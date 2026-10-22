# -*- coding: utf-8 -*-
"""ПОВНИЙ витяг підземель для журналу: instance-ID(и) -> усе потрібне.
  - api_journal_instances.json: назва інстансу
  - api_instance_desc.json: опис інстансу (lore)
  - api_journal.json: енкаунтери (боси) name+description(лор)
  - api_journal_sections.json: текст секцій (огляд/буліти/механіки)
  - source/spells.json: spell-ID секцій (для описів абілок, як Captured)
Запуск: python extract_dungeon_full.py 1300,476,1201,945,1299,1315,1316
"""
import os, sys, json, time
import requests
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

REGION = "us"
BASE = f"https://{REGION}.api.blizzard.com"
_session = requests.Session()
_token = None
SRC = DATA_DIR / "source"


def token():
    global _token
    if not _token:
        _token = requests.post(
            "https://oauth.battle.net/token", data={"grant_type": "client_credentials"},
            auth=(os.environ["BLIZZARD_CLIENT_ID"], os.environ["BLIZZARD_CLIENT_SECRET"]),
            timeout=30).json()["access_token"]
    return _token


def get(path, locale="en_US"):
    for a in range(6):
        try:
            r = _session.get(BASE + path, params={"namespace": f"static-{REGION}", "locale": locale},
                             headers={"Authorization": f"Bearer {token()}"}, timeout=45)
        except requests.RequestException:
            time.sleep(1 + a); continue
        if r.status_code in (429,) or r.status_code >= 500:
            time.sleep(1 + a * 2); continue
        return r.json() if r.status_code == 200 else None
    return None


def loc3(field, path):
    """Тягне en/de/fr (3 запити) для name/description полів інстансу/боса."""
    out = {}
    for loc, short in (("en_US", "en"), ("de_DE", "de"), ("fr_FR", "fr")):
        d = get(path, loc)
        if d:
            v = d.get(field)
            if isinstance(v, str) and v:
                out[short] = v
    return out or None


def J(name):
    p = SRC / name
    return json.loads(p.read_text(encoding="utf-8-sig")) if p.exists() else {}


inst_ids = [int(x) for x in sys.argv[1].split(",")]
aji = J("api_journal_instances.json")
idesc = J("api_instance_desc.json")
aj = J("api_journal.json")
asec = J("api_journal_sections.json")
spells = json.loads((SRC / "spells.json").read_text(encoding="utf-8-sig"))


def collect(sec, texts, spids):
    if not isinstance(sec, dict):
        return
    for key in ("title", "body_text"):
        t = sec.get(key)
        if isinstance(t, str) and t.strip():
            texts.add(t.strip())
    sp = sec.get("spell")
    if isinstance(sp, dict) and sp.get("id"):
        spids.add(int(sp["id"]))
    for sub in sec.get("sections", []) or []:
        collect(sub, texts, spids)


tot_enc = tot_sec = tot_sp = 0
for iid in inst_ids:
    inst = get(f"/data/wow/journal-instance/{iid}")
    if not inst:
        print(f"  instance {iid}: 404"); continue
    name_en = inst.get("name", "?")
    # назва + опис інстансу (de/fr — окремими запитами лише якщо треба; en уже є)
    if str(iid) not in aji:
        aji[str(iid)] = {"name": loc3("name", f"/data/wow/journal-instance/{iid}")}
    if inst.get("description") and str(iid) not in idesc:
        idesc[str(iid)] = {"name": {"en": name_en}, "desc": {"en": inst["description"]}}
    encs = [e["id"] for e in inst.get("encounters", []) or []]
    sec_count = 0
    for eid in encs:
        enc = get(f"/data/wow/journal-encounter/{eid}")
        if not enc:
            continue
        # назва+лор боса (en+de+fr)
        if str(eid) not in aj:
            aj[str(eid)] = {"name": loc3("name", f"/data/wow/journal-encounter/{eid}"),
                            "description": loc3("description", f"/data/wow/journal-encounter/{eid}")}
        texts, spids = set(), set()
        for sec in enc.get("sections", []) or []:
            collect(sec, texts, spids)
        for t in texts:
            asec.setdefault(t, {"enc": []})
            if eid not in asec[t]["enc"]:
                asec[t]["enc"].append(eid)
        sec_count += len(texts)
        for sid in spids:
            if str(sid) not in spells:
                spells[str(sid)] = {"talent": True, "skillLine": "Captured", "name": {}}
                tot_sp += 1
    tot_enc += len(encs); tot_sec += sec_count
    print(f"  [{iid}] {name_en}: босів {len(encs)}, секцій {sec_count}")

(SRC / "api_journal_instances.json").write_text(json.dumps(aji, ensure_ascii=False, indent=1), encoding="utf-8")
(SRC / "api_instance_desc.json").write_text(json.dumps(idesc, ensure_ascii=False, indent=1), encoding="utf-8")
(SRC / "api_journal.json").write_text(json.dumps(aj, ensure_ascii=False, indent=1), encoding="utf-8")
(SRC / "api_journal_sections.json").write_text(json.dumps(asec, ensure_ascii=False, indent=1), encoding="utf-8")
(SRC / "spells.json").write_text(json.dumps(spells, ensure_ascii=False, indent=2), encoding="utf-8")
print(f"\nРАЗОМ: босів {tot_enc}, секцій {tot_sec}, НОВИХ spell-ID {tot_sp}")
print("Далі: add_referenced_spells -> extract_spell_descriptions -> prep -> переклад")
