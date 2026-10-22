# -*- coding: utf-8 -*-
"""Застосувати виправлення «верхівець»→«їздова тварина» глобально.
Читає out_vh_*.json {old_string: new_string}, замінює ТОЧНІ значення-рядки
скрізь у translations.json + Broadcast.lua (ключі секцій не потрібні)."""
import sys, json, glob, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

mapping = {}
for f in sorted(glob.glob(str(DATA_DIR / "batches" / "verhivets" / "out_vh_*.json"))):
    d = json.loads(open(f, encoding="utf-8-sig").read())
    for old, new in d.items():
        if isinstance(new, str) and new and new != old:
            mapping[old] = new
print(f"замін у мапі: {len(mapping)}")

# translations.json — глобальна підміна значень
TR = DATA_DIR / "translations.json"
tr = json.loads(TR.read_text(encoding="utf-8-sig"))
n_tr = [0]


def walk(o):
    if isinstance(o, dict):
        return {k: walk(v) for k, v in o.items()}
    if isinstance(o, list):
        return [walk(v) for v in o]
    if isinstance(o, str) and o in mapping:
        n_tr[0] += 1
        return mapping[o]
    return o


tr = walk(tr)
TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")

# Broadcast.lua — підміна значень за точним (екранованим) рядком
BCP = DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua"
bc = BCP.read_text(encoding="utf-8")


def esc(s):
    return (s.replace("\\", "\\\\").replace('"', '\\"')
             .replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t"))


n_bc = 0
for old, new in mapping.items():
    eo, en = esc(old), esc(new)
    if eo in bc:
        bc = bc.replace('"' + eo + '"', '"' + en + '"')
        n_bc += 1
BCP.write_text(bc, encoding="utf-8", newline="")

# контроль: скільки «верхівц» лишилось (легіт-вершники)
left = json.dumps(tr, ensure_ascii=False).count("верхівц") + json.dumps(tr, ensure_ascii=False).count("верхівець")
print(f"застосовано: translations {n_tr[0]} | Broadcast {n_bc}")
print(f"лишилось «верхівц» (легіт-вершники/непокрите): {left}")
