-- WoWUkraine: переклад UI-рядків гри — меню Esc і вікно налаштувань.
-- Перемикач: «Інтерфейс гри → Меню та налаштування» (interface.menu).
--
-- Підхід той самий, що для заголовків трекера: словник EN->UA і підміна
-- видимого тексту за точним збігом (з ns.SafeText проти секретних значень).
-- Жодних змін глобальних рядків/шрифтів — щоб не тейнтити захищений UI.

local _, ns = ...

-- Словник UI-рядків. Ключ — англійський текст як показує гра.
-- Розширюється в міру потреби; невідомі рядки лишаються англійською.
local UI = {
    -- Меню Esc (GameMenuFrame)
    ["Return to Game"] = "Повернутися до гри",
    ["Resume"] = "Продовжити",
    ["Options"] = "Параметри",
    ["Settings"] = "Налаштування",
    ["Game Menu"] = "Меню гри",
    ["Macros"] = "Макроси",
    ["AddOns"] = "Аддони",
    ["Edit Mode"] = "Режим редагування",
    ["Support"] = "Підтримка",
    ["Help"] = "Довідка",
    ["What's New"] = "Що нового",
    ["Shop"] = "Крамниця",
    ["Game Shop"] = "Ігрова крамниця",
    ["Log Out"] = "Вийти з персонажа",
    ["Logout"] = "Вийти з персонажа",
    ["Exit Game"] = "Вийти з гри",
    ["Customer Support"] = "Служба підтримки",
    ["Open Tickets"] = "Відкриті звернення",
    ["Quit"] = "Вийти",
    -- Категорії налаштувань
    ["System"] = "Система",
    ["Graphics"] = "Графіка",
    ["Advanced"] = "Додатково",
    ["Sound"] = "Звук",
    ["Game"] = "Гра",
    ["Interface"] = "Інтерфейс",
    ["Accessibility"] = "Доступність",
    ["Gameplay"] = "Ігровий процес",
    ["Combat"] = "Бій",
    ["Controls"] = "Керування",
    ["Camera"] = "Камера",
    ["Mouse"] = "Миша",
    ["Keyboard"] = "Клавіатура",
    ["Names"] = "Імена",
    ["Nameplates"] = "Панелі імен",
    ["Quests & Objectives"] = "Квести й цілі",
    ["Social"] = "Спілкування",
    ["Chat"] = "Чат",
    ["Action Bars"] = "Панелі дій",
    ["Status Text"] = "Текст стану",
    ["Display"] = "Дисплей",
    ["Network"] = "Мережа",
    ["Language"] = "Мова",
    ["Languages"] = "Мови",
    -- Часті кнопки/пункти
    ["Okay"] = "Гаразд",
    ["OK"] = "Гаразд",
    ["Cancel"] = "Скасувати",
    ["Apply"] = "Застосувати",
    ["Defaults"] = "За замовчуванням",
    ["Done"] = "Готово",
    ["Close"] = "Закрити",
    ["Back"] = "Назад",
    ["Save"] = "Зберегти",
    ["Reset"] = "Скинути",
    ["Enabled"] = "Увімкнено",
    ["Disabled"] = "Вимкнено",
    ["On"] = "Увімк.",
    ["Off"] = "Вимк.",
    ["Reset to Default"] = "Скинути до типових",
    ["Master Volume"] = "Загальна гучність",
    ["Enable Sound"] = "Увімкнути звук",
    ["Enable Music"] = "Увімкнути музику",
    ["Music Volume"] = "Гучність музики",
    ["Sound Effects"] = "Звукові ефекти",
    ["Ambience Volume"] = "Гучність оточення",
    ["Dialog Volume"] = "Гучність діалогів",
    ["Resolution"] = "Роздільна здатність",
    ["Display Mode"] = "Режим екрана",
    ["Graphics Quality"] = "Якість графіки",
    ["Field of View"] = "Поле зору",
    -- Вікно персонажа (CharacterFrame / CharacterStatsPane)
    ["Item Level"] = "Рівень предмета",
    ["Attributes"] = "Характеристики",
    ["Enhancements"] = "Підсилення",
    ["Strength"] = "Сила",
    ["Agility"] = "Спритність",
    ["Stamina"] = "Витривалість",
    ["Intellect"] = "Інтелект",
    ["Armor"] = "Броня",
    ["Critical Strike"] = "Критичний удар",
    ["Haste"] = "Швидкість",
    ["Mastery"] = "Майстерність",
    ["Versatility"] = "Універсальність",
    ["Speed"] = "Рухливість",
    ["Avoidance"] = "Уникнення",
    ["Leech"] = "Висмоктування",
    ["Character Info"] = "Інформація про персонажа",
    -- Вкладки вікна персонажа (CharacterFrameTab1/2/3.Text)
    ["Character"] = "Персонаж",
    ["Reputation"] = "Репутація",
    ["Currency"] = "Валюта",
    -- Панель репутації: рівні прихильності (FACTION_STANDING_LABEL*) + фільтр
    ["All"] = "Усі",
    ["Hated"] = "Зненавиджений",
    ["Hostile"] = "Ворожий",
    ["Unfriendly"] = "Неприязний",
    ["Neutral"] = "Нейтральний",
    ["Friendly"] = "Дружній",
    ["Honored"] = "Шанований",
    ["Revered"] = "Поважаний",
    ["Exalted"] = "Звеличений",
    ["Paragon"] = "Взірець",
    -- Журнал колекцій: вкладки + деталь-панель маунта/улюбленця
    ["Mounts"] = "Маунти",
    ["Pets"] = "Улюбленці",
    ["Battle Pets"] = "Бойові улюбленці",
    ["Toys"] = "Іграшки",
    ["Heirlooms"] = "Спадок",
    ["Appearances"] = "Образи",
    ["Drop:"] = "Випадає з:",
    ["Drop"] = "Випадає з",
    ["Location:"] = "Місце:",
    ["Location"] = "Місце",
    ["Source:"] = "Джерело:",
    ["Show Character"] = "Показати персонажа",
    ["Hide Character"] = "Сховати персонажа",
    -- Мікро-меню (кнопки знизу екрана) — тултіпи «Назва (клавіша)»
    ["Spellbook"] = "Книга заклять",
    ["Spellbook and Abilities"] = "Книга заклять і вмінь",
    ["Professions"] = "Професії",
    ["Specialization"] = "Спеціалізація",
    ["Specializations"] = "Спеціалізації",
    ["Talents"] = "Таланти",
    ["Player Spells and Talents"] = "Закляття й таланти",
    ["Talents & Spellbook"] = "Таланти й книга заклять",
    ["Talents and Spellbook"] = "Таланти й книга заклять",
    ["Quest Log"] = "Журнал квестів",
    ["Guild"] = "Гільдія",
    ["Guild and Communities"] = "Гільдія та спільноти",
    ["Guild & Communities"] = "Гільдія та спільноти",
    ["Communities"] = "Спільноти",
    ["Group Finder"] = "Пошук групи",
    ["Premade Groups"] = "Готові групи",
    ["Looking For Group"] = "Пошук групи",
    ["Dungeon Finder"] = "Пошук підземель",
    ["Store"] = "Крамниця",
    ["Game Menu"] = "Меню гри",
    ["Housing Dashboard"] = "Панель житла",
    ["Housing"] = "Житло",
    ["Collections"] = "Колекції",
    ["Warband Collections"] = "Колекції бойового загону",
    ["Adventure Guide"] = "Путівник пригод",
    ["Encounter Journal"] = "Журнал боїв",
    ["Achievements"] = "Досягнення",
    -- КЛАСИ (дропдауни-фільтри класів у меню; словник обмежений меню/дропдаунами через
    -- Lookup → без колізій з іменами NPC/предметів. Канон = CLASS_UA у ClassSpecHooks).
    ["Warrior"] = "Воїн",
    ["Paladin"] = "Паладин",
    ["Hunter"] = "Мисливець",
    ["Rogue"] = "Розбійник",
    ["Priest"] = "Жрець",
    ["Death Knight"] = "Лицар смерті",
    ["Shaman"] = "Шаман",
    ["Mage"] = "Маг",
    ["Warlock"] = "Чорнокнижник",
    ["Monk"] = "Монах",
    ["Druid"] = "Друїд",
    ["Demon Hunter"] = "Мисливець на демонів",
    ["Evoker"] = "Пробудник",
    -- Назви доповнень (заголовки груп у вікнах репутації/валюти — щоб скрізь однаково).
    -- Канон узгоджено з ns.ejStrings (JourneysHooks) — ЄДИНЕ джерело. Title Case.
    ["Legacy"] = "Спадщина",
    ["The War Within"] = "Війна Всередині",
    ["War Within"] = "Війна Всередині",
    ["Midnight"] = "Опівніч",
    ["Dragonflight"] = "Політ Драконів",
    ["Classic"] = "Класика",
    ["Shadowlands"] = "Тіньокрай",
    ["Legion"] = "Легіон",
    ["Warlords of Draenor"] = "Воєначальники Дренору",
    ["Mists of Pandaria"] = "Тумани Пандарії",
    ["Cataclysm"] = "Катаклізм",
    ["The Burning Crusade"] = "Палаючий Похід",
    ["Burning Crusade"] = "Палаючий Похід",
    ["Wrath of the Lich King"] = "Гнів Короля-Ліча",
    ["Battle for Azeroth"] = "Битва за Азерот",
    -- Сумки (кнопки наплічника/торб)
    ["Backpack"] = "Наплічник",
    ["Combined Backpack"] = "Об'єднаний наплічник",
    ["Reagent Bag"] = "Торба реагентів",
    ["Bag"] = "Торба",
    -- Вікно вибору рівня Глибини (DelvesDifficultyPickerFrame) — сталі ярлики.
    -- Точні рядки доберемо із захоплення (db.ui); тут лише впевнені.
    ["Delve"] = "Глибина",
    ["Delves"] = "Глибини",
    ["Enter Delve"] = "Увійти в Глибину",
    ["Great Vault"] = "Велике Сховище",
    ["View Abilities"] = "Переглянути здібності",
    ["Rewards"] = "Нагороди",
    ["Bountiful"] = "Щедра",
    ["Locked"] = "Заблоковано",
    ["Enter"] = "Увійти",
    ["Chance to receive:"] = "Шанс отримати:",
    ["Chance to receive"] = "Шанс отримати",
    -- нагороди делвів (часті типи)
    ["Trovehunter's Bounty"] = "Здобич шукача скарбів",
    ["Bountiful Coffer"] = "Щедра скриня",
    ["Restored Coffer"] = "Відновлена скриня",
    ["Companion Experience"] = "Досвід супутника",
    -- панель супутника Глибин (Валіра/Бранн): ролі + курйо
    ["Trusty Delve Companion"] = "Надійний супутник Глибин",
    ["Combat Role"] = "Бойова роль",
    ["Combat Curio"] = "Бойове курйо",
    ["Curio"] = "Курйо",
    ["Tank"] = "Танк",
    ["Healer"] = "Цілитель",
    ["Bountiful Heavy Trunk"] = "Щедра важка скриня",
    ["Heavy Trunk"] = "Важка скриня",
    ["Gold"] = "Золото",
}

