# -*- coding: utf-8 -*-
"""Інвентаризація форм власної назви ПО ВСІЙ базі, включно з прозою.

`canon_build.py` збирає форми лише з називних джерел (taxiNodes, areaPOI,
subnames, factions) — там назва стоїть у називному й порівнюється надійно.
Але більшість різнобою живе в ПРОЗІ: у тілі завдання назва відмінюється,
і саме там «Ліс Срібної Сосни» мирно співіснує зі «Срібноліссям».

Тому тут два кроки:
  1. КАНДИДАТИ — усі українські значення, що стоять під точним англійським
     ключем (або під ID істоти з таким EN). Це нормалізовані форми.
  2. ВАГА — скільки разів корінь кожного кандидата трапляється в УСІХ
     українських текстах бази. Корінь, а не слово: «Срібноліссі» й
     «Срібнолісся» — та сама форма, «Сільверпайн» — інша.

Вага показує, що гравець бачить частіше, і тільки вона дає право назвати
форму домінантою. Де рахунок близький — вирішує людина, не скрипт
[[korthian-adjective-canon]].

Запуск:
    python _name_forms.py "Silverpine Forest" "Desolace" ...
    python _name_forms.py --conflicts        # усі різнобої з canon_build
"""
import json
import re
import sys
from collections import Counter, defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

ROOT = 6          # довжина кореня для згортання відмінків
MIN_ROOT = 4      # коротші корені дають хибні влучання

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))


def ua_of(v):
    if isinstance(v, str):
        return v
    if isinstance(v, dict):
        for f in ("name", "title", "text", "ua", "value", "description"):
            x = v.get(f)
            if isinstance(x, str) and x.strip():
                return x
    return ""


def aligned_pairs():
    """Пари (секція, англійський текст, український) — тільки вирівняні.

    Рахувати частоту форми по ВСІЙ базі не можна: «Кровожер» трапляється й
    там, де жодного Gorefiend немає, і дає йому сотні вигаданих вживань.
    Питання ж інше — «скільки разів САМЕ ЦЮ англійську назву передали САМЕ
    ЦІЄЮ формою», а на нього відповідають лише пари, де видно обидва боки.

    Два роди джерел: секції з ключем-англійським-рядком (ключ і є оригінал)
    та секції з ключем-ID, де англійську беремо з data/source
    [[sv-bucket-vs-section-key]].
    """
    for sec, d in tr.items():
        if not isinstance(d, dict):
            continue
        for k, v in d.items():
            if not isinstance(k, str) or k.isdigit():
                continue
            u = ua_of(v)
            if u:
                yield sec, k, u

    ID_SRC = [("quests", "quests.json", ("title", "description")),
              ("npcNames", "creatures.json", ("name",)),
              ("itemNames", "items.json", ("name",)),
              ("spells", "spells.json", ("name",)),
              ("achievements", "achievements.json", ("title", "desc"))]
    for sec, src, fields in ID_SRC:
        p = DATA_DIR / "source" / src
        if not p.exists():
            continue
        d = json.loads(p.read_text(encoding="utf-8-sig"))
        t = tr.get(sec) or {}
        for k, v in d.items():
            uv = t.get(str(k))
            if not isinstance(uv, (dict, str)):
                continue
            for f in fields:
                en = v.get(f) if isinstance(v, dict) else None
                en = en.get("en") if isinstance(en, dict) else en
                ua = uv.get(f) if isinstance(uv, dict) else uv
                if isinstance(en, str) and isinstance(ua, str) and en and ua:
                    yield sec, en, ua


def candidates(en):
    """UA-значення, що стоять під точним англійським ключем."""
    out = defaultdict(list)
    for sec, d in tr.items():
        if not isinstance(d, dict):
            continue
        v = d.get(en)
        u = ua_of(v) if v is not None else ""
        if u:
            out[u].append(sec)
    return out


def id_anchored(en):
    """Те саме, але для секцій із ключем-ID: EN береться з джерела."""
    out = defaultdict(list)
    for sec, src, fld in (("npcNames", "creatures.json", "name"),
                          ("spells", "spells.json", "name"),
                          ("achievements", "achievements.json", "title")):
        p = DATA_DIR / "source" / src
        if not p.exists():
            continue
        d = json.loads(p.read_text(encoding="utf-8-sig"))
        t = tr.get(sec) or {}
        for k, v in d.items():
            nm = v.get(fld) if isinstance(v, dict) else None
            e = nm.get("en") if isinstance(nm, dict) else None
            if e != en:
                continue
            u = ua_of(t.get(str(k)))
            if u:
                out[u].append(f"{sec}#{k}")
    return out


