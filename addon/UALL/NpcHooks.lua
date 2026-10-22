-- WoWUkraine: імена NPC і монстрів. Перемикач «Світ та інше → Імена NPC і
-- монстрів» (world.npcNames). ТИПОВО ВИМКНЕНО — гра показує оригінальні
-- (англійські) імена; гравець сам умикає українські. Shift тимчасово
-- повертає оригінал (через центральний реєстр ns.replacements).
--
-- Підхід: підміняємо лише ВИДИМИЙ текст (FontString:SetText) у точках, де
-- Blizzard його ставить — тултіп істоти і назва на неймплейті/рамці. Жодних
-- замін секретних API, жодного повторного виклику захищених обробників — без taint.
-- Зіставлення за показаним іменем: ns.npcNames["English Name"] = "Українське".
--
-- ВАЖЛИВО: імена ГРАВЦІВ не чіпаємо (UnitIsPlayer) — лише NPC/монстри.

local _, ns = ...

local function Lookup(text)
    if not text or not ns.npcNames then return nil end
    return ns.npcNames[text]
end

-- Чи активна підміна зараз (увімкнено в опціях і не утримується Shift).
local function Active()
    return ns.IsEnabled("world.npcNames") and not ns.ShowOriginal()
end

-- Безпечна перевірка «це гравець?». У Midnight делв/секрет-активності лишають
-- юніт-ТОКЕН секретним і ПІСЛЯ виходу, ПОЗА боєм. UnitIsPlayer(секрет) у булевому
-- if кидає/повертає secret → раніше це обривало переклад ДО SetText, і моби
-- лишались англійською аж до /reload (доведено db.diag: назва прочитана й перекладена,
-- але SetText не дійшов; db.errors порожній, бо throw ловив pcall).
-- pcall із порівнянням ВСЕРЕДИНІ ловить і throw, і secret-повернення. FAIL-OPEN:
-- секрет → вважаємо «не гравець» і перекладаємо (назва вже збіглась зі словником
-- NPC; у гравців таких імен немає). У бою юніт не чіпаємо взагалі (як і було).
local function ConfirmedPlayer(unit)
    if not unit or InCombatLockdown() then return false end
    local ok, isP = pcall(function() return UnitIsPlayer(unit) == true end)
    return (ok and isP) or false
end

