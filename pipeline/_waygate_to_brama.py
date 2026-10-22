# -*- coding: utf-8 -*-
"""Waygate → «Брама» (рішення користувача за прецедентом Stargate=Зоряна брама).
Трек «Ancient Waygates» → «Прадавні Брами». Чистимо кальку «Брами Шляху»/«Шляховрата»."""
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")
P = Path("g:/Claude Code/WoWUkraine/data/translations.json")
tr = json.loads(P.read_text(encoding="utf-8-sig"))

log = []

# 1) renown-трек: явна нормалізація за EN-ключем
rn = tr.get("renown", {})
for k in list(rn):
    if isinstance(k, str) and k.startswith("Ancient Waygate"):
        old = rn[k]
        if k.startswith("Ancient Waygates"):
            roman = k.split()[-1]
            rn[k] = f"Прадавні Брами {roman}"
        else:  # "Ancient Waygate: X" — лишаємо вже перекладений хвіст після ':'
            ua_tail = old.split(":", 1)[1].strip() if ":" in old else ""
            rn[k] = f"Прадавня Брама: {ua_tail}"
        if rn[k] != old:
            log.append((k, old, rn[k]))

# 2) глобальна чистка калькованих форм у всіх рядках
#    «Брам(и/а/у/ою) Шляху/Шляхів» → без хвоста; «Шляховрата/Шляховрата» → «Брами»
CALQUE = [
    (r"Шляховрата", "Брами"), (r"Шляховрата", "Брами"),
    (r"\bБрами Шляхів\b", "Брами"), (r"\bБрами Шляху\b", "Брами"),
    (r"\bБрам Шляху\b", "Брам"), (r"\bБрама Шляху\b", "Брама"),
    (r"\bБраму Шляху\b", "Браму"), (r"\bБрамою Шляху\b", "Брамою"),
    (r"\bБрамі Шляху\b", "Брамі"),
]
cnt = {}
def clean(s):
    for pat, rep in CALQUE:
        ns, n = re.subn(pat, rep, s)
        if n:
            cnt[pat] = cnt.get(pat, 0) + n
            s = ns
    return s
def walk(v):
    if isinstance(v, str): return clean(v)
    if isinstance(v, dict): return {k: walk(x) for k, x in v.items()}
    if isinstance(v, list): return [walk(x) for x in v]
    return v
tr = walk(tr)

P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print("=== renown-трек (явно) ===")
for k, o, n in log:
    print(f"  {k}: «{o}» → «{n}»")
print("\n=== глобальна чистка кальки ===")
for k, v in cnt.items():
    print(f"  {k}: {v}")
blob = json.dumps(tr, ensure_ascii=False)
print("\nлишок «Шляху/Шляхів» біля Брам:", len(re.findall(r"Брам\w* Шлях", blob)), "| Шляховрата:", len(re.findall(r"Шляхов", blob)))
