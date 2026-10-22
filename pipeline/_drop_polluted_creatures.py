# -*- coding: utf-8 -*-
"""Прибрати з creatures.json записи, що насправді є іменами гравців.

Збір імен з плашок (extract_capture_creatures.py) не розрізняв істот і людей,
тож у ДАТАМАЙН потрапили ніки. Шкода не в самих рядках, а в тому, що
creatures.json служить ЗАСЛОНОМ у всіх відсівах: «слово є іменем істоти —
не чіпати». Занесений туди нік вигороджує сам себе, і будь-яка звірка проти
цього файлу стає коловою — саме на цьому спіткнувся один з агентів, коли
«підтвердив», що <нік> є NPC, звірившись із тим самим файлом.

ДОКАЗ (обидва боки незалежні від creatures.json):
  * назва збігається з ніком із meta.playerName або зі збору за суфіксом
    реалму («Ім'я-Реалм» у капчах);
  * запис ГОЛИЙ — лише name.en, без de/fr і без інших полів, тоді як
    справжня істота має локалізації або згадки в квестах.

Причину залатано в extract_capture_creatures.py (відсів ніків перед додаванням).

Запуск: python _drop_polluted_creatures.py [--apply]
"""
import io
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import known_nicks

APPLY = "--apply" in sys.argv
P = DATA_DIR / "source" / "creatures.json"
cr = json.loads(P.read_text(encoding="utf-8-sig"))
nicks = known_nicks(min_len=3, drop_ambiguous=False)

drop = []
for cid, v in list(cr.items()):
    if not isinstance(v, dict):
        continue
    nm = v.get("name")
    if not isinstance(nm, dict):
        continue
    en = nm.get("en")
    # Нік буває й УСЕРЕДИНІ назви: «<нік>'s Body» — труп гравця, і
    # точний збіг такого не ловить.
    # Перевіряємо ПЕРЕТИНОМ СЛІВ, а не регексом на кожен нік: ніків ~4500,
    # істот ~34000, і 153 млн пошуків не добігають за десять хвилин.
    # Межі слова дає сам розбір на слова — підрядок без меж ловив би
    # «Rea» усередині «Great».
    if not isinstance(en, str):
        continue
    _w = set(re.findall(r"[A-Za-zÀ-ÿ']{4,}", en))
    _w |= {x[:-2] for x in _w if x.endswith("'s")}
    if en not in nicks and not (_w & nicks):
        continue
    langs = [k for k in nm if nm.get(k)]
    if langs == ["en"] and not [k for k in v if k != "name"]:
        drop.append((cid, en))

print(f"записів у creatures.json: {len(cr)}")
print(f"на зняття (нік + голий запис): {len(drop)}")
for cid, en in drop:
    print(f"  id {cid}: «{en}»")

if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
for cid, _en in drop:
    del cr[cid]
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(cr, ensure_ascii=False, indent=2))
print(f"\nзнято {len(drop)}; лишилось {len(cr)}")
