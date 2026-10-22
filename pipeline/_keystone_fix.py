# -*- coding: utf-8 -*-
"""SOURCE-AWARE фікс: Keystone → «ключ» (НЕ «наріжний камінь»), глос. §459.
Чіпаємо ЛИШЕ записи, де EN містить 'Keystone' (щоб не зачепити справжній
Cornerstone=наріжний камінь). Відмінки зберігаємо."""
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
P = B / "data/translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
qsrc = json.loads((B / "data/source/quests.json").read_text(encoding="utf-8-sig"))
asrc = json.loads((B / "data/source/achievements.json").read_text(encoding="utf-8-sig"))

# «наріжн{прикметник} камін/камен{відмінок}» → «ключ{відмінок}» (прикметник «наріжний» прибираємо)
NOUN = {"камінь": "ключ", "каменя": "ключа", "каменю": "ключу", "камені": "ключі",
        "каменем": "ключем", "каменів": "ключів", "каменям": "ключам",
        "каменями": "ключами", "камінню": "ключами"}
PAT = re.compile(r"наріжн\w+\s+(" + "|".join(NOUN) + r")")
def fix_text(s):
    return PAT.sub(lambda m: NOUN[m.group(1)], s)

def en_quest(qid):
    v = qsrc.get(qid, {})
    out = ""
    for f in ("title", "description"):
        n = v.get(f)
        if isinstance(n, dict): out += " " + (n.get("en", "") or "")
    return out
def en_ach(aid):
    v = asrc.get(aid, {})
    out = ""
    for f in ("title", "desc"):
        n = v.get(f)
        if isinstance(n, dict): out += " " + (n.get("en", "") or "")
    return out

n = 0
# quests / achievements — гейт по EN із джерела
for qid, uv in tr.get("quests", {}).items():
    if isinstance(uv, dict) and "Keystone" in en_quest(qid):
        for f in ("title", "description", "objectives", "progress", "completion"):
            if isinstance(uv.get(f), str):
                nv = fix_text(uv[f])
                if nv != uv[f]: uv[f] = nv; n += 1
for aid, uv in tr.get("achievements", {}).items():
    if isinstance(uv, dict) and "Keystone" in en_ach(aid):
        for f in ("title", "desc"):
            if isinstance(uv.get(f), str):
                nv = fix_text(uv[f])
                if nv != uv[f]: uv[f] = nv; n += 1
# EN-keyed секції — ключ і Є EN
for sect in ("questObjectives", "itemNames", "uiTooltips", "globalStrings", "spells"):
    d = tr.get(sect, {})
    for k in list(d):
        if "Keystone" in str(k) and isinstance(d[k], str):
            nv = fix_text(d[k])
            if nv != d[k]: d[k] = nv; n += 1

P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"виправлено наріжний→ключ (EN=Keystone): {n}")
