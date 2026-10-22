# -*- coding: utf-8 -*-
"""QA-уніфікація канон-дрейфів у out-файлах хвилі (broadcast/gossip/quests)."""
import sys, json, glob, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

# стем-заміни (канон-стем + наявний суфікс)
STEM = {
    "Дарксрайдер": "Даркстрайдер",   # Darkstrider (канон)
    "чемпіон": "поборник",            # champion (глосарій)
    "Сій'та": "Сідж'та",              # Sij'ta (j→дж, як Zul'jin)
    "Пеклокрик": "Геллскрім",
    "Гул'дан": "Ґул'дан",
    "Сонцеступ": "Сонстрайдер",
    "Морозит": "Морозн",              # Frostmourne (рідкісний дрейф)
}


def fix(s):
    if not isinstance(s, str):
        return s
    for bad, good in STEM.items():
        if bad in s:
            s = s.replace(bad, good)
    return s


def proc_kv(path):
    d = json.loads(open(path, encoding="utf-8-sig").read())
    n = 0
    for k in list(d):
        nv = fix(d[k])
        if nv != d[k]:
            d[k] = nv
            n += 1
    if n:
        open(path, "w", encoding="utf-8").write(json.dumps(d, ensure_ascii=False, indent=1))
    return n


def proc_quests(path):
    d = json.loads(open(path, encoding="utf-8-sig").read())
    n = 0
    for rec in d:
        for f, v in list(rec.get("fields", {}).items()):
            nv = fix(v)
            if nv != v:
                rec["fields"][f] = nv
                n += 1
    if n:
        open(path, "w", encoding="utf-8").write(json.dumps(d, ensure_ascii=False, indent=1))
    return n


tot = 0
for f in glob.glob(str(DATA_DIR / "batches" / "broadcast" / "out_0*.json")):
    tot += proc_kv(f)
for f in glob.glob(str(DATA_DIR / "batches" / "gossip" / "out_g_*.json")):
    tot += proc_kv(f)
for f in glob.glob(str(DATA_DIR / "batches" / "qcap" / "out_qc_*.json")):
    tot += proc_quests(f)
print(f"QA-замін у виходах хвилі: {tot}")
