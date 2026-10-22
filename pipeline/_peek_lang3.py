# -*- coding: utf-8 -*-
import sys, re
sys.stdout.reconfigure(encoding="utf-8")
s = open(sys.argv[1], encoding="utf-8", errors="replace").read()
DE = re.compile("[äöüßÄÖÜ]")


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


# усі топ-рівневі ключі CaptureDB
top = re.findall(r'\n\t\t\["(\w+)"\]\s*=\s*\{', s)
if not top:
    top = re.findall(r'\["(\w+)"\]\s*=\s*\{', s)
print("=== німецькі літери по блоках ===")
for k in sorted(set(top)):
    b = block(k)
    n = len(DE.findall(b))
    if n:
        print(f"  {k}: {n}")

print("\n=== npc зразки ===")
nb = block("npc")
for v in re.findall(r'=\s*"((?:[^"\\]|\\.){3,})"', nb)[:8]:
    print("  ", repr(v[:55]))

print("\n=== рядки з нім.літерами (де саме) ===")
shown = 0
for m in re.finditer(r'"((?:[^"\\]|\\.)*)"', s):
    v = m.group(1)
    if DE.search(v) and len(v) > 15:
        print("  ", repr(v[:70]))
        shown += 1
        if shown >= 10:
            break
