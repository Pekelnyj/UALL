# -*- coding: utf-8 -*-
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
npcN = tr["npcNames"]
s = Path("F:/Battlenet/World of Warcraft/_retail_/WTF/Account/129089678#1/SavedVariables/WoWUkraine.lua").read_text(encoding="utf-8", errors="replace")
m = re.search(r'\["npc"\]\s*=\s*\{', s)
i, depth, instr, esc = m.end(), 1, False, False
while i < len(s) and depth > 0:
    c = s[i]
    if instr:
        if esc:
            esc = False
        elif c == "\\":
            esc = True
        elif c == '"':
            instr = False
    else:
        if c == '"':
            instr = True
        elif c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
    i += 1
nb = s[m.end():i - 1]
pairs = re.findall(r'\["(\d+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', nb)
new = [(iid, nm) for iid, nm in pairs if iid not in npcN]
print(f"npc IDs у зборі: {len(pairs)} | НЕперекладених (по ID): {len(new)}")
for iid, nm in new[:12]:
    print(f"   {iid} -> {nm}")
# субтитри-залишок (13)
btr = tr.get("broadcast", {})
print(f"\nbroadcast у tr: {len(btr)}")
