# -*- coding: utf-8 -*-
"""QA-уніфікація канон-дрейфів у НОВИХ виходах хвилі (broadcast_out + out_qc_*).
Стем-префікс заміни (канон-стем + наявний суфікс = правильний відмінок)."""
import sys, json, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

# bad_stem -> good_stem (відмінкові суфікси зберігаються природно)
STEM = {
    "Пеклокрик": "Геллскрім",      # Hellscream
    "Гул'дан": "Ґул'дан",          # Gul'dan (канон ґ)
    "Сонцеступ": "Сонстрайдер",    # Sunstrider
    "Сонцекрад": "Сонцехап",       # Sunreaver (домінант)
    "Тализра": "Талісра",          # Thalyssra
    "Талиссра": "Талісра",
}
# точні токени (нестемні)
EXACT = {
    "Морозиту": "Морозну Скорботу",  # Frostmourne (зн.відм.)
    "Санрівер": "Сонцехап",
}


def fix(s):
    if not isinstance(s, str):
        return s
    for bad, good in STEM.items():
        if bad in s:
            s = s.replace(bad, good)
    for bad, good in EXACT.items():
        if bad in s:
            s = s.replace(bad, good)
    return s


n = 0
# 1) broadcast_out.json
bp = DATA_DIR / "tester_new" / "broadcast_out.json"
bo = json.loads(bp.read_text(encoding="utf-8"))
for en in list(bo):
    nv = fix(bo[en])
    if nv != bo[en]:
        bo[en] = nv
        n += 1
bp.write_text(json.dumps(bo, ensure_ascii=False, indent=1), encoding="utf-8")

# 2) out_qc_*.json (масиви {qid, fields:{поле:ua}})
qn = 0
for f in sorted(glob.glob(str(DATA_DIR / "batches" / "qcap" / "out_qc_*.json"))):
    data = json.loads(open(f, encoding="utf-8").read())
    changed = False
    for rec in data:
        flds = rec.get("fields", {})
        for k, v in list(flds.items()):
            nv = fix(v)
            if nv != v:
                flds[k] = nv
                qn += 1
                changed = True
    if changed:
        open(f, "w", encoding="utf-8").write(json.dumps(data, ensure_ascii=False, indent=1))

print(f"QA-уніфікація: broadcast полів {n} | quest-полів {qn}")
