-- UALL: переклад поверхонь Тиру 3 (housing / пошук групи / професії / календар /
-- сплеші). Кожна поверхня — СВІЙ фрейм + СВІЙ словник, без перехресних запозичень
-- [[context-scoped-translation]]. Узагальнений реєстратор: walk FontString-ів фрейму
-- (+ тікер) із підміною лише зі свого ns.<dict>. Shift через ns.Remember.

local _, ns = ...

-- key — галочка конкретної поверхні; без неї — «Інші вікна» (interface.tier3). Вікна житла
-- слухають «Житло» (housing), як і HousingHooks: досі галочка «Житло» вимикала лише
-- половину житла, а ці вікна висіли на «Меню та налаштування» (07.10.2026).
local function Enabled(key)
    return (not ns.IsEnabled) or ns.IsEnabled(key or "interface.tier3")
end

-- Назва підземелля/рейду? (для опції groupfinder.names: гравці міжнародних груп
-- хочуть EN-назви данжів, лишаючи решту вікна українською). Звіряємо з
-- ns.journalInstances разом із суфіксом складності «Sporefall (Normal)».
-- Мапа живе в LoD-аддоні UALL_Journal — якщо гравець ще не відкривав Путівник,
-- її НЕМА і гейт мовчки вмирав (назви лишались перекладеними попри вимкнену
-- опцію). Тому довантажуємо журнал на вимогу (лише коли опція вимкнена —
-- див. порядок перевірок у skip нижче).
local journalLoadTried

-- НАЗВУ АКТИВНОСТІ ВИДАЄ САМА ФОРМА, А НЕ ЖУРНАЛ. Звіряння лише з
-- ns.journalInstances пропускало 62 назви: гравець знімав галочку, а
-- «Вівтар Іклів (Міфічний ключ)» лишався українським поряд з англійським
-- «Murder Row (Mythic Keystone)». Причини різні, а наслідок один:
--   • нові підземелля Опівночі, яких у мапі журналу ще нема (Altar of Fangs,
--     The Venomous Abyss, Aberrus);
--   • половинки Міфічний+, що в журналі одним записом (Lower Karazhan,
--     Tazavesh Streets, Mechagon Workshop);
--   • артикль і регістр («Blood Furnace» проти «The Blood Furnace»,
--     «THE MOTHERLODE»);
--   • глибини з «(Tier ?)» — старе правило чекало лише цифру.
-- Тому вводимо суфікси складності, виведені зі СЛОВНИКА шукача груп.
-- ЧАСТОТА ТУТ НЕ ДОКАЗ: «(Draenor)» і «(Challenge)» трапляються однаково
-- (по 3 рази), але перше стоїть за зонами й світовими босами («Nagrand»,
-- «Shadowmoon Valley»), а друге — за підземеллями («Auchindoun»). Доказом є
-- те, що стоїть ПЕРЕД суфіксом: суфікс вважаємо складністю, якщо більшість
-- назв із ним — підземелля. Підземелля визнаємо за ядровою складністю
-- Blizzard (Normal/Heroic/Mythic/Mythic Keystone) або за мапою журналу.
local CORE_DIFFICULTY = { Normal = true, Heroic = true, Mythic = true,
                          ["Mythic Keystone"] = true }
local commonSuffix, activityBase

local function splitSuffix(en)
    local base, suf = en:match("^(.-)%s*%(([^()]*)%)$")
    -- лічильник «(0)», «(0/10)» — серверне число, а не складність
    if base and suf and base ~= "" and not suf:match("^[%d%s/]+$") then
        return base, suf
    end
end

local function JournalMap()
    local ji = ns.journalInstances
    if not ji and not journalLoadTried then
        journalLoadTried = true
        local load = (C_AddOns and C_AddOns.LoadAddOn) or LoadAddOn
        if load then pcall(load, "UALL_Journal") end
        ji = ns.journalInstances
    end
    return ji
end

