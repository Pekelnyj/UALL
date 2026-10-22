# -*- coding: utf-8 -*-
"""Витяг db.ui (захоплені непокриті UI-рядки) з живого SV — точні EN рядки панелі
налаштувань, яких немає в globalStrings. Для перекладу й доливу в globalStrings."""
import sys, re, glob, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

paths = sorted(glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua"))
sv = open(paths[0], encoding="utf-8", errors="replace").read()

m = re.search(r'\["ui"\]\s*=\s*\{', sv)
if not m:
    print("db.ui НЕМА (debug вимкнено? увімкни /wu debug і відкрий панель)")
    sys.exit()
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
blk = sv[start:i - 1]
keys = re.findall(r'\["((?:[^"\\]|\\.)*)"\]', blk)


def un(s):
    return (s.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r")
             .replace("\\t", "\t").replace("\\\\", "\\"))


keys = [un(k) for k in keys]
gs = json.load(open(DATA_DIR / "translations.json", encoding="utf-8-sig")).get("globalStrings", {})
newui = [k for k in keys if k not in gs and re.search(r"[A-Za-z]{3}", k)]
print(f"db.ui усього: {len(keys)} | НЕ в globalStrings: {len(newui)}")
json.dump(sorted(newui), open(DATA_DIR / "_dbui_new.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
for k in sorted(newui):
    print("  ", repr(k))
