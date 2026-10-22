# -*- coding: utf-8 -*-
"""Батчі НЕперекладеного флейвору предметів (УНІКАЛЬНІ рядки).

Вихід: data/flavor_batches/batch_NNN.json {en_flavor: {de, fr}}
Переклад -> out_NNN.json {en_flavor: ua} -> merge_flavor_batches.py
"""
import json
import glob
import os

from common import DATA_DIR

OUT = DATA_DIR / "flavor_batches"
BATCH = 80


def main():
    src = json.loads((DATA_DIR / "source" / "items.json").read_text(encoding="utf-8-sig"))
    fl = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig")).get("itemFlavors", {})

    seen = {}
    for e in src.values():
        f = e.get("flavor") or {}
        en = f.get("en")
        if not en or en in fl or en in seen:
            continue
        seen[en] = {"de": f.get("de"), "fr": f.get("fr")}

    items = sorted(seen.items())
    OUT.mkdir(parents=True, exist_ok=True)
    for old in glob.glob(str(OUT / "*.json")):
        os.remove(old)
    n = 0
    for i in range(0, len(items), BATCH):
        n += 1
        (OUT / f"batch_{n:03d}.json").write_text(
            json.dumps(dict(items[i:i + BATCH]), ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Унікальних неперекл. флейворів: {len(items)} | батчів по {BATCH}: {n} -> {OUT}")


if __name__ == "__main__":
    main()