local function BuildActivityIndex()
    if commonSuffix then return end
    commonSuffix, activityBase = {}, {}
    local d = ns.groupFinder
    if not d then return end
    local ji = JournalMap() or {}
    local bySuf, coreBase = {}, {}
    for k in pairs(d) do
        local base, suf = splitSuffix(k)
        if base then
            bySuf[suf] = bySuf[suf] or {}
            bySuf[suf][base] = true
            if CORE_DIFFICULTY[suf] then coreBase[base] = true end
        end
    end
    for suf, bases in pairs(bySuf) do
        if CORE_DIFFICULTY[suf] or suf:match("^Tier [%d%?]+$") then
            commonSuffix[suf] = true           -- ядрова складність або глибина
        else
            local n, inst = 0, 0
            for b in pairs(bases) do
                n = n + 1
                if coreBase[b] or ji[b] then inst = inst + 1 end
            end
            if n > 0 and inst * 2 > n then commonSuffix[suf] = true end
        end
    end
    for suf in pairs(commonSuffix) do
        for b in pairs(bySuf[suf]) do activityBase[b] = true end
    end
end

local function IsInstanceName(en)
    if type(en) ~= "string" or en == "" then return false end
    BuildActivityIndex()
    local base, suf = splitSuffix(en)
    -- глибина: «(Tier 7)», «(Tier ?)», «(Tier ??)»
    if suf and suf:match("^Tier [%d%?]+$") then return true end
    -- назва з суфіксом складності — активність за самою формою
    if suf and commonSuffix[suf] then return true end
    -- гола назва, яка в словнику має хоча б одну активність зі складністю
    -- (випадний список «Вівтар Іклів» без дужок)
    if activityBase[en] then return true end
    local ji = ns.journalInstances
    if not ji and not journalLoadTried then
        journalLoadTried = true
        local load = (C_AddOns and C_AddOns.LoadAddOn) or LoadAddOn
        if load then pcall(load, "UALL_Journal") end
        ji = ns.journalInstances
    end
    if not ji then return false end
    if ji[en] then return true end
    local base = en:match("^(.-)%s*%([^()]*%)$")
    return base and ji[base] ~= nil
end
-- Для UIHooks (GameTooltip у вікні I — вкладка Міфічний+ малює назву данжа
-- в тултіпі значків «Найкраще за сезон» загальним тултіп-хуком).
ns.IsInstanceName = IsInstanceName

local function makeTr(dict, skip, key)   -- key — галочка поверхні (для миттєвого відкату)
    return function(fs)
        if not fs or not fs.GetText then return end
        local en = ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText()
        if not en or en == "" then return end
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
        if ns.ShowOriginal and ns.ShowOriginal() then return end
        if ns.HasCyrillic and ns.HasCyrillic(en) then return end
        if skip and skip(en, fs) then return end
        local d = ns[dict]
        local ua = d and d[en]
        if not ua and d then
            -- СУФІКС-ЛІЧИЛЬНИК «(0)», «(0/10)» — серверне число: перекласти БАЗУ, число
            -- лишити («Quick Join (0)» → «Швидкий вступ (0)»). Дужка має починатися з цифри,
            -- щоб не чіпати «(SHIFT-P)» тощо.
            local base, suffix = en:match("^(.-)(%s*%(%d[%d%s/]*%))$")
            if base and d[base] then ua = d[base] .. suffix end
        end
        if ua and ua ~= en then
            if ns.Remember then ns.Remember(fs, en, ua, nil, key or "interface.tier3") end
            fs:SetText(ua)
            if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
        end
    end
end

-- GameTooltip:SetOwner перепарентовує тултіп у власника → walk відкритої поверхні
-- міг дістатись GameTooltip і повісити self-heal на ЙОГО написи (вічний переклад
-- усіх тултіпів повз гейти). Тултіпам — свої хуки, у walk їм зась.
local function IsTooltipFrame(f)
    if f == GameTooltip then return true end
    if type(f) == "table" and f.GetObjectType then
        local ok, t = pcall(f.GetObjectType, f)
        return ok and t == "GameTooltip"
    end
    return false
end

local function walk(frame, tr, depth)
    if not frame or depth > 11 or type(frame) ~= "table" then return end
    if IsTooltipFrame(frame) then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") then pcall(tr, rg) end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then walk(c, tr, depth + 1) end end
    end
