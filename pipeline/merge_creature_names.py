"""Зливає переклади імен NPC (out_*.json) у translations.json -> ключ 'npcNames'.

Читає data/batches/creatures/out_*.json ([{id, ua}]), відкидає порожні/збіги,
ловить рос. літери ы/ъ/э/ё, додає у translations.json і регенерує бази.
"""
import glob
import json
import re

from common import DATA_DIR

TR = DATA_DIR / "translations.json"
SRC = DATA_DIR / "source" / "creatures.json"
OUT = DATA_DIR / "batches" / "creatures"
RUS = re.compile("[ыъэёЫЪЭЁ]")


def main():
    tr = json.loads(TR.read_text(encoding="utf-8-sig")) if TR.exists() else {}
    src = json.loads(SRC.read_text(encoding="utf-8-sig"))
    npc = tr.get("npcNames", {})

    added = skipped = rus = 0
    for p in sorted(glob.glob(str(OUT / "out_*.json"))):
        try:
            items = json.loads(open(p, encoding="utf-8-sig").read())
        except Exception as e:
            print("ПОМИЛКА JSON:", p, e)
            continue
        # Приймаємо ОБИДВІ форми виходу: список [{id, ua}] і словник {id: ua}.
        # Хвилі пишуть по-різному залежно від промпта, і на словнику цикл
        # `for it in items` віддавав КЛЮЧІ-рядки, а `it.get(...)` падав —
        # тобто злиття ламалося мовчки на першому ж файлі.
        if isinstance(items, dict):
            items = [{"id": k, "ua": v} for k, v in items.items()]
        for it in items:
            if not isinstance(it, dict):
                skipped += 1
                continue
            cid = str(it.get("id", "")).strip()
            ua = (it.get("ua") or "").strip()
            if not cid or not ua or cid not in src:
                skipped += 1
                continue
            if RUS.search(ua):
                rus += 1
                print("  РОС. ЛІТЕРА:", cid, repr(ua))
                continue
            npc[cid] = ua
            added += 1

    tr["npcNames"] = npc
    TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Імен злито: {added} | пропущено: {skipped} | рос.літер: {rus} | у базі: {len(npc)}")


if __name__ == "__main__":
    main()
