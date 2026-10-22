# Провенанс перекладу (яким рушієм що перекладено)

Мета — знати, **чим** перекладено кожен квест, щоб потім оцінити якість
(Fable vs Opus) і за потреби переробити слабші місця.

## Реєстр
`data/translation_provenance.json` — `{questID: "fable" | "opus"}`.

- **fable** — усе, що було перекладено до Opus-добивання (знімок від 2026-07-23,
  8383 квести). Переважно серверні поля квестів Midnight/DF/TWW + старі ери
  WoD/MoP/Legion/Classic-партія1, зроблені Fable-агентами.
- **opus** — «добивання» решти (Shadowlands, BfA, Classic-партії 2–8) моделлю
  Opus 4.8, коли ліміт Fable майже вичерпався.

## Як ведеться
Merge-скрипт старих ер (`scratchpad/old_merge.py`) приймає `MODEL` і при вливанні
записує `questID → MODEL` у реєстр. Тому кожна нова Opus-партія автоматично
позначається.

## Для рев'ю якості
Порівнювати вибірку Opus-квестів проти Fable-квестів тієї ж ери/типу:
```
python -c "import json;p=json.load(open('data/translation_provenance.json'));
from collections import Counter;print(Counter(p.values()))"
```
Слабкі Opus-місця → перекласти повторно Fable (коли оновиться ліміт) або
відредагувати вручну.
