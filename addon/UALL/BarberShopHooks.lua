-- UALL: переклад підписів/варіантів зовнішності у ПЕРУКАРНІ.
-- База: ns.chrCustomization (ChrCustomization* + BarberShop). КОНТЕКСТНО-ОБМЕЖЕНО:
-- лише свій словник [[context-scoped-translation]].
--
-- ВАЖЛИВО (виправлено): підписи/дропдауни живуть у `CharCustomizeFrame`
-- (Options.*.Label / Dropdown.Text), а НЕ в BarberShopFrame — це ОКРЕМИЙ фрейм,
-- не дитина. Старий хук ходив лише по BarberShopFrame → нічого не перекладалось.
-- Тепер walk'аємо ОБИДВА. Тікер прибрано → source-хук: walk на показ + self-heal
-- SetText (дропдауни/підписи оновлюються при зміні категорії) + re-walk на оновлення.
-- (Екран СТВОРЕННЯ персонажа — до входу у світ, аддон там не вантажиться.)

local _, ns = ...

local function Enabled()
    return (not ns.IsEnabled) or ns.IsEnabled("interface.barber")
end

local FRAMES = { "BarberShopFrame", "CharCustomizeFrame" }
local function shown()
    for _, fn in ipairs(FRAMES) do
        local f = _G[fn]
        if f and f.IsShown and f:IsShown() then return true end
    end
end

-- «показати оригінал» у ПЕРУКАРНІ: стабільний перемикач АБО живий Shift.
-- Тонкість: у фуллскрін-кастомізації MODIFIER_STATE_CHANGED аддонам НЕ прилітає
-- (доведено db.ccmod), тож подію натиску/відпускання не зловити. АЛЕ опитування
-- IsShiftKeyDown() працює (заборонено лише ПОДІЮ, не стан). Тому стан читаємо тут,
-- а перемальовування на edge робить shiftWatcher (нижче) — інакше текст залипав би.
local function ShowOrig()
    return ns.originalToggled or IsShiftKeyDown()
end

local applying = false
local function TrFS(fs)
    if applying or not fs or not fs.GetText then return end
    local en = ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText()
    if not en or en == "" then return end
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    if ShowOrig() then return end
    if ns.HasCyrillic and ns.HasCyrillic(en) then return end
    -- варіанти зовнішності + загальні UI-рядки кнопок (Cancel/Reset/Accept тощо
    -- живуть у ns.uiStrings). chrCustomization ПЕРШИМ — має пріоритет.
    local ua = (ns.chrCustomization and ns.chrCustomization[en])
        or (ns.uiMisc and ns.uiMisc[en])
        or (ns.uiStrings and ns.uiStrings[en])
    if ua and ua ~= en then
        applying = true
        if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.barber") end
        fs:SetText(ua)
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
        applying = false
    end
end

-- self-heal: зміна категорії/опції перепише напис → одразу повертаємо переклад
local hookedFS = setmetatable({}, { __mode = "k" })
local function selfHeal(fs)
    if applying or not (Enabled() and ns.chrCustomization and shown()) then return end
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

-- forward: Walk зустрічає кнопку-дропдаун і просить зачепити її список
local hookPopout
local function Walk(frame, depth)
    if not frame or depth > 11 or type(frame) ~= "table" then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") then
                hookFS(rg); pcall(TrFS, rg)
            end
        end
    end
    -- кнопка-дропдаун (зачіска/тіло) тримає своє спливне меню в полі .SelectionPopout
    -- /.Popout; саме меню — окрема страта, Walk його з CharCustomizeFrame не дістає,
    -- тож чіпляємось на нього через кнопку (не залежить від назви міксина).
    if hookPopout and (rawget(frame, "SelectionPopout") or rawget(frame, "Popout")) then
        pcall(hookPopout, frame)
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then Walk(c, depth + 1) end end
    end
end

-- зачепити спливний список дропдауна: на його показ відкладено walk'аємо (записи
-- створюються ліниво) → перекласти кожен SelectionName. Подія+кілька After — НЕ тікер
-- (той самий патерн, що OnShow перукарні). Запис слабкий, щоб не текло.
local hookedPopouts = setmetatable({}, { __mode = "k" })
function hookPopout(btn)
    local po = rawget(btn, "SelectionPopout") or rawget(btn, "Popout")
    if not po or hookedPopouts[po] or type(po) ~= "table" or not po.HookScript then return end
    hookedPopouts[po] = true
    po:HookScript("OnShow", function()
        for _, d in ipairs({ 0, 0.05, 0.2 }) do
            C_Timer.After(d, function()
                if Enabled() and ns.chrCustomization and po.IsShown and po:IsShown() then
                    pcall(Walk, po, 1)
                end
            end)
        end
    end)
end

local function Refresh()
    if not (Enabled() and ns.chrCustomization) then return end
    for _, fn in ipairs(FRAMES) do
        local f = _G[fn]
        if f and f.IsShown and f:IsShown() then pcall(Walk, f, 1) end
    end
end

