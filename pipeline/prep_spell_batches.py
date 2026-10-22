"""Підготовка батчів для перекладу назв спелів (талантів) агентами.

1. Якщо англійська назва вже перекладена під іншим spellID — переносимо
   готовий переклад (консистентність + нуль зайвої роботи).
2. Решту унікальних назв ділимо на батчі, згруповані за класом
   (агент бачить клас — краще розуміє контекст назви).

Результат:
    data/talent_batches/batch_NN.json   {en: {"de","fr","classes":[...]}}
    оновлений data/translations.json (перенесені дублі)

Використання:
    python prep_spell_batches.py
"""

import json
import io

from common import DATA_DIR

BATCH_DIR = DATA_DIR / "talent_batches"
BATCH_SIZE = 110


def main():
    src = json.load(io.open(DATA_DIR / "source" / "spells.json", encoding="utf-8-sig"))
    trans_path = DATA_DIR / "translations.json"
    trans = json.load(io.open(trans_path, encoding="utf-8-sig"))
    spells_tr = trans.setdefault("spells", {})

    en_by_id = {sid: e["name"]["en"] for sid, e in src.items()
                if e.get("name", {}).get("en")}

    # Готові переклади за англійською назвою.
    name_to_ua = {}
    for sid, ua in spells_tr.items():
        en = en_by_id.get(sid)
        if en:
            name_to_ua.setdefault(en, ua)

    # Перенесення на нові spellID з тією самою назвою.
    reused = 0
    for sid, en in en_by_id.items():
        if sid not in spells_tr and en in name_to_ua:
            spells_tr[sid] = name_to_ua[en]
            reused += 1

    # Унікальні неперекладені назви — лише ТАЛАНТИ (talent=true):
    # повний SkillLineAbility містить тисячі службових/застарілих спелів,
    # яких гравець ніколи не бачить.
    pending = {}
    for sid, e in src.items():
        if sid in spells_tr or not e.get("talent"):
            continue
        en = en_by_id.get(sid)
        if not en:
            continue
        p = pending.setdefault(en, {"de": None, "fr": None, "classes": set()})
        p["de"] = p["de"] or e["name"].get("de")
        p["fr"] = p["fr"] or e["name"].get("fr")
        if e.get("skillLine"):
            p["classes"].add(e["skillLine"])

    # Сортування за класом, щоб батч тримався одного класу.
    items = sorted(pending.items(),
                   key=lambda kv: (min(kv[1]["classes"]) if kv[1]["classes"] else "~",
                                   kv[0]))

    BATCH_DIR.mkdir(parents=True, exist_ok=True)
    for old in BATCH_DIR.glob("*.json"):
        old.unlink()

    batches = 0
    for i in range(0, len(items), BATCH_SIZE):
        chunk = {en: {"de": p["de"], "fr": p["fr"], "classes": sorted(p["classes"])}
                 for en, p in items[i:i + BATCH_SIZE]}
        batches += 1
        (BATCH_DIR / f"batch_{batches:02d}.json").write_text(
            json.dumps(chunk, ensure_ascii=False, indent=1), encoding="utf-8")

    trans_path.write_text(json.dumps(trans, ensure_ascii=False, indent=1),
                          encoding="utf-8")
    print(f"Перенесено готових (дублікати назв): {reused}")
    print(f"Унікальних назв на переклад: {len(items)} у {batches} батчах")
    print(f"-> {BATCH_DIR}")


if __name__ == "__main__":
    main()
