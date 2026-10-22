# -*- coding: utf-8 -*-
"""Черга імен NPC разом із ПАКЕТОМ ДОКАЗІВ (як _prep_bc_context.py для реплік).

Для перекладу імені агентові потрібні не словники, а УЗГОДЖЕНІСТЬ із базою:
«Flickerflame Candlekeeper» має звучати так само, як уже перекладені
«Flickerflame Kobold» і «Flickerflame Waxcaster»; «Ruven the Exterminator» —
як у репліках, де його вже назвали. Раніше агент грепав це сам, по кожному слову.

Для кожного імені з черги (data/batches/creatures/batch_*.json):
  de/fr         — локалізації з creatures.json, якщо є (рід, зміст титулу);
  word_examples — для кожного слова назви: до 4 уже перекладених імен NPC,
                  що містять це слово («EN -> UA»), і скільки таких загалом;
  text_mentions — до 3 рядків бази (репліки, балачки, цілі), де це ім'я вже
                  згадано, з перекладом — там видно усталену форму.

Не бере: вже перекладені ID (їх розносить окремий крок), службові ([DNT],
Kill Credit, тригери) і ніки гравців.

Запуск: python _prep_npc_context.py [--parts 2]
Вихід:  data/batches/creatures/nctx_NN.json
Злиття: merge_creature_names.py читає out_*.json у форматі {id: ua}.
"""
import glob
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import known_nicks

PARTS = int(sys.argv[sys.argv.index("--parts") + 1]) if "--parts" in sys.argv else 2
B = DATA_DIR / "batches" / "creatures"
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
cr = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
npc = tr.get("npcNames") or {}

queue = []
for f in sorted(glob.glob(str(B / "batch_*.json"))):
    queue += json.loads(open(f, encoding="utf-8").read())

JUNK = re.compile(r"\[DNT\]|\bDNT\b|\[PH\]|Kill Credit|\bTrigger\b|\bBunny\b", re.I)
nicks = known_nicks(min_len=4)
# Ім'я гравця — ЗАВЖДИ одне слово, тож голий нік відсіюємо точним збігом, а
# всередині назви — лише присвійну форму («<Нік>'s Corpse»). Старе «нік будь-де»
# викидало з черги справжніх NPC («Duke Vielle», «Provisioner Klaus»), бо ті
# слова хтось колись узяв за нік [[guild-names-never-translate]].
NICK_OWN = re.compile(r"\b(" + "|".join(re.escape(n) for n in sorted(nicks, key=len, reverse=True))
                      + r")['’]s\b")
items = [it for it in queue
         if str(it["id"]) not in npc and not JUNK.search(it["en"])
         and it["en"] not in nicks and not NICK_OWN.search(it["en"])]
print(f"у черзі: {len(queue)} | до перекладу: {len(items)}")

# перекладені імена: EN -> UA (одна форма на EN — найчастіша)
pairs = defaultdict(lambda: defaultdict(int))
for cid, ua in npc.items():
    en = ((cr.get(cid) or {}).get("name") or {}).get("en")
    if en and isinstance(ua, str):
        pairs[en][ua] += 1
named = {en: max(v.items(), key=lambda x: x[1])[0] for en, v in pairs.items()}

STOP = {"the", "of", "and", "a", "an", "to", "in", "on", "from", "as", "de"}


def words(en):
    return [w for w in re.findall(r"[A-Za-z][\w'’-]*", en) if w.lower() not in STOP and len(w) >= 3]


wanted = set()
for it in items:
    wanted |= set(words(it["en"]))
word_ex = defaultdict(list)
word_n = defaultdict(int)
WRX = {w: re.compile(r"(?<![\w'’-])" + re.escape(w) + r"(?![\w'’-])") for w in wanted}
for en, ua in named.items():
    for w in set(words(en)) & wanted:
        if WRX[w].search(en):
            word_n[w] += 1
            if len(word_ex[w]) < 4:
                word_ex[w].append(f"{en} -> {ua}")

# згадки повних імен у текстах бази
full = {it["en"] for it in items if len(it["en"]) >= 4}
BIG = re.compile("|".join(sorted((re.escape(n) for n in full), key=len, reverse=True))) if full else None
mentions = defaultdict(list)
CYR = re.compile(r"[А-Яа-яІіЇїЄєҐґ]")
if BIG:
    for sec in ("broadcast", "gossip", "questObjectives", "quests", "journalSections",
                "bossAbilities", "uiTooltips", "achievements"):
        d = tr.get(sec) or {}
        for k, v in d.items():
            texts = []
            if isinstance(v, str):
                texts = [(k, v)]
            elif isinstance(v, dict):          # квести: {title, description, ...}
                continue
            for kk, vv in texts:
                if not isinstance(kk, str) or len(kk) > 300 or not CYR.search(vv):
                    continue
                for m in BIG.finditer(kk):
                    n = m.group(0)
                    if len(mentions[n]) < 3:
                        mentions[n].append([kk[:200], vv[:200]])

rows = []
for it in items:
    row = {"id": str(it["id"]), "en": it["en"]}
    if it.get("de") or it.get("fr"):
        row["de"], row["fr"] = it.get("de", ""), it.get("fr", "")
    ex = {w: {"n": word_n[w], "examples": word_ex[w]} for w in words(it["en"]) if word_ex.get(w)}
    if ex:
        row["word_examples"] = ex
    if mentions.get(it["en"]):
        row["text_mentions"] = mentions[it["en"]]
    rows.append(row)

for f in B.glob("nctx_*.json"):
    f.unlink()
size = (len(rows) + PARTS - 1) // PARTS
for p in range(PARTS):
    chunk = rows[p * size:(p + 1) * size]
    if not chunk:
        continue
    path = B / f"nctx_{p:02d}.json"
    path.write_text(json.dumps(chunk, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"  {path.name}: {len(chunk)} імен, зі словами-доказами "
          f"{sum(1 for r in chunk if 'word_examples' in r)}, зі згадками в текстах "
          f"{sum(1 for r in chunk if 'text_mentions' in r)}, {path.stat().st_size // 1024} КБ")
