"""Злиття перекладених батчів назв спелів у translations.json.

Читає data/talent_batches/out_NN.json ({en: ua}) і застосовує переклад
до ВСІХ spellID з цією англійською назвою (консистентність між талантами
і скілами безкоштовно).

Використання:
    python merge_spell_batches.py
"""

import json
import io

from common import DATA_DIR

BATCH_DIR = DATA_DIR / "talent_batches"


def main():
    src = json.load(io.open(DATA_DIR / "source" / "spells.json", encoding="utf-8-sig"))
    trans_path = DATA_DIR / "translations.json"
    trans = json.load(io.open(trans_path, encoding="utf-8-sig"))
    spells_tr = trans.setdefault("spells", {})

    name_to_ua = {}
    for out in sorted(BATCH_DIR.glob("out_*.json")):
        data = json.loads(out.read_text(encoding="utf-8-sig"))
        bad = [en for en, ua in data.items() if not isinstance(ua, str) or not ua.strip()]
        if bad:
            print(f"  УВАГА {out.name}: порожні значення {bad[:5]}")
        for en, ua in data.items():
            if isinstance(ua, str) and ua.strip():
                name_to_ua.setdefault(en, ua.strip())

    applied = new_ids = 0
    for sid, e in src.items():
        en = e.get("name", {}).get("en")
        ua = en and name_to_ua.get(en)
        if not ua:
            continue
        if sid not in spells_tr:
            new_ids += 1
        if spells_tr.get(sid) != ua:
            spells_tr[sid] = ua
            applied += 1

    trans_path.write_text(json.dumps(trans, ensure_ascii=False, indent=1),
                          encoding="utf-8")
    print(f"Назв із батчів: {len(name_to_ua)} | застосовано до spellID: {applied} "
          f"(нових: {new_ids}) | усього спелів перекладено: {len(spells_tr)}")


if __name__ == "__main__":
    main()