UAW = re.compile(r"[А-ЯІЇЄҐа-яіїєґ'’][А-ЯІЇЄҐа-яіїєґ'’-]{2,}")


def form_regex(form):
    """Форма ЦІЛКОМ, з гнучким закінченням кожного слова.

    Рахувати обрізаним коренем не можна: при 6 літерах «Срібнолісся»,
    «Срібнососновий» і «Срібнохвойний» дають один корінь «срібно» й
    однакову вагу — цифри стають артефактом, а не даними. Тому кожне слово
    йде своєю основою (мінус відмінкове закінчення) плюс короткий хвіст, а
    слова з'єднуються пробілами.

    Хвіст саме {0,3}, а не необмежений: з відкритим хвостом основа «Кровож»
    ловила звичайні «кровожерливий» і «кровожерна» й дала Ґорфієндові 598
    вигаданих вживань. Три літери — це відмінкове закінчення, далі вже
    словотвір, тобто інше слово.
    """
    parts = []
    for w in UAW.findall(form):
        stem = w[:-2] if len(w) > 5 else w
        parts.append(re.escape(stem) + r"\w{0,3}\b")
    if not parts:
        return None
    return re.compile(r"\s+".join(parts), re.I)


argv = sys.argv[1:]
# Форми, задані вручну. Потрібні тому, що автопошук бачить назву лише під
# ТОЧНИМ англійським ключем, а в таксі ключ — «Nijel's Point, Desolace»:
# зона сидить усередині, і «Десолейс» автопошуку невидимий.
manual = []
if "--forms" in argv:
    i = argv.index("--forms")
    manual = [s.strip() for s in argv[i + 1].split(",") if s.strip()]
    del argv[i:i + 2]

names = [a for a in argv if not a.startswith("--")]
if not names:
    print("вкажи англійські назви: python _name_forms.py \"Silverpine Forest\"")
    sys.exit(2)

# Зібрати кандидатів
plan = {}
for en in names:
    forms = candidates(en)
    for u, secs in id_anchored(en).items():
        forms[u].extend(secs)
    for m in manual:
        forms.setdefault(m, []).append("вручну")
    plan[en] = forms

pats = {}
for en, forms in plan.items():
    for u in forms:
        r = form_regex(u)
        if r:
            pats[(en, u)] = r
if not pats:
    print("жодного кандидата: назви немає під точним ключем, задай --forms")
    sys.exit(1)

corpus = list(aligned_pairs())
print(f"вирівняних пар: {len(corpus)} | форм під обміром: {len(pats)}")
# Дешевий відсів: 563 тис. рядків на кожну форму — це десятки мільйонів
# запусків регексу. Спершу звичайний пошук підрядка за основою першого
# слова; регекс запускаємо лише там, де основа взагалі трапилась.
lits = {}
for key, _pat in pats.items():
    w = UAW.findall(key[1])
    lits[key] = (w[0][:-2] if len(w[0]) > 5 else w[0]).lower() if w else ""

weight = Counter()
where = defaultdict(Counter)
seen_en = Counter()
low_names = {en: en.lower() for en in plan}
for sec, en_text, ua_text in corpus:
    en_low = en_text.lower()
    hit_names = [en for en, nl in low_names.items() if nl in en_low]
    if not hit_names:
        continue
    for en in hit_names:
        seen_en[en] += 1
    ua_low = ua_text.lower()
    for key, pat in pats.items():
        if key[0] not in hit_names:
            continue
        lit = lits[key]
        if lit and lit not in ua_low:
            continue
        if pat.search(ua_text):
            weight[key] += 1
            where[key][sec] += 1

for en, forms in plan.items():
    print(f"\n=== {en} ===")
    rows = sorted(((weight[(en, u)], u, sorted(set(secs)))
                   for u, secs in forms.items()), reverse=True)
    total = sum(r[0] for r in rows) or 1
    for w, u, secs in rows:
        top = ", ".join(f"{s}:{c}" for s, c in where[(en, u)].most_common(3))
        print(f"   {w:>5}  {u:<34} {100 * w / total:>4.0f}%  [{', '.join(secs[:3])}]")
        if top:
            print(f"          де саме: {top}")
    if len(rows) > 1:
        lead, second = rows[0][0], rows[1][0]
        verdict = ("ДОМІНАНТА ЯСНА" if lead >= second * 2
                   else "БЛИЗЬКО — потрібен вирок людини")
        print(f"   -> {verdict} ({lead} проти {second})")
