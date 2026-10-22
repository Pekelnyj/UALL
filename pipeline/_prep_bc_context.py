# -*- coding: utf-8 -*-
"""Порція реплік NPC разом із ПАКЕТОМ ДОКАЗІВ — щоб агент не шукав їх сам.

НАВІЩО. Хвиля 13.09 показала: на 50 коротких реплік агент витрачав 130–220 тис.
токенів і 10–20 хвилин, з них власне переклад — кілька тисяч. Решта — той самий
пошук у кожного агента наново: grep по translations.json (40 МБ), NpcNames.lua,
німецька/французька назва мовця заради роду, підрахунок домінантної форми імені,
вибірка реплік того самого мовця. Два агенти робили цю роботу двічі.

Тут вона робиться ОДИН раз, детерміновано, і кладеться у вхідний файл:

  speaker_ua/de/fr — ім'я мовця в базі + локалізації (доказ роду: die Magierin);
  speaker_lines    — до 5 уже перекладених реплік ЦЬОГО мовця (тон, ти/ви);
  names            — для кожної власної назви з рядка: наявні в базі
                     українські варіанти імені істоти з підрахунком (домінанта
                     видно одразу) + до 3 прикладів «ключ -> переклад»;
  glossary         — лише ті рядки глосарія, що стосуються слів порції.

Мовця для реплік бази знаємо зі ЗБОРІВ (там у broadcast лежить пара
текст↔мовець); мапа кешується в data/batches/_bc_speakers.json.

Запуск:
  python _prep_bc_context.py --take 100 [--skip 0] [--parts 2] [--rescan]
Вихід: data/batches/broadcast/ctx_NN.json
"""
import glob
import json
import re
import sys
from collections import Counter, defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

ARG = sys.argv[1:]


def opt(name, default):
    return int(ARG[ARG.index(name) + 1]) if name in ARG else default


TAKE, SKIP, PARTS = opt("--take", 100), opt("--skip", 0), opt("--parts", 2)
RESCAN = "--rescan" in ARG
R = DATA_DIR.parent
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
cr = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))

# --- черга ------------------------------------------------------------------
queue = []
for f in sorted(glob.glob(str(DATA_DIR / "batches" / "broadcast" / "bc_*.json"))):
    queue += json.loads(open(f, encoding="utf-8").read())
items = queue[SKIP:SKIP + TAKE]
if not items:
    sys.exit("черга порожня")

# --- імена істот: EN -> {UA: скільки ID}, EN -> de/fr ------------------------
ua_by_en = defaultdict(Counter)
loc_by_en = {}
npc = tr.get("npcNames") or {}
for cid, v in cr.items():
    nm = v.get("name") if isinstance(v, dict) else None
    if not isinstance(nm, dict) or not nm.get("en"):
        continue
    en = nm["en"]
    loc_by_en.setdefault(en, {"de": nm.get("de"), "fr": nm.get("fr")})
    u = npc.get(str(cid))
    if isinstance(u, str) and u:
        ua_by_en[en][u] += 1

# --- мапа «репліка -> мовець» зі зборів (кеш) -------------------------------
CACHE = DATA_DIR / "batches" / "_bc_speakers.json"


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


if CACHE.exists() and not RESCAN:
    spk = json.loads(CACHE.read_text(encoding="utf-8"))
else:
    spk = {}
    paths = glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/UALL.lua")
    paths += sorted(glob.glob(str(R / "testerlua" / "*.lua")))
    for p in paths:
        try:
            src = open(p, encoding="utf-8", errors="replace").read()
        except OSError:
            continue
        for k, v in re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"',
                               block(src, "broadcast")):
            k, v = unq(k), unq(v)
            if v:
                spk.setdefault(k, v)
    CACHE.write_text(json.dumps(spk, ensure_ascii=False), encoding="utf-8")
print(f"мапа «репліка -> мовець» зі зборів: {len(spk)}")

bc = tr.get("broadcast") or {}
lines_by_speaker = defaultdict(list)
for en, who in spk.items():
    ua = bc.get(en)
    if ua:
        lines_by_speaker[who].append([en, ua])

