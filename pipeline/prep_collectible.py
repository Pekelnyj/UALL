# -*- coding: utf-8 -*-
"""Батчі для перекладу КОЛЕКЦІЙ (пети/маунти): назва + лорний опис.

КОНСИСТЕНТНІСТЬ ІМЕН: пети — це істоти; назву беремо з npcNames (en->ua) як hint,
щоб ім'я пета = ім'я істоти в грі. Маунти: переважно нові назви (золоте правило).

Вхід: data/source/api_<front>.json {id:{name:{en,de,fr}, description:{en,de,fr}}}
      + creatures.json + translations.json (npcNames) для мапи en->ua.
Вихід: data/batches/<front>/batch_NNN.json
       [{id, name:{en,de,fr}, hint?:"укр ім'я", desc:{en,de,fr}}]
Переклад -> out_NNN.json [{id, name:ua, desc:ua}] -> merge_api_front.py --front <front>.

Запуск: python prep_collectible.py --front pets [--size 12]
"""
import argparse, json
from common import DATA_DIR


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--front", required=True, choices=["pets", "mounts"])
    ap.add_argument("--size", type=int, default=12)
    args = ap.parse_args()

    src = json.loads((DATA_DIR / "source" / f"api_{args.front}.json").read_text(encoding="utf-8-sig"))
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    done = tr.get(args.front, {})
    npc = tr.get("npcNames", {})
    creatures = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))

    # Мапа en->ua для hint-консистентності: itemNames (маунти=предмети, Title Case)
    # + npcNames (пети=істоти). npcNames має пріоритет для збігів (істота-канон).
    en2ua = dict(tr.get("itemNames", {}))
    for cid, ua in npc.items():
        en = (creatures.get(cid, {}).get("name") or {}).get("en")
        if en:
            en2ua[en] = ua

    todo, hits = [], 0
    seen = set()
    for cid, v in src.items():
        if cid in done:
            continue
        n = v.get("name") or {}
        en = n.get("en")
        if not en or en in seen:
            continue
        seen.add(en)
        item = {"id": cid, "name": n}
        hint = en2ua.get(en)
        if hint:
            item["hint"] = hint
            hits += 1
        d = v.get("description") or {}
        if d.get("en"):
            item["desc"] = d
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
    print(f"{args.front}: до перекладу {len(todo)} | з готовим іменем (hint): {hits} | "
          f"нових імен: {len(todo) - hits} | батчів по {args.size}: {n}")


if __name__ == "__main__":
    main()
