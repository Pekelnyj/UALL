# -*- coding: utf-8 -*-
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
npcN = tr["npcNames"]
s = (B / "testerlua/WoWUkraine (21).lua").read_text(encoding="utf-8", errors="replace")
IN = B / "data/_t21_in"; IN.mkdir(exist_ok=True)
(B / "data/_t21_out").mkdir(exist_ok=True)


def block(key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
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
def cyr(x): return bool(re.search(r"[А-Яа-яІЇЄҐ]", x))
def unesc(x): return x.encode().decode("unicode_escape", "ignore") if "\\" in x else x

# 1) МОБИ new (by id) + якір
nb = block("npc")
pairs = re.findall(r'\["(\d+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', nb)
new = {i: n for i, n in pairs if i not in npcN}
(B / "data/_t21_newnpc.json").write_text(json.dumps(new, ensure_ascii=False, indent=1), encoding="utf-8")
src = {}
for f in ["creatures.json", "api_creatures_full.json"]:
    d = json.loads((B / "data/source" / f).read_text(encoding="utf-8-sig"))
    for k, v in d.items():
        if isinstance(v, dict) and v.get("name", {}).get("en"):
            src.setdefault(v["name"]["en"], k)
fw = defaultdict(dict)
for en, cid in src.items():
    if cid in npcN and en.split():
        fw[en.split()[0].lower()][en] = npcN[cid]
uniq = sorted(set(new.values()))
SZ = 50
nb_batches = [uniq[i:i+SZ] for i in range(0, len(uniq), SZ)]
for bi, names in enumerate(nb_batches, 1):
    ref = {}
    for nm in names:
        if nm.split():
            for en, ua in list(fw.get(nm.split()[0].lower(), {}).items())[:3]:
                ref[en] = ua
    (IN / f"mob_{bi}.json").write_text(json.dumps({"names": names, "reference_existing": ref}, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"МОБИ: {len(uniq)} унік. -> {len(nb_batches)} батчів")

# 2) субтитри
btr = tr.get("broadcast", {})
subs = sorted({unesc(k) for k in re.findall(r'\["((?:[^"\\]|\\.)*)"\]', block("broadcast")) if k not in btr and len(k) > 3 and not cyr(k)})
(IN / "subs.json").write_text(json.dumps(subs, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"СУБТИТРИ: {len(subs)}")

# 3) renown stragglers
rtr = tr.get("renown", {})
ren = [{"name": unesc(n), "desc": unesc(dsc)} for n, dsc in KV.findall(block("renown")) if dsc and unesc(dsc) not in rtr]
(IN / "renown.json").write_text(json.dumps(ren, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"RENOWN: {len(ren)}")
