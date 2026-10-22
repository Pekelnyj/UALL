# -*- coding: utf-8 -*-
import sys, re
sys.stdout.reconfigure(encoding="utf-8")
s = open(sys.argv[1], encoding="utf-8", errors="replace").read()
key = sys.argv[2]
m = re.search(r'\["' + key + r'"\]\s*=\s*\{', s)
if not m:
    print(f"{key}: блоку немає")
    sys.exit()
i, depth = m.end(), 1
instr = esc = False
st = i
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
blk = s[st:i - 1]
ids = re.findall(r'\[\d+\]\s*=', blk)
print(f"{key}: записів (квестів) = {len(ids)} | байтів = {len(blk)}")
