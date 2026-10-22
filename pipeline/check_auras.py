"""Разова діагностика: стан аур паладина в базах (вкладені тултіпи)."""
import json
import io

from common import DATA_DIR

src = json.load(io.open(DATA_DIR / "source" / "spells.json", encoding="utf-8-sig"))
trans = json.load(io.open(DATA_DIR / "translations.json", encoding="utf-8-sig"))
sp = trans.get("spells", {})
done = trans.get("descTemplates", {})

for name in ("Concentration Aura", "Devotion Aura", "Crusader Aura",
             "Auras of the Resolute"):
    ids = [k for k, v in src.items() if v.get("name", {}).get("en") == name]
    if not ids:
        print(f"{name}: НЕМА В ДЖЕРЕЛІ")
    for k in ids:
        en = (src[k].get("description") or {}).get("en")
        print(f"{name} [{k}]: назва={sp.get(k, 'НЕМА')!r} | "
              f"опис: {src[k].get('descComplexity')} перекладений={bool(en and en in done)}")
        if name == "Auras of the Resolute" and en:
            print("  шаблон:", repr(en[:400]))
