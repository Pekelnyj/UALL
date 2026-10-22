-- WoWUkraine: показ перекладу ТИТУЛІВ гравця.
-- База: ns.titles["English Title"] = "Український". Підміна лише видимого тексту.
-- Два місця (за /framestack):
--   1) список вибору: PaperDollFrame.TitleManagerPane.ScrollBox (рядки = голий титул);
--   2) заголовок аркуша: CharacterFrameTitleText = "<Титул> Ім'я" або "Ім'я <Титул>".
-- Shift «показати оригінал» — через ns.Remember/ns.replacements (як усюди).

local _, ns = ...

local function Active()
    if ns.IsEnabled and not ns.IsEnabled("enabled") then return false end
    return not (ns.ShowOriginal and ns.ShowOriginal())
end

local function trim(s) return (s:gsub("^%s+", ""):gsub("%s+$", "")) end

local function Lookup(text)
    if not ns.titles or not text then return nil end
    return ns.titles[text] or ns.titles[trim(text)]
end

-- 1) СПИСОК ВИБОРУ: кожен рядок ScrollBox показує голий титул у FontString.
local function TranslateRow(frame)
    if not frame or not frame.GetRegions then return end
    for _, r in ipairs(ns.Regions(frame)) do
        if r.IsObjectType and r:IsObjectType("FontString") then
            local t = ns.SafeText and ns.SafeText(r:GetText())
            local ua = t and Lookup(t)
            if ua and ua ~= t then
                ns.Remember(r, t, ua)
                r:SetText(ua)
                if ns.ApplyCyrFont then ns.ApplyCyrFont(r) end  -- шрифт із кирилицею
            end
        end
    end
end

local hookedPane = false
local function HookTitlePane()
    if hookedPane then return end
    local pane = PaperDollFrame and PaperDollFrame.TitleManagerPane
    local sb = pane and pane.ScrollBox
    if not sb or type(sb.Update) ~= "function" then return end
    hooksecurefunc(sb, "Update", function(self)
        if not Active() or type(self.GetFrames) ~= "function" then return end
        for _, f in ipairs(self:GetFrames()) do pcall(TranslateRow, f) end
    end)
    hookedPane = true
    if ns.Diag then ns.Diag("titles: пін списку ✓") end
end

-- 2) ЗАГОЛОВОК АРКУША: "<Титул> Ім'я" (префікс) або "Ім'я <Титул>" (суфікс).
local function TranslateCharTitle(fs)
    if not fs or not Active() then return end
    local text = ns.SafeText and ns.SafeText(fs:GetText())
    if not text or text == "" then return end
    local me = UnitName("player")
    if not me or me == "" or #text <= #me then return end
    local ua
    if text:sub(-#me) == me then                 -- "<Title> Me"
        local t = Lookup(trim(text:sub(1, #text - #me)))
        if t then ua = t .. " " .. me end
    elseif text:sub(1, #me) == me then           -- "Me <Title>"
        local t = Lookup(trim(text:sub(#me + 1)))
        if t then ua = me .. " " .. t end
    end
    if ua and ua ~= text then
        ns.Remember(fs, text, ua)
        fs:SetText(ua)
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end  -- шрифт із кирилицею
    end
end

local function HookCharTitle()
    local fs = _G.CharacterFrameTitleText
    if not fs or fs.__wuTitle then return end
    fs.__wuTitle = true
    hooksecurefunc(fs, "SetText", function(self)
        if self.__wuBusy then return end
        self.__wuBusy = true
        pcall(TranslateCharTitle, self)
        self.__wuBusy = false
    end)
    pcall(TranslateCharTitle, fs)
    if ns.Diag then ns.Diag("titles: пін заголовка ✓") end
end

-- Тригери: CharacterFrameTitleText є з логіну; TitleManagerPane.ScrollBox —
-- надійно при відкритті вікна персонажа.
local lf = CreateFrame("Frame")
lf:RegisterEvent("PLAYER_LOGIN")
lf:SetScript("OnEvent", function()
    HookCharTitle()
    HookTitlePane()
end)
if CharacterFrame and CharacterFrame.HookScript then
    CharacterFrame:HookScript("OnShow", function()
        HookCharTitle()
        HookTitlePane()
        if _G.CharacterFrameTitleText then pcall(TranslateCharTitle, _G.CharacterFrameTitleText) end
    end)
end
