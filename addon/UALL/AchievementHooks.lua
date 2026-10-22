-- WoWUkraine: досягнення (achievements) — назва і опис у вікні досягнень.
-- Перемикач «Світ та інше → Досягнення» (achievements). Типово УВІМКНЕНО.
-- Shift тимчасово показує оригінал.
--
-- Нашу базу індексовано за ID (ns.achievements[id] = {title, desc}). Щоб НЕ
-- блимало англійською, підміняємо СИНХРОННО в тих самих викликах, де Blizzard
-- заповнює кнопки (хук per-button показу + хук оновлення списку при гортанні).
-- Тікер лишений тільки як рідкісна підстраховка. Підміна — лише видимий текст
-- (SetText), без замін API — без taint.

local _, ns = ...

local function Active()
    return ns.IsEnabled("achievements") and not ns.ShowOriginal()
end

-- Krowi's Achievement Filter замінює вікно досягнень власним. Наш ЗАГАЛЬНИЙ віконний
-- обхід (Walk/WalkChrome через тікер 0.1с) при цьому лазить у Krowi-піддерево й накидає
-- UA, а Krowi своїм циклом вертає EN → видима боротьба щодесятих секунди. Тож коли Krowi
-- присутній, загальний віконний шлях СТОЇТЬ ОСТОРОНЬ: Krowi-вікно обслуговує ВИКЛЮЧНО
-- гейтований AchievementKrowiHooks (у джерелі, у тому ж кадрі, без тікера). Якщо його
-- перемикач вимкнено — Krowi лишається англійським, і жодної боротьби. (Тости/алерти
-- досягнень Krowi НЕ замінює — вони йдуть окремим шляхом і тут не зачіпаються.)
local function KrowiPresent()
    return _G.KrowiAF_AchievementButtonMixin ~= nil
        or (C_AddOns and C_AddOns.IsAddOnLoaded and C_AddOns.IsAddOnLoaded("Krowi_AchievementFilter"))
end

local LABEL_FIELDS = { "label", "Label", "Name", "name" }
-- Опис показується в РІЗНИХ написах залежно від стану рядка (зміряно /fstack):
-- .Description — коли ачівка ЗГОРНУТА; .HiddenDescription — коли РОЗГОРНУТА.
-- Тому перекладаємо ВСІ наявні, а не лише перший.
local DESC_FIELDS = { "description", "Description", "DescriptionText", "HiddenDescription" }

local function FirstFS(button, fields)
    for _, f in ipairs(fields) do
        local fs = button[f]
        if type(fs) == "table" and fs.GetText and fs.SetText then
            return fs
        end
    end
end

-- Закріпити переклад на самому FontString. Розгортання ачівки повертає опис
-- англійською повз наш хук (інколи навіть не через ScrollBox:Update). Тож вішаємо
-- post-hook на SetText цього напису: щойно його ставлять РІВНО тим англійським
-- рядком, що ми переклали, — миттєво повертаємо українську в тому ж кадрі.
-- Точний збіг англійського захищає від хибних замін при перевикористанні рядка
-- (пул ScrollBox). Прапорець wuBusy глушить рекурсію; Active() поважає Shift/опцію.
local function Pin(fs, en, ua)
    if not fs or en == nil or ua == nil then return end
    fs.wuEN, fs.wuUA = en, ua
    if not fs.wuPinned then
        fs.wuPinned = true
        local function guard(self)
            if self.wuBusy or self.wuUA == nil or not Active() then return end
            local cur = ns.SafeText(self:GetText())
            if cur ~= nil and cur == self.wuEN then
                self.wuBusy = true
                self:SetText(self.wuUA)
                self.wuBusy = false
            end
        end
        hooksecurefunc(fs, "SetText", guard)
        if type(fs.SetFormattedText) == "function" then
            hooksecurefunc(fs, "SetFormattedText", guard)
        end
    end
end

