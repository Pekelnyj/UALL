-- Локалізація Путівника пригод (Adventure Guide, shift+J).
-- Заміри /fstack (Midnight):
--   EncounterJournalJourneysFrame.JourneysList                 — ScrollBox Renown-фракцій
--   ...JourneysList.ScrollTarget.<картка>.RenownCardFactionName — FontString назви фракції
--   EncounterJournalJourneysTab.Text                            — підпис вкладки
--   EncounterJournalMonthlyActivitiesTab                        — вкладка «Traveler's Log»
-- 1) Назви фракцій підставляємо з ns.factionByName (англ.→укр).
-- 2) Сталі написи вкладок/заголовків — зі словника EJ_STRINGS.
-- EncounterJournal — Load-on-Demand (Blizzard_EncounterJournal): чекаємо ADDON_LOADED.

local _, ns = ...

local function ApplyCyr(fs)
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
end

-- ── Сталі UI-рядки Путівника (підписи вкладок, заголовки секцій).
-- Доповнюється в міру того, як знаходимо неперекладені написи.
local EJ_STRINGS = {
    ["Journeys"]          = "Подорожі",
    -- «Back» ТУТ — навігаційна КНОПКА огляду мандрівки (повернутися до списку),
    -- НЕ слот спорядження. Мусить стояти ПЕРШИМ у ланцюжку, бо uiTooltips далі
    -- в ланцюжку віддає слотове «Спина» (репро: кнопка «Спина» у Подорожах).
    ["Back"]              = "Назад",
    ["Traveler's Log"]    = "Журнал",
    ["Suggested Content"] = "Рекомендоване",
    ["Dungeons"]          = "Підземелля",
    ["Raids"]             = "Рейди",
    ["Tutorials"]         = "Посібники",
    ["Renowns"]           = "Визнання",
    ["Encounters"]        = "Бої",
    ["Show as Experience Bar"] = "Показувати як смугу досвіду",
    ["Overview"]          = "Огляд",
    ["Skip"]              = "Пропустити",
    ["Configure"]         = "Налаштувати",
    ["Journey Locked"]    = "Подорож заблокована",
    ["Maximum Renown"]    = "Максимальне визнання",
    -- Журнал мандрівника (Traveler's Log / Monthly Activities): фільтри + статуси
    ["All"]                = "Усі",
    ["Collectibles"]       = "Колекційне",
    ["Dungeons and Raids"] = "Підземелля й рейди",
    ["Holidays and Events"] = "Свята й події",
    ["Housing"]            = "Житло",
    ["Pet Battles"]        = "Битви улюбленців",
    ["Professions"]        = "Професії",
    ["Quests"]             = "Квести",
    ["You have collected all rewards for this month"] = "Ти зібрав усі нагороди цього місяця",
    ["Ends in:"]           = "Завершується через:",
    ["Special"]            = "Особливе",
    -- Назви доповнень (фільтр Журналу) — КАНОН (звірено, множина де треба).
    ["Classic"]            = "Classic",          -- бренд
    ["The Burning Crusade"] = "Палаючий Похід",
    ["Burning Crusade"]    = "Палаючий Похід",
    ["Wrath of the Lich King"] = "Гнів Короля-Ліча",
    ["Cataclysm"]          = "Катаклізм",
    ["Mists of Pandaria"]  = "Тумани Пандарії",   -- МНОЖИНА (Mists)
    ["Warlords of Draenor"] = "Воєначальники Дренору",
    ["Legion"]             = "Легіон",
    ["Battle for Azeroth"] = "Битва за Азерот",
    ["Shadowlands"]        = "Тіньокрай",
    ["Dragonflight"]       = "Політ Драконів",    -- НЕ «Зграя Драконів»
    ["The War Within"]     = "Війна Всередині",
    ["War Within"]         = "Війна Всередині",
    ["Midnight"]           = "Опівніч",
    ["Classic"]            = "Класика",
}
ns.ejStrings = EJ_STRINGS

-- Підмінити текст одного FontString, якщо він є у словнику й ще англійською.
-- ЗАВЖДИ реєструємо пару в ns.replacements (ns.Remember), щоб працював перемикач
-- «показати оригінал» (Shift/гаряча клавіша свопає весь реєстр). Сам текст міняємо
-- лише коли НЕ тримається оригінал — інакше лишаємо англійський.
local function SubFS(fs, dict)
    if not fs or not fs.GetText then return end
    local en = fs:GetText()
    if not en or en == "" then return end
    local ua = dict[en]
    if not ua or ua == en then return end       -- нема перекладу / вже укр.
    if ns.Remember then ns.Remember(fs, en, ua) end
    if not (ns.ShowOriginal and ns.ShowOriginal()) then
        fs:SetText(ua)
        ApplyCyr(fs)
    end
end

-- ── Нагороди трекá Journeys (EncounterJournalJourneysFrame.JourneyProgress.*):
-- назва нагороди (напр. "Power of the Voidstorm"), титул трекá ("The Singularity"),
-- "Current Progress". Це СЕРВЕРНІ/акаунтні рядки — їх НЕ зчитує жоден збирач і нема
-- в DB2, тож (1) ЗБИРАЄМО в db.journeys (capture-only, як gossip/делв), (2) перекладаємо
-- з ns.journeys / ns.uiTooltips, коли переклад зʼявиться. Картка зʼявляється/міняється
-- через карусель без OnShow-події → рекурсивний обхід FontString-ів + тікер-страховка.
local function VisitJourneyFS(fs)
    if not (fs and fs.GetText and fs.SetText) then return end
    local en = ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText()
    if not en or #en < 3 then return end
    if not en:find("%a") then return end                       -- мусить мати літери
    if en:match("^[%d%s/%%:.,%-]+$") then return end           -- пропустити чисто-числові (прогрес)
    if ns.HasCyrillic and ns.HasCyrillic(en) then return end   -- вже українською
    -- "Current Progress: |c..N / M|r" — динамічний (число), перекладаємо лише префікс
    if en:find("^Current Progress") then
        local ua = (en:gsub("Current Progress", "Поточний поступ"))
        if ns.Remember then ns.Remember(fs, en, ua) end
        if not (ns.ShowOriginal and ns.ShowOriginal()) then fs:SetText(ua); ApplyCyr(fs) end
        return
    end
    -- ЗБІР (гейт: лише поки вкладка Journeys видима — її гарантує виклик)
    if ns.GetCaptureDB then
        pcall(function()
            local db = ns.GetCaptureDB()
            db.journeys = db.journeys or {}
            db.journeys[en] = true
        end)
    end
    -- ПЕРЕКЛАД, якщо вже маємо. Назви мандрівок («The Singularity», «Amani Tribe»…) —
    -- це renown-/quest-сутності: їхній переклад лежить у questObjectives/factionByName,
    -- тож додаємо ці точні словники в ланцюг пошуку (exact-match → без хибних замін).
    -- EJ_STRINGS ПЕРШИМ: журнал-специфічний канон (назви доповнень/фільтри) має
    -- перекривати загальні словники (де могли бути криві leak-значення).
    local ua = EJ_STRINGS[en]
        or (ns.journeys and ns.journeys[en])
        or (ns.uiTooltips and ns.uiTooltips[en])
        or (ns.questObjectives and ns.questObjectives[en])
        or (ns.factionByName and ns.factionByName[en])
    if ua and ua ~= en then
        if ns.Remember then ns.Remember(fs, en, ua) end
        if not (ns.ShowOriginal and ns.ShowOriginal()) then
            fs:SetText(ua); ApplyCyr(fs)
        end
    end
end

local function WalkRegions(frame, depth)
    if not frame or depth < 0 then return end
    local ok, regions = pcall(function() return { frame:GetRegions() } end)
    if ok then
        for _, r in ipairs(regions) do
            if r.GetText then pcall(VisitJourneyFS, r) end
        end
    end
    local ok2, kids = pcall(function() return { frame:GetChildren() } end)
    if ok2 then
        for _, c in ipairs(kids) do WalkRegions(c, depth - 1) end
    end
end

-- Чи показана хоч одна панель Журналу, яку ми скануємо (Journeys або Журнал мандрівника).
local function EJPanelShown()
    local jf = EncounterJournalJourneysFrame
    if jf and jf.IsShown and jf:IsShown() then return true end
    local ma = EncounterJournalMonthlyActivitiesFrame
    if ma and ma.IsShown and ma:IsShown() then return true end
    return false
end

local function ScanJourneyRewards()
    -- Обходимо ВЕСЬ Journeys-фрейм (не лише JourneyProgress): картка нагороди +
    -- сусідня детальна панель з ОПИСОМ ("Rare elite enemies now spawn…") та підписом
    -- типу ("Warband Reward") лежать у різних гілках. Глибина 8 + фільтри/HasCyrillic.
    local jf = EncounterJournalJourneysFrame
    if jf then pcall(WalkRegions, jf, 8) end
    -- Журнал мандрівника (Traveler's Log / Monthly Activities): фільтри + картки
    -- активностей (ScrollBox, data-driven) — той самий VisitJourneyFS (переклад+збір).
    local ma = EncounterJournalMonthlyActivitiesFrame
    if ma then pcall(WalkRegions, ma, 8) end
end

-- Тікер-страховка: поки вкладка Journeys показана, періодично пере-скануємо нагороду
-- (карусель 2-12 міняє картку без OnShow/Update). Сам гаситься, коли вкладку закрито.
local jTicker
local function StartJourneyTicker()
    if jTicker or not C_Timer then ScanJourneyRewards(); return end
    ScanJourneyRewards()
    jTicker = C_Timer.NewTicker(0.1, function()      -- 0.1с: ледь помітний флеш замість ~1с
        if not EJPanelShown() then
            if jTicker then jTicker:Cancel(); jTicker = nil end
            return
        end
        pcall(ScanJourneyRewards)
    end)
end

-- ── Назви Renown-фракцій у списку Journeys.
local function LocalizeCard(card)
    if not card then return end
    -- назва фракції
    if ns.factionByName then
        SubFS(card.RenownCardFactionName, ns.factionByName)
    end
    -- чекбокс «Show as Experience Bar» усередині картки
    local toggle = card.WatchedFactionToggleFrame
    local cb = toggle and toggle.WatchFactionCheckbox
    if cb and cb.Label then SubFS(cb.Label, EJ_STRINGS) end
end

local function LocalizeJourneysList()
    local jf = EncounterJournalJourneysFrame
    local list = jf and jf.JourneysList
    if not list or not list.GetFrames then return end
    local ok, frames = pcall(list.GetFrames, list)
    if not ok or type(frames) ~= "table" then return end
    for _, card in ipairs(frames) do
        pcall(LocalizeCard, card)
        -- Сезонні картки («Delves: Season 1», «Prey: Season 1» у секції «Бої») —
        -- інший тип, ніж Renown-фракції: заголовок НЕ в RenownCardFactionName, тож
        -- LocalizeCard їх не чіпає. Картки пулові (ScrollBox), звичайний walk через
        -- GetChildren їх не бачить — тож обходимо регіони кожної картки з GetFrames()
        -- напряму (VisitJourneyFS знає ns.journeys: «Глибини/Здобич: Сезон 1»).
        pcall(WalkRegions, card, 4)
    end
end

-- ── Назви підземель/рейдів у списку вибору інстансу (вкладки Dungeons/Raids).
-- EncounterJournalInstanceSelect.ScrollBox — кнопки інстансів; назва — FontString
-- з анонімним іменем, тож шукаємо за відомим ключем .Name, інакше скануємо регіони
-- й підміняємо лише ті, чий текст є в нашій мапі ns.journalInstances (англ.→укр).
local function LocalizeInstanceButton(btn)
    if not btn or not ns.journalInstances then return end
    -- Під опцією groupfinder.names, як і решта назв підземель (шукач груп,
    -- Довідник підземель). Вимкнено — лишаємо англійські назви.
    if ns.IsEnabled and not ns.IsEnabled("groupfinder.names") then return end
    if btn.Name and btn.Name.GetText then
        SubFS(btn.Name, ns.journalInstances)
        return
    end
    local ok, regions = pcall(function() return { btn:GetRegions() } end)
    if not ok then return end
    for _, r in ipairs(regions) do
        if r.GetText and r.SetText then SubFS(r, ns.journalInstances) end
    end
end

local function LocalizeInstanceList()
    local sel = EncounterJournalInstanceSelect
    local box = sel and sel.ScrollBox
    if not box or not box.GetFrames then return end
    local ok, frames = pcall(box.GetFrames, box)
    if not ok or type(frames) ~= "table" then return end
    for _, btn in ipairs(frames) do
        pcall(LocalizeInstanceButton, btn)
    end
end

-- ── Сталі написи: рекурсивно (невелика глибина) обходимо фрейм Путівника й
-- підміняємо будь-який .Text, що є у словнику. Імена вкладок не хардкодимо —
-- так само ловимо Dungeons/Raids/Tutorials тощо без окремих замірів.
local function ScanStrings(frame, depth)
    if not frame or depth < 0 then return end
    if frame.Text then SubFS(frame.Text, EJ_STRINGS) end
    local ok, kids = pcall(function() return { frame:GetChildren() } end)
    if not ok then return end
    for _, child in ipairs(kids) do
        ScanStrings(child, depth - 1)
    end
end

local function LocalizeEJ()
    if EncounterJournal then
        ScanStrings(EncounterJournal, 3)
        -- Вкладка «Посібники» (TutorialsFrame): заголовок/опис туторіалу («Catch Up
        -- Experience» тощо) — це FontString-и в .Contents, а НЕ frame.Text, тож
        -- ScanStrings їх не дістає. Обходимо WalkRegions: переклад через
        -- uiTooltips/EJ_STRINGS + збір невідомого в db.journeys (як решта EJ).
        if EncounterJournal.TutorialsFrame then
            pcall(WalkRegions, EncounterJournal.TutorialsFrame, 6)
        end
    end
    LocalizeJourneysList()
    LocalizeInstanceList()
    StartJourneyTicker()
end

-- ── Хук у джерелі: після :Update ScrollBox-а (картки перемальовано) +
-- OnShow Путівника й вкладки Journeys. Без таймерів-обходів.
local hooked = false
local function HookJourneys()
    if hooked then return end
    hooked = true
    local jf = EncounterJournalJourneysFrame
    if jf then
        local list = jf.JourneysList
        if list and type(list.Update) == "function" then
            hooksecurefunc(list, "Update", LocalizeJourneysList)
        end
        jf:HookScript("OnShow", LocalizeJourneysList)
        jf:HookScript("OnShow", StartJourneyTicker)         -- збір+переклад нагород трекá
        local prog = jf.JourneyProgress
        if prog and prog.HookScript then
            prog:HookScript("OnShow", StartJourneyTicker)
        end
        -- СИНХРОННО в точці рендера: коли оверв'ю мандрівки (опис + картки «Найважливіше»)
        -- перемальовується після вибору фракції в дропдауні, перекладаємо ОДРАЗУ (без
        -- чекання тікера → без ~1с флешу). Метод-рендер у Blizzard може зватись по-різному
        -- між патчами, тож хукаємо будь-який наявний кандидат (post-hook: вміст уже виставлено).
        local function HookRender(obj, methods)
            if type(obj) ~= "table" then return end
            for _, m in ipairs(methods) do
                if type(obj[m]) == "function" then
                    hooksecurefunc(obj, m, function() pcall(ScanJourneyRewards) end)
                end
            end
        end
        HookRender(jf, { "Refresh", "Update", "SetJourney", "SelectJourney", "UpdateOverview" })
        HookRender(jf.JourneyOverview, { "Refresh", "Update", "Init", "SetJourney" })
    end
    -- Журнал мандрівника (Traveler's Log): OnShow + Update ScrollBox-ів (фільтри/картки)
    -- → тікер сканує (переклад відомого + збір нового в db.journeys).
    local ma = EncounterJournalMonthlyActivitiesFrame
    if ma then
        ma:HookScript("OnShow", StartJourneyTicker)
        if ma.ScrollBox and type(ma.ScrollBox.Update) == "function" then
            hooksecurefunc(ma.ScrollBox, "Update", StartJourneyTicker)
        end
        if ma.FilterList and ma.FilterList.ScrollBox and type(ma.FilterList.ScrollBox.Update) == "function" then
            hooksecurefunc(ma.FilterList.ScrollBox, "Update", StartJourneyTicker)
        end
    end
    local sel = EncounterJournalInstanceSelect
    if sel and sel.ScrollBox and type(sel.ScrollBox.Update) == "function" then
        hooksecurefunc(sel.ScrollBox, "Update", LocalizeInstanceList)
    end
    if EncounterJournal then
        EncounterJournal:HookScript("OnShow", LocalizeEJ)
    end
    LocalizeEJ()
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(_, _, name)
    if name == "Blizzard_EncounterJournal" then
        HookJourneys()
        loader:UnregisterEvent("ADDON_LOADED")
    end
end)
if EncounterJournalJourneysFrame then HookJourneys() end
