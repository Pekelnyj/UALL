# -*- coding: utf-8 -*-
"""Як БАЗА робить описові прізвища: перекладає (значення) чи транслітерує (звук)."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
npcN = tr["npcNames"]
src = {}
for f in ["creatures.json", "api_creatures_full.json"]:
    d = json.loads((B / "data/source" / f).read_text(encoding="utf-8-sig"))
    for k, v in d.items():
        if isinstance(v, dict) and v.get("name", {}).get("en"):
            src.setdefault(k, v["name"]["en"])
new = set(json.loads((B / "data/_live_new_npc.json").read_text(encoding="utf-8-sig")))

tests = {
    "hoof": ("копит", "гуф"),
    "mane": ("грив", "мейн"),
    "blade": ("клинок|меч", "блейд"),
    "song": ("спів", "сонг"),
    "claw": ("кіготь|лап", "клов|клоу"),
    "beard": ("борід|бород", "бірд"),
    "breaker": ("лам|руйн|трощ", "брейкер"),
    "strider": ("ступ|ходь", "страйдер"),
    "fury": ("лют|шал", "фурі"),
    "blood": ("кров", "блад"),
    "horn": ("ріг|рог", "горн"),
    "whisper": ("шепіт|шепот", "віспер"),
    "wind": ("вітер|вітр", "вінд"),
}
print(f"{'компонент':<11}{'переклад(знач.)':>17}{'трансліт(звук)':>16}")
for comp, (tr_pat, lit_pat) in tests.items():
    transl = descr = 0
    for cid, en in src.items():
        if cid in new or cid not in npcN:
            continue
        if en.lower().endswith(comp) and " " in en:
            ua = npcN[cid].lower()
            if re.search(lit_pat, ua):
                transl += 1
            elif re.search(tr_pat, ua):
                descr += 1
    print(f"-{comp:<10}{descr:>17}{transl:>16}")
