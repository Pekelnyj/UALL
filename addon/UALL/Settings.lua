-- Налаштування: що саме перекладати, а що лишити мовою оригіналу.
-- Чекбокси у стандартному вікні налаштувань WoW (Esc -> Options -> AddOns).
--
-- АРХІТЕКТУРА: повна таксономія типів тексту гри закладена з самого початку.
-- Кожен тип тексту має власний ключ і чекбокс — один гравець умикає
-- українську назву свого меча, інший лишає все «механічне» англійською.
-- Модулі перекладу перед підміною тексту питають ns.IsEnabled("ключ").
--
-- Філософія типових значень:
--   СЮЖЕТНЕ (квести, діалоги, книги, субтитри)      -> українська (увімкнено)
--   МЕХАНІЧНЕ (назви предметів/заклять, стати)      -> оригінал (вимкнено),
--     бо гравці звіряють їх із гайдами, WeakAuras і рейдовими callout'ами.

local ADDON_NAME, ns = ...

-- active=false — модуль ще в розробці: чекбокс видно і зберігається,
-- запрацює щойно з'явиться відповідний модуль перекладу.
ns.optionSections = {
    {
        header = "Загальне",
        options = {
            -- Головний вимикач. Знята галочка = увесь текст мовою оригіналу (це й
            -- був сенс окремого «Вимкнути весь переклад!» — прибрано як дубль). onChange
            -- дає ЖИВИЙ ефект: перемикання одразу вертає видимий текст EN⇄UA (через
            -- ns.ShowOriginal, що тепер зважає на майстер), без /reload.
            { key = "enabled", default = true, active = true,
              label = "Увімкнути переклад",
              tooltip = "Головний вимикач. Знято — увесь текст лишається мовою оригіналу (переклад вимкнено), аддон нічого не підміняє й лише збирає тексти. Те саме одразу робить клавіша «Вимкнути весь переклад (перемикач)» у «Гра > Призначення клавіш > Аддони».",
              onChange = function()
                  if ns.ToggleOriginal then ns.ToggleOriginal() end
              end },
            { key = "originalKey", default = "SHIFT", active = true,
              control = "dropdown",
              options = { { "SHIFT", "Shift" }, { "CTRL", "Ctrl" },
                          { "ALT", "Alt" }, { "NONE", "Вимкнено" } },
              label = "Клавіша показу оригіналу",   -- (утримання) обрізалось у панелі; пояснення — у підказці
              tooltip = "Утримуйте цю клавішу — текст тимчасово стане англійським (зручно звірятися з гайдами). Відпустіть — знову українська.\n\nЯкщо Shift/Ctrl/Alt у вас зайняті іншими комбо й переклад блимає — оберіть «Вимкнено» та скористайтеся окремою клавішею-перемикачем у «Гра > Призначення клавіш > Аддони»." },
            -- Обернений режим (07.10.2026, перенесено з Forever, де його попросили гравці):
            -- англійська типово, переклад — поки затиснута клавіша чи діє перемикач.
            { key = "reverseOriginal", default = false, active = true,
              label = "Обернений режим",   -- повна назва обрізалась у панелі; що це — у підказці
              tooltip = "Типово текст лишається англійським, а українським стає, поки ви тримаєте клавішу показу (вище) або діє клавіша-перемикач. Зручно, якщо граєте англійською й лише час від часу звіряєтеся з перекладом.\n\nЗняти галочку — звичайний режим: українською завжди, клавіша показує оригінал.",
              onChange = function()
                  if ns.ReverseRefresh then ns.ReverseRefresh() end
                  if ns.ToggleOriginal then ns.ToggleOriginal() end
              end },
        },
    },
    {
        header = "Квести",
        options = {
            { key = "quests.title", default = true, active = true,
              label = "Назви квестів",
              tooltip = "Назва квесту у вікні прийняття/здачі та журналі. Вимкніть, якщо шукаєте квести за назвою в гайдах/Wowhead." },
            { key = "quests.text", default = true, active = true,
              label = "Тексти квестів",
              tooltip = "Опис, текст прогресу і завершення квесту — основний сюжетний текст." },
            { key = "quests.objectives", default = true, active = true,
              label = "Цілі квестів",
              tooltip = "Рядок цілей у вікні квесту («Вбийте 10 вовків»)." },
            { key = "quests.ui", default = true, active = true,
              label = "Заголовки вікна квесту",
              tooltip = "Службові написи вікна квесту: «Опис», «Нагороди», «Ви отримаєте:» тощо." },
            { key = "quests.tracker", default = true, active = true,
              label = "Трекер цілей на екрані",
              tooltip = "Список квестів і цілей праворуч на екрані: назви квестів українською вже зараз, рядки цілей — у міру перекладу." },
        },
    },
    {
        header = "Діалоги NPC",
        options = {
            { key = "gossip.text", default = true, active = true,
              label = "Репліки NPC",
              tooltip = "Текст, який NPC говорить у вікні розмови. Неперекладені репліки збираються і поступово додаються в базу." },
            { key = "gossip.options", default = true, active = true,
              label = "Варіанти відповідей",
              tooltip = "Пункти вибору в розмові з NPC. Неперекладені збираються і поступово додаються в базу." },
            { key = "subtitles", default = true, active = true,
              label = "Субтитри і talking heads",
              tooltip = "Репліки персонажів вголос: talking heads, бабли над головами, крики босів і монстрів у чаті." },
            { key = "books", default = true, active = true,   -- готово з 0.58.0; «(скоро)» прибрано 07.10.2026
              label = "Книги і листи",
              tooltip = "Тексти книжок, записок і листів у світі." },
        },
    },
    {
        header = "Предмети",
        options = {
            { key = "items.name", default = false, active = true,
              label = "Назви предметів",
              tooltip = "Українська назва вашого меча у тултіпі (оригінал лишається поруч у дужках). Типово вимкнено: назви у гайдах і аукціоні англійські." },
            { key = "items.flavor", default = true, active = true,
              label = "Художні описи предметів",
              tooltip = "Жовтий «флейвор»-текст унизу тултіпа — сюжетний, на механіку не впливає." },
            { key = "items.effects", default = false, active = true,
              label = "Ефекти предметів (Use/Equip)",
              tooltip = "Рядки «Використання:» та «При спорядженні:». Типово вимкнено для звірки з гайдами." },
            { key = "items.statsSlots", default = false, active = true,
              label = "Слоти і характеристики",
              tooltip = "Назви слотів (Спина, Груди) і характеристик (Сила, Поспіх). Типово вимкнено." },
            { key = "items.bagSearch", default = true, active = true,
              label = "Пошук у сумках українською",
              tooltip = "Пошук за назвою предмета в сумках і банку працює й українською (напр. «меч»). Англійський пошук лишається — це доповнення, не заміна. Потрібна ввімкнена база предметів (за умовч. увімкнена)." },
            { key = "items.merchant", default = true, active = true,
              label = "Назви у вікні торговця",
              tooltip = "Українські назви товарів у списку торговця (і у викупі). Утримуйте клавішу показу оригіналу, щоб тимчасово побачити англійські. Потрібна ввімкнена база предметів." },
        },
    },
    {
        header = "Закляття і здібності",
        options = {
            { key = "spells.name", default = true, active = true,
              label = "Назви заклять",
              tooltip = "Українські назви заклять у книзі заклять і тултіпах. Затисни Shift, щоб тимчасово побачити оригінальні (англійські) назви — зручно для гайдів." },
            { key = "spells.description", default = false, active = true,
              label = "Описи заклять",
              tooltip = "Текст тултіпів заклять і талантів українською, з вашими живими числами (шкода, тривалість). Складні описи з умовами поки лишаються англійською." },
            { key = "auras", default = true, active = true,   -- до 07.10.2026 галочку не читав жоден модуль; тепер — підказки бафів (SpellHooks)
              label = "Бафи і дебафи",
              tooltip = "Назви й описи бафів і дебафів у підказках: на панелі бафів, на рамках гравця й цілі. Зніміть, щоб бачити ефекти англійською, лишивши переклад заклять." },
        },
    },
    {
        header = "Світ та інше",
        options = {
            { key = "classes", default = true, active = true,
              label = "Назви класів і спеціалізацій",
              tooltip = "ПАЛАДИН, Святість, Відплата — у вікні талантів і виборі спеціалізації." },
            { key = "names.original", default = false, active = true,
              label = "Імена персонажів: оригінал (латиницею)",
              tooltip = "Показувати імена героїв англійською (Wrathion замість Вратіон), решта тексту лишається українською — зручно для звірки з гайдами. Імена виходять без відмінка («Щоденник Wrathion»). Текст не дублюється: заміна йде на льоту." },
            { key = "world.zones", default = false, active = false,
              label = "Назви зон",
              tooltip = "Назви локацій на мапі та при вході в зону. (Модуль у розробці.)" },
            { key = "world.npcNames", default = true, active = true,
              label = "Імена NPC і монстрів",
              tooltip = "Імена істот у тултіпі, на неймплейті та в рамці цілі (зокрема kill-цілі «X вбито») українською. Затисни Shift, щоб тимчасово побачити оригінальні (англійські) імена — зручно для гайдів. Імена гравців не чіпаються." },
            { key = "achievements", default = true, active = true,
              label = "Досягнення",
              tooltip = "Назви й описи досягнень у вікні досягнень українською. Типово увімкнено (сюжетно-колекційний контент). Вимкніть, якщо шукаєте досягнення за назвою в гайдах/Wowhead. Shift тимчасово показує оригінал." },
            { key = "currency", default = true, active = true,
              label = "Валюти",
              tooltip = "Назви й описи валют у тултіпах (гаманець, нагороди) і у вікні Валюти. Shift тимчасово показує оригінал." },
            { key = "mail", default = true, active = true,
              label = "Пошта",
              tooltip = "Тема й текст листів від NPC та системи (поштова скринька) українською. Особисте листування між гравцями НЕ чіпається. Текст листів серверний — перекладається той, що ви отримали в грі. Shift тимчасово показує оригінал." },
            { key = "chat", default = true, active = true,
              label = "Чат: здобич і гроші",
              tooltip = "Переклад у вікні чату: здобич/гроші/валюта та емоції. Репліки NPC («Valeera says…») — окремий перемикач «Репліки NPC у чаті». Вимкніть, щоб службові рядки чату лишалися англійськими, НЕ зачіпаючи тултіпи предметів і субтитри. Діє на нові рядки (історію чату перемалювати не можна)." },
            { key = "chat.npc", default = true, active = true,
              label = "Репліки NPC у чаті",
              tooltip = "Переклад реплік NPC/монстрів у вікні чату («Valeera says…», крики, шепіт, бос-емоції) — незалежно від здобичі/грошей і від субтитрів-бабл над персонажем. Увімкніть лише це, щоб бачити діалоги українською, лишивши решту чату англійською. Діє на нові рядки." },
        },
    },
    {
        header = "Збір текстів для перекладу",
        options = {
            { key = "capture.notify", default = true, active = true,
              label = "Сповіщення в чаті про зібране",
              tooltip = "Повідомлення «Новий моб …», «Зібрано квест …», «Зібрано книгу …» у чаті, коли аддон збирає неперекладений текст у грі. САМ ЗБІР працює завжди — це лише сповіщення. Вимкніть, якщо заважає." },
        },
    },
    {
        header = "Інтерфейс гри",
        options = {
            { key = "interface.menu", default = true, active = true,
              label = "Меню та налаштування",
              tooltip = "Меню Esc (Параметри, Аддони, Вийти) і пункти у вікні налаштувань гри." },
            { key = "housing", default = true, active = true,
              label = "Житло (Housing)",
              tooltip = "Панель житла й Каталог декору (система Housing з Midnight). Перекладаються статичні написи інтерфейсу; лічильники й імена з форматом (напр. «Level 3») поки лишаються англійськими. Після зміни потрібен /reload." },
            { key = "groupfinder.names", default = true, active = true,
              label = "Назви підземель і рейдів",
              tooltip = "Перекладати назви підземель, рейдів і глибин УСЮДИ: у вікні пошуку груп (клавіша I) — списки «Зібрані групи», вкладка «Підземелля Міфічний+», значки сезону та їхні підказки; у Довіднику підземель (Adventure Guide) — плитки й заголовки інстансів; у вікні Мандрів. Вимкніть, щоб назви лишалися англійськими: зручно в міжнародних групах і для звірки з гайдами. Решта (описи боїв, лор, кнопки, заголовки) однаково перекладається — нею керують інші опції. Після зміни потрібен /reload." },
            { key = "interface.character", default = true, active = true,
              label = "Вікно персонажа (характеристики)",
              tooltip = "Назви характеристик (Сила, Витривалість, Критичний удар…), заголовки (Характеристики, Підсилення) і вкладки (Персонаж/Репутація/Валюта) у вікні персонажа. Вимкніть, щоб це вікно лишалося англійським — зручно для звірки з гайдами. Числа/відсотки не чіпаються." },
            -- Окремі модулі інтерфейсу (07.10.2026). Досі всі вони висіли на «Меню та
            -- налаштування» (interface.menu): зняв галочку меню — мовчки зникали й Торговий
            -- пост, бої улюбленців, професії, мапа польотів… Тепер у кожного своя.
            { key = "interface.areaPOI", default = true, active = true,
              label = "Точки інтересу на мапі",
              tooltip = "Назви й описи точок інтересу на мапі світу." },
            { key = "interface.barber", default = true, active = true,
              label = "Перукарня",
              tooltip = "Підписи й варіанти зовнішності в перукарні." },
            { key = "interface.genericTraits", default = true, active = true,
              label = "Дерева благословень і вмінь",
              tooltip = "Спеціальні дерева вмінь і благословень (напр. благословення лоа)." },
            { key = "interface.helpTip", default = true, active = true,
              label = "Спливні підказки-поради",
              tooltip = "Жовті спливні поради-туторіали біля кнопок і вікон." },
            { key = "interface.perks", default = true, active = true,
              label = "Торговий пост",
              tooltip = "Торговий пост: назви товарів, завдання й описи активностей." },
            { key = "interface.petBattle", default = true, active = true,
              label = "Бойові улюбленці",
              tooltip = "Описи улюбленців і назви та описи їхніх здібностей." },
            { key = "interface.playerChoice", default = true, active = true,
              label = "Вікна вибору",
              tooltip = "Вікна вибору історії, сценарію чи нагороди." },
            { key = "interface.questLine", default = true, active = true,
              label = "Сюжетні лінії в журналі",
              tooltip = "Назви сюжетних ліній і кампаній у журналі завдань." },
            { key = "interface.taxi", default = true, active = true,
              label = "Точки польоту",
              tooltip = "Назви точок польоту на мапі польотів." },
            { key = "interface.tier3", default = true, active = true,
              label = "Інші вікна",
              tooltip = "Дрібніші вікна: календар, заставки, частина пошуку групи й професій." },
            { key = "interface.transmog", default = true, active = true,
              label = "Трансмог-сети",
              tooltip = "Назви трансмог-сетів у Гардеробі." },
            { key = "interface.tutorial", default = true, active = true,
              label = "Банери навчання",
              tooltip = "Банери системи навчання для нових персонажів." },
            { key = "interface.vignette", default = true, active = true,
              label = "Рідкісні моби й скарби на мапі",
              tooltip = "Назви рідкісних мобів і скарбів на мапі світу й мінімапі." },
            { key = "interface.professions", default = true, active = true,
              label = "Професії",
              tooltip = "Книга професій і вікно ремесла: назви рецептів, категорій і підписи." },
            { key = "interface.toybox", default = true, active = true,
              label = "Скриня іграшок",
              tooltip = "Назви іграшок у Скрині іграшок." },
        },
    },
    {
        header = "Сторонні аддони (тестово)",
        options = {
            { key = "compat.dialogueUI", default = true, active = true,
              label = "DialogueUI (переклад квестів)",
              tooltip = "Віддавати український текст квестів аддону DialogueUI (він замінює стандартне вікно квестів власним). Кнопка-перекладач у кутку того вікна — ЙОГО, не наша: DialogueUI малює її сам, щойно якийсь перекладач зареєструвався, і її лівий клік вимикає переклад лише до перезаходу (DialogueUI цього не зберігає). Зніміть галочку тут, щоб вікна DialogueUI лишалися англійськими НАЗАВЖДИ — тоді кнопка зникає разом із перекладом. Решта гри перекладається як завжди." },
            { key = "compat.kalielsTracker", default = false, active = true,
              label = "Kaliel's Tracker (тестово)",
              tooltip = "Перекладати назви квестів і цілі у трекері Kaliel's Tracker (він замінює стандартний трекер власним фреймом). ТЕСТОВА функція — після ввімкнення зробіть /reload. Якщо помітите проблеми (неправильний розмір рядків, англійські блоки, миготіння) — вимкніть і повідомте." },
            { key = "compat.krowiAF", default = false, active = true,
              label = "Krowi's Achievement Filter (тестово)",
              tooltip = "Перекладати досягнення у вікні аддона Krowi's Achievement Filter (він замінює стандартне вікно досягнень власним): назви й описи в списку та Зведенні, результати пошуку, дерево категорій зліва та вкладки. ТЕСТОВА функція — після ввімкнення зробіть /reload. Якщо помітите проблеми (англійські рядки, миготіння, неправильна поведінка Krowi) — вимкніть і повідомте." },
        },
    },
}

