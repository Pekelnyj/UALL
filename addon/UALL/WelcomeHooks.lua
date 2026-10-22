-- Інформаційне вікно вітання. Показується ОДИН РАЗ при першому запуску аддона
-- (флаг db.welcomeShown у UALLSettingsDB). Повторно — слеш «/uall welcome» або
-- кнопка «Про аддон» у налаштуваннях. Мета: коротко пояснити гравцю, що це рання
-- тестова версія, і дати посилання (сайт/Discord/автор), бо WoW не відкриває
-- браузер — тож посилання копіюються в поле для Ctrl+C.

local ADDON_NAME, ns = ...

local VERSION = (C_AddOns and C_AddOns.GetAddOnMetadata
                 and C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version"))
    or (GetAddOnMetadata and GetAddOnMetadata(ADDON_NAME, "Version")) or ""

-- Повні адреси для копіювання + короткий підпис для показу.
local LINKS = {
    { label = "Сайт (завантажити версію для тестерів):",
      url = "https://temnozelena.com", show = "temnozelena.com" },
    { label = "Discord (спільнота DarkGreen):",
      url = "https://discord.gg/AMbx46DrY", show = "discord.gg/AMbx46DrY" },
    { label = "Автор — Pekelnyj:",
      url = "https://www.twitch.tv/pekelnyj", show = "twitch.tv/pekelnyj" },
    { label = "Особлива подяка — ne_multik:",
      url = "https://www.twitch.tv/ne_multik", show = "twitch.tv/ne_multik" },
}

local BODY =
    -- Перший рядок короткий: назву й розшифровку тепер несе шапка вікна.
    "Дякуємо, що встановили |cffffd100UALL|r!\n\n"
    .. "Це |cffff8040рання тестова версія|r: частина текстів ще не перекладена або "
    .. "може містити помилки, і ми активно над цим працюємо."

-- Сухі цифри обсягу перекладу. Знімок станом на версію (перерахунок:
-- scratchpad/stats.py по data/translations.json). Нерозривні пробіли (\194\160)
-- в числах, щоб не розривалися між рядками.
local STATS =
    "|cffffd100Уже перекладено:|r\n"
    .. "• слів — понад 4\194\160100\194\160000\n"
    .. "• квестів — 36\194\160053\n"
    .. "• секцій журналу — 24\194\160984\n"
    .. "• і багато чого іншого\n"
    .. "|cff9d9d9dІ це ще не все — триває постійна робота над вичиткою "
    .. "й покращенням текстів.|r"

local CREDITS =
    "Дякуємо тестерам: |cffb0e0b0st3nlee, ColonelBrasco, Avalon|r "
    .. "та всім, хто збирає дані для перекладу."

local frame       -- ліниво створюємо при першому показі
local currentUrl  -- адреса, що зараз у полі копіювання (для захисту від редагування)

local function SetCopy(box, url)
    currentUrl = url
    box:SetText(url)
    box:SetCursorPosition(0)
    box:HighlightText()
    box:SetFocus()
end

local function Build()
    if frame then return frame end
    frame = CreateFrame("Frame", "UALLWelcomeFrame", UIParent, "BackdropTemplate")
    frame:SetSize(480, 560)
    frame:SetPoint("CENTER")
    frame:SetFrameStrata("DIALOG")
    frame:SetBackdrop({
        bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
        edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 },
    })
    -- Стандартний фон діалогу напівпрозорий — крізь нього просвічує світ і текст
    -- читається погано. Підкладаємо суцільне затемнення поверх фону, під контентом.
    local dim = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
    dim:SetColorTexture(0, 0, 0, 0.65)
    dim:SetPoint("TOPLEFT", 11, -12)
    dim:SetPoint("BOTTOMRIGHT", -12, 11)

    -- рухоме + закривається Esc
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:SetClampedToScreen(true)
    tinsert(UISpecialFrames, "UALLWelcomeFrame")

    local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -4, -4)

    -- Шапка: назва у кольорах прапора + розшифровка + версія + роздільник.
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    title:SetPoint("TOP", 0, -20)
    title:SetText("|cff4ea6ffUA|r|cffffd100LL|r")

    local subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    subtitle:SetPoint("TOP", title, "BOTTOM", 0, -4)
    subtitle:SetText("українська локалізація World\194\160of\194\160Warcraft")

    local ver = frame:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    ver:SetPoint("TOP", subtitle, "BOTTOM", 0, -3)
    -- порожню версію не показуємо, щоб не висів самотній підпис «версія »
    -- у публічній збірці додаємо позначку «публічний реліз»
    local vtext = VERSION ~= "" and ("версія " .. VERSION) or ""
    if ns.PUBLIC then vtext = (vtext ~= "" and (vtext .. " — ") or "") .. "публічний реліз" end
    ver:SetText(vtext)

    local divider = frame:CreateTexture(nil, "ARTWORK")
    -- ВАЖЛИВО: один вертикальний якір + явний розмір. Пара TOPLEFT/TOPRIGHT із
    -- нульовим y прибиває текстуру до верху фрейму і ламає весь лейаут нижче.
    divider:SetSize(428, 1)
    divider:SetPoint("TOP", ver, "BOTTOM", 0, -10)
    divider:SetColorTexture(1, 0.82, 0, 0.25)

    local body = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    body:SetPoint("TOPLEFT", divider, "BOTTOMLEFT", 0, -14)
    body:SetWidth(428)
    body:SetJustifyH("LEFT")
    body:SetSpacing(3)
    body:SetText(BODY)

    -- сухі цифри обсягу перекладу
    local stats = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    stats:SetPoint("TOPLEFT", body, "BOTTOMLEFT", 0, -14)
    stats:SetWidth(428)
    stats:SetJustifyH("LEFT")
    stats:SetSpacing(3)
    stats:SetText(STATS)

    -- заголовок секції посилань
    local lh = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    lh:SetPoint("TOPLEFT", stats, "BOTTOMLEFT", 0, -16)
    lh:SetText("Посилання")

    -- поле копіювання (оголошуємо раніше — на нього посилаються рядки-посилання)
    local copyBox = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
    copyBox:SetAutoFocus(false)
    copyBox:SetFontObject("ChatFontNormal")
    copyBox:SetHeight(20)
    -- Esc у полі одразу закриває все вікно (а не лише знімає фокус —
    -- інакше гравцю доводиться тиснути Esc двічі)
    copyBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
        frame:Hide()
    end)
    -- захист від випадкового редагування: будь-яку ручну зміну відкочуємо
    -- до поточної адреси й повертаємо виділення
    copyBox:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
    copyBox:SetScript("OnTextChanged", function(self, userInput)
        if userInput and currentUrl then
            self:SetText(currentUrl)
            self:HighlightText()
        end
    end)

    -- рядки-посилання: клік по рядку кладе повну адресу в copyBox і виділяє її
    local anchor = lh
    for _, L in ipairs(LINKS) do
        local row = CreateFrame("Button", nil, frame)
        row:SetSize(428, 18)
        row:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -8)

        local lbl = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        lbl:SetPoint("LEFT", 0, 0)
        lbl:SetText(L.label)

        local link = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        link:SetPoint("LEFT", lbl, "RIGHT", 6, 0)
        link:SetText("|cff4ea6ff" .. L.show .. "|r")

        row:SetScript("OnClick", function() SetCopy(copyBox, L.url) end)
        row:SetScript("OnEnter", function() link:SetText("|cff9fd0ff" .. L.show .. "|r") end)
        row:SetScript("OnLeave", function() link:SetText("|cff4ea6ff" .. L.show .. "|r") end)
        anchor = row
    end

    -- подяки тестерам
    local credits = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    credits:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -14)
    credits:SetWidth(428)
    credits:SetJustifyH("LEFT")
    credits:SetText(CREDITS)

    -- підказка + поле копіювання
    local hint = frame:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    hint:SetPoint("TOPLEFT", credits, "BOTTOMLEFT", 0, -14)
    hint:SetText("Клікніть посилання — адреса з'явиться нижче, тоді Ctrl+C щоб скопіювати:")

    copyBox:SetPoint("TOPLEFT", hint, "BOTTOMLEFT", 4, -6)
    copyBox:SetPoint("RIGHT", frame, "RIGHT", -26, 0)
    currentUrl = LINKS[1].url
    copyBox:SetText(currentUrl)

    -- кнопки внизу
    local optBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    optBtn:SetSize(150, 24)
    optBtn:SetPoint("BOTTOMLEFT", 20, 20)
    optBtn:SetText("Налаштування")
    optBtn:SetScript("OnClick", function()
        if ns.OpenOptions then ns.OpenOptions() end
    end)

    local okBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    okBtn:SetSize(120, 24)
    okBtn:SetPoint("BOTTOMRIGHT", -20, 20)
    okBtn:SetText("Закрити")
    okBtn:SetScript("OnClick", function() frame:Hide() end)

    return frame
end

-- Показати вікно (force не потрібен — сам показ завжди дозволений; гейт першого
-- запуску робить обробник події нижче).
function ns.ShowWelcome()
    Build():Show()
end

-- Перший запуск: на вході в гру, коли БД і шрифти вже готові. Показуємо ОДИН раз.
-- ВАЖЛИВО: прапорець welcomeShown ставимо ЛИШЕ після успішного показу — якщо
-- гравець встигне зробити /reload під час затримки або показ упаде з помилкою,
-- вікно спробує з'явитися наступного разу, а не зникне назавжди.
local ev = CreateFrame("Frame")
ev:RegisterEvent("PLAYER_LOGIN")
ev:SetScript("OnEvent", function(self)
    self:UnregisterEvent("PLAYER_LOGIN")
    local db = ns.GetSettingsDB and ns.GetSettingsDB()
    if not (db and not db.welcomeShown) then return end

    local function showOnce()
        if pcall(ns.ShowWelcome) then
            db.welcomeShown = true
        end
    end
    -- невелика затримка, щоб вікно не потонуло серед логін-повідомлень
    if C_Timer and C_Timer.After then
        C_Timer.After(1.5, showOnce)
    else
        showOnce()
    end
end)