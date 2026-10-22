# -*- coding: utf-8 -*-
"""Перекладає $@spelldescNNN-тринькети правильно:
 (а) identity-шаблон $@spelldescNNN -> $@spelldescNNN (щоб рушій узяв токен-шлях);
 (б) переклад опису ЦІЛЬОВОГО спела NNN (з out_02) під ключем = EN-опис спела NNN,
     з суворою валідацією токенів/структури.
"""
import sys, io, json, re, csv, os
from collections import Counter

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")
csv.field_size_limit(10 ** 7)

TOKEN_RE = re.compile(r"\$\{[^{}]*\}|\$<\w+>|\$proc[a-z]+|\$@[a-zA-Z]+\d*|\$(\d+)?[sdatxmMunhoArRwWeEbc]\d*")
COND_RE = re.compile(r"\$\?!?[a-zA-Z]*\d+")
toks = lambda t: Counter(m.group(0) for m in TOKEN_RE.finditer(t))
struc = lambda t: (COND_RE.findall(t), t.count("["), t.count("]"))
PREFIX = "$@spelldesc"

out2 = json.loads(open("data/trinket_effect_batches/out_02.json", "rb").read().decode("utf-8-sig"))
spells = json.loads(open("data/source/spells.json", "rb").read().decode("utf-8-sig"))

csvdesc = {}
cf = "data/wago/Spell.enUS.latest.csv"
if os.path.exists(cf):
    with open(cf, encoding="utf-8") as fh:
        r = csv.DictReader(fh)
        dc = next((c for c in r.fieldnames if c.lower() in ("description_lang", "description")), None)
        idc = "ID" if "ID" in r.fieldnames else r.fieldnames[0]
        for row in r:
            if dc:
                csvdesc[row[idc]] = row[dc]

tr = json.loads(open("data/translations.json", "rb").read().decode("utf-8-sig"))
dt = tr["descTemplates"]
ok = ident = 0
rej = []
for key, ua in out2.items():
    if not key.startswith(PREFIX):
        rej.append((key[:40], "не spelldesc"))
        continue
    nnn = re.match(r"(\d+)", key[len(PREFIX):])
    if not nnn:
        rej.append((key[:40], "нема ID"))
        continue
    nnn = nnn.group(1)
    dt[key] = key
    ident += 1  # (а) identity
    en = ((spells.get(nnn, {}) or {}).get("description", {}) or {}).get("en") or csvdesc.get(nnn)
    if not en:
        rej.append((key, "нема EN опису " + nnn))
        continue
    if toks(en) != toks(ua) or struc(en) != struc(ua):
        rej.append((key, "токени/структура (" + nnn + ")"))
        continue
    dt[en] = ua
    ok += 1

open("data/translations.json", "w", encoding="utf-8").write(json.dumps(tr, ensure_ascii=False, indent=1))
print(f"(а) identity-шаблонів: {ident}")
print(f"(б) переклад цільового опису ПРИЙНЯТО: {ok} | відхилено: {len(rej)}")
for k, why in rej[:20]:
    print("  ВІДХ", why, "::", k[:55])
