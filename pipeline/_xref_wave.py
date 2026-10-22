# -*- coding: utf-8 -*-
"""Перехресна звірка будь-якої черги з УСІЄЮ базою.

Збирач знімає рядки з екрана, не знаючи, звідки вони. Тому в чергу трекера
осідають назви квестів, імена NPC, назви предметів — усе те, що вже
перекладено, просто в іншій секції. Перекладати їх удруге — марна робота і
пряме джерело різнобою: один і той самий квест назветься в журналі й у
трекері по-різному.

Обережність із контекстом [[context-scoped-translation]]: беремо переклад
лише тоді, коли ВСІ входження рядка в базі перекладені однаково. Якщо той
самий EN має різні UA в різних вікнах (Back = Спина/Назад), рядок лишається
перекладачеві.

Запуск: python _xref_wave.py <батч-тека> <префікс> [--apply]
   напр. python _xref_wave.py objlines ol --apply
"""
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

SUB = sys.argv[1]
PRE = sys.argv[2]
APPLY = "--apply" in sys.argv
MINLEN = 4  # коротші рядки надто контекстозалежні

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
qsrc = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))

LOW = re.compile(r"\s*\((low level|низький рівень)\)\s*$", re.I)
DONE = re.compile(r"\s*\((Complete|Завершено)\)\s*$", re.I)
# Лічильник цілі АБО маркер списку: трекери рідкісних істот і скарбів
# показують «• Bilefang Mother», а сама назва вже є в npcNames/gameObjects.
# Вікно ремесла пише потребу в реагенті як «*/5 Aetherlume» — зірка означає
# «будь-яка якість». Сама назва реагенту вже перекладена в предметах.
# ПОРЯДОК ВАЖЛИВИЙ: чергування в регексі бере ПЕРШИЙ збіг, не найдовший.
# Поки «[•\-]\s*» стояло першим, у рядку «- 0/1 Chillmaw slain» відкушувалось
# лише «- », тілом лишалося «0/1 Chillmaw slain» — і звірка його не знаходила,
# хоча «Chillmaw slain» у базі є. Тому спершу найдовший варіант.
PREFIX = re.compile(r"^(?:[•\-]\s*[\d*]+\s*/\s*\d+\s+|[\d*]+\s*/\s*\d+\s+|[•\-]\s*)")


def norm(s):
    return re.sub(r"\s+", " ", DONE.sub("", LOW.sub("", s))).strip()


# EN -> {UA, …}: збираємо з усіх секцій, де ключ — англійський рядок
en2ua = defaultdict(set)
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for k, v in d.items():
        if isinstance(k, str) and isinstance(v, str) and re.search(r"[A-Za-z]{3}", k):
            en2ua[norm(k)].add(v)

# назви квестів: ключ у базі — questID, англійська лежить у джерелі
for qid, v in qsrc.items():
    if not isinstance(v, dict):
        continue
    en = (v.get("title") or {}).get("en")
    ua = (tr.get("quests", {}).get(qid) or {}).get("title")
    if en and ua:
        en2ua[norm(en)].add(ua)

# закляття: у базі ключ — spellID, англійська лежить у джерелі. Без цього
# «Crusader Aura» щоразу вважалося новим, хоча переклад є.
try:
    ssrc = json.loads((DATA_DIR / "source" / "spells.json").read_text(encoding="utf-8-sig"))
    ts = tr.get("spells", {})
    for sid, v in ssrc.items():
        if not isinstance(v, dict):
            continue
        en = (v.get("name") or {}).get("en") if isinstance(v.get("name"), dict) else None
        ua = ts.get(str(sid))
        if en and isinstance(ua, str):
            en2ua[norm(en)].add(ua)
except FileNotFoundError:
    pass

# імена NPC: ключ у базі — creatureID
crea = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
tn = tr.get("npcNames", {})
if isinstance(crea, dict):
    for cid, v in crea.items():
        if not isinstance(v, dict):
            continue
        nm = v.get("name") if isinstance(v.get("name"), dict) else v
        en = nm.get("en") if isinstance(nm, dict) else None
        ua = tn.get(str(cid))
        if en and ua:
            en2ua[norm(en)].add(ua)

# ЗІБРАНА база імен: NpcNames.lua — це вже готова карта «англ. -> укр.».
# Без неї звірка сліпа на дві третини: у npcNames 41 421 ID, а в датамайні
# creatures.json лише 23 172, і 19 292 переклади висять на ID, які прийшли
# ЗІ ЗБОРІВ і в датамайні відсутні. Через це хвиля істот 27.08 зняла 77 пар
# замість кількох сотень, і агенти перекладали те, що вже було.
_lua = (DATA_DIR.parent / "addon" / "UALL_NpcNames" / "NpcNames.lua")
if _lua.exists():
    _n = 0
    for m in re.finditer(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"',
                         _lua.read_text(encoding="utf-8")):
        en, ua = m.group(1), m.group(2)
        if en and ua and re.search(r"[A-Za-z]{3}", en):
            en2ua[norm(en.replace('\\"', '"'))].add(ua.replace('\\"', '"'))
            _n += 1
    print(f"  з NpcNames.lua узято пар: {_n}")

