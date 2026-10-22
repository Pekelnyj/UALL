"""Злиття перекладених батчів цілей квестів + генерація Lua-бази.

Вхід:  data/batches/objectives/out_NN.json  [{"en": ..., "ua": ...}]
Дія:   1) валідація (en мусить існувати у вхідних батчах, ua непорожній)
       2) запис у data/translations.json -> "questObjectives" (EN -> UA)
       3) генерація addon/WoWUkraine/Database/QuestObjectives.lua

Скрипт ідемпотентний: можна запускати після кожної хвилі — підхопить
усі наявні out-файли (часткове злиття при падінні хвилі — нормальне).

Використання:
    python merge_objective_batches.py
"""

import json

from common import DATA_DIR

BATCH_DIR = DATA_DIR / "batches" / "objectives"
DB_LUA = (DATA_DIR.parent / "addon" / "UALL"
          / "Database" / "QuestObjectives.lua")

HEADER = """-- WoWUkraine: переклади рядків цілей квестів (трекер, лічильники «2/3»).
-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО скриптом pipeline/merge_objective_batches.py — не редагуйте вручну.
-- Ключ — англійський рядок цілі БЕЗ лічильника ("Captured Frostwolves Freed").

local _, ns = ...

ns.questObjectives = {
"""


def lua_quote(s: str) -> str:
    return '"' + (s.replace("\\", "\\\\").replace('"', '\\"')
                  .replace("\n", "\\n").replace("\r", "")) + '"'


def main():
    valid_en = set()
    for p in sorted(BATCH_DIR.glob("batch_*.json")):
        for item in json.loads(p.read_text(encoding="utf-8")):
            valid_en.add(item["en"])

    merged, bad = {}, []
    out_files = sorted(BATCH_DIR.glob("out_*.json"))
    for p in out_files:
        for item in json.loads(p.read_text(encoding="utf-8")):
            en, ua = item.get("en", ""), (item.get("ua") or "").strip()
            if en not in valid_en:
                bad.append(f"{p.name}: невідомий en: {en[:60]!r}")
            elif not ua:
                bad.append(f"{p.name}: порожній переклад: {en[:60]!r}")
            else:
                merged[en] = ua

    translations_path = DATA_DIR / "translations.json"
    translations = json.loads(translations_path.read_text(encoding="utf-8"))
    translations["questObjectives"] = merged
    translations_path.write_text(
        json.dumps(translations, ensure_ascii=False, indent=1),
        encoding="utf-8")

    lines = [HEADER]
    for en in sorted(merged):
        lines.append(f"    [{lua_quote(en)}] = {lua_quote(merged[en])},\n")
    lines.append("}\n")
    DB_LUA.write_text("".join(lines), encoding="utf-8")

    print(f"Out-файлів: {len(out_files)} | злито рядків: {len(merged)}"
          f"/{len(valid_en)} | відхилено: {len(bad)}")
    for b in bad[:10]:
        print("  !", b)
    print(f"-> translations.json [questObjectives] + {DB_LUA}")


if __name__ == "__main__":
    main()
