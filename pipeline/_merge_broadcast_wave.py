# -*- coding: utf-8 -*-
"""Злити out_NN.json broadcast-хвилі, ВАЛІДУВАТИ точний збіг ключів проти bc_NN,
звести у tester_new/broadcast_out.json. Звітувати розбіжності/пропуски."""
import sys, json, glob, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

BD = DATA_DIR / "batches" / "broadcast"
merged = {}
miss_total = 0
mismatch = 0
for inp in sorted(BD.glob("bc_*.json")):
    n = inp.stem.split("_")[1]
    outp = BD / f"out_{n}.json"
    items = json.loads(inp.read_text(encoding="utf-8"))
    want = [it["en"] for it in items]
    if not outp.exists():
        print(f"!! НЕМА out_{n}.json ({len(want)} записів)")
        miss_total += len(want)
        continue
    got = json.loads(outp.read_text(encoding="utf-8"))
    for en in want:
        if en not in got:
            print(f"  [{n}] ПРОПУЩЕНО ключ: {en[:60]!r}")
            miss_total += 1
            continue
        ua = got[en]
        if not isinstance(ua, str) or not ua.strip():
            print(f"  [{n}] ПОРОЖНІЙ переклад: {en[:60]!r}")
            continue
        # переклад має містити кирилицю (не лишився англ.) — окрім чистих вигуків
        if not re.search(r"[А-Яа-яЇїІіЄєҐґ]", ua) and re.search(r"[A-Za-z]{4}", ua):
            print(f"  [{n}] ?англ. лишок: {en[:40]!r} -> {ua[:40]!r}")
        # {NAME} збережено?
        if "{NAME}" in en and "{NAME}" not in ua:
            print(f"  [{n}] ВТРАЧЕНО {{NAME}}: {en[:50]!r}")
            mismatch += 1
        merged[en] = ua
    # НАВМИСНО перекльованi рядки: перекладач замiнює запечений клас/iм'я на
    # {class}/{NAME}, тож ключа з батчу вже немає, а натомість з'являється
    # ширший шаблон. Ранiше звiрка «точно як у bc_NN» тихо викидала їх у
    # «ПРОПУЩЕНО», i рядок не потрапляв у базу.
    extra = [k for k in got if k not in set(want)]
    for k in extra:
        if isinstance(got[k], str) and got[k].strip():
            print(f"  [{n}] переключовано: {k[:60]!r}")
            merged[k] = got[k]

print(f"\nЗлито пар: {len(merged)} | пропущено: {miss_total} | втрат {{NAME}}: {mismatch}")
OUT = DATA_DIR / "tester_new"
OUT.mkdir(parents=True, exist_ok=True)
(OUT / "broadcast_out.json").write_text(
    json.dumps(merged, ensure_ascii=False, indent=1), encoding="utf-8")
print("-> tester_new/broadcast_out.json")
