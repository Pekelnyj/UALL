"""Злиття перекладених батчів досягнень + генерація Achievements.lua.

Вхід:  data/batches/achievements/out_NN.json
       [{"id":"...","title":"...","desc":"..."}]
Дія:   валідація (id існує, title непорожній) -> translations.json["achievements"]
       -> addon/WoWUkraine/Database/Achievements.lua  {[id]={title=,desc=}}

Ідемпотентний: запускати після кожної хвилі.
Використання: python merge_achievement_batches.py
"""

import json
from common import DATA_DIR

BATCH_DIR = DATA_DIR / "batches" / "achievements"
DB_LUA = (DATA_DIR.parent / "addon" / "UALL"
          / "Database" / "Achievements.lua")

HEADER = """-- WoWUkraine: переклади досягнень (назва + опис).
-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО (pipeline/merge_achievement_batches.py).
-- Ключ — achievementID (число).

local _, ns = ...

ns.achievements = {
"""


def q(s):
    return '"' + (str(s).replace("\\", "\\\\").replace('"', '\\"')
                  .replace("\r\n", "\\n").replace("\n", "\\n")
                  .replace("\r", "")) + '"'


def main():
    src = json.loads((DATA_DIR / "source" / "achievements.json")
                     .read_text(encoding="utf-8"))
    tr_path = DATA_DIR / "translations.json"
    tr = json.loads(tr_path.read_text(encoding="utf-8"))
    ach = tr.setdefault("achievements", {})

    merged, rejected = 0, 0
    for path in sorted(BATCH_DIR.glob("out_*.json")):
        try:
            items = json.loads(path.read_text(encoding="utf-8-sig"))
        except json.JSONDecodeError:
            rejected += 1
            continue
        for it in items:
            aid = str(it.get("id", ""))
            title = (it.get("title") or "").strip()
            if aid not in src or not title:
                rejected += 1
                continue
            entry = {"title": title}
            desc = (it.get("desc") or "").strip()
            if desc:
                entry["desc"] = desc
            ach[aid] = entry
            merged += 1

    tr_path.write_text(json.dumps(tr, ensure_ascii=False, indent=1),
                       encoding="utf-8")

    lines = [HEADER]
    for aid in sorted(ach, key=lambda x: int(x)):
        e = ach[aid]
        if "desc" in e:
            lines.append(f"    [{aid}] = {{ title = {q(e['title'])}, "
                        f"desc = {q(e['desc'])} }},\n")
        else:
            lines.append(f"    [{aid}] = {{ title = {q(e['title'])} }},\n")
    lines.append("}\n")
    DB_LUA.write_text("".join(lines), encoding="utf-8")

    print(f"Злито: {merged} | відхилено: {rejected} | у базі: {len(ach)}")
    print(f"-> {DB_LUA}")


if __name__ == "__main__":
    main()
