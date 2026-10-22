# -*- coding: utf-8 -*-
import sys, glob, re
sys.stdout.reconfigure(encoding="utf-8")
sv = glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0]
s = open(sv, encoding="utf-8", errors="replace").read()
m = re.search(r'\["ejdebug"\]\s*=\s*\{', s)
if not m:
    print("db.ejdebug: НЕМА")
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
pairs = re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', block)
print(f"db.ejdebug: {len(pairs)} зразків\n")
for k, v in pairs[:15]:
    val = v.replace("\\\\", "\\").replace("||", "|").replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r")
    print("RAW:", repr(val[:280]))
    print()