ns.defaultSettings = {}
for _, section in ipairs(ns.optionSections) do
    for _, opt in ipairs(section.options) do
        ns.defaultSettings[opt.key] = opt.default
    end
end

function ns.GetSettingsDB()
    local db = _G[ADDON_NAME .. "SettingsDB"]
    if not db then
        db = {}
        _G[ADDON_NAME .. "SettingsDB"] = db
    end
    return db
end

-- Значення налаштування будь-якого типу (рядкові — для дропдаунів).
function ns.GetSetting(key)
    -- Публічна збірка: жодних сповіщень збору в чат (збирача нема).
    if ns.PUBLIC and key == "capture.notify" then return false end
    local v = ns.GetSettingsDB()[key]
    if v == nil then return ns.defaultSettings[key] end
    return v
end

-- Головна перевірка для всіх модулів перекладу.
-- Враховує головний вимикач, потім конкретний ключ.
function ns.IsEnabled(key)
    local db = ns.GetSettingsDB()
    local function value(k)
        local v = db[k]
        if v == nil then return ns.defaultSettings[k] or false end
        return v
    end
    if key ~= "enabled" and not value("enabled") then
        return false
    end
    return value(key)
end

-- true, коли треба показувати оригінал — усі модулі перекладу в цей момент
-- пропускають підміну. Незалежні шляхи: (0) МАЙСТЕР-вимикач «Увімкнути переклад»
-- знято > увесь текст оригіналом (замінив окремий «Вимкнути весь переклад!»);
-- (1) перемикач ns.originalToggled (клавіша «перемикач» у Призначенні клавіш);
-- (2) утримання ДОВІЛЬНОЇ клавіші (ns.holdOriginal — клавіша «утримання», ловиться
-- кадром-спостерігачем у Core); (3) утримання модифікатора з дропдауна.
local function OriginalKeyActive()
    if ns.originalToggled then return true end
    if ns.holdOriginal then return true end
    local key = ns.GetSetting("originalKey")
    if key == "SHIFT" then return IsShiftKeyDown() end
    if key == "CTRL" then return IsControlKeyDown() end
    if key == "ALT" then return IsAltKeyDown() end
    return false
