-- WoWUkraine: предмети (Midnight) — LoadOnDemand.
-- WoWUkraine: предмети (LoadOnDemand). Автоген pipeline/generate_db.py — не редагуйте.
-- Вантажиться головним аддоном лише коли увімкнено опції items.*. ns — спільний глобал.
local ns = _G.WoWUkraineNS
if not ns then return end
ns.items = ns.items or {}
local t = ns.items
local function add(f) f(t) end
add(function(t)
    t[193068] = { name = "Бурштиновий деревопурхач", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[213514] = { name = "Гілка пахучої шавлії", fen = "A tough shrub's branch with a very pungent smell.", fua = "Гілка міцного куща з дуже різким запахом." }
    t[219934] = { name = "Іскра війни", fen = "An iridescent essence.", fua = "Райдужна есенція." }
    t[222988] = { name = "Старий Світлокліщ", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[232875] = { name = "Іскра сяйва", fen = "A unique crafting material that radiates fierce light. Obtained through weekly quests or end-game activities, it is used to create the most powerful of equipment via professions.", fua = "Унікальний матеріал для виготовлення, що випромінює лютне світло. Здобувається у щотижневих завданнях чи в активностях кінцевого контенту й використовується для створення найпотужнішого спорядження через професії." }
    t[235625] = { name = "Уламок реліквії Ґразли", fen = "Grazla held tightly to this, apparently believing it contained significant power even while broken.", fua = "Ґразла міцно тримала його при собі, вочевидь вірячи, що навіть зламаним він містить чималу силу." }
    t[235632] = { name = "Зразок екзотичної тканини", fen = "Innards and some outtards of an exotic creature.", fua = "Тельбухи й дещиця назовнішків екзотичної істоти." }
    t[235637] = { name = "[NYI] Lockpick Power", fen = "[NYI] Opens a locked door within Murder Row.", fua = "[NYI] Відмикає замкнені двері у Завулку Убивць." }
    t[235644] = "Захований пістоль"
    t[235651] = { name = "Зручної форми кіготь", fen = "Of all the shapes a claw could come in.", fua = "З усіх форм, яких може набути кіготь." }
    t[235656] = { name = "Реліквія панування", fen = "A curio worthy of a blueberry.", fua = "Дивовижа, гідна чорничини." }
    t[235663] = { name = "Захоплений прапор Клинка Сутінків", fen = "Perfect for fooling an ogre into believing the Twilight's Blade has attacked.", fua = "Ідеально, щоб переконати оґра, ніби напав Клинок Сутінків." }
    t[235666] = { name = "Скалка, насичена тінню", fen = "Pulsing veins of void magic have begun to spread throughout the stone, displacing the elemental essence once bound within.", fua = "Пульсуючі жили магії Порожнечі почали розповзатися по каменю, витісняючи есенцію стихій, що колись була в ньому ув'язнена." }
    t[235806] = { name = "Посох Тайталора", fen = "The staff is gilded in a gold veneer, much like Tytalor's personality.", fua = "Посох укритий тонким шаром золота, дуже схоже на характер самого Тайталора." }
    t[235808] = { name = "Подерта сторінка чарівної книги", fen = "The entry gleams with magic, freshly picked from the source.", fua = "Запис мерехтить магією, щойно здобутою з джерела." }
    t[235912] = { name = "Гілка кровотрав'я", fen = "This branch smells more like decay than a medicine.", fua = "Ця гілка пахне радше тлінню, ніж ліками." }
    t[236332] = "Особливий резерв, торкнутий сонцем"
    t[236359] = { name = "Віщування Саргла №1", fen = "You're doomed!", fua = "Ти приречений!" }
    t[236365] = { name = "Віщування Саргла №2", fen = "Your problem just got worse. What have you done?", fua = "Твоя проблема щойно погіршилася. Що ти накоїв?" }
    t[236366] = { name = "Віщування Саргла №3", fen = "There's gold in your future, though it is not yours.", fua = "У твоєму майбутньому є золото, та воно не твоє." }
    t[236367] = { name = "Віщування Саргла №4", fen = "Are you happy? It won't last!", fua = "Ти щасливий? Це ненадовго!" }
    t[236368] = { name = "Віщування Саргла №5", fen = "Your fondest wish will never come true.", fua = "Твоє найзаповітніше бажання ніколи не справдиться." }
    t[236369] = { name = "Віщування Саргла №6", fen = "There's no fortune for you. Go home.", fua = "Для тебе немає віщування. Іди додому." }
    t[236370] = { name = "Віщування Саргла №7", fen = "Run!", fua = "Тікай!" }
    t[236371] = { name = "Віщування Саргла №8", fen = "The next sentence you hear is a lie.", fua = "Наступне речення, яке ти почуєш, — брехня." }
    t[236372] = { name = "Віщування Саргла №9", fen = "Yes, it was all your fault.", fua = "Так, це все була твоя провина." }
    t[236373] = { name = "Віщування Саргла №10", fen = "Avoid all gnomes.", fua = "Уникай усіх гномів." }
    t[236377] = { name = "Віщування Саргла №11", fen = "Ignore the previous fortune.", fua = "Не зважай на попереднє віщування." }
    t[236381] = { name = "Віщування Саргла №12", fen = "Caution! Poisoned food in your future.", fua = "Обережно! У твоєму майбутньому отруєна їжа." }
    t[236387] = { name = "Віщування Саргла №13", fen = "Today is not your day.", fua = "Сьогодні не твій день." }
    t[236752] = { name = "Знак Северума", fen = "A hollow symbol of hunger. The essence of Severum's authority.", fua = "Порожнистий символ голоду. Сутність влади Северума." }
    t[236761] = { name = "Цвіт спокою", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the Auction House.", fua = "Збирається гравцями з умінням травництва. Можна купити й продати на аукціоні." }
    t[236767] = { name = "Цвіт спокою", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the Auction House.", fua = "Збирається гравцями з умінням травництва. Можна купити й продати на аукціоні." }
    t[236770] = { name = "Кривавошип", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the Auction House.", fua = "Збирається гравцями з умінням травництва. Можна купити й продати на аукціоні." }
    t[236771] = { name = "Кривавошип", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the Auction House.", fua = "Збирається гравцями з умінням травництва. Можна купити й продати на аукціоні." }
    t[236774] = { name = "Азекорінь", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the Auction House.", fua = "Збирається гравцями з умінням травництва. Можна купити й продати на аукціоні." }
    t[236775] = { name = "Азекорінь", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the Auction House.", fua = "Збирається гравцями з умінням травництва. Можна купити й продати на аукціоні." }
    t[236776] = { name = "Срібнолист", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the Auction House.", fua = "Збирається гравцями з умінням травництва. Можна купити й продати на аукціоні." }
    t[236777] = { name = "Срібнолист", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the Auction House.", fua = "Збирається гравцями з умінням травництва. Можна купити й продати на аукціоні." }
    t[236778] = { name = "Лілея мани", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the Auction House.", fua = "Збирається гравцями з умінням травництва. Можна купити й продати на аукціоні." }
    t[236779] = { name = "Лілея мани", fen = "Gathered by players with the Herbalism skill. Can be bought and sold on the Auction House.", fua = "Збирається гравцями з умінням травництва. Можна купити й продати на аукціоні." }
    t[236780] = { name = "Нічний лотос", fen = "Found rarely amongst the other herbs of Midnight, its potency is unmatched. Sometimes gathered by players with the Herbalism skill. Can be bought and sold on the Auction House.", fua = "Рідкісна знахідка серед інших трав Опівночі, його сила незрівнянна. Іноді його збирають гравці з умінням травництва. Можна купити та продати на Аукціоні." }
    t[236949] = { name = "Крихта Світла", fen = "A mote of coalesced light formed from the Lightbloom. Can be bought and sold on the Auction House.", fua = "Крихта згущеного світла, утворена зі Світлоцвіту. Можна купити й продати на Аукціоні." }
    t[236950] = { name = "Крихта первісної енергії", fen = "A coalesced mote of pure, primal energy. Can be bought and sold on the Auction House.", fua = "Згущена крихта чистої первісної енергії. Можна купити й продати на Аукціоні." }
    t[236951] = { name = "Крихта дикої магії", fen = "Wild magic given a solid form. Can be bought and sold on the Auction House.", fua = "Дика магія, що набула твердої форми. Можна купити й продати на Аукціоні." }
    t[236952] = { name = "Крихта чистої Порожнечі", fen = "A solid orb of the nothingness that makes up the vast Twisting Nether. At least, you think it's solid. Can be bought and sold on the Auction House.", fua = "Тверда куля небуття, що складає безмежний Викривлений Простір. Принаймні ти гадаєш, що вона тверда. Можна купити й продати на Аукціоні." }
    t[236963] = { name = "Яскраве Полотно", fen = "A light and sturdy cloth sourced by Tailors from humanoids throughout Midnight zones. Can be bought and sold on the Auction House.", fua = "Легка й міцна тканина, яку кравці здобувають з гуманоїдів у зонах Опівночі. Можна купити й продати на Аукціоні." }
    t[236965] = { name = "Яскраве Полотно", fen = "A light and sturdy cloth sourced by Tailors from humanoids throughout Midnight zones. Can be bought and sold on the Auction House.", fua = "Легка й міцна тканина, яку кравці здобувають з гуманоїдів у зонах Опівночі. Можна купити й продати на Аукціоні." }
    t[237015] = { name = "Шовк сонячного вогню", fen = "A light and sturdy cloth sourced by Tailors from humanoids throughout Midnight zones. Can be bought and sold on the Auction House.", fua = "Легка й міцна тканина, яку кравці здобувають з гуманоїдів у зонах Опівночі. Можна купити й продати на Аукціоні." }
    t[237016] = { name = "Шовк сонячного вогню", fen = "A light and sturdy cloth sourced by Tailors from humanoids throughout Midnight zones. Can be bought and sold on the Auction House.", fua = "Легка й міцна тканина, яку кравці здобувають з гуманоїдів у зонах Опівночі. Можна купити й продати на Аукціоні." }
    t[237017] = { name = "Арканове плетиво", fen = "Cloth spun out of manasilk. Tailors can find these on humanoids throughout Midnight zones. Can be bought and sold on the Auction House.", fua = "Тканина, спрядена з манашовку. Кравці можуть знайти її на гуманоїдах у зонах Опівночі. Можна купити й продати на Аукціоні." }
    t[237018] = { name = "Арканове плетиво", fen = "Cloth spun out of manasilk. Tailors can find these on humanoids throughout Midnight zones. Can be bought and sold on the Auction House.", fua = "Тканина, спрядена з манашовку. Кравці можуть знайти її на гуманоїдах у зонах Опівночі. Можна купити й продати на Аукціоні." }
    t[237140] = "Спис Світлошпиля"
    t[237142] = { name = "Арканний видошукач", fen = "A camera used to strike fear in villain's hearts.", fua = "Камера, що сіє страх у серцях лиходіїв." }
    t[237164] = { name = "Мистецтво й архітектура Сільвермуна: том 3", fen = "A hefty volume that is possibly best for display purposes only. A note fitted between the pages reads, \"For Talren\".", fua = "Важкий том, який, мабуть, найкраще годиться лише для показу. Між сторінок вкладена записка: «Для Талрена»." }
    t[237165] = { name = "Торбина з травами", fen = "Old, dried herbs rest safely in a cloth bag. A small note tied to it reads, \"For Fiona.\"", fua = "Старі, висушені трави спокійно лежать у полотняній торбинці. На прив'язаній до неї записці написано: \"Для Фіони\"." }
    t[237166] = { name = "Непримітна пляшка води", fen = "This appears to be a simple glass bottle with water in it. A note plastered to the side reads, \"Sample for Rimblat.\"", fua = "Здається, це проста скляна пляшка з водою. На приклеєній збоку записці написано: «Зразок для Рімблата»." }
    t[237167] = { name = "Старовинне намисто", fen = "In need of polishing, but a highly valuable artifact.", fua = "Потребує полірування, але це вельми цінний артефакт." }
    t[237359] = { name = "Сяйлива мідна руда", fen = "Gathered by players with the Mining skill. Can be bought and sold on the Auction House.", fua = "Видобувається гравцями з умінням гірничої справи. Можна купити й продати на Аукціоні." }
    t[237361] = { name = "Сяйлива мідна руда", fen = "Gathered by players with the Mining skill. Can be bought and sold on the Auction House.", fua = "Видобувається гравцями з умінням гірничої справи. Можна купити й продати на Аукціоні." }
    t[237362] = { name = "Тінява олов'яна руда", fen = "Gathered by players with the Mining skill. Can be bought and sold on the Auction House.", fua = "Видобувається гравцями з умінням гірничої справи. Можна купити й продати на Аукціоні." }
    t[237363] = { name = "Тінява олов'яна руда", fen = "Gathered by players with the Mining skill. Can be bought and sold on the Auction House.", fua = "Видобувається гравцями з умінням гірничої справи. Можна купити й продати на Аукціоні." }
    t[237364] = { name = "Осяйна Срібна Руда", fen = "Gathered by players with the Mining skill. Can be bought and sold on the Auction House.", fua = "Видобувається гравцями з умінням гірничої справи. Можна купити й продати на Аукціоні." }
    t[237365] = { name = "Осяйна Срібна Руда", fen = "Gathered by players with the Mining skill. Can be bought and sold on the Auction House.", fua = "Видобувається гравцями з умінням гірничої справи. Можна купити й продати на Аукціоні." }
    t[237366] = { name = "Сяйливий торій", fen = "Gathered by players with the Mining skill. Can be bought and sold on the Auction House.", fua = "Видобувається гравцями з умінням гірничої справи. Можна купити й продати на Аукціоні." }
    t[237367] = "Сяйливий обважнювальний камінь"
    t[237369] = "Сяйливий обважнювальний камінь"
    t[237370] = "Сяйливий точильний камінь"
    t[237371] = "Сяйливий точильний камінь"
    t[237372] = "Сяйливий гострильний камінь"
    t[237373] = "Сяйливий гострильний камінь"
    t[237380] = { name = "Порожня Манакомірка", fen = "Uncharged and devoid of energy.", fua = "Незаряджена й позбавлена енергії." }
    t[237496] = "Зразок вивергнутої породи"
    t[237497] = { name = "Стійке зерня", fen = "A magical seed that thrums with life.", fua = "Магічна насінина, що бринить життям." }
    t[237498] = { name = "Сяйливе стійке насіння", fen = "A magical seed that thrums with life. It emits a soft but steady glow.", fua = "Чарівне насіння, що пульсує життям. Воно випромінює м'яке, але рівне сяйво." }
    t[237499] = { name = "Дике витривале зерня", fen = "A magical seed that thrums with life. Wild magics pulse from within.", fua = "Чарівне зерня, що пульсує життям. Усередині б'ється дика магія." }
    t[237500] = { name = "Первісне стійке насіння", fen = "A magical seed that thrums with life. The primal energy of Azeroth courses through it.", fua = "Магічне насіння, що пульсує життям. Крізь нього струмує первісна енергія Азероту." }
    t[237501] = { name = "Зброя зі світлодерева", fen = "A weapon perfect for smiting Twilight's Blade cultists.", fua = "Зброя, ідеальна для нищення культистів Клинка Сутінків." }
    t[237505] = { name = "Завзяття майстра", fen = "A mysterious reagent beyond mortal comprehension that is bestowed upon master crafters. It is often exchanged for new recipes and books of knowledge.", fua = "Таємничий реагент поза межами розуміння смертних, що дарується майстрам-ремісникам. Його часто обмінюють на нові рецепти й книги знань." }
    t[237506] = "Септарієва конкреція"
    t[237507] = "Каламутний кварц"
    t[237513] = { name = "Медитаційний кристал захисника Маараада", fen = "Maraad leaned on this meditation crystal for peace, just as others leaned on Maraad for strength and protection.", fua = "Маараад спирався на цей медитаційний кристал, щоб віднайти спокій, так само як інші спиралися на Маараада, щоб віднайти силу й захист." }
    t[237514] = "Віридіанова руда"
    t[237515] = "Багряна руда"
    t[237516] = "Лазурова руда"
    t[237517] = "Цитринова руда"
    t[237518] = { name = "Кухоль Лени Стормпайк", fen = "Even through tavern songs, she radiated her Light by lifting others' spirits.", fua = "Навіть крізь шинкові пісні вона випромінювала своє Світло, підносячи дух інших." }
    t[237519] = { name = "Лікувальний набір Утера", fen = "Uther's faith in the Light shone brightest when he was healing others.", fua = "Віра Утера у Світло сяяла найяскравіше, коли він зціляв інших." }
    t[237573] = { name = "Молитовник Мари Фордрагон", fen = "With her poetic prayers to the Light, she taught of the Light we share with each other--the joy and fellowship found in community.", fua = "Поетичними молитвами до Світла вона навчала про Світло, яке ми поділяємо одне з одним, про радість і братерство, що народжуються у спільноті." }
    t[237574] = { name = "Ковальський молот Крома Світанкомолота", fen = "Krohm's armor, bolstered by the Light, was stronger than even Krohm. Few know he forged it himself.", fua = "Броня Крома, зміцнена Світлом, була міцніша навіть за самого Крома. Мало хто знає, що він викував її сам." }
    t[237576] = { name = "Багряний шпиль Бентара", fen = "Benthar channeled the Light through this staff for his own dark purposes. It shall find better use at the Sunwell.", fua = "Бентар направляв Світло крізь цей посох заради своїх темних намірів. Біля Сонячного Колодязя він знайде краще застосування." }
    t[237579] = { name = "Жезл покарання Меєра", fen = "Meyer directed the Light through this staff, both to fight outsiders and to train his pupils to do the same.", fua = "Меєр спрямовував Світло крізь цей жезл, щоб і битися з чужинцями, і вчити учнів чинити так само." }
    t[237722] = { name = "Покинута записка", fen = "Another \"shipment\" has gone missing, and the client is getting impatient. Make sure the next batch leaves without incident. Use Tideborne's seal on the documents to keep customs off your back.", fua = "Ще одна «партія» зникла, і клієнт втрачає терпіння. Подбай, щоб наступний вантаж пішов без пригод. Постав на документи печатку Хвилерідних, щоб митниця не чіплялася." }
    t[237744] = { name = "Арканний залишок", fen = "Crackling with potential.", fua = "Потріскує потенціалом." }
    t[237745] = { name = "Зашифрований пристрій", fen = "Handheld and even more secure.", fua = "Кишеньковий і ще надійніший." }
    t[237761] = { name = "Осяйний фальшіон Елайс", fen = "Aelyse focused the Light through her sword whenever she fought for the Crusade, until the day she walked away from them both.", fua = "Елайс зосереджувала Світло крізь свій меч щоразу, коли билася за хрестовий похід, аж до того дня, коли відцуралася їх обох." }
    t[237763] = "Камінь Скверни"
    t[237764] = "Вишукана картина"
    t[237765] = "Клинок зупинки серця"
    t[237766] = "Яйце вирма Скверни"
    t[237767] = { name = "Зброя зі світлодерева", fen = "This weapon has cords of lightwood running through it, giving it a strange blur to the eye.", fua = "Цю зброю пронизують жили світлодерева, через що для ока вона дивно розпливається." }
    t[237768] = { name = "Посох гаш'ей", fen = "This staff seems to hold great importance to Elder Kinduru.", fua = "Цей посох, схоже, дуже важливий для старійшини Кіндуру." }
    t[237772] = { name = "Вічногорюче вугілля", fen = "An eternal flame that has corrupted the local wildlife, embedding itself in them.", fua = "Вічне полум'я, що зіпсувало місцеву фауну, вкорінившись у ній." }
    t[237807] = { name = "Есенція стерва", fen = "The extracted essence of prey.", fua = "Видобута есенція здобичі." }
    t[237811] = { name = "Благословення Фаола", fen = "Alonsus Faol has served the Light since the First War, and his staff has retained some of the power that has been channeled through it.", fua = "Алонзус Фаол служить Світлу від Першої війни, і його посох зберіг частку сили, що крізь нього струмувала." }
    t[237828] = "Хода руйнівника чарів"
    t[237829] = "Прихисток руйнівника чарів"
    t[237830] = "Пояс руйнівника чарів"
    t[237831] = "Докір руйнівника чарів"
    t[237832] = "Покрив руйнівника чарів"
    t[237833] = "Поножі руйнівника чарів"
    t[237834] = "Наручі руйнівника чарів"
    t[237835] = "Накидка руйнівника чарів"
    t[237836] = "Рішучість руйнівника чарів"
    t[237837] = "Милосердя далекоходів"
    t[237838] = "Ритуальний ніж магістра"
    t[237839] = "Клинок руйнівника чарів"
    t[237840] = "Бойовий глейв руйнівника чарів"
    t[237841] = "Ультиматум руйнівника чарів"
    t[237842] = "Квітокована велика сокира"
    t[237843] = "Манамеч магістра"
    t[237844] = "Тесак магістра"
    t[237845] = "Квітокований кіготь"
    t[237846] = "Бойовий клинок Лицаря крові"
    t[237847] = "Порив Лицаря крові"
    t[237848] = "Милосердя Лицаря крові"
    t[237849] = "Прощання магістра"
    t[237850] = "Сікач далекоходів"
    t[237895] = { name = "Розколотий ключ", fen = "Oddly shaped with jagged edges.", fua = "Незвичної форми, із зазубреними краями." }
    t[237901] = "Латний нагрудник таласського змагуна"
    t[237902] = "Латні сабатони таласського змагуна"
    t[237903] = "Латні рукавиці таласського змагуна"
    t[237904] = "Латний шолом таласського змагуна"
    t[237905] = "Латні поножі таласського змагуна"
    t[237906] = "Латні наплічники таласського змагуна"
    t[237907] = "Латний пояс таласського змагуна"
    t[237908] = "Латні наручі таласського змагуна"
    t[237909] = "Кайло таласського змагуна"
    t[237910] = "Ніж таласського змагуна"
    t[237911] = "Максима таласського змагуна"
    t[237912] = "Бастіон таласського змагуна"
    t[237913] = "Розсікач таласського змагуна"
    t[237914] = "Рожен таласського змагуна"
    t[237915] = "Дворучний меч таласського змагуна"
    t[237916] = "Меч таласського змагуна"
    t[237917] = "Кровозагартовані поножі"
    t[237918] = "Кровозагартований нагрудник"
    t[237919] = "Кровозагартований широкий пояс"
    t[237920] = "Кровозагартований бастіон"
    t[237921] = "Кровозагартований шишак"
    t[237922] = "Кровозагартовані наголінники"
    t[237923] = "Кровозагартовані наручі"
    t[237924] = "Кровозагартовані наплічники"
    t[237925] = "Кровозагартовані рукавиці"
    t[237926] = "Світанково-кований ритуальний ніж"
    t[237927] = "Світанково-кована різь"
    t[237928] = "Світанково-кований довгий клинок"
    t[237929] = "Первісноковані кастети"
    t[237930] = "Світанково-кована бойова булава"
    t[237931] = "Світанково-кований розколювач"
    t[237932] = "Первіснокована важка сокира"
    t[237946] = "Таласський набір голок"
    t[237947] = "Набір інструментів таласського шкіряра"
    t[237948] = "Скринька з інструментами таласського коваля"
    t[237950] = "Благословенний сонцем набір голок"
    t[237951] = "Благословенний сонцем чинбарський набір інструментів"
    t[237952] = "Благословенна сонцем ковальська скринька з інструментами"
    t[238009] = "Таласський серп"
    t[238010] = "Таласське кайло"
    t[238011] = "Таласський ніж для білування"
    t[238012] = "Ніж таласського шкіряра"
    t[238013] = "Молот таласського коваля"
    t[238014] = "Благословенний сонцем серп"
    t[238015] = "Благословенна сонцем кирка"
    t[238016] = "Благословенний сонцем білувальний ніж"
    t[238017] = "Благословенний сонцем чинбарський ніж"
    t[238018] = "Благословенний сонцем ковальський молот"
    t[238020] = "Таласський майстровий ремонтний молот"
    t[238024] = { name = "Лійка", fen = "An ornate watering can made from a hard material which looks like metal, but which feels warm and soft to the touch.", fua = "Оздоблена лійка з твердого матеріалу, схожого на метал, але теплого й м'якого на дотик." }
    t[238197] = { name = "Сяйливий мідний зливок", fen = "Smelted by players with the Blacksmithing skill. Can be bought and sold on the Auction House.", fua = "Виплавлений гравцями з умінням Ковальства. Можна купувати й продавати на Аукціоні." }
    t[238198] = { name = "Сяйливий мідний зливок", fen = "Smelted by players with the Blacksmithing skill. Can be bought and sold on the Auction House.", fua = "Виплавлений гравцями з умінням Ковальства. Можна купувати й продавати на Аукціоні." }
    t[238202] = { name = "Присмерковий сплав", fen = "Smelted by players with the Blacksmithing skill. Can be bought and sold on the Auction House.", fua = "Виплавлений гравцями з умінням Ковальства. Можна купувати й продавати на Аукціоні." }
    t[238203] = { name = "Присмерковий сплав", fen = "Smelted by players with the Blacksmithing skill. Can be bought and sold on the Auction House.", fua = "Виплавлений гравцями з умінням Ковальства. Можна купувати й продавати на Аукціоні." }
    t[238204] = { name = "Срібний сплав", fen = "Smelted by players with the Blacksmithing skill. Can be bought and sold on the Auction House.", fua = "Виплавлений гравцями з умінням Ковальства. Можна купувати й продавати на Аукціоні." }
    t[238205] = { name = "Срібний сплав", fen = "Smelted by players with the Blacksmithing skill. Can be bought and sold on the Auction House.", fua = "Виплавлений гравцями з умінням Ковальства. Можна купувати й продавати на Аукціоні." }
    t[238206] = "[PH] Weightstone - Quality 1"
    t[238209] = "Сяйливий ремонтний молот"
    t[238218] = { name = "Креслення: латний нагрудник таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Plate Breastplate.", fua = "Навчає вас виготовляти латний нагрудник таласського змагуна." }
    t[238219] = { name = "Креслення: латні сабатони таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Plate Sabatons.", fua = "Навчає вас виготовляти латні сабатони таласського змагуна." }
    t[238220] = { name = "Креслення: латні рукавиці таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Plate Gauntlets.", fua = "Навчає вас виготовляти латні рукавиці таласського змагуна." }
    t[238221] = { name = "Креслення: латний шолом таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Plate Helm.", fua = "Навчає вас виготовляти латний шолом таласського змагуна." }
    t[238222] = { name = "Креслення: латні поножі таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Plate Greaves.", fua = "Навчає вас виготовляти латні поножі таласського змагуна." }
    t[238223] = { name = "Креслення: латні наплічники таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Plate Pauldrons.", fua = "Навчає вас виготовляти латні наплічники таласського змагуна." }
    t[238224] = { name = "Креслення: латний пояс таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Plate Waistguard.", fua = "Навчає вас виготовляти латний пояс таласського змагуна." }
    t[238225] = { name = "Креслення: латні наручі таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Plate Armguards.", fua = "Навчає вас виготовляти латні наручі таласського змагуна." }
    t[238226] = { name = "Креслення: кайло таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Pickaxe.", fua = "Навчає вас виготовляти кайло таласського змагуна." }
    t[238227] = { name = "Креслення: ніж таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Knife.", fua = "Навчає вас виготовляти ніж таласського змагуна." }
    t[238228] = { name = "Креслення: максима таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Maxim.", fua = "Навчає вас виготовляти максиму таласського змагуна." }
    t[238229] = { name = "Креслення: бастіон таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Bulwark.", fua = "Навчає вас виготовляти бастіон таласського змагуна." }
    t[238230] = { name = "Креслення: розкол таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Splitter.", fua = "Навчає вас виготовляти розкол таласського змагуна." }
    t[238231] = { name = "Креслення: шпичак таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Skewer.", fua = "Навчає вас виготовляти шпичак таласського змагуна." }
    t[238232] = { name = "Креслення: великий меч таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Greatsword.", fua = "Навчає вас виготовляти великий меч таласського змагуна." }
    t[238233] = { name = "Креслення: меч таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Sword.", fua = "Навчає вас виготовляти меч таласського змагуна." }
    t[238256] = { name = "Рогіз", fen = "Fuzzy stalks rise from numerous thin, curled reeds. This is Koozat's favorite meal.", fua = "З численних тонких закручених очеретин здіймаються пухнасті стебла. Це улюблена страва Кузата." }
    t[238359] = { name = "Тотем Налоракка", fen = "You sense the raw power of a bear within.", fua = "Ви відчуваєте всередині нього невгамовну силу ведмедя." }
    t[238365] = { name = "Хижак сін'дорей", fen = "A common fish in Quel'Thalas. Can be bought and sold on the Auction House.", fua = "Звичайна риба з Кель'Таласа. Можна купити й продати на аукціоні." }
    t[238366] = { name = "Риба-рись", fen = "A common fish in Quel'Thalas. Can be bought and sold on the Auction House.", fua = "Звичайна риба з Кель'Таласа. Можна купити й продати на аукціоні." }
    t[238367] = { name = "Кореневий краб", fen = "A common creature in Quel'Thalas. Can be bought and sold on the Auction House.", fua = "Звичайна істота з Кель'Таласу. Можна купити й продати на Аукціоні." }
    t[238368] = { name = "Спотворена тетра", fen = "A rare fish in Quel'Thalas. Can be bought and sold on the Auction House.", fua = "Рідкісна риба в Кель'Таласі. Можна купити й продати на Аукціоні." }
    t[238369] = { name = "Квітохвостий Гольян", fen = "An uncommon fish native to Quel'Thalas. Can be bought and sold on the Auction House.", fua = "Незвичайна риба, родом із Кель'Таласу. Можна купити й продати на Аукціоні." }
    t[238370] = { name = "Мерехтлива колючка", fen = "An uncommon fish native to Quel'Thalas. Can be bought and sold on the Auction House.", fua = "Незвичайна риба, родом із Кель'Таласу. Можна купити й продати на Аукціоні." }
    t[238371] = { name = "Арканна риба-вирм", fen = "A common fish in Quel'Thalas. Can be bought and sold on the Auction House.", fua = "Звичайна риба з Кель'Таласа. Можна купити й продати на аукціоні." }
    t[238372] = { name = "Відновлена співуча риба", fen = "An uncommon fish native to Quel'Thalas. Can be bought and sold on the Auction House.", fua = "Незвичайна риба, родом із Кель'Таласу. Можна купити й продати на Аукціоні." }
    t[238373] = { name = "Зловісний восьминіг", fen = "A rare creature in Voidstorm. Can be bought and sold on the Auction House.", fua = "Рідкісна істота в Бурі Порожнечі. Можна купувати й продавати на Аукціоні." }
    t[238374] = { name = "Ніжний світлоплав", fen = "An uncommon fish native to Quel'Thalas. Can be bought and sold on the Auction House.", fua = "Незвичайна риба, родом із Кель'Таласу. Можна купити й продати на Аукціоні." }
    t[238375] = { name = "Грибошкіра щука", fen = "An uncommon fish in Quel'Thalas. Can be bought and sold on the Auction House.", fua = "Незвичайна риба в Кель'Таласі. Можна купити й продати на Аукціоні." }
    t[238376] = { name = "Везучий лоа", fen = "A rare fish native to Quel'Thalas. Can be bought and sold on the Auction House.", fua = "Рідкісна риба, родом із Кель'Таласу. Можна купувати й продавати на Аукціоні." }
    t[238377] = { name = "Кровний ловець", fen = "A rare fish native to Quel'Thalas and sometimes found in Voidstorm. Can be bought and sold on the Auction House.", fua = "Рідкісна риба родом з Кель'Таласу, яку інколи трапляється спіймати в Бурі Порожнечі. Можна купити й продати на Аукціоні." }
    t[238378] = { name = "Мерехтлива сирена", fen = "An uncommon fish native to Voidstorm. Can be bought and sold on the Auction House.", fua = "Незвичайна риба, що водиться в Бурі Порожнечі. Її можна купити й продати на Аукціоні." }
    t[238379] = { name = "Мудра викривлянка", fen = "A rare fish native to Voidstorm. Can be bought and sold on the Auction House.", fua = "Рідкісна риба, родом із Бурі Порожнечі. Її можна купити й продати на Аукціоні." }
    t[238380] = { name = "Нуль-пусториба", fen = "A rare fish caught within Voidstorm. Can be bought and sold on the Auction House.", fua = "Рідкісна риба, виловлена в Бурі Порожнечі. Можна купувати й продавати на Аукціоні." }
    t[238381] = { name = "Порожнистий групер", fen = "A rare fish native to Voidstorm. Can be bought and sold on the Auction House.", fua = "Рідкісна риба, родом із Бурі Порожнечі. Її можна купити й продати на Аукціоні." }
    t[238382] = { name = "Кривава гупі", fen = "A common fish caught within Quel'Thalas. Can be bought and sold on the Auction House.", fua = "Звичайна риба, що водиться в Кель'Таласі. Можна купити й продати на Аукціоні." }
    t[238383] = { name = "Форель Вічної Пісні", fen = "A rare fish caught within Quel'Thalas. Can be bought and sold on the Auction House.", fua = "Рідкісна риба, що виловлюється в Кель'Таласі. Можна купити й продати на Аукціоні." }
    t[238384] = { name = "Риба Сонячного Колодязя", fen = "An uncommon fish in Quel'Thalas. Can be bought and sold on the Auction House.", fua = "Незвичайна риба в Кель'Таласі. Можна купити й продати на Аукціоні." }
    t[238387] = "Магічна мульча"
    t[238388] = "Просякнутий перегній"
    t[238389] = "Підсилений Перегній"
    t[238417] = { name = "Ослаблений альнів пил", fen = "The cosmic foundation that forms the creatures of the Rift of Aln.", fua = "Космічна основа, з якої постають створіння Розлому Альну." }
    t[238465] = { name = "Таласське перо фенікса", fen = "A petal of the elusive Thalassian Phoenix Tail. Studying it can provide vital knowledge of the local flora.", fua = "Пелюстка невловимого таласського феніксохвоста. Її вивчення дає важливі знання про місцеву флору." }
    t[238466] = { name = "Таласський феніксохвіст", fen = "A full sample of the exceedingly rare Thalassian Phoenix Tail flower. While it doesn't have any practical use in crafting, it can provide a significant amount of knowledge of the local flora. You likely won't find another for a while!", fua = "Повноцінний зразок надзвичайно рідкісної квітки таласського феніксохвоста. Хоч вона й не має практичного застосування у виготовленні, та може дати чимало знань про місцеву флору. Іншу ви знайдете ще нескоро!" }
    t[238467] = { name = "Таласський жар фенікса", fen = "A nascent sample of a Thalassian Phoenix Tail flower. Not useful for any practical purposes, but still useful to study the local flora.", fua = "Юний зразок квітки таласського феніксохвоста. Непридатний для практичного вжитку, та все ж корисний для вивчення місцевої флори." }
    t[238468] = "Розквітла брунька"
    t[238469] = "Розмашиста коса женця"
    t[238470] = "Прості садові ножиці"
    t[238471] = "Корінь Світлоцвіту"
    t[238472] = { name = "Лопата", fen = "Calling it like I see it.", fua = "Називаю речі своїми іменами." }
    t[238473] = "Серп женця"
    t[238474] = "Дивний лотос"
    t[238475] = "Садова лопата"
    t[238476] = { name = "Подразливі спори", fen = "Sticky and prickly.", fua = "Липкі й колючі." }
    t[238477] = { name = "Гниле м'ясо", fen = "Yuck!", fua = "Фе!" }
    t[238478] = "Мерехтлива морська трава"
    t[238479] = { name = "Подерта закидна сіть", fen = "This ain't catchin' nothin'.", fua = "Цим нічого не вловиш." }
    t[238480] = { name = "Відкрита скринька", fen = "Someone was here...", fua = "Тут уже хтось побував..." }
    t[238481] = { name = "Блискуче сміття", fen = "It's pretty... pretty ugly!", fua = "Воно гарне... аж бридке!" }
    t[238482] = { name = "Цілісінька купа нічого", fen = "What more could you ask for.", fua = "Чого ще можна бажати." }
    t[238483] = { name = "Донна Трава", fen = "Not as good as Top Grass.", fua = "Не така добра, як Верхня Трава." }
    t[238484] = "Вологий рушничок"
    t[238485] = { name = "Гротескна кулька", fen = "Don't know what it is, and I don't like it.", fua = "Не знаю, що це, і мені воно не до вподоби." }
    t[238486] = { name = "Порожня Бляшанка", fen = "It would be so epic if this can was full.", fua = "Було б так епічно, якби ця бляшанка була повна." }
    t[238487] = { name = "Бляшанка для копання", fen = "This can is only for kickin'!", fua = "Ця бляшанка лише для того, щоб її копати!" }
    t[238488] = { name = "Точно камінь", fen = "Ain't much to it.", fua = "Та й по всьому." }
    t[238489] = { name = "Точно не камінь", fen = "An expertly engineered weapon to be used on friends or foes.", fua = "Майстерно сконструйована зброя для застосування проти друзів чи ворогів." }
    t[238490] = { name = "Невиразний камінь", fen = "We aren't quite sure what this one is. Give it a second and it might come to you.", fua = "Ми не зовсім певні, що це таке. Подумай хвильку, і, може, тебе осяє." }
    t[238491] = { name = "Шепітний камінь", fen = "You swear this rock said something to you.", fua = "Ти можеш заприсягтися, що цей камінь щось тобі сказав." }
    t[238492] = { name = "Мовчазний камінь", fen = "Suspiciously quiet, for a rock.", fua = "Підозріло тихий, як для каменя." }
    t[238493] = { name = "Кричущий камінь", fen = "This rock needs to chill out, right?", fua = "Цьому каменю варто б охолонути, еге ж?" }
    t[238494] = { name = "Чужий скарб", fen = "Your treasure! Congratulations!", fua = "Твій скарб! Вітаємо!" }
    t[238495] = { name = "Сміття одного рибалки", fen = "Perhaps another's treasure!", fua = "Можливо, скарб для іншого!" }
    t[238496] = { name = "Верхня трава", fen = "Way better than Bottom Grass.", fua = "Куди краща за Нижню траву." }
    t[238511] = { name = "Шкіра, загартована Порожнечею", fen = "Acquired by players with the Skinning skill. Can be bought and sold on the Auction House.", fua = "Здобувається гравцями з умінням білування. Можна купити й продати на аукціоні." }
    t[238512] = { name = "Шкіра, загартована Порожнечею", fen = "Acquired by players with the Skinning skill. Can be bought and sold on the Auction House.", fua = "Здобувається гравцями з умінням білування. Можна купити й продати на аукціоні." }
    t[238513] = { name = "Луска, загартована Порожнечею", fen = "Acquired by players with the Skinning skill. Can be bought and sold on the Auction House.", fua = "Здобувається гравцями з умінням білування. Можна купити й продати на аукціоні." }
    t[238514] = { name = "Луска, загартована Порожнечею", fen = "Acquired by players with the Skinning skill. Can be bought and sold on the Auction House.", fua = "Здобувається гравцями з умінням білування. Можна купити й продати на аукціоні." }
    t[238515] = { name = "Забутий черепокол", fen = "This could be from Stromgarde's attack or the Red Dawn's ambush.", fua = "Це могло лишитися від нападу Стромґарда або засідки Червоного Світанку." }
    t[238516] = { name = "Зламаний довгий меч", fen = "Many human soldiers lost their lives due to Marran Trollbane's \"decisive leadership.\"", fua = "Багато людських воїнів наклали життям через «рішуче командування» Марран Троллбейн." }
    t[238518] = { name = "Шкура, загартована Порожнечею", fen = "Acquired by players with the Skinning skill. Can be bought and sold on the Auction House.", fua = "Здобувається гравцями з умінням білування. Можна купити й продати на аукціоні." }
    t[238519] = { name = "Шкура, загартована Порожнечею", fen = "Acquired by players with the Skinning skill. Can be bought and sold on the Auction House.", fua = "Здобувається гравцями з умінням білування. Можна купити й продати на аукціоні." }
    t[238520] = { name = "Панцир, загартований Порожнечею", fen = "Acquired by players with the Skinning skill. Can be bought and sold on the Auction House.", fua = "Здобувається гравцями з умінням білування. Можна купити й продати на аукціоні." }
    t[238521] = { name = "Панцир, загартований Порожнечею", fen = "Acquired by players with the Skinning skill. Can be bought and sold on the Auction House.", fua = "Здобувається гравцями з умінням білування. Можна купити й продати на аукціоні." }
    t[238522] = { name = "Незрівнянне оперення", fen = "An uncommon species-specific material gathered from feathered creatures with the Skinning skill. Can be bought and sold on the Auction House.", fua = "Незвичайний видоспецифічний матеріал, що збирається з пернатих створінь за допомогою вміння білування. Можна купити й продати на аукціоні." }
    t[238523] = { name = "Гострий ікло", fen = "An uncommon species-specific material gathered from fanged creatures with the Skinning skill. Can be bought and sold on the Auction House.", fua = "Незвичайний видоспецифічний матеріал, що його збирають з ікластих істот навичкою білування. Можна купувати й продавати на Аукціоні." }
    t[238525] = { name = "Дивовижне хутро", fen = "An uncommon species-specific material gathered from furred creatures with the Skinning skill. Can be bought and sold on the Auction House.", fua = "Незвичайний видоспецифічний матеріал, що збирається з хутряних істот за допомогою вміння Білування. Можна купити й продати на Аукціоні." }
    t[238528] = { name = "Величний кіготь", fen = "A majestic material gathered from Renowned Beasts with the Skinning skill. Can be bought and sold on the Auction House.", fua = "Величний матеріал, здобутий з Уславлених звірів за допомогою вміння Білування. Можна купити й продати на Аукціоні." }
    t[238529] = { name = "Велична шкура", fen = "A majestic material gathered from Renowned Beasts with the Skinning skill. Can be bought and sold on the Auction House.", fua = "Величний матеріал, здобутий з Уславлених звірів за допомогою вміння Білування. Можна купити й продати на Аукціоні." }
    t[238530] = { name = "Величний плавець", fen = "A majestic material gathered from Renowned Beasts with the Skinning skill. Can be bought and sold on the Auction House.", fua = "Величний матеріал, здобутий з Уславлених звірів за допомогою вміння Білування. Можна купити й продати на Аукціоні." }
    t[238531] = { name = "Сяйливий шлунок", fen = "Its contents are both infinitely valuable and useless until you check what's inside!", fua = "Його вміст водночас безмежно цінний і марний, доки ти не зазирнеш усередину!" }
    t[238532] = "Флакон дивовиж Лісу Вічної Пісні"
    t[238533] = "Флакон дивовиж Бурі Порожнечі"
    t[238534] = "Флакон дивовиж Кореневих земель"
    t[238535] = "Флакон дивовиж Зул'Аману"
    t[238536] = "Свіжозірваний мироцвіт"
    t[238537] = "Мирний ополоник"
    t[238538] = "Бездоганне зілля"
    t[238539] = "Невдалий експеримент"
    t[238540] = "Розібрані ковальські техніки"
    t[238541] = "Ковальський набір Сільвермуна"
    t[238542] = "Дбайливо складений спис"
    t[238543] = "Шпаргалка з обробки металу"
    t[238544] = "Оборонний спис Бурі Порожнечі"
    t[238545] = "Меч флорадоглядача рутаані"
    t[238546] = "Ковальська булава майстра сін'дорей"
    t[238547] = "Коваль молот Сільвермуна"
    t[238548] = "Зачарована маска амані"
    t[238549] = "Зачарований шовк сонячного вогню"
    t[238550] = "Чистий кристал Порожнечі"
    t[238551] = "Вічнопалаюча сонячна порошинка"
    t[238552] = "Ентропійний осколок"
    t[238553] = "Сфера первісної есенції"
    t[238554] = "Благословенний лоа пил"
    t[238555] = "Чаклунська паличка сін'дорей"
    t[238556] = "Мотлох одного інженера"
    t[238557] = "Мініатюрний транспортний ялик"
    t[238558] = "Посібник помилок і прикрощів"
    t[238559] = "Прудкий пілон"
    t[238560] = "Ефірний штормовий ключ"
    t[238561] = "Офлайн-помічник-бот"
    t[238562] = { name = "Що робити, коли нічого не працює", fen = "Its sole purpose is to pass condiments.", fua = "Її єдине призначення — подавати приправи." }
    t[238563] = "Зручний гайковий ключ"
    t[238572] = "Торкнуте Порожнечею перо"
    t[238573] = "Техніки в шкіряній оправі"
    t[238574] = "Запасне чорнило"
    t[238575] = "Мітка безстрашного дослідника"
    t[238576] = "Залишок пігменту кровотерну"
    t[238577] = "Недопрацьовані техніки"
    t[238578] = "Перо композитора"
    t[238579] = "Гусяче перо композитора"
    t[238580] = "Майстерне долото сін'дорей"
    t[238581] = "Гіпотетичний кристал Бурі Порожнечі"
    t[238582] = "Двофункційні Лупи"
    t[238583] = "Погано закруглена пляшечка"
    t[238584] = "Розбите скло"
    t[238585] = "Старовинний самоцвіт душі"
    t[238586] = "Ефірні щипці для самоцвітів"
    t[238587] = "Гранувальники самоцвітів сін'дорей"
    t[238588] = "Кушнірський інструмент амані"
    t[238589] = "Ефірний ніж для обробки шкіри"
    t[238590] = "Престижно вичинена шкура"
    t[238591] = "Стос дрібничок чинбаря"
    t[238592] = "Викрійки: За межею Порожнечі"
    t[238593] = "Молоток для шкіряної справи гаранірів"
    t[238594] = "Ніж для шкіряної справи гаранірів"
    t[238595] = "Виважене замовлення майстра"
    t[238596] = "Шахтарський провідник Бурею Порожнечі"
    t[238597] = "Щасливий талісман дослідника печер"
    t[238598] = "Загублена торба Бурі Порожнечі"
    t[238599] = "Масивні рудні пробійники"
    t[238600] = "Мерехтлива перлина Порожнечі"
    t[238601] = "Різець знавця амані"
    t[238602] = "Поклад зоряного металу"
    t[238603] = "Запасний експедиційний смолоскип"
    t[238612] = "Дитяча м'яка іграшка"
    t[238613] = "Дуже гарна штора"
    t[238614] = "Кравецька лінійка сін'дорей"
    t[238615] = "Дерев'яний ткацький меч"
    t[238616] = "Книга Швів Сін'дорей"
    t[238617] = "Атласна декоративна подушка"
    t[238618] = "Надзвичайно чарівна скатертина"
    t[238619] = "Накривний гребінь майстра"
    t[238625] = { name = "Тонка загартована Порожнечею шкура", fen = "A particularly fine trophy pelt that is far more useful for studying anatomy of the local fauna than it is for crafting.", fua = "Особливо гарна трофейна шкура, яка значно корисніша для вивчення анатомії місцевої фауни, ніж для ремесла." }
    t[238626] = { name = "Маною просякнута кістка", fen = "A bone notably saturated in magical energy. This isn't a common occurrence, and will make for fascinating study material.", fua = "Кістка, помітно насичена магічною енергією. Таке трапляється нечасто, тож вона стане захопливим матеріалом для вивчення." }
    t[238627] = { name = "Маною насичений зразок", fen = "A small tuft of fur with a mild amount of latent mana floating about it. Great for studying, not so great for crafting.", fua = "Маленький жмутик хутра з невеликою кількістю прихованої мани, що ширяє довкола. Чудовий для вивчення, але не надто придатний для виготовлення." }
    t[238628] = "Уражена Світлоцвітом шкура"
    t[238629] = "Білувальний ніж загону"
    t[238630] = "Первісна шкура"
    t[238631] = "Зразок шкіри з Бурі Порожнечі"
    t[238632] = "Дубильна олія амані"
    t[238633] = "Олія для дублення сін'дорей"
    t[238634] = "Ніж для білування амані"
    t[238635] = "Таласський ніж для білування"
    t[238651] = { name = "Гриб, вирощений на Альні", fen = "Sparkles with Alndust. Amarakk can grind it down to a fine weapon coating.", fua = "Виблискує альнопилом. Амаракк може перетерти його на тонке покриття для зброї." }
    t[238652] = { name = "Велична принада Лісу Вічної Пісні", fen = "A bait made to lure a majestic beast out of hiding within Eversong Woods.", fua = "Принада, створена, щоб виманити величного звіра з його схованки у Лісі Вічної Пісні." }
    t[238653] = { name = "Велична принада Зул'Аману", fen = "A bait made to lure a majestic beast out of hiding within Zul'Aman.", fua = "Принада, створена, щоб виманити величного звіра з його схованки в Зул'Амані." }
    t[238654] = { name = "Велична принада Гарандара", fen = "A bait made to lure a majestic beast out of hiding within Harandar.", fua = "Принада, створена, щоб виманити величного звіра з його схованки в Гарандарі." }
    t[238655] = { name = "Велична принада Бурі Порожнечі", fen = "A bait made to lure a majestic beast out of hiding within Voidstorm.", fua = "Принада, створена, щоб виманити величного звіра з його схованки в Бурі Порожнечі." }
    t[238656] = { name = "Велика принада на звірину", fen = "A bait made to lure the fiercest of the majestic beasts out of hiding.", fua = "Принада, створена, щоб виманити найлютіших із величних звірів зі сховку." }
    t[238657] = { name = "Розпилювач Світлоцвіту", fen = "A special device designed to imbue the targeted creature with Lightbloom energy.", fua = "Особливий пристрій, призначений наповнювати ціль енергією Світлоцвіту." }
    t[238658] = { name = "Дикий розсіювач", fen = "A special device designed to imbue the targeted creature with Wild energy.", fua = "Особливий пристрій, створений, щоб наповнити обрану істоту Дикою енергією." }
    t[238659] = { name = "Первісний розпорошувач", fen = "A special device designed to imbue the targeted creature with Primal energy.", fua = "Особливий пристрій, створений для насичення обраної істоти первісною енергією." }
    t[238660] = { name = "Розсіювач Порожнечі", fen = "A special device designed to imbue the targeted creature with Void energy.", fua = "Особливий пристрій, призначений наповнювати цільову істоту енергією Порожнечі." }
    t[238677] = { name = "Гудуче ядро", fen = "The surface of this orb is seemingly made from a collection of revolving runes.", fua = "Поверхня цієї кулі, схоже, складена з безлічі рун, що обертаються." }
    t[238730] = { name = "Арканний годинник", fen = "A timepiece showing the creator's past in snapshots of time. Using the item potentially stirs up anomalies.", fua = "Годинник, що показує минуле свого творця миттєвими знімками часу. Використання предмета може здіймати аномалії." }
    t[238738] = { name = "Великий пил Альну", fen = "It's almost too bright to look at.", fua = "На нього майже надто яскраво дивитися." }
    t[238779] = { name = "Сигіл Торентії", fen = "A burning symbol of ambition. The essence of Torentia's authority.", fua = "Палаючий символ амбіцій. Сутність влади Торентії." }
    t[238792] = { name = "Артефакти гаранірів", fen = "Objects left behind from the haranir guests who promote good rutaani relations.", fua = "Речі, що залишили гості-гараніри, які зміцнюють добрі стосунки з рутаані." }
    t[238807] = { name = "Викривлений розтинач", fen = "As swift and unpredictable as Prince Kael'thas's temper.", fua = "Стрімкий і непередбачуваний, як норов принца Кель'таса." }
    t[238842] = { name = "Космічний насичувач", fen = "Infused with the power of the stars and the darkness between them.", fua = "Насичений силою зір і темряви поміж ними." }
    t[238843] = { name = "Спустошення", fen = "\"Devastation never gave their loa time to answer their prayers.\" -- Triellyde, Troll Wars Veteran", fua = "«Спустошення не дало їхнім лоа часу відповісти на молитви». — Трієллайд, ветеран Тролячих воєн" }
    t[238844] = { name = "Клинки нескінченності", fen = "Serving the king in ways he must never know of.", fua = "Служать королю так, як він ніколи не має дізнатися." }
    t[238845] = { name = "Посох розпаду", fen = "Disintegration is one of the simplest types of magic, but simple and easy are not the same.", fua = "Розпад — один із найпростіших видів магії, але просте й легке — не те саме." }
    t[238846] = { name = "Довгий лук із ниток Нечестя", fen = "You can feel the pull of the Twisting Nether guiding the arrow to the heart of its target.", fua = "Ви відчуваєте, як притягання Виру Нечестя скеровує стрілу прямо в серце цілі." }
    t[238864] = "Проголошення Світла"
    t[238890] = { name = "Згуба Погибелі", fen = "\"Forge our rage into justice!\" -- Kael'thas Sunstrider", fua = "«Скуй наш гнів у справедливість!» — Кель'тас Сонцеблукач" }
    t[238891] = "Скалка наару"
    t[238923] = { name = "Розколоте вугілля", fen = "This coal is splintered and crumbled, having fallen off of a creature's skin.", fua = "Це вугілля розтріскане й розкришене — воно відпало зі шкіри якоїсь істоти." }
    t[238944] = { name = "Подертий матеріал", fen = "Whatever this was, it is completely unusable due to damage not even the most skilled crafter can overcome.", fua = "Чим би це не було, воно геть непридатне через ушкодження, з якими не впорається навіть найвправніший ремісник." }
    t[238962] = { name = "Тріски світлодерева", fen = "A small bag of wood scraps, left over after chopping and shaving down larger planks.", fua = "Невеликий мішечок з обрізками дерева, що лишилися після рубання і стругання більших дощок." }
    t[238964] = { name = "Викрадене спорядження", fen = "Tampered-with tools taken from the logging camp, some broken beyond repair.", fua = "Зіпсовані інструменти, взяті з лісозаготівельного табору; деякі поламані без надії на ремонт." }
    t[238987] = { name = "Прихильність Салтеріла", fen = "Can be traded with attendees at Saltheril's Haven to unlock tasks.", fua = "Можна обмінювати з гостями Гавані Салтеріла, щоб відкривати завдання." }
    t[239014] = { name = "Крижані ягоди", fen = "Small blue berries plucked from a scraggly shrub. They are sour, tangy, and leave a cold, refreshing feeling on the tongue.", fua = "Маленькі сині ягоди, зірвані з миршавого кущика. Вони кислуваті, терпкі й лишають на язику холодне, освіжаюче відчуття." }
    t[239022] = { name = "Еліксир Морської Щедрості", fen = "An elixir that gives water breathing and swim speed for a duration.", fua = "Еліксир, що на певний час дарує дихання під водою та швидкість плавання." }
    t[239067] = { name = "Світлисті волокна", fen = "These golden fibers leave a shimmery residue on everything they touch.", fua = "Ці золотаві волокна лишають мерехтливий слід на всьому, чого торкаються." }
    t[239077] = { name = "Купа сяк-так значущого м'яса", fen = "A pile of meat left over from a creature you skinned. It could be from the creature itself, or something it ate. Only one way to find out!", fua = "Купа м'яса, що лишилася від обдертої вами істоти. Воно може бути з неї самої або з того, що вона з'їла. Є лише один спосіб дізнатися!" }
    t[239083] = { name = "Голова Брулага Трощила", fen = "Flecked with gore and battered with bruises.", fua = "Заляпана кров'ю та вкрита синцями." }
    t[239130] = { name = "Смолоскип", fen = "A straightforward solution to the Dark Horde's banners.", fua = "Простий спосіб упоратися з прапорами Темної Орди." }
    t[239131] = { name = "Вплив Амаракка", fen = "The Shul'ka's power, in the palm of your hand...", fua = "Сила шул'ка, у долоні твоєї руки..." }
    t[239134] = { name = "Плани проникнення", fen = "A map of Eversong, with key locations marked for annihilation.", fua = "Карта Лісу Вічної Пісні з позначеними ключовими місцями для знищення." }
    t[239138] = { name = "Брус світлодерева", fen = "The cut wood feels comfortably warm to the touch and seems to emit the faintest glow from the inside grain.", fua = "Зрізане дерево приємно тепле на дотик і ніби випромінює ледь помітне сяйво зсередини волокон." }
    t[239151] = "Поклик Світла"
    t[239195] = { name = "Зім'ятий щит Лотара", fen = "Adorned with a dented lion's head. No longer effective, yet the metal is infused with incredible power.", fua = "Оздоблений увігнутою лев'ячою головою. Уже непридатний, та метал просякнутий неймовірною силою." }
    t[239198] = { name = "Сувій арканового плетива", fen = "A bolt woven by Tailors and infused with Arcane magics. Can be bought and sold on the Auction House.", fua = "Сувій, витканий кравцями й просочений арканною магією. Можна купити й продати на Аукціоні." }
    t[239199] = { name = "Відживлювальний напій", fen = "This thin liquid has a mild floral odor.", fua = "Ця рідина має легкий квітковий запах." }
    t[239200] = { name = "Сувій арканового плетива", fen = "A bolt woven by Tailors and infused with Arcane magics. Can be bought and sold on the Auction House.", fua = "Сувій, витканий кравцями й просочений арканною магією. Можна купити й продати на Аукціоні." }
    t[239201] = { name = "Сувій шовку сонячного вогню", fen = "Woven by Tailors and infused with Sunwell energies. Can be bought and sold on the Auction House.", fua = "Зітканий кравцями й насичений енергіями Сонячного Колодязя. Можна купити й продати на Аукціоні." }
    t[239202] = { name = "Сувій шовку сонячного вогню", fen = "Woven by Tailors and infused with Sunwell energies. Can be bought and sold on the Auction House.", fua = "Зітканий кравцями й насичений енергіями Сонячного Колодязя. Можна купити й продати на Аукціоні." }
    t[239226] = { name = "[DNT]zzOldVoid Resonator", fen = "Delicately crafted and calibrated.", fua = "Дбайливо виготовлений і відкалібрований." }
    t[239447] = { name = "Плакучі спори", fen = "The boars that eat weeping caps will develop tears carrying these spores, sowing them for future generations.", fua = "Вепри, що поїдають плакучі шапки, починають ронити сльози з цими спорами, засіваючи їх для прийдешніх поколінь." }
    t[239480] = { name = "Стійка жила", fen = "This sinew hardens as it ages, creating a bond that always remains.", fua = "Ця жила твердне з віком, утворюючи зв'язок, що лишається назавжди." }
    t[239483] = { name = "Опала гілка Кан'ши", fen = "Every shed branch carries a little poison away from Kan'sha's heartwood.", fua = "Кожна опала гілка несе геть трохи отрути від серцевини Кан'ши." }
    t[239494] = { name = "Вивітрений уламок святині", fen = "Even a weak foundation can find new use.", fua = "Навіть слабка основа може знайти нове застосування." }
    t[239496] = { name = "Сплюндровані нотатки", fen = "This book was once full of Void theorems, but someone has torn out most of the pages.", fua = "Ця книга колись була повна теорем Порожнечі, але хтось видер більшість сторінок." }
    t[239498] = { name = "Дивний знак", fen = "Humming with latent void energy.", fua = "Гуде прихованою енергією Порожнечі." }
    t[239511] = { name = "Виснажений руйнівник оберегів", fen = "Runes are interwoven along the surface, faint and dull, waiting to be refilled with magic.", fua = "Поверхнею переплетені руни, бліді й тьмяні, що чекають, аби їх знову наповнили магією." }
    t[239608] = { name = "Викривальні документи", fen = "Records of fel magic misuse and receipts showing they were paid off with Magisterial funds. Several reports about kidnappings in Murder Row are mixed into the pile.", fua = "Записи про зловживання магією Скверни та квитанції, що доводять оплату коштами магістрату. До купи підмішано кілька повідомлень про викрадення у Завулку Убивць." }
    t[239635] = "Алхімічний Комбінезон Витонченого Ремісника"
    t[239636] = "Кухарський Ковпак Витонченого Ремісника"
    t[239637] = "Капелюх Накладача Чарів Витонченого Ремісника"
    t[239638] = "Рибальський Капелюх Витонченого Ремісника"
    t[239639] = "Капелюх Травника Витонченого Ремісника"
    t[239640] = "Кравецька Роба Витонченого Ремісника"
    t[239641] = "Алхімічний Фартух із Яскравого Полотна"
    t[239642] = "Кухарський ковпак зі світлого льону"
    t[239643] = "Капелюх Зачаровника з Яскравого Полотна"
    t[239644] = "Рибальський Капелюх із Яскравого Полотна"
    t[239645] = "Капелюх Травника з Яскравого Полотна"
    t[239646] = "Кравецька Мантія з Яскравого Полотна"
    t[239648] = "Пов'язки мученика"
    t[239649] = "Пояс мученика"
    t[239650] = "Накидка мученика"
    t[239651] = "Поножі мученика"
    t[239652] = "Корона мученика"
    t[239653] = "Рукавиці мученика"
    t[239654] = "Капці мученика"
    t[239655] = "Шати мученика"
    t[239656] = "Шовкове покривало прибічника"
    t[239657] = "Наручі сонячного вогню"
    t[239658] = "Плащ сонячного вогню"
    t[239659] = "Чоботи сонячного вогню"
    t[239660] = "Наручі з арканового плетива"
    t[239661] = "Плащ з арканового плетива"
    t[239662] = "Чоботи з арканового плетива"
    t[239663] = "Пояс сонячного вогню"
    t[239664] = "Шнур з арканового плетива"
    t[239668] = "Придворний шолом"
    t[239669] = "Придворні рукавиці"
    t[239670] = "Придворний пояс"
    t[239671] = "Придворні наручі"
    t[239672] = "Придворна мантія"
    t[239673] = "Придворні черевики"
    t[239674] = "Придворний плащ"
    t[239675] = "Придворні наплічники"
    t[239676] = "Придворні штани"
    t[239677] = "Тканинні напульсники таласського змагуна"
    t[239678] = "Тканинний плащ таласського змагуна"
    t[239679] = "Тканинні рукавички таласського змагуна"
    t[239680] = "Тканинний каптур таласського змагуна"
    t[239681] = "Тканинні штани таласського змагуна"
    t[239682] = "Тканинний кушак таласського змагуна"
    t[239683] = "Тканинні наплічники таласського змагуна"
    t[239684] = "Тканинні черевики таласського змагуна"
    t[239685] = "Тканинна туніка таласського змагуна"
    t[239700] = { name = "Сувій Яскравого Полотна", fen = "A bolt woven by Tailors. Can be bought and sold on the Auction House.", fua = "Сувій, витканий кравцями. Його можна купити й продати на Аукціоні." }
    t[239701] = { name = "Сувій Яскравого Полотна", fen = "A bolt woven by Tailors. Can be bought and sold on the Auction House.", fua = "Сувій, витканий кравцями. Його можна купити й продати на Аукціоні." }
    t[239702] = { name = "Просякнутий сувій світлого льону", fen = "A bolt woven by Tailors. Can be bought and sold on the Auction House.", fua = "Сувій, витканий кравцями. Його можна купити й продати на Аукціоні." }
    t[239703] = { name = "Просякнутий сувій світлого льону", fen = "A bolt woven by Tailors. Can be bought and sold on the Auction House.", fua = "Сувій, витканий кравцями. Його можна купити й продати на Аукціоні." }
    t[239711] = "Бинт із Яскравого Полотна"
    t[239713] = "Бинт із Яскравого Полотна"
    t[240094] = "Чародійна нитка із шовку сонячного вогню"
    t[240133] = "Чародійна нитка із шовку сонячного вогню"
    t[240154] = "Чароткана нитка з арканового плетива"
    t[240155] = "Чароткана нитка з арканового плетива"
    t[240156] = "Чарівна Нитка з Яскравого Полотна"
    t[240157] = "Чарівна Нитка з Яскравого Полотна"
    t[240158] = "Рюкзак для реагентів з арканового плетива"
    t[240159] = "Торбинка для Реагентів із Яскравого Полотна"
    t[240160] = "Просякнутий наплічник зі світлого льону"
    t[240161] = "Наплічник із шовку сонячного вогню"
    t[240164] = { name = "Підкладка із шовку сонячного вогню", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[240165] = { name = "Підкладка із шовку сонячного вогню", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[240166] = { name = "Підкладка з арканового плетива", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[240167] = { name = "Підкладка з арканового плетива", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[240484] = { name = "Загублені небесні скалки", fen = "Though they seem to fall throughout Harandar, no one is certain where skyshards come from.", fua = "Хоч вони, здається, падають по всьому Гарандару, ніхто не певен, звідки беруться небесні скалки." }
    t[240485] = { name = "Ціла гілка смолораптора", fen = "Known for their fragrance and flavor, haranir wrap their meals in these fronds before steaming them over boiling water.", fua = "Відомі своїм ароматом і смаком, гараніри загортають у ці гілки свою їжу, перш ніж готувати її на парі над окропом." }
    t[240831] = { name = "Щоденник Гієрона", fen = "A battered journal carried by Riftwalker Hieron.", fua = "Пошарпаний щоденник, що його носив із собою Гієрон, Мандрівник Розломів." }
    t[240838] = { name = "Послання Клинка Сутінків", fen = "Crucial information about the Twilight's Blade, penned in a cryptic hand.", fua = "Важливі відомості про Клинок Сутінків, написані загадковою рукою." }
    t[240840] = { name = "Кусайчик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[240855] = "Швидкий перидот"
    t[240856] = "Швидкий перидот"
    t[240857] = "Смертоносний перидот"
    t[240858] = "Смертоносний перидот"
    t[240859] = "Майстерний перидот"
    t[240860] = "Майстерний перидот"
    t[240861] = "Універсальний перидот"
    t[240862] = "Універсальний перидот"
    t[240863] = "Майстерний аметист"
    t[240864] = "Майстерний аметист"
    t[240865] = "Смертоносний аметист"
    t[240866] = "Смертоносний аметист"
    t[240867] = "Швидкий аметист"
    t[240868] = "Швидкий аметист"
    t[240869] = "Універсальний аметист"
    t[240870] = "Універсальний аметист"
    t[240871] = "Смертоносний гранат"
    t[240872] = "Смертоносний гранат"
    t[240873] = "Швидкий гранат"
    t[240874] = "Швидкий гранат"
    t[240875] = "Майстерний гранат"
    t[240876] = "Майстерний гранат"
    t[240877] = "Універсальний гранат"
    t[240878] = "Універсальний гранат"
    t[240879] = "Універсальний лазурит"
    t[240880] = "Універсальний лазурит"
    t[240881] = "Смертоносний лазурит"
    t[240882] = "Смертоносний лазурит"
    t[240883] = "Швидкий лазурит"
    t[240884] = "Швидкий лазурит"
    t[240885] = "Майстерний лазурит"
    t[240886] = "Майстерний лазурит"
    t[240887] = "Бездоганний швидкий перидот"
    t[240888] = "Бездоганний швидкий перидот"
    t[240889] = "Бездоганний смертоносний перидот"
    t[240890] = "Бездоганний смертоносний перидот"
    t[240891] = "Бездоганний майстерний перидот"
    t[240892] = "Бездоганний майстерний перидот"
    t[240893] = "Бездоганний універсальний перидот"
    t[240894] = "Бездоганний універсальний перидот"
    t[240895] = "Бездоганний майстерний аметист"
    t[240896] = "Бездоганний майстерний аметист"
    t[240897] = "Бездоганний смертоносний аметист"
    t[240898] = "Бездоганний смертоносний аметист"
    t[240899] = "Бездоганний швидкий аметист"
    t[240900] = "Бездоганний швидкий аметист"
    t[240901] = "Бездоганний універсальний аметист"
    t[240902] = "Бездоганний універсальний аметист"
    t[240903] = "Бездоганний смертоносний гранат"
    t[240904] = "Бездоганний смертоносний гранат"
    t[240905] = "Бездоганний швидкий гранат"
    t[240906] = "Бездоганний швидкий гранат"
    t[240907] = "Бездоганний майстерний гранат"
    t[240908] = "Бездоганний майстерний гранат"
    t[240909] = "Бездоганний універсальний гранат"
    t[240910] = "Бездоганний універсальний гранат"
    t[240911] = "Бездоганний універсальний лазурит"
    t[240912] = "Бездоганний універсальний лазурит"
    t[240913] = "Бездоганний смертоносний ляпіс"
    t[240914] = "Бездоганний смертоносний ляпіс"
    t[240915] = "Бездоганний швидкий лазурит"
    t[240916] = "Бездоганний швидкий лазурит"
    t[240917] = "Бездоганний майстерний ляпіс"
    t[240918] = "Бездоганний майстерний ляпіс"
    t[240946] = { name = "Перетравлена річ", fen = "Who knows what it could be? It certainly has been there for a while though.", fua = "Хтозна, що це могло бути? Та одне певно — вона тут уже чимало пролежала." }
    t[240947] = "Сяйлива мідна каблучка"
    t[240948] = "Нічний амулет"
    t[240949] = "Майстерний перстень сін'дорей"
    t[240950] = "Майстерний амулет сін'дорей"
    t[240951] = "Перстень-печатка таласського змагуна"
    t[240952] = "Амулет таласського змагуна"
    t[240953] = "Біфокальні Окуляри Завзятого Біографа"
    t[240954] = "Дивовижна фокусувальна лупа для шрифту"
    t[240955] = "Лупи Сільвермуна"
    t[240956] = "Зосереджувальний осколок Сільвермуна"
    t[240957] = "Окуляри писаря сін'дорей"
    t[240958] = { name = "Удосконалена лупа для правші", fen = "For when the Right-Handed Magnifying Glass wasn't cutting it.", fua = "Для випадків, коли звичайної лупи для правші вже замало." }
    t[240959] = "Ювелірні лупи сін'дорей"
    t[240960] = "Кристал чаклуна сін'дорей"
    t[240961] = { name = "Частково перетравлене намисто з портретом Лор'темара", fen = "It appears someone was quite the fan.", fua = "Схоже, хтось був неабияким фанатом." }
    t[240962] = { name = "Пожований лист відданості", fen = "A once-sweet letter, now a shredded mess, as if the creature preferred the taste of romance over reading it.", fua = "Колись ніжний лист, тепер пошматований, наче істоті більше смакувала романтика, ніж саме читання." }
    t[240963] = { name = "Розмоклий примірник «Магія і ти: арканне пробудження»", fen = "The creature clearly found this spellbinding, but unfortunately chewed through it faster than it could absorb any knowledge.", fua = "Створіння вочевидь вважало це захопливим, але, на жаль, прогризло книгу швидше, ніж устигло засвоїти бодай якісь знання." }
    t[240964] = { name = "Пошарпаний сувій ельфійського етикету", fen = "The creature has devoured this scroll, though it seems it missed the point.", fua = "Істота пожерла цей сувій, проте, схоже, так і не вловила його суті." }
    t[240965] = { name = "Напівз'їдений дипломатичний лист", fen = "'WARNING: HIGHLY CONFI--' The rest has been digested.", fua = "«ПОПЕРЕДЖЕННЯ: ЦІЛКОМ ТАЄМ--» Решту перетравлено." }
    t[240966] = "Могутній вічноспівний діамант"
    t[240967] = "Могутній вічноспівний діамант"
    t[240968] = "Телуричний вічноспівний діамант"
    t[240969] = "Телуричний вічноспівний діамант"
    t[240970] = "Стоїчний вічноспівний діамант"
    t[240971] = "Стоїчний вічноспівний діамант"
    t[240972] = { name = "Лінза сін'дорей", fen = "Created by players with the Jewelcrafting skill. Can be bought and sold on the Auction House.", fua = "Створюється гравцями з майстерністю ювелірства. Можна купувати й продавати на Аукціоні." }
    t[240973] = { name = "Лінза сін'дорей", fen = "Created by players with the Jewelcrafting skill. Can be bought and sold on the Auction House.", fua = "Створюється гравцями з майстерністю ювелірства. Можна купувати й продавати на Аукціоні." }
    t[240974] = { name = "Калейдоскопічна призма", fen = "Created by players with the Jewelcrafting skill. Can be bought and sold on the Auction House.", fua = "Створюється гравцями з майстерністю ювелірства. Можна купувати й продавати на Аукціоні." }
    t[240975] = { name = "Калейдоскопічна призма", fen = "Created by players with the Jewelcrafting skill. Can be bought and sold on the Auction House.", fua = "Створюється гравцями з майстерністю ювелірства. Можна купувати й продавати на Аукціоні." }
    t[240982] = "Нерозгаданий вічноспівний діамант"
    t[240983] = "Нерозгаданий вічноспівний діамант"
    t[240990] = { name = "Флакон із сонячного скла", fen = "Jewelcrafters can craft this item at high qualities. Can be purchased from a vendor at lower quality. Can be bought and sold on the Auction House.", fua = "Ювеліри можуть створити цей предмет високої якості. Нижчу якість можна придбати в торговця. Можна купити й продати на Аукціоні." }
    t[240991] = { name = "Флакон із сонячного скла", fen = "Purchased from tradeskill vendors. Jewelcrafters can also craft this item at equal or higher qualities. Can be bought and sold on the Auction House.", fua = "Купується в торговців ремісничими товарами. Ювеліри також можуть виготовити цей предмет рівної або вищої якості. Можна купувати й продавати на Аукціоні." }
    t[241000] = { name = "Тріснутий голоключ", fen = "This unusual ethereal device emits a hum. It seems functional despite being damaged.", fua = "Цей незвичний пристрій ефіріалів видає гудіння. Попри пошкодження, він, схоже, працює." }
    t[241013] = { name = "Шлунок електровугра", fen = "Filled with pungent, caustic acid and wreathed in a thick slime.", fua = "Наповнений їдкою, пекучою кислотою й оповитий густим слизом." }
    t[241014] = { name = "Пухироводорость", fen = "The leaves seem harmless but contain a deadly toxin.", fua = "Листя здається безпечним, та містить смертельну отруту." }
    t[241125] = { name = "Саморобна плюшева іграшка", fen = "A hand-sewn, stuffed representation of a truly dangerous creature from the lands beyond.", fua = "Зшита вручну, набита подоба справді небезпечної істоти із земель за межею." }
    t[241131] = { name = "Призма лазуриту амані", fen = "Break open to reveal some Amani Lapis.", fua = "Розбийте, щоб дістати трохи лазуриту амані." }
    t[241132] = { name = "Призма лазуриту амані", fen = "Break open to reveal some Amani Lapis.", fua = "Розбийте, щоб дістати трохи лазуриту амані." }
    t[241133] = { name = "Призма темітливих аметистів", fen = "Break open to reveal some Tenebrous Amethysts.", fua = "Розбий, щоб дістати кілька темітливих аметистів." }
    t[241134] = { name = "Призма темітливих аметистів", fen = "Break open to reveal some Tenebrous Amethysts.", fua = "Розбий, щоб дістати кілька темітливих аметистів." }
    t[241135] = { name = "Призма кривавих гранатів", fen = "Break open to reveal some Sanguine Garnets.", fua = "Розбий, щоб видобути кілька кривавих гранатів." }
    t[241136] = { name = "Призма кривавих гранатів", fen = "Break open to reveal some Sanguine Garnets.", fua = "Розбий, щоб видобути кілька кривавих гранатів." }
    t[241137] = { name = "Перидотова призма Гарандара", fen = "Break open to reveal some Harandar Peridots.", fua = "Розколіть, щоб дістати перидоти Гарандара." }
    t[241138] = { name = "Перидотова призма Гарандара", fen = "Break open to reveal some Harandar Peridots.", fua = "Розколіть, щоб дістати перидоти Гарандара." }
    t[241139] = "Таласський шийний обруч фенікса"
    t[241140] = "Перстень благословень Азерота"
    t[241141] = { name = "Кубок монологіста", fen = "What is a chalice? A wonderful prop for monologues!", fua = "Що таке кубок? Чудовий реквізит для монологів!" }
    t[241142] = "Рішучий геліотроп"
    t[241143] = "Когнітивний геліотроп"
    t[241144] = "Витривалий геліотроп"
    t[241145] = "Принада на везучого лоа"
    t[241147] = "Принада на кровного ловця"
    t[241148] = "Оберіг рибалки амані"
    t[241149] = "Принада на зловісного восьминога"
    t[241151] = "Принада на кореневого краба"
    t[241155] = { name = "Конденсатор Порожнечі", fen = "Locus Researcher's tool that detects and captures latent Void residue.", fua = "Знаряддя дослідника осередку, що виявляє й уловлює приховані залишки Порожнечі." }
    t[241192] = { name = "Пожований щоденник", fen = "The journal is covered in slobber and has visible bite marks. Clearly it has seen better days.", fua = "Щоденник укритий слиною й має помітні сліди зубів. Він явно бачив кращі часи." }
    t[241205] = { name = "Гудливий амулет", fen = "Recently inlaid enchantments pulse through the pendant like a heartbeat.", fua = "Нещодавно вкарбовані чари пульсують у підвісці, наче серцебиття." }
    t[241207] = { name = "Арканний меч", fen = "The sharp edge of the blade flickers with a soft, radiant glow.", fua = "Гостре лезо клинка мерехтить м'яким променистим сяйвом." }
    t[241208] = { name = "Кошик чаклунських реагентів", fen = "Latent magic glitters across the surface of the crystals.", fua = "Прихована магія мерехтить на поверхні кристалів." }
    t[241280] = { name = "Композитна флора", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241281] = { name = "Композитна флора", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241282] = { name = "Дивовижний синергіст", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241283] = { name = "Дивовижний синергіст", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241284] = "Казан зілля світла Порожнечі"
    t[241285] = "Казан зілля світла Порожнечі"
    t[241286] = { name = "Збереження Світла", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241287] = { name = "Збереження Світла", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241288] = { name = "Зілля безрозсудності", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241289] = { name = "Зілля безрозсудності", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241291] = { name = "Первісний філософський камінь", fen = "Required for Alchemical Transmutation.", fua = "Потрібен для Алхімічної Трансмутації." }
    t[241292] = { name = "Настоянка Нестримного Запалу", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241293] = { name = "Настоянка Нестримного Запалу", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241294] = { name = "Зілля поглинутих снів", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241295] = { name = "Зілля поглинутих снів", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241296] = { name = "Зілля завзяття", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241297] = { name = "Зілля завзяття", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241298] = { name = "Екстракт амані", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241299] = { name = "Екстракт амані", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241300] = { name = "Світлосплавлене зілля мани", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241301] = { name = "Світлосплавлене зілля мани", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241302] = { name = "Настоянка, оповита Порожнечею", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241303] = { name = "Настоянка, оповита Порожнечею", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241304] = { name = "Цілюще зілля Сільвермуна", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241305] = { name = "Цілюще зілля Сільвермуна", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241306] = { name = "Освіжна сироватка", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241307] = { name = "Освіжна сироватка", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241308] = { name = "Потенціал Світла", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241309] = { name = "Потенціал Світла", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241310] = { name = "Флакон витонченості гаранірів", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241311] = { name = "Флакон витонченості гаранірів", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241312] = { name = "Флакон винахідливості гаранірів", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241313] = { name = "Флакон винахідливості гаранірів", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241316] = { name = "Флакон сприйняття гаранірів", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241317] = { name = "Флакон сприйняття гаранірів", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241318] = "Казан флаконів сін'дорей"
    t[241319] = "Казан флаконів сін'дорей"
    t[241320] = { name = "Флакон таласіанського опору", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241321] = { name = "Флакон таласіанського опору", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241322] = { name = "Флакон Магістрів", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241323] = { name = "Флакон Магістрів", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241324] = { name = "Флакон Лицарів крові", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241325] = { name = "Флакон Лицарів крові", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241326] = { name = "Флакон Розбитого Сонця", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241327] = { name = "Флакон Розбитого Сонця", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241334] = { name = "Лютий таласійський флакон честі", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241338] = { name = "Тонік просвітлення", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241339] = { name = "Тонік просвітлення", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[241340] = { name = "Алхімічний камінь магістра", fen = "Can be used for transmutations in place of a Philosopher's Stone.", fua = "Можна використовувати для трансмутацій замість Філософського Каменя." }
    t[241349] = { name = "Запашна грибна шапка", fen = "Filled with a sticky, resinous liquid that carries a deep, rich scent.", fua = "Наповнена липкою, смолистою рідиною з глибоким, насиченим ароматом." }
    t[241611] = { name = "Голова Зарата", fen = "Looks more like a large flower than a head.", fua = "Радше схожа на велику квітку, ніж на голову." }
    t[241612] = { name = "Дротик зі світлодерева", fen = "The javelin you created with Woodcrafter Azai's guidance. With his expert teaching, the weapon turned out to be quite beautiful.", fua = "Дротик, який ти створив під керівництвом різьбяра Азаї. Завдяки його вправному навчанню зброя вийшла справді гарною." }
    t[241614] = { name = "Старий горщик амані", fen = "Paint has long flaked off this pot and a few of the gems are chipped.", fua = "Фарба з цього горщика давно облупилася, а кілька самоцвітів пощерблені." }
    t[241615] = { name = "Загублена дрібничка амані", fen = "The material is scuffed, but the color is quite exquisite.", fua = "Матеріал потертий, але барва доволі вишукана." }
    t[242226] = { name = "Викрадене насіння", fen = "A handful of seeds of various shapes and sizes.", fua = "Жменя насіння різних форм і розмірів." }
    t[242241] = { name = "Прихована аркана", fen = "Used to charge Runestones across Eversong Woods.", fua = "Використовується для заряджання рунних каменів по всьому Лісі Вічної Пісні." }
    t[242253] = { name = "Перезаряджений руйнівник оберегів", fen = "Attuned to fel magic instead of arcane this time. This should be enough to break fel wards made by Magister Aradis.", fua = "Цього разу налаштований на магію Скверни замість арканної. Цього має вистачити, щоб зруйнувати оберіги Скверни, створені магістром Арадісом." }
    t[242254] = { name = "Перехоплення майстра", fen = "Ethereal technology wavers and yields in its presence.", fua = "Ефіріальна технологія хитається й піддається в його присутності." }
    t[242272] = "Суміш кель'дореїв"
    t[242273] = "Квітучий бенкет"
    t[242274] = "Бенто чемпіона"
    t[242275] = "Королівська печеня"
    t[242276] = "Тушкований Кровожер"
    t[242277] = "Багряний кальмар"
    t[242278] = "Смачна копчена тетра"
    t[242280] = "Кореневий краб у маслі"
    t[242281] = "Блискучі шпажки"
    t[242282] = "Страва «Нуль і Порожнеча»"
    t[242283] = "Засмажений на сонці світлоплавець"
    t[242284] = "Рибні рулетики, поціловані Порожнечею"
    t[242285] = "Викривлені мудрокрила"
    t[242286] = "Філе, торкнуте Скверною"
    t[242287] = "Арканові котлети"
    t[242288] = "Сутінкова рибальська суміш"
    t[242289] = "Філе на чародійному вогні"
    t[242290] = "Мудрохвости"
    t[242291] = "Смажений цвітохвіст"
    t[242292] = "Пудинг Вічної Пісні"
    t[242293] = "Насолода Сонячного Колодязя"
    t[242294] = "Інжир скверноягоди"
    t[242295] = "Вечеря біля вогнища"
    t[242296] = "Котлети, загорнуті в кривавий будяк"
    t[242297] = "Чай з лілеї мани"
    t[242298] = "Чай зі срібнолисту"
    t[242299] = "Чай із кровотерну"
    t[242300] = { name = "Чай із цвіту спокою", fen = "A simple tea. As straightforward as it is refreshing.", fua = "Простий чай. Такий же безхитрісний, як і освіжний." }
    t[242301] = "Чай з азекореня"
    t[242302] = "Квіткові шпажки"
    t[242303] = "Маною просякнуте рагу"
    t[242304] = "Пряні бісквіти"
    t[242305] = "Класична страва Сільвермуна"
    t[242306] = "Збиральницька суміш"
    t[242307] = "Швидкий сендвіч"
    t[242308] = "Переносна перекуска"
    t[242309] = "Пайок далекохода"
    t[242390] = { name = "Уламок тінещепа", fen = "The strange metal of these cuff-like fragments thrum with Void energy. Holding it, your heart races. You long for the thrill of battle.", fua = "Дивний метал цих манжетоподібних уламків гуде енергією Порожнечі. Тримаючи його, ви відчуваєте, як прискорюється серце. Вас вабить трепет бою." }
    t[242552] = { name = "Нестабільна аркана", fen = "The glass vial pulses with shifting arcane energy, unpredictable and uncontrollable. Clearly, this should be handled with caution.", fua = "Скляна посудина пульсує мінливою арканною енергією, непередбачуваною й некерованою. Вочевидь, з нею слід поводитися обережно." }
    t[242553] = { name = "Кривавий гранат", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242554] = { name = "Лазурит амані", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242606] = { name = "Темітливий аметист", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242607] = { name = "Перидот Гарандара", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242608] = { name = "Діамант Вічної Пісні", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242610] = { name = "Бездоганний перидот Гарандара", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242611] = { name = "Бездоганний морочний аметист", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242612] = { name = "Бездоганний ляпіс амані", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242613] = { name = "Бездоганний кривавий гранат", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242620] = { name = "Мерехтливий самоцвітний пил", fen = "Acquired by Jewelcrafters by crushing Midnight gems. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами шляхом подрібнення самоцвітів Опівночі. Можна купувати й продавати на аукціоні." }
    t[242621] = { name = "Мерехтливий самоцвітний пил", fen = "Acquired by Jewelcrafters by crushing Midnight gems. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами шляхом подрібнення самоцвітів Опівночі. Можна купувати й продавати на аукціоні." }
    t[242637] = { name = "Переробити зілля", fen = "Break down unwanted potions into Stabilized Derivate.", fua = "Розкладає непотрібні зілля на стабілізований дериват." }
    t[242638] = { name = "Переробити флакони", fen = "Break down unwanted flasks and phials into Stabilized Derivate.", fua = "Розкладає непотрібні флакони та фіали на стабілізований дериват." }
    t[242639] = { name = "Майже свинина", fen = "Meat from various creatures in Midnight zones. Can be bought and sold on the Auction House.", fua = "М'ясо різних істот у землях Опівночі. Можна купувати й продавати на Аукціоні." }
    t[242640] = { name = "Рослинний протеїн", fen = "A meat substitute from various creatures in Midnight zones. Can be bought and sold on the Auction House.", fua = "Замінник м'яса з різних істот у землях Опівночі. Можна купувати й продавати на Аукціоні." }
    t[242641] = { name = "Кулінарне вино", fen = "Wine used for cooking various Quel'Thalas recipes. Sold by vendors.", fua = "Вино, що використовується для приготування різних рецептів Кель'Таласу. Продається торговцями." }
    t[242642] = { name = "Таласські трави", fen = "Finely chopped herbs used for cooking various Quel'Thalas recipes. Sold by vendors.", fua = "Дрібно посічені трави, які використовують для приготування різних рецептів Кель'Таласу. Продаються в торговців." }
    t[242643] = { name = "Добрячий старий кусень масла", fen = "Butter used in various Quel'Thalas cooking recipes. Sold by vendors.", fua = "Масло, яке використовують у різних кулінарних рецептах Кель'Таласа. Продається у торговців." }
    t[242644] = { name = "Есенція манавирма", fen = "Residue siphoned from Mana-Wyrms to add a little zest in cooking various Quel'Thalas recipes. Sold by vendors.", fua = "Залишки, висмоктані з манавирмів, щоб додати трохи смаку у приготування різних рецептів Кель'Таласу. Продається торговцями." }
    t[242645] = { name = "Набір стиглих овочів", fen = "Ripe vegetables used for cooking various Quel'Thalas recipes. Sold by vendors.", fua = "Стиглі овочі для різноманітних рецептів Кель'Таласу. Продаються у торговців." }
    t[242646] = { name = "Торбинка прянощів", fen = "Spices used for cooking various Quel'Thalas recipes. Sold by vendors.", fua = "Прянощі для приготування різних рецептів Кель'Таласу. Продаються торговцями." }
    t[242647] = { name = "Корчмарські приправи", fen = "A mixture of miscellaneous odds-and-ends used in cooking various Quel'Thalas recipes. Sold by vendors.", fua = "Суміш різноманітних дрібних інгредієнтів, які використовують у приготуванні різних рецептів Кель'Таласу. Продається в торговців." }
    t[242650] = { name = "Коробка з Камінням", fen = "Exactly what you expect. Created by experienced alchemists.", fua = "Саме те, що ти й очікуєш. Створена досвідченими алхіміками." }
    t[242651] = { name = "Стабілізований дериват", fen = "A coalesced alchemical essence reclaimed from excess concoctions.", fua = "Згущена алхімічна есенція, відновлена з надлишкових сумішей." }
    t[242712] = { name = "Діамант Вічної Пісні", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242719] = "Скриня тестового спорядження"
    t[242720] = { name = "Перидот Гарандара", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242721] = { name = "Темітливий аметист", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242722] = { name = "Лазурит амані", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242723] = { name = "Кривавий гранат", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242724] = { name = "Бездоганний кривавий гранат", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242725] = { name = "Бездоганний морочний аметист", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242726] = { name = "Бездоганний перидот Гарандара", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242727] = { name = "Бездоганний ляпіс амані", fen = "Acquired by Jewelcrafters when prospecting Midnight ore. Can be bought and sold on the Auction House.", fua = "Здобувається ювелірами при перебиранні руди Міднайту. Можна купити й продати на Аукціоні." }
    t[242744] = "Ситне асорті кель'дореїв"
    t[242745] = "Ситний квітучий бенкет"
    t[242746] = "Ситне бенто чемпіона"
    t[242747] = "Ситна королівська печеня"
    t[242748] = "Ситний тушкований кривавий ловець"
    t[242749] = "Ситні багряні кальмари"
    t[242750] = "Ситна смачна копчена тетра"
    t[242752] = "Ситний кореневий краб у маслі"
    t[242753] = "Ситні мерехтливі шашлички"
    t[242754] = "Ситна страва «Ніщо і Порожнеча»"
    t[242755] = "Ситний світлоплавець, обсмажений на сонці"
    t[242756] = "Ситні рибні рулети, торкнуті Порожнечею"
    t[242757] = "Ситні викривлені мудрокрила"
    t[242758] = "Ситне філе, торкнуте Скверною"
    t[242759] = "Ситні арканні котлети"
    t[242760] = "Ситне асорті сутінкового рибалки"
    t[242761] = "Ситне філе чаровогню"
    t[242762] = "Ситні мудрохвости"
    t[242763] = "Ситний смажений квітохвіст"
    t[242764] = "Ситний вічноспівний пудинг"
    t[242765] = "Ситна насолода Сонячного Колодязя"
    t[242766] = "Ситні інжири зі скверноягодами"
    t[242767] = "Ситна вечеря біля вогнища"
    t[242768] = "Ситні котлети в кривавому будяку"
    t[242769] = "Ситні шашлички з квітів"
    t[242770] = "Ситне рагу, насичене маною"
    t[242771] = "Ситне печиво з прянощами"
    t[242772] = "Ситна сільвермунська класика"
    t[242773] = "Ситне асорті збирача"
    t[242774] = "Ситний швидкий сендвіч"
    t[242775] = "Ситна похідна закуска"
    t[242776] = "Ситний пайок далекохода"
    t[242786] = { name = "Кристалічне скло", fen = "Found by with the Jewelcrafting skill by Prospecting ore. Can be bought and sold on the Auction House.", fua = "Здобувається навичкою ювелірства під час розвідки руди. Можна купити й продати на Аукціоні." }
    t[242787] = { name = "Кристалічне скло", fen = "Found by players with the Jewelcrafting skill by Prospecting ore. Can be bought and sold on the Auction House.", fua = "Здобувається гравцями з умінням ювелірства під час розвідки руди. Можна купити й продати на аукціоні." }
    t[242788] = { name = "Сутінкова Самоцвітна Каменина", fen = "Found with the Jewelcrafting skill by Prospecting ore. Can be bought and sold on the Auction House.", fua = "Здобувається навичкою ювелірства під час видобутку самоцвітів з руди. Можна купити та продати на Аукціоні." }
    t[242789] = { name = "Сутінкова Самоцвітна Каменина", fen = "Found with the Jewelcrafting skill by Prospecting ore. Can be bought and sold on the Auction House.", fua = "Здобувається навичкою ювелірства під час видобутку самоцвітів з руди. Можна купити та продати на Аукціоні." }
    t[243019] = { name = "Драконояструб крила Порожнечі", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[243020] = { name = "Світлокрилий драконояструб", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[243060] = { name = "Осяйний флюс", fen = "Used to bond disparate metals into bonded alloys. Sold by Blacksmithing vendors.", fua = "Використовується для сплавлення різнорідних металів у сполучені стопи. Продається в торговців ковальством." }
    t[243062] = { name = "Надієкрил", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[243063] = { name = "Лиховісні пера", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[243146] = "Боротьба рен'дорей"
    t[243188] = { name = "Голова Скеловартового Ґаагла", fen = "Flecked with gore and battered with bruises.", fua = "Заляпана кров'ю та вкрита синцями." }
    t[243189] = { name = "Голова Трощительки Гелтри", fen = "Flecked with gore and battered with bruises.", fua = "Заляпана кров'ю та вкрита синцями." }
    t[243196] = { name = "Цілющі води Ал'уа", fen = "Tingles to the touch and taste. Intended to counteract the poison of the nearby creatures during En'liahn's upcoming ritual.", fua = "Поколюють на дотик і на смак. Призначені нейтралізувати отруту довколишніх істот під час майбутнього ритуалу Ен'ліан." }
    t[243221] = { name = "Підозрілий лист", fen = "A set of mysterious orders, penned in an unknown hand.", fua = "Низка загадкових наказів, написаних незнайомою рукою." }
    t[243236] = { name = "Заплямована робоча сорочка", fen = "A threadbare garment, soiled by fel and hastily discarded. Someone was messy.", fua = "Витерта одежина, забруднена Скверною й похапцем викинута. Хтось був неохайний." }
    t[243237] = { name = "Закупорений Порох Скверни", fen = "The bottle of dust is hot to the touch, tiny cracks already spreading across the glass. This must be a temporary means of transport.", fua = "Пляшечка з порохом гаряча на дотик, а скло вже вкривають дрібні тріщини. Це, певно, тимчасовий спосіб перенесення." }
    t[243238] = { name = "Почорнілий уламок металу", fen = "Deceptively heavy. Broken runes along the edge resemble Legion script.", fua = "Оманливо важкий. Зламані руни вздовж краю нагадують письмо Легіону." }
    t[243239] = { name = "Рукописний список", fen = "A nondescript record of sales for mana wyrms, tucked inside a book. There is fel residue in the fingerprints smudging the edges.", fua = "Непримітний запис продажів манавирмів, схований у книзі. У відбитках пальців, що розмазані по краях, є залишки Скверни." }
    t[243240] = { name = "Висушене ядро вирма", fen = "Grown in the body of a mana wyrm, these cores crystallize from the magic the creature feeds on. There is a dim fel glow to this one.", fua = "Ці ядра ростуть у тілі манавирма й кристалізуються з магії, якою живиться істота. Це випромінює тьмяний відблиск Скверни." }
    t[243248] = { name = "Нитка аномалії", fen = "A fragment of something peculiar.", fua = "Уламок чогось дивного." }
    t[243294] = { name = "Посох Роніна", fen = "Staff of the great Archmage Rhonin Redhair.", fua = "Посох великого архімага Роніна Рудоволосого." }
    t[243295] = { name = "Лист від Роніна", fen = "The last words of Archmage Rhonin.", fua = "Останні слова верховного мага Роніна." }
    t[243302] = { name = "Цвіт Водолія", fen = "An overwhelming catalyst of growth.", fua = "Приголомшливий каталізатор росту." }
    t[243342] = { name = "Квіткова цяцька", fen = "A single seed can turn into a swarm.", fua = "Одна-єдина насінина може обернутися на рій." }
    t[243343] = { name = "Аномалія рибалки", fen = "A window into something much, much more.", fua = "Вікно в щось значно, значно більше." }
    t[243350] = { name = "Кров хижака", fen = "Void specks darken the vile liquid.", fua = "Цяточки Порожнечі затьмарюють мерзенну рідину." }
    t[243468] = { name = "Самоцвітний ключ", fen = "Mundane, yet somehow still ominous.", fua = "Буденний, але чомусь усе одно зловісний." }
    t[243478] = { name = "Запасні памфлети", fen = "Someone has stashed away these cultist recruitment pamphlets for later use.", fua = "Хтось приховав ці вербувальні памфлети культистів для подальшого вжитку." }
    t[243574] = { name = "Співоче зубчасте колесо", fen = "Crafted by Quel'Thalas Engineers for use in their inventions. Can be bought and sold on the Auction House.", fua = "Виготовлено інженерами Кель'Таласа для своїх винаходів. Можна купити й продати на аукціоні." }
    t[243575] = { name = "Співоче зубчасте колесо", fen = "Crafted by Quel'Thalas Engineers for use in their inventions. Can be bought and sold on the Auction House.", fua = "Виготовлено інженерами Кель'Таласа для своїх винаходів. Можна купити й продати на аукціоні." }
    t[243576] = { name = "Зубчатка душі", fen = "Crafted by Quel'Thalas Engineers for use in their inventions. Can be bought and sold on the Auction House.", fua = "Виготовлено інженерами Кель'Таласа для своїх винаходів. Можна купити й продати на аукціоні." }
    t[243577] = { name = "Зубчатка душі", fen = "Crafted by Quel'Thalas Engineers for use in their inventions. Can be bought and sold on the Auction House.", fua = "Виготовлено інженерами Кель'Таласа для своїх винаходів. Можна купити й продати на аукціоні." }
    t[243578] = { name = "Етерлум", fen = "Recycled using parts by Quel'Thalas Engineers and other artisans. Can be bought and sold on the Auction House.", fua = "Переробляється з деталей інженерами Кель'Таласу та іншими майстрами. Можна купувати й продавати на аукціоні." }
    t[243579] = { name = "Етерлум", fen = "Recycled using parts by Quel'Thalas Engineers and other artisans. Can be bought and sold on the Auction House.", fua = "Переробляється з деталей інженерами Кель'Таласу та іншими майстрами. Можна купувати й продавати на аукціоні." }
    t[243581] = { name = "Вічноядро", fen = "Recycled using parts by Quel'Thalas Engineers and other artisans. Can be bought and sold on the Auction House.", fua = "Переробляється з деталей інженерами Кель'Таласу та іншими майстрами. Можна купувати й продавати на аукціоні." }
    t[243582] = { name = "Вічноядро", fen = "Recycled using parts by Quel'Thalas Engineers and other artisans. Can be bought and sold on the Auction House.", fua = "Переробляється з деталей інженерами Кель'Таласу та іншими майстрами. Можна купувати й продавати на аукціоні." }
    t[243583] = { name = "Райдужний панцир", fen = "When crushed into a powder, it produces a glittering pigment that shimmers with many colors.", fua = "Якщо розтерти на порошок, він дає блискучий пігмент, що мерехтить багатьма кольорами." }
    t[243584] = { name = "Пелюстки аметрилу", fen = "The velvety surface shifts between deep violet and radiant lilac, as if woven from the light of a setting sun.", fua = "Оксамитова поверхня мерехтить між глибоким фіолетом і променистим бузковим, наче виткана зі світла призахідного сонця." }
    t[243589] = { name = "Альнопил", fen = "Brightly glimmering with an intense light.", fua = "Яскраво мерехтить інтенсивним світлом." }
    t[243595] = { name = "Мазь Альну", fen = "A glittery salve that tingles with power.", fua = "Мерехтлива мазь, що поколює силою." }
    t[243598] = { name = "Фітогенна отруйна залоза", fen = "The secretions coming from these plant-like organs are most definitely toxic.", fua = "Виділення з цих рослиноподібних органів безперечно токсичні." }
    t[243599] = { name = "Пил Вічної Пісні", fen = "Gathered by players with the Enchanting skill by disenchanting items. Can be bought and sold on the Auction House.", fua = "Здобувається гравцями з умінням Накладання чарів через знечарування предметів. Можна купувати й продавати на Аукціоні." }
    t[243600] = { name = "Пил Вічної Пісні", fen = "Gathered by players with the Enchanting skill by disenchanting items. Can be bought and sold on the Auction House.", fua = "Здобувається гравцями з умінням Накладання чарів через знечарування предметів. Можна купувати й продавати на Аукціоні." }
    t[243602] = { name = "Сяйливий уламок", fen = "Gathered by players with the Enchanting skill by disenchanting items. Can be bought and sold on the Auction House.", fua = "Здобувається гравцями з умінням Накладання чарів через знечарування предметів. Можна купувати й продавати на Аукціоні." }
    t[243603] = { name = "Сяйливий уламок", fen = "Gathered by players with the Enchanting skill by disenchanting items. Can be bought and sold on the Auction House.", fua = "Здобувається гравцями з умінням Накладання чарів через знечарування предметів. Можна купувати й продавати на Аукціоні." }
    t[243605] = { name = "Світанковий кристал", fen = "Gathered by players with the Enchanting skill by disenchanting items. Can be bought and sold on the Auction House.", fua = "Здобувається гравцями з умінням Накладання чарів через знечарування предметів. Можна купувати й продавати на Аукціоні." }
    t[243606] = { name = "Світанковий кристал", fen = "Gathered by players with the Enchanting skill by disenchanting items. Can be bought and sold on the Auction House.", fua = "Здобувається гравцями з умінням Накладання чарів через знечарування предметів. Можна купувати й продавати на Аукціоні." }
    t[243612] = { name = "Репутація з Лицарями крові", fen = "Your reputation with the Blood Knights will decrease.", fua = "Ваша репутація з Лицарями крові знизиться." }
    t[243733] = { name = "Таласька олія фенікса", fen = "The bottle contains what appears to be liquid fire and radiates warmth.", fua = "Здається, у пляшці міститься рідкий вогонь, і вона випромінює тепло." }
    t[243734] = { name = "Таласька олія фенікса", fen = "The bottle contains what appears to be liquid fire and radiates warmth.", fua = "Здається, у пляшці міститься рідкий вогонь, і вона випромінює тепло." }
    t[243735] = { name = "Олія світанку", fen = "A vial of holy oil blessed by the Sunwell.", fua = "Флакон священної олії, освяченої Сонячним Колодязем." }
    t[243736] = { name = "Олія світанку", fen = "A vial of holy oil blessed by the Sunwell.", fua = "Флакон священної олії, освяченої Сонячним Колодязем." }
    t[243737] = { name = "Зачароване лезо контрабандиста", fen = "More of a magical toxic sludge than an oil, really.", fua = "Радше магічна отруйна твань, ніж олія, як по правді." }
    t[243738] = { name = "Зачароване лезо контрабандиста", fen = "More of a magical toxic sludge than an oil, really.", fua = "Радше магічна отруйна твань, ніж олія, як по правді." }
    t[243773] = "Радісний гламур — ельф крові"
    t[243774] = "Радісний гламур — дворф Темного Заліза"
    t[243775] = "Радісний гламур — дреней"
    t[243776] = "Радісний гламур — дворф"
    t[243777] = "Радісний гламур — земельний"
    t[243778] = "Радісний гламур — гном"
    t[243779] = "Радісний гламур — гоблін"
    t[243780] = "Радісний гламур — таврен Високогір'я"
    t[243781] = "Радісний гламур — людина"
    t[243782] = "Радісний гламур — куль-тираець"
    t[243783] = "Радісний гламур — загартований Світлом дреней"
    t[243784] = "Радісний гламур — орк маг'хар"
    t[243785] = "Радісний гламур — механогном"
    t[243786] = "Радісний гламур — нічний ельф"
    t[243787] = "Радісний гламур — нічнороджений"
    t[243788] = "Радісний гламур — орк"
    t[243789] = "Радісний гламур — пандарен"
    t[243790] = "Радісний гламур — таврен"
    t[243791] = "Радісний гламур — троль"
    t[243792] = "Радісний гламур — нежить"
    t[243793] = "Радісний гламур — ельф Порожнечі"
    t[243794] = "Радісний гламур — вульпера"
    t[243795] = "Радісний гламур — ворген"
    t[243796] = "Радісний гламур — троль зандаларі"
    t[243797] = "Радісний гламур — ельф крові"
    t[243798] = "Радісний гламур — дворф Темного Заліза"
    t[243799] = "Радісний гламур — дреней"
    t[243800] = "Радісний гламур — дворф"
    t[243801] = "Радісний гламур — земельний"
    t[243802] = "Радісний гламур — гном"
    t[243803] = "Радісний гламур — гоблін"
    t[243804] = "Радісний гламур — таврен Високогір'я"
    t[243805] = "Радісний гламур — людина"
    t[243806] = "Радісний гламур — куль-тираець"
    t[243807] = "Радісний гламур — загартований Світлом дреней"
    t[243808] = "Радісний гламур — орк маг'хар"
    t[243809] = "Радісний гламур — механогном"
    t[243810] = "Радісний гламур — нічний ельф"
    t[243811] = "Радісний гламур — нічнороджений"
    t[243812] = "Радісний гламур — орк"
    t[243813] = "Радісний гламур — пандарен"
    t[243814] = "Радісний гламур — таврен"
    t[243815] = "Радісний гламур — троль"
    t[243816] = "Радісний гламур — нежить"
    t[243817] = "Радісний гламур — ельф Порожнечі"
    t[243818] = "Радісний гламур — вульпера"
    t[243819] = "Радісний гламур — ворген"
    t[243820] = "Радісний гламур — троль зандаларі"
    t[243844] = { name = "Пелюсткова торба", fen = "This small bag is made up of delicate flower petals.", fua = "Ця маленька торба зроблена з тендітних пелюсток квітів." }
    t[243845] = { name = "Пелюстковий мішок", fen = "A medium-sized sack formed from delicate flower petals.", fua = "Мішок середнього розміру, сформований із тендітних пелюсток квітів." }
    t[243946] = "Чари на нагрудник – Знак Налоракка"
    t[243947] = "Чари на нагрудник – Знак Налоракка"
    t[243948] = "Чари шолома — Врок висмоктування"
    t[243949] = "Чари шолома — Врок висмоктування"
    t[243950] = "Чари шолома — Посилений врок висмоктування"
    t[243951] = "Чари шолома — Посилений врок висмоктування"
    t[243952] = "Чари на чоботи – Спритність Рисі"
    t[243953] = "Чари на чоботи – Спритність Рисі"
    t[243954] = "Чари персня — Майстерність амані"
    t[243955] = "Чари персня — Майстерність амані"
    t[243956] = "Чари персня — Очі орла"
    t[243957] = "Чари персня — Очі орла"
    t[243958] = "Чари персня — Майстерність Зул'джина"
    t[243959] = "Чари персня — Майстерність Зул'джина"
    t[243960] = "Чари плечей — Політ орла"
    t[243961] = "Чари плечей — Політ орла"
    t[243962] = "Чари плечей — Прудкість Акіл'зона"
    t[243963] = "Чари плечей — Прудкість Акіл'зона"
    t[243964] = "Чари інструмента — Сприйнятливість амані"
    t[243965] = "Чари інструмента — Сприйнятливість амані"
    t[243966] = "Чари інструмента — Винахідливість амані"
    t[243967] = "Чари інструмента — Винахідливість амані"
    t[243968] = "Чари зброї — Сила Галаззі"
    t[243969] = "Чари зброї — Сила Галаззі"
    t[243970] = "Чари зброї — Точність Джан'алая"
    t[243971] = "Чари зброї — Точність Джан'алая"
    t[243972] = "Чари зброї — Лють берсерка"
    t[243973] = "Чари зброї — Лють берсерка"
    t[243974] = "Чари нагрудника — Знак вартового коренів"
    t[243975] = "Чари нагрудника — Знак вартового коренів"
    t[243976] = "Чари нагрудника — Знак Світодуші"
    t[243977] = "Чари нагрудника — Знак Світодуші"
    t[243978] = "Чари шолома — Благословення швидкості"
    t[243979] = "Чари шолома — Благословення швидкості"
    t[243980] = "Чари шолома — Посилене благословення швидкості"
    t[243981] = "Чари шолома — Посилене благословення швидкості"
    t[243982] = "Чари на чоботи – Коріння Шаладрассіла"
    t[243983] = "Чари на чоботи – Коріння Шаладрассіла"
    t[243984] = "Чари персня — Гнів природи"
    t[243985] = "Чари персня — Гнів природи"
    t[243986] = "Чари персня — Лють природи"
    t[243987] = "Чари персня — Лють природи"
    t[243988] = "Чари плечей — Грація природи"
    t[243989] = "Чари плечей — Грація природи"
    t[243990] = "Чари плечей — Грація Амірдрассіла"
    t[243991] = "Чари плечей — Грація Амірдрассіла"
    t[243992] = "Чари інструмента — Витонченість гаранірів"
    t[243993] = "Чари інструмента — Витонченість гаранірів"
    t[243994] = "Чари інструмента — Багатоверстатне ремесло гаранірів"
    t[243995] = "Чари інструмента — Багатоверстатне ремесло гаранірів"
    t[243996] = "Чари зброї — Колиска Світодуші"
    t[243997] = "Чари зброї — Колиска Світодуші"
    t[243998] = "Чари зброї — Егіда Світодуші"
    t[243999] = "Чари зброї — Егіда Світодуші"
    t[244000] = "Чари зброї — Стійкість Світодуші"
    t[244001] = "Чари зброї — Стійкість Світодуші"
    t[244002] = "Чари нагрудника — Знак магістра"
    t[244003] = "Чари нагрудника — Знак магістра"
    t[244004] = "Чари шолома — Руна уникнення"
    t[244005] = "Чари шолома — Руна уникнення"
    t[244006] = "Чари шолома — Посилена руна уникнення"
    t[244007] = "Чари шолома — Посилена руна уникнення"
    t[244008] = "Чари на чоботи – Полювання Далекохода"
    t[244009] = "Чари на чоботи – Полювання Далекохода"
    t[244010] = "Чари персня — Таласійський поспіх"
    t[244011] = "Чари персня — Таласійський поспіх"
    t[244012] = "Чари персня — Таласійська універсальність"
    t[244013] = "Чари персня — Таласійська універсальність"
    t[244014] = "Чари персня — Завзяття Сільвермуна"
    t[244015] = "Чари персня — Завзяття Сільвермуна"
    t[244016] = "Чари персня — Стійкість Сільвермуна"
    t[244017] = "Чари персня — Стійкість Сільвермуна"
    t[244018] = "Чари плечей — Таласійське відновлення"
    t[244019] = "Чари плечей — Таласійське відновлення"
    t[244020] = "Чари плечей — Зцілення Сільвермуна"
    t[244021] = "Чари плечей — Зцілення Сільвермуна"
    t[244022] = "Чари інструмента — Спритність сін'дорей"
    t[244023] = "Чари інструмента — Спритність сін'дорей"
    t[244024] = "Чари інструмента — Кмітливість рен'дорей"
    t[244025] = "Чари інструмента — Кмітливість рен'дорей"
    t[244026] = "Чари зброї — Полум'я сін'дорей"
    t[244027] = "Чари зброї — Полум'я сін'дорей"
    t[244028] = "Чари зброї — Гострота розуму рен'дорей"
    t[244029] = "Чари зброї — Гострота розуму рен'дорей"
    t[244030] = "Чари зброї — Арканна майстерність"
    t[244031] = "Чари зброї — Арканна майстерність"
    t[244032] = "Ілюзорна оздоба — Квітуче світло"
    t[244033] = "Ілюзорна оздоба — Квітуче світло"
    t[244034] = "Ілюзорна оздоба — Обійми природи"
    t[244035] = "Ілюзорна оздоба — Обійми природи"
    t[244036] = "Ілюзорна оздоба — Торкнута Порожнечею"
    t[244037] = "Ілюзорна оздоба — Торкнута Порожнечею"
    t[244038] = { name = "Лозообвита скриня", fen = "This squat crate is made from leaves and flower petals, and bound by vines.", fua = "Ця присадкувата скриня зроблена з листя та пелюсток і зв'язана лозою." }
    t[244039] = { name = "Ваза з рослини-глечика", fen = "This small, delicate vase is made from a bulbous pitcher plant.", fua = "Ця маленька тендітна ваза зроблена з пузатої рослини-глечика." }
    t[244040] = { name = "Лантух насіння", fen = "A sack of seeds from Harandar.", fua = "Лантух насіння з Гарандара." }
    t[244041] = { name = "Проросле зерня", fen = "A large seed with a tendril of root poking through a cracked shell.", fua = "Велике зерня, з тріснутої шкаралупи якого пробивається вусик кореня." }
    t[244056] = "Радісний гламур — гаранір"
    t[244057] = "Радісний гламур — гаранір"
    t[244143] = { name = "Ікла з Кістяного Панцира", fen = "Sturdy and smooth like polished bone. You are what you eat...", fua = "Міцні й гладенькі, мов полірована кістка. Ти — те, що ти їси..." }
    t[244144] = { name = "Кровожильний згусток", fen = "The bloody mass glows faintly in the dark, as if still alive.", fua = "Закривавлена маса слабко світиться в темряві, наче й досі жива." }
    t[244146] = { name = "Видобуті дані", fen = "A small data storage device. An intrepid ethereal tinkerer could decode the data.", fua = "Невеликий пристрій для зберігання даних. Безстрашний ефіріал-винахідник зміг би розшифрувати ці дані." }
    t[244171] = { name = "Мітка викрадача", fen = "Its design seems reminiscent of a Rune of Portals.", fua = "Її візерунок чимось нагадує Руну порталів." }
    t[244173] = { name = "Реліквія визволення", fen = "Its ancient, chaotic energies oppose tyranny in all its forms, from evil magic to overtightened hoofguards.", fua = "Її прадавня, хаотична енергія протистоїть тиранії в усіх її проявах — від лихої магії до надто туго затягнутих захистів копит." }
    t[244174] = { name = "Сяйливий мідний прут", fen = "While not very powerful, it serves as a runed enchanting rod.", fua = "Хоч і не дуже потужний, він слугує рунованим жезлом для зачарування." }
    t[244175] = { name = "Рунна блискуча мідна паличка", fen = "Serves as a runed enchanting rod.", fua = "Слугує рунованим жезлом для накладання чарів." }
    t[244176] = { name = "Рунна осяйна срібна паличка", fen = "Serves as a runed enchanting rod.", fua = "Слугує рунованим жезлом для накладання чарів." }
    t[244177] = { name = "Рунна сяйлива торієва паличка", fen = "Serves as a runed enchanting rod.", fua = "Слугує рунованим жезлом для накладання чарів." }
    t[244178] = "Жезл таласського ткача заклять"
    t[244179] = "Великий фокусувальник магістра"
    t[244194] = { name = "Вирвана сторінка", fen = "A page torn out of a journal. Umbric may be interested in this.", fua = "Сторінка, вирвана зі щоденника. Це може зацікавити Умбрика." }
    t[244195] = { name = "Вирвана сторінка", fen = "A page torn out of a journal. Umbric may be interested in this.", fua = "Сторінка, вирвана зі щоденника. Це може зацікавити Умбрика." }
    t[244197] = { name = "Вирвана сторінка", fen = "A page torn out of a journal. Umbric may be interested in this.", fua = "Сторінка, вирвана зі щоденника. Це може зацікавити Умбрика." }
    t[244214] = { name = "Соковита жаб'яча лапка", fen = "A plump, freshly-plucked frog leg. Perfectly irresistible to hawkstriders.", fua = "Пухка, щойно зірвана жаб'яча лапка. Геть нездоланна спокуса для яструбоступів." }
    t[244337] = { name = "Порожній Мішок для Насіння", fen = "A rutaani sack formed of leaves and vines, empty of its contents.", fua = "Мішок рутаані, сплетений з листя та лоз, спорожнілий від свого вмісту." }
    t[244339] = { name = "Пташеня яструбоступа", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[244407] = { name = "Тріснуте ядро вирма", fen = "Fel magic clings to the dense, pearlescent crystal, seeping from the long crack where it was hastily dropped.", fua = "Магія Скверни чіпляється до щільного перламутрового кристала, просочуючись із довгої тріщини, що утворилася, коли його квапливо впустили." }
    t[244425] = "Кульки Ґіббі"
    t[244429] = { name = "Сяйвогриб", fen = "A large, glowing mushroom from a cave in Fungal Cleft.", fua = "Великий сяйливий гриб із печери у Грибній Розколині." }
    t[244435] = { name = "Дороговказ Великої Темряви", fen = "Its crystal reflects wintery peaks in one moment and seabeds of coral in the next.", fua = "Його кристал то віддзеркалює зимові вершини, то морське дно з коралами." }
    t[244459] = "Ключ від скрині сутінкового бійця"
    t[244462] = { name = "Накази амані", fen = "Quotas for Lightbloom lumber and operations.", fua = "Квоти на світлодеревну деревину та роботи." }
    t[244463] = "Прудконоги Завулку Убивць"
    t[244469] = { name = "Сокира Світлоцвіту", fen = "Forged with lightwood.", fua = "Викувана зі світлодерева." }
    t[244472] = "Частокіл лицаря-командувача"
    t[244528] = { name = "Вантажна накладна", fen = "Bears a tax stamp from the Silvermoon dockmaster. The contents are falsely declared as mana crystals.", fua = "Має податковий штамп начальника доків Сільвермуна. Вміст фальшиво заявлено як кристали мани." }
    t[244539] = { name = "Посох арканного перенесення", fen = "A staff used to draw power from arcane crystals.", fua = "Посох, яким видобувають силу з арканних кристалів." }
    t[244547] = { name = "Складена квитанція", fen = "Details of a payment for \"mana crystals\" between Suramar and the Illicit Rain.", fua = "Подробиці оплати за «кристали мани» між Сурамаром і Незаконним Дощем." }
    t[244553] = "Шкіряні чоботи таласського змагуна"
    t[244554] = "Шкіряний нагрудник таласського змагуна"
    t[244555] = "Шкіряна маска таласського змагуна"
    t[244556] = "Шкіряні наплічники таласського змагуна"
    t[244557] = "Шкіряний пояс таласського змагуна"
    t[244558] = "Шкіряні штани таласського змагуна"
    t[244559] = "Шкіряні рукавички таласського змагуна"
    t[244560] = "Шкіряні обмотки на зап'ястки таласського змагуна"
    t[244561] = "Кольчужні чоботи таласського змагуна"
    t[244562] = "Кольчужна туніка таласського змагуна"
    t[244563] = "Кольчужний каптур таласського змагуна"
    t[244564] = "Кольчужні наплічники таласського змагуна"
    t[244565] = "Кольчужний пояс таласського змагуна"
    t[244566] = "Кольчужні штани таласського змагуна"
    t[244567] = "Кольчужні рукавиці таласського змагуна"
    t[244568] = "Кольчужні манжети таласського змагуна"
    t[244569] = "Крадькові чоботи агента Сільвермуна"
    t[244570] = "Кітель агента Сільвермуна"
    t[244571] = "Каптур агента Сільвермуна"
    t[244572] = "Накидка агента Сільвермуна"
    t[244573] = "Робочий пояс агента Сільвермуна"
    t[244574] = "Штани агента Сільвермуна"
    t[244575] = "Намотки на руки агента Сільвермуна"
    t[244576] = "Відбивачі агента Сільвермуна"
    t[244577] = "Гострі пазурі далекоходів"
    t[244578] = "Розвідницький жилет далекоходів"
    t[244579] = "Незворушний лик далекоходів"
    t[244580] = "Осяйне пір'я далекохода"
    t[244581] = "Трофейний пояс далекоходів"
    t[244582] = "Укріплені стегнові пластини далекоходів"
    t[244583] = "Нагострені кігті далекоходів"
    t[244584] = "Пластинчасті наручі далекоходів"
    t[244585] = "Шкіряні чоботи контрабандиста"
    t[244586] = "Шкіряні наручі контрабандиста"
    t[244587] = "Шкіряна туніка контрабандиста"
    t[244588] = "Лускаті чоботи розвідника"
    t[244589] = "Лускаті наручі розвідника"
    t[244590] = "Лускатий жилет розвідника"
    t[244591] = "Укріплений каптур контрабандиста"
    t[244592] = "Укріплені наплічники контрабандиста"
    t[244593] = "Укріплені рукавиці контрабандиста"
    t[244594] = "Укріплені штани контрабандиста"
    t[244595] = "Укріплена пов'язка контрабандиста"
    t[244596] = "Полірований шолом розвідника"
    t[244597] = "Поліровані наплічники розвідника"
    t[244598] = "Поліровані рукавиці розвідника"
    t[244599] = "Поліровані наголінники розвідника"
    t[244600] = "Поліроване обмотування розвідника"
    t[244601] = "Кореневі обмотки Світового Дерева"
    t[244602] = "Рукавиці рейнджер-генерала"
    t[244603] = { name = "Благословенний амулет панголіна", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[244604] = { name = "Благословенний амулет панголіна", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[244605] = "Наручі сокирометальника"
    t[244606] = "Вроко-ткана нитка"
    t[244607] = { name = "Первісне споропереплетення", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[244608] = { name = "Первісне споропереплетення", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[244609] = "Стовбурова пластина Світодоглядача"
    t[244610] = "Кореневі капці Світоглядача"
    t[244611] = "Кораправа застібка Світоглядача"
    t[244612] = "Відбивачі завулкоброда"
    t[244613] = "Захист завулкоброда"
    t[244614] = "Прудкі рукавиці завулкоброда"
    t[244615] = "Сумка вічноспівного ботаніка"
    t[244616] = "Заплічник чинбаря"
    t[244617] = "Ковпак чинбаря"
    t[244618] = "Рукавиці майстра-механіка"
    t[244619] = "Фартух чинбаря"
    t[244620] = "Кашкет хіміка"
    t[244621] = "Рюкзак травника сін'дорей"
    t[244622] = "Мисливська торба сін'дорей"
    t[244623] = "Наголов'я вічноспівного мисливця"
    t[244624] = "Рукавиці інженера сін'дорей"
    t[244625] = "Халат чинбаря сін'дорей"
    t[244626] = "Капелюх алхіміка сін'дорей"
    t[244627] = "Фартух підмайстра-коваля"
    t[244628] = "Фартух коваля-майстра сін'дорей"
    t[244629] = "Фартух підмайстра-ювеліра"
    t[244630] = "Фартух ювеліра сін'дорей"
    t[244631] = { name = "Лускоткана шкура", fen = "Crafted by players with the Leatherworking skill. Can be bought and sold on the Auction House.", fua = "Виготовляється гравцями з умінням Шкіряної справи. Можна купувати й продавати на Аукціоні." }
    t[244632] = { name = "Лускоткана шкура", fen = "Crafted by players with the Leatherworking skill. Can be bought and sold on the Auction House.", fua = "Виготовляється гравцями з умінням Шкіряної справи. Можна купувати й продавати на Аукціоні." }
    t[244633] = { name = "Насичена лускоткана шкура", fen = "Crafted by players with the Leatherworking skill. Can be bought and sold on the Auction House.", fua = "Виготовляється гравцями з умінням Шкіряної справи. Можна купувати й продавати на Аукціоні." }
    t[244634] = { name = "Насичена лускоткана шкура", fen = "Crafted by players with the Leatherworking skill. Can be bought and sold on the Auction House.", fua = "Виготовляється гравцями з умінням Шкіряної справи. Можна купувати й продавати на Аукціоні." }
    t[244635] = { name = "Обкантовка обладунків сін'дорей", fen = "Crafted by players with the Leatherworking skill. Can be bought and sold on the Auction House.", fua = "Виготовляється гравцями з умінням Шкіряної справи. Можна купувати й продавати на Аукціоні." }
    t[244636] = { name = "Обкантовка обладунків сін'дорей", fen = "Crafted by players with the Leatherworking skill. Can be bought and sold on the Auction House.", fua = "Виготовляється гравцями з умінням Шкіряної справи. Можна купувати й продавати на Аукціоні." }
    t[244637] = { name = "Обмотка зброї Сільвермуна", fen = "Crafted by players with the Leatherworking skill. Can be bought and sold on the Auction House.", fua = "Виготовляється гравцями з умінням Шкіряної справи. Можна купувати й продавати на Аукціоні." }
    t[244638] = { name = "Обмотка зброї Сільвермуна", fen = "Crafted by players with the Leatherworking skill. Can be bought and sold on the Auction House.", fua = "Виготовляється гравцями з умінням Шкіряної справи. Можна купувати й продавати на Аукціоні." }
    t[244639] = "Барабани, торкнуті Порожнечею"
    t[244640] = "Набір броні лісового мисливця"
    t[244641] = "Набір броні лісового мисливця"
    t[244642] = "Набір для броні Лицаря крові"
    t[244643] = "Набір для броні Лицаря крові"
    t[244644] = "Таласський набір броні розвідника"
    t[244645] = "Таласський набір броні розвідника"
    t[244674] = { name = "Пожирущі смуги", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[244675] = { name = "Пожирущі смуги", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[244679] = "Рибальський гачок Завулку Убивць"
    t[244697] = { name = "Флюксова шестерня", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[244698] = { name = "Флюксова шестерня", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[244699] = { name = "Змащене зубчате колесо", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[244700] = { name = "Змащене зубчате колесо", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[244701] = { name = "Досконале зубчасте колесо", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[244702] = { name = "Досконале зубчасте колесо", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[244703] = { name = "Надійне зубчасте колесо", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[244704] = { name = "Надійне зубчасте колесо", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[244707] = { name = "Ножиці для тканини далекохода", fen = "For a quick snip in the field.", fua = "Для швидкого розкрою в польових умовах." }
    t[244708] = { name = "Ножиці сін'дорей", fen = "Meticulously crafted, especially by engineering standards.", fua = "Виготовлено надзвичайно ретельно, особливо як на інженерні мірки." }
    t[244709] = { name = "Мотлошний козирок мотлошниці", fen = "Makes everything look like treasure.", fua = "Робить так, що все має вигляд скарбу." }
    t[244710] = { name = "Налобний ліхтар сін'дорей", fen = "This battery ain't never goin' out.", fua = "Ця батарея ніколи не сяде." }
    t[244711] = "Аматорська вудка далекохода"
    t[244712] = "Вудка рибалки сін'дорей"
    t[244713] = { name = "Затискачі далекохода", fen = "Provides all the necessary tools for jewelcrafting in one convenient package.", fua = "Містить усі потрібні інструменти для ювелірства в одному зручному наборі." }
    t[244714] = { name = "Затискачі сін'дорей", fen = "When they ask \"How do you do it?\", show them this.", fua = "Коли вас питають «Як вам це вдається?», покажіть їм це." }
    t[244715] = "Захисна каска далекохода"
    t[244716] = "Позолочена каска сін'дорей"
    t[244717] = { name = "Багатофункційний інструмент мотлошниці", fen = "Gets the job done.", fua = "Робить свою справу." }
    t[244718] = { name = "Багатофункційний інструмент турбо-утилізатора", fen = "Oh yeah, this'll work.", fua = "О так, це спрацює." }
    t[244719] = "Сумка для каміння далекохода"
    t[244720] = "Старий добрий мішок мотлошниці"
    t[244735] = "Тканинні окуляри таласського змагуна"
    t[244736] = "Шкіряні окуляри таласського змагуна"
    t[244737] = "Кольчужне забрало таласського змагуна"
    t[244738] = "Латний шолом таласського змагуна"
    t[244739] = "Тканинні манжети таласського змагуна"
    t[244740] = "Шкіряні напульсники таласського змагуна"
    t[244741] = "Кольчужні з'єднання таласського змагуна"
    t[244742] = "Латні нараменники таласського змагуна"
    t[244743] = "Пов'язка на очі з етерлуму"
    t[244744] = "Окуляри з етерлуму"
    t[244745] = "Заслона зору з етерлуму"
    t[244746] = "Сонцезахист з етерлуму"
    t[244747] = "Шовкові манжети з етерлуму"
    t[244748] = "Зап'ястки з етерлуму"
    t[244749] = "Браслети з етерлуму"
    t[244750] = "Наручі з етерлуму"
    t[244751] = "Стрімкозавій Вічноядра"
    t[244752] = "Захисні окуляри з вічноядра"
    t[244753] = "Окуляри розвідника з вічноядра"
    t[244754] = "Захист зору з вічноядра"
    t[244755] = "Шовкові манжети кель'дореїв"
    t[244756] = "Пов'язки кель'дореїв"
    t[244757] = "Браслети кель'дореїв"
    t[244758] = "Наручі кель'дореїв"
    t[244759] = "Тканинні окуляри кель'дореїв"
    t[244760] = "Шкіряні окуляри кель'дореїв"
    t[244761] = "Кольчужна запона кель'дореїв"
    t[244762] = "Заборало кель'дореїв"
    t[244763] = "Тканинні пантофлі таласського змагуна"
    t[244764] = "Шкіряні капці таласського змагуна"
    t[244765] = "Кольчужні чоботи таласського змагуна"
    t[244766] = "Латні чоботи таласського змагуна"
    t[244767] = "М'якоступи кель'дореїв"
    t[244768] = "Бігунці кель'дореїв"
    t[244769] = "Грюкала кель'дореїв"
    t[244770] = "Тупотуни кель'дореїв"
    t[244771] = "М'якоступи з етерлуму"
    t[244772] = "Бігунці з етерлуму"
    t[244773] = "Гупала з етерлуму"
    t[244774] = "Тупотуни з етерлуму"
    t[244775] = { name = "Пам'ятна річ із К'ареша", fen = "Ethereal belongings from a life long-forgotten.", fua = "Ефіріальні пожитки з давно забутого життя." }
    t[244789] = "[PH] Test Fishing Rod B"
    t[244790] = "Звивиста Мисливиця"
    t[244791] = { name = "Рецепт: Оберіг рибалки амані", fen = "Teaches you how to craft an Amani Angler's Ward.", fua = "Навчає вас виготовляти оберіг рибалки амані." }
    t[244807] = "Колиска таласського доглядача рослин"
    t[244808] = "Робоча торба таласського слідопита природи"
    t[244809] = "Похідний капелюх таласського слідопита природи"
    t[244810] = "Рукавиці таласського майстра брухту"
    t[244811] = "Регалії таласського чинбаря шкур"
    t[244812] = "Ковпак для змішування таласського алхіміка"
    t[244813] = "Регалії таласського коваля заліза"
    t[244814] = "Великий фартух таласського гранувальника самоцвітів"
    t[244815] = { name = "Рецепт: Приманка для зловісного восьминога", fen = "Teaches you how to craft a Ominous Octopus Lure.", fua = "Навчає вас виготовляти приманку для зловісного восьминога." }
    t[244816] = { name = "Рецепт: Приманка везучого лоа", fen = "Teaches you how to craft a Lucky Loa Lure.", fua = "Навчає вас виготовляти приманку везучого лоа." }
    t[244817] = { name = "Рецепт: Приманка для кровомисливця", fen = "Teaches you how to craft a Blood Hunter Lure.", fua = "Навчає вас виготовляти приманку для кровомисливця." }
    t[244844] = { name = "Послання Клинка Сутінків", fen = "A note detailing the Twilight's Blade's movements.", fua = "Записка з докладними відомостями про пересування Сутінкового Леза." }
    t[245257] = { name = "Магічна кулька", fen = "An exquisite looking marble that emits a magical glow.", fua = "Вишукана на вигляд кулька, що випромінює магічне сяйво." }
    t[245337] = "Прудконоги з вічноядра"
    t[245338] = "Прошиті обмотки з вічноядра"
    t[245339] = "Турболанцюги з вічноядра"
    t[245340] = "Мастильні пластини з вічноядра"
    t[245341] = "Защіпка зап'ястків Вічноядра"
    t[245342] = "Скоба з вічноядра"
    t[245343] = "Кільчасті наручі з вічноядра"
    t[245344] = "Тягарець шестерні з вічноядра"
    t[245345] = { name = "Сплавлена життєва сила", fen = "A coalesced mote of pure, primal energy. Acquired by purchase from Abundance Vendor Chel the Chip or Abyss Angler Depthdiver Tu'nakit.", fua = "Згущена крихта чистої первісної енергії. Купується у Торговки рясності Чел Карбівки або в Рибалки Безодні Глибинника Ту'накіта." }
    t[245346] = { name = "Зразок Порожнечі", fen = "A crystalized core of latent void energy, sampled from the Dead Scar site.", fua = "Кристалізоване ядро прихованої енергії Порожнечі, взяте на місці Мертвого Шраму." }
    t[245347] = { name = "Зразок Порожнечі", fen = "A crystalized core of latent void energy, sampled from the South Peak site.", fua = "Кристалізоване ядро прихованої енергії Порожнечі, добуте на ділянці Південного піку." }
    t[245348] = { name = "Зразок Порожнечі", fen = "A crystalized core of latent void energy, sampled from the Tranquillien Woods site.", fua = "Кристалізоване ядро прихованої енергії Порожнечі, добуте на ділянці лісів Транквіл'єну." }
    t[245526] = "Кровомічене фазозв'язане забрало"
    t[245531] = { name = "Золотий сонцелист", fen = "A soft and springy shoot with leaves that glow like miniature suns.", fua = "М'який і пружний пагін із листям, що сяє, наче крихітні сонця." }
    t[245566] = { name = "Скалка Скверни", fen = "A tiny green crystal that looks like it was chipped off something much larger.", fua = "Крихітний зелений кристал, наче відколотий від чогось значно більшого." }
    t[245569] = { name = "Добряче зношений ополоник", fen = "A worn cooking ladle carved from wood, with a wrapped handle.", fua = "Зношений кухарський ополоник, вирізаний з дерева, з обмотаним держаком." }
    t[245570] = { name = "Поцуплене ремісниче свердло", fen = "A drill made from incredibly hard wood, carved to look like it's twisting to a sharp point.", fua = "Свердло з неймовірно твердого дерева, вирізьблене так, ніби воно скручується в гострий шпиль." }
    t[245571] = { name = "Пір'їна пелюсткокрила", fen = "The delicate feathers of the petalwing are prized by the haranir when used to apply fine lines and detail while painting.", fua = "Тендітні пера пелюсткокрила цінуються гаранірами, коли ними наносять тонкі лінії й деталі під час малювання." }
    t[245573] = { name = "Лосось", fen = "A tasty salmon. Yummy!", fua = "Смачний лосось. Смакота!" }
    t[245588] = { name = "Харчові припаси", fen = "A tough, jaw-testing slab of dry bread that's more punishment than provision.", fua = "Жорсткий, випробувальний для щелеп шмат сухого хліба — радше кара, ніж харч." }
    t[245610] = { name = "Сплеск світла Порожнечі", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[245628] = { name = "Намисто Похмуроспіва", fen = "An exquisite piece of ethereal jewelry. Timeworn, yet its luster remains.", fua = "Вишукана прикраса ефіріалів. Поточена часом, але блиск її не згас." }
    t[245644] = { name = "Коробка з Камінням", fen = "Exactly what you expect. Created by experienced alchemists.", fua = "Саме те, що ти й очікуєш. Створена досвідченими алхіміками." }
    t[245647] = { name = "Косяк самоцвітів", fen = "Stuffed to the gills with gems.", fua = "Напхом напханий самоцвітами." }
    t[245648] = { name = "Косяк самоцвітів", fen = "Stuffed to the gills with gems.", fua = "Напхом напханий самоцвітами." }
    t[245650] = { name = "Букет Трав", fen = "A lovely bouquet of herbs from Midnight regions. Created by experienced alchemists.", fua = "Чарівний букет трав із регіонів Опівночі. Створений досвідченими алхіміками." }
    t[245651] = { name = "Букет Трав", fen = "A lovely bouquet of herbs from Midnight regions. Created by experienced alchemists.", fua = "Чарівний букет трав із регіонів Опівночі. Створений досвідченими алхіміками." }
    t[245750] = "Колода Темного Місяця: Порожнеча"
    t[245751] = "Медальйон таласського змагуна"
    t[245752] = "Знак завзяття таласського змагуна"
    t[245753] = "Емблема таласського змагуна"
    t[245755] = "Таласський трактат з алхімії"
    t[245756] = "Таласський трактат із кравецтва"
    t[245757] = "Таласський трактат з накреслення"
    t[245758] = "Таласський трактат зі шкірообробки"
    t[245759] = "Таласський трактат із зачаровування"
    t[245760] = "Таласський трактат з ювелірства"
    t[245761] = "Таласський трактат із травництва"
    t[245762] = "Таласський трактат з гірництва"
    t[245763] = "Таласський трактат з ковальства"
    t[245764] = { name = "Кодифікований азекорінь", fen = "A refined piece of Azeroot. Crafted by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Очищений шматок азекореня. Створюється гравцями з умінням накреслення. Можна купувати й продавати на Аукціоні." }
    t[245765] = { name = "Кодифікований азекорінь", fen = "A refined piece of Azeroot. Crafted by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Очищений шматок азекореня. Створюється гравцями з умінням накреслення. Можна купувати й продавати на Аукціоні." }
    t[245766] = { name = "Шифр душі", fen = "A boundless rune crafted by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Безмежна руна, виготовлена гравцями з умінням Накреслення. Можна купувати й продавати на Аукціоні." }
    t[245767] = { name = "Шифр душі", fen = "A boundless rune crafted by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Безмежна руна, виготовлена гравцями з умінням Накреслення. Можна купувати й продавати на Аукціоні." }
    t[245768] = "Лампа вартового коренів"
    t[245769] = "Ліхтар Ал'нгари"
    t[245770] = "Тростина Ал'нгари"
    t[245771] = "Списовий жезл Ал'нгари"
    t[245772] = "Милиця доглядача флори"
    t[245773] = "Жезл доглядача фауни"
    t[245775] = "Перо писаря-аматора"
    t[245776] = "Перо сін'дорей"
    t[245777] = "Мішалка алхіміка-аматора"
    t[245778] = "Мішалка алхіміка сін'дорей"
    t[245779] = "Качалка аматора"
    t[245780] = "Качалка сін'дорей"
    t[245781] = { name = "Таласське послання сяйва", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245782] = { name = "Таласське послання сяйва", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245783] = { name = "Таласське послання гарячкового спалаху", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245784] = { name = "Таласське послання гарячкового спалаху", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245785] = { name = "Таласське послання вогняного спалаху", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245786] = { name = "Таласське послання вогняного спалаху", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245787] = { name = "Таласське послання гармонії", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245788] = { name = "Таласське послання гармонії", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245789] = { name = "Таласське послання незрівнянності", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245790] = { name = "Таласське послання незрівнянності", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245791] = { name = "Таласське послання швидкого клинка", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245792] = { name = "Таласське послання швидкого клинка", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245793] = { name = "Контракт: Сингулярність", fen = "A document drafted by Scribes pledging a Warband's allegiance to a faction.", fua = "Документ, складений Писарями, що засвідчує вірність загону певній фракції." }
    t[245794] = { name = "Контракт: Сингулярність", fen = "A document drafted by Scribes pledging a Warband's allegiance to a faction.", fua = "Документ, складений Писарями, що засвідчує вірність загону певній фракції." }
    t[245795] = { name = "Контракт: Гара'ті", fen = "A document drafted by Scribes pledging a Warband's allegiance to a faction.", fua = "Документ, складений Писарями, що засвідчує вірність загону певній фракції." }
    t[245796] = { name = "Контракт: Гара'ті", fen = "A document drafted by Scribes pledging a Warband's allegiance to a faction.", fua = "Документ, складений Писарями, що засвідчує вірність загону певній фракції." }
    t[245797] = { name = "Контракт: плем'я амані", fen = "A document drafted by Scribes pledging a Warband's allegiance to a faction.", fua = "Документ, складений Писарями, що засвідчує вірність загону певній фракції." }
    t[245798] = { name = "Контракт: плем'я амані", fen = "A document drafted by Scribes pledging a Warband's allegiance to a faction.", fua = "Документ, складений Писарями, що засвідчує вірність загону певній фракції." }
    t[245799] = { name = "Контракт: Двір Сільвермуна", fen = "A document drafted by Scribes pledging a Warband's allegiance to a faction.", fua = "Документ, складений Писарями, що засвідчує вірність загону певній фракції." }
    t[245800] = { name = "Контракт: Двір Сільвермуна", fen = "A document drafted by Scribes pledging a Warband's allegiance to a faction.", fua = "Документ, складений Писарями, що засвідчує вірність загону певній фракції." }
    t[245801] = { name = "Чорнило Манселла", fen = "A cool ink crafted by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Прохолодне чорнило, виготовлене гравцями з умінням Накреслення. Можна купувати й продавати на Аукціоні." }
    t[245802] = { name = "Чорнило Манселла", fen = "A cool ink crafted by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Прохолодне чорнило, виготовлене гравцями з умінням Накреслення. Можна купувати й продавати на Аукціоні." }
    t[245803] = { name = "Пігмент срібнолисту", fen = "A pigment milled by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Пігмент, змелений гравцями з умінням Накреслення. Можна купувати й продавати на Аукціоні." }
    t[245804] = { name = "Пігмент срібнолисту", fen = "A pigment milled by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Пігмент, змелений гравцями з умінням Накреслення. Можна купувати й продавати на Аукціоні." }
    t[245805] = { name = "Сієнове чорнило", fen = "A warm ink crafted by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Тепле чорнило, виготовлене гравцями з умінням Накреслення. Можна купувати й продавати на Аукціоні." }
    t[245806] = { name = "Сієнове чорнило", fen = "A warm ink crafted by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Тепле чорнило, виготовлене гравцями з умінням Накреслення. Можна купувати й продавати на Аукціоні." }
    t[245807] = { name = "Порошковий пігмент", fen = "A pigment milled by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Пігмент, змелений гравцями з умінням Накреслення. Можна купувати й продавати на Аукціоні." }
    t[245808] = { name = "Порошковий пігмент", fen = "A pigment milled by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Пігмент, змелений гравцями з умінням Накреслення. Можна купувати й продавати на Аукціоні." }
    t[245809] = "Таласський трактат з інженерії"
    t[245810] = "Переписати: Кров"
    t[245811] = "Переписати: Гниль"
    t[245812] = "Переписати: Полювання"
    t[245813] = "Переписати: Порожнеча"
    t[245814] = { name = "Таласське послання винахідливості", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245815] = { name = "Таласське послання винахідливості", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245816] = { name = "Таласське послання кмітливості", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245817] = { name = "Таласське послання кмітливості", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245818] = { name = "Таласське послання багаторазового виготовлення", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245819] = { name = "Таласське послання багаторазового виготовлення", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245820] = { name = "Таласське послання швидкості виготовлення", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245821] = { name = "Таласське послання швидкості виготовлення", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245822] = { name = "Таласське послання витонченості", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245823] = { name = "Таласське послання витонченості", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245824] = { name = "Таласське послання сприйняття", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245825] = { name = "Таласське послання сприйняття", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245826] = { name = "Таласське послання спритності", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245827] = { name = "Таласське послання спритності", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245828] = "Таласський трактат з білування"
    t[245829] = "Колода Темного Місяця: Лови"
    t[245830] = "Туз Полювання"
    t[245831] = "Двійка Полювання"
    t[245832] = "Трійка полювання"
    t[245833] = "Четвірка Полювання"
    t[245834] = "П'ятірка Полювання"
    t[245835] = "Шістка Полювання"
    t[245836] = "Сімка Полювання"
    t[245837] = "Вісімка Полювання"
    t[245838] = "Туз Порожнечі"
    t[245839] = "Двійка Порожнечі"
    t[245840] = "Трійка Порожнечі"
    t[245841] = "Четвірка Порожнечі"
    t[245842] = "П'ятірка Порожнечі"
    t[245843] = "Шістка Порожнечі"
    t[245844] = "Сімка Порожнечі"
    t[245845] = "Вісімка Порожнечі"
    t[245846] = "Колода Темного Місяця: Гниль"
    t[245847] = "Туз Гниття"
    t[245848] = "Двійка Гнилі"
    t[245849] = "Трійка гнилі"
    t[245850] = "Четвірка Гнилі"
    t[245851] = "П'ятірка Гнилі"
    t[245852] = "Шістка Гнилі"
    t[245853] = "Сімка Гнилі"
    t[245854] = "Вісімка Гнилі"
    t[245855] = "Колода Темного Місяця: Кров"
    t[245856] = "Туз Крові"
    t[245857] = "Двійка Крові"
    t[245858] = "Трійка крові"
    t[245859] = "Четвірка Крові"
    t[245860] = "П'ятірка Крові"
    t[245861] = "Шістка Крові"
    t[245862] = "Сімка Крові"
    t[245863] = "Вісімка Крові"
    t[245864] = { name = "Пігмент кровотерну", fen = "A pigment milled by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Пігмент, змелений гравцями з умінням Накреслення. Можна купувати й продавати на Аукціоні." }
    t[245865] = { name = "Пігмент кровотерну", fen = "A pigment milled by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Пігмент, змелений гравцями з умінням Накреслення. Можна купувати й продавати на Аукціоні." }
    t[245866] = { name = "Пігмент лілеї мани", fen = "A pigment milled by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Пігмент, змелений гравцями з умінням Накреслення. Можна купувати й продавати на Аукціоні." }
    t[245867] = { name = "Пігмент лілеї мани", fen = "A pigment milled by players with the Inscription skill. Can be bought and sold on the Auction House.", fua = "Пігмент, змелений гравцями з умінням Накреслення. Можна купувати й продавати на Аукціоні." }
    t[245868] = "Стовп таласського змагуна"
    t[245869] = "Лук таласського змагуна"
    t[245870] = "Ліхтар таласського змагуна"
    t[245871] = { name = "Знак Темного Місяця: Кров", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245872] = { name = "Знак Темного Місяця: Кров", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245873] = { name = "Знак Темного Місяця: Порожнеча", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245874] = { name = "Знак Темного Місяця: Порожнеча", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245875] = { name = "Знак Темного Місяця: Лови", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245876] = { name = "Знак Темного Місяця: Лови", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245877] = { name = "Знак Темного Місяця: Гниль", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245878] = { name = "Знак Темного Місяця: Гниль", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[245879] = "Руна Вантуса: Сяйлива"
    t[245880] = "Руна Вантуса: Сяйлива"
    t[245881] = { name = "Пергамент лексиколога", fen = "A parchment frequently used by Scribes. Can be purchased from vendors.", fua = "Пергамент, що часто використовується Писарями. Можна придбати у торгівців." }
    t[245882] = { name = "Таласська співоча вода", fen = "A liquid cleared of its impurities and frequently used by Scribes. Can be purchased from vendors.", fua = "Очищена від домішок рідина, що часто використовується Писарями. Можна придбати у торгівців." }
    t[245883] = { name = "Заляпаний сувій", fen = "A haranir scroll with tight lettering. The parchment is torn and there are dark burgundy stains splattered across its face.", fua = "Сувій гараніру з тісним письмом. Пергамент розірваний, а по його лицьовій стороні розбризкані темні бордові плями." }
    t[245886] = { name = "Заплямований фарбою гарбузок", fen = "This small gourd is covered in drips and speckles of various shades of paint. A sloshing sound indicates that some paint yet remains within.", fua = "Цей маленький гарбузок укритий патьоками й плямами фарби різних відтінків. Хлюпотіння всередині свідчить, що там ще лишилося трохи фарби." }
    t[245897] = "Швидкоплинний потенціал Світла"
    t[245898] = "Швидкоплинний потенціал Світла"
    t[245900] = "Швидкоплинне зілля фанатизму"
    t[245901] = "Швидкоплинне зілля фанатизму"
    t[245902] = "Швидкоплинне зілля безрозсудності"
    t[245903] = "Швидкоплинне зілля безрозсудності"
    t[245904] = "Швидкоплинне зілля поглинутих снів"
    t[245905] = "Швидкоплинне зілля поглинутих снів"
    t[245910] = "Швидкоплинне зілля нестримної жаги"
    t[245911] = "Швидкоплинне зілля нестримної жаги"
    t[245916] = "Швидкоплинне світлозлите зілля мани"
    t[245917] = "Швидкоплинне світлозлите зілля мани"
    t[245918] = "Швидкоплинне сільвермунське зілля здоров'я"
    t[245919] = "Швидкоплинне сільвермунське зілля здоров'я"
    t[245926] = "Швидкоплинна фляга таласського спротиву"
    t[245927] = "Швидкоплинна фляга таласського спротиву"
    t[245928] = "Швидкоплинна фляга Розбитого Сонця"
    t[245929] = "Швидкоплинна фляга Розбитого Сонця"
    t[245930] = "Швидкоплинна фляга Лицарів крові"
    t[245931] = "Швидкоплинна фляга Лицарів крові"
    t[245932] = "Швидкоплинна фляга магістрів"
    t[245933] = "Швидкоплинна фляга магістрів"
    t[245934] = { name = "Розбити есенцію", fen = "Shatter a magical essence of Midnight to receive a temporary boon for your crafting.", fua = "Розбийте магічну есенцію Опівночі, щоб отримати тимчасове благо для свого ремесла." }
    t[245937] = { name = "Рештки, осквернені Порожнечею", fen = "Remains of something... or someone. Deminos Darktrance in Masters' Perch would be interested in this.", fua = "Рештки чогось... або когось. Деміноса Дарктренса в Сідало Володарів це б зацікавило." }
    t[245982] = { name = "Велика печінка панго", fen = "A particularly large, fresh pango liver.", fua = "Особливо велика, свіжа печінка панго." }
    t[246054] = { name = "Око, змінене Світлом", fen = "The light continues to burn within.", fua = "Світло й далі палає всередині." }
    t[246087] = "Дорогоцінний ключ"
    t[246112] = { name = "Щит Альянсу", fen = "This shield has seen many battles, the last of which was against a large saptor -- evident by the large claw marks digging into the metal.", fua = "Цей щит бачив багато боїв, останній з яких був проти великого смолораптора — про це свідчать глибокі сліди пазурів, що вгризлися в метал." }
    t[246117] = { name = "Різьблений ключ", fen = "This small key looks as though it was carved from wood, but feels as strong as metal.", fua = "Цей маленький ключ виглядає так, ніби вирізьблений з дерева, але на дотик міцний, як метал." }
    t[246118] = { name = "Глек Ен'ліан", fen = "A ceramic jug for collecting the Healing Waters of Ahl'ua. It is decorated in the Hara'ti style.", fua = "Керамічний глек для збирання Цілющих Вод Ал'уа. Оздоблений у стилі гара'ті." }
    t[246120] = { name = "Нотатки про вирощування", fen = "This scroll is a meticulous account of Ru'gar's growing methods, noting in detail the steps he took while cultivating his plants.", fua = "Цей сувій — прискіпливий опис методів вирощування Ру'ґара, у якому детально занотовано кроки, що він робив, плекаючи свої рослини." }
    t[246126] = { name = "Сокира Орди", fen = "This heavy axe has sticky sap on its edge. Whoever the owner is, they were fighting one of the local beasts.", fua = "На лезі цієї важкої сокири — липкий сік. Хто б не був її власником, він бився з одним із місцевих звірів." }
    t[246129] = { name = "Спорядження чужинця", fen = "Proxy for Quest.", fua = "Замінник для завдання." }
    t[246152] = { name = "Комір смолораптора", fen = "A frill of flowers from the head of a saptor. It smells like honey.", fua = "Квітковий комір із голови смолораптора. Пахне медом." }
    t[246153] = { name = "Шкура інвазивної рисі", fen = "The pelt is warm and soft, and feels even warmer knowing you helped cut down an invasive population while retrieving it.", fua = "Шкура тепла й м'яка, а ще тепліше стає на душі від думки, що, здобуваючи її, ти допоміг скоротити інвазивну популяцію." }
    t[246166] = { name = "Рекомендація далекоходів", fen = "A recommendation issued by Ranger Hannovia for the recommendee to become a Farstrider.", fua = "Рекомендація, видана рейнджеркою Ганновією, щоб названа особа стала далекоходом." }
    t[246167] = { name = "Рекомендація Лицарів крові", fen = "A recommendation issued by Jesthenis Sunstriker for the recommendee to become a Blood Knight.", fua = "Рекомендація, видана Джестенісом Сонцеструном, що дозволяє названій особі вступити до Лицарів крові." }
    t[246168] = { name = "Рекомендація магістра", fen = "A recommendation issued by Magister Jaronis for the recommendee to become a Magister.", fua = "Рекомендація, видана магістром Джаронісом, аби названа особа стала магістром." }
    t[246209] = "12.0 Monster - Arator - Sword1H - Sword_1H_Arator_D_01"
    t[246210] = { name = "Розбитий посох", fen = "This staff seems to have been broken with a harsh impact many years ago.", fua = "Здається, цей посох багато років тому зламали потужним ударом." }
    t[246221] = { name = "Викрадені пожитки", fen = "Property of a haranir, likely pilfered by a trained petalwing.", fua = "Власність гараніра, ймовірно поцуплена навченим пелюсткокрилом." }
    t[246236] = { name = "Ящик допомоги", fen = "Chock-full of bandages, salves, and other aid.", fua = "Напхом напханий бинтами, мазями та іншими ліками." }
    t[246268] = { name = "Палкий любовний роман: Жага Порожнечі", fen = "This binder of loose notes looks like an unpublished manuscript. Written by 'D'.", fua = "Ця тека з розрізненими нотатками скидається на неопублікований рукопис. Написано «Д»." }
    t[246304] = "Панування Темного Місяця: Лови"
    t[246305] = "Панування Темного Місяця: Кров"
    t[246306] = "Панування Темного Місяця: Гниль"
    t[246307] = "Панування Темного Місяця: Порожнеча"
    t[246314] = { name = "Булькітлива грудка фарби", fen = "Rinse this the next time you go for a swim to reveal what wriggles in the paint blob. Warning, you may get wet as well.", fua = "Сполощіть її наступного разу, коли підете плавати, щоб побачити, що звивається всередині грудки фарби. Увага: ви теж можете намокнути." }
    t[246320] = "Проблиск алхімічних знань Опівночі"
    t[246321] = "Промінець знань про алхімію Опівночі"
    t[246322] = "Проблиск ковальських знань Опівночі"
    t[246323] = "Промінець знань про ковальство Опівночі"
    t[246324] = "Проблиск знань зачаровування Опівночі"
    t[246325] = "Промінець знань про накладання чарів Опівночі"
    t[246326] = "Проблиск інженерних знань Опівночі"
    t[246327] = "Промінець знань про інженерство Опівночі"
    t[246328] = "Проблиск знань накреслення Опівночі"
    t[246329] = "Промінець знань про накреслення Опівночі"
    t[246330] = "Проблиск ювелірних знань Опівночі"
    t[246331] = "Промінець знань про ювелірство Опівночі"
    t[246332] = "Проблиск чинбарських знань Опівночі"
    t[246333] = "Промінець знань про шкіряна справа Опівночі"
    t[246334] = "Проблиск кравецьких знань Опівночі"
    t[246335] = "Промінець знань про кравецтво Опівночі"
    t[246345] = { name = "Древкова зброя", fen = "A little worse for wear, but still effective.", fua = "Трохи пошарпана, та все ще дієва." }
    t[246363] = { name = "Ягода сінара", fen = "Special care is required when handling these deep, red berries. If done incorrectly, it makes a potent poison. Delicious, albeit rather deadly.", fua = "З цими темно-червоними ягодами треба поводитися особливо обережно. Якщо зробити щось не так, вийде потужна отрута. Смачно, хоч і досить смертельно." }
    t[246364] = { name = "Цвіт беланісу", fen = "The rich fragrance and sweet, earthy flavor can be an acquired taste.", fua = "Насичений аромат і солодкий, землистий смак — до них треба звикнути." }
    t[246371] = { name = "Стріла балісти", fen = "A right-sized projectile for giant, lumbering elementals.", fua = "Снаряд саме того розміру для велетенських, неповоротких елементалів." }
    t[246372] = { name = "Шматок, насичений Порожнечею", fen = "A succulent bit of flesh perfect for a growing behemoth's diet.", fua = "Соковитий шматочок плоті, ідеальний для раціону бегемота, що росте." }
    t[246374] = { name = "Кров невинного", fen = "Blood taken from an innocent.", fua = "Кров, узята в невинного." }
    t[246376] = { name = "Солаарська сінталія", fen = "A fabulous fruit-infused blend, with a hint of belanise. If it is not Solaarian, it is just fruit wine.", fua = "Чудова суміш, настояна на фруктах, з ноткою беланісу. Якщо вона не солаарська, це просто фруктове вино." }
    t[246379] = { name = "Цілком підхожа риба", fen = "There is nothing wrong with this fish. It is absolutely adequate for your needs.", fua = "З цією рибою все гаразд. Вона цілком підходить для твоїх потреб." }
    t[246380] = { name = "Доволі добра риба", fen = "This is a good fish, a happy fish, a fairly fine fish.", fua = "Це добра риба, щаслива риба, доволі добра риба." }
    t[246381] = { name = "Гарненька пухка рибина", fen = "What a nice fish. It is plump and round and scaly.", fua = "Яка чудова рибина. Пухка, кругленька й лускоплеча." }
    t[246382] = { name = "Казкова риба", fen = "My goodness, what a fabulous fish!", fua = "Боже мій, яка ж казкова риба!" }
    t[246383] = "Севіче, политий сонцем"
    t[246397] = { name = "Мантія сутінкового культиста", fen = "A passable collection of purple cloth that will obscure you while you infiltrate the cult.", fua = "Стерпний набір багряної тканини, що приховає тебе, поки ти проникаєш у культ." }
    t[246398] = { name = "Каптур культиста", fen = "Perfect for concealing one's face while still representing the Twilight's Blade.", fua = "Чудово приховує обличчя, водночас являючи приналежність до Клинка Сутінків." }
    t[246399] = { name = "Кинджал культиста", fen = "Suitably curved and wicked-looking.", fua = "Доречно вигнутий і лиховісний на вигляд." }
    t[246400] = { name = "Шати культиста", fen = "Fashionably purple and only a little flecked with blood.", fua = "Модного фіолетового кольору й лише трохи заплямовані кров'ю." }
    t[246435] = { name = "Реліквіарій темряви", fen = "A spell focus used by Lucia Nightbreaker for powerful voidcasting. A hunger for Void energy dwells within.", fua = "Фокус для заклять, яким Люсія Нічолом творила могутні чари Порожнечі. Усередині дрімає голод за енергією Порожнечі." }
    t[246436] = { name = "Оґрів фоліант темної магії", fen = "This remarkably complex tome filled with technical spells makes you question stereotypes you've heard about ogres.", fua = "Цей напрочуд складний фоліант, сповнений мудрованих заклять, змушує засумніватися в усіх стереотипах про оґрів, які тобі доводилося чути." }
    t[246437] = { name = "Оґрів фоліант бойових прийомів", fen = "This remarkably simple tome filled with colorful pictures reinforces stereotypes you've heard about ogres.", fua = "Цей напрочуд простий фоліант, сповнений яскравих малюнків, лише підтверджує всі стереотипи про оґрів, які тобі доводилося чути." }
    t[246439] = { name = "Попіл Порожнечі", fen = "The remains of a fallen void elemental, cold to the touch.", fua = "Рештки полеглого елементаля Порожнечі, холодні на дотик." }
    t[246440] = { name = "Стегнова кістка культиста", fen = "You have no idea what the troll scout plans to use this for.", fua = "Ти й гадки не маєш, для чого троль-розвідниця збирається це використати." }
    t[246441] = "Гудуче ядро"
    t[246443] = { name = "Сокирка амані", fen = "This hatchet was left behind after its owner could no longer fight.", fua = "Цю сокирку покинули, коли її власник більше не міг битися." }
    t[246447] = { name = "Каракулі підмайстра", fen = "Useful in small doses. Can be bought and sold on the Auction House.", fua = "Корисні в малих дозах. Можна купити й продати на Аукціоні." }
    t[246448] = { name = "Облікова книга майстра", fen = "For perusing at your leisure. Can be bought and sold on the Auction House.", fua = "Для читання на дозвіллі. Можна купити й продати на Аукціоні." }
    t[246449] = { name = "Корисний виріб наставника", fen = "No need to reinvent the wheel. Can be bought and sold on the Auction House.", fua = "Не треба винаходити велосипед. Можна купити й продати на Аукціоні." }
    t[246450] = { name = "Золота зірка Консорціуму майстрів", fen = "An award befitting a crafter of great esteem.", fua = "Нагорода, гідна вельми шанованого майстра." }
    t[246460] = "Розсіяний ефірозаряджений кристал"
    t[246514] = "Надзвичайно елегантна кравецька мантія ремісника"
    t[246515] = "Надзвичайно елегантний капелюх травника-ремісника"
    t[246521] = "Надзвичайно елегантний алхімічний комбінезон ремісника"
    t[246522] = "Надзвичайно елегантний кухарський ковпак ремісника"
    t[246524] = "Бездоганні дослідники тексту"
    t[246525] = "Кристалічна лінза таласського писаря"
    t[246526] = "Точні лупи магічного ока"
    t[246527] = "Налаштована таласійська рунічна призма"
    t[246533] = "Сонцегартований серп"
    t[246534] = "Сонцегартована кирка"
    t[246535] = "Сонцегартований білувальний ніж"
    t[246536] = "Сонцегартований чинбарський ніж"
    t[246537] = "Сонцегартований ковальський молот"
    t[246585] = { name = "Виплата Консорціуму майстрів", fen = "On behalf of our Patrons.", fua = "Від імені наших покровителів." }
    t[246586] = { name = "Панцир Шадри", fen = "A large piece of a spider loa's carapace.", fua = "Великий шматок панцира лоа-павучихи." }
    t[246590] = { name = "Попіл Бело'рена", fen = "Teaches you how to summon this mount.  This mount changes depending on your Riding skill and location.", fua = "Навчає викликати цей засіб пересування. Цей засіб пересування змінюється залежно від вашої навички верхової їзди та місцезнаходження." }
    t[246621] = { name = "Отруйний ріг", fen = "This spike looks similar to a venomous fang.", fua = "Цей шип схожий на отруйне ікло." }
    t[246661] = { name = "Сліпуча світлошапка", fen = "A glowing morel perfect for encouraging muscle growth in Voidstorm's wildlife.", fua = "Сяйлива зморшок, ідеальна для стимуляції росту м'язів у звірів Бурі Порожнечі." }
    t[246671] = { name = "Рецепт: Кадило сонячного диму", fen = "Teaches you how to craft a Sunsmoke Censer.", fua = "Навчає вас виготовляти кадило сонячного диму." }
    t[246681] = { name = "Ритуальне ікло", fen = "This fang is an enormous version of the fangs seen on the spiders in Witherbark Bluffs.", fua = "Це ікло — велетенська версія ікл, які можна побачити в павуків на кручах Візербарків." }
    t[246693] = "Таласійське сонцевино з самоналивом"
    t[246699] = { name = "Уламок реліквії Наґоша", fen = "Similar to the piece Mar'kag was using as a belt buckle.", fua = "Схожий на той шматок, який Мар'каг носив як пряжку для пояса." }
    t[246704] = { name = "Пряжка Мар'каґа", fen = "Mar'kag recognized the strength of the metal and used it as a buckle.", fua = "Мар'каґ розпізнав міцність металу й використав його як пряжку." }
    t[246731] = { name = "Присмерковий Похмурорись", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[246734] = { name = "Лютий грімрись", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[246735] = { name = "Грімрись-кореневий переслідувач", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[246736] = { name = "Кістяний грімрись", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[246744] = { name = "Око Шадри", fen = "A magical eye from the giant spider loa.", fua = "Магічне око гігантської лоа-павучихи." }
    t[246886] = { name = "Гармонійний батіг", fen = "Many grovecrawlers consider the fronds of lashers to be a delicacy.", fua = "Багато гайоповзів вважають листя батожників делікатесом." }
    t[246910] = { name = "Витриманий витвір", fen = "Elrendar Reserve, 25.", fua = "Ельрендарський резерв, 25." }
    t[246911] = { name = "Викинута чарівна паличка", fen = "A plain, dormant wand. A note is attached to its handle: \"DEEMED UNSUITABLE. RECYCLE.\"", fua = "Проста, бездіяльна чарівна паличка. До держака причеплено записку: «ВИЗНАНО НЕПРИДАТНОЮ. ПЕРЕРОБИТИ»." }
    t[246912] = { name = "Нестабільна аркана", fen = "The glass vial pulses with shifting arcane energy, unpredictable and uncontrollable.", fua = "Скляна пляшечка пульсує мінливою таємною енергією, непередбачуваною й некерованою." }
    t[246913] = { name = "Магічне манго", fen = "Likely pilfered from a Magister's party table.", fua = "Найпевніше поцуплене зі святкового столу магістра." }
    t[246914] = { name = "Цілком придатне зерно", fen = "Triple inspected, this grain is surely safe to handle and consume.", fua = "Тричі перевірене, це зерно безперечно безпечне для використання й споживання." }
    t[246923] = { name = "Філе торочкориби", fen = "Prized for its tender texture, the fillet has wave-like marbling and a subtly briny flavor.", fua = "Цінується за ніжну структуру; філе має хвилясту мармуровість і ледь солонуватий смак." }
    t[246924] = { name = "Коренева дрейфова медуза", fen = "Sweet and shimmering, it is rumored to tingle on the tongue and glow faintly in the dark.", fua = "Солодка й мерехтлива, подейкують, що вона поколює язик і ледь світиться в темряві." }
    t[246926] = { name = "Поживний ґрунт", fen = "Soil packed in nutrients needed for a growing rutaani. A meal replacement for those not inclined to consuming solids.", fua = "Ґрунт, насичений поживними речовинами, потрібними для росту рутаані. Замінник їжі для тих, хто не схильний споживати тверду їжу." }
    t[246942] = { name = "Трупна шкірка", fen = "Freshly slain, the plant-based flesh still shines with a moist glow.", fua = "Свіжовбита, рослинна плоть досі сяє вологим полиском." }
    t[246951] = { name = "Ядро Штормаріона", fen = "An energized core charged with potent energy.", fua = "Заряджене ядро, повне потужної енергії." }
    t[247218] = { name = "Відзнака Кам'яного Вартового", fen = "The Dark Horde awards this badge to highly capable fighters, which often become their future leaders.", fua = "Темна Орда вручає цю відзнаку надзвичайно вправним бійцям, які часто стають її майбутніми ватажками." }
    t[247237] = { name = "Зразки цвілі", fen = "Mold samples for growing the next generation of grudgefighters.", fua = "Зразки цвілі для вирощування наступного покоління бійців Ями Злоби." }
    t[247243] = { name = "Дивна грибниця", fen = "This sample of fungarian flesh seems off. It would be wise not to touch it directly.", fua = "Цей зразок плоті фунґаріанина здається підозрілим. Розумно було б не торкатися його голіруч." }
    t[247422] = { name = "Злостивий тінещеп", fen = "The strange metal of these cuff-like fragments thrum with Void energy. Holding it, your heart races. You long for the thrill of the battle.", fua = "Дивний метал цих наручеподібних уламків гуде енергією Порожнечі. Тримаючи його, ти відчуваєш, як серце прискорюється. Тебе тягне до гострих відчуттів бою." }
    t[247423] = { name = "Рецепт: Фонтан Сільвермунського шпиля", fen = "Teaches you how to craft a Silvermoon Spire Fountain.", fua = "Навчає вас виготовляти фонтан Сільвермунського шпиля." }
    t[247425] = { name = "Рецепт: Камінь Розлому", fen = "Teaches you how to craft a Riftstone.", fua = "Навчає вас виготовляти камінь Розлому." }
    t[247498] = { name = "Рецепт: Ентропійне світило", fen = "Teaches you how to craft an Entropic Illuminant.", fua = "Навчає вас виготовляти ентропійне світило." }
    t[247499] = { name = "Рецепт: Консерванти гаранірів", fen = "Teaches you how to create a Haranir Preserving Agents.", fua = "Навчає вас створювати консерванти гаранірів." }
    t[247500] = { name = "Рецепт: Корінням сповитий чан", fen = "Teaches you how to create a Rootbound Vat.", fua = "Навчає вас створювати корінням сповитий чан." }
    t[247593] = "Позичена Чарівна Паличка"
    t[247672] = { name = "Шипучка Вічної Пісні", fen = "Cooling and refreshing, with a hint of sunfire water.", fua = "Прохолодна й освіжна, з ноткою сонцевогняної води." }
    t[247673] = { name = "Сін'грія із Сільвермуна", fen = "A blend of wine and fruit, inspired by certain provincial artisans.", fua = "Суміш вина й фруктів, натхненна певними провінційними майстрами." }
    t[247713] = { name = "Реліквіарій темряви", fen = "A spell focus used by Lucia Nightbreaker for powerful voidcasting. A hunger for Void energy dwells within.", fua = "Фокус для заклять, яким Люсія Нічолом творила могутні чари Порожнечі. Усередині дрімає голод за енергією Порожнечі." }
    t[247719] = "Матриця багатовиробу"
    t[247724] = "Колектор багатовиробу"
    t[247725] = "Винахідлива арматура"
    t[247726] = "Винахідливе сполучення"
    t[247788] = "Хитромудра особистість"
    t[247811] = { name = "Олія серцедерева", fen = "An alchemical reagent used for neutralizing the effects of potions and flasks. Can be purchased from Alchemy suppliers throughout Midnight zones.", fua = "Алхімічний реагент, що використовується для нейтралізації дії зілля й настоянок. Можна придбати в постачальників алхімії в усіх зонах Опівночі." }
    t[247854] = { name = "Наповнений релікварій темряви", fen = "A spell focus used by Lucia Nightbreaker for powerful voidcasting. It is ready for her to use.", fua = "Фокус закляттів, який Люсія Найтбрейкер використовує для могутніх заклять Порожнечі. Він готовий до її використання." }
    t[247860] = { name = "Спори-Бомби", fen = "Dangerously unstable spores.", fua = "Небезпечно нестабільні спори." }
    t[248018] = "Поножі Світлоловця"
    t[248019] = "Обгоріле вбрання Вата'нан"
    t[248020] = "Обгорілий нагрудник Вата'нан"
    t[248021] = "Обгоріла кольчуга Вата'нан"
    t[248022] = "Обгорілий каптан Вата'нан"
    t[248023] = "Шкіряні рукавиці рисогуба"
    t[248024] = "Укріплені рукавиці рисогуба"
    t[248025] = "Зшиті рукавиці рисогуба"
    t[248026] = "Лускаті рукавиці рисогуба"
    t[248027] = "Корона вічноспівного захисника"
    t[248028] = "Кольчужний шолом вічноспівного захисника"
    t[248029] = "Каптур вічноспівного захисника"
    t[248030] = "Поножі сутінкового шпигуна"
    t[248031] = "Штани сутінкового шпигуна"
    t[248032] = "Штани сутінкового шпигуна"
    t[248033] = "Облягаючі штани сутінкового шпигуна"
    t[248038] = "Пояс гербіциду"
    t[248039] = "Пояс гербіциду"
    t[248040] = "Поясний обладунок гербіциду"
    t[248041] = "Пояс гербіциду"
    t[248042] = "Манжети нерішучого дипломата"
    t[248043] = "Наручі нерішучого дипломата"
    t[248044] = "Передпліччя нерішучого дипломата"
    t[248045] = "Обмотки нерішучого дипломата"
    t[248046] = "Ритуальний перстень, осквернений Порожнечею"
    t[248047] = { name = "Перстень Світлоцвіту", fen = "Uncomfortably warm to the touch.", fua = "Неприємно теплий на дотик." }
    t[248048] = "Перстень буяння"
    t[248049] = "Ланцюг Вічної Пісні"
    t[248050] = "Кольє Транквілліена"
    t[248051] = "Зіпсутий сутінковий каптур"
    t[248052] = "Покрив зради"
    t[248053] = "Шолом вічноспівного захисника"
    t[248054] = "Капці Світлоловця"
    t[248055] = "Чоботи Світлоловця"
    t[248056] = "Черевики Світлоловця"
    t[248057] = "Накидка Підрізальника Бруньок"
    t[248058] = "Накидка рятівника Сонцекорони"
    t[248059] = "Кинджал Золотого Міста"
    t[248061] = "Топірець Золотого Міста"
    t[248062] = "Сокира Золотого Міста"
    t[248063] = "Тесак Золотого Міста"
    t[248064] = "Булава полеглої матрони"
    t[248065] = "Молот неправедного"
    t[248066] = "Лиховісний черепотрощ"
    t[248067] = "Клинок Золотого Міста"
    t[248068] = "Короткий меч Золотого Міста"
    t[248069] = "Клинок зрадливого послушника"
    t[248070] = "Клеймор Золотого Міста"
    t[248071] = "Великий меч Золотого Міста"
    t[248072] = "Награбований глефа культиста"
    t[248074] = "Кат капітана-зрадника"
    t[248075] = "Посох Золотого Міста"
    t[248076] = "Жезл Золотого Міста"
    t[248077] = "Викинутий щит Захисника"
    t[248078] = "Довгий лук Золотого Міста"
    t[248080] = "Фетиш зачарованої крипти"
    t[248082] = { name = "Блискучий предмет", fen = "Knick-nacks, jewelry and other objects. As long as it is shiny, it might be here.", fua = "Дрібнички, прикраси та інші речі. Якщо воно блищить — може бути тут." }
    t[248083] = { name = "Запорошений Кварцовий Амулет", fen = "An hand carved amulet, long forgotten by it's owner. It appears to have sentimental value.", fua = "Вирізьблений вручну амулет, давно забутий своїм власником. Здається, він має сентиментальну цінність." }
    t[248084] = "Кинджал зрадника в спину"
    t[248085] = { name = "Потерте бурштинове кільце з листя", fen = "A ring made of leaves and an amber gemstone. It appears to be worn down from being exposed to the elements for so long.", fua = "Кільце з листя та бурштинового самоцвіту. Воно виглядає потертим, наче довго було під впливом стихій." }
    t[248086] = { name = "Есенція Порожнечі", fen = "The coalesced energy of Void drawn from the violence innate to Voidstorm life.", fua = "Згуртована енергія Порожнечі, видобута з насильства, властивого життю Бурі Порожнечі." }
    t[248087] = { name = "Чокер із папоротевого кореня", fen = "A choker made from condensed fern leaves under pressure. It's owner surely misses it.", fua = "Чокер, зроблений зі спресованого під тиском листя папороті. Його власник напевне сумує за ним." }
    t[248130] = { name = "Щасливий брелок", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[248132] = { name = "Кінетичні підривники для кісточок", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[248133] = { name = "Кінетичні підривники для кісточок", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[248135] = { name = "B1P, Спопеляч Душ", fen = "Summons Bip, Soul Scorcher. Created by players with the Engineering skill. Can be bought and sold on the Auction House.", fua = "Призиває B1P, Спопеляча Душ. Створюється гравцями з умінням інженерії. Можна купити й продати на Аукціоні." }
    t[248136] = { name = "M3DDY, кишеньковий", fen = "Created by players with the Engineering skill. Can be bought and sold on the Auction House.", fua = "Створюється гравцями з умінням Інженерії. Можна купити й продати на Аукціоні." }
    t[248137] = "M3DDY"
    t[248138] = "Цікава червона кнопка"
    t[248139] = { name = "Квіт Ал'нгари", fen = "This bloom pulses faintly, as if in rhythm with a song that cannot be heard.", fua = "Цей квіт ледь помітно пульсує, наче в такт пісні, якої не почути." }
    t[248205] = { name = "Лишковий елементій", fen = "Raw Elementium pieces. Not as valuable as they once were, but useful in dark rituals.", fua = "Сирі шматки елементію. Вже не такі цінні, як колись, але корисні в темних ритуалах." }
    t[248207] = { name = "Щоденник Гієрона", fen = "A battered journal carried by Riftwalker Hieron.", fua = "Пошарпаний щоденник, що його носив із собою Гієрон, Мандрівник Розломів." }
    t[248209] = { name = "Потертий конверт", fen = "Sealed and tucked between the pages of Hieron's journal like he'd been using it as a bookmark. Addressed to Sedona Duskspire in Silvermoon.", fua = "Запечатаний і вкладений між сторінок щоденника Гієрона, наче той правив ним за закладку. Адресований Седоні Даскспір у Сільвермуні." }
    t[248239] = "Лікувальна фляга"
    t[248241] = { name = "Листя примарної квітки", fen = "Ephemeral and fragrant. Pruned from matured ghostflower plants.", fua = "Швидкоплинне й запашне. Зрізане з достиглих рослин примарної квітки." }
    t[248244] = { name = "Резонатор зіпсуття", fen = "Enchanted by Arcanist Taemin himself.", fua = "Зачарований особисто арканістом Теміном." }
    t[248280] = "Жезл аналізу Порожнечі"
    t[248281] = { name = "Скалка Світла", fen = "A fragment of crystal imbued with the warm, gentle glow of the Light.", fua = "Фрагмент кристала, просякнутий теплим, лагідним сяйвом Світла." }
    t[248300] = { name = "Дрібничка Налоракка", fen = "This small carving pulses lightly with a sense of hungry energy.", fua = "Ця маленька різьблена фігурка ледь помітно пульсує відчуттям голодної енергії." }
    t[248409] = "В-4РТ0ВИЙ ПЕ5"
    t[248485] = "Генератор Червоточин: Кель'Талас"
    t[248486] = "Аварійний Зв'язок Душ"
    t[248551] = "Намотки на руки сутінколома"
    t[248552] = "Рукавиці сутінколома"
    t[248553] = "Захвати сутінколома"
    t[248554] = "Латні рукавиці сутінколома"
    t[248555] = "Кріс Кам'яного Гілля"
    t[248556] = "Дворучний меч Кам'яного Гілля"
    t[248557] = "Кинджал Кам'яного Гілля"
    t[248558] = "Лезо Кам'яного Гілля"
    t[248559] = "Лук Кам'яного Гілля"
    t[248560] = "Клинок Кам'яного Гілля"
    t[248561] = "Сокира Кам'яного Гілля"
    t[248562] = "Спис Кам'яного Гілля"
    t[248563] = "Черевики Зулгварда"
    t[248564] = "Тупотуни Зулгварда"
    t[248565] = "Крокоступи Зулгварда"
    t[248566] = "Бойові чоботи Зулгварда"
    t[248567] = "Шати благословенного небесами"
    t[248568] = "Жилет благословенного небесами"
    t[248569] = "Кольчуга благословенного небесами"
    t[248570] = "Нагрудник благословенного небесами"
    t[248571] = "Шнур вартового духів"
    t[248572] = "Перев'язь вартового духів"
    t[248573] = "Затяжка вартового духів"
    t[248574] = "Поясний захист вартового духів"
    t[248575] = "Шаль крадькуна"
    t[248576] = "Тканина крадькуна"
    t[248577] = "Перстень сумніву"
    t[248578] = "Перстень нетерпіння"
    t[248579] = "Мантія присяги Атал-варти"
    t[248580] = "Наплічні накладки присяги Атал-варти"
    t[248581] = "Наплічний захист присяги Атал-варти"
    t[248582] = "Наплічники присяги Атал-варти"
    t[248583] = "Барабан Оновлених Уз"
    t[248592] = { name = "B1P, Спопеляч Душ", fen = "Summons B1P, Scorcher of Souls. Created by players with the Engineering skill. Can be bought and sold on the Auction House.", fua = "Прикликає Б1П, Спопелителя душ. Створюється гравцями з навичкою інженерії. Можна купувати й продавати на аукціоні." }
    t[248593] = { name = "Новонароджений клинок", fen = "The blade churns with conflicting energy--the spark of Light trembling against the torrent of Void. Its chaos emanates bloodlust.", fua = "Клинок вирує суперечливою енергією — іскра Світла тремтить проти потоку Порожнечі. Його хаос випромінює жагу крові." }
    t[248608] = { name = "Повідомлення клану Чорноскали", fen = "Nagosh, it's time we teach the lesser races to fear the Dark Horde once more. Have your forces ready to strike Redridge by the end of the month. Warlord Grazla", fua = "Наґош, час знову навчити нижчі раси боятися Темної Орди. Хай твої сили будуть готові вдарити по Редріджу до кінця місяця. Воєначальниця Ґразла" }
    t[248610] = { name = "Повідомлення клану Чорноскали", fen = "83 days since anyone fell in the lava. Keep it that way!", fua = "83 дні відтоді, як хтось останнього разу впав у лаву. Так тримати!" }
    t[248611] = { name = "Повідомлення клану Чорноскали", fen = "We have a big operation coming up soon! If I'm not yelling orders at you, and you aren't bleeding, you should always be training. Stop reading and get to it! - Nagosh", fua = "Скоро на нас чекає велика операція! Якщо я не горлаю на тебе накази, а ти не спливаєш кров'ю — маєш тренуватися. Годі читати, берися до діла! — Наґош" }
    t[248612] = { name = "Повідомлення клану Чорноскали", fen = "I've heard some of you are mad you didn't get a badge. If anyone thinks I was wrong, challenge me directly. Win, you get a badge. Lose and you won't have any more complaints. -Nagosh", fua = "Я чув, дехто з вас злий, що не отримав значка. Якщо хтось вважає, що я помилявся, киньте мені виклик особисто. Переможете — отримаєте значок. Програєте — і скарг у вас більше не буде. — Наґош" }
    t[248614] = { name = "Артефакт кель'дореїв", fen = "An arcane relic used by Magisters to amplify long-distance communication and scrying.", fua = "Арканна реліквія, якою магістри користуються, щоб посилювати зв'язок і ясновидіння на великій відстані." }
    t[248615] = { name = "Схованка інфільтратора", fen = "A heavy, rune-etched chest secured by two intricate locks. Contains valuable stolen documents.", fua = "Важка скриня з вирізьбленими рунами, замкнена двома вигадливими замками. Містить цінні викрадені документи." }
    t[248659] = { name = "Скарби Ґроффи", fen = "A bag of treasures gifted from a shadowy source.", fua = "Торба скарбів, подарована з тіньового джерела." }
    t[248680] = { name = "Нестабільний зосереджувальний кристал", fen = "An unstable void crystal that could be used as a lens for as long as it lasts.", fua = "Нестабільний кристал Порожнечі, який можна використовувати як лінзу, поки він тримається." }
    t[248715] = { name = "Кістки Полеглих", fen = "Bones of dem lost to de Vilebranch. Carry dem with honor.", fua = "Кістки тих, кого забрали Лихогіллі. Несіть їх із честю." }
    t[248720] = { name = "Викрадені документи", fen = "A bundle of neatly bound scrolls containing stolen intelligence on elven defenses, magical relay points, and the names of key personnel in Silvermoon.", fua = "Зв'язка акуратно перев'язаних сувоїв із вкраденими відомостями про оборону ельфів, магічні ретрансляційні точки та імена ключових осіб у Сільвермуні." }
    t[248722] = { name = "Чай із примарної квітки", fen = "Fragrant and bitter. Motes of void drift from the spout.", fua = "Запашний і гіркий. З носика чайника здіймаються часточки Порожнечі." }
    t[248723] = { name = "Викрадені документи", fen = "A bundle of neatly bound scrolls containing stolen intelligence on elven defenses, magical relay points, and the names of key personnel in Silvermoon.", fua = "Зв'язка акуратно перев'язаних сувоїв із вкраденими відомостями про оборону ельфів, магічні ретрансляційні точки та імена ключових осіб у Сільвермуні." }
    t[248724] = "Приціл розвідника"
    t[248756] = { name = "Дарунок Шадри", fen = "Shadra shared with us de poison of her children. It will help against de Vilebranch.", fua = "Шадра поділилася з нами отрутою своїх дітей. Вона стане в пригоді проти Лихогіллих." }
    t[248814] = { name = "Припаси Візербарків", fen = "Dis be what ya needin' to get de job done.", fua = "Це те, що тобі треба, аби зробити справу." }
    t[248826] = { name = "Бочок трайгора", fen = "Robust earthy flavor, slightly sweet, and deeply savory.", fua = "Насичений землистий смак, ледь солодкий і глибоко пряний." }
    t[248905] = { name = "Мерзосало Порожнечі", fen = "A substance you didn't even know existed!", fua = "Речовина, про існування якої ти навіть не здогадувався!" }
    t[248920] = { name = "Маска Нічної варти", fen = "What are you hiding?", fua = "Що ти приховуєш?" }
    t[248927] = { name = "Плавець штормового ската", fen = "A secret flavor only the daring can appreciate.", fua = "Таємний смак, який оцінять лише найсміливіші." }
    t[248928] = { name = "Накази культу", fen = "Worn parchment, faintly stained with wax and blood.", fua = "Потертий пергамент, ледь заплямований воском і кров'ю." }
    t[248929] = { name = "Перекусний пакунок доманаарів", fen = "\"Snack pack\" sounded better than \"mystery bag of dried bits.\"", fua = "«Перекусний пакунок» звучало краще, ніж «таємний мішок сушених шматочків»." }
    t[248931] = { name = "Потьмяніла монета Лихогіллі", fen = "Dis be a worthless thing, but at one time dey held great value.", fua = "Тепер ця штука нічого не варта, та колись ці монети мали велику ціну." }
    t[248944] = { name = "Ефірна енергія", fen = "Obtained by opening objects with an Ethereal Tool. Can be exchanged for consumables at the Shenzar Refinery in Slayer's Rise.", fua = "Здобувається відкриванням об'єктів ефірним інструментом. Можна обміняти на витратні матеріали на Шензарській переробні на Височині Вбивць." }
    t[248957] = "Сувій опору"
    t[248966] = "Сувій плинності"
    t[248967] = "Сувій стихій"
    t[248968] = "Сувій могутності"
    t[249005] = { name = "Фокус Роніна", fen = "Focus of the great Archmage Rhonin Redhair.", fua = "Фокус великого верховного мага Роніна Рудоволосого." }
    t[249219] = "12.0 Delves - Season 1 - Curio - Combat 1"
    t[249220] = "Накидка зірок"
    t[249221] = "Едикт санктуму"
    t[249222] = "Ентропійний кріс Нечестя"
    t[249223] = "12.0 Delves - Season 1 - Curio - Combat 5"
    t[249224] = "Непорушна Нуль-хвиля"
    t[249225] = "Мандат священної смерті"
    t[249226] = "Чорна Корона Поневолення"
    t[249227] = "12.0 Delves - Season 1 - Curio - Utility 4"
    t[249228] = "12.0 Delves - Season 1 - Curio - Utility 5"
    t[249231] = { name = "Орлине Перо", fen = "Perfectly suited for an Amani headdress... you hope.", fua = "Чудово підходить для головного убору амані... сподіваєшся." }
    t[249236] = { name = "Головний убір амані", fen = "You did your best to mimic the Amani style.", fua = "Ви зробили все можливе, щоб відтворити стиль амані." }
    t[249271] = { name = "Намисто із зубів трешадона", fen = "Only the strongest gnarldin have a necklace such as this.", fua = "Лише найсильніші корчедіни мають таке намисто." }
    t[249272] = { name = "Розкидані припаси", fen = "Slightly roughed up, but still usable.", fua = "Трохи пошарпані, але ще придатні." }
    t[249275] = { name = "Бастіон шляхетної рішучості", fen = "\"The only nobility is the destruction.\" - Imperator Averzian", fua = "«Єдина шляхетність — це руйнування.» — імператор Аверзіан" }
    t[249276] = { name = "Гримуар Вічного Світла", fen = "Full of the Light's wisdom, but an inattentive adherent may wander into mouths better left unexplored.", fua = "Сповнений мудрості Світла, та неуважний прихильник може забрести у пащі, які краще лишити недослідженими." }
    t[249277] = "Останній присуд Беламі"
    t[249278] = "Альном знехтуваний шпиль"
    t[249279] = "Рушниця сонячного удару"
    t[249280] = { name = "Оздоблений Сонцеглеф", fen = "The light of the sun and the fires of vengeance all burn the same.", fua = "Світло сонця й вогонь помсти палають однаково." }
    t[249281] = "Клинок останніх сутінків"
    t[249283] = "Бело'мелорн, Розтрощений Пазур"
    t[249284] = { name = "Спритний Пазур Бело'рена", fen = "A flash of fire, a shadow falls. Few things move faster.", fua = "Спалах вогню, падіння тіні. Мало що рухається швидше." }
    t[249286] = "Жаровня Дисонансного Плачу"
    t[249287] = "Пестощі побратимів виводку"
    t[249288] = "Смертоносний рекурсивний лук рейнджер-капітана"
    t[249293] = "Тягар командування"
    t[249294] = { name = "Клинок сліпого вироку", fen = "\"The Light's flame spares no one.\" - Venel Lightblood", fua = "«Полум'я Світла не щадить нікого.» — Венел Лайтблад" }
    t[249295] = "Фальшиве відлуння Тураліона"
    t[249296] = "Алаг'ендал, Світанкова Пісня"
    t[249298] = "Лезисті кулаки Мучителя"
    t[249302] = { name = "Невідворотний засяг", fen = "No prey can run fast enough.", fua = "Жодна здобич не втече досить швидко." }
    t[249303] = { name = "Поясний шнур Засуджених", fen = "You have been found... deserving.", fua = "Тебе визнано... гідним." }
    t[249304] = "Манжети полеглого короля"
    t[249305] = "Капці Опівнічного Полум'я"
    t[249306] = "Лик пожирущої ночі"
    t[249307] = "Хвати Народженого з Жару"
    t[249308] = "Деспотичне вбрання"
    t[249309] = "Сонцезв'язний нагрудник"
    t[249310] = "Шати скутого Порожнечею"
    t[249311] = "Поножі Лайтбладі"
    t[249312] = "Штани Нічного Клинка"
    t[249313] = "Наплічники, суджені Світлом"
    t[249314] = "Спотворений сутінковий пояс"
    t[249315] = "Ненаситні наручні пов'язки"
    t[249316] = { name = "Корона розбитого тирана", fen = "A crown without a kingdom.", fua = "Корона без королівства." }
    t[249317] = "Докір шаленства"
    t[249318] = "Жахливі еполети нуль-блукача"
    t[249319] = "Пояс нескінченного маршу"
    t[249320] = "Сабатони затемнення"
    t[249321] = "Жахливий захват Вейлгора"
    t[249322] = "Куртка сяйливого доглядача кладки"
    t[249323] = "Легінси Ненажерливого Наступу"
    t[249324] = "Лускаті захисники вічного полум'я"
    t[249325] = { name = "Розкуті захвати берсеркерки", fen = "The one place she could let go was in battle. At least before.", fua = "Єдине місце, де вона могла дати собі волю, був бій. Принаймні раніше." }
    t[249326] = "Наручі Маршу Світла"
    t[249327] = "Наручі, оббіловані Порожнечею"
    t[249328] = "Лунка Мантія Порожнечі"
    t[249329] = "Погляд нестримної"
    t[249330] = "Рукавиці воєнної капеланки"
    t[249331] = "Морокопута Еззорака"
    t[249332] = "Чоботи проти паразитів"
    t[249333] = "Квітучі наплічники зі світлокори"
    t[249334] = "Гомілкобійці, привласнені Порожнечею"
    t[249335] = "Стяг імператора"
    t[249336] = "Перстень зголоднілого звіра"
    t[249337] = "Стрічка звивистої злоби"
    t[249339] = "Заплямований мороком жахолуск"
    t[249340] = { name = "Обмотки космічного божевілля", fen = "Is it mad to sacrifice your world for victory?", fua = "Чи божевільно жертвувати своїм світом заради перемоги?" }
    t[249341] = "Нестабільний насичувач Порожнечі"
    t[249342] = "Серце Прадавнього Голоду"
    t[249343] = { name = "Погляд провидця Альну", fen = "There are some places the faithful dare not look.", fua = "Є місця, куди вірні не наважуються зазирати." }
    t[249344] = { name = "Прапорець Роти Світла", fen = "Forward, the Vanguard of the Light!", fua = "Уперед, авангарде Світла!" }
    t[249345] = "Райдужний знак рейнджер-капітана"
    t[249346] = "Останній погляд Вейлгора"
    t[249347] = "Альнотканий розломоцвіт"
    t[249348] = "Альновитриманий розломоцвіт"
    t[249349] = "Альнолитий розломоцвіт"
    t[249350] = "Альнокований розломоцвіт"
    t[249351] = "Голодне нуль-ядро, виткане з Порожнечі"
    t[249352] = "Загартоване Порожнечею голодне нуль-ядро"
    t[249353] = "Зіткане Порожнечею голодне нуль-ядро"
    t[249354] = "Коване в Порожнечі голодне нуль-ядро"
    t[249355] = "Фанатичне нуль-ядро, виткане з Порожнечі"
    t[249356] = "Загартоване Порожнечею фанатичне нуль-ядро"
    t[249357] = "Зіткане Порожнечею фанатичне нуль-ядро"
    t[249358] = "Коване в Порожнечі фанатичне нуль-ядро"
    t[249359] = "Зіпсоване нуль-ядро, виткане з Порожнечі"
    t[249360] = "Загартоване Порожнечею зіпсуте нуль-ядро"
    t[249361] = "Зіткане Порожнечею зіпсуте нуль-ядро"
    t[249362] = "Коване в Порожнечі зіпсуте нуль-ядро"
    t[249363] = "Розпале нуль-ядро, виткане з Порожнечі"
    t[249364] = "Загартоване Порожнечею розпадне нуль-ядро"
    t[249365] = "Зіткане Порожнечею розпадне нуль-ядро"
    t[249366] = "Коване в Порожнечі розпадне нуль-ядро"
    t[249367] = { name = "Дзвінкий курйоз Порожнечі", fen = "Find Kirana near the entrance to the March on Quel'Danas to trade this for powerful class set armor.", fua = "Знайди Кірану біля входу до Маршу на Кель'Данас, щоб обміняти це на потужну броню класового набору." }
    t[249368] = "Вічний ланцюг Пісні Порожнечі"
    t[249369] = "Узи Світла"
    t[249370] = "Драконячий нуль-плащ"
    t[249371] = "Пояс згуби зневаги"
    t[249373] = "Обпалені Сном Поножі"
    t[249374] = "Пояс Шул'ки, посіченого зневагою"
    t[249376] = "Перев'яз, списаний шепотом"
    t[249377] = "Чоботи темноходи"
    t[249380] = "Поясний ланцюг, скутий ненавистю"
    t[249381] = "Поножі Безформних"
    t[249382] = { name = "Онучі ходака по кронах", fen = "For feet that need never touch the earth.", fua = "Для ніг, яким ніколи не треба торкатися землі." }
    t[249387] = { name = "Прихований тінещеп", fen = "A metal used by the domanaar to enforce control over others.", fua = "Метал, який доманаари використовують, щоб установлювати владу над іншими." }
    t[249402] = { name = "Шип Геллебори", fen = "Harvested from the serrated jaws of the hydra Hellebora, the edge of this thorn is wickedly sharp and difficult to handle.", fua = "Здобутий із зазубрених щелеп гідри Геллебори, край цього шипа надзвичайно гострий і важко піддається обробці." }
    t[249403] = { name = "Пелюстки Жаботіні", fen = "A collection of large olive-green petals, gathered from the hydra Toadshade.", fua = "Жмут великих оливково-зелених пелюсток, зібраних із гідри Жаботінь." }
    t[249404] = { name = "Душлива лоза", fen = "This coil of thick vines harvested from Muckmire writhes in your grasp, attempting to squeeze whatever it can.", fua = "Цей жмут товстої лози, зібраний у Багнотвані, звивається у твоїй руці, намагаючись здушити все, до чого дотягнеться." }
    t[249405] = { name = "Люмінесцентні стебла", fen = "Long rubbery stalks with a bioluminescent orb at their apex.", fua = "Довгі гумоподібні стебла з біолюмінесцентною кулею на верхівці." }
    t[249406] = { name = "Клешні Кривавошипа", fen = "A set of sharp, curving pincers, harvested from Gorebarb.", fua = "Набір гострих, вигнутих клешень, здобутих із Кривавошипа." }
    t[249407] = { name = "Зрубане світлодерево", fen = "The cut wood feels comfortably warm to the touch and seems to emit the faintest glow from the inside grain.", fua = "Зрізане дерево приємно тепле на дотик і ніби випромінює ледь помітне сяйво зсередини волокон." }
    t[249408] = { name = "Терноікла Діонеї", fen = "A set of wickedly sharp tusks, harvested from the thornmaw Dionaea.", fua = "Набір диявольськи гострих іклів, здобутих із тернопащі Діонеї." }
    t[249411] = { name = "Сутінкові жетони", fen = "The Twilight Hammer has no further use for this.", fua = "Сутінковому Молоту це більше не потрібне." }
    t[249412] = { name = "Смердючий лівий черевик", fen = "We could look into weaponizing this stench.", fua = "Можна було б спробувати зробити зброю з цього смороду." }
    t[249413] = { name = "Колись улюблена сережка", fen = "There's barely any ear still attached.", fua = "Вуха при ній майже не лишилося." }
    t[249414] = { name = "Щоденник почуттів", fen = "Some days, me do not think leader appreciate how big me stomp or how hard me smash. Why me bother?", fua = "Деколи мене думати, що ватажок не цінувати, як сильно мене топтати чи як міцно мене трощити. Нащо мене старатися?" }
    t[249415] = { name = "Сувій загибелі Трока", fen = "Almost as doom-filled as Borvin's Scroll of Doom.", fua = "Майже такий згубний, як Сувій загибелі Борвіна." }
    t[249416] = { name = "Надкушений пайок", fen = "You can just brush the bugs off, if you're really hungry.", fua = "Якщо ти справді голодний, комах можна просто струсити." }
    t[249418] = { name = "Світлоквітуча цибулина", fen = "Deceptively gentle glowing bulb. The botanist's test of nature versus nurture.", fua = "Оманливо лагідна сяйлива цибулина. Ботанічна перевірка природи проти виховання." }
    t[249421] = { name = "Манапідсилений витриманий напій", fen = "An extremely expensive reserve bottled during the early years of Anasterian's reign.", fua = "Надзвичайно дороге вино, розлите в перші роки правління Анастеріана." }
    t[249422] = { name = "Сонцешовк", fen = "Used to create exquisite silk threads, with just a hint of warmth.", fua = "Використовується для створення вишуканих шовкових ниток з ледь відчутним теплом." }
    t[249433] = "Скалка Порожнечі"
    t[249437] = { name = "Жезл зменшених пропорцій", fen = "Ironically, the wand is actually quite large.", fua = "За іронією, сам жезл насправді чималий." }
    t[249439] = { name = "Яскраве Перо", fen = "The vivid hue of the hawkstrider feather makes a lovely adornment.", fua = "Соковитий відтінок пера яструбоступа робить його гарною оздобою." }
    t[249440] = { name = "Яскраве Перо", fen = "The vivid hue of the hawkstrider feather makes a lovely adornment.", fua = "Соковитий відтінок пера яструбоступа робить його гарною оздобою." }
    t[249444] = { name = "Вогнепелюстка Вічної Пісні", fen = "The delicate petals disintegrate at the barest touch, becoming a fine powder that glitters with vibrant amber light.", fua = "Тендітні пелюстки розсипаються від найлегшого дотику, обертаючись на дрібний порох, що мерехтить яскравим бурштиновим світлом." }
    t[249445] = { name = "Сувій Тканини з Манашовку", fen = "Shimmers with magical iridescence. This would make a stunning set of robes.", fua = "Мерехтить магічним переливом. З цього вийшла б приголомшлива мантія." }
    t[249452] = { name = "Неживий віник", fen = "Empty of magic, but ready to be enchanted once more.", fua = "Позбавлений магії, та готовий, щоб його зачарували знову." }
    t[249472] = { name = "Запашний кривавий будяк", fen = "A potent delicacy among the sin'dorei.", fua = "Сильнодійний делікатес серед сін'дорей." }
    t[249490] = { name = "Таємничий цвіт", fen = "Holding it conjures the sensation of cool mist on a summer morning.", fua = "Коли тримаєш його, охоплює відчуття прохолодного туману літнього ранку." }
    t[249491] = { name = "Таємничий цвіт", fen = "Holding it conjures the image of dewdrops on the first flowers of spring.", fua = "Тримаючи її, уявляєш краплі роси на перших весняних квітах." }
    t[249492] = { name = "Таємничий цвіт", fen = "Holding it conjures the feeling of autumn light filtering through golden trees.", fua = "Тримаючи її, відчуваєш осіннє світло, що сочиться крізь золоті дерева." }
    t[249497] = { name = "Перець Примарних земель", fen = "Peppers so hot that the Sunwell blocks their entry.", fua = "Перці такі гострі, що Сонячний Колодязь не пускає їх до себе." }
    t[249498] = { name = "Викрадені припаси", fen = "Supplies stolen from unfortunate travelers passing through the marsh.", fua = "Припаси, вкрадені в нещасних мандрівників, що проходили крізь болото." }
    t[249499] = { name = "Ятаган наги", fen = "Dark, deadly, and sandy.", fua = "Темний, смертоносний і запорошений піском." }
    t[249517] = { name = "Контрабандні товари", fen = "Filled to the brim with silks, spices, and gems from overseas.", fua = "Напхані по вінця шовками, прянощами й самоцвітами із заморських країв." }
    t[249527] = { name = "Картина Старійшини", fen = "Did he just look at me? No, that must be a trick of the light.", fua = "Він щойно глянув на мене? Ні, це, певно, гра світла." }
    t[249528] = { name = "Сутінкова зброя", fen = "A fantastic conversation starter to hang on the wall of a noble's parlor.", fua = "Чудовий привід для розмови, щоб повісити на стіну в покоях шляхтича." }
    t[249531] = { name = "Таємничий кубик", fen = "Turn the edges. Upward, upward, downward, downward, west, east, west, east, bala, anu.", fua = "Крути грані. Угору, угору, униз, униз, захід, схід, захід, схід, бала, ану." }
    t[249540] = { name = "Дивно запечатана книга", fen = "The essence of the sin'dorei must be shared for this tome to open.", fua = "Щоб ця книга відкрилася, треба поділитися есенцією сін'дорей." }
    t[249541] = { name = "Ікло наги", fen = "As massive as it is sharp, this could easily be made into a weapon. Or dice.", fua = "Таке ж масивне, як і гостре, з нього легко вийшла б зброя. Або гральні кості." }
    t[249542] = { name = "Частково використаний сувенір", fen = "Two fingers down.", fua = "Два пальці донизу." }
    t[249543] = { name = "Особливі ліки", fen = "Do not distribute after midnight.", fua = "Не роздавати після опівночі." }
    t[249544] = { name = "Скриня крадених цінностей", fen = "Bears the crest of a minor noble house in Eversong.", fua = "Має герб дрібного шляхетного дому з Лісу Вічної Пісні." }
    t[249552] = { name = "Пустотлива маска", fen = "Wear with caution. Willpower denies.", fua = "Носи обережно. Сила волі заперечує." }
    t[249553] = { name = "Загублене дзеркало", fen = "The voice inside is faint. The whispers draw you closer.", fua = "Голос усередині ледь чутний. Шепоти ваблять тебе ближче." }
    t[249554] = { name = "Мінливий годинник", fen = "When will then be then again?", fua = "Коли тоді знову настане тоді?" }
    t[249555] = { name = "Бренді з кривавого будяку", fen = "Incredibly sweet, but balanced by subtle floral notes.", fua = "Неймовірно солодке, та врівноважене тонкими квітковими нотами." }
    t[249556] = { name = "Манапал", fen = "Popular in the Row, where tapsters swear it actually drains your mana. Sure does feel like it. Tasty, though.", fua = "Популярний у Завулку, де шинкарі присягаються, що він і справді висмоктує ману. На відчуття так і є. Та зате смачний." }
    t[249557] = { name = "Сонцем цілована транквілла", fen = "Aged for its final year in Eversong sunlight, imparting a bold, caramelized taste.", fua = "Останній рік визрівала під сонцем Лісу Вічної Пісні, що надало їй насиченого, карамельного смаку." }
    t[249610] = "Смолистий квітоклинок"
    t[249619] = "Розлогий мікопокрив"
    t[249620] = "Барвисте дикокільце"
    t[249621] = "Перстень вуду"
    t[249622] = "Перстень печатки духів"
    t[249623] = "Квітучий листяний звій"
    t[249624] = "Кісткокута бліда мантія"
    t[249625] = "Старе Мохове Покривало"
    t[249626] = "Нічний терновий амулет"
    t[249627] = "Нашийник з деревної лози"
    t[249628] = "Плащ буйного тернику"
    t[249629] = "Розлога коренева туніка"
    t[249630] = "Розлогі кореневі наколінники"
    t[249631] = "Розлогі вусики"
    t[249632] = "Розлогий кореневий комір"
    t[249633] = "Розлогі кореневі панчохи"
    t[249634] = "Розлогі волокнисті шкаралупи"
    t[249635] = "Розлогий ризомний шнур"
    t[249636] = "Розлогі наручні корені"
    t[249637] = "Кісткокута мозкова жилетка"
    t[249638] = "Кісткокуті ногодробильники"
    t[249639] = "Кісткокуті хребтохапи"
    t[249640] = "Кісткокуті шаблезуби"
    t[249641] = "Кісткокуті кісткоступи"
    t[249642] = "Кісткокуті лезонаплічники"
    t[249643] = "Кісткокутий кістяний пояс"
    t[249644] = "Кісткокуті кістяні наручі"
    t[249645] = "Стара Мохова Кольчуга"
    t[249646] = "Старі Мохові Черевики"
    t[249647] = "Старі Мохові Вусики"
    t[249648] = "Старі Мохові Роги"
    t[249649] = "Старі Штани з Моховими Прожилками"
    t[249650] = "Старі Великолисти з Моховими Прожилками"
    t[249651] = "Старий Моховий Пояс"
    t[249652] = "Старі Мохові Наручі"
    t[249653] = "Лати буйного тернику"
    t[249654] = "Тупотуни буйного будяка"
    t[249655] = "Буйні повзучі лози"
    t[249656] = "Шолом буйного тернику"
    t[249657] = "Поножі буйного тернику"
    t[249658] = "Накидка буйних колючок"
    t[249659] = "Ремінь буйних колючок"
    t[249660] = "Манжети буйного тернику"
    t[249661] = "Зелена сокира різьбяра коренів"
    t[249662] = "Дикий волоконний ніж"
    t[249664] = "Вузлувата тернобулава"
    t[249665] = "Квітуча насіннєва коробочка"
    t[249667] = "Колюча кореняста чарівна паличка"
    t[249669] = "Терновий спис нутрощопроколювача"
    t[249670] = "Шпиль Прадавнього Кореня"
    t[249671] = "Хребтокол Вузлокореня"
    t[249672] = "Ліхтар Бузинового Цвіту"
    t[249676] = "Тернова Барикада"
    t[249677] = "Дикоглефа Двотерну"
    t[249686] = "Дублон Хвилерідних"
    t[249687] = { name = "Виділення отруйної жаби", fen = "Sticky and acrid-smelling, this potent toxin could easily be smeared on a weapon or inconspicuous surface.", fua = "Липка й з різким запахом, ця потужна отрута легко наноситься на зброю чи непримітну поверхню." }
    t[249688] = { name = "Репліка Фело'мелорна", fen = "Surprisingly well made, though a bit small. A fiery enchantment hums along the purposefully-dulled edge.", fua = "Напрочуд добре зроблена, хоч і трохи замала. Уздовж навмисно затупленого леза гуде вогняне закляття." }
    t[249689] = { name = "Чай із примарної квітки з сонячним плодом", fen = "The bitter medicine of Ghostflowers tempered with the sweetness of Eversong's Sunfruit.", fua = "Гірке зілля з примарних квіток, пом'якшене солодкістю сонячного плоду Лісу Вічної Пісні." }
    t[249691] = { name = "Святий сонячний вогонь", fen = "Handle with care.", fua = "Поводитися обережно." }
    t[249724] = { name = "Скибка сонячного плоду", fen = "Sweet and acidic.", fua = "Солодка й кислувата." }
    t[249732] = { name = "Золотий виноградарів", fen = "A dry wine with an effervescent twist.", fua = "Сухе вино з грайливими бульбашками." }
    t[249775] = { name = "Яскрава Ягода", fen = "A high value treat for baby dragonhawks.", fua = "Ласощі великої цінності для драконояструбенят." }
    t[249779] = { name = "Розладнана мелодія", fen = "A tune to turn the tide. Does not work on the disoriented.", fua = "Мелодія, що змінює перебіг подій. Не діє на знетямлених." }
    t[249805] = { name = "Сочлива реліквія Несненого Бога", fen = "The ooze never seems to stop.", fua = "Слиз, здається, ніколи не спиняється." }
    t[249806] = "Сяйлива пір'їна"
    t[249807] = "Вічне яйце"
    t[249808] = { name = "Літанія засліпленого Світлом гніву", fen = "Are you with the Light?", fua = "Ти зі Світлом?" }
    t[249809] = { name = "Стрічка Локус-Вокера", fen = "\"Do you wish to learn more of the Void? It has many lessons to teach us amongst its maddening whispers.\" - Locus-Walker", fua = "\"Бажаєш дізнатися більше про Порожнечу? Вона має чимало уроків для нас серед своїх божевільних шепотів.\" - Локус-Вокер" }
    t[249810] = "Тінь небесного реквієму"
    t[249811] = { name = "Світло Космічного Крещендо", fen = "There was a time when her song filled hearts with hope.", fua = "Був час, коли її пісня сповнювала серця надією." }
    t[249912] = "Шати безкінечного забуття"
    t[249913] = "Маска найтемнішого наміру"
    t[249914] = "Каптур забуття"
    t[249915] = { name = "Поножі вимирання", fen = "Someone has to be the last one standing.", fua = "Хтось мусить лишитися останнім." }
    t[249919] = "Перстень надії сін'дорей"
    t[249920] = "Око Опівночі"
    t[249921] = "Таласська світанкова варта"
    t[249922] = { name = "Фоліант жалю знехтуваних Альном", fen = "Are you certain you wish to understand the Alnscorned? To make their pain your own?", fua = "Чи певен ти, що бажаєш зрозуміти знехтуваних Альном? Зробити їхній біль своїм власним?" }
    t[249925] = "Зголодніла перемога"
    t[249947] = "Велика накидка Згубителя Ночі"
    t[249948] = "Бойові наручі Згубителя Ночі"
    t[249949] = "Пояс Згубителя Ночі"
    t[249950] = "Наплічники Згубителя Ночі"
    t[249951] = "Поножі Згубителя Ночі"
    t[249952] = "Ікла Згубителя Ночі"
    t[249953] = "Кулаки Згубителя Ночі"
    t[249954] = "Великі чоботи Згубителя Ночі"
    t[249955] = "Нагрудник Згубителя Ночі"
    t[249956] = "Велика мантія Осяйного Вироку"
    t[249957] = "Манжети Осяйного Вироку"
    t[249958] = "Незламний герб Осяйного Вироку"
    t[249959] = "Провидницький страж Осяйного Вироку"
    t[249960] = "Поножі Осяйного Вироку"
    t[249961] = "Непохитний погляд Осяйного Вироку"
    t[249962] = "Латні рукавиці Осяйного Вироку"
    t[249963] = "Сабатони Осяйного Вироку"
    t[249964] = "Божественний бойовий панцир Осяйного Вироку"
    t[249965] = "Плащ невблаганного вершника"
    t[249966] = "Окови нещадного вершника"
    t[249967] = "Кольчуга невблаганного вершника"
    t[249968] = "Жахошипи невблаганного вершника"
    t[249969] = "Поножі невблаганного вершника"
    t[249970] = "Корона невблаганного вершника"
    t[249971] = "Кістяні рукавиці невблаганного вершника"
    t[249972] = "Чоботи нещадного вершника"
    t[249973] = "Кіраса невблаганного вершника"
    t[249974] = "Страж Первинного Ядра"
    t[249975] = "Манжети первісного ядра"
    t[249976] = "Пояс первісного ядра"
    t[249977] = "Бурі первинного ядра"
    t[249978] = "Легінси Первинного Ядра"
    t[249979] = "Осереддя первинного ядра"
    t[249980] = "Земнохвати Первісного Ядра"
    t[249981] = "Сабатони первинного ядра"
    t[249982] = "Обійми Первісного Ядра"
    t[249983] = "Хребет первісного Вартового"
    t[249984] = "Кровоспини первісного Вартового"
    t[249985] = "Затяжка первісного Вартового"
    t[249986] = "Трофеї первісного Вартового"
    t[249987] = "Поножі первісного Вартового"
    t[249988] = "Паща первісного Вартового"
    t[249989] = "Кігтезахисники первісного Вартового"
    t[249990] = "Прудкоступи первісного Вартового"
    t[249991] = "Лускатий обладунок первісного Вартового"
    t[249992] = "Покрив Чорного Пазура"
    t[249993] = "Наручі Чорного Пазура"
    t[249994] = "Пояс Чорного Пазура"
    t[249995] = "Маяки Чорного Пазура"
    t[249996] = "Поножі Чорного Пазура"
    t[249997] = "Рогатий шолом Чорного Пазура"
    t[249998] = "Хватки наглядача Чорного Пазура"
    t[249999] = "Чарокроки Чорного Пазура"
    t[250000] = "Оберіг від шаленства Чорного Пазура"
    t[250001] = "Зникома тканина похмурого жарту"
    t[250002] = "Каверзні наручі Похмурого жарту"
    t[250003] = "Пояс з інструментами Похмурого жарту"
    t[250004] = "Отруйні барила Похмурого Жарту"
    t[250005] = "Піхви для клинків Похмурого Жарту"
    t[250006] = "Маскарад похмурого жарту"
    t[250007] = "Спритність рук Похмурого Жарту"
    t[250008] = "Зрівноважувальні чоботи Похмурого Жарту"
    t[250009] = "Дивовижне вбрання Похмурого Жарту"
    t[250010] = "Вітровій Обранця Ра-дена"
    t[250011] = "Ударні щитки Обранця Ра-дена"
    t[250012] = "Штормовий знак Обранця Ра-дена"
    t[250013] = "Аурокамені Обранця Ра-дена"
    t[250014] = "Прудкоступи Обранця Ра-дена"
    t[250015] = "Жахливий лик Обранця Ра-дена"
    t[250016] = "Громокулаки Обранця Ра-дена"
    t[250017] = "Громотрощії Обранця Ра-дена"
    t[250018] = "Бойове вбрання Обранця Ра-дена"
    t[250019] = "Листяна накидка Сяйливого Цвіту"
    t[250020] = "Пов'язки Осяйного Цвіту"
    t[250021] = "Кірний пояс Осяйного Цвіту"
    t[250022] = "Насіннєві коробочки осяйного цвіту"
    t[250023] = "Флоемні обмотки осяйного цвіту"
    t[250024] = "Гілки Осяйного Цвіту"
    t[250025] = "Доглядачі дерев Осяйного Цвіту"
    t[250026] = "Кореневі капці осяйного цвіту"
    t[250027] = "Стовбур осяйного цвіту"
    t[250028] = "Накидка пожирущого хапуна"
    t[250029] = "Опорні ремені пожирущого хапуна"
    t[250030] = "Емблема пожирущого хапуна"
    t[250031] = "Випускні пластини пожирущого хапуна"
    t[250032] = "Поршні пожирущого хапуна"
    t[250033] = "Забірник пожирущого хапуна"
    t[250034] = "Руків'я есенції пожирущого хапуна"
    t[250035] = "Душотопти пожирущого хапуна"
    t[250036] = "Двигун пожирущого хапуна"
    t[250037] = "Ритуальна мантія Спопелителя Безодні"
    t[250038] = "Кайдани Спопелителя Безодні"
    t[250039] = "Палаюче осердя Спопелителя Безодні"
    t[250040] = "Лють Спопелителя Безодні"
    t[250041] = "Стовпи Спопелителя Безодні"
    t[250042] = "Тліючі полум'я Спопелителя Безодні"
    t[250043] = "Захвати Спопелителя Безодні"
    t[250044] = "Попелоступи Спопелителя Безодні"
    t[250045] = "Роба жаху Спопелителя Безодні"
    t[250046] = "Покрив Сліпої Клятви"
    t[250047] = "Обмотки Сліпої Клятви"
    t[250048] = "Самоцвітний пояс Сліпої Клятви"
    t[250049] = "Серафимові наплічники Сліпої Клятви"
    t[250050] = "Поножі Сліпої Клятви"
    t[250051] = "Крилатий герб Сліпої Клятви"
    t[250052] = "Дотик Сліпої Клятви"
    t[250053] = "Капці Сліпої Клятви"
    t[250054] = "Убрання Сліпої Клятви"
    t[250055] = "Шифроплащ руйнівника Порожнечі"
    t[250056] = "Наручі руйнівника Порожнечі"
    t[250057] = "Шнур мудреця руйнівника Порожнечі"
    t[250058] = "Вузли лей-ліній руйнівника Порожнечі"
    t[250059] = "Штани руйнівника Порожнечі"
    t[250060] = "Серпанок Зламувача Порожнечі"
    t[250061] = "Рукавиці руйнівника Порожнечі"
    t[250062] = "Чоботи Зламувача Порожнечі"
    t[250063] = "Роба руйнівника Порожнечі"
    t[250096] = { name = "Наживка для червів", fen = "Local eggs mixed with Void magic. Irresistible to consumptors.", fua = "Місцеві яйця, змішані з магією Порожнечі. Нездоланна спокуса для пожирачів." }
    t[250116] = { name = "Сховок скарбів Кель'Таласу", fen = "Rewards a piece of Champion equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження чемпіона для вашої спеціалізації здобичі." }
    t[250117] = { name = "Сховок скарбів Кель'Таласу", fen = "Rewards a piece of Hero equipment for your Loot Specialization.", fua = "Дає предмет спорядження рівня «Герой» для твоєї спеціалізації здобичі." }
    t[250138] = { name = "Фіолетове пташеня", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[250142] = { name = "Блакитний спорокажан", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[250144] = "Перо Попелястокрила"
    t[250190] = { name = "Голова жриці ножа Геззії", fen = "This foul head reeks of blood and death.", fua = "Ця мерзенна голова смердить кров'ю та смертю." }
    t[250214] = { name = "Ядро Світлошпиля", fen = "Stand in the Light, and be made whole.", fua = "Стань у Світло й стань цілісним." }
    t[250215] = "Фляга вантажника"
    t[250223] = { name = "Талісман ловця душ", fen = "Vordaza's necromantic fetish is covered in inscrutable carvings and has a heavy, ominous aura.", fua = "Некромантський фетиш Вордази вкритий незбагненними різьбленнями і випромінює важку, лиховісну ауру." }
    t[250224] = "Сигіл розумопронизувача"
    t[250225] = "Мандат страти Порожнечі"
    t[250226] = "Кривий гак Засувки"
    t[250227] = "Бойовий стяг Кролука"
    t[250228] = "Лункий ревокамінь"
    t[250229] = "Ідол воєнного лоа"
    t[250238] = "Зерня пожираючих нетрів"
    t[250241] = "Знак Світла"
    t[250242] = "Реплікатор желе"
    t[250243] = "Зв'язувальне полум'я Манасерця"
    t[250244] = "Есенція вічної мерзлоти"
    t[250245] = "Пухлина рою"
    t[250246] = "Сфера дозаправлення"
    t[250247] = "Амулет Безодневого Гімну"
    t[250248] = { name = "Міколічні ліки", fen = "A draught from a species long lost everywhere but in dreams.", fua = "Зілля виду, що давно зник усюди, окрім снів." }
    t[250253] = "Шепіт сутінкового привида"
    t[250254] = "Зерня променистої надії"
    t[250255] = "Нестабільний кристал скверносердя"
    t[250256] = "Серце вітру"
    t[250257] = "Око Потопаючої Порожнечі"
    t[250258] = { name = "Посудина змучених душ", fen = "Don't tap the glass. They don't like that.", fua = "Не стукай по склу. Вони цього не люблять." }
    t[250259] = "Саджанець Світанкокореня"
    t[250317] = { name = "Купка попелу", fen = "All that's left of a wand.", fua = "Усе, що лишилося від чарівної палички." }
    t[250319] = { name = "Тінещеп Дослідника", fen = "Experimental shadowgraft meant for the brood of Predaxas.", fua = "Експериментальний тінещеп, призначений для виводка Предаксаса." }
    t[250320] = "Світлощеп"
    t[250352] = "Зношена торба з припасами"
    t[250355] = "Посох сутінкового підбурювача"
    t[250356] = "Довгий лук зрадливого слідопита"
    t[250360] = "Відлуння Рясності: Білування"
    t[250361] = "Виснажений перстень зі скалки Порожнечі"
    t[250440] = { name = "Вербувальні листівки", fen = "A call to arms for the Blood Knights, Magisters, and Farstriders!", fua = "Заклик до зброї для Лицарів крові, Магістрів та далекоходів!" }
    t[250443] = "Відлуння Рясності: Травництво"
    t[250444] = "Відлуння Рясності: Гірнича справа"
    t[250445] = "Відлуння Рясності: Накладання чарів"
    t[250446] = "Бастіон скелехранителя"
    t[250447] = "Сяйливий скіпетр Лісу Вічної Пісні"
    t[250448] = "Шпиль формувача Порожнечі"
    t[250449] = "Скрадливий кропив'яний кинджал"
    t[250450] = "Лютий довгий лук лісової вартової"
    t[250451] = "Звіросіч світанкового шаленства"
    t[250452] = "Квітуча Тернова Клинка"
    t[250453] = "Скіпетр незв'язаного Світла"
    t[250454] = "Душосік пожирущого авангарду"
    t[250455] = "Звірячий квітошип"
    t[250456] = "Позолочена мантія жалюгідного книжника"
    t[250457] = "Поножі пожирущого передового вершника"
    t[250458] = "Шолом командира воїнства"
    t[250459] = "Пернатий Каптур Тернового Слідопита"
    t[250460] = "Перстень-печатка навальної тіні"
    t[250461] = "Ланцюг давнього вартового"
    t[250462] = "Відзнака забутого далекохода"
    t[250465] = { name = "Тіньовий кристал", fen = "Explosive void condensed into crystalline form.", fua = "Вибухова порожнеча, згущена в кристалічну форму." }
    t[250470] = "Лук зачарованої крипти"
    t[250471] = "Бойовий посох зачарованої крипти"
    t[250472] = "Посох зачарованої крипти"
    t[250473] = "Клеймор зачарованої крипти"
    t[250474] = "Великий меч зачарованої крипти"
    t[250475] = "Меч зачарованої крипти"
    t[250476] = "Фальшіон зачарованої крипти"
    t[250477] = "Рубака зачарованої крипти"
    t[250478] = "Сокирка зачарованої крипти"
    t[250479] = "Сікач зачарованої крипти"
    t[250480] = "Заточка зачарованої крипти"
    t[250750] = { name = "Торбинка пророслих живців", fen = "Filled with herbs gathered during Abundance events.", fua = "Наповнена травами, зібраними під час подій Рясності." }
    t[250753] = { name = "Торба з тріснутими крихтами руди", fen = "Filled with ore gathered during Abundance events.", fua = "Наповнена рудою, зібраною під час подій Рясності." }
    t[250754] = { name = "Торба з дикою шкірою", fen = "Filled with leather and scales gathered during Abundance events.", fua = "Наповнена шкірою та лускою, зібраними під час подій Рясності." }
    t[250755] = { name = "Торбинка містичного помелу", fen = "Filled with enchanting materials gathered during Abundance events.", fua = "Наповнена матеріалами для чароплетства, зібраними під час подій Рясності." }
    t[250782] = { name = "Сонцепер амані", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[250799] = "Благословенний лоа плащ"
    t[250800] = "Благословенна лоа накидка"
    t[250801] = "Благословенні лоа наплічники"
    t[250807] = { name = "Штормаріонове ядро Селюни", fen = "An energized core charged with potent energy.", fua = "Заряджене ядро, повне потужної енергії." }
    t[250854] = { name = "Осередок сонця", fen = "The gentle warmth of the sun provides energy and growth.", fua = "Лагідне тепло сонця дарує енергію й ріст." }
    t[250855] = "Корона речника лоа"
    t[250863] = { name = "Налокі", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[250872] = { name = "Пошрамований спис", fen = "There might be somewhere to display this in the Arcantina.", fua = "Можливо, для нього знайдеться місце в Аркантині." }
    t[250873] = { name = "Чорний Стяг", fen = "There might be somewhere to display this in the Arcantina.", fua = "Можливо, для нього знайдеться місце в Аркантині." }
    t[250874] = { name = "Зіпсутий ліхтар", fen = "There might be somewhere to display this in the Arcantina.", fua = "Можливо, для нього знайдеться місце в Аркантині." }
    t[250875] = { name = "Давній зандаларський сувій", fen = "The ancient scroll is brittle. Upon it is a proclamation from Emperor Lei Shen directing the Zandalari to destroy the mortals outside, overrun Pandaria, and restore the glory of the empire. There might be somewhere to display this in the Arcantina.", fua = "Давній сувій крихкий. На ньому — проголошення імператора Лей Шеня, що велить зандаларі винищити смертних назовні, заполонити Пандарію та відродити славу імперії. Можливо, у Аркантині знайдеться місце, щоб виставити це напоказ." }
    t[250876] = { name = "Вічнозелена лоза", fen = "There might be somewhere to display this in the Arcantina.", fua = "Можливо, для нього знайдеться місце в Аркантині." }
    t[250877] = { name = "Уламок пілона", fen = "This shattered piece was a part of Tortheldrin's extensive pylon system used to contain the powerful demon Immol'thar. There might be somewhere to display this in the Arcantina.", fua = "Цей розбитий шматок був частиною розгалуженої системи пілонів Тортелдріна, що стримувала могутнього демона Іммол'тара. Можливо, у Арканіні знайдеться місце, щоб його виставити." }
    t[250878] = { name = "Вивітрений фоліант", fen = "There might be somewhere to display this in the Arcantina.", fua = "Можливо, для нього знайдеться місце в Аркантині." }
    t[250879] = { name = "Важкий якір", fen = "There might be somewhere to display this in the Arcantina.", fua = "Можливо, для нього знайдеться місце в Аркантині." }
    t[250880] = { name = "Піщаний гобелен", fen = "There might be somewhere to display this in the Arcantina.", fua = "Можливо, для нього знайдеться місце в Аркантині." }
    t[250881] = { name = "Засушені Троянди", fen = "There might be somewhere to display this in the Arcantina.", fua = "Можливо, для нього знайдеться місце в Аркантині." }
    t[250882] = { name = "Шкура розкопита", fen = "There might be somewhere to display this in the Arcantina.", fua = "Можливо, для нього знайдеться місце в Аркантині." }
    t[250889] = { name = "Вітрокликач амані", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[250919] = { name = "Порожня Котушка Манашовку", fen = "For winding on freshly-siphoned mana silk.", fua = "Для намотування свіжовидобутого манашовку." }
    t[250922] = "Шепіт лоа: Шкіряна справа"
    t[250923] = "Шепіт лоа: Білування"
    t[250924] = "Шепіт лоа: Гірнича справа"
    t[250974] = "Висхідний Вітер Акіл'зона"
    t[251001] = { name = "Барвистий маналя", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[251002] = { name = "Фамільяр Нечестя", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[251003] = { name = "Гнівний вирм", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[251039] = "Трунок для тосту"
    t[251073] = "Захисна матриця з каменю Порожнечі"
    t[251075] = { name = "Загублений болт амані", fen = "The wood has been warped by time. Faded colors and beading suggest it might have been very vibrant once.", fua = "Дерево покоробилося від часу. Вицвілі барви й бісер натякають, що колись він був дуже яскравий." }
    t[251076] = "Брошка захисника Сонячного Колодязя"
    t[251077] = "Гілка вартового коренів"
    t[251078] = "Захисниця Попелястого Світанку"
    t[251079] = "Бурштинолисті наручі"
    t[251080] = "Німб Тернового Світанку"
    t[251081] = "Хвати Попелястого Гаю"
    t[251082] = "Пояс хапкої лози"
    t[251083] = "Розкопувальний кий"
    t[251084] = "Сабатони батога-пружини"
    t[251085] = "Накидка темної відданості"
    t[251086] = "Захисник Шматохреба"
    t[251087] = "Обмотки Тривкої Спадщини"
    t[251088] = "Сікач, зношений війною"
    t[251089] = "Хват забутої честі"
    t[251090] = "Вицвілі штани командира"
    t[251091] = "Сабатони лютої помсти"
    t[251092] = "Мантія полеглого вояка"
    t[251093] = "Згасання Світла"
    t[251094] = "Знак неспокійного серця"
    t[251095] = "Серце урагану"
    t[251096] = "Підвіска щемкої скорботи"
    t[251097] = "Наплічники польоту стріли"
    t[251098] = "Збляклий наличник лучниці"
    t[251099] = "Жилет завивального вихору"
    t[251100] = "Молот лиходійства"
    t[251101] = "Панцир арканного стража"
    t[251102] = "Застібка покори"
    t[251103] = "Кайдани опіки"
    t[251104] = "Легінси Зразкової Поведінки"
    t[251105] = "Оберіг Руйнівника чарів"
    t[251106] = "Рішуча рунова глефа"
    t[251107] = "Чоботи присяжних"
    t[251108] = "Обмотки пильного гніву"
    t[251109] = "Тіньова маска розриву чарів"
    t[251110] = "Сонячний пояс Сонцебатога"
    t[251111] = "Жало розтину покрову"
    t[251112] = "Тінерозтинний пояс"
    t[251113] = "Рукавиці в'язкого слизу"
    t[251114] = "Кольчуга зі слизу, спотворена Порожнечею"
    t[251115] = "Перстень роздвоєння"
    t[251116] = "Застібка згубника Порожнечі"
    t[251117] = "Вихровий сікач Порожнечі"
    t[251118] = "Латні поножі Тривкого Присмерку"
    t[251119] = "Лик вихору"
    t[251120] = "Обмотки тіньового сходження"
    t[251121] = "Грізні чоботи доманаара"
    t[251122] = "Тінеруб-різак"
    t[251123] = "Тренувальний жезл Гризунчика"
    t[251124] = "Латні рукавиці гарячкового захисту"
    t[251125] = "Просочені Скверною підошви"
    t[251126] = "Великий шолом спокуси"
    t[251127] = "Гризькі нараменники"
    t[251128] = "Клинкова туга"
    t[251129] = "Підроблені пазурі"
    t[251130] = "Штани Спритних Оборудок"
    t[251131] = "Брязкітливі наплічники Скверни"
    t[251132] = "Покрив підпільної корчми"
    t[251133] = "Наручі наглядача"
    t[251134] = "Розрубувач Ксатуукса"
    t[251135] = "Люттю опірені наручі"
    t[251136] = "Перстень злісної покори"
    t[251137] = "Буремні сандалі"
    t[251138] = "Наплічники Сіндерф'юрі"
    t[251139] = "Пекуча сорочка викликниці"
    t[251140] = "Каптур мерзенного біса"
    t[251141] = "З'єднані кольчужні ногавиці Літіель"
    t[251142] = "Підвіска злостивої люті"
    t[251143] = "Рукавиці похмурого жнива"
    t[251144] = "Пояс осіннього дару"
    t[251145] = { name = "Наступники забутого племені", fen = "From a tribe forgotten everywhere but Nalorakk's dreams.", fua = "Від племені, забутого всюди, окрім снів Налоракка." }
    t[251146] = "Наплічники збирача"
    t[251147] = "Перев'яз краденого врожаю"
    t[251148] = { name = "Поцуплений коштовний перстень", fen = "The Hoardmonger was strangely attached to this 'precious' ring.", fua = "Скарбохапко був дивно прив'язаний до цього «коштовного» персня." }
    t[251149] = "Миттєвоморожений клинок переможця"
    t[251150] = "Прихисток бурі"
    t[251151] = "Приз вартового-суперника"
    t[251152] = "Рукавиці зміни пір року"
    t[251153] = "Ногавиці арктичного дослідника"
    t[251154] = "Наручі обіймів зими"
    t[251155] = "Шнур племінного захисника"
    t[251156] = "Посох полеглого речника"
    t[251157] = "Пекучі наплічники"
    t[251158] = "Жах Налоракка"
    t[251159] = "Шати воєнного випробування"
    t[251160] = "Наголінники лісового сну"
    t[251161] = { name = "Покрив мисливиці на душі", fen = "A relic of the twisted rituals secret to the Vilebranch.", fua = "Реліквія викривлених ритуалів, що є таємницею Лихогіллі." }
    t[251162] = "Кіготь зрадника"
    t[251163] = "Вроцькі пазурі берсерка"
    t[251164] = "Збруя Злиття"
    t[251165] = "Трощильні рукавиці"
    t[251166] = "Пояс сокольничого"
    t[251167] = { name = "Скрадальники Нічної Здобичі", fen = "These footwraps give Witherbark hunters sure, silent steps when stalking their prey", fua = "Ці онучі дарують мисливцям Візербарків упевнену й тиху ходу, коли вони підкрадаються до здобичі." }
    t[251168] = "Абордажна шабля Життєрозривача"
    t[251169] = { name = "Обмотки на стопи лихої долі", fen = "The Vilebranch walk a perilous path between life and death.", fua = "Лихогіллі ступають небезпечним шляхом між життям і смертю." }
    t[251170] = "Штани злотканини"
    t[251171] = "Зачаровані кістяні шипи"
    t[251172] = "Пута мерзенних чарів"
    t[251173] = "Ярмо навального ведмедя"
    t[251174] = "Гнилолук дурисвіта"
    t[251175] = "Тесак душомору"
    t[251176] = "Тягар воскресителя"
    t[251177] = { name = "Сморідна мерзенна корона", fen = "It appears sewn from the decaying corpses of many animals.", fua = "Схоже, її зшито з гнилих трупів багатьох тварин." }
    t[251178] = { name = "Церемоніальний клинок чарів", fen = "A blade used in the foul ceremony to raise and empower Rak'thul.", fua = "Клинок, що його використовують у мерзенній церемонії воскресіння та посилення Рак'тула." }
    t[251179] = "Зотлілий панцир"
    t[251180] = "Терноклинок"
    t[251181] = "Підрізальна піка"
    t[251182] = "Штани з корінної породи"
    t[251183] = "Обмотки вартового коренів"
    t[251184] = "Залізнокореневий комір"
    t[251185] = "Пояс Світлоцвіту"
    t[251186] = "Лезо тернокогтя"
    t[251187] = "Розмах Амірдрассіла"
    t[251188] = "Лиховісна пелюстка"
    t[251189] = "Збруя кореневого ходака"
    t[251190] = "Кровотерновий бурнус"
    t[251191] = "Люмінесцентний паросток"
    t[251192] = "Гілка Гордості"
    t[251193] = "Реберний захист зі стрижневого кореня"
    t[251194] = "Пута Світловартового"
    t[251195] = "Колюча відповідь"
    t[251196] = "Жертва Тельдрассила"
    t[251197] = "Рукавиці терношипа"
    t[251198] = "Легінси світлоспор"
    t[251199] = "Крона світокореня"
    t[251200] = "Наручі смолораптороубивці"
    t[251201] = "Багатофункційний інструмент ядроіскри"
    t[251202] = "Рефлектор зворотного потоку"
    t[251203] = "Пов'язки Касрета"
    t[251204] = "Розрядники майстра ядра"
    t[251205] = "Легінси силових ліній"
    t[251206] = "Плащ із флюксоткання"
    t[251207] = "Кий Жахоцепа"
    t[251208] = "Зашрамовані Світлом набедреники"
    t[251209] = "Манжети вартового ядра"
    t[251210] = "Еспадрильї Затемнення"
    t[251211] = "Потріскані рукавиці без пальців"
    t[251212] = "Сяйливий різак"
    t[251213] = "Накидка Нісарри"
    t[251214] = "Окови Гаш'ура"
    t[251215] = "Поножі божественної хитрості"
    t[251216] = "Проклятий жилет"
    t[251217] = "Запона Порожнечі"
    t[251218] = "Космічне лезо Таз'Ра"
    t[251219] = "Витерті Розломом чоботи"
    t[251220] = "Корона, посічена Порожнечею"
    t[251221] = "Латні рукавиці зневіреного"
    t[251222] = "Ефірна нетер-обмотка"
    t[251223] = "Похмурі наплічники"
    t[251224] = "Громіздка ручна сокира"
    t[251225] = "Ікло зарази"
    t[251226] = "Шкура Чуми"
    t[251227] = "Наплічники отруйника"
    t[251228] = "Пояс бегемота"
    t[251229] = "Забрало хижака"
    t[251230] = "Харонічний серп"
    t[251231] = "Різак сингулярності"
    t[251232] = "Діадема наглядача"
    t[251233] = "Жилет маніпулятора"
    t[251234] = "Прищеп доманаарів"
    t[251235] = "Гравітаційний пояс"
    t[251241] = "Ентропійний кристал Порожнечі"
    t[251242] = "Перстень зв'язаного Порожнечею лейтенанта"
    t[251250] = "Віднайдений тесак святилища"
    t[251251] = "Віднайдена сокирка святилища"
    t[251252] = "Віднайдена сокира святилища"
    t[251253] = "Віднайдена рапіра святилища"
    t[251254] = "Віднайдений меч святилища"
    t[251255] = "Віднайдений дворучний меч святилища"
    t[251256] = "Віднайдений клинок святилища"
    t[251257] = "Віднайдений ціпок святилища"
    t[251258] = "Віднайдена жердина святилища"
    t[251259] = "Віднайдений лук святилища"
    t[251260] = "Віднайдений кинджал святилища"
    t[251272] = { name = "Загублене весло амані", fen = "Something rather unfortunate to lose in a lake.", fua = "Доволі прикра річ, щоб загубити її в озері." }
    t[251273] = { name = "Трохи магічний кристал", fen = "If you focus very closely, you can sense a soft thrum emanating from it.", fua = "Якщо зосередитися як слід, можна відчути, як від нього лине тихе гудіння." }
    t[251274] = "Рукавиці оновлення"
    t[251275] = "Обмотки оновлення"
    t[251276] = "Дотик оновлення"
    t[251277] = "Руки оновлення"
    t[251278] = { name = "Ненажерливе тавро", fen = "This brand will ignite a corpse with a flare, possibly attracting nearby hungry entities.", fua = "Це тавро спалахом запалить труп, можливо, приваблюючи голодних істот поблизу." }
    t[251283] = { name = "Змучений тантал", fen = "A dense alloy rendered from tormented souls. Can be bought and sold on the Auction House.", fua = "Щільний сплав, виплавлений зі змучених душ. Можна купити й продати на Аукціоні." }
    t[251284] = { name = "Інвертор аномалії", fen = "Something Grand Artificer Rommul created for the occasion.", fua = "Дещо, що Великий Конструктор Ромуул створив з цієї нагоди." }
    t[251285] = { name = "Скам'янілий корінь", fen = "The root is warm to the touch. Can be bought and sold on the Auction House.", fua = "Корінь теплий на дотик. Можна купити й продати на аукціоні." }
    t[251287] = { name = "Щедрий оберемок скам'янілого коріння", fen = "A heap of roots bound together with cloth.", fua = "Купа коріння, перев'язаного тканиною." }
    t[251321] = { name = "Колекція вічноспівних мінералів", fen = "Filled with reagents useful for Midnight Blacksmithing and Jewelcrafting.", fua = "Наповнена реагентами, корисними для ковальства й ювелірства Опівночі." }
    t[251322] = { name = "Торба таласського шкіряра", fen = "Filled with reagents useful for Midnight Leatherworking.", fua = "Наповнена реагентами, корисними для шкірообробки Опівночі." }
    t[251324] = { name = "Кошик вічноспівних трав", fen = "Filled with reagents useful for Midnight Alchemy and Inscription.", fua = "Наповнений реагентами, корисними для алхімії та письмознавства Опівночі." }
    t[251326] = { name = "Гаманець таласського зачаровувача", fen = "Filled with reagents useful for Midnight Enchanting.", fua = "Наповнений реагентами, корисними для зачаровування Опівночі." }
    t[251327] = { name = "Сумка таласського кравця", fen = "Filled with reagents useful for Midnight Tailoring.", fua = "Наповнена реагентами, корисними для кравецтва Опівночі." }
    t[251487] = { name = "Призматична фокусувальна діафрагма", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[251488] = { name = "Призматична фокусувальна діафрагма", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[251489] = { name = "Стабілізаційна самоцвітна перев'язь", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[251490] = { name = "Стабілізаційна самоцвітна перев'язь", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[251491] = { name = "Магічний Клікер для Улюбленців", fen = "Sit! Now stay!", fua = "Сидіти! А тепер на місце!" }
    t[251492] = { name = "Шукач трохи магічних кристалів", fen = "Finds magical crystals. More specifically, slightly magical crystals.", fua = "Знаходить магічні кристали. Точніше, трохи магічні кристали." }
    t[251512] = { name = "Уламок одкровення", fen = "A shard of the haranir's history, hidden away at the bottom of the Gulf of Memory.", fua = "Часточка історії гараніру, схована на дні Затоки Пам'яті." }
    t[251513] = "Перстень шанувальника лоа"
    t[251521] = { name = "Повна Котушка Манашовку", fen = "A freshly-wound bobbin of glittering manasilk.", fua = "Свіжонамотана котушка блискучого манашовку." }
    t[251629] = { name = "Техніка: Контракт: Плем'я Амані", fen = "Teaches you how to craft Contract: The Amani Tribe.", fua = "Навчає вас виготовляти Контракт: Плем'я Амані." }
    t[251630] = { name = "Рецепт: Тушкований кровомисливець", fen = "Teaches you how to craft Braised Blood Hunter.", fua = "Навчає вас готувати тушкованого кровомисливця." }
    t[251633] = "Тріскотливий Клунок Щедрот"
    t[251635] = { name = "Незаконний космічний випромінювач", fen = "An unusual weapon obtained from an unusual supplier.", fua = "Незвичайна зброя, здобута в незвичайного постачальника." }
    t[251665] = { name = "Нитка зі срібнолисту", fen = "Silverleaf has many uses, including the fiber arts. Sold by Tailoring vendors.", fua = "Срібнолист має багато застосувань, зокрема й у текстильному ремеслі. Продається у торговців кравецьким приладдям." }
    t[251691] = { name = "Нитка для Вишивання", fen = "The perfect finishing touch for any stylish garment. Sold by Tailoring vendors.", fua = "Ідеальний завершальний штрих для будь-якого стильного вбрання. Продається у крамницях кравецтва." }
    t[251719] = "Накидка Надії Світла"
    t[251720] = "Еполети Надії Світла"
    t[251721] = "Наплічники Надії Світла"
    t[251722] = "Наплічники Надії Світла"
    t[251724] = "Перероблений багряний черепокол"
    t[251725] = "Перероблена багряна сокира"
    t[251726] = "Перероблений багряний тесак"
    t[251727] = "Перероблений багряний меч"
    t[251728] = "Перероблений багряний клинок"
    t[251729] = "Перероблений багряний широкий меч"
    t[251730] = "Перероблений багряний клеймор"
    t[251731] = "Перероблена багряна тростина"
    t[251732] = "Перероблений багряний бойовий посох"
    t[251733] = "Перероблений багряний лук"
    t[251734] = "Перероблений багряний ніж"
    t[251774] = { name = "Ящик священних реліквій", fen = "All the remaining relics not used for the Sunwell ritual.", fua = "Усі реліквії, що лишилися й не були використані для ритуалу Сонячного Колодязя." }
    t[251782] = "Лапа всохлого смолораптора"
    t[251783] = "Загублений ідол гаш'ей"
    t[251784] = "Лісовий вакрапуку"
    t[251785] = "Требник женця Порожнечі"
    t[251786] = "Вічнозгасальна тріщина Порожнечі"
    t[251787] = "Запечатана урна хаосу"
    t[251788] = "Дар Світла"
    t[251789] = "Освячена чаша"
    t[251790] = "Осквернений келих"
    t[251791] = "Веління святого месника"
    t[251792] = "Пам'ятка славного хрестоносця"
    t[251793] = "Ендосимбіотичний міцелій"
    t[251794] = "Грі-грі впевненості"
    t[251805] = { name = "Нестабільний вибуховий пристрій", fen = "One way or another, it'll be gone within the hour.", fua = "Так чи інакше, за годину його не стане." }
    t[251816] = "Штани скромного слуги"
    t[251817] = "Рейтузи скромного слуги"
    t[251818] = "Спідні скромного слуги"
    t[251819] = "Легінси скромного слуги"
    t[251822] = "Обруч Темної Орди"
    t[251823] = "Шолом Темної Орди"
    t[251824] = "Каптур Темної Орди"
    t[251825] = "Шолом Темної Орди"
    t[251826] = "Медальйон Темної Орди"
    t[251828] = "Пошрамований кольє клану Чорноскали"
    t[251829] = "Безпалі рукавиці Мар'каґа"
    t[251830] = "Завеликий перстень Мар'каґа"
    t[251831] = "Наручі Мар'каґа"
    t[251832] = "Браслет на ногу Мар'каґа"
    t[251881] = { name = "Невелика купка сяйливого пилу", fen = "Mothkeeper Wew'tam in The Den might be interested in this.", fua = "Цим могла б зацікавитися Доглядачка метеликів Вев'там у Лігві." }
    t[251882] = "Розколотий уламок світла"
    t[251883] = "Зосереджувач каналізування Умбрика"
    t[251884] = "Шабля Безодні"
    t[251885] = "Сяйлива рапіра"
    t[251886] = "Нестабільний манамедальйон"
    t[251899] = { name = "Книга законів Анастеріана", fen = "Written by High King Anasterian Sunstrider. A lengthy volume of codices and edicts.", fua = "Написана верховним королем Анастеріаном Сонстрайдером. Об'ємний том кодексів та едиктів." }
    t[251902] = { name = "Зріла кров'яна пелюстка", fen = "A peculiar flower thriving in stagnant pools of decayed flesh and other fluids. Potentially potent at neutralizing harmful agents.", fua = "Дивна квітка, що буяє в застійних калюжах гнилої плоті та інших рідин. Можливо, дієва для нейтралізації шкідливих речовин." }
    t[251903] = "Яйце Картопухи"
    t[251904] = { name = "Корона верховного короля", fen = "The crown glimmers with authority.", fua = "Корона виблискує владою." }
    t[251905] = { name = "Спеціалізована печінка", fen = "A liver specialized in cleansing toxins and parasites native to the Voidstorm.", fua = "Печінка, що спеціалізується на очищенні від токсинів і паразитів, родом з Бурі Порожнечі." }
    t[251919] = "Накреслення: Кров"
    t[251920] = "Накреслення: Гнилизна"
    t[251921] = "Накреслення: Полювання"
    t[251922] = "Накреслення: Порожнеча"
    t[251923] = { name = "Таласська есенція ярмарку", fen = "A boisterous mote of energy used by scribes to craft various Darkmoon oddities. Can be bought and sold on the Auction House.", fua = "Невгамовна частинка енергії, яку використовують писарі для виготовлення різноманітних дивовиж Темного Місяця. Можна купити й продати на Аукціоні." }
    t[251934] = "Благословенний перстень-печатка"
    t[251935] = "Світлохватний світокорінь"
    t[251936] = "Знульований ціпок"
    t[251970] = { name = "Переповнений скарб амані", fen = "Contains a variety of rewards for those who have proven themselves true allies of the Amani Tribe.", fua = "Містить різноманітні нагороди для тих, хто довів, що є справжнім союзником племені амані." }
    t[252003] = { name = "Слизький луціан", fen = "Difficult to catch with your bare hands, but well worth the effort if cooked properly.", fua = "Голіруч його впіймати важко, але як приготувати правильно, він вартий зусиль." }
    t[252011] = { name = "Осяйний Пелюсткокрил", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[252012] = { name = "Барвистий пелюсткокрил", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[252014] = { name = "Лазуровий спорокрил", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[252017] = { name = "Рудуватий спорокрил", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[252134] = { name = "Бойовий спис Ідаґо", fen = "The spear is adorned with wraps reserved for the honor guard sworn to protect the tribe's leader.", fua = "Спис оздоблений перев'язками, що їх носить лише почесна варта, яка присяглася захищати ватажка племені." }
    t[252135] = { name = "Стяг Ідаґо", fen = "A story of heroic and loyal service is inscribed on this banner.", fua = "На цьому стязі викарбувано оповідь про героїчну й віддану службу." }
    t[252136] = { name = "Лист Ідаґо", fen = "You got de courage of de fiercest bear, Lilaju. You're a cub no more. You would make ya parents proud.", fua = "У тобі відвага найлютішого ведмедя, Лілажу. Ти вже не ведмежа. Твої батьки пишалися б тобою." }
    t[252192] = { name = "Рунний ключ", fen = "The magic of this runic device mirrors that of the shackles binding Idago.", fua = "Магія цього рунного пристрою віддзеркалює магію кайданів, що тримають Ідаґо." }
    t[252234] = { name = "Смаковитий шматок смолораптора", fen = "It looks like meat, but it's not meat!", fua = "Виглядає як м'ясо, але це не м'ясо!" }
    t[252246] = { name = "Солодкі жукові крильця", fen = "Some food is better to not know the origins of.", fua = "Про походження деяких страв краще не знати." }
    t[252257] = { name = "Багатий суглинистий ґрунт", fen = "A staple of Rutaani and Fungarian cuisine.", fua = "Основа кухні рутаані та фунґаріан." }
    t[252258] = "Огидний перстень-печатка Атроксуса"
    t[252259] = { name = "Мандрівне Желе", fen = "Sweet but slightly salty.", fua = "Солодке, але трохи солоне." }
    t[252265] = "Заврочений Слиз Картопухи"
    t[252370] = { name = "Листок серцевого вогника", fen = "An herb tinged with the metallic scent of blood.", fua = "Трава з металевим присмаком крові." }
    t[252411] = "Сяйливий сонячний камінь"
    t[252415] = { name = "Винагорода шукача скарбів", fen = "Surely, great treasure awaits.", fua = "Безперечно, на тебе чекає великий скарб." }
    t[252418] = "Запальник сонячного ядра"
    t[252420] = "Призма сонячного спалаху"
    t[252421] = "Гнила кулька"
    t[252607] = "Маяк рясності"
    t[252608] = { name = "Чиста рясність", fen = "Your first gift from the Loa of Abundance. Used to purchase goods from Chel the Chip.", fua = "Твій перший дарунок від лоа Рясності. Використовується для купівлі товарів у Чела Карбика." }
    t[252609] = { name = "Уламок ключа від скрині", fen = "Acquired from treasures, Radiant Echoes, World Quests, and outdoor events throughout Khaz Algar.", fua = "Здобувається зі скарбів, Сяйних Відлунь, світових завдань та подій просто неба по всьому Каз Алґару." }
    t[252648] = { name = "Скупчення уламків ключа", fen = "Grants a cluster of Coffer Key Shards upon acquisition.", fua = "Дає скупчення уламків ключа від скрині при отриманні." }
    t[252649] = { name = "Зелений слиз скрадача", fen = "Positively teeming with life of all sorts.", fua = "Буквально кишить усілякими формами життя." }
    t[252677] = "Загадкова реліквія крипти"
    t[252684] = "Рукавиці світської особи Лицарів крові"
    t[252685] = "Штани світської особи Лицарів крові"
    t[252686] = "Пряжка світської особи Лицарів крові"
    t[252687] = "Жилет світської особи Лицарів крові"
    t[252688] = "Черевики світської особи Лицарів крові"
    t[252689] = "Рукавиці світського магістра"
    t[252690] = "Штани світського магістра"
    t[252691] = "Пряжка світського магістра"
    t[252692] = "Жилет світського магістра"
    t[252693] = "Черевики світського магістра"
    t[252694] = "Рукавиці світської особи далекоходів"
    t[252695] = "Штани світської особи далекоходів"
    t[252696] = "Пряжка світської особи далекоходів"
    t[252697] = "Жилет світської особи далекоходів"
    t[252698] = "Черевики світської особи далекоходів"
    t[252699] = "Рукавиці гаванського світського лева"
    t[252700] = "Штани гаванського світського лева"
    t[252701] = "Пряжка гаванського світського лева"
    t[252702] = "Жилет гаванського світського лева"
    t[252703] = "Чоботи гаванського світського лева"
    t[252704] = "Поцуплені рукавиці світської особи"
    t[252705] = "Поцуплені штани світської особи"
    t[252706] = "Поцуплена пряжка світської особи"
    t[252707] = "Поцуплений жилет світської особи"
    t[252708] = "Поцуплені черевики світської особи"
    t[252716] = "Тіньові наручні ланцюги придворного"
    t[252717] = "Тіньова мантія придворного"
    t[252718] = "Тіньовий пояс придворного"
    t[252719] = "Тіньовий ланцюг придворного"
    t[252720] = "Тіньові обмотки придворного"
    t[252721] = "Лазурові наручні ланцюги придворного"
    t[252722] = "Лазурова мантія придворного"
    t[252723] = "Лазуровий пояс придворного"
    t[252724] = "Лазуровий ланцюг придворного"
    t[252725] = "Лазурові обмотки придворного"
    t[252726] = "Смарагдові наручні ланцюги придворного"
    t[252727] = "Смарагдова мантія придворного"
    t[252728] = "Смарагдовий пояс придворного"
    t[252729] = "Смарагдовий ланцюг придворного"
    t[252730] = "Смарагдові обмотки придворного"
    t[252731] = "Багряні наручні ланцюги придворного"
    t[252732] = "Багряна мантія придворного"
    t[252733] = "Багряний пояс придворного"
    t[252734] = "Багряний ланцюг придворного"
    t[252735] = "Багряні обмотки придворного"
    t[252736] = "Осяйні наручні ланцюги придворного"
    t[252737] = "Осяйна мантія придворного"
    t[252738] = "Осяйний пояс придворного"
    t[252739] = "Осяйний ланцюг придворного"
    t[252740] = "Осяйні обмотки придворного"
    t[252956] = "Есенція, зв'язана з Альном"
    t[252957] = "Сплетіння яскравих лоз"
    t[253153] = { name = "Викрадені знання", fen = "Kasiea's handwriting is unmistakable. These are the pages ripped and stolen from her notebook.", fua = "Почерк Касієї ні з чим не сплутати. Це сторінки, вирвані й викрадені з її записника." }
    t[253210] = { name = "Печатка віщуна", fen = "A small silver ring inlaid with a violet gem. The letter 'Z' has been carved in the surface.", fua = "Невеликий срібний перстень з оправленим фіолетовим самоцвітом. На поверхні вирізано літеру «Z»." }
    t[253211] = { name = "Печатка контрабандиста", fen = "A small silver ring inlaid with a green gem. The letter \"Z\" has been carved in the surface.", fua = "Невеликий срібний перстень з оправленим зеленим самоцвітом. На поверхні вирізано літеру «Z»." }
    t[253212] = { name = "Перстень-печатка розбійника", fen = "A small silver ring inlaid with a yellow gem. The letter 'Z' has been carved in the surface.", fua = "Маленький срібний перстень із жовтим самоцвітом. На поверхні викарбувано літеру «Z»." }
    t[253226] = "Відновлений ключ від скрині"
    t[253245] = { name = "Тріснутий ключ", fen = "Triumphal horns and cries of victory can faintly be heard emanating from within.", fua = "Зсередини ледь чутно лунають тріумфальні роги й переможні вигуки." }
    t[253302] = { name = "Гнучкий каркас", fen = "A preliminary reagent often used by Engineers before starting their work. Can be purchased from vendors.", fua = "Попередній реагент, який інженери часто використовують перед початком роботи. Можна придбати в торговців." }
    t[253303] = { name = "Купа мотлоху", fen = "A heap of scrap unusable by one Tinker, but perhaps useful to another. Can be purchased from vendors.", fua = "Купа брухту, непридатна одному майстровому, та, можливо, корисна іншому. Можна придбати в торговців." }
    t[253307] = { name = "Насичений геліотроп", fen = "Acquired rarely through PvP activities, such as battlegrounds or arenas. Can be purchased with Honor. Used to craft and augment Midnight PvP gear in various ways. Can be bought and sold on the Auction House.", fua = "Рідкісно здобувається в PvP-активностях, як-от поля битв чи арени. Можна придбати за Честь. Використовується для виготовлення та вдосконалення PvP-спорядження Опівночі у різні способи. Можна купувати й продавати на Аукціоні." }
    t[253342] = { name = "Маяк надії", fen = "A small yet immensely potent source of light. So much so that its glow is said to shine through into the Void itself. Unfortunately, its denizens can see it too, and they will act to obscure it.", fua = "Маленьке, та неймовірно потужне джерело світла. Настільки, що його сяйво, як кажуть, пробивається аж у саму Порожнечу. На жаль, її мешканці теж його бачать — і робитимуть усе, щоб його затьмарити." }
    t[253386] = { name = "Насінина, що пульсує Світлом", fen = "Glowing tendrils stretch and writhe from small cracks in the seed.", fua = "З дрібних тріщин у насінині тягнуться й звиваються сяйливі вусики." }
    t[253387] = { name = "Незіпсоване око", fen = "One of many eyes from an aberration. It's in such perfect condition, you wonder if it can still see.", fua = "Одне з багатьох очей аберації. Воно в такому ідеальному стані, що ти замислюєшся, чи воно ще бачить." }
    t[253403] = { name = "Таласське філе", fen = "Freshly filleted by someone with the Cooking skill. Can be bought and sold on the Auction House.", fua = "Свіжо нарізане тим, хто володіє вмінням Кулінарії. Можна купувати й продавати на Аукціоні." }
    t[253506] = "Кореневий чан"
    t[253516] = "Використаний балон глибоководного нурця"
    t[253518] = { name = "Протиотрута від патогену", fen = "A powerful curative crafted from the flora and fauna in the Molt.", fua = "Потужний лік, виготовлений із флори та фауни Линяви." }
    t[253519] = { name = "Патогенна есенція", fen = "The remnants of a deadly bloodborn pathogenic existence. It appears to be moving slightly...", fua = "Рештки смертоносної патогенної істоти, народженої з крові. Здається, вони злегка ворушаться..." }
    t[253521] = { name = "Видіння хмароходіння Герона", fen = "A vintage from Goldenmist Village.", fua = "Витримане вино із селища Золотий Туман." }
    t[253582] = "Іклоплавцевий ціп"
    t[253623] = "Абстрактна картина"
    t[253624] = "Перевірений глибиною балон"
    t[253625] = "Кисневий балон Налоракка"
    t[253626] = "Укріплені з'єднання"
    t[253627] = "Глибинне мастило"
    t[253628] = "Глибоководні плавці Пага"
    t[253629] = { name = "Особистий Ключ до Аркантіни", fen = "An intricate relic forged from remnants of Dalaran, it shimmers with deep violet crystels and etched runes, humming softly with arcane power.", fua = "Вигадлива реліквія, викувана з решток Даларану, мерехтить глибоко-фіолетовими кристалами й викарбуваними рунами, тихо гудучи арканною силою." }
    t[253802] = { name = "Грамота меценатства", fen = "Your patronage has allowed you to purchase canvas paintings in the Silvermoon Bazaar, north of the Sanctum of Light. Merely showing patronage is enough, you don't need to keep the deed on you.", fua = "Твоє меценатство дозволило тобі купувати полотняні картини на Базарі Сільвермуна, на північ від Святилища Світла. Достатньо просто виявити меценатство — тобі не потрібно носити грамоту із собою." }
    t[253849] = { name = "Переробка", fen = "Recycle crafted reagents from a variety of Midnight Professions to salvage necessary components like Aetherlume and Evercores.", fua = "Переробляє виготовлені реагенти з різних професій Опівночі, щоб отримати необхідні компоненти на кшталт ефірлюму та вічноядер." }
    t[254250] = { name = "Щедра Скриня", fen = "Contains powerful equipment, bonus currencies, and a chance at a new or upgraded curio. Requires a Restored Coffer Key to open.", fua = "Містить потужне спорядження, додаткові валюти й шанс на нову чи поліпшену дивовижу. Для відкриття потрібен Відновлений Ключ від Скрині." }
    t[254253] = { name = "Здобич Нуллея", fen = "Defeating Nullaeus may reward currencies, collectibles, curios, and upgrade crests. Once per week per character.", fua = "Перемога над Нуллеєм може винагородити валютами, колекційними предметами, дивовижами й гербами вдосконалення. Раз на тиждень для кожного персонажа." }
    t[254256] = { name = "Винагорода дослідника Глибин", fen = "There is a small chance to find a Delver's Bounty inside one of this delve's Heavy Trunks.", fua = "Є невеликий шанс знайти винагороду дослідника Глибин в одній з важких скринь цієї Глибини." }
    t[254268] = "Відновлений ключ від скрині"
    t[254269] = "Відновлений ключ від скрині"
    t[254270] = "Відновлений ключ від скрині"
    t[254271] = "Відновлений ключ від скрині"
    t[254272] = "Відновлений ключ від скрині"
    t[254273] = "Відновлений ключ від скрині"
    t[254274] = "Відновлений ключ від скрині"
    t[254276] = { name = "Сяйливе відлуння", fen = "Obtained from a Bountiful Coffer in a Bountiful Delve. Bring to a Worldsoul Memory to experience the radiant memories of Azeroth.", fua = "Здобувається зі щедрої скрині у Щедрій Глибині. Принеси його до Спогаду Світодуші, щоб пережити сяйливі спогади Азероту." }
    t[254280] = { name = "Флакон ртуті", fen = "Toxic to touch and taste. Not well-suited to any sort of conventional medicine.", fua = "Отруйна на дотик і на смак. Геть не годиться для жодної звичайної медицини." }
    t[254282] = { name = "Пляшка Магістерського Резерву", fen = "Vintages that predate the Cataclysm prove increasingly rare lately, for obvious reasons.", fua = "Витримки до Катаклізму останнім часом стають дедалі рідкіснішими — з очевидних причин." }
    t[254283] = { name = "Іржава сокира", fen = "Many orcs threw their weapons at Kurdran, but none found their target.", fua = "Багато орків кидали свою зброю в Курдрана, та жодна не влучила в ціль." }
    t[254373] = { name = "Ельрендарське червоне Арейна", fen = "A vintage from Goldenmist Village.", fua = "Витримане вино із селища Золотий Туман." }
    t[254384] = { name = "Витримане арквино леді Марілін", fen = "A vintage from Goldenmist Village.", fua = "Витримане вино із селища Золотий Туман." }
    t[254385] = { name = "Мускусно-динний напій Ландреланіс", fen = "A vintage from Goldenmist Village.", fua = "Витримане вино із селища Золотий Туман." }
    t[254386] = { name = "Арканний настій Лімієна", fen = "A vintage from Goldenmist Village.", fua = "Витримане вино із селища Золотий Туман." }
    t[254387] = { name = "Танцівливе Мерло Сутінкозгасу", fen = "A vintage from Goldenmist Village.", fua = "Витримане вино із селища Золотий Туман." }
    t[254388] = { name = "Метеликова есенція Нари", fen = "A vintage from Goldenmist Village.", fua = "Витримане вино із селища Золотий Туман." }
    t[254389] = { name = "Кривава пристрасть Кварелестри", fen = "A vintage from Goldenmist Village.", fua = "Витримане вино із селища Золотий Туман." }
    t[254390] = { name = "Сміхотливе рожеве Шері", fen = "A vintage from Goldenmist Village.", fua = "Витримане вино із селища Золотий Туман." }
    t[254391] = { name = "Білий мерехтливий серпанок Вена", fen = "A vintage from Goldenmist Village.", fua = "Витримане вино із селища Золотий Туман." }
    t[254394] = { name = "Сутінкове кларет Залени", fen = "A vintage from Goldenmist Village.", fua = "Витримане вино із селища Золотий Туман." }
    t[254430] = "Рештки тотема"
    t[254448] = "Рукавиці сановника Лицарів крові"
    t[254449] = "Наголінники сановника Лицарів крові"
    t[254450] = "Пояс сановника Лицарів крові"
    t[254451] = "Туніка сановника Лицарів крові"
    t[254452] = "Чоботи сановника Лицарів крові"
    t[254453] = "Рукавиці сановника-магістра"
    t[254454] = "Поножі сановника-магістра"
    t[254455] = "Пояс сановника-магістра"
    t[254456] = "Туніка сановника-магістра"
    t[254457] = "Чоботи сановника-магістра"
    t[254458] = "Рукавиці сановника далекоходів"
    t[254459] = "Наголінники сановника далекоходів"
    t[254460] = "Кушак сановника далекоходів"
    t[254461] = "Туніка сановника далекоходів"
    t[254462] = "Чоботи сановника далекоходів"
    t[254463] = "Рукавиці сановника Гавані"
    t[254464] = "Гетри сановника Гавані"
    t[254465] = "Пояс гаванського сановника"
    t[254466] = "Туніка гаванського сановника"
    t[254467] = "Чоботи сановника Гавані"
    t[254468] = "Поцуплені рукавиці вельможі"
    t[254469] = "Поцуплені штани вельможі"
    t[254470] = "Поцуплений пояс вельможі"
    t[254471] = "Поцуплена туніка вельможі"
    t[254472] = "Поцуплені чоботи вельможі"
    t[254474] = "Поцуплена маска вельможі"
    t[254475] = "Маска сановника Гавані"
    t[254476] = "Маска сановника далекоходів"
    t[254477] = "Маска сановника-магістра"
    t[254478] = "Маска сановника Лицарів крові"
    t[254479] = "Елегантна мантія Лицаря крові"
    t[254480] = "Елегантні поножі Лицаря крові"
    t[254481] = "Елегантна застібка Лицаря крові"
    t[254482] = "Елегантна роба Лицаря крові"
    t[254483] = "Елегантні капці Лицаря крові"
    t[254484] = "Елегантна накидка магістра"
    t[254485] = "Елегантні штани магістра"
    t[254486] = "Елегантна застібка магістра"
    t[254487] = "Елегантна мантія магістра"
    t[254488] = "Елегантні капці магістра"
    t[254489] = "Елегантна накидка далекоходів"
    t[254490] = "Елегантні штани далекоходів"
    t[254491] = "Елегантна застібка далекоходів"
    t[254492] = "Елегантна мантія далекоходів"
    t[254493] = "Елегантні капці далекоходів"
    t[254494] = "Елегантна мантія Гавані"
    t[254495] = "Елегантні поножі Гавані"
    t[254496] = "Елегантна застібка Гавані"
    t[254497] = "Елегантна роба Гавані"
    t[254498] = "Елегантні капці Гавані"
    t[254499] = "Поцуплена елегантна мантія"
    t[254500] = "Поцуплені елегантні штани"
    t[254501] = "Поцуплена елегантна пряжка"
    t[254502] = "Поцуплена елегантна роба"
    t[254503] = "Поцуплені елегантні капці"
    t[254505] = "Тіньові наручні ланцюги авгура"
    t[254506] = "Тіньова мантія авгура"
    t[254507] = "Тіньовий пояс авгура"
    t[254508] = "Тіньовий ланцюг авгура"
    t[254509] = "Тіньові обмотки на щиколотки авгура"
    t[254510] = "Лазурові зап'ясткові ланцюжки віщуна"
    t[254511] = "Лазурова мантія віщуна"
    t[254512] = "Лазуровий пояс віщуна"
    t[254513] = "Лазуровий ланцюг віщуна"
    t[254514] = "Лазурові обмотки на щиколотки віщуна"
    t[254515] = "Смарагдові наручні ланцюги авгура"
    t[254516] = "Смарагдова мантія авгура"
    t[254517] = "Смарагдовий пояс авгура"
    t[254518] = "Смарагдовий ланцюг авгура"
    t[254519] = "Смарагдові обмотки на щиколотки авгура"
    t[254520] = "Багряні зап'ясткові ланцюжки віщуна"
    t[254521] = "Багряна мантія віщуна"
    t[254522] = "Багряний пояс віщуна"
    t[254523] = "Багряний ланцюг віщуна"
    t[254524] = "Багряні обмотки на щиколотки віщуна"
    t[254525] = "Сяйливі наручні ланцюги авгура"
    t[254526] = "Сяйлива мантія авгура"
    t[254527] = "Осяйний пояс віщуна"
    t[254528] = "Осяйний ланцюг віщуна"
    t[254529] = "Осяйні обмотки на щиколотки віщуна"
    t[254530] = "Осяйний шолом віщуна"
    t[254531] = "Багряний шолом віщуна"
    t[254532] = "Смарагдовий шолом авгура"
    t[254533] = "Лазуровий шолом віщуна"
    t[254534] = "Тіньовий шолом авгура"
    t[254535] = "Тіньові наплічники авгура"
    t[254536] = "Лазурові наплічники віщуна"
    t[254537] = "Смарагдові наплічники авгура"
    t[254538] = "Багряні наплічники віщуна"
    t[254539] = "Сяйливі наплічники авгура"
    t[254540] = "Тіньові наручі авгура"
    t[254541] = "Лазурові наручі віщуна"
    t[254542] = "Смарагдові наручі авгура"
    t[254543] = "Багряні наручі віщуна"
    t[254544] = "Осяйні наручі віщуна"
    t[254554] = { name = "Паличка чарів амані", fen = "It be yer trusty anti-hexxor', mon!", fua = "Це твій вірний антиврочитель, друже!" }
    t[254557] = { name = "Збірник рецептів корпусу лісничих, том VII", fen = "The portions are far too large to be for personal use.", fua = "Порції надто великі, щоб бути для особистого вжитку." }
    t[254558] = { name = "Довідник травника: цілющі рослини Лісу Вічної Пісні", fen = "Notes are written in the margins detailing how various plants affect animals--not just elves.", fua = "На полях написано нотатки про те, як різні рослини впливають на тварин, а не лише на ельфів." }
    t[254559] = { name = "Пісні срібним потокам", fen = "This humble collection has been taken on many adventures.", fua = "Ця скромна збірка побувала в багатьох пригодах." }
    t[254673] = { name = "Імітація Хадґара від Крейнни", fen = "A vintage from Goldenmist Village.", fua = "Витримане вино із селища Золотий Туман." }
    t[254674] = "Давня дивовижа"
    t[254675] = "Давня дивовижа"
    t[254677] = { name = "Схованка вершини", fen = "Weekly cache containing materials for upgrading equipment, gold, coffer key shards, and more.\n\n\n\nThe first two pinnacle caches you earn each week contain a piece of Veteran equipment.", fua = "Щотижнева скриня з матеріалами для поліпшення спорядження, золотом, уламками ключа від реліквієвої скрині тощо.\n\n\n\nПерші дві найвищі скрині, здобуті за тиждень, містять предмет спорядження ветерана." }
    t[254748] = "Брила досвіду супутника"
    t[254749] = { name = "Флакон норового бальзаму", fen = "An old phial of healing resin, long lost in a pangolin's burrow, its age-fermented balm now prized by the trolls.", fua = "Старий флакон цілющої смоли, давно загублений у норі панголіна, його витриманий часом бальзам тепер цінується тролями." }
    t[254756] = "Брила досвіду супутника"
    t[254757] = "Брила досвіду супутника"
    t[254778] = { name = "Змінений тотем", fen = "Bin'zin's totem has been roughly restored. His energy pulses within it and seems to pull toward him.", fua = "Тотем Бін'зіна нашвидкуруч відновлено. Його енергія пульсує всередині й немовби тягне до нього." }
    t[254838] = { name = "Частування напоями", fen = "They're on Danath.", fua = "За рахунок Даната." }
    t[254869] = "Брила досвіду супутника"
    t[254874] = { name = "Сяйливий пил метеликів", fen = "A fine dust collected from moths found only in Harandar. This can be safely sold to vendors.", fua = "Дрібний пил, зібраний з метеликів, що водяться лише в Гарандарі. Можна без побоювань продати торговцям." }
    t[254983] = "Підступний чай убивці"
    t[254984] = "Міцний витончений чай асасина"
    t[255008] = { name = "Вивітрене орлине яйце", fen = "Despite its rough shell, something inside still stirs with stubborn life.", fua = "Попри шорстку шкаралупу, всередині щось досі ворушиться впертим життям." }
    t[255151] = { name = "Кошлатодзьоб", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[255157] = "Рибальський журнал Рибалки Безодні"
    t[255158] = { name = "Кресало Каллума", fen = "A symbol of devotion to the sacred flame. The lid is initialed, \"C.A.\"", fua = "Символ відданості священному полум'ю. На кришці вигравіювано ініціали «C.A.»" }
    t[255159] = { name = "Щит Каллума", fen = "A sturdy Arathi shield, dented and scored with signs of battle.", fua = "Міцний араті щит, побитий і подряпаний слідами битв." }
    t[255160] = { name = "Намисто Каллума", fen = "The back is engraved, \"Until the stars fade. --Anais\"", fua = "На звороті вигравіювано: «Доки не згаснуть зорі. — Анаїс»" }
    t[255258] = { name = "Ікло гайоповзня", fen = "Constructing a weapon with these fangs will symbolically bestow the hunter with the grovecrawler's swiftness and accuracy.", fua = "Зброя, виготовлена з цих іклів, символічно надасть мисливцеві прудкості й влучності гайоповзня." }
    t[255259] = { name = "Кістка хлороцероса", fen = "A thick, hard, and pristine chloroceros bone, providing the perfect base for a hunter's weapon.", fua = "Товста, тверда й бездоганна кістка хлороцероса, що дає ідеальну основу для мисливської зброї." }
    t[255260] = { name = "Лоза-батіг", fen = "A skilled haranir blacksmith could turn these vines into a hard material that binds together all parts of a weapon.", fua = "Майстерний коваль-гараніри міг би перетворити ці лози на твердий матеріал, що скріплює всі частини зброї докупи." }
    t[255261] = { name = "Хвостова спора споропланера", fen = "We do not hunt the graceful sporeglider. Instead, we collect the molted tail and spores to remind us that the goddess has many ways to gift us with her creations.   - Ka'dani Letanni", fua = "Ми не полюємо на граційного споропланера. Натомість ми збираємо линялий хвіст і спори, щоб нагадати собі, що богиня має багато способів обдарувати нас своїми творіннями. - Ка'дані Летанні" }
    t[255262] = "Латний шолом галактичного претендента"
    t[255263] = "Шовкова роба галактичного претендента"
    t[255264] = "Нагрудник галактичного претендента"
    t[255265] = "Броньована камізелька галактичного претендента"
    t[255266] = "Шкіряний жилет галактичного претендента"
    t[255267] = "Латні бойові чоботи галактичного претендента"
    t[255268] = "Шовкові черевики галактичного претендента"
    t[255269] = "Кольчужні сабатони галактичного претендента"
    t[255270] = "Шкіряні чоботи галактичного претендента"
    t[255271] = "Шкіряні рукавиці галактичного претендента"
    t[255272] = "Латні рукавиці галактичного претендента"
    t[255273] = "Шовкові рукавиці галактичного претендента"
    t[255274] = "Кольчужні рукавиці галактичного претендента"
    t[255275] = "Шовковий каптур галактичного претендента"
    t[255276] = "Кольчужний шолом галактичного претендента"
    t[255277] = "Шкіряний шолом галактичного претендента"
    t[255278] = "Латні поножі галактичного претендента"
    t[255279] = "Шовкові поножі галактичного претендента"
    t[255280] = "Кольчужні поножі галактичного претендента"
    t[255281] = "Шкіряні штани галактичного претендента"
    t[255282] = "Шкіряні наплічники галактичного претендента"
    t[255283] = "Латні наплічники галактичного претендента"
    t[255284] = "Шовкова мантія галактичного претендента"
    t[255285] = "Кольчужні оплічники галактичного претендента"
    t[255286] = "Латний пояс галактичного претендента"
    t[255287] = "Шовковий шнур галактичного претендента"
    t[255288] = "Кольчужний пояс галактичного претендента"
    t[255289] = "Шкіряний пояс галактичного претендента"
    t[255290] = "Шовкові наручні пов'язки галактичного претендента"
    t[255291] = "Латні манжети галактичного претендента"
    t[255292] = "Кольчужні наручні пов'язки галактичного претендента"
    t[255293] = "Шкіряні наручні пов'язки галактичного претендента"
    t[255294] = "Латний наголовник галактичного претендента"
    t[255295] = "Шовкова сорочка галактичного претендента"
    t[255296] = "Латна броня галактичного претендента"
    t[255297] = "Броньована туніка галактичного претендента"
    t[255298] = "Шкіряна туніка галактичного претендента"
    t[255299] = "Латні чоботи галактичного претендента"
    t[255300] = "Шовкові онучі галактичного претендента"
    t[255301] = "Кольчужні чоботи галактичного претендента"
    t[255302] = "Шкіряне взуття галактичного претендента"
    t[255303] = "Шкіряні рукавички галактичного претендента"
    t[255304] = "Латні рукавички галактичного претендента"
    t[255305] = "Шовкові ручні пов'язки галактичного претендента"
    t[255306] = "Кольчужні наручники галактичного претендента"
    t[255307] = "Шовковий головний убір галактичного претендента"
    t[255308] = "Кольчужний наголовник галактичного претендента"
    t[255309] = "Шкіряна маска галактичного претендента"
    t[255310] = "Латні бойові поножі галактичного претендента"
    t[255311] = "Шовкові пов'язки на ноги галактичного претендента"
    t[255312] = "Кольчужні бойові поножі галактичного претендента"
    t[255313] = "Шкіряні поножі галактичного претендента"
    t[255314] = "Шкіряна мантія галактичного претендента"
    t[255315] = "Латні наплічники галактичного претендента"
    t[255316] = "Шовкова шаль галактичного претендента"
    t[255317] = "Кольчужні наплічники галактичного претендента"
    t[255318] = "Латний широкий пояс галактичного претендента"
    t[255319] = "Шовковий пояс галактичного претендента"
    t[255320] = "Кольчужна застібка галактичного претендента"
    t[255321] = "Шкіряний шнур галактичного претендента"
    t[255322] = "Шовкові пов'язки галактичного претендента"
    t[255323] = "Латні наручі галактичного претендента"
    t[255324] = "Кольчужні наручі галактичного претендента"
    t[255325] = "Шкіряні наручі галактичного претендента"
    t[255326] = "Знак лютості галактичного претендента"
    t[255327] = "Медальйон галактичного претендента"
    t[255328] = "Відзнака завзяття галактичного претендента"
    t[255329] = "Емблема галактичного претендента"
    t[255330] = "Сигіл адаптації галактичного претендента"
    t[255331] = "Перстень галактичного претендента"
    t[255332] = "Перстень галактичного претендента"
    t[255333] = "Печатка галактичного претендента"
    t[255334] = "Намисто галактичного претендента"
    t[255335] = "Кольє галактичного претендента"
    t[255336] = "Підвіска галактичного претендента"
    t[255337] = "Накидка галактичного претендента"
    t[255338] = "Плащ галактичного претендента"
    t[255339] = "Плащ галактичного претендента"
    t[255340] = "Великий плащ галактичного претендента"
    t[255341] = "Бойова сокира галактичного претендента"
    t[255342] = "Кинджал галактичного претендента"
    t[255343] = "Булава галактичного претендента"
    t[255344] = "Древкова зброя галактичного претендента"
    t[255345] = "Посох галактичного претендента"
    t[255346] = "Дворучний меч галактичного претендента"
    t[255347] = "Кадило галактичного претендента"
    t[255348] = "Бойовий глеф галактичного претендента"
    t[255349] = "Скіпетр галактичного претендента"
    t[255350] = "Щит галактичного претендента"
    t[255351] = "Лук галактичного претендента"
    t[255352] = "Алебарда галактичного претендента"
    t[255353] = "Моргенштерн галактичного претендента"
    t[255354] = "Ніж галактичного претендента"
    t[255355] = "Тесак галактичного претендента"
    t[255356] = "Чарівна паличка галактичного претендента"
    t[255357] = "Шовкова мантія галактичного гладіатора"
    t[255358] = "Шовкова сукня галактичного гладіатора"
    t[255359] = "Шовкові капці галактичного гладіатора"
    t[255360] = "Шовкові черевики галактичного гладіатора"
    t[255361] = "Шовкові рукавиці галактичного гладіатора"
    t[255362] = "Шовкові обмотки на руки галактичного гладіатора"
    t[255363] = "Шовковий капелюх галактичного гладіатора"
    t[255364] = "Шовкова шапочка галактичного гладіатора"
    t[255365] = "Шовкові поножі галактичного гладіатора"
    t[255366] = "Шовкові штани галактичного гладіатора"
    t[255367] = "Шовкова мантія галактичного гладіатора"
    t[255368] = "Шовковий амікт галактичного гладіатора"
    t[255369] = "Шовковий шнур галактичного гладіатора"
    t[255370] = "Шовковий пояс галактичного гладіатора"
    t[255371] = "Шовкові напульсники галактичного гладіатора"
    t[255372] = "Шовкові нарукавники галактичного гладіатора"
    t[255373] = "Плащ галактичного гладіатора"
    t[255374] = "Накидка галактичного гладіатора"
    t[255375] = "Шаль галактичного гладіатора"
    t[255376] = "Шовкова мантія галактичного гладіатора"
    t[255377] = "Шовкові шати галактичного гладіатора"
    t[255378] = "Шовкові капці галактичного гладіатора"
    t[255379] = "Шовкові черевики галактичного гладіатора"
    t[255380] = "Шовкові рукавиці галактичного гладіатора"
    t[255381] = "Шовкові обмотки на руки галактичного гладіатора"
    t[255382] = "Шовковий каптур галактичного гладіатора"
    t[255383] = "Шовкова личина галактичного гладіатора"
    t[255384] = "Шовкові поножі галактичного гладіатора"
    t[255385] = "Шовкові штани галактичного гладіатора"
    t[255386] = "Шовкова мантія галактичного гладіатора"
    t[255387] = "Шовковий амікт галактичного гладіатора"
    t[255388] = "Шовковий шнур галактичного гладіатора"
    t[255389] = "Шовковий пояс галактичного гладіатора"
    t[255390] = "Шовкові напульсники галактичного гладіатора"
    t[255391] = "Шовкові нарукавники галактичного гладіатора"
    t[255392] = "Плащ галактичного гладіатора"
    t[255393] = "Накидка галактичного гладіатора"
    t[255394] = "Шаль галактичного гладіатора"
    t[255395] = "Шовкове вбрання галактичного гладіатора"
    t[255396] = "Шовкові шати галактичного гладіатора"
    t[255397] = "Шовкові капці галактичного гладіатора"
    t[255398] = "Шовкові черевики галактичного гладіатора"
    t[255399] = "Шовкові рукавиці галактичного гладіатора"
    t[255400] = "Шовкові обмотки на руки галактичного гладіатора"
    t[255401] = "Шовковий каптур галактичного гладіатора"
    t[255402] = "Шовкова личина галактичного гладіатора"
    t[255404] = "Шовкові поножі галактичного гладіатора"
    t[255405] = "Шовкові штани галактичного гладіатора"
    t[255406] = "Шовкова мантія галактичного гладіатора"
    t[255407] = "Шовковий амікт галактичного гладіатора"
    t[255408] = "Шовковий шнур галактичного гладіатора"
    t[255409] = "Шовковий пояс галактичного гладіатора"
    t[255410] = "Шовкові напульсники галактичного гладіатора"
    t[255411] = "Шовкові нарукавники галактичного гладіатора"
    t[255412] = "Плащ галактичного гладіатора"
    t[255413] = "Накидка галактичного гладіатора"
    t[255414] = "Шаль галактичного гладіатора"
    t[255415] = "Шкіряний жилет галактичного гладіатора"
    t[255416] = "Шкіряне вбрання галактичного гладіатора"
    t[255417] = "Шкіряні чоботи галактичного гладіатора"
    t[255418] = "Шкіряні черевики галактичного гладіатора"
    t[255419] = "Шкіряні рукавиці галактичного гладіатора"
    t[255420] = "Шкіряні рукавички галактичного гладіатора"
    t[255421] = "Шкіряний шолом галактичного гладіатора"
    t[255422] = "Шкіряна маска галактичного гладіатора"
    t[255423] = "Шкіряні штани галактичного гладіатора"
    t[255424] = "Шкіряні обмотки на ноги галактичного гладіатора"
    t[255425] = "Шкіряні наплічні галактичного гладіатора"
    t[255426] = "Шкіряні наплічники галактичного гладіатора"
    t[255427] = "Шкіряний пояс галактичного гладіатора"
    t[255428] = { name = "Лікарська торба Толбані", fen = "A waterproof satchel woven from river reeds, packed with poultices and salves.", fua = "Водонепроникна торба, сплетена з річкового очерету, напхана припарками й мазями." }
    t[255429] = "Шкіряний ремінь галактичного гладіатора"
    t[255430] = "Шкіряні наручні обмотки галактичного гладіатора"
    t[255431] = "Шкіряні зап'ястки галактичного гладіатора"
    t[255432] = "Плащ галактичного гладіатора"
    t[255433] = "Накидка галактичного гладіатора"
    t[255434] = "Шаль галактичного гладіатора"
    t[255435] = "Шкіряний жилет галактичного гладіатора"
    t[255436] = "Шкіряний камзол галактичного гладіатора"
    t[255437] = "Шкіряні чоботи галактичного гладіатора"
    t[255438] = "Шкіряні черевики галактичного гладіатора"
    t[255439] = "Шкіряні рукавиці галактичного гладіатора"
    t[255440] = "Шкіряні рукавички галактичного гладіатора"
    t[255441] = "Шкіряний шолом галактичного гладіатора"
    t[255442] = "Шкіряна маска галактичного гладіатора"
    t[255443] = "Шкіряні штани галактичного гладіатора"
    t[255444] = "Шкіряні обмотки на ноги галактичного гладіатора"
    t[255445] = "Шкіряні наплічні галактичного гладіатора"
    t[255446] = "Шкіряні наплічники галактичного гладіатора"
    t[255447] = "Шкіряний пояс галактичного гладіатора"
    t[255448] = "Шкіряний ремінь галактичного гладіатора"
    t[255449] = "Шкіряні наручні обмотки галактичного гладіатора"
    t[255450] = "Шкіряні зап'ястки галактичного гладіатора"
    t[255451] = "Плащ галактичного гладіатора"
    t[255452] = "Накидка галактичного гладіатора"
    t[255453] = "Шаль галактичного гладіатора"
    t[255454] = "Шкіряний жилет галактичного гладіатора"
    t[255455] = "Шкіряний камзол галактичного гладіатора"
    t[255456] = "Шкіряні чоботи галактичного гладіатора"
    t[255457] = "Шкіряні черевики галактичного гладіатора"
    t[255458] = "Шкіряні рукавиці галактичного гладіатора"
    t[255459] = "Шкіряні рукавички галактичного гладіатора"
    t[255460] = "Шкіряний шолом галактичного гладіатора"
    t[255461] = "Шкіряна маска галактичного гладіатора"
    t[255462] = "Шкіряні штани галактичного гладіатора"
    t[255463] = "Шкіряні обмотки на ноги галактичного гладіатора"
    t[255464] = "Шкіряні наплічні галактичного гладіатора"
    t[255465] = "Шкіряні наплічники галактичного гладіатора"
    t[255466] = "Шкіряний пояс галактичного гладіатора"
    t[255467] = "Шкіряний ремінь галактичного гладіатора"
    t[255468] = "Шкіряні наручні обмотки галактичного гладіатора"
    t[255469] = "Шкіряні зап'ястки галактичного гладіатора"
    t[255470] = "Плащ галактичного гладіатора"
    t[255471] = "Накидка галактичного гладіатора"
    t[255472] = "Шаль галактичного гладіатора"
    t[255473] = "Шкіряний жилет галактичного гладіатора"
    t[255474] = "Шкіряний камзол галактичного гладіатора"
    t[255475] = "Шкіряні чоботи галактичного гладіатора"
    t[255476] = "Шкіряні черевики галактичного гладіатора"
    t[255477] = "Шкіряні рукавиці галактичного гладіатора"
    t[255478] = "Шкіряні рукавички галактичного гладіатора"
    t[255479] = "Шкіряний шолом галактичного гладіатора"
    t[255480] = "Шкіряна маска галактичного гладіатора"
    t[255481] = "Шкіряні штани галактичного гладіатора"
    t[255482] = "Шкіряні обмотки на ноги галактичного гладіатора"
    t[255483] = "Шкіряні наплічні галактичного гладіатора"
    t[255484] = "Шкіряні наплічники галактичного гладіатора"
    t[255485] = "Шкіряний пояс галактичного гладіатора"
    t[255486] = "Шкіряний ремінь галактичного гладіатора"
    t[255487] = "Шкіряні наручні обмотки галактичного гладіатора"
    t[255488] = "Шкіряні зап'ястки галактичного гладіатора"
    t[255489] = "Плащ галактичного гладіатора"
    t[255490] = "Накидка галактичного гладіатора"
    t[255491] = "Шаль галактичного гладіатора"
    t[255492] = "Броньована луска галактичного гладіатора"
    t[255493] = "Лусковий захист галактичного гладіатора"
    t[255494] = "Кольчужні сабатони галактичного гладіатора"
    t[255495] = "Кольчужні чоботи галактичного гладіатора"
    t[255496] = "Кольчужні рукавиці галактичного гладіатора"
    t[255497] = "Кольчужні наручні галактичного гладіатора"
    t[255498] = "Кольчужний шолом галактичного гладіатора"
    t[255499] = "Кольчужне забрало галактичного гладіатора"
    t[255500] = "Кольчужні поножі галактичного гладіатора"
    t[255501] = "Кольчужні штани галактичного гладіатора"
    t[255502] = "Кольчужні наплічники галактичного гладіатора"
    t[255503] = "Кольчужний наплічний захист галактичного гладіатора"
    t[255504] = "Кольчужний пояс галактичного гладіатора"
    t[255505] = "Кольчужний пояс галактичного гладіатора"
    t[255506] = "Кольчужні зап'ястки галактичного гладіатора"
    t[255507] = "Кольчужні наручі галактичного гладіатора"
    t[255508] = "Плащ галактичного гладіатора"
    t[255509] = "Накидка галактичного гладіатора"
    t[255510] = "Шаль галактичного гладіатора"
    t[255511] = "Кольчужний жилет галактичного гладіатора"
    t[255512] = "Кольчужна туніка галактичного гладіатора"
    t[255513] = "Кольчужні сабатони галактичного гладіатора"
    t[255514] = "Кольчужні чоботи галактичного гладіатора"
    t[255515] = "Кольчужні рукавиці галактичного гладіатора"
    t[255516] = "Кольчужні наручні галактичного гладіатора"
    t[255517] = "Кольчужний шолом галактичного гладіатора"
    t[255518] = "Кольчужне забрало галактичного гладіатора"
    t[255519] = "Кольчужні поножі галактичного гладіатора"
    t[255520] = "Кольчужні штани галактичного гладіатора"
    t[255521] = "Кольчужні наплічники галактичного гладіатора"
    t[255522] = "Кольчужний наплічний захист галактичного гладіатора"
    t[255523] = "Кольчужний пояс галактичного гладіатора"
    t[255524] = "Кольчужний пояс галактичного гладіатора"
    t[255525] = "Кольчужні зап'ястки галактичного гладіатора"
    t[255526] = "Кольчужні наручі галактичного гладіатора"
    t[255527] = "Плащ галактичного гладіатора"
    t[255528] = "Накидка галактичного гладіатора"
    t[255529] = "Шаль галактичного гладіатора"
    t[255530] = "Кольчужний жилет галактичного гладіатора"
    t[255531] = "Кольчужна туніка галактичного гладіатора"
    t[255532] = "Кольчужні сабатони галактичного гладіатора"
    t[255533] = "Кольчужні чоботи галактичного гладіатора"
    t[255534] = "Кольчужні рукавиці галактичного гладіатора"
    t[255535] = "Кольчужні наручні галактичного гладіатора"
    t[255536] = "Кольчужний шолом галактичного гладіатора"
    t[255537] = "Кольчужне забрало галактичного гладіатора"
    t[255538] = "Кольчужні поножі галактичного гладіатора"
    t[255539] = "Кольчужні штани галактичного гладіатора"
    t[255540] = "Кольчужні наплічники галактичного гладіатора"
    t[255541] = "Кольчужний наплічний захист галактичного гладіатора"
    t[255542] = "Кольчужний пояс галактичного гладіатора"
    t[255543] = "Кольчужний пояс галактичного гладіатора"
    t[255544] = "Кольчужні зап'ястки галактичного гладіатора"
    t[255545] = "Кольчужні наручі галактичного гладіатора"
    t[255546] = "Плащ галактичного гладіатора"
    t[255547] = "Накидка галактичного гладіатора"
    t[255548] = "Шаль галактичного гладіатора"
    t[255549] = "Нагрудний захист галактичного гладіатора"
    t[255550] = "Нагрудник галактичного гладіатора"
    t[255551] = "Латні бойові чоботи галактичного гладіатора"
    t[255552] = "Латні чоботиська галактичного гладіатора"
    t[255553] = "Латні рукавиці галактичного гладіатора"
    t[255554] = "Латні наручні галактичного гладіатора"
    t[255555] = "Латний шолом галактичного гладіатора"
    t[255556] = "Латна каска галактичного гладіатора"
    t[255557] = "Латний захист ніг галактичного гладіатора"
    t[255558] = "Латні бойові поножі галактичного гладіатора"
    t[255559] = "Латні плечі галактичного гладіатора"
    t[255560] = "Латні наплічники галактичного гладіатора"
    t[255561] = "Латний пояс галактичного гладіатора"
    t[255562] = "Латний широкий пояс галактичного гладіатора"
    t[255563] = "Латні зап'ястки галактичного гладіатора"
    t[255564] = "Латні наручі галактичного гладіатора"
    t[255565] = "Плащ галактичного гладіатора"
    t[255566] = "Накидка галактичного гладіатора"
    t[255567] = "Шаль галактичного гладіатора"
    t[255568] = "Нагрудний захист галактичного гладіатора"
    t[255569] = "Нагрудник галактичного гладіатора"
    t[255570] = "Латні бойові чоботи галактичного гладіатора"
    t[255571] = "Латні чоботиська галактичного гладіатора"
    t[255572] = "Латні рукавиці галактичного гладіатора"
    t[255573] = "Латні наручні галактичного гладіатора"
    t[255574] = "Латний шолом галактичного гладіатора"
    t[255575] = "Латна каска галактичного гладіатора"
    t[255576] = "Латний захист ніг галактичного гладіатора"
    t[255577] = { name = "Брунька хлороцероса", fen = "The bud that grows on the back of a violet chloroceros bull. It is the orchid hydra's favorite meal.", fua = "Брунька, що росте на спині фіолетового бика-хлороцероса. Улюблена страва орхідейної гідри." }
    t[255578] = "Латні набедреники галактичного гладіатора"
    t[255579] = "Латні плечі галактичного гладіатора"
    t[255580] = "Латні наплічники галактичного гладіатора"
    t[255581] = "Латний пояс галактичного гладіатора"
    t[255582] = "Латний широкий пояс галактичного гладіатора"
    t[255583] = "Латні зап'ястки галактичного гладіатора"
    t[255584] = "Латні наручі галактичного гладіатора"
    t[255585] = "Плащ галактичного гладіатора"
    t[255586] = "Накидка галактичного гладіатора"
    t[255587] = "Шаль галактичного гладіатора"
    t[255588] = "Нагрудний захист галактичного гладіатора"
    t[255589] = "Нагрудник галактичного гладіатора"
    t[255590] = "Латні бойові чоботи галактичного гладіатора"
    t[255591] = "Латні чоботиська галактичного гладіатора"
    t[255592] = "Латні рукавиці галактичного гладіатора"
    t[255593] = "Латні наручні галактичного гладіатора"
    t[255594] = "Латний шолом галактичного гладіатора"
    t[255595] = "Латна каска галактичного гладіатора"
    t[255596] = "Латний захист ніг галактичного гладіатора"
    t[255597] = "Латні бойові поножі галактичного гладіатора"
    t[255598] = "Латні плечі галактичного гладіатора"
    t[255599] = "Латні наплічники галактичного гладіатора"
    t[255600] = "Латний пояс галактичного гладіатора"
    t[255601] = "Латний широкий пояс галактичного гладіатора"
    t[255602] = "Латні зап'ястки галактичного гладіатора"
    t[255603] = "Латні наручі галактичного гладіатора"
    t[255604] = "Плащ галактичного гладіатора"
    t[255605] = "Накидка галактичного гладіатора"
    t[255606] = "Шаль галактичного гладіатора"
    t[255607] = "Перстень галактичного гладіатора"
    t[255608] = "Перстень галактичного гладіатора"
    t[255609] = "Перстень-печатка галактичного гладіатора"
    t[255610] = "Намисто галактичного гладіатора"
    t[255611] = "Підвіска галактичного гладіатора"
    t[255612] = "Амулет галактичного гладіатора"
    t[255613] = "Знак лютості галактичного гладіатора"
    t[255614] = "Знак запалу галактичного гладіатора"
    t[255615] = "Емблема галактичного гладіатора"
    t[255616] = "Медальйон галактичного гладіатора"
    t[255617] = "Печатка пристосування галактичного гладіатора"
    t[255619] = "Кинджал галактичного гладіатора"
    t[255620] = "Бойова глефа галактичного гладіатора"
    t[255621] = "Древкова зброя галактичного гладіатора"
    t[255622] = "Посох галактичного гладіатора"
    t[255623] = "Лук галактичного гладіатора"
    t[255624] = "Скіпетр галактичного гладіатора"
    t[255625] = "Фоліант галактичного гладіатора"
    t[255626] = "Щит галактичного гладіатора"
    t[255627] = "Молот галактичного гладіатора"
    t[255628] = "Розбитий клинок галактичного гладіатора"
    t[255629] = "Тесак галактичного гладіатора"
    t[255630] = "Бластер галактичного гладіатора"
    t[255631] = "Великий посох галактичного гладіатора"
    t[255632] = "Бастіон галактичного гладіатора"
    t[255633] = "Великий меч галактичного гладіатора"
    t[255634] = "Моргенштерн галактичного гладіатора"
    t[255635] = "Меч галактичного гладіатора"
    t[255636] = "Гладіус галактичного гладіатора"
    t[255637] = "Бойовий посох галактичного гладіатора"
    t[255638] = "Осередок галактичного гладіатора"
    t[255639] = "Булава галактичного гладіатора"
    t[255666] = { name = "Велика торба загального товару Опівночі", fen = "Contains many common reagents shared between all professions. Still missing something? Check a nearby vendor!", fua = "Містить багато звичайних реагентів, спільних для всіх професій. Усе ще чогось бракує? Завітай до найближчого торговця!" }
    t[255671] = { name = "Жетон зброї галактичного гладіатора", fen = "Proof of your prowess on the battlefield. Can be exchanged for gladiator weapons at Falconwing Square in Silvermoon.", fua = "Доказ твоєї звитяги на полі бою. Можна обміняти на зброю гладіатора на площі Соколиного Крила в Сільвермуні." }
    t[255678] = { name = "Велика торба трав Опівночі", fen = "Tons of flowers to save you oodles of hours!", fua = "Купа квітів, щоб заощадити тобі купу годин!" }
    t[255679] = { name = "Велика торба мінералів Опівночі", fen = "Ore-n't you glad you don't have to mine this yourself?", fua = "Хіба не камінь з душі, що тобі не довелося видобувати це самотужки?" }
    t[255680] = { name = "Забутий пазур", fen = "Weathered and broken, yet still so sharp it could serve as a blade, and so large that one could believe it once belonged to an eagle as mighty as Akil'zon.", fua = "Побитий негодою й надламаний, та все ще такий гострий, що міг би слугувати клинком, і такий великий, що можна повірити, ніби він колись належав орлові, могутньому, як Акіл'зон." }
    t[255681] = { name = "Загублена сторінка з компендіуму Ностро", fen = "The intact parchment is only slightly curled from age, but the ink is hopelessly blotched and faded, making the page unreadable. Perhaps a professional could restore it.", fua = "Уцілілий пергамент лише трохи покоробився від часу, але чорнило безнадійно розпливлося й вицвіло, через що сторінка нечитабельна. Можливо, фахівець зміг би її відновити." }
    t[255682] = { name = "Велика торба шкур Опівночі", fen = "If you're not skinning you're not winning.", fua = "Хто не білує — той не виграє." }
    t[255683] = { name = "Велика торба ювелірного товару Опівночі", fen = "Contains nearly everything to craft anything, assuming you're a Jewelcrafter.", fua = "Містить майже все потрібне, щоб виготовити будь-що, якщо ти ювелір." }
    t[255684] = { name = "Велика торба шкіряного товару Опівночі", fen = "Contains nearly everything to craft anything, assuming you're a Leatherworker.", fua = "Містить майже все потрібне, щоб виготовити будь-що, якщо ти чинбар." }
    t[255685] = { name = "Кишеньковий годинник Лан'далока", fen = "There's an inscription inside the casing that reads, \"Time is our most precious gift.\"", fua = "Усередині корпусу є напис: «Час — наш найдорожчий дар»." }
    t[255686] = { name = "Велика торба алхімічного товару Опівночі", fen = "Contains nearly everything to craft anything, assuming you're an Alchemist.", fua = "Містить майже все потрібне, щоб виготовити будь-що, якщо ти алхімік." }
    t[255687] = { name = "Велика торба додаткового товару Опівночі", fen = "Contains all of the stuff you could choose to ignore, but decided not to.", fua = "Містить усе те, що ти міг би й проігнорувати, але вирішив цього не робити." }
    t[255688] = { name = "Якір Безодні", fen = "Though now serving as an anchor, the cleaver-like silhouette of this immense weight, with its unforgiving edge, strongly suggests a more violent former life.", fua = "Хоч тепер він і слугує якорем, тесакоподібний силует цього величезного тягаря з безжальним лезом виразно натякає на куди жорстокіше минуле." }
    t[255689] = { name = "Велика торба інженерного товару Опівночі", fen = "Contains nearly everything to craft anything, assuming you're an Engineer.", fua = "Містить майже все потрібне, щоб виготовити будь-що, якщо ти інженер." }
    t[255690] = { name = "Велика торба товару для накладання чарів Опівночі", fen = "Contains nearly everything to craft anything, assuming you're an Enchanter.", fua = "Містить майже все потрібне, щоб виготовити будь-що, якщо ти зачарувальник." }
    t[255691] = { name = "Велика торба кравецького товару Опівночі", fen = "Contains nearly everything to craft anything, assuming you're a Tailor.", fua = "Містить майже все потрібне, щоб виготовити будь-що, якщо ти кравець." }
    t[255703] = { name = "Велика торба ковальського товару Опівночі", fen = "Contains nearly everything to craft anything, assuming you're a Blacksmith.", fua = "Містить майже все потрібне, щоб виготовити будь-що, якщо ти володієш ковальством." }
    t[255704] = { name = "Велика торба товару для письма Опівночі", fen = "Contains nearly everything to craft anything, assuming you're a Scribe.", fua = "Містить майже все потрібне, щоб виготовити будь-що, якщо ти писар." }
    t[255825] = { name = "Знешкоджена пастка", fen = "Your prey's failure is your advantage.", fua = "Невдача твоєї здобичі — твоя перевага." }
    t[255826] = { name = "Таємничі небесні скалки", fen = "These shards of luminous glass reflect the light of the Goddess' song. They remind you of your adventures with Kuri in Har'kuai.", fua = "Ці скалки осяйного скла відбивають світло пісні Богині. Вони нагадують тобі про пригоди з Курі в Гар'куаї." }
    t[255828] = { name = "Цілком таємний посібник старшого професора Інструктавра з алхімії Опівночі", fen = "Go on, take a peek! Nobody's watching.", fua = "Ну ж бо, зазирни! Ніхто не бачить." }
    t[255829] = { name = "Цілком таємний посібник старшого професора Інструктавра з ковальства Опівночі", fen = "Go on, take a peek! Nobody's watching.", fua = "Ну ж бо, зазирни! Ніхто не бачить." }
    t[255830] = { name = "Цілком таємний посібник старшого професора Інструктавра з накладання чарів Опівночі", fen = "Go on, take a peek! Nobody's watching.", fua = "Ну ж бо, зазирни! Ніхто не бачить." }
    t[255831] = { name = "Цілком таємний посібник старшого професора Інструктавра з інженерії Опівночі", fen = "Go on, take a peek! Nobody's watching.", fua = "Ну ж бо, зазирни! Ніхто не бачить." }
    t[255832] = { name = "Цілком таємний посібник старшого професора Інструктавра з травництва Опівночі", fen = "Go on, take a peek! Nobody's watching.", fua = "Ну ж бо, зазирни! Ніхто не бачить." }
    t[255833] = { name = "Цілком таємний посібник старшого професора Інструктавра з накреслення Опівночі", fen = "Go on, take a peek! Nobody's watching.", fua = "Ну ж бо, зазирни! Ніхто не бачить." }
    t[255834] = { name = "Цілком таємний посібник старшого професора Інструктавра з ювелірства Опівночі", fen = "Go on, take a peek! Nobody's watching.", fua = "Ну ж бо, зазирни! Ніхто не бачить." }
    t[255835] = { name = "Цілком таємний посібник старшого професора Інструктавра з шкіряної справи Опівночі", fen = "Go on, take a peek! Nobody's watching.", fua = "Ну ж бо, зазирни! Ніхто не бачить." }
    t[255836] = { name = "Цілком таємний посібник старшого професора Інструктавра з гірництва Опівночі", fen = "Go on, take a peek! Nobody's watching.", fua = "Ну ж бо, зазирни! Ніхто не бачить." }
    t[255837] = { name = "Цілком таємний посібник старшого професора Інструктавра з білування Опівночі", fen = "Go on, take a peek! Nobody's watching.", fua = "Ну ж бо, зазирни! Ніхто не бачить." }
    t[255838] = { name = "Цілком таємний посібник старшого професора Інструктавра з кравецтва Опівночі", fen = "Go on, take a peek! Nobody's watching.", fua = "Ну ж бо, зазирни! Ніхто не бачить." }
    t[255842] = { name = "Тренувальний жезл Перетворення", fen = "Governing sigils are carved into the wood, preventing students from using it too often or for too long.", fua = "У дереві вирізьблені керівні сигіли, що не дають учням використовувати його надто часто чи надто довго." }
    t[255843] = { name = "HU5H, безтурботне цуценя", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[255844] = { name = "HU5H, безтурботне цуценя", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[255845] = "Парад Сільвермуна"
    t[255846] = "Свято Гарандара"
    t[255847] = "Неймовірно королівська печеня"
    t[255848] = "Шал флори"
    t[255879] = "Прапорець галактичної легенди"
    t[255882] = "Одіж галактичного паліжвійни"
    t[255883] = "Капці галактичного паліжвійни"
    t[255884] = "Рукавиці галактичного паліжвійни"
    t[255885] = "Маска галактичного паліжвійни"
    t[255886] = "Штани галактичного паліжвійни"
    t[255887] = "Шнур галактичного паліжвійни"
    t[255888] = "Обв'язки галактичного паліжвійни"
    t[255889] = "Наплічник галактичного паліжвійни"
    t[255890] = "Чоботи галактичного паліжвійни"
    t[255891] = "Намотки на руки галактичного паліжвійни"
    t[255892] = "Каптур галактичного паліжвійни"
    t[255893] = "Бриджі галактичного паліжвійни"
    t[255894] = "Пояс галактичного паліжвійни"
    t[255895] = "Намотки галактичного паліжвійни"
    t[255896] = "Куртка галактичного паліжвійни"
    t[255897] = "Наплічний захист галактичного паліжвійни"
    t[255898] = "Заборало галактичного паліжвійни"
    t[255899] = "Кіраса галактичного паліжвійни"
    t[255900] = "Сабатони галактичного паліжвійни"
    t[255901] = "Латні рукавиці галактичного паліжвійни"
    t[255902] = "Поножі галактичного паліжвійни"
    t[255903] = "Наплічники галактичного паліжвійни"
    t[255904] = "Застібка галактичного паліжвійни"
    t[255905] = "Наручні галактичного паліжвійни"
    t[255906] = "Нагрудник галактичного паліжвійни"
    t[255907] = "Поножі галактичного паліжвійни"
    t[255908] = "Рукавиці-хвати галактичного паліжвійни"
    t[255909] = "Шолом галактичного паліжвійни"
    t[255910] = "Легінси галактичного паліжвійни"
    t[255911] = "Еполети галактичного паліжвійни"
    t[255912] = "Опасок галактичного паліжвійни"
    t[255913] = "Наручі галактичного паліжвійни"
    t[255914] = "Плащ галактичного паліжвійни"
    t[255915] = "Шаль галактичного паліжвійни"
    t[255916] = "Накидка галактичного паліжвійни"
    t[255917] = "Покрив галактичного паліжвійни"
    t[255918] = "Бойова сокира галактичного паліжвійни"
    t[255919] = "Сокирка галактичного паліжвійни"
    t[255920] = "Різак галактичного паліжвійни"
    t[255921] = "Довгий лук галактичного паліжвійни"
    t[255922] = "Двоклинок галактичного паліжвійни"
    t[255923] = "Ліхтар галактичного паліжвійни"
    t[255924] = "Вістря галактичного паліжвійни"
    t[255925] = "Бойовий посох галактичного паліжвійни"
    t[255926] = "Великий меч галактичного паліжвійни"
    t[255927] = "Широкий меч галактичного паліжвійни"
    t[255928] = "Булава галактичного паліжвійни"
    t[255929] = "Молот галактичного паліжвійни"
    t[255930] = "Кий галактичного паліжвійни"
    t[255931] = "Егіда галактичного паліжвійни"
    t[255932] = "Спис-протикач галактичного паліжвійни"
    t[255933] = "Спис галактичного паліжвійни"
    t[255934] = "Жезл галактичного паліжвійни"
    t[255935] = "Булава галактичного паліжвійни"
    t[255936] = "Трощило галактичного паліжвійни"
    t[255937] = "Скіпетр галактичного паліжвійни"
    t[255938] = "Кинджал галактичного паліжвійни"
    t[255939] = "Стилет галактичного паліжвійни"
    t[255968] = "Прапорець легенди Нічної Пітьми"
    t[255969] = "Прапорець стратега Нічної Пітьми"
    t[256055] = { name = "Переповнений скарб гара'ті", fen = "Contains a variety of rewards for those who have proven themselves true allies of the Hara'ti.", fua = "Містить різноманітні нагороди для тих, хто довів, що є справжнім союзником гара'ті." }
    t[256135] = { name = "Просякнута Світлом трутниця", fen = "Callum's tinder box, infused with the last of Anais's Light.", fua = "Трутниця Калума, просякнута рештками Світла Анаїс." }
    t[256136] = { name = "Мозок професора Інструктавра щодо Опівночі", fen = "And now you know why Senior Professor Instructaur has been helping you all this time.", fua = "І тепер ти знаєш, чому старший професор Інструктавр допомагав тобі весь цей час." }
    t[256138] = { name = "Гар'ольд", fen = "Orweyna has a happy rock friend? So many questions, no time to ask.", fua = "В Орвейни є щасливий кам'яний друг? Стільки питань, а часу їх поставити немає." }
    t[256143] = { name = "Дерев'яна ложка", fen = "An old wooden spoon that have seen better days. The name \"Orweyna\" is carved on its side.", fua = "Стара дерев'яна ложка, що бачила кращі часи. На боці вирізьблено ім'я \"Орвейна\"." }
    t[256144] = { name = "Кістяний Гребінь", fen = "A comb made of thick bone and dulled talons.", fua = "Гребінь із товстої кістки та затуплених пазурів." }
    t[256145] = { name = "Пташиний свисток", fen = "A beautifully carved bird whistle, most likely used to lure prey during a hunt.", fua = "Чудово вирізьблений пташиний свисток, найімовірніше, для приваблювання здобичі під час полювання." }
    t[256164] = { name = "Зламане весло", fen = "Its shaft splintered and its head long dulled, yet something about its balance and heft speaks of a weapon once wielded in primal fury.", fua = "Держак розщеплений, а лопать давно затупилася, однак щось у його балансі й вазі промовляє про зброю, якою колись орудували в первісній люті." }
    t[256174] = "Маленький щит, торкнутий спорами"
    t[256175] = "Жезл, торкнутий спорами"
    t[256176] = "Шпиль мальованих спогадів"
    t[256177] = "Посох, торкнутий спорами"
    t[256178] = "Спис мальованих спогадів"
    t[256179] = "Лук Намальованих Спогадів"
    t[256180] = "Короткий лук, торкнутий спорами"
    t[256181] = "Глева мальованих спогадів"
    t[256182] = "Клинок мальованих спогадів"
    t[256183] = "Меч мальованих спогадів"
    t[256184] = "Шабля, торкнута спорами"
    t[256185] = "Кий мальованих спогадів"
    t[256186] = "Булава, торкнута спорами"
    t[256187] = "Булава мальованих спогадів"
    t[256188] = "Кий, торкнутий спорами"
    t[256189] = "Ніж намальованих спогадів"
    t[256190] = "Кинджал, торкнутий спорами"
    t[256191] = "Ручна сокира мальованих спогадів"
    t[256192] = "Обпалені Світлом наручі"
    t[256193] = "Зношений великий пояс Гарандара"
    t[256194] = "Квітучі наплічники Кіма"
    t[256195] = "Уражені Світлом поножі"
    t[256196] = "Великий шолом обпалених листків"
    t[256197] = "Латні рукавиці щепленого"
    t[256198] = "Бойові чоботи колосальних бегемотів"
    t[256199] = "Панцир, укритий альнопилом"
    t[256200] = "Загартовані манжети лаш'ра"
    t[256201] = "Пояс небажаного гостя"
    t[256202] = "Наплічники збожеволілого від Світла рутаані"
    t[256203] = "Уражені Світлом поножі"
    t[256204] = "Шолом захисника Гар'мари"
    t[256205] = "Хватки сповненого надії гараніра"
    t[256206] = "Чоботи Нескінченного Вихору"
    t[256207] = "Кіраса мандрівника Розломів"
    t[256208] = "Наручі Сонячного Вінця"
    t[256209] = "Пошарпаний пояс Ради"
    t[256210] = "Вибілені Світлом наплічники"
    t[256211] = "Уражені Світлом штани"
    t[256212] = "Капелюх гармонійного гаю"
    t[256213] = "Рукавиці, торкнуті альнопилом"
    t[256214] = "Чоботи Нескінченної Гравітації"
    t[256215] = "Запорошений камзол Он'геї"
    t[256216] = "Розвіяні ритуальні браслети"
    t[256217] = "Запасний пасок радника"
    t[256218] = "Наплічник мандрівного торговця"
    t[256219] = "Уражені Світлом легінси"
    t[256220] = "Обгорілий ковпак спорового доглядача"
    t[256221] = "Рукавиці згуртованого гараніра"
    t[256222] = "Імлисті присмеркові чоботи"
    t[256223] = "Шати потьмареного пилом Альну"
    t[256224] = "Вицвілий від світла амулет"
    t[256225] = "Кольє з коренекості"
    t[256226] = "Плащ з плетеного коріння"
    t[256227] = "Давній листяний плащ"
    t[256228] = "Перстень відкинутого поклику"
    t[256229] = "Перстень незворушного старійшини"
    t[256230] = "Великий меч мальованих спогадів"
    t[256231] = "Фальшіон, торкнутий спорами"
    t[256232] = { name = "Гроно стиглого винограду", fen = "Perfect for snacking... or stomping.", fua = "Ідеально для перекусу... або для чавлення." }
    t[256326] = "Сморідний ідол жаби-дротика"
    t[256334] = "Перстень розірваних зв'язків"
    t[256335] = "Тканий перстень-печатка Амаракка"
    t[256356] = "Кадильниця сонячного диму"
    t[256397] = { name = "Пакетик швидких дріжджів", fen = "Made in Goldenmist, this dry yeast completes the fermentation process in record time.", fua = "Виготовлені в Золотому Тумані, ці сухі дріжджі завершують бродіння за рекордний час." }
    t[256423] = { name = "Незаплямований повзун гаю", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[256424] = { name = "Відлуння Альн'шарана", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[256549] = { name = "Тіньове долото", fen = "Impossibly sharp, yet too delicate to carve anything substantial.", fua = "Неймовірно гостре, проте надто тендітне, щоб вирізьбити щось вагоме." }
    t[256552] = { name = "Зелене Насіння Рутаані", fen = "A strange seed cultivated by the Rutaani. It's not fully known what effect it has on other humanoid life.", fua = "Дивне насіння, що його вирощують рутаані. Достеменно не відомо, як воно впливає на інших гуманоїдів." }
    t[256559] = { name = "Геральдика галактичного бійця", fen = "Acquired from various PvP activities or purchased with Honor from PvP quartermasters in Silvermoon. Can be bought and sold on the Auction House.", fua = "Здобувається в різних PvP-активностях або купується за честь у PvP-інтендантів у Сільвермуні. Можна купувати та продавати на аукціоні." }
    t[256607] = { name = "Геральдика галактичного претендента", fen = "Purchased with Honor from PvP quartermasters in Silvermoon.", fua = "Купується за честь у PvP-інтендантів у Сільвермуні." }
    t[256608] = { name = "Геральдика галактичного гладіатора", fen = "Purchased with Conquest from PvP quartermasters in Silvermoon.", fua = "Купується за Завоювання в інтендантів PvP у Сільвермуні." }
    t[256613] = "Плащ старійшини Гара'ті"
    t[256614] = "Наплічники старійшини Гара'ті"
    t[256615] = "Накидка старійшини Гара'ті"
    t[256625] = { name = "Викрійка: врокоткана нитка", fen = "Teaches you how to craft Hexwoven Strand.", fua = "Навчає вас виготовляти врокоткану нитку." }
    t[256626] = { name = "Викрійка: шкіряні чоботи таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Leather Boots.", fua = "Навчає вас виготовляти шкіряні чоботи таласського змагуна." }
    t[256627] = { name = "Викрійка: шкіряний нагрудник таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Leather Chestpiece.", fua = "Навчає вас виготовляти шкіряний нагрудник таласського змагуна." }
    t[256628] = { name = "Викрійка: шкіряні рукавиці таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Leather Gloves.", fua = "Навчає вас виготовляти шкіряні рукавиці таласського змагуна." }
    t[256629] = { name = "Викрійка: шкіряні штани таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Leather Trousers.", fua = "Навчає вас виготовляти шкіряні штани таласського змагуна." }
    t[256630] = { name = "Викрійка: шкіряні наплічники таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Leather Shoulderpads.", fua = "Навчає вас виготовляти шкіряні наплічники таласського змагуна." }
    t[256631] = { name = "Викрійка: шкіряний пояс таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Leather Belt.", fua = "Навчає вас виготовляти шкіряний пояс таласського змагуна." }
    t[256632] = { name = "Викрійка: шкіряна маска таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Leather Mask.", fua = "Навчає вас виготовляти шкіряну маску таласського змагуна." }
    t[256633] = { name = "Викрійка: кольчужні чоботи таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Chain Stompers.", fua = "Навчає вас виготовляти кольчужні чоботи таласського змагуна." }
    t[256634] = { name = "Викрійка: кольчужна туніка таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Chain Tunic.", fua = "Навчає вас виготовляти кольчужну туніку таласського змагуна." }
    t[256635] = { name = "Викрійка: шкіряні обмотки на зап'ястки таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Leather Wristwraps.", fua = "Навчає вас виготовляти шкіряні обмотки на зап'ястки таласського змагуна." }
    t[256636] = { name = "Викрійка: відбивачі завулкового блукача", fen = "Teaches you how to craft Row Walker's Deflectors.", fua = "Навчає вас виготовляти відбивачі завулкового блукача." }
    t[256637] = { name = "Викрійка: наручі сокирокидача", fen = "Teaches you how to craft Axe-Flingin' Bands.", fua = "Навчає вас виготовляти наручі сокирокидача." }
    t[256638] = { name = "Викрійка: спритні рукавиці завулкового блукача", fen = "Teaches you how to craft Row Walker's Swiftgrips.", fua = "Навчає вас виготовляти спритні рукавиці завулкового блукача." }
    t[256639] = { name = "Викрійка: Кореневі обмотки Світового Дерева", fen = "Teaches you how to craft World Tree Rootwraps.", fua = "Навчає вас виготовляти Кореневі обмотки Світового Дерева." }
    t[256640] = { name = "Викрійка: захист завулкового блукача", fen = "Teaches you how to craft Row Walker's Insurance.", fua = "Навчає вас виготовляти захист завулкового блукача." }
    t[256641] = { name = "Викрійка: кольчужні поножі таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Chain Leggings.", fua = "Навчає вас виготовляти кольчужні поножі таласського змагуна." }
    t[256642] = { name = "Викрійка: первинна спорова в'язь", fen = "Teaches you how to craft Primal Spore Binding.", fua = "Навчає вас виготовляти первинну спорову в'язь." }
    t[256643] = { name = "Викрійка: кольчужні рукавиці таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Chain Grips.", fua = "Навчає вас виготовляти кольчужні рукавиці таласського змагуна." }
    t[256644] = { name = "Викрійка: кольчужні наплічники таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Chain Epaulets.", fua = "Навчає вас виготовляти кольчужні наплічники таласського змагуна." }
    t[256645] = { name = "Викрійка: благословенний амулет панґо", fen = "Teaches you how to craft Blessed Pango Charm.", fua = "Навчає вас виготовляти благословенний амулет панґо." }
    t[256646] = { name = "Викрійка: кольчужний каптур таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Chain Cowl.", fua = "Навчає вас виготовляти кольчужний каптур таласського змагуна." }
    t[256647] = { name = "Викрійка: набір броні лісового мисливця", fen = "Teaches you how to craft Forest Hunter's Armor Kit.", fua = "Навчає вас виготовляти набір броні лісового мисливця." }
    t[256649] = { name = "Викрійка: кольчужний пояс таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Chain Girdle.", fua = "Навчає вас виготовляти кольчужний пояс таласського змагуна." }
    t[256650] = { name = "Викрійка: кореневі капці доглядача світу", fen = "Teaches you how to craft World Tender's Rootslippers.", fua = "Навчає вас виготовляти кореневі капці доглядача світу." }
    t[256652] = { name = "Викрійка: стовбурна пластина доглядача світу", fen = "Teaches you how to craft World Tender's Trunkplate.", fua = "Навчає вас виготовляти стовбурну пластину доглядача світу." }
    t[256653] = { name = "Викрійка: рукавиці генерала-рейнджера", fen = "Teaches you how to craft Ranger-General's Grips.", fua = "Навчає вас виготовляти рукавиці генерала-рейнджера." }
    t[256654] = { name = "Викрійка: кольчужні нараменники таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Chain Cuffs.", fua = "Навчає вас виготовляти кольчужні нараменники таласського змагуна." }
    t[256655] = { name = "Викрійка: капелюх алхіміка сін'дорей", fen = "Teaches you how to craft Sin'dorei Alchemist's Hat.", fua = "Навчає вас виготовляти капелюх алхіміка сін'дорей." }
    t[256656] = { name = "Викрійка: кірчана застібка доглядача світу", fen = "Teaches you how to craft World Tender's Barkclasp.", fua = "Навчає вас виготовляти кірчану застібку доглядача світу." }
    t[256657] = { name = "Викрійка: убрання таласського ковача заліза", fen = "Teaches you how to craft Thalassian Ironbender's Regalia.", fua = "Навчає вас виготовляти убрання таласського ковача заліза." }
    t[256658] = { name = "Викрійка: ковпак для змішування таласського алхіміка", fen = "Teaches you how to craft Thalassian Alchemist's Mixcap.", fua = "Навчає вас виготовляти ковпак для змішування таласського алхіміка." }
    t[256659] = { name = "Викрійка: фартух майстра-коваля сін'дорей", fen = "Teaches you how to craft Sin'dorei Forgemaster's Cover.", fua = "Навчає вас виготовляти фартух майстра-коваля сін'дорей." }
    t[256660] = { name = "Викрійка: рукавиці інженера сін'дорей", fen = "Teaches you how to craft Sin'dorei Engineer's Gloves.", fua = "Навчає вас виготовляти рукавиці інженера сін'дорей." }
    t[256661] = { name = "Викрійка: рукавиці таласського майстра брухту", fen = "Teaches you how to craft Thalassian Scrapmaster's Gauntlets.", fua = "Навчає вас виготовляти рукавиці таласського майстра брухту." }
    t[256662] = { name = "Викрійка: рюкзак травника сін'дорей", fen = "Teaches you how to craft Sin'dorei Herbalist's Backpack.", fua = "Навчає вас виготовляти рюкзак травника сін'дорей." }
    t[256663] = { name = "Викрійка: колиска таласського доглядача трав", fen = "Teaches you how to craft Thalassian Herbtender's Cradle.", fua = "Навчає вас виготовляти колиску таласського доглядача трав." }
    t[256664] = { name = "Викрійка: похідний капелюх таласського шукача нетрів", fen = "Teaches you how to craft Thalassian Wildseeker's Stridercap.", fua = "Навчає вас виготовляти похідний капелюх таласського шукача нетрів." }
    t[256665] = { name = "Викрійка: блуза чинбаря сін'дорей", fen = "Teaches you how to craft Sin'dorei Leathershaper's Smock.", fua = "Навчає вас виготовляти блузу чинбаря сін'дорей." }
    t[256666] = { name = "Викрійка: сумка мисливця сін'дорей", fen = "Teaches you how to craft Sin'dorei Hunter's Pack.", fua = "Навчає вас виготовляти сумку мисливця сін'дорей." }
    t[256667] = { name = "Викрійка: великий фартух таласського гранувальника самоцвітів", fen = "Teaches you how to craft Thalassian Gemshaper's Grand Cover.", fua = "Навчає вас виготовляти великий фартух таласського гранувальника самоцвітів." }
    t[256668] = { name = "Викрійка: убрання таласського чинбаря", fen = "Teaches you how to craft Thalassian Hideshaper's Regalia.", fua = "Навчає вас виготовляти убрання таласського чинбаря." }
    t[256669] = { name = "Викрійка: наголовник вічноспівного мисливця", fen = "Teaches you how to craft Eversong Hunter's Headcover.", fua = "Навчає вас виготовляти наголовник вічноспівного мисливця." }
    t[256670] = { name = "Викрійка: фартух ювеліра сін'дорей", fen = "Teaches you how to craft Sin'dorei Jeweler's Cover.", fua = "Навчає вас виготовляти фартух ювеліра сін'дорей." }
    t[256671] = { name = "Викрійка: робоча сумка таласського шукача нетрів", fen = "Teaches you how to craft Thalassian Wildseeker's Workbag.", fua = "Навчає вас виготовляти робочу сумку таласського шукача нетрів." }
    t[256672] = { name = "Трофеї корчедінів", fen = "Gnarldin collect various items that they consider proof of their strength.", fua = "Корчедіни збирають різні речі, які вважають доказом своєї сили." }
    t[256685] = { name = "Табличка мисливця", fen = "A tablet recovered from the body of a slain hunter. Recovering it proves your strength.", fua = "Табличка, знята з тіла вбитого мисливця. Здобути її — означає довести свою силу." }
    t[256692] = { name = "В'язкий іхор", fen = "Dark, cloying ichor harvested from beasts in the Fangfall.", fua = "Темний, нудотний іхор, зібраний зі звірів Ікластого Урвища." }
    t[256694] = { name = "Кістяна Скалка", fen = "Bone fragments from an unknown beast.", fua = "Уламки кісток невідомого звіра." }
    t[256699] = { name = "Креслення: кристал зачаровувача сін'дорей", fen = "Teaches you how to craft Sin'dorei Enchanter's Crystal.", fua = "Навчає тебе виготовляти кристал зачаровувача сін'дорей." }
    t[256700] = { name = "Креслення: перстень азеротських благословень", fen = "Teaches you how to craft Signet of Azerothian Blessings.", fua = "Навчає тебе виготовляти перстень азеротських благословень." }
    t[256701] = { name = "Креслення: налаштована таласійська рунна призма", fen = "Teaches you how to craft Attuned Thalassian Rune-Prism.", fua = "Навчає тебе виготовляти налаштовану таласійську рунну призму." }
    t[256702] = { name = "Креслення: перстень таласійського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Signet.", fua = "Навчає тебе виготовляти перстень таласійського змагуна." }
    t[256703] = { name = "Креслення: окуляри писаря сін'дорей", fen = "Teaches you how to craft Sin'dorei Scribe's Spectacles.", fua = "Навчає тебе виготовляти окуляри писаря сін'дорей." }
    t[256704] = { name = "Креслення: могутній вічноспівний діамант", fen = "Teaches you how to craft Powerful Eversong Diamond.", fua = "Навчає тебе виготовляти могутній вічноспівний діамант." }
    t[256705] = { name = "Креслення: бездоганні окуляри для читання текстів", fen = "Teaches you how to craft Flawless Text Scrutinizers.", fua = "Навчає тебе виготовляти бездоганні окуляри для читання текстів." }
    t[256706] = { name = "Креслення: рішучий геліотроп", fen = "Teaches you how to craft Determined Heliotrope.", fua = "Навчає тебе виготовляти рішучий геліотроп." }
    t[256707] = { name = "Креслення: точні лупи магового ока", fen = "Teaches you how to craft Mage-Eye Precision Loupes.", fua = "Навчає тебе виготовляти точні лупи магового ока." }
    t[256708] = { name = "Креслення: телуричний вічноспівний діамант", fen = "Teaches you how to craft Telluric Eversong Diamond.", fua = "Навчає тебе виготовляти телуричний вічноспівний діамант." }
    t[256709] = { name = "Креслення: ювелірні лупи сін'дорей", fen = "Teaches you how to craft Sin'dorei Jeweler's Loupes.", fua = "Навчає тебе виготовляти ювелірні лупи сін'дорей." }
    t[256710] = { name = "Креслення: витривалий геліотроп", fen = "Teaches you how to craft Enduring Heliotrope.", fua = "Навчає тебе виготовляти витривалий геліотроп." }
    t[256711] = { name = "Креслення: кришталева лінза таласійського писаря", fen = "Teaches you how to craft Thalassian Scribe's Crystalline Lens.", fua = "Навчає тебе виготовляти кришталеву лінзу таласійського писаря." }
    t[256712] = { name = "Креслення: пізнавальний геліотроп", fen = "Teaches you how to craft Cognitive Heliotrope.", fua = "Навчає тебе виготовляти пізнавальний геліотроп." }
    t[256713] = { name = "Креслення: вдосконалена лупа для правші", fen = "Teaches you how to craft Improved Right-Handed Magnifying Glass.", fua = "Навчає тебе виготовляти вдосконалену лупу для правші." }
    t[256714] = { name = "Креслення: незбагненний вічноспівний діамант", fen = "Teaches you how to craft Indecipherable Eversong Diamond.", fua = "Навчає тебе виготовляти незбагненний вічноспівний діамант." }
    t[256715] = { name = "Креслення: таласійська гривна фенікса", fen = "Teaches you how to craft Thalassian Phoenix Torque.", fua = "Навчає тебе виготовляти таласійську гривну фенікса." }
    t[256716] = { name = "Креслення: призматична фокусувальна діафрагма", fen = "Teaches you how to craft Prismatic Focusing Iris.", fua = "Навчає тебе виготовляти призматичну фокусувальну діафрагму." }
    t[256717] = { name = "Креслення: перстень шанувальника лоа", fen = "Teaches you how to craft Loa Worshiper's Band.", fua = "Навчає тебе виготовляти перстень шанувальника лоа." }
    t[256718] = { name = "Креслення: стабілізувальний самоцвітний патронташ", fen = "Teaches you how to craft Stabilizing Gemstone Bandolier.", fua = "Навчає тебе виготовляти стабілізувальний самоцвітний патронташ." }
    t[256719] = { name = "Креслення: амулет таласійського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Amulet.", fua = "Навчає тебе виготовляти амулет таласійського змагуна." }
    t[256720] = { name = "Креслення: незворушний вічноспівний діамант", fen = "Teaches you how to craft Stoic Eversong Diamond.", fua = "Навчає тебе виготовляти незворушний вічноспівний діамант." }
    t[256721] = { name = "Креслення: захисна матриця з каменю Порожнечі", fen = "Teaches you how to craft Voidstone Shielding Array.", fua = "Навчає тебе виготовляти захисну матрицю з каменю Порожнечі." }
    t[256737] = { name = "Формула: Зачарувати нагрудник - Знак Налоракка", fen = "Teaches you how to perform the Mark of Nalorakk enchantment.", fua = "Навчає тебе, як виконати зачарування «Знак Налоракка»." }
    t[256738] = { name = "Формула: Зачарувати шолом - Підсилений врок висмоктування", fen = "Teaches you how to perform the Empowered Hex of Leeching enchantment.", fua = "Навчає тебе, як виконати зачарування «Підсилений врок висмоктування»." }
    t[256739] = { name = "Формула: Зачарувати перстень - Очі орла", fen = "Teaches you how to perform the Eyes of the Eagle enchantment.", fua = "Навчає тебе, як виконати зачарування «Очі орла»." }
    t[256740] = { name = "Формула: Зачарувати плечі - Прудкість Акіл'зона", fen = "Teaches you how to perform the Akil'zon's Swiftness enchantment.", fua = "Навчає тебе, як виконати зачарування «Прудкість Акіл'зона»." }
    t[256741] = { name = "Формула: Зачарувати зброю - Сила Галаззі", fen = "Teaches you how to perform the Strength of Halazzi enchantment.", fua = "Навчає тебе, як виконати зачарування «Сила Галаззі»." }
    t[256742] = { name = "Формула: Рунований сяйливий торієвий жезл", fen = "Teaches you how to craft Runed Dazzling Thorium Rod.", fua = "Навчає, як виготовити Рунований сяйливий торієвий жезл." }
    t[256743] = { name = "Формула: Радісний гламур — гараніри", fen = "Teaches you how to craft Gleeful Glamour - Haranir.", fua = "Навчає, як виготовити Радісний гламур — гараніри." }
    t[256744] = { name = "Формула: Зачарувати інструмент - Сприйняття амані", fen = "Teaches you how to perform the Amani Perception enchantment.", fua = "Навчає тебе, як виконати зачарування «Сприйняття амані»." }
    t[256745] = { name = "Формула: Зачарувати нагрудник - Знак вартового коренів", fen = "Teaches you how to perform the Mark of the Rootwarden enchantment.", fua = "Навчає тебе, як виконати зачарування «Знак вартового коренів»." }
    t[256746] = { name = "Формула: Зачароване лезо контрабандиста", fen = "Teaches you how to craft Smuggler's Enchanted Edge.", fua = "Навчає, як виготовити Зачароване лезо контрабандиста." }
    t[256747] = { name = "Формула: Зачарувати чоботи - Коріння Шаладрассіла", fen = "Teaches you how to perform the Shaladrassil's Roots enchantment.", fua = "Навчає тебе, як виконати зачарування «Коріння Шаладрассіла»." }
    t[256748] = { name = "Формула: Зачарувати плечі - Грація Амірдрассіла", fen = "Teaches you how to perform the Amirdrassil's Grace enchantment.", fua = "Навчає тебе, як виконати зачарування «Грація Амірдрассіла»." }
    t[256749] = { name = "Формула: Зачарувати інструмент - Багатоверстатність гараніра", fen = "Teaches you how to perform the Haranir Multicrafting enchantment.", fua = "Навчає тебе, як виконати зачарування «Багатоверстатність гараніра»." }
    t[256750] = { name = "Формула: Зачарувати зброю - Колиска Світодуші", fen = "Teaches you how to perform the Worldsoul Cradle enchantment.", fua = "Навчає тебе, як виконати зачарування «Колиска Світодуші»." }
    t[256751] = { name = "Формула: Зачарувати зброю - Завзятість Світодуші", fen = "Teaches you how to perform the Worldsoul Tenacity enchantment.", fua = "Навчає тебе, як виконати зачарування «Завзятість Світодуші»." }
    t[256752] = { name = "Формула: Зачарувати перстень - Лють природи", fen = "Teaches you how to perform the Nature's Fury enchantment.", fua = "Навчає тебе, як виконати зачарування «Лють природи»." }
    t[256753] = { name = "Формула: Зачарувати шолом - Підсилена руна уникнення", fen = "Teaches you how to perform the Empowered Rune of Avoidance enchantment.", fua = "Навчає тебе, як виконати зачарування «Підсилена руна уникнення»." }
    t[256754] = { name = "Формула: Зачарувати плечі - Обійми природи", fen = "Teaches you how to perform the Nature's Embrace enchantment.", fua = "Навчає тебе, як виконати зачарування «Обійми природи»." }
    t[256755] = { name = "Формула: Зачарувати нагрудник - Знак магістра", fen = "Teaches you how to perform the Mark of the Magister enchantment.", fua = "Навчає тебе, як виконати зачарування «Знак магістра»." }
    t[256756] = { name = "Формула: Зачарувати чоботи - Полювання далекохода", fen = "Teaches you how to perform the Farstrider's Hunt enchantment.", fua = "Навчає тебе, як виконати зачарування «Полювання далекохода»." }
    t[256757] = { name = "Формула: Зачарувати зброю - Гострота розуму рен'дорей", fen = "Teaches you how to perform the Acuity of the Ren'dorei enchantment.", fua = "Навчає тебе, як виконати зачарування «Гострота розуму рен'дорей»." }
    t[256758] = { name = "Формула: Зачарувати інструмент - Винахідливість рен'дорей", fen = "Teaches you how to perform the Ren'dorei Ingenuity enchantment.", fua = "Навчає тебе, як виконати зачарування «Винахідливість рен'дорей»." }
    t[256759] = { name = "Формула: Зачарувати зброю - Полум'я сін'дорей", fen = "Teaches you how to perform the Flames of the Sin'dorei enchantment.", fua = "Навчає тебе, як виконати зачарування «Полум'я сін'дорей»." }
    t[256760] = { name = "Формула: Зачарувати перстень - Завзятість Сільвермуна", fen = "Teaches you how to perform the Silvermoon's Tenacity enchantment.", fua = "Навчає тебе, як виконати зачарування «Завзятість Сільвермуна»." }
    t[256761] = { name = "Формула: Зачарувати плечі - Торкнутий Порожнечею", fen = "Teaches you how to perform the Voidtouched enchantment.", fua = "Навчає тебе, як виконати зачарування «Торкнутий Порожнечею»." }
    t[256880] = { name = "Викрійка: тканинні наручі таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Cloth Bands.", fua = "Навчає вас виготовляти тканинні наручі таласського змагуна." }
    t[256882] = { name = "Подертий м'яч", fen = "A tattered ball that was left to the elements. If it doesn't belong to anyone, maybe you could give it away?", fua = "Подертий м'яч, кинутий напризволяще. Якщо він нікому не належить, може, ти міг би його комусь віддати?" }
    t[256884] = { name = "Викрійка: тканинний пояс таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Cloth Sash.", fua = "Навчає вас виготовляти тканинний пояс таласського змагуна." }
    t[256885] = { name = "Викрійка: тканинна туніка таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Cloth Tunic.", fua = "Навчає вас виготовляти тканинну туніку таласського змагуна." }
    t[256886] = { name = "Викрійка: тканинне взуття таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Cloth Treads.", fua = "Навчає вас виготовляти тканинне взуття таласського змагуна." }
    t[256887] = { name = "Викрійка: тканинні рукавиці таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Cloth Gloves.", fua = "Навчає вас виготовляти тканинні рукавиці таласського змагуна." }
    t[256888] = { name = "Викрійка: тканинний каптур таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Cloth Hood.", fua = "Навчає вас виготовляти тканинний каптур таласського змагуна." }
    t[256889] = { name = "Викрійка: тканинні поножі таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Cloth Leggings.", fua = "Навчає вас виготовляти тканинні поножі таласського змагуна." }
    t[256890] = { name = "Викрійка: тканинні наплічники таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Cloth Shoulderpads.", fua = "Навчає вас виготовляти тканинні наплічники таласського змагуна." }
    t[256891] = { name = "Викрійка: тканинний плащ таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Cloth Cloak.", fua = "Навчає вас виготовляти тканинний плащ таласського змагуна." }
    t[256963] = { name = "Таласька деревина", fen = "Lumber harvested from Quel'Thalas and nearby areas, as well as the wilds of Harandar.", fua = "Деревина, заготовлена в Кель'Таласі та довколишніх землях, а також у нетрях Гарандара." }
    t[256965] = "Сталекорі наручі"
    t[256966] = "Листяні обмотки речника коренів"
    t[256967] = "Манжети зеленого слідопита"
    t[256968] = "Наручі глибоколози"
    t[256969] = "Підвіска далекоходів"
    t[256970] = "Благословенне лоа намисто"
    t[256971] = "Сяйлива фенікс-пов'язка"
    t[256972] = "Вічновитка хутколоза"
    t[256973] = "Сталекорі сабатони"
    t[256974] = "Онучі речника коренів"
    t[256975] = "Поножі зеленого слідопита"
    t[256976] = "Поножі глибоколози"
    t[256977] = "Сталекорі рукавиці"
    t[256978] = "Гілки речника коренів"
    t[256979] = "Пазурі зеленого слідопита"
    t[256980] = "Рукавиці глибоколози"
    t[256981] = "Сталекорий нагрудник"
    t[256982] = "Стовбур речника коренів"
    t[256983] = "Жилет зеленого слідопита"
    t[256984] = "Нагрудна обмотка глибоколози"
    t[256985] = "Каблучка лісового мисливця"
    t[256986] = "Вінець навальної тіні"
    t[256987] = "Бастіон залізної лози"
    t[256988] = "Ліхтар світлоцвіту"
    t[256989] = "Лезастий ціпок вартового коренів"
    t[256990] = "Лезо зеленого слідопита"
    t[256991] = "Лозообвитий молот"
    t[256992] = "Кийок з гострої лози"
    t[256993] = "Шпичак зеленого слідопита"
    t[256994] = "Сталекорий шолом"
    t[256995] = "Головний убір речника коренів"
    t[256996] = "Каптур зеленого слідопита"
    t[256997] = "Комір глибоколози"
    t[256998] = "Сталекорі наплічники"
    t[256999] = "Крона речника коренів"
    t[257000] = "Трофейна мантія зеленого слідопита"
    t[257001] = "Наплічники глибоколози"
    t[257002] = "Сталекорі поножі"
    t[257003] = "Поножі речника коренів"
    t[257004] = "Наголінники зеленого слідопита"
    t[257005] = "Штани глибоколози"
    t[257006] = "Лозорозривний клеймор"
    t[257007] = "Чародійний фокус із плетива лоз"
    t[257008] = "Спис скалкошипа"
    t[257009] = "Лук глибинного мисливця"
    t[257010] = "Квітуча лозокоса"
    t[257011] = "Тернолісовий різак"
    t[257012] = "Чароклинок вартового коренів"
    t[257013] = "Зеленавий трощитель"
    t[257014] = "Скіпетр світлоцвіту"
    t[257015] = "Лозоповитий кинджал"
    t[257016] = "Січ Глибокого лісу"
    t[257017] = "Сталекорий пояс"
    t[257018] = "Корова застібка речника коренів"
    t[257019] = "Пряжка зеленого слідопита"
    t[257020] = "Пояс глибоколози"
    t[257021] = "Покрив зеленого слідопита"
    t[257022] = "Покрив глибоколози"
    t[257023] = { name = "Скриня шукача здобичі для шукача пригод", fen = "A chest containing a random piece of Adventurer equipment, supplies, gold, and a chance for professions materials.", fua = "Скриня з випадковим предметом спорядження шукача пригод, припасами, золотом і шансом на матеріали для професій." }
    t[257024] = { name = "Загублений мисливський ніж", fen = "Once a formidable blade that could swiftly end the life of any beast, now is a dull bone edge hanging together by a thin dried vines. While of no value to vendors, this blade might hold a value to its hunter.", fua = "Колись грізне лезо, що могло вмить обірвати життя будь-якого звіра, а нині — тупий уламок кістки, який тримається купи лише завдяки тонкій сухій лозі. Хоч для торговців він і нічого не вартий, для свого мисливця це лезо може мати неабияку цінність." }
    t[257026] = { name = "Ветеранська скриня Шукача Здобичі", fen = "A chest containing a random piece of Veteran equipment, supplies, gold, and a chance for professions materials.", fua = "Скриня з випадковим ветеранським спорядженням, припасами, золотом і шансом на матеріали для ремесел." }
    t[257054] = { name = "Скручена подушка", fen = "An old rolled-up pillow that was used for meditation or relaxation.", fua = "Стара скручена подушка, яку використовували для медитації чи відпочинку." }
    t[257080] = { name = "Череп із вирізьбленими рунами", fen = "A potentially magical rune prized by the gnarldin as a symbol of strength.", fua = "Можливо, магічна руна, яку корчедіни цінують як символ сили." }
    t[257081] = { name = "Закривавлений вістрям списа", fen = "A spear tip used by the gnarldin to skewer smaller beasts.", fua = "Вістря списа, яким корчедіни нанизують дрібнішу звірину." }
    t[257082] = { name = "Намисто корчедіна", fen = "A necklace belonging to a gnarldin, signifying their many victories in combat.", fua = "Намисто, що належить корчедінові й знаменує його численні перемоги в бою." }
    t[257084] = { name = "Розтрощена кора", fen = "A piece of bark used by the gnarldin as makeshift armor.", fua = "Шматок кори, що корчедіни використовують як саморобну броню." }
    t[257085] = { name = "Підсилений штормоскат", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[257086] = { name = "Пожовані останки", fen = "The remains of some creature. Someone thinks this is a suitable trophy.", fua = "Останки якоїсь істоти. Хтось вважає, що це гідний трофей." }
    t[257087] = { name = "Кришкий перстень", fen = "An old ring worn by a gnarldin that has crushed many skulls.", fua = "Старий перстень, що його носив корчедін, який розчавив чимало черепів." }
    t[257088] = { name = "Подертий наруч", fen = "A bracer ripped off of a slain gnarldin.", fua = "Наруч, зірваний з убитого корчедіна." }
    t[257090] = { name = "Кістяний Пояс", fen = "A series of bones from a beast. Used by the gnarldin to signify their stature.", fua = "Низка кісток якогось звіра. Корчедіни позначають ними свій статус." }
    t[257142] = { name = "Вогняний драконояструб", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[257143] = { name = "Перидотовий драконояструб", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[257144] = { name = "Тінявий драконояструб", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[257145] = { name = "Багряний драконояструб", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[257147] = { name = "Кобальтовий драконояструб", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[257149] = { name = "Старий фоліант", fen = "Its pages brittle and its ink long faded, yet a faint, acrid scent clings to it... as if some diabolic remedy had once been brewed from its secrets.", fua = "Сторінки крихкі, а чорнило давно вицвіло, та слабкий, їдкий запах усе ще тримається на ньому... наче колись із його таємниць варили якесь диявольське вариво." }
    t[257152] = { name = "Гострокіготь амані", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[257154] = { name = "Багряний яструбоступ із Сільвермуна", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257155] = "Кріс вартового гаю"
    t[257156] = { name = "Лазуровий яструбоступ", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257158] = "Рапіра вартового гаю"
    t[257159] = "Баклер вартового гаю"
    t[257161] = "Алебарда вартового гаю"
    t[257164] = "Діадема руйнівника Порожнечі"
    t[257165] = "Шолом руйнівника Порожнечі"
    t[257166] = "Покрив руйнівника Порожнечі"
    t[257167] = "Великий шолом руйнівника Порожнечі"
    t[257169] = "Печатка руйнівника Порожнечі"
    t[257171] = "Підвіска руйнівника Порожнечі"
    t[257172] = "Накидка руйнівника Порожнечі"
    t[257173] = "Накидка-плащ руйнівника Порожнечі"
    t[257174] = "Накидка-мантія руйнівника Порожнечі"
    t[257175] = "Намітка Зламувача Порожнечі"
    t[257176] = { name = "Сутінковий Мучитель", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[257178] = "Полум'я руйнівника Порожнечі"
    t[257179] = "Накидка-мантія руйнівника Порожнечі"
    t[257180] = { name = "Повід приборканого захисника Штормаріону", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[257181] = "Наплічники руйнівника Порожнечі"
    t[257182] = "Латні наплічники руйнівника Порожнечі"
    t[257183] = "Роба руйнівника Порожнечі"
    t[257184] = "Куртка руйнівника Порожнечі"
    t[257185] = "Кіраса руйнівника Порожнечі"
    t[257186] = "Нагрудник руйнівника Порожнечі"
    t[257187] = "Наручі руйнівника Порожнечі"
    t[257188] = "Обмотки зап'ясть Зламувача Порожнечі"
    t[257189] = "Застібки руйнівника Порожнечі"
    t[257190] = "Наручні щитки руйнівника Порожнечі"
    t[257191] = { name = "Зарозумілість шукача здобичі", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[257192] = { name = "Гнів Шукача Здобичі", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[257193] = { name = "Жахіття шукача здобичі", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[257194] = { name = "Листівка Консорціуму майстрів", fen = "A notice promoting a special giveaway in Falconwing Square.", fua = "Оголошення про особливу роздачу на Соколиній площі." }
    t[257197] = { name = "Благословенна нориця амані", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257199] = { name = "Гіганто Маніс", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257200] = { name = "Утеклий панголін Візербарків", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257201] = "Мітенки руйнівника Порожнечі"
    t[257202] = "Хватки руйнівника Порожнечі"
    t[257203] = "Латні рукавиці руйнівника Порожнечі"
    t[257204] = "Наручні захисники руйнівника Порожнечі"
    t[257205] = "Пояс Зламувача Порожнечі"
    t[257206] = "Кушак руйнівника Порожнечі"
    t[257207] = "Шнур руйнівника Порожнечі"
    t[257208] = "Пряжка руйнівника Порожнечі"
    t[257209] = "Штани руйнівника Порожнечі"
    t[257210] = "Штани руйнівника Порожнечі"
    t[257212] = "Захисники ніг руйнівника Порожнечі"
    t[257213] = "Набедреник руйнівника Порожнечі"
    t[257214] = "Підошви руйнівника Порожнечі"
    t[257216] = "Кроки Зламувача Порожнечі"
    t[257217] = "Бродні Зламувача Порожнечі"
    t[257218] = "Латні чоботи руйнівника Порожнечі"
    t[257219] = { name = "Благословенний ведмідь амані", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257220] = "Перстень руйнівника Порожнечі"
    t[257223] = { name = "Бойовий ведмідь предків", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257234] = "Бойова сокира Зламувача Порожнечі"
    t[257236] = "Рунічна сокира руйнівника Порожнечі"
    t[257237] = "Довгий лук руйнівника Порожнечі"
    t[257238] = "Кинджал руйнівника Порожнечі"
    t[257239] = "Ніж руйнівника Порожнечі"
    t[257240] = { name = "Покинутий багряний бойовий кінь", fen = "Aelyse won't be needing this anymore, having renounced the Scarlet Crusade.", fua = "Ейліз більше це не знадобиться, адже вона зреклася Багряного хрестового походу." }
    t[257241] = { name = "Грудкуваті рибні тельбухи", fen = "Lumps of fish meat for feeding Amani Dragonhawks.", fua = "Грудки риб'ячого м'яса для годування драконояструбів амані." }
    t[257242] = "Ліхтар руйнівника Порожнечі"
    t[257243] = { name = "Техніка: Лампа таласійського змагальника", fen = "Teaches you how to craft Thalassian Competitor's Lamp.", fua = "Навчає вас виготовляти лампу таласійського змагальника." }
    t[257248] = "Молот руйнівника Порожнечі"
    t[257249] = "Бойова булава Зламувача Порожнечі"
    t[257250] = "Булава руйнівника Порожнечі"
    t[257251] = "Бойова сокира руйнівника Порожнечі"
    t[257252] = "Бердиш руйнівника Порожнечі"
    t[257254] = "Спис руйнівника Порожнечі"
    t[257256] = "Посох руйнівника Порожнечі"
    t[257258] = { name = "Техніка: Лук таласійського змагальника", fen = "Teaches you how to craft Thalassian Competitor's Bow.", fua = "Навчає вас виготовляти лук таласійського змагальника." }
    t[257259] = { name = "Техніка: Колона таласійського змагальника", fen = "Teaches you how to craft Thalassian Competitor's Pillar.", fua = "Навчає вас виготовляти колону таласійського змагальника." }
    t[257260] = { name = "Техніка: Емблема таласійського змагальника", fen = "Teaches you how to craft Thalassian Competitor's Emblem.", fua = "Навчає вас виготовляти емблему таласійського змагальника." }
    t[257261] = { name = "Техніка: Знак запалу таласійського змагальника", fen = "Teaches you how to craft Thalassian Competitor's Insignia of Alacrity.", fua = "Навчає вас виготовляти знак запалу таласійського змагальника." }
    t[257262] = { name = "Техніка: Медальйон таласійського змагальника", fen = "Teaches you how to craft Thalassian Competitor's Medallion.", fua = "Навчає вас виготовляти медальйон таласійського змагальника." }
    t[257269] = "Ритуальний меч руйнівника Порожнечі"
    t[257270] = "Клинок руйнівника Порожнечі"
    t[257271] = "Довгий меч руйнівника Порожнечі"
    t[257284] = "Великий меч руйнівника Порожнечі"
    t[257289] = "Глефа руйнівника Порожнечі"
    t[257298] = { name = "Схема: латні чоботи таласійського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Plate Dunkers.", fua = "Навчає виготовляти латні чоботи таласійського змагуна." }
    t[257369] = { name = "Схема: кольчужні поножі таласійського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Mail Footlinks.", fua = "Навчає виготовляти кольчужні поножі таласійського змагуна." }
    t[257370] = { name = "Схема: шкіряні шльопанці таласійського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Leather Sliders.", fua = "Навчає виготовляти шкіряні шльопанці таласійського змагуна." }
    t[257371] = { name = "Схема: тканинні шкарпетки таласійського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Cloth Tip-Toes.", fua = "Навчає виготовляти тканинні шкарпетки таласійського змагуна." }
    t[257379] = "Досвід гравця"
    t[257380] = "Досвід гравця"
    t[257381] = "Досвід гравця"
    t[257382] = "Досвід супутника"
    t[257383] = "Досвід супутника"
    t[257384] = "Досвід супутника"
    t[257386] = { name = "Важка скриня", fen = "May contain equipment, recipes, currencies, collectibles, and curios.", fua = "Може містити спорядження, рецепти, валюту, колекційні речі та дивовижі." }
    t[257387] = { name = "Щедра Важка Скриня", fen = "May contain equipment, recipes, currencies, collectibles, and curios.", fua = "Може містити спорядження, рецепти, валюту, колекційні речі та дивовижі." }
    t[257407] = { name = "Схема: латні наручі таласійського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Plate Bindings.", fua = "Навчає виготовляти латні наручі таласійського змагуна." }
    t[257408] = { name = "Схема: латний наголовник таласійського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Plate Guard.", fua = "Навчає виготовляти латний наголовник таласійського змагуна." }
    t[257410] = { name = "Схема: тканинні манжети таласійського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Cloth Cuffs.", fua = "Навчає виготовляти тканинні манжети таласійського змагуна." }
    t[257411] = { name = "Схема: тканинні окуляри таласійського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Cloth Goggles.", fua = "Навчає виготовляти тканинні окуляри таласійського змагуна." }
    t[257413] = { name = "Схема: шкіряні пов'язки таласійського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Leather Bands.", fua = "Навчає виготовляти шкіряні пов'язки таласійського змагуна." }
    t[257414] = { name = "Схема: шкіряні окуляри таласійського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Leather Optics.", fua = "Навчає виготовляти шкіряні окуляри таласійського змагуна." }
    t[257415] = { name = "Схема: кольчужні ланки таласійського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Mail Links", fua = "Навчає виготовляти кольчужні ланки таласійського змагуна." }
    t[257416] = { name = "Схема: кольчужне забрало таласійського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Mail Visor.", fua = "Навчає виготовляти кольчужне забрало таласійського змагуна." }
    t[257417] = { name = "Рецепт: Лютий таласійський флакон честі", fen = "Teaches you how to create a Vicious Midnight Flask of Honor.", fua = "Навчає вас створювати лютий опівнічний флакон честі." }
    t[257420] = "Шпилевий фонтан Сільвермуна"
    t[257444] = { name = "Заврочений орел Лихопера", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[257445] = { name = "Ненажерлива дрантокіготь", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257446] = { name = "Повід ненаситного шматокігтя", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257447] = { name = "Крадькуватий шматокіготь", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257448] = { name = "Шалений шматокіготь", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257502] = { name = "Лютий кусючий ящір", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257504] = { name = "Лютий кусючий ящір", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[257534] = "Жезл руйнівника Порожнечі"
    t[257535] = "Галактична ювелірна оправа"
    t[257537] = "Стіна Зламувача Порожнечі"
    t[257599] = { name = "Журнал умінь: Ювелірство", fen = "A magazine depicting all the ways artisan crafters improve their skills.", fua = "Журнал, що описує всі способи, якими майстри-ремісники вдосконалюють свої вміння." }
    t[257600] = { name = "Журнал умінь: Накладання чарів", fen = "A magazine depicting all the ways artisan crafters improve their skills.", fua = "Журнал, що описує всі способи, якими майстри-ремісники вдосконалюють свої вміння." }
    t[257601] = { name = "Журнал умінь: Кравецтво", fen = "A magazine depicting all the ways artisan crafters improve their skills.", fua = "Журнал, що описує всі способи, якими майстри-ремісники вдосконалюють свої вміння." }
    t[257683] = "Порцеляновий кінчик клинка"
    t[257686] = "Кукрі руйнівника Порожнечі"
    t[257687] = "Довбня руйнівника Порожнечі"
    t[257688] = "Бойовий лук Зламувача Порожнечі"
    t[257714] = { name = "Колючий наріст", fen = "A horn-like spine protruding from the densely scaled hide of an aberration.", fua = "Рогоподібний шип, що стирчить зі щільно вкритої лускою шкіри аберації." }
    t[257715] = { name = "Клапоть щільної шкури", fen = "Tiny interlocking scales give this aberration's hide a smooth texture. This particular scrap of hide leaves the scales perfectly preserved.", fua = "Дрібні зчеплені лусочки надають шкурі цієї аберації гладкої текстури. Саме на цьому клапті луска збереглася бездоганно." }
    t[257717] = { name = "Спис ка'дані", fen = "If a hunting spear is an extension of its hunter, then the Ka'dani spear is an integral part of their being--a perfect mirror of their body, mind, and soul. --Ka'dani Silamon", fua = "Якщо мисливський спис — це продовження свого мисливця, то спис ка'дані — невід'ємна частина його єства, досконале відображення тіла, розуму й душі. — Ка'дані Сіламон" }
    t[257727] = { name = "Згущені запаси Порожнечі", fen = "A large quantity of Void energy.", fua = "Велика кількість енергії Порожнечі." }
    t[257728] = { name = "Згущений уламок Порожнечі", fen = "Crystals of pure Void energy.", fua = "Кристали чистої енергії Порожнечі." }
    t[257729] = { name = "Нуль-стабілізатор", fen = "A curious artifact capable of directing and stabilizing Void energy.", fua = "Дивний артефакт, здатний спрямовувати й стабілізувати енергію Порожнечі." }
    t[257730] = { name = "Енергіст шляху Порожнечі", fen = "A versatile relic used by domanaar artificers as a power source.", fua = "Універсальна реліквія, яку конструктори доманаарів використовують як джерело енергії." }
    t[257731] = { name = "Щипці сингулярності", fen = "Used for grasping and manipulating the raw power of a singularity.", fua = "Призначені, щоб ухопити й приборкати сиру силу сингулярності." }
    t[257735] = { name = "B0P, Хранитель Вибухів", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[257736] = { name = "Покликаний Світлом Камінь Повернення", fen = "Remember the Sunwell.", fua = "Пам'ятай про Сонячний Колодязь." }
    t[257741] = { name = "B0P, Хранитель Вибухів", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[257745] = "Соколине око далекоходів"
    t[257746] = "Соколине око далекоходів"
    t[257747] = "Рисяче око контрабандиста"
    t[257748] = "Рисяче око контрабандиста"
    t[257749] = "Отруєні швидкостріли"
    t[257750] = "Отруєні швидкостріли"
    t[257751] = "Обважнені вибухові заряди"
    t[257752] = "Обважнені вибухові заряди"
    t[257755] = "Свята стрибуча ручна граната"
    t[257757] = { name = "Лантух запашних пісків", fen = "Filled with the scents of the sun, the earth, the wind, the ocean, and living things too stubborn to leave.", fua = "Сповнений ароматів сонця, землі, вітру, океану та живих створінь, надто впертих, щоб піти." }
    t[257768] = "Загублений у часі указ"
    t[257866] = "Переповнений Шпиль Порожнечі"
    t[257870] = { name = "Залишок Порожнечі", fen = "A small amount of Void energy scraped from a near-empty canister.", fua = "Невелика кількість енергії Порожнечі, зішкрябана з майже порожнього резервуара." }
    t[257958] = "Забрало вартового Гара'ті"
    t[257959] = "Шапочка розвідника Гара'ті"
    t[257960] = "Шолом вартового коренів Гара'ті"
    t[257961] = "Комір коренеплясуна Гара'ті"
    t[257962] = "Наплічники вартового Гара'ті"
    t[257963] = "Нагрудник вартового Гара'ті"
    t[257964] = "Плащ вартового Гара'ті"
    t[257965] = "Наручі вартового Гара'ті"
    t[257966] = "Манжети вартового Гара'ті"
    t[257967] = "Широкий пояс вартового Гара'ті"
    t[257968] = "Набедреники вартового Гара'ті"
    t[257969] = "Поножі вартового Гара'ті"
    t[257973] = "Листя розвідника Гара'ті"
    t[257977] = { name = "Перната Дрібничка", fen = "A crudely made trinket of metal and feathers, set with a glittering green stone.", fua = "Грубо зроблена дрібничка з металу й пір'я, оздоблена блискучим зеленим камінцем." }
    t[257982] = "Туніка розвідника Гара'ті"
    t[257983] = "Плащ розвідника Гара'ті"
    t[257984] = "Зап'ясткові щитки розвідника Гара'ті"
    t[257985] = "Латні рукавиці розвідника Гара'ті"
    t[257986] = "Пояс розвідника Гара'ті"
    t[257988] = "Поножі розвідника Гара'ті"
    t[257990] = "Сабатони розвідника Гара'ті"
    t[257991] = "Кістки вартового коренів Гара'ті"
    t[257992] = "Жилет вартового коренів Гара'ті"
    t[257993] = "Накидка вартового коренів Гара'ті"
    t[257995] = "Браслет вартового коренів Гара'ті"
    t[257996] = "Пазурі вартового коренів Гара'ті"
    t[257998] = "Шнур вартового коренів Гара'ті"
    t[257999] = "Бриджі вартового коренів Гара'ті"
    t[258000] = "Підошви вартового коренів Гара'ті"
    t[258001] = "Терни коренеплясуна Гара'ті"
    t[258002] = "Обмотки коренеплясуна Гара'ті"
    t[258004] = "Накидка коренеплясуна Гара'ті"
    t[258005] = "Наручі коренеплясуна Гара'ті"
    t[258006] = "Рукавиці коренеплясуна Гара'ті"
    t[258007] = "Кушак коренеплясуна Гара'ті"
    t[258008] = "Штани коренеплясуна Гара'ті"
    t[258009] = "Чоботи коренеплясуна Гара'ті"
    t[258010] = { name = "Комплект: вбрання коренетанцівника гара'ті", fen = "An ensemble of Cloth armor appearances.", fua = "Комплект образів тканинної броні." }
    t[258012] = { name = "Комплект: одяг вартового коренів гара'ті", fen = "An ensemble of Leather armor appearances.", fua = "Комплект образів шкіряної броні." }
    t[258013] = { name = "Комплект: спорядження розвідника гара'ті", fen = "An ensemble of Mail armor appearances.", fua = "Комплект образів кольчужної броні." }
    t[258014] = { name = "Комплект: броня хранителя гара'ті", fen = "An ensemble of Plate armor appearances.", fua = "Комплект образів латної броні." }
    t[258022] = "Шолом з пір'ям умілого шукача здобичі"
    t[258023] = "Заплічник умілого шукача здобичі"
    t[258024] = "Наплічні шипи умілого шукача здобичі"
    t[258025] = { name = "Викрійка: підкладка із шовку сонячного вогню", fen = "Teaches you how to craft Sunfire Silk Lining.", fua = "Навчає вас виготовляти підкладку із шовку сонячного вогню." }
    t[258026] = "Наплічні шипи славетного ловця здобичі"
    t[258027] = "Наплічні шипи уславленого ловця здобичі"
    t[258028] = "Шолом із плюмажем славетного ловця здобичі"
    t[258029] = "Шолом з плюмажем уславленого ловця здобичі"
    t[258030] = "Наплічник славетного ловця здобичі"
    t[258031] = "Заплічник уславленого ловця здобичі"
    t[258033] = { name = "Викрійка: арканоткана підкладка", fen = "Teaches you how to craft Arcanoweave Lining.", fua = "Навчає вас виготовляти арканоткану підкладку." }
    t[258034] = { name = "Нестабільна аркана", fen = "The glass vial pulses with shifting arcane energy, unpredictable and uncontrollable.", fua = "Скляна пляшечка пульсує мінливою таємною енергією, непередбачуваною й некерованою." }
    t[258035] = { name = "Викрійка: алхімічний комбінезон елегантного майстра", fen = "Teaches you how to craft Elegant Artisan's Alchemy Coveralls.", fua = "Навчає вас виготовляти алхімічний комбінезон елегантного майстра." }
    t[258036] = { name = "Викрійка: кухарський ковпак елегантного майстра", fen = "Teaches you how to craft Elegant Artisan's Cooking Hat.", fua = "Навчає вас виготовляти кухарський ковпак елегантного майстра." }
    t[258037] = { name = "Викрійка: капелюх зачарування елегантного майстра", fen = "Teaches you how to craft Elegant Artisan's Enchanting Hat.", fua = "Навчає вас виготовляти капелюх зачарування елегантного майстра." }
    t[258038] = { name = "Викрійка: рибальський капелюх елегантного майстра", fen = "Teaches you how to craft Elegant Artisan's Fishing Hat.", fua = "Навчає вас виготовляти рибальський капелюх елегантного майстра." }
    t[258039] = { name = "Викрійка: травницький капелюх елегантного майстра", fen = "Teaches you how to craft Elegant Artisan's Herbalism Hat.", fua = "Навчає вас виготовляти травницький капелюх елегантного майстра." }
    t[258040] = { name = "Викрійка: кравецька роба елегантного майстра", fen = "Teaches you how to craft Elegant Artisan's Tailoring Robe.", fua = "Навчає вас виготовляти кравецьку робу елегантного майстра." }
    t[258044] = { name = "Потьмяніла Перлина", fen = "Energy flickers weakly within.", fua = "Усередині слабко мерехтить енергія." }
    t[258045] = "Глефи Світанкового Клинка"
    t[258122] = { name = "Смарагдове Пташеня", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[258123] = { name = "Викрійка: чароплет із шовку сонячного вогню", fen = "Teaches you how to craft Sunfire Silk Spellthread.", fua = "Навчає вас виготовляти чароплет із шовку сонячного вогню." }
    t[258124] = { name = "Викрійка: арканотканий чароплет", fen = "Teaches you how to craft Arcanoweave Spellthread.", fua = "Навчає вас виготовляти арканотканий чароплет." }
    t[258125] = { name = "Викрійка: пояс сонячного вогню", fen = "Teaches you how to craft Sunfire Sash.", fua = "Навчає вас виготовляти пояс сонячного вогню." }
    t[258126] = { name = "Викрійка: арканоткана шнурівка", fen = "Teaches you how to craft Arcanoweave Cord.", fua = "Навчає вас виготовляти арканоткану шнурівку." }
    t[258127] = { name = "Викрійка: штори Сільвермуна", fen = "Teaches you how to craft Silvermoon Curtains.", fua = "Навчає вас виготовляти штори Сільвермуна." }
    t[258128] = { name = "Викрійка: пишний килим Телоґруса", fen = "Teaches you how to craft a Lush Telogrus Carpet.", fua = "Навчає вас виготовляти пишний килим Телоґруса." }
    t[258131] = { name = "Викрійка: розкішна диванна подушка Сільвермуна", fen = "Teaches you how to craft Luxurious Silvermoon Lounge Cushion.", fua = "Навчає вас виготовляти розкішну диванну подушку Сільвермуна." }
    t[258132] = { name = "Викрійка: м'яке ліжко Сільвермуна", fen = "Teaches you how to craft Plush Silvermoon Bed.", fua = "Навчає вас виготовляти м'яке ліжко Сільвермуна." }
    t[258133] = { name = "Викрійка: вишукана подушка Сільвермуна", fen = "Teaches you how to craft Chic Silvermoon Pillow.", fua = "Навчає вас виготовляти вишукану подушку Сільвермуна." }
    t[258134] = { name = "Викрійка: сідельна сумка ходака Порожнечі", fen = "Teaches you how to craft a Voidstrider Saddlebag.", fua = "Навчає вас виготовляти сідельну сумку ходака Порожнечі." }
    t[258141] = { name = "Рецепт: Фіал сприйняття гаранірів", fen = "Teaches you how create a Haranir Phial of Perception.", fua = "Навчає вас створювати фіал сприйняття гаранірів." }
    t[258146] = { name = "Гнила падаль", fen = "Pungent remains of a slain beast from the Obscurion Citadel.", fua = "Смердючі рештки вбитого звіра з цитаделі Обскуріон." }
    t[258168] = { name = "Купа Риб'ячих Тельбухів", fen = "These innards have been sitting in the air for some time. The smell is foul.", fua = "Ці нутрощі вже якийсь час лежать просто неба. Сморід жахливий." }
    t[258218] = "Клинок Небоборця"
    t[258295] = { name = "Зазубрене ікло", fen = "A sharp tooth harvested from the horrifying maw of an aberration.", fua = "Гострий зуб, здобутий зі страхітливої пащі аберації." }
    t[258305] = { name = "Рецепт: Екстракт амані", fen = "Teaches you how create Amani Extract.", fua = "Навчає вас створювати екстракт амані." }
    t[258321] = { name = "Сплюндрована реліквія", fen = "A handmade artifact looted from an abandoned shrine during the loas' silence. As the loas return to Zul'Aman, it is only fitting the Amani reclaim these relics.", fua = "Рукотворний артефакт, награбований у покинутому святилищі під час мовчання лоа. Тепер, коли лоа повертаються до Зул'Аману, цілком справедливо, що амані повертають собі ці реліквії." }
    t[258324] = { name = "Викрадена дичина", fen = "Meat stolen from Amani hunting parties, mostly pristine quality.", fua = "М'ясо, вкрадене в мисливських загонів амані, здебільшого бездоганної якості." }
    t[258410] = "Традиції гаранірів: травництво"
    t[258411] = "Традиції гаранірів: накреслення"
    t[258412] = "Арбалет штормотворця"
    t[258436] = "Лезо Палаючого Сонця"
    t[258438] = "Палаючі сонцекігті"
    t[258472] = "Сонячний реліквар Рухрана"
    t[258484] = "Сонячний спис Вірікс"
    t[258487] = { name = "Креслення: Прудкі стопи Завулка Убивць", fen = "Teaches you how to craft Murder Row Fleet Feet.", fua = "Навчає вас виготовляти Прудкі стопи Завулка Убивць." }
    t[258489] = { name = "Техніка: Таласське послання вправності", fen = "Teaches you how to craft Thalassian Missive of Deftness.", fua = "Навчає вас виготовляти таласське послання вправності." }
    t[258491] = { name = "Техніка: Таласське послання сприйняття", fen = "Teaches you how to craft Thalassian Missive of Perception.", fua = "Навчає вас виготовляти таласське послання сприйняття." }
    t[258492] = { name = "Техніка: Таласське послання витонченості", fen = "Teaches you how to craft Thalassian Missive of Finesse.", fua = "Навчає вас виготовляти таласське послання витонченості." }
    t[258493] = { name = "Техніка: Таласське послання швидкості ремесла", fen = "Teaches you how to craft Thalassian Missive of Crafting Speed.", fua = "Навчає вас виготовляти таласське послання швидкості ремесла." }
    t[258494] = { name = "Техніка: Таласське послання багатовиробу", fen = "Teaches you how to craft Thalassian Missive of Multicraft.", fua = "Навчає вас виготовляти таласське послання багатовиробу." }
    t[258495] = { name = "Техніка: Таласське послання кмітливості", fen = "Teaches you how to craft Thalassian Missive of Resourcefulness.", fua = "Навчає вас виготовляти таласське послання кмітливості." }
    t[258496] = { name = "Техніка: Таласське послання винахідливості", fen = "Teaches you how to craft Thalassian Missive of Ingenuity.", fua = "Навчає вас виготовляти таласське послання винахідливості." }
    t[258499] = { name = "Техніка: Затишна бронзова лава", fen = "Teaches you how to craft Restful Bronze Bench.", fua = "Навчає вас виготовляти затишну бронзову лаву." }
    t[258500] = { name = "Техніка: Летючий торкнутий Порожнечею фоліант", fen = "Teaches you how to craft Floating Void-Touched Tome.", fua = "Навчає вас виготовляти летючий торкнутий Порожнечею фоліант." }
    t[258502] = { name = "Техніка: Жваве перо піснетворця", fen = "Teaches you how to craft Lively Songwriter's Quill.", fua = "Навчає вас виготовляти жваве перо піснетворця." }
    t[258503] = { name = "Техніка: Розгорнутий сувій сін'дорей", fen = "Teaches you how to craft Opened Sin'dorei Scroll.", fua = "Навчає вас виготовляти розгорнутий сувій сін'дорей." }
    t[258504] = { name = "Техніка: Позолочена книга Вічної Пісні", fen = "Teaches you how to craft Gilded Eversong Book.", fua = "Навчає вас виготовляти позолочену книгу Вічної Пісні." }
    t[258505] = { name = "Техніка: Перо фенікса сін'дорей", fen = "Teaches you how to craft Sin'dorei Phoenix Quill.", fua = "Навчає вас виготовляти перо фенікса сін'дорей." }
    t[258509] = { name = "Техніка: Дороговказ Гарандара", fen = "Teaches you how to craft Harandar Signpost.", fua = "Навчає вас виготовляти дороговказ Гарандара." }
    t[258510] = { name = "Техніка: Розкішна височезна книжкова шафа", fen = "Teaches you how to craft Magnificent Towering Bookcase.", fua = "Навчає вас виготовляти розкішну височезну книжкову шафу." }
    t[258514] = "Тінявий шпиль Зураала"
    t[258516] = "Жезл погляду Сапріша"
    t[258517] = { name = "Креслення: Частокіл лицаря-командора", fen = "Teaches you how to craft Knight-Commander's Palisade.", fua = "Навчає вас виготовляти Частокіл лицаря-командора." }
    t[258518] = { name = "Креслення: Рибальський гачок Завулка Убивць", fen = "Teaches you how to craft Murder Row Fishhook.", fua = "Навчає вас виготовляти Рибальський гачок Завулка Убивць." }
    t[258519] = { name = "Креслення: Прощання Магістра", fen = "Teaches you how to craft Magister's Valediction.", fua = "Навчає вас виготовляти Прощання Магістра." }
    t[258521] = { name = "Креслення: Запал Лицаря крові", fen = "Teaches you how to craft Blood Knight's Impetus.", fua = "Навчає вас виготовляти Запал Лицаря крові." }
    t[258522] = { name = "Креслення: Цвітокована велика сокира", fen = "Teaches you how to craft Bloomforged Greataxe.", fua = "Навчає вас виготовляти Цвітоковану велику сокиру." }
    t[258523] = "Нечесткіготь Незгара"
    t[258524] = "Хват Темного Намісника"
    t[258525] = "Скіпетр нескінченної ночі"
    t[258529] = "Спис арканного пазура"
    t[258531] = "Лусковартові Кравта"
    t[258532] = "Міцна стола Шукача Здобичі"
    t[258533] = "Полірований плащ шукача здобичі"
    t[258534] = { name = "Скриня славетного суперника", fen = "An impressive stockpile of various goods. May contain profession reagents, recipe scrolls, PvP consumables, and more!", fua = "Вражаючий запас різноманітних товарів. Може містити реагенти професій, сувої з рецептами, видаткові предмети для PvP і не тільки!" }
    t[258556] = { name = "Таласський знак заслуги", fen = "Can be exchanged for valuables offered by Vaultkeeper Elysa in Silvermoon.", fua = "Можна обміняти на цінні речі у хранительки сховища Елайси в Сільвермуні." }
    t[258571] = { name = "Грибний пігмент", fen = "A fine powder ingredient used by the Zur'ashar to create vibrant, enduring paints.", fua = "Тонкий порошковий інгредієнт, який заратті використовують для створення яскравих, стійких фарб." }
    t[258572] = { name = "Кристалічна есенція", fen = "This essence contains volatile amounts of void energy.", fua = "Ця сутність містить нестабільну кількість енергії Порожнечі." }
    t[258573] = { name = "Рослинний барвник", fen = "This essence contains volatile amounts of void energy.", fua = "Ця сутність містить нестабільну кількість енергії Порожнечі." }
    t[258577] = "Чоботи Палкого Зосередження"
    t[258620] = { name = "Доплата за ризик польового медика", fen = "A stockpile of miscellaneous goods that compensates for the underappreciated work out in the battlefield.", fua = "Запас різноманітних товарів, що відшкодовує недооцінену працю на полі бою." }
    t[258622] = "Медаль завоювання"
    t[258623] = { name = "Блискучий мішечок насіння", fen = "Made from petals and leaves, and wrapped with a sturdy vine, this rutaani seed bag glistens with its own dim light.", fua = "Зроблений із пелюсток і листя та обмотаний міцною лозою, цей мішечок насіння рутаані блищить власним тьмяним сяйвом." }
    t[258736] = "Сувій порталу до міста"
    t[258738] = { name = "Сердечне запрошення", fen = "An invitation to discuss your inevitable demise and gravestone with one Nelthius Shadestone.", fua = "Запрошення обговорити твою неминучу загибель і надгробок з якимсь Нелтіусом Шейдстоуном." }
    t[258763] = "Переносний запал Порожнечі"
    t[258768] = { name = "Пошарпаний ключ від скрині", fen = "The Thalassian symbol for '1' is inscribed near the top.", fua = "Біля верху викарбувано таласійський символ «1»." }
    t[258769] = { name = "Зношений ключ від скрині", fen = "The Thalassian symbol for '2' is inscribed near the top.", fua = "Угорі викарбувано таласіанський символ '2'." }
    t[258770] = { name = "Потьмянілий ключ від сейфа", fen = "The Thalassian symbol for '3' is inscribed near the top.", fua = "Угорі викарбуваний таласійський символ числа «3»." }
    t[258839] = { name = "Прихований каталог", fen = "Contains an elusive recipe from the depths of Midnight's dungeons.", fua = "Містить невловимий рецепт із глибин підземель Опівночі." }
    t[258848] = "Заплямований пояс"
    t[258849] = "Заплямований наголовник"
    t[258850] = "Заплямовані кулачні щитки"
    t[258851] = "Заплямована кольчуга"
    t[258852] = "Заплямовані поножі"
    t[258853] = "Заплямовані сабатони"
    t[258854] = "Заплямовані наплічники"
    t[258855] = "Заплямовані наручі"
    t[258856] = "Потертий наплічник"
    t[258857] = "Потертий пояс"
    t[258858] = "Потерта корона"
    t[258859] = "Потерті рукавиці"
    t[258860] = "Потерті штани"
    t[258861] = "Потерті капці"
    t[258862] = "Потерті шати"
    t[258863] = "Зношені нараменники"
    t[258864] = "Крихкий Пояс"
    t[258865] = "Крихкий Нагрудник"
    t[258866] = "Крихкі Рукавиці"
    t[258867] = "Крихке Забрало"
    t[258868] = "Крихкі Поножі"
    t[258869] = "Крихкі Наплічники"
    t[258870] = "Крихкі бойові чоботи"
    t[258871] = "Крихкі Налокітники"
    t[258872] = "Зношені обмотки для зап'ястків"
    t[258873] = "Зношена туніка"
    t[258874] = "Зношені наплічники"
    t[258875] = "Зношені штани"
    t[258876] = "Зношений каптур"
    t[258877] = "Зношені обмотки для рук"
    t[258878] = "Зношені чоботи"
    t[258879] = "Зношений ремінь"
    t[258890] = { name = "Туша Вепра", fen = "The carcass of a giant boar, entrails and all, ready to be butchered and cooked.", fua = "Туша велетенського вепра, з тельбухами й усім іншим, готова до оброблення й приготування." }
    t[258891] = { name = "Бездоганна тіньова лілея", fen = "These delicate flowers are difficult to pick without damaging them, but if kept in flawless condition, they are perfect for cooling balms.", fua = "Ці тендітні квіти важко зірвати, не пошкодивши, але якщо зберегти їх у бездоганному стані, вони ідеальні для охолоджувальних бальзамів." }
    t[258892] = { name = "Папоротева віть драконояструба", fen = "When ready for harvest, these fronds shimmer with a fiery effect, which gives a cauterizing salve its potency.", fua = "Коли надходить час збирати, ці віті мерехтять вогнистим полиском, що надає припікальній мазі її дієвості." }
    t[258900] = { name = "Обвуглена гілка Світового Дерева", fen = "Makes for surprisingly good fertilizer.", fua = "Несподівано стає чудовим добривом." }
    t[258903] = { name = "Персіваль", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[258908] = "Потьмяніла світанкова каблучка"
    t[258909] = "Потьмяніла світанкова печатка"
    t[258910] = "Потьмяніле світанкове кільце"
    t[258911] = "Потьмянілий світанковий підвісок"
    t[258912] = "Потьмяніла світанкова мантія заклинача"
    t[258913] = "Потьмянілі світанкові черевики заклинача"
    t[258914] = "Потьмянілі світанкові рукавиці заклинача"
    t[258915] = "Потьмяніла світанкова корона заклинача"
    t[258916] = "Потьмянілі світанкові штани заклинача"
    t[258917] = "Потьмянілі світанкові наплічники заклинача"
    t[258918] = "Потьмянілий світанковий пояс заклинача"
    t[258919] = "Потьмянілі світанкові наручі заклинача"
    t[258920] = "Потьмяніла світанкова туніка корсара"
    t[258921] = "Потьмянілі світанкові чоботи корсара"
    t[258922] = "Потьмянілі світанкові рукавиці корсара"
    t[258923] = "Потьмянілий світанковий каптур корсара"
    t[258924] = "Потьмянілі світанкові штани корсара"
    t[258925] = "Потьмянілі світанкові наплічники корсара"
    t[258926] = "Потьмянілий світанковий пояс корсара"
    t[258927] = "Потьмянілі світанкові наручі корсара"
    t[258928] = "Потьмяніла світанкова кольчуга вартового"
    t[258929] = "Потьмянілі світанкові латні чоботи вартового"
    t[258930] = "Потьмянілі світанкові латні рукавиці вартового"
    t[258931] = "Потьмянілий світанковий шолом вартового"
    t[258932] = "Потьмянілі світанкові ножні лати вартового"
    t[258933] = "Потьмянілі світанкові еполети вартового"
    t[258934] = "Потьмянілий світанковий пояс вартового"
    t[258935] = "Потьмянілі світанкові наручі вартового"
    t[258936] = "Потьмянілий світанковий нагрудник командира"
    t[258937] = "Потьмянілі світанкові бойові чоботи командира"
    t[258938] = "Потьмянілі світанкові латні рукавиці командира"
    t[258939] = "Потьмянілий світанковий шолом командира"
    t[258940] = "Потьмянілі світанкові поножі командира"
    t[258941] = "Потьмяніла світанкова накидка на плечі командира"
    t[258942] = "Потьмянілий світанковий широкий пояс командира"
    t[258943] = "Потьмянілі світанкові наручні пластини командира"
    t[258944] = "Потьмянілий світанковий сікач"
    t[258945] = "Потьмянілий світанковий різак"
    t[258946] = "Потьмянілий світанковий тесак"
    t[258947] = "Потьмянілий світанковий кинджал"
    t[258948] = "Потьмянілий світанковий ніж"
    t[258949] = "Потьмянілий світанковий булава"
    t[258950] = "Потьмяніла світанкова бойова булава"
    t[258951] = "Потьмянілий світанковий короткий меч"
    t[258952] = "Потьмянілий світанковий довгий меч"
    t[258953] = "Потьмянілий світанковий довгий лук"
    t[258954] = "Потьмяніла світанкова сокира на держаку"
    t[258955] = "Потьмяніла світанкова алебарда"
    t[258956] = "Потьмянілий світанковий скіпетр"
    t[258957] = "Потьмянілий світанковий посох"
    t[258958] = "Потьмянілий світанковий дворучний меч"
    t[258959] = "Потьмяніле світанкове лезо"
    t[258960] = "Потьмянілий світанковий маяк"
    t[258961] = "Потьмянілий світанковий захисник"
    t[258962] = "Потьмянілий світанковий бойовий глеф"
    t[258963] = "Парашут Грибострибуна"
    t[258965] = { name = "Фоліант Перетворення", fen = "A collection of essays, instructions, and warnings.", fua = "Збірка нарисів, настанов і застережень." }
    t[258966] = { name = "Нашийник рисі", fen = "Magically inscribed with the mark of Sunstrider Isle.", fua = "Магічно позначений знаком острова Сонстрайдерів." }
    t[258967] = "Гайовий лук розвідника Гара'ті"
    t[258969] = "Кинджал вартового коренів Гара'ті"
    t[258970] = "Клинок коренеплясуна Гара'ті"
    t[258972] = "Пазурі розвідника Гара'ті"
    t[259027] = "Комплект: Елегантні регалії Лицаря крові"
    t[259028] = "Комплект: елегантне парадне вбрання Гавані"
    t[259029] = { name = "Розвіддані Тіньової варти", fen = "Shadowguard movement and warplans are detailed on this small data store.", fua = "Пересування й воєнні плани Тіньової варти докладно викладені в цьому невеликому сховищі даних." }
    t[259036] = "Катар розвідника Гара'ті"
    t[259037] = "Скіпетр вартового коренів Гара'ті"
    t[259038] = "Кийок вартового Гара'ті"
    t[259039] = "Глефа коренеплясуна Гара'ті"
    t[259040] = "Довгий меч вартового Гара'ті"
    t[259041] = "Ручна сокира коренеплясуна Гара'ті"
    t[259042] = "Цвіт вартового коренів Гара'ті"
    t[259043] = "Бастіон вартового Гара'ті"
    t[259047] = "Чарівна паличка вартового коренів Гара'ті"
    t[259048] = "Патериця вартового коренів Гара'ті"
    t[259049] = "Клинковий посох коренеплясуна Гара'ті"
    t[259050] = "Арбалет розвідника Гара'ті"
    t[259051] = "Бойова сокира вартового Гара'ті"
    t[259052] = "Шамшир вартового Гара'ті"
    t[259054] = "Спис розвідника Гара'ті"
    t[259073] = { name = "Арсенал: зброя гара'ті", fen = "An arsenal of weapon appearances.", fua = "Арсенал виглядів зброї." }
    t[259074] = "Комплект: елегантне парадне вбрання магістра"
    t[259075] = "Комплект: викрадене елегантне парадне вбрання"
    t[259076] = "Комплект: елегантне парадне вбрання далекоходів"
    t[259079] = "Комплект: убори сановника далекоходів"
    t[259080] = "Комплект: убори сановника-магістра"
    t[259081] = "Комплект: Регалії сановника Лицарів крові"
    t[259082] = "Комплект: убори сановника Гавані"
    t[259083] = "Комплект: викрадені убори сановника"
    t[259084] = { name = "Дар Циклу", fen = "A strange orb of light that is warm to the touch. Holding it to your ear, you can sometimes hear a child at play, or a hunter discussing a hunt, and sometimes an elder telling a story about a life well lived.", fua = "Дивна куля світла, тепла на дотик. Якщо піднести її до вуха, інколи можна почути дитину за грою, мисливця, що розповідає про полювання, а часом старійшину, який оповідає історію про добре прожите життя." }
    t[259085] = { name = "Руна підсилення, торкнута Порожнечею", fen = "Can be bought and sold on the auction house.", fua = "Можна купити та продати на аукціоні." }
    t[259086] = { name = "Торкнута Порожнечею торбина співпраці", fen = "Filled to the brim with gold, Void-Touched Augment Runes, and Voidlight Marl.", fua = "Наповнена по вінця золотом, торкнутими Порожнечею рунами підсилення та пилом світла Порожнечі." }
    t[259087] = "Комплект: викрадене світське вбрання"
    t[259088] = "Комплект: Світське вбрання Лицарів крові"
    t[259089] = "Комплект: світське вбрання магістра"
    t[259090] = "Комплект: світське вбрання далекоходів"
    t[259091] = "Комплект: світське вбрання Гавані"
    t[259092] = "Зілля вільної дії, відтінене Порожнечею"
    t[259171] = { name = "Налобний світлоблокатор", fen = "For when the lights are too bright.", fua = "На випадок, коли світло надто яскраве." }
    t[259172] = { name = "Схема: наголовний променезагородник", fen = "Teaches you how to craft Head-Mounted Beam Bummer.", fua = "Навчає виготовляти наголовний променезагородник." }
    t[259173] = { name = "Каска від каменепаду", fen = "Ain't no rock getting through this time tested accessory.", fua = "Жоден камінь не проб'ється крізь цей перевірений часом аксесуар." }
    t[259174] = { name = "Схема: каменеломна каска", fen = "Teaches you how to craft a Rock Bonkin' Hardhat.", fua = "Навчає виготовляти каменеломну каску." }
    t[259175] = { name = "Надміцний помічник для каміння", fen = "Grabs even more rocks!", fua = "Збирає ще більше каміння!" }
    t[259176] = { name = "Схема: надміцний помічник для каменю", fen = "Teaches you how to craft Heavy-Duty Rock Assister.", fua = "Навчає виготовляти надміцний помічник для каменю." }
    t[259177] = { name = "Самозагострювані ножиці сін'дорей", fen = "That first cut feeling, every time.", fua = "Відчуття першого розрізу — щоразу." }
    t[259178] = { name = "Схема: самозагострювані ножиці сін'дорей", fen = "Teaches you how to craft Self-Sharpening Sin'dorei Snippers.", fua = "Навчає виготовляти самозагострювані ножиці сін'дорей." }
    t[259179] = "Котушкова вудка сін'дорей"
    t[259180] = { name = "Схема: вудка з котушкою сін'дорей", fen = "Teaches you how to craft Sin'dorei Reeler's Rod.", fua = "Навчає виготовляти вудку з котушкою сін'дорей." }
    t[259181] = { name = "Гіга-самоцвітні захвати", fen = "When they ask \"How do you do it?\", show them this.", fua = "Коли вас питають «Як вам це вдається?», покажіть їм це." }
    t[259182] = { name = "Схема: гіга-самоцвітні захвати", fen = "Teaches you how to craft Giga-Gem Grippers.", fua = "Навчає виготовляти гіга-самоцвітні захвати." }
    t[259183] = { name = "Багатофункційний інструмент турбо-утилізатора v9", fen = "Nothing better than this.", fua = "Кращого не буває." }
    t[259184] = { name = "Схема: багатофункційний інструмент турбо-брухтарки v9", fen = "Teaches you how to craft Turbo-Junker's Multitool v9.", fua = "Навчає виготовляти багатофункційний інструмент турбо-брухтарки v9." }
    t[259188] = "Зразок спор зі Світлоцвітом"
    t[259189] = "Витриманий круор"
    t[259190] = { name = "Таласський точильний камінь", fen = "While the craftsmanship is impressive, this aged whetstone is no longer practically useful. You can study it though to improve your Blacksmithing knowledge!", fua = "Хоч майстерність вражає, цей старий точильний камінь уже не придатний для практичного вжитку. Утім, ви можете вивчити його, щоб поглибити свої знання з ковальства!" }
    t[259191] = { name = "Насичена гартувальна олія", fen = "An advanced product utilizing the skills of Alchemists, Enchanters, and Blacksmiths, studying this oil can help deepen your understanding of practical application of Thalassian smithing techniques.", fua = "Передовий продукт, що поєднує вміння алхіміків, зачаровувачів і ковалів. Вивчення цієї олії допоможе поглибити твоє розуміння практичного застосування таласійських ковальських технік." }
    t[259192] = { name = "Попіл Бурі Порожнечі", fen = "A fine dust from the Voidstorm, it contains latent magic for enchanters to study. Doing so will yield knowledge!", fua = "Дрібний пил із Бурі Порожнечі, що містить приховану магію для вивчення зачаровувачами. Вивчивши його, ти здобудеш знання!" }
    t[259193] = { name = "Загублений таласійський пергамен", fen = "A previously-lost vellum containing Thalassian-based magics. While it doesn't have any practical use, you can study it for Enchanting Knowledge!", fua = "Колись загублений пергамен із таласійською магією. Хоч практичної користі він не має, ти можеш вивчати його задля знань із чаротворення!" }
    t[259194] = { name = "Танцювальна шестерня", fen = "While they don't have any practical applications, studying them can help improve your knowledge of Thalassian engineering techniques. They also happen to pair well with Song Gears.", fua = "Хоч вони й не мають практичного застосування, їх вивчення допоможе поглибити твої знання таласійських інженерних технік. До того ж вони добре поєднуються зі співочими шестернями." }
    t[259195] = { name = "Світанковий конденсатор", fen = "A strange device that emits a bright, golden glow. While you don't have any practical uses for it, you could disassemble it and study it to improve your Engineering knowledge!", fua = "Дивний пристрій, що випромінює яскраве золотаве сяйво. Хоч практичного застосування для нього в тебе немає, ти можеш розібрати його та вивчити, щоб поглибити свої знання з інженерії!" }
    t[259196] = { name = "Осяйне Чорнило Фенікса", fen = "The magic flowing through this ink has long expired, but its brilliant hue is still a sight to behold. Studying it can help you deepen your understanding of Thalassian scribe techniques.", fua = "Магія, що текла в цьому чорнилі, давно вичерпалася, та його осяйний відтінок досі вражає. Його вивчення допоможе тобі поглибити розуміння таласійських письменницьких технік." }
    t[259197] = { name = "Благословенна лоа руна", fen = "An ancient rune blessed with the power of the Loa. While you're unsure what it would do, or how to even utilize it, the masterful craftsmanship of the rune can help you with your studies as a scribe.", fua = "Стародавня руна, благословенна силою лоа. Хоч ти й не певен, що вона робить чи як її взагалі використати, майстерне виконання руни може допомогти тобі в студіях писаря." }
    t[259198] = { name = "Уламки вічноспівного діаманта, торкнуті Порожнечею", fen = "Unusable, but hints of voidlight shimmer within the depths of the gem. Studying it can yield new Jewelcrafting Knowledge.", fua = "Непридатні, та в глибині самоцвіту мерехтить світло Порожнечі. Вивчення може дати нове знання з ювелірства." }
    t[259199] = { name = "Кам'яний зразок з Гарандара", fen = "A sample of stone from Harandar, steeped in the primal magic of Azeroth. Studying it will yield Jewelcrafting Knowledge.", fua = "Зразок каменю з Гарандара, просочений первісною магією Азероту. Його вивчення дасть знання з ювелірства." }
    t[259200] = { name = "Дубильна олія амані", fen = "Made from the trees of Zul'Aman, the Amani trolls use this for treating their leather. Studying it will yield new knowledge!", fua = "Виготовлене з дерев Зул'Амана, тролі амані використовують його для обробки своєї шкіри. Вивчення його дасть нові знання!" }
    t[259201] = { name = "Таласька манаолія", fen = "Perfect for treating hides in the use of powerful armor. Also great for studying to improve your Leatherworking!", fua = "Ідеальна для обробки шкур задля виготовлення потужної броні. Також чудово підходить для вивчення, щоб поліпшити вашу шкірообробку!" }
    t[259202] = "Вишитий Сувенір"
    t[259203] = "Тонко плетений рисячий нашийник"
    t[259204] = { name = "Попелясті рештки нальотчика", fen = "The result of many failures piling up...", fua = "Результат багатьох невдач, що накопичилися..." }
    t[259205] = "Позолочена мішалка алхіміка"
    t[259206] = { name = "Техніка: Позолочена мішалка алхіміка", fen = "Teaches you how to craft Gilded Alchemist's Mixing Rod.", fua = "Навчає вас виготовляти позолочену мішалку алхіміка." }
    t[259207] = "Позолочена качалка сін'дорей"
    t[259208] = { name = "Техніка: Позолочена качалка сін'дорей", fen = "Teaches you how to craft Gilded Sin'dorei Rolling Pin.", fua = "Навчає вас виготовляти позолочену качалку сін'дорей." }
    t[259209] = "Позолочене перо сін'дорей"
    t[259210] = { name = "Техніка: Позолочене перо сін'дорей", fen = "Teaches you how to craft Gilded Sin'dorei Quill.", fua = "Навчає вас виготовляти позолочене перо сін'дорей." }
    t[259219] = { name = "Ведмежий зуб", fen = "Token of Nalorakk's Chosen. Key to the Honored Warrior's Cache.", fua = "Знак Обранця Налоракка. Ключ до Схованки Шанованого Воїна." }
    t[259220] = { name = "Перо драконояструба", fen = "Token of Jan'alai's Chosen. Key to the Honored Warrior's Cache.", fua = "Знак обранця Джан'алая. Ключ до Схрону шанованого воїна." }
    t[259221] = { name = "Орлиний Кіготь", fen = "Token of Akil'zon's Chosen. Key to the Honored Warrior's Cache.", fua = "Знак Обранця Акіл'зона. Ключ до Скарбниці Шанованого Воїна." }
    t[259223] = { name = "Кіготь рисі", fen = "Token of Halazzi's Chosen. Key to the Honored Warrior's Cache.", fua = "Знак Обранця Галаззі. Ключ до Схованки шанованого воїна." }
    t[259224] = { name = "Драконояструбеня", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[259230] = "Сонцегартована ковальська скринька з інструментами"
    t[259231] = { name = "Креслення: Сонцегартована ковальська скринька з інструментами", fen = "Teaches you how to craft Sunforged Blacksmith's Toolbox.", fua = "Навчає вас виготовляти Сонцегартовану ковальську скриньку з інструментами." }
    t[259232] = "Сонцегартований чинбарський набір інструментів"
    t[259233] = { name = "Креслення: Сонцегартований чинбарський набір інструментів", fen = "Teaches you how to craft Sunforged Leatherworker's Toolset.", fua = "Навчає вас виготовляти Сонцегартований чинбарський набір інструментів." }
    t[259234] = "Сонцегартований набір голок"
    t[259235] = { name = "Креслення: Сонцегартований набір голок", fen = "Teaches you how to craft Sunforged Needle Set.", fua = "Навчає вас виготовляти Сонцегартований набір голок." }
    t[259237] = { name = "Креслення: Сонцегартований ковальський молот", fen = "Teaches you how to craft Sunforged Blacksmith's Hammer.", fua = "Навчає вас виготовляти Сонцегартований ковальський молот." }
    t[259240] = "Вино Сін'дорей"
    t[259245] = "Зілля фази Порожнечі"
    t[259317] = { name = "Креслення: Сонцегартований серп", fen = "Teaches you how to craft Sunforged Sickle.", fua = "Навчає вас виготовляти Сонцегартований серп." }
    t[259318] = { name = "Креслення: Сонцегартований чинбарський ніж", fen = "Teaches you how to craft Sunforged Leatherworker's Knife.", fua = "Навчає вас виготовляти Сонцегартований чинбарський ніж." }
    t[259319] = { name = "Креслення: Сонцегартована кирка", fen = "Teaches you how to craft Sunforged Pickaxe.", fua = "Навчає вас виготовляти Сонцегартовану кирку." }
    t[259322] = { name = "Креслення: Сонцегартований білувальний ніж", fen = "Teaches you how to craft Sunforged Skinning Knife.", fua = "Навчає вас виготовляти Сонцегартований білувальний ніж." }
    t[259334] = { name = "Переповнений скарб Сингулярності", fen = "Contains a variety of rewards for those who have proven themselves true allies of the Singularity.", fua = "Містить різноманітні нагороди для тих, хто довів, що є справжнім союзником Сингулярності." }
    t[259337] = { name = "Хрумчик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[259345] = { name = "Пернатий тотем Ані", fen = "A feathered keepsake bound to bone with dried marshlands vine.", fua = "Пернатий пам'ятний дарунок, прив'язаний до кістки висушеною болотяною лозою." }
    t[259348] = { name = "Запашний стробіл Ані", fen = "This trinket, similar to a pine cone, is dipped in tarred incense. The scent is strong, but not unpleasant.", fua = "Ця дрібничка, схожа на соснову шишку, занурена в смолистий ладан. Запах сильний, але не неприємний." }
    t[259349] = "Осереддя Розквітлого Вартового Коренів"
    t[259350] = { name = "Різьблена подоба Ані", fen = "A stone-carved animal complete with bared fangs. It bears an impressive resemblance to Ani's animal friend, Jynx. Simply designed, but carved with care.", fua = "Вирізана з каменю тварина з вищиреними іклами. Вона напрочуд схожа на звіриного друга Ані, Джинкса. Проста за задумом, але вирізана дбайливо." }
    t[259351] = "Лозоплетені ікла"
    t[259352] = "Хват Речника зелені"
    t[259355] = "Самостріл глибинного мисливця"
    t[259356] = "Протинач Квіткоткача"
    t[259358] = "Тесак для розчищення чагарів"
    t[259359] = "Накидка речника коренів"
    t[259360] = "Сталекорий плащ"
    t[259361] = { name = "Мерзенна есенція", fen = "Condensed necromantic energy. There's probably a use for this, if you don't mind the unsettling chill it sends down your spine.", fua = "Згущена некромантична енергія. Їй, напевно, знайдеться застосування, якщо тебе не бентежить тривожний холод, що пробігає по спині." }
    t[259362] = { name = "Викрійка: ліжко з балдахіном гараніра", fen = "Teaches you how to craft Haranir Canopy Bed.", fua = "Навчає вас виготовляти ліжко з балдахіном гараніра." }
    t[259363] = { name = "Креслення: оздоблена самоцвітами ліра сін'дорей", fen = "Teaches you how to craft Bejeweled Sin'dorei Lyre.", fua = "Навчає тебе виготовляти оздоблену самоцвітами ліру сін'дорей." }
    t[259364] = { name = "Формула: Оживлений молот сін'дорей", fen = "Teaches you how to create Animated Sin'dorei Hammer.", fua = "Навчає тебе, як створити Оживлений молот сін'дорей." }
    t[259365] = { name = "Викрійка: м'яка шкіряна подушка гараніра", fen = "Teaches you how to craft Plush Haranir Leather Pillow.", fua = "Навчає вас виготовляти м'яку шкіряну подушку гараніра." }
    t[259366] = { name = "Креслення: копія фрески гаранірів", fen = "Teaches you how to craft Replica Haranir Mural.", fua = "Навчає тебе виготовляти копію фрески гаранірів." }
    t[259367] = { name = "Формула: Оживлене кайло сін'дорей", fen = "Teaches you how to create Animated Sin'dorei Pick.", fua = "Навчає тебе, як створити Оживлене кайло сін'дорей." }
    t[259368] = { name = "Викрійка: міцний стілець гараніра", fen = "Teaches you how to craft Sturdy Haranir Chair.", fua = "Навчає вас виготовляти міцний стілець гараніра." }
    t[259369] = { name = "Креслення: осяйна статуя високорідних", fen = "Teaches you how to craft Resplendent Highborne Statue.", fua = "Навчає тебе виготовляти осяйну статую високорідних." }
    t[259370] = { name = "Формула: Багаття кореневого полум'я", fen = "Teaches you how to create Rootflame Campfire.", fua = "Навчає, як створити Багаття кореневого полум'я." }
    t[259371] = { name = "Викрійка: гаптований килим гараніра", fen = "Teaches you how to craft Stitched Haranir Rug.", fua = "Навчає вас виготовляти гаптований килим гараніра." }
    t[259372] = { name = "Креслення: сяйливий пісковий годинник сін'дорей", fen = "Teaches you how to craft Shining Sin'dorei Hourglass.", fua = "Навчає тебе виготовляти сяйливий пісковий годинник сін'дорей." }
    t[259373] = { name = "Формула: Поштове сховище рен'дорей", fen = "Teaches you how to create Ren'dorei Postal Repository.", fua = "Навчає, як створити Поштове сховище рен'дорей." }
    t[259374] = { name = "Формула: Закляттям скута книга таласійських магій", fen = "Teaches you how to create Spellbound Tome of Thalassian Magics.", fua = "Навчає, як створити Закляттям скуту книгу таласійських магій." }
    t[259375] = { name = "Формула: Самонагідне таласійське сонячне вино", fen = "Teaches you how to create Self-Pouring Thalassian Sunwine.", fua = "Навчає, як створити Самонагідне таласійське сонячне вино." }
    t[259457] = { name = "Викрійка: простий стіл гараніра", fen = "Teaches you how to craft Simple Haranir Table.", fua = "Навчає вас виготовляти простий стіл гараніра." }
    t[259459] = { name = "Рецепт: Зілля безрозсудності", fen = "Teaches you how create Potion of Recklessness.", fua = "Навчає вас створювати зілля безрозсудності." }
    t[259462] = "Терноголка"
    t[259471] = { name = "Апетитне крабове м'ясо", fen = "A staple ingredient in Revantusk cuisine.", fua = "Основний інгредієнт ревантуської кухні." }
    t[259472] = "Загублені пожитки ревантусків"
    t[259473] = "Обвуглена дрібничка амані"
    t[259474] = "Загублена іграшка амані"
    t[259475] = "Загублена статуя лоа"
    t[259477] = "Пагін буйної есенції"
    t[259896] = "Кора Дерева-Охоронця"
    t[259909] = "Витончена шаль Шукача Здобичі"
    t[259910] = "Гладка пелерина Шукача Здобичі"
    t[259911] = "Перстень шукача здобичі"
    t[259912] = "Перстень-печатка Шукача Здобичі"
    t[259913] = "Перстень Шукача Здобичі"
    t[259914] = "Каблучка шукача здобичі"
    t[259915] = "Пряжка шукача здобичі"
    t[259916] = "Намисто шукача здобичі"
    t[259917] = "Витончені шати Шукача Здобичі"
    t[259918] = "Витончені пантофлі Шукача Здобичі"
    t[259919] = "Витончені рукавички Шукача Здобичі"
    t[259920] = "Витончена корона шукача здобичі"
    t[259921] = "Витончені рейтузи Шукача Здобичі"
    t[259922] = "Витончений еполет Шукача Здобичі"
    t[259923] = "Витончений пояс шукача здобичі"
    t[259924] = "Витончені манжети Шукача Здобичі"
    t[259925] = "Гладкий камзол Шукача Здобичі"
    t[259926] = "Гладкі чоботи Шукача Здобичі"
    t[259927] = "Гладкі рукавиці Шукача Здобичі"
    t[259928] = "Гладка маска Шукача Здобичі"
    t[259929] = "Гладкі штани Шукача Здобичі"
    t[259930] = "Гладкі наплічники Шукача Здобичі"
    t[259931] = "Гладкий пояс Шукача Здобичі"
    t[259932] = "Гладкі наручні пов'язки Шукача Здобичі"
    t[259933] = "Міцний обергеон Шукача Здобичі"
    t[259934] = "Міцні сабатони Шукача Здобичі"
    t[259935] = "Міцні наручі Шукача Здобичі"
    t[259936] = "Міцний плюмаж Шукача Здобичі"
    t[259937] = "Міцні поножі Шукача Здобичі"
    t[259938] = "Міцні наплічники Шукача Здобичі"
    t[259939] = "Міцна застібка Шукача Здобичі"
    t[259940] = "Міцні обмотки Шукача Здобичі"
    t[259941] = "Полірована бригантина шукача здобичі"
    t[259942] = "Поліровані важкі чоботи шукача здобичі"
    t[259943] = "Поліровані наручні шукача здобичі"
    t[259944] = "Полірований шолом шукача здобичі"
    t[259945] = "Поліровані стегнові щитки шукача здобичі"
    t[259946] = "Поліровані наплічники шукача здобичі"
    t[259947] = "Полірований широкий пояс шукача здобичі"
    t[259948] = "Поліровані наручі шукача здобичі"
    t[259949] = "Сокирка шукача здобичі"
    t[259950] = "Кукрі шукача здобичі"
    t[259951] = "Колючка Шукача Здобичі"
    t[259952] = "Кий шукача здобичі"
    t[259953] = "Скіпетр Шукача Здобичі"
    t[259955] = "Молот шукача здобичі"
    t[259956] = "Ятаган Шукача Здобичі"
    t[259957] = "Ритуальний клинок Шукача Здобичі"
    t[259958] = "Довгий меч шукача здобичі"
    t[259959] = "Бойова глефа Шукача Здобичі"
    t[259960] = "Довгий лук шукача здобичі"
    t[259961] = "Спис Шукача Здобичі"
    t[259962] = "Посох Шукача Здобичі"
    t[259963] = "Вістря Шукача Здобичі"
    t[259964] = "Фальшіон шукача здобичі"
    t[259965] = "Ліхтар шукача здобичі"
    t[259966] = "Великий щит Шукача Здобичі"
    t[259967] = { name = "Посох чарів амані", fen = "Elder Doru's reliable and trusty hexing staff.", fua = "Надійний і вірний посох чарів старійшини Дору." }
    t[259991] = { name = "Маленький шукач здобичі", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[259992] = { name = "Копії Документів", fen = "Records of fel magic misuse and receipts showing they were paid off with Magisterial funds. Several reports about kidnappings in Murder Row are mixed into the pile.", fua = "Записи про зловживання магією Скверни та квитанції, що доводять оплату коштами магістрату. До купи підмішано кілька повідомлень про викрадення у Завулку Убивць." }
    t[260187] = "Розривач чагарів"
    t[260188] = "Дикий тернолез"
    t[260189] = "Танцівлива голка хранителя коренів"
    t[260193] = { name = "Схованка легендарного ветерана", fen = "Weekly cache containing materials for upgrading gear, gold, and more.\n\n\n\nThe first two pinnacle caches you earn each week contain a piece of Veteran gear.", fua = "Щотижнева скриня з матеріалами для поліпшення спорядження, золотом тощо.\n\n\n\nПерші дві найвищі скрині, здобуті за тиждень, містять предмет спорядження ветерана." }
    t[260227] = { name = "Обморожена накидка", fen = "Well-worn and battered, this tabard is mostly recognizable under all the dust and frost.", fua = "Зношена й пошарпана, ця накидка ледь упізнавана під шаром пилу та інею." }
    t[260228] = { name = "Кривавий дрейк галактичного гладіатора", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[260231] = { name = "Блискучий яструбоступ", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[260232] = "Таласська відмичка"
    t[260233] = { name = "Смарагдовий Яструбоступ", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[260235] = "Тіняве перо"
    t[260238] = { name = "Наповнене Гноєм Око Мурлока", fen = "Squishy!", fua = "М'якеньке!" }
    t[260242] = { name = "Стегнова Кістка Ба'тіка", fen = "Large enough to be wielded as a mace.", fua = "Така велика, що нею можна орудувати як булавою." }
    t[260243] = { name = "Мерзокорінь", fen = "The last thing many a traveler sees before sinking into the swamp.", fua = "Останнє, що бачить чимало мандрівників, перш ніж піти на дно болота." }
    t[260246] = { name = "Креслення: таласська відмичка", fen = "Teaches you how to craft Coreforged Skeleton Key.", fua = "Навчає вас виготовляти Надровий Універсальний Ключ." }
    t[260248] = { name = "Таємнича зелена рідина", fen = "It's... viscous and gloopy.", fua = "Вона... в'язка й слизька." }
    t[260250] = { name = "Таємнича фіолетова рідина", fen = "This substance glistens in the dim light of the cave.", fua = "Ця речовина мерехтить у тьмяному світлі печери." }
    t[260251] = { name = "Таємнича червона рідина", fen = "Quite pungent! It stings the nostrils.", fua = "Доволі їдка! Аж пече в носі." }
    t[260254] = "Сонячний салат із капусти Кейл'тас"
    t[260255] = { name = "Манаґі-рол", fen = "Made with fresh wyrm. Arcane content may vary.", fua = "Зроблено зі свіжого вирма. Вміст арканної енергії може різнитися." }
    t[260256] = "Розкішний омлет"
    t[260257] = "Перець Примарних земель"
    t[260258] = "Очищений сироп"
    t[260259] = "Вода вічного джерела"
    t[260260] = "Джерельна газована вода"
    t[260261] = "Квітковий нектар"
    t[260262] = { name = "Бенкет Фейрбризу", fen = "A picnic basket laden with finger sandwiches, fruits, and cocktails.", fua = "Кошик для пікніка, навантажений канапками, фруктами й коктейлями." }
    t[260263] = { name = "Бенкетний стіл Сільвермуна", fen = "A collection of sun-golden apples, arcane infused 'blue' cheese, and native Eversong nuts, paired with fine Arcwine.", fua = "Набір сонячно-золотих яблук, насиченого арканом «блакитного» сиру та місцевих горіхів Лісу Вічної Пісні, у парі з вишуканим арквином." }
    t[260264] = { name = "Пайок Кель'Данаса", fen = "A simple but nourishing bag of dense bread and dried meats.", fua = "Простий, але поживний мішок із щільним хлібом та в'яленим м'ясом." }
    t[260266] = { name = "Шипуча рідина", fen = "It bubbles and hisses.", fua = "Вона булькає й шипить." }
    t[260267] = { name = "Парений омар Гексс'алора", fen = "A whole lobster, harvested straight from the ocean, steamed in two fingers (troll) of Hexx'alor salt water.", fua = "Цілий омар, виловлений просто з океану, парений у двох (тролячих) пальцях солоної води Гексс'алора." }
    t[260268] = { name = "Лускатник із пюре", fen = "Thick slices of straw-seared Pango shank topping a heaping bowl of mashed spiced pinetatoes.", fua = "Товсті скибки засмаженої на соломі гомілки лускатника на верху повної миски пряного пюре зі шишкопкартоплі." }
    t[260269] = { name = "В'ялена кабаняча в'ялятина", fen = "Strips of dried boar meat, marinated first in tongue-melting conpeppers and a potent blend of spices.", fua = "Смужки в'яленого кабанячого м'яса, спершу замариновані в обпікаючих язик соснових перцях і насиченій суміші прянощів." }
    t[260270] = { name = "Болотяні Ніжки", fen = "An assortment of fried, leg-meat drumsticks. Meats include amazard, toad, boggorm, and all other manner of Leech Bog dwellers.", fua = "Добірка смажених гомілок із ніжного м'яса. Серед м'яса — амазард, жаба, болотогорм та інші мешканці П'явкового Болота." }
    t[260271] = { name = "Кореневий сік", fen = "Hand-squeezed roots, tubors, and toadstools sourced throughout Zul'Aman's clilffsides.", fua = "Видавлені вручну корені, бульби й поганки, зібрані на кручах Зул'Аману." }
    t[260272] = { name = "Міцний бок зі скель", fen = "Toasted malt flavor with a sharp bitter tang. Heavily preferred by Witherbark fishers on overcast afternoons.", fua = "Смак підсмаженого солоду з різкою гіркуватою ноткою. Дуже до вподоби рибалкам-візербаркам у похмурі пообіддя." }
    t[260273] = { name = "Чай туманів і дощу", fen = "A mix of fresh-cut buds and dried petals from the Miststone Wells, mixed warm with bear milk. Recommended before sleep to help rejuvenate sore muscles.", fua = "Суміш свіжозрізаних бруньок і сушених пелюсток із Туманокам'яних Джерел, заварена тепла на ведмежому молоці. Рекомендовано пити перед сном, щоб відновити втомлені м'язи." }
    t[260274] = { name = "Темна обсмажка з печерних грибів", fen = "Mushrooms harvested from Zul'Aman's caves, roasted for a day then ground into a fine powder. Mix with boiling water and drink to stay alert through any overnight hunt.", fua = "Гриби, зібрані в печерах Зул'Амана, обсмажені цілий день і змелені на дрібний порошок. Розведи в окропі й випий, щоб лишатися пильним усю ніч на полюванні." }
    t[260275] = { name = "Карі з мукліча", fen = "Overnight-boiled mukleech meat in a boggorm bone broth. Plate of assorted vegetables for dipping.", fua = "Вночі виварене м'ясо мукліча в бульйоні з кісток багнянки. Тарілка різних овочів для вмочання." }
    t[260276] = { name = "Акіл'юшка", fen = "A hearty mixture of herbs, vegetables, and fresh-butchered meats harvested from the mountains of southern Zul'Aman.", fua = "Ситна суміш трав, овочів і свіжозабитого м'яса, зібраних у горах південного Зул'Аману." }
    t[260277] = { name = "Ґумбо з осокового повзуна", fen = "A medly of fresh-caught river crawlers, prowlshrimp, and abasi muscles, simmered in a stock of bear sausage and sauteed greens. Spicy levels: Revantusk Hot, Amani Kick, Elf Child Mild.", fua = "Суміш свіжовиловлених річкових повзунів, креветок-нишпорок і м'язів абасі, тушкована в бульйоні з ведмежої ковбаси та смажених овочів. Рівні гостроти: ревантуська пекуча, аманійський кік, м'яка для ельфеняти." }
    t[260278] = "Салат із картопухи"
    t[260279] = "Світлоквітуча цибуля"
    t[260280] = "Смажені грибні бульби"
    t[260281] = "Смажене філе смолораптора"
    t[260282] = "Освіжна вода Ал'уа"
    t[260283] = "Ковток із гроту"
    t[260284] = "Прохолодний напій із батогогриба"
    t[260285] = "Екстракт світлоцвіту"
    t[260286] = "Гриби й нектар"
    t[260287] = "Бенкет світового коріння"
    t[260288] = "Бенкет, насичений альнопилом"
    t[260289] = { name = "Пайок рен'дорей", fen = "A single bite can yield an entire day of sustenance. The taste could be significantly improved.", fua = "Одного укусу вистачить, щоб наїстися на цілий день. Смак, утім, можна було б суттєво покращити." }
    t[260290] = { name = "Сир Кель'Таласа", fen = "Made far from the forests of Eversong, but the taste reminds some of home.", fua = "Зроблений далеко від лісів Лісу Вічної Пісні, та його смак декому нагадує домівку." }
    t[260291] = { name = "Зореглядний пудинг", fen = "It's more of a pastry, really.", fua = "Насправді це радше випічка." }
    t[260292] = { name = "Астероїдний суп", fen = "Little meatballs in a rich wine broth.", fua = "Маленькі фрикадельки в насиченому винному бульйоні." }
    t[260293] = { name = "Портвейн Порожнечі", fen = "Produced under less-than-ideal conditions, this drink will do the job.", fua = "Виготовлений у далеко не ідеальних умовах, цей напій усе ж зробить свою справу." }
    t[260294] = { name = "Абсент вирма Порожнечі", fen = "Drink too much and you'll start to see astral serpents.", fua = "Вип'єш забагато - і почнеш бачити астральних змій." }
    t[260295] = { name = "Очищена штормова вода", fen = "It has a strong metallic aftertaste.", fua = "Має виразний металевий присмак." }
    t[260296] = { name = "Чай із тінелисту", fen = "It smells like sleep.", fua = "Пахне сном." }
    t[260297] = { name = "Перепочинок Мандрівника Порожнечі", fen = "The meat changes, but the spices stay the same.", fua = "М'ясо змінюється, та прянощі лишаються ті самі." }
    t[260298] = { name = "Астральний яблучний пиріг", fen = "Contains no apples.", fua = "Не містить яблук." }
    t[260299] = { name = "Смажений вугор Безодні", fen = "This eel is definitely not from Azeroth.", fua = "Цей вугор однозначно не з Азероту." }
    t[260306] = { name = "Спотворений спогад", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[260309] = { name = "Гудлива рослинна матерія", fen = "Even after death, it pulses with life energy.", fua = "Навіть після смерті вона пульсує життєвою енергією." }
    t[260311] = { name = "Порожнє Ядро Вірма Скверни", fen = "Most of the fel magic has been drained. Maybe another infusion could reinvigorate it...", fua = "Більшість магії скверни висмоктано. Можливо, ще одне вливання могло б його оживити..." }
    t[260312] = "Накидка непокірного захисника"
    t[260314] = { name = "Прадавня Зброя Амані", fen = "Motes of spiritual and necrotic energy drift about the dull stone.", fua = "Довкола тьмяного каменя кружляють порошинки духовної та некротичної енергії." }
    t[260363] = { name = "Давній уламок", fen = "This mysterious rock fragment is carved with strange runes that glow with Void.", fua = "Цей загадковий уламок скелі вкритий дивними рунами, що сяють Порожнечею." }
    t[260368] = { name = "Бруд", fen = "Don't know what you expected.", fua = "Не знаю, чого ти сподівався." }
    t[260370] = "Лик незримих істин"
    t[260371] = "Пекельний пояс з великим замком"
    t[260372] = "Чоботи нуль-ступа"
    t[260373] = "Штани владної стійки"
    t[260374] = "Наплічники первісної іскри"
    t[260375] = "Пояс лютого шторму"
    t[260376] = "Нагрудник Останнього Рубежу"
    t[260377] = "Сабатони згасаючої зорі"
    t[260406] = { name = "Сторінка болю", fen = "Magical script is scrawled in jagged ink across the vellum.", fua = "По пергаменту нашкрябано магічний напис нерівним чорнилом." }
    t[260407] = { name = "Сторінка скуття", fen = "Simple incantations meant to hold a mortal against their will.", fua = "Прості заклинання, призначені втримати смертного проти його волі." }
    t[260408] = "Безсвітлий Плач"
    t[260410] = { name = "Надщерблений артефакт Клинка Сутінків", fen = "An unsightly artifact from the cultists' camp, roiling with the Void. The end that had been stuck inside the crab's carapace drips with void-infected blood.", fua = "Неоковирний артефакт із табору культистів, що вирує Порожнечею. З кінця, що застряг у панцирі краба, скрапує заражена Порожнечею кров." }
    t[260414] = "Амулет Висхідної Порожнечі"
    t[260417] = { name = "Припаси Корчедінів", fen = "Not inedible... just unpalatable.", fua = "Не те щоб неїстівне... просто несмачне." }
    t[260419] = { name = "Проклята Зандаларська Монета", fen = "Warm to the touch, despite sitting at the bottom of the sea.", fua = "Тепла на дотик, хоч і пролежала на дні моря." }
    t[260420] = { name = "Болотяне Яблуко", fen = "Yuck! Tastes like swamp!", fua = "Фу! На смак як болото!" }
    t[260423] = "Швидкоплинна згадка Аратора"
    t[260424] = { name = "Грудкуватий Жовчний Камінь", fen = "It takes a truly miserable goat to produce a gallstone this lumpy.", fua = "Такий грудкуватий жовчний камінь міг вирости хіба що в по-справжньому нещасної кози." }
    t[260425] = { name = "Шматочок Крабового М'яса", fen = "Sweet and briny.", fua = "Солодке й солонувате." }
    t[260426] = { name = "Закривавлений Точильний Камінь", fen = "The last proof of an ancient grievance.", fua = "Останній доказ давньої кривди." }
    t[260427] = { name = "Друга улюблена жувальна іграшка Нагуута", fen = "Almost as good as Gazlowe.", fua = "Майже така ж смачна, як Ґазлоу." }
    t[260431] = "Нашийник Річколуски"
    t[260432] = "Кольє Річколуски"
    t[260434] = "Штани мандрівника видінь"
    t[260435] = "Заплямовані штани маляра"
    t[260436] = "Поножі загубленого наставника"
    t[260437] = "Ткані штани Джа'кула"
    t[260439] = { name = "Відзнака чемпіона тиші й тіні", fen = "Awarded to the most perceptive among the Haranir.", fua = "Вручається найпроникливішим серед гаранірів." }
    t[260440] = "Квітучі спорові шати"
    t[260441] = "Накидка галактичного гладіатора"
    t[260443] = "Престижний плащ галактичного гладіатора"
    t[260444] = "Запасна туніка Ґікал"
    t[260446] = "Нагрудник, вкритий спорами"
    t[260447] = "Заражена грибами бригантина"
    t[260450] = "Перстень колишньої вартової коренів"
    t[260451] = "Перстень збереженої надії"
    t[260453] = { name = "Кліщ-п'явка", fen = "A bug uniquely capable of converting blood into tasty nutrients for other Zul'Aman wildlife to snack on.", fua = "Комаха з унікальною здатністю перетворювати кров на смачні поживні речовини, якими ласує інша звірина Зул'Аману." }
    t[260458] = "Фетиш Гелтри"
    t[260459] = "Горжет Гаала"
    t[260461] = "Шийна гривна Брулага"
    t[260468] = "Заляпані кров'ю кайдани"
    t[260469] = "Заляпані кров'ю манжети"
    t[260470] = "Заляпані кров'ю пов'язки"
    t[260471] = "Заляпані кров'ю обмотки"
    t[260472] = "Сокирка учня ка'шук"
    t[260473] = "Кинджал учня ка'шук"
    t[260474] = "Булава учня ка'шук"
    t[260475] = "Кий учня ка'шук"
    t[260476] = "Короткий меч учня ка'шук"
    t[260477] = "Довгий меч учня ка'шук"
    t[260478] = "Бойова глефа учня ка'шук"
    t[260479] = "Довгий лук учня ка'шук"
    t[260481] = "Спис учня ка'шук"
    t[260482] = "Посох учня ка'шук"
    t[260483] = "Великий меч учня ка'шук"
    t[260523] = "Кріс фарбороба"
    t[260524] = "Мішалка фарбороба"
    t[260525] = "Булава фарбороба"
    t[260526] = "Рапіра фарбороба"
    t[260527] = "Ціпок фарбороба"
    t[260528] = "Есток фарбороба"
    t[260529] = "Скребок фарбороба"
    t[260530] = "Палітра фарбороба"
    t[260531] = { name = "Фрагмент кристалізованої смоли", fen = "Sap from Teldrassil, crystalized by the fire.", fua = "Смола з Тельдрассилу, кристалізована вогнем." }
    t[260534] = { name = "Надлишкові реагенти майстра-алхіміка", fen = "Filled with reagents fit for an experienced alchemist... and possibly a recipe!", fua = "Повний реагентів, гідних досвідченого алхіміка... а може, і рецепта!" }
    t[260536] = { name = "Надлишкові реагенти майстра-коваля", fen = "Filled with reagents fit for an experienced blacksmith... and possibly a recipe!", fua = "Повний реагентів, гідних досвідченого коваля... а може, і рецепта!" }
    t[260537] = { name = "Надлишкові реагенти майстра-зачаровувача", fen = "Filled with reagents fit for an experienced enchanter... and possibly a recipe!", fua = "Повний реагентів, гідних досвідченого зачаровувача... а може, і рецепта!" }
    t[260538] = { name = "Надлишкові реагенти майстра-інженера", fen = "Filled with reagents fit for an experienced engineer... and possibly a recipe!", fua = "Повний реагентів, гідних досвідченого інженера... а може, і рецепта!" }
    t[260539] = { name = "Надлишкові реагенти майстра-травника", fen = "Filled with reagents fit for an experienced herbalist... and possibly a recipe!", fua = "Повний реагентів, гідних досвідченого травника... а може, і рецепта!" }
    t[260540] = { name = "Надлишкові реагенти майстра-писаря", fen = "Filled with reagents fit for an experienced scribe... and possibly a recipe!", fua = "Повний реагентів, гідних досвідченого писаря... а може, і рецепта!" }
    t[260541] = { name = "Надлишкові реагенти майстра-ювеліра", fen = "Filled with reagents fit for an experienced jewelcrafter... and possibly a recipe!", fua = "Повний реагентів, гідних досвідченого ювеліра... а може, і рецепта!" }
    t[260542] = { name = "Надлишкові реагенти майстра-шкіряра", fen = "Filled with reagents fit for an experienced leatherworker... and possibly a recipe!", fua = "Повний реагентів, гідних досвідченого шкіряра... а може, і рецепта!" }
    t[260543] = { name = "Надлишкові реагенти майстра-шахтаря", fen = "Filled with reagents fit for an experienced miner... and possibly a recipe!", fua = "Повний реагентів, гідних досвідченого шахтаря... а може, і рецепта!" }
    t[260544] = { name = "Надлишкові реагенти майстра-чинбаря", fen = "Filled with reagents fit for an experienced skinner... and possibly a recipe!", fua = "Повний реагентів, гідних досвідченого чинбаря... а може, і рецепта!" }
    t[260545] = { name = "Надлишкові реагенти майстра-кравця", fen = "Filled with reagents fit for an experienced tailor... and possibly a recipe!", fua = "Повний реагентів, гідних досвідченого кравця... а може, і рецепта!" }
    t[260585] = { name = "Лінда Щаслива", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[260587] = { name = "Ритуальний Кинджал", fen = "A ritual dagger chiseled from obsidian and jade. Its pommel bears the head of a snake. You know why. And you know what must be done.", fua = "Ритуальний кинджал, вирізьблений з обсидіану й нефриту. На його навершші — голова змії. Ти знаєш чому. І знаєш, що треба зробити." }
    t[260589] = { name = "Благословенний полум'ям пляжний рушник", fen = "Moisture doesn't stand a chance. +10 Dryness", fua = "Волога не має жодного шансу. +10 до сухості" }
    t[260590] = { name = "Штормаріонове ядро Маелли", fen = "An energized core charged with potent energy.", fua = "Заряджене ядро, повне потужної енергії." }
    t[260603] = "Тендітне гнучке крило"
    t[260604] = "Линька комахи"
    t[260605] = "Розбитий вістря списа"
    t[260606] = "Світле кошлате хутро"
    t[260608] = "Роздуті рештки тварини"
    t[260611] = "Велика звірина луска"
    t[260613] = "Квітка Світлоцвіту"
    t[260614] = "Невпізнаваний орган"
    t[260615] = "Залишки пилу Порожнечі"
    t[260616] = "М'які морські гриби"
    t[260617] = "Великі поламані зуби"
    t[260618] = "Просякнуте Світлом листя"
    t[260619] = "Барвисте листя"
    t[260620] = "Кам'яні уламки"
    t[260621] = "Магією просякнута кора"
    t[260630] = "Хитромудрий ідентифікатор"
    t[260635] = { name = "Кривавий мучитель", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[260636] = "Камінь, укритий водоростями"
    t[260637] = "Гнилі яйця комах"
    t[260638] = "Тонкий осад Порожнечі"
    t[260639] = "Зламана кістка"
    t[260640] = "Кривські пташині пазурі"
    t[260641] = "Сухі вусики"
    t[260642] = "Скам'янілі дикі тварини"
    t[260643] = "Купа пір'я"
    t[260644] = "Кора Світлоцвіту"
    t[260645] = "Орган, наповнений водою"
    t[260646] = "Сяйлива залоза"
    t[260647] = "Перетравлена людська рука"
    t[260648] = "Подертий одяг"
    t[260649] = "Барвистий вир"
    t[260650] = "Стихійні уламки"
    t[260651] = "Лискуча шкура дикого звіра"
    t[260652] = "Зламаний звіриний кіготь"
    t[260653] = "Великі гриби світлоцвіту"
    t[260654] = "Абразивний пісок"
    t[260655] = "Зотліла гуманоїдна плоть"
    t[260656] = "Продірявлене крило"
    t[260657] = "Дірявий орган"
    t[260658] = "Уламок кристалічної породи"
    t[260659] = "Залишки зоряного вихору"
    t[260660] = "Гнилі грибні спори"
    t[260661] = "Сяйливий кущ"
    t[260662] = "Полірований фіолетовий камінець"
    t[260663] = "Залишок Світлоцвіту"
    t[260664] = "Біолюмінесцентні пелюстки квітів"
    t[260665] = "Чималий бивень"
    t[260666] = "Землистий Гриб"
    t[260667] = "Осквернені органи"
    t[260668] = "Каламутний фіолетовий самоцвіт"
    t[260669] = "Безбарвні камінці"
    t[260670] = "Закривавлений зламаний дзьоб"
    t[260671] = "Завелика залоза"
    t[260672] = "Сморідне око"
    t[260673] = "Частково перетравлені наручі"
    t[260674] = "Тонкий арканний пил"
    t[260675] = "Світлисте насіння"
    t[260676] = "Непримітний кристал"
    t[260677] = "Пластівці Порожнечі"
    t[260678] = "Гострий шматок обсидіану"
    t[260679] = "Кістка без плоті"
    t[260680] = "Матеріали для гнізда"
    t[260681] = "Просякнуті Світлоцвітом спори"
    t[260682] = "Іржаве кільце з ікла"
    t[260683] = "Тонкий пурпуровий пісок"
    t[260684] = "Гостра луска"
    t[260685] = "Велика крихка кістка"
    t[260686] = "Барвисті крила"
    t[260687] = "Зотліла шкіра"
    t[260688] = "Екзоскелет комахи"
    t[260689] = "Тонкий біолюмінесцентний порошок"
    t[260690] = "Похмурий корінь"
    t[260691] = "Хутро, осквернене Порожнечею"
    t[260692] = "Брила загадкового м'яса"
    t[260693] = "Замшілий грудень землі"
    t[260694] = "Смердюча ламінарія"
    t[260695] = "Гнилі водні рештки"
    t[260696] = { name = "Зв'язаний Порожнечею штормоскат", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[260697] = { name = "Лабораторний штормоскат", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[260705] = { name = "Помічник ботаніка Листик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[260730] = { name = "Збентежений спорокажан", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[260832] = "Імлистий присмерковий шолом"
    t[260833] = "Каптур нескінченного тяжіння"
    t[260834] = "Каптур Нескінченного Вихору"
    t[260835] = "Шолом колосальних бегемотів"
    t[260836] = "Імлисті присмеркові рукавиці"
    t[260837] = "Латні рукавиці безмежної гравітації"
    t[260838] = "Поножі Нескінченного Вихору"
    t[260839] = "Хват колосальних бегемотів"
    t[260840] = "Імлистий присмерковий пояс"
    t[260841] = "Пояс нескінченної гравітації"
    t[260842] = "Пояс Нескінченного Вихору"
    t[260843] = "Поясний обладунок колосальних бегемотів"
    t[260844] = "Імлисті присмеркові штани"
    t[260845] = "Поножі нескінченної гравітації"
    t[260846] = "Штани Нескінченного Вихору"
    t[260847] = "Штани колосальних бегемотів"
    t[260848] = "Маяк Холодного Полум'я"
    t[260854] = "Імлисті присмеркові наплічники"
    t[260855] = "Наплічники нескінченної гравітації"
    t[260856] = "Накидка Нескінченного Вихору"
    t[260857] = "Наплічники колосальних бегемотів"
    t[260858] = "Намисто з напівтіньових самоцвітів"
    t[260859] = "Колюче намисто"
    t[260860] = "Імлисті присмеркові наручі"
    t[260861] = "Браслети Нескінченної Гравітації"
    t[260862] = "Наручі Нескінченного Вихору"
    t[260863] = "Незламні налокітники колосальних бегемотів"
    t[260864] = "Імлиста присмеркова мантія"
    t[260865] = "Жилет безмежної гравітації"
    t[260866] = "Кольчуга Нескінченного Вихору"
    t[260867] = "Нагрудник Колосальних Бегемотів"
    t[260878] = "Дар Можливостей"
    t[260879] = "Дар Сили"
    t[260882] = "Дар Потуги"
    t[260884] = "Дар Поміркованості"
    t[260887] = { name = "Морочний гнобитель", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[260890] = { name = "Торба шампурів", fen = "Ready for stabbing.", fua = "Готові до проштрикування." }
    t[260892] = "Набір «Арканний рейнджер»"
    t[260898] = "Загублене лазурове лезо"
    t[260900] = "Загублений Громовий Кулак"
    t[260901] = "Загублений костур норкової звивистості"
    t[260902] = "Загублений скіпетр заходу сонця"
    t[260903] = "Загублений розколювач Сонячного Колодязя"
    t[260904] = "Збирач загублених душ"
    t[260905] = "Загублений клинок просторового сходження"
    t[260907] = "Голод загубленої зими"
    t[260908] = "Останній бій загубленого Морозного Вовка"
    t[260910] = "Дар Життєвої Сили"
    t[260911] = "Дар Стійкості"
    t[260913] = "Багряне благословення"
    t[260918] = "Порив фанатика"
    t[260922] = { name = "Фідофікус", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[260924] = "Благословення вартового"
    t[260940] = { name = "Переможна вершинна скриня Штормаріона", fen = "Weekly cache containing materials for upgrading gear, gold, coffer key shards, and more.\n\n\n\nThe first two pinnacle caches you earn each week contain a piece of Veteran equipment.", fua = "Щотижнева скриня з матеріалами для поліпшення спорядження, золотом, уламками ключа від реліквієвої скрині тощо.\n\n\n\nПерші дві найвищі скрині, здобуті за тиждень, містять предмет спорядження ветерана." }
    t[260942] = { name = "Булькітливий кусачок", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[260948] = { name = "Загадкова сурма Порожнечі", fen = "In darkness, unbind us.", fua = "У темряві визволи нас." }
    t[260979] = { name = "Переможна скриня Штормаріона", fen = "Contains Stormarion Cores, Voidlight Marl, Gold, and more.", fua = "Містить ядра Штормаріона, пил світла Порожнечі, золото та інше." }
    t[262342] = { name = "Спорміліан", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[262343] = { name = "Треджа'сака", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[262346] = { name = "Скриня шукача здобичі для чемпіона", fen = "A chest containing a random piece of Champion equipment, supplies, gold, and a chance for professions materials.", fua = "Скриня з випадковим предметом спорядження чемпіона, припасами, золотом і шансом на матеріали для професій." }
    t[262354] = "Камінь Розлому"
    t[262355] = "Ентропійне світило"
    t[262356] = "Консерванти гаранірів"
    t[262375] = "Древкова зброя, насичена темрявою"
    t[262376] = "Кинджал вічної Порожнечі"
    t[262389] = "Запнуте благословення"
    t[262390] = { name = "Спорбі", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[262391] = { name = "Зловісний Домінус", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[262392] = { name = "Гризунчик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[262393] = { name = "Кріпа'зойд", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[262394] = { name = "Зіорґ'фарон", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[262395] = { name = "Заврочене зайченя", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[262396] = { name = "Загублена зірка", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[262431] = "Пружний Гриб"
    t[262450] = "Зачарована мітла"
    t[262451] = "Позолочене ковадло Сільвермуна"
    t[262452] = "Майстерний ремісничий молот"
    t[262455] = "Джерело осяйної води"
    t[262456] = "Оздобна вішалка із Сільвермуна"
    t[262457] = "Позолочена вішалка Сільвермуна"
    t[262458] = "Оживлена кирка сін'дорей"
    t[262459] = "Оживлений молот сін'дорей"
    t[262460] = "Ковадло рен'дорей"
    t[262461] = "Темітлива армілярна сфера рен'дорей"
    t[262465] = "Зорегляд рен'дорей"
    t[262468] = "Поштове сховище рен'дорей"
    t[262470] = "Зачарований фоліант таласійської магії"
    t[262496] = { name = "Арканний голем дослідника Глибин", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[262500] = { name = "Чародійний захисник Сільвермуна", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[262502] = { name = "Ельфійський Арканний Вартовий", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[262510] = { name = "Яйце яструбоступа", fen = "Something is making noises inside. It's going to hatch soon!", fua = "Усередині щось ворушиться. Скоро вилупиться!" }
    t[262578] = "Каменотесний різець амані"
    t[262579] = "Різак для шкур амані"
    t[262580] = "Колун амані"
    t[262581] = "Каменотесний молот амані"
    t[262582] = "Лещата для самоцвітів амані"
    t[262584] = "Бездонна Торба Амулетів Висхідної Порожнечі"
    t[262586] = { name = "Прадавній арканний останок", fen = "Shimmers of untold stories and ancient secrets.", fua = "Мерехтить незліченними нерозказаними історіями та древніми таємницями." }
    t[262589] = "Простий стіл гаранірів"
    t[262590] = "Багаття кореневого полум'я"
    t[262620] = { name = "Лиховісне Стерво", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[262621] = { name = "Одужне Стерво", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[262635] = { name = "Сховок здобичі дослідника глибин", fen = "Rewards a piece of Champion equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження чемпіона для вашої спеціалізації здобичі." }
    t[262644] = { name = "За обрієм подій: ковальство", fen = "A magazine depicting all the ways artisan crafters improve their skills.", fua = "Журнал, що описує всі способи, якими майстри-ремісники вдосконалюють свої вміння." }
    t[262645] = { name = "За обрієм подій: алхімія", fen = "A magazine depicting all the ways artisan crafters improve their skills.", fua = "Журнал, що описує всі способи, якими майстри-ремісники вдосконалюють свої вміння." }
    t[262646] = { name = "За обрієм подій: інженерія", fen = "A magazine depicting all the ways artisan crafters improve their skills.", fua = "Журнал, що описує всі способи, якими майстри-ремісники вдосконалюють свої вміння." }
    t[262649] = { name = "Глибоке занурення рибалки", fen = "An extensive ledger of diving preparedness. Perhaps of use to someone in your Warband.", fua = "Докладний посібник з підготовки до занурень. Можливо, стане в пригоді комусь із вашої бойової ватаги." }
    t[262650] = { name = "Звивистий черв'як-крутько", fen = "Great for catching fish across Quel'Thalas.", fua = "Чудово ловить рибу по всьому Кель'Таласі." }
    t[262651] = { name = "Гострий колючий слимак", fen = "Carefully attaching this to your rod is bound to keep you on your toes.", fua = "Обережне закріплення його на вудці точно тримає тебе в напрузі." }
    t[262654] = { name = "Відбиток таблиці амані", fen = "There are possible clues, but no overt references to Ula'tek.", fua = "Тут є можливі підказки, але жодних прямих згадок про Ула'тек." }
    t[262658] = { name = "Туманний сховок Порожнечі: Падіння Опівночі", fen = "Transmute two Nebulous Voidcores into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює два туманні ядра Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[262659] = { name = "Фетиш чарів Лихогіллі", fen = "A small trinket that emanates necromantic power.", fua = "Маленька дрібничка, що випромінює некромантичну силу." }
    t[262662] = { name = "Таласська відзнака", fen = "Contains 5 Marks of Honor.", fua = "Містить 5 знаків честі." }
    t[262669] = "Сокира, торкнута Порожнечею"
    t[262670] = "Кинджал, торкнутий Порожнечею"
    t[262671] = "Бойова глефа спустошення"
    t[262672] = "Залізні кулаки Вічної Порожнечі"
    t[262673] = "Лук, торкнутий Порожнечею"
    t[262674] = "Щит спустошення"
    t[262675] = "Палиця, торкнута Порожнечею"
    t[262677] = "Кинджал темряви"
    t[262678] = "Лук Великої Темряви"
    t[262729] = "Рука хранителя коренів"
    t[262730] = "Сокира спустошення"
    t[262731] = "Дикотерновий гостроклик"
    t[262732] = "Важкий терновий арбалет"
    t[262733] = "Меч темновбивці"
    t[262735] = "Меч спустошення"
    t[262737] = "Сокира Великої Темряви"
    t[262738] = "Сокира Вічної Порожнечі"
    t[262739] = "Меч вічної Порожнечі"
    t[262741] = "Набір «Стрибок розвіювання»"
    t[262742] = "Набір «Прудкість»"
    t[262743] = "Набір «Поле нейтралізації»"
    t[262744] = "Набір «Хода Розломом»"
    t[262745] = "Набір «Маскування»"
    t[262746] = "Набір «Механічний вартовий»"
    t[262752] = { name = "Сувій Лихогіллі", fen = "A possible clue relating to Malacrass's research on Ula'tek.", fua = "Можливий ключ до досліджень Малакрасса щодо Ула'тек." }
    t[262755] = "Підсилення «Ексцентро-магічний імпульс»"
    t[262756] = "Підсилення «Створити приманку»"
    t[262757] = "Підсилення «Велика метаморфоза»"
    t[262787] = { name = "Виловлений Запис із Щоденника", fen = "Barely legible but perhaps of use to someone in your Warband.", fua = "Ледь розбірливий, але, можливо, стане в пригоді комусь із твоєї бойової ватаги." }
    t[262791] = { name = "Нотатки Малакрасса", fen = "An old collection of scrolls containing notes and incantations from a long-dead Hex Lord.", fua = "Стара збірка сувоїв з нотатками й заклинаннями давно померлого Володаря чарів." }
    t[262792] = { name = "Подерта квіткова волосінь", fen = "A very small piece of a skillful Midnight Angler's fishing rod.", fua = "Зовсім крихітний шматочок вудки вмілого рибалки Опівночі." }
    t[262793] = { name = "Прибита квітколіска", fen = "A small piece of a skillful Midnight Angler's fishing rod.", fua = "Маленький шматок вудки вправного Опівнічного Рибалки." }
    t[262794] = { name = "Слабка квітколіска", fen = "A piece of a skillful Midnight Angler's fishing rod.", fua = "Частина вудки вправного Опівнічного рибалки." }
    t[262795] = { name = "Квітуча волосінь рибалки", fen = "The final piece of a skillful Midnight Angler's fishing rod.", fua = "Остання деталь вудки вмілого рибалки Опівночі." }
    t[262796] = { name = "Велична волосінь рибалки Опівночі", fen = "The perfect line for a Midnight Angler's fishing rod.", fua = "Ідеальна волосінь для вудки рибалки Опівночі." }
    t[262797] = { name = "Подерта мерехтлива волосінь", fen = "A very small piece of a perceptive Midnight Angler's fishing rod.", fua = "Зовсім крихітний шматочок вудки проникливого рибалки Опівночі." }
    t[262798] = { name = "Прибита мерехтлива волосінь", fen = "A small piece of a perceptive Midnight Angler's fishing rod.", fua = "Маленький шматок вудки проникливого Опівнічного Рибалки." }
    t[262799] = { name = "Слабка мерехтиліска", fen = "A piece of a perceptive Midnight Angler's fishing rod.", fua = "Частина вудки спостережливого Опівнічного рибалки." }
    t[262800] = { name = "Мерехтлива волосінь рибалки", fen = "The final piece of a perceptive Midnight Angler's fishing rod.", fua = "Остання деталь вудки проникливого рибалки Опівночі." }
    t[262886] = { name = "Цвіт Солодкопилки", fen = "Serrated petals and leaves make plucking this plant from the muck a difficult task. A scent somewhere between honey and the iron tang of blood lingers around its dangerous bloom.", fua = "Зазубрені пелюстки й листя роблять виривання цієї рослини з багнюки нелегкою справою. Довкола її небезпечного цвіту витає запах — щось середнє між медом і залізним присмаком крові." }
    t[262904] = { name = "Ектоплазма", fen = "A globe of softly glowing energy with a slightly slimy, squishy feel to it.", fua = "Кулька м'якого сяйва енергії, трохи слизька й м'якенька на дотик." }
    t[262908] = "Помел"
    t[262911] = { name = "Тренувальна сокира", fen = "The head is barely hanging on to this training weapon, the hilt splintered and worn. It has seen extensive use.", fua = "Лезо цієї тренувальної зброї ледь тримається на держаку, а руків'я потріскане й стерте. Вона багато попрацювала." }
    t[262914] = { name = "Примарний яструбоступ", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[262928] = { name = "Мішок шукача здобичі для шукача пригод", fen = "A sack containing supplies, gold, and a chance for professions materials.", fua = "Мішок із припасами, золотом і шансом на матеріали для ремесел." }
    t[262936] = { name = "Ветеранський мішок Шукача Здобичі", fen = "A sack containing supplies, gold, and a chance for professions materials.", fua = "Мішок із припасами, золотом і шансом на матеріали для ремесел." }
    t[262938] = { name = "Мішок шукача здобичі для чемпіона", fen = "A sack containing supplies, gold, and a chance for professions materials.", fua = "Мішок із припасами, золотом і шансом на матеріали для ремесел." }
    t[262951] = "Надгробок сін'дорей"
    t[262963] = "Благочестивий меморіал"
    t[262964] = "Надія смерті"
    t[262965] = "Втіха дослідника Глибин"
    t[262966] = "Доступна заміна"
    t[262967] = { name = "Дуельний прапор доманаарів", fen = "Carve your way.", fua = "Проклади собі шлях." }
    t[262970] = { name = "Зловісний фоліант", fen = "The first page was ripped out and the rest were left blank.", fua = "Першу сторінку видерто, а решта лишилися порожніми." }
    t[262973] = "Експедиційні нотатки Реліквіарію"
    t[262983] = "Архівна магнібулава"
    t[262984] = "Експедиційна торба Реліквіарію"
    t[262989] = "Релікварний келеп пильнозору"
    t[262990] = "Арканний манускрипт сін'дорей"
    t[262991] = "Дві тисячі і дві ночі"
    t[262992] = "Пензель творця міфів"
    t[262999] = { name = "Люма", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[263009] = "Лиховісний ніж Валіри"
    t[263178] = { name = "Початковий набір дослідника Глибин", fen = "Contains 200 Coffer Key Shards.", fua = "Містить 200 уламків ключа від скрині." }
    t[263179] = { name = "Косметична торба-сюрприз дослідника Глибин", fen = "Contains a random delve cosmetic for your warband.", fua = "Містить випадковий косметичний предмет Глибин для твоєї бойової ватаги." }
    t[263185] = { name = "Зогнила Дошка", fen = "Floats in venom, at least for a little bit.", fua = "Плаває в отруті — принаймні якийсь час." }
    t[263188] = "Відновлений ключ від скрині"
    t[263191] = "Відновлений ключ від скрині"
    t[263193] = { name = "Пов'язки мисливця на тролів", fen = "Talon marks from Muro'jin beloved pet, Nekraxx, scar these bands' surface.", fua = "Сліди кігтів від улюбленця Муро'джина, Некраксса, шрамами вкривають поверхню цих пов'язок." }
    t[263198] = "Особлива Страва Валдекара"
    t[263202] = { name = "Рисориба на шпажці по-мурлоцьки", fen = "A lynxfish cooked in the traditional murloc style... you think.", fua = "Рисориба, приготована за традиційним мурлоцьким рецептом... як ти гадаєш." }
    t[263208] = "Комплект: тканинна броня галактичного претендента"
    t[263210] = "Комплект: шкіряна броня галактичного претендента"
    t[263213] = "Комплект: кольчужна броня галактичного претендента"
    t[263214] = "Комплект: латна броня галактичного претендента"
    t[263215] = "Арсенал: зброя галактичного претендента"
    t[263217] = "Комплект: тканинна броня галактичного паліїя війни"
    t[263218] = "Комплект: шкіряна броня галактичного паліїя війни"
    t[263219] = "Комплект: кольчужна броня галактичного паліїя війни"
    t[263220] = "Комплект: латна броня галактичного паліїя війни"
    t[263221] = "Арсенал: зброя галактичного паліжвійни"
    t[263222] = { name = "Аркано-порожнечний конструкт", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[263244] = "Загадковий Фонтан"
    t[263265] = "Кушак захисника Гара'ті"
    t[263267] = "Шнур захисника Гара'ті"
    t[263268] = "Пояс захисника Гара'ті"
    t[263269] = "Широкий пояс захисника Гара'ті"
    t[263272] = "Штани Фліґа"
    t[263273] = "Шкіряні обмотки Фліґа"
    t[263274] = "Поножі Фурґа"
    t[263275] = "Латні поножі Фурґа"
    t[263278] = "Хвилевитканий серпанок"
    t[263279] = "Хвилевиткана маска"
    t[263280] = "Хвилевиткана шапочка"
    t[263281] = "Хвилевикуваний великий шолом"
    t[263282] = "Перероблена нестабільна манокомірка"
    t[263283] = "Кинджал вартового гаю"
    t[263284] = "Посох вартового гаю"
    t[263285] = "Великий меч вартового гаю"
    t[263286] = "Перероблений гонг фунґаріан"
    t[263287] = "Загублений короткий лук охоронця Реліквіарію"
    t[263289] = "Влада володаря спор"
    t[263324] = "Викинутий ланцюг Тайталора"
    t[263325] = "Найменш улюблене намисто Тайталора"
    t[263326] = { name = "Капелюх від сонця Мірведи", fen = "She won't be needing it anymore.", fua = "Він їй більше не знадобиться." }
    t[263327] = "Покриття, обтяжене спорами"
    t[263328] = "Каптур хранителя санктуму"
    t[263331] = "Здерев'янілий шолом"
    t[263334] = "Мантія вельможі Золотого Туману"
    t[263341] = { name = "Примарне Вариво", fen = "This glowing bottle feels almost like it will pass through your hands, but it is somehow corporeal enough to be held. Within, a softly glowing substance sloshes around, making no sound and having no smell. Do you dare to try a sip?", fua = "Ця сяйлива пляшка ніби от-от прослизне крізь твої руки, та все ж вона достатньо тілесна, щоб її тримати. Усередині хлюпає м'яко сяйлива речовина: без жодного звуку й без запаху. Наважишся сьорбнути?" }
    t[263343] = "Туніка кусач-дракона"
    t[263344] = "Кольчуга вічноспівного далекохода"
    t[263345] = "Нагрудник захисника Золотого Туману"
    t[263346] = "Комплект: броня лицаря смерті галактичного гладіатора"
    t[263347] = "Комплект: броня мисливця на демонів галактичного гладіатора"
    t[263348] = { name = "Фіолетовий — новий чорний", fen = "It pairs with everything. And more importantly, with the nothingness of the endless void.", fua = "Пасує до всього. А головне — до небуття нескінченної Порожнечі." }
    t[263349] = "Шаль магістра"
    t[263350] = { name = "Фанфік про Провісницю", fen = "Not as badly written as you would have expected.", fua = "Написано не так погано, як можна було очікувати." }
    t[263351] = "Плащ учня"
    t[263352] = "Каптур далекоходів"
    t[263353] = "Накриття Лицаря крові"
    t[263354] = { name = "Як заповнити Порожнечу у твоєму серці", fen = "Even if no one loves you, Nothingness will.", fua = "Навіть якщо тебе ніхто не любить, Ніщо полюбить." }
    t[263355] = "Комплект: броня друїда галактичного гладіатора"
    t[263356] = "Комплект: броня пробуджувача галактичного гладіатора"
    t[263357] = "Комплект: броня мисливця галактичного гладіатора"
    t[263358] = "Штани щура Завулку"
    t[263359] = "Кольчужні штани щура Завулку"
    t[263360] = "Комплект: броня мага галактичного гладіатора"
    t[263361] = { name = "Курячий суп для бездушних", fen = "If you can get past the Void propaganda, the purple poulet stew actually sounds pretty good.", fua = "Якщо абстрагуватися від пропаганди Порожнечі, фіолетове куряче рагу звучить насправді доволі смачно." }
    t[263362] = "Штани щура Завулку"
    t[263363] = "Комплект: броня монаха галактичного гладіатора"
    t[263364] = "Поножі щура Завулку"
    t[263365] = "Комплект: броня паладина галактичного гладіатора"
    t[263366] = "Комплект: броня жерця галактичного гладіатора"
    t[263367] = "Комплект: броня розбійника галактичного гладіатора"
    t[263368] = { name = "Армагедон і ти — Посібник початківця з процвітання в апокаліпсисі", fen = "A collection of useful tips and tricks for living your best life after the Void consumes the world.", fua = "Збірка корисних порад і хитрощів, як жити на повну після того, як Порожнеча поглине світ." }
    t[263369] = "Комплект: броня шамана галактичного гладіатора"
    t[263370] = "Комплект: броня чорнокнижника галактичного гладіатора"
    t[263371] = "Комплект: броня воїна галактичного гладіатора"
    t[263372] = "Арсенал: зброя галактичного гладіатора"
    t[263373] = { name = "Не повіриш, що це не Порожнеча", fen = "You may never harness the pure cosmic power of the Void, but 4/5 warlocks recommend shadow magic as a substitute. Your victims will never know the difference!", fua = "Можливо, ти ніколи не опануєш чисту космічну силу Порожнечі, та 4 із 5 чорнокнижників радять тіньову магію як заміну. Твої жертви ніколи не помітять різниці!" }
    t[263374] = "Еполети архіваріуса"
    t[263375] = "Наплічники культиста"
    t[263376] = "Наплічники Фейрсонг"
    t[263377] = { name = "Ксал-а-Друг", fen = "Xal-a-Pal sees you. Xal-a-Pal loves you. Xal-a-Pal would never sacrifice you for momentary gain.", fua = "Ксал-а-Друг бачить тебе. Ксал-а-Друг любить тебе. Ксал-а-Друг ніколи не пожертвував би тобою заради миттєвої вигоди." }
    t[263378] = "Наплічники Світанкового Серця"
    t[263379] = { name = "Особиста рекламна платформа", fen = "Sharing your opinions on the upcoming apocalypse and the tyranny of shoes has never been easier.", fua = "Ділитися своїми поглядами на прийдешній апокаліпсис і тиранію взуття ще ніколи не було так легко." }
    t[263380] = { name = "Вербувальні брошури", fen = "\"What has the Light done for you recently?\", \"Is that nagging sense of doom paranoia, or prescience?\", \"Do you like purple?\", and other classics.", fua = "«Що Світло зробило для тебе останнім часом?», «Це настирливе відчуття приреченості — параноя чи передбачення?», «Ти любиш фіолетовий?» та інша класика." }
    t[263381] = { name = "Настінні сувої Ксал'атат", fen = "Some are even tasteful.", fua = "Деякі навіть зі смаком." }
    t[263382] = { name = "Сутінкове спорядження", fen = "The void tainted equipment that the Twilight's Blade uses to arm their cultists.", fua = "Заплямоване Порожнечею спорядження, яким Клинок Сутінків озброює своїх культистів." }
    t[263384] = "Комплект: Броня лицаря смерті елітного галактичного гладіатора"
    t[263385] = "Комплект: Броня мисливця на демонів елітного галактичного гладіатора"
    t[263386] = "Комплект: Броня друїда елітного галактичного гладіатора"
    t[263387] = "Комплект: Броня пробуджувача елітного галактичного гладіатора"
    t[263388] = "Комплект: броня мисливця галактичного гладіатора-елітника"
    t[263389] = "Комплект: броня мага галактичного гладіатора-елітника"
    t[263390] = "Комплект: броня монаха галактичного гладіатора-елітника"
    t[263391] = "Комплект: броня паладина галактичного гладіатора-елітника"
    t[263392] = "Комплект: броня жерця галактичного гладіатора-елітника"
    t[263393] = "Комплект: броня розбійника галактичного гладіатора-елітника"
    t[263394] = "Комплект: броня шамана галактичного гладіатора-елітника"
    t[263395] = "Комплект: броня чорнокнижника галактичного гладіатора-елітника"
    t[263396] = "Комплект: броня воїна галактичного гладіатора-елітника"
    t[263397] = "Арсенал: зброя галактичного гладіатора-елітника"
    t[263400] = { name = "Сховок здобичі дослідника глибин", fen = "Rewards a piece of Hero equipment for your Loot Specialization.", fua = "Дає предмет спорядження рівня «Герой» для твоєї спеціалізації здобичі." }
    t[263413] = "Нуллей Доманоок"
    t[263416] = "Ткані черевики бібліотекаря"
    t[263419] = "Взуття рекрута далекоходів"
    t[263427] = "Чоботи вічноспівного природознавця"
    t[263429] = "Копитники Вічної Пісні"
    t[263433] = { name = "Переповнений скарб Сільвермуна", fen = "Contains a variety of rewards for those who have proven themselves true allies of the Silvermoon Court.", fua = "Містить різноманітні нагороди для тих, хто довів, що є справжнім союзником Двору Сільвермуна." }
    t[263437] = "Потьмянілий перстень Ґідвіна"
    t[263438] = "Запорошений перстень Таренара"
    t[263442] = "Доманське око, поглинуте Порожнечею"
    t[263443] = { name = "Техніка: Контракт: Гара'ті", fen = "Teaches you how to craft Contract: The Hara'ti.", fua = "Навчає вас виготовляти Контракт: Гара'ті." }
    t[263444] = { name = "Техніка: Контракт: Двір Сільвермуна", fen = "Teaches you how to craft Contract: The Silvermoon Court.", fua = "Навчає вас виготовляти Контракт: Двір Сільвермуна." }
    t[263445] = { name = "Техніка: Контракт: Сингулярність", fen = "Teaches you how to craft Contract: The Singularity.", fua = "Навчає вас виготовляти Контракт: Сингулярність." }
    t[263446] = { name = "Запасний костюм мурлока", fen = "You're not sure who wore this last, but it smells like someone who never took it off.", fua = "Ти не певен, хто носив його останнім, але пахне він так, наче той ніколи його не знімав." }
    t[263447] = "Тесак Вічної Пісні"
    t[263454] = "Записник таласського алхіміка"
    t[263455] = "Журнал таласського коваля"
    t[263456] = "Записник таласського інженера"
    t[263457] = "Журнал таласського писаря"
    t[263458] = "Записник таласського ювеліра"
    t[263459] = "Журнал таласського шкіряра"
    t[263460] = "Записник таласського кравця"
    t[263461] = "Нотатки таласського чинбаря"
    t[263462] = "Нотатки таласського травника"
    t[263463] = "Нотатки таласського гірника"
    t[263464] = "Фоліант таласського зачаровувача"
    t[263465] = { name = "Лишкова торба святкових гостинців", fen = "Weekly cache containing materials for upgrading equipment, gold, coffer key shards, and more.\n\n\n\nThe first two pinnacle caches you earn each week contain a piece of Veteran equipment.", fua = "Щотижнева скриня з матеріалами для поліпшення спорядження, золотом, уламками ключа від реліквієвої скрині тощо.\n\n\n\nПерші дві найвищі скрині, здобуті за тиждень, містять предмет спорядження ветерана." }
    t[263466] = { name = "Переповнена торба рясності", fen = "Weekly cache containing materials for upgrading equipment, gold, coffer key shards, and more.\n\n\n\nThe first two pinnacle caches you earn each week contain a piece of Veteran equipment.", fua = "Щотижнева скриня з матеріалами для поліпшення спорядження, золотом, уламками ключа від реліквієвої скрині тощо.\n\n\n\nПерші дві найвищі скрині, здобуті за тиждень, містять предмет спорядження ветерана." }
    t[263467] = { name = "Набір припасів завзятого учня", fen = "Weekly cache containing materials for upgrading gear, gold, coffer key shards, and more.\n\n\n\nThe first two pinnacle caches you earn each week contain a piece of Veteran equipment.", fua = "Щотижнева скриня з матеріалами для поліпшення спорядження, золотом, уламками ключа від реліквієвої скрині тощо.\n\n\n\nПерші дві найвищі скрині, здобуті за тиждень, містять предмет спорядження ветерана." }
    t[263471] = { name = "Вогняна штука", fen = "This thing is ON FIRE", fua = "Ця штука ГОРИТЬ" }
    t[263473] = { name = "Рецепт: Буяння флори", fen = "Teaches you how to cook Flora Frenzy.", fua = "Навчає вас готувати буяння флори." }
    t[263480] = "Прутик Вічної Пісні"
    t[263481] = "Оборонець Вічної Пісні"
    t[263482] = "Колій Вічної Пісні"
    t[263484] = "Клинок Вічної Пісні"
    t[263485] = "Бойова сокира Вічної Пісні"
    t[263486] = "Різак Вічної Пісні"
    t[263487] = "Тренувальний посох Вічної Пісні"
    t[263488] = "Досвід супутника"
    t[263492] = { name = "Блискострумок", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[263510] = { name = "Відвідник переливу", fen = "Used by ethereal to dampen overwhelming energies.", fua = "Використовується ефіріалами, щоб гасити надмірні енергії." }
    t[263515] = { name = "Розбите дзеркало, що краде душі", fen = "Would look great on a bedside table.", fua = "Чудово виглядало б на нічному столику." }
    t[263516] = { name = "Космічна ритуальна чаша", fen = "In excellent condition despite prior use.", fua = "У чудовому стані, попри попереднє використання." }
    t[263517] = { name = "Давній текст", fen = "The only thing still legible is its price tag.", fua = "Єдине, що ще можна прочитати, — це цінник." }
    t[263518] = { name = "Дорога на вигляд знахідка", fen = "This has \"money\" written all over it.", fua = "На цьому суцільно написано «гроші»." }
    t[263519] = { name = "Зміїна олія", fen = "As rare as you need it to be.", fua = "Така рідкісна, як тобі потрібно." }
    t[263520] = "Комплект: вбрання Розповзу"
    t[263573] = "Наплічники позолоченої згаслої зорі"
    t[263574] = { name = "Комплект: кістяний одяг", fen = "An ensemble of Leather armor appearances.", fua = "Комплект образів шкіряної броні." }
    t[263575] = { name = "Комплект: Прадавнє мохове вбрання", fen = "An ensemble of Mail armor appearances.", fua = "Комплект образів кольчужної броні." }
    t[263576] = { name = "Комплект: броня буйного терну", fen = "An ensemble of Plate armor appearances.", fua = "Комплект образів латної броні." }
    t[263577] = { name = "Арсенал: зброя Кореневих земель", fen = "An arsenal of weapon appearances.", fua = "Арсенал виглядів зброї." }
    t[263579] = { name = "Жвавий хлороцерос", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[263580] = { name = "Яскравий хлороцерос", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[263585] = "Нагрудник вершника Порожнечі"
    t[263586] = "Сабатони вершника Порожнечі"
    t[263587] = "Рукавиці вершника Порожнечі"
    t[263588] = "Шолом вершника Порожнечі"
    t[263589] = "Поножі вершника Порожнечі"
    t[263590] = "Наплічники вершника Порожнечі"
    t[263591] = "Пояс вершника Порожнечі"
    t[263592] = "Плащ вершника Порожнечі"
    t[263593] = "Наручі вершника Порожнечі"
    t[263594] = "Збруя блукача Порожнечі"
    t[263595] = "Сандалі блукача Порожнечі"
    t[263596] = "Рукавиці Блукача Порожнечі"
    t[263597] = "Шапочка блукача Порожнечі"
    t[263598] = "Поножі блукача Порожнечі"
    t[263599] = "Наплічні клинки блукача Порожнечі"
    t[263600] = "Шнур Блукача Порожнечі"
    t[263601] = "Плащ Блукача Порожнечі"
    t[263602] = "Наручі Блукача Порожнечі"
    t[263603] = "Роба люті Порожнечі"
    t[263604] = "Чоботи люті Порожнечі"
    t[263605] = "Наручні люті Порожнечі"
    t[263606] = "Покрівець люті Порожнечі"
    t[263607] = "Поножі люті Порожнечі"
    t[263608] = "Наплічники люті Порожнечі"
    t[263609] = "Пояс люті Порожнечі"
    t[263610] = "Плащ люті Порожнечі"
    t[263611] = "Наручі люті Порожнечі"
    t[263612] = "Нагрудник люті Порожнечі"
    t[263613] = "Нагрудник вартового Порожнечі"
    t[263614] = "Кігті вартового Порожнечі"
    t[263615] = "Пазурі вартового Порожнечі"
    t[263616] = "Корона вартового Порожнечі"
    t[263617] = "Поножі вартового Порожнечі"
    t[263618] = "Наплічники вартового Порожнечі"
    t[263619] = "Пояс вартового Порожнечі"
    t[263620] = "Плащ вартового Порожнечі"
    t[263621] = "Наручі вартового Порожнечі"
    t[263622] = "Нагрудник Переслідувача Порожнечі"
    t[263623] = "Поножі Переслідувача Порожнечі"
    t[263624] = "Рукавиці Переслідувача Порожнечі"
    t[263625] = "Шолом Переслідувача Порожнечі"
    t[263626] = "Набедреники Переслідувача Порожнечі"
    t[263627] = "Наплічники Переслідувача Порожнечі"
    t[263628] = "Пояс Переслідувача Порожнечі"
    t[263629] = "Плащ Переслідувача Порожнечі"
    t[263630] = "Наручі Переслідувача Порожнечі"
    t[263631] = "Мантія вітру Порожнечі"
    t[263632] = "Чоботи вітру Порожнечі"
    t[263633] = "Рукавиці вітру Порожнечі"
    t[263634] = "Корона вітру Порожнечі"
    t[263635] = "Штани вітру Порожнечі"
    t[263636] = "Накидка вітру Порожнечі"
    t[263637] = "Пояс вітру Порожнечі"
    t[263638] = "Плащ вітру Порожнечі"
    t[263639] = "Перев'язки вітру Порожнечі"
    t[263640] = "Блуза вітру Порожнечі"
    t[263641] = "Жилет послушника Порожнечі"
    t[263642] = "Пазурі прислужника Порожнечі"
    t[263643] = "Хват служки Порожнечі"
    t[263644] = "Шолом послушника Порожнечі"
    t[263645] = "Штани послушника Порожнечі"
    t[263646] = "Наплічники послушника Порожнечі"
    t[263647] = "Шнур послушника Порожнечі"
    t[263648] = "Плащ послушника Порожнечі"
    t[263649] = "Пов'язки служника Порожнечі"
    t[263650] = "Нагрудник Суду Порожнечі"
    t[263651] = "Сабатони Суду Порожнечі"
    t[263652] = "Латні рукавиці Суду Порожнечі"
    t[263653] = "Корона Суду Порожнечі"
    t[263654] = "Латні поножі Суду Порожнечі"
    t[263655] = "Наплічники Суду Порожнечі"
    t[263656] = "Пояс Суду Порожнечі"
    t[263657] = "Плащ Суду Порожнечі"
    t[263658] = "Пов'язки Суду Порожнечі"
    t[263659] = "Наголінники Суду Порожнечі"
    t[263660] = "Шати піднесення Порожнечі"
    t[263661] = "Чоботи Піднесення Порожнечі"
    t[263662] = "Наручі піднесення Порожнечі"
    t[263663] = "Німб піднесення Порожнечі"
    t[263664] = "Легінси Сходження Порожнечі"
    t[263665] = "Наплічники піднесення Порожнечі"
    t[263666] = "Пояс піднесення Порожнечі"
    t[263667] = "Плащ піднесення Порожнечі"
    t[263668] = "Пов'язки піднесення Порожнечі"
    t[263669] = "Блуза Піднесення Порожнечі"
    t[263670] = "Нагрудник Ікла Порожнечі"
    t[263671] = "Чоботи Ікла Порожнечі"
    t[263672] = "Рукавиці Ікла Порожнечі"
    t[263673] = "Каптур Ікла Порожнечі"
    t[263674] = "Штани Ікла Порожнечі"
    t[263675] = "Наплічники Ікла Порожнечі"
    t[263676] = "Пояс Ікла Порожнечі"
    t[263677] = "Плащ Ікла Порожнечі"
    t[263678] = "Наручі Ікла Порожнечі"
    t[263679] = "Нагрудник Бур Порожнечі"
    t[263680] = "Сабатони бур Порожнечі"
    t[263681] = "Латні рукавиці бур Порожнечі"
    t[263682] = "Шолом бур Порожнечі"
    t[263683] = "Кілт Бур Порожнечі"
    t[263684] = "Еполети Бур Порожнечі"
    t[263685] = "Пояс Бур Порожнечі"
    t[263686] = "Плащ бур Порожнечі"
    t[263687] = "Наручі Бур Порожнечі"
    t[263688] = "Поножі бур Порожнечі"
    t[263689] = "Мантія Немезиди Порожнечі"
    t[263690] = "Чоботи немезиди Порожнечі"
    t[263691] = "Рукавиці Немезиди Порожнечі"
    t[263692] = "Шапка Немезиди Порожнечі"
    t[263693] = "Поножі Немезиди Порожнечі"
    t[263694] = "Наплічники Немезиди Порожнечі"
    t[263695] = "Пояс немезиди Порожнечі"
    t[263696] = "Плащ Немезиди Порожнечі"
    t[263697] = "Наручі Немезиди Порожнечі"
    t[263698] = "Блуза немезиди Порожнечі"
    t[263699] = "Нагрудник Гніву Порожнечі"
    t[263700] = "Сабатони гніву Порожнечі"
    t[263701] = "Латні рукавиці гніву Порожнечі"
    t[263702] = "Шолом гніву Порожнечі"
    t[263703] = "Латні поножі Гніву Порожнечі"
    t[263704] = "Наплічники гніву Порожнечі"
    t[263705] = "Пояс гніву Порожнечі"
    t[263706] = "Плащ гніву Порожнечі"
    t[263707] = "Браслети Гніву Порожнечі"
    t[263723] = "Шаль позолоченої згаслої зорі"
    t[263734] = "Нагрудник вершника Порожнечі"
    t[263735] = "Сабатони вершника Порожнечі"
    t[263736] = "Рукавиці вершника Порожнечі"
    t[263737] = "Шолом вершника Порожнечі"
    t[263738] = "Поножі вершника Порожнечі"
    t[263739] = "Наплічники вершника Порожнечі"
    t[263741] = "Пояс вершника Порожнечі"
    t[263742] = "Плащ вершника Порожнечі"
    t[263743] = "Наручі вершника Порожнечі"
    t[263744] = "Збруя блукача Порожнечі"
    t[263745] = "Сандалі блукача Порожнечі"
    t[263746] = "Рукавиці Блукача Порожнечі"
    t[263747] = "Шапочка блукача Порожнечі"
    t[263748] = "Поножі блукача Порожнечі"
    t[263749] = "Наплічні клинки блукача Порожнечі"
    t[263750] = "Шнур Блукача Порожнечі"
    t[263751] = "Плащ Блукача Порожнечі"
    t[263752] = "Наручі Блукача Порожнечі"
    t[263753] = "Роба люті Порожнечі"
    t[263754] = "Чоботи люті Порожнечі"
    t[263755] = "Наручні люті Порожнечі"
    t[263756] = "Покрівець люті Порожнечі"
    t[263757] = "Поножі люті Порожнечі"
    t[263758] = "Наплічники люті Порожнечі"
    t[263759] = "Пояс люті Порожнечі"
    t[263760] = "Плащ люті Порожнечі"
    t[263761] = "Наручі люті Порожнечі"
    t[263762] = "Нагрудник люті Порожнечі"
    t[263763] = "Нагрудник вартового Порожнечі"
    t[263764] = "Кігті вартового Порожнечі"
    t[263765] = "Пазурі вартового Порожнечі"
    t[263766] = "Корона вартового Порожнечі"
    t[263767] = "Поножі вартового Порожнечі"
    t[263768] = "Наплічники вартового Порожнечі"
    t[263769] = "Пояс вартового Порожнечі"
    t[263770] = "Плащ вартового Порожнечі"
    t[263771] = "Наручі вартового Порожнечі"
    t[263772] = "Нагрудник Переслідувача Порожнечі"
    t[263773] = "Поножі Переслідувача Порожнечі"
    t[263774] = "Рукавиці Переслідувача Порожнечі"
    t[263775] = "Шолом Переслідувача Порожнечі"
    t[263777] = "Набедреники Переслідувача Порожнечі"
    t[263778] = "Наплічники Переслідувача Порожнечі"
    t[263779] = "Пояс Переслідувача Порожнечі"
    t[263780] = "Плащ Переслідувача Порожнечі"
    t[263781] = "Наручі Переслідувача Порожнечі"
    t[263782] = "Мантія вітру Порожнечі"
    t[263783] = "Чоботи вітру Порожнечі"
    t[263784] = "Рукавиці вітру Порожнечі"
    t[263785] = "Корона вітру Порожнечі"
    t[263786] = "Штани вітру Порожнечі"
    t[263787] = "Накидка вітру Порожнечі"
    t[263788] = "Пояс вітру Порожнечі"
    t[263789] = "Плащ вітру Порожнечі"
    t[263790] = "Перев'язки вітру Порожнечі"
    t[263791] = "Блуза вітру Порожнечі"
    t[263792] = "Жилет послушника Порожнечі"
    t[263793] = "Пазурі прислужника Порожнечі"
    t[263794] = "Хват служки Порожнечі"
    t[263795] = "Шолом послушника Порожнечі"
    t[263796] = "Штани послушника Порожнечі"
    t[263797] = "Наплічники послушника Порожнечі"
    t[263798] = "Шнур послушника Порожнечі"
    t[263799] = "Плащ послушника Порожнечі"
    t[263800] = "Пов'язки служника Порожнечі"
    t[263801] = "Нагрудник Суду Порожнечі"
    t[263802] = "Сабатони Суду Порожнечі"
    t[263803] = "Латні рукавиці Суду Порожнечі"
    t[263804] = "Корона Суду Порожнечі"
    t[263805] = "Латні поножі Суду Порожнечі"
    t[263806] = "Наплічники Суду Порожнечі"
    t[263807] = "Пояс Суду Порожнечі"
    t[263808] = "Плащ Суду Порожнечі"
    t[263809] = "Пов'язки Суду Порожнечі"
    t[263810] = "Наголінники Суду Порожнечі"
    t[263811] = "Шати піднесення Порожнечі"
    t[263812] = "Чоботи Піднесення Порожнечі"
    t[263813] = "Наручі піднесення Порожнечі"
    t[263814] = "Німб піднесення Порожнечі"
    t[263815] = "Легінси Сходження Порожнечі"
    t[263816] = "Наплічники піднесення Порожнечі"
    t[263817] = "Пояс піднесення Порожнечі"
    t[263818] = "Плащ піднесення Порожнечі"
    t[263819] = "Пов'язки піднесення Порожнечі"
    t[263820] = "Блуза Піднесення Порожнечі"
    t[263821] = "Нагрудник Ікла Порожнечі"
    t[263823] = "Чоботи Ікла Порожнечі"
    t[263824] = "Рукавиці Ікла Порожнечі"
    t[263825] = "Каптур Ікла Порожнечі"
    t[263826] = "Штани Ікла Порожнечі"
    t[263827] = "Наплічники Ікла Порожнечі"
    t[263828] = "Пояс Ікла Порожнечі"
    t[263829] = "Плащ Ікла Порожнечі"
    t[263830] = "Наручі Ікла Порожнечі"
    t[263831] = "Нагрудник Бур Порожнечі"
    t[263832] = "Сабатони бур Порожнечі"
    t[263833] = "Латні рукавиці бур Порожнечі"
    t[263834] = "Шолом бур Порожнечі"
    t[263835] = "Кілт Бур Порожнечі"
    t[263836] = "Еполети Бур Порожнечі"
    t[263837] = "Пояс Бур Порожнечі"
    t[263838] = "Плащ бур Порожнечі"
    t[263839] = "Наручі Бур Порожнечі"
    t[263840] = "Поножі бур Порожнечі"
    t[263841] = "Мантія Немезиди Порожнечі"
    t[263842] = "Чоботи немезиди Порожнечі"
    t[263843] = "Рукавиці Немезиди Порожнечі"
    t[263844] = "Шапка Немезиди Порожнечі"
    t[263845] = "Поножі Немезиди Порожнечі"
    t[263846] = "Наплічники Немезиди Порожнечі"
    t[263847] = "Пояс немезиди Порожнечі"
    t[263848] = "Плащ Немезиди Порожнечі"
    t[263849] = "Наручі Немезиди Порожнечі"
    t[263850] = "Блуза немезиди Порожнечі"
    t[263851] = "Нагрудник Гніву Порожнечі"
    t[263852] = "Сабатони гніву Порожнечі"
    t[263853] = "Латні рукавиці гніву Порожнечі"
    t[263854] = "Шолом гніву Порожнечі"
    t[263855] = "Латні поножі Гніву Порожнечі"
    t[263856] = "Наплічники гніву Порожнечі"
    t[263857] = "Пояс гніву Порожнечі"
    t[263858] = "Плащ гніву Порожнечі"
    t[263860] = "Браслети Гніву Порожнечі"
    t[263870] = "Ключ від схованки колонії"
    t[263871] = { name = "Свята Повідка для Улюбленця", fen = "Imbued with the energy of the Sunwell.", fua = "Просякнута енергією Сонячного Колодязя." }
    t[263872] = { name = "Люциферн", fen = "Beautiful to look at, terrible to sniff.", fua = "Гарний на вигляд, жахливий на нюх." }
    t[263888] = "Каблучка, просякнута Порожнечею"
    t[263889] = "Печатка, просякнута Порожнечею"
    t[263890] = "Перстень, просякнутий Порожнечею"
    t[263891] = "Кулон, просякнутий Порожнечею"
    t[263892] = "Гривна, просякнута Порожнечею"
    t[263893] = "Намисто, просякнуте Порожнечею"
    t[263894] = "Торкнута Порожнечею рушниця"
    t[263897] = "Сяйливий самоцвітов'яз"
    t[263898] = "Ікло, торкнуте Порожнечею"
    t[263900] = "Патрач, торкнутий Порожнечею"
    t[263901] = "Торкнутий Порожнечею жертовний ніж"
    t[263902] = "Торкнутий Порожнечею здвоєний клинок"
    t[263903] = "Дробарка, торкнута Порожнечею"
    t[263904] = "Молоток, торкнутий Порожнечею"
    t[263905] = "Молоток учня, торкнутий Порожнечею"
    t[263906] = "Бастіон, торкнутий Порожнечею"
    t[263907] = "Торкнутий Порожнечею заступ"
    t[263908] = "Торкнута Порожнечею бойова сокира"
    t[263909] = "Торкнутий Порожнечею посох Сонячної Люті"
    t[263910] = "Маяковий посох, торкнутий Порожнечею"
    t[263911] = "Бойова палиця, торкнута Порожнечею"
    t[263912] = "Торкнутий Порожнечею жезл магістра"
    t[263913] = "Торкнутий Порожнечею трощитель"
    t[263914] = "Молот, торкнутий Порожнечею"
    t[263915] = "Торкнутий Порожнечею смолоскип"
    t[263916] = "Торкнутий Порожнечею фоліант"
    t[263917] = "Розширений клинок, торкнутий Порожнечею"
    t[263918] = "Клинок вартового, торкнутий Порожнечею"
    t[263919] = "Торкнутий Порожнечею меч магістра"
    t[263920] = "Дуельний клинок, торкнутий Порожнечею"
    t[263921] = "Торкнутий Порожнечею клинок Сонячної Люті"
    t[263922] = "Торкнутий Порожнечею клинок мага"
    t[263923] = "Великий клинок, торкнутий Порожнечею"
    t[263924] = "Великий лук, торкнутий Порожнечею"
    t[263925] = "Фокусувач, торкнутий Порожнечею"
    t[263926] = "Великий жезл, торкнутий Порожнечею"
    t[263927] = "Лезо-глефа, торкнуте Порожнечею"
    t[263928] = { name = "Сховок озброєння, торкнутого Порожнечею", fen = "Contains a Champion item for your Loot Specialization.", fua = "Містить предмет рівня Чемпіон для вашої спеціалізації здобичі." }
    t[263929] = { name = "Сховок озброєння, торкнутого Порожнечею", fen = "Contains a Heroic item for your Loot Specialization.", fua = "Містить геройський предмет для вашої спеціалізації здобичі." }
    t[263933] = { name = "Камінь Повернення Шукача Здобичі", fen = "Astalor swears this won't hurt... much.", fua = "Асталор присягається, що це не болітиме... надто сильно." }
    t[263934] = { name = "Скриня золота", fen = "Contains 1000 gold.", fua = "Містить 1000 золота." }
    t[263938] = { name = "Ідол Небезпеки", fen = "Represents the depth of your bond with Puul, Loa of Peril.", fua = "Уособлює глибину твого зв'язку з Пуулом, лоа Небезпеки." }
    t[263941] = "Торкнута Порожнечею рушниця"
    t[263942] = "Ікло, торкнуте Порожнечею"
    t[263943] = "Патрач, торкнутий Порожнечею"
    t[263946] = "Дробарка, торкнута Порожнечею"
    t[263949] = "Бастіон, торкнутий Порожнечею"
    t[263950] = "Торкнутий Порожнечею заступ"
    t[263952] = "Торкнутий Порожнечею посох Сонячної Люті"
    t[263954] = "Бойова палиця, торкнута Порожнечею"
    t[263956] = "Торкнутий Порожнечею трощитель"
    t[263959] = "Торкнутий Порожнечею фоліант"
    t[263960] = "Розширений клинок, торкнутий Порожнечею"
    t[263963] = "Дуельний клинок, торкнутий Порожнечею"
    t[263966] = "Великий клинок, торкнутий Порожнечею"
    t[263967] = "Великий лук, торкнутий Порожнечею"
    t[263968] = "Фокусувач, торкнутий Порожнечею"
    t[263969] = "Великий жезл, торкнутий Порожнечею"
    t[263970] = "Лезо-глефа, торкнуте Порожнечею"
    t[263974] = { name = "Заспокійливий трав'яний чай", fen = "Camberon's mother's best friend's cousin's recipe for a stress-relieving concoction. Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Рецепт антистресового відвару від кузини найкращої подруги матері Камберона. Створено досвідченими алхіміками. Можна купувати й продавати на аукціоні." }
    t[263975] = "Генератор Почуттів Mk. 7"
    t[264010] = "Престижний плащ галактичного гладіатора"
    t[264164] = "Накидка галактичного гладіатора"
    t[264165] = { name = "Тіфф", fen = "Aww. She fell asleep.", fua = "Ой. Вона заснула." }
    t[264166] = { name = "Уламок артефакту Порожнечі", fen = "A crystalline shard cleaved from a larger, void-infused artifact. It pollutes its surroundings with the Void.", fua = "Кристалічний уламок, відколотий від більшого артефакту, насиченого Порожнечею. Він отруює довкілля Порожнечею." }
    t[264182] = { name = "Щедрий ароматний дарунок Келум'ко", fen = "A whole tide fish, heavily blessed, and only slightly decomposing. Best sell it quickly--the smell is spreading its own kind of blessing!", fua = "Ціла припливна рибина, рясно благословенна й лише трохи підгнила. Краще продай її швидше — її запах поширює власне благословення!" }
    t[264183] = { name = "Щедрий ароматний дарунок Келум'ко", fen = "A whole tide fish, formerly blessed and now decomposed. The blessing is gone, but the smell remains stronger than ever. Still worth a few coins to anyone with a strong stomach.", fua = "Цілісна припливна риба, колись благословенна, а тепер геть струхлявіла. Благословення зникло, та сморід міцніший, ніж будь-коли. Усе ще вартує кількох монет для того, хто має міцний шлунок." }
    t[264184] = "Арсенал: реліквії Атал'Амана"
    t[264188] = { name = "Золота карта Відіуса", fen = "A strange card that carries the Domanaar's likeness, as though part of some greater set.", fua = "Дивна карта з подобою доманаара, наче частина якогось більшого набору." }
    t[264189] = { name = "Золота карта Зіадан", fen = "A strange card that carries the Domanaar's likeness, as though part of some greater set.", fua = "Дивна карта з подобою доманаара, наче частина якогось більшого набору." }
    t[264191] = { name = "Викрадені бойові плани Зіадан", fen = "Everything Ziadan is planning in the upcoming battle.", fua = "Усе, що Зіадан планує у прийдешній битві." }
    t[264192] = { name = "Викрадені бойові плани Відіуса", fen = "Everything Vidious is planning in the upcoming battle.", fua = "Усе, що Відіус задумав на прийдешню битву." }
    t[264193] = "Прицільне око небесного мисливця амані"
    t[264194] = "Посох полум'язбора амані"
    t[264195] = "Спис іклозова амані"
    t[264196] = "Лезо вісника війни амані"
    t[264197] = "Оберіг духокори амані"
    t[264274] = { name = "Схованка легендарного шукача пригод", fen = "Weekly cache containing materials for upgrading equipment, gold, coffer key shards, and more.\n\n\n\nThe first two pinnacle caches you earn each week contain a piece of Adventurer equipment.", fua = "Щотижнева скриня з матеріалами для поліпшення спорядження, золотом, уламками ключа від реліквієвої скрині тощо.\n\n\n\nПерші дві найвищі скрині, здобуті за тиждень, містять предмет спорядження шукача пригод." }
    t[264286] = "Намисто руйнівника Порожнечі"
    t[264287] = "Каблучка руйнівника Порожнечі"
    t[264288] = "Перстень руйнівника Порожнечі"
    t[264289] = "Обмотки безнитяного контролю"
    t[264290] = "Рукавиці бездротового контролю"
    t[264291] = "Латні рукавиці безниткового контролю"
    t[264292] = "Хват безниткового контролю"
    t[264293] = "Подертий шаль вигнанця"
    t[264294] = "Плащ ередара-посланця Нечестя"
    t[264295] = "Наручні стрічки Нічеламника"
    t[264296] = "Наручі Нічеламника"
    t[264297] = "Манжети Нічеламника"
    t[264298] = "Наручники Нічеламника"
    t[264299] = "Пояс вірусного згортання"
    t[264300] = "Шарф вірусного згортання"
    t[264301] = "Черес вірусного згортання"
    t[264302] = "Перев'язь вірусного згортання"
    t[264303] = { name = "Віллі", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[264304] = "Шати затьмареного підступу"
    t[264305] = "Жилет затьмареного обману"
    t[264306] = "Кольчуга затьмареної підступності"
    t[264307] = "Нагрудник Затьмареної Облуди"
    t[264308] = "Маска пробуджених тіней"
    t[264309] = "Шолом пробуджених тіней"
    t[264310] = "Каптур пробуджених тіней"
    t[264311] = "Бойовий шолом пробуджених тіней"
    t[264313] = { name = "Шалена Червоноголівка", fen = "Yum!", fua = "Смакота!" }
    t[264314] = { name = "Сховок головних уборів, торкнутих Порожнечею", fen = "Contains a cosmetic Void-Touched helm you do not have in your collection.", fua = "Містить косметичний шолом, торкнутий Порожнечею, якого немає у вашій колекції." }
    t[264315] = { name = "Сховок наплічників, торкнутих Порожнечею", fen = "Contains a cosmetic Void-Touched shoulders you do not have in your collection.", fua = "Містить косметичні наплічники, торкнуті Порожнечею, яких немає у вашій колекції." }
    t[264316] = { name = "Сховок плащів, торкнутих Порожнечею", fen = "Contains a cosmetic Void-Touched cloak you do not have in your collection.", fua = "Містить косметичний плащ, торкнутий Порожнечею, якого немає у вашій колекції." }
    t[264317] = { name = "Сховок нагрудників, торкнутих Порожнечею", fen = "Contains a cosmetic Void-Touched chestpiece you do not have in your collection.", fua = "Містить косметичний нагрудник, торкнутий Порожнечею, якого немає у вашій колекції." }
    t[264318] = { name = "Сховок наручів, торкнутих Порожнечею", fen = "Contains a cosmetic Void-Touched bracer you do not have in your collection.", fua = "Містить косметичні наручі, торкнуті Порожнечею, яких немає у вашій колекції." }
    t[264319] = { name = "Сховок рукавиць, торкнутих Порожнечею", fen = "Contains a cosmetic Void-Touched glove item you do not have in your collection.", fua = "Містить косметичні рукавиці, торкнуті Порожнечею, яких немає у вашій колекції." }
    t[264320] = { name = "Сховок поясів, торкнутих Порожнечею", fen = "Contains a cosmetic Void-Touched belt you do not have in your collection.", fua = "Містить косметичний пояс, торкнутий Порожнечею, якого немає у вашій колекції." }
    t[264321] = { name = "Сховок набедреників, торкнутих Порожнечею", fen = "Contains a cosmetic Void-Touched legwear you do not have in your collection.", fua = "Містить косметичний набедреник, торкнутий Порожнечею, якого немає у вашій колекції." }
    t[264322] = { name = "Сховок чобіт, торкнутих Порожнечею", fen = "Contains a cosmetic Void-Touched boot item you do not have in your collection.", fua = "Містить косметичні чоботи, торкнуті Порожнечею, яких немає у вашій колекції." }
    t[264323] = { name = "Сховок зброї, торкнутої Порожнечею", fen = "Contains a cosmetic Void-Touched weapon you do not have in your collection.", fua = "Містить косметичну зброю, торкнуту Порожнечею, якої немає у вашій колекції." }
    t[264325] = "Накидка захисника Штормаріона"
    t[264326] = "Наплічники захисника Штормаріона"
    t[264327] = "Наплічники штормаріонського захисника"
    t[264328] = "Наплічники захисника Штормаріона"
    t[264357] = { name = "Крабове м'ясо, вражене Порожнечею", fen = "Maybe if the flames are hot enough they can burn the Void out of this... meat? It's so far gone that it might not qualify as meat anymore.", fua = "Може, якщо полум'я буде досить гарячим, воно випалить Порожнечу з цього... м'яса? Воно так зіпсувалося, що, мабуть, уже й не зветься м'ясом." }
    t[264363] = { name = "Голова Гар'чака Череполома", fen = "Yeah, it's him.", fua = "Так, це він." }
    t[264364] = { name = "Голова Гардіна Сталезамка", fen = "Yeah, it's him.", fua = "Так, це він." }
    t[264367] = { name = "Домашня Спора Мікоманта", fen = "It's good to get back to your roots.", fua = "Добре повертатися до своїх коренів." }
    t[264380] = { name = "Контракт на службу", fen = "Payment is for victors only. The defeated earn no wages.", fua = "Платня лише для переможців. Переможені не отримують винагороди." }
    t[264391] = "Освячений дотик"
    t[264403] = "Перероблені капці далекоходів"
    t[264404] = "Перероблені чоботи далекоходів"
    t[264405] = "Перероблені черевики далекоходів"
    t[264406] = "Перероблені чоботища далекоходів"
    t[264407] = "Шаровари того, хто протистоїть Порожнечі"
    t[264408] = "Штани того, хто протистоїть Порожнечі"
    t[264409] = "Поножі того, хто протистоїть Порожнечі"
    t[264410] = "Наголінники того, хто протистоїть Порожнечі"
    t[264411] = "Злодійський перстень пам'яті"
    t[264412] = "Пам'ятка магістра сін'дорей"
    t[264413] = "Нищівна Перемога"
    t[264414] = "Сигнальний Пістолет Глибинника Опівночі"
    t[264415] = "Лук Творця Порожнечі"
    t[264417] = "Великий меч Творця Порожнечі"
    t[264418] = "Тесак Творця Порожнечі"
    t[264419] = "Скіпетр Творця Порожнечі"
    t[264420] = "Бойова глефа Творця Порожнечі"
    t[264421] = "Спрямовувач Творця Порожнечі"
    t[264422] = "Кинджал Творця Порожнечі"
    t[264423] = "Шматувач Творця Порожнечі"
    t[264424] = "Посох Творця Порожнечі"
    t[264425] = "Тесак, сформований Порожнечею"
    t[264426] = "Трощило, сформоване Порожнечею"
    t[264427] = "Штрикач, сформований Порожнечею"
    t[264428] = "Стрілець, сформований Порожнечею"
    t[264429] = "Різак, сформований Порожнечею"
    t[264430] = "Колій, сформований Порожнечею"
    t[264431] = "Творець, сформований Порожнечею"
    t[264432] = "Захисник, сформований Порожнечею"
    t[264433] = "Протинач, сформований Порожнечею"
    t[264434] = { name = "Волді", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[264447] = "Перстень серця трешадона"
    t[264448] = "Сплетена з пір'я каблучка обітниці"
    t[264449] = "Лісорубська сокирка зі світлодерева"
    t[264450] = "Різьбярський ніж зі світлодерева"
    t[264451] = "Духовна довбня зі світлодерева"
    t[264452] = "Лісорубський молот зі світлодерева"
    t[264453] = "Рунний клинок зі світлодерева"
    t[264454] = "Збирацька шабля зі світлодерева"
    t[264455] = "Серпасті клинки зі світлодерева"
    t[264456] = "Різьблений довгий лук зі світлодерева"
    t[264457] = "Розколювальний спис зі світлодерева"
    t[264458] = "Світлодеревний посох спрямування"
    t[264459] = "Сонячний меч зі світлодерева"
    t[264460] = "Ніж-ікло різьбяра іклів"
    t[264461] = "Ритуальний молот різьбяра іклів"
    t[264462] = "Кістяний молот різьбяра іклів"
    t[264463] = "Мисливський клинок різьбяра іклів"
    t[264464] = "Гострий посох різьбяра іклів"
    t[264465] = "Бойовий меч різьбяра іклів"
    t[264466] = "Трофей різьбяра іклів"
    t[264467] = "Щит різьбяра іклів"
    t[264468] = "Плащ обряду Ревантусків"
    t[264469] = "Попелосповитий плащ данини"
    t[264470] = { name = "Попелом сповита пожертва", fen = "A small bundle of river reeds bound with blackened twine, still smelling faintly of smoke from Tolbani's pyre. Inside, the ashes mingle with faintly glowing fragments gathered from the riverbank.", fua = "Невеликий жмут річкового очерету, перев'язаний почорнілим шнурком, що досі ледь пахне димом погребального вогнища Толбані. Усередині попіл змішаний зі слабо мерехтливими уламками, зібраними з берега річки." }
    t[264471] = "Рукавиці облудного лоа"
    t[264472] = "Кігтезахисти облудного лоа"
    t[264473] = "Припливні захвати облудного лоа"
    t[264474] = "Розсільні кулаки облудного лоа"
    t[264475] = "Тінява олов'яна скринька"
    t[264503] = { name = "Тріснуте ядро", fen = "A Stormarion core, altered to forcibly release its energy.", fua = "Ядро штормаріона, змінене, щоб силоміць вивільнити свою енергію." }
    t[264506] = { name = "Уламок Штормаріона", fen = "Shattered pieces of a Stormarion core.", fua = "Розбиті частини ядра Штормаріона." }
    t[264507] = "Горнило хаотичних енергій"
    t[264513] = { name = "Кристалічний посуд", fen = "The gemstone is warm to the touch and quivers with the potential energy contained within.", fua = "Самоцвіт теплий на дотик і тремтить від потенційної енергії, що в ньому міститься." }
    t[264517] = "Галактичний Прапор Перемоги"
    t[264519] = "Перероблений нагрудник блукача Порожнечі"
    t[264520] = "Лей-патериця вартового"
    t[264521] = "Осередок з пера яструбоступа"
    t[264522] = "Наручні пов'язки з пера яструбоступа"
    t[264523] = "Клинок гідрозуба"
    t[264524] = "Уражений Світлом зелений жилет"
    t[264525] = "Обмотані вусикові манжети"
    t[264526] = "Винятково слизький пояс"
    t[264527] = "Мантія мерзенного ворожбита"
    t[264528] = "Заслизені поножі"
    t[264529] = "Покров фурболга-старійшини"
    t[264530] = "Рукавиці Похмурохутра"
    t[264531] = "Капці з тіньової нитки"
    t[264532] = "Шати плинних істин"
    t[264533] = "Щупальцевий пояс королеви"
    t[264534] = "Наплічники з Болотяної Лози"
    t[264535] = "Легінси Космічного Гнобителя"
    t[264536] = "Викличний нашийник паростка Зеда"
    t[264537] = "Рукавиці крилатого жаху"
    t[264538] = "Капці з прозорої перетинки"
    t[264539] = "Шати призивача Порожнечі"
    t[264540] = "Зап'ястки з твань-лози"
    t[264541] = "Пояс для Сповивання Яєць"
    t[264542] = "Мантія Череполома"
    t[264543] = { name = "Штани кусач-дракона", fen = "Are they worn by or made of Snapdragons? We may never know.", fua = "Їх носять кусючі дракони чи їх із них зроблено? Можливо, ми ніколи не дізнаємося." }
    t[264544] = "Заземлений бліда поганка"
    t[264545] = "Хватки з пазурів мучительки"
    t[264546] = "Чоботи з кажанячого хутра"
    t[264547] = "Зношені пов'язки фурболгів"
    t[264548] = "Пояс космічного спокою"
    t[264549] = "Наплічники вічного пожирання"
    t[264550] = "Панчохи грибного скрадайла"
    t[264551] = "Щелепа Нічного виводку"
    t[264552] = "Рукавиці з жаб'ячої шкіри"
    t[264553] = "Шкіряні калоші глибокоспор"
    t[264554] = "Оздоблена шкіряна камізелька"
    t[264555] = "Застібки з розколотого врочного дерева"
    t[264556] = "Підперезник, кований у Порожнечі"
    t[264557] = "Наплічники з Бурової Броні"
    t[264558] = "Стопники, стійкі до мерзокрові"
    t[264559] = "Лик пожирача"
    t[264560] = "Рукавиці гострокіготь"
    t[264561] = "Первісні кістятопти"
    t[264562] = "Латний гайовий жилет"
    t[264563] = "Наручі Еруунді"
    t[264564] = "Збруя приборкувача крабів"
    t[264565] = "Наплічники з луски Порожнечі"
    t[264566] = "Листостриби Батоязика"
    t[264567] = "Каптур з кам'яної луски"
    t[264568] = "Зубчасті лускаті рукавиці"
    t[264569] = "Копняки, пересичені Порожнечею"
    t[264570] = "Укріплена кольчуга-мррл"
    t[264571] = "Залізнолисті наручі"
    t[264572] = "Застібка пластин Нечестя"
    t[264573] = "Садистські наплічники наглядача"
    t[264574] = "Набедреники Жаху Нечестя"
    t[264575] = "Шолом із чародерева"
    t[264576] = "Рукавиці сланцевої луски"
    t[264577] = "Кристалоковані чоботи"
    t[264578] = "Жахоброня Пенька"
    t[264579] = "Зголоднілі наручні пластини"
    t[264580] = "Мргл-пояс Мррлокка"
    t[264581] = "Квітокорі наплічники"
    t[264582] = "Поножі з луски діамантоспина"
    t[264583] = "Барбют крилатої мисливиці"
    t[264584] = "Вирізьблені з каменю трощії"
    t[264585] = "Чоботи кусача"
    t[264586] = "Нагрудник із панцира ракоподібного"
    t[264587] = { name = "Торбинка дрібничок Ані", fen = "A small satchel stuffed with river stones, shiny shells, and a few brave memories. Ani pressed it into your hands with a proud grin--her way of saying thanks for helping her find her courage.", fua = "Маленька торбинка, набита річковим камінням, блискучими мушлями та кількома сміливими спогадами. Ані вклала її тобі в руки з гордою усмішкою — її спосіб подякувати за те, що допоміг їй віднайти відвагу." }
    t[264588] = "Шаль космічного шепоту"
    t[264589] = "Крилатий плащ, сплавлений з Порожнечею"
    t[264591] = "Перо сяйливого пелюсткокрила"
    t[264592] = "Бездоганне крило Га'калаве"
    t[264593] = "Бойовий плащ Різника"
    t[264594] = "Плащ із луски Нечестя"
    t[264595] = "Шаль зі шкіри рисі"
    t[264596] = "Серпанок з нитки Порожнечі"
    t[264597] = "Перстень Зуба-п'явки"
    t[264598] = "Вугроелектрумовий Перстень"
    t[264599] = "Перстень-печатка Кул-Тіраса"
    t[264600] = "Давнє аргуське кільце"
    t[264601] = "Перстень ока королеви"
    t[264602] = "Перстень з коралів Безодні"
    t[264603] = "Самоцвітне кільце стража"
    t[264604] = "Багниста зелена печатка"
    t[264605] = "Намисто непохитних вітрів"
    t[264606] = "Амулет осередку Нечестя"
    t[264607] = "Намисто, обтяжене спорами"
    t[264608] = "Низка чарівних квітів"
    t[264609] = "Знак честі Гар'чака"
    t[264610] = { name = "Жетон утеклого піддослідного", fen = "Unfamiliar glowing symbols are etched on the surface.", fua = "На поверхні викарбувані незнайомі сяйливі символи." }
    t[264611] = "Підвіска висмоктаної життєвої сили"
    t[264612] = { name = "Потьмянілий золотий медальйон", fen = "Thalassian lyrics are etched inside this formerly resplendent locket.", fua = "Усередині цього колись розкішного медальйона викарбувані таласійські слова пісні." }
    t[264613] = "Сталекорий бастіон"
    t[264614] = "Грибошапковий щит"
    t[264615] = "Запасний клинок Гардіна"
    t[264616] = "Уражений Світлом Смолопій"
    t[264617] = "Шпичак Погибелі"
    t[264618] = "Дивовижно вугружний клинок"
    t[264619] = "Чароклинок із нечесткованої сталі"
    t[264620] = "Кулехребтний чаропроникач"
    t[264621] = { name = "Найгірший направляч Лихого Зеда", fen = "The only thing worse than Zed was the dagger he summoned his Zedlings with.", fua = "Єдине, що було гірше за Зеда, — це кинджал, яким він призивав своїх Зедлінгів." }
    t[264622] = "Колій Похмуроікла"
    t[264623] = "Роздираюче ікло"
    t[264624] = "Ікло пані"
    t[264625] = "Осередок штормової сили"
    t[264626] = "Скіпетр осяйного навернення"
    t[264627] = "Запасний мисливський спис Рав'іка"
    t[264628] = "Спис небуття"
    t[264629] = "Дебелий плавець Коралоікла"
    t[264630] = "Колосальний розколювач Порожнечі"
    t[264631] = { name = "Череполом Гарака", fen = "Occasionally you get bored of just crushing skulls.", fua = "Іноді просто трощити черепи набридає." }
    t[264632] = "Патериця Темноцвіту"
    t[264633] = "Бойовий посох верховіття"
    t[264634] = "Шпиль плинної Порожнечі"
    t[264635] = "Пень Пенька"
    t[264637] = "Глеф космічного мисливця"
    t[264638] = "Ікла загарбниці"
    t[264639] = "Гострозубий тесак"
    t[264640] = "Загострений кіготь свердляка"
    t[264641] = "Загострений череполом"
    t[264642] = "Різальна коса Порожнечі"
    t[264643] = "Запасний тесак Аш'ана"
    t[264644] = "Розумокоса плазуна"
    t[264645] = "Старий лук далекоходів"
    t[264646] = "Довгий лук із жил піддослідного"
    t[264647] = { name = "Каратель Кре'вана", fen = "Not nearly as efficient as a Boot-a-rang.", fua = "Далеко не такий ефективний, як черевикоранг." }
    t[264648] = "Молоток із паразитячої луски"
    t[264649] = "Кігтемолот Розумогнилі"
    t[264650] = "Звісник правди звісника правди"
    t[264651] = "Резонуючий травмувач"
    t[264652] = "Мішечок дослідника Глибин з пилом світла Порожнечі"
    t[264654] = { name = "Маля Попелястокрила", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[264662] = "Шати жриці ножа"
    t[264663] = "Жилет висмоктування духу візербарків"
    t[264664] = "Кольчужний обладунок руйнівника чарів"
    t[264665] = "Латний нагрудник непокірного лоа"
    t[264666] = "Жезл Вимучення"
    t[264668] = "Дар Швидкості"
    t[264669] = "Благословення могутності"
    t[264670] = "Благословення завзяття"
    t[264672] = "Космічний Ритуальний Камінь"
    t[264694] = "Кіраса ультрадона"
    t[264695] = "Міжвимірний Сигнал Посилки"
    t[264696] = { name = "Череп Іл'мула", fen = "In remarkable condition given its age. A cold power rests inside these bones.", fua = "У напрочуд доброму стані як на свій вік. У цих кістках спочиває холодна сила." }
    t[264697] = { name = "Друга Рука Іл'мула", fen = "There's little reason beyond faith for the hand to stay attached to the arm, but it does anyway.", fua = "Окрім віри, кисть майже ніщо не тримає на цій руці — та вона все одно тримається." }
    t[264698] = { name = "Грудна Клітка Іл'мула", fen = "Without Gral's blessing, these would have been dust long ago.", fua = "Без благословення Ґрала ці кістки давно б стали порохом." }
    t[264701] = "Космічний дзвін"
    t[264704] = { name = "М'ясо Морської Істоти", fen = "A hunk of fishy flesh coated in a slime that may not be edible.", fua = "Шмат рибної плоті, вкритий слизом, який може бути неїстівним." }
    t[264805] = "Бранн-О-Бачення 3000"
    t[264847] = "Дрімотний лозовий мішечок"
    t[264848] = "Осяяний сонцем лозовий клунок"
    t[264849] = "Росяний лозовий мішечок"
    t[264851] = "Наплічник Клинка Сутінків, торкнутий Порожнечею"
    t[264852] = "Лезастий сутінковий наплічник"
    t[264853] = "Позолочений наплічник Сутінків"
    t[264854] = "Провидець душ Лихогіллі"
    t[264855] = "Провидець смерті Лихогіллі"
    t[264856] = "Провидець життя Лихогіллі"
    t[264857] = "Каптур сутінкового фанатика"
    t[264859] = "Каптур сутінкового послідовника"
    t[264860] = "Каптур сутінкового мага"
    t[264878] = "Збурювач муки Асталора"
    t[264882] = { name = "Кошти на вбрання", fen = "Can be exchanged with Andra at The Bazaar in Silvermoon City for an outfit of your choice.", fua = "Можна обміняти в Андри на Базарі в Сільвермуні на вбрання за твоїм вибором." }
    t[264883] = "Комплект: Багряні шати придворного"
    t[264892] = { name = "Нова", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[264895] = { name = "Випробування мисливця флорафауни", fen = "A tablet recording the trials and tribulations of a haranir Hunter's coming-of-age.", fua = "Табличка, що описує випробування та злигодні дорослішання мисливця-гараніра." }
    t[264907] = "Щит новобранця Лицарів крові"
    t[264909] = { name = "Мерехтінь", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[264910] = "Панцироруба сокира на держаку"
    t[264911] = "Лук лісового мисливця"
    t[264912] = "Шпиль каналізатора Порожнечі"
    t[264913] = "Зосереджений Розтинач Нижнього світу"
    t[264914] = { name = "Запас рейнджера", fen = "Cache containing Field Accolades, Relic Coffer Key shards, materials for upgrading gear, gold, and more.", fua = "Схованка з польовими відзнаками, уламками ключа від реліквієвої скрині, матеріалами для вдосконалення спорядження, золотом тощо." }
    t[264968] = { name = "Телуричний лейцвіт", fen = "Wilts as rapidly as it blooms.", fua = "В'яне так само швидко, як і розквітає." }
    t[264970] = "Лезо забуття"
    t[264971] = "Жезл знищення"
    t[264972] = { name = "Припаси Бурі Порожнечі", fen = "Contains a set of equipment to begin your journey into Voidstorm.", fua = "Містить набір спорядження, щоб розпочати твою подорож у Бурю Порожнечі." }
    t[264973] = "Гауда із Золотого Туману"
    t[264981] = "Сік Золотого Гаю"
    t[264982] = "Вино-вато"
    t[264983] = { name = "Чарка Сонячного Колодязя", fen = "Bursting with sweet citrus flavor, and perhaps a drop of the Sunwell's power.", fua = "Вибух солодкого цитрусового смаку і, можливо, краплина сили Сонячного Колодязя." }
    t[264984] = "Питво Темного Колодязя"
    t[264985] = "Світанкова моза"
    t[264987] = "Медовуха магістра"
    t[264988] = { name = "Необхідне для фіналу", fen = "Contains a set of equipment to begin your journey into Midnight Endgame.", fua = "Містить набір спорядження, щоб розпочати твою подорож у фінальний контент Опівночі." }
    t[264989] = "Політ драконояструба"
    t[264990] = "Фейрбризька франчакорта"
    t[264991] = "Ікра вбивства"
    t[264992] = { name = "Бургер Лицаря крові", fen = "Rare please.", fua = "З кров'ю, будь ласка." }
    t[264993] = { name = "Ніжні ніжки дартоптаха", fen = "Actually tastes like chicken.", fua = "Насправді на смак як курятина." }
    t[264994] = "Мариновані квіткові пагони"
    t[264995] = "Варення Золотого Гілля"
    t[264996] = "Позолочена сонячна списа"
    t[264997] = "Сагайдак далекоходів"
    t[265014] = { name = "Відлуння Сяйва", fen = "A small fragment of Light taken from the Lightblinded Vanguard in The Voidspire on Normal difficulty.", fua = "Маленький уламок Світла, здобутий зі Сліпленого Світлом Авангарду в Шпилі Порожнечі на звичайній складності." }
    t[265015] = { name = "Відлуння Сяйва", fen = "A small fragment of Light taken from the Lightblinded Vanguard in The Voidspire on Heroic difficulty.", fua = "Невеликий уламок Світла, здобутий зі Світлоосліпленого авангарду в Шпилі Порожнечі на героїчній складності." }
    t[265016] = { name = "Відлуння Сяйва", fen = "A small fragment of Light taken from the Lightblinded Vanguard in The Voidspire on Mythic difficulty.", fua = "Маленький уламок Світла, здобутий зі Світлосліпого авангарду у Войдспайрі на міфічній складності." }
    t[265018] = "Комплект: Смарагдові шати придворного"
    t[265019] = "Комплект: Лазурові шати придворного"
    t[265020] = "Комплект: Сутінкові шати придворного"
    t[265021] = "Комплект: Осяйні шати придворного"
    t[265022] = "Комплект: Багряне вбрання авгура"
    t[265023] = "Комплект: Смарагдове вбрання авгура"
    t[265024] = "Комплект: Лазурове вбрання авгура"
    t[265025] = "Комплект: Сутінкове вбрання авгура"
    t[265026] = "Комплект: Осяйне вбрання авгура"
    t[265027] = "Щасливий рисячий медальйон"
    t[265030] = { name = "Кай", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[265035] = { name = "Медуза", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[265040] = "Розбитий фокус Порожнечі"
    t[265041] = "Обгорілий ритуальний пергамент"
    t[265042] = "Потьмянілий тіньовий гривень"
    t[265043] = "Пом'яте навершя клинка Порожнечі"
    t[265044] = "Подертий пояс Сутінків"
    t[265045] = "Запечатана пляшечка крові"
    t[265046] = "Викривлена печатка прикликання"
    t[265047] = "Тріснутий філактерій душі"
    t[265048] = "Уламок луски"
    t[265049] = "Свисток із Мандрівної Мушлі"
    t[265050] = "Уламок коралу"
    t[265051] = "Різьблений кореневий тотем"
    t[265052] = "Кришкий кам'яний уламок"
    t[265053] = "Скалка вузлуватої кори"
    t[265054] = "Тріснута племінна маска"
    t[265055] = "Подертий вимірний обмотник"
    t[265056] = "Мерехтлива енергетична котушка"
    t[265057] = "Порожниста сполучна нитка"
    t[265058] = "Спотворений уламок відлуння"
    t[265059] = "Зруйноване ядро Порожнечі"
    t[265061] = "Залишок шепітного Розлому"
    t[265062] = "Нуль-спалаховий осад"
    t[265071] = "Сяйлива сонячна часточка"
    t[265072] = "Іклошитий сагайдак амані"
    t[265096] = "Призване суфле"
    t[265097] = "Призвана коричнева булочка"
    t[265098] = "Призваний круасан"
    t[265099] = "Призваний чай"
    t[265100] = { name = "Камінь Повернення Вартової Ядра", fen = "Taken, misplaced, or perhaps a cruel joke being played on the mortal who finds this device.", fua = "Узятий, загублений чи, можливо, жорстокий жарт над смертним, який знайде цей пристрій." }
    t[265336] = "Довіра доглядача фауни"
    t[265337] = "Гілкомет Ал'нгари"
    t[265341] = { name = "Терношапка", fen = "Poisonous if the spines are not removed, the flesh of this fungi is regarded as a delicacy by the Amani and Zul'Aman's indigenous wildlife.", fua = "Якщо не видалити колючки, м'якоть цього гриба отруйна, та амані й місцева дика звірина Зул'Аману вважають її делікатесом." }
    t[265362] = "Арсенал: Сутінковий клинок"
    t[265363] = "Сокирка сутінкового тіньоварта"
    t[265364] = "Клинок сутінкового лазутчика"
    t[265365] = "Кинджал сутінкового шепотіння"
    t[265366] = "Сутінкова катиня"
    t[265367] = "Сутінкове ікло"
    t[265368] = "Сутінкова руйнівниця"
    t[265399] = { name = "Ритуально Обвуглені Кістки", fen = "They glow faintly in your bag.", fua = "Вони ледь світяться у твоїй торбі." }
    t[265400] = { name = "Скам'яніле Черепашаче Серце", fen = "Never beat very fast anyway.", fua = "Воно й так ніколи не билося надто швидко." }
    t[265402] = { name = "Жменя Крилець Мошок", fen = "Picking them off one-by-one is delicate work.", fua = "Відривати їх одне за одним — робота делікатна." }
    t[265403] = { name = "Плямисте Яйце Морського Птаха", fen = "A delicacy amongst the murlocs.", fua = "Делікатес серед мурлоків." }
    t[265525] = { name = "Моторошний Шматок", fen = "Bits of tortollan shell are stuck between this briny cod's teeth.", fua = "Між зубами цієї солоної тріски застрягли шматочки тортоланського панцира." }
    t[265528] = { name = "Креслення: Позолочене ковадло Сільвермуна", fen = "Teaches you how to craft Gilded Silvermoon Anvil.", fua = "Навчає вас виготовляти Позолочене ковадло Сільвермуна." }
    t[265530] = { name = "Креслення: Оздобна вішалка Сільвермуна", fen = "Teaches you how to craft Ornamental Silvermoon Hanger.", fua = "Навчає вас виготовляти Оздобну вішалку Сільвермуна." }
    t[265532] = { name = "Креслення: Позолочена вішалка Сільвермуна", fen = "Teaches you how to craft Gilded Silvermoon Hanger.", fua = "Навчає вас виготовляти Позолочену вішалку Сільвермуна." }
    t[265534] = { name = "Креслення: Ковадло рен'дорей", fen = "Teaches you how to craft Ren'dorei Anvil.", fua = "Навчає вас виготовляти Ковадло рен'дорей." }
    t[265536] = { name = "Креслення: Майстерний ремісничий молот", fen = "Teaches you how to craft Masterwork Crafting Hammer.", fua = "Навчає вас виготовляти Майстерний ремісничий молот." }
    t[265543] = "Загартований наконечник списа амані"
    t[265554] = "Укріплене держак амані"
    t[265560] = "Зміцнена шкіряна обмотка амані"
    t[265562] = "Спис воїна амані"
    t[265601] = "Велика сокира галактичного гладіатора"
    t[265602] = { name = "Ключ Корсара Амані", fen = "This rusty key looks like it might fit a stone chest.", fua = "Схоже, цей іржавий ключ підійде до кам'яної скрині." }
    t[265603] = "Зубчаста Половина Ключа Корсара"
    t[265609] = { name = "Принцеса Кровопролиття", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[265610] = "Кільцева Половина Ключа Корсара"
    t[265611] = { name = "Зламаний кошик для пікніка", fen = "This basket has seen better days.", fua = "Цей кошик знавав кращі часи." }
    t[265612] = "Кинджал галактичного гладіатора"
    t[265613] = "Бойова глефа галактичного гладіатора"
    t[265614] = "Древкова зброя галактичного гладіатора"
    t[265615] = "Посох галактичного гладіатора"
    t[265616] = "Лук галактичного гладіатора"
    t[265617] = "Скіпетр галактичного гладіатора"
    t[265618] = "Фоліант галактичного гладіатора"
    t[265619] = "Щит галактичного гладіатора"
    t[265620] = { name = "Зволожений Зандаларський Перець", fen = "Once dried, now quite soggy.", fua = "Колись сушений, а тепер геть розмоклий." }
    t[265621] = "Розбитий клинок галактичного гладіатора"
    t[265622] = { name = "Вузлувата Болотяна Палиця", fen = "Perfectly sized to stun a small frog.", fua = "Якраз такого розміру, щоб оглушити маленьку жабку." }
    t[265623] = "Тесак галактичного гладіатора"
    t[265625] = "Бластер галактичного гладіатора"
    t[265626] = { name = "Розбитий Чайник", fen = "Broken into many pieces.", fua = "Розбитий на безліч шматочків." }
    t[265627] = "Великий меч галактичного гладіатора"
    t[265628] = "Моргенштерн галактичного гладіатора"
    t[265629] = "Меч галактичного гладіатора"
    t[265630] = "Бойовий посох галактичного гладіатора"
    t[265632] = "Молот галактичного гладіатора"
    t[265638] = "Велика сокира галактичного гладіатора"
    t[265655] = { name = "Складники ритуалу", fen = "Bones, roots, and other bits used for ritualistic magic.", fua = "Кістки, коріння та інші частки, що використовуються в ритуальній магії." }
    t[265656] = { name = "Ану'шалла, Провідниця Тіні", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[265657] = "Волокно живої агонії"
    t[265658] = "Плащ двору Сільвермуна"
    t[265659] = "Еполети двору Сільвермуна"
    t[265663] = "Накидка двору Сільвермуна"
    t[265664] = "Паросток світла"
    t[265665] = "Лисичковий шанді"
    t[265666] = "Світокореневе пиво"
    t[265667] = "Яскравий Кіготь"
    t[265668] = "Май-тай із Гар'куаї"
    t[265669] = "Ферментована вода Розлому"
    t[265674] = { name = "Смачне м'ясо", fen = "Kinda gamey, really.", fua = "Трохи дичиною відгонить, правда." }
    t[265695] = { name = "Простий Уламок Ядра Порожнечі", fen = "A shard of coalesced Void energy almost humming with potential. Decimus can weave these into Elemental Voidcores to build the Voidforge.", fua = "Уламок згущеної енергії Порожнечі, що мало не гуде від прихованої сили. Децимус може вплести їх у Ядра Порожнечі Елементалів, щоб збудувати Кузню Порожнечі." }
    t[265714] = { name = "Винагорода шукача скарбів", fen = "Chance to receive a Trovehunter's Bounty from a Bountiful delve's Heavy Trunk. Using this rare map will lead you to a Hidden Trove containing powerful equipment, bonus currencies, and a new or upgraded curio. Obtainable once per week per character.", fua = "Дає шанс отримати винагороду шукача скарбів зі скрині щедрої вилазки. Ця рідкісна мапа приведе вас до прихованої схованки, що містить могутнє спорядження, додаткові валюти й нову чи покращену дивовижу. Можна отримати раз на тиждень на персонажа." }
    t[265715] = { name = "Квітковий Букет", fen = "A bouquet of sweetsaw blooms, beautiful and dangerous. The honey-like sweetness is almost enough to make one want to draw closer, but the serated leaves are a warning.", fua = "Букет цвіту солодкопилки — гарний і небезпечний. Медової солодкості майже досить, щоб закортіло підійти ближче, та зазубрене листя — це пересторога." }
    t[265739] = "Підвіска струн серця амані"
    t[265740] = "Тотемна нитка амані"
    t[265746] = { name = "Ідол Рясності", fen = "Represents the depth of your bond with Dundun, Loa of Abundance.", fua = "Уособлює глибину твого зв'язку з Дундуном, лоа Рясності." }
    t[265749] = { name = "Ідол Глибин", fen = "Represents the depth of your bond with Pahk, Loa of the Depths.", fua = "Уособлює глибину твого зв'язку з Пагком, лоа Глибин." }
    t[265767] = "Ловецька торба, плетена з лоаткану"
    t[265768] = "Сумка для здобичі зі шкури амазарда"
    t[265769] = "Лови-Мішок зі Шкіри Вепра"
    t[265770] = "Триниткова сіть"
    t[265771] = "Сітка для мілководдя"
    t[265775] = "Бойовий посох амані"
    t[265778] = "Гарпунна турель порожнистого ядра"
    t[265779] = "Важка гарпунна гармата"
    t[265781] = "Кістяна гиря духотанцівника амані"
    t[265790] = { name = "Сховок світанкових гербів", fen = "A satchel containing 10 Hero and Myth Dawncrests.", fua = "Торбинка, що містить 10 геройських і міфічних світанкових гербів." }
    t[265800] = "Землиста Приправа"
    t[265801] = "Смаковита аномалія"
    t[265803] = { name = "Базарні закуски", fen = "A perfectly portable snack.", fua = "Ідеальна закуска, яку зручно носити з собою." }
    t[265814] = { name = "Перстень-печатка вельможі", fen = "Subtle, sophisticated, and a little unsettling.", fua = "Витончений, вишуканий і трохи бентежний." }
    t[265816] = { name = "Загублений сагайдак", fen = "Barely holding itself together and filled with anything but arrows.", fua = "Ледь тримається купи й напхом напханий чим завгодно, тільки не стрілами." }
    t[265817] = { name = "Перо забутого пісняра", fen = "A little crusty, but still holds some value.", fua = "Трохи засохле, але все ще має певну цінність." }
    t[265818] = { name = "Роздуми Руї, частина 1", fen = "The Rootwarden's notes about his activities.", fua = "Нотатки вартового коренів про його діяльність." }
    t[265819] = { name = "Роздуми Руї, частина 2", fen = "The Rootwarden's notes about his activities.", fua = "Нотатки вартового коренів про його діяльність." }
    t[265820] = { name = "Роздуми Руї, частина 3", fen = "The Rootwarden's notes about his activities.", fua = "Нотатки вартового коренів про його діяльність." }
    t[265824] = { name = "Нотатки вартового коренів", fen = "The rootwarden's notes about his activities.", fua = "Нотатки вартового коренів про його діяльність." }
    t[265828] = "Позолочена армілярна сфера"
    t[265832] = "Неповний збірничок сонетів"
    t[265833] = "Сторінка 1 збірки сонетів"
    t[265834] = "Сторінка 2 збірки сонетів"
    t[265835] = "Сторінка 3 збірки сонетів"
    t[265931] = { name = "Зібрана Ектоплазма", fen = "Twenty globes of softly glowing energy with a slightly slimy, squishy feel to them.", fua = "Двадцять кульок м'яко сяйливої енергії, трохи слизьких і м'якеньких на дотик." }
    t[265995] = { name = "Скриня шукача пригод Кель'Таласа", fen = "Weekly cache containing leveling equipment, gold, and more.", fua = "Щотижнева скриня зі спорядженням для росту рівня, золотом і не тільки." }
    t[265997] = "Накидка чемпіона Лицарів крові"
    t[266002] = { name = "Зламаний механізм пастки", fen = "Unfortunately, disarmament broke a crucial piece of this trap.", fua = "На жаль, при знешкодженні пастки зламалася важлива її частина." }
    t[266075] = "Гарпун винищення"
    t[266076] = { name = "Поглинач Нечестя", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[266098] = "Довгий лук Файнделя"
    t[266099] = { name = "Згаслий Палахкалібур", fen = "No latent power can be felt when holding this blade. Whatever made it remarkable has been consumed by the Void.", fua = "Тримаючи цей клинок, не відчуваєш жодної прихованої сили. Усе, що робило його винятковим, поглинула Порожнеча." }
    t[266100] = { name = "Зазубрений кинджал блукача Розломів", fen = "Riftwalkers out in the field have to make quick decisions and repurpose enemy armaments in a pinch.", fua = "Розломоходи в полі мусять швидко ухвалювати рішення й у скруті пристосовувати ворожу зброю до своїх потреб." }
    t[266101] = "Невикористаний бастіон новачка"
    t[266102] = { name = "Невиразний камінь", fen = "You may have a better understanding of this rock.", fua = "Можливо, ти краще збагнеш природу цього каменя." }
    t[266128] = { name = "Частина аберації", fen = "An undamaged piece taken from a fresh kill, demonstrating not only the killer's ferocity but their precision, as well.", fua = "Неушкоджений шматок, узятий зі свіжої здобичі, що засвідчує не лише лютість мисливця, а й його влучність." }
    t[266183] = { name = "Загадкова сурма Порожнечі", fen = "In darkness, unbind us.", fua = "У темряві визволи нас." }
    t[266196] = { name = "Комплект: вишукана броня ловця здобичі", fen = "An ensemble of Cloth armor found via Prey.", fua = "Комплект тканинної броні, що здобувається через «Здобич»." }
    t[266197] = { name = "Комплект: витончена броня ловця здобичі", fen = "An ensemble of Leather armor found via Prey.", fua = "Комплект шкіряної броні, що здобувається через «Здобич»." }
    t[266198] = { name = "Комплект: міцна броня ловця здобичі", fen = "An ensemble of Mail armor found via Prey.", fua = "Комплект кольчужної броні, що здобувається через «Здобич»." }
    t[266199] = { name = "Комплект: полірована броня ловця здобичі", fen = "An ensemble of Plate armor found via Prey.", fua = "Комплект латної броні, що здобувається через «Здобич»." }
    t[266207] = "Потьмянілий світанковий плащ заклинача"
    t[266208] = "Потьмяніла світанкова мантія корсара"
    t[266209] = "Потьмяніла світанкова накидка вартового"
    t[266210] = "Потьмяніла світанкова накидка командира"
    t[266216] = "Зношений плащ"
    t[266221] = "Зношений покрив"
    t[266223] = "Заплямований плащ"
    t[266224] = "Крихкий Плащ"
    t[266314] = "Намисто бійця-новачка"
    t[266317] = "Перстень бійця-новачка"
    t[266327] = { name = "Бездоганний Хребетний Шип", fen = "Extracting these from the hog is a gristly task.", fua = "Виймати їх із вепра — моторошна й хрящувата робота." }
    t[266370] = "Дундунів Спосіб Подорожі до Рясності"
    t[266384] = "Стовп магістра санктуму"
    t[266386] = "Стовп служки санктуму"
    t[266387] = "Пілон магістра санктуму"
    t[266388] = "Пілон служки санктуму"
    t[266393] = "Позолочений лук далекоходів"
    t[266396] = "Урочистий лук далекоходів"
    t[266429] = "Сонячний шпиль Сільвермуна"
    t[266430] = "Сонцезахист Сільвермуна"
    t[266431] = "Сонячний покрив Сільвермуна"
    t[266432] = "Сонцегребінь Сільвермуна"
    t[266435] = { name = "Пожива для Кі'клак", fen = "Softly glowing bits of ectoplasm. Ki'clak's favorite snack!", fua = "М'яко сяйливі шматочки ектоплазми. Улюблена пожива Кі'клак!" }
    t[266438] = { name = "Ідол Чуми", fen = "Represents the depth of your bond with Mot'amra, Loa of Pestilence.", fua = "Уособлює глибину твого зв'язку з Мот'амрою, лоа Чуми." }
    t[266440] = { name = "Ідол Зросту", fen = "Represents the depth of your bond with Oe, Forest of Growth.", fua = "Уособлює глибину твого зв'язку з Ое, лоа Зросту." }
    t[266448] = { name = "Ядро батареї Гал'гадара", fen = "Between the arcane wires and metal plates, you notice the faint glimmer of glowing yellow crystals.", fua = "Поміж арканних дротів і металевих пластин ти помічаєш тьмяний полиск жовтих кристалів, що світяться." }
    t[266893] = { name = "Сутінкові Підказки", fen = "Everyday thoughts, musings, wishes, hopes, and aspirations to be evil.", fua = "Повсякденні думки, роздуми, бажання, надії та прагнення бути злим." }
    t[266894] = { name = "Сутінковий Щоденник", fen = "A journal with daily writings. Recent entries focus on Xal'atath's disappearance and feeling lost.", fua = "Щоденник із щоденними записами. Останні записи присвячені зникненню Ксал'атат і відчуттю загубленості." }
    t[266896] = { name = "Сутінковий Лист", fen = "Contains commiserations about not receiving what they believe Xal'atath promised them.", fua = "Містить співчуття через те, що вони не отримали того, що їм, як вони вірять, обіцяла Ксал'атат." }
    t[266901] = "Плащ глибоководного нурця"
    t[266902] = "Накидка глибоководного нурця"
    t[266903] = "Наплічники глибоководного нурця"
    t[266965] = "Накидка рясності амані"
    t[266966] = "Накидка рясності амані"
    t[266967] = "Шаль аманійської рясності"
    t[266969] = "Комплект: Шати глибоководного пірнальника"
    t[266970] = "Комплект: Одіння рясності"
    t[266979] = "Шаль потемнілої згаслої зорі"
    t[266980] = "Наплічники потьмянілої згаслої зорі"
    t[266981] = "Накидка затемненої згаслої зорі"
    t[266982] = "Накидка туманної згаслої зорі"
    t[266983] = "Наплічники туманної згаслої зорі"
    t[266984] = "Шаль туманної згаслої зорі"
    t[266985] = "Ситний сільвермунський парад"
    t[266996] = "Ситне гарандарське свято"
    t[267004] = "Подвійний клинок Пожирача"
    t[267005] = { name = "Тотем Ракана", fen = "An old shaman's totem, used as a conduit in rituals to empower loa altars.", fua = "Тотем старого шамана, що слугував провідником у ритуалах для наснаження вівтарів лоа." }
    t[267040] = { name = "Морська дудка", fen = "This salty pipe plays the Song of the Sea.", fua = "Ця солона дудка грає Пісню моря." }
    t[267051] = { name = "Темна частка", fen = "These particles seem to obscure any source of light. Maren Silverwing in Silvermoon City mentioned she may have a use for these.", fua = "Здається, ці частки затьмарюють будь-яке джерело світла. Марен Сільвервінг у Сільвермуні згадувала, що вони могли б їй знадобитися." }
    t[267052] = "Таласський алхімічний комбінезон"
    t[267053] = { name = "Викрійка: таласський алхімічний комбінезон", fen = "Teaches you how to craft Thalassian Alchemy Coveralls.", fua = "Навчає вас виготовляти таласський алхімічний комбінезон." }
    t[267054] = "Ковпак таласського кухаря"
    t[267055] = { name = "Викрійка: таласський кухарський ковпак", fen = "Teaches you how to craft Thalassian Chef's Chapeau.", fua = "Навчає вас виготовляти таласський кухарський ковпак." }
    t[267056] = "Каптур таласського чаклуна-зачаровувача"
    t[267057] = { name = "Викрійка: таласський капелюх зачаровувача", fen = "Teaches you how to craft Thalassian Enchanter's Bonnet.", fua = "Навчає вас виготовляти таласський капелюх зачаровувача." }
    t[267060] = "Каптур таласського травника"
    t[267061] = { name = "Викрійка: таласський каптур травника", fen = "Teaches you how to craft Thalassian Herbalist's Cowl.", fua = "Навчає вас виготовляти таласський каптур травника." }
    t[267062] = "Шати таласського кравця"
    t[267063] = { name = "Викрійка: таласське кравецьке вбрання", fen = "Teaches you how to craft Thalassian Tailor's Threads.", fua = "Навчає вас виготовляти таласське кравецьке вбрання." }
    t[267076] = "Медальйон бійця-новачка"
    t[267077] = "Емблема бійця-початківця"
    t[267085] = { name = "Вируюча Ектоплазма", fen = "A globe of swirling, softly glowing energy, with a slightly slimy, squishy feel to it.", fua = "Кулька вируючої, м'яко сяйливої енергії, трохи слизька й м'якенька на дотик." }
    t[267139] = "Голодна Чорна Діра"
    t[267177] = { name = "Похвала Дуелуму Убивць", fen = "Awards 100 reputation with the Slayer's Duellum.", fua = "Дає 100 одиниць репутації з Дуелумом Убивць." }
    t[267235] = "Дар Життєвої Сили"
    t[267236] = "Дар Швидкості"
    t[267237] = "Дар Сили"
    t[267238] = "Дар Потуги"
    t[267239] = "Дар Можливостей"
    t[267240] = "Дар Стійкості"
    t[267241] = "Дар Поміркованості"
    t[267242] = "Дар Швидкості"
    t[267243] = "Дар Життєвої Сили"
    t[267257] = "Плащ мудреця Гара'ті"
    t[267258] = "Плащ провидця Гара'ті"
    t[267259] = "Наплічники мудреця Гара'ті"
    t[267260] = "Наплічники провидця Гара'ті"
    t[267261] = "Накидка мудреця Гара'ті"
    t[267262] = "Накидка провидця Гара'ті"
    t[267267] = "Маска грабіжника з нетершкіри"
    t[267268] = "Вологі Шовкові Онучі"
    t[267269] = { name = "Благословенна Вогнем Припарка", fen = "Bitter medicinal herbs wreathed in cauterizing flames", fua = "Гіркі лікарські трави, оповиті припікальним полум'ям" }
    t[267270] = "Просякнуті тінню наголінники"
    t[267271] = "Нетерсталеві дефлектори"
    t[267277] = { name = "Чиста рясність", fen = "Pure bounty of the land, stirred by the Loa of Abundance and claimed through Abundant Harvests. Used to purchase goods from Chel the Chip.", fua = "Чисті щедроти землі, пробуджені Лоа рясності й здобуті завдяки рясним врожаям. Використовується, щоб купувати товари в Чела Чіпа." }
    t[267278] = { name = "Перли рибалки", fen = "Rewarded from Abyss Anglers dives, and used in trade with Depthdivers Jeju and Tu'nakit in Zul'Aman.", fua = "Видаються за занурення Рибалок Безодні й використовуються в торгівлі з глибиннорибами Джеджу та Ту'накітом у Зул'Амані." }
    t[267281] = { name = "Креслення: Милосердя Лицаря крові", fen = "Teaches you how to craft Blood Knight's Mercy.", fua = "Навчає вас виготовляти Милосердя Лицаря крові." }
    t[267282] = { name = "Креслення: Бойовий клинок Лицаря крові", fen = "Teaches you how to craft Blood Knight's Warblade.", fua = "Навчає вас виготовляти Бойовий клинок Лицаря крові." }
    t[267284] = { name = "Креслення: Цвітокована пазурка", fen = "Teaches you how to craft Bloomforged Claw.", fua = "Навчає вас виготовляти Цвітоковану пазурку." }
    t[267285] = { name = "Креслення: Тесак Магістра", fen = "Teaches you how to craft Magister's Cleaver.", fua = "Навчає вас виготовляти Тесак Магістра." }
    t[267286] = { name = "Креслення: Манамеч Магістра", fen = "Teaches you how to craft Magister's Mana Sword.", fua = "Навчає вас виготовляти Манамеч Магістра." }
    t[267287] = { name = "Креслення: Ритуальний ніж Магістра", fen = "Teaches you how to craft Magister's Ritual Knife.", fua = "Навчає вас виготовляти Ритуальний ніж Магістра." }
    t[267291] = "Клей для Ключа від Скрині"
    t[267299] = "Скарбниця Дуелуму Убивць"
    t[267371] = "Розривач галактичного гладіатора"
    t[267375] = "Пазурі галактичного претендента"
    t[267376] = { name = "Жарина Джан'алая", fen = "Radiating the heat of the loa.", fua = "Випромінює жар лоа." }
    t[267379] = { name = "Корчмарський кухоль", fen = "A simple mug for a simple beverage.", fua = "Простий кухоль для простого напою." }
    t[267393] = { name = "Сяйливе дроблення", fen = "Shatter Radiant Shards into Eversinging Dust.", fua = "Розбиває сяйливі уламки на вічноспівний пил." }
    t[267394] = { name = "Техніка: Затишна полиця сін'дорей", fen = "Teaches you how to craft Homely Sin'dorei Shelf.", fua = "Навчає вас виготовляти затишну полицю сін'дорей." }
    t[267395] = { name = "Техніка: Затишні настінні полиці", fen = "Teaches you how to craft Homely Wall Shelves.", fua = "Навчає вас виготовляти затишні настінні полиці." }
    t[267399] = { name = "Техніка: Міцна діжка рен'дорей", fen = "Teaches you how to craft Sturdy Ren'dorei Cask.", fua = "Навчає вас виготовляти міцну діжку рен'дорей." }
    t[267400] = { name = "Техніка: Дикий висячий сувій", fen = "Teaches you how to craft a Wild Hanging Scroll.", fua = "Навчає вас виготовляти дикий висячий сувій." }
    t[267401] = { name = "Світанкове розколювання", fen = "Shatter Dawn Crystals into Radiant Shards.", fua = "Розколює світанкові кристали на осяйні скалки." }
    t[267417] = "Кігті галактичного претендента"
    t[267444] = "Плащ контрабандиста"
    t[267445] = "Плащ агента Сільвермуна"
    t[267446] = "Плащ розвідника"
    t[267447] = "Вишите покривало далекоходів"
    t[267448] = "Кровозагартований плащ"
    t[267449] = "Покрив руйнівника чарів"
    t[267456] = "Подушка Малого Скутса"
    t[267466] = "Плащ Срібносонячного договору"
    t[267467] = "Накидка Срібносонячного договору"
    t[267468] = "Наплічники Срібносонячного договору"
    t[267469] = "Знак прудкості бійця-новачка"
    t[267479] = "Кушак завзятого захисника гара'ті"
    t[267480] = "Шнур завзятого захисника гара'ті"
    t[267481] = "Пояс завзятого захисника гара'ті"
    t[267482] = "Широкий пояс завзятого захисника гара'ті"
    t[267486] = { name = "Простий кухоль", fen = "A simple cup for a simple beverage.", fua = "Простий кухоль для простого напою." }
    t[267487] = { name = "Запалений смолоскип", fen = "A temporary light in the darkness.", fua = "Тимчасове світло в темряві." }
    t[267488] = { name = "Туманний сховок Порожнечі: Корона Космосу", fen = "Transmute two Nebulous Voidcores into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює два туманні ядра Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[267491] = "Плащ бійця-початківця"
    t[267571] = "Галактична поліроль завойовника"
    t[267572] = "Галактичний лак завойовника"
    t[267604] = "Лабети колосальних бегемотів"
    t[267605] = "Рукавиці Нескінченного Вихору"
    t[267606] = "Рукавиці нескінченної гравітації"
    t[267607] = "Імлисті присмеркові обмотки рук"
    t[267614] = { name = "Шепітна фіала", fen = "Magical crucible resilient enough to contain Void energy.", fua = "Магічний тигель, достатньо стійкий, щоб утримувати енергію Порожнечі." }
    t[267615] = { name = "Імператорський кухоль", fen = "Imperial grade goods at civilian prices.", fua = "Товар імператорської якості за цивільними цінами." }
    t[267617] = { name = "Витончений келих", fen = "Sophisticated drinkware for sophisticated beverages.", fua = "Витончений посуд для витончених напоїв." }
    t[267618] = { name = "Іржаве вмістилище", fen = "Rust-free on the inside.", fua = "Усередині без іржі." }
    t[267619] = { name = "Келих для дегустації", fen = "Delicate and fragile. Hold carefully.", fua = "Тендітний і крихкий. Тримай обережно." }
    t[267620] = { name = "Простий кухоль", fen = "A simple stein for a simple beverage.", fua = "Простий кухоль для простого напою." }
    t[267621] = { name = "Традиційний кухоль", fen = "A traditional stein for a traditional beverage.", fua = "Традиційний кухоль для традиційного напою." }
    t[267622] = { name = "Груба смолоскип", fen = "A rugged but effective means of lighting your path.", fua = "Грубий, але дієвий спосіб освітити твій шлях." }
    t[267623] = { name = "Простий смолоскип", fen = "A simple but effective torch.", fua = "Простий, але дієвий смолоскип." }
    t[267624] = { name = "Бамбукова таця", fen = "Perfect for serving tea, brew and warm hospitality.", fua = "Ідеальна, щоб подавати чай, напої та теплу гостинність." }
    t[267625] = { name = "Запалена свічка", fen = "Not as effective as an ignited torch but it will suffice.", fua = "Не така дієва, як запалений смолоскип, але цього вистачить." }
    t[267626] = { name = "Черствий корчмарський хліб", fen = "Too stale to eat.", fua = "Надто черствий, щоб їсти." }
    t[267627] = { name = "Декоративний корчемний сир", fen = "Great for plate decoration. Not so great for eating.", fua = "Чудовий для прикрашання тарілки. Не такий чудовий для їжі." }
    t[267638] = "Потьмяніле сонячне вістря Сільвермуна"
    t[267639] = "Потьмянілий сонячний захисник Сільвермуна"
    t[267640] = "Потьмяніла сонячна заслона Сільвермуна"
    t[267641] = "Потьмянілий сонячний гребінь Сільвермуна"
    t[267642] = "Зношений підвісок-струна серця амані"
    t[267643] = "Зношена тотемна струна амані"
    t[267647] = "Дар Завзяття"
    t[267648] = "Дар Завзяття"
    t[267649] = "Дар Завзяття"
    t[267653] = { name = "Мерехтливий порошок", fen = "A glossy, fine powder that shimmers with arcane magic.", fua = "Глянцевий дрібний порошок, що мерехтить арканною магією." }
    t[267654] = { name = "Вирувата арканна есенція", fen = "An ephemeral flow of arcane magic, fit for study by an aspiring enchanter.", fua = "Ефемерний потік арканної магії, придатний для вивчення майбутнім зачаровувачем." }
    t[267655] = { name = "Переповнений Уламок Мани", fen = "A small crystal packed with condensed mana. An enchanter could learn much by studying it.", fua = "Маленький кристал, наповнений згущеною маною. Зачаровник міг би багато чого навчитися, вивчаючи його." }
    t[267838] = { name = "Сонцекриле пташеня", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[268025] = { name = "Важкий кухоль", fen = "A heavy stein for a heavy beverage.", fua = "Важкий кухоль для міцного напою." }
    t[268032] = "Призвана ілюзорна оздоба – Квітуче світло"
    t[268033] = "Призвана ілюзорна оздоба – Обійми природи"
    t[268034] = "Призвана ілюзорна оздоба – Торкнутий Порожнечею"
    t[268038] = "Нескінченний кодекс квітучого світла"
    t[268039] = "Нескінченний кодекс грації природи"
    t[268041] = "Нескінченний кодекс торкнутих Порожнечею"
    t[268042] = { name = "Формула: Нескінченний кодекс квітучого Світла", fen = "Teaches you how to create Endless Codex of Blooming Light.", fua = "Навчає тебе, як створити Нескінченний кодекс квітучого Світла." }
    t[268043] = { name = "Формула: Нескінченний кодекс грації природи", fen = "Teaches you how to create Endless Codex of Nature's Grace.", fua = "Навчає тебе, як створити Нескінченний кодекс грації природи." }
    t[268044] = { name = "Формула: Нескінченний кодекс торкнутих Порожнечею", fen = "Teaches you how to create Endless Codex of the Voidtouched.", fua = "Навчає тебе, як створити Нескінченний кодекс торкнутих Порожнечею." }
    t[268053] = { name = "Грубий кухоль", fen = "Intimidating drinkware for those intense tavern disputes.", fua = "Залякувальний посуд для тих запеклих корчемних суперечок." }
    t[268068] = { name = "Міцний смолоскип", fen = "Sturdy and reliable.", fua = "Міцний і надійний." }
    t[268085] = { name = "Ручний смолоскип", fen = "Warning: Do not hold your hand near the flame", fua = "Увага: не тримай руку біля полум'я" }
    t[268095] = { name = "Свіжа Припарка", fen = "A briny herbal treatment that extracts and neutralizes toxins.", fua = "Солоний трав'яний засіб, що витягує й знешкоджує токсини." }
    t[268110] = { name = "Сирна таця", fen = "Cheese and grapes. The perfect combination.", fua = "Сир і виноград. Ідеальне поєднання." }
    t[268111] = { name = "Арконітовий маяк", fen = "Holding the beacon still is a vital lesson for all artificer-in-training.", fua = "Уміння тримати маяк нерухомо — важлива наука для кожного майстра-початківця." }
    t[268112] = { name = "Аргунітовий маяк", fen = "Capable of producing a lightsource only visible by the one who wields it.", fua = "Здатний породжувати джерело світла, видиме лише тому, хто його тримає." }
    t[268113] = { name = "Подих Джан'алая", fen = "Watch dem burn!", fua = "Дивись, як вони горять!" }
    t[268115] = { name = "Перепечений пончик", fen = "Too cooked to eat, but perfect for putting on display.", fua = "Надто пригорілий, щоб їсти, але ідеальний для виставляння напоказ." }
    t[268116] = { name = "Тримач двополум'я", fen = "Two flames for double the coverage.", fua = "Два полум'я для подвійного охоплення." }
    t[268122] = { name = "Розвіяні монети", fen = "Your coins have been dispelled. Participate more in the next match.", fua = "Твої монети розвіяно. Бери активнішу участь у наступному матчі." }
    t[268196] = "Посічений Отрутою Панцирний Щит"
    t[268197] = "Хребет Сичливої Безодні"
    t[268198] = "Їдкий Трощитель Хранителів"
    t[268199] = { name = "Бульбашкова Хлопавка Пронизувача Припливів", fen = "Pop, pop, pop.", fua = "Лусь, лусь, лусь." }
    t[268200] = { name = "Запасний Бластер Ґеббо", fen = "Good thing he kept it at the bottom of his bags.", fua = "Добре, що він тримав його на самому дні своїх торб." }
    t[268201] = "Отруйна Кістяна Глефа"
    t[268202] = "Щелепа Закутої Богині"
    t[268203] = { name = "Чаклунський Душороз", fen = "\"Dis be de only way.\" - Nek'zali", fua = "«Це єдиний шлях.» — Нек'залі" }
    t[268204] = "Отруйна Заточка Давнього Конструкта"
    t[268205] = "Крилатий Спрямовувач Отрутника"
    t[268206] = "Молоток Звивистого Дикуна"
    t[268207] = "Великий Лук Їдкого Спокою"
    t[268208] = { name = "Церемоніальний Тесак Міцнокрова", fen = "Others had noticed her obsession. Did he ignore it? Or could he not see his sister for what she had become?", fua = "Інші помічали її одержимість. Чи він не зважав на це? Чи просто не бачив, ким стала його сестра?" }
    t[268209] = { name = "Аман'мусо, Помста Воєначальника", fen = "Do you submit to de loa, or do de loa submit to you?", fua = "Це ти коришся лоа, чи лоа коряться тобі?" }
    t[268210] = "Лиховісний Кийок Духів"
    t[268211] = "Лиховісний Клинок Прокльонів"
    t[268213] = { name = "Мазе-роа, Лють Воєначальника", fen = "De loa say our grandfather, de great Zul'jin, betrayed them. But why believe them?", fua = "Лоа кажуть, що наш дід, великий Зул'джин, зрадив їх. Та навіщо їм вірити?" }
    t[268214] = "Підступне Зубчасте Лезо"
    t[268215] = "Бердиш Безоднього Демона Виводку"
    t[268216] = "Проклятий Пояс Реліквіарію"
    t[268217] = "Наручі Припливу"
    t[268218] = "Духоходи Нек'залі"
    t[268219] = "Бойова Маска Тіньового Мисливця"
    t[268220] = "Душителі з Лускатих Пластин"
    t[268221] = "Роба Чаклунки, Скутої Припливами"
    t[268222] = "Нагрудник Відчайдушного Духа"
    t[268223] = "Офідійська Кольчуга з Ікол"
    t[268224] = "Поножі Вартового Отрути"
    t[268225] = "Звивисті Поножі Вроків"
    t[268226] = "Наплічники Розбурханого Моря"
    t[268227] = { name = "Неодержимий Пояс із Черепом", fen = "Thoroughly cleansed with fish to remove all traces of possession.", fua = "Ретельно очищений рибою, щоб усунути всі сліди одержимості." }
    t[268228] = "Обпалені Отрутою Манжети"
    t[268229] = "Шолом Воскреслої Жертви"
    t[268230] = "Вінець Вічного Ікла"
    t[268231] = "Наплічники Звивистої Душі"
    t[268232] = "Пояс Гроту Безодні"
    t[268233] = "Люті Лускаті Чоботи"
    t[268234] = { name = "Безжальні Рукавиці Різанини", fen = "Slaughter!", fua = "Різанина!" }
    t[268235] = "Шати Пробудження"
    t[268236] = "Жертовні Рейтузи Послушника"
    t[268237] = "Поножі Розплетеного Єднання"
    t[268238] = "Рукавиці Вируючої Люті"
    t[268239] = "Наручі в Панцирній Оправі"
    t[268240] = "Кайдани Неспокійного Духа"
    t[268241] = "Оздоби Вічного Кільця"
    t[268242] = "Каптур Заблудлого Мудреця Сувоїв"
    t[268243] = "Рукавиці Вічної Тіні"
    t[268244] = "Пояс Забутого Гроту"
    t[268245] = "Латні Чоботи Похованого Культиста"
    t[268246] = "Наплічники Пінистої Отрути"
    t[268247] = "Чоботи Хвилеріза"
    t[268248] = { name = "Шаль Прикликання Амані", fen = "Kale, Ula'tek! Ula'tek ban kale!", fua = "Кале, Ула'тек! Ула'тек бан кале!" }
    t[268249] = { name = "Перстень Мерзенного Алхіміка", fen = "Ooh, a live subject!", fua = "О-о, живий піддослідний!" }
    t[268250] = { name = "Їдкий Ланцюг Вартового", fen = "Curse of her blood purge you.", fua = "Хай прокляття її крові очистить тебе." }
    t[268251] = { name = "Амулет Двох Ікол", fen = "The hunger of Ula'tek's most ancient spawn grew until the very end.", fua = "Голод найдавнішого поріддя Ула'тек зростав до самого кінця." }
    t[268252] = "Кігтистий Перстень Верховного Здорованя"
    t[268253] = "Шовкова Накидка Вуду"
    t[268254] = { name = "Зміїний Пояс для Змішування", fen = "Little bit of this, little bit of that.", fua = "Трішки того, трішки сього." }
    t[268255] = "Реготливі Чоботи Душ"
    t[268256] = "Пояс Покинутої Посудини"
    t[268257] = "Їдкий Пояс у Ланцюгах"
    t[268258] = "Чоботи Відчайдушного Мандрівника"
    t[268259] = "Пояс Отруйного Жалю"
    t[268260] = "Бойові Чоботи Лускатого Лиходія"
    t[268261] = { name = "Обслинені Зміїні Капці", fen = "Quite luxurious, despite the spittle.", fua = "Доволі розкішні, попри слину." }
    t[268262] = "Захист від Бризок Бульбоплавів"
    t[268263] = "Містична Гілка Фростскейла"
    t[268264] = "Ікло Ненажерливого Бенкетника"
    t[268265] = { name = "Релікварій Згуби Акірів", fen = "The aqir fled before her vicious onslaught, but the rivers of venom left in her wake were indiscriminate.", fua = "Акіри тікали від її лютого натиску, але ріки отрути, що лишалися за нею, не розбирали, кого губити." }
    t[268266] = "Звабливий Бульбашковий Перстень"
    t[268274] = "Нашийник Морги"
    t[268280] = "Грибна шапка володаря спор"
    t[268281] = { name = "Ула'тельбухи", fen = "Unsightly (and stinky) but goes a long way toward an antidote.", fua = "Негарні (і смердючі), але неабияк наблизять до протиотрути." }
    t[268282] = "Розкішні ґрунтоступи"
    t[268283] = "Корона гнилоцвіту"
    t[268284] = "Гнилісні шати мікоманта"
    t[268285] = "Бойовий обладунок гнилого Доглядача"
    t[268286] = "Пояс гнилого велетня"
    t[268287] = "Тупотуни Злобожаха"
    t[268288] = "Стегнові щитки фунґаріанського безумства"
    t[268289] = "Пояс пожирущої гнилі"
    t[268290] = "Квітучий перстень закличника спор"
    t[268291] = "Спорове серце Гнилобагна"
    t[268292] = "Міцелярний знак володаря спор"
    t[268297] = "Дзвінкий мішок золота"
    t[268326] = "Плащ громадянина сін'дорей"
    t[268327] = "Шаль громадянина сін'дорей"
    t[268365] = "Посох таласського змагуна"
    t[268366] = { name = "Техніка: Посох таласського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Staff.", fua = "Навчає вас виготовляти посох таласського змагуна." }
    t[268455] = "Зачарований Пісковий Годинник"
    t[268456] = "Оживлена Лава"
    t[268458] = { name = "Туманний сховок Порожнечі: Бело'рен, дитя Ал'ара", fen = "Transmute two Nebulous Voidcores into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює два туманні ядра Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268459] = { name = "Туманний сховок Порожнечі: Імператор Аверзіан", fen = "Transmute two Nebulous Voidcores into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює два туманні ядра Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268460] = { name = "Туманний сховок Порожнечі: Воразіус", fen = "Transmute two Nebulous Voidcores into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює два туманні ядра Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268461] = { name = "Туманний сховок Порожнечі: Полеглий король Салгадаар", fen = "Transmute two Nebulous Voidcores into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює два туманні ядра Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268462] = { name = "Туманний сховок Порожнечі: Велґор і Еззорак", fen = "Transmute two Nebulous Voidcores into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює два туманні ядра Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268463] = { name = "Туманний сховок Порожнечі: Засліплений Світлом авангард", fen = "Transmute two Nebulous Voidcores into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює два туманні ядра Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268464] = { name = "Туманний сховок Порожнечі: Хімерус, невимовний бог", fen = "Transmute two Nebulous Voidcores into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює два туманні ядра Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268465] = { name = "Туманний сховок Порожнечі: Академія Алґет'ара", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268466] = { name = "Туманний сховок Порожнечі: Тераса магістрів", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268467] = { name = "Туманний сховок Порожнечі: Вузлова точка Ксенас", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268468] = { name = "Туманний сховок Порожнечі: Яма Сарона", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268469] = { name = "Туманний сховок Порожнечі: Престол Тріумвірату", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268470] = { name = "Туманний сховок Порожнечі: Небосяг", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268471] = { name = "Туманний сховок Порожнечі: Шпиль Віндраннерів", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268473] = { name = "Туманний сховок Порожнечі: Печери Майсари", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268475] = { name = "Дзвонар бань з вічноядра", fen = "For when you see a dome that needs dingin'.", fua = "Для тих випадків, коли бачиш баню, яку треба добряче дзенькнути." }
    t[268477] = { name = "БАХ x3", fen = "Come on, shoot even faster!", fua = "Ну ж бо, стріляй іще швидше!" }
    t[268479] = "Рушниця таласського змагуна"
    t[268480] = { name = "Схема: рушниця таласійського змагуна", fen = "Teaches you how to craft Thalassian Competitor's Rifle.", fua = "Навчає виготовляти рушницю таласійського змагуна." }
    t[268481] = { name = "Стільник чарівної бджоли магістра", fen = "Teaches you how to summon the Breaker Bee.  This mount changes depending on your Riding skill and location.", fua = "Навчає вас викликати Бджолу-нищительку. Ця їздова тварина змінюється залежно від вашого вміння їзди верхи та місцеперебування." }
    t[268485] = { name = "Переможна вершинна скриня Штормаріона", fen = "Weekly cache containing materials for upgrading equipment, gold, coffer key shards, and more.\n\n\n\nThe first two pinnacle caches you earn each week contain a piece of Adventurer equipment.", fua = "Щотижнева скриня з матеріалами для поліпшення спорядження, золотом, уламками ключа від реліквієвої скрині тощо.\n\n\n\nПерші дві найвищі скрині, здобуті за тиждень, містять предмет спорядження шукача пригод." }
    t[268487] = { name = "Набір припасів завзятого учня", fen = "Weekly cache containing materials for upgrading equipment, gold, coffer key shards, and more.\n\n\n\nThe first two pinnacle caches you earn each week contain a piece of Adventurer equipment.", fua = "Щотижнева скриня з матеріалами для поліпшення спорядження, золотом, уламками ключа від реліквієвої скрині тощо.\n\n\n\nПерші дві найвищі скрині, здобуті за тиждень, містять предмет спорядження шукача пригод." }
    t[268488] = { name = "Переповнена торба рясності", fen = "Weekly cache containing materials for upgrading equipment, gold, coffer key shards, and more.\n\n\n\nThe first two pinnacle caches you earn each week contain a piece of Adventurer equipment.", fua = "Щотижнева скриня з матеріалами для поліпшення спорядження, золотом, уламками ключа від реліквієвої скрині тощо.\n\n\n\nПерші дві найвищі скрині, здобуті за тиждень, містять предмет спорядження шукача пригод." }
    t[268489] = { name = "Лишкова торба святкових гостинців", fen = "Weekly cache containing materials for upgrading equipment, gold, coffer key shards, and more.\n\n\n\nThe first two pinnacle caches you earn each week contain a piece of Adventurer equipment.", fua = "Щотижнева скриня з матеріалами для поліпшення спорядження, золотом, уламками ключа від реліквієвої скрині тощо.\n\n\n\nПерші дві найвищі скрині, здобуті за тиждень, містять предмет спорядження шукача пригод." }
    t[268490] = { name = "Схованка вершини", fen = "Weekly cache containing materials for upgrading equipment, gold, coffer key shards, and more.\n\n\n\nThe first two pinnacle caches you earn each week contain a piece of Adventurer equipment.", fua = "Щотижнева скриня з матеріалами для поліпшення спорядження, золотом, уламками ключа від реліквієвої скрині тощо.\n\n\n\nПерші дві найвищі скрині, здобуті за тиждень, містять предмет спорядження шукача пригод." }
    t[268504] = { name = "Несправний Посох", fen = "Sparks leap from the ancient-looking staff's crystal. It looks like it's been tampered with.", fua = "З кристала на старовинному з вигляду посоху сиплються іскри. Схоже, хтось у ньому поколупався." }
    t[268519] = { name = "Нектар Старовинного Цвіту", fen = "Silvermoon flowers of yore are the only place one may find this nectar of special alchemical properties.", fua = "Цей нектар з особливими алхімічними властивостями можна знайти лише в давніх квітах Сільвермуна." }
    t[268534] = "Указ санктуму"
    t[268545] = { name = "Скриня завзятого ловця здобичі", fen = "A chest containing a random piece of leveling equipment, supplies, gold, and a chance for professions materials.", fua = "Скриня, що містить випадковий предмет спорядження для прокачування, припаси, золото та шанс на матеріали для професій." }
    t[268552] = { name = "Висхідне ядро Порожнечі", fen = "Weave the Voidcore's energy into worthy equipment with Decimus's assistance at the Howling Ridge in the Voidstorm.", fua = "Вплети енергію ядра Порожнечі в гідне спорядження за допомогою Децимуса на Виючому хребті в Бурі Порожнечі." }
    t[268557] = { name = "Акікі", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[268578] = { name = "Яструбоступ, торкнутий Порожнечею", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[268584] = { name = "Неушкоджена Зміїна Луска", fen = "Do not hold too long. The toxin is quite potent.", fua = "Не тримай надто довго. Отрута вельми сильна." }
    t[268628] = { name = "Залоза Струмочерева", fen = "The electric gland of a Zapgut eel carries a powerful electric charge. Avoid ingesting.", fua = "Електрична залоза струмочеревого вугра несе потужний електричний заряд. Не вживати всередину." }
    t[268644] = { name = "Зан", fen = "Teaches you how to summon this companion", fua = "Навчає вас прикликати цього супутника" }
    t[268650] = { name = "Висхідний уламок Порожнечі", fen = "Although only a fragment of a Voidcore, it hums with an unnerving power. More may be found by defeating powerful foes.", fua = "Хоч це й лише фрагмент ядра Порожнечі, він гуде тривожною силою. Більше можна здобути, долаючи могутніх ворогів." }
    t[268679] = "Ситна неймовірно королівська печеня"
    t[268680] = "Ситне квіткове шаленство"
    t[268717] = "Панцир Панго"
    t[268728] = "Мазь Смолораптора"
    t[268730] = { name = "Спотворене Нечестям яйце", fen = "Opalescent blue glistens off of its sturdy exterior. Warm to the touch, this mysterious egg pulses with an almost familiar energy.", fua = "Його міцна шкаралупа виблискує мерехтливою синявою. Тепле на дотик, це загадкове яйце пульсує майже знайомою енергією." }
    t[268807] = { name = "Подертий лист Сутінків", fen = "The seal of the Twilight Blade has been stamped into the broken wax.", fua = "У надламаному воску відтиснута печатка Клинка Сутінків." }
    t[268808] = { name = "Зледенілий ключ", fen = "Motes of void energy seem to dissipate from the cold, green metal orb.", fua = "Частинки енергії Порожнечі немовби розсіюються з холодної зеленої металевої кулі." }
    t[268809] = { name = "Зачарований сувій наг", fen = "The shimmering arcane letters rearrange themselves every few seconds, making it very difficult to decipher.", fua = "Мерехтливі арканні літери щокілька секунд переставляються місцями, тож розшифрувати їх украй важко." }
    t[268823] = "Сувій Пошуку"
    t[268826] = "Баластний Камінь"
    t[268871] = { name = "Камінь Потрібного Розміру", fen = "Seems to be roughly the right shape. If you squint.", fua = "Здається, приблизно потрібної форми. Якщо примружитися." }
    t[268921] = "Посох Великої Темряви"
    t[268929] = "Поспіхом Написана Записка"
    t[268950] = { name = "Відлякувач Мурлоків", fen = "Though the stench is contained, you can tell it is seeping into your skin.", fua = "Хоч сморід і запечатаний, ви відчуваєте, як він просякає вам у шкіру." }
    t[268951] = { name = "Знайоме Намисто із Зубів Трешадона", fen = "This necklace feels familiar... like you are looking at your own handiwork.", fua = "Це намисто здається знайомим... ніби дивишся на власну роботу." }
    t[268952] = "Поспіхом Написана Записка"
    t[268953] = { name = "Знайомий Головний Убір Амані", fen = "This headdress feels familiar... like you are looking at your own handiwork.", fua = "Цей головний убір здається знайомим... ніби дивишся на власну роботу." }
    t[268954] = { name = "Ентропійний екстракт", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[268955] = { name = "Ентропійний екстракт", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[268959] = { name = "Їдка Суміш", fen = "Oh dear loa, what have you created? Putrid may even be too generous to describe the smell you encounter.", fua = "О любі лоа, що ж це за витвір? Навіть «гнилий» — надто щедре слово для запаху, який ударяє в ніс." }
    t[268964] = { name = "Знайомий Головний Убір Амані", fen = "This headdress feels familiar... like you are looking at your own handiwork.", fua = "Цей головний убір здається знайомим... ніби дивишся на власну роботу." }
    t[268965] = { name = "Знайоме Намисто із Зубів Трешадона", fen = "This necklace feels familiar... like you are looking at your own handiwork.", fua = "Це намисто здається знайомим... ніби дивишся на власну роботу." }
    t[268968] = "Поспіхом Написана Записка"
    t[268969] = { name = "Туманний сховок Порожнечі: Скарб дослідника Глибин", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[268970] = { name = "Велична Статуя Орла", fen = "A powerful eagle in flight. Your local decor vendor has expressed an interest in such things.", fua = "Могутній орел у польоті. Ваш місцевий торговець декором цікавився такими речами." }
    t[268972] = { name = "Засушений Кровотерн", fen = "Pressed for preservation. Your local flora decor trader may be interested in this exotic specimen.", fua = "Засушено для збереження. Місцевого торговця рослинним декором може зацікавити цей екзотичний екземпляр." }
    t[268973] = { name = "Кістяне Перо", fen = "An Amani pen carved from an animal bone. Your local steward may appreciate it.", fua = "Перо Амані, вирізьблене з тваринної кістки. Вашому місцевому управителю воно може сподобатися." }
    t[268974] = { name = "Деактивований Оберіг Амані від Вроків", fen = "This type of curiosity could be of interest to the Last Architect.", fua = "Така дивовижа могла б зацікавити Останнього Архітектора." }
    t[268975] = { name = "Бойова Сокира Амані", fen = "Even while blunted, this axe could be a collector's item for one whose trade involves chopping things.", fua = "Хай і затуплена, ця сокира може стати колекційною річчю для того, чиє ремесло — рубати." }
    t[268976] = { name = "«Ароматна» Пляшка", fen = "The foul smelling substance in this bottle should be as far away from your neighborhood as you can get it. You may be able to trade it to people who trade with far off lands.", fua = "Смердючу речовину в цій пляшці варто тримати якнайдалі від свого сусідства. Можливо, її вдасться збути тим, хто торгує з далекими краями." }
    t[268977] = { name = "Осеїнова Рибальська Дрібничка", fen = "Said to bring luck and a bountiful harvest of fish. Could be of use to a person in the fish trade.", fua = "Кажуть, приносить удачу й щедрий улов. Може знадобитися тому, хто торгує рибою." }
    t[268978] = { name = "Статуя Торґи", fen = "A very small carving of Torga, the Turtle Loa. If you can find a tortollan in your neighborhood, they would appreciate this.", fua = "Дуже маленька різьблена фігурка Торґи, Черепашачого Лоа. Якщо у твоєму сусідстві знайдеться тортоланець, він це оцінить." }
    t[268996] = { name = "Мішечок польових відзнак", fen = "Maren Silverwing will exchange these for Void-Touched caches in Silvermoon City.", fua = "Марен Сільвервінг обміняє їх на торкнуті Порожнечею скрині в Сільвермуні." }
    t[269005] = { name = "Блискуча торбинка монет шукача здобичі", fen = "A pouch containing 125 gold.", fua = "Торбинка зі 125 золотими." }
    t[269006] = { name = "Осяйна торбинка монет шукача здобичі", fen = "A pouch containing 150 gold.", fua = "Торбинка зі 150 золотими." }
    t[269007] = { name = "Мерехтлива торбинка монет шукача здобичі", fen = "A pouch containing 175 gold.", fua = "Торбинка зі 175 золотими." }
    t[269019] = { name = "Будівельний Молот Амані", fen = "A hammer worthy of any builder. It could be a good gift for a contractor.", fua = "Молот, гідний будь-якого будівничого. З нього вийшов би добрий подарунок для підрядника." }
    t[269020] = { name = "Різьблений Оберіг", fen = "A grim ward said to scare away evil spirits. Or would, if properly enchanted. As it is, it may be a curiosity to those who peddle in the more macabre decor.", fua = "Похмурий оберіг, що нібито відлякує злих духів. Принаймні відлякував би, якби його як слід зачарували. А так — хіба що цікавинка для тих, хто торгує моторошнішим декором." }
    t[269021] = { name = "Дрібничка Джан'алая", fen = "An artistic rendition of Jan'alai as a sunburst, this is said to ensure that sun always shines and crops will grow. Perhaps a farmer might want it?", fua = "Мистецьке зображення Джан'алая у вигляді сонячного сяйва; кажуть, воно гарантує, що сонце завжди світитиме, а врожай ростиме. Може, якийсь фермер захоче його собі?" }
    t[269022] = { name = "Цілющі води Ал'уа", fen = "Tingles to the touch and taste. Intended to counteract the poison of the nearby creatures during Shul'ka rituals.", fua = "Поколює на дотик і на смак. Призначене нейтралізувати отруту тутешніх створінь під час ритуалів Шул'ка." }
    t[269023] = { name = "Фітогенна отруйна залоза", fen = "The secretions coming from these plant-like organs are most definitely toxic.", fua = "Виділення з цих рослиноподібних органів безперечно токсичні." }
    t[269028] = { name = "Сажолап", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[269029] = { name = "Торба Цілком Законного Товару Амані", fen = "A variety of Amani items, supposedly. These may be of interest to your neighbors.", fua = "Нібито всілякі речі амані. Можуть зацікавити твоїх сусідів." }
    t[269234] = { name = "Переповнена схованка ритуального місця", fen = "Contains a variety of rewards for those who have proven themselves adept at facing Ritual Sites.", fua = "Містить різноманітні нагороди для тих, хто довів свою вправність у протистоянні ритуальним місцям." }
    t[269240] = { name = "Світлистий спорокрил", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[269245] = { name = "Смачний спорогризок", fen = "Not for humanoid consumption.", fua = "Не для споживання гуманоїдами." }
    t[269258] = { name = "Спотворений Порожнечею спорокус", fen = "Crush the sporbit to convert the last of its lifeforce into a Nebulous Voidcore.", fua = "Розчави спорокуса, щоб перетворити рештки його життєвої сили на туманне ядро Порожнечі." }
    t[269586] = "Аварійний Зв'язок Душ"
    t[269603] = { name = "Зелений слиз скрадача", fen = "Positively teeming with life of all sorts.", fua = "Буквально кишить усілякими формами життя." }
    t[269606] = "Позичена Чарівна Паличка"
    t[269612] = { name = "Терпка крабова печінка", fen = "The smorgasbord of organs inside a crab's body cavity. Known as a delicacy in some circles, while appreciated from afar--very afar--by others.", fua = "Розмаїття органів із нутрощів краба. У певних колах вважається делікатесом, а інші цінують його здалеку — дуже здалеку." }
    t[269666] = { name = "Перо Джан'алая", fen = "A small piece of the loa herself. Even a single feather emanates a slight warmth in your hand.", fua = "Маленька частинка самої лоа. Навіть одне перо випромінює легке тепло у твоїй руці." }
    t[269668] = { name = "Зголоднілий забуттій", fen = "An oddity of the Voidstorm. It emanates an eerie malice. Decimus requires it to be empowered with violence in order to forge the Nilhammer.", fua = "Дивовижа Бурі Порожнечі. Він випромінює моторошну злобу. Децимусу потрібно наситити його насильством, щоб викувати Молот Небуття." }
    t[269701] = { name = "Лишкова торба святкових гостинців", fen = "Weekly cache containing leveling equipment, gold, and more.", fua = "Щотижнева скриня зі спорядженням для росту рівня, золотом і не тільки." }
    t[269702] = { name = "Переповнена торба рясності", fen = "Weekly cache containing leveling equipment, gold, and more.", fua = "Щотижнева скриня зі спорядженням для росту рівня, золотом і не тільки." }
    t[269703] = { name = "Набір припасів завзятого учня", fen = "Weekly cache containing leveling equipment, gold, and more.", fua = "Щотижнева скриня зі спорядженням для росту рівня, золотом і не тільки." }
    t[269704] = { name = "Переможна скриня Штормаріона", fen = "Weekly cache containing leveling equipment, gold, and more.", fua = "Щотижнева скриня зі спорядженням для росту рівня, золотом і не тільки." }
    t[269720] = { name = "Роз'їдлива Гекта", fen = "A crystalized token of Ula'tek's malefic venom. May be traded for wares and boons.", fua = "Кристалізований жетон лиховісної отрути Ула'тек. Можна обміняти на товари та дари." }
    t[269766] = { name = "Зібраний Плющ", fen = "Recently harvested, this vibrant green ivy will make for excellent cover.", fua = "Щойно зібраний, цей соковито-зелений плющ чудово все вкриє." }
    t[269768] = { name = "Туманний сховок Порожнечі: Здобич", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[269817] = { name = "Звіт про випробування ритуального місця: щупальця", fen = "You've discovered information regarding a potential challenge you might face in a Ritual Site. Lady Darkglen should be told about this.", fua = "Ти здобув відомості про можливе випробування, з яким можеш зіткнутися на ритуальному місці. Про це слід розповісти леді Даркґлену." }
    t[269828] = { name = "Орлиний кіготь, спотворений Порожнечею", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[269829] = { name = "Орлятко, помічене Порожнечею", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[269836] = { name = "Пухтик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[269856] = "Стос Туманних Гербів Шукача Пригод"
    t[269857] = "Торбина Туманних Гербів Чемпіона"
    t[269858] = "Набір Туманних Гербів Героя"
    t[269859] = "Торбинка Ветеранських Туманних Гербів"
    t[269861] = { name = "Подертий Сувій Амані", fen = "This scroll sustained severe exposure to the elements. The fading ink is making the Amani words written on it hard to read.", fua = "Цей сувій добряче постраждав від негоди. Чорнило вицвіло, і написані на ньому слова амані важко розібрати." }
    t[269862] = { name = "Таласський знак заслуги", fen = "Can be exchanged for valuables offered by Vaultkeeper Elysa in Silvermoon.", fua = "Можна обміняти на цінні речі у хранительки сховища Елайси в Сільвермуні." }
    t[269864] = "Тріумфальна Торбина Туманних Гербів Чемпіона"
    t[269865] = "Святковий Набір Геройських Туманних Гербів"
    t[269866] = "Славне Гроно Міфічних Туманних Гербів"
    t[269867] = "Шанована Торбина Ветеранських Туманних Гербів"
    t[269868] = { name = "Мініатюрна Маска Ручної Роботи", fen = "An old miniature hand-crafted mask. It was crafted by a very talented and skilled craftsman. Its use is unknown.", fua = "Стара мініатюрна маска ручної роботи. Її створив дуже талановитий і вправний майстер. Призначення невідоме." }
    t[269918] = { name = "Роз'їдений Отрутою Жовчний Камінь", fen = "A venom-corroded digestive system produces venom-corroded gallstones.", fua = "Роз'їдена отрутою травна система породжує роз'їдені отрутою жовчні камені." }
    t[269934] = { name = "Манаспора", fen = "Grows atop the highest, grandest mushrooms.", fua = "Росте на верхівках найвищих, найвеличніших грибів." }
    t[269935] = { name = "Забута Дрібничка", fen = "A small statuette made of jade. There is nothing outstanding about it.", fua = "Маленька нефритова статуетка. Нічого видатного в ній немає." }
    t[269937] = { name = "Сусідська Дрібничка", fen = "A random assortment of from your neighbors. Try trading 3 of them to Griftah. He doesn't need to know they aren't worth much.", fua = "Випадковий набір усякої всячини від ваших сусідів. Спробуйте обміняти 3 штуки в Ґріфтаха. Йому не конче знати, що вони небагато варті." }
    t[269980] = "Бойова глефа Бивнеріза"
    t[269981] = "Лезо фарбороба"
    t[269982] = "Глейв, торкнутий спорами"
    t[269991] = { name = "Свіже Серце Звіра", fen = "Lined with well-worn striations. This would make a fine offering to the Loa of the Hunt.", fua = "Помережане глибокими борознами. З нього вийшла б гідна пожертва для Лоа Полювання." }
    t[269994] = { name = "Жетон Вдячності Ґріфтаха", fen = "Griftah may generously give one of these as a reward for completing an endeavor task, depending on its difficulty. Trade it with Griftah in your Neighborhood for exciting (or not) prizes.", fua = "Ґріфтах може щедро дати один такий у нагороду за виконане завдання ініціативи — залежно від його складності. Обміняйте його в Ґріфтаха у вашому Сусідстві на захопливі (чи не дуже) призи." }
    t[269999] = { name = "Перевантажений манавирмик", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[270058] = { name = "Мотузяна збруя рисі", fen = "Teaches you how to summon the Void-Corrupted Lynx. This mount changes depending on your Riding skill and location.", fua = "Навчає тебе призивати спотворену Порожнечею рись. Ця їздова тварина змінюється залежно від твоєї навички їзди та місцеперебування." }
    t[270061] = { name = "Кусач-дракон, скупаний у Порожнечі", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[270062] = { name = "Пташеня, торкнуте Порожнечею", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[270063] = { name = "Торкнуте Порожнечею рисеня", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[270160] = "Панцирний Оберіг Старпома"
    t[270161] = "Ікло Тіньової Злоби"
    t[270162] = "Ритуальна Посудина Душезвіїв"
    t[270163] = { name = "Лютість Ссзорака", fen = "Fight. Scream. Die.", fua = "Бийся. Кричи. Помри." }
    t[270164] = { name = "Бездонна Торба Ґеббо", fen = "Disgusting fish! How does this keep happening? I should have total control!", fua = "Огидна риба! Як це знову й знову стається? Я ж мав би все тримати під контролем!" }
    t[270165] = { name = "Вируюче Ядро Хранителя", fen = "Curse of her venom find you.", fua = "Хай знайде тебе прокляття її отрути." }
    t[270166] = { name = "Кривава Злоба Вашніка", fen = "Crimson. Viscous. Delicious.", fua = "Багряна. В'язка. Смачна." }
    t[270167] = "Морський Камінь Закликача Хвиль"
    t[270168] = "Джерело Отруйної Люті"
    t[270169] = "Згубний Ідол Володаря Вроків"
    t[270170] = "Невичерпна Залоза Вексгула"
    t[270171] = "Надприродна Протиотрута"
    t[270173] = { name = "Техніка Гільйотини Зул'джина", fen = "D'you want axe?", fua = "Хочеш сокиру?" }
    t[270174] = "Ідол Виючого Нексуса"
    t[270175] = "Ненажерливе Серце Ула'тек"
    t[270244] = { name = "Польовий мішечок", fen = "Contains Field Accolades, Gold, Voidlight Marl and more acknowledging your acumen in the field.", fua = "Містить польові відзнаки, золото, пил світла Порожнечі й більше — на знак визнання твоєї кмітливості на полі бою." }
    t[270247] = { name = "Польова торба", fen = "Filled with Field Accolades, Gold, Voidlight Marl, and more acknowledging your acumen in the field.", fua = "Наповнена польовими відзнаками, золотом, пилом світла Порожнечі й більшим — на знак визнання твоєї кмітливості на полі бою." }
    t[270266] = { name = "Розколота Порожнеча", fen = "Carries an impression of abandonment.", fua = "Несе на собі відбиток покинутості." }
    t[270267] = { name = "Сутінкове Послання", fen = "Written by ogre hand. Contains complaints about new leadership being deficient.", fua = "Написано рукою оґра. Містить скарги на те, що нове керівництво нікуди не годиться." }
    t[270272] = "Лордерон Навіки"
    t[270273] = "Лозове ласо"
    t[270274] = { name = "Доморощений Віск", fen = "A curious wax that has recently begun to appear in residential areas. \n\nThe visiting kobolds may have uses for this in your neighborhood.", fua = "Дивний віск, що віднедавна з'являється в житлових районах.\n\nКобольдам, що навідуються до твого сусідства, він може знадобитися." }
    t[270277] = { name = "Рунний Ключ Музока", fen = "Pulsing with power, this rune-key fills your heart with dread.", fua = "Пульсуючи силою, цей рунний ключ сповнює ваше серце жахом." }
    t[270282] = { name = "Рунний Ключ Казока", fen = "Pulsing with power, this rune-key fills your heart with dread.", fua = "Пульсуючи силою, цей рунний ключ сповнює ваше серце жахом." }
    t[270330] = { name = "Яйце драконояструба, торкнуте Порожнечею", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[270331] = { name = "Малок розумоламача, насичений Порожнечею", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[270335] = { name = "Майже Гладкий Морський Камінь", fen = "Fairly smooth, but not smooth enough.", fua = "Доволі гладкий, але не досить." }
    t[270342] = { name = "Зчеплені Сутінкові Руни", fen = "The rune-keys you've gathered interlock into an eldritch mechanism that groans with ominous energy.", fua = "Зібрані вами рунні ключі зчіплюються в моторошний механізм, що стогне від зловісної енергії." }
    t[270346] = { name = "Велика М'ясиста Клешня", fen = "Certain to cheer up even the surliest of trolls!", fua = "Неодмінно підбадьорить навіть найпохмурішого троля!" }
    t[270347] = "Плащ Отруйного Палія Війни"
    t[270348] = "Накидка Отруйного Палія Війни"
    t[270349] = "Плащ Отруйного Палія Війни"
    t[270350] = "Шаль Отруйного Палія Війни"
    t[270351] = "Вбрання Отруйного Палія Війни"
    t[270352] = "Капці Отруйного Палія Війни"
    t[270353] = "Рукавички Отруйного Палія Війни"
    t[270354] = "Маска Отруйного Палія Війни"
    t[270355] = "Штани Отруйного Палія Війни"
    t[270356] = "Оплічник Отруйного Палія Війни"
    t[270357] = "Пояс Отруйного Палія Війни"
    t[270358] = "Наручі Отруйного Палія Війни"
    t[270359] = "Куртка Отруйного Палія Війни"
    t[270360] = "Чоботи Отруйного Палія Війни"
    t[270361] = "Обмотки для Рук Отруйного Палія Війни"
    t[270362] = "Каптур Отруйного Палія Війни"
    t[270363] = "Штани Отруйного Палія Війни"
    t[270364] = "Наплічники Отруйного Палія Війни"
    t[270365] = "Пояс Отруйного Палія Війни"
    t[270366] = "Обмотки Отруйного Палія Війни"
    t[270367] = "Нагрудник Отруйного Палія Війни"
    t[270368] = "Поножі Отруйного Палія Війни"
    t[270369] = "Рукавиці Отруйного Палія Війни"
    t[270370] = "Шолом Отруйного Палія Війни"
    t[270371] = "Поножі Отруйного Палія Війни"
    t[270372] = "Наплічники Отруйного Палія Війни"
    t[270373] = "Пояс Отруйного Палія Війни"
    t[270374] = "Наручі Отруйного Палія Війни"
    t[270375] = "Кіраса Отруйного Палія Війни"
    t[270376] = "Чоботи Отруйного Палія Війни"
    t[270377] = "Латні Рукавиці Отруйного Палія Війни"
    t[270378] = "Заборало Отруйного Палія Війни"
    t[270379] = "Поножі Отруйного Палія Війни"
    t[270380] = "Наплічники Отруйного Палія Війни"
    t[270381] = "Застібка Отруйного Палія Війни"
    t[270382] = "Наручі Отруйного Палія Війни"
    t[270383] = "Розколювач Отруйного Палія Війни"
    t[270384] = "Різак Отруйного Палія Війни"
    t[270385] = "Тесак Отруйного Палія Війни"
    t[270386] = "Заточка Отруйного Палія Війни"
    t[270387] = "Кинджал Отруйного Палія Війни"
    t[270388] = "Булава Отруйного Палія Війни"
    t[270390] = "Кий Отруйного Палія Війни"
    t[270392] = "Трощитель Отруйного Палія Війни"
    t[270394] = "Чарівна Паличка Отруйного Палія Війни"
    t[270395] = "Бойова Глефа Отруйного Палія Війни"
    t[270396] = "Лук Отруйного Палія Війни"
    t[270397] = "Спис Отруйного Палія Війни"
    t[270398] = "Древкова Зброя Отруйного Палія Війни"
    t[270399] = "Бойовий Посох Отруйного Палія Війни"
    t[270400] = "Посох Отруйного Палія Війни"
    t[270401] = "Великий Клинок Отруйного Палія Війни"
    t[270402] = "Клеймор Отруйного Палія Війни"
    t[270403] = "Ріг Отруйного Палія Війни"
    t[270404] = "Щит Отруйного Палія Війни"
    t[270405] = "Лють Отруйного Палія Війни"
    t[270406] = "Стинач Голів Отруйного Палія Війни"
    t[270407] = "Чароклинок Отруйного Палія Війни"
    t[270408] = "Меч Отруйного Палія Війни"
    t[270431] = { name = "Скриня гаранірів", fen = "Contains gear for other class specializations.", fua = "Містить спорядження для інших спеціалізацій класу." }
    t[270445] = "Щит Отруйного Претендента"
    t[270446] = "Сигіл Отруйного Претендента"
    t[270447] = "Клеймор Отруйного Претендента"
    t[270448] = "Бойовий Клинок Отруйного Претендента"
    t[270449] = "Великий Клинок Отруйного Претендента"
    t[270450] = "Посох Отруйного Претендента"
    t[270451] = "Древкова Зброя Отруйного Претендента"
    t[270452] = "Спис Отруйного Претендента"
    t[270453] = "Лук Отруйного Претендента"
    t[270454] = "Бойова Глефа Отруйного Претендента"
    t[270455] = "Чарівна Паличка Отруйного Претендента"
    t[270456] = "Чароклинок Отруйного Претендента"
    t[270457] = "Меч Отруйного Претендента"
    t[270458] = "Клинок Отруйного Претендента"
    t[270459] = "Трощитель Отруйного Претендента"
    t[270460] = "Кий Отруйного Претендента"
    t[270461] = "Булава Отруйного Претендента"
    t[270464] = "Кинджал Отруйного Претендента"
    t[270465] = "Заточка Отруйного Претендента"
    t[270466] = "Тесак Отруйного Претендента"
    t[270467] = "Розколювач Отруйного Претендента"
    t[270468] = "Латні Наручі Отруйного Претендента"
    t[270469] = "Латні Манжети Отруйного Претендента"
    t[270470] = "Латний Широкий Пояс Отруйного Претендента"
    t[270471] = "Латний Пояс Отруйного Претендента"
    t[270472] = "Латні Наплічники Отруйного Претендента"
    t[270473] = "Латні Наплічники Отруйного Претендента"
    t[270474] = "Латні Бойові Поножі Отруйного Претендента"
    t[270475] = "Латні Поножі Отруйного Претендента"
    t[270476] = "Латний Шолом Отруйного Претендента"
    t[270477] = "Латний Шолом Отруйного Претендента"
    t[270478] = "Латні Рукавиці Отруйного Претендента"
    t[270479] = "Латні Рукавиці Отруйного Претендента"
    t[270480] = "Латні Чоботи Отруйного Претендента"
    t[270481] = "Латні Бойові Чоботи Отруйного Претендента"
    t[270482] = "Латний Обладунок Отруйного Претендента"
    t[270483] = "Латний Нагрудник Отруйного Претендента"
    t[270484] = "Кольчужні Наручі Отруйного Претендента"
    t[270485] = "Кольчужні Наручі Отруйного Претендента"
    t[270486] = "Кольчужна Застібка Отруйного Претендента"
    t[270487] = "Кольчужний Пояс Отруйного Претендента"
    t[270488] = "Кольчужні Наплічники Отруйного Претендента"
    t[270489] = "Кольчужні Наплічники Отруйного Претендента"
    t[270490] = "Кольчужні Бойові Поножі Отруйного Претендента"
    t[270491] = "Кольчужні Поножі Отруйного Претендента"
    t[270492] = "Кольчужний Шолом Отруйного Претендента"
    t[270493] = "Кольчужний Шолом Отруйного Претендента"
    t[270494] = "Кольчужні Рукавиці Отруйного Претендента"
    t[270495] = "Кольчужні Латні Рукавиці Отруйного Претендента"
    t[270496] = "Кольчужні Чоботи Отруйного Претендента"
    t[270497] = "Кольчужні Чоботи Отруйного Претендента"
    t[270498] = "Кольчужна Туніка Отруйного Претендента"
    t[270499] = "Кольчужний Нагрудник Отруйного Претендента"
    t[270500] = "Шкіряні Наручі Отруйного Претендента"
    t[270501] = "Шкіряні Наручі Отруйного Претендента"
    t[270502] = "Шкіряний Шнур Отруйного Претендента"
    t[270503] = "Шкіряний Пояс Отруйного Претендента"
    t[270504] = "Шкіряний Оплічник Отруйного Претендента"
    t[270505] = "Шкіряні Наплічники Отруйного Претендента"
    t[270506] = "Шкіряні Поножі Отруйного Претендента"
    t[270507] = "Шкіряні Штани Отруйного Претендента"
    t[270508] = "Шкіряна Маска Отруйного Претендента"
    t[270509] = "Шкіряний Шолом Отруйного Претендента"
    t[270510] = "Шкіряні Рукавиці Отруйного Претендента"
    t[270511] = "Шкіряні Рукавички Отруйного Претендента"
    t[270512] = "Шкіряні Чоботи Отруйного Претендента"
    t[270513] = "Шкіряні Чоботи Отруйного Претендента"
    t[270514] = "Шкіряна Туніка Отруйного Претендента"
    t[270515] = "Шкіряний Жилет Отруйного Претендента"
    t[270516] = "Шовкові Пов'язки Отруйного Претендента"
    t[270517] = "Шовкові Наручі Отруйного Претендента"
    t[270518] = "Шовковий Пояс Отруйного Претендента"
    t[270519] = "Шовковий Шнур Отруйного Претендента"
    t[270520] = "Шовкова Шаль Отруйного Претендента"
    t[270521] = "Шовковий Оплічник Отруйного Претендента"
    t[270522] = "Шовкові Штани Отруйного Претендента"
    t[270523] = "Шовкові Поножі Отруйного Претендента"
    t[270524] = "Шовковий Головний Убір Отруйного Претендента"
    t[270525] = "Шовковий Каптур Отруйного Претендента"
    t[270526] = "Шовкові Рукавиці Отруйного Претендента"
    t[270527] = "Шовкові Рукавички Отруйного Претендента"
    t[270528] = "Шовкові Онучі Отруйного Претендента"
    t[270529] = "Шовкові Чоботи Отруйного Претендента"
    t[270530] = "Шовкова Сорочка Отруйного Претендента"
    t[270531] = "Шовкова Роба Отруйного Претендента"
    t[270532] = "Підвіска Отруйного Претендента"
    t[270533] = "Намисто Отруйного Претендента"
    t[270534] = "Намисто Отруйного Претендента"
    t[270535] = "Перстень-Печатка Отруйного Претендента"
    t[270536] = "Перстень Отруйного Претендента"
    t[270537] = "Перстень Отруйного Претендента"
    t[270538] = "Великий Плащ Отруйного Претендента"
    t[270539] = "Плащ Отруйного Претендента"
    t[270540] = "Плащ Отруйного Претендента"
    t[270541] = "Накидка Отруйного Претендента"
    t[270542] = "Клинок Отруйного Палія Війни"
    t[270549] = "Бойова Сокира Отруйного Палія Війни"
    t[270550] = "Колун Отруйного Палія Війни"
    t[270551] = "Жнець Отруйного Палія Війни"
    t[270552] = "Бойова Сокира Отруйного Претендента"
    t[270553] = "Колун Отруйного Претендента"
    t[270554] = "Жнець Отруйного Претендента"
    t[270555] = "Емблема Отруйного Претендента"
    t[270556] = "Медальйон Отруйного Претендента"
    t[270557] = "Сигіл Пристосування Отруйного Претендента"
    t[270558] = "Відзнака Завзяття Отруйного Претендента"
    t[270559] = "Знак Лютості Отруйного Претендента"
    t[270560] = { name = "Жетон Зброї Отруйного Гладіатора", fen = "Proof of your prowess on the battlefield. Can be exchanged for gladiator weapons at Falconwing Square in Silvermoon.", fua = "Доказ твоєї звитяги на полі бою. Можна обміняти на зброю гладіатора на площі Соколиного Крила в Сільвермуні." }
    t[270562] = { name = "Зіпсований зразок", fen = "A strangely tainted bone sample. Lady Darkglen might be interested in this.", fua = "Дивно зіпсований зразок кістки. Леді Даркґлен могла б ним зацікавитися." }
    t[270563] = "Плащ Отруйного Гладіатора"
    t[270564] = "Накидка Отруйного Гладіатора"
    t[270565] = "Шаль Отруйного Гладіатора"
    t[270566] = "Плащ Отруйного Гладіатора"
    t[270567] = "Накидка Отруйного Гладіатора"
    t[270568] = "Шаль Отруйного Гладіатора"
    t[270569] = "Плащ Отруйного Гладіатора"
    t[270570] = "Накидка Отруйного Гладіатора"
    t[270571] = "Шаль Отруйного Гладіатора"
    t[270572] = "Плащ Отруйного Гладіатора"
    t[270573] = "Накидка Отруйного Гладіатора"
    t[270574] = "Шаль Отруйного Гладіатора"
    t[270575] = "Перстень Отруйного Гладіатора"
    t[270576] = "Перстень Отруйного Гладіатора"
    t[270577] = "Перстень-Печатка Отруйного Гладіатора"
    t[270578] = "Плащ Отруйного Гладіатора"
    t[270579] = "Накидка Отруйного Гладіатора"
    t[270580] = "Шаль Отруйного Гладіатора"
    t[270581] = "Плащ Отруйного Гладіатора"
    t[270582] = "Накидка Отруйного Гладіатора"
    t[270583] = "Шаль Отруйного Гладіатора"
    t[270584] = "Плащ Отруйного Гладіатора"
    t[270585] = "Накидка Отруйного Гладіатора"
    t[270586] = "Шаль Отруйного Гладіатора"
    t[270587] = "Намисто Отруйного Гладіатора"
    t[270588] = "Підвіска Отруйного Гладіатора"
    t[270589] = "Амулет Отруйного Гладіатора"
    t[270590] = "Плащ Отруйного Гладіатора"
    t[270591] = "Накидка Отруйного Гладіатора"
    t[270592] = "Шаль Отруйного Гладіатора"
    t[270593] = "Плащ Отруйного Гладіатора"
    t[270594] = "Накидка Отруйного Гладіатора"
    t[270595] = "Шаль Отруйного Гладіатора"
    t[270596] = "Плащ Отруйного Гладіатора"
    t[270597] = "Накидка Отруйного Гладіатора"
    t[270598] = "Шаль Отруйного Гладіатора"
    t[270599] = "Плащ Отруйного Гладіатора"
    t[270600] = "Накидка Отруйного Гладіатора"
    t[270601] = "Шаль Отруйного Гладіатора"
    t[270602] = "Знак Лютості Отруйного Гладіатора"
    t[270603] = "Відзнака Завзяття Отруйного Гладіатора"
    t[270604] = "Сигіл Пристосування Отруйного Гладіатора"
    t[270605] = "Медальйон Отруйного Гладіатора"
    t[270606] = "Емблема Отруйного Гладіатора"
    t[270607] = "Плащ Отруйного Гладіатора"
    t[270608] = "Накидка Отруйного Гладіатора"
    t[270609] = "Шаль Отруйного Гладіатора"
    t[270610] = "Плащ Отруйного Гладіатора"
    t[270611] = "Накидка Отруйного Гладіатора"
    t[270612] = "Шаль Отруйного Гладіатора"
    t[270613] = "Шовкова Роба Отруйного Гладіатора"
    t[270614] = "Шовкова Сукня Отруйного Гладіатора"
    t[270615] = "Шовкові Капці Отруйного Гладіатора"
    t[270616] = "Шовкові Чоботи Отруйного Гладіатора"
    t[270617] = "Шовкові Рукавички Отруйного Гладіатора"
    t[270618] = "Шовкові Рукавиці Отруйного Гладіатора"
    t[270619] = "Шовковий Капелюх Отруйного Гладіатора"
    t[270620] = "Шовкова Шапка Отруйного Гладіатора"
    t[270621] = "Шовкові Поножі Отруйного Гладіатора"
    t[270622] = "Шовкові Штани Отруйного Гладіатора"
    t[270623] = "Шовковий Оплічник Отруйного Гладіатора"
    t[270624] = "Шовковий Оплічник Отруйного Гладіатора"
    t[270625] = "Шовковий Пояс Отруйного Гладіатора"
    t[270626] = "Шовковий Пояс Отруйного Гладіатора"
    t[270627] = "Шовкові Наручі Отруйного Гладіатора"
    t[270628] = "Шовкові Наручі Отруйного Гладіатора"
    t[270629] = "Шовкова Роба Отруйного Гладіатора"
    t[270630] = "Шовкові Шати Отруйного Гладіатора"
    t[270631] = "Шовкові Капці Отруйного Гладіатора"
    t[270632] = "Шовкові Чоботи Отруйного Гладіатора"
    t[270633] = "Шовкові Рукавички Отруйного Гладіатора"
    t[270634] = "Шовкові Рукавиці Отруйного Гладіатора"
    t[270635] = "Шовковий Каптур Отруйного Гладіатора"
    t[270636] = "Шовковий Каптур Отруйного Гладіатора"
    t[270637] = "Шовкові Поножі Отруйного Гладіатора"
    t[270638] = "Шовкові Штани Отруйного Гладіатора"
    t[270639] = "Шовковий Оплічник Отруйного Гладіатора"
    t[270640] = "Шовковий Оплічник Отруйного Гладіатора"
    t[270641] = "Шовковий Пояс Отруйного Гладіатора"
    t[270642] = "Шовковий Пояс Отруйного Гладіатора"
    t[270643] = "Шовкові Наручі Отруйного Гладіатора"
    t[270644] = "Шовкові Наручі Отруйного Гладіатора"
    t[270645] = "Шовкове Вбрання Отруйного Гладіатора"
    t[270646] = "Шовкові Шати Отруйного Гладіатора"
    t[270647] = "Шовкові Капці Отруйного Гладіатора"
    t[270648] = "Шовкові Чоботи Отруйного Гладіатора"
    t[270649] = "Шовкові Рукавички Отруйного Гладіатора"
    t[270650] = "Шовкові Рукавиці Отруйного Гладіатора"
    t[270651] = "Шовковий Каптур Отруйного Гладіатора"
    t[270652] = "Шовковий Каптур Отруйного Гладіатора"
    t[270653] = "Шовкові Поножі Отруйного Гладіатора"
    t[270654] = "Шовкові Штани Отруйного Гладіатора"
    t[270655] = "Шовковий Оплічник Отруйного Гладіатора"
    t[270656] = "Шовковий Оплічник Отруйного Гладіатора"
    t[270657] = "Шовковий Пояс Отруйного Гладіатора"
    t[270658] = "Шовковий Пояс Отруйного Гладіатора"
    t[270659] = "Шовкові Наручі Отруйного Гладіатора"
    t[270660] = "Шовкові Наручі Отруйного Гладіатора"
    t[270661] = "Шкіряний Нагрудник Отруйного Гладіатора"
    t[270662] = "Шкіряний Камзол Отруйного Гладіатора"
    t[270663] = "Шкіряні Чоботи Отруйного Гладіатора"
    t[270664] = "Шкіряні Чоботи Отруйного Гладіатора"
    t[270665] = "Шкіряні Рукавички Отруйного Гладіатора"
    t[270666] = "Шкіряні Рукавиці Отруйного Гладіатора"
    t[270667] = "Шкіряний Шолом Отруйного Гладіатора"
    t[270668] = "Шкіряна Маска Отруйного Гладіатора"
    t[270669] = "Шкіряні Штани Отруйного Гладіатора"
    t[270670] = "Шкіряні Поножі Отруйного Гладіатора"
    t[270671] = "Шкіряні Наплічники Отруйного Гладіатора"
    t[270672] = "Шкіряні Наплічники Отруйного Гладіатора"
    t[270673] = "Шкіряний Пояс Отруйного Гладіатора"
    t[270674] = "Шкіряний Ремінь Отруйного Гладіатора"
    t[270675] = "Шкіряні Наручі Отруйного Гладіатора"
    t[270676] = "Шкіряні Наручі Отруйного Гладіатора"
    t[270677] = "Шкіряний Нагрудник Отруйного Гладіатора"
    t[270678] = "Шкіряні Шати Отруйного Гладіатора"
    t[270679] = "Шкіряні Чоботи Отруйного Гладіатора"
    t[270680] = "Шкіряні Чоботи Отруйного Гладіатора"
    t[270681] = "Шкіряні Рукавички Отруйного Гладіатора"
    t[270682] = "Шкіряні Рукавиці Отруйного Гладіатора"
    t[270683] = "Шкіряний Шолом Отруйного Гладіатора"
    t[270684] = "Шкіряна Маска Отруйного Гладіатора"
    t[270685] = "Шкіряні Штани Отруйного Гладіатора"
    t[270686] = "Шкіряні Поножі Отруйного Гладіатора"
    t[270687] = "Шкіряні Наплічники Отруйного Гладіатора"
    t[270688] = "Шкіряні Наплічники Отруйного Гладіатора"
    t[270689] = "Шкіряний Пояс Отруйного Гладіатора"
    t[270690] = "Шкіряний Ремінь Отруйного Гладіатора"
    t[270691] = "Шкіряні Наручі Отруйного Гладіатора"
    t[270692] = "Шкіряні Наручі Отруйного Гладіатора"
    t[270693] = "Шкіряний Нагрудник Отруйного Гладіатора"
    t[270694] = "Шкіряний Камзол Отруйного Гладіатора"
    t[270695] = "Шкіряні Чоботи Отруйного Гладіатора"
    t[270696] = "Шкіряні Чоботи Отруйного Гладіатора"
    t[270697] = "Шкіряні Рукавички Отруйного Гладіатора"
    t[270698] = "Шкіряні Рукавиці Отруйного Гладіатора"
    t[270699] = "Шкіряний Шолом Отруйного Гладіатора"
    t[270700] = "Шкіряна Маска Отруйного Гладіатора"
    t[270701] = "Шкіряні Штани Отруйного Гладіатора"
    t[270702] = "Шкіряні Поножі Отруйного Гладіатора"
    t[270703] = "Шкіряні Наплічники Отруйного Гладіатора"
    t[270704] = "Шкіряні Наплічники Отруйного Гладіатора"
    t[270705] = "Шкіряний Пояс Отруйного Гладіатора"
    t[270706] = "Шкіряний Ремінь Отруйного Гладіатора"
    t[270707] = "Шкіряні Наручі Отруйного Гладіатора"
    t[270708] = "Шкіряні Наручі Отруйного Гладіатора"
    t[270709] = "Шкіряний Нагрудник Отруйного Гладіатора"
    t[270710] = "Шкіряний Камзол Отруйного Гладіатора"
    t[270711] = "Шкіряні Чоботи Отруйного Гладіатора"
    t[270712] = "Шкіряні Чоботи Отруйного Гладіатора"
    t[270713] = "Шкіряні Рукавички Отруйного Гладіатора"
    t[270714] = "Шкіряні Рукавиці Отруйного Гладіатора"
    t[270715] = "Шкіряний Шолом Отруйного Гладіатора"
    t[270716] = "Шкіряна Маска Отруйного Гладіатора"
    t[270717] = "Шкіряні Штани Отруйного Гладіатора"
    t[270718] = "Шкіряні Поножі Отруйного Гладіатора"
    t[270719] = "Шкіряні Наплічники Отруйного Гладіатора"
    t[270720] = "Шкіряні Наплічники Отруйного Гладіатора"
    t[270721] = "Шкіряний Пояс Отруйного Гладіатора"
    t[270722] = "Шкіряний Ремінь Отруйного Гладіатора"
    t[270723] = "Шкіряні Наручі Отруйного Гладіатора"
    t[270724] = "Шкіряні Наручі Отруйного Гладіатора"
    t[270725] = "Броньована Луска Отруйного Гладіатора"
    t[270726] = "Лускатий Захист Отруйного Гладіатора"
    t[270727] = "Кольчужні Чоботи Отруйного Гладіатора"
    t[270728] = "Кольчужні Чоботи Отруйного Гладіатора"
    t[270729] = "Кольчужні Латні Рукавиці Отруйного Гладіатора"
    t[270730] = "Кольчужні Рукавиці Отруйного Гладіатора"
    t[270731] = "Кольчужний Шолом Отруйного Гладіатора"
    t[270732] = "Кольчужне Забрало Отруйного Гладіатора"
    t[270733] = "Кольчужні Поножі Отруйного Гладіатора"
    t[270734] = "Кольчужні Штани Отруйного Гладіатора"
    t[270735] = "Кольчужні Оплічники Отруйного Гладіатора"
    t[270736] = "Кольчужні Наплічники Отруйного Гладіатора"
    t[270737] = "Кольчужний Пояс Отруйного Гладіатора"
    t[270738] = "Кольчужний Пояс Отруйного Гладіатора"
    t[270739] = "Кольчужні Наручі Отруйного Гладіатора"
    t[270740] = "Кольчужні Наручі Отруйного Гладіатора"
    t[270741] = "Кольчужний Нагрудник Отруйного Гладіатора"
    t[270742] = "Кольчужна Туніка Отруйного Гладіатора"
    t[270743] = "Кольчужні Чоботи Отруйного Гладіатора"
    t[270744] = "Кольчужні Чоботи Отруйного Гладіатора"
    t[270745] = "Кольчужні Латні Рукавиці Отруйного Гладіатора"
    t[270746] = "Кольчужні Рукавиці Отруйного Гладіатора"
    t[270747] = "Кольчужний Шолом Отруйного Гладіатора"
    t[270748] = "Кольчужне Забрало Отруйного Гладіатора"
    t[270749] = "Кольчужні Поножі Отруйного Гладіатора"
    t[270750] = "Кольчужні Штани Отруйного Гладіатора"
    t[270751] = "Кольчужні Оплічники Отруйного Гладіатора"
    t[270752] = "Кольчужні Наплічники Отруйного Гладіатора"
    t[270753] = "Кольчужний Пояс Отруйного Гладіатора"
    t[270754] = "Кольчужний Пояс Отруйного Гладіатора"
    t[270755] = "Кольчужні Наручі Отруйного Гладіатора"
    t[270756] = "Кольчужні Наручі Отруйного Гладіатора"
    t[270757] = "Кольчужний Нагрудник Отруйного Гладіатора"
    t[270758] = "Кольчужна Туніка Отруйного Гладіатора"
    t[270759] = "Кольчужні Чоботи Отруйного Гладіатора"
    t[270760] = "Кольчужні Чоботи Отруйного Гладіатора"
    t[270761] = "Кольчужні Латні Рукавиці Отруйного Гладіатора"
    t[270762] = "Кольчужні Рукавиці Отруйного Гладіатора"
    t[270763] = "Кольчужний Шолом Отруйного Гладіатора"
    t[270764] = "Кольчужне Забрало Отруйного Гладіатора"
    t[270765] = "Кольчужні Поножі Отруйного Гладіатора"
    t[270766] = "Кольчужні Штани Отруйного Гладіатора"
    t[270767] = "Кольчужні Оплічники Отруйного Гладіатора"
    t[270768] = "Кольчужні Наплічники Отруйного Гладіатора"
    t[270769] = "Кольчужний Пояс Отруйного Гладіатора"
    t[270770] = "Кольчужний Пояс Отруйного Гладіатора"
    t[270771] = "Кольчужні Наручі Отруйного Гладіатора"
    t[270772] = "Кольчужні Наручі Отруйного Гладіатора"
    t[270773] = "Нагрудник Отруйного Гладіатора"
    t[270774] = "Латний Нагрудник Отруйного Гладіатора"
    t[270775] = "Латні Бойові Чоботи Отруйного Гладіатора"
    t[270776] = "Латні Чоботи Отруйного Гладіатора"
    t[270777] = "Латні Рукавиці Отруйного Гладіатора"
    t[270778] = "Латні Рукавиці Отруйного Гладіатора"
    t[270779] = "Латний Шолом Отруйного Гладіатора"
    t[270780] = "Латний Шолом Отруйного Гладіатора"
    t[270781] = "Латні Поножі Отруйного Гладіатора"
    t[270782] = "Латні Бойові Поножі Отруйного Гладіатора"
    t[270783] = "Латні Наплічники Отруйного Гладіатора"
    t[270784] = "Латні Наплічники Отруйного Гладіатора"
    t[270785] = "Латний Пояс Отруйного Гладіатора"
    t[270786] = "Латний Широкий Пояс Отруйного Гладіатора"
    t[270787] = "Латні Наручі Отруйного Гладіатора"
    t[270788] = "Латні Наручі Отруйного Гладіатора"
    t[270789] = "Нагрудник Отруйного Гладіатора"
    t[270790] = "Латний Нагрудник Отруйного Гладіатора"
    t[270791] = "Латні Бойові Чоботи Отруйного Гладіатора"
    t[270792] = "Латні Чоботи Отруйного Гладіатора"
    t[270793] = "Латні Рукавиці Отруйного Гладіатора"
    t[270794] = "Латні Рукавиці Отруйного Гладіатора"
    t[270795] = "Латний Шолом Отруйного Гладіатора"
    t[270796] = "Латний Шолом Отруйного Гладіатора"
    t[270797] = "Латні Поножі Отруйного Гладіатора"
    t[270798] = "Латні Стегнові Щитки Отруйного Гладіатора"
    t[270799] = "Латні Наплічники Отруйного Гладіатора"
    t[270800] = "Латні Наплічники Отруйного Гладіатора"
    t[270801] = "Латний Пояс Отруйного Гладіатора"
    t[270802] = "Латний Широкий Пояс Отруйного Гладіатора"
    t[270803] = "Латні Наручі Отруйного Гладіатора"
    t[270804] = "Латні Наручі Отруйного Гладіатора"
    t[270805] = "Нагрудник Отруйного Гладіатора"
    t[270806] = "Латний Нагрудник Отруйного Гладіатора"
    t[270807] = "Латні Бойові Чоботи Отруйного Гладіатора"
    t[270808] = "Латні Чоботи Отруйного Гладіатора"
    t[270809] = "Латні Рукавиці Отруйного Гладіатора"
    t[270810] = "Латні Рукавиці Отруйного Гладіатора"
    t[270811] = "Латний Шолом Отруйного Гладіатора"
    t[270812] = "Латний Шолом Отруйного Гладіатора"
    t[270813] = "Латні Поножі Отруйного Гладіатора"
    t[270814] = "Латні Бойові Поножі Отруйного Гладіатора"
    t[270815] = "Латні Наплічники Отруйного Гладіатора"
    t[270816] = "Латні Наплічники Отруйного Гладіатора"
    t[270817] = "Латний Пояс Отруйного Гладіатора"
    t[270818] = "Латний Широкий Пояс Отруйного Гладіатора"
    t[270819] = "Латні Наручі Отруйного Гладіатора"
    t[270820] = "Латні Наручі Отруйного Гладіатора"
    t[270821] = "Заточка Отруйного Гладіатора"
    t[270822] = "Хребет Отруйного Гладіатора"
    t[270823] = "Різці Отруйного Гладіатора"
    t[270824] = "Розривачі Отруйного Гладіатора"
    t[270825] = "Трощитель Отруйного Гладіатора"
    t[270826] = "Булава Отруйного Гладіатора"
    t[270827] = "Кийок Отруйного Гладіатора"
    t[270828] = "Тесак Отруйного Гладіатора"
    t[270829] = "Розколювач Отруйного Гладіатора"
    t[270830] = "Різак Отруйного Гладіатора"
    t[270831] = "Клинок Отруйного Гладіатора"
    t[270832] = "Меч Отруйного Гладіатора"
    t[270833] = "Чароклинок Отруйного Гладіатора"
    t[270834] = "Лезо Отруйного Гладіатора"
    t[270835] = "Бойова Сокира Отруйного Гладіатора"
    t[270836] = "Колун Отруйного Гладіатора"
    t[270837] = "Жнець Отруйного Гладіатора"
    t[270838] = "Лук Отруйного Гладіатора"
    t[270839] = "Плювач Отруйного Гладіатора"
    t[270843] = "Спис Отруйного Гладіатора"
    t[270844] = "Шип Отруйного Гладіатора"
    t[270845] = "Посох Отруйного Гладіатора"
    t[270846] = "Кий Отруйного Гладіатора"
    t[270847] = "Скіпетр Отруйного Гладіатора"
    t[270848] = "Сигіл Отруйного Гладіатора"
    t[270849] = "Лускатий Щит Отруйного Гладіатора"
    t[270850] = "Шипастий Щит Отруйного Гладіатора"
    t[270851] = "Клеймор Отруйного Гладіатора"
    t[270852] = "Бойовий Клинок Отруйного Гладіатора"
    t[270853] = "Дворучний Клинок Отруйного Гладіатора"
    t[270871] = "Подих Джан'алая"
    t[270898] = { name = "Підкладка зі Зміїної Шкіри", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[270899] = { name = "Підкладка зі Зміїної Шкіри", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[270900] = { name = "Викрійка: Підкладка зі Зміїної Шкіри", fen = "Teaches you how to create Snakeskin Lining.", fua = "Навчає вас створювати Підкладку зі Зміїної Шкіри." }
    t[270909] = { name = "Дивовижа Сплячого Звою", fen = "Find Kirana near the Catalyst in Silvermoon to trade this for powerful class set armor.", fua = "Знайди Кірану біля Каталізатора в Сільвермуні, щоб обміняти це на потужну броню класового набору." }
    t[270910] = "Витканий з Отрути Ідол"
    t[270911] = "Витриманий в Отруті Ідол"
    t[270912] = "Відлитий з Отрути Ідол"
    t[270913] = "Викуваний в Отруті Ідол"
    t[270914] = "Виткана з Отрути Подоба"
    t[270915] = "Витримана в Отруті Подоба"
    t[270916] = "Відлита з Отрути Подоба"
    t[270917] = "Викувана в Отруті Подоба"
    t[270918] = "Виткана з Отрути Реліквія"
    t[270919] = "Витримана в Отруті Реліквія"
    t[270920] = "Відлита з Отрути Реліквія"
    t[270921] = "Викувана в Отруті Реліквія"
    t[270922] = "Витканий з Отрути Залишок"
    t[270923] = "Витриманий в Отруті Залишок"
    t[270924] = "Відлитий з Отрути Залишок"
    t[270925] = "Викуваний в Отруті Залишок"
    t[270926] = "Виткана з Отрути Ікона"
    t[270927] = "Витримана в Отруті Ікона"
    t[270928] = "Відлита з Отрути Ікона"
    t[270929] = "Викувана в Отруті Ікона"
    t[270930] = "Кіготь Могильного Плазуна"
    t[270932] = { name = "Звивиста польова торбинка", fen = "Contains Field Accolades, Gold, and Voidlight Marl acknowledging your acumen in the field. Something else is inside this bag...", fua = "Містить польові відзнаки, золото й пил світла Порожнечі на знак твоєї вправності в бою. Усередині торбинки є ще дещо..." }
    t[270933] = { name = "Напхана польова торба", fen = "Contains Field Accolades, Gold, and Voidlight Marl acknowledging your acumen in the field. Something big is causing the bag to bulge out oddly.", fua = "Містить польові відзнаки, золото й світло-порожнечний пил на знак визнання вашої вправності в бою. Щось велике дивно випинає торбу." }
    t[270934] = { name = "Польова торбинка рекрута", fen = "Contains Gold, Voidlight Marl, and a chance at an item for your current specialization acknowledging your acumen in the field.", fua = "Містить золото, пил Світла Порожнечі та шанс отримати предмет для вашої поточної спеціалізації на знак вашого хисту в полі." }
    t[270935] = "Сабатони новобранця-вартового"
    t[270936] = "Роба новобранця-вартового"
    t[270937] = "Нагрудник новобранця-вартового"
    t[270938] = "Кольчуга новобранця-вартового"
    t[270939] = "Куртка новобранця-вартового"
    t[270940] = "Рукавички новобранця-вартового"
    t[270941] = "Латні рукавиці новобранця-вартового"
    t[270942] = "Рукавиці новобранця-вартового"
    t[270943] = "Рукавиці новобранця-вартового"
    t[270944] = "Корона новобранця-вартового"
    t[270945] = "Каска новобранця-вартового"
    t[270946] = "Каптур новобранця-вартового"
    t[270947] = "Наголінники новобранця-вартового"
    t[270948] = "Штани новобранця-вартового"
    t[270949] = "Штани новобранця-вартового"
    t[270950] = "Рейтузи рекрута-рейнджера"
    t[270951] = "Наплічники новобранця-вартового"
    t[270952] = "Наплічники новобранця-вартового"
    t[270953] = "Накидка новобранця-вартового"
    t[270954] = "Наплічники рекрута-рейнджера"
    t[270955] = "Черес новобранця-вартового"
    t[270956] = "Пояс новобранця-вартового"
    t[270957] = "Пояс рекрута-рейнджера"
    t[270958] = "Пояс новобранця-вартового"
    t[270959] = "Манжети новобранця-вартового"
    t[270960] = "Наручі рекрута-рейнджера"
    t[270961] = "Зап'ястники рекрута-рейнджера"
    t[270962] = "Обмотки рекрута-рейнджера"
    t[270963] = "Перстень новобранця-вартового"
    t[270964] = "Каблучка новобранця-вартового"
    t[270965] = "Ланцюг новобранця-вартового"
    t[270966] = "Плащ новобранця-вартового"
    t[270967] = "Шолом новобранця-вартового"
    t[270968] = "Капці рекрута-рейнджера"
    t[270969] = "Чоботи новобранця-вартового"
    t[270970] = "Чоботи рекрута-рейнджера"
    t[270971] = "Чароклинок рекрута-рейнджера"
    t[270972] = "Булава новобранця-вартового"
    t[270973] = "Череполом рекрута-рейнджера"
    t[270974] = "Клинок новобранця-вартового"
    t[270975] = "Клинок прислужника новобранця-вартового"
    t[270976] = "Глефа новобранця-вартового"
    t[270977] = "Держакова зброя новобранця-вартового"
    t[270978] = "Щит новобранця-вартового"
    t[270979] = "Довгий лук новобранця-вартового"
    t[270980] = "Жезл рекрута-рейнджера"
    t[270981] = "Фетиш новобранця-вартового"
    t[270982] = "Стилет рекрута-рейнджера"
    t[270983] = "Бойовий ціпок новобранця-вартового"
    t[270984] = "Посох рекрута-рейнджера"
    t[270985] = "Тесак новобранця-вартового"
    t[270986] = "Медальйон новобранця-вартового"
    t[270987] = { name = "Польова сумка рекрута", fen = "Filled with Gold, Voidlight Marl, and an item for your current specialization acknowledging your acumen in the field.", fua = "Наповнена золотом, пилом Світла Порожнечі та предметом для вашої поточної спеціалізації на знак вашого хисту в полі." }
    t[271092] = { name = "Джан'тразет, Ікло Душ", fen = "Upon de bones of each Amani's sacrifice, our empire will rise.", fua = "На кістках жертви кожного з амані постане наша імперія." }
    t[271093] = { name = "Зата'тек, Подих Скверни", fen = "Bury dem. They must never know de price we paid.", fua = "Поховайте їх. Вони ніколи не мають дізнатися, яку ціну ми заплатили." }
    t[271094] = { name = "Пристрій леді Даркґлен", fen = "A device to analyze magic energy.", fua = "Пристрій для аналізу магічної енергії." }
    t[271130] = "Вливання Отрути"
    t[271132] = "Пастка для Сутності"
    t[271133] = "Ідол Гадючого Вітру"
    t[271135] = "Запорошений Тотем Лоа"
    t[271156] = "Викрадений Артефакт"
    t[271181] = "Привада на фіннова"
    t[271182] = "Наживка з плекоплавця"
    t[271183] = "М'ясо твань-ковзуна"
    t[271184] = "Герметична лупа"
    t[271185] = { name = "Емберлін", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[271221] = { name = "Звивиста польова торбинка новобранця", fen = "Contains Gold, Voidlight Marl, and a chance at an item for your current specialization acknowledging your acumen in the field. There is something else moving in the bag.", fua = "Містить золото, пил світла Порожнечі та шанс на предмет для твоєї поточної спеціалізації на знак твоєї вправності в бою. Усередині торбинки щось ворушиться." }
    t[271222] = { name = "Напхана польова торба рекрута", fen = "Contains Gold, Voidlight Marl, and a chance at an item for your current specialization acknowledging your acumen in the field. There is at least one weapon that barely fits in the bag.", fua = "Містить золото, світло-порожнечний пил і шанс отримати предмет для вашої поточної спеціалізації на знак визнання вашої вправності в бою. Усередині є щонайменше одна зброя, що ледь вміщається." }
    t[271341] = { name = "Галактична скалка Порожнечі", fen = "A thin splinter of Void energy that thrums with barely contained aggression. More may be claimed from the defeated in Arenas and Battlegrounds.", fua = "Тонка скалка енергії Порожнечі, що бринить ледь стримуваною агресією. Більше можна здобути з переможених на аренах і полях бою." }
    t[271342] = { name = "Галактична матриця Порожнечі", fen = "A tightly bound matrix of Galactic Void energy, stabilized through repeated conflict. Its power seeks worthy armaments.", fua = "Щільно зв'язана матриця галактичної енергії Порожнечі, стабілізована повторюваними сутичками. Її сила шукає гідну зброю." }
    t[271353] = { name = "Колекція цінностей", fen = "Rae'ana might be interested in this.", fua = "Рае'ану це може зацікавити." }
    t[271423] = { name = "Ключ Водолаза", fen = "A fully assembled key... but to what?", fua = "Повністю зібраний ключ... але від чого?" }
    t[271424] = { name = "Уламок Ключа Водолаза", fen = "About a third of a key... Probably.", fua = "Приблизно третина ключа... Мабуть." }
    t[271427] = { name = "Вишуканий скарб", fen = "A treasure reclaimed from a Ritual Site.", fua = "Скарб, повернутий з місця ритуалу." }
    t[271428] = { name = "Кристалічний скарб", fen = "A treasure reclaimed from a Ritual Site.", fua = "Скарб, повернутий з місця ритуалу." }
    t[271429] = { name = "Ефірний скарб", fen = "A treasure reclaimed from a Ritual Site.", fua = "Скарб, повернутий з місця ритуалу." }
    t[271430] = { name = "Різьблений скарб", fen = "A treasure reclaimed from a Ritual Site.", fua = "Скарб, повернутий з місця ритуалу." }
    t[271434] = "Оплічник Отруйного Обряду"
    t[271435] = "Капці Сичливого Культу"
    t[271436] = "Пояс зі Звивистої Луски"
    t[271440] = "Поножі Отруйних Глибин"
    t[271441] = "Нищівний Каптур Звивуна"
    t[271444] = "Наплічники Забутої Жертви"
    t[271445] = "Широкий Пояс Іклатого Здорованя"
    t[271451] = "Плащ Нефритового Воєначальника"
    t[271452] = "Наручі Нефритового Воєначальника"
    t[271453] = "Широкий Пояс Нефритового Воєначальника"
    t[271454] = "Шалені Наплічники Нефритового Воєначальника"
    t[271455] = "Поножі Нефритового Воєначальника"
    t[271457] = "Самоцвітні Латні Рукавиці Нефритового Воєначальника"
    t[271458] = "Люті Чоботи Нефритового Воєначальника"
    t[271459] = "Кіраса Нефритового Воєначальника"
    t[271460] = "Плащ Освяченого Полум'я"
    t[271461] = "Наручі Освяченого Полум'я"
    t[271462] = "Пояс Освяченого Полум'я"
    t[271463] = "Наплічники Освяченого Полум'я"
    t[271464] = "Поножі Освяченого Полум'я"
    t[271465] = "Бойовий Шолом Освяченого Полум'я"
    t[271466] = "Латні Рукавиці Освяченого Полум'я"
    t[271467] = "Великі Чоботи Освяченого Полум'я"
    t[271468] = "Бастіон Освяченого Полум'я"
    t[271469] = "Лиховісний Великий Плащ Могильного Лицаря"
    t[271470] = "Лиховісні Наручі Могильного Лицаря"
    t[271471] = "Лиховісний Пояс Могильного Лицаря"
    t[271472] = "Лиховісні Шибениці Могильного Лицаря"
    t[271473] = "Лиховісні Поножі Могильного Лицаря"
    t[271474] = "Лиховісний Шолом Могильного Лицаря"
    t[271475] = "Лиховісні Смертельні Рукавиці Могильного Лицаря"
    t[271476] = "Лиховісні Чоботи Могильного Лицаря"
    t[271477] = "Лиховісний Нагрудник Могильного Лицаря"
    t[271478] = "Ритуальна Накидка Офідійського Оракула"
    t[271479] = "Наручі Офідійського Оракула"
    t[271480] = "Отруйний Пояс Офідійського Оракула"
    t[271481] = "Сичача Мантія Офідійського Оракула"
    t[271482] = "Поножі Зміїного Оракула"
    t[271483] = "Зміїний Вінець Офідійського Оракула"
    t[271484] = "Чаклунські Рукавиці Офідійського Оракула"
    t[271485] = "Лускаті Черевики Офідійського Оракула"
    t[271486] = "Іклате Вбрання Зміїного Оракула"
    t[271487] = "Покрив Скрадливої Гадюки"
    t[271488] = "Загартована Зап'ясткова Луска Скрадливої Гадюки"
    t[271489] = "Призові Ікла Скрадливої Гадюки"
    t[271490] = "Щелепи Скрадливої Гадюки"
    t[271491] = "Звиті Обмотки Скрадливої Гадюки"
    t[271492] = "Плакучі Ікла Скрадливої Гадюки"
    t[271493] = "Шкуроколи Скрадливої Гадюки"
    t[271494] = "Сліди Скрадливої Гадюки"
    t[271495] = "Щитковий Нагрудник Скрадливої Гадюки"
    t[271496] = "Грізний Великий Плащ Лиха"
    t[271497] = "Лускаті Наручі Лиховісного Відлуння"
    t[271498] = "Пошрамований Пояс Лиховісного Відлуння"
    t[271499] = "Розколоті Вершини Лиховісного Відлуння"
    t[271500] = "Земляні Стовпи Лиха"
    t[271501] = "Магмотворці Лиховісного Відлуння"
    t[271502] = "Чорні Великі Роги Лиховісного Відлуння"
    t[271503] = "Вулканічні Чоботи Лиховісного Відлуння"
    t[271504] = "Пекуча Кальдера Лиха"
    t[271505] = "Плащ Обраного Кривавого Різника"
    t[271506] = "Наручі Обраного Кривавого Вбивці"
    t[271507] = "Трофейний Пояс Обраного Кривавого Вбивці"
    t[271508] = "Обереги Вуду Обраного Кривавого Вбивці"
    t[271509] = "Укріплені Штани Обраного Кривавого Вбивці"
    t[271510] = "Покрив Духів Обраного Кривавого Вбивці"
    t[271511] = "Іклаті Рукавиці Обраного Кривавого Вбивці"
    t[271512] = "Чоботи Обраного Кривавого Різника"
    t[271513] = "Окуте Пончо Обраного Кривавого Різника"
    t[271514] = "Плащ Короля Мавп"
    t[271515] = "Наручі Мавпячого Короля"
    t[271516] = "Спритний Пояс Мавпячого Короля"
    t[271517] = "Китиці Мавпячого Короля"
    t[271518] = "Штани Короля Мавп"
    t[271520] = "Бойові Кулаки Мавпячого Короля"
    t[271521] = "Поножі Мавпячого Короля"
    t[271522] = "Бойове Ґі Мавпячого Короля"
    t[271523] = "Плащ Загадкового Вартового Сну"
    t[271524] = "Наручі Загадкового Вартового Сну"
    t[271525] = "Пояс із Сигілами Загадкового Вартового Сну"
    t[271526] = "Оперення Загадкового Вартового Сну"
    t[271527] = "Поножі Загадкового Вартового Сну"
    t[271528] = "Дрімотний Погляд Загадкового Вартового Сну"
    t[271529] = "Рукавиці Загадкового Вартового Сну"
    t[271530] = "Сандалі Загадкового Вартового Сну"
    t[271531] = "Місячне Вбрання Загадкового Вартового Сну"
    t[271532] = "Оздоблена Накидка Безоднього Гончака Погибелі"
    t[271533] = "Наручі Безоднього Гончака Погибелі"
    t[271534] = "Самоцвітний Пояс Безоднього Гончака Погибелі"
    t[271535] = "Щелепи Безоднього Гончака Погибелі"
    t[271536] = "Поножі Безоднього Гончака Погибелі"
    t[271537] = "Невблаганний Погляд Безоднього Гончака Погибелі"
    t[271538] = "Клепані Латні Рукавиці Безоднього Гончака Погибелі"
    t[271539] = "Чоботи Безоднього Гончака Погибелі"
    t[271540] = "Захист Ядра Безоднього Гончака Погибелі"
    t[271541] = "Кольчужний Плащ Проклятого Некроліта"
    t[271542] = "Кайдани Проклятого Некроліта"
    t[271543] = "Дзвінкий Пояс Проклятого Некроліта"
    t[271544] = "Шпилі Проклятого Некроліта"
    t[271545] = "Ножні Пов'язки Проклятого Некроліта"
    t[271546] = "Череп Проклятого Некроліта"
    t[271547] = "Обвуглені Рукавиці Проклятого Некроліта"
    t[271548] = "Підошви Проклятого Некроліта"
    t[271549] = "Брязкітлива Роба Проклятого Некроліта"
    t[271550] = "Накидка Космічного Покаянника"
    t[271551] = "Наручі Космічного Покаянника"
    t[271552] = "Орбітальний Пояс Космічного Покаянника"
    t[271553] = "Лункі Крики Космічного Покаянника"
    t[271554] = "Огортальні Поножі Космічного Покаянника"
    t[271555] = "Істинний Зір Космічного Покаянника"
    t[271556] = "Небесні Рукавиці Космічного Покаянника"
    t[271557] = "Слід Космічного Покаянника"
    t[271558] = "Затемнювальна Роба Космічного Покаянника"
    t[271559] = "Чароплащ Первісного Вартового Лей-Ліній"
    t[271560] = "Манжети Первісного Вартового Лей-ліній"
    t[271561] = "Оздоблена Самоцвітами Пряжка Первісного Вартового Лей-Ліній"
    t[271562] = "Манопотік Первісного Вартового Лей-Ліній"
    t[271563] = "Пошиті Обмотки на Ноги Первісного Вартового Лей-Ліній"
    t[271564] = "Вінець Первісного Вартового Лей-ліній"
    t[271565] = "Формувачі Мани Первісного Вартового Лей-Ліній"
    t[271566] = "Бойові Чоботи Первісного Вартового Лей-Ліній"
    t[271567] = "Герб Первісного Вартового Лей-Ліній"
    t[271638] = "Нефритове Око Зв'язаного Змія"
    t[271644] = { name = "Жарина Сили", fen = "Lady Darkglen might be interested in this.", fua = "Леді Даркґлен може цим зацікавитися." }
    t[271680] = "Опалений Гріхом Самостріл"
    t[271681] = "Вічний Морозоскутий Амулет"
    t[271693] = { name = "Загусла Отрута", fen = "A globule of congealed venom. Er'inye would likely have a use for this.", fua = "Кулька загуслої отрути. Ер'іньє, мабуть, знайде їй застосування." }
    t[271717] = "Горнятко Кафи"
    t[271785] = "Ритуальна здобич"
    t[271786] = "Звіти з ритуального місця"
    t[271787] = "Польові відзнаки"
    t[271788] = { name = "Рагу з Вепра-Нюхача", fen = "A delicious stew made of fresh caught boar. Clearly of a higher quality than an average meal.", fua = "Смачне рагу зі щойно впольованого вепра. Явно якісніше за звичайну страву." }
    t[271791] = { name = "Зілля від Головного Болю", fen = "A spoonful of fish guts helps the medicine go down!", fua = "Ложечка риб'ячих тельбухів — і ліки самі проковтнуться!" }
    t[271792] = { name = "Ключ від Контрабандного Скарбу Солдата", fen = "Smuggled alongside the chest. Who knows what might be inside.", fua = "Провезений контрабандою разом зі скринею. Хтозна, що може бути всередині." }
    t[271815] = "Люмінесцентна Перлина"
    t[271863] = { name = "Офідійська Жовч", fen = "Foul fluids from one of Ula'tek's brood.", fua = "Смердюча рідина одного з виплодків Ула'тек." }
    t[271864] = { name = "Гнила Пневма", fen = "Foul residue from the undead that stalk the temple halls.", fua = "Огидні рештки нежиті, що блукає храмовими залами." }
    t[271865] = { name = "Роздобута Зброя", fen = "A long-forgotten troll weapon.", fua = "Давно забута зброя тролів." }
    t[271866] = { name = "Добряче Зношена Сокирка", fen = "A long-forgotten troll weapon.", fua = "Давно забута зброя тролів." }
    t[271867] = { name = "Витравлений Отрутою Меч", fen = "A long-forgotten troll weapon.", fua = "Давно забута зброя тролів." }
    t[271868] = { name = "Розщеплений Спис", fen = "A long-forgotten troll weapon.", fua = "Давно забута зброя тролів." }
    t[271874] = "Жахливий Каптур Вартового Отрути"
    t[271875] = "Погляд Звивистого Вартового"
    t[271876] = "Пробуджена Кіраса Жахоікла"
    t[271878] = "Поножі Розкутої Злоби"
    t[271881] = { name = "Загублений Ключ", fen = "A small key, dropped by the hermit crab Nacretta. Smells slightly of fish.", fua = "Маленький ключик, що випав у рака-самітника Накретти. Ледь відгонить рибою." }
    t[271883] = { name = "Концентроване Сільвермунське Зілля Здоров'я", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[271884] = { name = "Концентроване Сільвермунське Зілля Здоров'я", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[271885] = { name = "Рецепт: Концентроване Сільвермунське Зілля Здоров'я", fen = "Teaches you how create a Concentrated Silvermoon Health Potion.", fua = "Навчає тебе створювати Концентроване Сільвермунське Зілля Здоров'я." }
    t[271886] = { name = "Рідкий Блиск", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[271887] = { name = "Рідкий Блиск", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[271888] = { name = "Рецепт: Рідкий Блиск", fen = "Teaches you how create Liquid Luster.", fua = "Навчає тебе створювати Рідкий Блиск." }
    t[271889] = { name = "Зваблива Панацея", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[271890] = { name = "Зваблива Панацея", fen = "Created by experienced alchemists. Can be bought and sold on the Auction House.", fua = "Створено досвідченими алхіміками. Можна купувати та продавати на аукціоні." }
    t[271891] = { name = "Рецепт: Зваблива Панацея", fen = "Teaches you how create an Alluring Nostrum.", fua = "Навчає тебе створювати Звабливу Панацею." }
    t[271970] = "Сяйво Світанку"
    t[271973] = "Ритуальна здобич"
    t[271974] = "Ритуальна здобич"
    t[271975] = "Ритуальна здобич"
    t[271976] = "Ритуальна здобич"
    t[271991] = "Скриня Отруйного Спорядження"
    t[271996] = { name = "Зім'ятий Сувій", fen = "Despite the smudged ink and torn parchment, the tortollans may be able to glean something from this.", fua = "Попри розмазане чорнило й подертий пергамент, тортолани, можливо, зуміють щось із цього почерпнути." }
    t[271997] = { name = "Понівечена Реліквія", fen = "Are those bite marks?", fua = "Це що, сліди зубів?" }
    t[271998] = { name = "Викинуте Зілля", fen = "Cracked glass and a missing label make this potion unidentifiable, but potentially still viable in a pinch.", fua = "Тріснуте скло й відсутня етикетка не дають розпізнати це зілля, але в скруті воно, можливо, ще згодиться." }
    t[271999] = { name = "Загублена ритуальна свічка", fen = "A ritual candle looking for a ritual.", fua = "Ритуальна свічка у пошуках ритуалу." }
    t[272005] = "Накидка Отруйного Гладіатора"
    t[272006] = "Накидка Отруйного Гладіатора"
    t[272007] = "Престижний Плащ Отруйного Гладіатора"
    t[272010] = "Престижний Плащ Отруйного Гладіатора"
    t[272046] = { name = "Маною обпалена лозина", fen = "Used to locate leylines, the device appears to have been damaged from prolonged exposure.", fua = "Використовується для пошуку лей-ліній; пристрій, схоже, пошкоджений тривалим впливом." }
    t[272047] = { name = "Камінь видіння глибинного причаєнця", fen = "As you stare at your reflection in the arcane-shimmering surface, you swear you see a reptilian face looking back at you for a brief moment.", fua = "Вдивляючись у своє відображення на поверхні, що мерехтить арканою, ти готовий присягнутися, що на мить побачив рептилоїдне обличчя, яке дивилося на тебе у відповідь." }
    t[272048] = { name = "Розбита перлина стримування", fen = "Carved from a massive violet-colored pearl, the arcane energy contained within has all but drained away.", fua = "Вирізьблена з велетенської фіолетової перлини, арканна енергія, що була в ній, майже вся витекла." }
    t[272049] = { name = "Закривавлена пропагандистська листівка", fen = "She abandoned us as our blood spilled! Payment for promises left unfulfilled! We must find our prize for our purpose, not hers!", fua = "Вона покинула нас, коли лилася наша кров! Розплата за обіцянки, які лишились невиконані! Ми мусимо знайти нашу здобич заради нашої мети, а не її!" }
    t[272051] = { name = "Липкий пропагандистський сувій", fen = "Baneshadow will raise our fallen! Baneshadow will lead us until she returns to usher in her final Twilight!", fua = "Згубнотінь воскресить наших полеглих! Згубнотінь вестиме нас, доки не повернеться, щоб провістити свої останні Сутінки!" }
    t[272052] = { name = "Вирвана сторінка пропаганди", fen = "Join Mor'duun's second and help finish what he started! Through Ger'lok's might, she will return to us!", fua = "Приєднуйся до правиці Мор'дууна й допоможи завершити те, що він почав! Силою Ґер'лока вона повернеться до нас!" }
    t[272109] = { name = "Зім'ята сторінка пропаганди", fen = "A Broken Throne for a broken Speaker! In Deatholme, we conquer death and void! Join Baneshadow!", fua = "Розбитий Трон для розбитого Речника! У Детхолмі ми долаємо смерть і Порожнечу! Приєднуйся до Згубитіні!" }
    t[272110] = { name = "Обгорілий пропагандистський листок", fen = "The Ruins of Deatholme bring only death and ruin! Join Speaker Ger'lok in the Broken Throne and RISE!", fua = "Руїни Детхолму несуть лише смерть і розруху! Приєднуйся до речника Ґер'лока на Розбитому Троні й ПОВСТАНЬ!" }
    t[272111] = { name = "Зотлілий плащ некроманта", fen = "Faint necrotic energy emanates from the cloak. It smells terrible.", fua = "Від плаща віє слабкою некротичною енергією. Він жахливо смердить." }
    t[272112] = { name = "Золотий вінець із рунним різьбленням", fen = "This armament bears the mark of the fallen High Inquisitor, Mor'duun.", fua = "Ця зброя несе знак полеглого Верховного Інквізитора Мор'дууна." }
    t[272113] = { name = "Уламок скалки Погибелі", fen = "Although its power has been depleted, the stench of necromancy lingers on the faded green shard.", fua = "Хоч його сила вичерпалася, сморід некромантії досі тримається на вицвілій зеленій скалці." }
    t[272114] = { name = "Викинутий розкопувальний інструмент", fen = "The chipped sigil of the Twilight's Blade can be faintly seen on the tools handle.", fua = "На держаку інструмента ледь видно надщерблений знак Клинка Сутінків." }
    t[272115] = { name = "Розбитий випромінювач щита", fen = "An alien language you don't recognize is etched on the surface of the chassis.", fua = "На поверхні корпусу викарбувано незнайому тобі чужинську мову." }
    t[272116] = { name = "Просочений водою сувій угоди", fen = "The legible details reveal a transaction of ethereal weapons being offered in exchange for something illegible.", fua = "Розбірливі рядки свідчать про угоду, за якою ефірійську зброю пропонують в обмін на щось нерозбірливе." }
    t[272117] = { name = "Розбита енергетична зброя", fen = "Arcane sparks fizzle and pop along the broken hilt of the weapon.", fua = "Арканні іскри шиплять і потріскують уздовж зламаного руків'я зброї." }
    t[272118] = { name = "Знешкоджений арканний вибуховий пристрій", fen = "While the outside shell is unrecognizable, the damaged inner components appear to be ethereal in origin.", fua = "Хоча зовнішня оболонка невпізнавана, ушкоджені внутрішні компоненти, схоже, ефіріального походження." }
    t[272119] = { name = "Вкритий осадом інструмент", fen = "A strange glowing film clings to the metal parts of the tool.", fua = "Дивна сяйлива плівка чіпляється до металевих частин інструмента." }
    t[272120] = { name = "Загадкова склянка", fen = "Bioluminescent spores glow in the strange looking water.", fua = "Біолюмінесцентні спори світяться в дивній на вигляд воді." }
    t[272125] = { name = "Запас рекрута", fen = "Contains Gold, Voidlight Marl, and an item for your current specialization acknowledging your acumen in the field.", fua = "Містить золото, пил Світла Порожнечі та предмет для вашої поточної спеціалізації на знак вашого хисту в полі." }
    t[272128] = { name = "Розмокла іграшка-рись", fen = "This toy is soaked through and heavily chewed.", fua = "Ця іграшка наскрізь промокла й сильно погризена." }
    t[272147] = "Змієподібний Перстень"
    t[272148] = "Зміїний Вир"
    t[272149] = "Перстень Вроків"
    t[272150] = "Уроборичний Перстень-Печатка"
    t[272194] = "Руна Вантуса: Припливи"
    t[272195] = "Руна Вантуса: Припливи"
    t[272196] = { name = "Техніка: Руна Вантуса: Припливи", fen = "Teaches you how to craft Vantus Rune: Tides.", fua = "Навчає вас виготовляти Руну Вантуса: Припливи." }
    t[272225] = "Мантія Вогнехода"
    t[272226] = "Покрив Туманного Переслідувача"
    t[272227] = "Вуаль Вершника Бурі"
    t[272228] = "Шепітливий Амулет"
    t[272229] = "Зміїний Талісман"
    t[272230] = "Покров Носія Присяги"
    t[272231] = "Камзол Вогнехода"
    t[272232] = "Чоботи Вогнехода"
    t[272233] = "Рукавиці Вогнехода"
    t[272234] = "Митра Вогнехода"
    t[272235] = "Черевики Вогнехода"
    t[272236] = "Оплічник Вогнехода"
    t[272237] = "Пояс-Обі Вогнехода"
    t[272238] = "Обмотки Вогнехода"
    t[272239] = "Бригантина Туманного Переслідувача"
    t[272240] = "Чоботи Туманного Переслідувача"
    t[272241] = "Рукавиці Туманного Переслідувача"
    t[272242] = "Каптур Туманного Переслідувача"
    t[272243] = "Набедреники Туманного Переслідувача"
    t[272244] = "Наплічники Туманного Переслідувача"
    t[272245] = "Пасок Туманного Переслідувача"
    t[272246] = "Наручі Туманного Переслідувача"
    t[272247] = "Кольчуга Вершника Бурі"
    t[272248] = "Чоботи Вершника Бурі"
    t[272249] = "Кольчужні Застібки Вершника Бурі"
    t[272250] = "Погляд Вершника Бурі"
    t[272251] = "Поножі Вершника Бурі"
    t[272252] = "Оплічник Вершника Бурі"
    t[272253] = "Кольчужна Спідниця Вершника Бурі"
    t[272254] = "Сітчасті Обмотки Вершника Бурі"
    t[272255] = "Кіраса Носія Присяги"
    t[272256] = "Сабатони Носія Присяги"
    t[272257] = "Латні Рукавиці Носія Присяги"
    t[272258] = "Маска Носія Присяги"
    t[272259] = "Наколінники Носія Присяги"
    t[272260] = "Наплічники Носія Присяги"
    t[272261] = "Пояс Носія Присяги"
    t[272262] = "Наручі Носія Присяги"
    t[272266] = "Кинджал Забутого Ейдолона"
    t[272267] = "Вивільнений Лабрис"
    t[272268] = "Різьбяр Масок"
    t[272269] = "Надгробок Запечатувача Душ"
    t[272270] = "Товкач для Кісткового Пилу"
    t[272271] = "Осередок, Зв'язаний Духами"
    t[272272] = "Змучена Партизана"
    t[272273] = "Освячений Церемоніальний Скіпетр"
    t[272274] = "Розколювач Світів"
    t[272275] = "Ріг Співця Душ"
    t[272276] = "Виючий Бастіон"
    t[272277] = "Шматувач Духів"
    t[272278] = "Вигнутий Вогникостріл"
    t[272280] = "Ексгумований Розсікач Душ"
    t[272283] = "Еманація Мечника"
    t[272316] = "Клинкова піка руйнівника чарів"
    t[272317] = "Фенікс-глейв руйнівника чарів"
    t[272339] = "Славетний Стяг Тіньового Чемпіона"
    t[272391] = { name = "Викрійка: мотузяна збруя для рисі", fen = "Teaches you how to craft a Rope Lynx Harness.", fua = "Навчає вас виготовляти мотузяну збрую для рисі." }
    t[272392] = { name = "Порваний повідець рисі", fen = "Some Blood Elves have made an effort to domesticate the Eversong lynx but they are rarely contained, this leash was one attempt.", fua = "Деякі ельфи крові намагалися приручити рись Лісу Вічної Пісні, та її рідко вдається втримати; цей повідець був однією з таких спроб." }
    t[272400] = { name = "Тонке рисяче хутро", fen = "This must have caught on the leash.", fua = "Це, мабуть, зачепилося за повідок." }
    t[272892] = { name = "Розбитий самоцвіт", fen = "This dark stone feels surprisingly cold to the touch.", fua = "Цей темний камінь напрочуд холодний на дотик." }
    t[272893] = { name = "Крижана збруя", fen = "The cold metal has a layer of frost on it.", fua = "Холодний метал укритий шаром паморозі." }
    t[272894] = { name = "Неактивний рунний камінь", fen = "The alien language carved into this stone is pocked with charred runic markings that smell faintly of brimstone.", fua = "Чужинська мова, висічена на цьому камені, поцяткована обвугленими рунними позначками, що ледь чутно тхнуть сіркою." }
    t[272960] = "Стіна щитів руйнівника чарів"
    t[272961] = "Клинковий посох руйнівника чарів"
    t[272975] = { name = "Код-ключ наглядача Гал'гадара", fen = "Free the caged creatures.", fua = "Звільни ув'язнених істот." }
    t[273000] = { name = "Роз'їдлива Душа", fen = "Corrosive Souls can be used at the Altar of Corrosion or given to Er'inye in exchange for Corrosive Coins.", fua = "Роз'їдливі Душі можна використати біля Вівтаря Корозії або віддати Ер'іньє в обмін на Роз'їдливі Монети." }
    t[273004] = "Роз'їдливий Повторний Кидок"
    t[273013] = { name = "Клапоть шкури, пронизаний Порожнечею", fen = "The cold, tattered remnants of a void-suffused beast.", fua = "Холодні, пошарпані рештки звіра, просякнутого Порожнечею." }
    t[273014] = { name = "Виюча скляна скалка", fen = "The cold void glass trembles as if something trapped within struggles to escape.", fua = "Холодне скло Порожнечі тремтить, наче щось ув'язнене всередині борсається, щоб вирватися назовні." }
    t[273059] = { name = "Ритуальний Камінь Мисливця", fen = "Crafted by players with the Blacksmithing skill. Can be bought and sold on the Auction House.", fua = "Виготовляється гравцями з умінням ковальства. Можна купити й продати на аукціоні." }
    t[273060] = { name = "Ритуальний Камінь Мисливця", fen = "Crafted by players with the Blacksmithing skill. Can be bought and sold on the Auction House.", fua = "Виготовляється гравцями з умінням ковальства. Можна купити й продати на аукціоні." }
    t[273061] = { name = "Креслення: Ритуальний Камінь Мисливця", fen = "Teaches you how to craft a Hunter's Ritual Stone.", fua = "Навчає вас виготовляти Ритуальний Камінь Мисливця." }
    t[273062] = { name = "Згорнуте Зміїне Око", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[273063] = { name = "Згорнуте Зміїне Око", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[273064] = { name = "Креслення: Згорнуте Зміїне Око", fen = "Teaches you how to craft a Coiled Snake-Eye.", fua = "Навчає вас виготовляти згорнуте зміїне око." }
    t[273065] = { name = "Полірований Амоліт", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[273066] = { name = "Полірований Амоліт", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[273067] = { name = "Креслення: Полірований Амоліт", fen = "Teaches you how to craft Polished Ammolite.", fua = "Навчає тебе виготовляти полірований амоліт." }
    t[273068] = { name = "Оздоблене Ікло", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[273069] = { name = "Оздоблене Ікло", fen = "Can be bought and sold on the Auction House.", fua = "Можна купувати й продавати на Аукціоні." }
    t[273070] = { name = "Викрійка: Оздоблене Ікло", fen = "Teaches you how to craft an Adorned Fang.", fua = "Навчає вас виготовляти Оздоблене Ікло." }
    t[273071] = "Чари зброї — Обряд Гаш'ей"
    t[273072] = "Чари зброї — Обряд Гаш'ей"
    t[273073] = { name = "Формула: Обряд Гаш'ей", fen = "Teaches you how to perform the Rite of the Hash'ey enchantment.", fua = "Навчає тебе, як виконати зачарування «Обряд Гаш'ей»." }
    t[273152] = { name = "Скриня спорядження Глибин", fen = "Creates a set of gear at this item level.", fua = "Створює комплект спорядження цього рівня предметів." }
    t[273153] = { name = "Скриня спорядження Глибин", fen = "Creates a set of gear at this item level.", fua = "Створює комплект спорядження цього рівня предметів." }
    t[273154] = { name = "Скриня спорядження Глибин", fen = "Creates a set of gear at this item level.", fua = "Створює комплект спорядження цього рівня предметів." }
    t[273155] = { name = "Скриня спорядження Глибин", fen = "Creates a set of gear at this item level.", fua = "Створює комплект спорядження цього рівня предметів." }
    t[273156] = { name = "Скриня спорядження Глибин", fen = "Creates a set of gear at this item level.", fua = "Створює комплект спорядження цього рівня предметів." }
    t[273288] = { name = "Суп Соу'джина", fen = "Looks awful but smells delicious.", fua = "Виглядає жахливо, але пахне смачно." }
    t[273303] = { name = "Ритуальний Самоцвіт", fen = "Sacred gems stolen and used in dark rituals.", fua = "Священні самоцвіти, викрадені й використані в темних ритуалах." }
    t[273307] = { name = "Флакон відважного лимонаду", fen = "Freshly squeezed by an intrepid entrepreneur! Glittering with sugar crystals... or mana crystals?", fua = "Свіжовичавлений відважним підприємцем! Виблискує кристаликами цукру... чи то кристаликами мани?" }
    t[273649] = "Грозоскута Емблема Дазара"
    t[273773] = "Обмотки для Рук Блюзнірських Обрядів"
    t[273774] = "Наплічники зі Зміїної Шкіри"
    t[273775] = "Наручі з Луски Гідри"
    t[273776] = "Обсидіанові Стовпи Давнього Генерала"
    t[273777] = "Отрутостійкі Чоботи"
    t[273778] = "Полірований Спрямовувач зі Світлодерева"
    t[273779] = "Згубне Фокусне Ікло"
    t[273780] = "Витравлений Отрутою Серп"
    t[273781] = "Низка Оберегових Іклів"
    t[273782] = "Мерзенна Глефа Звивоікла"
    t[273783] = "Вкритий Отрутою Бойовий Посох"
    t[273784] = "Вигнутий Лук Предків Амані"
    t[273785] = "Первісна Роба Обрядів"
    t[273786] = "Поножі Сплетених Змій"
    t[273787] = "Старий Переплетений Лускатий Обладунок"
    t[273789] = "Нагрудник Роз'їденої Луски"
    t[273791] = { name = "Запасний Каптур Речника", fen = "One of the few familial keepsakes Zul'jan took with him when he set out.", fua = "Одна з небагатьох родинних пам'яток, які Зул'джан узяв із собою, вирушаючи в путь." }
    t[273792] = { name = "Перстень Воєначальника Амані", fen = "A simple but durable ring, once worn by the Warlord Zul'jin himself.", fua = "Простий, але міцний перстень, який колись носив сам воєначальник Зул'джин." }
    t[273793] = "Парний Клинок із Хребта Гідри"
    t[273794] = "Вузол Звивистих Змій"
    t[273795] = "Вигнутий Іклокамінь"
    t[273796] = { name = "Мерзенний Флакон Нестабільної Отрути", fen = "Questionable? Yes. Potable?... Technically yes.", fua = "Сумнівно? Так. Придатне до пиття?.. Формально — так." }
    t[273797] = { name = "Подертий Бойовий Стяг Амані", fen = "Aged and worn, it has led the Amani to countless victories in ages past.", fua = "Старий і зношений, він вів амані до незліченних перемог у давні часи." }
    t[273844] = { name = "Очищувальна пляшечка Шаджі", fen = "This looks like plain water and smells a little salty.", fua = "Виглядає як звичайна вода й трохи відгонить сіллю." }
    t[273855] = { name = "Ритуальна табличка", fen = "An intricate tablet outlining the ritual at the site. It contains valuable knowledge but will keep our researchers busy studying it for at least a week.", fua = "Майстерно виконана табличка, що описує ритуал на цьому місці. Вона містить цінні знання, але нашим дослідникам знадобиться щонайменше тиждень, щоб її вивчити." }
    t[273856] = { name = "Уламок ритуальної таблички", fen = "A fragment of a Ritual Tablet. Some knowledge can still be recovered, but again it will take our researchers working overtime to decipher more in a week.", fua = "Уламок ритуальної таблички. З нього ще можна відновити частину знань, але нашим дослідникам знову доведеться працювати понаднормово, щоб розшифрувати більше за тиждень." }
    t[273873] = "Торкнута Порожнечею бойова сокира Сонячної Люті"
    t[273874] = "Торкнута Порожнечею бойова сокира Сонячної Люті"
    t[273881] = "Протиотрутний Панцир"
    t[274033] = { name = "Деревні Уламки", fen = "Shaken loose by winds on the island, this debris is just the right size for crafting.", fua = "Струшені вітрами на острові, ці уламки саме підхожого розміру для ремесла." }
    t[274036] = { name = "Магікула Порожнечі", fen = "As you peer into the orb, you see brief flickers of runic enchantments, forbidden spells, and sealed-away knowledge swirling within, calling out to you.", fua = "Вдивляючись у сферу, ти бачиш, як усередині спалахують руничні чари, заборонені закляття та запечатане знання, що кружляють і кличуть тебе." }
    t[274069] = "Пакунок бойової ватаги зі світанковими гербами Героя"
    t[274070] = "Пакунок бойової ватаги зі світанковими гербами Чемпіона"
    t[274071] = "Пакунок бойової ватаги зі світанковими гербами Ветерана"
    t[274076] = { name = "Проклятий Отрутою Карпозубик", fen = "The tamest of the venom-cursed fish, but still dripping with vile juices.", fua = "Найсмирніша з проклятих отрутою риб, та все одно стікає мерзенним соком." }
    t[274083] = { name = "Бомбардувальний Ранець Берді", fen = "Under the venom curse, Birdie experimented with the nastiest of explosives, now neatly kept in a watertight pack.", fua = "Прокляття отрути штовхнуло Берді на досліди з найпаскуднішою вибухівкою — тепер її охайно складено у водонепроникний ранець." }
    t[274089] = { name = "Добірні Сухарі Суплрґра", fen = "A craft passed down through generations, breadcrumbs can elevate any dish simply by guiding the gourmand to their meal.", fua = "Ремесло, що передається з покоління в покоління: сухарі здатні піднести будь-яку страву, просто вказавши гурманові шлях до його трапези." }
    t[274090] = { name = "Осяйний Ектошип", fen = "Ghostly and sharp, this ingredient makes a meal into a dangerous game of chance. Who will survive?", fua = "Примарний і гострий, цей інгредієнт перетворює страву на небезпечну гру випадку. Хто виживе?" }
    t[274091] = { name = "Жорстке Крабове М'ясо", fen = "This chewy crab meat is perfect for showing off how difficult a recipe can be.", fua = "Це жилаве крабове м'ясо ідеально підходить, щоб показати, яким складним може бути рецепт." }
    t[274103] = { name = "Запасний Казанок Шкіроязика", fen = "Toughened by the worst of Leathertongue's pre- and post-venom curse cooking, this pot should make a suitable shield.", fua = "Загартований найгіршими стравами Шкіроязика — і до, і після прокляття отрутою, — цей казанок має стати годящим щитом." }
    t[274145] = { name = "Стос Паперів", fen = "A wrapped bundle of miscellaneous papers detailing Tortollan business agreements.", fua = "Перев'язаний стос різноманітних паперів із подробицями ділових угод тортоланів." }
    t[274146] = { name = "Тортоланські Пожитки", fen = "Tortollan Belongings", fua = "Тортоланські пожитки." }
    t[274147] = { name = "Пляшка Піску", fen = "A sealed bottle of sand, striated in multiple colors.", fua = "Запечатана пляшка піску, посмугованого кількома кольорами." }
    t[274148] = { name = "Пакетик Рибальських Принад", fen = "A packet of fishing lures, wrapped carefully to avoid unintended injury.", fua = "Пакетик рибальських принад, дбайливо загорнутих, щоб ніхто ненароком не поранився." }
    t[274164] = { name = "Мандрівний Караван Хранителя Вогнища", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[274261] = { name = "Шифр-ключ Великого Магістра", fen = "The Grand Magister's Key-Cipher hums with latent arcane energy.", fua = "Шифр-ключ Великого Магістра гуде прихованою арканною енергією." }
    t[274266] = { name = "Ка'бабб", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[274267] = { name = "Сплавлена життєва сила", fen = "A coalesced mote of pure, primal energy. Acquired by purchase from Abundance Vendor Chel the Chip or Abyss Angler Depthdiver Tu'nakit.", fua = "Згущена крихта чистої первісної енергії. Купується у Торговки рясності Чел Карбівки або в Рибалки Безодні Глибинника Ту'накіта." }
    t[274272] = "Скриня Спорядження Амані"
    t[274281] = { name = "Чорноотруйний Групер", fen = "From Seszam the Venom-Leech's gullet, this fish has soaked in the most venom of any fish on Atal'Utek.", fua = "З горлянки Сесзама Отруйної П'явки: ця риба ввібрала найбільше отрути з-поміж усіх риб Атал'Утека." }
    t[274282] = { name = "Заряджений Отрутою Дублон", fen = "This is a prized snack of Seszam the Venom-Leech.", fua = "Це улюблені ласощі Сесзама Отруйної П'явки." }
    t[274296] = { name = "Згубна Отрута Ула'тек", fen = "Extremely caustic! Carefully collect into Dezi's Potion Bottle.", fua = "Надзвичайно їдка! Обережно збери її в Пляшку для Зілля Дезі." }
    t[274297] = { name = "Пляшка для Зілля Дезі", fen = "Fill with the venom from the Children of Ula'tek at The Serpent's Tail.", fua = "Наповни отрутою Дітей Ула'тек у Зміїному Хвості." }
    t[274372] = { name = "Добрячий Мішок Полірованих Талісманів Улюбленця", fen = "Contains 100 Polished Pet Charms.", fua = "Містить 100 Полірованих Талісманів Улюбленця." }
    t[274374] = { name = "Винагорода шукача скарбів", fen = "Surely, great treasure awaits.", fua = "Безперечно, на тебе чекає великий скарб." }
    t[274407] = { name = "Паливний елемент автоматона Гал'гадара", fen = "Overload Hal'hadar machinery.", fua = "Перевантажує машинерію Гал'гадара." }
    t[274421] = { name = "Ящик Купонів Спільноти", fen = "Contains 10 Community Coupons.", fua = "Містить 10 Купонів Спільноти." }
    t[274422] = { name = "Закостеніла Реліквія", fen = "A lonely piece of bone. Perhaps its purpose lies elsewhere?", fua = "Самотній шматок кістки. Можливо, його призначення деінде?" }
    t[274437] = "Оберіг від Отрути"
    t[274462] = "Витверезний Еліксир"
    t[274465] = { name = "Збурений Ящик Зандаларської Люті", fen = "Contains a small Zandalari Raptor. Is it an Anklerender? A Kneebiter? It's hard to tell them apart until you check.", fua = "Містить маленького зандаларського раптора. Це Дерун Кісточок? Чи Кусач за Коліна? Поки не роздивишся — не відрізниш." }
    t[274476] = { name = "Іскра Припливів", fen = "A unique crafting material imbued with cerulean water. Obtained through weekly quests or end-game activities, it is used to create the most powerful of equipment via professions.", fua = "Унікальний ремісничий матеріал, насичений лазуровою водою. Здобувається за щотижневі завдання або в активностях максимального рівня; за допомогою професій із нього створюють найпотужніше спорядження." }
    t[274486] = { name = "Сумка Руми", fen = "It rattles with the sound of the many fragile items contained within.", fua = "Вона торохтить від безлічі крихких речей, що лежать усередині." }
    t[274492] = { name = "Заразний Зразок Дикої Фауни", fen = "Is it still wiggling?!", fua = "Воно ще ворушиться?!" }
    t[274493] = "Подоба Вірних Ула'тек"
    t[274494] = "Хіральний Прищеплювач Кісткового Мозку"
    t[274495] = "Окулюс Шукача Імпульсу"
    t[274496] = "Офідійський Кістяний Свисток"
    t[274497] = "Духороздирна Отрута"
    t[274498] = "Оберіг Духів"
    t[274499] = "Отрутоносне Переливання"
    t[274500] = { name = "Без Таємниць: Алхімія", fen = "An article depicting all the ways artisan crafters improve their skills.", fua = "Стаття, що описує всі способи, якими майстри-ремісники вдосконалюють свої вміння." }
    t[274507] = "Без Таємниць: Шкіряна Справа"
    t[274508] = "Без Таємниць: Білування"
    t[274509] = "Без Таємниць: Гірництво"
    t[274510] = { name = "Без Таємниць: Ювелірна Справа", fen = "A magazine depicting all the ways artisan crafters improve their skills.", fua = "Журнал, що описує всі способи, якими майстри-ремісники вдосконалюють свої вміння." }
    t[274511] = { name = "Без Таємниць: Накладання Чарів", fen = "A magazine depicting all the ways artisan crafters improve their skills.", fua = "Журнал, що описує всі способи, якими майстри-ремісники вдосконалюють свої вміння." }
    t[274512] = { name = "Без Таємниць: Кравецтво", fen = "A magazine depicting all the ways artisan crafters improve their skills.", fua = "Журнал, що описує всі способи, якими майстри-ремісники вдосконалюють свої вміння." }
    t[274513] = "Без Таємниць: Травництво"
    t[274514] = "Без Таємниць: Накреслення"
    t[274515] = { name = "Без Таємниць: Ковальство", fen = "A magazine depicting all the ways artisan crafters improve their skills.", fua = "Журнал, що описує всі способи, якими майстри-ремісники вдосконалюють свої вміння." }
    t[274516] = { name = "Без Таємниць: Інженерія", fen = "A magazine depicting all the ways artisan crafters improve their skills.", fua = "Журнал, що описує всі способи, якими майстри-ремісники вдосконалюють свої вміння." }
    t[274574] = { name = "Намисто А'поне", fen = "A big necklace for a big troll.", fua = "Велике намисто для великого троля." }
    t[274575] = { name = "Шматки Намиста Уга'не", fen = "There's not much left.", fua = "Небагато лишилося." }
    t[274576] = { name = "Ритуалізована аркана", fen = "This darkened arcane substrate is warm to the touch and smells faintly of char.", fua = "Цей затемнений арканний субстрат теплий на дотик і ледь чутно пахне гаром." }
    t[274577] = { name = "Темне злиття лей-енергії", fen = "Motes of shadow and raw arcane swirl around this glittering piece of coalesced ley line energy.", fua = "Часточки тіні та чистої аркани кружляють довкола цього мерехтливого згустку злитої енергії силових ліній." }
    t[274578] = { name = "Підношення чистої рясності", fen = "A small benevolence from Dundun, Loa of Abundance, containing 4500 Unalloyed Abundance.", fua = "Невеликий дарунок від Дундуна, лоа Рясності, що містить 4500 чистого рясності." }
    t[274579] = { name = "Неушкоджена Голка Пастки", fen = "Part of the trap mechanism that immobilizes the crab using cursed venom.", fua = "Частина механізму пастки, що знерухомлює краба проклятою отрутою." }
    t[274580] = { name = "Першоесенція Скверни", fen = "A swirling vortex of concentrated chaos, its power barely contained.", fua = "Вируючий вир концентрованого хаосу, чию міць ледь стримано." }
    t[274581] = { name = "Першоесенція тіні", fen = "A swirling vortex of concentrated Void, its power barely contained.", fua = "Вирий вир зосередженої Порожнечі, чию міць ледве стримано." }
    t[274582] = { name = "Першоесенція життя", fen = "A swirling vortex of concentrated nature, its power barely contained.", fua = "Вируючий вир концентрованої природи, чию міць ледь стримано." }
    t[274583] = { name = "Першоесенція аркани", fen = "A swirling vortex of concentrated arcana, its power barely contained.", fua = "Вируючий вир концентрованої аркани, чию міць ледь стримано." }
    t[274584] = { name = "Першоесенція Світла", fen = "A swirling vortex of concentrated holy Light, its power barely contained.", fua = "Вирий вир зосередженого святого Світла, чию міць ледве стримано." }
    t[274585] = { name = "Першоесенція смерті", fen = "A swirling vortex of concentrated death, its power barely contained.", fua = "Вируючий вир концентрованої смерті, чию міць ледь стримано." }
    t[274587] = { name = "Плямистий Карпозубик", fen = "A common fish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Звичайна риба зі Звивистого Острова. Можна купувати й продавати на аукціоні." }
    t[274588] = { name = "Отруйна Тлапі", fen = "A common fish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Звичайна риба зі Звивистого Острова. Можна купувати й продавати на аукціоні." }
    t[274589] = { name = "Зміїноголов Ула'тек", fen = "A rare fish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Рідкісна риба зі Звивистого Острова. Можна купити й продати на Аукціоні." }
    t[274590] = { name = "Сірчана Мулориба", fen = "An uncommon fish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Незвичайна риба зі Звивистого Острова. Можна купувати й продавати на Аукціоні." }
    t[274591] = { name = "Звивистий Зорежер", fen = "A rare fish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Рідкісна риба зі Звивистого Острова. Можна купити й продати на Аукціоні." }
    t[274592] = { name = "Брудний Стрілець", fen = "A common fish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Звичайна риба зі Звивистого Острова. Можна купувати й продавати на аукціоні." }
    t[274593] = { name = "Чумний Роєвик", fen = "A rare fish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Рідкісна риба зі Звивистого Острова. Можна купити й продати на Аукціоні." }
    t[274594] = { name = "Забруднена Риба-Куля", fen = "An uncommon fish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Незвичайна риба зі Звивистого Острова. Можна купувати й продавати на Аукціоні." }
    t[274595] = { name = "Бездоганний Багатокутник", fen = "A rare starfish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Рідкісна морська зірка зі Звивистого Острова. Можна купити й продати на Аукціоні." }
    t[274596] = { name = "Викинутий на Берег Астероїд", fen = "A common starfish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Звичайна морська зірка зі Звивистого Острова. Можна купити й продати на Аукціоні." }
    t[274597] = { name = "Бульбастий Бентос", fen = "An uncommon starfish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Незвичайна морська зірка зі Звивистого острова. Можна купувати й продавати на аукціоні." }
    t[274620] = { name = "Сингулярне кріоядро", fen = "A frozen core of Void and ice plucked from the darkest depths of Val.", fua = "Замерзле ядро Порожнечі та криги, видобуте з найтемніших глибин Валу." }
    t[274640] = { name = "Гідроспора арквиру", fen = "A pure, living ley-spore fused with the arcane-rich waters of Naigtal pulses within the containment sphere.", fua = "Чиста, жива лей-спора, злита з багатими на аркану водами Найґталу, пульсує всередині стримувальної сфери." }
    t[274649] = { name = "Зореріз Володаря Порожнечі", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[274650] = { name = "Нечесткований нуль-каркас", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[274682] = { name = "Герб Прикликання Тетла'кетля", fen = "Used in the conjurer's ritual. The plumage still glows.", fua = "Використовується в ритуалі заклинача. Пір'я досі світиться." }
    t[274685] = { name = "Луска Прикликання Тсссаані", fen = "Used in the sssummoner's ritual. Imbued with diabolical intent.", fua = "Ссслужить для ритуалу прикликача. Просякнута диявольським наміром." }
    t[274705] = "Румин Винищувач Зарази"
    t[274707] = { name = "Кристалізований Манопотік Отруйної Згуби", fen = "Grant Venomblight Manaflux capable of imbuing armor with incredible power at the Catalyst in Silvermoon.", fua = "Дарує Манопотік Отруйної Згуби, здатний наділити броню неймовірною силою, біля Каталізатора в Сільвермуні." }
    t[274708] = { name = "Туманний сховок Порожнечі: Німрісса Хвилезаклиначка", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization.\n\nItems may be received once per difficulty level until all potential items for your current specialization have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі.\n\nПредмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети для вашої поточної спеціалізації." }
    t[274713] = { name = "Сховок Скарбів Амані", fen = "Rewards a piece of Hero equipment for your Loot Specialization.", fua = "Дає предмет спорядження рівня «Герой» для твоєї спеціалізації здобичі." }
    t[274714] = { name = "Сховок Скарбів Амані", fen = "Rewards a piece of Champion equipment for your Loot Specialization.", fua = "Винагороджує предметом спорядження чемпіона для вашої спеціалізації здобичі." }
    t[274763] = "Швидкоплинне Рідке Сяйво"
    t[274764] = "Швидкоплинне Рідке Сяйво"
    t[274765] = "Швидкоплинна Зваблива Панацея"
    t[274772] = "Ефірний бинт"
    t[274774] = "Просочена морозом пара"
    t[274775] = "Випар голодаря Порожнечі"
    t[274777] = { name = "Знешкоджений Згусток Отрути", fen = "This is all that remains after neutralizing venom on the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Це все, що лишається після знешкодження отрути на Звивистому Острові. Можна купувати й продавати в аукціонному домі." }
    t[274780] = "Пара грибних спор"
    t[274781] = { name = "Скута Прокляттям Куля", fen = "The object thrums with unsettling energy. Can be bought and sold on the Auction House.", fua = "Предмет гуде тривожною енергією. Можна купувати й продавати на аукціоні." }
    t[274782] = "Випар, що Розрубує Пута"
    t[274783] = { name = "Жар Скверни", fen = "Still warm to the touch.", fua = "Досі теплий на дотик." }
    t[274793] = "Проєктор манабар'єру"
    t[274794] = "Підсилювач ударної хвилі"
    t[274796] = "Отруєний Смертоносний Клинок"
    t[274798] = { name = "Дистанційний детонатор", fen = "Plant on Hal'Hadar Skiffs to destroy them from a safe distance.", fua = "Установіть на яликах Гал'гадарів, щоб знищити їх із безпечної відстані." }
    t[274801] = "Отруєне Зміїне Ікло"
    t[274802] = "Отруєний Молоток"
    t[274803] = "Отруєний Розтинач Тролів"
    t[274804] = "Отруєний Розсікач Ельфів"
    t[274805] = "Отруєний Тесак"
    t[274806] = "Отруєний Череворіз"
    t[274807] = "Отруєний Ритуалізатор"
    t[274808] = "Отруєний Тіньовий Клеймор"
    t[274809] = "Отруєний Збирач Душ"
    t[274810] = "Отруєний Шал Весни"
    t[274811] = "Отруєний Жертовний Кинджал"
    t[274812] = "Отруєний Спис Мисливця"
    t[274813] = "Отруєний Молот"
    t[274814] = "Отруєний Шматувач Дичини"
    t[274815] = "Отруєні Сторінки"
    t[274816] = "Отруєна Облудна Обітниця"
    t[274817] = { name = "Золота Морська Зірка", fen = "A true badge of honor.", fua = "Справжня відзнака честі." }
    t[274818] = "Накидка Глибокої Темряви"
    t[274819] = "Грибоскладчастий каптан"
    t[274820] = "Плащ ненажерливого пожирача"
    t[274821] = "Накидка Вбивці Гал'гадар"
    t[274822] = "Перстень женця звірів"
    t[274823] = "Перстень із губчастих зябер"
    t[274824] = "Кістяний перстень Світожера"
    t[274825] = "Печатка вбивці Гал'гадара"
    t[274826] = "Звивистий димовий ланцюг"
    t[274827] = "Дренейський приводний ланцюг"
    t[274828] = "Шати поневолювача доманаарів"
    t[274829] = "Черевики псувача істот"
    t[274830] = "Льодом вкриті рукавиці"
    t[274831] = "Вінець творця порталів"
    t[274832] = "Заплямовані Скверною штани"
    t[274833] = "Крижана мантія з павучого шовку"
    t[274834] = "Шнур владної рішучості"
    t[274835] = "Наручі з клешнявих жил"
    t[274836] = "Стійкий до мокрого снігу камзол"
    t[274837] = "Чоботи зі зіпсутої шкури"
    t[274838] = "Рукавиці спадного руйнівника"
    t[274839] = "Покрив для холодного світу"
    t[274840] = "Штани втраченого легіону"
    t[274841] = "Наплічники крижаного печерного мешканця"
    t[274842] = "Шкіряний пояс брамника"
    t[274843] = "Зап'ясткові щитки проти клешень"
    t[274844] = "Кольчуга крижаних ланок"
    t[274845] = "Поножі зіпсутої луски"
    t[274846] = "Латні рукавиці Льодовикової улоговини"
    t[274847] = "Наголов'я Атомуса"
    t[274848] = "Поножі Скверни"
    t[274849] = "Наплічник морозолуского павука"
    t[274850] = "Кольчужний Пояс Мерцилуса"
    t[274851] = "Блискучі обмотки з морозної луски"
    t[274852] = "Нагрудник крупозернистого каменю"
    t[274853] = "Чавила істот"
    t[274854] = "Латні рукавиці Тіньової варти"
    t[274855] = "Шолом охоронця порталів"
    t[274856] = "Замерзлі поножі стража Скверни"
    t[274857] = "Хітинові наплічники матері виводку"
    t[274858] = "Бойовий пояс доманаарів"
    t[274859] = "Латні наручі клаксидів"
    t[274860] = { name = "Давня вкрита спорами сокира", fen = "Draenic script is still legible on the head of the axe.", fua = "На лезі сокири досі читається дренейське письмо." }
    t[274861] = "Морозне ікло матері виводку"
    t[274862] = "Зіпсутий кріс жриці дренеїв"
    t[274863] = "Кий покрученого женця"
    t[274864] = "Молот спороцвіту"
    t[274865] = "Падаючий молот руйнівника"
    t[274866] = "Лезо, спотворене Порожнечею"
    t[274867] = "Накреслений меч доманаара"
    t[274868] = "Короткий клинок майстра порталів"
    t[274869] = "Бойові глефи, скуті кригою Порожнечі"
    t[274870] = "Лук убивці з тятивою Порожнечі"
    t[274871] = "Гігантський протинач червів"
    t[274872] = "Жахний Шип Темряви"
    t[274873] = "Шпиль розпорядника похорону"
    t[274874] = "Мерехтливий розтинач крил"
    t[274875] = "Ліхтар Розломоходця"
    t[274876] = "Укріплений бастіон з грибошкіри"
    t[274877] = "Головорозкол фазового клинка"
    t[274878] = "Клинок тінероздирача Гал'гадара"
    t[274879] = "Манапідсилений трощитель"
    t[274880] = "Молоток ад'ютанта Гал'гадара"
    t[274881] = "Фазовий підпалювач"
    t[274882] = "Імпульсна рушниця Гал'гадара"
    t[274883] = "Бойова сокира вимірної варти Гал'гадара"
    t[274884] = "Маяк арканного прищеплювача"
    t[274885] = "Фазозагострений фальшіон"
    t[274886] = "Кадило винищувача"
    t[274887] = "Манаперевантажений бастіон"
    t[274888] = "Глейви легіону Гал'гадара"
    t[274889] = "Лезо темноклинка Гал'гадара"
    t[274890] = "Зачарована спора"
    t[274891] = "Зубчастий привід Mk XII"
    t[274892] = "Стійкий флакон крові Скверни"
    t[274893] = "Морозне жало клаксида"
    t[274913] = "Уламки Жаровні"
    t[274921] = { name = "Перлина Радощів", fen = "A faint sound of clacking claws can be heard.", fua = "Чути ледь уловимий стукіт клешень." }
    t[274923] = { name = "Шкряботун Акірів", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[274924] = { name = "Просякнуті Спорами Легені", fen = "Kifaan needs these for his research.", fua = "Кіфаан потребує їх для свого дослідження." }
    t[274927] = { name = "Крилохап Акірів", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[274934] = { name = "Клинок Матріарха Лицарів Крові", fen = "Lady Liadrin's prized sword. Salandria wanted you to have it.", fua = "Цінний меч леді Ліадрін. Саландрія хотіла, щоб він дістався тобі." }
    t[274936] = { name = "Заряджений кристалічний провідник", fen = "Arcane-flecked spores seem to be drawn to the rune-marked crystals.", fua = "Спори, поцятковані арканом, наче тягнуться до позначених рунами кристалів." }
    t[274937] = { name = "Щит Матріарха Лицарів Крові", fen = "Lady Liadrin's beloved shield. Salandria wanted you to have it.", fua = "Улюблений щит леді Ліадрін. Саландрія хотіла, щоб він дістався тобі." }
    t[274951] = "Роз'їдена Луска"
    t[274953] = "Зміїний Ірис"
    t[274954] = "Бездоганне Ікло"
    t[274965] = "Давня дивовижа"
    t[274970] = "Давня дивовижа"
    t[274990] = { name = "Вузол даних піхоти", fen = "K'areshi runes dance around the outer chassis of the device.", fua = "Руни к'арешів витанцьовують навколо зовнішнього корпусу пристрою." }
    t[275012] = { name = "Рецепт: Багатооберіг Токки", fen = "Teaches you how to craft Tokka's Multi-Ward.", fua = "Навчає вас виготовляти багатооберіг Токки." }
    t[275013] = { name = "Багатооберіг Токки", fen = "When the right tools for the job are all of them.", fua = "Коли правильний інструмент для роботи — це всі одразу." }
    t[275018] = { name = "Рецепт: Принада на Звивистого Зорежера", fen = "Teaches you how to craft a Coiled Stargorger Lure.", fua = "Навчає тебе виготовляти Принаду на Звивистого Зорежера." }
    t[275020] = { name = "Отруйний Елементаль", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[275038] = "Інгредієнти Штормстаутів"
    t[275039] = "Прокляття Акірів"
    t[275047] = { name = "Ліхтар Броварні Штормстаутів", fen = "There might be somewhere to display this in the Arcantina.", fua = "Можливо, для нього знайдеться місце в Аркантині." }
    t[275048] = { name = "Старезний Ключ", fen = "Lost long ago by some poor, ancient troll. Could it unlock something valuable?", fua = "Давним-давно загублений якимсь бідолашним прадавнім тролем. Чи не відімкне він щось цінне?" }
    t[275053] = { name = "Колекція Кобольдових Свічок", fen = "There might be somewhere to display this in the Arcantina.", fua = "Можливо, для нього знайдеться місце в Аркантині." }
    t[275054] = { name = "Дерев'яний Іграшковий Меч", fen = "There might be somewhere to display this in the Arcantina.", fua = "Можливо, для нього знайдеться місце в Аркантині." }
    t[275060] = { name = "Забута Реліквія", fen = "A long-abandoned Soulcoiler relic. Its power is faded, but may yet be put to good use.", fua = "Давно покинута реліквія Душезвіїв. Її сила згасла, але їй ще можна знайти добрий ужиток." }
    t[275062] = "Ілюзія: Отруйна Спіраль"
    t[275068] = "Вимпел Отруйної Легенди"
    t[275070] = "Загострений Різак зі Світлодерева"
    t[275134] = { name = "Потойбічна іскра війни", fen = "An iridescent essence.", fua = "Райдужна есенція." }
    t[275135] = { name = "Ключ дешифрування брандмауера", fen = "Red K'areshi runes rapidly flicker through the small energized node.", fua = "Червоні руни к'арешів швидко мерехтять у маленькому енергетизованому вузлі." }
    t[275136] = "Блузка з тканого листя"
    t[275137] = "Мерехтливі м'якоступи"
    t[275138] = "Обмотки рук доглядача спор"
    t[275139] = "Корона грибних спор"
    t[275140] = "Легінси Опоганеної Набивки"
    t[275141] = "Наплічники, поцятковані спорами"
    t[275142] = "Перев'яз, спотворений Порожнечею"
    t[275143] = "Церемоніальні манжети дренеїв"
    t[275144] = "Плащ із листяної шкури"
    t[275145] = "Стопники зі шкіри низинокрила"
    t[275146] = "Рукавиці зі спорової мембрани"
    t[275147] = "Біолюмінесцентна болотяна маска"
    t[275148] = "Підбиті штани мародера"
    t[275149] = "Грибами оповиті еполети"
    t[275150] = "Шкіряний пояс спорокажана"
    t[275151] = "Наручі дренейської скорботи"
    t[275152] = "Кільчастий обладунок землероя"
    t[275153] = "Мерехтливі лускаті сабатони"
    t[275154] = "Рукавиці болотного мандрівника"
    t[275155] = "Нескінченний грибний шолом"
    t[275156] = "Легінси на шестернях"
    t[275157] = "Наплічники болотохода"
    t[275158] = "Лускатий пояс, спотворений Порожнечею"
    t[275159] = "Наручі маніпулятора конструктів"
    t[275160] = "Панцир Слайпаана"
    t[275161] = "Болотостійкі тупотуни"
    t[275162] = "Рукавиці, виполірувані спорами"
    t[275163] = "Підсилений шолом Уарна"
    t[275164] = "Незламні механізовані набедрені пластини"
    t[275165] = "Наплічні пластини зі скам'янілого гриба"
    t[275166] = "Великий пояс, спотворений Порожнечею"
    t[275167] = "Цілі пластини конструкта"
    t[275168] = "Плащ загону реагування"
    t[275169] = "Накидка загону реагування"
    t[275170] = "Шаль загону реагування"
    t[275171] = "Накидка загону реагування"
    t[275172] = "Шати загону реагування"
    t[275173] = "Капці загону реагування"
    t[275174] = "Рукавиці загону реагування"
    t[275175] = "Корона загону реагування"
    t[275176] = "Облягальні штани загону реагування"
    t[275177] = "Вістря загону реагування"
    t[275178] = "Шнур загону реагування"
    t[275179] = "Манжети загону реагування"
    t[275180] = "Куртка загону реагування"
    t[275181] = "Чоботи загону реагування"
    t[275182] = "Наручні щитки загону реагування"
    t[275183] = "Маска загону реагування"
    t[275184] = "Штани загону реагування"
    t[275185] = "Наплічники загону реагування"
    t[275186] = "Пояс загону реагування"
    t[275187] = "Обв'язки загону реагування"
    t[275188] = "Кольчуга загону реагування"
    t[275189] = "Латні чоботи загону реагування"
    t[275190] = "Захвати загону реагування"
    t[275191] = "Шолом загону реагування"
    t[275192] = "Поножі загону реагування"
    t[275193] = "Наплічні щитки загону реагування"
    t[275194] = "Застібка загону реагування"
    t[275195] = "Пов'язки загону реагування"
    t[275196] = "Нагрудник загону реагування"
    t[275197] = "Великі чоботи загону реагування"
    t[275198] = "Латні рукавиці загону реагування"
    t[275199] = "Шолом загону реагування"
    t[275200] = "Латні поножі загону реагування"
    t[275201] = "Наплічники загону реагування"
    t[275202] = "Черес загону реагування"
    t[275203] = "Наручі загону реагування"
    t[275204] = "Топірець загону реагування"
    t[275205] = "Кукрі загону реагування"
    t[275206] = "Молот загону реагування"
    t[275207] = "Довгий меч загону реагування"
    t[275208] = "Бойова глефа загону реагування"
    t[275209] = "Довгий лук загону реагування"
    t[275210] = "Спис загону реагування"
    t[275211] = "Вістря загону реагування"
    t[275212] = "Фальшіон загону реагування"
    t[275213] = "Ліхтар загону реагування"
    t[275214] = "Великий щит загону реагування"
    t[275216] = "Леза фазового клинка"
    t[275217] = "Фазовий клинок капітана вузла"
    t[275218] = "Командний жезл Мертеї"
    t[275219] = "Стрекало для звірів Пертінакса"
    t[275220] = "Шабля імператора з лезом Порожнечі"
    t[275221] = "Кийок збирача звірів"
    t[275222] = "Стинач голів командира бази"
    t[275223] = "Метач фазових болтів"
    t[275224] = "Ад'ютантські поножі Мертеї"
    t[275225] = "Токсичні наплічники коси Порожнечі"
    t[275226] = "Рукавиці приборкувача роздиракігтя"
    t[275227] = "Парадні сабатони Лет'іра"
    t[275228] = { name = "Туманний сховок Порожнечі: Гнилобагно", fen = "Transmute two Nebulous Voidcores into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює два туманні ядра Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[275256] = "Зразок із крон дерев"
    t[275257] = "Есенція манакузні"
    t[275258] = "Котлети з Отруйними Прянощами"
    t[275259] = "Ситні Котлети з Отруйними Прянощами"
    t[275260] = "Тарілка з Рибою-Кулею"
    t[275261] = "Кисло-Солодкі Шпажки"
    t[275262] = "Ситна Страва з Риби-Кулі"
    t[275263] = "Ситні Кисло-Солодкі Шпажки"
    t[275264] = "Ріг Достатку Амані"
    t[275265] = "Збір Лоа"
    t[275266] = "Бенкет Знань"
    t[275267] = "Ситний Ріг Достатку Амані"
    t[275268] = "Ситний Збір Лоа"
    t[275269] = "Ситний Бенкет Знань"
    t[275271] = { name = "Рецепт: Відбивні, Приправлені Отрутою", fen = "Teaches you how to craft Venom-Spiced Cutlets.", fua = "Навчає вас виготовляти відбивні, приправлені отрутою." }
    t[275273] = { name = "Рецепт: Кисло-Солодкі Шпажки", fen = "Teaches you how to craft a Sweet-And-Sour Skewers.", fua = "Навчає тебе виготовляти Кисло-Солодкі Шпажки." }
    t[275275] = { name = "Рецепт: Фальшиві Бризки Отрути", fen = "Teaches you how to craft Ersatz Venom Splatter.", fua = "Навчає тебе виготовляти Фальшиві Бризки Отрути." }
    t[275280] = { name = "Бік Дичини", fen = "Salvaging this using the Cooking skill may be useful. Can be bought and sold on the Auction House.", fua = "Можливо, варто переробити це за допомогою навички кулінарії. Можна купувати й продавати на Аукціоні." }
    t[275281] = { name = "Складене Крило", fen = "Salvaging this using the Cooking skill may be useful. Can be bought and sold on the Auction House.", fua = "Можливо, варто переробити це за допомогою навички кулінарії. Можна купувати й продавати на Аукціоні." }
    t[275282] = { name = "Гладка Вирізка", fen = "Salvaging this using the Cooking skill may be useful. Can be bought and sold on the Auction House.", fua = "Можливо, варто переробити це за допомогою навички кулінарії. Можна купувати й продавати на Аукціоні." }
    t[275283] = { name = "Шматок Земноводного", fen = "Salvaging this using the Cooking skill may be useful. Can be bought and sold on the Auction House.", fua = "Можливо, варто переробити це за допомогою навички кулінарії. Можна купувати й продавати на Аукціоні." }
    t[275284] = { name = "Слинявий Язик", fen = "Salvaging this using the Cooking skill may be useful. Can be bought and sold on the Auction House.", fua = "Можливо, варто переробити це за допомогою навички кулінарії. Можна купувати й продавати на Аукціоні." }
    t[275285] = { name = "Гнучкий Корінь", fen = "Salvaging this using the Cooking skill may be useful. Can be bought and sold on the Auction House.", fua = "Можливо, варто переробити це за допомогою навички кулінарії. Можна купувати й продавати на Аукціоні." }
    t[275286] = { name = "Листяний Відросток", fen = "Salvaging this using the Cooking skill may be useful. Can be bought and sold on the Auction House.", fua = "Можливо, варто переробити це за допомогою навички кулінарії. Можна купувати й продавати на Аукціоні." }
    t[275287] = { name = "Клітинний Шмат", fen = "Salvaging this using the Cooking skill may be useful. Can be bought and sold on the Auction House.", fua = "Можливо, варто переробити це за допомогою навички кулінарії. Можна купувати й продавати на Аукціоні." }
    t[275288] = { name = "Фотосинтезований Клапоть", fen = "Salvaging this using the Cooking skill may be useful. Can be bought and sold on the Auction House.", fua = "Можливо, варто переробити це за допомогою навички кулінарії. Можна купувати й продавати на Аукціоні." }
    t[275289] = { name = "Крилате Стебло", fen = "Salvaging this using the Cooking skill may be useful. Can be bought and sold on the Auction House.", fua = "Можливо, варто переробити це за допомогою навички кулінарії. Можна купувати й продавати на Аукціоні." }
    t[275300] = { name = "Рецепт: Збір Лоа", fen = "Teaches you how to craft Loa's Gathering.", fua = "Навчає тебе виготовляти Збір Лоа." }
    t[275301] = { name = "Рецепт: Бенкет Знань", fen = "Teaches you how to craft Feast of Knowledge.", fua = "Навчає тебе виготовляти Бенкет Знань." }
    t[275302] = { name = "Кривавий Дрейк Отруйного Гладіатора", fen = "Teaches you how to summon this mount. This mount changes depending on your Riding skill and location.", fua = "Навчає вас прикликати цього їздового звіра. Цей звір змінюється залежно від вашого вміння верхової їзди та місцеперебування." }
    t[275304] = { name = "Креслення: Верстак Майстра-Коваля Амані", fen = "Teaches you how to craft an Amani Forgemaster's Workbench.", fua = "Навчає вас виготовляти Верстак Майстра-Коваля Амані." }
    t[275306] = { name = "Креслення: Декоративний Спис Майстра-Коваля Амані", fen = "Teaches you how to craft an Amani Forgemaster's Decorative Spear.", fua = "Навчає вас виготовляти Декоративний Спис Майстра-Коваля Амані." }
    t[275308] = { name = "Креслення: Стійка Майстра-Коваля Амані", fen = "Teaches you how to craft an Amani Forgemaster's Rack.", fua = "Навчає вас виготовляти Стійку Майстра-Коваля Амані." }
    t[275310] = { name = "Формула: Гостра Маска Вроків", fen = "Teaches you how to craft a Keen Hex Mask.", fua = "Навчає тебе виготовляти Гостру Маску Прокляття." }
    t[275312] = { name = "Формула: Люта Маска Тікі", fen = "Teaches you how to craft a Furious Tiki Mask.", fua = "Навчає тебе виготовляти Люту Маску Тікі." }
    t[275314] = { name = "Формула: Зачарована Риба з Криниці Порожнечі", fen = "Teaches you how to craft an Enchanted Voidwell Fish.", fua = "Навчає тебе виготовляти Зачаровану Рибу з Криниці Порожнечі." }
    t[275316] = { name = "Креслення: Змотаний Аманійський Гак", fen = "Teaches you how to craft a Coiled Amani Hookshot.", fua = "Навчає вас виготовляти змотаний аманійський гак." }
    t[275318] = { name = "Креслення: Корабель у Пляшці Праудмурів", fen = "Teaches you how to craft a Proudmoore Ship-in-a-Bottle.", fua = "Навчає вас виготовляти корабель у пляшці Праудмурів." }
    t[275320] = { name = "Креслення: Польова Лампа з Етерлуму", fen = "Teaches you how to craft an Aetherlume Field Lamp.", fua = "Навчає вас виготовляти польову лампу з етерлуму." }
    t[275324] = { name = "Техніка: Фреска «Проклятий Погляд Ула'тек»", fen = "Teaches you how to craft a \"Cursed Gaze of Ula'tek\" Mural.", fua = "Навчає тебе виготовляти фреску «Проклятий Погляд Ула'тек»." }
    t[275326] = { name = "Техніка: Різьблена Табличка Амані", fen = "Teaches you how to craft a Chiseled Amani Tablet.", fua = "Навчає тебе виготовляти різьблену табличку амані." }
    t[275332] = { name = "Викрійка: Плаский Навіс зі Зміїної Шкіри", fen = "Teaches you how to craft a Flat Snakeskin Canopy.", fua = "Навчає вас виготовляти Плаский Навіс зі Зміїної Шкіри." }
    t[275334] = { name = "Викрійка: Стійка з Натягнутою Зміїною Шкірою", fen = "Teaches you how to craft a Stretched Snakeskin Rack.", fua = "Навчає вас виготовляти Стійку з Натягнутою Зміїною Шкірою." }
    t[275336] = { name = "Викрійка: Опудало Мобі", fen = "Teaches how to craft a Mounted Moby.", fua = "Навчає виготовляти Опудало Мобі." }
    t[275338] = { name = "Викрійка: Похідна Постіль Клинка Сутінків", fen = "Teaches you how to craft Twilight's Blade Bedroll.", fua = "Навчає вас виготовляти Похідну Постіль Клинка Сутінків." }
    t[275342] = { name = "Викрійка: Тортоланська Заплічна Торба", fen = "Teaches you how to craft a Tortollan Slingsack.", fua = "Навчає вас виготовляти Тортоланську Заплічну Торбу." }
    t[275380] = { name = "Геральдика Отруйного Бійця", fen = "Acquired from various PvP activities or purchased with Honor from PvP quartermasters in Silvermoon. Can be bought and sold on the Auction House.", fua = "Здобувається в різних PvP-активностях або купується за честь у PvP-інтендантів у Сільвермуні. Можна купувати та продавати на аукціоні." }
    t[275383] = { name = "Геральдика Отруйного Претендента", fen = "Purchased with Honor from PvP quartermasters in Silvermoon.", fua = "Купується за честь у PvP-інтендантів у Сільвермуні." }
    t[275385] = { name = "Геральдика Отруйного Гладіатора", fen = "Purchased with Conquest from PvP quartermasters in Silvermoon.", fua = "Купується за Завоювання в інтендантів PvP у Сільвермуні." }
    t[275391] = { name = "Дешифрувач даних Світлозавіси", fen = "The handheld crystal gleams with Lightforged runes.", fua = "Кристал у долоні сяє загартованими Світлом рунами." }
    t[275432] = { name = "Лютий Вепр Світлоцвіту", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[275433] = { name = "Лютий Вепр Світлоцвіту", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[275477] = { name = "Головідбиток нуль-каркаса", fen = "Detailed 3D schematics and building notes on something called \"Project Nullframe\" flicker across the holoprint.", fua = "На голограмі мерехтять докладні об'ємні схеми та нотатки до будівництва чогось під назвою «Проєкт Нуль-Каркас»." }
    t[275488] = "Полірована Бригантина Мисливця за Здобиччю"
    t[275489] = "Полірований Широкий Пояс Мисливця за Здобиччю"
    t[275490] = "Поліровані Важкі Чоботи Мисливця за Здобиччю"
    t[275491] = "Поліровані Рукавиці Мисливця за Здобиччю"
    t[275492] = "Полірований Шолом Мисливця за Здобиччю"
    t[275493] = "Поліровані Наплічники Мисливця за Здобиччю"
    t[275494] = "Поліровані Стегнові Щитки Мисливця за Здобиччю"
    t[275495] = "Поліровані Наручі Мисливця за Здобиччю"
    t[275496] = "Витончений Пояс Мисливця за Здобиччю"
    t[275497] = "Витончений Вінець Мисливця за Здобиччю"
    t[275498] = "Витончені Манжети Мисливця за Здобиччю"
    t[275499] = "Витончений Еполет Мисливця за Здобиччю"
    t[275500] = "Витончені Рукавички Мисливця за Здобиччю"
    t[275501] = "Витончені Капці Мисливця за Здобиччю"
    t[275502] = "Витончені Рейтузи Мисливця за Здобиччю"
    t[275503] = "Витончені Шати Мисливця за Здобиччю"
    t[275504] = "Міцні Наручі Мисливця за Здобиччю"
    t[275505] = "Міцна Застібка Мисливця за Здобиччю"
    t[275506] = "Міцні Рукавиці Мисливця за Здобиччю"
    t[275507] = "Міцна Кольчуга Мисливця за Здобиччю"
    t[275508] = "Міцні Поножі Мисливця за Здобиччю"
    t[275509] = "Міцний Плюмаж Мисливця за Здобиччю"
    t[275510] = "Міцні Сабатони Мисливця за Здобиччю"
    t[275511] = "Міцні Наплічники Мисливця за Здобиччю"
    t[275512] = "Гладкі Наручі Мисливця за Здобиччю"
    t[275513] = "Гладкий Пояс Мисливця за Здобиччю"
    t[275514] = "Гладкі Чоботи Мисливця за Здобиччю"
    t[275515] = "Гладкі Рукавиці Мисливця за Здобиччю"
    t[275516] = "Гладка Куртка Мисливця за Здобиччю"
    t[275517] = "Гладка Маска Мисливця за Здобиччю"
    t[275518] = "Гладкі Наплічники Мисливця за Здобиччю"
    t[275519] = "Гладкі Штани Мисливця за Здобиччю"
    t[275520] = { name = "Повідомлення техновидця", fen = "A projected image of a rotating Lightforged Warframe emits from the device.", fua = "Із пристрою постає спроектоване зображення загартованого Світлом бойового панцира, що обертається." }
    t[275522] = "Витончена Шаль Мисливця за Здобиччю"
    t[275523] = "Гладка Пелерина Мисливця за Здобиччю"
    t[275524] = "Міцний Палантин Мисливця за Здобиччю"
    t[275525] = "Полірований Плащ Мисливця за Здобиччю"
    t[275526] = "Перстень Мисливця за Здобиччю"
    t[275527] = "Перстень-Печатка Мисливця за Здобиччю"
    t[275528] = "Перстень Мисливця за Здобиччю"
    t[275529] = "Каблучка Мисливця за Здобиччю"
    t[275530] = "Застібка Мисливця за Здобиччю"
    t[275531] = "Намисто Мисливця за Здобиччю"
    t[275532] = "Сокирка Мисливця за Здобиччю"
    t[275533] = "Кукрі Мисливця за Здобиччю"
    t[275534] = "Заточка Мисливця за Здобиччю"
    t[275535] = "Кий Мисливця за Здобиччю"
    t[275536] = "Скіпетр Мисливця за Здобиччю"
    t[275537] = "Молот Мисливця за Здобиччю"
    t[275538] = "Ятаган Мисливця за Здобиччю"
    t[275539] = "Ритуальний Клинок Мисливця за Здобиччю"
    t[275540] = "Довгий Меч Мисливця за Здобиччю"
    t[275541] = "Бойова Глефа Мисливця за Здобиччю"
    t[275542] = "Довгий Лук Мисливця за Здобиччю"
    t[275543] = "Спис Мисливця за Здобиччю"
    t[275544] = "Посох Мисливця за Здобиччю"
    t[275545] = "Вістря Мисливця за Здобиччю"
    t[275546] = "Фальшіон Мисливця за Здобиччю"
    t[275547] = "Ліхтар Мисливця за Здобиччю"
    t[275548] = "Великий Щит Мисливця за Здобиччю"
    t[275632] = { name = "Нестабільний Отрутозуб", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[275634] = { name = "Листівка Консорціуму майстрів", fen = "A notice promoting a special giveaway in Falconwing Square.", fua = "Оголошення про особливу роздачу на Соколиній площі." }
    t[275652] = { name = "Багряний Отрутозуб", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[275653] = { name = "Морський Острівний Змій", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[275654] = { name = "Їдкий Отрутозуб", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[275655] = { name = "Отруйний Змій - Білий", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[275656] = { name = "Золотоносний Отрутозуб", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[275657] = { name = "Апофічний Трощитель Душ", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[275658] = { name = "Прадавній Небесний Друг", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[275659] = { name = "Спустошувач Чарополум'я", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[275660] = { name = "Лють Мисливця за Здобиччю", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[275662] = { name = "Фростикус Максимус", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[275663] = { name = "Силенто", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[275667] = "Серпанкотворець"
    t[275676] = "R0CKY на Виніс"
    t[275683] = "СЛИ3"
    t[275684] = { name = "Креслення: СЛИ3", fen = "Teaches you how to craft G-00.", fua = "Навчає вас виготовляти СЛИ3." }
    t[275686] = { name = "Розшифрована сфера відомостей", fen = "A flurry of projected images, alien letters, and other information churns within the energy sphere.", fua = "Вихор спроєктованих образів, чужинських літер та іншої інформації клекоче всередині енергетичної сфери." }
    t[275687] = { name = "Головідбиток ґратки душ", fen = "Shimmering runes and 3D projections of something called a \"Soul Lattice\" flickers across the holoprint.", fua = "На голограмі мерехтять мінливі руни та об'ємні проєкції чогось під назвою «Ґратка Душ»." }
    t[275689] = { name = "Голограма Мерехтливої крипти", fen = "A flickering 3D overlay of a non-ethereal structure shimmers across the holoprint.", fua = "На голограмі мерехтить хитлива об'ємна проєкція неефірної споруди." }
    t[275690] = { name = "Схованка переслідувача Розломів", fen = "Cache containing Field Accolades, Relic Coffer Key shards, materials for upgrading gear, gold, and more.", fua = "Схованка з польовими відзнаками, уламками ключа від реліквієвої скрині, матеріалами для вдосконалення спорядження, золотом тощо." }
    t[275691] = { name = "Переповнена схованка переслідувача Розломів", fen = "Cache containing Field Accolades, Relic Coffer Key shards, Myth Dawncrests, gold, and more. Will contain items from the Riftstalker's Cache if not already claimed.", fua = "Схованка з польовими відзнаками, уламками ключа від скрині реліквій, міфічними світанковими гербами, золотом та іншим. Міститиме предмети зі Схованки розломного переслідувача, якщо їх ще не забрано." }
    t[275693] = { name = "Креслення: Опалесцентний Перидот Амані", fen = "Teaches you how to craft an Opalescent Amani Peridot.", fua = "Навчає тебе виготовляти опалесцентний перидот амані." }
    t[275695] = { name = "Креслення: Пронизливий Лазурит Амані", fen = "Teaches you how to craft a Piercing Amani Lapis.", fua = "Навчає тебе виготовляти пронизливий лазурит амані." }
    t[275697] = { name = "Креслення: Ревучий Гранат Амані", fen = "Teaches you how to craft a Roaring Amani Garnet.", fua = "Навчає тебе виготовляти ревучий гранат амані." }
    t[275699] = { name = "Звіт Вераана про душевну ґратку", fen = "The bundle of scrolls gleams with the arcane-laced ink of the ethereals.", fua = "Стос сувоїв мерехтить просякнутим арканом чорнилом ефіріалів." }
    t[275702] = { name = "Призмовий Вартовий Мисливця за Здобиччю", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[275704] = { name = "Розломолам Мисливця за Здобиччю", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[275707] = "Міазматичний Самоцвітов'яз"
    t[275726] = { name = "Скриня Мисливця за Здобиччю для Чемпіона", fen = "A chest containing a piece of Champion equipment, supplies, gold, and a chance for professions materials. Your first four Preyhunter's containers awarded by hunts a week also have a chance to include Corrosive Souls.", fua = "Скриня з предметом спорядження рівня Чемпіона, припасами, золотом і шансом на матеріали для професій. Перші чотири скрині чи мішки мисливця за здобиччю, здобуті за полювання протягом тижня, також можуть містити Роз'їдливі Душі." }
    t[275728] = { name = "Мішок Мисливця за Здобиччю для Чемпіона", fen = "A sack containing supplies, gold, and a chance for professions materials. Your first four Preyhunter's containers awarded by hunts a week also have a chance to include Corrosive Souls.", fua = "Мішок із припасами, золотом і шансом на матеріали для професій. Перші чотири скрині чи мішки мисливця за здобиччю, здобуті за полювання протягом тижня, також можуть містити Роз'їдливі Душі." }
    t[275822] = { name = "Ветеранська Скриня Мисливця за Здобиччю", fen = "A chest containing a piece of Veteran equipment, supplies, gold, and a chance for professions materials. Your first four Preyhunter's containers awarded by hunts a week also have a chance to include Corrosive Souls.", fua = "Скриня з предметом ветеранського спорядження, припасами, золотом і шансом на матеріали для професій. Перші чотири контейнери Мисливця за Здобиччю, здобуті за полювання протягом тижня, також мають шанс містити Роз'їдливі Душі." }
    t[275825] = "Жертовний Дощщщ Ула'тек"
    t[275899] = { name = "Просочена Отрутою Торба", fen = "Contains materials for upgrading gear, gold, and more.", fua = "Містить матеріали для покращення спорядження, золото й багато іншого." }
    t[275910] = { name = "Маяк надії", fen = "A small yet immensely potent source of light. So much so that its glow is said to shine through into the Void itself. Unfortunately, its denizens can see it too, and they will act to obscure it.", fua = "Маленьке, та неймовірно потужне джерело світла. Настільки, що його сяйво, як кажуть, пробивається аж у саму Порожнечу. На жаль, її мешканці теж його бачать — і робитимуть усе, щоб його затьмарити." }
    t[275911] = { name = "Вкрита Отрутою Скриня", fen = "Weekly cache containing materials for upgrading equipment, gold, coffer key shards, and more.\n\nThe first two pinnacle caches you earn each week contain a piece of Veteran equipment.", fua = "Щотижнева скриня з матеріалами для покращення спорядження, золотом, уламками ключів від скриньок і не тільки.\n\nПерші дві вершинні скрині, які ви здобуваєте щотижня, містять предмет спорядження ветерана." }
    t[275917] = { name = "Ветеранський Мішок Мисливця за Здобиччю", fen = "A sack containing supplies, gold, and a chance for professions materials. Your first four Preyhunter's containers awarded by hunts a week also have a chance to include Corrosive Souls.", fua = "Мішок із припасами, золотом і шансом на матеріали для професій. Перші чотири скрині чи мішки мисливця за здобиччю, здобуті за полювання протягом тижня, також можуть містити Роз'їдливі Душі." }
    t[275918] = { name = "Скриня Мисливця за Здобиччю для Шукача Пригод", fen = "A chest containing a piece of Adventurer equipment, supplies, gold, and a chance for professions materials. Your first four Preyhunter's containers awarded by hunts a week also have a chance to include Corrosive Souls.", fua = "Скриня з предметом спорядження рівня Шукача Пригод, припасами, золотом і шансом на матеріали для професій. Перші чотири скрині чи мішки мисливця за здобиччю, здобуті за полювання протягом тижня, також можуть містити Роз'їдливі Душі." }
    t[275919] = { name = "Мішок Мисливця за Здобиччю для Шукача Пригод", fen = "A sack containing supplies, gold, and a chance for professions materials. Your first four Preyhunter's containers awarded by hunts a week also have a chance to include Corrosive Souls.", fua = "Мішок із припасами, золотом і шансом на матеріали для професій. Перші чотири скрині чи мішки мисливця за здобиччю, здобуті за полювання протягом тижня, також можуть містити Роз'їдливі Душі." }
    t[275920] = { name = "Потьмяніла Глефа Амані", fen = "A warrior's glaive, well-worn through battle and no longer fit for use.", fua = "Глефа воїна, добряче зношена в боях і вже непридатна до вжитку." }
    t[275936] = "Глибинобот 7001: Чип Програмного Оновлення Опівночі"
    t[275937] = "Лик Володаря Вроків"
    t[275938] = "Погляд Володаря Вроків"
    t[275978] = "Початковий набір дослідника Глибин"
    t[275986] = "Косметична торба-сюрприз дослідника Глибин"
    t[275988] = "Роз'їдлива Перемога"
    t[276000] = "Кам'яношкірі Наручі"
    t[276001] = "Наручі Небокіготя"
    t[276002] = "Тіньокіготні Наручі"
    t[276003] = "Наручі Вогнедзьоба"
    t[276004] = "Кам'яношкірі Латні Чоботи"
    t[276005] = "Чоботи Небокіготя"
    t[276006] = "Тіньокіготні Чоботи"
    t[276007] = "Сандалі Вогнедзьоба"
    t[276008] = "Кам'яношкірі Латні Рукавиці"
    t[276009] = "Рукавички Небокіготя"
    t[276010] = "Тіньокіготні Рукавиці"
    t[276011] = "Рукавиці Вогнедзьоба"
    t[276012] = "Кам'яношкірий Нагрудник"
    t[276013] = "Кольчуга Небокіготя"
    t[276014] = "Тіньокіготна Куртка"
    t[276015] = "Роба Вогнедзьоба"
    t[276016] = "Кам'яношкірий Шолом"
    t[276017] = "Шолом Небокіготя"
    t[276018] = "Тіньокіготний Головний Убір"
    t[276019] = "Вінець Вогнедзьоба"
    t[276020] = "Кам'яношкірі Наплічники"
    t[276021] = "Наплічники Небокіготя"
    t[276022] = "Тіньокіготні Наплічники"
    t[276023] = "Оплічник Вогнедзьоба"
    t[276024] = "Кам'яношкірі Поножі"
    t[276025] = "Штани Небокіготя"
    t[276026] = "Тіньокіготні Поножі"
    t[276027] = "Поножі Вогнедзьоба"
    t[276028] = "Кам'яношкірий Пояс"
    t[276029] = "Пояс Небокіготя"
    t[276030] = "Тіньокіготний Пояс"
    t[276031] = "Пояс Вогнедзьоба"
    t[276032] = "Намисто Лихої Ворожби"
    t[276033] = "Амулет Вартового Лоа"
    t[276034] = "Перстень Обплутувального Виводку"
    t[276035] = "Перстень-Печатка Душезвія"
    t[276036] = "Перстень Вічного Стискання"
    t[276037] = "Вінець Протипрокляття"
    t[276038] = "Плащ Небокіготя"
    t[276039] = "Накидка Вогнедзьоба"
    t[276040] = "Тіньокіготний Покрив"
    t[276041] = "Кам'яношкірий Плащ"
    t[276043] = "Кадило Лихоікла"
    t[276044] = "Насичений Лоа Бойовий Посох"
    t[276045] = "Клинок Душі Першопрохідця"
    t[276046] = "Трощитель із Суперзахватом"
    t[276047] = "Болотяне Гупало"
    t[276048] = "Кинджал Погибелі Гадюк"
    t[276049] = "Клеймор Змієвбивці"
    t[276050] = "Переможний Духовний Посох"
    t[276051] = "Іклопащий Бойовий Спис"
    t[276052] = "Великий Лук Отруйного Пострілу"
    t[276053] = "Бойова Глефа Мисливця на Змій"
    t[276054] = "Змієлозове Мачете"
    t[276055] = "Проклятий Клинок Душеткача"
    t[276057] = "Скіпетр, Прив'язаний до Склепу"
    t[276058] = "Згубний Змієріз"
    t[276059] = "Рубач Мисливця за Головами"
    t[276060] = "Вибуховий Жезл Ворожбита"
    t[276061] = "Кровопускач Знахаря"
    t[276062] = "Рубач Ший Гідри"
    t[276089] = "Польові відзнаки"
    t[276090] = "Польові відзнаки"
    t[276091] = "Покинута зброя"
    t[276092] = "Покинута зброя"
    t[276093] = "Капітан вузла Лет'ір"
    t[276094] = "Капітан вузла Лет'ір"
    t[276095] = "Імператор Пертінакс"
    t[276096] = "Імператор Пертінакс"
    t[276097] = "Покинута зброя"
    t[276098] = "Предмети з рейдів"
    t[276104] = { name = "Скриня Завзятого Мисливця за Здобиччю", fen = "A chest containing a piece of leveling equipment, supplies, gold, and a chance for professions materials. Your first four Preyhunter's containers awarded by hunts a week also include Corrosive Souls.", fua = "Скриня з предметом спорядження для прокачування, припасами, золотом і шансом на матеріали для професій. Перші чотири скрині мисливця за здобиччю, здобуті за полювання протягом тижня, містять також Роз'їдливі душі." }
    t[276117] = { name = "Каламутна Кривава Перлина", fen = "Once brilliant red, the surface of this pearl has clouded over with... something. Ofi may be interested in its latent magical properties.", fua = "Колись яскраво-червона, поверхня цієї перлини затьмарилася... чимось. Офі можуть зацікавити її приховані магічні властивості." }
    t[276124] = { name = "Прадавня Гральна Кістка", fen = "Once used to tell the future. Ofi may be interested in its latent magical properties.", fua = "Колись цим віщували майбутнє. Офі може зацікавитися прихованими магічними властивостями цієї речі." }
    t[276126] = { name = "Зміїне Перо", fen = "For many, this vibrant plumage is the last they see before being devoured. Ofi may be interested in its latent magical properties.", fua = "Для багатьох це яскраве оперення — останнє, що вони бачать, перш ніж їх зжеруть. Офі може зацікавитись його прихованими магічними властивостями." }
    t[276135] = "Блювотний Засіб Дезі"
    t[276142] = { name = "Роз'їдливий Кодекс", fen = "A miasmic aura clings to the scroll, which contains notes on forbidden Corrosive spells.", fua = "Сувій огортає міазматична аура; у ньому — нотатки про заборонені Роз'їдливі закляття." }
    t[276144] = { name = "Перлина Радощів", fen = "A faint sound of clacking claws can be heard.", fua = "Чути ледь уловимий стукіт клешень." }
    t[276162] = { name = "Роз'їдений Трощитель Душ", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[276163] = "Апофічна Патагія"
    t[276164] = "Роз'їдена Патагія"
    t[276165] = "Офідійська Патагія"
    t[276166] = "Двоголовий Парний Клинок"
    t[276167] = "Спис Орі'кассі"
    t[276168] = "Ікло Сс'акрітоса"
    t[276169] = "Спотворений Бар'єр"
    t[276171] = "Офідійська Каблучка"
    t[276172] = "Головний Убір Мутагенезу"
    t[276173] = "Сандалі Вартового Кладки"
    t[276174] = "Сочливі Лускаті Обладунки Левіафана"
    t[276175] = "Обійми Матері Виводку"
    t[276178] = "Латні Рукавиці Отруйного Списника"
    t[276186] = { name = "Цілком Не Крадений Порох", fen = "Ignore the admiralty stamps on the barrel. It was...recycled. Definitely.", fua = "Не зважай на адміралтейські штампи на бочці. Її... переробили. Точно." }
    t[276187] = "Отруйна Ювелірна Оправа"
    t[276189] = "Подоба Дундуна"
    t[276198] = { name = "195 Шеллмена", fen = "Strong enough to melt the beard off a dwarf.", fua = "Таке міцне, що й бороду дворфові розплавить." }
    t[276205] = { name = "Законна Партія Поворотних Гармат", fen = "All manner of makes and models. Curiously, all of the makers' marks seem to have been filed off.", fua = "Усіх можливих марок і моделей. Цікаво, що всі клейма виробників, схоже, сточено." }
    t[276206] = { name = "Законно Здобуті Гарматні Ядра", fen = "From solid shot to explosive shells, there's enough firepower here to shiver the timbers of even the scurviest scallywag.", fua = "Від суцільних ядер до розривних снарядів — вогневої сили тут досить, щоб затрусило навіть найпаршивішого шибеника." }
    t[276207] = "Маскарад Мисливця за Здобиччю"
    t[276229] = "Підставка під Трофей Мисливця за Здобиччю"
    t[276234] = { name = "Барвистий Отрутозуб", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[276248] = { name = "Снек'залі", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[276249] = "Плащ Гаш'ури"
    t[276250] = "Накидка Гаш'ури"
    t[276251] = "Наплічники Гаш'ура"
    t[276255] = { name = "Забута меморіальна шана", fen = "A cherished tribute left long ago by the loved ones of those interred within Vilaldoun.", fua = "Дорогоцінна шана, залишена давним-давно близькими тих, хто похований у Вілалдоуні." }
    t[276258] = "Командний Кристал Супутника"
    t[276276] = "Манаспора"
    t[276285] = "Меч Захисника Елоната"
    t[276286] = { name = "Вузлувате Серце", fen = "A freshly extracted gnarldin heart, still warm and beating faintly.", fua = "Щойно вирване серце корчедіна — ще тепле й ледь-ледь б'ється." }
    t[276288] = "Забутий меч Вілалдоуна"
    t[276289] = "Аргунітовий клинок Світлозавіси"
    t[276290] = "Круп'яний клинок крижаного вартового"
    t[276292] = "Маяк давнього анахорета"
    t[276293] = "Маяк прив'язі Світлозавіси"
    t[276296] = "Руків'я солтіанського приборкувача"
    t[276297] = { name = "Реактивний Ранець Іржоболта", fen = "Tailored for Neighborhood and House use only.", fua = "Створений лише для використання в Сусідстві та Домі." }
    t[276298] = "Забутий пазур зі скверноскалки"
    t[276299] = "Душевний молот тінявого вартового"
    t[276300] = "Скіпетр анахорета Вілалдоуна"
    t[276301] = "Кристалевий маяк зі світлорунами"
    t[276302] = "Булава кристалокова з Таалвілора"
    t[276303] = "Благословенний клинок Таалвілора"
    t[276304] = "Благословенний аргунітовий бойовий клинок"
    t[276330] = "Зоряний шип викраденого ходака Розломів"
    t[276331] = "Сяйноспис Авангарду Світла"
    t[276342] = { name = "Розколота ґратка душі", fen = "Although most of it is damaged, the crystalline core in the center frame flickers with a faint energy pulse.", fua = "Хоча здебільшого вона пошкоджена, кристалічне ядро в центрі мерехтить слабким пульсом енергії." }
    t[276343] = { name = "Ключ шифрування консолі", fen = "The key appears to have an encryption sequence of its own.", fua = "Здається, ключ має власну послідовність шифрування." }
    t[276344] = { name = "Зарослий споровидобувач", fen = "Various forms of fungi have begun to grow on the outer casing of the device.", fua = "На зовнішньому корпусі пристрою почали проростати найрізноманітніші гриби." }
    t[276345] = { name = "Несправний головідбиток", fen = "The holoprint is quite unreadable as warped projections and random rune flicker across the screen.", fua = "Головідбиток цілком нечитабельний: спотворені проєкції й випадкові руни мерехтять на екрані." }
    t[276346] = { name = "Обпалений Скверною мотлох", fen = "A twisted metal scrap once belonging to some part of a Legion vessel.", fua = "Покручений уламок металу, що колись був частиною судна Легіону." }
    t[276347] = { name = "Тріснутий Комунікатор Легіону", fen = "For a moment you're sure you can hear a voice emitting from the defunct device.", fua = "На мить ти певен, що чуєш голос, який лине зі зламаного пристрою." }
    t[276348] = { name = "Лозобатіг болотного приборкувача", fen = "Strange alien letters are carved into the base of the whip.", fua = "На руків'ї батога вирізьблені дивні чужорідні літери." }
    t[276349] = { name = "Бульбастий лейгриб", fen = "The bulb-like mushroom glows with a faint arcane light.", fua = "Цибулинуватий гриб світиться слабким арканним сяйвом." }
    t[276350] = { name = "Мерехтливі водорості", fen = "Tiny flecks of energy cling to the algae.", fua = "Дрібнесенькі цяточки енергії чіпляються до водоростей." }
    t[276351] = { name = "Кришталева фігурка, вицвіла від твані", fen = "The details and etchings once carved into the figure have been eroded away by the swamp mud.", fua = "Деталі та різьблення, колись викарбувані на фігурці, стерті болотяною твань'ю." }
    t[276352] = { name = "Подряпаний молитовний браслет", fen = "The prayer runes carved into the bracelet have been eroded away by years of swamp water.", fua = "Молитовні руни, вирізьблені на браслеті, стерлися за роки в болотній воді." }
    t[276353] = { name = "Замерзла скалка темряви", fen = "A single sliver of pure Void energy appears to be imprisoned within the ice.", fua = "Єдина скалка чистої енергії Порожнечі, здається, ув'язнена в кризі." }
    t[276354] = { name = "Замерзле ядро Скверни", fen = "Once used to power the Legion's war machines, the core is now cold and lifeless.", fua = "Колись ним живили бойові машини Легіону, та нині воно холодне й неживе." }
    t[276355] = { name = "Розбите морозокуте руків'я", fen = "Forged, honed, and shattered in the frozen valleys of Val long ago.", fua = "Викуто, нагострено й розбито в замерзлих долинах Валу давним-давно." }
    t[276356] = { name = "Морозом пошматований плащ демона", fen = "This cloak did little to protect its owner from the ice storms of Val.", fua = "Цей плащ мало захищав свого власника від крижаних бур Валі." }
    t[276357] = { name = "Гострольодова сніжинка", fen = "\"If the cold winds don't kill you, the dagger-sized ice flakes will.\" - A Demon's Guide to Surviving Val.", fua = "«Якщо тебе не вб'ють холодні вітри, це зроблять крижані пластівці завбільшки з кинджал.» — Демонів довідник із виживання на Валі." }
    t[276358] = { name = "Розбитий тінещеп", fen = "Once used to control and bend the mind of its wearer.", fua = "Колись слугувала для того, щоб керувати розумом носія й гнути його волю." }
    t[276359] = { name = "Спотворена зброя доманаарів", fen = "Lifeless and cold to the touch.", fua = "Неживий і холодний на дотик." }
    t[276360] = { name = "Гравірований крижаний осколок", fen = "Strange symbols have been etched deep into the ice.", fua = "Дивні символи глибоко викарбувані в кризі." }
    t[276361] = { name = "Затверділі від інею рештки", fen = "The unidentifiable frozen remains of... something that perished on Val.", fua = "Невпізнанні замерзлі рештки... чогось, що загинуло на Валі." }
    t[276362] = { name = "Загублені гаки для сходження на льодовик", fen = "The glacial cave systems of Val are impossible to traverse without some stabilization.", fua = "Льодовикові печери Валу неможливо подолати без надійного закріплення." }
    t[276364] = "Арсенал: загартована Світлом зброя"
    t[276365] = { name = "Високогірний червоноголовець", fen = "A terrible stench to wake even the dead emanates from this mushroom.", fua = "Від цього гриба йде жахливий сморід, що здатний підняти й мертвих." }
    t[276366] = { name = "Запорошена Червоноголовка", fen = "A terrible stench to wake even the dead emanates from this mushroom.", fua = "Від цього гриба йде жахливий сморід, що здатний підняти й мертвих." }
    t[276367] = { name = "Болотяна червоноголовка", fen = "A terrible stench to wake even the dead emanates from this mushroom.", fua = "Від цього гриба йде жахливий сморід, що здатний підняти й мертвих." }
    t[276368] = { name = "Напівперетравлена Червоношапка", fen = "A terrible stench to wake even the dead emanates from this mushroom.", fua = "Від цього гриба йде жахливий сморід, що здатний підняти й мертвих." }
    t[276369] = { name = "Легка червоноголовка", fen = "A terrible stench to wake even the dead emanates from this mushroom.", fua = "Від цього гриба йде жахливий сморід, що здатний підняти й мертвих." }
    t[276371] = { name = "Маяк Відкликання Світлозавіси", fen = "Recalls you back to the Umbral Base Camp on Val or Naigtal.", fua = "Повертає тебе до Тіньового базового табору на Валі чи Найґталі." }
    t[276372] = "Маяк Відкликання Світлозавіси"
    t[276373] = "Маяк Відкликання Світлозавіси"
    t[276374] = { name = "Зчитувач рун Світлозавіси", fen = "Lightforged symbols flicker across the glowing node.", fua = "Загартовані Світлом символи мерехтять на сяйливому вузлі." }
    t[276375] = { name = "Прозірна матриця техномага", fen = "Don't stare too long into the endless expanse of shimmering runic letters.", fua = "Не вдивляйся надто довго в безкраю широчінь мерехтливих рунічних літер." }
    t[276376] = { name = "Тіньовий смолоскип Скверни", fen = "The flame is just as warm as fel fire but not as bright.", fua = "Полум'я таке ж тепле, як вогонь Скверни, але не таке яскраве." }
    t[276377] = { name = "Мерехтливий тіньовий маяк", fen = "The soft glow of the crystal illuminates your path.", fua = "М'яке сяйво кристала освітлює твій шлях." }
    t[276378] = { name = "Сховок озброєння, торкнутого Порожнечею: чоботи", fen = "Contains a Heroic boot item for your Loot Specialization.", fua = "Містить геройські чоботи для вашої спеціалізації здобичі." }
    t[276379] = { name = "Сховок озброєння, торкнутого Порожнечею: ноги", fen = "Contains a Heroic leg item for your Loot Specialization.", fua = "Містить геройський набедреник для вашої спеціалізації здобичі." }
    t[276380] = { name = "Сховок озброєння, торкнутого Порожнечею: пояси", fen = "Contains a Heroic belt item for your Loot Specialization.", fua = "Містить геройський пояс для вашої спеціалізації здобичі." }
    t[276381] = { name = "Сховок озброєння, торкнутого Порожнечею: рукавиці", fen = "Contains a Heroic glove item for your Loot Specialization.", fua = "Містить геройські рукавиці для вашої спеціалізації здобичі." }
    t[276382] = { name = "Сховок озброєння, торкнутого Порожнечею: наручі", fen = "Contains a Heroic bracer item for your Loot Specialization.", fua = "Містить геройські наручі для вашої спеціалізації здобичі." }
    t[276383] = { name = "Сховок озброєння, торкнутого Порожнечею: нагрудник", fen = "Contains a Heroic chest item for your Loot Specialization.", fua = "Містить геройський нагрудник для вашої спеціалізації здобичі." }
    t[276384] = { name = "Сховок озброєння, торкнутого Порожнечею: плащ", fen = "Contains a Heroic cloak item for your Loot Specialization.", fua = "Містить геройський плащ для вашої спеціалізації здобичі." }
    t[276385] = { name = "Сховок озброєння, торкнутого Порожнечею: плечі", fen = "Contains a Heroic shoulder item for your Loot Specialization.", fua = "Містить геройський наплічник для вашої спеціалізації здобичі." }
    t[276386] = { name = "Сховок озброєння, торкнутого Порожнечею: голова", fen = "Contains a Heroic head item for your Loot Specialization.", fua = "Містить геройський головний убір для вашої спеціалізації здобичі." }
    t[276387] = { name = "Прихильність переслідувача Розломів", fen = "Cache containing Field Accolades, Relic Coffer Key shards, materials for upgrading gear, gold, and more.", fua = "Схованка з польовими відзнаками, уламками ключа від реліквієвої скрині, матеріалами для вдосконалення спорядження, золотом тощо." }
    t[276388] = { name = "Переповнена прихильність переслідувача Розломів", fen = "Cache containing Field Accolades, Relic Coffer Key shards, Myth Dawncrests, gold, and more. Will contain items from the Riftstalker's Favor if not already claimed.", fua = "Схованка з польовими відзнаками, уламками ключа від реліквієвої скрині, міфічними світанковими гербами, золотом тощо. Міститиме предмети з прихильності переслідувача Розломів, якщо їх ще не отримано." }
    t[276389] = { name = "Винагорода переслідувача Розломів", fen = "Cache containing Field Accolades, Relic Coffer Key shards, materials for upgrading gear, gold, and more.", fua = "Схованка з польовими відзнаками, уламками ключа від реліквієвої скрині, матеріалами для вдосконалення спорядження, золотом тощо." }
    t[276390] = { name = "Переповнена винагорода переслідувача Розломів", fen = "Cache containing Field Accolades, Relic Coffer Key shards, Myth Dawncrests, gold, and more. Will contain items from the Riftstalker's Prize if not already claimed.", fua = "Схованка з польовими відзнаками, уламками ключа від реліквієвої скрині, міфічними світанковими гербами, золотом тощо. Міститиме предмети з винагороди переслідувача Розломів, якщо їх ще не отримано." }
    t[276465] = "Ключ від контейнера зі зразком"
    t[276531] = "Наручі Руйнівника Проклять"
    t[276532] = "Наручі Руйнівника Проклять"
    t[276533] = "Обмотки для Зап'ястків Руйнівника Проклять"
    t[276534] = "Манжети Руйнівника Проклять"
    t[276536] = { name = "Роз'їдливий Ридикюль", fen = "Contains 6 Corrosive Souls.", fua = "Містить 6 Роз'їдливих Душ." }
    t[276547] = "Уражена Душа"
    t[276548] = "Змучена Душа"
    t[276549] = { name = "Топазове Небоікло", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[276551] = { name = "Фіолетовоспинне Небоікло", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[276553] = { name = "Смарагдове Небоікло", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[276571] = "Великий Шолом Обранця Налоракка"
    t[276572] = "Шолом Обранця Акіл'зона"
    t[276573] = "Каптур Обранця Галаззі"
    t[276574] = "Головний Убір Обранця Джан'алая"
    t[276575] = "Наплічники Обранця Налоракка"
    t[276576] = "Нагрудник Обранця Налоракка"
    t[276577] = "Великий Плащ Обранця Налоракка"
    t[276578] = "Латні Наручі Обранця Налоракка"
    t[276579] = "Рукавиці Обранця Налоракка"
    t[276580] = "Широкий Пояс Обранця Налоракка"
    t[276581] = "Бойові Поножі Обранця Налоракка"
    t[276582] = "Бойові Чоботи Обранця Налоракка"
    t[276583] = "Наплічники Обранця Акіл'зона"
    t[276584] = "Кольчуга Обранця Акіл'зона"
    t[276585] = "Плащ Обранця Акіл'зона"
    t[276586] = "Наручі Обранця Акіл'зона"
    t[276587] = "Латні Рукавиці Обранця Акіл'зона"
    t[276588] = "Пояс Обранця Акіл'зона"
    t[276589] = "Поножі Обранця Акіл'зона"
    t[276590] = "Чоботи Обранця Акіл'зона"
    t[276591] = "Оплічник Обранця Галаззі"
    t[276592] = "Туніка Обранця Галаззі"
    t[276593] = "Шкура Обранця Галаззі"
    t[276594] = "Наручі Обранця Галаззі"
    t[276595] = "Рукавички Обранця Галаззі"
    t[276596] = "Пояс Обранця Галаззі"
    t[276597] = "Штани Обранця Галаззі"
    t[276598] = "Обмотки на Щиколотки Обранця Галаззі"
    t[276599] = "Еполети Обранця Джан'алая"
    t[276600] = "Шати Обранця Джан'алая"
    t[276601] = "Плащ Обранця Джан'алая"
    t[276602] = "Браслети Обранця Джан'алая"
    t[276603] = "Обмотки для Рук Обранця Джан'алая"
    t[276604] = "Пояс Обранця Джан'алая"
    t[276605] = "Штани Обранця Джан'алая"
    t[276606] = "Онучі Обранця Джан'алая"
    t[276607] = { name = "Комплект: Шати Обранця Джан'алая", fen = "An ensemble of Cloth armor appearances.", fua = "Комплект образів тканинної броні." }
    t[276608] = { name = "Комплект: Бойове Спорядження Обранця Галаззі", fen = "An ensemble of Leather armor appearances.", fua = "Комплект образів шкіряної броні." }
    t[276609] = { name = "Комплект: Кольчуга Обранця Акіл'зона", fen = "An ensemble of Mail armor appearances.", fua = "Комплект образів кольчужної броні." }
    t[276610] = { name = "Комплект: Бойові Лати Обранця Налоракка", fen = "An ensemble of Plate armor appearances.", fua = "Комплект образів латної броні." }
    t[276622] = { name = "Амулет Де-криптації", fen = "A carved stone ball topped with leather bound fangs and soft feathers glows eerily. This ancient amulet is said to be able to banish wayward Amani spirits.", fua = "Різьблена кам'яна куля, увінчана перев'язаними шкірою іклами та м'яким пір'ям, моторошно світиться. Кажуть, цей прадавній амулет здатен виганяти заблукалих духів амані." }
    t[276624] = { name = "Переповнений Скарб Гаш'ури", fen = "Contains a variety of rewards for those who have proven themselves true allies of Zul'jarra.", fua = "Містить різноманітні нагороди для тих, хто довів, що є справжнім союзником Зул'джарри." }
    t[276628] = "Сувій Глибокого Подиху"
    t[276629] = "Сувій Риби-Вітрильника"
    t[276641] = "Роз'їдені Зап'ястки Руйнівника Проклять"
    t[276642] = "Роз'їдені Наручі Руйнівника Проклять"
    t[276643] = "Роз'їдені Обмотки для Зап'ястків Руйнівника Проклять"
    t[276644] = "Роз'їдені Манжети Руйнівника Проклять"
    t[276645] = { name = "Розмокла Вантажна Накладна", fen = "Details a delivery of oversized novelty silverware that was never completed.", fua = "Описує доставку величезного сувенірного столового срібла, яку так і не завершили." }
    t[276747] = { name = "Сувій Солоного Сувеніру: Схід", fen = "This souvenir is EXTRA secret. Read this scroll in the right place to reveal it!", fua = "Цей сувенір ОСОБЛИВО таємний. Прочитай сувій у правильному місці, щоб його відкрити!" }
    t[276748] = { name = "Сувій Солоного Сувеніру: Захід", fen = "This souvenir is EXTRA secret. Read this scroll in the right place to reveal it!", fua = "Цей сувенір ОСОБЛИВО таємний. Прочитай сувій у правильному місці, щоб його відкрити!" }
    t[276749] = { name = "Сувій Солоного Сувеніру: Південь", fen = "This souvenir is EXTRA secret. Read this scroll in the right place to reveal it!", fua = "Цей сувенір ОСОБЛИВО таємний. Прочитай сувій у правильному місці, щоб його відкрити!" }
    t[276787] = "Укріплені експедиційні пов'язки"
    t[276788] = "Запасні пов'язки Кіфаана"
    t[276789] = "Наручі Вартового Світлозавіси"
    t[276790] = "Рунні обмотки іллідарі"
    t[276791] = "Тренувальний пояс Тала'саана"
    t[276792] = "Пояс авангарду іллідарі"
    t[276793] = "Пернатий пояс далекого стрільця"
    t[276794] = "Шнур Світла верховного мага"
    t[276799] = "Тіньовий плащ переслідувача Розломів"
    t[276801] = { name = "Отруйний Звивун", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[276802] = { name = "Індиговий Звивистий Жах", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[276803] = { name = "Рубінова Звивина", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[276804] = { name = "Звивистий Виводок", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[276825] = "Бастіон Обранця Налоракка"
    t[276826] = "Осереддя Обранця Джан'алая"
    t[276827] = "Бойовий Посох Обранця Джан'алая"
    t[276828] = "Меч Обранця Галаззі"
    t[276829] = "Булава Обранця Акіл'зона"
    t[276830] = "Кинджал Обранців Галаззі"
    t[276831] = "Бойовий Клинок Обранця Налоракка"
    t[276832] = "Бойовий Спис Обранця Акіл'зона"
    t[276833] = "Бойовий Лук Обранця Акіл'зона"
    t[276834] = "Бойова Глефа Обранця Галаззі"
    t[276835] = "Сокира Обранця Акіл'зона"
    t[276836] = "Чарівна Паличка Обранця Джан'алая"
    t[276837] = "Бойова Сокира Обранця Налоракка"
    t[276841] = { name = "Арсенал: Озброєння Лоа", fen = "An arsenal of weapon appearances.", fua = "Арсенал виглядів зброї." }
    t[276881] = { name = "Подих Чуми", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[276882] = { name = "Подих Руїни", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[276925] = "Ідол Ула'тек"
    t[276926] = { name = "Зіпсутий Рійник", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[276927] = { name = "Гострокрил Акірів", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[277116] = { name = "Латний обладунок Порожнечі палія війни", fen = "Despite the numerous scratches and dents, this armor is incredibly strong. It hums with dark energy.", fua = "Попри численні подряпини й вм'ятини, цей обладунок неймовірно міцний. Він гуде темною енергією." }
    t[277124] = { name = "Скриня бойової ватаги зі спорядженням, торкнутим Порожнечею", fen = "Contains a Champion item for your Loot Specialization.", fua = "Містить предмет рівня Чемпіон для вашої спеціалізації здобичі." }
    t[277125] = { name = "Сховок озброєння, торкнутого Порожнечею: зброя", fen = "Contains a Heroic weapon item for your Loot Specialization.", fua = "Містить геройську зброю для вашої спеціалізації здобичі." }
    t[277126] = { name = "Сховок озброєння, торкнутого Порожнечею: намиста", fen = "Contains a Heroic necklace item for your Loot Specialization.", fua = "Містить геройське намисто для вашої спеціалізації здобичі." }
    t[277127] = { name = "Сховок озброєння, торкнутого Порожнечею: персні", fen = "Contains a Heroic ring item for your Loot Specialization.", fua = "Містить геройський перстень для вашої спеціалізації здобичі." }
    t[277137] = { name = "Звивиста Просочена Отрутою Торба", fen = "Contains materials for upgrading gear, gold, and more. Something is moving inside!", fua = "Містить матеріали для покращення спорядження, золото й багато іншого. Всередині щось ворушиться!" }
    t[277157] = "Вкрита Мушлями Скриня"
    t[277192] = { name = "Тіньовий Попіл", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[277283] = { name = "Сумка для Досліджень Акірів", fen = "Weekly cache containing a piece of Champion equipment, materials for upgrading equipment, gold, coffer key shards, and more.", fua = "Щотижнева скриня з предметом спорядження чемпіона, матеріалами для покращення спорядження, золотом, уламками ключа від скрині та іншим." }
    t[277292] = "Ребро Отруйного Гладіатора"
    t[277293] = "Бойова Глефа Отруйного Гладіатора"
    t[277294] = "Древкова Зброя Отруйного Гладіатора"
    t[277295] = "Великий Посох Отруйного Гладіатора"
    t[277296] = "Довгий Лук Отруйного Гладіатора"
    t[277298] = "Фетиш Отруйного Гладіатора"
    t[277299] = "Щит Отруйного Гладіатора"
    t[277300] = "Кинджал Отруйного Гладіатора"
    t[277301] = "Ікла Отруйного Гладіатора"
    t[277302] = "Бластер Отруйного Гладіатора"
    t[277303] = "Дворучний Меч Отруйного Гладіатора"
    t[277304] = "Трощитель Отруйного Гладіатора"
    t[277305] = "Меч Отруйного Гладіатора"
    t[277306] = "Жало Отруйного Гладіатора"
    t[277307] = "Гамселка Отруйного Гладіатора"
    t[277308] = "Дворучна Сокира Отруйного Гладіатора"
    t[277312] = "Сокира Отруйного Гладіатора"
    t[277326] = "Сокира Амані"
    t[277327] = "Оплічник Налоракка"
    t[277506] = { name = "Кодекс Душезвіїв", fen = "You can feel your spirit corrode just by holding it.", fua = "Відчуваєш, як твій дух роз'їдає, щойно береш його до рук." }
    t[277527] = { name = "Свічка Вроків", fen = "To cloud remembrance and unravel the will of the guided.", fua = "Щоб затьмарити пам'ять і розплести волю тих, кого ведуть." }
    t[277530] = { name = "Мушиний Бальзам", fen = "Carries the scent of nectar, rot, and still water.", fua = "Пахне нектаром, гниллю й стоячою водою." }
    t[277554] = { name = "Емблема командира Порожнечі", fen = "A runed emblem that can be taken from Nexus-Captain Leth'ir and Imperator Pertinax on Heroic world tier difficulty.", fua = "Рунічна емблема, яку можна здобути з нексус-капітана Лет'іра та імператора Пертінакса на героїчному рівні світу." }
    t[277764] = "Бойові Наручі Проклятого Отрутою Ведмедя"
    t[277765] = "Бойовий Пояс Проклятого Отрутою Ведмедя"
    t[277766] = "Наплічники Проклятого Отрутою Ведмедя"
    t[277767] = "Поножі Проклятого Отрутою Ведмедя"
    t[277768] = "Щелепи Проклятого Отрутою Ведмедя"
    t[277769] = "Латні Рукавиці Проклятого Отрутою Ведмедя"
    t[277770] = "Натиск Проклятого Отрутою Ведмедя"
    t[277771] = "Нагрудник Проклятого Отрутою Ведмедя"
    t[277772] = "Лускаті Наручі Проклятого Отрутою Орла"
    t[277773] = "Пояс Проклятого Отрутою Орла"
    t[277774] = "Нараменник Проклятого Отрутою Орла"
    t[277775] = "Поножі Проклятого Отрутою Орла"
    t[277776] = "Каптур Проклятого Отрутою Орла"
    t[277777] = "Рукавиці Проклятого Отрутою Орла"
    t[277778] = "Політ Проклятого Отрутою Орла"
    t[277779] = "Герб Проклятого Отрутою Орла"
    t[277780] = "Наручі Проклятої Отрутою Рисі"
    t[277781] = "Пряжка Проклятої Отрутою Рисі"
    t[277782] = "Наплічники Проклятої Отрутою Рисі"
    t[277783] = "Штани Проклятої Отрутою Рисі"
    t[277784] = "Погляд Проклятої Отрутою Рисі"
    t[277785] = "Пазурі Проклятої Отрутою Рисі"
    t[277786] = "Лапи Проклятої Отрутою Рисі"
    t[277787] = "Збруя Проклятої Отрутою Рисі"
    t[277788] = "Наручі Проклятого Отрутою Драконояструба"
    t[277789] = "Пояс Проклятого Отрутою Драконояструба"
    t[277790] = "Розмах Крил Проклятого Отрутою Драконояструба"
    t[277791] = "Поножі Проклятого Отрутою Драконояструба"
    t[277792] = "Оперення Проклятого Отрутою Драконояструба"
    t[277793] = "Обмотки на Руки Проклятого Отрутою Драконояструба"
    t[277794] = "Пазурі Проклятого Отрутою Драконояструба"
    t[277795] = "Роба Проклятого Отрутою Драконояструба"
    t[277798] = "Прокляте Отрутою Ікло Чарів"
    t[277799] = "Проклятий Отрутою Кийок"
    t[277800] = "Проклятий Отрутою Фокус"
    t[277801] = "Проклята Отрутою Кістяна Глефа"
    t[277802] = "Проклята Отрутою Гільйотина"
    t[277803] = "Проклятий Отрутою Різьбяр Чарів"
    t[277804] = "Проклятий Отрутою Довгий Лук"
    t[277805] = "Проклятий Отрутою Кинджал"
    t[277806] = "Проклятий Отрутою Шкуроколій"
    t[277807] = "Проклятий Отрутою Ритуальний Посох"
    t[277808] = "Проклятий Отрутою Гладіус"
    t[277809] = "Проклятий Отрутою Клеймор"
    t[277810] = "Проклята Отрутою Егіда"
    t[277820] = { name = "Рецепт: Принада на Зміїноголова Ула'тек", fen = "Teaches you how to craft an Ula'tek Snakehead Lure.", fua = "Навчає вас виготовляти принаду на зміїноголова Ула'тек." }
    t[277821] = "Принада на Зміїноголова Ула'тек"
    t[277847] = { name = "Цілий Шарнір Пастки", fen = "A perfectly functional hinge for closing the trap lid after a crab has been injected with venom.", fua = "Цілком справний шарнір, щоб закрити кришку пастки після того, як крабові впорснуть отруту." }
    t[277848] = { name = "Незаймана Принада на Краба", fen = "A false snack for a crab hidden beneath the broken debris.", fua = "Фальшива закуска для краба, що ховається під уламками." }
    t[277849] = { name = "Розчавлений Краб", fen = "Remnants of a crab who could not escape Hegvosh's stride.", fua = "Рештки краба, який не зміг утекти з-під ноги Геґвоша." }
    t[277876] = "Священний Шпиль Спраги"
    t[277879] = "Ритуальний Ніж Шепітного Терну"
    t[277880] = "Рунічний Місячний Клинок"
    t[277881] = "Поножі Сморідного Релікварію"
    t[277882] = "Дика Морокогілка"
    t[277883] = "Скло Злоби Присмеркової Мантії"
    t[277885] = "Штани Ткача Серпанку"
    t[277886] = "Підвіска Отруйної Варти"
    t[277888] = "Серпанок Дикого Обряду"
    t[277889] = "Іклата Розломна Бритва"
    t[277890] = "Личина Вартового Нетрів"
    t[277891] = "Наручі Левіафана"
    t[277893] = "Ритуальний Ніж Жевріючої Запони"
    t[277894] = "Обмотки Серпанкового Покриву"
    t[277895] = "Тіньова Роба Ткача Серпанку"
    t[277896] = "Кольчуга Кривавого Припливу"
    t[277897] = "Перстень-Печатка Кривавого Знака"
    t[277898] = "Поножі Авангарду Присмеркового Освячення"
    t[277899] = "Скалкохребетний Лук Вартового Ікол"
    t[277920] = { name = "Яскрава Чубова Пір'їна", fen = "A feather so bright, ostentatious, and shaped that it is guaranteed to turn multiple heads.", fua = "Пір'їна настільки яскрава, показна й вигадливої форми, що гарантовано змусить озирнутися не одну голову." }
    t[277934] = { name = "Здобич Звивистих Душ", fen = "A collection of ancient treasures coated with a viscous, acidic venom that burns on contact.", fua = "Збірка стародавніх скарбів, укритих в'язкою їдкою отрутою, що обпікає від самого дотику." }
    t[277935] = { name = "Смердюча Ніжка П'явки", fen = "Uniquely scented to draw the attention of large, three-headed monstrosities who find their flavor irresistible.", fua = "Має особливий запах, що привертає увагу великих триголових потвор, для яких її смак — невідпорна спокуса." }
    t[277937] = { name = "Збалансоване Підношення", fen = "The culmination of your mysterious mixing. What could it contain?", fua = "Вінець вашого загадкового змішування. Що ж у ньому може бути?" }
    t[277938] = { name = "Згубне Підношення", fen = "The culmination of your mysterious mixing. What could it contain?", fua = "Вінець вашого загадкового змішування. Що ж у ньому може бути?" }
    t[277939] = { name = "Нестабільне Підношення", fen = "The culmination of your mysterious mixing. What could it contain?", fua = "Вінець вашого загадкового змішування. Що ж у ньому може бути?" }
    t[277940] = { name = "Крихке Підношення", fen = "The culmination of your mysterious mixing. What could it contain?", fua = "Вінець вашого загадкового змішування. Що ж у ньому може бути?" }
    t[277941] = { name = "Моторошне Підношення", fen = "The culmination of your mysterious mixing. What could it contain?", fua = "Вінець вашого загадкового змішування. Що ж у ньому може бути?" }
    t[277942] = { name = "Огидне Підношення", fen = "The culmination of your mysterious mixing. What could it contain?", fua = "Вінець вашого загадкового змішування. Що ж у ньому може бути?" }
    t[277943] = { name = "Згубне Підношення", fen = "The culmination of your mysterious mixing. What could it contain?", fua = "Вінець вашого загадкового змішування. Що ж у ньому може бути?" }
    t[277944] = { name = "Флегматичне Підношення", fen = "The culmination of your mysterious mixing. What could it contain?", fua = "Вінець вашого загадкового змішування. Що ж у ньому може бути?" }
    t[277945] = { name = "Меланхолійне Підношення", fen = "The culmination of your mysterious mixing. What could it contain?", fua = "Вінець вашого загадкового змішування. Що ж у ньому може бути?" }
    t[277946] = { name = "Холеричне Підношення", fen = "The culmination of your mysterious mixing. What could it contain?", fua = "Вінець вашого загадкового змішування. Що ж у ньому може бути?" }
    t[277949] = { name = "Шкварчлива Отрута", fen = "Sizzling with unknown toxins, it represents an opportunity to advance the art of poisoncraft as much as it does a mortal threat.", fua = "Шкварчить невідомими токсинами: це і нагода просунути мистецтво отруйництва, і смертельна загроза водночас." }
    t[277951] = "Різак Отруйного Претендента"
    t[277954] = "Проклятий Клинок Джакту"
    t[277955] = { name = "Низка Ефірних Намистин", fen = "Metaphysically curious, the shine on these ghostly beads serves as an excellent diversion.", fua = "Метафізична дивовижа: блиск цих примарних намистин чудово відвертає увагу." }
    t[277961] = "Проклятий Клинок Джакту"
    t[277967] = { name = "Техніка: Контракт: Сили Зул'джарри", fen = "Teaches you how to craft Contract: Zul'jarra's Forces.", fua = "Навчає тебе виготовляти Контракт: Сили Зул'джарри." }
    t[277968] = { name = "Контракт: Сили Зул'джарри", fen = "A document drafted by Scribes pledging a Warband's allegiance to a faction.", fua = "Документ, складений Писарями, що засвідчує вірність загону певній фракції." }
    t[277969] = { name = "Контракт: Сили Зул'джарри", fen = "A document drafted by Scribes pledging a Warband's allegiance to a faction.", fua = "Документ, складений Писарями, що засвідчує вірність загону певній фракції." }
    t[277970] = "Бойовий Клинок Отруйного Палія Війни"
    t[277985] = { name = "Таємниче Підношення", fen = "The culmination of your mysterious mixing. What could it contain?", fua = "Вінець вашого загадкового змішування. Що ж у ньому може бути?" }
    t[277989] = { name = "Дзвін Закликача Привидів", fen = "The bell's chime signals the cursed to rise... and the pure to fall.", fua = "Передзвін цього дзвона — знак проклятим повстати... а чистим — упасти." }
    t[277991] = { name = "Вересклива Скринька зі Снастями", fen = "A tacklebox with bottomless lures, weights, and hooks. Now if only it didn't scream every time it opened...", fua = "Скринька з невичерпним запасом принад, грузил і гачків. От якби ж вона ще не верещала щоразу, як її відкривають..." }
    t[277992] = { name = "Частини Пастки на Крабів", fen = "Salvaged elements of one of Tokka's crab traps.", fua = "Урятовані частини однієї з крабових пасток Токки." }
    t[277993] = { name = "Ладан Сплеску Духів", fen = "Usually incense is said to calm the spirits, not rile them up.", fua = "Зазвичай кажуть, що ладан заспокоює духів, а не розбурхує їх." }
    t[277996] = { name = "Сіль Прикликання", fen = "As strategies of communing with the beyond have changed over time, one thing remains the same: the need for salt.", fua = "Способи спілкування з потойбіччям з часом змінювалися, та одне лишається незмінним: потреба в солі." }
    t[277997] = { name = "Лиховісний Рибальський Кодекс", fen = "Who knew fishing could be so dangerous? You did.", fua = "Хто б міг подумати, що риболовля така небезпечна? Ви могли." }
    t[277998] = { name = "Грудка Кристалічного Малахіту", fen = "It resonates at a frequency that is said to attract monsters, and just about anyone else.", fua = "Резонує на частоті, яка, кажуть, приваблює чудовиськ — та й узагалі будь-кого." }
    t[277999] = "Ритуальний Кинджал"
    t[278000] = { name = "Запечатаний Флакон Таємничої Зеленої Рідини", fen = "The vial is sealed at the top, so that not one drop of its strange contents can spill.", fua = "Флакон запечатано зверху, щоб жодна крапля його дивного вмісту не пролилася." }
    t[278001] = { name = "Забута Вудка Амані", fen = "Now THAT'S a fishing rod!", fua = "Оце вже СПРАВЖНЯ вудка!" }
    t[278003] = { name = "Забута Маска", fen = "A well-worn relic lost to time.", fua = "Потерта реліквія, загублена в плині часу." }
    t[278004] = { name = "Скриня бойової ватаги з чоботами, торкнутими Порожнечею", fen = "Contains a Champion boot item for your Loot Specialization.", fua = "Містить чоботи рівня Чемпіон для вашої спеціалізації здобичі." }
    t[278005] = { name = "Скриня бойової ватаги з поножами, торкнутими Порожнечею", fen = "Contains a Champion leg item for your Loot Specialization.", fua = "Містить поножі рівня Чемпіон для вашої спеціалізації здобичі." }
    t[278006] = { name = "Скриня бойової ватаги з поясами, торкнутими Порожнечею", fen = "Contains a Champion belt item for your Loot Specialization.", fua = "Містить пояс рівня Чемпіон для вашої спеціалізації здобичі." }
    t[278007] = { name = "Скриня бойової ватаги з рукавицями, торкнутими Порожнечею", fen = "Contains a Champion glove item for your Loot Specialization.", fua = "Містить рукавиці рівня Чемпіон для вашої спеціалізації здобичі." }
    t[278008] = { name = "Скриня бойової ватаги з наручами, торкнутими Порожнечею", fen = "Contains a Champion bracer item for your Loot Specialization.", fua = "Містить наручі рівня Чемпіон для вашої спеціалізації здобичі." }
    t[278009] = { name = "Скриня бойової ватаги з нагрудником, торкнутим Порожнечею", fen = "Contains a Champion chest item for your Loot Specialization.", fua = "Містить нагрудник рівня Чемпіон для вашої спеціалізації здобичі." }
    t[278010] = { name = "Скриня бойової ватаги з плащем, торкнутим Порожнечею", fen = "Contains a Champion cloak item for your Loot Specialization.", fua = "Містить плащ рівня Чемпіон для вашої спеціалізації здобичі." }
    t[278011] = { name = "Скриня бойової ватаги з наплічниками, торкнутими Порожнечею", fen = "Contains a Champion shoulder item for your Loot Specialization.", fua = "Містить наплічний предмет рівня Чемпіон для вашої спеціалізації здобичі." }
    t[278012] = { name = "Скриня бойової ватаги зі шоломом, торкнутим Порожнечею", fen = "Contains a Champion head item for your Loot Specialization.", fua = "Містить наголовний предмет рівня Чемпіон для вашої спеціалізації здобичі." }
    t[278013] = { name = "Скриня бойової ватаги зі зброєю, торкнутою Порожнечею", fen = "Contains a Champion weapon item for your Loot Specialization.", fua = "Містить зброю рівня Чемпіон для вашої спеціалізації здобичі." }
    t[278014] = { name = "Скриня бойової ватаги з намистами, торкнутими Порожнечею", fen = "Contains a Champion necklace item for your Loot Specialization.", fua = "Містить намисто рівня Чемпіон для вашої спеціалізації здобичі." }
    t[278015] = { name = "Скриня бойової ватаги з перснями, торкнутими Порожнечею", fen = "Contains a Champion ring item for your Loot Specialization.", fua = "Містить перстень рівня Чемпіон для вашої спеціалізації здобичі." }
    t[278021] = { name = "Напхана польова торба ельфів", fen = "Contains a random blood elf weapon recovered during the recent void assaults.", fua = "Містить випадкову зброю ельфів крові, здобуту під час нещодавніх штурмів Порожнечі." }
    t[278022] = { name = "Напхана польова торба амані", fen = "Contains a random amani weapon recovered during the recent void assaults.", fua = "Містить випадкову зброю амані, здобуту під час нещодавніх штурмів Порожнечі." }
    t[278024] = { name = "Напхана польова торба наг", fen = "Contains a random naga weapon recovered during the recent void assaults.", fua = "Містить випадкову зброю наг, здобуту під час нещодавніх штурмів Порожнечі." }
    t[278025] = { name = "Напхана польова торба Сутінків", fen = "Contains a random twilight weapon recovered during the recent void assaults.", fua = "Містить випадкову зброю Сутінків, здобуту під час нещодавніх штурмів Порожнечі." }
    t[278026] = { name = "Напханий клунок ефіріалів", fen = "Contains a random ethereal weapon recovered from Naigtal treasures.", fua = "Містить випадкову зброю ефіріалів, здобуту зі скарбів Найгталу." }
    t[278027] = { name = "Напханий зимовий клунок", fen = "Contains a random piece of winter gear recovered from Val treasures.", fua = "Містить випадковий предмет зимового спорядження, здобутий зі скарбів Валу." }
    t[278031] = { name = "Тріснутий Череп Амані", fen = "The only remains of a warrior long past.", fua = "Єдине, що лишилося від воїна давноминулих часів." }
    t[278032] = { name = "Пошкоджена Дрібничка Лоа", fen = "This corroded item is no longer protected by spirits.", fua = "Цей роз'їдений предмет більше не захищають духи." }
    t[278035] = { name = "Оздоблене Зілля Зцілення", fen = "This bottle looks like it can hold several normal potions of liquid.", fua = "Схоже, ця пляшка вміщує кілька порцій звичайного зілля." }
    t[278048] = { name = "Роз'їдлива Реліквія", fen = "Hissing with corrosive power.", fua = "Сичить роз'їдливою силою." }
    t[278050] = { name = "Роз'їдливий Самоцвіт", fen = "Sizzling with corrosive energy.", fua = "Шипить роз'їдливою енергією." }
    t[278070] = { name = "Жменя Езотеричних Складників", fen = "Somehow, the materials found on the isle seem more potent than before.", fua = "Чомусь матеріали, знайдені на острові, здаються сильнішими, ніж раніше." }
    t[278084] = "Жменя Езотеричних Складників"
    t[278094] = { name = "Ціла Непроклята Печінка", fen = "An organ that is perhaps the key to creating even more powerful strains of the venom curse.", fua = "Орган, що, можливо, є ключем до створення ще потужніших різновидів отруйного прокляття." }
    t[278095] = { name = "Печінкова Каша", fen = "An unrecognizable lump of fish flesh useless for further study.", fua = "Невпізнанна грудка риб'ячої плоті, непридатна для подальшого вивчення." }
    t[278099] = "Солод"
    t[278100] = "Зерно"
    t[278101] = { name = "Комплект: Полірована Броня Мисливця на Здобич", fen = "An ensemble of Plate armor found via Prey.", fua = "Комплект латної броні, що здобувається через «Здобич»." }
    t[278103] = { name = "Комплект: Міцна Броня Мисливця на Здобич", fen = "An ensemble of Mail armor found via Prey.", fua = "Комплект кольчужної броні, що здобувається через «Здобич»." }
    t[278104] = { name = "Комплект: Витончена Броня Мисливця на Здобич", fen = "An ensemble of Leather armor found via Prey.", fua = "Комплект шкіряної броні, що здобувається через «Здобич»." }
    t[278105] = { name = "Комплект: Вишукана Броня Мисливця на Здобич", fen = "An ensemble of Cloth armor found via Prey.", fua = "Комплект тканинної броні, що здобувається через «Здобич»." }
    t[278116] = "Досвід гравця"
    t[278193] = { name = "Жвало Акіра", fen = "A trophy proving Ula'tek's triumph over an ancient foe.", fua = "Трофей на доказ тріумфу Ула'тек над давнім ворогом." }
    t[278241] = { name = "Арсенал: Втрачене Озброєння Ловця Здобичі", fen = "An arsenal of weapon appearances.", fua = "Арсенал виглядів зброї." }
    t[278261] = { name = "Арсенал: Втрачене Озброєння Мисливця за Здобиччю", fen = "An arsenal of weapon appearances.", fua = "Арсенал виглядів зброї." }
    t[278276] = { name = "Здобич Азта'река", fen = "Defeating Azta'rec may reward currencies, collectibles, curios, and upgrade crests. Once per week per character.", fua = "Перемога над Азта'реком може винагородити валютами, колекційними предметами, дивовижами й гербами вдосконалення. Раз на тиждень для кожного персонажа." }
    t[278283] = { name = "Туманний сховок Порожнечі: Поховані вартові", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization.\n\nItems may be received once per difficulty level until all potential items for your current specialization have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі.\n\nПредмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети для вашої поточної спеціалізації." }
    t[278284] = { name = "Туманний сховок Порожнечі: Ула'тек", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization.\n\nItems may be received once per difficulty level until all potential items for your current specialization have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі.\n\nПредмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети для вашої поточної спеціалізації." }
    t[278285] = { name = "Туманний сховок Порожнечі: Душезвій Нек'залі", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization.\n\nItems may be received once per difficulty level until all potential items for your current specialization have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі.\n\nПредмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети для вашої поточної спеціалізації." }
    t[278286] = { name = "Туманний сховок Порожнечі: Тортоланські дослідники", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization.\n\nItems may be received once per difficulty level until all potential items for your current specialization have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі.\n\nПредмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети для вашої поточної спеціалізації." }
    t[278287] = { name = "Туманний сховок Порожнечі: Вашнік", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization.\n\nItems may be received once per difficulty level until all potential items for your current specialization have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі.\n\nПредмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети для вашої поточної спеціалізації." }
    t[278288] = { name = "Туманний сховок Порожнечі: Ссзорак", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization.\n\nItems may be received once per difficulty level until all potential items for your current specialization have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі.\n\nПредмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети для вашої поточної спеціалізації." }
    t[278289] = { name = "Туманний сховок Порожнечі: Два Ікла", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization.\n\nItems may be received once per difficulty level until all potential items for your current specialization have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі.\n\nПредмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети для вашої поточної спеціалізації." }
    t[278290] = { name = "Туманний сховок Порожнечі: Звивистий Вівтар", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization.\n\nItems may be received once per difficulty level until all potential items for your current specialization have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі.\n\nПредмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети для вашої поточної спеціалізації." }
    t[278329] = { name = "Таласський Рецепт у Пляшці", fen = "Parchment tucked away inside of a corked bottle.", fua = "Пергамент, захований у закоркованій пляшці." }
    t[278330] = { name = "Креслення: Р0КІ", fen = "Teaches you how to craft R0CKY.", fua = "Навчає вас виготовляти Р0КІ." }
    t[278331] = "Рецепт: Кисло-Солодкі Шпажки"
    t[278332] = { name = "Рецепт: Тарілка з Рибою-Кулею", fen = "Teaches you how to craft Puffer Plate.", fua = "Навчає тебе виготовляти Тарілку з Рибою-Кулею." }
    t[278333] = { name = "Креслення: Р0КІ на Виніс", fen = "Teaches you how to craft R0CKY-To-Go.", fua = "Навчає вас виготовляти Р0КІ на виніс." }
    t[278335] = "Лазурова Перлина"
    t[278336] = "Грішна Перлина"
    t[278337] = "Бурштинова Перлина"
    t[278339] = "Скута Прокляттям Перлина"
    t[278340] = "Заражена Перлина"
    t[278391] = "Моторошна Цяцька"
    t[278397] = { name = "Ефемерний Зоряний Слиз", fen = "Handle with caution.", fua = "Поводьтеся обережно." }
    t[278470] = { name = "Лиховісна Отрута", fen = "A vial of pure venom from the Vaults of Atal'Utek. It almost seems alive, cloying to the sides of the glass vial.", fua = "Флакон чистої отрути зі Сховищ Атал'Утек. Вона здається майже живою — липне до стінок скляного флакона." }
    t[278472] = { name = "Отруйна Роз'їдлива Монета", fen = "This coin feels unpleasant to hold. The thought of putting it down is even more unpleasant.", fua = "Цю монету неприємно тримати в руці. Думка покласти її — ще неприємніша." }
    t[278517] = { name = "Загублений Амулет Мед'джаїв", fen = "A bit of stone carved into the shape of a troll warrior, lost long ago.", fua = "Шматочок каменю, вирізьблений у подобі воїна-троля й загублений давним-давно." }
    t[278523] = { name = "Перо Ток'джари", fen = "So fragile it appears nearly translucent.", fua = "Таке тендітне, що здається майже прозорим." }
    t[278534] = { name = "Око Сзарита", fen = "Even severed from its master, it still twitches.", fua = "Навіть відтяте від господаря, воно досі сіпається." }
    t[278536] = { name = "Муміфікована Лапа Рисі", fen = "It can't possibly be lucky, given where it ended up.", fua = "Навряд чи вона приносить щастя, зважаючи на те, де опинилася." }
    t[278557] = { name = "Визнання Отули", fen = "A little goes a long way!", fua = "Навіть дрібниця багато важить!" }
    t[278617] = "Комплект: Тканинна Броня Отруйного Застрільника"
    t[278618] = "Комплект: Шкіряна Броня Отруйного Застрільника"
    t[278619] = "Комплект: Кольчужна Броня Отруйного Застрільника"
    t[278620] = "Комплект: Латна Броня Отруйного Застрільника"
    t[278621] = "Арсенал: Зброя Отруйного Претендента"
    t[278626] = "Арсенал: Зброя Отруйного Палія Війни"
    t[278627] = "Комплект: Броня Лицаря Смерті Отруйного Гладіатора"
    t[278628] = "Комплект: Броня Мисливця на Демонів Отруйного Гладіатора"
    t[278629] = "Комплект: Броня Друїда Отруйного Гладіатора"
    t[278630] = "Комплект: Броня Пробуджувача Отруйного Гладіатора"
    t[278631] = "Комплект: Броня Мисливця Отруйного Гладіатора"
    t[278632] = "Комплект: Броня Мага Отруйного Гладіатора"
    t[278633] = "Комплект: Броня Монаха Отруйного Гладіатора"
    t[278634] = "Комплект: Броня Паладина Отруйного Гладіатора"
    t[278635] = "Комплект: Броня Жерця Отруйного Гладіатора"
    t[278636] = "Комплект: Броня Розбійника Отруйного Гладіатора"
    t[278637] = "Комплект: Броня Шамана Отруйного Гладіатора"
    t[278638] = "Комплект: Броня Чорнокнижника Отруйного Гладіатора"
    t[278639] = "Комплект: Броня Воїна Отруйного Гладіатора"
    t[278640] = "Арсенал: Зброя Отруйного Гладіатора"
    t[278641] = "Комплект: Броня Лицаря Смерті Елітного Отруйного Гладіатора"
    t[278642] = "Комплект: Броня Мисливця на Демонів Елітного Отруйного Гладіатора"
    t[278643] = "Комплект: Броня Друїда Елітного Отруйного Гладіатора"
    t[278644] = "Комплект: Броня Пробуджувача Елітного Отруйного Гладіатора"
    t[278645] = "Комплект: Броня Мисливця Елітного Отруйного Гладіатора"
    t[278646] = "Комплект: Броня Мага Елітного Отруйного Гладіатора"
    t[278647] = "Комплект: Броня Монаха Елітного Отруйного Гладіатора"
    t[278648] = "Комплект: Броня Паладина Елітного Отруйного Гладіатора"
    t[278649] = "Комплект: Броня Жерця Елітного Отруйного Гладіатора"
    t[278650] = "Комплект: Броня Розбійника Елітного Отруйного Гладіатора"
    t[278651] = "Комплект: Броня Шамана Елітного Отруйного Гладіатора"
    t[278652] = "Комплект: Броня Чорнокнижника Елітного Отруйного Гладіатора"
    t[278653] = "Комплект: Броня Воїна Елітного Отруйного Гладіатора"
    t[278654] = "Арсенал: Зброя Отруйного Гладіатора-Елітника"
    t[278841] = "Комплект: Повний Обладунок Вогнехода"
    t[278842] = { name = "Комплект: Збруя Туманного Переслідувача", fen = "An ensemble of Leather armor appearances.", fua = "Комплект образів шкіряної броні." }
    t[278843] = { name = "Комплект: Бойове Спорядження Вершника Бурі", fen = "An ensemble of Mail armor appearances.", fua = "Комплект образів кольчужної броні." }
    t[278844] = { name = "Комплект: Бойові Лати Носія Присяги", fen = "An ensemble of Plate armor appearances.", fua = "Комплект образів латної броні." }
    t[278845] = { name = "Арсенал: Зброя Амані", fen = "An arsenal of weapon appearances.", fua = "Арсенал виглядів зброї." }
    t[278848] = { name = "Гнійний Чумний Роєвик", fen = "One of the rarest and most cursed fish from the Coiled Isle. This fish would surely be a prize for any fish fanatics.", fua = "Одна з найрідкісніших і найпроклятіших риб зі Звивистого Острова. Для будь-якого рибного фанатика ця риба — справжній трофей." }
    t[278877] = "Кіраса Очисника Склепу"
    t[278878] = "Нагрудник Очисника Склепу"
    t[278879] = "Збруя Очисника Склепу"
    t[278880] = "Шати Очисника Склепу"
    t[278881] = "Вінець Офідійського Генерала"
    t[278882] = "Барбют Офідійського Генерала"
    t[278883] = "Головний Убір Офідійського Генерала"
    t[278884] = "Бойовий Убір Офідійського Генерала"
    t[278885] = "Наплічники Жертводавця"
    t[278886] = "Наплічники Жертводавця"
    t[278887] = "Оплічник Жертводавця"
    t[278888] = "Оплічник Жертводавця"
    t[278889] = "Бойові Наручі Братів"
    t[278890] = "Наручі Братів"
    t[278891] = "Наручі Побратимів"
    t[278892] = "Братерські Наручі"
    t[278893] = "Поножі Стрибка Віри"
    t[278894] = "Сабатони Стрибка Віри"
    t[278895] = "Чоботи Стрибка Віри"
    t[278896] = "Капці Стрибка Віри"
    t[278897] = "Трощителі Іклолама"
    t[278898] = "Латні Рукавиці Іклолама"
    t[278899] = "Обмотки на Руки Іклолама"
    t[278900] = "Рукавиці Іклолама"
    t[278901] = "Поножі Болотяного Копача"
    t[278902] = "Поножі Болотяного Копача"
    t[278903] = "Поножі Болотяного Копача"
    t[278904] = "Штани Болотяного Копача"
    t[278905] = "Застібка Могильної Печатки"
    t[278906] = "Пояс Могильної Печатки"
    t[278907] = "Пасок Могильної Печатки"
    t[278908] = "Кушак Могильної Печатки"
    t[278909] = "Плащ Принаджування"
    t[278910] = "Промокла Накидка Іл'мула"
    t[278911] = "Покрив Жертви Кораблетрощі"
    t[278912] = "Великий Плащ, Благословенний Ґралом"
    t[279009] = "Виток Кривавого Тріскуна"
    t[279010] = "Пута Ула'тек"
    t[279011] = "Намисто з Отруйного Нефриту"
    t[279012] = { name = "Тріснутий ключ", fen = "Triumphal horns and cries of victory can faintly be heard emanating from within.", fua = "Зсередини ледь чутно лунають тріумфальні роги й переможні вигуки." }
    t[279021] = "Забутий Сувенір"
    t[279049] = "Забутий Сувенір"
    t[279051] = { name = "Одержима Ваза", fen = "The vase promises great riches. Surely a vendor would be able to assist with that.", fua = "Ваза обіцяє великі багатства. Напевно, якийсь торговець зможе з цим допомогти." }
    t[279052] = "Давня Маска Амані"
    t[279053] = "Давня Маска Амані"
    t[279054] = { name = "Ідол Синьої Води й Синього Неба", fen = "Those who have offended Gral, know that you can outswim him only for so long.", fua = "Ті, хто образив Ґрала, знайте: випереджати його уплав можна лише до пори." }
    t[279055] = "Дельфінячий Ідол Корсара"
    t[279064] = { name = "Полум'яний Амулет Надж'кули", fen = "An amulet of Jan'alai given only to very talented Shadowpine shamans.", fua = "Амулет Джан'алая, який дарують лише дуже обдарованим шаманам Шедоупайнів." }
    t[279091] = { name = "Сочливий Бичок", fen = "A common fish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Звичайна риба зі Звивистого Острова. Можна купувати й продавати на аукціоні." }
    t[279092] = { name = "Торба, Торкнута Мукою", fen = "Contains 100 Voidlight Marl.", fua = "Містить 100 од. пилу світла Порожнечі." }
    t[279093] = { name = "Хихотливий Череп", fen = "An uncommon fish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Незвичайна риба зі Звивистого Острова. Можна купувати й продавати на Аукціоні." }
    t[279094] = { name = "Гротескний Осетер", fen = "A rare fish from the Coiled Isle.", fua = "Рідкісна риба зі Звивистого Острова." }
    t[279100] = { name = "Багатоока Камбала", fen = "A common fish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Звичайна риба зі Звивистого Острова. Можна купувати й продавати на аукціоні." }
    t[279105] = { name = "Двоголова Риба-Бекас", fen = "An uncommon fish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Незвичайна риба зі Звивистого Острова. Можна купувати й продавати на Аукціоні." }
    t[279106] = { name = "Огидний Вудильник", fen = "A rare fish from the Coiled Isle. Can be bought and sold on the Auction House.", fua = "Рідкісна риба зі Звивистого Острова. Можна купити й продати на Аукціоні." }
    t[279142] = "Цілий Сегмент Хребта"
    t[279143] = "Видовжені Нутрощі"
    t[279145] = "Флакон Отрути"
    t[279146] = "Відрубане Брязкальце"
    t[279147] = "Невпізнавана Кістка"
    t[279148] = "Смужка Зміїної Шкури"
    t[279152] = "Ціла Зміїна Голова"
    t[279153] = "Великий Трофей"
    t[279154] = "Великий Листок"
    t[279157] = "Зношений Пояс Кочівника"
    t[279160] = "Заляпані Багном Онучі"
    t[279166] = "Пемзова Крейда для Рук"
    t[279194] = "Нашийник Заздрості"
    t[279195] = "Намисто Гніву"
    t[279196] = "Ланцюг Помсти"
    t[279197] = { name = "Звивисте Ікло", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[279207] = { name = "Почорніла Мулориба", fen = "An uncommon mutation of the sludgefish, this creature has more flavor than its exterior suggests. Its overwhelming scent may draw in the most curious of palates.", fua = "Незвична мутація мулориби: на смак це створіння багатше, ніж обіцяє його вигляд. Його нестерпний запах може привабити найдопитливіших гурманів." }
    t[279210] = { name = "Вибухова Тлапі", fen = "A bombastic fish that has survived beyond expectations. Its audacity and volatile innards make it eye-catching for any weapons enthusiasts.", fua = "Бомбезна риба, що вижила всупереч усім сподіванням. Її зухвалість і вибухонебезпечні нутрощі приваблюють око кожного поціновувача зброї." }
    t[279217] = "Покрив Проклятого Отрутою Драконояструба"
    t[279220] = "Грива Проклятої Отрутою Рисі"
    t[279222] = "Оплічник Проклятого Отрутою Орла"
    t[279223] = "Великий Плащ Проклятого Отрутою Ведмедя"
    t[279224] = "Комплект: Шати Проклятого Отрутою Драконояструба"
    t[279227] = "Комплект: Вбрання Проклятої Отрутою Рисі"
    t[279228] = "Комплект: Луска Проклятого Отрутою Орла"
    t[279230] = "Комплект: Захист Проклятого Отрутою Ведмедя"
    t[279231] = "Прадавній Спис Амані"
    t[279232] = "Прадавній Довгий Лук Амані"
    t[279233] = "Прадавній Чароклинок Амані"
    t[279234] = "Давній Кинджал Амані"
    t[279235] = "Давня Ручна Сокира Амані"
    t[279236] = "Давній Атам Амані"
    t[279237] = "Давня Дворучна Сокира Амані"
    t[279238] = "Давня Бойова Сокира Амані"
    t[279243] = "Екзорцизований Щит"
    t[279244] = "Екзорцизований Фокус"
    t[279245] = "Екзорцизований Кинджал"
    t[279280] = "Екзорцизована Дворучна Сокира"
    t[279281] = "Екзорцизована Ручна Сокира"
    t[279282] = "Екзорцизований Чароклинок"
    t[279283] = "Екзорцизована Бойова Сокира"
    t[279284] = { name = "Туманний сховок Порожнечі: Скарб дослідника Глибин", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization.\n\nItems may be received once per difficulty level until all potential items for your current specialization have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі.\n\nПредмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети для вашої поточної спеціалізації." }
    t[279287] = { name = "Роз'їдена Торбинка", fen = "Contains Corrosive Coins and other spoils of battle.", fua = "Містить Роз'їдливі Монети та іншу бойову здобич." }
    t[279288] = { name = "Роз'їдена Торба", fen = "Contains Corrosive Coins, Veteran Mistcrests, and other spoils of battle.", fua = "Містить Роз'їдливі Монети, Туманні Герби Ветерана та іншу бойову здобич." }
    t[279289] = "Урна Заслуженого Спочинку"
    t[279290] = "У Любителя Ікол"
    t[279329] = "Стійка Майстра-Коваля Амані"
    t[279345] = { name = "Просочений Отрутою Мішок", fen = "Contains Corrosive Coins, Champion Mistcrests, and other spoils of battle.", fua = "Містить Роз'їдливі Монети, Туманні Герби Чемпіона та іншу бойову здобич." }
    t[279358] = { name = "Арсенал: Проклята Отрутою Зброя", fen = "An arsenal of weapon appearances.", fua = "Арсенал виглядів зброї." }
    t[279362] = "Люта Маска Тікі"
    t[279382] = "Проклятий Отрутою Уламок"
    t[279384] = { name = "Латна Рукавиця з Кістяної Кольчуги", fen = "Fits like a glove. Taking it off... now that's the hard part.", fua = "Сидить як влита. А от зняти… оце вже справжня морока." }
    t[279387] = { name = "Ула'тук", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[279396] = "Загублене в часі сідло"
    t[279449] = { name = "Уламок Маски Троля-Ворожбита", fen = "A piece of something dark.", fua = "Шматок чогось темного." }
    t[279475] = "Перо Мутагенітора"
    t[279476] = "Кіготь Вассті"
    t[279477] = "Роздвоєний Язик Сс'акрітоса"
    t[279478] = "Зазубрений Хвіст Орі'кассі"
    t[279479] = "Око Левіафана"
    t[279483] = { name = "Триока Риба", fen = "Teaches you how to summon this companion.", fua = "Навчає тебе викликати цього супутника." }
    t[279520] = { name = "Схованка легендарного ветерана", fen = "Weekly cache containing materials for upgrading gear, gold, and more.\n\nThe first two pinnacle caches you earn each week contain a piece of Veteran gear.", fua = "Щотижнева схованка з матеріалами для вдосконалення спорядження, золотом та іншим.\n\nДві перші вершинні схованки, які ти заробляєш щотижня, містять предмет спорядження Ветерана." }
    t[279522] = { name = "Лишкова торба святкових гостинців", fen = "Weekly cache containing materials for upgrading equipment, gold, coffer key shards, and more.\n\nThe first two pinnacle caches you earn each week contain a piece of Veteran equipment.", fua = "Щотижнева скриня з матеріалами для покращення спорядження, золотом, уламками ключів від скриньок і не тільки.\n\nПерші дві вершинні скрині, які ви здобуваєте щотижня, містять предмет спорядження ветерана." }
    t[279523] = { name = "Переповнена торба рясності", fen = "Weekly cache containing materials for upgrading equipment, gold, coffer key shards, and more.\n\nThe first two pinnacle caches you earn each week contain a piece of Veteran equipment.", fua = "Щотижнева скриня з матеріалами для покращення спорядження, золотом, уламками ключів від скриньок і не тільки.\n\nПерші дві вершинні скрині, які ви здобуваєте щотижня, містять предмет спорядження ветерана." }
    t[279525] = { name = "Набір припасів завзятого учня", fen = "Weekly cache containing materials for upgrading gear, gold, coffer key shards, and more.\n\nThe first two pinnacle caches you earn each week contain a piece of Veteran equipment.", fua = "Щотижнева скриня з матеріалами для покращення спорядження, золотом, уламками ключів від скрині та іншим.\n\nПерші дві вершинні скрині, що ти здобуваєш щотижня, містять предмет ветеранського спорядження." }
    t[279526] = { name = "Переможна вершинна скриня Штормаріона", fen = "Weekly cache containing materials for upgrading gear, gold, coffer key shards, and more.\n\nThe first two pinnacle caches you earn each week contain a piece of Veteran equipment.", fua = "Щотижнева скриня з матеріалами для покращення спорядження, золотом, уламками ключів від скрині та іншим.\n\nПерші дві вершинні скрині, що ти здобуваєш щотижня, містять предмет ветеранського спорядження." }
    t[279527] = { name = "Схованка вершини", fen = "Weekly cache containing materials for upgrading equipment, gold, coffer key shards, and more.\n\nThe first two pinnacle caches you earn each week contain a piece of Veteran equipment.", fua = "Щотижнева скриня з матеріалами для покращення спорядження, золотом, уламками ключів від скриньок і не тільки.\n\nПерші дві вершинні скрині, які ви здобуваєте щотижня, містять предмет спорядження ветерана." }
    t[279550] = { name = "Зілля Отруйного Повернення", fen = "This can't possibly be good for you.", fua = "Навряд чи це піде вам на користь." }
    t[279573] = { name = "Згасаючий Шепіт Порожнечі", fen = "These maddening murmurs may have a clue to Xal'atath's whereabouts.", fua = "У цьому божевільному бурмотінні може критися підказка, де шукати Ксал'атат." }
    t[279574] = { name = "Скриня Мисливця за Здобиччю для Героя", fen = "A chest containing a piece of Hero equipment, supplies, gold, and a chance for professions materials.\n\nThis chest shares a list of rewards with Nebulous Voidcache: Prey.", fua = "Скриня з предметом спорядження рівня Героя, припасами, золотом і шансом на матеріали для професій.\n\nЦя скриня має спільний список нагород із Туманним сховком Порожнечі: Здобич." }
    t[279575] = "Емблема Громадянина Сільвермуна"
    t[279576] = "Залишок Порожнечі"
    t[279590] = "Славетний Стяг Отруйного Чемпіона"
    t[279610] = { name = "Стос світанкових гербів шукача пригод", fen = "The magic of these crests has expired, rendering them simple decoration now.", fua = "Магія цих гербів вичерпалася, тож тепер вони лише проста прикраса." }
    t[279611] = { name = "Торбина чемпіонських світанкових гербів", fen = "The magic of these crests has expired, rendering them simple decoration now.", fua = "Магія цих гербів вичерпалася, тож тепер вони лише проста прикраса." }
    t[279612] = { name = "Набір світанкових гербів героя", fen = "The magic of these crests has expired, rendering them simple decoration now.", fua = "Магія цих гербів вичерпалася, тож тепер вони лише проста прикраса." }
    t[279613] = { name = "Торбинка ветеранських світанкових гербів", fen = "The magic of these crests has expired, rendering them simple decoration now.", fua = "Магія цих гербів вичерпалася, тож тепер вони лише проста прикраса." }
    t[279614] = { name = "Тріумфальна торбина зі світанковими гербами чемпіона", fen = "The magic of these crests has expired, rendering them simple decoration now.", fua = "Магія цих гербів вичерпалася, тож тепер вони лише проста прикраса." }
    t[279615] = { name = "Святковий набір геройських світанкових гербів", fen = "The magic of these crests has expired, rendering them simple decoration now.", fua = "Магія цих гербів вичерпалася, тож тепер вони лише проста прикраса." }
    t[279616] = { name = "Славне гроно міфічних світанкових гербів", fen = "The magic of these crests has expired, rendering them simple decoration now.", fua = "Магія цих гербів вичерпалася, тож тепер вони лише проста прикраса." }
    t[279617] = { name = "Шанована торбина ветеранських світанкових гербів", fen = "The magic of these crests has expired, rendering them simple decoration now.", fua = "Магія цих гербів вичерпалася, тож тепер вони лише проста прикраса." }
    t[279618] = { name = "Туманний сховок Порожнечі: Вівтар Іклів", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[279619] = { name = "Туманний сховок Порожнечі: Сліпуча Долина", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[279620] = { name = "Туманний сховок Порожнечі: Лігво Налоракка", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[279621] = { name = "Туманний сховок Порожнечі: Спочинок Королів", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[279622] = { name = "Туманний сховок Порожнечі: Рубінові Озера Життя", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[279623] = { name = "Туманний сховок Порожнечі: Завулок Убивць", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[279625] = { name = "Туманний сховок Порожнечі: Арена Шраму Порожнечі", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization. Items may be received once per difficulty level until all potential items have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі. Предмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети." }
    t[279921] = { name = "Кі'клак", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[279994] = { name = "Зів'ялий Корінь", fen = "Small, but still edible.", fua = "Малий, але ще їстівний." }
    t[279995] = { name = "М'ясо Звірини", fen = "Little, but it will go a long way.", fua = "Дрібне, та надовго вистачить." }
    t[279997] = "Підступний Отруйний Камінь"
    t[280003] = { name = "Вирізальний Ніж", fen = "The blade is chipped yet startlingly sharp. Er'inye might know more.", fua = "Лезо вищерблене, але напрочуд гостре. Ер'іньє, можливо, знає більше." }
    t[280004] = "Роз'їдений Ключ"
    t[280005] = { name = "Талісман Розвіювання", fen = "A charm carved by the Med'jai for dispelling foul magic. Er'inye might know more.", fua = "Талісман, вирізьблений мед'джаями для розвіювання лихої магії. Ер'іньє, можливо, знає більше." }
    t[280006] = { name = "Лупа Духів", fen = "Light shifts and bends as it passes through the gem. Er'inye might know more.", fua = "Світло зміщується й заломлюється, проходячи крізь самоцвіт. Ер'іньє, можливо, знає більше." }
    t[280007] = { name = "Уламок Маски", fen = "A Mask Fragment taken from Hex Lord Malacrass in the Venomous Abyss on Normal difficulty.", fua = "Уламок маски, здобутий у Володаря Вроків Малакрасса в Отруйній Безодні на звичайній складності." }
    t[280033] = "Рукавиці Серпанкового Покриву"
    t[280035] = "Наручі Серпанкового Покриву"
    t[280036] = "Латні Рукавиці Серпанкового Покриву"
    t[280038] = "Сабатони Сморідного Релікварію"
    t[280039] = "Чоботи Сморідного Релікварію"
    t[280040] = "Капці Сморідного Релікварію"
    t[280047] = "Пернатий Дзвін"
    t[280089] = "Уламок Маски"
    t[280090] = "Уламок Маски"
    t[280091] = "Прихований Очисник"
    t[280097] = "Відзнака Завзяття Отруйного Претендента"
    t[280102] = { name = "Жменя Їдких Монет", fen = "Ghosts of the Amani deal exclusively in these phantasmal tokens.", fua = "Привиди амані розраховуються виключно цими примарними жетонами." }
    t[280105] = "Зганьблена Скрижаль Амані"
    t[280118] = "Медальйон Отруйного Претендента"
    t[280123] = "Чохол для Гострої Сокири"
    t[280131] = "Туманний сховок Порожнечі: Здобич"
    t[280136] = { name = "Дарунок Споріднених Душ", fen = "Feelings of love and affection overflow from this bag.", fua = "Із цієї торби через край ллються любов і ніжність." }
    t[280138] = { name = "Пікантик", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[280178] = { name = "Отруйна Жаба-Древолаз", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[280182] = { name = "Звивисте Карі", fen = "Mukleech with a twist! Spiced with Coiled Isle tree nuts and a splash of venom.", fua = "Мукліч із вивертом! Приправлено горіхами з дерев Звивистого Острова та краплею отрути." }
    t[280183] = { name = "Млинці Переслідувача", fen = "Fresh Atal'Utek wind serpent meat, perfectly grilled and seasoned with local mushrooms.", fua = "Свіже м'ясо вітряного змія з Атал'Утек, бездоганно підсмажене на грилі й приправлене місцевими грибами." }
    t[280184] = { name = "Сюрприз із Солодкопилки", fen = "A vibrant blend of delicious veggies, with a helping of crushed sweetsaw for an extra kick of flavor and color.", fua = "Яскрава суміш смачних овочів із пригорщею товченої солодкопилки — для додаткового смаку й кольору." }
    t[280189] = { name = "Вариво з Казана", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[280201] = { name = "Книга Оповідок", fen = "Go on, tell your tale.", fua = "Ну ж бо, розкажи свою історію." }
    t[280277] = "Вивітрений Перстень-Печатка Мед'джаїв"
    t[280305] = { name = "Залишок Душозвою", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[280376] = "Скалка Тіньового Уламка"
    t[280377] = "Подих Джан'алая"
    t[280409] = { name = "Зілля Рідкої Нежиті", fen = "Guaranteed to speed up the life cycle, one way or another.", fua = "Гарантовано прискорює життєвий цикл — так чи інакше." }
    t[280419] = "Проклятий Значок Душезвіїв"
    t[280422] = { name = "Паростки Духів", fen = "A taste palatable only in death.", fua = "Смак, прийнятний лише по смерті." }
    t[280425] = { name = "Ель з Потойбіччя", fen = "When you just need to feel something...", fua = "Коли просто треба хоч щось відчути..." }
    t[280446] = { name = "Бентежна Наживка", fen = "An amalgamation of various creature parts. You would swear you see it pulse.", fua = "Мішанина з частин різних істот. Ви могли б заприсягтися, що вона пульсує." }
    t[280458] = "Роз'їдена Торбинка Підмонет Глибинника"
    t[280503] = { name = "Нотатки Уланту", fen = "Notes about Lokago's rituals and how to thwart them.", fua = "Нотатки про ритуали Локаґо й те, як їм завадити." }
    t[280519] = { name = "Лазуровий Гордокіготь", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[280540] = { name = "Малий Мон", fen = "Teaches you how to summon and dismiss this companion.", fua = "Навчає вас прикликати й відсилати цього улюбленця." }
    t[280545] = "Накидка Шен'дорей"
    t[280562] = { name = "Висхідний Камінь Отрути", fen = "Weave the Venomstone's energy into worthy equipment with Orin's assistance at the Catalyst in Silvermoon. Acquired from powerful Midnight Season 2 enemies.", fua = "Вплети енергію Каменя Отрути в гідне спорядження з допомогою Оріна біля Каталізатора в Сільвермуні. Здобувається з могутніх ворогів 2-го сезону Опівночі." }
    t[280563] = "Давнє Бойове Мистецтво Гаш'ей: Удари Сокола"
    t[280599] = { name = "Вірний Супутник Досвідченого Шукача Пригод", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[280617] = { name = "Уламок Щита Світлоносця", fen = "\"All or none.\" - Lady Liadrin", fua = "«Усі або ніхто.» — леді Ліадрін" }
    t[280678] = { name = "Первісна Крихта Отрути", fen = "Orin can use these to further his research into repurposing the Catalyst's power to create Ascendant Venomstones.", fua = "Орін може використати їх, щоб просунути своє дослідження з переналаштування сили Каталізатора на створення Висхідних Каменів Отрути." }
    t[280689] = "Великий Спис Біґ Мона"
    t[280690] = "Лук Кусача"
    t[280691] = "Кинджал Звивистого Ритуалу"
    t[280692] = "Гамселій Грабіжника"
    t[280693] = "Посох Всезнання"
    t[280694] = "Клинок Забутого"
    t[280695] = "Черепокол Скаллі"
    t[280698] = "Розтинач Черева Сзарита"
    t[280700] = "Наручі Гнилого Кігтя"
    t[280701] = "Пояс Іклатих"
    t[280702] = "Оплічник Воскресителя"
    t[280704] = "Отруйні Чоботи Мулорота"
    t[280706] = "Гнилі Пазурі Сс'аліка"
    t[280708] = "Пояс з Отруйним Панциром"
    t[280709] = "Наплічники Потрійної Загрози"
    t[280710] = "Зарослий Мушлями Пояс Ґарсеґа"
    t[280711] = "Поточені Кайдани Привида"
    t[280712] = "Наручі Сплячої Гідри"
    t[280713] = { name = "Пряжка Біґ Мона", fen = "The initials B.M. are crudely etched on the front.", fua = "Спереду грубо видряпано ініціали Б.М." }
    t[280714] = "Кольчуга Розривача Корпусів"
    t[280715] = { name = "Око Скаллі", fen = "This ring was embedded in Coin-Eye Skully's actual eye.", fua = "Цей перстень був вправлений у справжнє око Монетоокого Скаллі." }
    t[280716] = "Медальйон Всечитця"
    t[280717] = "Дорогоцінна Підвіска Фартика"
    t[280718] = "Незворушний Тріпотливий Плащ"
    t[280732] = "Пакунок Бойової Ватаги з Туманними Гербами Героя"
    t[280734] = "Пакунок Бойової Ватаги з Туманними Гербами Чемпіона"
    t[280737] = "Пакунок Бойової Ватаги з Туманними Гербами Ветерана"
    t[280781] = { name = "Сховок озброєння, торкнутого Порожнечею", fen = "Contains a Heroic item for your Loot Specialization.", fua = "Містить геройський предмет для вашої спеціалізації здобичі." }
    t[280782] = { name = "Сховок озброєння, торкнутого Порожнечею: чоботи", fen = "Contains a Heroic boot item for your Loot Specialization.", fua = "Містить геройські чоботи для вашої спеціалізації здобичі." }
    t[280783] = { name = "Сховок озброєння, торкнутого Порожнечею: ноги", fen = "Contains a Heroic leg item for your Loot Specialization.", fua = "Містить геройський набедреник для вашої спеціалізації здобичі." }
    t[280784] = { name = "Сховок озброєння, торкнутого Порожнечею: пояси", fen = "Contains a Heroic belt item for your Loot Specialization.", fua = "Містить геройський пояс для вашої спеціалізації здобичі." }
    t[280785] = { name = "Сховок озброєння, торкнутого Порожнечею: рукавиці", fen = "Contains a Heroic glove item for your Loot Specialization.", fua = "Містить геройські рукавиці для вашої спеціалізації здобичі." }
    t[280786] = { name = "Сховок озброєння, торкнутого Порожнечею: наручі", fen = "Contains a Heroic bracer item for your Loot Specialization.", fua = "Містить геройські наручі для вашої спеціалізації здобичі." }
    t[280787] = { name = "Сховок озброєння, торкнутого Порожнечею: нагрудник", fen = "Contains a Heroic chest item for your Loot Specialization.", fua = "Містить геройський нагрудник для вашої спеціалізації здобичі." }
    t[280788] = { name = "Сховок озброєння, торкнутого Порожнечею: плащ", fen = "Contains a Heroic cloak item for your Loot Specialization.", fua = "Містить геройський плащ для вашої спеціалізації здобичі." }
    t[280789] = { name = "Сховок озброєння, торкнутого Порожнечею: плечі", fen = "Contains a Heroic shoulder item for your Loot Specialization.", fua = "Містить геройський наплічник для вашої спеціалізації здобичі." }
    t[280790] = { name = "Сховок озброєння, торкнутого Порожнечею: голова", fen = "Contains a Heroic head item for your Loot Specialization.", fua = "Містить геройський головний убір для вашої спеціалізації здобичі." }
    t[280791] = { name = "Сховок озброєння, торкнутого Порожнечею: зброя", fen = "Contains a Heroic weapon item for your Loot Specialization.", fua = "Містить геройську зброю для вашої спеціалізації здобичі." }
    t[280792] = { name = "Сховок озброєння, торкнутого Порожнечею: намиста", fen = "Contains a Heroic necklace item for your Loot Specialization.", fua = "Містить геройське намисто для вашої спеціалізації здобичі." }
    t[280793] = { name = "Сховок озброєння, торкнутого Порожнечею: персні", fen = "Contains a Heroic ring item for your Loot Specialization.", fua = "Містить геройський перстень для вашої спеціалізації здобичі." }
    t[280799] = "Лу'селама, Правосуддя Світла"
    t[280820] = "Благословенна Лоа Перемога"
    t[280821] = "Слід Галаззі"
    t[280822] = "Амулет Сили Налоракка"
    t[280823] = "Пір'я Акіл'зона"
    t[280825] = "Обряд Полум'я Джан'алая"
    t[280835] = "Сигіл Невідворотного Затемнення"
    t[281022] = "Моторошна Принада"
    t[281029] = { name = "Перстень Закликача Рою", fen = "Ominous whispers emanate from the band, loud enough to hear but too silent to fully understand.", fua = "Від персня линуть зловісні шепоти — досить гучні, щоб їх почути, та надто тихі, щоб до пуття зрозуміти." }
    t[281056] = { name = "Освячене Феніксове Лезо Лицаря", fen = "\"Darkness has no hold here.\" - Lady Liadrin", fua = "«Темрява тут не має влади.» — леді Ліадрін" }
    t[281136] = { name = "Камінь Повернення Виплоду Рою", fen = "Some hunt the swarm. Others become the swarm.", fua = "Одні полюють на рій. Інші стають роєм." }
    t[281215] = { name = "Щупальце Спотвореного Жахіття", fen = "A deep-seated aggression emanates from the severed appendage.", fua = "Від відтятого відростка віє глибоко вкоріненою агресією." }
    t[281223] = { name = "Торбина Їдких Монет", fen = "Contains a small amount Corrosive Coins.", fua = "Містить невелику кількість Їдких Монет." }
    t[281224] = "Отруйна Поліроль Завойовника"
    t[281225] = "Отруйний Лак Завойовника"
    t[281226] = "Арсенал: Зброя Сьомої Розвідгрупи"
    t[281227] = "Раш'ках Душезвія"
    t[281235] = "Поножі Ткача Порожнечі"
    t[281236] = "Нагрудна Обмотка Відчутного Жаху"
    t[281238] = "Латні Рукавиці Аномального Командира"
    t[281239] = "Роз'їдена Шапочка Здорованя"
    t[281244] = "Сагайдак Розвідника Амані"
    t[281245] = "Щит Розвідника Амані"
    t[281247] = "Сокира Розвідника Амані"
    t[281248] = "Лук Розвідника Амані"
    t[281249] = "Моджо Розвідника Амані"
    t[281311] = "Спис Розвідника Амані"
    t[281325] = "Бойовий Посох Розвідника Амані"
    t[281326] = "Посох Розвідника Амані"
    t[281405] = "Сховок озброєння, торкнутого Порожнечею: чоботи"
    t[281406] = "Сховок озброєння, торкнутого Порожнечею: ноги"
    t[281407] = "Сховок озброєння, торкнутого Порожнечею: пояси"
    t[281408] = "Сховок озброєння, торкнутого Порожнечею: рукавиці"
    t[281409] = "Сховок озброєння, торкнутого Порожнечею: наручі"
    t[281410] = "Сховок озброєння, торкнутого Порожнечею: нагрудник"
    t[281411] = "Сховок озброєння, торкнутого Порожнечею: плащ"
    t[281412] = "Сховок озброєння, торкнутого Порожнечею: плечі"
    t[281413] = "Сховок озброєння, торкнутого Порожнечею: голова"
    t[281414] = "Сховок озброєння, торкнутого Порожнечею: зброя"
    t[281415] = "Сховок озброєння, торкнутого Порожнечею: намиста"
    t[281416] = "Сховок озброєння, торкнутого Порожнечею: персні"
    t[281417] = "Сховок озброєння, торкнутого Порожнечею: чоботи"
    t[281418] = "Сховок озброєння, торкнутого Порожнечею: ноги"
    t[281419] = "Сховок озброєння, торкнутого Порожнечею: пояси"
    t[281420] = "Сховок озброєння, торкнутого Порожнечею: рукавиці"
    t[281421] = "Сховок озброєння, торкнутого Порожнечею: наручі"
    t[281422] = "Сховок озброєння, торкнутого Порожнечею: нагрудник"
    t[281423] = "Сховок озброєння, торкнутого Порожнечею: плащ"
    t[281424] = "Сховок озброєння, торкнутого Порожнечею: плечі"
    t[281425] = "Сховок озброєння, торкнутого Порожнечею: голова"
    t[281426] = "Сховок озброєння, торкнутого Порожнечею: зброя"
    t[281427] = "Сховок озброєння, торкнутого Порожнечею: намиста"
    t[281428] = "Сховок озброєння, торкнутого Порожнечею: персні"
    t[281429] = "Сховок озброєння, торкнутого Порожнечею"
    t[281566] = "Тесак Воїна Амані"
    t[281615] = { name = "Камінь Повернення Тіньоткача", fen = "Travel at the speed of darkness.", fua = "Подорожуй зі швидкістю темряви." }
    t[282183] = { name = "Схованка Легендарного Ветерана Звивистого Острова", fen = "Weekly cache containing materials for upgrading gear, gold, and more. Contains additional Coffer Key Shards.\n\nThe first two pinnacle caches you earn each week contain a piece of Veteran gear.", fua = "Щотижнева схованка з матеріалами для вдосконалення спорядження, золотом та іншим. Містить додаткові уламки ключа від скрині.\n\nДві перші вершинні схованки, які ти заробляєш щотижня, містять предмет спорядження Ветерана." }
    t[282402] = { name = "Прадавній Ключ Амані", fen = "Used to open a locked door hidden within the Labyrinth.", fua = "Відмикає замкнені двері, сховані в Лабіринті." }
    t[282414] = { name = "Спороносний Грибний Ходун", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[282424] = "Прудкість Акіл'зона"
    t[282425] = "Перстень женця звірів"
    t[282426] = "Дренейський приводний ланцюг"
    t[282427] = "Лютість Налоракка"
    t[282718] = "Покрив Галаззі"
    t[283363] = { name = "Благословенний Лоа Мандрівник", fen = "Teaches you how to summon this mount.", fua = "Навчає тебе викликати цього їздового." }
    t[283388] = { name = "Благословенна Зброя Лоа", fen = "The Amani loa have recognized your courage. As a token of their favor, they offer a powerful raiment of your choosing.", fua = "Лоа Амані визнали вашу відвагу. На знак прихильності вони пропонують могутнє вбрання на ваш вибір." }
    t[283996] = "Давнє Бойове Мистецтво Гаш'ей: Хвиля Жару"
    t[283997] = "Давнє Бойове Мистецтво Гаш'ей: Залізна Шкура Ведмедя"
    t[283998] = "Давнє Бойове Мистецтво Гаш'ей: Око Рисі"
    t[284051] = "Наплічники Носія Вроків"
    t[284052] = "Подоба Амані"
    t[284054] = "Наплічники Поглинача Вроків"
    t[284055] = "Наплічники Накладача Вроків"
    t[284056] = "Подоба Духа"
    t[284057] = "Подоба Корозії"
    t[284159] = { name = "Фоліант Матріарха", fen = "\"Rise as the Light's champion!\" - Lady Liadrin", fua = "«Повстань поборником Світла!» — леді Ліадрін" }
    t[284160] = "Гліф Крил Матріарха"
    t[284180] = "Торкнуті Лоа Плечі"
    t[284181] = "Торкнутий Лоа Хребет"
    t[284182] = "Торкнутий Лоа Лик"
    t[284186] = { name = "Відкрити Аукціон", fen = "Unlocks the ability to add an Auction House to your Fungal Strider mount.", fua = "Відкриває можливість додати Аукціон до твого їздового Грибного Ступохода." }
    t[284189] = "Відкрити Поштову Службу"
    t[284190] = "Відкрити Ремонтні Послуги"
    t[284191] = "Відкрити Трансмогрифікатор"
    t[284212] = { name = "Техніка: Відро з Плавучими Яблуками", fen = "Teaches you how to craft Apple Bobbing Bucket.", fua = "Навчає тебе виготовляти відро з плавучими яблуками." }
    t[284213] = { name = "Викрійка: Павучий Відьомський Капелюх", fen = "Teaches you how to craft a Spidery Witch Hat.", fua = "Навчає вас виготовляти Павучий Відьомський Капелюх." }
    t[284219] = "Гранітна Ритуальна Кіраса"
    t[284259] = "Непорушна Нуль-хвиля"
    t[284260] = "Переповнений Шпиль Порожнечі"
    t[284576] = "Тріснута Маска"
    t[284577] = "Жалка Кропива"
    t[284578] = "Незаплямована Лозина"
    t[284846] = "Трощитель Отруйного Гладіатора"
    t[285044] = { name = "Шанована Зброя Лоа", fen = "Your worth has far exceeded the Amani loas' expectations. As a token of their favor, they offer an exalted raiment of your choosing.", fua = "Ваша цінність набагато перевершила сподівання лоа амані. На знак прихильності вони пропонують звеличене вбрання на ваш вибір." }
    t[285062] = "Медаль завоювання"
    t[285065] = "Міфічний Фрагмент Душі"
    t[285801] = "Героїчний Уламок Душі"
    t[285807] = "Героїчний Уламок Душі"
    t[285875] = { name = "Винагорода Кіндо'джана", fen = "Defeating Kindo'jan within a Tier 8 or above Labyrinth will grant you Vault Credit and a Heroic Soul Fragment once per week per character.", fua = "Перемога над Кіндо'джаном у Лабіринті 8-го рівня чи вищого раз на тиждень для кожного персонажа зараховується до Великого Сховища та дає Героїчний Уламок Душі." }
    t[285876] = { name = "Зах'ран", fen = "Zah'ran will appear at the end of this delve with a random assortment of wares for purchase.", fua = "Зах'ран з'явиться наприкінці цієї Глибини з випадковим набором товарів на продаж." }
    t[285877] = { name = "Зах'ран", fen = "Zah'ran will appear at the end of this delve with a random assortment of wares for purchase.", fua = "Зах'ран з'явиться наприкінці цієї Глибини з випадковим набором товарів на продаж." }
    t[286019] = { name = "Туманний сховок Порожнечі: Кіт'ікс", fen = "Transmute a Nebulous Voidcore into a piece of equipment for your Loot Specialization.\n\nItems may be received once per difficulty level until all potential items for your current specialization have been transmuted.", fua = "Перетворює туманне ядро Порожнечі на спорядження для вашої спеціалізації здобичі.\n\nПредмети можна отримати раз на рівень складності, доки не буде перетворено всі можливі предмети для вашої поточної спеціалізації." }
    t[286211] = "Лункий Уламок Вулика"
    t[286212] = "Перетинка Крила Акіра"
    t[286213] = "Тріснутий Перстень-Печатка Рою"
    t[286558] = "Глибинобот 7001: Чип Програмного Оновлення Лабіринту Кіндо'джана"
    t[286643] = { name = "Перо Зникнення Кіндуру", fen = "A gift from Kinduru. Beyond Kindo'jan's Labyrinth, it is nothing more than a bird's feather.", fua = "Дарунок від Кіндуру. Поза Лабіринтом Кіндо'джана це лише пташина пір'їна." }
    t[287078] = { name = "Прадавня Скрижаль Амані", fen = "Almost indecipherable, only a few words can be picked out.", fua = "Майже не піддається прочитанню — вдається розібрати лише кілька слів." }
end)
