# -*- coding: utf-8 -*-
"""Уточнений аудит: РЕАЛЬНА розбіжність бос-квест = EN-ім'я є в квесті, але
ЖОДНЕ значуще слово UA-імені (поза титулами) не зустрічається в перекладі квесту.
+ фактичні UA-форми токена Anvilrage у секціях."""
import sys, json, re, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
qsrc = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))
tq = tr.get("quests", {})
js = tr.get("journalSections", {})

boss = {}
for f in glob.glob(str(DATA_DIR / "jdung_*" / "_boss.json")):
    boss.update(json.loads(open(f, encoding="utf-8-sig").read()))

TITLES = {"лорд", "король", "королева", "капітан", "командир", "барон", "баронеса",
          "генерал", "вождь", "великий", "майстер", "войовник", "полководиця",
          "хранитель", "темний", "лавовий", "гідромантка", "мекґенієр", "мехінженер",
          "володар", "прозорець", "магістр", "екзарх", "ловець", "жнець", "вартовий",
          "війни", "принц", "принцеса", "посол", "верховний", "верховна", "нексус",
          "знахар", "піромант", "інструктор", "леді", "матір", "пророк", "діва",
          "старійшина", "герольд", "велика", "магиня", "імператор"}

out = ["=== РЕАЛЬНІ розбіжності бос-квест (жодне слово імені не збігається) ==="]
real = 0
for en, ua in sorted(boss.items()):
    if len(en) < 5:
        continue
    words = [w for w in re.findall(r"[А-Яа-яЇїІіЄєҐґ']+", ua)
             if len(w) >= 4 and w.lower() not in TITLES]
    if not words:
        continue
    stems = [w[:5] for w in words]
    pat = re.compile(r"\b" + re.escape(en) + r"\b")
    for qid, qd in qsrc.items():
        if qid not in tq:
            continue
        qen = ((qd.get("title", {}) or {}).get("en", "") + " " +
               (qd.get("description", {}) or {}).get("en", ""))
        if not pat.search(qen):
            continue
        t = tq[qid]
        qua = (t.get("title", "") or "") + " " + (t.get("description", "") or "")
        if not any(s in qua for s in stems):
            real += 1
            # показати, як квест зве боса (контекст навколо)
            out.append(f"  [{qid}] журнал '{ua}' (EN {en}) — у квесті значущого слова НЕМА")
        break
out.append(f"  РЕАЛЬНИХ прапорів: {real}")

# Anvilrage форми
out.append("\n=== Anvilrage у секціях — фактичні UA-форми ===")
for en_raw, ua in js.items():
    if "anvilrage" in en_raw.lower():
        m = re.findall(r"[А-Яа-яЇїІіЄєҐґ'-]{5,}", ua)
        # показати слова з коренем гнів/ковад/тінь
        rel = [w for w in m if any(r in w.lower() for r in ("гнів", "ковад", "тінь", "тінек", "анвіл"))]
        if rel:
            out.append(f"  {rel}")

(DATA_DIR / "_audit2.txt").write_text("\n".join(out), encoding="utf-8")
print("\n".join(out))
