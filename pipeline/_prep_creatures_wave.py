# -*- coding: utf-8 -*-
"""Черга на переклад ІМЕН ІСТОТ у заданому діапазоні ID (доба доповнення).

Узагальнення `_prep_midnight_wave.py`: та сама механіка, але доба задається
з командного рядка, бо дірки лишилися не лише в Опівночі. Межі — за
діапазонами ID (у Blizzard вони зростають монотонно); це евристика для
вибору обсягу роботи, у переклад вона не потрапляє.

Відсів:
  • службові рядки розробників (у гру не потрапляють);
  • те, що вже перекладено (ключ npcNames = ID [[sv-bucket-vs-section-key]]);
  • імена гравців [[guild-names-never-translate]].

-> data/batches/<тека>/npc_NN.json
Далі: _xref_wave.py <тека> npc --apply, тоді переклад.

Запуск:
    python _prep_creatures_wave.py bfa 120000 155000 [розмір]
    python _prep_creatures_wave.py df  180000 205000
"""
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import nick_regex

if len(sys.argv) < 4:
    print(__doc__)
    sys.exit(2)
SUB = sys.argv[1]
LO, HI = int(sys.argv[2]), int(sys.argv[3])
SIZE = int(sys.argv[4]) if len(sys.argv) > 4 else 40

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
cr = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
done = tr.get("npcNames", {})
NICK = nick_regex(min_len=4)

DEV = re.compile(
    r"(?:\s-\s*Mix\s*\d+$)"
    r"|[\[(]?\b(?:DNT|PH|TEST|UNUSED|DEPRECATED)\b[\])]?"
    r"|\b(?:DO ?NOT ?USE|Placeholder)\b"
    r"|^\d+(?:\.\d+)*[\s_]"
    r"|^\d+xp_"
    r"|_[A-Za-z]"
    r"|\b(?:Props?|Collision|Blocker|Invisible|Trigger|Spawner|DEBUG|Bunny)\b"
    r"|\bZ\d+\b"
    r"|^\W+$|^\d+$", re.I)


def ua_of(v):
    if isinstance(v, str):
        return v
    if isinstance(v, dict) and isinstance(v.get("name"), str):
        return v["name"]
    return ""


raw = dev = nick = 0
out = []
for k, v in cr.items():
    if not k.isdigit() or not (LO <= int(k) < HI):
        continue
    nm = v.get("name") if isinstance(v, dict) else None
    en = nm.get("en") if isinstance(nm, dict) else None
    if not en or ua_of(done.get(k)):
        continue
    raw += 1
    if DEV.search(en):
        dev += 1
        continue
    if NICK.search(en):
        nick += 1
        continue
    out.append({"id": k, "en": en})

out.sort(key=lambda x: int(x["id"]))
print(f"Істоти [{LO}..{HI}): у добі без перекладу {raw} | службових {dev} | "
      f"ніків {nick} | НА ПЕРЕКЛАД {len(out)}")

d = DATA_DIR / "batches" / SUB
d.mkdir(parents=True, exist_ok=True)
for f in d.glob("npc_*.json"):
    f.unlink()
n = (len(out) + SIZE - 1) // SIZE
for k in range(n):
    (d / f"npc_{k:02d}.json").write_text(
        json.dumps(out[k * SIZE:(k + 1) * SIZE], ensure_ascii=False, indent=1),
        encoding="utf-8")
print(f"-> батчів {n} по {SIZE} у {d}")
