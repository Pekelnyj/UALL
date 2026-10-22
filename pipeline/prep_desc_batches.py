"""Батчі для перекладу ОПИСІВ спелів агентами.

Беремо лише:
  - спели, назви яких уже перекладені (consistency: опис посилається на назву);
  - описи з descComplexity == "simple" (складні з умовами $?.. — наступна хвиля).

Однакові англійські шаблони зливаються (один переклад на всі spellID).
У батч кладемо назву спела en+ua і клас — контекст для перекладача.

Результат: data/desc_batches/batch_NN.json
    {"<en шаблон>": {"de": ..., "fr": ..., "spells": [{"en","ua","class"}]}}

Використання:
    python prep_desc_batches.py
"""

import json
import io

from common import DATA_DIR

BATCH_DIR = DATA_DIR / "desc_batches"
BATCH_SIZE = 32


def main():
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--complexity", default="simple",
                    help="simple (типово) або complex ($? умови)")
    args = ap.parse_args()

    src = json.load(io.open(DATA_DIR / "source" / "spells.json", encoding="utf-8-sig"))
    trans = json.load(io.open(DATA_DIR / "translations.json", encoding="utf-8-sig"))
    spells_tr = trans.get("spells", {})
    done = trans.get("descTemplates", {})  # вже перекладені шаблони

    pending = {}
    for sid, e in src.items():
        if sid not in spells_tr:
            continue
        desc = e.get("description") or {}
        en = desc.get("en")
        if not en or e.get("descComplexity") != args.complexity or en in done:
            continue
        p = pending.setdefault(en, {"de": None, "fr": None, "spells": []})
        p["de"] = p["de"] or desc.get("de")
        p["fr"] = p["fr"] or desc.get("fr")
        name_en = e.get("name", {}).get("en")
        if name_en and len(p["spells"]) < 3:
            p["spells"].append({"en": name_en, "ua": spells_tr[sid],
                                "class": e.get("skillLine", "")})

    # Групуємо за класом першого спела — батч тримається однієї тематики.
    items = sorted(pending.items(),
                   key=lambda kv: (kv[1]["spells"][0]["class"] if kv[1]["spells"] else "~",
                                   kv[0]))

    BATCH_DIR.mkdir(parents=True, exist_ok=True)
    for old in BATCH_DIR.glob("*.json"):
        old.unlink()

    batches = 0
    for i in range(0, len(items), BATCH_SIZE):
        chunk = dict(items[i:i + BATCH_SIZE])
        batches += 1
        (BATCH_DIR / f"batch_{batches:02d}.json").write_text(
            json.dumps(chunk, ensure_ascii=False, indent=1), encoding="utf-8")

    words = sum(len(en.split()) for en in pending)
    print(f"Унікальних шаблонів: {len(items)} (~{words} слів) у {batches} батчах")
    print(f"-> {BATCH_DIR}")


if __name__ == "__main__":
    main()
