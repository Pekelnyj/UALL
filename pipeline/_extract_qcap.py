# -*- coding: utf-8 -*-
"""Витяг квест-капчуру (quests/progress/completion) з живого SavedVariables,
дедуп проти translations.quests (які поля ще НЕ перекладені)."""
import sys, re, json, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

sv = open(glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0],
          encoding="utf-8", errors="replace").read()
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
tq = tr.get("quests", {})


def block(key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', sv)
    if not m:
        return None
    i, depth, start = m.end(), 1, m.end()
    instr = esc = False
    while i < len(sv) and depth > 0:
        c = sv[i]
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
    return sv[start:i - 1]


def un(s):
    return (s.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r")
             .replace("\\t", "\t").replace("\\\\", "\\"))


report = []
# progress / completion: {questID = "текст"}
for key in ["progress", "completion"]:
    b = block(key)
    if b is None:
        report.append(f"{key}: НЕМА")
        continue
    pairs = re.findall(r'\[(\d+)\]\s*=\s*"((?:[^"\\]|\\.)*)"', b)
    total = len(pairs)
    new = [(qid, un(t)) for qid, t in pairs
           if not (tq.get(qid, {}) or {}).get(key)]
    report.append(f"{key}: усього {total} | без перекладу поля: {len(new)}")
    for qid, t in new[:3]:
        report.append(f"   [{qid}] {t[:80]!r}")

# quests bucket: може містити objectives/title тощо
b = block("quests")
if b is not None:
    qids = re.findall(r'\[(\d+)\]\s*=\s*\{', b)
    report.append(f"quests: {len(qids)} questID-блоків (objectives/title капчур)")

(DATA_DIR / "_qcap.txt").write_text("\n".join(report), encoding="utf-8")
print("\n".join(report))
