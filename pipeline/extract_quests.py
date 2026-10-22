"""Офлайн-витяг текстів квестів із Blizzard Game Data API — гра не потрібна.

Тягне квести КІЛЬКОМА МОВАМИ за один запит (без параметра locale API віддає
всі локалі): англійська — джерело перекладу, німецька/французька — контекст
для уточнення роду і неоднозначних термінів.

Потрібен безкоштовний ключ розробника Battle.net (https://develop.battle.net):
    $env:BLIZZARD_CLIENT_ID = "..."
    $env:BLIZZARD_CLIENT_SECRET = "..."

Використання:
    python extract_quests.py --ids 87000-87200          # діапазон questID
    python extract_quests.py --ids 84321,84322          # перелік
    python extract_quests.py --ids-file midnight_ids.txt
Результат додається в data/source/quests.json (повторні запуски — інкрементальні).
"""

import argparse
import json
import os
import sys
import time
from pathlib import Path

import requests

from common import DATA_DIR

SOURCE_PATH = DATA_DIR / "source" / "quests.json"

OAUTH_URL = "https://oauth.battle.net/token"
API_URL = "https://{region}.api.blizzard.com/data/wow/quest/{quest_id}"
AREA_INDEX_URL = "https://{region}.api.blizzard.com/data/wow/quest/area/index"
AREA_URL = "https://{region}.api.blizzard.com/data/wow/quest/area/{area_id}"

# Зони Midnight для автовідкриття квестів (підрядки назв, без урахування регістру).
# Точні назви зон звіряйте через --list-areas.
MIDNIGHT_AREAS = ["Eversong", "Ghostlands", "Zul'Aman", "Harandar", "Voidstorm", "Silvermoon"]

# Локалі, які зберігаємо: en — джерело, de/fr — контекст для перекладача.
LOCALES = {"en_US": "en", "de_DE": "de", "fr_FR": "fr"}

# Поля відповіді API з локалізованим текстом, які нас цікавлять.
TEXT_FIELDS = ["title", "description"]


def get_token() -> str:
    client_id = os.environ.get("BLIZZARD_CLIENT_ID")
    client_secret = os.environ.get("BLIZZARD_CLIENT_SECRET")
    if not client_id or not client_secret:
        sys.exit(
            "Задайте BLIZZARD_CLIENT_ID і BLIZZARD_CLIENT_SECRET.\n"
            "Ключ створюється безкоштовно: https://develop.battle.net -> Create Client."
        )
    resp = requests.post(
        OAUTH_URL,
        data={"grant_type": "client_credentials"},
        auth=(client_id, client_secret),
        timeout=30,
    )
    resp.raise_for_status()
    return resp.json()["access_token"]


def parse_ids(spec: str) -> list[int]:
    ids: list[int] = []
    for part in spec.split(","):
        part = part.strip()
        if "-" in part:
            lo, hi = part.split("-", 1)
            ids.extend(range(int(lo), int(hi) + 1))
        elif part:
            ids.append(int(part))
    return ids


def pick_locales(value) -> dict | None:
    """Зводить локалізоване поле API до {en: ..., de: ..., fr: ...}."""
    if isinstance(value, str):  # на випадок, якщо API віддав одну локаль
        return {"en": value}
    if isinstance(value, dict):
        out = {short: value[full] for full, short in LOCALES.items() if value.get(full)}
        return out or None
    return None


def fetch_quest(session: requests.Session, region: str, quest_id: int, token: str) -> dict | None:
    resp = None
    for attempt in range(6):  # мережеві обриви на довгих прогонах — норма
        try:
            resp = session.get(
                API_URL.format(region=region, quest_id=quest_id),
                params={"namespace": f"static-{region}"},
                headers={"Authorization": f"Bearer {token}"},
                timeout=30,
            )
            break
        except requests.exceptions.RequestException as e:
            wait = 2 ** attempt
            print(f"  ! #{quest_id}: {type(e).__name__}, повтор через {wait}с")
            time.sleep(wait)
    else:
        print(f"  ! #{quest_id}: пропускаю після 6 невдалих спроб")
        return None
    if resp.status_code == 404:
        return None
    if resp.status_code == 429:
        time.sleep(2)
        return fetch_quest(session, region, quest_id, token)
    if resp.status_code >= 500:  # серверна помилка на одному ID — пропускаємо
        print(f"  ! #{quest_id}: HTTP {resp.status_code}, пропускаю")
        return None
    resp.raise_for_status()
    data = resp.json()

    entry = {}
    for field in TEXT_FIELDS:
        locales = pick_locales(data.get(field))
        if locales:
            entry[field] = locales
    return entry or None


def api_get(session: requests.Session, url: str, region: str, token: str) -> dict:
    resp = session.get(
        url,
        params={"namespace": f"static-{region}"},
        headers={"Authorization": f"Bearer {token}"},
        timeout=30,
    )
    resp.raise_for_status()
    return resp.json()


def area_name_en(area: dict) -> str:
    name = area.get("name")
    if isinstance(name, dict):
        return name.get("en_US") or next(iter(name.values()), "")
    return name or ""