BD = DATA_DIR / "batches" / SUB


def suspect(en, ua):
    """Не переносити з бази те, що саме схоже на підміну.

    26.08.2026 цей скрипт узяв із бази зіпсовану пару
    «Vilescar Poacher» -> «Слалом Дикого Заповідника, просунутий: золото»
    і поклав її ще й в ім'я істоти. Тобто підміна не просто лежала в базі,
    а РОЗМНОЖУВАЛАСЯ нашим власним інструментом.

    Доказ той самий, що в `_check_kv_shift.py`: переклад мусить бути
    співмірний з оригіналом. Тут поріг навмисно м'якший (2.6), бо ціна
    помилки різна: пропустити пару — це просто зайва робота перекладачеві,
    а рознести підміну — це нова діра в грі.
    """
    if len(ua) <= 25:
        return False
    return len(ua) > len(en) * 2.6 + 8


# Маска з РІВНО двох цифр губила батчі ol_100+ (препи роблять сотні
# файлів): старі лишалися нечищеними й задвоювали чергу.
files = sorted(BD.glob(f"{PRE}_[0-9]*.json"),
               key=lambda f: int(re.search(r"(\d+)", f.stem).group(1)))
reuse, rest, ambig, skipped = {}, [], [], []
for f in files:
    for s in json.loads(f.read_text(encoding="utf-8")):
        t = s["en"] if isinstance(s, dict) else s
        # тултіпи мапи склеюють лічильник із текстом цілі: «- 0/15 Kobyss
        # slain». Сам текст уже перекладено в questObjectives — відділяємо
        # префікс, шукаємо решту, а лічильник вертаємо на місце незмінним.
        mc = PREFIX.match(t)
        if mc:
            head, body = mc.group(0), t[mc.end():]
            cb = en2ua.get(norm(body))
            if cb and len(body) >= MINLEN:
                ub = {norm(u): u for u in sorted(cb, key=len, reverse=True)}
                if len(ub) == 1:
                    cand_ua = next(iter(ub.values()))
                    if suspect(body, cand_ua):
                        skipped.append((t, cand_ua))
                    else:
                        reuse[t] = head + cand_ua
                        continue
                ambig.append((t, sorted(cb)[:3]))
            rest.append(s)
            continue
        cand = en2ua.get(norm(t))
        if cand and len(t) >= MINLEN:
            # «(низький рівень)» — службовий суфікс клієнта, а не інший
            # переклад: без цього однакові рядки читалися як розбіжність
            # найкоротший варіант присвоюємо ОСТАННІМ, щоб саме він лишився:
            # ключ без «(low level)» не повинен дістати «(низький рівень)»
            uniq = {norm(u): u for u in sorted(cand, key=len, reverse=True)}
            if len(uniq) == 1:
                cand_ua = next(iter(uniq.values()))
                if suspect(t, cand_ua):
                    skipped.append((t, cand_ua))
                else:
                    reuse[t] = cand_ua
                    continue
            ambig.append((t, sorted(cand)[:3]))
        rest.append(s)

print(f"{SUB}: {len(reuse) + len(rest)} | переклад є в базі: {len(reuse)} | "
      f"неоднозначних: {len(ambig)} | справжня робота: {len(rest)}")
for s, ua in list(reuse.items())[:5]:
    print(f"      ✔ {s[:44]:<46}-> {ua[:40]}")
for s, ua in skipped[:8]:
    print(f"      ✖ НЕ переношу (схоже на підміну): {s[:34]!r} -> {ua[:38]!r}")
for s, us in ambig[:5]:
    print(f"      ? {s[:30]:<32}-> {' | '.join(u[:22] for u in us)}")

if not APPLY:
    print("\n(звіт; щоб застосувати — --apply)")
    sys.exit()

(BD / f"out_{PRE}_xref.json").write_text(
    json.dumps(reuse, ensure_ascii=False, indent=1), encoding="utf-8")
size = 15
for f in files:
    f.unlink()
for k in range((len(rest) + size - 1) // size):
    (BD / f"{PRE}_{k:02d}.json").write_text(
        json.dumps(rest[k * size:(k + 1) * size], ensure_ascii=False, indent=1),
        encoding="utf-8")
print(f"\n-> out_{PRE}_xref.json: {len(reuse)} готових пар | "
      f"у черзі лишилось: {len(rest)}")
