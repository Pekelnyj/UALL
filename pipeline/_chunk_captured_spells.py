# -*- coding: utf-8 -*-
"""Розбити captured_spells.json на батчі для хвилі перекладу:
  назви -> data/batches/spellname/sn_NN.json  [{id,name_en,name_de,name_fr}]
  описи -> data/batches/spelldesc/sd_NN.json  [{id,desc_en,desc_de,desc_fr}]
Чистить старі sn_/sd_ та out-файли. Друкує кількість батчів."""
import sys, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

data = json.loads((DATA_DIR / "captured_spells.json").read_text(encoding="utf-8"))

# ДЕДУП ПРОТИ БАЗИ. Його тут не було зовсім: скрипт різав на порції ВСЕ, що
# лежало в captured_spells.json, включно з давно перекладеним. 12.09 це
# коштувало цілого агента — усі 59 ID порції вже були в translations.spells,
# і хвиля відпрацювала по готовому [[count-unique-texts-not-ids]].
_tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
_have_n = {str(k) for k, v in (_tr.get("spells") or {}).items() if v}
_have_d = {str(k) for k, v in (_tr.get("spellDescriptions") or {}).items() if v}

_all_n = [e for e in data if e.get("name_en")]
_all_d = [e for e in data if e.get("desc_en") and not e.get("name_en")]
names = [e for e in _all_n if str(e.get("id")) not in _have_n]
descs = [e for e in _all_d if str(e.get("id")) not in _have_d]
print(f"назв: {len(_all_n)} зібрано, {len(_all_n) - len(names)} уже в базі "
      f"-> у чергу {len(names)}")
print(f"описів: {len(_all_d)} зібрано, {len(_all_d) - len(descs)} уже в базі "
      f"-> у чергу {len(descs)}")

def chunk(items, sub, name, size):
    d = DATA_DIR / "batches" / sub
    d.mkdir(parents=True, exist_ok=True)
    for f in d.glob(name + "_*.json"):
        f.unlink()
    nb = (len(items) + size - 1) // size if items else 0
    for k in range(nb):
        (d / f"{name}_{k:02d}.json").write_text(
            json.dumps(items[k * size:(k + 1) * size], ensure_ascii=False, indent=1),
            encoding="utf-8")
    return nb

nb_n = chunk(names, "spellname", "sn", 40)
nb_d = chunk(descs, "spelldesc", "sd", 20)

# теки виходу
for sub in ("spell_names_out", "spell_descs_out"):
    od = DATA_DIR / sub
    od.mkdir(parents=True, exist_ok=True)
    for f in od.glob("*.json"):
        f.unlink()

print(f"назв: {len(names)} -> sn-батчів {nb_n}")
print(f"описів: {len(descs)} -> sd-батчів {nb_d}")
print(f"УСЬОГО spell-батчів: {nb_n + nb_d}")