-- зачепити OnShow обох фреймів + методи оновлення опцій кастомізації (re-walk при
-- зміні категорії/варіанта — без тікера). Методи захисно (імена в Midnight мінливі).
-- ВАЖЛИВО (taint): «вже зачеплено» тримаємо в НАШІЙ таблиці, а НЕ записом поля в
-- сам Blizzard-фрейм/мікс — запис у захищену таблицю заражає її, і захищені дії
-- (зміна зовнішності) блокуються попапом «blocked from an action».
local hookedFrames = setmetatable({}, { __mode = "k" })
local function HookFrame(fn)
    local f = _G[fn]
    if not f or hookedFrames[f] then return end
    hookedFrames[f] = true
    if f.HookScript then
        f:HookScript("OnShow", function()
            for _, d in ipairs({ 0, 0.1, 0.4 }) do C_Timer.After(d, Refresh) end
        end)
    end
    for _, m in ipairs({ "UpdateCustomizations", "SetSelectedData", "OnShow",
                         "UpdateOptionButtons", "RefreshCustomizations", "Update" }) do
        if type(f[m]) == "function" then pcall(hooksecurefunc, f, m, Refresh) end
    end
end
local function HookAll() for _, fn in ipairs(FRAMES) do HookFrame(fn) end end
HookAll()

-- Тултіп типу тіла показує "Body 1"/"Body 2" — гра будує його динамічно
-- (Body + номер), у DB2 такого рядка нема. Перекладаємо патерном, а також
-- ловимо будь-який підпис варіанта зі словника. Активно ЛИШЕ поки відкрито
-- перукарню/кастомізацію (інакше не чіпаємо світові тултіпи).
local function TrCustomTooltip(tt)
    if not (Enabled() and shown()) then return end
    if ShowOrig() then return end
    local name = tt.GetName and tt:GetName()
    if not name or not tt.NumLines then return end
    -- CustomizationNoHeaderTooltip має фіксовану ширину під АНГЛ. текст → довший укр.
    -- обрізається «…». Тому для кастом-тултіпів підганяємо ширину. GameTooltip авто-
    -- розмір — його не чіпаємо.
    local isCustom = name:find("Customization") ~= nil
    local maxNeed = 0
    for i = 1, tt:NumLines() do
        local fs = _G[name .. "TextLeft" .. i]
        local en = fs and fs.GetText and ns.SafeText(fs:GetText()) -- SafeText: nil для secret
        if en and not (ns.HasCyrillic and ns.HasCyrillic(en)) then
            -- кнопки кастомізації (камера/зум/рандом/тіло) мають лише іконку, текст
            -- живе в тултіпі. Дивимось у словники: варіанти зовнішності + загальні
            -- UI-рядки (Zoom Out=ns.uiStrings, Randomize Appearance=ns.uiMisc).
            local num = en:match("^Body (%d+)$")
            local ua = num and ("Тіло " .. num)
                or (ns.chrCustomization and ns.chrCustomization[en])
                or (ns.uiMisc and ns.uiMisc[en])
                or (ns.uiStrings and ns.uiStrings[en])
            if ua and ua ~= en then
                fs:SetText(ua)
                if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
                -- Заслін той самий, що в решті: якщо напис усередині ScrollBox,
                -- ширину не чіпаємо — це тейнтить рахунок прокрутки. Тултіпи
                -- барбершопа зазвичай поза списками, але перевірка дешева, а
                -- ціна помилки — заблокована дія [[bagsearch-setmatches-taint]].
                if isCustom and fs.GetUnboundedStringWidth
                    and not (ns.InScrollBox and ns.InScrollBox(fs)) then
                    local need = fs:GetUnboundedStringWidth() -- ширина без обрізки
                    if need and need > 0 then
                        -- якщо в напису явна (обмежувальна) ширина — розсуваємо
                        if fs.GetWidth and fs:GetWidth() > 0 and fs:GetWidth() < need then
                            fs:SetWidth(need + 2)
                        end
                        if need > maxNeed then maxNeed = need end
                    end
                end
            end
        end
    end
    -- розсунути сам кадр тултіпа під найширший рядок (+ поля).
    if isCustom and maxNeed > 0 and tt.SetWidth and tt.GetWidth
        and tt:GetWidth() < maxNeed + 28 then
        tt:SetWidth(maxNeed + 28)
    end
end
-- Тултіпи кнопок камери/зуму/рандому/тіла — це НЕ GameTooltip, а власні фрейми
-- кастомізації `CustomizationNoHeaderTooltip` / `CustomizationTooltip` (з'ясовано
-- скан-діагностикою). Плюс деякі тултіпи (Mirror тощо) — звичайний GameTooltip.
-- Хукаємо OnShow усіх трьох; TrCustomTooltip читає за іменем фрейму (…TextLeft1).
local hookedTips = setmetatable({}, { __mode = "k" })
local function HookTip(tt)
    if not tt or hookedTips[tt] or type(tt) ~= "table" or not tt.HookScript then return end
    hookedTips[tt] = true
    tt:HookScript("OnShow", function(self)
        TrCustomTooltip(self)
        -- текст інколи ставлять ПІСЛЯ Show → повторна обробка наступного кадру.
        C_Timer.After(0, function() if self:IsShown() then TrCustomTooltip(self) end end)
    end)
