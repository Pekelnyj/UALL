# -*- coding: utf-8 -*-
"""Злити out_us_*.json + _dbui_auto.json у translations.globalStrings. Валідація +
QA-уніфікація Nameplate→панель імен."""
import sys, json, glob, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
gs = tr.setdefault("globalStrings", {})

merged = {}
# формульні (скрипт)
merged.update(json.loads((DATA_DIR / "_dbui_auto.json").read_text(encoding="utf-8")))
# агенти
for f in sorted(glob.glob(str(DATA_DIR / "batches" / "uistr" / "out_us_*.json"))):
    data = json.loads(open(f, encoding="utf-8-sig").read())
    for en, ua in data.items():
        if isinstance(ua, str) and ua.strip():
            merged[en] = ua

# QA-уніфікація Nameplate → «панель імен» (канон UI-словника)
NP = [
    (re.compile(r"\bтабличк[аиіу] з іменами\b", re.I), "панель імен"),
    (re.compile(r"\bтаблич(?:ка|ки|ку|ці|ок)\b", re.I), "панель імен"),
    (re.compile(r"\bнеймплейт(?:и|а|ів|ах|ом)?\b", re.I), "панель імен"),
]
qa = 0
for en, ua in list(merged.items()):
    nv = ua
    if "ameplate" in en.lower() or "табличк" in ua.lower() or "неймплейт" in ua.lower():
        for rx, rep in NP:
            nv = rx.sub(rep, nv)
    if nv != ua:
        merged[en] = nv
        qa += 1

# залити (не перетираємо вже наявне краще? — ці нові, тож додаємо/оновлюємо)
add = 0
for en, ua in merged.items():
    if gs.get(en) != ua:
        gs[en] = ua
        add += 1

P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"злито рядків: {len(merged)} | додано/оновлено в globalStrings: {add} | QA Nameplate: {qa}")
print(f"globalStrings усього: {len(gs)}")
