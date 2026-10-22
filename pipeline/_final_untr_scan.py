# -*- coding: utf-8 -*-
"""Остаточний скан: що РЕАЛЬНО неперекладено (захоплене в грі + джерела)."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))

CAPS = [
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
            if esc: esc = False
            elif c == "\\": esc = True
            elif c == '"': instr = False
        else:
            if c == '"': instr = True
            elif c == "{": depth += 1
            elif c == "}": depth -= 1
        i += 1
    return s[m.end():i - 1]


KV = re.compile(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"')


def cap_union(key):
    out = {}
    for p in CAPS:
        if p.exists():
            for k, v in KV.findall(block(p.read_text(encoding="utf-8", errors="replace"), key)):
                out.setdefault(k, v)
    return out


def cyr(s): return bool(re.search(r"[А-Яа-яІЇЄҐ]", s))

# broadcast/субтитри: ключ англ.рядок -> переклад у tr['broadcast']
bc = cap_union("broadcast")
btr = tr.get("broadcast", {})
bc_new = [k for k in bc if k not in btr and len(k) > 3 and not cyr(k)]
print(f"СУБТИТРИ (broadcast) захоплено: {len(bc)} | НЕперекладено: {len(bc_new)}")

# gossip
go = cap_union("gossip")
gtr = tr.get("gossip", {})
go_new = [k for k in go if k not in gtr and len(k) > 3 and not cyr(k)]
print(f"GOSSIP захоплено: {len(go)} | НЕперекладено: {len(go_new)}")

# renown
rn = cap_union("renown")
rtr = tr.get("renown", {})
rn_new = [n for n, d in rn.items() if d not in rtr and d not in rtr.values()]
print(f"RENOWN захоплено: {len(rn)} | (descs не в tr): {sum(1 for n,d in rn.items() if d and d not in rtr)}")

# gameTips джерело?
gt_src = (B / "data/source/api_game_tips.json")
print(f"gameTips: розділ у tr = {len(tr.get('gameTips', {}))} | джерело-файл існує: {gt_src.exists()}")

# subjects/bodies (пошта) з капчуру
for key in ["subjects", "bodies", "mail"]:
    d = cap_union(key)
    if d:
        print(f"ПОШТА[{key}] захоплено: {len(d)}")
