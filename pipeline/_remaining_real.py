# -*- coding: utf-8 -*-
"""Скільки СПРАВДІ лишилося перекладати — за унікальними текстами, не ID.

_status.py показує сирий борг: усе, чого немає в базі. Але частина того —
не текст для людини: числа, розмітка, службові рядки [DNT]/Generic, одиночні
символи, рядки неанглійського клієнта й ніки гравців. Міряти борг разом із
ними — це завищувати його в рази [[count-unique-texts-not-ids]].

Тут міряємо так, як треба: БЕРЕМО РІЗНИЦЮ МНОЖИН зібраних текстів і всіх
ключів бази, тоді відсіюємо службове й показуємо обидва числа — сире й чисте.

Бакет `npc` — окремий випадок: його ключі це creatureID, а не текст. Тому для
нього міряємо не ключі, а АНГЛІЙСЬКІ ІМЕНА, яких ще немає в шарі плашок — і
саме за повним індексом ID->EN (усі джерела істот), бо `NpcNames.lua`
ключується англійською, і той самий EN під іншим ID уже працює.

Запуск: python _remaining_real.py [--file "<шлях до одного збору>"]
"""
import glob
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import known_nicks

BUCKETS = ("broadcast", "gossip", "uitooltip", "objLines", "minimap",
           "profui", "subnames", "journeys", "npc")

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
ALL_KEYS = set()
for d in tr.values():
    if isinstance(d, dict):
        ALL_KEYS |= {k for k in d if isinstance(k, str)}

NICKS = {n for n in known_nicks(min_len=4, drop_ambiguous=False)}
SERVICE = re.compile(r"\[DNT\]|^Generic\b|\bKill Credit\b|\bWidget\b|\bBunny\b"
                     r"|^\s*$|^[\W\d_]+$|PH\b|placeholder", re.I)
# латиниця обов'язкова: рядок без жодної латинської літери прийшов не з
# англійського клієнта (кирилиця = чужий переклад, CJK = чужий клієнт)
LAT = re.compile(r"[A-Za-z]")
DE = re.compile(r"(?:^|\s)(?:der|des|die|das|und|von|aus|zum)(?:\s|$)|[äöüßÄÖÜ]")


def block(src, name):
    m = re.search(r'(?m)^\s*\["' + re.escape(name) + r'"\]\s*=\s*\{', src)
    if not m:
        return ""
    i, depth, instr, esc = m.end(), 1, False, False
    while i < len(src) and depth:
        c = src[i]
        if instr:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                instr = False
        elif c == '"':
            instr = True
        elif c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
        i += 1
    return src[m.end():i - 1]


ARG = sys.argv[1:]
only = ARG[ARG.index("--file") + 1] if "--file" in ARG else None
files = [only] if only else glob.glob(str(DATA_DIR.parent / "testerlua" / "*.lua"))
texts = []
for f in files:
    try:
        texts.append(open(f, encoding="utf-8", errors="replace").read())
    except OSError as e:
        print("!!", f, e)
print(f"файлів зборів: {len(texts)}\n")

# --- бакет npc: ключі це ID, тож міряємо англійські імена без перекладу ------
npc_tr = tr.get("npcNames") or {}
en_of = {}
for name in ("api_creatures_full.json", "captured_creatures.json",
             "_midnight_creatures.json", "creatures.json"):
    p = DATA_DIR / "source" / name
    if not p.exists():
        continue
    try:
        d = json.loads(p.read_text(encoding="utf-8-sig"))
    except ValueError:
        continue
    for cid, v in (d.items() if isinstance(d, dict) else ()):
        nm = v.get("name") if isinstance(v, dict) else None
        en = nm.get("en") if isinstance(nm, dict) else None
        if en:
            en_of[str(cid)] = en
# ЗБОРИ — ТРЕТЄ ДЖЕРЕЛО ID->EN, і без нього лічба бреше: 5 209 перекладених ID
# не мають англійської назви в датамайні (їхній EN прийшов саме зі збору).
# Без цього кроку їхні імена читалися як «нові», і борг по npc роздувався
# з двох сотень до двох тисяч [[captured-creatures-source]]. Індекс будуємо з
# УСІХ зборів, навіть коли міряємо один файл.
for f in glob.glob(str(DATA_DIR.parent / "testerlua" / "*.lua")):
    try:
        src = open(f, encoding="utf-8", errors="replace").read()
    except OSError:
        continue
    blk = block(src, "npc")
    for m in re.finditer(r'\["(\d+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', blk):
        nm = m.group(2).replace('\\"', '"')
        if nm and nm != "Unknown":
            en_of.setdefault(m.group(1), nm)
# EN-імена, що вже мають переклад бодай під одним ID
plate_en = {en_of[c] for c in npc_tr if c in en_of and isinstance(npc_tr[c], str)
            and npc_tr[c]}
print(f"{'бакет':<14}{'сире':>9}{'службове':>10}{'чуже':>7}{'ніки':>7}{'ЧИСТО':>8}")

total = 0
for b in BUCKETS:
    keys = set()
    for t in texts:
        blk = block(t, b)
        if not blk:
            continue
        if b == "npc":
            # ["ID"] = "English Name" -> беремо ЗНАЧЕННЯ, і то лише ті імена,
            # яких немає в шарі плашок під жодним ID
            for m in re.finditer(r'\["(\d+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', blk):
                nm = m.group(2).replace('\\"', '"')
                if nm and nm != "Unknown" and nm not in plate_en:
                    keys.add(nm)
            continue
        for m in re.finditer(r'\["((?:[^"\\]|\\.)*)"\]', blk):
            k = m.group(1).replace('\\"', '"').replace("\\n", "\n")
            if k:
                keys.add(k)
    left = keys if b == "npc" else keys - ALL_KEYS
    if not left:
        continue
    serv = {k for k in left if SERVICE.search(k) or len(k) < 3}
    rest = left - serv
    alien = {k for k in rest if not LAT.search(k) or DE.search(k)}
    rest -= alien
    nick = {k for k in rest if any(n in k for n in NICKS if len(n) > 4)}
    rest -= nick
    total += len(rest)
    print(f"{b:<14}{len(left):>9}{len(serv):>10}{len(alien):>7}{len(nick):>7}{len(rest):>8}")

print(f"\n{'РАЗОМ чистого боргу зі зборів':<45}{total:>8}")
