# -*- coding: utf-8 -*-
"""Безвтратно оновити EN(+DE/FR) оригінал у editor.db для ID-секцій із data/source/*.

Навіщо: повний import_db.py перезаписує id рядків і знищив би користувачів/правки.
Цей скрипт лише робить UPDATE strings.en/de/fr там, де оригіналу бракує (або --all —
скрізь), за стабільним ключем (section·item_key·field). id/ua/історія не чіпаються.
FTS синхронізується тригером strings_fts_au (створює app.py) автоматично.

Покриває: achievements, quests, npcNames, spells.

Запуск:
    python editor/enrich_en.py          # заповнити лише порожні en
    python editor/enrich_en.py --all    # перезаписати en/de/fr скрізь
"""
import json
import sqlite3
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
SRC = ROOT / "data" / "source"
DB = HERE / "editor.db"


def load(p):
    return json.loads(Path(p).read_text(encoding="utf-8-sig")) if Path(p).exists() else {}


ach = load(SRC / "achievements.json")     # {id:{title:{en,de,fr},desc:{en,de,fr}}}
quests = load(SRC / "quests.json")         # {id:{title:{...},description:{...}}}
creatures = load(SRC / "creatures.json")   # {id:{name:{en,de,fr}}}
spells = load(SRC / "spells.json")         # {id:{name:{en,de,fr},...}}


def src(section, key, field):
    if section == "achievements":
        f = (ach.get(str(key)) or {}).get("title" if field == "title" else "desc")
        if isinstance(f, dict):
            return f.get("en", ""), f.get("de", ""), f.get("fr", "")
    elif section == "quests":
        q = quests.get(str(key)) or {}
        f = q.get("title" if field == "title" else "description" if field == "description" else field)
        if isinstance(f, dict):
            return f.get("en", ""), f.get("de", ""), f.get("fr", "")
    elif section == "npcNames":
        n = (creatures.get(str(key)) or {}).get("name") or {}
        return n.get("en", ""), n.get("de", ""), n.get("fr", "")
    elif section == "spells":
        n = (spells.get(str(key)) or {}).get("name") or {}
        if isinstance(n, dict):
            return n.get("en", ""), n.get("de", ""), n.get("fr", "")
    return "", "", ""


def main():
    if not DB.exists():
        raise SystemExit(f"Немає БД: {DB}")
    all_rows = "--all" in sys.argv[1:]
    con = sqlite3.connect(DB)
    con.execute("PRAGMA busy_timeout=8000")  # пережити короткі блокування від сервера
    where = "section IN ('achievements','quests','npcNames','spells')"
    if not all_rows:
        where += " AND (en IS NULL OR en='')"
    rows = con.execute(f"SELECT id,section,item_key,field FROM strings WHERE {where}").fetchall()
    print(f"Кандидатів: {len(rows)} ({'усі' if all_rows else 'лише порожні en'})")

    upd = 0
    by_sect = {}
    for sid, section, key, field in rows:
        en, de, fr = src(section, key, field or "")
        if not en:
            continue
        con.execute("UPDATE strings SET en=?,de=?,fr=? WHERE id=?", (en, de, fr, sid))
        upd += 1
        by_sect[section] = by_sect.get(section, 0) + 1
    con.commit()
    con.close()

    print(f"Оновлено EN: {upd}")
    for s, c in sorted(by_sect.items(), key=lambda x: -x[1]):
        print(f"  {s}: {c}")


if __name__ == "__main__":
    main()
