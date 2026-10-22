# -*- coding: utf-8 -*-
"""Витяг СЕРВЕРНИХ полів квестів (objectives/description/progress/completion) з Wowhead.
Blizzard REST їх НЕ віддає (лише title+description); Wowhead має все.

АНТИ-БАН: повільно (2-3с+джитер), РЕЗЮМАБЕЛЬНО (кожен квест одразу на диск; повторний
запуск пропускає вже здобуті), граційна зупинка на 403/429 (бан → пауза, не довбимо),
партіями (--limit). <name> Wowhead → наш {NAME}.

Запуск:  python pipeline/extract_wowhead_quests.py --ids-file data/_wh_todo.txt [--limit 500]
Результат: data/source/wowhead_quests.json  {qid: {objectives,description,progress,completion}}
           (доповнюється; безпечно перезапускати)
"""
import argparse, gzip, html, json, os, re, sys, time, urllib.request, urllib.error
sys.stdout.reconfigure(encoding="utf-8")

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
OUT = os.path.join(ROOT, "data", "source", "wowhead_quests.json")
# КЕШ сирих сторінок (обрізані скрипти/стилі + gzip ~7 КБ/стор.). Щоб БУДЬ-ЯКИЙ
# майбутній фікс парсера / нове поле → перепарс ЛОКАЛЬНО, без повторних звернень.
# Раз завантажене — назавжди на диску (див. reparse_from_cache.py).
HTML_CACHE = os.path.join(ROOT, "data", "wh_html_cache")
_SCRIPT = re.compile(r"<script\b.*?</script>|<style\b.*?</style>", re.S | re.I)
def _cache_path(qid):
    return os.path.join(HTML_CACHE, f"{qid}.html.gz")
# УВАГА: простий UA проходить, а «реалістичний» Chrome-UA+Referer → 403 (Cloudflare
# вважає його ботом). НЕ додавати Referer/зайві заголовки — саме вони тригерять блок.
UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
# детермінований «джитер» без random (сендбокс): за questID.
# База конфігурується через WH_DELAY (ввічливість/анти-403); типово 2.0с.
_BASE = float(os.environ.get("WH_DELAY", "2.0"))
def jitter(qid): return _BASE + (int(qid) % 17) / 10.0   # BASE..BASE+1.6 c

def clean(s):
    s = re.sub(r"<br\s*/?>", "\n", s)
    s = re.sub(r"<[^>]+>", "", s)
    s = html.unescape(s).strip()
    return s.replace("<name>", "{NAME}").replace("<class>", "{class}").replace("<race>", "{race}")

# JS-сигнатури: інколи в секцію витікає скрейп-сміття (Wowhead-скрипти)
JUNK = re.compile(r"WH\.|clickToCopy|C_QuestLog|function\s*\(|\bvar\s|document\.|\$WowheadPower", re.I)

def parse(h):
    h = re.sub(r"<script\b.*?</script>", " ", h, flags=re.S | re.I)  # прибрати скрипти ДО парсингу
    out = {}
    # НАЗВА квесту з <h1> — запасне EN-джерело (основне — Blizzard API; тут щоб
    # не губити назву квестів, яких в API нема).
    m = re.search(r'<h1[^>]*class="[^"]*heading-size-1[^"]*"[^>]*>(.*?)</h1>', h, re.S)
    if m:
        ttl = clean(m.group(1))
        if ttl and not ttl.lower().startswith(("quest", "wowhead")):
            out["title"] = ttl
    # ЦІЛЬ квесту — Wowhead НЕ дає її під <h2>Objectives</h2> для авто-цілей, зате
    # кладе В <meta name="description" content="ЦІЛЬ. A level N ЗОНА Quest. ...">.
    md = re.search(r'<meta name="description"\s+content="(.*?)"', h, re.S)
    if md:
        desc_meta = html.unescape(md.group(1))
        # відсікти хвіст «. A level N … Quest …» → лишається текст цілі
        om = re.match(r"(.+?)\.\s+A level\s+\d+", desc_meta)
        if om:
            obj = om.group(1).strip() + "."
            if obj and len(obj) > 3 and not JUNK.search(obj):
                out["objectives"] = obj
    for fld, lab in [("objectives", "Objectives"), ("description", "Description"),
                     ("progress", "Progress"), ("completion", "Completion")]:
        # заголовок буває ПРЯМИЙ (>Label</h2>) АБО в лінку (>Label</a></h2>);
        # текст — у наступному <div id="...">...</div>. Ловимо до наступного <h2.
        m = re.search(rf">{re.escape(lab)}(?:</a>)?</h2>(.*?)(?=<h2\b)", h, re.S)
        if m:
            t = clean(m.group(1))
            # відсікти службові хвости (кнопки/скрипти лишають короткі уламки) + JS-сміття
            if t and len(t) > 1 and not t.lower().startswith(("comment", "contribute", "screenshot")) and not JUNK.search(t):
                out[fld] = t
    return out

