# -*- coding: utf-8 -*-
# Готує батчі НЕперекладених валют (name + desc) з контекстом en/de/fr.
# Відсіює явне сміття (DEPRECATED/TEST/zzz...). Запуск: python pipeline/prep_currencies.py
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"
def L(p): return json.loads((DATA / p).read_text(encoding="utf-8-sig"))

cur = L("source/currencies.json")
tr = L("translations.json")
done = set(tr.get("currencies", {}))
JUNK = re.compile(r"\b(DEPRECATED|DEP|OLD|TEST|UNUSED|QA|placeholder|do not use|"
                  r"DELETE|\[?DNT\]?)\b|^z+\b|^Currency \d", re.I)

items = []
for cid, c in cur.items():
    if cid in done:
        continue
    nm = c.get("name") or {}
    en = nm.get("en")
    if not en or JUNK.search(en):
        continue
    d = c.get("description") or {}
    e = {"id": cid, "name_en": en, "name_de": nm.get("de", ""), "name_fr": nm.get("fr", "")}
    if d.get("en"):
        e["desc_en"] = d["en"]; e["desc_de"] = d.get("de", ""); e["desc_fr"] = d.get("fr", "")
    items.append(e)

print(f"Валют до перекладу (без сміття): {len(items)}")
B = 150
dpath = DATA / "currency_batches"
dpath.mkdir(exist_ok=True)
for f in dpath.glob("*.json"): f.unlink()
n = 0
for i in range(0, len(items), B):
    (dpath / f"cur_{n:02d}.json").write_text(
        json.dumps(items[i:i+B], ensure_ascii=False, indent=1), encoding="utf-8")
    n += 1
print(f"батчів по {B}: {n}")
