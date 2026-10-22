# -*- coding: utf-8 -*-
"""Інкрементно оновити ua в editor.db з data/translations.json (майстер -> редактор).

Навіщо: коли майстер правили напряму (скриптами/агентами), робоча БД редактора
відстає. Цей скрипт підтягує свіже ua за стабільним ключем (section·item_key·field),
НЕ чіпаючи id/користувачів/історію. FTS оновлюється тригером автоматично.

Безпека: рядки, які вже редагували В САМОМУ редакторі (є в history) за замовчуванням
ПРОПУСКАЮТЬСЯ — щоб не затерти ще не вивантажену працю. --overwrite-edited вимикає це.

Запуск:
    python editor/sync_from_master.py            # підтягти майстер, зберегти правки редактора
    python editor/sync_from_master.py --dry       # лише показати, скільки зміниться
    python editor/sync_from_master.py --overwrite-edited   # затерти й відредаговані в редакторі
"""
import json
import sqlite3
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
TR = ROOT / "data" / "translations.json"
DB = HERE / "editor.db"


def master_value(tr, section, key, field):
    sect = tr.get(section)
    if not isinstance(sect, dict):
        return None
    entry = sect.get(key)
    if field == "":
        return entry if isinstance(entry, str) else None
    if isinstance(entry, dict):
        v = entry.get(field)
        return v if isinstance(v, str) else None
    return None


def main():
    if not DB.exists():
        raise SystemExit(f"Немає БД: {DB}")
    if not TR.exists():
        raise SystemExit(f"Немає майстра: {TR}")
    dry = "--dry" in sys.argv[1:]
    overwrite_edited = "--overwrite-edited" in sys.argv[1:]

    tr = json.loads(TR.read_text(encoding="utf-8-sig"))
    con = sqlite3.connect(DB)
    con.execute("PRAGMA busy_timeout=8000")

    # рядки, відредаговані в самому редакторі (бережемо, якщо не --overwrite-edited)
    edited = set()
    if not overwrite_edited:
        try:
            edited = {r[0] for r in con.execute("SELECT DISTINCT string_id FROM history")}
        except sqlite3.OperationalError:
            edited = set()
    print(f"Захищених (редаговані в редакторі): {len(edited)}")

    rows = con.execute("SELECT id,section,item_key,field,ua FROM strings").fetchall()
    changed = preserved = 0
    samples = []
    for sid, section, key, field, cur_ua in rows:
        if sid in edited:
            continue
        mv = master_value(tr, section, key, field or "")
        if mv is None or mv == (cur_ua or ""):
            continue
        if cur_ua not in (None, "") and len(samples) < 10:
            samples.append(f"{section}·{key}{('·'+field) if field else ''}: "
                           f"{_short(cur_ua)} -> {_short(mv)}")
        if not dry:
            con.execute("UPDATE strings SET ua=? WHERE id=?", (mv, sid))
        changed += 1
    if not dry:
        con.commit()
    con.close()

    print(f"{'Змінилося б' if dry else 'Оновлено'} ua: {changed}")
    if samples:
        print("Приклади:")
        for s in samples:
            print("  " + s)
    if dry:
        print("DRY — нічого не записано.")


def _short(s, n=44):
    s = str(s).replace("\n", "⏎")
    return s if len(s) <= n else s[:n] + "…"


if __name__ == "__main__":
    main()
