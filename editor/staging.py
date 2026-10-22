# -*- coding: utf-8 -*-
"""Безпечна доставка нової бази: додати пакет у КОПІЮ живої editor.db, перевірити,
атомарно підмінити. Стара БД лишається в backups/ на 24 год (на відкат), потім видаляється.

Праця спільноти (правки/історія/пропозиції/глосарій/користувачі) переноситься, бо
кандидат — це копія живої БД + лише ДОДАНІ нові рядки (merge_rows нічого не затирає).
"""
import os
import shutil
import sqlite3
import time
from pathlib import Path

from update_db import merge_rows, package_rows

HERE = Path(__file__).resolve().parent
DB = HERE / "editor.db"
BACKUPS = HERE / "backups"
RETENTION = 24 * 3600  # тримати стару БД 24 год

REQUIRED_TABLES = ("strings", "strings_fts", "users", "history", "suggestions", "glossary")


def _count(con, t):
    return con.execute(f"SELECT COUNT(*) FROM {t}").fetchone()[0]


def _replace(src, dst, tries=12):
    """os.replace зі стійкістю до короткочасних блокувань файлу (Windows)."""
    for i in range(tries):
        try:
            os.replace(src, dst); return
        except PermissionError:
            if i == tries - 1:
                raise
            time.sleep(0.15)


def validate_db(path, min_strings):
    """Чи БД-кандидат робоча. Повертає (ok, problems[])."""
    problems = []
    try:
        con = sqlite3.connect(f"file:{path}?mode=ro", uri=True)
    except Exception as e:
        return False, [f"не відкривається: {e}"]
    try:
        if con.execute("PRAGMA integrity_check").fetchone()[0] != "ok":
            problems.append("integrity_check != ok")
        names = {r[0] for r in con.execute("SELECT name FROM sqlite_master WHERE type IN ('table','view')")}
        for t in REQUIRED_TABLES:
            if t not in names:
                problems.append(f"немає таблиці {t}")
        try:
            sc = _count(con, "strings")
            if sc < min_strings:
                problems.append(f"рядків поменшало: {sc} < {min_strings} (база має лише рости)")
        except Exception as e:
            problems.append(f"strings нечитабельні: {e}")
        try:
            if _count(con, "users") < 1:
                problems.append("втрачено користувачів")
        except Exception:
            problems.append("users нечитабельні")
        try:
            con.execute("SELECT rowid FROM strings_fts LIMIT 1").fetchone()
        except Exception as e:
            problems.append(f"FTS-пошук зламано: {e}")
    finally:
        con.close()
    return (len(problems) == 0), problems


def _backup_ts(p):
    try:
        return int(p.stem.split("-", 1)[1])
    except Exception:
        return None


def list_backups(now=None):
    now = int(now if now is not None else time.time())
    BACKUPS.mkdir(exist_ok=True)
    out = []
    for p in sorted(BACKUPS.glob("editor-*.db"), reverse=True):
        ts = _backup_ts(p)
        if ts is None:
            continue
        out.append({"name": p.name, "ts": ts, "age_h": round((now - ts) / 3600, 1),
                    "expired": (now - ts) > RETENTION, "size_mb": round(p.stat().st_size / 1024 / 1024, 1)})
    return out


def _cleanup_old(now):
    removed = 0
    for b in list_backups(now):
        if b["expired"]:
            try:
                (BACKUPS / b["name"]).unlink(); removed += 1
            except Exception:
                pass
    return removed


def stage_and_swap(package_path, note="", refresh_en=False, now=None):
    """Долити пакет у копію живої БД, перевірити, підмінити. Стара -> backups/ на відкат."""
    now = int(now if now is not None else time.time())
    BACKUPS.mkdir(exist_ok=True)
    candidate = HERE / "editor.candidate.db"
    if candidate.exists():
        candidate.unlink()

    live = sqlite3.connect(f"file:{DB}?mode=ro", uri=True)
    base_strings = _count(live, "strings")
    live.close()

    shutil.copy2(DB, candidate)                       # 1) копія живої БД (з усією працею спільноти)
    con = sqlite3.connect(candidate)                  # 2) долити нові рядки в кандидата
    con.execute("PRAGMA busy_timeout=8000")
    con.execute("""CREATE TABLE IF NOT EXISTS base_updates(
        id INTEGER PRIMARY KEY, ts REAL, added INTEGER, refreshed INTEGER, note TEXT DEFAULT '')""")
    added, refreshed, _ = merge_rows(con, package_rows(package_path), refresh_en=refresh_en, dry=False)
    con.execute("INSERT INTO base_updates(ts,added,refreshed,note) VALUES(?,?,?,?)",
                (now, added, refreshed, note or "upload"))
    con.commit(); con.close()

    ok, problems = validate_db(candidate, base_strings)   # 3) перевірка
    if not ok:
        try:
            candidate.unlink()
        except Exception:
            pass
        return {"ok": False, "problems": problems}

    backup = BACKUPS / f"editor-{now}.db"             # 4) атомарна підміна
    _replace(DB, backup)                              #    жива -> backup (на 24 год)
    _replace(candidate, DB)                           #    кандидат -> жива
    removed = _cleanup_old(now)
    return {"ok": True, "added": added, "refreshed": refreshed, "backup": backup.name,
            "rollback_until": now + RETENTION, "old_backups_removed": removed}


def rollback(now=None):
    """Відкотитися до найсвіжішого бекапа в межах 24 год."""
    now = int(now if now is not None else time.time())
    fresh = [b for b in list_backups(now) if not b["expired"]]
    if not fresh:
        return {"ok": False, "error": "немає бекапа в межах 24 год"}
    latest = fresh[0]
    src = BACKUPS / latest["name"]
    _replace(DB, BACKUPS / f"editor-{now}.db")        # поточну зберегти (раптом відкат помилковий)
    shutil.copy2(src, DB)                             # відновити стару
    return {"ok": True, "restored": latest["name"], "restored_age_h": latest["age_h"]}
