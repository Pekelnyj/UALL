"""Батчі рядків цілей квестів для перекладу агентами.

Вхід:  data/source/quest_objectives.json (extract_quest_objectives.py)
Вихід: data/batches/objectives/batch_NN.json

Рядки дедуплікуються (одна й та сама ціль трапляється в кількох квестах),
до кожного додається контекст — українська назва квесту з бази, щоб агент
розумів, про що мова.

Використання:
    python prep_objective_batches.py
"""

import json

from common import DATA_DIR

SRC = DATA_DIR / "source" / "quest_objectives.json"
OUT_DIR = DATA_DIR / "batches" / "objectives"
BATCH_SIZE = 60


def main():
    objectives = json.loads(SRC.read_text(encoding="utf-8"))
    translations = json.loads(
        (DATA_DIR / "translations.json").read_text(encoding="utf-8"))
    quests = translations.get("quests", {})

    # EN-рядок -> контексти (назви квестів українською, до 2 шт.)
    unique = {}
    for quest_id, objs in objectives.items():
        title = (quests.get(quest_id) or {}).get("title") or ""
        for o in objs:
            ctx = unique.setdefault(o["en"], [])
            if title and title not in ctx and len(ctx) < 2:
                ctx.append(title)

    items = [{"en": en, "context": "; ".join(ctx)}
             for en, ctx in sorted(unique.items())]

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for old in OUT_DIR.glob("batch_*.json"):
        old.unlink()
    n_batches = 0
    for i in range(0, len(items), BATCH_SIZE):
        n_batches += 1
        path = OUT_DIR / f"batch_{n_batches:02d}.json"
        path.write_text(json.dumps(items[i:i + BATCH_SIZE],
                                   ensure_ascii=False, indent=1),
                        encoding="utf-8")

    print(f"Унікальних рядків цілей: {len(items)} "
          f"(з {sum(len(v) for v in objectives.values())} загалом)")
    print(f"Батчів по {BATCH_SIZE}: {n_batches} -> {OUT_DIR}")


if __name__ == "__main__":
    main()
