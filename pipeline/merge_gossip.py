"""Злиття перекладених діалогів NPC + генерація Database/Gossip.lua.

Вхід: data/batches/gossip/out_NN.json [{en, ua}]
Дія:  translations.json["gossip"][en] = ua, далі generate Gossip.lua.
Ключ — англійський текст (з {name} замість імені гравця).
Ідемпотентний.
"""

import json

from common import DATA_DIR

BD = DATA_DIR / "batches" / "gossip"
DB_LUA = (DATA_DIR.parent / "addon" / "UALL"
          / "Database" / "Gossip.lua")

HEADER = """-- WoWUkraine: переклади реплік NPC (вікно розмови) і варіантів відповідей.
-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО — не редагуйте вручну.
-- Ключ — повний англійський текст ({name} = ім'я гравця).

local _, ns = ...

ns.gossip = {
"""


def lua_q(s):
    return '"' + (s.replace("\\", "\\\\").replace('"', '\\"')
                  .replace("\r\n", "\n").replace("\n", "\\n")
                  .replace("\r", "")) + '"'


def main():
    p = DATA_DIR / "translations.json"
    t = json.loads(p.read_text(encoding="utf-8"))
    g = t.setdefault("gossip", {})
    merged = 0
    for path in sorted(BD.glob("out_*.json")):
        try:
            items = json.loads(path.read_text(encoding="utf-8-sig"))
        except json.JSONDecodeError:
            continue
        for it in items:
            en = (it.get("en") or "").strip()
            ua = (it.get("ua") or "").strip()
            if en and ua:
                g[en] = ua
                merged += 1
    p.write_text(json.dumps(t, ensure_ascii=False, indent=1), encoding="utf-8")

    lines = [HEADER]
    for en in sorted(g):
        lines.append(f"    [{lua_q(en)}] = {lua_q(g[en])},\n")
    lines.append("}\n")
    DB_LUA.write_text("".join(lines), encoding="utf-8")
    print(f"Діалогів злито: {merged} | у базі: {len(g)} -> {DB_LUA.name}")


if __name__ == "__main__":
    main()
