# -*- coding: utf-8 -*-
"""Вивантажити розбіжності компонентів мобів + еталон існуючої бази для нормалізації."""
import json
import sys
from collections import defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
en2ua = json.loads((B / "data/_mob_master.json").read_text(encoding="utf-8-sig"))
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
npcN = tr.get("npcNames", {})
src = {}
for f in ["creatures.json", "api_creatures_full.json"]:
    d = json.loads((B / "data/source" / f).read_text(encoding="utf-8-sig"))
    for k, v in d.items():
        if isinstance(v, dict) and v.get("name", {}).get("en"):
            src.setdefault(v["name"]["en"], k)
# існуючий EN->UA з бази
exist = {}
for en, cid in src.items():
    if cid in npcN:
        exist[en] = npcN[cid]

comp = defaultdict(list)
for en, ua in en2ua.items():
    ws = en.split()
    if len(ws) >= 2:
        comp[ws[-1]].append((en, ua))

groups = []
for w, items in sorted(comp.items()):
    if len(items) < 2:
        continue
    last_ua = set()
    for en, ua in items:
        uw = ua.split()
        if uw:
            last_ua.add(uw[-1].lower())
    roots = set(u[:5] for u in last_ua)
    if len(roots) > 1:
        # еталон бази для цього компонента
        ref = {en: exist[en] for en in exist if en.split() and en.split()[-1] == w}
        groups.append({"component": w, "entries": dict(items),
                       "base_reference": dict(list(ref.items())[:5])})

(B / "data/_mob_divergences.json").write_text(json.dumps(groups, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Груп-розбіжностей: {len(groups)} -> data/_mob_divergences.json")
print(f"Записів усього в них: {sum(len(g['entries']) for g in groups)}")
print("Груп з еталоном бази:", sum(1 for g in groups if g["base_reference"]))