end
local function HookTooltips()
    HookTip(_G.GameTooltip)
    HookTip(_G.CustomizationNoHeaderTooltip)
    HookTip(_G.CustomizationTooltip)
end
HookTooltips()

-- Midnight перевів дропдаун кастомізації на НОВУ menu-систему (DropdownButtonMixin),
-- а НЕ SelectionPopout (його глобалів узагалі нема — авто-діагностика db.ccdebug це
-- підтвердила). Список генерується при відкритті як окреме меню. База всіх дропдаунів
-- — DropdownButtonMixin; його OnMenuOpened(self, menu) отримує сам фрейм меню →
-- відкладено walk'аємо його (переклад + self-heal кожного напису). Записи можуть
-- наповнюватись ліниво, тож кілька After. Guard shown() — діє лише в перукарні/
-- кастомізації, тож інші дропдауни гри не чіпаємо. Подія+After — не тікер.
if DropdownButtonMixin and not ns.__uall_ddbHooked then
    ns.__uall_ddbHooked = true -- guard у НАШОМУ ns, не в Blizzard-міксі (taint!)
    hooksecurefunc(DropdownButtonMixin, "OnMenuOpened", function(_, menu)
        if not (Enabled() and ns.chrCustomization and shown()) then return end
        if type(menu) ~= "table" then return end
        for _, d in ipairs({ 0, 0.05, 0.2 }) do
            C_Timer.After(d, function()
                if Enabled() and ns.chrCustomization and shown() then pcall(Walk, menu, 1) end
            end)
        end
    end)
end

-- Тултіп кнопки ТІЛА: CharCustomizeBodyTypeButtonMixin:OnEnter будує його через
-- GetAppropriateTooltip()+AddTooltipLine («Body N»). Хук OnEnter → перекласти рядки
-- того тултіпа (хоч би який фрейм це був, не лише GameTooltip).
if CharCustomizeBodyTypeButtonMixin and not ns.__uall_bodyHooked then
    ns.__uall_bodyHooked = true -- guard у НАШОМУ ns, не в Blizzard-міксі (taint!)
    hooksecurefunc(CharCustomizeBodyTypeButtonMixin, "OnEnter", function(self)
        if not (Enabled() and shown()) then return end
        local tt = self.GetAppropriateTooltip and self:GetAppropriateTooltip()
        if tt then C_Timer.After(0, function() pcall(TrCustomTooltip, tt) end) end
    end)
end

-- WATCHER КЛАВІШІ Shift. Движок НЕ шле MODIFIER_STATE_CHANGED у фуллскрін-
-- кастомізації (доведено db.ccmod), тож «показати оригінал» інакше не зробити.
-- OnUpdate активний ЛИШЕ поки відкрита перукарня (сам ховається, коли закрито) і
-- реагує тільки на EDGE (натиск/відпускання Shift), а не перемальовує щокадру:
-- на зміну стану свопає реєстр (EN↔UA) + один re-walk. Опитування — копійчане.
-- Це НЕ тікер-переклад, а детектор клавіші (єдиний шлях, що лишає рушій).
local shiftWatcher = CreateFrame("Frame")
shiftWatcher:Hide()
local lastShift = false
shiftWatcher:SetScript("OnUpdate", function(self)
    if not shown() then self:Hide(); return end
    -- стан «показати оригінал» з налаштувань (обрана клавіша, перемикач, утримання),
    -- а не жорсткий Shift — як у Крамниці мандрівників (PerksProgramHooks)
    local s = ((ns.DisplayOriginal or ns.ShowOriginal)()) and true or false
    if s ~= lastShift then
        lastShift = s
        if ns.ToggleOriginal then pcall(ns.ToggleOriginal) end -- свопнути EN↔UA реєстр
        C_Timer.After(0, Refresh)                               -- довести до пуття видимі
    end
end)
local function StartShiftWatcher()
    lastShift = IsShiftKeyDown() and true or false
    shiftWatcher:Show()
end

local ev = CreateFrame("Frame")
ev:RegisterEvent("ADDON_LOADED")
ev:RegisterEvent("BARBER_SHOP_OPEN")
ev:SetScript("OnEvent", function(_, e, a1)
    if e == "BARBER_SHOP_OPEN" then
        HookAll()
        HookTooltips() -- фрейми тултіпів кастомізації створюються при відкритті
        StartShiftWatcher()
        for _, d in ipairs({ 0, 0.1, 0.3, 0.6 }) do C_Timer.After(d, Refresh) end
    elseif a1 == "Blizzard_BarbershopUI" or a1 == "Blizzard_CharacterCustomize"
        or a1 == "Blizzard_CustomizationUI" then
        HookAll()
        HookTooltips()
        StartShiftWatcher()
    end
end)
