# -*- coding: utf-8 -*-
"""Витяг db.globalStrings (name->en дамп поточного клієнта) з живого SV. Оновлює
source/globalstrings.json (свіжі Midnight-рядки) і показує непокриті OPTION_TOOLTIP."""
import sys, re, glob, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

sv = open(sorted(glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua"))[0],
          encoding="utf-8", errors="replace").read()
m = re.search(r'\["globalStrings"\]\s*=\s*\{', sv)
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
pairs = re.findall(r'\["([A-Z][A-Z0-9_]*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', blk)


def un(s):
    return (s.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r")
             .replace("\\t", "\t").replace("\\\\", "\\"))


dump = {name: un(v) for name, v in pairs}
print(f"db.globalStrings (дамп клієнта): {len(dump)} пар")

# оновити source/globalstrings.json (мерж: нові/оновлені перекривають)
SP = DATA_DIR / "source" / "globalstrings.json"
src = json.loads(SP.read_text(encoding="utf-8-sig")) if SP.exists() else {}
added = 0
for name, en in dump.items():
    if src.get(name) != en:
        src[name] = en
        added += 1
SP.write_text(json.dumps(src, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"оновлено source/globalstrings.json: {added} (усього {len(src)})")

# непокриті OPTION_TOOLTIP / SUBTEXT описи (EN не в translations.globalStrings)
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
gs = tr.get("globalStrings", {})
todo = {}
for name, en in dump.items():
    if not re.search(r"TOOLTIP|SUBTEXT|_LABEL|OPTION_", name):
        continue
    if "%" in en or "|" in en or len(en) < 4:
        continue
    if en in gs:
        continue
    todo[en] = name
out = sorted(set(todo))
json.dump(out, open(DATA_DIR / "_gsdump_todo.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"непокритих OPTION/TOOLTIP/SUBTEXT: {len(out)}")
for e in out[:10]:
    print("  ", repr(e[:80]))
