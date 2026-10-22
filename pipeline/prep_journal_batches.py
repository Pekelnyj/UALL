# -*- coding: utf-8 -*-
"""Батчі для перекладу Журналу підземель (боси: ім'я + опис).

КОНСИСТЕНТНІСТЬ ІМЕН: для кожного боса спершу шукаємо вже наявний переклад
імені в базі істот (npcNames, en->ua). Якщо є — даємо агентові як ОБОВ'ЯЗКОВУ
підказку (hint), щоб ім'я в путівнику = ім'я в грі/квестах. Нові — транслітерує.

Вхід: data/source/api_journal.json {id:{name:{en,de,fr}, description:{en,de,fr}}}
      + creatures.json + translations.json (npcNames) для мапи en->ua.
Вихід: data/batches/journal/batch_NNN.json
       [{id, name:{en,de,fr}, hint:"<укр ім'я або null>", desc:{en,de,fr}?}]
Переклад -> out_NNN.json [{id, name:ua, desc:ua?}] -> merge_api_front.py --front journal
"""
import json, argparse
from common import DATA_DIR

BATCH = 10


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--size", type=int, default=BATCH)
    args = ap.parse_args()

    src = json.loads((DATA_DIR / "source" / "api_journal.json").read_text(encoding="utf-8-sig"))
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    npc = tr.get("npcNames", {})
    done = tr.get("journal", {})
    creatures = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))

    # en -> ua з бази істот (як у NpcNames.lua): cid->ua + cid->en
    en2ua = {}
    for cid, ua in npc.items():
        en = (creatures.get(cid, {}).get("name") or {}).get("en")
        if en and en not in en2ua:
            en2ua[en] = ua

    todo, hits = [], 0
    for jid, v in src.items():
        if jid in done:
            continue
        n = v.get("name") or {}
        en = n.get("en")
        if not en:
            continue
        item = {"id": jid, "name": n}
        hint = en2ua.get(en)
        if hint:
            item["hint"] = hint
            hits += 1
        d = v.get("description") or {}
        if d.get("en"):
            item["desc"] = d
        todo.append(item)

    todo.sort(key=lambda x: int(x["id"]))
    out = DATA_DIR / "batches" / "journal"
    out.mkdir(parents=True, exist_ok=True)
    for f in out.glob("batch_*.json"):
        f.unlink()
    n = 0
    for i in range(0, len(todo), args.size):
        n += 1
        (out / f"batch_{n:03d}.json").write_text(
            json.dumps(todo[i:i + args.size], ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"журнал: до перекладу {len(todo)} | з готовим іменем у базі: {hits} | "
          f"нових імен: {len(todo) - hits} | батчів по {args.size}: {n}")


if __name__ == "__main__":
    main()
