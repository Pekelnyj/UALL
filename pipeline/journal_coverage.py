# -*- coding: utf-8 -*-
"""ЗВІТ ПОКРИТТЯ журналу + ДАМП прогалин (щоб не QA-ити очима).
Для кожного підземелля рахує перекладено/всього по шарах і ВИВОДИТЬ точні
неперекладені рядки у data/jcov/ для наступної хвилі перекладу.

Запуск: python journal_coverage.py 1300,476,1201,945,1299,1315,1316
        python journal_coverage.py 1300,476,...  --dump   (записати прогалини)
"""
import os, sys, json, re, time
import requests
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

REGION = "us"; BASE = f"https://{REGION}.api.blizzard.com"
_s = requests.Session(); _tok = None
CACHE = DATA_DIR / "jcov" / "_apicache.json"
_cache = json.loads(CACHE.read_text(encoding="utf-8")) if CACHE.exists() else {}


def token():
    global _tok
    if not _tok:
        _tok = requests.post("https://oauth.battle.net/token", data={"grant_type": "client_credentials"},
                             auth=(os.environ["BLIZZARD_CLIENT_ID"], os.environ["BLIZZARD_CLIENT_SECRET"]),
                             timeout=30).json()["access_token"]
    return _tok


def get(path):
    if path in _cache:
        return _cache[path]
    for a in range(6):
        try:
            r = _s.get(BASE + path, params={"namespace": f"static-{REGION}", "locale": "en_US"},
                       headers={"Authorization": f"Bearer {token()}"}, timeout=45)
        except requests.RequestException:
            time.sleep(1 + a); continue
        if r.status_code in (429,) or r.status_code >= 500:
            time.sleep(1 + a * 2); continue
        d = r.json() if r.status_code == 200 else None
        _cache[path] = d
        return d
    return None


def ej_canon(s):
    s = re.sub(r'\|c[0-9a-fA-F]{8}', '', s); s = re.sub(r'\|cn[A-Za-z_]+:', '', s); s = s.replace('|r', '')
    s = re.sub(r'\|H.*?\|h(.*?)\|h', r'\1', s); s = re.sub(r'\|T.*?\|t', '', s); s = re.sub(r'\|A.*?\|a', '', s)
    s = s.replace('$bullet;', '').replace('|n', ' '); s = re.sub(r'[\r\n]+', ' ', s)
    s = re.sub(r'\d[\d,.]*', '#', s); return re.sub(r'\s+', ' ', s).strip()


def split_b(s):
    return [p for p in s.split("$bullet;") if p.strip()] if "$bullet;" in s else [s]


def walk(sec, spids, bullets):
    if not isinstance(sec, dict):
        return
    sp = sec.get("spell")
    if isinstance(sp, dict) and sp.get("id"):
        spids.add(int(sp["id"]))
    for k in ("title", "body_text"):
        t = sec.get(k)
        if isinstance(t, str) and t.strip():
            bullets.append(t.strip())
    for s in sec.get("sections", []) or []:
        walk(s, spids, bullets)


DUN = {1300: "Тераса магістрів", 476: "Скайріч", 1201: "Академія Алгетара", 945: "Престол Тріумвірату",
       1299: "Шпиль Віндраннерів", 1315: "Печери Майсари", 1316: "Вузлова Точка Ксенас",
       306: "Яма Сарона"}


def main():
    iids = [int(x) for x in sys.argv[1].split(",")]
    dump = "--dump" in sys.argv
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    journal = tr.get("journal", {}); dt = tr.get("descTemplates", {})
    idt = tr.get("instanceDesc", {})
    # journalSections у JSON ключована СИРИМ англ.; рушій матчить за КАНОНОМ (як
    # generate_journal: split_b + ej_canon). Будуємо канон-множину так само.
    js = set()
    for en_raw, ua in (tr.get("journalSections", {}) or {}).items():
        if not ua:
            continue
        for b in split_b(en_raw):
            k = ej_canon(b)
            if k:
                js.add(k)
    spells = json.loads((DATA_DIR / "source" / "spells.json").read_text(encoding="utf-8-sig"))

    def spen(sid):  # англ. назва спела
        v = spells.get(str(sid))
        if isinstance(v, dict):
            n = v.get("name"); return n.get("en") if isinstance(n, dict) else n
        return None

    def desc_translated(sid):
        # РЕАЛЬНИЙ ланцюг (як generate_spell_descriptions): spellID → source.description.en
        # → descTemplates[en]. НЕ spellID-ключ (то була помилка, що давала фальшиве OK).
        v = spells.get(str(sid))
        en = (v.get("description") or {}).get("en") if isinstance(v, dict) and isinstance(v.get("description"), dict) else None
        return bool(en and en in dt)

    gap_desc = {}   # spellID -> en name (опис треба зібрати в грі/DB2)
    gap_sec = set()  # raw EN bullet
    print(f"{'Підземелля':<22}{'лор':>8}{'опис.аб':>10}{'секції':>10}{'інст'}")
    for iid in iids:
        d = get(f"/data/wow/journal-instance/{iid}")
        if not d:
            print(f"  {iid}: 404"); continue
        lt = ln = dt_t = dt_n = st = sn = 0
        for e in d.get("encounters", []) or []:
            eid = str(e["id"]); enc = get(f"/data/wow/journal-encounter/{eid}")
            if not enc:
                continue
            if (enc.get("description") or "").strip():
                lt += 1
                if (journal.get(eid, {}) or {}).get("desc", "").strip():
                    ln += 1
            spids = set(); bullets = []
            for s in enc.get("sections", []) or []:
                walk(s, spids, bullets)
            for sid in spids:
                dt_t += 1
                if desc_translated(sid):
                    dt_n += 1
                else:
                    gap_desc[str(sid)] = spen(sid)
            for b in bullets:
                for one in split_b(b):
                    k = ej_canon(one)
                    if not k:
                        continue
                    st += 1
                    if k in js:
                        sn += 1
                    else:
                        gap_sec.add(one)
        idv = d.get("description")
        inst = "—" if not idv else ("OK" if idv in idt else "EN!")
        print(f"{DUN.get(iid, iid):<22}{ln}/{lt:<6}{dt_n}/{dt_t:<7}{sn}/{st:<7}{inst}")

    CACHE.parent.mkdir(exist_ok=True)
    CACHE.write_text(json.dumps(_cache, ensure_ascii=False), encoding="utf-8")
    print(f"\nПРОГАЛИНИ: описів-абілок {len(gap_desc)}, секцій {len(gap_sec)}")
    if dump:
        (DATA_DIR / "jcov" / "gap_desc.json").write_text(
            json.dumps(gap_desc, ensure_ascii=False, indent=1), encoding="utf-8")
        (DATA_DIR / "jcov" / "gap_sec.json").write_text(
            json.dumps(sorted(gap_sec), ensure_ascii=False, indent=1), encoding="utf-8")
        print("→ data/jcov/gap_desc.json, gap_sec.json")


if __name__ == "__main__":
    main()
