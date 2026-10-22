# -*- coding: utf-8 -*-
"""Витяг ТЕКСТУ СЕКЦІЙ босів (огляд/механіки) з Blizzard journal-encounter API
-> data/source/api_journal_sections.json {en_text: {"enc": [encID...]}}.

Кожен encounter має description (лор — уже маємо) + sections[] із body_text
(опис механік/здібностей). Рекурсивно збираємо унікальні англ. рядки title/body.
EN-only (для оцінки обсягу й першої хвилі); de/fr можна додати згодом.
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


def collect(sec, encid, out):
    """Рекурсивно: title + body_text секції -> out[text]['enc'].add(encid)."""
    if not isinstance(sec, dict):
        return
    for key in ("title", "body_text"):
        t = sec.get(key)
        if isinstance(t, str) and t.strip():
            out.setdefault(t.strip(), set()).add(encid)
    for sub in sec.get("sections", []) or []:
        collect(sub, encid, out)


enc_ids = sorted(int(k) for k in json.loads(
    (DATA_DIR / "source" / "api_journal.json").read_text(encoding="utf-8-sig")))
print(f"[sections] енкаунтерів: {len(enc_ids)}, тягну секції...")
out = {}


def fetch(eid):
    d = get(f"/data/wow/journal-encounter/{eid}")
    if not d:
        return None
    local = {}
    for sec in d.get("sections", []) or []:
        collect(sec, eid, local)
    return local


done = 0
with ThreadPoolExecutor(max_workers=THREADS) as ex:
    for res in ex.map(fetch, enc_ids):
        done += 1
        if res:
            for t, encs in res.items():
                out.setdefault(t, set()).update(encs)
        if done % 200 == 0:
            print(f"  ...{done}/{len(enc_ids)} (унікальних рядків: {len(out)})")

serial = {t: {"enc": sorted(encs)} for t, encs in out.items()}
(DATA_DIR / "source" / "api_journal_sections.json").write_text(
    json.dumps(serial, ensure_ascii=False, indent=1), encoding="utf-8")
chars = sum(len(t) for t in out)
print(f"\nУнікальних рядків секцій: {len(out)} | символів усього: {chars:,}")
print(f"-> data/source/api_journal_sections.json")
