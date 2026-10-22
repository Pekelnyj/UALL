# -*- coding: utf-8 -*-
"""Черга НОВИХ назв предметів патчу 12.1.5 з пакетом доказів для агента.

Чому не prep_item_batches.py: той бере предмети Midnight із data/source/items.json,
а тут джерело — свіжий ItemSparse із wago для білда 12.1.5.70391, якого в нашому
датамайні ще немає взагалі.

Для кожної назви кладемо:
  de / fr      — локалізації Blizzard (рід, зміст гри слів, що саме за предмет);
  flavor       — англійський флейвор-текст, якщо є (контекст назви);
  examples     — до 4 УЖЕ перекладених назв предметів, що містять те саме
                 значуще слово («EN -> UA»), щоб нове лягло в один ряд зі старим.

Рахуємо за УНІКАЛЬНИМИ НАЗВАМИ, не за ID: у ItemSparse 175 тис. ID на 139 тис.
назв [[count-unique-texts-not-ids]].

Запуск: python _prep_items_1215.py --src <тека з CSV> [--parts 12] [--take 1200]
Вихід:  data/batches/items1215/ictx_NN.json
Злиття: merge_item_batches.py читає out_*.json {en: {name, flavor}}
"""
import csv
import json
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
csv.field_size_limit(20_000_000)
from common import DATA_DIR


def opt(flag, default):
    return type(default)(sys.argv[sys.argv.index(flag) + 1]) if flag in sys.argv else default


SRC = Path(opt("--src", ""))
PARTS, TAKE = opt("--parts", 12), opt("--take", 1200)
OUT = DATA_DIR / "batches" / "items1215"

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
done = tr.get("itemNames") or {}
flavors_done = tr.get("itemFlavors") or {}

JUNK = re.compile(r"\[PH\]|\[DNT\]|DEPRECATED|UNUSED|^Test |^QA |NYI|PH -|TEMP", re.I)


def load(path, want_desc=False):
    out, desc = {}, {}
    with open(path, encoding="utf-8", newline="") as f:
        rd = csv.DictReader(f)
        c = next(x for x in rd.fieldnames if x.startswith("Display_lang"))
        d = next((x for x in rd.fieldnames if x.startswith("Description_lang")), None)
        for r in rd:
            v = (r.get(c) or "").strip()
            if v:
                out[r["ID"]] = v
                if want_desc and d:
                    t = (r.get(d) or "").strip()
                    if t:
                        desc[r["ID"]] = t
    return out, desc


en, flav = load(SRC / "it70391.csv", True)
de, _ = load(SRC / "it_de.csv")
fr, _ = load(SRC / "it_fr.csv")
print(f"ItemSparse: en {len(en)} ID | de {len(de)} | fr {len(fr)}")

# унікальні назви без перекладу й без службових
first_id = {}
for i, n in en.items():
    if n not in done and not JUNK.search(n):
        first_id.setdefault(n, i)
queue = sorted(first_id)
print(f"унікальних назв без перекладу: {len(queue)}")

# слово -> приклади вже перекладених назв
STOP = {"of", "the", "and", "a", "an", "to", "in", "on", "from", "with", "for"}
by_word = defaultdict(list)
for e, u in done.items():
    if not isinstance(u, str):
        continue
    for w in re.findall(r"[A-Za-z']{4,}", e):
        wl = w.lower()
        if wl not in STOP and len(by_word[wl]) < 400:
            by_word[wl].append((e, u))

OUT.mkdir(parents=True, exist_ok=True)
for f in OUT.glob("ictx_*.json"):
    f.unlink()

items = queue[:TAKE]
size = (len(items) + PARTS - 1) // PARTS
for p in range(PARTS):
    chunk = items[p * size:(p + 1) * size]
    if not chunk:
        continue
    rows = []
    for n in chunk:
        i = first_id[n]
        row = {"en": n}
        if de.get(i):
            row["de"] = de[i]
        if fr.get(i):
            row["fr"] = fr[i]
        if flav.get(i):
            row["flavor"] = flav[i]
            if flavors_done.get(flav[i]):
                row["flavor_ua"] = flavors_done[flav[i]]
        ex = []
        seen = set()
        for w in re.findall(r"[A-Za-z']{4,}", n):
            wl = w.lower()
            if wl in STOP or wl in seen:
                continue
            seen.add(wl)
            pool = by_word.get(wl) or []
            if pool:
                # Поле «dominant» тут було ОМАНОЮ: воно показувало найчастіше
                # ПОВНЕ ім'я серед прикладів, а не найчастіший переклад САМЕ
                # цього слова — агент хвилі 14.10 слушно написав, що «dominant
                # часто бреше», і рахував по базі сам. Краще не давати поля,
                # ніж давати хибне: лишаємо приклади й лічильник.
                ex.append({"word": w, "total": len(pool),
                           "examples": [f"{e} -> {u}" for e, u in pool[:4]]})
        if ex:
            row["word_examples"] = ex
        rows.append(row)
    path = OUT / f"ictx_{p:02d}.json"
    path.write_text(json.dumps(rows, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"  {path.name}: назв {len(rows)}, зі словами-доказами "
          f"{sum(1 for r in rows if r.get('word_examples'))}, "
          f"з флейвором {sum(1 for r in rows if r.get('flavor'))}, "
          f"{path.stat().st_size // 1024} КБ")
