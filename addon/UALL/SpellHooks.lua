-- WoWUkraine: переклад назв заклять у тултіпах.
-- Перемикач: «Закляття і здібності → Назви заклять» (spells.name),
-- типово ВИМКНЕНО — назви в гайдах/WeakAuras англійські; гравець вмикає сам.
--
-- Описи заклять поки не перекладаються: вони містять динамічні формули
-- (числа залежать від спорядження), це окремий майбутній модуль.

local _, ns = ...

-- Рядок із назвою закляття. У 12.0 з'явився офіційний доступ
-- GameTooltip:GetLeftLine(1); старий шлях через глобальні
-- <ім'я тултіпа>TextLeft1 лишається запасним для інших тултіпів.
local function GetNameLine(tooltip)
    if tooltip.GetLeftLine then
        local line = tooltip:GetLeftLine(1)
        if line then return line end
    end
    local name = tooltip.GetName and tooltip:GetName()
    return name and _G[name .. "TextLeft1"] or nil
end

local function SpellIDFromTooltip(tooltip, data)
    if data and data.id then return data.id end
    -- Запасний шлях, якщо в tooltipData немає id.
    if tooltip.GetSpell then
        local _, spellID = tooltip:GetSpell()
        return spellID
    end
end

-- ───────────────────────── Описи заклять ─────────────────────────
-- Опис у базі — ШАБЛОН з $-токенами ($s1, $d, ${...}). Гра рендерить
-- англійський опис із живими числами; ми зіставляємо його з англійським
-- шаблоном, витягаємо значення токенів і підставляємо їх в український.

-- Види токенів: ${формула}, $@spellname123 (посилання), прості $s1/$d/...
-- Останній патерн: $<цифри?><ЛІТЕРИ+><цифри?>. Літера — БУДЬ-ЯКА (%a), а не вузький
-- список: інакше токени на кшталт $433674U (велика U — кількість зарядів) НЕ
-- розпізнавались, матчер чекав буквальний «$433674U» замість «50», і ВЕСЬ опис
-- лишався англ. (масово в талантах/проках). БАГАТОЛІТЕРНІ іменовані токени ($pri —
-- первинна характеристика, $sw, $mhp тощо): «%a+», а не одна «%a». Раніше «%a»
-- захоплював лише ПЕРШУ літеру ($pri→«$p»), решта ставала літералом («ri»), якого
-- в рендері нема («Strength») → зіставлення падало, ЕФЕКТ ЛИШАВСЯ АНГЛ. (704 шаблони).
-- Однолітерні ($s1/$d) не міняються: за ними завжди не-літера, тож «%a+» бере ту саму
-- одну. NextToken бере найдовший збіг за найменшою позицією, тож $proc/$@/${} зберігають
-- пріоритет над коротким $p.
-- ПЛЮРАЛ/ГЕНДЕР-конструкції ($lability:abilities;, |4ally:allies;, $ghim:her;) — ОДИН
-- токен аж до «;»: гра рендерить лише одну з форм, тож без цього літерал «:abilities;»
-- не збігався і ВЕСЬ опис лишався англ. (311 шаблонів). На тій самій позиції плюрал
-- довший за загальний $-токен → перемагає за tie-break «довший збіг».
local TOKEN_PATTERNS = { "%$%b{}", "%$<%w+>", "%$proc%a+", "%$@%a+%d*",
                         "%$[lLgG][^:;%$]*:[^;%$]*;", "|4[^:;|]*:[^;|]*;",
                         "%$%d*%a+%d*" }