-- Підміна одного напису-імені. unit (за наявності) — щоб не чіпати гравців.
-- ПОРЯДОК ВАЖЛИВИЙ (проти taint): у бою frame.unit неймплейта — СЕКРЕТНЕ значення,
-- і UnitIsPlayer(секрет) тейнтить захищений шлях оновлення юніт-фрейма → Blizzard
-- падає «compare a secret number … tainted by UALL». Тому СПЕРШУ читаємо текст
-- (секрет → SafeText → nil → вихід ще ДО дотику до unit), і лише коли є що
-- перекладати (Lookup спрацював = це відоме ім'я NPC, не гравця), звіряємо гравця —
-- і ЛИШЕ поза боєм, де unit не секретний. У бою ns.npcNames-специфічність сама
-- захищає від підміни імені гравця (гравці в базі імен NPC не трапляються).
local function TranslateNameFS(fs, unit)
    if not fs or type(fs.GetText) ~= "function" then return end
    if not Active() then return end
    local text = ns.SafeText(fs:GetText()) -- секретні значення -> nil
    if not text then return end
    local ua = Lookup(text)
    if not ua then return end
    if ConfirmedPlayer(unit) then return end -- секрет-safe (делв-токен secret і поза боєм)
    local r, g, b, a = fs:GetTextColor() -- зберегти колір (ім'я NPC жовте/за реакцією)
    ns.Remember(fs, text, ua, nil, "world.npcNames") -- центральний реєстр для Shift «показати оригінал»
    fs:SetText(ua)
    if r then fs:SetTextColor(r, g, b, a) end
    -- Ширину неймплейта Blizzard рахує під АНГЛІЙСЬКЕ ім'я, тож довше українське
    -- рушій ріже: «Рен'дорейський книж... 100%». Знімаємо обрізання.
    if ns.UnclipIfTruncated then ns.UnclipIfTruncated(fs) end
end

-- ТИПИ істот (фіксований набір; рядок у тултіпі на кшталт «Aberration»). Колір зберігаємо.
local CREATURE_TYPE = {
    ["Aberration"] = "Покруч", ["Beast"] = "Звір", ["Humanoid"] = "Гуманоїд",
    ["Demon"] = "Демон", ["Undead"] = "Нежить", ["Elemental"] = "Елементаль",
    ["Dragonkin"] = "Драконід", ["Giant"] = "Велетень", ["Mechanical"] = "Механізм",
    ["Critter"] = "Дрібнота", ["Totem"] = "Тотем", ["Gas Cloud"] = "Газова хмара",
    ["Uncategorized"] = "Без категорії",
}

-- Підзаголовок істоти («<Terrible Beast Master>», «Innkeeper» тощо) — рядок 2 тултіпа
-- ОДРАЗУ під іменем (до рівня/типу/фракції). База ns.npcSubnames[en] = ua; невідомі
-- збираємо в db.subnames на майбутній переклад (як gossip). Гейт — world.npcNames.
local function TranslateSubname(fs)
    if not fs or type(fs.GetText) ~= "function" then return end
    local text = ns.SafeText(fs:GetText())
    if not text or text == "" then return end
    -- не чіпати рядки рівня/фракції/типу — лише «справжній» підзаголовок
    if text:match("^Level") or CREATURE_TYPE[text] then return end
    local ua = ns.npcSubnames and ns.npcSubnames[text]
    if ua then
        local r, g, b, a = fs:GetTextColor()
        ns.Remember(fs, text, ua, nil, "world.npcNames")
        fs:SetText(ua)
        if r then fs:SetTextColor(r, g, b, a) end
    elseif text:find("%a") and not ns.HasCyrillic(text) and #text < 60
           and ns.GetCaptureDB then
        local db = ns.GetCaptureDB()
        db.subnames = db.subnames or {}
        db.subnames[text] = true
    end
end

-- 1) ТУЛТІП істоти (наведення). TooltipDataProcessor — чистий пост-виклик.
--    Рядок1=ім'я, рядок2=підзаголовок, далі — рівень/тип. Перекладаємо ім'я,
--    підзаголовок і ТИП (де є). Колір зберігається в кожній підміні.
if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall
   and Enum and Enum.TooltipDataType then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip)
        if tooltip ~= GameTooltip then return end
        pcall(function()
            local _, unit = tooltip:GetUnit()
            if unit and UnitIsPlayer(unit) then return end
            if not Active() then return end
            local name = tooltip:GetName()
            if not name then return end
            TranslateNameFS(_G[name .. "TextLeft1"], unit)
            TranslateSubname(_G[name .. "TextLeft2"])  -- підзаголовок під іменем
            -- ТИП істоти: шукаємо рядок-збіг із CREATURE_TYPE у кількох рядках
            for i = 3, math.min(tooltip:NumLines(), 8) do
                local fs = _G[name .. "TextLeft" .. i]
                local t = fs and ns.SafeText(fs:GetText())
                -- тип істоти (Beast→Звір) АБО назва фракції/організації
                -- (Dream Wardens→Вартові Сну) — точний збіг, ns.uiMisc має назви
                local ua = t and (CREATURE_TYPE[t]
                    or (ns.uiMisc and not (ns.HasCyrillic and ns.HasCyrillic(t)) and ns.uiMisc[t]))
                if ua and ua ~= t then
                    local r, g, b, a = fs:GetTextColor()
                    ns.Remember(fs, t, ua, nil, "world.npcNames")
                    fs:SetText(ua)
                    if r then fs:SetTextColor(r, g, b, a) end
                end
            end
        end)
    end)
end

-- 2) РАМКИ ГРУПИ/РЕЙДУ: Blizzard оновлює frame.name тут (функція ще існує).
if type(CompactUnitFrame_UpdateName) == "function" then
    hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
        -- заборонені фрейми (secret-неймплейти в бою) НЕ чіпаємо — дотик тейнтить
        if not frame or (frame.IsForbidden and frame:IsForbidden()) then return end
        if frame.name then ns.Guard("імена NPC", TranslateNameFS, frame.name, frame.unit) end
    end)
    if ns.Diag then ns.Diag("npc: CompactUnitFrame_UpdateName зачеплено") end
end

-- Надійний пошук напису з ІМЕНЕМ юніта всередині фрейма: точні поля у Midnight
-- змінні, тож шукаємо FontString, що показує САМЕ це ім'я (неглибокий перебір
-- регіонів + дітей). Потрібен для неймплейтів, де структура динамічна.
local function FindNameFS(frame, name, depth)
    if ns.IsTooltipFrame(frame) then return  end
    if not frame or depth > 4 then return nil end
    -- заборонений фрейм не можна обходити (iterate/GetRegions тейнтить/кидає)
    if frame.IsForbidden and frame:IsForbidden() then return nil end
    if frame.GetRegions then
        for _, r in ipairs(ns.Regions(frame)) do
            if r.IsObjectType and r:IsObjectType("FontString") then
                local ok, t = pcall(r.GetText, r)
                if ok and t and t == name then return r end
            end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do
            local f = FindNameFS(c, name, depth + 1)
            if f then return f end
        end
    end
