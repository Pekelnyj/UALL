# -*- coding: utf-8 -*-
"""Батчі ПОРАД екрану завантаження (GameTips) для перекладу, з en/de/fr.

Вихід: data/gametips_batches/batch_NN.json {en_текст: {de, fr}}
Переклад -> out_NN.json {en: ua} -> merge у translations.json["gameTips"].
"""
import json
import csv
import glob
import os

from common import DATA_DIR

OUT = DATA_DIR / "gametips_batches"
BATCH = 38


def _load(lang):
    csv.field_size_limit(10 ** 7)
    m = {}
    with open(DATA_DIR / "wago" / f"GameTips.{lang}.latest.csv", encoding="utf-8") as fh:
        for row in csv.DictReader(fh):
            m[row["ID"]] = (row.get("Text_lang") or "").strip()
    return m


def main():
    en, de, fr = _load("enUS"), _load("deDE"), _load("frFR")
    items = {}
    for iid, t in en.items():
        if t:
            items[t] = {"de": de.get(iid, ""), "fr": fr.get(iid, "")}

    pairs = sorted(items.items())
    OUT.mkdir(parents=True, exist_ok=True)
    for old in glob.glob(str(OUT / "*.json")):
        os.remove(old)
    n = 0
    for i in range(0, len(pairs), BATCH):
        n += 1
        (OUT / f"batch_{n:02d}.json").write_text(
            json.dumps(dict(pairs[i:i + BATCH]), ensure_ascii=False, indent=1), encoding="utf-8")
    words = sum(len(t.split()) for t in items)
    print(f"Порад: {len(items)} (~{words} слів) | батчів по {BATCH}: {n} -> {OUT}")


if __name__ == "__main__":
    main()
