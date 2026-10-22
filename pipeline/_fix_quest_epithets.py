# -*- coding: utf-8 -*-
"""Точкові виправлення описових епітетів у КВЕСТАХ на канон-транслітерацію.
Blackhand→Блекгенд, Doomhammer→Думгаммер, Blackrock(clan/Foundry)→Блекрок —
як уже у npcNames/itemFlavors/journal. Sunwalker(27403) НЕ чіпаємо (титул)."""
import sys, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
q = tr["quests"]

# (qid, field, [(старе, нове), ...])
FIX = [
    ("37765", "title", [("Горнило Чорноруча: Чорноруч", "Горнило Блекгенда: Блекгенд")]),
    ("37765", "description", [("клану Чорноскеля", "клану Блекрок"),
                              ("Чорноскельної Ливарні", "Ливарні Блекрок")]),
    ("37772", "title", [("Горнило Чорноруча: Чорноруч", "Горнило Блекгенда: Блекгенд")]),
    ("37772", "description", [("Чорноруч, Воєначальник клану Чорноскеля",
                              "Блекгенд, Воєначальник клану Блекрок"),
                              ("здолай Чорноруча", "здолай Блекгенда"),
                              ("Чорноскельної Ливарні", "Ливарні Блекрок")]),
    ("40224", "description", [("Молот Фатуму впав", "Думгаммер впав")]),
    ("42931", "description", [("повернути Молот Долі", "повернути Думгаммер")]),
    ("42932", "description", [("чи бачила вона Молот Долі", "чи бачила вона Думгаммер")]),
]

changed = 0
for qid, field, subs in FIX:
    txt = q[qid][field]
    new = txt
    for old, rep in subs:
        if old not in new:
            print(f"!! НЕ ЗНАЙДЕНО у {qid}/{field}: {old!r}")
        new = new.replace(old, rep)
    if new != txt:
        q[qid][field] = new
        changed += 1
        print(f"OK {qid}/{field}")

P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"\nзмінено полів: {changed}")
