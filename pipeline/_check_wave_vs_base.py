# -*- coding: utf-8 -*-
"""ГЕЙТ: чи не розійшлася нова хвиля з уже наявними назвами в базі.

Типова поломка. У базі є квест «Prey: Ranger Swiftglade» -> «Здобич:
Лісничий Швидкогай». Нова хвиля перекладає ціль трекера «Ranger Swiftglade
slain» -> «Убито рейнджера Швидколіса». Обидва рядки правильні окремо, але
гравець бачить в одному вікні «Лісничий Швидкогай», а в іншому «рейнджер
Швидколіс» — і не знаходить NPC [[base-contradicts-itself-across-layers]].

Метод. Беремо ВЛАСНІ назви з англійських ключів хвилі (два-три слова з
великої літери), знаходимо для кожної вже наявний переклад у базі за
англійським якорем, і порівнюємо КОРЕНІ українських слів. Коріння, а не
цілі слова: відмінок відрізнятиметься законно («Лісничого» проти
«Лісничий»), а от інший корінь — це вже різна назва.

Запуск: python _check_wave_vs_base.py [тека-батчів ...]
"""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

SUBS = sys.argv[1:] or ["gossip", "broadcast", "objlines", "uitooltip",
                        "profui", "profdesc", "qcap"]

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
qsrc = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))

# EN -> набір UA з БАЗИ (назви квестів за ID + усі рядкові ключі)
base = {}


def add(en, ua):
    if en and isinstance(ua, str):
        base.setdefault(en, set()).add(ua)


for qid, v in qsrc.items():
    if isinstance(v, dict):
        add((v.get("title") or {}).get("en"),
            (tr.get("quests", {}).get(qid) or {}).get("title"))
for sec, d in tr.items():
    if isinstance(d, dict):
        for k, v in d.items():
            if isinstance(k, str) and isinstance(v, str):
                add(k, v)

# власна назва: 2+ слів із великої (щоб не ловити початок речення)
NAME = re.compile(r"\b([A-Z][a-z']+(?:\s+(?:the\s+)?[A-Z][a-z']+)+)\b")
CYR = re.compile(r"[А-Яа-яЇїІіЄєҐґ']{4,}")


def roots(text):
    """Корені українських слів: відтинаємо típові закінчення."""
    out = set()
    for w in CYR.findall(text):
        w = w.lower()
        for suf in ("ього", "ому", "ами", "ів", "ом", "ої", "ий", "а", "у",
                    "и", "е", "і", "о", "я", "ю"):
            if w.endswith(suf) and len(w) - len(suf) >= 4:
                w = w[:-len(suf)]
                break
        out.add(w[:6])
    return out


bad = []
for sub in SUBS:
    d = DATA_DIR / "batches" / sub
    if not d.exists():
        continue
    for f in sorted(d.glob("out_*.json")):
        try:
            data = json.loads(f.read_text(encoding="utf-8"))
        except Exception:
            continue
        pairs = (data.items() if isinstance(data, dict)
                 else [(r.get("qid", ""), v) for r in data
                       for v in (r.get("fields") or {}).values()])
        for en, ua in pairs:
            if not (isinstance(en, str) and isinstance(ua, str)):
                continue
            # Перевіряємо лише КОРОТКІ рядки, де назва і є весь зміст
            # («Ranger Swiftglade slain»). У довгому описі назва законно
            # перефразовується або згадується побіжно, і порівняння коренів
            # там дає суцільні хибні спрацювання.
            if len(en) > 60:
                continue
            for nm in NAME.findall(en):
                have = base.get(nm)
                if not have:
                    continue
                known = set()
                for h in have:
                    known |= roots(h)
                mine = roots(ua)
                # хоч один спільний корінь -> вважаємо, що назва та сама
                if known and mine and not (known & mine):
                    bad.append((sub, nm, sorted(have)[0], ua))

seen = set()
for sub, nm, was, now in bad:
    key = (nm, was)
    if key in seen:
        continue
    seen.add(key)
    print(f"  [{sub}] «{nm}»\n      у базі: {was[:70]!r}\n      у хвилі: {now[:70]!r}")
print(f"\nрозбіжностей назв: {len(seen)}")
sys.exit(1 if seen else 0)