end

-- SetText-ПІН: одноразово чіпляємо SetText конкретного напису-імені. Хай яка
-- функція Blizzard перепише текст — наш хук одразу підмінить на українську.
-- getUnit() повертає юніт цього напису (щоб не чіпати гравців). busy — захист
-- від рекурсії (наш self:SetText знову тригерить хук).
local busy = false
local pinned = {}
local function PinNameFS(fs, getUnit)
    if not fs or pinned[fs] then return false end
    pinned[fs] = true
    local function apply(self)
        if busy or not Active() then return end
        -- ПОРЯДОК проти taint: текст ПЕРШИЙ (секрет у бою → SafeText → nil → вихід
        -- ДО дотику до unit). UnitIsPlayer(секретний unit) інакше тейнтить юніт-фрейм.
        local t = ns.SafeText(self:GetText())
        local ua = Lookup(t)
        -- Ім'я + підзаголовок в одному написі: «Name <Beast Master>» / «Name\n<...>».
        -- Повний рядок у словнику не знайдеться — беремо саме ім'я, підзаголовок лишаємо.
        if not ua and t then
            local base = t:match("^(.-)%s*<.->%s*$") or t:match("^(.-)\n.*$")
            local bua = base and Lookup(base)
            if bua then ua = bua .. t:sub(#base + 1) end
        end
        -- ДІАГНОСТИКА показу імені (чому лишається англ.): записуємо, що ПРОЧИТАЛОСЯ
        -- з FontString і чи знайшовся переклад. t=nil → secret/порожньо (як делв-моби);
        -- |Англ| ua=... → хук дістав і має переклад (якщо все одно англ. — текст
        -- перевизначає рушій ПОЗА Lua-SetText); відсутність запису → хук не пінить цей FS.
        if ns.GetCaptureDB then
            pcall(function()
                local db = ns.GetCaptureDB(); db.diag = db.diag or {}
                if t == nil then
                    db.diag["nameFS: secret/порожньо (SafeText зрізав GetText)"] = true
                elseif not ns.HasCyrillic(t) and t:find("%a") then
                    db.diag["nameFS |" .. t .. "| ua=" .. tostring(ua)] = true
                end
            end)
        end
        if ua and ua ~= t then
            -- перевірка гравця лише КОЛИ є що міняти й ПОЗА боєм (у бою unit секретний
            -- → UnitIsPlayer тейнтить; Lookup-специфічність сама не чіпає імен гравців)
            local unit = getUnit and getUnit()
            if ConfirmedPlayer(unit) then return end -- секрет-safe (див. ConfirmedPlayer)
            busy = true
            local r, g, b, a = self:GetTextColor() -- зберегти колір імені
            ns.Remember(self, t, ua, nil, "world.npcNames")
            self:SetText(ua)
            if r then self:SetTextColor(r, g, b, a) end
            busy = false
        end
    end
    hooksecurefunc(fs, "SetText", apply)
    apply(fs) -- підмінити поточний текст (якщо ціль уже вибрана на момент /reload)
    return true
end

-- 3) РАМКА ЦІЛІ/ФОКУСА. За /framestack ім'я лежить у
--    TargetFrame.TargetFrameContent.TargetFrameContentMain.Name (так само FocusFrame).
--    Пінимо саме цей FontString — не залежимо від назви функції, що його ставить.
--    ФОЛБЕК: якщо точний шлях у Midnight змінився (.Name не там) — обходимо рамку
--    цілком (як неймплейти), щоб знайти напис-ім'я будь-де. apply чіпає лише збіги
--    зі словником імен, тож пінити «зайві» написи рамки безпечно.
local PinAllNameFS -- forward (визначена нижче, у блоці неймплейтів)
local function PinUnitFrame(tf)
    if not tf then return end
    local getUnit = function() return tf.unit end
    local main = tf.TargetFrameContent and tf.TargetFrameContent.TargetFrameContentMain
    local nameFS = main and main.Name
    if nameFS then
        if PinNameFS(nameFS, getUnit) and ns.Diag then
            ns.Diag("npc: пін імені цілі на " .. (tf:GetName() or "?") .. " ✓")
        end
    else
        if ns.Diag then ns.Diag("npc: .Name не за шляхом на " .. (tf:GetName() or "?") .. " > обхід рамки") end
    end
    -- завжди робимо обхід-страховку (Midnight міняє шлях; ловить ім'я в іншому FS)
    if PinAllNameFS then pcall(PinAllNameFS, tf, getUnit, 0) end
end

-- одразу + на вхід у світ (на випадок, якщо Blizzard_UnitFrame вантажиться пізніше)
PinUnitFrame(_G.TargetFrame)
PinUnitFrame(_G.FocusFrame)
local lf = CreateFrame("Frame")
lf:RegisterEvent("PLAYER_ENTERING_WORLD")
lf:SetScript("OnEvent", function()
    PinUnitFrame(_G.TargetFrame)
    PinUnitFrame(_G.FocusFrame)
end)

-- 4) НЕЙМПЛЕЙТИ (ім'я над головою). За /framestack напис-ім'я лежить у
--    <plate>.UnitFrame.name — пінимо його НАПРЯМУ (надійніше за перебір; SetText-пін
--    ловить імʼя, навіть якщо Blizzard ставить його пізніше за NAME_PLATE_UNIT_ADDED).
--    Пули неймплейтів перевикористовуються, тож getUnit бере ПОТОЧНИЙ юніт плити.
-- Пін УСІХ написів плити (неглибокий перебір). У Midnight структура неймплейта
-- динамічна: у звичайних мобів ім'я в .UnitFrame.name, а в КРИТЕРІВ/тривіальних
-- (Rabbit тощо) — в іншому FontString. apply змінює лише текст, що збігся зі
-- словником імен, тож пінити «зайві» написи (рівень, каст) безпечно.
PinAllNameFS = function(frame, getUnit, depth)
    if ns.IsTooltipFrame(frame) then return  end
    if not frame or depth > 4 then return end
    -- ЗАБОРОНЕНІ ОБ'ЄКТИ. У Midnight частина фреймів неймплейта захищена, і
    -- звернення до GetRegions/GetChildren кидає «Attempt to access forbidden
    -- object from code tainted by an AddOn» — саме це ловили тестери (23 рази
    -- за сесію). IsForbidden треба питати ПЕРШИМ, до будь-якого доступу
    -- [[unit-frame-taint-order]].
    if frame.IsForbidden then
        local ok, forbidden = pcall(frame.IsForbidden, frame)
        if not ok or forbidden then return end
    end
    if frame.GetRegions then
        local ok, regions = pcall(function() return { frame:GetRegions() } end)
        if ok then
            for _, r in ipairs(regions) do
                if r.IsObjectType and r:IsObjectType("FontString") then
                    ns.Guard("імена NPC", PinNameFS, r, getUnit)
                end
            end
        end
    end
    if frame.GetChildren then
        local ok, kids = pcall(function() return { frame:GetChildren() } end)
        if ok then
            for _, c in ipairs(kids) do
                PinAllNameFS(c, getUnit, depth + 1)
            end
        end
    end
end

if C_NamePlate then
    local npf = CreateFrame("Frame")
    npf:RegisterEvent("NAME_PLATE_UNIT_ADDED")
    npf:SetScript("OnEvent", function(_, _, unit)
        local plate = unit and C_NamePlate.GetNamePlateForUnit(unit)
        local uf = plate and plate.UnitFrame
        if not uf then return end
        local getUnit = function() return plate.namePlateUnitToken or uf.unit or unit end
        if uf.name then
            PinNameFS(uf.name, getUnit)
            if ns.Diag then ns.Diag("npc: неймплейт пін .UnitFrame.name ✓") end
        end
        -- страховка для критерів/нестандартних плит: пін будь-якого напису-імені
        -- (ім'я може бути не під .UnitFrame, а на самій плиті) — перебираємо плиту.
        PinAllNameFS(plate, getUnit, 0)
    end)
    if ns.Diag then ns.Diag("npc: NAME_PLATE_UNIT_ADDED зачеплено") end

    -- 4b) РЕ-НАКЛАДАННЯ на вхід у світ (вихід із делва/інстансу/фазування).
    --     Пули неймплейтів переюзуються. Якщо ім'я встановилося, поки текст був
    --     СЕКРЕТНИМ (делв-моби) або підміна була неактивна, англійська «застигає»
    --     до наступного SetText — тобто до /reload. PinNameFS на вже-пінутому FS
    --     виходить рано (pinned[fs]) і НЕ перекладає поточний текст. Тож на
    --     PLAYER_ENTERING_WORLD форсимо ПРЯМИЙ переклад видимих плит через
    --     TranslateNameFS (він бере ПОТОЧНИЙ текст, не чекає SetText).
    local function ReapplyWalk(frame, unit, depth)
        if not frame or depth > 4 or ns.IsTooltipFrame(frame) then return end
        if frame.IsForbidden and frame:IsForbidden() then return end
        if frame.GetRegions then
            for _, r in ipairs(ns.Regions(frame)) do
                if r.IsObjectType and r:IsObjectType("FontString") then
                    ns.Guard("імена NPC", TranslateNameFS, r, unit)
                end
            end
        end
        if frame.GetChildren then
            for _, c in ipairs(ns.Children(frame)) do ReapplyWalk(c, unit, depth + 1) end
        end
    end
    local function ReapplyPlates()
        if not C_NamePlate.GetNamePlates then return end
        for _, plate in ipairs(C_NamePlate.GetNamePlates() or {}) do
            local uf = plate.UnitFrame
            local unit = plate.namePlateUnitToken or (uf and uf.unit)
            ReapplyWalk(plate, unit, 0)
        end
    end

    local rf = CreateFrame("Frame")
    rf:RegisterEvent("PLAYER_ENTERING_WORLD")
    rf:SetScript("OnEvent", function()
        -- плити з'являються не миттєво після переходу — кілька відкладених спроб
        ns.Guard("імена NPC", ReapplyPlates)
        if C_Timer then
            C_Timer.After(0.5, function() ns.Guard("імена NPC", ReapplyPlates) end)
            C_Timer.After(2, function() ns.Guard("імена NPC", ReapplyPlates) end)
        end
    end)

    -- 4c) САМОЛІКУВАЛЬНИЙ ТІКЕР — БЕЗПЕЧНИЙ ЗАГАЛЬНИЙ МЕТОД проти «після деяких
    --     активностей ім'я знову англійське». Фазування, зміна підзони, кінець бою,
    --     стелс-переходи можуть скинути ім'я плити назад на англ. БЕЗ події, яку ми
    --     ловимо — а ловити кожну подію окремо марно. Тож раз на 1.5с обходимо
    --     ВИДИМІ плити й перекладаємо ЛИШЕ ті, що ще англійською.
    --     ЧОМУ ДЕШЕВО/БЕЗПЕЧНО: TranslateNameFS робить no-op на вже-українських
    --     (HasCyrillic) і на секретних/неактивних (SafeText→nil / Active()=false),
    --     тож поки все перекладено — тік майже безкоштовний (лише читання тексту).
    --     Taint-safe (SafeText першим, UnitIsPlayer лише поза боєм). Gate Active():
    --     коли підміну вимкнено чи утримується Shift — не чіпаємо взагалі.
    if C_Timer and C_Timer.NewTicker then
        C_Timer.NewTicker(1.5, function()
            if not Active() then return end
            ns.Prof("неймплейти 1.5с", function() ns.Guard("імена NPC", ReapplyPlates) end)
        end)
    end
