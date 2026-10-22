# -*- coding: utf-8 -*-
"""БАЗА КАНОНУ власних назв: збирає EN-назву -> усі UA-форми з авторитетних джерел,
флагує РІЗНОБІЙ (>1 форма на одну EN-назву) як кандидатів у канон.

Джерела (EN-прив'язані): npcNames(через creatures.json id->EN), areaPOI, taxiNodes,
subnames, vignette, factions(name). Усі переважно в називному → порівняння форм надійне.

Запуск:
  python pipeline/canon_build.py            # звіт різнобою (кандидати)
  python pipeline/canon_build.py --seed     # + дописати безконфліктні (1 форма) у data/canon.json
"""
import json
import sys
import re
import collections
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path(__file__).resolve().parent.parent
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))


def load(p):
    return json.loads((B / p).read_text(encoding="utf-8-sig"))


# id -> EN для істот
def id2en():
    m = {}
    for f in ("data/source/api_creatures_full.json", "data/source/creatures.json"):
        try:
            d = load(f)
        except Exception:
            continue
        for k, v in d.items():
            nm = v.get("name") if isinstance(v, dict) else None
            en = nm.get("en") if isinstance(nm, dict) else (nm if isinstance(nm, str) else None)
            if isinstance(en, str) and en:
                m[str(k)] = en
    return m


CRE = id2en()

# EN -> Counter(ua-форм). Кожне джерело додає (en, ua).
en_forms = collections.defaultdict(collections.Counter)
en_types = collections.defaultdict(set)  # EN -> {типи джерел} (npc/place/...)


def add(en, ua, typ):
    if not en or not ua or not isinstance(en, str) or not isinstance(ua, str):
        return
    if not re.search(r"[A-Za-z]", en) or not re.search(r"[А-Яа-яІіЇїЄєҐґ]", ua):
        return
    en_forms[en.strip()][ua.strip()] += 1
    en_types[en.strip()].add(typ)


# npcNames: id->ua, EN з creatures (істоти — NpcNames-стиль, sentence-case)
for i, ua in tr.get("npcNames", {}).items():
    en = CRE.get(str(i))
    if en:
        add(en, ua, "npc")

# EN-keyed прості str-секції (місця=Title Case; субназви/vignette за типом)
for sec, typ in (("areaPOI", "place"), ("taxiNodes", "place"),
                 ("subnames", "subname"), ("vignette", "npc")):
    for en, ua in tr.get(sec, {}).items():
        add(en, ua, typ)

# factions: id->{name,desc} — EN назви фракцій нема в translations; пропускаємо desc, name беремо як є
# (factions ua-only; для крос-канону назв фракцій треба EN-джерело — TODO)

# конфлікти = EN з >1 формою
conflicts = []
for en, forms in en_forms.items():
    if len(forms) > 1:
        conflicts.append((sum(forms.values()), en, dict(forms)))
conflicts.sort(reverse=True)

print(f"=== БАЗА КАНОНУ: детектор різнобою ===")
print(f"унікальних EN-назв (авторит. джерела): {len(en_forms)}")
print(f"РІЗНОБІЙ (>1 UA-форма): {len(conflicts)}\n")
for tot, en, forms in conflicts[:50]:
    fs = " | ".join(f"{u}×{n}" for u, n in sorted(forms.items(), key=lambda x: -x[1]))
    print(f"[{tot:>3}] {en!r}\n      {fs}")

# зберегти повний список конфліктів (з типом джерела)
out = {en: {"type": "/".join(sorted(en_types[en])), "forms": dict(forms)}
       for _, en, forms in conflicts}
(B / "data/wago_bulk/_canon_conflicts.json").write_text(
    json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"\nповний список -> data/wago_bulk/_canon_conflicts.json ({len(out)})")

if "--seed" in sys.argv:
    cp = B / "data/canon.json"
    canon = json.loads(cp.read_text(encoding="utf-8-sig")) if cp.exists() else {}
    seeded = 0
    for en, forms in en_forms.items():
        if len(forms) == 1 and en not in canon:
            canon[en] = {"canon": next(iter(forms)), "type": "auto", "forbidden": [], "note": "auto-seed (1 форма)"}
            seeded += 1
    cp.write_text(json.dumps(canon, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"засіяно безконфліктних у canon.json: +{seeded} (усього {len(canon)})")
