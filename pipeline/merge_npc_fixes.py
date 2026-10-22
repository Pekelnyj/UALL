"""Злити виправлення imen (out_*.json: en->новий_ua) у translations.json (id->ua).
Мапимо en->id через creatures.json."""
import json, glob
from common import DATA_DIR

# 1) зібрати всі виправлення en->ua
fixes = {}
for p in sorted(glob.glob(str(DATA_DIR / "npc_review" / "out_*.json"))):
    d = json.loads(open(p, encoding="utf-8-sig").read())
    fixes.update(d)
print(f"виправлень (en->ua): {len(fixes)}")

# 2) en -> [id] з creatures.json
C = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
en2ids = {}
for cid, v in C.items():
    en = (v.get("name") or {}).get("en")
    if en:
        en2ids.setdefault(en, []).append(cid)

# 3) оновити translations.json npcNames за id
T = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
npc = T.setdefault("npcNames", {})
upd = 0
miss = []
for en, ua in fixes.items():
    ids = en2ids.get(en)
    if not ids:
        miss.append(en)
        continue
    for cid in ids:
        npc[str(cid)] = ua
        upd += 1

(DATA_DIR / "translations.json").write_text(
    json.dumps(T, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"оновлено записів npcNames (за id): {upd}")
if miss:
    print(f"не знайдено en у creatures.json: {len(miss)} (приклади): {miss[:5]}")
