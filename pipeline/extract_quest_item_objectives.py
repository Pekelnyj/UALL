# -*- coding: utf-8 -*-
"""Цілі-ПРЕДМЕТИ квестів: «1/1 <Назва предмета>» у вікні квесту/трекері.

Клієнт будує такий рядок РАНТАЙМ із назви предмета, тож у questObjectives його
нема — і ціль лишалась англійською, хоча сам предмет давно перекладено
(секція itemNames). Беремо з DB2 QuestObjective (Type=1 → ObjectID = itemID),
резолвимо EN-назву через ItemSparse і кладемо questObjectives[EN] = UA з itemNames.

Запуск із папки pipeline/:  python extract_quest_item_objectives.py [--write]
Без --write лише показує, скільки додалося б.
"""
import csv, json, os, sys
sys.stdout.reconfigure(encoding="utf-8")
csv.field_size_limit(10 ** 7)
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
W = os.path.join(ROOT, "data", "wago")
WRITE = "--write" in sys.argv

TR_PATH = os.path.join(ROOT, "data", "translations.json")
tr = json.load(open(TR_PATH, encoding="utf-8-sig"))
item_names = tr.get("itemNames", {})
qobj = tr.setdefault("questObjectives", {})

def uaname(v):
    return (v.get("name") if isinstance(v, dict) else v) if v else None

# 1) itemID → EN-назва (ItemSparse.Display_lang)
id2en = {}
with open(os.path.join(W, "ItemSparse.enUS.latest.csv"), encoding="utf-8") as f:
    r = csv.DictReader(f)
    idc = next(c for c in r.fieldnames if c.lower() in ("id", "_id"))
    namec = next(c for c in r.fieldnames if c.lower().startswith("display_lang"))
    for row in r:
        n = (row.get(namec) or "").strip()
        if n:
            id2en[(row.get(idc) or "").strip()] = n

# 2) QuestObjective: Type=1 → предмет
ITEM_TYPE = "1"
added, no_en, no_ua, total = 0, 0, 0, 0
with open(os.path.join(W, "QuestObjective.enUS.latest.csv"), encoding="utf-8") as f:
    r = csv.DictReader(f)
    for row in r:
        if (row.get("Type") or "").strip() != ITEM_TYPE:
            continue
        total += 1
        en = id2en.get((row.get("ObjectID") or "").strip())
        if not en:
            no_en += 1; continue
        ua = uaname(item_names.get(en))
        if not ua or ua == en:
            no_ua += 1; continue
        if qobj.get(en) != ua:
            qobj[en] = ua
            added += 1

print("=== ЦІЛІ-ПРЕДМЕТИ КВЕСТІВ (DB2 QuestObjective Type=1) ===")
print(f"  предметних цілей у DB2: {total}")
print(f"  без EN-назви (нема в ItemSparse): {no_en}")
print(f"  без укр. назви (предмет не перекладено): {no_ua}")
print(f"  {'ДОДАНО' if WRITE else 'ДОДАЛОСЬ БИ'} у questObjectives: {added}")

if WRITE:
    json.dump(tr, open(TR_PATH, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    print(f"  questObjectives тепер: {len(qobj)}")
else:
    print("  (запуск без --write — нічого не змінено)")
