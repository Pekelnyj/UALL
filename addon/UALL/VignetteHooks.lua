-- UALL: переклад назв РІДКІСНИХ мобів/скарбів (vignette) — мітки на МАПІ СВІТУ та
-- МІНІМАПІ. Назва показується у тултіпі при наведенні на пін (мапа/мінімапа) та як
-- підпис піна на мапі. База ns.vignette (унікальні власні назви істот/об'єктів).
-- КОНТЕКСТНО-ОБМЕЖЕНО [[context-scoped-translation]]: тултіп перекладаємо лише коли
-- відкрита WorldMapFrame АБО курсор над мінімапою; підписи — лише walk-ом мапи.
-- Збіг ТОЧНИЙ (власні назви), лише свій словник.

local _, ns = ...

local function Enabled()
    return (not ns.IsEnabled) or ns.IsEnabled("interface.vignette")
end

local function MapShown()
    local f = _G.WorldMapFrame
    return f and f.IsShown and f:IsShown()
end

-- контекст vignette: мапа світу або наведення на мінімапу (блип рідкісного)
local function VigContext()
    if MapShown() then return true end
    local mm = _G.Minimap
    if mm and mm.IsMouseOver and mm:IsMouseOver() then return true end
    return false
end

local function TrText(en)
    if not en or en == "" or not ns.vignette then return nil end
    if ns.HasCyrillic and ns.HasCyrillic(en) then return nil end
    local ua = ns.vignette[en]
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
        if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.vignette") end
        fs:SetText(ua)
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    end
end

-- ТУЛТІП піна (назва рідкісного/скарбу) — лише у vignette-контексті
local function TrTip(tt)
    if not (Enabled() and tt and tt.NumLines and VigContext()) then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    local name = tt.GetName and tt:GetName()
    for i = 1, tt:NumLines() do
        local fs = (name and _G[name .. "TextLeft" .. i]) or (tt.GetLeftLine and tt:GetLeftLine(i))
        if fs then pcall(TrFS, fs) end
    end
end

-- Підписи пінів на самій мапі (walk) — лише коли мапа відкрита
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
        if Enabled() then pcall(Walk, _G.WorldMapFrame, 1) end
        C_Timer.After(0.3, tick)
    end
    C_Timer.After(0.05, tick)
end

local function HookMap()
    local f = _G.WorldMapFrame
    if f and f.HookScript and not f.__uall_vig then
        f.__uall_vig = true
        f:HookScript("OnShow", StartTicker)
    end
end
HookMap()

if _G.GameTooltip and _G.GameTooltip.HookScript then
    _G.GameTooltip:HookScript("OnShow", function(self)
        if C_Timer and C_Timer.After then
            C_Timer.After(0.02, function() pcall(TrTip, self) end)
        else
            pcall(TrTip, self)
        end
    end)
end

local ev = CreateFrame("Frame")
ev:RegisterEvent("ADDON_LOADED")
ev:SetScript("OnEvent", function(_, _, n)
    if n == "Blizzard_WorldMap" then HookMap() end
end)
