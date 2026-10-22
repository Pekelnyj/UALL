# -*- coding: utf-8 -*-
"""Гілки, що суперечать САМІ СОБІ: одне ім'я — кілька українських форм.

Гравець читає гілку поспіль: назва гілки, назва завдання, ціль у трекері,
тіло завдання. Якщо в цих чотирьох місцях той самий персонаж зветься
по-різному, він шукає в грі те, чого під такою назвою немає. Різні хвилі
перекладали ці шари різного часу, тож база суперечить сама собі частіше,
ніж помиляється окремий перекладач [[base-contradicts-itself-across-layers]].

Як шукаємо, не вгадуючи:
  1. з бази беремо ВСІ українські втілення кожного англійського імені —
     лише там, де ім'я стоїть під ТОЧНИМ англійським ключем (npcNames,
     questObjectives, taxiNodes тощо). Це надійні кандидати;
  2. для кожної гілки збираємо український текст усіх її завдань;
  3. якщо в межах ОДНІЄЇ гілки трапляються дві різні форми одного імені —
     це доказ, а не підозра.

Форму шукаємо цілим словом з коротким відмінковим хвостом ({0,3}): з
відкритим хвостом основа «Кровож» ловить звичайне «кровожерливий».

-> data/batches/qlnorm/qn_NN.json
Запуск: python _prep_questline_norm.py [розмір_батча] [--report]
"""
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

SIZE = int(sys.argv[1]) if len(sys.argv) > 1 and sys.argv[1].isdigit() else 12
REPORT = "--report" in sys.argv
# --top N: узяти N НАЙБІЛЬШИХ гілок незалежно від того, чи знайшов детектор
# конфлікт. Детектор доводить лише те, що видно за точними ключами; різнобій,
# який живе тільки в прозі, він не бачить — а редактор бачить. Тому для
# вичитки беремо гілки за обсягом, а не за підозрою.
TOP = 0
if "--top" in sys.argv:
    TOP = int(sys.argv[sys.argv.index("--top") + 1])

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
ql = json.loads((DATA_DIR / "questlines.json").read_text(encoding="utf-8-sig"))
qsrc = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))
tq = tr.get("quests", {})

STOP = {
    "The", "And", "Of", "In", "To", "For", "From", "With", "Into", "Upon",
    "A", "An", "At", "On", "By", "Is", "Are", "Be", "Not", "All", "You",
    "New", "Old", "Great", "Last", "First", "Lost", "Dark", "Light", "This",
    "War", "Battle", "Siege", "Rise", "Fall", "End", "Return", "Your", "It",
    "Quest", "Chapter", "Part", "One", "Two", "Three", "Now", "But", "That",
    "What", "When", "Where", "Who", "How", "Why", "We", "They", "Their",
}
PROPER = re.compile(r"\b[A-Z][a-zA-Z']{3,}\b")
UAW = re.compile(r"[А-ЯІЇЄҐа-яіїєґ'’][А-ЯІЇЄҐа-яіїєґ'’-]{2,}")


def ua_of(v):
    if isinstance(v, str):
        return v
    if isinstance(v, dict):
        for f in ("name", "title", "text", "ua", "value"):
            x = v.get(f)
            if isinstance(x, str) and x.strip():
                return x
    return ""


# --- 1. англ. ім'я -> українські кандидати (лише з точних ключів) -------------
cand = defaultdict(set)
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for k, v in d.items():
        if not isinstance(k, str) or k.isdigit() or len(k.split()) > 4:
            continue
        u = ua_of(v)
        if u and PROPER.search(k):
            cand[k].add(u)
