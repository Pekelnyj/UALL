# -*- coding: utf-8 -*-
import sys, re, json
sys.stdout.reconfigure(encoding="utf-8")


def WordsKey(s):
    s = re.sub(r'\|c[0-9a-fA-F]{8}', '', s)
    s = re.sub(r'\|cn[A-Za-z_]+:', '', s); s = s.replace('|r', '')
    s = re.sub(r'\|H.*?\|h(.*?)\|h', r'\1', s)
    s = re.sub(r'\|T.*?\|t', '', s); s = re.sub(r'\|A.*?\|a', '', s)
    s = s.replace('$bullet;', ' ')
    s = re.sub(r'\$@?\w*', ' ', s)
    s = re.sub(r'\d', ' ', s); s = re.sub(r'[^0-9A-Za-z_\s]', ' ', s)
    return re.sub(r'\s+', ' ', s.lower()).strip()


src = json.loads(open("data/source/spells.json", encoding="utf-8-sig").read())
tr = json.loads(open("data/translations.json", encoding="utf-8-sig").read())
dt = tr["descTemplates"]

# 1) знайти spellID за фрагментом EN
frags = ["erupts in a blaze of glory", "fixates on a random player", "enters dormancy as a Smoldering"]
found = {}
for sid, e in src.items():
    den = (e.get("description") or {}).get("en") if isinstance(e.get("description"), dict) else None
    if not den:
        continue
    for f in frags:
        if f in den:
            found.setdefault(f, []).append((sid, den))

# 2) побудувати descByWords-префікс (як у грі) + рахувати колізії
prefix_owners = {}
for sid, e in src.items():
    den = (e.get("description") or {}).get("en") if isinstance(e.get("description"), dict) else None
    if den and den in dt:
        k = WordsKey(den)[:48]
        if len(k) >= 16:
            prefix_owners.setdefault(k, []).append(sid)

for f in frags:
    print("=" * 60)
    print("ФРАГМЕНТ:", f)
    for sid, den in found.get(f, [])[:2]:
        inDt = den in dt
        k = WordsKey(den)[:48]
        owners = prefix_owners.get(k, [])
        print(f"  spellID {sid}: descTemplates[en]={'Є' if inDt else 'НЕМА'}")
        print(f"    префікс-ключ: {k!r}")
        print(f"    власники цього префікса (колізія): {owners}")
        print(f"    EN repr: {den[:130]!r}")
    if not found.get(f):
        print("  spellID НЕ знайдено в source за фрагментом")
