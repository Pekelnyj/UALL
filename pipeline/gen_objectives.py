"""Регенерує Database/QuestObjectives.lua з translations.json[questObjectives]."""
import json
from common import DATA_DIR

DB = (DATA_DIR.parent / "addon" / "UALL" / "Database" / "QuestObjectives.lua")
HEADER = """-- WoWUkraine: переклади рядків цілей квестів (трекер, лічильники «2/3»).
-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО — не редагуйте вручну.
-- Ключ — англійський рядок цілі БЕЗ лічильника.

local _, ns = ...

ns.questObjectives = {
"""


def q(s):
    return '"' + (s.replace("\\", "\\\\").replace('"', '\\"')
                  .replace("\r\n", "\n").replace("\n", "\\n")
                  .replace("\r", "")) + '"'


def main():
    t = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8"))
    qo = t.get("questObjectives", {})
    lines = [HEADER]
    for en in sorted(qo):
        lines.append(f"    [{q(en)}] = {q(qo[en])},\n")
    lines.append("}\n")
    DB.write_text("".join(lines), encoding="utf-8")
    print(f"QuestObjectives.lua: {len(qo)} рядків")


if __name__ == "__main__":
    main()
