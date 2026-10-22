# -*- coding: utf-8 -*-
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
npcN = tr["npcNames"]
LIVE = Path("F:/Battlenet/World of Warcraft/_retail_/WTF/Account/129089678#1/SavedVariables/WoWUkraine.lua")
s = LIVE.read_text(encoding="utf-8", errors="replace")


def block(key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
    i, depth, instr, esc = m.end(), 1, False, False
    while i < len(s) and depth > 0:
        c = s[i]
        if instr:
            if esc: esc = False
            elif c == "\\": esc = True
            elif c == '"': instr = False
        else:
            if c == '"': instr = True
            elif c == "{": depth += 1
            elif c == "}": depth -= 1
        i += 1
    return s[m.end():i - 1]


# нові моби
nb = block("npc")
pairs = re.findall(r'\["(\d+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', nb)
new = {iid: nm for iid, nm in pairs if iid not in npcN}
(B / "data/_new48_ids.json").write_text(json.dumps(new, ensure_ascii=False, indent=1), encoding="utf-8")

# якір: існуючі EN->UA зі спільним першим словом
src = {}
for f in ["creatures.json", "api_creatures_full.json"]:
    d = json.loads((B / "data/source" / f).read_text(encoding="utf-8-sig"))
    for k, v in d.items():
        if isinstance(v, dict) and v.get("name", {}).get("en"):
            src.setdefault(v["name"]["en"], k)
fw = defaultdict(dict)
for en, cid in src.items():
    if cid in npcN and en.split():
        fw[en.split()[0].lower()][en] = npcN[cid]
ref = {}
for nm in new.values():
    if nm.split():
        for en, ua in list(fw.get(nm.split()[0].lower(), {}).items())[:3]:
            ref[en] = ua
out = {"names": sorted(set(new.values())), "reference_existing": ref}
(B / "data/_fin_in/mob48.json").write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"нових мобів: {len(set(new.values()))} -> mob48.json")

# 13 субтитрів
btr = tr.get("broadcast", {})
def cyr(x): return bool(re.search(r"[А-Яа-яІЇЄҐ]", x))
subs = sorted({k for k in re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=', block("broadcast"))
               if k not in btr and len(k) > 3 and not cyr(k)})
(B / "data/_fin_in/subs13.json").write_text(json.dumps(subs, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"нових субтитрів: {len(subs)} -> subs13.json")
