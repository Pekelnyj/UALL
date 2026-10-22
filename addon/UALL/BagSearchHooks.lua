-- WoWUkraine: пошук у сумках/банку за УКРАЇНСЬКОЮ назвою предмета.
-- АДИТИВНО: рідний (англійський) пошук Blizzard лишається недоторканим — ми лише
-- ДОдаємо збіги за нашою базою назв (ns.items[itemID]). Тобто «меч» знайде предмети,
-- у яких українська назва містить «меч», а англійський пошук працює як завжди.
-- Гейт: опція items.bagSearch + завантажена база предметів (ns.items — LoD).
-- Тейнт-безпечно: лише візуальний SetMatchesSearch на кнопках сумок (не захищені),
-- під гейтом IsForbidden; жодних замін API/захищених викликів.
local _, ns = ...

local C_Container = C_Container
if not (C_Container and C_Container.SetItemSearch) then return end

-- UTF-8-згортання регістру (string.lower не чіпає кирилицю) --------------------
local LOWER = {
    ["А"]="а",["Б"]="б",["В"]="в",["Г"]="г",["Ґ"]="ґ",["Д"]="д",["Е"]="е",["Є"]="є",
    ["Ж"]="ж",["З"]="з",["И"]="и",["І"]="і",["Ї"]="ї",["Й"]="й",["К"]="к",["Л"]="л",
    ["М"]="м",["Н"]="н",["О"]="о",["П"]="п",["Р"]="р",["С"]="с",["Т"]="т",["У"]="у",
    ["Ф"]="ф",["Х"]="х",["Ц"]="ц",["Ч"]="ч",["Ш"]="ш",["Щ"]="щ",["Ь"]="ь",["Ю"]="ю",
    ["Я"]="я",
}
local function fold(s)
    if not s or s == "" then return "" end
    -- спершу кирилиця (двобайтові UTF-8), тоді ASCII через :lower()
    s = s:gsub("[\194-\244][\128-\191]*", function(c) return LOWER[c] or c end)
    return s:lower()
end

-- Поточний рядок пошуку (спільний для всіх контейнерів) -----------------------
local currentSearch = nil
hooksecurefunc(C_Container, "SetItemSearch", function(text)
    currentSearch = (type(text) == "string" and text ~= "") and fold(text) or nil
end)

-- Гейт активності --------------------------------------------------------------
local function Active()
    return ns.IsEnabled and ns.IsEnabled("items.bagSearch") and ns.items ~= nil
end

-- Дістати itemID з кнопки сумки/банку ------------------------------------------
local function ItemIDOf(button)
    local bag = button.GetBagID and button:GetBagID()
    local slot = button.GetID and button:GetID()
    if bag and slot and C_Container.GetContainerItemID then
        local ok, id = pcall(C_Container.GetContainerItemID, bag, slot)
        if ok and id then return id end
    end
    if button.GetItemLocation then
        local ok, loc = pcall(button.GetItemLocation, button)
        if ok and loc and loc.IsValid and loc:IsValid() and C_Item and C_Item.GetItemID then
            local ok2, id = pcall(C_Item.GetItemID, loc)
            if ok2 and id then return id end
        end
    end
    return nil
end

local function UANameOf(itemID)
    local entry = itemID and ns.items and ns.items[itemID]
    if not entry then return nil end
    return type(entry) == "table" and entry.name or entry
end

-- OR-in: якщо англійський фільтр сховав предмет, але українська назва збігається
-- з рядком пошуку — повертаємо збіг. reentry-гейт проти нескінченної рекурсії.
local reentry = false
local function OnMatches(self, matches)
    if reentry or matches then return end            -- вже збіг (англ.) — нічого додавати
    if not currentSearch or not Active() then return end
    if self.IsForbidden and self:IsForbidden() then return end
    -- У БОЮ не чіпаємо кнопки: SetMatchesSearch тейнтить їх, а Blizzard-розкладка торби
    -- в бою кличе Button:SetPassThroughButtons() → попап ADDON_ACTION_FORBIDDEN. Поза
    -- боєм (де й шукають предмети) укр-пошук працює; правильний фікс — власний оверлей.
    if InCombatLockdown and InCombatLockdown() then return end
    local ua = UANameOf(ItemIDOf(self))
    if ua and fold(ua):find(currentSearch, 1, true) then
        reentry = true
        pcall(self.SetMatchesSearch, self, true)
        reentry = false
    end
end

-- Чіпляємо на базовий та контейнерний мікшини (у Midnight глобальні UI-функції
-- прибрано — працюємо через мікшини). Уникаємо подвійного хука тієї самої функції.
local hooked = {}
local function HookMixin(mixin)
    if type(mixin) == "table" and type(mixin.SetMatchesSearch) == "function"
       and not hooked[mixin.SetMatchesSearch] then
        hooked[mixin.SetMatchesSearch] = true
        hooksecurefunc(mixin, "SetMatchesSearch", OnMatches) -- @taint-ok: рішення власника 20.08.2026 — лишити до власної підсвітки (див. коментар нижче)
    end
end
-- Укр-пошук предметів у торбах/банку за укр-назвою (OR-in до рідного англ. пошуку).
-- ТЕЙНТ: SetMatchesSearch на secure-кнопках тейнтить їх; OnMatches вище не чіпає їх У БОЮ
-- (де й виринав попап FORBIDDEN на SetPassThroughButtons). Поза боєм — працює. Правильний
-- майбутній фікс — власний оверлей-підсвітка замість Blizzard-SetMatchesSearch.
HookMixin(_G.ItemButtonMixin)
HookMixin(_G.ContainerFrameItemButtonMixin)
