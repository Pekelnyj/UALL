# -*- coding: utf-8 -*-
"""Прибрати 6 витоків, які знайшов _check_guild_leak після хвилі 15.10.

Усі шість — ключі, що існують лише для ОДНОГО гравця, тож у грі вони однаково
мертві, а в базі це ім'я живої людини [[guild-names-never-translate]]:
  • «Alyth-Ragnaros», «Nimonimo-Nemesis» — ніки з реалмом, ще й перекладені;
  • дві надгробні репліки «Here lies <Нік>-<Реалм>…»;
  • «Leader: Ht-Gilneas (Alliance)» — тут ще й ЧУЖЕ значення під ключем
    («Мисливець за скарбами: Звивистий Острів»), тобто разом із витоком сидить
    підміна ключ↔значення [[kv-shift-substitution]];
  • «Haranir the Seeker-Sunstrider» — суфікс реалму й покручений переклад.

НЕ чіпаємо «Crag-Leaper's Cache»: це законна назва схованки, слово «Leaper»
просто збіглося зі зібраним списком ніків.

Запуск: python _drop_leaks_1015.py [--apply]
"""
import io
import json
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))

MARKS = [("uiTooltips", "Alyth-Ragnaros"),
         ("uiTooltips", "Nimonimo-Nemesis"),
         ("uiTooltips", "Haranir the Seeker-Sunstrider"),
         ("uiTooltips", "Leader: Ht-Gilneas"),
         ("gossip", "Here lies Ethrénïs-Ysondre"),
         ("gossip", "Here lies Pacdk-Thrall")]

dropped = 0
for sec, frag in MARKS:
    d = tr.get(sec) or {}
    for k in [k for k in d if frag in k]:
        print(f"  [{sec}] «{k[:70]}»\n       -> «{str(d[k])[:70]}»")
        if APPLY:
            del d[k]
        dropped += 1

print(f"\nпід викид: {dropped}")
if not APPLY:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("translations.json записано")
