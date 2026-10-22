# -*- coding: utf-8 -*-
"""Додає НЕперекладені істоти з api_creatures_full.json у creatures.json (en/de/fr).
Лише нові імена (en нема в базі) і нові cid (без перезапису). Далі — звичайний
конвеєр: prep_creature_batches -> переклад -> merge_creature_names -> generate_db.
"""
import json
from common import DATA_DIR

api = json.loads((DATA_DIR / "source" / "api_creatures_full.json").read_text(encoding="utf-8-sig"))
crp = DATA_DIR / "source" / "creatures.json"
cr = json.loads(crp.read_text(encoding="utf-8-sig"))
have_en = {(v.get("name") or {}).get("en") for v in cr.values() if isinstance(v, dict)}
have_en.discard(None)

added = 0
for cid, v in api.items():
    n = v.get("name") or {}
    en = n.get("en")
    if not en or en in have_en or cid in cr:
        continue
    cr[cid] = {"name": {"en": en, "de": n.get("de"), "fr": n.get("fr")}}
    have_en.add(en)
    added += 1

crp.write_text(json.dumps(cr, ensure_ascii=False, indent=2), encoding="utf-8")
print(f"Додано з API: {added} | усього в creatures.json: {len(cr)}")
