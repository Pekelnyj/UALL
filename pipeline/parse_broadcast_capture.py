"""Парсинг ЗАХОПЛЕНИХ у грі субтитрів (CaptureDB.broadcast) у bc-батчі.

Вхід:  WTF\\...\\SavedVariables\\WoWUkraine.lua -> CaptureDB.broadcast (EN-рядки)
Вихід: data/batches/broadcast/bc_cap_NN.json [{id:"cap_N", en, scene}]
Дедуп проти наявної Database/Broadcast.lua (вже перекладені пропускаємо).
Cyrillic-рядки (вже наш переклад) і порожні — пропускаємо.

Той самий merge (merge_broadcast.py) підхопить bc_cap_* і out_cap_*.
Використання: python parse_broadcast_capture.py
"""

import re
import json
from luaparser import ast, astnodes
from common import DATA_DIR

SV = (r"F:\Battlenet\World of Warcraft\_retail_\WTF\Account"
      r"\129089678#1\SavedVariables\WoWUkraine.lua")
BD = DATA_DIR / "batches" / "broadcast"
DB_LUA = (DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua")
BATCH = 40
CYR = re.compile(r"[А-Яа-яіїєґ]")


def lua_str(n):
    if isinstance(n, astnodes.String):
        v = n.s
        return v.decode("utf-8", "replace") if isinstance(v, bytes) else v
    return None


def main():
    import glob
    files = glob.glob(str(DATA_DIR.parent / "testerlua" / "*.lua")) + [SV]
    captured = []
    for path in files:
        try:
            src = open(path, encoding="utf-8", errors="replace").read()
            tree = ast.parse(src)
        except Exception:
            continue
        for node in ast.walk(tree):
            if not isinstance(node, astnodes.Assign):
                continue
            for tgt, val in zip(node.targets, node.values):
                if getattr(tgt, "id", None) != "WoWUkraineCaptureDB":
                    continue
                for f in (val.fields if isinstance(val, astnodes.Table) else []):
                    if lua_str(f.key) == "broadcast" and isinstance(f.value, astnodes.Table):
                        for x in f.value.fields:
                            k = lua_str(x.key)
                            if k:
                                captured.append((k, lua_str(x.value) or ""))  # (текст, мовець)

    db = DB_LUA.read_text(encoding="utf-8")
    new, seen = [], set()
    for en, speaker in captured:
        e = en.strip()
        if not e or e in seen or CYR.search(e):
            continue
        if e[:45] in db:           # уже в базі (грубий, але надійний дедуп)
            continue
        seen.add(e)
        new.append((e, speaker))

    BD.mkdir(parents=True, exist_ok=True)
    for old in BD.glob("bc_cap_*.json"):
        old.unlink()
    n = 0
    for i in range(0, len(new), BATCH):
        chunk = new[i:i + BATCH]
        items = [{"id": "cap_%d" % (i + j), "en": t,
                  "speaker": sp, "scene": t}  # speaker -> рід у перекладі
                 for j, (t, sp) in enumerate(chunk)]
        (BD / ("bc_cap_%02d.json" % n)).write_text(
            json.dumps(items, ensure_ascii=False, indent=1), encoding="utf-8")
        n += 1

    print(f"Захоплено субтитрів: {len(captured)} | нових унікальних: {len(new)} "
          f"| батчів bc_cap: {n}")


if __name__ == "__main__":
    main()