for cid, v in json.loads(
        (DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig")).items():
    nm = v.get("name") if isinstance(v, dict) else None
    en = nm.get("en") if isinstance(nm, dict) else None
    u = ua_of(tr.get("npcNames", {}).get(str(cid)))
    if en and u:
        cand[en].add(u)


def form_pat(form):
    parts = []
    for w in UAW.findall(form):
        stem = w[:-2] if len(w) > 5 else w
        parts.append(re.escape(stem) + r"\w{0,3}\b")
    return re.compile(r"\s+".join(parts), re.I) if parts else None


def stem_key(form):
    """Підпис форми за основами — щоб відмінок не читався як інша назва.

    «Командир» і «Командире» (кличний), «Подорож» і «Подорожі», «Велика» і
    «Великий» — це одна форма в різних відмінках і родах, а не різнобій.
    Без цього згортання детектор називав різнобоєм звичайну граматику.
    """
    return tuple(w[:-2].lower() if len(w) > 5 else w.lower()
                 for w in UAW.findall(form))


PATS = {}
for en, forms in cand.items():
    if len(forms) < 2:
        continue
    by_stem = {}
    for f in forms:
        k = stem_key(f)
        if k and k not in by_stem:
            by_stem[k] = f
    if len(by_stem) < 2:
        continue
    ps = {}
    for f in by_stem.values():
        p = form_pat(f)
        if p:
            ps[f] = p
    if len(ps) > 1:
        PATS[en] = ps

# Загальне слово з великої на початку речення — не власна назва. Якщо те
# саме слово трапляється в англійському тексті з МАЛОЇ, воно загальне:
# «Broken», «Travel», «Bones» шуміли саме так.
COMMON = set()
for v in qsrc.values():
    if not isinstance(v, dict):
        continue
    for f in ("title", "description"):
        t = (v.get(f) or {}).get("en") if isinstance(v.get(f), dict) else None
        if t:
            COMMON.update(w.capitalize() for w in re.findall(r"\b[a-z]{4,}\b", t))
PATS = {k: v for k, v in PATS.items() if k not in COMMON}

# --- 2. гілки ----------------------------------------------------------------
rows = []
for qlid, v in ql.items():
    nm = v.get("name") if isinstance(v, dict) else None
    ql_en = nm.get("en") if isinstance(nm, dict) else None
    quests = v.get("quests") or []
    if not ql_en or not quests:
        continue

    en_blob, items = [], []
    for q in quests:
        sv, uv = qsrc.get(str(q)), tq.get(str(q))
        if not isinstance(sv, dict) or not isinstance(uv, dict):
            continue
        e_t = (sv.get("title") or {}).get("en") or ""
        e_d = (sv.get("description") or {}).get("en") or ""
        u_t, u_d = uv.get("title") or "", uv.get("description") or ""
        if not (u_t or u_d):
            continue
        en_blob.append(e_t + " " + e_d)
        items.append({"id": str(q), "en_title": e_t, "ua_title": u_t,
                      "ua_desc": u_d})
    if len(items) < 2:
        continue

    ua_blob = " ".join(i["ua_title"] + " " + i["ua_desc"] for i in items)
    names = {w for chunk in en_blob for w in PROPER.findall(chunk)} - STOP

    conflicts = {}
    for n in names:
        ps = PATS.get(n)
        if not ps:
            continue
        # Форми шукаємо ВІД НАЙДОВШОЇ, затираючи знайдене. Інакше коротша
        # форма зараховує собі довшу: шаблон «Ейтріґ» це основа «Ейтр» плюс
        # хвіст до трьох літер, і він накриває «Ейтріґґ». Через це детектор
        # оголошував конфлікт там, де в тексті стоїть лише одна форма.
        blob, seen = ua_blob, []
        for f in sorted(ps, key=len, reverse=True):
            if ps[f].search(blob):
                seen.append(f)
                blob = ps[f].sub(" ", blob)
        if len(seen) > 1:
            conflicts[n] = sorted(seen)
    if conflicts or TOP:
        rows.append({"questline": ql_en,
                     "ua_questline": ua_of(tr.get("questLines", {}).get(ql_en)),
                     "conflicts": conflicts,
                     "quests": items})

if TOP:
    # найбільші гілки: там і найбільше шансів на різнобій, і найбільша
    # видимість — це кампанії, які проходить кожен.
    rows.sort(key=lambda r: -len(r["quests"]))
    rows = rows[:TOP]
else:
    rows.sort(key=lambda r: -len(r["conflicts"]))
tot = sum(len(r["conflicts"]) for r in rows)
print(f"гілок із завданнями: {len(ql)} | СУПЕРЕЧАТЬ САМІ СОБІ: {len(rows)} "
      f"| конфліктів імен разом: {tot}")

if REPORT:
    for r in rows[:20]:
        print(f"\n  {r['questline']} ({len(r['quests'])} завдань)")
        for n, forms in list(r["conflicts"].items())[:4]:
            print(f"      {n}: {' | '.join(forms)}")
    sys.exit()

d = DATA_DIR / "batches" / "qlnorm"
d.mkdir(parents=True, exist_ok=True)
for f in d.glob("qn_*.json"):
    f.unlink()
n = (len(rows) + SIZE - 1) // SIZE
for k in range(n):
    (d / f"qn_{k:02d}.json").write_text(
        json.dumps(rows[k * SIZE:(k + 1) * SIZE], ensure_ascii=False, indent=1),
        encoding="utf-8")
print(f"-> батчів {n} по {SIZE} у {d}")
