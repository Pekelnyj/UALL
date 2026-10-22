# -*- coding: utf-8 -*-
# Зливає вихід агентів-перекладачів заклять у translations.json.
#   data/spell_names_out/*.json : {spellID: "ua назва"}
#   data/spell_descs_out/*.json : {"en опис": "ua шаблон"}
# Кирилиця обов'язкова; порожні/латинські відкидаємо. Потім запусти generate_db.py.
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"
CYR = re.compile("[Ѐ-ӿ]")
tr = json.loads((DATA / "translations.json").read_text(encoding="utf-8-sig"))

def merge(sub, target, label):
    d = DATA / sub
    bucket = tr.setdefault(target, {})
    added = skipped = 0
    if not d.exists():
        print(f"{label}: нема теки {sub}"); return
    for f in sorted(d.glob("*.json")):
        try:
            data = json.loads(f.read_text(encoding="utf-8-sig"))
        except Exception as e:
            print(f"  ПОМИЛКА {f.name}: {e}"); continue
        for k, v in data.items():
            if not isinstance(v, str) or not v.strip() or not CYR.search(v):
                skipped += 1; continue
            bucket[str(k)] = v
            added += 1
    print(f"{label}: додано {added}, пропущено {skipped}, разом у базі {len(bucket)}")

merge("spell_names_out", "spells", "НАЗВИ заклять")
merge("spell_descs_out", "descTemplates", "ОПИСИ заклять")

(DATA / "translations.json").write_text(
    json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print("translations.json збережено. Далі: python pipeline/generate_db.py")
