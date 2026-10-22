# -*- coding: utf-8 -*-
"""Зіставити захоплені renown-нагороди з фракціями (через RenownRewards.CovenantID -> Covenant)."""
import json
import csv
import re
import sys
from collections import defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
csv.field_size_limit(10 ** 7)
B = Path("g:/Claude Code/WoWUkraine")

# 1) Covenant id -> назва (en)
cov = json.loads((B / "data/wago_all/Covenant.json").read_text(encoding="utf-8-sig"))
covname = {}
for k, v in cov.items():
    nm = (v.get("Name_lang") if isinstance(v, dict) else None)
    if isinstance(nm, dict):
        nm = nm.get("en") or nm.get("enUS")
    if nm:
        covname[str(k)] = nm
# fallback: з CSV Covenant якщо json порожній
if not covname:
    pass

# 2) RenownRewards: текст -> covenantID
desc2cov, toast2cov, name2cov = {}, {}, {}
with open(B / "data/wago/RenownRewards.enUS.latest.csv", encoding="utf-8") as f:
    for r in csv.DictReader(f):
        cid = r["CovenantID"]
        if r.get("Description_lang"):
            desc2cov.setdefault(r["Description_lang"], cid)
        if r.get("ToastDescription_lang"):
            toast2cov.setdefault(r["ToastDescription_lang"], cid)
        if r.get("Name_lang"):
            name2cov.setdefault(r["Name_lang"], cid)

# 3) захоплений renown {name: desc}
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
CAPS = [Path("F:/Battlenet/World of Warcraft/_retail_/WTF/Account/129089678#1/SavedVariables/WoWUkraine.lua"),
        B / "testerlua/WoWUkraine (20).lua"]


def block(s, key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', s)
    if not m: return ""
    i, d, instr, esc = m.end(), 1, False, False
    while i < len(s) and d > 0:
        c = s[i]
        if instr:
            if esc: esc = False
            elif c == "\\": esc = True
            elif c == '"': instr = False
        else:
            if c == '"': instr = True
            elif c == "{": d += 1
            elif c == "}": d -= 1
        i += 1
    return s[m.end():i - 1]


KV = re.compile(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"')
ren = {}
for p in CAPS:
    if p.exists():
        for n, dsc in KV.findall(block(p.read_text(encoding="utf-8", errors="replace"), "renown")):
            n2 = n.encode().decode("unicode_escape", "ignore") if "\\" in n else n
            dsc2 = dsc.encode().decode("unicode_escape", "ignore") if "\\" in dsc else dsc
            ren.setdefault(n2, dsc2)

by_fac = defaultdict(list)
unmatched = 0
for name, desc in ren.items():
    cid = desc2cov.get(desc) or toast2cov.get(desc) or name2cov.get(name)
    if cid:
        by_fac[cid].append(name)
    else:
        unmatched += 1

print(f"Захоплено renown: {len(ren)} | зіставлено з фракцією: {len(ren)-unmatched} | без збігу: {unmatched}\n")
print(f"{'Фракція (Covenant)':<42}{'нагород':>8}")
print("-" * 52)
for cid, names in sorted(by_fac.items(), key=lambda x: -len(x[1])):
    fn = covname.get(cid, f"Covenant#{cid}")
    print(f"{fn:<42}{len(names):>8}")