end

-- frameNames: список можливих імен фрейму поверхні; dict: ключ у ns; addon: LoD-аддон.
-- ХУК У ТОЧЦІ ДЖЕРЕЛА, БЕЗ ТІКЕРА [[hook-at-source-not-walk]]:
--   • walk-раз на OnShow поверхні (+ ВІШАННЯ self-heal SetText на кожен напис);
--   • self-heal: щойно Blizzard перепише напис (скрол ScrollBox / оновлення місій) —
--     наш хук миттєво повертає переклад;
--   • ScrollBox OnInitializedFrame: нові рядки під час скролу.
-- Раніше тут був C_Timer-тікер 0.3с — він блимав і ламав «hook-at-source».
local function registerSurface(frameNames, dict, addon, skip, key)
    local tr = makeTr(dict, skip, key)
    local hookedFS = setmetatable({}, { __mode = "k" })
    local applying = false
    local function shown()
        for _, fn in ipairs(frameNames) do
            local f = _G[fn]
            if f and f.IsShown and f:IsShown() then return f end
        end
    end
    local function selfHeal(fs)
        if applying or not (Enabled(key) and ns[dict]) or not shown() then return end
        applying = true; pcall(tr, fs); applying = false
    end
    local function hookFS(fs)
        if hookedFS[fs] or type(fs) ~= "table" or type(fs.SetText) ~= "function" then return end
        hookedFS[fs] = true
        hooksecurefunc(fs, "SetText", selfHeal)
        if type(fs.SetFormattedText) == "function" then
            hooksecurefunc(fs, "SetFormattedText", selfHeal)
        end
    end
    -- walk + переклад + ВІШАННЯ self-heal на кожен напис
    local function walkHook(frame, depth)
        if not frame or depth > 11 or type(frame) ~= "table" then return end
        if IsTooltipFrame(frame) then return end
        if frame.GetRegions then
            for _, rg in ipairs(ns.Regions(frame)) do
                if rg.IsObjectType and rg:IsObjectType("FontString") then
                    hookFS(rg); pcall(tr, rg)
                end
            end
        end
        if frame.GetChildren then
            for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then walkHook(c, depth + 1) end end
        end
    end
    -- знайти всі ScrollBox-и поверхні й зачепити OnInitializedFrame (нові рядки скролу)
    local function hookScrollBoxes(frame, depth)
        if not frame or depth > 11 or type(frame) ~= "table" then return end
        if type(frame.RegisterCallback) == "function" and type(frame.ForEachFrame) == "function"
                and not frame.__uall_t3sb then
            local evt = ScrollBoxListViewMixin and ScrollBoxListViewMixin.Event
            if evt and evt.OnInitializedFrame then
                frame.__uall_t3sb = true
                pcall(function()
                    frame:RegisterCallback(evt.OnInitializedFrame, function(_, f)
                        if f and Enabled(key) then pcall(walkHook, f, 1) end
                    end, frame)
                end)
            end
        end
        if frame.GetChildren then
            for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then hookScrollBoxes(c, depth + 1) end end
        end
    end
    local function refresh()
        if not (Enabled(key) and ns[dict]) then return end
        local f = shown()
        if f then pcall(walkHook, f, 1); pcall(hookScrollBoxes, f, 0) end
    end
    local function hookShow()
        for _, fn in ipairs(frameNames) do
            local f = _G[fn]
            if f and f.HookScript and not f.__uall_t3 then
                f.__uall_t3 = true
                f:HookScript("OnShow", refresh)
                if f:IsShown() then refresh() end
            end
        end
    end
    hookShow()
    if addon then
        local ev = CreateFrame("Frame")
        ev:RegisterEvent("ADDON_LOADED")
        ev:SetScript("OnEvent", function(_, _, n) if n == addon then hookShow() end end)
    end
end

-- Поверхні (frame-імена з кількома варіантами — нешкідливо, якщо якогось нема):
registerSurface({ "HousingFrame", "HouseEditorFrame", "HousingHouseFrame", "HousingDecorFrame" },
                "housing", "Blizzard_Housing", nil, "housing")   -- галочка «Житло»
