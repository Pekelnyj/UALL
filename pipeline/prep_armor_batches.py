# -*- coding: utf-8 -*-
"""Батчі НАЗВ БРОНІ (+flavor) на переклад, по слоту (ItemSparse InventoryType).
Слоти: 1 голова, 3 плечі, 5/20 груди, 6 пояс, 7 ноги, 8 стопи, 9 зап'ястки,
       10 кисті, 11 палець, 16 спина, 2 шия, 14 щит, 23 тримана, 19 табард, 4 сорочка.
Тільки ще не перекладені (нема в itemNames). Дедуп за EN. Формат як item_batches.

Вихід: data/armor_batches/batch_NN.json {en:{de,fr,flavor?}}
"""
import json
import csv
import glob
import os
import argparse

from common import DATA_DIR

OUT = DATA_DIR / "armor_batches"
BATCH = 80


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--slot", default="7", help="InventoryType (7=ноги)")
    args = ap.parse_args()
    csv.field_size_limit(10 ** 7)

    ids = {}
    with open(DATA_DIR / "wago" / "ItemSparse.enUS.latest.csv", encoding="utf-8") as fh:
        for row in csv.DictReader(fh):
            if row.get("InventoryType") == args.slot and (row.get("Display_lang") or "").strip():
                ids[row["ID"]] = True

    src = json.loads((DATA_DIR / "source" / "items.json").read_text(encoding="utf-8-sig"))
    names = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig")).get("itemNames", {})

    seen = set()
    items = []
    for iid in ids:
        e = src.get(iid)
        if not e:
            continue
        en = (e.get("name") or {}).get("en")
        if not en or en in names or en in seen:
            continue
        seen.add(en)
        entry = {"de": (e.get("name") or {}).get("de"), "fr": (e.get("name") or {}).get("fr")}
        if e.get("flavor"):
            entry["flavor"] = e["flavor"]
        items.append((en, entry))

    items.sort()
    OUT.mkdir(parents=True, exist_ok=True)
    for old in glob.glob(str(OUT / "*.json")):
        os.remove(old)
    n = 0
    for i in range(0, len(items), BATCH):
        n += 1
        (OUT / f"batch_{n:03d}.json").write_text(
            json.dumps(dict(items[i:i + BATCH]), ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Слот {args.slot}: неперекладених назв {len(items)} | батчів по {BATCH}: {n} -> {OUT}")


if __name__ == "__main__":
    main()
