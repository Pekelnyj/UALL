-- UALL: переклад вікна PlayerChoiceFrame — вибір історії/сценарію
-- («Which story would you like to hear?» / опис доповнення / нагороди / «Begin»).
--
-- Сервер віддає ці тексти ДИНАМІЧНО (їх нема в DB2), тож:
--   • переклад беремо з ns.playerChoice[en] (+ ns.ejStrings — канон назв доповнень,
--     + ns.broadcast як запас);
--   • невідоме ловимо в db.playerchoice → перекласти → generate_db → показ.
-- FontString-и перекладаємо підміною; ОПИС історії — SimpleHTML (як BookHooks:
-- пін SetText, бо SimpleHTML ріже текст на безіменні шматки-FontString).
-- Shift повертає оригінал (ns.Remember). Без taint — лише видимий текст.

local _, ns = ...

local function Enabled()
    return (not ns.IsEnabled) or ns.IsEnabled("interface.playerChoice")
end

-- Згортання пробілів/переносів (SimpleHTML-опис гра рендерить із \r\n і власним
-- переносом рядків — байт-точний збіг ламається; нормалізуємо обидва боки).
local function Norm(s)
    return (s:gsub("<.->", " ")                          -- HTML-теги SimpleHTML
             :gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
             :gsub("|T.-|t", ""):gsub("|A.-|a", "")
             :gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", ""))
end

-- Нормалізована мапа ns.playerChoice (лінива, будується раз).
local normMap
local function BuildNorm()
    normMap = {}
    if ns.playerChoice then
        for k, v in pairs(ns.playerChoice) do normMap[Norm(k)] = v end
    end
end

-- en -> ua: ТІЛЬКИ власний словник вікна (ns.playerChoice) + канон назв доповнень
-- (ns.ejStrings — однозначні власні назви, не гомоніми). СВІДОМО БЕЗ fallback на
-- ns.broadcast/gossip/items та інші бази: один EN-рядок означає різне в різних
-- контекстах (Back=Спина/Назад), тож перевикористання чужих словників = витік
-- хибних перекладів. Кожне вікно перекладається СВОЇМИ рядками у своєму контексті.
local function Lookup(en)
    if not en or en == "" then return nil end
    local ua = (ns.playerChoice and ns.playerChoice[en])
            or (ns.ejStrings and ns.ejStrings[en])
    if ua and ua ~= en then
        return ns.ApplyNames and ns.ApplyNames(ua) or ua
    end
    -- зняти розмітку (іконка/колір/пробіли) і спробувати ще раз
    local stripped = en:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
                       :gsub("|T.-|t", ""):gsub("|A.-|a", "")
                       :gsub("^%s+", ""):gsub("%s+$", "")
    if stripped ~= en and stripped ~= "" then
        local u2 = (ns.playerChoice and ns.playerChoice[stripped])
                or (ns.ejStrings and ns.ejStrings[stripped])
        if u2 and u2 ~= stripped then
            return ns.ApplyNames and ns.ApplyNames(u2) or u2
        end
    end
    -- ОСТАННІЙ шанс: нормалізований збіг (опис з іншими переносами/пробілами).
    if not normMap then BuildNorm() end
    local un = normMap[Norm(en)]
    if un then return ns.ApplyNames and ns.ApplyNames(un) or un end
    return nil
end

local function Capture(en)
    if not en or en == "" then return end
    if ns.HasCyrillic and ns.HasCyrillic(en) then return end
    if not en:find("%a") then return end
    local db = ns.GetCaptureDB and ns.GetCaptureDB()
    if db then
        db.playerchoice = db.playerchoice or {}
        if db.playerchoice[en] == nil then db.playerchoice[en] = true end
    end
end

-- Однослівний переклад («Глибини») ширший за англ. оригінал («Delves») і не
-- переноситься (FontString з фікс. шириною) → обрізається в «Глиб...». Якщо
-- обрізано — поступово зменшуємо кегль того ж кир. шрифту, поки вміститься (до
-- підлоги 9пт). ApplyCyrFont зберігає поточний розмір, тож шринк тримається.
local function FitFontString(fs)
    if not (fs and fs.IsTruncated and fs.GetFont and fs.SetFont) then return end
    for _ = 1, 6 do
        local ok, trunc = pcall(fs.IsTruncated, fs)
        if not ok or not trunc then break end
        local file, h, flags = fs:GetFont()
        if not (file and h) or h <= 9 then break end
        pcall(fs.SetFont, fs, file, h - 1, flags)
    end
end

-- ── FontString ──────────────────────────────────────────────────────────────
local function TrFS(fs)
    if not fs or not fs.GetText then return end
    local en = ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText()
    if not en or en == "" then return end
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end  -- кир. шрифт на КОЖЕН напис (□ на «і/ї/є/ґ»)
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    if ns.HasCyrillic and ns.HasCyrillic(en) then FitFontString(fs); return end -- вже укр.: лише дофітити
    local ua = Lookup(en)
    if ua and ua ~= en then
        if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.playerChoice") end
        fs:SetText(ua)
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
        FitFontString(fs)                              -- однослівний задовгий → вмістити
    else
        Capture(en)
    end
end

-- ── SimpleHTML (опис історії) — пін SetText, як BookHooks ─────────────────────
local htmlBusy = {}
local function TrHTML(self, en)
    if htmlBusy[self] then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    en = ns.SafeText and ns.SafeText(en) or en
    if not en or en == "" then return end
    local key = (en:gsub("\r", ""))           -- база з \n, гра дає \r\n
    if ns.HasCyrillic and ns.HasCyrillic(key) then return end
    local ua = Lookup(key)
    if not ua or ua == key then Capture(key); return end
    htmlBusy[self] = true
    if ns.Remember then ns.Remember(self, key, ua, true, "interface.playerChoice") end  -- solo: SimpleHTML без пулу
    self:SetText(ua)
    htmlBusy[self] = false
end

local htmlHooked = {}
local function HookHTML(obj)
    if not obj or htmlHooked[obj] or type(obj.SetText) ~= "function" then return end
    htmlHooked[obj] = true
    hooksecurefunc(obj, "SetText", TrHTML)
    if obj.GetText then pcall(TrHTML, obj, obj:GetText()) end  -- поточний текст
end

-- ── Рекурсивний обхід вікна ──────────────────────────────────────────────────
local function Walk(frame, depth)
    if not frame or depth > 9 or type(frame) ~= "table" then return end
    -- SimpleHTML (опис історії): пінимо ЦІЛИЙ текст через SetText і НЕ рекурсуємо
    -- всередину — інакше ловили б безіменні дочірні FontString-уламки абзаців у db.
    if frame.GetObjectType then
        local ok, t = pcall(frame.GetObjectType, frame)
        if ok and t == "SimpleHTML" then HookHTML(frame); return end
    end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType then
                if rg:IsObjectType("SimpleHTML") then
                    HookHTML(rg)
                elseif rg:IsObjectType("FontString") then
                    pcall(TrFS, rg)
                end
            end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then Walk(c, depth + 1) end end
    end
end

-- ── ОПИСИ (SimpleHTML) через API ─────────────────────────────────────────────
-- Фрейми опцій ПЕРЕСТВОРЮЮТЬСЯ щоразу при відкритті вікна (нові анонімні фрейми),
-- тож SetText опису спрацьовує ДО того, як наш хук устигне причепитися, а GetText
-- на SimpleHTML ненадійний. Тому беремо описи НАПРЯМУ з API C_PlayerChoice
-- (як BookHooks бере ItemTextGetText), мапимо на SimpleHTML-фрейми зліва-направо
-- (порядок фреймів = порядок опцій) і підміняємо текст. Це й дає ТОЧНИЙ оригінал.
local function LeftOf(f)
    if not f.GetLeft then return 0 end
    local ok, l = pcall(f.GetLeft, f)
    return (ok and l) or 0
end

local function CollectHTML(frame, out, depth)
    if not frame or depth > 9 or type(frame) ~= "table" then return end
    if frame.GetObjectType then
        local ok, t = pcall(frame.GetObjectType, frame)
        if ok and t == "SimpleHTML" then out[#out + 1] = frame; return end
    end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("SimpleHTML") then out[#out + 1] = rg end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then CollectHTML(c, out, depth + 1) end end
    end
end

local function GetChoiceInfo()
    if not C_PlayerChoice then return nil end
    local fn = C_PlayerChoice.GetCurrentPlayerChoiceInfo or C_PlayerChoice.GetPlayerChoiceInfo
    if not fn then return nil end
    local ok, info = pcall(fn)
    return ok and info or nil
end

local descDone = {}
local function TranslateDescriptions(pcf)
    local info = GetChoiceInfo()
    if not info or not info.options then return end
    local htmls = {}
    CollectHTML(pcf, htmls, 1)
    if #htmls == 0 then return end
    table.sort(htmls, function(a, b) return LeftOf(a) < LeftOf(b) end)
    -- мапимо за порядком лише якщо кількість збігається (інакше зіставлення ненадійне)
    if #htmls ~= #info.options then
        for _, opt in ipairs(info.options) do
            if opt.description then Capture((opt.description:gsub("\r", ""))) end
        end
        return
    end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    for i, opt in ipairs(info.options) do
        local html = htmls[i]
        local en = opt.description and (opt.description:gsub("\r", ""))
        if html and en and en ~= "" and not (ns.HasCyrillic and ns.HasCyrillic(en)) then
            local ua = Lookup(en)
            if ua and ua ~= en then
                if descDone[html] ~= ua then
                    htmlBusy[html] = true
                    if ns.Remember then ns.Remember(html, en, ua, true, "interface.playerChoice") end
                    pcall(html.SetText, html, ua)
                    htmlBusy[html] = false
                    descDone[html] = ua
                end
            else
                Capture(en)
            end
        end
    end
end

local function Refresh()
    if not Enabled() then return end
    local pcf = _G.PlayerChoiceFrame
    if pcf and pcf.IsShown and pcf:IsShown() then
        pcall(Walk, pcf, 1)
        pcall(TranslateDescriptions, pcf)
    end
end

-- Тікер поки вікно показане: опції рендеряться асинхронно й перемальовуються
-- з даних (той самий «бій з оригіналом»), тож ре-walk раз на ~0.3с. Ідемпотентно
-- (кирилицю пропускаємо), зупиняється сам, щойно вікно сховали.
local ticking = false
local function StartTicker()
    if ticking or not (C_Timer and C_Timer.After) then return end
    ticking = true
    local function tick()
        local pcf = _G.PlayerChoiceFrame
        if not (pcf and pcf.IsShown and pcf:IsShown()) then ticking = false; return end
        Refresh()
        C_Timer.After(0.3, tick)
    end
    C_Timer.After(0.05, tick)
end

local function Kick() Refresh(); StartTicker() end

local function HookShow()
    local pcf = _G.PlayerChoiceFrame
    if pcf and pcf.HookScript and not pcf.__uall_pc then
        pcf.__uall_pc = true
        pcf:HookScript("OnShow", Kick)
    end
end
HookShow()  -- якщо фрейм уже існує

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_CHOICE_UPDATE")  -- сервер прислав/оновив вибір
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, ev, name)
    if ev == "ADDON_LOADED" then
        if name == "Blizzard_PlayerChoice" then HookShow() end
    else
        HookShow(); Kick()
    end
end)
