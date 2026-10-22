# -*- coding: utf-8 -*-
"""Застосувати фікс-мапу консистентності + змерджити мобів у npcNames + captured_creatures."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
TR = B / "data/translations.json"
new = json.loads((B / "data/_live_new_npc.json").read_text(encoding="utf-8-sig"))  # id->en (2311)
en2ua = json.loads((B / "data/_mob_master.json").read_text(encoding="utf-8-sig"))
fix = json.loads((B / "data/_mob_fixmap.json").read_text(encoding="utf-8-sig"))

# 1) застосувати фікс-мапу
for en, ua in fix.items():
    if en in en2ua:
        en2ua[en] = ua
(B / "data/_mob_master.json").write_text(json.dumps(en2ua, ensure_ascii=False, indent=1), encoding="utf-8")

# 2) мердж у npcNames (id->ua)
tr = json.loads(TR.read_text(encoding="utf-8-sig"))
npcN = tr.setdefault("npcNames", {})
merged = 0
for cid, en in new.items():
    ua = en2ua.get(en)
    if ua:
        npcN[cid] = ua
        merged += 1
TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")

# 3) captured_creatures.json (id->en) — щоб пайплайн знав про нові
cc_path = B / "data/source/captured_creatures.json"
cc = json.loads(cc_path.read_text(encoding="utf-8-sig")) if cc_path.exists() else {}
added = 0
for cid, en in new.items():
    if cid not in cc:
        cc[cid] = en
        added += 1
cc_path.write_text(json.dumps(cc, ensure_ascii=False, indent=1), encoding="utf-8")

print(f"Фікс-мапу застосовано: {len(fix)} записів")
print(f"Змерджено в npcNames: {merged} (тепер {len(npcN):,})")
print(f"Додано в captured_creatures: {added} (тепер {len(cc):,})")
