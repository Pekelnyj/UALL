# -*- coding: utf-8 -*-
"""Дістати instance-ID рейдів (і підземель) доповнення за journal-expansion ID."""
import os, sys, json, time
import requests
sys.stdout.reconfigure(encoding="utf-8")

REGION = "us"; BASE = f"https://{REGION}.api.blizzard.com"
_s = requests.Session(); _tok = None


def token():
    global _tok
    if not _tok:
        _tok = requests.post("https://oauth.battle.net/token", data={"grant_type": "client_credentials"},
                             auth=(os.environ["BLIZZARD_CLIENT_ID"], os.environ["BLIZZARD_CLIENT_SECRET"]),
                             timeout=30).json()["access_token"]
    return _tok


def get(path):
    for a in range(6):
        r = _s.get(BASE + path, params={"namespace": f"static-{REGION}", "locale": "en_US"},
                   headers={"Authorization": f"Bearer {token()}"}, timeout=45)
        if r.status_code in (429,) or r.status_code >= 500:
            time.sleep(1 + a * 2); continue
        return r.json() if r.status_code == 200 else None
    return None


exp = int(sys.argv[1])
d = get(f"/data/wow/journal-expansion/{exp}")
for kind in ("dungeons", "raids"):
    print(f"=== {kind} ===")
    for inst in d.get(kind, []) or []:
        print(f"  {inst['id']}\t{inst['name']}")
