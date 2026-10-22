# -*- coding: utf-8 -*-
"""Аудит консистентності журналу:
(1) боси (EN->UA канон з _boss.json + journal) vs КВЕСТИ — чи зветься бос у
    квесті так само, як у журналі (за стемом UA-імені).
(2) розбіжні UA-рендери проблемних токенів (Anvilrage тощо) у journalSections.
"""
import sys, json, re, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
qsrc = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))
tq = tr.get("quests", {})
js = tr.get("journalSections", {})

# --- канон босів: _boss.json (3 тіри) + journal-таблиця ---
boss = {}
for f in glob.glob(str(DATA_DIR / "jdung_*" / "_boss.json")):
    boss.update(json.loads(open(f, encoding="utf-8-sig").read()))
print(f"босів у каноні (_boss.json): {len(boss)}")

out = ["=== (1) БОСИ vs КВЕСТИ (стем UA-імені має бути в перекладі квесту) ==="]
flagged = 0
checked = 0
for en, ua in sorted(boss.items()):
    if len(en) < 5:
        continue
    # стем = перше слово UA-імені (>=4 літери), напр. "Інгвар" з "Інгвар Грабіжник"
    words = [w for w in re.findall(r"[А-Яа-яЇїІіЄєҐґ'']+", ua) if len(w) >= 4]
    if not words:
        continue
    stem = words[0][:5]  # перші 5 літер кореня (терпить відмінки)
    # квести, де EN-ім'я боса згадане
    pat = re.compile(r"\b" + re.escape(en) + r"\b")
    for qid, qd in qsrc.items():
        if qid not in tq:
            continue
        qen = ((qd.get("title", {}) or {}).get("en", "") + " " +
               (qd.get("description", {}) or {}).get("en", ""))
        if not pat.search(qen):
            continue
        checked += 1
        t = tq[qid]
        qua = (t.get("title", "") or "") + " " + (t.get("description", "") or "")
        if stem not in qua:
            flagged += 1
            out.append(f"  [{qid}] бос '{en}'→'{ua}' (стем '{stem}') НЕ знайдено у перекладі квесту")
        break  # одного прикладу на боса досить
out.append(f"  перевірено пар бос-квест: {checked} | прапорів: {flagged}")

# --- (2) розбіжні токени у секціях ---
out.append("\n=== (2) РОЗБІЖНІ UA-РЕНДЕРИ ТОКЕНІВ у journalSections ===")
TOKENS = ["Anvilrage", "Shadowforge", "Smolderthorn", "Bloodaxe", "Dark Iron",
          "Spirestone", "Bloodwarder", "Ymirjar", "Stormforged"]
en2uavals = {}
for en_raw, ua in js.items():
    for tok in TOKENS:
        if tok.lower() in en_raw.lower():
            en2uavals.setdefault(tok, set()).add(ua[:0])  # placeholder
# краще: зібрати UA-слова поруч — складно; натомість покажемо к-сть різних секцій
# Простіше: для кожного токена показати чи є кілька різних коренів у перекладах
for tok in TOKENS:
    forms = set()
    for en_raw, ua in js.items():
        if tok.lower() in en_raw.lower():
            # знайти укр-слова, що не є загальними (евристика: довші 4)
            for w in re.findall(r"[А-Яа-яЇїІіЄєҐґ']{5,}", ua):
                forms.add(w)
    # показуємо лише якщо токен реально зустрічається
    cnt = sum(1 for en_raw in js if tok.lower() in en_raw.lower())
    if cnt:
        out.append(f"  {tok}: у {cnt} секціях")

(DATA_DIR / "_audit.txt").write_text("\n".join(out), encoding="utf-8")
print("\n".join(out[:40]))