-- Шаблонні UI-рядки з ЧИСЛАМИ: число = плейсхолдер (%s), лишається недоторканим.
-- Пробуються після точного збігу. Кожен запис: { lua-патерн, формат-рядок }.
local UI_PATTERNS = {
    { "^Tier (%d+)$", "Складність %s" },
    { "^Recommended for adventurers at item level (%d+)%.$",
      "Рекомендовано для шукачів пригод з рівнем предметів %s." },
    { "^Recommended item level: (%d+)$", "Рекомендований рівень предметів: %s" },
    { "^Renown (%d+)$", "Визнання %s" },   -- рівень великих фракцій (число лишається)
    { "^Level (%d+)$", "Рівень %s" },      -- рівень дружби (Valeera тощо)
    { "^Season (%d+)$", "Сезон %s" },      -- групи валют (вікно Валюта)
}

local originals = setmetatable({}, { __mode = "k" })

-- Єдина точка пошуку перекладу: точний збіг -> трейлінг-двокрапка -> шаблони з
-- числами. Повертає укр. рядок або nil. Вживають і Walk, і хук SetText дропдауна.
--
-- ВИМІРЯНО (/uall perf, 9800X3D): «меню/UI: обхід» — 403 виклики, 1724 мс сумарно,
-- 4.28 мс у середньому. Це в сім разів більше за всі інші точки разом. Причина не
-- в обході як такому, а в тому, що Lookup рахувався НАНОВО для кожного напису на
-- кожному проході: на ПРОМАХУ це 6 патернів (кожен ще й з алокацією таблиці на
-- captures), 6 gsub-ів у гілці зі зняттям розмітки і ~14 звернень до словників.
-- Вікно перечитується 4 рази на секунду, тож та сама марна робота повторювалася
-- сотні разів. Кешуємо результат разом із ПРОМАХАМИ (false) — саме промахи й
-- коштували найдорожче, бо проходили ланцюг до кінця.
local Lookup   -- оголошено наперед: LookupRaw рекурсивно кличе кешовану версію
local function LookupRaw(text)
    local ua = UI[text]
    if ua then return ua end
    local base = text:match("^(.-)%s*:%s*$")       -- «Strength:» / «Strength :»
    if base and UI[base] then return UI[base] .. ":" end
    for _, p in ipairs(UI_PATTERNS) do             -- «Tier 7» -> «Складність 7»
        local caps = { text:match(p[1]) }
        if caps[1] ~= nil then return p[2]:format(unpack(caps)) end
    end
    if ns.uiStrings then                           -- панель «Параметри»/меню Esc (globalStrings)
        local u = ns.uiStrings[text]
        if u then return u end
    end
    if ns.factionByName then                       -- назви фракцій/доповнень (репутація)
        local f = ns.factionByName[text]
        if f then return f end
    end
    -- колекції: назви та описи маунтів/улюбленців (журнал колекцій)
    if ns.mountsByName then
        local m = ns.mountsByName[text]; if m then return m end
    end
    if ns.petsByName then
        local p = ns.petsByName[text]; if p then return p end
    end
    if ns.mountsDescByEn then
        local m = ns.mountsDescByEn[text]; if m then return m end
    end
    -- повний набір описів маунтів з wago DB2 (EN опис -> UA), деталь-панель журналу
    if ns.mountDescriptions then
        local m = ns.mountDescriptions[text]; if m then return m end
    end
    if ns.petsDescByEn then
        local p = ns.petsDescByEn[text]; if p then return p end
    end
    -- валюти (вікно Валюта / TokenFrame): ns.currencyByName[en] = {name=...}
    if ns.currencyByName and ns.IsEnabled("currency") then
        local c = ns.currencyByName[text]
        if c and c.name then return c.name end
    end
    -- делв/мапа UI-тексти зі збору (назви глибин, тижневі події, генеричні блоки на
    -- панелі DelvesDifficultyPickerFrame): той самий словник, що й хук наведення-тултіпів.
    if ns.uiTooltips then
        local u = ns.uiTooltips[text]
        if u then return u end
    end
    -- назви світових подій на панелі QuestMapFrame.EventsFrame («Void Assaults»,
    -- «Eversong Woods», «Prey») лежать у словнику цілей квестів.
    if ns.questObjectives then
        local q = ns.questObjectives[text]
        if q then return q end
    end
    -- ОСТАННІЙ шанс: напис із розмітками (іконка |T..|t, колір |c..|r) або зайвими
    -- пробілами не дав точного збігу. Знімаємо розмітку, тримаємо й шукаємо ще раз
    -- (одна рекурсія: stripped ~= text). Так заголовки доповнень у ScrollBox валют,
    -- що приходять із префіксом-текстурою, теж матчаться зі словником.
    local stripped = text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
                         :gsub("|T.-|t", ""):gsub("|A.-|a", "")
                         :gsub("^%s+", ""):gsub("%s+$", "")
    if stripped ~= text and stripped ~= "" then
        return Lookup(stripped)
    end
    return nil
end

