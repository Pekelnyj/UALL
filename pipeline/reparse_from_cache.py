# -*- coding: utf-8 -*-
"""Перепарсити ВСІ кешовані сторінки Wowhead ЛОКАЛЬНО (нуль звернень до мережі) і
оновити data/source/wowhead_quests.json. Для будь-якого майбутнього фіксу парсера
чи нового поля: полагодив parse() → запустив це → за хвилини всі поля оновлені,
БЕЗ жодної перекачки. Саме те, чого нам бракувало, коли загубили objectives.

Запуск:  python pipeline/reparse_from_cache.py
"""
import gzip, glob, json, os, sys
sys.stdout.reconfigure(encoding="utf-8")
from extract_wowhead_quests import parse, HTML_CACHE, OUT

got = json.load(open(OUT, encoding="utf-8-sig")) if os.path.exists(OUT) else {}
files = glob.glob(os.path.join(HTML_CACHE, "*.html.gz"))
print(f"кешованих сторінок: {len(files):,}")
updated = 0; new_fields = 0
for i, fp in enumerate(files):
    qid = os.path.basename(fp)[:-len(".html.gz")]
    try:
        with gzip.open(fp, "rt", encoding="utf-8") as f:
            h = f.read()
    except Exception:
        continue
    p = parse(h)
    old = got.get(qid, {}) if isinstance(got.get(qid), dict) else {}
    merged = {**old, **{k: v for k, v in p.items() if v}}
    if merged != old:
        new_fields += len(set(k for k in merged if merged[k]) - set(k for k in old if old.get(k)))
        got[qid] = merged; updated += 1
    if (i + 1) % 500 == 0:
        print(f"  {i+1}/{len(files)}…")
json.dump(got, open(OUT, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"\n✅ перепарсено {len(files):,} сторінок з кешу | оновлено квестів: {updated:,} | нових полів: {new_fields:,}")
print(f"   → {OUT}  (жодного звернення до Wowhead)")
