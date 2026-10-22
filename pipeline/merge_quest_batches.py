"""Злиття перекладених батчів квестів + перегенерація Quests.lua.

Вхід:  data/batches/quests/out_NNN.json
       [{"id": "...", "title": "...", "description": "...", "objectives": "..."}]
Перевірки: плейсхолдери {name}/{class}/{race}... мусять збігатися з en;
переклад непорожній; квест існує в джерелі. Відхилене — у звіт, не в базу.

Ідемпотентний: запускати після КОЖНОЇ хвилі (або падіння) — підбирає все,
що встигло записатись.

Використання:
    python merge_quest_batches.py
"""

import json
import re
import subprocess
import sys

from common import DATA_DIR

BATCH_DIR = DATA_DIR / "batches" / "quests"
TOKEN_RE = re.compile(r"\{[A-Za-z:]+\}")
FIELDS = ("title", "description", "objectives", "progress", "completion")


def tokens(s: str) -> set:
    # {class:v}/{race:v} — кличний відмінок, легальний варіант {class}/{race}
    return set(t.lower().replace(":v}", "}") for t in TOKEN_RE.findall(s or ""))


def main():
    src = json.loads((DATA_DIR / "source" / "quests.json")
                     .read_text(encoding="utf-8"))
    tr_path = DATA_DIR / "translations.json"
    tr = json.loads(tr_path.read_text(encoding="utf-8"))
    quests = tr.setdefault("quests", {})

    merged, rejected = 0, []
    for path in sorted(BATCH_DIR.glob("out_*.json")):
        try:
            # utf-8-sig: деякі агенти пишуть файл із BOM-маркером.
            items = json.loads(path.read_text(encoding="utf-8-sig"))
        except json.JSONDecodeError as e:
            rejected.append(f"{path.name}: битий JSON ({e})")
            continue
        for item in items:
            qid = str(item.get("id", ""))
            if qid not in src:
                rejected.append(f"{path.name}: невідомий id {qid}")
                continue
            entry = {}
            bad = None
            for field in FIELDS:
                ua = (item.get(field) or "").strip()
                if not ua:
                    continue
                en = (src[qid].get(field) or {}).get("en", "")
                if en and tokens(en) != tokens(ua):
                    bad = f"{qid}/{field}: плейсхолдери не збігаються"
                    break
                entry[field] = ua.replace("\r\n", "\n")
            if bad:
                rejected.append(f"{path.name}: {bad}")
            elif entry:
                existing = quests.get(qid, {})
                existing.update(entry)
                quests[qid] = existing
                merged += 1

    tr_path.write_text(json.dumps(tr, ensure_ascii=False, indent=1),
                       encoding="utf-8")
    print(f"Злито квестів: {merged} | відхилено: {len(rejected)} "
          f"| у базі тепер: {len(quests)}")
    for r in rejected[:10]:
        print("  !", r)

    # Перегенерувати Lua-бази з оновленого translations.json
    result = subprocess.run([sys.executable, "-X", "utf8", "generate_db.py"],
                            cwd=str(DATA_DIR.parent / "pipeline"),
                            capture_output=True, text=True, encoding="utf-8")
    print(result.stdout.strip())
    if result.returncode != 0:
        print("ПОМИЛКА generate_db:", result.stderr[:500])


if __name__ == "__main__":
    main()
