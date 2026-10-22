"""Збір квестових текстів, зібраних аддоном у грі (CaptureDB.quests).

Серверні тексти (зведена ціль objectives, інколи опис/назва квестів поза
експортом Blizzard) аддон збирає під час гри у SavedVariables. Цей скрипт
витягує те, чого ще НЕМАЄ в перекладі, і робить батч на переклад.

Вхід:  WTF\\...\\SavedVariables\\WoWUkraine.lua -> CaptureDB.quests
Вихід: data/batches/captured/cap_NN.json  [{id, field, en}]

Використання: python parse_captured_quests.py
"""

import json

from luaparser import ast, astnodes

from common import DATA_DIR

SV = (r"F:\Battlenet\World of Warcraft\_retail_\WTF\Account"
      r"\129089678#1\SavedVariables\WoWUkraine.lua")
OUT_DIR = DATA_DIR / "batches" / "captured"
FIELDS = ("title", "description", "objectives", "progress", "completion")
BATCH = 20


def s(n):
    v = getattr(n, "s", None)
    if isinstance(v, bytes):
        return v.decode("utf-8", "replace")
    return v


def main():
    src = open(SV, encoding="utf-8", errors="replace").read()
    tree = ast.parse(src)
    captured = {}
    for node in ast.walk(tree):
        if not isinstance(node, astnodes.Assign):
            continue
        for t, v in zip(node.targets, node.values):
            if getattr(t, "id", None) != "WoWUkraineCaptureDB":
                continue
            if not isinstance(v, astnodes.Table):
                continue
            for f in v.fields:
                if s(f.key) != "quests" or not isinstance(f.value, astnodes.Table):
                    continue
                for q in f.value.fields:
                    qid = getattr(q.key, "n", None)
                    if qid is None or not isinstance(q.value, astnodes.Table):
                        continue
                    d = {s(ff.key): s(ff.value) for ff in q.value.fields
                         if isinstance(ff.value, astnodes.String)}
                    captured[str(int(qid))] = d

    translations = json.loads(
        (DATA_DIR / "translations.json").read_text(encoding="utf-8"))
    quests = translations.get("quests", {})

    todo = []
    for qid, fields in captured.items():
        existing = quests.get(qid, {})
        for field in FIELDS:
            en = (fields.get(field) or "").strip()
            if en and not existing.get(field):
                todo.append({"id": qid, "field": field, "en": en})

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for old in OUT_DIR.glob("cap_*.json"):
        old.unlink()
    n = 0
    for i in range(0, len(todo), BATCH):
        n += 1
        (OUT_DIR / f"cap_{n:02d}.json").write_text(
            json.dumps(todo[i:i + BATCH], ensure_ascii=False, indent=1),
            encoding="utf-8")

    print(f"Зібрано квестів: {len(captured)} | полів до перекладу: {len(todo)}"
          f" | батчів: {n}")
    from collections import Counter
    c = Counter(x["field"] for x in todo)
    for k, v in c.most_common():
        print(f"  {k}: {v}")


if __name__ == "__main__":
    main()
