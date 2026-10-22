# -*- coding: utf-8 -*-
"""Виправити вшите ім'я гравця: «Pekelnyj»/вокатив «Пекельний» -> {NAME}.
Зачіпає ЛИШЕ рядки-звертання; прикметник «пекельний» (Hellfire тощо) і M+ афікс
«Пекельний» (Infernal) НЕ чіпає. Заміна глобальна за точним old->new рядком."""
import sys, re, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

# вокатив-ім'я: Latin Pekelnyj; або «Пекельний» з пробілом/комою перед і пунктуацією/кінцем після;
# або на початку рядка з пунктуацією після.
LAT = re.compile(r"Pekelnyj")
VOC = re.compile(r"(?<=[ ,])Пекельний(?=[,.!?:»]|$)")
VOC_START = re.compile(r"^Пекельний(?=[,.!?:])")


def is_affix(s):
    # M+ афікс «Пекельний» (Infernal) — НЕ ім'я
    return s.strip() == "Пекельний" or "афікс" in s.lower()


def fix(s):
    if is_affix(s):
        return s
    n = LAT.sub("{NAME}", s)
    n = VOC.sub("{NAME}", n)
    n = VOC_START.sub("{NAME}", n)
    return n


tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))

# зібрати old->new по всіх рядках-значеннях
mapping = {}


def collect(o):
    if isinstance(o, dict):
        for v in o.values():
            collect(v)
    elif isinstance(o, list):
        for v in o:
            collect(v)
    elif isinstance(o, str):
        if ("Pekelnyj" in o) or VOC.search(o) or VOC_START.search(o):
            nw = fix(o)
            if nw != o:
                mapping[o] = nw


collect(tr)
print(f"рядків-звертань до заміни: {len(mapping)}")

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
(DATA_DIR / "translations.json").write_text(
    json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")

# Broadcast.lua
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

print(f"застосовано: translations {n_tr[0]} | Broadcast {n_bc}")
print("приклади:")
for k in list(mapping)[:5]:
    print("  ", repr(mapping[k][:70]))
