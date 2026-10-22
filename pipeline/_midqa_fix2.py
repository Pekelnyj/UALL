# -*- coding: utf-8 -*-
"""Решта чітких фіксів з QA Midnight (low/med)."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
P = Path("g:/Claude Code/WoWUkraine/data/translations.json")
tr = json.loads(P.read_text(encoding="utf-8-sig"))
DOL = "$"

# база (наскрізні)
GLOBAL = [
    ("Болетус правий", "Болетус має рацію"),
    ("Лоа Достатку", "лоа Достатку"),
    ("Бровароство", "Броварство"), ("бровароство", "броварство"),
    ("Жаргобатіг", "Жаробатіг"), ("жаргобатіг", "жаробатіг"),
    ("Вівтарнативна історія", "Історія вівтарів"),
    ("хранителька коренів", "вартова коренів"),
    ("Колишня хранителька", "Колишня вартова"),
    # Dire Maul → Лютопащ
    ("Лютий Спис", "Лютопащ"), ("Лютого Списа", "Лютопащі"), ("Лютому Спису", "Лютопащі"),
    # the Molt → Линька / Линьці
    ("Линянні", "Линьці"), ("Линянням", "Линькою"), ("Линяння", "Линька"),
    # sungrubs → сонячні личинки
    ("сонцехробаків", "сонячних личинок"), ("сонцехробаки", "сонячні личинки"),
    ("сонцехробака", "сонячної личинки"), ("сонцехроб", "сонячна личинк"),
    # Taemin
    ("Теміном", "Таеміном"), ("Теміна", "Таеміна"), ("Теміну", "Таеміну"),
]
cnt = {}
def gfix(s):
    for a, b in GLOBAL:
        if a in s:
            cnt[a] = cnt.get(a, 0) + s.count(a)
            s = s.replace(a, b)
    return s
def walk(v):
    if isinstance(v, str):
        return gfix(v)
    if isinstance(v, dict):
        return {k: walk(x) for k, x in v.items()}
    if isinstance(v, list):
        return [walk(x) for x in v]
    return v
tr = walk(tr)

# точкові (по quest+field)
q = tr["quests"]
def pq(qid, fld, a, b):
    if qid in q and isinstance(q[qid], dict) and fld in q[qid]:
        if a in q[qid][fld]:
            q[qid][fld] = q[qid][fld].replace(a, b)
            cnt["pq:" + qid] = cnt.get("pq:" + qid, 0) + 1

pq("96728", "description", "ти доповіла", "ти допові" + DOL + "p(в:ла)")
pq("90823", "title", "Акіл'зон", "Акіл'зона")
pq("91089", "description", "Захисника Азероту", "Поборника Азероту")
pq("91345", "objectives", "слідопиткою Валсар", "слідопитом Валсар")
pq("91345", "description", "слідопитка", "слідопит")
pq("92448", "objectives", "доглядачем нетель", "доглядачкою нетель")
pq("92448", "objectives", "Вью'там", "Вев'там")
pq("91348", "objectives", "виверн", "манавирм")
pq("92164", "completion", "Ти впорався?", "Готово?")

P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print("замін:", sum(v for k, v in cnt.items()))
for k, v in sorted(cnt.items(), key=lambda x: -x[1])[:14]:
    print(f"  {k}: {v}")
