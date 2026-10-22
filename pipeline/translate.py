"""Переклад квестів через Claude API (ЗАПАСНИЙ шлях — потребує API-ключ).

ОСНОВНИЙ шлях перекладу в цьому проєкті — слеш-команда /translate у Claude Code:
вона працює через підписку (Max) без API-ключа. Цей скрипт знадобиться, лише
якщо захочете повної автоматизації через console.anthropic.com (платно окремо).

Джерела текстів (об'єднуються, обидва необов'язкові):
  1. data/source/quests.json  — офлайн-витяг із Blizzard API (extract_quests.py):
     англійська (джерело) + німецька/французька (контекст для роду й уточнень).
  2. data/capture.json        — зібране аддоном у грі (parse_capture.py):
     додає objectives/progress/completion, яких немає в API.

Глосарій pipeline/glossary.md вставляється в системний промпт дослівно —
це гарантує дотримання термінологічного стандарту.

Використання:
    set ANTHROPIC_API_KEY=sk-ant-...    (один раз у середовищі)
    python translate.py                 # перекласти до 20 квестів (денна порція)
    python translate.py --limit 5       # менша порція
    python translate.py --quest 84321   # один конкретний квест
"""

import argparse
import json
import sys
from pathlib import Path

import anthropic

from common import DATA_DIR

CAPTURE_PATH = DATA_DIR / "capture.json"
SOURCE_PATH = DATA_DIR / "source" / "quests.json"
TRANSLATIONS_PATH = DATA_DIR / "translations.json"
GLOSSARY_PATH = Path(__file__).resolve().parent / "glossary.md"

MODEL = "claude-opus-4-8"

FIELDS = ["title", "description", "objectives", "progress", "completion"]
CONTEXT_LOCALES = {"de": "німецька", "fr": "французька"}

OUTPUT_SCHEMA = {
    "type": "object",
    "properties": {field: {"type": "string"} for field in FIELDS},
    "required": FIELDS,
    "additionalProperties": False,
}

SYSTEM_TEMPLATE = """\
Ти — професійний локалізатор відеоігор, перекладаєш World of Warcraft: Midnight
з англійської на українську. Перекладаєш тексти квестів: назву, опис, цілі,
текст прогресу і текст завершення.

ГОЛОВНИЙ ПРИНЦИП — ЯКІСТЬ ПОНАД УСЕ. Краще довше подумати і звірити всі
доступні версії, ніж видати швидкий, але неточний чи неприродний переклад.

Вимоги до перекладу:
- Жива, природна українська мова; художній стиль фентезі, не дослівний підрядник.
- Суворо дотримуйся глосарія нижче. Якщо термін є в глосарії — використовуй
  ТІЛЬКИ варіант із глосарія, з урахуванням колонки «Контекст».
- Англійська — канонічний оригінал, але ти НЕ обмежений лише нею. Якщо надано
  німецьку чи французьку версію — ОБОВ'ЯЗКОВО переглянь їх перед перекладом:
  офіційні локалізації часто несуть інформацію, якої в англійській не видно:
  - граматичний рід персонажів (нім. die Magierin = жінка-маг, der Magier = чоловік);
  - число, звертання, тон (фамільярне du / ввічливе Sie тощо);
  - як офіційні перекладачі розв'язали гру слів, ідіому чи неоднозначність.
- Якщо англійський текст неоднозначний або контексту бракує — рішення приймай
  на основі ЗІСТАВЛЕННЯ всіх версій: обирай те прочитання, яке підтверджують
  інші мови і яке дає найточніший та найприродніший український текст.
- Якщо версії суперечать одна одній — пріоритет має зміст англійської,
  але граматичні деталі (рід, число) бери з тієї мови, що їх явно маркує.
- Плейсхолдер {NAME} — ім'я персонажа гравця: залиш його як {NAME} у тих самих
  місцях. Будуй речення так, щоб {NAME} стояло у називному відмінку або у
  звертанні без зміни самого плейсхолдера.
- Зберігай переноси рядків (\\n), кольорові коди (|cFF...|r), числа і відсотки.
- Якщо якесь поле порожнє у вхідних даних — поверни для нього порожній рядок.
- Імена власні, яких немає в глосарії, транслітеруй українською.

{glossary}
"""


def load_json(path: Path, default):
    if path.exists():
        return json.loads(path.read_text(encoding="utf-8-sig"))
    return default


