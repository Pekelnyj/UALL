# -*- coding: utf-8 -*-
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
gtr = tr.get("gossip", {})
s = Path("F:/Battlenet/World of Warcraft/_retail_/WTF/Account/129089678#1/SavedVariables/WoWUkraine.lua").read_text(encoding="utf-8", errors="replace")


def block(key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
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
    return s[m.end():i - 1]


KV = re.compile(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"')
gb = block("gossip")
new = []
for k, v in KV.findall(gb):
    if k in gtr:
        continue
    if re.search(r"[А-Яа-яІЇЄҐ]", k):
        continue
    if " " in k and len(k) > 12:
        new.append(k)
new = sorted(set(new))
(B / "data/_fin_in/gossip.json").write_text(json.dumps(new, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"gossip нових (речення): {len(new)} -> gossip.json")
for g in new[:5]:
    print("   •", g[:75])
