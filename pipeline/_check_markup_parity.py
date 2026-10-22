# -*- coding: utf-8 -*-
"""ГЕЙТ: переклад не від того ключа — за слідом розмітки й чисел.

18.10.2026. Агент хвилі натрапив на пару
    ["Use: Submit the Relic Fragments to Archivist Roh-Suir…"] = "Бойова
    барабанщиця Зурула"
і виявилось, що в `uiTooltips` зсунуто цілий масив: значення належать ключам,
які стоять далі в АЛФАВІТНОМУ списку. Доказ, що це зсув, а не поганий
переклад: правильний текст теж у базі, лише під чужим ключем —
    ["Tricks and Treats of the Dragon Isles"] = "Застосування: |n|n Ситість|n…"
(це переклад ключа «Use: |n|n Well Fed|n…», що лежить на 30 рядків нижче).

Чому наявний `_check_kv_shift.py` цього не бачив: він шукає РОДИНИ з однаковим
англійським початком, а тут ключі різні, і єдине, що їх викриває — слід самого
рядка. Беремо те, що переклад МУСИТЬ зберігати:

  * розмітка: |n |cXXXXXXXX |r |T…|t |A…|a, підстановки %s %d {NAME};
  * числа: 165, 10, 308-321 — переклад їх не вигадує і не губить;
  * форма «Зона, Підзона»: кома й дві частини з великої.

Рядок, у якому КЛЮЧ має такий слід, а переклад — ні (або інший), перекладом
цього ключа бути не може. Це високоточний критерій: звичайний поганий переклад
розмітку й числа зберігає.

Запуск: python _check_markup_parity.py [--section uiTooltips] [--list]
"""
import json
import re
import sys
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

ARG = sys.argv[1:]
ONLY = ARG[ARG.index("--section") + 1] if "--section" in ARG else None
LIST = "--list" in ARG

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))

MARK = re.compile(r"\|n|\|c[0-9A-Fa-f]{8}|\|r|\|T[^|]*\|t|\|A[^|]*\|a"
                  r"|%[0-9$]*[sdf]|\{NAME\}|\{name\}")
NUM = re.compile(r"\d+")
# службові секції, де ключ — ID, а не текст: порівнювати нема з чим
SKIP_SEC = {"npcNames", "quests", "spells", "items", "itemNames", "itemFlavors",
            "achievements", "journal", "journalSections", "subnames"}

bad = Counter()
rows = []
for sec, d in tr.items():
    if not isinstance(d, dict) or (ONLY and sec != ONLY) or sec in SKIP_SEC:
        continue
    for k, v in d.items():
        if not isinstance(k, str) or not isinstance(v, str) or not v:
            continue
        if not re.search("[А-Яа-яІіЇїЄєҐґ]", v):
            continue
        # КЛЮЧ-ІДЕНТИФІКАТОР. У частині секцій ключ — це ID (itemSets, currencies,
        # instanceDesc), і тоді «числа в ключі, яких немає в перекладі» — не
        # дефект, а сама будова секції. Перша версія гейта через це дала 1 335
        # фальшивок із 1 722.
        if k.isdigit():
            continue
        km, vm = sorted(MARK.findall(k)), sorted(MARK.findall(v))
        kn, vn = sorted(NUM.findall(k)), sorted(NUM.findall(v))
        why = None
        if km != vm:
            why = "розмітка"
        elif kn and vn and kn != vn:
            # ОБИДВІ сторони мають числа, але різні — це вже не «переклад
            # словом» («Tier One» -> «1-го рівня»), а чужий рядок.
            why = "числа"
        if why:
            bad[(sec, why)] += 1
            rows.append((sec, why, k, v))

print("ПАРИ, ДЕ ПЕРЕКЛАД НЕ ВІД ЦЬОГО КЛЮЧА")
for (sec, why), n in bad.most_common():
    print(f"  {sec+'/'+why:<34}{n:>6}")
print(f"  {'РАЗОМ':<22}{sum(bad.values()):>6}")

if LIST:
    print()
    for sec, why, k, v in rows:
        print(f"  [{sec}/{why}] {k[:70]!r}\n       = {v[:70]!r}")
sys.exit(1 if rows else 0)
