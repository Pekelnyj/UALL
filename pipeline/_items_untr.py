# -*- coding: utf-8 -*-
"""Скільки предметів-назв неперекладено по доповненнях + дамп для перекладу."""
import json
import csv
import sys
from collections import Counter, defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
csv.field_size_limit(10 ** 7)
B = Path("g:/Claude Code/WoWUkraine")
items = json.loads((B / "data/source/items.json").read_text(encoding="utf-8-sig"))
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
itemN = tr.get("itemNames", {})
itemF = tr.get("itemFlavors", {})

EXP = {"0": "Classic", "1": "TBC", "2": "Wrath", "3": "Cataclysm", "4": "MoP",
       "5": "WoD", "6": "Legion", "7": "BfA", "8": "Shadowlands", "9": "Dragonflight",
       "10": "WarWithin", "11": "Midnight"}
ORDER = ["Classic", "TBC", "Wrath", "Cataclysm", "MoP", "WoD", "Legion", "BfA",
         "Shadowlands", "Dragonflight", "WarWithin", "Midnight", "?"]

expmap = {}
csvp = B / "data/wago/ItemSparse.enUS.latest.csv"
if csvp.exists():
    with open(csvp, encoding="utf-8") as fh:
        for row in csv.DictReader(fh):
            expmap[row["ID"]] = row.get("ExpansionID")

untr_name = defaultdict(list)   # exp -> [(id, en)]
untr_flav = Counter()
for iid, e in items.items():
    en = (e.get("name") or {}).get("en")
    if not en:
        continue
    exp = EXP.get(expmap.get(iid, ""), "?")
    if en not in itemN:
        untr_name[exp].append((iid, en))
    fl = (e.get("flavor") or {}).get("en")
    if fl and fl not in itemF:
        untr_flav[exp] += 1

print(f"{'Доповнення':<13}{'неперекл. назв':>16}{'неперекл. флейвор':>18}")
print("-" * 47)
tot_n = tot_f = 0
for exp in ORDER:
    n = len(untr_name.get(exp, []))
    f = untr_flav.get(exp, 0)
    tot_n += n; tot_f += f
    if n or f:
        print(f"{exp:<13}{n:>16,}{f:>18,}")
print("-" * 47)
print(f"{'РАЗОМ':<13}{tot_n:>16,}{tot_f:>18,}")

# дамп Classic-назв (унікальні EN) для першої хвилі
classic = sorted({en for _, en in untr_name.get("Classic", [])})
(B / "data/_items_classic.json").write_text(json.dumps(classic, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"\nClassic унікальних назв -> data/_items_classic.json: {len(classic)}")
