# -*- coding: utf-8 -*-
"""Зібрати повні записи journalSections/descTemplates за префіксами з QA-звітів
+ безпечні глобальні заміни (Anger'rel, Земельний дворф)."""
import sys, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
js = tr.get("journalSections", {})
dt = tr.get("descTemplates", {})

# безпечні глобальні заміни в журнал-таблицях
GLOBAL = [("Anger'rel", "Анґер'рел"), ("Земельний дворф", "Земляний дворф"),
          ("Земельних дворф", "Земляних дворф"), ("Земельні дворф", "Земляні дворф")]
g = 0
for tbl in (js, dt, tr.get("instanceDesc", {})):
    for k, v in list(tbl.items()):
        if not isinstance(v, str):
            continue
        nv = v
        for a, b in GLOBAL:
            nv = nv.replace(a, b)
        if nv != v:
            tbl[k] = nv
            g += 1
(DATA_DIR / "translations.json").write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")

# зібрати повні записи за префіксами
issues = json.loads((DATA_DIR / "_qa_a_out.json").read_text(encoding="utf-8-sig")) + \
         json.loads((DATA_DIR / "_qa_b_out.json").read_text(encoding="utf-8-sig"))
fixin = []
for it in issues:
    pref = it.get("en", "").strip()[:35]
    if not pref:
        continue
    found = None
    for tbl_name, tbl in (("journalSections", js), ("descTemplates", dt)):
        for k, v in tbl.items():
            if k.strip().startswith(pref) or pref in k:
                found = {"tbl": tbl_name, "en": k, "ua": v}
                break
        if found:
            break
    if found:
        fixin.append({**found, "issue": it.get("issue", ""), "suggest": it.get("suggest", "")})

json.dump(fixin, open(DATA_DIR / "_qa_fix_in.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
print(f"глобальних замін: {g} | записів для фікс-агента: {len(fixin)}")