local function TranslateButton(button, explicitID)
    if not button then return end
    local id = explicitID or button.id
    if type(id) ~= "number" then return end
    if not Active() then return end
    local a = ns.achievements and ns.achievements[id]
    if not a then return end

    local label = FirstFS(button, LABEL_FIELDS)
    if a.title and label then
        -- Прибрати обрізання «...»: знімаємо обмеження ширини, щоб показувалась
        -- ПОВНА назва (місця в рядку вдосталь). Застосовуємо щоразу — Blizzard
        -- знов вужчає рядок при гортанні/оновленні.
        -- Ширину чіпаємо ЛИШЕ поза ScrollBox: усередині нього зміна розміру з
        -- незахищеного коду тейнтить рахунок прокрутки, і Blizzard падає на
        -- порівнянні secret-числа в MathUtil [[bagsearch-setmatches-taint]].
        if not (ns.InScrollBox and ns.InScrollBox(label)) then
            pcall(label.SetWidth, label, 0)
            pcall(label.SetWordWrap, label, false)
        end
        local en = ns.SafeText(label:GetText())
        if en and en ~= a.title then
            local ua = ns.ApplyNames(a.title) -- опція «оригінальні імена»
            -- Remember має отримати ПОКАЗАНИЙ рядок (ua після ApplyNames), НЕ сирий a.title:
            -- з names.original «Омніум Сонстрайдерів»→«Омніум Sunstrider», тож cur==p.ua у
            -- Shift-своп збігається лише коли зберігаємо ua [[shift-toggle-needs-displayed-text]].
            ns.Remember(label, en, ua, nil, "achievements")
            label:SetText(ua)
            Pin(label, en, ua)
        end
    end
    if a.desc then
        for _, f in ipairs(DESC_FIELDS) do
            local desc = button[f]
            if type(desc) == "table" and desc.GetText and desc.SetText then
                local en = ns.SafeText(desc:GetText())
                if en and en ~= a.desc then
                    local ua = ns.ApplyNames(a.desc) -- опція «оригінальні імена»
                    ns.Remember(desc, en, ua, nil, "achievements") -- ПОКАЗАНИЙ ua, не сирий a.desc (див. вище)
                    desc:SetText(ua)
                    Pin(desc, en, ua)
                end
            end
        end
    end
end

-- Обхід піддерева вікна: будь-який фрейм із числовим .id — кандидат-кнопка.
local function Walk(frame, depth)
    if ns.IsTooltipFrame(frame) then return  end
    if not frame or depth > 7 then return end
    if type(frame.id) == "number" then pcall(TranslateButton, frame) end
    if frame.GetChildren then
        for _, child in ipairs(ns.Children(frame)) do
            Walk(child, depth + 1)
        end
    end
end

-- ── ХРОМ ІНТЕРФЕЙСУ вікна досягнень: заголовки, назви категорій, вкладки.
-- Скоуповано лише в межах AchievementFrame, тож інших вікон не зачіпає.
-- Підміна за точним збігом тексту + реєстрація для Shift.
local UI_CHROME = {
    ["Recent Achievements"] = "Останні досягнення",
    ["Progress Overview"] = "Зведення прогресу",
    ["Achievements Earned"] = "Здобуто досягнень",
    ["Summary"] = "Огляд",
    ["General"] = "Загальне",
    ["Characters"] = "Персонажі",
    ["Quests"] = "Завдання",
    ["Exploration"] = "Дослідження",
    ["Housing"] = "Житло",
    ["Delves"] = "Глибини",
    ["Player vs. Player"] = "Гравець проти гравця",
    ["Dungeons & Raids"] = "Підземелля і рейди",
    ["Professions"] = "Професії",
    ["Reputation"] = "Репутація",
    ["World Events"] = "Світові події",
    ["Pet Battles"] = "Бої улюбленців",
    ["Collections"] = "Колекції",
    ["Expansion Features"] = "Можливості доповнень",
    ["Feats of Strength"] = "Подвиги сили",
    ["Guild Feats of Strength"] = "Подвиги сили гільдії",
    ["Legacy"] = "Спадщина",
    ["Achievements"] = "Досягнення",
    ["Guild"] = "Гільдія",
    ["Statistics"] = "Статистика",
    ["Search"] = "Пошук",
}
-- Спільне ЄДИНЕ джерело назв категорій/хрому — використовує й AchievementKrowiHooks
-- (щоб Krowi-дерево категорій перекладалось тим самим словником, без розходжень).
-- Кастомні вкладки Krowi (Expansions/Events/Specials) тут НЕ додаємо навмисно —
-- вони специфічні для Krowi й перекладаються лише під власним (гейтованим) перемикачем.
ns.achievementChrome = UI_CHROME