-- Назви данжів/рейдів у шукачі груп — під опцією groupfinder.names (одне
-- налаштування на ВСІ поверхні вікна I: випадний список, Міфічний+, списки
-- Premade Groups); хром вікна (кнопки/заголовки) перекладається завжди.
-- ТЕКСТ ГРАВЦЯ у шукачі груп НЕ перекладаємо ніколи, незалежно від опції:
-- назва групи в списку («+10 Relaxed», «Chomu b ni»), назва й опис власної
-- групи у вікні заявок. Словник groupFinder має і короткі слова («Heroic»,
-- «Mythic»), тож група з такою назвою отримала б «переклад» того, що написав
-- гравець [[guild-names-never-translate]].
local function IsPlayerWrittenFS(fs)
    local p = fs.GetParent and fs:GetParent()
    if not p then return false end
    if p.resultID ~= nil and fs == p.Name then return true end   -- рядок списку груп
    local av = _G.LFGListFrame and _G.LFGListFrame.ApplicationViewer
    if av and (fs == av.EntryName
               or (av.DescriptionFrame and fs == av.DescriptionFrame.Text)) then
        return true
    end
    return false
end
registerSurface({ "PVEFrame", "LFGListFrame", "PVPUIFrame", "GroupFinderFrame", "LFDParentFrame" },
                "groupFinder", "Blizzard_GroupFinder",
                function(en, fs)
                    if fs and IsPlayerWrittenFS(fs) then return true end
                    -- опція ПЕРШОЮ: IsInstanceName може довантажити LoD-журнал,
                    -- робити це варто лише коли переклад назв справді вимкнено
                    if not (ns.IsEnabled and not ns.IsEnabled("groupfinder.names")) then
                        return false
                    end
                    -- ДЕЛВ-активність: «Parhelion Plaza (Tier 11)» — делвів нема в
                    -- журнальній мапі, але суфікс «(Tier N)» унікально їх видає
                    if en:match("^.-%s%(Tier %d+%)$") then return true end
                    return IsInstanceName(en)
                end)
registerSurface({ "CalendarFrame" }, "holidays", "Blizzard_Calendar")
registerSurface({ "ProfessionsFrame", "PlayerSpellsFrame", "SpellBookFrame" },
                "skillLines", "Blizzard_Professions")
registerSurface({ "SplashFrame" }, "uiMisc", nil)
registerSurface({ "FriendsFrame", "WhoFrame", "IgnoreListFrame", "RaidFrame",
                  "QuickJoinFrame", "RecruitAFriendFrame" }, "uiMisc", "Blizzard_FriendsFrame")

-- ТАБИ FriendsFrame внизу («Контакти»/«Швидкий вступ (0)» ширші за англ. → обрізаються
-- «Швидкий в…»). Той самий фікс, що для гарнізону: PanelTemplates_TabResize підганяє ширину
-- таба під поточний укр. текст. Кличемо на показ + дозатримка (текст ставиться не миттєво)
-- і при кліку по табу (перемикання може перемалювати ширину).
local function ResizeFriendsTabs()
    if not (Enabled() and PanelTemplates_TabResize) then return end
    local ff = _G.FriendsFrame
    if not (ff and ff.IsShown and ff:IsShown()) then return end
    for i = 1, 8 do
        local tab = _G["FriendsFrameTab" .. i]
        if tab and tab.IsShown and tab:IsShown() then
            pcall(PanelTemplates_TabResize, tab, 0)
        end
    end
end
if _G.FriendsFrame and _G.FriendsFrame.HookScript and C_Timer then
    _G.FriendsFrame:HookScript("OnShow", function()
        for _, d in ipairs({ 0, 0.1, 0.5 }) do C_Timer.After(d, ResizeFriendsTabs) end
    end)
    for i = 1, 8 do
        local tab = _G["FriendsFrameTab" .. i]
        if tab and tab.HookScript then
            tab:HookScript("OnClick", function() C_Timer.After(0, ResizeFriendsTabs) end)
        end
    end
end
registerSurface({ "GarrisonMissionFrame", "OrderHallMissionFrame", "GarrisonBuildingFrame",
                  "GarrisonLandingPage", "BFAMissionFrame", "CovenantMissionFrame" },
                "garrison", "Blizzard_GarrisonUI")

