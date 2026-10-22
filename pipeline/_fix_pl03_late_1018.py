# -*- coding: utf-8 -*-
"""Доливка 7 імен pl_03 і три шар-конфлікти з того самого звіту (18.10.2026).

ЧОМУ ДОЛИВКА. Агент порції pl_03 здав файл, я його влив, а він ПІСЛЯ того
дотягнув офіційні de/fr/ru/es і виправив сім імен. Файл на диску свіжіший за
базу — звіряння показало рівно ці сім розбіжностей. УРОК: коли агент пише, що
чекає на веб-довідку, яка не встигла, його вихід ще не остаточний.

ЧОМУ САМЕ ТАК (підстава кожної правки):
  Pincha    усі локалі перекладають (de «Zwicka», ru «Щепоть») -> «Щипун»
  Whistler  de «Pfeifer», fr «Siffleur», ru «Свистун»          -> «Свистун»
  Teek      «Тік» уже належить ІНШОМУ мобові (Tick), два різні EN мали б одну
            плашку; дев'ятка після «т» дає                      -> «Тик»
  Ravageant це ЖУК-рідкісний Голловфолу (de «Wüterich»), а «Плюндрант» був
            новотвором; у базі вже є живе слово                 -> «Плюндрувач»
  Warped Dragonbone  тип істоти порожній (реквізит на розкопі), усі локалі
            дають «спотворена кістка дракона»                   -> двослівна форма
  Tormented Hatchling  de «Gequältes Küken» (курча), і de САМ розрізняє: у
            Cowering Hatchling там загальне «Jungtier»          -> «пташеня»
  Observational  de «Aufmerksame», ru «Наблюдательный» — це про пильність
            вартового, а не про призначення                     -> «спостережливий»

ШАР-КОНФЛІКТИ з того ж звіту:
  vignette «Народжений Площинами нищитель» — «площина» тут геометрична калька,
      домінанта бази для plane-of-existence «вимір» (вимір льоду/бур/вогню);
  vignette «Мандрівний Скарб Тріфлснача» — та сама істота, що Triflesnatcher,
      і всі локалі передають її описово (de «Kleinschnapper», ru «Мелкохват»);
  broadcast «Гниль забирає Гнилолапа» — Rotpaw ЖІНКА: квест 75950 «She's
      indiscriminate in who or what she spreads her decay to», de «Faulhändlerin
      Rottpfote». Чоловічий рід у репліці суперечить власному опису квесту.

Запуск: python _fix_pl03_late_1018.py [--apply]
Далі:   python _rebuild_broadcast_lua.py --apply && python generate_db.py
"""
import io
import json
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))

NAMES = {
    "204814": ("Пінча", "Щипун"),
    "204863": ("Вістлер", "Свистун"),
    "204973": ("Тік", "Тик"),
    "207826": ("Плюндрант", "Плюндрувач"),
    "209181": ("Спотворена драконокість", "Спотворена драконова кість"),
    "209974": ("Змучене маля", "Змучене пташеня"),
    "210624": ("Спостережний вартовий пилку", "Спостережливий вартовий пилку"),
}
npc = tr.setdefault("npcNames", {})
print("ІМЕНА (доливка pl_03)")
for cid, (old, new) in NAMES.items():
    if npc.get(cid) != old:
        print(f"  !! {cid}: там {npc.get(cid)!r}, очікував {old!r} — не чіпаю")
        continue
    print(f"  {cid}: {old!r} -> {new!r}")
    if APPLY:
        npc[cid] = new

# (секція, що міняємо, на що) — заміна ПІДРЯДКА у значеннях
SUBS = [
    ("vignette", "Народжений Площинами", "Народжений вимірами"),
    ("vignette", "Тріфлснача", "Дрібничкохапа"),
    ("broadcast", "забирає Гнилолапа", "забирає Гнилолапу"),
]
print("\nШАР-КОНФЛІКТИ")
for sec, a, b in SUBS:
    d = tr.get(sec) or {}
    n = 0
    for k, v in list(d.items()):
        if isinstance(v, str) and a in v:
            new = v.replace(a, b)
            print(f"  [{sec}] {str(k)[:46]!r}\n     - {v[:62]}\n     + {new[:62]}")
            if APPLY:
                d[k] = new
            n += 1
    if not n:
        print(f"  !! [{sec}] {a!r} не знайдено")

if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("\ntranslations.json записано")
