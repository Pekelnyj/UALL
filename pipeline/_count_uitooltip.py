# -*- coding: utf-8 -*-
"""Порахувати непокриті описи опцій (db.uitooltip) у живому капчурі."""
import sys, re, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

path = sys.argv[1]
s = open(path, encoding="utf-8", errors="replace").read()
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
covered = set(tr.get("globalStrings", {})) | set(tr.get("uiTooltips", {}))


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


def un(x):
    x = x.replace("\\\\", "\x00")
    x = x.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r").replace("\\t", "\t")
    return x.replace("\x00", "\\")


keys = re.findall(r'\["((?:[^"\\]|\\.)*)"\]', block("uitooltip"))
new = []
for k in keys:
    u = un(k)
    if u in covered:
        continue
    if not re.search(r"[A-Za-z]{3}", u):
        continue
    new.append(u)
print(f"db.uitooltip усього: {len(keys)} | НЕпокритих: {len(new)}")
for x in new[:15]:
    print("  ", repr(x[:75]))