local function TranslateChromeFS(fs)
    if not fs or type(fs.GetText) ~= "function" then return end
    local en = ns.SafeText(fs:GetText())
    -- Назви доповнень (категорії-підгрупи списку ачівок: The War Within, Опівніч…)
    -- беремо з ЄДИНОГО канон-словника ns.ejStrings (JourneysHooks), щоб не дублювати
    -- й не розходитись. Власний UI_CHROME лишається для не-експансійних рядків.
    -- ns.achievementCategories — ЄДИНА база лівого списку категорій (154 назви з
    -- DB2 Achievement_Category). Раніше тут був лише жорсткий UI_CHROME на ~18
    -- рядків, тому головні категорії були українською, а підкатегорії
    -- («Argent Tournament», «Tol Barad», «Torghast») лишались англійськими.
    local ua = en and (UI_CHROME[en]
                       or (ns.achievementCategories and ns.achievementCategories[en])
                       or (ns.ejStrings and ns.ejStrings[en]))
    if ua then
        ns.Remember(fs, en, ua, nil, "achievements")
        fs:SetText(ua)
    end
end

local function WalkChrome(frame, depth)
    if ns.IsTooltipFrame(frame) then return  end
    if not frame or depth > 8 then return end
    if frame.GetRegions then
        for _, r in ipairs(ns.Regions(frame)) do
            if r.IsObjectType and r:IsObjectType("FontString") then
                TranslateChromeFS(r)
            end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do
            WalkChrome(c, depth + 1)
        end
    end
end

local function ApplyAll()
    if not Active() or KrowiPresent() then return end
    local f = _G.AchievementFrame
    if f and f:IsShown() then
        pcall(Walk, f, 1)
        pcall(WalkChrome, f, 1)
    end
end

-- ── Синхронні хуки: ставимо на всі наявні глобальні функції показу/оновлення.
-- hooksecurefunc виконує наш код ОДРАЗУ після Blizzard, у тому ж кадрі —
-- англійська не встигає відмалюватися.
local CANDIDATES = {
    "AchievementButton_DisplayAchievement", -- per-button (ідеально: без блимання)
    "AchievementFrameAchievements_Update",  -- оновлення списку при гортанні
    "AchievementFrameSummary_Update",       -- вкладка «Огляд»
    -- ↓ додано при відмові від тікера-страховки: точки, через які вікно
    -- перемальовується при перемиканні вкладок/категорій, пошуку й порівнянні.
    -- Кожну беремо ЛИШЕ якщо вона є в цьому клієнті (перевірка типу нижче),
    -- тож зайві назви шкоди не роблять.
    "AchievementFrame_UpdateTabs",
    "AchievementFrame_ShowSubFrame",
    "AchievementFrame_SelectAchievement",
    "AchievementFrameCategories_Update",
    "AchievementFrameStats_Update",
    "AchievementFrameComparison_Update",
    "AchievementFrameSearchBox_OnTextChanged",
    "AchievementFrameCategories_SelectButton",
}

