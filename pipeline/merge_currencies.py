"""Злиття перекладених валют у translations.json["currencies"].

Вхід: data/batches/currencies/out_NN.json  [{id, ua, desc_ua?}]
Дія:  translations["currencies"][str(id)] = {"name": ua, "desc": desc_ua?}
Ідемпотентно. Далі запусти generate_db.py, щоб оновити Currencies.lua.
"""

import json

from common import DATA_DIR

BD = DATA_DIR / "batches" / "currencies"
TR = DATA_DIR / "translations.json"


def main():
    t = json.loads(TR.read_text(encoding="utf-8-sig"))
    cur = t.setdefault("currencies", {})
    merged = 0
    for path in sorted(BD.glob("out_*.json")):
        try:
            items = json.loads(path.read_text(encoding="utf-8-sig"))
        except json.JSONDecodeError:
            print(f"  ПРОПУСК (битий json): {path.name}")
            continue
        for it in items:
            cid = it.get("id")
            ua = (it.get("ua") or "").strip()
            if cid is None or not ua:
                continue
            entry = {"name": ua}
            desc = (it.get("desc_ua") or "").strip()
            if desc:
                entry["desc"] = desc
            cur[str(cid)] = entry
            merged += 1
    TR.write_text(json.dumps(t, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Валют злито: {merged} | у базі: {len(cur)}")


if __name__ == "__main__":
    main()
