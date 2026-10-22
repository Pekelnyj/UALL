# -*- coding: utf-8 -*-
import sys, re
sys.stdout.reconfigure(encoding="utf-8")
s = open("testerlua/WoWUkraine (11).lua", encoding="utf-8", errors="replace").read()
m = re.search(r'\["errors"\]\s*=\s*\{', s)
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
block = s[m.end():i - 1]
# значення (екрановані рядки)
vals = re.findall(r'\["((?:[^"\]|\.)*)"\]', block)
def un(v): return v.replace('\\"', '"').replace("\n", "\n").replace("\r", "\r").replace("\t", "\t").replace("\\\\", "\\")
ours, others = [], 0
for v in vals:
    u = un(v)
    if "WoWUkraine" in u and "WowUkrainizer" not in u:
        ours.append(u)
    else:
        others += 1
print(f"errors усього: {len(vals)} | НАШІ (WoWUkraine): {len(ours)} | інші аддони: {others}")
seen = set()
for u in ours:
    # унікалізувати за рядком файлу
    key = re.search(r"WoWUkraine[\/].-?\.lua:\d+", u)
    k = key.group(0) if key else u[:60]
    if k in seen: continue
    seen.add(k)
    print("\n---", k)
    print(u[:400])
