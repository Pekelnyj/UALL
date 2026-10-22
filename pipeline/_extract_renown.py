# -*- coding: utf-8 -*-
"""Витягти renown (нагороди слави) з обох зборів -> об'єднати -> дамп на переклад."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
done = tr.get("renown", {})

SRC = [
    Path("F:/Battlenet/World of Warcraft/_retail_/WTF/Account/129089678#1/SavedVariables/WoWUkraine.lua"),
    B / "testerlua/WoWUkraine (20).lua",
]


def block(s, key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
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


KV = re.compile(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"')
merged = {}
for p in SRC:
    if not p.exists():
        continue
    s = p.read_text(encoding="utf-8", errors="replace")
    for name, desc in KV.findall(block(s, "renown")):
        name = name.encode().decode("unicode_escape", "ignore") if "\\" in name else name
        desc = desc.encode().decode("unicode_escape", "ignore") if "\\" in desc else desc
        merged.setdefault(name, desc)

# неперекладені (ключ=EN name)
todo = [{"name": n, "desc": d} for n, d in sorted(merged.items()) if n not in done]
print(f"renown усього зібрано: {len(merged)} | перекладено: {len(done)} | на переклад: {len(todo)}")
words = sum(len(d.split()) for t in todo for d in [t["desc"]])
print(f"~{words} слів описів")

OUT = B / "data/_fin_in"
# поб'ємо на 3 для хвилі
k = 3
sz = (len(todo) + k - 1) // k
for i in range(k):
    chunk = todo[i * sz:(i + 1) * sz]
    if chunk:
        (OUT / f"renown_{i+1}.json").write_text(json.dumps(chunk, ensure_ascii=False, indent=1), encoding="utf-8")
        print(f"  renown_{i+1}.json: {len(chunk)}")
