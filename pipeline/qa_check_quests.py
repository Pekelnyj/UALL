# -*- coding: utf-8 -*-
# QA-чекер перекладу квестів: шукає русизми, чужі літери, неперекладене, рідкісні слова.
# Прогін по всій базі:        python pipeline/qa_check_quests.py
# Прогін по виходу хвилі:      python pipeline/qa_check_quests.py wave
# Пише data/_qa_quests.json (кандидати на ручний фікс) + друкує лічбу й приклади.
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"
mode = sys.argv[1] if len(sys.argv) > 1 else "base"

# чужі літери (укр. не має ы ъ э ё)
FOREIGN = re.compile("[ыъэёЫЪЭЁ]")

# ВИСОКОВПЕВНЕНІ русизми/кальки (рідкісні в правильній укр.). \b де треба.
RUS = [
    (re.compile("\\bпоможи", re.I), "поможи→допоможи"),
    (re.compile("\\bпоможе", re.I), "поможе→допоможе"),
    (re.compile("\\bпоможу", re.I), "поможу→допоможу"),
    (re.compile("на протязі", re.I), "на протязі→протягом"),
    (re.compile("\\bслідуюч", re.I), "слідуючий→наступний"),
    (re.compile("приймати участь|прийняти участь|приймають участь", re.I), "брати участь"),
    (re.compile("співпада", re.I), "співпадати→збігатися"),
    (re.compile("більш краще", re.I), "більш краще"),
    (re.compile("у якості\\b", re.I), "у якості→як"),
    (re.compile("не дивлячись на", re.I), "не дивлячись→незважаючи"),
    (re.compile("\\bвключа[єют]", re.I), "включати→вмикати/охоплювати"),
    (re.compile("\\bвідмінити\\b|\\bвідмінено\\b", re.I), "відмінити→скасувати"),
    # -уючий ЛИШЕ як прикметник (-уючий/-уюча/-уюче/-уючі...), НЕ дієприслівник (-уючи)
    (re.compile("уюч(ий|а|е|их|им|ою|ому|і|у|ого)\\b", re.I), "-уючий-прикм (уникати)"),
    (re.compile("\\bпровіря", re.I), "провіряти→перевіряти"),
]

# рідкісні/заборонені (з історії правок)
# тварюк прибрано — користувач підтвердив, що «тварюка» прийнятна (колоритне укр. слово)
BANNED = re.compile("румак|маніяк|прудкіст|курдупел|запределл|порожнеч'ю|"
                    "грязь|спотворений часом", re.I)

def has_cyr(s): return bool(re.search("[Ѐ-ӿ]", s or ""))
def has_lat(s): return bool(re.search("[A-Za-z]", s or ""))

def check(text):
    flags = []
    if not isinstance(text, str) or not text.strip():
        return flags
    if FOREIGN.search(text):
        flags.append("ЧУЖІ-ЛІТЕРИ")
    for rx, lbl in RUS:
        if rx.search(text):
            flags.append("РУСИЗМ:" + lbl)
    if BANNED.search(text):
        flags.append("ЗАБОРОНЕНЕ:" + BANNED.search(text).group(0))
    # неперекладене: має латиницю, але кирилиці зовсім нема (і це не код/тег)
    if has_lat(text) and not has_cyr(text) and len(text) > 3 \
       and not re.search(r"\[DNT\]|\[PH\]|\bDNT\b|Mk|\d", text):
        flags.append("НЕ-ПЕРЕКЛАДЕНО")
    return flags

# джерело перевірки
if mode == "wave":
    items = {}
    for f in (DATA / "quest_out_new").glob("*.json"):
        for qid, fields in json.loads(f.read_text(encoding="utf-8-sig")).items():
            if isinstance(fields, dict):
                items[qid] = fields
else:
    items = json.loads((DATA / "translations.json").read_text(encoding="utf-8-sig")).get("quests", {})

cand = {}
counts = {}
for qid, fields in items.items():
    if not isinstance(fields, dict): continue
    for fld in ("title", "description"):
        v = fields.get(fld)
        fl = check(v)
        if fl:
            cand.setdefault(qid, {})[fld] = {"ua": v, "flags": fl}
            for f in fl:
                key = f.split(":")[0]
                counts[key] = counts.get(key, 0) + 1

(DATA / "_qa_quests.json").write_text(json.dumps(cand, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Режим: {mode} | перевірено квестів: {len(items)} | проблемних: {len(cand)}")
for k, v in sorted(counts.items(), key=lambda x: -x[1]):
    print(f"  {k}: {v}")
# приклади
print("\n=== приклади (до 15) ===")
shown = 0
for qid, fields in cand.items():
    for fld, d in fields.items():
        print(f"  [{qid}.{fld}] {d['flags']}  «{(d['ua'] or '')[:60]}»")
        shown += 1
        if shown >= 15: break
    if shown >= 15: break
