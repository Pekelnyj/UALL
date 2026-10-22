# -*- coding: utf-8 -*-
import sys, re, json, glob
sys.stdout.reconfigure(encoding="utf-8")


def block_of(s, key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', s)
    if not m:
        return None
    i, depth, instr, esc = m.end(), 1, False, False
    while i < len(s) and depth > 0:
        c = s[i]
        if instr:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                instr = False
        else:
            if c == '"':
                instr = True
            elif c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
        i += 1
    return s[m.end():i - 1]


def unesc(v):
    return v.replace("\\\\", "\\").replace("||", "|").replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r").replace("\\t", "\t")


sv = glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0]
s = open(sv, encoding="utf-8", errors="replace").read()
mb = block_of(s, "ejmiss")
disp = [unesc(k) for k, _ in re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*(\d+)', mb)]

src = json.loads(open("data/source/spells.json", encoding="utf-8-sig").read())
tr = json.loads(open("data/translations.json", encoding="utf-8-sig").read())
dt = tr["descTemplates"]

# індекс: нормалізована англ. (числа→#) опису → spellID (для матчу displayed→spellID)
def norm(s):
    s = re.sub(r'\|[a-zA-Z].-?\|[a-zA-Z]', '', s)
    s = re.sub(r'\$@?\w*', '#', s)
    s = re.sub(r'\d[\d,. ]*', '#', s)
    return re.sub(r'\s+', ' ', s).strip().lower()[:40]

by_norm = {}
for sid, e in src.items():
    den = (e.get("description") or {}).get("en") if isinstance(e.get("description"), dict) else None
    if den:
        by_norm.setdefault(norm(den), []).append((sid, den))

# беремо лише схожі на описи абілок (мають "inflict"/"damage"/"sec", довгі)
abil = [d for d in disp if len(d) > 60 and re.search(r'inflict|damage|every|sec|players|summons|casts', d, re.I)]
in_dt = gap = 0
gaps = []
for d in abil:
    cands = by_norm.get(norm(d), [])
    hit = None
    for sid, den in cands:
        if den in dt:
            hit = sid; break
    if hit:
        in_dt += 1
    else:
        gap += 1
        gaps.append(d[:70])
print(f"Схожих на описи абілок у ejmiss: {len(abil)}")
print(f"  spellID знайдено + descTemplates Є (мали б перекластись/render): {in_dt}")
print(f"  НЕ в source/descTemplates (ДАНІ відсутні): {gap}")
print("\nПриклади дірок даних:")
for g in gaps[:15]:
    print("   ", repr(g))
