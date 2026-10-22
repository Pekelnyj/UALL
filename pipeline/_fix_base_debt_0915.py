# -*- coding: utf-8 -*-
"""П'ять боргів бази, що виплили на хвилі імен NPC (15.09), — одним проходом.

Кожна правка прив'язана до АНГЛІЙСЬКОГО ЯКОРЯ запису (ключ-рядок або EN істоти
за ID), а не до українського підрядка [[verify-names-by-id-anchor]]:
перейменування терміна розповзається по секціях, і сліпий своп ламає сторонні
рядки й рід [[term-rename-spread-and-gender]].

1) «потрошитель» — русизм (58 форм у 8 секціях). Глосарій: ripper = розривач.
   Ripper -> розривач; Eviscerator / Gutter / Disemboweler / Gutwrencher -> патрач.
   Відмінки за парадигмою -ач (розривача, патрачем…), жіночий -ка.
   «Черепокрушитель» (Loa-Gutter Skullcrusher) — та сама вада -итель ->
   «черепотрощ», через дефіс, як у решти родини «Лоапатрач-різник».
2) Німецькі «англійські» назви в creatures.json (15; для 13 є справжня
   англійська в api_creatures_full) — плашка в англійській грі мертва.
3) Fungarian — 8 форм. Парадигма іменників на -анин (як селянин): фунґаріани,
   РОДОВИЙ МНОЖИНИ «фунґаріан» (не «фунґаріанів»), фунґаріанам…; прикметник
   «фунґаріанський»; ґ за глосарієм («селище Фунґара»).
4) Fel Reaver — «Спустошувач Скверни» (домінанта 17 проти «Жнець» 6,
   «Скверноплюндрувач» 2, «жнивар» 2).
5) Flickerflame — назва клану кобольдів, Title Case: «Мерехтливого Вогню»
   (7 плашок з малої + «мерехтливого полум'я» в цілі).

broadcast — майстер у Broadcast.lua, тому його зміни йдуть окремим JSON у
_update_broadcast_values.py [[never-regex-edit-broadcast-lua]].

Запуск: python _fix_base_debt_0915.py [--apply]
Далі:   python _update_broadcast_values.py data/tester_new/debt0915_broadcast.json
        python _sync_broadcast_master.py && python generate_db.py
"""
import io
import json
import re
import sys
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
C = DATA_DIR / "source" / "creatures.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
cr = json.loads(C.read_text(encoding="utf-8-sig"))
try:
    acf = json.loads((DATA_DIR / "source" / "api_creatures_full.json").read_text(encoding="utf-8-sig"))
except OSError:
    acf = {}
qs = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))
en_of = {c: ((v.get("name") or {}).get("en")) for c, v in cr.items() if isinstance(v, dict)}

# --- 2) німецькі EN -----------------------------------------------------------
import capfilter  # noqa: E402

ger_fix = []
for c, en in list(en_of.items()):
    if en and capfilter.is_foreign(en):
        a = acf.get(c)
        n = a.get("name") if isinstance(a, dict) else None
        real = n.get("en") if isinstance(n, dict) else (n if isinstance(n, str) else None)
        if real and not capfilter.is_foreign(real):
            ger_fix.append((c, en, real))
            en_of[c] = real            # далі якорі рахуємо вже за справжньою назвою

# --- 1) потрошитель -----------------------------------------------------------
END = {"ь": "", "я": "а", "ю": "у", "еві": "еві", "ем": "ем", "і": "і", "ів": "ів",
       "ям": "ам", "ями": "ами", "ях": "ах",
       "ька": "ка", "ьки": "ки", "ьці": "ці", "ьку": "ку", "ькою": "кою", "ьок": "ок", "ько": "ко"}
ENDS = "|".join(sorted(END, key=len, reverse=True))
POT = re.compile(r"(?P<pre>[А-Яа-яІіЇїЄєҐґ'’]*?)(?P<p>[Пп])отрошител(?P<e>" + ENDS + r")(?![А-Яа-яІіЇїЄєҐґ])")
SKULL = re.compile(r"[Чч]ерепокрушител(?P<e>" + ENDS + r")(?![А-Яа-яІіЇїЄєҐґ])")
RIPPER_QUESTS = {"9770"}                        # «marshfang rippers» в описі


def fix_pot(s, ripper):
    def rep(m):
        stem = "розривач" if ripper else "патрач"
        if m.group("p") == "П" and not m.group("pre"):
            stem = stem.capitalize()
        return m.group("pre") + stem + END[m.group("e")]
    s = POT.sub(rep, s)
    # регістр зберігаємо: у назвах предметів Title Case («Черепотрощ Нокхудів»)
    s = SKULL.sub(lambda m: ("Черепотрощ" if m.group(0)[0] == "Ч" else "черепотрощ")
                  + END[m.group("e")], s)
    # родина Loa-Gutter пишеться через дефіс і з малої: «Лоапатрач-різник»
    s = re.sub(r"(Лоапатрач\w*)\s+[Чч](ерепотрощ\w*)", r"\1-ч\2", s)
    return s