local hooked = false
local function InstallHooks()
    if hooked then return end
    local found = {}
    for _, name in ipairs(CANDIDATES) do
        if type(_G[name]) == "function" then
            found[#found + 1] = name
            if name == "AchievementButton_DisplayAchievement" then
                hooksecurefunc(name, function(button)
                    pcall(TranslateButton, button)
                end)
            else
                hooksecurefunc(name, function()
                    ApplyAll()
                end)
            end
        end
    end
    -- Алерт-ТОСТ досягнення (popup при здобутті) — зміряно /fstack: AchievementAlertFrame
    -- із FontString .Name; SetUp-функція передає achievementID → беремо укр. назву з
    -- ns.achievements[id].title. hooksecurefunc (пост-виклик) override-ить англ. у тому ж кадрі.
    for _, name in ipairs({ "AchievementAlertFrame_SetUp", "CriteriaAlertFrame_SetUp" }) do
        if type(_G[name]) == "function" then
            hooksecurefunc(name, function(frame, achievementID)
                if not Active() then return end
                local a = achievementID and ns.achievements and ns.achievements[achievementID]
                local fs = frame and frame.Name
                if a and a.title and fs and type(fs.GetText) == "function" then
                    local en = ns.SafeText(fs:GetText())
                    local ua = ns.ApplyNames and ns.ApplyNames(a.title) or a.title
                    if ua and en ~= ua then
                        if ns.Remember then ns.Remember(fs, en, ua, nil, "achievements") end
                        fs:SetText(ua)
                    end
                end
            end)
            found[#found + 1] = name
        end
    end
    ns.Diag("ачів-хуки встановлено: " .. (table.concat(found, ",") or "—"))
    hooked = true
end

-- ── Хуки ScrollBox вікна досягнень (зміряно через /fstack: і список ачівок, і
-- список категорій — модерні ScrollBox). Callback OnInitializedFrame
-- спрацьовує СИНХРОННО при заповненні кожного рядка → підміна в тому ж кадрі,
-- англійська не встигає відмалюватись (нуль блимання при зміні категорій).
-- Кандидати — кілька шляхів (список ачівок + список категорій); чіпляємо ті,
-- що існують і мають RegisterCallback. Що зачепилось — пишемо в db.diag.
local SCROLLBOX_PATHS = {
    "AchievementFrameAchievements.ScrollBox", -- правий список ачівок
    "AchievementFrameCategories.ScrollBox",   -- лівий список категорій
    "AchievementFrameCategories",             -- (на випадок, якщо це сам ScrollBox)
}

local function Resolve(path)
    local obj = _G
    for key in path:gmatch("[^.]+") do
        if type(obj) ~= "table" then return nil end
        obj = obj[key]
    end
    return obj
end

-- Дістати achievementID рядка. У Midnight стара функція, що ставила .id, зникла,
-- тож пробуємо ще й дані елемента ScrollBox-а (GetElementData).
local function ResolveID(frame)
    if type(frame.id) == "number" then return frame.id end
    if frame.GetElementData then
        local ok, data = pcall(frame.GetElementData, frame)
        if ok and data then
            if type(data) == "number" then return data end
            if type(data) == "table" then
                return data.id or data.achievementID or data.achievementId
            end
        end
    end
end

-- Синхронний переклад одного рядка списку: ачівка (за id) + хром (назва категорії).
local idProbed = false
local function TranslateRow(frame)
    if not Active() or type(frame) ~= "table" then return end
    local id = ResolveID(frame)
    if type(id) == "number" then
        pcall(TranslateButton, frame, id)
    elseif not idProbed and frame.GetElementData then
        -- одноразовий зонд: рядок схожий на ачівку, але id не знайдено — лог куди дивитись далі
        idProbed = true
        local ok, data = pcall(frame.GetElementData, frame)
        ns.Diag("ачів-рядок БЕЗ id: GED=" .. tostring(ok) .. " тип=" .. type(data)
            .. (type(data) == "table" and (" k1=" .. tostring(next(data))) or ""))
    end
    pcall(WalkChrome, frame, 1) -- назва категорії / написи рядка — у тому ж кадрі
end

-- Переклад УСІХ видимих рядків ScrollBox-а в одному кадрі.
local function TranslateAllFrames(sb)
    if not Active() then return end
    if sb.ForEachFrame then
        sb:ForEachFrame(TranslateRow)
    elseif sb.GetFrames then
        for _, f in ipairs(sb:GetFrames()) do TranslateRow(f) end
    end
end

local hookedBoxes = {}
local hookedUpdate = {}
local function HookScrollBox()
    local evt = _G.ScrollBoxListViewMixin and _G.ScrollBoxListViewMixin.Event
    local ev = evt and evt.OnInitializedFrame
    for _, path in ipairs(SCROLLBOX_PATHS) do
        local sb = Resolve(path)
        if sb then
            -- (1) OnInitializedFrame — підстраховка при першому створенні рядка.
            if ev and not hookedBoxes[path] and type(sb.RegisterCallback) == "function" then
                local ok = pcall(function()
                    sb:RegisterCallback(ev, function(_, frame) TranslateRow(frame) end, sb)
                end)
                if ok then
                    hookedBoxes[path] = true
                    ns.Diag("ачів-ScrollBox(init) зачеплено: " .. path)
                end
            end
            -- (2) ГОЛОВНЕ: метод Update — стріляє синхронно при кожному показі/
            -- гортанні/зміні категорії/розгортанні. Глобалок-функцій у Midnight
            -- більше нема (DA/AU = nil), тож саме це прибирає блимання.
            if not hookedUpdate[path] and type(sb.Update) == "function" then
                local ok = pcall(hooksecurefunc, sb, "Update", function(self)
                    TranslateAllFrames(self)
                end)
                if ok then
                    hookedUpdate[path] = true
                    ns.Diag("ачів-ScrollBox(Update) зачеплено: " .. path)
                end
            end
        end
    end
end

-- ВІДМОВА ВІД ТІКЕРА-СТРАХОВКИ (було: NewTicker 0.1с, поки вікно відкрите).
-- Перевірено тестером: без тікера вигляд вікна НЕ змінився — отже він нічого не
-- тримав, лише молотив 10 разів на секунду. Замість нього:
--   • розширено список джерельних хуків (вкладки/категорії/пошук/порівняння);
--   • на подіях, де вміст ще може дозавантажитись, — КОРОТКИЙ САМОГАСНИЙ сплеск.
-- Якщо виявиться неперехоплений шлях — додаємо джерельний хук у CANDIDATES,
-- а не повертаємо цикл.
local burstPending = false
local function Burst()
    if burstPending or KrowiPresent() then return end
    burstPending = true
    HookScrollBox()   -- панель могла створитись лише тепер
    ApplyAll()
    if C_Timer and C_Timer.After then
        C_Timer.After(0.05, ApplyAll)
        C_Timer.After(0.25, ApplyAll)
        C_Timer.After(0.60, function() ApplyAll(); burstPending = false end)
    else
        burstPending = false
    end
end

local function StartWatching()
    local f = _G.AchievementFrame
    if not f then return end
    InstallHooks()
    HookScrollBox()
    f:HookScript("OnShow", Burst)
    for i = 1, 5 do        -- вкладки вікна інколи оминають глобальні *_Update
        local tab = _G["AchievementFrameTab" .. i]
        if tab and tab.HookScript then tab:HookScript("OnClick", Burst) end
    end
    if f:IsShown() then Burst() end
end

local ev = CreateFrame("Frame")
ev:RegisterEvent("ADDON_LOADED")
ev:SetScript("OnEvent", function(self, _, name)
    if name == "Blizzard_AchievementUI" then
        StartWatching()
        self:UnregisterEvent("ADDON_LOADED")
    end
end)
if _G.AchievementFrame then StartWatching() end

-- ── ГЕНЕРИЧНИЙ хук АЛЕРТ-ТОСТІВ. Midnight додав нові тост-сабсистеми (напр. фрейм
-- з атласом housing-item-toast для ачівок професій) — їх НЕ покривають стандартні
-- AchievementAlertFrame_SetUp/CriteriaAlertFrame_SetUp. Тому обгортаємо setUpFunction
-- КОЖНОГО зареєстрованого алерт-сабсистему (AlertFrame.alertFrameSubSystems): після
-- оригіналу перекладаємо frame.Name за ID-аргументом. Display-only (лише SetText на
-- .Name тоста, не secure-фрейм) → без taint. Ідемпотентно (en≠ua), поважає Shift/опцію.
-- itemID для лут-тоста: тост передає item-ЛІНК (рядок) або itemID; також з полів фрейму.
-- НЕ беремо «перший числовий вараг» — у лута це кількість, не ID (ns.items[1] = хибний).
local function ResolveAlertItemID(frame, ...)
    if C_Item and C_Item.GetItemInfoInstant then
        for i = 1, select("#", ...) do
            local v = select(i, ...)
            if type(v) == "string" then
                local ok, iid = pcall(C_Item.GetItemInfoInstant, v)
                if ok and iid then return iid end
            end
        end
        local link = frame and (frame.itemLink
            or (frame.elementData and (frame.elementData.itemLink or frame.elementData.hyperlink)))
        if link then
            local ok, iid = pcall(C_Item.GetItemInfoInstant, link)
            if ok and iid then return iid end
        end
    end
    if frame and type(frame.itemID) == "number" then return frame.itemID end
end

-- Переклад НАПИСУ-ЗАГОЛОВКА тоста («You received» / «Achievement Progress» /
-- «Achievement Earned» / «Recipe Learned»…) через ns.uiStrings (globalStrings) — walk по
-- FontString-регіонах фрейму, окрім самої назви (nameFS). SafeText-захист (secret-рядки).
local function TranslateAlertChrome(frame, depth, nameFS)
    if ns.IsTooltipFrame(frame) then return  end
    if not frame or (depth or 0) > 4 or not ns.uiStrings then return end
    if frame.GetRegions then
        for _, r in ipairs(ns.Regions(frame)) do
            if r ~= nameFS and r.IsObjectType and r:IsObjectType("FontString")
                and r.GetText and r.SetText then
                local en = ns.SafeText(r:GetText())
                if en and not ns.HasCyrillic(en) then
                    local ua = ns.uiStrings[en]
                    if ua and en ~= ua then
                        if ns.Remember then ns.Remember(r, en, ua, nil, "achievements") end
                        r:SetText(ua)
                    end
                end
            end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do
            TranslateAlertChrome(c, (depth or 0) + 1, nameFS)
        end
    end
end

-- ТИП тоста зі шаблону підсистеми / імені фрейму (стабільно між патчами). Кожен тип
-- передає СВІЙ вид ID (mountID / achievementID / recipeSpellID / itemID / perksActivityID),
-- і ці простори ID ВІЛЬНО збігаються (mount 2818 == item 2818; perks 645 == spell 645).
-- Тому шукаємо переклад ЛИШЕ в таблиці свого типу — жодного перебору, жодних колізій.
local function ClassifyKind(s)
    if type(s) ~= "string" then return nil end
    if s:find("Mount") then return "mount" end
    if s:find("Recipe") then return "recipe" end
    if s:find("Achievement") or s:find("Criteria") then return "achievement" end
    if s:find("Perks") or s:find("Activity") or s:find("MonthlyActivit") or s:find("TravelersLog") then return "perks" end
    if s:find("Toy") or s:find("Loot") then return "item" end
    if s:find("Pet") then return "pet" end
    return nil
end

local function TranslateAlertName(frame, ...)
    if type(frame) ~= "table" then return end
    -- назва тоста: .Name (ачівка/рецепт) або .ItemName (Midnight лут-тост, ItemDisplay)
    local fs = frame.Name or frame.ItemName
    -- ЗАГОЛОВОК (You received / Achievement Progress …) — завжди через ns.uiStrings
    if Active() then pcall(TranslateAlertChrome, frame, 0, fs) end
    if not (fs and fs.GetText and fs.SetText) then return end
    local id, ua
    if frame.ItemName and fs == frame.ItemName then
        -- ЛУТ-тост: назва = предмет за item-лінком/itemID (НЕ числовий achievement-арг)
        id = ResolveAlertItemID(frame, ...)
        if id and ns.items then
            local e = ns.items[id]
            ua = (type(e) == "table" and e.name) or (type(e) == "string" and e) or nil
        end
    else
        -- .Name: тип тоста ВІДОМИЙ (з підсистеми/імені) → шукаємо в ОДНІЙ таблиці за типом.
        for i = 1, select("#", ...) do
            local v = select(i, ...)
            if type(v) == "number" then id = v; break end
        end
        if not id and type(frame.id) == "number" then id = frame.id end
        local en0 = fs.GetText and ns.SafeText(fs:GetText())
        local kind = frame.__wuKind or (frame.GetName and ClassifyKind(frame:GetName()))
        -- 1) EN-ТЕКСТ (специфічний, без колізій): активності Торгового поста тощо
        if en0 and not ns.HasCyrillic(en0) and ns.perksActivity then
            ua = ns.perksActivity[en0]
        end
        -- 2) числовий ID → ЛИШЕ таблиця свого типу (жодного перебору → жодних колізій)
        if not ua and type(id) == "number" then
            if kind == "mount" then
                local m = ns.mounts and ns.mounts[id]
                if type(m) == "table" then ua = m.n end
            elseif kind == "recipe" then
                local s = ns.spells and ns.spells[id]
                ua = type(s) == "string" and s or nil
            elseif kind == "item" then
                local e = ns.items and ns.items[id]
                ua = (type(e) == "table" and e.name) or (type(e) == "string" and e) or nil
            elseif kind == "achievement" then
                -- ЛИШЕ явна ачівко-підсистема. НЕ чіпаємо kind==nil за числовим id:
                -- тост колекції «You Collected» (пет/маунт/предмет/зовнішність) не
                -- класифікується, а його id ВІЛЬНО збігається з achievementID → давало
                -- хибну назву ачівки замість імені пета (напр. пет 61960 → ачівка
                -- «Скарби Лісу Вічної Пісні»). Такі йдуть у name-fallback нижче.
                local a = ns.achievements and ns.achievements[id]
                if a then ua = a.title end
            end
            -- kind "perks"/"pet" → числовий ID НЕ використовуємо (perksActivityID/speciesID
            -- колізують); переклад лише за EN-текстом вище / у fallback нижче.
        end
    end
    local en = ns.SafeText(fs:GetText())
    -- FALLBACK ЗА НАЗВОЮ: Perks/Traveler's Log активності мають perksActivityID
    -- (не achievement/spell ID), тож ID-пошук вище не спрацьовує. Беремо переклад
    -- за самим EN-текстом тоста (display-only, без тейнту). Напр. "Complete 10 World
    -- Quests" є в ns.uiTooltips. Колізії малоймовірні (специфічні рядки активностей).
    if not ua and en and not ns.HasCyrillic(en) then
        -- за ІМЕНЕМ (точний EN-збіг — без колізій ID): колекційні тости пета/маунта
        ua = (ns.petsByName and ns.petsByName[en])
            or (ns.mountsByName and ns.mountsByName[en])
            or (ns.uiTooltips and ns.uiTooltips[en])
            or (ns.perksActivity and ns.perksActivity[en]) or nil
    end
    -- ДІАГНОСТИКА: кожен тост → db.diag (текст+id+знайдений переклад), щоб бачити,
    -- ЧОМУ не переклалось (id=nil → не той аргумент; ua=nil → нема в базі).
    if ns.GetCaptureDB and en and not ns.HasCyrillic(en) then
        pcall(function()
            local db = ns.GetCaptureDB()
            db.diag = db.diag or {}
            db.diag["alert |" .. tostring(en) .. "| id=" .. tostring(id) .. " ua=" .. tostring(ua)] = true
        end)
    end
    if not ua or not Active() then return end
    if en and en ~= ua then
        if ns.Remember then ns.Remember(fs, en, ua, nil, "achievements") end
        fs:SetText(ns.ApplyNames and ns.ApplyNames(ua) or ua)
    end
