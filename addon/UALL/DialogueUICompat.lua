-- WoWUkraine: сумісність зі стороннім аддоном DialogueUI (Peterodox).
-- DialogueUI замінює стандартні вікна квестів/діалогів власним UI, тож наші
-- хуки на Blizzard-фрейми його НЕ ловлять. DialogueUI має ОФІЦІЙНИЙ публічний
-- API для аддонів-перекладачів: DialogueUIAPI.SetTranslator{...} — реєструємо
-- наш геттер квест-даних, і DialogueUI показує НАШ український текст напряму
-- (той самий шлях, що CzechQuests/WowUkrainizer). Жодного хакання фреймів.

local _, ns = ...

-- Той самий конвеєр, що QuestHooks.Localize: рід гравця ($p) + опція імен.
local function L(text)
    if type(text) ~= "string" then return text end
    if ns.ApplyPlayerGender then text = ns.ApplyPlayerGender(text) end
    if ns.ApplyNames then text = ns.ApplyNames(text) end
    return text
end

-- КНОПКА-ПЕРЕКЛАДАЧ у кутку вікна DialogueUI — ЙОГО власна (MainFrame.Translator-
-- Button, TranslatorPublic.lua). Він малює її сам, щойно будь-який аддон
-- зареєструвався через SetTranslator, і показує лише там, де в перекладача є
-- назва квесту (IsQuestTranslationAvailable → цей самий геттер). Її ЛІВИЙ клік
-- гасить переклад лише до перезаходу: у DialogueUI це локальна змінна
-- ENABLE_TRANSLATION, у збереженнях її немає (правий клік — показ оригіналу —
-- навпаки, зберігається в його DB). Ми ту змінну не бачимо й зберегти не можемо,
-- тож маємо власний вимикач, який переживає /reload: опцію знято → геттер
-- повертає nil → DialogueUI нема чого показувати, і кнопка зникає разом із
-- перекладом (скарга тестера 01.10).
--
-- DialogueUI кличе це з questID; повертаємо НАШ переклад або nil (тоді DialogueUI
-- лишає англ. — м'який фолбек). Поля: title/description/objective(одн.!)/progress/
-- completion (greeting у нас окремо немає). Поля гейтуємо тими самими опціями,
-- що й рідне вікно квестів, — інакше DialogueUI ігнорував би налаштування.
local function QuestDataGetter(questID)
    if not ns.IsEnabled("compat.dialogueUI") then return nil end
    local q = ns.quests and ns.quests[questID]
    if not q then return nil end
    local data = {}
    if q.title and ns.IsEnabled("quests.title") then data.title = L(q.title) end
    if q.description and ns.IsEnabled("quests.text") then data.description = L(q.description) end
    if q.objectives and ns.IsEnabled("quests.objectives") then
        data.objective = L(q.objectives)                        -- DialogueUI: «objective»
    end
    if q.progress and ns.IsEnabled("quests.text") then data.progress = L(q.progress) end
    if q.completion and ns.IsEnabled("quests.text") then data.completion = L(q.completion) end
    -- порожня таблиця = немає перекладу → не плутаємо DialogueUI
    if not next(data) then return nil end
    return data
end

-- Шрифт для UA-тексту в DialogueUI. КРИТИЧНО: ігровий «Fonts\FRIZQT___CYR.TTF»
-- є НЕ на всіх клієнтах (у частини тестерів його нема → весь UA-текст = квадратики).
-- DialogueUI ВЕЗЕ власний кириличний шрифт frizqt___cyr.ttf у своїй теці — він
-- присутній ЗАВЖДИ (бо DialogueUI встановлено) і має кириличні гліфи. Тож беремо
-- його; ігровий CYR — лише запас (на випадок зміни шляху в DialogueUI).
local function PickFont()
    local duiFont = "Interface/AddOns/DialogueUI/Fonts/frizqt___cyr.ttf"
    local test = _G.WoWUkraineFontProbe or UIParent:CreateFontString(nil, "BACKGROUND")
    _G.WoWUkraineFontProbe = test
    -- pcall: SetFont заборонена в обмежених контекстах (кінематик/захищений UI) → не флудити
    if test.SetFont then
        local ok, res = pcall(test.SetFont, test, duiFont, 12, "")
        if ok and res then return duiFont end
    end
    return ns.CYR_FONT
end

local registered = false
local function Register()
    if registered then return true end
    local api = _G.DialogueUIAPI
    if not (api and type(api.SetTranslator) == "function") then return false end
    api.SetTranslator({
        name = "UALL",
        font = PickFont(),            -- bundled DialogueUI cyr-шрифт (надійніше за ігровий)
        questDataGetter = QuestDataGetter,
    })
    registered = true
    if ns.Diag then ns.Diag("DialogueUI: перекладач UALL зареєстровано") end
    return true
end

-- DialogueUI вантажиться окремо й може бути ще не готовим на момент нашого старту —
-- пробуємо одразу, потім на завантаженні аддонів / вході у світ.
if not Register() then
    local f = CreateFrame("Frame")
    f:RegisterEvent("ADDON_LOADED")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:SetScript("OnEvent", function(self)
        if Register() then self:UnregisterAllEvents() end
    end)
end
