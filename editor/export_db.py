# -*- coding: utf-8 -*-
"""Експорт відредагованих перекладів із SQLite (editor.db) назад у майстер.

Реверс import_db.py: бере UA з таблиці `strings` й кладе його в
`data/translations.json`, зберігаючи решту структури. en/de/fr у майстрі
НЕ зберігаються — тут їх не чіпаємо й не додаємо.

Розкладка (точний реверс імпорту):
  • field == ""   ->  tr[section][item_key] = ua
        (EN-ключ: broadcast, gossip, descTemplates, questObjectives, itemNames,
         itemFlavors, globalStrings, journalSections, uiTooltips, instanceDesc,
         profDesc, gameTips, bookTexts, subnames;
         ID-ключ: spells, npcNames, itemSets)
  • field != ""   ->  tr[section][item_key][field] = ua
        (dict-секції: quests, achievements, currencies, affixes, titles, recipes,
         journal, factions, journal_instances, minimap, pets, mounts; professions).
  item_key й field беремо з рядка БД як є (digit/EN-розбіжність уже враховано на імпорті).

Запуск:
    python editor/export_db.py            # лише записати translations.json
    python editor/export_db.py --build    # + запустити pipeline/generate_db.py
"""
import json
import sqlite3
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
DATA = ROOT / "data"
DB = HERE / "editor.db"
TRANSLATIONS = DATA / "translations.json"


def main():
    if not DB.exists():
        raise SystemExit(f"Немає БД: {DB} — спершу: python editor/import_db.py")
    if not TRANSLATIONS.exists():
        raise SystemExit(f"Немає майстра: {TRANSLATIONS}")

    # 1. Майстер (UTF-8-sig, як у import_db.py).
    tr = json.loads(TRANSLATIONS.read_text(encoding="utf-8-sig"))

    # 2. Перебір усіх рядків БД -> запис ua назад у tr.
    con = sqlite3.connect(DB)
    cur = con.execute("SELECT section, item_key, field, ua FROM strings")

    updated = 0   # записано непорожніх ua
    skipped = 0   # пропущено порожніх/None
    bad = 0       # конфлікт структури (item_key мав бути dict, але є рядок)

    for section, item_key, field, ua in cur:
        if ua is None or ua == "":
            skipped += 1
            continue

        sect = tr.setdefault(section, {})

        if field == "":
            # EN- або ID-ключ із рядковим значенням.
            sect[item_key] = ua
        else:
            # dict-секція: гарантуємо, що значення під ключем — dict.
            entry = sect.get(item_key)
            if not isinstance(entry, dict):
                if entry is not None:
                    # Існувало нерозбірне значення (несумісна структура) — не псуємо.
                    bad += 1
                    continue
                entry = {}
                sect[item_key] = entry
            entry[field] = ua

        updated += 1

    con.close()

    # 3. Записати майстер назад (ensure_ascii=False, indent=1) — як у пайплайні.
    TRANSLATIONS.write_text(
        json.dumps(tr, ensure_ascii=False, indent=1),
        encoding="utf-8",
    )

    # 4. Звіт.
    print(f"Оновлено рядків: {updated}")
    print(f"Пропущено (порожніх): {skipped}")
    if bad:
        print(f"Пропущено (несумісна структура): {bad}")
    print(f"-> {TRANSLATIONS}")

    # 5. --build: зібрати Database/*.lua.
    if "--build" in sys.argv[1:]:
        pipeline = ROOT / "pipeline"
        print("\n== generate_db.py ==")
        res = subprocess.run(
            [sys.executable, "generate_db.py"],
            cwd=pipeline,
        )
        if res.returncode != 0:
            raise SystemExit(f"generate_db.py завершився з кодом {res.returncode}")
    else:
        print("\nдалі: python pipeline/generate_db.py")


if __name__ == "__main__":
    main()
