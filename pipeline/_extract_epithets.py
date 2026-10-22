# -*- coding: utf-8 -*-
"""Витяг усіх входжень описових епітетів з локатором+контекстом для агента."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
FORMS = ["Пеклокрик", "Кровокопит", "Кривавокопит", "Тіньоспів", "Бронзоборід",
         "Шепіт Вітру", "Молот Долі", "Чорнорук", "Чорнодих"]
rx = re.compile("|".join(FORMS))

out = []
for tname, tbl in tr.items():
    if not isinstance(tbl, dict):
        continue
    for k, v in tbl.items():
        if isinstance(v, str):
            if rx.search(v):
                out.append({"loc": f"{tname}||{k}||_", "ua": v})
        elif isinstance(v, dict):
            for sub, vv in v.items():
                if isinstance(vv, str) and rx.search(vv):
                    out.append({"loc": f"{tname}||{k}||{sub}", "ua": vv})

json.dump(out, open(DATA_DIR / "_epithet_in.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
print(f"входжень для агента: {len(out)}")
