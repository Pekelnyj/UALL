-- WoWUkraine: показ перекладу книг (ItemText) — книги, листи, таблички.
-- База: ns.bookTexts["англ. текст сторінки"] = "укр. текст". Збір — у Capture.lua.
--
-- За /framestack текст сторінки рендерить ItemTextPageText — це SimpleHTML-фрейм
-- (всередині створює FontString-и з hex-іменами на кожен абзац). Тож НЕ шукаємо
-- окремий FontString (там лише шматки) — пінимо SetText самого ItemTextPageText.
-- У хука SetText(self, text) аргумент text = англ. текст, що ставить Blizzard:
-- беремо його напряму → шукаємо в базі → підмінюємо. Без taint (лише видимий текст).
-- Shift тимчасово повертає оригінал (через ns.replacements / ns.Remember).

local _, ns = ...

local busy = false       -- захист від рекурсії (наш SetText знову тригерить хук)
local hooked = false

-- ІМ'Я ГРАВЦЯ. Частина листів звертається до читача на ім'я («{NAME} represents
-- a new, united front…» — грамота Лицарів Чорного Клинка), тож захоплення
-- зберігає ім'я ТОГО тестера, а база ключується через {NAME}. До 18.10.2026
-- модуль цього не вмів: 35 ключів із {NAME} лежали мертвим грузом, бо lookup
-- ішов по буквальному тексту, а той у кожного гравця інший. Дзеркало
-- NormName/LocName із BroadcastHooks [[guild-names-never-translate]].
local PLAYER
local function P()
    if PLAYER == nil then PLAYER = UnitName("player") or false end
    return PLAYER or nil
end
local function esc(s) return (s:gsub("(%W)", "%%%1")) end
local function NormName(t)
    local p = P()
    if p and t and t:find(p, 1, true) then return (t:gsub(esc(p), "{NAME}")) end
    return t
end
local function LocName(t)
    if t and t:find("{NAME}", 1, true) then
        local p = P()
        if p then return (t:gsub("{NAME}", function() return p end)) end
    end
    return t
end

-- text — рядок, який Blizzard ставить у сторінку (англ. оригінал).
local function Translate(self, text)
    if busy then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    -- галочка «Книги і листи» до 07.10.2026 ні на що не впливала: модуль її не читав
    if ns.IsEnabled and not ns.IsEnabled("books") then return end
    local raw = ns.SafeText and ns.SafeText(text) or text
    if not raw or raw == "" then return end
    -- Гра віддає переноси як \r\n, а база згенерована з \n (генератор зрізає \r).
    -- Нормалізуємо ключ пошуку, інакше "…\r\n…" ніколи не збігається з "…\n…".
    local en = (raw:gsub("\r", ""))
    local ua = ns.bookTexts and ns.bookTexts[en]
    if not ua then                      -- друга спроба: ім'я читача -> {NAME}
        local key = NormName(en)
        if key ~= en then ua = ns.bookTexts and ns.bookTexts[key] end
        if ua then ua = LocName(ua) end -- у показі {NAME} -> справжнє ім'я
    end
    if ns.Diag then
        ns.Diag(("книга: en=%d ua=%s"):format(#en, ua and "Є" or "НЕМА"))
    end
    if not ua or ua == en then return end
    busy = true
    ns.Remember(self, en, ua, true, "books") -- solo: SimpleHTML без GetText, не пул
    self:SetText(ua)
    busy = false
    if ns.Diag then ns.Diag("книга: підмінено ✓") end
end

-- Причіпка SetText-піна (лінива: фрейм може з'явитись не одразу).
local function EnsureHook()
    if hooked then return end
    local fs = _G.ItemTextPageText
    if fs and fs.SetText then
        hooksecurefunc(fs, "SetText", Translate)
        hooked = true
        if ns.Diag then ns.Diag("книга: SetText ItemTextPageText зачеплено") end
    elseif ns.Diag then
        ns.Diag("книга: ItemTextPageText недоступний")
    end
end

EnsureHook() -- якщо фрейм уже існує на момент завантаження

-- ITEM_TEXT_READY — сторінка готова. Причіпляємо хук (якщо ще ні) і вручну
-- підмінюємо поточну сторінку: Blizzard міг поставити текст ще до нашого піна.
local function RunTranslate()
    local fs = _G.ItemTextPageText
    if fs and ItemTextGetText then Translate(fs, ItemTextGetText()) end
end

-- СТРАХОВИЙ ТІКЕР: SimpleHTML (ItemTextPageText) інколи ПЕРЕМАЛЬОВУЄ сторінку
-- ще раз ПІСЛЯ нашої підміни — другий SetText іде з трохи іншим текстом
-- (HTML-обгортка/пробіли), lookup промахується → лист лишається англійським,
-- доки Shift (ns.Remember) не відновить. Тому, поки ItemTextFrame показаний,
-- легко ре-translate'имо раз на ~0.2с (ідемпотентно: busy-guard + Cyrillic уже
-- стоїть → повторно не чіпаємо). Зупиняється сам, щойно лист закрили.
local ticking = false
local function StartTicker()
    if ticking or not (C_Timer and C_Timer.After) then return end
    ticking = true
    local function tick()
        local frame = _G.ItemTextFrame
        if not (frame and frame.IsShown and frame:IsShown()) then
            ticking = false
            return
        end
        pcall(RunTranslate)
        C_Timer.After(0.2, tick)
    end
    C_Timer.After(0.05, tick)
end

local f = CreateFrame("Frame")
f:RegisterEvent("ITEM_TEXT_READY")
f:SetScript("OnEvent", function()
    EnsureHook()
    -- кілька синхронних спроб (Blizzard міг поставити текст до нашого піна) + тікер
    if C_Timer and C_Timer.After then
        for _, d in ipairs({ 0, 0.1, 0.3 }) do C_Timer.After(d, RunTranslate) end
        StartTicker()
    else
        RunTranslate()
    end
end)
