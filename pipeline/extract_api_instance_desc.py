# -*- coding: utf-8 -*-
"""Витяг ОПИСІВ підземель/рейдів (lore) з journal-instance API
-> data/source/api_instance_desc.json {journalInstanceID: {name:{en}, desc:{en}}}.
EJ показує їх у LoreScrollingFont. Плоский текст — матч за EN.
"""
import os, sys, json, time
from concurrent.futures import ThreadPoolExecutor
import requests
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

REGION = "us"
BASE = f"https://{REGION}.api.blizzard.com"
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


def get(path):
    for a in range(6):
        try:
            r = _session.get(BASE + path, params={"namespace": f"static-{REGION}", "locale": "en_US"},
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


ids = [int(k) for k in json.loads(
    (DATA_DIR / "source" / "api_journal_instances.json").read_text(encoding="utf-8-sig"))]
print(f"[instance-desc] {len(ids)} інстансів, тягну описи...")
out = {}


def fetch(iid):
    d = get(f"/data/wow/journal-instance/{iid}")
    if not d:
        return None
    nm = d.get("name")
    desc = d.get("description")
    if not desc:
        return None
    return (iid, {"name": {"en": nm if isinstance(nm, str) else ""},
                  "desc": {"en": desc}})


with ThreadPoolExecutor(max_workers=16) as ex:
    for res in ex.map(fetch, sorted(ids)):
        if res:
            out[str(res[0])] = res[1]

(DATA_DIR / "source" / "api_instance_desc.json").write_text(
    json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
chars = sum(len(v["desc"]["en"]) for v in out.values())
print(f"З описом: {len(out)} | символів: {chars:,} -> data/source/api_instance_desc.json")
