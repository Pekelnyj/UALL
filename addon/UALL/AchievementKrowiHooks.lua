-- UALL: сумісність із аддоном «Krowi's Achievement Filter» (KrowiAF).
-- KrowiAF малює досягнення у ВЛАСНИХ кнопках (KrowiAF_AchievementButtonMixin),
-- тож дефолтні хуки Blizzard (AchievementHooks) туди не доходять — назви/описи
-- лишаються англійськими. Тут хукаємо мікшин KrowiAF синхронно (пост-виклик, у тому
-- ж кадрі → без блимання) і override-имо Header(назву) + Description/HiddenDescription
-- (опис) з нашої бази ns.achievements[id] (та сама, що й для дефолтного вікна).
-- Окремий перемикач «Krowi's Achievement Filter (тестово)» (compat.krowiAF, default
-- OFF) — юзер вмикає сам, бо втручання в рендер чужого аддона потенційно щось зачепить.
-- Тейнт-безпечно: лише видимий SetText на FontString-ах чужого аддона.
local _, ns = ...

-- Гейт: окрема опція «Krowi's Achievement Filter (тестово)» (default OFF — юзер
-- вмикає сам, бо втручання в чужий аддон потенційно щось зачепить) І загальна
-- опція «Досягнення», і не режим показу оригіналу (Shift).
local function Active()
    return ns.IsEnabled and ns.IsEnabled("compat.krowiAF")
        and ns.IsEnabled("achievements")
        and not (ns.ShowOriginal and ns.ShowOriginal())
        and ns.achievements ~= nil
end

-- Перекласти одну KrowiAF-кнопку за її ID (Krowi зберігає ID у self.Achievement.Id).
local function TrButton(self, id)
    if not Active() or type(self) ~= "table" then return end
    id = id or (self.Achievement and self.Achievement.Id)
    local a = id and ns.achievements[id]
    if not a then return end
    -- Назва: головні кнопки списку → self.Header; кнопки пошуку → self.Name.
    local titleFS = self.Header or self.Name
    if a.title and titleFS and titleFS.SetText then
        local en = ns.SafeText and ns.SafeText(titleFS:GetText())
        if en and ns.Remember then ns.Remember(titleFS, en, a.title, nil, "achievements") end
        titleFS:SetText(a.title)
        if ns.ApplyCyrFont then ns.ApplyCyrFont(titleFS) end
    end
    if a.desc then
        -- Description = видимий опис; HiddenDescription = для розрахунку висоти (теж
        -- ставимо, щоб к-сть рядків рахувалась по українському тексту).
        for _, key in ipairs({ "Description", "HiddenDescription" }) do
            local fs = self[key]
            if fs and fs.SetText then
                local en = ns.SafeText and ns.SafeText(fs:GetText())
                if en and ns.Remember then ns.Remember(fs, en, a.desc, nil, "achievements") end
                fs:SetText(a.desc)
                if key == "Description" and ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
            end
        end
    end
end

-- Дерево категорій Krowi зліва: KrowiAF_CategoryButtonMixin:SetCategory ставить
-- self.Label з назвою категорії. Для розгортних категорій Krowi додає службовий
-- префікс «+ »/«- » — саме він ламав точний збіг у WalkChrome (тому «+ Quests» лишався
-- англійським, а безпрефіксні «Characters»/«Housing» перекладались). Тут відриваємо
-- префікс, перекладаємо основу спільним словником ns.achievementChrome (+ ns.ejStrings
-- для доповнень) і повертаємо префікс на місце.
local function TrCategory(self)
    if not Active() or type(self) ~= "table" then return end
    local lbl = self.Label
    if not lbl or not lbl.GetText then return end
    local shown = ns.SafeText and ns.SafeText(lbl:GetText())
    if not shown or shown == "" then return end
    local prefix, base = shown:match("^([%+%-] )(.+)$")
    prefix, base = prefix or "", base or shown
    local map = ns.achievementChrome
    local uaBase = (map and map[base]) or (ns.ejStrings and ns.ejStrings[base])
    if not uaBase then return end
    local ua = prefix .. uaBase
    if ua == shown then return end
    if ns.Remember then ns.Remember(lbl, shown, ua, nil, "achievements") end
    lbl:SetText(ua)
    if ns.ApplyCyrFont then ns.ApplyCyrFont(lbl) end
end

-- Кастомні вкладки Krowi внизу вікна (Expansions/Events/Specials). Текст ставиться
-- напряму button:SetText у фабриці (без хукабельного метода), тож перекладаємо
-- гейтованим обходом глобальних AchievementFrameTab* при показі підфрейму вкладки.
-- Блізардівські вкладки (Achievements/Guild/Statistics) сюди НЕ входять — їх і далі
-- перекладає загальний WalkChrome через UI_CHROME.
local KROWI_TABS = { ["Expansions"] = "Доповнення", ["Events"] = "Події", ["Specials"] = "Особливе" }
local function TrTabs()
    if not Active() then return end
    for i = 1, (AchievementFrame and AchievementFrame.numTabs or 12) do
        local btn = _G["AchievementFrameTab" .. i]
        if btn and btn.GetText then
            local en = ns.SafeText and ns.SafeText(btn:GetText())
            local ua = en and KROWI_TABS[en]
            if ua then
                if ns.Remember then ns.Remember(btn, en, ua, nil, "achievements") end
                btn:SetText(ua)
            end
        end
    end
end

-- Мікшин-функції KrowiAF копіюються на кнопки при їх створенні (з пулу, ліниво при
-- першому відкритті вікна), тож хук на таблицю-мікшин ставимо ДО того — на завантаженні
-- Krowi. SetAchievement→SetAchievementData, тож досить хукнути SetAchievementData.
local function Install()
    local m = _G.KrowiAF_AchievementButtonMixin
    if m and type(m.SetAchievementData) == "function" and not m.__uall then
        m.__uall = true
        hooksecurefunc(m, "SetAchievementData", function(self, _, id) TrButton(self, id) end)
    end
    local sm = _G.KrowiAF_SearchResultsButtonMixin
    if sm and type(sm.SetAchievement) == "function" and not sm.__uall then
        sm.__uall = true
        hooksecurefunc(sm, "SetAchievement", function(self) TrButton(self) end)
    end
    local cm = _G.KrowiAF_CategoryButtonMixin
    if cm and type(cm.SetCategory) == "function" and not cm.__uall then
        cm.__uall = true
        hooksecurefunc(cm, "SetCategory", function(self) TrCategory(self) end)
    end
    local tm = _G.KrowiAF_AchievementFrameTabMixin
    if tm and type(tm.ShowSubFrames) == "function" and not tm.__uall then
        tm.__uall = true
        hooksecurefunc(tm, "ShowSubFrames", function() TrTabs() end)
    end
end

Install() -- якщо Krowi вже завантажений (UALL після нього)
local ev = CreateFrame("Frame")
ev:RegisterEvent("ADDON_LOADED")
ev:RegisterEvent("PLAYER_LOGIN")
ev:SetScript("OnEvent", function(_, _, name)
    if name == "Krowi_AchievementFilter" or _G.KrowiAF_AchievementButtonMixin then Install() end
end)
