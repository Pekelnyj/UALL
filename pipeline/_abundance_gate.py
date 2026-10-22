# -*- coding: utf-8 -*-
"""Гейт: система Рясності (Midnight/Зул'Аман/лоа Дундун, Abundance) МУСИТЬ бути «рясність»,
а не «достаток». Контекстний: чіпає лише ЗАКРІПЛЕНІ системні анкери (не generic «достаток»
у Пілігримовому Достатку / старих квестах / «abundance of treasures»). Падає, якщо анкер
регресував на достаток. [[term-rename-spread-and-gender]] [[glossary-needs-active-gate]].
Запуск: python pipeline/_abundance_gate.py  (0=ок, 1=є регрес)
"""
from pathlib import Path
import json, re, sys
sys.stdout.reconfigure(encoding="utf-8")
ROOT = str(Path(__file__).resolve().parent.parent) + "/"
t = json.load(open(ROOT + "data/translations.json", encoding="utf-8-sig"))
DOST = re.compile(r"[Дд]остат")

# ЗАКРІПЛЕНІ анкери системи Рясності (EN), де достаток = регрес
ITEM_ANCHORS = ["Abundant Beacon", "Ensemble: Abundant Raiment", "Overflowing Abundant Satchel",
                "Idol of Abundance"]
GOSSIP_ANCHORS = ["The Abundant Awakening", "Tell me about Abundance.",
                  "Harvesting Abundance.", "Contributing Abundance.", "The Blessing of Abundance."]
QUEST_ANCHORS = ["91930", "91933", "94361", "93931"]  # The Abundant Lands/Honor/Life, Abundance of Wealth
BROADCAST_ANCHORS = ["This is abundance.",
                     "Delay not! Lest abundance be claimed without you!",
                     "Alas, alack, alacrity! Your abundant limit nears!"]

fails = []
for en in ITEM_ANCHORS:
    ua = t.get("itemNames", {}).get(en)
    if isinstance(ua, str) and DOST.search(ua):
        fails.append(f"itemNames[{en!r}] = {ua!r}")
for en in GOSSIP_ANCHORS:
    ua = t.get("gossip", {}).get(en)
    if isinstance(ua, str) and DOST.search(ua):
        fails.append(f"gossip[{en!r}] = {ua!r}")
for en in BROADCAST_ANCHORS:
    ua = t.get("broadcast", {}).get(en)
    if isinstance(ua, str) and DOST.search(ua):
        fails.append(f"broadcast[{en!r}] = {ua!r}")
for qid in QUEST_ANCHORS:
    v = t.get("quests", {}).get(qid, {})
    for f, ua in v.items():
        if isinstance(ua, str) and DOST.search(ua):
            fails.append(f"quests[{qid}].{f} = {ua[:50]!r}")

if fails:
    print("РЕГРЕС Рясність→достаток у системних анкерах:")
    for x in fails:
        print("  " + x)
    print(f"\nВСЬОГО: {len(fails)}. Система Рясності НЕ вживає «достаток».")
    sys.exit(1)
print("Гейт Рясності: OK (системні анкери на «рясність»)")
