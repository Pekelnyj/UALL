# -*- coding: utf-8 -*-
"""Масовий витяг локалізованого тексту з Blizzard Game Data API (en/de/fr).

Тягне те, чого нема (або неповно) у wago-db2, але є в API:
  creatures (search), mounts, pets, toys, titles, m+ affixes, reputation factions,
  covenants, item sets, professions->recipes (назви), journal encounters (назва+опис).

GET без locale повертає поле як обʼєкт {en_US, de_DE, fr_FR, ...} -> 1 запит = усі мови.
Прямий GET creature/{id} дає 404, тож істоти беремо через search із нарізкою по id.

Кожен фронт пишеться окремо в data/source/api_<name>.json; наявний пропускається
(резюмабельність). Потоки прискорюють index+detail.

Запуск:  python extract_api_catalog.py
"""
import os, sys, json, time
from concurrent.futures import ThreadPoolExecutor
import requests

from common import DATA_DIR

sys.stdout.reconfigure(encoding="utf-8")
REGION = "us"
BASE = f"https://{REGION}.api.blizzard.com"
OUT = DATA_DIR / "source"
THREADS = 16

_session = requests.Session()
_token = None


def token():
    global _token
    if not _token:
        _token = requests.post(
            "https://oauth.battle.net/token", data={"grant_type": "client_credentials"},
            auth=(os.environ["BLIZZARD_CLIENT_ID"], os.environ["BLIZZARD_CLIENT_SECRET"]),
            timeout=30).json()["access_token"]
    return _token


def get(path, params=None, retries=6):
    p = {"namespace": f"static-{REGION}"}
    p.update(params or {})
    for a in range(retries):
        try:
            r = _session.get(BASE + path, params=p,
                             headers={"Authorization": f"Bearer {token()}"}, timeout=45)
        except requests.RequestException:
            time.sleep(1 + a); continue
        if r.status_code == 404:
            return None
        if r.status_code == 429 or r.status_code >= 500:
            time.sleep(1 + a * 2); continue
        if r.status_code == 200:
            return r.json()
        return None
    return None


def loc3(field):
    if isinstance(field, str):
        return {"en": field} if field else None
    if isinstance(field, dict):
        out = {}
        for k, short in (("en_US", "en"), ("de_DE", "de"), ("fr_FR", "fr")):
            if field.get(k):
                out[short] = field[k]
        return out or None
    return None


def save(name, data):
    path = OUT / f"api_{name}.json"
    path.write_text(json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"  -> {path.name}: {len(data)} записів")


def done(name):
    if (OUT / f"api_{name}.json").exists():
        print(f"[{name}] вже є, пропускаю")
        return True
    return False


# ---------- index + detail (потоково) ----------
def index_detail(name, index_path, index_key, detail_fmt, fields):
    if done(name):
        return
    print(f"[{name}] index...")
    idx = get(index_path)
    items = (idx or {}).get(index_key, [])
    ids = [it["id"] for it in items if "id" in it]
    print(f"[{name}] {len(ids)} елементів, тягну деталі ({THREADS} потоків)...")
    out = {}

    def fetch(i):
        d = get(detail_fmt.format(id=i))
        if not d:
            return None
        rec = {}
        for f in fields:
            v = loc3(d.get(f))
            if v:
                rec[f] = v
        return (i, rec) if rec else None

    with ThreadPoolExecutor(max_workers=THREADS) as ex:
        for res in ex.map(fetch, ids):
            if res:
                out[str(res[0])] = res[1]
    save(name, out)


# ---------- creatures via search (нарізка по id) ----------
def creature_search():
    if done("creatures_full"):
        return
    print("[creatures_full] search по id-діапазонах...")
    out = {}

    def rng(lo, hi):
        d = get("/data/wow/search/creature",
                {"id": f"[{lo},{hi}]", "orderby": "id", "_pageSize": 1000})
        res = (d or {}).get("results") or []
        if len(res) >= 1000 and hi - lo > 1:
            mid = (lo + hi) // 2
            rng(lo, mid); rng(mid + 1, hi)
            return
        for r in res:
            data = r.get("data", {})
            nm = loc3(data.get("name"))
            if nm and "id" in data:
                out[str(data["id"])] = {"name": nm}

    step = 5000
    lo = 0
    while lo <= 330000:
        rng(lo, lo + step - 1)
        lo += step
        if lo % 50000 == 0:
            print(f"   ...id {lo}, зібрано {len(out)}")
    save("creatures_full", out)


# ---------- journal encounters (інстанс -> бос -> опис) ----------
def journal():
    if done("journal"):
        return
    print("[journal] інстанси...")
    idx = get("/data/wow/journal-instance/index")
    insts = [i["id"] for i in (idx or {}).get("instances", [])]
    enc_ids = set()
    for iid in insts:
        d = get(f"/data/wow/journal-instance/{iid}")
        for e in (d or {}).get("encounters", []):
            if "id" in e:
                enc_ids.add(e["id"])
    print(f"[journal] {len(enc_ids)} боїв, тягну описи...")
    out = {}

    def fetch(eid):
        d = get(f"/data/wow/journal-encounter/{eid}")
        if not d:
            return None
        rec = {}
        for f in ("name", "description"):
            v = loc3(d.get(f))
            if v:
                rec[f] = v
        return (eid, rec) if rec else None

    with ThreadPoolExecutor(max_workers=THREADS) as ex:
        for res in ex.map(fetch, sorted(enc_ids)):
            if res:
                out[str(res[0])] = res[1]
    save("journal", out)


# ---------- professions -> skill tiers -> recipe names ----------
def professions():
    if done("recipes"):
        return
    print("[recipes] професії...")
    idx = get("/data/wow/profession/index")
    profs = [(p["id"], loc3(p.get("name"))) for p in (idx or {}).get("professions", [])]
    out = {}
    for pid, pname in profs:
        pd = get(f"/data/wow/profession/{pid}")
        for tier in (pd or {}).get("skill_tiers", []):
            tid = tier.get("id")
            td = get(f"/data/wow/profession/{pid}/skill-tier/{tid}")
            for cat in (td or {}).get("categories", []):
                for rec in cat.get("recipes", []):
                    rid = rec.get("id")
                    nm = loc3(rec.get("name"))
                    if rid and nm:
                        out[str(rid)] = {"name": nm}
        print(f"   {pname.get('en') if pname else pid}: разом рецептів {len(out)}")
    save("recipes", out)


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    creature_search()
    index_detail("mounts", "/data/wow/mount/index", "mounts",
                 "/data/wow/mount/{id}", ["name", "description"])
    index_detail("pets", "/data/wow/pet/index", "pets",
                 "/data/wow/pet/{id}", ["name", "description"])
    index_detail("toys", "/data/wow/toy/index", "toys",
                 "/data/wow/toy/{id}", ["source_description"])
    index_detail("titles", "/data/wow/title/index", "titles",
                 "/data/wow/title/{id}", ["name"])
    index_detail("affixes", "/data/wow/keystone-affix/index", "affixes",
                 "/data/wow/keystone-affix/{id}", ["name", "description"])
    index_detail("factions", "/data/wow/reputation-faction/index", "factions",
                 "/data/wow/reputation-faction/{id}", ["name", "description"])
    index_detail("covenants", "/data/wow/covenant/index", "covenants",
                 "/data/wow/covenant/{id}", ["name", "description"])
    index_detail("item_sets", "/data/wow/item-set/index", "item_sets",
                 "/data/wow/item-set/{id}", ["name"])
    journal()
    professions()
    print("\nГОТОВО. Файли у data/source/api_*.json")


if __name__ == "__main__":
    main()
