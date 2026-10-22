# -*- coding: utf-8 -*-
"""Звести toy-broadcast до %s-шаблонів і прибрати з них імена гравців.

ЩО СТАЛОСЯ. Повідомлення іграшок («X places a cozy Harandar Celebration…»)
прилітають на CHAT_MSG_MONSTER_EMOTE, тож збирач клав їх у db.broadcast уже
З ПІДСТАВЛЕНИМ іменем того, хто вжив іграшку. У базі осіло 33 таких записи, і
хвилі їх сумлінно переклали — разом із ніками. Наслідки троякі:

  1. ВИТІК: ніки чужих гравців не просто лишилися, а транслітерувалися
     («Hananami» -> «Гананамі»), а «Overlòrd» узагалі перекладено як
     «Володар». Це порушення залізного правила [[guild-names-never-translate]].
  2. МЕРТВИЙ КЛЮЧ: рядок з ім'ям конкретної людини не зматчиться більше
     ні в кого — переклад бачить рівно один гравець.
  3. ВИДИМИЙ БАГ: два записи мають токен «{name}» малими літерами, а LocName
     підставляє лише «{NAME}». Гравець бачить на екрані буквально «{name}».

ЧОМУ НЕ {NAME}. Спокусливо зтокенізувати нік у {NAME}, як робить
_fix_broadcast_playernames.py. Але той токен хук розгортає в ім'я ЧИТАЧА, а
свято влаштував хтось інший — вийшло б «Ви влаштовуєте свято», якого ви не
влаштовували. Для чужого імені годиться лише %s: trBy вставляє захоплене
назад БЕЗ ЗМІН, тобто перекладає речення й не чіпає ім'я.

Назви іграшок беремо з itemNames — щоб у чаті стояло те саме, що в підказці
предмета [[context-scoped-translation]].

Запуск: python _fix_toy_broadcast.py [--apply]
Далі:   python _sync_broadcast_master.py && python generate_db.py
"""
import io
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
DB = DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua"

# Форми, у яких гра підставляє ім'я гравця першим аргументом. Свідомо вузькі:
# ширша спроба («Хтось activates …») затягла звичайну репліку NPC «Our champions
# have lost much blood in the struggle to activate this Scourge transporter».
SHAPES = [
    re.compile(r"^(.+?) (places a cozy .+ for everyone to enjoy!)$"),
    re.compile(r"^(.+?) (sets out a .+!)$"),
]

# Канон назв — з itemNames. Дієслово: «влаштовує» для свят (домінанта 12:4),
# «виставляє» для приладів.
TEMPLATES = {
    "%s places a cozy Harandar Celebration for everyone to enjoy!":
        "%s влаштовує затишне Свято Гарандара на радість усім!",
    "%s places a cozy Blooming Feast for everyone to enjoy!":
        "%s влаштовує затишний Квітучий бенкет на радість усім!",
    "%s places a cozy Silvermoon Parade for everyone to enjoy!":
        "%s влаштовує затишний Парад Сільвермуна на радість усім!",
    "%s places a cozy Quel'dorei Medley for everyone to enjoy!":
        "%s влаштовує затишну Суміш кель'дореїв на радість усім!",
    "%s sets out a Transmorpher Beacon!":
        "%s виставляє Маяк Трансморфера!",
    "%s sets out a Toy Train Set!":
        "%s виставляє Іграшкову Залізницю!",
}

LINE = re.compile(r'^\s*\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)",?\s*$')


def un(s):
    s = s.replace("\\\\", "\x00")
    s = (s.replace('\\"', '"').replace("\\n", "\n")
          .replace("\\r", "\r").replace("\\t", "\t"))
    return s.replace("\x00", "\\")


def esc(s):
    return (s.replace("\\", "\\\\").replace('"', '\\"')
             .replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t"))


src = DB.read_text(encoding="utf-8")
lines = src.split("\n")
keep, dropped = [], []
for ln in lines:
    m = LINE.match(ln)
    if m:
        k = un(m.group(1))
        if "%" not in k:
            for rx in SHAPES:
                mm = rx.match(k)
                if mm:
                    dropped.append((mm.group(1), k, un(m.group(2))))
                    break
            else:
                keep.append(ln)
                continue
            continue
    keep.append(ln)

print(f"знімаю записів родини: {len(dropped)}")
for who, _k, ua in dropped:
    print(f"  {who:<16} {ua[:62]}")

have = {un(m.group(1)) for m in (LINE.match(l) for l in keep) if m}
add = [(en, ua) for en, ua in TEMPLATES.items() if en not in have]
print(f"\nдодаю %s-шаблонів: {len(add)} (з {len(TEMPLATES)}; решта вже є)")
for en, ua in add:
    print(f"  {en}\n     -> {ua}")

if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)

out = "\n".join(keep)
idx = out.rstrip().rfind("}")
ins = "".join(f'    ["{esc(en)}"] = "{esc(ua)}",\n' for en, ua in add)
out = out[:idx] + ins + out[idx:]
if out.count("{") != out.count("}"):
    sys.exit("ДИСБАЛАНС дужок — не записую")
io.open(DB, "w", encoding="utf-8", newline="\n").write(out)
print(f"\nBroadcast.lua: знято {len(dropped)}, додано {len(add)}; баланс OK")
