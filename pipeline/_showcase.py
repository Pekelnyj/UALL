# -*- coding: utf-8 -*-
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))


def chars(v):
    if isinstance(v, str):
        return len(v)
    if isinstance(v, dict):
        return sum(chars(x) for x in v.values())
    if isinstance(v, list):
        return sum(chars(x) for x in v)
    return 0


total, per = 0, {}
for k, v in tr.items():
    c = chars(v)
    per[k] = c
    total += c

bl = (DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua").read_text(encoding="utf-8")
bvals = re.findall(r'=\s*"((?:[^"\\]|\\.)*)"', bl)
bchars = sum(len(x) for x in bvals)


def f(n):
    return f"{n:,}".replace(",", " ")


print("=== ОБСЯГ ТЕКСТУ ===")
print(f"translations.json: {f(total)} символів")
print(f"Broadcast.lua субтитри: {f(bchars)} символів ({f(len(bvals))} рядків)")
tt = total + bchars
print(f"РАЗОМ: {f(tt)} символів ≈ {f(tt // 6)} слів ≈ {f(tt // 1800)} стор. А4 ≈ {f(tt // 500000)} книг")
print()
print("=== ТОП-КАТЕГОРІЇ за обсягом ===")
for k, c in sorted(per.items(), key=lambda x: -x[1])[:14]:
    print(f"  {k}: {f(c)}")
