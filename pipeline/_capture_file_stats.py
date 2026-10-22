# -*- coding: utf-8 -*-
"""Скільки приніс ОДИН файл збору тестера: старе / нове по кожному бакету.

Питання «що дав новий файл» відрізняється від _status.py (той міряє борг по
ВСІХ зборах). Тут для кожного бакета одного файлу:

  зібрано      — унікальні записи в бакеті;
  у базі       — уже перекладено (старе);
  не в базі    — перекладу немає, і з них:
    бачили     — уже траплялося в попередніх зборах (старе, але не закрите);
    вперше     — жоден попередній збір цього не мав (справді нове);
  до перекладу — «вперше» мінус відсів (рантайм, імена гравців, чужа мова,
                 службове, %-шаблони). Це оцінка; точну чергу дають препи.

Порівняння — РІЗНИЦЯ МНОЖИН [[count-unique-texts-not-ids]]; рядкові бакети
міряються проти ОБ'ЄДНАННЯ всіх секцій бази [[sv-bucket-vs-section-key]].

Запуск: python _capture_file_stats.py "<файл збору>"
"""
import glob
import json
import os
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
import capfilter
from playernames import known_nicks

if len(sys.argv) < 2:
    sys.exit("вкажи файл збору")
TARGET = os.path.abspath(sys.argv[1])
R = DATA_DIR.parent
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
SECTIONS = {s: d for s, d in tr.items() if isinstance(d, dict)}
ALL_KEYS = set()
for d in SECTIONS.values():
    ALL_KEYS.update(k for k in d if isinstance(k, str))
NICK_RX = re.compile(r"\b(" + "|".join(re.escape(n) for n in sorted(
    known_nicks(min_len=4), key=len, reverse=True)) + r")\b")


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


def unq(s):
    return (s.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r")
             .replace("\\\\", "\\"))


def top_keys(b):
    """Ключі ВЕРХНЬОГО рівня бакета (рядкові або числові)."""
    keys, depth, i, n = set(), 0, 0, len(b)
    key_rx = re.compile(r'\[(?:"((?:[^"\\]|\\.)*)"|(\d+))\]\s*=')
    while i < n:
        c = b[i]
        if c == '"':                       # пропустити рядок
            j = i + 1
            while j < n and b[j] != '"':
                j += 2 if b[j] == "\\" else 1
            i = j + 1
            continue
        if c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
        elif c == "[" and depth == 0:
            m = key_rx.match(b, i)
            if m:
                keys.add(unq(m.group(1)) if m.group(1) is not None else m.group(2))
                i = m.end()
                continue
        i += 1
    return keys


def all_strings(b):
    return {unq(s) for s in re.findall(r'"((?:[^"\\]|\\.)*)"', b)}


STRING_BUCKETS = ["broadcast", "gossip", "uitooltip", "objLines", "subnames",
                  "profui", "minimap", "journeys", "playerchoice", "system",
                  "ui", "renown", "profdesc"]
LORE_BUCKETS = ["books", "Plaque"]          # назва -> сторінки: рахуємо сторінки


def collect(src):
    out = {}
    for b in STRING_BUCKETS:
        out[b] = top_keys(block(src, b))
    for b in LORE_BUCKETS:
        out[b] = {s for s in all_strings(block(src, b)) if re.search(r"[A-Za-z]{3}", s)}
    npc = {}
    for cid, nm in re.findall(r'\[(?:"|)(\d+)(?:"|)\]\s*=\s*"((?:[^"\\]|\\.)*)"', block(src, "npc")):
        npc[cid] = unq(nm)
    out["npc"] = npc
    out["quests"] = top_keys(block(src, "quests"))
    out["spellCapture"] = top_keys(block(src, "spellCapture"))
    return out


target_src = open(TARGET, encoding="utf-8", errors="replace").read()
T = collect(target_src)

others = glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/UALL.lua")
others += glob.glob(str(R / "testerlua" / "*.lua"))
others = [p for p in others if os.path.abspath(p) != TARGET]
SEEN = {k: set() for k in T}
for p in others:
    try:
        o = collect(open(p, encoding="utf-8", errors="replace").read())
    except OSError:
        continue
    for k, v in o.items():
        SEEN[k] |= set(v.keys() if isinstance(v, dict) else v)
print(f"файл: {os.path.basename(TARGET)} | попередніх зборів для порівняння: {len(others)}\n")


def filtered(s):
    return bool(capfilter.why_runtime(s) or capfilter.is_foreign(s)
                or capfilter.is_service(s) or "%" in s or NICK_RX.search(s))


rows = []
# рядкові бакети
for b in STRING_BUCKETS + LORE_BUCKETS:
    keys = T[b]
    if not keys:
        continue
    have = {k for k in keys if k in ALL_KEYS or k.strip() in ALL_KEYS}
    miss = keys - have
    seen = {k for k in miss if k in SEEN[b]}
    first = miss - seen
    todo = {k for k in first if not filtered(k)}
    rows.append((b, len(keys), len(have), len(miss), len(seen), len(first), len(todo)))
# npc за ID
npcN = SECTIONS.get("npcNames", {})
ids = set(T["npc"])
have = {c for c in ids if c in npcN}
miss = ids - have
seen = {c for c in miss if c in SEEN["npc"]}
first = miss - seen
todo = {c for c in first if not NICK_RX.search(T["npc"][c]) and not capfilter.is_foreign(T["npc"][c])}
rows.append(("npc (ID)", len(ids), len(have), len(miss), len(seen), len(first), len(todo)))
# квести за ID
q = SECTIONS.get("quests", {})
ids = T["quests"]
have = {c for c in ids if c in q}
miss = ids - have
seen = {c for c in miss if c in SEEN["quests"]}
rows.append(("quests (ID)", len(ids), len(have), len(miss), len(seen), len(miss - seen), len(miss - seen)))
# закляття за ID
sp = SECTIONS.get("spells", {})
ids = T["spellCapture"]
have = {c for c in ids if c in sp}
miss = ids - have
seen = {c for c in miss if c in SEEN["spellCapture"]}
rows.append(("spellCapture (ID)", len(ids), len(have), len(miss), len(seen), len(miss - seen), len(miss - seen)))

hdr = ("бакет", "зібрано", "у базі", "не в базі", "бачили", "вперше", "до перекл.")
print("| " + " | ".join(hdr) + " |")
print("|" + "---|" * len(hdr))
tot = [0] * 6
for r in rows:
    print("| " + " | ".join(str(x) for x in r) + " |")
    tot = [a + b for a, b in zip(tot, r[1:])]
print("| **разом** | " + " | ".join(f"**{x}**" for x in tot) + " |")
