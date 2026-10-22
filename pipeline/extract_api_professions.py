# -*- coding: utf-8 -*-
"""Витяг назв ПРОФЕСІЙ + рівнів майстерності (skill tiers) з Blizzard API
-> data/source/api_professions.json {key: {name:{en,de,fr}}}.
Профі: ключ = profID; тир: ключ = "t<tierID>".
"""
import os, sys, json
import requests
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

REGION = "us"
BASE = f"https://{REGION}.api.blizzard.com"
tok = requests.post("https://oauth.battle.net/token", data={"grant_type": "client_credentials"},
                    auth=(os.environ["BLIZZARD_CLIENT_ID"], os.environ["BLIZZARD_CLIENT_SECRET"]),
                    timeout=30).json()["access_token"]
H = {"Authorization": f"Bearer {tok}"}


def get(path):
    r = requests.get(BASE + path, params={"namespace": f"static-{REGION}"}, headers=H, timeout=30)
    return r.json() if r.status_code == 200 else None


def loc3(field):
    if isinstance(field, str):
        return {"en": field}
    if isinstance(field, dict):
        o = {}
        for k, s in (("en_US", "en"), ("de_DE", "de"), ("fr_FR", "fr")):
            if field.get(k):
                o[s] = field[k]
        return o or None
    return None


out = {}
idx = get("/data/wow/profession/index")
for p in (idx or {}).get("professions", []):
    pid = p["id"]
    pd = get(f"/data/wow/profession/{pid}")
    if not pd:
        continue
    nm = loc3(pd.get("name"))
    if nm:
        out[str(pid)] = {"name": nm}
    for tier in pd.get("skill_tiers", []):
        tn = loc3(tier.get("name"))
        if tn:
            out[f"t{tier.get('id')}"] = {"name": tn}

(DATA_DIR / "source" / "api_professions.json").write_text(
    json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Професій+тирів: {len(out)} -> data/source/api_professions.json")
