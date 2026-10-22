# -*- coding: utf-8 -*-
"""Зняти з бази підміни, які знайшов _check_kv_shift.py.

Знімаємо ЛИШЕ доказову частину — пари, де переклад у рази довший за власний
оригінал. Ключ у цих секціях і є англійський текст, тож «Tort Jaw» (8 симв.)
не може мати перекладу на 105 символів: це тіло від іншого рядка.

Числові влучання гейта сюди НЕ входять — серед них бувають цілком правильні
переклади, з яких просто випали цифри. Їх скрипт лише перелічує: вирок за
людиною.

Втрати перекладу тут немає. Знятий англійський ключ повертається в чергу
сам: `_prep_uitt_wave.py` бере зі збору те, чого немає в базі, тож рядок
поїде наступною хвилею й отримає СВІЙ переклад.

Запуск: python _drop_kv_shift.py [--apply]
Далі: python generate_db.py && python _check_kv_shift.py
"""
import io
import json
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from _check_kv_shift import MIN_LEN, RATIO, SECTIONS, SLACK, ua_of, unwrap

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))

# Гейт помітив їх лише за числами, тож автоматично вони не знімаються — але
# звірка очима показала те саме чуже тіло, що й у решти. Тримаємо іменний
# список, щоб рішення було видно, а не сховане в порозі.
# Ключі беремо з бази за ПОЧАТКОМ рядка: повний текст сюди не переписуємо,
# бо він мусить збігатися байт-у-байт, а переписаний з очей — не збігається.
REVIEWED = [
    # -> «Перемикає значки мапи й завдань…»
    ("uiTooltips", "At least 16 out of 20 players in your group are members of"),
    # -> «Смолоскип ельфа Порожнечі (декор житла)»
    ("uiTooltips", "Use: Drink to increase your primary stat by 695 for 30 sec"),
    # 27.08: нагороди перегонів на драконах («…: золото») розповзлися по
    # чужих ключах. Підказка порталу не може казати «Випробування
    # Тіргольда: золото» — доказ не потребує порогів.
    ("uiTooltips", "Time-Portal to Eon's Fringe"),
    ("uiTooltips", "Time-Portal to Everywhere Inn"),
    ("uiTooltips", "Time-Portal to Feralas"),
    ("uiTooltips", "Time-Portal to Lordaeron"),
    ("uiTooltips", "Vilescale Warrior"),
    # «Ілва» — це переклад ключа «Ylva»; сюди він потрапив як чуже тіло.
    ("uiTooltips", "Warmother Captive"),
    # 28.08: те саме гніздо «Time-Portal to …», ще чотири. Довжини тут
    # співмірні, тож поріг їх не бачив — знайшов перекладач очима.
    # ВАЖЛИВО: підмінений запис виглядає ПЕРЕКЛАДЕНИМ, тож дедуп його
    # пропускає і в чергу він не повертається. Тільки зняття повертає
    # рядок у роботу — саме тому раніше зняті «портали» вже перекладено,
    # а ці чотири стояли зіпсованими далі.
    ("uiTooltips", "Time-Portal to Dalaran"),
    ("uiTooltips", "Time-Portal to Dun Algaz"),
    ("uiTooltips", "Time-Portal to Stormwind"),
    ("uiTooltips", "Time-Portal to Tiragarde Sound"),
]

drop = []
for sec in SECTIONS:
    d = tr.get(sec)
    if not isinstance(d, dict):
        continue
    for k, v in d.items():
        u = ua_of(v)
        if not u or len(u) <= MIN_LEN:
            continue
        en, ua = len(unwrap(k)), len(u)
        if ua > en * RATIO + SLACK:
            drop.append((sec, k, u, ua / en))

seen = {(s, k) for s, k, _u, _r in drop}
for sec, pref in REVIEWED:
    d = tr.get(sec) or {}
    hits = [k for k in d if k.startswith(pref)]
    if not hits:
        print(f"  ? звірене вручну вже знято: {pref[:50]!r}")
    for k in hits:
        if (sec, k) not in seen:
            drop.append((sec, k, ua_of(d[k]), 0.0))

drop.sort(key=lambda x: -x[3])
print(f"доказових підмін: {len(drop)}\n")
for sec, k, u, r in drop:
    print(f"  [{sec}] {k[:56]!r}   (у {r:.1f} раза довше)")
    print(f"      знімаю: {u[:66]!r}")

if APPLY:
    for sec, k, _u, _r in drop:
        del tr[sec][k]
    io.open(P, "w", encoding="utf-8", newline="\n").write(
        json.dumps(tr, ensure_ascii=False, indent=1))
    print(f"\nзнято {len(drop)}; translations.json записано")
else:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
