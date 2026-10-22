# -*- coding: utf-8 -*-
"""Батчі НЕПЕРЕКЛАДЕНИХ предметів ОДНОГО доповнення (ExpansionID), усі типи.
Для хронологічного перекладу: Classic(0) -> TBC(1) -> ... -> Midnight(11).

Вихід: data/exp_batches/batch_NNN.json {en:{de,fr,flavor?}}
Переклад -> out_NNN.json {en:{name,flavor?}} -> merge_item_batches.py --dir exp_batches
"""
import json
import csv
import glob
import os
import argparse

from common import DATA_DIR

OUT = DATA_DIR / "exp_batches"
BATCH = 80


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--exp", required=True,
                    help="ExpansionID або кілька через кому (0=Classic, ... 11=Midnight, -3=Special)")
    args = ap.parse_args()
    csv.field_size_limit(10 ** 7)
    exps = {x.strip() for x in args.exp.split(",")}

    ids = {}
    with open(DATA_DIR / "wago" / "ItemSparse.enUS.latest.csv", encoding="utf-8") as fh:
        for row in csv.DictReader(fh):
            if row.get("ExpansionID") in exps and (row.get("Display_lang") or "").strip():
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
    print(f"ExpansionID {args.exp}: неперекладених {len(items)} | батчів по {BATCH}: {n} -> {OUT}")


if __name__ == "__main__":
    main()
