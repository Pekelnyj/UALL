# -*- coding: utf-8 -*-
import sys, glob, re, json
sys.stdout.reconfigure(encoding="utf-8")
sv = glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0]
s = open(sv, encoding="utf-8", errors="replace").read()
m = re.search(r'\["ejmiss"\]\s*=\s*\{', s)
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

def unesc(v):
    return v.replace("\\\\", "\\").replace("||", "|").replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r").replace("\\t", "\t")

KEYRE = re.compile(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*(\d+)')
disp = None
for k, n in KEYRE.findall(block):
    u = unesc(k)
    if u.startswith("Argus was governed"):
        disp = u
        break

idesc = json.load(open("data/source/api_instance_desc.json", encoding="utf-8-sig"))
key = idesc["945"]["desc"]["en"]
print("показане len:", len(disp), "| ключ len:", len(key), "| РІВНІ?", disp == key)
diffs = 0
for idx in range(min(len(disp), len(key))):
    a, b = disp[idx], key[idx]
    if a != b:
        print(f"  поз {idx}: показане {a!r} U+{ord(a):04X}  ≠  ключ {b!r} U+{ord(b):04X}   …{disp[max(0,idx-12):idx+3]!r}")
        diffs += 1
        if diffs >= 8:
            break
if diffs == 0 and len(disp) != len(key):
    print("  префікс однаковий; хвіст показаного:", repr(disp[len(key):len(key)+30]))
