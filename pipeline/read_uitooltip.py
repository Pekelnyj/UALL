# -*- coding: utf-8 -*-
import sys, glob, re
sys.stdout.reconfigure(encoding="utf-8")
sv = glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0]
s = open(sv, encoding="utf-8", errors="replace").read()


def block(key):
    m = re.search(r'\["%s"\]\s*=\s*\{' % key, s)
    if not m:
        return None
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
    return s[m.end():i - 1]


b = block("uitooltip")
if b is None:
    print("db.uitooltip: НЕМА")
else:
    keys = re.findall(r'\["((?:[^"\\]|\\.)*)"\]', b)
    print(f"db.uitooltip: {len(keys)} рядків")
    for k in keys:
        print("  -", k.replace('\\"', '"').replace('\\\\', '\\'))
bs = block("spellCapture")
print("\ndb.spellCapture:", len(re.findall(r'\[(\d+)\]', bs)) if bs else "нема", "спелів")
