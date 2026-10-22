# -*- coding: utf-8 -*-
"""Нормалізація Табард(чол.) → Накидка(жін.) з узгодженням роду прикметників.
Рішення користувача: САМЕ «Накидка» (домінує 595:175)."""
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")
P = Path("g:/Claude Code/WoWUkraine/data/translations.json")
tr = json.loads(P.read_text(encoding="utf-8-sig"))

# 1) відмінкові форми (мало, але точно)
DECL = [
    ("Табардами", "Накидками"), ("Табардів", "Накидок"), ("Табардам", "Накидкам"),
    ("Табардом", "Накидкою"), ("Табарді", "Накидці"), ("Табарда", "Накидки"),
    ("Табарди", "Накидки"), ("Табард", "Накидка"),
]

def masc_to_fem(adj):
    # тверда група: -ий→-а ; м'яка: -ій→-я
    if adj.endswith("ій"):
        return adj[:-2] + "я"
    if adj.endswith("ий"):
        return adj[:-2] + "а"
    return adj

# прогін прикметникового ланцюга перед «Накидка»
ADJRUN = re.compile(r'((?:[А-ЯІЇЄҐа-яіїєґ\'-]+(?:ий|ій)\s+)+)Накидка')
def fix_gender(s):
    def rep(m):
        run = m.group(1)
        words = run.split()
        words = [masc_to_fem(w) for w in words]
        return " ".join(words) + " Накидка"
    return ADJRUN.sub(rep, s)

cnt = {"decl": 0, "gender": 0}
def conv(s):
    orig = s
    for a, b in DECL:
        if a in s:
            cnt["decl"] += s.count(a)
            s = s.replace(a, b)
    ns = fix_gender(s)
    if ns != s:
        cnt["gender"] += 1
    return ns

def walk(v):
    if isinstance(v, str):
        return conv(v)
    if isinstance(v, dict):
        return {k: walk(x) for k, x in v.items()}
    if isinstance(v, list):
        return [walk(x) for x in v]
    return v

tr = walk(tr)
P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Табард→Накидка замін: {cnt['decl']} | рід прикметників виправлено у {cnt['gender']} рядках")

# контроль: лишки «...ий/ій Накидка» (мали б зникнути)
blob = json.dumps(tr, ensure_ascii=False)
left = re.findall(r'[А-ЯІЇЄҐа-яіїєґ]+(?:ий|ій)\s+Накидка', blob)
print("залишок неузгоджених (перевір):", len(left), left[:8])
print("Табард, що лишилось:", len(re.findall(r'Табард', blob)))
