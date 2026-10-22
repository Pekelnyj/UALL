# -*- coding: utf-8 -*-
"""Батчі для перекладу РЕАЛЬНИХ фейків: journalSections (абілки) + справжні предмети."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
real = json.loads((B / "data/_fakes_real.json").read_text(encoding="utf-8-sig"))
IN = B / "data/_fk_in"; IN.mkdir(exist_ok=True)
(B / "data/_fk_out").mkdir(exist_ok=True)

# сильніший junk-фільтр для предметів/імен
HARD = re.compile(
    r"\bPH\b|REUSE|\bIOU\b|\bPTR\b|NEEDS|Sequenced|Tome of the|G\dT|TEMP|Holder|Location|"
    r"Target|Clone|Visual|Scene|CLIENT|Unburrow|Balloon - Pet|Zeppelin|Quest Chest|"
    r"\bOLD\b|\bnew\b|copy|Copy|backup|TBD|WIP|do not|DoNot|\bNPC\b|\bUI\b|Trigger|Spawner|"
    r"Invisible|Generic|Bunny|Stalker Bunny|Kill Credit|Bird Bunny", re.I)


def clean(d):
    return {k: v for k, v in d.items() if not HARD.search(v) and not HARD.search(str(k)) and len(v) > 2}


# journalSections — усі 244 реальні
js = list(real.get("journalSections", {}).keys())
# предмети — сильний фільтр
items = clean(real.get("itemNames", {}))
print(f"journalSections (абілки): {len(js)} | справжні предмети після фільтра: {len(items)}")

# батчі journalSections по 50
for bi in range((len(js) + 49) // 50):
    chunk = js[bi*50:(bi+1)*50]
    (IN / f"js_{bi+1}.json").write_text(json.dumps(chunk, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"  -> {(len(js)+49)//50} батчів js")

# предмети одним файлом
(IN / "items.json").write_text(json.dumps(sorted(items), ensure_ascii=False, indent=1), encoding="utf-8")
for v in list(items.values())[:8]:
    print("   предмет:", v[:50])