end

-- 5) ДРУЖНІ NPC. Плаваюче ім'я над дружнім NPC малює РУШІЙ гри (CVar
--    UnitNameFriendlyNPCName) як світовий текст — це НЕ FontString, до нього
--    немає Lua-доступу (доведено пробою: у дружнього NPC немає ні неймплейта,
--    ні CompactUnitFrame). Перекласти можна ЛИШЕ коли дружній NPC отримує
--    CompactUnitFrame-неймплейт — тоді хук (4) NAME_PLATE_UNIT_ADDED його ловить.
--    Ми НЕ форсуємо CVar самі: у клієнта вже є ВБУДОВАНА опція (Параметри →
--    Панелі імен → неймплейти дружніх гравців/NPC). Гравець вмикає її як хоче —
--    щойно дружній неймплейт з'являється, хук (4) перекладає ім'я автоматично.

-- ДОВЕДЕНО ЕМПІРИЧНО (Jun30, тест FNP у db.diag): forbidden-неймплейт ДРУЖНІХ NPC
-- неперекладний. Для ВСІХ ForbiddenNamePlateN: forb=true, посилання .UnitFrame.name
-- дістається (nameFS=true), АЛЕ і getText, і setText кидають помилку (false) —
-- гра блокує читання й запис insecure-коду. Бар'єр жорсткий. [[floating-name...]].

-- Shift «показати оригінал» — централізовано в Core (ns.ToggleOriginal свопає
-- ns.replacements). Неймплейти/тултіпи перемальовуються Blizzard самі, тож
-- після відпускання Shift наступне оновлення поверне українську.
