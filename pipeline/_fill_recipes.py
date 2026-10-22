# -*- coding: utf-8 -*-
"""Авто-заповнення рецептів з уже перекладених заклять/предметів (консистентно, без Max).
Пріоритет: spellID (рецепт=крафт-закляття) > itemNames(EN-назва) > spell-назва."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
BASE = Path("g:/Claude Code/WoWUkraine")
TR = BASE / "data/translations.json"

tr = json.loads(TR.read_text(encoding="utf-8-sig"))
rc = json.loads((BASE / "data/source/api_recipes.json").read_text(encoding="utf-8-sig"))
sp = json.loads((BASE / "data/source/spells.json").read_text(encoding="utf-8-sig"))

rct = tr.setdefault("recipes", {})
itemN = tr.get("itemNames", {})           # EN-назва -> UA
spU = tr.get("spells", {})                # spellID -> UA
spEN = {v["name"]["en"]: spU[k] for k, v in sp.items()
        if k in spU and v.get("name", {}).get("en")}  # EN -> UA

filled = {"spellid": 0, "item": 0, "spellname": 0}
left = []
for k in rc:
    if k in rct:
        continue
    en = rc[k].get("name", {}).get("en", "")
    ua = None
    if k in spU:
        ua = spU[k]; filled["spellid"] += 1
    elif en in itemN:
        ua = itemN[en]; filled["item"] += 1
    elif en in spEN:
        ua = spEN[en]; filled["spellname"] += 1
    else:
        left.append(k); continue
    rct[k] = {"name": ua}

TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Заповнено: spellID={filled['spellid']}, items={filled['item']}, spellName={filled['spellname']}")
print(f"Рецептів усього в майстрі: {len(rct):,} | лишилось вручну: {len(left):,}")