end

-- ДВА ПИТАННЯ, які не можна плутати (обернений режим, 07.10.2026):
--   ns.ShowOriginal()    — чи модулям НЕ перекладати (так його й кличуть усі модулі);
--   ns.DisplayOriginal() — що зараз на екрані (для ToggleOriginal і ns.Remember).
-- У звичайному режимі вони збігаються. В оберненому модулі перекладають ЗАВЖДИ — пара
-- «оригінал — переклад» потрібна в реєстрі, щоб клавіші було що показати, — а англійський
-- текст на екран повертає ns.Remember (Core.lua).
function ns.ShowOriginal()
    if ns.__reverting then return true end      -- ми саме ставимо оригінал (Core: Reverse)
    if not ns.IsEnabled("enabled") then return true end
    if ns.GetSetting("reverseOriginal") then return false end
    return OriginalKeyActive()
end

function ns.DisplayOriginal()
    if not ns.IsEnabled("enabled") then return true end
    if ns.GetSetting("reverseOriginal") then return not OriginalKeyActive() end
    return OriginalKeyActive()
end

-- Додати опції секції у вказану категорію (головну або підкатегорію).
local function AddSectionOptions(category, db, section)
    for _, opt in ipairs(section.options) do
        -- «(скоро)» — ПРЕФІКСОМ (на початку): суфікс обрізався на довгих
        -- назвах (як «Імена персонажів…»), і позначку не було видно.
        local label = opt.active and opt.label or ("(скоро) " .. opt.label)
        if opt.control == "dropdown" then
            local setting = Settings.RegisterAddOnSetting(
                category, ADDON_NAME .. "_" .. opt.key, opt.key, db,
                Settings.VarType.String, label, opt.default)
            local function GetOptions()
                local container = Settings.CreateControlTextContainer()
                for _, o in ipairs(opt.options) do
                    container:Add(o[1], o[2])
                end
                return container:GetData()
            end
            Settings.CreateDropdown(category, setting, GetOptions, opt.tooltip)
        else
            local setting = Settings.RegisterAddOnSetting(
                category,
                ADDON_NAME .. "_" .. opt.key, -- унікальний variable
                opt.key,                      -- ключ у таблиці db
                db,
                Settings.VarType.Boolean,
                label,
                opt.default
            )
            Settings.CreateCheckbox(category, setting, opt.tooltip)
            -- власна реакція опції (onChange), а тоді — миттєвий відкат/повернення написів
            -- модуля (07.10.2026; досі знята галочка діяла лише на нові написи)
            setting:SetValueChangedCallback(function()
                if opt.onChange then opt.onChange() end
                if ns.ModuleChanged then pcall(ns.ModuleChanged, opt.key) end
            end)
        end
    end
