# -*- coding: utf-8 -*-
# Готує батчі НЕперекладених сетів предметів (api_item_sets.json) з контекстом en/de/fr.
# Запуск: python pipeline/prep_sets.py
import json, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"
def L(p): return json.loads((DATA / p).read_text(encoding="utf-8-sig"))

sets = L("source/api_item_sets.json")
tr = L("translations.json")
done = set(tr.get("itemSets", {}))

items = []
for sid, s in sets.items():
    if sid in done:
        continue
    nm = s.get("name") or {}
    en = nm.get("en")
    if not en:
        continue
    items.append({"id": sid, "en": en, "de": nm.get("de", ""), "fr": nm.get("fr", "")})

print(f"Сетів до перекладу: {len(items)}")
B = 150
d = DATA / "set_batches"
d.mkdir(exist_ok=True)
for f in d.glob("*.json"): f.unlink()
n = 0
for i in range(0, len(items), B):
    (d / f"set_{n:02d}.json").write_text(
        json.dumps(items[i:i+B], ensure_ascii=False, indent=1), encoding="utf-8")
    n += 1
print(f"Батчів по {B}: {n}")
