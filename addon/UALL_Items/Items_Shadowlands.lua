-- WoWUkraine: предмети (Shadowlands) — LoadOnDemand.
-- WoWUkraine: предмети (LoadOnDemand). Автоген pipeline/generate_db.py — не редагуйте.
-- Вантажиться головним аддоном лише коли увімкнено опції items.*. ns — спільний глобал.
local ns = _G.WoWUkraineNS
if not ns then return end
ns.items = ns.items or {}
local t = ns.items
local function add(f) f(t) end
add(function(t)
    t[153408] = "Ікло Морської Потвори"
    t[153409] = "Щаслива Коса"
    t[153410] = "Мерехтлива Руна"
    t[153411] = "Скам'яніла Луска Василіска"
    t[153412] = "Погодний Журнал Океанографа"
    t[153413] = "Підзорна Труба Корсара"
    t[154979] = "Ікло Морської Потвори"
    t[154980] = "Щаслива Коса"
    t[154981] = "Мерехтлива Руна"
    t[154982] = "Скам'яніла Луска Василіска"
    t[154983] = "Самоцвіт Золотого Міста"
    t[154984] = "Зачарований Кіготь Дияволозавра"
    t[155876] = "Заплямована Сторінка Щоденника"
    t[158931] = "Екто-вимірний Протонний Промінь"
    t[158932] = { name = "Найтаємніша Риба", fen = "A very elusive fish", fua = "Дуже невловна риба." }
    t[168035] = "Збруя Утробопацюка"
    t[168208] = "Осяйна Скриня"
    t[168209] = "Осяйна Скриня: Олберік"
    t[168210] = "Осяйна Скриня: Азрафаель"
    t[168211] = "Осяйна Скриня: Бенефікус"
    t[168410] = "Аптечка"
    t[168583] = { name = "Вдовоцвіт", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням Травознавства. Можна купувати й продавати на аукціоні." }
    t[168586] = { name = "Світанкова слава", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням Травознавства. Можна купувати й продавати на аукціоні." }
    t[168589] = { name = "Костокорінь", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням Травознавства. Можна купувати й продавати на аукціоні." }
    t[168591] = "Пелюстка Кісткокореня"
    t[169550] = "Пелюстка Світанкової Слави"
    t[169697] = { name = "Пелюстка Беладони", fen = "This herb requires a special knowledge to harvest correctly.", fua = "Щоб правильно зібрати цю траву, потрібні особливі знання." }
    t[169698] = "Пелюстка Вдовоцвіту"
    t[169699] = "Пелюстка Смолоскипної Рослини Чувань"
    t[169700] = "Пелюстка Смертоцвіту"
    t[169701] = { name = "Смертоцвіт", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням Травознавства. Можна купувати й продавати на аукціоні." }
    t[169819] = { name = "Жменя Кривавих Скалок", fen = "A favored reagent of the Quilboar, used in their foul rituals.", fua = "Улюблений реагент кабанолюдів, який вони використовують у своїх мерзенних ритуалах." }
    t[169821] = { name = "Огряча Статуетка", fen = "This stone figurine has the letters \"DAGG\" carved on the bottom of it.", fua = "На нижній частині цієї кам'яної фігурки вирізьблено літери \"DAGG\"." }
    t[169822] = "Спадаючий Плащ"
    t[169823] = { name = "Монета Лордерона", fen = "These coins are rare to find after the human city of Lordaeron fell to the Forsaken. Some believe they are an ill omen. Others don't pay any attention and sell them to collectors.", fua = "Ці монети стали рідкістю відтоді, як людське місто Лордерон перейшло до Відступників. Дехто вважає їх лихим знаком. Інші ж не зважають на це й продають їх колекціонерам." }
    t[170053] = { name = "Ікло Грек'оґа", fen = "Grek'og's tusk broke off when it beseeched the dragon for power. Maybe someone would buy it?", fua = "Ікло Грек'оґа відламалося, коли він благав дракона про силу. Може, хтось його купить?" }
    t[170463] = { name = "Ключ Від Вежі Тюремника", fen = "Grants entry to Torghast, Tower of the Damned.", fua = "Дає доступ до Торгаста, Вежі Проклятих." }
    t[170479] = { name = "Ключ Від Ліфта: Рівень 5", fen = "Temporary Implementation!", fua = "Temporary Implementation!" }
    t[170480] = { name = "Ключ Від Ліфта: Рівень 10", fen = "Temporary Implementation!", fua = "Temporary Implementation!" }
    t[170481] = { name = "Ключ Від Ліфта: Рівень 15", fen = "Temporary Implementation!", fua = "Temporary Implementation!" }
    t[170482] = { name = "Ключ Від Ліфта: Рівень 20", fen = "Temporary Implementation!", fua = "Temporary Implementation!" }
    t[170498] = "Збруя Мертводушного Гончака"
    t[170499] = "Збруя Шукача Пащі"
    t[170550] = { name = "Священний Сувій", fen = "Part of a series detailing a powerful rite of humility.", fua = "Частина серії, що описує могутній обряд смирення." }
    t[170551] = { name = "Світло Бастіону", fen = "A shining light to guide your soul home, no matter where you are.", fua = "Сяйне світло, що веде вашу душу додому, де б ви не були." }
    t[170552] = { name = "Некротичний Фетиш", fen = "This fetish has necrotic energy oozing from it. Best to keep it in a sealed bag.", fua = "З цього фетиша сочиться некротична енергія. Найкраще тримати його в герметичній торбі." }
    t[170554] = { name = "Смолоскип Чувань", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням Травознавства. Можна купувати й продавати на аукціоні." }
    t[170557] = "Перерозмірювач v9.0.1"
    t[170585] = { name = "Виснажене Ядро Аніми", fen = "Unfortunately, it seems like al of the anima has been drained out.", fua = "На жаль, схоже, всю аніму було витягнуто." }
    t[171100] = { name = "Прихований Уламок Гріховного Каменя", fen = "Many arrogant sins are listed.", fua = "Тут перелічено багато гордовитих гріхів." }
    t[171101] = { name = "Прихований Уламок Гріховного Каменя", fen = "Many selfish sins are listed.", fua = "Тут перелічено багато гріхів себелюбства." }
    t[171102] = { name = "Прихований Уламок Гріховного Каменя", fen = "Many deceptive sins are listed.", fua = "Тут перелічено багато підступних гріхів." }
    t[171103] = "Камені Гріха Інквізиторів"
    t[171104] = { name = "Гріховний Камінь Обвинувачки", fen = "The list of sins is extraordinarily long and detailed, but every sin is crossed out.", fua = "Перелік гріхів надзвичайно довгий і докладний, але кожен гріх викреслено." }
    t[171105] = { name = "Некротична Скалка", fen = "This shard pulses with weak necrotic energies.", fua = "Ця скалка пульсує слабкою некротичною енергією." }
    t[171106] = "Зібрані Некротичні Скалки"
    t[171146] = { name = "Некротичний Захист Від Смерті", fen = "A deadly combination of Fearstalker artifacts. Can call upon the ruins of dredcovia to strike against your enemies.", fua = "Смертоносне поєднання артефактів ловця страху. Може закликати руїни Дредковії, щоб уразити ваших ворогів." }
    t[171204] = "Голова Зрадника"
    t[171205] = { name = "Розрубувач Ворогів", fen = "A rather unimpressive sword, all things considered. Disappointing.", fua = "Як не глянь, доволі непримітний меч. Прикро." }
    t[171206] = { name = "Забута Зброя", fen = "An old weapon that still has some value.", fua = "Стара зброя, що все ще має певну цінність." }
    t[171209] = { name = "Закривавлена Торбина", fen = "Contains meat and bone from the Shadowlands.", fua = "Містить м'ясо й кістки зі Світу Тіней." }
    t[171210] = { name = "Торбина Дарів Природи", fen = "Contains fish and herbs from the Shadowlands.", fua = "Містить рибу й трави зі Світу Тіней." }
    t[171211] = { name = "Гаманець Вентира", fen = "Contains gold and gems from the Shadowlands.", fua = "Містить золото й самоцвіти зі Світу Тіней." }
    t[171215] = { name = "Темна Проповідь", fen = "A compilation of the values and goals of the Forsworn.", fua = "Збірка цінностей та цілей Зреченців." }
    t[171249] = { name = "Ключ від Клітки Душ", fen = "Unlocks a Soul Cage.", fua = "Відмикає Клітку Душ." }
    t[171263] = "Зілля Чистоти Душі"
    t[171264] = "Зілля Затьмареного Зору"
    t[171265] = "REUSE ME"
    t[171266] = "Зілля Прихованого Духа"
    t[171267] = "Духовне Зілля Зцілення"
    t[171268] = "Духовне Зілля Мани"
    t[171269] = "Духовне Зілля Відродження"
    t[171270] = "Зілля Спектральної Спритності"
    t[171271] = "Зілля Затверділих Тіней"
    t[171272] = "Зілля Духовної Ясності"
    t[171273] = "Зілля Спектрального Інтелекту"
    t[171274] = "Зілля Спектральної Витривалості"
    t[171275] = "Зілля Спектральної Сили"
    t[171276] = "Примарна Настоянка Сили"
    t[171278] = "Примарна Настоянка Витривалості"
    t[171279] = "[DNT] Spiritual Strength Flask"
    t[171280] = "Вічна Настоянка"
    t[171281] = "Вічний Казан"
    t[171282] = "Вічний Казан"
    t[171283] = "Вічний Казан"
    t[171284] = "Вічний Казан"
    t[171285] = "Олія Тіньового Ядра"
    t[171286] = "Олія Бальзамувальника"
    t[171287] = "Мелений Смертоцвіт"
    t[171288] = "Мелений Смолоскип Чувань"
    t[171289] = "Мелений Вдовоцвіт"
    t[171290] = "Мелений Мозкокорінь"
    t[171291] = "Мелена Світанкова Слава"
    t[171292] = "Мелений Паслін"
    t[171301] = "Духовна Протиотрута"
    t[171310] = { name = "Перстень Кам'яного Керування", fen = "Used by the stonekeepers of Revendreth to wake Inert Stonestalkers.", fua = "Використовується кам'яними хранителями Ревендрету, щоб пробуджувати Нерухомих Кам'яних Переслідувачів." }
    t[171315] = { name = "Беладона", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням Травознавства. Можна купувати й продавати на аукціоні." }
    t[171323] = { name = "Духовний Алхімічний Камінь", fen = "Can be used for transmutations in place of a Philosopher's Stone.", fua = "Можна використовувати для трансмутацій замість Філософського Каменя." }
    t[171343] = { name = "Чистий Пергамент", fen = "Rescued from a fate of bearing tedious and verbose research notes.", fua = "Врятований від долі носити нудні й багатослівні дослідницькі нотатки." }
    t[171344] = { name = "Каліграфічний Набір Вентирів", fen = "No venthyr document is official until it's excessively ornate.", fua = "Жоден документ вентирів не вважається офіційним, доки не стане надмірно оздобленим." }
    t[171345] = { name = "Підроблений Лист Засудження", fen = "You had to make a few guesses at the formatting and wording, but it looks pretty convincing to you.", fua = "Тобі довелося дещо вгадати щодо оформлення й формулювань, але виглядає доволі переконливо." }
    t[171346] = { name = "Листи з Міста", fen = "Filled with gossip among nobles and rumors of the rebellion.", fua = "Сповнені пліток серед знаті й чуток про повстання." }
    t[171349] = "Зілля Примарного Вогню"
    t[171350] = "Зілля Божественного Пробудження"
    t[171351] = "Зілля Смертельної Фіксації"
    t[171352] = "Зілля Посилених Екзорцизмів"
    t[171367] = { name = "Тональний Молот", fen = "A magical implement of harmony for the ancient bells of Bastion.", fua = "Магічне знаряддя гармонії для прадавніх дзвонів Бастіону." }
    t[171368] = { name = "Бездоганно Звучний Сплав", fen = "Produces a clear, sweet tone when struck.", fua = "Видає чистий, приємний звук, коли по ньому вдарити." }
    t[171369] = { name = "Співуче Дерево", fen = "Part of a plant known for the soft music it creates when stirred by the wind.", fua = "Частина рослини, відомої ніжною музикою, яку вона творить, коли її колише вітер." }
    t[171370] = "Зілля Примарної Прудкості"
    t[171373] = { name = "Самопізнання", fen = "This spear is more than a weapon. It possesses the ability to cut to the core of a soul, exposing deeply held memories and emotions.", fua = "Цей спис — більше, ніж зброя. Він здатен врізатися в саму глибину душі, оголюючи приховані спогади та емоції." }
    t[171374] = "Церемоніальний Нагрудник"
    t[171375] = "Церемоніальні Чоботи"
    t[171376] = "Церемоніальні Латні Рукавиці"
    t[171377] = "Церемоніальний Шолом"
    t[171378] = "Урочисті Поножі"
    t[171379] = "Церемоніальні Наплічники"
    t[171380] = "Церемоніальний Пояс"
    t[171381] = "Церемоніальні Наручі"
    t[171382] = "Церемоніальна Рапіра"
    t[171383] = "Церемоніальний Клеймор"
    t[171384] = "Церемоніальний Трощитель"
    t[171385] = "Церемоніальна Заточка"
    t[171386] = "Церемоніальний Спис"
    t[171387] = "Церемоніальна Булава"
    t[171388] = "Церемоніальна Сокира"
    t[171389] = "Церемоніальна Коса"
    t[171390] = "Церемоніальний Клинок"
    t[171391] = "Церемоніальний Щит"
    t[171392] = "Церемоніальна Бойова Глефа"
    t[171412] = { name = "Нагрудник Тіньожаху", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[171413] = { name = "Чоботи Тіньожаху", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[171414] = { name = "Латні Рукавиці Тіньожаху", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[171415] = { name = "Шолом Тіньожаху", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[171416] = { name = "Поножі Тіньожаху", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[171417] = { name = "Наплічники Тіньожаху", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[171418] = { name = "Пояс Тіньожаху", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[171419] = { name = "Наручі Тіньожаху", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[171428] = { name = "Злиток Тіньожаху", fen = "Can be bought and sold on the auction house.", fua = "Можна купити та продати на аукціоні." }
    t[171430] = "Реагент Ковальства 03"
    t[171431] = "Реагент Ковальства 04"
    t[171432] = "Реагент Ковальства 05"
    t[171433] = "Реагент Ковальства 06"
    t[171434] = "Реагент Ковальства 07"
    t[171435] = "Реагент Ковальства 08"
    t[171436] = "Пористий Точильний Камінь"
    t[171437] = "Затьмарений Точильний Камінь"
    t[171438] = "Пористий Важільний Камінь"
    t[171439] = "Затьмарений Обважнювальний Камінь"
    t[171440] = { name = "Ключ від Дверей Торгаста", fen = "Opens a door on this floor of Torghast.", fua = "Відчиняє двері на цьому поверсі Торгаста." }
    t[171441] = "Лестритова Відмичка"
    t[171442] = "Нагрудник із Тіньосталі"
    t[171443] = "Чоботи з Тіньосталі"
    t[171444] = "Латні Рукавиці з Тіньосталі"
    t[171445] = "Шолом із Тіньосталі"
    t[171446] = "Поножі Тіньової Криці"
    t[171447] = "Наплічники з Тіньосталі"
    t[171448] = "Пояс із Тіньосталі"
    t[171449] = "Наручі з Тіньосталі"
    t[171468] = "Величний Клапоть Тканини"
    t[171469] = "Обвуглена Дошка"
    t[171828] = { name = "Руда Лестриту", fen = "Gathered by players with the Mining skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням гірничої справи. Можна купити та продати на аукціоні." }
    t[171829] = { name = "Руда Соленію", fen = "Gathered by players with the Mining skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням гірничої справи. Можна купити та продати на аукціоні." }
    t[171830] = { name = "Руда Оксеїну", fen = "Gathered by players with the Mining skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням гірничої справи. Можна купити та продати на аукціоні." }
    t[171831] = { name = "Руда Федруму", fen = "Gathered by players with the Mining skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням гірничої справи. Можна купити та продати на аукціоні." }
    t[171832] = { name = "Руда Сінвіру", fen = "Gathered by players with the Mining skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням гірничої справи. Можна купити та продати на аукціоні." }
    t[171833] = { name = "Руда Елетію", fen = "Gathered by players with the Mining skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням гірничої справи. Можна купити та продати на аукціоні." }
    t[171834] = { name = "Самородок Лестриту", fen = "Gathered by players with the Mining skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням гірничої справи. Можна купити та продати на аукціоні." }
    t[171835] = { name = "Самородок Соленію", fen = "Gathered by players with the Mining skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням гірничої справи. Можна купити та продати на аукціоні." }
    t[171836] = { name = "Самородок Оксеїну", fen = "Gathered by players with the Mining skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням гірничої справи. Можна купити та продати на аукціоні." }
    t[171837] = { name = "Самородок Федруму", fen = "Gathered by players with the Mining skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням гірничої справи. Можна купити та продати на аукціоні." }
    t[171838] = { name = "Самородок Сінвіру", fen = "Gathered by players with the Mining skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням гірничої справи. Можна купити та продати на аукціоні." }
    t[171839] = { name = "Самородок Елетію", fen = "Gathered by players with the Mining skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням гірничої справи. Можна купити та продати на аукціоні." }
    t[171840] = { name = "Пористий Камінь", fen = "Gathered by players with the Mining skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням гірничої справи. Можна купити та продати на аукціоні." }
    t[171841] = { name = "Затінений Камінь", fen = "Gathered by players with the Mining skill. Can be bought and sold on the auction house.", fua = "Збирається гравцями з умінням гірничої справи. Можна купити та продати на аукціоні." }
    t[171948] = "Попіл Душ"
    t[171961] = { name = "Очисний Дзвіночок", fen = "A handheld bell meant for private rituals.", fua = "Ручний дзвіночок для приватних ритуалів." }
    t[171963] = "Гніздо Стійкої Іскри"
    t[171966] = { name = "Самоцвіт Пут", fen = "A powerful catalyst used to form dredger brutes.", fua = "Потужний каталізатор, який використовують для створення землекопів-горлорізів." }
    t[171967] = { name = "Темний Каптур", fen = "A cowl that may have once been another color, but is now a dark brown. It's mostly intact, with worn edges and it smells of things better left unmentioned.", fua = "Каптур, що колись, можливо, був іншого кольору, але тепер темно-брунатний. Він майже цілий, із потертими краями, і пахне тим, про що краще не згадувати." }
    t[171969] = { name = "Непримітна Роба", fen = "A dark cloth robe that is covered in dirt and other unknown substances. These common robes have all their identifying colors and insigna removed.", fua = "Темна полотняна роба, вкрита брудом та іншими невідомими речовинами. З цих простих роб усунули всі впізнавані кольори та відзнаки." }
    t[171989] = { name = "Мішечок зі Спорами", fen = "Do not inhale.", fua = "Не вдихати." }
    t[171990] = "Дрімотний Мальдрацит"
    t[171991] = { name = "Невигадлива Зброя", fen = "A weapon of standard make.", fua = "Зброя стандартного виготовлення." }
    t[172020] = { name = "Побита Зброя", fen = "While full of nicks and dents, this weapon seems to be in good enough condition to fight with.", fua = "Хоч і вся в подряпинах та вм'ятинах, ця зброя в достатньо доброму стані, щоб нею битися." }
    t[172036] = { name = "Слинявий М'ячик Кали", fen = "It's still a bit damp. Mesmerizing for larion of any age.", fua = "Він і досі трохи вологий. Зачаровує ларіонів будь-якого віку." }
    t[172037] = { name = "Пан Міканікос", fen = "The squeaker was torn out eons ago but he's still very helpful. Named after Kala's favorite steward.", fua = "Пищик вирвали ще цілу вічність тому, та він і досі дуже стає у пригоді. Названий на честь улюбленого розпорядника Кали." }
    t[172038] = "Похмурі Залізні Кайдани"
    t[172039] = { name = "Затишна М'яка Подушка", fen = "Kala's had it since she was a cub and can't sleep without it.", fua = "Кала має її, відколи була малятком, і без неї не може заснути." }
    t[172040] = "Реберця Мариновані В Карамелі"
    t[172041] = "Суфле З Колючопера З Картоплею Фрі"
    t[172042] = "Напрочуд Смачний Бенкет"
    t[172043] = "Бенкет Ненажерливого Гедонізму"
    t[172044] = "Рагу з Костурбана з Корицею"
    t[172045] = "Тіньове Реберне Каре в Желе"
    t[172046] = "Печиво та Ікра"
    t[172047] = "Тістечка З Цукрованої Жовтохвостки"
    t[172048] = "М'ясні Яблучні Вареники"
    t[172049] = "Райдужні Равіолі З Яблучним Соусом"
    t[172050] = "Солодкі Ковбаски Срібнозябрих"
    t[172051] = "Стейк а-ля Мод"
    t[172052] = "Ефірне М'ясо"
    t[172053] = "Тіньові Реберця"
    t[172054] = "Сире Серафічне Крило"
    t[172055] = "Примарний Окіст"
    t[172056] = "Суміш Транспланарних Прянощів"
    t[172057] = "Неймовірно Витриманий Оцет"
    t[172058] = "Контрабандна Городина з Азероту"
    t[172059] = "Жирне Молоко Травоїда"
    t[172060] = "Тихі Хорти"
    t[172061] = "Крила Серафима"
    t[172062] = { name = "Тушкована Рулька", fen = "Spicy!", fua = "Гостро!" }
    t[172063] = "Смажена Кістяна Риба"
    t[172064] = "zzOldArdenweald Zonewich"
    t[172068] = "Смузі з Маринованого М'яса"
    t[172069] = "Банановий Пудинг із Яловичиною"
    t[172074] = { name = "Пожитки Лорана", fen = "A light satchel filled with various items.", fua = "Легка торбина, наповнена різноманітними речами." }
    t[172084] = "Грибний Маяк"
    t[172085] = { name = "Уламок Дзеркала", fen = "A small piece of reflective glass with jagged, sharp edges.", fua = "Маленький шматок дзеркального скла із зазубреними, гострими краями." }
    t[172086] = { name = "Уламок Дзеркала", fen = "A small piece of reflective glass with jagged, sharp edges.", fua = "Маленький шматок дзеркального скла із зазубреними, гострими краями." }
    t[172087] = { name = "Уламок Дзеркала", fen = "A small piece of reflective glass with jagged, sharp edges.", fua = "Маленький шматок дзеркального скла із зазубреними, гострими краями." }
    t[172089] = { name = "Спустошена Шкіра", fen = "Gathered by players with the Skinning skill.", fua = "Збирається гравцями з умінням Білування." }
    t[172092] = { name = "Бліда Кістка", fen = "Gathered by players with the Skinning skill.", fua = "Збирається гравцями з умінням Білування." }
    t[172093] = { name = "Клапті Спустошеної Шкіри", fen = "Used by players with the Leatherworking skill to create Desolate Leather.", fua = "Використовуються гравцями з умінням Шкіряної справи для створення Спустошеної Шкіри." }
    t[172094] = { name = "Загрубіла Шкіра", fen = "Gathered by players with the Skinning skill.", fua = "Збирається гравцями з умінням Білування." }
    t[172095] = { name = "Клапті Загрубілої Шкіри", fen = "Used by players with the Leatherworking skill to create Callous Hide.", fua = "Використовуються гравцями з умінням Шкіряної справи для створення Загрубілої Шкіри." }
    t[172096] = { name = "Важка Спустошена Шкіра", fen = "Gathered by players with the Skinning skill.", fua = "Збирається гравцями з умінням Білування." }
    t[172097] = { name = "Важка Загрубіла Шкіра", fen = "Gathered by players with the Skinning skill.", fua = "Збирається гравцями з умінням Білування." }
    t[172141] = { name = "Заспокійливий Ціпок Корінни", fen = "You sense an ancient and vast power within. Perhaps with the guidance of Korinna's memory, Zosime will be able to eventually restore tranquility to the gardens.", fua = "Ви відчуваєте всередині прадавню й безмежну силу. Можливо, за вказівкою пам'яті Корінни Зосіме зрештою зможе повернути садам спокій." }
    t[172205] = { name = "Кристал Малдрациту", fen = "This small green crystal is filled with anima and etched with runes.", fua = "Цей маленький зелений кристал сповнений аніми й покритий різьбленими рунами." }
    t[172218] = { name = "Оброблений Панцир Горма", fen = "Rigid, yet lightweight.", fua = "Цупкий, але легкий." }
    t[172220] = { name = "Уламок Дзеркала", fen = "A small piece of reflective glass with jagged, sharp edges.", fua = "Маленький шматок дзеркального скла із зазубреними, гострими краями." }
    t[172221] = { name = "Велетенський Жир Горма", fen = "Used by the fae of Ardenweald for... something.", fua = "Фейрі Арденвальду використовують це для... чогось." }
    t[172230] = "Душевний Пил"
    t[172231] = "Священна Скалка"
    t[172232] = "Вічний Кристал"
    t[172233] = "Барабани Смертельної Лютості"
    t[172234] = "Спустошений Шкіряний Жилет"
    t[172235] = "Спустошені Шкіряні Чоботи"
    t[172236] = "Спустошені Шкіряні Рукавиці"
    t[172237] = "Спустошений Шкіряний Шолом"
    t[172238] = "Скорботні Шкіряні Поножі"
    t[172239] = "Спустошені Шкіряні Наплічники"
    t[172240] = "Спустошений Шкіряний Пояс"
    t[172241] = "Спустошені Шкіряні Наручі"
    t[172242] = "Спустошений Лускатий Жилет"
    t[172243] = "Спустошені Лускаті Чоботи"
    t[172244] = "Спустошені Лускаті Рукавиці"
    t[172245] = "Спустошений Лускатий Шолом"
    t[172246] = "Скорботні Лускаті Поножі"
    t[172247] = "Спустошені Лускаті Наплічники"
    t[172248] = "Спустошений Лускатий Пояс"
    t[172249] = "Спустошені Лускаті Наручі"
    t[172250] = "Тінесований Нагрудник"
    t[172251] = "Тінесковані Чоботи"
    t[172252] = "Тінесковані Латні Рукавиці"
    t[172253] = "Тінескований Шолом"
    t[172254] = "Тінню Скуті Поножі"
    t[172255] = "Тінесковані Наплічники"
    t[172256] = "Тінесований Пояс"
    t[172257] = "Тінесковані Наручі"
    t[172258] = "Нагрудник із Тіньової Луски"
    t[172259] = "Чоботи з Тіньової Луски"
    t[172260] = "Латні Рукавиці з Тіньової Луски"
    t[172261] = "Шолом із Тіньової Луски"
    t[172262] = "Поножі з Тіньової Луски"
    t[172263] = "Наплічники з Тіньової Луски"
    t[172264] = "Пояс із Тіньової Луски"
    t[172265] = "Наручі з Тіньової Луски"
    t[172280] = "Пояс із Гріхолуски"
    t[172314] = { name = "Нагрудник з Тіньошкіри", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172315] = { name = "Чоботи з Тіньошкіри", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172316] = { name = "Латні Рукавиці з Тіньошкіри", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172317] = { name = "Шолом з Тіньошкіри", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172318] = { name = "Поножі з Тіньошкіри", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172319] = { name = "Наплічники з Тіньошкіри", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172320] = { name = "Пояс з Тіньошкіри", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172321] = { name = "Наручі з Тіньошкіри", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172322] = { name = "Кісткотрощний Нагрудник", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172323] = { name = "Кісткотрощні Чоботи", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172324] = { name = "Кісткотрощні Латні Рукавиці", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172325] = { name = "Кісткотрощний Шолом", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172326] = { name = "Кісткотрощні Поножі", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172327] = { name = "Кісткотрощні Наплічники", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172328] = { name = "Кісткотрощний Пояс", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172329] = { name = "Кісткотрощні Наручі", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[172330] = { name = "Лиховісна Шкіра", fen = "Gathered by players with the Skinning skill from creatures in Ardenweald.", fua = "Збирається гравцями з умінням Білування з істот у Арденвальді." }
    t[172331] = { name = "Гріховна Шкіра", fen = "Gathered by players with the Skinning skill from creatures in Revendreth.", fua = "Збирається гравцями з умінням Білування з істот у Ревендреті." }
    t[172332] = { name = "Некротична Шкіра", fen = "Gathered by players with the Skinning skill from creatures in Maldraxxus.", fua = "Збирається гравцями з умінням Білування з істот у Малдраксусі." }
    t[172333] = { name = "Очищена Шкіра", fen = "Gathered by players with the Skinning skill from creatures in Bastion.", fua = "Збирається гравцями з умінням Білування з істот у Бастіоні." }
    t[172334] = "Реагент Шкіряної Справи 05"
    t[172335] = "Реагент Шкіряної Справи 06"
    t[172336] = "Реагент Шкіряної Справи 07"
    t[172337] = "Реагент Шкіряної Справи 08"
    t[172346] = "Набір для Спустошеної Броні"
    t[172347] = "Важкий Набір Спустошеної Броні"
    t[172348] = "Спустошений Шкіряний Цестус"
    t[172349] = "Кастет, Скований Кістками"
    t[172350] = "Композитний лук"
    t[172351] = "Композитний Арбалет"
    t[172357] = "Чари Персня — Угода Критичного Удару"
    t[172358] = "Чари Персня — Угода Стрімкості"
    t[172359] = "Чари Персня — Угода Майстерності"
    t[172360] = "Чари Персня — Угода Універсальності"
    t[172361] = "Чари Персня — Доктрина Критичного Удару"
    t[172362] = "Чари Персня — Доктрина Стрімкості"
    t[172363] = "Чари Персня — Доктрина Майстерності"
    t[172364] = "Чари Персня — Доктрина Універсальності"
    t[172365] = "Чари Зброї — Піднесена Снага"
    t[172366] = "Чари Зброї — Небесне Провадження"
    t[172367] = "Чари Зброї — Вічна Грація"
    t[172368] = "Чари Зброї — Гріховне Одкровення"
    t[172370] = "Чари Зброї — Безсвітлова Сила"
    t[172406] = "Чари Рукавичок — Збирання Тіньокраю"
    t[172407] = "Чари Рукавичок — Сила Душі"
    t[172408] = "Чари Рукавичок — Вічна Сила"
    t[172410] = "Чари Плаща — Посилена Швидкість"
    t[172411] = "Чари Плаща — Посилене Ухиляння"
    t[172412] = "Чари Плаща — Посилене Висмоктування"
    t[172413] = "Чари Чобіт — Спритний Душеходець"
    t[172414] = "Чари Наручів — Осяяна Душа"
    t[172415] = "Чари Наручів — Вічний Інтелект"
    t[172416] = "Чари Наручів — Тіньове Повернення"
    t[172418] = "Чари Нагрудника — Вічний Оплот"
    t[172419] = "Чари Чобіт — Вічна Спритність"
    t[172437] = { name = "Зачарований Злиток Елетію", fen = "Created by players with the Enchanting skill.", fua = "Створюється гравцями з умінням Зачаровування." }
    t[172438] = { name = "Зачарована Важка Загрубіла Шкіра", fen = "Created by players with the Enchanting skill.", fua = "Створюється гравцями з умінням Зачаровування." }
    t[172439] = { name = "Зачарований Безсвітловий Шовк", fen = "Created by players with the Enchanting skill.", fua = "Створюється гравцями з умінням Зачаровування." }
    t[172446] = { name = "Ключ від Клітки Ренатала", fen = "Forged from dark metals and enforced with evil sigils.", fua = "Викуваний з темних металів і зміцнений лиховісними сигілами." }
    t[172451] = { name = "Слабка Порошинка Аніми", fen = "An insubstantial distillation of anima. It is too weak to power anything on its own.", fua = "Безплотна витяжка аніми. Заслабка, щоб самотужки щось живити." }
    t[172453] = { name = "Накази про Передачу Полонених", fen = "Written in an ancient and unkind language.", fua = "Написані прадавньою й немилосердною мовою." }
    t[172454] = { name = "Скверноскривний Крам", fen = "Foreign goods for Xem'altan.", fua = "Заморський товар для Ксем'алтана." }
    t[172455] = { name = "Загартовані Скалки Скверни", fen = "Concentrated power; convenient size.", fua = "Зосереджена сила; зручний розмір." }
    t[172456] = { name = "Надщерблене Скверноядро", fen = "A denizen of the Shadowlands may well find a means to restore this treasure.", fua = "Хтось із мешканців Тіньокраю напевне знайде спосіб відновити цей скарб." }
    t[172457] = { name = "Накази Легіону", fen = "No doubt desirable to Maldraxxi tacticians.", fua = "Безсумнівно бажані для тактиків Малдраксусу." }
    t[172458] = { name = "Затерта Розписка Легіону", fen = "Some strange currency, perhaps?", fua = "Можливо, якась дивна валюта?" }
    t[172460] = { name = "Скверноскривний Припарок", fen = "A compress steeped in burning fel.", fua = "Компрес, просочений палючою скверною." }
    t[172462] = "Зачарована Сутінкова Чарівна Паличка"
    t[172464] = { name = "Німолист", fen = "The bitter taste of the Nimleaf belies its powerful medicinal properties.", fua = "Гіркий смак німолисту приховує його потужні лікувальні властивості." }
    t[172496] = "Ключ Каналу"
    t[172512] = { name = "Гілка Кулексового Дерева", fen = "This wood is soft and light.", fua = "Ця деревина м'яка й легка." }
    t[172513] = { name = "Скверний Спускач", fen = "Activates dormant Legion portals.", fua = "Активує бездіяльні портали Легіону." }
    t[172516] = { name = "Осяйні Нутрощі", fen = "The innards of an etherwyrm are naturally infused with anima.", fua = "Нутрощі етервірма від природи просякнуті анімою." }
    t[172517] = "Зачарована Флейта"
    t[172900] = { name = "Нотатки про Винагороду", fen = "Leads on Oku's next bounty.", fua = "Підказки про наступну здобич Оку." }
    t[172901] = "Перстень-Печатка Гаконе"
    t[172902] = "Метавка Бомб-Боласів"
    t[172903] = "Граната-Лускунчик"
    t[172904] = "Тіньова Наземна Міна"
    t[172905] = "Гнучкі Ектоплазмові Окуляри"
    t[172906] = "Заземлені Ектоплазмові Окуляри"
    t[172907] = "Шарнірні Ектоплазмові Окуляри"
    t[172908] = "Зміцнені Ектоплазмові Окуляри"
    t[172909] = { name = "[DNT] [REUSE ME]", fen = "The eyes are the window to the soul.", fua = "Очі — це вікно в душу." }
    t[172910] = { name = "Карта Темного Місяця Спокою", fen = "A random Darkmoon Card from the Repose suit. Collect a full set to receive a reward.", fua = "Випадкова карта Темного Місяця з масті Спокою. Зберіть повний набір, щоб отримати винагороду." }
    t[172911] = { name = "[DNT] [REUSE ME]", fen = "Macroscopic Observable Transplanar Energy", fua = "Макроскопічна спостережна транспланарна енергія" }
    t[172912] = { name = "Чоботи Перерозподілу Імпульсу", fen = "Allows you to do a super heroic landing!", fua = "Дозволяють тобі здійснити супергеройське приземлення!" }
    t[172913] = "[DNT] [REUSE ME]"
    t[172914] = { name = "Гравіметрична Глушильна Гармата", fen = "Sometimes called a \"Black Hole Gun\", which is inaccurate. It's really more of an artillery piece.", fua = "Її іноді називають \"гарматою чорної діри\", що неточно. Насправді це радше артилерійський засіб." }
    t[172915] = { name = "50UL-TR4P", fen = "Who will you be in communications with?!", fua = "З ким ти збираєшся виходити на зв'язок?!" }
    t[172916] = { name = "[DNT] [REUSE ME]", fen = "Causes nearby enemies to release unbound souls upon their expiration.", fua = "Змушує ворогів неподалік вивільняти непов'язані душі по своїй смерті." }
    t[172917] = { name = "Модифікація Пояса: Вимірний Зсувач", fen = "You are unable to assail that which you are incapable of visually perceiving!", fua = "Ти не здатен напасти на те, чого не можеш бачити!" }
    t[172918] = { name = "Модифікація Пояса: Електрострибок", fen = "Ride the lightning!", fua = "Осідлай блискавку!" }
    t[172919] = { name = "Модифікація Пояса: Відплатник Шкоди", fen = "I am comprised of highly elastic bands, you consist entirely of liquid adhesive...", fua = "Я складаюся з вельми пружних стрічок, ти ж цілковито з рідкого клею..." }
    t[172920] = { name = "Оптичний Збільшувач Цілі", fen = "Boom. Headshot.", fua = "Бум. Постріл у голову." }
    t[172921] = { name = "Інфразелений Рефлекторний Приціл", fen = "No one can hide from my sight.", fua = "Ніхто не сховається від мого ока." }
    t[172923] = { name = "Точний Інвертор Життєсили", fen = "Extremely effective at making enemy combatants less healthy.", fua = "Надзвичайно дієвий у тому, щоб робити ворожих бійців менш здоровими." }
    t[172924] = { name = "Генератор Червоточин: Тіньокрай", fen = "CAUTION: Failure to operate within strict safety guidelines may result in... double death? Turbo death? Aliveness?", fua = "УВАГА: недотримання суворих правил безпеки може призвести до... подвійної смерті? Турбосмерті? Оживлення?" }
    t[172934] = { name = "Жменя Лестритових Болтів", fen = "Used by Engineers to make a variety of items.", fua = "Використовуються інженерами для виготовлення різноманітних предметів." }
    t[172935] = { name = "Пористий Полірувальний Абразив", fen = "Used by Engineers to precisely smooth and polish metal.", fua = "Використовується інженерами для точного вигладжування й полірування металу." }
    t[172936] = { name = "Смертна Звита Пружина", fen = "Used by Engineers to make intricate items.", fua = "Використовується інженерами для виготовлення вигадливих предметів." }
    t[172937] = { name = "Зачервивлений Зубчастий Механізм", fen = "Used by Engineers to make extremely complex items.", fua = "Використовується інженерами для виготовлення вкрай складних предметів." }
    t[172938] = "Інженерний Реагент 05"
    t[172939] = "Інженерний Реагент 06"
    t[172940] = "Інженерний Реагент 07"
    t[172941] = "Інженерний Реагент 08"
    t[172948] = { name = "Анімашишка", fen = "A seed of condensed anima, fallen from one of the celestial trees.", fua = "Насінина концентрованої аніми, що впала з одного з небесних дерев." }
    t[172950] = { name = "Глек Глини", fen = "Smells earthy.", fua = "Пахне землею." }
    t[172953] = { name = "Виснажене Дике Сім'я", fen = "No trace remains of the once-great spirit that resided within.", fua = "Від колись величного духа, що мешкав усередині, не лишилося й сліду." }
    t[172996] = "Камінь Гріха Інквізитора Сорина"
    t[172997] = "Камінь Гріха Інквізитора Петре"
    t[172998] = "Камінь Гріха Інквізиторки Отілії"
    t[172999] = "Камінь Гріха Інквізитора Траяна"
    t[173000] = "Камінь Гріхів Верховної Інквізиторки Ґабі"
    t[173001] = "Камінь Гріхів Верховної Інквізиторки Раду"
    t[173005] = "Камінь Гріхів Верховної Інквізиторки Маґди"
    t[173006] = "Камінь Гріхів Верховного Інквізитора Дакіана"
    t[173007] = "Камінь Гріхів Великого Інквізитора Ніку"
    t[173008] = "Камінь Гріхів Великої Інквізиторки Авріки"
    t[173023] = { name = "Будь Свідком: Кодекс Спостерігача", fen = "An embossed scroll espousing the virtues of compassion and duty in determining the fate of the newly deceased.", fua = "Тиснений сувій, що проголошує чесноти співчуття й обов'язку у вирішенні долі щойно померлих." }
    t[173024] = { name = "Незліченні Світи", fen = "A thick volume detailing thousands upon thousands of worlds beyond the Shadowlands.", fua = "Грубий том, що детально описує тисячі й тисячі світів за межами Тіньокраю." }
    t[173025] = { name = "Нескінченні Трактати", fen = "A heavy scroll compiling the professional works of master Kyrian crafters.", fua = "Важкий сувій, що зібрав фахові праці майстрів-ремісників кіріанів." }
    t[173029] = "Відзнака Квартирмейстера"
    t[173032] = "Загублена Камбала"
    t[173033] = "Райдужна Сериола"
    t[173034] = "Срібнозяброва Щука"
    t[173035] = "Дзьобана Кістриба"
    t[173036] = "Колючопера Піранья"
    t[173037] = "Елізійський Тейд"
    t[173038] = "Принада на Загублену Камбалу"
    t[173039] = "Принада На Райдужну Сериолу"
    t[173040] = "Принада На Срібнозяброву Щуку"
    t[173041] = "Принада на Дзьобану Кістрибу"
    t[173042] = "Наживка На Колючоперу Піранью"
    t[173043] = "Принада на Елізійського Тейда"
    t[173044] = "Заквітчана Вудка"
    t[173047] = { name = "Личинка Шовкохода", fen = "Expresses it's gratitude by chittering non-stop.", fua = "Виявляє свою вдячність невпинним сюрчанням." }
    t[173048] = { name = "Кодекс Безтурботного Розуму", fen = "Created by players with the Inscription skill. Can be bought and sold on the auction house.", fua = "Створюється гравцями з навичкою накреслення. Можна купити й продати на аукціоні." }
    t[173049] = { name = "Фоліант Безтурботного Розуму", fen = "Created by players with the Inscription skill. Can be bought and sold on the auction house.", fua = "Створюється гравцями з навичкою накреслення. Можна купити й продати на аукціоні." }
    t[173050] = "Кодекс Нещодавно Спочилих"
    t[173051] = "Контракт: Піднесені"
    t[173053] = "Контракт: Дике Полювання"
    t[173054] = "Шпиль хранителя душ"
    t[173056] = { name = "Тіньовий Пігмент", fen = "Commonly found when milling herbs native to the Shadowlands.", fua = "Зазвичай знаходиться при перемелюванні трав, що ростуть у Тіньокраї." }
    t[173057] = { name = "Сяйливий Пігмент", fen = "Commonly found when milling herbs native to the Shadowlands.", fua = "Зазвичай знаходиться при перемелюванні трав, що ростуть у Тіньокраї." }
    t[173058] = { name = "Тіньове Чорнило", fen = "Crafted by players with the Inscription skill. Can be bought and sold on the auction house.", fua = "Виготовлено гравцями з умінням Знакарства. Можна купити й продати на аукціоні." }
    t[173059] = { name = "Сяйливе Чорнило", fen = "Crafted by players with the Inscription skill. Can be bought and sold on the auction house.", fua = "Виготовлено гравцями з умінням Знакарства. Можна купити й продати на аукціоні." }
    t[173060] = { name = "Газована Вода", fen = "Used for mixing various pigments into inks. Sold by inscription vendors.", fua = "Використовується для змішування різних пігментів у чорнило. Продається у торговців знакарством." }
    t[173062] = "Контракт: Двір Жнеців"
    t[173063] = { name = "[DNT] REUSE ME", fen = "[TBD]", fua = "[TBD]" }
    t[173064] = { name = "[DNT] REUSE ME", fen = "[TBD]", fua = "[TBD]" }
    t[173065] = "Указ про Гробокрадство"
    t[173066] = { name = "Картка Темного Місяця: Смерть", fen = "A random Darkmoon Card of Death. Collect a full set to receive a reward.", fua = "Випадкова Картка Темного Місяця: Смерть. Збери повний набір, щоб отримати винагороду." }
    t[173067] = "Руна Вантуса: Замок Натрія"
    t[173068] = { name = "Техніка Руни Вантуса: Замок Натрія", fen = "Teaches you how to craft a Vantus Rune: Castle Nathria.", fua = "Навчає тебе виготовляти Руну Вантуса: Замок Натрія." }
    t[173069] = "Колода Місячної Гільдії: Гниття"
    t[173070] = "Туз Гниття"
    t[173071] = "Двійка Гнилі"
    t[173072] = "Трійка Гниття"
    t[173073] = "Четвірка Гнилі"
    t[173074] = "П'ятірка Гнилі"
    t[173075] = "Шістка Гниття"
    t[173076] = "Сімка Гнилі"
    t[173077] = "Вісімка Гнилі"
    t[173078] = "Колода Місячної Гільдії: Спокій"
    t[173079] = "Туз Спочинку"
    t[173080] = "Двійка Спокою"
    t[173081] = "Трійка Спокою"
    t[173082] = "Четвірка Спокою"
    t[173083] = "П'ятірка Спокою"
    t[173084] = "Шістка Спокою"
    t[173085] = "Сімка Спокою"
    t[173086] = "Вісімка Спокою"
    t[173087] = "Колода Місячної Гільдії: Ненаситність"
    t[173088] = "Туз Ненажерливості"
    t[173089] = "Двійка Ненажерливості"
    t[173090] = "Трійка Ненаситності"
    t[173091] = "Четвірка Ненажерливості"
    t[173092] = "П'ятірка Ненажерливості"
    t[173093] = "Шістка Ненажерливості"
    t[173094] = "Сімка Ненажерливості"
    t[173095] = "Вісімка Ненажерливості"
    t[173096] = "Колода Місячної Гільдії: Незламність"
    t[173097] = "Туз Незламності"
    t[173098] = "Двійка Незламності"
    t[173099] = "Трійка Незламності"
    t[173100] = "Четвірка Незламності"
    t[173101] = "П'ятірка Незламного"
    t[173102] = "Шістка Незламності"
    t[173103] = "Сімка Незламних"
    t[173104] = "Вісімка Незламного"
    t[173108] = "Оріблейз"
    t[173109] = "Око Гніву"
    t[173110] = "Умбрил"
    t[173111] = "9.x Необроблений Рідкісний"
    t[173115] = "9.x Необроблений Жовтий"
    t[173116] = "9.x Необроблений Червоний"
    t[173117] = "9.x Необроблений Синій"
    t[173121] = "Смертоносний Дублет Самоцвітів"
    t[173122] = "Швидкий Дублет Самоцвітів"
    t[173123] = "Універсальний Дуплет Самоцвітів"
    t[173124] = "Майстерний Дублет Самоцвітів"
    t[173125] = "Відновлювальний Самоцвітний Дублет"
    t[173126] = "Гранчастий Самоцвітний Дублет"
    t[173127] = "Смертоносне Гроно Самоцвітів"
    t[173128] = "Швидке Гроно Самоцвітів"
    t[173129] = "Універсальне Скупчення Самоцвітів"
    t[173130] = "Майстерне Гроно Самоцвітів"
    t[173131] = "Універсальний Соленієвий Перстень"
    t[173132] = "Майстерний Перстень з Федруму"
    t[173133] = "Швидкий Окссейновий Перстень"
    t[173134] = "Смертоносний Перстень зі Сінвіру"
    t[173135] = "Універсальний Лестритовий Перстень"
    t[173136] = "Майстерний Перстень з Лестриту"
    t[173137] = "Швидкий Лестритовий Перстень"
    t[173138] = "Смертоносний Перстень із Лестриту"
    t[173140] = "Універсальне Лестритове Намисто"
    t[173141] = "Майстерне Намисто з Лестриту"
    t[173142] = "Швидке Лестритове Намисто"
    t[173143] = "Смертоносне Намисто з Лестриту"
    t[173144] = "Універсальне Соленієве Намисто"
    t[173145] = "Майстерне Намисто з Федруму"
    t[173146] = "Швидке Окссейнове Намисто"
    t[173147] = "Смертоносне Намисто зі Сінвіру"
    t[173148] = { name = "Сталевий Сікач", fen = "This large cleaver is designed to cut through bone and flesh smoothly.", fua = "Цей великий сікач створений, щоб легко розтинати кістки й плоть." }
    t[173149] = { name = "Порожній Кристал Аніми", fen = "A small well crafted crystal. It is covered in runes, but appears to be empty.", fua = "Невеликий майстерно виготовлений кристал. Він укритий рунами, але видається порожнім." }
    t[173150] = { name = "Щаслива Довбня Фіннана", fen = "It certainly looks lucky enough.", fua = "Виглядає вона і справді доволі щасливою." }
    t[173157] = "Флакон Їдкого Слизу"
    t[173158] = { name = "Нотатка Теотара", fen = "Written with remarkable penmanship.", fua = "Написана навдивовижу гарним почерком." }
    t[173160] = { name = "Лист Швидкості", fen = "Crafted by scribes, Missives can be bought and sold on the Auction House.", fua = "Виготовлені писарями, листи можна купувати й продавати на аукціоні." }
    t[173161] = { name = "Лист Критичного Удару", fen = "Crafted by scribes, Missives can be bought and sold on the Auction House.", fua = "Виготовлені писарями, листи можна купувати й продавати на аукціоні." }
    t[173162] = { name = "Лист Майстерності", fen = "Crafted by scribes, Missives can be bought and sold on the Auction House.", fua = "Виготовлені писарями, листи можна купувати й продавати на аукціоні." }
    t[173163] = { name = "Лист Універсальності", fen = "Crafted by scribes, Missives can be bought and sold on the Auction House.", fua = "Виготовлені писарями, листи можна купувати й продавати на аукціоні." }
    t[173168] = { name = "Лестритова Оправа", fen = "Used for securing gemstones. Sold by Jewelcrafting vendors.", fua = "Слугує для закріплення самоцвітів. Продається торгівцями для ювелірства." }
    t[173170] = { name = "Сутність Відродження", fen = "Gathered by players with the Jewelcrafting skill. Most commonly found when prospecting Phaedrum Ore.", fua = "Збирається гравцями з умінням ювелірства. Найчастіше знаходиться при перебиранні федрумової руди." }
    t[173171] = { name = "Сутність Муки", fen = "Gathered by players with the Jewelcrafting skill. Most commonly found when prospecting Sinvyr Ore.", fua = "Збирається гравцями з умінням ювелірства. Найчастіше знаходиться при перебиранні сінвірової руди." }
    t[173172] = { name = "Сутність Поневолення", fen = "Gathered by players with the Jewelcrafting skill. Most commonly found when prospecting Oxxein Ore.", fua = "Збирається гравцями з умінням ювелірства. Найчастіше знаходиться при перебиранні оксеїнової руди." }
    t[173173] = { name = "Сутність Звитяги", fen = "Gathered by players with the Jewelcrafting skill. Most commonly found when prospecting Solenium Ore.", fua = "Збирається гравцями з умінням ювелірства. Найчастіше знаходиться при перебиранні соленієвої руди." }
    t[173180] = { name = "Оздоблений Ключ", fen = "Controls access to Thornhill Manor.", fua = "Відмикає доступ до маєтку Торнгілл." }
    t[173187] = { name = "Річковий Намул", fen = "Altogether unassuming. If you squint hard enough you think you might see a sparkle, but it could just as easily be a trick of the light.", fua = "Загалом доволі невиразний. Якщо як слід примружитися, здається, ніби бачиш блиск, та з тим самим успіхом це може бути просто гра світла." }
    t[173191] = "Важкий Бинт з Оповитої Тканини"
    t[173192] = "Бинт з Оповитої Тканини"
    t[173193] = "Роба з Оповитої Тканини"
    t[173194] = "Плащ з Оповитої Тканини"
    t[173195] = "Сандалі з Оповитої Тканини"
    t[173196] = "Рукавиці з Оповитої Тканини"
    t[173197] = "Каптур з Оповитої Тканини"
    t[173198] = "Штани із Запинальної Тканини"
    t[173199] = "Наплічники з Оповитої Тканини"
    t[173200] = "Пояс з Оповитої Тканини"
    t[173201] = "Наручі з Оповитої Тканини"
    t[173202] = { name = "Огорнута Тканина", fen = "Gathered from killing creatures. Can be bought and sold on the auction house.", fua = "Здобувається з убитих створінь. Можна купити та продати на аукціоні." }
    t[173204] = { name = "Безсвітний Шовк", fen = "Used by players with the Tailoring skill. Can be bought and sold on the auction house.", fua = "Використовується гравцями з умінням кравецтва. Можна купити та продати на аукціоні." }
    t[173214] = "Туніка з Тіньового Мережива"
    t[173215] = "Плащ із Тіньового Мережива"
    t[173216] = "Чоботи з Тіньового Мережива"
    t[173217] = "Рукавиці з Тіньового Мережива"
    t[173218] = "Каптур із Тіньового Мережива"
    t[173219] = "Штани з Тіньового Мережива"
    t[173220] = "Оплічник із Тіньового Мережива"
    t[173221] = "Пояс із Тіньового Мережива"
    t[173222] = "Наручі з Тіньового Мережива"
    t[173241] = { name = "Роба Похмурої Запони", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[173242] = { name = "Плащ Похмурої Запони", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[173243] = { name = "Сандалі Похмурої Запони", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[173244] = { name = "Рукавиці Похмурої Запони", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[173245] = { name = "Каптур Похмурої Запони", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[173246] = { name = "Штани Похмурої Запони", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[173247] = { name = "Наплічники Похмурої Запони", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[173248] = { name = "Пояс Похмурої Запони", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[173249] = { name = "Наручі Похмурої Запони", fen = "An exceptionally well crafted piece of armor worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлений елемент броні, гідний того, щоб його зміцнив Різьбяр рун." }
    t[173250] = "Кравецький Реагент 01"
    t[173251] = "Кравецький Реагент 02"
    t[173252] = "Кравецький Реагент 03"
    t[173253] = "Кравецький Реагент 04"
    t[173254] = "Кравецький Реагент 05"
    t[173255] = "Кравецький Реагент 06"
    t[173256] = "Кравецький Реагент 07"
    t[173257] = "Кравецький Реагент 08"
    t[173266] = { name = "Ритуальні Шати", fen = "Preternaturally white and extremely soft.", fua = "Надприродно білі й надзвичайно м'які." }
    t[173267] = { name = "Кристалізований Гормовий Жир", fen = "Highly condensed biomaterial. Requires additional refinement for use.", fua = "Вкрай ущільнений біоматеріал. Перед застосуванням потребує додаткового очищення." }
    t[173268] = { name = "Свіжий Гормовий Жир", fen = "Pretty, for something that just came out of a gormling.", fua = "Доволі гарний, як на щось, що щойно вийшло з гормлінга." }
    t[173269] = { name = "Тренувальний Самоцвіт", fen = "Used to help train phalynx's laser location skills.", fua = "Використовується для тренування навичок наведення лазера у фалінксів." }
    t[173285] = { name = "Зрадницький Лист", fen = "Penned by Lord Andrei of House Iremoore.", fua = "Написаний лордом Андреєм із дому Айрмор." }
    t[173286] = { name = "Гриб Сутінкової Багви", fen = "Fragrant and deadly.", fua = "Запашний і смертельний." }
    t[173287] = { name = "Медальйон Жадання", fen = "Once worn by the Countess, this medallion seethes with power.", fua = "Колись його носила графиня, і тепер цей медальйон вирує силою." }
    t[173307] = { name = "Підсилена Броня", fen = "Sturdy replacement armor fitted for a phalynx.", fua = "Міцна запасна броня, припасована для фалінкса." }
    t[173312] = { name = "Ключ Тока", fen = "Unlocks prisoner cage containing Ansid.", fua = "Відмикає клітку з полоненим Ансідом." }
    t[173315] = "Шолом Розсудливого Претендента"
    t[173316] = "Небеснотканий Плащ"
    t[173317] = "Шати Дороговказу"
    t[173318] = "Нагрудник Дороговказу"
    t[173319] = "Кольчуга Дороговказу"
    t[173320] = "Туніка Дороговказу"
    t[173321] = "Чоботи Самозаглиблення"
    t[173322] = "Сандалі Ясності Душі"
    t[173323] = "Споглядальні Чоботи"
    t[173324] = "Чоботи Внутрішнього Спокою"
    t[173325] = "Рукавиці Тренера-Спаринґіста"
    t[173326] = "Латні Рукавиці Тренера-Спаринґіста"
    t[173327] = "Обмотки Тренера-Спаринґіста"
    t[173328] = "Рукавички Тренера-Спаринґіста"
    t[173329] = "Каптур Чистого Претендента"
    t[173330] = "Шолом Смиренного Претендента"
    t[173331] = "Шолом Мужнього Претендента"
    t[173332] = "Поножі Розважливого Претендента"
    t[173333] = "Поножі Чистого Претендента"
    t[173334] = "Поножі Скромного Претендента"
    t[173335] = "Штани Відважного Адепта"
    t[173336] = "Еполети Дороговказу"
    t[173337] = "Наплічники Дороговказу"
    t[173338] = "Наплічні Накладки Дороговказу"
    t[173339] = "Наплічні Щитки Дороговказу"
    t[173340] = "Пас Непевної Відданості"
    t[173341] = "Пояс Непевної Відданості"
    t[173342] = "Пояс Непевної Відданості"
    t[173343] = "Пояс Непевної Відданості"
    t[173344] = "Перстень Літописних Діянь"
    t[173345] = "Наручі з Журавлиного Пера"
    t[173346] = "Дзьобозахисники"
    t[173347] = "Наручі на Пуховій Підкладці"
    t[173348] = "Ненажерливі Обмотки на Зап'ястя"
    t[173349] = "Несправний Пульт Центуріона"
    t[173354] = { name = "Спис Калліопи", fen = "It is arguably the most impressive spear you have encountered.", fua = "Без сумніву, це найвражаючіший спис, який вам траплявся." }
    t[173355] = "Мішечок Пилку Пухопелюстки"
    t[173358] = "Запрошення"
    t[173368] = { name = "Роздутий Отруйний Мішечок", fen = "Yuck!", fua = "Фе!" }
    t[173380] = { name = "Книга Незримованого", fen = "A flesh bound book that is filled with rituals.", fua = "Оправлена в плоть книга, повна ритуалів." }
    t[173381] = "Знак Ремісника I"
    t[173382] = "Знак Ремісника II"
    t[173383] = "Знак Ремісника III"
    t[173384] = "Знак Ремісника Закутого Острова"
    t[173385] = { name = "Свічка Зеленого Полум'я", fen = "A thick purple candle that burns, but is not consumed.", fua = "Товста фіолетова свічка, що горить, але не згоряє." }
    t[173392] = { name = "Рунний Кинджал", fen = "A thin runed dagger. Useless for fighting, designed for rituals.", fua = "Тонкий рунний кинджал. Непридатний для бою, призначений для ритуалів." }
    t[173428] = "Колона хранителя душ"
    t[173536] = "Лабораторне Обладнання"
    t[173690] = { name = "Ріг Хмароходця", fen = "The perfect toy for a larion to chew on.", fua = "Ідеальна іграшка-погризачка для ларіона." }
    t[173691] = "Висмоктувач Аніми"
    t[173692] = { name = "Дротик Немеї", fen = "Used to work alongside a larion to take down flying prey.", fua = "Використовувався разом із ларіоном для полювання на летючу здобич." }
    t[173695] = { name = "Вентирська Ритуальна Роба", fen = "Ornate, elegant, and beautiful.", fua = "Оздоблена, елегантна й прекрасна." }
    t[173696] = { name = "Вентирський Ритуальний Кинджал", fen = "Has aided countless souls without ever piercing flesh.", fua = "Допоміг незліченним душам, жодного разу не проштрикнувши плоть." }
    t[173697] = { name = "Вентирський Ритуальний Фоліант", fen = "Each ritual is endlessly detailed with countless variations.", fua = "Кожен ритуал описано безмежно докладно, з незліченними варіаціями." }
    t[173702] = { name = "Сутність Хмаропера", fen = "Every larion's favorite meal.", fua = "Улюблена страва кожного ларіона." }
    t[173707] = { name = "Клинок Ловця Душ", fen = "The blade from a venthyr rapier. One glance at it reveals the numerous terrors it has wrought.", fua = "Клинок вентирської рапіри. Одного погляду досить, щоб зрозуміти, скільки жахіть він заподіяв." }
    t[173708] = { name = "Кіріанський Щит", fen = "A fun way to bond with your larion.", fua = "Кумедний спосіб поріднитися зі своїм ларіоном." }
    t[173709] = { name = "Флакон Гробарського Багна", fen = "Contains muck from a muck pool. Its odor is noxious and singes the tips of your nose hairs.", fua = "Містить багно з багнистої калюжі. Сморід отруйний і обпалює кінчики волосків у носі." }
    t[173710] = { name = "Скам'янілий Кам'яний Лиходій", fen = "A stonefiend completely drained of its anima. In perfect condition too.", fua = "Кам'яний лиходій, цілковито позбавлений своєї аніми. До того ж у бездоганному стані." }
    t[173711] = { name = "Портрет Сіра", fen = "A near perfect rendition of Denathrius.", fua = "Майже досконале зображення Денатрія." }
    t[173712] = { name = "Реєстр Душ", fen = "A ledger containing the names of thousands of souls sent to Revendreth.", fua = "Реєстр, що містить імена тисяч душ, відісланих до Ревендрету." }
    t[173715] = { name = "Набір Інструментів Гробаря", fen = "A bucket of tools used by the dredgers of Revendreth.", fua = "Відро інструментів, яким користуються гробарі Ревендрету." }
    t[173717] = { name = "Досконале Люстерко", fen = "These devices are capable of teleportation in addition to more combative uses. This mirror contains very intricate designs on the casings.", fua = "Окрім бойового застосування, ці пристрої здатні телепортувати. Це люстерко має дуже химерні візерунки на оправі." }
    t[173718] = { name = "Пляшка Вина Редельав", fen = "A bottle of finely aged Redelav wine. A unique blend of native spices and foilage of Revendreth. A strong aftertaste of iron.", fua = "Пляшка добре витриманого вина Редельав. Унікальна суміш місцевих прянощів та листя Ревендрету. Сильний залізний післясмак." }
    t[173719] = { name = "Бездоганне Ікло Жахокажана", fen = "The fang is extremely sharp. A slight poke to a person can puncture the skin.", fua = "Ікло надзвичайно гостре. Легкий укол може проколоти людині шкіру." }
    t[173720] = { name = "Мерехтливе Намисто Первоцвіту", fen = "The necklace is laced with a strange gold material.", fua = "Намисто оздоблене дивним золотавим матеріалом." }
    t[173721] = { name = "Любов і Жах", fen = "A collection of poems from an unknown writer. From the looks of the writing style it is likely Venthyr in nature.", fua = "Збірка віршів невідомого автора. Судячи зі стилю письма, вони, найімовірніше, вентирського походження." }
    t[173732] = { name = "Дивний Рунний Камінь", fen = "A strange rune has been brutally chipped into the stone.", fua = "У камені брутально вибито дивну руну." }
    t[173733] = { name = "Записи Каменів Гріхів", fen = "A complete archive would detail in explicit detail every sinstone the venthyr have ever accumulated.", fua = "Повний архів містив би докладні відомості про кожен камінь гріхів, що його будь-коли зібрали вентири." }
    t[173735] = "Ключ від Склепу Спокути"
    t[173737] = { name = "Тіло Темеля", fen = "Cracked all over. The Chamberlain's goons roughed him up bad.", fua = "Усе вкрите тріщинами. Поплічники Камергера добряче його відлупцювали." }
    t[173738] = { name = "Крила Темеля", fen = "One is slightly larger than the other.", fua = "Одне трохи більше за інше." }
    t[173739] = { name = "Голова Темеля", fen = "Frozen in a state of wild cackling.", fua = "Завмерла посеред дикого реготу." }
    t[173759] = "Цукрована Світлокора"
    t[173760] = "Сніжний Пиріг із Сильберрі"
    t[173761] = "Глазуровані Сяйноягоди"
    t[173762] = "Настоянка Палкої Роси"
    t[173793] = { name = "Камінь Гріхів Інквізитора", fen = "Archivist Fane will locate the sinstone of an inquisitor for you to challenge.", fua = "Архіваріус Фейн відшукає для тебе камінь гріхів інквізитора, якого ти зможеш викликати на бій." }
    t[173794] = { name = "Камінь Гріхів Верховного Інквізитора", fen = "Archivist Fane will locate the sinstone of a high inquisitor for you to challenge.", fua = "Архіваріус Фейн відшукає для тебе камінь гріхів верховного інквізитора, якого ти зможеш викликати на бій." }
    t[173795] = { name = "Камінь Гріхів Великого Інквізитора", fen = "Archivist Fane will locate the sinstone of a grand inquisitor for you to challenge.", fua = "Архіваріус Фейн відшукає для тебе камінь гріхів великого інквізитора, якого ти зможеш викликати на бій." }
    t[173797] = "Намисто з Зубів Ларіона"
    t[173798] = { name = "Пошарпаний Щоденник", fen = "Several pages appear to be missing.", fua = "Здається, бракує кількох сторінок." }
    t[173800] = { name = "Безлика Маска", fen = "A strange mask worn by the hostile fae.", fua = "Дивна маска, яку носять ворожі феї." }
    t[173859] = "Ефірний Гранат"
    t[173872] = "Вирвана Сторінка Щоденника"
    t[173873] = "Зім'ята Сторінка Щоденника"
    t[173879] = "Осквернений Компонент Центуріона"
    t[173880] = { name = "Очищений Метал", fen = "The smelting process seems to have removed all trace of the Forsworn's magic.", fua = "Здається, процес виплавки усунув усі сліди магії зреченців." }
    t[173882] = { name = "Затискачі з Душесталі", fen = "A special pair of clamps with a soulsteel core, capable of holding true against massive force.", fua = "Особлива пара затискачів з осердям із душесталі, здатних витримати велетенську силу." }
    t[173891] = { name = "Чумороджена Слизь", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[173892] = "Врятоване Спорядження"
    t[173909] = { name = "Іскристе Осердя Дрейфокулі", fen = "Reacts to the heat of an anima brazier to create a driftglobe used for precise smithing.", fua = "Реагує на жар анімової жаровні, створюючи дрейфокулю для точного ковальства." }
    t[173910] = { name = "Кадильниця з Пелюстки Благодаті", fen = "Mikanikos describes the smell as \"inspirational\". He cannot work without it.", fua = "Міканікос описує цей запах як «надихаючий». Без нього він не може працювати." }
    t[173929] = "Продірявлений Череп"
    t[173939] = "Звабна Аніма"
    t[173942] = "Личинка Кісткобура"
    t[173945] = { name = "Приєднайся до Принца!", fen = "Written with an elegant penmanship.", fua = "Написано вишуканим почерком." }
    t[173952] = { name = "Гробове Яблуко", fen = "This strange spongy fruit glows slightly with a sickly green glow.", fua = "Цей дивний губчастий плід ледь світиться хворобливим зеленим сяйвом." }
    t[173973] = { name = "Пуріан", fen = "Place in a tribute bowl in Aspirant's Crucible.", fua = "Покладіть у жертовну чашу в Горнилі Претендента." }
    t[173976] = { name = "Медальйон Заздрості", fen = "Bestowed upon Venthyr by The Sire himself. Allows the wearer to exert partial dominion over Revendreth.", fua = "Дарований вентирам самим Сіром. Дозволяє власнику частково панувати над Ревендретом." }
    t[173984] = "Сувій Еонів"
    t[174007] = "Очисний Напій"
    t[174021] = "Стертий Часом Короткий Клинок"
    t[174022] = "Церемоніальний Дзвіночок"
    t[174038] = "Передзвін Прудкості"
    t[174043] = { name = "Філактерія Арін'гора", fen = "The tiny dagger is plainly worked without ornamentation.", fua = "Цей крихітний кинджал викуваний просто, без жодних оздоблень." }
    t[174058] = { name = "Запас Аніми", fen = "Mikanikos's special anima reserve.", fua = "Особливий запас аніми Міканікоса." }
    t[174061] = { name = "Фестус, Початок Еонів", fen = "Blessed instrument of the First Forgelite, conduit in the creation of the first centurions and the Spires of Ascension.", fua = "Благословенне знаряддя Першої Ковальки, провідник у створенні перших центуріонів та Шпилів Вознесіння." }
    t[174070] = { name = "Незборима Шкіра", fen = "Useful in the construction of an abomination.", fua = "Корисний у спорудженні гидоти." }
    t[174078] = "Піротехнічний Порошок Первоцвіт"
    t[174092] = { name = "Скалка Дзеркала Матео", fen = "Entrusted to Sinkeeper Mateo before the Curator was cast into the Maw. Can be combined with Emil's shard to complete the Curator's mirror.", fua = "Довірена Хранителю Гріхів Матео, перш ніж Кураторку вкинули до Пащі. Можна поєднати зі скалкою Еміла, щоб відновити дзеркало Кураторки." }
    t[174093] = { name = "Ікла Іонати", fen = "Fangs once belonging to Examiner Ionata.", fua = "Ікла, що колись належали Дізнавачці Іонаті." }
    t[174094] = { name = "Ікла Бояна", fen = "Fangs once belonging to Examiner Boian.", fua = "Ікла, що колись належали Дізнавачу Бояну." }
    t[174095] = { name = "Ікла Дачіани", fen = "Fangs once belonging to Examiner Daciana.", fua = "Ікла, що колись належали Дізнавачці Дачіані." }
    t[174098] = { name = "Порошок Смертельного Лотоса", fen = "A powder made from ground up death lotus, among other things. Known for its use in venthyr spells.", fua = "Порошок, виготовлений зокрема з перемеленого смертельного лотоса. Відомий завдяки застосуванню в чарах вентирів." }
    t[174100] = { name = "Молот Каменотрощія", fen = "Used by dredgers to break down stone.", fua = "Землекопи використовують його, щоб розбивати камінь." }
    t[174101] = { name = "Цінний Брухт", fen = "Old and worn, might still be useful.", fua = "Старий і потертий, але ще може стати в нагоді." }
    t[174102] = { name = "Каністра Аніми", fen = "The anima within is struggling to escape.", fua = "Аніма всередині намагається вирватися." }
    t[174104] = "Розбитий Сувенір"
    t[174111] = { name = "Медальйон Жадоби", fen = "Bestowed upon Venthyr by The Sire himself. Allows the wearer to exert partial dominion over Revendreth.", fua = "Дарований вентирам самим Сіром. Дозволяє власнику частково панувати над Ревендретом." }
    t[174179] = { name = "Порошок Смертельного Лотоса", fen = "A powder made from ground up death lotus, among other things. Known for its use in venthyr spells.", fua = "Порошок, виготовлений зокрема з перемеленого смертельного лотоса. Відомий завдяки застосуванню в чарах вентирів." }
    t[174211] = { name = "Малдраксійська Зброя", fen = "Infused with strange necrotic powers... this should not be in Revendreth.", fua = "Просякнута дивними некротичними силами... їй не місце в Ревендреті." }
    t[174212] = "Підозріла Зброя"
    t[174219] = { name = "Викрадена Пам'ятка", fen = "A lost possession, left behind with the death of the grove.", fua = "Загублена річ, покинута зі смертю гаю." }
    t[174231] = "Бойовий План Ліча"
    t[174232] = "Тактичний План Вираза"
    t[174233] = "Польове Креслення Конструкта"
    t[174269] = { name = "Серце Тірна Ноха", fen = "Simmering with stored anima, the last remnants of a great tree.", fua = "Тліє накопиченою анімою — останні рештки великого дерева." }
    t[174275] = "Опалий Пуріан"
    t[174278] = "Накази Десятника"
    t[174280] = "Ковальський Молот Бастіону"
    t[174281] = "Очищена Вода Небесного Джерела"
    t[174282] = "Повітряна Чіабата"
    t[174283] = "Стигійське Рагу"
    t[174284] = "Емпірейський Фруктовий Салат"
    t[174285] = "Цукровані Волоські Горіхи"
    t[174289] = "Великий Шолом Безкорисливого Збирача"
    t[174290] = "Нагрудник Безкорисливого Збирача"
    t[174291] = "Бойові Чоботи Безкорисливого Збирача"
    t[174292] = "Латні Рукавиці Безкорисливого Збирача"
    t[174293] = "Поножі Самовідданого Збирача"
    t[174294] = "Наплічники Безкорисливого Збирача"
    t[174295] = "Пояс Безкорисливого Збирача"
    t[174296] = "Наручі Безкорисливого Збирача"
    t[174297] = "Великий Плащ Безкорисливого Збирача"
    t[174298] = "Тесак Сумлінного Учня"
    t[174299] = "Розсікач Грішного Гладіатора"
    t[174300] = "Різьбяр, Затьмарений Сумнівом"
    t[174301] = "Лабрис Самовідданого Носія"
    t[174302] = "Лабрис Вірного Ларіона"
    t[174303] = "Нарізач Гармонійного Форджлайта"
    t[174310] = "Егіда Елізійського Вартового"
    t[174311] = "Захисник Грішного Гладіатора"
    t[174312] = "Дефлектор, Підфарбований Сумнівом"
    t[174313] = "Оберіг Безкорисливого Збирача"
    t[174314] = "Оплот Гармонійного Збирача"
    t[174315] = "Герб Надії Чайруса"
    t[174322] = "Гармонійні Дзвіночки Вітру"
    t[174324] = "Зброя Полеглих"
    t[174329] = "Стріла Душотрощу"
    t[174330] = { name = "Досконала Кругла Форма", fen = "A mold of perfect circular shape. Used by Mikanikos to finely craft circular components.", fua = "Форма ідеально круглої обриси. Міканікос використовує її, щоб майстерно виготовляти круглі деталі." }
    t[174331] = { name = "Латна Рукавиця Голіафа", fen = "The right gauntlet of a Kyrian goliath. Capable of withstanding tremendous heat.", fua = "Права латна рукавиця кіріанського голіафа. Здатна витримати неймовірний жар." }
    t[174332] = { name = "Поповнений Вмістилище Аніми", fen = "A container of refined anima. Used to power Kyrian constructs.", fua = "Вмістилище очищеної аніми. Застосовується, щоб живити кіріанських конструктів." }
    t[174333] = { name = "Чутки про Прихильність", fen = "One noble's account of the Countess gifting mirror shards to certain houses.", fua = "Розповідь одного шляхтича про те, як Графиня дарувала скалки дзеркала певним домам." }
    t[174336] = { name = "Багряна Краватка", fen = "The final touch to pull an ensemble together.", fua = "Завершальний штрих, що поєднує весь образ." }
    t[174357] = { name = "Пелюстка Смертельного Лотоса", fen = "Can be crushed into a powder to ward off curses.", fua = "Можна перемолоти на порошок, щоб відганяти прокляття." }
    t[174359] = { name = "Скалка Графині", fen = "A shard gifted to houses by the Countess as a sign of favor.", fua = "Скалка, якою Графиня обдаровує доми на знак прихильності." }
    t[174374] = { name = "Скалка Графині", fen = "A shard gifted to houses by the Countess as a sign of favor.", fua = "Скалка, якою Графиня обдаровує доми на знак прихильності." }
    t[174375] = { name = "Скалка Графині", fen = "A shard gifted to houses by the Countess as a sign of favor.", fua = "Скалка, якою Графиня обдаровує доми на знак прихильності." }
    t[174377] = { name = "Том Перемоги", fen = "A single book of the seemingly endless volumes of victory.", fua = "Одна книга з немовби нескінченних томів перемоги." }
    t[174378] = { name = "Сувій Мортеґора", fen = "Ritual parchment covered in complex sigils. Can be used to empower Mortegore Sigils.", fua = "Ритуальний пергамент, укритий складними сигілами. Можна застосувати для підсилення Сигілів Мортеґора." }
    t[174382] = { name = "Порошок Смертельного Лотоса", fen = "A powder made from ground up death lotus, among other things. Known for its use in venthyr spells.", fua = "Порошок, виготовлений зокрема з перемеленого смертельного лотоса. Відомий завдяки застосуванню в чарах вентирів." }
    t[174445] = "Кокон Мерехтокрилки"
    t[174454] = { name = "Камінь Гріхів Графині", fen = "Every venthyr who lived a past life has a sinstone. The Countess hid hers, insisting she was born of the Shadowlands.", fua = "Кожен вентир, що прожив минуле життя, має камінь гріхів. Графиня сховала свій, наполягаючи, що народилася в Тінеземлях." }
    t[174464] = "Примарна Вуздечка"
    t[174465] = "Осквернений Компонент Центуріона"
    t[174466] = { name = "Скриня з Інструментами Міканікоса", fen = "Contains Mikanikos's prized tools.", fua = "Містить цінні інструменти Міканікоса." }
    t[174467] = { name = "Здутий Травний Мішок", fen = "Filled with a green, acrid fluid. It's sloshing. A lot.", fua = "Наповнений зеленою їдкою рідиною. Вона хлюпає. Дуже сильно." }
    t[174489] = "Оброблена Шишка Аніми"
    t[174497] = "Чагарникова Ягода"
    t[174498] = { name = "Печатка Каяття", fen = "Once used in the penitential process for souls arriving in Revendreth, it was cast aside long ago for more brutal methods.", fua = "Колись її застосовували в процесі покути для душ, що прибували до Ревендрета, але давно відкинули задля жорстокіших методів." }
    t[174499] = { name = "Підсилені Кістки", fen = "Bones from a construct imbued with anima.", fua = "Кістки конструкта, насиченого анімою." }
    t[174520] = { name = "Чудова Шкіра Емені", fen = "Beautifully tough.", fua = "Прекрасно міцна." }
    t[174524] = "Голка для Нанизування"
    t[174526] = "Згортальні Латки"
    t[174534] = "Котушка Лезонитки"
    t[174629] = { name = "Смарагдовий Камінь", fen = "A dark green stone that is native to Maldraxxus. The House of Rituals uses it to store anima and souls.", fua = "Темно-зелений камінь, рідний для Малдраксу. Дім Ритуалів використовує його для зберігання аніми та душ." }
    t[174643] = { name = "Щоденник Марілета — Обкладинка", fen = "The tattered cover of Marileth's journal. The journal's contents may be found on Plague-Doused Remnants.", fua = "Подерта обкладинка щоденника Марілета. Вміст щоденника можна знайти на просочених чумою рештках." }
    t[174645] = { name = "Гілка Гормопаса", fen = "It looks well-used, but maintained. The maker's mark seems familiar...", fua = "На вигляд добре зношений, але доглянутий. Тавро майстра видається знайомим..." }
    t[174655] = { name = "Дзвін Пам'яті", fen = "Brittle and damaged.", fua = "Крихкий і пошкоджений." }
    t[174674] = { name = "Дзвін Пам'яті", fen = "Brittle and damaged.", fua = "Крихкий і пошкоджений." }
    t[174741] = { name = "Дзвін Пам'яті", fen = "Brittle and damaged.", fua = "Крихкий і пошкоджений." }
    t[174745] = { name = "Скалка Скла Спогадів", fen = "What is broken can be reforged.", fua = "Що зламане, можна перекувати." }
    t[174750] = { name = "Спогадна Аніма", fen = "Suffused with reminiscence.", fua = "Сповнена спогадів." }
    t[174755] = { name = "Виклик Обраних", fen = "A summons to be presented to the wayward baroness.", fua = "Виклик, який слід вручити свавільній баронесі." }
    t[174781] = { name = "Улюблений Молот Анісікоса", fen = "A little damp, but nothing a few good swings won't fix.", fua = "Трохи вологий, але ніщо, чого не виправить кілька добрих ударів." }
    t[174821] = { name = "Курива Наставництва", fen = "Used by aspirants to guide their way during their final trial.", fua = "Аспіранти використовують його, щоб освітити свій шлях під час останнього випробування." }
    t[174839] = { name = "Пропозиція Працевлаштування", fen = "Details the roles, responsibilities, and compensation for members of the Thornhill Manor staff.", fua = "Описує ролі, обов'язки та винагороду для працівників маєтку Торнгілл." }
    t[174843] = { name = "Серпошипний Порошок Витівок", fen = "For Tricks and Untricks!", fua = "Для витівок і противитівок!" }
    t[174844] = "Жмут Хутра Скрадача"
    t[174845] = "Вінок із Квітів Нічного Серпанку"
    t[174854] = { name = "Переповнене Ядро Анімуса", fen = "The hideous heart still beats.", fua = "Огидне серце досі б'ється." }
    t[174877] = "Шовк Ґраббі"
    t[174923] = "Еліксир Сутінкового Багна"
    t[174930] = { name = "Камінь Гріхів Інквізиторки Стелії", fen = "A long list of murderous sins.", fua = "Довгий перелік смертельних гріхів." }
    t[174934] = { name = "Заряджений Анімою Малдрацит", fen = "A crystal charged with anima.", fua = "Кристал, заряджений анімою." }
    t[174935] = "М'ясо Кролика"
    t[174938] = "Сутність Пожирача"
    t[174940] = "Прадавня Серцевина"
    t[174957] = { name = "Рапіра Абеля", fen = "Proof of Abel's untimely demise.", fua = "Свідчення передчасної загибелі Абеля." }
    t[174991] = "Коренева Волокнина Вічного Життя"
    t[174997] = "Оберемок Деревини"
    t[174998] = "Ключ Склепу Заприсяжених"
    t[175011] = "Веспер Польоту Крізь Завісу"
    t[175012] = "Танцюючий Цвіркун"
    t[175069] = { name = "Театральний Квиток", fen = "Welcome to the show.", fua = "Ласкаво просимо на виставу." }
    t[175111] = { name = "Кістномозкова Личинка", fen = "Wiggly and very chewy.", fua = "Звивиста й дуже жилава." }
    t[175114] = { name = "Ренні", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[175133] = "Кістяна Бойова Кольчуга"
    t[175137] = "Клапоть Подертого Сувою"
    t[175138] = { name = "Запечатаний Сувій Гнилі Душі", fen = "The magic inside the scroll wants to be let out, but you refrain from tearing apart the parchment.", fua = "Магія всередині сувою прагне вирватися назовні, але ви утримуєтеся від того, щоб роздерти пергамент." }
    t[175139] = { name = "Зачеплена Збитошністю Аніма", fen = "Something's a little off about this anima.", fua = "З цією анімою щось трохи не так." }
    t[175149] = { name = "Маленька Різьба Ісери", fen = "Rough edges smoothed by time and handling, the ancient wood carving has been preserved by high quality protection spells.", fua = "Шорсткі краї згладжені часом і доторками; ця прадавня різьба по дереву збереглася завдяки високоякісним захисним закляттям." }
    t[175152] = { name = "Вкрита Слизом Книга Таємниць", fen = "Surprisingly, the gorm matriarch's digestive juices haven't had much effect on the book's protections.", fua = "Як не дивно, травні соки гормської матріарх майже не вплинули на захист книги." }
    t[175153] = "Посудина Арденвельду"
    t[175154] = { name = "Невимовлена Таємниця", fen = "Sealed so it cannot be read aloud.", fua = "Запечатана, щоб її не можна було прочитати вголос." }
    t[175241] = "Експедиційне Зілля Зцілення"
    t[175247] = { name = "Незвично Великий Гриб", fen = "This rapidly decaying mushroom requires loamy soil in order to survive.", fua = "Цей гриб швидко гниє і потребує суглинистого ґрунту, щоб вижити." }
    t[175248] = "Клинок Самовідданого Носія"
    t[175249] = "Дротик Самовідданого Збирача"
    t[175251] = "Роздвоєне Лезо Стійкості"
    t[175254] = "Палаючий Маяк Надії"
    t[175275] = { name = "Сувій Шляху", fen = "A carefully inscribed scroll that tells the history of an aspirant becoming a Kyrian.", fua = "Ретельно списаний сувій, що оповідає історію про те, як аспірант стає кіріанцем." }
    t[175276] = { name = "Філактерій Кел'Тузада", fen = "A batterd and old earthenware vessel, with Kirin Tor designs on it, this phylactery comes from Azeroth.", fua = "Пощерблений старий глиняний посуд з візерунками Кірін-Тора — цей філактерій походить з Азероту." }
    t[175277] = "Частина Однострою Зречених"
    t[175279] = "Ксифос Заблуканої Душі"
    t[175384] = { name = "Скалка Скла", fen = "A small piece of reflective glass with jagged, sharp edges.", fua = "Маленький шматок дзеркального скла із зазубреними, гострими краями." }
    t[175410] = { name = "Витяжка Жахотіні", fen = "A highly versatile, potentially deadly reagent.", fua = "Вкрай універсальний, потенційно смертоносний реагент." }
    t[175413] = { name = "Пляшечка Аніми", fen = "A small vial of condensed anima often used for barter with brokers.", fua = "Маленька пляшечка згущеної аніми, яку часто використовують для обміну з посередниками." }
    t[175414] = "Каменекований Головний Убір"
    t[175415] = "Шати Стражденного Відпущення"
    t[175416] = "Каменекований Нагрудник"
    t[175417] = "Кольчуга Мисливця за Душами"
    t[175418] = "Огорнутий Ніччю Жилет"
    t[175423] = "Чіпкі Рукавички з Парасолькою"
    t[175424] = { name = "Поліровані Латні Рукавиці Габбінса", fen = "Good for signalling Tubbins across a distance, but bad when others see.", fua = "Добре подавати сигнали Таббінсу на відстані, але погано, коли інші бачать." }
    t[175425] = "Жаротривкі Прихватки Чайника Таббінса"
    t[175426] = "Рукавиці, Стійкі до Гулячих Зубів"
    t[175427] = "Каптур Стражденного Відпущення"
    t[175428] = "Шолом Мисливця за Душами"
    t[175429] = "Огорнутий Ніччю Каптур"
    t[175430] = "Камінно Ковані Поножі"
    t[175431] = "Поножі Стражденного Спокутування"
    t[175432] = "Поножі Мисливця за Душами"
    t[175433] = "Штани, Огорнуті Ніччю"
    t[175434] = "Огорнуті Ніччю Наплічники"
    t[175435] = "Каменековані Наплічники"
    t[175436] = "Оплічник Болісного Відпущення"
    t[175437] = "Наплічники Мисливця за Душами"
    t[175438] = "Каменекований Пояс"
    t[175439] = "Пояс Стражденного Відпущення"
    t[175440] = "Пояс Мисливця за Душами"
    t[175441] = "Огорнутий Ніччю Пояс"
    t[175442] = "Обмотки Стражденного Спокути"
    t[175443] = "Каменековані Наручі"
    t[175444] = "Наручі Мисливця за Душами"
    t[175445] = "Огорнуті Ніччю Пов'язки"
    t[175446] = "Шолом Жорстокого Ката"
    t[175447] = "Роба Трупозшивача"
    t[175448] = "Нагрудник Жорстокого Ката"
    t[175449] = "Кольчуга Архітектора Плоті"
    t[175450] = "Жилет Підступного Агента"
    t[175451] = "Бойові Чоботи Жорстокого Ката"
    t[175452] = "Чоботи Трупозшивача"
    t[175453] = "Чоботи Архітектора Плоті"
    t[175454] = "Чоботи Підступного Агента"
    t[175455] = "Рукавички Улюбленого Учня"
    t[175456] = "Трощителі Грізного Послушника"
    t[175457] = "Рукавиці Улюбленого Учня"
    t[175458] = "Латні Рукавиці Улюбленого Фанатика"
    t[175459] = "Каптур Трупозшивача"
    t[175460] = "Каптур Архітектора Плоті"
    t[175461] = "Шолом Підступного Агента"
    t[175462] = "Поножі Жорстокого Ката"
    t[175463] = "Поножі Зшивача Трупів"
    t[175464] = "Поножі Архітектора Плоті"
    t[175465] = "Штани Підступного Агента"
    t[175466] = "Наплічники Підступного Агента"
    t[175467] = "Наплічники Жорстокого Ката"
    t[175468] = "Оплічник Трупозшивача"
    t[175469] = "Оплічник Архітектора Плоті"
    t[175470] = "Пояс Жорстокого Ката"
    t[175471] = "Пояс Трупозшивача"
    t[175472] = "Пояс Архітектора Плоті"
    t[175473] = "Пояс Підступного Агента"
    t[175474] = "Наручі Трупозшивача"
    t[175475] = "Наручі Жорстокого Ката"
    t[175476] = "Наручі Архітектора Плоті"
    t[175477] = "Наручі Підступного Агента"
    t[175478] = { name = "Щоденник Корріма", fen = "The ramblings in this journal mention the Fathomless Vial. It might be worth asking Marileth about it.", fua = "Маячня в цьому щоденнику згадує Бездонну Пляшечку. Можливо, варто запитати про неї Марілета." }
    t[175479] = "Каменекований Каптур"
    t[175480] = "Роба Болісної Спокути"
    t[175481] = "Каменекована Кольчуга"
    t[175482] = "Жилет Мисливця за Душами"
    t[175483] = "Огорнутий Ніччю Нагрудник"
    t[175484] = "Каменековані Чоботи"
    t[175485] = "Черевики Болісного Відпущення"
    t[175486] = "Чоботи Мисливця за Душами"
    t[175487] = "Огорнуті Ніччю Черевики"
    t[175488] = "Огорнуті Ніччю Рукавиці"
    t[175489] = "Каменековані Латні Рукавиці"
    t[175490] = "Рукавички Стражденного Відпущення"
    t[175491] = "Рукавиці Мисливця за Душами"
    t[175492] = "Каптур Болісного Відпущення"
    t[175493] = "Наголів'я Мисливця за Душами"
    t[175494] = "Огорнутий Ніччю Шолом"
    t[175495] = "Камінно Ковані Поножі"
    t[175496] = "Штани Стражденної Спокути"
    t[175497] = "Поножі Мисливця за Душами"
    t[175498] = "Штани, Огорнуті Ніччю"
    t[175499] = "Огорнуті Ніччю Наплічники"
    t[175500] = "Каменековані Наплічники"
    t[175501] = "Наплічники Болісного Відпущення"
    t[175502] = "Оплічник Мисливця за Душами"
    t[175503] = "Каменекований Широкий Пояс"
    t[175504] = "Пояс Болісного Спокутування"
    t[175505] = "Пояс Мисливця за Душами"
    t[175506] = "Огорнутий Ніччю Пояс"
    t[175507] = "Наручі Стражденної Спокути"
    t[175508] = "Каменековані Наручі"
    t[175509] = "Наручі Мисливця за Душами"
    t[175510] = "Огорнуті Ніччю Наручі"
    t[175511] = "Налобник Полеглого Захисника"
    t[175516] = "Чоботи Жорстокого Ката"
    t[175517] = "Капці Трупозшивача"
    t[175518] = "Галоші Архітектора Плоті"
    t[175519] = "Чоботи Підступного Агента"
    t[175524] = "Обличчя Воскреслого Підмайстра"
    t[175525] = "Каптур Забутого Переслідувача"
    t[175526] = "Каптур Лютого Відвойовника"
    t[175527] = "Поножі Жорстокого Ката"
    t[175528] = "Штани Зшивача Трупів"
    t[175529] = "Поножі Архітектора Плоті"
    t[175530] = "Поножі Підступного Агента"
    t[175531] = "Наплічники Підступного Агента"
    t[175532] = "Наплічники Жорстокого Ката"
    t[175533] = "Оплічник Трупозшивача"
    t[175534] = "Наплічники Архітектора Плоті"
    t[175543] = "Чорнотерновий Шолом"
    t[175544] = "Роба Мерехтливого Гілля"
    t[175545] = "Чорнотерновий Нагрудник"
    t[175546] = "Сутінковий Нагрудник"
    t[175547] = "Жилет Сутінкового Будяка"
    t[175548] = "Чорнотернові Бойові Чоботи"
    t[175549] = "Чоботи Мерехтливого Гілля"
    t[175550] = "Сутінкові Чоботи"
    t[175551] = "Чоботи Сутінкового Будяка"
    t[175552] = "Рукавички Сутінкового Будяка"
    t[175553] = "Чорнотернові Латні Рукавиці"
    t[175554] = "Рукавички Мерехтливого Гілля"
    t[175555] = "Сутінкові Латні Рукавиці"
    t[175556] = "Каптур Мерехтливого Гілля"
    t[175557] = "Сутінковий Шолом"
    t[175558] = "Шолом Сутінкового Будяка"
    t[175559] = "Поножі Чорного Терну"
    t[175560] = "Поножі Мерехтливого Гілля"
    t[175561] = "Сутінкові Поножі"
    t[175562] = "Штани Сутінкового Будяка"
    t[175563] = "Наплічники Сутінкового Будяка"
    t[175564] = "Чорнотернові Наплічники"
    t[175565] = "Оплічник Мерехтливого Гілля"
    t[175566] = "Сутінкові Наплічники"
    t[175567] = "Чорнотерновий Пояс"
    t[175568] = "Шнур Мерехтливого Гілля"
    t[175569] = "Сутінковий Пояс"
    t[175570] = "Пояс Сутінкового Будяка"
    t[175571] = "Наручні Обмотки Мерехтливого Гілля"
    t[175572] = "Чорнотернові Наручі"
    t[175573] = "Сутінкові Напульсники"
    t[175574] = "Наручі Сутінкового Будяка"
    t[175576] = "Сплетене Феями Вбрання"
    t[175581] = "Сплетені Феями Сандалі"
    t[175586] = "Сплетені Феями Обмотки Рук"
    t[175588] = "Сплетений Феями Каптур"
    t[175592] = "Поножі, Сплетені Феями"
    t[175597] = "Сплетений Феями Нараменник"
    t[175600] = "Сплетений Феями Кушак"
    t[175603] = "Сплетені Феями Наручі"
    t[175612] = "Бойові Чоботи Розсудливого Претендента"
    t[175613] = "Чоботи Чистого Претендента"
    t[175614] = "Чоботи Смиренного Претендента"
    t[175615] = "Чоботи Мужнього Претендента"
    t[175616] = "Рукавички Мужнього Претендента"
    t[175617] = "Латні Рукавиці Розсудливого Претендента"
    t[175618] = "Рукавички Чистого Претендента"
    t[175619] = "Латні Рукавиці Смиренного Претендента"
    t[175623] = "Поножі Розважливого Претендента"
    t[175624] = "Поножі Чистого Претендента"
    t[175625] = "Поножі Скромного Претендента"
    t[175626] = "Штани Відважного Адепта"
    t[175635] = "Наручі Чистого Претендента"
    t[175636] = "Наручі Розсудливого Претендента"
    t[175637] = "Наручі Смиренного Претендента"
    t[175638] = "Наручі Мужнього Претендента"
    t[175647] = "Великий Шолом Вартового Гаю"
    t[175648] = "Роба Доглядача Духів"
    t[175649] = "Нагрудник Вартового Гаю"
    t[175650] = "Кольчуга Сонного Терену"
    t[175651] = "Жилет Зоряного Покрову"
    t[175652] = "Бойові Чоботи Вартового Гаю"
    t[175653] = "Капці Доглядача Духів"
    t[175654] = "Чоботи Сонного Терену"
    t[175655] = "Чоботи Зоряного Покрову"
    t[175656] = "Рукавички Зоряного Покрову"
    t[175657] = "Латні Рукавиці Вартового Гаю"
    t[175658] = "Рукавички Доглядача Духів"
    t[175659] = "Рукавиці Сонного Терену"
    t[175660] = "Каптур Доглядача Духів"
    t[175661] = "Наголовник Сонного Терену"
    t[175662] = "Шолом Зоряного Покрову"
    t[175663] = "Поножі Хранителя Гаю"
    t[175664] = "Поножі Опікуна Духів"
    t[175665] = "Поножі Сновійного Терня"
    t[175666] = "Штани Зоряного Савану"
    t[175667] = "Наплічники Зоряного Покрову"
    t[175668] = "Наплічники Вартового Гаю"
    t[175669] = "Оплічник Доглядача Духів"
    t[175670] = "Наплічники Сонного Терену"
    t[175671] = "Пояс Вартового Гаю"
    t[175672] = "Пояс Доглядача Духів"
    t[175673] = "Ланцюг Сонного Терену"
    t[175674] = "Пояс Зоряного Покрову"
    t[175675] = "Наручі Доглядача Духів"
    t[175676] = "Наручі Вартового Гаю"
    t[175677] = "Наручі Сонного Терену"
    t[175678] = "Наручі Зоряного Покрову"
    t[175703] = "Перстень Срібного Шпиля"
    t[175704] = "Лункий Срібний Перстень"
    t[175706] = "Перстень Розідраного Розуму"
    t[175707] = "Перстень-Печатка Обізнаного"
    t[175708] = { name = "Відновлений Сімейний Медальйон", fen = "We are still together, forever, even when we find ourselves apart.", fua = "Ми завжди разом, навіки, навіть коли опиняємося нарізно." }
    t[175710] = "Перстень Нічного Придворного"
    t[175711] = "Перстень із Дрімотного Дерева"
    t[175712] = "Перстень Мерехтливого Гілля"
    t[175713] = "Перстень Гілкочортополоху"
    t[175714] = "Потьмянілий Перстень-Печатка Камергера"
    t[175715] = "Перстень з Оком Ґарґона"
    t[175716] = "Жаропалений Перстень"
    t[175717] = "Перстень-Печатка Інквізитора"
    t[175718] = "Герб Піднесеного Захисника"
    t[175719] = "Вістря Списа Аґтії, Торкнуте Порожнечею"
    t[175722] = "Флакон Їдкої Рідини"
    t[175723] = "Сироватка Оновлення"
    t[175725] = "Гладіаторський Значок Новачка"
    t[175726] = "Водоростик Первісника"
    t[175727] = "Грозове Зерно Старійшини"
    t[175728] = "Корінь Просіювача Душ"
    t[175729] = "Паросток Гнилого Терну"
    t[175730] = "Розписка Майстра Дуелей"
    t[175731] = "Викрадений Знак Пащі"
    t[175732] = { name = "Табличка Відчаю", fen = "Sometimes a tool in the wrong hands is a weapon.", fua = "Іноді знаряддя в чужих руках стає зброєю." }
    t[175733] = "Переповнена Жарінь-Скалка"
    t[175736] = "Амулет Згубника Надії"
    t[175737] = "Амулет-Чорнильниця Саму"
    t[175739] = "Відновлене Малдраксійське Намисто"
    t[175740] = "Гривня Валешрауд"
    t[175741] = "Горжет із Ґормгрісу"
    t[175751] = { name = "Просочений Рубін", fen = "Pulses with a steady heartbeat.", fua = "Пульсує рівним серцебиттям." }
    t[175752] = { name = "Уламок Дзеркала", fen = "Can be used to rebuild Broken Mirrors throughout Revendreth.", fua = "Можна використати, щоб відбудувати розбиті дзеркала по всьому Ревендреті." }
    t[175753] = { name = "Загартована Життям Аніма", fen = "The hard core of a spent chrysalis. The anima has almost crystallized, but glimmers with potential.", fua = "Тверде осердя спрацьованого кокона. Аніма майже скристалізувалася, але мерехтить потенціалом." }
    t[175754] = "Знак Смирення"
    t[175755] = "Знак Знання"
    t[175756] = { name = "Медальйон Панування", fen = "Its immense power passively pulls in anima from the air around it.", fua = "Його неосяжна сила пасивно притягує аніму з навколишнього повітря." }
    t[175762] = { name = "Плащ Приборкувача Леріонів", fen = "Let's get dangerous.", fua = "Ану, до небезпеки." }
    t[175763] = "Врятований Плащ Найманця"
    t[175765] = "Покров Жахокрила"
    t[175766] = "Мисливський Плащ Ілки"
    t[175767] = "Великий Плащ Блискокрилих"
    t[175769] = "Грамота Констеллана"
    t[175770] = { name = "Медальйон Жаху", fen = "Bestowed upon Venthyr by The Sire himself. Allows the wearer to exert partial dominion over Revendreth.", fua = "Дарований вентирам самим Сіром. Дозволяє власнику частково панувати над Ревендретом." }
    t[175788] = { name = "Спокійний Пігмент", fen = "Found when milling rare herbs native to the Shadowlands.", fua = "Знаходиться при подрібненні рідкісних трав, рідних для Тіньокраю." }
    t[175791] = { name = "Крило Аріелли", fen = "Not a single feather is out of place.", fua = "Жодна пір'їна не випадає з місця." }
    t[175792] = { name = "Льотне Перо Леріона", fen = "Pristine plumage from a larion's wing.", fua = "Бездоганне оперення з крила леріона." }
    t[175794] = { name = "Кільце з Ключами", fen = "A small ring of keys, clearly for the various prison doors around the crypt.", fua = "Маленьке кільце з ключами, вочевидь для різних в'язничних дверей по всій крипті." }
    t[175795] = { name = "Око Зрадника", fen = "The truth lingers inside it still.", fua = "Правда досі ховається в ньому." }
    t[175826] = { name = "Попелясті Чипси", fen = "Lightly dusted.", fua = "Злегка припорошені." }
    t[175828] = { name = "Дзеркальна Цукерка", fen = "No pain, no flavor.", fua = "Без болю немає смаку." }
    t[175829] = { name = "Липкі Комашині Шматочки", fen = "Regret is 100% guaranteed.", fua = "Жаль гарантований на 100%." }
    t[175840] = { name = "Легка Перекуска", fen = "This will certainly give Stonehead a tummy ache.", fua = "Це напевно дасть Каменюзі біль у животі." }
    t[175843] = "Віспяні Вузли"
    t[175850] = "Латний Шолом Грішного Претендента"
    t[175851] = "Плащ Грішного Претендента"
    t[175852] = "Шовкова Роба Грішного Претендента"
    t[175853] = "Латний Нагрудник Грішного Претендента"
    t[175854] = "Кольчужний Жилет Грішного Претендента"
    t[175855] = "Шкіряний Жилет Грішного Претендента"
    t[175856] = "Латні Бойові Чоботи Грішного Претендента"
    t[175857] = "Шовкові Чоботи Грішного Претендента"
    t[175858] = "Кольчужні Чоботи Грішного Претендента"
    t[175859] = "Шкіряні Чоботи Грішного Претендента"
    t[175860] = "Шкіряні Рукавички Грішного Претендента"
    t[175861] = "Латні Рукавиці Грішного Претендента"
    t[175862] = "Шовкові Рукавички Грішного Претендента"
    t[175863] = "Кольчужні Латні Рукавиці Грішного Претендента"
    t[175864] = "Шовковий Каптур Грішного Претендента"
    t[175865] = "Кольчужний Шолом Грішного Претендента"
    t[175866] = "Шкіряний Шолом Грішного Претендента"
    t[175867] = "Латні Поножі Грішного Претендента"
    t[175868] = "Шовкові Поножі Грішного Претендента"
    t[175869] = "Кольчужні Поножі Грішного Претендента"
    t[175870] = "Шкіряні Штани Грішного Претендента"
    t[175871] = "Шкіряні Оплічники Грішного Претендента"
    t[175872] = "Латні Оплічники Грішного Претендента"
    t[175873] = "Шовковий Оплічник Грішного Претендента"
    t[175874] = "Кольчужні Оплічники Грішного Претендента"
    t[175875] = "Латний Пояс Грішного Претендента"
    t[175876] = "Шовковий Шнур Грішного Претендента"
    t[175877] = "Кольчужний Пояс Грішного Претендента"
    t[175878] = "Шкіряний Пояс Грішного Претендента"
    t[175879] = "Перстень Грішного Претендента"
    t[175880] = "Шовкові Наручі Грішного Претендента"
    t[175881] = "Латні Манжети Грішного Претендента"
    t[175882] = "Кольчужні Наручні Обмотки Грішного Претендента"
    t[175883] = "Шкіряні Наручні Обмотки Грішного Претендента"
    t[175884] = "Жетон Лютості Грішного Претендента"
    t[175885] = "Намисто Грішного Претендента"
    t[175886] = { name = "Темний Пергамент", fen = "A thicker stock than normal parchment, it can be lightly engraved by a Scribe.", fua = "Цупкіший за звичайний пергамент, його може злегка гравіювати писар." }
    t[175887] = "Латний Шолом Грішного Гладіатора"
    t[175888] = "Плащ Грішного Гладіатора"
    t[175889] = "Шовкова Роба Грішного Гладіатора"
    t[175890] = "Латний Нагрудник Грішного Гладіатора"
    t[175891] = "Кольчужний Нагрудник Грішного Гладіатора"
    t[175892] = "Шкіряний Нагрудник Грішного Гладіатора"
    t[175893] = "Латні Бойові Чоботи Грішного Гладіатора"
    t[175894] = "Шовкові Капці Грішного Гладіатора"
    t[175895] = "Кольчужні Чоботи Грішного Гладіатора"
    t[175896] = "Шкіряні Чоботи Грішного Гладіатора"
    t[175897] = "Шкіряні Рукавички Грішного Гладіатора"
    t[175898] = "Латні Рукавиці Грішного Гладіатора"
    t[175899] = "Шовкові Рукавички Грішного Гладіатора"
    t[175900] = "Кольчужні Латні Рукавиці Грішного Гладіатора"
    t[175901] = "Шовковий Каптур Грішного Гладіатора"
    t[175902] = "Кольчужний Шолом Грішного Гладіатора"
    t[175903] = "Шкіряний Шолом Грішного Гладіатора"
    t[175904] = "Латні Поножі Грішного Гладіатора"
    t[175905] = "Шовкові Поножі Грішного Гладіатора"
    t[175906] = "Кольчужні Поножі Грішного Гладіатора"
    t[175907] = "Шкіряні Штани Грішного Гладіатора"
    t[175908] = "Шкіряні Наплічники Грішного Гладіатора"
    t[175909] = "Латні Наплічники Грішного Гладіатора"
    t[175910] = "Шовковий Оплічник Грішного Гладіатора"
    t[175911] = "Кольчужні Наплічники Грішного Гладіатора"
    t[175912] = "Латний Пояс Грішного Гладіатора"
    t[175913] = "Шовковий Пояс Грішного Гладіатора"
    t[175914] = "Кольчужний Пояс Грішного Гладіатора"
    t[175915] = "Шкіряний Пояс Грішного Гладіатора"
    t[175916] = "Перстень Грішного Гладіатора"
    t[175917] = "Шовкові Наручі Грішного Гладіатора"
    t[175918] = "Латні Наручі Грішного Гладіатора"
    t[175919] = "Кольчужні Наручі Грішного Гладіатора"
    t[175920] = "Шкіряні Наручі Грішного Гладіатора"
    t[175921] = "Жетон Лютості Грішного Гладіатора"
    t[175922] = "Намисто Грішного Гладіатора"
    t[175923] = { name = "Ардендеревина", fen = "The surface of this pale wood twinkles softly, as if varnished in starlight.", fua = "Поверхня цієї блідої деревини м'яко мерехтить, ніби вкрита лаком зоряного сяйва." }
    t[175924] = "Контракт: Невмируще Військо"
    t[175941] = { name = "Духовний Алхімічний Камінь", fen = "Can be used for transmutations in place of a Philosopher's Stone.", fua = "Можна використовувати для трансмутацій замість Філософського Каменя." }
    t[175942] = { name = "Духовний Алхімічний Камінь", fen = "Can be used for transmutations in place of a Philosopher's Stone.", fua = "Можна використовувати для трансмутацій замість Філософського Каменя." }
    t[175943] = { name = "Духовний Алхімічний Камінь", fen = "Can be used for transmutations in place of a Philosopher's Stone.", fua = "Можна використовувати для трансмутацій замість Філософського Каменя." }
    t[175954] = "Просякнутий Ріг"
    t[175955] = "Тіньова Шкура"
    t[175956] = "PH Unusual"
    t[175957] = "Пухнаста Лапа"
    t[175959] = "Шовковиста Грива"
    t[175960] = "Карбована Кістка"
    t[175962] = "Ріг Сонного Лісу"
    t[175964] = "PH Frequent"
    t[175965] = "Голчастий Дзьоб"
    t[175967] = { name = "Волокно Етервірма", fen = "Surprisingly strong anima-infused strands from an etherwyrm's tail.", fua = "Напрочуд міцні просочені анімою пасма з хвоста етервірма." }
    t[175968] = { name = "Цвіт Анімілісу", fen = "The extremely pungent bloom of the Animyllis bulb.", fua = "Надзвичайно різко пахнучий цвіт цибулини анімілісу." }
    t[175970] = { name = "Спокійне Чорнило", fen = "Crafted by players with the Inscription skill. Can be bought and sold on the auction house.", fua = "Виготовлено гравцями з умінням Знакарства. Можна купити й продати на аукціоні." }
    t[175971] = { name = "Невибухла Чумна Бомба", fen = "Don't shake it.", fua = "Не трясіть її." }
    t[175972] = { name = "Просочена Анімою Отрута", fen = "This acidic venom is not only highly corrosive, but also infused with anima. It's a powerful reagent in spells and poisons.", fua = "Ця кислотна отрута не лише вкрай їдка, а й просочена анімою. Це потужний реагент для заклять і трутизн." }
    t[175973] = { name = "Кіготь Спустошувача", fen = "A thick impossibly sharp talon, this could serve as a knife.", fua = "Товстий, неймовірно гострий кіготь — міг би послужити ножем." }
    t[175974] = { name = "Цілісна Стегнова Кістка", fen = "The longest bone in most humanoids bodies, a femur is an excellent base for building a strong vessel.", fua = "Стегнова кістка, найдовша кістка в тілі більшості гуманоїдів, є чудовою основою для створення міцного вмістища." }
    t[175982] = { name = "Список Справ із Серпошипу", fen = "A scribbled note of directions.", fua = "Нашкрябана записка з вказівками." }
    t[175983] = "Лук із Серцевини Дерева"
    t[175984] = "Кинджал Серцевини"
    t[175985] = "Гамселій Захисника Гаю"
    t[175986] = "Молот Захисника Гаю"
    t[175987] = "Спис Захисника Гаю"
    t[175988] = "Посох Хранительки Лугів"
    t[175989] = "Меч Захисника Гаю"
    t[175990] = "Щит Хранительки Луки"
    t[175992] = "Бойова Глефа Серцевини"
    t[176052] = { name = "Поясна Пряжка із Залізним Черепом", fen = "You may call it gaudy. Venthyr call it fashion.", fua = "Ви можете назвати її кричущою. Вентири називають її модою." }
    t[176053] = { name = "Плісований Плащ", fen = "The perfect touch of drama that every venthyr needs.", fua = "Ідеальний штрих драматизму, потрібний кожному вентиру." }
    t[176054] = { name = "Ботфорти", fen = "Molded perfectly for somebody. That somebody is not you.", fua = "Ідеально припасовані для когось. Той хтось — не ви." }
    t[176055] = { name = "Шнуровані Наручі", fen = "Ask a tortured soul to lace yours today!", fua = "Попросіть катовану душу зашнурувати ваші вже сьогодні!" }
    t[176057] = "Плазма Маркграфині Страдами"
    t[176058] = "Запрошення: Баронеса Вашж"
    t[176081] = "Книга Планування Свят Темеля"
    t[176082] = { name = "Безглузда Балаканина", fen = "Hollow gossip between nobles.", fua = "Порожні плітки між шляхтичами." }
    t[176083] = { name = "Особиста Образа", fen = "A scathing letter of lost trust.", fua = "Нищівний лист про втрачену довіру." }
    t[176084] = { name = "Список Вимог", fen = "Blackmail taken too far.", fua = "Шантаж, що зайшов задалеко." }
    t[176085] = "Одяг Вентирів"
    t[176086] = "Кошмарний Намул"
    t[176087] = "Хітин Ґорма"
    t[176088] = "Ґормгріс"
    t[176089] = "Жвало Деревохапа"
    t[176090] = "Запрошення: Леді Мунберрі"
    t[176091] = "Запрошення: Графиня"
    t[176092] = "Запрошення: Міканікос"
    t[176093] = "Запрошення: Александрос Мограйн"
    t[176094] = "Запрошення: Почесний Гість 6"
    t[176096] = "PH Mawsworn Humanoid Drop"
    t[176097] = "Запрошення: Баронеса Вашж"
    t[176098] = "Довгий Лук Шукача Істини"
    t[176112] = "Запрошення: Леді Мунберрі"
    t[176113] = "Запрошення: Міканікос"
    t[176114] = "Запрошення: Графиня"
    t[176115] = "Запрошення: Александрос Мограйн"
    t[176116] = "Запрошення: Капітан Полювання Корайн"
    t[176117] = "Запрошення: Полемарх Адрестес"
    t[176118] = "Запрошення: Рендл і Кийломорда"
    t[176119] = "Запрошення: Чуфа"
    t[176120] = "Запрошення: Хранитель Склепу Кассір"
    t[176121] = "Запрошення: Дроман Аліоте"
    t[176122] = "Запрошення: Грандмайстер Воул"
    t[176123] = "Запрошення: Клея і Пелагос"
    t[176124] = "Запрошення: Чумотворець Марілет"
    t[176125] = "Запрошення: Сіка"
    t[176126] = "Контракт: Традиційне Оформлення"
    t[176127] = "Контракт: Загадкові Дзеркала"
    t[176128] = "Контракт: Згадки про Смертність"
    t[176129] = "Контракт: Оздоблення 4"
    t[176130] = "Контракт: Ритуали Спокути"
    t[176131] = "Контракт: Погляд на Дикі Землі"
    t[176132] = "Контракт: Загублений Келих"
    t[176133] = "Контракт: Розваги 4"
    t[176134] = "Контракт: Чаювання Таббінса"
    t[176135] = "Контракт: Божественні Десерти"
    t[176136] = "Контракт: Грибний Сюрприз!"
    t[176137] = "Контракт: Частування 4"
    t[176138] = "Контракт: Добровольці Вентирів"
    t[176139] = "Контракт: Резерви Каменероджених"
    t[176140] = "Контракт: Малдраксійське Військо"
    t[176141] = "Контракт: Охорона 4"
    t[176215] = { name = "Скалка Графині", fen = "A shard gifted to houses by the Countess as a sign of favor.", fua = "Скалка, якою Графиня обдаровує доми на знак прихильності." }
    t[176277] = "Кинджал Безжального Суперника"
    t[176278] = "Молот Безжального Суперника"
    t[176279] = "Посох Безжального Суперника"
    t[176280] = "Меч Безжального Суперника"
    t[176281] = "Арбалет Безжального Суперника"
    t[176282] = "Чарівна Паличка Безжального Суперника"
    t[176283] = "Клеймор Безжального Суперника"
    t[176284] = "Щит Безжального Суперника"
    t[176285] = "Фоліант Безжального Суперника"
    t[176286] = "Бойова Глефа Безжального Суперника"
    t[176289] = "Зотлілий Шкіряний Пояс"
    t[176290] = "Зотлілі Шкіряні Чоботи"
    t[176291] = "Зотлілі Шкіряні Рукавички"
    t[176292] = "Зотлілий Шкіряний Каптур"
    t[176293] = "Зношені Шкіряні Штани"
    t[176294] = "Зотлілі Шкіряні Наплічники"
    t[176295] = "Зотліла Шкіряна Безрукавка"
    t[176296] = "Зотлілі Шкіряні Наручі"
    t[176297] = "Поїдені Ґормами Наручі"
    t[176298] = "Поїдені Ґормами Чоботи"
    t[176299] = "Поїдені Ґормами Наплічники"
    t[176300] = "Поножі, Поїдені Ґормами"
    t[176301] = "Поїдений Ґормами Шолом"
    t[176302] = "Поїдені Ґормами Латні Рукавиці"
    t[176303] = "Поїдений Ґормами Нагрудник"
    t[176304] = "Поїдений Ґормами Пояс"
    t[176305] = "Збляклі Шовкові Наручі"
    t[176306] = "Зблякла Шовкова Сорочка"
    t[176307] = "Збляклі Шовкові Сандалі"
    t[176308] = "Вицвілі Шовкові Штани"
    t[176309] = "Збляклі Шовкові Рукавиці"
    t[176310] = "Збляклий Шовковий Каптур"
    t[176311] = "Збляклий Шовковий Пояс"
    t[176312] = "Збляклий Шовковий Амікт"
    t[176313] = "Наручі з Висохлої Луски"
    t[176314] = "Наплічники з Висохлої Луски"
    t[176315] = "Чоботи з Висохлої Луски"
    t[176316] = "Висохлі Лускаті Поножі"
    t[176317] = "Кольчуга з Висохлої Луски"
    t[176318] = "Рукавички з Висохлої Луски"
    t[176319] = "Каптур із Висохлої Луски"
    t[176320] = "Пояс із Висохлої Луски"
    t[176321] = { name = "Гребінець Леді Мунберрі", fen = "It's lovely!", fua = "Чарівний!" }
    t[176330] = "Арбалет Провідної Ноти"
    t[176331] = { name = "Зілля Приховувальної Сутності", fen = "This appears to be more gas than potion. It should obscure you from the Jailer's gaze, delaying his wrath as long as he hasn't already been alerted.", fua = "Це більше схоже на газ, ніж на зілля. Воно має приховати вас від погляду Тюремника, відстрочивши його гнів, доки він іще не насторожений." }
    t[176332] = "Бойова Глефа Срібний Передзвін"
    t[176333] = "Оплот Захисника Мелодії"
    t[176334] = "Довгий Спис Срібного Передзвону"
    t[176335] = "Передзвін Мелодійної Задуми"
    t[176336] = "Руків'я Провідної Ноти"
    t[176337] = "Швидкоклинок Небесного Відтінку"
    t[176338] = "Дворучний Меч Небесного Відтінку"
    t[176339] = "Довбня Небесного Відтінку"
    t[176388] = "Кинджал Провідної Ноти"
    t[176390] = "Молоток Срібний Передзвін"
    t[176391] = "Листяна Антена"
    t[176392] = "Візерунчасте Крило"
    t[176393] = "Дрімотний Порошок"
    t[176396] = { name = "Інструменти з Жахолога", fen = "Can be brought to a Muckborn Craftsman in the Banewood.", fua = "Можна віднести Багнородженому Ремісникові в Лиходоліссі." }
    t[176397] = { name = "Болт із Жахолога", fen = "Can be brought to Wingsmash in the Banewood.", fua = "Можна віднести до Крилоруба в Лиходоліссі." }
    t[176408] = "Капсули Засліпливого Диму"
    t[176409] = { name = "Відживлювальна Висмоктана Сутність", fen = "What... or who am I drinking?", fua = "Що... чи кого я п'ю?" }
    t[176410] = "Скручений Шкіряний Пояс"
    t[176411] = "Скручені Шкіряні Чоботи"
    t[176412] = "Скручені Шкіряні Рукавиці"
    t[176413] = "Скручений Шкіряний Каптур"
    t[176414] = "Поножі зі Спотвореної Шкіри"
    t[176415] = "Скручені Шкіряні Наплічники"
    t[176416] = "Скручена Шкіряна Туніка"
    t[176417] = "Скручені Шкіряні Наручі"
    t[176418] = "Спотворені Латні Наручі"
    t[176419] = "Спотворені Латні Бойові Чоботи"
    t[176420] = "Спотворені Латні Наплічники"
    t[176421] = "Спотворені Латні Поножі"
    t[176422] = "Спотворене Латне Заборало"
    t[176423] = "Спотворені Латні Рукавички"
    t[176424] = "Спотворений Латний Нагрудник"
    t[176425] = "Спотворений Латний Великий Пояс"
    t[176426] = "Заплямовані Тканинні Наручі"
    t[176427] = "Заплямована Тканинна Туніка"
    t[176428] = "Заплямовані Тканинні Капці"
    t[176429] = "Заплямовані Тканинні Обмотки"
    t[176430] = "Заплямовані Тканинні Рукавиці"
    t[176431] = "Заплямований Тканинний Каптур"
    t[176432] = "Заплямований Тканинний Пояс"
    t[176433] = "Заплямований Тканинний Оплічник"
    t[176434] = "Осквернені Кольчужні Наручі"
    t[176435] = "Осквернені Кольчужні Наплічники"
    t[176436] = "Осквернені Кольчужні Чоботи"
    t[176437] = "Осквернені Кольчужні Штани"
    t[176438] = "Осквернений Кольчужний Жилет"
    t[176439] = "Осквернені Кольчужні Рукавиці"
    t[176440] = "Осквернений Кольчужний Шолом"
    t[176441] = "Осквернений Кольчужний Пояс"
    t[176442] = { name = "Вариво з Щурячих Вусів", fen = "May cause coagulated dairy cravings.", fua = "Може спричинити потяг до скислих молочних продуктів." }
    t[176443] = { name = "Зілля Швидкоплинного Шалу", fen = "This potion appears to be boiling even though it is cool to the touch.", fua = "Здається, ніби це зілля кипить, хоча на дотик воно прохолодне." }
    t[176444] = "Сталь Безжального Суперника"
    t[176446] = "Достигле Зерня Аніми"
    t[176448] = { name = "[DNT] [REUSE ME]", fen = "Contains a soul that can be used by an Engineer to power their devices.", fua = "Містить душу, яку інженер може використати, щоб живити свої пристрої." }
    t[176456] = { name = "Ключ від Клітки В'язня", fen = "A key which opens a cage in the Hall of Chains.", fua = "Ключ, що відмикає клітку в Залі Ланцюгів." }
    t[176582] = { name = "Викрадений Лист", fen = "Private correspondence intended for residents of the Redelav District.", fua = "Приватне листування, призначене для мешканців Району Редлав." }
    t[176616] = { name = "[DNT] [REUSE ME]", fen = "Collected by Engineers, it will dissapate unless contained within a Soul Battery.", fua = "Збирається інженерами. Розвіється, якщо не тримати її в Душовій Батареї." }
    t[176760] = { name = "Жало Дзизкривда", fen = "Seems perfect for gormsmithing, you guess.", fua = "Здається, ідеально пасує для гормоковки, гадаєш ти." }
    t[176761] = "Шолом Мерехтокопитих"
    t[176762] = "Шати Тінекрила"
    t[176763] = "Нагрудник Мерехтокопитих"
    t[176764] = "Сталелуската Кольчуга"
    t[176765] = "Темнопірна Туніка"
    t[176766] = "Чоботи Мерехтокопитих"
    t[176767] = "Сандалі Тінекрила"
    t[176768] = "Сталелускаті Чоботи"
    t[176769] = "Темнопірні Чоботи"
    t[176770] = "Темнопірні Рукавиці"
    t[176771] = "Латні Рукавиці Мерехтокопитих"
    t[176772] = "Рукавиці Тінекрила"
    t[176773] = "Сталелускаті Рукавички"
    t[176774] = "Каптур Тінекрила"
    t[176775] = "Сталелускатий Шолом"
    t[176776] = "Темнопірний Шолом"
    t[176777] = "Поножі Мерехтливого Копита"
    t[176778] = "Поножі Тіньокрилі"
    t[176779] = "Поножі Сталевої Луски"
    t[176780] = "Темнопері Штани"
    t[176781] = "Темнопірні Наплічники"
    t[176782] = "Наплічники Мерехтокопитих"
    t[176783] = "Наплічники Тінекрила"
    t[176784] = "Сталелускаті Наплічники"
    t[176785] = "Пояс Мерехтокопитих"
    t[176786] = "Пояс Тінекрила"
    t[176787] = "Сталелускатий Пояс"
    t[176788] = "Темнопірний Пояс"
    t[176789] = "Наручі Тінекрила"
    t[176790] = "Наручні Пластини Мерехтокопитих"
    t[176791] = "Сталелускаті Наручі"
    t[176792] = "Темнопірні Наручі"
    t[176793] = "Арбалет Бездоганної Честі"
    t[176794] = "Позолочена Глефа"
    t[176795] = "Аспіс Захисника"
    t[176796] = "Елізійський Спис"
    t[176797] = "Ритуальний Дзвін"
    t[176798] = "Кіготь Ларіона"
    t[176799] = "Благоговійний Кинджал"
    t[176800] = "Скромний Дворучний Меч"
    t[176801] = "Звільнений Молот"
    t[176802] = "Клинок Споглядача"
    t[176803] = "Гармонійна Довбня"
    t[176805] = { name = "Уламок Обладунка Центуріона", fen = "Metal of this caliber is hard to find, of late.", fua = "Метал такого ґатунку нині важко знайти." }
    t[176806] = { name = "Висотане Осердя Аніми", fen = "Dimly lit. It contains very little power.", fua = "Тьмяно світиться. Містить дуже мало сили." }
    t[176808] = { name = "Волокнистий Наріст", fen = "Full of fiber", fua = "Повний волокон." }
    t[176809] = "Тріснутий Привод"
    t[176810] = "Осердя Центуріона"
    t[176811] = "Зілля Жертовної Аніми"
    t[176812] = "Цвіт Анімілісу"
    t[176832] = { name = "Волокно Кореня Дикого Насіння", fen = "This special root increases the quality of rewards offered by a spirit upon rebirth.", fua = "Цей особливий корінь підвищує якість нагород, які пропонує дух при відродженні." }
    t[176846] = "Щетина Трупної Воші"
    t[176847] = "Вусик Кислого Смокчика"
    t[176850] = { name = "Порожнє Запрошення", fen = "Consumed to bypass the Infused Ruby cost when changing the guests for your next Ember Court. Speak with Lord Garridan in Sinfall.", fua = "Споживається, щоб обійти витрату Просоченого Рубіна під час зміни гостей вашого наступного Попелястого Двору. Поговоріть із Лордом Гарріданом у Гріхопаді." }
    t[176851] = "Кайло Із Залізодерева"
    t[176852] = "Затверділа Хвостова Кістка"
    t[176853] = "Висохла Плоть"
    t[176854] = "Незламна Щелепна Кістка"
    t[176855] = "Їдкий Виділок"
    t[176856] = "Частково Перетравлені Нутрощі"
    t[176858] = "Гнучкий Хвостовий Плавець"
    t[176859] = "Гартований Панцир"
    t[176861] = "Набрякла Отруйна Залоза"
    t[176862] = "Сплюндрована Шкіра"
    t[176864] = "Колюча Нога"
    t[176865] = "Заражений Пилок"
    t[176866] = "Гнильна Твань"
    t[176867] = "Зламані Кайдани"
    t[176868] = "Скалка Ентропії"
    t[176869] = "Кістяна Скалка"
    t[176870] = "Скелетне Ікло"
    t[176871] = "Зміцнені Вусики"
    t[176872] = "Щільне Стебло"
    t[176873] = "Мариновані Реберця"
    t[176874] = "Висохла Плечова Кістка"
    t[176875] = "Кривий Ріг"
    t[176876] = "Зруйнована Психіка"
    t[176877] = "Розщеплений Зуб"
    t[176878] = "Потьмянілий Сувенір"
    t[176884] = "Видовжений Хребет"
    t[176888] = "Бурштиновий Ніж"
    t[176921] = { name = "Часові Листки", fen = "These enchanted leaves reduce the Wildseed of Regrowth process by 1 day.", fua = "Ці зачаровані листки скорочують процес дикого зерна відновлення на 1 день." }
    t[176922] = { name = "Дика Нічецвіть", fen = "This magical bloom increases the yield of crafting materials offered by reborn spirits and catalysts grown from catalyst seeds by 100%.", fua = "Ця магічна квітка збільшує на 100% кількість ремісничих матеріалів, які пропонують відроджені духи та каталізатори, вирощені з насіння каталізатора." }
    t[176929] = "Гнилий Шкіряний Пояс"
    t[176930] = "Гнилі Шкіряні Онучі"
    t[176931] = "Гнилі Шкіряні Обмотки Рук"
    t[176932] = "Гнилий Шкіряний Каптур"
    t[176933] = "Гнилі Шкіряні Поножі"
    t[176934] = "Гнилі Шкіряні Наплічники"
    t[176935] = "Гнилий Шкіряний Камзол"
    t[176936] = "Гнилі Шкіряні Наручі"
    t[176937] = "Сплюндровані Латні Наручі"
    t[176938] = "Сплюндровані Латні Бойові Чоботи"
    t[176939] = "Сплюндровані Латні Наплічники"
    t[176940] = "Сплюндровані Латні Поножі"
    t[176941] = "Сплюндроване Латне Заборало"
    t[176942] = "Сплюндровані Латні Рукавички"
    t[176943] = "Сплюндрований Латний Нагрудник"
    t[176944] = "Сплюндрований Латний Широкий Пояс"
    t[176945] = "Зотлілі Тканинні Наручі"
    t[176946] = "Зотлілі Тканинні Шати"
    t[176947] = "Зотлілі Тканинні Чоботи"
    t[176948] = "Зотлілі Тканинні Поножі"
    t[176949] = "Зотлілі Тканинні Рукавиці"
    t[176950] = "Зотлілий Тканинний Каптур"
    t[176951] = "Зотлілий Тканинний Пояс"
    t[176952] = "Зотлілий Тканинний Оплічник"
    t[176953] = "Крихкі Кольчужні Наручі"
    t[176954] = "Крихкі Кольчужні Наплічники"
    t[176955] = "Крихкі Кольчужні Чоботи"
    t[176956] = "Крихкі Кольчужні Штани"
    t[176957] = "Крихкий Кольчужний Нагрудник"
    t[176958] = "Крихкі Кольчужні Латні Рукавиці"
    t[176959] = "Крихкий Кольчужний Шолом"
    t[176960] = "Крихка Кольчужна Застібка"
    t[176961] = "Наголовник Чорного Гончака"
    t[176962] = "Роба Кривавої Шкіри"
    t[176963] = "Нагрудник Чорного Гончака"
    t[176964] = "Оссеїновий Лускатий Обладунок"
    t[176965] = "Нагрудник із Воєнної Плоті"
    t[176966] = "Бойові Чоботи Чорного Гончака"
    t[176967] = "Черевики Кривавої Шкіри"
    t[176968] = "Оссеїнові Лускаті Чоботи"
    t[176969] = "Чоботи з Воєнної Плоті"
    t[176970] = "Рукавиці з Воєнної Плоті"
    t[176971] = "Латні Рукавиці Чорного Гончака"
    t[176972] = "Рукавички Кривавої Шкіри"
    t[176973] = "Латні Рукавиці із Кістяної Луски"
    t[176974] = "Каптур Кривавої Шкіри"
    t[176975] = "Оссеїновий Лускатий Наголовник"
    t[176976] = "Каркас із Воєнної Плоті"
    t[176977] = "Поножі Чорного Гончака"
    t[176978] = "Поножі Кривавої Шкіри"
    t[176979] = "Поножі з Кістяної Луски"
    t[176980] = "Штани з Бойової Плоті"
    t[176981] = "Наплічники з Воєнної Плоті"
    t[176982] = "Наплічники Чорного Гончака"
    t[176983] = "Оплічник Кривавої Шкіри"
    t[176984] = "Оссеїнові Лускаті Наплічники"
    t[176985] = "Пояс Чорного Гончака"
    t[176986] = "Шнур Кривавої Шкіри"
    t[176987] = "Пояс із Кістяної Луски"
    t[176988] = "Пояс із Воєнної Плоті"
    t[176989] = "Напульсники Кривавої Шкіри"
    t[176990] = "Латні Наручі Чорного Гончака"
    t[176991] = "Наручі із Кістяної Луски"
    t[176992] = "Наручі з Воєнної Плоті"
    t[177025] = { name = "Надкушена Риба", fen = "Something else already got to it.", fua = "Хтось інший уже до цього дібрався." }
    t[177026] = "Загублена Сережка"
    t[177027] = "Стара Рукавичка"
    t[177028] = "Іржавий Ланцюг"
    t[177030] = "Водяний Екстрактор"
    t[177032] = "Епідермальний Роздільник"
    t[177039] = "Барбуні, Фарширований Оливками"
    t[177040] = "Роса Амброрії"
    t[177041] = "Зігрітий Сонцем Ксифіас"
    t[177042] = "П'ятидзвонний Бацос"
    t[177043] = "Вирізаний Бік Ларіона"
    t[177050] = "Шолом Безкорисливого Носія Душі"
    t[177051] = "Нагрудник Безкорисливого Носія Душі"
    t[177052] = "Чоботи Безкорисливого Носія Душі"
    t[177053] = "Рукавиці Безкорисливого Носія Душі"
    t[177054] = "Поножі Самовідданого Носія"
    t[177055] = "Наплічники Безкорисливого Носія Душі"
    t[177056] = "Пояс Безкорисливого Носія Душі"
    t[177057] = "Наручі Безкорисливого Носія Душі"
    t[177058] = "Плащ Безкорисливого Носія Душі"
    t[177061] = { name = "Сутінкова Кора", fen = "Gathered by Miners from Phaedrum Deposits in Ardenweald.", fua = "Збирається шахтарями з покладів федруму в Арденвельді." }
    t[177147] = "Ікло Морської Потвори"
    t[177148] = "Щаслива Коса"
    t[177149] = "Мерехтлива Руна"
    t[177150] = "Скам'яніла Луска Василіска"
    t[177151] = "Погодний Журнал Океанографа"
    t[177152] = "Підзорна Труба Корсара"
    t[177154] = "Ікло Морської Потвори"
    t[177155] = "Мерехтлива Руна"
    t[177156] = "Скам'яніла Луска Василіска"
    t[177157] = "Самоцвіт Золотого Міста"
    t[177158] = "Зачарований Кіготь Дияволозавра"
    t[177166] = "Щаслива Коса"
    t[177186] = { name = "Забута Записка", fen = "A fragment of a larger story.", fua = "Уривок більшої історії." }
    t[177196] = "Шолом Гармонійного Носія Душі"
    t[177197] = "Нагрудник Гармонійного Носія Душі"
    t[177198] = "Бойові Чоботи Гармонійного Носія Душі"
    t[177199] = "Латні Рукавиці Гармонійного Носія Душі"
    t[177200] = "Поножі Гармонійного Носія Душ"
    t[177201] = "Наплічники Гармонійного Носія Душі"
    t[177202] = "Пояс Гармонійного Носія Душі"
    t[177203] = "Наручі Гармонійного Носія Душі"
    t[177204] = "Шолом Шанобливого Носія"
    t[177205] = "Нагрудник Шанобливого Носія"
    t[177206] = "Бойові Чоботи Шанобливого Носія"
    t[177207] = "Латні Рукавиці Шанобливого Носія"
    t[177208] = "Поножі Шанобливого Носія"
    t[177209] = "Наплічники Шанобливого Носія"
    t[177210] = "Пояс Шанобливого Носія"
    t[177211] = "Наручі Шанобливого Носія"
    t[177212] = "Шолом Дисгармонійного Носія Душі"
    t[177213] = "Нагрудник Дисгармонійного Носія Душі"
    t[177214] = "Бойові Чоботи Дисгармонійного Носія Душі"
    t[177215] = "Латні Рукавиці Дисгармонійного Носія Душі"
    t[177216] = "Поножі Розбратного Носія"
    t[177217] = "Наплічники Дисгармонійного Носія Душі"
    t[177218] = "Пояс Дисгармонійного Носія Душі"
    t[177219] = "Наручі Дисгармонійного Носія Душі"
    t[177220] = "Плащ Гармонійного Носія Душі"
    t[177221] = "Плащ Шанобливого Носія"
    t[177222] = "Плащ Дисгармонійного Носія Душі"
    t[177230] = "Просочена Анімою Вода"
    t[177231] = "Вінець Честі"
    t[177232] = "Зачарована Шафа"
    t[177233] = "Насіння Стрибучого Гриба"
    t[177234] = "Дзвін Збору"
    t[177235] = "Щасливий Чайник Таббінса"
    t[177236] = "Кістка Псячої Кістки"
    t[177237] = "Святкові Припаси Землекопів"
    t[177238] = "Щедрий Дарунок"
    t[177239] = "Дозвіл на Перегони"
    t[177241] = "Арсенал Некролорда"
    t[177242] = "Арсенал Вентирів"
    t[177243] = "Кіріанський Арсенал"
    t[177244] = "Арсенал Нічних Фе"
    t[177245] = "Малдраксійський Прапор Виклику"
    t[177278] = "Фіал Безтурботності"
    t[177279] = { name = "Виснажене Сухожилля", fen = "Gathered by players with the Skinning skill.", fua = "Збирається гравцями з умінням Білування." }
    t[177280] = "Подерта Оправа"
    t[177633] = "Сталевий Норманський Щит"
    t[177634] = "Флакон Нестійкої Сутності"
    t[177635] = "Трощитель Легіону Сінфоллу"
    t[177636] = "Зубчастий Посох Легіонера Сінфоллу"
    t[177637] = "Аркебуза Сінфолу"
    t[177638] = "Клинок Майстра Леза Сінфоллу"
    t[177639] = "Рапіра Вартового Сінфоллу"
    t[177640] = "Посох Крадія Гріхів"
    t[177641] = "Кинджал Інквізитора Сінфоллу"
    t[177642] = "Темнолезо Сінфолу"
    t[177643] = "Рапіра Дуелянта Сінфоллу"
    t[177644] = "Велика Булава Поновлювача Сінфоллу"
    t[177646] = "Лютий Жахоклинок"
    t[177648] = "Нагострена Глефа Жаху"
    t[177650] = "Рапіра Незламного Зломлювача Надії"
    t[177651] = "Рапіра Спритного Згубника Надії"
    t[177652] = "Скалкова булава-моргенштерн"
    t[177653] = "Загартовані Чоботиська"
    t[177654] = "Ударні Чоботиська"
    t[177655] = "Аероботи"
    t[177656] = "Летючі Чоботи-Ривок"
    t[177657] = "Переповнене Жарне Дзеркало"
    t[177659] = "Чари Нагрудника — Вічна Сутичка"
    t[177660] = "Чари Плаща — Життєва Сила Душі"
    t[177661] = "Чари Чобіт — Чоботи Душі"
    t[177665] = "Примарна Хустинка"
    t[177666] = "Шолом Гармонійного Збирача"
    t[177667] = "Нагрудник Гармонійного Збирача"
    t[177668] = "Бойові Чоботи Гармонійного Збирача"
    t[177669] = "Латні Рукавиці Гармонійного Збирача"
    t[177670] = "Поножі Гармонійного Збирача"
    t[177671] = "Наплічники Гармонійного Збирача"
    t[177672] = "Пояс Гармонійного Збирача"
    t[177673] = "Наручі Гармонійного Збирача"
    t[177674] = "Плащ Гармонійного Збирача"
    t[177675] = "Шолом Дисгармонійного Збирача"
    t[177676] = "Нагрудник Дисгармонійного Збирача"
    t[177677] = "Бойові Чоботи Дисгармонійного Збирача"
    t[177678] = "Латні Рукавиці Дисгармонійного Збирача"
    t[177679] = "Поножі Розбратного Збирача"
    t[177680] = "Наплічники Дисгармонійного Збирача"
    t[177681] = "Пояс Дисгармонійного Збирача"
    t[177682] = "Наручі Дисгармонійного Збирача"
    t[177683] = "Плащ Дисгармонійного Збирача"
    t[177693] = { name = "Сувій Постачальника", fen = "A long scroll detailing the recent acquisitions for the House of the Chosen.", fua = "Довгий сувій, що описує нещодавні придбання Дому Обраних." }
    t[177698] = { name = "Неприборканий Дух", fen = "This spirit contains the essence of an untamed being.", fua = "Цей дух містить сутність неприборканої істоти." }
    t[177699] = { name = "Більший Неприборканий Дух", fen = "This spirit contains the essence of a powerful untamed being.", fua = "Цей дух містить сутність могутньої неприборканої істоти." }
    t[177700] = { name = "Божественний Неприборканий Дух", fen = "This spirit contains the essence of a divine untamed being.", fua = "Цей дух містить сутність божественної неприборканої істоти." }
    t[177708] = { name = "Грамота Данини", fen = "Prince Renathal can use this to collect tribute in the Ember Court.", fua = "Принц Ренатал може використати її, щоб збирати данину при Дворі Жарин." }
    t[177710] = { name = "Розклад Патрулів", fen = "The master copy of the current patrol schedule for the House of the Chosen guards.", fua = "Головний примірник поточного розкладу патрулів вартових Дому Обраних." }
    t[177712] = { name = "Лист Посланця", fen = "Correspondence between the House of the Chosen and the House of Rituals.", fua = "Листування між Домом Обраних і Домом Ритуалів." }
    t[177715] = "Чари Нагрудника — Вічні Узи"
    t[177716] = "Чари Нагрудника — Священні Характеристики"
    t[177732] = "Наручі з Потрісканих Лат"
    t[177733] = "Бойові Чоботи з Потрісканих Лат"
    t[177734] = "Наплічники з Потрісканих Лат"
    t[177735] = "Кришні Латні Поножі"
    t[177736] = "Заборало з Потрісканих Лат"
    t[177737] = "Рукавички з Потрісканих Лат"
    t[177738] = "Нагрудник з Потрісканих Лат"
    t[177739] = "Широкий Пояс з Потрісканих Лат"
    t[177740] = "Намулені Кольчужні Наручі"
    t[177741] = "Намулені Кольчужні Наплічники"
    t[177742] = "Намулені Кольчужні Чоботи"
    t[177743] = "Кольчужні Штани з Намулу"
    t[177744] = "Намулений Кольчужний Жилет"
    t[177745] = "Намулені Кольчужні Рукавиці"
    t[177746] = "Намулений Кольчужний Шолом"
    t[177747] = "Намулена Кольчужна Пряжка"
    t[177748] = "Заплямований Багном Шкіряний Пояс"
    t[177749] = "Заплямовані Багном Шкіряні Обмотки"
    t[177750] = "Шкіряні Обмотки Рук у Багнюці"
    t[177751] = "Шкіряний Каптур у Багнюці"
    t[177752] = "Шкіряні Поножі, Заплямовані Багном"
    t[177753] = "Шкіряні Наплічники у Багнюці"
    t[177754] = "Шкіряний Жилет у Багнюці"
    t[177755] = "Заплямовані Багном Шкіряні Наручі"
    t[177756] = "Вибілені Жаром Тканинні Наручі"
    t[177757] = "Вибілена Жаром Тканинна Туніка"
    t[177758] = "Вибілені Жаром Тканинні Капці"
    t[177759] = "Тканинні Онучі, Вибілені Жаром"
    t[177760] = "Вибілені Жаром Тканинні Рукавиці"
    t[177761] = "Вибілений Жаром Тканинний Каптур"
    t[177762] = "Вибілений Жаром Тканинний Пояс"
    t[177763] = "Вибілений Жаром Тканинний Оплічник"
    t[177764] = { name = "Уламок Дзеркала", fen = "Can be used to rebuild Broken Mirrors throughout Revendreth.", fua = "Можна використати, щоб відбудувати розбиті дзеркала по всьому Ревендреті." }
    t[177767] = "Шати Заприсяженого Мучителя"
    t[177768] = "Сандалі Заприсяженого Мучителя"
    t[177769] = "Обмотки Заприсяженого Мучителя"
    t[177770] = "Каптур Заприсяженого Мучителя"
    t[177771] = "Поножі Запеклого Мучителя"
    t[177772] = "Шнур Заприсяженого Мучителя"
    t[177773] = "Зап'ясні Обмотки Заприсяженого Мучителя"
    t[177774] = "Чоботи Розпусного Чорноклинка"
    t[177775] = "Рукавиці Розпусного Чорноклинка"
    t[177776] = "Шолом Розпусного Чорноклинка"
    t[177777] = "Штани Розбещеного Темного Клинка"
    t[177778] = "Пояс Розпусного Чорноклинка"
    t[177779] = "Наручі Розпусного Чорноклинка"
    t[177780] = "Дика Кольчуга Кісткогриза"
    t[177781] = "Дикі Чоботи Кісткогриза"
    t[177782] = "Дикі Рукавички Кісткогриза"
    t[177783] = "Дикий Шолом Кісткогриза"
    t[177784] = "Дикі Поножі Кісткогриза"
    t[177785] = "Дикі Наплічники Кісткогриза"
    t[177786] = "Дикий Пояс Кісткогриза"
    t[177787] = "Дикі Наручі Кісткогриза"
    t[177788] = "Шолом Нічного Вартового"
    t[177789] = "Нагрудник Нічного Вартового"
    t[177790] = "Чоботи Нічного Вартового"
    t[177791] = "Латні Рукавиці Нічного Вартового"
    t[177792] = "Поножі Нічного Вартового"
    t[177793] = "Наплічники Нічного Вартового"
    t[177794] = "Пояс Нічного Вартового"
    t[177795] = "Наручні Пластини Нічного Вартового"
    t[177796] = "Туніка Розпусного Чорноклинка"
    t[177797] = "Еполети Розпусного Чорноклинка"
    t[177798] = "Наплічники Заприсяженого Мучителя"
    t[177799] = "Щит Камінородженого"
    t[177800] = "Булькітливе Вариво"
    t[177801] = "Алебарда Небесного Легіону"
    t[177802] = "Карабін Згубника Надії"
    t[177803] = "Посох Великого Інквізитора"
    t[177804] = "Кинджал Ритуаліста"
    t[177805] = "Булава Спокутника"
    t[177806] = "Кинджал з Лиходерева"
    t[177807] = "Жахоглефа Вірти"
    t[177808] = "Посилена Рапіра"
    t[177809] = "Гнучка Рапіра"
    t[177810] = "Булава Каменолома"
    t[177811] = "Перстень-Печатка Розпусної Наставниці"
    t[177812] = "Перстень Дому Ределав"
    t[177813] = "Знак Згубника Надії"
    t[177815] = "Ланцюг Побожного Архіваріуса"
    t[177816] = "Плащ із Дредголлоу"
    t[177817] = "Вудуйський Порошок"
    t[177818] = { name = "Темне Моджо", fen = "This dark mojo animated the nearby undead of Nazmir towards the essence of Mueh'zala.", fua = "Це темне моджо привертало довколишню нежить Назміру до сутності Муех'зали." }
    t[177836] = "Крилопробивний Дротик"
    t[177837] = "Череп Кривавого Ікла"
    t[177840] = { name = "Чиста Карта Незламності", fen = "Used by Scribes to craft a random Darkmoon Card belonging to the Indomitable suit.", fua = "Використовується писарями для створення випадкової карти Темного Місяця з масті Незламності." }
    t[177841] = { name = "Чиста Карта Ненажерливості", fen = "Used by Scribes to craft a random Darkmoon Card belonging to the Voracity suit.", fua = "Використовується писарями для створення випадкової карти Темного Місяця з масті Ненажерливості." }
    t[177842] = { name = "Чиста Карта Спокою", fen = "Used by Scribes to craft a random Darkmoon Card belonging to the Repose suit.", fua = "Використовується писарями для створення випадкової карти Темного Місяця з масті Спокою." }
    t[177843] = { name = "Чиста Карта Гниття", fen = "Used by Scribes to craft a random Darkmoon Card belonging to the Putrescence suit.", fua = "Використовується писарями для створення випадкової карти Темного Місяця з масті Гниття." }
    t[177844] = { name = "Зразок Чуми", fen = "A small glass tube filled with a bright liquid. There's markings on the glass that appear to be notation. Marileth will likely want it.", fua = "Маленька скляна пробірка, наповнена яскравою рідиною. На склі є позначки, схожі на нотацію. Марілет напевно захоче його отримати." }
    t[177845] = { name = "Флакон Чуми", fen = "A small glass tube filled with a bright liquid. There's markings on the glass that appear to be notation.", fua = "Маленька скляна трубочка, наповнена яскравою рідиною. На склі є позначки, схожі на якийсь запис." }
    t[177846] = "Гладіус Грішного Гладіатора"
    t[177847] = "Сікач, Затьмарений Сумнівом"
    t[177848] = "Копис Гармонійного Збирача"
    t[177849] = "Рятівний Клинок Душоносця"
    t[177850] = "Муза Медитації"
    t[177851] = "Церемоніальний Меч Грішного Гладіатора"
    t[177852] = "Рапіра, Затьмарена Сумнівом"
    t[177853] = "Чаромеч Самовідданого Спостерігача"
    t[177854] = "Чаромеч Гармонійного Вартового"
    t[177855] = "Чароклинок Прадавності"
    t[177856] = "Легкий Лук Грішного Гладіатора"
    t[177857] = "Бойовий лук, затьмарений сумнівом"
    t[177858] = "Довгий Лук Самовідданого Ковальчука"
    t[177859] = "Лук Гармонійного Форджлайта"
    t[177860] = "Посріблений Вигнутий Лук Примирення"
    t[177861] = "Ніж Грішного Гладіатора"
    t[177862] = "Парний клинок, Затьмарений Сумнівом"
    t[177863] = "Запасна Зброя Самовідданого Спостерігача"
    t[177864] = "Кинджал Гармонійного Носія"
    t[177865] = "Вірна Допоміжна Зброя"
    t[177866] = "Чаша Грішного Гладіатора"
    t[177867] = "Маяк, Підфарбований Сумнівом"
    t[177868] = "Дороговказ Безкорисливого Носія Душі"
    t[177869] = "Дороговказне Світло Гармонійного Споглядача"
    t[177870] = "Маяк Передбачення Теніоса"
    t[177871] = "Просочена Сумнівом Глефа"
    t[177872] = "Скеровуюча Глефа Архонта"
    t[177873] = { name = "Карта Темного Місяця Незламності", fen = "A random Darkmoon Card of the Indomitable. Collect a full set to receive a reward.", fua = "Випадкова карта Темного Місяця Незламності. Зберіть повний набір, щоб отримати винагороду." }
    t[177874] = { name = "Карта Темного Місяця Ненажерливості", fen = "A random Darkmoon Card of Voracity. Collect a full set to receive a reward.", fua = "Випадкова карта Темного Місяця Ненажерливості. Зберіть повний набір, щоб отримати винагороду." }
    t[177875] = { name = "Карта Темного Місяця Гниття", fen = "A random Darkmoon Card of Putrescence. Collect a full set to receive a reward.", fua = "Випадкова карта Темного Місяця Гниття. Зберіть повний набір, щоб отримати винагороду." }
    t[177876] = { name = "Карта Темного Місяця Спокою", fen = "A random Darkmoon Card of Repose. Collect a full set to receive a reward.", fua = "Випадкова карта Даркмуна Спокою. Збери повний набір, щоб отримати винагороду." }
    t[177878] = { name = "Анімашишка", fen = "The seed pulses gently with a dark, blue energy.", fua = "Зернина легенько пульсує темною синьою енергією." }
    t[177879] = { name = "Малдраксійський Кістковий Мозок", fen = "This bone marrow was mined from within Maldraxxus. Best not to think about it.", fua = "Цей кістковий мозок видобули в надрах Малдраксусу. Краще про це не думати." }
    t[177880] = "Первісна Багнюка"
    t[177881] = { name = "Камінь Гріха Наджії", fen = "The abhorrent actions of Viscountess Eak'le of Asquiron, premiere of the Order of Blades are described herein.", fua = "Тут описані огидні вчинки віконтеси Еак'ле з Аскірону, очільниці Ордену Клинків." }
    t[177894] = { name = "Глиняний Глек", fen = "An earthenware jar, for storing and transporting hot coals.", fua = "Глиняний глек для зберігання й перевезення гарячого вугілля." }
    t[177895] = { name = "Теплий Глиняний Глек", fen = "An earthenware jar, for storing and transporting hot coals. It is filled with lich fire and gives off an uncomfortable heat.", fua = "Глиняний глек для зберігання й перевезення гарячого вугілля. Він наповнений вогнем лічів і пашить неприємним жаром." }
    t[177904] = { name = "Камінь Смерті", fen = "Looks something like a hearthstone, but with a touch more death.", fua = "Виглядає чимось схожим на камінь повернення, але з дрібкою смерті." }
    t[177946] = "Спустошена Шкіряна Попона"
    t[177947] = "Загублена Парасолька Теотара"
    t[177948] = "Загублений Набір Інструментів Вулки"
    t[177949] = "Загублений Чайник Таббінса"
    t[177951] = { name = "Мерехтокрилки на Нитках", fen = "Five of Bastion's finest glimmerflies tethered by strings of anima.", fua = "П'ять найкращих мерехтокрилок Бастіону, прив'язаних нитками аніми." }
    t[177953] = { name = "Неприборканий Дух", fen = "This spirit contains the essence of an untamed being.", fua = "Цей дух містить сутність неприборканої істоти." }
    t[177954] = { name = "Згущена Частинка Аніми", fen = "A fraction of what the extractor was capable of producing, in better times.", fua = "Дещиця того, що екстрактор міг виробляти за кращих часів." }
    t[177957] = { name = "Необхідні Підсилювачі", fen = "A special formula to improve one's combat abilities.", fua = "Особлива формула для покращення бойових здібностей." }
    t[177961] = { name = "Зразок Чуми", fen = "An unbroken vial of plague. It has markings on the vial that you cannot decipher.", fua = "Ціла пляшечка чуми. На ній є позначки, які ви не можете розшифрувати." }
    t[177962] = "Чари Нагрудника — Вічні Характеристики"
    t[177963] = { name = "Очищені Уламки Обладунку", fen = "This black metal fragment shimmers with anima. There are parts of runes visible. It is no longer coated in green plague.", fua = "Цей чорний металевий уламок мерехтить анімою. Видно частини рун. Він більше не вкритий зеленою чумою." }
    t[178016] = { name = "Потенційний Каталізатор", fen = "This might be what the Warden is looking for. It looks kind of like the one they gave you earlier.", fua = "Можливо, це те, що шукає Вартова. Виглядає майже як той, що вона дала тобі раніше." }
    t[178017] = "Друстівська Линька"
    t[178018] = { name = "Ключ Тавра", fen = "The initials 'BtB' are carved onto the key, inside what looks like the shape of a... heart?", fua = "На ключі вирізьблені ініціали «BtB», усередині чогось схожого на... серце?" }
    t[178019] = { name = "Додаткові Томи Перемоги", fen = "A single book of the seemingly endless volumes of victory.", fua = "Одна книга з немовби нескінченних томів перемоги." }
    t[178020] = { name = "Том Перемоги: Том 1", fen = "The first volume of the seemingly endless volumes of victory.", fua = "Перший том із, здавалося б, нескінченної низки томів перемоги." }
    t[178021] = "Довгий лук з кулексового дерева"
    t[178022] = "Ніж із Кулексового Дерева"
    t[178023] = "Гамселій з Панцира Ґорма"
    t[178024] = "Кийок із Панцира Ґорма"
    t[178025] = "Спис із Жала Ґорма"
    t[178027] = "Меч Ґормового Жала"
    t[178029] = "Фокус Хранительки Луки"
    t[178030] = "Бойова Глефа Ґормового Жала"
    t[178031] = "Дзвіночок Освячення"
    t[178033] = { name = "Балакуча Спора", fen = "It's making quiet noises. It almost sounds like... grumbling?", fua = "Вона тихенько щось бурмоче. Майже схоже на... буркотіння?" }
    t[178040] = "Згущена Стигія"
    t[178041] = "Архонічний Резонатор"
    t[178042] = "Панцир Вічності"
    t[178043] = "Злиття Аніми"
    t[178045] = "Призма Душі"
    t[178051] = "Перерозмірювач v9.0.1"
    t[178053] = "Підмітач Хащів"
    t[178054] = "Карабін Терноклятий"
    t[178055] = "Глефа Шипозгуби"
    t[178056] = "Рапіра Кам'яної Чати"
    t[178057] = "Швидкоклинок Шляхтича"
    t[178058] = "Моргенштерн Кавалериста"
    t[178059] = "Священний Моргенштерн"
    t[178060] = "Алебарда Тернової Згуби"
    t[178061] = { name = "Податлива Плоть", fen = "Used in the creation of powerful constructs, fierce minions, and loyal mounts. Can be found from killing creatures in the Shadowlands or completing tasks for the Stitchmasters.", fua = "Слугує для створення могутніх конструктів, лютих посіпак і вірних їздових. Її можна знайти, вбиваючи істот у Тіньокраї, або отримати, виконуючи завдання для Зшивачів." }
    t[178065] = "Огорнуті Ніччю Рукавиці"
    t[178066] = "Каменековані Рукавички"
    t[178067] = "Рукавиці Болісного Відпущення"
    t[178068] = "Рукавички Мисливця за Душами"
    t[178069] = "Огорнутий Ніччю Оплічник"
    t[178070] = "Каменекований Оплічник"
    t[178071] = "Оплічник Скорботного Відпущення"
    t[178072] = "Наплічники Мисливця за Душами"
    t[178073] = "Каменекований Шолом"
    t[178074] = "Покрив Болісного Відпущення"
    t[178075] = "Каптур Мисливця за Душами"
    t[178076] = "Огорнутий Ніччю Каптур"
    t[178077] = "Перстень-Печатка Брайарбейн"
    t[178078] = "Схованка Відродженого Духа"
    t[178088] = "Унікальна Здобич з Малдраксуса"
    t[178090] = "Унікальна Здобич з Бастіону"
    t[178091] = "Унікальна Здобич Ревендрету"
    t[178103] = "Крихітне Крило"
    t[178104] = "Жариновий Попіл"
    t[178106] = "Розколоте Ікло"
    t[178107] = "Бліда Звивиста Шкіра"
    t[178110] = "Масна Чорна Пір'їна"
    t[178111] = "Заляпаний Падлом Дзьоб"
    t[178113] = "Тремтливий Камінь"
    t[178114] = "Кам'яний Окіст"
    t[178115] = "Стукотлива Кам'яна Кігтиста Лапа"
    t[178123] = "Згасаючий Жар Породження Світла"
    t[178125] = "Танцюючі Металеві Скалки"
    t[178126] = "Руків'я, Обвите Жилами"
    t[178127] = "Подерті Клапті Одягу"
    t[178129] = "Фігурка з Кісток і Багна"
    t[178130] = "Формована Багнюка"
    t[178131] = "Точильний Напилок для Кігтів"
    t[178132] = { name = "Розкішно Каліграфоване Запрошення", fen = "Details of a great party are laid out in fine lettering. Unfortunately, the intended recipient will never know to attend.", fua = "Подробиці пишного свята викладені вишуканим письмом. На жаль, призначений одержувач так і не дізнається, що мав на нього прийти." }
    t[178133] = "Пасма Ектоплазми"
    t[178134] = { name = "Ефемерні Пальці", fen = "It's as if they still reach out to you..", fua = "Здається, вони досі тягнуться до тебе.." }
    t[178138] = { name = "Уламок Арфи", fen = "A remnant of a shattered harp, once used to soothe silkstriders.", fua = "Залишок розбитої арфи, якою колись заспокоювали шовкоходів." }
    t[178139] = { name = "Шифр Переміщення", fen = "A working version of one of these will teleport the user from the dangers of the Maw to the safety of Ve'nari's Refuge.", fua = "Робоча версія такого предмета телепортує власника з небезпек Пащі в безпеку Притулку Ве'нарі." }
    t[178140] = "Архонічний Резонатор"
    t[178142] = { name = "Згущена Стигія", fen = "This appears to be what Ve'nari is looking for.", fua = "Схоже, це те, що шукає Ве'нарі." }
    t[178144] = { name = "Сирий Шовк Шовкохода", fen = "Beautiful silk strands, fresh from the silkstrider.", fua = "Прекрасні нитки шовку, щойно від шовкохода." }
    t[178147] = "Відзнака Армії Темряви"
    t[178150] = { name = "Смачний Пуріан", fen = "One of the Stewards' favorite foods.", fua = "Одна з улюблених страв провостів." }
    t[178152] = { name = "<Broker Adjective> Маяк Повернення", fen = "This item will probably end up as a Garrison-Style zone ability rather than an item you carry.", fua = "Цей предмет, імовірно, стане здібністю зони на кшталт гарнізонної, а не предметом, що ти носиш." }
    t[178153] = "Шолом Безкорисливого Спостерігача"
    t[178154] = "Нагрудник Безкорисливого Спостерігача"
    t[178155] = "Бойові Чоботи Самовідданого Спостерігача"
    t[178156] = "Латні Рукавиці Безкорисливого Спостерігача"
    t[178157] = "Поножі Самовідданого Споглядача"
    t[178158] = "Наплічники Самовідданого Спостерігача"
    t[178159] = "Пояс Безкорисливого Спостерігача"
    t[178160] = "Наручі Самовідданого Спостерігача"
    t[178161] = "Плащ Безкорисливого Спостерігача"
    t[178172] = "Абразивний пісок"
    t[178173] = "Крихкий Пісковик"
    t[178175] = "Липкий Сік"
    t[178178] = "Крихка Кора"
    t[178179] = "Шолом Гармонійного Споглядача"
    t[178180] = "Нагрудник Гармонійного Споглядача"
    t[178181] = "Бойові Чоботи Гармонійного Споглядача"
    t[178182] = "Латні Рукавиці Гармонійного Споглядача"
    t[178183] = "Поножі Гармонійного Спостерігача"
    t[178184] = "Наплічники Гармонійного Споглядача"
    t[178185] = "Пояс Гармонійного Споглядача"
    t[178186] = "Наручі Гармонійного Споглядача"
    t[178187] = "Плащ Гармонійного Споглядача"
    t[178188] = "Шолом Шанобливого Спостерігача"
    t[178189] = "Нагрудник Шанобливого Спостерігача"
    t[178190] = "Бойові Чоботи Шанобливого Спостерігача"
    t[178191] = "Латні Рукавиці Шанобливого Спостерігача"
    t[178192] = "Поножі Шанобливого Спостерігача"
    t[178193] = "Наплічники Шанобливого Спостерігача"
    t[178194] = "Пояс Шанобливого Спостерігача"
    t[178195] = "Наручі Шанобливого Спостерігача"
    t[178196] = "Плащ Шанобливого Спостерігача"
    t[178197] = "Шолом Дисгармонійного Спостерігача"
    t[178198] = "Нагрудник Дисгармонійного Спостерігача"
    t[178199] = "Чоботи Дисгармонійного Спостерігача"
    t[178200] = "Рукавиці Дисгармонійного Спостерігача"
    t[178201] = "Поножі Розбратного Спостерігача"
    t[178202] = "Наплічники Дисгармонійного Спостерігача"
    t[178203] = "Пояс Дисгармонійного Спостерігача"
    t[178204] = "Наручі Дисгармонійного Спостерігача"
    t[178205] = "Плащ Дисгармонійного Спостерігача"
    t[178214] = { name = "Оплічник Примуса", fen = "Piece of Primus' armor?", fua = "Частина обладунку Примуса?" }
    t[178215] = { name = "Листяний Суглинок", fen = "Smells musty, but not entirely unpleasant.", fua = "Пахне затхлістю, але не зовсім неприємно." }
    t[178216] = "Смажені Дрімогриби"
    t[178217] = "Чай із Лазуроцвіту"
    t[178218] = "Бренді із Зимової Дині"
    t[178219] = "Гаряче Феївино"
    t[178222] = "Пиріг з Медовою Сливою"
    t[178223] = "Варене Яйце Бродника"
    t[178224] = "Парений Хвіст Ґорма"
    t[178225] = "Рагу Дикого Мисливця"
    t[178226] = "Обвуглений Рунний Бік"
    t[178227] = "Опівнічний Зорепер"
    t[178228] = "Іскристий Зелений Горошок"
    t[178247] = "Стиглий Зимовий Кавун"
    t[178252] = "Зв'язка Вогнеягід"
    t[178263] = "Заступ Доглядача Гаю"
    t[178264] = "Латний Захист Голови Грішного Претендента"
    t[178265] = "Накидка Грішного Претендента"
    t[178266] = "Шовкова Роба Грішного Претендента"
    t[178267] = "Латний Обладунок Грішного Претендента"
    t[178268] = "Кольчужна Туніка Грішного Претендента"
    t[178269] = "Шкіряна Туніка Грішного Претендента"
    t[178270] = "Латні Чоботиська Грішного Претендента"
    t[178271] = "Шовкові Обмотки Грішного Претендента"
    t[178272] = "Кольчужні Чоботиська Грішного Претендента"
    t[178273] = "Шкіряні Черевики Грішного Претендента"
    t[178274] = "Шкіряні Рукавиці Грішного Претендента"
    t[178275] = "Латні Рукавиці Грішного Претендента"
    t[178276] = "Шовкові Рукавиці Грішного Претендента"
    t[178277] = "Кольчужні Рукавиці Грішного Претендента"
    t[178278] = "Шовковий Каптур Грішного Претендента"
    t[178279] = "Кольчужний Захист Голови Грішного Претендента"
    t[178280] = "Шкіряна Маска Грішного Претендента"
    t[178281] = "Латні Бойові Поножі Грішного Претендента"
    t[178282] = "Шовкові Поножі-Обмотки Грішного Претендента"
    t[178283] = "Кольчужні Бойові Поножі Грішного Претендента"
    t[178284] = "Шкіряні Поножі Грішного Претендента"
    t[178285] = "Шкіряний Оплічник Грішного Претендента"
    t[178286] = "Латні Наплічники Грішного Претендента"
    t[178287] = "Шовкова Накидка Грішного Претендента"
    t[178288] = "Кольчужні Наплічники Грішного Претендента"
    t[178289] = "Латний Широкий Пояс Грішного Претендента"
    t[178290] = "Шовковий Пояс Грішного Претендента"
    t[178291] = "Кольчужна Застібка Грішного Претендента"
    t[178292] = "Шкіряний Шнур Грішного Претендента"
    t[178293] = "Перстень Грішного Претендента"
    t[178294] = "Шовкові Пов'язки Грішного Претендента"
    t[178295] = "Латні Наручі Грішного Претендента"
    t[178296] = "Кольчужні Наручі Грішного Претендента"
    t[178297] = "Шкіряні Наручі Грішного Претендента"
    t[178298] = "Відзнака Завзяття Грішного Претендента"
    t[178299] = "Намисто Грішного Претендента"
    t[178301] = "Накидка Грішного Претендента"
    t[178329] = "Перстень-Печатка Грішного Претендента"
    t[178334] = "Емблема Грішного Претендента"
    t[178335] = "Амулет Грішного Претендента"
    t[178352] = "Латний Шолом Грішного Гладіатора"
    t[178353] = "Накидка Грішного Гладіатора"
    t[178354] = "Шовкове Вбрання Грішного Гладіатора"
    t[178355] = "Латний Нагрудник Грішного Гладіатора"
    t[178356] = "Кольчужна Туніка Грішного Гладіатора"
    t[178357] = "Шкіряний Нагрудник Грішного Гладіатора"
    t[178358] = "Латні Чоботи Грішного Гладіатора"
    t[178359] = "Шовкові Чоботи Грішного Гладіатора"
    t[178360] = "Кольчужні Чоботи Грішного Гладіатора"
    t[178361] = "Шкіряні Чоботи Грішного Гладіатора"
    t[178362] = "Шкіряні Рукавиці Грішного Гладіатора"
    t[178363] = "Латні Рукавиці Грішного Гладіатора"
    t[178364] = "Шовкові Рукавиці Грішного Гладіатора"
    t[178365] = "Кольчужні Рукавиці Грішного Гладіатора"
    t[178366] = "Шовковий Каптур Грішного Гладіатора"
    t[178367] = "Кольчужний Шолом Грішного Гладіатора"
    t[178368] = "Шкіряна Маска Грішного Гладіатора"
    t[178369] = "Латні Бойові Поножі Грішного Гладіатора"
    t[178370] = "Шовкові Штани Грішного Гладіатора"
    t[178371] = "Кольчужні Штани Грішного Гладіатора"
    t[178372] = "Шкіряні Поножі-Обмотки Грішного Гладіатора"
    t[178373] = "Шкіряні Наплічники Грішного Гладіатора"
    t[178374] = "Латні Наплічники Грішного Гладіатора"
    t[178375] = "Шовковий Оплічник Грішного Гладіатора"
    t[178376] = "Кольчужні Наплічники Грішного Гладіатора"
    t[178377] = "Латний Широкий Пояс Грішного Гладіатора"
    t[178378] = "Шовковий Пояс Грішного Гладіатора"
    t[178379] = "Кольчужний Пояс Грішного Гладіатора"
    t[178380] = "Шкіряний Пояс Грішного Гладіатора"
    t[178381] = "Перстень Грішного Гладіатора"
    t[178382] = "Шовкові Наручі Грішного Гладіатора"
    t[178383] = "Латні Наручі Грішного Гладіатора"
    t[178384] = "Кольчужні Наручі Грішного Гладіатора"
    t[178385] = "Шкіряні Наручі Грішного Гладіатора"
    t[178386] = "Відзнака Завзяття Грішного Гладіатора"
    t[178387] = "Амулет Грішного Гладіатора"
    t[178414] = "Накидка Грішного Гладіатора"
    t[178442] = "Перстень-Печатка Грішного Гладіатора"
    t[178447] = "Емблема Грішного Гладіатора"
    t[178448] = "Амулет Грішного Гладіатора"
    t[178464] = "Викинута Арфа"
    t[178465] = { name = "Велетенський Сувій Шовку", fen = "A huge bundle of silk, freshly spun from the lonely matriarch.", fua = "Величезний сувій шовку, щойно зітканий самотньою матріархою." }
    t[178468] = "Бойова Сокира Грішного Претендента"
    t[178470] = "Кинджал Грішного Претендента"
    t[178471] = "Булава Грішного Претендента"
    t[178472] = "Древкова Зброя Грішного Послідовника"
    t[178473] = "Посох Грішного Послідовника"
    t[178474] = "Меч Грішного Претендента"
    t[178475] = "Дворучна Сокира Грішного Послідовника"
    t[178476] = "Дворучний Меч Грішного Послідовника"
    t[178478] = "Сфера Грішного Претендента"
    t[178479] = "Бойова Глефа Грішного Претендента"
    t[178481] = "Молоток Грішного Претендента"
    t[178490] = "Бар'єр Грішного Претендента"
    t[178496] = { name = "Бойовий Ріг Барона", fen = "A warhorn made of bone. Runes are inscribed along the stone fittings.", fua = "Бойовий ріг із кістки. Уздовж кам'яних оздоб викарбувані руни." }
    t[178515] = { name = "Зшитий Торт-Сюрприз", fen = "A delicious fresh cake that's moving!", fua = "Смачний свіжий торт, який рухається!" }
    t[178517] = { name = "Золотий Зуб", fen = "Don't ask how he got this.", fua = "Краще не питати, звідки він його взяв." }
    t[178519] = { name = "Чистий Камінь Гріха", fen = "I haven't done anything wrong!", fua = "Я не зробив нічого поганого!" }
    t[178526] = { name = "Загублений Перстень Хранителя Склепу", fen = "Cryptkeeper Kassir will be pleased to have this again.", fua = "Хранитель склепу Кассір буде радий повернути його собі." }
    t[178534] = "Бовтанка Корпіні"
    t[178535] = { name = "Підозрілий Чарчик Слизу", fen = "Oozy, gooey, and sure to make you feel woozy after consuming this beverage.", fua = "Слизький і тягучий, цей напій неодмінно змусить тебе почуватися млосно." }
    t[178536] = "Кістковий Мозок Тауралуса"
    t[178537] = "Сповиті Волоссям Гриби"
    t[178538] = "Жучиний Сік"
    t[178539] = "Тепле Молоко Тауралуса"
    t[178540] = { name = "Смаковитий Десерт із Бруду", fen = "Dirt, grubs, and goo combined in perfect harmony. A treat for all Maldraxxi who do well in the Arena.", fua = "Бруд, личинки й слиз поєднані в досконалій гармонії. Ласощі для всіх малдраксійців, що добре б'ються на арені." }
    t[178541] = "Смажені Мозкові Кістки"
    t[178542] = { name = "Черепна Бовтанка", fen = "Congealed viscera sloshes in the mug.", fua = "У кухлі хлюпають загуслі нутрощі." }
    t[178543] = "Смажена Кров'янка"
    t[178544] = { name = "Сумнівна Сирна Тарілка", fen = "Someone went through great lengths to milk the beasts that wander this land.", fua = "Хтось добряче попрацював, аби надоїти звірів, що блукають цією землею." }
    t[178545] = "Чай із Серцевини Яблук"
    t[178546] = { name = "Сумнівний М'ясний Продукт", fen = "An amalgamation of flesh, tendon, and bone comprise this ghastly glob of meat.", fua = "Це жахливе місиво м'яса складається з плоті, сухожиль і кісток." }
    t[178547] = { name = "Сумнівна Смажена Птиця", fen = "A proprietary blend of poultry make up this foul-smelling dish.", fua = "Цю смердючу страву складає особлива потаємна суміш птиці." }
    t[178548] = "Чайні Кістки"
    t[178549] = "Варене М'ясо"
    t[178550] = { name = "Темна Трюфля", fen = "Bloodtusks dig up these morsels that are enjoyed by liches and gladiators alike.", fua = "Кривоікли викопують ці ласощі, якими насолоджуються і лічі, і гладіатори." }
    t[178551] = "Жахливий Гагіс із Кровоікла"
    t[178552] = "Криваві Апельсини"
    t[178560] = { name = "Поступ Внеску в Чистоту", fen = "Description goes here.", fua = "Тут має бути опис." }
    t[178564] = { name = "Око Тюремника:|CFFff2020 +1000 |R", fen = "Increase your threat level with Zovaal, the Jailer by |CFFff2020+1000 |Runits.\n\n\n\n|CFF00a18e(This threat level is reset to zero each day)\n\n|R", fua = "Підвищує рівень загрози від тебе для Зоваала, Тюремника, на |CFFff2020+1000 |Rодиниць.\n\n\n\n|CFF00a18e(Цей рівень загрози щодня скидається до нуля)\n\n|R" }
    t[178565] = { name = "Підозріле Повідомлення", fen = "Crumpled parchment covered with fine calligraphy \"NOOS SEOG EHTIT\".", fua = "Зім'ятий пергамент із вишуканою каліграфією: «ИННЯ КЯ ОВ ИДЯ»." }
    t[178566] = "Тріснуте Ручне Дзеркальце"
    t[178568] = { name = "Торба Моторошних Плазунів", fen = "It wiggles and squeaks disturbingly.", fua = "Вона тривожно звивається й попискує." }
    t[178569] = { name = "Походження Смерті", fen = "A dense tome pondering the creation of the interwoven mechanisms of the Shadowlands and how they relate to one another.", fua = "Грубий фоліант, що розмірковує над створенням переплетених механізмів Тіньокраю та про те, як вони пов'язані між собою." }
    t[178570] = { name = "Згасле Скло Спогадів", fen = "This memory glass appears to be very old, and the memories within will soon be lost.", fua = "Це скло спогадів виглядає дуже старим, і спомини в ньому невдовзі будуть утрачені." }
    t[178571] = { name = "Слизьке Листування", fen = "A letter from Margrave Stradama to an unknown recipient, it is written in a coded language you are not able to decipher.", fua = "Лист маркграфині Страдами невідомому одержувачу, написаний шифрованою мовою, яку ти не здатен розшифрувати." }
    t[178572] = { name = "Перстень з Потойбічного Металу", fen = "A ring of strange metal that appears similar to the makeup of Oribos.", fua = "Перстень з дивного металу, що видається подібним до складу Орибоса." }
    t[178573] = { name = "Незвичні Деталі Автоматона", fen = "Appears to be pieces from the core of an automaton, but unlike any that you've seen in the Shadowlands.", fua = "Схоже на частини осердя автоматона, але не схожі на жодні, що ви бачили в Тіньокраю." }
    t[178574] = { name = "Дивна Ритуальна Маска", fen = "A mask depicting a robotic face unlike anything you've seen in the Shadowlands.", fua = "Маска, що зображує механічне обличчя, не схоже ні на що бачене вами в Тіньокраю." }
    t[178575] = { name = "Золота Сфера Енергії", fen = "An intricate and complicated golden orb-like structure surrounding a dark interior. It periodically flickers with white energy, but never for long.", fua = "Хитромудра й складна золота сфероподібна структура, що оточує темне нутро. Час від часу вона спалахує білою енергією, та ніколи надовго." }
    t[178576] = { name = "Прадавній Головний Убір Посередника", fen = "The headpiece of a broker of unknown origin, it looks significantly different than the brokers you've met in Oribos.", fua = "Головний убір посередника невідомого походження, він суттєво відрізняється від тих посередників, яких ви зустрічали в Орибосі." }
    t[178577] = { name = "Настанови щодо Філактерії Налтора", fen = "Instructions on the creation of a phylactery, a necromantic ritual that liches rarely share with others.", fua = "Настанови зі створення філактерії, некромантичний ритуал, яким ліхи рідко діляться з іншими." }
    t[178578] = { name = "Дивна Лялька", fen = "Appears to be a child's doll or plaything, oddly-shaped and likely from a place outside of Azeroth.", fua = "Схоже на дитячу ляльку чи іграшку, химерної форми та, ймовірно, з місцини поза межами Азероту." }
    t[178579] = { name = "Загублений Гросбух Страдами", fen = "A series of meticulously-maintained lists of objects and the slime pools in which they are stored, using a coordinate system the likes of which you've never seen.", fua = "Низка ретельно ведених переліків об'єктів та калюж слизу, у яких вони зберігаються, із системою координат, якої ви ще ніколи не бачили." }
    t[178580] = { name = "Монета Чемпіона", fen = "A curious coin granted to champions of the Theater of Pain when they win a certain number of bouts. Not useful as a currency, only for ceremonial purposes.", fua = "Цікава монета, дарована чемпіонам Театру Болю за певну кількість виграних поєдинків. Не годиться як валюта, лише для церемоніальних цілей." }
    t[178581] = { name = "Розбухла Личинка Ґорма", fen = "A squishy, wiggling gorm larva that looks ready to mature at any moment.", fua = "М'яка, звивиста личинка ґорма, що, здається, ось-ось дозріє." }
    t[178582] = { name = "Золота Посмертна Маска", fen = "A mask depicting Mueh'zala's visage, likely from a civilization that once worshipped him.", fua = "Маска, що зображує обличчя Муех'зали, ймовірно, з цивілізації, яка колись йому поклонялася." }
    t[178583] = { name = "Фоліант Алхімії Землекопів", fen = "A book detailing a variety of methods for the creation and use of dredgers.", fua = "Книга, що докладно описує різноманітні методи створення та використання землекопів." }
    t[178584] = { name = "Медальйон Орієнтування", fen = "A medallion used to orient oneself in the Shadowlands relative to Oribos. Valuable for a general leading an army, but invaluable for travelling traders.", fua = "Медальйон, що дозволяє орієнтуватися в Тіньокраю відносно Орибоса. Цінний для генерала, який веде армію, але безцінний для мандрівних торговців." }
    t[178594] = { name = "Аніма-Прив'язані Обмотки", fen = "Anima infused wraps that add strength to bones and flesh.", fua = "Просочені анімою обмотки, що додають міцності кісткам і плоті." }
    t[178602] = { name = "Колючий Перстень", fen = "Prickly. This will certainly keep you preoccupied if you put it on.", fua = "Колеться. Якщо ви його надінете, він точно не дасть вам спокою." }
    t[178655] = { name = "Ритуальні Креслення Лая", fen = "Plans for the construction of Mor'Bitan's ritual.", fua = "Плани зведення ритуалу Мор'Бідана." }
    t[178656] = { name = "Ритуальні Креслення Ксілі", fen = "Plans for the construction of Mor'Bitan's ritual.", fua = "Плани зведення ритуалу Мор'Бідана." }
    t[178657] = { name = "Ритуальні Креслення Галена", fen = "Plans for the construction of Mor'Bitan's ritual.", fua = "Плани зведення ритуалу Мор'Бідана." }
    t[178658] = "Відновити Конструкт"
    t[178659] = { name = "Жахна Підмога", fen = "In an emergency, any construct will do!", fua = "У надзвичайній ситуації згодиться будь-який конструкт!" }
    t[178662] = { name = "Незавершений Клинок", fen = "A blade with no hilt. The runes embedded in the metal seem to call out to you.", fua = "Клинок без руків'я. Руни, вкарбовані в метал, неначе кличуть вас." }
    t[178663] = "Бойова Сокирка Грішного Претендента"
    t[178664] = "Вигнутий Лук Грішного Претендента"
    t[178668] = "Довгий Спис Грішного Послідовника"
    t[178670] = "Клинок Грішного Претендента"
    t[178676] = { name = "Пульсуючі Клапті Шкіри", fen = "This skin is dripping what you can only assume is the blood of the land itself.", fua = "З цієї шкіри скрапує те, що ви можете лише припустити бути кров'ю самої землі." }
    t[178681] = { name = "Тонка Гомілкова Кістка", fen = "A thin bone used to pry open crates or locked chests!", fua = "Тонка кістка, якою можна підважувати ящики чи замкнені скрині!" }
    t[178682] = { name = "Гросбух Аттікуса", fen = "Ledger tracking all covenant supplies", fua = "Гросбух з обліком усіх припасів ковенанту." }
    t[178683] = "Дзьоб Ґорджбіка"
    t[178684] = { name = "Пил Малдрациту", fen = "A fine maldracite powder used to draw runes.", fua = "Дрібний порошок малдрациту, що використовується для накреслення рун." }
    t[178686] = "Запрошення: Кам'яноголовий"
    t[178687] = "Запрошення: VIP 17"
    t[178688] = "Запрошення: VIP 18"
    t[178689] = "Запрошення: VIP 19"
    t[178690] = "Запрошення: VIP 20"
    t[178691] = "Каптур Прихованої Стежки"
    t[178692] = "Лик Душотерну"
    t[178693] = "Каптур з Коконного Шовку"
    t[178694] = "Шолом із Гнівокори"
    t[178695] = "Наплічники Зимового Зламу"
    t[178696] = "Оплічник Інґри Малоха"
    t[178697] = "Наплічники Жартівника"
    t[178698] = "Кольчуга Дощової Тіні"
    t[178699] = "Пояс Сокожера"
    t[178700] = "Застібка Згасальної Тіні"
    t[178701] = "Поножі з Панцира Ґорма"
    t[178702] = "Наручі Хащів"
    t[178703] = "Наручі Вулиного Рою"
    t[178704] = "Наручі Смертокайданів"
    t[178705] = "Рукавички Капосного Дрібнодуха"
    t[178706] = "Латні Рукавиці Туманоткача"
    t[178707] = "Підвіска Стежкопряда"
    t[178708] = { name = "Звільнений Підмінок", fen = "This strange critter has a rather unsettling habit of staring at you while you eat.", fua = "Це дивне створіння має доволі бентежну звичку витріщатися на вас, поки ви їсте." }
    t[178709] = "Скіпетр зі Скайтового Дерева"
    t[178710] = "Колючка Плутолісу"
    t[178711] = "Сокира Мертвого Гаю"
    t[178712] = "Оплот Кислотної Багнюки"
    t[178713] = "Дворучна Сокира Друствладці"
    t[178714] = "Шпиль Знання Лакалі"
    t[178715] = "Окарина Туманної Закличниці"
    t[178717] = { name = "Кокон Арденського Метелика", fen = "A moth in hand is worth two in the trees. Probably.", fua = "Метелик у руці вартий двох на деревах. Мабуть." }
    t[178729] = { name = "Фокус Некромантії", fen = "A single page incantation.", fua = "Заклинання на одну сторінку." }
    t[178730] = "Молот Розбухлого Черва"
    t[178731] = "Зшиті з Нутрощів Чоботи"
    t[178732] = "Жахливе Обличчя"
    t[178733] = "Наплічники Згнилокості"
    t[178734] = "Широкий Пояс зі Сплавлених Кісток"
    t[178735] = "Чумоплюй"
    t[178736] = "Загублений Перстень-Печатка Стічфлеша"
    t[178737] = "Чароклинок Амарта"
    t[178738] = "Деренчливий Каптур Влучного Стрільця"
    t[178739] = "Латні Поножі Нечестивого Шаленства"
    t[178740] = "Оплічник Воскресителя"
    t[178741] = "Наручі Воскреслого Чудовиська"
    t[178742] = "Токсин Обдертокрила у Пляшці"
    t[178743] = "Скальпель Стічфлеша"
    t[178744] = "Свіжозабальзамований Камзол"
    t[178745] = "Ступаки Невгамовної Злоби"
    t[178747] = { name = "Нічна Лілія", fen = "A beautiful flower that blooms only at night.", fua = "Прекрасна квітка, що розквітає лише вночі." }
    t[178748] = "Закривавлені Рукавички Хірурга"
    t[178749] = "Наплічники Мерзенного Різника"
    t[178750] = "Вкрита Кіркою Кришка Каноп"
    t[178751] = "Запасний М'ясний Гак"
    t[178752] = "Витончений Кісткодробитель"
    t[178753] = "Хірургічний Видобувач Гнійників"
    t[178754] = { name = "Пошесна Буря, Довгий Меч Мору", fen = "The taint of Stradama's machinations linger on the blade.", fua = "Скверна підступів Страдами досі тримається на клинку." }
    t[178755] = "Плащ Зараженого Маркграфа"
    t[178756] = "Загублені Капці Страдами"
    t[178757] = "Рукавички Темних Ритуалів"
    t[178759] = "Маска Розпусного Лікаря"
    t[178760] = "Погляд Перетравленого Дізнавача"
    t[178761] = "Поножі Освіченого Книжника"
    t[178762] = "Кольчужні Поножі Народженого Чумою"
    t[178763] = "Смердючі Наплічники, Зшиті Хрящами"
    t[178764] = "Чумороджені Наплічники"
    t[178767] = "Пута Катованого Помічника"
    t[178769] = "Безмежно Подільна Слиз"
    t[178770] = "Слизький Виснажливий Орган"
    t[178771] = "Флакон Гниття"
    t[178772] = "Торбина Потворних Поплічників"
    t[178773] = "Дворучний Шолом Чумника"
    t[178774] = "Чоботи Багнокачання"
    t[178775] = "Зрослі З Плоттю Чавила"
    t[178777] = "Темноморозний Шолом"
    t[178778] = "Поножі з Кісток Ліча"
    t[178779] = "Наплічники Незгасного Холоду"
    t[178780] = "Рунний Клинок Льодов'яза"
    t[178781] = "Перстень Ритуального Командира"
    t[178782] = "Кайдани Лорда Некрополя"
    t[178783] = "Висмоктувальна Скалка Філактерії"
    t[178786] = "Борошно з Блископшениці"
    t[178787] = "Орбореальна Скалка"
    t[178788] = { name = "Сліди Аніми", fen = "A faint whisper of anima.", fua = "Ледь чутний шепіт аніми." }
    t[178789] = "Ніж Формувача Плоті"
    t[178790] = "Тіняве перо"
    t[178791] = "Різьблений Поклик Хмаропера"
    t[178792] = "Зшиті Душами Шати"
    t[178793] = { name = "Нагрудник Захисту Черева", fen = "Guts in, swords out.", fua = "Кишки всередині, мечі назовні." }
    t[178794] = "Кольчуга Тріумфального Бійця"
    t[178795] = "Нагрудник Прихованих Таємниць"
    t[178796] = "Чоботи Тремкої Матерії"
    t[178797] = "Ступаки Переможеного Узурпатора"
    t[178798] = "Рукавиці Нищівних Побоїв"
    t[178799] = "Каптур Переслідувача з Амфітеатру"
    t[178800] = "Оцинковані Поножі з Окссеїну"
    t[178801] = "Поножі Безстрашного Суперника"
    t[178802] = "Наплічники Незламного Бійця"
    t[178803] = "Зачумлений Амікт"
    t[178804] = "Пояс Полеглої Імператриці"
    t[178805] = "Пояс Розбитих Мрій"
    t[178806] = "Заражені Марлеві Наручі"
    t[178807] = "Наручі Бійця Ями"
    t[178808] = "Нутрощі Згуслої Ненависті"
    t[178809] = "Рубін Випускання Душ"
    t[178810] = "Флакон Примарної Сутності"
    t[178811] = "Похмурий Кодекс"
    t[178812] = "Шолом Командира Ескадрильї"
    t[178813] = "Запинало Гріховного Світла"
    t[178814] = "Нагрудник Потойбічного Впливу"
    t[178815] = "Кольчуга Ширяючого Винищувача"
    t[178816] = "Маска Узурпатора з Натрії"
    t[178817] = "Каптур Заломлених Тіней"
    t[178818] = "Велетенські Стовпи Галкіаса"
    t[178819] = "Кам'яношкірі Поножі Небесного Жаху"
    t[178820] = "Наплічники Розкутої Гордині"
    t[178821] = "Оплічник Скороминущих Ликів"
    t[178822] = "Пояс Темного Слова"
    t[178823] = "Пояс Темної Відданості"
    t[178824] = "Перстень-Печатка Фальшивого Обвинувача"
    t[178825] = "Пульсівне Кам'яне Серце"
    t[178826] = "Сонцекровний Аметист"
    t[178827] = "Амулет, Заплямований Гріхом"
    t[178828] = "Скинія Натрії"
    t[178829] = "Натрійська Ферула"
    t[178830] = "Скалкошкіряні Латні Чоботи"
    t[178831] = "Капці Підвищеного Становища"
    t[178832] = "Рукавички Невідступної Одержимості"
    t[178833] = "Рукавички Формувальника Кам'яних Чудовиськ"
    t[178834] = "Моргенштерн Кам'яного Охоронця"
    t[178835] = "Заляпана Анімою Шкіра"
    t[178836] = "Латні Чоботи Навального Колоса"
    t[178837] = "Просочені Гріхом Чоботи"
    t[178838] = "Поножі Нескінченних Мук Берилії"
    t[178839] = "Поножі Танцівника Вітру"
    t[178840] = "Кам'яні Пазурі Ґайлвінда"
    t[178841] = "Залізні Шипасті Рукавиці"
    t[178842] = "Пояс Вигнаної Муки"
    t[178843] = "Гордовитий Пояс Виконавця"
    t[178844] = "Пов'язі Сплеску Сутності"
    t[178845] = "Наручі Розбещеного Наглядача"
    t[178846] = "Окови Звабливої Життєвості"
    t[178847] = "Пов'язки Сяйливого Світла"
    t[178848] = "Сплетений Вус Ненажери"
    t[178849] = "Переповнена Клітка Аніми"
    t[178850] = "Стійка Сонячна Порошинка"
    t[178851] = "Плащ Огортальних Проявів"
    t[178852] = "Посудина Сяйливого Світіння"
    t[178853] = "Хребет Ненажерливого Зажери"
    t[178854] = "Парний Клинок Зголоднілого Пожирача"
    t[178855] = "Гріходробар"
    t[178856] = "Похмурий Клинок Кааля"
    t[178857] = "Лезо Кам'яного Генерала"
    t[178858] = "Наплічники Лиховісного Клинокрила"
    t[178859] = "Оплічник Карателя"
    t[178860] = "Каптур Відданого Генерала"
    t[178861] = "Карафа Наснажених Анімою Вітрів"
    t[178862] = "Набір для Обладунку Танцівника з Клинками"
    t[178863] = "Закривавлений Сікач"
    t[178864] = "Молоток Кровозв'язаного Хижака"
    t[178865] = "Піка Влади Ксава"
    t[178866] = "Спустошливий Стинач Голів Дессії"
    t[178867] = "Барикада Безкінечної Імперії"
    t[178868] = "Обітниця Смертоходу"
    t[178869] = "Зрослий З Плоттю Перстень"
    t[178870] = "Ритуальний Кістяний Перстень"
    t[178871] = "Перстень-Печатка Кривавої Присяги"
    t[178872] = "Перстень Невпинного Конфлікту"
    t[178874] = { name = "Войовничий Дух", fen = "This spirit contains the essence of a martial being.", fua = "Цей дух містить сутність войовничої істоти." }
    t[178876] = { name = "Мішок Припасів", fen = "Contains plenty of raw materials for the artisans at Glitterfall Basin.", fua = "Містить удосталь сировини для ремісників улоговини Блискотливого Водоспаду." }
    t[178877] = { name = "Величний Войовничий Дух", fen = "This spirit contains the essence of a powerful martial being.", fua = "Цей дух містить сутність могутньої войовничої істоти." }
    t[178878] = { name = "Божественний Войовничий Дух", fen = "This spirit contains the essence of a divine martial being.", fua = "Цей дух містить сутність войовничої божественної істоти." }
    t[178879] = { name = "Божественний Сумлінний Дух", fen = "This spirit contains the essence of a dutiful divine being.", fua = "Цей дух містить сутність сумлінної божественної істоти." }
    t[178880] = { name = "Величний Сумлінний Дух", fen = "This spirit contains the essence of a powerful dutiful being.", fua = "Цей дух містить сутність могутньої сумлінної істоти." }
    t[178881] = { name = "Сумлінний Дух", fen = "This spirit contains the essence of a dutiful being.", fua = "Цей дух містить сутність сумлінної істоти." }
    t[178882] = { name = "Гордовитий Дух", fen = "This spirit contains the essence of a prideful being.", fua = "Цей дух містить сутність гордовитої істоти." }
    t[178883] = { name = "Величний Гордовитий Дух", fen = "This spirit contains the essence of a powerful prideful being.", fua = "Цей дух містить сутність могутньої гордовитої істоти." }
    t[178884] = { name = "Божественний Гордовитий Дух", fen = "This spirit contains the essence of a prideful divine being.", fua = "Цей дух містить сутність гордовитої божественної істоти." }
    t[178885] = "Шкура Хмароходця"
    t[178890] = "Перо Ларіона"
    t[178891] = "Елізійська Нитка"
    t[178892] = "Указ: Прихильність Баронеси Вашж"
    t[178893] = "Указ: Пошана Баронеси Вашж"
    t[178894] = "Указ: Благословення Баронеси Вашж"
    t[178895] = "Незламні Наручі Рішучості"
    t[178896] = "Незламні Рукавички Рішучості"
    t[178897] = "Незламний Наплічник Рішучості"
    t[178898] = { name = "Їдка Отрута Роєвика", fen = "Smells strongly of spoiled fruit and excrement.", fua = "Тхне гнилими фруктами та екскрементами." }
    t[178899] = "Деревожолудь"
    t[178900] = { name = "Гнилий Перець Смерті", fen = "Sauced, seasoned, seared... and still moving!", fua = "У соусі, приправлений, обсмажений... і досі ворушиться!" }
    t[178901] = "Насінина Лози"
    t[178902] = "Відживляюча Гілочка"
    t[178903] = { name = "Зброя Розміру Спріґана", fen = "Just as deadly as the normal version.", fua = "Така ж смертоносна, як і звичайний варіант." }
    t[178904] = { name = "Ключ від Кайданів", fen = "Despite being exposed to the elements, the key remains remarkably unscathed.", fua = "Попри те що ключ був відкритий стихіям, він лишився напрочуд неушкодженим." }
    t[178907] = { name = "Чарівна Паличка Розміру Спріґана", fen = "Just as deadly as the normally-sized version.", fua = "Така ж смертоносна, як і варіант звичайного розміру." }
    t[178908] = { name = "Древкова Зброя Розміру Спріґана", fen = "Also useful for reaching things on medium-height branches.", fua = "Також зручна, щоб діставати речі з гілок середньої висоти." }
    t[178909] = { name = "Посох Розміру Спріґана", fen = "Perfect for channeling spriggan-sized magic.", fua = "Ідеальний для каналізування магії розміру спріґана." }
    t[178915] = { name = "Стиглий Пуріан", fen = "A perfectly ripe, extremely aromatic purian fruit. It will probably spoil shortly.", fua = "Бездоганно стиглий, надзвичайно ароматний плід пуріану. Імовірно, скоро зіпсується." }
    t[178923] = "Потрощений Уламок"
    t[178924] = "Грудка Попелу"
    t[178926] = { name = "Тіньожахний Перстень", fen = "An exceptionally well crafted piece of jewelry worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлена прикраса, гідна того, щоб бути підсиленою Різьбярем Рун." }
    t[178927] = { name = "Тіньожахне Намисто", fen = "An exceptionally well crafted piece of jewelry worthy of being empowered by the Runecarver.", fua = "Винятково майстерно виготовлена прикраса, гідна того, щоб бути підсиленою Різьбярем Рун." }
    t[178928] = "Слизький колій Доміни"
    t[178929] = "Алебарда Аранаккі"
    t[178930] = "Рукавиці Бездоганного Подвоєння"
    t[178931] = "Пошрамований Кровозв'язаний Пояс"
    t[178932] = "Пояс Жалюгідних Маніпуляцій"
    t[178933] = "Перстень Павучого Шифру"
    t[178934] = "Затягнуті Отрутошипні Пов'язки"
    t[178943] = "Закривавлений Кинджал"
    t[178944] = "Закривавлений Молоток"
    t[178945] = "Великий Посох в Кістяних Лещатах"
    t[178946] = "Закривавлений Меч"
    t[178947] = "Арбалет Сталевої Щелепи"
    t[178948] = "Чарівна Паличка в Кістяних Лапах"
    t[178949] = "Клеймор Чорного Хорта"
    t[178950] = "Оплот Чорного Гончака"
    t[178951] = "Фоліант у Пергаментній Оправі"
    t[178952] = "Закривавлена Бойова Глефа"
    t[178953] = "Меч Чорного Гончака"
    t[178956] = "Рукавиці Мужнього Претендента"
    t[178957] = "Рукавички Розсудливого Претендента"
    t[178958] = "Обмотки Чистого Претендента"
    t[178959] = "Рукавиці Смиренного Претендента"
    t[178965] = "Мала Торба Садівника"
    t[178966] = "Торба Садівника"
    t[178967] = "Велика Торба Садівника"
    t[178968] = "Щотижнева Торба Садівника"
    t[178969] = "Тестовий Контейнер"
    t[178970] = "Шпиль Самовідданого Спостерігача"
    t[178971] = "Дзвін Грішного Гладіатора"
    t[178972] = "Просочений Сумнівом Великий Посох"
    t[178973] = "Симфонічний Хранитель Дзвонів"
    t[178974] = "Вечірній Посох Гармонійного Спостерігача"
    t[178975] = "Вечірній дзвін відбиття Весіфони"
    t[178991] = "Накидка Піднесених"
    t[178992] = "Прихована Зброя"
    t[178995] = { name = "Скалка Дзеркала Душ", fen = "The Forsworn collect these shards in an attempt to recapture their past memories.", fua = "Зреченці збирають ці скалки, прагнучи повернути свої минулі спогади." }
    t[179001] = "Глек Десятини"
    t[179002] = { name = "Долото Землекопа", fen = "Well-worn, but still usable.", fua = "Добряче зношене, але ще придатне." }
    t[179003] = "Розбиті Кварцові Очі"
    t[179004] = { name = "Полірована Срібна Десятина", fen = "The face has been worn away by time and many hands.", fua = "Лицьовий бік стерся від часу та безлічі рук." }
    t[179005] = "Блискуче Золоте Ікло"
    t[179006] = "Сяйний Пил Скінчмару"
    t[179008] = { name = "Виснажене Осердя Голіафа", fen = "The heart of any Goliath, these cores keep them powered with anima.", fua = "Серце будь-якого голіафа, ці осердя живлять їх анімою." }
    t[179009] = { name = "Підмінений Аніма-Зарядник", fen = "Used to empower Forsworn Centurions past their normal limits.", fua = "Використовується, щоб підсилити центуріонів-зреченців понад їхні звичні межі." }
    t[179010] = { name = "Перевантажене Осердя Голіафа", fen = "Allows the capture of Kalisthene's memory.", fua = "Дозволяє вловити спогад Калістени." }
    t[179011] = "Кажанячий Пиріг"
    t[179012] = "Гуляш із Багнолаза"
    t[179013] = "Копчена Багнориба"
    t[179014] = "Мармуровий Стейк Ненажери"
    t[179015] = "Павучі Ніжки з Часником"
    t[179016] = "Домашній Сир"
    t[179017] = "Телемея"
    t[179018] = "Відбивна з Череполикана"
    t[179019] = "Смажене Крило Жахокрила"
    t[179020] = { name = "Зубчик Часнику", fen = "The pleasant aroma it gives the breath is held in high regard, for the small number of Venthyr without the common allergy.", fua = "Приємний аромат, який він надає диханню, високо цінується серед нечисленних вентирів без поширеної алергії." }
    t[179021] = "Рожевий Солодкий Перець"
    t[179022] = "Світлолиста Капуста"
    t[179023] = "Стебла Ревеню"
    t[179024] = { name = "Медальйон Гордині", fen = "Bestowed upon Venthyr by The Sire himself. Allows the wearer to exert partial dominion over Revendreth.", fua = "Дарований вентирам самим Сіром. Дозволяє власнику частково панувати над Ревендретом." }
    t[179025] = "Пахучий Рис"
    t[179026] = "Вічноночна Каша"
    t[179166] = "Булочки Нічного Врожаю"
    t[179267] = "Ендмайрський Світлогриб"
    t[179268] = "Білий Гриб із Згубнолісся"
    t[179269] = "Мус із Сутінкового Мигдалю"
    t[179270] = "Тінешкіра Слива"
    t[179271] = { name = "Яблуко Дредголлоу", fen = "A crispy treat enjoyed by equines of all types.", fua = "Хрумкі ласощі, які смакують усім видам коней." }
    t[179272] = "Насолода Жахолова"
    t[179273] = "Вирізка Темного Гончака"
    t[179274] = "Бараняче Дроб"
    t[179275] = "Фарш Із Кліща У Капустяному Листі"
    t[179276] = "Юшка з Тельбухів Химери"
    t[179278] = "Бренді з Тінешкірої Сливи"
    t[179279] = "Глек Самогону Туйка"
    t[179281] = "Борщ Падіння Пихи"
    t[179282] = "Гербова Накидка Двору Женців"
    t[179283] = "Пшоняні Вафлі"
    t[179284] = "Соковиті Шматочки Черепокабана"
    t[179285] = "Джумарі"
    t[179286] = "Сушене Капустяне Листя"
    t[179287] = "Вкриті Багном Шматочки"
    t[179288] = "Обітні Свічки"
    t[179289] = "Скручені Молитовні Намистини"
    t[179290] = "Прості Кайдани"
    t[179291] = "Срібна Настоянка"
    t[179292] = "Витончена Хустинка"
    t[179293] = "Мерехтливий Крем для Обличчя"
    t[179294] = "Порожній Бурдюк зі Шкіри Дредвінга"
    t[179295] = { name = "Пискляве Кажаня", fen = "Repeated 'squeaks' have been known to release stress in some... increase in others.", fua = "Подейкують, що повторюваний писк одним знімає стрес... а в інших його посилює." }
    t[179296] = "Рукавичка Дуелянта"
    t[179297] = "Наповнена Пилом Настоянка"
    t[179298] = "Стрічки Тканинної Парасолі"
    t[179299] = "Вирваний Ікло"
    t[179300] = "Затверділа в Багні Кулька"
    t[179301] = "Великий Заболочений Клинок"
    t[179302] = "Заляпаний Багном Кинджал"
    t[179306] = "Зігрівач Кінчиків Крил"
    t[179307] = "Ковток Туїцької Самогонки"
    t[179308] = "Фіал Бренді з Тінешкірої Сливи"
    t[179309] = "Настоянка Самогонки Туйки"
    t[179311] = "Замкнена Скринька Сінвіру"
    t[179314] = "М'ясо Повзучого Плазуна"
    t[179315] = "Тіньова Гомілка"
    t[179317] = { name = "Кістковий Метал", fen = "A dense, but pliable, metal used in the construction of arms and armor.", fua = "Щільний, але податливий метал, що використовується для виготовлення зброї та обладунків." }
    t[179318] = { name = "Скорботна Лоза", fen = "A hateful vine that grows only in the lowlands of Revendreth.", fua = "Сповнена ненависті лоза, що росте лише в низинах Ревендрету." }
    t[179319] = "Закутий Кийок"
    t[179320] = { name = "Лісодерево", fen = "Shaped wood enchanted by the keepers of Ardenweald.", fua = "Оброблене дерево, зачароване хранителями Арденвельду." }
    t[179321] = { name = "Ґільденіт", fen = "A hard, golden material used for many purposes.", fua = "Твердий золотавий матеріал багатоцільового призначення." }
    t[179322] = "Мокасини з Вітрової Луски"
    t[179323] = "Кийок Жахної Балки"
    t[179324] = "Штани з Пера Душі"
    t[179325] = "Рукавиці Примари Гаккарі"
    t[179326] = "Пояс Душолупа"
    t[179327] = { name = "Посередницька Монета", fen = "A highly-valued coin of the Shadowlands used to trade for rare materials with the Brokers.", fua = "Високо цінована монета Тіньокраю, якою торгують з посередниками за рідкісні матеріали." }
    t[179328] = "Кровопроливець"
    t[179329] = "Серцеколь Ґаргульї"
    t[179330] = "Зін'хас, Клинок Полеглого Бога"
    t[179331] = "Забризкана Кров'ю Луска"
    t[179332] = "Древкова Сокира Кам'яного Вартового"
    t[179333] = "Кийок Інквізитора"
    t[179334] = "Посох Крилоклинка"
    t[179335] = "Розкішне Вбрання Манасторма"
    t[179336] = "Рукавиці Погонича Курки-Ракети"
    t[179337] = "Поножі з Техно-Котушкою"
    t[179338] = "Динамо-Тупотуни Фатуму"
    t[179339] = "Свистобабахна Тростина"
    t[179340] = "Суперколайдер"
    t[179342] = "Кристал Нездоланної Могутності"
    t[179343] = "Пояс Вишуканих Надбань"
    t[179344] = "Наплічники Далекого Мандрівника"
    t[179345] = "Чоботи Просторового Розриву"
    t[179346] = "Нагрудник Згубних Хитрощів"
    t[179347] = "Пульсуючий Посох Колекціонера"
    t[179348] = "Арбалет Картелю Зай"
    t[179349] = "Плащ Торговки Зайекси"
    t[179350] = "Незбагненний Квантовий Пристрій"
    t[179351] = "Пов'язка з Лиховісної Нитки Муех'зали"
    t[179352] = "Поножі Прадавньої Душі"
    t[179353] = "Збруя Звихнутих Примх"
    t[179354] = "Наручі Розламу Реальності"
    t[179355] = "Перстень-Печатка Бога Смерті"
    t[179356] = "Тотем Тіньової Хватки"
    t[179358] = { name = "Реморнія", fen = "Within this animated blade a dark presence screams to be released.", fua = "У цьому живому клинку темна присутність волає, щоб її випустили." }
    t[179363] = { name = "«Загублена» Аніма-Подать", fen = "Anima swirls nearly overflowing the container, it appears that quite a few tolls have been 'misplaced.'", fua = "Аніма вирує, мало не переливаючись через край посудини. Схоже, чимало податей було «загублено»." }
    t[179367] = "[PH] Torghast Boss Loot"
    t[179368] = { name = "Незмінні Кайдани", fen = "Once closed, they can never be released.", fua = "Замкнувшись, вони вже ніколи не відчиняться." }
    t[179369] = "Примарний Ключ"
    t[179370] = "Інертний Сигіл Проходу"
    t[179372] = "Зламана Пастка На Маврата"
    t[179378] = { name = "Дзеркало Душ", fen = "Used to capture a memory of a target for training purposes in the Path of Ascension.", fua = "Слугує, щоб уловити спогад цілі для тренувань на Шляху Сходження." }
    t[179380] = { name = "Гаманець Ределав", fen = "The heavy purse jingles with a large amount of coins.", fua = "Важкий гаманець подзенькує безліччю монет." }
    t[179382] = { name = "Крихітний Мокрий Сувій", fen = "Tied to the key in theotar's tea cup.", fua = "Прив'язаний до ключа в чашці чаю Теотара." }
    t[179389] = "Анімашишка"
    t[179390] = { name = "Спокусливо Велика Золота Слива", fen = "Beware those that are beset by greed as gold never satiates the soul.", fua = "Стережіться охоплених жадібністю, адже золото ніколи не насичує душу." }
    t[179392] = { name = "Сфера Дедалі більших Амбіцій", fen = "Ambition can outstrip prudence.", fua = "Амбіції здатні взяти гору над розважливістю." }
    t[179393] = "Дзеркало Заздрісних Снів"
    t[179485] = "Ікло Немея"
    t[179486] = "Панцеролам Сиґілоспинного"
    t[179487] = "Ріг Аетона"
    t[179488] = "Лапа Клаудтейла"
    t[179492] = "Кишкорвач Підземного Плазуна"
    t[179493] = "Ікло Дикого Полювання"
    t[179494] = "Ікло Нічного Придворного"
    t[179495] = "Ікло Грішного Гладіатора"
    t[179496] = "Ікло Зимородженого"
    t[179497] = "Ікло Крилатого Вартового"
    t[179498] = "Шпичак Присяжного Фей"
    t[179499] = "Шпичак Нічної Верби"
    t[179500] = "Ніж Сутінкового Вартового"
    t[179502] = "Колючка Рваної Лози"
    t[179508] = "Бойова Глефа Сутінкового Вартового"
    t[179509] = "Лезо Вартового Гаю"
    t[179510] = "Бойова Глефа Пісні Снів"
    t[179511] = "Глефа Фейської Присяги"
    t[179512] = "Шабля Пісні Снів"
    t[179513] = "Ятаган Сутінкового Вартового"
    t[179514] = "Шабля Рваної Лози"
    t[179515] = "Фальшіон Присяжного Фей"
    t[179516] = "Посох співучого дерева"
    t[179517] = "Кадило Присмеростража"
    t[179518] = "Посох Мерехтливого Світла"
    t[179525] = "Зимороджений Спис"
    t[179526] = "Спис Грішного Гладіатора"
    t[179527] = "Спис Приборкувача Ґаргонів"
    t[179528] = "Бойовий Спис Нічного Куртизана"
    t[179529] = "Бойовий Спис Дикого Полювання"
    t[179530] = "Патрач Нічної Варти"
    t[179531] = "Косар Присяжних Фей"
    t[179532] = "Коса Присмеростража"
    t[179533] = "Жнець Хранителя Гаю"
    t[179534] = "Смертокоса Мі'кая"
    t[179535] = "Видобувачі Зруйнованої Пихи"
    t[179536] = "Бойовий Молот Присяжних Фей"
    t[179537] = "Молот Присмеростража"
    t[179538] = "Молот Хранителя Гаю"
    t[179539] = "Збивачка Келокса"
    t[179540] = "Молот Нічного Куртизана"
    t[179541] = "Колосальний Багнотовкач"
    t[179542] = "Бойовий Молот Дикого Полювання"
    t[179543] = "Кийок Грішного Гладіатора"
    t[179544] = "Попелорізьблений Кувальний Молот"
    t[179545] = "Зимороджений Молот"
    t[179546] = "Бойова Палиця Фейської Присяги"
    t[179547] = "Бойовий Кийок Сутінкового Вартового"
    t[179548] = "Молоток зі Стародавнього Дерева"
    t[179549] = "Кийок Нічної Верби"
    t[179556] = "Скіпетр Зимородженого"
    t[179557] = "Дубовий Скіпетр Барона"
    t[179558] = "Скіпетр Нічного Придворного"
    t[179559] = "Скіпетр Грішного Гладіатора"
    t[179560] = "Скіпетр Дикого Полювання"
    t[179561] = "Кривава Гілка Коренеткача"
    t[179562] = "Гілка Сутінкового Вартового"
    t[179563] = "Стебло Серцедерева"
    t[179564] = "Скерувальний Корінь Феєприсяжних"
    t[179565] = "Стебло Пісенного Дерева"
    t[179566] = "Ліра Занепадницької Легковажності"
    t[179567] = "Арфа Дикого Полювання"
    t[179568] = "Ліра Нічного Придворного"
    t[179569] = "Ліра Грішного Гладіатора"
    t[179570] = "Арфа Кривавого Двору"
    t[179571] = "Арфа Зимородженого"
    t[179577] = "Каменеломні Жвала"
    t[179578] = "Щелепи Грішного Гладіатора"
    t[179579] = "Щелепи Голодаря"
    t[179580] = "Щелепи Дикого Полювання"
    t[179581] = "Щелепи Нічного Придворного"
    t[179582] = "Щелепи Зимородженого"
    t[179583] = "Феєприсяжний Бойовий Лук"
    t[179584] = "Короткий лук сутінкового стража"
    t[179585] = "Короткий Лук Нічної Верби"
    t[179586] = "Пробійник зі старого дерева"
    t[179593] = "Маска Темнокраю"
    t[179594] = "Личина Зів'ялої Зневаги"
    t[179596] = "Друстівська Маска Панування"
    t[179602] = "Оплот Дикого Полювання"
    t[179603] = "Бар'єр з Кропив'яного Лушпиння"
    t[179604] = "Щит Сутінкового Вартового"
    t[179605] = "Бар'єр зі Старолісся"
    t[179607] = "Оплот Зимородженого"
    t[179608] = "Бар'єр Нічного Придворного"
    t[179609] = "Оплот Грішного Гладіатора"
    t[179610] = "Бойовий Щит Велетня-Землекопа"
    t[179611] = "Оплот Незламних"
    t[179613] = { name = "Особливо Липке Павутиння", fen = "Not long before it loses its stick!", fua = "Скоро воно втратить свою липкість!" }
    t[179620] = "Плащ Королівської Варти"
    t[179621] = "Кольчужний Плащ Завіту Арденвельду"
    t[179623] = "Сплетений Феями Покров"
    t[179624] = "Покрив Нічного Придворного"
    t[179625] = "Шовковий Плащ Консерватора"
    t[179626] = "Покривало Зимородженого"
    t[179628] = "Накидка Нічного Придворного"
    t[179630] = "Кольчужний Плащ Завіту Арденвельду"
    t[179631] = "Кольчужний Плащ Завіту Арденвельду"
    t[179632] = "Кольчужний Плащ Завіту Арденвельду"
    t[179633] = "Залізнодеревний Плащ Хранителя"
    t[179634] = "Плащ Нічного Придворного"
    t[179635] = "Плащ Зимородженого"
    t[179653] = "Просочена Світлом Кольчуга"
    t[179654] = "Роба Нічного Придворного"
    t[179655] = "Шовкові Шати Консерватора"
    t[179656] = "Зимороджена Роба"
    t[179657] = "Сплетена Феями Туніка"
    t[179658] = "Туніка Нічного Придворного"
    t[179659] = "Шовкова Туніка Консерватора"
    t[179660] = "Зимороджена Туніка"
    t[179661] = "Сандалі Нічного Придворного"
    t[179662] = "Шовкові Сандалі Консерватора"
    t[179663] = "Зимороджені Сандалі"
    t[179664] = { name = "Дзеркало Калісфени", fen = "Contains a memory of Kalisthene, which kyrian may train against in the Path of Ascension.", fua = "Містить спомин Калісфени, проти якого кіріани можуть тренуватися на Шляху Вознесіння." }
    t[179665] = "Обмотки Рук Нічного Придворного"
    t[179666] = "Шовкові Рукавички Консерватора"
    t[179667] = "Обмотки для Рук Зимородженого"
    t[179668] = "Каптур Нічного Придворного"
    t[179669] = "Шовковий Каптур Консерватора"
    t[179670] = "Каптур Зимородженого"
    t[179671] = "Поножі Нічного Придворного"
    t[179672] = "Шовкові Поножі Консерватора"
    t[179673] = "Поножі Зимородженого"
    t[179674] = "Оплічник Нічного Придворного"
    t[179675] = "Шовковий Оплічник Консерватора"
    t[179676] = "Амікт Зимородженого"
    t[179677] = "Кушак Нічного Придворного"
    t[179678] = "Шовковий Пояс Консерватора"
    t[179679] = "Зимороджений Пояс"
    t[179680] = "Манжети Нічного Придворного"
    t[179681] = "Шовкові Наручі Консерватора"
    t[179682] = "Манжети Зимородженого"
    t[179765] = "Дубосердя Туніка"
    t[179766] = "Дубосерді Обмотки"
    t[179767] = "Дубосерді Наручі"
    t[179768] = "Дубосердий Шолом"
    t[179769] = "Штани Дубосерда"
    t[179770] = "Дубосердий Оплічник"
    t[179771] = "Дубосердий Пояс"
    t[179772] = "Дубосерді Наручі"
    t[179773] = "Дубосердий Плащ"
    t[179774] = "Дубосердні Шати"
    t[179775] = "Шкіряна Туніка Консерватора"
    t[179776] = "Нагрудник Нічного Придворного"
    t[179777] = "Нагрудник Зимородженого"
    t[179778] = "Шкіряний Плащ Консерватора"
    t[179780] = "Накидка Зимородженого"
    t[179781] = "Шкіряні Чоботи Консерватора"
    t[179782] = "Обмотки на Щиколотки Нічного Придворного"
    t[179783] = "Обмотки на Кісточки Зимородженого"
    t[179784] = "Шкіряні Наручі Консерватора"
    t[179785] = "Наручі Нічного Придворного"
    t[179786] = "Наручні Щитки Зимородженого"
    t[179787] = "Шкіряний Вінець Консерватора"
    t[179788] = "Вінець Нічного Придворного"
    t[179789] = "Гребінь Зимородженого"
    t[179790] = "Шкіряні Штани Консерватора"
    t[179791] = "Штани Нічного Придворного"
    t[179792] = "Штани Зимородженого"
    t[179793] = "Шкіряні Шати Консерватора"
    t[179794] = "Одіння Нічного Придворного"
    t[179795] = "Зиморождені Шати"
    t[179796] = "Шкіряний Оплічник Консерватора"
    t[179797] = "Оплічник Нічного Придворного"
    t[179798] = "Оплічник Зимородженого"
    t[179799] = "Шкіряний Пояс Консерватора"
    t[179800] = "Пояс Нічного Придворного"
    t[179801] = "Пояс Зимородженого"
    t[179802] = "Шкіряні Наручі Консерватора"
    t[179803] = "Наручі Нічного Придворного"
    t[179804] = "Наручі Зимородженого"
    t[179823] = "Ключ Жнив"
    t[179830] = "Кольчужний Нагрудник Завіту Арденвельду"
    t[179831] = "Кольчужні Чоботи Завіту Арденвельду"
    t[179832] = "Кольчужні Рукавички Завіту Арденвельду"
    t[179833] = "Кольчужний Шолом Завіту Арденвельду"
    t[179834] = "Кольчужні Поножі Ковенанту Арденвельду"
    t[179835] = "Кольчужні Наплічники Завіту Арденвельду"
    t[179836] = "Кольчужний Пояс Завіту Арденвельду"
    t[179837] = "Кольчужні Наручі Завіту Арденвельду"
    t[179838] = "Кольчужні Наручі Завіту Арденвельду"
    t[179839] = "Кольчужний Пояс Завіту Арденвельду"
    t[179840] = "Кольчужні Наплічники Завіту Арденвельду"
    t[179841] = "Кольчужні Поножі Ковенанту Арденвельду"
    t[179842] = "Кольчужний Шолом Завіту Арденвельду"
    t[179843] = "Кольчужні Рукавички Завіту Арденвельду"
    t[179844] = "Кольчужні Чоботи Завіту Арденвельду"
    t[179845] = "Кольчужний Нагрудник Завіту Арденвельду"
    t[179846] = "Кольчужні Наручі Завіту Арденвельду"
    t[179847] = "Кольчужний Пояс Завіту Арденвельду"
    t[179848] = "Кольчужні Наплічники Завіту Арденвельду"
    t[179849] = "Кольчужні Поножі Ковенанту Арденвельду"
    t[179850] = "Кольчужний Шолом Завіту Арденвельду"
    t[179851] = "Кольчужні Рукавички Завіту Арденвельду"
    t[179852] = "Кольчужні Чоботи Завіту Арденвельду"
    t[179853] = "Кольчужний Нагрудник Завіту Арденвельду"
    t[179854] = "Кольчужні Наручі Завіту Арденвельду"
    t[179855] = "Кольчужний Пояс Завіту Арденвельду"
    t[179856] = "Кольчужні Наплічники Завіту Арденвельду"
    t[179857] = "Кольчужні Поножі Ковенанту Арденвельду"
    t[179858] = "Кольчужний Шолом Завіту Арденвельду"
    t[179859] = "Кольчужні Рукавички Завіту Арденвельду"
    t[179860] = "Кольчужні Чоботи Завіту Арденвельду"
    t[179861] = "Кольчужний Нагрудник Завіту Арденвельду"
    t[179887] = "Великий Шолом Королівської Варти"
    t[179888] = "Нагрудник Королівської Варти"
    t[179889] = "Чоботи Королівської Варти"
    t[179890] = "Латні Рукавиці Королівської Варти"
    t[179891] = "Поножі Королівської Варти"
    t[179892] = "Наплічники Королівської Варти"
    t[179893] = "Пояс Королівської Варти"
    t[179894] = "Наручі Королівської Варти"
    t[179895] = "Залізнодеревні Наручі Охоронця"
    t[179896] = "Залізнодеревний Пояс Хранителя"
    t[179897] = "Залізнодеревні Наплічники Охоронця"
    t[179898] = "Залізнодеревні Поножі Охоронця"
    t[179899] = "Залізнодеревний Великий Шолом Хранителя"
    t[179900] = "Залізнодеревні Латні Рукавиці Хранителя"
    t[179901] = "Залізнодеревні Чоботи Охоронця"
    t[179902] = "Залізнодеревний Нагрудник Хранителя"
    t[179903] = "Наручі Нічного Придворного"
    t[179904] = "Пояс Нічного Придворного"
    t[179905] = "Наплічники Нічного Придворного"
    t[179906] = "Поножі Нічного Придворного"
    t[179907] = "Великий Шолом Нічного Придворного"
    t[179908] = "Латні Рукавиці Нічного Придворного"
    t[179909] = "Латні Чоботи Нічного Придворного"
    t[179910] = "Нагрудна Пластина Нічного Придворного"
    t[179911] = "Зимороджені Наручі"
    t[179912] = "Ремінь Зимородженого"
    t[179913] = "Наплічники Зимородженого"
    t[179914] = "Поножі Зимородженого"
    t[179915] = "Великий Шолом Зимородженого"
    t[179916] = "Латні Рукавиці Зимородженого"
    t[179917] = "Зимороджені Чоботи"
    t[179918] = "Нагрудна Пластина Зимородженого"
    t[179922] = { name = "Анімашишка", fen = "A seed of condensed anima, fallen from one of the celestial trees. It's covered in saliva.", fua = "Зерня згущеної аніми, що впало з одного з небесних дерев. Воно вкрите слиною." }
    t[179924] = "Просочена Світлом Куртка"
    t[179925] = "Просочений Світлом Нагрудник"
    t[179926] = "Просочена Світлом Туніка"
    t[179927] = "Сяйливе Жало Скверноболота"
    t[179928] = "Ланцюговий Важіль Камери"
    t[179937] = { name = "Скалка Буйної Амбіції", fen = "Ambition can outstrip prudence.", fua = "Амбіції здатні взяти гору над розважливістю." }
    t[179938] = "Видобувачі Зруйнованої Пихи"
    t[179939] = { name = "Звивистий Павучий Кокон", fen = "Oooh they are ready to hatch!", fua = "Ооо, вони готові вилуплюватися!" }
    t[179940] = "Жилет Безкорисливого Форджлайта"
    t[179941] = "Чоботи Безкорисливого Форджлайта"
    t[179942] = "Рукавички Безкорисливого Форджлайта"
    t[179943] = "Шолом Безкорисливого Форджлайта"
    t[179944] = "Штани Самовідданого Ковача"
    t[179945] = "Наплічники Безкорисливого Форджлайта"
    t[179946] = "Пояс Безкорисливого Форджлайта"
    t[179947] = "Наручі Безкорисливого Форджлайта"
    t[179948] = "Плащ Безкорисливого Форджлайта"
    t[179949] = "Жилет Гармонійного Форджлайта"
    t[179950] = "Чоботи Гармонійного Форджлайта"
    t[179951] = "Рукавички Гармонійного Форджлайта"
    t[179952] = "Шолом Гармонійного Форджлайта"
    t[179953] = "Штани Гармонійного Форджлайта"
    t[179954] = "Наплічники Гармонійного Форджлайта"
    t[179955] = "Пояс Гармонійного Форджлайта"
    t[179956] = "Наручі Гармонійного Форджлайта"
    t[179957] = "Плащ Гармонійного Форджлайта"
    t[179958] = "Список Гостей Двору Жарин"
    t[179959] = "Жилет Дисгармонійного Форджлайта"
    t[179960] = "Чоботи Дисгармонійного Форджлайта"
    t[179961] = "Рукавички Дисгармонійного Форджлайта"
    t[179962] = "Шолом Дисгармонійного Форджлайта"
    t[179963] = "Штани Розбратного Форджлайта"
    t[179964] = "Наплічники Дисгармонійного Форджлайта"
    t[179965] = "Пояс Дисгармонійного Форджлайта"
    t[179966] = "Наручі Дисгармонійного Форджлайта"
    t[179967] = "Плащ Дисгармонійного Форджлайта"
    t[179968] = "Нагрудник Шанобливого Форджлайта"
    t[179969] = "Чоботи Шанобливого Форджлайта"
    t[179970] = "Рукавички Шанобливого Форджлайта"
    t[179971] = "Шолом Шанобливого Форджлайта"
    t[179972] = "Штани Шанобливого Форджлайта"
    t[179973] = "Наплічники Шанобливого Форджлайта"
    t[179974] = "Пояс Шанобливого Форджлайта"
    t[179975] = "Наручі Шанобливого Форджлайта"
    t[179976] = "Плащ Шанобливого Форджлайта"
    t[179977] = "Гонг Доброти"
    t[179978] = "Насичені Шишки Аніми"
    t[179979] = "Потертий Камінь Гріхів"
    t[179980] = "Тріснутий Камінь Гріха"
    t[179981] = "Надщерблений Камінь Гріха"
    t[179982] = "Кіріанський Дзвін"
    t[179983] = "Насичені Шишки Аніми"
    t[179984] = { name = "Ритуали й Обряди Вічного Війська", fen = "This book is filled with notes and information about the House of Rituals. Much of this is unknown to Baroness Draka.", fua = "Ця книга сповнена нотаток та відомостей про Дім Ритуалів. Багато чого з цього невідомо баронесі Драці." }
    t[179985] = "Тьмяні Скалки Вітражного Скла"
    t[179986] = "Стражденні Відлуння"
    t[179988] = "Обпалений Попелом Пояс"
    t[179989] = "Мереживні Манжети Маркіза"
    t[179990] = "Нагрудник Шаттерая"
    t[179991] = "Вибілені Світлом Поножі"
    t[179992] = "Вода Тіньового Джерела"
    t[179993] = "Насичена Брудна Вода"
    t[180000] = "Посох Покаянника"
    t[180001] = "Зимороджений Посох"
    t[180002] = "Шпиль довгої темряви"
    t[180003] = "Шпиль Нічного Куртизана"
    t[180004] = "Посох Грішного Гладіатора"
    t[180005] = "Посох Дикого Полювання"
    t[180008] = "Резонувальне Осердя Аніми"
    t[180009] = "Резонувальна Частинка Аніми"
    t[180018] = "Чарівна Паличка Зимороджених"
    t[180019] = "Чарівна Паличка Грішного Гладіатора"
    t[180020] = "Чарівна Паличка Нічного Придворного"
    t[180021] = "Чарівна Паличка Дикого Полювання"
    t[180022] = "Кореневе Бульбо Безгрішних"
    t[180023] = "Чарівна Паличка Деревної Майстерності"
    t[180035] = { name = "Око Провидця", fen = "A glowing, still twitching eye, pried directly from Leerok the Scryer.", fua = "Сяюче, ще тремтливе око, вирване просто з Лерока Провидця." }
    t[180051] = "Арбалет Пащі"
    t[180052] = { name = "Ліве Самоцвітне Око", fen = "Looks like the left eye of a massive gargoyle statue. Perhaps there's one missing this somewhere.", fua = "Схоже на ліве око величезної статуї ґаргульї. Можливо, десь стоїть така без нього." }
    t[180053] = { name = "Праве Самоцвітне Око", fen = "The right eye of a gigantic gargoyle statue. Maybe it's nearby.", fua = "Праве око велетенської статуї ґаргульї. Можливо, вона десь поблизу." }
    t[180061] = { name = "Феєрна Зброя", fen = "Bears signs of recent use.", fua = "Має сліди недавнього використання." }
    t[180062] = "Небесний Барабан"
    t[180063] = "Неземний Передзвін"
    t[180064] = "Флейта Піднесених"
    t[180071] = "Пронизливий Шукач Гріхів"
    t[180073] = "Довгий Лук Серцелова"
    t[180075] = "Лук Зимородженого"
    t[180077] = "Бойовий Лук Нічного Придворного"
    t[180079] = "Бойовий Лук Дикого Полювання"
    t[180081] = "Бойовий Лук Грішного Гладіатора"
    t[180085] = { name = "Кіріанська Пам'ятка", fen = "A small box of Kyrian design.", fua = "Маленька скринька кіріанського виробу." }
    t[180088] = "Рукописна Записка"
    t[180095] = "Покаянне Лезо"
    t[180096] = "Какофонічна Бойова Сокира Девос"
    t[180097] = "Бойовий Посох Розбрату"
    t[180098] = "Вбрання Лиховісного Реквієму"
    t[180099] = "Нагрудник Жорстокого Розладу"
    t[180100] = "Кольчуга Зреченого Переслідувача"
    t[180101] = "Бойові Чоботи Нещадної Рішучості"
    t[180102] = "Обмотки Темного Кроку"
    t[180103] = "Рукавички Крилатого Мисливця"
    t[180104] = "Латні Рукавиці Спотвореного Конструкта"
    t[180105] = "Рукавиці Немелодійного Конструкта"
    t[180106] = "Лицевий Захист Лютого Натиску"
    t[180107] = "Обмотки на Ноги Протоколу Очищення"
    t[180108] = "Безодняні Штани Розладу"
    t[180109] = "Лиховісний Пояс Кін-Тари"
    t[180110] = "Застібка Темного Преторіанця"
    t[180111] = "Пояс Тіньового Вихору"
    t[180112] = "Філософ"
    t[180113] = "Наручі Громового Відлуння"
    t[180114] = "Наручі Полеглого Взірця"
    t[180115] = "Амулет Лазурової Отрути"
    t[180116] = "Перезаряджена Батарея Аніми"
    t[180117] = "Емпірейна Боєприпаса"
    t[180118] = "Випромінювач Анімаполя"
    t[180119] = "Благословення Архонта"
    t[180123] = "Накидка Скривлених Відданостей"
    t[180126] = { name = "Висотане Дике Зерно", fen = "This wildseed's anima is almost completely drained, but the spirit within is still surviving.", fua = "Аніма цього дикого зерна майже повністю висотана, але дух усередині все ще виживає." }
    t[180128] = { name = "Елітний Гаманець з Винагородою Женця", fen = "The heavy purse jingles with a large amount of coins.", fua = "Важкий гаманець подзенькує безліччю монет." }
    t[180136] = { name = "«Посередницька Вудка»", fen = "The only apparatus required to extract aquatic wildlife from their habitats!", fua = "Єдине знаряддя, потрібне, щоб видобувати водну живність з її середовища!" }
    t[180142] = "Сокирка Мертвого Каменю"
    t[180143] = "Січун Темних Меж"
    t[180144] = "Топірець Білування Фей"
    t[180145] = "Ручна Сокира Зів'ялої Зневаги"
    t[180146] = "Сокира Зломленої Волі"
    t[180152] = "Друстська Дворучна Сокира"
    t[180153] = "Друсткований Кат"
    t[180154] = "Дворучна Сокира Невпинного Переслідування"
    t[180155] = "Розколювач Темних Меж"
    t[180156] = "Дворучна Сокира Висхлої Зневаги"
    t[180162] = "Друсткована Коса"
    t[180163] = "Жнець Чорного Терну"
    t[180164] = "Коса викривлювача душ"
    t[180165] = "Жнець Висхлої Зневаги"
    t[180166] = "Посох Зв'язувача Смерті"
    t[180168] = "Оріпоплавок"
    t[180170] = "Пульсівна Анімашишка"
    t[180172] = { name = "Анімашишка", fen = "Some anima still remains within this animacone.", fua = "У цій анімашишці ще лишилося трохи аніми." }
    t[180173] = { name = "Перстень Дому Грінчинів", fen = "Magical protections prevent those outside House Grinchin from holding it for long.", fua = "Магічний захист не дає тим, хто не належить до Дому Грінчинів, тримати його довго." }
    t[180174] = "Сорти Витерфолла для Витонченого Смаку"
    t[180175] = "Трактат про Генбестійську Логіку"
    t[180176] = { name = "Про Природу Божественного", fen = "A plain leather cover has been wrapped around the original illustrated jacket which displays a muscular stoneborn figure.", fua = "Простою шкіряною обкладинкою обгорнено первісну ілюстровану палітурку, на якій зображено м'язисту каменероджену постать." }
    t[180177] = "Роздуми про Справжні Імена"
    t[180208] = { name = "PHA7-YNX", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180209] = { name = "Розчинник Комах", fen = "Keeps the bugs off your body.", fua = "Відганяє комах від тіла." }
    t[180210] = "Зуб Вентира"
    t[180211] = "Око Вентира"
    t[180212] = "Піхви Вентира"
    t[180213] = "Ніготь Вентира"
    t[180214] = "Перстень Вентира"
    t[180215] = "Ребро Вентира"
    t[180216] = "Серце Вентира"
    t[180219] = { name = "Любовний Роман", fen = "Well-worn and falling apart.", fua = "Добряче зачитаний і розпадається." }
    t[180220] = { name = "Історичний Трактат", fen = "Well-worn and falling apart.", fua = "Добряче зачитаний і розпадається." }
    t[180221] = { name = "Збірник Жартів", fen = "Well-worn and falling apart.", fua = "Добряче зачитаний і розпадається." }
    t[180222] = { name = "Кулінарна Книга Смертних", fen = "Well-worn and falling apart.", fua = "Добряче зачитаний і розпадається." }
    t[180223] = { name = "Архівні Записи Камені гріхівв", fen = "Well-worn and falling apart.", fua = "Добряче зачитаний і розпадається." }
    t[180224] = { name = "Загублений Щоденник Габбінса", fen = "Well-worn and falling apart.", fua = "Добряче зачитаний і розпадається." }
    t[180225] = { name = "Детектив", fen = "Well-worn and falling apart.", fua = "Добряче зачитаний і розпадається." }
    t[180226] = { name = "Збірник Правил Гри", fen = "Well-worn and falling apart.", fua = "Добряче зачитаний і розпадається." }
    t[180227] = { name = "Роман Жахів", fen = "Well-worn and falling apart.", fua = "Добряче зачитаний і розпадається." }
    t[180228] = { name = "Книга із Саморозвитку", fen = "Well-worn and falling apart.", fua = "Добряче зачитаний і розпадається." }
    t[180229] = { name = "Автобіографія Таббінса", fen = "Well-worn and falling apart.", fua = "Добряче зачитаний і розпадається." }
    t[180230] = "Скалки Самоцвітів"
    t[180239] = "Шолом Шанобливого Збирача"
    t[180240] = "Нагрудник Шанобливого Збирача"
    t[180241] = "Бойові Чоботи Шанобливого Збирача"
    t[180242] = "Латні Рукавиці Шанобливого Збирача"
    t[180243] = "Поножі Шанобливого Збирача"
    t[180244] = "Наплічники Шанобливого Збирача"
    t[180245] = "Пояс Шанобливого Збирача"
    t[180246] = "Наручі Шанобливого Збирача"
    t[180247] = "Плащ Шанобливого Збирача"
    t[180248] = "Запас Посла"
    t[180249] = "Стежник Кам'яного Біса"
    t[180256] = "Бойова Глефа Зимородженого"
    t[180257] = "Бойова Глефа Нічного Придворного"
    t[180258] = "Пломучитель Фейського Лісу"
    t[180259] = "Бойова Глефа Дикого Полювання"
    t[180260] = "Бойова Глефа Танцівника Смерті"
    t[180261] = "Лезо Грішного Гладіатора"
    t[180263] = { name = "Рунний Олень Світломрії", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180264] = { name = "Жахна Підмога", fen = "Let Emeni handle it!", fua = "Хай цим займеться Емені!" }
    t[180267] = { name = "Малий Едді", fen = "No one like Eddie.", fua = "Едді ніхто не любить." }
    t[180270] = "Ключ від Клітки"
    t[180271] = { name = "Волокниста Спора", fen = "A stringy, potent spore.", fua = "Волокниста, потужна спора." }
    t[180273] = "Згуба скорботи"
    t[180275] = { name = "Маскування під Конструкта", fen = "Almost as good as the real thing.", fua = "Майже не відрізнити від справжнього." }
    t[180277] = { name = "Ключ від Фронтових Пайків", fen = "Key to the Battlefront Rations at the Spearhead.", fua = "Ключ до Фронтових Пайків біля Вістря Списа." }
    t[180278] = "Легендарні Сили"
    t[180279] = { name = "Уламок Каменя Гріхів", fen = "Contains a detailed account of mortal sins.", fua = "Містить докладний перелік смертних гріхів." }
    t[180281] = { name = "Уламок Каменя Гріхів", fen = "Contains a detailed account of mortal sins.", fua = "Містить докладний перелік смертних гріхів." }
    t[180282] = { name = "Уламок Каменя Гріхів", fen = "Contains a detailed account of mortal sins.", fua = "Містить докладний перелік смертних гріхів." }
    t[180283] = { name = "Уламок Каменя Гріхів", fen = "Contains a detailed account of mortal sins.", fua = "Містить докладний перелік смертних гріхів." }
    t[180284] = { name = "Уламок Каменя Гріхів", fen = "Contains a detailed account of mortal sins.", fua = "Містить докладний перелік смертних гріхів." }
    t[180286] = { name = "Зламана Вудка", fen = "Doesn't look usable.", fua = "Скидається на непридатну." }
    t[180287] = "Награбована Аніма"
    t[180289] = { name = "Сінвірова Статуетка", fen = "Depicting a venerable member of House Briarbane, the statue is exquisite.", fua = "Вишукана статуя зображує шанованого члена Дому Тернотерну." }
    t[180290] = "Камінь Повернення Нічних Фе"
    t[180291] = "Насінина Душлозу"
    t[180292] = "Чарівний Пил"
    t[180293] = "Відзнака Нічних Фе"
    t[180295] = { name = "Сигіл Тіні", fen = "The surface of the object is decorated with curious markings.", fua = "Поверхню предмета прикрашають дивні гравірування." }
    t[180296] = { name = "Голова Прихованого Некроманта", fen = "Spies lurk in the shadows of the Ember Court. Baroness Vashj will be interested in this. (|cfff2e699+Bonus Happiness|r)", fua = "Шпигуни ховаються в тінях Жариного Двору. Баронесу Вашж це зацікавить. (|cfff2e699+Бонус до задоволення|r)" }
    t[180297] = { name = "Зачаровані Нотатки", fen = "The writing appears to be protected by a veil of runes.", fua = "Письмена, схоже, захищені пеленою рун." }
    t[180298] = "Сплетіння Гріха"
    t[180299] = "Сплетіння Гріха"
    t[180300] = "Сплетіння Гріха"
    t[180301] = "Сплетіння Гріха"
    t[180302] = "Сплетіння Гріха"
    t[180303] = "Сплетіння Гріха"
    t[180304] = "Сплетіння Гріха"
    t[180305] = "Сплетіння Гріха"
    t[180306] = "Сплетіння Гріха"
    t[180307] = "Жахливий Кам'яний Лик"
    t[180308] = "Рішуче Кам'яне Обличчя"
    t[180310] = "Тріпотливі Кам'яні Крила"
    t[180311] = "Дрючок Самовідданого Збирача"
    t[180312] = "Захисний Дрюк Голіафа"
    t[180313] = "Великий Молот Грішного Гладіатора"
    t[180314] = "Просочена Сумнівом Палиця"
    t[180315] = "Скіпетр Віри Полемарха"
    t[180316] = "Великий Молот Гармонійного Збирача"
    t[180317] = "Душевне Зілля Зцілення"
    t[180318] = "Душевне Зілля Мани"
    t[180319] = "Кулон Кислого Вина"
    t[180320] = "Намисто Темножилля"
    t[180321] = "Амулет Первоцвіту"
    t[180322] = "Намисто Гріхоіклих"
    t[180323] = "Намисто Чорного Лиха"
    t[180324] = "Намисто Айрмору"
    t[180325] = "Амулет Ределавів"
    t[180326] = { name = "Покручена Парасолька", fen = "A bit beyond repair, but potentially worth some coin as parts.", fua = "Лагодженню вже не підлягає, та частини, можливо, варті кількох монет." }
    t[180327] = "Колекція Жаринових Бліх"
    t[180328] = "Привидні Сліди: Трактат про Незримі Стежки"
    t[180329] = "Гола Ланцюгова Моргенштерн-Булава"
    t[180330] = "Згасаючий Прапорець Денатріуса"
    t[180331] = "Різець Каменотески"
    t[180332] = "Скинуті Кінчики Крил"
    t[180333] = "Стривожене Намисто-Ліра"
    t[180334] = "Тріснутий Кухоль"
    t[180335] = "Міцні Вила"
    t[180336] = "Ледь Тліючий Смолоскип"
    t[180337] = "Іржавий Ручний Серп"
    t[180338] = "Різьблений Ідол"
    t[180339] = "Тіньооздоблений Келих"
    t[180340] = "Темні Омани та Відволікання"
    t[180341] = "Реліквія Натрезімів"
    t[180342] = "Посріблене Ікло"
    t[180343] = "Вічногорюче Кадило"
    t[180344] = "Вогники Жахіть"
    t[180345] = "Флакон Забутого Сну"
    t[180346] = "Кришталевий Виріб із Цвяхами"
    t[180347] = "Столове Срібло з Гріхосталі"
    t[180348] = "Оздоблена Філігранна Арфа"
    t[180349] = "Перстень Послушника Натрезімів"
    t[180350] = "Простий Кам'яний Перстень"
    t[180351] = "Потертий Перстень Побожності"
    t[180352] = "Тріснутий Перстень Інквізитора"
    t[180353] = { name = "Примарний Кишеньковий Камінь", fen = "Old venthyr tales speak of good luck coming from some simple objects.", fua = "Давні венфірські перекази розповідають, що деякі прості речі приносять удачу." }
    t[180354] = "Роздерта Набивка"
    t[180355] = "Оздоблена Дароносиця"
    t[180357] = "Сплетіння Гріха"
    t[180358] = "Сплетіння Гріха"
    t[180359] = "Сплетіння Гріха"
    t[180360] = "Сплетіння Гріха"
    t[180361] = "Сплетіння Гріха"
    t[180362] = "Сплетіння Гріха"
    t[180363] = "Сплетіння Гріха"
    t[180364] = "Сплетіння Гріха"
    t[180365] = "Сплетіння Гріха"
    t[180366] = "Сплетіння Гріха"
    t[180367] = "Сплетіння Гріха"
    t[180368] = "Сплетіння Гріха"
    t[180369] = "Сплетіння Гріха"
    t[180370] = "Сплетіння Гріха"
    t[180371] = "Сплетіння Гріха"
    t[180372] = "Сплетіння Гріха"
    t[180373] = "Сплетіння Гріха"
    t[180374] = "Сплетіння Гріха"
    t[180375] = "Ранець Згубника Надії"
    t[180376] = "Сплетіння Гріха"
    t[180377] = "Червоний Ром"
    t[180378] = "Ящик Майстра-Коваля"
    t[180379] = { name = "Вишукано Тканий Килим", fen = "An accomplished tailor can deconstruct the rug to use the materials for their own purposes.", fua = "Вправний кравець може розібрати килим, щоб використати матеріали для власних потреб." }
    t[180380] = { name = "Мереживні Драпування", fen = "An accomplished tailor can deconstruct the draperies to use the materials for their own purposes.", fua = "Вправний кравець може розібрати драпування, щоб використати матеріали для власних потреб." }
    t[180381] = "Мозкокорінь"
    t[180382] = "Опікоколос"
    t[180383] = "Чортів Послід"
    t[180384] = "Шибенична Трава"
    t[180385] = "Крило Кажана"
    t[180386] = "Мішечок Травника"
    t[180387] = "Крихкий Камінь Гріха"
    t[180388] = "Мушкетон Душолова"
    t[180389] = "Чоботи Згубнолісся"
    t[180390] = "Пояс Багатьох Трофеїв"
    t[180391] = "Поножі Затемнювачів Небес"
    t[180392] = "Кам'яні Кулаки Ґаргулі"
    t[180393] = "Еполети Розпусного Чорноклинка"
    t[180394] = "Поножі, Оздоблені Заздрістю"
    t[180395] = "Кольчуга Хрестоносця Натрезімів"
    t[180396] = "Наручі Згасаючої Людяності"
    t[180397] = "Вінець Занепадницьких Бажань"
    t[180398] = "Кам'яна Алебарда Легіону"
    t[180400] = "Останній Вирок Інквізиції"
    t[180401] = "Шляхетне Правосуддя"
    t[180402] = "Бар'єр Забутих"
    t[180403] = "Посудина Очищеного Жалю"
    t[180404] = { name = "Лосьйон Жаротону", fen = "HPF 500", fua = "СЗФ 500" }
    t[180405] = "Іржавий Ланцюг Ґаргона"
    t[180406] = "Ласощі для Ґарґона"
    t[180407] = "Порожня Пляшка з-під Бренді"
    t[180408] = "Порожня Фіала з-під Бренді"
    t[180410] = "Тліючий Трунок Тіней"
    t[180411] = "Даркгейвенський Стаут"
    t[180412] = "Яблучний Сидр із Дредголлоу"
    t[180413] = { name = "Тінелистий Рунний Олень", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180414] = { name = "Рунний Олень Пробудника", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180415] = { name = "Рунний Олень Зимороджених", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180416] = "Арія Туманозова"
    t[180417] = "Балада Туманозова"
    t[180418] = "Марш Туманозова"
    t[180419] = "Жалобна Пісня Туманозова"
    t[180421] = { name = "Жаропад", fen = "\"The artist depicts a holy inferno descending upon Revendreth.\"", fua = "«Митець зображує священне пекло, що сходить на Ревендрет.»" }
    t[180422] = "Дорога Згубнолісся"
    t[180423] = "Герцогиня Гельвіра"
    t[180424] = "Престижний Плащ Грішного Гладіатора"
    t[180425] = "9.0 PvP - PvP Reward - Accessory - Cloak - 02"
    t[180426] = "9.0 PvP - PvP Reward - Accessory - Cloak - 03"
    t[180427] = "9.0 PvP - PvP Reward - Accessory - Cloak - 04"
    t[180428] = "9.0 PvP - PvP Reward - Accessory - Cloak - 05"
    t[180429] = { name = "Ліплений Вручну М'ясохліб", fen = "Care and hair went into baking this Maldraxxi delicacy.", fua = "У випікання цих малдраксійських ласощів вкладено турботу і волосся." }
    t[180430] = "Легка Закуска"
    t[180431] = "Накидка Грішного Гладіатора"
    t[180432] = "9.0 PvP - PvP Reward - Tabard - 2"
    t[180433] = "9.0 PvP - PvP Reward - Tabard - 3"
    t[180434] = "9.0 PvP - PvP Reward - Tabard - 4"
    t[180435] = "9.0 PvP - PvP Reward - Tabard - 5"
    t[180436] = { name = "Список Дикого Насіння", fen = "A short list of names.", fua = "Короткий перелік імен." }
    t[180437] = { name = "Медальйон Панування", fen = "Its immense power passively pulls in anima from the air around it.", fua = "Його неосяжна сила пасивно притягує аніму з навколишнього повітря." }
    t[180439] = { name = "Жаба в Торбі", fen = "The frog kicks enthusiastically against the bag. Good thing The Craw likes its food lively.", fua = "Жаба завзято б'ється об торбу. Добре, що Зоб полюбляє свою їжу жвавою." }
    t[180440] = { name = "Сигіл Дисципліни", fen = "The markings depict various runes encircling a figure, kneeling in servitude.", fua = "Гравірування зображує різноманітні руни, що оточують постать, схилену в покорі." }
    t[180441] = { name = "Сигіл Самопожертви", fen = "The object emits a soft, verdant glow.", fua = "Предмет випромінює м'яке, зелене сяйво." }
    t[180443] = { name = "Нотатки Дослідника", fen = "The ink's color and thickness vary between the two halves of the worn parchment, suggesting the continuation of previous work.", fua = "Колір і густота чорнила різняться на двох половинах потертого пергаменту, що вказує на продовження попередньої праці." }
    t[180444] = "Обраний Пояс Гармонії"
    t[180445] = "Планер Небоходця"
    t[180446] = { name = "Напрочуд Їдке Вариво", fen = "Reverse engineered and completely safe for carrying... mostly.", fua = "Відтворене зворотною інженерією і цілком безпечне для перенесення... здебільшого." }
    t[180447] = { name = "Анімашишка", fen = "A seed of condensed anima, fallen from one of the celestial trees.", fua = "Насінина концентрованої аніми, що впала з одного з небесних дерев." }
    t[180448] = { name = "Зношений Тепловідвід", fen = "Absorbs heat energy produced  by bastion constructs.", fua = "Поглинає теплову енергію, що її виробляють конструкти Бастіону." }
    t[180449] = { name = "Невдалий експеримент", fen = "Its design is complex and obtuse. No discernible use could be derived upon examination.", fua = "Її будова складна й заплутана. Навіть після огляду не вдалося визначити жодного зрозумілого призначення." }
    t[180450] = { name = "Різні Болти", fen = "A pile of extra bolts... they must go to something! Right?", fua = "Купа зайвих болтів... вони ж мають кудись підходити! Чи не так?" }
    t[180451] = { name = "Уламок Гріхокаменю Великого Інквізитора", fen = "Archivist Fane needs these to recreate Grand Inquisitor Sinstones, which will allow you to hunt the most dangerous inquisitors in the Halls of Atonement.", fua = "Архіваріусу Фейну вони потрібні, щоб відтворити Камені гріхів великих інквізиторів, які дозволять вам полювати на найнебезпечніших інквізиторів у Залах Спокути." }
    t[180452] = { name = "Спис Калліопи", fen = "It is arguably the most impressive spear you have encountered.", fua = "Без сумніву, це найвражаючіший спис, який вам траплявся." }
    t[180453] = { name = "Вона Мала Кам'яне Серце", fen = "A poem written in a stony hand, it evokes a slight stirring in its simple prose.", fua = "Вірш, написаний кам'яною рукою, що навіть простою прозою викликає легкий трепет." }
    t[180456] = "Барви Невмирущої Армії"
    t[180457] = { name = "Тіньокамінь", fen = "Created by players with the Alchemy skill. Can be bought and sold on the auction house.", fua = "Створюється гравцями з умінням алхімії. Можна купити й продати на аукціоні." }
    t[180458] = { name = "Грамота про Звільнення від Десятини", fen = "By the order of the Taskmaster, the bearer is exempt from four anima tithings. Proportionate compensation may be given for transfer of this writ.", fua = "За наказом Наглядача, власник звільняється від чотирьох десятин аніми. За передачу цієї грамоти може бути надана відповідна винагорода." }
    t[180459] = { name = "Плащ Висихання", fen = "An excellent cut for an overly Holy desiccated land.", fua = "Чудовий крій для надміру священної, висохлої землі." }
    t[180461] = { name = "Жахливий Дредвінг", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180462] = { name = "Маска Одержимості", fen = "This unused mask appears to be dormant and safe to wear.", fua = "Ця невживана маска видається сплячою і безпечною для носіння." }
    t[180463] = "Заскорузлий Скіпетр"
    t[180464] = "Креслення: Капці Герольда"
    t[180465] = "Досяг Ксандрії"
    t[180466] = { name = "Підроблений Дозвіл", fen = "You have added enough blobs of sealing wax that you're sure this will work.", fua = "Ти наляпав стільки печаткового воску, що певен: це спрацює." }
    t[180470] = { name = "Дикий Гриб", fen = "It might be delicious. It might kill you. Picky Stefan will be interested in this. (|CFF1b8729+Humble|R)", fua = "Може, він смачний. А може, тебе вб'є. Перебірливий Стефан зацікавиться цим. (|CFF1b8729+Скромно|R)" }
    t[180471] = { name = "Пил Сутності", fen = "The powdery substance shimmers ever so slightly.", fua = "Порошкоподібна речовина ледь-ледь мерехтить." }
    t[180472] = "Креслення: Тризуб Глибинної Луни"
    t[180473] = "Чаробулава з Кулексового Дерева"
    t[180474] = "Кинджал із Кулексового Дерева"
    t[180475] = "Перетинчаста Лапа"
    t[180476] = "Снодійний Слиз"
    t[180477] = { name = "Елізійське Пір'я", fen = "A common reagent across the Shadowlands, these special feathers can be found nestled in the wings of many flying creatures.", fua = "Поширений реагент по всіх Тінеземлях, це особливе пір'я можна знайти в крилах багатьох летючих створінь." }
    t[180478] = { name = "Хутро Чемпіона", fen = "Though these shimmering pelts can be harvested from many creatures, rumor holds that Ardenweald hunters often find them when culling overpopulated beasts.", fua = "Хоча ці мерехтливі шкури можна здобути з багатьох створінь, подейкують, що мисливці Арденвельду часто знаходять їх, прорідивши надмірно розплоджених звірів." }
    t[180479] = "Талісман Стійкості"
    t[180480] = "Малдраксійська Метальна Сокира"
    t[180481] = { name = "Дивне Креслення", fen = "It seems to detail a piece of equipment.", fua = "Здається, воно описує частину спорядження." }
    t[180482] = "Креслення: Талісман Стійкості"
    t[180483] = "[PH] Legendary Dust"
    t[180484] = { name = "Флейта Ноко", fen = "The traveling flute of an ancient caravan. (|CFFfbdd52+Exciting|R)", fua = "Дорожня флейта стародавньої каравани. (|CFFfbdd52+Захопливо|R)" }
    t[180485] = { name = "Щаслива Скрипка Анселя", fen = "Lucky or not, this is a beautiful instrument. (|CFFfbdd52+Exciting|R)", fua = "Щаслива чи ні, а це прекрасний інструмент. (|CFFfbdd52+Захопливо|R)" }
    t[180486] = { name = "Лютня Чіу", fen = "The back of the neck is covered in pandaren etchings. (|CFFfbdd52+Exciting|R)", fua = "Тильний бік грифа вкритий пандаренськими гравюрами. (|CFFfbdd52+Захопливо|R)" }
    t[180487] = "Накладка на Кулак Стоунфіста"
    t[180488] = "Кований Кулаком Нагрудник"
    t[180489] = { name = "Багатошарова Рапіра Майстра-Коваля", fen = "Never loses its edge.", fua = "Ніколи не втрачає гостроти." }
    t[180490] = "Колючки Душолова"
    t[180491] = "Шпиль Крилатого Танцюриста"
    t[180493] = "Роба Інквізитора"
    t[180494] = "Креслення: Духокована Егіда"
    t[180495] = "Креслення: Фіал Безтурботності"
    t[180496] = "Покрив Ганьби Верховного Інквізитора"
    t[180497] = "Маскування Дому Айрмор"
    t[180498] = "Непристойна Шаль Верховного Інквізитора"
    t[180499] = "Плащ Фанатизму Верховного Інквізитора"
    t[180500] = "Кривавий Плащ Верховного Інквізитора"
    t[180501] = "Головна Клітка у Формі Черепа"
    t[180502] = "Рукавички Катеси Адрастії"
    t[180503] = "Душеклинка Великого Арканіста"
    t[180504] = "Сопілка Мерехтливого Гілля"
    t[180505] = "Тріснута Кам'яна Маска"
    t[180506] = "Несправний Гарпун"
    t[180507] = "Пух Пернатого Дрейка"
    t[180508] = "Дзвіночок Нічної Лілії"
    t[180509] = "Арфа зі Струнами з Гриви"
    t[180510] = "Пакетик Чаю з Гібіскуса"
    t[180511] = "Скам'янілий Листок"
    t[180512] = "Жолудь Вартового"
    t[180513] = "Снодійна Поганка"
    t[180514] = "Браслет Ґорма"
    t[180515] = "Дивне Яйце"
    t[180516] = "Волинка Спріґана"
    t[180517] = "Життєтворна Флейта"
    t[180518] = "Голка Із Залізодерева"
    t[180519] = "Безживна Гілка"
    t[180520] = "Тріснута Бурштинова Лялька"
    t[180521] = "Павутина Повзучого Рою"
    t[180522] = "Федрумова Скринька"
    t[180531] = "[PH] Twisted Dust"
    t[180532] = "Окссеїнова Скринька"
    t[180533] = "Соленієва Скринька"
    t[180543] = { name = "Дикий Ґормовий Жир", fen = "More potent than the domestic-grown variety.", fua = "Дієвіший за різновид, вирощений у неволі." }
    t[180579] = "Ступаки Герольда"
    t[180581] = { name = "Ґаргон-Надієтрощій", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180582] = { name = "Прив'язь Літуна Кінцетопу", fen = "Teaches you how to summon an Endmire Flyer.", fua = "Навчає призивати Літуна Кінцетопу." }
    t[180594] = { name = "Загрубіла Кістка", fen = "These bones are well-worn, beaten and battered over time from use and exposure to the elements. It's clear that these were collected from creatures with exposed bone in Maldraxxus.", fua = "Ці кістки добряче зношені, побиті й потерті часом від ужитку та негоди. Очевидно, що їх зібрали зі створінь з оголеними кістками в Малдраксусі." }
    t[180595] = { name = "Ніччю Викувана Криця", fen = "An incredible metal forged by the venthyr, it often finds its way into their armor and blades.", fua = "Неймовірний метал, викуваний вентирами, що часто йде на їхні обладунки та клинки." }
    t[180606] = { name = "Звіт Ара'лона", fen = "A written account of the events that transpired near Blackthorn Grove.", fua = "Письмовий опис подій, що сталися біля Гаю Чорношипа." }
    t[180607] = { name = "Шифр Осліплення", fen = "You cannot fathom the writing on this device.", fua = "Ти не годен збагнути письмена на цьому пристрої." }
    t[180613] = "Крихкий Сувій Смирення"
    t[180623] = "Подерта Сторінка, Вкрита Рунами"
    t[180624] = "Ледь Сяйливий Пергамент"
    t[180625] = "Насичений Друстський Фетиш"
    t[180626] = "Шифр Мелодії"
    t[180627] = { name = "Спокійний Бродник", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180628] = { name = "Перлокрила Чапля", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180629] = { name = "Пожиральний Анімокліщ", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180630] = { name = "Гонитель Ґорм", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180631] = { name = "Колій Ґорм", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180632] = { name = "Корененосій Ґорм", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180633] = { name = "Личинко", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180634] = { name = "Глубер у Ролі Г'хууна", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180635] = { name = "Голодний Норокопач", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180636] = { name = "Вербовий Вітерець", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180637] = { name = "Зоряне Сновидне Лоша", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180638] = { name = "Пухнастий Мерехтливий Метелик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180639] = { name = "Запорошений Спорокрил", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180640] = { name = "Бурштинове Блискокриле", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180641] = { name = "Флуфа", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180642] = { name = "Хмаропере Пташеня", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180643] = { name = "Щебетливий Долинний Крикун", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180644] = { name = "Каменюка", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180645] = { name = "Спритник", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180646] = "Припаси Невмирущої Армії"
    t[180651] = { name = "Викинуте Ядро Фалінкса", fen = "The core glows softly violet, evidence of its corruption.", fua = "Ядро м'яко світиться фіолетовим, що свідчить про його зіпсуття." }
    t[180652] = { name = "Чарівний Ловець Снів", fen = "Protects against nightmares and wards away blight.", fua = "Захищає від кошмарів і відганяє згубу." }
    t[180653] = { name = "Міфічний Ключ", fen = "Place within the Font of Power inside the dungeon on Mythic difficulty.", fua = "Помістіть у Джерело Сили всередині підземелля на Міфічній складності." }
    t[180657] = "Кристалізований Іхор"
    t[180658] = "Кристал Згасання Світла"
    t[180659] = "Душевисмоктувальна Скалка"
    t[180660] = "Пергаменти Темної Вежі: Миттєвий Поліморфіст"
    t[180661] = "Пергаменти Темної Вежі: Найгидкіша Неміч"
    t[180663] = "Кісткопила Воєнного Книжника"
    t[180664] = "Трощитель Воскреслого Ката"
    t[180665] = "Захланний Великий Посох"
    t[180666] = "Бойовий Клинок Кісткогнута"
    t[180667] = "Збільшений Арбалет зі Щелепи"
    t[180668] = "Чарівна Паличка Воєнного Книжника"
    t[180669] = "Дворучний Меч Оживленого Ката"
    t[180670] = "Бастіон Жорстокого Ката"
    t[180671] = "Фоліант Воєнного Книжника"
    t[180672] = "Бойова Глефа Кісткогнута"
    t[180673] = "Меч Воскреслого Ката"
    t[180674] = "Чарівна Паличка Буркотливості"
    t[180675] = { name = "Чарівна Паличка Величної Постави", fen = "When you just need to put on a face to take on anything.", fua = "Коли треба лише прибрати належну подобу, щоб упоратися з будь-чим." }
    t[180676] = "Викинута Грамота"
    t[180677] = "Викинута Медаль Звитяги"
    t[180678] = { name = "Велетенський Жолудь", fen = "It's worth a try.", fua = "Варто спробувати." }
    t[180682] = "Гардероб Дворянина"
    t[180683] = "Вартове Кам'яне Крило"
    t[180684] = "Вартовий Кам'янокрил"
    t[180685] = "Скіпка Душі"
    t[180686] = "«Позичений» Камінь Душі"
    t[180687] = "Залишки Аніми"
    t[180688] = "Насичений Залишок Світла"
    t[180689] = "Кишеньковий Жар"
    t[180690] = "Хмара Попелу в Пляшці"
    t[180691] = "Огортальна Хмара Попелу"
    t[180692] = "Коробка Пасток Переслідувача"
    t[180693] = "Циклонічні Хроніки"
    t[180694] = "Фоліант Сили"
    t[180696] = "Відзнака Крила Легіону"
    t[180697] = "Відзнака Командира Ескадрильї"
    t[180704] = "Насичене Печиво для Улюбленця"
    t[180705] = "Посібник з Дресури Ґарґона"
    t[180706] = "Їдкий Бруд"
    t[180707] = "Липкий Бруд"
    t[180708] = "Дзеркало Розпачу"
    t[180709] = "Гартована Латка для Броні"
    t[180710] = "Кишеньковий Ремонтний Набір"
    t[180713] = "Гортань Верескуна"
    t[180714] = "Ендмайрська Мазь"
    t[180715] = "Гнів у Пляшці"
    t[180718] = "Звичайний Кристал"
    t[180721] = { name = "Зачарований Рунний Олень Світломрії", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180722] = { name = "Зачарований Тінелистий Руноолень", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180723] = { name = "Зачарований Руноолень Пробудника", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180724] = { name = "Зачарований Зимороджений Руноолень", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180725] = { name = "Колючопащий Гаєжер", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180726] = { name = "Блідий Кислотопаст", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180727] = { name = "Бігун Мерехтливого Туману", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180728] = { name = "Прудкий Похмурокопит", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180729] = { name = "Сутінковокрилий Арденметелик", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180730] = { name = "Дикий Мерехтливохутрий Скрадач", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180731] = { name = "Колиска Дикого Зерня", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180732] = { name = "Флакон, Гравірований Рунами", fen = "Used for containing a variety of liquids. Sold by Alchemy vendors.", fua = "Слугує для зберігання різноманітних рідин. Продається у торговців алхімією." }
    t[180734] = "Журнал Алхіміка"
    t[180735] = "Бездіяльна Відзнака"
    t[180736] = "Журнал Коваля"
    t[180737] = "Щоденник Кухаря"
    t[180738] = "Щоденник Зачаровувача"
    t[180739] = "Щоденник Інженера"
    t[180740] = "Журнал Рибалки"
    t[180741] = "Журнал Квітникаря"
    t[180742] = "Щоденник Писаря"
    t[180743] = "Журнал Ювеліра"
    t[180744] = "Журнал Шкіряра"
    t[180745] = "Щоденник Шахтаря"
    t[180746] = "Журнал Шкуролупа"
    t[180747] = "Журнал Кравця"
    t[180748] = { name = "Шовковистий Мерехтливий Метелик", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180749] = "Пошрамований Боями Оплот Гаука"
    t[180751] = "Червона Свічка-Голова"
    t[180752] = "Рожевий Святковий Ковпак"
    t[180753] = { name = "Садовий Набір Мерехтливої Зірки", fen = "Faerie tools used to tend the gardens of Ardenweald.", fua = "Чарівні знаряддя, якими доглядають сади Арденвельду." }
    t[180755] = "Феїна Святкова Маска"
    t[180760] = "Вінець Праведного"
    t[180761] = { name = "Фалінкс Вірності", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180762] = { name = "Фалінкс Смирення", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180763] = { name = "Фалінкс Відваги", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180764] = { name = "Фалінкс Чистоти", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180765] = { name = "Вічний Фалінкс Чистоти", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180766] = { name = "Вічний Фалінкс Відваги", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180767] = { name = "Вічний Фалінкс Вірності", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180768] = { name = "Вічний Фалінкс Смирення", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180769] = "Розколоте Кам'яне Крило"
    t[180771] = { name = "Зілля Незвичайної Сили", fen = "A cheap performance enhancer used by arena combatants.", fua = "Дешевий стимулятор, яким користуються бійці арени." }
    t[180772] = { name = "Срібновітровий Ларіон", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180773] = { name = "Сонцетанець", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180774] = { name = "Збережені Ягоди", fen = "These dried berries are wrinkled and scorched. They were collected from a dead world.", fua = "Ці сушені ягоди зморщені й обпалені. Їх зібрали в мертвому світі." }
    t[180777] = { name = "Ключ, Викуваний у Тросі", fen = "Unlocks the gate to Kivarr's cage.", fua = "Відмикає браму до клітки Ківарра." }
    t[180778] = { name = "Посудина Арденвельду", fen = "Willowblossom's essence infuses the vessel. It will serve as the heart of the newly-constructed Crest of Ascension.", fua = "Сутність Вербоцвіт сповнює посудину. Вона слугуватиме серцем новоствореного Герба Піднесення." }
    t[180780] = { name = "Рецепт: Червона Свічка-Голова", fen = "Teaches you how to make a Red Noggin Candle.", fua = "Навчає, як виготовити Червону Свічку-Голову." }
    t[180781] = { name = "Викрійка: Рожевий Святковий Капелюх", fen = "Teaches you how to make a Pink Party Hat.", fua = "Навчає, як виготовити Рожевий Святковий Капелюх." }
    t[180782] = { name = "Техніка: Феєрична Святкова Маска", fen = "Teaches you how to make a Fae Revel Masque.", fua = "Навчає, як виготовити Феєричну Святкову Маску." }
    t[180783] = { name = "Креслення: Вінець Праведного", fen = "Teaches you how to make a Crown of the Righteous.", fua = "Навчає, як виготовити Вінець Праведного." }
    t[180785] = "Згущена Сутність"
    t[180786] = "Порожня Палітурка"
    t[180787] = { name = "Зламаний Обладунок Зел'хана", fen = "The broken remains of Zel'han's armor. An image of Mueh'zala is cracked in two.", fua = "Зламані рештки обладунку Зел'хана. Зображення Мує'зали тріснуло навпіл." }
    t[180788] = { name = "Поминальне Вино", fen = "A beverage often used to honor the memories of those who are gone.", fua = "Напій, яким часто вшановують пам'ять тих, кого вже немає." }
    t[180790] = "Посох Воєнного Книжника"
    t[180791] = "Заточка Воскреслого Ката"
    t[180792] = "Короткий Меч Воєнного Книжника"
    t[180793] = "Посох у Кістяних Лещатах"
    t[180794] = "Закривавлений Короткий Меч"
    t[180795] = "Закривавлена Кісткова Пилка"
    t[180796] = "Перо Мерехтливого Польоту"
    t[180797] = { name = "Ключ Поминальної Пожертви", fen = "A key to a small chest of offerings.", fua = "Ключ до невеликої скрині з пожертвами." }
    t[180798] = { name = "PH - Kyrian IOU", fen = "The hastily scribled note suggests you have emptied the Kyrian coffers of gold for the week.", fua = "Нашвидкуруч надряпана записка натякає, що ви спорожнили кірійські скрині золота на цей тиждень." }
    t[180800] = { name = "Спотворений Шифр Переміщення", fen = "Thrumming with Stygian energy, yet completely non-functional.", fua = "Бринить стигійською енергією, та геть непридатний до вжитку." }
    t[180809] = "Елізійський Ріг"
    t[180810] = { name = "Метальний Череп", fen = "A medium sized skull, perfect for playing fetch with.", fua = "Череп середнього розміру, ідеальний, щоб гратися в апорт." }
    t[180811] = "Улюблений Череп Смертоіклого"
    t[180812] = { name = "Золотий Хмаропер", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180813] = { name = "Срібний Терокіготь", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180814] = { name = "Темнинка", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180815] = { name = "Світлолуске Маля", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180816] = { name = "Відзнака Зреченців", fen = "Inscribed on the back in fine calligraphy is the phrase \"We fall, only to rise.\"", fua = "На звороті вишуканою каліграфією виведено: \"Ми падаємо лише для того, щоб піднятися\"." }
    t[180817] = "Шифр Переміщення"
    t[180818] = "Кісткозлита Кісткопилка"
    t[180819] = "Кісткозлитий Трощій"
    t[180820] = "Великий Посох, Зрослий з Кісткою"
    t[180821] = "Кісткозлитий Бойовий Клинок"
    t[180822] = "Арбалет, Сплавлений з Кісток"
    t[180823] = "Дворучний Меч, Зрослий з Кісткою"
    t[180824] = "Кісткозлитий Меч"
    t[180825] = "Кісткозлита Заточка"
    t[180826] = "Кісткозлитий Короткий Меч"
    t[180827] = { name = "Малдраксійський Бойовий Ріг", fen = "A warhorn made of bone. Runes are inscribed along the stone fittings.", fua = "Бойовий ріг із кістки. Уздовж кам'яних оздоб викарбувані руни." }
    t[180830] = "Резонансний Сплав"
    t[180831] = { name = "Тонік Ківарра", fen = "A potent mixture of herbs native to Ardenweald combined with the dark power of Gorak Tul.", fua = "Потужна суміш трав, що ростуть в Арденвельді, поєднана з темною силою Горак Тула." }
    t[180832] = { name = "Звіт Лорда Герна", fen = "The envelope is addressed to the Winter Queen.", fua = "Конверт адресовано Зимовій Королеві." }
    t[180834] = { name = "Сторінки Щоденника Ренатала", fen = "Scattered after exile, returning them to his proctor Mistress Mihaela in Darkhaven will certainly curry favor with his court.", fua = "Розпорошені після вигнання. Повернення їх його наглядачці Володарці Міхаелі в Темногавань напевно здобуде прихильність його двору." }
    t[180837] = { name = "Синя Мерехтокрилка", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180838] = { name = "Синій Ефірний Вірм", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180839] = { name = "Помічна Мерехтокрилка", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180840] = { name = "Рожева Мерехтокрилка", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180841] = { name = "Оливкова Драконова Черепаха", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180842] = "Незламна Охоронниця"
    t[180844] = "Жорстока Життєва Сила"
    t[180845] = { name = "Креслення Плотошва", fen = "Sewing instructions for constructs made from Kyrian flesh.", fua = "Інструкції з шиття конструктів із кірійської плоті." }
    t[180846] = { name = "Голова Колосального Бенкетника", fen = "The visage is twisted and horrific in death.", fua = "У смерті обличчя спотворене й жахливе." }
    t[180847] = "Надихаюча Присутність"
    t[180848] = { name = "Голова Сталешкірого Лінолома", fen = "The head is rather more solid than might have been anticipated.", fua = "Голова виявилася значно міцнішою, ніж можна було очікувати." }
    t[180849] = { name = "Голова Душезгнилої Плоті", fen = "The stench radiating from this head is nauseating.", fua = "Сморід від цієї голови викликає нудоту." }
    t[180850] = { name = "Голова Хворобливого Кістковартового", fen = "The bones are cracked and smashed from combat.", fua = "Кістки потріскані й розтрощені в бою." }
    t[180851] = "Пилок Вихрепелюстки"
    t[180852] = { name = "Гранула Стигії", fen = "The byproduct of the violent sundering of a Soul and its anima within the Maw.", fua = "Побічний продукт жорстокого роз'єднання Душі та її аніми в Пащі." }
    t[180854] = "Медальйон Учасника Змагань"
    t[180855] = "Перстень-Печатка Учасника Змагань"
    t[180856] = { name = "Срібнопанцерна Черепаха", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180857] = { name = "Золотолапе Лисеня", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180858] = { name = "Кристалевий Молот Герольдів", fen = "A hammer forged of hardened anima crystal. Its use often heralded a host of silver wings.", fua = "Молот, викуваний із загартованого кристала аніми. Його застосування часто провіщало появу зграї срібних крил." }
    t[180859] = { name = "Білосніжка", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180860] = { name = "Помаранчевий Вульпін", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180861] = { name = "Червоний Вульпін", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180862] = "Кулеметальниця"
    t[180864] = "Графин Дистильованих Тіней"
    t[180865] = "Кийок Кам'яної Погибелі"
    t[180866] = { name = "Позолочений Бродяр", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180867] = { name = "Срібний Журавель", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180868] = "Серцеколій Страху"
    t[180869] = { name = "Пожертий Бродяр", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180870] = "Укус Тіні"
    t[180871] = { name = "Індиго", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180872] = { name = "Завзяте Небесне Лоша", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[180873] = "Тліюче Серце"
    t[180874] = "Свисток на Ґарґона"
    t[180875] = "Вантаж Карети"
    t[180876] = { name = "Акумулятор Водянистого Матеріалу", fen = "This untested equipment hums despite having no discernable power source. The large canister is intended for holding small slimes.", fua = "Цей невипробуваний пристрій гуде, хоча в ньому немає видимого джерела енергії. Великий резервуар призначений для тримання дрібних слизняків." }
    t[180878] = "Роз'їдений Флакон"
    t[180879] = "Шорсткий Кістяний Напилок"
    t[180880] = "Закривавлена Пам'ятка"
    t[180881] = "Пошарпана Зубочистка"
    t[180882] = "Арений Указ"
    t[180883] = "Осяйний Кристал"
    t[180884] = "Сувій Мерзенних Обрядів"
    t[180885] = "Потертий Оздоблений Рунами Мішечок"
    t[180886] = "Грубо Змелена Жила"
    t[180887] = "Законсервований Орган"
    t[180888] = "Нерозбірливий Журнал"
    t[180889] = "Викривлені Окуляри"
    t[180890] = "Закривавлений М'ясний Гак"
    t[180891] = "Розчавлена Личинка"
    t[180892] = "Кісткові Уламки зі Слідами Зубів"
    t[180893] = "Злиплі Спори"
    t[180894] = "Спорожніла Настоянка"
    t[180896] = "Запобіжник"
    t[180897] = "Світло Первородної"
    t[180898] = "Ефемерний Напій"
    t[180900] = "Чорний Як Ебен Головний Убір Жахливого Вартового"
    t[180901] = "Чорні Як Смола Шати Душолама"
    t[180902] = "Чорний Як Ебен Нагрудник Жахливого Вартового"
    t[180903] = "Чорнодеревна Кольчуга Жахолова"
    t[180904] = "Нагрудник Чорного Савану Смерті"
    t[180905] = "Чорні Як Ебен Великі Чоботи Жахливого Вартового"
    t[180906] = "Чорні Як Смола Капці Душолама"
    t[180907] = "Чорнодеревні Чоботи Жахолова"
    t[180908] = "Чоботи Чорного Савану Смерті"
    t[180909] = "Рукавички Чорного Савану Смерті"
    t[180910] = "Чорні Як Ебен Рукавиці Жахливого Вартового"
    t[180911] = "Чорні Як Смола Обмотки Душолама"
    t[180912] = "Чорнодеревні Латні Рукавиці Жахолова"
    t[180913] = "Чорний Як Смола Каптур Душолама"
    t[180914] = "Чорнодеревний Шолом Жахолова"
    t[180915] = "Каптур Чорного Савану Смерті"
    t[180916] = "Чорні Як Смола Поножі Грізного Вартового"
    t[180917] = "Чорні Поножі Душолома"
    t[180918] = "Чорні Поножі Жахоловця"
    t[180919] = "Штани Чорного Савану Смерті"
    t[180920] = "Наплічники Чорного Савану Смерті"
    t[180921] = "Чорні Як Ебен Наплічники Жахливого Вартового"
    t[180922] = "Чорний Як Смола Оплічник Душолама"
    t[180923] = "Чорнодеревні Наплічники Жахолова"
    t[180924] = "Чорний Як Ебен Пояс Жахливого Вартового"
    t[180925] = "Чорний Як Смола Пояс Душолама"
    t[180926] = "Чорнодеревний Пояс Жахолова"
    t[180927] = "Пояс Чорного Савану Смерті"
    t[180928] = "Чорні Як Смола Обмотки Душолама"
    t[180929] = "Чорні Як Ебен Наручі Жахливого Вартового"
    t[180930] = "Чорнодеревні Наручі Жахолова"
    t[180931] = "Наручі Чорного Савану Смерті"
    t[180932] = "Живлений Насильством"
    t[180933] = "Попелястий Джаґернаут"
    t[180934] = "Чорний Як Смола Плащ Душолама"
    t[180935] = "Зруйнувати Вали"
    t[180936] = "Плащ Чорного Савану Смерті"
    t[180937] = "Чорнодеревний Плащ Жахолова"
    t[180938] = "Чорний Як Ебен Плащ Жахливого Вартового"
    t[180939] = "Оплічник Темних Клинків Майстра Кузні"
    t[180940] = "Оплічник Чорного Хранителя Склепу"
    t[180941] = "Темний Ланцюг З Каменя Гріха Каеля"
    t[180943] = "Какофонічний Рев"
    t[180944] = "Безжальний Кісткодробар"
    t[180945] = { name = "Склеповий Гаргон", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180946] = "Благословенна Зброя"
    t[180947] = "Посудина Збирача Десятини"
    t[180948] = { name = "Бойовий Гаргон Вреднік", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[180949] = "Стабілізатор Потоку Аніми"
    t[180950] = { name = "The Maw - Pet Cosmetic - NYI", fen = "Very cute, but possibly lethal to all life on Azeroth.", fua = "Дуже миле, але, можливо, смертельне для всього живого на Азероті." }
    t[180951] = { name = "The Maw - POI Unlock - NYI", fen = "Unlocks access to a Point of Interest in The Maw", fua = "Відкриває доступ до визначного місця в Пащі." }
    t[180952] = { name = "Матриця Можливостей", fen = "The hand of fate can be guided, after all.", fua = "Зрештою, рукою долі таки можна керувати." }
    t[180953] = "Скіпетр Поєднання Душ"
    t[180954] = "Шпиль Вартового Склепу"
    t[180955] = "Алебарда Кам'яного Крила"
    t[180956] = "Мушкетон із Сокирним Лезом"
    t[180957] = "Глефа Кажанового Крила"
    t[180958] = "Рапіра Дому Ределев"
    t[180959] = "Литкокус Виволоки"
    t[180960] = "Дробар з Блискучим Металевим Навершям"
    t[180961] = "Ритуальний Кинджал зі Срібним Лезом"
    t[180962] = "Кийок зі Стерлінгового Срібла"
    t[180963] = "Посудина Хранителя Склепу"
    t[180964] = "Бар'єр Двору Жарин"
    t[180965] = { name = "Розписка Адонаса", fen = "Promises made by Sika's friends to take care of chores while she is away.", fua = "Обіцянки друзів Сіки виконувати її роботу, поки вона у від'їзді." }
    t[180966] = { name = "Розписка Леди", fen = "Promises made by Sika's friends to take care of chores while she is away.", fua = "Обіцянки друзів Сіки виконувати її роботу, поки вона у від'їзді." }
    t[180967] = { name = "Розписка Ікарана", fen = "Promises made by Sika's friends to take care of chores while she is away.", fua = "Обіцянки друзів Сіки виконувати її роботу, поки вона у від'їзді." }
    t[180968] = { name = "Розписка Софони", fen = "Promises made by Sika's friends to take care of chores while she is away.", fua = "Обіцянки друзів Сіки виконувати її роботу, поки вона у від'їзді." }
    t[180970] = { name = "Кристал Терегір", fen = "One of the curiosities that Acquirer Ta'gosh's in Oribos hoards, this amber colored crystal is thought to have unique powers of enchantment, yet no one in millennia has been able to tap it.", fua = "Одна з дивовиж, що їх збирає Здобувач Та'гош в Орибосі. Цей бурштиновий кристал начебто має унікальну силу чарування, та за тисячоліття ніхто так і не зумів його розкрити." }
    t[180971] = { name = "Аквамаринова Розписка Картелю", fen = "Often offered as a marker for favors, but some brokers like Ta'lan the Antiquary in Oribos are willing to offer them for rare items they covet.", fua = "Часто слугує знаком послуги, та деякі мітларі, як-от Та'лан Антиквар в Орибосі, готові віддавати їх за рідкісні речі, яких вони прагнуть." }
    t[180973] = { name = "Намисто з Іклів Жахокажана", fen = "An obscure piece, yet Ta'tru in Revendreth is always carrying one in his supply.", fua = "Незвичайна річ, проте Та'тру в Ревендреті завжди має таке у своїх запасах." }
    t[180974] = "Сумка Початківця"
    t[180975] = "Торба Підмайстра"
    t[180976] = "Сумка Ремісника"
    t[180977] = "Сумка Доглядача Духів"
    t[180979] = "Велика Сумка Ремісника"
    t[180980] = "Велика Торба Підмайстра"
    t[180981] = "Велика Сумка Початківця"
    t[180983] = "Напхана Сумка Ремісника"
    t[180984] = "Напхана Торба Підмайстра"
    t[180985] = "Напхана Сумка Початківця"
    t[180988] = "Переповнена Торба Підмайстра"
    t[180989] = "Переповнена Сумка Початківця"
    t[180990] = "Еонічна Ліра"
    t[180991] = "Чорнильниця з Карміновим Чорнилом"
    t[180992] = "Кривавочервоне Перо"
    t[181004] = "Багряний Головний Убір Жахливого Вартового"
    t[181005] = "Багряний Нагрудник Жахливого Вартового"
    t[181006] = "Багряні Великі Чоботи Жахливого Вартового"
    t[181007] = "Багряні Рукавиці Жахливого Вартового"
    t[181008] = "Багряні Поножі Грізного Вартового"
    t[181009] = "Багряні Наплічники Жахливого Вартового"
    t[181010] = "Багряний Пояс Жахливого Вартового"
    t[181011] = "Багряні Наручі Жахливого Вартового"
    t[181012] = "Багряний Плащ Жахливого Вартового"
    t[181013] = "Двірський Головний Убір Жахливого Вартового"
    t[181014] = "Двірський Нагрудник Жахливого Вартового"
    t[181015] = "Двірські Великі Чоботи Жахливого Вартового"
    t[181016] = "Двірські Рукавиці Жахливого Вартового"
    t[181017] = "Придворні Поножі Грізного Вартового"
    t[181018] = "Двірські Наплічники Жахливого Вартового"
    t[181019] = "Двірський Пояс Жахливого Вартового"
    t[181020] = "Двірські Наручі Жахливого Вартового"
    t[181021] = "Двірський Плащ Жахливого Вартового"
    t[181022] = "Воронований Головний Убір Жахливого Вартового"
    t[181023] = "Воронований Нагрудник Жахливого Вартового"
    t[181024] = "Вороновані Великі Чоботи Жахливого Вартового"
    t[181025] = "Вороновані Рукавиці Жахливого Вартового"
    t[181026] = "Поліровані Поножі Грізного Вартового"
    t[181027] = "Вороновані Наплічники Жахливого Вартового"
    t[181028] = "Воронований Пояс Жахливого Вартового"
    t[181029] = "Вороновані Наручі Жахливого Вартового"
    t[181030] = "Воронований Плащ Жахливого Вартового"
    t[181040] = "Багряний Жилет Смертного Савану"
    t[181041] = "Багряні Чоботи Смертного Савану"
    t[181042] = "Багряні Рукавички Смертного Савану"
    t[181043] = "Багряний Каптур Смертного Савану"
    t[181044] = "Багряні Штани Смертного Савану"
    t[181045] = "Багряні Наплічники Смертного Савану"
    t[181046] = "Багряний Пояс Смертного Савану"
    t[181047] = "Багряні Наручі Смертного Савану"
    t[181048] = "Багряна Накидка Смертного Савану"
    t[181049] = "Придворний Жилет Смертного Савану"
    t[181050] = "Придворні Чоботи Смертного Савану"
    t[181051] = "Придворні Рукавички Смертного Савану"
    t[181052] = "Придворний Каптур Смертного Савану"
    t[181053] = "Двірські Штани Савану Смерті"
    t[181054] = "Придворні Наплічники Смертного Савану"
    t[181055] = "Придворний Пояс Смертного Савану"
    t[181056] = "Придворні Наручі Смертного Савану"
    t[181057] = "Придворний Плащ Смертного Савану"
    t[181058] = "Полірований Жилет Смертного Савану"
    t[181059] = "Поліровані Чоботи Смертного Савану"
    t[181060] = "Поліровані Рукавички Смертного Савану"
    t[181061] = "Полірований Каптур Смертного Савану"
    t[181062] = "Поліровані Штани Савану Смерті"
    t[181063] = "Поліровані Наплічники Смертного Савану"
    t[181064] = "Полірований Пояс Смертного Савану"
    t[181065] = "Поліровані Зв'язки Смертного Савану"
    t[181066] = "Полірований Плащ Смертного Савану"
    t[181067] = "Багряна Кольчуга Жахолова"
    t[181068] = "Багряні Чоботи Жахолова"
    t[181069] = "Багряні Латні Рукавиці Жахолова"
    t[181070] = "Багряний Шолом Жахолова"
    t[181071] = "Багряні Поножі Жахоловця"
    t[181072] = "Багряні Наплічники Жахолова"
    t[181073] = "Багряний Пояс Жахолова"
    t[181074] = "Багряні Наручі Жахолова"
    t[181075] = "Багряний Плащ Жахолова"
    t[181076] = "Придворна Кольчуга Жахолова"
    t[181077] = "Придворні Чоботи Жахолова"
    t[181078] = "Придворні Латні Рукавиці Жахолова"
    t[181079] = "Придворний Шолом Жахолова"
    t[181080] = "Двірські Поножі Жахоловця"
    t[181081] = "Придворні Наплічники Жахолова"
    t[181082] = "Придворний Пояс Жахолова"
    t[181083] = "Придворні Наручі Жахолова"
    t[181084] = "Придворний Плащ Жахолова"
    t[181085] = "Полірована Кольчуга Жахолова"
    t[181086] = "Поліровані Чоботи Жахолова"
    t[181087] = "Поліровані Латні Рукавиці Жахолова"
    t[181088] = "Полірований Шолом Жахолова"
    t[181089] = "Поліровані Поножі Жахоловця"
    t[181090] = "Поліровані Наплічники Жахолова"
    t[181091] = "Полірований Пояс Жахолова"
    t[181092] = "Поліровані Наручі Жахолова"
    t[181093] = "Полірований Плащ Жахолова"
    t[181094] = "Багряні Шати Душолама"
    t[181095] = "Багряні Капці Душолама"
    t[181096] = "Багряні Обмотки Душолама"
    t[181097] = "Багряний Каптур Душолама"
    t[181098] = "Багряні Поножі Душолома"
    t[181099] = "Багряний Оплічник Душолама"
    t[181100] = "Багряний Пояс Душолама"
    t[181101] = "Багряні Обмотки Душолама"
    t[181102] = "Багряний Плащ Душолама"
    t[181112] = "Придворні Шати Душолама"
    t[181113] = "Придворні Капці Душолама"
    t[181114] = "Придворні Обмотки Душолама"
    t[181115] = "Придворний Каптур Душолама"
    t[181116] = "Придворні Поножі Душолома"
    t[181117] = "Придворний Оплічник Душолама"
    t[181118] = "Придворний Пояс Душолама"
    t[181119] = "Придворні Обмотки Душолама"
    t[181120] = "Двірський Плащ Душолама"
    t[181121] = "Поліровані Шати Душолама"
    t[181122] = "Поліровані Капці Душолама"
    t[181123] = "Поліровані Намотки Душолама"
    t[181124] = "Полірований Каптур Душолама"
    t[181125] = "Поліровані Поножі Душолома"
    t[181126] = "Полірований Оплічник Душолама"
    t[181127] = "Полірований Пояс Душолама"
    t[181128] = "Поліровані Намотки Душолама"
    t[181129] = "Полірований Плащ Душолама"
    t[181139] = "Креслення: Талісман Запалу"
    t[181140] = "Чар Запалу"
    t[181141] = "Чорний Душопроникач"
    t[181142] = "Темний Клинок Покаянного"
    t[181143] = "Кіготь Каменерожена Ката"
    t[181144] = "Молот Темного Віщування"
    t[181145] = "Талісман Завзяття"
    t[181146] = "Обпалений Шпиль Душі"
    t[181147] = "Креслення: Талісман Наполегливості"
    t[181148] = "Посох темних пристрастей"
    t[181149] = "Темне Лукавство Жахокажана"
    t[181150] = "Чорне Лезо Гріха"
    t[181151] = "Чорне Жало Душожера"
    t[181152] = "Чорне Лезо Жахокрила"
    t[181153] = "Чорний Самостріл Жахохребта"
    t[181154] = "Темний Бастіон Вартування Смерті"
    t[181155] = "Креслення: Талісман Розбрату"
    t[181156] = "Темний Осередок Гріхокрада"
    t[181157] = "Талісман Розбрату"
    t[181158] = "[UNUSED - FOCUS] Blueprint: Charm of Energizing"
    t[181159] = "Талісман Наснаги"
    t[181160] = { name = "Кісткова Бойова Сокира", fen = "The wickedly sharp blade glistens.", fua = "Лиховісно гостре лезо виблискує." }
    t[181161] = { name = "Кістковий Посох", fen = "Glows with inner light.", fua = "Світиться внутрішнім сяйвом." }
    t[181162] = "Активатор Маяка"
    t[181164] = { name = "Рука Оонара", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181165] = "Креслення: Набір Коваля Кіріан"
    t[181166] = "Сигіл Гнітючих Спогадів"
    t[181167] = "Покращення Послуги Розпорядника: Гармонійне Сходження"
    t[181168] = { name = "Гладкий Кісткоіклий", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181170] = { name = "Згубний Кісткоіклий", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181171] = { name = "Осяйна Павутинниця", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181172] = { name = "Кістоткане Пташеня", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181173] = { name = "Метушливий Отрутоплюй", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181175] = "Шати Збирача Гріхів"
    t[181176] = "Сандалі Збирача Гріхів"
    t[181177] = "Намотки Висмоктувача Душ"
    t[181178] = "Каптур Жаристої Люті"
    t[181179] = "Поножі Збирача Гріхів"
    t[181180] = "Пояс Збирача Гріхів"
    t[181181] = "Душевні Наручі"
    t[181182] = "Чоботи-Бродні для Багна"
    t[181183] = "Рукавиці Душолова"
    t[181184] = "Шолом Душолова"
    t[181185] = "Штани Душевистежувача"
    t[181186] = "Пояс Переслідувачки Вайт"
    t[181187] = "Наручі Душолова"
    t[181188] = "Кольчуга Темнокрилого Бунтаря"
    t[181189] = "Чоботи Темнокрилого Бунтаря"
    t[181190] = "Метальники Землекопів"
    t[181191] = "Койф Приборкувача Пожирачів"
    t[181192] = "Поножі Листоноші"
    t[181193] = "Наплічники Темнокрилого Бунтаря"
    t[181194] = "Пояс Темнокрилого Бунтаря"
    t[181195] = "Наручі Темнокрилого Бунтаря"
    t[181196] = "Каменетворний Шолом"
    t[181197] = "Каменетворний Нагрудник"
    t[181198] = "Просякнуті Каменем Чоботи"
    t[181199] = "Каменетворні Латні Рукавиці"
    t[181200] = "Камінно Викувані Поножі"
    t[181201] = "Оплічник Кам'яного Крила"
    t[181202] = "Жаропошрамований Пояс"
    t[181203] = "Кам'яноковані Наручні Пластини"
    t[181204] = "Шкура Кренґаата"
    t[181205] = "Еполети Душолова"
    t[181206] = "Наплічники Збирача Гріхів"
    t[181207] = "Бар'єр Фортеці Панування"
    t[181208] = "Просочений Анімою Бруд"
    t[181209] = "Укус Пожирача"
    t[181210] = "Громострел Жахокряжу"
    t[181211] = "Кріс Душепивця"
    t[181212] = "Булава душезаклинача"
    t[181213] = "Ніж, Укритий Скалками"
    t[181214] = "Жало Збирача Податків"
    t[181215] = "Клинок Темнокрилого Вбивці"
    t[181216] = "Велика Булава Попелястого Муру"
    t[181217] = "Перстень Вартового Панування"
    t[181218] = "Перстень-Печатка Вельможі Чаші"
    t[181219] = "Кийок Бунтівника Кам'яне Крило"
    t[181220] = "Кийок Збирача Поторочей"
    t[181221] = "Збалансований Посох Темнокрила"
    t[181222] = "Алебарда Темнокрилого Бунтаря"
    t[181223] = "Булава Попелястого Гніву"
    t[181224] = "Посох Присяжного Арканіста"
    t[181225] = "Арбалет Споглядального Спокою"
    t[181226] = "Бронзова Дволеза Глефа"
    t[181227] = "Бронзовий Церемоніальний Щит"
    t[181228] = "Партизана Храмового Вартового"
    t[181229] = "Кадило Умиротвореного"
    t[181230] = "Чакрам Кулачного Бійця"
    t[181231] = "Широколезий Розтинач"
    t[181232] = "Клеймор Чашника"
    t[181233] = "Молот Дзвонаря"
    t[181234] = "Зобов'язаний Чароклинок"
    t[181235] = "Молот Останнього Судді"
    t[181237] = { name = "Отруйний Розчинник", fen = "Spider venom capable of dissolving coagulated slime.", fua = "Павучача отрута, здатна розчиняти загусле слиз." }
    t[181238] = "Креслення: Талісман Зосередження"
    t[181239] = "Талісман Зосередження"
    t[181240] = "Талісман Підсилення 7"
    t[181244] = "Лезо Бунтівного Темнокрила"
    t[181246] = "Зів'яле Листя"
    t[181247] = { name = "Гостра Палиця", fen = "Could be used for eye poking.", fua = "Нею можна виколоти око." }
    t[181248] = { name = "Прадавній Камінь Гріхів", fen = "Prince Renathal will be interested in this relic of Revendreth's past. (|CFFfb95ff+Formal|R)", fua = "Принц Ренатал зацікавиться цією реліквією з минувшини Ревендрета. (|CFFfb95ff+Формальність|R)" }
    t[181250] = { name = "Феромонна Залоза Горма", fen = "Emanates a surprisingly pleasant, delicate odor.", fua = "Випромінює напрочуд приємний, ніжний запах." }
    t[181251] = { name = "Квітучий Шпичак Батожника", fen = "Tiny flowers speckle the razor sharp spur.", fua = "Крихітні квіти всіяли гострий, як бритва, шпичак." }
    t[181252] = { name = "Листя Срібносердої Лози", fen = "Thick, waxy multicolored leaves on a sturdy vine.", fua = "Товсте, воскувате різнобарвне листя на міцній лозі." }
    t[181259] = { name = "Чіпляка", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181262] = { name = "Булькотлива Пустула", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181263] = { name = "Сором'язливий Мелвін", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181264] = { name = "Личинка Чумної Воші", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181265] = { name = "Личинка Трупної Воші", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181266] = { name = "Ненажерлива Личинка", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181267] = { name = "Звивистий Хребет", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181268] = { name = "Хребет", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181269] = { name = "Містичний Каптур Мікроманта", fen = "Teaches you how to summon Micromancer.", fua = "Навчає, як прикликати Мікроманта." }
    t[181270] = { name = "Безхребетна Олія", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181271] = { name = "Багновий Вусик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181272] = { name = "Кіготь", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181273] = { name = "Олія Помазання", fen = "Allows the capture of Echthra's memory.", fua = "Дозволяє вловити спогад Ехтри." }
    t[181274] = { name = "Серцебійний Дротик", fen = "Allows the capture of Alderyn and Myn'ir's memory.", fua = "Дозволяє вловити спогад Алдерина та Мин'іра." }
    t[181275] = { name = "Джерело Омолодження", fen = "Allows the capture of Nuuminuuru's memory.", fua = "Дозволяє вловити спогад Нууміннууру." }
    t[181276] = { name = "Каталізатор Творіння", fen = "Allows the capture of Mad Mortimer's memory.", fua = "Дозволяє вловити спогад Несамовитого Мортимера." }
    t[181277] = { name = "Резонансний Маяк Претора", fen = "Allows the capture of Splinterbark Nightmare.", fua = "Дозволяє вловити Жахіття Тріснутої Кори." }
    t[181278] = { name = "Кристал Шукача Душ", fen = "Allows the capture of Thran'tiok's memory.", fua = "Дозволяє вловити спогад Тран'тіока." }
    t[181279] = { name = "Ключ Попелопаду", fen = "Allows the capture of Craven Corinth's memory.", fua = "Дає змогу захопити спогад Корінта Боягуза." }
    t[181280] = { name = "Сторож Смирення", fen = "Allows the capture of Athanos's memory.", fua = "Дозволяє вловити спогад Атаноса." }
    t[181281] = "Принада для Боса 10"
    t[181282] = { name = "Му'дуд", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181283] = { name = "Смердокрилий Гудець", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[181284] = "Ґормлінг у Торбі"
    t[181285] = "Огидне Креслення"
    t[181286] = "Німб Самовідданості"
    t[181287] = "Німб Шаноби"
    t[181288] = "Німб Гармонії"
    t[181289] = "Німб Розбрату"
    t[181290] = "Гармонійний Сигіл Архонта"
    t[181291] = "Безкорисливий Сигіл Архонта"
    t[181292] = "Дисгармонійний Сигіл Архонта"
    t[181293] = "Шанобливий Сигіл Архонта"
    t[181294] = "Гармонійні Крила Піднесених"
    t[181295] = "Самовіддані Крила Піднесених"
    t[181296] = "Дисгармонійні Крила Піднесених"
    t[181297] = "Шанобливі Крила Піднесених"
    t[181298] = "Набір Виживання Згубнолісся"
    t[181299] = "Зношена Торба"
    t[181300] = { name = "Моторошний Обдертокрил", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[181301] = "Сплетені Феями Гілки"
    t[181302] = "Гілки Доглядача Духів"
    t[181303] = "Гілки Нічного Придворного"
    t[181304] = "Зимовиплетені Гілки"
    t[181305] = "Сплетена Феями Цибулина"
    t[181306] = "Цибулина Доглядача Духів"
    t[181307] = "Цибулина Нічного Придворного"
    t[181308] = "Зимовиплетена Цибулина"
    t[181309] = "Сплетений Феями Клунок"
    t[181310] = "Клунок Доглядача Духів"
    t[181311] = "Торба Нічного Придворного"
    t[181312] = "Зимовиплетений Клунок"
    t[181313] = "Душа Снепера"
    t[181314] = "Душа Глитая"
    t[181316] = { name = "Сріблокрилий Жахокрил", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[181317] = { name = "Безстрашний Сутінковий Бігун", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[181318] = "Зачарований Дзеркальний Пил"
    t[181320] = "Баліста Кістяної Пащі"
    t[181321] = "Самоцвітно-вінчана Чарівна Паличка"
    t[181322] = "Кісткозшитий Фоліант"
    t[181323] = "Зчеплений Пошестю Великий Посох"
    t[181325] = "Кистково-Зрощений Кинджал"
    t[181326] = "Закривавлена Ножівка по Металу"
    t[181327] = "Хребтокований Відбивач"
    t[181328] = "Кистково-Зрощений Меч"
    t[181329] = "Клеймор, Сплавлений з Мозком"
    t[181330] = "Кистково-Зрощена Бойова Глефа"
    t[181331] = "Кісткосплавлений Щит"
    t[181333] = "Медальйон Грішного Гладіатора"
    t[181334] = "Видобувач Сутності"
    t[181335] = "Невблаганна Брошка Грішного Гладіатора"
    t[181336] = { name = "Балакуча Жаба в Банці", fen = "The frog keeps asking uncomfortable questions.", fua = "Жаба невпинно ставить незручні питання." }
    t[181337] = "Крила Кам'яного Чудовиська"
    t[181350] = { name = "Роба Поплічника", fen = "For best results, maintain composure.", fua = "Для найкращих наслідків зберігайте незворушність." }
    t[181351] = "Подерта Тканина"
    t[181352] = "Подерта Шкіра"
    t[181354] = { name = "Регенеративна Магма", fen = "The magma never seems to cool enough to harden.", fua = "Магма, здається, ніколи не холоне настільки, щоб затвердіти." }
    t[181355] = { name = "Несправні Феєрверки", fen = "Prince Renathal might be interested in these \"premier\" party favors. (|cffdb453d+Safe|r)", fua = "Принц Ренатал, можливо, зацікавиться цими «найкращими» святковими гостинцями. (|cffdb453d+Безпека|r)" }
    t[181356] = { name = "Оригінал Глензу", fen = "The colors give the work contrast, depth, hue, value, and tone.", fua = "Кольори надають твору контрасту, глибини, відтінку, насиченості й тону." }
    t[181357] = { name = "Табличка Відчаю", fen = "Sometimes a tool in the wrong hands is a weapon.", fua = "Іноді знаряддя в чужих руках стає зброєю." }
    t[181358] = "Розписка Майстра Дуелей"
    t[181359] = "Переповнене Жарне Дзеркало"
    t[181360] = "Переповнена Жарінь-Скалка"
    t[181361] = { name = "Придворні Плітки", fen = "Prince Renathal would like to contain such idle gossip. (|cfffbdd52+Relaxing|r)", fua = "Принц Ренатал хотів би стримати такі марні плітки. (|cfffbdd52+Спокій|r)" }
    t[181362] = { name = "Грудка Слизу", fen = "Prince Renathal might like to contain this mess. (|cff34cceb+Clean|r)", fua = "Принц Ренатал, мабуть, захоче прибрати цей безлад. (|cff34cceb+Чистота|r)" }
    t[181363] = { name = "Саморобний Набір для Ремонту Дзеркал", fen = "Used in the repair of the most intricate translocation mirrors in Revendreth.", fua = "Використовується для ремонту найскладніших дзеркал переміщення в Ревендреті." }
    t[181364] = { name = "Жмут Насіння", fen = "Prince Renathal might have a use for seeds such as these. (|cff1b8729+Humble|r)", fua = "Принц Ренатал, можливо, знайде застосування такому насінню. (|cff1b8729+Скромність|r)" }
    t[181365] = { name = "Статуя з Ан'Кіражу", fen = "Finely detailed obsidian carving in the Ahn'Qiraj style.", fua = "Тонко оздоблена обсидіанова різьба в стилі Ан'Кіражу." }
    t[181366] = { name = "Некростатичний Заряд", fen = "Consumed immediately upon acquisition.", fua = "Споживається одразу після отримання." }
    t[181367] = { name = "Список Поповнення Картелю Та", fen = "A list of objects Keeper Ta'saran has requested you find on Azeroth.", fua = "Перелік речей, які Хранитель Та'саран попросив вас знайти на Азероті." }
    t[181368] = "Енергетичне Осердя Центуріона"
    t[181369] = { name = "Велетенський Легеневий Гриб", fen = "A foul-tasting mushroom, found natively only in Maldraxxus. Picky Stefan will be interested in this. (|CFF1b8729+Humble|R)", fua = "Огидний на смак гриб, що в природі росте лише в Малдраксусі. Привередливий Стефан зацікавиться цим. (|CFF1b8729+Скромність|R)" }
    t[181370] = { name = "Чистісінька Вода", fen = "There is no question this sweet-smelling water comes from Ardenweald.", fua = "Немає сумніву, що ця солодко пахуча вода походить з Арденвельду." }
    t[181371] = { name = "Запасна Голова", fen = "An extra one that no one needed.", fua = "Зайва, яка нікому не була потрібна." }
    t[181372] = { name = "Данина Вознесених", fen = "Valuable items from the forges and archives of the Ascended are contained within.", fua = "Усередині — цінні предмети з кузень та архівів Вознесених." }
    t[181373] = "Відвернення Шкоди"
    t[181375] = "Зілля Зимового Спокою"
    t[181376] = "Внутрішня Лють"
    t[181377] = "Ілюстрований Посібник з Бойової Медитації"
    t[181378] = { name = "Кайдани Пихи", fen = "There is no greater burden than pride.", fua = "Немає тягаря важчого за пиху." }
    t[181379] = { name = "Перо з Пір'я Ларіона", fen = "The result of steward ingenuity, this writing tool draws upon the anima of the scribe to commit the written word.", fua = "Витвір кмітливості розпорядників, це писальне знаряддя черпає аніму писаря, аби закарбувати написане слово." }
    t[181380] = { name = "Інструменти Підручного Коваля", fen = "Humble in appearance, these devices are perfectly balanced and impossibly sharp.", fua = "Скромні на вигляд, ці знаряддя ідеально збалансовані й неймовірно гострі." }
    t[181381] = "Арденовий Яблучний Пиріг"
    t[181382] = { name = "Передзвін Вічності", fen = "A gentle tap produces a pitch-perfect resonance that seems to last forever.", fua = "Легкий дотик породжує бездоганно чистий відголос, що, здається, лунає вічно." }
    t[181383] = "Невблаганний Холод"
    t[181384] = { name = "Безмежний Кошик", fen = "Capable of holding much more than it should.", fua = "Здатний вмістити набагато більше, ніж мав би." }
    t[181385] = "Комахобій"
    t[181387] = "Крапчастий Вогнехвіст"
    t[181388] = "Буйний Марроурут"
    t[181389] = "Тремтливе Ядро"
    t[181393] = "Лісовий Білий Щит"
    t[181394] = { name = "Порожня Пляшка з-під Чуми", fen = "One of the House of Plagues' chemists must have left this lying around. Someone could potentially fill it with anything. How unsafe!", fua = "Хтось із хіміків Дому Чум, певно, залишив це валятися. Хтось міг би налити сюди будь-що. Як небезпечно!" }
    t[181395] = "Молот Пилолама"
    t[181396] = "Коса Колючого Жнивника"
    t[181397] = "Гімнарій Перепочинку"
    t[181398] = "Живицевосталевий Бойовий Шолом"
    t[181399] = "Феїсто-Мохові Шати"
    t[181400] = "Живицевосталевий Нагрудник"
    t[181401] = "Нагрудник із Панцира Ґорма"
    t[181402] = "Туніка Доглядача Рун"
    t[181403] = "Живицевосталеві Латні Чоботи"
    t[181404] = "Феїсто-Мохові Чоботи"
    t[181405] = "Чоботи з Панцира Ґорма"
    t[181406] = "Чоботи Доглядача Рун"
    t[181407] = "Рукавиці Доглядача Рун"
    t[181408] = "Живицевосталеві Латні Рукавиці"
    t[181409] = "Рукавички з Феїного Моху"
    t[181410] = "Рукавиці з Панцира Ґорма"
    t[181411] = "Вінець із Феїного Моху"
    t[181412] = "Каптур із Панцира Ґорма"
    t[181413] = "Шолом Доглядача Рун"
    t[181414] = "Латні Поножі зі Смолосталі"
    t[181415] = "Поножі з Феїного Моху"
    t[181416] = "Кілт з Луски Ґорма"
    t[181417] = "Штани Доглядача Рун"
    t[181418] = "Наплічники Доглядача Рун"
    t[181419] = "Живицевосталеві Наплічники"
    t[181420] = "Оплічник із Феїного Моху"
    t[181421] = "Оплічник із Панцира Ґорма"
    t[181422] = "Живицевосталева Застібка"
    t[181423] = "Феїсто-Моховий Пояс"
    t[181424] = "Пояс із Панцира Ґорма"
    t[181425] = "Пояс Доглядача Рун"
    t[181426] = "Наручі з Феїного Моху"
    t[181427] = "Живицевосталеві Наручі"
    t[181428] = "Наручі з Панцира Ґорма"
    t[181429] = "Наручі Доглядача Рун"
    t[181430] = "Вічноночна Накидка"
    t[181431] = "Браслет, Оздоблений Самоцвітами"
    t[181432] = "Чарошпичак Сутінкового Вартового"
    t[181433] = "Молоток Сутінкового Вартового"
    t[181434] = "Шкіряний Сагайдак Переслідувача"
    t[181435] = "Розраховані Удари"
    t[181436] = "Дзеркальце для Чепуріння"
    t[181437] = { name = "Тренувальні Опудала", fen = "A few plague stains are present, but all in all they are in good working order.", fua = "На них є кілька плям чуми, та загалом вони в робочому стані." }
    t[181438] = { name = "Дикий Барабан", fen = "Matching the timber of a great beast from her lost homeworld this drum will quicken the greatest of warriors.", fua = "Звуком схожий на ревіння великого звіра з її втраченого рідного світу, цей барабан надихне найвеличніших воїнів." }
    t[181439] = "Захисні Жаровні"
    t[181440] = "Слизька Багнюка"
    t[181441] = "Вівтар Звершень"
    t[181442] = "Видіння Сіра Денатрія"
    t[181443] = { name = "Святковий Капелюх Святкового Герольда", fen = "Even expert Party Heralds like Temel need to earn the right to wear this ultimate party hat!", fua = "Навіть досвідчені Святкові Герольди, як-от Темель, мусять заслужити право носити цей найкращий святковий капелюх!" }
    t[181444] = "Бонус 24"
    t[181445] = "Бонус 25"
    t[181446] = "Бонус 26"
    t[181447] = "Бонус 27"
    t[181448] = "Бонус 28"
    t[181449] = "Бонус 29"
    t[181450] = "Сяйлива Руда Соленію"
    t[181451] = "Бонус 30"
    t[181452] = "Товста Шкіра Горма"
    t[181453] = "Плащ Маскування"
    t[181454] = "Виверт Сутінкового Багна"
    t[181455] = "Крижана Тяга"
    t[181456] = { name = "Ключ Фалдо", fen = "Key to the Faldo's Keepsakes chest.", fua = "Ключ до скрині Пам'ятні Речі Фалдо." }
    t[181457] = "Листя Пробуджувача"
    t[181458] = "Чування Королівської Варти"
    t[181459] = "Уламкошок Зів'ялого Гаю"
    t[181460] = "Дзеркало Душ"
    t[181461] = "Крижаний Укус"
    t[181462] = "Узгоджений Наступ"
    t[181463] = { name = "Алхімічна Скриня Анонімного Покупця", fen = "Contains the instructions and materials provided by the buyer.", fua = "Містить настанови й матеріали, надані покупцем." }
    t[181464] = "Захист Зими"
    t[181465] = "Узи Сюеня"
    t[181466] = "Заземлювальний Подих"
    t[181467] = "Плин Часу"
    t[181468] = { name = "Прихована Руна Підсилення", fen = "Can be bought and sold on the auction house.", fua = "Можна купити та продати на аукціоні." }
    t[181469] = "Незабутня Перемога"
    t[181470] = "Каталізатор Творіння"
    t[181471] = "Сторож Смирення"
    t[181472] = "Дзеркало Душ"
    t[181473] = { name = "Шматок Свічкового Воску", fen = "A glob of wax that is ready to be recycled and melted again.", fua = "Грудка воску, готова до переплавлення й повторного використання." }
    t[181475] = { name = "Щедрість Вартових Гаю", fen = "Valuable items collected from the Queen's many groves.", fua = "Цінні предмети, зібрані з численних гаїв Королеви." }
    t[181476] = { name = "Данина Дикого Полювання", fen = "Valuable items collected from the Queen's many groves.", fua = "Цінні предмети, зібрані з численних гаїв Королеви." }
    t[181477] = "Перлина Арденової Роси"
    t[181478] = "Ріг Достатку Зимового Двору"
    t[181479] = "Ловець Зоряного Світла"
    t[181483] = { name = "Котушка Нитки Шовкоступа", fen = "The gossamer appearance of silkstrider thread belies its great tensile strength which enables it to be utilized as a bowstring for both war and merriment.", fua = "Тонкий, мов павутина, вигляд нитки шовкоступа оманливий: її велика міцність дозволяє використовувати її як тятиву і для війни, і для розваг." }
    t[181484] = { name = "Живець Співучого Дерева", fen = "Wood coaxed from mature trees is grafted onto saplings to improve their vitality and ensure bountiful anima harvests.", fua = "Деревину, видобуту зі зрілих дерев, прищеплюють до саджанців, аби зміцнити їхню життєву силу й забезпечити щедрі врожаї аніми." }
    t[181485] = { name = "Оздоблений Самоцвітами Бурштиновий Лист", fen = "Rather than metalwork, the night fae fashion amber into both useful tools and decorative objects.", fua = "Замість металу нічні феї виготовляють із бурштину як корисні знаряддя, так і оздоби." }
    t[181486] = { name = "Кожух з Листолуски", fen = "The leaves growing atop the runestags of Ardenweald are utilized by the night fae in lieu of their fur, so the animal can remain unharmed.", fua = "Замість хутра рунних оленів Арденвельду нічні феї використовують листя, що росте на них, аби не завдати тварині шкоди." }
    t[181487] = { name = "Низка Намистин зі Світлоягід", fen = "Glowberries can shimmer for decades when properly pulped and dried.", fua = "Світлоягоди можуть мерехтіти десятиліттями, якщо їх належно розтовкти й висушити." }
    t[181488] = { name = "Кіготь Тінекрада", fen = "When a shadowstalker population grows too quickly, a hunt is called to cull their numbers.", fua = "Коли популяція тінекрадів росте надто швидко, оголошують полювання, щоб зменшити їхнє число." }
    t[181489] = { name = "Сонети Зоряного Озера", fen = "The performative revelry displayed at the Star Lake Ampitheater provides reprieve from the constant vigil required to nurture wildseeds.", fua = "Барвисті вистави в Амфітеатрі Зоряного Озера дарують перепочинок від невпинної варти, потрібної для плекання диких насінин." }
    t[181490] = { name = "Руна Дикого Бога", fen = "Spirit Tenders who hold vigil over the rebirth of Wild Gods often fill quiet hours carving their gods' likenesses as keepsakes.", fua = "Доглядачі духів, що несуть варту над відродженням Диких Богів, нерідко в тихі години вирізьблюють подоби своїх богів на згадку." }
    t[181491] = { name = "Лампа на Гормовому Жирі", fen = "Gormgris's natural luminosity provides an excellent light source for visitors unaccustomed to Ardenweald's perpetual twilight.", fua = "Природне сяйво гормового жиру — чудове джерело світла для гостей, не звиклих до вічних сутінків Арденвельду." }
    t[181492] = { name = "Скам'яніла Фейська Квітка", fen = "Petrified flowers are a gift given between friends and lovers, their never-wilting state symbolizing an eternal relationship.", fua = "Скам'янілі квіти дарують одне одному друзі й закохані: їхній невідцвітний стан символізує вічні стосунки." }
    t[181495] = "Нефритовий Зв'язок"
    t[181496] = { name = "Квітка Гиблого Багна", fen = "Its petals emit a soft glow and pungent smell.", fua = "Її пелюстки м'яко світяться й видають різкий запах." }
    t[181498] = "Заземлювальний Сплеск"
    t[181499] = "Тризуб Глибинного Відлуння"
    t[181500] = { name = "Глефа Каменероджених", fen = "The weapon's blades are chipped and scratched.", fua = "Леза цієї зброї пощерблені й подряпані." }
    t[181501] = "Полум'я Битви"
    t[181502] = "Сироватка Оновлення"
    t[181503] = "Флакон Їдкої Рідини"
    t[181504] = "Пекельний Каскад"
    t[181505] = "Осяйний Туман"
    t[181506] = "Первинне Полум'я"
    t[181507] = "Пульсуюче Ядро Потвори"
    t[181508] = "Зміцнювальні Інгредієнти"
    t[181509] = "Магічний Вундеркінд"
    t[181510] = "Тривке Заніміння"
    t[181511] = "Незримна Точність"
    t[181512] = "Запаморочливе Падіння"
    t[181515] = { name = "Жалюгідна Купа Таємниць", fen = "The hidden pieces that comprise a soul.", fua = "Приховані частки, з яких складається душа." }
    t[181517] = "Будівля: Ставок Землекопів"
    t[181518] = "Будівля: Вартівня"
    t[181519] = "Персонал: Декоратори-Землекопи"
    t[181520] = "Персонал: Сценічна Бригада"
    t[181521] = "Персонал: Посол"
    t[181522] = "Персонал: Офіціанти"
    t[181523] = "Персонал: Вибивайли"
    t[181524] = "Персонал: Посол"
    t[181529] = "Клинок Безжального Суперника"
    t[181530] = "Запас: Вітальні Набори"
    t[181531] = "Чароклинок Безжального Суперника"
    t[181532] = "Запас: Закуски"
    t[181533] = "Запас: Зразки Аніми"
    t[181534] = "Жезл Безжального Суперника"
    t[181535] = "Запас: Зручні Крісла"
    t[181536] = "Сторінка Списку Гостей"
    t[181537] = "Сторінка Списку Гостей"
    t[181538] = "Сторінка Списку Гостей"
    t[181539] = "Дисципліна Гаю"
    t[181540] = "Пуп'янок Анімоквіту"
    t[181541] = "Небесний Жолудь"
    t[181544] = "Сповіді про Лиходійство"
    t[181545] = "Кровозв'язана Кулька"
    t[181546] = "Зріла Склепоцвітка"
    t[181547] = "Напій Дворянина"
    t[181548] = "Ліхтар Душ Даркгейвена"
    t[181549] = "Зужитий Часом Камінь Гріхів"
    t[181550] = "Польовий Ін'єктор Згубника Надії"
    t[181551] = "Виснажене Серце Камінародженого"
    t[181552] = "Зібрана Десятина"
    t[181553] = "Дарунок Ліча"
    t[181556] = { name = "Данина Двору", fen = "Contains valuable items released from the vaults of the Court of Harvesters.", fua = "Містить цінні предмети, видані зі сховищ Двору Жнеців." }
    t[181557] = { name = "Прихильність Двору", fen = "Contains valuable items released from the vaults of the Court of Harvesters.", fua = "Містить цінні предмети, видані зі сховищ Двору Жнеців." }
    t[181558] = { name = "Зниклі Ритуальні Сторінки", fen = "These pages look ripped out of a necromancer's spellbook from the House of Rituals.", fua = "Ці сторінки наче вирвані зі збірника заклять некроманта з Дому Ритуалів." }
    t[181563] = "Указ: Ласка Міканікоса"
    t[181564] = "Указ: Пошана Міканікоса"
    t[181565] = "Указ: Прихильність Міканікоса"
    t[181566] = "Указ: Ласка Графині"
    t[181567] = "Указ: Пошана Графині"
    t[181568] = "Указ: Прихильність Графині"
    t[181569] = "Роба Цілителя Духу"
    t[181570] = "Капці Цілителя Духу"
    t[181571] = "Рукавички Цілителя Духу"
    t[181572] = "Каптур Цілителя Духу"
    t[181573] = "Поножі Цілителя Душ"
    t[181574] = "Оплічник Цілителя Духу"
    t[181575] = "Пояс Цілителя Духу"
    t[181576] = "Наручі Цілителя Духу"
    t[181577] = "Жилет Душоносця"
    t[181578] = "Чоботи Душоносця"
    t[181580] = "Рукавички Душоносця"
    t[181581] = "Шолом Душоносця"
    t[181583] = "Штани Носія Душ"
    t[181585] = "Наплічники Душоносця"
    t[181587] = "Пояс Душоносця"
    t[181589] = "Наручі Душоносця"
    t[181591] = "Кольчуга Підручного Коваля"
    t[181594] = "Чоботи Підручного Коваля"
    t[181596] = "Рукавиці Підручного Коваля"
    t[181598] = "Указ: Прихильність Леді Мунберрі"
    t[181599] = "Наголів'я Підручного Коваля"
    t[181600] = "Гнів Піднесених"
    t[181601] = "Поножі Підручного Коваля"
    t[181602] = "Наплічники Підручного Коваля"
    t[181603] = "Ланцюг Підручного Коваля"
    t[181604] = "Наручі Підручного Коваля"
    t[181605] = "Нагрудник Щитоварти"
    t[181606] = "Бойові Чоботи Щитоварти"
    t[181607] = "Указ: Пошана Леді Мунберрі"
    t[181608] = "Латні Рукавиці Щитоварти"
    t[181609] = "Великий Шолом Щитоварти"
    t[181610] = "Поножі Щитоносця"
    t[181611] = "Латні Наплічники Щитоварти"
    t[181612] = "Пояс Щитоварти"
    t[181613] = "Указ: Ласка Леді Мунберрі"
    t[181614] = "Наручі Щитоварти"
    t[181615] = { name = "Як Вести Армію", fen = "An introduction to battle tactics.", fua = "Вступ до бойової тактики." }
    t[181616] = { name = "Трактат про Великі Битви Лордерона", fen = "Detailing the tactics and battlefield mastery of Mograine himself.", fua = "Докладно про тактику та воєнну майстерність самого Мограйна." }
    t[181617] = { name = "Командування на Полі Бою", fen = "One must know the land as much as the enemy.", fua = "Слід знати місцевість так само добре, як і ворога." }
    t[181618] = "Таріль Кіша з Ґормами"
    t[181619] = "Варені Яйця Ґорма"
    t[181620] = "Зварене Круто Яйце Ґорма"
    t[181621] = "Зразок Гіперреактивної Слизі"
    t[181622] = "Трохи Опромінений Зразок Слизу"
    t[181623] = "Зразок Флуоресцентного Слизу"
    t[181624] = "Швидке Перенесення"
    t[181625] = "Крововиплавлений Медальйон"
    t[181626] = "Крововиплавлений Перстень"
    t[181627] = "Арбалет Життєвого Шляху"
    t[181628] = "Глефа Спогадів"
    t[181629] = "Захисник Дороговказу"
    t[181630] = "Спис Кування Слави"
    t[181631] = "Передзвін Реквієму"
    t[181632] = "Ручні Коси Реквієму"
    t[181633] = "Клинок Дороговказного Світла"
    t[181634] = "Дворучний Меч Пам'яті"
    t[181635] = "Молоток Данини Честі"
    t[181636] = "Чароклинок Спогадів"
    t[181637] = "Молот Життєвого Шляху"
    t[181638] = "Крововиплавлена Накидка"
    t[181639] = "Висмоктана Злоба"
    t[181640] = "Техніка Перекату"
    t[181641] = "Відродження Вранішнього Сонця"
    t[181642] = "Засади Чумознавства для Початківців"
    t[181643] = "Плакучий Трупогриб"
    t[181644] = "Непідписані Банки з Культурою"
    t[181645] = "Набрякле Серце Потвори"
    t[181646] = "Прив'язаний Запобіжний Філактерій"
    t[181647] = "Стабілізований Штам Чуми"
    t[181648] = "Фокусувальний Кристал Зикурата"
    t[181649] = "Законсервована Надприродна Черепна Коробка"
    t[181650] = "Захищена Чарами Дисертація"
    t[181651] = "Сталеосердий Шолом"
    t[181652] = "Роба Кривавого Шовку"
    t[181653] = "Сталосердий Нагрудник"
    t[181654] = "Плотолуската Кольчуга"
    t[181655] = "Трупошкіряний Нагрудник"
    t[181656] = "Сталеосерді Бойові Чоботи"
    t[181657] = "Чоботи Кривавого Шовку"
    t[181658] = "Плотолускаті Чоботи"
    t[181659] = "Трупошкіряні Чоботи"
    t[181660] = "Трупошкіряні Рукавички"
    t[181661] = "Сталосерді Латні Рукавиці"
    t[181662] = "Рукавички Кривавого Шовку"
    t[181663] = "Плотолускаті Латні Рукавиці"
    t[181664] = "Каптур Кривавого Шовку"
    t[181665] = "Плотолускатий Каптур"
    t[181666] = "Трупошкіряний Шолом"
    t[181667] = "Поножі Сталевого Осердя"
    t[181668] = "Поножі з Кривавого Шовку"
    t[181669] = "Поножі з Плотолуски"
    t[181670] = "Штани з Трупної Шкіри"
    t[181671] = "Трупошкіряні Наплічники"
    t[181672] = "Сталеосерді Наплічники"
    t[181673] = "Оплічник Кривавого Шовку"
    t[181674] = "Плотолускатий Оплічник"
    t[181675] = "Сталеосердий Пояс"
    t[181676] = "Шнур Кривавого Шовку"
    t[181677] = "Плотолускатий Пояс"
    t[181678] = "Трупошкіряний Пояс"
    t[181679] = "Напульсники Кривавого Шовку"
    t[181680] = "Сталеосерді Наручі"
    t[181681] = "Плотолускаті Наручі"
    t[181682] = "Трупошкіряні Наручі"
    t[181683] = "Освячений Талісман"
    t[181684] = "Кровокута Чарівна Паличка"
    t[181685] = "Крововиплавлений Бар'єр"
    t[181686] = "Крововиплавлений Фоліант"
    t[181687] = "Кровокована Бойова Глефа"
    t[181688] = "Кровокутий Посох"
    t[181689] = "Кровокована Кісткова Пилка"
    t[181690] = "Кровокований Трощитель"
    t[181691] = "Кровокутий Великий Посох"
    t[181692] = "Кровокована Бойова Клинка"
    t[181693] = "Кровокутий Арбалет"
    t[181694] = "Кровокутий Дворучний Меч"
    t[181695] = "Кровокований Короткий Меч"
    t[181696] = "Кровокований Ніж"
    t[181697] = "Кровокована Чароклинка"
    t[181698] = "Кріозаморозка"
    t[181699] = "Нотатки Ехтри"
    t[181700] = "Окропне Вариво"
    t[181701] = "Дзеркало Душ"
    t[181702] = "Перстень-Печатка Освяченого Стража"
    t[181703] = "Намисто Небесного Дзвіночка"
    t[181704] = "Плащ Срібної Ноти"
    t[181705] = "Небесне Шумування"
    t[181706] = "Олія Помазання"
    t[181707] = "Відведена Енергія"
    t[181708] = "Листяний Перстень Лиховісного Лісу"
    t[181709] = "Бентежна Зосередженість"
    t[181712] = "Глибини Божевілля"
    t[181713] = { name = "Обгорілий Лист", fen = "Only a few kind words can be deciphered, yet it was clutched tightly till the end as they held onto a fleeting past.", fua = "Можна розібрати лише кілька теплих слів, проте його міцно стискали до останку, тримаючись за швидкоплинне минуле." }
    t[181714] = { name = "Оздоблений Самоцвітами Віяло", fen = "It is difficult to feel for all those banished to the Ember Ward as the decadence of some is staggering.", fua = "Важко співчувати всім вигнаним до Округу Жарин, адже декаданс декого просто вражає." }
    t[181715] = { name = "Сертифікат Виконання Темеля", fen = "This certificate signifies that the bearer has sufficent skills to hold an Ember Court, after successfully making The Party Herald happy in the course of their trial soiree.", fua = "Цей сертифікат засвідчує, що його власник має достатньо вмінь, аби влаштувати Двір Жарин, успішно догодивши Святковому Герольду на пробному прийомі." }
    t[181716] = { name = "Вербувальні Плакати", fen = "Broadsheet that extols the benefits of serving in Nadjia's security troop.", fua = "Листівка, що вихваляє переваги служби в загоні безпеки Наджії." }
    t[181718] = "Здерев'яніла Руда Федруму"
    t[181719] = "Монолітна Оксеїнова Руда"
    t[181720] = "Грізна Руда Сінвіру"
    t[181721] = "Перстень-Печатка Звитяги Піднесеного"
    t[181722] = { name = "Стародавня Позеленіла Монета", fen = "Once a symbol of success in the arena in Maldraxxus, the visage of the Primus is etched onto the coin.", fua = "Колишній символ перемоги на арені Малдраксуса; на монеті викарбуване обличчя Прима." }
    t[181723] = { name = "Ретельно Замаринована Голова", fen = "Preservation of knowledge means something else entirely in Maldraxxus.", fua = "Збереження знань у Малдраксусі означає геть інше." }
    t[181724] = { name = "Тактика, Том 83: Використання Погоди", fen = "Recognizing the material composition of your foe's armaments, and thus their resemblance to a lightning rod, may dictate how weather-manipulating magics can be utilized.", fua = "Розпізнавання матеріалу, з якого зроблена зброя ворога, а отже й її схожості з громовідводом, може підказати, як найкраще застосувати магію керування погодою." }
    t[181725] = { name = "Цінна Медаль Захисника", fen = "Defenders of Maldraxxus are given a medal in honor of their service to protect the Shadowlands.", fua = "Захисникам Малдраксуса вручають медаль на честь їхньої служби з оборони Тіньокраю." }
    t[181726] = { name = "Воєнна Справа, Том 27: У Тилу Ворога", fen = "Travelling as a prisoner is often more expeditious than remaining undetected.", fua = "Подорожувати як полонений часто швидше, ніж лишатися непоміченим." }
    t[181727] = { name = "Порожні Зміцнені Колби", fen = "Triple-walled flasks are essential in containing the deadly liquids used by the House of Plagues for their experiments.", fua = "Тристінні колби незамінні для зберігання смертоносних рідин, які Дім Чум використовує у своїх дослідах." }
    t[181728] = { name = "Бездоганні Голки Зшивача Плоті", fen = "Carved from the very bones of Maldraxxus, these needles are a prized output of the House of Constructs.", fua = "Вирізані з самих кісток Малдраксуса, ці голки — цінний виріб Дому Конструктів." }
    t[181729] = { name = "Прототип Форми Філактерія", fen = "The House of Liches are constantly working to improve their phylacteries to be more resilient to those seeking to destroy them.", fua = "Дім Лічів безперестанку працює над тим, щоб зробити свої філактерії стійкішими до тих, хто прагне їх знищити." }
    t[181730] = { name = "Кований Оксеїновий Точильний Камінь", fen = "Disciplined soldiers in Maldraxxus keep their weapons sharp and honed, ready to defend the Shadowlands at any cost.", fua = "Дисципліновані солдати Малдраксуса тримають свою зброю гострою й нагостреною, готові захищати Тіньокрай за будь-яку ціну." }
    t[181731] = { name = "Лакований Ікло Ларіона", fen = "Removing a fang from a slumbering Larion was one of many trials required for initiation into the House of Eyes.", fua = "Вирвати ікло в сплячого ларіона було однією з багатьох випробувань, потрібних для вступу до Дому Очей." }
    t[181732] = { name = "Данина Честолюбних", fen = "Valuable items from the Undying Army's supply caches.", fua = "Цінні речі зі схованок припасів Невмирущої Армії." }
    t[181733] = { name = "Данина Відданих Обов'язку", fen = "Valuable items from the Undying Army's supply caches.", fua = "Цінні речі зі схованок припасів Невмирущої Армії." }
    t[181734] = "Тавро Магі"
    t[181735] = "Рубай і Сікти"
    t[181736] = "Нарощення Полум'я"
    t[181737] = "Поживне Чі"
    t[181738] = "Витвір Архімага"
    t[181739] = { name = "Торба Душевного Попелу", fen = "Contains 15000 Soul Ash and 5000 Soul Cinders.", fua = "Містить 15000 душевного попелу та 5000 душевного жару." }
    t[181740] = "Ухильна Хода"
    t[181741] = { name = "Данина Взірця", fen = "Valuable items from the forge-temples are contained within this tribute.", fua = "У цій данині містяться цінні речі з кузень-храмів." }
    t[181742] = "Хода Вола"
    t[181743] = "Перо Архонта"
    t[181744] = "Вуглинка Форджлайтів"
    t[181745] = "Вугілля Коваля Кузні"
    t[181749] = "Звіяна Вітром Висхідна Слава"
    t[181756] = "Замовляння Спритності"
    t[181757] = "Мерехтливий Смолоскип Чувань"
    t[181758] = { name = "Видобувач Гізеїну", fen = "Others see this as an instrument of torture, but the Maldraxxi use this to harvest herbs from the undulating terrain of their homeland.", fua = "Інші вбачають у цьому знаряддя тортур, та малдраксійці використовують його, щоб збирати трави на горбистих землях своєї батьківщини." }
    t[181759] = "Удар із Ясністю"
    t[181760] = "Скам'яніла Кирка"
    t[181761] = { name = "Ваучер Гросмейстера", fen = "This voucher begrudgingly verifies that the Grandmaster has lost a bet and intends to give the bearer the agreed sum. Au'narim at the Theater of Pain will approve and dispense said funds.", fua = "Ця розписка неохоче засвідчує, що Гросмейстер програв парі й має намір віддати пред'явнику обумовлену суму. Ау'нарім у Театрі Болю схвалить і видасть зазначені кошти." }
    t[181762] = "Буйний Вдовоцвіт"
    t[181764] = "Шкуролуп"
    t[181765] = { name = "Жетон Марселя Малбі", fen = "Never planning to bring a gift, Grandmaster Vole still had a good time and tossed this marker into the gift box. If you return it to Marcel he is sure to offer a sizable sum to get his marker back.", fua = "Зовсім не плануючи приносити подарунок, Гросмейстер Воул усе ж добре провів час і вкинув цей жетон у скриньку для дарунків. Якщо повернеш його Марселю, він напевне запропонує чималу суму за повернення свого жетона." }
    t[181767] = { name = "Маленький Гаманець", fen = "The initials GV are sown into the side, you should take it as an honor, Grandmaster Vole is not easily enteretained and rarely does he tip.", fua = "Збоку вишито ініціали ГВ, тож вважай це за честь: Гросмейстера Воула важко розважити, і рідко коли він дає на чай." }
    t[181769] = "Бар'єр Бурі"
    t[181770] = "Кістковомозковий Хміль"
    t[181771] = "Браслет Найкращого Друга Стоунгеда"
    t[181774] = "Насичені Відображення"
    t[181775] = "Шлях Фей"
    t[181776] = "Лютий Презир"
    t[181777] = { name = "Ключ Фаетона", fen = "A key belonging to the runespeakers of the House of the Chosen.", fua = "Ключ, що належить рунословам Дому Обраних." }
    t[181781] = { name = "Майже Порожня Бочка Амонтильядо", fen = "A trowel, jester's bells, and an empty wine bottle rattle around as you peer in the cask.", fua = "Коли ти зазираєш у бочку, всередині торохкотять кельма, блазенські дзвіночки та порожня пляшка з-під вина." }
    t[181782] = "Дзеркало Душ"
    t[181783] = { name = "Позичена Руда Федруму", fen = "Actually an amber-like solidified resin.", fua = "Насправді це затверділа смола, схожа на бурштин." }
    t[181784] = { name = "В'язка Наконечників Стріл Переслідувача", fen = "Very, very sharp.", fua = "Дуже, дуже гострі." }
    t[181785] = { name = "Осеїновий Ключ", fen = "For use on Ansid's cage.", fua = "Для клітки Ансіда." }
    t[181786] = "Вічний Голод"
    t[181787] = { name = "Розплавлений Федрум", fen = "Very, VERY hot! Ready to be poured into a mold.", fua = "Дуже, ДУЖЕ гарячий! Готовий до заливання у форму." }
    t[181788] = { name = "Необроблені Наконечники Стріл", fen = "Even without sharpening, these can be deadly.", fua = "Навіть без заточування вони можуть бути смертоносними." }
    t[181789] = { name = "Дерев'яна Форма для Наконечників Стріл", fen = "A plank with carved notches. Pouring molten phaedrum into the notches produces an arrowhead.", fua = "Дошка з різьбленими виїмками. Заливаючи розплавлений федрум у виїмки, отримуєш наконечник стріли." }
    t[181790] = { name = "Перекований Кіріанський Щит", fen = "It remains heavily dented and tarnished from training.", fua = "Він і досі сильно пом'ятий і потьмянілий від тренувань." }
    t[181791] = { name = "Полірований Кіріанський Щит", fen = "Neatly polished and ready for combat!", fua = "Охайно відполірований і готовий до бою!" }
    t[181792] = { name = "Потьмянілий Кіріанський Щит", fen = "Dent free, but filthy.", fua = "Без жодної вм'ятини, та брудний." }
    t[181793] = { name = "Уламок Розбитого Кіріанського Щита", fen = "Part of a shield that has been sundered.", fua = "Частина щита, що був розколотий." }
    t[181794] = "Ліра Орофеї"
    t[181795] = "Дзеркало Душ"
    t[181797] = { name = "Дивна Тканина", fen = "Could make a distinctive fashion statement.", fua = "Може стати яскравим модним висловлюванням." }
    t[181798] = { name = "Опудало Конструкта", fen = "Could make a distinctive fashion statement.", fua = "Може стати яскравим модним висловлюванням." }
    t[181799] = { name = "Величезний Капелюх", fen = "Could make a distinctive fashion statement.", fua = "Може стати яскравим модним висловлюванням." }
    t[181800] = "Стяг Загону Чорного Гончака"
    t[181801] = { name = "Штандарт Некролордів", fen = "For the honor and glory of Maldraxxus and all of the Shadowlands.", fua = "За честь і славу Малдраксуса й усього Тінокраю." }
    t[181802] = { name = "Штандарт Обранців Смерті", fen = "Maldraxxi are protectors of the realm, selected by the Shadowlands itself as its defender.", fua = "Малдраксійці — захисники королівства, обрані самим Тінокраєм як його оборонці." }
    t[181803] = { name = "Бойовий Штандарт Клинкоприсяжних", fen = "Every defeat is a lesson. Every victory, earned.", fua = "Кожна поразка — це урок. Кожна перемога — заслужена." }
    t[181804] = "Трофей Відродженого Кістколорда"
    t[181805] = "Костокрила Некролордів"
    t[181806] = "Відрослі Кістяні Крила"
    t[181807] = "Варварські Кістяні Крила"
    t[181808] = "Фетиш Смерті"
    t[181809] = { name = "Кристал Приправ Томаліна", fen = "The flavor produced by the crystal is undetectable by mortal tongues but coveted by constructs and liches alike.", fua = "Смак, що дає кристал, нечутний для смертних язиків, але жаданий і конструктами, і лічами." }
    t[181810] = "Філактерій Мертвого Інтригана"
    t[181811] = "Тіньовий Кристал Закличника"
    t[181815] = { name = "Броньований Костекопитний Тавралус", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[181816] = "Сигіл Пристосування Грішного Гладіатора"
    t[181817] = { name = "Обдертокрил Смертоносця", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[181818] = { name = "Погризені Повіддя Недосвідченого Обдертокрила", fen = "Teaches you how to summon a Callow Flayedwing.", fua = "Навчає викликати недосвідченого білокрила." }
    t[181819] = { name = "Повіддя Мозкоікла", fen = "Teaches you how to summon Marrowfang.", fua = "Навчає викликати Мозкоікла." }
    t[181820] = { name = "Броньований Обраний Тавралус", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[181821] = { name = "Броньований Чумогнильний Тавралус", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[181822] = { name = "Броньований Бойововирощений Тавралус", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[181824] = { name = "Їдка Жовч", fen = "Bile capable of burning through metal or magic.", fua = "Жовч, здатна проїдати метал чи магію." }
    t[181825] = "Фіал Ненажерливого Слизу"
    t[181826] = "Напівпрозоре Зображення"
    t[181827] = "Граційний Рух"
    t[181828] = { name = "Огидна Торба Збирача", fen = "This hide satchel has seen better days and reeks of a heady combination of decay and putrefication.", fua = "Ця шкіряна торбина бачила кращі часи й тхне дурманливим поєднанням гнилі та розкладу." }
    t[181834] = "Крижана Витривалість"
    t[181836] = "Виснаження Духу"
    t[181837] = "Ясний Розум"
    t[181838] = "Милосердна Душа"
    t[181840] = "Натхнення Світла"
    t[181841] = "Зміцнений Панцир"
    t[181842] = "Сила Іншим"
    t[181843] = "Осяйна Променистість"
    t[181844] = "Перетворення Болю"
    t[181845] = "Звеличення"
    t[181846] = "Талісман Прудкості"
    t[181847] = "Незламний Дух"
    t[181848] = "Пришвидшений Холод"
    t[181857] = "Еліксир Смирення"
    t[181858] = "Дозок Гротескної Сили"
    t[181859] = "Настоянка Виваженої Дисципліни"
    t[181860] = { name = "Позичена Сутінкова Кора", fen = "Used as an additive to reinforce phaedrum, strengthening it immensely.", fua = "Використовується як добавка для зміцнення федруму, надзвичайно його посилюючи." }
    t[181861] = { name = "Мелена Сутінкова Кора", fen = "Coarsely ground, ready to be added to phaedrum.", fua = "Грубо мелена, готова до додавання у федрум." }
    t[181862] = { name = "Бритва Душі", fen = "Sharp enough to cleave a soul from its mortal body.", fua = "Достатньо гостра, щоб відсікти душу від смертного тіла." }
    t[181864] = "Чумовитравлений Рубач"
    t[181865] = "Чумовитравлений Штрикач"
    t[181866] = "Висушлива Чума"
    t[181867] = "Швидке Покаяння"
    t[181868] = { name = "Вбивча Відпустка", fen = "Focus Emeni's murderous tendencies.", fua = "Спрямовує вбивчі нахили Емені." }
    t[181877] = "Великий Плащ Вартового Рун"
    t[181878] = "Великий Плащ Зимородженого"
    t[181879] = "Великий Плащ Нічного Придворного"
    t[181880] = "Лускатий Великий Плащ Консерватора"
    t[181909] = "Кольчуга Вартового Рун"
    t[181910] = "Чоботи Вартового Рун"
    t[181911] = "Рукавички Вартового Рун"
    t[181912] = "Личина Вартового Рун"
    t[181913] = "Поножі Вартового Рун"
    t[181914] = "Наплічники Вартового Рун"
    t[181915] = "Пряжка Вартового Рун"
    t[181916] = "Наручі Вартового Рун"
    t[181917] = "Напульсники Зимородженого"
    t[181918] = "Пряжка Зимородженого"
    t[181919] = "Зимороджені Наплічники"
    t[181920] = "Поножі Зимородженого"
    t[181921] = "Личина Зимородженого"
    t[181922] = "Рукавички Зимородженого"
    t[181923] = "Чоботи Зимородженого"
    t[181924] = "Кольчуга Зимородженого"
    t[181925] = "Пов'язки Нічного Придворного"
    t[181926] = "Пряжка Нічного Придворного"
    t[181927] = "Наплічники Нічного Придворного"
    t[181928] = "Поножі Нічного Придворного"
    t[181929] = "Личина Нічного Придворного"
    t[181930] = "Рукавички Нічного Придворного"
    t[181931] = "Чоботи Нічного Придворного"
    t[181932] = "Кольчуга Нічного Придворного"
    t[181933] = "Лускаті Наручі Консерватора"
    t[181934] = "Лускатий Пояс Консерватора"
    t[181935] = "Лускаті Наплічники Консерватора"
    t[181936] = "Лускаті Поножі Консерватора"
    t[181937] = "Лускана Подоба Консерватора"
    t[181938] = "Лускаті Рукавички Консерватора"
    t[181939] = "Лускаті Чоботи Консерватора"
    t[181940] = "Лускатий Нагрудник Консерватора"
    t[181941] = "Шати Нічного Придворного"
    t[181942] = "Зосереджене Зцілення"
    t[181943] = "Нищівний Удар"
    t[181944] = "Резонансні Слова"
    t[181945] = { name = "Рагу для Стюардів", fen = "For Stewards, not made from them.", fua = "Для стюардів, а не з них." }
    t[181946] = "Павуче В'ялене М'ясо"
    t[181947] = "М'ясо на Шпажках"
    t[181948] = "Чари: Точний Приціл"
    t[181949] = "Незламний Кристал"
    t[181950] = "Вічногорючий Смолоскип"
    t[181951] = "Силовий Молот"
    t[181952] = "Кісткоокована Метавка Кілків"
    t[181953] = "Пістоль Дуелянта"
    t[181954] = "Розкішна Мерехтоплавка"
    t[181955] = "Скелетний Мулоскок"
    t[181956] = "Кривавогорлий Групер"
    t[181957] = "Заклик Обов'язку"
    t[181958] = "Літанія Могутності"
    t[181959] = "Каталог Гріхів"
    t[181960] = "Осяйне Кіранітове Намисто"
    t[181961] = "Різьблений Кристалевий Перстень"
    t[181962] = "Розумове Відновлення"
    t[181963] = "Кровний Зв'язок"
    t[181964] = "Лиховісний Амулет"
    t[181965] = "Сталешкірна Шкіряна Збруя"
    t[181966] = "Кулак, Усіяний Кістками"
    t[181967] = "Придворні Шкіряні Чоботи"
    t[181968] = "Розкішна Міднохутрова Шкура"
    t[181969] = "Міцний Панцир"
    t[181970] = "Моторошна Дублена Шкіра"
    t[181971] = "Туніка з Тканого Серпанку"
    t[181972] = "Моторошний Каптур"
    t[181973] = "Загрозливий Гобелен"
    t[181974] = "Мужнє Сходження"
    t[181975] = "Затверділі Кістки"
    t[181977] = "Шати Зимородженого"
    t[181978] = "Лускаті Шати Консерватора"
    t[181979] = "Шати Вартового Рун"
    t[181980] = "Обійми Смерті"
    t[181981] = "Гнійне Переливання"
    t[181982] = "Вічномороз"
    t[181983] = "Рідкий Сон"
    t[181984] = "Порошковий Сонокорінь"
    t[181985] = "Свіжі Пагони Мрієкореня"
    t[181986] = "Нарізані Арденські Яблука"
    t[181987] = "Свіжі Арденські Яблука"
    t[181988] = "Мішок Арденського Вівса"
    t[181990] = "Сутінковий Пил"
    t[181991] = "Старовинний Лук Переслідувача"
    t[181992] = "Електрокабель"
    t[181993] = "Заряджена Батарея"
    t[181994] = "Оброблений Злиток Федруму"
    t[181995] = "Сувій Заспокійливих Слів"
    t[181996] = "Чорнило з Арденягоди"
    t[181997] = "Пігмент з Арденягоди"
    t[181998] = "Гравійований Федрумовий Перстень"
    t[181999] = "Шліфовані Самоцвіти"
    t[182000] = "Шліфований Федрумовий Прут"
    t[182001] = "Ремінь зі Шкіри Рунооленя"
    t[182002] = "Фарбована Шкіра Руностага"
    t[182003] = "Шкіра Рунооленя"
    t[182004] = "Сувій Тканини Арденшовку"
    t[182005] = "Тканина з Арденового Шовку"
    t[182006] = "Котушка Арденшовку"
    t[182007] = "Сталешкірний Шкіряний Пояс"
    t[182008] = "Сталешкірний Шкіряний Ремінь"
    t[182009] = "Свіжа Сталешкіра"
    t[182010] = "Кіранітова Підвіска"
    t[182011] = "Соленієвий Дріт"
    t[182012] = "Позичений Самородок Соленію"
    t[182013] = "Вірш про Обов'язок"
    t[182014] = "Опалесцентне Чорнило"
    t[182015] = "Опалесцентний Пігмент"
    t[182016] = "Поршневий Вузол"
    t[182017] = "Загартовані Болти"
    t[182018] = "Оброблений Злиток Соленію"
    t[182020] = "Трансцендентний Пил"
    t[182021] = "Старовинний Кіріанський Дротик"
    t[182022] = "Нарізані Овочі"
    t[182023] = "Кістковий Бульйон із Травоїда"
    t[182024] = "Кістки Травоїда"
    t[182025] = "Очищена Рішучість"
    t[182026] = "Подрібнений Вітроцвіт"
    t[182027] = "Свіжі Пагони Вітроцвіту"
    t[182028] = "Похмура Нитка"
    t[182029] = "Нитка Трупозшивача"
    t[182030] = "Очищена Шкіра"
    t[182031] = "Невикористана Плоть"
    t[182032] = "Видовбаний Кристал"
    t[182033] = "Гранований Кристал"
    t[182034] = "Зазублений Некротичний Кристал"
    t[182035] = "Сувій Незламної Сили"
    t[182036] = "Некротичне Чорнило"
    t[182037] = "Некротичний Пігмент"
    t[182038] = "Зміцнені Кісткою Оксеїнові Трубки"
    t[182039] = "Жменя Оксеїнових Болтів"
    t[182040] = "Оброблений Злиток Оксеїну"
    t[182042] = "Некротична Сутність"
    t[182043] = "Старовинний Посох Некроманта"
    t[182044] = "Товсте Павуче М'ясо"
    t[182045] = "Товсті Павучі Ноги"
    t[182046] = "Могильний Пил"
    t[182047] = "Жорстока Олія"
    t[182048] = "Потрощені Кістки"
    t[182049] = "Кістки Переможених Ворогів"
    t[182050] = "Тканина Пихоткання"
    t[182051] = "Сувій Гордоткані"
    t[182052] = "Нитка Гордості"
    t[182053] = "Катована Підошва"
    t[182054] = "Розм'якшена Шкіра"
    t[182055] = "Подерта Шкіра Сінраннера"
    t[182056] = "Осяйна Цяцька"
    t[182057] = "Тонкий Сінвірний Ланцюг"
    t[182058] = "Шліфований Сінвірний Злиток"
    t[182059] = "Сувій Покарання"
    t[182060] = "Пихате Чорнило"
    t[182061] = "Пихатий Пігмент"
    t[182062] = "Сінвіровий Ствол"
    t[182063] = "Сінвіровий Спусковий Механізм"
    t[182064] = "Оброблений Злиток Сінвіру"
    t[182066] = "Кривавий Кристал"
    t[182067] = "Старовинна Рапіра Дуелянта"
    t[182068] = "Жариновий Соус"
    t[182069] = "Підсмажені Котлети"
    t[182070] = "Свіжий Стейк зі Звіра"
    t[182071] = "Витончена Покора"
    t[182072] = "Сік Колючого Терну"
    t[182073] = "Свіжі Пагони Колючника"
    t[182074] = { name = "Обраний Тавралус", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182075] = { name = "Костекопитний Тавралус", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182076] = { name = "Чумогнильний Тавралус", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182077] = { name = "Бойововирощений Тавралус", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182078] = { name = "Костезшитий М'ясарок", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182079] = { name = "Вкриті Слизом Повіддя Дебелого Смертарока", fen = "Teaches you how to summon a Hulking Deathroc.", fua = "Навчає викликати дебелого смертарока." }
    t[182080] = { name = "Хижий Чумарок", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182081] = { name = "Повіддя Колосального Різоклаба", fen = "Teaches you how to summon a Colossal Slaughterclaw.", fua = "Навчає викликати колосального різоклаба." }
    t[182082] = { name = "Моторошний Кровоіклий", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182083] = { name = "Череповепр Костетята", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182084] = { name = "Кровошпич", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182085] = { name = "Пухирчастоспинний Кровоіклий", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182086] = "Загартована Важка Бритва"
    t[182087] = "М'яке Важке Лезо"
    t[182088] = "Позичена Оксеїнова Руда"
    t[182089] = "Зачаровані Заклепки"
    t[182090] = "Сковуючі Наручі"
    t[182091] = "Позичений Злиток Сінвіру"
    t[182092] = "Гартовані Ланцюги Кайданів"
    t[182093] = "М'які Ланцюги Кайданів"
    t[182094] = "Позичений Прут Сінвіру"
    t[182095] = "Поклик Піднесення: Клея"
    t[182096] = "Жаринові Чилі"
    t[182097] = { name = "Сповита Скалка Дзеркала", fen = "Glass used to craft magical mirros in Revendreth.", fua = "Скло, з якого роблять магічні дзеркала в Ревендреті." }
    t[182098] = "Свіжа Морква"
    t[182099] = "Свіжа Ріпа"
    t[182100] = "Свіжі Гриби"
    t[182101] = "Основа для Вівсяного Пирога"
    t[182102] = "Сувій Тканого Серпанку"
    t[182103] = "Серпанкова Тканина"
    t[182104] = "Серпанкова Нитка"
    t[182105] = "Астральний Захист"
    t[182106] = "Освіжальні Води"
    t[182107] = "Життєвий Приріст"
    t[182108] = "Громові Лапи"
    t[182109] = "Тотемний Сплеск"
    t[182110] = "Калічний Пристріт"
    t[182111] = "Духовний Резонанс"
    t[182112] = { name = "Саморобний Набір для Ремонту Дзеркал", fen = "Used in the repair of the most intricate translocation mirrors in Revendreth.", fua = "Використовується для ремонту найскладніших дзеркал переміщення в Ревендреті." }
    t[182113] = "Скороминущий Вітер"
    t[182116] = "Сувій Похмурої Тканини"
    t[182117] = "Похмура Тканина"
    t[182118] = "Кислий Вечірній Трунок"
    t[182119] = { name = "Кривава Марілет", fen = "A drink favored by those in the House of Plagues, and in honor of the ingenious Marileth.", fua = "Напій, улюблений серед мешканців Дому Чум, на честь винахідливого Марілета." }
    t[182120] = "Серце Ліча"
    t[182121] = "Воскреситель Трупів"
    t[182122] = "Арденовий Вермут"
    t[182123] = "Витримана Текіла Аграве"
    t[182125] = "Пірокластичний Удар"
    t[182126] = "Висока Напруга"
    t[182127] = "Струсити Підвалини"
    t[182128] = "Поклик Полум'я"
    t[182129] = "Феїна Фермата"
    t[182130] = "Розбите Сприйняття"
    t[182131] = "Моторошні Привиди"
    t[182132] = "Нескінченна Хватка"
    t[182133] = "Невгамовний Апетит"
    t[182134] = "Непокірні Вітри"
    t[182135] = "Зосереджена Блискавка"
    t[182136] = "Промерзлий до Кісток"
    t[182137] = "Магмовий Кулак"
    t[182138] = "Пожирач Розуму"
    t[182139] = "Скажені Тіні"
    t[182140] = "Дисонансні Відлуння"
    t[182141] = "Свята Промова"
    t[182142] = "Обійми Землі"
    t[182143] = "Вирові Течії"
    t[182144] = "Зосередження Природи"
    t[182145] = "Рясна Злива"
    t[182158] = { name = "Насичений Уламок Каменю", fen = "Still saturated with anima.", fua = "Усе ще насичений анімою." }
    t[182160] = { name = "Торбинка Ласощів для Твіґіна", fen = "Attracts Twigin to your side... till you run out of treats.", fua = "Приваблює Твіґіна до тебе... доки не скінчаться ласощі." }
    t[182161] = { name = "Церемоніальний Дротик", fen = "A favored form of combat meditation, precise accuracy when throwing these spears can only be achieved by a tranquil mind.", fua = "Улюблена форма бойової медитації: бездоганної влучності в метанні цих списів можна досягти лише спокійним розумом." }
    t[182162] = "Креслення: Талісман Спритності"
    t[182163] = { name = "Сила Крові", fen = "An ancient mixture of vitallity boosting ingredients.", fua = "Прадавня суміш складників, що зміцнюють життєву силу." }
    t[182164] = "Послуга Розпорядника: Сховок Реагентів"
    t[182165] = "Душа Арденового Метелика"
    t[182166] = "Ведмежа Душа"
    t[182167] = "Душа Кобри"
    t[182168] = "Душа Журавля"
    t[182169] = "Душа Вуалекрила"
    t[182170] = "Душа Грифона"
    t[182171] = "Душа Гіпогрифа"
    t[182172] = "Кінська Душа"
    t[182173] = "Душа Гієни"
    t[182174] = "Лев'яча Душа"
    t[182175] = "Душа Лося"
    t[182176] = "Душа Тіньового Переслідувача"
    t[182177] = "Душа Совокота"
    t[182178] = "Душа Раптора"
    t[182179] = "Душа Рунооленя"
    t[182180] = "Душа Оленя"
    t[182181] = "Душа Тигра"
    t[182182] = "Вовча Душа"
    t[182183] = "Душа Вовкосокола"
    t[182184] = "Душа Віверни"
    t[182185] = "Душа Верескуна"
    t[182186] = { name = "Викрадена Пам'ятка", fen = "The thief almost got away with it. Keeper Ta'saran will be interested in this. (|CFFfbdd52+Relaxing|R)", fua = "Злодій ледь не втік із цим. Хранителя Та'сарана це зацікавить. (|CFFfbdd52+Спокій|R)" }
    t[182187] = "М'ясний Щит"
    t[182188] = "Менша Фіала Безтурботності"
    t[182189] = "Феїна Флейта"
    t[182190] = "Нашийник зі Шкіри Тауралуса"
    t[182191] = "Замуслена Іграшка-Гризунчик"
    t[182192] = "Поножі до Колін"
    t[182193] = "Цупка Шкіра Сталешкура"
    t[182194] = "Сталешкірна Жила"
    t[182195] = "Дзеркальце для Чепуріння"
    t[182196] = "Аркбаліста Колосального Хижака"
    t[182197] = "Позичений Кіраніт"
    t[182198] = "Звивистий Кровопивця-Землериї"
    t[182199] = { name = "Полум'я в Пляшці від Брайтспарка", fen = "The bottle emits a comforting warmth.", fua = "Пляшка випромінює затишне тепло." }
    t[182200] = "Наповнений Кров'ю Норолаз"
    t[182201] = "Вивільнене Шаленство"
    t[182202] = "Позичений Пергамент"
    t[182203] = "Виснажлива Хвороба"
    t[182204] = "Ілюзія: Гнів Гріха"
    t[182205] = "Заборало зі Скарабеєвого Панцира"
    t[182206] = "Скликання Мертвих"
    t[182208] = "Тривка Чума"
    t[182209] = { name = "Бойовий Гаргон Жадання", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182210] = "Дзеркальце для Чепуріння"
    t[182211] = { name = "Кам'яна Цеглина", fen = "Scuffs can use this to create a statue to honor you (+|CFF1b8729Decadent|R) or others (|CFF1b8729+Humble|R).", fua = "Дряпко може використати її, щоб створити статую на честь тебе (+|CFF1b8729Розкіш|R) чи інших (|CFF1b8729+Скромність|R)." }
    t[182212] = { name = "Магічна Дивовижа", fen = "This trinket has been imbued with power. Mikanikos will be interested in this. (|CFFfbdd52+Bonus Happiness|R)", fua = "Цей тринкет наповнений силою. Це зацікавить Міканікоса. (|CFFfbdd52+Бонусна радість|R)" }
    t[182213] = "Найвищий Великий Шолом Вісника"
    t[182214] = "Найвищий Нагрудник Вісника"
    t[182215] = "Найвищі Чоботи Вісника"
    t[182216] = "Найвищі Чоботи Вісника"
    t[182217] = "Поножі Верховного Провісника"
    t[182218] = "Найвищі Наплічники Вісника"
    t[182219] = "Найвищий Бойовий Пояс Вісника"
    t[182220] = "Найвищі Наручі Вісника"
    t[182221] = "Найвищий Великий Плащ Вісника"
    t[182222] = "Найвищий Лик Привида"
    t[182223] = "Найвищий Нагрудник Привида"
    t[182224] = "Найвищі Чоботи Привида"
    t[182225] = "Найвищі Рукавиці Привида"
    t[182226] = "Штани Верховного Примарного Духа"
    t[182227] = "Найвищі Наплічники Привида"
    t[182228] = "Найвищий Пояс Привида"
    t[182229] = "Найвищі Наручі Привида"
    t[182230] = "Найвищий Плащ Привида"
    t[182231] = "Найвищий Каптур Чаклуна"
    t[182232] = "Найвища Туніка Чаклуна"
    t[182233] = "Найвищі Чоботи Чаклуна"
    t[182234] = "Найвищі Рукавички Чаклуна"
    t[182235] = "Поножі Верховного Чаклуна"
    t[182236] = "Найвищий Оплічник Чаклуна"
    t[182237] = "Найвищий Пояс Чаклуна"
    t[182238] = "Найвищі Наручі Чаклуна"
    t[182239] = "Найвищий Плащ Чаклуна"
    t[182240] = "Найвищий Шолом Тактика"
    t[182241] = "Найвищий Нагрудник Тактика"
    t[182242] = "Найвищі Чоботи Тактика"
    t[182243] = "Найвищі Латні Рукавиці Тактика"
    t[182244] = "Набедреники Верховного Тактика"
    t[182245] = "Найвищі Наплічники Тактика"
    t[182246] = "Найвищий Пояс Тактика"
    t[182247] = "Найвищі Наручі Тактика"
    t[182248] = "Найвищий Плащ Тактика"
    t[182249] = "Наручі Плототворення"
    t[182250] = "Великий Шолом Провісника Присяглих Клинку"
    t[182251] = "Нагрудник Провісника Присяглих Клинку"
    t[182252] = "Чоботи Провісника Присяглих Клинку"
    t[182253] = "Трощителі Провісника Присяглих Клинку"
    t[182254] = "Поножі Передвісника Присяги Клинка"
    t[182255] = "Наплічники Провісника Присяглих Клинку"
    t[182256] = "Бойовий Пояс Провісника Присяглих Клинку"
    t[182257] = "Наручі Провісника Присяглих Клинку"
    t[182258] = "Великий Плащ Провісника Присяглих Клинку"
    t[182259] = "Лик Примари Клинкоприсяжного"
    t[182260] = "Куртка Примари Клинкоприсяжного"
    t[182261] = "Чоботи Примари Клинкоприсяжного"
    t[182262] = "Душителі Примари Клинкоприсяжного"
    t[182263] = "Штани Привида Присяги Клинка"
    t[182264] = "Наплічники Примари Клинкоприсяжного"
    t[182265] = "Пояс Примари Клинкоприсяжного"
    t[182266] = "Наручі Примари Клинкоприсяжного"
    t[182267] = "Плащ Примари Клинкоприсяжного"
    t[182268] = "Каптур Заклинача Присяглих Клинку"
    t[182269] = "Туніка Заклинача Присяглих Клинку"
    t[182270] = "Капці Заклинача Присяглих Клинку"
    t[182271] = "Рукавички Заклинача Присяглих Клинку"
    t[182272] = "Поножі Чарівника Присяги Клинка"
    t[182273] = "Оплічник Заклинача Присяглих Клинку"
    t[182274] = "Пояс Заклинача Присяглих Клинку"
    t[182275] = "Наручі Заклинача Присяглих Клинку"
    t[182276] = "Плащ Заклинача Присяглих Клинку"
    t[182277] = "Забрало Тактика Присяглих Клинку"
    t[182278] = "Кольчуга Тактика Присяглих Клинку"
    t[182279] = "Латні Чоботи Тактика Присяглих Клинку"
    t[182280] = "Латні Рукавиці Тактика Присяглих Клинку"
    t[182281] = "Поножі Тактика Присяги Клинка"
    t[182282] = "Наплічники Тактика Присяглих Клинку"
    t[182283] = "Пояс Тактика Присяглих Клинку"
    t[182284] = "Наручі Тактика Присяглих Клинку"
    t[182285] = "Плащ Тактика Присяглих Клинку"
    t[182286] = "Сутінковий Пергамент"
    t[182287] = { name = "Навіки Збережений Скарабей", fen = "A breed of scarab lost to time.", fua = "Порода скарабея, втрачена в часі." }
    t[182288] = "Непроникний Морок"
    t[182289] = "Жменя Мерехтливих Самоцвітів"
    t[182290] = "Пляшка Барвника для Шкіри"
    t[182292] = "Жорстокий Захват"
    t[182295] = "Поширення"
    t[182296] = { name = "Рекомендаційний Лист, Головний Розпорядник Свят", fen = "This letter will let Temel know that the bearer has previous party planning experience and is ready to hit the ground running.", fua = "Цей лист повідомить Темелю, що пред'явник має досвід в організації свят і готовий одразу взятися до справи." }
    t[182297] = "Обдерта Плоть"
    t[182298] = { name = "Каджа'Екстрім", fen = "Latest in the Kaja brand, it really get the brain cells firing!", fua = "Новинка від марки Каджа, від неї мозкові клітини аж іскрять!" }
    t[182299] = "Зіпсований Панцир"
    t[182301] = { name = "Землекопова Суміш із Каджа-Настоєм", fen = "It's practically bursting with inspiration!", fua = "Її буквально розпирає від натхнення!" }
    t[182302] = "Промоплакати Гурту"
    t[182303] = { name = "Душеплащ Убивці", fen = "A veiled cloak, allowing you to see hidden magics within Perdition Hold.", fua = "Завуальований плащ, що дозволяє бачити приховану магію в Оплоті Загибелі." }
    t[182304] = "Божественний Поклик"
    t[182305] = { name = "Вінець Осінньої Флори", fen = "A circlet of flowers that only bloom late in the cycle of life.", fua = "Вінок із квітів, що розквітають лише наприкінці життєвого циклу." }
    t[182307] = "Захисні Слова"
    t[182308] = "Скалка Граната"
    t[182309] = "Цупкий Пергамент"
    t[182310] = { name = "Конфісковані Інструменти", fen = "Confiscated for excessive noise violations. Liberated for the right to rock!", fua = "Конфісковано за надмірне порушення тиші. Звільнено в ім'я права на рок!" }
    t[182311] = { name = "Конфісковані Сценічні Прожектори", fen = "Confiscated for excessive noise violations. Liberated for the right to rock!", fua = "Конфісковано за надмірне порушення тиші. Звільнено в ім'я права на рок!" }
    t[182312] = { name = "Конфісковані Сценічні Декорації", fen = "Confiscated for excessive noise violations. Liberated for the right to rock!", fua = "Конфісковано за надмірне порушення тиші. Звільнено в ім'я права на рок!" }
    t[182313] = "Підривні Заряди"
    t[182314] = "Ендмайрський Лозокорінь"
    t[182315] = { name = "Насичений Плід Кінцетопі", fen = "Similar to a pear, exposure to the endmire has twisted this fruit and the devourer mites flourish off it.", fua = "Схожий на грушу, цей плід викривило під впливом Кінцетопі, і пожирачі-кліщі бенкетують на ньому." }
    t[182316] = "Захисник Скверни"
    t[182317] = "Розбите Відновлення"
    t[182318] = "В'язке Чорнило"
    t[182319] = "Булава Дикого Полювання"
    t[182321] = "Знак Знесилення"
    t[182322] = "Молот Фейської Присяги"
    t[182323] = "Чароклинок Фейської Присяги"
    t[182324] = "Поспіх Вогню Скверни"
    t[182325] = "Жадібне Поглинання"
    t[182326] = "Гравюра Панування: Біль"
    t[182327] = "Гравюра Панування: Втрата"
    t[182328] = "Гравюра Панування: Скорбота"
    t[182329] = "Поклик Панування"
    t[182330] = "Демонічне Помилування"
    t[182331] = "Посилене Вивільнення"
    t[182332] = { name = "Надгробкова Бойова Броня", fen = "Teaches you how to summon a Gravestone Battle Gargon.", fua = "Навчає викликати надгробкового бойового гаргона." }
    t[182333] = "Роса Будякоцвіту"
    t[182334] = "Серце Плототворця"
    t[182335] = "Налаштування на Духів"
    t[182336] = "Золотий Шлях"
    t[182338] = "Чиста Зосередженість"
    t[182339] = "Некротичний Шквал"
    t[182340] = "Спритність Скверни"
    t[182341] = "Серце Плототворця"
    t[182342] = "Персонал: Посол"
    t[182343] = "Персонал: Посол"
    t[182344] = "Загублений у Темряві"
    t[182345] = "Елізійський Реквієм"
    t[182346] = "Навальні Хвилі"
    t[182347] = "Сутнісний Видобуток"
    t[182348] = "Щедрий Урожай"
    t[182349] = "Дрючок Грішного Гладіатора"
    t[182350] = "Рейдова Булава Арденвельду СИЛ"
    t[182351] = "Булава Звільненого"
    t[182352] = "Булава Нічного Придворного"
    t[182353] = "Палиця Зимородженого"
    t[182354] = "М'яке Хутро Вульпіна"
    t[182355] = { name = "Забутий Солодкий Сир", fen = "Small bits of fruit in every bite.", fua = "Шматочки фруктів у кожному кусні." }
    t[182356] = { name = "Витриманий Вітросир", fen = "Who can guess what flavors the wind may bring?", fua = "Хто вгадає, які смаки принесе вітер?" }
    t[182357] = { name = "Розмоклий Сир із Водоростей", fen = "Technically all-natural flavors, but who thought leaving this cheese here was a good idea?", fua = "Технічно цілком натуральний смак, але кому спало на думку лишити цей сир тут?" }
    t[182358] = "Свіжа Аніма Бастіону"
    t[182359] = "Свіжа Аніма Малдраксуса"
    t[182360] = "Свіжа Аніма Арденвельду"
    t[182361] = "Свіжа Аніма Ревендрету"
    t[182362] = "Відновлена Деревина"
    t[182363] = { name = "Зачарований Пил Пройдисвіта", fen = "A tiny sprinkle is enough to disguise your appearance for a full day.", fua = "Дрібки досить, щоб змінити твою зовнішність на цілий день." }
    t[182364] = { name = "Буденний Убивця", fen = "How to hide in plain sight and ensure your victims never see it coming.", fua = "Як ховатися в усіх на очах і зробити так, щоб жертви ніколи не побачили твого нападу." }
    t[182365] = { name = "Дріжджова Закваска для Кислого Хліба", fen = "Alive and hungry, ready to ferment.", fua = "Жива й голодна, готова бродити." }
    t[182366] = { name = "Огидний Слиз", fen = "It quivers slightly.", fua = "Він злегка тремтить." }
    t[182367] = { name = "Гнилі Кістки", fen = "Alarmingly sticky.", fua = "Тривожно липкі." }
    t[182368] = "Невпинний Натиск"
    t[182369] = "Оздоблений Кинджал Двору Жарин"
    t[182370] = "Клинок Хрестоносця з Попелястого Двору"
    t[182371] = "Кігті Вартових Двору"
    t[182372] = "Молоток Двору Жарин"
    t[182373] = "Посох Обвинувачки Двору Жарин"
    t[182374] = "Шипастий києк Попелястого двору"
    t[182375] = "Клинок Дуелянта Двору Жарин"
    t[182376] = "Клинок Придворного Вартового"
    t[182377] = "Клинок Придворного Грішноткача"
    t[182378] = "Крилате Лезо Попелястого Двору"
    t[182379] = "Арбалет Вартового Попелястого Двору"
    t[182380] = "Щит Придворного Охоронця"
    t[182381] = "Кристал Двору"
    t[182382] = { name = "Настоянка Мерзенного Спротиву", fen = "Rarely in stock, due to its unstable nature.", fua = "Рідко буває в наявності через свою нестабільну природу." }
    t[182383] = "Танець з Долею"
    t[182384] = "Зубчаста Глефа"
    t[182385] = "Наростаюче Пекло"
    t[182386] = { name = "Наплічники Імперіуму", fen = "The Primus's pauldrons.", fua = "Наплічники Примуса." }
    t[182387] = { name = "Дика Аніма", fen = "Glows with a chaotic light.", fua = "Світиться хаотичним світлом." }
    t[182388] = "Спиноріз Натрійського Асасина"
    t[182389] = "Бастардний Меч Натрійського Хрестоносця"
    t[182390] = "Кігті Генералів Легіону"
    t[182391] = "Вироковий Молоток Гріхокрада"
    t[182392] = "Посох Відпущення Гріхоносця"
    t[182393] = "Жезл Кам'яних Вартових"
    t[182394] = "Зазубрений Мечолам Жахокрила"
    t[182395] = "Жахоклинок Кам'янонароджених"
    t[182396] = "Анімаклинок Зголоднілого Ритуаліста"
    t[182397] = "Крилоглефа Генерала Легіону"
    t[182398] = "Залізоплюй Жахоікла"
    t[182399] = "Бар'єр Кам'янокованих Ґаргулій"
    t[182400] = "Різець Майстрині-Каменотески"
    t[182401] = "Гострогрішний Дирк Грішного Гладіатора"
    t[182402] = "Клинок Хрестоносця Грішного Гладіатора"
    t[182403] = "Кіготь Ґаргульї Грішного Гладіатора"
    t[182404] = "Молоток Грішного Гладіатора, що Поглинає Гріхи"
    t[182405] = "Смолоскипний Посох Грішного Гладіатора"
    t[182406] = "Бойовий Посох Грішного Гладіатора"
    t[182407] = "Крилоклинок Грішного Гладіатора"
    t[182408] = "Мечолам Грішного Гладіатора"
    t[182409] = "Клинок Грішного Гладіатора, що Поглинає Гріхи"
    t[182410] = "Крилата Глефа Грішного Гладіатора"
    t[182411] = "Багатозарядний Арбалет Грішного Гладіатора"
    t[182412] = "Редут Грішного Гладіатора"
    t[182413] = "Осередок Чарів Грішного Гладіатора"
    t[182414] = "Зрадницький Ніж Багряного Двору"
    t[182415] = "Тесак Каменородного Голіафа"
    t[182416] = "Кігті Кам'яних Генералів"
    t[182417] = "Булава Огортальних Гріхів"
    t[182418] = "Смолоскип Вогняного Спокутування"
    t[182419] = "Посох Натрійського Смолоскипника"
    t[182420] = "Плоторозривач Натрійського Дуелянта"
    t[182421] = "Шипасте Лезо Кам'яного Легіону"
    t[182422] = "Шпичак Грізного Інквізитора"
    t[182423] = "Бойова Глефа Крилотанцівника"
    t[182424] = "Багатозарядний Арбалет Жахокажана"
    t[182425] = "Оплот Кам'яного Легіону"
    t[182426] = "Просякнутий Каменеріз Каменотески"
    t[182427] = "Серцеколій Сінфоллу"
    t[182428] = "Позолочений Бастардний Меч Гріхопаду"
    t[182429] = "Кіготь Визолоченого Каменероджена"
    t[182430] = "Молоток Жахокрила Грішношукача"
    t[182431] = "Позолочений Посох Гріхоїда"
    t[182432] = "Позолочений Посох Вартового"
    t[182433] = "Шипаста Жахоклинок"
    t[182434] = "Крилоклинок з Багряним Лезом"
    t[182435] = "Багрянозубчастий Грішнолам"
    t[182436] = "Багряна Глефа Жахокрила"
    t[182437] = "Багряний Метач Шипів Верескуна"
    t[182438] = "Визолочений Оплот Сінфолу"
    t[182439] = "Осередок Чарів Серця Гріха"
    t[182440] = "Пронизливий Вирок"
    t[182442] = "Слава Ветерана"
    t[182448] = "Кінська Броня Світла"
    t[182449] = "Непохитна Завіса"
    t[182450] = { name = "Бездоганна Лусочка Крила Арденського Метелика", fen = "Shines with bright iridescence.", fua = "Сяє яскравою райдужністю." }
    t[182451] = "Грандіозний Задум Мерехтливого Пилу"
    t[182452] = "Тернина Вічного Холоду"
    t[182453] = "Сутінковий Цвіт"
    t[182454] = "Шепоти в Темряві"
    t[182455] = "Зцілення Сновиди"
    t[182456] = "Вигнання Зла"
    t[182457] = "Уламок Дзеркала"
    t[182458] = "Дзеркало Прадавніх Учень"
    t[182459] = "Смачні Пальчики"
    t[182460] = "Накопичена Життєва Сила"
    t[182461] = "Відлунні Благословення"
    t[182462] = "Очищення"
    t[182463] = "Жахітна Кара"
    t[182464] = "Гармонія Тортолланів"
    t[182465] = "Слід Істини"
    t[182466] = "Тінь Жаху"
    t[182467] = "Дзеркало Душ"
    t[182468] = "Смертельне Комбо"
    t[182469] = "Відживляючий Вітер"
    t[182470] = "Демонічний Натиск"
    t[182471] = "Горнило Душ"
    t[182473] = "Фоліант з Архівама"
    t[182475] = { name = "Заборонене Чорнило", fen = "Ink used by magical quills.", fua = "Чорнило, що його використовують магічні пера." }
    t[182476] = "Витривалість Мисливця"
    t[182477] = { name = "Священний Текст", fen = "A compilation of teachings from Chyrus, Paragon of Humility.", fua = "Збірка повчань Хіруса, Взірця Смирення." }
    t[182478] = "Зловісний Погляд"
    t[182479] = "Ключ Попелопаду"
    t[182480] = "Поворот Долі"
    t[182481] = "Латаний Великий Шолом Провісника"
    t[182482] = "Латаний Нагрудник Провісника"
    t[182483] = "Латані Чоботи Провісника"
    t[182484] = "Латані Трощії Провісника"
    t[182485] = "Залатані Поножі Передвісника"
    t[182486] = "Латані Наплічники Провісника"
    t[182487] = "Латаний Бойовий Пояс Провісника"
    t[182488] = "Латані Наручі Провісника"
    t[182489] = "Латаний Великий Плащ Провісника"
    t[182490] = "Латана Личина Примари"
    t[182491] = "Латаний Камзол Примари"
    t[182492] = "Латані Чоботи Примари"
    t[182493] = "Латані Душителі Примари"
    t[182494] = "Залатані Штани Примари"
    t[182495] = "Латані Наплічники Примари"
    t[182496] = "Латаний Пояс Примари"
    t[182497] = "Латані Наручі Примари"
    t[182498] = "Латаний Плащ Примари"
    t[182499] = "Латаний Каптур Заклинача"
    t[182500] = "Латана Туніка Заклинача"
    t[182501] = "Латані Пантофлі Заклинача"
    t[182502] = "Латані Рукавички Заклинача"
    t[182503] = "Залатані Поножі Заклинача"
    t[182504] = "Латаний Оплічник Заклинача"
    t[182505] = "Латаний Пояс Заклинача"
    t[182506] = "Латані Наручі Заклинача"
    t[182507] = "Латаний Плащ Заклинача"
    t[182508] = "Латане Забрало Тактика"
    t[182509] = "Латана Кольчуга Тактика"
    t[182510] = "Латані Чоботи Тактика"
    t[182511] = "Латані Латні Рукавиці Тактика"
    t[182512] = "Залатані Набедреники Тактика"
    t[182513] = "Латані Наплічники Тактика"
    t[182514] = "Латаний Пояс Тактика"
    t[182515] = "Латані Наручі Тактика"
    t[182516] = "Латана Накидка Тактика"
    t[182517] = "Великий Шолом Відданого Вісника"
    t[182518] = "Нагрудник Відданого Вісника"
    t[182519] = "Тупотуни Відданого Вісника"
    t[182520] = "Трощителі Відданого Вісника"
    t[182521] = "Поножі Обов'язком Зв'язаного Передвісника"
    t[182522] = "Наплічники Відданого Вісника"
    t[182523] = "Бойовий Пояс Відданого Вісника"
    t[182524] = "Наручі Відданого Вісника"
    t[182525] = "Великий Плащ Відданого Вісника"
    t[182526] = "Лик Примари, Відданої Обов'язку"
    t[182527] = "Камзол Примари, Відданої Обов'язку"
    t[182528] = "Чоботи Примари, Відданої Обов'язку"
    t[182529] = "Душителі Примари, Відданої Обов'язку"
    t[182530] = "Штани Обов'язком Зв'язаного Привида"
    t[182531] = "Наплічники Примари, Відданої Обов'язку"
    t[182532] = "Пояс Примари, Відданої Обов'язку"
    t[182533] = "Наручі Примари, Відданої Обов'язку"
    t[182534] = "Плащ Примари, Відданої Обов'язку"
    t[182535] = "Каптур Відданого Закликача"
    t[182536] = "Туніка Відданого Закликача"
    t[182537] = "Капці Відданого Закликача"
    t[182538] = "Рукавички Відданого Закликача"
    t[182539] = "Поножі Обов'язком Зв'язаного Чаклуна"
    t[182540] = "Оплічник Відданого Закликача"
    t[182541] = "Пояс Відданого Закликача"
    t[182542] = "Наручі Відданого Закликача"
    t[182543] = "Плащ Відданого Закликача"
    t[182544] = "Наличник Відданого Тактика"
    t[182545] = "Кольчуга Відданого Тактика"
    t[182546] = "Чоботи Відданого Тактика"
    t[182547] = "Латні Рукавиці Відданого Тактика"
    t[182548] = "Набедреники Обов'язком Зв'язаного Тактика"
    t[182549] = "Наплічники Відданого Тактика"
    t[182550] = "Пояс Відданого Тактика"
    t[182551] = "Наручі Відданого Тактика"
    t[182552] = "Накидка Відданого Тактика"
    t[182556] = "Плащ Тінекрила"
    t[182557] = "Темнопірний Плащ"
    t[182558] = "Сталелускатий Плащ"
    t[182559] = "Виправдання Тамплієра"
    t[182560] = "Накидка Мерехтокопитих"
    t[182561] = "Плащ Полеглого Учня"
    t[182580] = "Дзеркало Душ"
    t[182582] = "Запалений Дух"
    t[182584] = "Снага Гепарда"
    t[182585] = { name = "Щітка для Догляду", fen = "A circular motion with the stiff bristled brush removes grime and soothes itches.", fua = "Кругові рухи цією щіткою з жорсткою щетиною прибирають бруд і знімають свербіж." }
    t[182586] = "Рука Вентира з Кийком"
    t[182587] = "Обслинений Ненажерою Кий"
    t[182588] = "Закривавлена Рука"
    t[182589] = { name = "Вірний Ненажера", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182590] = { name = "Поточений Лозами Гаманець", fen = "Coins jingle, nearly falling out of the many holes.", fua = "Монети дзенькають, мало не випадаючи з численних дірок." }
    t[182591] = { name = "Вкриті Лозами Насичені Рубіни", fen = "If you can pull them out of the vines, the dredgers are always willing to trade for Infused Rubies.", fua = "Якщо вам вдасться витягти їх з лоз, копачі завжди готові виміняти насичені рубіни." }
    t[182592] = { name = "Насичений Плід Кінцетопі", fen = "Once much like a pear, the endmire has twisted it and the devourer mites flourish on it.", fua = "Колись схожий на грушу, цей плід спотворило Кінцеве багно, і тепер на ньому буяють кліщі-пожирачі." }
    t[182593] = "Різьблення Грішноскака"
    t[182594] = "Іскристе Рубінове Намисто"
    t[182595] = { name = "Міцна Підкова", fen = "Protective footwear for horse-like creatures.", fua = "Захисне взуття для конеподібних створінь." }
    t[182596] = { name = "Верескун з Валу", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182597] = { name = "Зручний Чепрак", fen = "A soft and comfortable blanket for regulating body temperature.", fua = "М'яка та зручна ковдра для регулювання температури тіла." }
    t[182598] = "Демонячий Намордник"
    t[182599] = { name = "Відро Чистої Води", fen = "Guaranteed to quench the greatest thirst.", fua = "Гарантовано вгамує найбільшу спрагу." }
    t[182600] = "Ґормлінг у Торбі"
    t[182601] = { name = "Голова Багнокулака", fen = "A head taken from Sludgefist in Castle Nathria on Normal Difficulty.", fua = "Голова, здобута від Багнокулака в Замку Натрія на Звичайному рівні складності." }
    t[182602] = { name = "Голова Багнокулака", fen = "A head taken from Sludgefist in Castle Nathria on Heroic Difficulty.", fua = "Голова, здобута зі Сладжфіста в замку Натрія на героїчній складності." }
    t[182603] = { name = "Голова Багнокулака", fen = "A head taken from Sludgefist in Castle Nathria on Mythic Difficulty.", fua = "Голова, здобута зі Сладжфіста в замку Натрія на міфічній складності." }
    t[182604] = "Ревуче Полум'я"
    t[182605] = "Тактичний Відступ"
    t[182606] = { name = "Личинка Крововоші", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[182607] = { name = "Волохате Яйце", fen = "The chirps of whatever's inside grow louder. This egg is hatching into something.", fua = "Цвірінькання того, хто всередині, дедалі гучнішає. З цього яйця хтось вилуплюється." }
    t[182608] = "Доброчесний Наказ"
    t[182609] = { name = "Прострочений Сувій", fen = "The House of Rituals takes late penalties seriously.", fua = "Дім Ритуалів серйозно ставиться до штрафів за прострочення." }
    t[182610] = "Лютий Апетит"
    t[182611] = "Феїна Флейта"
    t[182614] = { name = "Поводи Сивулі", fen = "Teaches you how to summon Sinrunner Blanchy.", fua = "Навчає вас прикликати Гріхобіжну Сивулю." }
    t[182615] = { name = "Блукаючий Фоліант", fen = "An enchanted book run amok.", fua = "Зачарована книга, що вийшла з-під контролю." }
    t[182616] = { name = "Бешкетне Перо", fen = "A magical pen that has escaped the bonds of its enchantment.", fua = "Магічне перо, що вирвалося з пут свого чару." }
    t[182617] = "Спогад про Обійми Смерті"
    t[182618] = "Повернена Посудина"
    t[182619] = { name = "Здобута Анімошишка", fen = "Glows with a soft bluish-white light.", fua = "Світиться м'яким блакитно-білим світлом." }
    t[182620] = "Порожнє Відро для Води"
    t[182621] = "Єдність зі Звіром"
    t[182622] = "Осяйне Світло"
    t[182623] = "Дзеркало Душ"
    t[182624] = "Демонстрація Сили"
    t[182625] = "Спогад про Вічну Хватку"
    t[182626] = "Спогад про Жахоферомони"
    t[182627] = "Спогад про Надштам"
    t[182628] = "Спогад про Бріндаора"
    t[182629] = "Спогад про Багряні Руни"
    t[182630] = "Спогад про Панування Ґорфіенда"
    t[182631] = "Спогад про Вампірську Ауру"
    t[182632] = "Спогад про Абсолютний Нуль"
    t[182633] = "Спогад про Пекучий Холод"
    t[182634] = "Спогад про Лють Замерзлого Чемпіона"
    t[182635] = "Спогад про Колтіру"
    t[182636] = "Спогад про Найсмертельніший Виток"
    t[182637] = "Спогад про Невідворотність Смерті"
    t[182638] = "Спогад про Несамовите Чудовисько"
    t[182639] = { name = "Позолочений Ключ-Череп", fen = "Unlocks the gate to Kivarr's cage.", fua = "Відмикає браму до клітки Ківарра." }
    t[182640] = "Спогад про Воскреслого Тинялу"
    t[182641] = { name = "Осяйний Срібний Ключ", fen = "Unlocks the gate to Kivarr's cage.", fua = "Відмикає браму до клітки Ківарра." }
    t[182642] = { name = "Крилатий Арканум", fen = "A treatise on the magic of Bastion and the kyrian.", fua = "Трактат про магію Бастіону та кіріанів." }
    t[182643] = { name = "Шляхи Перших", fen = "An eldritch tome, rife with speculation about the precursors to the rulers of the Shadowlands.", fua = "Моторошний фоліант, сповнений припущень про попередників володарів Тінокраю." }
    t[182644] = { name = "Вищі Обереги та Бар'єри, Том IV", fen = "A pedantic volume of spells and counterspells.", fua = "Прискіпливий том заклять і контрзаклять." }
    t[182645] = { name = "Узи Вигнанця", fen = "An ancient, dusty tome describing the trials of a figure known as \"The Banished One.\"", fua = "Стародавній запорошений фоліант, що описує випробування постаті, відомої як \"Вигнанець\"." }
    t[182646] = "Повторний Указ"
    t[182647] = { name = "Шпичак з Рунокаменем", fen = "The stone was found in the chest of an unfortunate possessed fae.", fua = "Камінь знайшли в грудях нещасного одержимого фейрі." }
    t[182648] = "Зосередження Влучного Стрільця"
    t[182649] = "Жорстокі Снаряди"
    t[182650] = { name = "Деревний Ковтач", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182651] = "Руйнівні Відлуння"
    t[182653] = "Ласощі для Ларіона"
    t[182654] = { name = "Кістописні Депеші", fen = "The movements of the Maldraxxi invaders would be of great important to Malcorn Caliga at the Theater of Pain in Maldraxxus.", fua = "Пересування малдраксійських загарбників матиме велике значення для Малкорна Каліґи в Театрі Болю в Малдраксусі." }
    t[182656] = "Порушення Спокою"
    t[182657] = "Смертоносний Ланцюг"
    t[182658] = { name = "Оплічник Вічної Перемоги", fen = "Once a part of the Primus' armor, this mantle is still filled with power.", fua = "Колись частина обладунку Примуса, цей оплічник досі сповнений сили." }
    t[182659] = { name = "Нічна Лілія", fen = "The strong scent has an intense calming quality.", fua = "Сильний аромат має потужну заспокійливу властивість." }
    t[182660] = { name = "Рецепт: Тіньокамінь", fen = "Teaches you how to transmute Shadestone.", fua = "Навчає вас перетворювати Тіньокамінь." }
    t[182661] = { name = "Гриб-Веселун", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[182662] = { name = "Листолюб", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[182663] = { name = "Корінчик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[182664] = { name = "Стеблик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[182665] = { name = "Рецепт: Гріхи на Чесноту", fen = "Teaches you how to transmute Sins to Virtue.", fua = "Навчає вас перетворювати Гріхи на Чесноту." }
    t[182666] = { name = "Формула: Зачарований Злиток Елетію", fen = "Teaches you how to craft an Enchanted Elethium Bar.", fua = "Навчає вас створювати Зачарований Злиток Елетію." }
    t[182667] = "Сфокусоване Світло"
    t[182668] = { name = "Рецепт: Бенкет Ненаситного Гедонізму", fen = "Teaches you how to craft a Feast of Gluttonous Hedonism.", fua = "Навчає вас готувати Бенкет Ненаситного Гедонізму." }
    t[182671] = { name = "Рунолитий Стрибун", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[182672] = { name = "Туманний Стрибун", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[182673] = { name = "Накопичувач з Мерехтливих Віт", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[182674] = { name = "Сер Реджинальд", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[182675] = "Незагартована Відданість"
    t[182676] = { name = "Серце Запиналокрила", fen = "A source of great magical power, particularly useful in necromantic rituals.", fua = "Джерело великої магічної сили, особливо корисне в некромантських ритуалах." }
    t[182677] = "Покарати Винних"
    t[182678] = { name = "Цілий Жмут Спор", fen = "Often burned as incense to aid in concentration during intense rituals.", fua = "Часто палять як пахощі, щоб сприяти зосередженню під час напружених ритуалів." }
    t[182679] = { name = "Згорток Реагентів", fen = "Contains various supplies for Kel'Thuzad's ritual.", fua = "Містить різноманітне приладдя для ритуалу Кел'Тузада." }
    t[182681] = "Мстивий Шок"
    t[182682] = "Посвідчення Читача Бібліотеки"
    t[182684] = "Непохитний Захисник"
    t[182685] = "Посилена Пильність"
    t[182686] = "Потужна Точність"
    t[182687] = "Здоровило-Гамселило"
    t[182688] = "Шифр Затуманення"
    t[182689] = "Рапіра Безстрашного"
    t[182690] = "Позолочений Моргенштерн Хрестоносця"
    t[182691] = "Головоруб Темного Крила"
    t[182692] = { name = "Ікло Вентира", fen = "More of a metaphysical metaphor than a practical biological component.", fua = "Радше метафізична метафора, ніж практичний біологічний складник." }
    t[182693] = "Нотатки Зниклого Учня"
    t[182694] = "Стильна Чорна Парасолька"
    t[182695] = { name = "Потерта Фіолетова Парасолька", fen = "It looks like it has been through a few perilous flights, but still can block the sun and rain.", fua = "Схоже, вона пережила кілька небезпечних польотів, але досі захищає від сонця й дощу." }
    t[182696] = "Парасолька Графині"
    t[182697] = { name = "Запасна Стильна Парасолька", fen = "Parasols are always in fashion in Revendreth, I am sure you can find someone willing to buy such a stylish one.", fua = "Парасольки в Ревендреті завжди в моді, тож ви напевно знайдете охочого придбати таку стильну." }
    t[182702] = { name = "Флакон Чорного Барвника з Багна", fen = "Can be used to alter the color of dredger clothing.", fua = "Можна використати, щоб змінити колір одягу копача." }
    t[182703] = { name = "Булькотливий Червоний Барвник з Багна", fen = "Can be used to alter the color of dredger clothing.", fua = "Можна використати, щоб змінити колір одягу копача." }
    t[182704] = { name = "Зелений Барвник з Багна", fen = "Can be used to alter the color of dredger clothing.", fua = "Можна використати, щоб змінити колір одягу копача." }
    t[182705] = { name = "Фіал Синьої Багнистої Барви", fen = "Can be used to alter the color of dredger clothing.", fua = "Можна використати, щоб змінити колір одягу копача." }
    t[182706] = "Похмурий Ставок"
    t[182707] = "Викинуті Обмотки для Рук"
    t[182708] = "Різьблений Дерев'яний Захист Зубаня"
    t[182709] = "Чепурні Напівштани"
    t[182710] = { name = "Пухнастий Халат", fen = "To look cool walking into the ring.", fua = "Щоб круто виглядати, виходячи на ринг." }
    t[182711] = { name = "Свисток Оголошувача Переможців", fen = "Not too sturdy, but good for five bouts!", fua = "Не надто міцний, але вистачить на п'ять боїв!" }
    t[182712] = { name = "Копача Камзол з Короткими Рукавами", fen = "Can be given to Dredger Assistant to allow the short sleeve doublet option.", fua = "Можна віддати помічнику-копачу, щоб відкрити варіант камзола з короткими рукавами." }
    t[182713] = { name = "Розмитий Водою Лист", fen = "Was it sad? Or just rain...", fua = "Це був сум? Чи просто дощ..." }
    t[182714] = { name = "Згорток Листівок", fen = "\"Do your part in the anima drought, 10 ways to still guarantee your tithe...\"", fua = "\"Зроби свій внесок у часи нестачі аніми: 10 способів усе одно гарантувати свою десятину...\"" }
    t[182715] = { name = "Порожній Ящик", fen = "The contents are missing.", fua = "Вмісту бракує." }
    t[182716] = "Сумка Гінця"
    t[182717] = { name = "Гріхоторкнутий Смертохід", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182718] = { name = "Аркуш Марок Кам'янородженого Гінця", fen = "Notable Venthyr faces grace the page.", fua = "Сторінку прикрашають обличчя видатних вентирів." }
    t[182719] = "Чоботи Листоноші"
    t[182720] = "Туніка Листоноші"
    t[182721] = "Рукавиці Листоноші"
    t[182722] = "Кашкет Листоноші"
    t[182723] = "Наплічники Листоноші"
    t[182724] = "Пояс Листоноші"
    t[182725] = "Наручі Листоноші"
    t[182726] = { name = "Лист Наджі", fen = "To: Dimwiddle - Darkhaven", fua = "Кому: Дімвідл - Темна Гавань" }
    t[182727] = { name = "Протікаючий Пакунок", fen = "To: Ta'tru - Barter- Night Market - Revendreth - Shadowlands *Perishable", fua = "Кому: Та'тру - Мінова Торгівля - Нічний Ринок - Ревендрет - Тіньокрай *Швидкопсувне" }
    t[182728] = { name = "Ящик Руди Сінвіру", fen = "To: Gibbo - Old Gate - Recurring", fua = "Кому: Ґіббо - Стара Брама - Регулярно" }
    t[182729] = "Дужий Драконячий Плюмаж"
    t[182730] = "Набрякла Насінина Аніми"
    t[182731] = "Торбинка Кулексового Дерева"
    t[182732] = { name = "Некроном-ням-нікон", fen = "A foreboding, gluttonous presence can be felt flipping through the pages of this tome.", fua = "Гортаючи сторінки цього фоліанта, відчуваєш зловісну, ненажерливу присутність." }
    t[182733] = "Погризені Анімажолуді"
    t[182734] = { name = "Різні Дивовижі", fen = "Interesting bits and baubles from the Brokers' stock.", fua = "Цікаві дрібнички та витребеньки з товарів посередників." }
    t[182736] = "Накотлива Агонія"
    t[182737] = { name = "Смажені Крильця Серафима", fen = "Prepared for easy access in battles when you can get a moments respite.", fua = "Приготовані так, щоб ними було легко підкріпитися в бою, коли випаде мить перепочинку." }
    t[182738] = "Згорток Контрабандних Деталей Парасолі"
    t[182739] = "Кольчужний Пояс Із Пряжкою"
    t[182740] = "Латний Пояс Із Пряжкою"
    t[182741] = "Тканинний Пояс Із Пряжкою"
    t[182742] = "Шкіряний Пояс Із Пряжкою"
    t[182743] = "Зосереджена Злоба"
    t[182744] = { name = "Оздоблена Пряжка Пояса", fen = "The buckle is in perfect shape. Maybe someone in Wanecrypt Hill can help you create a new belt with it.", fua = "Пряжка в ідеальному стані. Можливо, хтось на Згубному Пагорбі допоможе вам зробити з неї новий пояс." }
    t[182745] = "Великий Аквамариновий Кристал"
    t[182746] = { name = "Універсальний Набір для Ремонту Поясів", fen = "Complete with cord, leather strap, chain or plates for all belt types and buckle sizes.", fua = "Укомплектований шнуром, шкіряним ремінцем, ланцюжком і пластинами для всіх видів поясів і розмірів пряжок." }
    t[182747] = "Висушлива Стріла"
    t[182748] = "Породження Крові"
    t[182749] = "Відригнуті Кіріанські Крила"
    t[182750] = "Хижі Переслідувачі"
    t[182751] = "Душа Тирана"
    t[182752] = "Загін Скверни"
    t[182753] = "Королівський Указ"
    t[182754] = "Підступне Спустошення"
    t[182755] = "Попелясті Рештки"
    t[182756] = "Срібний Крилатий Бюст"
    t[182757] = "Срібний Набір Ределавів"
    t[182758] = "Декоративний Кинджал зі Сінсталі"
    t[182759] = "Робоче Ядро Аніми"
    t[182760] = "Осяйна Лазурова Сфера"
    t[182761] = "Очищений Золотий Злиток"
    t[182762] = "Вигадливо Оздоблений Самоцвітами Амулет"
    t[182763] = "Величезний Нефритовий Кулон"
    t[182764] = "Пульсівний Зоряний Аметист"
    t[182765] = { name = "Золотий Кропив'янок", fen = "An intricately carved statuette.", fua = "Майстерно вирізьблена статуетка." }
    t[182766] = "Золоте Яйце"
    t[182767] = "Довге Літо"
    t[182768] = "Зачарований Дракон"
    t[182769] = "Двигун Згоряння"
    t[182770] = "Праведна Міць"
    t[182771] = "Мерехтливий Патрач"
    t[182772] = "Пекельне Тавро"
    t[182773] = "Камінь Повернення Некролорда"
    t[182774] = { name = "Чаша Пакту Ренаґала", fen = "Sealing the most powerful in his kingdom to his will, Renagal attracted much more attention than he ever desired.", fua = "Підкоривши своїй волі наймогутніших у своєму королівстві, Ренаґал привернув до себе значно більше уваги, ніж будь-коли бажав." }
    t[182775] = { name = "Позолочені Поводи Тераманіка", fen = "Gertainig was known as a terror on the battlefield atop Teramanik, yet the treatment his mount endured was horrific, and no one was suprised when Gertainig was found with his neck 'tangled' in Teramanik's reins.", fua = "Ґертаніґ був грозою бойовища верхи на Тераманіку, та поводився зі своїм скакуном так жахливо, що ніхто не здивувався, коли Ґертаніґа знайшли із шиєю, 'заплутаною' в поводах Тераманіка." }
    t[182776] = { name = "Ритуальний Кинджал Демолтрова", fen = "The profane rites Demoltrov performed before each of his kills ate at his soul until he led only a half-life and was finally dispatched.", fua = "Блюзнірські обряди, що їх Демолтров чинив перед кожним убивством, поїдали його душу, аж доки він не став ледь живим і його врешті не порішили." }
    t[182777] = "Освячена Прозорливість"
    t[182778] = "Дзвінка Ясність"
    t[182779] = { name = "Згорток \"Змінених\" Реагентів", fen = "Contains various supplies for Kel'Thuzad's ritual. Tainted by Balmedar to cause his ritual to fail.", fua = "Містить різноманітне приладдя для ритуалу Кел'Тузада. Зіпсоване Бальмедаром, щоб провалити його ритуал." }
    t[182780] = "Казан із Багнистої Калюжі"
    t[182797] = "Правила Кулачного Рингу"
    t[182890] = "Перо Швидкого Декламування"
    t[182954] = { name = "Ґаргон Інквізиції", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[182955] = "Шифр Послаблення"
    t[182956] = { name = "Руна Полювання на Посередників", fen = "A rune that has the ability to detect nearby brokers.", fua = "Руна, здатна виявляти посередників поблизу." }
    t[182957] = "Ключ Інквізитора Від Склепу"
    t[182958] = { name = "Нічний Корінь", fen = "A potent and invasive plant commonly found within lands blighted by the Drust.", fua = "Сильна й загарбницька рослина, що часто трапляється в землях, отруєних друстами." }
    t[182960] = "Десятина Душ"
    t[182961] = "Фатальне Винищення"
    t[182962] = "Катастрофічне Походження"
    t[182963] = { name = "Сумка Відьми", fen = "A bag filled with reagents and focus objects for use in Drust rituals.", fua = "Торбина, повна реагентів і фокусувальних предметів для ритуалів друстів." }
    t[182964] = "Пожирач Душ"
    t[182965] = "Дзеркало Душ"
    t[182966] = { name = "Зламаний Спис", fen = "The splintered remains of Ara'lon's spear.", fua = "Розтрощені рештки списа Ара'лона." }
    t[182967] = { name = "Дуплет Копача з Довгими Рукавами", fen = "Can be given to Dredger Assistant to allow the long sleeve doublet option.", fua = "Можна віддати Копачу-Помічнику, щоб розблокувати варіант дуплета з довгими рукавами." }
    t[182968] = { name = "Плечова Кістка", fen = "You found this...", fua = "Ви знайшли це..." }
    t[182969] = "Дзеркало Душ"
    t[182970] = { name = "Портрет Облізлого", fen = "Can be given to Dredger Assistant to allow the greasy Igor hair cut.", fua = "Можна віддати Копачу-Помічнику, щоб розблокувати масну зачіску в стилі Ігоря." }
    t[182971] = { name = "Портрет Фабіуса", fen = "Can be given to Dredger Assistant to allow the lushesly full hair cut.", fua = "Можна віддати Копачу-Помічнику, щоб розблокувати пишну зачіску." }
    t[182972] = { name = "Портрет Звірятка Дводума", fen = "Can be given to Dredger Assistant to allow the spikey hair cut.", fua = "Можна віддати Копачу-Помічнику, щоб розблокувати колючу зачіску." }
    t[182973] = { name = "Шкіряний Каптур Копача", fen = "Gift to your Dredger Butler to give him the option of wearing a hat.", fua = "Подаруйте своєму Копачу-Дворецькому, щоб дати йому змогу носити капелюх." }
    t[182974] = "Флейта Ріверблоссом"
    t[182975] = "Поклик Вознесіння: Міканікос"
    t[182976] = "Універсальний Пояс на Подвійному Ланцюгу"
    t[182977] = "Браслети Заблудлої Гордині"
    t[182978] = "Зап'ясні Обмотки з Плетеної Кори"
    t[182979] = "Капці Забутого Єретика"
    t[182980] = "Лиховісна Маска Садиста"
    t[182981] = "Поножі Смертельного Відлуння"
    t[182982] = "Наручі Пильного Арбалетника"
    t[182983] = { name = "Чоботи Прислужника Кам'яної Варти", fen = "Both of these greaves are fitted for the left foot.", fua = "Обидва ці поножі припасовані до лівої ноги." }
    t[182984] = "Колосальні Латні Рукавиці"
    t[182985] = "Набедреники, Сповнені Спогадів"
    t[182986] = "Хламида Головного Ката"
    t[182987] = "Нагрудник Обачного Розрахунку"
    t[182988] = "Патронташ Мисливця-Майстра"
    t[182989] = "Корсет Спритного Дуелянта"
    t[182990] = "Закривавлені Чоботи Легіонера"
    t[182991] = "Латні Рукавиці Присяжного Воїна"
    t[182992] = "Поножі Нескінченної Ненажерливості"
    t[182993] = "Кажанячі Поножі"
    t[182994] = "Еполети Нездоланної Сили"
    t[182995] = "Зітканий Чарами Джгут"
    t[182996] = "Кольчуга Похмурого Переслідувача"
    t[182997] = "Діадема Владного Прагнення"
    t[182998] = "Роба Проклятого Командос"
    t[182999] = "Нагрудник Розлюченого Велетня"
    t[183000] = "Виснажливий Кольчужний Панцир"
    t[183001] = "Шолом Невситимого Апетиту"
    t[183002] = "Церемоніальні Парадні Поножі"
    t[183003] = "Наплічники Фатальної Невідворотності"
    t[183004] = "Тіньоспотворений Пояс"
    t[183005] = "Збруя Необачного Кулачника"
    t[183006] = "Окуті Каменем Чоботи"
    t[183007] = "Рукавиці Вбивці Похмурокрилих"
    t[183008] = "М'які Рукавички Прохача"
    t[183009] = "Вкрита Міазмами Безрукавка"
    t[183010] = "Подряпані Шипами Чоботи"
    t[183011] = "Костюмні Штани Придворного"
    t[183012] = "Поножі Загадкових Енергій"
    t[183013] = "Латні Рукавиці Полеглого Тамплієра"
    t[183014] = "Кольчужні Рукавиці Кастеляна"
    t[183015] = "Пута Спотворених Бажань"
    t[183016] = "Вантажний Пояс"
    t[183017] = "Оксамитові Наручі Послушника"
    t[183018] = "Наручі Пекельного Хорта"
    t[183019] = "Точно Відкалібрований Хронометр"
    t[183020] = "Шаль Покаянника"
    t[183021] = "Улюблений Кашкет Повірника"
    t[183022] = "Неймовірно Завеликі Рукавиці"
    t[183023] = "Блискотливі Скляні Капці"
    t[183024] = "Нестійкі Тіньозшиті Поножі"
    t[183025] = "Пояс Незворушного Вартового"
    t[183026] = "Рукавички Примарних Тіней"
    t[183027] = "Поножі Заблудлого Хрестоносця"
    t[183028] = "Пояс Нескінченної Тісноти"
    t[183029] = "Горже Лиховісного Фланкувальника"
    t[183030] = "Зачаровані Танцювальні Черевики"
    t[183031] = "Каменеоковані Наручі Солдата"
    t[183032] = "Герб Генерала-Легіонера"
    t[183033] = "Оплічник Явлених Гріхів"
    t[183034] = "Плащ із Кажанячих Крил з Каптуром"
    t[183035] = "Перстень-Печатка Палкої Сонцезорі"
    t[183036] = "Найцарственіший Перстень-Печатка Сіра Денатріуса"
    t[183037] = { name = "Заповітний Перстень Ритуалістки", fen = "Looking upon this ring causes your heart to tremble.", fua = "Погляд на цей перстень змушує ваше серце тремтіти." }
    t[183038] = "Гіперсвітляний Перстень"
    t[183039] = "Амулет Дворянина з Каменем Народження"
    t[183040] = { name = "Амулет Вічної Зими", fen = "A chill wind whistles through the chain of this amulet.", fua = "Холодний вітер свистить крізь ланцюжок цього амулета." }
    t[183041] = { name = "Просякнутий Анімою Шовк", fen = "The thread is delicate and shimmers with a soft glow.", fua = "Нитка ніжна й мерехтить м'яким сяйвом." }
    t[183042] = { name = "Колосальне Ядро Сили", fen = "A pulsing crystal which seems to contain thousands of barely audible souls, screaming for release.", fua = "Пульсуючий кристал, що, здається, містить тисячі ледь чутних душ, які волають про звільнення." }
    t[183044] = "Підступність Кілроґа"
    t[183045] = "Заспокійливий Ціпок Корінни"
    t[183047] = { name = "Душа Темнопса", fen = "This negative space stonework etching of a great beast speaks to the soul on a primal level.", fua = "Це різьблення великого звіра в негативному просторі звертається до душі на первинному рівні." }
    t[183048] = { name = "Міць Темнопса", fen = "This dark image of a trio of darkhounds baying in the moonlight is compelling for reasons you do not quite understand.", fua = "Це похмуре зображення трійці темнопсів, що виють у місячному світлі, ваблить вас із причин, яких ви до кінця не розумієте." }
    t[183049] = { name = "Хитрість Зграї", fen = "The ferocious nature of these beasts that is captured by master Ventarin's original piece is never replicated by copies.", fua = "Люту вдачу цих звірів, схоплену в оригіналі майстра Вентаріна, не відтворила жодна копія." }
    t[183050] = { name = "Тумани Краєтрясовини", fen = "Flaking green paint reveals this sculpture, which is thought to be a rebuke of the wastes streaming into the Endmire, to be a fake.", fua = "Облуплена зелена фарба викриває цю скульптуру, яку вважають докором відходам, що стікають у Краєтрясовину, як підробку." }
    t[183051] = { name = "Навальний Приплив", fen = "Many reproductions of this wave of liquid anima poised to drown a village have been produced, but none have the vibrancy of the original.", fua = "Зроблено чимало відтворень цієї хвилі рідкої аніми, що готова поглинути село, та жодне не має жвавості оригіналу." }
    t[183052] = { name = "Твердопанцирник Темної Нори", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[183053] = { name = "Сутінковий Серпоріг", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[183054] = "Таємниче Дзеркало Душ"
    t[183055] = { name = "Кишеньковий Годинник Вентирів на Ланцюжку", fen = "Aeons lose meaning when you have eternity to absolve your assignment, but a distinguished presentation is truly timeless.", fua = "Еони втрачають сенс, коли маєш вічність на відпущення своїх обов'язків, та вишукана подача воістину позачасова." }
    t[183056] = { name = "Верескокрил, від Крентіса", fen = "A favorite of budding forgery artists, this painting conveys the majesty of Castle Nathria's blind sentinel.", fua = "Улюблена в початківців-фальсифікаторів, ця картина передає велич сліпого вартового Замку Натрія." }
    t[183060] = "Скриня Мук"
    t[183062] = { name = "Осяйна Репліка Партаннаса", fen = "Tales amongst the dredgers tell of how Partannas, the living axe whose fury struck down invaders of the Light, was lost long ago to the Maw.", fua = "У переказах копачів мовиться, як Партаннас, жива сокира, чия лють вражала загарбників Світла, був давно втрачений у Пащі." }
    t[183064] = { name = "Самоцвіт Опантрісс", fen = "A pair of wicked souls are condemned to dance with each other in this orb until released by their absolver.", fua = "Пара лихих душ приречена танцювати одна з одною в цій кулі, доки їх не звільнить їхній відпускач гріхів." }
    t[183065] = { name = "Сліпучий Цирконовий Куб", fen = "All of the appearance of wealth with none of the risks of financial loss.", fua = "Уся видимість багатства без жодного ризику фінансових втрат." }
    t[183071] = { name = "Щаслива Підкова Грішноскака", fen = "Amongst the venthyr, superstition is considered a vice rather than a sin.", fua = "Серед вентирів забобони вважаються радше пороком, ніж гріхом." }
    t[183072] = { name = "Флакони Парфумів", fen = "The attractiveness of the fragrance is secondary to simply avoiding smelling like a Dredger.", fua = "Принадність аромату вторинна, головне — просто не пахнути, як копач." }
    t[183073] = { name = "Королівський Кухонний Набір із Грішвіру", fen = "A favorite choice of gift-givers, the perfect complement to dishes and flatware that are simply too nice to use is a full set of lavish, never-utilized cookware.", fua = "Улюблений вибір дарувальників: повний набір розкішного, ніколи не вживаного кухонного начиння — ідеальне доповнення до страв і столових приборів, які просто надто гарні, щоб ними користуватися." }
    t[183074] = "Загублена Шишка Аніми"
    t[183075] = { name = "Примарне Маскарадне Вбрання", fen = "Enchantments ensure this mask is always perfect for any occasion at the Ember Court.", fua = "Чари роблять цю маску завжди ідеальною для будь-якої нагоди при Жариновому Дворі." }
    t[183076] = "Диявольський Кривавий Камінь"
    t[183077] = "Випробуваний у Боях Ніж"
    t[183078] = "Випробуваний у Боях Трощитель"
    t[183079] = "Випробуваний Боєм Костур"
    t[183080] = "Випробуваний у Боях Короткий Меч"
    t[183081] = "Випробуваний у Бою Арбалет"
    t[183082] = "Випробувана в Бою Чарівна Паличка"
    t[183083] = "Випробуваний Боєм Дворучний Меч"
    t[183084] = "Випробуваний у Бою Оплот"
    t[183085] = "Випробуваний у Бою Фоліант"
    t[183086] = "Випробувана у Боях Бойова Глефа"
    t[183087] = "Випробуваний у Боях Довгий Меч"
    t[183088] = "Випробуваний у Боях Кинджал"
    t[183089] = "Випробуваний у Боях Чароклинок"
    t[183090] = "Випробуваний Боєм Посох"
    t[183091] = "Життєтканий Браслет"
    t[183093] = { name = "Техніка: Контракт: Дике Полювання", fen = "Teaches you how to craft a Contract: The Wild Hunt.", fua = "Навчає вас укладати Контракт: Дике Полювання." }
    t[183094] = { name = "Креслення: Шолом із Тіньосталі", fen = "Teaches you how to craft a Shadowsteel Helm.", fua = "Навчає вас виготовляти Шолом із Тіньосталі." }
    t[183095] = { name = "Креслення: Наплічники з Тіньосталі", fen = "Teaches you how to craft Shadowsteel Pauldrons.", fua = "Навчає вас виготовляти Наплічники з Тіньосталі." }
    t[183096] = { name = "Формула: Священна Скалка", fen = "Teaches you how to convert an Eternal Crystal into Sacred Shards.", fua = "Навчає вас перетворювати Вічний Кристал на Священні Скалки." }
    t[183097] = { name = "Креслення: PHA7-YNX", fen = "Teaches you how to craft a PHA7-YNX.", fua = "Навчає вас виготовляти PHA7-YNX." }
    t[183098] = { name = "Техніка: Кодекс Спокійного Розуму", fen = "Teaches you how to craft a Codex of the Still Mind.", fua = "Навчає вас виготовляти Кодекс Спокійного Розуму." }
    t[183099] = { name = "Креслення: Відживлюючий Самоцвітний Дуплет", fen = "Teaches you how to craft a Revitalizing Jewel Doublet.", fua = "Навчає вас виготовляти Відживлюючий Самоцвітний Дуплет." }
    t[183100] = { name = "Викрійка: Важкий Набір Спустошеної Броні", fen = "Teaches you how to craft a Heavy Desolate Armor Kit.", fua = "Навчає вас виготовляти Важкий Набір Спустошеної Броні." }
    t[183101] = { name = "Викрійка: Плащ із Тіньового Мережива", fen = "Teaches you how to craft a Shadowlace Cloak.", fua = "Навчає вас виготовляти Плащ із Тіньового Мережива." }
    t[183102] = { name = "Техніка: Контракт: Двір Жнеців", fen = "Teaches you how to craft a Contract: Court of Harvesters.", fua = "Навчає вас укладати Контракт: Двір Жнеців." }
    t[183103] = { name = "Техніка: Контракт: Піднесені", fen = "Teaches you how to craft a Contract: The Ascended.", fua = "Навчає вас укладати Контракт: Піднесені." }
    t[183104] = { name = "Техніка: Контракт: Невмируще Військо", fen = "Teaches you how to craft a Contract: The Undying Army.", fua = "Навчає вас укладати Контракт: Невмируще Військо." }
    t[183105] = "Жезл Ката"
    t[183106] = { name = "Рецепт: Вічний Казан", fen = "Teaches you how to craft an Eternal Cauldron.", fua = "Навчає вас виготовляти Вічний Казан." }
    t[183107] = { name = "Купа Попелястого Пилу", fen = "Teaches you how to summon Char.", fua = "Навчає вас прикликати Жарину." }
    t[183109] = "Пульсівний Уламок, Позначений Порожнечею"
    t[183110] = "Мінлива Порожнеча"
    t[183111] = "Оживлена Ліктьова Кістка"
    t[183112] = "Оживлена Променева Кістка"
    t[183113] = "Згинисті Фаланги"
    t[183114] = { name = "Зап'ясток", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183115] = { name = "Баштовий Смертотарган", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183116] = { name = "Сичливий Смертотарган", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183117] = { name = "Розтинальниця", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183119] = "Посередницька Дрібничка"
    t[183120] = "Частково Перетравлена Енциклопедія"
    t[183121] = "Тренувальний Самоцвіт"
    t[183122] = "Плащ Смерті"
    t[183125] = "Бойова Медитація: Могутність"
    t[183126] = "Набір Кіріанського Коваля"
    t[183129] = "Сповнений Анімою Ловець Снів"
    t[183130] = { name = "Потойбічне Яйце", fen = "Despite being fleshy and smelling awful, it survived being in a gorm's belly.", fua = "Попри те, що воно м'ясисте й жахливо смердить, воно вціліло в череві ґорма." }
    t[183131] = "Стигійський Гак-Кішка"
    t[183132] = "Відлунний Поклик"
    t[183135] = "Прикликати Полеглих"
    t[183136] = "Запальний Щур Утроби"
    t[183138] = "Гострокамінь Обраних"
    t[183140] = "Ріг Хмароходця"
    t[183141] = "Стигійська Магма"
    t[183143] = "Спадковий Нагрудник"
    t[183144] = "Спадковий Шолом"
    t[183145] = "Спадкові Наплічники"
    t[183146] = "Спадковий Плащ"
    t[183147] = "Спадкові Поножі"
    t[183148] = "Спадкове Намисто"
    t[183149] = "Спадковий Перстень"
    t[183150] = "Спадковий Тринкет"
    t[183159] = "Спадковий Перстень"
    t[183160] = "Спадковий Тринкет"
    t[183165] = "Арбалет Присяжних Утроби"
    t[183166] = { name = "Нідор Окуляріс", fen = "What could be more useful than \"seeing\" scents?", fua = "Що може бути кориснішим за вміння \"бачити\" запахи?" }
    t[183167] = "Сила Зграї"
    t[183184] = "Жалкий Удар"
    t[183185] = { name = "Сувій Хромі", fen = "Where did this scroll come from? Did you always have it? It's best not to worry about it.", fua = "Звідки взявся цей сувій? Він був у вас завжди? Краще про це не замислюватися." }
    t[183186] = "Очищений Нектар"
    t[183187] = "Закляття Тінеткача"
    t[183188] = { name = "Сувій Хромі", fen = "Where did this scroll come from? Did you always have it? It's best not to worry about it.", fua = "Звідки взявся цей сувій? Він був у вас завжди? Краще про це не замислюватися." }
    t[183189] = "Ілюзія: Невмирущий Дух"
    t[183190] = "Шифр Ублйона"
    t[183191] = { name = "Плазун Пащі", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183192] = { name = "Несамовитий Пащурощур", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183193] = { name = "Глек Попелу", fen = "Teaches you how to summon an Ashen Chomper.", fua = "Навчає тебе викликати попелястого жуйку." }
    t[183194] = { name = "Переслідувач Пащі", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183195] = { name = "Причаєнець Торгаста", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183196] = { name = "Лавандовий Гризун", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183197] = "Контрольоване Руйнування"
    t[183199] = "Висушлива Земля"
    t[183202] = "Смертоносний Тандем"
    t[183203] = "Величезний Окссейновий Кухоль"
    t[183204] = "Підручник Кісткозгинання"
    t[183205] = "Латний Бойовий Ріг"
    t[183207] = "Пам'ятка Першого Конфлікту"
    t[183208] = "Звірі, і Як Їх Їсти: Том I"
    t[183209] = "Найвища Печатка Каральника"
    t[183210] = "Спогад про Скверне Бомбардування"
    t[183211] = "Спогад про Годину Темряви"
    t[183212] = "Спогад про Медальйон Темнозора"
    t[183213] = "Спогад про Колективну Муку"
    t[183214] = "Спогад про Теорію Хаосу"
    t[183215] = "Спогад про Хаотичне Осердя Скверни"
    t[183216] = "Спогад про Пекучу Рану"
    t[183217] = "Спогад про Мою Темнішу Натуру"
    t[183218] = "Спогад про Зміцнене Скверне Полум'я"
    t[183219] = "Спогад про Вогняну Душу"
    t[183220] = "Спогад про Осквернення Разеліха"
    t[183221] = "Спогад про Дух Темного Полум'я"
    t[183222] = "Спогад про Старійшину-Друїда"
    t[183223] = "Спогад про Коло Життя і Смерті"
    t[183224] = "Спогад про Напій Глибокого Зосередження"
    t[183225] = "Спогад про Лікару"
    t[183226] = "Спогад про Рівновагу Всього Сущого"
    t[183227] = "Спогад про Онета"
    t[183228] = "Спогад про Арканні Пульсари"
    t[183229] = "Спогад про Зношений Сноткач"
    t[183230] = "Спогад про Верховного Хижака"
    t[183231] = "Спогад про Дивовижу Котяче Око"
    t[183232] = "Спогад про Симетричне Око"
    t[183233] = "Спогад про Перстень Шаленства"
    t[183234] = "Спогад про Обійми, Просякнуті Люфою"
    t[183235] = "Спогад про Природний Лад"
    t[183236] = "Спогад про Урсока"
    t[183237] = "Спогад про Сплячого"
    t[183238] = "Спогад про Буйнозелену Інфузію"
    t[183239] = "Спогад про Нескінченне Зростання"
    t[183240] = "Спогад про Материнське Дерево"
    t[183241] = "Спогад про Темного Титана"
    t[183242] = "Спогад про Еонар"
    t[183243] = "Спогад про Суд Арбітра"
    t[183244] = "Спогад про Хрипіння Пащі"
    t[183245] = "Спогад про Норґаннона"
    t[183246] = "Спогад про Сефуза"
    t[183247] = "Спогад про Стійку Принаду Фантазми"
    t[183248] = "Спогад про Око Тюремника"
    t[183249] = "Спогад про Життєдайну Жертву"
    t[183250] = "Спогад про Дикий Поклик"
    t[183251] = "Спогад про Боягузливу Хитрість"
    t[183252] = "Спогад про Капканний Апарат"
    t[183253] = "Спогад про Жар Душокова"
    t[183254] = "Спогад про Грізний Наказ"
    t[183255] = "Спогад про Полум'яного Ходака"
    t[183256] = "Спогад про Бойовий Наказ Ередунською"
    t[183257] = "Спогад про Ікла Мисливця на Рилаків"
    t[183258] = "Спогад про Справжню Зосередженість Іґлталона"
    t[183259] = "Спогад про Невсипущу Варту"
    t[183260] = "Спогад про Підступність Змієлова"
    t[183261] = "Спогад про Навальні Постріли"
    t[183262] = "Спогад про Кістяні Уламки Різника"
    t[183263] = "Спогад про Отруйні Ін'єктори"
    t[183264] = "Спогад про Удари Мисливця на Рилаків"
    t[183265] = "Спогад про Гроно Пожежних Бомб"
    t[183266] = "Спогад про Владу Дисциплін"
    t[183267] = "Спогад про Розширений Потенціал"
    t[183268] = "Спогад про Моторошну Бурульку"
    t[183269] = "Спогад про Триєдиний Оберіг"
    t[183270] = "Спогад про Чародійне Бомбардування"
    t[183271] = "Спогад про Нескінченне Чародійство"
    t[183272] = "Спогад про Висмоктувальну Бурю"
    t[183273] = "Спогад про Часове Викривлення"
    t[183274] = "Спогад про Гарячкове Заклинання"
    t[183275] = "Спогад про Вогняну Бурю"
    t[183276] = "Спогад про Розплавлене Небо"
    t[183277] = "Спогад про Сонячного Короля"
    t[183278] = "Спогад про Холодний Фронт"
    t[183279] = "Спогад про Крижані Вітри"
    t[183280] = "Спогад про Уламки Криги"
    t[183281] = "Спогад про Слизьку Кригу"
    t[183282] = "Спогад про Смертельний Дотик"
    t[183283] = "Спогад про Закликача"
    t[183284] = "Спогад про Втечу від Реальності"
    t[183285] = "Спогад про Обмотки Певної Стрімкості"
    t[183286] = "Спогад про Шаохао"
    t[183287] = "Спогад про Обвуглені Пристрасті"
    t[183288] = "Спогад про Небесне Вливання"
    t[183289] = "Спогад про Стормстаута"
    t[183290] = "Спогад про Прадавні Вчення"
    t[183291] = "Спогад про Юлона"
    t[183292] = "Спогад про Захмарене Зосередження"
    t[183293] = "Спогад про Вранішню Сльозу"
    t[183294] = "Спогад про Нефритове Займання"
    t[183295] = "Спогад про Кіфера"
    t[183296] = "Спогад про Останнього Імператора"
    t[183297] = "Спогад про Зуена"
    t[183298] = "Спогад про Шаленого Взірця"
    t[183299] = "Спогад про Цикли Сонця"
    t[183300] = "Спогад про Вирок Магістрата"
    t[183301] = "Спогад про Утера"
    t[183302] = "Спогад про Цвіт Сонячного Колодязя"
    t[183303] = "Спогад про Останній Подих Мараада"
    t[183304] = "Спогад про Тінеборця"
    t[183305] = "Спогад про Шоковий Бар'єр"
    t[183306] = "Спогад про Праведний Оплот"
    t[183307] = "Спогад про Священний Сигіл"
    t[183308] = "Спогад про Вічних Королів"
    t[183309] = "Спогад про Ревного Захисника"
    t[183310] = "Спогад про Натиск Авангарду"
    t[183311] = "Спогад про Остаточний Присуд"
    t[183312] = "Спогад про Невблаганного Інквізитора"
    t[183313] = "Спогад про Бурю Світлоносця"
    t[183314] = "Спогад про Випалювальні Тіні"
    t[183315] = "Спогад про Розважливе Споглядання"
    t[183316] = "Спогад про Близнюків Сонячної Жриці"
    t[183317] = "Спогад про Небесний Стрибок"
    t[183318] = "Спогад про Ясний Розум"
    t[183319] = "Спогад про Моє Кристалічне Відображення"
    t[183320] = "Спогад про Поцілунок Смерті"
    t[183321] = "Спогад про Покаянника"
    t[183322] = "Спогад про Божественний Образ"
    t[183323] = "Спогад про Миттєву Зосередженість"
    t[183324] = "Спогад про Гармонійний Апарат"
    t[183325] = "Спогад про Архієпископа Бенедикта"
    t[183326] = "Спогад про Вічний Поклик Порожнечі"
    t[183327] = "Спогад про Псалом Болевгамування"
    t[183328] = "Спогад про Талбадара"
    t[183329] = "Спогад про Призму Тіні й Вогню"
    t[183330] = "Спогад про Сутність Бладфенга"
    t[183331] = "Спогад про Бадьорий Тіньовий Пил"
    t[183332] = "Спогад про Знак Майстра-Вбивці"
    t[183333] = "Спогад про Крихітне Отруйне Лезо"
    t[183334] = "Спогад про Зухвалого Пройдисвіта"
    t[183335] = "Спогад про Клинок Загибелі"
    t[183336] = "Спогад про Латку Присмеркохода"
    t[183337] = "Спогад про Відзнаку Золдиків"
    t[183338] = "Спогад про Прудкість"
    t[183339] = "Спогад про Прихований Мушкетон"
    t[183340] = "Спогад про Ґрінскіна"
    t[183341] = "Спогад про Талісман Підступності"
    t[183342] = "Спогад про Уламок Душі Акаарі"
    t[183343] = "Спогад про Смертоносні Тіні"
    t[183344] = "Спогад про Завершеність"
    t[183345] = "Спогад про Гнилих"
    t[183346] = "Спогад про Поклик Предків"
    t[183347] = "Спогад про Нищівні Кайдани"
    t[183348] = "Спогад про Глибоко Вкорінені Стихії"
    t[183349] = "Спогад про Камінь Глибинного Двигтіння"
    t[183350] = "Спогад про Великий Розкол"
    t[183351] = "Спогад про Елементальну Рівновагу"
    t[183352] = "Спогад про Загибель Небокрая"
    t[183353] = "Спогад про Лавове Відродження Вітромовця"
    t[183354] = "Спогад про Вітри Загибелі"
    t[183355] = "Спогад про Морозну Відьму"
    t[183356] = "Спогад про Первісні Лавові Збудники"
    t[183357] = "Спогад про Знахаря"
    t[183358] = "Спогад про Земну Гармонію"
    t[183359] = "Спогад про Джоната"
    t[183360] = "Спогад про Первісне Ядро Припливу"
    t[183361] = "Спогад про Припливний Тотем Духоходця"
    t[183362] = "Спогад про Злостивий Гнів"
    t[183363] = "Спогад про Агонію Адж'Акіра"
    t[183364] = "Спогад про Темний Удар Сакролаша"
    t[183365] = "Спогад про Поглинальний Гнів"
    t[183366] = "Спогад про Кіготь Ендерета"
    t[183367] = "Спогад про Демонічну Синергію"
    t[183368] = "Спогад про Темний Портал"
    t[183369] = "Спогад про Сигіл Вищого Закликання Вілфреда"
    t[183370] = "Спогад про Осердя Лиховісного Павука"
    t[183371] = "Спогад про Рогатий Жах"
    t[183372] = "Спогад про Похмурого Інквізитора"
    t[183373] = "Спогад про Імплозивний Потенціал"
    t[183374] = "Спогад про Жар Адж'Акіра"
    t[183375] = "Спогад про Диявольське Вбрання"
    t[183376] = "Спогад про Безум Адж'Акіра"
    t[183377] = "Спогад про Імірьярів"
    t[183378] = "Спогад про Стрибуна"
    t[183379] = "Спогад про Спотворене Дзеркало"
    t[183380] = "Спогад про Сейсмічний Відголос"
    t[183381] = "Спогад про Змучених Королів"
    t[183382] = "Спогад про Володаря Битв"
    t[183383] = "Спогад про Невгасний Удар"
    t[183384] = "Спогад про Визискувача"
    t[183385] = "Спогад про Несамовитих"
    t[183386] = "Спогад про Фуджієду"
    t[183387] = "Спогад про Смертоносця"
    t[183388] = "Спогад про Відчайдушний Захист"
    t[183389] = "Спогад про Волю Берсерка"
    t[183390] = "Спогад про Відплату"
    t[183391] = "Спогад про Стіну"
    t[183392] = "Спогад про Володаря Грому"
    t[183393] = "Спогад про Незламну Волю"
    t[183394] = "Викинутий Гримуар"
    t[183395] = { name = "Самоцвіт Руків'я Реморнії", fen = "Teaches you how to summon the Will of Remornia.", fua = "Навчає вас прикликати Волю Реморнії." }
    t[183396] = "Вливання Полум'я"
    t[183397] = "Клинок Чаклуна"
    t[183398] = { name = "Загадкова Прадавня Реліквія", fen = "There is some sort of image inside...", fua = "Усередині є якесь зображення..." }
    t[183399] = "Оплічник Ритуаліста"
    t[183400] = { name = "Аметистовий Порошок", fen = "A versatile alchemical reagent that can be used to produce a brilliant purple dye.", fua = "Універсальний алхімічний реагент, який можна використати для виготовлення яскраво-фіолетового барвника." }
    t[183401] = "Аметистова Барва"
    t[183402] = "Кровопускання"
    t[183407] = { name = "Стримана Сутність Жаху", fen = "Teaches you how to summon Dread.", fua = "Навчає вас прикликати Жах." }
    t[183408] = { name = "Невмирущий Смертотарган", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183409] = { name = "Гнильний Пащурощур", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183410] = { name = "Гострокіготь", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183412] = { name = "Шукач Смерті", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183416] = "Лівий Чобіт Листоноші"
    t[183417] = { name = "Правий Чобіт Поштового Кур'єра", fen = "Deadfoot in Wanecrypt Hill might be able to set you up with a match.", fua = "Мертвонога зі Згаслого Гробничного Пагорба, можливо, підбере вам пару." }
    t[183418] = "Чоботи Згубника Надії"
    t[183419] = "Лівий Чобіт Згубника Надії"
    t[183420] = { name = "Правий Чобіт Надієломця", fen = "Deadfoot in Wanecrypt Hill might be able to set you up with a match.", fua = "Мертвонога зі Згаслого Гробничного Пагорба, можливо, підбере вам пару." }
    t[183421] = "Чоботи Кам'яного Легіону"
    t[183422] = "Лівий Чобіт Кам'яного Легіону"
    t[183423] = { name = "Правий Чобіт Кам'яного Легіону", fen = "Deadfoot in Wanecrypt Hill might be able to set you up with a match.", fua = "Мертвонога зі Згаслого Гробничного Пагорба, можливо, підбере вам пару." }
    t[183424] = "Латана Торба з Малдраксійськими Товарами"
    t[183425] = "Черевики Дослідника"
    t[183426] = "Латана Торба з Фейськими Товарами"
    t[183427] = "Лівий Черевик Дослідника"
    t[183428] = "Латана Торба з Товарами Претендента"
    t[183429] = "Латана Торба з Вентирськими Товарами"
    t[183430] = { name = "Правий Капець Дослідника", fen = "Deadfoot in Wanecrypt Hill might be able to set you up with a match.", fua = "Мертвонога зі Згаслого Гробничного Пагорба, можливо, підбере вам пару." }
    t[183433] = "Кистень Грішного Претендента"
    t[183435] = "Серп Грішного Претендента"
    t[183436] = { name = "Оживлений Каталізатор", fen = "This goo jiggles without any outside influence. Bits of bone float within the caustic substance.", fua = "Ця слиз тремтить без жодного зовнішнього впливу. Уламки кісток плавають у їдкій речовині." }
    t[183437] = "Протиналь Грішного Гладіатора"
    t[183438] = "Редут Грішного Гладіатора"
    t[183439] = "Кристал Грішного Гладіатора"
    t[183440] = "Розсікач Грішного Гладіатора"
    t[183441] = "Бойова Глефа Грішного Гладіатора"
    t[183443] = "Жертовний Кинджал Грішного Гладіатора"
    t[183445] = "Рушниця Грішного Гладіатора"
    t[183446] = "Тесак Грішного Гладіатора"
    t[183447] = "Глефа Грішного Гладіатора"
    t[183448] = "Рубака Грішного Гладіатора"
    t[183449] = "Молоток Грішного Гладіатора"
    t[183450] = "Кровокований Ніж"
    t[183451] = "Кровокований Бар'єр"
    t[183452] = "Кровокований Фокус"
    t[183453] = "Кровокована Булава"
    t[183454] = "Кровокована Бойова Глефа"
    t[183455] = "Кровокований Посох"
    t[183456] = "Кровокований Мушкетон"
    t[183457] = "Кровокована Дворучна Сокира"
    t[183458] = "Кровокована Древкова Зброя"
    t[183459] = "Кровокований Сікач"
    t[183460] = "Кровокований Серп"
    t[183462] = "Ілюзія: Незламна Рішучість"
    t[183463] = "Неприродна Злоба"
    t[183464] = "Міцний Як Кора"
    t[183465] = "Ведмежа Снага"
    t[183466] = "Природна Рішучість"
    t[183467] = "Невтомне Переслідування"
    t[183468] = "Народжений Наново"
    t[183469] = "Вістря Зграї"
    t[183470] = "Дитя Нетрів"
    t[183471] = "Непохитна Відданість"
    t[183472] = "Розвинений Рій"
    t[183473] = "Злиття Стихій"
    t[183474] = "Нескінченна Спрага"
    t[183475] = { name = "Незборима Шкіра", fen = "Useful in the construction of an abomination.", fua = "Корисний у спорудженні гидоти." }
    t[183476] = "Зоряне Натхнення"
    t[183477] = "Точне Вирівнювання"
    t[183478] = "Лють Небес"
    t[183479] = "Тіньова Напруга"
    t[183480] = "Жага Крові"
    t[183481] = "Невпинний Мисливець"
    t[183482] = "Раптова Засідка"
    t[183483] = "Хижий Інстинкт"
    t[183484] = "Нестримна Агресія"
    t[183485] = "Дикий Боєць"
    t[183486] = "Загострені Інстинкти"
    t[183487] = "Густа Грива"
    t[183488] = "Нестримний Ріст"
    t[183489] = "Спалах Ясності"
    t[183490] = "Рослинне Відновлення"
    t[183491] = "Готовий до Всього"
    t[183492] = "Відлуння"
    t[183493] = "Раптові Тріщини"
    t[183494] = "Септичний Шок"
    t[183495] = "Батожисті Рубці"
    t[183496] = "Спритні Пальці"
    t[183497] = "Відновлювач"
    t[183498] = "Огорнутий Тінями"
    t[183499] = "Швидкі Рішення"
    t[183500] = "Розчинення в Ніщо"
    t[183501] = "Поспішне Налаштування"
    t[183502] = "Готовий до Всього"
    t[183503] = "Отруєний Катар"
    t[183504] = "Влучно Спрямована Криця"
    t[183505] = "Калічення, Шматування"
    t[183506] = "Смертельні Отрути"
    t[183507] = "Потрійна Загроза"
    t[183508] = "Дворукість"
    t[183509] = "Спритність Рук"
    t[183510] = "Зважити Шанси"
    t[183511] = "Довші Кинджали"
    t[183512] = "Запланована Страта"
    t[183513] = "Стилетне Стакато"
    t[183514] = "Продірявлені Жили"
    t[183515] = { name = "Райдужна Слизь", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183516] = "Заплямований Кісткозрослий Оплічник"
    t[183517] = { name = "Сторінка 76 Некроном-і-ном", fen = "The page is torn and old. Perhaps this would be a welcomed addition for the Necronom-i-nom.", fua = "Сторінка стара й подерта. Можливо, вона стане бажаним доповненням до Некроном-і-ном." }
    t[183518] = { name = "Двірський Грішноскак", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[183519] = { name = "Некромантська Олія", fen = "Useful in the construction of an abomination.", fua = "Корисний у спорудженні гидоти." }
    t[183520] = { name = "Зерна Дикого Нічноцвіту", fen = "These seeds grow a magical bloom that increases the yield of rewards offered by a spirit upon rebirth as well as the number of catalysts grown from catalyst seeds.", fua = "З цих зерен виростає чарівна квітка, що збільшує кількість винагород, які пропонує дух під час відродження, а також кількість каталізаторів, вирощених із зерен каталізатора." }
    t[183521] = { name = "Зерна Темпорального Листя", fen = "These seeds grow enchanted leaves that speed up the Wildseed of Regrowth process.", fua = "З цих зерен виростає зачароване листя, що пришвидшує процес дозрівання Дикого Сімені Відновлення." }
    t[183522] = { name = "Зерна Кореня Дикого Сімені", fen = "These seeds grow a special root that increases the quality of rewards offered by a spirit upon rebirth.", fua = "З цих зерен виростає особливий корінь, що підвищує якість винагород, які пропонує дух під час відродження." }
    t[183596] = { name = "Зламаний Артефакт", fen = "Not completely worthless, but not worth a lot either.", fua = "Не зовсім нікчемний, але й не надто цінний." }
    t[183597] = { name = "Печиво зі Зшитої Плоті", fen = "A favorite for constructs of all ages.", fua = "Улюблені ласощі для створінь будь-якого віку." }
    t[183600] = { name = "Частини Гидоти", fen = "A collection of various body parts used to craft Maldraxxian constructs.", fua = "Зібрання різноманітних частин тіла, що слугують для виготовлення малдраксійських конструктів." }
    t[183601] = { name = "Тремтунчик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183602] = "Липке Павутиння"
    t[183604] = "Арбалет Пронизливого Тембру"
    t[183605] = "Бойова глефа, кута Пожирачем"
    t[183606] = "Оплот Лункої Відваги"
    t[183607] = "Спис непевного претендента"
    t[183608] = "Вічнодзвінкий Вечірній Дзвін"
    t[183609] = "Переживлені Кулаки Голіафа"
    t[183610] = "Стилет Воїна-Поета"
    t[183611] = "Велике Лезо Смиренної Офелії"
    t[183612] = "Молот Вірного Чемпіона"
    t[183613] = "Виблискуючий Кинджал Світанку"
    t[183614] = "Молот Гармонійної Мудрості"
    t[183615] = { name = "Бойовозшитий Темний Гончак", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[183617] = { name = "Скрекотливий Анімокліщ", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[183618] = { name = "Темногрива Буревію", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[183619] = "Вічна Кісткокована Дворучна Сокира"
    t[183620] = { name = "Закривавлені Ікла", fen = "These tusks are made of a porous bone which almost seems to absorb liquids.", fua = "Ці ікла зроблені з пористої кістки, що, здається, мало не вбирає рідину." }
    t[183622] = "Посох Великого Рунослова"
    t[183623] = { name = "Шипопащий Гормик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[183689] = "Пов'язка Хрестоносця"
    t[183690] = "Попелясте Чорнило"
    t[183691] = "Слизовий Пігмент"
    t[183692] = "Зазублена Кісткова Пилка"
    t[183693] = "Маска Чумного Лікаря"
    t[183695] = { name = "Скалка Розпадного Темного Наару", fen = "A dark naaru is a fiercesome foe, but for the Maldraxxi, they see it as another opportunity to prove their worth in the arena.", fua = "Темний наару — грізний ворог, але для Малдраксі це просто чергова нагода довести свою гідність на арені." }
    t[183696] = "Підзорна Очна Труба"
    t[183697] = { name = "Нічна Лілія", fen = "A beautiful flower that blooms only at night.", fua = "Прекрасна квітка, що розквітає лише вночі." }
    t[183698] = { name = "Ключ Ката", fen = "With numerous, neatly aligned scatch marks along its neck it's clear someone's been busy.", fua = "За численними, охайно вишикуваними подряпинами вздовж його стрижня видно, що хтось був при роботі." }
    t[183699] = { name = "Вишукані Інгредієнти", fen = "Contains assorted herbs and beverages from the Shadowlands, courtesy of Theotar.", fua = "Містить добірні трави та напої з Тіньокраю, ласкаво надані Теотаром." }
    t[183700] = "Наплічники Забутого Закликача"
    t[183701] = { name = "Матеріали для Обряду Очищення", fen = "Contains assorted cloth and enchanting materials from the Shadowlands, courtesy of Pelagos.", fua = "Містить добірну тканину та матеріали для чарування з Тіньокраю, ласкаво надані Пелагосом." }
    t[183702] = { name = "Пишнота Природи", fen = "Contains assorted leather, fish, and meats from the Shadowlands, courtesy of Niya.", fua = "Містить добірну шкіру, рибу та м'ясо з Тіньокраю, ласкаво надані Нією." }
    t[183703] = { name = "Сумка Костоковальки", fen = "Contains assorted ore and gems from the Shadowlands, courtesy of Heirmir.", fua = "Містить добірну руду та самоцвіти з Тіньокраю, ласкаво надані Геймір." }
    t[183704] = { name = "Мінливий Дух Знання", fen = "This spirit contains the essence of a mysterious, but powerful, spirit. It has a strange aura of loneliness to it.", fua = "Цей дух містить сутність загадкового, але могутнього духа. Від нього віє дивною аурою самотності." }
    t[183705] = "Оплічник Багряних Клинків"
    t[183706] = "Оплічник Двірських Клинків"
    t[183707] = "Оплічник Полірованих Клинків"
    t[183708] = "Блискучий Ланцюг із Золотого Каменя Гріха"
    t[183709] = { name = "Камінь Гріха в Бронзовій Оправі", fen = "Stonehead thought the chain was sparkly.", fua = "Камінноголовому здалося, що ланцюжок блискучий." }
    t[183710] = "Полірований Ланцюг Каменя Гріха"
    t[183711] = "Полірований Оплічник Хранителя Склепу"
    t[183712] = "Осяйний Оплічник Хранителя Крипти"
    t[183713] = "Оплічник Склепу Кассіра"
    t[183714] = { name = "Болотяний Очерет", fen = "Teaches you how to summon a Withering Mire Creeper.", fua = "Навчає вас, як прикликати В'янучого Повзуна Багнистого Болота." }
    t[183715] = { name = "Гаргон Гріхопаду", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[183716] = { name = "Камінь Гріха Вентирів", fen = "Binding you to more than an inn.", fua = "Прив'язує тебе до чогось більшого, ніж заїзд." }
    t[183717] = { name = "Пута Добробуту", fen = "Strong bindings that create comfort and security within a construct.", fua = "Міцні пута, що дарують конструктові затишок і відчуття безпеки." }
    t[183718] = { name = "Особливо Липкий Гормослиз", fen = "Even more gooey and gross than usual. Very hard to walk through.", fua = "Ще липкіший і огидніший, ніж зазвичай. Дуже важко крізь нього пройти." }
    t[183719] = { name = "Пелюстка Гнилоцвіту", fen = "It smells so bad!", fua = "Вона так жахливо смердить!" }
    t[183720] = "Безрукавка зі Шкіри Жахокажана"
    t[183722] = { name = "Прадавня Відзнака", fen = "A pleasant warmth spreads through your body as you hold this in your hands.", fua = "Приємне тепло розливається вашим тілом, коли ви тримаєте її в руках." }
    t[183723] = "Переповнена Сфера Аніми"
    t[183724] = "Зразок Віспяної Шкіри"
    t[183725] = "Сачок для Метеликів"
    t[183727] = "Резонанс Конфлікту"
    t[183728] = { name = "Ключ Очей", fen = "Used by the House of Eyes to open innumerable locks.", fua = "Дім Очей використовує його, щоб відмикати незліченні замки." }
    t[183729] = "Заляпаний Брудом Наголовник"
    t[183730] = "Великий Шолом, Оздоблений Каменем гріхів"
    t[183731] = "Жаром Гартовані Латні Поножі"
    t[183732] = "Поножі, Скуті Каменем Гріха"
    t[183733] = { name = "Очищений Нектар", fen = "Not the best, but when you're dead this will do.", fua = "Не найкращий, але коли ти мертвий, і цей згодиться." }
    t[183735] = "Оплічник Крадія Гріхів-Відступника"
    t[183736] = "Рукавички Опору Пихатості"
    t[183737] = "Кам'яний Пояс Аатрона"
    t[183738] = "Чари Нагрудника — Вічне Прозріння"
    t[183739] = "Ендмайрські Наручні Гріли"
    t[183740] = { name = "Позолочений Никалець", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[183741] = { name = "Піднесена Небогрива", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[183742] = { name = "Проникнення Ворога - Передмова", fen = "A report written by an unknown hand. The signature upon the final page has been rendered illegible.", fua = "Звіт, написаний невідомою рукою. Підпис на останній сторінці зроблено нерозбірливим." }
    t[183743] = { name = "Податлива Плоть", fen = "Put enough together, you have a construct!", fua = "Збереш докупи достатньо — матимеш конструкта!" }
    t[183744] = { name = "Добірні Деталі", fen = "Quality limbs used to create superior constructs. Can be obtained by completing tasks for the Stitchmasters.", fua = "Якісні кінцівки, що слугують для створення кращих конструктів. Їх можна отримати, виконуючи завдання для Зшивачів." }
    t[183752] = { name = "Порожнє Барило Чарки-на-Ніч", fen = "We're there's dancing, there's sure to be Nightcap.", fua = "Де танці, там напевне знайдеться й Чарка-на-Ніч." }
    t[183754] = { name = "Конструкторські Нотатки Зшиваного", fen = "A very thorough document covering proper construct operation and maintenace.", fua = "Вельми ґрунтовний документ про належну роботу з конструктами та їхнє обслуговування." }
    t[183755] = { name = "Вінок Арденвельду", fen = "A beautiful bouquet that might add some flare to a boring construct.", fua = "Прекрасний букет, що міг би додати трохи блиску нудному конструктові." }
    t[183756] = { name = "Ширяючий Вінець", fen = "As light as a cloud, this circlet floats above the wearers head.", fua = "Легкий, мов хмаринка, цей вінець ширяє над головою власника." }
    t[183759] = { name = "Незвично Великий Череп", fen = "The skull of a devourer, large enough to cover a construct's head.", fua = "Череп пожирача, достатньо великий, щоб укрити голову конструкта." }
    t[183760] = { name = "Окуляри Вентирів", fen = "A stylish pair of glasses that could improve the look of even the ugliest construct.", fua = "Стильні окуляри, що поліпшили б вигляд навіть найпотворнішого конструкта." }
    t[183761] = "Креслення: Планер Небоходів"
    t[183786] = { name = "Пташка Щастя", fen = "A small caged bird that would be happy to ride on anyone's shoulder.", fua = "Маленька пташка в клітці, яка радо посиділа б у будь-кого на плечі." }
    t[183787] = "Стигійський Гамівник"
    t[183789] = { name = "Шестимильна Торба", fen = "A legendary pack, once owned by a Venthyr of notable leaping skills.", fua = "Легендарна торба, що колись належала вентиру з неабиякими стрибковими вміннями." }
    t[183791] = { name = "Поцуплені Матеріали", fen = "Looks like a spriggan chewed on it.", fua = "Схоже, їх погриз спріган." }
    t[183792] = { name = "Реманент Ремісника", fen = "Used for crafting fine things, unless it's in the wrong hands.", fua = "Слугує для виготовлення витончених речей, хіба що потрапить не в ті руки." }
    t[183793] = "Емпірейське Частування"
    t[183794] = "Креслення: Небесна Відсвіжа"
    t[183795] = { name = "Повідомлення про Особливу Доставку", fen = "The letter is written as if the author was in an incredible hurry, distracted, or both.", fua = "Лист написаний так, наче автор неабияк квапився, був неуважний або і те, і те водночас." }
    t[183796] = { name = "Плоть Кістколичинки", fen = "Smells as good as it looks.", fua = "Пахне так само добре, як і виглядає." }
    t[183797] = "Пов'язка Хрестоносця"
    t[183798] = { name = "Бойова Збруя Сілессі", fen = "Teaches you how to summon Battle Gargon Silessa as a mount.", fua = "Навчає вас, як прикликати Бойового Гаргона Силессу як їздового." }
    t[183799] = "Мінливий Каталізатор"
    t[183800] = { name = "Бурштиновий Арденметелик", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[183801] = { name = "Барвисте Тріпокриле", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[183805] = { name = "Спокійний Дух Космосу", fen = "This spirit contains the essence of a very powerful, yet oddly calming, spirit.", fua = "Цей дух містить сутність дуже могутнього й водночас навдивовижу заспокійливого духа." }
    t[183806] = { name = "Енергійний Дух Цікавості", fen = "This spirit contains the essence of a very powerful and curious spirit.", fua = "Цей дух містить сутність дуже могутнього та допитливого духа." }
    t[183807] = "Стигійський Примус"
    t[183811] = { name = "Найкращий Друг Конструкта", fen = "All good dogs go to Maldraxxus.", fua = "Усі добрі пси потрапляють до Малдраксусу." }
    t[183823] = "Зілля Безперешкодного Переходу"
    t[183824] = { name = "Схованка Запасної Зброї", fen = "A collection of unique weapons, that maybe usable by constructs.", fua = "Зібрання унікальної зброї, яку, можливо, зможуть використовувати конструкти." }
    t[183825] = { name = "Завеликий Монокль", fen = "A very large monocle that might fit the very large eye of a construct.", fua = "Дуже великий монокль, що міг би пасувати до дуже великого ока конструкта." }
    t[183826] = { name = "Великий Обвислий Капелюх", fen = "An out of fashion hat, stowed away where no one will see it.", fua = "Старомодний капелюх, схований там, де його ніхто не побачить." }
    t[183827] = { name = "Чорносталевий Наспинник", fen = "Armor traditional of the troops of the Blackhound outpost.", fua = "Традиційна броня вояків застави Чорного Гончака." }
    t[183828] = { name = "Дружні Комахи", fen = "Peaceful tree loving bugs.", fua = "Мирні комахи, що люблять дерева." }
    t[183829] = { name = "Слизовий Кіт", fen = "The sort of horrible creature a construct might have as a friend.", fua = "Така собі жахлива істота, яку конструкт міг би мати за друга." }
    t[183830] = { name = "Набір для Самостійного Виготовлення Прапора", fen = "Parts to create a battle flag for a construct.", fua = "Деталі для створення бойового прапора для конструкта." }
    t[183831] = { name = "Набір для Безпечного Падіння", fen = "No idea how this got here, but it could be useful!", fua = "Гадки не маю, як він тут опинився, але може стати в пригоді!" }
    t[183833] = { name = "Мішок Мотлоху Каша", fen = "A large bag of junk greatly valued by Collector Kash.", fua = "Великий мішок мотлоху, який вельми цінує колекціонер Каш." }
    t[183836] = { name = "Мерехтливий Намул", fen = "It sparkles brightly as it runs through your fingers.", fua = "Він яскраво виблискує, просочуючись крізь ваші пальці." }
    t[183837] = { name = "Королівський Торф", fen = "You can feel the life ready to burst through this soil.", fua = "Ви відчуваєте, як життя готове вирватися крізь цей ґрунт." }
    t[183839] = { name = "Викрійка: Важка Спустошена Шкіра", fen = "Teaches you how to craft a Heavy Desolate Hide.", fua = "Навчає вас, як виготовити Важку Спустошену Шкіру." }
    t[183840] = { name = "Чорнотернова Глина", fen = "Hard and crumbly", fua = "Тверда й розсипчаста." }
    t[183842] = { name = "Повід Поні-Гріхобігуна", fen = "Gift to your Dredger Butler so he can learn to ride and keep up on long treks.", fua = "Подаруйте своєму дворецькому-копачу, щоб він навчився їздити верхи й не відставати в довгих мандрівках." }
    t[183843] = { name = "Збруя Молодого Жахокажана", fen = "Gift to your Dredger Butler so that he can learn to ride a flying mount and follow when you take to the skies.", fua = "Подаруйте своєму дворецькому-копачу, щоб він навчився їздити на літунному їздовому й супроводжувати вас, коли ви здіймаєтесь у небо." }
    t[183844] = { name = "Рекомендаційний Лист, Костоковалька", fen = "Mograine doesn't waste flowery words with his succinct letter of introduction to Bonesmith Heimir.", fua = "Мограйн не марнує пишних слів у своєму стислому рекомендаційному листі до костоковальки Геймір." }
    t[183845] = { name = "Короткий Лист до Ковальки Софони", fen = "The Polemarch doesn't waste words telling Forgelite Sophone of your merits and worthiness.", fua = "Полемарх не марнує слів, розповідаючи ковальці Софоні про ваші заслуги та гідність." }
    t[183846] = { name = "Накази Гормоковалю Кавіні", fen = "Hunter Captain Korayn has drafted a dispatch for you to take to Gormsmith Cavina requesting she aid your cause.", fua = "Капітан мисливців Корейн склала депешу, яку ви маєте віднести гормоковалю Кавіні, прохаючи її допомогти вашій справі." }
    t[183847] = "Личина Послушника"
    t[183848] = { name = "Поспіхом Нашкрябана Записка для Ковальчика", fen = "Rendle pened this quick note to his friend Forgy that he thinks you should meet.", fua = "Рендл нашвидку написав цю записку своєму другові Ковальчику, з яким, на його думку, вам варто познайомитися." }
    t[183849] = "Корінь Просіювача Душ"
    t[183850] = "Листя Пробуджувача"
    t[183851] = "Уламкошок Зів'ялого Гаю"
    t[183856] = "Містична Сфера Медитації"
    t[183857] = { name = "Сила Вогню", fen = "Warms the soul.", fua = "Зігріває душу." }
    t[183858] = { name = "Креслення: Генератор Червоточин: Тіньокрай", fen = "Teaches you how to craft a Wormhole Generator: Shadowlands.", fua = "Навчає вас, як виготовити Генератор Червоточин: Тіньокрай." }
    t[183860] = { name = "Хода Смерті: Вступ до Етикету Малдраксусу", fen = "Give to your dredger butler so they can brush up on the proper way to entertain your guests from Maldraxxus.", fua = "Віддайте своєму дворецькому-копачу, щоб він опанував належний спосіб приймати ваших гостей з Малдраксусу." }
    t[183861] = { name = "Зимовий Цикл: Збірка Етикету та Притч Арденвельду", fen = "Give to your dredger butler so they can brush up on the proper way to entertain your guests from Ardenweald.", fua = "Віддайте своєму дворецькому-копачу, щоб він опанував належний спосіб приймати ваших гостей з Арденвельду." }
    t[183862] = { name = "Гідне Свято: Докладна Розповідь про Етикет Вентирів від Теотара", fen = "Give to your dredger butler so they can brush up on the proper way to entertain your guests from Revendreth.", fua = "Віддайте своєму дворецькому-копачу, щоб він опанував належний спосіб приймати ваших гостей з Ревендрету." }
    t[183863] = { name = "Правильний Шлях та Етикет для Прагнучих", fen = "Give to your dredger butler so they can brush up on the proper way to entertain your guests from Bastion.", fua = "Дайте це своєму дворецькому-копачу, щоб він освіжив знання про належний спосіб розважати ваших гостей із Бастіону." }
    t[183870] = { name = "Рецепт: Знак Майстра II", fen = "Teaches you how to craft a Crafter's Mark II.", fua = "Навчає вас створювати Знак Майстра II." }
    t[183872] = "Залишковий Смуток"
    t[183873] = { name = "Потойбічний Чайний Сервіз", fen = "A variety of blends and condiments.", fua = "Розмаїття сумішей та присмак." }
    t[183876] = "Перо Листування"
    t[183877] = { name = "Звивиста Історія", fen = "A hefty tome, light on plot.", fua = "Грубезний фоліант з кволеньким сюжетом." }
    t[183878] = { name = "Мандрівна Оповідь", fen = "A rambling plot, it has seen much of Ardenweald.", fua = "Заплутаний сюжет, вона побачила чимало Арденвельду." }
    t[183879] = { name = "Ескапістський Роман", fen = "It, er, appears to have been escaping.", fua = "Він, е-е, схоже, втікав." }
    t[183880] = { name = "Дорожній Щоденник", fen = "This book appears to be well traveled.", fua = "Схоже, ця книга чимало помандрувала." }
    t[183881] = { name = "Грайлива Історія", fen = "Not suitable for polite company.", fua = "Непридатна для пристойного товариства." }
    t[183882] = { name = "Збірка Випадкових Дрібничок", fen = "Colorful, shiny, potentially useful knickknacks, Choofa collects them all.", fua = "Барвисті, блискучі, потенційно корисні цяцьки - Чуфа збирає їх усі." }
    t[183883] = { name = "Напхана Збірка Випадкових Дрібничок", fen = "Colorful, shiny, potentially useful knickknacks, Choofa collects them all.", fua = "Барвисті, блискучі, потенційно корисні цяцьки - Чуфа збирає їх усі." }
    t[183884] = { name = "Жменя Різних Самородків", fen = "You never know when you will need just that little bit of ore, or which one...", fua = "Ніколи не знаєш, коли тобі знадобиться трохи руди, чи якої саме..." }
    t[183885] = "Запасний Мішечок Руди Сіки"
    t[183886] = { name = "Торбинка Рідкісної Руди Сіки", fen = "You never know when you will need to be ready to forge...", fua = "Ніколи не знаєш, коли треба бути готовим кувати..." }
    t[183887] = "Суйртанед, Клинок Спадкоємця"
    t[183888] = { name = "Апогейна Намистина Аніми", fen = "Return this bead of Anima to your Covenant sanctum in exchange for a shield or offhand.", fua = "Поверніть цю намистину аніми до сактуму вашого ковенанта в обмін на щит або предмет лівої руки." }
    t[183889] = { name = "Чаротворча Намистина Аніми", fen = "Return this bead of Anima to your Covenant sanctum in exchange for a shield or offhand.", fua = "Поверніть цю намистину аніми до сактуму вашого ковенанта в обмін на щит або предмет лівої руки." }
    t[183890] = { name = "Зенітна Кулька Аніми", fen = "Return this bead of Anima to your Covenant sanctum in exchange for a weapon.", fua = "Поверніть цю намистину аніми до сактуму вашого ковенанта в обмін на зброю." }
    t[183891] = { name = "Шанована Кулька Аніми", fen = "Return this bead of Anima to your Covenant sanctum in exchange for a weapon.", fua = "Поверніть цю намистину аніми до сактуму вашого ковенанта в обмін на зброю." }
    t[183892] = { name = "Містична Кулька Аніми", fen = "Return this bead of Anima to your Covenant sanctum in exchange for a weapon.", fua = "Поверніть цю намистину аніми до сактуму вашого ковенанта в обмін на зброю." }
    t[183893] = { name = "Жахлива Кулька Аніми", fen = "Return this bead of Anima to your Covenant sanctum in exchange for a weapon.", fua = "Поверніть цю намистину аніми до сактуму вашого ковенанта в обмін на зброю." }
    t[183894] = { name = "Чаротворча Намистина Аніми", fen = "Return this bead of Anima to your Covenant sanctum in exchange for a shield or offhand.", fua = "Поверніть цю намистину аніми до сактуму вашого ковенанта в обмін на щит або предмет лівої руки." }
    t[183895] = { name = "Апогейна Намистина Аніми", fen = "Return this bead of Anima to your Covenant sanctum in exchange for a shield or offhand.", fua = "Поверніть цю намистину аніми до сактуму вашого ковенанта в обмін на щит або предмет лівої руки." }
    t[183896] = { name = "Жахлива Кулька Аніми", fen = "Return this bead of Anima to your Covenant sanctum in exchange for a weapon.", fua = "Поверніть цю намистину аніми до сактуму вашого ковенанта в обмін на зброю." }
    t[183897] = { name = "Містична Кулька Аніми", fen = "Return this bead of Anima to your Covenant sanctum in exchange for a weapon.", fua = "Поверніть цю намистину аніми до сактуму вашого ковенанта в обмін на зброю." }
    t[183898] = { name = "Шанована Кулька Аніми", fen = "Return this bead of Anima to your Covenant sanctum in exchange for a weapon.", fua = "Поверніть цю намистину аніми до сактуму вашого ковенанта в обмін на зброю." }
    t[183899] = { name = "Зенітна Кулька Аніми", fen = "Return this bead of Anima to your Covenant sanctum in exchange for a weapon.", fua = "Поверніть цю намистину аніми до сактуму вашого ковенанта в обмін на зброю." }
    t[183900] = "Сінвіровий Чайний Сервіз"
    t[183901] = "Дзиґа «Кістяна Буря»"
    t[183902] = "Ледь Сяйливе Зерня"
    t[183903] = { name = "Смердючий Холодець", fen = "Phew! That stinks.", fua = "Фу! Як смердить." }
    t[183912] = { name = "Обпалений Уламок Дзеркала", fen = "Glass used to craft magical mirros in Revendreth", fua = "Скло, що використовується для виготовлення магічних дзеркал у Ревендреті." }
    t[183913] = "Зламана Ніжка Келиха"
    t[183914] = "Липка Серветка"
    t[183915] = "Клапоть Стрічки"
    t[183916] = "Тріснута Чашка для Чаю"
    t[183917] = "Заляпана Слизом Миска"
    t[183918] = "Надщерблена Сервірувальна Миска"
    t[183919] = { name = "Попелясте Осердя", fen = "Radiates sufficient heat to allow glass to be fused into complex magical patterns.", fua = "Випромінює достатньо жару, щоб сплавляти скло у складні магічні візерунки." }
    t[183920] = "Зігнута Виделка"
    t[183921] = { name = "Зім'ята Серветка", fen = "A barely legible 'miserable' can be seen scrawled on the inside.", fua = "На внутрішньому боці видно ледь розбірливе нашкрябане 'жалюгідно'." }
    t[183922] = "Подрібнена Горіхова Шкаралупа"
    t[183923] = "Зламаний Кіготь"
    t[183924] = "Шкаралупа Яєць Ґорма"
    t[183925] = "М'яка Сніжна Слива"
    t[183926] = "Потерті Шкіряні Шнурки"
    t[183927] = "Зламаний Механізм Центуріона"
    t[183928] = { name = "Ввічлива, Але Коротка Подячна Записка", fen = "The Polemarch in a short note thanks you for the invite and hosting him.", fua = "У короткій записці полемарх дякує вам за запрошення і гостинність." }
    t[183929] = "Кишеньковий Жорсток Лестриту"
    t[183930] = "Зламаний Застібок Наручів"
    t[183931] = "Розщеплене Оперення Стріли"
    t[183932] = { name = "Розірваний Купон Ставки", fen = "It clearly wasn't a winner.", fua = "Очевидно, що він не був виграшним." }
    t[183933] = "Догоріла Склепова Свічка"
    t[183934] = "Заплямована Багном Серветка"
    t[183935] = { name = "Змінений Смертний Вирок", fen = "A crude drawing that might be you is on the reused warrant...", fua = "На повторно використаному вироку є грубий малюнок, що може зображати вас..." }
    t[183936] = { name = "Різка Записка", fen = "The Countess lays out succinctly that she was offended by your party and expected more from you.", fua = "Графиня стисло викладає, що ваше свято її образило і що вона очікувала від вас більшого." }
    t[183937] = { name = "Пожирач Душ Грішного Гладіатора", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[183940] = { name = "Фоліант Присяжного Архіваріуса", fen = "Only through research and toil can one enter the ranks of the Avowed.", fua = "Лише через дослідження й тяжку працю можна вступити до лав Присяжних." }
    t[183942] = "Знак Ремісника-Початківця"
    t[183943] = "Відро Таббінса"
    t[183944] = { name = "Сітка для Чапель", fen = "A large net with weighted edges used to briefly immobilize Territorial Waders without harming them.", fua = "Велика сітка з обтяженими краями, що використовується, аби ненадовго знерухомити територіальних бродунів, не завдаючи їм шкоди." }
    t[183945] = "Збільшений Нерв"
    t[183946] = "Кровокований Тесак"
    t[183950] = { name = "Дистильований Екстракт Смерті", fen = "Used for neutralizing unstable chemicals. Sold by Alchemy vendors.", fua = "Використовується для нейтралізації нестабільних хімікатів. Продається у крамарів алхімії." }
    t[183951] = { name = "Безсмертна Скалка", fen = "Used for empowering enchantments. Sold by Enchanting vendors.", fua = "Використовується для підсилення чарів. Продається у крамарів накладання чарів." }
    t[183952] = { name = "Машинна Олія", fen = "Used for lubricating and cooling machines. Sold by Engineering vendors.", fua = "Використовується для змащування й охолодження машин. Продається у крамарів інженерії." }
    t[183953] = { name = "Сургуч для Печаток", fen = "Used for emblazoning official seals. Sold by Inscription vendors.", fua = "Використовується для відтиснення офіційних печаток. Продається у крамарів накреслення." }
    t[183954] = { name = "Гнучкий Дріт", fen = "Used for creating intricate filigree. Sold by Jewelcrafting vendors.", fua = "Використовується для створення вишуканого філіграну. Продається у крамарів ювелірної справи." }
    t[183956] = "Запрошення: Чуфа"
    t[183957] = "Запрошення: Грандмайстер Воул"
    t[183960] = { name = "Переносний Кишеньковий Вимір", fen = "No matter how heavy the contents, this bag's shape and weight never seem to change.", fua = "Хоч би яким важким був вміст, форма і вага цієї торби, схоже, ніколи не змінюються." }
    t[183963] = "Ґормлет"
    t[183964] = { name = "Розкішні Предмети Аніми", fen = "Contains a number of anima items of rare quality.", fua = "Містить кілька предметів аніми рідкісної якості." }
    t[183965] = { name = "Незвичайні Предмети Аніми", fen = "Contains a number of anima items of uncommon quality.", fua = "Містить кілька предметів аніми незвичайної якості." }
    t[183968] = "Кріс Вентирського Ритуаліста"
    t[183969] = "Бутафорський Крис"
    t[183970] = "Ритуальний Клинок Королівського Арканіста"
    t[183971] = "Кріс Розбещеного Ритуаліста"
    t[183972] = "Крилатий Кріс Забутого Вентира"
    t[183973] = "Загублений Крилатий Ритуальний Кріс"
    t[183974] = "Церемоніальний Кинджал Двору Жарин"
    t[183975] = "Церемоніальне Лезо Сінфолу"
    t[183976] = "Кинджал Дослідника-Відступника"
    t[183977] = "Церемоніальний Кинджал Дому Ренатал"
    t[183978] = "Сріблогравійований Дирк Згубник Надії"
    t[183979] = "Стандартна Рапіра Фехтувальника"
    t[183980] = "Кіріанський Гладіус"
    t[183981] = "Великий Клинок Кіріанців"
    t[183982] = "Колій Кліща-Пожирача"
    t[183983] = "Чароклинок Ритуаліста-Відступника"
    t[183984] = "Малдраксійський Короткий Клинок"
    t[183985] = "Малдраксійська Кісткова Пилка"
    t[183986] = "Прив'язуваний Камінь Гріха"
    t[183987] = { name = "Ключ від Клітки В'язня", fen = "A key which opens a prisoner cage.", fua = "Ключ, що відмикає клітку з в'язнем." }
    t[183988] = "Прив'язувана Діадема Валькіри"
    t[183989] = "Гонщик на Тачці Землекопів"
    t[184013] = { name = "Лютий Бойовий Павук", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[184014] = { name = "Лютий Бойовий Павук", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[184015] = { name = "Викрадена Пам'ятка", fen = "A lost possession, left behind with the death of the grove.", fua = "Загублена річ, покинута зі смертю гаю." }
    t[184016] = "Крило Скрадача"
    t[184017] = "Повідок Баргаста"
    t[184018] = "Розколоте Серце Ал'ара"
    t[184019] = "Запалювач Душ"
    t[184020] = "Жмут Тліючого Пір'я"
    t[184021] = "Гліф Поглинання"
    t[184022] = "Виснажлива Настоянка"
    t[184023] = "Ненажерливий Шпичак"
    t[184024] = "Моторошні Ноти"
    t[184025] = "Спогад про Минулі Гріхи"
    t[184026] = "Ненависний Ланцюг"
    t[184027] = "Геральдика Кам'яного Легіону"
    t[184028] = "Збірник Гімнів Кабаліста"
    t[184029] = "Зв'язане з Маною Дзеркало"
    t[184030] = "Посудина Жахливого Вогню"
    t[184031] = "Кривавий Витримок"
    t[184036] = { name = "Капелюх Дандея", fen = "A simple hat made from Tauralus hide.", fua = "Простий капелюх зі шкіри тауралуса." }
    t[184037] = { name = "Свічки Малдраксусу", fen = "The best and only candles available.", fua = "Найкращі і єдині доступні свічки." }
    t[184038] = { name = "Навчена Трупна Воша", fen = "Trained, but still hungry!", fua = "Навчена, але все ще голодна!" }
    t[184039] = { name = "Чистий Білий Капелюх", fen = "Easily stretched to fit even the biggest of heads.", fua = "Легко розтягується, щоб пасувати навіть найбільшим головам." }
    t[184040] = { name = "Розбита Яєчна Шкаралупа", fen = "Could be made in to a rather unique hat.", fua = "З неї можна зробити доволі унікальний капелюх." }
    t[184041] = { name = "Святкова Парасолька", fen = "The perfect party accessory.", fua = "Ідеальний аксесуар для вечірки." }
    t[184045] = { name = "Воєнна Десятина Двору Женців", fen = "Contains a weapon unique to the court of Revendreth.", fua = "Містить унікальну зброю двору Ревендрету." }
    t[184046] = { name = "Тайник зі Зброєю Невмирущої Армії", fen = "Contains a weapon unique to the armies of Maldraxxus.", fua = "Містить унікальну зброю армій Малдраксусу." }
    t[184047] = { name = "Скриня Зброї Піднесених", fen = "Contains a weapon unique to the forces of Bastion.", fua = "Містить унікальну зброю воїнства Бастіону." }
    t[184048] = { name = "Сумка зі Зброєю Дикого Полювання", fen = "Contains a weapon unique to the hunters of Ardenweald.", fua = "Містить унікальну зброю мисливців Арденвельду." }
    t[184049] = { name = "Підроблений Талісман", fen = "\"Chordy not want, but maybe you do? It make funny sound.\" -Clyde", fua = "\"Корді не хотіти, але може ти? Воно робити смішний звук.\" - Клайд" }
    t[184050] = { name = "Гнучка Сітка", fen = "\"I try to fool Atticus, but he too smart. It help keep goo inside.\" -Clyde", fua = "\"Я пробувати обдурити Аттікуса, але він надто розумний. Воно помагати тримати слиз усередині.\" - Клайд" }
    t[184051] = { name = "Зшита Подоба Ліча", fen = "\"I want be a lich, but soul too weak. I make doll instead!\" -Clyde", fua = "\"Я хотіти бути ліч, але душа надто слабка. Я робити ляльку замість!\" - Клайд" }
    t[184052] = "Медальйон Грішного Претендента"
    t[184053] = "Невблаганна Брошка Грішного Претендента"
    t[184054] = "Сигіл Пристосування Грішного Претендента"
    t[184055] = "Медальйон Спотвореного Гладіатора"
    t[184056] = "Невблаганна Брошка Спотвореного Гладіатора"
    t[184057] = "Сигіл Пристосування Спотвореного Гладіатора"
    t[184062] = { name = "Погризені Віжки Бойового Військового Гончака", fen = "Teaches you how to summon a Battle-Bound Warhound.", fua = "Навчають вас прикликати Бойового Військового Гончака." }
    t[184063] = "Ніж Незримого Ока"
    t[184064] = "Мертвокований Бастіон Малдраксуса"
    t[184065] = "Мерехтливий Чумовражений Фокус"
    t[184066] = "Звивиста Душезаряджена Булава"
    t[184067] = "Черепоподібна Кістяна Бойова Глефа"
    t[184068] = "Дворучний Посох Присяжників Ліча"
    t[184069] = "Душевне Жало, Бездиханна Смерть"
    t[184070] = "Колосальна Дворучна Сокира Пандемоніуму"
    t[184071] = "Залита Кров'ю Древкова Зброя Аранакків"
    t[184072] = "Брутальний Тесак, Кутий Люттю"
    t[184073] = "Кривий Кинджал, Торкнутий Чумою"
    t[184074] = "Рубач Прихованої Руки"
    t[184075] = "Кам'янокований Вартовий"
    t[184076] = "Недороблений Кам'яний Вартовий"
    t[184077] = { name = "Заголовки Каменів Гріхів зі Славетними Іменами", fen = "You recognize one or two names of legend that appear to have passed through Revendreth.", fua = "Ви впізнаєте одне-два легендарні імена тих, хто, схоже, пройшов крізь Ревендрет." }
    t[184078] = "Викинутий Зуб Наксса"
    t[184079] = "Жахливий Оплот Марза"
    t[184080] = "Линяльний Тотем Роузбойла"
    t[184081] = "Смердючий Гамселій Газового Міхура"
    t[184082] = "Звільнювач Аніми Аттікуса"
    t[184083] = "Гамселик Професора"
    t[184084] = "Пускач Кісткових Шипів Ратана"
    t[184085] = "Широка Сокира Мухоловки, що Розтинає Життя"
    t[184086] = "Палиця-Апортувалка Ніни"
    t[184087] = "Розв'язувач Проблем Залізного Філіпа"
    t[184088] = "Кривий Палець Сабріни"
    t[184089] = "Сікач Томаліна"
    t[184090] = "Зілля Швидкості Психопомпа"
    t[184101] = { name = "Висотане Дике Зерно", fen = "This wildseed's anima is almost completely drained, but the spirit within is still surviving.", fua = "Аніма цього дикого зерна майже повністю висотана, але дух усередині все ще виживає." }
    t[184102] = { name = "Одержима Маска", fen = "A strange mask worn by the hostile fae.", fua = "Дивна маска, яку носять ворожі феї." }
    t[184103] = { name = "Тріснуте Яйце, Торкнуте Виразкою", fen = "The egg has hatched!", fua = "Яйце вилупилося!" }
    t[184104] = { name = "Яйце, Торкнуте Виразкою", fen = "This egg is hatching into something.", fua = "З цього яйця хтось вилуплюється." }
    t[184105] = "Вир"
    t[184106] = "Ґімбл"
    t[184107] = "Плащ Бороґова"
    t[184108] = "Ворпальний Амулет"
    t[184109] = "Дворучний Меч Пащі"
    t[184110] = "Комплект: Бойова Кора Консерватора"
    t[184111] = "Комплект: Подоба Хранителя"
    t[184112] = "Комплект: Шати Консерватора"
    t[184113] = "Комплект: Регалії Консерватора"
    t[184114] = "Комплект: Регалії Зимородженого"
    t[184115] = "Комплект: Шати Зимородженого"
    t[184116] = "Комплект: Личина Зимородженого"
    t[184117] = "Комплект: Бойова Кора Зимородженого"
    t[184119] = "Запасне Серце"
    t[184120] = "Запасний Мозок"
    t[184121] = "Запасне Око"
    t[184122] = "Запасна Нога"
    t[184123] = "Плащ Грішного Гладіатора"
    t[184124] = "Запасний Шлунок"
    t[184125] = "Пояс із Серволанцюга"
    t[184126] = "Наручі З Залізокореня"
    t[184127] = "Капці Листяного Підліску"
    t[184128] = "Грудна Клітка Мортаніса"
    t[184129] = "Прозорі Поножі Ораномоноса"
    t[184130] = "Пояс Багатьох Каменів Гріха Нурґаша"
    t[184131] = "Зручні Сонні Намотки"
    t[184132] = "Завеликий Шолом Центуріона"
    t[184133] = "Поясний Шнур Хребтоповза"
    t[184134] = "Дзвінкі Кам'яні Чоботи"
    t[184135] = "Наручі з Лопаток"
    t[184136] = "Заряджені Анімою Наручі"
    t[184137] = "Гріхокам'яні Наплічники"
    t[184138] = "Пояс із Кам'яної Кори"
    t[184139] = "Землетовкачі Валінора"
    t[184140] = "Чоботи з Кістяними Шипами"
    t[184141] = "Покрив Покаянника"
    t[184142] = "Скручений Перстень Всохлокореня"
    t[184143] = "Перстень Воскреслого Кістяного Лорда"
    t[184144] = "Ланцюговий Чокер із Багна"
    t[184145] = "Великий Плащ Грішного Претендента"
    t[184146] = "Обпалені Кайдани Душі"
    t[184147] = "Пристрій Збагачення Агонії"
    t[184148] = "Прихована Сінвірова Настоянка"
    t[184149] = "Аромат, Настояний на Вдовоцвіті"
    t[184150] = "Зв'язані Лоєві Свічки"
    t[184151] = "Підроблена Рубінова Брошка"
    t[184152] = "Пляшка Розведеного Анімового Вина"
    t[184153] = "Поліморфний Багатогранник"
    t[184154] = "Обшарпаний Стримувальний Рюкзак"
    t[184155] = { name = "Відновлений Стримувальний Ранець", fen = "What a rare find! Someone in the House of Plagues would be interested in such a pristine containment pack.", fua = "Яка рідкісна знахідка! Хтось у Домі Чум зацікавився б таким бездоганним стримувальним ранцем." }
    t[184156] = "Бездоганний Стримувальний Ранець"
    t[184157] = { name = "Припаси Зимовецької Улоговини", fen = "Supplies for the refugees at the Heart of the Forest.", fua = "Припаси для біженців у Серці Лісу." }
    t[184160] = { name = "Бульбастий Некроскат", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[184161] = { name = "Уражений Некроскат", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[184162] = { name = "Заразний Некроскат", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[184163] = { name = "Позолочений Слиз", fen = "This slime appears to have eaten a large pile of gold.", fua = "Схоже, цей слиз з'їв велику купу золота." }
    t[184164] = "Ілюзія: Дика Душа"
    t[184165] = "Печатка Фордрагона"
    t[184166] = { name = "Коридорний Плазун", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[184167] = { name = "Ловець Душ Пащеслужбовців", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[184168] = { name = "Зв'язаний Тіньовий Гончак", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[184169] = "Ланцюговий Підйомник Сховища"
    t[184170] = "Намотки на Руки Ткача Сумнівів"
    t[184171] = "Загартовані Замкові Трощителі"
    t[184172] = "Обмотки Доглядача Насіння"
    t[184173] = "Кісткодробильні Лещата"
    t[184174] = "Застібка Смерті"
    t[184175] = "Кісткопальна Чарівна Паличка"
    t[184176] = "Костеруйнівна Бойова Глефа Морока"
    t[184177] = "Гротескне Шпичакове Кайло"
    t[184178] = "Клеймор Світорозриву"
    t[184179] = "Кістяний Клинок Личозаприсяженого Командира"
    t[184180] = "Необроблена Маска Ліди"
    t[184181] = "Улюблений Гак Каша"
    t[184182] = "Зміцнений Гак Мерзоти"
    t[184183] = { name = "Ненажерливий Пожирач", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[184184] = "Кислотне Жало Ревеномуса"
    t[184185] = "Вкрита Брудом Ключиця"
    t[184186] = "Гак для Виловлювання Плоті"
    t[184187] = "Відбивач Наглядача"
    t[184188] = "Трупний Гак Колекціонера"
    t[184189] = "Заплямований Плотогриз"
    t[184192] = "Бездоганний Алебастровий Протинач"
    t[184193] = "Гак, Кутий Мозолями"
    t[184194] = "Чумовитравлений Рубач"
    t[184195] = "Чумовитравлений Штрикач"
    t[184198] = { name = "Ключ, Торкнутий Душами", fen = "A key with a familiar aura. Bolvar might be interested in this.", fua = "Ключ зі знайомою аурою. Болвара це може зацікавити." }
    t[184199] = { name = "Уламки в Кірці Льоду", fen = "A broken object encased in unnatural ice. This looks like the work of a mage adept in frost magic. Bolvar might be interested in this.", fua = "Зламаний предмет, закутий у неприродний лід. Це схоже на роботу мага, вправного у магії холоду. Болвара це може зацікавити." }
    t[184200] = { name = "Зашифровані Нотатки", fen = "A page marked with unsettling runes and glyphs. Though you cannot decipher the writing, it may be of interest to Bolvar Fordragon.", fua = "Сторінка, помережана тривожними рунами та гліфами. Хоч ви й не можете розшифрувати письмо, воно може зацікавити Болвара Фордрагона." }
    t[184201] = "Талий Сніг"
    t[184202] = "Сушене Солоне М'ясо"
    t[184203] = { name = "Грибковий Тонік для Волосся", fen = "It's not hair, but it covers up bald spots.", fua = "Це не волосся, але воно прикриває лисини." }
    t[184204] = { name = "Капелюх з Іншого Світу", fen = "A hat that formerly belonged to someone else's head.", fua = "Капелюх, що раніше належав чиїйсь чужій голові." }
    t[184205] = { name = "Давно Загублений Вінець", fen = "Polish it up and declare yourself king!", fua = "Начисти його і проголоси себе королем!" }
    t[184206] = "Поїдений Міллю Плащ Ковенанту"
    t[184207] = "Іржавий Наплічник Ковенанту"
    t[184208] = "Потертий Пояс Ковенанта"
    t[184209] = "Уламки Камінородженого"
    t[184210] = "Шипастий Кий Інквізиції"
    t[184211] = "Стягнутий Пояс Верховного Інквізитора"
    t[184212] = "Наручі Тренера Залякувачів"
    t[184213] = "Підошви Ритуаліста"
    t[184214] = "Скуті Кайдани"
    t[184215] = "Рукавиці Розпусного Псаря"
    t[184216] = "Наплічники Камінородженого Охоронця"
    t[184217] = "Гріхокам'яні Чоботи"
    t[184218] = "Арбітр Непристойності"
    t[184219] = "Трактат про Здобуття Уламків Каменя Гріхів"
    t[184220] = { name = "Енциклопедія Відновлення Уламків Каменя Гріхів", fen = "A more in depth volume perfect for those just beginning their studies.", fua = "Докладніший том, ідеальний для тих, хто лише починає свої студії." }
    t[184222] = "Реквізиційні Накази Лемета"
    t[184223] = { name = "Шолом Поневолених", fen = "The helm of the mawsworn, still seeping with the Jailer's dominating energies.", fua = "Шолом присяжних Пащі, з якого досі сочиться поневолювальна енергія Тюремника." }
    t[184224] = { name = "Насіння Чепурунчика", fen = "With a little assistance fungus should grow!", fua = "З невеликою допомогою гриби мають вирости!" }
    t[184225] = { name = "Маленький Рухомий Скелет", fen = "A strange item, sold by very stange vendors.", fua = "Дивна річ, що її продають дуже дивні торговці." }
    t[184227] = { name = "Янгольське Перо", fen = "Caution! Do not sell within the realm of Bastion.", fua = "Обережно! Не продавати в межах Бастіону." }
    t[184228] = { name = "Наелектризований Залишок Душі", fen = "Whatever this was appears to have fallen victim to a massive electrical attack. Found in Coldheart Interstitia, Bolvar might be interested in this.", fua = "Що б це не було, схоже, воно стало жертвою потужної електричної атаки. Знайдений у Холодосердному Проміжку, Болвар, можливо, цим зацікавиться." }
    t[184229] = { name = "Тіньовий Ключ", fen = "A key, larger than most. Found in Mort'regar, Bolvar might be interested in this.", fua = "Ключ, більший за більшість. Знайдений у Морт'регарі, Болвар, можливо, цим зацікавиться." }
    t[184230] = "Піка Шанованого Пельтаста"
    t[184231] = "9.0 Covenant - Bastion - Weapon - Warglaive AGI - Blue"
    t[184232] = "9.0 Covenant - Bastion - Weapon - Warglaive AGI - Copper"
    t[184233] = "9.0 Covenant - Bastion - Weapon - Warglaive AGI - Dark"
    t[184234] = "9.0 Covenant - Bastion - Weapon - Warglaive AGI - Gold"
    t[184235] = "9.0 Covenant - Bastion - Weapon - Warglaive AGI - Pink"
    t[184236] = "Бойова Глефа Відданої Могутності"
    t[184237] = "Бойова Глефа Грішного Гладіатора"
    t[184238] = "Бойова глефа, Затьмарена Сумнівом"
    t[184239] = "Бойова Глефа Самовідданого Носія"
    t[184240] = "Бойова Глефа Гармонійного Носія"
    t[184241] = "Зломлювач Кам'яного Вартового"
    t[184242] = { name = "Обгорілий Тотем", fen = "This totem has seen better days. Bolvar might be interested in this.", fua = "Цей тотем бачив кращі дні. Болвар, можливо, цим зацікавиться." }
    t[184243] = "Преторіанський Крилоклинок"
    t[184244] = "Кусючий Кишкоріз"
    t[184245] = "Бар'єр Обраного"
    t[184246] = "Осереддя Крижаного Закликача"
    t[184247] = "Хватка Мертвих"
    t[184248] = "Здвоєний Клинок, Кований Згубою"
    t[184249] = "Посох ліч-присяжного лейтенанта"
    t[184250] = "Мушкетон Влучного Стрільця"
    t[184251] = "Скостеніла Широка Сокира"
    t[184252] = "Катувальний Пристрій Аранакків"
    t[184253] = "Січкар для Утроби"
    t[184254] = "Серп Чумошипа"
    t[184255] = "Рубака Кривавих Хрящів"
    t[184256] = "Лютий Кинджал Кровошматувача"
    t[184257] = "Тягар Протекторату"
    t[184258] = "Кристал Злостивого Закликача"
    t[184259] = "Хватка з Могили"
    t[184260] = "Бойова Глефа Прихованого Лиходія"
    t[184261] = "Дворучний Посох Генерала Присяжників Ліча"
    t[184262] = "Гармата Влучного Стрільця"
    t[184263] = "Скостеніла Дворучна Сокира"
    t[184264] = "Кровопускальна Древкова Зброя Крексуса"
    t[184265] = "Розпорювач Утроби"
    t[184266] = "Серп Кари Плоті"
    t[184267] = "Черепосік Нещадного"
    t[184270] = "Миролюбний поніард Учня"
    t[184271] = "Копіс Відваги Ксандрії"
    t[184272] = "Вознесений Гладіус Слави"
    t[184273] = "Протинач Чистого Розуму"
    t[184274] = "Спустошувач Оновленої Рішучості"
    t[184275] = "Священне Лезо Бійця"
    t[184276] = { name = "Відрізок Просякнутого Світлом Ланцюга", fen = "These chains appear to have bound someone strong with the Light recently. Bolvar might be interested in this.", fua = "Цей ланцюг, схоже, нещодавно сковував когось дужого Світлом. Болвар, можливо, цим зацікавиться." }
    t[184277] = { name = "Емблема Лева", fen = "This emblem appears to have been torn from a piece of armor. Bolvar might be interested in this.", fua = "Ця емблема, схоже, була зірвана з обладунку. Болвар, можливо, цим зацікавиться." }
    t[184278] = { name = "Королівський Перстень", fen = "This ring looks like it could have been fit for a king. Bolvar might be interested in this.", fua = "Цей перстень виглядає так, наче міг належати королю. Болвар, можливо, цим зацікавиться." }
    t[184279] = "Висмоктувальний Кровопивця"
    t[184280] = "Чепурне Вбрання"
    t[184281] = { name = "Багномороз", fen = "Comes in five flavors: Cold, Chunky, Slough, Moist-ish, and Brown, not sure which this is...", fua = "Випускається в п'яти смаках: холодний, грудкуватий, твань, вологуватий і брунатний, не певен, що це за один..." }
    t[184283] = "Сутінки №1"
    t[184284] = { name = "Бойова Булава Бладгуф", fen = "Black ooze covers Baine's mace. It has caved in the skull of many Mawsworn.", fua = "Чорна слизота вкриває булаву Бейна. Вона провалила черепи багатьом прислужникам Пащі." }
    t[184285] = "Кістьохопні Кайдани"
    t[184286] = { name = "Аніма Згаслих Душ", fen = "The empty vessel is a gutwrenching reminder of Denathrius' betrayal.", fua = "Порожня посудина — гнітюче нагадування про зраду Денатрія." }
    t[184287] = "Заляпані Брудом Еполети"
    t[184288] = "Бар'єр Безжального Воєначальника"
    t[184289] = "Чароклинок Веретенозуба"
    t[184290] = { name = "Закривавлена Кісткова Пила", fen = "Bonesaws are not very effective at cutting animated globules of blood.", fua = "Кісткові пили не дуже добре ріжуть оживлені кров'яні згустки." }
    t[184291] = "Гартований Пояс із Кісткових Пластин"
    t[184292] = { name = "Стародавня Елетієва Монета", fen = "Etched into one side of this coin are the words \"Vala Mortalis\". Even after throwing it, it can always be found in your pocket.", fua = "На одному боці цієї монети викарбувано слова «Vala Mortalis». Навіть викинувши її, ти завжди знаходиш її у своїй кишені." }
    t[184293] = "Освячений Листок Небосвіту"
    t[184294] = "Ефірна Амброзія"
    t[184295] = "Намисто Вічного Світанку"
    t[184296] = "Дворучний Клинок Грані Чистоти"
    t[184297] = "Великий Клинок Вартового Смерті"
    t[184298] = "Журнал Зібраного Зреченого"
    t[184299] = "Просочений Кров'ю Панцир"
    t[184300] = "Сплавлений Захист Хребта"
    t[184301] = "Фіолетовий Пояс на Двадцять Петель"
    t[184302] = "Багнисті Болотні Чоботи в Намулі"
    t[184303] = "Арсенал: Зброя Майстрів Шва"
    t[184304] = { name = "Уламки Зброї, Торкнуті Анімою", fen = "The faint touch of anima lingers on the fragments. Someone back at Butchers Block would certainly find these useful.", fua = "На уламках лишається ледь помітний слід аніми. Комусь на М'ясницькому Кварталі вони точно знадобляться." }
    t[184305] = "Озброєння Малдраксійського Чемпіона"
    t[184306] = "Душоловна Твань"
    t[184307] = "Уламки Малдраксійської Броні"
    t[184308] = { name = "Одноразовий Спектрофазовий Реаніматор", fen = "While this device can certainly bring the dead back to life, it may also bring the living to the brink of death.", fua = "Хоч цей пристрій і здатен повертати мертвих до життя, він також може довести живих до межі смерті." }
    t[184309] = { name = "Нотатки Вентирського Інквізитора", fen = "Tod boasts the most peculiar of sins I have ever encountered, I am at a loss as to what form of atonement could possibly be warranted.", fua = "Тод похваляється найдивовижнішими гріхами, які я будь-коли стрічав, і я губуся, яка форма спокути тут була б доречна." }
    t[184310] = { name = "Камінь Гріхів Тода", fen = "Imagine the dumbest, yet oddly diabolic, and still utterly wrong deeds.", fua = "Уяви найдурніші, але дивно диявольські й водночас цілковито хибні вчинки." }
    t[184311] = "Великий Плащ Грішного Гладіатора"
    t[184312] = "Вогняна Сірка Борр-Гета"
    t[184314] = "Посередницький Пристрій"
    t[184315] = "Модульний Контейнер для Аніми"
    t[184316] = { name = "Схованка Натрійських Скарбів", fen = "Rewards a piece of equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження для вашої спеціалізації здобичі." }
    t[184317] = { name = "Схованка Натрійських Скарбів", fen = "Rewards a piece of equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження для вашої спеціалізації здобичі." }
    t[184318] = "Бойовий Клич Крексуса"
    t[184320] = "Посох Послушника Сінфоллу"
    t[184321] = "Бойова Сокира Бійця Сінфоллу"
    t[184322] = "Мушкетон Сінфолу"
    t[184323] = "Крилата Глефа Сінфоллу"
    t[184324] = "Рапіра Фехтувальника Сінфоллу"
    t[184325] = "Швидкий Клинок Сінфоллу"
    t[184326] = "Кийок Каменероджених Сінфоллу"
    t[184327] = "Моргенштерн Спокутника Сінфоллу"
    t[184328] = "Алебарда Захисника Сінфоллу"
    t[184329] = "Каплеподібний Щит Сінфолу"
    t[184330] = "Зачарована Пляшка Еліксиру Сінфолу"
    t[184340] = { name = "VIP-Перепустка до Коренебару", fen = "You're on the list.", fua = "Ти у списку." }
    t[184341] = "Надкушений Порталбело"
    t[184342] = "Великий Порталовик"
    t[184343] = "Здоровий Порталбелло"
    t[184344] = "Зів'ялий Портабело"
    t[184345] = "Сяйний Порталбело"
    t[184346] = "Вологий Портальський Гриб"
    t[184347] = "Струнка Портальбело"
    t[184348] = "Креслення: Перстень Оберегу"
    t[184349] = "Креслення: Флакон Личоморозу"
    t[184350] = { name = "Куйовда", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[184351] = "Ілюзія: Відданий Дух"
    t[184352] = "Ілюзія: Трансцендентна Душа"
    t[184353] = "Кіріанський Камінь Повернення"
    t[184354] = { name = "Ключ Жниці Душ", fen = "A key to open the Harvester's cage.", fua = "Ключ, щоб відчинити клітку Жниці." }
    t[184359] = { name = "Уламок Незв'язаної Реальності", fen = "This potent concentration of magic can open new possibilities for you at your covenant's Forge of Bonds.", fua = "Ця потужна концентрація магії може відкрити тобі нові можливості в Кузні Уз твого ковенанту." }
    t[184360] = "Роздуми про Повторення"
    t[184361] = { name = "Апарат Просторового Переналаштування", fen = "This gadget causes a miniature rift in space to appear within your equipment, perfectly shaped for a gem.", fua = "Цей пристрій спричиняє появу у вашому спорядженні мініатюрного розриву простору, ідеально підігнаного під самоцвіт." }
    t[184362] = "Роздуми про Чистоту"
    t[184363] = "Роздуми про Мужність"
    t[184365] = "Егіда Спасіння"
    t[184368] = { name = "Тліюче Руків'я", fen = "This fragment of a sword still emits sparks and puffs of smoke, but its once-fiery blade has been utterly quenched.", fua = "Цей уламок меча досі сипле іскрами й пускає клуби диму, та його колись вогняний клинок цілковито згас." }
    t[184371] = "Жвавість Співпраці"
    t[184373] = "Мала Куля Аніми"
    t[184374] = "Обмінна Посудина Картелю"
    t[184378] = "Бурштин Феїстого Пралісу"
    t[184379] = "Замерзла Сльоза Королеви"
    t[184380] = "Нектар Зорецвіту"
    t[184381] = "Астральна Заболонь"
    t[184382] = "Сяйлива Сильягода"
    t[184383] = "Бульба Присмерку"
    t[184384] = "Зимовий Паросток"
    t[184385] = "Скам'яніла Серцевина"
    t[184386] = "Зароджувана Спорова Капсула"
    t[184387] = "Туманний Мерехтлист"
    t[184388] = "Пухкий Блискокорінь"
    t[184389] = "Дрімотне Зорянасіння"
    t[184395] = { name = "Сховок Полеглого Шукача Пригод", fen = "All that remains of some poor soul, forgotten to the ages.", fua = "Усе, що лишилося від якоїсь бідолашної душі, забутої віками." }
    t[184396] = { name = "Несправна Латна Рукавиця Голіафа", fen = "Only about 50% effective.", fua = "Ефективна лише десь на 50%." }
    t[184397] = { name = "Загублений Пернатик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[184398] = { name = "Пернатик Розпорядника", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[184399] = { name = "Ларіонча", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[184400] = { name = "Відвага", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[184401] = { name = "Ларіон-Стрибун", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[184402] = { name = "Флейта Пана з Кулексового Дерева", fen = "Instruments carved from culexwood are the finest in all of the Shadowlands, wagered upon by travelling musicians in contests of skill and creativity.", fua = "Інструменти, вирізьблені з кулексового дерева, найкращі в усіх Тінокраях, і мандрівні музики ставлять їх на кін у змаганнях майстерності та творчості." }
    t[184403] = { name = "Свічка Сноваби", fen = "Dreamlures smolder near hibernating souls, warding away the traumas of previous lifetimes.", fua = "Сновабні свічки жевріють поряд зі сплячими душами, оберігаючи їх від травм минулих життів." }
    t[184404] = "Невгасиме Вогнище"
    t[184407] = "Креслення: Поштова Торбина Стюарда"
    t[184410] = "Ноші Претендента"
    t[184411] = "Креслення: Позолочені Рахівниці"
    t[184412] = "Нагорода-Звання: Скрадач Шпилів"
    t[184413] = { name = "Панель Налаштування Пам'яті", fen = "Your reflection seems to recognize you.", fua = "Твоє відображення, здається, упізнає тебе." }
    t[184414] = "Креслення: Пояс для Ремісничого Інструменту"
    t[184415] = { name = "Заспокійливий Дзвін", fen = "While not as powerful as its larger brethren, its voice is still remarkably soothing to the ear.", fua = "Хоч він і не такий потужний, як його більші побратими, його голос усе ж напрочуд заспокоює слух." }
    t[184418] = { name = "Акробатичний Розпорядник", fen = "How else are they expected to reach high places?", fua = "Як інакше їм діставатися високих місць?" }
    t[184435] = { name = "Знак Чистоти", fen = "It is a rare soul that earns the attentions of a Paragon at the moment of their death.", fua = "Рідкісна та душа, що заслуговує на увагу Взірця в мить своєї смерті." }
    t[184445] = "Креслення: Медальйон Служіння"
    t[184446] = { name = "Фіал Синьої Багнистої Барви", fen = "Can be used to alter the color of dredger clothing.", fua = "Можна використати, щоб змінити колір одягу копача." }
    t[184447] = "Святкове Приладдя Кевіна"
    t[184448] = "Гострі Жаргриби"
    t[184449] = "Улюблена Іграшка Джиґлза"
    t[184450] = "Креслення: Вечірній Дзвін Поклику"
    t[184451] = "Веспер Заклику"
    t[184452] = "Шанобливий Шолом"
    t[184453] = "Шанобливий Плащ"
    t[184454] = "Шанобливі Латні Рукавиці"
    t[184455] = "Шанобливий Пояс"
    t[184456] = "Шанобливий Нагрудник"
    t[184457] = "Шанобливі Поножі"
    t[184458] = "Шанобливі Наплічники"
    t[184459] = "Шанобливі Чоботи"
    t[184460] = "Шанобливі Наручі"
    t[184461] = { name = "Чіпляка", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[184462] = "Арсенал: Збройова Схованка Сумніву"
    t[184463] = "Арбалет, Затьмарений Сумнівом"
    t[184464] = "Бойова глефа, Затьмарена Сумнівом"
    t[184465] = "Просочений Сумнівом Довгий Спис"
    t[184466] = "Дзвін, Підфарбований Сумнівом"
    t[184467] = "Руків'я, Затьмарене Сумнівом"
    t[184468] = "Швидкий клинок, Затьмарений Сумнівом"
    t[184469] = "Просочений Сумнівом Дворучний Меч"
    t[184470] = "Довбня, Затьмарена Сумнівом"
    t[184471] = "Кинджал Провідної Ноти"
    t[184472] = "Молоток, Затьмарений Сумнівом"
    t[184473] = "Чароклинок, Затьмарений Сумнівом"
    t[184474] = "Арсенал: Збройова Схованка Мудрості"
    t[184475] = "Духокована Егіда"
    t[184476] = { name = "Фіал Відновлювального Слизу", fen = "For some reason, every time you look at it there's more slime in the vial.", fua = "Чомусь щоразу, як ти дивишся на нього, слизу у фіалі стає більше." }
    t[184477] = "Флакон Лічморозу"
    t[184478] = "Фіал Безтурботності"
    t[184479] = "Сумка з Оповитої Тканини"
    t[184480] = "Мішечок з Безсвітлого Шовку"
    t[184481] = "Перстень Оберегу"
    t[184487] = "Ґормлінг у Торбі"
    t[184488] = { name = "Уламок Каменя Гріхів", fen = "Contains a detailed account of mortal sins.", fua = "Містить докладний перелік смертних гріхів." }
    t[184489] = "Феїна Арфа"
    t[184490] = "Феїна Сопілка"
    t[184492] = { name = "Пульсуюча Сфера", fen = "This sphere pulses with magic that is utilized by the brokers. A message is inscribed on it: 'We know what you did, Ve'nari. You will pay the price.'", fua = "Ця сфера пульсує магією, якою користуються посередники. На ній викарбувано послання: «Ми знаємо, що ти зробила, Ве'нарі. Ти заплатиш за це»." }
    t[184495] = { name = "Заражений Павучий Кокон", fen = "It glows softly blue. You're not sure it should be doing that.", fua = "Він м'яко світиться блакитним. Ти не певен, що так має бути." }
    t[184496] = "Комплект: Шати Розладнаних"
    t[184497] = "Комплект: Шати Розладнаних"
    t[184498] = "Комплект: Кольчуга Розбрату"
    t[184499] = "Комплект: Бойові Лати Розладнаних"
    t[184500] = { name = "Кишеньковий Портал Прислужника: Бастіон", fen = "Limited power remains in this device.", fua = "У цьому пристрої лишилося обмаль сили." }
    t[184501] = { name = "Кишеньковий Портал Прислужника: Ревендрет", fen = "Limited power remains in this device.", fua = "У цьому пристрої лишилося обмаль сили." }
    t[184502] = { name = "Кишеньковий Портал Прислужника: Малдраксус", fen = "Limited power remains in this device.", fua = "У цьому пристрої лишилося обмаль сили." }
    t[184503] = { name = "Кишеньковий Портал Прислужника: Арденвельд", fen = "Limited power remains in this device.", fua = "У цьому пристрої лишилося обмаль сили." }
    t[184504] = { name = "Кишеньковий Портал Прислужника: Орибос", fen = "Limited power remains in this device.", fua = "У цьому пристрої лишилося обмаль сили." }
    t[184507] = { name = "Загублений Нашийник Люсі", fen = "Teaches you how to summon Lucy.", fua = "Навчає прикликати Люсі." }
    t[184509] = { name = "Спріган-Шахрай", fen = "Teaches you how to summon this pet.", fua = "Навчає вас, як прикликати цього улюбленця." }
    t[184510] = { name = "Кристалізована Стигія", fen = "A shard broken from the massive crystallized structures formed from the essence of shattered souls.", fua = "Скалка, відламана від велетенських кристалізованих споруд, утворених із сутності розбитих душ." }
    t[184511] = { name = "Чорний Руноклинок", fen = "A memento to the sacrifice of the Knights of the Ebon Blade.", fua = "Згадка про жертовність Лицарів Чорного Клинка." }
    t[184512] = { name = "Зимолистий Спріган", fen = "Teaches you how to summon this pet.", fua = "Навчає вас, як прикликати цього улюбленця." }
    t[184513] = { name = "Сфера Утримання", fen = "Keeps subjects safe and fresh.", fua = "Тримає піддослідних у безпеці й свіжості." }
    t[184514] = "Кріс Чароплета Сінфоллу"
    t[184515] = "Латні Чоботи Священного Гаю"
    t[184516] = "Сандалі Туманної Завіси"
    t[184517] = "Чоботи Лісожера"
    t[184518] = "Чоботи Дубового Зібрання"
    t[184519] = "Тотем Викраденого Моджо"
    t[184522] = { name = "Завуальована Сумка Співпраці", fen = "Filled to the brim with gold and augment runes.", fua = "Наповнена по вінця золотом та рунами вдосконалення." }
    t[184523] = "Елізійська Гастрафета із Залізними Болтами"
    t[184524] = "Елізійська Двоклинкова Глефа"
    t[184525] = "Елізійський Гострий Гоплон"
    t[184526] = "Елізійський Фалангітський Спис"
    t[184527] = "Дзвін Елізійського Спостерігача"
    t[184528] = "Елізійські Гільйотинні Пазурі"
    t[184529] = "Елізійський Церемоніальний Кинджал"
    t[184530] = "Дворучний Меч Елізійської Варти"
    t[184531] = "Елізійський Бойовий Молот"
    t[184532] = "Елізійський Дирк зі Срібним Вістрям"
    t[184533] = "Молот Елізійського Ковальчука"
    t[184535] = "Топірець Самовідданого Ковача"
    t[184536] = "Лезо Самовідданого Спостерігача"
    t[184537] = "Фальшіон Самовідданого Ковача"
    t[184538] = "Тесак, Затьмарений Сумнівом"
    t[184539] = "Розумопробивач, Затьмарений Сумнівом"
    t[184540] = "Довгий меч, Затьмарений Сумнівом"
    t[184541] = "Бойова Сокира Гармонійного Збирача"
    t[184542] = "Клинок Гармонійного Форджлайта"
    t[184543] = "Вістря Гармонійного Вартового"
    t[184545] = "Алебарда Гармонійного Носія"
    t[184546] = "Рубака Грішного Гладіатора"
    t[184547] = "Ксифос Грішного Гладіатора"
    t[184548] = "Ритуальний Кинджал Грішного Гладіатора"
    t[184549] = "Спис Дорі Грішного Гладіатора"
    t[184552] = { name = "Рунокуті Кайдани", fen = "Utilized by the Mawsworn to restrain powerful entities, these chains are steeped in Domination magic.", fua = "Ці ланцюги, насичені магією поневолення, прислужники Пащі використовують, щоб стримувати могутніх істот." }
    t[184556] = { name = "Палаючий Злиток", fen = "This ore burns with unquenchable fire. Handle with care.", fua = "Ця руда горить незгасним вогнем. Поводься обережно." }
    t[184560] = { name = "Ритуальний Осередок", fen = "Can be used at a ritual circle", fua = "Можна застосувати в ритуальному колі." }
    t[184561] = { name = "Жаринки Аніми", fen = "You take what you can get down here.", fua = "Тут унизу береш те, що можеш дістати." }
    t[184562] = { name = "Камінь Спокою", fen = "Simple rocks worn smooth by flowing waters are utilized by aspirants as a meditative focus and often crafted into simple jewelry.", fua = "Прості камінці, обточені до гладкості плинною водою, послушники використовують як осередок для медитації й часто перетворюють на нехитрі прикраси." }
    t[184563] = { name = "Конденсатор Аніми", fen = "None but the Collectors understand how to utilize it, but this device is the secret to the potency of Bastion's army of centurions.", fua = "Ніхто, крім Збирачів, не знає, як ним користуватися, та саме цей пристрій є таємницею могутності армії центуріонів Бастіону." }
    t[184564] = { name = "Кіріанська Музична Скринька", fen = "Miniscule bells are rung by tiny chimes that rotate around a spatial representation of Bastion.", fua = "Крихітні дзвіночки дзвонять від маленьких курантів, що обертаються навколо просторового зображення Бастіону." }
    t[184565] = { name = "Кіріанський Симулятор Хвиль", fen = "Acoustically resonant chambers project the sound of water lapping against a shore.", fua = "Акустично резонансні камери відтворюють звук води, що плюскоче об берег." }
    t[184566] = { name = "Попурі Адріми", fen = "The dusty scent of dried flowers gathered from the fields of Bastion enhances mindfulness.", fua = "Курний аромат сухих квітів, зібраних на полях Бастіону, посилює уважність." }
    t[184567] = { name = "Власноруч В'язаний Светр Розпорядника", fen = "Some aspirants find it easier to meditate whilst their hands are in motion, and shed hairs from cloudstriders are in no short supply.", fua = "Деяким послушникам легше медитувати, коли руки в русі, а опалого хутра хмароходів завжди вдосталь." }
    t[184568] = "Короткий Клинок Грішного Гладіатора"
    t[184574] = "Некропосох Грішного Гладіатора"
    t[184576] = "Викрадене спорядження"
    t[184577] = "Поштова Торба Розпорядника"
    t[184578] = "Реміснича Пояс-Сумка для Інструментів"
    t[184579] = { name = "Вирвана Сторінка Щоденника", fen = "A page ripped from the journal of the Broker Pathfinder.", fua = "Сторінка, вирвана з журналу Слідопита-Посередника." }
    t[184580] = "Позолочений Абак"
    t[184585] = { name = "Стигійська Руда", fen = "Durable ore formed from dense concentrations of stygia.", fua = "Міцна руда, утворена з густих скупчень стигії." }
    t[184586] = "Небесний Ланцюг"
    t[184587] = "Засідка"
    t[184588] = { name = "Талісман Стабілізації Душі", fen = "An enchanted talisman, built to protect the wearer's soul against the darkest magics of the Mawsworn.", fua = "Зачарований талісман, створений, щоб захищати душу носія від найтемнішої магії прислужників Пащі." }
    t[184605] = { name = "Сигіл Незримого", fen = "A powerful sigil stolen from the Mawsworn, dabbed in otherworldly ink.", fua = "Могутній сигіл, викрадений у прислужників Пащі, вмочений у потойбічне чорнило." }
    t[184606] = { name = "Тугіший Шов", fen = "Smaller and just as ugly.", fua = "Менший і такий самий потворний." }
    t[184613] = { name = "Замкнена Сутність Розломоходця", fen = "A partial Mawsworn soul, encased in a glassy stone, which fools Chaotic Riftstones into granting the bearer access.", fua = "Частка душі прислужника Пащі, замкнена в склистому камені, що дурить хаотичні камені розломів, змушуючи їх надавати носієві прохід." }
    t[184615] = { name = "Позавимірні Кишені", fen = "These pockets are substantially larger on the inside than they appear.", fua = "Ці кишені всередині значно більші, ніж здаються ззовні." }
    t[184617] = { name = "Браслет Старшинства", fen = "This bangle once indicated Ve'nari's status in the Ve cartel. Now, it belongs to you.", fua = "Колись цей браслет вказував на статус Ве'нарі в картелі Ве. Тепер він належить тобі." }
    t[184618] = { name = "Відзнака Рангу: Закупник", fen = "This certifies you as a deputy of the Ve cartel. Which you are absolutely not, but they won't know that.", fua = "Це засвідчує тебе як повноважного представника картелю Ве. Яким ти абсолютно не є, але вони про це не знатимуть." }
    t[184619] = { name = "Лупа Незвичайних Чарів", fen = "Ve'nari has imbued this jeweler's loupe with a compulsion spell, making some brokers inclined to offer you special deals.", fua = "Ве'нарі наклала на цю ювелірну лупу закляття принади, через що деякі посередники схильні пропонувати тобі особливі угоди." }
    t[184620] = { name = "Посудина Нещасних Духів", fen = "Dangerous magic ties the fate of any who hold this vessel with that of the spirit contained therein.", fua = "Небезпечна магія пов'язує долю кожного, хто тримає цю посудину, з долею ув'язненого в ній духа." }
    t[184621] = { name = "Ритуальна Призма Долі", fen = "Ve'nari has inscribed this crystal with glyphs which are said to ward against the whims of fate.", fua = "Ве'нарі вкарбувала в цей кристал гліфи, що, як кажуть, оберігають від примх долі." }
    t[184622] = "Стигійський Молот"
    t[184626] = "Книга Колядок Зимового Серпанку"
    t[184627] = "Жертовний Червоний Конверт"
    t[184628] = "Жертовний Місячний Камінь Старійшини"
    t[184630] = { name = "Схованка Кравця Шукача Пригод", fen = "Contains an assortment of common Shadowlands cloth.", fua = "Містить набір звичайної тканини Тіньокраю." }
    t[184631] = { name = "Схованка Чаротворця Шукача Пригод", fen = "Contains an assortment of basic Shadowlands enchanting materials.", fua = "Містить набір базових матеріалів для чаротворення Тіньокраю." }
    t[184632] = { name = "Схованка Рибалки Чемпіона", fen = "Contains an assortment of common shadowlands fish.", fua = "Містить набір звичайної риби Тіньокраю." }
    t[184633] = { name = "Схованка М'ясника Чемпіона", fen = "Contains an assortment of common shadowlands meats.", fua = "Містить набір звичайного м'яса Тіньокраю." }
    t[184634] = { name = "Схованка Травника Шукача Пригод", fen = "Contains an assortment of common Shadowlands herbs.", fua = "Містить набір звичайних трав Тіньокраю." }
    t[184635] = { name = "Схованка Гірника Шукача Пригод", fen = "Contains an assortment of common Shadowlands ore.", fua = "Містить набір звичайної руди Тіньокраю." }
    t[184636] = { name = "Схованка Чинбаря Шукача Пригод", fen = "Contains an assortment of common Shadowlands skins.", fua = "Містить набір звичайних шкур Тіньокраю." }
    t[184637] = { name = "Схованка М'ясника Героя", fen = "Contains an assortment of shadowlands meat of all qualities.", fua = "Містить набір м'яса Тіньокраю всіх якостей." }
    t[184638] = { name = "Схованка Рибалки Героя", fen = "Contains an assortment of shadowlands fish of all qualities.", fua = "Містить набір риби Тіньокраю всіх якостей." }
    t[184639] = { name = "Схованка Кравця Чемпіона", fen = "Contains an assortment of shadowlands cloth of all qualities.", fua = "Містить набір тканини Тіньокраю всіх якостей." }
    t[184640] = { name = "Схованка Чинбаря Чемпіона", fen = "Contains an assortment of shadowlands skins of all qualities.", fua = "Містить набір шкур Тіньокраю всіх якостей." }
    t[184641] = { name = "Схованка Гірника Чемпіона", fen = "Contains an assortment of shadowlands ore of all qualities.", fua = "Містить набір руди Тіньокраю всіх якостей." }
    t[184642] = { name = "Схованка Травника Чемпіона", fen = "Contains an assortment of shadowlands herbs of all qualities.", fua = "Містить набір трав Тіньокраю всіх якостей." }
    t[184643] = { name = "Схованка Чаротворця Чемпіона", fen = "Contains an assortment of shadowlands enchanting materials of all qualities.", fua = "Містить набір матеріалів для чаротворення Тіньокраю всіх якостей." }
    t[184644] = { name = "Схованка Кравця Героя", fen = "Contains a large assortment of shadowlands cloth of all qualities.", fua = "Містить великий набір тканини Тіньокраю всіх якостей." }
    t[184645] = { name = "Схованка Чинбаря Героя", fen = "Contains a large assortment of shadowlands skins of all qualities.", fua = "Містить великий набір шкур Тіньокраю всіх якостей." }
    t[184646] = { name = "Схованка Гірника Героя", fen = "Contains a large assortment of shadowlands ore of all qualities.", fua = "Містить великий набір руди Тіньокраю всіх якостей." }
    t[184647] = { name = "Схованка Травника Героя", fen = "Contains a large assortment of shadowlands herbs of all qualities.", fua = "Містить великий набір трав Тіньокраю всіх якостей." }
    t[184648] = { name = "Схованка Чаротворця Героя", fen = "Contains a large assortment of shadowlands enchanting materials of all qualities.", fua = "Містить великий набір матеріалів для чаротворення Тіньокраю всіх якостей." }
    t[184650] = { name = "Поступ Кампанії Пригод", fen = "This challenge leads to additional adventures with greater rewards.", fua = "Це випробування веде до додаткових пригод з більшими винагородами." }
    t[184653] = { name = "Оживлений Ланцюг Левітації", fen = "This segment of magical chain was recovered from a helpless prisoner of the Jailer, lost to the Maw. It still retains a semblance of power.", fua = "Цей сегмент магічного ланцюга врятували з безпорадного бранця Тюремника, загубленого в Пащі. Він досі зберігає подобу сили." }
    t[184654] = "Шаль Забутої Тіні"
    t[184655] = "Пояс Ефірного Слуги"
    t[184656] = "Колет Вбивці-Присяжного Утроби"
    t[184657] = "Наруч Незримого Нападника"
    t[184658] = "Наплічники Жахливого Гонителя"
    t[184659] = "Рукавиці Приборкувача Жахопсів"
    t[184660] = "Великий Шолом Жахової Варти"
    t[184661] = "Наручі Тіньового Почту"
    t[184662] = { name = "Реквізована Комірка Аніми", fen = "This Anima Cell is being offered as a special deal.", fua = "Ця комірка аніми пропонується за особливою угодою." }
    t[184663] = "Будівля: Вартівня"
    t[184665] = "Хроніка Втрачених Спогадів"
    t[184712] = "Осяйні Шати"
    t[184713] = "Осяйна Кіраса"
    t[184714] = "Осяйний Нагрудник"
    t[184715] = "Осяйна Туніка"
    t[184716] = "Нейтралізатор Вартових"
    t[184717] = "Плащ Лорда-Камергера"
    t[184718] = { name = "Викрадена Карта Просоченої Рубінової Мережі", fen = "Tattered and hand-marked, this map will be out of date in a day.", fua = "Подерта й помічена від руки, ця карта застаріє вже за день." }
    t[184719] = { name = "Зачарована Карта Просоченої Рубінової Мережі", fen = "An enchantment keeps this map regularly updated with any changes.", fua = "Зачарування постійно оновлює цю карту відповідно до будь-яких змін." }
    t[184720] = "Відбивний Пояс"
    t[184721] = "Оздоблений Камербанд"
    t[184722] = "Пишна Пряжка"
    t[184723] = "Сяйливий Пояс"
    t[184724] = "Наплічники Придворного"
    t[184725] = "Латні Наплічники Придворного"
    t[184726] = "Оплічник Придворного"
    t[184727] = "Наплічники Придворного"
    t[184728] = "Шолом Шляху"
    t[184729] = "Личина Шляху"
    t[184730] = "Каптур Шляху"
    t[184731] = "Горжет Шляху"
    t[184732] = "Кайдани Тягаря"
    t[184733] = "Наручні Скоби Каяття"
    t[184734] = "Наручі Каяття"
    t[184735] = "Наручні Застібки Ганьби"
    t[184736] = "Роба Сторожа Кордону"
    t[184737] = "Нагрудник Прикордонного Вартового"
    t[184738] = "Кольчуга Прикордонного Вартового"
    t[184739] = "Бліді Зшиті Рукавички"
    t[184740] = "Зміцнені Щелепокроші"
    t[184741] = "Рукавички Учня Некроманта"
    t[184742] = "Деренчливі Кістяні Кулаки"
    t[184744] = "Вузлувата Кісткова Петля"
    t[184745] = "Туніка Вартового Прикордоння"
    t[184746] = "Багнотопи Доглядача Звірини"
    t[184747] = "Капці Єгеря"
    t[184748] = "Чоботи-Бродні Доглядача Звірини"
    t[184749] = "Колючкозахист Доглядача Звірини"
    t[184750] = "Поножі, Окуті Бурштином"
    t[184751] = "Шаровари Доглядача Циклу"
    t[184752] = "Поножі з Луски Ґорма"
    t[184753] = "Штани Деревлаза"
    t[184754] = "Шарф Блискокрилих"
    t[184755] = "Зміцнений Високий Комір"
    t[184756] = { name = "Згладжений Перстень Споглядання", fen = "Worn thin by eons of meditative aid.", fua = "Витончений за еони допомоги в медитації." }
    t[184757] = { name = "Ланцюг Призначених", fen = "The will of the Arbiter is mysterious to all.", fua = "Воля Розсудниці незбагненна для всіх." }
    t[184758] = "Накидка Незбагненного Призначення"
    t[184763] = "Нейронна Мережа Мнеміс"
    t[184764] = "Привід Колоса"
    t[184765] = "Ударний Молот Веспера"
    t[184766] = "Хроніки Взірців"
    t[184767] = "Кишенькове Дзеркало Душ"
    t[184768] = "Кадило з Сухими Пелюстками Грації"
    t[184769] = "Засушений Цвіт Факельної Лілії"
    t[184770] = "Список Забутих"
    t[184771] = "Попіл Пергаменту Спогадів"
    t[184772] = "Ритуальний Кристал Малдрациту"
    t[184773] = "Випробуваний у Бою Компонент Броні"
    t[184774] = "Молодий Спороплет"
    t[184775] = "Некромантія для Практичного Ритуаліста"
    t[184776] = "Урна з Землею Арени"
    t[184777] = "Лопата Гробокопача"
    t[184778] = "Занепала Натрійська Шаль"
    t[184779] = { name = "Часові Листки", fen = "These enchanted leaves speed up the Wildseed of Regrowth process.", fua = "Це зачароване листя пришвидшує визрівання Дикого Сімені Відродження." }
    t[184781] = "Зшита Долею Шаль"
    t[184782] = { name = "Плащ Стиснення Ґаста", fen = "Longer than it looks.", fua = "Довший, ніж здається." }
    t[184783] = "Грозокований Перстень Муірнне"
    t[184784] = { name = "Караючий Перстень", fen = "Embossed with grinning faces, this ring alternates between grumbling and chuckling.", fua = "Оздоблений усміхненими личинами, цей перстень то буркоче, то хихотить." }
    t[184785] = { name = "Шипований Нашийник Ґаязелі", fen = "Fit for every occasion.", fua = "Доречний за будь-якої нагоди." }
    t[184786] = { name = "Шати Переконання Джойї", fen = "Necessity transcends morality.", fua = "Необхідність вища за мораль." }
    t[184787] = "Тягар Терпіння Елогіна"
    t[184788] = "Звабливий Пояс Кіт Джін"
    t[184789] = "Пустотливі Чоботи Найта"
    t[184790] = "Зелені Пальці Архідруїда Ван-Ялі"
    t[184791] = "Місячна Вуаль Азшаріс"
    t[184792] = "Чоботи Гару Кімунда"
    t[184793] = "Поножі Ловчого Саллівана"
    t[184794] = "Дорожній Ланцюг Віллера"
    t[184795] = "Обвуглений Нагрудник Таратоса"
    t[184796] = "Закуті в Залізо Бойові Чоботи Бетеас"
    t[184797] = "Підступне Шило Зінка"
    t[184798] = "Суворий Стилет Гіштара"
    t[184799] = "Вовчоіклий Кулак"
    t[184800] = { name = "Точний Молотильник Клонтзаса", fen = "The Subjugator enables efficiency by any means necessary.", fua = "Підкорювач забезпечує дієвість будь-якими засобами." }
    t[184801] = "Невіддільний Скіпетр Локка"
    t[184802] = "Зазублена Бойова Глефа Дженретт"
    t[184803] = "Алебарда Аґтії"
    t[184804] = "Заспокійливий клеймор Ульфіуса"
    t[184805] = "Баліста Похованих Королів"
    t[184806] = "Дивовижний Щит Кудебега"
    t[184807] = "Релікт Первинних"
    t[184808] = "Кулаки Десма"
    t[184809] = "Тавровані Наплічники Тейбоуна"
    t[184811] = { name = "Винагорода Артемеди", fen = "Contains a huge assortment of crafting materials.", fua = "Містить величезний набір ремісничих матеріалів." }
    t[184812] = { name = "Винагорода Аполона", fen = "Contains a large assortment of crafting materials.", fua = "Містить великий набір ремісничих матеріалів." }
    t[184823] = { name = "Непотрібний Лист", fen = "Refinance you garrison to lock in these new low rates! Good for one hour!", fua = "Перекредитуйте свій гарнізон, щоб зафіксувати ці нові низькі ставки! Дійсно одну годину!" }
    t[184824] = { name = "Непотрібний Лист", fen = "Increase your Spell Power in 7 days! Limited time only!", fua = "Збільш свою силу заклять за 7 днів! Лише обмежений час!" }
    t[184825] = { name = "Непотрібний Лист", fen = "Save 70% on all your reagents with this one easy trick! Offer expires in sixty minutes!", fua = "Заощадь 70% на всіх своїх реагентах завдяки одній простій хитрості! Пропозиція спливає за шістдесят хвилин!" }
    t[184839] = "Несправний Пульт Центуріона"
    t[184840] = "Збірник Гімнів Шляху"
    t[184841] = "Ліра Священного Призначення"
    t[184842] = "Божественний Дзвін Наставника"
    t[184843] = { name = "Врятовані Припаси", fen = "Contains reagents collected by the Stitchmasters.", fua = "Містить реагенти, зібрані Зшивачами." }
    t[184844] = "Тестовий Предмет"
    t[184845] = "Закривавлені Окуляри"
    t[184863] = "9.1 Monster - Hand_1H_BrokerAssassin_C_01 - Red"
    t[184868] = { name = "Схованка Натрійських Скарбів", fen = "Rewards a piece of equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження для вашої спеціалізації здобичі." }
    t[184869] = { name = "Схованка Натрійських Скарбів", fen = "Rewards a piece of equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження для вашої спеціалізації здобичі." }
    t[184870] = "Шукач Стигії"
    t[184876] = { name = "Кристал Зчеплення", fen = "Emits a necrotic attractor binding elements of soul and bone together.", fua = "Випромінює некротичний притягач, що зв'язує елементи душі й кістки докупи." }
    t[184894] = "Креслення Тургадена"
    t[184895] = { name = "Викуваний Рансер", fen = "A remarkably well-crafted weapon, yet to be imbued with power.", fua = "Винятково майстерно зроблена зброя, яку ще належить наснажити силою." }
    t[184901] = { name = "Підсилювач Переходу Негоціантів", fen = "After many mishaps in the dangerous platforms of Coldheart Interstitia and Mort'regar, short range teleportation devices were created to allow safer travel for the brokers trapped within. This device will allow you to see them.", fua = "Після численних нещасть на небезпечних платформах Холодосердної Інтерстиції та Морт'регара було створено пристрої короткосяжної телепортації, щоб забезпечити безпечніше пересування ув'язненим там негоціантам. Цей пристрій дасть вам змогу їх побачити." }
    t[184915] = { name = "Злиток Темної Кузні", fen = "Forged with care by Shadowforge City's finest blacksmiths.", fua = "Дбайливо викуваний найкращими ковалями Тіньокованого Міста." }
    t[184916] = { name = "Киплячий Вогняний Осердя", fen = "What would burn anybody else is only warm to a Dark Iron.", fua = "Те, що спалило б будь-кого іншого, для темнозалізного дворфа лише приємно тепле." }
    t[184917] = { name = "Вогняний Гравер", fen = "Thurgaden's preferred tool for carving traditional runes into his creations.", fua = "Улюблений інструмент Тургадена для викарбовування традиційних рун на своїх витворах." }
    t[184922] = "Арсенал: Зброя Лавкового Горна"
    t[184939] = "Шати Лазурового Присмерку"
    t[184940] = "Капці Лазурового Присмерку"
    t[184941] = "Обмотки Лазурового Присмерку"
    t[184942] = "Каптур Лазурового Присмерку"
    t[184943] = "Поножі Блакитного Присмерку"
    t[184944] = "Оплічник Лазурового Присмерку"
    t[184945] = "Пояс Лазурового Присмерку"
    t[184946] = "Пов'язки Лазурового Присмерку"
    t[184947] = "Накидка Лазурового Присмерку"
    t[184948] = "Шати Сутінкового Гаю"
    t[184949] = "Капці Сутінкового Гаю"
    t[184950] = "Наручні Обмотки Сутінкового Гаю"
    t[184951] = "Каптур Сутінкового Гаю"
    t[184952] = "Поножі Сутінкового Гаю"
    t[184953] = "Оплічник Присмеркового Гаю"
    t[184954] = "Пояс Присмеркового Гаю"
    t[184955] = "Обмотки Сутінкового Гаю"
    t[184956] = "Накидка Сутінкового Гаю"
    t[184957] = "Шати Осінньої Обіцянки"
    t[184958] = "Капці Осінньої Обітниці"
    t[184959] = "Наручні Обмотки Осінньої Обітниці"
    t[184960] = "Каптур Осінньої Обіцянки"
    t[184961] = "Поножі Осінньої Обітниці"
    t[184962] = "Оплічник Осінньої Обіцянки"
    t[184963] = "Пояс Осінньої Обіцянки"
    t[184964] = "Обмотки Осінньої Обітниці"
    t[184965] = "Накидка Осінньої Обіцянки"
    t[184966] = "Шати Чистого Зору"
    t[184967] = "Капці Чистого Зору"
    t[184968] = "Обмотки Чистого Зору"
    t[184969] = "Каптур Чистого Зору"
    t[184970] = "Поножі Чистого Зору"
    t[184971] = "Оплічник Чистого Зору"
    t[184972] = "Пояс Чистого Зору"
    t[184973] = "Наручі Чистого Зору"
    t[184974] = "Плащ Чистого Зору"
    t[184975] = "Шати Гінця Бойовища"
    t[184976] = "Капці Гінця Бойовища"
    t[184977] = "Обмотки Гінця Бойовища"
    t[184978] = "Каптур Гінця Бойовища"
    t[184979] = "Поножі Гінця Бойовища"
    t[184980] = "Пояс Гінця Бойовища"
    t[184981] = "Наручі Гінця Бойовища"
    t[184982] = "Накидка Гінця Бойовища"
    t[184983] = "Шати Зреченого Претендента"
    t[184984] = "Капці Зреченого Претендента"
    t[184985] = "Накручі Зреченого Претендента"
    t[184986] = "Каптур Зреченого Претендента"
    t[184987] = "Поножі Зреченого Послушника"
    t[184988] = "Пояс Зреченого Претендента"
    t[184989] = "Обмотки Зреченого Претендента"
    t[184990] = "Плащ Зреченого Претендента"
    t[184991] = "Шати Завзятого Претендента"
    t[184992] = "Капці Завзятого Претендента"
    t[184993] = "Обмотки Завзятого Претендента"
    t[184994] = "Каптур Завзятого Претендента"
    t[184995] = "Поножі Завзятого Претендента"
    t[184996] = "Пояс Завзятого Претендента"
    t[184997] = "Обмотки Завзятого Претендента"
    t[184998] = "Накидка Завзятого Претендента"
    t[184999] = "Шати Відданого Претендента"
    t[185000] = "Капці Відданого Претендента"
    t[185001] = "Обмотки Відданого Претендента"
    t[185002] = "Каптур Відданого Претендента"
    t[185003] = "Поножі Відданого Претендента"
    t[185004] = "Пояс Відданого Претендента"
    t[185005] = "Обмотки Відданого Претендента"
    t[185006] = "Плащ Відданого Претендента"
    t[185007] = "Роба Відданого Претендента"
    t[185008] = "Роба Завзятого Претендента"
    t[185009] = "Роба Зреченого Претендента"
    t[185010] = "Роба Гінця Бойовища"
    t[185011] = "Шати Некроманта-Відступника"
    t[185012] = "Капці Некроманта-Відступника"
    t[185013] = "Обмотки Некроманта-Відступника"
    t[185014] = "Каптур Некроманта-Відступника"
    t[185015] = "Поножі Відступника-Некроманта"
    t[185016] = "Оплічник Некроманта-Відступника"
    t[185017] = "Пояс Некроманта-Відступника"
    t[185018] = "Намотки Некроманта-Відступника"
    t[185019] = "Плащ Некроманта-Відступника"
    t[185020] = "Некромантійні Шати Послушника"
    t[185021] = "Некромантійні Капці Послушника"
    t[185022] = "Некромантійні Рукавички Послушника"
    t[185023] = "Некромантійний Каптур Послушника"
    t[185024] = "Некромантські Поножі Послушника"
    t[185025] = "Некромантійні Наплічники Послушника"
    t[185026] = "Некромантійний Пояс Послушника"
    t[185027] = "Некромантійні Наручі Послушника"
    t[185028] = "Некромантійний Плащ Послушника"
    t[185029] = "Шати Помічника Марілета"
    t[185030] = "Капці Помічника Марілета"
    t[185031] = "Рукавиці Помічника Марілета"
    t[185032] = "Каптур Помічника Марілета"
    t[185033] = "Поножі Помічника Марілета"
    t[185034] = "Оплічник Помічника Марілета"
    t[185035] = "Пояс Помічника Марілета"
    t[185036] = "Наручі Помічника Марілета"
    t[185037] = "Накидка Помічника Марілета"
    t[185038] = "Шати Передового Некроманта"
    t[185039] = "Капці Передового Некроманта"
    t[185040] = "Накручі Передового Некроманта"
    t[185041] = "Каптур Передового Некроманта"
    t[185042] = "Поножі Некроманта Передової"
    t[185043] = "Оплічник Передового Некроманта"
    t[185044] = "Пояс Передового Некроманта"
    t[185045] = "Обмотки Передового Некроманта"
    t[185046] = "Плащ Передового Некроманта"
    t[185047] = "Душа Яка"
    t[185048] = "Душа Лопатоікла"
    t[185049] = "Душа Сауроліска"
    t[185050] = "Душа Павука"
    t[185051] = "Душа Жахорога"
    t[185052] = "Душа Бегемота"
    t[185053] = "Душа Кодо"
    t[185054] = "Душа Мамонта"
    t[185056] = { name = "Зруйнована Стела", fen = "An ancient stone tablet covered in runes and radiating strange magic.", fua = "Прадавня кам'яна табличка, вкрита рунами й випромінює дивну магію." }
    t[185057] = "Шати Двору Женців"
    t[185058] = "Капці Двору Женців"
    t[185059] = "Рукавиці Двору Женців"
    t[185060] = "Каптур Двору Женців"
    t[185061] = "Двірські Поножі Женця"
    t[185062] = "Пояс Двору Женців"
    t[185063] = "Наручі Двору Женців"
    t[185064] = "Плащ Двору Женців"
    t[185065] = "Шати Бойовища Ренатала"
    t[185066] = "Капці Бойовища Ренатала"
    t[185067] = "Рукавички Бойовища Ренатала"
    t[185068] = "Каптур Бойовища Ренатала"
    t[185069] = "Бойові Поножі Ренатала"
    t[185070] = "Пояс Бойовища Ренатала"
    t[185071] = "Наручі Бойовища Ренатала"
    t[185072] = "Плащ Бойовища Ренатала"
    t[185073] = "Плащ Сяйливого Двору"
    t[185074] = "Наручі Сяйливого Двору"
    t[185075] = "Пояс Сяйливого Двору"
    t[185076] = "Поножі Осяйного Двору"
    t[185077] = "Каптур Сяйливого Двору"
    t[185078] = "Обмотки Рук Сяйливого Двору"
    t[185079] = "Капці Сяйливого Двору"
    t[185080] = "Шати Сяйливого Двору"
    t[185081] = "Вентирські Шати Сінфолу"
    t[185082] = "Вентирські Капці Сінфолу"
    t[185083] = "Вентирські Обмотки Рук Сінфолу"
    t[185084] = "Вентирський Каптур Сінфолу"
    t[185085] = "Поножі Вентирів Сінфоллу"
    t[185086] = "Вентирський Пояс Сінфолу"
    t[185087] = "Вентирські Наручні Обмотки Сінфолу"
    t[185088] = "Вентирська Шаль Сінфолу"
    t[185089] = "Роба Придворного Інквізитора"
    t[185090] = "Капці Придворного Інквізитора"
    t[185091] = "Рукавиці Придворного Інквізитора"
    t[185092] = "Каптур Придворного Інквізитора"
    t[185093] = "Поножі Двірського Інквізитора"
    t[185094] = "Оплічник Придворного Інквізитора"
    t[185095] = "Пояс Придворного Інквізитора"
    t[185096] = "Наручні Обмотки Придворного Інквізитора"
    t[185097] = "Плащ Придворного Інквізитора"
    t[185098] = "Польовий Плащ Інквізитора Ренатала"
    t[185099] = "Польові Наручі Інквізитора Ренатала"
    t[185100] = "Польовий Пояс Інквізитора Ренатала"
    t[185101] = "Польовий Оплічник Інквізитора Ренатала"
    t[185102] = "Поножі Польового Інквізитора Ренатала"
    t[185103] = "Польовий Каптур Інквізитора Ренатала"
    t[185104] = "Польові Рукавички Інквізитора Ренатала"
    t[185105] = "Польові Черевики Інквізитора Ренатала"
    t[185106] = "Польова Роба Інквізитора Ренатала"
    t[185107] = "Роба Спокутуваного Інквізитора"
    t[185108] = "Капці Спокутуваного Інквізитора"
    t[185109] = "Рукавички Спокутуваного Інквізитора"
    t[185110] = "Каптур Спокутуваного Інквізитора"
    t[185111] = "Поножі Спокутуваного Інквізитора"
    t[185112] = "Оплічник Спокутуваного Інквізитора"
    t[185113] = "Пояс Спокутуваного Інквізитора"
    t[185114] = "Наручі Спокутуваного Інквізитора"
    t[185115] = "Плащ Спокутуваного Інквізитора"
    t[185116] = "Роба Грішного Інквізитора"
    t[185117] = "Капці Грішного Інквізитора"
    t[185118] = "Рукавиці Грішного Інквізитора"
    t[185119] = "Каптур Грішного Інквізитора"
    t[185120] = "Поножі Грішного Інквізитора"
    t[185121] = "Оплічник Грішного Інквізитора"
    t[185122] = "Пояс Грішного Інквізитора"
    t[185123] = "Наручі Грішного Інквізитора"
    t[185124] = "Шаль Грішного Інквізитора"
    t[185125] = "Колун Розкутого Гладіатора"
    t[185126] = "Захисник Розкутого Гладіатора"
    t[185127] = "Латний Шолом Розкутого Шукача"
    t[185128] = "Плащ Розкутого Шукача"
    t[185129] = "Шовкова Роба Розкутого Претендента"
    t[185130] = "Латний Нагрудник Розкутого Шукача"
    t[185131] = "Кольчужний Нагрудник Розкутого Шукача"
    t[185132] = "Шкіряний Нагрудник Розкутого Шукача"
    t[185133] = "Латні Бойові Чоботи Розкутого Претендента"
    t[185134] = "Шовкові Чоботи Розкутого Претендента"
    t[185135] = "Кольчужні Чоботи Розкутого Шукача"
    t[185136] = "Шкіряні Чоботи Розкутого Шукача"
    t[185137] = "Шкіряні Рукавички Розкутого Шукача"
    t[185138] = "Латні Рукавиці Розкутого Шукача"
    t[185139] = "Шовкові Рукавички Розкутого Претендента"
    t[185140] = "Кольчужні Латні Рукавиці Розкутого Шукача"
    t[185141] = "Шовковий Каптур Розкутого Претендента"
    t[185142] = "Кольчужний Шолом Розкутого Шукача"
    t[185143] = "Шкіряний Шолом Розкутого Шукача"
    t[185144] = "Латні Поножі Розкутого Претендента"
    t[185145] = "Шовкові Поножі Розкутого Претендента"
    t[185146] = "Кольчужні Поножі Розкутого Претендента"
    t[185147] = "Шкіряні Штани Розкутого Претендента"
    t[185148] = "Шкіряні Наплічники Розкутого Шукача"
    t[185149] = "Латні Наплічники Розкутого Претендента"
    t[185150] = "Шовковий Оплічник Розкутого Претендента"
    t[185151] = "Кольчужні Оплічники Розкутого Шукача"
    t[185152] = "Латний Пояс Розкутого Шукача"
    t[185153] = "Шовковий Пояс Розкутого Претендента"
    t[185154] = "Кольчужний Пояс Розкутого Шукача"
    t[185155] = "Шкіряний Пояс Розкутого Шукача"
    t[185156] = "Перстень Розкутого Претендента"
    t[185157] = "Шовкові Наручі Розкутого Претендента"
    t[185158] = "Латні Манжети Розкутого Шукача"
    t[185159] = "Кольчужні Наручні Пов'язки Розкутого Шукача"
    t[185160] = "Шкіряні Наручні Пов'язки Розкутого Шукача"
    t[185161] = "Значок Лютості Розкутого Претендента"
    t[185162] = "Намисто Розкутого Шукача"
    t[185163] = "Латний Шолом Розкутого Гладіатора"
    t[185164] = "Плащ Розкутого Гладіатора"
    t[185165] = "Шовкова Роба Нескутого Гладіатора"
    t[185166] = "Латний Нагрудник Розкутого Гладіатора"
    t[185167] = "Кольчужний Нагрудник Розкутого Гладіатора"
    t[185168] = "Шкіряний Нагрудник Розкутого Гладіатора"
    t[185169] = "Латні Бойові Чоботи Розкутого Гладіатора"
    t[185170] = "Шовкові Капці Нескутого Гладіатора"
    t[185171] = "Кольчужні Сабатони Розкутого Гладіатора"
    t[185172] = "Шкіряні Чоботи Розкутого Гладіатора"
    t[185173] = "Шкіряні Рукавички Розкутого Гладіатора"
    t[185174] = "Латні Рукавиці Розкутого Гладіатора"
    t[185175] = "Шовкові Рукавички Нескутого Гладіатора"
    t[185176] = "Кольчужні Латні Рукавиці Розкутого Гладіатора"
    t[185177] = "Шовковий Каптур Нескутого Гладіатора"
    t[185178] = "Кольчужний Шолом Розкутого Гладіатора"
    t[185179] = "Шкіряний Шолом Розкутого Гладіатора"
    t[185180] = "Латні Поножі Розкутого Гладіатора"
    t[185181] = "Шовкові Поножі Розкутого Гладіатора"
    t[185182] = "Кольчужні Поножі Розкутого Гладіатора"
    t[185183] = "Шкіряні Штани Розкутого Гладіатора"
    t[185184] = "Шкіряні Наплічники Розкутого Гладіатора"
    t[185185] = "Латні Наплічники Розкутого Гладіатора"
    t[185186] = "Шовковий Оплічник Нескутого Гладіатора"
    t[185187] = "Кольчужні Наплічники Розкутого Гладіатора"
    t[185188] = "Латний Пояс Розкутого Гладіатора"
    t[185189] = "Шовковий Пояс Нескутого Гладіатора"
    t[185190] = "Кольчужний Пояс Розкутого Гладіатора"
    t[185191] = "Шкіряний Пояс Розкутого Гладіатора"
    t[185192] = "Перстень Розкутого Гладіатора"
    t[185193] = "Шовкові Наручі Нескутого Гладіатора"
    t[185194] = "Латні Наручі Розкутого Гладіатора"
    t[185195] = "Кольчужні Наручі Розкутого Гладіатора"
    t[185196] = "Шкіряні Наручі Розкутого Гладіатора"
    t[185197] = "Значок Лютості Розкутого Гладіатора"
    t[185198] = "Намисто Розкутого Гладіатора"
    t[185199] = "Гладіус Розкутого Гладіатора"
    t[185200] = "Церемоніальний Меч Розкутого Гладіатора"
    t[185201] = "Легкий Лук Розкутого Гладіатора"
    t[185202] = "Ніж Розкутого Гладіатора"
    t[185203] = "Келих Розкутого Гладіатора"
    t[185204] = "Латний Захист Голови Розкутого Шукача"
    t[185205] = "Накидка Розкутого Шукача"
    t[185206] = "Шовкова Роба Розкутого Претендента"
    t[185207] = "Латний Обладунок Розкутого Шукача"
    t[185208] = "Кольчужна Туніка Розкутого Шукача"
    t[185209] = "Шкіряна Туніка Розкутого Шукача"
    t[185210] = "Латні Чоботи Розкутого Претендента"
    t[185211] = "Шовкові Чоботи Розкутого Претендента"
    t[185212] = "Кольчужні Чоботиська Розкутого Шукача"
    t[185213] = "Шкіряні Черевики Розкутого Шукача"
    t[185214] = "Шкіряні Рукавиці Розкутого Шукача"
    t[185215] = "Латні Рукавиці Розкутого Шукача"
    t[185216] = "Шовкові Рукавиці Розкутого Претендента"
    t[185217] = "Кольчужні Рукавиці Розкутого Шукача"
    t[185218] = "Шовковий Каптур Розкутого Претендента"
    t[185219] = "Кольчужний Захист Голови Розкутого Шукача"
    t[185220] = "Шкіряна Маска Розкутого Шукача"
    t[185221] = "Латні Бойові Поножі Розкутого Претендента"
    t[185222] = "Шовкові Обмотки Розкутого Претендента"
    t[185223] = "Кольчужні Бойові Поножі Розкутого Претендента"
    t[185224] = "Шкіряні Поножі Розкутого Претендента"
    t[185225] = "Шкіряний Оплічник Розкутого Шукача"
    t[185226] = "Латні Наплічники Розкутого Претендента"
    t[185227] = "Шовкова Шаль Розкутого Претендента"
    t[185228] = "Кольчужні Наплічники Розкутого Шукача"
    t[185229] = "Латний Широкий Пояс Розкутого Шукача"
    t[185230] = "Шовковий Пояс Розкутого Претендента"
    t[185231] = "Кольчужна Застібка Розкутого Шукача"
    t[185232] = "Шкіряний Поясок Розкутого Шукача"
    t[185233] = "Перстень Розкутого Шукача"
    t[185234] = "Шовкові Наручі Розкутого Претендента"
    t[185235] = "Латні Наручі Розкутого Шукача"
    t[185236] = "Кольчужні Наручі Розкутого Шукача"
    t[185237] = "Шкіряні Наручі Розкутого Шукача"
    t[185238] = "Відзнака Запалу Розкутого Претендента"
    t[185239] = "Намисто Розкутого Шукача"
    t[185240] = "Плащ Розкутого Шукача"
    t[185241] = "Перстень-Печатка Розкутого Претендента"
    t[185242] = "Емблема Розкутого Претендента"
    t[185243] = "Підвіска Розкутого Шукача"
    t[185244] = "Латний Шолом Розкутого Гладіатора"
    t[185245] = "Накидка Розкутого Гладіатора"
    t[185246] = "Шовкові Шати Нескутого Гладіатора"
    t[185247] = "Латний Нагрудник Розкутого Гладіатора"
    t[185248] = "Кольчужна Туніка Розкутого Гладіатора"
    t[185249] = "Шкіряний Нагрудник Розкутого Гладіатора"
    t[185250] = "Латні Чоботи Розкутого Гладіатора"
    t[185251] = "Шовкові Чоботи Нескутого Гладіатора"
    t[185252] = "Кольчужні Чоботи Розкутого Гладіатора"
    t[185253] = "Шкіряні Чоботи Розкутого Гладіатора"
    t[185254] = "Шкіряні Рукавиці Розкутого Гладіатора"
    t[185255] = "Латні Рукавиці Розкутого Гладіатора"
    t[185256] = "Шовкові Обмотки Рук Нескутого Гладіатора"
    t[185257] = "Кольчужні Рукавиці Розкутого Гладіатора"
    t[185258] = "Шовковий Каптур Нескутого Гладіатора"
    t[185259] = "Кольчужне Забрало Розкутого Гладіатора"
    t[185260] = "Шкіряна Маска Розкутого Гладіатора"
    t[185261] = "Латні Бойові Поножі Розкутого Гладіатора"
    t[185262] = "Шовкові Штани Розкутого Гладіатора"
    t[185263] = "Кольчужні Штани Розкутого Гладіатора"
    t[185264] = "Шкіряні Обмотки Розкутого Гладіатора"
    t[185265] = "Шкіряні Наплічники Розкутого Гладіатора"
    t[185266] = "Латні Наплічники Розкутого Гладіатора"
    t[185267] = "Шовковий Амікт Розкутого Гладіатора"
    t[185268] = "Кольчужні Наплічники Розкутого Гладіатора"
    t[185269] = "Латний Великий Пояс Розкутого Гладіатора"
    t[185270] = "Шовковий Пояс Розкутого Гладіатора"
    t[185271] = "Кольчужний Пояс Розкутого Гладіатора"
    t[185272] = "Шкіряний Пояс Розкутого Гладіатора"
    t[185273] = "Перстень Розкутого Гладіатора"
    t[185274] = "Шовкові Наручі Розкутого Гладіатора"
    t[185275] = "Латні Наручі Розкутого Гладіатора"
    t[185276] = "Кольчужні Наручі Розкутого Гладіатора"
    t[185277] = "Шкіряні Наручі Розкутого Гладіатора"
    t[185278] = "Відзнака Запалу Розкутого Гладіатора"
    t[185279] = "Підвіска Розкутого Гладіатора"
    t[185280] = "Шаль Розкутого Гладіатора"
    t[185281] = "Перстень-Печатка Розкутого Гладіатора"
    t[185282] = "Емблема Розкутого Гладіатора"
    t[185283] = "Амулет Розкутого Гладіатора"
    t[185284] = "Бойова Сокира Розкутого Претендента"
    t[185285] = "Кинджал Розкутого Претендента"
    t[185286] = "Булава Розкутого Претендента"
    t[185287] = "Древкова зброя розкутого претендента"
    t[185288] = "Посох розкутого претендента"
    t[185289] = "Меч Розкутого Претендента"
    t[185290] = "Дворучна сокира розкутого претендента"
    t[185291] = "Дворучний меч розкутого претендента"
    t[185292] = "Сфера Розкутого Шукача"
    t[185293] = "Бойова Глефа Розкутого Претендента"
    t[185294] = "Молот Розкутого Претендента"
    t[185295] = "Бар'єр Розкутого Шукача"
    t[185296] = "Топірець Розкутого Претендента"
    t[185297] = "Лук Подвійного Вигину Розкутого Претендента"
    t[185298] = "Довгий спис розкутого претендента"
    t[185299] = "Клинок Розкутого Претендента"
    t[185300] = "Вечірній дзвін розкутого гладіатора"
    t[185301] = "Дворучна сокира розкутого гладіатора"
    t[185302] = "Престижний Плащ Розкутого Гладіатора"
    t[185303] = "Накидка Нескутого Гладіатора"
    t[185304] = "Медальйон Розкутого Гладіатора"
    t[185305] = "Невблаганна Брошка Розкутого Гладіатора"
    t[185306] = "Сигіл Пристосування Розкутого Гладіатора"
    t[185307] = "Кийок Розкутого Претендента"
    t[185308] = "Серп Розкутого Претендента"
    t[185309] = "Медальйон Розкутого Претендента"
    t[185310] = "Невблаганна Брошка Розкутого Претендента"
    t[185311] = "Сигіл Пристосування Розкутого Претендента"
    t[185312] = "Бойова Глефа Розкутого Гладіатора"
    t[185313] = "Великий Плащ Розкутого Гладіатора"
    t[185314] = "Рубака Розкутого Гладіатора"
    t[185315] = "Ксифос Розкутого Гладіатора"
    t[185316] = "Ритуальний Кинджал Розкутого Гладіатора"
    t[185317] = "Дорі розкутого гладіатора"
    t[185455] = "9.1 Monster - Hand_1H_BrokerAssassin_C_01 - Green"
    t[185456] = "9.1 Monster - Hand_1H_BrokerAssassin_C_01 - Blue"
    t[185457] = "9.1 Monster - Hand_1H_BrokerAssassin_C_01 - White"
    t[185473] = { name = "Інструменти Душокова", fen = "A set of tools used by the Mawsworn when Soul Forging.", fua = "Набір інструментів, якими користуються пов'язані Пащею для кування душ." }
    t[185474] = { name = "Броньована Оболонка", fen = "An armored husk inscribed with runes.", fua = "Броньована оболонка, поцяткована рунами." }
    t[185476] = "Плинні Гребеневі Шипи"
    t[185479] = "Звивиста Перетинка Крила"
    t[185480] = "Яскраво Забарвлений Чубчик"
    t[185481] = "Довгий Волокнистий Язик"
    t[185485] = { name = "Знищувач Рун", fen = "Removes the toughest stains and magical enhancements.", fua = "Видаляє найстійкіші плями та магічні підсилення." }
    t[185561] = "9.2 Monster - Hand_1H_ProgenitorRaid_D_01 - Black"
    t[185562] = "9.2 Monster - Hand_1H_ProgenitorRaid_D_01 - Bronze"
    t[185563] = "9.2 Monster - Hand_1H_ProgenitorRaid_D_01 - Gold"
    t[185564] = "9.2 Monster - Hand_1H_ProgenitorRaid_D_01 - Green"
    t[185565] = "9.2 Monster - Hand_1H_ProgenitorRaid_D_01 - Light Gold"
    t[185566] = "9.2 Monster - Hand_1H_ProgenitorRaid_D_01 - Red"
    t[185615] = { name = "Повернена Фантазма", fen = "There's a little extra in here...", fua = "Тут є трошки більше..." }
    t[185636] = { name = "Кодекс Архіваріусів", fen = "A chronicle of all the relics the Archivists are charged with securing and studying.", fua = "Літопис усіх реліквій, які архіваріуси покликані оберігати й вивчати." }
    t[185681] = { name = "Яйце Теотара", fen = "Happily painted with all the colors of the rainbow. Bring it to Theotar. (|cfff2e699+Bonus Happiness|r)", fua = "Радісно розписане всіма барвами веселки. Віднесіть його Теотару. (|cfff2e699+Бонусна радість|r)" }
    t[185682] = { name = "Яйце Темела", fen = "Descriptions of horrifying sins have been etched into the shell. Bring it to Temel. (|cff34cceb+Bonus Time|r)", fua = "На шкаралупі вигравіювано описи жахливих гріхів. Віднесіть його Темелу. (|cff34cceb+Бонусний час|r)" }
    t[185683] = { name = "Яйце Принца Ренатала", fen = "Carefully painted with the symbols of his guests' covenants. Bring it to Prince Renathal.", fua = "Дбайливо розписане символами ковенантів його гостей. Віднесіть його принцу Ренаталу." }
    t[185684] = { name = "Яйце Лорда Гаррідана", fen = "Every line is carefully painted, with no speck out of place. Bring it to Lord Garridan.", fua = "Кожну лінію виведено старанно, без жодної зайвої цяточки. Віднесіть його лорду Гаррідану." }
    t[185685] = "Болти Автоматона"
    t[185716] = { name = "Тріснутий Запис", fen = "Anima weakly pulses out of this device. Strange symbols can be seen in the cracks.", fua = "З цього пристрою слабко струменіє аніма. У тріщинах видніються дивні символи." }
    t[185717] = { name = "Сплячий Дух", fen = "A spirit which can be nutured in the Queen's Conservatory.", fua = "Дух, якого можна виплекати в Оранжереї Королеви." }
    t[185719] = { name = "Просочені Анімою Кістки", fen = "These bones pulse with anima and are incredibly tough.", fua = "Ці кістки пульсують анімою і є неймовірно міцними." }
    t[185720] = { name = "Бойовий Ріг Драки", fen = "A warhorn made of bone. Runes are inscribed along the stone fittings.", fua = "Бойовий ріг із кістки. Уздовж кам'яних оздоб викарбувані руни." }
    t[185727] = { name = "Бойовий Ріг Драки", fen = "A warhorn made of bone. Runes are inscribed along the stone fittings.", fua = "Бойовий ріг із кістки. Уздовж кам'яних оздоб викарбувані руни." }
    t[185729] = "Заряджена Анімою Руна"
    t[185733] = { name = "Частинка Аніми", fen = "A distillation of anima. Capable of empowering a Centurion.", fua = "Дистиляція аніми. Здатна наснажити центуріона." }
    t[185734] = "Куля Одкровення"
    t[185735] = { name = "Навершя Рудного Посоха", fen = "The head of an enigmatic staff. Archivist Roh-Senara insisted that it was imperative to keep this out of the hands of the mawsworn.", fua = "Навершя загадкового посоха. Архіваріус Ро-Сенара наполягала, що конче необхідно вберегти його від рук пов'язаних Пащею." }
    t[185736] = { name = "Сяйлива Золота Пір'їна", fen = "A bright, golden light is fading from this feather. It was lost fairly recently and it's owner may be nearby.", fua = "Яскраве золоте світло згасає в цій пір'їні. Її загублено зовсім нещодавно, тож власник може бути неподалік." }
    t[185737] = "Дрібні Ланки Ланцюга"
    t[185738] = "Гелекована Печатка"
    t[185740] = { name = "Голова Азодія", fen = "The still warm head of the Nathrezim Azodius. Highlord Bolvar should be informed of the threat.", fua = "Ще тепла голова натрезима Азодія. Верховного лорда Болвара слід сповістити про загрозу." }
    t[185741] = { name = "Поповнення та Лагодження: Поради й Хитрощі для Безперервного Свята", fen = "Teaches your Dredger Butler how to deal with the more tedious realities of party planning on your behalf, removing the need for you to manually restock or repair any amenities after an Ember Court.", fua = "Навчає вашого дворецького-копача залагоджувати за вас більш марудні турботи з організації свята, тож вам більше не доведеться вручну поповнювати запаси чи лагодити будь-що після Попелястого Двору." }
    t[185742] = "Кайдани Присяжних Утроби"
    t[185743] = { name = "Видерта Сторінка", fen = "A page torn from the Fatescribe's journal.", fua = "Сторінка, вирвана з журналу Писаря Долі." }
    t[185746] = { name = "Викрадений Криптограф", fen = "Part of a complex lock and key system necessary to gain access to a vault.", fua = "Частина складної системи замка й ключа, потрібної, щоб отримати доступ до сховища." }
    t[185756] = { name = "Спотворена Фантазма", fen = "There is something strange about this, Ve'nari will find it interesting.", fua = "У цьому є щось дивне, Ве'нарі це зацікавить." }
    t[185757] = { name = "Дослідження Навігації Потойбіччя", fen = "Positional data for some of the various afterlives that compose the Shadowlands. The diagrams and accompanying calculations on the scroll are dense and incomprehensible.", fua = "Дані про розташування деяких з різних потойбічних світів, що складають Тіньокрай. Діаграми та супутні обчислення на сувої щільні й незрозумілі." }
    t[185758] = { name = "Запис Спостережень", fen = "A packet of data from a broker surveillance device.", fua = "Пакет даних із пристрою стеження посередника." }
    t[185759] = { name = "Держак Рудного Посоха", fen = "The shaft of an enigmatic staff. Archivist Roh-Senara insisted that it was imperative to keep this out of the hands of the mawsworn.", fua = "Держак загадкового посоха. Архіваріус Ро-Сенара наполягала, що конче необхідно вберегти його від рук пов'язаних Пащею." }
    t[185760] = { name = "Руків'я Рудного Посоха", fen = "The handle of an enigmatic staff. Archivist Roh-Senara insisted that it was imperative to keep this out of the hands of the mawsworn.", fua = "Руків'я загадкового посоха. Архіваріус Ро-Сенара наполягала, що конче необхідно вберегти його від рук пов'язаних Пащею." }
    t[185761] = { name = "Зім'ятий Бунтівний Памфлет", fen = "The pamphlet casts doubt on Sin'dane's ability to lead the House of Rituals.", fua = "Памфлет ставить під сумнів здатність Сін'дане очолювати Дім Ритуалів." }
    t[185762] = "Незримі Гості Серед Нас"
    t[185763] = { name = "Запечатаний Контейнер", fen = "Surprisingly light, but contains valuable Korthian relics.", fua = "Напрочуд легкий, але містить цінні кортіанські релікти." }
    t[185765] = { name = "Партія Важкої Грубої Шкіри", fen = "Contains 10 Heavy Callous Hide.", fua = "Містить 10 одиниць важкої грубої шкіри." }
    t[185766] = { name = "Некролітовий Фокусувальний Кристал", fen = "A small, humming crystal.", fua = "Невеликий кристал, що гуде." }
    t[185767] = { name = "Складене Послання", fen = "The missive indicates Ke'Thuzad will call on his followers soon and mentions a \"gathering among the stalks.\"", fua = "Послання вказує, що Кел'Тузад невдовзі скличе своїх прибічників, і згадує «зібрання серед стебел»." }
    t[185768] = { name = "Напівспалений Сувій", fen = "What remains  mentions a gathering for the like-minded in the south, and promises power very soon.", fua = "У залишках згадується зібрання однодумців на півдні та обіцянка скорої могутності." }
    t[185769] = { name = "Подерта Записка", fen = "All you can read is \"The time is nigh. Be ready!\"", fua = "Усе, що можна розібрати: «Час близько. Будьте напоготові!»" }
    t[185770] = { name = "Половина Розмитого Листа", fen = "The letter asks the recipient to steal certain ritual items for Kel'Thuzad's use as well as to cause chaos.", fua = "Лист просить отримувача викрасти певні ритуальні предмети для потреб Кел'Тузада, а також посіяти хаос." }
    t[185771] = { name = "Знаряддя Писаря Долі", fen = "This object is a powerful focus that allows the Fatescribe to perform sacred rituals.", fua = "Цей предмет - потужне осердя, що дозволяє Писарю Долі вершити священні ритуали." }
    t[185772] = "Дра'ґора"
    t[185773] = { name = "Жетон Прихильності Барона Кел'Тузада", fen = "A small token indicating the bearer remains loyal to Kel'Thuzad.", fua = "Невеликий жетон, що засвідчує відданість власника Кел'Тузаду." }
    t[185774] = "PH Green Head Candle"
    t[185776] = "Владний Погляд Гуктейла"
    t[185777] = "Ікло Алкрукса"
    t[185778] = "Перший Кулак Картелю Со"
    t[185779] = "Шпиль очищення"
    t[185780] = "Білувальний Клинок Дізнавача"
    t[185781] = "Накидка Титанічних Снів"
    t[185782] = "Роба Опівнічних Оборудок"
    t[185783] = "Ясам Розломолам"
    t[185784] = "Бойові Лати Спалаху Нової"
    t[185785] = "Обійми Зв'язувача Реліквій"
    t[185786] = "Фрактальний Жилет Со'азмі"
    t[185787] = { name = "Невблаганні Всепогодні Чоботи", fen = "Neither snow nor rain nor heat nor gloom of night.", fua = "Ні сніг, ні дощ, ні спека, ні нічна темрява." }
    t[185788] = "Хитромудрі Сандалі Шифрозламувача"
    t[185789] = "Латні Чоботи Виміряного Часу"
    t[185790] = "Чоботи Титанічної Деконверсії"
    t[185791] = "Рукавички Кулачного Бійця"
    t[185792] = "Незламна Хватка Ахілліта"
    t[185793] = "Зашифровані Рукавички"
    t[185794] = "Рукавички-Молотобійці"
    t[185795] = "Каптур Розгалуженої Долі"
    t[185796] = "Діадема Драконьої Погибелі"
    t[185797] = "Хвацько Заломлена Трикутка"
    t[185798] = "Квантові Поножі"
    t[185799] = "Надлегкі Поножі"
    t[185800] = "Кюлоти Орбітального Викривлення"
    t[185801] = "Аномальні Зоряні Штани"
    t[185802] = "Наплічники Зламаного Ритму"
    t[185803] = "Наплічники Кам'яної Плоті"
    t[185804] = "Гармонійні Наплічники"
    t[185805] = "Модернізовані Наплічники Гілбранда"
    t[185806] = "Імпровізований Пояс"
    t[185807] = "Позавимірний Пакувальний Шнур"
    t[185808] = "Уцінений Пояс Поштою"
    t[185809] = "Пороховий Пояс Вензи"
    t[185810] = "Небокрай, Дворучна Сокира Хранителів"
    t[185811] = "Захисник Посилок"
    t[185812] = "Звабливо Звучне Кадило"
    t[185813] = "Перстень-Печатка Згасних Зір"
    t[185814] = "Лічильні Наручі Аукціоніста"
    t[185815] = "Наручі Перевірки"
    t[185816] = "Конфісковані Наручі Приховування"
    t[185817] = "Наручі Автономної Класифікації"
    t[185818] = { name = "Таємна Техніка Со'леї", fen = "Lead with an open hand, not a closed fist.", fua = "Веди відкритою долонею, а не стиснутим кулаком." }
    t[185819] = "Лезо Горизонту Подій"
    t[185820] = "Кабошон Нескінченного Польоту"
    t[185821] = "Ненажерливий Кинджал-Рондель"
    t[185822] = "Посох Розколотого Простору-Часу"
    t[185823] = "Доленищитель, Руйнівник Майбутніх"
    t[185824] = "Клинок Тяжкого Каліцтва"
    t[185827] = { name = "Кортіанський Футляр для Сувоїв", fen = "An elaborate scrollcase, used for storage. It's empty.", fua = "Вишуканий футляр для зберігання сувоїв. Він порожній." }
    t[185828] = { name = "Знаряддя Писаря Долі", fen = "This object is a powerful focus that allows the Fatescribe to perform sacred rituals.", fua = "Цей предмет - потужне осердя, що дозволяє Писарю Долі вершити священні ритуали." }
    t[185829] = "Спис Щирого Серця"
    t[185830] = { name = "Тягар Суду", fen = "A small golden weight. It's impossibly light.", fua = "Маленька золота гиря. Вона неймовірно легка." }
    t[185831] = { name = "Сокира Бур", fen = "A one handed axe, marked with runes. It hums with magic.", fua = "Одноручна сокира, поцяткована рунами. Вона гуде від магії." }
    t[185832] = { name = "Партія Елетієвої Руди", fen = "Contains 20 Elethium Ore.", fua = "Містить 20 одиниць Елетієвої Руди." }
    t[185833] = { name = "Партія Безсвітлого Шовку", fen = "Contains 20 Lightless Silk.", fua = "Містить 20 одиниць Безсвітлого Шовку." }
    t[185834] = { name = "Орбореальна Відзнака", fen = "Contains 5 Marks of Honor.", fua = "Містить 5 знаків честі." }
    t[185836] = "Кодекс Першої Техніки"
    t[185839] = "Жарина Душосталі"
    t[185840] = "Печатка Обладунку"
    t[185841] = "Тальвар Часокрута"
    t[185842] = "Вигадливо Гравірований Підсилювач"
    t[185843] = "Дублювальна Накидка"
    t[185844] = "Цокотливий Мішок Жаху"
    t[185845] = { name = "Першокласний Розподільник Зцілення", fen = "Rain or shine, your healing will be on time.", fua = "У дощ чи в погоду - ваше зцілення завжди вчасно." }
    t[185846] = "Крихітний Поштовий Елементаль у Конверті"
    t[185847] = { name = "Знаряддя Писаря Долі", fen = "This object is a powerful focus that allows the Fatescribe to perform sacred rituals.", fua = "Цей предмет - потужне осердя, що дозволяє Писарю Долі вершити священні ритуали." }
    t[185853] = "Осквернене Ядро Центуріона"
    t[185854] = "Шаль із Кам'яним Карбом"
    t[185855] = "Роба Кортіанського Доглядача"
    t[185856] = "Капці Кортіанського Доглядача"
    t[185857] = "Рукавиці Кортіанського Доглядача"
    t[185858] = "Шолом Кортіанського Доглядача"
    t[185859] = "Поножі Кортіанського Доглядача"
    t[185860] = "Пояс Кортіанського Доглядача"
    t[185861] = "Наручі Кортіанського Доглядача"
    t[185862] = "Скалкошкіряні Чоботи"
    t[185863] = "Скалкошкіряні Рукавички"
    t[185864] = "Скалкошкіряна Відлога"
    t[185865] = "Шкіряні Штани зі Скалкошкіра"
    t[185866] = "Скалкошкіряний Пояс"
    t[185867] = "Скалкошкіряні Наручі"
    t[185868] = "Кольчужний Обладунок з Луски Лезокрила"
    t[185869] = "Чоботи з Луски Лезокрила"
    t[185870] = "Рукавиці з Луски Лезокрила"
    t[185871] = "Каптур з Луски Лезокрила"
    t[185872] = "Поножі з Луски Бритвокрила"
    t[185873] = "Наплічники з Луски Лезокрила"
    t[185874] = "Пояс з Луски Лезокрила"
    t[185875] = "Наручі з Луски Лезокрила"
    t[185876] = "Шолом Вартового Сховища"
    t[185877] = "Нагрудник Вартового Сховища"
    t[185878] = "Чоботи Вартового Сховища"
    t[185879] = "Латні Рукавиці Вартового Сховища"
    t[185880] = "Поножі Вартового Сховища"
    t[185881] = "Наплічники Вартового Сховища"
    t[185882] = "Пояс Вартового Сховища"
    t[185883] = "Наручі Вартового Сховища"
    t[185884] = "Скалкошкіряний Жилет"
    t[185885] = "Скалкошкіряні Наплічники"
    t[185886] = "Наплічники Кортіанського Доглядача"
    t[185887] = "Щит Вартового Сховища"
    t[185888] = "Куля Кортіанського Доглядача"
    t[185889] = "Довгий Лук із Жил Громіта"
    t[185890] = "Кріс Кортіанського Доглядача"
    t[185891] = "Кіготь Гострокрила"
    t[185892] = "Обезголовлювач, Гравірований Стигією"
    t[185893] = "Дворучна Сокира Кортіанського Захисника"
    t[185894] = "Перстень Прислужника"
    t[185895] = "Перстень Заблукалого Мандрівника"
    t[185896] = "Кийок Хранителя Сховища"
    t[185897] = "Молот Кортіанської Вартової"
    t[185898] = "Шпиль Кортіанського Слідопита"
    t[185899] = "Молоток Кортіанського Архіваріуса"
    t[185900] = "Жезл Кортіанського Доглядача"
    t[185901] = "Кортіанський Парний Клинок"
    t[185902] = { name = "Набір Інструментів Залізної Діви", fen = "Trying the spikes on the outside.", fua = "Спробуємо цього разу з шипами назовні." }
    t[185903] = "Перстень Шукача Душ"
    t[185905] = "Накидка Вартового Сховища"
    t[185909] = { name = "Тьмяний Опал", fen = "Nearly worthless to all but the right merchant.", fua = "Майже нічого не вартий для всіх, окрім правильного торговця." }
    t[185911] = "Зброя Присяжних Утроби"
    t[185912] = "Моторошний Вінець"
    t[185913] = "Очі Тіні"
    t[185915] = { name = "Кортіанський Артефакт", fen = "A battered artifact that was likely the focus of research.", fua = "Побитий артефакт, що, ймовірно, був осердям дослідження." }
    t[185916] = { name = "Кодекс Спогадів", fen = "The leather-bound tome is quite heavy, sopping with moisture from the damp, dark dwelling where it was retrieved.", fua = "Шкіряний фоліант доволі важкий, просочений вологою з темного сирого житла, де його знайшли." }
    t[185917] = "Переписані Пекельні Криптограми"
    t[185918] = { name = "Перекладені Криптограми", fen = "Translated from Infernal Cryptograms found within Sinfall.", fua = "Перекладено з пекельних криптограм, знайдених у Гріхопаді." }
    t[185919] = { name = "Бездоганний Аметистовий Чепурун-Хробак", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[185920] = { name = "Звіт про Подію Картелю Аль", fen = "Confidential: For Overseer Al'rilan only.", fua = "Конфіденційно: лише для Наглядача Аль'рілана." }
    t[185927] = { name = "Звіт Експедиції A37J - Передмова", fen = "Overseer, please review the following introduction to Al'firim's findings.", fua = "Наглядачу, прошу ознайомитися з наступним вступом до знахідок Аль'фірима." }
    t[185928] = { name = "Звіт Експедиції A37J - Частина 1", fen = "Warning: The reading of heretical texts is punishable by banishment.", fua = "Попередження: за читання єретичних текстів карають вигнанням." }
    t[185929] = { name = "Звіт Експедиції A37J - Частина 2", fen = "Overseer, I apologize for showing you this heresy. But you must know the truth.", fua = "Наглядачу, перепрошую, що показую вам цю єресь. Але ви маєте знати правду." }
    t[185930] = { name = "Звіт Експедиції A37J - Частина 3", fen = "Ramblings of a lunatic. READ NO FURTHER!", fua = "Маячня божевільного. ДАЛІ НЕ ЧИТАЙ!" }
    t[185931] = { name = "Звіт Експедиції A37J - Частина 4", fen = "A chronicle  of crimes. Discard at once! HERESY!", fua = "Хроніка злочинів. Негайно знищити! ЄРЕСЬ!" }
    t[185932] = { name = "Пошкоджений Флакон", fen = "Nearly worthless to all but the right merchant.", fua = "Майже нічого не вартий для всіх, окрім правильного торговця." }
    t[185933] = { name = "Дешеві Прянощі", fen = "Nearly worthless to all but the right merchant.", fua = "Майже нічого не вартий для всіх, окрім правильного торговця." }
    t[185934] = { name = "Тріснутий Бойовий Молот", fen = "Nearly worthless to all but the right merchant.", fua = "Майже нічого не вартий для всіх, окрім правильного торговця." }
    t[185935] = { name = "Запорошений Череп", fen = "Nearly worthless to all but the right merchant.", fua = "Майже нічого не вартий для всіх, окрім правильного торговця." }
    t[185936] = { name = "Звичайний Барабан", fen = "Nearly worthless to all but the right merchant.", fua = "Майже нічого не вартий для всіх, окрім правильного торговця." }
    t[185937] = { name = "Черствий Хліб", fen = "Nearly worthless to all but the right merchant.", fua = "Майже нічого не вартий для всіх, окрім правильного торговця." }
    t[185938] = { name = "Витерта Тканина", fen = "Nearly worthless to all but the right merchant.", fua = "Майже нічого не вартий для всіх, окрім правильного торговця." }
    t[185939] = { name = "Зношений Щоденник", fen = "Nearly worthless to all but the right merchant.", fua = "Майже нічого не вартий для всіх, окрім правильного торговця." }
    t[185941] = "Перстень-Печатка Кортіанського Книжника"
    t[185942] = "Амулет Серця Гріха"
    t[185943] = "Медальйон Зниклого Шукача Пригод"
    t[185944] = "Тесак вартового сховища"
    t[185945] = "Шпиль Тіньоткача"
    t[185946] = { name = "Довгохвості Динащури", fen = "Three maw rats tied together... gross.", fua = "Троє пащурів, зв'язані докупи... гидота." }
    t[185947] = "Дозок Висмоктувальних Ударів"
    t[185949] = "Спис Корейн"
    t[185950] = "Дозок Часового Пориву"
    t[185951] = "Дозок Шипастої Шкіри"
    t[185953] = "Підроблені Документи"
    t[185954] = "Стерпно Підроблені Документи"
    t[185960] = "Залишок Витоків"
    t[185962] = "Рунова Бирка"
    t[185963] = "Рунний Жетон Віщуна"
    t[185968] = "Дубльований Рунний Жетон"
    t[185970] = "Розколоті Уламки Кристала"
    t[185971] = "Багряні Сторінки"
    t[185972] = { name = "Схованка Мучителя", fen = "Can contain powerful equipment, Soul Cinders, Torghast Back Pieces as well as a chain to summon the Hand of Bahmeht.", fua = "Може містити потужне спорядження, Жар Душ, накидки з Торгаста, а також ланцюг для прикликання Руки Бахмета." }
    t[185973] = { name = "Ланцюг Бахметри", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[185990] = { name = "Воєнна Скриня Женця", fen = "Contains Soul Cinders, Stygia and recovered Korthian Relics.", fua = "Містить Жар Душ, Стигію та віднайдені Кортіанські Релікти." }
    t[185991] = { name = "Воєнна Скриня Дикого Полювання", fen = "Contains Soul Cinders, Stygia and recovered Korthian Relics.", fua = "Містить Жар Душ, Стигію та віднайдені Кортіанські Релікти." }
    t[185992] = { name = "Воєнна Скриня Невмирущого Війська", fen = "Contains Soul Cinders, Stygia and recovered Korthian Relics.", fua = "Містить Жар Душ, Стигію та віднайдені Кортіанські Релікти." }
    t[185993] = { name = "Воєнна Скриня Піднесених", fen = "Contains Soul Cinders, Stygia and recovered Korthian Relics.", fua = "Містить Жар Душ, Стигію та віднайдені Кортіанські Релікти." }
    t[185996] = { name = "Сідло Жахокрила Женця", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186000] = { name = "Бойова Упряж Ногоруба", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186003] = "Стигійський Довгий Лук Версі"
    t[186004] = "Кріс Темної Спокуси"
    t[186005] = "Стигійський Свердел Болю"
    t[186006] = "Стигійський Розколювач Каджа"
    t[186007] = "Кий Бляшаного Вартового"
    t[186008] = "Суд Зреченого"
    t[186009] = "Зіпсована Гілка Древнього"
    t[186010] = "Скіпетр Загиблого Прислужника"
    t[186011] = "Парний Клинок Люмісенди"
    t[186012] = "Щит Пекельного Вибуху"
    t[186013] = "Посудина Первісної Смерті"
    t[186014] = { name = "Оплот Божественного Наміру", fen = "Immaterial and abstract, the shield is forged from the concept of altruism.", fua = "Нематеріальний і абстрактний, цей щит викуваний із самого поняття самовідданості." }
    t[186017] = { name = "Кортитовий Кристал", fen = "A crafting reagent used to create more powerful Runecarving items. Can be bought and sold on the auction house.", fua = "Ремісничий реагент, що використовується для створення потужніших предметів рунного різьблення. Можна купити та продати на аукціоні." }
    t[186042] = "Клинок Хрестоносця Відступників"
    t[186043] = { name = "Маніпулятор Порталів Торгаста", fen = "Requires the entire party to activate the key.", fua = "Для активації ключа потрібна вся група." }
    t[186089] = "Посох Нії"
    t[186099] = { name = "Апарат Просторового Переналаштування", fen = "This gadget causes a miniature rift in space to appear within your equipment, perfectly shaped for a gem.", fua = "Цей пристрій спричиняє появу у вашому спорядженні мініатюрного розриву простору, ідеально підігнаного під самоцвіт." }
    t[186101] = { name = "Ключ Дізнавача", fen = "Every lock has a key. This is the key to the cage holding Archivist Roh-Senara.", fua = "До кожного замка є ключ. Це ключ від клітки, у якій ув'язнено архіваріуса Ро-Сенару." }
    t[186102] = "Чарівна Паличка Леді Мунберрі"
    t[186103] = { name = "Упряж Невмирущого Темнопса", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186107] = "Роба Темного Чаклуна-Присяжного Утроби"
    t[186108] = "Капці Темного Чаклуна-Присяжного Утроби"
    t[186109] = "Обмотки на Руки Темного Чаклуна-Присяжного Утроби"
    t[186110] = "Шолом Темного Чаклуна-Присяжного Утроби"
    t[186111] = "Поножі Зевопідданого Темночара"
    t[186112] = "Пояс Темного Чаклуна-Присяжного Утроби"
    t[186113] = "Пов'язки Темного Чаклуна-Присяжного Утроби"
    t[186114] = "Чоботи Вбивці-Присяжного Утроби"
    t[186115] = "Рукавички Вбивці-Присяжного Утроби"
    t[186116] = "Каптур Вбивці-Присяжного Утроби"
    t[186117] = "Штани Зевопідданого Асасина"
    t[186118] = "Пояс Утробоприсяжного Вбивці"
    t[186119] = "Наручі Вбивці-Присяжного Утроби"
    t[186120] = "Кольчуга Розвідника-Присяжного Утроби"
    t[186121] = "Чоботи Розвідника-Присяжного Утроби"
    t[186122] = "Рукавиці Розвідника-Присяжного Утроби"
    t[186123] = "Кольчужний Каптур Розвідника-Присяжного Утроби"
    t[186124] = "Поножі Зевопідданого Розвідника"
    t[186125] = "Наплічники Розвідника-Присяжного Утроби"
    t[186126] = "Пояс Розвідника-Присяжного Утроби"
    t[186127] = "Наручі Розвідника-Присяжного Утроби"
    t[186128] = "Шолом Вартового-Присяжного Утроби"
    t[186129] = "Нагрудник Вартового-Присяжного Утроби"
    t[186130] = "Чоботи Вартового-Присяжного Утроби"
    t[186131] = "Латні Рукавиці Вартового-Присяжного Утроби"
    t[186132] = "Поножі Зевопідданого Вартового"
    t[186133] = "Наплічники Вартового-Присяжного Утроби"
    t[186134] = "Пояс Вартового-Присяжного Утроби"
    t[186135] = "Наручі Вартового-Присяжного Утроби"
    t[186136] = "Жилет Вбивці-Присяжного Утроби"
    t[186137] = "Наплічники Вбивці-Присяжного Утроби"
    t[186138] = "Наплічники Темного Чаклуна-Присяжного Утроби"
    t[186139] = "Тарча Списометальника-Присяжного Утроби"
    t[186140] = "Куля Темного Чаклуна-Присяжного Утроби"
    t[186141] = "Скорострільний Лук Розвідника Пащеслужбовців"
    t[186142] = "Кріс Темного Чаклуна Хащепокляних"
    t[186143] = "Кинджал у Спину Асасина Хащепокляних"
    t[186144] = "Дворучна Сокира Розбійника Прислужників Пащі"
    t[186145] = "Стигійський Колючий Перстень"
    t[186146] = "Кийок Вартового Хащепокляних"
    t[186147] = "Бойовий Молот Хащепокляних"
    t[186148] = "Шпиль Переможця Прислужників Пащі"
    t[186149] = "Молоток Збирача Хащепокляних"
    t[186150] = "Посох Темного Заклинача Прислужників Пащі"
    t[186151] = "Парний Клинок Асасина Хащепокляних"
    t[186152] = "Плащ Лейтенанта-Присяжного Утроби"
    t[186153] = "Печатка Зречених"
    t[186154] = "Тесак Вартового Прислужників Пащі"
    t[186155] = "Гармонійний Розгромник Натовпу"
    t[186156] = "Фоліант Прозріння"
    t[186157] = "Жильний Посох"
    t[186160] = { name = "Замкнений Футляр для Артефакта", fen = "An intricate puzzle lock similar to the Attendant's vault locks bars entry to this case.", fua = "Хитромудрий замок-головоломка, схожий на замки сховища Служника, перепиняє доступ до цього футляра." }
    t[186161] = "Стигійська Скринька із Замком"
    t[186167] = { name = "Запечатаний Контейнер", fen = "Surprisingly light, but contains valuable Korthian relics.", fua = "Напрочуд легкий, але містить цінні кортіанські релікти." }
    t[186168] = { name = "Запис Спостережень", fen = "A packet of data from a broker surveillance device.", fua = "Пакет даних із пристрою стеження посередника." }
    t[186169] = { name = "Запис Спостережень", fen = "A packet of data from a broker surveillance device.", fua = "Пакет даних із пристрою стеження посередника." }
    t[186170] = { name = "Запис Спостережень", fen = "A packet of data from a broker surveillance device.", fua = "Пакет даних із пристрою стеження посередника." }
    t[186171] = { name = "Запис Спостережень", fen = "A packet of data from a broker surveillance device.", fua = "Пакет даних із пристрою стеження посередника." }
    t[186172] = { name = "Запис Спостережень", fen = "A packet of data from a broker surveillance device.", fua = "Пакет даних із пристрою стеження посередника." }
    t[186173] = { name = "Запечатаний Контейнер", fen = "Surprisingly light, but contains valuable Korthian relics.", fua = "Напрочуд легкий, але містить цінні кортіанські релікти." }
    t[186174] = { name = "Запечатаний Контейнер", fen = "Surprisingly light, but contains valuable Korthian relics.", fua = "Напрочуд легкий, але містить цінні кортіанські релікти." }
    t[186175] = { name = "Запечатаний Контейнер", fen = "Surprisingly light, but contains valuable Korthian relics.", fua = "Напрочуд легкий, але містить цінні кортіанські релікти." }
    t[186177] = { name = "Пожирач Душ Розкутого Гладіатора", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186178] = { name = "Лютий Бойовий Горм", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186179] = { name = "Лютий Бойовий Горм", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186182] = { name = "Вантажна Накладна Картелю Со", fen = "The bulk of Cartel So's wares seem to be marked for delivery to a place named 'Tazavesh.'", fua = "Більшість товарів Картелю Со, схоже, призначені для доставки в місце на ім'я \"Тазавеш\"." }
    t[186183] = "Голова Маленької Потвори"
    t[186184] = "Тулуб Маленької Потвори"
    t[186185] = "Ноги Маленької Потвори"
    t[186186] = { name = "Права Рука Малого Монстрика", fen = "Is it a right hand? It's hard to tell, but with aboms it rarely matters.", fua = "Чи права це рука? Важко сказати, але для монстрів це рідко має значення." }
    t[186187] = { name = "Запасна Рука Малого Монстрика", fen = "It's clearly a right hand... at least its not two left feet.", fua = "Це явно права рука... принаймні не дві ліві ноги." }
    t[186188] = { name = "Малий Монстрик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186189] = "Схованка Зі Зброєю"
    t[186190] = { name = "Ключ від Клітки Етервірма", fen = "Key to the Etherwyrm Cage", fua = "Ключ від Клітки Етервірма." }
    t[186191] = { name = "Наснажений Етервірм", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186196] = { name = "Військова Скриня Поступу Смерті", fen = "Contains the wealth and armor scavenged by our forces in the defense of Korthia as well as a symbol of your dedication to the realms of Shadowlands.", fua = "Містить багатства та обладунки, здобуті нашими військами при обороні Кортії, а також символ вашої відданості царствам Тіньокраю." }
    t[186198] = { name = "Звичайний Перстень-Печатка", fen = "There doesn't appear to be anything special with this ring anymore.", fua = "Схоже, у цьому персні вже немає нічого особливого." }
    t[186199] = "Чарівна Паличка Леді Мунберрі"
    t[186200] = "Насичений Дендрит"
    t[186201] = "Прадавня Посудина Аніми"
    t[186202] = "Летюча Шишка Корі"
    t[186203] = "Сяйний Шлунок Пожирача"
    t[186204] = "Забарвлені Анімою Скляні Скалки"
    t[186205] = "Браслет Книжника-Прислужника"
    t[186206] = "Попелястий Камінь Сховища"
    t[186207] = "Шати Вісника-Присяжного Утроби"
    t[186208] = "Підбиті Душоустілки"
    t[186209] = "Заляпані Кров'ю Рукавички Смерті"
    t[186210] = "Диявольська Запона Душі"
    t[186211] = "Штани Засудженого Барда"
    t[186212] = "Плетений Пояс Етернаса"
    t[186213] = "Наручі Явленого Болю"
    t[186214] = "Чоботи зі Зміїної Шкіри Пащі"
    t[186215] = "Душителі Душ"
    t[186216] = "Лик Зоґратоса"
    t[186217] = "Гнучкі Шкіряні Штани Пекельного Пса"
    t[186218] = "Загартований Вогнем Поясок Обладунку"
    t[186219] = { name = "Зап'ясткові Пов'язки Пірофуса", fen = "Chain management is vital.", fua = "Уміння давати раду ланцюгам - річ життєво важлива." }
    t[186220] = "Стигійська Грудна Клітка"
    t[186221] = "Чоботи з Обпалених Ланок"
    t[186222] = "Рукавиці Холодносердого Ад'ютанта"
    t[186223] = "Каптур Розплавленого Жаху"
    t[186224] = "Чоботи Псаря Звіриного Лігва"
    t[186225] = "Шпинделі Плечового Суглоба"
    t[186226] = "Пояс Скам'янілих Лоз"
    t[186227] = "Бряжчливі Ланцюгові Кайдани"
    t[186228] = "Шолом Полохливого Героя"
    t[186229] = "Лавоплавлений Нагрудник"
    t[186230] = "Бойові Чоботи Присяжних Утроби"
    t[186231] = "Рукавички Палкого Заступництва"
    t[186232] = "Латні Поножі Примарного Переслідувача"
    t[186233] = "Наплічники Небородженого Проклятого"
    t[186234] = "Пояс Речника Смерті"
    t[186235] = "Тіньооповиті Наручі"
    t[186236] = "Куртка з Тіньошкіри Пожирача"
    t[186237] = "Наплічники зі Шкіри Ґорма"
    t[186238] = "Оплічник Верховного Збирача"
    t[186239] = "Накидка Фантазму"
    t[186240] = "Плащ Зі Шкіри Прародительки"
    t[186241] = "Утеплені Термопоножі"
    t[186242] = "Кольчужний Койф Зул'ґата"
    t[186243] = "Шолом Некротичного Зору"
    t[186244] = "Горжет Шакорзета"
    t[186245] = { name = "Чимала Кількість Крові Пожирача", fen = "The liquid within the vial appears to be bloodlike, but heavily infused with anima.", fua = "Рідина у флаконі схожа на кров, але рясно насичена анімою." }
    t[186281] = "Чоботи, Виковані з Фантазми"
    t[186282] = "Священицька Сутана Жертводавця"
    t[186283] = "Кайдани Жорстокого Володаря"
    t[186284] = "Загадкове Енергетичне Коло"
    t[186285] = "Стрімливі Поножі Чаклуна"
    t[186286] = "Оплічник Обранця Артура"
    t[186287] = "Каптур Мстивої Одержимості"
    t[186288] = "Рукавиці Ясновидющого Мудреця"
    t[186289] = "Плащ Зраненої Честі"
    t[186290] = { name = "Клятва Дев'ятьох", fen = "Nine paths. One Purpose.", fua = "Дев'ять шляхів. Одна Мета." }
    t[186291] = "Амулет Бездоганного Збереження"
    t[186292] = "Шапка Звивистої Злоби"
    t[186293] = "Поножі, Спалені Вогнезатиском"
    t[186294] = "Болісний Шипастий Пояс"
    t[186295] = "Намотки на Руки Відданого Квалдира"
    t[186296] = "Кіраса Патрача-Присяжного Утроби"
    t[186297] = "Застібки Бездольного Трубадура"
    t[186298] = "Награбовані Наплічники Контрабандиста"
    t[186299] = "Непокірні Чоботи Дашли"
    t[186300] = { name = "Ритуальна Книга Слугів Пащі", fen = "Detailed incantations for all manner of evil deeds.", fua = "Докладні заклинання на всілякі лихі діяння." }
    t[186301] = "Скручений Стигійський Гак"
    t[186302] = "Кайдани Туманного Сповиття"
    t[186303] = "Кольчуга Вбивці Колосів"
    t[186304] = "Герб Полеглих"
    t[186305] = "Наплічники Тиранічної Непокори"
    t[186306] = "Поножі Винищення"
    t[186307] = "Списоносні Поножі Арадне"
    t[186308] = "Рукавиці Прадавнього Шепоту"
    t[186309] = { name = "Клапоть Послання Слугів Пащі", fen = "The original letter has been shredded. This small piece of it is unreadable on its own.", fua = "Початкового листа подерто на шматки. Цей маленький клаптик сам по собі годі прочитати." }
    t[186310] = { name = "Темний Мозок", fen = "The twisted, tangible essence of dark creations.", fua = "Спотворена, відчутна сутність темних творінь." }
    t[186311] = "Рукавиці Кавалера-Клятвопорушника"
    t[186312] = "Кіраса Самотньої Цитаделі"
    t[186313] = "Готичні Поножі Агати"
    t[186314] = "Наплічники Згубного Воєначальника"
    t[186315] = "Погляд Темного Мучителя"
    t[186316] = "Наручі Летючого Викрадача"
    t[186317] = "Незнищенний Пояс"
    t[186318] = "Моторошні Поножі Захисника"
    t[186319] = "Катовані Чоботи Тіньорозламу"
    t[186320] = "Драпіроване Пишне Вбрання Віщуна"
    t[186321] = "Голосильні Наручі Осквернителя"
    t[186322] = "Пояс Підступної Магії"
    t[186323] = "Поножі Волаючого Полум'я"
    t[186324] = { name = "Оплічник Облудного Маркграфа", fen = "Dress for the job you'll take - not the job you have.", fua = "Вдягайся для посади, яку візьмеш, а не для тієї, яку маєш." }
    t[186325] = "Вуаль Королеви-Банші"
    t[186326] = "Рукавички Втраченого Призначення"
    t[186330] = "Каптур Гнітючого Передбачення"
    t[186331] = "Елітні Штани Аранакків"
    t[186332] = "Перев'язь Віндраннер"
    t[186333] = "В'язальники Вузлів Ката"
    t[186334] = "Клепаний Нагрудник Зів'ялого Серця"
    t[186335] = "Прониті Долею Пов'язки"
    t[186336] = { name = "Наплічники Підступного Повірника", fen = "Pity about the House of Plagues.", fua = "Шкода тільки Дім Чум." }
    t[186337] = "Чоботи Завзятого Палія Війни"
    t[186338] = "Церемоніальна Застібка Конструкта"
    t[186339] = "Скорботні Наручні Обмотки Бриньї"
    t[186340] = "Кольчуга, Викувана в Сполученні Зір"
    t[186341] = "Лицьова Клітка з Тіньосталі"
    t[186342] = "Еполети Майстра-Слідопита"
    t[186343] = "Скуті Люттю Кайдани"
    t[186344] = "Надщільні Поножі"
    t[186345] = "Напіврукавиці Приречення"
    t[186346] = "Незмінні Захисники Кіри"
    t[186347] = "Шасі Прадавнього Колоса"
    t[186348] = "Латні Поножі, Куті Долею"
    t[186349] = "Шпилі Розбитої Надії"
    t[186350] = "Звитяжне Обличчя Крексуса"
    t[186351] = "Парадні Манжети Вираза"
    t[186352] = "Пута Темних Доль"
    t[186353] = "Поножі Примарної Руїни"
    t[186354] = "Сандалі Священної Симетрії"
    t[186355] = "Наручні Обмотки Муки"
    t[186356] = "Ремінь Самотнього В'язня"
    t[186357] = "Скорботні Штани"
    t[186358] = "Плетені Рукавиці Душочара"
    t[186359] = "Стражденні Поножі Негідника"
    t[186360] = "Збруя Катованої Душі"
    t[186361] = "Рукавиці Звільненого Страждання"
    t[186362] = "Наручі Поневоленого"
    t[186363] = "Чоботи Нестабільного Енергізатора"
    t[186364] = "Пояс Підкорених Духів"
    t[186365] = "Наручі Полеглого Дому"
    t[186366] = "Стигійські Кольчужні Поножі"
    t[186367] = "Зчеплені Поножі Душеплаву"
    t[186368] = "Латні Рукавиці Прокляття Мор'ґета"
    t[186369] = "Гільйотинні Латні Рукавиці"
    t[186370] = "Заґратовані Латні Поножі"
    t[186371] = "Прадавні Наручі Зламаної Душі"
    t[186372] = "Широкий Пояс Ката"
    t[186373] = "Височенні Великі Чоботи Тіньожаху"
    t[186374] = "Самовідтворювана Тканина"
    t[186375] = { name = "Мініатюрне Колесо Тортур", fen = "Every soul, a stage. Every scream - applause.", fua = "Кожна душа - сцена. Кожен крик - оплески." }
    t[186376] = "Коливний Уроборос"
    t[186377] = "Потьмяніла Відзнака Кель'Таласа"
    t[186378] = "Звітрілий Талісман Тіньового Місяця"
    t[186379] = "Міжпланарний Ключ"
    t[186381] = "Глефа з Елетієвим Лезом"
    t[186383] = "Поглядопробивач"
    t[186384] = "Невмируща Лють Ск'ї"
    t[186385] = "Звучний Скрамасакс Сіґне"
    t[186386] = "Тіньовий Шпичак Зрадника"
    t[186387] = "Відбивач Дормазейна"
    t[186388] = "Хрестоподібний Жилоріз"
    t[186391] = { name = "Тіньосталевий Деморалізатор", fen = "The beatings will continue.", fua = "Побої триватимуть." }
    t[186392] = "Безжальний Розуморіз"
    t[186393] = { name = "Смолоскип Вічного Знання", fen = "And now it falls to you.", fua = "І тепер це випадає вам." }
    t[186398] = "Лезо Ночі"
    t[186403] = "Стигійський Спис Переходу"
    t[186404] = "Йотунґейр, Поклик Долі"
    t[186405] = "Вузлуватий Посох Старійшини-Шамана"
    t[186406] = "Проклятий Опус"
    t[186407] = "Реквієм Хеллскріма"
    t[186409] = "Пілон Великого Очищення"
    t[186410] = "Джейтіс, Тюремний Клинок"
    t[186411] = "Вигнутий Лук Душороздертого Вершника"
    t[186413] = "Спрямований Проектор Розплаву"
    t[186414] = "Рей'шаларе, Шепіт Смерті"
    t[186415] = { name = "Запасний Щит Моріаза", fen = "Spare parts to protect a perfect creation.", fua = "Запасні частини, щоб захистити досконале творіння." }
    t[186416] = "Останній Оплот Нескінченності"
    t[186417] = "Егіда Розколотого Захисника"
    t[186418] = "Загублена Жувальна Іграшка Ґуарма"
    t[186419] = "Запис Реальностей, що Руйнуються"
    t[186421] = "Заборонений Некромантський Фоліант"
    t[186422] = "Фоліант Жахливих Конструкцій"
    t[186423] = { name = "Титанічна Очна Залоза", fen = "A price paid long ago in exchange for knowledge and power.", fua = "Ціна, сплачена давним-давно в обмін на знання і могутність." }
    t[186424] = "Скалка Егіди Аннгільди"
    t[186425] = "Нашкрябане Слово Повернення"
    t[186427] = "Шепітлива Скалка Сили"
    t[186428] = "Затінена Куля Муки"
    t[186429] = "Карафа Безкінечного Виття"
    t[186430] = "Уламок Катувальної Дибки"
    t[186431] = "Чорнодушні Лещата"
    t[186432] = "Врятований Підсилювач Синтезу"
    t[186433] = "Реактивна Захисна Матриця"
    t[186434] = "Плетиво Викривлених Доль"
    t[186435] = "Різьблена Пам'ятка зі Слонової Кістки"
    t[186436] = "Лункий Срібний Дзвоник"
    t[186437] = "Релікт Крижаних Пустищ"
    t[186438] = "Душа Старого Воїна"
    t[186439] = "Сагайдак Темного Слідопита"
    t[186445] = { name = "Відновлювальний Пристрій Міканікоса", fen = "Created by the greatest minds in Bastion, this contraption should allow for the healing of Kyrian, Stoneborn, Night Fae, and Maldraxxi.", fua = "Створений найвидатнішими умами Бастіону, цей пристрій має зцілювати кіріанів, каменероджених, нічних фей та малдраксійців." }
    t[186448] = { name = "Відновлювальний Пристрій Міканікоса", fen = "Created by the greatest minds in Bastion, this contraption should allow for the healing of Kyrian, Stoneborn, Night Fae, and Maldraxxi.", fua = "Створений найвидатнішими умами Бастіону, цей пристрій має зцілювати кіріанів, каменероджених, нічних фей та малдраксійців." }
    t[186449] = { name = "Незів'яле Жало", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186450] = { name = "Грубий Стигійський Затискач", fen = "Crude but crucial in containing the sentinel's soul.", fua = "Грубий, але вкрай потрібний, щоб утримати душу вартового." }
    t[186453] = "Шукач Аніми Сховища"
    t[186455] = { name = "Кіготь Скалкошкірого", fen = "A long claw taken from the paw of a shardhide bear.", fua = "Довгий кіготь, узятий з лапи скалкошкірого ведмедя." }
    t[186456] = { name = "Лапа Громіта", fen = "A fuzzy foot from a gromit. It doesn't appear to have given its owner any extra luck.", fua = "Пухнаста лапа громіта. Схоже, своєму власнику вона жодної удачі не принесла." }
    t[186457] = { name = "Голка Лезокрила", fen = "A thin hollow needle like spine taken from a Razorwing.", fua = "Тонка порожниста голка-колючка, взята з лезокрила." }
    t[186470] = { name = "Рецепт: Знак Ремісника Закутого Острова", fen = "Teaches you how to craft a Crafter's Mark of the Chained Isle.", fua = "Навчає вас виготовляти Знак Ремісника Закутого Острова." }
    t[186472] = "Вогники Спогадів"
    t[186476] = { name = "Могильнокрило з Сінфолу", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186477] = { name = "Бліде Могильнокрило", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186478] = { name = "Обсидіанове Могильнокрило", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186479] = { name = "Майстерне Могильнокрило", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186480] = { name = "Загартований у Битвах Аквілон", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186482] = { name = "Елізійський Аквілон", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186483] = { name = "Аквілон Зреченого", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186485] = { name = "Аквілон Піднесеного", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186487] = { name = "Збруя Малдраксійської Трупної Мухи", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186488] = { name = "Збруя Величної Трупної Мухи", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186489] = { name = "Володар Трупних Мух", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186490] = { name = "Збруя Бойового Роїстого", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186491] = { name = "Збруя Весняного Дикуна", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186492] = { name = "Збруя Літнього Дикуна", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186493] = { name = "Збруя Дикуна Арденвельду", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186494] = { name = "Збруя Осіннього Дикуна", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186495] = { name = "Збруя Зимового Дикуна", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186497] = "Комплект: Шати Чистого Духу"
    t[186498] = "Комплект: Шати Блакитного Присмерку"
    t[186499] = "Комплект: Шати Осінньої Обітниці"
    t[186500] = "Комплект: Шати Сутінкового Гаю"
    t[186501] = "Підставка під Трофей Думвокера"
    t[186502] = "Комплект: Шати Помічника Марілета"
    t[186503] = "Комплект: Некромантичні Шати Послушника"
    t[186504] = "Комплект: Шати Передового Некроманта"
    t[186505] = "Комплект: Шати Некроманта-Відступника"
    t[186507] = "Комплект: Вбрання Двору Жнеця"
    t[186508] = "Комплект: Шати Двірського Інквізитора"
    t[186509] = "Комплект: Вбрання Грішних Вентир"
    t[186510] = "Комплект: Шати Грішного Інквізитора"
    t[186511] = "Комплект: Бойове Вбрання Ренатала"
    t[186512] = "Комплект: Шати Польового Інквізитора Ренатала"
    t[186513] = "Комплект: Вбрання Осяйного Двору"
    t[186514] = "Комплект: Шати Спокутуваного Інквізитора"
    t[186515] = "Комплект: Регалії Завзятого Претендента"
    t[186516] = "Комплект: Регалії Відданого Претендента"
    t[186517] = "Комплект: Регалії Гінця Бойовища"
    t[186518] = "Комплект: Регалії Зреченого Претендента"
    t[186519] = { name = "Стиснута Бульбашка Аніми", fen = "Perfect for making a large amount of Anima more mobile.", fua = "Ідеально підходить, щоб зробити велику кількість аніми мобільнішою." }
    t[186521] = "Безкоштовна Слава"
    t[186522] = "Контракт: Поступ Смерті"
    t[186525] = "Чай Божевільного Герцога"
    t[186526] = "Чай Стрімкості Божевільного Герцога"
    t[186527] = "Чай Влучності Божевільного Герцога"
    t[186528] = "Чай Універсальності Божевільного Герцога"
    t[186529] = { name = "Сховок Скарбів Святилища", fen = "Rewards a piece of equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження для вашої спеціалізації здобичі." }
    t[186530] = { name = "Сховок Скарбів Святилища", fen = "Rewards a piece of equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження для вашої спеціалізації здобичі." }
    t[186531] = { name = "Сховок Скарбів Святилища", fen = "Rewards a piece of equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження для вашої спеціалізації здобичі." }
    t[186533] = { name = "Сховок Скарбів Святилища", fen = "Rewards a piece of equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження для вашої спеціалізації здобичі." }
    t[186534] = { name = "Ґізмо", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186535] = { name = "Топазовий Цяцьковий Черв'як", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186536] = { name = "Бірюзовий Цяцьковий Черв'як", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186537] = { name = "Рубіновий Цяцьковий Черв'як", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186538] = { name = "Скрегозуб", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186539] = { name = "Хитрун", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186540] = { name = "Рідкість", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186541] = { name = "Моховий Стрибунець", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186542] = { name = "Кортіанський Зразок", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186543] = { name = "Свійський Авніанець", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186544] = { name = "Верескун Гріхопаду", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186545] = { name = "REUSE", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186546] = { name = "Мідноспинний Етерний Змій", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186547] = { name = "Навальний Дзизкун", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186548] = { name = "Хрумчик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186549] = { name = "Позолочений Темний Лицар", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186550] = { name = "Поплічник Присяжних Пащі", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186551] = { name = "Морд'ал Вечірня Зоря", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186552] = { name = "Рук", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186553] = { name = "Ґурґл", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186554] = { name = "Всевидюще Око", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186555] = { name = "Око Винищення", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186556] = { name = "Позачасовий Механічний Дракончик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186557] = { name = "Гарматне М'ясо", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186558] = { name = "Залізохват", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186559] = { name = "Хапка Латна Рукавиця", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186561] = "Кортіанські Ласощі"
    t[186562] = "Закутий Наспинник Ката"
    t[186563] = "Спис настромлювачки"
    t[186564] = { name = "Золоте Око", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[186565] = "Спогад про Несамовите Перенесення"
    t[186566] = "Спогад про Остаточний Вирок"
    t[186567] = "Спогад про Невгамовний Голод"
    t[186568] = "Спогад про Шаленство Потвори"
    t[186569] = "Гніздо Розлюченого Голкаря"
    t[186570] = "Спогад про Славу"
    t[186572] = "Спогад про Гріховний Сплеск"
    t[186573] = { name = "Карта Оборони", fen = "A map marking the location of all the magical defenses of Perdition Hold.", fua = "Карта, що позначає розташування всіх магічних оборонних споруд Твердині Загибелі." }
    t[186576] = "Спогад про Лють Природи"
    t[186577] = "Спогад про Нестримний Рій"
    t[186591] = "Спогад про Гармонійне Відлуння"
    t[186598] = { name = "Рецепт: Знак Ремісника III", fen = "Teaches you how to craft a Crafter's Mark III.", fua = "Навчає тебе створювати Знак Ремісника III." }
    t[186599] = { name = "Стигійський Жар", fen = "Once a brave warrior, now reduced to a lost sliver of undeath.", fua = "Колись хоробрий воїн, а нині — лише загублена крихта нежиття." }
    t[186600] = { name = "Розбита Чверть Прадавнього Персня", fen = "This ring fragment seems to be made of stone.", fua = "Здається, цей уламок персня зроблено з каменю." }
    t[186601] = { name = "Розбита Чверть Прадавнього Персня", fen = "This ring fragment seems to be made of stone.", fua = "Здається, цей уламок персня зроблено з каменю." }
    t[186602] = { name = "Розбита Чверть Прадавнього Персня", fen = "This ring fragment seems to be made of stone.", fua = "Здається, цей уламок персня зроблено з каменю." }
    t[186603] = { name = "Кам'яний Перстень Нілґаніхмата", fen = "Stone shall be broken. Just like your soul.", fua = "Камінь буде розбито. Так само, як і твою душу." }
    t[186604] = { name = "Розбита Чверть Прадавнього Персня", fen = "This ring fragment seems to be made of stone.", fua = "Здається, цей уламок персня зроблено з каменю." }
    t[186605] = { name = "Рунний Перстень Нілґаніхмата", fen = "You dare flaunt your runes before the master of Domination?", fua = "Ти смієш виставляти напоказ свої руни перед володарем Панування?" }
    t[186606] = { name = "Перстень-Печатка Нілґаніхмата", fen = "Braggart! This symbol of your failed reign means nothing here!", fua = "Хвалько! Цей символ твого занепалого правління тут нічого не означає!" }
    t[186607] = { name = "Срібний Перстень Нілґаніхмата", fen = "Riches mean nothing in this realm of torment.", fua = "Багатства нічого не варті в цьому царстві муки." }
    t[186608] = { name = "Золотий Перстень Нілґаніхмата", fen = "Such vanity, to claim a ring of gold!", fua = "Яка марнославність — претендувати на перстень із золота!" }
    t[186609] = "Спогад про Гріховну Розкіш"
    t[186611] = "Чоботи Тараксіса"
    t[186613] = "Кільчасті Поножі Ровуса"
    t[186614] = { name = "Глек Душі", fen = "A soul swirls within begging to be freed.", fua = "Усередині кружляє душа, благаючи про звільнення." }
    t[186615] = { name = "Дзеркало Призваного Двійника", fen = "Your reflection grins ominously at you through a shadowy fog.", fua = "Твоє відображення зловісно вищиряється до тебе крізь тіньовий туман." }
    t[186616] = "Наручі Волаючої Смерті"
    t[186617] = "Чоботи Молота Смерті"
    t[186618] = "Ланцюг Ламача Волі"
    t[186619] = "Заляпані Кров'ю Наплічники Білувальника"
    t[186620] = "Фехтувальні Рукавиці Резари"
    t[186621] = "Спогад про Глибини Смерті"
    t[186622] = "Роба Блукливого Смутку"
    t[186623] = { name = "Оплічник Загубленої Душі", fen = "They stood up well to saliva and teeth.", fua = "Він добре витримав слину та зуби." }
    t[186624] = "Накидка Крил Смерті"
    t[186625] = "Каптур Лиходійства"
    t[186626] = "Кровоточиві Напульсники"
    t[186627] = "Пояс Десяти Тисяч Хвостів"
    t[186628] = "Хапачі Сокири Разказзара"
    t[186629] = "Шипастий Перстень Саннґора"
    t[186630] = "Іскровідбивний Пояс"
    t[186631] = "Жаросплавний Перстень"
    t[186632] = "Наручі, Вкриті Рунами"
    t[186633] = "Нашийник Утробопацюка-Покруча"
    t[186635] = "Спогад про Гріховну Втіху"
    t[186636] = { name = "Клітка з Пацюками Пащі", fen = "Several Mawrats gaze hopefully at you through the bars.", fua = "Кілька пащурів з надією дивляться на тебе крізь ґрати." }
    t[186637] = { name = "Механопланер Тазавеша", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186638] = { name = "Механопланер Майстра Картелю", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186639] = { name = "Механопланер Повіреного Ксай", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186640] = { name = "Механопланер Вандала", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186641] = { name = "Збруя Приборканого Шматувальника", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186642] = { name = "Повід Помсти", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186643] = { name = "Повід Мандрівниці", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186644] = { name = "Бериловий Колючошкур", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186645] = { name = "Багряний Колючошкур", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186646] = { name = "Темнолап", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186647] = { name = "Бурштиновий Скалкошкур", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186648] = { name = "Ширяюче Гострокриле", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186649] = { name = "Люте Гострокриле", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186650] = "Припаси Поступу Смерті"
    t[186651] = { name = "Сутінкове Гострокриле", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186652] = { name = "Гранатове Гострокриле", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186653] = { name = "Наруч Хрестиморака", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186654] = { name = "Браслет Саларанги", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186655] = { name = "Повід Бойового Коня Присяжних Пащі", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186656] = { name = "Повід Сутінкового Бойового Коня Святилища", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186657] = { name = "Повід Прив'язаного До Душі Сутінкового Бойового Коня", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186659] = { name = "Повід Полеглого Бойового Коня", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186660] = "Шипи Обладунку Бойового Коня"
    t[186662] = "Руна Вантуса: Святилище Панування"
    t[186663] = "Шати Кортіанського Доглядача"
    t[186664] = "Сандалі Кортіанського Доглядача"
    t[186665] = "Рукавички Кортіанського Доглядача"
    t[186666] = "Вінець Кортіанського Доглядача"
    t[186667] = "Штани Кортіанського Доглядача"
    t[186668] = "Пояс Кортіанського Доглядача"
    t[186669] = "Намотки Кортіанського Доглядача"
    t[186670] = "Оплічник Кортіанського Доглядача"
    t[186671] = { name = "Техніка Руни Вантуса: Святилище Панування", fen = "Teaches you how to craft a Vantus Rune: Sanctum of Domination.", fua = "Навчає тебе створювати Руну Вантуса: Святилище Панування." }
    t[186673] = "Спогад про Споріднену Спорідненість"
    t[186676] = "Спогад про Отруйний Натиск"
    t[186678] = { name = "Сховок Зброї, Кованої В Пащі", fen = "These weapons seem to have a life of their own.", fua = "Здається, ця зброя живе власним життям." }
    t[186679] = { name = "Сувій Панування", fen = "Don't stare at the runes too long.", fua = "Не вдивляйся в руни надто довго." }
    t[186680] = { name = "Наповнений Золотом Чобіт", fen = "Don't forget it is full of gold, otherwise it may result in toe injury.", fua = "Не забувай, що він повний золота, бо інакше можеш забити пальці." }
    t[186685] = { name = "Уламок Реліквії", fen = "Ancient symbols still show on the surface of these fragments.", fua = "На поверхні цих уламків досі видніються прадавні символи." }
    t[186686] = { name = "Бліді Віщунські Кістки", fen = "A set of small bones with symbols carved into them that allow the user to learn about their future.", fua = "Набір дрібних кісток із вирізьбленими символами, що дають змогу власнику зазирнути у своє майбутнє." }
    t[186687] = "Спогад про Небесних Духів"
    t[186688] = { name = "Наповнене Золотом Відро", fen = "The handle really makes it easy to move around the gold held within.", fua = "Ручка справді полегшує перенесення золота, що лежить усередині." }
    t[186689] = "Спогад про Розколоті Стихії"
    t[186690] = { name = "Наповнена Золотом Діжка", fen = "Rendle was pretty upset when he had to use his brew barrel for holding gold.", fua = "Рендл був добряче засмучений, коли йому довелося використати свою пивну діжку для золота." }
    t[186691] = { name = "Наповнена Золотом Сумка", fen = "Extra stitching was used to make the satchels able to hold all the coins.", fua = "Аби сумка вмістила всі монети, її прошили додатково." }
    t[186692] = { name = "Наповнений Золотом Шолом", fen = "Instructions note to hold upside down until ready to take out coins.", fua = "В інструкції зазначено тримати догори дном, доки не будеш готовий діставати монети." }
    t[186693] = { name = "Наповнена Золотом Тачка", fen = "When you need a wheelbarrow to hold all your gold do you have enough?", fua = "Якщо тобі потрібна тачка, щоб умістити все своє золото, чи означає це, що його достатньо?" }
    t[186694] = { name = "Тінева Торба Руди", fen = "A bag of ore from the Shadowlands.", fua = "Торба руди з Тіньових Земель." }
    t[186696] = { name = "Монета Послуг Картелю Та", fen = "A symbolic coin that recognizes the completion of a favor for a favor.", fua = "Символічна монета, що засвідчує виконання послуги за послугу." }
    t[186697] = "Вибух Цвіту"
    t[186698] = "Спалах Смолоскипа"
    t[186699] = "Удовиний Вибух"
    t[186700] = "Кістковий Вибух"
    t[186701] = "Спалах Слави"
    t[186702] = { name = "Бліда Кістяна Флейта", fen = "A bone flute from the land of the dead? Doesn't seem ominous at all.", fua = "Кістяна флейта з краю мертвих? Звучить аж ніяк не зловісно." }
    t[186703] = { name = "Золотий Келих", fen = "The cup itself looks to be worth a lot of gold alone.", fua = "Сам по собі цей келих коштує чималого золота." }
    t[186704] = "Сутінковий Чай"
    t[186705] = { name = "Наповнений Золотом Келих", fen = "Rendle scooped out a heaping pile of coins from his enormous cache to fill the cup.", fua = "Рендл начерпав цілу гору монет зі свого величезного сховку, щоб наповнити келих." }
    t[186706] = { name = "Наповнений Золотом Капелюх", fen = "The threads of the hat are straining under the weight of all the coins it is holding.", fua = "Нитки капелюха ледь витримують вагу всіх монет, що в ньому лежать." }
    t[186707] = { name = "Наповнена Золотом Скриня", fen = "The crate is so full of coins that they are slipping out between the lid.", fua = "Скриня настільки повна монет, що вони висипаються крізь щілину під кришкою." }
    t[186708] = { name = "Наповнений Золотом Стакан Для Пензлів", fen = "No one usually questions the odd interests of a dredger, especialy one that provides such a crucial service as gear repair.", fua = "Зазвичай ніхто не питає про дивні захоплення землекопа, надто коли той надає таку важливу послугу, як лагодження спорядження." }
    t[186710] = "Спогад про Покірних"
    t[186712] = "Спогад про Смертошпиль"
    t[186713] = { name = "Керівний Перстень Нілганіхмата", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[186714] = { name = "Дослідницький Звіт: Всевидющий Кристал", fen = "Roh-Suir was able to recreate the research on an All-Seeing Crystal, allowing you to affix one to the Lodestaff to detect other relics.", fua = "Рох-Суір зміг відтворити дослідження Всевидющого Кристала, що дозволяє вам прикріпити один такий до Жильного Посоха, щоб виявляти інші реліквії." }
    t[186715] = { name = "Дослідницький Звіт: Покращені Сплави", fen = "Analyzing the effects of domination magic on the items of Korthia and the Maw have lead to improved alloys that can allow us to make our items hardier and more powerful.", fua = "Аналіз впливу магії панування на предмети Кортії та Пащі привів до покращених сплавів, що дозволяють зробити наші предмети витривалішими й могутнішими." }
    t[186716] = { name = "Дослідницький Звіт: Стародавні Святилища", fen = "Further research into the mysterious Cipher of Understanding you recovered from the rift has allowed us to understand the interaction with the ancient shrine swords found around Korthia.", fua = "Подальше вивчення загадкового Шифру Розуміння, який ви видобули з розриву, дозволило нам зрозуміти взаємодію зі стародавніми мечами святилищ, що трапляються по всій Кортії." }
    t[186717] = { name = "Дослідницький Звіт: Адаптивні Сплави", fen = "Further research from the relic recovery have led us to discover new adaptive alloys that will further allow us to increase the power of items touched by domination magic in Korthia and the Maw.", fua = "Подальші дослідження після віднайдення реліквій привели нас до відкриття нових адаптивних сплавів, що дозволять нам ще більше підвищити силу предметів, торкнутих магією панування, у Кортії та Пащі." }
    t[186718] = { name = "Набір для Ремонту Телепортера", fen = "One thing remains universal: righty tighty, lefty loosey. Required to repair Ancient Teleporters around Korthia, allowing access to hidden vaults.", fua = "Одне залишається незмінним: праворуч закручуй, ліворуч розкручуй. Потрібен для ремонту Стародавніх Телепортерів по всій Кортії, що відкриває доступ до прихованих сховищ." }
    t[186721] = "Трактат: Багатство Реліквій Тіньокраю"
    t[186722] = "Трактат: Вивчення Аніми та Збереження Кожної Краплі"
    t[186724] = { name = "Техніка: Контракт: Поступ Смерті", fen = "Teaches you how to craft a Contract: Death's Advance.", fua = "Навчає вас, як скласти Контракт: Поступ Смерті." }
    t[186725] = "Хліб із Кісткового Борошна"
    t[186726] = { name = "Пористий Льодяник-Камінець", fen = "Contains no nutritional value.", fua = "Не містить жодної поживної цінності." }
    t[186731] = { name = "Полагоджений Ключ Розриву", fen = "This stone shakes in your hand, humming with strange power and whispers from the beyond.", fua = "Цей камінь тремтить у вашій руці, гудучи дивною силою та шепотом із потойбіччя." }
    t[186732] = { name = "Скриня Незліченних Речей", fen = "Power from many realms courses through this box of woven metal and magic.", fua = "Сила багатьох світів струмує крізь цю скриню зі сплетеного металу й магії." }
    t[186734] = "Скалкошкіряні Черевики"
    t[186735] = "Скалкошкіряні Рукавиці"
    t[186736] = "Скалкошкіряний Каптур"
    t[186737] = "Шкіряні Штани зі Скалкошкіра"
    t[186738] = "Скалкошкіряний Ремінь"
    t[186739] = "Скалкошкіряні Манжети"
    t[186740] = "Збруя з Луски Лезокрила"
    t[186741] = "Чоботи з Луски Лезокрила"
    t[186742] = "Кулаки з Луски Лезокрила"
    t[186743] = "Каптур з Луски Лезокрила"
    t[186744] = "Штани з Луски Бритвокрила"
    t[186745] = "Наплічники з Луски Лезокрила"
    t[186746] = "Кольчуга з Луски Лезокрила"
    t[186747] = "Наручі з Луски Лезокрила"
    t[186748] = "Забрало Вартового Сховища"
    t[186749] = "Нагрудник Вартового Сховища"
    t[186750] = "Чоботи Вартового Сховища"
    t[186751] = "Рукавиці Вартового Сховища"
    t[186752] = "Латні Поножі Вартового Сховища"
    t[186753] = "Наплічники Вартового Сховища"
    t[186754] = "Пряжка Вартового Сховища"
    t[186755] = "Пов'язки Вартового Сховища"
    t[186756] = "Скалкошкіряний Колет"
    t[186757] = "Скалкошкіряні Еполети"
    t[186758] = "Баклер Кортіанського Хранителя"
    t[186759] = "Кортіанська Посудина Аніми"
    t[186760] = "Корфіанський Енергетичний Лук"
    t[186761] = "Клинок Кортіанського Прислужника"
    t[186762] = "Кортіанський Різак Аніми"
    t[186763] = "Стинач голів вартового сховища"
    t[186764] = "Бойовий Молот Кортіанського Захисника"
    t[186765] = "Булава Патрульного Сховища"
    t[186766] = "Посох патрульного сховища"
    t[186767] = "Скіпетр Кортіанського Прислужника"
    t[186768] = "Тростина Кортіанського Прислужника"
    t[186769] = "Бойова Глефа Хранителя Сховища"
    t[186770] = "Плащ Доглядача Сховища"
    t[186771] = "Різак патрульного сховища"
    t[186775] = "Спогад про Лунку Ясність"
    t[186776] = "Престижний Плащ Космічного Гладіатора"
    t[186777] = "Гербовий Плащ Космічного Гладіатора"
    t[186778] = "Чаша Космічного Гладіатора"
    t[186779] = "Захисник Космічного Гладіатора"
    t[186780] = "Плащ Космічного Гладіатора"
    t[186781] = "Накидка Космічного Гладіатора"
    t[186782] = "Накидка Космічного Гладіатора"
    t[186783] = "Великий Плащ Космічного Гладіатора"
    t[186784] = "Перстень Космічного Гладіатора"
    t[186785] = "Перстень Космічного Гладіатора"
    t[186786] = "Перстень-Печатка Космічного Гладіатора"
    t[186787] = "Намисто Космічного Гладіатора"
    t[186788] = "Амулет Космічного Гладіатора"
    t[186789] = "Амулет Космічного Гладіатора"
    t[186790] = "Шовкова Роба Космічного Гладіатора"
    t[186791] = "Шовкове Вбрання Космічного Гладіатора"
    t[186792] = "Шовкові Чоботи Космічного Гладіатора"
    t[186793] = "Шовкові Чоботи Космічного Гладіатора"
    t[186794] = "Шовкові Рукавички Космічного Гладіатора"
    t[186795] = "Шовкові Рукавиці Космічного Гладіатора"
    t[186796] = "Шовковий Каптур Космічного Гладіатора"
    t[186797] = "Шовковий Каптур Космічного Гладіатора"
    t[186798] = "Шовкові Поножі Космічного Гладіатора"
    t[186799] = "Шовкові Штани Космічного Гладіатора"
    t[186800] = "Шовковий Оплічник Космічного Гладіатора"
    t[186801] = "Шовковий Оплічник Космічного Гладіатора"
    t[186802] = "Шовковий Пояс Космічного Гладіатора"
    t[186803] = "Шовковий Пояс Космічного Гладіатора"
    t[186804] = "Шовкові Наручі Космічного Гладіатора"
    t[186805] = "Шовкові Наручі Космічного Гладіатора"
    t[186806] = "Шкіряний Нагрудник Космічного Гладіатора"
    t[186807] = "Шкіряний Нагрудник Космічного Гладіатора"
    t[186808] = "Шкіряні Чоботи Космічного Гладіатора"
    t[186809] = "Шкіряні Чоботи Космічного Гладіатора"
    t[186810] = "Шкіряні Рукавички Космічного Гладіатора"
    t[186811] = "Шкіряні Рукавиці Космічного Гладіатора"
    t[186812] = "Шкіряний Шолом Космічного Гладіатора"
    t[186813] = "Шкіряна Маска Космічного Гладіатора"
    t[186814] = "Шкіряні Штани Космічного Гладіатора"
    t[186815] = "Шкіряні Поножі-обмотки Космічного Гладіатора"
    t[186816] = "Шкіряні Наплічники Космічного Гладіатора"
    t[186817] = "Шкіряні Наплічники Космічного Гладіатора"
    t[186818] = "Шкіряний Пояс Космічного Гладіатора"
    t[186819] = "Шкіряний Пояс Космічного Гладіатора"
    t[186820] = "Шкіряні Наручі Космічного Гладіатора"
    t[186821] = "Шкіряні Наручі Космічного Гладіатора"
    t[186822] = "Кольчужний Нагрудник Космічного Гладіатора"
    t[186823] = "Кольчужна Туніка Космічного Гладіатора"
    t[186824] = "Кольчужні Чоботи Космічного Гладіатора"
    t[186825] = "Кольчужні Чоботи Космічного Гладіатора"
    t[186826] = "Кольчужні Латні Рукавиці Космічного Гладіатора"
    t[186827] = "Кольчужні Рукавиці Космічного Гладіатора"
    t[186828] = "Кольчужний Шолом Космічного Гладіатора"
    t[186829] = "Кольчужний Шолом Космічного Гладіатора"
    t[186830] = "Кольчужні Поножі Космічного Гладіатора"
    t[186831] = "Кольчужні Штани Космічного Гладіатора"
    t[186832] = "Кольчужні Наплічники Космічного Гладіатора"
    t[186833] = "Кольчужні Наплічники Космічного Гладіатора"
    t[186834] = "Кольчужний Пояс Космічного Гладіатора"
    t[186835] = "Кольчужний Пояс Космічного Гладіатора"
    t[186836] = "Кольчужні Наручі Космічного Гладіатора"
    t[186837] = "Кольчужні Наручі Космічного Гладіатора"
    t[186838] = "Латний Нагрудник Космічного Гладіатора"
    t[186839] = "Латний Нагрудник Космічного Гладіатора"
    t[186840] = "Латні Бойові Чоботи Космічного Гладіатора"
    t[186841] = "Латні Чоботи Космічного Гладіатора"
    t[186842] = "Латні Рукавиці Космічного Гладіатора"
    t[186843] = "Латні Рукавиці Космічного Гладіатора"
    t[186844] = "Латний Шолом Космічного Гладіатора"
    t[186845] = "Латний Шолом Космічного Гладіатора"
    t[186846] = "Латні Поножі Космічного Гладіатора"
    t[186847] = "Латні Бойові Поножі Космічного Гладіатора"
    t[186848] = "Латні Наплічники Космічного Гладіатора"
    t[186849] = "Латні Наплічники Космічного Гладіатора"
    t[186850] = "Латний Пояс Космічного Гладіатора"
    t[186851] = "Латний Широкий Пояс Космічного Гладіатора"
    t[186852] = "Латні Наручі Космічного Гладіатора"
    t[186853] = "Латні Наручі Космічного Гладіатора"
    t[186854] = "Розколювач Космічного Гладіатора"
    t[186855] = "Січка Космічного Гладіатора"
    t[186856] = "Ніж Космічного Гладіатора"
    t[186857] = "Ритуальний Кинджал Космічного Гладіатора"
    t[186858] = "Гладіус Космічного Гладіатора"
    t[186859] = "Церемоніальний Меч Космічного Гладіатора"
    t[186860] = "Ксифос Космічного Гладіатора"
    t[186861] = "Бойова Глефа Космічного Гладіатора"
    t[186862] = "Подрібнювач Космічного Гладіатора"
    t[186863] = "Баліста Космічного Гладіатора"
    t[186864] = "Коса Космічного Гладіатора"
    t[186865] = "Вечірній Дзвін Космічного Гладіатора"
    t[186866] = "Значок Лютості Космічного Гладіатора"
    t[186867] = "Відзнака Жвавості Космічного Гладіатора"
    t[186868] = "Емблема Космічного Гладіатора"
    t[186869] = "Медальйон Космічного Гладіатора"
    t[186870] = "Невблаганна Брошка Космічного Гладіатора"
    t[186871] = "Сигіл Пристосування Космічного Гладіатора"
    t[186872] = "Латний Шолом Космічного Претендента"
    t[186873] = "Плащ Космічного Претендента"
    t[186874] = "Шовкова Туніка Космічного Претендента"
    t[186875] = "Латний Нагрудник Космічного Претендента"
    t[186876] = "Кольчужний Нагрудник Космічного Претендента"
    t[186877] = "Шкіряний Нагрудник Космічного Претендента"
    t[186878] = "Латні Бойові Чоботи Космічного Претендента"
    t[186879] = "Шовкові Чоботи Космічного Претендента"
    t[186880] = "Кольчужні Чоботи Космічного Претендента"
    t[186881] = "Шкіряні Чоботи Космічного Претендента"
    t[186882] = "Шкіряні Рукавички Космічного Претендента"
    t[186883] = "Латні Рукавиці Космічного Претендента"
    t[186884] = "Шовкові Рукавички Космічного Претендента"
    t[186885] = "Кольчужні Латні Рукавиці Космічного Претендента"
    t[186886] = "Шовковий Каптур Космічного Претендента"
    t[186887] = "Кольчужний Шолом Космічного Претендента"
    t[186888] = "Шкіряний Шолом Космічного Претендента"
    t[186889] = "Латні Поножі Космічного Адепта"
    t[186890] = "Шовкові Поножі Космічного Адепта"
    t[186891] = "Кольчужні Поножі Космічного Адепта"
    t[186892] = "Шкіряні Штани Космічного Адепта"
    t[186893] = "Шкіряні Наплічники Космічного Претендента"
    t[186894] = "Латні Оплічники Космічного Претендента"
    t[186895] = "Шовковий Оплічник Космічного Претендента"
    t[186896] = "Кольчужні Оплічники Космічного Претендента"
    t[186897] = "Латний Пояс Космічного Претендента"
    t[186898] = "Шовковий Шнур Космічного Претендента"
    t[186899] = "Кольчужний Пояс Космічного Претендента"
    t[186900] = "Шкіряний Пояс Космічного Претендента"
    t[186901] = "Перстень Космічного Претендента"
    t[186902] = "Шовкові Наручі Космічного Претендента"
    t[186903] = "Латні Манжети Космічного Претендента"
    t[186904] = "Кольчужні Наручні Пов'язки Космічного Претендента"
    t[186905] = "Шкіряні Наручні Пов'язки Космічного Претендента"
    t[186906] = "Значок Лютості Космічного Претендента"
    t[186907] = "Намисто Космічного Претендента"
    t[186908] = "Латний Наголовник Космічного Претендента"
    t[186909] = "Накидка Космічного Претендента"
    t[186910] = "Шовковий Нагрудник Космічного Претендента"
    t[186911] = "Латний Обладунок Космічного Претендента"
    t[186912] = "Кольчужна Туніка Космічного Претендента"
    t[186913] = "Шкіряна Туніка Космічного Претендента"
    t[186914] = "Латні Чоботиська Космічного Претендента"
    t[186915] = "Шовкові Обмотки Космічного Претендента"
    t[186916] = "Кольчужні Чоботиська Космічного Претендента"
    t[186917] = "Шкіряні Черевики Космічного Претендента"
    t[186918] = "Шкіряні Рукавиці Космічного Претендента"
    t[186919] = "Латні Рукавиці-Захисти Космічного Претендента"
    t[186920] = "Шовкові Рукавиці Космічного Претендента"
    t[186921] = "Кольчужні Рукавиці Космічного Претендента"
    t[186922] = "Шовковий Каптур Космічного Претендента"
    t[186923] = "Кольчужний Наголовник Космічного Претендента"
    t[186924] = "Шкіряна Маска Космічного Претендента"
    t[186925] = "Латні Бойові Поножі Космічного Адепта"
    t[186926] = "Шовкові Поножі-обмотки Космічного Адепта"
    t[186927] = "Кольчужні Бойові Поножі Космічного Адепта"
    t[186928] = "Шкіряні Поножі Космічного Адепта"
    t[186929] = "Шкіряний Оплічник Космічного Претендента"
    t[186930] = "Латні Наплічники Космічного Претендента"
    t[186931] = "Шовкова Накидка Космічного Претендента"
    t[186932] = "Кольчужні Наплічники Космічного Претендента"
    t[186933] = "Латний Широкий Пояс Космічного Претендента"
    t[186934] = "Шовковий Пояс Космічного Претендента"
    t[186935] = "Кольчужна Застібка Космічного Претендента"
    t[186936] = "Шкіряний Шнур Космічного Претендента"
    t[186937] = "Перстень Космічного Претендента"
    t[186938] = "Шовкові Пов'язки Космічного Претендента"
    t[186939] = "Латні Наручі Космічного Претендента"
    t[186940] = "Кольчужні Наручі Космічного Претендента"
    t[186941] = "Шкіряні Наручі Космічного Претендента"
    t[186942] = "Відзнака Завзяття Космічного Претендента"
    t[186943] = "Намисто Космічного Претендента"
    t[186944] = "Плащ Космічного Претендента"
    t[186945] = "Перстень-Печатка Космічного Претендента"
    t[186946] = "Емблема Космічного Претендента"
    t[186947] = "Амулет Космічного Претендента"
    t[186948] = "Бойова Сокира Космічного Шукача"
    t[186949] = "Кинджал Космічного Шукача"
    t[186950] = "Булава Космічного Шукача"
    t[186951] = "Древкова Зброя Космічного Претендента"
    t[186952] = "Посох Космічного Претендента"
    t[186953] = "Меч Космічного Шукача"
    t[186954] = "Дворучна Сокира Космічного Претендента"
    t[186955] = "Дворучний Меч Космічного Претендента"
    t[186956] = "Сфера Космічного Претендента"
    t[186957] = "Бойова Глефа Космічного Шукача"
    t[186958] = "Молот Космічного Шукача"
    t[186959] = "Бар'єр Космічного Претендента"
    t[186960] = "Топірець Космічного Шукача"
    t[186961] = "Рекурсивний лук космічного претендента"
    t[186962] = "Довгий Спис Космічного Претендента"
    t[186963] = "Клинок Космічного Шукача"
    t[186964] = "Кийок Космічного Шукача"
    t[186965] = "Серп Космічного Шукача"
    t[186966] = "Медальйон Космічного Претендента"
    t[186967] = "Невблаганна Брошка Космічного Претендента"
    t[186968] = "Сигіл Пристосування Космічного Претендента"
    t[186969] = { name = "Розпадливий Камінь Розриву", fen = "This weakened artifact has a limited number of charges.", fua = "Цей ослаблений артефакт має обмежену кількість зарядів." }
    t[186970] = { name = "Рука Годувальниці з Ключем", fen = "Yeah she bit the hand...", fua = "Так, вона вкусила руку..." }
    t[186971] = "Рука Годувальника"
    t[186973] = "Анімований Повідець"
    t[186974] = { name = "Експериментальна Комірка Аніми", fen = "What powers might lie within the orb if taken outside of Torghast?", fua = "Які сили могли б критися всередині сфери, якби винести її за межі Торгаста?" }
    t[186975] = { name = "Рушник із Запинної Тканини", fen = "Cleanliness is next to Titaness.", fua = "Чистота — крок до титанства." }
    t[186976] = "Тонке Перо Гострокрила"
    t[186977] = "Череповий Півмісяць Звіроклича"
    t[186978] = "Позичений Серп Ока"
    t[186980] = "Кайдани Розкутого Гладіатора"
    t[186981] = "Пориста Кам'яна Статуя"
    t[186982] = "Затьмарена Кам'яна Статуя"
    t[186983] = "Ланцюг Прислужника"
    t[186984] = { name = "Ключ із Корітового Кристала", fen = "The bite marks marring this key suggest its previous owner may have visited an outlook inhabited by voracious wildlife... and left in quite a hurry.", fua = "Сліди укусів на цьому ключі натякають, що його попередній власник, можливо, навідав оглядовий майданчик, заселений ненажерливою живністю... і пішов звідти вкрай поспіхом." }
    t[186985] = "Невловні Ласощі для Улюбленця"
    t[186986] = { name = "Рецепт: Вдовиний Вибух", fen = "Teaches you how to craft a Widow Burst.", fua = "Навчає вас, як виготовити Вдовиний Вибух." }
    t[186987] = { name = "Рецепт: Смолоскиповий Вибух", fen = "Teaches you how to craft a Torch Burst.", fua = "Навчає вас, як виготовити Смолоскиповий Вибух." }
    t[186988] = { name = "Рецепт: Славний Вибух", fen = "Teaches you how to craft a Glory Burst.", fua = "Навчає вас, як виготовити Славний Вибух." }
    t[186989] = { name = "Рецепт: Кістковий Вибух", fen = "Teaches you how to craft a Marrow Burst.", fua = "Навчає вас, як виготовити Кістковий Вибух." }
    t[186990] = { name = "Рецепт: Квітковий Вибух", fen = "Teaches you how to craft a Blossom Burst.", fua = "Навчає вас, як виготовити Квітковий Вибух." }
    t[186991] = { name = "Рецепт: Трансмутація: Каміння на Руду", fen = "Teaches you how to Transmute: Stones to Ore.", fua = "Навчає вас Трансмутації: Каміння на Руду." }
    t[186992] = { name = "Формула: Анімований Повідець", fen = "Teaches you how to make an Anima-ted Leash.", fua = "Навчає вас, як виготовити Анімований Повідець." }
    t[186993] = { name = "Креслення: Пориста Кам'яна Статуя", fen = "Teaches you how to make a Porous Stone Statue.", fua = "Навчає вас, як виготовити Пористу Кам'яну Статую." }
    t[186994] = { name = "Креслення: Затінена Кам'яна Статуя", fen = "Teaches you how to make a Shaded Stone Statue.", fua = "Навчає вас, як виготовити Затінену Кам'яну Статую." }
    t[186995] = { name = "Викрійка: Рушник із Запинної Тканини", fen = "Teaches you how to make a Shrouded Hand Towel.", fua = "Навчає вас, як виготовити Рушник із Запинної Тканини." }
    t[186997] = "Накидка Поступу Смерті"
    t[186998] = { name = "Викрійка: Бліді Віщунські Кістки", fen = "Teaches you how to craft a Pallid Oracle Bones.", fua = "Навчає вас, як виготовити Бліді Віщунські Кістки." }
    t[186999] = { name = "Викрійка: Бліда Кістяна Флейта", fen = "Teaches you how to craft a Pallid Bone Flute.", fua = "Навчає вас, як виготовити Бліду Кістяну Флейту." }
    t[187000] = { name = "Викрійка: Невловне Ласощі для Улюбленця", fen = "Teaches you how to craft a Wind-Up Skeleton.", fua = "Навчає вас, як виготовити Заводний Скелет." }
    t[187006] = { name = "Рецепт: Сутінковий Чай", fen = "Teaches you how to craft a Twilight Tea.", fua = "Навчає вас, як виготовити Сутінковий Чай." }
    t[187007] = { name = "Рецепт: Хліб із Кісткового Борошна", fen = "Teaches you how to craft a Bonemeal Bread.", fua = "Навчає вас, як виготовити Хліб із Кісткового Борошна." }
    t[187008] = { name = "Рецепт: Пористий Льодяник-Камінець", fen = "Teaches you how to craft a Porous Rock Candy.", fua = "Навчає вас, як виготовити Пористий Льодяник-Камінець." }
    t[187011] = "Наплічні Шпилі Карателя-Присяжного Утроби"
    t[187012] = "Розбалансований Розломний Камінь"
    t[187013] = "Наплічники Перехоплювача"
    t[187014] = "Шипасті Наплічники Кайданника"
    t[187015] = "Наплічники Душожера"
    t[187016] = "Шипастий Оплічник Патрача"
    t[187017] = "Оплічник Душогуба"
    t[187018] = "Наплічні Коси Ритуаліста"
    t[187019] = "Наплічники Лазутчика"
    t[187020] = "Наплічники Некров'язя"
    t[187021] = "Шипастий Оплічник Карателя"
    t[187022] = "Наплічники Лейтенанта-Присяжного Утроби"
    t[187023] = "Оплічник Наставника"
    t[187024] = "Оплічник Некроманта"
    t[187025] = "Спинна Темниця Боленосця"
    t[187026] = "Набір Тортур Польового Наглядача"
    t[187027] = "Наплічні Шпичаки Сколдуса"
    t[187028] = "Припаси Кодексу Архіваріусів"
    t[187029] = "Таємничий Подарунок від Ве'нарі"
    t[187030] = "Наплічники Смертоприсяжного"
    t[187031] = "Височенний Оплічник Пащі"
    t[187032] = "Наплічники Пророкованої Смерті"
    t[187033] = { name = "Малий Ключ Підношень", fen = "An ornate key meant to unlock the offering boxes used in various Korthian rituals.", fua = "Оздоблений ключ, призначений відмикати скрині підношень, що використовуються в різних кортіанських ритуалах." }
    t[187034] = "Позолочена Клітка Агонії"
    t[187035] = "Холодний Тягар Проклятих"
    t[187038] = "Наплічники Несамовитого Розтину"
    t[187039] = "Стигійські Наплічники Маллеара"
    t[187040] = "Наплічники Двох Кіс"
    t[187041] = "Наплічники Незламної Загибелі"
    t[187042] = "Оздобний Горжет Окультиста"
    t[187043] = "Шипасті Наплічники Цитаделі"
    t[187044] = "Наплічники Смертоносця"
    t[187045] = "Оплічник Завуальованого Мучителя"
    t[187046] = "Наплічники Бездоганного Шматування"
    t[187047] = { name = "Личина Перевертня", fen = "The surface of this mask is shifting, changing. As you gaze upon it, dozens of different countenances can be discerned.", fua = "Поверхня цієї маски зсувається й змінюється. Поки ви вдивляєтеся в неї, можна розрізнити десятки різних облич." }
    t[187051] = "Забута Пір'їна"
    t[187052] = { name = "Зоря Потойбіччя", fen = "Thrumming gently with potential energy.", fua = "Тихо вібрує потенційною енергією." }
    t[187054] = { name = "Загублене Яйце Гострокрила", fen = "The devourer must have either raided a razorwing nest or it tumbled down from above. Maybe if you return it to its nest the matriarch will be grateful.", fua = "Пожирач, мабуть, або сплюндрував гніздо гострокрила, або яйце скотилося згори. Можливо, якщо повернути його до гнізда, матріарх буде вдячна." }
    t[187055] = { name = "Гаманець із Руновими Фішками", fen = "A single lonely chit rattles around in the pouch.", fua = "Самотня фішка торохтить у гаманці." }
    t[187056] = "Ненажерливий Холод"
    t[187057] = "Уламок Бека"
    t[187059] = "Уламок Яса"
    t[187061] = "Скалка Рева"
    t[187063] = "Уламок Кора"
    t[187065] = "Уламок Кіра"
    t[187071] = "Скалка Тела"
    t[187073] = "Уламок Диза"
    t[187075] = "Коробка Брязкітливих Ланцюгів"
    t[187076] = "Уламок Ота"
    t[187077] = { name = "Запакований Попіл Душ", fen = "Packed for easy transfer. A significant chunk of Soul Ash was lost due to its volatile nature.", fua = "Запакований для зручного перенесення. Значну частину Попелу Душ втрачено через його нестійку природу." }
    t[187079] = "Скалка Зеда"
    t[187081] = "Череповий Півмісяць Чорного Полум'я"
    t[187082] = "Позолочений Серп Черепа"
    t[187083] = "Позолочений Серп Ока"
    t[187084] = "Серп Ока Тюремника"
    t[187085] = "Срібні Плечові Рожни"
    t[187086] = "Срібні Наплічники Смертоприсяжного"
    t[187087] = "Срібний Оплічник Протинача"
    t[187088] = "Срібні Черепокрилі Наплічники"
    t[187089] = "Срібні Наплічники з Лезами"
    t[187090] = "Срібні Крилолезі Наплічники"
    t[187091] = "Позолочені Наплічники з Подвійною Косою"
    t[187092] = "Позолочені Наплічні Щити"
    t[187093] = "Позолочений Оздобний Оплічник"
    t[187094] = "Позолочені Шипасті Фортеці"
    t[187095] = "Срібні Шипасті Наплічники"
    t[187096] = "Наплічники Непохитного Сховку"
    t[187097] = "Наплічні Пластини Конструкта"
    t[187098] = "Срібні Наплічники з Подвійною Косою"
    t[187099] = "Срібні Наплічники-Фортеці"
    t[187100] = "Срібний Оздобний Оплічник"
    t[187101] = "Срібні Плечові Щити"
    t[187103] = { name = "Вічноживуща Статуетка", fen = "The events that this statuette have witnessed would boggle the mind. One could learn a lot from it, if only it wasn't so duplicitous.", fua = "Події, свідком яких була ця статуетка, годі й уявити. З неї можна було б багато чого навчитися, якби тільки вона не була такою дволикою." }
    t[187104] = { name = "Обеліск Темних Звісток", fen = "While in proximity of the obelisk, a voice in your head murmurs sweet lies and maddening truths.", fua = "Поблизу обеліска голос у вашій голові шепоче солодку брехню й божевільні істини." }
    t[187105] = "Спогад про Болісний Погляд"
    t[187106] = "Спогад про Божественний Резонанс"
    t[187107] = "Спогад про Молот Обов'язку"
    t[187109] = "Спогад про Полум'яну Різанину"
    t[187111] = "Спогад про Сліпу Віру"
    t[187113] = { name = "Власна Гиря з Ланцюгом", fen = "There are many like it, but this one is mine.", fua = "Таких багато, але ця моя." }
    t[187115] = { name = "Послання Прислужників Пащі", fen = "Details of the Jailer's orders.", fua = "Подробиці наказів Тюремника." }
    t[187117] = { name = "Лазурові Сторінки", fen = "Torn pages that brim with energy.", fua = "Вирвані сторінки, що повняться енергією." }
    t[187118] = "Спогад про Демонічну Присягу"
    t[187119] = { name = "Перстень Самоспоглядання", fen = "When the gemstone set into the band is viewed at an oblique angle, a shimmering duplicate of the ring can be seen.", fua = "Коли дивишся на вставлений у перстень самоцвіт під косим кутом, можна побачити мерехтливу копію персня." }
    t[187123] = { name = "Дрібничка Підсилення", fen = "Use to power up target Shard of Domination", fua = "Використайте, щоб підсилити обрану Скалку Панування." }
    t[187124] = { name = "Медальйон Гніву", fen = "Bestowed upon Venthyr by The Sire himself. Allows the wearer to exert partial dominion over Revendreth.", fua = "Дарований вентирам самим Сіром. Дозволяє власнику частково панувати над Ревендретом." }
    t[187126] = { name = "Викинутий Щоденник", fen = "Penned by the broker Xevveth, this appears to have been misplaced.", fua = "Написаний посередником Ксеввефом, цей щоденник, схоже, кудись загубили." }
    t[187127] = "Спогад про Осяйний Жар"
    t[187131] = { name = "Нутрощі Автоми", fen = "... goopy?", fua = "...слизькі?" }
    t[187132] = "Спогад про Пори Достатку"
    t[187134] = "Гранувальник Викривлення Сплаву"
    t[187136] = { name = "Дослідницький Звіт: Техніки Огляду Реліквій", fen = "As research techniques improve the Archivist is able to gather more knowledge from each fragment brought to him.", fua = "З удосконаленням дослідницьких технік архіваріус здатен здобути більше знань з кожного принесеного йому уламка." }
    t[187137] = { name = "Дослідницький Звіт: Техніки Пошуку Реліквій", fen = "Knowing how to identify missing relics is critical to our efforts and so this report outlines tips and tricks to sometimes find more relic fragments from common sources.", fua = "Уміння розпізнавати зниклі реліквії має вирішальне значення для нашої справи, тож цей звіт окреслює поради й хитрощі, як іноді знайти більше уламків реліквій із звичайних джерел." }
    t[187138] = { name = "Дослідницький Звіт: Перші Сплави", fen = "With access to the full Archivists' Codex, we now understand the binding power of domination magic and how that lines up with some of the first alloys seen in the Shadowlands, allowing us to further improve your Korthia and Maw items.", fua = "Маючи доступ до повного Кодексу Архіваріусів, ми тепер розуміємо зв'язуючу силу магії панування та її співвідношення з деякими з перших сплавів, побачених у Тіньокраї, що дозволяє нам ще більше вдосконалити ваші предмети з Кортії та Пащі." }
    t[187139] = { name = "Серце Тіні в Пляшці", fen = "The contents within are best left undisturbed.", fua = "Те, що всередині, краще не чіпати." }
    t[187140] = "Перстень Дволикості"
    t[187141] = "Бездоганне Вовче Ядро"
    t[187142] = "Бездоганне Оленяче Ядро"
    t[187143] = "Бездоганне Ядро Раптори"
    t[187145] = "Трактат: Розпізнавання Стигії та Її Застосування"
    t[187148] = { name = "Скалка, Прив'язана до Смерті", fen = "Can be used at the Forge of Bonds to uncover an unknown conduit or conduit rank.", fua = "Можна використати в Кузні Уз, щоб виявити невідомий провідник або ранг провідника." }
    t[187150] = { name = "Фетиш із Кігтя Горака", fen = "Terrible to behold and foul-smelling besides.", fua = "Жахливий на вигляд, та ще й огидно смердить." }
    t[187152] = "Ключ Автоми"
    t[187153] = { name = "Смачний Гриб Пащі", fen = "Only a hardy animal would find these tasty...", fua = "Тільки витривала тварина вважатиме їх смачними..." }
    t[187154] = "Прадавні Кортіанські Руни"
    t[187155] = "Личина Перевертня"
    t[187158] = { name = "Окуляр Прояснення", fen = "Enchanted by Al'firim to pierce broker illusions.", fua = "Зачарований Ал'фірімом, щоб пронизувати ілюзії посередників." }
    t[187159] = "Короткий Меч, що Розтинає Тіні"
    t[187160] = "Спогад про Блідий Наказ"
    t[187161] = "Спогад про Угоду Бвонсамді"
    t[187162] = "Спогад про Тіньове Слово: Маніпуляція"
    t[187163] = "Спогад про Гармонію Сфер"
    t[187171] = { name = "Органічна Диня", fen = "Will it Blend?", fua = "А чи подрібниться?" }
    t[187173] = { name = "Звивисте Щупальце", fen = "Will it Blend?", fua = "А чи подрібниться?" }
    t[187174] = "Затьмарений Камінь Суду"
    t[187175] = "Злиток Хранителя Рун"
    t[187176] = "Дзвін Гармонії"
    t[187178] = { name = "Улюблена Плюшева Іграшка Ск'утті", fen = "Will it Blend?", fua = "А чи подрібниться?" }
    t[187179] = { name = "Світлові Палички", fen = "Will it Blend?", fua = "А чи подрібниться?" }
    t[187180] = "Поточене Прозоре Крило"
    t[187181] = { name = "Мале Яйце Трупної Мухи", fen = "The Lord of the Heap's progeny should go far.", fua = "Нащадок Володаря Купи має сягнути далеко." }
    t[187182] = { name = "Яйце Трупної Мухи, що Вилуплюється", fen = "See what will emerge from the egg.", fua = "Подивіться, що вилупиться з яйця." }
    t[187183] = { name = "Лютий Шматувальник", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187184] = "Дзвін Ясності"
    t[187185] = "Дзвін Віри"
    t[187186] = { name = "Сфера Облуди", fen = "Suspicious...", fua = "Підозріло..." }
    t[187187] = "Кортіанське Озброєння"
    t[187188] = { name = "Бездонна Фляга Д'роо", fen = "Despite your best efforts, you can't seem to fill it.", fua = "Хоч як старайся, наповнити її, схоже, неможливо." }
    t[187189] = { name = "Гіперсвітловий Мультитул", fen = "Invented by Di'lks of Cartel Xy, an essential tool used anywhere Broker technology is crafted.", fua = "Винайдений Ді'лксом із картелю Ксі, незамінний інструмент, який використовують усюди, де створюють технології посередників." }
    t[187190] = { name = "Сорочка з Квітковим Принтом", fen = "A vintage yet stylish garment designed by N'uth of Cartel Al.", fua = "Вінтажне, та все ж стильне вбрання, розроблене Н'утом із картелю Ал." }
    t[187191] = { name = "Збережене Око Ві'лера", fen = "It seems to lead you along the path should you find yourself lost.", fua = "Воно немовби веде вас уперед, якщо ви раптом загубилися." }
    t[187192] = { name = "Урна Знань", fen = "The preserved memories of Ny'lad of Cartel Ta, carefully redacted into the urn for future study before he moved on.", fua = "Збережені спогади Ні'лада з картелю Та, дбайливо занесені до урни для подальшого вивчення, перш ніж він рушив далі." }
    t[187193] = { name = "Опудало Чайки з Автографом", fen = "The craftsmanship is stunning, an embroidered signature across the beak reads K'en.", fua = "Майстерність вражає, а вишитий на дзьобі підпис промовляє: К'ен." }
    t[187194] = { name = "Сонечко в Слоїку", fen = "Plucked from the skies by Startamer Ja'z of Cartel Zo, the star appears carefully placed into a jar for others to enjoy.", fua = "Зірку, зірвану з небес Зореприборкувачем Джа'з із картелю Зо, дбайливо вмістили в слоїк на втіху іншим." }
    t[187195] = { name = "Золотий Саксофон", fen = "An instrument once played by the legendary Myza's Oasis act, Ta'ylor.", fua = "Інструмент, на якому колись грав Та'йлор, легендарний артист з Оази Майзи." }
    t[187196] = { name = "Жетон Безкінечної Аркади", fen = "Ta'piper fastened an invisible string to the token, allowing endless hours of fun for he and his friends.", fua = "Та'пайпер прив'язав до жетона невидиму нитку, даруючи собі й друзям безкінечні години розваг." }
    t[187197] = { name = "Примарна Барабанна Установка Д'роо", fen = "A charismatic spirit appears to haunt the kit, coming to life when it hears a nearby joke.", fua = "Здається, установку населяє харизматичний дух, що оживає, коли чує поряд жарт." }
    t[187198] = { name = "Фінік Ксі'ле", fen = "A common snack of the Xy cartel, easy to enjoy with others.", fua = "Звична закуска картелю Ксі, якою легко поласувати в компанії." }
    t[187199] = { name = "Рунова Головоломка Па'хікс", fen = "An intricate game to be solved with friends, created by the famous codebreaker herself.", fua = "Хитромудра гра, яку варто розв'язувати з друзями, створена самою знаменитою зломницею шифрів." }
    t[187206] = { name = "Книга Зв'язування: Божевільна Відьма", fen = "This book is incomplete. A deranged voice from within repeatedly and urgently requests the recovery of crimson pages.", fua = "Ця книга неповна. Божевільний голос зсередини раз у раз наполегливо вимагає повернути багряні сторінки." }
    t[187207] = { name = "Загадковий Пристрій для Розшифрування", fen = "A similar design to Broker ethertype technology, yet infinitely more complex.", fua = "Конструкцією схожий на ефірну технологію посередників, та незмірно складніший." }
    t[187208] = { name = "Короткий Меч, що Розтинає Тіні", fen = "Keen and bright enough to sever shadows.", fua = "Достатньо гострий і яскравий, щоб розтинати тіні." }
    t[187209] = { name = "Різьблення по Дереву Родини Ланг", fen = "Well-worn with deep grooves in the wood. It must be thousands of years old.", fua = "Добряче потерте, з глибокими борознами в дереві. Йому, певно, тисячі років." }
    t[187210] = { name = "Книга Зв'язування: Змучений Чаклун", fen = "This book is incomplete. A deranged voice from within repeatedly and urgently requests the recovery of azure pages.", fua = "Ця книга неповна. Божевільний голос зсередини раз у раз наполегливо вимагає повернути блакитні сторінки." }
    t[187211] = { name = "Хроніка Картелю Ал", fen = "A collection of the inscribed tales of the greatest heroes passed down through the ages, signed by Al'len.", fua = "Збірка записаних оповідей про найвеличніших героїв, переданих крізь епохи, підписана Ал'леном." }
    t[187212] = { name = "Гіперсвітлові Мокасини", fen = "Designed with style and function in mind by the greatest shoemaker in Tazavesh, By'ron.", fua = "Поєднання стилю та зручності від найвидатнішого шевця Тазавеша, Байрона." }
    t[187213] = { name = "Міжгалактичний Сховок Джо", fen = "Well-suited for travel, the glowing vessel contains everything you need to thrive in any corner of the galaxy.", fua = "Добре пристосована для подорожей, ця сяйлива посудина містить усе потрібне, щоб процвітати в будь-якому куточку галактики." }
    t[187216] = { name = "Душоплетний Серп", fen = "Can be used at the Forge of Bonds to uncover an unknown conduit or conduit rank.", fua = "Можна використати в Кузні Уз, щоб виявити невідомий провідник або ранг провідника." }
    t[187217] = "Спогад про Щедре Вариво"
    t[187218] = "Фоліант Походжень"
    t[187219] = "Жетон Заслуги Прислужника"
    t[187220] = { name = "Згущена Сила", fen = "A strange orb radiating with Broker magic.", fua = "Дивна сфера, що випромінює магію посередників." }
    t[187221] = { name = "Сховок Душевного Попелу", fen = "Contains 250 Soul Ash.", fua = "Містить 250 душевного попелу." }
    t[187222] = { name = "Стигійська Сингулярність", fen = "Contains 500 Stygia.", fua = "Містить 500 стигії." }
    t[187223] = "Спогад про Насіння Буйного Росту"
    t[187224] = "Спогад про Елементальний Провідник"
    t[187225] = "Спогад про Згасаючий Душевний Прах"
    t[187226] = "Спогад про Скалки Знищення"
    t[187227] = "Спогад про Гнилу Душевну Торбину"
    t[187228] = "Спогад про Стримуваний Безперервний Вибух"
    t[187229] = "Спогад про Пакт Душоловів"
    t[187230] = "Спогад про Торбу Боєприпасів"
    t[187231] = "Спогад про Уламки Прадавніх Рогів"
    t[187232] = "Спогад про Торбинку з Гострими Уламками"
    t[187234] = { name = "Згущена Сила", fen = "A strange orb radiating with Broker magic.", fua = "Дивна сфера, що випромінює магію посередників." }
    t[187237] = "Спогад про Заклик до Зброї"
    t[187238] = { name = "Важка Шипаста Шкіра", fen = "A tough patch of hide, layered with vicious spines.", fua = "Цупкий клапоть шкіри, всіяний лютими шипами." }
    t[187239] = { name = "Зрілий Закостенілий Дзьоб", fen = "Boney and sharp, this beak can snap through armor.", fua = "Кістлявий і гострий, цей дзьоб може прокусити крізь обладунок." }
    t[187240] = "Пильне Око Польового Наглядача"
    t[187241] = "Пильне Око Проклятих"
    t[187242] = "Герб Проклятих Винищувача"
    t[187243] = "Серп Тіньового Мисливця"
    t[187245] = "Оповиті Смертю Шпилі"
    t[187246] = "Оповиті Смертю Наплічники"
    t[187247] = "Оповиті Смертю Наплічні Шипи"
    t[187248] = "Сяйливі Наплічники Крока"
    t[187250] = "Шипокрилі Наплічники Крока"
    t[187251] = "Наплічники Затьмареного Черепа"
    t[187252] = "Шипований Оплічник Ритуаліста"
    t[187253] = "Шипасті Наплічники Вартового Пащі"
    t[187254] = { name = "Композиція Аніми", fen = "Contains 175 Anima.", fua = "Містить 175 аніми." }
    t[187255] = { name = "Руки Непокори: Хроніка Скорботи", fen = "Recounting the tale of a clan of wicked giants damned to the Maw, and the punishments they endured for defying the Jailer.", fua = "Оповідь про клан лихих велетнів, приречених на Пащу, та про кари, яких вони зазнали за непокору Тюремникові." }
    t[187256] = { name = "Запасний Капелюх Гіпса", fen = "Gift to your Dredger Butler to give him the option of wearing this cool fedora.", fua = "Подаруйте своєму Дворецькому-Землекопу, щоб дати йому змогу носити цей чудовий капелюх." }
    t[187258] = "Спогад про Гармонію Фейлінії"
    t[187259] = "Спогад про Шалений Вир Вечірнього Дзвону"
    t[187264] = { name = "Голова Ве'райна", fen = "What other secrets might it contain?", fua = "Які ще таємниці вона може приховувати?" }
    t[187274] = { name = "Стародавній Сплав", fen = "This chunk of metal is tinged with impossibly ancient magic.", fua = "Цей кусень металу пройнятий неймовірно стародавньою магією." }
    t[187275] = { name = "Бойові Плани Присяжних Гелі", fen = "Intelligence reports and battle strategies for assaulting Keeper's Respite.", fua = "Розвідувальні звіти та бойові стратегії для штурму Притулку Хранителя." }
    t[187276] = { name = "Викрадені Кортіанські Припаси", fen = "Supplies stolen from Keeper's Respite by invasive Rift monsters.", fua = "Припаси, викрадені з Притулку Хранителя загарбницькими чудовиськами Розколини." }
    t[187277] = "Спогад про Лиховісні Вчення"
    t[187278] = { name = "Пробита Кігтем Скринька Присяжних Пащі", fen = "Falling from the wilderling's talon as you land a couple of items fall out but more items rattle within.", fua = "Коли ви приземляєтеся, вона випадає з кігтя дикуна, і кілька речей висипаються, але всередині торохтить ще більше." }
    t[187280] = "Спогад про Серце Фейрі"
    t[187281] = { name = "Сідло Дикуна", fen = "The escaped wilderling slipped this off during your last ride, insisting that you take it.", fua = "Утеклий дикун скинув його під час вашої останньої поїздки, наполягаючи, щоб ви його взяли." }
    t[187282] = { name = "Ціла Серцевина Аквілона", fen = "Left uncrushed by the devourer, this core could power your very own aquilon.", fua = "Не розчавлена пожирачем, ця серцевина могла б живити вашого власного аквілона." }
    t[187283] = { name = "Кристал Могилокрила", fen = "Pulsing with energy, the Stonewright would be able to use this in the creation of a mount.", fua = "Пульсуючи енергією, цей кристал Каменотеска могла б використати для створення засобу пересування." }
    t[187284] = "Лиховісна Скалка Бека"
    t[187285] = "Лиховісна Скалка Яса"
    t[187286] = "Лиховісна Скалка Рева"
    t[187287] = "Лиховісна Скалка Кора"
    t[187288] = "Лиховісна Скалка Кіра"
    t[187289] = "Лиховісна Скалка Тела"
    t[187290] = "Лиховісна Скалка Диза"
    t[187291] = "Лиховісна Скалка Ота"
    t[187292] = "Лиховісна Скалка Зеда"
    t[187293] = "Спустошена Скалка Бека"
    t[187294] = "Спустошена Скалка Джасу"
    t[187295] = "Спустошена Скалка Рева"
    t[187296] = "Спустошена Скалка Кора"
    t[187297] = "Спустошена Скалка Кіра"
    t[187298] = "Спустошена Скалка Тела"
    t[187299] = "Спустошена Скалка Дізу"
    t[187300] = "Спустошена Скалка Ота"
    t[187301] = "Спустошена Скалка Зеда"
    t[187302] = "Лиховісна Скалка Бека"
    t[187303] = "Лиховісна Скалка Яса"
    t[187304] = "Лиховісна Скалка Рева"
    t[187305] = "Лиховісна Скалка Кора"
    t[187306] = "Лиховісна Скалка Кіра"
    t[187307] = "Лиховісна Скалка Тела"
    t[187308] = "Лиховісна Скалка Диза"
    t[187309] = "Лиховісна Скалка Ота"
    t[187310] = "Лиховісна Скалка Зеда"
    t[187311] = { name = "Пошарпані Карти Азґота", fen = "A note near the bottom reads: Obtained by The House of Eyes.", fua = "Унизу є напис: «Здобуто Домом Очей»." }
    t[187312] = "Лиховісна Скалка Бека"
    t[187313] = "Лиховісна Скалка Яса"
    t[187314] = "Лиховісна Скалка Рева"
    t[187315] = "Лиховісна Скалка Кора"
    t[187316] = "Лиховісна Скалка Кіра"
    t[187317] = "Лиховісна Скалка Тела"
    t[187318] = "Лиховісна Скалка Диза"
    t[187319] = "Лиховісна Скалка Ота"
    t[187320] = "Лиховісна Скалка Зеда"
    t[187321] = "Термічний Руйнівник"
    t[187322] = { name = "Розсипчаста Кам'яна Скрижаль", fen = "Some of the runes are still visible.", fua = "Деякі руни ще видно." }
    t[187323] = { name = "Рунна Схема", fen = "Smudged but still legible.", fua = "Розмазана, але ще читабельна." }
    t[187324] = { name = "Погризений Стародавній Ідол", fen = "The top right is unrecognizable, but the rest is mostly intact.", fua = "Верхній правий край не розпізнати, але решта здебільшого ціла." }
    t[187325] = { name = "Вицвіла Ілюстрація Анатомії Лезокрила", fen = "The detail is exquisite, but only barely visible.", fua = "Деталізація вишукана, але ледь помітна." }
    t[187326] = { name = "Недокінчений Візерунок Рунокузні", fen = "A crucial step was left out of the middle, whether deliberately is unknown.", fua = "Із середини випущено вирішальний крок, та чи навмисно це сталося, невідомо." }
    t[187327] = { name = "Зашифрований Кортіанський Щоденник", fen = "Written in an ancient script the journal contains a lot of notes.", fua = "Написаний стародавнім письмом, щоденник містить чимало нотаток." }
    t[187328] = { name = "Подерта Карта Космології", fen = "You can discern it is referencing the cosmos, but it is very different from any you have seen on Azeroth.", fua = "Ви можете розрізнити, що вона стосується космосу, але вона дуже відрізняється від усіх, які ви бачили на Азероті." }
    t[187329] = { name = "Банка зі Зразком Древнього Бога", fen = "Floating in a suspension of some uknown liquid the eye looks perfectly preserved.", fua = "Плаваючи в завислій невідомій рідині, око має чудово збережений вигляд." }
    t[187330] = { name = "Уламок Скалки Наару", fen = "The fragment has a faint glow to it but you cannot tell if that is the light or more.", fua = "Уламок ледь помітно сяє, та ви не можете сказати, чи це Світло, чи щось більше." }
    t[187331] = { name = "Пошарпані Візерунки Фей", fen = "This torn parchment has some familiar fae pictures on it.", fua = "На цьому подертому пергаменті є кілька знайомих зображень фей." }
    t[187332] = { name = "Врятована Сторінка Голосів", fen = "The remnants of this page has the names of attendants who have previously served the Arbiter.", fua = "На рештках цієї сторінки збереглися імена прислужників, що колись служили Арбітрові." }
    t[187333] = { name = "Серцевина Невідомого Титана", fen = "A titan core that has been taken apart multiple times for study.", fua = "Серцевина титана, яку для вивчення розбирали кілька разів." }
    t[187334] = { name = "Розтрощена Скрижаль Порожнечі", fen = "Void energy leaks out from this tablet, along with whispers that are best left ignored.", fua = "Зі скрижалі сочиться енергія Порожнечі, а разом із нею шепоти, які краще не слухати." }
    t[187335] = { name = "Панцир Личинки Малдраксуса", fen = "This shell has the distinct smell of Maldraxxus to it. You know the one.", fua = "Цей панцир має виразний запах Малдраксуса. Ви знаєте, про який ідеться." }
    t[187336] = { name = "Заборонені Креслення Зброї", fen = "Tattered plans for weapons that the Primus has decreed to be too destructive for creation.", fua = "Пошарпані креслення зброї, яку Примус оголосив надто руйнівною, щоб її створювати." }
    t[187337] = { name = "Ключ від Сховку Присяжних Пащі", fen = "This key is in the shape of a sword that looks familiar...", fua = "Цей ключ має форму меча, що видається знайомим..." }
    t[187338] = { name = "Алебастрове Перо", fen = "It isn't clear what kind of creature left this feather, but it did not survive the pull into the maw.", fua = "Незрозуміло, яке створіння лишило це перо, але воно не пережило падіння в Пащу." }
    t[187339] = "Срібний Свисток Скалкошкіра"
    t[187340] = { name = "Кодекс Творення: Автома", fen = "A record of the different types of constructs in Zereth Mortis.", fua = "Запис про різні види конструктів у Зерет-Мортісі." }
    t[187343] = "Згущена Сфера Підношень"
    t[187344] = "Виробник Наборів Підношень"
    t[187345] = { name = "Оздоблена Скринька для Підношень", fen = "The box has some gold filigree and is immaculately crafted.", fua = "Скринька прикрашена золотою філігранню й виготовлена бездоганно." }
    t[187346] = { name = "Загублена Пам'ятка", fen = "There is a hard lump inside the hastily rolled scroll.", fua = "Усередині поспіхом скрученого сувою є твердий клубок." }
    t[187347] = { name = "Згущена Аніма", fen = "The protectors died to keep this gem of anima safe.", fua = "Захисники загинули, щоб уберегти цей самоцвіт аніми." }
    t[187348] = "Подертий Сувій"
    t[187349] = { name = "Сповнене Анімою Яйце", fen = "An extremely large burst of anima near the nest has crystallized the egg into pure anima.", fua = "Надзвичайно потужний сплеск аніми поблизу гнізда викристалізував яйце в чисту аніму." }
    t[187350] = { name = "Зміщена Реліквія", fen = "Holding the relic you feel an abnormal tug to somewhere else, where could this have come from?", fua = "Тримаючи реліквію, ви відчуваєте незвичний поклик кудись інде. Звідки ж це могло взятися?" }
    t[187351] = { name = "Стигійське Скупчення", fen = "Contains 250 Stygia.", fua = "Містить 250 стигії." }
    t[187352] = "Самоцвітне Серце Езекіля"
    t[187353] = { name = "Експериментальний Чай", fen = "A sample of Tubbins and Whisperdown's experimental tea.", fua = "Зразок експериментального чаю Таббінса та Шепотоплину." }
    t[187354] = { name = "Покинута Торба Посередника", fen = "The bag is heavier than it should be for just scrolls, something else is at the bottom.", fua = "Торба важча, ніж мала б бути для самих лише сувоїв, на дні є ще щось." }
    t[187355] = "Стегнова Кістка Пожирача"
    t[187356] = "Дрібні Кістки Громіта"
    t[187357] = "Зім'ятий Утробогриб"
    t[187358] = "Запорошений Кристал Медитації"
    t[187359] = "Миска для Води Ільви"
    t[187360] = "Куля Огортальних Розломів"
    t[187361] = "Розломопов'язаний Тіньовий Пронизувач"
    t[187362] = "Жалкий Тіньовий Верескун"
    t[187363] = "Спис Орґулууса"
    t[187364] = "Клинок Малдраксійського Зрадника"
    t[187365] = "Розсікач Розламу"
    t[187366] = "Шпиль Полеглого Вартового Сховища"
    t[187367] = "Вихровий клинок Деомена"
    t[187368] = "Жезл Контролю Ксіраксза"
    t[187369] = { name = "Парадна Роба Ве'райна", fen = "An odd thing to pack for a maw excursion.", fua = "Дивна річ, щоб брати її в подорож до Пащі." }
    t[187370] = "М'які Капці Чавила Карет"
    t[187371] = "Оксамитові Обмотки Рук з Громіту"
    t[187372] = { name = "Наголів'я для Фільтрування Міазмів", fen = "For when you are doing those odorous activities.", fua = "Для тих випадків, коли ви займаєтеся смердючими справами." }
    t[187373] = "Поножі, що Огортають Душу"
    t[187374] = "Поясний Шнур Балтіра"
    t[187375] = "Зв'язані Мацаки Пожирача Світів"
    t[187376] = "Чоботи Лейтенанта-Присяжного Утроби"
    t[187377] = "Лапи Малбоґа"
    t[187378] = "Лик Знищувача"
    t[187380] = "Пояс зі Шкіри Пожирача"
    t[187381] = "Наручі, Торкнуті Розломом"
    t[187382] = "Кольчуга Винищувача-Присяжного Утроби"
    t[187383] = "Чоботи Тихого Душолова"
    t[187384] = "Лускаті Рукавиці Контроґза"
    t[187385] = "Вихреносний Головний Убір"
    t[187386] = "Поножі, Всаджені Стигійським Кристалом"
    t[187387] = "Наплічники Незвіданого Потойбіччя"
    t[187388] = "Пояс із Колючої Луски"
    t[187389] = "Пута Володаря Тіней"
    t[187390] = "Шолом Підкореного Захисника"
    t[187391] = "Грудна Клітка Ярксгова"
    t[187392] = "Латні Чоботи Велетенського Конструкта"
    t[187393] = { name = "Бездоганні Латні Рукавиці Псаря", fen = "A matching set were made for Helya's trusted Hellhound handlers.", fua = "Пару таких виготовили для довірених псарів пекельних гончаків Гельї." }
    t[187394] = { name = "Поножі Змученого Велетня", fen = "Good thing you have a belt, they are a bit big.", fua = "Добре, що у вас є пояс, вони трохи завеликі." }
    t[187395] = "Зміцнені Стигійські Наплічники"
    t[187396] = "Пояс Мертводуша"
    t[187397] = "Наручі Межисвіту"
    t[187398] = "Нагрудник Тіньової Варти"
    t[187399] = "Наплічники Конструкта Пащі"
    t[187400] = "Оплічник Волаючих Тіней"
    t[187401] = "Перстень Затіненого Розлому"
    t[187402] = "Всепоглинальний Перстень"
    t[187403] = "Плащ Руйнівниці Реліквій"
    t[187404] = "Амулет Картелю Ве"
    t[187405] = "Намисто Прихованого Спостерігача"
    t[187406] = "Перстень Сліпучих Тіней"
    t[187407] = { name = "Торба Безпеки", fen = "A false bag to misdirect intrusive hands.", fua = "Фальшива торба, щоб збити з пантелику настирливі руки." }
    t[187408] = "Замовлення Картелю"
    t[187409] = "Плащ Кортіанського Книжника"
    t[187410] = "Бойова Накидка Поступу Смерті"
    t[187411] = "Оплічник Поступу Смерті"
    t[187412] = "Скалкошкур Ка-Ша"
    t[187416] = { name = "Клітка Тюремника", fen = "The Jailer has a place for you.", fua = "У Тюремника знайдеться місце й для тебе." }
    t[187417] = { name = "Камера Непохитних Склепів", fen = "Accommodations for the Jailer's most prized guests.", fua = "Помешкання для найцінніших гостей Тюремника." }
    t[187419] = { name = "Перше Перо Стюарда", fen = "A small feather, beloved by stewards, that briefly reminds them of their youth.", fua = "Маленьке перо, любе стюардам, що на мить нагадує їм про їхню юність." }
    t[187420] = { name = "Видошукач Пащі", fen = "Just a shadow of the real thing.", fua = "Лише тінь справжнього." }
    t[187421] = { name = "Попеляста Мазь", fen = "A popular sunblock for trips outside the Shadowlands.", fua = "Популярний захист від сонця для мандрівок поза межами Тіньокраю." }
    t[187423] = { name = "Легенда про Анімне Джерело", fen = "Incomplete notes regarding a massive source of anima in Korthia.", fua = "Неповні нотатки щодо величезного джерела аніми в Кортії." }
    t[187424] = { name = "Легенда про Анімне Джерело", fen = "Incomplete notes regarding a massive source of anima in Korthia.", fua = "Неповні нотатки щодо величезного джерела аніми в Кортії." }
    t[187425] = "Прадавнє Озброєння Малдраксі"
    t[187426] = { name = "Легенда про Анімне Джерело", fen = "Incomplete notes regarding a massive source of anima in Korthia.", fua = "Неповні нотатки щодо величезного джерела аніми в Кортії." }
    t[187427] = "Загублений Дзвіночок для Медитації"
    t[187428] = { name = "Легенда про Анімне Джерело", fen = "Incomplete notes regarding a massive source of anima in Korthia.", fua = "Неповні нотатки щодо величезного джерела аніми в Кортії." }
    t[187429] = "Скам'янілі Лісові Роги"
    t[187430] = "Сінвіровий Келих Женця"
    t[187431] = { name = "Спляча Зброя", fen = "Well rested and ready for battle.", fua = "Добре відпочила й готова до бою." }
    t[187432] = "Магофокусна Серцевина"
    t[187433] = "Кришталеві Дзвіночки Вітру"
    t[187434] = "Саджанець Світлосіму"
    t[187436] = { name = "Звіт про Фауну Кортії", fen = "Upon further inspection, the bulk of this report contains a list of what faerie magic works on the local wildlife.", fua = "Придивившись уважніше, ви помічаєте, що більша частина звіту містить перелік того, яка чарівна магія діє на місцеву звірину." }
    t[187437] = { name = "Звіт про Оборону Притулку Хранителя", fen = "A shorthand report detailing the covenants' defensive troop movement around Korthia.", fua = "Стислий звіт, що описує оборонні переміщення військ ковенантів довкола Кортії." }
    t[187438] = { name = "Нотатки Обстеження Аніми", fen = "A technical document full of numbers and acronyms that make little sense to you.", fua = "Технічний документ, сповнений чисел і скорочень, що мало вам про що говорять." }
    t[187439] = { name = "Звіт про Переміщення Присяжних Пащі", fen = "The writing on this enchantment is designed to disappear when read by an enemy.", fua = "Письмо в цьому зачаруванні зроблено так, щоб зникати, коли його читає ворог." }
    t[187440] = { name = "Напханий Пір'ям Шолом", fen = "The helm looks okay if you dump out the feathers.", fua = "Шолом має пристойний вигляд, якщо витрусити з нього пір'я." }
    t[187441] = "Перо Присяжної Утробі Валькіри"
    t[187442] = "Стародавня Торба Книжника"
    t[187443] = "Корок Банки Зі Зразком"
    t[187444] = "Розчавлені Шлундогриби"
    t[187445] = "Інертний Сувій Закляття"
    t[187446] = "Подерті Документи"
    t[187447] = "Уламок Клітки Душі"
    t[187448] = "Скинута Луска Шардгайда"
    t[187449] = "Надщерблене Ікло Лезокрила"
    t[187450] = "Флакон Примарних Сліз"
    t[187451] = "Частини Знаряддя Тортур"
    t[187452] = "Порожня Посудина Душі"
    t[187453] = "Скручений Чорний Ланцюг"
    t[187454] = "Запасні Ланцюги Для Зброї"
    t[187455] = "Шипасті Кайдани"
    t[187456] = "Горнило з Металу Душокузні"
    t[187457] = { name = "Гравірована Скляна Пластина", fen = "Are they runes... or pictures...", fua = "Це руни... чи зображення..." }
    t[187458] = { name = "Викопаний Сигіл Телепортера", fen = "The lines appear to infer connections, maybe with more the Archivist can map the network.", fua = "Лінії, схоже, вказують на зв'язки; можливо, з більшою кількістю Архіваріус зможе скласти карту мережі." }
    t[187459] = { name = "Флакон Таємничої Рідини", fen = "The vial is sealed extremely well, best to let the Archivist risk opening it.", fua = "Флакон запечатано напрочуд міцно, краще лишити ризик відкрити його Архіваріусові." }
    t[187460] = { name = "Дивовижно Хитромудрий Ключ", fen = "Maybe the Archivist will have an equally intricate lock?", fua = "Можливо, в Архіваріуса знайдеться так само хитромудрий замок?" }
    t[187461] = "Викривлений Тавровий Прут"
    t[187462] = { name = "Сувій Байок Тіньокраю", fen = "The script is beautiful, but clearly a language you do not know.", fua = "Письмо прекрасне, та мова, поза сумнівом, вам незнайома." }
    t[187463] = { name = "Загадкові Уламки Карти", fen = "The formations on each piece don't resemble anything you have ever seen.", fua = "Обриси на кожному уламку не схожі ні на що, що ви будь-коли бачили." }
    t[187464] = "Кристалізований Душевний Пил"
    t[187465] = { name = "Складний Гармонізатор Організмів", fen = "Intended to be worn as an armband, you think this might be for the study of hostile fauna.", fua = "Задуманий, щоб носити як наруч; ви припускаєте, що він призначений для вивчення ворожої фауни." }
    t[187466] = { name = "Кортіанська Книга Шифрів", fen = "The pages appear to be translations for hundreds of different languages. The initial key appears to have been left out, possibly only given to the Attendant Scholars.", fua = "Сторінки, схоже, містять переклади сотень різних мов. Початковий ключ, вочевидь, прибрали, можливо, його довірили лише книжникам-прислужникам." }
    t[187467] = { name = "Спантеличливий Рунний Куб", fen = "You spin the cubes mechanism a few times trying to line up the runes, but it seems impossible to line them all up.", fua = "Ви кілька разів обертаєте механізм куба, намагаючись вирівняти руни, але зрівняти їх усі видається неможливим." }
    t[187468] = "Збруя Тіньового Гончака"
    t[187469] = "Наконечники Дротиків Присяжних Утроби"
    t[187470] = { name = "Зламаний Ланцюг Калічника", fen = "A soft blue light still clings to the sharp edges of the shattered ends.", fua = "М'яке блакитне сяйво досі чіпляється за гострі краї розтрощених кінців." }
    t[187471] = "Великий Зуб Скалкошкура"
    t[187472] = "Скинута Луска Бритвокрила"
    t[187473] = "Відрубана Кінцівка Громіта"
    t[187474] = "Подряпана Пряжка Присяжного Пащі"
    t[187475] = "Хребтоплавий Скалкошкур"
    t[187476] = { name = "Потертий Щоденник", fen = "An old journal, water-stained and illegible.", fua = "Старий щоденник, замочений водою і нечитабельний." }
    t[187477] = "Пожовані Накази Присяжних Пащі"
    t[187478] = { name = "Білий Кіготь Лезокрила", fen = "The Korthians claim that there's a very rare chance for the Razorwing to grow a talon with an ivory complexion.", fua = "Кортіанці запевняють, що вкрай рідко в лезокрила виростає кіготь кольору слонової кістки." }
    t[187479] = "Підстилка зі Смужок Кори"
    t[187480] = "Обпалена Енергією Гілка"
    t[187481] = "Ціла Грудна Клітка Гострокрила"
    t[187482] = "Подерта Пащеприсяжна Туніка"
    t[187483] = "Закривавлене Перо Лезокрила"
    t[187484] = "Позолочена Кортіанська Прикраса"
    t[187485] = "Деталі Кам'яного Телепортера"
    t[187486] = "Призматичні Скляні Піраміди"
    t[187487] = { name = "Стародавній Визначник Реліквій", fen = "Once used to catalog and identify relics. However, this one's power source looks to be dormant.", fua = "Колись слугував для опису та визначення реліквій. Утім, джерело його сили, здається, спить." }
    t[187488] = "Спорожнена Чорнильниця"
    t[187489] = "Скло Банки Зі Зразком"
    t[187490] = "Цілий Утробогриб"
    t[187491] = "Капелюшок Утробогриба"
    t[187492] = "Ніжка Утробогриба"
    t[187493] = "Їдкий Залишок Пащогриба"
    t[187495] = { name = "Золотий Філігранний Пензлик", fen = "Brushes were only viewed in a utilitarian light until the attendants encountered mortals.", fua = "Пензлі вважалися суто ужитковими речами, доки прислужники не зустріли смертних." }
    t[187496] = { name = "Краї Тіньокраю", fen = "A hand copied book outlining the unique history of the Shadowlands.", fua = "Переписана від руки книга, що змальовує неповторну історію Тіньокраю." }
    t[187497] = { name = "Витончена Фігурка Лезокрила", fen = "Carved out of amber, this piece is exquisitely detailed.", fua = "Вирізьблена з бурштину, ця статуетка опрацьована з вишуканою точністю." }
    t[187498] = { name = "Вишукано Вишитий Мішечок", fen = "Made of a luxurious cloth, it is not clear who crafted the pouch, but the few remaining Attendant Scholar's have them.", fua = "Виготовлений з розкішної тканини; невідомо, хто пошив цей мішечок, але нечисленні вцілілі книжники-прислужники мають такі." }
    t[187499] = { name = "Різьблена Елетієва Сфера", fen = "Some portions of the orb resemble the terrain of some of the Shadowlands realms you have visited, while others are completely unknown to you.", fua = "Деякі частини сфери нагадують ландшафти царств Тіньокраю, які ви відвідали, тоді як інші вам зовсім незнайомі." }
    t[187500] = { name = "Майстерно Витравлений Ніж для Листів", fen = "Rarely used on envelopes the attendants tell you it is used when unsealing cataloged journals.", fua = "Прислужники кажуть, що його рідко застосовують для конвертів, а радше для розпечатування каталогізованих щоденників." }
    t[187501] = { name = "Осягнення Призначення", fen = "A guide that repetitiously touches on the unwavering commitment to the broad concept of the Purpose.", fua = "Посібник, що раз за разом наголошує на непохитній відданості широкому поняттю Призначення." }
    t[187503] = { name = "Згорток Заархівованих Досліджень", fen = "Contains 500 Cataloged Research.", fua = "Містить 500 каталогізованих досліджень." }
    t[187504] = { name = "Відновлювальний Пристрій Міканікоса", fen = "Created by the greatest minds in Bastion, this contraption should allow for the healing of Kyrian, Stoneborn, Night Fae, and Maldraxxi.", fua = "Створений найвидатнішими умами Бастіону, цей пристрій має зцілювати кіріанів, каменероджених, нічних фей та малдраксійців." }
    t[187506] = "Згущена Сфера Аніми"
    t[187507] = "Уламок Адаптивної Броні"
    t[187508] = { name = "Переноска для Навченого Громіта", fen = "Its strong nose finds everything.", fua = "Його чутливий ніс знаходить усе." }
    t[187511] = "Спогад про Елізійську Могутність"
    t[187512] = { name = "Фоліант Дрібних Гріхів", fen = "A ritual tome detailing venthyr methods of absolving the sins of the smallest of creatures.", fua = "Ритуальний фоліант, що описує способи вентирів відпускати гріхи найдрібніших створінь." }
    t[187515] = "Бездонний Чайник Теотара"
    t[187516] = { name = "Ковальський Кран Фіріма", fen = "One of many ancient devices found discarded in Zereth Mortis.", fua = "Один з багатьох прадавніх пристроїв, кинутих напризволяще в Зерет-Мортісі." }
    t[187517] = { name = "Призма Анімоплину", fen = "The hidden treasure of legend", fua = "Прихований скарб з легенд" }
    t[187523] = { name = "Your Reward [DNT]", fen = "This is a bug. You should not have touched this. IT'S PROBABLY CURSED!", fua = "Це баг. Тобі не варто було цього торкатися. ВОНО, МАБУТЬ, ПРОКЛЯТЕ!" }
    t[187525] = { name = "Душескручений Смертохід", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187526] = { name = "Підозрілий Список", fen = "Perhaps someone would be interested in this?", fua = "Можливо, когось це зацікавить?" }
    t[187528] = "Бездоганне Ядро Автома"
    t[187529] = { name = "Скалка Філактерії", fen = "A shard taken from Kel'Thuzad's shattered phylactery in the Sanctum of Domination on Normal Difficulty.", fua = "Скалка з розбитої філактерії Кел'Тузада, здобута в Святилищі Панування на Звичайній складності." }
    t[187530] = { name = "Скалка Філактерії", fen = "A shard taken from Kel'Thuzad's shattered phylactery in the Sanctum of Domination on Heroic Difficulty.", fua = "Скалка з розтрощеного філактерія Кел'Тузада у Святилищі Панування на героїчній складності." }
    t[187531] = { name = "Скалка Філактерії", fen = "A shard taken from Kel'Thuzad's shattered phylactery in the Sanctum of Domination on Mythic Difficulty.", fua = "Скалка з розтрощеного філактерія Кел'Тузада у Святилищі Панування на міфічній складності." }
    t[187532] = "Долото Душевного Вогню"
    t[187533] = "Велика Фіала Безтурботності"
    t[187534] = "Пояс із Кристала Кортіту"
    t[187535] = "Поясний Шнур Книжника-Прислужника"
    t[187536] = "Рукавиці Прототипа-Вартового"
    t[187537] = "Витончені Маніпулятори Смертності"
    t[187538] = "Рукавички Навальної Смерті"
    t[187539] = "Латні Рукавиці Вартового Смерті"
    t[187540] = "Пас Огортальної Смерті"
    t[187541] = "Ланцюг Облягаючої Смерті"
    t[187542] = "Джейтіс, Тюремний Клинок"
    t[187543] = { name = "Військова Скриня Поступу Смерті", fen = "Contains the wealth and armor scavenged by our forces in the defense of Korthia as well as a symbol of your dedication to the realms of Shadowlands.", fua = "Містить багатства та обладунки, здобуті нашими військами при обороні Кортії, а також символ вашої відданості царствам Тіньокраю." }
    t[187544] = "Поглинута Сутність Зброї"
    t[187545] = "Поглинута Сутність Зброї"
    t[187546] = "Поглинута Сутність Зброї"
    t[187547] = "Поглинута Сутність Зброї"
    t[187548] = "Поглинута Сутність Зброї"
    t[187550] = { name = "Тіньосталеві Стружки", fen = "Delicious. Well balanced. My compliments to the blacksmith.", fua = "Смакота. Добре збалансовані. Мої компліменти ковалю." }
    t[187551] = { name = "Мала Кортіанська Скриня Припасів", fen = "Contains profession materials, gold and Korthite Crystal.", fua = "Містить матеріали для ремесел, золото та кортитовий кристал." }
    t[187552] = "Бездоганно Підроблені Документи"
    t[187553] = { name = "Орбореальні Стружки", fen = "Very rich with magic. Great flavor. I wouldn't mind another...", fua = "Дуже насичені магією. Чудовий смак. Я б не відмовився ще..." }
    t[187554] = { name = "Елетієві Крихти", fen = "Not particularly filling, but perfect for an afternoon battle.", fua = "Не надто ситні, але ідеальні для пообідньої сутички." }
    t[187555] = { name = "Безнадійний Мотлох", fen = "A waste of steel. Tasteless. It shouldn't have been made.", fua = "Марнування сталі. Несмак. Цьому взагалі не варто було поставати." }
    t[187569] = { name = "Частка Підсилення Кравецтва Посередників", fen = "Contains a large assortment of Shadowlands cloth of all qualities.", fua = "Містить велику добірку тканини Тіньокраю всіх рівнів якості." }
    t[187570] = { name = "Частка Підсилення Білування Посередників", fen = "Contains a large assortment of Shadowlands skins of all qualities.", fua = "Містить велику добірку шкур Тіньокраю всіх рівнів якості." }
    t[187571] = { name = "Частка Підсилення Гірництва Посередників", fen = "Contains a large assortment of Shadowlands ore of all qualities.", fua = "Містить велику добірку руди Тіньокраю всіх рівнів якості." }
    t[187572] = { name = "Частка Підсилення Травництва Посередників", fen = "Contains a large assortment of Shadowlands herbs of all qualities.", fua = "Містить велику добірку трав Тіньокраю всіх рівнів якості." }
    t[187573] = { name = "Частка Підсилення Чаротворства Посередників", fen = "Contains a large assortment of Shadowlands enchanting materials of all qualities.", fua = "Містить велику добірку матеріалів для чаротворства Тіньокраю всіх рівнів якості." }
    t[187574] = { name = "Переповнене Відро Посередників", fen = "Contains an assortment of Shadowlands meat or fish of all qualities.", fua = "Містить добірку м'яса чи риби Тіньокраю всіх рівнів якості." }
    t[187575] = { name = "Кортіанська Рибальська Схованка", fen = "Contains an assortment of Shadowlands fish of all qualities.", fua = "Містить добірку риби Тіньокраю всіх рівнів якості." }
    t[187576] = { name = "Кортіанська Схованка для Білування", fen = "Contains a large assortment of Shadowlands skins of all qualities.", fua = "Містить велику добірку шкур Тіньокраю всіх рівнів якості." }
    t[187577] = { name = "Кортіанська Схованка з М'ясом", fen = "Contains an assortment of Shadowlands meat of all qualities.", fua = "Містить добірку м'яса Тіньокраю всіх рівнів якості." }
    t[187591] = "Пильність Вартового Народжених Ніччю"
    t[187592] = "Жила Примарного Вогника"
    t[187593] = "Ефірне Оперення"
    t[187594] = { name = "Альманах П'уга", fen = "A trusted schedule of astronomical and meteorological forecasts.", fua = "Надійний збірник астрономічних і метеорологічних прогнозів." }
    t[187595] = { name = "Прихильність Гіпогрифа Вал'шари", fen = "Teaches you how to summon a Val'sharah Hippogryph. This is a flying mount.", fua = "Навчає прикликати гіпогрифа Вал'шари. Це летючий їздовий звір." }
    t[187596] = { name = "Постачання М'яса із Розколотих Островів", fen = "A shipment of meat from Dalaran. Nomi sends his greetings.", fua = "Партія м'яса з Даларану. Номі передає вітання." }
    t[187597] = { name = "Постачання Риби із Розколотих Островів", fen = "A shipment of fish from Dalaran, sent with Marcia Chase's blessings.", fua = "Партія риби з Даларану, надіслана з благословенням Марсії Чейз." }
    t[187598] = { name = "Постачання Тканини із Розколотих Островів", fen = "A shipment of cloth from Dalaran, thanks to Tanithria.", fua = "Партія тканини з Даларану, завдяки Таніфрії." }
    t[187599] = { name = "Постачання Трав із Розколотих Островів", fen = "A shipment of tenderly harvested herbs from Kuhuine Tenderstride in Dalaran.", fua = "Партія дбайливо зібраних трав від Кугуїни Ніжний Крок з Даларану." }
    t[187600] = { name = "Постачання Руди із Розколотих Островів", fen = "A shipment of ore packed specially by Mama Diggs.", fua = "Партія руди, особисто упакована Мамою Діґз." }
    t[187601] = { name = "Постачання Шкіри із Розколотих Островів", fen = "A shipment of skins and scales selected by Kondal Huntsworn of Dalaran.", fua = "Партія шкур і луски, відібрана Кондалом Мисливцем-за-Присягою з Даларану." }
    t[187602] = { name = "Мотиватор Фіріма", fen = "A mysterious device that influences Automa's actions.", fua = "Загадковий пристрій, що впливає на дії автоми." }
    t[187603] = "Чай Божевільного Герцога"
    t[187604] = { name = "Постачання Чарів із Розколотих Островів", fen = "A shipment of enchanting supplies from Dalaran's very own enchanting supplier Ildine Sorrowspear.", fua = "Партія припасів для чаротворства від власної даларанської постачальниці Ільдіни Скорботний Спис." }
    t[187605] = { name = "Постачання Самоцвітів із Розколотих Островів", fen = "A shipment of gems from Dalaran, courtesy of Tiffany Cartier.", fua = "Партія самоцвітів з Даларану, люб'язно надана Тіффані Картьє." }
    t[187611] = "Шепітливий Кристал Полум'я Скверни"
    t[187612] = { name = "Ключ Текучих Вод", fen = "The bow of this key is worn beyond recognition, weathered in the treacherous waters once present in the Estuary of Awakening.", fua = "Голівка цього ключа стерта до невпізнання, виточена підступними водами, що колись були в Лимані Пробудження." }
    t[187613] = { name = "Ключ Внутрішніх Покоїв", fen = "The insignia atop the head of this key suggests it belongs to something near the great vaults.", fua = "Відзнака на голівці цього ключа свідчить, що він належить чомусь поблизу великих сховищ." }
    t[187614] = { name = "Ключ Багатьох Думок", fen = "The hand-scorched sigils along the side of the key may unlock the mysteries of relics within the Seeker's Quorum.", fua = "Випалені рукою сигіли вздовж ключа можуть відімкнути таємниці реліквій у Кворумі Шукача." }
    t[187615] = { name = "Уламок Сфери", fen = "Covered in claw and teeth marks.", fua = "Укритий слідами кігтів і зубів." }
    t[187618] = { name = "Контур Об'єкта Оет", fen = "Though its workings are unclear, this device is used by the Automa to gain entrance to Site Oeth.", fua = "Хоча принцип його дії незрозумілий, цей пристрій автома використовують для проходу на Об'єкт Оет." }
    t[187619] = { name = "Звивисте Зерно", fen = "Vines curl around the internals, moving and pulsing with life.", fua = "Лози обвивають його нутрощі, рухаючись і пульсуючи життям." }
    t[187620] = { name = "Звивисте Зерно", fen = "Metal gears and living vines, fused together.", fua = "Металеві шестерні й живі лози, сплавлені воєдино." }
    t[187626] = { name = "Підозрілі Папери", fen = "These scraps of paper have strange scribblings on them, almost certainly a code.", fua = "На цих клаптях паперу дивні карлючки, майже напевно якийсь код." }
    t[187628] = { name = "Матриця Відновлення", fen = "An instrument of significant power for the automa. However, this device is severely depleted.", fua = "Знаряддя неабиякої сили для автома. Проте цей пристрій майже повністю вичерпаний." }
    t[187629] = { name = "Камінь Серцесвітла", fen = "Teaches you how to summon a Heartlight Vombata mount.", fua = "Навчає прикликати вомбату серцесвітла як їздового звіра." }
    t[187630] = { name = "Допитливий Кристалонюх", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187631] = { name = "Затемнений Вомбата", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187632] = { name = "Оздоблений Вомбата", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187633] = { name = "Решітка Буфоніда", fen = "A mystical lattice used to synthesize an bufonid.", fua = "Містична решітка, що використовується для синтезу буфоніда." }
    t[187634] = { name = "Решітка Амбістана", fen = "A mystical lattice used to synthesize an ambystan.", fua = "Містична решітка, що використовується для синтезу амбістана." }
    t[187635] = { name = "Решітка Оленя", fen = "A mystical lattice used to synthesize a cervid.", fua = "Містична решітка, що використовується для синтезу оленя." }
    t[187636] = { name = "Решітка Аураліда", fen = "A mystical lattice used to synthesize an aurelid.", fua = "Містична решітка, що використовується для синтезу аураліда." }
    t[187638] = { name = "Смертобіг", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187639] = { name = "Блідий Величний Цервід", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187640] = { name = "Повіддя Освяченого Протооленя", fen = "Teaches you how to summon an Anointed Protostag mount.", fua = "Навчає прикликати освяченого протооленя як їздового звіра." }
    t[187641] = { name = "Повіддя Розколотого Зерет-Скакуна", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187642] = { name = "Лютий Бойовий Переслідувач", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187644] = { name = "Лютий Бойовий Переслідувач", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187648] = "Порожній Казан з-під Кам'яного Супу"
    t[187660] = { name = "Веспоїдна Тріпотушка", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187662] = { name = "Дивна Слиз", fen = "The aurelids of Zereth Mortis seem attracted to this substance, but it resists attachment to any lure. Someone more familiar with deep sea creatures may know what to do with it.", fua = "Аураліди Зерет-Мортісу немовби тягнуться до цієї речовини, проте її неможливо причепити до жодної принади. Хтось досвідченіший у глибоководних створіннях може знати, що з нею робити." }
    t[187663] = { name = "Бронзокрилий Веспоїд", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187664] = { name = "Викуваний Злолетун", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187665] = { name = "Дзум", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187666] = { name = "Мисливець Пустельнокрил", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187667] = { name = "Пащепристосований Раптора", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187668] = { name = "Стрімкокрилий Раптора", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187669] = { name = "Серенада", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187670] = { name = "Бронзовий Гелікід", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187671] = { name = "Невдалий Прототип Прудкопода", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187672] = { name = "Багряний Гелікід", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187673] = { name = "Загадковий Ауралід", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187675] = { name = "Мерехтливий Ауралід", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187676] = { name = "Глибинозоряний Поліп", fen = "Teaches you how to summon a Deepstar Aurelid.", fua = "Навчає прикликати глибинозоряного аураліда." }
    t[187677] = { name = "Повзун Генези", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187678] = { name = "Тарахнідний Повзун", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187679] = { name = "Невимовна Дряпачка", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187680] = { name = "Лютий Бойовий Квакун", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187681] = { name = "Лютий Бойовий Квакун", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187682] = { name = "Спустошений Смертохід", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187683] = { name = "Золотопанцирний Буфонід", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[187684] = { name = "Стримувальна Пастка", fen = "Keeps researchers safe and unharmed.", fua = "Тримає дослідників у безпеці й неушкодженими." }
    t[187685] = { name = "Уламок Чорної Сталі", fen = "The Jailer's magic emanates from this chunk of steel...", fua = "Від цього шматка сталі струмує магія Тюремника..." }
    t[187686] = { name = "[DNT] Suspicious Badge", fen = "A small bloodstained badge that says \"Hi! My name is....\" The name has rubbed off.", fua = "Маленька закривавлена відзнака з написом «Привіт! Мене звати...». Ім'я стерлося." }
    t[187688] = { name = "[DNT] Rinanji's Key", fen = "A key inscribed with the name \"Rinanji.\"", fua = "Ключ із вигравіруваним іменем «Рінанджі»." }
    t[187696] = { name = "Вовк, Вольпертінґер та Інші Хвостаті Історії", fen = "A well-worn collection of poetry, bound in gold thread.", fua = "Зачитана збірка поезії, оправлена золотою ниткою." }
    t[187699] = { name = "Перша Квітка", fen = "This rare and beautiful flower prototype thrives in deadly locations within the land of the First Ones.", fua = "Цей рідкісний і прекрасний прототип квітки квітне в смертельних місцях у землі Перших." }
    t[187700] = { name = "Прогенієва Руда", fen = "Can be mined from deposits and elementals found in the most rugged and dangerous areas of Zereth Mortis.", fua = "Видобувається з покладів та елементалів у найсуворіших і найнебезпечніших куточках Зерет-Мортісу." }
    t[187701] = { name = "Протогенна Шкура", fen = "Players with the skinning skill can gather these rare hides from the strongest creatures inhabiting Zereth Mortis.", fua = "Гравці з умінням Білування можуть здобувати ці рідкісні шкури з найсильніших створінь, що населяють Зерет-Мортіс." }
    t[187702] = { name = "Панцирна Риба-Предтеча", fen = "This enigmatic fish only surfaces occasionally to feed in groups, making it rare to catch outside of these circumstances.", fua = "Ця загадкова риба лише зрідка спливає на поверхню, щоб годуватися зграями, тож зловити її в інший час дуже важко." }
    t[187703] = { name = "Шовкове Протоволокно", fen = "Produced by some of the more powerful worms and spiders within Zereth Mortis, it is used by players with the Tailoring skill.", fua = "Виробляється деякими з наймогутніших червів і павуків Зерет-Мортіса й використовується гравцями з умінням Кравецтва." }
    t[187704] = "Протоплоть"
    t[187705] = "Поклик Чуфи"
    t[187706] = "Трактат: Узи Стигії у Смертних"
    t[187707] = { name = "Есенція Прародичів", fen = "An extraordinarily rare remnant of the Progenitors which can be used to craft powerful enhancements.\n\n\n\nCan be bought and sold on the auction house.", fua = "Надзвичайно рідкісний уламок спадку Прародичів, з якого можна виготовляти могутні поліпшення.\n\n\n\nМожна купувати й продавати на Аукціоні." }
    t[187708] = { name = "Зламаний Шолом", fen = "The shattered half of the Helm of Domination.", fua = "Розколота половина Шолома Панування." }
    t[187711] = { name = "Цяцьки Маклерів", fen = "Odd bits of metal and magic. Perhaps they still serve a purpose, perhaps they don't.", fua = "Дивні шматочки металу й магії. Можливо, вони ще на щось придатні, а можливо, й ні." }
    t[187712] = "Принада на Прадавнього Панцирника"
    t[187728] = { name = "Нитки Ефемери", fen = "An essential building block to creating everything.", fua = "Невід'ємний будівельний елемент для творення всього сущого." }
    t[187730] = { name = "Залишок Провідності", fen = "A stream of energy pulses through this object, seemingly directed at nowhere.", fua = "Крізь цей предмет пульсує потік енергії, спрямований, здається, у нікуди." }
    t[187731] = { name = "Залишок Провідності", fen = "A stream of energy pulses through this object, seemingly directed at nowhere.", fua = "Крізь цей предмет пульсує потік енергії, спрямований, здається, у нікуди." }
    t[187732] = { name = "Залишок Провідності", fen = "A stream of energy pulses through this object, seemingly directed at nowhere.", fua = "Крізь цей предмет пульсує потік енергії, спрямований, здається, у нікуди." }
    t[187735] = { name = "Джорді", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[187736] = { name = "Викривач", fen = "This odd contraption seems to be made up of various old broker devices thrown together.", fua = "Цей дивний пристрій, схоже, зібрано з різних старих знарядь маклерів, абияк докупи." }
    t[187741] = "Знак Ремісника IV"
    t[187742] = "Знак Ремісника Перших"
    t[187749] = "Рецепт: Знак Ремісника Перших"
    t[187750] = "Рецепт: Знак Ремісника IV"
    t[187779] = { name = "Малий Енігмет", fen = "An energized particle used as a catalyst in the creation process.", fua = "Заряджена частинка, що використовується як каталізатор у процесі творення." }
    t[187780] = "Припаси Просвітленого Посередника"
    t[187781] = { name = "Схованка Олеа", fen = "The jiro of Circle Olea are happy to reward those who continue to recover cyphers beyond Firim's ability to research.", fua = "Джиро Кола Олеа радо винагороджують тих, хто й далі добуває шифри, що їх Фірим не здатен дослідити." }
    t[187782] = { name = "Ейдолічний Уламок", fen = "A stabilizing material used as the foundation of larger creations.", fua = "Стабілізуючий матеріал, що слугує основою для більших витворів." }
    t[187784] = "Залишок Вічного"
    t[187785] = "Фоліант Вічних"
    t[187787] = { name = "Сфера Ефемери", fen = "An orb of pure anima protecting unknown contents.", fua = "Сфера чистої аніми, що оберігає невідомий вміст." }
    t[187789] = { name = "Ейдолічні Частинки", fen = "A rare particle of creation.", fua = "Рідкісна частинка творення." }
    t[187790] = { name = "Слідовий Енігмет", fen = "An energized particle used as a catalyst in the creation process.", fua = "Заряджена частинка, що використовується як каталізатор у процесі творення." }
    t[187793] = { name = "Особиста Утримувальна Пастка", fen = "Become the subject of scrutiny.", fua = "Станьте об'єктом прискіпливої уваги." }
    t[187796] = "Контракт: Просвітлені"
    t[187797] = { name = "Техніка: Контракт: Просвітлені", fen = "Teaches you how to craft a Contract: The Enlightened.", fua = "Навчає вас укладати Контракт: Просвітлені." }
    t[187802] = "Зілля Космічного Зцілення"
    t[187804] = { name = "Рецепт: Порожній Казан Кам'яного Супу", fen = "Teaches you how to craft an Empty Kettle of Stone Soup", fua = "Навчає вас виготовляти Порожній Казан Кам'яного Супу." }
    t[187805] = "Руна Вантуса: Гробниця Перших"
    t[187806] = { name = "Техніка Руни Вантуса: Гробниця Першонароджених", fen = "Teaches you how to craft a Vantus Rune: Sepulcher of the First Ones.", fua = "Навчає вас виготовляти Руну Вантуса: Гробниця Першонароджених." }
    t[187808] = { name = "Пропускне Гасло", fen = "Required to access the Vessel.", fua = "Потрібне для доступу до Посудини." }
    t[187811] = { name = "Примарний Корм", fen = "The ethereal nutrition shimmers in your grasp.", fua = "Ефірний харч мерехтить у вашій руці." }
    t[187812] = "Порожній Казан"
    t[187813] = "Куряча Душа"
    t[187816] = { name = "Спокусливий Слиз", fen = "Certainly edible. To something.", fua = "Звісно, їстівний. Для чогось." }
    t[187817] = { name = "Жеода Кортитових Кристалів", fen = "Contains 5 Korthite Crystals.", fua = "Містить 5 Кортитових Кристалів." }
    t[187818] = "Душа Видри"
    t[187819] = "Котяча Душа"
    t[187820] = { name = "Грудка Слизу", fen = "Not very appetizing.", fua = "Не надто апетитна." }
    t[187821] = "Рубаюче Лезо Бар-Фусана"
    t[187822] = { name = "Прохання Перебіжчика", fen = "A scroll detailing an arms requisition to support the Maldraxxi defectors operating in Revendreth.", fua = "Сувій з реквізицією зброї на підтримку малдракситських перебіжчиків, що діють у Ревендреті." }
    t[187823] = "Магічно Відрегульоване Ядро Автоми"
    t[187824] = { name = "Формула: Магічно Врегульоване Ядро Автома", fen = "Teaches you how to craft a Magically Regulated Automa Core.", fua = "Навчає вас виготовляти Магічно Врегульоване Ядро Автома." }
    t[187825] = "Космічне Прототкання"
    t[187826] = { name = "Формула: Космічне Протоплетиво", fen = "Teaches you how to craft a Cosmic Protoweave.", fua = "Навчає вас виготовляти Космічне Протоплетиво." }
    t[187827] = "Інфузія: Очищення Трупа"
    t[187828] = { name = "Рецепт: Настій: Очищення Трупа", fen = "Teaches you how to craft an Infusion: Corpse Purification.", fua = "Навчає вас готувати Настій: Очищення Трупа." }
    t[187829] = "Аеалічний Камінь Гармонізації"
    t[187830] = { name = "Креслення: Еалічний Гармонізаційний Камінь", fen = "Teaches you how to craft an Aealic Harmonizing Stone.", fua = "Навчає вас виготовляти Еалічний Гармонізаційний Камінь." }
    t[187831] = "Розширення Вітрил Чистого Повітря"
    t[187832] = { name = "Креслення: Чистоповітряні Подовжувачі Вітрил", fen = "Teaches you how to craft the Pure-Air Sail Extensions.", fua = "Навчає вас виготовляти Чистоповітряні Подовжувачі Вітрил." }
    t[187833] = "Чепурний Покопок"
    t[187834] = "Стражденний Прапор Спритних"
    t[187835] = { name = "Реплікуюча Сутність", fen = "More of a disease than a gift, replicating rapidly until it kills the host.", fua = "Радше хвороба, ніж дар: швидко розмножується, поки не вб'є носія." }
    t[187836] = "Хаотична Матриця Генезису"
    t[187837] = { name = "Креслення: Хитка Матриця Генези", fen = "Teaches you how to craft Progenitor Circuitry.", fua = "Навчає вас виготовляти Схеми Прародичів." }
    t[187840] = "Блискотливі Крила"
    t[187841] = { name = "Вибухове Ядро", fen = "Feels rather unstable.", fua = "Здається доволі нестабільним." }
    t[187842] = "Інертна Прогенієва Руда"
    t[187844] = "Цілий Резонатор Захисника Автоми"
    t[187847] = { name = "Креслення: Камінь Сутності Пожирача", fen = "Teaches you how to craft a Devourer Essence Stone.", fua = "Навчає вас виготовляти Камінь Сутності Пожирача." }
    t[187848] = { name = "Рецепт: Зміцнювальна Полірувальна Паста для Обладунків", fen = "Teaches you how to concoct Sustaining Armor Polish.", fua = "Навчає вас готувати Зміцнювальну Полірувальну Пасту для Обладунків." }
    t[187849] = "Камінь Сутності Пожирача"
    t[187850] = "Зміцнювальна Поліроль для Броні"
    t[187852] = { name = "Стос Зброї", fen = "Crate of staves and mana crystals.", fua = "Ящик з посохами та кристалами мани." }
    t[187853] = { name = "Ящик Бойових Лусок", fen = "Crate of dracthyr armor.", fua = "Ящик з обладунками драктирів." }
    t[187858] = "Душа Кролика"
    t[187859] = "Душа Пацюка"
    t[187860] = { name = "Сфера Мортіса", fen = "A method of travel, as slow as time itself.", fua = "Спосіб пересування, повільний, як сам час." }
    t[187862] = "Душа Змії"
    t[187863] = { name = "Ключ Ефемери", fen = "This key is phasing in and out of existence. It is difficult to discern its details... or whether it's even real.", fua = "Цей ключ то з'являється, то зникає з буття. Важко розгледіти його деталі... чи навіть те, чи він узагалі справжній." }
    t[187870] = "Душа Дикобраза"
    t[187871] = "Душа Цвіркуна"
    t[187873] = "Душа Лучного Собачки"
    t[187876] = "Душа Маляти Сауроліска"
    t[187877] = "Душа Жаби"
    t[187878] = "Душа Саврида"
    t[187879] = { name = "Запилена Витяжка", fen = "A rare proto-material", fua = "Рідкісний протоматеріал." }
    t[187880] = "Душа Кози"
    t[187881] = "Душа Барана"
    t[187882] = "Душа Альпаки"
    t[187884] = "Знак Присмеркового Рунооленя"
    t[187885] = { name = "Стільниковий Каркас", fen = "A rare proto-material", fua = "Рідкісний протоматеріал." }
    t[187886] = { name = "Техніка: Знак Сутінкового Ловця-Жахокажана", fen = "Teaches you how to craft a Mark of the Gloomstalker Dredbat.", fua = "Навчає вас виготовляти Знак Сутінкового Ловця-Жахокажана." }
    t[187887] = "Знак Жахокажана-Мряколова"
    t[187888] = "Знак Мерехтливого Арденського Метелика"
    t[187889] = { name = "Нестабільний Збудник", fen = "A rare proto-material", fua = "Рідкісний протоматеріал." }
    t[187890] = { name = "Заряджений Анімою Жовток", fen = "A rare proto-material", fua = "Рідкісний протоматеріал." }
    t[187891] = { name = "Небесна Сутність", fen = "A rare proto-material", fua = "Рідкісний протоматеріал." }
    t[187892] = { name = "Безтілесний Пісок", fen = "A rare proto-material", fua = "Рідкісний протоматеріал." }
    t[187893] = { name = "Летючий Предтеча", fen = "A rare proto-material", fua = "Рідкісний протоматеріал." }
    t[187894] = { name = "Заряджений Небосхил", fen = "A rare proto-material", fua = "Рідкісний протоматеріал." }
    t[187901] = "Душа Орла"
    t[187902] = "Душа Спорокрила"
    t[187903] = "Душа Йормунгара"
    t[187904] = "Душа Хмарного Змія"
    t[187905] = "Душа Вепра"
    t[187906] = "Душа Сови"
    t[187908] = { name = "Запасний Ковальський Відвід Фіріма", fen = "A less stable version of Firm's Forge-Tap.", fua = "Менш стабільна версія Ковальського Відводу Фіріма." }
    t[187909] = { name = "Нестабільна Утримувальна Пастка", fen = "A less stable version of the Containment Trap.", fua = "Менш стабільна версія Утримувальної Пастки." }
    t[187911] = "Темна «Юшка»"
    t[187913] = "Чоботи Учня Слизомага"
    t[187915] = { name = "Смердючий Риба-Крапля", fen = "Smells as awful as it looks.", fua = "Смердить так само бридко, як і виглядає." }
    t[187916] = { name = "Лоза Хапкої Спіралі", fen = "This vine shifts continuously, as if clutching for something it can never reach.", fua = "Ця лоза безперервно звивається, наче тягнеться до чогось недосяжного." }
    t[187917] = "Чай Божевільного Герцога"
    t[187920] = "Слизькоплавець"
    t[187922] = { name = "Слизькоплавець", fen = "Even while deceased, it desires to slip from your fingers once more.", fua = "Навіть мертвим він прагне знову вислизнути вам з рук." }
    t[187923] = { name = "Принада на Ауреліда", fen = "Attracts jellyfish and related creatures.", fua = "Приваблює медуз і подібних до них створінь." }
    t[187925] = { name = "Вічна Вода", fen = "Brimming with strange energy. Is it safe...?", fua = "Вирує дивною енергією. Чи це безпечно...?" }
    t[187930] = { name = "Техніка: Знак Величного Жахокажана", fen = "Teaches you how to craft a Mark of the Regal Dredbat.", fua = "Навчає вас виготовляти Знак Величного Жахокажана." }
    t[187931] = "Знак Величного Жахокажана"
    t[187933] = "Знак Ворона-Сутінькрила"
    t[187934] = "Знак Опівнічного Рунооленя"
    t[187936] = "Знак Чорного Арденського Метелика"
    t[187940] = { name = "Колба для Компонентів", fen = "A container used to hold materials while conducting experiments.", fua = "Посудина для зберігання матеріалів під час дослідів." }
    t[187941] = "Виснажене Ядро Автоми"
    t[187942] = { name = "Хроматичний Розид", fen = "Vibrant flowers with a strange aroma.", fua = "Яскраві квіти з дивним ароматом." }
    t[187943] = { name = "Сітка Фей", fen = "For use in capturing a Veil Flitter moth", fua = "Для лову молі Серпанкокрила." }
    t[187944] = "Релікт Прабатьків"
    t[187949] = "Каталізоване Яблуко"
    t[187950] = { name = "Спотворена Плоть", fen = "Definitely not white meat.", fua = "Точно не біле м'ясо." }
    t[187957] = "Зашифрований Прапор Спритних"
    t[187958] = "Оповитий Прапор Спритних"
    t[187959] = "PH - Banner of the Opportune"
    t[187996] = "Священна Реліквія"
    t[187999] = "Портал Риболовлі"
    t[188000] = { name = "Клунок Доглядача Гаю", fen = "A cache of anima rich seeds.", fua = "Схованка з насінням, багатим на аніму." }
    t[188002] = { name = "Зламаний Шолом", fen = "The shattered half of the Helm of Domination.", fua = "Розколота половина Шолома Панування." }
    t[188003] = { name = "Ящик Добірного Ревендретського Вина", fen = "The bottles represent some of Denathrius' oldest refined anima blend.", fua = "Ці пляшки містять одну з найстаріших витончених сумішей аніми Денатрія." }
    t[188004] = { name = "Ящик Просочених Анімою Частин", fen = "Soaked in Anima for the highest quality of abomination.", fua = "Вимочені в анімі задля бридоти найвищого ґатунку." }
    t[188005] = { name = "Скупана в Анімі Клинок", fen = "A masterwork of the Forgelites.", fua = "Витвір майстрів-ковалів." }
    t[188006] = "Хоральні Шати"
    t[188007] = "Хоральні Капці"
    t[188008] = "Хорові Намотки на Руки"
    t[188009] = "Хоральний Каптур"
    t[188010] = "Хорові Поножі"
    t[188011] = "Хоральний Пояс"
    t[188012] = "Хоральні Намотки"
    t[188013] = "Чоботи Стакато"
    t[188014] = "Рукавиці Стакато"
    t[188015] = "Шолом Стакато"
    t[188016] = "Поножі Стакато"
    t[188017] = "Пояс Стакато"
    t[188018] = "Наручі Стакато"
    t[188019] = "Гімнічна Кіраса"
    t[188020] = "Гімнічні Поножі"
    t[188021] = "Гімнічні Латні Рукавиці"
    t[188022] = "Гімнічний Каптур"
    t[188023] = "Урочисті Поножі"
    t[188024] = "Гімнічні Наплічники"
    t[188025] = "Гімнічний Кольчужний Пояс"
    t[188026] = "Гімнічні Наручі"
    t[188027] = "Гармоніумний Шолом"
    t[188028] = "Гармоніумний Нагрудник"
    t[188029] = "Гармоніумні Ударні Чоботи"
    t[188030] = "Гармоніумні Латні Рукавиці"
    t[188031] = "Гармонійні Латні Поножі"
    t[188032] = "Гармоніумні Наплічники"
    t[188033] = "Гармоніумний Пояс"
    t[188034] = "Гармоніумні Наручі"
    t[188035] = "Жилет Стакато"
    t[188036] = "Оплічник Стакато"
    t[188037] = "Хоровий Амікт"
    t[188038] = "Щит Вартового Притулку"
    t[188039] = "Гармонійний Привід"
    t[188040] = "Полірований Арбалет"
    t[188041] = "Позачасовий Чароклинок"
    t[188042] = "Кинджал Просвітлених"
    t[188043] = "Знищувачка Вічної Варти"
    t[188044] = "Викинутий Перстень-Печатка Картелю Ал"
    t[188045] = "Врятований Зміїний Перстень"
    t[188046] = "Булава Вартового Притулку"
    t[188047] = "Кий Вартового Притулку"
    t[188048] = "Посох Шукача Істини"
    t[188049] = "Трансцендентний Молоток"
    t[188050] = "Незбагненний Шпиль"
    t[188051] = "Бойова Глефа Брамного Стража"
    t[188053] = "Покинутий Перстень Автома"
    t[188054] = "Плащ Першопочатку"
    t[188055] = "Неймовірно Стародавній Перстень"
    t[188056] = "Трощило Стародавнього Захисника"
    t[188106] = "Незбагненний Амулет"
    t[188107] = "Наплічники Налаштування Шифру"
    t[188108] = "Пояс Налаштування Шифру"
    t[188109] = "Взуття Налаштування Шифру"
    t[188110] = "Нагрудник Налаштування Шифру"
    t[188111] = "Намисто Налаштування Шифру"
    t[188112] = "Перстень Налаштування Шифру"
    t[188113] = "Наручі Налаштування Шифру"
    t[188114] = "Головний Убір Налаштування Шифру"
    t[188115] = "Поножі Шифрового Налаштування"
    t[188116] = "Рукавиці Налаштування Шифру"
    t[188117] = "Плащ Налаштування Шифру"
    t[188121] = { name = "Спотворений Зразок Аніми", fen = "Anima warped and twisted by unexplained forces.", fua = "Аніма, спотворена й покручена нез'ясованими силами." }
    t[188137] = "Релікт Наведення"
    t[188152] = { name = "Скалка Керування Брамою", fen = "The shard's magic is searing to the touch.", fua = "Магія скалки пече на дотик." }
    t[188153] = "Кортіанський Плащ"
    t[188154] = "Кортіанський Нагрудник"
    t[188155] = "Кортіанські Чоботи"
    t[188156] = "Кортіанський Аксесуар"
    t[188157] = "Кортіанські Рукавички"
    t[188158] = "Кортіанський Шолом"
    t[188159] = "Кортіанські Поножі"
    t[188160] = "Кортіанські Наплічники"
    t[188161] = "Кортіанський Пояс"
    t[188162] = "Кортіанська Зброя"
    t[188163] = "Кортіанські Наручі"
    t[188164] = "Гліф Дикого Гриба"
    t[188165] = { name = "Вода Водоспаду", fen = "Water collected from Dimensional Falls.", fua = "Вода, зібрана з Вимірних Водоспадів." }
    t[188166] = { name = "Гравірована Карта", fen = "The card has intricate engravings along its surface.", fua = "Поверхню карти вкривають вигадливі гравіювання." }
    t[188167] = "Посередницький Знак Відзнаки"
    t[188173] = "Скриня Звитяжного Спорядження"
    t[188174] = "Скриня Розкутого Спорядження"
    t[188198] = "Сховок Аніми Мандрівника"
    t[188199] = { name = "Локрійська Улоговина", fen = "The swale lies inert, its purpose unserved.", fua = "Улоговина лежить недіяльна, її призначення не справджене." }
    t[188209] = { name = "Комплект: Бойові Лати Рейвенкреста", fen = "Legacy of the Lord of Black Rook", fua = "Спадок Володаря Чорного Грача." }
    t[188214] = { name = "Ядрова Грона Лоз [UNUSED]", fen = "A ball of pulsing plant matter. The core was completely compromised.", fua = "Кулька з пульсуючої рослинної матерії. Ядро повністю пошкоджене." }
    t[188217] = { name = "Та Сама Ціль", fen = "Everybody be looking for it.", fua = "Усі її шукають." }
    t[188218] = { name = "Кортіанський Журнал для Зберігання Таємниць", fen = "Full o' secrets, but you gotta put 'em dere first.", fua = "Повен таємниць, та спершу їх туди треба вписати." }
    t[188219] = { name = "Часниковий Амулет Захисту від Іклів", fen = "Keep dem fangs away! Also makes good pasta.", fua = "Тримай ті ікла подалі! А ще добре пасує до пасти." }
    t[188220] = { name = "Попеляста Куля Торгаста", fen = "Has the words \"I Survived the Tower\" on the bottom.", fua = "Знизу напис \"Я Пережив Вежу\"." }
    t[188221] = { name = "Око Ридальника", fen = "Appears to be weeping.", fua = "Здається, воно плаче." }
    t[188222] = { name = "Крила Прислужника", fen = "A cheap looking pin in the shape of golden wings. 'Yoo-hoo did it!' is etched on the back.", fua = "Дешевий на вигляд значок у формі золотих крил. Ззаду викарбувано: 'Гу-у-у це зробив!'" }
    t[188223] = { name = "Пляма Панування", fen = "An ominious dark smudge mars the swatch of fabric. Perhaps some Club Kaja'Cola is in order?", fua = "Зловісна темна пляма псує клапоть тканини. Може, варто скуштувати Клуб Каджа'Коли?" }
    t[188224] = { name = "Чарівна Мальдраксійська Лялька", fen = "Uncomfortably fleshy.", fua = "Незатишно тілеса." }
    t[188225] = { name = "Сороменеч", fen = "Frighteningly rusty with disuse.", fua = "Лячно іржавий від бездіяльності." }
    t[188226] = { name = "Чоботи для Пащопрогулянок", fen = "One o' dese days these boots be walkin' over you.", fua = "Одного дня ці чоботи прогуляються по тобі." }
    t[188230] = { name = "Зернина Катамелона", fen = "All the magic of creation exists within a single tiny seed.", fua = "Уся магія творення міститься в єдиній крихітній зернині." }
    t[188231] = { name = "Ключ від Сховку Провіса", fen = "Key to the Locked Provis Cache in Provis Flora.", fua = "Ключ від Замкненого Сховку Провіса у Флорі Провіса." }
    t[188252] = "Ланцюги Панування"
    t[188253] = "Шрами Братовбивчої Чвари"
    t[188254] = "Похмуре Затемнення"
    t[188255] = "Серце Рою"
    t[188261] = "Нав'язлива Клітка Думок"
    t[188262] = "Рик Лева"
    t[188263] = "Осердя Інтенсивності Відновлювача"
    t[188264] = "Удар Землеборця"
    t[188265] = "Сховок Здобутих Скарбів"
    t[188266] = "Пульсівна Скалка Розлому"
    t[188267] = "Дзвони Безкінечного Бенкету"
    t[188268] = "Ядро Винахідливості Архітектора"
    t[188269] = "Кишенькова Протокузня"
    t[188270] = "Елегія Вічних"
    t[188271] = "Перший Сигіл"
    t[188272] = "Лункий Резервуар"
    t[188273] = "Дзвіночок Допоміжного Служника"
    t[188274] = "Викрадений Артефакт"
    t[188275] = { name = "Наснажене Коріння [UNUSED]", fen = "Writhing with a strange growth-accelerating energy.", fua = "Звивається дивною енергією, що пришвидшує ріст." }
    t[188276] = { name = "Наснажене Коріння", fen = "Writhing with a strange growth-accelerating energy.", fua = "Звивається дивною енергією, що пришвидшує ріст." }
    t[188522] = { name = "Прадавній Архів", fen = "Recovered from Mawsworn in the Arrangement Index. Could be revelation, or could be a recipe. Or rarely, both.", fua = "Здобутий у пащогінців у Покажчику Впорядкування. Може бути одкровенням, а може — рецептом. А рідко — і тим, і тим." }
    t[188523] = { name = "Бадьорливий Зайцеїд", fen = "Prototype prey for Garudeon's brood. It would have kept going if not for you.", fua = "Прототип здобичі для виводка Ґарудеона. Він і досі біг би, якби не ти." }
    t[188524] = "Прискіплива Рішучість Космічного Гладіатора"
    t[188529] = { name = "Шестикутний Нектар", fen = "Surprisingly not edible. Could be useful for other things.", fua = "Несподівано неїстівний. Та може стати в пригоді для чогось іншого." }
    t[188660] = "Бар'єр Розкутого Гладіатора"
    t[188661] = "Молот Розкутого Гладіатора"
    t[188662] = "Великий посох розкутого гладіатора"
    t[188663] = "Посох зосередження розкутого гладіатора"
    t[188664] = "Магічний Клинок Розкутого Гладіатора"
    t[188665] = "Різак Розкутого Гладіатора"
    t[188666] = "Рушниця Розкутого Гладіатора"
    t[188667] = "Розривач Розкутого Гладіатора"
    t[188668] = "Дворучний меч розкутого гладіатора"
    t[188669] = "Обсидіанове Ядро"
    t[188670] = "Формовані Мінерали"
    t[188671] = "Великий Позолочений Перстень"
    t[188674] = { name = "Прив'язаний до Мага Фоліант Заклинань", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[188678] = { name = "Мотиватор Фіріма", fen = "A mysterious device that influences automa's actions.", fua = "Загадковий пристрій, що впливає на дії автома." }
    t[188679] = { name = "Безсвітлий Мучитель", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[188681] = "Гладка Оптична Лінза"
    t[188682] = "Містично Виліплена Сфера"
    t[188686] = "Поліровані Окови Душі"
    t[188687] = "Полірований Череп-Півмісяць"
    t[188688] = "Полірований Око-Півмісяць"
    t[188690] = "Зіпсований Серп Черепа"
    t[188691] = "Лунка Рішучість Космічного Гладіатора"
    t[188697] = "Кінематичний Рекалібратор Мікрожиття"
    t[188737] = "Чорний Арбалет Пащеприсяжних"
    t[188738] = { name = "Дивний Артефакт", fen = "Heavy, but light at the same time. As if still forming.", fua = "Важкий і водночас легкий. Наче все ще формується." }
    t[188740] = { name = "Кортіанське Сховище", fen = "A steady white pulse confirms that the knowledge stored within is still intact.", fua = "Розмірене біле пульсування підтверджує, що збережені всередині знання досі цілі." }
    t[188743] = "Попелястий Арбалет Пащеслужних"
    t[188744] = "Чорний Молот Пащеслужних"
    t[188745] = "Попелястий Молот Пащеслужних"
    t[188746] = "Чорна Алебарда Пащеслужних"
    t[188747] = "Попеляста Алебарда Пащеслужних"
    t[188748] = "Чорний Посох Пащеслужних"
    t[188749] = "Попелястий Посох Пащеслужних"
    t[188750] = "Полірований Дворучний Меч Пащеслужників"
    t[188752] = "Срібний Дворучний Меч Пащеслужних"
    t[188753] = "Позолочений Дворучний Меч Пащеслуг"
    t[188759] = { name = "Запечатана Старовинна Колода Темного Місяця", fen = "Mint condition.", fua = "У бездоганному стані." }
    t[188765] = { name = "Дослідження Посередника", fen = "This device contains the collected studies of the perished enlightened broker.", fua = "Цей пристрій містить зібрані дослідження загиблого просвітленого посередника." }
    t[188766] = "Резонатор Космічного Гладіатора"
    t[188775] = "Вічна Егіда Космічного Гладіатора"
    t[188778] = "Пожирне Прокляття Космічного Гладіатора"
    t[188779] = "Просякнутий Енергією Ріг"
    t[188787] = { name = "Замкнений Багаж Посередника", fen = "One unfortunate broker's cache is another mortal's fortune!", fua = "Скарбничка одного безталанного посередника — це багатство для іншого смертного!" }
    t[188789] = { name = "Горловий Захист Жабоїди", fen = "An intricate piece of metal used for both consumption and defense.", fua = "Вигадливий шматок металу, що слугує і для споживання їжі, і для оборони." }
    t[188790] = { name = "Подільна Сфера", fen = "Portions of this design are aligned to a fixed axis, serving as mechanical joints, probably for an automa.", fua = "Частини цього виробу вирівняні по фіксованій осі, слугуючи механічними з'єднаннями, ймовірно для автоми." }
    t[188791] = "Конічний Бур"
    t[188792] = "Броньований Каркас"
    t[188793] = { name = "Саморобний Інструмент Аналізу Шифрів", fen = "The cyphers of the First Ones are everywhere in Zereth Mortis. We cannot reveal all to your mortal sight, but this will help you to see somewhat more of them.", fua = "Шифри Перших усюди в Зерет-Мортісі. Ми не можемо явити всі їх твоєму смертному зору, але це допоможе тобі побачити дещо більше." }
    t[188794] = { name = "Спіймане Світло", fen = "Tangible motes of light that carelessly flutter into the wind, springing up and over the hills of Zereth Mortis.", fua = "Відчутні на дотик порошинки світла, що безтурботно тріпочуть на вітрі, здіймаючись над пагорбами Зерет-Мортіса." }
    t[188796] = "Тестовий Предмет Шифру"
    t[188798] = { name = "Викрадений Артефакт", fen = "This strange orb makes you feel slightly displaced just by touching it.", fua = "Від самого дотику до цієї дивної сфери вас огортає легке відчуття зміщення." }
    t[188808] = { name = "Терпляча Жабоїда", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[188809] = { name = "Прототип Стрибуна", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[188810] = { name = "Рудувата Жабоїда", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[188827] = "Космічна Слизь"
    t[188834] = "Примарний Вовчий Зуб"
    t[188835] = "Їдка Кислотна Бульбашка"
    t[188838] = "Чоботи Освіченого Окультиста"
    t[188839] = "Роба Освіченого Окультиста"
    t[188840] = "Наручі Освіченого Окультиста"
    t[188841] = "Пояс Освіченого Окультиста"
    t[188842] = "Поножі Освіченого Окультиста"
    t[188843] = "Оплічник Освіченого Окультиста"
    t[188844] = "Каптур Освіченого Окультиста"
    t[188845] = "Рукавиці Освіченого Окультиста"
    t[188846] = "Покрив Освіченого Окультиста"
    t[188847] = "Наголов'я Непорушних Зір"
    t[188848] = "Поножі Нерухомих Зір"
    t[188849] = "Нагрудник Нерухомих Зір"
    t[188850] = "Наручі Незмінних Зір"
    t[188851] = "Наплічники Незмінних Зір"
    t[188852] = "Пас Незмінних Зір"
    t[188853] = "Наручні Обмотки Незмінних Зір"
    t[188854] = "Онучі Незрушних Зірок"
    t[188855] = "Наручні Обмотки Богомисливця"
    t[188856] = "Наплічники Богомисливця"
    t[188857] = "Набедреник Богомисливця"
    t[188858] = "Кольчуга Богомисливця"
    t[188859] = "Салет Богомисливця"
    t[188860] = "Набедреники Боголовця"
    t[188861] = "Латні Рукавиці Богомисливця"
    t[188862] = "Чоботи Богомисливця"
    t[188863] = "Латні Рукавиці Першого Ейдолона"
    t[188864] = "Панцир Першого Ейдолона"
    t[188865] = "Поножі Першого Ейдолона"
    t[188866] = "Набедреники Першого Ейдолона"
    t[188867] = "Латні Наплічники Першого Ейдолона"
    t[188868] = "Лик Першого Ейдолона"
    t[188869] = "Наручі Першого Ейдолона"
    t[188870] = "Пояс Першого Ейдолона"
    t[188871] = "Накидка Незрушних Зір"
    t[188872] = "Маскування Богомисливця"
    t[188873] = "Плащ Першого Ейдолона"
    t[188874] = "Небесні Капці"
    t[188875] = "Шати Небожителя"
    t[188876] = "Браслети Емпірею"
    t[188877] = "Пояс Небесної Тверді"
    t[188878] = "Поножі Небесного"
    t[188879] = "Накидка Небесного"
    t[188880] = "Оплічник Небожителя"
    t[188881] = "Дотик Небесного"
    t[188882] = "Накидка Небожителя"
    t[188883] = "Чоботи Демонічної Зорі"
    t[188884] = "Роба Демонічної Зорі"
    t[188885] = "Браслети Демонічної Зорі"
    t[188886] = "Пояс Демонічної Зорі"
    t[188887] = "Поножі Демонічної Зорі"
    t[188888] = "Оплічник Демонічної Зорі"
    t[188889] = "Роги Демонічної Зорі"
    t[188890] = "Рукавиці Демонічної Зорі"
    t[188891] = "Плащ Демонічної Зірки"
    t[188892] = "Каптур Мінливого Карателя"
    t[188893] = "Штани Мінливого Карателя"
    t[188894] = "Безрукавка Мінливого Карателя"
    t[188895] = "Наручі Мінливого Карателя"
    t[188896] = "Наплічники Мінливого Карателя"
    t[188897] = "Пояс Мінливого Карателя"
    t[188898] = "Рукавиці Мінливого Карателя"
    t[188899] = "Чоботи Мінливого Карателя"
    t[188900] = "Оплічник Мінливого Карателя"
    t[188901] = "Личина Душеклинка"
    t[188902] = "Поножі Клинка Душі"
    t[188903] = "Шкіряна Броня Душеклинка"
    t[188904] = "Наруч Душеклинка"
    t[188905] = "Нічокрилі Наплічники Душеклинка"
    t[188906] = "Перев'язь Душеклинка"
    t[188907] = "Рукавиці Душеклинка"
    t[188908] = "Чоботи Душеклинка"
    t[188909] = "Плащ Душеклинка"
    t[188910] = "Вінець Великого Виру"
    t[188911] = "Поножі Великого Підняття"
    t[188912] = "Кіраса Великого Виру"
    t[188913] = "Напіврукавиці Великого Виру"
    t[188914] = "Китиці Великого Підняття"
    t[188915] = "Пояс Великого Виру"
    t[188916] = "Рукавиці Великого Виверження"
    t[188917] = "Онучі Великого Виверження"
    t[188918] = "Накидка Великого Виру"
    t[188919] = "Наручі Теургійного Зореречця"
    t[188920] = "Оздоба Теургійного Зореречця"
    t[188921] = "Пояс Теургійного Зореречця"
    t[188922] = "Кольчуга Теургійного Зореречця"
    t[188923] = "Каптур Теургійного Зореречця"
    t[188924] = "Набедреники Теургічного Звіздаря"
    t[188925] = "Рунічні Пов'язки Теургійного Зореречця"
    t[188926] = "Чоботи Теургійного Зореречця"
    t[188927] = "Шаль Теургійного Зореречця"
    t[188928] = "Латні Рукавиці Сяйливого Лицаря"
    t[188929] = "Нагрудник Сяйливого Лицаря"
    t[188930] = "Остроги Сяйливого Лицаря"
    t[188931] = "Роба Осяйного Лицаря"
    t[188932] = "Наплічники Сяйливого Лицаря"
    t[188933] = "Шолом Сяйливого Лицаря"
    t[188934] = "Наручі Сяйливого Лицаря"
    t[188935] = "Пояс Сяйливого Лицаря"
    t[188936] = "Накидка Сяйливого Лицаря"
    t[188937] = "Рукавиці Незліченної Піхоти"
    t[188938] = "Нагрудник Безмежної Піхоти"
    t[188939] = "Хода Нескінченної Піхоти"
    t[188940] = "Латні Поножі Нескінченної Піхоти"
    t[188941] = "Наплічники Незліченної Піхоти"
    t[188942] = "Погляд Безкінечної Піхоти"
    t[188943] = "Наручі Нескінченної Піхоти"
    t[188944] = "Великий Пояс Незліченної Піхоти"
    t[188945] = "Прихильність Незліченної Піхоти"
    t[188947] = "Долоня з Накресленим Сузір'ям"
    t[188948] = "Осяйне Крило"
    t[188952] = { name = "Підкорений Камінь Повернення", fen = "Your time in Torghast has taught you a trick or two.", fua = "Час, проведений у Торгасті, навчив тебе кількох хитрощів." }
    t[188957] = { name = "Порошинка Творення", fen = "A small portion of energy needed to fuel a synthesis forge.", fua = "Невелика порція енергії, потрібна для живлення кузні синтезу." }
    t[189145] = { name = "Ґратка Равлиїда", fen = "A mystical lattice used to synthesize a helicid.", fua = "Містична ґратка, що використовується для синтезу равлиїда." }
    t[189146] = { name = "Ґратка Геоменталя", fen = "A mystical lattice used to synthesize a geomental.", fua = "Містична ґратка, що використовується для синтезу геоменталя." }
    t[189147] = { name = "Ґратка Зайцеїда", fen = "A mystical lattice used to synthesize a leporid.", fua = "Містична ґратка, що використовується для синтезу зайцеїда." }
    t[189148] = { name = "Ґратка Птахіда", fen = "A mystical lattice used to synthesize a poultrid.", fua = "Містична ґратка, що використовується для синтезу птахіда." }
    t[189149] = { name = "Ґратка Протоптаха", fen = "A mystical lattice used to synthesize a proto avian.", fua = "Містична ґратка, що використовується для синтезу протоптаха." }
    t[189150] = { name = "Ґратка Раптори", fen = "A mystical lattice used to synthesize a raptora.", fua = "Містична ґратка, що використовується для синтезу раптори." }
    t[189151] = { name = "Ґратка Скарабіда", fen = "A mystical lattice used to synthesize a scarabid.", fua = "Містична ґратка, що використовується для синтезу скарабіда." }
    t[189152] = { name = "Ґратка Тарахніда", fen = "A mystical lattice used to synthesize a tarachnid.", fua = "Містична ґратка, що використовується для синтезу тарахніда." }
    t[189153] = { name = "Безформна Ґратка", fen = "A mystical lattice used to synthesize a creature without a clearly-defined shape.", fua = "Містична ґратка, що використовується для синтезу створіння без чітко окресленої форми." }
    t[189154] = { name = "Ґратка Осоїда", fen = "A mystical lattice used to synthesize a vespoid.", fua = "Містична ґратка, що використовується для синтезу осоїда." }
    t[189155] = { name = "Ґратка Зміїда", fen = "A mystical lattice used to synthesize a viperid.", fua = "Містична ґратка, що використовується для синтезу зміїда." }
    t[189156] = { name = "Ґратка Вомбати", fen = "A mystical lattice used to synthesize a vombata.", fua = "Містична ґратка, що використовується для синтезу вомбати." }
    t[189157] = { name = "Проблиск Оживлення", fen = "A component used to synthesize the soul of a small protoform creature.", fua = "Складник, що використовується для синтезу душі малого створіння протоформи." }
    t[189158] = { name = "Проблиск Хитрості", fen = "A component used to synthesize the soul of a small protoform creature.", fua = "Складник, що використовується для синтезу душі малого створіння протоформи." }
    t[189159] = { name = "Проблиск Відкриття", fen = "A component used to synthesize the soul of a small protoform creature.", fua = "Складник, що використовується для синтезу душі малого створіння протоформи." }
    t[189160] = { name = "Проблиск Зосередження", fen = "A component used to synthesize the soul of a small protoform creature.", fua = "Складник, що використовується для синтезу душі малого створіння протоформи." }
    t[189161] = { name = "Проблиск Злоби", fen = "A component used to synthesize the soul of a small protoform creature.", fua = "Складник, що використовується для синтезу душі малого створіння протоформи." }
    t[189162] = { name = "Проблиск Метаморфози", fen = "A component used to synthesize the soul of a small protoform creature.", fua = "Складник, що використовується для синтезу душі малого створіння протоформи." }
    t[189163] = { name = "Проблиск Руху", fen = "A component used to synthesize the soul of a small protoform creature.", fua = "Складник, що використовується для синтезу душі малого створіння протоформи." }
    t[189164] = { name = "Проблиск Множинності", fen = "A component used to synthesize the soul of a small protoform creature.", fua = "Складник, що використовується для синтезу душі малого створіння протоформи." }
    t[189165] = { name = "Проблиск Хижацтва", fen = "A component used to synthesize the soul of a small protoform creature.", fua = "Складник, що використовується для синтезу душі малого створіння протоформи." }
    t[189166] = { name = "Проблиск Оновлення", fen = "A component used to synthesize the soul of a small protoform creature.", fua = "Складник, що використовується для синтезу душі малого створіння протоформи." }
    t[189167] = { name = "Проблиск Вдоволення", fen = "A component used to synthesize the soul of a small protoform creature.", fua = "Складник, що використовується для синтезу душі малого створіння протоформи." }
    t[189168] = { name = "Проблиск Безтурботності", fen = "A component used to synthesize the soul of a small protoform creature.", fua = "Складник, що використовується для синтезу душі малого створіння протоформи." }
    t[189169] = { name = "Проблиск Виживання", fen = "A component used to synthesize the soul of a small protoform creature.", fua = "Складник, що використовується для синтезу душі малого створіння протоформи." }
    t[189170] = { name = "Проблиск Пильності", fen = "A component used to synthesize the soul of a small protoform creature.", fua = "Складник, що використовується для синтезу душі малого створіння протоформи." }
    t[189171] = { name = "Брязкальце Чистої Новації", fen = "Innovation is madness made useful, harnessed by a singular vision.", fua = "Новація — це божевілля, обернене на користь і скероване єдиним баченням." }
    t[189172] = { name = "Кристалізована Луна Першої Пісні", fen = "All that remains to hear of this long-lost tune is hidden in the babbling of falling waters.", fua = "Усе, що лишилося від цього давно загубленого наспіву, сховане в дзюрчанні спадної води." }
    t[189173] = { name = "Вічна Перлина Люті", fen = "When all you are is lost to darkness, only your rage survives.", fua = "Коли все, чим ти був, поглинула пітьма, виживає лише твоя лють." }
    t[189174] = { name = "Лінза Зосередженого Наміру", fen = "Through this lens, the enlightened can find truth.", fua = "Крізь цю лінзу просвітлені здатні побачити істину." }
    t[189175] = { name = "Вуздечка, Викувана у Пащі", fen = "Ephemeral synergy - luck - is all that Zovaal needed for his escape from the Maw.", fua = "Швидкоплинна синергія — щастя — це все, що знадобилося Зоваалу для втечі з Пащі." }
    t[189176] = { name = "Вінець Протоформної Свідомості", fen = "Upon one's head, it allows purpose through service.", fua = "На голові він дарує сенс через служіння." }
    t[189177] = { name = "Ключ Одкровення", fen = "Some dangerous truths must be hidden to keep mortals protected.", fua = "Деякі небезпечні істини мають лишатися прихованими заради захисту смертних." }
    t[189178] = { name = "Знаряддя Незбагненних Дослідів", fen = "An unparalleled mind uses these to create... imperfectly.", fua = "Незрівнянний розум послуговується ними, щоб творити... недосконало." }
    t[189179] = { name = "Чистий Бронзовий Злиток", fen = "If mixed into the storehouses of any mortal world, you could not tell the difference between this and bronze made of copper and tin.", fua = "Якби це опинилося в коморах будь-якого смертного світу, ніхто б не відрізнив цю бронзу від звичайної, виплавленої з міді й олова." }
    t[189180] = { name = "Безкінечний Поклик Вітру", fen = "If sufficiently enhanced, any soul can soar the winds of Zereth Mortis.", fua = "Достатньо вдосконалена душа здатна ширяти на вітрах Зерет-Мортіса." }
    t[189362] = { name = "Феромонна Залоза", fen = "Smells like fermented garlic.", fua = "Пахне ферментованим часником." }
    t[189418] = "Креслення: Амбистовий Стрілець"
    t[189433] = "Трав'яні Ліки"
    t[189434] = "Креслення: Лютий Скарабід"
    t[189435] = "Креслення: Багатокурка"
    t[189436] = "Креслення: Лютий Полтрид"
    t[189437] = "Креслення: Стабілізований Геоментал"
    t[189438] = "Частка Композиції"
    t[189439] = "Вузол Компіляції"
    t[189440] = "Креслення: Всемогутнє Ядро"
    t[189441] = "Креслення: Резонансне Відлуння"
    t[189442] = "Креслення: Протолоскотик"
    t[189443] = "Креслення: Жахлива Медуза"
    t[189444] = "Креслення: Стрибучий Лепорид"
    t[189445] = "Креслення: Мікролісід"
    t[189446] = "Креслення: Мушелька"
    t[189447] = "Креслення: Віперід-Загроза"
    t[189448] = "Креслення: Риючий Вомбата"
    t[189450] = { name = "Крещендал", fen = "Still dripping with devourer guts.", fua = "Усе ще скрапує нутрощами пожирача." }
    t[189451] = "Шеф-Кухар Покопок"
    t[189455] = "Креслення: Блідий Величний Цервід"
    t[189456] = "Креслення: Розколотий Зеретський Скакун"
    t[189457] = "Креслення: Смертобіг"
    t[189458] = "Креслення: Мисливець Пустелекрил"
    t[189459] = "Креслення: Пащепристосована Раптора"
    t[189460] = "Креслення: Раптора-Пікірувальник"
    t[189461] = "Креслення: Серенада"
    t[189462] = "Креслення: Бронзовий Геліцид"
    t[189463] = "Креслення: Невдалий Прототип Флітподу"
    t[189464] = "Креслення: Багряний Гелікід"
    t[189465] = "Креслення: Плазун Генези"
    t[189466] = "Креслення: Тарахнід-Повзун"
    t[189467] = "Креслення: Незбагненний Метушун"
    t[189468] = "Креслення: Золотопанцирний Буфонід"
    t[189469] = "Креслення: Прототип Стрибуна"
    t[189470] = "Креслення: Терплячий Буфонід"
    t[189471] = "Креслення: Рудий Буфонід"
    t[189472] = "Креслення: Веспоїд-Тріпотун"
    t[189473] = "Креслення: Бронзокрилий Веспоїд"
    t[189474] = "Креслення: Дзиж"
    t[189475] = "Креслення: Кований Злоблеліт"
    t[189476] = "Креслення: Допитливий Кристалонюх"
    t[189477] = "Креслення: Затемнений Вомбата"
    t[189478] = "Креслення: Оздоблений Вомбата"
    t[189479] = { name = "Хроматичний Розид", fen = "Vibrant flowers with a strange aroma.", fua = "Яскраві квіти з дивним ароматом." }
    t[189492] = { name = "Кодекс Налаштування", fen = "This strange object hums with an energy.", fua = "Цей дивний предмет гуде енергією." }
    t[189493] = { name = "Уламок Чорної Сталі", fen = "The Jailer's magic emanates from this chunk of steel.", fua = "Від цього шматка криці струмує магія Тюремника." }
    t[189499] = { name = "Протоформний Каталізатор", fen = "The cyphers transcribed along the surface of the object refer to the Protoform Repository.", fua = "Шифри, накреслені вздовж поверхні предмета, вказують на Сховище Протоформ." }
    t[189500] = { name = "Решітка Оленя", fen = "A mystical lattice used to synthesize a cervid.", fua = "Містична решітка, що використовується для синтезу оленя." }
    t[189501] = { name = "Протоформний Інструмент", fen = "A component used to synthesize the soul of a protoform creature.", fua = "Складник, що використовується для синтезу душі протоформної істоти." }
    t[189507] = { name = "Пожирач Душ Космічного Гладіатора", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[189535] = { name = "Залишок Неочастки", fen = "A fragment of this necessary creation component.", fua = "Уламок цього необхідного для творення складника." }
    t[189536] = { name = "Затверділа Неочастка", fen = "Partially decomposed Neomotes.", fua = "Частково розкладені неочастки." }
    t[189544] = "Плетиво Аніми"
    t[189554] = "Мотузка Протоприборкувача"
    t[189560] = { name = "Кристалічний Сфероїд Відхилення", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189561] = { name = "Приборкання Первинного: Ориксал", fen = "This scroll contains a few words of power in the language of the First Ones.", fua = "Цей сувій містить кілька слів сили мовою Перших." }
    t[189562] = "Бар'єр Космічного Гладіатора"
    t[189563] = "Рушниця Космічного Гладіатора"
    t[189564] = "Дворучний Меч Космічного Гладіатора"
    t[189566] = "Фокусний Посох Космічного Гладіатора"
    t[189567] = "Великий Посох Космічного Гладіатора"
    t[189568] = "Молот Космічного Гладіатора"
    t[189569] = "Розривач Космічного Гладіатора"
    t[189570] = "Різак Космічного Гладіатора"
    t[189572] = { name = "Приборкання Первинного: Гадеон Каменолам", fen = "This scroll contains a few words of power in the language of the First Ones.", fua = "Цей сувій містить кілька слів сили мовою Перших." }
    t[189573] = { name = "Приборкання Первинного: Гарудеон", fen = "This scroll contains a few words of power in the language of the First Ones.", fua = "Цей сувій містить кілька слів сили мовою Перших." }
    t[189575] = { name = "Фірім у Вигнанні, Частина 1", fen = "A memoir of sorts.", fua = "Своєрідні мемуари." }
    t[189576] = { name = "Фірім у Вигнанні, Частина 2", fen = "A testament to a singular intellect.", fua = "Свідчення непересічного розуму." }
    t[189577] = "Відбивний Плинний Сфероїд"
    t[189578] = { name = "Фірім у Вигнанні, Частина 3", fen = "A victim of lesser intellects.", fua = "Жертва нижчих умів." }
    t[189579] = { name = "Фірім у Вигнанні, Частина 4", fen = "Of automa, and realizations.", fua = "Про автома та осяяння." }
    t[189580] = { name = "Фірім у Вигнанні, Частина 5", fen = "The cyphers and the greater mysteries.", fua = "Шифри та найбільші таємниці." }
    t[189581] = { name = "Фірім у Вигнанні, Частина 6", fen = "You may hear the song, but you will not understand it.", fua = "Ти можеш почути пісню, але не зрозумієш її." }
    t[189582] = { name = "Фірім у Вигнанні, Частина 7", fen = "Ponder the revelations and you will know fear.", fua = "Поміркуй над одкровеннями — і пізнаєш страх." }
    t[189584] = "Рятівник Гробниці"
    t[189704] = { name = "Ключ Панування", fen = "A key to the Domination Cache near the Dread Portal.", fua = "Ключ до Схованки Панування поблизу Жахного Порталу." }
    t[189705] = "Душа Індика"
    t[189707] = "Бронзово-Золоте Тіло Покопока"
    t[189708] = "Берилієво-Срібне Тіло Покопока"
    t[189709] = "Кобальтово-Мідне Тіло Покопока"
    t[189710] = "Рубіново-Платинове Тіло Покопока"
    t[189711] = "Золото-Рубінові Компоненти Покопока"
    t[189712] = "Срібно-Берилієві Компоненти Покопока"
    t[189713] = "Мідно-Кобальтові Компоненти Покопока"
    t[189714] = "Платиново-Смарагдові Компоненти Покопока"
    t[189715] = "Діамантові Наручі Покопока"
    t[189716] = "Лицьова Оздоба Покопока"
    t[189717] = "Захищене Ядро Покопока"
    t[189718] = "Поліпшене Ядро Покопока"
    t[189722] = { name = "Кристалічний Сфероїд Завзяття", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189723] = { name = "Кристалічний Сфероїд Поглинання", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189724] = { name = "Кристалічний Сфероїд Видобутку", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189725] = { name = "Кристалічний Сфероїд Гнучкості", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189726] = { name = "Кристалічний Сфероїд Зосередження", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189727] = { name = "Кристалічний Сфероїд Зцілення", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189728] = { name = "Кристалічний Сфероїд Затемнення", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189729] = { name = "Кристалічний Сфероїд Осмосу", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189730] = { name = "Кристалічний Сфероїд Сприйняття", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189731] = { name = "Кристалічний Сфероїд Потуги", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189732] = { name = "Кристалічний Сфероїд Витривалості", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189733] = { name = "Кристалічний Сфероїд Надійності", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189734] = { name = "Кристалічний Сфероїд Твердості", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189735] = { name = "Кристалічний Сфероїд Швидкості", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189736] = "Поглинальний Плинний Сфероїд"
    t[189737] = "Обскуріальний Плинний Сфероїд"
    t[189738] = "Перцептіальний Плинний Сфероїд"
    t[189739] = "Екстрактіальний Плинний Сфероїд"
    t[189740] = "Завзятий Плинний Сфероїд"
    t[189741] = "Осмосіальний Плинний Сфероїд"
    t[189742] = "Зціляльний Плинний Сфероїд"
    t[189743] = "Зосередноїдний Плинний Сфероїд"
    t[189744] = "Потенційний Плинний Сфероїд"
    t[189745] = "Надійний Плинний Сфероїд"
    t[189746] = "Ригіалічний Плинний Сфероїд"
    t[189747] = "Велоціальний Плинний Сфероїд"
    t[189748] = "Констіалічний Рідинний Сфероїд"
    t[189749] = "Гнучкоїдний Плинний Сфероїд"
    t[189753] = { name = "Фірім у Вигнанні, Епілог", fen = "Addendum: Ruminations upon the fragility of all things.", fua = "Додаток: роздуми про крихкість усього сущого." }
    t[189754] = "Верстат Зародження"
    t[189755] = "Форціальний Плинний Сфероїд"
    t[189756] = "Токсиціальний Плинний Сфероїд"
    t[189757] = "Ефіціалічний Флюїдний Сфероїд"
    t[189758] = "Відбивний Плинний Сфероїд"
    t[189759] = "Робустіалічний Плинний Сфероїд"
    t[189760] = { name = "Кристалічний Сфероїд Міцності", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189761] = { name = "Кристалічний Сфероїд Токсичності", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189762] = { name = "Кристалічний Сфероїд Стійкості", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189763] = { name = "Кристалічний Сфероїд Дієвості", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189764] = { name = "Кристалічний Сфероїд Відбиття", fen = "Can be socketed into Cypher gear.", fua = "Можна вставити в криптоспорядження." }
    t[189767] = { name = "Блукливий Ремонтний Інструмент", fen = "This strange Jiro tool has a habit of disappearing...", fua = "Цей дивний інструмент джиро має звичку зникати..." }
    t[189768] = { name = "Молот Джиро", fen = "Looks capable of breaking rocks.", fua = "Схоже, ним можна трощити каміння." }
    t[189769] = { name = "Ікло Фестіса", fen = "Lined with the acrid poison that Mother uses to break her prey... molecule by molecule.", fua = "Вкрите їдкою отрутою, якою Матір розкладає свою здобич... молекулу за молекулою." }
    t[189770] = "Збірні Підошви"
    t[189771] = "Набедреники з Прадавнього Матеріуму"
    t[189772] = "Модифікована Захисна Сітка"
    t[189773] = "Застібка Кривих Крещендо"
    t[189774] = "Розколоте Ядро Колоса"
    t[189775] = "Шолом Урочистої Варти"
    t[189776] = "Пояс Першої Брами"
    t[189777] = "Наручі Нестабільного Велетня"
    t[189778] = "Латні Поножі Дрімотної Вартової"
    t[189779] = { name = "Ключ до Безсмертного Вогнища", fen = "Will you unlock inner courage, or terrible destruction?", fua = "Що ти вивільниш: внутрішню відвагу чи страшну руйнацію?" }
    t[189781] = "Затьмарена Фрактальна Призма"
    t[189782] = "Роба Моторошних Гімнів"
    t[189783] = { name = "Просякнутий Гріхом Вінець", fen = "Heavy is the head that wears the crown.", fua = "Важка голова, що носить корону." }
    t[189784] = "Еполети Млосної Арії"
    t[189785] = "Хроматична Кіраса Віщуна"
    t[189786] = "Пісенно-Шалені Чоботи"
    t[189787] = "Дисонансний Німб Дозейн"
    t[189788] = "Злоба Маестро"
    t[189789] = "Прагнення до Перемоги"
    t[189790] = { name = "Останнє Форте", fen = "Vengeance for songs silenced too soon.", fua = "Помста за пісні, що змовкли занадто рано." }
    t[189791] = "Накидка Жалобних Мелодій"
    t[189793] = "Пояс Безмовної Сонати"
    t[189794] = "Чоботи Невпинного Протистояння"
    t[189795] = "Чоботи Зимової Навали"
    t[189796] = "Вознесений Нагрудник Обов'язку"
    t[189797] = "Наручні Обмотки Нічного Оновлення"
    t[189798] = "Мокасини Жахливого Відпущення"
    t[189799] = "Обіцянка Елізії"
    t[189800] = "Прелюдія до Гордині"
    t[189801] = "Заряджена Ефемерою Шапка Мислителя"
    t[189802] = "Хризоліт Балакучого Хранителя"
    t[189803] = "Штани Доглядача Автоматів"
    t[189804] = { name = "Займистий Пояс Співпраці", fen = "No bad ideas in a brainstorm!", fua = "У мозковому штурмі немає поганих ідей!" }
    t[189805] = "Наручі Незбагненного Винахідника"
    t[189806] = "Світлотрощна Сокирка"
    t[189807] = "Розбратний смертоносний клинок"
    t[189808] = "Розтинальний Скальпель Лігувіма"
    t[189809] = "Ненаситні Наручі Сколекса"
    t[189810] = "Пом'якшений Ефемерою Екзоскелет"
    t[189811] = "Нескінченно Згортний Виток"
    t[189812] = "Обвітрені Піском Шкіряні Наручі Пожирача"
    t[189813] = "Оплічник Зломленого Звіра"
    t[189814] = "Ненажерливий Наплічний Захист"
    t[189815] = "Камуфляж Причаєного Хижака"
    t[189816] = { name = "Кристалізований Шип Нутрощів", fen = "As deadly outside the beast as it was within it.", fua = "Назовні звіра такий самий смертоносний, як і всередині нього." }
    t[189817] = "Пошрамований Розломом Сонцедробитель"
    t[189818] = { name = "Визволення Панування", fen = "By his hands, freedom. By his design, oblivion.", fua = "Його руками — свобода. Його задумом — забуття." }
    t[189819] = "Асимільований Запобіжник"
    t[189820] = "Клинок Ганоа"
    t[189821] = "Кобура для Незаконного Артефакту"
    t[189822] = "Імпортовані Наплічники Іллідарі"
    t[189823] = "Викрадені Натрійські Пантофлі"
    t[189824] = "Неліцензовані Гіперсвітлові Рукавиці"
    t[189825] = "Наручі Завуальованого Аукціоніста"
    t[189826] = "Стримувальний Пояс Каральника"
    t[189827] = { name = "Доказ Посвяти Картелю Ксай", fen = "No more small jobs. From now on, you meet with our associates directly.", fua = "Більше ніяких дрібних робіт. Віднині ви зустрічаєтеся з нашими партнерами безпосередньо." }
    t[189828] = "Арбалет Капітана Картелю Зай"
    t[189829] = { name = "Реліктовий Клинок Предтечі", fen = "One of a kind. How much would Tazavesh pay for a second?", fua = "Єдиний у своєму роді. Скільки заплатив би Тазавеш за другий?" }
    t[189830] = { name = "Відтворений Реліктовий Клинок", fen = "A flawless duplicate of inscrutable design.", fua = "Бездоганна копія незбагненної конструкції." }
    t[189831] = "Заплямовані Ефемерою Латні Чоботи"
    t[189832] = "Великі Чоботи Мандрівного Голіафа"
    t[189833] = "Лазурит Мовчазного Хранителя"
    t[189834] = "Посох-Сторож Великого Циклу"
    t[189835] = "Княжі Шати Андуїна"
    t[189836] = "Наручі Лиховісної Зорі"
    t[189837] = "Вовкосердий Пояс Короля"
    t[189838] = "Маяк Стормвінда"
    t[189839] = { name = "Душевикривлена Печатка Рінна", fen = "I now believe as you do - that peace is the noblest aspiration.", fua = "Тепер я вірю так само, як і ти — що мир є найшляхетнішим прагненням." }
    t[189840] = "Блюзнірський Пояс Погибелі Решток"
    t[189841] = { name = "Душевикривлена Печатка Менетіла", fen = "No king rules forever, my son.", fua = "Жоден король не править вічно, мій сину." }
    t[189842] = "Наручі Таємного Командира"
    t[189843] = "Рукавиці Викраденої Долі"
    t[189844] = "Латні Рукавиці Незримих Гостей"
    t[189845] = { name = "Зруйнований Герб Лордерону", fen = "A memento of Mal'ganis' favorite pawn.", fua = "Згадка про улюблену пішачку Мальганіса." }
    t[189846] = { name = "Змучені Парні Клинки Аландієн", fen = "A trophy from Kin'tessa's favorite deception.", fua = "Трофей з улюбленого ошуканства Кінтесси." }
    t[189847] = "Покрив Обранців Сіра"
    t[189848] = "Чоботи Титанічної Цікавості"
    t[189849] = "Міжвимірні Наручі"
    t[189850] = "Рукавиці Прихованих Світів"
    t[189851] = { name = "Спустошена Світоскалка", fen = "A bleak reminder to worlds unworthy.", fua = "Похмурий нагад негідним світам." }
    t[189852] = "Антумбра, Тінь Космосу"
    t[189853] = "Астральний Вирок"
    t[189854] = { name = "Геральдичний Перстень Ригелона", fen = "Prepare for my arrival.", fua = "Готуйтеся до мого прибуття." }
    t[189855] = "Наручі Вигнанця"
    t[189856] = "Покручений Оберіг Різьбяра Рун"
    t[189857] = "Поножі Епохального Гнобителя"
    t[189858] = "Поножі Граничної Загрози"
    t[189859] = { name = "Світовбивча Райдужка", fen = "A living symbol of despair, borne by the nemesis of a doomed eternity. The fate of Azeroth will be shared by all her children.", fua = "Живий символ відчаю, що його несе ворог приреченої вічності. Долю Азероту розділять усі його діти." }
    t[189860] = "Заборонена Істина"
    t[189861] = { name = "Зоваструм, Розтворення", fen = "Begin the end of all things.", fua = "Започаткуй кінець усіх речей." }
    t[189862] = "Молот Першого Арбітра"
    t[189863] = { name = "Просторовий Відмикач", fen = "A strangely perfect shimmering geometric form. This looks important.", fua = "Дивно досконала мерехтлива геометрична форма. Виглядає важливо." }
    t[189864] = "Павутиння Аніми"
    t[189865] = "Матриця Аніми"
    t[189900] = "Ніжна Нагрудна Тканина Вексіс"
    t[189901] = "Осквернені Шати Вітіани"
    t[189902] = "Чоботи Безталанного Мандрівника"
    t[189903] = "Сандалі Просіювання Піску"
    t[189904] = "Рукавички Прискіпливого Архітектора"
    t[189905] = "Сиропні Чавила Гірукона"
    t[189906] = { name = "Маска Рішучого Оленя", fen = "Put on your bravest face.", fua = "Надягніть своє найхоробріше обличчя." }
    t[189907] = "Вінець Покрученої Думки"
    t[189908] = "Поножі Ненажери Голоду"
    t[189909] = "Штани Холодних Закутків"
    t[189910] = "Оздоба Дзвінких Фракталів"
    t[189911] = "Розкішний Хутряний Оплічник"
    t[189912] = "Вишуканий Пояс Оріксала"
    t[189913] = "Стискальний Пояс Поглинача"
    t[189914] = "Відновлювальні Наручі Отіозена"
    t[189915] = "Тканинна Стрічка Тахвітца"
    t[189916] = "Збруя Мутованого Пожирача"
    t[189917] = "Халат Майстра Сузір'їв"
    t[189918] = "Кроки Скороминущого Маклера"
    t[189919] = "Чоботи Метушливого Скарабея"
    t[189920] = "Рукавички Гадючого Сторожа"
    t[189921] = "Ненаситні Рукавиці Пожирача"
    t[189922] = "Каптур Ганебного Розростання"
    t[189923] = "Жахливий Лик Тарахніда"
    t[189924] = "Поножі Дзижчливого Хижака"
    t[189925] = "Спритні Поножі Земноводного"
    t[189926] = "Отрутою Зрошені Наплічники"
    t[189927] = "Погризені Посередницькі Наплічники"
    t[189928] = "Доцентровий Пояс"
    t[189929] = "Обвитий Лозою Ремінь"
    t[189930] = "Пута Безмежного Хаосу"
    t[189931] = "Суглобові Обмотки Анеліда"
    t[189932] = "Гладкий Лускатий Хітин"
    t[189933] = "Нагрудник Пильної Раптори"
    t[189934] = "Лати-Чоботи Слизового Сліду"
    t[189935] = "Гнітючі Розчавлювачі Надії"
    t[189936] = { name = "Жерущий Плащ Бенкетувальниці", fen = "More of a large napkin, really.", fua = "Радше така собі велика серветка, насправді." }
    t[189937] = "Перяна Ковдра Ґарудеона"
    t[189939] = "Паралітична Хватка Затоджина"
    t[189940] = "Забруднювальний Дотик Архітектора"
    t[189941] = "Ненаситна Діадема"
    t[189942] = "Непереборний Лицьовий Захист Гадеона"
    t[189943] = "Поножі Космічних Візерунків"
    t[189944] = "Незрушна Постава Вомбата"
    t[189945] = "Наплічники Зниклого Велетня"
    t[189946] = "Драглистий Оплічник Аураліда"
    t[189947] = "Пояс Величного Спостерігача"
    t[189948] = "Душильне Ланцюгове Ласо"
    t[189949] = "Окови Скутого Стража"
    t[189950] = "Пута Скутої Жертви"
    t[189951] = "Засмагла Пташина Броня"
    t[189952] = "Нагрудна Мушля Небесного Молюска"
    t[189953] = "Заплямовані Зеленню Чоботи"
    t[189954] = "Осяйні Чоботи Вартового"
    t[189955] = "Деренчливі Рукавиці Скарабіда"
    t[189956] = "Рукавиці Збоченого Чемпіона"
    t[189957] = "Зосереджувальний Наголовник Колоса"
    t[189958] = "Пробивний Великий Шолом Копача"
    t[189959] = "Поножі Граційного Приземлення"
    t[189960] = "Принишклі Поножі Бафоніда"
    t[189961] = "Наплічники Витривалого Захисника"
    t[189962] = "Осяйні Наплічники Сорраноса"
    t[189963] = "Різьблена Застібка Уробороса"
    t[189964] = "Багатогранний Пояс"
    t[189965] = "Броньовані Наручі Гелмікса"
    t[189966] = "Наручі зі Співучого Металу"
    t[189967] = "Каптур Зоряної Топології"
    t[189968] = "Туніка Генерала Володарів Жаху"
    t[189969] = "Дзвінкі Поножі Веспоїда"
    t[189970] = "Забрало Нутряних Жадань"
    t[189971] = "Душа Драконояструба"
    t[189972] = "Душа Скорпіда"
    t[189973] = "Душа Ската"
    t[189975] = "Душа Елекка"
    t[189976] = "Душа Довгонога"
    t[189977] = "Душа Кажана"
    t[189980] = "Душа Брутозавра"
    t[189982] = "Душа Силітида"
    t[189983] = "Душа Ґроміта"
    t[189984] = "Накидка Обожнюваної Симетрії"
    t[189985] = "Завіса Незліченних Світів"
    t[189986] = "Душа Броненосця"
    t[189987] = "Душа Свині"
    t[189988] = "Душа Вівці"
    t[189989] = "Душа Пінгвіна"
    t[189990] = "Душа Бджоли"
    t[189991] = "Душа Равлика"
    t[189993] = "Молоток збоченого судії"
    t[189994] = "Наказ Чіталі"
    t[189995] = "Молот Вирівнювання Будівничого"
    t[189996] = "Витончено Збалансована Сокира"
    t[189997] = "Міць Першого Вовка"
    t[189998] = "Оздоблений Кам'яний Молот"
    t[189999] = "Молоток Темного Неба"
    t[190000] = "Панцир Ковзких Пісків"
    t[190001] = "Блискучий Горловий Захист Ґоркека"
    t[190002] = "Оплот Зламаних"
    t[190003] = "Кіготь Небесного Рятівника"
    t[190004] = "Гравійоване Жало Фурідіана"
    t[190005] = "Осяйний Випад Гірукона"
    t[190006] = "Меч Висмоктування Аніми"
    t[190007] = { name = "Фірмова Шабля Ксай'рата", fen = "A coveted broker's blade... What was that noise?", fua = "Жадана клинок посередника... Що це був за звук?" }
    t[190008] = "Мачете Просвітленого Ботаніка"
    t[190009] = "Молот Розтрощених Творінь"
    t[190045] = "Плинний Посох Піскоплава"
    t[190046] = "Крадена Тростина Маклера"
    t[190047] = "Посох Наверненого Посередника"
    t[190048] = "Наймудріше Ікло Вексіс"
    t[190049] = "Незмінний Пробійний Кинджал"
    t[190050] = "Різак Ентропійного Маклера"
    t[190051] = "Розкішний Посох Старійшини"
    t[190052] = "Ніж для Листів Ксай'рата"
    t[190053] = "Арбалет Підземного Кружляльника"
    t[190054] = "Арбалет з Гранчастим Загостренням"
    t[190055] = "Знаряддя Злиття Енергій"
    t[190056] = "Ліхтар Просвітленого Дослідника"
    t[190057] = "Крило-Глефа Захисної Раптори"
    t[190058] = "Мирний Покопок"
    t[190059] = "Піратський Покопок"
    t[190060] = "Завзята Пококо"
    t[190061] = "Адмірал Пококо"
    t[190062] = "Лукавий Покопок"
    t[190096] = "Покобольд"
    t[190098] = "Пепепек"
    t[190102] = "Ланцюги Заразливих Зазубнів"
    t[190103] = "Стовп Отруйного Поширення"
    t[190104] = "Духопроникач Влучного Стрільця"
    t[190105] = "Крижана Булава Панування"
    t[190106] = "Смолоскип Близького Жаху"
    t[190107] = "Посох Скинутих Тягарів"
    t[190108] = "Егіда Реготливих Душ"
    t[190109] = "Кий Кайданів Смертності"
    t[190110] = "Ціп Граційної Різанини"
    t[190111] = "Гербовий Щит Прекрасної Смерті"
    t[190112] = "Мерехтливий Бойовий Маяк"
    t[190124] = { name = "Лютий Кинджал Допитувачки", fen = "An ebb of pain..", fua = "Відлив болю.." }
    t[190125] = { name = "Кріс Заплутаних Таємниць", fen = "..A flow of stories.", fua = "..Потік оповідей." }
    t[190126] = "Загребущі Ножиці Гнилевідбирача"
    t[190127] = "Танцівлива Подвійна Коса Марзана"
    t[190128] = { name = "Норовлива Сутність", fen = "A rare proto-material", fua = "Рідкісний протоматеріал." }
    t[190129] = { name = "Безтурботний Пігмент", fen = "A rare proto-material", fua = "Рідкісний протоматеріал." }
    t[190172] = "Нагорода-Звання: Бігун Випробування"
    t[190177] = "Сфера Просвітлених Роздумів"
    t[190178] = { name = "Торбинка Протогенних Припасів", fen = "Contains an assortment of rare resources found in Zereth Mortis.", fua = "Містить добірку рідкісних ресурсів, знайдених у Зерет-Мортісі." }
    t[190182] = "Чарівний Величний Покопок"
    t[190184] = "Фіміам Нескінченності"
    t[190189] = { name = "Пісками Стерта Реліквія", fen = "A relic, thought lost to time. Acquired from certain enemies and chests in the Endless Sands. Trade these to Elder Rafiq in Pilgrim's Grace in exchange for powerful equipment.", fua = "Реліквія, що вважалася втраченою в часі. Здобувається з певних ворогів та скринь у Безкраїх Пісках. Обміняйте їх у Старійшини Рафіка в Ласці Прочанина на потужне спорядження." }
    t[190196] = "Камінь Повернення Просвітлених"
    t[190197] = { name = "Пісками Стертий Ключ від Скрині", fen = "Key to the Locked Sandworn Chest in Endless Sands, Zereth Mortis", fua = "Ключ до Замкненої Пісками Стертої Скрині в Безкраїх Пісках, Зерет-Мортіс." }
    t[190198] = "Уламок Ключа Піскошарпаної Скрині"
    t[190234] = { name = "Дослідження Порталів Просвітлених", fen = "Pages of thought droning on about the intricacies of hexagonal lattices, followed by pristine instructions to create wormholes within Zereth Mortis.", fua = "Сторінки розмірковувань, що монотонно гудуть про тонкощі шестикутних ґраток, а далі — бездоганні настанови зі створення червоточин у Зерет-Мортісі." }
    t[190235] = "Інертний Тріснутий Панцир"
    t[190236] = "Уламок Протолуски"
    t[190237] = "Посередницька Матриця Переміщення"
    t[190238] = { name = "Схованка-Пастка Ксай'рата", fen = "So tantalizing.. I must know what's inside!", fua = "Так спокусливо... Я мушу дізнатися, що всередині!" }
    t[190241] = "Запасне Вбрання Ксай'рата"
    t[190242] = { name = "Делікатес «Червоний Оксамит»", fen = "Xy'rath's taste for the color red goes beyond just finery.", fua = "Замилування Ксай'рата червоним кольором сягає далеко за межі вбрання." }
    t[190333] = "Коло Співу Джиро"
    t[190334] = "Витоки"
    t[190336] = { name = "Гудливий Камінь Сили", fen = "This stone pulses with faintly familiar energies. Can be disenchanted or sold.", fua = "Цей камінь пульсує ледь знайомими енергіями. Можна розчаклувати або продати." }
    t[190337] = "Душа Оленя"
    t[190339] = "Підношення Просвітлених"
    t[190341] = "Віщунська Блуза"
    t[190342] = "Віщунські Капці"
    t[190343] = "Віщунські Рукавиці"
    t[190344] = "Віщунський Каптур"
    t[190345] = "Пророчі Панталони"
    t[190346] = "Віщунський Оплічник"
    t[190347] = "Віщунський Пояс"
    t[190348] = "Віщунські Наручі"
    t[190349] = "Таємничий Жилет"
    t[190350] = "Таємничі Чоботи"
    t[190351] = "Таємничі Рукавиці"
    t[190352] = "Таємнича Маска"
    t[190353] = "Загадкові Штани"
    t[190354] = "Таємничі Наплічники"
    t[190355] = "Таємничий Поясок"
    t[190356] = "Таємничі Наручі"
    t[190357] = "Загадкова Кольчуга"
    t[190358] = "Загадкові Чоботи"
    t[190359] = "Загадкові Латні Рукавиці"
    t[190360] = "Загадковий Каптур"
    t[190361] = "Загадкові Поножі"
    t[190362] = "Загадкові Еполети"
    t[190363] = "Загадковий Ланцюг"
    t[190364] = "Загадкові Пов'язки"
    t[190365] = "Нагрудник Нумерус"
    t[190366] = "Латні Чоботи Нумерус"
    t[190367] = "Рукавиці Нумерус"
    t[190368] = "Вінець Нумерус"
    t[190369] = "Поножі Нумерус"
    t[190370] = "Наплічники Нумерус"
    t[190371] = "Пояс Нумерус"
    t[190372] = "Наручі Нумерус"
    t[190374] = { name = "Самоцвіт Призматичного Сяйва", fen = "One of the few relics left behind that the guardians sought to protect.", fua = "Одна з небагатьох уцілілих реліквій, які прагнули зберегти охоронці." }
    t[190378] = "Гліф Примарного Вовка"
    t[190379] = { name = "Техніка: Гліф Примарного Вовка", fen = "Teaches you how to craft a Glyph of the Spectral Lupine.", fua = "Навчає, як створити Гліф Примарного Вовка." }
    t[190380] = "Гліф Примарного Лиса"
    t[190381] = { name = "Техніка: Гліф Примарного Лиса", fen = "Teaches you how to craft a Glyph of the Spectral Vulpine.", fua = "Навчає, як створити Гліф Примарного Лиса." }
    t[190382] = { name = "Викривлений Кишеньковий Вимір", fen = "No matter how far you reach, the only thing you find within the bag is itself.", fua = "Хоч як глибоко занурюй руку, єдине, що знайдеш у торбі, — це вона сама." }
    t[190387] = "Канали Задарма"
    t[190388] = { name = "Вовча Ґратниця", fen = "A mystical lattice used to synthesize a lupine.", fua = "Містична ґратниця, що слугує для синтезу вовка." }
    t[190389] = { name = "Щаслива Монета Посередника", fen = "Good luck!", fua = "Щасти!" }
    t[190390] = "Розсіювальне Знаряддя Захисника"
    t[190457] = { name = "Протопологічний Куб", fen = "So this is what abstract feels like.", fua = "То ось яка вона на дотик, ця абстракція." }
    t[190458] = "Зловісний Оплот Атрофії"
    t[190459] = "Холодна Гнітюча Барикада"
    t[190460] = "Серп Верховного Грабіжника"
    t[190461] = "Звабливий Жезл Оживлювача"
    t[190462] = "Граційний Спис Настромлювача"
    t[190463] = "Глефа Похмурого Містика"
    t[190464] = "Пояс Єдності"
    t[190465] = "Пояс Єдності"
    t[190466] = "Застібка Єдності"
    t[190467] = "Пояс Єдності"
    t[190468] = "Пояс Єдності"
    t[190469] = "Пояс Єдності"
    t[190470] = "Пояс Єдності"
    t[190471] = "Пояс Єдності"
    t[190472] = "Пояс Єдності"
    t[190473] = "Застібка Єдності"
    t[190474] = "Пояс Єдності"
    t[190475] = "Пояс Єдності"
    t[190579] = { name = "Несформована Сутність", fen = "An unusual material that glimmers with untapped potential.", fua = "Незвичний матеріал, що мерехтить нерозкритим потенціалом." }
    t[190580] = { name = "Серцевірний Вовчик", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[190582] = "Символ Вомбатів"
    t[190584] = "Спогад про Єдність"
    t[190585] = "Креслення: Серцезв'язаний Лупин"
    t[190587] = "Спогад про Єдність"
    t[190588] = "Спогад про Єдність"
    t[190589] = "Спогад про Єдність"
    t[190590] = "Спогад про Єдність"
    t[190591] = "Спогад про Єдність"
    t[190592] = "Спогад про Єдність"
    t[190593] = "Спогад про Єдність"
    t[190594] = "Спогад про Єдність"
    t[190595] = "Спогад про Єдність"
    t[190596] = "Спогад про Єдність"
    t[190597] = "Символ Лупінів"
    t[190598] = "Спогад про Єдність"
    t[190601] = { name = "Сонько", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[190602] = "Символ Рапторів"
    t[190605] = "Неймовірно Стародавній Плащ"
    t[190610] = { name = "Данина Просвітлених Старійшин", fen = "This chest contains valuable equipment and resources that have been gathered by the elders of the Enlightened.", fua = "Ця скриня містить цінне спорядження та ресурси, зібрані старійшинами Просвітлених." }
    t[190611] = "Накидка Просвітлених"
    t[190614] = "Довірений Бацинет Антроса"
    t[190615] = "Панцир Космічного Вартового"
    t[190616] = "Застібка Контрольованої Послідовності"
    t[190617] = "Рукавиці для Ядра Руйнування"
    t[190618] = "Ґратка Далекого Хранителя"
    t[190619] = "Крилоподібні Бігові Чоботи Першопочатку"
    t[190620] = "Згубний Тантур Сав'тула"
    t[190621] = "Деалічні Захисні Панчохи"
    t[190624] = "Латні Рукавиці Кінця"
    t[190625] = "Наплічники Можливих Загробних Життів"
    t[190626] = "Каптур Порожніх Вічностей"
    t[190627] = "Поножі Підривного Володаря"
    t[190628] = "Синтетичний Головний Убір Люпіна"
    t[190629] = "Злодійські Носаки Картелю"
    t[190630] = "Плівчасті Наплічники Пожирання"
    t[190631] = "Рукавиці Сплюндрованих Ефемер"
    t[190632] = "Перстень з Гравіруванням Шифру"
    t[190633] = "Перстень з Гравіруванням Шифру"
    t[190634] = "Шийна Гривня з Гравіруванням Шифру"
    t[190635] = "Підвіска з Гравіруванням Шифру"
    t[190637] = "Інструмент Ударного Ремонту"
    t[190638] = "Стражденний Дворучний Меч із Пащесталі"
    t[190640] = "Джерело Ефемерної Сили"
    t[190641] = "Божественний Дзвін Наставника"
    t[190644] = "Посудина Глибоких Можливостей"
    t[190652] = "Цокотливий Мішок Жаху"
    t[190654] = { name = "Сховок Скарбів Гробниці", fen = "Rewards a piece of equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження для вашої спеціалізації здобичі." }
    t[190655] = { name = "Сховок Скарбів Гробниці", fen = "Rewards a piece of equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження для вашої спеціалізації здобичі." }
    t[190656] = { name = "Сховок Скарбів Гробниці", fen = "Rewards a piece of equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження для вашої спеціалізації здобичі." }
    t[190658] = "Резонансний Плинний Сфероїд Павутиння"
    t[190659] = "Резонансний Плинний Сфероїд Панцира"
    t[190660] = "Резонансний Плинний Сфероїд Слизу"
    t[190661] = "Резонансний Плинний Сфероїд Відродження"
    t[190726] = "Витяжка Дивовижних Пісків"
    t[190729] = "Печатка Енергійного Вартового"
    t[190730] = "Перстень з Панцира Матріарха"
    t[190731] = "Ілюзорний Перстень-Печатка Облудника"
    t[190732] = "Низка Опоганених Реліквій"
    t[190733] = "Коло Аккаріса"
    t[190734] = { name = "Торба з Мінами Макаріса", fen = "A bag of mawsworn explosives.", fua = "Торба з вибухівкою зв'язаних Пащею." }
    t[190735] = "Гільйотина Варрута"
    t[190739] = { name = "Віск Провіс", fen = "Give yourself a newly created glow.", fua = "Подаруй собі новостворене сяйво." }
    t[190741] = "Посередницька Зброя"
    t[190742] = "Вимірні Таємничі Чоботи"
    t[190743] = "Відтворчі Таємничі Чоботи"
    t[190744] = "Часові Загадкові Чоботи"
    t[190745] = "Вимірні Числові Рукавиці"
    t[190746] = "Відтворчі Численні Рукавиці"
    t[190747] = "Часові Нумерус-Рукавиці"
    t[190748] = "Вимірні Загадкові Рукавиці"
    t[190749] = "Часові Загадкові Рукавиці"
    t[190750] = "Відтворчі Загадкові Рукавиці"
    t[190751] = "Вимірні Віщі Наручі"
    t[190752] = "Відтворчі Віщі Наручі"
    t[190753] = "Часові Пророчі Наручі"
    t[190754] = { name = "Контейнер для Зразків Фіріма", fen = "Contains an unusual wildlife specimen collected for research.", fua = "Містить незвичайний зразок дикої фауни, зібраний для дослідження." }
    t[190755] = "Посередницькі Наплічники"
    t[190756] = "Посередницькі Поножі"
    t[190757] = "Посередницький Шолом"
    t[190758] = "Посередницькі Рукавички"
    t[190759] = "Посередницький Плащ"
    t[190760] = "Посередницький Нагрудник"
    t[190761] = "Посередницькі Наручі"
    t[190762] = "Посередницькі Чоботи"
    t[190763] = "Посередницький Пояс"
    t[190764] = "Посередницький Перстень"
    t[190768] = { name = "Фрактальний Шифр Зеретського Наглядача", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[190769] = { name = "Нестабільна аркана", fen = "Unstable arcana condensed into a gem. Looks ready to explode at any moment... so don't shake it around too much.", fua = "Нестабільна таємна магія, згущена в самоцвіт. Здається, ось-ось вибухне... тож не дуже ним трясіть." }
    t[190771] = { name = "Фрактальний Шифр Карцинізованого Зерет-Скакуна", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[190773] = { name = "Відлуння Альманаху", fen = "A strange, stirring melody is woven into the mechanics of this device.", fua = "Дивна, бентежна мелодія вплетена в механізм цього пристрою." }
    t[190823] = { name = "Загадковий Сховок Фіріма", fen = "What could this mysterious cache possibly contain?", fua = "Що ж може ховатися в цьому загадковому сховку?" }
    t[190852] = { name = "Веспоїдний Мед", fen = "Sweet, crunchy, but smells awful.", fua = "Солодкий, хрусткий, але смердить жахливо." }
    t[190853] = "Жменя Таємничих Плодів"
    t[190880] = { name = "Каталізований Яблучний Пиріг", fen = "Made from locally grown apples.", fua = "Зроблений із місцевих яблук." }
    t[190881] = { name = "Коло Прожитку", fen = "Stands the test of time...uneaten.", fua = "Витримує випробування часом... недоїдене." }
    t[190926] = "Заражене Ядро Автома"
    t[190927] = { name = "Припаси Просвітлених", fen = "Useful items to aid Haven in its efforts.", fua = "Корисні речі на допомогу Притулку в його зусиллях." }
    t[190928] = "Плащ Піщаних Хвостів"
    t[190929] = "Чорний Протоплащ"
    t[190930] = "Темна Шаль Просвітлених"
    t[190931] = "Плащ Царственого Мандрівника"
    t[190932] = "Плащ із Протошкіри"
    t[190933] = "Накидка Величного Оракула"
    t[190934] = "Штандарт мандрівних посередників"
    t[190935] = { name = "Шанований Клинок Картелю Ал", fen = "The Enlightened put aside more than past ambitions when they devoted all to their research of Zereth Mortis.", fua = "Просвітлені відклали не лише минулі амбіції, коли віддали все дослідженню Зерет-Мортіса." }
    t[190936] = { name = "Відновлювальний Потік", fen = "Crisp, refreshing, and nearly impalpable.", fua = "Свіжий, бадьорий і майже невідчутний." }
    t[190937] = { name = "Лезо Просвітлених", fen = "Enlightenment extends so far in a hostile environment.", fua = "Ось як далеко сягає просвітлення у ворожих землях." }
    t[190939] = "Дорожній Посох Просвітленої Подорожі"
    t[190940] = { name = "Дослідницькі Нотатки Фіріма", fen = "Written in an almost illegible scrawl.", fua = "Написані майже нерозбірливими карлючками." }
    t[190941] = "Вчення Старійшин"
    t[190942] = "Видобувач Протомінералів"
    t[190943] = "Налаштувальний Молот Джиро"
    t[190944] = "Булава Оновленої Мети"
    t[190945] = "Дворучний Молот Прадавніх Вартових"
    t[190946] = "Прамолот Смарагдового Серця"
    t[190947] = "Посох-Німб Оракулів"
    t[190948] = "Посох сплячого оракула"
    t[190949] = "Посох вічного циклу"
    t[190950] = "Молот Втраченої Мети"
    t[190951] = "Шанований Клинок Картелю Ал"
    t[190952] = "Збирач Протофлори"
    t[190953] = "М'якоть Протофрукта"
    t[190955] = { name = "Протоплазмова Нитка", fen = "Constantly shifting, as if seeking a stable form.", fua = "Постійно змінюється, наче шукає сталу форму." }
    t[190956] = "Графин Нерозкритого Потенціалу"
    t[190958] = { name = "Таємна Техніка Со'леї", fen = "Lead with an open hand, not a closed fist.", fua = "Веди відкритою долонею, а не стиснутим кулаком." }
    t[190959] = { name = "Уламок Журботи", fen = "A fragment taken from Anduin's blade in the Sepulcher of the First Ones on Mythic Difficulty.", fua = "Уламок, відколотий від клинка Андуїна в Усипальниці Першоджерел на Міфічному рівні складності." }
    t[190966] = { name = "Уламок Журботи", fen = "A fragment taken from Anduin's blade in the Sepulcher of the First Ones on Heroic Difficulty.", fua = "Уламок, відбитий від клинка Андуїна в Гробниці Прабатьків на героїчній складності." }
    t[190967] = { name = "Уламок Журботи", fen = "A fragment taken from Anduin's blade in the Sepulcher of the First Ones on Normal Difficulty.", fua = "Уламок, відбитий від клинка Андуїна в Гробниці Прабатьків на звичайній складності." }
    t[190968] = { name = "Звіт із Полів Генезису", fen = "A shorthand report detailing the presence of devourers in the Genesis Fields.", fua = "Стислий звіт про присутність пожирачів на Полях Генезису." }
    t[190969] = { name = "Звіт із Провіс Флори", fen = "A shorthand report detailing the presence of Mawsworn in Provis Flora.", fua = "Стислий звіт про присутність зв'язаних Пащею у Провіс Флорі." }
    t[190970] = { name = "Звіт із Блаженного Гаю", fen = "A shorthand report detailing the presence of cartel Xy agents in the Felicitous Glade.", fua = "Стислий звіт про присутність агентів картелю Ксай у Блаженному Гаю." }
    t[190971] = { name = "Звіт із Тераси Формування", fen = "A shorthand report detailing the presence of small unusual humanoids.", fua = "Стислий звіт про присутність дрібних незвичайних гуманоїдів." }
    t[190976] = { name = "Пахощі Просвітлених", fen = "Incense used by the Enlightened in their rituals for the First Ones.", fua = "Пахощі, які Просвітлені використовують у ритуалах для Першоджерел." }
    t[190977] = "Очисна Віща Сорочка"
    t[190978] = "Віщунська Блуза Нова"
    t[190979] = "Кристалічна Віщунська Роба"
    t[190980] = "Емпатичний Віщунський Оплічник"
    t[190981] = "Віщунський Посередницький Оплічник"
    t[190982] = "Синхронний Пророчий Оплічник"
    t[190983] = "Очисна Загадкова Маска"
    t[190984] = "Загадкова Маска Нова"
    t[190985] = "Кристалічна Таємнича Маска"
    t[190986] = "Емпатичні Криптичні Наплічники"
    t[190987] = "Загадкові Посередницькі Наплічники"
    t[190988] = "Синхронні Загадкові Наплічники"
    t[190989] = "Очисні Таємничі Еполети"
    t[190990] = "Загадкові Еполети Нова"
    t[190991] = "Кристалічні Загадкові Еполети"
    t[190992] = "Емпатичний Загадковий Каптур"
    t[190993] = "Таємничий Посередницький Каптур"
    t[190994] = "Синхронний Загадковий Каптур"
    t[190995] = "Очисний Числовий Вінець"
    t[190996] = "Вінець Нова Нумерус"
    t[190997] = "Кристалічний Числовий Вінець"
    t[190998] = "Емпатичний Нагрудник Нумерус"
    t[190999] = "Посередницький Нумерусний Нагрудник"
    t[191000] = "Синхронний Нумерус-Нагрудник"
    t[191001] = "Тіньова Заточка Спостерігача"
    t[191002] = "Містичний Модуль Шолома"
    t[191003] = "Модуль Шанованого Шолома"
    t[191004] = "Зенітний Шоломний Модуль"
    t[191005] = "Жахливий Модуль Шолома"
    t[191006] = "Жахливий Модуль Плеча"
    t[191007] = "Містичний Наплічний Модуль"
    t[191008] = "Модуль Шанованих Наплічників"
    t[191009] = "Зенітний Наплічний Модуль"
    t[191010] = "Жахливий Нагрудний Модуль"
    t[191011] = "Містичний Нагрудний Модуль"
    t[191012] = "Шанований Нагрудний Модуль"
    t[191013] = "Зенітний Нагрудний Модуль"
    t[191014] = "Жахливий Ручний Модуль"
    t[191015] = "Містичний Ручний Модуль"
    t[191016] = "Шанований Ручний Модуль"
    t[191017] = "Зенітний Долонний Модуль"
    t[191018] = "Жахливий Модуль Ніг"
    t[191019] = "Містичний Ножний Модуль"
    t[191020] = "Модуль Шанованих Поножів"
    t[191021] = "Зенітний Ножний Модуль"
    t[191029] = { name = "Камінь Повернення Ліліан", fen = "Well-worn, made of a chunk of gravestone.", fua = "Добряче потертий, зроблений з уламка надгробка." }
    t[191030] = { name = "Пакунок Космічного Флюксу", fen = "Contains 500 Cosmic Flux", fua = "Містить 500 космічного флюксу." }
    t[191031] = { name = "Запакований Жар Душ", fen = "Sealed inside a crate, some of the cinders have flickered and lost their potency.", fua = "Запечатані в ящику, деякі жарини згасли й втратили свою силу." }
    t[191034] = "Лист до Греймейна"
    t[191036] = "Посередницький Аксесуар"
    t[191037] = "Посередницька Коса"
    t[191038] = { name = "Згорток Припасів", fen = "A small bundle of supplies. Cloth, wood, nails... an assortment of useful things.", fua = "Невеликий згорток припасів. Тканина, дерево, цвяхи... набір корисних речей." }
    t[191040] = { name = "Сховок Скарбів Гробниці", fen = "Rewards a piece of equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження для вашої спеціалізації здобичі." }
    t[191041] = { name = "Сховок Скарбів Гробниці", fen = "Rewards a piece of equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження для вашої спеціалізації здобичі." }
    t[191108] = "Підношення Тускарів"
    t[191123] = { name = "Лицеруб Грімхаула", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[191139] = { name = "Данина Просвітлених Старійшин", fen = "This chest contains valuable equipment and resources that have been gathered by the elders of the Enlightened.", fua = "Ця скриня містить цінне спорядження та ресурси, зібрані старійшинами Просвітлених." }
    t[191290] = { name = "Пожирач Душ Вічного Гладіатора", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[191296] = "Зачарована Скринька"
    t[191297] = "Насичена Ефемерою Сітка"
    t[191299] = "Данина Просвітленим"
    t[191300] = "Засвідчений Дозвіл"
    t[191301] = { name = "Трактат про Узори в Призначенні", fen = "Grants you 40 Cyphers of the First Ones.", fua = "Надає вам 40 шифрів Першонароджених." }
    t[191302] = { name = "Нічне Небо в Пляшці", fen = "Contains 25 Genesis Motes.", fua = "Містить 25 частинок генези." }
    t[191303] = { name = "Переповнена Скриня Багатств", fen = "This chest contains a substantial amount of gold.", fua = "Ця скриня містить чималу кількість золота." }
    t[191553] = "Шолом Відданості Лицаря Крові"
    t[191554] = "Пояс Відданості Лицаря Крові"
    t[191555] = "Поножі Відданості Лицаря Крові"
    t[191556] = "Нагрудник Відданості Лицаря Крові"
    t[191557] = "Латні Рукавиці Відданості Лицаря Крові"
    t[191558] = "Поножі Відданості Кривавого Лицаря"
    t[191559] = "Наплічні Пластини Відданості Лицаря Крові"
    t[191560] = "Наручі Відданості Лицаря Крові"
    t[191561] = "Плащ Відданості Лицаря Крові"
    t[191562] = "Накидка Відданості Лицаря Крові"
    t[191563] = "Мантія Відданості Лицаря Крові"
    t[191564] = "Оплічник Відданості Лицаря Крові"
    t[191565] = { name = "Комплект: Відданість Кривавого Лицаря", fen = "You have demonstrated cunning, determination, and integrity. Hallmarks of what it means to be a Blood Knight.", fua = "Ви виявили хитрість, рішучість і чесність. Ознаки того, що означає бути Кривавим Лицарем." }
    t[191566] = { name = "Невловний Смарагдовий Яструбоступ", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[191604] = "Рансер, торкнутий Завісою"
    t[191625] = "Моноліт Лавокузні"
    t[191626] = "Сікач Лавової Кузні"
    t[191631] = "Бастіон Лавокузні"
    t[191634] = "Спогад про Єдність"
    t[191635] = "Спогад про Єдність"
    t[191636] = "Спогад про Єдність"
    t[191637] = "Спогад про Єдність"
    t[191638] = "Спогад про Єдність"
    t[191639] = "Спогад про Єдність"
    t[191640] = "Спогад про Єдність"
    t[191641] = "Спогад про Єдність"
    t[191642] = "Спогад про Єдність"
    t[191643] = "Спогад про Єдність"
    t[191644] = "Спогад про Єдність"
    t[191645] = "Спогад про Єдність"
    t[191646] = { name = "Синьохвоста Верховодка", fen = "A particularly tasty fish found near Khuri's Fishing Spot.", fua = "Особливо смачна риба, що водиться біля Рибного Місця Хурі." }
    t[191648] = "Каптур Темного Слідопита"
    t[191649] = "Чоботи Темного Слідопита"
    t[191650] = "Нагрудник Темного Вартового"
    t[191651] = "Рукавички Темного Слідопита"
    t[191652] = "Поножі Темного Рейнджера"
    t[191653] = "Наплічники Темного Вартового"
    t[191654] = "Пояс Темного Слідопита"
    t[191655] = "Наручі Темного Вартового"
    t[191657] = "Плащ Темного Слідопита"
    t[191658] = "Комплект: Вбрання Темного Слідопита"
    t[191701] = { name = "Торба Досліджених Душ", fen = "This bag contains remnants of the lost from Torghast - enough Soul Ash and Soul Cinder for the Runecarver to craft a powerful legendary item.", fua = "Ця торба містить рештки загиблих із Торгасту — достатньо Попелу Душ і Жару Душ, щоб Карбувальник Рун створив могутній легендарний предмет." }
    t[191781] = "Залишок Пожирачів"
    t[191902] = { name = "Перстень Полеглого Захисника", fen = "An ancient horn ring worn by the dragons of the Obsidian Citadel.", fua = "Прадавній роговий перстень, який носили дракони Обсидіанової Цитаделі." }
    t[191908] = { name = "Ріг Скорксії", fen = "The remains of Scorxia, crafted into a djaradin warhorn.", fua = "Рештки Скорксії, виготовлені в бойовий ріг джарадинів." }
    t[191910] = "Спантеличливий Старовинний Шифр"
    t[191911] = { name = "Космічний Поштовх Творення", fen = "Even splinters of the Catalyst bid potential to manifest.", fua = "Навіть скалки каталізатора таять потенціал для прояву." }
    t[191926] = "Спантеличливий Прадавній Шифр"
    t[191927] = { name = "Священний Поштовх Творення", fen = "The Pattern revealed; all arrive at their destination.", fua = "Узор розкрито; усі досягають свого призначення." }
    t[191957] = "Рансер Полеглого Лицаря"
    t[192205] = "Престижний Плащ Вічного Гладіатора"
    t[192206] = "Гербова Накидка Вічного Гладіатора"
    t[192207] = "Келих Вічного Гладіатора"
    t[192208] = "Захист Вічного Гладіатора"
    t[192209] = "Плащ Вічного Гладіатора"
    t[192210] = "Накидка Вічного Гладіатора"
    t[192211] = "Шаль Вічного Гладіатора"
    t[192212] = "Великий Плащ Вічного Гладіатора"
    t[192213] = "Перстень Вічного Гладіатора"
    t[192214] = "Перстень Вічного Гладіатора"
    t[192215] = "Перстень-Печатка Вічного Гладіатора"
    t[192216] = "Намисто Вічного Гладіатора"
    t[192217] = "Підвіска Вічного Гладіатора"
    t[192218] = "Амулет Вічного Гладіатора"
    t[192219] = "Шовкова Роба Вічного Гладіатора"
    t[192220] = "Шовкове Вбрання Вічного Гладіатора"
    t[192221] = "Шовкові Капці Вічного Гладіатора"
    t[192222] = "Шовкові Чоботи Вічного Гладіатора"
    t[192223] = "Шовкові Рукавички Вічного Гладіатора"
    t[192224] = "Шовкові Рукавиці Вічного Гладіатора"
    t[192225] = "Шовковий Каптур-Капюшон Вічного Гладіатора"
    t[192226] = "Шовковий Каптур Вічного Гладіатора"
    t[192227] = "Шовкові Поножі Вічного Гладіатора"
    t[192228] = "Шовкові Штани Вічного Гладіатора"
    t[192229] = "Шовковий Оплічник-Накидка Вічного Гладіатора"
    t[192230] = "Шовковий Оплічник Вічного Гладіатора"
    t[192231] = "Шовковий Пояс-Шнур Вічного Гладіатора"
    t[192232] = "Шовковий Пояс Вічного Гладіатора"
    t[192233] = "Шовкові Напульсники Вічного Гладіатора"
    t[192234] = "Шовкові Нарукавники Вічного Гладіатора"
    t[192235] = "Шкіряний Жилет Вічного Гладіатора"
    t[192236] = "Шкіряний Камзол Вічного Гладіатора"
    t[192237] = "Шкіряні Чоботи Вічного Гладіатора"
    t[192238] = "Шкіряні Черевики Вічного Гладіатора"
    t[192239] = "Шкіряні Рукавиці Вічного Гладіатора"
    t[192240] = "Шкіряні Рукавички Вічного Гладіатора"
    t[192241] = "Шкіряний Шолом Вічного Гладіатора"
    t[192242] = "Шкіряна Маска Вічного Гладіатора"
    t[192243] = "Шкіряні Штани Вічного Гладіатора"
    t[192244] = "Шкіряні Поножі Вічного Гладіатора"
    t[192245] = "Шкіряні Оплічники Вічного Гладіатора"
    t[192246] = "Шкіряні Наплічники Вічного Гладіатора"
    t[192247] = "Шкіряний Пояс Вічного Гладіатора"
    t[192248] = "Шкіряний Ремінь Вічного Гладіатора"
    t[192249] = "Шкіряні Напульсники Вічного Гладіатора"
    t[192250] = "Шкіряні Наручі Вічного Гладіатора"
    t[192251] = "Кольчужний Жилет Вічного Гладіатора"
    t[192252] = "Кольчужна Туніка Вічного Гладіатора"
    t[192253] = "Кольчужні Сабатони Вічного Гладіатора"
    t[192254] = "Кольчужні Чоботи Вічного Гладіатора"
    t[192255] = "Кольчужні Рукавиці Вічного Гладіатора"
    t[192256] = "Кольчужні Рукавички Вічного Гладіатора"
    t[192257] = "Кольчужний Шолом Вічного Гладіатора"
    t[192258] = "Кольчужне Забрало Вічного Гладіатора"
    t[192259] = "Кольчужні Поножі Вічного Гладіатора"
    t[192260] = "Кольчужні Штани Вічного Гладіатора"
    t[192261] = "Кольчужні Оплічники Вічного Гладіатора"
    t[192262] = "Кольчужний Наплічний Захист Вічного Гладіатора"
    t[192263] = "Кольчужний Пояс Вічного Гладіатора"
    t[192264] = "Кольчужний Пояс Вічного Гладіатора"
    t[192265] = "Кольчужні Зап'ястки Вічного Гладіатора"
    t[192266] = "Кольчужні Наручі Вічного Гладіатора"
    t[192267] = "Латний Нагрудник Вічного Гладіатора"
    t[192268] = "Латний Нагрудник-Кіраса Вічного Гладіатора"
    t[192269] = "Латні Бойові Чоботи Вічного Гладіатора"
    t[192270] = "Латні Чоботи Вічного Гладіатора"
    t[192271] = "Латні Рукавиці Вічного Гладіатора"
    t[192272] = "Латні Рукавиці-Захисти Вічного Гладіатора"
    t[192273] = "Латний Шолом Вічного Гладіатора"
    t[192274] = "Латний Шолом-Каска Вічного Гладіатора"
    t[192275] = "Латні Поножі Вічного Гладіатора"
    t[192276] = "Латні Бойові Поножі Вічного Гладіатора"
    t[192277] = "Латні Наплічні Лати Вічного Гладіатора"
    t[192278] = "Латні Наплічники Вічного Гладіатора"
    t[192279] = "Латний Пояс Вічного Гладіатора"
    t[192280] = "Латний Широкий Пояс Вічного Гладіатора"
    t[192281] = "Латні Наручні Захисти Вічного Гладіатора"
    t[192282] = "Латні Наручі Вічного Гладіатора"
    t[192283] = "Розрубувач Вічного Гладіатора"
    t[192284] = "Тесак Вічного Гладіатора"
    t[192285] = "Ніж Вічного Гладіатора"
    t[192286] = "Ритуальний Кинджал Вічного Гладіатора"
    t[192287] = "Гладіус Вічного Гладіатора"
    t[192288] = "Церемоніальний Меч Вічного Гладіатора"
    t[192289] = "Ксифос Вічного Гладіатора"
    t[192290] = "Бойова Глефа Вічного Гладіатора"
    t[192291] = "Подрібнювач Вічного Гладіатора"
    t[192292] = "Баліста Вічного Гладіатора"
    t[192293] = "Коса Вічного Гладіатора"
    t[192294] = "Вечірній Дзвін Вічного Гладіатора"
    t[192295] = "Значок Лютості Вічного Гладіатора"
    t[192296] = "Відзнака Завзятості Вічного Гладіатора"
    t[192297] = "Емблема Вічного Гладіатора"
    t[192298] = "Медальйон Вічного Гладіатора"
    t[192299] = "Невблаганна Брошка Вічного Гладіатора"
    t[192300] = "Сигіл Пристосування Вічного Гладіатора"
    t[192301] = "Прискіплива Рішучість Вічного Гладіатора"
    t[192302] = "Відлунна Рішучість Вічного Гладіатора"
    t[192303] = "Резонатор Вічного Гладіатора"
    t[192304] = "Вічна Егіда Вічного Гладіатора"
    t[192305] = "Пожирне Прокляття Вічного Гладіатора"
    t[192306] = "Бар'єр Вічного Гладіатора"
    t[192307] = "Гвинтівка Вічного Гладіатора"
    t[192308] = "Дворучний Меч Вічного Гладіатора"
    t[192309] = "Фокусувальний Посох Вічного Гладіатора"
    t[192310] = "Великий Посох Вічного Гладіатора"
    t[192311] = "Молоток Вічного Гладіатора"
    t[192312] = "Різак Вічного Гладіатора"
    t[192313] = "Стругач Вічного Гладіатора"
    t[192318] = "Латний Шолом Вічного Претендента"
    t[192319] = "Плащ Вічного Претендента"
    t[192320] = "Шовкова Туніка Вічного Претендента"
    t[192321] = "Латний Нагрудник Вічного Претендента"
    t[192322] = "Кольчужний Нагрудник Вічного Претендента"
    t[192323] = "Шкіряний Жилет Вічного Претендента"
    t[192324] = "Латні Бойові Чоботи Вічного Претендента"
    t[192325] = "Шовкові Черевики Вічного Претендента"
    t[192326] = "Кольчужні Сабатони Вічного Претендента"
    t[192327] = "Шкіряні Чоботи Вічного Претендента"
    t[192328] = "Шкіряні Рукавиці Вічного Претендента"
    t[192329] = "Латні Рукавиці Вічного Претендента"
    t[192330] = "Шовкові Рукавиці Вічного Претендента"
    t[192331] = "Кольчужні Латні Рукавиці Вічного Претендента"
    t[192332] = "Шовковий Каптур Вічного Претендента"
    t[192333] = "Кольчужний Шолом Вічного Претендента"
    t[192334] = "Шкіряний Шолом Вічного Претендента"
    t[192335] = "Латні Поножі Вічного Претендента"
    t[192336] = "Шовкові Поножі Вічного Претендента"
    t[192337] = "Кольчужні Поножі Вічного Претендента"
    t[192338] = "Шкіряні Штани Вічного Претендента"
    t[192339] = "Шкіряні Оплічники Вічного Претендента"
    t[192340] = "Латні Оплічники Вічного Претендента"
    t[192341] = "Шовкова Мантія Вічного Претендента"
    t[192342] = "Кольчужні Наплічники Вічного Претендента"
    t[192343] = "Латний Пояс Вічного Претендента"
    t[192344] = "Шовковий Шнур Вічного Претендента"
    t[192345] = "Кольчужний Пояс Вічного Претендента"
    t[192346] = "Шкіряний Пояс Вічного Претендента"
    t[192347] = "Перстень Вічного Претендента"
    t[192348] = "Шовкові Наручні Пов'язки Вічного Претендента"
    t[192349] = "Латні Манжети Вічного Претендента"
    t[192350] = "Кольчужні Напульсники Вічного Претендента"
    t[192351] = "Шкіряні Наручні Пов'язки Вічного Претендента"
    t[192352] = "Значок Лютості Вічного Претендента"
    t[192353] = "Намисто Вічного Претендента"
    t[192354] = "Латний Наголовник Вічного Претендента"
    t[192355] = "Накидка Вічного Претендента"
    t[192356] = "Шовковий Жилет Вічного Претендента"
    t[192357] = "Латна Броня Вічного Претендента"
    t[192358] = "Кольчужна Туніка Вічного Претендента"
    t[192359] = "Шкіряна Туніка Вічного Претендента"
    t[192360] = "Латні Чоботи Вічного Претендента"
    t[192361] = "Шовкові Онучі Вічного Претендента"
    t[192362] = "Кольчужні Чоботи Вічного Претендента"
    t[192363] = "Шкіряні Чоботи Вічного Претендента"
    t[192364] = "Шкіряні Рукавички Вічного Претендента"
    t[192365] = "Латні Рукавички Вічного Претендента"
    t[192366] = "Шовкові Ручні Пов'язки Вічного Претендента"
    t[192367] = "Кольчужні Рукавиці Вічного Претендента"
    t[192368] = "Шовковий Головний Убір Вічного Претендента"
    t[192369] = "Кольчужний Наголовник Вічного Претендента"
    t[192370] = "Шкіряна Маска Вічного Претендента"
    t[192371] = "Латні Бойові Поножі Вічного Претендента"
    t[192372] = "Шовкові Онучі Вічного Претендента"
    t[192373] = "Кольчужні Бойові Поножі Вічного Претендента"
    t[192374] = "Шкіряні Поножі Вічного Претендента"
    t[192375] = "Шкіряна Мантія Вічного Претендента"
    t[192376] = "Латні Наплічники Вічного Претендента"
    t[192377] = "Шовкова Шаль Вічного Претендента"
    t[192378] = "Кольчужні Наплічники Вічного Претендента"
    t[192379] = "Латний Широкий Пояс Вічного Претендента"
    t[192380] = "Шовковий Пояс Вічного Претендента"
    t[192381] = "Кольчужна Застібка Вічного Претендента"
    t[192382] = "Шкіряний Пояс-Шнур Вічного Претендента"
    t[192383] = "Перстень Вічного Претендента"
    t[192384] = "Шовкові Пов'язки Вічного Претендента"
    t[192385] = "Латні Наручі Вічного Претендента"
    t[192386] = "Кольчужні Наручі Вічного Претендента"
    t[192387] = "Шкіряні Наручі Вічного Претендента"
    t[192388] = "Відзнака Завзятості Вічного Претендента"
    t[192389] = "Намисто Вічного Претендента"
    t[192390] = "Плащ Вічного Претендента"
    t[192391] = "Печатка Вічного Претендента"
    t[192392] = "Емблема Вічного Претендента"
    t[192393] = "Підвіска Вічного Претендента"
    t[192394] = "Бойова Сокира Вічного Претендента"
    t[192395] = "Кинджал Вічного Претендента"
    t[192396] = "Булава Вічного Претендента"
    t[192397] = "Древкова Зброя Вічного Претендента"
    t[192398] = "Посох Вічного Претендента"
    t[192399] = "Меч Вічного Претендента"
    t[192400] = "Дворучна Сокира Вічного Претендента"
    t[192401] = "Дворучний Меч Вічного Претендента"
    t[192402] = "Сфера Вічного Претендента"
    t[192403] = "Бойова Глефа Вічного Претендента"
    t[192404] = "Молоток Вічного Претендента"
    t[192405] = "Бар'єр Вічного Претендента"
    t[192406] = "Топірець Вічного Претендента"
    t[192407] = "Рекурсивний лук вічного претендента"
    t[192408] = "Довгий Спис Вічного Претендента"
    t[192409] = "Клинок Вічного Претендента"
    t[192410] = "Кийок Вічного Претендента"
    t[192411] = "Серп Вічного Претендента"
    t[192412] = "Медальйон Вічного Претендента"
    t[192413] = "Невблаганна Брошка Вічного Претендента"
    t[192414] = "Сигіл Пристосування Вічного Претендента"
    t[192422] = "Гармоніумний Ліхтар"
    t[192423] = "Серенадний Арбалет"
    t[192424] = "Рапсодичний Тесак"
    t[192425] = "Молот Легато"
    t[192426] = "Вальсуюча Глефа"
    t[192427] = "Чароклинок Сенза"
    t[192428] = "Щит Балади"
    t[192429] = "Скіпетр Реквієму"
    t[192430] = "Меч Мено"
    t[192437] = { name = "Сховок Доленосних Скарбів", fen = "Rewards a piece of equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження для вашої спеціалізації здобичі." }
    t[192438] = { name = "Сховок Доленосних Скарбів", fen = "Rewards a piece of equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження для вашої спеціалізації здобичі." }
    t[192440] = "Ритмічний Трощитель"
    t[192444] = "Резонувальний Диск"
    t[192449] = "Колій Увертюри"
    t[192450] = "Хоровий Посох"
    t[192451] = "Скорботний Клинок"
    t[192456] = "Моноліт Лавокузні"
    t[192466] = { name = "Загадковий Динар Картелю", fen = "A coin of remarkable design, mysteriously obtained...", fua = "Монета визначної роботи, здобута загадковим чином..." }
    t[192478] = { name = "Стихійний Фокус", fen = "This gem hums with focused elemental energy. It seems to seek more.", fua = "Цей самоцвіт гуде зосередженою стихійною енергією. Здається, він прагне більшого." }
    t[192479] = { name = "Стихійний Фокус", fen = "This gem hums with focused elemental energy. It seems to seek more.", fua = "Цей самоцвіт гуде зосередженою стихійною енергією. Здається, він прагне більшого." }
    t[192485] = { name = "Пристрій Збереженої Мудрості", fen = "Contains the sage wisdom and rules of the notorious Ve'nari.", fua = "Містить мудрі поради та правила сумнозвісної Ве'нарі." }
    t[192547] = { name = "Садове Насіння", fen = "Freshly-collected lasher seed. Bring to a Sister of the Garden for replanting.", fua = "Свіжозібране насіння батожника. Віднесіть Сестрі Саду для пересадки." }
    t[192548] = { name = "Попелястоскалкове Вугілля", fen = "A pristine piece of Cindershard Coal.", fua = "Бездоганний шматок попелястоскалкового вугілля." }
    t[192557] = { name = "Смертоступ Відновлення", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[193221] = { name = "Нестійкий Морозовогонь", fen = "Both cold and hot to the touch. Good for melting ice without harming what's within.", fua = "Холодний і гарячий водночас на дотик. Добре розтоплює лід, не шкодячи тому, що всередині." }
    t[193874] = { name = "Креслення Каляші", fen = "Battle plans written in an ancient script.", fua = "Бойові плани, написані стародавнім письмом." }
    t[194105] = { name = "Суміш для Дракончиків", fen = "Specially made to help whelplings grow into strong, healthy drakes.", fua = "Виготовлена спеціально, щоб допомогти дракончикам вирости в сильних і здорових драків." }
    t[194118] = "Скриня Космічного Спорядження"
    t[194334] = "Скриня з Зашифрованим Спорядженням"
    t[194512] = { name = "Зламаний Магічний Пристрій", fen = "Some arcane magic still sparks out of this piece of the device.", fua = "З цього уламка пристрою досі вибиваються іскри чародійської магії." }
    t[194513] = { name = "Збірка Фоліантів", fen = "These tomes detail the history of what Camp Antonidas once was 10,000 years ago.", fua = "Ці фоліанти докладно описують історію того, чим був Табір Антонідаса 10 000 років тому." }
    t[194514] = { name = "Застарілий Список Гостей", fen = "This old tome has the names of dragons who frequented this area. Two names are on almost every page: Malygos and Sindragosa.", fua = "У цьому давньому фоліанті записано імена драконів, які бували в цьому краю. Два імені трапляються майже на кожній сторінці: Малігос і Синдрагоса." }
    t[194515] = { name = "Зотлілий Календар Подій", fen = "This book details various events that were held in this area. All of them seemed to involve displays of arcana to show other dragonflights and aspects.", fua = "Ця книга докладно описує різні події, що відбувалися в цьому краю. Усі вони, схоже, включали демонстрації чародійства перед іншими зграями драконів та аспектами." }
    t[194516] = { name = "Старий Щоденник", fen = "These pages have details about the courtship between two blue dragons, Malygos and Sindragosa. One note indicates this is, \"part one of a series\".", fua = "На цих сторінках описано залицяння двох синіх драконів, Малігоса й Синдрагоси. Одна примітка вказує, що це «частина перша з серії»." }
    t[194517] = { name = "Уривчасті Тексти", fen = "This book details the drakonid and dragonspawn that looked after this area after the blue dragons left. Many pages lament about the \"cheer\" being gone with the absence of Sindragosa and Malygos.", fua = "Ця книга докладно описує драконідів і драконячий виплід, що дбали про цей край після того, як сині дракони пішли. Багато сторінок журяться, що разом із Синдрагосою та Малігосом зникла й \"радість\"." }
    t[194544] = { name = "Полум'яний Клинок Хранителя Землі", fen = "A powerful weapon once wielded by dragonkin in battle.", fua = "Могутня зброя, якою колись у битві орудували драконороджені." }
    t[194546] = { name = "Звіт Баскілана", fen = "Observations detailing the djaradin's harvesting of Hornspike meat.", fua = "Спостереження, що детально описують, як джарадини заготовляють м'ясо рогошипа." }
    t[194559] = { name = "Звіт Вазаллії", fen = "A map showing the leading edge of the djaradin controlled lava flow.", fua = "Мапа, що показує передовий край лавового потоку під владою джарадинів." }
    t[194561] = { name = "Звіт Зефаріона", fen = "A report detailing the number of djaradin encamped at Dragonbane Keep.", fua = "Звіт, що докладно описує кількість джарадинів, які отаборилися біля Фортеці Драконоборця." }
    t[194707] = { name = "Звіт Міридіана", fen = "Observations detailing the movements of the Worldbreaker clan.", fua = "Спостереження, що докладно описують пересування клану Світоламів." }
    t[194713] = { name = "Звіт Зефаріона", fen = "A report detailing the dangers of the Flayscale Camp.", fua = "Звіт із докладним описом небезпек табору Шкуролуски." }
    t[194716] = { name = "Звіт Еворіана", fen = "A report detailing the safety of the western coastline.", fua = "Звіт, що докладно описує безпеку західного узбережжя." }
    t[194899] = { name = "Чарівна Паличка Розвіювання", fen = "This wand was specially developed by the Kirin Tor for their excursion to the Azure Span. It can dispel small fields of unstable arcane energy.", fua = "Цю паличку Кірін-Тор створив спеціально для своєї експедиції до Лазурового Хребта. Вона здатна розвіювати невеликі поля нестабільної магічної енергії." }
    t[194971] = { name = "Кристалізований Дракконій", fen = "Crystalized Draconium, formed under great pressure.", fua = "Кристалізований дракконій, утворений під величезним тиском." }
    t[196440] = { name = "Драконячий Політ", fen = "An assortment of alcoholic drinks of various colors.", fua = "Набір алкогольних напоїв різних кольорів." }
    t[198449] = { name = "Кисет Дивовижних Чудес", fen = "The Enlightened carry these pouches while wandering Zereth Mortis, believing the practice brings them closer to the First Ones.", fua = "Просвітлені носять ці кисети, мандруючи Зеретом Мортісом, бо вірять, що цей звичай наближає їх до Першоджерел." }
    t[198563] = { name = "Таємна Іскра", fen = "A small spark of leftover arcane magic. Venthi from the Cobalt Assembly would know how to put this to good use.", fua = "Маленька іскра залишкової таємної магії. Венті з Кобальтового Зібрання знатиме, як її як слід використати." }
    t[198603] = { name = "Таємна Руна", fen = "A stabilized arcane rune that emits a low hum. Venthi from the Cobalt Assembly would know how to put this to good use.", fua = "Стабілізована таємна руна, що тихо гуде. Венті з Кобальтової асамблеї знала б, як пустити її до діла." }
    t[198604] = { name = "Таємний Самоцвіт", fen = "A gem brimming with arcane power. Venthi from the Cobalt Assembly would know how to put this to good use.", fua = "Самоцвіт, налитий таємною силою. Венті з Кобальтового Зібрання знатиме, як його як слід використати." }
    t[198677] = "jrz test vellum quality 1 [DNT]"
    t[198678] = "jrz test vellum quality 2 [DNT]"
    t[198679] = "jrz test vellum quality 3 [DNT]"
    t[199112] = "Фракталізатор Приреченої Матерії"
    t[199181] = "Вістря Покутної Сталі"
    t[199182] = "Розколотий Зір Душі"
    t[199183] = "Руків'я Приреченої Королеви"
    t[199202] = "Жетон Заслуги Прислужника"
    t[199381] = "Печатка Стихійних Лих"
    t[199382] = "Перстень-Печатка Катастрофи"
    t[199383] = "Гривна Лих"
    t[199453] = "Іскра Дикості"
    t[199454] = "Бронзове Прискорення"
    t[199455] = "Потужне Пробудження"
    t[199456] = "Величне Благословення"
    t[199457] = "Коло Життя"
    t[199458] = "Вроджений Опір"
    t[199459] = "Первісна Стійкість"
    t[199460] = "Граційний Крок"
    t[199461] = "Спадок Колдарри"
    t[199462] = "Природна Зброя"
    t[199551] = "Застібка Єдності"
    t[199552] = "Спогад про Єдність"
    t[199553] = "Спогад про Єдність"
    t[199555] = "Універсальна Штормова Принада"
    t[199645] = "Відзнака Мисливця на Бурі"
    t[200220] = { name = "Заморожений Хвостоплав", fen = "A fish that's quite chewy. It's an acquired taste. Supposedly.", fua = "Доволі жорстка риба. Смак на любителя. Нібито." }
    t[200225] = { name = "Скалка Великого Посоха", fen = "A shard taken from Broodkeeper Diurna's greatstaff in Vault of the Incarnates on Normal Difficulty.", fua = "Скалка, взята з великого посоха Хранительки Виводка Дюрни в Сховищі Втілень на Звичайній складності." }
    t[200226] = { name = "Скалка Великого Посоха", fen = "A shard taken from Broodkeeper Diurna's greatstaff in Vault of the Incarnates on Heroic Difficulty.", fua = "Скалка, відбита від великого посоха Хранительки виводку Діурни у Сховищі Втілень на героїчній складності." }
    t[200227] = { name = "Скалка Великого Посоха", fen = "A shard taken from Broodkeeper Diurna's greatstaff in Vault of the Incarnates on Mythic Difficulty.", fua = "Скалка, відбита від великого посоха Хранительки виводку Діурни у Сховищі Втілень на міфічній складності." }
    t[200613] = { name = "Уламок Вітрокаменя Айлаагів", fen = "A small amount of the wind's blessing, just enough to carry a whisper and the whisperer.", fua = "Дрібка благословення вітру, якраз достатня, щоб понести шепіт і того, хто шепоче." }
    t[200638] = { name = "Бульбашкова Камбала", fen = "A rare and unusual fish of little value.", fua = "Рідкісна й незвична риба, що майже нічого не варта." }
    t[200646] = "Сітка Похмурого Рибалки"
    t[200667] = "Похмурий Шматок"
    t[200680] = "Оберемок Маруукай"
    t[200855] = "Тускарський Портвейн"
    t[200856] = { name = "Шлюпка", fen = "The perfect drink for fishing, not for boating.", fua = "Ідеальний напій для риболовлі, але не для плавання." }
    t[201355] = "Скриня Вічного Спорядження"
    t[201362] = "Скриня Приреченого Спорядження"
    t[201727] = { name = "Моїм Найвідданішим Союзникам", fen = "Were it not impossible, one might think this ancient tome to be stained by tears.", fua = "Якби це не було неможливо, можна було б подумати, що цей стародавній фоліант поплямований сльозами." }
    t[201841] = "Комплект: Латна Броня Космічного Претендента"
    t[201842] = "Комплект: Кольчужна Броня Космічного Претендента"
    t[201843] = "Комплект: Шкіряна Броня Космічного Претендента"
    t[201844] = "Комплект: Тканинна Броня Космічного Претендента"
    t[201845] = "Комплект: Броня Воїна Космічного Гладіатора"
    t[201846] = "Комплект: Броня Чорнокнижника Космічного Гладіатора"
    t[201847] = "Комплект: Броня Шамана Космічного Гладіатора"
    t[201848] = "Комплект: Броня Розбійника Космічного Гладіатора"
    t[201849] = "Комплект: Броня Жерця Космічного Гладіатора"
    t[201850] = "Комплект: Броня Паладина Космічного Гладіатора"
    t[201851] = "Комплект: Броня Ченця Космічного Гладіатора"
    t[201852] = "Комплект: Броня Мага Космічного Гладіатора"
    t[201853] = "Комплект: Броня Мисливця Космічного Гладіатора"
    t[201854] = "Комплект: Броня Друїда Космічного Гладіатора"
    t[201855] = "Комплект: Броня Мисливця на Демонів Космічного Гладіатора"
    t[201856] = "Комплект: Броня Лицаря Смерті Космічного Гладіатора"
    t[201857] = "Комплект: Латна Броня Звільненого Претендента"
    t[201858] = "Комплект: Кольчужна Броня Звільненого Претендента"
    t[201859] = "Комплект: Шкіряна Броня Звільненого Претендента"
    t[201860] = "Комплект: Тканинна Броня Звільненого Претендента"
    t[201861] = "Комплект: Латна Броня Звільненого Гладіатора"
    t[201862] = "Комплект: Кольчужна Броня Звільненого Гладіатора"
    t[201863] = "Комплект: Шкіряна Броня Звільненого Гладіатора"
    t[201864] = "Комплект: Тканинна Броня Звільненого Гладіатора"
    t[201865] = "Комплект: Латна Броня Грішного Претендента"
    t[201866] = "Комплект: Кольчужна Броня Грішного Претендента"
    t[201867] = "Комплект: Шкіряна Броня Грішного Претендента"
    t[201868] = "Комплект: Тканинна Броня Грішного Претендента"
    t[201869] = "Комплект: Латна Броня Грішного Гладіатора"
    t[201870] = "Комплект: Кольчужна Броня Грішного Гладіатора"
    t[201871] = "Комплект: Шкіряна Броня Грішного Гладіатора"
    t[201872] = "Комплект: Тканинна Броня Грішного Гладіатора"
    t[201873] = "Арсенал: Зброя Космічного Гладіатора"
    t[201875] = "Арсенал: Зброя Космічного Претендента"
    t[201876] = "Арсенал: Зброя Звільненого Гладіатора"
    t[201877] = "Арсенал: Зброя Звільненого Претендента"
    t[201878] = "Арсенал: Зброя Грішного Претендента"
    t[201879] = "Арсенал: Ревендретська Зброя Грішного Гладіатора"
    t[201880] = "Арсенал: Малдраксуська Зброя Грішного Гладіатора"
    t[201881] = "Арсенал: Бастіонська Зброя Грішного Гладіатора"
    t[201882] = "Арсенал: Арденвальдська Зброя Грішного Гладіатора"
    t[202034] = "Полум'я Спомину"
    t[202081] = { name = "Торба припасів Драконових островів", fen = "Various resources and building materials that can assist the friendly factions of the Dragon Isles in their fight again the Primalists. Used to purchase items unlocked from renown.", fua = "Різноманітні ресурси й будівельні матеріали, що можуть допомогти дружнім фракціям Драконових островів у боротьбі з первісниками. Слугує для придбання речей, відкритих через визнання." }
    t[202088] = { name = "Потужна настоянка оновлення", fen = "Still potent after all these years.", fua = "Досі дієва навіть через стільки років." }
    t[208447] = { name = "Очисне Плетиво", fen = "A sense of calm befalls those that touch the orb.", fua = "Відчуття спокою огортає тих, хто торкається кулі." }
    t[208543] = { name = "Маленьке Морозокриле", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210409] = { name = "Аура", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210505] = { name = "Мрія", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210522] = { name = "Блакитлу", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210553] = { name = "Народжений Сном Скарабей", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210555] = { name = "Снокопит", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210556] = { name = "Плющ", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210567] = { name = "Спогадик", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210570] = { name = "Куняйло", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210571] = { name = "Сонько", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210633] = { name = "Кал'анду", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210648] = { name = "Насінчик", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210651] = { name = "Пилюнчик", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210652] = { name = "Дрімолет", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210689] = { name = "Носик", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210690] = { name = "Елмер", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210691] = { name = "Ялинка", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210692] = { name = "Ялівець", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210777] = { name = "Дрімайло", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210785] = { name = "Снорр", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210870] = { name = "Мітзі", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[210964] = { name = "Малий Вратіон", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[217043] = { name = "Покі", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[219939] = { name = "Кристал Аллерії", fen = "This crystal seems to eat the light around it. There is slight movement in the depths of it's core.", fua = "Здається, цей кристал поглинає світло довкола себе. У глибині його осердя помітний легкий рух." }
    t[220162] = "[PH] Toy, Pipe Toy"
    t[220765] = "Ілюзія: Скверна Ша"
    t[222899] = { name = "[UNUSED] Faerin's Shield", fen = "It's heavy and finely-crafted specifically for Faerin.", fua = "Він важкий і вишукано викуваний саме для Фейрін." }
    t[223639] = "Вішак для Плаща Непохованого Претендента"
    t[223640] = "Вішак для Плаща Непохованого Гладіатора"
    t[223769] = "Плащ Вічного Претендента"
    t[228765] = { name = "Ґумі", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[234422] = "Обпалена Бурею Здобич"
    t[234423] = { name = "Срібна Здобич Барило-Ноги", fen = "A silver coin that feels electric to the touch. Perhaps the unsavory individuals in Dornogal would be interested in this?", fua = "Срібна монета, що на дотик відчувається наелектризованою. Можливо, цим зацікавляться сумнівні особи в Дорногалі?" }
    t[234424] = { name = "Бронзова Здобич Барило-Ноги", fen = "A bronze coin that feels electric to the touch. Perhaps the unsavory individuals in Dornogal would be interested in this?", fua = "Бронзова монета, що на дотик відчувається наелектризованою. Можливо, цим зацікавляться сумнівні особи в Дорногалі?" }
    t[235898] = { name = "Стримувальна Пастка", fen = "Keeps researchers safe and unharmed.", fua = "Тримає дослідників у безпеці й неушкодженими." }
    t[237827] = { name = "Пам'ятка Полеглого Авангардиста", fen = "A fractured, rent keepsake... all that remains of this brave Vanguard combatant.", fua = "Зламаний, роздертий пам'ятний знак... усе, що лишилося від цього хороброго бійця Авангарду." }
    t[244457] = { name = "Контейнер для Ключа", fen = "Contains a Timeworn Keystone.", fua = "Містить Зужитий Часом Ключ." }
    t[246705] = "Локшина з карамеллю та м'ятою"
    t[250776] = "Ілюзія: Скверна Ша"
    t[251772] = { name = "Деревина Ардену", fen = "Lumber harvested beyond the Veil and taken from the Shadowlands.", fua = "Деревина, заготовлена за Завісою і винесена з Тіньокраю." }
    t[253706] = { name = "Непотрібний Лист", fen = "Refinance you home to lock in these new low rates! Good for one hour!", fua = "Перекредитуй своє житло, щоб зафіксувати ці нові низькі ставки! Чинне одну годину!" }
    t[254746] = "Похвала Двору Жниварів"
    t[254758] = "Похвала Дикого Полювання"
    t[254759] = "Похвала Невмирущого Війська"
    t[254760] = "Похвала Піднесених"
    t[254761] = "Похвала Ве'нарі"
    t[254762] = "Похвала Заприсяжених"
    t[254763] = "Похвала Двору Ночі"
    t[254764] = "Похвала Двору Жарин"
    t[254765] = "Похвала Майстрів Швів"
    t[254768] = "Похвала Маразміуса"
    t[254771] = "Похвала Поступу Смерті"
    t[254774] = "Похвала Кодексу Архіваріуса"
    t[254775] = "Похвала Просвітлених"
    t[254844] = "Молот Праведного Світлоносця"
    t[254845] = "Молот Полеглого Світлоносця"
    t[254851] = "Сагайдак Переслідувача Пащі"
    t[254852] = "Сагайдак Духовного Стрільця"
    t[254853] = "Спис Архітекторів"
    t[254854] = "Гнильний Оплічник Некроманта"
    t[254855] = "Оплічник Темного Некроманта"
    t[254856] = "Коса Жниваря Душ"
    t[254857] = "Гільйотина Ката Пащі"
    t[254858] = "Арбалет Першонароджених"
    t[254860] = "Довгий Меч Першостворених"
    t[254861] = "Колун Каменя Гріха"
    t[254862] = "Рунний Клинок Взірця Малдраксуса"
    t[254863] = "Посох Покаянника"
    t[254864] = "Слизовий Ранець Божевільного Алхіміка"
    t[254865] = "Панцир Забороненого Краю"
    t[254866] = "Тріснутий Трощитель Прародителів"
    t[254867] = "Лагодильник Прародителів"
    t[254868] = "Священний Дзвін Піднесених"
    t[254872] = "Жезл Першопочатку Творця"
    t[254873] = "Віброклинок Зерита"
    t[254876] = { name = "Помічник P.O.S.T.", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[256336] = "Небороз Кіріанців"
    t[256337] = "Збивач Ціни"
    t[256338] = "Кинджал Забутих Обітниць"
    t[256339] = "Рапіра Анімапивця"
    t[256340] = "Довгий Лук Небесної Варти"
    t[256341] = "Спаситель Шпиля Віри"
    t[256348] = "Оплот Полеглого Піднесеного"
    t[256349] = "Бойові Глефи Відданості"
    t[256350] = "Лати Анімакутого Вартового"
    t[256351] = "Роба Зреченого Провидця"
    t[256352] = "Оплічник Гармонійного Духу"
    t[256353] = "Кольчуга Елізійського Слідопита"
    t[256355] = "Шолом Анімакутого Вартового"
    t[256358] = "Забрало Елізійського Слідопита"
    t[256359] = "Каптур Зреченого Провидця"
    t[256360] = "Маска Гармонійного Духу"
    t[256881] = { name = "Цяцька Стюарда", fen = "Who needs a helping wing? Who? Who?", fua = "Кому потрібне дружнє крило? Кому? Кому?" }
    t[256893] = { name = "Тавро Жалюгідного Копача", fen = "Can't dredge up a better servant.", fua = "Кращого слугу годі й викопати." }
    t[257048] = "Купіль Медитації Послушника"
    t[257049] = "Самоцвітна Чаша Вентирів"
    t[257050] = "Шишка Аніми за Завісою"
    t[257051] = "Свічки з Гріховного Лою"
    t[257098] = "Пляшка Аніми Вентирів"
    t[257511] = { name = "Збруя Бронзового Дикуна", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257513] = { name = "Збруя Бронзового Аквілона", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257514] = { name = "Збруя Бронзової Трупної Мухи", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257516] = { name = "Збруя Бронзового Могилокрила", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[258235] = "Стілець Прагнучої Душі"
    t[258237] = "Ліхтарний Стовп Арденвельду"
    t[258238] = "Малдраксійська Скриня"
    t[258239] = "Фоліант Малдраксійських Ритуалів"
    t[258240] = "Кіріанська Діжка Аніми"
    t[258242] = "Святилище Нічних Фей Видолинку"
    t[258244] = "Стіл Проклять Посередника"
    t[258245] = "Підвісні Кошики Арденвельду"
    t[258247] = "Велика Складська Скриня Ревендрета"
    t[258248] = "Зшитий Шкіряний Килим Маркграфа"
    t[258250] = "Книжкова Шафа Картелю Та"
    t[258252] = "Ловецька Скриня Картелю Ксай"
    t[258488] = { name = "Небеснолапий Мерехтохутрий", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[258515] = { name = "Багряний Люпин", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[258527] = "Великий Молот Полеглого Світоносця"
    t[258528] = "Великий Молот Праведного Світоносця"
    t[258561] = "Згорнута Подушка Кіріанського Послушника"
    t[258662] = "Доглядальний Вартовий Прародителя"
    t[259463] = { name = "Сніголапий Мерехтлехутрий Блукач", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[260360] = { name = "Ґуммі, Сяйливий Вірм", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[260699] = "Малдраксійська Рунічна Табличка"
    t[262663] = "Летюча Лампа Кіріанів"
    t[264678] = "Кільчастий Прапор Аспіранта"
    t[264713] = "Прапор Серця Лісу"
    t[275664] = { name = "Змучений Ненажера", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
end)
