# -*- coding: utf-8 -*-
"""Підготувати батчі для перекладу нових мобів. Консистентність: дедуплікація імен,
алфавітне групування (спільні префікси разом), якір існуючих EN->UA зі спільним 1-м словом + de/fr."""
import json
import sys
from collections import defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
new = json.loads((B / "data/_live_new_npc.json").read_text(encoding="utf-8-sig"))  # id->en (2311)
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
npcN = tr.get("npcNames", {})  # id->ua

# джерела з de/fr
src = {}
for f in ["creatures.json", "api_creatures_full.json"]:
    d = json.loads((B / "data/source" / f).read_text(encoding="utf-8-sig"))
    for k, v in d.items():
        if isinstance(v, dict) and "name" in v:
            src.setdefault(k, v["name"])  # {en,de,fr}

# існуючий якір EN->UA (id у джерелі І перекладений)
existing = {}
for cid, nm in src.items():
    if cid in npcN and nm.get("en"):
        existing.setdefault(nm["en"], npcN[cid])
fw_index = defaultdict(dict)  # перше слово -> {en: ua}
for en, ua in existing.items():
    fw_index[en.split()[0].lower() if en.split() else ""][en] = ua

# унікальні нові імена + de/fr
name_meta = {}
for cid, en in new.items():
    if en not in name_meta:
        meta = src.get(cid, {})
        name_meta[en] = {"de": meta.get("de", ""), "fr": meta.get("fr", "")}
uniq = sorted(name_meta)
withdefr = sum(1 for n in uniq if name_meta[n]["de"])
print(f"Нових id: {len(new)} | унікальних імен: {len(uniq)} | з них з de/fr контекстом: {withdefr}")

INDIR = B / "data/_mob_in"; INDIR.mkdir(exist_ok=True)
(B / "data/_mob_out").mkdir(exist_ok=True)
SIZE = 230
batches = [uniq[i:i + SIZE] for i in range(0, len(uniq), SIZE)]
for bi, names in enumerate(batches, 1):
    items = []
    fws = set()
    for n in names:
        items.append({"en": n, "de": name_meta[n]["de"], "fr": name_meta[n]["fr"]})
        if n.split():
            fws.add(n.split()[0].lower())
    # якір: існуючі імена зі спільним першим словом (обмежимо ~3 на слово)
    ref = {}
    for w in fws:
        for en, ua in list(fw_index.get(w, {}).items())[:3]:
            ref[en] = ua
    out = {"batch": bi, "names": items, "reference_existing": ref}
    (INDIR / f"mob_{bi:02d}.json").write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")

print(f"Батчів: {len(batches)} по ~{SIZE} імен")
print("Приклади якоря (batch_01 reference):")
b1 = json.loads((INDIR / "mob_01.json").read_text(encoding="utf-8-sig"))
for i, (en, ua) in enumerate(b1["reference_existing"].items()):
    print(f"   {en!r} -> {ua!r}")
    if i >= 6: break
