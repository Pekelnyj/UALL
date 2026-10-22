# -*- coding: utf-8 -*-
"""Точкові дефекти шару неймплейтів, знайдені хвилею 18.10.2026.

ПІДМІНА КЛЮЧ↔ЗНАЧЕННЯ (гейт _check_plate_kv_shift.py). Безіменний моб носив
ім'я боса, а мамут-маунт звався на честь мурлока:
    246605  Hunted Remnant              = «Петйолл Гострий лист»  (ім'я боса)
    81947   Traveler's Tundra Mammoth   = «Син Скума»
Правильні переклади беремо з прецедентів бази: Remnant = «останок»
(Diseased/Plaguedoused Remnant), а мамут — із назви предмета-повіддя
(«Повіддя Тундрового Мамонта Мандрівника»).

РІД, НЕ УЗГОДЖЕНИЙ ІЗ ІМЕННИКОМ:
    250124  Plump Chitterfang = «Пухкий хрускоікло» -> «Пухке» («ікло» середнього)

ОДИН EN — ДВІ УКРАЇНСЬКІ НАЗВИ. `NpcNames.lua` ключується англійською, тож із
двох ID лишиться одна назва, і плашка стає непередбачуваною. Зводимо старі ID
до форми, яку хвиля довела доказами (ціль квесту, віньєтка, родина):
    217183  Noth Drone              «Дрон Нота»              -> «Нотський трутень»
    222156  Scavenging Sandsnapper  «Падложерний піскохап»   -> «…піщаний кусач»
    221678  Wild Stormhowl          «Дикий штормовий вий»    -> «…ревун»

ЗЛАМАНЕ УЗГОДЖЕННЯ в цілі квесту: «Вбий 10 сонячна личінків» — обидва слова не
в тій формі.

Запуск: python _fix_plate_defects_1018.py [--apply]
Далі:   python generate_db.py
"""
import io
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
npc = tr.setdefault("npcNames", {})

NAMES = {
    "246605": ("Петйолл Гострий лист", "Загнаний останок"),
    "81947": ("Син Скума", "Тундровий мамонт мандрівника"),
    "250124": ("Пухкий хрускоікло", "Пухке хрускоікло"),
    "217183": ("Дрон Нота", "Нотський трутень"),
    "222156": ("Падложерний піскохап", "Падложерний піщаний кусач"),
    "221678": ("Дикий штормовий вий", "Дикий штормовий ревун"),
}

print("ІМЕНА ІСТОТ")
for cid, (old, new) in NAMES.items():
    cur = npc.get(cid)
    if cur != old:
        print(f"  !! {cid}: очікував {old!r}, а там {cur!r} — не чіпаю")
        continue
    print(f"  {cid}: {old!r} -> {new!r}")
    if APPLY:
        npc[cid] = new

# --- зламане узгодження в цілі квесту --------------------------------------
obj = tr.get("questObjectives") or {}
RX = re.compile(r"сонячна личінк\w*|сонячна личинк\w*")
print("\nЦІЛІ КВЕСТІВ")
for k, v in list(obj.items()):
    if not isinstance(v, str) or not RX.search(v):
        continue
    new = RX.sub("сонячних личинок", v)
    print(f"  {k[:52]!r}\n     - {v[:64]}\n     + {new[:64]}")
    if APPLY:
        obj[k] = new

if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("\ntranslations.json записано")
