# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding="utf-8")
tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
js = tr["journalSections"]
M = {
 "Erkhart Stormvein": "Еркгарт Стормвейн", "Eternity's Ebb and Flow": "Відплив і приплив Вічності",
 "Familiar Face": "Знайоме обличчя", "Forces of the Alliance": "Сили Альянсу",
 "Forces of the Horde": "Сили Орди", "Gashtooth": "Ґаштут", "Granyth": "Ґраніт",
 "Grommash Hellscream": "Ґромаш Хеллскрім", "Hardened Crystal": "Загартований кристал",
 "Horde Axe Thrower": "Ординський метальник сокир", "Horde Grunt": "Ординський піхотинець",
 "Horde Warlock": "Ординський чорнокнижник", "Infinite Keeper": "Нескінченний хранитель",
 "Infused Whelp": "Наповнене драконятко", "Intermission: Stormwinds": "Перепочинок: Штормові вітри",
 "Kyrakka": "Кіракка", "Longboat Raid!": "Рейд драккара!", "Loszkeleth": "Лоскелет",
 "Magical Implements": "Магічне знаряддя", "Olaf": "Олаф", "Teera": "Тіра",
}
for en, ua in M.items():
    js[en] = ua
json.dump(tr, open("data/translations.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("міток додано:", len(M))