end

local function WrapAlertSubsystems()
    local af = _G.AlertFrame
    if not (af and af.alertFrameSubSystems) then return end
    for _, sub in ipairs(af.alertFrameSubSystems) do
        if type(sub) == "table" and type(sub.setUpFunction) == "function" and not sub.__wuWrapped then
            sub.__wuWrapped = true
            -- ТИП підсистеми зі шаблону пулу (стабільний між патчами) → маршрутизація
            -- пошуку за типом у TranslateAlertName (mount/achievement/recipe/item/perks).
            local tmpl = sub.alertFramePool and sub.alertFramePool.frameTemplate
            local kind = ClassifyKind(tmpl)
            local orig = sub.setUpFunction
            sub.setUpFunction = function(frame, ...)
                orig(frame, ...)
                if kind and type(frame) == "table" then frame.__wuKind = kind end
                pcall(TranslateAlertName, frame, ...)  -- (...) → 1-й = ID свого ТИПУ
            end
        end
    end
end

-- Сабсистеми реєструються ліниво (housing/перки-аддони вантажаться окремо) — кілька
-- спроб після входу + на кожен ADDON_LOADED, поки не зачепимо нові.
local awf = CreateFrame("Frame")
awf:RegisterEvent("PLAYER_LOGIN")
awf:RegisterEvent("ADDON_LOADED")
awf:SetScript("OnEvent", function()
    pcall(WrapAlertSubsystems)
    if C_Timer then
        C_Timer.After(1, function() pcall(WrapAlertSubsystems) end)
        C_Timer.After(5, function() pcall(WrapAlertSubsystems) end)
    end
end)

