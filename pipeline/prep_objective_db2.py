"""Батчі цілей квестів із db2 (QuestObjective.db2) — НЕ зі збору в грі.

Вхід:  data/wago/QuestObjective.{enUS,deDE,frFR}.latest.csv (Description_lang)
Вихід: data/batches/objectives/batch_NN.json (продовжує нумерацію)
       [{"en": ..., "context": "de: ... | fr: ..."}]
Дедуп проти data/translations.json["questObjectives"].

Той самий merge (merge_objective_batches.py) підхопить out-файли.
Використання: python prep_objective_db2.py
"""

import csv
import json
from common import DATA_DIR

WAGO = DATA_DIR / "wago"
BATCH_DIR = DATA_DIR / "batches" / "objectives"
BATCH_SIZE = 60


def load(loc):
    d = {}
    with open(WAGO / f"QuestObjective.{loc}.latest.csv", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            t = (row.get("Description_lang") or "").strip()
            if t:
                d[row["ID"]] = t
    return d


def main():
    en, de, fr = load("enUS"), load("deDE"), load("frFR")
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8"))
    done = set(tr.get("questObjectives", {}))

    # унікальні англ. рядки -> один приклад de/fr для контексту
    seen = {}
    for oid, t in en.items():
        if t in done or t in seen:
            continue
        ctx = []
        if oid in de:
            ctx.append("de: " + de[oid])
        if oid in fr:
            ctx.append("fr: " + fr[oid])
        seen[t] = " | ".join(ctx)

    items = [{"en": t, "context": ctx} for t, ctx in sorted(seen.items())]

    BATCH_DIR.mkdir(parents=True, exist_ok=True)
    existing = sorted(BATCH_DIR.glob("batch_*.json"))
    next_n = (int(existing[-1].stem.split("_")[1]) if existing else 0) + 1
    n = 0
    for i in range(0, len(items), BATCH_SIZE):
        path = BATCH_DIR / f"batch_{next_n + n:02d}.json"
        path.write_text(json.dumps(items[i:i + BATCH_SIZE],
                                   ensure_ascii=False, indent=1),
                        encoding="utf-8")
        n += 1

    print(f"Нових цілей з db2: {len(items)} | батчі: "
          f"batch_{next_n:02d}..batch_{next_n + n - 1:02d} ({n})")


if __name__ == "__main__":
    main()
