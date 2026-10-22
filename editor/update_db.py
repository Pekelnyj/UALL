# -*- coding: utf-8 -*-
"""Інкрементно ДОДАТИ нові рядки бази в editor.db, НЕ чіпаючи правки/історію/користувачів.

Джерело рядків — або локальні файли (translations.json + source/*), або готовий
самодостатній «пакет бази» (build_base_package.py) — щоб на сервері не тримати
великі вихідні файли.

  • ДОДАЄ нові (section·item_key·field), яких ще немає; наявні рядки НЕ чіпає
    (виняток: --refresh-en оновлює лише en/de/fr оригіналу);
  • веде журнал поповнень (таблиця base_updates).
FTS: нові рядки одразу в індекс; оновлення en синхронізує тригер.

Запуск:
    python editor/update_db.py                          # з локальних translations.json + source/*
    python editor/update_db.py --from-package base.jsonl[.gz]   # з пакета (на сервері)
    python editor/update_db.py ... --dry                # лише порахувати
    python editor/update_db.py ... --refresh-en         # + оновити en/de/fr наявних
    python editor/update_db.py ... --note "патч 11.2"   # підпис у журналі
"""
import gzip
import json
import sqlite3
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from import_db import load, load_sources, iter_rows, DATA, DB

sys.stdout.reconfigure(encoding="utf-8")


def _short(s, n=46):
    if not s:
        return ""
    s = str(s).replace("\n", "⏎")
    return s if len(s) <= n else s[:n] + "…"


def package_rows(path):
    """Читає пакет бази (JSONL, .gz-aware): yield (section,key,field,en,de,fr,ua)."""
    opener = gzip.open if str(path).endswith(".gz") else open
    with opener(path, "rt", encoding="utf-8") as fh:
        for line in fh:
            line = line.strip()
            if not line:
                continue
            o = json.loads(line)
            if "_meta" in o:          # службовий заголовок
                continue
            yield (o["s"], o["k"], o.get("f", ""), o.get("en", ""),
                   o.get("de", ""), o.get("fr", ""), o.get("ua", ""))


def merge_rows(con, rows, refresh_en=False, dry=False):
    """Додає відсутні рядки; наявні не чіпає (крім --refresh-en). Повертає (added, refreshed, samples)."""
    existing = {(r[0], r[1], r[2]) for r in con.execute("SELECT section,item_key,field FROM strings")}
    has_fts = con.execute("SELECT name FROM sqlite_master WHERE name='strings_fts'").fetchone() is not None
    added = refreshed = 0
    samples = []
    for section, key, field, en, de, fr, ua in rows:
        k = (section, key, field)
        if k not in existing:
            if not dry:
                cur = con.execute(
                    "INSERT OR IGNORE INTO strings(section,item_key,field,en,de,fr,ua) VALUES(?,?,?,?,?,?,?)",
                    (section, key, field, en, de, fr, ua))
                if cur.lastrowid and has_fts:
                    con.execute("INSERT INTO strings_fts(rowid,en,ua) VALUES(?,?,?)", (cur.lastrowid, en, ua))
            existing.add(k)
            added += 1
            if len(samples) < 10:
                samples.append(f"+ {section}·{key}{('·'+field) if field else ''}: {_short(ua) or _short(en)}")
        elif refresh_en and en and not dry:
            cur = con.execute(
                "UPDATE strings SET en=?,de=?,fr=? WHERE section=? AND item_key=? AND field=? "
                "AND (en IS NOT ? OR de IS NOT ? OR fr IS NOT ?)",
                (en, de, fr, section, key, field, en, de, fr))
            refreshed += cur.rowcount
    return added, refreshed, samples


def main():
    argv = sys.argv[1:]
    dry = "--dry" in argv
    refresh_en = "--refresh-en" in argv
    pkg = None
    note = ""
    if "--from-package" in argv:
        i = argv.index("--from-package")
        if i + 1 < len(argv):
            pkg = argv[i + 1]
    if "--note" in argv:
        i = argv.index("--note")
        if i + 1 < len(argv):
            note = argv[i + 1]

    if not DB.exists():
        raise SystemExit(f"Немає БД: {DB} — спершу: python editor/import_db.py")

    if pkg:
        if not Path(pkg).exists():
            raise SystemExit(f"Немає пакета: {pkg}")
        rows = package_rows(pkg)
        src_desc = f"пакет {Path(pkg).name}"
    else:
        rows = iter_rows(load(DATA / "translations.json"), load_sources())
        src_desc = "translations.json + source/*"

    con = sqlite3.connect(DB)
    con.execute("PRAGMA busy_timeout=8000")
    con.execute("""CREATE TABLE IF NOT EXISTS base_updates(
        id INTEGER PRIMARY KEY, ts REAL, added INTEGER, refreshed INTEGER, note TEXT DEFAULT '')""")

    added, refreshed, samples = merge_rows(con, rows, refresh_en=refresh_en, dry=dry)

    if not dry:
        con.execute("INSERT INTO base_updates(ts,added,refreshed,note) VALUES(?,?,?,?)",
                    (time.time(), added, refreshed, note or src_desc))
        con.commit()
    con.close()

    tail = f" | оновлено оригінал: {refreshed}" if refresh_en else ""
    print(f"Джерело: {src_desc}")
    print(f"Нових рядків {'(порахунок)' if dry else 'додано'}: {added}{tail}")
    for s in samples:
        print("  " + s)
    if dry:
        print("DRY — нічого не записано.")
    else:
        print(f"журнал base_updates += 1{(' («' + note + '»)') if note else ''}")


if __name__ == "__main__":
    main()