-- GameTooltip гарнізону: тултіпи-нагороди («Bonus Follower XP» тощо) йдуть через
-- GameTooltip, а не як рядок ScrollBox — surface-walk їх не бачить. Хукаємо рядки
-- тултіпа й перекладаємо зі словника garrison, ЛИШЕ коли гарнізон показаний.
local GARR_FRAMES = { "GarrisonMissionFrame", "OrderHallMissionFrame", "GarrisonBuildingFrame",
                      "GarrisonLandingPage", "BFAMissionFrame", "CovenantMissionFrame",
                      "GarrisonCapacitiveDisplayFrame", "GarrisonShipyardFrame" }
local function garrisonShown()
    for _, fn in ipairs(GARR_FRAMES) do
        local f = _G[fn]
        if f and f.IsShown and f:IsShown() then return true end
    end
end
local garrTr = makeTr("garrison")

-- Форматні мітки сторінки місії (з %d/кольорами): «Base XP: 1500», «33% Chance»,
-- «Total Maximum: 1,308/10,000». Точний збіг не ловить → патерн (зі стрипом кольорів).
local function stripColor(s)
    return (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""))
end
local GARR_PATTERNS = {
    { "^Base XP:%s*(%d+)%s*%(%+(%d+)%)$", "Базовий досвід: %s (+%s)" },
    { "^Base XP:%s*(%d+)$", "Базовий досвід: %s" },
    { "^(%d+)%%%s*Chance$", "%s%% Шанс" },
    { "^Total Maximum:%s*(.+)$", "Загальний максимум: %s" },
}
local garrPatBusy = false
local function garrPatTr(fs)
    if garrPatBusy or not fs or not fs.GetText then return end
    local raw = ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText()
    if not raw or raw == "" then return end
    if ns.HasCyrillic and ns.HasCyrillic(raw) then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    local t = stripColor(raw)
    for _, p in ipairs(GARR_PATTERNS) do
        local a, b = t:match(p[1])
        if a then
            garrPatBusy = true
            if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
            fs:SetText(b and p[2]:format(a, b) or p[2]:format(a))
            if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
            garrPatBusy = false
            return
        end
    end
end

-- RE-WALK на події соратників/місій: деталі соратника/сторінка місії оновлюються
-- при КЛІКУ, після первинного walk'у → нові написи (Cleave/Base XP/Chance) не
-- зловлені. Walk'аємо наново + self-heal на нові написи. Без тікера — лише на події.
local garrHooked = setmetatable({}, { __mode = "k" })
local function garrWalk(frame, depth)
    if not frame or depth > 12 or type(frame) ~= "table" then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") then
                if not garrHooked[rg] and type(rg.SetText) == "function" then
                    garrHooked[rg] = true
                    hooksecurefunc(rg, "SetText", function(self)
                        if Enabled() and garrisonShown() then pcall(garrTr, self); pcall(garrPatTr, self) end
                    end)
                end
                pcall(garrTr, rg)
                pcall(garrPatTr, rg)
            end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then garrWalk(c, depth + 1) end end
    end
end
local function RewalkGarrison()
    if not (Enabled() and ns.garrison and garrisonShown()) then return end
    for _, fn in ipairs(GARR_FRAMES) do
        local f = _G[fn]
        if f and f.IsShown and f:IsShown() then pcall(garrWalk, f, 1) end
    end
end
do
    local gev = CreateFrame("Frame")
    for _, e in ipairs({ "GARRISON_FOLLOWER_LIST_UPDATE", "GARRISON_FOLLOWER_XP_CHANGED",
                         "GARRISON_FOLLOWER_CATEGORIES_UPDATED", "GARRISON_MISSION_LIST_UPDATE",
                         "GARRISON_FOLLOWER_ADDED", "GARRISON_SHOW_LANDING_PAGE" }) do
        pcall(gev.RegisterEvent, gev, e)
    end
    gev:SetScript("OnEvent", function()
        for _, d in ipairs({ 0, 0.1, 0.3 }) do C_Timer.After(d, RewalkGarrison) end
    end)
