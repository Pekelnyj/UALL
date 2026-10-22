# -*- coding: utf-8 -*-
"""Застосувати транслітераційні фікси прізвищ + ре-мердж у npcNames."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
master = json.loads((B / "data/_mob_master.json").read_text(encoding="utf-8-sig"))

fix = {}
for i in range(1, 6):
    f = B / f"data/_mob_tl_out_{i}.json"
    d = json.loads(f.read_text(encoding="utf-8-sig"))
    fix.update(d)

applied = 0
for en, ua in fix.items():
    if en in master and master[en] != ua:
        master[en] = ua
        applied += 1
(B / "data/_mob_master.json").write_text(json.dumps(master, ensure_ascii=False, indent=1), encoding="utf-8")

# ре-мердж у npcNames
TR = B / "data/translations.json"
tr = json.loads(TR.read_text(encoding="utf-8-sig"))
new = json.loads((B / "data/_live_new_npc.json").read_text(encoding="utf-8-sig"))  # id->en
npcN = tr["npcNames"]
upd = 0
for cid, en in new.items():
    ua = master.get(en)
    if ua and npcN.get(cid) != ua:
        npcN[cid] = ua
        upd += 1
TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Транслітераційних фіксів у мапі: {len(fix)} | застосовано до master: {applied} | оновлено npcNames: {upd}")
