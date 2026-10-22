# -*- coding: utf-8 -*-
"""Прибрати з бази НАЗВИ КЛАВІШ-МОДИФІКАТОРІВ, перекладені як звичайні слова.

«Shift» -> «Зсув» виліз у дропдауні наших-таки налаштувань («Клавіша показу
оригіналу»): гравець має побачити напис на своїй клавіатурі, а не переклад
слова. Видалення ключа = рядок лишається англійським, що тут і потрібно.

ОБЕРЕЖНО З ОБСЯГОМ. Перша версія брала широкий список клавіш (Tab, Enter,
Escape, Delete…) по ВСІХ секціях — і знесла законне: globalStrings «Delete» =
«Видалити» (кнопка інтерфейсу) і journalSections «Escape» = «Втеча» (назва
здібності боса). Тому тут лише модифікатори й лише ті секції, де рядок
справді може бути підписом клавіші.

Запуск: python _drop_key_names.py [--apply]
Далі:   python generate_db.py
"""
import io
import json
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
KEYS = {"Shift", "Ctrl", "Control", "Alt"}
SECTIONS = ("uiTooltips", "uiStrings", "uiMisc")
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))

dropped = []
for sec in SECTIONS:
    d = tr.get(sec)
    if not isinstance(d, dict):
        continue
    for k in list(d):
        if k in KEYS and isinstance(d[k], str):
            dropped.append((sec, k, d[k]))
            if APPLY:
                del d[k]

for sec, k, v in dropped:
    print(f"{sec}: «{k}» -> «{v}»")
print(f"прибрано: {len(dropped)}")
if not APPLY:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("translations.json записано")
