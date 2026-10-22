"""Злиття перекладених субтитрів + генерація Database/Broadcast.lua.

Аддон у грі бачить ПОКАЗАНИЙ англійський текст репліки (бабл/talking head/
монстр у чаті), тому база — мапа EN-текст -> UA. Для статі гравця гра вже
обирає Text або Text1 і показує його; ми мапимо обидва EN-варіанти на свої
UA, тож аддон просто шукає за показаним текстом.

Вхід:  data/batches/broadcast/bc_NNN.json (en, en_female_player)
       data/batches/broadcast/out_NNN.json (ua, ua_female_player)
Вихід: addon/WoWUkraine/Database/Broadcast.lua  (ns.broadcast = { [en]=ua })
"""

import json

from common import DATA_DIR

BD = DATA_DIR / "batches" / "broadcast"
DB_LUA = (DATA_DIR.parent / "addon" / "UALL"
          / "Database" / "Broadcast.lua")

HEADER = """-- WoWUkraine: переклади реплік/субтитрів (BroadcastText).
-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО — не редагуйте вручну.
-- Ключ — англійський текст репліки (як показує гра), значення — українська.

local _, ns = ...

ns.broadcast = {
"""


def lua_q(s):
    return '"' + (s.replace("\\", "\\\\").replace('"', '\\"')
                  .replace("\r\n", "\n").replace("\n", "\\n")
                  .replace("\r", "")) + '"'


def main():
    # id -> (en, en_female)
    en_of = {}
    for p in sorted(BD.glob("bc_*.json")):
        for it in json.loads(p.read_text(encoding="utf-8")):
            en_of[it["id"]] = (it.get("en", ""), it.get("en_female_player"))

    mapping = {}
    bad = 0
    for p in sorted(BD.glob("out_*.json")):
        try:
            items = json.loads(p.read_text(encoding="utf-8-sig"))
        except json.JSONDecodeError:
            bad += 1
            continue
        for it in items:
            sid = str(it.get("id", ""))
            ua = (it.get("ua") or "").strip()
            en, en_f = en_of.get(sid, ("", None))
            if en and ua:
                mapping[en] = ua
            ua_f = (it.get("ua_female_player") or "").strip()
            if en_f and ua_f:
                mapping[en_f] = ua_f

    lines = [HEADER]
    for en in sorted(mapping):
        lines.append(f"    [{lua_q(en)}] = {lua_q(mapping[en])},\n")
    lines.append("}\n")
    DB_LUA.write_text("".join(lines), encoding="utf-8")
    print(f"Субтитрів злито: {len(mapping)} | биті out: {bad} -> {DB_LUA.name}")


if __name__ == "__main__":
    main()