end

-- Вибір соратника (клік у списку) НЕ дає події → деталі (Cleave/Pummel/Profession/
-- Mission Duration) ставляться без re-walk. Чіпляємо ФУНКЦІЮ показу соратника
-- (захисно — кілька кандидатів імен у різних версіях) → re-walk при кожному виборі.
local function bump() for _, d in ipairs({ 0, 0.05, 0.2 }) do C_Timer.After(d, RewalkGarrison) end end
local function HookFollowerShow()
    -- глобальні функції показу соратника/місії (WoD/Legion)
    for _, gname in ipairs({ "GarrisonFollowerPage_ShowFollower",
                             "GarrisonMissionPage_ShowMission", "GarrisonMissionButton_OnClick" }) do
        if type(_G[gname]) == "function" and not _G["__uall_" .. gname] then
            _G["__uall_" .. gname] = true
            pcall(hooksecurefunc, gname, bump)
        end
    end
    -- мікс-методи на FollowerTab/FollowerList/MissionTab.MissionPage фреймів
    local f = _G.GarrisonMissionFrame
    for _, path in ipairs({ f and f.FollowerTab, f and f.FollowerList,
                            f and f.MissionTab and f.MissionTab.MissionPage,
                            _G.GarrisonLandingPage and _G.GarrisonLandingPage.FollowerTab }) do
        if path and not path.__uall_fhook then
            for _, m in ipairs({ "ShowFollower", "SetFollower", "ShowMission", "SetMission",
                                 "UpdateData", "Update" }) do
                if type(path[m]) == "function" then
                    pcall(hooksecurefunc, path, m, bump)
                end
            end
            path.__uall_fhook = true
        end
    end
end

local function translateGarrTooltip(tt)
    if not (Enabled() and ns.garrison and garrisonShown()) then return end
    if not tt or not tt.NumLines or not tt.GetName then return end
    local name = tt:GetName()
    if not name then return end
    local n = tt:NumLines()
    for i = 1, n do
        local fs = _G[name .. "TextLeft" .. i]
        if fs then pcall(garrTr, fs) end
    end
end
-- Лише OnShow: у Midnight скрипту "OnTooltipSetItem" більше немає (тултіпи через
-- TooltipDataProcessor). OnShow спрацьовує на кожне наведення → рядки вже задані.
if GameTooltip and GameTooltip.HookScript then
    GameTooltip:HookScript("OnShow", translateGarrTooltip)
end
-- Дані тултіпа можуть дозаповнюватись після OnShow (TooltipDataProcessor) — підхоп.
if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall and Enum
        and Enum.TooltipDataType then
    pcall(TooltipDataProcessor.AddTooltipPostCall, Enum.TooltipDataType.Item,
        function(tt) if tt == GameTooltip then translateGarrTooltip(tt) end end)
end

-- КАСТОМНІ гарнізон-тултіпи здібностей/соратників (це НЕ GameTooltip, а власні
-- фрейми) — walk написів на показ + переклад через garrison. Назви скілів («Cleave»),
-- описи, лічильники («Minion Swarms») у базі є — тут їх показуємо.
local GARR_TOOLTIPS = {
    "GarrisonFollowerAbilityTooltip", "GarrisonFollowerTooltip",
    "GarrisonFollowerAbilityWithoutCountersTooltip",
    "FloatingGarrisonFollowerAbilityTooltip", "FloatingGarrisonFollowerTooltip",
    "GarrisonMissionMechanicTooltip", "GarrisonMissionMechanicFollowerCounterTooltip",
    "GarrisonBuildingFollowerTooltip", "GarrisonShipyardFollowerTooltip",
}
local function walkGarrTooltipFrame(frame, depth)
    if not frame or depth > 6 or type(frame) ~= "table" then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") then pcall(garrTr, rg) end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then walkGarrTooltipFrame(c, depth + 1) end end
    end
