# -*- coding: utf-8 -*-
import sys, re, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

s = open(str(DATA_DIR.parent / "testerlua" / "WoWUkraine (11).lua"), encoding="utf-8", errors="replace").read()


def block(key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', s)
    if not m:
        return None
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


# топ-рівневі ключі WoWUkraineCaptureDB
mroot = re.search(r'WoWUkraineCaptureDB\s*=\s*\{', s)
root = s[mroot.end():]
# прямі ключі першого рівня
topkeys = re.findall(r'\n    \["([^"\\]+)"\]\s*=', root)
print("ТОП-РІВНЕВІ КЛЮЧІ капчуру:", len(topkeys))
big = {}
for k in set(topkeys):
    b = block(k)
    if b is not None:
        cnt = len(re.findall(r'\["', b))
        if cnt > 1:
            big[k] = cnt
for k, c in sorted(big.items(), key=lambda x: -x[1]):
    print(f"  {k}: {c} записів")

# meta
mp = re.search(r'\["playerName"\]\s*=\s*"([^"]*)"', s)
print("\nplayerName:", mp.group(1) if mp else "?")
mv = re.search(r'v0\.\d+\.\d+-test\d+', s)
print("версія аддона тестера:", mv.group(0) if mv else "?")
