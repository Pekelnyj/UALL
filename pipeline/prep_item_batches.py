"""Батчі для перекладу ПРЕДМЕТІВ Midnight агентами.

Назва і флейвор перекладаються разом (флейвор — контекст для назви).
Однакові англійські назви зливаються (сети мають копії по складностях).

Результат: data/item_batches/batch_NN.json
    {"<en назва>": {"de","fr","flavor": {"en","de","fr"}|null}}

Використання:
    python prep_item_batches.py
"""

import json
import io

from common import DATA_DIR

BATCH_DIR = DATA_DIR / "item_batches"
BATCH_SIZE = 90


def main():
    src = json.load(io.open(DATA_DIR / "source" / "items.json", encoding="utf-8-sig"))
    trans = json.load(io.open(DATA_DIR / "translations.json", encoding="utf-8-sig"))
    done = trans.get("itemNames", {})

    pending = {}
    for iid, e in src.items():
        name = e.get("name", {})
        en = name.get("en")
        if not en or en in done:
            continue
        flavor = e.get("flavor") or None
        has_fl = bool(flavor and flavor.get("en"))
        rec = pending.get(en)
        if rec is None:
            pending[en] = {
                "de": name.get("de"),
                "fr": name.get("fr"),
                "flavor": {"en": flavor.get("en"), "de": flavor.get("de"),
                           "fr": flavor.get("fr")} if has_fl else None,
                "_maxid": int(iid),
            }
        else:
            rec["_maxid"] = max(rec["_maxid"], int(iid))
            if has_fl and not rec["flavor"]:
                rec["flavor"] = {"en": flavor.get("en"), "de": flavor.get("de"),
                                 "fr": flavor.get("fr")}

    # ПРІОРИТЕТ: спершу з флейвором (там назву звіряємо з описом), тоді найновіші.
    order = sorted(pending.items(),
                   key=lambda kv: (kv[1]["flavor"] is None, -kv[1]["_maxid"]))
    items = [(en, {k: v for k, v in rec.items() if k != "_maxid"})
             for en, rec in order]
    BATCH_DIR.mkdir(parents=True, exist_ok=True)
    for old in BATCH_DIR.glob("*.json"):
        old.unlink()

    batches = 0
    for i in range(0, len(items), BATCH_SIZE):
        chunk = dict(items[i:i + BATCH_SIZE])
        batches += 1
        (BATCH_DIR / f"batch_{batches:02d}.json").write_text(
            json.dumps(chunk, ensure_ascii=False, indent=1), encoding="utf-8")

    flavored = sum(1 for _, p in items if p["flavor"])
    print(f"Унікальних назв: {len(items)} (з флейвором: {flavored}) у {batches} батчах")
    print(f"-> {BATCH_DIR}")


if __name__ == "__main__":
    main()
