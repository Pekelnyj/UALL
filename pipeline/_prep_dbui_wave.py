# -*- coding: utf-8 -*-
"""426 Blizzard db.ui рядків: формульні keybind-и перекласти скриптом (консистентно),
решту — у батчі для агентів."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

blizz = json.loads((DATA_DIR / "_dbui_blizz.json").read_text(encoding="utf-8"))

auto = {}            # формульні → UA
rest = []            # на переклад агентами
for s in blizz:
    m = re.match(r"^Action Bar (\d+) Button (\d+)$", s)
    if m:
        auto[s] = f"Панель дій {m.group(1)}, кнопка {m.group(2)}"
        continue
    m = re.match(r"^Action Button (\d+)$", s)
    if m:
        auto[s] = f"Кнопка дії {m.group(1)}"
        continue
    m = re.match(r"^Bonus Action Button (\d+)$", s)
    if m:
        auto[s] = f"Бонусна кнопка дії {m.group(1)}"
        continue
    m = re.match(r"^Multiaction Bar (\d+) Button (\d+)$", s)
    if m:
        auto[s] = f"Мультипанель {m.group(1)}, кнопка {m.group(2)}"
        continue
    rest.append(s)

json.dump(auto, open(DATA_DIR / "_dbui_auto.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)

OUT = DATA_DIR / "batches" / "uistr"
OUT.mkdir(parents=True, exist_ok=True)
for f in OUT.glob("*.json"):
    f.unlink()
B = 48
rest.sort()
nb = (len(rest) + B - 1) // B
for k in range(nb):
    (OUT / f"us_{k:02d}.json").write_text(
        json.dumps(rest[k * B:(k + 1) * B], ensure_ascii=False, indent=1), encoding="utf-8")
print(f"формульних (скрипт): {len(auto)} | на агентів: {len(rest)} | батчів по {B}: {nb}")
