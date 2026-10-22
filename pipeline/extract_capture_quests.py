# -*- coding: utf-8 -*-
"""Об'єднати серверні поля квестів з УСІХ файлів збору (тестери + свій),
дедуплікувати, прибрати ім'я гравця -> {NAME}, і розкласти в батчі НОВИХ
полів (яких ще нема в translations.json quests[qid]).

Вихід: data/quest_capture_batches/batch_NN.json
       {qid: {"_title": ua-назва для контексту, "objectives":en, "progress":en, "completion":en}}
Перекладається -> out_NN.json {qid: {field: ua}} -> merge_capture_quests.py
"""
import json
import glob
from pathlib import Path

from common import DATA_DIR, sv_variable
from parse_capture import LuaParser


def parse_saved_variables(p: Path) -> dict:
    """Толерантне читання (биті байти в діаг-лозі -> replace)."""
    text = p.read_text(encoding="utf-8", errors="replace")
    marker = sv_variable()
    pos = text.find(marker)
    if pos == -1:
        raise ValueError(f"немає {marker}")
    pos = text.find("{", pos)
    parser = LuaParser(text)
    parser.i = pos
    return parser.parse_table()

FIELDS = ("objectives", "progress", "completion")
OUT_DIR = DATA_DIR / "quest_capture_batches"
BATCH = 20

CAPTURE_FILES = glob.glob(str(DATA_DIR.parent / "testerlua" / "*.lua")) + [
    r"F:\Battlenet\World of Warcraft\_retail_\WTF\Account\129089678#1\SavedVariables\WoWUkraine.lua",
]


def main():
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    qtr = tr.get("quests", {})

    combined = {}  # qid(str) -> {field: en}
    seen_files = 0
    for f in CAPTURE_FILES:
        p = Path(f)
        if not p.exists():
            continue
        try:
            db = parse_saved_variables(p)
        except Exception as e:
            print(f"  ПРОПУСК {p.name}: {e}")
            continue
        seen_files += 1
        pname = (db.get("meta") or {}).get("playerName")
        for qid, entry in (db.get("quests") or {}).items():
            if not isinstance(entry, dict):
                continue
            qid = str(qid)
            for fld in FIELDS:
                en = entry.get(fld)
                if not isinstance(en, str) or not en.strip():
                    continue
                if pname:
                    en = en.replace(pname, "{NAME}")
                # вже перекладено в базі?
                if (qtr.get(qid) or {}).get(fld):
                    continue
                combined.setdefault(qid, {}).setdefault(fld, en)

    # батчі
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for old in OUT_DIR.glob("*.json"):
        old.unlink()
    items = sorted(combined.items(), key=lambda kv: int(kv[0]))
    nfields = sum(len(v) for _, v in items)
    nwords = sum(len(t.split()) for _, v in items for t in v.values())
    n = 0
    for i in range(0, len(items), BATCH):
        n += 1
        chunk = {}
        for qid, fields in items[i:i + BATCH]:
            rec = {"_title": (qtr.get(qid) or {}).get("title", "")}
            rec.update(fields)
            chunk[qid] = rec
        (OUT_DIR / f"batch_{n:02d}.json").write_text(
            json.dumps(chunk, ensure_ascii=False, indent=1), encoding="utf-8")

    print(f"Файлів збору: {seen_files}")
    print(f"Унікальних квестів із новими полями: {len(items)}")
    print(f"Нових полів (objectives/progress/completion): {nfields} (~{nwords} слів)")
    print(f"Батчів по {BATCH}: {n} -> {OUT_DIR}")


if __name__ == "__main__":
    main()