# --- власні назви з рядків --------------------------------------------------
STOP = {"I", "A", "An", "The", "You", "Your", "We", "Our", "My", "He", "She",
        "It", "They", "This", "That", "There", "But", "And", "For", "Not",
        "No", "Yes", "If", "So", "Now", "Then", "What", "Who", "Why", "How",
        "When", "Where", "Come", "Go", "Let", "Do", "Don", "All", "Ah", "Oh",
        "Hah", "Bah", "Well", "Here", "Its", "Their", "His", "Her", "Me", "Us"}
PHRASE = re.compile(r"\b([A-ZÀ-Þ][\w'’À-ÿ]+(?: (?:of|the|de) | )?"
                    r"(?:[A-ZÀ-Þ][\w'’À-ÿ]+)?(?: [A-ZÀ-Þ][\w'’À-ÿ]+)?)")


def phrases(text):
    out = set()
    for m in PHRASE.finditer(text):
        p = m.group(1).strip()
        while p and p.split()[0] in STOP:
            p = p.split(" ", 1)[1] if " " in p else ""
        if len(p) >= 3 and p not in STOP:
            out.add(p)
            out.add(p.split()[0])
    return {p for p in out if len(p) >= 3 and p not in STOP}


wanted = set()
for it in items:
    wanted |= phrases(it["en"])
    if it.get("speaker"):
        wanted.add(it["speaker"])
print(f"власних назв у порції: {len(wanted)}")

# приклади «ключ -> переклад» з бази: ОДИН прохід по всіх секціях
BIG = re.compile("|".join(sorted((re.escape(p) for p in wanted), key=len, reverse=True)))
examples = defaultdict(list)
CYR = re.compile(r"[А-Яа-яІіЇїЄєҐґ]")
for sec, d in tr.items():
    if not isinstance(d, dict) or sec in ("spells", "itemNames", "quests"):
        continue
    for k, v in d.items():
        if not isinstance(k, str) or not isinstance(v, str) or not CYR.search(v):
            continue
        if len(k) > 220:
            continue
        for m in BIG.finditer(k):
            p = m.group(0)
            if len(examples[p]) < 3 and [k, v] not in examples[p]:
                examples[p].append([k, v])

# --- глосарій: лише дотичні рядки -------------------------------------------
gl = (R / "pipeline" / "glossary.md").read_text(encoding="utf-8")
words = set()
for it in items:
    words |= {w.lower() for w in re.findall(r"[A-Za-z']{4,}", it["en"])}
glossary = [ln.strip() for ln in gl.splitlines()
            if any(w in ln.lower() for w in words) and "|" in ln][:60]

# --- збірка порцій ----------------------------------------------------------
out_dir = DATA_DIR / "batches" / "broadcast"
for f in out_dir.glob("ctx_*.json"):
    f.unlink()
size = (len(items) + PARTS - 1) // PARTS
for part in range(PARTS):
    chunk = items[part * size:(part + 1) * size]
    if not chunk:
        continue
    rows, used = [], set()
    for it in chunk:
        en, who = it["en"], it.get("speaker") or ""
        row = {"en": en, "speaker": who}
        if who:
            row["speaker_ua"] = dict(ua_by_en.get(who, {})) or None
            row["speaker_loc"] = loc_by_en.get(who)
            ex = lines_by_speaker.get(who, [])[:5]
            if ex:
                row["speaker_lines"] = ex
        ph = sorted(phrases(en))
        row["names"] = ph
        used |= set(ph)
        rows.append(row)
    names = {}
    for p in sorted(used):
        info = {}
        if ua_by_en.get(p):
            info["npc_ua"] = dict(ua_by_en[p].most_common(4))
            if loc_by_en.get(p):
                info["npc_loc"] = loc_by_en[p]
        if examples.get(p):
            info["examples"] = examples[p]
        if info:
            names[p] = info
    path = out_dir / f"ctx_{part:02d}.json"
    path.write_text(json.dumps(
        {"lines": rows, "names": names, "glossary": glossary},
        ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"  {path.name}: рядків {len(rows)}, назв із доказами {len(names)}, "
          f"{path.stat().st_size // 1024} КБ")
