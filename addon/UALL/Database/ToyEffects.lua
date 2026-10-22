-- WoWUkraine: переклади ЕФЕКТІВ іграшок (рядок «Use:» у тултіпі Скрині).
-- Ключ = itemID; {en, ua} — шаблони опису (з $-токенами там, де гра підставляє
-- живі числа). Показ: ToyBoxHooks через ns.RenderTemplate. УЗГОДЖЕНО пакетами
-- (назва+флейвор+ефект разом). Автоген.
local _, ns = ...
ns.toyEffects = ns.toyEffects or {}
local t = ns.toyEffects
t[1973] = { en = "Transforms caster to look like a member of the opposing faction for 5 min.", ua = "Обертає на представника ворожої фракції на 5 хв." }
t[13379] = { en = "Play to invoke the spirit of dance in those around you.", ua = "Грай, щоб пробудити дух танцю в тих, хто поруч." }
t[17712] = { en = "Change yourself into something more befitting the wintry season.  Requires a Snowball to use.", ua = "Перетворися на щось доречніше зимовій порі.  Для використання потрібна сніжка." }
t[17716] = { en = "Allows an experienced engineer to turn water into a snowball.\n\nCooldown reduced during Feast of Winter Veil.", ua = "Дозволяє досвідченому інженеру перетворювати воду на сніжку.\n\nПерезарядження скорочене під час Свята Зимової Завіси." }
t[18660] = { en = "Enlarges the entire world for $d or until you attack.", ua = "Збільшує весь світ на $d або доки ти не атакуєш." }
t[18984] = { en = "Rips the dimensional walls asunder and transports you to Everlook in Winterspring.   There are technical problems that sometimes occur, but that's what Goblin Engineering is all about!", ua = "Роздирає стіни вимірів і переносить тебе до Евірлука у Вічнозим'ї.   Часом трапляються технічні негаразди, але ж у цьому вся суть ґоблінської інженерії!" }
t[18986] = { en = "Safely transport yourself to Gadgetzan in Tanaris!    Emphasis on Safe!   Yup, nothing bad could ever happen while using this device!", ua = "Безпечно перенесися до Ґаджетзана в Танарісі!    Наголос на слові «Безпечно»!   Ага, нічогісінько поганого не може статися, поки користуєшся цим пристроєм!" }
t[21540] = { en = "Create an Elune Stone.  Requires a Solid Stone.", ua = "Створює Камінь Елуни. Потребує Суцільний Камінь." }
t[23767] = { en = "Summon a robot pet that will fight other fighting robots.", ua = "Приклич улюбленця-робота, який битиметься з іншими бойовими роботами." }
t[30542] = { en = "Rips the dimensional walls asunder and transports you to Area 52 in Netherstorm.   There are technical problems that sometimes occur, but that's what Goblin Engineering is all about!", ua = "Роздирає стіни вимірів і переносить тебе до Зони 52 в Нетерштормі.   Часом трапляються технічні негаразди, але ж у цьому вся суть ґоблінської інженерії!" }
t[30544] = { en = "Safely transport yourself to Toshley's Station in Blade's Edge!    Nothing to worry about while using this baby!   Gnomish know-how will get you there in a safe and timely fashion!", ua = "Безпечно перенесися до Станції Тошлі в Лезі Клинка!    Нема про що хвилюватися, поки користуєшся цією крихіткою!   Ґномське ноу-хау доправить тебе на місце безпечно й вчасно!" }
t[30690] = { en = "Destroys technological terror constructs.", ua = "Знищує технологічні конструкти жаху." }
t[32542] = { en = "Ask a question, then right click to receive your answer!", ua = "Постав запитання, а тоді клацни правою кнопкою, щоб отримати відповідь!" }
t[32566] = { en = "Set up a relaxing little picnic.", ua = "Влаштуй затишний невеличкий пікнік." }
t[32782] = { en = "Transforms caster to have the appearance of a Skettis arakkoa.", ua = "Обертає на араккоа зі Скеттіса." }
t[33079] = { en = "It's a murloc costume.", ua = "Це костюм мурлока." }
t[33219] = { en = "Create a kettle of spicy Goblin Gumbo.\n\n\n\nGoblin Gumbo disappears if logged out for more than 15 minutes.", ua = "Створює казанок гострого ґоблінського гамбо.\n\n\n\nҐоблінське гамбо зникає, якщо вийти з гри більш ніж на 15 хвилин." }
t[33223] = { en = "Set up a comfy fishing chair.", ua = "Постав зручний рибальський стілець." }
t[33927] = { en = "Tap a pony keg of delicious Brewfest Brew.\n\n\n\nBrewfest Brew disappears if logged out for more than 15 minutes.", ua = "Відкоркуй барильце смачного пива Хмільного свята.\n\n\n\nПиво Хмільного свята зникає, якщо вийти з гри більш ніж на 15 хвилин." }
t[34480] = { en = "Set up a romantic picnic.", ua = "Влаштуй романтичний пікнік." }
t[34499] = { en = "Build a paper gyrocopter.", ua = "Збудуй паперовий гіроплан." }
t[34686] = { en = "Place your Brazier of Dancing Flames.", ua = "Постав свою Жаровню Танцівливого Полум'я." }
t[35227] = { en = "Activate your Personal Weather Maker.", ua = "Активуй свій Персональний Погодотворець." }
t[35275] = { en = "Disguise yourself as a Blood Elf for a short period of time.", ua = "Перекинься на ельфа крові на короткий час." }
t[36862] = { en = "Rolls a pair of dice. Hope you get lucky!", ua = "Кидає пару костей. Хай тобі пощастить!" }
t[36863] = { en = "Rolls a pair of dice.", ua = "Кидає пару костей." }
t[37254] = { en = "Go wild in a bubble for $d.", ua = "Побешкетуй у бульбашці $d." }
t[37460] = { en = "Guide your companion pet with a rope leash.", ua = "Веди свого улюбленця на мотузяному повідці." }
t[37710] = { en = "Summon and control your Crashin' Thrashin' Racer.", ua = "Приклич свій Трощо-Громовий Гонщик і керуй ним." }
t[38301] = { en = "Start the dance party.", ua = "Розпочни танцювальну вечірку." }
t[38578] = { en = "Place a flag on an enemy player's corpse in front of you.", ua = "Постав прапорець на труп ворожого гравця перед собою." }
t[40727] = { en = "Temporarily reverse your gravity. Only works out of combat and in areas where you can fly with a flying mount.", ua = "Тимчасово оберни свою гравітацію. Діє лише поза боєм і в місцях, де можна літати на їздовій тварині." }
t[40768] = { en = "Creates a portable mailbox for $d.", ua = "Створює переносну поштову скриньку на $d." }
t[40895] = { en = "Allows you to see players without clothing and armor.", ua = "Дозволяє тобі бачити гравців без одягу та броні." }
t[43499] = { en = "Assume the form of an Iron Dwarf for $d.", ua = "Прийми подобу залізного дворфа на $d." }
t[43824] = { en = "Teleports the caster to and from the spires atop the Violet Citadel.  This spell only works in the City of Dalaran.", ua = "Телепортує до шпилів на вершині Фіолетової Цитаделі й назад. Це закляття діє лише в місті Даларан." }
t[44430] = { en = "Toss your luck!", ua = "Підкинь свою удачу!" }
t[44606] = { en = "Set down your Toy Train Set.", ua = "Постав свою Іграшкову залізницю." }
t[44719] = { en = "Brings out the Wolvar in you!", ua = "Пробуджує вольвара в тобі!" }
t[44820] = { en = "Guide your companion pet with a red ribbon pet leash.", ua = "Веди свого улюбленця на повідці з червоної стрічки." }
t[45011] = { en = "Plant your Stormwind banner.", ua = "Встанови свій прапор Стормвінда." }
t[45013] = { en = "Plant your Thunder Bluff banner.", ua = "Встанови свій прапор Тандер Блафа." }
t[45014] = { en = "Plant your Orgrimmar banner.", ua = "Встанови свій прапор Оґриммара." }
t[45015] = { en = "Plant your Sen'jin banner.", ua = "Встанови свій прапор Сен'джину." }
t[45016] = { en = "Plant your Undercity banner.", ua = "Встанови свій прапор Андерсіті." }
t[45017] = { en = "Plant your Silvermoon City banner.", ua = "Встанови свій прапор Сільвермуна." }
t[45018] = { en = "Plant your Ironforge banner.", ua = "Встанови свій прапор Айронфорджа." }
t[45019] = { en = "Plant your Gnomeregan banner.", ua = "Встанови свій прапор Гномрегану." }
t[45020] = { en = "Plant your Exodar banner.", ua = "Встанови свій прапор Екзодара." }
t[45021] = { en = "Plant your Darnassus banner.", ua = "Встанови свій прапор Дарнасуса." }
t[45057] = { en = "Set down a wind-up train wrecker.", ua = "Постав заводного руйнівника потягів." }
t[45063] = { en = "Place a Foam Sword Rack.\n\n\n\nFoam Swords disappear if logged out for more than 15 minutes.", ua = "Постав Стійку з поролоновими мечами.\n\n\n\nПоролонові мечі зникають, якщо вийти з гри більш ніж на 15 хвилин." }
t[45984] = { en = "Point the compass!", ua = "Наведи компас!" }
t[46709] = { en = "Summon and control your MiniZep!", ua = "Приклич свій Мінізеп і керуй ним!" }
t[46780] = { en = "Places a candy-filled Ogre Pinata.", ua = "Ставить оґрську піньяту, повну цукерок." }
t[46843] = { en = "Plant your Argent Crusader's Banner.", ua = "Встанови свій Прапор Срібного Хрестоносця." }
t[48933] = { en = "Creates an unstable wormhole the Engineer can use to travel around Northrend.  Lasts $d.", ua = "Створює нестабільну червоточину, якою інженер може подорожувати Нортрендом. Триває $d." }
t[49703] = { en = "Shoots a firework into the air that bursts into a thousand purple stars.", ua = "Запускає в небо феєрверк, що вибухає тисячею фіолетових зірок." }
t[49704] = { en = "Become a hulking red ogre for $d!", ua = "Стань здоровенним червоним оґром на $d!" }
t[50471] = { en = "This strange experimental device was meant to burst the target's chest cavity in a spray of hot gore. Instead, it induces a brief but pitiful display of miserable, wracking sobs.", ua = "Цей дивний експериментальний пристрій мав розірвати грудну клітку цілі бризками гарячих нутрощів. Натомість він викликає короткий, але жалюгідний напад нещасних, надривних ридань." }
t[52201] = { en = "Assume the form of a Frost Dwarf for $d.", ua = "Прийми подобу морозного дворфа на $d." }
t[52253] = { en = "Summons Sylvanas's Lamenters.", ua = "Прикликає Плакальників Сильвани." }
t[53057] = { en = "Relive your days as an apprentice.", ua = "Переживи знову свої дні учнівства." }
t[54212] = { en = "Become a heroic statue of yourself.", ua = "Стань власною героїчною статуєю." }
t[54343] = { en = "Summon and control your Crashin' Thrashin' Racer.", ua = "Приклич свій Трощо-Громовий Гонщик і керуй ним." }
t[54437] = { en = "Place a Tiny Green Ragdoll.", ua = "Постав Крихітну зелену ганчір'яну ляльку." }
t[54438] = { en = "Place a Tiny Blue Ragdoll.", ua = "Постав Крихітну синю ганчір'яну ляльку." }
t[54452] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[54651] = { en = "Transform into Gnomeregan Infantry.", ua = "Обернися на піхотинця Гномрегану." }
t[54653] = { en = "Transform into a Darkspear Warrior.", ua = "Обернися на воїна Темного Списа." }
t[60854] = { en = "Retrieves the loot from a nearby corpse.", ua = "Забирає здобич із трупа поблизу." }
t[63141] = { en = "Set down your Tol Barad Searchlight.", ua = "Постав свій Прожектор Тол Барада." }
t[63269] = { en = "Rolls a pair of dice. You know you'll get lucky!", ua = "Кидає пару костей. Ти ж знаєш, що тобі пощастить!" }
t[64358] = { en = "Look into the mirror...", ua = "Зазирни в дзеркало..." }
t[64361] = { en = "Summon a Fountain of Knowledge.", ua = "Приклич Фонтан Знань." }
t[64373] = { en = "Witness a historic sword dance.", ua = "Стань свідком історичного танцю з мечами." }
t[64383] = { en = "Hold the chimes up to the wind and check the weather.", ua = "Підніми дзвіночки на вітер і перевір погоду." }
t[64456] = { en = "Witness a recording of the arrival of the naaru.", ua = "Побач запис прибуття наару." }
t[64457] = { en = "Teleports you exactly where you want to go... if you aren't too picky.", ua = "Телепортує саме туди, куди хочеш... якщо не бути надто прискіпливим." }
t[64481] = { en = "Receive the Blessing of the Old God for $d.", ua = "Прийми Благословення Древнього Бога на $d." }
t[64482] = { en = "Make a vain attempt to open the puzzle box.", ua = "Марно спробуй відкрити головоломну скриньку." }
t[64488] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[64646] = { en = "Endure the transformation for $d.", ua = "Витримай перетворення протягом $d." }
t[64651] = { en = "Take on wisp form for $d.", ua = "Прибери на $d подобу вогника." }
t[64881] = { en = "Summons a storm of peaceful scarabs.", ua = "Прикликає бурю мирних скарабеїв." }
t[64997] = { en = "Set down your Tol Barad Searchlight.", ua = "Постав свій Прожектор Тол Барада." }
t[66888] = { en = "Transforms you into a Furbolg for $d.", ua = "Обертає тебе на фурболга на $d." }
t[67097] = { en = "Builds a grim campfire that isn't going to increase anyone's spirit. In fact, it may creep them out a bit. It does allow cooking, though.", ua = "Розкладає похмуре багаття, яке нікому не додасть настрою. Насправді воно може навіть трохи лякати. Утім, на ньому можна готувати." }
t[68806] = { en = "Invite the spirit of Kalytha to overtake you.", ua = "Запроси дух Каліти оволодіти тобою." }
t[69215] = { en = "Build a War Party Hitching Post.\n\n\n\nParty or raid members with at least Apprentice Riding may use the post to summon a Hitch Horse mount.", ua = "Збудуй Конов'язь бойового загону.\n\n\n\nЧлени групи або рейду з верховою їздою хоча б рівня учня можуть скористатися конов'яззю, щоб прикликати їздового коня." }
t[69227] = { en = "Place a node of Fool's Gold.\n\n\n\nPlayers may use the node to summon temporary Greedy Kobold non-combat pets.", ua = "Постав поклад котячого золота.\n\n\n\nГравці можуть скористатися покладом, щоб прикликати тимчасових небойових улюбленців — Жадібних кобольдів." }
t[69775] = { en = "Quaff of the Vrykul Drinking Horn.", ua = "Хильни з Питного рогу врикулів." }
t[69776] = { en = "Become trapped in amber.", ua = "Застрягни в бурштині." }
t[69777] = { en = "Place and listen to a Haunted War Drum.", ua = "Постав Примарний бойовий барабан і послухай його." }
t[69895] = { en = "Summon a green balloon.", ua = "Приклич зелену повітряну кульку." }
t[69896] = { en = "Summon a yellow balloon.", ua = "Приклич жовту повітряну кульку." }
t[70159] = { en = "Mylune's Call.", ua = "Поклик Майлуни." }
t[70161] = { en = "Set up a mushroom chair.", ua = "Постав грибний стілець." }
t[70722] = { en = "Builds a little burning wickerman that increases the spirits of those nearby by $7353s1 and allows cooking.", ua = "Розкладає невеликого палаючого плетеного чоловічка, що піднімає настрій присутнім поряд на $7353s1 і дозволяє готувати." }
t[71137] = { en = "Summon a beer-toting Keg Pony for $d.", ua = "Приклич поні з барильцем пива на $d." }
t[71259] = { en = "Release the memories contained within the locket.", ua = "Вивільни спогади, що зберігаються в медальйоні." }
t[71628] = { en = "Create $s1 Throwing Starfish.", ua = "Створює $s1 метальних морських зірок." }
t[72159] = { en = "Become a red ogre mage for $d.", ua = "Стань червоним оґром-магом на $d." }
t[72161] = { en = "Climb into a sarcophagus for $d.", ua = "Залізь у саркофаг на $d." }
t[75042] = { en = "Summon and dismiss your yellow balloon.", ua = "Приклич і відпусти свою жовту повітряну кульку." }
t[79769] = { en = "Resemble a demon hunter for $d.", ua = "Прибери подобу мисливця на демонів на $d." }
t[80822] = { en = "Throw The Golden Banana.", ua = "Кинь Золотий Банан." }
t[82467] = { en = "Summon Ruthers, the bad yak.", ua = "Приклич Рутерса, поганого яка." }
t[85500] = { en = "You can raft across water. Requires Revered with The Anglers and a Pandaria Fishing skill of 1.", ua = "Ти можеш переправлятися через воду на плоту. Потребує репутації «Шанований» у Рибалок і 1 рівня рибальства Пандарії." }
t[85973] = { en = "Attach the charm to yourself, granting you a chance to find additional fish from pools in Pandaria for $d. Requires Fishing Skill of 1.", ua = "Причепи талісман до себе, даючи шанс знаходити додаткову рибу з водойм у Пандарії на $d. Потребує навички риболовлі 1." }
t[86565] = { en = "Blast a blaring horn, attracting enemies within $A1 yards. Ineffective on targets above level $ctrmax2067 or not native to Pandaria.", ua = "Засурми в гучний ріг, що приваблює ворогів у межах $A1 ярдів. Неефективно проти цілей, вищих за рівень $ctrmax2067 або не родом із Пандарії." }
t[86568] = { en = "Release the memories of a long-lost first mate.", ua = "Вивільни спогади давно зниклого першого помічника." }
t[86571] = { en = "Become infused with stone, granting a chance upon killing an opponent to encase them in stone.", ua = "Насичся каменем, здобувши шанс при вбивстві супротивника закувати його в камінь." }
t[86573] = { en = "Transform into a Mogu statue, becoming untargetable for $d.", ua = "Обернися на статую моґу, і тебе не можна буде обрати ціллю на $d." }
t[86575] = { en = "Give in to your anger for $d. While active, the next killing blow made against a player will transform you into a Mogu for $127263d, preventing any actions from being taken while you gloat.", ua = "Піддайся гніву на $d. Поки триває, наступний смертельний удар по гравцеві перетворить тебе на моґу на $127263d, унеможливлюючи будь-які дії, поки ти зловтішаєшся." }
t[86578] = { en = "Restores $s1% of health and mana every $t1 sec. for $d. Any damage taken will remove the frenzy. Can only be used in Pandaria.", ua = "Відновлює $s1% здоров'я та мани кожні $t1 с протягом $d. Будь-яка отримана шкода знімає шал. Можна використати лише в Пандарії." }
t[86581] = { en = "Allows you to see far into the distance and grants the ability to create small water droplets.", ua = "Дозволяє тобі бачити далеко вдалину й дає здатність створювати дрібні краплі води." }
t[86582] = { en = "Increases swim speed by $s1% and allows underwater breathing for $d. Only usable on Pandaria.", ua = "Збільшує швидкість плавання на $s1% і дозволяє дихати під водою протягом $d. Можна використати лише в Пандарії." }
t[86583] = { en = "Blend into the shadows for $d and summon a Salyin Warscout. The Warscout will draw the attention of nearby monsters and run into the distance. Only effective in Pandaria.", ua = "Розчинися в тінях на $d і приклич салійського розвідника. Розвідник приверне увагу ближніх монстрів і побіжить удалину. Діє лише в Пандарії." }
t[86584] = { en = "Throw a hard shell, dismounting the target. Unusable on targets above level $ctrmax2067.", ua = "Кинь твердий панцир, скидаючи ціль з їздової тварини. Не діє на цілі понад рівень $ctrmax2067." }
t[86586] = { en = "Play the panflute, causing nearby critters to follow you for $d.", ua = "Заграй на флейті Пана, і дрібні звірята поблизу йтимуть за тобою протягом $d." }
t[86588] = { en = "Set up a dazzling firework display.", ua = "Влаштуй сліпучий феєрверк." }
t[86589] = { en = "Take on the slightly shimmery appearance of the target for $127315d.", ua = "Прибери на $127315d ледь мерехтливий вигляд цілі." }
t[86590] = { en = "Unleash a gentle breeze, lightening your steps. This effect only works in Pandaria.", ua = "Вивільни легкий вітерець, що полегшить твою ходу. Цей ефект діє лише в Пандарії." }
t[86593] = { en = "Get ready for fun in the sun!", ua = "Приготуйся до розваг під сонцем!" }
t[86594] = { en = "Calls Helpful Wikky, who will forage for you and bring back presents. Can only be used in Pandaria.", ua = "Прикликає Послужливого Віккі, який шукатиме для тебе харчі й приноситиме дарунки. Можна використати лише в Пандарії." }
t[86596] = { en = "Set up a comfy fishing chair.", ua = "Постав зручний рибальський стілець." }
t[87214] = { en = "Assembles the incredible Blingtron 4000, a robot of infinite wealth.  Bling, as he likes to be called, will give out a random gift to anyone who talks to him, but only once per day.  Lasts 10 min.", ua = "Збирає неймовірного Блінгтрона 4000, робота безмежного багатства.  Блінг, як він любить, щоб його називали, видасть випадковий подарунок кожному, хто з ним заговорить, але лише раз на день.  Триває 10 хв." }
t[87215] = { en = "Teleports you to somewhere in Pandaria.  The exact location is difficult to predict, but will likely be far away.", ua = "Телепортує тебе кудись у Пандарію. Точне місце передбачити важко, але воно, найпевніше, буде далеко." }
t[87528] = { en = "Display a Brewmaster Keg on your back.", ua = "Розміщує барило пивовара в тебе за спиною." }
t[88370] = { en = "Summons a Puntable Marmot at target location.", ua = "Прикликає бабака, якого можна копнути, у вказаному місці." }
t[88375] = { en = "Summon a Turnip Punching Bag at target location for $d.  The punching bag acts as a target dummy while it persists.\n\n\n\nOnly usable outdoors.", ua = "Приклич ріп'яну грушу для биття у вказане місце на $d.  Поки груша існує, вона править за манекен-ціль.\n\n\n\nМожна використати лише просто неба." }
t[88377] = { en = "Throw a ball of orange paint at your current friendly target, turning them orange for $d.", ua = "Кинь кулю жовтогарячої фарби в поточну дружню ціль, роблячи її жовтогарячою на $d." }
t[88381] = { en = "Summon a burning stick of Silversage Incense at target location for $d.", ua = "Приклич паличку срібношавлієвих пахощів, що горить, у вказане місце на $d." }
t[88385] = { en = "Focus your gaze intently on the target critter, causing it to explode from the pressure after several seconds.", ua = "Пильно зосередь погляд на звірятку-цілі, і за кілька секунд воно вибухне від тиску." }
t[88387] = { en = "Summons Shushen's Spittoon on the ground at target location for $d.  Allies can click on the Spittoon to use it.", ua = "Прикликає плювальницю Шушена на землю у вказаному місці на $d.  Союзники можуть клацнути по плювальниці, щоб скористатися нею." }
t[88417] = { en = "Stand on a piece of Gokk'lok's shell. Moving cancels the effect.", ua = "Стань на уламок мушлі Ґокк'лока. Рух скасовує ефект." }
t[88531] = { en = "A strong alcoholic beverage.", ua = "Міцний алкогольний напій." }
t[88566] = { en = "Perform some quick surgery.", ua = "Проведи швидку операцію." }
t[88579] = { en = "Summon Jin Warmkeg's Brew, which allies can use to have a drink of his ale.", ua = "Приклич вариво Джина Вормкеґа, з якого союзники можуть скуштувати його елю." }
t[88580] = { en = "Put Ken-Ken's Mask on a friendly target.", ua = "Надінь Маску Кен-Кена на дружню ціль." }
t[88584] = { en = "Summon a Totem of Harmony at the target location, illuminating the area for $d.", ua = "Прикличте Тотем Гармонії у вказане місце, що освітлює довкілля на $d." }
t[88587] = { en = "Toss a mug of Iron Belly Spirits to the target to raise their spirits for $d.", ua = "Кинь кухоль спиртного «Залізне Черево» цілі, щоб підняти їй настрій на $d." }
t[88589] = { en = "Cremate the body of a fallen ally.", ua = "Кремуй тіло полеглого союзника." }
t[88801] = { en = "Unleash your rage by flipping a table forwards.", ua = "Вивільни свою лють, перекинувши стіл уперед." }
t[88802] = { en = "Summon a remote controlled Foxicopter to fly around for $d.", ua = "Прикличте радіокерований Лисокоптер, щоб політати навколо на $d." }
t[89139] = { en = "Guide your companion pet with a chain leash.", ua = "Веди свого улюбленця на ланцюговому повідці." }
t[89205] = { en = "Toss your Mini Mana Bomb.", ua = "Кинь свою Міні-Бомбу Мани." }
t[89222] = { en = "Summon a cloud ring that your pet will jump through.  Requires a flying pet.", ua = "Прикличте хмарне кільце, крізь яке стрибатиме ваш улюбленець.  Потрібен летючий улюбленець." }
t[89614] = { en = "Summon an Anatomical Dummy at target location for $d.  The punching bag acts as a target dummy while it persists.\n\n\n\nOnly usable outdoors in Pandaria.", ua = "Прикличте анатомічний манекен у вказане місце на $d.  Поки груша існує, вона править за манекен-ціль.\n\n\n\nМожна використати лише просто неба в Пандарії." }
t[89869] = { en = "Plant your Pandaren Scarecrow.", ua = "Встанови своє Пандаренське Опудало." }
t[89999] = { en = "Shoots a firework that bursts into the Alliance symbol.", ua = "Запускає феєрверк, що вибухає символом Альянсу." }
t[90000] = { en = "Shoots a firework that bursts into the Horde symbol.", ua = "Запускає феєрверк, що вибухає символом Орди." }
t[90067] = { en = "Offer the necklace.", ua = "Запропонуй намисто." }
t[90175] = { en = "Chop, mince, and julienne a fresh humanoid or beast corpse.", ua = "Поруби, посічи й наріж соломкою свіжий труп гуманоїда чи звіра." }
t[90427] = { en = "Carry a keg of brew on your back for $d. Drink brew or toss some to friends!", ua = "Неси барило пива на спині $d. Пий пиво або кинь трохи друзям!" }
t[90883] = { en = "Throw the ball to a friendly player. If possible, they will automatically return it.", ua = "Кинь м'яч дружньому гравцеві. Якщо зможе, він автоматично поверне його." }
t[90888] = { en = "Kick the ball to a friendly player. If possible, they will automatically return it.", ua = "Пасуй м'яч дружньому гравцеві. Якщо зможе, він автоматично поверне його." }
t[90899] = { en = "Make a loud, annoying sound, startling everyone within $A1 yards.", ua = "Видай гучний, набридливий звук, лякаючи всіх у радіусі $A1 ярдів." }
t[91904] = { en = "Summon a Stackable Stag at the target location.  If there is another Stackable Stag nearby, your Stackable Stag will stack on top of it.", ua = "Прикличте Складаного Оленя у вказане місце.  Якщо поблизу є інший Складаний Олень, ваш стане на нього згори." }
t[92738] = { en = "Battle pet experience gained is increased by $s1%.", ua = "Отримуваний досвід бойових улюбленців збільшено на $s1%." }
t[93672] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[95567] = { en = "Returns you to the Kirin Tor on the Isle of Thunder. This beacon only works on the Isle of Thunder or in the Throne of Thunder.", ua = "Повертає тебе до Кірін Тор на Острові Грому. Цей маяк діє лише на Острові Грому чи в Троні Грому." }
t[95568] = { en = "Returns you to the Sunreavers on the Isle of Thunder. This beacon only works on the Isle of Thunder or in the Throne of Thunder.", ua = "Повертає тебе до Санріверів на Острові Грому. Цей маяк діє лише на Острові Грому чи в Троні Грому." }
t[95589] = { en = "Plant your Kirin Tor Offensive banner.", ua = "Встанови свій прапор Наступу Кірін Тор." }
t[95590] = { en = "Plant your Sunreaver Onslaught banner.", ua = "Встанови свій прапор Навали Санріверів." }
t[97919] = { en = "Head-shrinking is for amateurs. Shrink your whole body!", ua = "Зменшувати голову — для аматорів. Зменш усе тіло!" }
t[97921] = { en = "Alter your vision.", ua = "Зміни свій зір." }
t[97942] = { en = "Summon a set of three spirit drums that anyone can play.", ua = "Прикличте набір із трьох духовних барабанів, на яких може грати будь-хто." }
t[97994] = { en = "Summons a seesaw for $142096d.", ua = "Прикликає гойдалку-балансир на $142096d." }
t[98132] = { en = "Unload a torrent of water on allies and enemies with the Geyser Gun.", ua = "Обрушай потік води на союзників і ворогів з Гейзерної Рушниці." }
t[98136] = { en = "Summon and control Jerry the Snail.", ua = "Прикличте равлика Джеррі й керуйте ним." }
t[98552] = { en = "Call wild snakes to follow you for $d.", ua = "Приклич диких змій, щоб повзли за тобою $d." }
t[101571] = { en = "Drape Moonfang's pelt over your head or helmet.", ua = "Накинь шкуру Мунфанґа на голову чи шолом." }
t[102467] = { en = "Sacrifice $s2% of maximum health to become an Emissary of Ordos. While transformed, you are hostile to all players, and killing players grants Bloody Coins. Can only be used on the Timeless Isle, and flags the user for PvP.", ua = "Пожертвуй $s2% максимального здоров'я, щоб стати Емісаром Ордоса. У перетвореному стані ти ворожий до всіх гравців, а вбивство гравців дає Криваві монети. Можна використати лише на Позачасовому Острові; позначає користувача для PvP." }
t[103685] = { en = "Take on the guise of a Celestial Defender.", ua = "Прибери подобу Небесного Захисника." }
t[104262] = { en = "Become infused with stone, granting a chance upon killing an opponent to encase them in stone.", ua = "Насичся каменем, здобувши шанс при вбивстві супротивника закувати його в камінь." }
t[104294] = { en = "Sing the haunting melody of the crew lost on the Dread Ship Vazuvius.", ua = "Заспівайте моторошну мелодію команди, що загинула на Жаскому Кораблі «Вазувіус»." }
t[104302] = { en = "Wear the Blackflame Daggers, signifying your allegiance to Ordos.", ua = "Вдягни Кинджали Чорного Полум'я, засвідчуючи свою відданість Ордосу." }
t[104309] = { en = "Places an Eternal Kiln that increases the spirits of those nearby by 4 and allows cooking.", ua = "Ставить Вічну Жарівню, що піднімає настрій тим, хто поруч, на 4 і дозволяє готувати." }
t[104318] = { en = "Summon and control your Flyer!", ua = "Прикличте свій Трощо-громовий Літун і керуйте ним!" }
t[104323] = { en = "Throw the ball to a friendly player. If possible, they will automatically return it.", ua = "Кинь м'яч дружньому гравцеві. Якщо зможе, він автоматично поверне його." }
t[104324] = { en = "Kick the ball to a friendly player. If possible, they will automatically return it.", ua = "Пасуй м'яч дружньому гравцеві. Якщо зможе, він автоматично поверне його." }
t[104329] = { en = "Summons a ridable but uncontrollable Furious Ashhide Mushan. This is a very, VERY fast mount. Can only be used on the Timeless Isle.", ua = "Прикликає їздового, та некерованого Лютого попелошкурого мушана. Це дуже, ДУЖЕ швидка їздова тварина. Можна використати лише на Позачасовому острові." }
t[104331] = { en = "Place a Warning Sign that lasts for $d. A message can be carved into the sign, causing it to last for $148628d and making it visible to other players.", ua = "Постав Попереджувальний знак, що триває $d. На знаку можна вирізьбити повідомлення, і тоді він триватиме $148628d та стане видимим для інших гравців." }
t[105898] = { en = "Assume the aspect of Moonfang for $d.", ua = "Прийми подобу Мунфанґа на $d." }
t[108631] = { en = "Summon and control your Crashin' Thrashin' Roller.", ua = "Прикличте свій Трощо-громовий Коток і керуйте ним." }
t[108632] = { en = "Summon and control your Crashin' Thrashin' Flamer.", ua = "Прикличте свій Трощо-громовий Вогнемет і керуйте ним." }
t[108633] = { en = "Summon and control your Crashin' Thrashin' Cannon.", ua = "Прикличте свою Трощо-громову Гармату й керуйте нею." }
t[108634] = { en = "Summon and control your Crashin' Thrashin' Mortar.", ua = "Прикличте свій Трощо-громовий Міномет і керуйте ним." }
t[108635] = { en = "Summon and control your Crashin' Thrashin' Killdozer.", ua = "Прикличте свій Трощо-громовий Кілдозер і керуйте ним." }
t[108735] = { en = "Summon ogre gladiators to battle for your entertainment.", ua = "Прикличте оґрів-гладіаторів, щоб билися вам на розвагу." }
t[108739] = { en = "Feel pretty.", ua = "Почувайся красиво." }
t[108743] = { en = "Make your boots smolder.", ua = "Хай твої чоботи задиміють." }
t[108745] = { en = "Create a temporary hologram of yourself for $d.", ua = "Створює тимчасову голограму тебе самого на $d." }
t[109167] = { en = "Retrieves the loot from a nearby corpse. Can only be used in Draenor.", ua = "Забирає здобич із трупа поблизу. Можна використати лише в Дреноре." }
t[109183] = { en = "Shrinks the entire world for $d or until you attack.", ua = "Зменшує весь світ на $d або доки ти не атакуєш." }
t[109739] = { en = "Summon a map of the stars.", ua = "Прикличте карту зірок." }
t[110560] = { en = "Returns you to your Garrison.", ua = "Повертає тебе до твого Гарнізону." }
t[110586] = { en = "Gives the user mysterious flowers.", ua = "Дає власнику таємничі квіти." }
t[111476] = { en = "Turn your breath frosty.", ua = "Зроби свій подих морозним." }
t[111821] = { en = "Assembles the upgraded Blingtron 5000, a savage, yet generous, robot.  While he will give out gifts to players once per day, he will also fight other Blingtron units to the death.", ua = "Збирає вдосконаленого Блінгтрона 5000, дикого, та все ж щедрого робота.  Хоч він і видає подарунки гравцям раз на день, він також битиметься з іншими Блінгтронами на смерть." }
t[112059] = { en = "Creates a spinning wormhole the Engineer can use to travel around Draenor.", ua = "Створює обертову червоточину, якою інженер може подорожувати Дренором." }
t[112324] = { en = "Summons a nightmarish hitching post.\n\n\n\nParty members may use the post to transform their mounts into Warforged Nightmares for $162997d.", ua = "Прикликає жаску конов'язь.\n\n\n\nЧлени групи можуть скористатися конов'яззю, щоб перетворити своїх їздових тварин на Бойокованих Жахокоників на $162997d." }
t[113096] = { en = "Transforms caster to have the appearance of a Bloodmane Saberon.", ua = "Обертає на саберона Кривавогривих." }
t[113375] = { en = "Feel pretty.", ua = "Почувайся красиво." }
t[113540] = { en = "Restores $o1% health and $o2% Mana over $d. Must remain seated while drinking. Can only be used in Draenor.", ua = "Відновлює $o1% здоров'я та $o2% мани протягом $d. Треба лишатися сидіти під час пиття. Можна використати лише в Дреноре." }
t[113542] = { en = "Slows your falling speed for $d.", ua = "Уповільнює швидкість падіння на $d." }
t[113543] = { en = "Summons a ridable spectral talbuk in Draenor. This is a very, VERY fast mount.", ua = "Прикликає їздового примарного талбака в Дренорі. Це дуже, ДУЖЕ швидка їздова тварина." }
t[113570] = { en = "Make like a tree and leaf.", ua = "Прикинься деревом і накивай листям!" }
t[113631] = { en = "Hypnotize a critter in to following you for $d.", ua = "Загіпнотизуй звірятко, щоб воно йшло за тобою $d." }
t[113670] = { en = "Release Murmur's wail.", ua = "Вивільни зойк Мурмура." }
t[114227] = { en = "Shoot a stream of bubbles for $d.", ua = "Пускай струмінь бульбашок на $d." }
t[115468] = { en = "Interacting with the permanent frost essence lowers the body's temperature for $d.", ua = "Взаємодія з постійною сутністю морозу знижує температуру тіла на $d." }
t[115472] = { en = "Interacting with the enchanted orb takes the person out of time for $d.", ua = "Взаємодія із зачарованою кулею вихоплює людину з плину часу на $d." }
t[115501] = { en = "Emits a soothing tune to all enemy creatures within $m2 yards, reducing their range at which they detect enemies. The Music Box lasts for $d until it has to be wound up again.", ua = "Видає заспокійливу мелодію всім ворожим істотам у межах $m2 ярдів, зменшуючи дальність, на якій вони виявляють ворогів. Музична скринька триває $d, доки її знову не доведеться накрутити." }
t[115503] = { en = "Covers your feet in blazing magma.\n\n\n\nUsable only in Draenor.", ua = "Вкриває твої стопи розжареною магмою.\n\n\n\nВикористовується лише в Дренорі." }
t[115505] = { en = "Emits a pleasing tune, calling indigenous wildlife to assist you in battle against enemy Players within $A1 yards.", ua = "Видає приємну мелодію, прикликаючи місцеву звірину на допомогу в бою проти ворожих гравців у межах $A1 ярдів." }
t[115506] = { en = "Disguises wearer as a tree and removes them from combat. Only usable in the wilds of Draenor.", ua = "Маскує власника під дерево й виводить його з бою. Використовується лише в нетрях Дренору." }
t[116067] = { en = "Place the ring on your finger.", ua = "Надінь перстень собі на палець." }
t[116113] = { en = "A gust of wind propels you forward. Can only be used in Draenor.", ua = "Порив вітру штовхає тебе вперед. Використати можна лише в Дренорі." }
t[116115] = { en = "Don a pair of fiery wings, showing off your mastery of the Firebird's Challenge!", ua = "Вдягни вогняні крила, демонструючи свою майстерність у Випробуванні Вогнептаха!" }
t[116120] = { en = "Restores $o1 health over $d. Restores ${$m2/5*$d} mana over $d.  Must remain seated while eating & drinking.", ua = "Відновлює $o1 здоров'я протягом $d. Відновлює ${$m2/5*$d} мани протягом $d.  Треба лишатися сидіти під час їжі та пиття." }
t[116122] = { en = "Eavesdrop on the Burning Legion's commands.", ua = "Підслухай накази Палаючого Легіону." }
t[116125] = { en = "Get all wrapped up.", ua = "Загорнись із головою." }
t[116139] = { en = "Haunt a target for $d, periodically causing the spirit world to affect them.", ua = "Переслідуй ціль $d, час від часу насилаючи на неї вплив світу духів." }
t[116396] = { en = "Emits a pleasing tune, calling indigenous wildlife to assist you in battle against enemy Players within $A1 yards.", ua = "Видає приємну мелодію, прикликаючи місцеву звірину на допомогу в бою проти ворожих гравців у межах $A1 ярдів." }
t[116400] = { en = "Covers target with turkey feathers.", ua = "Вкриває ціль індичим пір'ям." }
t[116435] = { en = "Places a Cozy Bonfire that increases the Versatility of those nearby by 4 and allows cooking.", ua = "Ставить Затишне Вогнище, що підвищує Універсальність тих, хто поруч, на 4 і дозволяє готувати." }
t[116440] = { en = "Take on the guise of a fiery defender.", ua = "Прибери подобу вогняного захисника." }
t[116456] = { en = "Magically filters your perception of the world.", ua = "Магічно фільтрує твоє сприйняття світу." }
t[116651] = { en = "Focus the prism on a target, lighting them up with adoration.", ua = "Наведи призму на ціль, осяявши її обожнюванням." }
t[116689] = { en = "Place a lounge cushion that can be sat on and lasts for $d.", ua = "Постав подушку для відпочинку, на якій можна сидіти й що триває $d." }
t[116690] = { en = "Place a lounge cushion that can be sat on and lasts for $d.", ua = "Постав подушку для відпочинку, на якій можна сидіти й що триває $d." }
t[116691] = { en = "Place a lounge cushion that can be sat on and lasts for $d.", ua = "Постав подушку для відпочинку, на якій можна сидіти й що триває $d." }
t[116692] = { en = "Place a lounge cushion that can be sat on and lasts for $d.", ua = "Постав подушку для відпочинку, на якій можна сидіти й що триває $d." }
t[116757] = { en = "Places a Steamworks Sausage Grill that increases the spirits of those nearby by 4 and allows cooking.", ua = "Ставить Паровий Гриль для Ковбасок, що піднімає настрій тим, хто поруч, на 4 і дозволяє готувати." }
t[116758] = { en = "Represent Brewfest!", ua = "Вболівай за Хмільне свято!" }
t[116763] = { en = "Summon and control your Crashin' Thrashin' Shredder.", ua = "Прикличте свій Трощо-громовий Подрібнювач і керуйте ним." }
t[116856] = { en = "Don the contender's costume, allowing you to use special abilities to battle other contenders.\n\n\n\nWhile costumed, healing taken is reduced by 100%.", ua = "Вдягни костюм суперника, що дозволяє використовувати особливі здібності для двобою з іншими суперниками.\n\n\n\nУ костюмі отримане зцілення зменшене на 100%." }
t[116888] = { en = "Don the contender's costume, allowing you to use special abilities to battle other contenders.\n\n\n\nWhile costumed, healing taken is reduced by 100%.", ua = "Вдягни костюм суперника, що дозволяє використовувати особливі здібності для двобою з іншими суперниками.\n\n\n\nУ костюмі отримане зцілення зменшене на 100%." }
t[116889] = { en = "Don the contender's costume, allowing you to use special abilities to battle other contenders.\n\n\n\nWhile costumed, healing taken is reduced by 100%.", ua = "Вдягни костюм суперника, що дозволяє використовувати особливі здібності для двобою з іншими суперниками.\n\n\n\nУ костюмі отримане зцілення зменшене на 100%." }
t[116890] = { en = "Don the contender's costume, allowing you to use special abilities to battle other contenders.\n\n\n\nWhile costumed, healing taken is reduced by 100%.", ua = "Вдягни костюм суперника, що дозволяє використовувати особливі здібності для двобою з іншими суперниками.\n\n\n\nУ костюмі отримане зцілення зменшене на 100%." }
t[116891] = { en = "Don the contender's costume, allowing you to use special abilities to battle other contenders.\n\n\n\nWhile costumed, healing taken is reduced by 100%.", ua = "Вдягни костюм суперника, що дозволяє використовувати особливі здібності для двобою з іншими суперниками.\n\n\n\nУ костюмі отримане зцілення зменшене на 100%." }
t[117550] = { en = "Shake me.", ua = "Струсни мене." }
t[117569] = { en = "Shake me.", ua = "Струсни мене." }
t[117573] = { en = "Offers respite from the darkness.", ua = "Дарує перепочинок від темряви." }
t[118191] = { en = "Attempt to contact Archmage Vargoth.", ua = "Спробуй зв'язатися з архімагом Варготом." }
t[118221] = { en = "Petrify a critter for $d.", ua = "Оберни дрібну істоту на камінь на $d." }
t[118222] = { en = "Summon the Spirit of Bashiok.", ua = "Прикличте Дух Башіока." }
t[118224] = { en = "Brew up a special surprise!", ua = "Звари особливий сюрприз!" }
t[118244] = { en = "Disguise yourself as a swashbuckler of the Iron Seas.", ua = "Перекинься на флібустьєра Залізних Морів." }
t[118427] = { en = "Turn the card over to see what you got!", ua = "Переверни картку, щоб побачити, що тобі випало!" }
t[118716] = { en = "Disguise yourself as a goren.", ua = "Перекинься на ґорена." }
t[118935] = { en = "Restores $s1% of health and mana every $t1 sec. for $d. Any damage taken will remove the bloom. Can only be used in Draenor.", ua = "Відновлює $s1% здоров'я та мани кожні $t1 с протягом $d. Будь-яка отримана шкода знімає цвітіння. Можна використати лише в Дреноре." }
t[118937] = { en = "Clutch the braid tightly and Gamon will be with you.", ua = "Міцно стисни косу, і Ґамон буде з тобою." }
t[118938] = { en = "Adds another Manastorm to the world, as if it needed it.", ua = "Додає світові ще одного Манашторма, наче йому цього бракувало." }
t[119001] = { en = "Summon a keg filled with a mysterious brew.", ua = "Прикличте барило, наповнене таємничим варивом." }
t[119003] = { en = "Place a Void Totem that will weaken the barrier between this world and the Twisting Nether for $d.", ua = "Постав Тотем Порожнечі, що послабить бар'єр між цим світом і Викривленим Нижнім Світом на $d." }
t[119039] = { en = "Place a Warning Sign that lasts for $d. A message can be carved into the sign, causing it to last for $148628d and making it visible to other players.", ua = "Постав Попереджувальний знак, що триває $d. На знаку можна вирізьбити повідомлення, і тоді він триватиме $148628d та стане видимим для інших гравців." }
t[119083] = { en = "Throw a piece of fruit at the target, utterly destroying the fruit.", ua = "Кинь шматок фрукта в ціль, дощенту знищивши фрукт." }
t[119092] = { en = "Polish the scuffs away, and everything else!", ua = "Відполіруй подряпини — і геть усе інше!" }
t[119093] = { en = "Launches you high into the air and deploys magical wings. Can only be used in Draenor.", ua = "Підкидає тебе високо в повітря й розгортає магічні крила. Можна використати лише в Дренорі." }
t[119134] = { en = "Disguise yourself as a Sargerai Initiate.", ua = "Перекинься на послушника Саргераї." }
t[119144] = { en = "Feel the touch of the Naaru.", ua = "Відчуй дотик наару." }
t[119145] = { en = "Place a Firefury Totem that will set the sky on fire for $d.", ua = "Постав Тотем Вогняної Люті, що підпалить небо на $d." }
t[119160] = { en = "Set down your Tickle Totem.", ua = "Постав свій Тотем лоскоту." }
t[119163] = { en = "Drain the last whispers of life from a corpse.", ua = "Висмокчи останні шепоти життя з трупа." }
t[119178] = { en = "Summons a powerful whirlwind that will spin you around and launch you in a random direction. Only usable in Draenor.", ua = "Прикликає потужний вихор, що закрутить вас і жбурне у випадковому напрямку. Можна використати лише в Дренорі." }
t[119180] = { en = "Summon a goren to take you for a ride.", ua = "Прикличте ґорена, щоб він вас покатав." }
t[119182] = { en = "Protect your soul from demons for $d.", ua = "Захисти свою душу від демонів на $d." }
t[119210] = { en = "Throw down a Hearthstone board, letting everyone know you're ready to play!", ua = "Розклади ігрове поле Hearthstone, сповіщаючи всіх про свою готовність грати!" }
t[119211] = { en = "Destroy your hero and replace it with Lord Jaraxxus.", ua = "Знищує твого героя й замінює його лордом Джараксусом." }
t[119212] = { en = "Show everyone that you just won a game of Hearthstone!", ua = "Покажи всім свою щойно здобуту перемогу в партії Hearthstone!" }
t[119215] = { en = "Transform into a Clockwork Gnome.", ua = "Обернися на механічного ґнома." }
t[119217] = { en = "Place a flag on an enemy player's corpse in front of you.", ua = "Постав прапорець на труп ворожого гравця перед собою." }
t[119218] = { en = "Place a flag on an enemy player's corpse in front of you.", ua = "Постав прапорець на труп ворожого гравця перед собою." }
t[119219] = { en = "Place a flag on an enemy player's corpse in front of you.", ua = "Постав прапорець на труп ворожого гравця перед собою." }
t[119220] = { en = "Display your Alliance banner on your back.", ua = "Розміщує твій прапор Альянсу в тебе за спиною." }
t[119221] = { en = "Display your Horde banner on your back.", ua = "Розміщує твій прапор Орди в тебе за спиною." }
t[119421] = { en = "Become a Sha'tari Defender for $177193d.", ua = "Стань Захисником Ша'тарі на $177193d." }
t[119432] = { en = "Blend in with the Botani.", ua = "Злийся з ботані." }
t[120276] = { en = "Disguise yourself as a Warsong orc.", ua = "Перекинься на орка клану Бойової Пісні." }
t[120857] = { en = "Summon a barrel containing mystery bandanas for you and all your friends. You'll Barrel-y Believe The Results!", ua = "Приклич діжку з таємничими банданами для себе й усіх друзів. Ти й сам не повіриш — ціла діжка веселощів!" }
t[122117] = { en = "Transforms the caster to have the appearance of one of Iskar's followers.", ua = "Надає тобі вигляду одного з послідовників Іскара." }
t[122119] = { en = "Shoots a firework into the air that bursts into the Darkmoon Faire logo.", ua = "Запускає в небо феєрверк, що вибухає логотипом Ярмарку Темного Місяця." }
t[122120] = { en = "Mark an enemy target with the Gaze of the Darkmoon.", ua = "Познач ворожу ціль Поглядом Темного Місяця." }
t[122121] = { en = "Summons a Darkmoon Gazer and binds your vision to it.  The Gazer is stealthed and moves quickly, but is very fragile.", ua = "Прикликає Споглядача Темного Місяця й прив'язує твій зір до нього. Споглядач невидимий і рухається швидко, та вкрай тендітний." }
t[122122] = { en = "Summon and control your Crashin' Thrashin' Tonk.", ua = "Приклич свій Трощо-громовий Тонк і керуй ним." }
t[122123] = { en = "Unleash an explosion of rings.", ua = "Вивільни вибух кілець." }
t[122126] = { en = "Place down a blinking arrow.", ua = "Постав стрілку, що блимає." }
t[122129] = { en = "Drink the solution, setting your breath on fire.", ua = "Випий розчин, і твій подих спалахне вогнем." }
t[122283] = { en = "Transformed into a Rukhmar Adherent.", ua = "Обертає на прибічника Рухмар." }
t[122293] = { en = "Calls forth Pepe to ride on your head as you adventure together.", ua = "Прикликає Пепе, щоб сидів у тебе на голові, поки ви разом мандруєте." }
t[122298] = { en = "Miniaturize your Bodyguard for $d.", ua = "Зменш свого охоронця на $d." }
t[122304] = { en = "Harness the essence of Fire granted to the Druids of the Flame.", ua = "Опануй сутність Вогню, дану Друїдам Полум'я." }
t[122674] = { en = "Frame the perfect shot and take a selfie!", ua = "Злови ідеальний кадр і зроби селфі!" }
t[122681] = { en = "Open the book. Only usable in Azsuna.", ua = "Відкрий книгу. Можна використати лише в Азсуні." }
t[122700] = { en = "Put down your Portable Audiophone.", ua = "Постав свій портативний аудіофон." }
t[123851] = { en = "Adds some company to your friends' S.E.L.F.I.E. pictures.", ua = "Додає компанію до S.E.L.F.I.E.-світлин твоїх друзів." }
t[126931] = { en = "Blow on the slidewhistle.", ua = "Дмухни у свисток-слайд." }
t[127394] = { en = "Disguise yourself as a podling.", ua = "Перекинься на паростка." }
t[127652] = { en = "Build a fel campfire that is unpleasant to be around. It does allow cooking, though.", ua = "Розклади багаття Скверни, біля якого неприємно бути. Утім, на ньому можна готувати." }
t[127655] = { en = "Summon an imp to do your bidding for a short time. Sort of. The imp will only answer your summons while you are in Draenor.", ua = "Приклич біса, щоб він недовго виконував твої накази. Ну, майже. Біс відгукнеться на твій поклик лише в Дренорі." }
t[127659] = { en = "Show mutineers you've got a bone to pick with them.", ua = "Покажи бунтівникам, що маєш до них рахунок." }
t[127666] = { en = "Drink the remains of the Blood Moon.", ua = "Випий рештки Кривавого Місяця." }
t[127668] = { en = "Apply directly to the forehead.", ua = "Наноси прямо на чоло." }
t[127669] = { en = "Summon the power of the dead Chieftain to quickly cross vast distances.\n\n\n\nOnly usable in Draenor.", ua = "Приклич силу загиблого вождя, щоб швидко долати величезні відстані.\n\n\n\nМожна використати лише в Дренорі." }
t[127670] = { en = "Follow the path of the Man'ari\n\nEredar.", ua = "Іди шляхом ман'арі\n\nередарів." }
t[127695] = { en = "Gives your companion pet a spectral look.", ua = "Надає твоєму улюбленцю примарного вигляду." }
t[127696] = { en = "Take on the appearance of your companion pet. Only works on pets that can battle.", ua = "Прибери вигляд свого улюбленця-супутника. Діє лише на улюбленців, здатних до бою." }
t[127707] = { en = "Give your Perky Pug a bone.", ua = "Дай своєму Жвавому мопсу кістку." }
t[127709] = { en = "Give in to the power of the Bleeding Hollow clan.", ua = "Піддайся силі клану Кровоточивої Западини." }
t[127766] = { en = "Pick a few fel-tainted petals from the blossom.", ua = "Зірви кілька заплямованих Скверною пелюсток із квітки." }
t[127859] = { en = "Equip a Dazzling Rod, allowing you to shoot arcane energy at others wielding the rod.", ua = "Спорядь Сяйливу Паличку, що дозволяє стріляти арканною енергією в інших власників палички." }
t[127864] = { en = "Place a spotlight over your head.", ua = "Постав прожектор над своєю головою." }
t[128223] = { en = "$@spelldesc1291850|n|nSide effects may occur. Can only be consumed outdoors in Draenor.", ua = "$@spelldesc1291850|n|nМожливі побічні ефекти. Вживати можна лише просто неба в Дренорі." }
t[128310] = { en = "Don the banner and weaponry of the Burning Blade.", ua = "Візьми прапор і зброю Палаючого Клинка." }
t[128328] = { en = "Feeds the wee squirrels.", ua = "Годує маленьких білок." }
t[128462] = { en = "Garb yourself in the ceremonial robes of Karabor.", ua = "Вдягни церемоніальні шати Карабора." }
t[128471] = { en = "Garb yourself for battle as a Frostwolf soldier.", ua = "Вберися до бою, як воїн клану Морозного Вовка." }
t[128536] = { en = "Places an enchanted brazier that increases spirits of those nearby by 4 and allows cooking.", ua = "Ставить зачаровану жаровню, що піднімає настрій тим, хто поруч, на 4 і дозволяє готувати." }
t[128636] = { en = "Bring the snow to your friends and enemies with your fabulous new Snow Blower!\n\nCooldown reduced during Feast of Winter Veil.", ua = "Принеси сніг друзям і ворогам своїм чудовим новим Снігодувом!\n\nПерезарядження скорочене під час Свята Зимової Завіси." }
t[128776] = { en = "Sit on a sled that can be pulled by other players, or put your battle pet on a sled and pull it yourself!\n\n\n\nOnly works on pets that can battle.", ua = "Сядь на санчата, які можуть тягнути інші гравці, або посади свого бойового улюбленця на санчата й тягни його сам!\n\n\n\nПрацює лише з улюбленцями, здатними до бою." }
t[128794] = { en = "Throw the sack, releasing the spiders inside.", ua = "Кинь мішок і випусти павуків, що всередині." }
t[128807] = { en = "Become someone else.\n\nCooldown reduced during Hallow's End.", ua = "Стань кимось іншим.\n\nПерезарядження скорочене під час Кануна Всіх Святих." }
t[129055] = { en = "Shine someone's shoes.", ua = "Начисти комусь взуття." }
t[129057] = { en = "Throw the disc to a friendly player. If possible, they will automatically return it.", ua = "Кинь диск дружньому гравцеві. Якщо зможе, він автоматично поверне його." }
t[129093] = { en = "Apply the sweet Ravenbear disguise.", ua = "Вдягни милу личину вороноведмедя." }
t[129111] = { en = "Blast a blaring horn, attracting enemies within $A1 yards. Ineffective on targets above level $ctrmax2067.", ua = "Засурми в гучний ріг, приваблюючи ворогів у межах $A1 ярдів. Неефективно проти цілей, вищих за рівень $ctrmax2067." }
t[129113] = { en = "Drink some of the mead.", ua = "Випий трохи медовухи." }
t[129149] = { en = "Take on your Helheim Spirit form.", ua = "Прибери подобу свого духа Гельгейму." }
t[129165] = { en = "Something about this gem smells fishy...", ua = "Щось із цим самоцвітом підозріло тхне рибою..." }
t[129211] = { en = "Write a steamy romance novel.", ua = "Напиши жагучий любовний роман." }
t[129279] = { en = "Summon the Sand Piper tied to the Enchanted Stone Whistle.", ua = "Приклич кулика, прив'язаного до Зачарованого Кам'яного Свистка." }
t[129367] = { en = "Whittle a vrykul toy boat.", ua = "Вистругай іграшковий човник врикулів." }
t[129926] = { en = "Disguise yourself as an Ashtongue Broken.", ua = "Перекинься на понівеченого з Попеломовців." }
t[129929] = { en = "Reveal convergence points between Draenor and Outland.", ua = "Виявляє точки сходження між Дренором та Аутлендом." }
t[129938] = { en = "Embrace the will of Northrend.", ua = "Прийми волю Нортренду." }
t[129952] = { en = "Turn the hourglass.", ua = "Переверни пісочний годинник." }
t[129956] = { en = "Place down a Leather Love Seat.", ua = "Постав шкіряну канапу для двох." }
t[129958] = { en = "Guide your companion pet with a leather leash.", ua = "Веди свого улюбленця на шкіряному повідці." }
t[129960] = { en = "Place a bed for most Companion Pets.", ua = "Постав лежанку для більшості улюбленців-супутників." }
t[129961] = { en = "Hold up a flaming hoop for your pet to jump through!", ua = "Підніми палаючий обруч, щоб твій улюбленець стрибнув крізь нього!" }
t[129965] = { en = "Heed the call of the wild to quickly cross vast distances. Only usable in Northrend.", ua = "Прислухайся до поклику дикої природи, щоб швидко долати величезні відстані. Можна використати лише в Нортренді." }
t[130102] = { en = "Skin a creature from up to 40 yards away. Not effective on creatures above level $ctrmax2067.", ua = "Зніми шкуру з істоти на відстані до 40 ярдів. Не діє на істот вище рівня $ctrmax2067." }
t[130147] = { en = "Take on the guise of a mischievous Thistleleaf Thorndancer.", ua = "Прибери подобу пустотливого будяколистого терноплясуна." }
t[130151] = { en = "Restores $195562o% health and mana over $195562d. Taking damage will remove the effect.\n\nLunch is limited to the Broken Isles, but comes with a rotating menu and matching thermos.", ua = "Відновлює $195562o% здоров'я та мани протягом $195562d. Отримана шкода знімає ефект.\n\nОбід доступний лише на Зламаних Островах, зате має мінливе меню й термос у комплекті." }
t[130157] = { en = "Use the rod to glimpse the true form of the departed in the Broken Isles.", ua = "Скористайся жезлом, щоб побачити справжню подобу спочилих на Зламаних Островах." }
t[130158] = { en = "Leaves fluttering leaves in your wake for $d.", ua = "Лишає за тобою вихор опалого листя на $d." }
t[130169] = { en = "Wave the Favor and be the envy of all around you.", ua = "Помахай Знаком Прихильності й викликай заздрість усіх довкола." }
t[130170] = { en = "Summon a vision of the green aspect Ysera.", ua = "Приклич видіння зеленого аспекта Ісери." }
t[130171] = { en = "Gaze into the dark glass.", ua = "Вдивися в темне скло." }
t[130191] = { en = "Deploy a trapped Treasure Chest, you Rascal!", ua = "Встанови Скриню зі Скарбами з пасткою, шибенику!" }
t[130199] = { en = "Open a portal to a dangerous Legion world.", ua = "Відкрий портал у небезпечний світ Легіону." }
t[130209] = { en = "Set down and open your Never Ending Toy Chest.", ua = "Постав і відкрий свою нескінченну скриню з іграшками." }
t[130214] = { en = "Discard the worn doll on the ground.", ua = "Викинь зношену ляльку на землю." }
t[130232] = { en = "Place the Moonfeather Statue on the ground. What's the worst that could happen?", ua = "Постав Статую Місячного Пера на землю. Що ж найгірше може статися?" }
t[130249] = { en = "Transform into the likeness of a Thundering Sablehoof to quickly cross vast distances in Val'sharah.", ua = "Обернися на подобу Громового Соболекопита, щоб швидко долати великі відстані у Вал'шарі." }
t[130251] = { en = "Play a jewel matching game.", ua = "Зіграй у гру на збіг самоцвітів." }
t[130254] = { en = "Activate or deactivate the gem.", ua = "Увімкни або вимкни самоцвіт." }
t[131717] = { en = "Draw the outline of a Starlight Field. Players inside the Starlight Field can fly.\n\n\n\nCan only be used in the Broken Isles.", ua = "Окресли Зоряне Поле. Гравці всередині Зоряного Поля можуть літати.\n\n\n\nВикористовується лише на Зламаних Островах." }
t[131724] = { en = "Peer through the eye to see a world where the demons won the War of the Ancients.", ua = "Поглянь крізь око, щоб побачити світ, де демони перемогли у Війні Прадавніх." }
t[131811] = { en = "Reduces your falling speed for $d. Only useable in Broken Isles.", ua = "Зменшує швидкість твого падіння на $d. Можна використати лише на Зламаних Островах." }
t[131812] = { en = "Nibble a piece of the crystal.", ua = "Відкуси шматочок кристала." }
t[131814] = { en = "Place a Whitewater Carp to kick around. Splash!", ua = "Постав біловодого коропа, щоб копати його ногою. Плюсь!" }
t[131900] = { en = "The instincts of the Elderhorn make your mount more sure and swift. Only usable within Highmountain.", ua = "Інстинкти старорога роблять твою їздову тварину впевненішою та швидшою. Можна використати лише у Високогір'ї." }
t[131933] = { en = "Launch critters into the air.", ua = "Підкидай звіряток у повітря." }
t[132518] = { en = "Play a circuit-uncrossing game.", ua = "Зіграй у гру з розплутування схеми." }
t[133511] = { en = "Examine this fin-omenon of nature, retrieved from the depths of Vashj'ir.", ua = "Розглянь цей плав-феномен природи, здобутий з глибин Вайш'іра." }
t[133542] = { en = "Witness the wrath of Deathwing firsthand.", ua = "Побач лють Дезвінга на власні очі." }
t[133997] = { en = "Equip the Black Ice to show off your adventuring.", ua = "Спорядь Чорну Кригу, щоб похизуватися своїми пригодами." }
t[133998] = { en = "Imbue the target with rainbow power! \n\n\n\nCooldown reduced during the Darkspear Dash.", ua = "Наповни ціль веселковою силою! \n\n\n\nПерезарядження скорочене під час Ривка Чорнокопів." }
t[134004] = { en = "Put on your Noble's Eternal Elementium Signet Ring.", ua = "Надінь свій вічний елементієвий перстень-печатку шляхтича." }
t[134007] = { en = "Equip the Eternal Black Diamond Ring, passed down through generations.", ua = "Спорядь Вічний Перстень з Чорним Діамантом, що передається з покоління в покоління." }
t[134019] = { en = "Put on Don Carlos' Famous Hat and summon an incorporeal coyote spirit to accompany you. The spirit will remain until you remove the hat.", ua = "Надінь славетний капелюх Дона Карлоса й приклич безтілесного духа койота, що супроводжуватиме тебе. Дух лишатиметься, доки ти не знімеш капелюх." }
t[134020] = { en = "Allows you to cook faster.", ua = "Дозволяє тобі готувати швидше." }
t[134021] = { en = "Launch yourself to the stars.  For the safety of others, please clear the launching platform before use.", ua = "Запусти себе до зірок. Задля безпеки інших, звільни стартовий майданчик перед використанням." }
t[134022] = { en = "Succumb to the curse of Burgy Blackheart.", ua = "Піддайся прокляттю Берґі Блекгарта." }
t[134023] = { en = "Jump high into the sky on the winds of Pandaria. Can only be used outdoors.", ua = "Стрибни високо в небо на вітрах Пандарії. Можна використати лише просто неба." }
t[134024] = { en = "Transform into a Cursed Hozen Swabby, able to breathe underwater and swim $s3% faster.\n\n\n\nOnly useable in Pandaria.", ua = "Обернися на проклятого гозена-матроса, здатного дихати під водою і плавати на $s3% швидше.\n\n\n\nМожна використати лише в Пандарії." }
t[134026] = { en = "Represent your faction!", ua = "Вболівай за свою фракцію!" }
t[134031] = { en = "Represent your faction!", ua = "Вболівай за свою фракцію!" }
t[134032] = { en = "Represent your faction!", ua = "Вболівай за свою фракцію!" }
t[134034] = { en = "Represent your faction!", ua = "Вболівай за свою фракцію!" }
t[134831] = { en = "Disguise yourself as a Doomsayer.", ua = "Перекинься на віщуна загибелі." }
t[136846] = { en = "Conjures a familiar stone, containing either an Arcane, Fiery, or Icy Familiar.", ua = "Створює чарами камінь фамільяра, що містить арканного, вогняного або крижаного фамільяра." }
t[136849] = { en = "Teleports you to a natural location.", ua = "Телепортує тебе в природну місцину." }
t[136855] = { en = "Call on a random animal companion that represents a random hunter aspect to follow you for $122489d.", ua = "Приклич випадкового звіра-супутника, що уособлює випадковий аспект мисливця, аби йшов за тобою на $122489d." }
t[136927] = { en = "Compels a friendly target to confess a secret.\n\n\n\nOr maybe it's just subtle mind control.", ua = "Змушує дружню ціль зізнатися в таємниці.\n\n\n\nА може, це просто тонкий контроль розуму." }
t[136928] = { en = "The orb calls attention to your personal affinity to either light or shadow.", ua = "Сфера привертає увагу до твоєї особистої схильності — до світла чи до тіні." }
t[136934] = { en = "Summons a random Fire, Water, or Earth familiar.  Familiars of different types have a tendency to fight each other.", ua = "Прикликає випадкового фамільяра Вогню, Води чи Землі. Фамільяри різних типів схильні битися між собою." }
t[136935] = { en = "You summon a rain storm of frogs at your targeted location.", ua = "Ти прикликаєш дощ із жаб у вибраному місці." }
t[136937] = { en = "Summons one of Vol'jin's Serpent Wards at the feet of the caster for $d that repeatedly attacks any encroaching critters within $210859r yards for $210859s1 Fire damage.", ua = "Прикликає один зі Зміїних Оберегів Вол'джина біля ніг заклинача на $d, що раз за разом атакує будь-яких дрібних створінь, які наближаються в межах $210859r ярдів, завдаючи $210859s1 Вогняної шкоди." }
t[137294] = { en = "Take on the mark of the Kirin Tor.", ua = "Прибери знак Кірін-Тору." }
t[137663] = { en = "Mortally wound an enemy of trivial difficulty.", ua = "Смертельно порань ворога дріб'язкової складності." }
t[138202] = { en = "For $d, jumping while mounted will cause an array of fireworks to shoot off.", ua = "Протягом $d стрибок верхи запускатиме феєрверк." }
t[138415] = { en = "Shout a filthy pirate insult at everyone within earshot!", ua = "Вигукни брудну піратську лайку на всіх, хто в межах чутності!" }
t[138490] = { en = "Unleash the Waterspeaker's Totem, causing globes of water to encircle you for $d. Restoration Shamans only.", ua = "Вивільни Тотем Водомовця, і кулі води оточать тебе на $d. Лише для шаманів відновлення." }
t[138873] = { en = "Unleash the lingering enchantment on the hat to relive your days at the Academy.", ua = "Вивільни залишкові чари капелюха, щоб знову пережити свої дні в Академії." }
t[138876] = { en = "Grind Small Ley Crystals found around Azsuna Ley Lines into semi-edible Crystal Shards. The grinder takes some time to regenerate after each session.", ua = "Перемели Малі кристали лей, що трапляються біля ліній лей Азсуни, на напівїстівні Кристалічні уламки. Після кожного сеансу млинку потрібен час на відновлення." }
t[138878] = { en = "The blood glows from time to time, allowing you to call... no, \"request\" that Master Daglop pay you a visit.", ua = "Кров час від часу світиться, дозволяючи покликати... ні, «попросити» майстра Даґлопа завітати до тебе." }
t[138900] = { en = "Wear the hat.", ua = "Вдягни капелюх." }
t[139337] = { en = "Set out a Clothes Chest for your raid or party to try on.\n\nCooldown reduced during Feast of Winter Veil.", ua = "Виклади Скриню з одягом, щоб твій рейд чи група поміряли його.\n\nЧас відновлення скорочено під час Свята Зимової Завіси." }
t[139587] = { en = "Disguise yourself as a wooden crate.", ua = "Перекинься на дерев'яний ящик." }
t[139773] = { en = "Push off the ground and catch a gust of wind. Can only be used in Broken Isles.", ua = "Відштовхнися від землі й злови порив вітру. Можна використати лише на Зламаних Островах." }
t[140160] = { en = "Blow into the Stormforged Vrykul Horn, taking on the appearance of a Stormforged Vrykul for $d.", ua = "Засурми в Штормокований Ріг Врикулів, набуваючи вигляду Штормокованого Врикула на $d." }
t[140192] = { en = "Teleports the caster to Dalaran.", ua = "Телепортує до Даларану." }
t[140231] = { en = "Causes your companion pet to take on your appearance.", ua = "Змушує твого улюбленця-супутника набути твого вигляду." }
t[140309] = { en = "Shimmer with all of the colors of the rainbow for $d.\n\n\n\nCooldown reduced during the Darkspear Dash.", ua = "Мерехти всіма барвами веселки на $d.\n\n\n\nЧас відновлення скорочено під час Ривка Чорнокопів." }
t[140314] = { en = "Gives a crab a knife.", ua = "Дає крабові ніж." }
t[140324] = { en = "Set up the beacon in the field to return to Shal'aran. The beacon is the pinnacle of Telemancy technology and provides 85% coverage of Suramar as well as only requiring 20 hours to recharge!", ua = "Постав маяк у полі, щоб повернутися до Шал'арану. Цей маяк — вершина технології телемантії: він покриває 85% Сурамару й потребує лише 20 годин на перезарядку!" }
t[140325] = { en = "Don a 'home-made' Nightborne party mask.", ua = "Вдягни «саморобну» святкову маску нічнароджених." }
t[140336] = { en = "Summon a Brulfist Idol at the base of the caster, shooting them into the air... violently.", ua = "Приклич Ідол Брулфіста біля ніг заклинача, вистріливши його в повітря... брутально." }
t[140363] = { en = "Summon a small Fel Spreader that will spread the taint of the Legion.", ua = "Приклич невеликий Розсіювач Скверни, що ширитиме заразу Легіону." }
t[140632] = { en = "Summon an ancient Lava Fountain.", ua = "Приклич прадавній лавовий фонтан." }
t[140780] = { en = "Project the image of the incubating Fal'dorei onto yourself.", ua = "Спроєктуй на себе образ Фал'дорея, що визріває." }
t[140786] = { en = "Toss the Fal'dorei Spider Jar at your current target.", ua = "Кинь Банку з Павуком Фал'дорей у поточну ціль." }
t[141296] = { en = "Creates a floating Mana Basin for $d. Party and raid members can use the basin to acquire Mana Catalyst increasing the regen of conjured foods and magical foods purchased in Suramar.", ua = "Створює плавучу Чашу Мани на $d. Члени групи та рейду можуть використати чашу, щоб отримати Каталізатор Мани, який підвищує відновлення від створених чарами страв і чарівних страв, куплених у Сурамарі." }
t[141297] = { en = "Deploy the Arcano-Shower for $d. The arcane flows not only cleanse through clothes they also cleanse the clothes as well!", ua = "Встанови Аркано-душ на $d. Арканні потоки не лише очищають крізь одяг — вони очищають і сам одяг!" }
t[141298] = { en = "Focus on the stone and think about your happy place.", ua = "Зосередься на камені й подумай про своє щасливе місце." }
t[141299] = { en = "Place a Kal'dorei Light Globe for $d.", ua = "Постав Світлову Кулю Калдореїв на $d." }
t[141300] = { en = "Focus what was once a powerful arcane beam at targets in front of you.", ua = "Спрямуй колись потужний арканний промінь на цілі перед собою." }
t[141301] = { en = "Open the ominously glowing makeup box.", ua = "Відкрий косметичну скриньку, що зловісно сяє." }
t[141306] = { en = "Let the Wisp out of the bottle.", ua = "Випусти Вогника з пляшки." }
t[141331] = { en = "Splash yourself with the ooze, transforming into a Leper Gnome.", ua = "Обілляй себе слизом, перетворившись на прокаженого гнома." }
t[141605] = { en = "$@spelldesc227334", ua = "$@spelldesc227334" }
t[141649] = { en = "Set yourself on fire! For reasons!", ua = "Підпали себе! Просто так!" }
t[141862] = { en = "Become infused with starlight for $d.", ua = "Насичся зоряним світлом на $d." }
t[141879] = { en = "Enter your Personal Egg.", ua = "Увійди у своє персональне яйце." }
t[142265] = { en = "Make your nearby pets and battle pets huge, and red!", ua = "Зроби своїх улюбленців і бойових улюбленців поблизу величезними й червоними!" }
t[142341] = { en = "Summon your Love Boat on the water's surface within $a1 yards.\n\nCooldown reduced during Love is in the Air.", ua = "Приклич свій Човен Кохання на поверхні води в межах $a1 ярдів.\n\nПерезарядження скорочене під час свята «Кохання в повітрі»." }
t[142452] = { en = "Disguise yourself as a wyrmtongue for $d.", ua = "Перекинься на змієязикого на $d." }
t[142494] = { en = "Give a falcosaur pet a flowery hat.", ua = "Дай улюбленцю-соколозавру квітчастий капелюх." }
t[142495] = { en = "Give a falcosaur pet a pair of fake teeth.", ua = "Дай улюбленцю-соколозавру накладні зуби." }
t[142496] = { en = "Give a falcosaur pet a dirty spoon.", ua = "Дай улюбленцю-соколозавру брудну ложку." }
t[142497] = { en = "Give a falcosaur pet a tiny pack.", ua = "Дай улюбленцю-соколозавру маленький наплічник." }
t[142528] = { en = "Replace your fishing bobber with a can of tasty (to fish, at least) worms for $d.", ua = "Заміни свій риболовний поплавець на бляшанку смачних (принаймні для риби) хробаків на $d." }
t[142529] = { en = "Replace your fishing bobber with a toy cat head for $d.", ua = "Заміни свій риболовний поплавець на іграшкову котячу голову на $d." }
t[142530] = { en = "Replace your fishing bobber with a tugboat for $d.", ua = "Заміни свій риболовний поплавець на буксир на $d." }
t[142531] = { en = "Replace your fishing bobber with a squeaky duck for $d.", ua = "Заміни свій риболовний поплавець на пискляве каченя на $d." }
t[142532] = { en = "Replace your fishing bobber with a cute murloc head for $d.", ua = "Заміни свій риболовний поплавець на милу голову мурлока на $d." }
t[142536] = { en = "Summon the Memory Cube and relive pivotal moments in the battle against the Legion.", ua = "Приклич Куб Спогадів і переживи заново переломні миті битви проти Легіону." }
t[142542] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[143534] = { en = "Focus Arcane magic to create living construct.  It is unknown what forms this could take.", ua = "Зосередь арканну магію, щоб створити живий конструкт.  Невідомо, якої форми він набуде." }
t[143543] = { en = "Strum the strings to produce a haunting melody.", ua = "Перебирай струни, щоб видобути моторошну мелодію." }
t[143544] = { en = "Contemplate the power emanating from the demonic skull.", ua = "Споглянь силу, що промениться з демонічного черепа." }
t[143545] = { en = "Contemplate the power of the fel crystal.", ua = "Споглянь силу кристала Скверни." }
t[143660] = { en = "Sound the Mrglgrlhjorn, causing a stampede of murloc tadpoles.", ua = "Засурми у Мрґлґрлгйорн, здійнявши навалу мурлокових пуголовків." }
t[143662] = { en = "Replace your fishing bobber with a wooden Pepe, sure to attract any fish for $d.", ua = "Заміни свій риболовний поплавець на дерев'яного Пепе, що напевно приманить будь-яку рибу, на $d." }
t[143727] = { en = "Enter into a heroic pose to impress those around you.", ua = "Стань у героїчну позу, щоб вразити оточення." }
t[143827] = { en = "Wear a dragon's head costume.", ua = "Вдягни костюм голови дракона." }
t[143828] = { en = "Wear a dragon's body costume.", ua = "Вдягни костюм тулуба дракона." }
t[143829] = { en = "Wear a dragon's tail costume.", ua = "Вдягни костюм хвоста дракона." }
t[144072] = { en = "Release your adopted puppies for $d of fun.", ua = "Випусти своїх прийомних цуценят на $d розваги." }
t[144339] = { en = "Summon a Sturdy Love Fool at target location for $d. The Sturdy Love Fool acts as a target dummy while it persists.", ua = "Приклич Міцного Закоханого Дурника у вказане місце на $d. Поки він існує, править за манекен-ціль." }
t[144393] = { en = "Perform an emergency yak wash in the field.", ua = "Виконай аварійне миття яка в польових умовах." }
t[147307] = { en = "Replace your fishing bobber with a carved Vrykul helm, sure to attract any fish for $d.", ua = "Заміни свій риболовний поплавець на різьблений шолом врикулів, що напевно приманить будь-яку рибу, на $d." }
t[147308] = { en = "Replace your fishing bobber with an enchanted elven statue, sure to attract any fish for $d.", ua = "Заміни свій риболовний поплавець на зачаровану ельфійську статую, що напевно приманить будь-яку рибу, на $d." }
t[147309] = { en = "Replace your fishing bobber with a carved treant head, sure to attract any fish for $d.", ua = "Заміни свій риболовний поплавець на різьблену голову древотвара, що напевно приманить будь-яку рибу, на $d." }
t[147310] = { en = "Replace your fishing bobber with a totem, sure to attract any fish for $d.", ua = "Заміни свій риболовний поплавець на тотем, що напевно приманить будь-яку рибу, на $d." }
t[147311] = { en = "Replace your fishing bobber with a replica Nightborne gondola, sure to attract any fish for $d.", ua = "Заміни свій риболовний поплавець на копію гондоли нічнонароджених, що напевно приманить будь-яку рибу, на $d." }
t[147312] = { en = "Replace your fishing bobber with a wooden demon hunter head, sure to attract any fish for $d.", ua = "Заміни свій риболовний поплавець на дерев'яну голову мисливця на демонів, що напевно приманить будь-яку рибу, на $d." }
t[147537] = { en = "Calls forth your ally, Demon Hunter Pepe, to ride on your head as you slay demons together.", ua = "Прикликає твого союзника, Пепе — мисливця на демонів, щоб сидів у тебе на голові, поки ви разом убиваєте демонів." }
t[147708] = { en = "Begin a Legion attack simulation!", ua = "Розпочни симуляцію атаки Легіону!" }
t[147832] = { en = "Allows a target battle pet to fly alongside you on a magical disc.", ua = "Дозволяє обраному бойовому улюбленцю летіти поряд із тобою на магічному диску." }
t[147838] = { en = "Pull a rabbit out of the hat!", ua = "Витягни кролика з капелюха!" }
t[147843] = { en = "Take on the guise of a Warden.", ua = "Прибери подобу Вартового." }
t[147867] = { en = "Place your Pilfered Sweeper on the ground. It is very low on energy and won't last for long.", ua = "Постав свій Поцуплений Підмітальник на землю. У нього майже не лишилося енергії, тож довго він не протримається." }
t[150547] = { en = "Raise the Black.", ua = "Підніми чорний прапор." }
t[150743] = { en = "Discover flight points and reveal maps around Kalimdor.", ua = "Відкриває польотні точки й розкриває карти довкола Калімдору." }
t[150744] = { en = "Discover flight points and reveal maps around Kalimdor.", ua = "Відкриває польотні точки й розкриває карти довкола Калімдору." }
t[150745] = { en = "Discover flight points and reveal maps around Eastern Kingdoms.", ua = "Відкриває польотні точки й розкриває карти довкола Східних Королівств." }
t[150746] = { en = "Discover flight points and reveal maps around Eastern Kingdoms.", ua = "Відкриває польотні точки й розкриває карти довкола Східних Королівств." }
t[151016] = { en = "Consume the soul of target critter to summon a portal to the Black Temple.", ua = "Спожий душу обраного звіряти, щоб прикликати портал до Чорного Храму." }
t[151184] = { en = "Throw the Verdant Sphere near a friendly targeted player. If caught, the ally will immediately throw another.", ua = "Кинь Зелену Сферу біля дружнього гравця. Якщо він упіймає, союзник одразу кине ще одну." }
t[151265] = { en = "Channel an epic Blight Boar performance.", ua = "Влаштуй епічний виступ гурту «Чорні Вепри»." }
t[151270] = { en = "Wear a horse tail costume.", ua = "Вдягни костюм кінського хвоста." }
t[151271] = { en = "Wear a horse head costume.", ua = "Вдягни костюм кінської голови." }
t[151343] = { en = "Set up the Hearthstation.\n\nCooldown reduced during Feast of Winter Veil.", ua = "Постав Гартстейшн.\n\nПерезарядження скорочене під час Свята Зимової Завіси." }
t[151344] = { en = "Set up the Hearthstation.\n\nCooldown reduced during Feast of Winter Veil.", ua = "Постав Гартстейшн.\n\nПерезарядження скорочене під час Свята Зимової Завіси." }
t[151348] = { en = "Equip the weapon set.\n\nCooldown reduced during Feast of Winter Veil.", ua = "Спорядь комплект зброї.\n\nПерезарядження скорочене під час Свята Зимової Завіси." }
t[151349] = { en = "Equip the weapon set.\n\nCooldown reduced during Feast of Winter Veil.", ua = "Спорядь комплект зброї.\n\nПерезарядження скорочене під час Свята Зимової Завіси." }
t[151652] = { en = "Teleports the player to a random location on Argus.", ua = "Телепортує гравця у випадкове місце на Аргусі." }
t[151877] = { en = "Summon a barrel containing mystery eyepatches for you and all your friends. You'll Barrel-y Believe The Results!", ua = "Приклич діжку з таємничими пов'язками на око для себе й усіх друзів. Ти ледве-діжці повіриш у результати!" }
t[152556] = { en = "Summon a Trawler Totem, granting $251216s1 Fishing skill to all nearby players for $d.", ua = "Приклич Тотем Траулера, що дає $251216s1 навички Риболовлі всім гравцям поруч на $d." }
t[152574] = { en = "Use on another player to search their pockets for shiny baubles.", ua = "Використай на іншому гравцеві, щоб обшукати його кишені в пошуках блискучих цяцьок." }
t[152982] = { en = "Disguise yourself as a wyrmtongue treasure-collector for $D.", ua = "Перекинься на змієязикого збирача скарбів на $D." }
t[153004] = { en = "Temporarily tears a hole into the Twisting Nether for $D, allowing travel for those... brave enough?", ua = "Тимчасово прориває на $D діру у Викривлений Нижній Світ, дозволяючи подорож тим... хто досить сміливий?" }
t[153039] = { en = "Ignite a campfire of crystals, allowing cooking.", ua = "Запали багаття з кристалів, дозволяючи готувати їжу." }
t[153124] = { en = "Deploy a turret capable of annihilating nearby critters.", ua = "Встанови турель, здатну винищувати дрібних тваринок поблизу." }
t[153126] = { en = "Summon and control a Felburst Micro-Artillery.", ua = "Приклич скверновибухову мікроартилерію й керуй нею." }
t[153179] = { en = "Summon a blue rune of power above your head.", ua = "Приклич синю руну сили над своєю головою." }
t[153180] = { en = "Summon a yellow rune of power above your head.", ua = "Приклич жовту руну сили над своєю головою." }
t[153181] = { en = "Summon a red rune of power above your head.", ua = "Приклич червону руну сили над своєю головою." }
t[153182] = { en = "Throw the sphere to a friendly player. If possible, they will automatically return it.", ua = "Кинь сферу дружньому гравцеві. Якщо зможе, він автоматично поверне її." }
t[153183] = { en = "Create a temporary barrier.", ua = "Створює тимчасовий бар'єр." }
t[153193] = { en = "Summons a ridable spectral talbuk on Argus. This is a very, VERY fast mount.", ua = "Прикликає їздового примарного талбака на Аргусі. Це дуже, ДУЖЕ швидка їздова тварина." }
t[153194] = { en = "Allows you to see far into the distance and grants the ability to summon beacons there to attract Legion forces.", ua = "Дозволяє тобі бачити далеко вдалину й дає здатність прикликати туди маяки, щоб привабити сили Легіону." }
t[153204] = { en = "Summon the Eye of the All-Seer, allowing the caster to see through the target's eyes and offer insights to the target for $d.", ua = "Приклич Око Всевидця, щоб бачити очима цілі й ділитися з нею прозріннями на $d." }
t[153253] = { en = "Summons an S.F.E. Interceptor and binds your vision to it. The Interceptor is slightly stealthed and moves very quickly, but is somewhat fragile.", ua = "Прикликає Перехоплювач С.Ф.Е. й прив'язує твій зір до нього. Перехоплювач злегка невидимий і рухається дуже швидко, та доволі тендітний." }
t[153293] = { en = "Makes you very difficult to detect for $d.\n\n\n\nOnly usable on Argus and the Broken Isles.", ua = "Робить тебе дуже важким для виявлення на $d.\n\n\n\nМожна використати лише на Аргусі та Розбитих Островах." }
t[156649] = { en = "Create an attackable effigy of your current target.", ua = "Створює подобизну твоєї поточної цілі, яку можна атакувати." }
t[156833] = { en = "Call through sleet and snow to Katy Stampwhistle, Postmaster's Assistant extraordinaire. Katy will deliver and retrieve mail for $d, or until she is called elsewhere.", ua = "Поклич крізь сльоту та сніг Кейті Стемпвісл, неперевершену помічницю поштмейстера. Кейті доставлятиме й забиратиме пошту $d або поки її не покличуть деінде." }
t[156871] = { en = "Bring forth your own little sea slug friend.", ua = "Приклич власного маленького приятеля — морського слимака." }
t[158149] = { en = "Designed to make your friends look adorable!\n\nCooldown reduced during WoW's Anniversary.", ua = "Створено, щоб твої друзі мали чарівний вигляд!\n\nПерезарядження скорочене під час Річниці WoW." }
t[159749] = { en = "Causes you to glow from heat and leave flames in your wake for $d.", ua = "Змушує тебе світитися від жару й лишати полум'я по собі на $d." }
t[159753] = { en = "Play a tune of the desert, encouraging the small critters of Vol'dun to accompany you for $d. They happily follow you everywhere you go!", ua = "Заграй пустельну мелодію, спонукаючи дрібних звіряток Вол'дуну супроводжувати тебе протягом $d. Вони радо йдуть за тобою всюди!" }
t[160509] = { en = "Let loose a devilish roar.", ua = "Видай диявольський рик." }
t[160740] = { en = "Summon a plague of toads.", ua = "Приклич навалу жаб." }
t[160751] = { en = "Summons a ghostly dancing witch.", ua = "Прикликає примарну танцівницю-відьму." }
t[161342] = { en = "Submit to a creature from the void.", ua = "Підкорися істоті з Порожнечі." }
t[162539] = { en = "Munch on some popcorn.", ua = "Похрумай попкорном." }
t[162642] = { en = "Equip the armor set.\n\nCooldown reduced during Feast of Winter Veil.", ua = "Спорядь комплект броні.\n\nПерезарядження скорочене під час Свята Зимової Завіси." }
t[162643] = { en = "Equip the armor set.\n\nCooldown reduced during Feast of Winter Veil.", ua = "Спорядь комплект броні.\n\nПерезарядження скорочене під час Свята Зимової Завіси." }
t[162973] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[163045] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[163200] = { en = "Look into the distance and see what the scurvy naves are up to, yarr!", ua = "Вдивися в далечінь і поглянь, шо там замишляють ті лайдаки, йо-хо-хо!" }
t[163201] = { en = "Summon a Gnoll Targeting Barrel at the target location for $d.  The barrel acts as a target dummy while it persists.\n\n\n\nOnly usable outdoors in Kul Tiras and Zandalar.", ua = "Приклич гнолячу мішень-бочку у вказане місце на $d.  Поки бочка існує, вона править за манекен-ціль.\n\n\n\nМожна використати лише просто неба в Кул Тірасі та Зандаларі." }
t[163210] = { en = "Get the mojo flowing.", ua = "Розворуши моджо." }
t[163211] = { en = "Prepare a campfire and use Akunda's Firesticks to get a spark. The fire increases the Versatility of those nearby by $7353s1 and allows cooking.", ua = "Розклади багаття й скористайся Вогнепалицями Акунди, щоб викресати іскру. Вогонь підвищує Універсальність тих, хто поруч, на $7353s1 і дозволяє готувати." }
t[163463] = { en = "Call the souls of the deceased.", ua = "Приклич душі померлих." }
t[163603] = { en = "Sends you back in time to before the coven arrived. Only usable in Whitegrove Chapel.", ua = "Переносить тебе в минуле, до появи ковена. Можна використати лише в Каплиці Білого Гаю." }
t[163607] = { en = "Prick the target to see if they're a witch in disguise.", ua = "Вколи ціль, щоб дізнатися, чи не відьма це під личиною." }
t[163697] = { en = "Fire a laser pointer at the ground.  Perhaps something will chase it.", ua = "Посвіти лазерною указкою по землі.  Може, хтось за нею поженеться." }
t[163704] = { en = "Drop a tiny robot mouse for your companion pet to chase around for $d.", ua = "Кинь крихітну робо-мишку, щоб твій улюбленець ганявся за нею $d." }
t[163705] = { en = "Shoot an imaginary gun at your Companion Pet, causing it to play dead for $d.", ua = "Вистріли з уявної рушниці у свого улюбленця-супутника, щоб той прикинувся мертвим на $d." }
t[163713] = { en = "Places a small brazier on your head.", ua = "Ставить маленьку жарівницю тобі на голову." }
t[163735] = { en = "Make a loud, annoying sound, startling everyone within $A1 yards.", ua = "Видай гучний, набридливий звук, лякаючи всіх у радіусі $A1 ярдів." }
t[163736] = { en = "Take on a spectral visage.", ua = "Прибери примарну подобу." }
t[163738] = { en = "Wear a Syndicate mask, replacing any existing headwear.", ua = "Вдягни маску Синдикату, замінивши будь-який наявний головний убір." }
t[163740] = { en = "Perform a ritual sacrifice, offering the target's soul to the Drust. Useable only on the recently deceased.", ua = "Проведи ритуальне жертвоприношення, пропонуючи душу цілі друстам. Можна використати лише на нещодавно померлих." }
t[163741] = { en = "Throw to a friendly player. If possible, they will automatically return it.", ua = "Кинь дружньому гравцеві. Якщо зможе, він автоматично поверне це." }
t[163742] = { en = "Places the user under the spell of the Heartsbane Coven.", ua = "Накладає чари ковену Серцезгуби на того, хто скористався предметом." }
t[163744] = { en = "Summons a light snowfall.", ua = "Прикликає легкий снігопад." }
t[163745] = { en = "Places a forest troll gong.", ua = "Ставить гонг лісових тролів." }
t[163750] = { en = "Grants the appearance of (a small) Kovork.", ua = "Надає вигляду (маленького) Коворка." }
t[163775] = { en = "Wear a stone Molok head.", ua = "Вдягни кам'яну голову Молока." }
t[163795] = { en = "Take on the guise of an Oomgut pygmy.", ua = "Прибери подобу пігмея Умґут." }
t[163828] = { en = "Summon and control this toy.", ua = "Приклич цю іграшку й керуй нею." }
t[163829] = { en = "Summon and control this toy.", ua = "Приклич цю іграшку й керуй нею." }
t[163924] = { en = "Put the candle on your head.", ua = "Постав свічку собі на голову." }
t[163986] = { en = "Plant an Orgrimmar Hero's War Banner. \n\n\n\nFor the Horde!", ua = "Встанови Бойовий Прапор Героя Оґриммара. \n\n\n\nЗа Орду!" }
t[163987] = { en = "Plant a Stormwind Champion's War Banner.\n\n\n\nFor the Alliance!", ua = "Встанови Бойовий Прапор Чемпіона Стормвінда.\n\n\n\nЗа Альянс!" }
t[164310] = { en = "Represent your faction!", ua = "Вболівай за свою фракцію!" }
t[164373] = { en = "Prepare the soup to disguise yourself as a trogg for $d.", ua = "Звари юшку, щоб на $d прибрати подобу троґґа." }
t[164374] = { en = "Disguise yourself as a Hozen for $d.", ua = "Перекинься на хозена на $d." }
t[164375] = { en = "Shed your regular humanoid shell for a more simian bone structure for $d.", ua = "Скинь свою звичну гуманоїдну оболонку заради більш мавпячої будови кістяка на $d." }
t[164983] = { en = "Hide, Goldtusk Gang-style! Can only be used in Kul Tiras and Zandalar.", ua = "Сховайся в стилі Банди Золотого Ікла! Можна використати лише в Кул Тірасі та Зандаларі." }
t[165021] = { en = "Accept Akunda's gift.", ua = "Прийми дар Акунди." }
t[165669] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[165670] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[165671] = { en = "Wear a dragon's head costume.", ua = "Вдягни костюм голови дракона." }
t[165672] = { en = "Wear a dragon's body costume.", ua = "Вдягни костюм тулуба дракона." }
t[165673] = { en = "Wear a dragon's tail costume.", ua = "Вдягни костюм хвоста дракона." }
t[165674] = { en = "Wear a dragon's head costume.", ua = "Вдягни костюм голови дракона." }
t[165675] = { en = "Wear a dragon's body costume.", ua = "Вдягни костюм тулуба дракона." }
t[165676] = { en = "Wear a dragon's tail costume.", ua = "Вдягни костюм хвоста дракона." }
t[165791] = { en = "Don a brown cloak and hood, potentially confusing assassins looking for someone dressed similarly.", ua = "Вдягни брунатний плащ із каптуром, щоб, можливо, збити з пантелику вбивць, які шукають когось у схожому вбранні." }
t[165802] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[166247] = { en = "Summons a member of the Citizens Brigade.", ua = "Прикликає учасника Громадянської Бригади." }
t[166308] = { en = "Trade your blood to the blood god, and be disguised as a blood troll for $d.", ua = "Віддай свою кров кривавому богу й обернися на кривавого троля на $d." }
t[166461] = { en = "Allows you to surf across water.", ua = "Дозволяє тобі серфити по воді." }
t[166544] = { en = "Change your appearance to look like a Dark Ranger for $d.", ua = "Зміни свій вигляд на подобу Темного вартового на $d." }
t[166662] = { en = "Summons a very cranky crab for your battle pet to ride on.", ua = "Прикликає дуже сварливого краба, на якому їздитиме твій бойовий улюбленець." }
t[166663] = { en = "Use the anchor as a weapon.", ua = "Використай якір як зброю." }
t[166678] = { en = "Beseech Brynja from death to serve as your spirit healer for $d.", ua = "Виблагай Брюнью з-за смерті, щоб служила твоїм духом-цілителем на $d." }
t[166701] = { en = "Feed a fallen ally to ravasaurs.", ua = "Згодуй полеглого союзника равазаврам." }
t[166702] = { en = "Places an ornately crafted wind up music box bearing the Proudmoore crest.", ua = "Ставить вигадливо оздоблену заводну музичну скриньку з гербом Праудмурів." }
t[166703] = { en = "Lay out a breakfast buffet fit for a king, de best de Goldtusk Inn has to offer.", ua = "Влаштуй королівський сніданок-фуршет, найкраще, шо є в заїзді «Золоте Ікло»." }
t[166704] = { en = "Lay out a bowl of glowing pufferfish.", ua = "Виклади миску сяйливих риб-куль." }
t[166743] = { en = "Summon and control your Blight Bomber.", ua = "Прикличте свій Бомбардувальник Чуми й керуйте ним." }
t[166744] = { en = "Summon and control your Glaive Tosser.", ua = "Прикличте свій Метальник Глеф і керуйте ним." }
t[166746] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[166747] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[166777] = { en = "Set off a firework on the fresh corpse of a Horde player.", ua = "Запусти феєрверк над свіжим трупом гравця Орди." }
t[166778] = { en = "Set off a firework on the fresh corpse of an Alliance player.", ua = "Запусти феєрверк над свіжим трупом гравця Альянсу." }
t[166779] = { en = "Summons an Ethereal Transmorpher that can change your appearance for $290215d.", ua = "Прикликає ефіріала-Трансморфера, який може змінити твою зовнішність на $290215d." }
t[166784] = { en = "Trap the target's soul inside Narassin's Soul Gem. Only usable on dead targets.", ua = "Ув'язни душу цілі в Самоцвіті Душі Нарассіна. Можна використати лише на мертвих цілях." }
t[166785] = { en = "Throws a Detoxified Blight Grenade at the target, covering them in Detoxified Blight.", ua = "Кидає в ціль Знешкоджену Чумну Гранату, вкриваючи ціль Знешкодженою Чумою." }
t[166790] = { en = "Allow yourself to be possessed by a Highborne spirit.", ua = "Дозволь духу Високородної заволодіти тобою." }
t[166808] = { en = "Lay out a bewitching tea party for your friends.", ua = "Влаштуй для друзів чаклунське чаювання." }
t[166851] = { en = "Play a round of Kojo's expanded shell game.", ua = "Зіграй раунд розширеної гри в шкаралупки Коджо." }
t[166877] = { en = "Launch unstable Azerite skyward in a dazzling display.", ua = "Запусти нестабільний азерит у небо сліпучим феєрверком." }
t[166879] = { en = "Plant a war banner and rally nearby troops!", ua = "Встанови бойовий стяг і згуртуй війська поблизу!" }
t[166880] = { en = "Set up a rickety jukebox featuring Meerah's greatest hit!", ua = "Постав розхитаний музичний автомат із найбільшим хітом Міри!" }
t[167698] = { en = "Allows the wearer to see secret fish.", ua = "Дозволяє носієві бачити таємну рибу." }
t[167931] = { en = "Equipped with Mechagonian Steel Sawblades.", ua = "Оснащено мехагонськими сталевими пиляльними дисками." }
t[168012] = { en = "Some luminous latent power still lingers in this splinter of an Apexis shard.", ua = "У цьому уламку кристала Апексіс досі жевріє якась світна прихована сила." }
t[168014] = { en = "Don the banner of the Burning Blade clan.", ua = "Вдягни прапор клану Палаючого Клинка." }
t[168016] = { en = "Create a Hyper-Compressed Ocean.", ua = "Створює Гіперстиснений Океан." }
t[168123] = { en = "Receive the gift of N'Zoth.", ua = "Прийми дар Н'Зота." }
t[168667] = { en = "Assembles the upgraded Blingtron 7000, a savage, yet generous, robot.  While he will give out gifts to players once per day, he will also fight other Blingtron units to the death.", ua = "Збирає вдосконаленого Блінгтрона 7000, дикого, та все ж щедрого робота. Хоч він і видає подарунки гравцям раз на день, він також битиметься з іншими Блінгтронами на смерть." }
t[168807] = { en = "Teleports the player to a random location on Kul Tiras.", ua = "Телепортує гравця у випадкове місце на Кул-Тірасі." }
t[168808] = { en = "Teleports the player to a random location on Zandalar.", ua = "Телепортує гравця у випадкове місце на Зандаларі." }
t[168824] = { en = "Immerse yourself in the sounds of the ocean.", ua = "Занурся у звуки океану." }
t[168907] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[169108] = { en = "Deploy a holographic Rustbolt banner.", ua = "Встанови голографічний прапор Іржоболту." }
t[169275] = { en = "Carry an Alliance War Banner. Can be used while mounted. \n\n\n\nEntering combat will remove the banner.", ua = "Неси бойовий прапор Альянсу. Можна використати верхи. \n\n\n\nВступ у бій прибере прапор." }
t[169276] = { en = "Carry a Horde War Banner. Can be used while mounted.\n\n\n\nEntering combat will remove the banner.", ua = "Неси бойовий прапор Орди. Можна використати верхи.\n\n\n\nВступ у бій прибере прапор." }
t[169277] = { en = "Carry a Horde War Standard. Your movement speed is slightly hindered.\n\n\n\nEntering combat will remove the banner.", ua = "Неси бойовий штандарт Орди. Твоя швидкість руху трохи знижена.\n\n\n\nВступ у бій прибере прапор." }
t[169278] = { en = "Carry a Alliance War Standard. Your movement speed is slightly hindered.\n\n\n\nEntering combat will remove the banner.", ua = "Неси бойовий штандарт Альянсу. Твоя швидкість руху трохи знижена.\n\n\n\nВступ у бій прибере прапор." }
t[169297] = { en = "Returns you to the sanctuary of Dun Baldar.", ua = "Повертає тебе до святині Дун Балдара." }
t[169298] = { en = "Returns you to the sanctuary of Frostwolf Keep.", ua = "Повертає тебе до святині Замку Морозного Вовка." }
t[169303] = { en = "Flex, increasing arm power for $d.", ua = "Напруж м'язи, збільшивши силу рук на $d." }
t[169347] = { en = "Create hologram of King Mechagon.", ua = "Створює голограму короля Мехагона." }
t[169768] = { en = "Hold the Heart of Azeroth in your hand.", ua = "Потримай Серце Азероту в руці." }
t[169796] = { en = "Summon the base and display a figure from your collection.", ua = "Приклич підставку й вистав фігурку зі своєї колекції." }
t[169865] = { en = "Proudly display your Brewfest Chowdown Trophy!", ua = "Гордо покажи свій Трофей Об'їдайла Хмільного Свята!" }
t[170154] = { en = "Read the book and recall the memories of the Unshackled.", ua = "Прочитай книгу й пригадай спогади Розкутих." }
t[170155] = { en = "Hold the charm and recall the memories of the Ankoan.", ua = "Потримай оберіг і пригадай спогади анкоанів." }
t[170187] = { en = "Grasp the shadows around the scale, and perceive the world as if it were midnight.", ua = "Схопи тіні довкола луски й побач світ таким, наче настала північ." }
t[170196] = { en = "Place a Warning Sign that lasts for $d. A message can be carved into the sign, causing it to last for $148628d and making it visible to other players.", ua = "Постав застережний знак, що триває $d. На знаку можна вирізьбити повідомлення, і тоді він триватиме $148628d та стане видимим для інших гравців." }
t[170197] = { en = "Place a Warning Sign that lasts for $d. A message can be carved into the sign, causing it to last for $148628d and making it visible to other players.", ua = "Постав застережний знак, що триває $d. На знаку можна вирізьбити повідомлення, і тоді він триватиме $148628d та стане видимим для інших гравців." }
t[170198] = { en = "Prepare for dinner.", ua = "Приготуйся до вечері." }
t[170199] = { en = "Equip a naga weapon.", ua = "Спорядь зброю наги." }
t[170203] = { en = "Place the fish down and kick it around.", ua = "Поклади рибу на землю й поганяй її ногами." }
t[170204] = { en = "Believe in Gral and be blessed.", ua = "Увіруй у Ґрала й здобудь благословення." }
t[170380] = { en = "Sprinkle the dust, and perceive the world as if it were midday.", ua = "Розсип пісок і сприймай світ так, наче надворі полудень." }
t[170469] = { en = "Place a seashell on the ground. Interacting with the memento fills you with memories of adventures in Nazjatar with your allies.", ua = "Постав мушлю на землю. Взаємодія з цією пам'яткою наповнює тебе спогадами про пригоди в Назжатарі разом із союзниками." }
t[170476] = { en = "Place the lamp.", ua = "Постав лампу." }
t[172179] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[172219] = { en = "Transform your mount into something wildly festive.\n\n\n\nCan only be used during Feast of Winter Veil.", ua = "Перетвори свою їздову тварину на щось шалено святкове.\n\n\n\nМожна використати лише під час Свята Зимової Завіси." }
t[172222] = { en = "Summon and control your Crashin' Thrashin' Juggernaught.", ua = "Прикличте свій Трощо-Громовий Дредноут і керуйте ним." }
t[172223] = { en = "Summon and control your Crashin' Thrashin' Battleship.", ua = "Прикличте свій Трощо-Громовий Лінкор і керуйте ним." }
t[172924] = { en = "Open a wormhole that allows the user to quickly travel to one of several fixed points within the Shadowlands.", ua = "Відкриває червоточину, що дозволяє швидко перенестися до однієї з кількох фіксованих точок у Тіньокраї." }
t[173727] = { en = "Consumes a sip of Nomi's Vintage, delivering a fiery burst to the senses! Only useable within Zandalar, Kul Tiras, and Nazjatar.", ua = "Спожий ковток Витриманого Вина Номі, що дарує вогняний вибух відчуттів! Використати можна лише в Зандаларі, Кул-Тірасі та Назжатарі." }
t[173951] = { en = "Sacrifice part of your mortal essence, dealing $m3% of your maximum health in Shadow damage to yourself.\n\n\n\nIn exchange you become Shath'Yar, breaking your normal faction allegiance, serving only N'Zoth.\n\n\n\nN'lyeth can only be used outdoors in Kul Tiras, Zandalar and during Visions of N'Zoth while in War Mode.", ua = "Пожертвуй частину своєї смертної сутності, завдавши собі $m3% максимального здоров'я тіньовою шкодою.\n\n\n\nНатомість ти стаєш Шат'Яром, розриваючи звичну вірність фракції та служачи лише Н'Зоту.\n\n\n\nН'льєт можна використати лише просто неба в Кул-Тірасі, Зандаларі та під час Видінь Н'Зота в режимі війни." }
t[173984] = { en = "Echo the appearance of a newly arrived soul.", ua = "Відлунюй подобу щойно прибулої душі." }
t[174445] = { en = "Gently open up the cocoon.", ua = "Обережно розкрий кокон." }
t[174830] = { en = "Disguise yourself as a shadowy figure for $d.", ua = "Перекинься на тіньову постать на $d." }
t[174871] = { en = "Gain control over your companion pet for $316932d.", ua = "Візьми під контроль свого улюбленця на $316932d." }
t[174873] = { en = "Turn yourself into a member of one of the four warring Mogu clans.", ua = "Обернися на представника одного з чотирьох ворожих кланів моґу." }
t[174874] = { en = "Call forth a friend from the deep to rest atop your head.", ua = "Приклич приятеля з глибин, щоб влаштувався в тебе на голові." }
t[174920] = { en = "Place Coifcurl's Close Shave Kit on the ground at your feet for you and others to peruse. WARNING: Shave kit may be under dark influence. Satisfaction is not guaranteed!", ua = "Постав Набір для Гладкого Гоління Койфкерла на землю собі під ноги, щоб ти та інші могли ним скористатися. УВАГА: набір для гоління може бути під темним впливом. Задоволення не гарантоване!" }
t[174921] = { en = "Throw the skull to a friendly target to begin the game. Don't get caught with it when it releases its void energy or you lose!", ua = "Кинь череп дружній цілі, щоб почати гру. Не залишайся з ним, коли він вивільнить енергію Порожнечі, бо програєш!" }
t[174924] = { en = "Place the totem at your feet. WARNING! Keep away from small critters, unless you want them big and angry.", ua = "Постав тотем собі під ноги. УВАГА! Тримай подалі від дрібних звіряток, якщо не хочеш, щоб вони стали великими й лютими." }
t[174926] = { en = "Allows you to see void threats, wherever they might be crawling.", ua = "Дозволяє тобі бачити загрози Порожнечі, хоч би де вони повзали." }
t[174928] = { en = "Place the rotten apple on the ground and of course leave it alone...", ua = "Поклади гниле яблуко на землю і, звісно ж, дай йому спокій..." }
t[174995] = { en = "A more fitting leash for your void-touched pets or... to keep your other small creatures in line.", ua = "Доречніший повідець для твоїх торкнутих Порожнечею улюбленців або... щоб тримати в шорах інших дрібних створінь." }
t[175063] = { en = "Throws an Aqir Egg Cluster at the target, swarming them with aqir.", ua = "Кидає в ціль Кладку Яєць Акірів, обсідаючи її акірами." }
t[175140] = { en = "N'Zoth gifts you with All-Seeing Eyes.", ua = "Н'Зот дарує тобі Всевидющі Очі." }
t[177951] = { en = "Summon a cluster of Glimmerflies to lift your spirit, granting you the ability to float over land and water.", ua = "Приклич рій мерехтокрилок, щоб підняти твій дух і дати змогу ширяти над землею та водою." }
t[178530] = { en = "Throw the wreath to a friendly player. If possible, they will automatically return it.", ua = "Кинь вінок дружньому гравцеві. Якщо зможе, він автоматично поверне його." }
t[179393] = { en = "Give yourself an Envious Glimmer to look like a great $@class of old.", ua = "Огорни себе Заздрісним Сяйвом, щоб виглядати як великий $@class з давнини." }
t[180290] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.\n\n\n\nCan only be used by those pledged to the Night Fae.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки.\n\n\n\nМожуть використовувати лише ті, хто присягнув Нічним Феям." }
t[180873] = { en = "Concentrate on the stone to cause your shoulders to smolder for $d.", ua = "Зосередься на камені, щоб твої плечі жевріли на $d." }
t[180947] = { en = "Place the Tithe Collector's Vessel on your back for $d.", ua = "Почепи Посудину Збирача Десятини собі на спину на $d." }
t[180993] = { en = "Replace your fishing bobber with a bobbing bat visage for $d.", ua = "Заміни свій риболовний поплавець на подобу кажана, що погойдується на воді, на $d." }
t[181794] = { en = "Sing an Orophean Dirge for $d, forcing players within $s1 yards to cry uncontrollably.", ua = "Заспівай орофейську жалобну пісню на $d, змушуючи гравців у радіусі $s1 ярдів невтримно ридати." }
t[181825] = { en = "The slime contained is ravenous and uncontrollable, devouring party members and dealing damage to them. Only usable outdoors in the Shadowlands.", ua = "Слиз усередині ненажерливий і некерований: він пожирає учасників групи й завдає їм шкоди. Можна використати лише просто неба в Тіньокраї." }
t[182694] = { en = "Pull out a black parasol for $d, allowing you to safely float down the next time you fall.", ua = "Розкрий чорну парасольку на $d, щоб безпечно спланерувати додолу наступного разу, коли впадеш." }
t[182695] = { en = "Pull out a purple parasol for $d, allowing you to safely float down the next time you fall.", ua = "Розкрий фіолетову парасольку на $d, щоб безпечно спланерувати додолу наступного разу, коли впадеш." }
t[182696] = { en = "Pull out a green parasol for $d, allowing you to safely float down the next time you fall.", ua = "Розкрий зелену парасольку на $d, щоб безпечно спланерувати додолу наступного разу, коли впадеш." }
t[182729] = { en = "A mystical dragon plume gently slows your fall for $d.\n\n\n\nOnly usable in the Shadowlands.", ua = "Містичний драконячий плюмаж м'яко сповільнює твоє падіння на $d.\n\n\n\nМожна використати лише в Тіньокраї." }
t[182732] = { en = "Consume an Enchanting Vellum to flip through the pages of the book, granting you a random effect scrawled on the pages.", ua = "Спожий Пергамент для чарування, щоб погортати сторінки книги, отримавши випадковий ефект, нашкрябаний на сторінках." }
t[182773] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[182780] = { en = "Increases the Versatility of those nearby by $7353s1 and allows cooking.", ua = "Збільшує Універсальність тих, хто поруч, на $7353s1 і дозволяє готувати їжу." }
t[182890] = { en = "Pull out your quill and parchment and dictate a great epic... or your auction house list.", ua = "Дістань перо та пергамент і продиктуй великий епос... чи свій список для аукціону." }
t[183716] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.\n\n\n\nCan only be used by those pledged to the Venthyr.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки.\n\n\n\nМожуть використовувати лише ті, хто присягнув вентирам." }
t[183847] = { en = "Disguise yourself as an acolyte of the House of Rituals. Cooldown reduced if applied while in Maldraxxus.\n\n\n\nCan only be used by those pledged to the Necrolords.", ua = "Перекинься на послушника Дому Ритуалів. Перезарядження скорочене, якщо застосувати в Малдраксусі.\n\n\n\nДоступно лише тим, хто присягнув Некролордам." }
t[183856] = { en = "Find your inner calm wherever you may be.", ua = "Віднайди внутрішній спокій будь-де." }
t[183876] = { en = "Send a letter to one of your best friends from the Ember Court. Within a day, they will write back to you in the mail.", ua = "Надішли листа одному зі своїх найкращих друзів із Двору Жарин. Протягом дня вони відпишуть тобі поштою." }
t[183900] = { en = "Serve tea with your Sinvyr Tea Set.", ua = "Подай чай зі свого Сінвірового чайного сервізу." }
t[183901] = { en = "Unleash the little Bonestorm spinning across the ground.", ua = "Випусти маленьку Кістяну Бурю, що закружляє по землі." }
t[183903] = { en = "Inhale the vapors, causing your form to transform into a Slime Giant for $d.", ua = "Вдихни випари, і твоя подоба перетвориться на Слизового Велетня на $d." }
t[183986] = { en = "Activate to gain insight from the sinstone.", ua = "Активуй, щоб отримати прозріння від каменя гріха." }
t[183988] = { en = "Activate to gain insight from the val'kyr.", ua = "Активуй, щоб отримати прозріння від валькіри." }
t[183989] = { en = "Jump in the dredger's wheelbarrow. Requires at least Journeyman Riding.", ua = "Стрибни в тачку землекопа. Потребує щонайменше «Їзди підмайстра»." }
t[184075] = { en = "Place the sentry in the ground to warn off unwanted entities from entering the area.", ua = "Встанови вартового в землю, щоб відлякувати небажаних істот від входу в цю місцевість." }
t[184218] = { en = "Place the Vulgarity Arbiter on the ground so you and your allies can atone for your vulgarity.", ua = "Постав Арбітра Непристойності на землю, щоб ти та твої союзники могли спокутувати свою непристойність." }
t[184223] = { en = "Don the helm, allowing you to pose as one of the mawsworn.", ua = "Вдягни шолом, щоб видати себе за одного з присяжних Пащі." }
t[184292] = { en = "Toss a coin at your target. They're as good as dead.", ua = "Кинь монету в ціль. Вона вже вважай мертва." }
t[184312] = { en = "Draw power from this fragment of Borr-Geth, summoning a pillar of flame underneath your feet and sending yourself flying into the air. Can only be used in The Maw.", ua = "Черпни силу з цього уламка Борр-Гета, здіймаючи стовп полум'я під ногами й підкидаючи себе в повітря. Використовується лише в Пащі." }
t[184318] = { en = "Conjure a spectral visage of Margrave Krexus.", ua = "Створи чарами примарну подобу маркграфа Крексуса." }
t[184353] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.\n\n\n\nCan only be used by those pledged to the Kyrian.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки.\n\n\n\nМожуть використовувати лише ті, хто присягнув Кіріанам." }
t[184396] = { en = "Snap the gauntlet's fingers, instantly destroying half the critters within 40 yards.", ua = "Клацни пальцями рукавиці, миттєво знищивши половину дрібних створінь у радіусі 40 ярдів." }
t[184404] = { en = "Increases the Versatility of those nearby by $7353s1 and allows cooking.", ua = "Збільшує Універсальність тих, хто поруч, на $7353s1 і дозволяє готувати їжу." }
t[184410] = { en = "Deploy a stretcher to carry a wounded ally in comfort.", ua = "Встанови ноші, щоб зручно нести пораненого союзника." }
t[184413] = { en = "Peer into the glass.", ua = "Зазирни у скло." }
t[184415] = { en = "Place a Soothing Vesper at the desired location.", ua = "Постав Заспокійливий Дзвін у бажаному місці." }
t[184418] = { en = "Call an Acrobatic Steward to your side. If more than one is present, they will stack on each other's shoulders to reach great heights.", ua = "Приклич до себе Акробатичного розпорядника. Якщо їх кілька, вони ставатимуть одне одному на плечі, щоб сягнути великих висот." }
t[184435] = { en = "Identify yourself as one of Bastion's chosen, earning the right to speak to an image of Vesiphone, Paragon of Purity, at the precipice of death.\n\n\n\nReplaces your spirit healer for $d.", ua = "Оголоси себе одним з обраних Бастіону, здобувши право говорити з образом Весифони, Взірця Чистоти, на порозі смерті.\n\n\n\nЗамінює твого духа-цілителя на $d." }
t[184447] = { en = "Get a slime ready for a party.", ua = "Приготуй слиз до вечірки." }
t[184449] = { en = "Fire a spooky laser at the ground.  Perhaps something will chase it.", ua = "Посвіти моторошним лазером по землі. Може, хтось за ним поженеться." }
t[184476] = { en = "Pour out a collection of experimental slimes.", ua = "Вилий колекцію експериментальних слизів." }
t[184487] = { en = "Toss a gormling, and it will run back to you!", ua = "Підкинь ґормлінга, і він прибіжить назад до тебе!" }
t[184489] = { en = "Play a soothing melody.", ua = "Заграй заспокійливу мелодію." }
t[184490] = { en = "Play the pipes!", ua = "Заграй на сопілці!" }
t[184495] = { en = "Place an Infested Arachnid Casing nearby.\n\n\n\nDisturb at your own risk.", ua = "Постав поблизу Заражений павучий кокон.\n\n\n\nТурбуй на власний ризик." }
t[184508] = { en = "A mawsworn leash.", ua = "Повідець присяжних Пащі." }
t[186501] = { en = "Summon a trophy signifying your defeat of the Doomwalker.", ua = "Приклич трофей, що засвідчує твою перемогу над Думвокером." }
t[186686] = { en = "Consult the bones to learn your future.", ua = "Поворожи на кістках, щоб дізнатися своє майбутнє." }
t[186702] = { en = "Play a haunting melody, inspiring those around you to dance.", ua = "Заграй бентежну мелодію, надихаючи оточення на танець." }
t[186973] = { en = "Guide your companion pet with an anima leash.", ua = "Веди свого улюбленця на повідці з аніми." }
t[186974] = { en = "Summons a Torghast anima hoard outside of Torghast.", ua = "Прикликає скарбницю аніми Торгаста за межами Торгаста." }
t[186985] = { en = "Drop a tiny bone wielding golem for your companion pet to chase around for $d.", ua = "Кинь крихітного голема з кісткою, щоб твій улюбленець ганявся за ним $d." }
t[187051] = { en = "Give your battle pet the power of the Val'kyr, allowing them to fly alongside you.", ua = "Надай своєму бойовому улюбленцю силу валькір, щоб він літав поруч із тобою." }
t[187075] = { en = "Unleash the Minigrue, who will destroy some nearby toys.", ua = "Випусти Мініґру, який понищить деякі іграшки поблизу." }
t[187113] = { en = "Create your own Personal Ball and Chain to drag around.", ua = "Створи свою власну гирю з ланцюгом, щоб тягати за собою." }
t[187139] = { en = "Break the seal of the bottle allowing the shade within to possess you for a short time.", ua = "Зламай печатку пляшки, дозволивши тіні всередині заволодіти тобою на короткий час." }
t[187140] = { en = "Use some of the remnant magic in the ring to summon a mirror image which copies your actions.", ua = "Використай рештки магії в персні, щоб прикликати дзеркальну копію, яка повторює твої дії." }
t[187154] = { en = "Cast the runes to reveal fate.", ua = "Кинь руни, щоб відкрити долю." }
t[187155] = { en = "Take on the appearance of an attendant of Korthia.", ua = "Прибери вигляд служителя Кортії." }
t[187159] = { en = "Sever the shadow of a target player.", ua = "Відітни тінь гравця-цілі." }
t[187174] = { en = "Judge the soul of the targeted party member. Only usable on the recently deceased.", ua = "Осуди душу вибраного члена групи. Можна використати лише на щойно померлих." }
t[187176] = { en = "Place a vesper of harmony in front of you.", ua = "Постав веспер гармонії перед собою." }
t[187184] = { en = "Place a vesper of clarity in front of you.", ua = "Постав веспер ясності перед собою." }
t[187185] = { en = "Place a vesper of faith in front of you.", ua = "Постав веспер віри перед собою." }
t[187339] = { en = "Summon the Spirit of Ka-Sha to whisk you away for $s1 sec, unless it is tired, then it will just slowly carry you around for $s2 min. Only usable in the Shadowlands.", ua = "Прикличте Дух Ка-Ша, щоб він умчав вас на $s1 сек., а якщо він втомлений — просто повільно поносить вас $s2 хв. Можна використати лише в Тіньокраї." }
t[187344] = { en = "Create an Offering Condensing Kit that you can use to wrap an offering for someone.", ua = "Створює Набір для Пакування Підношень, яким можна загорнути підношення для когось." }
t[187416] = { en = "Enter your own personal cage.", ua = "Увійди у власну персональну клітку." }
t[187417] = { en = "Enter the Jailer's Deluxe cell.", ua = "Увійди в люксову камеру Тюремника." }
t[187419] = { en = "Causes your steward companion to revert to a more youthful form.\n\n\n\nCan only be used by those sworn to the service of the Kyrian.", ua = "Змушує твого слугу-супутника повернутися до молодшого вигляду.\n\n\n\nМоже використати лише той, хто присягнув на службу кіріанам." }
t[187420] = { en = "Summons a miniature shadow realm.", ua = "Прикликає мініатюрний тіньовий світ." }
t[187422] = { en = "Customize your Rockin' Rollin' Racer!", ua = "Налаштуй свій запальний котючий болід!" }
t[187512] = { en = "Helps a critter atone for their sins and move on to the afterlife they justly deserve.\n\n\n\nCan only be used by members of the Venthyr covenant or those who have reached Renown 80 with the Venthyr.", ua = "Допомагає звіряткові спокутувати гріхи й перейти в потойбіччя, на яке воно по праву заслуговує.\n\n\n\nМожуть використовувати лише члени ковенанту вентирів або ті, хто досяг Визнання 80 у вентирів." }
t[187591] = { en = "Become suspicious of your surroundings. Reduced cooldown for Nightborne.", ua = "Насторожися до всього довкола. Скорочене перезарядження для Народжених Ніччю." }
t[187689] = { en = "Summon a dance stage and put on a show!", ua = "Прикличте танцювальну сцену й влаштуйте шоу!" }
t[187705] = { en = "Invoke Choofa's call to summon some fuzzy friends.", ua = "Виклич поклик Чуфи, щоб прикликати пухнастих друзів." }
t[187793] = { en = "Imprison yourself for $d in your own personal containment trap.", ua = "Ув'язни себе на $d у власній пастці-в'язниці." }
t[187834] = { en = "Plant a banner representing your successes against the Tormented.", ua = "Встанови прапор, що уособлює твої успіхи проти Стражденних." }
t[187840] = { en = "Show off your inner faerie with a pair of sparkly wings!\n\n\n\nCan only be used by members of the Night Fae covenant or those who have reached Renown 80 with the Night Fae.", ua = "Прояви свою внутрішню фею парою блискучих крил!\n\n\n\nМожуть використовувати лише члени ковенанту Нічних Фей або ті, хто досяг Визнання 80 у Нічних Фей." }
t[187860] = { en = "Summon a Zereth Mortis sphere to roll around on. Only usable outdoors.", ua = "Прикличте сферу Зерет Мортіс, щоб на ній кататися. Можна використати лише просто неба." }
t[187869] = { en = "Discover flight points and reveal maps around the Shadowlands.", ua = "Відкриває польотні точки й розкриває карти довкола Тіньокраю." }
t[187875] = { en = "Discover flight points and reveal maps around the Broken Isles.", ua = "Відкриває польотні точки й розкриває карти довкола Розколотих Островів." }
t[187895] = { en = "Discover flight points and reveal maps around Draenor.", ua = "Відкриває польотні точки й розкриває карти довкола Дренору." }
t[187896] = { en = "Discover flight points and reveal maps around Pandaria.", ua = "Відкриває польотні точки й розкриває карти довкола Пандарії." }
t[187897] = { en = "Discover flight points and reveal maps established during the Cataclysm.", ua = "Відкриває польотні точки й розкриває карти, що постали під час Катаклізму." }
t[187898] = { en = "Discover flight points and reveal maps around Northrend.", ua = "Відкриває польотні точки й розкриває карти довкола Нортренду." }
t[187899] = { en = "Discover flight points and reveal maps around Outland.", ua = "Відкриває польотні точки й розкриває карти довкола Аутленду." }
t[187900] = { en = "Discover flight points and reveal maps around Kul Tiras and Zandalar.", ua = "Відкриває польотні точки й розкриває карти довкола Кул-Тіраса й Зандалару." }
t[187913] = { en = "Track slime wherever you go for $d.\n\n\n\nCan only be used by those pledged to the Necrolords or those who have reached Renown 80 with the Necrolords.", ua = "Лишай слизові сліди всюди, куди йдеш, на $d.\n\n\n\nМожуть використати лише ті, хто присягнув Некролордам, або ті, хто досяг Визнання 80 у Некролордів." }
t[187957] = { en = "Plant a banner representing your successes against the Encrypted.", ua = "Встанови прапор, що уособлює твої успіхи проти Зашифрованих." }
t[187958] = { en = "Plant a banner representing your successes against the Shrouded.", ua = "Встанови прапор, що уособлює твої успіхи проти Оповитих." }
t[188680] = { en = "Sing a festive song. Only functions during Winter Veil.", ua = "Заспівайте святкову пісню. Діє лише під час Зимової Завіси." }
t[188694] = { en = "Plant a flower.", ua = "Посади квітку." }
t[188695] = { en = "Kneel down and allow others to cook over you.", ua = "Стань на коліна й дозволь іншим готувати над тобою." }
t[188698] = { en = "Increases speed by $s1% for $d1. Only functions during Noblegarden where Brightly Colored Eggs are hidden.", ua = "Збільшує швидкість на $s1% на $d1. Діє лише під час Шляхетного Саду, де сховані Яскраво розфарбовані яйця." }
t[188699] = { en = "Hot feet!", ua = "Гарячі п'яти!" }
t[188701] = { en = "Add some spark to your dance moves!", ua = "Додай іскри своїм танцювальним рухам!" }
t[188952] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[190177] = { en = "Gaze deeply into the orb while sitting, pondering its secrets.", ua = "Сидячи, вдивляйся глибоко в кулю, розмірковуючи над її таємницями." }
t[190196] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[190237] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[190238] = { en = "Set down Xy'rath's cache to try and open it. Be careful, it's trapped!", ua = "Постав сховок Ксай'рата й спробуй відкрити його. Обережно, він із пасткою!" }
t[190333] = { en = "Summon a circle of Jiro to serenade you.", ua = "Прикличте коло Джиро, щоб вони заспівали вам серенаду." }
t[190457] = { en = "Assume the guise of a Nascent Prototype.", ua = "Прийми подобу новоствореного прототипа." }
t[190734] = { en = "Drop six land mines for players to step on.", ua = "Розкидай шість наземних мін, щоб гравці на них наступали." }
t[190754] = { en = "Place one of Firim's specimen containers in front of you.", ua = "Постав перед собою один із контейнерів для зразків Фіріма." }
t[190853] = { en = "Celebrate the fruits of your labor!", ua = "Відсвяткуй плоди своєї праці!" }
t[190926] = { en = "Equip a living automa core to your back.", ua = "Спорядь живе ядро автома собі на спину." }
t[191891] = { en = "A Chirpsnide original! Disguise yourself as the Screechflight harpy known as Chef Fry-Aerie!", ua = "Оригінал від Чирпснайда! Замаскуйся під гарпію Верескокрилих на ім'я шеф-кухар Фрай-Ері!" }
t[191925] = { en = "Become a star flinger! Use again to fling a star to starcatchers.", ua = "Стань зореметом! Використай знову, щоб жбурнути зірку зореловам." }
t[191937] = { en = "Become a starcatcher! Use again to knockback nearby starcatchers.", ua = "Стань зореловом! Використай знову, щоб відкинути ближніх зореловів." }
t[192099] = { en = "Put on the earpieces, tuning out the musical and vocal projections of those around you.", ua = "Вдягни беруші, відгородившись від музичних і голосових проєкцій тих, хто довкола." }
t[192443] = { en = "Guaranteed to propel yourself to a safe height above your surroundings!", ua = "Гарантовано підкине тебе на безпечну висоту над околицею!" }
t[192495] = { en = "Cloaks the user in a stealth field, allowing them to sneak around undetected. That's what it used to do, anyway.", ua = "Огортає користувача полем маскування, дозволяючи скрадатися непоміченим. Принаймні так воно колись працювало." }
t[193032] = { en = "Humbly offer your most prized possession to whomever considers you worthy enough to accept it.", ua = "Смиренно запропонуй свій найцінніший скарб тому, хто вважатиме, що ти заслуговуєш його прийняти." }
t[193033] = { en = "Clutch the enchanted prism in your hand to guide a beam of light to very precise locations.\n\n\n\nThe beam is only visible to members of your party or raid.", ua = "Стисни в руці зачаровану призму, щоб спрямувати промінь світла в дуже точні місця.\n\n\n\nПромінь видно лише членам твоєї групи або рейду." }
t[193476] = { en = "Place a gnoll tent to rest and relax under.", ua = "Постав намет гнолів, щоб відпочити й розслабитися під ним." }
t[193478] = { en = "Place a beanbag that can be sat on and lasts for $d.", ua = "Постав крісло-мішок, на якому можна сидіти й що триває $d." }
t[193588] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[194052] = { en = "Cover the recently deceased in a mourning cloth.", ua = "Накрий нещодавно померлого жалобним покривалом." }
t[194056] = { en = "Take a nap with your favorite duckie.", ua = "Подрімай зі своєю улюбленою качечкою." }
t[194057] = { en = "Place a time-traveling cushion that can be sat on and moves through time for $d.", ua = "Постав подушку-мандрівницю в часі, на якій можна сидіти і яка рухається крізь час протягом $d." }
t[194058] = { en = "Place a cooling cushion to soothe a rough wipe.", ua = "Постав охолоджувальну подушку, щоб пережити важкий вайп." }
t[194059] = { en = "Place a market tent to shop and relax under.", ua = "Постав торговий намет, щоб торгувати й відпочивати під ним." }
t[194060] = { en = "Place a Dragonscale Expedition's Expedition Tent to excel on every expedition.", ua = "Постав Похідний Намет Експедиції Драконячої Луски, щоб успішно долати кожну виправу." }
t[194885] = { en = "Place a perch to beckon a nearby Child of Ohn'ahra. The ohuna will deliver and retrieve mail for $d, or until it is called elsewhere.", ua = "Постав сідало, щоб прикликати Дитя Он'агри поблизу. Огуна доставлятиме й забиратиме пошту протягом $d або доки її не покличуть деінде." }
t[197719] = { en = "Place a sign so everyone can know where the best goods are sold.", ua = "Постав вивіску, щоб усі знали, де продають найкращий крам." }
t[197961] = { en = "Get carried away by five dragon whelplings!", ua = "Хай п'ять драконячих маленят віднесуть тебе геть!" }
t[197986] = { en = "Something looks fishy...\n\n\n\nCooldown reduced during the March of the Tadpoles.", ua = "Щось тут підозріло рибне...\n\n\n\nПерезарядження скорочене під час Маршу Пуголовків." }
t[198039] = { en = "Call an Appreciative Critter to prepare a feast as a token of gratitude.", ua = "Приклич Вдячне звірятко, щоб приготувало бенкет на знак подяки." }
t[198090] = { en = "Slip and slide the slime way!", ua = "Ковзайте й катайтеся по слизу!" }
t[198156] = { en = "Open a wormhole that allows the user to quickly travel to a random location in the Dragon Isles.\n\n\n\nEngineers that specialize into triangulation can learn to warp to specific locations.", ua = "Відкрий червоточину, що дозволяє власнику швидко перенестися у випадкову місцину Драконових Островів.\n\n\n\nІнженери, що спеціалізуються на тріангуляції, можуть навчитися переноситися в конкретні місця." }
t[198173] = { en = "Deploy a device that will temporarily rearrange the genetic composition of anyone you convince to step onto it.", ua = "Встанови пристрій, що тимчасово перебудує генетичний склад будь-кого, кого ти переконаєш на нього стати." }
t[198206] = { en = "Place down an Environmental Emulator for up to $d that allows you to view the world from a different perspective.\n\n\n\nA cloaking device attached to this machine ensures that only members of your party or raid can see the machine and its effects.\n\n\n\nCan only be used outside.", ua = "Постав Емулятор Довкілля на строк до $d, що дозволяє поглянути на світ під іншим кутом.\n\n\n\nМаскувальний пристрій, приєднаний до цієї машини, гарантує, що машину та її ефекти бачать лише члени твоєї групи чи рейду.\n\n\n\nМожна використати лише надворі." }
t[198227] = { en = "Perceive the world as though it were ruled by gnolls.", ua = "Сприймай світ так, ніби ним правлять гноли." }
t[198264] = { en = "Place down a Centralized Precipitation Emitter for up to $d that allows you to experience the fury of nature, by choice!\n\n\n\nA cloaking device attached to this machine ensures that only members of your party or raid can see the machine and its effects.\n\n\n\nCan only be used outside.", ua = "Постав Централізований Випромінювач Опадів на строк до $d, що дозволяє відчути лють природи — за власним бажанням!\n\n\n\nМаскувальний пристрій, приєднаний до цієї машини, гарантує, що машину та її ефекти бачать лише члени твоєї групи чи рейду.\n\n\n\nМожна використати лише надворі." }
t[198402] = { en = "Set out a Maruuk cooking pot, allowing cooking.", ua = "Постав казан Маруук, що дозволяє готувати." }
t[198409] = { en = "Enter your own Personal Shell.", ua = "Увійди у власний особистий панцир." }
t[198428] = { en = "You can raft across water.", ua = "Ти можеш переправлятися через воду на плоту." }
t[198474] = { en = "Get inspired.", ua = "Надихнись." }
t[198537] = { en = "Summon Taivan to your side. Taivan increases the Versatility of those nearby by $384543s1.", ua = "Прикличте Тайвана до себе. Тайван підвищує Універсальність тих, хто поруч, на $384543s1." }
t[198646] = { en = "Place an ornate dragon statue near you.", ua = "Постав біля себе оздоблену статую дракона." }
t[198720] = { en = "Place the pillow at your feet.", ua = "Постав подушку собі під ноги." }
t[198721] = { en = "Place the pillow at your feet.", ua = "Постав подушку собі під ноги." }
t[198722] = { en = "Place the pillow at your feet.", ua = "Постав подушку собі під ноги." }
t[198728] = { en = "Deploy an Explorers' League Banner.", ua = "Встанови Прапор Ліги Дослідників." }
t[198729] = { en = "Deploy a Reliquary Banner.", ua = "Встанови Прапор Реліквіарію." }
t[198827] = { en = "Jump on and sled!", ua = "Застрибуй і катайся на санчатах!" }
t[198857] = { en = "Escort Lucky Duck for a short time. You don't want to disappoint Lillistraza, do you?", ua = "Супроводжуй Щасливу Качечку недовгий час. Ти ж не хочеш розчарувати Ліллістразу, правда?" }
t[199337] = { en = "Vacuum critters for $d.", ua = "Засмоктуй дрібних звірят на $d." }
t[199554] = { en = "Set up a vaguely comfortable mechanical seat. Better than sitting on the floor!", ua = "Постав більш-менш зручне механічне сидіння. Краще, ніж сидіти на підлозі!" }
t[199649] = { en = "Serve tea with your Dragon Tea Set.", ua = "Подай чай зі свого Драконячого чайного сервізу." }
t[199650] = { en = "Serve tea with your Whale Bone Tea Set.", ua = "Подай чай зі свого чайного сервізу з китової кістки." }
t[199767] = { en = "Deploy a Red Dragon Banner to show your support for the red dragonflight!", ua = "Встанови Прапор Червоних Драконів, щоб виявити підтримку червоного роду драконів!" }
t[199768] = { en = "Deploy a Black Dragon Banner to show your support for the black dragonflight!", ua = "Встанови Прапор Чорних Драконів, щоб виявити підтримку чорного роду драконів!" }
t[199769] = { en = "Deploy a Blue Dragon Banner to show your support for the blue dragonflight!", ua = "Встанови Прапор Синіх Драконів, щоб виявити підтримку синього роду драконів!" }
t[199770] = { en = "Deploy a Bronze Dragon Banner to show your support for the bronze dragonflight!", ua = "Встанови Прапор Бронзових Драконів, щоб виявити підтримку бронзового роду драконів!" }
t[199771] = { en = "Deploy a Green Dragon Banner to show your support for the green dragonflight!", ua = "Встанови Прапор Зелених Драконів, щоб виявити підтримку зеленого роду драконів!" }
t[199830] = { en = "Summon a Tuskarr Training Dummy at target location for $d.\n\n\n\nOnly usable outdoors.", ua = "Прикличте тускарський тренувальний манекен у вказане місце на $d.\n\n\n\nМожна використати лише просто неба." }
t[199892] = { en = "Increases the Versatility of those nearby by $7353s1 and allows cooking.", ua = "Збільшує Універсальність тих, хто поруч, на $7353s1 і дозволяє готувати їжу." }
t[199894] = { en = "Place the Fisherman's Folly Basket on the ground to challenge your friends to see who gets the small fry.", ua = "Постав Кошик Рибальської Примхи на землю й кинь виклик друзям, аби побачити, хто впіймає дрібноту." }
t[199896] = { en = "Summon a Rubbery Fish Head at target location for $d.  The fish head acts as a target dummy while it persists.\n\n\n\nOnly usable outdoors.", ua = "Прикличте гумову риб'ячу голову у вказане місце на $d.  Поки голова існує, вона править за манекен-ціль.\n\n\n\nМожна використати лише просто неба." }
t[199897] = { en = "Place the beanbag at your feet.", ua = "Постав крісло-мішок собі під ноги." }
t[199899] = { en = "Pull a tuskarr child's sled that someone can ride on.", ua = "Тягни санчата тускарського дитяти, на яких хтось може прокотитися." }
t[199900] = { en = "Set up survey equipment, so it looks as if you are doing something very important.", ua = "Постав геодезичне спорядження, щоб здавалося, ніби ти робиш щось дуже важливе." }
t[199902] = { en = "Enable the Wayfinder's Compass to help you navigate the world.", ua = "Увімкни Компас Шукача Шляхів, щоб орієнтуватися у світі." }
t[200116] = { en = "Drink from this horn to become immune to lava outdoors in the Dragon Isles for 10 minutes.", ua = "Випий з цього рогу, щоб на 10 хвилин стати несприйнятливим до лави просто неба на Драконових Островах." }
t[200148] = { en = "Call upon the words of your past and future selves.", ua = "Заклич слова свого минулого та майбутнього «я»." }
t[200160] = { en = "Create a powerfully unbearable odor.", ua = "Створює нестерпно міцний сморід." }
t[200178] = { en = "Transforms you into a zombie for $d.", ua = "Обертає тебе на зомбі на $d." }
t[200198] = { en = "Imprison yourself for $d in your own Primalist cage.\n\n\n\nOnly usable outdoors.", ua = "Ув'язни себе на $d у власній клітці прадавників.\n\n\n\nМожна використати лише просто неба." }
t[200249] = { en = "Attempt to cast Polymorph.", ua = "Спробуй сотворити Перетворення." }
t[200469] = { en = "Disenchant a player.", ua = "Розчаклуй гравця." }
t[200550] = { en = "Lounge around, Maruuk style!", ua = "Вилежуйся, як справжній Маруук!" }
t[200551] = { en = "Rest like a khanam wherever you go!", ua = "Відпочивай, як канам, де завгодно!" }
t[200597] = { en = "Throw the Lover's Bouquet at a friend for them to catch.", ua = "Кинь Букет Закоханих другові, щоб він упіймав." }
t[200628] = { en = "Summons an arcana orb outside of the Cobalt Assembly.", ua = "Прикликає арканну кулю за межами Кобальтового Зібрання." }
t[200630] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[200631] = { en = "Show off your best dance moves alongside some tuskarr friends!", ua = "Похвалися своїми найкращими танцювальними рухами разом із друзями-тускарами!" }
t[200636] = { en = "Perform an elemental invocation, transforming into the elemental summoned for ${$s1/60} min.", ua = "Виконай елементальне закликання, перетворюючись на прикликаного елементаля на ${$s1/60} хв." }
t[200640] = { en = "Place three obsidian dragon eggs on the ground,  ready to hatch!", ua = "Поклади три обсидіанові драконячі яйця на землю — вже готові вилупитися!" }
t[200707] = { en = "You have access to Wrathion's personal cloak collection.", ua = "Ти маєш доступ до особистої колекції плащів Вратіона." }
t[200857] = { en = "Take on the appearance of a random djaradin.", ua = "Прибери вигляд випадкового джарадина." }
t[200869] = { en = "Drink a weak alcoholic beverage from the horn. As is tradition.", ua = "Випий слабкий алкогольний напій з рогу. Як велить традиція." }
t[200878] = { en = "Summon and control your Floaty Boaty.", ua = "Прикличте свій Плавучий Човник і керуйте ним." }
t[200926] = { en = "Reminisce with Divo's love songs.", ua = "Поринь у спогади під любовні пісні Діво." }
t[200960] = { en = "Embrace the spirits of the weald, transforming into your Soulshape.", ua = "Прийми духів пущі, перетворюючись на свою Душеподобу." }
t[200999] = { en = "Summon the Super Shellkhan Gang to follow you as they charge up their Super Spinning Attack!", ua = "Прикличте Зграю Супер-Панцирханів, щоб вона супроводжувала вас, накопичуючи свою Супер-Обертальну Атаку!" }
t[201435] = { en = "These sands will give your body the boogie it's been waiting for!\n\n\n\nBecome a dancing fiend for $d!\n\n\n\nCooldown reduced during the Darkspear Dash.", ua = "Ці піски подарують твоєму тілу той танок, на який воно так чекало!\n\n\n\nСтань завзятим танцюристом на $d!\n\n\n\nПерезарядження зменшене під час Забігу Темного Списа." }
t[201815] = { en = "Faces adorn the back of this cloak, their appearance fading out of view as quickly as you notice them.", ua = "Обличчя оздоблюють спину цього плаща, і їхній вигляд зникає з очей так само швидко, як ти їх помічаєш." }
t[201927] = { en = "Hold the crystal up to the light, manifesting and refracting arcane beauty.", ua = "Піднеси кристал до світла, являючи й заломлюючи арканну красу." }
t[201930] = { en = "Fires a signal flare to alert nearby allies of incoming danger.\n\n\n\nCan only be used in battlegrounds. Signal flares cannot be fired in a given area by the same faction more than once every $385647d.", ua = "Запускає сигнальну ракету, щоб попередити союзників поблизу про небезпеку.\n\n\n\nМожна використати лише на полях бою. Одна фракція може запускати сигнальні ракети в певній місцевості не частіше, ніж раз на $385647d." }
t[201931] = { en = "Throw down your Warcraft Rumble Mini: Maiev.", ua = "Постав свою міні-фігурку Warcraft Rumble: Майєв." }
t[201933] = { en = "Summon the Black Dragon's Challenge Dummy at target location for $d. This acts as a target dummy that can be damaged and healed by opposing roles while it persists. Will it live, or die?\n\n\n\nOnly usable outdoors.", ua = "Прикличте манекен-виклик чорного дракона у вказане місце на $d. Поки він існує, править за манекен-ціль, якому можуть завдавати шкоди й зцілювати протилежні ролі. Виживе він чи загине?\n\n\n\nМожна використати лише просто неба." }
t[202019] = { en = "Display your wealth to the world, leaving riches in your wake.", ua = "Вистав своє багатство напоказ усьому світу, лишаючи по собі коштовності." }
t[202020] = { en = "Summon a storm to chase an allied target!", ua = "Прикличте бурю, щоб гнатися за союзною ціллю!" }
t[202021] = { en = "Place a flag on an enemy player's corpse in front of you.", ua = "Постав прапорець на труп ворожого гравця перед собою." }
t[202022] = { en = "Fly Yennu's Kite.", ua = "Запусти повітряного змія Йенну." }
t[202042] = { en = "Equip a pair of black aquatic sunglasses.", ua = "Спорядь чорні водні сонцезахисні окуляри." }
t[202207] = { en = "$@spelldesc207700\n\n\n\nCan be used with bobbers in your toy collection.", ua = "$@spelldesc207700\n\n\n\nМожна використовувати з поплавцями з твоєї колекції іграшок." }
t[202253] = { en = "Transforms you into a Winterpelt Furbolg for $d.", ua = "Обертає тебе на фурболга Зимохутрих на $d." }
t[202261] = { en = "Throw down your Warcraft Rumble Mini: Sneed.", ua = "Постав свою міні-фігурку Warcraft Rumble: Снід." }
t[202283] = { en = "Equip a pair of reading glasses.", ua = "Спорядь окуляри для читання." }
t[202309] = { en = "Activate the Doomsday Device.", ua = "Активуй Пристрій Судного Дня." }
t[202360] = { en = "Attach some garbage to your fishing hook and cast your line! You will probably not catch anything, but at least you will appear to be trying.", ua = "Причепи якийсь мотлох до рибальського гачка й закинь вудку! Ти, мабуть, нічого не спіймаєш, але принаймні виглядатимеш так, ніби намагаєшся." }
t[202711] = { en = "Hold out your compass.", ua = "Простягни свій компас." }
t[202851] = { en = "Throw down your Warcraft Rumble Mini: Night Elf Huntress.", ua = "Постав свою міні-фігурку Warcraft Rumble: Мисливиця нічних ельфів." }
t[202856] = { en = "Throw down your Warcraft Rumble Mini: Stonehoof Tauren.", ua = "Постав свою міні-фігурку Warcraft Rumble: Таурен Кам'яного Копита." }
t[202859] = { en = "Throw down your Warcraft Rumble Mini: Undead Ghoul.", ua = "Постав свою міні-фігурку Warcraft Rumble: Гуль-нежить." }
t[202862] = { en = "Throw down your Warcraft Rumble Mini: Murloc.", ua = "Постав свою міні-фігурку Warcraft Rumble: Мурлок." }
t[202865] = { en = "Throw down your Warcraft Rumble Mini: Whelp Egg.", ua = "Постав свою міні-фігурку Warcraft Rumble: Яйце дракончика." }
t[203716] = { en = "Plant a banner representing your successes against the Thundering.", ua = "Встанови прапор, що уособлює твої успіхи проти Громових." }
t[203725] = { en = "Caber Toss!", ua = "Кидок колоди!" }
t[203734] = { en = "Get buried in snow!", ua = "Дай засипати себе снігом!" }
t[203757] = { en = "Place down the Brazier of Madness which enables cooking for any chef willing to get close to madness.", ua = "Постав Жаровню Безумства, що дозволяє готувати будь-якому кухарю, готовому наблизитися до безумства." }
t[203852] = { en = "Consume the spores and let them transform you.", ua = "Спожий спори й дай їм перетворити тебе." }
t[204170] = { en = "Wear the banner of your chosen Orc clan.", ua = "Вдягни прапор обраного тобою клану орків." }
t[204220] = { en = "Manifest Hraxian's Will.", ua = "Яви Волю Граксіана." }
t[204256] = { en = "Create a holographic tribute of Alexstrasza.", ua = "Створює голографічну шану Алекстразі." }
t[204257] = { en = "Create a holographic tribute of Ysera.", ua = "Створює голографічну шану Ісері." }
t[204262] = { en = "Create a holographic tribute of Nozdormu.", ua = "Створює голографічну шану Ноздорму." }
t[204389] = { en = "Have a smashing good time!", ua = "Розважся на всю котушку!" }
t[204405] = { en = "Place a stuffed bear statue near you.", ua = "Постав біля себе статую плюшевого ведмедя." }
t[204675] = { en = "Equip your Dragonriding drake with a festive basket.\n\nCooldown reduced during Noblegarden.", ua = "Спорядь свого дрейка драконячої їзди святковим кошиком.\n\nПерезарядження скорочене під час Шляхетного саду." }
t[204686] = { en = "Manifest a Titan prison at your location.", ua = "Яви в'язницю Титанів на своєму місці." }
t[204687] = { en = "Blow on the battle horn.", ua = "Засурми в бойовий ріг." }
t[204818] = { en = "Bonk a friend or foe with your squeakiest rubber duck.", ua = "Стукни друга чи ворога найпискливішою гумовою качкою." }
t[205045] = { en = "Bump fists with your best brul!", ua = "Стукнись кулаками зі своїм найкращим брулом!" }
t[205255] = { en = "Dig a tunnel back to Loamm from elsewhere in Zaralek Cavern.", ua = "Прокопай тунель назад до Лоамма з будь-якого місця Печери Заралек." }
t[205418] = { en = "Envelops the caster in shadowflame for $d.", ua = "Огортає творця тіньовим полум'ям на $d." }
t[205419] = { en = "Place Dinn's Drum in front of you.", ua = "Постав Барабан Дінна перед собою." }
t[205463] = { en = "Begins a molten ritual to summon a ball of lava.", ua = "Розпочинає розжарений ритуал прикликання кулі лави." }
t[205688] = { en = "Hurl a glob of glitterscale glitter at your target. Be careful, it gets everywhere...", ua = "Жбурни згусток блискіток блискітколуски у ціль. Обережно, вони лізуть усюди..." }
t[205796] = { en = "Equip the pack, allowing yourself to toss fast-cooling lava at your \"friends\". It won't hurt, but is still hot!", ua = "Спорядь ранець, що дозволяє жбурляти лаву, яка швидко застигає, у своїх «друзів». Не боляче, але все одно гаряче!" }
t[205904] = { en = "Clack the claw thrice, transforming into a primal makrura for $d.", ua = "Клацни клешнею тричі, перетворюючись на первісну макруру на $d." }
t[205908] = { en = "Some of the ancient blue dragon's wisdom, passed down to you in a form he surely found amusing. Hold a yes-or-no question in your heart and call upon it.", ua = "Дещиця мудрості прадавнього синього дракона, передана тобі у формі, яка його напевно потішила. Задумай у серці питання «так чи ні» й поклич її." }
t[205936] = { en = "New Niffen No-Sniffin' Tonic is guaranteed to block out all sounds of other people's noses for a full week. Useful and safe for everyone who doesn't want to hear niffen (or anyone!) sniffin'.\n\n\n\nWARNING: Only blocks sound. Does not block smell.", ua = "Новий Тонік Ніффенів «Годі Шморгати» гарантовано заблокує всі звуки чужих носів на цілий тиждень. Корисний і безпечний для кожного, хто не хоче чути, як ніффени (та й будь-хто!) шморгають.\n\n\n\nУВАГА: Блокує лише звук. Запах не блокує." }
t[205963] = { en = "Compel a friend to come visit you!", ua = "Спонукай друга завітати до тебе!" }
t[206008] = { en = "Plant the Nightmare Banner.", ua = "Встанови Стяг Жахіття." }
t[206038] = { en = "Put on a flashy show with an explosive conclusion.", ua = "Влаштуй яскраве шоу з вибуховим фіналом." }
t[206043] = { en = "Summon the essence of Fyrakk to unleash a deep breath, devastating critters caught in the flames.", ua = "Приклич есенцію Фіракка, щоб вивергнути глибокий подих і спопелити дрібних створінь у полум'ї." }
t[206195] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[206267] = { en = "Represent your seasonal achievement with a pennant.", ua = "Відзнач своє сезонне досягнення вимпелом." }
t[206268] = { en = "Summon an Ethereal Warpweaver for $d to transmogrify your gear.", ua = "Приклич ефіріала-ткача основи на $d, щоб трансмогрифікувати своє спорядження." }
t[206343] = { en = "Represent your seasonal achievement with a pennant.", ua = "Відзнач своє сезонне досягнення вимпелом." }
t[206347] = { en = "Transforms caster to a mannequin from the Trading Post.", ua = "Обертає на манекен із Торгового Посту." }
t[206565] = { en = "Place down a crate of ordinary grain for $d. Nobody will suspect a thing.", ua = "Постав ящик звичайного зерна на $d. Ніхто нічого не запідозрить." }
t[206696] = { en = "Equip your Tricked-Out Thinking Cap to start tracking coordinates from your location, and listen for any stray thoughts. \n\n\n\nUsed to solve the Secrets of Azeroth.", ua = "Спорядь свій Хитромудрий Мислильний Ковпак, щоб почати відстежувати координати свого розташування й прислухатися до випадкових думок. \n\n\n\nВикористовується для розгадки Таємниць Азероту." }
t[206993] = { en = "Spin the hands of the clock.", ua = "Прокрути стрілки годинника." }
t[207092] = { en = "Place a Portable Party Platter perfect for propagating pastries at picnics!", ua = "Постав Переносну святкову тацю, пречудову для пригощання печивом на пікніках!" }
t[207099] = { en = "Release the tiny earth elementals contained within.", ua = "Вивільни крихітних земляних елементалів, замкнених усередині." }
t[207730] = { en = "Summon the Idol of Ohn'ahra to detect objects of interest.\n\n\n\nUsed to solve the Secrets of Azeroth.", ua = "Приклич Ідол Он'ари, щоб виявляти цікаві об'єкти.\n\n\n\nВикористовується для розгадування Таємниць Азероту." }
t[208057] = { en = "Plant a banner representing your successes against the Smoldering.", ua = "Встанови прапор, що уособлює твої успіхи проти Тліючих." }
t[208058] = { en = "Manifest an hourglass to keep track of time.", ua = "Яви пісочний годинник, щоб стежити за часом." }
t[208092] = { en = "Pull out the Torch of Pyrreth to empower ancient devices, light braziers, melt locks, or reveal hidden artifacts.\n\n\n\nUsed to solve the Secrets of Azeroth.", ua = "Дістань Смолоскип Піррета, щоб наснажувати прадавні пристрої, запалювати жаровні, плавити замки чи виявляти приховані артефакти.\n\n\n\nВикористовується для розгадування Таємниць Азероту." }
t[208096] = { en = "Perform an incomplete ritual.", ua = "Проведи незавершений ритуал." }
t[208186] = { en = "Ask Boffins to follow you around for a while.", ua = "Попроси Боффінса ходити за тобою якийсь час." }
t[208415] = { en = "Enter stasis, trapping yourself in a single moment.", ua = "Увійди в стазис, замкнувши себе в єдиній миті." }
t[208421] = { en = "Read a random volume from the compendium and transform into a giant wolf.", ua = "Прочитай навмання том зі збірника й перетворися на велетенського вовка." }
t[208433] = { en = "Display your racing prowess.", ua = "Продемонструй свою гоночну вправність." }
t[208658] = { en = "Take on the form of a repentant man'ari eredar.", ua = "Прибери подобу розкаяного ман'арі ередара." }
t[208704] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[208798] = { en = "Summon a titan disc to gaze into its recorded memories. Usable only in Tyrhold or Valdrakken.", ua = "Приклич диск титанів, щоб зазирнути в записані на ньому спогади. Можна використати лише в Тайргольді або Валдраккені." }
t[208825] = { en = "Periodically release rings for party members to race through.\n\n\n\nRings cannot be placed near each other. Cooldown reduced during Feast of Winter Veil.", ua = "Періодично випускає кільця, крізь які члени групи мчать наввипередки.\n\n\n\nКільця не можна ставити близько одне до одного. Перезарядження скорочене під час Свята Зимової Завіси." }
t[208883] = { en = "Bounce gently atop this springy toy gryphon, or raise your weapon and call down the thunder for a rollicking ride.", ua = "М'яко підстрибуй на цьому пружному іграшковому грифоні або здійми зброю й приклич грім для завзятої поїздки." }
t[209035] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[209052] = { en = "Summon and ride a rolling barrel for $d.", ua = "Приклич барило, що котиться, і осідлай його на $d." }
t[209858] = { en = "Experience the memory of a Dreamsurge.", ua = "Переживи спогад про Сплеск Сну." }
t[209859] = { en = "Calls forth Pepe to ride on a sleigh as you adventure together.", ua = "Прикликає Пепе, щоб їхав на санях, поки ви разом мандруєте." }
t[209944] = { en = "Call a trio of adorable friends from the Emerald Dream to your side.", ua = "Приклич до себе трійцю чарівних друзів зі Смарагдового Сну." }
t[210042] = { en = "Plant your frosty banner.", ua = "Встанови своє морозне знамено." }
t[210411] = { en = "Plant a seed that will rapidly grow.", ua = "Посади насінину, що швидко проросте." }
t[210455] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.\n\n\n\nOnly draenei and lightforged draenei can use the draenic hologem.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки.\n\n\n\nДренейським голосамоцвітом можуть користуватися лише дренеї та дренеї, Загартовані Світлом." }
t[210467] = { en = "Summons a magical monument that that can change your appearance for $425843d", ua = "Прикликає чарівний монумент, який може змінити твою зовнішність на $425843d" }
t[210497] = { en = "Represent your seasonal achievement with a pennant.", ua = "Відзнач своє сезонне досягнення вимпелом." }
t[210656] = { en = "Don your festive footwear for $d1. Bring the Feast of Winter Veil with you everywhere you go!", ua = "Взуй святкове взуття на $d1. Носи Свято Зимової Завіси всюди, куди йдеш!" }
t[210725] = { en = "Put down a post for nearby owls to rest on.", ua = "Постав сідало, щоб на ньому відпочивали сови поблизу." }
t[210864] = { en = "When you need sleep no matter where.", ua = "Коли поспати треба, хай там де." }
t[210974] = { en = "Tune out non-party members.", ua = "Заглуши всіх, хто не в твоїй групі." }
t[210975] = { en = "Place down a Date Simulation Modulator for up to $d that allows you to view the world from a different perspective.\n\n\n\nA cloaking device attached to this machine ensures that only members of your party or raid can see the machine and its effects.\n\n\n\nCan only be used outside.", ua = "Постав Модулятор Симуляції Побачень на строк до $d, що дозволяє поглянути на світ під іншим кутом.\n\n\n\nМаскувальний пристрій, приєднаний до цієї машини, гарантує, що машину та її ефекти бачать лише члени твоєї групи чи рейду.\n\n\n\nМожна використати лише надворі." }
t[211424] = { en = "Plant a banner representing your successes against the Dreaming.", ua = "Встанови прапор, що уособлює твої успіхи проти Сновидних." }
t[211788] = { en = "Brings you home to Gilneas City.", ua = "Переносить тебе додому, до міста Ґілнеас." }
t[211864] = { en = "Summon your Exquisite Love Boat on the water's surface within $a1 yards.\n\nCooldown reduced during Love is in the Air.", ua = "Приклич свій Вишуканий Човен Кохання на поверхні води в межах $a1 ярдів.\n\nПерезарядження скорочене під час свята «Кохання в повітрі»." }
t[211869] = { en = "Represent your seasonal achievement with a pennant.", ua = "Відзнач своє сезонне досягнення вимпелом." }
t[211931] = { en = "Conjure a body of water.", ua = "Створи чарами водойму." }
t[211946] = { en = "Place a Hearthstone Game Table and play a worthy opponent!", ua = "Постав Ігровий стіл Hearthstone і зіграй проти гідного суперника!" }
t[212337] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[212500] = { en = "Pull out a fancy white parasol for $d, allowing you to safely float down the next time you fall.", ua = "Розкрий вишукану білу парасольку на $d, щоб безпечно спланерувати додолу наступного разу, коли впадеш." }
t[212518] = { en = "Embrace infinity, randomizing the look of your customizable skyriding mounts.", ua = "Прийми нескінченність, довільно змінюючи вигляд своїх налаштовуваних їздових тварин для небесної їзди." }
t[212523] = { en = "Pull out a fancy jade parasol for $d, allowing you to safely float down the next time you fall.", ua = "Розкрий вишукану нефритову парасольку на $d, щоб безпечно спланерувати додолу наступного разу, коли впадеш." }
t[212524] = { en = "Pull out a fancy crimson parasol for $d, allowing you to safely float down the next time you fall.", ua = "Розкрий вишукану багряну парасольку на $d, щоб безпечно спланерувати додолу наступного разу, коли впадеш." }
t[212525] = { en = "Pull out a fancy ebony parasol for $d, allowing you to safely float down the next time you fall.", ua = "Розкрий вишукану чорну парасольку на $d, щоб безпечно спланерувати додолу наступного разу, коли впадеш." }
t[215145] = { en = "Offer a fallen player a respectful burial.", ua = "Влаштуй полеглому гравцеві шанобливий похорон." }
t[215147] = { en = "Focus a colored beam of light through a gemstone toward a helpless critter.", ua = "Спрямуй кольоровий промінь світла крізь самоцвіт на беззахисне звірятко." }
t[216881] = { en = "Summon an egg that lets you transform into a tiny duck.", ua = "Приклич яйце, що дає змогу перетворитися на крихітну качку." }
t[217723] = { en = "Occasionally don the wings of Xuen over the next $d.", ua = "Час від часу вбирайся в крила Сюеня протягом наступних $d." }
t[217724] = { en = "Occasionally don the wings of Chi-Ji over the next $d.", ua = "Час від часу вбирайся в крила Чі-Цзі протягом наступних $d." }
t[217725] = { en = "Occasionally don the wings of Yu'lon over the next $d.", ua = "Час від часу вбирайся в крила Ю'лон протягом наступних $d." }
t[217726] = { en = "Occasionally don the wings of Niuzao over the next $d.", ua = "Час від часу вбирайся в крила Ніуцзао протягом наступних $d." }
t[218112] = { en = "Set up a colorful beach chair.", ua = "Постав барвистий пляжний шезлонг." }
t[218128] = { en = "Plant a banner representing your successes against the Draconic.", ua = "Встанови прапор, що уособлює твої успіхи проти Драконічних." }
t[218308] = { en = "Find someone to help pull open the cracker. One participant will receive a surprise.", ua = "Знайди когось, хто допоможе розкрити хлопавку. Один з учасників отримає сюрприз." }
t[218310] = { en = "Place a box full of puntable creatures!", ua = "Постав скриню, повну істот, яких так і кортить копнути!" }
t[219387] = { en = "Deploy a dangerous barrel of fireworks for $d so you and your friends can violently illuminate the night sky!\n\n\n\nOther players can opt-in to seeing the fireworks by attacking the barrel.\n\n\n\nCooldown reduced during drunken goblin revelries.", ua = "Встанови небезпечне барило феєрверків на $d, щоб ти й твої друзі могли шалено осяяти нічне небо!\n\n\n\nІнші гравці можуть долучитися до перегляду феєрверків, атакувавши барило.\n\n\n\nПерезарядження скорочене під час п'яних ґоблінських гулянок." }
t[219403] = { en = "Place a lantern to illuminate your surroundings and calm your spirits. The heat is just strong enough to also allow for cooking.", ua = "Постав ліхтар, щоб освітити довкола й заспокоїти душу. Його тепла якраз досить, щоб іще й готувати." }
t[220692] = { en = "Place an X-treme Water Blaster Display.", ua = "Постав Вітрину Екстремального Водомета." }
t[220777] = { en = "Walk a cherry blossom strewn path.", ua = "Пройдися стежкою, всіяною цвітом вишні." }
t[221962] = { en = "Urgently seek shelter inside a defective escape pod. You won't get very far, but at least you are safe.", ua = "Терміново сховайся в несправній рятувальній капсулі. Далеко не заїдеш, але принаймні будеш у безпеці." }
t[221964] = { en = "Embrace your inner photographer!", ua = "Пробуди в собі фотографа!" }
t[221966] = { en = "Open a wormhole that allows the user to quickly travel to a random location in Khaz Algar.", ua = "Відкрий червоточину, що дозволяє власнику швидко перенестися у випадкову місцину Каз Алґару." }
t[223146] = { en = "Plant one of the seeds.", ua = "Посади одну з насінин." }
t[223312] = { en = "Throw the hat to an ally!", ua = "Кинь капелюх союзникові!" }
t[224192] = { en = "Spin to win!", ua = "Крути й вигравай!" }
t[224251] = { en = "Release a memory of yourself.", ua = "Вивільни спогад про себе." }
t[224552] = { en = "Ignite a torch.", ua = "Запали смолоскип." }
t[224554] = { en = "Call the wind to arms. Your feet won't touch the ground!", ua = "Приклич вітер до зброї. Твої ноги не торкатимуться землі!" }
t[224585] = { en = "Creates a horse hologram that races forward.", ua = "Створює голограму коня, що мчить уперед." }
t[224643] = { en = "Place a candle on a non-combat pet's head. This candle radiates a small amount of warmth that can be used temporarily to cook meals.", ua = "Постав свічку на голову небойового улюбленця. Ця свічка випромінює трохи тепла, якого тимчасово вистачає, щоб готувати страви." }
t[224783] = { en = "Set down a chest of royal clothes for you and others to try on.", ua = "Постав скриню з королівським вбранням, щоб ти й інші могли поміряти його." }
t[225347] = { en = "Break out a spinning wheel to dye a slew of nerubian spools.", ua = "Дістань прядку, щоб пофарбувати купу нерубських котушок." }
t[225547] = { en = "Emanate an aura of victory.", ua = "Випромінюй ауру перемоги." }
t[225556] = { en = "Summon Icarus the Unbreakable at target location for $d. This acts as a target dummy that can be damaged and healed by opposing roles while it persists. How far up will you make the numbers go?\n\n\n\nOnly usable outdoors.", ua = "Приклич Ікара Незламного у вказане місце на $d. Поки він існує, править за манекен-ціль, якому можуть завдавати шкоди й зцілювати протилежні ролі. Як високо ти підіймеш числа?\n\n\n\nМожна використати лише просто неба." }
t[225641] = { en = "Take on the visage of a kobyss for $d.", ua = "Прибери на $d подобу кобісса." }
t[225659] = { en = "Catch up on the latest book you started the other day.", ua = "Продовж читати книжку, розпочату днями." }
t[225910] = { en = "Eat me?", ua = "З'їж мене?" }
t[225933] = { en = "Represent your seasonal achievement with a pennant.", ua = "Відзнач своє сезонне досягнення вимпелом." }
t[225969] = { en = "Place a flag on an enemy player's corpse in front of you.", ua = "Постав прапорець на труп ворожого гравця перед собою." }
t[226191] = { en = "A sturdy, sticky leash of webbing for your creepy-crawly pets.", ua = "Міцний липкий повідець із павутини для твоїх повзучих улюбленців." }
t[226373] = { en = "The mouthfeel of oil and the brininess of an oyster. Delicious.\n\n\n\nCosts 50 silver per gulp.", ua = "Масляниста на язик, солона, мов устриця. Смакота.\n\n\n\nКоштує 50 срібла за ковток." }
t[226519] = { en = "You can visualize the detection radius of guards in the City of Threads.\n\n\n\nYou've learned much from the General.", ua = "Ти можеш бачити радіус виявлення вартових у Місті Ниток.\n\n\n\nГенерал багато чого тебе навчив." }
t[226810] = { en = "Take on the visage of an Ethereum Void Reaper for $d.", ua = "Прибери на $d подобу Женця Порожнечі Етеріуму." }
t[227538] = { en = "Represent your achievement with a pennant.", ua = "Відзнач своє досягнення вимпелом." }
t[227539] = { en = "Represent your seasonal achievement with a pennant.", ua = "Відзнач своє сезонне досягнення вимпелом." }
t[228413] = { en = "Call a sparkle of fireflies to your side.", ua = "Приклич до себе рій світлячків." }
t[228698] = { en = "Summon Lil Wick to carry you around. Only usable outdoors.", ua = "Приклич Лила Віка, щоб він носив тебе довкола. Можна використати лише просто неба." }
t[228705] = { en = "Morph into a giant spider.", ua = "Перекинься на велетенського павука." }
t[228706] = { en = "Turn to stone.", ua = "Обернися на камінь." }
t[228707] = { en = "Manifest the trial and try not to get hit.", ua = "Яви випробування й намагайся не пропустити удару." }
t[228789] = { en = "Equip the Blizzard Bling to show off your many years of adventures.", ua = "Спорядь Blizzard Bling, щоб похизуватися багатьма роками пригод." }
t[228914] = { en = "Something skitters in the corner of your eyes. Everywhere.", ua = "Щось шмигає скраю поля зору. Усюди." }
t[228940] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.\n\n\n\nCan only be used by those who've proven themselves to the Severed Threads.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки.\n\n\n\nМожуть використовувати лише ті, хто довів свою відданість Розтятим Ниткам." }
t[228966] = { en = "See what you want to see.", ua = "Побач те, що хочеш бачити." }
t[229828] = { en = "Throw down a chest filled with balloons.", ua = "Кинь на землю скриню, повну повітряних кульок." }
t[230727] = { en = "Emanate an aura of victory.", ua = "Випромінюй ауру перемоги." }
t[230850] = { en = "Call down Delve-O-Bot 7001 to get a ride to a random The War Within Bountiful Delve.\n\n\n\nIf none are Bountiful, teleport to a random one.", ua = "Приклич Глибинобота 7001, щоб домчати до випадкової Щедрої Глибини з Війни Всередині.\n\n\n\nЯкщо Щедрих немає, телепортуйся до випадкової." }
t[230924] = { en = "Put the spotlight on a party member!", ua = "Спрямуй прожектор на учасника групи!" }
t[231064] = { en = "Disguise yourself as a certified Undermine gangster, fooling the locals into leaving you alone for $d. Only usable in Undermine.", ua = "Перекинься на дипломованого гангстера Андермайну, щоб місцеві дали тобі спокій на $d. Використовується лише в Андермайні." }
t[232301] = { en = "Plant a banner representing your successes against the Tempered.", ua = "Встанови прапор, що уособлює твої успіхи проти Загартованих." }
t[232302] = { en = "Plant a banner representing your successes against the Prized.", ua = "Встанови прапор, що уособлює твої успіхи проти Шанованих." }
t[232303] = { en = "Plant a banner representing your successes against the Unbound.", ua = "Встанови прапор, що уособлює твої успіхи проти Розкутих." }
t[232305] = { en = "Plant a banner representing your victories within the Forged arenas.", ua = "Встанови прапор, що уособлює твої перемоги на Кованих аренах." }
t[232306] = { en = "Plant a banner representing your victories within the Prized arenas.", ua = "Встанови прапор, що уособлює твої перемоги на Шанованих аренах." }
t[232307] = { en = "Plant a banner representing your victories within the Astral arenas.", ua = "Встанови прапор, що уособлює твої перемоги на Астральних аренах." }
t[233202] = { en = "Take control of the G.O.L.E.M. Jr. for $d.", ua = "Візьми під контроль G.O.L.E.M. Молодшого на $d." }
t[233486] = { en = "Carry your crate full of Hallowfall supplies.", ua = "Неси свій ящик, повний припасів Святопаду." }
t[234473] = { en = "Summons a comfy lawn chair.", ua = "Прикликає зручне садове крісло." }
t[234950] = { en = "Deploy a device that will temporarily goblinate anyone you convince to step onto it.", ua = "Встанови пристрій, що тимчасово оґоблінить будь-кого, кого ти переконаєш на нього стати." }
t[234951] = { en = "Place a rack of assorted Kaja'Cola flavors to share with your friends.", ua = "Постав стійку з різними смаками каджа'коли, щоб поділитися з друзями." }
t[235015] = { en = "Carry your crate full of Dornogal supplies.", ua = "Неси свій ящик, повний припасів Дорноґалу." }
t[235016] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[235017] = { en = "Embrace the ancient call of Hymosul.", ua = "Прийми прадавній поклик Гімосула." }
t[235041] = { en = "Equip Cyrce's Circlet to display your mastery of the mythical siren's ring.", ua = "Спорядь Вінець Цирцеї, щоб показати свою майстерність над перснем міфічної сирени." }
t[235050] = { en = "Catch up on the latest book you started the other day.", ua = "Продовж читати книжку, розпочату днями." }
t[235220] = { en = "Don a hat loaded with fireworks for $d. Releases fireworks when you jump.", ua = "Вдягни капелюх, начинений феєрверками, на $d. Випускає феєрверки, коли ти стрибаєш." }
t[235288] = { en = "Serve a unique tea blend with your Sha-Warped Tea Set.", ua = "Подай унікальну суміш чаю зі свого Ша-спотвореного чайного сервізу." }
t[235519] = { en = "Represent your seasonal achievement with a pennant.", ua = "Відзнач своє сезонне досягнення вимпелом." }
t[235669] = { en = "Plant the banner of the Steamwheedle Cartel.", ua = "Встанови прапор Картелю Парогвинта." }
t[235670] = { en = "Plant the banner of the Bilgewater Cartel.", ua = "Встанови прапор Картелю Трюмних Вод." }
t[235671] = { en = "Plant the banner of the Blackwater Cartel.", ua = "Встанови прапор Картелю Чорноводдя." }
t[235672] = { en = "Plant the banner of Venture Co.", ua = "Встанови прапор Компанії «Авантюра»." }
t[235799] = { en = "Throw the sawblade to a friendly player. If possible, they will automatically return it.", ua = "Кинь пиляльний диск дружньому гравцеві. Якщо зможе, він автоматично поверне його." }
t[235801] = { en = "You can raft across water.", ua = "Ти можеш переправлятися через воду на плоту." }
t[235807] = { en = "Place a goblin market stall designed to last for $d. Can only be used outdoors.", ua = "Постав ґоблінську ринкову ятку, розраховану на $d. Можна використати лише надворі." }
t[236687] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[236749] = { en = "Strike a pose and snap a picture with Torq!", ua = "Прийміть позу й зробіть світлину з Торком!" }
t[236751] = { en = "Strike a pose and snap a picture with Flarendo!", ua = "Прийміть позу й зробіть світлину з Фларендо!" }
t[236769] = { en = "For no good reason, reroute the Gallagio's fountain plumbing to your location for $d.", ua = "Без жодної поважної причини перенаправ водогін фонтана «Ґалладжіо» до себе на $d." }
t[237345] = { en = "Replace your fishing bobber with a bobbing Limited Edition Rocket\n\n for $d.\n\n\n\nOnly real fans have this one!", ua = "Заміни свій риболовний поплавець на ракету обмеженого випуску, що погойдується на воді\n\n на $d.\n\n\n\nТака є лише в справжніх фанатів!" }
t[237346] = { en = "Replace your fishing bobber with a bobbing Artisan Beverage Goblet for $d.\n\n\n\nThe height of glamour!", ua = "Заміни свій риболовний поплавець на келих ремісничого напою, що погойдується на воді, на $d.\n\n\n\nВершина шику!" }
t[237347] = { en = "Replace your fishing bobber with a bobbing Organically-Sourced Wellington\n\n for $d.\n\n\n\nThe finest fish are attracted to the finest cuisine!", ua = "Заміни свій риболовний поплавець на органічно вирощений Веллінгтон, що погойдується на воді\n\n на $d.\n\n\n\nНайвишуканіша риба клює на найвишуканішу страву!" }
t[237382] = { en = "Carry your crate full of Undermine supplies and knick-knacks.", ua = "Неси свій ящик, повний припасів і дрібничок Андермайну." }
t[238850] = { en = "Stay in rhythm to keep the flame in the air.", ua = "Тримайте ритм, щоб полум'я не згасало в повітрі." }
t[238852] = { en = "Plant a banner for the Flame's Radiance.", ua = "Встанови прапор Сяйва Полум'я." }
t[239007] = { en = "Plant the Dastardly Banner.", ua = "Встанови Підступний стяг." }
t[239018] = { en = "Place a Winner's Podium and show off!", ua = "Постав П'єдестал переможця й похизуйся!" }
t[239693] = { en = "Whistle for a Courier Lynx to appear. The lynx will deliver and retrieve mail for $d, or until it is called elsewhere.", ua = "Свисни, щоб з'явилася Рись-кур'єр. Рись доставлятиме й забиратиме пошту протягом $d або доки її не покличуть деінде." }
t[242323] = { en = "Slip Chowdar's favorite ribbon onto your finger. It'll fit, right?", ua = "Надіньте на палець улюблену стрічку Чавдара. Вона ж підійде, так?" }
t[242520] = { en = "Summon a Festival Hot Air Balloon to float into the sky. Only usable outdoors.", ua = "Прикличте святкову повітряну кулю, щоб злетіти в небо. Можна використати лише просто неба." }
t[242534] = { en = "You can raft across water.", ua = "Ти можеш переправлятися через воду на плоту." }
t[242636] = { en = "Represent your seasonal achievement with a pennant.", ua = "Відзнач своє сезонне досягнення вимпелом." }
t[243056] = { en = "Open a portal for $d that any player can use to return to the Explorers' League home base in Dornogal.", ua = "Відкрий портал на $d, яким будь-який гравець може скористатися, щоб повернутися до бази Ліги Дослідників у Дорноґалі." }
t[243146] = { en = "The Void's influence can be overbearing against even the most resilient void elves.", ua = "Вплив Порожнечі буває нездоланним навіть для найстійкіших ельфів Порожнечі." }
t[243304] = { en = "Don the jolly costume of the Jubilant Snowman. Cooldown reduced during Feast of Winter Veil.", ua = "Вдягни веселий костюм Радісного Сніговика. Перезарядження скорочене під час Свята Зимової Завіси." }
t[244470] = { en = "Emanate an aura of victory.", ua = "Випромінюй ауру перемоги." }
t[244792] = { en = "Summons an Ethereal Transmorpher that can change your appearance for $1237986d.", ua = "Прикликає ефіріала-Трансморфера, який може змінити вашу зовнішність на $1237986d." }
t[244888] = { en = "Call upon your memory of Xal'atath. Her voice will occasionally echo with glee when you kill a foe.", ua = "Заклич свій спогад про Ксал'атат. Її голос час від часу зловтішно відлунюватиме, коли ти вбиваєш ворога." }
t[245567] = { en = "Take on the appearance of a K'areshi.", ua = "Прибери вигляд к'арешійця." }
t[245580] = { en = "Jump on a snowball and roll it! Cooldown reduced during Feast of Winter Veil.", ua = "Застрибни на сніжку й покоти її! Перезарядження скорочене під час Свята Зимової Завіси." }
t[245631] = { en = "Remember the tale of Arthas Menethil. You take on his visage.", ua = "Згадай оповідь про Артаса Менетіла. Ти прибираєш його подобу." }
t[245942] = { en = "Summons a Sea-Blessed Shrine at target location.", ua = "Прикликає Благословенне Морем Святилище у вказаному місці." }
t[245946] = { en = "Summon and dismiss your Brewer's Balloon.", ua = "Прикличте й відпустіть свою повітряну кулю броваря." }
t[245970] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[246227] = { en = "Summons a Lightning-Blessed Spire at target location.", ua = "Прикликає Благословенний Блискавкою Шпиль у вказаному місці." }
t[246565] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[246903] = { en = "Enter an ethereal state of energy.", ua = "Увійди в ефірний стан енергії." }
t[246905] = { en = "View the world through K'areshi sensibilities.", ua = "Поглянь на світ очима к'арешійця." }
t[246907] = { en = "Carry your crate full of Tazaveshi supplies and knick-knacks.", ua = "Неси свій ящик, повний тазавешійських припасів і дрібничок." }
t[246908] = { en = "Carry your crate full of K'areshi supplies and doodads.", ua = "Неси свій ящик, повний к'арешійських припасів і дрібничок." }
t[248485] = { en = "Open a wormhole that allows the user to quickly travel to a random Midnight location.", ua = "Відкрий червоточину, що дозволяє власнику швидко перенестися у випадкову місцину Опівночі." }
t[249468] = { en = "Mark the pages with an \"O\" or an \"X\", try to get 3 marks of the same type in a row to win.", ua = "Постав на сторінках «O» чи «X»; щоб виграти, збери 3 однакові позначки в ряд." }
t[249713] = { en = "Disguise yourself as a Broker from Cartel Xy for a short period of time.", ua = "Перекинься на посередника з Картелю Ксай на короткий час." }
t[250319] = { en = "Marked by the Void.", ua = "Тебе позначено Порожнечею." }
t[250320] = { en = "Marked by the Light.", ua = "Тебе позначено Світлом." }
t[250722] = { en = "Drop down an ethereal stall that lasts for $d. Can only be used outdoors.", ua = "Постав ефірний прилавок, що триває $d. Використовується лише просто неба." }
t[250974] = { en = "Call upon the favor of Akil'zon to ride the currents of the sky, levitating on a swirling gust of wind.", ua = "Заклич ласку Акіл'зона, щоб осідлати небесні течії, ширяючи на вихорі вітру." }
t[251491] = { en = "Command a targeted vanity pet to move to an area and then stay.", ua = "Накажи обраному декоративному улюбленцю перейти в певне місце й лишатися там." }
t[251633] = { en = "Throw forth a bundle brimming with abundance, allowing Dundun to run wild!", ua = "Кинь клунок, повний рясності, і дай Дундуну розгулятися!" }
t[251903] = { en = "Potatoad.", ua = "Картопуха." }
t[252265] = { en = "Guzzle down the mucus and enjoy it.", ua = "Хлебчи слиз і смакуй." }
t[253629] = { en = "Teleports the user to the Arcantina.", ua = "Телепортує до Аркантіни." }
t[254666] = { en = "Summon a replica of the Exodar to travel alongside you.", ua = "Прикличте копію Екзодара, аби подорожувала поруч із вами." }
t[256141] = { en = "Summon Fortune's Waving Cat to travel alongside you.", ua = "Прикличте Кота Удачі, що махає лапкою, аби подорожував поруч із вами." }
t[256552] = { en = "Sprout into a Rutaani. Live your best peaceful, grounded, plant-creature life!", ua = "Проростіть у Рутаані. Живіть найкращим мирним, заземленим життям істоти-рослини!" }
t[256881] = { en = "Transform into a helpful steward.", ua = "Обернися на послужливого стюарда." }
t[256893] = { en = "Transform into a disgusting wretch.", ua = "Обернися на огидного виродка." }
t[257736] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[258129] = { en = "Summons a Jade Monument that you and others can jump on.", ua = "Прикликає Нефритовий Монумент, на який можете застрибувати ви та інші." }
t[258135] = { en = "Summons a Gilded Coil Spire that you and others can jump on.", ua = "Прикликає Позолочений Шпиль Кілець, на який можете застрибувати ви та інші." }
t[258136] = { en = "Summons a Azure Thunder Coil Pillar that you and others can jump on.", ua = "Прикликає Лазуровий Стовп Громових Кілець, на який можете застрибувати ви та інші." }
t[258840] = { en = "Summons a magic fountain that accepts a gold offering.", ua = "Прикликає чарівний фонтан, який приймає золоті пожертви." }
t[258963] = { en = "Reduces your falling speed for $d. Only usable in outdoor Midnight areas.", ua = "Зменшує швидкість твого падіння на $d. Можна використати лише просто неба в місцинах Опівночі." }
t[259084] = { en = "Calls forth a spirit of the cycle of life.", ua = "Прикликає духа циклу життя." }
t[259240] = { en = "Toast to those around you with your glass of sin'dorei wine.", ua = "Виголоси тост тим, хто довкола, келихом сін'дорейського вина." }
t[259335] = { en = "Beckon a bronze whelping to capture victorious moments against epic foes.", ua = "Приклич бронзове драконя, щоб закарбувати миті перемог над епічними ворогами." }
t[259899] = { en = "Become encased in ash as embers of Amirdrassil rain from above.", ua = "Вкрийся попелом, поки жаринки Амірдрассілу сиплються згори." }
t[260170] = { en = "Throw a smooth rock fragment across the water and watch it skip.", ua = "Кинь гладенький камінець над водою й дивись, як він скаче жабкою." }
t[262431] = { en = "Deploy your mushroom to reach new heights!\n\n\n\nOnly usable in outdoor Midnight zones.", ua = "Розгорни свій гриб, щоб дістатися нових висот!\n\n\n\nВикористовується лише на відкритих теренах зон Опівночі." }
t[263198] = { en = "Show off your best catch!", ua = "Похвалися своїм найкращим уловом!" }
t[263244] = { en = "Summon 3 Baby Voidwalkers.", ua = "Прикличте 3 маленьких блукачів Порожнечі." }
t[263489] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[263871] = { en = "A sturdy, magical tether for your cherished pets.", ua = "Міцна магічна прив'язь для твоїх дорогих улюбленців." }
t[263933] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[263975] = { en = "Tap the emotion-projecting lens to let your vibes out into the world - once for good, twice for bad.", ua = "Торкнись лінзи, що проєктує емоції, аби випустити свій настрій у світ — раз для доброго, двічі для лихого." }
t[264313] = { en = "Share a delicious mushroom treat with your friends and become one with the fungus.", ua = "Поділися смачними грибними ласощами з друзями та стань одним цілим із грибами." }
t[264367] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[264413] = { en = "Emanate an aura of victory.", ua = "Випромінюй ауру перемоги." }
t[264414] = { en = "Fire a flare to call down a fellow delver to help out!\n\n\n\nOnly works within a Midnight Delve.", ua = "Запусти сигнальну ракету, щоб прикликати напарника-глибинника на допомогу!\n\n\n\nПрацює лише в Глибині Опівночі." }
t[264517] = { en = "Place a flag on an enemy player's corpse in front of you.", ua = "Постав прапорець на труп ворожого гравця перед собою." }
t[264666] = { en = "Squeeze one last bit of anguish from a corpse.", ua = "Вичавіть із трупа останню краплю муки." }
t[264672] = { en = "Perform a ritual dedicating a player's corpse to the Void.", ua = "Проведи ритуал, присвячуючи труп гравця Порожнечі." }
t[264695] = { en = "Use the incredibly safe and well-tested device to temporarily open a hole in reality, allowing you to send and receive mail.", ua = "Скористайся неймовірно безпечним і добре випробуваним пристроєм, щоб тимчасово відкрити діру в реальності й отримувати та надсилати пошту." }
t[264805] = { en = "It's Delvin' Time!", ua = "Час глибинити!" }
t[265100] = { en = "Returns you to $z. Speak to an Innkeeper in a different place to change your home location.", ua = "Повертає тебе до $z. Поговори з корчмарем в іншому місці, щоб змінити місце своєї домівки." }
t[266370] = { en = "You are whisked away to the current Abundant location.\n\n\n\n(Can only be activated in Midnight zones.)", ua = "Тебе миттю переносить до поточної місцини Достатку.\n\n\n\n(Можна активувати лише в зонах Опівночі.)" }
t[267139] = { en = "Play a game to feed your Hungry Black Hole.", ua = "Зіграй у гру, щоб нагодувати свою Голодну чорну діру." }
t[267291] = { en = "Combine all of your Coffer Key Shards into Restored Coffer Key.", ua = "Поєднай усі свої Уламки ключа від скрині у Відновлений ключ від скрині." }
t[267323] = { en = "Roll like a troll!\n\n\n\nCooldown reduced during the Darkspear Dash.", ua = "Котися, як троль!\n\n\n\nЧас відновлення скорочено під час Ривка Чорнокопів." }
t[267456] = { en = "Gently hold Lil' Scoots while he sleeps off his day of mayhem.", ua = "Ніжно потримай Малого Скутса, поки він відсипається після дня бешкету." }
t[267472] = { en = "Summon a holographic projection of yourself at the target location. If there is another Holo-Gnome nearby, your Holo-Gnome will stack on top of it. Warning: Holo-Gnomes are unstable and, admittedly, not great at stacking.\n\n\n\nCooldown reduced during the Great Gnomeregan Run.", ua = "Прикличте голографічну проєкцію себе у вказане місце. Якщо поблизу є інший Голо-гном, ваш Голо-гном стане на нього згори. Увага: Голо-гноми нестабільні й, чесно кажучи, кепсько стають у стос.\n\n\n\nПерезарядження скорочене під час Великого Забігу Гномрегану." }
t[268455] = { en = "Summons an enchanted hourglass!", ua = "Прикликає зачарований пісковий годинник!" }
t[268456] = { en = "Summons a bench to sit on!", ua = "Прикликає лаву, щоб посидіти!" }
t[268695] = { en = "Frame the perfect shot and capture the moment.", ua = "Злови ідеальний кадр і закарбуй мить." }
t[268717] = { en = "Activate the plating to transform into a pango.", ua = "Активуй панцир, щоб перетворитися на панго." }
t[268728] = { en = "Drink from the salve to transform into a saptor.", ua = "Випий з мазі, щоб перетворитися на смолораптора." }
t[272287] = { en = "Mandatory nap time.", ua = "Обов'язкова тиха година." }
t[272339] = { en = "Plant a banner representing your victories within the Umbral arenas.", ua = "Встанови прапор, що уособлює твої перемоги на Тіньових аренах." }
t[276371] = { en = "Recalls you to the current active Umbral Base Camp on Naigtal or Val. Location may vary.", ua = "Повертає тебе до чинного Тіньового базового табору на Найґталі чи Валі. Розташування може змінюватися." }
