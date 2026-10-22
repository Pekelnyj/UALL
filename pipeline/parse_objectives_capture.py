"""Парсинг зібраних у грі цілей квестів із SavedVariables.

Вхід:  WTF\\...\\SavedVariables\\WoWUkraine.lua -> CaptureDB.objectives
Вихід: data/source/quest_objectives_capture.json {questID: [тексти]}
       + батчі data/batches/objectives/batch_NN.json (нумерація продовжує
         наявну; рядки, що вже перекладені, пропускаються)

Лічильники нормалізуються: "2/10 Текст" і "Текст: 2/10" -> "Текст"
(в базі аддона ключ — текст без лічильника).

Використання:
    python parse_objectives_capture.py
"""

import json
import re

from luaparser import ast
from luaparser import astnodes

from common import DATA_DIR

SV = (r"F:\Battlenet\World of Warcraft\_retail_\WTF\Account"
      r"\129089678#1\SavedVariables\WoWUkraine.lua")
OUT_SRC = DATA_DIR / "source" / "quest_objectives_capture.json"
BATCH_DIR = DATA_DIR / "batches" / "objectives"
BATCH_SIZE = 60

PREFIX_RE = re.compile(r"^\s*\d+\s*/\s*\d+\s+")          # "2/10 Текст"
SUFFIX_RE = re.compile(r"\s*:\s*[\d/%.\s]+$")             # "Текст: 2/10|53%"
PAREN_RE = re.compile(r"\s*\(\s*[\d/%.\s]+%?\s*\)$")      # "Текст (47%)|(2/10)"


def lua_str(node):
    if isinstance(node, astnodes.String):
        s = node.s
        if isinstance(s, bytes):  # luaparser віддає рядки як bytes
            s = s.decode("utf-8", errors="replace")
        return s
    return None


def table_fields(node):
    return node.fields if isinstance(node, astnodes.Table) else []


def main():
    # У diag-рядках WoW інколи ріже utf-8 посередині символу (обрізання
    # до 60 байтів) — нам потрібні лише англійські цілі, тож втрати ОК.
    src = open(SV, encoding="utf-8", errors="replace").read()
    tree = ast.parse(src)

    objectives = {}
    obj_lines = []  # плоский ключ objLines: рядки трекера цілей («2/3 ...»)
    for node in ast.walk(tree):
        if not isinstance(node, astnodes.Assign):
            continue
        for target, value in zip(node.targets, node.values):
            if getattr(target, "id", None) != "WoWUkraineCaptureDB":
                continue
            for field in table_fields(value):
                key = lua_str(field.key)
                if key == "objectives":
                    for qfield in table_fields(field.value):
                        qid = getattr(qfield.key, "n", None)
                        if qid is None:
                            continue
                        texts = [lua_str(t.value) for t in table_fields(qfield.value)]
                        texts = [t for t in texts if t]
                        if texts:
                            objectives[str(int(qid))] = texts
                elif key == "objLines":
                    # objLines = { ["English line"] = true/лічильник, ... }
                    for lf in table_fields(field.value):
                        line = lua_str(lf.key)
                        if line:
                            obj_lines.append(line)

    OUT_SRC.parent.mkdir(parents=True, exist_ok=True)
    OUT_SRC.write_text(json.dumps(objectives, ensure_ascii=False, indent=1),
                       encoding="utf-8")
    total_lines = sum(len(v) for v in objectives.values())
    print(f"Квестів із цілями: {len(objectives)} | рядків: {total_lines}")

    # Унікальні нормалізовані рядки, яких ще нема в перекладах.
    translations = json.loads(
        (DATA_DIR / "translations.json").read_text(encoding="utf-8"))
    done = set(translations.get("questObjectives", {}))
    quests = translations.get("quests", {})

    unique = {}
    for qid, texts in objectives.items():
        title = (quests.get(qid) or {}).get("title") or ""
        for t in texts:
            base = PAREN_RE.sub("", SUFFIX_RE.sub("", PREFIX_RE.sub("", t))).strip()
            if not base or base in done:
                continue
            ctx = unique.setdefault(base, [])
            if title and title not in ctx and len(ctx) < 2:
                ctx.append(title)

    # Рядки трекера (objLines) — без прив'язки до questID, тож без контексту.
    CYR = re.compile(r"[А-Яа-яІЇЄҐіїєґ]")
    for t in obj_lines:
        if CYR.search(t):
            continue  # вже перекладений рядок (засмічення збору) — пропустити
        base = PAREN_RE.sub("", SUFFIX_RE.sub("", PREFIX_RE.sub("", t))).strip()
        if not base or base in done:
            continue
        unique.setdefault(base, [])

    items = [{"en": en, "context": "; ".join(ctx)}
             for en, ctx in sorted(unique.items())]

    existing = sorted(BATCH_DIR.glob("batch_*.json"))
    next_n = (int(existing[-1].stem.split("_")[1]) if existing else 0) + 1
    n_batches = 0
    for i in range(0, len(items), BATCH_SIZE):
        path = BATCH_DIR / f"batch_{next_n + n_batches:02d}.json"
        path.write_text(json.dumps(items[i:i + BATCH_SIZE],
                                   ensure_ascii=False, indent=1),
                        encoding="utf-8")
        n_batches += 1

    print(f"Нових унікальних рядків: {len(items)} (вже перекладених "
          f"пропущено: збіг із {len(done)} наявними)")
    print(f"Нові батчі: {n_batches} (batch_{next_n:02d}..."
          f"batch_{next_n + n_batches - 1:02d}) -> {BATCH_DIR}")


if __name__ == "__main__":
    main()