end

local function RegisterOptionsPanel()
    -- ДЕРЕВО ЯК В AUCTIONATOR: головна сторінка = «Загальне», решта секцій —
    -- ПІДКАТЕГОРІЇ зліва (Settings.RegisterVerticalLayoutSubcategory). Ключі
    -- налаштувань ті самі — збережені значення гравців не втрачаються.
    local category, layout = Settings.RegisterVerticalLayoutCategory(ADDON_NAME)
    local db = ns.GetSettingsDB()

    -- Вступний опис угорі головної сторінки: пояснює саму суть — гравець сам
    -- обирає, що перекладати, а утримання Shift тимчасово показує оригінал
    -- (клавіша переназначувана). Секція-заголовок Settings API переносить текст.
    if not layout and SettingsPanel and SettingsPanel.GetLayout then
        layout = SettingsPanel:GetLayout(category)
    end
    if layout and CreateSettingsListSectionHeaderInitializer then
        layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(
            "Оберіть, які тексти гри бачити українською, а які лишити мовою "
            .. "оригіналу. Утримуйте Shift, щоб тимчасово показати оригінал — "
            .. "клавішу можна змінити нижче або в «Гра > Призначення клавіш > Аддони»."))
    end

    for i, section in ipairs(ns.optionSections) do
        -- Публічна збірка: секція «Збір текстів для перекладу» неактуальна (збирача нема).
        if ns.PUBLIC and section.header == "Збір текстів для перекладу" then
            -- пропускаємо
        elseif i == 1 then
            AddSectionOptions(category, db, section)   -- «Загальне» на головній
        else
            local sub = Settings.RegisterVerticalLayoutSubcategory(category, section.header)
            AddSectionOptions(sub, db, section)
        end
    end

    Settings.RegisterAddOnCategory(category)
    ns.settingsCategory = category
end

function ns.OpenOptions()
    if ns.settingsCategory then
        Settings.OpenToCategory(ns.settingsCategory:GetID())
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, _, name)
    if name ~= ADDON_NAME then return end
    RegisterOptionsPanel()
    -- відновити ФІКСОВАНИЙ «показати оригінал» з минулої сесії: якщо був увімкнений,
    -- ставимо ns.originalToggled > усі хуки одразу показують оригінал (переклад «вимкнено»).
    local db = ns.GetSettingsDB and ns.GetSettingsDB()
    if db and db.showOriginal then ns.originalToggled = true end
    self:UnregisterEvent("ADDON_LOADED")
end)
