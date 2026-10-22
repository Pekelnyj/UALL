# -*- coding: utf-8 -*-
"""Зул'джарра говорить про себе в чоловічому роді — виправити ТОЧКОВО.

Вона жінка (журнал рейду: «Unable to defend herself… her burden»), але дві її
репліки в базі чоловічі. Шкода не лише в цих рядках: пакет доказів подає
speaker_lines наступним хвилям, і 14.10 один з агентів чесно скопіював із них
чоловічий рід — помилка почала розмножуватися.

ЧОМУ ТОЧКОВО, А НЕ СВІПОМ. Автоматичний пошук «усе на -в/-ів» у її 221 репліці
дав 5 влучань, із яких 3 ХИБНІ: «хай речник лоа сам тобі скаже» (чоловік-
речник), «мій дух готовий» (чоловічий іменник), «хіба ти не радий» (звернення
до Зул'джана). Сліпа заміна зіпсувала б усі три [[term-rename-spread-and-gender]].

Запуск: python _fix_zuljarra_gender.py [--apply]
Далі:   python _sync_broadcast_master.py (якщо правили Broadcast.lua) + generate_db.py
"""
import io
import json
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
bc = tr.get("broadcast") or {}

FIXES = [
    ("But to join forces with Malacrass? Dat fool! I warned him about dat villain.",
     "Я застерігав", "Я застерігала"),
    ("While in de crypt, I noticed de Vilebranch were blinded by de mist too.",
     "Поки я був у крипті, я помітив", "Поки я була у крипті, я помітила"),
]

done = 0
for en_part, old, new in FIXES:
    keys = [k for k in bc if k.startswith(en_part)]
    if not keys:
        print(f"!! не знайдено ключа: «{en_part[:50]}…»")
        continue
    for k in keys:
        if old not in bc[k]:
            print(f"   вже виправлено або змінилося: «{k[:50]}…»")
            continue
        print(f"  - {bc[k][:120]}")
        if APPLY:
            bc[k] = bc[k].replace(old, new)
        print(f"  + {bc[k].replace(old, new)[:120] if not APPLY else bc[k][:120]}")
        done += 1

print(f"\nвиправлено реплік: {done}")
if not APPLY:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("translations.json записано")
