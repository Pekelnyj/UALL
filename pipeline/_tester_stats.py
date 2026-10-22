# -*- coding: utf-8 -*-
"""Скільки НОВОГО приніс кожен тестерський збір.

Рахуємо чесно, а не «скільки рядків у файлі»:
  • проти ПРАВИЛЬНОЇ секції бази (бакет != ключ секції
    [[sv-bucket-vs-section-key]]);
  • з відсівом рантайму (capfilter) — лічильники, суми, таймери ключем не стануть;
  • з відсівом імен гравців, гільдій і речей гравців [[player-name-leak-gate]];
  • «унікальне» = чого немає ні в базі, ні в інших файлах цієї партії, тобто
    саме внесок цього тестера, а не спільна частина.

Запуск: python _tester_stats.py "../testerlua/UALL (72).lua" ...
"""
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
import capfilter
from playernames import known_nicks, nick_regex

FILES = [Path(p) for p in sys.argv[1:]]
if not FILES:
    sys.exit("вкажи файли зборів")

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
crea = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
cap = json.loads((DATA_DIR / "source" / "captured_creatures.json").read_text(encoding="utf-8-sig"))

anchors = set()
for cid, v in crea.items():
    if isinstance(v, dict):
        nm = v.get("name") if isinstance(v.get("name"), dict) else v
        en = nm.get("en") if isinstance(nm, dict) else None
        if en:
            anchors.add(en)
anchors |= {v for v in cap.values() if isinstance(v, str)}

# бакет -> секція бази. subnames свідомо НЕ рахуємо як роботу: джерела з ID
# нема, гільдію від титулу NPC не відрізнити.
MAP = {
    "gossip": "gossip", "broadcast": "broadcast", "objLines": "questObjectives",
    "uitooltip": "uiTooltips", "profui": "globalStrings", "profdesc": "profDesc",
    "playerchoice": "playerChoice", "renown": "renown", "mail": "mail",
    "subjects": "mail", "ui": "uiStrings", "system": "system",
    "npc": "npcNames", "quests": "quests", "spellCapture": "spells",
    "minimap": "minimapLabels", "lines": "broadcast",
}
SKIP = {"subnames"}

NICK = nick_regex(min_len=4)
REALMS = {"Aggra(Português)"}
nicks = set(known_nicks())
PAIR = re.compile(r"\b([A-Za-zÀ-ÿ'’]{3,})-([A-Z][A-Za-z]{2,}(?:\([^)]+\))?)\b")
OWNED = re.compile(r"^(?!(?:A|An|The)\s)(.+?)'s\s+"
                   r"(Pet|Minion|Gateway|Companion|Guardian|Ghoul|Steed|Mount|"
                   r"Familiar|Butler|Servant|Imp|Voidwalker|Felhunter)$")
FMT = re.compile(r"%[-\d.]*[sdfg]")


