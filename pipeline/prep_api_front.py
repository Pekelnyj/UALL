# -*- coding: utf-8 -*-
"""Батчі для перекладу API-фронтів типу name(+description): афікси, титули,
фракції, маунти, пети, іграшки, журнал... Джерело: data/source/api_<front>.json
{id:{name:{en,de,fr}, description?:{en,de,fr}}}.

Вихід: data/batches/<front>/batch_NNN.json — список {id, name:{en,de,fr}, desc:{en,de,fr}}.
Переклад -> out_NNN.json [{id, name:ua, desc:ua?}] -> merge_api_front.py --front <front>.

Запуск: python prep_api_front.py --front affixes [--size 80]
"""
import argparse, glob, json, os
from common import DATA_DIR


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--front", required=True)
    ap.add_argument("--size", type=int, default=80)
    ap.add_argument("--skip-items", action="store_true",
                    help="пропустити назви, що вже є в itemNames (рецепти=предмети)")
    args = ap.parse_args()

    src = json.loads((DATA_DIR / "source" / f"api_{args.front}.json").read_text(encoding="utf-8-sig"))
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    done = tr.get(args.front, {})
    items = set(tr.get("itemNames", {})) if args.skip_items else set()

    todo = []
    seen = set()  # дедуп за англ. назвою (один переклад на унікальну назву)
    for aid, v in src.items():
        if aid in done:
            continue
        n = v.get("name") or {}
        en_name = n.get("en")
        if en_name:
            if en_name in items or en_name in seen:
                continue
            seen.add(en_name)
        item = {"id": aid}
        if en_name:
            item["name"] = n
        d = v.get("description") or {}
        if d.get("en"):
            item["desc"] = d
        if "name" in item or "desc" in item:
            todo.append(item)
    todo.sort(key=lambda x: int(x["id"]) if x["id"].lstrip("-").isdigit() else 0)

    out = DATA_DIR / "batches" / args.front
    out.mkdir(parents=True, exist_ok=True)
    for f in out.glob("batch_*.json"):
        f.unlink()
    n = 0
    for i in range(0, len(todo), args.size):
        n += 1
        (out / f"batch_{n:03d}.json").write_text(
            json.dumps(todo[i:i + args.size], ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"{args.front}: до перекладу {len(todo)} | батчів по {args.size}: {n} -> {out}")


if __name__ == "__main__":
    main()
