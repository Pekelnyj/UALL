# -*- coding: utf-8 -*-
"""Злити батчі uitooltip (out_ut_*.json {en:ua}) у translations.uiTooltips.

Пара до _prep_uitt_wave.py. Раніше цей бакет ішов через
batches/uitt_out.json і _merge_captured_wave.py, де змішувався зі збором
істот; тут — окремо й із тими самими перевірками, що в інших хвиль:
кирилиця обов'язкова, ключі байт-у-байт, {NAME} не губиться.

НЕБЕЗПЕКА, через яку тут з'явилася чернетка. Скрипт бере ВСІ файли
out_ut_*.json у теці, а вони там накопичуються від хвилі до хвилі. 28.08.2026
я запустив його по свіжій хвилі — і разом із 105 новими рядками він залив
назад 112 старих, серед яких були підміни, вичищені того ж ранку:
«Warlock - Demonology» знову став «Генератор вирмодір». Гейт показав 29
підмін замість 2, довелося відкочувати з коміту.

Тому:
  • без --apply нічого не пишеться;
  • відпрацьовані відповіді ПРИБИРАТИ з теки (data/batches/_uitt_old/).

Запуск: python _merge_uitt_wave.py [--apply]
Далі: python generate_db.py && python _check_kv_shift.py
"""
import glob
import io
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv

CYR = re.compile("[Ѐ-ӿ]")
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
ui = tr.setdefault("uiTooltips", {})
add = skip = lost = 0
for f in sorted(glob.glob(str(DATA_DIR / "batches" / "uitooltip" / "out_ut_*.json"))):
    for en, ua in json.loads(open(f, encoding="utf-8-sig").read()).items():
        if not (isinstance(ua, str) and ua.strip() and CYR.search(ua)):
            skip += 1
            continue
        if "{NAME}" in en and "{NAME}" not in ua:
            print(f"  ВТРАЧЕНО {{NAME}}: {en[:60]!r}")
            lost += 1
            continue
        if ui.get(en) != ua:
            ui[en] = ua
            add += 1
        else:
            skip += 1
print(f"uiTooltips {'злито' if APPLY else 'ЗЛИЛОСЯ Б'}: {add} | "
      f"пропущено: {skip} | втрат {{NAME}}: {lost} | разом: {len(ui)}")
# ЗАПИС ПІД ЗАСЛОНОМ. Змінна APPLY тут була оголошена й НІКОДИ не перевірена —
# запис відбувався завжди. Тобто запобіжник, доданий саме після інциденту
# 28.08 (див. шапку файлу), не працював жодного разу: достатньо було
# запустити скрипт «подивитися», щоб залити застарілі out-файли в базу.
if not APPLY:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("translations.json записано")
