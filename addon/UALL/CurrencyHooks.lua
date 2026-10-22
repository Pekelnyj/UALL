-- WoWUkraine: переклад валют у тултіпах (гаманець, нагороди квестів, токен-
-- фрейм) і в слотах нагород. База: ns.currencies[currencyID] =
-- { name = ua, en = EN-назва, desc = ua-опис, den = EN-опис }.
-- Підміна — лише видимий текст (SetText), без замін API — без taint.

local _, ns = ...

-- Зворотний індекс EN-назва -> запис (для слотів нагород, де є лише назва).
ns.currencyByName = ns.currencyByName or {}
if ns.currencies then
    for _, e in pairs(ns.currencies) do
        if type(e) == "table" and e.en then
            ns.currencyByName[e.en] = e
        end
    end
end

local function NameLine(tooltip)
    if tooltip.GetLeftLine then
        local line = tooltip:GetLeftLine(1)
        if line then return line end
    end
    local name = tooltip.GetName and tooltip:GetName()
    return name and _G[name .. "TextLeft1"] or nil
end

local function LineByIndex(tooltip, i)
    if tooltip.GetLeftLine then
        local line = tooltip:GetLeftLine(i)
        if line then return line end
    end
    local name = tooltip.GetName and tooltip:GetName()
    return name and _G[name .. "TextLeft" .. i] or nil
end

local function TranslateCurrencyTooltip(tooltip, data)
    if not ns.IsEnabled("currency") then return end -- перемикач «Валюти»
    if ns.ShowOriginal() then return end -- клавіша «показати оригінал»
    local id = data and data.id
    local entry = id and ns.currencies and ns.currencies[id]
    if type(entry) ~= "table" then return end
    local changed = false

    -- 1) Назва — рядок 1 (зі збереженням кольору рідкості).
    if entry.name then
        local line = NameLine(tooltip)
        local orig = ns.SafeText(line and line:GetText())
        if orig and not orig:find(entry.name, 1, true) then
            local r, g, b = line:GetTextColor()
            local shown = ns.ApplyNames(entry.name) .. " |cff808080(" .. orig .. ")|r"
            line:SetText(shown)
            if r then line:SetTextColor(r, g, b) end
            ns.Remember(line, orig, shown, nil, "currency")
            changed = true
        end
    end

    -- 2) Опис — шукаємо рядок, що дорівнює EN-опису (den), і міняємо на ua.
    if entry.desc and entry.den then
        for i = 2, tooltip:NumLines() do
            local line = LineByIndex(tooltip, i)
            local text = ns.SafeText(line and line:GetText())
            if text == entry.den then
                local r, g, b = line:GetTextColor() -- зберегти колір (опис буває жовтий)
                line:SetText(entry.desc)
                if r then line:SetTextColor(r, g, b) end
                ns.Remember(line, entry.den, entry.desc, nil, "currency")
                changed = true
                break
            end
        end
    end

    if changed then tooltip:Show() end
end

if TooltipDataProcessor and Enum.TooltipDataType and Enum.TooltipDataType.Currency then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Currency,
        TranslateCurrencyTooltip)
end

-- ── ВІКНО «ВАЛЮТА» (TokenFrame): переклад ОВЕРЛЕЄМ, їхній текст НЕДОТОРКАНИЙ ──
-- ЧОМУ НЕ МОЖНА ПІДМІНЯТИ ТЕКСТ. Клік по рядку відкриває TokenFramePopup
-- («Currency Options» з Transfer). Гра при кліку читає ТЕКСТ КНОПКИ рядка
-- (button:GetText() = текст її напису), щоб зрозуміти, яку валюту вибрано.
-- Тому будь-яка наша підміна ламала попап: з перекладом він не відкривався
-- жодного разу; з тікером, що писав раз на 0.15 с, — лише якщо клікнути в мить,
-- поки текст ще англійський (звідси «іноді працює при спам-кліку»).
-- РІШЕННЯ: їхній напис лишається англійським (гра його читає), ми лише робимо
-- його ПРОЗОРИМ і малюємо поверх ВЛАСНИЙ напис українською.
-- Дві помилки першої спроби, виправлені тут:
--   1) шрифт брали з оригіналу — він БЕЗ кирилиці, виходили □□□. Тепер розмір і
--      прапорці з оригіналу, а файл шрифту — наш ns.CYR_FONT.
--   2) alpha гасили ОДИН раз і запам'ятовували — гра скидає її при кожній
--      перемальовці рядка, і англійський текст вилазив назад. Тепер гасимо
--      ЩОПРОХОДУ, поки показуємо свій напис.
local overlayHost = CreateFrame("Frame", nil, UIParent)
local overlays = setmetatable({}, { __mode = "k" })  -- [їхній FontString] = наш FontString
local shown = {}                                     -- кого показали цього проходу