-- ТУЛТІП ачівки (наведення на лінк у чаті, попап «Achievement earned by …»):
-- це ОКРЕМИЙ шлях від вікна досягнень — хуки вище його не ловлять, тому ачівка
-- в тултіпі лишалась англійською, хоч переклад Є в базі. Ловимо через
-- TooltipDataProcessor (тип Achievement): беремо EN назву/опис із GetAchievementInfo
-- і підміняємо рядки на наш UA (ns.achievements[id] = {title, desc}). Без тейнту.
if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall
   and Enum and Enum.TooltipDataType and Enum.TooltipDataType.Achievement then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Achievement, function(tooltip, data)
        if not Active() then return end
        local id = data and data.id
        local a = id and ns.achievements and ns.achievements[id]
        if not a or not (tooltip and tooltip.NumLines and tooltip.GetName) then return end
        local enName, enDesc
        pcall(function()
            local _, n, _, _, _, _, _, d = GetAchievementInfo(id) -- 2=name, 8=description
            enName, enDesc = n, d
        end)
        local tname = tooltip:GetName()
        if not tname then return end
        for i = 1, tooltip:NumLines() do
            local fs = _G[tname .. "TextLeft" .. i]
            local t = fs and ns.SafeText(fs:GetText())
            if t then
                if a.title and enName and t == enName then
                    local ua = ns.ApplyNames and ns.ApplyNames(a.title) or a.title
                    fs:SetText(ua)
                    if ns.Remember then ns.Remember(fs, enName, ua, nil, "achievements") end
                elseif a.desc and enDesc and t == enDesc then
                    local ua = ns.ApplyNames and ns.ApplyNames(a.desc) or a.desc
                    fs:SetText(ua)
                    if ns.Remember then ns.Remember(fs, enDesc, ua, nil, "achievements") end
                end
            end
        end
    end)
end

-- Shift «показати оригінал» — централізовано в Core (ns.ToggleOriginal).
