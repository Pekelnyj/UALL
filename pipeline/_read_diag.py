# -*- coding: utf-8 -*-
import sys, re, glob
sys.stdout.reconfigure(encoding="utf-8")

sv = open(glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0],
          encoding="utf-8", errors="replace").read()


def block(key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', sv)
    if not m:
        return None
    i, depth, start = m.end(), 1, m.end()
    instr = esc = False
    while i < len(sv) and depth > 0:
        c = sv[i]
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
    return sv[start:i - 1]


for key in ["diag", "errors"]:
    b = block(key)
    print(f"=== {key} ===")
    if b is None:
        print("  НЕМА")
        continue
    vals = re.findall(r'"((?:[^"\\]|\\.)*)"', b)
    for v in vals:
        print("  ", v.encode("utf-8", "replace").decode("utf-8"))