def list_areas(session: requests.Session, region: str, token: str) -> list[dict]:
    index = api_get(session, AREA_INDEX_URL.format(region=region), region, token)
    return index.get("areas", [])


def fetch_area_quests(session: requests.Session, region: str, token: str,
                      area_id: int, area_name: str = "") -> list[int]:
    detail = api_get(
        session, AREA_URL.format(region=region, area_id=area_id), region, token)
    quests = [q["id"] for q in detail.get("quests", [])]
    print(f"  Зона «{area_name or area_id}» (id {area_id}): {len(quests)} квест(ів)")
    return quests


def discover_area_ids(session: requests.Session, region: str, token: str,
                      patterns: list[str]) -> list[int]:
    """Знаходить questID за назвами зон (через індекс /quest/area)."""
    ids: list[int] = []
    lowered = [p.lower() for p in patterns]
    for area in list_areas(session, region, token):
        name = area_name_en(area)
        if not any(p in name.lower() for p in lowered):
            continue
        ids.extend(fetch_area_quests(session, region, token, area["id"], name))
        time.sleep(0.05)
    return ids


def main():
    ap = argparse.ArgumentParser(description="Витяг квестів із Blizzard API")
    ap.add_argument("--ids", help="діапазони/перелік questID: 87000-87200,84321")
    ap.add_argument("--ids-file", help="файл із questID, по одному на рядок")
    ap.add_argument("--midnight", action="store_true",
                    help="автовідкриття: всі квести зон Midnight (через індекс зон)")
    ap.add_argument("--areas", help="квести зон за назвами (підрядки через кому)")
    ap.add_argument("--area-ids", help="квести зон за точними areaID через кому "
                                       "(щоб відрізнити нові версії зон від старих)")
    ap.add_argument("--list-areas", action="store_true",
                    help="показати всі зони з індексу і вийти")
    ap.add_argument("--region", default="eu", choices=["eu", "us"])
    ap.add_argument("--force", action="store_true", help="перезавантажити вже наявні")
    args = ap.parse_args()

    ids: list[int] = []
    if args.ids:
        ids.extend(parse_ids(args.ids))
    if args.ids_file:
        for line in Path(args.ids_file).read_text(encoding="utf-8-sig").splitlines():
            line = line.strip()
            if line and not line.startswith("#"):
                ids.append(int(line))

    needs_api = args.list_areas or args.midnight or args.areas or args.area_ids
    if needs_api:
        token = get_token()
        session = requests.Session()
        if args.list_areas:
            for area in list_areas(session, args.region, token):
                print(f"{area['id']:>6}  {area_name_en(area)}")
            return
        if args.area_ids:
            for area_id in parse_ids(args.area_ids):
                ids.extend(fetch_area_quests(session, args.region, token, area_id))
                time.sleep(0.05)
        if args.midnight or args.areas:
            patterns = MIDNIGHT_AREAS if args.midnight else \
                [p.strip() for p in args.areas.split(",") if p.strip()]
            print(f"Шукаю зони за назвами: {', '.join(patterns)}")
            ids.extend(discover_area_ids(session, args.region, token, patterns))

    if not ids:
        sys.exit("Вкажіть --midnight, --areas, --ids або --ids-file.\n"
                 "Приклади: --midnight | --areas \"Harandar\" | --ids 87000-87200")
    ids = sorted(set(ids))

    source = {}
    if SOURCE_PATH.exists():
        source = json.loads(SOURCE_PATH.read_text(encoding="utf-8-sig"))
    if not args.force:
        # Пропускаємо лише ті, де ОПИС уже є: наявність запису з wago
        # (title/objectives) — не привід не добрати description із Blizzard API.
        ids = [qid for qid in ids if "description" not in source.get(str(qid), {})]
    if not ids:
        print("Усі вказані квести вже мають описи (додайте --force, щоб оновити).")
        return

    token = get_token()
    session = requests.Session()
    found, missing = 0, 0

    print(f"Запитую {len(ids)} квест(ів) із регіону {args.region}...")
    for n, quest_id in enumerate(ids, 1):
        entry = fetch_quest(session, args.region, quest_id, token)
        if entry:
            # Зливаємо по полях — не затираємо title/objectives із wago.
            slot = source.setdefault(str(quest_id), {})
            for field, locales in entry.items():
                slot.setdefault(field, {}).update(locales)
            found += 1
            title = entry.get("title", {}).get("en", "?")
            print(f"  [{n}/{len(ids)}] #{quest_id} {title}")
        else:
            missing += 1
        if found and found % 50 == 0:
            SOURCE_PATH.parent.mkdir(parents=True, exist_ok=True)
            SOURCE_PATH.write_text(
                json.dumps(source, ensure_ascii=False, indent=2), encoding="utf-8")
        time.sleep(0.05)  # ввічливий темп: ~20 запитів/с, ліміт Blizzard — 100/с

    SOURCE_PATH.parent.mkdir(parents=True, exist_ok=True)
    SOURCE_PATH.write_text(json.dumps(source, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"\nЗнайдено: {found}, не існує: {missing}. Усього в базі джерел: {len(source)}")
    print(f"-> {SOURCE_PATH}")


if __name__ == "__main__":
    main()
