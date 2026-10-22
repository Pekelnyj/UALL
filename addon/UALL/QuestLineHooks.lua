-- UALL: переклад назв СЮЖЕТНИХ ЛІНІЙ/КАМПАНІЙ (QuestLine) у журналі квестів.
-- Назви ліній — заголовки-FontString у QuestMapFrame (журнал/кампанія). Walk +
-- точний збіг із ns.questLines. КОНТЕКСТНО-ОБМЕЖЕНО: лише QuestMapFrame + лише
-- свій словник [[context-scoped-translation]]. Shift через ns.Remember.

local _, ns = ...

local function Enabled()
    return (not ns.IsEnabled) or ns.IsEnabled("interface.questLine")
end

local function TrFS(fs)
    if not fs or not fs.GetText then return end
    local en = ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText()
    if not en or en == "" then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    if ns.HasCyrillic and ns.HasCyrillic(en) then return end
    local ua = ns.questLines and ns.questLines[en]
    if ua and ua ~= en then
        if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.questLine") end
        fs:SetText(ua)
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    end
end

local function Walk(frame, depth)
    if not frame or depth > 9 or type(frame) ~= "table" then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") then pcall(TrFS, rg) end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then Walk(c, depth + 1) end end
    end
end

local function Refresh()
    if not (Enabled() and ns.questLines) then return end
    local f = _G.QuestMapFrame
    if f and f.IsShown and f:IsShown() then pcall(Walk, f, 1) end
end

local ticking = false
local function StartTicker()
    if ticking or not (C_Timer and C_Timer.After) then return end
    ticking = true
    local function tick()
        local f = _G.QuestMapFrame
        if not (f and f.IsShown and f:IsShown()) then ticking = false; return end
        Refresh()
        C_Timer.After(0.3, tick)
    end
    C_Timer.After(0.05, tick)
end

local function Kick() Refresh(); StartTicker() end

-- СИНХРОННИЙ фікс блимання: список квестів на мапі — це ScrollBox (QuestScrollFrame).
-- На розгортанні/згортанні зони чи скролі Blizzard перевикористовує кнопки й ставить
-- АНГЛІЙСЬКИЙ текст. Хук на :Update повертає UA В ТОМУ Ж кадрі, ПІСЛЯ Blizzard —
-- на екран англійська не потрапляє (тікер лишається запаскою для інших перемальовок).
local scrollHooked = false
local function HookScrollBox()
    if scrollHooked then return end
    local sb = _G.QuestScrollFrame
    if sb and type(sb.Update) == "function" and not sb.__uall_ql_upd then
        sb.__uall_ql_upd = true
        scrollHooked = true
        hooksecurefunc(sb, "Update", function() pcall(Refresh) end)
    end
end

local function HookShow()
    local f = _G.QuestMapFrame
    if f and f.HookScript and not f.__uall_ql then
        f.__uall_ql = true
        f:HookScript("OnShow", Kick)
    end
    HookScrollBox()
end
HookShow()

-- журнал — у Blizzard_QuestLog? зазвичай уже завантажений; підстрахуємось подією.
local ev = CreateFrame("Frame")
ev:RegisterEvent("QUEST_LOG_UPDATE")
ev:SetScript("OnEvent", function() HookShow(); if _G.QuestMapFrame and _G.QuestMapFrame:IsShown() then Kick() end end)
