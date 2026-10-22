# -*- coding: utf-8 -*-
"""Витяг непокритих ОПИСІВ налаштувань із db.uitooltip живого SV (тултіпи опцій,
яких нема в дампі globalstrings — лише через захоплення). Для перекладу."""
import sys, re, glob, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

sv = open(sorted(glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua"))[0],
          encoding="utf-8", errors="replace").read()
m = re.search(r'\["uitooltip"\]\s*=\s*\{', sv)
i, depth, start = m.end(), 1, m.end()
instr = esc = False
while i < len(sv) and depth > 0:
    c = sv[i]
    if instr:
        if esc: esc = False
        elif c == "\\": esc = True
        elif c == '"': instr = False
    else:
        if c == '"': instr = True
        elif c == "{": depth += 1
        elif c == "}": depth -= 1
    i += 1
blk = sv[start:i - 1]
keys = re.findall(r'\["((?:[^"\\]|\\.)*)"\]', blk)


def un(s):
    return (s.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r")
             .replace("\\t", "\t").replace("\\\\", "\\"))


tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
gs = tr.get("globalStrings", {})
ui = tr.get("uiTooltips", {})

new = []
for k in keys:
    s = un(k)
    if not s or s in gs or s in ui:
        continue
    if not re.search(r"[A-Za-z]{3}", s):
        continue
    if re.search(r"[А-Яа-яЇїІіЄєҐґ]", s):  # вже кир.
        continue
    new.append(s)
new = sorted(set(new))
# розділити: описи-речення (>=25, з пробілами) vs короткі
descs = [s for s in new if len(s) >= 25 and " " in s]
short = [s for s in new if s not in descs]
json.dump(descs, open(DATA_DIR / "_uitt_descs.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
json.dump(short, open(DATA_DIR / "_uitt_short.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"db.uitooltip непокритих: {len(new)} | описів-речень: {len(descs)} | коротких: {len(short)}")
for s in descs[:12]:
    print("  ", repr(s[:80]))