local function EscapeMagic(s)
    return (s:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%1"))
end

-- Первинна характеристика ($pri) в РОД. відмінку для «надати вам 30 <стат>».
ns.PRIMARY_STAT = {
    Strength = "Сили", Agility = "Спритності", Intellect = "Інтелекту",
    ["Bonus Armor"] = "Додаткової броні",
}

local function NextToken(template, pos)
    local bestS, bestE
    for _, pat in ipairs(TOKEN_PATTERNS) do
        local s, e = template:find(pat, pos)
        if s and (not bestS or s < bestS or (s == bestS and e > bestE)) then
            bestS, bestE = s, e
        end
    end
    -- Поглинути хвостовий специфікатор ТОЧНОСТІ «.N» (напр. «${$s1}.1» → рендериться
    -- «27.4», «${…}.1%» → «30.8%»): сервер споживає «.N» при форматуванні, тож у
    -- показаному тексті його НЕМА. Без цього літерал «.1%» у патерні не збігався з «%»
    -- → усі описи з форматом ${…}.N лишались англ. (мастерія персонажа, купа проків).
    if bestE then
        local _, pe = template:find("^%.%d+", bestE + 1)
        if pe then bestE = pe end
    end
    return bestS, bestE
end

local matcherCache = {}
-- Екранувати літерал + зробити пробіли ГНУЧКИМИ: будь-який ран пробілів/переносів →
-- «%s+». WoW-описи в джерелі мають подвійні пробіли після крапки, а відрендерений
-- тултіп інколи дає одинарний (або навпаки) → точний матч провалювався, і опис лишався
-- англ. (напр. маунт X-53). «%s+» матчить і одинарний, і подвійний — безпечно.
local function EscFlexWS(s)
    return (EscapeMagic(s):gsub("%s+", "%%s+"))
end
local function BuildMatcher(template)
    local cached = matcherCache[template]
    if cached then return cached end
    local tokens, parts, pos = {}, { "^" }, 1
    while pos <= #template do
        local s, e = NextToken(template, pos)
        if not s then
            parts[#parts + 1] = EscFlexWS(template:sub(pos))
            break
        end
        parts[#parts + 1] = EscFlexWS(template:sub(pos, s - 1))
        tokens[#tokens + 1] = template:sub(s, e)
        parts[#parts + 1] = "(.-)"
        pos = e + 1
    end
    parts[#parts + 1] = "$"
    cached = { pattern = table.concat(parts), tokens = tokens }
    matcherCache[template] = cached
    return cached
end

local RenderDescription -- оголошення наперед: потрібна в SubstituteTokens

-- ───── Плюрал/гендер-форми в УКРАЇНСЬКОМУ тексті ─────
-- Перекладачі зберігають конструкцію з укр. формами: «$Lочко комбо:очки комбо;»,
-- «|4союзника:союзників;». Гра такі токени сама не рендерить (ми підміняємо текст
-- ПІСЛЯ її рендера), тож обираємо форму самі: $l/$L/|4 — за ОСТАННІМ числом перед
-- токеном (семантика гри: 1 → однина, інакше множина), $g/$G — за статтю персонажа.
local function ChooseByNumber(pre, sg, pl)
    local n
    for num in pre:gmatch("%d[%d%.,]*") do n = num end
    if not n then return pl end
    return (tonumber((n:gsub("[,%.]", ""))) == 1) and sg or pl
end
local function ResolveForms(text)
    if not text:find("[%$|][lLgG4]") then return text end
    local isFemale = UnitSex and UnitSex("player") == 3
    text = text:gsub("()%$([lLgG])([^:;%$]*):([^;%$]*);", function(p, k, sg, pl)
        if k == "g" or k == "G" then return isFemale and pl or sg end
        return ChooseByNumber(text:sub(1, p - 1), sg, pl)
    end)
    text = text:gsub("()|4([^:;|]*):([^;|]*);", function(p, sg, pl)
        return ChooseByNumber(text:sub(1, p - 1), sg, pl)
    end)
    return text
end

-- Підстановка значень токенів в український текст. $@spellname123
-- замінюється на українську назву зі своєї бази, $@spelldesc123 —
-- рекурсивно перекладеним описом вкладеного закляття (аури тощо).
local function SubstituteTokens(uaText, tokens, values)
    local map, order = {}, {}
    for i, tok in ipairs(tokens) do
        if map[tok] == nil then
            map[tok] = values[i]
            order[#order + 1] = tok
        end
    end
    -- Довші токени першими, щоб $s1 не зачепив $s12.
    table.sort(order, function(a, b) return #a > #b end)
    for _, tok in ipairs(order) do
        local val = map[tok]
        -- Токени тривалості ($d, $221883d) рендеряться з англійською
        -- одиницею ("8 sec") — українізуємо її.
        if tok:match("^%$%d*[dD]%d*$") then
            val = val:gsub("(%d[%d%.,]*) sec", "%1 сек")
                     :gsub("(%d[%d%.,]*) min", "%1 хв")
                     :gsub("(%d[%d%.,]*) hours?", "%1 год")
                     :gsub("(%d[%d%.,]*) days?", "%1 дн")
        end
        -- $pri — первинна характеристика: гра рендерить англ. слово («Strength»),
        -- ставимо укр. у РОД. відмінку («…надати вам 30 Сили»). $Spri — з великої.
        if tok == "$pri" or tok == "$Pri" then
            val = (ns.PRIMARY_STAT and ns.PRIMARY_STAT[val]) or val
        end
        local nameID = tok:match("^%$@spellname(%d+)$")
        if nameID and ns.spells and ns.spells[tonumber(nameID)] then
            val = ns.spells[tonumber(nameID)]
        end
        local descID = tok:match("^%$@spelldesc(%d+)$")
        if descID then
            -- Захоплене значення — відрендерений EN-опис вкладеного
            -- закляття; перекладаємо його тим самим механізмом.
            local nested = RenderDescription(tonumber(descID), val)
            if nested then val = nested end
        end
        -- Плюрал/гендер-токени НЕ підставляємо (val — англ. форма з рендера,
        -- «abilities»): українську форму обирає ResolveForms нижче.
        if not (tok:match("^%$[lLgG][^:;]*:") or tok:sub(1, 2) == "|4") then
            uaText = uaText:gsub(EscapeMagic(tok), (val:gsub("%%", "%%%%")))
        end
    end
    return ResolveForms(uaText)
end

-- Зіставляє відрендерений EN-текст із шаблоном без умов; повертає
-- український текст із підставленими значеннями або nil.
local function MatchAndFill(enText, uaText, renderedEN)
    -- Нормалізувати переноси: шаблон у базі може мати \n\n\n\n, а гра рендерить
    -- менше — без цього багатоабзацні описи (ефекти предметів) не збігаються.
    enText = enText:gsub("[\r\n]+", "\n")
    renderedEN = renderedEN:gsub("[\r\n]+", "\n")
    uaText = uaText:gsub("[\r\n]+", "\n\n") -- у виводі — один абзацний розрив
    -- ОБРІЗАТИ хвостові пробіли/переноси: гра часто додає кінцевий \n у FontString
    -- журналу, а патерн анкорить «$», який у Lua НЕ матчить перед хвостовим \n →
    -- жоден варіант не сходився (описи абілок лишались англ.).
    enText = enText:gsub("%s+$", "")
    renderedEN = renderedEN:gsub("%s+$", "")
    local m = BuildMatcher(enText)
    if #m.tokens == 0 then
        return renderedEN:match(m.pattern) and ResolveForms(uaText) or nil
    end
    local values = { renderedEN:match(m.pattern) }
    if #values ~= #m.tokens then return nil end
    return SubstituteTokens(uaText, m.tokens, values)
end

-- ───── Умовні конструкції $?a137028[гілка А][гілка Б] ─────
-- Ми не знаємо, яку гілку обрала гра (умова — спека/аура), тому
-- РОЗГОРТАЄМО шаблон у всі варіанти і шукаємо той, що зійшовся
-- з відрендереним текстом; ті самі гілки обираємо в українському.

-- Розбирає ланцюжок $?cond[A]?cond2[B][C] з позиції s ('$').
-- Повертає позицію після конструкції і список гілок {A, B, C}.
local function ParseConditionalChain(str, s)
    local pos = s + 1 -- після '$'
    local branches = {}
    while str:sub(pos, pos) == "?" do
        local br = str:find("%[", pos)
        if not br then return nil end
        local _, blockEnd = str:find("%b[]", br)
        if not blockEnd then return nil end
        branches[#branches + 1] = str:sub(br + 1, blockEnd - 1)
        pos = blockEnd + 1
    end
    -- else-гілка: інколи Blizzard відділяє її пробілами/переносами від першої
    -- ($?c[.]\n\n\n\n[.\n\n\nSmoldering...]) — пропускаємо їх перед '['.
    local elsePos = pos
    while str:sub(elsePos, elsePos):match("%s") do elsePos = elsePos + 1 end
    local hasElse = false
    if str:sub(elsePos, elsePos) == "[" then
        local _, blockEnd = str:find("%b[]", elsePos)
        if blockEnd then
            branches[#branches + 1] = str:sub(elsePos + 1, blockEnd - 1)
            pos = blockEnd + 1
            hasElse = true
        end
    end
    -- $?cond[X] БЕЗ явної else-гілки = «X або ПОРОЖНЬО». Без цієї неявної порожньої
    -- гілки, коли гра рендерить порожній варіант (інша складність — $?diff8|diff23[…]),
    -- ЖОДЕН розгорнутий варіант не збігається → опис лишається англ. (клас ejmiss).
    if not hasElse then
        branches[#branches + 1] = ""
    end
    if #branches == 0 then return nil end
    return pos, branches
end

-- 64 не вистачало: талант-описи з 4-5 незалежними $?-умовами (по 3 гілки з
-- неявною порожньою) дають 3^5=243 варіанти → expand падав і опис лишався англ.
-- Результат кешується (expansionCache), тож вартість разова на шаблон.
local MAX_VARIANTS = 256

local function ExpandTemplate(template)
    local queue = { { text = template, choices = {} } }
    local result = {}
    while #queue > 0 do
        local v = table.remove(queue)
        local s = v.text:find("%$%?", v.from or 1)
        if not s then
            result[#result + 1] = v
            if #result > MAX_VARIANTS then return nil end
        else
            local after, branches = ParseConditionalChain(v.text, s)
            -- Літеральний «$?» без гілок-[..] (трапляється в текстах описів):
            -- НЕ валимо весь шаблон — пропускаємо це входження і шукаємо далі.
            if not after then
                queue[#queue + 1] = { text = v.text, choices = v.choices, from = s + 2 }
            else
                for i, b in ipairs(branches) do
                    local choices = {}
                    for k, c in ipairs(v.choices) do choices[k] = c end
                    choices[#choices + 1] = i
                    queue[#queue + 1] = {
                        text = v.text:sub(1, s - 1) .. b .. v.text:sub(after),
                        choices = choices,
                    }
                end
            end
        end
    end
    return result
end

-- Застосовує до українського шаблону ті самі вибори гілок.
local function ApplyChoices(template, choices)
    local text, idx, from = template, 1, 1
    while true do
        local s = text:find("%$%?", from)
        if not s then break end
        local after, branches = ParseConditionalChain(text, s)
        -- літеральний «$?» без гілок — пропустити (дзеркально до ExpandTemplate)
        if not after then
            from = s + 2
        else
            local chosen = branches[choices[idx] or 0]
            if not chosen then return nil end
            idx = idx + 1
            text = text:sub(1, s - 1) .. chosen .. text:sub(after)
        end
    end
    return text
end

local expansionCache = {}

-- Рендер за ГОТОВИМ шаблоном {en, ua}: MatchAndFill вставляє живі числа з
-- renderedEN; для шаблонів з умовами $?a[..][..] перебирає розгорнуті варіанти.
-- Ключова частина RenderDescription, винесена окремо — щоб перекладати описи там,
-- де немає spellID-індексу (напр. ефекти іграшок за itemID, див. ToyBoxHooks).
local function RenderTemplate(t, renderedEN)
    if not t or not t.en then return nil end
    if not t.en:find("$?", 1, true) then
        return MatchAndFill(t.en, t.ua, renderedEN)
    end
    local variants = expansionCache[t.en]
    if variants == nil then
        variants = ExpandTemplate(t.en) or false
        expansionCache[t.en] = variants
    end
    if not variants then return nil end
    for _, v in ipairs(variants) do
        local uaVariant = ApplyChoices(t.ua, v.choices)
        if uaVariant then
            local ua = MatchAndFill(v.text, uaVariant, renderedEN)
            if ua then return ua end
        end
    end
    return nil
end
ns.RenderTemplate = RenderTemplate

-- Повертає український опис із живими числами або nil.
-- (Локальна змінна оголошена вище — потрібна рекурсія з SubstituteTokens.)
function RenderDescription(spellID, renderedEN, isAura)
    -- isAura: опис бафа — свій індекс (AuraDescriptions.lua), шаблони в тому ж ns.descTemplates
    local index = isAura and ns.auraDescIndex or ns.spellDescIndex
    local idx = index and index[spellID]
    local t = idx and ns.descTemplates and ns.descTemplates[idx]
    if not t then return nil end
    local ua = RenderTemplate(t, renderedEN)
    if not ua and ns.debug then
        ns.Print("опис: шаблон не зійшовся для spellID " .. spellID)
    end
    return ua
end

-- Доступ для ItemHooks: переклад рядків Equip:/Use: у тултіпах предметів
-- використовує той самий рушій рендеру описів за spellID.
ns.RenderDescription = RenderDescription

-- Текстова реверс-мапа описів БЕЗ $-токенів (маунти тощо): {canon(en): ua}. Дозволяє
-- перекласти опис там, де spellID-індекс не спрацьовує — напр. мул-тултіп, де data.id =
-- mountID (НЕ spellID). Лінива, з ns.descTemplates; токенні описи пропускаємо (їх
-- обслуговує RenderDescription за spellID).
local descByText
local function CanonDesc(s)
    return (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|c%x+", ""):gsub("|r", "")
             :gsub("[\r\n]+", " "):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", ""))
end
local function DescByText()
    if descByText then return descByText end
    descByText = {}
    if ns.descTemplates then
        for _, t in ipairs(ns.descTemplates) do
            if t.en and t.ua and not t.en:find("$", 1, true) then
                descByText[CanonDesc(t.en)] = t.ua
            end
        end
    end
    return descByText
end

-- ───── СЕТ-БОНУСИ ─────
-- Рядок «(N) Set: <опис>» у тултіпі предмета. Опис — ШАБЛОН спела з $-токенами;
-- ЧИСЛА рендерить сервер (нам на них байдуже — це змінні). spellID у рядку НЕМА,
-- тож зіставляємо шаблон за НОРМАЛІЗОВАНИМ текстом: токени і числа → спільний
-- маркер. На збігу MatchAndFill(шаблон.en, шаблон.ua, рендер) вставляє живі числа
-- в UA. ns.setBonus = { {en=шаблон, ua=шаблон}, … } (SetBonuses.lua).
local setBonusByNorm
local function NormForSet(s)
    s = s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|c%x+", ""):gsub("|r", "")
    for _, pat in ipairs(TOKEN_PATTERNS) do s = s:gsub(pat, "\1") end -- токени → \1
    s = s:gsub("[\r\n]+", " "):gsub("%d+[%d%.,]*", "\1")             -- числа → \1
    s = s:gsub("[%s\1]+", " "):gsub("^%s+", ""):gsub("%s+$", "")     -- згорнути маркери/пробіли
    return s
end
-- text = ЧИСТИЙ відрендерений опис бонусу (БЕЗ префікса «(N) Set: »).
-- Шаблон може мати умови $?a123[A][B] — гра рендерить ОДНУ гілку. Тому індексуємо
-- РОЗГОРНУТІ варіанти (ExpandTemplate) з уже застосованими виборами в UA
-- (ApplyChoices) — як RenderDescription, але ключ = нормалізований текст, не spellID.
function ns.SetBonusTry(text)
    if not (ns.setBonus and text) then return nil end
    if not setBonusByNorm then
        setBonusByNorm = {}
        for _, t in ipairs(ns.setBonus) do
            if t.en and t.ua then
                if t.en:find("%$%?") then
                    local variants = ExpandTemplate(t.en)
                    if variants then
                        for _, v in ipairs(variants) do
                            local uaV = ApplyChoices(t.ua, v.choices)
                            if uaV then setBonusByNorm[NormForSet(v.text)] = { en = v.text, ua = uaV } end
                        end
                    end
                else
                    setBonusByNorm[NormForSet(t.en)] = t
                end
            end
        end
    end
    local t = setBonusByNorm[NormForSet(text)]
    if not t then return nil end
    return MatchAndFill(t.en, t.ua, text)
end

-- Трейти професій (спец-дерево): опис вузла — ШАБЛОН з $ev1/$en1/${…} (SpellID=0,
-- значення з самого трейта). Гра рендерить у число/назву; індексуємо за нормалізованим
-- текстом (як set-бонуси) + MatchAndFill. ns.traitTemplates = {{en,ua},…} (TraitTemplates.lua).
local traitByNorm
function ns.TraitTemplateTry(text)
    if not (ns.traitTemplates and text) then return nil end
    if not traitByNorm then
        traitByNorm = {}
        for _, t in ipairs(ns.traitTemplates) do
            if t.en and t.ua then
                if t.en:find("%$%?") then
                    local variants = ExpandTemplate(t.en)
                    if variants then
                        for _, v in ipairs(variants) do
                            local uaV = ApplyChoices(t.ua, v.choices)
                            if uaV then traitByNorm[NormForSet(v.text)] = { en = v.text, ua = uaV } end
                        end
                    end
                else
                    traitByNorm[NormForSet(t.en)] = t
                end
            end
        end
    end
    local t = traitByNorm[NormForSet(text)]
    if not t then return nil end
    return MatchAndFill(t.en, t.ua, text)
end

-- ЖАДІБНИЙ поабзацний збіг для СКЛЕЄНИХ описів (база+суфікс). Базовий $@spelldesc
-- може сам бути з кількох абзаців (у profDesc — один ключ), суфікс — окремий ключ.
-- Ділимо на абзаци й від кожної позиції беремо НАЙДОВШИЙ підряд абзаців, що Є ключем
-- profDesc; неспівпалі лишаємо як є. Спільне для тултіпа (тут) і панелі деталей.
function ns.ProfDescCompose(key)
    if not (ns.profDesc and key) then return nil end
    local paras = {}
    for p in (key .. "\n\n"):gmatch("(.-)\n\n") do paras[#paras + 1] = p end
    if #paras < 2 then return nil end
    local out, i, any = {}, 1, false
    while i <= #paras do
        local matched = false
        for j = #paras, i, -1 do
            local sub = table.concat(paras, "\n\n", i, j)
            local t = ns.profDesc[sub] or ns.profDesc[(sub:gsub("^%s+", ""):gsub("%s+$", ""))]
            if t then out[#out + 1] = t; any = true; i = j + 1; matched = true; break end
        end
        if not matched then out[#out + 1] = paras[i]; i = i + 1 end
    end
    if any then return table.concat(out, "\n\n") end
    return nil
end

-- profDesc-фолбек: описи ПРОФЕСІЙНИХ спелів (руда/трави/геологічні зразки) лежать у
-- ns.profDesc (профа-флейвор), а не в descTemplates. Тултіп таких рецептів — це
-- SPELL-тултіп (є cast time/range), тож переклад беремо тут. + хвіст «You may discover
-- N more sample(s)…» зі змінним N → нормалізуємо число (кеш ns.__profDescNorm).
local function ProfDescTry(text)
    if not (ns.profDesc and text) then return nil end
    local key = text:gsub("\r", "")
    local ua = ns.profDesc[key]
    if ua then return ua end
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
        if pv then return (pv:gsub("(ще )%d+( зразок)", "%1" .. liveN .. "%2")) end
    end
    -- ФОЛБЕК для СКЛЕЄНИХ описів варіантів (Lush/Wild/Voidbound…) = база+суфікс через
    -- порожній рядок. АЛЕ гранулярність різна: базовий $@spelldesc може сам бути з
    -- КІЛЬКОХ абзаців (лежить у profDesc ОДНИМ ключем), а суфікс — окремим. Тому не
    -- ріжемо на кожному \n\n, а ЖАДІБНО шукаємо найдовший підряд абзаців, що Є ключем.
    if key:find("\n\n") then
        local ua2 = ns.ProfDescCompose and ns.ProfDescCompose(key)
        if ua2 then return ua2 end
    end
    return nil
end

local function TranslateDescriptionLines(tooltip, spellID, isAura)
    if not (C_Spell and C_Spell.GetSpellDescription) then return end
    local index = isAura and ns.auraDescIndex or ns.spellDescIndex
    local indexed = index and index[spellID]
    local name = tooltip.GetName and tooltip:GetName()
    -- Матчимо НАМАЛЬОВАНИЙ рядок проти шаблону (за spellID, число=будь-яке — стійко до
    -- бойового дрейфу) АБО за текстом (descByText — коли spellID/індекс не той, як у
    -- мул-тултіпі з mountID). Кирилицю пропускаємо (вже наш переклад).
    for i = 2, tooltip:NumLines() do
        local line
        if tooltip.GetLeftLine then
            line = tooltip:GetLeftLine(i)
        else
            line = name and _G[name .. "TextLeft" .. i]
        end
        local text = ns.SafeText(line and line:GetText())
        -- описи бафів бувають короткі («Stunned.»), описи заклять — ні (там відсікаємо ранг/вартість)
        if text and #text > (isAura and 3 or 20) and not ns.HasCyrillic(text) then
            local ua = indexed and RenderDescription(spellID, (text:gsub("\r\n", "\n")), isAura)
            if not ua then ua = DescByText()[CanonDesc(text)] end -- фолбек за текстом
            if not ua then ua = ProfDescTry(text) end            -- профа-описи (profDesc)
            if ua and ua ~= text then
                -- Зберегти колір опису (гра ставить жовтий через SetTextColor).
                local r, g, b = line:GetTextColor()
                ns.Remember(line, text, ua, nil, isAura and "auras" or "spells.description") -- Shift -> оригінал
                line:SetText(ua)
                if r then line:SetTextColor(r, g, b) end
                return true
            end
        end
    end
end

-- Системні рядки спелл-тултіпа (перезарядка/кулдаун/час творення/канал) — GlobalString-
-- шаблони, яких нема в descTemplates. Перекладаємо САМ РЯДОК (не GlobalString-override,
-- щоб не тейнтити secure-код [[globalstrings-interface-taint]]). Число зберігаємо як
-- намальоване. Це spell-тултіп (не widget), SafeText проти secret у бою.
local SYS_LINES = {
    { "^(%d[%d%.,]*) sec recharge$", "перезарядка: %s с" },
    { "^(%d[%d%.,]*) min recharge$", "перезарядка: %s хв" },
    { "^(%d[%d%.,]*) sec cooldown$", "перезарядка: %s с" },
    { "^(%d[%d%.,]*) min cooldown$", "перезарядка: %s хв" },
    { "^(%d[%d%.,]*) hr cooldown$",  "перезарядка: %s год" },
    { "^(%d[%d%.,]*) sec cast$",     "час творення: %s с" },
    { "^(%d[%d%.,]*) min cast$",     "час творення: %s хв" },
    { "^Channeled$",                 "Підтримуване" },
}
local function TranslateSystemLines(tooltip)
    local name = tooltip.GetName and tooltip:GetName()
    local changed = false
    for i = 2, (tooltip.NumLines and tooltip:NumLines() or 0) do
        local line = (tooltip.GetLeftLine and tooltip:GetLeftLine(i))
            or (name and _G[name .. "TextLeft" .. i])
        local text = ns.SafeText(line and line:GetText())
        if text and #text < 40 and not ns.HasCyrillic(text) then
            for _, pat in ipairs(SYS_LINES) do
                local cap = text:match(pat[1])
                if cap then
                    local ua = pat[2]:find("%%s") and pat[2]:format(cap) or pat[2]
                    if ua ~= text then
                        local r, g, b = line:GetTextColor()
                        ns.Remember(line, text, ua, nil, "spells.description")
                        line:SetText(ua)
                        if r then line:SetTextColor(r, g, b) end
                        changed = true
                    end
                    break
                end
            end
        end
    end
    return changed
end

local function TranslateSpellTooltip(tooltip, data, isAura)
    if ns.ShowOriginal() then return end -- клавіша «показати оригінал»
    local wantName = ns.IsEnabled("spells.name")
    -- опис бафа — під галочкою «Бафи і дебафи» (обгортка UnitAura її вже перевірила)
    local wantDesc = isAura or ns.IsEnabled("spells.description")
    if not wantName and not wantDesc then return end

    local spellID = SpellIDFromTooltip(tooltip, data)
    -- Захист від "secret" spellID (захищені спели в бою на кулдауні, 12.0): і
    -- ПОРІВНЯННЯ (`not spellID`), і ІНДЕКСАЦІЯ `ns.spells[spellID]` кидають помилку
    -- на secret-ключі (лог тестера: «attempted to index ... with secret keys»). Тому
    -- ОДНИМ pcall перевіряємо придатність spellID ПЕРЕД будь-яким його використанням.
    local safe = pcall(function() return spellID ~= nil and ns.spells[spellID] ~= nil end)
    if not safe then return end          -- spellID секретний → просто пропускаємо тултіп
    if not spellID then
        if ns.debug then ns.Print("тултіп: немає spellID у даних") end
        return
    end

    local changed = false

    -- ЗБІР неперекладених заклять (квестові/предметні/зональні абілки, яких
    -- немає в нашій класовій базі). Записуємо лише ID — дані (назва/опис,
    -- en/de/fr) у нас уже є в кешованих CSV. Так збираємо рівно те, що
    -- гравець реально бачить, без 185k сміття.
    local nameKnown = ns.spells and ns.spells[spellID]
    local descKnown = ns.spellDescIndex and ns.spellDescIndex[spellID]
    if (not nameKnown or not descKnown) and ns.GetCaptureDB then
        local ok = pcall(function()
            local db = ns.GetCaptureDB()
            db.spellCapture = db.spellCapture or {}
            db.spellCapture[spellID] = true
        end)
    end

    if wantDesc then
        changed = TranslateDescriptionLines(tooltip, spellID, isAura) or changed
        -- ДИНАМІЧНІ МАУНТИ: опис («This mount changes depending on your Riding skill…»)
        -- додається до тултіпа ПІЗНІШЕ за наш post-call (виміряно: на момент хука
        -- NumLines=4, рядка опису ще нема). Тому ВІДКЛАДЕНІ одноразові спроби (подієві,
        -- НЕ тікер) — коли тултіп уже добудований. RenderDescription матчить за текстом,
        -- тож хибно не перекладе, навіть якщо тултіп змінився; кирилицю пропускає.
        if C_Timer and ns.spellDescIndex and ns.spellDescIndex[spellID] then
            for _, d in ipairs({ 0, 0.1, 0.3, 0.6 }) do
                C_Timer.After(d, function()
                    -- ShowOriginal-гейт ОБОВ'ЯЗКОВИЙ: без нього відкладені повтори
                    -- перекладали в UA вже ПІСЛЯ того, як Shift перемкнув рядок на EN
                    -- → миготіння UA<->EN ~0.6с на тултіпах кнопок дій (оновлюються
                    -- кожні ~0.1с). Тепер під Shift повтори не чіпають рядок.
                    if ns.ShowOriginal() then return end
                    if tooltip and tooltip.IsShown and tooltip:IsShown() then
                        ns.Guard("закляття", TranslateDescriptionLines, tooltip, spellID, isAura)
                    end
                end)
            end
        end
    end

    if wantName then
        local nameLine = GetNameLine(tooltip)
        local original = ns.SafeText(nameLine and nameLine:GetText())
        local translated = ns.spells and ns.spells[spellID]
        -- ФОЛБЕК для маунтів/улюбленців: їхні закляття-виклики (на панелях дій) не
        -- в базі назв заклять, але показана назва Є в мапах колекцій. Перекладаємо
        -- за показаним текстом → «Invincible» на панелі стане «Непереможний».
        if not translated and original then
            translated = (ns.mountsByName and ns.mountsByName[original])
                      or (ns.petsByName and ns.petsByName[original])
        end
        if not translated then
            if ns.debug then ns.Print("тултіп: spellID " .. spellID .. " — нема в базі назв") end
        elseif original and not original:find(translated, 1, true) then
            -- Зберегти колір рядка (гра ставить через SetTextColor).
            local r, g, b = nameLine:GetTextColor()
            -- Українська назва + оригінал поруч, щоб легко звірятися з гайдами.
            local shown = translated .. " |cff808080(" .. original .. ")|r"
            nameLine:SetText(shown)
            if r then nameLine:SetTextColor(r, g, b) end
            ns.Remember(nameLine, original, shown, nil, "spells.name") -- Shift -> чистий оригінал
            changed = true
        end
    end

    -- Системні рядки (перезарядка/час творення/канал) — коли локалізуємо тултіп
    local okSys, sysChanged = pcall(TranslateSystemLines, tooltip)
    if okSys and sysChanged then changed = true end

    if changed then
        tooltip:Show() -- перерахувати розмір тултіпа під змінені рядки
    end
end

if TooltipDataProcessor and Enum.TooltipDataType and Enum.TooltipDataType.Spell then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, TranslateSpellTooltip)
    -- Бафи/аури на панелі бафів — це ОКРЕМИЙ тип тултіпа (UnitAura), а не Spell;
    -- GetSpell() для них дає nil, але data.id = spellID аури. Та сама функція
    -- перекладає назву (й опис, де є шаблон). Devotion Aura(465) → «Аура відданості».
    if Enum.TooltipDataType.UnitAura then
        -- окрема галочка «Бафи і дебафи» (до 07.10.2026 її не читав ніхто)
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.UnitAura, function(tooltip, data)
            if ns.IsEnabled("auras") then return TranslateSpellTooltip(tooltip, data, true) end
        end)
    end
    ns.spellHooksRegistered = true
else
    ns.spellHooksRegistered = false
end

-- МАУНТ-ТУЛТІП (Колекції→Маунти + панель дій): це ОКРЕМИЙ від Spell тип, тому
-- TranslateSpellTooltip для нього не спрацьовував (ні ім'я «Invincible», ні опис).
-- Будується через GameTooltip:SetMountBySpellID(spellID) — повний тултіп СИНХРОННО
-- (ім'я+опис відразу, без пізнього доданку). Хукаємо його (і тип даних Mount, якщо є)
-- і женемо через ту саму TranslateSpellTooltip: ім'я — з ns.mountsByName, опис — через
-- RenderDescription за spellID. Один метод покриває і Колекції, і панель дій.
if TooltipDataProcessor and Enum.TooltipDataType and Enum.TooltipDataType.Mount then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Mount, TranslateSpellTooltip)
end
if GameTooltip and type(GameTooltip.SetMountBySpellID) == "function" then
    hooksecurefunc(GameTooltip, "SetMountBySpellID", function(self, spellID)
        ns.Guard("закляття", TranslateSpellTooltip, self, { id = spellID })
    end)
end

-- МАКРОС «#showtooltip <закляття>» (07.10.2026, перенесено з Forever): гра показує підказку
-- закляття, але тип даних — Macro, тож пост-обробники Spell її не бачили, і назва з
-- описом лишались англійськими. spellID — з підказки (GetSpell) або зі слота кнопки:
-- GetActionInfo(slot) → "macro" → GetMacroSpell. Виклик — у pcall: у бою значення secret.
local function MacroSpellID(tooltip, slot)
    local ok, _, sid = pcall(tooltip.GetSpell, tooltip)
    if ok and sid then return sid end
    if not slot then
        local owner = tooltip.GetOwner and tooltip:GetOwner()
        slot = type(owner) == "table" and owner.action or nil
    end
    if not slot then return nil end
    local atype, id, sub = GetActionInfo(slot)
    if atype ~= "macro" then return nil end
    local msid = GetMacroSpell and GetMacroSpell(id)
    if msid then return msid end
    if sub == "spell" then return id end           -- деякі клієнти дають тут уже spellID
end
ns.MacroSpellID = MacroSpellID
if TooltipDataProcessor and Enum.TooltipDataType and Enum.TooltipDataType.Macro then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Macro, function(tooltip, data)
        if tooltip ~= GameTooltip then return end
        local ok, sid = pcall(MacroSpellID, tooltip)
        if ok and sid then
            ns.Guard("закляття", TranslateSpellTooltip, tooltip,
                  { id = sid, lines = type(data) == "table" and data.lines or nil })
        end
    end)
end

-- НАДІЙНИЙ шлях для бафів/дебафів на панелі (BuffFrame.AuraContainer): якщо тип
-- тултіпа UnitAura відсутній/не спрацьовує, аури все одно йдуть через методи
-- GameTooltip:SetUnit(Buff|Debuff|Aura)[ByAuraInstanceID]. Хукаємо їх (пост-виклик,
-- без тейнту), дістаємо spellID аури й кличемо ту саму TranslateSpellTooltip.
local CUA = C_UnitAuras
local function TranslateAura(tooltip, spellID)
    if spellID and tooltip then ns.Guard("закляття", TranslateSpellTooltip, tooltip, { id = spellID }) end
end
if GameTooltip and CUA then
    if type(GameTooltip.SetUnitBuffByAuraInstanceID) == "function" and CUA.GetAuraDataByAuraInstanceID then
        hooksecurefunc(GameTooltip, "SetUnitBuffByAuraInstanceID", function(self, unit, id)
            local a = CUA.GetAuraDataByAuraInstanceID(unit, id)
            TranslateAura(self, a and a.spellId)
        end)
        hooksecurefunc(GameTooltip, "SetUnitDebuffByAuraInstanceID", function(self, unit, id)
            local a = CUA.GetAuraDataByAuraInstanceID(unit, id)
            TranslateAura(self, a and a.spellId)
        end)
    end
    if type(GameTooltip.SetUnitBuff) == "function" and CUA.GetAuraDataByIndex then
        hooksecurefunc(GameTooltip, "SetUnitBuff", function(self, unit, idx, filter)
            local a = CUA.GetAuraDataByIndex(unit, idx, filter or "HELPFUL")
            TranslateAura(self, a and a.spellId)
        end)
        hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self, unit, idx, filter)
            local a = CUA.GetAuraDataByIndex(unit, idx, filter or "HARMFUL")
            TranslateAura(self, a and a.spellId)
        end)
    end
end

-- Тултіп маунта/улюбленця на ПАНЕЛЯХ ДІЙ: кнопка дії (SetAction) не завжди дає
-- spellID (виклик маунта — особлива дія/макрос), тож основний хук виходить рано.
-- Тут проходимо рядки тултіпа і перекладаємо: НАЗВУ (мапи колекцій, +оригінал) і
-- сталі ЯРЛИКИ/речення (без оригіналу). Summon-опис «Summons and dismisses <назва>»
-- лишається англ. — це окремий датасет описів заклять, якого в нас нема.
local MOUNT_TT = {
    ["Warband Mount"] = "Маунт загону",
    ["Account Mount"] = "Маунт акаунта",
    ["Flying"] = "Літаючий", ["Ground"] = "Наземний",
    ["Aquatic"] = "Водний", ["Underwater"] = "Підводний",
    ["Underwater Mount"] = "Підводний маунт",
    ["Summons and dismisses this mount."] = "Прикликає та відкликає цього маунта.",
    ["This mount changes depending on your Riding skill and location."] =
        "Цей маунт змінюється залежно від вашого вміння їзди та місцевості.",
    ["This mount can use Ride Along."] =
        "Цей маунт може використовувати «Спільну поїздку».",
}
local function TranslateMountLine(fs, isName)
    local original = fs and ns.SafeText(fs:GetText())
    if not original or original == "" or ns.HasCyrillic(original) then return false end
    local label = MOUNT_TT[original]
    -- ns.mountDescriptions: флейвор-опис маунта (з wago DB2, точний збіг рядка).
    -- НЕ isName (опис — не перший рядок); показуємо ЛИШЕ переклад (без «(ориг.)»).
    local desc = (not isName) and ns.mountDescriptions and ns.mountDescriptions[original]
    local ua = label or desc
                     or (isName and ((ns.mountsByName and ns.mountsByName[original])
                                  or (ns.petsByName and ns.petsByName[original])))
    if not ua or original:find(ua, 1, true) then return false end
    local r, g, b = fs:GetTextColor()
    -- назва: укр + оригінал сірим (звірка з гайдами); ярлик/опис/речення: тільки укр
    local shown = (label or desc) and ua or (ua .. " |cff808080(" .. original .. ")|r")
    fs:SetText(shown)
    if r then fs:SetTextColor(r, g, b) end
    ns.Remember(fs, original, shown, nil, "spells.name")
    return true
end
local function TranslateMountTooltip(tt)
    if not tt or ns.ShowOriginal() or not ns.IsEnabled("spells.name") then return end
    local nm = tt.GetName and tt:GetName()
    if not nm then return end
    local changed = false
    for i = 1, (tt.NumLines and tt:NumLines() or 0) do
        if TranslateMountLine(_G[nm .. "TextLeft" .. i], i == 1) then changed = true end
        if TranslateMountLine(_G[nm .. "TextRight" .. i], false) then changed = true end
    end
    if changed then tt:Show() end
end
-- ОБХІД secret-блокування в бою на кулдауні: дані тултіпа засекречені (spellID і
-- текст нечитабельні), тож НАЗВУ беремо не з тултіпа, а зі СЛОТА панелі дій —
-- GetActionInfo(slot) (інший API, зазвичай не secret). Якщо назву ще не переклав
-- основний шлях (рядок не кирилиця) — форсуємо UA-назву з нашої бази.
local function TranslateActionSpellName(tt, slot)
    if not slot or ns.ShowOriginal() or not ns.IsEnabled("spells.name") then return end
    local ok, atype, id = pcall(GetActionInfo, slot)
    if ok and atype == "macro" then                 -- макрос «#showtooltip»: його закляття
        local okm, msid = pcall(MacroSpellID, tt, slot)
        atype, id = "spell", okm and msid or nil
    end
    if not ok or atype ~= "spell" or not id then return end
    local okn, ua = pcall(function() return ns.spells and ns.spells[id] end)
    if not okn or not ua then return end
    local nm = tt.GetName and tt:GetName()
    local nameLine = nm and _G[nm .. "TextLeft1"]
    if not nameLine then return end
    local orig = ns.SafeText(nameLine:GetText())   -- nil якщо secret
    -- якщо вже кирилиця (основний шлях переклав) — нічого не робимо
    if orig and ns.HasCyrillic(orig) then return end
    local shown = orig and (ua .. " |cff808080(" .. orig .. ")|r") or ua  -- без ориг., якщо secret
    local r, g, b = nameLine:GetTextColor()
    nameLine:SetText(shown)
    if r then nameLine:SetTextColor(r, g, b) end
    if orig then ns.Remember(nameLine, orig, shown, nil, "spells.name") end
    tt:Show()
end
if GameTooltip and type(GameTooltip.SetAction) == "function" then
    hooksecurefunc(GameTooltip, "SetAction", function(self, slot)
        TranslateMountTooltip(self)
        ns.Guard("закляття", TranslateActionSpellName, self, slot)
    end)
end

-- ОПИС МАСТЕРІЯ у тултіпі стата (панель персонажа → «Підсилення»): переклад цього
-- опису ВЖЕ Є в descTemplates (це опис мастерія-спела з $-токенами), АЛЕ стат-тултіп
-- будується НЕ як Spell-тултіп → RenderDescription сам не викликається. Дістаємо
-- мастерія-спелID гравця й рендеримо довгі рядки опису за текстом (числа=динамічні,
-- MatchAndFill підставляє живі). Нічого НЕ перекладаємо наново — лише застосовуємо
-- наявний шаблон. Гейт: лише поки відкрита панель статів (без глобального оверхеду).
local function MasterySpellIDs()
    local ids = {}
    local spec = GetSpecialization and GetSpecialization()
    if spec and GetSpecializationMasterySpells then
        local ok, a, b = pcall(GetSpecializationMasterySpells, spec)
        if ok then
            if a then ids[#ids + 1] = a end
            if b then ids[#ids + 1] = b end
        end
    end
    return ids
end
-- ОПИСИ ІНШИХ СТАТІВ (Крит/Витрив./Сила/Броня…): не спели, а глобалки стат-тултіпів.
-- СТАТИЧНІ («Chance for extra effectiveness…») є в ns.uiTooltips точним ключем.
-- ДИНАМІЧНІ з живим числом («Increases Health by 413,920», рядок «Critical Strike:
-- 861 [+18.72%]») захоплено з ІНШИМ числом → точний збіг падає. Тому ЧИСЛО-
-- НОРМАЛІЗОВАНИЙ збіг: усі числа→маркер, знаходимо шаблон, підставляємо ЖИВІ числа
-- позиційно в UA. Індекс будуємо раз (лише де к-сть чисел en==ua). Контент не чіпаємо.
local statNumIdx
local function StatNumNorm(s)
    return (s:gsub("%d[%d,%.]*", "\1"))
end
local function StatDescTry(text)
    if not (ns.uiTooltips and text) then return nil end
    local ua = ns.uiTooltips[text]
    if ua then return ua end
    -- кольорові рядки стат-тултіпа (жовтий «Physical Damage Reduction…», сірий
    -- «(Against an evenly matched enemy)») мають |cff…|r / |T|A — знімаємо перед
    -- пошуком, бо ключ у базі БЕЗ розмітки (заголовок білий збігався, а ці — ні).
    local clean = text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|c%x+", ""):gsub("|r", "")
                      :gsub("|T.-|t", ""):gsub("|A.-|a", "")
                      :gsub("^%s+", ""):gsub("%s+$", "")
    if clean ~= text then
        ua = ns.uiTooltips[clean]
        if ua then return ua end
        text = clean
    end
    if not text:find("%d") then return nil end
    -- Кольор-коди |cXXXXXXXX містять hex-ЦИФРИ (напр. |cff888888) — вони НЕ дані стата,
    -- тож при рахунку/нормалізації/підстановці чисел їх ІГНОРУЄМО, а в результаті
    -- ЗБЕРІГАЄМО (щоб сіра «(Проти…)» лишалась сірою, як в оригіналі).
    local function stripCC(s) return (s:gsub("|c%x+", ""):gsub("|r", "")) end
    if not statNumIdx then
        -- ПОВНИЙ прохід по ns.uiTooltips із чотирма gsub на запис, СИНХРОННО в
        -- момент першого показу тултіпа. Словник виріс 6961 -> 11517, тож ціна
        -- цієї побудови зросла разом із ним — вимірюємо, перш ніж лагодити.
        ns.Prof("індекс статів (1 раз)", function()
        statNumIdx = {}
        for k, v in pairs(ns.uiTooltips) do
            if type(k) == "string" and type(v) == "string" and k:find("%d") then
                local ne = select(2, stripCC(k):gsub("%d[%d,%.]*", ""))
                local nu = select(2, stripCC(v):gsub("%d[%d,%.]*", ""))
                if ne == nu and ne > 0 then
                    local nk = StatNumNorm(stripCC(k))
                    if not statNumIdx[nk] then statNumIdx[nk] = v end
                end
            end
        end
        end)
    end
    local tmpl = statNumIdx[StatNumNorm(stripCC(text))]
    if not tmpl then return nil end
    -- ЖИВІ числа з text (без кольор-кодів)
    local nums = {}
    for num in stripCC(text):gmatch("%d[%d,%.]*") do nums[#nums + 1] = num end
    -- захистити кольор-коди від число-заміни (маркер \30 — без цифр), тоді підставити
    -- живі числа, тоді відновити коди по порядку.
    local codes = {}
    local out = tmpl:gsub("|c%x+", function(c) codes[#codes + 1] = c; return "\30" end)
    local i = 0
    out = out:gsub("%d[%d,%.]*", function() i = i + 1; return nums[i] or "" end)
    local j = 0
    out = out:gsub("\30", function() j = j + 1; return codes[j] or "" end)
    return out
end

local function TranslateStatTooltip(tt)
    if tt ~= GameTooltip then return end
    if not (CharacterStatsPane and CharacterStatsPane.IsShown and CharacterStatsPane:IsShown()) then return end
    if ns.ShowOriginal() then return end
    -- ЛИШЕ стат-тултіпи: у вікні персонажа є й слоти спорядження — на ПРЕДМЕТ/ЮНІТ
    -- цей хендлер (і білий заголовок) НЕ чіпаємо (зламав би кольори якості предметів).
    if tt.GetItem then local ok, _, lnk = pcall(tt.GetItem, tt); if ok and lnk then return end end
    if tt.GetUnit then local ok, _, u = pcall(tt.GetUnit, tt); if ok and u then return end end
    local masteryIDs = MasterySpellIDs()
    local wantDesc = ns.IsEnabled and ns.IsEnabled("spells.description")
    local wantUI = ns.IsEnabled and ns.IsEnabled("interface.menu")
    local changed = false
    for i = 2, (tt.NumLines and tt:NumLines() or 0) do
        local fs = _G["GameTooltipTextLeft" .. i]
        local text = fs and ns.SafeText(fs:GetText())
        if text and #text > 6 and not ns.HasCyrillic(text) then
            local ua
            -- 1) мастерія-опис через спел-шаблон (RenderDescription)
            if wantDesc and ns.RenderDescription and #text > 25 then
                for _, sid in ipairs(masteryIDs) do
                    ua = ns.RenderDescription(sid, (text:gsub("\r\n", "\n")))
                    if ua then break end
                end
            end
            -- 2) статичні/динамічні описи стат-глобалок (uiTooltips + число-норм)
            if not ua and wantUI then ua = StatDescTry(text) end
            if ua and ua ~= text then
                local r, g, b = fs:GetTextColor()
                if ns.Remember then ns.Remember(fs, text, ua, nil, "interface.menu") end
                fs:SetText(ua)
                if r then fs:SetTextColor(r, g, b) end
                changed = true
            end
        end
    end
    -- ЗАГОЛОВОК стат-тултіпа (назва: «Haste», «Armor 2,052») у грі БІЛИЙ, але наш
    -- переклад заголовка (через загальний хук) інколи виходив жовтим. Якщо рядок 1
    -- уже наш (кириличний) — примусово білий, як в оригіналі. Під Shift (англ.) не чіпаємо.
    local title = _G["GameTooltipTextLeft1"]
    if title and title.SetTextColor and title.GetText then
        local t = ns.SafeText(title:GetText())
        if t and ns.HasCyrillic(t) then title:SetTextColor(1, 1, 1) end
    end
    if changed and tt.Show then tt:Show() end
end
if GameTooltip and GameTooltip.Show then
    hooksecurefunc(GameTooltip, "Show", TranslateStatTooltip)
end

-- РЕЦЕПТ-ТОСТ (popup при вивченні рецепту професії) — зміряно /fstack: AlertFrame
-- (AlertFrames.lua) із FontString .Name; SetUp передає recipeID (спел-ID рецепту) →
-- укр. назву беремо з ns.spells[id]. hooksecurefunc (пост-виклик) override-ить англ.
if type(_G.NewRecipeLearnedAlertFrame_SetUp) == "function" then
    hooksecurefunc("NewRecipeLearnedAlertFrame_SetUp", function(frame, recipeID)
        if ns.ShowOriginal and ns.ShowOriginal() then return end
        if not ns.IsEnabled("spells.name") then return end
        local fs = frame and frame.Name
        local ua = recipeID and ns.spells and ns.spells[tonumber(recipeID)]
        if fs and type(fs.GetText) == "function" and ua then
            local en = ns.SafeText(fs:GetText())
            if en and en ~= ua then
                if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.menu") end
                fs:SetText(ua)
            end
        end
    end)
end
