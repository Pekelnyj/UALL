# -*- coding: utf-8 -*-
"""Батчі НЕПЕРЕКЛАДЕНИХ описів-ефектів ТРИНЬОК (прості + складні $?).

Тринькети = ItemSparse InventoryType==12. Для кожної беремо spellID ефектів
(item_effects.json), збираємо EN-описи, яких ще нема в descTemplates. Дедуп за EN.
Додаємо de/fr (для зняття неоднозначності) + назву тринькети (контекст ефекту).

Вихід: data/trinket_effect_batches/batch_NN.json
       {en_шаблон: {"de":..., "fr":..., "item": "назва тринькети"}}

Переклад -> out_NN.json {en: ua}, далі:
    python merge_desc_batches.py --dir trinket_effect_batches   (сувора валідація)
"""

import json
import csv
import glob
import os

from common import DATA_DIR

OUT = DATA_DIR / "trinket_effect_batches"
BATCH = 16


def main():
    # тринькети + назви
    trinkets = {}
    with open(DATA_DIR / "wago" / "ItemSparse.enUS.latest.csv", encoding="utf-8") as fh:
        csv.field_size_limit(10 ** 7)
        for row in csv.DictReader(fh):
            if row.get("InventoryType") == "12":
                nm = (row.get("Display_lang") or "").strip()
                if nm:
                    trinkets[row["ID"]] = nm

    eff = json.loads((DATA_DIR / "source" / "item_effects.json").read_text(encoding="utf-8-sig"))
    spells = json.loads((DATA_DIR / "source" / "spells.json").read_text(encoding="utf-8-sig"))
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    done = tr.get("descTemplates", {})

    pending = {}  # en -> {de, fr, item}
    for iid, name in trinkets.items():
        for sid in (eff.get(str(iid)) or []):
            d = (spells.get(str(sid), {}) or {}).get("description") or {}
            en = d.get("en")
            if not en or en in done or en in pending:
                continue
            pending[en] = {"de": d.get("de"), "fr": d.get("fr"), "item": name}

    items = sorted(pending.items())
    OUT.mkdir(parents=True, exist_ok=True)
    for old in glob.glob(str(OUT / "*.json")):
        os.remove(old)
    n = 0
    for i in range(0, len(items), BATCH):
        n += 1
        (OUT / f"batch_{n:02d}.json").write_text(
            json.dumps(dict(items[i:i + BATCH]), ensure_ascii=False, indent=1),
            encoding="utf-8")
    words = sum(len(en.split()) for en in pending)
    cond = sum(1 for en in pending if "$?" in en)
    print(f"Унік. описів ефектів триньок: {len(items)} (складних $?: {cond}, ~{words} слів)")
    print(f"Батчів: {n} (по {BATCH}) -> {OUT}")


if __name__ == "__main__":
    main()
