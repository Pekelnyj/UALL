# -*- coding: utf-8 -*-
"""ПІДОЗРИ в підказках виду «Зона, Підзона» (списки відер із цукерками).

УВАГА: гейт поки ЗМІШУЄ два класи — справжню підміну («Tirisfal Glades,
Brill» -> «Під водою») і звичайний різнобій назви зони («Dread Wastes» має
в базі і «Жахобезлюддя», і «Жахливі Пустища»). Перше лікується зняттям,
друге — свіпом. Розрізняти доводиться очима; звужувати правило далі без
повної карти зон немає сенсу.

ЧОМУ ОКРЕМИЙ ГЕЙТ. `_check_kv_shift.py` доводить підміну ДОВЖИНОЮ: переклад
у рази довший за власний оригінал. Тут довжини співмірні, тож він сліпий:
«Tirisfal Glades, Brill» -> «Під водою» проходить повз нього
[[kv-shift-substitution]].

ДОКАЗ ТУТ ІНШИЙ. Ключ називає ЗОНУ, і ця зона майже завжди вже перекладена
деінде в базі. Якщо в перекладі ключа немає ні кореня назви зони, ні коми —
значення належить не цьому ключу.

Дві перевірки, щоб не ловити назви досягнень із комою («Many Whelps, Handle
It», «Exeunt, Triumphant»): ключ мусить починатися з відомої зони.

Запуск: python _check_zone_pair_shift.py
Код виходу 1, якщо знайдено.
"""
import json
import re
import sys
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
ui = tr.get("uiTooltips") or {}

# Карта «англійська зона -> найчастіший український корінь». Будуємо з усієї
# бази: та сама зона трапляється в areaPOI, taxiNodes, quests тощо.
zone_ua = {}
for sec in ("areaPOI", "taxiNodes", "uiTooltips", "questObjectives"):
    d = tr.get(sec) or {}
    for k, v in d.items():
        if not isinstance(k, str) or not isinstance(v, str):
            continue
        if "," in k or len(k) > 40 or not re.match(r"^[A-Z][A-Za-z' ]+$", k):
            continue
        zone_ua.setdefault(k, Counter())[v] += 1

PAIR = re.compile(r"^([A-Z][A-Za-z'’ ]+), (.+)$")
bad = []
for k, v in ui.items():
    if not isinstance(k, str) or not isinstance(v, str):
        continue
    m = PAIR.match(k)
    if not m:
        continue
    zone = m.group(1).strip()
    cand = zone_ua.get(zone)
    if not cand:
        continue                     # зони не знаємо — не судимо
    # Приймаємо БУДЬ-ЯКУ відому форму зони, не лише домінанту. Інакше гейт
    # змішує два різні класи: справжню підміну і звичайний різнобій назв.
    # «Dread Wastes» має в базі і «Жахобезлюддя», і «Жахливі Пустища» —
    # друге не підміна, а розбіжність, і лікується не тут.
    roots = set()
    for ua_zone in cand:
        for w in re.findall(r"[А-Яа-яІіЇїЄєҐґ']{4,}", ua_zone):
            roots.add(w[:5])
    if not roots:
        continue
    if not any(r in v for r in roots):
        bad.append((k, v, cand.most_common(1)[0][0]))

print(f"ключів «Зона, Підзона» з відомою зоною: "
      f"{sum(1 for k in ui if PAIR.match(k) and PAIR.match(k).group(1) in zone_ua)}")
print(f"переклад НЕ містить назви зони: {len(bad)}\n")
for k, v, z in bad:
    print(f"  {k[:56]}")
    print(f"      зона мала б бути «{z}», а стоїть: {v[:52]}")
sys.exit(1 if bad else 0)
