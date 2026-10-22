# -*- coding: utf-8 -*-
"""Ідемпотентний канон-фікс імен (пара до _hellscream_gate.py). Застосовує ВСІ
відомі описові/хибні форми -> транслітерація, у translations.json + Broadcast.lua +
broadcast_out.json. Запускати, поки гейт не стане чистим.
Запуск: python pipeline/_canon_fix.py
"""
import json, re, sys
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"g:/Claude Code/WoWUkraine"

# (regex, заміна) — ДОВШІ/специфічніші ПЕРШІ; усі ідемпотентні
SUBS = [
    # Hellscream -> Хеллскрім (описові + хибні)
    (r"Пекельного Крику", "Хеллскріма"), (r"Пекельного Крика", "Хеллскріма"),
    (r"Пекельному Крикові", "Хеллскріму"), (r"Пекельному Крику", "Хеллскріму"),
    (r"Пекельним Криком", "Хеллскрімом"), (r"Пекельнім Криком", "Хеллскрімом"),
    (r"Пекельнім Крику", "Хеллскрімі"), (r"Пекельний Крик", "Хеллскрім"),
    (r"Пеклокрик", "Хеллскрім"),
    (r"Пеккриком", "Хеллскрімом"), (r"Пеккрика", "Хеллскріма"),
    (r"Пеккриму", "Хеллскріму"), (r"Пеккрику", "Хеллскріму"), (r"Пеккрик", "Хеллскрім"),
    (r"Геллскрім", "Хеллскрім"),   # Г -> Х (стем, відмінки слідують)
    # Grommash -> Ґроммаш (один м / без Ґ / Г-замість-Ґ -> канон)
    (r"\bГроммаш", "Ґроммаш"),   # Г->Ґ (два м лишаються): Громмаш/Громмашар тощо
    (r"\bҐромаш", "Ґроммаш"), (r"\bГромаш", "Ґроммаш"),
    # Deathwing -> Дезвінг
    (r"Смертокрилом", "Дезвінгом"), (r"Смертокрилові", "Дезвінгові"),
    (r"Смертокрила", "Дезвінга"), (r"Смертокрилу", "Дезвінгу"),
    (r"Смертокрилі", "Дезвінгові"), (r"Смертокриле", "Дезвінгу"), (r"Смертокрил", "Дезвінг"),
]
RX = [(re.compile(a), b) for a, b in SUBS]

def fix(s):
    for rx, b in RX:
        s = rx.sub(b, s)
    return s

n = {"tr": 0, "lua": 0, "bo": 0}
# translations.json
P = ROOT + "/data/translations.json"; tr = json.load(open(P, encoding="utf-8-sig"))
def walk(o):
    if isinstance(o, str):
        f = fix(o)
        if f != o: n["tr"] += 1
        return f
    if isinstance(o, dict): return {k: walk(v) for k, v in o.items()}
    if isinstance(o, list): return [walk(v) for v in o]
    return o
tr = walk(tr); json.dump(tr, open(P, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
# Broadcast.lua
DB = ROOT + "/addon/WoWUkraine/Database/Broadcast.lua"; lua = open(DB, encoding="utf-8").read()
lua2 = fix(lua); n["lua"] = sum(1 for a, b in zip(lua.split("\n"), lua2.split("\n")) if a != b)
open(DB, "w", encoding="utf-8").write(lua2)
# broadcast_out.json
BO = ROOT + "/data/tester_new/broadcast_out.json"; bo = json.load(open(BO, encoding="utf-8"))
bo2 = {fix(k): fix(v) for k, v in bo.items()}; n["bo"] = sum(1 for k in bo if bo[k] != bo2.get(fix(k), bo[k]))
json.dump(bo2, open(BO, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"канон-фікс: translations {n['tr']} рядків, Broadcast.lua {n['lua']} рядків, broadcast_out ~{n['bo']}")
print(f"баланс Lua: {lua2.count('{')}/{lua2.count('}')}")
