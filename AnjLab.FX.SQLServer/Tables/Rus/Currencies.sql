/*
<summary>
	World currencies dictionary according to Russian ОКВ standard
</summary>

<author>
	Alex Zakharov
	Copyright © AnjLab 2008, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
<author>

<date>3/25/2008</date>

*/

set nocount on

if not exists (select * from sysobjects where id = object_id(N'fx.Currencies') and xtype ='U')
begin

create table fx.Currencies (
	CurrencyID smallint not null identity(1,1),
	DigitCode char(3) not null,
	CharCode char(3),
	CurrencyName nvarchar(128) not null,
	Countries nvarchar(max) null,
	CbrID char(6),
	IsFavorite bit not null constraint dfCurrenciesIsFavorite default 0,
	constraint pkCurrencies primary key clustered (CurrencyID asc)
)

exec sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'World currencies dictionary (in Russian) according to Russian OKV standard', 
	@level0type=N'SCHEMA', @level0name=N'fx', @level1type=N'TABLE',  @level1name=N'Currencies'

exec sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'Currency digital code' , 
	@level0type=N'SCHEMA', @level0name=N'fx', @level1type=N'TABLE',  @level1name=N'Currencies', @level2type=N'COLUMN',  @level2name=N'DigitCode'

exec sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'Currency char code' , 
	@level0type=N'SCHEMA', @level0name=N'fx', @level1type=N'TABLE',  @level1name=N'Currencies', @level2type=N'COLUMN',  @level2name=N'CharCode'

exec sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'Currency name' , 
	@level0type=N'SCHEMA', @level0name=N'fx', @level1type=N'TABLE',  @level1name=N'Currencies', @level2type=N'COLUMN',  @level2name=N'CurrencyName'

exec sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'List of countries where currency is used' , 
	@level0type=N'SCHEMA', @level0name=N'fx', @level1type=N'TABLE',  @level1name=N'Currencies', @level2type=N'COLUMN',  @level2name=N'Countries'

exec sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'You can use this flag to define currencies which are used often (for example, to truncate full list). By default UDS, EUR and RUR are marked as favorites.' , 
	@level0type=N'SCHEMA', @level0name=N'fx', @level1type=N'TABLE',  @level1name=N'Currencies', @level2type=N'COLUMN',  @level2name=N'IsFavorite'

insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('004', 'AFA', N'Афгани', N'Афганистан', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('008', 'ALL', N'Лек', N'Албания', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('012', 'DZD', N'Алжирский динар', N'Алжир', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('020', 'ADP', N'Андорская песета', N'Андорра', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('031', 'AZM', N'Азербайджанский манат', N'Азербайджан', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('032', 'ARS', N'Аргентинское песо', N'Аргентина', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('036', 'AUD', N'Австралийский доллар', N'Австралия; Кирибати; Кокосовые (Килинг) острова; Науру; Норфолк, остров; Остров Рождества; Тувалу; Херд и Макдональд, острова', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('044', 'BSD', N'Багамский доллар', N'Багамские острова', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('048', 'BHD', N'Бахрейнский динар', N'Бахрейн', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('050', 'BDT', N'Така', N'Бангладеш', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('051', 'AMD', N'Армянский драм', N'Армения', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('052', 'BBD', N'Барбадосский доллар', N'Барбадос', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('060', 'BMD', N'Бермудский доллар', N'Бермудские острова', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('064', 'BTN', N'Нгултрум', N'Бутан', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('068', 'BOB', N'Боливиано', N'Боливия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('072', 'BWP', N'Пула', N'Ботсвана', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('084', 'BZD', N'Белизский доллар', N'Белиз', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('090', 'SBD', N'Доллар Соломоновых островов', N'Соломоновы острова', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('096', 'BND', N'Брунейский доллар', N'Бруней Даруссалам', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('100', 'BGL', N'Лев', N'Болгария', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('104', 'MMK', N'Кьят', N'Мьянма', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('108', 'BIF', N'Бурундийский франк', N'Бурунди', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('116', 'KHR', N'Риель', N'Камбоджа', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('124', 'CAD', N'Канадский доллар', N'Канада', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('132', 'CVE', N'Эскудо Кабо-Верде', N'Кабо-Верде', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('136', 'KYD', N'Доллар Каймановых островов', N'Каймановы острова', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('144', 'LKR', N'Шри-Ланкийская рупия', N'Шри-Ланка', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('152', 'CLP', N'Чилийское песо', N'Чили', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('156', 'CNY', N'Юань Ренминби', N'Китай', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('170', 'COP', N'Колумбийское песо', N'Колумбия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('174', 'KMF', N'Франк Коморских островов', N'Коморские острова', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('188', 'CRC', N'Костариканский колон', N'Коста-Рика', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('191', 'HRK', N'Куна', N'Хорватия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('192', 'CUP', N'Кубинское песо', N'Куба', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('196', 'CYP', N'Кипрский фунт', N'Кипр', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('203', 'CZK', N'Чешская крона', N'Чешская Республика', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('208', 'DKK', N'Датская крона', N'Гренландия; Дания; Фарерские острова', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('214', 'DOP', N'Доминиканское песо', N'Доминиканская Республика', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('222', 'SVC', N'Сальвадорский колон', N'Сальвадор', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('230', 'ЕТВ', N'Эфиопский быр', N'Эфиопия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('232', 'ERN', N'Накфа', N'Эритрея', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('233', 'ЕЕК', N'Крона', N'Эстония', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('238', 'FKP', N'Фунт Фолклендских островов', N'Фолклендские (Мальвинские) острова', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('242', 'FJD', N'Доллар Фиджи', N'Фиджи', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('262', 'DJF', N'Франк Джибути', N'Джибути', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('270', 'GMD', N'Даласи', N'Гамбия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('288', 'GHC', N'Седи', N'Гана', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('292', 'GIP', N'Гибралтарский фунт', N'Гибралтар', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('320', 'GTQ', N'Кетсаль', N'Гватемала', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('324', 'GNF', N'Гвинейский франк', N'Гвинея', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('328', 'GYD', N'Гайанский доллар', N'Гайана', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('332', 'HTG', N'Гурд', N'Гаити', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('340', 'HNL', N'Лемпира', N'Гондурас', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('344', 'HKD', N'Гонконгский доллар', N'Гонконг', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('348', 'HUF', N'Форинт', N'Венгрия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('352', 'ISK', N'Исландская крона', N'Исландия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('356', 'INR', N'Индийская рупия', N'Бутан; Индия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('360', 'IDR', N'Рупия', N'Восточный Тимор; Индонезия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('364', 'IRR', N'Иранский риал', N'Иран (Исламская Республика)', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('368', 'IQD', N'Иракский динар', N'Ирак', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('376', 'ILS', N'Новый израильский шекель', N'Израиль', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('388', 'JMD', N'Ямайский доллар', N'Ямайка', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('392', 'JPY', N'Йена', N'Япония', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('398', 'KZT', N'Тенге', N'Казахстан', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('400', 'JOD', N'Иорданский динар', N'Иордания', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('404', 'KES', N'Кенийский шиллинг', N'Кения', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('408', 'KPW', N'Северо-корейская вона', N'Корея, демократическая народная республика', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('410', 'KRW', N'Вона', N'Корея, республика', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('414', 'KWD', N'Кувейтский динар', N'Кувейт', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('417', 'KGS', N'Сом', N'Киргизия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('418', 'LAK', N'Кип', N'Лаос, народная демократическая республика', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('422', 'LBP', N'Ливанский фунт', N'Ливан', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('426', 'LSL', N'Лоти', N'Лесото', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('428', 'LVL', N'Латвийский лат', N'Латвия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('430', 'LRD', N'Либерийский доллар', N'Либерия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('434', 'LYD', N'Ливийский динар', N'Ливийская Арабская Джамахирия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('440', 'LTL', N'Литовский лит', N'Литва', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('446', 'MOP', N'Патака', N'Макао', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('450', 'MGF', N'Малагасийский франк', N'Мадагаскар', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('454', 'MWK', N'Квача', N'Малави', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('458', 'MYR', N'Малайзийский рингтит', N'Малайзия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('462', 'MVR', N'Руфия', N'Мальдивы', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('470', 'MTL', N'Мальтийская лира', N'Мальта', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('478', 'MRO', N'Угия', N'Мавритания', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('480', 'MUR', N'Маврикийская рупия', N'Маврикий', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('484', 'MXN', N'Мексиканское песо', N'Мексика', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('496', 'MNT', N'Тугрик', N'Монголия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('498', 'MDL', N'Молдавский лей', N'Молдова', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('504', 'MAD', N'Марокканский дирхам', N'Западная Сахара; Марокко', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('508', 'MZM', N'Метикал', N'Мозамбик', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('512', 'OMR', N'Оманский риал', N'Оман', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('516', 'NAD', N'Доллар Намибии', N'Намибия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('524', 'NPR', N'Непальская рупия', N'Непал', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('532', 'ANG', N'Нидерландский антильский гульден', N'Нидерландские Антильские острова', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('533', 'AWG', N'Арубанский гульден', N'Аруба', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('548', 'VUV', N'Вату', N'Вануату', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('554', 'NZD', N'Новозеландский доллар', N'Ниуэ; Новая Зеландия; Острова Кука; Питкерн; Токелау', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('558', 'NIO', N'Золотая кордоба', N'Никарагуа', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('566', 'NGN', N'Найра', N'Нигерия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('578', 'NOK', N'Норвежская крона', N'Буве, остров; Норвегия; Свальбард и Ян Майен, острова', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('586', 'PKR', N'Пакистанская рупия', N'Пакистан', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('590', 'PAB', N'Бальбоа', N'Панама', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('598', 'PGK', N'Кина', N'Папуа-Новая Гвинея', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('600', 'PYG', N'Гуарани', N'Парагвай', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('604', 'PEN', N'Новый соль', N'Перу', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('608', 'PHP', N'Филиппинское песо', N'Филиппины', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('624', 'GWP', N'Песо Гвинеи-Бисау', N'Гвинея-Бисау', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('626', 'TPE', N'Тиморское эскудо', N'Восточный Тимор', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('634', 'QAR', N'Катарский риал', N'Катар', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('642', 'ROL', N'Лей', N'Румыния', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('643', 'RUB', N'Российский рубль (деноминированный)', N'Россия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('646', 'RWF', N'Франк Руанды', N'Руанда', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('654', 'SHP', N'Фунт Острова Святой Елены', N'Остров Святой Елены', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('678', 'STD', N'Добра', N'Сан-Томе и Принсипи', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('682', 'SAR', N'Саудовский риял', N'Саудовская Аравия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('690', 'SCR', N'Сейшельская рупия', N'Сейшельские Острова', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('694', 'SLL', N'Леоне', N'Сьерра-Леоне', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('702', 'SGD', N'Сингапурский доллар', N'Сингапур', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('703', 'SKK', N'Словацкая крона', N'Словакия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('704', 'VND', N'Донг', N'Вьетнам', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('705', 'SIT', N'Толар', N'Словения', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('706', 'SOS', N'Сомалийский шиллинг', N'Сомали', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('710', 'ZAR', N'Рэнд', N'Лесото; Намибия; Южная Африка', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('716', 'ZWD', N'Доллар Зимбабве', N'Зимбабве', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('736', 'SDD', N'Суданский динар', N'Судан', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('740', 'SRG', N'Суринамский гульден', N'Суринам', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('748', 'SZL', N'Лилангени', N'Свазиленд', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('752', 'SEK', N'Шведская крона', N'Швеция', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('756', 'CHF', N'Швейцарский франк', N'Лихтенштейн; Швейцария', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('760', 'SYP', N'Сирийский фунт', N'Сирийская Арабская Республика', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('764', 'THB', N'Бат', N'Таиланд', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('776', 'TOP', N'Паанга', N'Тонга', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('780', 'TTD', N'Доллар Тринидада и Тобаго', N'Тринидад и Тобаго', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('784', 'AED', N'Дирхам (ОАЭ)', N'Объединенные Арабские Эмираты (ОАЭ)', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('788', 'TND', N'Тунисский динар', N'Тунис', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('792', 'TRL', N'Турецкая лира', N'Турция', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('795', 'TMM', N'Манат', N'Туркмения', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('800', 'UGX', N'Угандийский шиллинг', N'Уганда', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('807', 'MKD', N'Динар', N'Македония', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('810', 'RUR', N'Российский рубль', N'Россия', 1)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('818', 'EGP', N'Египетский фунт', N'Египет', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('826', 'GBP', N'Фунт стерлингов', N'Соединенное королевство (Великобритания)', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('834', 'TZS', N'Танзанийский шиллинг', N'Танзания, единая республика', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite, CbrID) values('840', 'USD', N'Доллар США', N'Американское Самоа; Британская территория в Индийском океане; Виргинские острова (Британские); Виргинские острова (США); Гаити; Гуам; Малые Тихоокеанские Отдаленные острова США; Маршалловы острова; Микронезия; Палау; Панама; Пуэрто-Рико; Северные Марианские острова; Соединенные Штаты Америки (США); Теркс и Кайкос, острова', 1, 'R01235')
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('858', 'UYU', N'Уругвайское песо', N'Уругвай', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('860', 'UZS', N'Узбекский сум', N'Узбекистан', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('862', 'VEB', N'Боливар', N'Венесуэла', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('882', 'WST', N'Тала', N'Самоа', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('886', 'YER', N'Йеменский риал', N'Йемен', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('891', 'YUM', N'Югославский динар', N'Югославия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('894', 'ZMK', N'Квача (замбийская)', N'Замбия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('901', 'TWD', N'Новый тайваньский доллар', N'Тайвань, провинция Китая', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('950', 'XAF', N'Франк КФА ВЕАС (денежная единица Банка государств Центральной Африки)', N'Габон; Камерун; Конго; Центрально-африканская Республика; Чад; Экваториальная Гвинея', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('951', 'XCD', N'Восточно-карибский доллар', N'Ангилья; Антигуа и Барбуда; Гренада; Доминика; Монсеррат; Сент-Винсент и Гренадины; Сент-Китс и Невис; Сент-Люсия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('952', 'XOF', N'Франк КФА ВСЕАО (денежная единица Центрального Банка государств Западной Африки)', N'Бенин; Буркина-Фасо; Гвинея-Бисау; Кот дИвуар; Мали; Нигер; Сенегал; Того', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('953', 'XPF', N'Франк КФП', N'Французская Полинезия; Новая Каледония; Уоллис и Футуна, острова', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('960', 'XDR', N'СДР (специальные права заимствования)', N'Международный валютный фонд', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('972', 'TJS', N'Сомони', N'Таджикистан', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('973', 'AOA', N'Кванза', N'Ангола', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('974', 'BYR', N'Белорусский рубль', N'Беларусь', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('975', 'BGN', N'Болгарский лев', N'Болгария', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('976', 'CDF', N'Конголезский франк', N'Конго, демократическая республика', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('977', 'ВАМ', N'Конвертируемая марка', N'Босния и Герцеговина', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite, CbrID) values('978', 'EUR', N'Евро', N'Австрия; Андорра; Бельгия; Ватикан, город-государство; Гваделупа; Германия; Греция; Ирландия; Испания; Италия; Люксембург; Мартиника; Монако; Нидерланды; Португалия; Реюньон; Сан-Марино; Сен-Пьер и Микелон; Финляндия; Франция; Французская Гвиана; Французские Южные территории', 1, 'R01239')
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('980', 'UAH', N'Гривна', N'Украина', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('981', 'OEL', N'Лари', N'Грузия', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('985', 'PLN', N'Злотый', N'Польша', 0)
insert into fx.Currencies(DigitCode, CharCode, CurrencyName, Countries, IsFavorite) values('986', 'BRL', N'Бразильский реал', N'Бразилия', 0)

end
GO
	