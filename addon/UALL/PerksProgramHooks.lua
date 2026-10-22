-- UALL: переклад Торгового поста (Trading Post / Blizzard_PerksProgram).
-- Завдання й описи активностей беруться з ns.perksActivity (PerksActivity.db2).
-- КОНТЕКСТНО-ОБМЕЖЕНО: працює ЛИШЕ на PerksProgramFrame і дивиться ЛИШЕ у свій
-- словник — жодних запозичень з інших баз (щоб не було крос-контекстних колізій).
-- Підміна FontString-ів + кир. шрифт + Shift через ns.Remember. Без taint.

local _, ns = ...

local function Enabled()
    return (not ns.IsEnabled) or ns.IsEnabled("interface.perks")
end

-- ТІЛЬКИ власний словник вікна (+ зняти розмітку як запас). Без fallback на чужі бази.
local function Lookup(en)
    if not en or en == "" or not ns.perksActivity then return nil end
    local ua = ns.perksActivity[en]
    if ua and ua ~= en then return ua end
    local stripped = en:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
                       :gsub("^%s+", ""):gsub("%s+$", "")
    if stripped ~= en then
        ua = ns.perksActivity[stripped]
        if ua and ua ~= stripped then return ua end
    end
    return nil
end

-- SELF-HEAL: рядки ScrollBox перемальовуються Blizzard (EN) БЕЗ нашого відома —
-- тікер (0.3с) наздоганяв із затримкою, а після відпускання Shift рядок «залипав»
-- в EN, поки не переведеш на інший (ре-init). Вішаємо hooksecurefunc SetText на
-- перекладні FontString: будь-яка перемальовка одразу ре-перекладає (поважає Shift).
local hookedFS = setmetatable({}, { __mode = "k" })
local hookFS   -- forward
local function TrFS(fs)
    if not fs or not fs.GetText then return end
    local en = ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText()
    if not en or en == "" then return end
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    if ns.HasCyrillic and ns.HasCyrillic(en) then return end
    local ua = Lookup(en)
    if ua and ua ~= en then
        if hookFS then hookFS(fs) end                 -- self-heal проти перемальовки
        if ns.ShowOriginal and ns.ShowOriginal() then return end -- Shift: лишаємо оригінал
        if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.perks") end
        fs:SetText(ua)
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    end
end
function hookFS(fs)
    if hookedFS[fs] or type(fs) ~= "table" or type(fs.SetText) ~= "function" then return end
    hookedFS[fs] = true
    hooksecurefunc(fs, "SetText", function(self) ns.Guard("Торговий пост", TrFS, self) end)
end

-- НАЗВА ТОВАРУ каталогу — це назва ПРЕДМЕТА/сету (itemNames), НЕ perksActivity, тож
-- Lookup її не бачить. Дістаємо itemID з рядка ScrollBox → ns.items[itemID].name
-- (за аналогією з рецептами професій). Контекстно-безпечно: тут рядок = предмет.
local function ProductItemID(frame, elementData)
    local d = elementData
    if type(d) == "table" and d.GetData then
        local ok, dd = pcall(d.GetData, d); if ok then d = dd end
    end
    if type(d) ~= "table" then d = frame end
    if type(d) ~= "table" then return nil end
    if type(d.itemID) == "number" then return d.itemID end
    local info = d.info or d.perksVendorItemInfo or d
    if type(info) == "table" and type(info.itemID) == "number" then return info.itemID end
    local vid = d.perksVendorItemID or (type(info) == "table" and info.perksVendorItemID)
    if vid and C_PerksProgram and C_PerksProgram.GetVendorItemInfo then
        local ok, vi = pcall(C_PerksProgram.GetVendorItemInfo, vid)
        if ok and type(vi) == "table" and type(vi.itemID) == "number" then return vi.itemID end
    end
    return nil
