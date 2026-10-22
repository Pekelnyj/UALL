# -*- coding: utf-8 -*-
"""Злити переклад професій: out_pu_*.json -> translations.globalStrings (UI-лейбли),
out_pd_*.json -> translations.profDesc (описи спеціалізацій). Кирилиця обов'язкова."""
import sys, json, glob, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

CYR = re.compile("[Ѐ-ӿ]")
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))


def merge(sub, name, target):
    bucket = tr.setdefault(target, {})
    add = 0
    for f in sorted(glob.glob(str(DATA_DIR / "batches" / sub / ("out_" + name + "_*.json")))):
        d = json.loads(open(f, encoding="utf-8-sig").read())
        for en, ua in d.items():
            if isinstance(ua, str) and ua.strip() and CYR.search(ua) and bucket.get(en) != ua:
                bucket[en] = ua
                add += 1
    print(f"{target}: +{add} (разом {len(bucket)})")


merge("profui", "pu", "globalStrings")
merge("profdesc", "pd", "profDesc")
P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
