# -*- coding: utf-8 -*-
"""Витяг УСІХ spell-ID секцій заданих енкаунтерів (боси) з journal-encounter API
-> додає їх у source/spells.json (name з DB2 пізніше через process). Аргумент —
encounterID через кому. Для Ями Сарона: 608,609,610.
Потім: process (назви) / extract_spell_descriptions -> переклад.
"""
import os, sys, json, time
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
        if r.status_code in (429,) or r.status_code >= 500:
            time.sleep(1 + a * 2); continue
        return r.json() if r.status_code == 200 else None
    return None


def collect_spells(sec, out):
    if not isinstance(sec, dict):
        return
    sp = sec.get("spell")
    if isinstance(sp, dict) and sp.get("id"):
        out.add(int(sp["id"]))
    for sub in sec.get("sections", []) or []:
        collect_spells(sub, out)


enc_ids = [int(x) for x in sys.argv[1].split(",")] if len(sys.argv) > 1 else [608, 609, 610]
spells = set()
for eid in enc_ids:
    d = get(f"/data/wow/journal-encounter/{eid}")
    if d:
        for sec in d.get("sections", []) or []:
            collect_spells(sec, spells)
print(f"Енкаунтери {enc_ids}: spell-ID у секціях = {len(spells)}")

# додати відсутні у source як заглушки (name/desc підтягне DB2 у наст. кроках)
sp = json.loads((DATA_DIR / "source" / "spells.json").read_text(encoding="utf-8-sig"))
new = 0
for sid in spells:
    if str(sid) not in sp:
        sp[str(sid)] = {"talent": True, "skillLine": "Captured", "name": {}}
        new += 1
(DATA_DIR / "source" / "spells.json").write_text(
    json.dumps(sp, ensure_ascii=False, indent=2), encoding="utf-8")
# зберегти список для process (назви) — через окремий канал
(DATA_DIR / "_enc_spell_ids.json").write_text(
    json.dumps(sorted(spells)), encoding="utf-8")
print(f"Додано нових у source: {new} | список -> data/_enc_spell_ids.json")
