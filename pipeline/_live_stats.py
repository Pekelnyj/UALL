# -*- coding: utf-8 -*-
import re
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
LIVE = Path("F:/Battlenet/World of Warcraft/_retail_/WTF/Account/129089678#1/SavedVariables/WoWUkraine.lua")
s = LIVE.read_text(encoding="utf-8", errors="replace")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))


def block(key):
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

# топ-рівневі ключі
root = s[re.search(r"WoWUkraineCaptureDB\s*=\s*\{", s).end():]
top = re.findall(r'\n\s*\["([a-zA-Z_]+)"\]\s*=\s*\{', root)
print("Категорії-таблиці у зборі:", top)
print()

npcN = tr.get("npcNames", {})

# перебрати всі словникові категорії й порахувати new
for key in ["npc", "creatures", "names", "nameplate", "renown", "uitooltip", "uiTooltips",
            "gobjseen", "gameObjects", "titles", "factions", "currencies", "minimap"]:
    bl = block(key)
    if not bl:
        continue
    pairs = KV.findall(bl)
    if not pairs:
        # можливо це масив імен без значень
        keys = re.findall(r'\["((?:[^"\\]|\\.)*)"\]', bl)
        print(f"{key}: {len(keys)} ключів (без знач.)")
        continue
    words = sum(len(v.split()) for _, v in pairs)
    # звірка з npcNames для мобів
    if key in ("npc", "creatures", "names", "nameplate"):
        new = [k for k, _ in pairs if k not in npcN and not any(k in d for d in [npcN])]
        new = [k for k, v in pairs if v not in npcN.values() and k not in npcN]
        print(f"{key}: {len(pairs)} зібрано | НОВИХ (нема в npcNames) ~{len(new)} | ~{words} слів")
    else:
        sec = tr.get(key, {})
        new = [k for k, _ in pairs if k not in sec]
        print(f"{key}: {len(pairs)} зібрано | НОВИХ ~{len(new)} | у перекладі={len(sec)} | ~{words} слів")