def fetch(qid):
    # 1) КЕШ: якщо сторінка вже збережена — читаємо з диска, НУЛЬ звернень до Wowhead.
    cp = _cache_path(qid)
    if os.path.exists(cp):
        try:
            with gzip.open(cp, "rt", encoding="utf-8") as f:
                return f.read()
        except Exception:
            pass  # битий кеш — перекачаємо
    # 2) МЕРЕЖА: тягнемо сторінку і ОДРАЗУ кешуємо (обрізавши скрипти/стилі).
    req = urllib.request.Request(f"https://www.wowhead.com/quest={qid}", headers={"User-Agent": UA})
    with urllib.request.urlopen(req, timeout=30) as r:
        h = r.read().decode("utf-8", "replace")
    try:
        os.makedirs(HTML_CACHE, exist_ok=True)
        with gzip.open(cp, "wt", encoding="utf-8") as f:
            f.write(_SCRIPT.sub(" ", h))  # без <script>/<style> — усе, що треба парсеру, лишається
    except Exception:
        pass  # кеш — «приємний бонус», збій запису не має валити фетч
    return h

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--ids-file", required=True)
    ap.add_argument("--limit", type=int, default=0, help="скільки НОВИХ за прогін (0=усі)")
    a = ap.parse_args()
    ids = [x.strip() for x in open(os.path.join(ROOT, a.ids_file.replace("data/", "data/") if a.ids_file.startswith("data") else a.ids_file), encoding="utf-8") if x.strip()] \
        if not os.path.isabs(a.ids_file) else [x.strip() for x in open(a.ids_file) if x.strip()]
    got = json.load(open(OUT, encoding="utf-8-sig")) if os.path.exists(OUT) else {}
    todo = [q for q in ids if q not in got]
    print(f"усього ID: {len(ids)} | вже здобуто: {len(got)} | лишилось: {len(todo)}")
    fails = 0; new = 0; empty = 0
    for i, qid in enumerate(todo):
        if a.limit and new >= a.limit:
            print(f"досягнуто --limit {a.limit}, стоп (решту наступного прогону)"); break
        try:
            p = parse(fetch(qid))
            got[qid] = p; new += 1
            if not p: empty += 1
            fails = 0
            if new % 10 == 0:
                json.dump(got, open(OUT, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
                print(f"  [{new}] #{qid}: {list(p) or 'порожньо'} (збережено)")
        except urllib.error.HTTPError as e:
            if e.code == 404:
                got[qid] = {}; new += 1  # фантом — позначити, щоб не тягти знову
            elif e.code in (403, 429, 503):
                fails += 1
                print(f"  !! {e.code} на #{qid} — можливий бан/ліміт. Пауза {30*fails}с ({fails}/3)")
                json.dump(got, open(OUT, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
                if fails >= 3:
                    print("  СТОП: 3 поспіль — не довбимо IP. Перезапусти пізніше (резюм)."); break
                time.sleep(30 * fails); continue
            else:
                got[qid] = {}; new += 1
        except Exception as e:
            print(f"  ? #{qid}: {type(e).__name__}"); time.sleep(5); continue
        time.sleep(jitter(qid))
    json.dump(got, open(OUT, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    print(f"\nздобуто цей прогін: {new} (порожніх/фантомів: {empty}) | усього в файлі: {len(got)} -> {OUT}")

if __name__ == "__main__":
    main()
