# -*- coding: utf-8 -*-
"""Застосувати FIX-файли QA-рев'ю хвилі: gossip/qcap -> translations.json,
broadcast -> translations.broadcast + Broadcast.lua. Плюс точкові правки імен."""
import sys, json, os, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

ROOT = DATA_DIR.parent
TR = DATA_DIR / "translations.json"
BCP = ROOT / "addon" / "UALL" / "Database" / "Broadcast.lua"
tr = json.loads(TR.read_text(encoding="utf-8-sig"))
rep = {}

# 1) gossip FIX
p = DATA_DIR / "batches" / "gossip" / "FIX.json"
if p.exists():
    d = json.loads(p.read_text(encoding="utf-8-sig")); n = 0
    g = tr.setdefault("gossip", {})
    for en, ua in d.items():
        if isinstance(ua, str) and ua.strip():
            g[en] = ua; n += 1
    rep["gossip"] = n

# 2) qcap FIX (масив {qid, fields})
p = DATA_DIR / "batches" / "qcap" / "FIX.json"
if p.exists():
    d = json.loads(p.read_text(encoding="utf-8-sig")); n = 0
    q = tr.setdefault("quests", {})
    for rec in d:
        qid = str(rec.get("qid", "")).strip(); flds = rec.get("fields", {})
        if not qid or not flds:
            continue
        e = q.setdefault(qid, {})
        for k, v in flds.items():
            if isinstance(v, str) and v.strip() and k in ("title", "description", "objectives", "progress", "completion"):
                e[k] = v; n += 1
    rep["qcap_fields"] = n

# 3) broadcast FIXA+FIXB -> translations.broadcast
b = tr.setdefault("broadcast", {}); nb = 0
bfix = {}
for p in (DATA_DIR / "batches" / "broadcast" / "FIXA.json",
          DATA_DIR / "batches" / "broadcast" / "FIXB.json"):
    if p.exists():
        d = json.loads(p.read_text(encoding="utf-8-sig"))
        for en, ua in d.items():
            if isinstance(ua, str) and ua.strip():
                b[en] = ua; bfix[en] = ua; nb += 1
rep["broadcast_master"] = nb

# 4) точкові правки імен NPC (транслітерація, не опис) — за npcID
NAME_FIX = {
    "167672": "Герберт Глумберст",          # Herbert Gloomburst
    "167301": "Шуджа Грімакс",              # Shuja Grimaxe
    "158591": "Воєначальниця Брека Грімакс",  # Warlord Breka Grimaxe
}
nn = 0
# секція імен NPC у translations.json — знайти, де лежать ці npcID
for sect in ("npcNames", "creatures", "npc", "names"):
    s = tr.get(sect)
    if isinstance(s, dict) and any(k in s for k in NAME_FIX):
        for k, v in NAME_FIX.items():
            if k in s:
                s[k] = v; nn += 1
        rep["name_section"] = sect
        break
rep["names_fixed"] = nn

# 4b) узгодити квестове "Грімекс" -> "Грімакс"
ng = 0
def fixgrim(o):
    global ng
    if isinstance(o, dict):
        return {k: fixgrim(v) for k, v in o.items()}
    if isinstance(o, list):
        return [fixgrim(v) for v in o]
    if isinstance(o, str) and "Грімекс" in o:
        ng += o.count("Грімекс"); return o.replace("Грімекс", "Грімакс")
    return o
tr = fixgrim(tr)
rep["grimaxe_unify"] = ng

TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")

# 5) broadcast FIX -> Broadcast.lua (оновити значення за точним ключем)
def esc(s):
    return (s.replace("\\", "\\\\").replace('"', '\\"')
             .replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t"))
bc = BCP.read_text(encoding="utf-8")
applied = 0
for en, ua in bfix.items():
    k = esc(en); v = esc(ua)
    pat = re.compile(r'(\["' + re.escape(k) + r'"\]\s*=\s*")(?:[^"\\]|\\.)*(")')
    bc2, c = pat.subn(lambda m: m.group(1) + v + m.group(2), bc)
    if c:
        bc = bc2; applied += 1
BCP.write_text(bc, encoding="utf-8", newline="")
rep["broadcast_lua"] = applied

print("QA застосовано:", json.dumps(rep, ensure_ascii=False))
