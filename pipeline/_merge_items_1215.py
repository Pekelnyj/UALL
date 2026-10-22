# -*- coding: utf-8 -*-
"""Злити хвилю назв предметів 12.1.5 у translations.json (itemNames/itemFlavors).

Чому не merge_item_batches.py: той бере англійський ТЕКСТ флейвору з
data/source/items.json, а предметів патчу 12.1.5 там ще немає взагалі — тож усі
245 перекладених флейворів тихо зникли б. Тут англійський флейвор береться з
самої черги (ictx_*.json), де його й клали.

Перевірки (рядок, що не пройшов, НЕ йде в базу, причина — у звіті):
  • ключа немає в черзі;
  • переклад порожній або без кирилиці;
  • російські літери ы/ъ/э/ё;
  • переклад дослівно дорівнює англійському ключу;
  • флейвор, для якого в базі вже є інший переклад (не перезаписуємо).

Запуск: python _merge_items_1215.py [--apply]
Далі:   гейти + python generate_db.py
"""
import io
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
B = DATA_DIR / "batches" / "items1215"
P = DATA_DIR / "translations.json"
CYR = re.compile("[А-Яа-яІіЇїЄєҐґ]")
RUS = re.compile("[ыъэёЫЪЭЁ]")

queue = {}
for f in sorted(B.glob("ictx_*.json")):
    for it in json.loads(f.read_text(encoding="utf-8")):
        queue[it["en"]] = it

tr = json.loads(P.read_text(encoding="utf-8-sig"))
names = tr.setdefault("itemNames", {})
flavors = tr.setdefault("itemFlavors", {})

add_n = add_f = 0
rej = []
for f in sorted(B.glob("out_ictx_*.json")):
    data = json.loads(f.read_text(encoding="utf-8-sig"))
    for en, v in data.items():
        it = queue.get(en)
        if it is None:
            rej.append((f.name, "нема в черзі", en))
            continue
        ua = (v.get("name") if isinstance(v, dict) else v) or ""
        ua = ua.strip()
        if not ua or not CYR.search(ua):
            rej.append((f.name, "порожнє/без кирилиці", en))
            continue
        if RUS.search(ua):
            rej.append((f.name, "російські літери", en))
            continue
        if ua == en:
            rej.append((f.name, "переклад = оригінал", en))
            continue
        if APPLY:
            names[en] = ua
        add_n += 1

        fl_ua = ((v.get("flavor") if isinstance(v, dict) else None) or "").strip()
        fl_en = (it.get("flavor") or "").strip()
        if not fl_ua or not fl_en:
            continue
        if not CYR.search(fl_ua) or RUS.search(fl_ua):
            rej.append((f.name, "флейвор без кирилиці/з рос. літерами", en))
            continue
        if fl_en in flavors and flavors[fl_en] != fl_ua:
            rej.append((f.name, "флейвор уже перекладено інакше", en))
            continue
        if APPLY:
            flavors[fl_en] = fl_ua
        add_f += 1

print(f"назв: {add_n} | флейворів: {add_f} | відхилено: {len(rej)}")
for fn, why, en in rej[:20]:
    print(f"   {fn}: {why} -> «{en}»")
print(f"стане в базі: назв {len(names) + (0 if APPLY else add_n)}, "
      f"флейворів {len(flavors) + (0 if APPLY else add_f)}")
if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("translations.json записано")
