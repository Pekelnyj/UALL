# -*- coding: utf-8 -*-
import sys, glob, re
sys.stdout.reconfigure(encoding="utf-8")
sv = glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0]
s = open(sv, encoding="utf-8", errors="replace").read()


def block_of(key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', s)
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


for key in ("ejhdr", "ejdebug"):
    b = block_of(key)
    print("=" * 60)
    print(f"db.{key}:", "НЕМА" if b is None else "")
    if b:
        for k, v in re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', b):
            print(f"  [{k}] = {v[:200]}")
        for k, v in re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*(\d+)', b):
            print(f"  [{k}] = {v}")
