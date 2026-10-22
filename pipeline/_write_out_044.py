# -*- coding: utf-8 -*-
import json, collections, io, sys

base = r"G:/Claude Code/WoWUkraine/data/exp_batches"
src = json.load(open(base + "/batch_044.json", encoding="utf-8"))

T = {
 "Ossein Scale Hauberk": "Оссеїновий Лускатий Обладунок",
 "Ossein Scale Headguard": "Оссеїновий Лускатий Наголовник",
 "Ossein Scale Sabatons": "Оссеїнові Лускаті Чоботи",
 "Ossein Scale Spaulders": "Оссеїнові Лускаті Наплічники",
 "Ostentatious Buckle": "Пишна Пряжка",
 "Osteowings of the Necrolords": "Костокрила Некролордів",
 "Otiosen's Regenerative Wristwraps": "Відновлювальні Наручі Отіозена",
 "Otter Soul": "Душа Видри",
 "Oublion Cipher": "Шифр Ублйона",
 "Oversized Centurion Helm": "Завеликий Шолом Центуріона",
 "Owl Soul": "Душа Сови",
 "Owlcat Soul": "Душа Совокота",
 "Oxxein Lockbox": "Окссеїнова Скринька",
 "PH - Banner of the Opportune": "PH - Banner of the Opportune",
 "PH Frequent": "PH Frequent",
 "PH Green Head Candle": "PH Green Head Candle",
 "PH Unusual": "PH Unusual",
 "Package Protector": "Захисник Посилок",
 "Padded Insouls": "Підбиті Душоустілки",
 "Pain Transformation": "Перетворення Болю",
 "Painbringer's Back-Prison": "Спинна Темниця Боленосця",
 "Pallid Sinuous Hide": "Бліда Звивиста Шкіра",
 "Pallid Stitched Gloves": "Бліді Зшиті Рукавички",
 "Pan-Dimensional Packing Cord": "Позавимірний Пакувальний Шнур",
 "Parched Silk Amice": "Збляклий Шовковий Амікт",
 "Parched Silk Cord": "Збляклий Шовковий Пояс",
 "Parched Silk Cowl": "Збляклий Шовковий Каптур",
 "Parched Silk Handwraps": "Збляклі Шовкові Рукавиці",
 "Parched Silk Sandals": "Збляклі Шовкові Сандалі",
 "Parched Silk Shirt": "Зблякла Шовкова Сорочка",
 "Parched Silk Wristwraps": "Збляклі Шовкові Наручі",
 "Partially Digested Encyclopedia": "Частково Перетравлена Енциклопедія",
 "Partially Digested Viscera": "Частково Перетравлені Нутрощі",
 "Partially Finished Stone Sentry": "Недороблений Кам'яний Вартовий",
 "Passably-Forged Credentials": "Стерпно Підроблені Документи",
 "Patterned Wing": "Візерунчасте Крило",
 "Pauldrons of Fatal Finality": "Наплічники Фатальної Невідворотності",
 "Pauldrons of Immaculate Laceration": "Наплічники Бездоганного Шматування",
 "Pauldrons of Possible Afterlives": "Наплічники Можливих Загробних Життів",
 "Pauldrons of Tyrannical Defiance": "Наплічники Тиранічної Непокори",
 "Pauldrons of Unleashed Pride": "Наплічники Розкутої Гордині",
 "Pauldrons of the Infinite Infantry": "Наплічники Незліченної Піхоти",
 "Pauldrons of the Unknown Beyond": "Наплічники Незвіданого Потойбіччя",
 "Peaceful Pocopoc": "Мирний Покопок",
 "Penguin Soul": "Душа Пінгвіна",
 "Pepepec": "Пепепек",
 "Perceptialic Fluidic Spheroid": "Перцептіальний Плинний Сфероїд",
 "Perfectly-Forged Credentials": "Бездоганно Підроблені Документи",
 "Perforated Skull": "Продірявлений Череп",
 "Perforated Veins": "Продірявлені Жили",
 "Periapt of Pristine Preservation": "Амулет Бездоганного Збереження",
 "Perk 24": "Бонус 24",
 "Perk 25": "Бонус 25",
 "Perk 26": "Бонус 26",
 "Perk 27": "Бонус 27",
 "Perk 28": "Бонус 28",
 "Perk 29": "Бонус 29",
 "Perk 30": "Бонус 30",
 "Perverse Champion's Handguards": "Рукавиці Збоченого Чемпіона",
 "Petrified Leaf": "Скам'янілий Листок",
 "Petrified Sylvan Antlers": "Скам'янілі Лісові Роги",
 "Phaedrum Lockbox": "Федрумова Скринька",
 "Phantasma-Forged Striders": "Чоботи, Виковані з Фантазми",
 "Phantasmal Haunch": "Примарний Окіст",
 "Phial of Ravenous Slime": "Фіал Ненаситної Слизі",
 "Phial of Serenity": "Фіал Безтурботності",
 "Phylactery of the Dead Conniver": "Філактерій Мертвого Інтригана",
 "Pickled Meat Smoothie": "Смузі з Маринованого М'яса",
 "Piece of Shredded Scroll": "Клапоть Подертого Сувою",
 "Piercing Verdict": "Пронизливий Вирок",
 "Pig Soul": "Душа Свині",
 "Pink Party Hat": "Рожевий Святковий Ковпак",
 "Pirate Pocopoc": "Піратський Покопок",
 "Piston Assembly": "Поршневий Вузол",
 "Pit Fighter's Wristguards": "Наручі Бійця Ями",
 "Pitted Diaphanous Wing": "Поточене Прозоре Крило",
 "Plague Doctor's Mask": "Маска Чумного Лікаря",
 "Plague Handler's Greathelm": "Дворучний Шолом Чумника",
 "Plague-Licked Amice": "Зачумлений Амікт",
 "Plagueborne Shoulderguards": "Чумороджені Наплічники",
}

# Sanity: every source key must be present, no extras
missing = [k for k in src if k not in T]
extra = [k for k in T if k not in src]
assert not missing, ("MISSING: " + repr(missing))
assert not extra, ("EXTRA: " + repr(extra))

out = collections.OrderedDict()
for k in src:  # preserve source order
    out[k] = {"name": T[k], "flavor": None}

with io.open(base + "/out_044.json", "w", encoding="utf-8") as f:
    f.write("{\n")
    items = list(out.items())
    for i, (k, v) in enumerate(items):
        comma = "," if i < len(items) - 1 else ""
        f.write(" " + json.dumps(k, ensure_ascii=False) + ": " +
                json.dumps(v, ensure_ascii=False) + comma + "\n")
    f.write("}\n")

print("WROTE", len(out), "items to out_044.json")
