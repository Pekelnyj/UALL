"""Батчі описів ЕФЕКТІВ предметів (spell-описи з токенами) на переклад.

Беремо spell із skillLine=ItemEffect, descComplexity=simple, опис ще не в
descTemplates. Дедуп за EN-шаблоном (один переклад на однаковий опис).

Вихід: data/effect_desc_batches/batch_NN.json
       [{sid, en, de, fr}]  (en/de/fr — шаблони опису з $-токенами)
"""

import json
import glob
import os

from common import DATA_DIR

OUT = DATA_DIR / "effect_desc_batches"
BATCH = 35


def main():
    src = json.loads((DATA_DIR / "source" / "spells.json").read_text(encoding="utf-8-sig"))
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    done = tr.get("descTemplates", {})

    seen = set()
    items = []
    for sid, e in src.items():
        if e.get("skillLine") != "ItemEffect":
            continue
        d = e.get("description") or {}
        en = d.get("en")
        if not en or e.get("descComplexity") != "simple" or en in done or en in seen:
            continue
        seen.add(en)
        items.append({"sid": int(sid), "en": en, "de": d.get("de"), "fr": d.get("fr")})

    OUT.mkdir(parents=True, exist_ok=True)
    for old in glob.glob(str(OUT / "*.json")):
        os.remove(old)
    n = 0
    for i in range(0, len(items), BATCH):
        n += 1
        (OUT / f"batch_{n:02d}.json").write_text(
            json.dumps(items[i:i + BATCH], ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Унік. описів ефектів: {len(items)} | батчів: {n} (по {BATCH})")


if __name__ == "__main__":
    main()
