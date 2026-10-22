"""Батчі для ВИЧИТКИ перекладеного «злим рецензентом» (нічого не міняє).

Збирає весь перекладений текст у порції:
  - квести (title/objectives/description/progress/completion) — лише UA;
  - назви спелів — EN + UA (коротке, оригінал потрібен для оцінки);
  - шаблони описів — EN + UA.

Результат: data/review_batches/batch_NN.json
    [{"type","id","en"?,"ua"}]

Використання:
    python prep_review_batches.py
"""

import json
import io

from common import DATA_DIR

BATCH_DIR = DATA_DIR / "review_batches"
WORDS_PER_BATCH = 9000


def main():
    trans = json.load(io.open(DATA_DIR / "translations.json", encoding="utf-8-sig"))

    units = []
    for qid, q in trans.get("quests", {}).items():
        parts = [f"{f}: {q[f]}" for f in
                 ("title", "objectives", "description", "progress", "completion")
                 if q.get(f)]
        if parts:
            units.append({"type": "quest", "id": qid, "ua": "\n".join(parts)})

    # Назви спелів: групуємо по 40 в один юніт, щоб не плодити дрібʼязок.
    spells = sorted(trans.get("spells", {}).items(), key=lambda kv: int(kv[0]))
    src = json.load(io.open(DATA_DIR / "source" / "spells.json", encoding="utf-8-sig"))
    for i in range(0, len(spells), 40):
        chunk = spells[i:i + 40]
        lines = []
        for sid, ua in chunk:
            en = (src.get(sid, {}).get("name") or {}).get("en", "?")
            lines.append(f"{en} = {ua}")
        units.append({"type": "spells", "id": f"{chunk[0][0]}..{chunk[-1][0]}",
                      "ua": "\n".join(lines)})

    for en, ua in trans.get("descTemplates", {}).items():
        units.append({"type": "desc", "id": en[:70], "en": en, "ua": ua})

    BATCH_DIR.mkdir(parents=True, exist_ok=True)
    for old in BATCH_DIR.glob("*.json"):
        old.unlink()

    batches, cur, words = 0, [], 0
    def flush():
        nonlocal batches, cur, words
        if not cur:
            return
        batches += 1
        (BATCH_DIR / f"batch_{batches:02d}.json").write_text(
            json.dumps(cur, ensure_ascii=False, indent=1), encoding="utf-8")
        cur, words = [], 0

    for u in units:
        cur.append(u)
        words += len(u["ua"].split()) + len(u.get("en", "").split())
        if words >= WORDS_PER_BATCH:
            flush()
    flush()

    total = sum(len(u['ua'].split()) for u in units)
    print(f"Одиниць: {len(units)} (~{total} укр. слів) у {batches} батчах")
    print(f"-> {BATCH_DIR}")


if __name__ == "__main__":
    main()
