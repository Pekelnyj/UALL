# -*- coding: utf-8 -*-
"""Перебудувати EN->UA з АКТУАЛЬНОГО npcNames + скан розбіжностей компонентів."""
import json
import sys
from collections import defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
npcN = tr["npcNames"]
new = json.loads((B / "data/_live_new_npc.json").read_text(encoding="utf-8-sig"))  # id->en

# актуальний EN->UA з npcNames
en2ua = {}
for cid, en in new.items():
    if cid in npcN:
        en2ua.setdefault(en, npcN[cid])
(B / "data/_mob_master.json").write_text(json.dumps(en2ua, ensure_ascii=False, indent=1), encoding="utf-8")

comp = defaultdict(list)
for en, ua in en2ua.items():
    ws = en.split()
    if len(ws) >= 2:
        comp[ws[-1]].append((en, ua))

flag = 0
examples = []
for w, items in sorted(comp.items()):
    if len(items) < 2:
        continue
    last_ua = set(u.split()[-1].lower() for en, u in items if u.split())
    roots = set(u[:5] for u in last_ua)
    if len(roots) > 1:
        flag += 1
        if len(examples) < 20:
            examples.append(f"[{w}] " + " | ".join(f"{en}→{ua}" for en, ua in items[:3]))

print(f"Унікальних: {len(en2ua)} | підозрілих компонентів-розбіжностей: {flag}")
print("--- залишкові приклади ---")
for e in examples:
    print(" ", e)
