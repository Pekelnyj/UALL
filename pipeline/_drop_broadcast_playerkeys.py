# -*- coding: utf-8 -*-
"""Зняти broadcast-ключі, у яких перше слово — підставлене ім'я гравця.

Родину знаходимо доказом, а не списком ніків (список знає лише НАШИХ тестерів,
а тут сторонні гравці): той самий хвіст речення з РІЗНИМИ першими словами —
це серверна підстановка, а не власна назва. Той самий критерій, що в гейті
_check_playernames.py.

ЩО ЗНІМАЄМО:
  * чужий нік («<нік> activated an Unstable Nether Portal in …») —
    витік [[guild-names-never-translate]] і водночас мертвий ключ: він
    не зматчиться більше ні в кого;
  * «{name}» малими — мертвий токен. Хук нормалізує ім'я гравця ЛИШЕ у
    «{NAME}» (NormName), тож ключ із «{name}» не збігається ніколи. На екран
    він не потрапляє — це не видимий баг, а баласт від чужого нормалізатора.

ЩО ЛИШАЄМО:
  * «{NAME}» — законний ключ: хук підставляє ім'я читача, і для власних дій
    гравця рядок працює правильно.

ЧОГО НЕ РОБИМО. Не зводимо родину в «%s …»: у цих реченнях змінна не лише
ім'я, а й ЗОНА, а другим %s її робити не можна — trBy вставляє захоплене без
змін, тож назва зони лишилась би англійською. Потрібен шаблон на кожну зону,
а 24 назви цієї родини не мають канону більше ніде в базі й розходяться між
собою (Deadwood Landing: «Мертволісся»/«Пристань Мертволісся»/«Пристань
Сухолісся»). Це вирок, а не механічна заміна.

Запуск: python _drop_broadcast_playerkeys.py [--apply]
Далі:   python _sync_broadcast_master.py
"""
import io
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
DB = DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua"

TAIL_MIN = 25
LEADER = re.compile(r"^([A-ZÀ-Þ{][\w'À-ɏ{}]{2,})\s+(.+)$", re.S)
STOP = {"The", "This", "That", "These", "Those", "Her", "His", "Its", "Their",
        "Our", "Your", "They", "She", "You", "We", "It", "And", "But", "For",
        "All", "Not", "Now", "How", "What", "When", "Where", "Who", "Why",
        "One", "Two", "Some", "Any", "Many", "Every", "Each", "There", "Here"}
KEEP_TOKENS = {"{NAME}"}
LINE = re.compile(r'^\s*\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)",?\s*$')


def un(s):
    s = s.replace("\\\\", "\x00")
    s = (s.replace('\\"', '"').replace("\\n", "\n")
          .replace("\\r", "\r").replace("\\t", "\t"))
    return s.replace("\x00", "\\")


cr = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
NPC = set()
for v in (cr.values() if isinstance(cr, dict) else cr):
    nm = v.get("name") if isinstance(v, dict) else None
    en = nm.get("en") if isinstance(nm, dict) else None
    if en:
        NPC |= set(re.findall(r"[A-Za-z']{3,}", en))

src = DB.read_text(encoding="utf-8")
lines = src.split("\n")
parsed = []
for i, ln in enumerate(lines):
    m = LINE.match(ln)
    parsed.append((i, un(m.group(1)), un(m.group(2))) if m else None)

tails = defaultdict(set)
for p in parsed:
    if not p:
        continue
    _, k, _v = p
    if "%" in k:
        continue
    m = LEADER.match(k)
    if m and len(m.group(2)) >= TAIL_MIN and m.group(1) not in STOP:
        tails[m.group(2).strip()].add(m.group(1))

# родина = хвіст, під яким стоять ≥2 різні перші слова й жодне з них не істота
fam = {t for t, who in tails.items()
       if len(who) >= 2 and not any(w in NPC for w in who)}
print(f"родин з підстановкою: {len(fam)}")

drop_idx, kept = set(), defaultdict(int)
for p in parsed:
    if not p:
        continue
    i, k, v = p
    if "%" in k:
        continue
    m = LEADER.match(k)
    if not m or m.group(1) in STOP:
        continue
    tail, who = m.group(2).strip(), m.group(1)
    if tail not in fam:
        continue
    if who in KEEP_TOKENS:
        kept[tail] += 1
        continue
    drop_idx.add(i)

by_tail = defaultdict(list)
for i in sorted(drop_idx):
    _, k, v = parsed[i]
    by_tail[LEADER.match(k).group(2).strip()].append((LEADER.match(k).group(1), v))
for tail, lst in sorted(by_tail.items()):
    print(f"\n  «…{tail[:60]}»  знімаю {len(lst)}, лишаю {{NAME}}: {kept.get(tail, 0)}")
    for who, v in lst[:4]:
        print(f"      {who:<14} {v[:58]}")
    if len(lst) > 4:
        print(f"      … ще {len(lst) - 4}")

print(f"\nразом на зняття: {len(drop_idx)}")
if not APPLY:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)

out = "\n".join(ln for i, ln in enumerate(lines) if i not in drop_idx)
if out.count("{") != out.count("}"):
    sys.exit("ДИСБАЛАНС дужок — не записую")
io.open(DB, "w", encoding="utf-8", newline="\n").write(out)
print(f"Broadcast.lua: знято {len(drop_idx)}; баланс OK")
