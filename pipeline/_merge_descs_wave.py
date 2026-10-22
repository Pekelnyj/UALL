# -*- coding: utf-8 -*-
"""Злити out_d_*.json (описи опцій) у globalStrings + QA Nameplate→панель імен."""
import sys, json, glob, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
gs = tr.setdefault("globalStrings", {})

NP = [
    (re.compile(r"\bіменн[аиіу]х? табличк\w*", re.I), "панель імен"),
    (re.compile(r"\bтабличк[аиіуо]\w* з іменами", re.I), "панель імен"),
    (re.compile(r"\bтаблич(?:к[аиіуо]\w*|ці|ок)", re.I), "панель імен"),
    (re.compile(r"\bнеймплейт\w*", re.I), "панель імен"),
]


def qa(ua):
    nv = ua
    if "таблич" in ua.lower() or "неймплейт" in ua.lower():
        for rx, rep in NP:
            nv = rx.sub(rep, nv)
    return nv


merged, qan, eng = {}, 0, 0
for f in sorted(glob.glob(str(DATA_DIR / "batches" / "descs" / "out_d_*.json"))):
    data = json.loads(open(f, encoding="utf-8-sig").read())
    for en, ua in data.items():
        if not isinstance(ua, str) or not ua.strip():
            continue
        nv = qa(ua)
        if nv != ua:
            qan += 1
        if not re.search(r"[А-Яа-яЇїІіЄєҐґ]", nv) and re.search(r"[A-Za-z]{5}", nv):
            eng += 1  # підозра на неперекладене
        merged[en] = nv

add = 0
for en, ua in merged.items():
    if gs.get(en) != ua:
        gs[en] = ua
        add += 1

P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"описів злито: {len(merged)} | додано/оновлено: {add} | QA Nameplate: {qan} | англ?: {eng}")
print(f"globalStrings усього: {len(gs)}")
