# -*- coding: utf-8 -*-
"""Чанкер Stage 2 для ОДНОГО рейду (після journal_coverage <iid> --dump):
описи абілок (gap_desc, лише ті, що мають реальний текст, не чисте $@spelldesc-посилання)
+ секції (gap_sec) в батчі. Запуск: python _chunk_raid.py <outdir> [dsize] [ssize]"""
import sys, json, os, re
sys.stdout.reconfigure(encoding="utf-8")

outdir = sys.argv[1]
DSZ = int(sys.argv[2]) if len(sys.argv) > 2 else 37
SSZ = int(sys.argv[3]) if len(sys.argv) > 3 else 36
os.makedirs(outdir + "/desc", exist_ok=True)
os.makedirs(outdir + "/sec", exist_ok=True)
for sub in ("desc", "sec"):
    for f in os.listdir(outdir + "/" + sub):
        os.remove(outdir + "/" + sub + "/" + f)

src = json.load(open("data/source/spells.json", encoding="utf-8-sig"))
gap_desc = json.load(open("data/jcov/gap_desc.json", encoding="utf-8-sig"))
gap_sec = json.load(open("data/jcov/gap_sec.json", encoding="utf-8-sig"))

PURE = re.compile(r"^\$@spelldesc\d+s?$")
need = []
skipped = 0
for sid in gap_desc:
    e = src.get(str(sid), {})
    d = e.get("description") if isinstance(e, dict) else None
    en = d.get("en") if isinstance(d, dict) else None
    if not en or PURE.match(en.strip()):
        skipped += 1
        continue
    need.append({"id": sid, "en": en, "de": (d.get("de") or ""), "fr": (d.get("fr") or "")})

nd = 0
for i in range(0, len(need), DSZ):
    nd += 1
    json.dump(need[i:i + DSZ], open(f"{outdir}/desc/d_{nd:02d}.json", "w", encoding="utf-8"),
              ensure_ascii=False, indent=1)
ns = 0
for i in range(0, len(gap_sec), SSZ):
    ns += 1
    json.dump(gap_sec[i:i + SSZ], open(f"{outdir}/sec/s_{ns:02d}.json", "w", encoding="utf-8"),
              ensure_ascii=False, indent=1)

print(f"описи(реальні): {len(need)} → {nd} батчів | чисті-посилання пропущено: {skipped} | "
      f"секції: {len(gap_sec)} → {ns} батчів")