end
local function ProductNameFS(frame)
    if type(frame) ~= "table" then return nil end
    -- шлях зі /fstack: <row>.ContentsContainer.Label
    local cc = frame.ContentsContainer
    if cc and cc.Label and cc.Label.GetText then return cc.Label end
    if frame.Label and frame.Label.GetText then return frame.Label end
    if frame.Name and frame.Name.GetText then return frame.Name end
    if frame.Text and frame.Text.GetText then return frame.Text end
    -- запас: найдовший видимий FontString у рядку
    if frame.GetRegions then
        local best
        for _, r in ipairs(ns.Regions(frame)) do
            if r.IsObjectType and r:IsObjectType("FontString") and r.GetText then
                local t = r:GetText()
                if t and t ~= "" and (not best or #t > #(best:GetText() or "")) then best = r end
            end
        end
        if best then return best end
    end
    return nil
end
-- SELF-HEAL В ТОЧЦІ ДЖЕРЕЛА: Blizzard ставить/оновлює назву товару через Label:SetText
-- не лише на init, а й на Refresh/оновленні (тому init-callback НЕ ловить усе, а тікер
-- заборонений — [[hook-at-source-not-walk]]). Хукаємо САМ SetText мітки → на КОЖНЕ
-- Blizzard-встановлення тексту одразу ре-перекладаємо, синхронно, поважаючи Shift.
-- У хуку беремо СВІЖИЙ elementData рядка (щоб на перевикористанні був правильний itemID).
local productRowOfFS = setmetatable({}, { __mode = "k" })
local hookedProductFS = setmetatable({}, { __mode = "k" })
local TranslateProductRow -- forward
local function hookProductFS(fs)
    if hookedProductFS[fs] or type(fs) ~= "table" or type(fs.SetText) ~= "function" then return end
    hookedProductFS[fs] = true
    hooksecurefunc(fs, "SetText", function(self)
        local fr = productRowOfFS[self]
        if fr then
            local ed = fr.GetElementData and fr:GetElementData()
            ns.Guard("Торговий пост", TranslateProductRow, fr, ed)
        end
    end)
end

-- itemID з elementData → ns.items[itemID].name. Реєструє пару для Shift ЗАВЖДИ; SetText
-- лише коли не показуємо оригінал. Рекурсії нема: наш SetText(ua) → хук → текст уже
-- кириличний → достроковий вихід.
function TranslateProductRow(frame, elementData)
    local fs = ProductNameFS(frame)
    if not fs then return end
    productRowOfFS[fs] = frame
    hookProductFS(fs)
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    local id = ProductItemID(frame, elementData)
    local e = id and ns.items and ns.items[id]
    local ua = (type(e) == "table" and e.name) or (type(e) == "string" and e) or nil
    if not ua then return end
    local en = ns.SafeText(fs:GetText())
    if en and en ~= ua and not (ns.HasCyrillic and ns.HasCyrillic(en)) then
        -- РЕЄСТРУЄМО пару ЗАВЖДИ (навіть під Shift), ua РІВНЕ SetText-значенню — тоді
        -- центральний ns.ToggleOriginal свопає в обидва боки ([[shift-toggle-needs-displayed-text]]).
        if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.perks") end
        if not (ns.ShowOriginal and ns.ShowOriginal()) then
            fs:SetText(ua)
            if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
        end
    end
end
local function HookProductScrollBox()
    local f = _G.PerksProgramFrame
    local sb = f and f.ProductsFrame and f.ProductsFrame.ProductsScrollBoxContainer
              and f.ProductsFrame.ProductsScrollBoxContainer.ScrollBox
    if not sb or sb.__uall_pp or not (ScrollUtil and ScrollUtil.AddInitializedFrameCallback) then return end
    sb.__uall_pp = true
    ScrollUtil.AddInitializedFrameCallback(sb, function(frame, elementData)
        ns.Guard("Торговий пост", TranslateProductRow, frame, elementData)
    end, sb)
    if sb.ForEachFrame then
        pcall(sb.ForEachFrame, sb, function(frame)
            local ed = frame.GetElementData and frame:GetElementData()
            ns.Guard("Торговий пост", TranslateProductRow, frame, ed)
        end)
    end
end

-- САПКА-МЕРЕЖА для НАЗВ товарів: init-callback + self-heal-SetText ловлять більшість,
-- але деякі рядки (напр. appearance/transmog-нагороди) Blizzard пере-ставляє на EN на
-- шляху, що обходить наш гачок FontString (async-довантаження назви вигляду) → рядок
-- залишається англійським, і НІХТО його не переперекладає (Walk чіпає лише активності,
-- не назви товарів). Тому щотік проходимо ПОТОЧНІ товарні рядки й кличемо
-- TranslateProductRow — ідемпотентно (no-op, коли вже кирилиця; поважає Shift через
-- ns.ShowOriginal). ppdbg підтвердив: itemID фартухів резолвиться, ns.items їх має.
local function RewalkProducts()
    local f = _G.PerksProgramFrame
    local sb = f and f.ProductsFrame and f.ProductsFrame.ProductsScrollBoxContainer
              and f.ProductsFrame.ProductsScrollBoxContainer.ScrollBox
    if sb and sb.ForEachFrame then
        pcall(sb.ForEachFrame, sb, function(frame)
            local ed = frame.GetElementData and frame:GetElementData()
            ns.Guard("Торговий пост", TranslateProductRow, frame, ed)
        end)
    end
end

local function Walk(frame, depth)
    if not frame or depth > 9 or type(frame) ~= "table" then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") then ns.Guard("Торговий пост", TrFS, rg) end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then Walk(c, depth + 1) end end
    end
end

local function Refresh()
    if not Enabled() then return end
    local f = _G.PerksProgramFrame
    if f and f.IsShown and f:IsShown() then
        HookProductScrollBox()  -- хук-джерело для НАЗВ товарів (InitializedFrameCallback)
        ns.Guard("Торговий пост", RewalkProducts)   -- сапка-мережа: назви товарів, що відкотились на EN
        ns.Guard("Торговий пост", Walk, f, 1)       -- активності/заголовки (перекл-словник вікна)
    end
end

-- Тікер поки вікно показане (список активностей довантажується/гортається async).
local ticking = false
local function StartTicker()
    if ticking or not (C_Timer and C_Timer.After) then return end
    ticking = true
    local function tick()
        local f = _G.PerksProgramFrame
        if not (f and f.IsShown and f:IsShown()) then ticking = false; return end
        Refresh()
        C_Timer.After(0.3, tick)
    end
    C_Timer.After(0.05, tick)
end

local StartShiftWatcher -- forward (визначено нижче, після ns-хелперів)
local function Kick() Refresh(); StartTicker(); if StartShiftWatcher then StartShiftWatcher() end end

local function HookShow()
    local f = _G.PerksProgramFrame
    if f and f.HookScript and not f.__uall_pp then
        f.__uall_pp = true
        f:HookScript("OnShow", Kick)
    end
end
HookShow()

local ev = CreateFrame("Frame")
ev:RegisterEvent("ADDON_LOADED")
ev:SetScript("OnEvent", function(_, _, name)
    if name == "Blizzard_PerksProgram" then HookShow(); Kick() end
end)

-- SHIFT-WATCHER: у вікні Крамниці MODIFIER_STATE_CHANGED аддонам НЕ прилітає (як у
-- барбершопі — [[barber-customization-pipeline]]), тож центральний ns.ToggleOriginal
-- (він на цій події) тут НІКОЛИ не запускається → Shift не свопає. Обхід: легкий
-- OnUpdate-вартовий лише ПОКИ вікно відкрите — ловить ЗМІНУ стану «показати оригінал»
-- (ns.ShowOriginal поллить IsShiftKeyDown) і кличе центральний ns.ToggleOriginal, який
-- свопає реєстр ns.replacements (у т.ч. назви товарів). Не переклад-обхід — лише реакція
-- на зміну клавіші; діє тільки при відкритому вікні.
local lastOrig
local shiftWatcher = CreateFrame("Frame")
shiftWatcher:Hide()
shiftWatcher:SetScript("OnUpdate", function(self)
    local f = _G.PerksProgramFrame
    if not (f and f.IsShown and f:IsShown()) then self:Hide(); lastOrig = nil; return end
    local cur = (ns.DisplayOriginal or ns.ShowOriginal)() or false   -- що на екрані (і в оберненому режимі)
    if cur ~= lastOrig then
        lastOrig = cur
        if ns.ToggleOriginal then pcall(ns.ToggleOriginal) end
    end
end)
function StartShiftWatcher()
    local f = _G.PerksProgramFrame
    if f and f.IsShown and f:IsShown() then lastOrig = nil; shiftWatcher:Show() end
end
