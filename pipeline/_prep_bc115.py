# -*- coding: utf-8 -*-
"""Підготувати неперекладені BroadcastText (за живим білдом) із de/fr-звіркою
та сценним контекстом (сусідні ID). Відновити .latest для de/fr."""
import sys, csv, io, json, shutil
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

W = DATA_DIR / "wago"
BUILD = "12.0.7.68256"

# відновити .latest для de/fr (звірка роду/тону)
for loc in ("deDE", "frFR"):
    src = W / f"BroadcastText.{loc}.{BUILD}.csv"
    if src.exists():
        shutil.copy(src, W / f"BroadcastText.{loc}.latest.csv")


def load(loc, build=BUILD):
    d = {}
    for r in csv.DictReader(open(W / f"BroadcastText.{loc}.{build}.csv", encoding="utf-8")):
        t = (r.get("Text_lang", "") or "").strip()
        if t:
            d[int(r["ID"])] = t
    return d


en, de, fr = load("enUS"), load("deDE"), load("frFR")
bl = (DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua").read_text(encoding="utf-8")


def esc(s):
    return (s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n").replace("\r", "\\r"))


untr = sorted(i for i, t in en.items() if '["' + esc(t) + '"]' not in bl)
# згрупувати в сцени (різниця ID <=3) для контексту
items = []
for i in untr:
    scene = [en[j] for j in range(i - 2, i + 3) if j in en]
    items.append({
        "id": i,
        "en": en[i],
        "de": de.get(i, ""),
        "fr": fr.get(i, ""),
        "scene_context": " / ".join(scene),
    })
json.dump(items, open(DATA_DIR / "tester_all" / "bc115.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
print(f"неперекладених BroadcastText: {len(items)} (de/fr .latest відновлено)")
# розподіл за типами
garr = sum(1 for x in items if "\n\nLevel" in x["en"])
print(f"  гарнізон-будівлі (X\\n\\nLevel N): {garr} | інше (діалоги/лор): {len(items)-garr}")
