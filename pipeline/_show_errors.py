# -*- coding: utf-8 -*-
"""Витяг db.errors з тестерських файлів — показати помилки (наші vs чужі аддони)."""
import sys, re
sys.stdout.reconfigure(encoding="utf-8")

FILES = sys.argv[1:]


def block(sv, key):
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


def un(s):
    return (s.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r")
             .replace("\\t", "\t").replace("\\\\", "\\"))


for path in FILES:
    sv = open(path, encoding="utf-8", errors="replace").read()
    b = block(sv, "errors")
    print("=" * 70)
    print(path)
    if b is None:
        print("  db.errors НЕМА")
        continue
    # errors може бути масивом рядків АБО {рядок=...}
    strs = re.findall(r'"((?:[^"\\]|\\.)*)"', b)
    seen = []
    for s in strs:
        u = un(s)
        if u and u not in seen:
            seen.append(u)
    for i, e in enumerate(seen, 1):
        print(f"\n  [{i}] {e[:600]}")
