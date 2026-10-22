# -*- coding: utf-8 -*-
"""ГЕЙТ: чуже ім'я на плашці — підміна ключ↔значення в шарі npcNames.

18.10.2026. Агент хвилі побачив у пакеті доказів «Hunted Remnant = Петйолл
Гострий лист» і не повірив. Перевірка підтвердила:
    npcNames["246605"] = "Петйолл Гострий лист"   # EN: Hunted Remnant
    npcNames["271689"] = "Петйолл Гострий лист"   # EN: Petyoll the Razorleaf
Тобто безіменному мобові дісталося ім'я боса. На плашці гравець бачить не те
створіння, яке перед ним [[kv-shift-substitution]].

ЯК ЛОВИМО. Одне й те саме українське ім'я під двома ID — саме по собі
нормально: різні англійські назви законно зводяться до «Вартовий». Підозра
виникає тоді, коли англійські назви не мають НІ ОДНОГО спільного слова (від 4
літер) — бо тоді однаковий переклад нічим не виправданий. Додатково вимагаємо,
щоб ім'я виглядало ВЛАСНИМ (два+ слова, друге з великої або апостроф): родові
моби законно збігаються, а власне ім'я — ні.

Запуск: python _check_plate_kv_shift.py [--all]
   --all: показати й родові збіги (без вимоги власного імені)
"""
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

ALL = "--all" in sys.argv
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
cr = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
npc = tr.get("npcNames") or {}

en_of = {}
for cid, v in cr.items():
    nm = v.get("name") if isinstance(v, dict) else None
    en = nm.get("en") if isinstance(nm, dict) else None
    if en:
        en_of[str(cid)] = en

WORD = re.compile(r"[A-Za-z']{4,}")
# власне ім'я: два+ слова, і не перше слово з великої, або є апостроф
OWN = re.compile(r"[А-ЯІЇЄҐ][а-яіїєґ'’]+\s+[А-ЯІЇЄҐ]|['’]")

by_ua = defaultdict(list)
for cid, ua in npc.items():
    if isinstance(ua, str) and ua and str(cid) in en_of:
        by_ua[ua].append(str(cid))

hits = []
for ua, ids in by_ua.items():
    if len(ids) < 2:
        continue
    bags = {i: set(w.lower() for w in WORD.findall(en_of[i])) for i in ids}
    # чи є пара без жодного спільного слова
    clash = False
    for a in ids:
        for b in ids:
            if a < b and not (bags[a] & bags[b]):
                clash = True
    if not clash:
        continue
    if not ALL and not OWN.search(ua):
        continue
    hits.append((ua, ids))

print(f"однакове ім'я при неспоріднених англійських назвах: {len(hits)}")
for ua, ids in sorted(hits)[:40]:
    print(f"  {ua!r}")
    for i in ids:
        print(f"      {i}  {en_of[i]}")
sys.exit(1 if hits else 0)
