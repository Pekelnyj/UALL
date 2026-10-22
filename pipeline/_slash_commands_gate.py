# -*- coding: utf-8 -*-
"""ГЕЙТ: слеш-команди не перекладаються.

Гравець набирає команду сам, і гра розуміє лише англійську: «/bow», не «/уклін».
07.10.2026 у майстрі знайшлося пів сотні описів Торгового поста з перекладеними
командами («Уклонися (/уклін)…», «/Погладь Мара», «/реверанс»). Правильно — дію
українською, команду як в оригіналі: «Уклонися (/bow)…», «Покажи емоцію /wave …».

Падає (код 1), якщо в перекладі є «/» + кирилиця там, де в оригіналі є англійська
слеш-команда. Дати й дроби («3/9», «з/без») не чіпає: перед «/» там стоїть символ слова.
Перенесено з проєкту Forever (правило 9b docs/ХУКИ.md).

Запуск: python pipeline/_slash_commands_gate.py
"""
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

EN_COMMAND = re.compile(r"(?<![\w/:])/[A-Za-z]{2,}")
UA_COMMAND = re.compile(r"(?<![\w/])/[А-Яа-яІіЇїЄєҐґ']{2,}")


def main():
    data = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8"))
    bad = []
    for section, entries in data.items():
        if not isinstance(entries, dict):
            continue
        for en, value in entries.items():
            ua = value.get("ua") if isinstance(value, dict) else value
            if not (isinstance(en, str) and isinstance(ua, str)) or not EN_COMMAND.search(en):
                continue
            found = UA_COMMAND.findall(ua)
            if found:
                bad.append((section, en, ", ".join(found)))
    for section, en, found in bad:
        print(f"ПЕРЕКЛАДЕНА КОМАНДА [{section}] {en[:80]!r}: {found}")
    if bad:
        print(f"Усього: {len(bad)}. Команду лишити англійською, дію — українською: «Уклонися (/bow)».")
        sys.exit(1)
    print("OK: слеш-команди в перекладах не перекладено")


if __name__ == "__main__":
    main()
