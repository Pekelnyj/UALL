-- WoWUkraine: підтримка української кирилиці на enUS-клієнті.
-- Стандартні шрифти англійського клієнта НЕ містять українських гліфів
-- (і, ї, є, ґ) — тому в UI вони показуються порожніми квадратиками («□»).
-- Підміняємо шрифт на версію *_CYR, що йде з грою і має ці гліфи.
--
-- ⚠️ TAINT (досвід, який ламав кулдауни — "bad argument #1 to 'SetCooldown'"):
--   Підміна СПІЛЬНИХ об'єктів шрифтів (GameFontNormal, SystemFont_*, тултіпи
--   тощо) «заражає» захищений UI: панель дій читає ці шрифти, виконання стає
--   tainted, і SetCooldown отримує «секретне» значення. Виключення Number*
--   НЕ рятує — таінт іде через БУДЬ-ЯКИЙ спільний шрифт, що торкається панелі.
--   Тому тут чіпаємо ЛИШЕ квест/трекер-специфічні об'єкти (захищений UI їх НЕ
--   використовує). Для решти UI (списки, заголовки-зони) кирилічний шрифт
--   ставиться на рівні ОКРЕМИХ FontString у TrackerHooks.lua (ApplyCyrFont) —
--   це безпечно, бо не чіпає глобальні об'єкти.

local _, ns = ...

local CYR_FONT = "Fonts\\FRIZQT___CYR.TTF"
ns.CYR_FONT = CYR_FONT

-- Об'єкти шрифтів, які підміняємо на CYR. ВАЖЛИВО: лише ті, що НЕ читає
-- захищена панель дій (інакше taint→SetCooldown). Безпечні = квест/трекер +
-- ВЕЛИКІ ДЕКОРАТИВНІ дисплей-шрифти банерів/тостів/зон/сценарію/делв
-- (панель дій їх не торкається). НЕБЕЗПЕЧНІ (НЕ додавати): GameFontNormal,
-- GameFontHighlight*, GameFontNormalSmall, GameFontDisable*, NumberFont*.
local FONT_OBJECTS = {
    -- Квестові тексти (вікно квесту, журнал).
    "QuestFont", "QuestFontNormalHuge", "QuestFont_Large", "QuestFont_Huge",
    "QuestFont_30", "QuestFont_39", "QuestTitleFont",
    "QuestTitleFontBlackShadow", "QuestFont_Enormous", "QuestFont_Super_Huge",
    -- Трекер цілей: заголовки секцій («ПІДЗЕМЕЛЛЯ») і рядки.
    "ObjectiveTrackerHeaderFont", "ObjectiveTrackerLineFont", "ObjectiveFont",
    "ObjectiveTrackerBlockHeaderFont",
    -- ВЕЛИКІ ДИСПЛЕЙ-ШРИФТИ (банери EventToast «Достаток: Лігво посвяти»,
    -- назви зон/сценаріїв/делв, бос-емоути). Дисплейні розміри — панель дій
    -- їх НЕ читає. Покривають □ СИСТЕМНО, без walk-у за кожним фреймом.
    "Game72Font", "Game60Font", "Game48Font", "Game46Font", "Game42Font",
    "Game40Font", "Game36Font", "Game32Font", "Game30Font", "Game27Font",
    "Game24Font", "Game22Font", "Game20Font", "Game18Font",
    "Game48FontShadow", "Game32FontShadow",
    "SystemFont_Huge1", "SystemFont_Huge1_Outline", "SystemFont_Huge2",
    "SystemFont_World", "SystemFont_World_ThickOutline",
    "SystemFont_Shadow_Huge1", "SystemFont_Shadow_Huge2", "SystemFont_Shadow_Huge3",
    "SystemFont_Outline_Huge", "SystemFont_Med3", "SystemFont_Large", "SystemFont_Large2",
    "SystemFont_Shadow_Med3", "SystemFont_Shadow_Large", "SystemFont_Shadow_Large2",
    "ZoneTextFont", "SubZoneTextFont", "PVPInfoTextFont", "BossEmoteNormalHuge",
    "DestinyFontHuge", "DestinyFontLarge", "DestinyFontMed",
    "Fancy16Font", "Fancy18Font", "Fancy20Font", "Fancy22Font", "Fancy24Font",
    "Fancy27Font", "Fancy30Font", "Fancy32Font", "Fancy48Font", "Fancy72Font",
    "CoreAbilityFont", "RaidWarningFont", "ZoneTextString",
}

local function ApplyCyrillicFonts()
    for _, name in ipairs(FONT_OBJECTS) do
        local fontObject = _G[name]
        if fontObject and fontObject.GetFont then
            local _, size, flags = fontObject:GetFont()
            if size then
                pcall(fontObject.SetFont, fontObject, CYR_FONT, size, flags)
            end
        end
    end
    -- Спільні шрифти (GameFont*, SystemFont*, STANDARD_TEXT_FONT, Number*) НЕ
    -- чіпаємо — taint-вектор для кулдаунів. Кирилицю в решті UI робить
    -- ApplyCyrFont на рівні окремих FontString (TrackerHooks.lua).
end

ns.ApplyCyrillicFonts = ApplyCyrillicFonts

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("ADDON_LOADED")  -- ліниві шрифт-об'єкти (EventToast/сценарій/делв вантажаться окремо)
f:SetScript("OnEvent", function() pcall(ApplyCyrillicFonts) end)
-- запас: деякі шрифти створюються вже після завантаження аддонів
if C_Timer and C_Timer.After then
    C_Timer.After(2, function() pcall(ApplyCyrillicFonts) end)
    C_Timer.After(8, function() pcall(ApplyCyrillicFonts) end)
end