def merge_sources(source: dict, capture: dict, player_name: str | None) -> dict:
    """Об'єднує API-витяг і зібране в грі в один словник джерел.

    Повертає {questID: {"fields": {...en...}, "context": {"de": {...}, "fr": {...}}}}.
    """
    merged: dict[str, dict] = {}

    def slot(quest_id: str) -> dict:
        return merged.setdefault(quest_id, {"fields": {}, "context": {}})

    # 1. Зібране в грі — повний набір полів, але лише англійською.
    for quest_id, entry in capture.get("quests", {}).items():
        s = slot(quest_id)
        for field in FIELDS:
            value = entry.get(field)
            if value:
                if player_name:
                    value = value.replace(player_name, "{NAME}")
                s["fields"][field] = value

    # 2. API-витяг: англійська авторитетніша (без імені персонажа),
    #    інші локалі йдуть у контекст.
    for quest_id, entry in source.items():
        s = slot(quest_id)
        for field, locales in entry.items():
            if locales.get("en"):
                s["fields"][field] = locales["en"]
            for loc in CONTEXT_LOCALES:
                if locales.get(loc):
                    s["context"].setdefault(loc, {})[field] = locales[loc]

    return merged


def build_user_prompt(quest_id: str, entry: dict) -> str:
    lines = [f"Переклади квест #{quest_id}.", "", "=== ОРИГІНАЛ (англійська) ==="]
    for field in FIELDS:
        value = entry["fields"].get(field, "") or ""
        lines.append(f"\n[{field}]\n{value}")

    for loc, loc_name in CONTEXT_LOCALES.items():
        ctx = entry["context"].get(loc)
        if ctx:
            lines.append(f"\n=== ОФІЦІЙНА ЛОКАЛІЗАЦІЯ ({loc_name}) — звір рід, число, тон, "
                         "розв'язання неоднозначностей ===")
            for field, value in ctx.items():
                lines.append(f"\n[{field}]\n{value}")

    return "\n".join(lines)


def main():
    ap = argparse.ArgumentParser(description="Переклад квестів через Claude")
    ap.add_argument("--limit", type=int, default=20, help="максимум квестів за запуск")
    ap.add_argument("--quest", help="перекласти лише цей questID")
    args = ap.parse_args()

    source = load_json(SOURCE_PATH, {})
    capture = load_json(CAPTURE_PATH, {})
    if not source and not capture:
        sys.exit(
            "Немає жодного джерела текстів.\n"
            f"  - {SOURCE_PATH} (запустіть extract_quests.py), або\n"
            f"  - {CAPTURE_PATH} (запустіть parse_capture.py після гри з аддоном)"
        )

    translations = load_json(TRANSLATIONS_PATH, {"quests": {}})
    glossary = GLOSSARY_PATH.read_text(encoding="utf-8-sig")
    system_prompt = SYSTEM_TEMPLATE.format(glossary=glossary)
    player_name = (capture.get("meta") or {}).get("playerName")

    merged = merge_sources(source, capture, player_name)

    if args.quest:
        pending = [args.quest] if args.quest in merged else []
    else:
        pending = [qid for qid in sorted(merged, key=int)
                   if qid not in translations["quests"]]
    pending = pending[: args.limit]

    if not pending:
        print("Нових квестів для перекладу немає.")
        return

    client = anthropic.Anthropic()
    print(f"Перекладаю {len(pending)} квест(ів) моделлю {MODEL}...")

    for n, quest_id in enumerate(pending, 1):
        entry = merged[quest_id]
        title = (entry["fields"].get("title") or "?").strip()
        print(f"  [{n}/{len(pending)}] #{quest_id} — {title} ... ", end="", flush=True)

        response = client.messages.create(
            model=MODEL,
            max_tokens=16000,
            thinking={"type": "adaptive"},
            system=[{
                "type": "text",
                "text": system_prompt,
                "cache_control": {"type": "ephemeral"},
            }],
            messages=[{"role": "user", "content": build_user_prompt(quest_id, entry)}],
            output_config={
                "effort": "max",  # якість понад усе: максимальна глибина міркування
                "format": {"type": "json_schema", "schema": OUTPUT_SCHEMA},
            },
        )

        text = next(b.text for b in response.content if b.type == "text")
        translated = json.loads(text)
        # Порожні поля (їх не було в оригіналі) не зберігаємо.
        translations["quests"][quest_id] = {
            field: value for field, value in translated.items() if value
        }

        # Пишемо після кожного квесту — переривання нічого не втрачає.
        TRANSLATIONS_PATH.parent.mkdir(parents=True, exist_ok=True)
        TRANSLATIONS_PATH.write_text(
            json.dumps(translations, ensure_ascii=False, indent=2), encoding="utf-8"
        )
        usage = response.usage
        print(f"готово (токени: {usage.input_tokens}+{usage.output_tokens})")

    total = len(translations["quests"])
    print(f"\nУсього перекладено квестів: {total}")
    print("Тепер згенеруйте базу аддона: python generate_db.py")


if __name__ == "__main__":
    main()
