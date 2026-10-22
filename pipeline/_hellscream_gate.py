# -*- coding: utf-8 -*-
"""ГЕЙТ КАНОНУ ІМЕН (Hellscream та ін.): падає, якщо в базі чи в кінематик-батчах
з'являється ОПИСОВА форма прізвища замість транслітерації (глосарій §10).
Hellscream = ТІЛЬКИ «Хеллскрім», НІКОЛИ «Пекельний Крик»/«Пеклокрик».
Запуск перед кожним мерджем/релізом: python pipeline/_hellscream_gate.py
"""
from pathlib import Path
import sys, json, re, glob
sys.stdout.reconfigure(encoding="utf-8")
ROOT = str(Path(__file__).resolve().parent.parent)

# (заборонена_форма_regex, канон, пояснення)
FORBIDDEN = [
    (r"Пекельн\w*\s+Крик\w*", "Хеллскрім", "Hellscream — транслітерувати, НЕ описувати"),
    (r"Пеклокрик\w*",          "Хеллскрім", "Hellscream — транслітерувати, НЕ зліплювати"),
    (r"Пекло[-\s]?крик\w*",    "Хеллскрім", "Hellscream"),
    (r"Пеккрик\w*",            "Хеллскрім", "Hellscream — НЕ скорочувати"),
    (r"Геллскрім\w*",          "Хеллскрім", "Hellscream — Х (не Г) на початку"),
    (r"Смертокрил\w*",         "Дезвінг",   "Deathwing — транслітерувати"),
    (r"Вітрогін\w*",           "Віндраннер","Windrunner — транслітерувати"),
    (r"\bҐромаш\w*|\bГромаш\w*|\bГроммаш\w*", "Ґроммаш", "Grommash — Ґроммаш (Ґ, два м)"),
]

def scan(text):
    hits = []
    for pat, canon, why in FORBIDDEN:
        for m in re.finditer(pat, text):
            hits.append((m.group(0), canon, why))
    return hits

violations = []

# 1) translations.json (усі секції)
tr = json.load(open(ROOT + "/data/translations.json", encoding="utf-8-sig"))
def walk(o, path=""):
    if isinstance(o, str):
        for bad, canon, why in scan(o):
            violations.append((f"translations/{path}", bad, canon, why))
    elif isinstance(o, dict):
        for k, v in o.items(): walk(v, f"{path}/{k}" if path else str(k))
    elif isinstance(o, list):
        for v in o: walk(v, path)
walk(tr)

# 2) кінематик-батчі (вхід до перекладу)
for f in glob.glob(ROOT + "/data/tester_new/db2gaps/cinematic/translated/batch_*.json"):
    try: d = json.load(open(f, encoding="utf-8"))
    except Exception: continue
    for k, v in (d.items() if isinstance(d, dict) else []):
        for bad, canon, why in scan(str(v)):
            violations.append((f"cinematic/{f.split(chr(92))[-1]}", bad, canon, why))

# 3) Broadcast.lua (майстер субтитрів)
bl = open(ROOT + "/addon/UALL/Database/Broadcast.lua", encoding="utf-8").read()
for bad, canon, why in scan(bl):
    violations.append(("Broadcast.lua", bad, canon, why))

if violations:
    print(f"❌ ГЕЙТ КАНОНУ: {len(violations)} порушень")
    seen = set()
    for where, bad, canon, why in violations:
        key = (bad, where.split("/")[0])
        if key in seen: continue
        seen.add(key)
        print(f"   [{where.split('/')[0]}] «{bad}» → має бути «{canon}» ({why})")
    sys.exit(1)
print("✅ ГЕЙТ КАНОНУ: чисто. Жодних Пеклокриків (Hellscream=Хеллскрім, Deathwing=Дезвінг, Windrunner=Віндраннер).")
