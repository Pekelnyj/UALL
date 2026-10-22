-- WoWUkraine: КЛАС ГРАВЦЯ у перекладах — токени {class} (називний) і {classv}
-- (кличний). Сервер підставляє клас гравця в тексти ($c) ДО показу, тож
-- тестерський збір «запікає» конкретний клас у EN-ключ («How can I help you,
-- paladin?»). У базі такі записи зберігаються ШАБЛОНОМ з {class}; на
-- PLAYER_LOGIN ми МАТЕРІАЛІЗУЄМО їх у конкретні ключі для класу гравця
-- (обидва регістри: $c «paladin» і $C «Paladin»). Шляхи пошуку в хуках не
-- змінюються — словник просто отримує готові пари. Стать — за UnitSex.

local _, ns = ...

-- classFile → EN-рендер $c (нижній регістр, як у капчах).
local CLASS_EN = {
    WARRIOR = "warrior", PALADIN = "paladin", HUNTER = "hunter",
    ROGUE = "rogue", PRIEST = "priest", DEATHKNIGHT = "death knight",
    SHAMAN = "shaman", MAGE = "mage", WARLOCK = "warlock",
    MONK = "monk", DRUID = "druid", DEMONHUNTER = "demon hunter",
    EVOKER = "evoker",
}

-- classFile → { m = {наз, клич}, f = {наз, клич} } (узгоджено з користувачем).
local CLASS_UA = {
    WARRIOR = { m = { "воїн", "воїне" }, f = { "воїтелька", "воїтелько" } },
    PALADIN = { m = { "паладин", "паладине" }, f = { "паладинка", "паладинко" } },
    HUNTER = { m = { "мисливець", "мисливцю" }, f = { "мисливиця", "мисливице" } },
    ROGUE = { m = { "розбійник", "розбійнику" }, f = { "розбійниця", "розбійнице" } },
    PRIEST = { m = { "жрець", "жерче" }, f = { "жриця", "жрице" } },
    DEATHKNIGHT = { m = { "лицар смерті", "лицарю смерті" }, f = { "лицарка смерті", "лицарко смерті" } },
    SHAMAN = { m = { "шаман", "шамане" }, f = { "шаманка", "шаманко" } },
    -- «маг» у кличному НЕ відмінюємо (глосарій §13; «магу» — давальний, у
    -- звертанні звучить хибно; база 20:2 за незмінну форму)
    MAGE = { m = { "маг", "маг" }, f = { "магиня", "магине" } },
    WARLOCK = { m = { "чорнокнижник", "чорнокнижнику" }, f = { "чорнокнижниця", "чорнокнижнице" } },
    MONK = { m = { "монах", "монаше" }, f = { "монахиня", "монахине" } },
    DRUID = { m = { "друїд", "друїде" }, f = { "друїдка", "друїдко" } },
    DEMONHUNTER = { m = { "мисливець на демонів", "мисливцю на демонів" },
                    f = { "мисливиця на демонів", "мисливице на демонів" } },
    EVOKER = { m = { "евокер", "евокере" }, f = { "евокерка", "евокерко" } },
}

-- Підстановка токенів у наш UA-рядок (на випадок прямого рантайм-використання).
function ns.ApplyPlayerClass(text)
    if type(text) ~= "string" or not text:find("{class", 1, true) then return text end
    local _, classFile = UnitClass("player")
    local ua = classFile and CLASS_UA[classFile]
    if not ua then return text end
    local forms = (UnitSex and UnitSex("player")) == 3 and ua.f or ua.m
    -- {class:v} — синтаксис квестового хука; {classv} — матеріалізований broadcast.
    -- Обидва = кличний. Довші токени ПЕРШИМИ. Стать — за UnitSex (жін. форми).
    return (text:gsub("{class:v}", forms[2]):gsub("{classv}", forms[2]):gsub("{class}", forms[1]))
end

-- Матеріалізація: для кожного словника додаємо конкретні ключі класу гравця.
-- ЛИШЕ читання/додавання — шаблонні ключі не видаляємо (Shift/капча їх не бачать,
-- бо гра ніколи не рендерить "{class}" буквально).
local function Materialize(dict)
    if not dict then return 0 end
    local _, classFile = UnitClass("player")
    local en = classFile and CLASS_EN[classFile]
    local ua = classFile and CLASS_UA[classFile]
    if not en or not ua then return 0 end
    -- $C капіталізує кожне слово («Death Knight»), $c — нижній регістр.
    local enCap = en:gsub("%f[%a]%l", string.upper)
    local forms = (UnitSex and UnitSex("player")) == 3 and ua.f or ua.m
    local adds = {}
    for k, v in pairs(dict) do
        if type(k) == "string" and type(v) == "string" and k:find("{class}", 1, true) then
            local uaDone = v:gsub("{classv}", forms[2]):gsub("{class}", forms[1])
            adds[(k:gsub("{class}", en))] = uaDone
            adds[(k:gsub("{class}", enCap))] = uaDone
        end
    end
    local n = 0
    for k, v in pairs(adds) do
        if dict[k] == nil then dict[k] = v; n = n + 1 end
    end
    return n
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
    local total = 0
    for _, name in ipairs({ "gossip", "broadcast", "questObjectives", "playerChoice" }) do
        total = total + Materialize(ns[name])
    end
    if ns.debug and total > 0 then
        ns.Print(("клас-токени: матеріалізовано %d ключів."):format(total))
    end
end)
