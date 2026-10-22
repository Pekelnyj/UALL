# -*- coding: utf-8 -*-
"""Витяг назв journal-ІНСТАНСІВ (підземелля/рейди Путівника пригод) з Blizzard API
-> data/source/api_journal_instances.json {journalInstanceID: {name:{en,de,fr}}}.

Боси (encounters) тягне extract_api_catalog.py; тут — лише назви самих інстансів,
що показуються списком у вкладках Dungeons/Raids (EncounterJournalInstanceSelect).
"""
import os, sys, json, time
from concurrent.futures import ThreadPoolExecutor
import requests
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

REGION = "us"
BASE = f"https://{REGION}.api.blizzard.com"
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


def get(path, retries=6):
    for a in range(retries):
        try:
            r = _session.get(BASE + path, params={"namespace": f"static-{REGION}"},
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


idx = get("/data/wow/journal-instance/index")
insts = [i["id"] for i in (idx or {}).get("instances", [])]
print(f"[instances] {len(insts)} інстансів, тягну назви...")
out = {}


def fetch(iid):
    d = get(f"/data/wow/journal-instance/{iid}")
    if not d:
        return None
    nm = loc3(d.get("name"))
    return (iid, nm) if nm else None


with ThreadPoolExecutor(max_workers=THREADS) as ex:
    for res in ex.map(fetch, sorted(insts)):
        if res:
            out[str(res[0])] = {"name": res[1]}

(DATA_DIR / "source" / "api_journal_instances.json").write_text(
    json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Інстансів: {len(out)} -> data/source/api_journal_instances.json")
