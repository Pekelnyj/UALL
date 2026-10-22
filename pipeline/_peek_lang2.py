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


DE = re.compile("[äöüßÄÖÜ]")
# показати, у яких блоках є німецькі літери
for key in ("quests", "broadcast", "gossip", "npc", "npcNames", "objLines", "uitooltip", "errors"):
    b = block(key)
    if not b:
        continue
    n = len(DE.findall(b))
    print(f"{key}: німецьких літер = {n}")

# зразки рядків квестів (objectives/progress) — мова?
qb = block("quests")
strs = re.findall(r'"((?:[^"\\]|\\.){20,})"', qb)
print("\n=== зразки тексту квестів ===")
for x in strs[:6]:
    print("  ", repr(x[:75]))