-- Кеш ЖИВЕ ДО КІНЦЯ СЕСІЇ: усі словники, які читає LookupRaw, статичні —
-- вони приходять із Database/*.lua і після завантаження не змінюються.
-- Стан «показати оригінал» (Shift) тут не враховується навмисно: його
-- обробляє TranslateFS вище, а не пошук.
local lookupCache, lookupCacheN = {}, 0
-- Лічильник для /uall perf: показує, чи кеш узагалі працює, навіть коли
-- сценарій замало навантажив обхід, щоб точка «меню/UI» зʼявилася в таблиці.
ns.__uiLookupStats = { hit = 0, miss = 0 }
Lookup = function(text)
    if type(text) ~= "string" then return nil end
    local hit = lookupCache[text]
    if hit ~= nil then                          -- false = запам'ятований промах
        ns.__uiLookupStats.hit = ns.__uiLookupStats.hit + 1
        return hit or nil
    end
    ns.__uiLookupStats.miss = ns.__uiLookupStats.miss + 1
    local ua = LookupRaw(text)
    -- запобіжник від безмежного росту: UI-рядків скінченна кількість, але в
    -- капчу можуть потрапляти рядки з числами, що змінюються щокадру
    if lookupCacheN > 20000 then lookupCache, lookupCacheN = {}, 0 end
    lookupCache[text] = ua or false
    lookupCacheN = lookupCacheN + 1
    return ua
end

-- LoadOnDemand-бази (UALL_Items, UALL_NpcNames, UALL_Journal) вантажаться вже
-- в грі, коли гравець вмикає відповідну опцію. Рядок, який ДО того був чесним
-- промахом, після довантаження може стати перекладним — тож на кожне
-- завантаження аддона й на вхід у світ кеш скидаємо. Це кілька разів за сесію,
-- а не в гарячому шляху.
local cacheReset = CreateFrame("Frame")
cacheReset:RegisterEvent("ADDON_LOADED")
cacheReset:RegisterEvent("PLAYER_LOGIN")
cacheReset:SetScript("OnEvent", function()
    lookupCache, lookupCacheN = {}, 0
    ns.__uiLookupStats.hit, ns.__uiLookupStats.miss = 0, 0
end)

-- Підміна напису + реєстрація в ЦЕНТРАЛЬНОМУ реєстрі ns.replacements, щоб Shift
-- свопав їх на НАТИСК (як усюди в аддоні), а не лише при повторному показі вікна.
-- skipFont: НЕ чіпати шрифт цього напису. Для записів НОВОЇ меню-системи
-- (Blizzard_Menu/Compositor) fs:SetFont заборонено (taint «Use of function
-- 'SetFont' is disallowed») — і pcall не глушить, бо Blizzard сам репортить через
-- assertsafe. Меню-шрифт уже показує кирилицю, тож переклад робимо БЕЗ ApplyCyrFont.
-- КОНТЕКСТНІ ВИНЯТКИ [[context-scoped-translation]]. Те саме англійське слово в
-- різних вікнах означає різне: «Mount» у тултіпі предмета — це ТИП («їздова
-- тварина»), а на кнопці Журналу маунтів — ДІЯ («осідлати»). Загальний словник
-- знає лише одну відповідь, тож дію доводиться задавати за місцем.
-- Перевірку робимо ЛИШЕ для кількох двозначних слів, щоб не платити
-- GetDebugName на кожному написі гарячого обходу.
-- Прив'язуємось до ВІКНА, а не до конкретної кнопки: точна назва кнопки в
-- Blizzard змінюється між патчами, а «десь усередині Журналу маунтів» — ні.
-- Слово «Mount» окремим написом трапляється в цьому вікні лише на кнопці дії
-- (вкладка зветься «Mounts», у множині, і це інший рядок).
local AMBIGUOUS = { ["Mount"] = true, ["Dismiss"] = true }
local CONTEXT_OVERRIDE = {
    { window = "MountJournal",
      map = { ["Mount"] = "Осідлати", ["Dismiss"] = "Відкликати" } },
}

local function ContextOverride(fs, text)
    if not AMBIGUOUS[text] then return nil end   -- гарячий шлях: одна перевірка
    local p, name = fs, nil
    for _ = 1, 6 do                              -- напис -> кнопка -> ... -> вікно
        if type(p) ~= "table" then return nil end
        local ok, n = pcall(function()
            return (p.GetName and p:GetName()) or (p.GetDebugName and p:GetDebugName())
        end)
        name = (ok and type(n) == "string") and n or nil
        if name then
            for _, rule in ipairs(CONTEXT_OVERRIDE) do
                if name:find(rule.window, 1, true) and rule.map[text] then
                    return rule.map[text]
                end
            end
        end
        local okp, parent = pcall(function() return p.GetParent and p:GetParent() end)
        if not okp or not parent then return nil end
        p = parent
    end
    return nil
end

local function TranslateFS(fs, skipFont)
    if not fs or not fs.GetText then return end
    local text = ns.SafeText(fs:GetText())
    if not text then return end
    -- КИР. ШРИФТ на КОЖЕН walked-напис (не лише перекладений): декоративні шрифти
    -- заголовків (напр. «Властивості карти» в делв-пікері) не мають «і/ґ/ї/є» → □.
    -- ApplyCyrFont сам пропускає вже-CYR, тож безпечно й ідемпотентно.
    if not skipFont and ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    if ns.ShowOriginal() then
        local pair = originals[fs]
        if pair and ns.SafeText(fs:GetText()) == pair.ua then fs:SetText(pair.en) end -- SafeText: secret-рядок не порівнюємо напряму
        return
    end
    local newt = ContextOverride(fs, text) or Lookup(text)
    if newt and text ~= newt then
        originals[fs] = { en = text, ua = newt }
        if ns.Remember then ns.Remember(fs, text, newt, nil, "interface.menu") end  -- центральний Shift
        fs:SetText(newt)
        if not skipFont and ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end  -- кир. шрифт: інакше □ на «і/ґ/ї/є» у декор. заголовках (делв-меню тощо)
    elseif not newt and ns.debug and not ns.HasCyrillic(text) and text:find("%a")
           and #text < 80 then
        -- ЗАХОПЛЕННЯ непокритих UI-рядків у SavedVariables (db.ui). Відкрий вікно
        -- (напр. вибір рівня Глибини) -> /reload -> надішли файл. Виміряти, потім перекласти.
        local db = ns.GetCaptureDB and ns.GetCaptureDB()
        if db then db.ui = db.ui or {}; db.ui[text] = true end
    end
end

-- GameTooltip:SetOwner ПЕРЕПАРЕНТОВУЄ тултіп у фрейм-власник → генеричні walk-ери
-- відкритих вікон (разові й тікерні) діставались до GameTooltipTextLeft* і вішали
-- на них ВІЧНИЙ SetText-Lookup, який перекладав УСІ тултіпи повз гейти (зокрема
-- назви данжів у вікні I попри вимкнену groupfinder.names). Тултіпи мають СВОЇ
-- хуки — у генеричні обходи їм зась.
local function IsTooltipFrame(f)
    if f == GameTooltip then return true end
    if type(f) == "table" and f.GetObjectType then
        local ok, t = pcall(f.GetObjectType, f)
        return ok and t == "GameTooltip"
    end
    return false
end

local function Walk(frame, depth)
    if not frame or depth > 8 or not frame.IsShown or not frame:IsShown() then
        return
    end
    if IsTooltipFrame(frame) then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") then
                ns.Guard("інтерфейс", TranslateFS, rg)
            end
        end
    end
    if frame.GetChildren then
        for _, child in ipairs(ns.Children(frame)) do
            Walk(child, depth + 1)
        end
    end
end

local function Refresh(frame)
    if not ns.IsEnabled("interface.menu") then return end
    ns.Guard("інтерфейс", Walk, frame, 1)
end

-- Нова меню-система WoW (випадні списки) рендериться з ДАНИХ: при кожному
-- перемиканні текст кнопки й записів перемальовується з нуля -> наша підміна
-- після факту відкочується в англ. (той самий «бій з оригіналом»). Тому ловимо
-- В ТОЧЦІ, де текст ставиться: hooksecurefunc на SetText (пост-виклик, без тейнту).
-- Це тримається попри перемикання. Кирилицю пропускаємо -> без рекурсії/циклів.
local function HookTextSetter(fs)
    if type(fs) ~= "table" or fs.__ua_txt or type(fs.SetText) ~= "function" then return end
    fs.__ua_txt = true
    pcall(hooksecurefunc, fs, "SetText", function(self, txt)
        txt = ns.SafeText(txt)   -- secret-рядки (захищені спели в бою) → nil, без помилки
        if type(txt) ~= "string" or ns.HasCyrillic(txt) then return end
        if not ns.IsEnabled("interface.menu") then return end
        if ns.ShowOriginal and ns.ShowOriginal() then return end
        -- і тут теж контекст: кнопку Журналу гра перепідписує Mount<->Dismiss
        -- при зміні стану, тобто повз разовий обхід
        local newt = ContextOverride(self, txt) or Lookup(txt)
        if newt and newt ~= txt then
            originals[self] = { en = txt, ua = newt }
            if ns.Remember then ns.Remember(self, txt, newt, nil, "interface.menu") end
            self:SetText(newt)
            -- БЕЗ ApplyCyrFont: меню-написи (Blizzard_Menu) забороняють SetFont (taint)
        end
    end)
end

-- Записи відкритого меню (анонімний фрейм) — чіпляємо SetText на КОЖНОМУ FontString
-- меню, тоді переклад тримається навіть при перемальовці меню з даних.
local HookMenuTexts   -- оголошено наперед: нижче загортаємо в профайлер
local function HookMenuTextsRaw(menu, depth)
    if not menu or depth > 8 or type(menu) ~= "table" then return end
    if IsTooltipFrame(menu) then return end
    if menu.GetRegions then
        for _, rg in ipairs(ns.Regions(menu)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") then
                HookTextSetter(rg)
                ns.Guard("інтерфейс", TranslateFS, rg, true)   -- одразу перекласти; skipFont=true (меню забороняє SetFont)
            end
        end
    end
    if menu.GetChildren then
        -- рекурсія йде в RAW: профайлер міряє ВЕСЬ обхід одним записом,
        -- інакше кожен рівень вкладеності рахувався б окремим викликом
        for _, c in ipairs(ns.Children(menu)) do if not ns.IsTooltipFrame(c) then HookMenuTextsRaw(c, depth + 1) end end
    end
end

HookMenuTexts = function(menu, depth)
    return ns.Prof("меню/UI: обхід", HookMenuTextsRaw, menu, depth)
end

local function WalkMenu(menu)
    if not menu then return end
    pcall(HookMenuTexts, menu, 0)
    if C_Timer then C_Timer.After(0.03, function() pcall(HookMenuTexts, menu, 0) end) end
end

-- Кнопка-дропдаун нової системи має один із методів: OnMenuOpen / SetupMenu /
-- IsMenuOpen. Знаходимо її серед дітей вікна, чіпляємо текст (кнопки) і меню.
local function isDropdown(c)
    return type(c) == "table" and (type(c.OnMenuOpen) == "function"
        or type(c.SetupMenu) == "function" or type(c.IsMenuOpen) == "function")
end

-- Дістати відкрите меню кнопки-дропдауна кількома шляхами (поле/метод залежить
-- від версії міксина) і пройтися по ньому.
local function CaptureOpenMenu(btn, menu)
    if not menu and type(btn) == "table" then
        menu = rawget(btn, "menu")
        if not menu and type(btn.GetMenu) == "function" then
            local ok, m = pcall(btn.GetMenu, btn); if ok then menu = m end
        end
    end
    if not menu and Menu and type(Menu.GetOpenMenu) == "function" then
        local ok, m = pcall(Menu.GetOpenMenu); if ok then menu = m end
    end
    if ns.debug and ns.Diag then
        local nm = (type(menu) == "table" and menu.GetName and menu:GetName()) or "анонім"
        ns.Diag("дропдаун: меню " .. (menu and ("знайдено [" .. nm .. "]") or "НЕ знайдено"))
    end
    if menu then WalkMenu(menu) end
end

local function HookDropdownButtons(root)
    if not root then return end
    local function scan(f, depth)
        if depth > 6 or type(f) ~= "table" or not f.GetChildren then return end
        for _, c in ipairs(ns.Children(f)) do
            if isDropdown(c) and not c.__ua_menu then
                c.__ua_menu = true
                -- текст самої кнопки (вибрана складність) — тримати переклад
                HookTextSetter(c.Text)
                if c.GetFontString then HookTextSetter(c:GetFontString()) end
                -- меню відкривається через один із цих методів (залежить від версії);
                -- після виклику дістаємо фрейм меню й перекладаємо його записи.
                for _, m in ipairs({ "OnMenuOpen", "OpenMenu", "ToggleMenu" }) do
                    if type(c[m]) == "function" then
                        pcall(hooksecurefunc, c, m, function(self, arg)
                            local menu = (type(arg) == "table") and arg or nil
                            if C_Timer then
                                C_Timer.After(0, function() CaptureOpenMenu(self, menu) end)
                            else
                                CaptureOpenMenu(self, menu)
                            end
                        end)
                    end
                end
                -- запасний шлях: CallbackRegistry-подія
                if type(c.RegisterCallback) == "function" then
                    pcall(c.RegisterCallback, c, "OnMenuOpen", function()
                        if C_Timer then C_Timer.After(0, function() CaptureOpenMenu(c) end) end
                    end, c)
                end
            end
            scan(c, depth + 1)
        end
    end
    ns.Guard("інтерфейс", scan, root, 0)
end

-- Меню Esc і вікно налаштувань вантажаться на вимогу — ловимо їхню появу.
local TARGETS = { "GameMenuFrame", "SettingsPanel", "VideoOptionsFrame",
                  "InterfaceOptionsFrame", "ChatConfigFrame", "CharacterFrame",
                  "DelvesDifficultyPickerFrame", "ReputationFrame",
                  -- Панель супутника Глибин (Валіра/Бранн): ролі, бойові курйо, описи.
                  -- Список курйо — ScrollBox (data-driven), тому ще й у DATA_DRIVEN.
                  "DelvesCompanionConfigurationFrame",
                  "CollectionsJournal", "MountJournal", "PetJournal",
                  -- ⚠️ TokenFrame (вікно «Валюта») НАВМИСНО ВИКЛЮЧЕНО [[bagsearch-setmatches-taint]].
                  -- Клік по рядку валюти відкриває меню з ПЕРЕКАЗОМ на іншого персонажа —
                  -- захищена дія. Будь-який наш запис у написи цих рядків тейнтить їх, і меню
                  -- перестає відкриватися ВЗАГАЛІ (перевірено тестером: з вимкненим перекладом
                  -- меню працює; Shift не рятує, бо фрейм уже затейнтований до /reload).
                  -- Відкладення підміни на наступний кадр теж НЕ допомогло — тейнт чіпляється
                  -- до самого напису. Тому назви валют тут лишаються англійськими; у ТУЛТІПАХ
                  -- валют переклад працює (CurrencyHooks — там тултіп, не захищений шлях).
                  -- Повертати сюди можна ЛИШЕ через оверлей (власний FontString на UIParent,
                  -- прианкорений до рядка), який не пише в їхні об'єкти.
                  -- банер-тост подій/сценаріїв (EventToastManager): заголовок+опис
                  -- ставляться через SetText на currentDisplayingToast → self-heal ловить
                  "EventToastManagerFrame" }
-- ДАНІ-КЕРОВАНІ вікна (ScrollBox перемальовує рядки з даних при прокрутці): тут
-- замість разового Walk вішаємо SetText-хук на КОЖЕН напис (HookMenuTexts), щоб
-- переклад тримався при ре-рендері, + дропдаун-фільтри + дефер на пізні рядки.
local DATA_DRIVEN = { DelvesDifficultyPickerFrame = true, ReputationFrame = true,
                      DelvesCompanionConfigurationFrame = true,
                      EventToastManagerFrame = true,
                      CollectionsJournal = true, MountJournal = true, PetJournal = true,
                      -- TokenFrame свідомо НЕ тут — див. коментар у TARGETS (тейнт переказу валют).
                      -- Панель «Параметри» (нова Settings-система) — ScrollBox перемальовує
                      -- рядки опцій при прокрутці/зміні категорії БЕЗ повторного OnShow,
                      -- тож потрібні SetText-хуки + ScrollBox-Update + тікер, а не разовий Walk.
                      SettingsPanel = true }
local hooked = {}

-- ВКЛАДКИ КОЛЕКЦІЙ (CollectionsJournalTabN): наш переклад довший за англ., а ширину
-- кнопки-вкладки Blizzard рахує ПІД АНГЛ. до нашого перекладу → на ПЕРШОМУ відкритті
-- текст обрізається «…» (на наступних гра робить re-layout і вміщає). Після перекладу
-- перераховуємо ширину під поточний (UA) текст (PanelTemplates_TabResize), сусідні
-- реанкоряться самі. Self-heal: на КОЖЕН SetText тексту вкладки — резайз знову.
local function ResizeCollectionsTabs()
    if not (PanelTemplates_TabResize and _G.CollectionsJournal) then return end
    for i = 1, 10 do
        local tab = _G["CollectionsJournalTab" .. i]
        if tab and tab.GetName then pcall(PanelTemplates_TabResize, tab, 0) end
    end
end
local ctHooked = setmetatable({}, { __mode = "k" })
local function HookCollectionsTabs()
    if not _G.CollectionsJournal then return end
    for i = 1, 10 do
        local tab = _G["CollectionsJournalTab" .. i]
        local fs = tab and (tab.Text or _G["CollectionsJournalTab" .. i .. "Text"])
        if fs and not ctHooked[fs] and type(fs.SetText) == "function" then
            ctHooked[fs] = true
            hooksecurefunc(fs, "SetText", function()
                if C_Timer then C_Timer.After(0, ResizeCollectionsTabs) else ResizeCollectionsTabs() end
            end)
        end
    end
    -- одразу + відкладено (текст вкладки могли перекласти після нашого проходу)
    ResizeCollectionsTabs()
    if C_Timer then C_Timer.After(0, ResizeCollectionsTabs); C_Timer.After(0.1, ResizeCollectionsTabs) end
end

local function HookDataFrame(self)
    if not ns.IsEnabled("interface.menu") then return end
    pcall(HookMenuTexts, self, 0)
    HookDropdownButtons(self)
    if self == _G.CollectionsJournal then ns.Guard("інтерфейс", HookCollectionsTabs) end
    -- Хук оновлення ScrollBox(ів): при прокрутці/РОЗГОРТАННІ секцій з'являються нові
    -- елементи (заголовки .Name у згорнутих групах валют/репутації), яких разовий
    -- walk не зачепив. Після кожного Update ре-walk фрейму (ідемпотентно).
    local function hookSB(f, d)
        if type(f) ~= "table" or d > 6 then return end
        -- ScrollBox = має метод Update І посилання ScrollTarget (надійніше за GetView)
        local isSB = type(f.Update) == "function"
            and (rawget(f, "ScrollTarget") or type(f.GetView) == "function"
                 or type(f.SetDataProvider) == "function" or type(f.GetDataProvider) == "function")
        if isSB and not f.__ua_sb then
            f.__ua_sb = true
            pcall(hooksecurefunc, f, "Update", function()
                if C_Timer then C_Timer.After(0, function() pcall(HookMenuTexts, self, 0) end)
                else pcall(HookMenuTexts, self, 0) end
            end)
            -- СИНХРОННО на ініціалізацію КОЖНОГО рядка ScrollBox: переклад у мить,
            -- коли Blizzard прив'язує рядок до даних (до промальовування), а не
            -- відкладено через Update. Прибирає блимання рядків, що з'являються
            -- після OnShow (напр. перші в групі — «Кампанія»/«Підземелля» в легенді).
            if type(f.RegisterCallback) == "function" and ScrollBoxListViewMixin
               and ScrollBoxListViewMixin.Event and ScrollBoxListViewMixin.Event.OnInitializedFrame then
                pcall(f.RegisterCallback, f, ScrollBoxListViewMixin.Event.OnInitializedFrame,
                      function(_, child) pcall(HookMenuTexts, child, 0) end, f)
            end
        end
        if f.GetChildren then for _, c in ipairs(ns.Children(f)) do if not ns.IsTooltipFrame(c) then hookSB(c, d + 1) end end end
    end
    ns.Guard("інтерфейс", hookSB, self, 0)
    if C_Timer then
        C_Timer.After(0.05, function() pcall(HookMenuTexts, self, 0); HookDropdownButtons(self) end)
        C_Timer.After(0.3, function() pcall(HookMenuTexts, self, 0); HookDropdownButtons(self) end)
    end
    -- СТРАХОВКА від ScrollBox-розгортання: коли гравець розкриває згорнуту групу
    -- (доповнення у вікні Валюти), нові рядки-ЗАГОЛОВКИ створюються з пулу ПІСЛЯ
    -- нашого walk, а хук Update інколи не ловить цей шлях. Поки вікно показане —
    -- легкий ре-walk раз на ~0.25с (ідемпотентний: HookTextSetter і TranslateFS
    -- мають guard). Зупиняється сам, щойно вікно сховали.
    if C_Timer and not self.__ua_ticker then
        self.__ua_ticker = true
        local function tick()
            if not (self.IsShown and self:IsShown()) then
                self.__ua_ticker = false
                return
            end
            pcall(HookMenuTexts, self, 0)
            C_Timer.After(0.25, tick)
        end
        C_Timer.After(0.25, tick)
    end
end

local function TryHook()
    for _, name in ipairs(TARGETS) do
        local f = _G[name]
        if f and not hooked[name] and f.HookScript then
            hooked[name] = true
            local dataDriven = DATA_DRIVEN[name]
            -- Вікно персонажа має ОКРЕМИЙ перемикач interface.character (тестер хотів
            -- вимикати саме це вікно, не чіпаючи меню Esc/налаштування).
            local isChar = (name == "CharacterFrame")
            local function doRefresh(self)
                if dataDriven then HookDataFrame(self)
                elseif isChar then
                    if ns.IsEnabled("interface.character") then Refresh(self) end
                else Refresh(self) end
            end
            f:HookScript("OnShow", doRefresh)
            if f:IsShown() then doRefresh(f) end
        end
    end
    -- QuestMapFrame.EventsFrame (панель «Події» на карті, Midnight) — ДИТЯ
    -- QuestMapFrame, тож не в _G-TARGETS. ScrollBox перемальовує рядки подій з
    -- даних → разовий walk ловить не все (звідси частковий переклад). Чіпляємо
    -- як data-driven: HookDataFrame = SetText-self-heal на КОЖЕН напис + хук
    -- ScrollBox:Update + страховий тікер. Заголовки («Поточні події»/«Розклад
    -- подій»/«Події») і назви подій (Lookup тепер бачить і questObjectives).
    local ef = QuestMapFrame and QuestMapFrame.EventsFrame
    if ef and ef.HookScript and not hooked["__EventsFrame"] then
        hooked["__EventsFrame"] = true
        ef:HookScript("OnShow", function(self) ns.Guard("інтерфейс", HookDataFrame, self) end)
        if ef:IsShown() then ns.Guard("інтерфейс", HookDataFrame, ef) end
    end
    -- QuestMapFrame.MapLegend (вікно «Легенда» карти) — теж дитя QuestMapFrame зі
    -- ScrollBox (MapLegendScrollFrame). Раніше ловилось лише повільним обходом →
    -- ~1с блимання англ.→UA при відкритті. HookDataFrame дає self-heal на SetText
    -- (синхронно в тому ж кадрі) + хук ScrollBox + швидкий дефер, тож блимання зникає.
    local ml = QuestMapFrame and QuestMapFrame.MapLegend
    if ml and ml.HookScript and not hooked["__MapLegend"] then
        hooked["__MapLegend"] = true
        ml:HookScript("OnShow", function(self) ns.Guard("інтерфейс", HookDataFrame, self) end)
        if ml:IsShown() then ns.Guard("інтерфейс", HookDataFrame, ml) end
    end
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("PLAYER_ENTERING_WORLD")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", TryHook)
TryHook()

-- ── Вікно персонажа ПЕРЕМАЛЬОВУЄ написи статів при оновленні (вхід/вихід із бою,
-- проки, зміна споряди), скидаючи мітки на англ. Перекладаємо ЗНОВУ — але СИНХРОННО
-- в хуку (він біжить ПІСЛЯ оновлення Blizzard у ТОМУ Ж кадрі), тож напис завершує
-- кадр українською й НЕ блимає. Відкладати (C_Timer) НЕ можна — саме defer і давав
-- війну «англ. цей кадр / укр. наступний». SetText безпечний у бою (не protected).
-- Перемальовуються лише НАЗВИ статів у CharacterStatsPane (числа/відсотки наш
-- словник не чіпає). Тож чіпаємо ТІЛЬКИ цю панель, а не все вікно — легко й точно.
-- SELF-HEAL для панелі статів: перемикання вкладок (Персонаж→Валюта/Репутація→назад)
-- перемальовує стат-лейбли, а одноразовий Walk на UpdateStats ловив лише частину
-- (гонка) → половина статів «залипала» англ. Вішаємо hooksecurefunc SetText на КОЖЕН
-- стат-лейбл (той самий HookTextSetter, що для меню): будь-яка перемальовка одразу
-- ре-перекладає через Lookup (той, що вже перекладає «Сила»/«Універсальність»).
-- Self-heal стат-лейблів під ОКРЕМИМ перемикачем interface.character (не menu):
-- на кожну перемальовку ре-перекладаємо, АЛЕ лише якщо вікно персонажа увімкнене —
-- тож вимикач діє наживо, навіть коли лейбл уже був зачеплений (не потрібен /reload).
local function HookStatSetter(fs)
    if type(fs) ~= "table" or fs.__ua_stat or type(fs.SetText) ~= "function" then return end
    fs.__ua_stat = true
    pcall(hooksecurefunc, fs, "SetText", function(self)
        if not ns.IsEnabled("interface.character") then return end
        ns.Guard("інтерфейс", TranslateFS, self)
    end)
end
local function StatSelfHealWalk(frame, depth)
    if not frame or depth > 5 or type(frame) ~= "table" then return end
    if IsTooltipFrame(frame) then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") then
                HookStatSetter(rg)       -- self-heal проти перемальовки (гейт interface.character)
                ns.Guard("інтерфейс", TranslateFS, rg)   -- одразу перекласти наявне
            end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then StatSelfHealWalk(c, depth + 1) end end
    end
end
local function RefreshCharacter()
    if not ns.IsEnabled("interface.character") then return end
    local pane = _G["CharacterStatsPane"]
    if pane and pane.IsShown and pane:IsShown() then
        ns.Guard("інтерфейс", StatSelfHealWalk, pane, 1)   -- синхронно, лише панель статів + self-heal
    end
end
if type(_G.PaperDollFrame_UpdateStats) == "function" then
    hooksecurefunc("PaperDollFrame_UpdateStats", RefreshCharacter)
else
    -- запасний шлях лише якщо точного хука нема: рідкісні події бою (теж синхронно)
    local statEv = CreateFrame("Frame")
    for _, e in ipairs({ "PLAYER_REGEN_DISABLED", "PLAYER_REGEN_ENABLED" }) do
        pcall(statEv.RegisterEvent, statEv, e)
    end
    statEv:SetScript("OnEvent", RefreshCharacter)
end
-- ПЕРЕМИКАННЯ ВКЛАДОК: повернення Валюта/Репутація→Персонаж НЕ кличе UpdateStats,
-- а панель ре-показується з ПУЛЕНИХ фреймів (нові FontString, не зачеплені) → усе
-- англ. Тому чіпляємось на OnShow самої панелі статів (і PaperDollFrame): при
-- кожному показі — re-walk + self-heal нових лейблів. + один відкладений прохід
-- (пул наповнюється в тому ж/наступному кадрі); self-heal ідемпотентний, без блимання.
local function HookStatsShow()
    for _, name in ipairs({ "CharacterStatsPane", "PaperDollFrame" }) do
        local fr = _G[name]
        if fr and fr.HookScript and not fr.__uall_stats then
            fr.__uall_stats = true
            fr:HookScript("OnShow", function()
                RefreshCharacter()
                if C_Timer then C_Timer.After(0, RefreshCharacter) end
            end)
        end
    end
end
HookStatsShow()
if CharacterFrame and CharacterFrame.HookScript then
    CharacterFrame:HookScript("OnShow", HookStatsShow) -- на випадок пізнього створення фреймів
end

-- ── Повідомлення центру екрана (UIErrorsFrame): помаранчеві/червоні сповіщення
-- на кшталт «You sense a nearby Skyriding Glyph.». Перекладаємо ВІДОБРАЖЕННЯ —
-- обгортка над AddMessage (UIErrorsFrame НЕ secure → без тейнту, на відміну від
-- перезапису глобал-рядка). Шаблони: %s = плейсхолдер; назву об'єкта (Skyriding
-- Glyph) доперекладаємо через ns.npcNames. Невідомі рядки в debug → db.uierr.
local ERR_TEMPLATES = {
    { "^You sense a nearby (.+)%.$", "Ти відчуваєш неподалік %s." },
}
local function TranslateErr(msg)
    msg = ns.SafeText(msg)   -- secret-рядки в бою → nil, без помилки порівняння
    if type(msg) ~= "string" or ns.HasCyrillic(msg) then return nil end
    for _, t in ipairs(ERR_TEMPLATES) do
        local cap = msg:match(t[1])
        if cap then
            local name = (ns.npcNames and ns.npcNames[cap]) or cap
            return t[2]:format(name)
        end
    end
    return nil
end

local function maybeCapture(msg, tag)
    msg = ns.SafeText(msg)
    if not (ns.debug and type(msg) == "string") then return end
    if ns.Diag then ns.Diag("[" .. tag .. "] " .. msg:gsub("|", "||")) end
    if not ns.HasCyrillic(msg) and msg:find("%a") then
        local db = ns.GetCaptureDB and ns.GetCaptureDB()
        if db then db.uierr = db.uierr or {}; db.uierr[msg] = true end
    end
end

-- Обгортка довільного методу-додавання повідомлення на фреймі (display-only).
local function wrapMethod(f, method, tag)
    if not f or f["__ua_" .. method] or type(f[method]) ~= "function" then return false end
    f["__ua_" .. method] = true
    local orig = f[method]
    f[method] = function(self, msg, ...)
        if type(msg) == "string" then
            if ns.IsEnabled and ns.IsEnabled("interface.menu") then
                local ua = TranslateErr(msg)
                if ua then msg = ua else maybeCapture(msg, tag) end
            else
                maybeCapture(msg, tag)
            end
        end
        return orig(self, msg, ...)
    end
    return true
end

local function HookErrors()
    local done = {}
    for _, name in ipairs({ "UIErrorsFrame" }) do
        local f = _G[name]
        if wrapMethod(f, "AddMessage", name) then done[#done + 1] = name .. ":AddMessage" end
        if wrapMethod(f, "AddExternalErrorMessage", name) then done[#done + 1] = name .. ":AddExt" end
    end
    if ns.debug and ns.Diag then
        ns.Diag("err-хук: " .. (#done > 0 and table.concat(done, ",") or "НЕ встановлено"))
    end
end
HookErrors()

-- ДІАГНОСТИКА каналу (debug): слухаємо самі події, щоб порівняти з тим, що бачить
-- обгортка AddMessage. Якщо подія є, а [UIErrorsFrame:AddMessage] нема — текст
-- виводиться іншим фреймом, і його треба обгорнути окремо.
local errDiag = CreateFrame("Frame")
errDiag:RegisterEvent("UI_ERROR_MESSAGE")
errDiag:RegisterEvent("UI_INFO_MESSAGE")
errDiag:SetScript("OnEvent", function(_, ev, a, b)
    if not ns.debug then return end
    local msg = (type(b) == "string" and b) or (type(a) == "string" and a) or tostring(a)
    if ns.Diag then ns.Diag("[event " .. ev .. "] " .. tostring(msg):gsub("|", "||")) end
end)

-- Допоміжне для тултіпів мікро-меню/сумок (юзає OnEnter-підхід нижче).
local function stripColor(s)
    return (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|cn[%a_]+:", ""):gsub("|r", ""))
end
-- Рядки місткості сумок із ЧИСЛАМИ (число лишається).
local TT_LINE_PATTERNS = {
    { "^(%d+) Empty Slots %(Total%)$", "%s порожніх комірок (усього)" },
    { "^(%d+) Free Slots$", "%s вільних комірок" },
    { "^(%d+) Slots$", "%s комірок" },
}

-- Шаблонні рядки GameTooltip із ЧИСЛАМИ (меню делвів тощо). Перекладаємо ЛИШЕ
-- рядки, що збіглися зі шаблоном (число зберігаємо). Це пост-обробка ПОКАЗАНОГО
-- тултіпа (display-only) — без override GlobalString, без тейнту. «Tier»=«Складність»
-- (узгоджено з дропдауном складності делвів).
-- Точні рядки (мітки/описи делв-тултіпів мапи). Delve=«глибина» (домінантний термін).
local TT_EXACT = {
    ["Bountiful Delve"] = "Щедра глибина",
    ["This delve contains a bonus treasure chest that can be opened with a Restored Coffer Key."]
        = "Ця глибина містить додаткову скриню зі скарбом, яку можна відкрити Відновленим ключем від скрині.",
    -- «Gilded Stash» = «Позолочена схованка» (єдиний термін; «схованка» точніше за «скарб»).
    ["Gilded Stash"] = "Позолочена схованка",
    ["Upon delve completion with lives remaining, a Gilded Stash will appear in the treasure room."]
        = "Завершивши глибину зі збереженими життями, ти знайдеш Позолочену схованку в кімнаті скарбів.",
    ["Resets weekly."] = "Скидається щотижня.",
}
local TT_FORMAT_PATTERNS = {
    { "^Recommended for adventurers at item level (%d+)%.$",
      "Рекомендовано шукачам пригод із рівнем предметів %s." },
    { "^Requires completion of a Tier (%d+) delve with lives remaining%.$",
      "Потрібно завершити делв Складності %s, зберігши життя." },
    { "^Story Variant: (.+)$", "Варіант історії: %s" }, -- назву делву лишаємо (нема в базі)
    { "^Gilded Stash looted: (%d+)/(%d+)$", "Золочена схованка зібрана: %s/%s" },
    { "^Time Left: (%d+) Hr (%d+) Min$", "Залишилось: %s год %s хв" },
    { "^Time Left: (%d+) Hr$", "Залишилось: %s год" },
    { "^Time Left: (%d+) Min$", "Залишилось: %s хв" },
    -- Тултіп гільдійної групи: назву ГІЛЬДІЇ гра вписує посеред речення. Лише
    -- шаблон — назву лишаємо як є [[guild-names-never-translate]]; точні ключі з
    -- назвами гільдій прибрано з бази, їх ловить _check_guild_leak.py.
    { "^At least (%d+) out of (%d+) players in your group are members of (.+)%. Guild achievements can be earned%.$",
      "Щонайменше %s з %s гравців у вашій групі — учасники гільдії %s. Можна здобувати досягнення гільдії." },
    { "^Your entire group is composed of guild members of (.+)%. Guild achievements can be earned%.$",
      "Уся ваша група складається з учасників гільдії %s. Можна здобувати досягнення гільдії." },
}
-- Plain (не-патерн) заміна підрядка зі збереженням решти (іконка|колір|число).
local function ttPlainReplace(s, find, repl)
    find = find:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
    repl = repl:gsub("%%", "%%%%")
    return (s:gsub(find, repl))
end
-- ЗБИРАЧ неперекладених рядків делв/мапа-тултіпів у db.uitooltip (для майбутньої
-- хвилі). Лише коли відкрито делв-пікер АБО мапу — щоб не збирати весь UI підряд.
-- Прибираємо текстури/іконки й колір; беремо «справжній» текст (з літерами).
local function ttStripAll(s)
    -- \r\n → \n: гра шле абзаци тултіпа з \r\n, а наша база зберігає лише \n
    -- (generate_db/JSON зрізають \r) — без цього багатоабзацні описи НЕ матчились.
    return (s:gsub("\r\n", "\n"):gsub("\r", "\n")
             :gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|cn[%a_]+:", ""):gsub("|r", "")
             :gsub("|T.-|t", ""):gsub("|A.-|a", ""):gsub("^%s+", ""):gsub("%s+$", ""))
end
-- Тултіп КВЕСТОВОГО ОБ'ЄКТА має рядок-ціль формату «- 0/1 …» (лічильник прогресу
-- на ПОЧАТКУ рядка). Тоді збираємо і його назву (форж-компоненти: Void Repository,
-- Void Brazier тощо), хоч делв-пікер/мапа й не відкриті. Прапор рахуємо ОДИН раз
-- на тултіп (у TranslateTooltipFormatLines), щоб не сканувати рядки повторно.
local ttQuestCtx = false
-- Тултіп групи з пошуку / заявника / Швидкого вступу: власник (або його предок)
-- — рядок списку з resultID/applicantID чи одне з вікон, де показано назви груп.
local ttLFGCtx = false
local LFG_TIP_ROOTS = { "LFGListFrame", "QuickJoinFrame", "LFGListInviteDialog",
                        "LFGListApplicationDialog", "QuickJoinToastButton" }
local function IsPlayerGroupTip(tt)
    local owner = tt and tt.GetOwner and tt:GetOwner()
    local depth = 0
    while owner and depth < 12 do
        if type(owner) ~= "table" then return false end
        if owner.resultID ~= nil or owner.applicantID ~= nil then return true end
        for _, fn in ipairs(LFG_TIP_ROOTS) do
            if _G[fn] and owner == _G[fn] then return true end
        end
        owner = owner.GetParent and owner:GetParent()
        depth = depth + 1
    end
    return false
end
local function TooltipHasQuestObjective(tt)
    if not tt or not tt.NumLines then return false end
    for i = 1, tt:NumLines() do
        local fs = _G["GameTooltipTextLeft" .. i]
        local t = fs and fs.GetText and ns.SafeText(fs:GetText()) -- SafeText: secret→nil (інакше t:find кидає краш)
        if type(t) == "string" and t:find("^%s*%-?%s*%d+%s*/%s*%d+%s+%S") then
            return true
        end
    end
    return false