def block(s, key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
    i, depth, st = m.end(), 1, m.end()
    instr = esc = False
    while i < len(s) and depth > 0:
        c = s[i]
        if instr:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                instr = False
        else:
            if c == '"':
                instr = True
            elif c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
        i += 1
    return s[st:i - 1]


def un(x):
    x = x.replace("\\\\", "\x00")
    x = (x.replace('\\"', '"').replace("\\n", "\n")
          .replace("\\r", "\r").replace("\\t", "\t"))
    return x.replace("\x00", "\\")


texts, owners = {}, {}
for f in FILES:
    s = f.read_text(encoding="utf-8", errors="replace")
    texts[f] = s
    m = re.search(r'\["playerName"\]\s*=\s*"([^"]*)"', s)
    owners[f] = m.group(1) if m else f.stem
    for a, b in PAIR.findall(s):
        if a in nicks or a == owners[f]:
            REALMS.add(b)
REALM_RX = re.compile(r"-(?:%s)\b" % "|".join(re.escape(r) for r in sorted(REALMS)))


def is_player(k):
    return bool(REALM_RX.search(k) or OWNED.match(k) or NICK.search(k))


# Секції, що тримають %s-ШАБЛОНИ (system, emotes): простого «чи є ключ у базі»
# замало — «<нік> joins the party.» покривається шаблоном «%s joins the
# party.», хоч дослівно його в базі нема. Матчимо так само, як ChatHooks.
def build_tpl(sec):
    d = tr.get(sec) or {}
    exact = {k for k in d if "%s" not in k}
    pats = []
    for en in d:
        if "%s" in en:
            n = en.count("%s")
            rx = re.compile("^" + "(.+)".join(re.escape(x) for x in en.split("%s")) + "$")
            pats.append((rx, len(en) - 2 * n, n))
    pats.sort(key=lambda p: (-p[1], p[2]))
    return exact, [p[0] for p in pats]


TPL = {sec: build_tpl(sec) for sec in ("system", "emotes")}


def covered_by_template(sec, k):
    t = TPL.get(sec)
    if not t:
        return False
    exact, pats = t
    if k in exact:
        return True
    return any(rx.match(k) for rx in pats)


# збір -> бакет -> множина НОВИХ (проти бази) ключів
raw = defaultdict(lambda: defaultdict(set))
dropped = defaultdict(lambda: defaultdict(int))
for f in FILES:
    for b, sec in MAP.items():
        blk = block(texts[f], b)
        if not blk:
            continue
        keys = {un(k) for k in re.findall(r'\["((?:[^"\\]|\\.)*)"\]', blk)}
        base = tr.get(sec) or {}
        new = [k for k in keys if k not in base and re.search(r"[A-Za-z]{3}", k)
               and not covered_by_template(sec, k)]
        good, drop = capfilter.split(new)
        good = [k for k in good if not FMT.search(k)]
        players = [k for k in good if is_player(k)]
        good = [k for k in good if not is_player(k)]
        raw[f][b] = set(good)
        dropped[f][b] = len(new) - len(good)
        dropped[f]["_players"] += len(players)

# унікальне = нема в інших файлах партії
uniq = {}
for f in FILES:
    others = set()
    for g in FILES:
        if g is not f:
            for b in raw[g]:
                others |= raw[g][b]
    uniq[f] = {b: raw[f][b] - others for b in raw[f]}

print(f"{'збір':<26}{'тестер':<14}{'НОВОГО':>9}{'унікально':>11}{'відсіяно':>10}")
print("-" * 72)
tot_new = set()
for f in FILES:
    n = sum(len(v) for v in raw[f].values())
    u = sum(len(v) for v in uniq[f].values())
    d = sum(v for k, v in dropped[f].items() if k != "_players") + dropped[f]["_players"]
    print(f"{f.name:<26}{owners[f]:<14}{n:>9}{u:>11}{d:>10}")
    for b in raw[f]:
        tot_new |= raw[f][b]
print("-" * 72)
print(f"{'РАЗОМ унікальних рядків у партії':<49}{len(tot_new):>9}")

print("\nПо бакетах (нове проти бази):")
buckets = sorted({b for f in FILES for b in raw[f] if raw[f][b]},
                 key=lambda b: -sum(len(raw[f][b]) for f in FILES))
hdr = f"{'бакет':<16}" + "".join(f"{owners[f]:>13}" for f in FILES) + f"{'разом':>9}"
print(hdr)
for b in buckets:
    row = f"{b:<16}" + "".join(f"{len(raw[f][b]):>13}" for f in FILES)
    union = set()
    for f in FILES:
        union |= raw[f][b]
    print(row + f"{len(union):>9}")
print(f"\nвідсіяно імен гравців/гільдій: "
      + ", ".join(f"{owners[f]}={dropped[f]['_players']}" for f in FILES))
print(f"(бакет subnames не рахується: {', '.join(sorted(SKIP))} — нема ID-якоря)")
