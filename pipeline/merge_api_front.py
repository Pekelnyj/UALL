# -*- coding: utf-8 -*-
"""Злиття перекладів API-фронту (name+desc) у translations.json[<front>].
Читає data/batches/<front>/out_*.json [{id, name:ua, desc:ua?}].
Ловить рос. літери ы/ъ/э/ё.

Запуск: python merge_api_front.py --front affixes
"""
import argparse, glob, json, re
from common import DATA_DIR
RUS = re.compile("[ыъэёЫЪЭЁ]")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--front", required=True)
    args = ap.parse_args()

    p = DATA_DIR / "translations.json"
    tr = json.loads(p.read_text(encoding="utf-8-sig"))
    sect = tr.setdefault(args.front, {})

    acc = bad = rus = 0
    for f in sorted((DATA_DIR / "batches" / args.front).glob("out_*.json")):
        for it in json.loads(open(f, encoding="utf-8-sig").read()):
            aid = str(it.get("id", "")).strip()
            nm = (it.get("name") or "").strip()
            ds = (it.get("desc") or "").strip()
            if not aid or (not nm and not ds):
                bad += 1
                continue
            if (nm and RUS.search(nm)) or (ds and RUS.search(ds)):
                rus += 1
                print("  РОС. ЛІТЕРА:", aid, repr((nm or ds)[:50]))
                continue
            e = sect.setdefault(aid, {})
            if nm:
                e["name"] = nm
            if ds:
                e["desc"] = ds
            acc += 1

    p.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"{args.front}: прийнято {acc} | браку {bad} | рос.літер {rus} | усього {len(sect)}")


if __name__ == "__main__":
    main()
