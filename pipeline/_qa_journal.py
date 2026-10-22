# -*- coding: utf-8 -*-
"""(А) Вибірка нових журнал-секцій+абілок (Wrath/TBC/Classic) для незалежного QA.
(Б) Скан заборонених термінів/кальок у журнал-перекладах."""
import sys, json, glob, random, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

random.seed(42)
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
js = tr.get("journalSections", {})
dt = tr.get("descTemplates", {})

# (А) вибірка: EN-секції з sec/s_*.json 3 тірів + їх UA з journalSections
def collect_sec(tier):
    ens = []
    for f in glob.glob(str(DATA_DIR / f"jdung_{tier}" / "sec" / "s_*.json")):
        ens += json.loads(open(f, encoding="utf-8-sig").read())
    return ens

def collect_desc(tier):
    out = {}
    for f in glob.glob(str(DATA_DIR / f"jdung_{tier}" / "desc" / "dout_*.json")):
        out.update(json.loads(open(f, encoding="utf-8-sig").read()))
    # wrath: dout.json
    p = DATA_DIR / "descgap2" / "dout.json"
    return out

sample = []
for tier in ("wrath", "tbc", "classic"):
    ens = collect_sec(tier)
    random.shuffle(ens)
    for en in ens[:18]:
        ua = js.get(en)
        if ua:
            sample.append({"tier": tier, "type": "section", "en": en[:400], "ua": ua[:400]})
# абілки
allab = {}
for f in glob.glob(str(DATA_DIR / "jdung_classic" / "desc" / "dout_*.json")):
    allab.update(json.loads(open(f, encoding="utf-8-sig").read()))
allab.update(json.loads((DATA_DIR / "descgap2" / "dout.json").read_text(encoding="utf-8-sig")))
items = list(allab.items())
random.shuffle(items)
for en, ua in items[:15]:
    sample.append({"type": "ability", "en": en[:400], "ua": ua[:400]})

json.dump(sample, open(DATA_DIR / "_qa_sample.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)

# (Б) скан заборонених
FORBIDDEN = {
    "Запределля": "Аутленд (рос. калька)",
    "румак": "бойовий кінь (рідкісне)",
    "маніяк": "очманілий (Crazed)",
    "Сонцеступ": "Сонстрайдер (поки транслітерація)",
    "покрит": "перевірити/опрацьовано (англіцизм)",
    "на протязі": "протягом (русизм)",
    "слідуючий": "наступний (русизм)",
    "міроприємств": "захід (русизм)",
    "приймати участь": "брати участь (русизм)",
    "Мармур": "Мурмур (камінь!)",
}
hits = {}
for tbl_name, tbl in (("journalSections", js), ("descTemplates", dt),
                      ("instanceDesc", tr.get("instanceDesc", {}))):
    for k, v in tbl.items():
        if not isinstance(v, str):
            continue
        for bad, why in FORBIDDEN.items():
            if bad.lower() in v.lower():
                hits.setdefault(bad + " → " + why, []).append((tbl_name, v[:80]))

print(f"QA-вибірка: {len(sample)} (секції+абілки 3 тірів)")
print("\n=== ЗАБОРОНЕНІ ТЕРМІНИ В ЖУРНАЛІ ===")
if not hits:
    print("  чисто — порушень не знайдено")
for key, lst in hits.items():
    print(f"  ⚠ {key}: {len(lst)}")
    for tn, ex in lst[:2]:
        print(f"      [{tn}] {ex!r}")
