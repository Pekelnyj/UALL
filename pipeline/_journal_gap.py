# -*- coding: utf-8 -*-
"""Які journal-секції (абілки босів) у нас НЕ перекладені — розклад по доповненню × рейд/данж."""
import csv
import glob
import io
import json
import re
import sys
from pathlib import Path
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8")
W = Path("g:/Claude Code/WoWUkraine/data/wago")
SRC = Path("g:/Claude Code/WoWUkraine/data/source/api_journal_sections.json")

EXP = {0: "Classic", 1: "Burning Crusade", 2: "Wrath", 3: "Cataclysm", 4: "Mists of Pandaria",
       5: "Warlords of Draenor", 6: "Legion", 7: "Battle for Azeroth", 8: "Shadowlands",
       9: "Dragonflight", 10: "The War Within", 11: "Midnight"}
ITYPE = {1: "данж", 2: "РЕЙД", 3: "pvp", 4: "арена", 5: "сценарій"}


def load(table):
    f = sorted(glob.glob(str(W / f"{table}.enUS.*.csv")))
    if not f:
        return []
    return list(csv.DictReader(io.StringIO(Path(f[0]).read_text(encoding="utf-8"))))


def norm(s):
    return re.sub(r"\s+", " ", (s or "")).strip()


# карти join
enc = {r["ID"]: r for r in load("JournalEncounter")}
inst = {r["ID"]: r for r in load("JournalInstance")}
mp = {r["ID"]: r for r in load("Map")}

# наше покриття (ключі джерела = тексти секцій)
have = {norm(k) for k in json.loads(SRC.read_text(encoding="utf-8-sig")).keys()}

missing = Counter()          # (доповнення, тип) -> к-сть
missing_inst = Counter()     # назва інстансу -> к-сть
have_n = miss_n = noexp = 0

for s in load("JournalEncounterSection"):
    body = norm(s.get("BodyText_lang"))
    if not body:
        continue
    covered = body in have or norm(s.get("Title_lang")) in have
    e = enc.get(s.get("JournalEncounterID"))
    i = inst.get(e["JournalInstanceID"]) if e else None
    m = mp.get(i["MapID"]) if i else None
    exp = EXP.get(int(m["ExpansionID"]), f"exp{m['ExpansionID']}") if m and m.get("ExpansionID","").lstrip("-").isdigit() else "?"
    typ = ITYPE.get(int(m["InstanceType"]), m.get("InstanceType","?")) if m and m.get("InstanceType","").isdigit() else "?"
    iname = (i or {}).get("Name_lang", "?")
    if covered:
        have_n += 1
    else:
        miss_n += 1
        missing[(exp, typ)] += 1
        missing_inst[f"{iname} [{exp}/{typ}]"] += 1

print(f"Секцій з тілом: {have_n + miss_n} | вже маємо: {have_n} | НЕМАЄ: {miss_n}\n")
print("=== НЕМАЄ — по доповненню × тип ===")
for (exp, typ), n in sorted(missing.items(), key=lambda x: -x[1]):
    print(f"  {n:>5}  {exp:<22} {typ}")
print("\n=== ТОП-20 інстансів, де найбільше непокритого ===")
for name, n in missing_inst.most_common(20):
    print(f"  {n:>4}  {name}")
