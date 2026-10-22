# -*- coding: utf-8 -*-
import sys, re
sys.stdout.reconfigure(encoding="utf-8")
s = open(sys.argv[1], encoding="utf-8", errors="replace").read()


def block(key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
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
    return s[st:i - 1]


for key in ("broadcast", "gossip"):
    keys = re.findall(r'\["((?:[^"\\]|\\.)*)"\]', block(key))
    print(f"=== {key}: {len(keys)} ключів, зразки ===")
    for k in keys[:8]:
        print("  ", repr(k[:70]))
# German markers
de = sum(1 for ch in s if ch in "äöüßÄÖÜ")
print("німецьких літер (ä/ö/ü/ß):", de)