end
local function HookGarrTooltips()
    for _, nm in ipairs(GARR_TOOLTIPS) do
        local tt = _G[nm]
        if tt and tt.HookScript and not tt.__uall_gtt then
            tt.__uall_gtt = true
            tt:HookScript("OnShow", function(self)
                if Enabled() and ns.garrison then
                    pcall(walkGarrTooltipFrame, self, 1)
                    C_Timer.After(0.03, function() pcall(walkGarrTooltipFrame, self, 1) end)
                end
            end)
        end
    end
end

-- ТАБИ гарнізону: український текст («Соратники») ширший за англ. («Followers»),
-- а Blizzard зробила фіксовану ширину під англ. → обрізає («Соратн…»). Штатний
-- PanelTemplates_TabResize підганяє ширину таба під поточний текст. Кличемо після
-- перекладу (на показ фрейму + дозатримка, бо текст ставиться не миттєво).
local function ResizeGarrTabs()
    if not (Enabled() and PanelTemplates_TabResize and garrisonShown()) then return end
    for i = 1, 6 do
        local tab = _G["GarrisonMissionFrameTab" .. i]
        if tab and tab.IsShown and tab:IsShown() then
            pcall(PanelTemplates_TabResize, tab, 0)
        end
    end
end

-- Таби-лічильники «Available - 6» / «In Progress - 0»: формат із числом, точний
-- збіг не працює → патерн (число лишаємо). Self-heal: число змінюється → SetText.
local GARR_COUNT_PATTERNS = {
    { "^Available Missions %- (%d+)$", "Доступних місій - %s" },
    { "^Available %- (%d+)$", "Доступно - %s" },
    { "^In Progress %- (%d+)$", "У процесі - %s" },
}
local countBusy = false
local function trCountFS(fs)
    if countBusy or not fs or not fs.GetText then return end
    local t = ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText()
    if not t or t == "" then return end
    if ns.HasCyrillic and ns.HasCyrillic(t) then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    for _, p in ipairs(GARR_COUNT_PATTERNS) do
        local n = t:match(p[1])
        if n then
            countBusy = true
            if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
            if ns.Remember then ns.Remember(fs, t, p[2]:format(n), nil, "interface.tier3") end
            fs:SetText(p[2]:format(n))
            if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
            countBusy = false
            return
        end
    end
end
local countHooked = {}
local function HookCountTabs()
    for i = 1, 2 do
        local tab = _G["GarrisonMissionFrameMissionsTab" .. i]
        local fs = _G["GarrisonMissionFrameMissionsTab" .. i .. "Text"] or (tab and tab.Text)
        if not fs and tab and tab.GetRegions then
            for _, r in ipairs(ns.Regions(tab)) do
                if r.IsObjectType and r:IsObjectType("FontString") then fs = r; break end
            end
        end
        if fs and not countHooked[fs] then
            countHooked[fs] = true
            hooksecurefunc(fs, "SetText", function(self) if Enabled() then pcall(trCountFS, self) end end)
            pcall(trCountFS, fs)
        end
    end
end

local function GarrTabsOnShow()
    HookFollowerShow()  -- зачепити функцію показу соратника (деталі при виборі)
    HookGarrTooltips()  -- кастомні тултіпи здібностей
    for _, d in ipairs({ 0, 0.1, 0.5 }) do
        C_Timer.After(d, ResizeGarrTabs)
        C_Timer.After(d, HookCountTabs)
        C_Timer.After(d, HookFollowerShow)  -- FollowerTab міг створитись пізніше
        C_Timer.After(d, HookGarrTooltips)
    end
end
do
    local f = _G.GarrisonMissionFrame
    if f and f.HookScript and not f.__uall_tabs then
        f.__uall_tabs = true
        f:HookScript("OnShow", GarrTabsOnShow)
    end
    -- фрейм може вантажитись пізніше (LoD Blizzard_GarrisonUI)
    local ev = CreateFrame("Frame")
    ev:RegisterEvent("ADDON_LOADED")
    ev:SetScript("OnEvent", function(_, _, n)
        if n == "Blizzard_GarrisonUI" then
            local g = _G.GarrisonMissionFrame
            if g and g.HookScript and not g.__uall_tabs then
                g.__uall_tabs = true
                g:HookScript("OnShow", GarrTabsOnShow)
            end
        end
    end)
end
