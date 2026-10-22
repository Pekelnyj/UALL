-- UALL: переклад назв/описів точок інтересу на МАПІ СВІТУ (AreaPOI).
-- Назви показуються як підписи пінів + у тултіпі при наведенні. База ns.areaPOI.
-- КОНТЕКСТНО-ОБМЕЖЕНО: лише коли відкрита WorldMapFrame + лише свій словник
-- [[context-scoped-translation]]. Walk пінів (підписи) + GameTooltip (назва/опис).

local _, ns = ...

local function Enabled()
    return (not ns.IsEnabled) or ns.IsEnabled("interface.areaPOI")
end

local function MapShown()
    local f = _G.WorldMapFrame
    return f and f.IsShown and f:IsShown()
end

local function TrText(en)
    if not en or en == "" or not ns.areaPOI then return nil end
    if ns.HasCyrillic and ns.HasCyrillic(en) then return nil end
    local ua = ns.areaPOI[en]
    if ua and ua ~= en then return ua end
    return nil
end

local function TrFS(fs)
    if not fs or not fs.GetText then return end
    local en = ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText()
    if not en then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    local ua = TrText(en)
    if ua then
        if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.areaPOI") end
        fs:SetText(ua)
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    end
end

-- ⚠️ ПЕРЕКЛАД ТУЛТІПА POI ВИМКНЕНО НАЗАВЖДИ (таїнт, 3 інциденти). AreaPOI-тултіп має
-- КІЛЬКА secret-number шарів layout, і БУДЬ-ЯКИЙ наш SetText тейнтить котрийсь із них —
-- навіть СИНХРОННИЙ (з пін-OnEnter, як робить конкурент для КВЕСТ-пінів):
--   • widget-set: AreaPoiUtil→GameTooltip_AddWidgetSet→TextWithState:35 (secret textHeight);
--   • придушені квест-піни: AddSuppressedPinsToTooltip→LayoutFrame:491 (secret compare).
-- Квест-піни конкурента таких шарів НЕ мають, тому там синхронний SetText чистий; у POI —
-- ні. Тейнт сідає на СПІЛЬНИЙ GameTooltip і сипле на КОЖЕН тултіп (вішає гру). Тому назви
-- POI лишаємо ЛИШЕ як підписи на мапі (Walk нижче — GameTooltip не чіпає, чисто), а
-- hover-тултіп POI — англійською. [[tooltip-widget-taint]]

-- Підписи пінів на самій мапі (walk) — теж лише коли відкрита
local function Walk(frame, depth)
    if not frame or depth > 8 or type(frame) ~= "table" then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") then pcall(TrFS, rg) end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then Walk(c, depth + 1) end end
    end
end

local ticking = false
local function StartTicker()
    if ticking or not (C_Timer and C_Timer.After) then return end
    ticking = true
    local function tick()
        if not MapShown() then ticking = false; return end
        if Enabled() then
            pcall(Walk, _G.WorldMapFrame, 1)  -- лише підписи пінів на мапі (тултіп вимкнено)
        end
        C_Timer.After(0.3, tick)
    end
    C_Timer.After(0.05, tick)
end

-- СИНХРОННИЙ фікс БЛИМАННЯ заголовків зон у журналі квестів. Список квестів на
-- карті — це ScrollBox (QuestScrollFrame), дитя WorldMapFrame; його заголовки-зони
-- («Shattrath City»→«Шаттрат») перекладає саме цей модуль (areaPOI). На розгортанні/
-- згортанні/скролі Blizzard перевикористовує кнопку й ставить АНГЛІЙСЬКУ повну назву
-- мапи, а тікер (0.3с) вертав UA із запізненням → блимало (помітно на довгих «... City»).
-- Хук на :Update вертає UA В ТОМУ Ж кадрі — англійська на екран не потрапляє.
local qsHooked = false
local function HookQuestScroll()
    if qsHooked then return end
    local sb = _G.QuestScrollFrame
    if sb and type(sb.Update) == "function" then
        qsHooked = true
        hooksecurefunc(sb, "Update", function()
            if Enabled() and not (ns.ShowOriginal and ns.ShowOriginal()) then
                pcall(Walk, sb, 1)
            end
        end)
    end
end

local function HookMap()
    local f = _G.WorldMapFrame
    if f and f.HookScript and not f.__uall_poi then
        f.__uall_poi = true
        f:HookScript("OnShow", StartTicker)
    end
    HookQuestScroll()
end
HookMap()

local ev = CreateFrame("Frame")
ev:RegisterEvent("ADDON_LOADED")
ev:SetScript("OnEvent", function(_, _, n)
    if n == "Blizzard_WorldMap" or n == "Blizzard_QuestLog" then HookMap() end
end)
