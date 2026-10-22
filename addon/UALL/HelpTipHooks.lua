-- UALL: переклад спливних підказок-туторіалів (Blizzard_SharedXML/HelpTip.lua).
-- Це НЕ forbidden — звичайні фрейми з пулу HelpTip.framePool, кожен має .Text та
-- кнопку (Next/Okay). Хукаємо HelpTip:Show (точка джерела) і перекладаємо написи
-- активних підказок. Словник — ns.uiMisc/ns.uiStrings (UI-рядки) + %s-патерни для
-- форматних підказок. self-heal SetText ловить перехід кроку «Next» без тікера.

local _, ns = ...

local function Enabled()
    return (not ns.IsEnabled) or ns.IsEnabled("interface.helpTip")
end

-- Форматні підказки: відображений текст уже зібраний клієнтом (%s підставлено).
-- Матчимо повний рядок патерном і збираємо українською, перекладаючи аргумент.
local PATTERNS = {
    { pat = "^You can now choose a new (.+) Specialization to unlock$",
      fmt = "Тепер можна обрати нову спеціалізацію: %s" },
    { pat = "^You can choose a new (.+) Specialization%.$",
      fmt = "Можна обрати нову спеціалізацію: %s" },
}

local function argTr(a)
    return (ns.skillLines and ns.skillLines[a])
        or (ns.uiMisc and ns.uiMisc[a])
        or (ns.uiStrings and ns.uiStrings[a]) or a
end

local function Lookup(t)
    local ua = (ns.uiMisc and ns.uiMisc[t]) or (ns.uiStrings and ns.uiStrings[t])
    if ua and ua ~= t then return ua end
    for _, p in ipairs(PATTERNS) do
        local a = t:match(p.pat)
        if a then return p.fmt:format(argTr(a)) end
    end
    return nil
end

local applying = false
local hookedFS = setmetatable({}, { __mode = "k" })

-- Захоплення НЕЗНАЙОМОЇ підказки → у db.ui (як gossip-збір). Так словник підказок
-- доповнюється сам: будь-яка англ. підказка, що трапилась гравцю, потрапляє в чергу
-- і перекладається наступним оновленням. Фільтр: реальний текст, не код/число.
local helptipCapN = 0
local function CaptureHelpTip(t)
    if not (ns.GetCaptureDB and t) then return end
    if #t < 6 or not t:find("%a") then return end           -- код/коротке — пропуск
    if ns.HasCyrillic and ns.HasCyrillic(t) then return end
    -- формат-залишки з підставленими числами краще не ловити (одноразові)
    local ok, db = pcall(ns.GetCaptureDB)
    if not ok or not db then return end
    db.ui = db.ui or {}
    db.ui[t] = true          -- МОВЧКИ (підказок багато — не спамимо чат)
end

local function TrFS(fs)
    if applying or not fs or not fs.GetText then return end
    local t = ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText()
    if not t or t == "" then return end
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    if ns.HasCyrillic and ns.HasCyrillic(t) then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    -- підказка буває ОБГОРНУТА кольором |cnNORMAL_FONT_COLOR:...|r (Midnight |cn...:)
    -- або |cAARRGGBB...|r → знімаємо для пошуку, загортаємо переклад назад.
    local pre, inner, post = t:match("^(|c[nN][%w_]+:)(.-)(|r)$")
    if not pre then pre, inner, post = t:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$") end
    inner = inner or t
    local ua = Lookup(inner)
    if ua and ua ~= inner then
        applying = true
        local out = pre and (pre .. ua .. post) or ua
        if ns.Remember then ns.Remember(fs, t, out, nil, "interface.helpTip") end
        fs:SetText(out)
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
        applying = false
    else
        CaptureHelpTip(inner)  -- незнайома підказка → у чергу збору
    end
end

-- self-heal: крок «Next» оновлює .Text того ж фрейму без нового Show → ловимо SetText.
local function selfHeal(fs)
    if applying or not Enabled() then return end
    pcall(TrFS, fs)
end
local function hookFS(fs)
    if hookedFS[fs] or type(fs) ~= "table" or type(fs.SetText) ~= "function" then return end
    hookedFS[fs] = true
    hooksecurefunc(fs, "SetText", selfHeal)
    if type(fs.SetFormattedText) == "function" then
        hooksecurefunc(fs, "SetFormattedText", selfHeal)
    end
end

local function walk(frame, depth)
    if not frame or depth > 5 or type(frame) ~= "table" then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") then
                hookFS(rg); pcall(TrFS, rg)
            end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then walk(c, depth + 1) end end
    end
end

local function TranslateActive()
    if not Enabled() or not HelpTip then return end
    local pool = HelpTip.framePool
    if pool and pool.EnumerateActive then
        for f in pool:EnumerateActive() do pcall(walk, f, 1) end
    end
end

if HelpTip and type(HelpTip.Show) == "function" then
    hooksecurefunc(HelpTip, "Show", function() TranslateActive() end)
    -- Acknowledge/HideAll/HideAllSystem можуть переоновити активні — теж перекладаємо
    if type(HelpTip.Acknowledge) == "function" then
        hooksecurefunc(HelpTip, "Acknowledge", function() TranslateActive() end)
    end
    if ns.Diag then ns.Diag("HelpTip: Show зачеплено") end
end
