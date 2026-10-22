# -*- coding: utf-8 -*-
"""Остаточний аудит: УСІ текстові категорії живого збору проти перекладу."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
LIVE = Path("F:/Battlenet/World of Warcraft/_retail_/WTF/Account/129089678#1/SavedVariables/WoWUkraine.lua")
s = LIVE.read_text(encoding="utf-8", errors="replace")

# усі перекладені EN-ключі (по всіх секціях) + значення-UA
all_keys = set()
def collect(v):
    if isinstance(v, dict):
        for k, x in v.items():
            all_keys.add(k)
            collect(x)
    elif isinstance(v, list):
        for x in v:
            collect(x)
collect(tr)


def block(key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
    i, depth, instr, esc = m.end(), 1, False, False
    while i < len(s) and depth > 0:
        c = s[i]
        if instr:
            if esc: esc = False
            elif c == "\\": esc = True
            elif c == '"': instr = False
        else:
            if c == '"': instr = True
            elif c == "{": depth += 1
            elif c == "}": depth -= 1
        i += 1
    return s[m.end():i - 1]


def cyr(x): return bool(re.search(r"[А-Яа-яІЇЄҐ]", x))

# текстові категорії (не діагностичні)
CATS = ["broadcast", "gossip", "renown", "uitooltip", "itemtt", "ui", "system",
        "books", "mail", "subjects", "bodies", "ejtext", "profui", "objLines",
        "objectives", "minimap", "globalStrings"]
print(f"{'категорія':<14}{'зібрано':>9}{'НЕперекл.':>11}")
print("-" * 36)
for cat in CATS:
    bl = block(cat)
    if not bl:
        continue
    # ключі (англ. рядки/назви) і значення
    keys = re.findall(r'\["((?:[^"\\]|\\.)*)"\]', bl)
    cand = [k for k in set(keys) if len(k) > 3 and not cyr(k) and not k.isdigit()]
    untr = [k for k in cand if k not in all_keys]
    print(f"{cat:<14}{len(cand):>9}{len(untr):>11}")
    if untr and len(untr) <= 8:
        for u in untr[:8]:
            print(f"      • {u[:70]}")