# --- 3) Fungarian -------------------------------------------------------------
def fix_fung(s):
    s = re.sub(r"(?<![А-Яа-яІіЇїЄєҐґ])([Фф])ун[гґ](?:ійськ|арськ)(?=[А-Яа-яІіЇїЄєҐґ])", r"\1унґаріанськ", s)
    s = re.sub(r"(?<![А-Яа-яІіЇїЄєҐґ])([Фф])унгаріан", r"\1унґаріан", s)
    s = re.sub(r"(?<![А-Яа-яІіЇїЄєҐґ])([Фф])ун[гґ](?:аріанц|арц)(і|ів|ям|ями|ях)(?![А-Яа-яІіЇїЄєҐґ])",
               lambda m: m.group(1) + "унґаріан" + {"і": "и", "ів": "", "ям": "ам",
                                                    "ями": "ами", "ях": "ах"}[m.group(2)], s)
    s = re.sub(r"(?<![А-Яа-яІіЇїЄєҐґ])([Фф])унґаріанів(?![А-Яа-яІіЇїЄєҐґ])", r"\1унґаріан", s)
    return s


# --- 4) Fel Reaver ------------------------------------------------------------
def fix_reaver(s):
    def cap(first, word):
        return word.capitalize() if first.isupper() else word
    s = re.sub(r"([Жж])нець Скверни", lambda m: cap(m.group(1), "спустошувач") + " Скверни", s)
    s = re.sub(r"([Жж])неця Скверни", lambda m: cap(m.group(1), "спустошувача") + " Скверни", s)
    s = re.sub(r"([Жж])нецеві Скверни|([Жж])нецю Скверни",
               lambda m: cap((m.group(1) or m.group(2)), "спустошувачеві") + " Скверни", s)
    s = re.sub(r"([Жж])неців Скверни", lambda m: cap(m.group(1), "спустошувачів") + " Скверни", s)
    s = re.sub(r"([Жж])ниваря Скверни", lambda m: cap(m.group(1), "спустошувача") + " Скверни", s)
    s = re.sub(r"Скверноплюндрувач(а|ів|і|ем|у|еві)?(?![А-Яа-яІіЇїЄєҐґ])",
               lambda m: "Спустошувач" + (m.group(1) or "") + " Скверни", s)
    return s


# --- 5) Flickerflame ----------------------------------------------------------
def fix_flicker(s):
    return re.sub(r"[Мм]ерехтливого\s+(?:[Вв]огню|[Пп]олум'я|[Пп]олум’я)", "Мерехтливого Вогню", s)


def anchor(sec, k, field):
    if sec == "npcNames":
        return en_of.get(str(k)) or ""
    if sec == "quests":
        q = qs.get(str(k)) or {}
        f = q.get(field)
        return (f.get("en") if isinstance(f, dict) else "") or ""
    return k if isinstance(k, str) else ""


changes, bc_updates = [], {}
stat = Counter()


def process(sec, k, field, s):
    a = anchor(sec, k, field)
    al = a.lower()
    new = s
    if POT.search(new) or SKULL.search(new):
        ripper = "ripper" in al or (sec == "quests" and str(k) in RIPPER_QUESTS)
        new = fix_pot(new, ripper)
        stat["1 потрошитель"] += 1
    if "fungarian" in al:
        n2 = fix_fung(new)
        if n2 != new:
            stat["3 fungarian"] += 1
        new = n2
    if "fel reaver" in al:
        n2 = fix_reaver(new)
        if n2 != new:
            stat["4 fel reaver"] += 1
        new = n2
    if "flickerflame" in al:
        n2 = fix_flicker(new)
        if n2 != new:
            stat["5 flickerflame"] += 1
        new = n2
    return new


for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for k, v in list(d.items()):
        if isinstance(v, str):
            new = process(sec, k, None, v)
            if new != v:
                changes.append((sec, k, None, v, new))
                if sec == "broadcast":
                    bc_updates[k] = new
                elif APPLY:
                    d[k] = new
        elif isinstance(v, dict):
            for f, s in list(v.items()):
                if isinstance(s, str):
                    new = process(sec, k, f, s)
                    if new != s:
                        changes.append((sec, k, f, s, new))
                        if APPLY:
                            v[f] = new

print(f"2) німецькі EN до виправлення: {len(ger_fix)}")
for c, en, real in ger_fix:
    print(f"   {c}: {en} -> {real}")
print(f"\nзмінено записів: {len(changes)} | за пунктами: {dict(stat)} | з них broadcast: {len(bc_updates)}")
for sec, k, f, old, new in changes:
    # показуємо лише змінений фрагмент
    i = next((j for j, (x, y) in enumerate(zip(old, new)) if x != y), 0)
    print(f"[{sec}] {str(k)[:38]}{'/' + f if f else ''}\n   - {old[max(0, i - 30):i + 60]}\n   + {new[max(0, i - 30):i + 60]}")

# залишки після правки — має бути порожньо
left = []
for sec, d in tr.items():
    if isinstance(d, dict):
        for k, v in d.items():
            vals = [v] if isinstance(v, str) else (list(v.values()) if isinstance(v, dict) else [])
            for s in vals:
                if isinstance(s, str) and s in {c[3] for c in changes}:
                    continue
                if isinstance(s, str) and re.search(r"отрошител|ерепокрушител", s):
                    left.append((sec, str(k)[:40], s[:80]))
print(f"\nзалишки «потрошитель/черепокрушитель» поза зміненими: {len(left)}")
for x in left[:10]:
    print("   ", x)

if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
for c, _en, real in ger_fix:
    cr[c]["name"]["en"] = real
io.open(C, "w", encoding="utf-8", newline="\n").write(json.dumps(cr, ensure_ascii=False, indent=2))
io.open(P, "w", encoding="utf-8", newline="\n").write(json.dumps(tr, ensure_ascii=False, indent=1))
out = DATA_DIR / "tester_new" / "debt0915_broadcast.json"
out.write_text(json.dumps(bc_updates, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"\ntranslations.json і creatures.json записано; broadcast -> {out}")
