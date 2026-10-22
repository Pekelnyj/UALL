# -*- coding: utf-8 -*-
"""Черга БАЛАЧОК (gossip) на переклад — із кількох файлів збору одразу.

Чому не _extract_gossip.py: у ньому зашито один шлях до SavedVariables
(ще під стару назву WoWUkraine.lua), тож партія тестерських зборів до нього не
доїжджає [[sv-rename-uald-bridge]]. Тут — як у _prep_broadcast_wave: приймаємо
список файлів, дедупимо проти бази, проганяємо через capfilter і заслони ніків.

Відсіюємо (і звітуємо, скільки чого):
  • те, що вже є в gossip / questObjectives / uiTooltips бази;
  • рантайм і службове (capfilter);
  • рядки з іменами гравців: нік власника збору -> {NAME}, чужі ніки -> геть;
  • текст неанглійського клієнта;
  • %-шаблони (інша система).

Запуск: python _prep_gossip_wave.py "<файл1>" ["<файл2>" ...] [--size 40]
Вихід:  data/batches/gossip/g_NN.json  [англ. рядок, ...]
Злиття: _merge_gossip_wave.py читає out_g_NN.json {en: ua}
"""
import glob
import json
import re
import sys
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
import capfilter
from playernames import nick_regex, known_nicks

SIZE = 40
args = []
_skip = False
for _i, _a in enumerate(sys.argv[1:]):
    if _skip:
        _skip = False
        continue
    if _a == "--size":                      # значення прапорця — НЕ файл збору
        SIZE = int(sys.argv[_i + 2])
        _skip = True
    elif not _a.startswith("--"):
        args.append(_a)
paths = args or glob.glob(
    r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/UALL.lua")
OUT = DATA_DIR / "batches" / "gossip"

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
done = set()
for sec in ("gossip", "questObjectives", "uiTooltips", "broadcast"):
    d = tr.get(sec)
    if isinstance(d, dict):
        done |= set(d.keys())

CYRIL = re.compile("[А-Яа-яІіЇїЄєҐґ]")


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
             .replace("\\t", "\t").replace("\\\\", "\\"))


owners, texts = [], set()
for p in paths:
    try:
        src = Path(p).read_text(encoding="utf-8", errors="replace")
    except OSError as e:
        print(f"!! {p}: {e}")
        continue
    m = re.search(r'\["playerName"\]\s*=\s*"([^"]+)"', src)
    if m:
        owners.append(m.group(1))
    b = block(src, "gossip")
    if b:
        texts |= {unq(x.group(1)) for x in re.finditer(r'\["((?:[^"\\]|\\.)*)"\]', b)}

print(f"зборів у роботі: {len(paths)} | імена власників: {owners}")
print(f"унікальних балачок у зборах: {len(texts)}")

PLAYER_RX = [re.compile(r"\b" + re.escape(o) + r"\b") for o in owners if len(o) >= 3]
NICK = nick_regex(min_len=4)
todo, drop = [], Counter()
for en in sorted(texts):
    if not en or not re.search(r"[A-Za-z]{3}", en):
        drop["без англійського тексту"] += 1
        continue
    # КЛЮЧ МУСИТЬ ЗБІГАТИСЯ З ТИМ, ЩО БУДУЄ ХУК. GossipHooks перед пошуком
    # зводить переноси до «\n» і підставляє «{name}» У НИЖНЬОМУ регістрі
    # (BroadcastHooks — навпаки, «{NAME}», звідси й плутанина). Ключ із «\r»
    # або з «{NAME}» гра не знайде ніколи: 15.10 таких мертвих ключів у базі
    # набралося 1 787 [[sv-bucket-vs-section-key]].
    norm = en.replace("\r\n", "\n").replace("\r", "\n")
    for rx in PLAYER_RX:
        norm = rx.sub("{name}", norm)
    if norm in done:
        drop["уже в базі"] += 1
        continue
    if CYRIL.search(norm):
        drop["кирилиця в ключі (чужий клієнт/нік)"] += 1
        continue
    if capfilter.is_foreign(norm):
        drop["текст неанглійського клієнта"] += 1
        continue
    why = capfilter.why_runtime(norm)
    if why:
        drop[why] += 1
        continue
    if NICK and NICK.search(norm):
        drop["чужий нік"] += 1
        continue
    if "%" in norm:
        drop["%-шаблон (інша система)"] += 1
        continue
    todo.append(norm)

todo = sorted(set(todo))
print(f"до перекладу: {len(todo)} | відсіяно: {sum(drop.values())}")
for why, n in drop.most_common(10):
    print(f"   {n:>5}  {why}")

OUT.mkdir(parents=True, exist_ok=True)
for f in OUT.glob("g_*.json"):
    f.unlink()
nb = (len(todo) + SIZE - 1) // SIZE
for i in range(nb):
    (OUT / f"g_{i:02d}.json").write_text(
        json.dumps(todo[i * SIZE:(i + 1) * SIZE], ensure_ascii=False, indent=1),
        encoding="utf-8")
print(f"батчів по {SIZE}: {nb} -> {OUT}")
