-- WoWUkraine: переклад предметів у тултіпах.
-- Перемикачі: «Предмети → Назви предметів» (items.name, типово ВИМКНЕНО —
-- назви в гайдах/аукціоні англійські) і «Художні описи» (items.flavor,
-- типово УВІМКНЕНО — флейвор сюжетний, на механіку не впливає).

local _, ns = ...

local function GetLine(tooltip, i)
    if tooltip.GetLeftLine then
        local line = tooltip:GetLeftLine(i)
        if line then return line end
    end
    local name = tooltip.GetName and tooltip:GetName()
    return name and _G[name .. "TextLeft" .. i] or nil
end

-- ЕФЕКТИ предмета (рядки Equip:/Use:/Chance on hit:) — це описи заклять,
-- прив'язаних через ItemEffect. За itemID беремо spellID ефектів (ns.itemEffects)
-- і рендеримо їхні описи тим самим рушієм (ns.RenderDescription) з живими
-- числами, підміняючи рядок. Префікс Equip:/Use: відрізаємо й лишаємо як є.
-- РОБАСТНИЙ переклад ефектів: НЕ зіставляємо рядок тултіпа з шаблоном (крихко
-- через префікси/хвости/кольори/переноси). Натомість беремо відрендерений EN
-- прямо з API (той самий текст, що в тултіпі), перекладаємо його, і знаходимо
-- цей текст у рядку ЯК ПІДРЯДОК — заміняючи лише його, а «Equip:»/«(Cooldown)»/
-- кольори лишаються самі. Один універсальний шлях для всіх предметів.
-- Переклад ефектів: зіставляємо РЯДОК ТУЛТІПА з шаблоном опису. Токени ($s1
-- тощо) ловлять числа ПРЯМО З ТУЛТІПА (вже відмасштабовані під рівень предмета),
-- тож масштаб коректний. (GetSpellDescription НЕ годиться — дає базові числа.)
-- Обробляємо формати: префікс Equip:/Use:, провідний пробіл, хвіст (Cooldown),
-- переноси (нормалізуються в MatchAndFill).
local function TranslateItemEffects(tooltip, itemID)
    local effs = ns.itemEffects and ns.itemEffects[itemID]
    if not effs or not ns.RenderDescription then return false end
    local PREFIXES = { ITEM_SPELL_TRIGGER_ONEQUIP, ITEM_SPELL_TRIGGER_ONUSE,
                       ITEM_SPELL_TRIGGER_ONPROC, ITEM_SPELL_TRIGGER_ONLEARN }
    local changed = false
    for i = 2, tooltip:NumLines() do
        local line = GetLine(tooltip, i)
        local raw = ns.SafeText(line and line:GetText())
        if raw and not (ns.HasCyrillic and ns.HasCyrillic(raw)) then
            local rendered = raw:gsub("\r\n", "\n")
            local core = rendered
            for _, p in ipairs(PREFIXES) do
                if p and rendered:sub(1, #p) == p then core = rendered:sub(#p + 1); break end
            end
            core = core:gsub("^%s+", "")
            local head = rendered:sub(1, #rendered - #core)
            local tail = ""
            local body, cd = core:match("^(.-)(%s*%([^()]*[Cc]ooldown[^()]*%))$")
            if body and cd then core, tail = body, cd end
            for _, sid in ipairs(effs) do
                local ua = ns.RenderDescription(sid, core)
                if ua then
                    local r, g, b = line:GetTextColor()
                    line:SetText(head .. ua .. tail)
                    if r then line:SetTextColor(r, g, b) end
                    ns.Remember(line, raw, head .. ua .. tail, nil, "items.effects")
                    changed = true
                    break
                end
            end
        end
    end
    return changed
end

-- ── Інформаційні рядки предмета (тип броні, слот, прив'язка, статистика).
-- ЧИСЛА лишаємо ЯК Є (плейсхолдер), перекладаємо лише слово — стати в РОД. відмінку
-- («+37 Сили»). Колір зберігаємо, реєструємо для Shift. Один стандарт із рештою.
local ITEM_TT = {
    ["Soulbound"] = "Прив'язаний до душі",
    ["Binds when equipped"] = "Прив'язується при одяганні",
    ["Binds when picked up"] = "Прив'язується при підборі",
    ["Binds to account"] = "Прив'язується до акаунту",
    ["Binds to Battle.net account"] = "Прив'язується до акаунту Battle.net",
    ["Timewarped"] = "Позачасовий",
    ["Indestructible"] = "Незнищенний",
    ["Unique"] = "Унікальний", ["Unique-Equipped"] = "Унікальний-одягнений",
    ["Mythic"] = "Міфічний", ["Heroic"] = "Героїчний", ["Normal"] = "Звичайний",
    ["Mythic+"] = "Міфічний+", ["Raid Finder"] = "Пошук рейду",
    ["Warband"] = "Загін", ["Binds to Warband"] = "Прив'язується до загону",
    ["Binds to Warband until equipped"] = "Прив'язується до загону до одягання",
    ["Warbound"] = "Прив'язаний до загону",
    ["Warbound until equipped"] = "Прив'язаний до загону до одягання",
    ["This Item Begins a Quest"] = "Цей предмет розпочинає завдання",
    ["Cosmetic"] = "Косметичний", ["Crafting Reagent"] = "Реагент ремесла",
    ["Classic Crafting Reagent"] = "Реагент ремесла (Classic)",
    ["You haven't collected this appearance"] = "Ви ще не зібрали цей вигляд",
    ["You've collected this appearance"] = "Ви вже зібрали цей вигляд",
    -- типи зброї
    ["Sword"] = "Меч", ["Mace"] = "Булава", ["Axe"] = "Сокира", ["Dagger"] = "Кинджал",
    ["Staff"] = "Посох", ["Polearm"] = "Древкова зброя", ["Bow"] = "Лук",
    ["Gun"] = "Рушниця", ["Crossbow"] = "Арбалет", ["Wand"] = "Жезл",
    ["Fist Weapon"] = "Кулачна зброя", ["Shield"] = "Щит", ["Warglaive"] = "Бойова глефа",
    ["Thrown"] = "Метальна", ["Fishing Pole"] = "Вудка",
    ["Plate"] = "Латний", ["Mail"] = "Кольчужний",
    ["Leather"] = "Шкіряний", ["Cloth"] = "Тканинний",
    ["Head"] = "Голова", ["Neck"] = "Шия", ["Shoulder"] = "Плечі",
    -- Вкладка Образів уживає МНОЖИННІ форми слотів (Shoulders/Hands/Legs/Feet);
    -- Shoulders окремо, бо тут ≠ Shoulder (однина в тултіпі предмета).
    ["Shoulders"] = "Плечі", ["Wrists"] = "Зап'ястя", ["Fingers"] = "Пальці",
    ["Back"] = "Спина", ["Chest"] = "Груди", ["Shirt"] = "Сорочка",
    ["Tabard"] = "Гербова накидка", ["Wrist"] = "Зап'ястя",
    ["Hands"] = "Кисті", ["Waist"] = "Пояс", ["Legs"] = "Ноги",
    ["Feet"] = "Стопи", ["Finger"] = "Палець", ["Trinket"] = "Дрібничка",
    ["Main Hand"] = "Основна рука", ["Off Hand"] = "Друга рука",
    ["One-Hand"] = "Одноручна", ["Two-Hand"] = "Дворучна",
    ["Held In Off-hand"] = "Тримається в лівій руці", ["Ranged"] = "Дальня",
}
local STAT_GEN = {
    ["Strength"] = "Сили", ["Agility"] = "Спритності", ["Stamina"] = "Витривалості",
    ["Intellect"] = "Інтелекту", ["Critical Strike"] = "Критичного удару",
    ["Haste"] = "Швидкості", ["Mastery"] = "Майстерності",
    ["Versatility"] = "Універсальності", ["Speed"] = "Рухливості",
    ["Avoidance"] = "Уникнення", ["Leech"] = "Висмоктування",
}
local TRACK = {
    ["Explorer"] = "Дослідник", ["Adventurer"] = "Шукач пригод",
    ["Veteran"] = "Ветеран", ["Champion"] = "Чемпіон",
    ["Hero"] = "Герой", ["Myth"] = "Міф",
}

-- Слова, якими ВЛАСНЕ ItemHooks перекладає інфо-рядки тултіпа предмета (прив'язка,
-- слоти, типи, стати, треки). Загальний GameTooltip-хук (UIHooks) МУСИТЬ їх пропускати
-- на ITEM-тултіпі — інакше застосує СВІЙ (контекстний) uiTooltips-варіант ПОВЕРХ нашого
-- → флікер при Shift (напр. «Soulbound»: тут «Прив'язаний до душі», а uiTooltips має
-- «Прив'язано до душі»). Дані НЕ чіпаємо (uiTooltips контекстний: Back=Спина/Назад).
ns.itemTTWords = ns.itemTTWords or {}
for _, m in ipairs({ ITEM_TT, STAT_GEN, TRACK }) do
    for k in pairs(m) do ns.itemTTWords[k] = true end
end
-- Канонні значення слот/тип-слів для ЧУЖИХ тултіп-хуків: коли «голе» слот-слово
-- трапляється ПОЗА предметним тултіпом (кнопка слота в Образах показує «Back»),
-- перекласти його має САМЕ цей словник (Back=Спина), а не квест/меню-словники.
ns.itemTTMap = ns.itemTTMap or {}
for k, v in pairs(ITEM_TT) do ns.itemTTMap[k] = v end

-- НАДІЙНИЙ зйом кольор-кодів: |c + РІВНО 8 будь-яких символів (формат буває з
-- дивними байтами/пробілами, не лише hex — звідси «Timewarped»/«Mythic+» не
-- знімались) + іменовані |cn..: + |r.
local function stripColors(text)
    return (text:gsub("|c........", ""):gsub("|cn[%a_]+:", ""):gsub("|r", ""))
end

local function TranslateInfoLine(text)
    local ua = ITEM_TT[text]
    if ua then return ua end
    -- стати з числами (число лишаємо, навіть із комою «+1,435»); слово в род. відмінку
    local sign, num, stat = text:match("^([%+%-]?)([%d,]+)%s+(.+)$")
    if num and stat then
        if STAT_GEN[stat] then return sign .. num .. " " .. STAT_GEN[stat] end
        if stat == "Armor" then return num .. " Броні" end
    end
    local il = text:match("^Item Level%s+(%d+)$")
    if il then return "Рівень предмета " .. il end
    local d1, d2 = text:match("^Durability%s+(%d+)%s*/%s*(%d+)$")
    if d1 then return "Міцність " .. d1 .. " / " .. d2 end
    local rl = text:match("^Requires Level%s+(%d+)$")
    if rl then return "Потрібен рівень " .. rl end
    -- «Midnight Season 1» (EXPANSION_SEASON_NAME = "%s Season %d"): назву
    -- доповнення лишаємо, «Season»→«Сезон» (як у досягненнях «… Сезон 3»).
    local exp, sn = text:match("^(.+) Season (%d+)$")
    if exp then return exp .. " Сезон " .. sn end
    local tr, c, m = text:match("^Upgrade Level:%s+(%a+)%s+(%d+)/(%d+)$")
    if tr and TRACK[tr] then return "Рівень покращення: " .. TRACK[tr] .. " " .. c .. "/" .. m end
    -- зброя: «215 - 358 Damage», «1 Damage» (число/діапазон лишаємо)
    local dmg = text:match("^([%d,%s%-]+)%s+Damage$")
    if dmg then return (dmg:gsub("%s+$", "")) .. " Шкоди" end
    -- «Speed 2.60»
    local spd = text:match("^Speed%s+([%d.]+)$")
    if spd then return "Швидкість " .. spd end
    -- «(79.6 damage per second)»
    local dps = text:match("^%(([%d.]+) damage per second%)$")
    if dps then return "(" .. dps .. " шкоди за секунду)" end
    -- «Sell Price:» — інколи монети (|T-текстури) в ТОМУ Ж рядку після двокрапки,
    -- тож не анкоримо «$»: перекладаємо префікс, хвіст (монети/число) лишаємо.
    local spTail = text:match("^Sell Price:?%s*(.-)%s*$")
    if spTail ~= nil then
        return spTail ~= "" and ("Ціна продажу: " .. spTail) or "Ціна продажу:"
    end
    if text:match("^No sell price%s*$") then return "Не продається" end
    -- місткість сумок: «36 Slot Bag», «34 Slot Reagent Bag» (прикметник → без
    -- відмінювання «комірок»: «34-комірна торба»)
    local srb = text:match("^(%d+) Slot Reagent Bag$")
    if srb then return srb .. "-комірна торба реагентів" end
    local sb = text:match("^(%d+) Slot Bag$")
    if sb then return sb .. "-комірна торба" end
    -- підпис майстра «<Made by X>» (ім'я гравця лишаємо)
    local mb = text:match("^<Made by (.+)>$")
    if mb then return "<Виготовлено: " .. mb .. ">" end
    -- рядок-порівняння «- Indestructible» (блок «If you replace this item…»):
    -- провідний дефіс + ВІДОМА властивість зі словника (інші «- X» не чіпаємо).
    local dash, rest = text:match("^(%s*%-%s*)(.+)$")
    if rest and ITEM_TT[rest] then return dash .. ITEM_TT[rest] end
    -- запасний: зняти кольори й перевірити словник (Timewarped/Mythic+ у |c..|r).
    -- ЗБЕРІГАЄМО інлайн-колір: «|cFF00FF00Timewarped|r» зелений — без обгортки
    -- переклад став би білим (GetTextColor дає базовий колір рядка, не інлайн).
    local prefix = text:match("^(|c........)") or text:match("^(|cn[%a_]+:)")
    local s = stripColors(text):gsub("^%s+", ""):gsub("%s+$", "")
    if s ~= text and ITEM_TT[s] then
        if prefix then return prefix .. ITEM_TT[s] .. "|r" end
        return ITEM_TT[s]
    end
    return nil
end

local function TranslateInfoLines(tooltip)
    local name = tooltip.GetName and tooltip:GetName()
    if not name then return false end
    local changed = false
    for i = 1, tooltip:NumLines() do
        for _, side in ipairs({ "TextLeft", "TextRight" }) do
            local line = _G[name .. side .. i]
            local text = ns.SafeText(line and line:GetText())
            if text then
                local ua = TranslateInfoLine(text)
                if ua and ua ~= text then
                    local r, g, b = line:GetTextColor()
                    line:SetText(ua)
                    if r then line:SetTextColor(r, g, b) end
                    ns.Remember(line, text, ua, nil, "items.statsSlots")
                    changed = true
                elseif ns.debug and not ns.HasCyrillic(text) and text:find("%a")
                       and #text < 50 then
                    -- ДАМП У ФАЙЛ (надійніше за чат): сирий вигляд нерозпізнаного
                    -- рядка в SavedVariables. Наведи -> /reload -> надішли файл.
                    local db = ns.GetCaptureDB and ns.GetCaptureDB()
                    if db then
                        db.itemtt = db.itemtt or {}
                        local raw = text:gsub("|", "||")
                        if not db.itemtt[raw] then db.itemtt[raw] = (line:GetText() or "") end
                    end
                    if ns.Diag then ns.Diag("предмет-рядок: «" .. text:gsub("|", "||") .. "»") end
                end
            end
        end
    end
    -- «Sell Price:» — це НЕ рядок TextLeft, а префікс money-фрейму
    -- (GameTooltipMoneyFrameNPrefixText), тож цикл вище його не бачить. Обходимо окремо.
    for i = 1, 4 do
        local pf = _G[name .. "MoneyFrame" .. i .. "PrefixText"]
        local t = pf and ns.SafeText(pf:GetText())
        if t then
            local uat = TranslateInfoLine(t)
            if uat and uat ~= t then
                local r, g, b = pf:GetTextColor()
                pf:SetText(uat)
                if r then pf:SetTextColor(r, g, b) end
                ns.Remember(pf, t, uat, nil, "items.statsSlots")
                changed = true
            end
        end
    end
    return changed
end

-- Назви СЕТІВ предметів: рядок «SetName (2/8)» у тултіпі. База ns.itemSetsByName
-- (англ.назва -> укр). Зберігаємо хвіст «(x/y)» і колір.
local function TranslateSetLines(tooltip)
    if not ns.itemSetsByName then return false end
    local changed = false
    local isSet = false
    for i = 2, tooltip:NumLines() do
        local line = GetLine(tooltip, i)
        local text = ns.SafeText(line and line:GetText())
        if text then
            local base, tail = text:match("^(.-)%s*(%(%d+/%d+%))$")
            local key = base or text
            local ua = ns.itemSetsByName[key]
            if ua and not text:find(ua, 1, true) then
                local r, g, b = line:GetTextColor()
                local shown = tail and (ua .. " " .. tail) or ua
                line:SetText(shown)
                if r then line:SetTextColor(r, g, b) end
                ns.Remember(line, text, shown, nil, "items.name")
                changed = true
                isSet = true
            elseif base and tail then
                isSet = true -- рядок «(x/y)» → це сет-тултіп навіть якщо назва не в базі
            end
        end
    end
    -- СПИСОК сет-піс: під заголовком гра перелічує назви предметів сету (з відступом,
    -- сірі=невзуті/білі=взуті). Це НАЗВИ ПРЕДМЕТІВ — перекладаємо через ns.uiTooltips
    -- (byName, вирівняний до itemNames). Гейт isSet, щоб не чіпати звичайні тултіпи.
    -- Зберігаємо відступ і колір рядка.
    if isSet and ns.uiTooltips then
        -- Індекс uiTooltips БЕЗ префікса «(N) »: сет-БОНУСИ гра показує то з «(N) Set:…»
        -- (неактивний), то «Set:…» (активний) — захопили одне, а на екрані інше.
        if not ns.__uiTipNoCount then
            -- другий повний прохід по тому самому словнику, теж синхронно
            ns.Prof("індекс сет-бонусів (1 раз)", function()
                ns.__uiTipNoCount = {}
                for k, v in pairs(ns.uiTooltips) do
                    local nk = type(k) == "string" and k:match("^%s*%(%d+%)%s*(.+)$")
                    if nk then ns.__uiTipNoCount[nk] = (v:match("^%s*%(%d+%)%s*(.+)$") or v) end
                end
            end)
        end
        for i = 2, tooltip:NumLines() do
            local line = GetLine(tooltip, i)
            local text = ns.SafeText(line and line:GetText())
            if text and not (ns.HasCyrillic and ns.HasCyrillic(text)) then
                local ua = ns.uiTooltips[text] -- ключ може вже містити відступ (як захопився)
                if not ua then
                    local lead = text:match("^(%s*)") or ""
                    local core = text:gsub("^%s+", ""):gsub("%s+$", "")
                    -- назва сет-піс: ns.setPieces (byName з itemNames) — покриває сети,
                    -- яких нема в uiTooltips (напр. Occlusion of Void → Запона Порожнечі)
                    local u2 = ns.uiTooltips[core] or (ns.setPieces and ns.setPieces[core])
                    if u2 then ua = lead .. u2 end
                end
                if not ua then
                    -- бонус із/без «(N)»: зіставляємо тіло без префікса, повертаємо свій
                    local bare = text:match("^%s*%(%d+%)%s*(.+)$") or text:gsub("^%s+", ""):gsub("%s+$", "")
                    local u3 = ns.__uiTipNoCount[bare]
                    if u3 then
                        local pfx = text:match("^(%s*%(%d+%)%s*)") or (text:match("^(%s*)") or "")
                        ua = pfx .. u3
                    end
                end
                if not ua and ns.SetBonusTry then
                    -- СЕТ-БОНУС «(N) Set: <опис-шаблон>»: числа рендерить сервер, тож
                    -- опис зіставляємо шаблонним рушієм (SetBonusTry), «Set:»→«Набір:».
                    local lead, cnt, desc = text:match("^(%s*)(%(%d+%)%s*)Set:%s*(.+)$")
                    if not desc then lead, desc = text:match("^(%s*)Set:%s*(.+)$"); cnt = "" end
                    if desc then
                        local ub = ns.SetBonusTry(desc)
                        if ub then ua = (lead or "") .. (cnt or "") .. "Набір: " .. ub end
                    end
                end
                if ua and ua ~= text then
                    local r, g, b = line:GetTextColor()
                    line:SetText(ua)
                    if r then line:SetTextColor(r, g, b) end
                    ns.Remember(line, text, ua, nil, "items.name")
                    changed = true
                end
            end
        end
    end
    return changed
end

-- ЧАРИ предметів (SpellItemEnchantment): рядок чару в тултіпі (зелений) = назва
-- чару рівно як ns.enchants[англ.]. Точний збіг: named-чари (Crusader, Sharpened II,
-- Fiery Weapon, Omen of Clarity) збігаються 1:1. Чари з токенами «+$k1 Stat» гра
-- показує вже з числом («+15 Spритність»), тож вони сюди НЕ потрапляють (точний
-- lookup їх не знаходить) — це навмисно, без ризику хибного пере-матчу. Колір/Shift
-- зберігаємо, як усюди. Рядок 1 (назва предмета) пропускаємо.
local function TranslateEnchantLines(tooltip)
    if not ns.enchants then return false end
    local changed = false
    for i = 2, tooltip:NumLines() do
        local line = GetLine(tooltip, i)
        local text = ns.SafeText(line and line:GetText())
        if text and not (ns.HasCyrillic and ns.HasCyrillic(text)) then
            local ua = ns.enchants[text]
            if ua and ua ~= text then
                local r, g, b = line:GetTextColor()
                line:SetText(ua)
                if r then line:SetTextColor(r, g, b) end
                ns.Remember(line, text, ua, nil, "items.statsSlots")
                changed = true
            end
        end
    end
    return changed
end

-- СУФІКСИ предметів (ItemNameDescription): «Season 10», «Season 10 Elite» тощо гра
-- показує ОКРЕМИМ рядком тултіпа під назвою. Точний збіг з ns.itemSuffixes (як чари).
local function TranslateSuffixLines(tooltip)
    if not ns.itemSuffixes then return false end
    local changed = false
    for i = 2, tooltip:NumLines() do
        local line = GetLine(tooltip, i)
        local text = ns.SafeText(line and line:GetText())
        if text and not (ns.HasCyrillic and ns.HasCyrillic(text)) then
            local ua = ns.itemSuffixes[text]
            if ua and ua ~= text then
                local r, g, b = line:GetTextColor()
                line:SetText(ua)
                if r then line:SetTextColor(r, g, b) end
                ns.Remember(line, text, ua, nil, "items.statsSlots")
                changed = true
            end
        end
    end
    return changed
end

-- ⚠️ ТЕЙНТ-БАР'ЄР [[tooltip-widget-taint]]. Частина предметів 12.0 (делв-кеші/каталоги
-- на кшталт Gilded Stash, захищений контент) несе у тултіпі SECRET-значення. Будь-який
-- наш SetText/Show на ТАКОМУ тултіпі перезапускає layout із порівнянням secret-числа
-- (LayoutFrame:491) → тейнт сідає на СПІЛЬНИЙ GameTooltip ГЛОБАЛЬНО (до /reload) і
-- згодом форбідить захищені дії, які його торкаються: «ADDON_ACTION_FORBIDDEN:
-- UALL -> UseContainerItem()» при використанні предмета з торби, ClearWidgetSet на
-- кнопках дій тощо. Тому secret-тултіп НЕ чіпаємо взагалі (як вимкнено POI-тултіп):
-- SafeText уже дає nil на secret-РЯДКАХ, але тейнт іде від ГЕОМЕТРІЇ layout, не від
-- тексту — тож ловимо сам факт secret-значення (pcall на порівнянні падає лише на
-- secret) і виходимо ДО першого SetText, лишаючи цей один тултіп англійською.
local function TooltipHasSecret(tooltip)
    local name = tooltip.GetName and tooltip:GetName()
    if not name then return false end
    for i = 1, tooltip:NumLines() do
        for _, side in ipairs({ "TextLeft", "TextRight" }) do
            local fs = _G[name .. side .. i]
            if fs and fs.GetText then
                local okG, raw = pcall(fs.GetText, fs)
                if okG and raw ~= nil then
                    local ok = pcall(function() return raw == "" end)
                    if not ok then return true end -- secret-значення у рядку
                end
            end
        end
    end
    return false
end

local function TranslateItemTooltip(tooltip, data)
    if ns.ShowOriginal() then return end -- клавіша «показати оригінал»
    local itemID = data and data.id
    if not itemID then return end
    if TooltipHasSecret(tooltip) then return end -- тейнт-бар'єр (secret-геометрія)
    local changed = false

    -- [ДІАГНОСТИКА КЛЮЧА] дамп СИРИХ рядків тултіпа ключа ДО перекладу (бачимо, де
    -- зникло підземелля). Лише для Mythic Keystone (180653) або назви з «Keystone».
    -- ГЕЙТ not ns.PUBLIC: у публічній збірці GetCaptureDB повертає null-DB (allTrue-
    -- метатаблиця), тож читання db.keystone.lines дає true, а #true падало 74× у ключах
    -- (баг тестера на CurseForge-збірці). Діагностика dev-only — тестерам лишаємо.
    if not ns.PUBLIC then
        local l1 = ns.SafeText(GetLine(tooltip, 1) and GetLine(tooltip, 1):GetText())
        if itemID == 180653 or (l1 and l1:find("Keystone")) then
            local db = ns.GetCaptureDB and ns.GetCaptureDB()
            if db then
                db.keystone = { id = itemID, lines = {} }
                for i = 1, tooltip:NumLines() do
                    for _, side in ipairs({ "Left", "Right" }) do
                        local fs = _G[(tooltip:GetName() or "") .. "Text" .. side .. i]
                        local t = fs and fs:GetText()
                        if t and t ~= "" then
                            db.keystone.lines[#db.keystone.lines + 1] = side:sub(1, 1) .. i .. ": " .. t
                        end
                    end
                end
            end
        end
    end

    -- Ефекти Equip:/Use: і info-рядки (тип/слот/прив'язка/стати/ціна/Soulbound/
    -- Equipped) — ПІД СВОЇМИ перемикачами, НЕ під флейвором. Інакше «Художні описи»
    -- тягнули переклад статів/прив'язки/ціни в рандомі (баг тестера).
    if ns.IsEnabled("items.effects") then
        changed = TranslateItemEffects(tooltip, itemID) or changed
    end
    if ns.IsEnabled("items.statsSlots") then
        changed = TranslateInfoLines(tooltip) or changed
        changed = TranslateEnchantLines(tooltip) or changed
        changed = TranslateSuffixLines(tooltip) or changed
    end
    -- Назви сетів (під перемикачем «Назви предметів» — це теж назви).
    if ns.IsEnabled("items.name") then
        changed = TranslateSetLines(tooltip) or changed
    end

    local wantName = ns.IsEnabled("items.name")
    local wantFlavor = ns.IsEnabled("items.flavor")
    local entry = ns.items and ns.items[itemID]
    if not entry then
        -- ФОЛБЕК: маунт/улюбленець-предмет може бути відсутній у базі назв предметів,
        -- але названий рівно як істота — тоді перекладаємо назву за мапами колекцій.
        if ns.IsEnabled("items.name") then
            local nameLine = GetLine(tooltip, 1)
            local original = ns.SafeText(nameLine and nameLine:GetText())
            local ua = original and ((ns.mountsByName and ns.mountsByName[original])
                                  or (ns.petsByName and ns.petsByName[original]))
            if ua and not original:find(ua, 1, true) then
                local r, g, b = nameLine:GetTextColor()
                local shown = ua .. " |cff808080(" .. original .. ")|r"
                nameLine:SetText(shown)
                if r then nameLine:SetTextColor(r, g, b) end
                ns.Remember(nameLine, original, shown, nil, "items.name")
                changed = true
            end
        end
        if changed then tooltip:Show() end
        return
    end

    local uaName = type(entry) == "table" and entry.name or entry

    if wantName and uaName then
        local nameLine = GetLine(tooltip, 1)
        local lineText = ns.SafeText(nameLine and nameLine:GetText())
        -- MYTHIC KEYSTONE: рядок 1 — ДИНАМІЧНА назва «Keystone: <Данж>».
        -- Статична підміна ns.items[…]=«Міфічний Ключ» СТИРАЛА назву данжу
        -- (гравець не бачив, у який данж ключ). Натомість перекладаємо сам формат:
        -- «Keystone: X» → «Ключ: <переклад X>», зберігаючи данж (його назва — у
        -- ns.questObjectives, напр. «Maisara Caverns»→«Печери Майсари»).
        -- ГЕЙТ — за самим форматом «Keystone: X», а НЕ за itemID: ID ключа різниться
        -- (180653 — не єдиний; сезонні/крос-версійні ключі мають інші ID), і жорсткий
        -- itemID пропускав їх → else-гілка затирала данж статичною назвою (баг BROCKEN).
        local dungeon = (lineText
                         and not (ns.HasCyrillic and ns.HasCyrillic(lineText)))
                        and lineText:match("^Keystone:%s*(.+)$") or nil
        if dungeon then
            local core = dungeon:gsub("%s*%(.-%)%s*$", "")        -- зняти « (…)»-хвіст
            local tail = dungeon:sub(#core + 1)                   -- те, що після назви
            local uaDun = (ns.questObjectives and ns.questObjectives[core])
                or (ns.uiTooltips and ns.uiTooltips[core]) or core -- фолбек: лишити англ. данж
            local r, g, b = nameLine:GetTextColor()
            local shown = "Ключ: " .. uaDun .. tail
            nameLine:SetText(shown)
            if r then nameLine:SetTextColor(r, g, b) end
            ns.Remember(nameLine, lineText, shown, nil, "items.name")               -- Shift -> оригінал
            changed = true
            if changed then tooltip:Show() end
            return
        end
        -- У дужки — СПРАВЖНЯ англійська назва предмета з гри (GetItemNameByID), а
        -- НЕ поточний текст рядка: його міг уже підмінити інший хук назвою КВЕСТУ,
        -- який починає цей предмет (у «Cracked Keystone» збігаються назви предмета
        -- й квесту, тож у дужки лізла чужа укр. назва замість англійського оригіналу).
        local original = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID))
            or lineText
        if lineText and original and not lineText:find(uaName, 1, true) then
            -- Колір рідкості гра ставить через SetTextColor — зчитуємо й
            -- повертаємо, щоб українська назва лишилась зелена/синя/фіолетова.
            local r, g, b = nameLine:GetTextColor()
            -- Українська назва + АНГЛ. оригінал, щоб звірятися з гайдами/аукціоном.
            local shown = uaName .. " |cff808080(" .. original .. ")|r"
            nameLine:SetText(shown)
            if r then nameLine:SetTextColor(r, g, b) end
            ns.Remember(nameLine, original, shown, nil, "items.name") -- Shift -> чистий АНГЛ. оригінал
            changed = true
        end
    end

    if wantFlavor and type(entry) == "table" and entry.fen then
        for i = 2, tooltip:NumLines() do
            local line = GetLine(tooltip, i)
            local text = ns.SafeText(line and line:GetText())
            if text == entry.fen then
                -- ЗБЕРЕГТИ колір флейвору: гра фарбує рядок через SetText(text,r,g,b),
                -- а наш SetText міняє лише текст → без відновлення колір ламається.
                local r, g, b, a = line:GetTextColor()
                line:SetText(entry.fua)
                if r then line:SetTextColor(r, g, b, a) end
                ns.Remember(line, entry.fen, entry.fua, nil, "items.flavor") -- Shift -> оригінал
                changed = true
                break
            elseif text and text:find(entry.fen, 1, true) then
                -- Гра часто обгортає флейвор у лапки/пробіли (" …flora."): точний
                -- збіг ламається. Замінюємо саме fen-ПІДРЯДОК, зберігаючи лапки.
                local pat = entry.fen:gsub("(%W)", "%%%1") -- екран. спецсимволів патерна
                local rep = entry.fua:gsub("%%", "%%%%")
                local shown = text:gsub(pat, rep)
                local r, g, b, a = line:GetTextColor()
                line:SetText(shown)
                if r then line:SetTextColor(r, g, b, a) end
                ns.Remember(line, text, shown, nil, "items.flavor") -- Shift -> показане (з лапками)
                changed = true
                break
            end
        end
    end

    -- ГЕОЛОГІЧНІ ЗРАЗКИ тощо: опис у тултіпі — НЕ з itemFlavors, а з profDesc (профа-
    -- флейвор, напр. Septarian Nodule). + хвіст «You may discover N more sample(s)…»
    -- зі ЗМІННИМ N → нормалізуємо число для збігу й підставляємо живе N у переклад.
    if wantFlavor and ns.profDesc then
        for i = 2, tooltip:NumLines() do
            local line = GetLine(tooltip, i)
            local text = ns.SafeText(line and line:GetText())
            if text and #text >= 40 and not ns.HasCyrillic(text) then
                local key = text:gsub("\r", "")
                local ua = ns.profDesc[key]
                if not ua then
                    local liveN = key:match("discover (%d+) more sample%(s%) this week")
                    if liveN then
                        if not ns.__profDescNorm then
                            ns.__profDescNorm = {}
                            for pk, pv in pairs(ns.profDesc) do
                                if pk:find("more sample%(s%) this week") then
                                    ns.__profDescNorm[(pk:gsub("(discover )%d+( more sample)", "%1#%2"))] = pv
                                end
                            end
                        end
                        local pv = ns.__profDescNorm[(key:gsub("(discover )%d+( more sample)", "%1#%2"))]
                        if pv then ua = (pv:gsub("(ще )%d+( зразок)", "%1" .. liveN .. "%2")) end
                    end
                end
                if ua and ua ~= text then
                    local r, g, b, a = line:GetTextColor()
                    line:SetText(ua)
                    if r then line:SetTextColor(r, g, b, a) end
                    ns.Remember(line, text, ua, nil, "items.effects")
                    changed = true
                    break
                end
            end
        end
    end

    if changed then
        tooltip:Show() -- перерахувати розмір під змінені рядки
    end
end

if TooltipDataProcessor and Enum.TooltipDataType and Enum.TooltipDataType.Item then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, TranslateItemTooltip)
end
