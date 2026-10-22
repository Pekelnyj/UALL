# -*- coding: utf-8 -*-
"""Категоризація db.ejmiss (журнал показав-але-не-переклав) з живого SavedVariables."""
import sys, re, json, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

sv = open(glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0],
          encoding="utf-8", errors="replace").read()
m = re.search(r'\["ejmiss"\]\s*=\s*\{', sv)
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
keys = [k for k in re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=', block)]


def un(s):
    return s.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r").replace("\\\\", "\\")


cats = {"item": [], "generic": [], "ability/lore": [], "short": []}
for k in keys:
    s = un(k)
    if "|H" in s or "|c" in s or re.search(r"Girdle|Helm|Boots|Cloak|Ring|Band|Robe|Gloves|Bracers|Belt|Leggings|Shoulder|Chestguard|Vestments|Wand|Blade|Axe|Mace", s):
        cats["item"].append(s)
    elif s in ("Loading...", "Catch Up Experience") or len(s) < 12:
        cats["generic" if s in ("Loading...", "Catch Up Experience") else "short"].append(s)
    else:
        cats["ability/lore"].append(s)
out = []
for c, lst in cats.items():
    out.append(f"=== {c}: {len(lst)} ===")
    out += ["  " + x[:90] for x in lst[:8]]
open(DATA_DIR / "_ejmiss.txt", "w", encoding="utf-8").write("\n".join(out))
print({c: len(l) for c, l in cats.items()})
