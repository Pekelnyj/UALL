# -*- coding: utf-8 -*-
"""Готує батчі renown-нагород тестера 24 для перекладу, з de/fr-збагаченням."""
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")

new = json.loads((B / "data/tester_new/renown.json").read_text(encoding="utf-8"))

# en -> (de,fr) з items.json + achievements.json
def load(name, sub):
    d = json.loads((B / f"data/source/{name}").read_text(encoding="utf-8-sig"))
    out = {}
    for v in d.values():
        nm = v.get(sub) if isinstance(v, dict) else None
        if isinstance(nm, dict) and nm.get("en"):
            out.setdefault(nm["en"], (nm.get("de", ""), nm.get("fr", "")))
        elif isinstance(v, dict) and isinstance(v.get("en"), str):
            out.setdefault(v["en"], (v.get("de", ""), v.get("fr", "")))
    return out

en2 = {}
en2.update(load("items.json", "name"))
try:
    ach = json.loads((B / "data/source/achievements.json").read_text(encoding="utf-8-sig"))
    for v in ach.values():
        if isinstance(v, dict) and isinstance(v.get("en"), str):
            en2.setdefault(v["en"], (v.get("de", ""), v.get("fr", "")))
        elif isinstance(v, dict) and isinstance(v.get("title"), dict):
            t = v["title"]
            if t.get("en"): en2.setdefault(t["en"], (t.get("de", ""), t.get("fr", "")))
except Exception as e:
    print("ach skip:", e)

items = []
for en in new:
    de, fr = en2.get(en, ("", ""))
    # прибрати «Title: » префікс окремо позначити
    items.append({"en": en, "de": de, "fr": fr})

# хвиля 4 = 420..кінець, батчі по 14
WAVE = items[420:]
OUT = B / "data/_rn24_in"
OUT.mkdir(exist_ok=True)
per = 14
n = 0
for i in range(0, len(WAVE), per):
    n += 1
    (OUT / f"r_{n}.json").write_text(json.dumps(WAVE[i:i+per], ensure_ascii=False, indent=1), encoding="utf-8")
hit = len([1 for x in WAVE if x["de"] or x["fr"]])
print(f"хвиля 1: {len(WAVE)} нагород у {n} батчах по {per} | з de/fr-контекстом: {hit}/{len(WAVE)}")
print(f"лишиться після хвилі 1: {len(items)-len(WAVE)}")
