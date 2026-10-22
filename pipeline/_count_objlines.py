# -*- coding: utf-8 -*-
"""Порахувати неперекладені tracker-цілі (db.objLines) у живому капчурі.
Запуск: python _count_objlines.py "<шлях SavedVariables>" """
import sys, re, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

path = sys.argv[1]
s = open(path, encoding="utf-8", errors="replace").read()
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
qo = set(tr.get("questObjectives", {}))


def block(key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
    i, depth = m.end(), 1
    instr = esc = False
    start = i
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
    return s[start:i - 1]


def un(x):
    x = x.replace("\\\\", "\x00")
    x = x.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r").replace("\\t", "\t")
    return x.replace("\x00", "\\")


keys = re.findall(r'\["((?:[^"\\]|\\.)*)"\]', block("objLines"))
new = []
for k in keys:
    u = un(k)
    base = u.strip()
    if base in qo:
        continue
    if not re.search(r"[A-Za-z]{3}", base):
        continue
    if "ипогрив" in base:  # вже укр.
        continue
    new.append(base)

print(f"objLines усього: {len(keys)} | НЕперекладених: {len(new)}")
for x in new[:25]:
    print("  ", repr(x[:70]))
