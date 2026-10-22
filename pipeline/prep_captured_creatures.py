# -*- coding: utf-8 -*-
"""Цільові батчі ЛИШЕ для зібраних у грі імен істот (db.npc), неперекладених.
Малі порції для якісного перекладу. -> data/batches/creatures_captured/cap_NN.json
"""
import sys, json, re, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

SV = glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0]
text = open(SV, encoding="utf-8", errors="replace").read()
m = re.search(r'\["npc"\]\s*=\s*\{', text)
i, depth, instr, esc = m.end(), 1, False, False
start = m.end()
while i < len(text) and depth > 0:
    c = text[i]
    if instr:
        if esc: esc = False
        elif c == "\\": esc = True
        elif c == '"': instr = False
    else:
        if c == '"': instr = True
        elif c == "{": depth += 1
        elif c == "}": depth -= 1
    i += 1
block = text[start:i - 1]
cap = re.findall(r'\["(\d+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', block)
cap_ids = {cid for cid, nm in cap if nm not in ("Unknown", "")}
print("Зібраних id:", len(cap_ids))

cr = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
done = set((tr.get("npcNames") or {}).keys())

todo = []
for cid in cap_ids:
    if cid in done:
        continue
    v = cr.get(cid)
    if not isinstance(v, dict):
        continue
    n = v.get("name", {})
    en = (n.get("en") or "").strip()
    if not en:
        continue
    todo.append({"id": cid, "en": en, "de": n.get("de", ""), "fr": n.get("fr", "")})

todo.sort(key=lambda x: x["en"].lower())
OUT = DATA_DIR / "batches" / "creatures_captured"
OUT.mkdir(parents=True, exist_ok=True)
for f in OUT.glob("*.json"):
    f.unlink()
B = 40
nb = (len(todo) + B - 1) // B
for k in range(nb):
    (OUT / f"cap_{k:02d}.json").write_text(
        json.dumps(todo[k * B:(k + 1) * B], ensure_ascii=False, indent=1), encoding="utf-8")
print(f"До перекладу (зібрані, неперекладені): {len(todo)} | батчів по {B}: {nb}")
print("Приклади:", [t["en"] for t in todo[:12]])
