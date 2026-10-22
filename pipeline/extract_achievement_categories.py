# -*- coding: utf-8 -*-
"""Категорії вікна досягнень (лівий список: «Argent Tournament», «Torghast»…).

ЧОМУ ОКРЕМА СЕКЦІЯ. Досі ці назви жили в жорсткому списку UI_CHROME всередині
AchievementHooks.lua (≈18 рядків), тому головні категорії були українською, а
підкатегорії — англійською. Переклади для більшості з них у базі Є, але розкидані
по questObjectives/uiMisc/globalStrings, куди вікно досягнень не заглядає.

Тут збираємо ЄДИНИЙ авторитетний словник:
  data/translations.json → "achievementCategories" = {EN: UA}
Джерело назв — DB2 Achievement_Category; UA підтягуємо з наявних секцій
(пріоритет: uiMisc → globalStrings → uiStrings → questObjectives → journalSections),
решту лишаємо порожніми — на переклад.

Запуск із папки pipeline/:  python extract_achievement_categories.py [--write]
"""
import csv, json, os, sys, re
sys.stdout.reconfigure(encoding="utf-8")
csv.field_size_limit(10 ** 7)
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
WRITE = "--write" in sys.argv
CYR = re.compile("[а-яіїєґ]", re.I)

TR_PATH = os.path.join(ROOT, "data", "translations.json")
tr = json.load(open(TR_PATH, encoding="utf-8-sig"))

# порядок = пріоритет джерела перекладу
PREFER = ["uiMisc", "globalStrings", "uiStrings", "questObjectives",
          "journalSections", "gossip", "scenario"]

def lookup(en):
    for sec in PREFER:
        d = tr.get(sec)
        if isinstance(d, dict):
            v = d.get(en)
            v = v.get("name") if isinstance(v, dict) else v
            if isinstance(v, str) and v.strip() and CYR.search(v):
                return v, sec
    return None, None

path = os.path.join(ROOT, "data", "wago", "Achievement_Category.enUS.latest.csv")
names = []
with open(path, encoding="utf-8") as f:
    r = csv.DictReader(f)
    nc = next(c for c in r.fieldnames if c.lower().startswith("name"))
    for row in r:
        n = (row.get(nc) or "").strip()
        if n and n not in names:
            names.append(n)

sec = tr.setdefault("achievementCategories", {})
filled = missing = kept = 0
src_stat = {}
for en in names:
    if isinstance(sec.get(en), str) and CYR.search(sec[en]):
        kept += 1; continue                      # уже перекладено раніше — не чіпаємо
    ua, src = lookup(en)
    if ua:
        sec[en] = ua; filled += 1
        src_stat[src] = src_stat.get(src, 0) + 1
    else:
        sec.setdefault(en, "")
        missing += 1

print("=== КАТЕГОРІЇ ДОСЯГНЕНЬ ===")
print(f"  унікальних назв у DB2: {len(names)}")
print(f"  уже було в секції:     {kept}")
print(f"  підтягнуто з бази:     {filled}   {src_stat}")
print(f"  БЕЗ перекладу:         {missing}")
if WRITE:
    json.dump(tr, open(TR_PATH, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    print(f"  → записано, у секції тепер {len(sec)}")
else:
    print("  (без --write нічого не змінено)")
