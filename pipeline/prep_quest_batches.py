"""Батчі неперекладених квестів для хвиль перекладу.

Вхід:  data/source/quests.json (en/de/fr) + data/translations.json (готове)
Вихід: data/batches/quests/batch_NNN.json — по BATCH_SIZE квестів,
       з de/fr контекстом для звірки (правило глосарія №8).

Використання:
    python prep_quest_batches.py
"""

import argparse
import json

from common import DATA_DIR

OUT_DIR = DATA_DIR / "batches" / "quests"
BATCH_SIZE = 12


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--min", type=int, default=0, help="мін. ID (включно)")
    ap.add_argument("--max", type=int, default=10**9, help="макс. ID (виключно)")
    args = ap.parse_args()

    src = json.loads((DATA_DIR / "source" / "quests.json")
                     .read_text(encoding="utf-8"))
    tr = json.loads((DATA_DIR / "translations.json")
                    .read_text(encoding="utf-8"))
    done = set(tr.get("quests", {}))

    todo = []
    for qid, q in src.items():
        if qid in done or not q.get("description"):
            continue
        if not (args.min <= int(qid) < args.max):
            continue
        # Пропускаємо девелоперські заглушки [DNT] = Do Not Translate.
        en_title = (q.get("title") or {}).get("en", "")
        if "[DNT]" in en_title or "QuestNameHere" in en_title:
            continue
        item = {"id": qid}
        for field in ("title", "description", "objectives"):
            if q.get(field):
                item[field] = q[field]  # {"en":..., "de":..., "fr":...}
        todo.append(item)
    todo.sort(key=lambda x: int(x["id"]))

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for old in OUT_DIR.glob("batch_*.json"):
        old.unlink()
    n = 0
    for i in range(0, len(todo), BATCH_SIZE):
        n += 1
        (OUT_DIR / f"batch_{n:03d}.json").write_text(
            json.dumps(todo[i:i + BATCH_SIZE], ensure_ascii=False, indent=1),
            encoding="utf-8")

    print(f"До перекладу: {len(todo)} квестів | батчів по {BATCH_SIZE}: {n}")


if __name__ == "__main__":
    main()
