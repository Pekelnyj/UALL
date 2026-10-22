# -*- coding: utf-8 -*-
"""Витягти УНІКАЛЬНІ рядки-значення, що містять «верхівц» (Mount-мистранслейт),
з translations.json + Broadcast.lua -> батчі для виправлення на «їздова тварина».
Виправлення мерджиться глобально як old_string->new_string (тому ключі секцій не треба)."""
import sys, re, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

RX = re.compile("верхівц|верхівець")
vals = set()


def walk(o):
    if isinstance(o, dict):
        for v in o.values():
            walk(v)
    elif isinstance(o, list):
        for v in o:
            walk(v)
    elif isinstance(o, str) and RX.search(o):
        vals.add(o)


tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
walk(tr)
# Broadcast.lua значення
bc = (DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua").read_text(encoding="utf-8")
for m in re.finditer(r'\["(?:[^"\\]|\\.)*"\]\s*=\s*"((?:[^"\\]|\\.)*)"', bc):
    v = m.group(1).replace('\\n', '\n').replace('\\r', '\r').replace('\\"', '"').replace('\\\\', '\\')
    if RX.search(v):
        vals.add(v)

vals = sorted(vals)
size = 20
OUT = DATA_DIR / "batches" / "verhivets"
OUT.mkdir(parents=True, exist_ok=True)
for f in OUT.glob("*.json"):
    f.unlink()
nb = (len(vals) + size - 1) // size
for k in range(nb):
    (OUT / f"vh_{k:02d}.json").write_text(
        json.dumps(vals[k * size:(k + 1) * size], ensure_ascii=False, indent=1),
        encoding="utf-8")
print(f"унікальних рядків із «верхівц»: {len(vals)} -> батчів {nb} (по {size})")
