# -*- coding: utf-8 -*-
"""Витяг НОВОГО db.broadcast із ЖИВОГО SavedVariables (свіже з гри), дедуп проти
translations.broadcast. Бо гравець ловить новий broadcast під час гри після екстракції."""
import sys, re, json, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

sv = open(glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0],
          encoding="utf-8", errors="replace").read()
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
g = tr.get("broadcast", {})

m = re.search(r'\["broadcast"\]\s*=\s*\{', sv)
i, depth, start = m.end(), 1, m.end()
instr = esc = False
while i < len(sv) and depth > 0:
    c = sv[i]
    if instr:
        if esc: esc = False
        elif c == "\\": esc = True
        elif c == '"': instr = False
    else:
        if c == '"': instr = True
        elif c == "{": depth += 1
        elif c == "}": depth -= 1
    i += 1
block = sv[start:i - 1]
keys = re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=', block)


def un(s):
    return (s.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r")
             .replace("\\t", "\t").replace("\\\\", "\\"))


new = []
for k in keys:
    s = un(k)
    if s and s not in g and re.search(r"[A-Za-z]{3}", s):
        new.append(s)
new = sorted(set(new))
json.dump(new, open(DATA_DIR / "tester_all" / "broadcast_live.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
print(f"НОВОГО broadcast у живому SV (не перекладено): {len(new)}")
for s in new[:6]:
    print("   ", repr(s[:70]))