end
-- Тултіп ВУЗЛА ЗБОРУ (трава/руда/шкура/риба): має рядок-субтитр професії, напр.
-- «Midnight Herbalism» / «Mining». Тоді збираємо назву об'єкта (1-й рядок),
-- щоб перекласти, бо це GameObject (не предмет, інший шлях).
local ttGatherCtx = false
local GATHER_SKILLS = { "Herbalism", "Mining", "Skinning", "Fishing" }
local function TooltipHasGatherSkill(tt)
    if not tt or not tt.NumLines then return false end
    for i = 2, tt:NumLines() do -- з 2-го: 1-й = назва об'єкта
        local fs = _G["GameTooltipTextLeft" .. i]
        local t = fs and fs.GetText and ns.SafeText(fs:GetText()) -- SafeText: secret→nil (інакше #t/t:match кидає краш)
        if type(t) == "string" and #t < 40 then
            for _, sk in ipairs(GATHER_SKILLS) do
                if t:match(sk .. "$") then return true end -- рядок ЗАКІНЧУЄТЬСЯ скілом
            end
        end
    end
    return false
end
-- Рядки, які гра СКЛЕЮЄ на льоту з живих значень: таймер, лічильник, особистий
-- рекорд, «• Ім'я». Кожне значення дає окремий ключ, тож їх нескінченно багато,
-- і в грі іншого гравця той самий рядок не повториться — перекладати марно.
-- Зі збору 66 такі рядки з'їдали 1340 із 3346 «нових» (ще 450 просто вже були
-- в базі). Тому відсіюємо їх ТУТ, а не потім у підготовці хвиль.
local TT_GENERATED = {
    "^[•·]%s",                       -- «• Matriarch Remalla» (ім'я вже в npcNames)
    "^Time Left:", "^Next move:", "^Next Feast:", "^Respawn",
    "^Ends in", "^Starts in",
    "#%d+%s*$",                      -- «Luminous Dust #111»
    "[Bb]est time",                  -- «Your best time: 64.411s»
    "%d+%.%d+s%f[%A]",               -- час кола в перегонах
    ":%s*Gold%]?$", ":%s*Silver%]?$", ":%s*Bronze%]?$",
    "^Item Level%s+%d", "^Coords?:", "^Coordinates:",
    "^Location:", "^Next to%s", "^Found at%s",
}
local function ttIsGenerated(s)
    for _, p in ipairs(TT_GENERATED) do
        if s:find(p) then return true end
    end
    return false
end

local function CaptureUITooltip(text)
    if not text or ns.HasCyrillic(text) then return end
    if ttLFGCtx then return end -- тултіп групи/заявки: назви груп і коментарі пишуть гравці
    if GameTooltip.GetUnit and GameTooltip:GetUnit() then return end -- юніт-тултіп: ім'я/гільдія/титул динамічні, не збираємо
    local inDelve = DelvesDifficultyPickerFrame and DelvesDifficultyPickerFrame.IsShown
        and DelvesDifficultyPickerFrame:IsShown()
    -- панель супутника Глибин (курйо/ролі) — тултіпи курйо ловимо так само
    local inCompanion = DelvesCompanionConfigurationFrame and DelvesCompanionConfigurationFrame.IsShown
        and DelvesCompanionConfigurationFrame:IsShown()
    local inMap = WorldMapFrame and WorldMapFrame.IsShown and WorldMapFrame:IsShown()
    if not (inDelve or inCompanion or inMap or ttQuestCtx or ttGatherCtx) then return end
    local clean = ttStripAll(text)
    if not clean:find("%a") or #clean < 2 or #clean > 800 then return end -- 800: довгі описи курйо
    if ttIsGenerated(clean) then return end
    local db = ns.GetCaptureDB and ns.GetCaptureDB()
    if db then db.uitooltip = db.uitooltip or {}; db.uitooltip[clean] = true end
end
local ttFmtBusy = false
local function TranslateTooltipFormatLines()
    if ttFmtBusy then return end
    if not ns.IsEnabled("interface.menu") then return end
    local tt = GameTooltip
    if not tt or not tt.NumLines or not tt:IsShown() then return end
    -- НЕ виходимо при Shift: усе одно проходимо рядки й РЕЄСТРУЄМО пару (ns.Remember),
    -- щоб жива зміна Shift свопала тултіп В ОБИДВА боки навіть коли він уже показаний.
    -- Лише САМ показ обираємо за станом: Shift тримається → лишаємо оригінал.
    local showOrig = ns.ShowOriginal and ns.ShowOriginal()
    ttQuestCtx = TooltipHasQuestObjective(tt) -- ОДИН раз на тултіп: чи це квест-об'єкт
    ttGatherCtx = TooltipHasGatherSkill(tt)   -- …або вузол збору (трава/руда/шкура/риба)
    -- ЮНІТ-ТУЛТІП (наведення на гравця/моба): ім'я+титул і ГІЛЬДІЯ — динамічні.
    -- Гільдію НЕ перекладаємо (guild-names-never-translate); ім'я юніта <-> {NAME},
    -- щоб титул «Brewmaster {NAME}» матчився, а буквальний {NAME} не світився.
    local uName, uGuild
    -- pcall: у Midnight юніт-токен світових/захищених тултіпів може бути SECRET —
    -- GetGuildInfo(secret) кидає «Usage: GetGuildInfo("unit")» і ФЛУДИТЬ (Count 130+).
    if tt.GetUnit then
        local _, u = tt:GetUnit()
        if u then
            local ok1, nm = pcall(UnitName, u); if ok1 then uName = nm end
            local ok2, g = pcall(GetGuildInfo, u); if ok2 then uGuild = g end
        end
    end
    -- ITEM-тултіп: його інфо-рядки (прив'язка/слоти/типи/стати) належать ItemHooks.
    -- Пропускаємо їх тут, щоб не ставити СВІЙ контекстний uiTooltips-варіант поверх
    -- (флікер при Shift, напр. Soulbound «Прив'язано» vs ItemHooks «Прив'язаний»).
    local isItemTip = false
    if tt.GetItem then
        local ok, _, lnk = pcall(tt.GetItem, tt)
        if ok and lnk then isItemTip = true end
    end
    -- Тултіп у вікні шукача груп (I)? Вкладка Міфічний+ (ChallengesFrame — дитя
    -- PVEFrame) показує назву данжа в тултіпі значків сезону — вона має слухатись
    -- опції groupfinder.names, як і решта назв данжів у цьому вікні.
    local inGroupFinder = false
    if PVEFrame then
        local owner = tt.GetOwner and tt:GetOwner()
        local depth = 0
        while owner and depth < 12 do
            if owner == PVEFrame then inGroupFinder = true break end
            owner = owner.GetParent and owner:GetParent()
            depth = depth + 1
        end
    end
    -- ТУЛТІП ГРУПИ/ЗАЯВКИ (список груп, вікно заявок, Швидкий вступ): у ньому назва
    -- групи, коментар і ніки — текст ГРАВЦІВ. Не перекладаємо й не збираємо: зі
    -- збору вже потрапили «Relaxed» і назва групи «Chomu b ni» -> «Чому б ні»
    -- [[guild-names-never-translate]]. Лишаємо тільки назви підземель (гейт опції
    -- нижче), але й не в 1-му рядку — там назва групи, яку гравець міг назвати як данж.
    ttLFGCtx = IsPlayerGroupTip(tt)
    local changed = false
    for i = 1, tt:NumLines() do
        local fs = _G["GameTooltipTextLeft" .. i]
        local text = fs and ns.SafeText(fs:GetText())
        if text and not ns.HasCyrillic(text) then
            -- НОРМАЛІЗАЦІЯ як у збирачі (ttStripAll: колір+текстури+обрізка країв),
            -- щоб ключ пошуку точно збігався з ключем у db/ns.uiTooltips.
            local clean = ttStripAll(text)
            -- ГІЛЬДІЯ гравця: НЕ перекладаємо й НЕ збираємо (guild-names-never-translate)
            local skipUnit = uGuild and clean == uGuild
            -- тултіп групи: дозволені лише назви активностей/підземель (словники
            -- groupFinder і журналу), і не в 1-му рядку (назва групи)
            local lfgUA
            if ttLFGCtx then
                lfgUA = i > 1 and ((ns.groupFinder and ns.groupFinder[clean])
                                   or (ns.journalInstances and ns.journalInstances[clean]))
                if not lfgUA then skipUnit = true end
            end
            -- слово-власність ItemHooks на ITEM-тултіпі → не чіпаємо (див. isItemTip)
            if isItemTip and ns.itemTTWords and ns.itemTTWords[clean] then skipUnit = true end
            -- назва данжа в тултіпі вікна I з вимкненою опцією → лишити EN
            if (inGroupFinder or ttLFGCtx) and not skipUnit and ns.IsInstanceName
               and not ns.IsEnabled("groupfinder.names") and ns.IsInstanceName(clean) then
                skipUnit = true
            end
            -- ім'я юніта -> {NAME} для пошуку (титул «Brewmaster {NAME}»→«Пивовар {NAME}»),
            -- а в результаті {NAME} -> назад справжнє ім'я (інакше світився б буквальний {NAME})
            local deName
            if not skipUnit and uName and #uName > 1 and clean:find(uName, 1, true) then
                clean = clean:gsub((uName:gsub("(%W)", "%%%1")), "{NAME}")
                deName = function(s) return (s:gsub("{NAME}", uName)) end
            end
            -- словник: вшиті рядки АБО згенерований зі збору ns.uiTooltips. ОПИСИ
            -- НАЛАШТУВАНЬ (тултіп опції) — з ns.uiStrings (globalStrings), але ЛИШЕ
            -- коли відкрита панель «Параметри» (щоб не чіпати тултіпи предметів деінде).
            local newt, exact
            if ttLFGCtx and not skipUnit and lfgUA then
                newt, exact = lfgUA, true
            end
            if not newt and not skipUnit then
                newt = TT_EXACT[clean] or (ns.uiTooltips and ns.uiTooltips[clean])
                if newt then exact = true end
            end
            if not newt and not skipUnit and ns.uiStrings and SettingsPanel and SettingsPanel.IsShown
               and SettingsPanel:IsShown() then
                newt = ns.uiStrings[clean]
                if newt then exact = true end
            end
            if not newt and not skipUnit then
                for _, p in ipairs(TT_FORMAT_PATTERNS) do
                    local caps = { clean:match(p[1]) }
                    if caps[1] ~= nil then newt = p[2]:format(unpack(caps)); break end
                end
            end
            -- назва данжа в тултіпі вікна I (вкладка Міфічний+): штатний переклад
            -- за журнальною мапою; з вимкненою groupfinder.names сюди не дійде
            -- (skipUnit вже true — гейт вище). Раніше це перекладав ВИПАДКОВИЙ
            -- SetText-хук, що просочувався через перепарентований тултіп.
            if not newt and not skipUnit and inGroupFinder and ns.journalInstances then
                local ua = ns.journalInstances[clean]
                if ua then newt = ua; exact = true end
            end
            -- ВАЛЮТА в рядку «…Назва: число» — підставити укр. назву (лише ВІДОМІ
            -- валюти), зберігши іконку/колір/число (заміна саме підрядка-назви).
            if not newt and not skipUnit and ns.currencyByName then
                local cname = clean:match("([%a%s'%-]+):%s*[%d,]+%s*$")
                cname = cname and cname:gsub("^%s+", ""):gsub("%s+$", "")
                local ce = cname and ns.currencyByName[cname]
                if ce and ce.name and ce.name ~= cname then
                    newt = ttPlainReplace(text, cname, ce.name)
                end
            end
            if newt and deName then newt = deName(newt) end -- {NAME} -> справжнє ім'я юніта
            -- ЗБЕРЕГТИ текстури/атласи (значок якості |A…|a, монети |T…|t), які ttStripAll
            -- зрізав для матчингу: інакше SetText(перекладу) губить іконку — баг «Quality:
            -- [самоцвіт]» → «Якість:» без самоцвіта. Лише для ТОЧНОГО збігу (uiTooltips),
            -- де переклад = мітка без хвоста; валютний/форматний шлях іконку зберігає сам.
            if newt and exact and not newt:find("|[TA]") then
                local tex = ""
                for tx in text:gmatch("|[TA].-|[ta]") do tex = tex .. tx end
                if tex ~= "" then newt = newt .. " " .. tex end
            end
            if newt and newt ~= text then
                -- РЕЄСТРУЄМО пару ЗАВЖДИ (навіть під Shift) — інакше жива зміна Shift
                -- не свопає вже показаний тултіп (ns.ToggleOriginal бере з реєстру).
                if ns.Remember then ns.Remember(fs, text, newt, nil, "interface.menu") end
                if not showOrig then
                    -- ЗБЕРЕГТИ колір рядка: гра фарбує деякі рядки тултіпа (напр. зелене
                    -- «<Right click for Frame Settings>») через SetTextColor; наш SetText
                    -- міняє лише текст → без відновлення колір скидається на білий.
                    local r, g, b, a = fs:GetTextColor()
                    fs:SetText(newt)
                    if r then fs:SetTextColor(r, g, b, a) end
                    changed = true
                end
            elseif not skipUnit then
                CaptureUITooltip(text) -- неперекладене -> у збір
            end
        end
    end
    if changed and tt.Show then ttFmtBusy = true; tt:Show(); ttFmtBusy = false end
end
if GameTooltip and GameTooltip.Show then
    hooksecurefunc(GameTooltip, "Show", TranslateTooltipFormatLines)
end

-- EmbeddedItemTooltip — ОКРЕМИЙ фрейм тултіпа (не GameTooltip). Його вживають вбудовані
-- показувачі предметів/нагород, зокрема РЕВОРДИ вікна складності Глибин («Gilded Stash»
-- тощо). Наш GameTooltip-хук його не бачить, тому текст лишався англ., хоч він Є в
-- ns.uiTooltips (діагностика /wu debug: рамка = EmbeddedItemTooltip). Перекладаємо його
-- рядки через той самий словник (ttStripAll+TT_EXACT/uiTooltips), зберігаючи колір/іконки.
-- Опис реворду дописується ПІСЛЯ OnShow → додаємо кілька відкладених ре-сканів.
local function TranslateEmbeddedTooltip()
    local tt = _G.EmbeddedItemTooltip
    if not tt or not tt.IsShown or not tt:IsShown() or not tt.NumLines then return end
    if not ns.IsEnabled("interface.menu") or (ns.ShowOriginal and ns.ShowOriginal()) then return end
    local name = tt.GetName and tt:GetName()
    if not name then return end
    local okN, n = pcall(tt.NumLines, tt)
    if not okN or not n then return end
    for i = 1, n do
        local fs = _G[name .. "TextLeft" .. i]
        local text = fs and ns.SafeText(fs:GetText())
        if text and not ns.HasCyrillic(text) then
            -- Рядок EmbeddedItemTooltip буває БАГАТОЧАСТИННИМ через \n (опис + лічильник
            -- + «Resets weekly» в одному FontString) — тож перекладаємо КОЖЕН сегмент окремо.
            -- ПІДСТАВЛЯЄМО UA на місце англ. тексту В МЕЖАХ оригіналу: інлайн-код |c..|r
            -- лишається на місці (колір НЕ ламається; тому НЕ робимо SetText(bare)+SetTextColor).
            local newt = text
            for part in text:gmatch("[^\r\n]+") do
                local clean = ttStripAll(part)
                if clean and #clean > 1 and clean:find("%a") then
                    local ua = TT_EXACT[clean] or (ns.uiTooltips and ns.uiTooltips[clean])
                    if ua and ua ~= clean then
                        local s, e = newt:find(clean, 1, true)
                        if s then newt = newt:sub(1, s - 1) .. ua .. newt:sub(e + 1) end
                    end
                end
            end
            if newt ~= text then
                if ns.Remember then ns.Remember(fs, text, newt, nil, "interface.menu") end
                fs:SetText(newt)
            end
        end
    end
end
if _G.EmbeddedItemTooltip and _G.EmbeddedItemTooltip.HookScript then
    _G.EmbeddedItemTooltip:HookScript("OnShow", function()
        ns.Guard("інтерфейс", TranslateEmbeddedTooltip)
        if C_Timer and C_Timer.After then           -- опис реворду з'являється пізніше
            C_Timer.After(0, function() ns.Guard("інтерфейс", TranslateEmbeddedTooltip) end)
            C_Timer.After(0.1, function() ns.Guard("інтерфейс", TranslateEmbeddedTooltip) end)
        end
    end)
end

-- Тултіпи КОНТРОЛІВ панелі «Параметри» (Midnight Settings API) НЕ завжди йдуть
-- через GameTooltip:Show() — тому хук вище їх не ловить (підтверджено: ні заголовок,
-- ні опис не перекладались, хоч обидва Є в ns.uiStrings). РІШЕННЯ: поки відкрита
-- панель — легкий тікер перекладає видимий GameTooltip напряму (ns.uiStrings-гейт
-- усередині TranslateTooltipFormatLines спрацьовує, бо SettingsPanel:IsShown()).
-- Ідемпотентно: вже-кириличні рядки пропускаються; працює лише поки панель видима.
if C_Timer and GameTooltip then
    local function settingsTooltipTick()
        local open = SettingsPanel and SettingsPanel.IsShown and SettingsPanel:IsShown()
        if open then
            if GameTooltip.IsShown and GameTooltip:IsShown() then
                ns.Guard("інтерфейс", TranslateTooltipFormatLines)
            end
            C_Timer.After(0.12, settingsTooltipTick)
        else
            C_Timer.After(0.5, settingsTooltipTick) -- очікуємо відкриття панелі
        end
    end
    C_Timer.After(1, settingsTooltipTick)
end

-- НАДІЙНІШИЙ, НЕЗАЛЕЖНИЙ ВІД ФРЕЙМУ шлях: тултіп опцій наповнюється глобальними
-- хелперами GameTooltip_SetTitle/AddNormalLine/… (хоч би який це фрейм). Хукаємо їх
-- ПОСТ-викликом і перекладаємо рядки переданого тултіпа через ns.uiStrings. Гейт —
-- лише поки відкрита панель «Параметри» (щоб не чіпати тултіпи предметів деінде).
local function TranslateTooltipFrame(tt)
    if type(tt) ~= "table" or not tt.NumLines or not tt.GetName then return end
    if not (SettingsPanel and SettingsPanel.IsShown and SettingsPanel:IsShown()) then return end
    if not ns.IsEnabled("interface.menu") or (ns.ShowOriginal and ns.ShowOriginal()) then return end
    if not ns.uiStrings then return end
    local name = tt:GetName()
    if not name then return end
    local ok, n = pcall(tt.NumLines, tt)
    if not ok or not n then return end
    for i = 1, n do
        local fs = _G[name .. "TextLeft" .. i]
        local text = fs and ns.SafeText(fs:GetText())
        if text and not ns.HasCyrillic(text) then
            local clean = ttStripAll(text)
            local ua = ns.uiStrings[clean]
            if ua and ua ~= text then
                if ns.Remember then ns.Remember(fs, text, ua, nil, "interface.menu") end
                fs:SetText(ua)
                -- Титул опції (рядок 1) — білий (як є); опис (рядки 2+) — жовтий
                -- (NORMAL_FONT_COLOR). Blizzard малює опис білим, що зливається з титулом.
                if i > 1 and fs.SetTextColor then fs:SetTextColor(1, 0.82, 0) end
            elseif not ua then
                CaptureUITooltip(text)  -- непокритий опис опції -> у збір (добір хвоста)
            end
        end
    end
end
for _, fn in ipairs({ "GameTooltip_SetTitle", "GameTooltip_AddNormalLine",
                      "GameTooltip_AddHighlightLine", "GameTooltip_AddInstructionLine",
                      "GameTooltip_AddColoredLine", "GameTooltip_AddErrorLine" }) do
    if type(_G[fn]) == "function" then
        hooksecurefunc(fn, function(tt) ns.Guard("інтерфейс", TranslateTooltipFrame, tt) end)
    end
end

-- ── Мікро-меню (кнопки знизу) — НАДІЙНИЙ шлях, незалежний від методу тултіпа:
-- хукаємо OnEnter кожної кнопки (пост-виклик). Після того як кнопка наповнила
-- GameTooltip (SetText/AddLine/новий API — байдуже), перекладаємо ПЕРШИЙ рядок:
-- назву зі словника, лишаючи «(клавішу)» з її кольором.
local function TranslateOpenMicroTitle()
    if not ns.IsEnabled("interface.menu") then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    local tt = GameTooltip
    if not tt.NumLines then return end
    local changed = false
    for i = 1, tt:NumLines() do
        local fs = _G["GameTooltipTextLeft" .. i]
        local text = fs and ns.SafeText(fs:GetText())
        if text and text ~= "" and not ns.HasCyrillic(text) then
            local newt
            if i == 1 then                       -- заголовок: назва зі словника + «(клавіша)»
                local name = stripColor(text):match("^([%a%s'&]+)")
                if name then name = name:gsub("%s+$", "") end
                local ua = name and name ~= "" and UI[name]
                if ua then
                    local s, e = text:find(name, 1, true)
                    if s then newt = text:sub(1, s - 1) .. ua .. text:sub(e + 1) end
                end
            end
            if not newt then                     -- решта: числові шаблони + точний словник
                local clean = stripColor(text)
                for _, p in ipairs(TT_LINE_PATTERNS) do
                    local cap = clean:match(p[1])
                    if cap then newt = p[2]:format(cap); break end
                end
                if not newt then newt = UI[clean] end
            end
            if newt and newt ~= text then fs:SetText(newt); changed = true end
        end
    end
    if changed and tt.Show then tt:Show() end
end
local microHooked = {}
-- ТЕЙНТ-ЗАСЛІН: не чіпати ЗАХИЩЕНІ кнопки (secure action/bag buttons). HookScript на
-- них тейнтить кнопку → коли Blizzard кличе Button:SetPassThroughButtons() у бою, дію
-- блокує («Interface action failed because of an AddOn»). Хукаємо ЛИШЕ незахищені
-- (мікро-меню — звичайні кнопки; кнопки торб BagsBar — захищені, пропускаємо).
local function SafeHookBtn(btn)
    if type(btn) ~= "table" or not btn.HookScript or microHooked[btn] then return end
    if btn.IsProtected and btn:IsProtected() then return end   -- secure → не чіпати
    microHooked[btn] = true
    btn:HookScript("OnEnter", TranslateOpenMicroTitle)
end
local function HookMicroMenu()
    if InCombatLockdown and InCombatLockdown() then return end  -- у бою не хукаємо взагалі
    local mm = _G["MicroMenu"]
    if mm and mm.GetChildren then
        for _, btn in ipairs(ns.Children(mm)) do SafeHookBtn(btn) end
    end
    -- наплічник/торби — окремий бар; кнопки там захищені, SafeHookBtn їх відсіє.
    for _, barName in ipairs({ "BagsBar", "MicroButtonAndBagsBar" }) do
        local bar = _G[barName]
        if bar and bar.GetChildren then
            for _, btn in ipairs(ns.Children(bar)) do SafeHookBtn(btn) end
        end
    end
end
local mmLoader = CreateFrame("Frame")
mmLoader:RegisterEvent("PLAYER_ENTERING_WORLD")
mmLoader:RegisterEvent("ADDON_LOADED")
mmLoader:RegisterEvent("PLAYER_REGEN_ENABLED")  -- кінець бою: дохукати те, що пропустили
mmLoader:SetScript("OnEvent", HookMicroMenu)
HookMicroMenu()
