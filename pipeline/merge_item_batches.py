"""Злиття перекладених предметів у translations.json.

Читає data/item_batches/out_NN.json:
    {"<en назва>": {"name": "укр назва", "flavor": "укр флейвор"|null}}

Зберігає у translations.json:
    itemNames:   {en назва: ua назва}
    itemFlavors: {en флейвор: ua флейвор}   (ключ — англійський ТЕКСТ флейвору)

Використання:
    python merge_item_batches.py
"""

import argparse
import json
import io

from common import DATA_DIR


def main():
    ap = argparse.ArgumentParser(description="Злиття перекладених предметів")
    ap.add_argument("--dir", default="item_batches", help="папка з батчами")
    args = ap.parse_args()
    BATCH_DIR = DATA_DIR / args.dir
    src = json.load(io.open(DATA_DIR / "source" / "items.json", encoding="utf-8-sig"))
    # en назва -> en флейвор (щоб скласти мапу флейворів за текстом)
    flavor_of_name = {}
    for e in src.values():
        en = e.get("name", {}).get("en")
        fl = (e.get("flavor") or {}).get("en")
        if en and fl:
            flavor_of_name.setdefault(en, fl)

    trans_path = DATA_DIR / "translations.json"
    trans = json.load(io.open(trans_path, encoding="utf-8-sig"))
    names = trans.setdefault("itemNames", {})
    flavors = trans.setdefault("itemFlavors", {})

    accepted_n = accepted_f = bad = 0
    for out in sorted(BATCH_DIR.glob("out_*.json")):
        data = json.loads(out.read_text(encoding="utf-8-sig"))
        for en, entry in data.items():
            if not isinstance(entry, dict) or not (entry.get("name") or "").strip():
                bad += 1
                continue
            names[en] = entry["name"].strip()
            accepted_n += 1
            fl_ua = (entry.get("flavor") or "").strip()
            fl_en = flavor_of_name.get(en)
            if fl_ua and fl_en:
                flavors[fl_en] = fl_ua
                accepted_f += 1

    trans_path.write_text(json.dumps(trans, ensure_ascii=False, indent=1),
                          encoding="utf-8")
    print(f"Назв: {accepted_n} | флейворів: {accepted_f} | браку: {bad}")
    print(f"Усього в базі: назв {len(names)}, флейворів {len(flavors)}")


if __name__ == "__main__":
    main()