local function GetOverlay(orig)
    local o = overlays[orig]
    if not o then
        o = overlayHost:CreateFontString(nil, "OVERLAY")
        overlays[orig] = o
    end
    local p = orig:GetParent() or overlayHost
    if o:GetParent() ~= p then o:SetParent(p) end     -- слідує за рядком (скрол/ховання)
    -- ШРИФТ: розмір/стиль з оригіналу, файл — НАШ кириличний (ns.CYR_FONT з
    -- Fonts.lua). Якщо встановити не вдалось, FontString лишається БЕЗ шрифту і
    -- не малюється взагалі — тому перевіряємо результат і маємо запасні шляхи:
    -- шрифт-об'єкт оригіналу (його кирилізує Fonts.lua) або його файл.
    local file, size, flags = orig:GetFont()
    local okFont = pcall(o.SetFont, o, ns.CYR_FONT, size or 12, flags or "")
    if not okFont or not o:GetFont() then
        local fo = orig.GetFontObject and orig:GetFontObject()
        if fo then pcall(o.SetFontObject, o, fo)
        elseif file then pcall(o.SetFont, o, file, size or 12, flags or "") end
    end
    o:SetJustifyH(orig:GetJustifyH() or "LEFT")
    o:SetJustifyV(orig:GetJustifyV() or "MIDDLE")
    o:SetDrawLayer("OVERLAY", 7)
    o:ClearAllPoints()                                -- ПІСЛЯ SetParent (він скидає анкори)
    o:SetPoint("LEFT", orig, "LEFT", 0, 0)
    return o
end

local function RestoreAll()
    for orig, o in pairs(overlays) do
        o:Hide()
        pcall(orig.SetAlpha, orig, 1)
    end
    wipe(shown)
end

local function WalkTokenRows(frame, depth)
    if not frame or depth > 8 or type(frame) ~= "table" then return end
    if frame.IsShown and not frame:IsShown() then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") and rg.GetText then
                local txt = ns.SafeText(rg:GetText())
                local e = txt and txt ~= "" and ns.currencyByName and ns.currencyByName[txt]
                local ua = e and e.name
                if ua and ua ~= txt then
                    local o = GetOverlay(rg)
                    o:SetText(ua)
                    -- Колір беремо БЕЗ альфи: ми самі щойно гасимо оригінал, і якщо
                    -- скопіювати його альфу — наш напис теж стане прозорим уже на
                    -- наступному проході (саме через це переклад «блимав» 0.1 с і
                    -- зникав). r,g,b несуть сірий колір недоступних валют — цього досить.
                    local r, g, b = rg:GetTextColor()
                    if r then o:SetTextColor(r, g, b, 1) end
                    o:Show()
                    pcall(rg.SetAlpha, rg, 0)             -- ЩОПРОХОДУ, не один раз
                    shown[rg] = true
                end
            end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do WalkTokenRows(c, depth + 1) end
    end
end

do
    local ticker = CreateFrame("Frame")
    local acc, active = 0, false
    ticker:SetScript("OnUpdate", function(_, elapsed)
        acc = acc + elapsed
        -- 0.04 с (~25/с): при кліку гра перемальовує рядок (повертає англійську й
        -- альфу), і до нашого наступного проходу видно «блік». Що коротший
        -- інтервал — то менш помітний. Прохід дешевий: лише поки вікно відкрите,
        -- ~20 рядків, і для нецільових написів робота = один пошук у таблиці.
        if acc < 0.04 then return end
        acc = 0
        local tf = _G.TokenFrame
        local on = tf and tf.IsShown and tf:IsShown()
                   and ns.IsEnabled("currency")
                   and not (ns.ShowOriginal and ns.ShowOriginal())
        if not on then
            if active then RestoreAll(); active = false end
            return
        end
        active = true
        wipe(shown)
        pcall(WalkTokenRows, tf, 0)
        for orig, o in pairs(overlays) do              -- рядок прокрутився/змінив валюту
            if not shown[orig] then
                o:Hide()
                pcall(orig.SetAlpha, orig, 1)
            end
        end
    end)
end
