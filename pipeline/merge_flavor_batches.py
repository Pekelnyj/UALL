# -*- coding: utf-8 -*-
"""Злиття перекладеного флейвору: out_*.json {en_flavor: ua} -> itemFlavors."""
import argparse
import json

from common import DATA_DIR


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dir", default="flavor_batches")
    args = ap.parse_args()
    bd = DATA_DIR / args.dir

    p = DATA_DIR / "translations.json"
    tr = json.loads(p.read_text(encoding="utf-8-sig"))
    fl = tr.setdefault("itemFlavors", {})

    acc = bad = 0
    for out in sorted(bd.glob("out_*.json")):
        data = json.loads(out.read_text(encoding="utf-8-sig"))
        for en, ua in data.items():
            if not isinstance(ua, str) or not ua.strip():
                bad += 1
                continue
            fl[en] = ua.strip()
            acc += 1

    p.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Флейворів: {acc} | браку: {bad} | усього в базі: {len(fl)}")


if __name__ == "__main__":
    main()
