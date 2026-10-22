# -*- coding: utf-8 -*-
import sys, glob, re
sys.stdout.reconfigure(encoding="utf-8")
sv = glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0]
s = open(sv, encoding="utf-8", errors="replace").read()
m = re.search(r'\["ejloot"\]\s*=\s*\{', s)
if not m:
    print("db.ejloot: НЕМА")
    sys.exit()
i, depth = m.end(), 1
instr = esc = False
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
block = s[m.end():i - 1]
for k, v in re.findall(r'\["(\w+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', block):
    print(f"{k}: {v.replace(chr(92) + chr(34), chr(34))}")
    print()
