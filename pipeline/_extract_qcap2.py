# -*- coding: utf-8 -*-
"""Парс db.quests = {[qid]={title,objectives,progress,completion,...}} з живого SV.
Показує, які квести/поля ще не перекладені в translations.quests."""
import sys, re, json, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

SVPATH = sys.argv[1] if len(sys.argv) > 1 else glob.glob(
    r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0]
sv = open(SVPATH, encoding="utf-8", errors="replace").read()
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
tq = tr.get("quests", {})

m = re.search(r'\["quests"\]\s*=\s*\{', sv)
i, depth, start = m.end(), 1, m.end()
instr = esc = False
while i < len(sv) and depth > 0:
    c = sv[i]
    if instr:
        if esc: esc = False
        elif c == "\\": esc = True
        elif c == '"': instr = False
    else:
        if c == '"': instr = True
        elif c == "{": depth += 1
        elif c == "}": depth -= 1
    i += 1
qb = sv[start:i - 1]


def un(s):
    return (s.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r")
             .replace("\\t", "\t").replace("\\\\", "\\"))


# розбити на блоки [qid] = { ... }
out = {}
for mm in re.finditer(r'\[(\d+)\]\s*=\s*\{', qb):
    qid = mm.group(1)
    j, d2, s2 = mm.end(), 1, mm.end()
    ins = es = False
    while j < len(qb) and d2 > 0:
        c = qb[j]
        if ins:
            if es: es = False
            elif c == "\\": es = True
            elif c == '"': ins = False
        else:
            if c == '"': ins = True
            elif c == "{": d2 += 1
            elif c == "}": d2 -= 1
        j += 1
    body = qb[s2:j - 1]
    fields = {}
    for f, v in re.findall(r'\["?(\w+)"?\]\s*=\s*"((?:[^"\\]|\\.)*)"', body):
        fields[f] = un(v)
    out[qid] = fields

report = []
NEWfields = {}
for qid, f in out.items():
    have = tq.get(qid, {}) or {}
    missing = [k for k in ("title", "description", "objectives", "progress", "completion")
               if f.get(k) and not have.get(k)]
    tag = "НОВИЙ" if qid not in tq else ("частк." if missing else "повний")
    report.append(f"[{qid}] {tag} | поля в капчурі: {list(f)} | бракує перекладу: {missing}")
    if missing:
        NEWfields[qid] = {k: f[k] for k in missing}
    report.append(f"     title={f.get('title','')[:60]!r}")

(DATA_DIR / "tester_all" / "qcap.json").write_text(
    json.dumps({"all": out, "newfields": NEWfields}, ensure_ascii=False, indent=1), encoding="utf-8")
(DATA_DIR / "_qcap.txt").write_text("\n".join(report), encoding="utf-8")
print(f"квестів у капчурі: {len(out)} | з неперекладеними полями: {len(NEWfields)}")
