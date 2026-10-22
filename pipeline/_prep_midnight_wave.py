# -*- coding: utf-8 -*-
"""Черга на переклад для доповнення ОПІВНІЧ: імена істот і назви об'єктів світу.

Квести Опівночі закриті, а от імена істот і назви об'єктів — ні, і саме вони
видні гравцеві щохвилини: над мобом, на неймплейті, у трекері, на мапі.

Доба визначається за діапазоном ID: у Blizzard вони зростають монотонно, тож
межа Опівночі — creature >= 240000, gameobject >= 470000. Це евристика, а не
поле в даних; для вибору обсягу роботи її досить, у переклад вона не потрапляє.

Відсів:
  • службові рядки розробників («… - Mix 761», «[DNT]», «Test», «PH»);
  • те, що вже перекладено (ключ istот = ID, об'єктів = АНГЛІЙСЬКА НАЗВА —
    у цих двох секцій ключі різні [[sv-bucket-vs-section-key]]);
  • імена гравців [[guild-names-never-translate]].

-> data/batches/midnight/npc_NN.json   (об'єкти: gobj_NN.json)
Далі: переклад -> out_npc_*.json / out_gobj_*.json -> _merge_midnight_wave.py

Запуск: python _prep_midnight_wave.py [розмір_батча]
"""
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import nick_regex

SIZE = int(sys.argv[1]) if len(sys.argv) > 1 else 40
NPC_FROM, GOBJ_FROM = 240000, 470000

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
NICK = nick_regex(min_len=4)

# Службове від розробників Blizzard: у гру такі рядки не потрапляють або
# потрапляють як брак, і перекладати їх не можна [[no-overclaiming-coverage]].
DEV = re.compile(
    r"(?:\s-\s*Mix\s*\d+$)"          # «… - Mix 761» — варіанти одного об'єкта
    r"|^\[?(?:DNT|PH|TEST|UNUSED|DEPRECATED)\b"
    r"|\b(?:DO ?NOT ?USE|Placeholder|placeholder)\b"
    # Внутрішні імена ассетів, які гравець не бачить ніколи: версійний префікс
    # патча («11.0 Z1 - Theater - Established Props»), підкреслення замість
    # пробілів («11.2_Razorwind_CommunityPlot_Stage1»), технічні об'єкти
    # (Props, Collision, Bunny — службовий маркер Blizzard) і код зони Z1/Z2.
    r"|^\d+(?:\.\d+)*[\s_]"
    r"|^\d+xp_"
    r"|_[A-Za-z]"
    r"|\b(?:Props?|Collision|Blocker|Invisible|Trigger|Spawner|DEBUG|Bunny)\b"
    r"|\bZ\d+\b"
    r"|^\W+$"
    r"|^\d+$",
    re.I)


def load(name):
    return json.loads((DATA_DIR / "source" / name).read_text(encoding="utf-8-sig"))


def en_name(v):
    nm = v.get("name") if isinstance(v, dict) else None
    return nm.get("en") if isinstance(nm, dict) else None


def chunk(items, prefix):
    d = DATA_DIR / "batches" / "midnight"
    d.mkdir(parents=True, exist_ok=True)
    for f in d.glob(f"{prefix}_*.json"):
        f.unlink()
    n = (len(items) + SIZE - 1) // SIZE
    for k in range(n):
        (d / f"{prefix}_{k:02d}.json").write_text(
            json.dumps(items[k * SIZE:(k + 1) * SIZE], ensure_ascii=False, indent=1),
            encoding="utf-8")
    return n


def report(label, raw, dev, nick, kept):
    print(f"{label}: у добі {raw} | службових {dev} | ніків {nick} | "
          f"НА ПЕРЕКЛАД {kept}")


# --- істоти: ключ бази = ID ---------------------------------------------------
cr = load("creatures.json")
done = tr.get("npcNames", {})
raw = dev = nick = 0
npc = []
for k, v in cr.items():
    if not k.isdigit() or int(k) < NPC_FROM:
        continue
    en = en_name(v)
    if not en or done.get(k):
        continue
    raw += 1
    if DEV.search(en):
        dev += 1
        continue
    if NICK.search(en):
        nick += 1
        continue
    npc.append({"id": k, "en": en})
npc.sort(key=lambda x: int(x["id"]))
report("Істоти Опівночі", raw, dev, nick, len(npc))

# --- об'єкти світу: ключ бази = АНГЛІЙСЬКА НАЗВА ------------------------------
go = load("gameobjects.json")
gdone = tr.get("gameObjects", {})
raw = dev = nick = 0
seen, gobj = set(), []
for k, v in go.items():
    if not k.isdigit() or int(k) < GOBJ_FROM:
        continue
    en = en_name(v)
    if not en or gdone.get(en) or en in seen:
        continue
    seen.add(en)
    raw += 1
    if DEV.search(en):
        dev += 1
        continue
    if NICK.search(en):
        nick += 1
        continue
    gobj.append({"id": k, "en": en})
gobj.sort(key=lambda x: x["en"])
report("Об'єкти Опівночі", raw, dev, nick, len(gobj))

print(f"-> npc-батчів {chunk(npc, 'npc')} | gobj-батчів {chunk(gobj, 'gobj')}"
      f" (по {SIZE})")
