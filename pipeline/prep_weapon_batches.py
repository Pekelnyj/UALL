# -*- coding: utf-8 -*-
"""Батчі НАЗВ ЗБРОЇ (+flavor) на переклад. Слоти зброї за ItemSparse InventoryType.

Слоти: 13(1H) 17(2H) 15(лук) 26(рушниця/паличка/арбалет) 21(осн.рука)
       22(друга рука) 25(метальна). Тільки ще не перекладені (нема в itemNames).
Дедуп за EN-назвою. Формат як у item_batches (de/fr/flavor) — той самий промпт.

Вихід: data/weapon_batches/batch_NN.json {en: {de, fr, flavor:{en,de,fr}}}
Переклад -> out_NN.json {en:{name,flavor}} -> merge_item_batches.py --dir weapon_batches
"""
import json
import csv
import glob
import os

from common import DATA_DIR

WEAPON_SLOTS = {"13", "17", "15", "26", "21", "22", "25"}
OUT = DATA_DIR / "weapon_batches"
BATCH = 80
# 2H перші (користувач просив почати з них), далі решта
SLOT_ORDER = {"17": 0, "13": 1, "26": 2, "15": 3, "21": 4, "25": 5, "22": 6}


def main():
    csv.field_size_limit(10 ** 7)
    # itemID -> slot (тільки зброя)
    wslot = {}
    with open(DATA_DIR / "wago" / "ItemSparse.enUS.latest.csv", encoding="utf-8") as fh:
        for row in csv.DictReader(fh):
            it = row.get("InventoryType")
            if it in WEAPON_SLOTS and (row.get("Display_lang") or "").strip():
                wslot[row["ID"]] = it

    src = json.loads((DATA_DIR / "source" / "items.json").read_text(encoding="utf-8-sig"))
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    names = tr.get("itemNames", {})

    seen = set()
    items = []  # (slot_order, en, entry)
    for iid, slot in wslot.items():
        e = src.get(iid)
        if not e:
            continue
        en = (e.get("name") or {}).get("en")
        if not en or en in names or en in seen:
            continue
        seen.add(en)
        entry = {"de": (e.get("name") or {}).get("de"),
                 "fr": (e.get("name") or {}).get("fr")}
        if e.get("flavor"):
            entry["flavor"] = e["flavor"]
        items.append((SLOT_ORDER.get(slot, 9), en, entry))

    items.sort(key=lambda x: (x[0], x[1]))  # 2H перші, тоді за назвою

    OUT.mkdir(parents=True, exist_ok=True)
    for old in glob.glob(str(OUT / "*.json")):
        os.remove(old)
    n = 0
    for i in range(0, len(items), BATCH):
        n += 1
        chunk = {en: entry for _, en, entry in items[i:i + BATCH]}
        (OUT / f"batch_{n:02d}.json").write_text(
            json.dumps(chunk, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Неперекладених назв зброї: {len(items)} | батчів по {BATCH}: {n} -> {OUT}")
    print("(2H — у перших батчах, як просив користувач)")


if __name__ == "__main__":
    main()
