(*
      } *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* {
       *|           ГрюндикСтудия представляет:           |*
        *                GruString v1.2                   *
        |*_______________________________________________*|
        * Написан на Delphi 5.                            *
       *|     Модуль для работы со строками.              |*
        *     Ждите следующих версии, обязательно будут   *
        |*_______________________________________________*|
        *                Москва 19.11.01 г.               *
       *|_________________________________________________|*
        * По всем вопросам обращаться на tarasui@aport.ru *
        |*           (Чёрный Тарас ака Грюндик)          *|
       * _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _*
      } * * * * * * * * * * * * * * * * * * * * * * * * * * {

[История:]

 [+] 04.02.02 ExtractPath (Получение пути к папке, без файла)
 [+] 04.02.02 ConcatLink (Сложение ссылок для анализа ссылок)
 [*] 04.02.02 GetHtmlMail (Отсеевает javascript: и mailto:)
 [+] 01.02.02 ChangeHSym и ChangeTSym (Замена спец. HTML символов и обратно)
 [+] 01.02.02 StrToMail (Выделения из строки всех E-Mail tarasui@mail.ru)
 [+] 26.01.02 CopyServer Возвращает из grundic.hut.ru/index.htm grundic.hut.ru
 [+] 26.01.02 CompareLink (Возвращает локальность ссылки относительно маски)
 [+] 26.01.02 DelCopyMask (Удаления из списка, строки повторяюшии в маске)
 [+] 26.01.02 DelHttp (Удаляет http:// из ссылки, если oн там есть)
 [+] 26.01.02 ToLetInteger (Проверка строки на смволы типа Integer)
 [+] 25.01.02 ZoneToState (Возвращает c доменa назвавие страны по русский)
 [+] 25.01.02 GetZone (Выделения ccTLD доменa)
 [+] 20.01.02 DeleteSpam (Удаление из строки спама);
 [*] 20.01.02 GetHtmlMail (Еще хитрее работает);
 [*] 20.01.02 GetHtmllink (Выделения HTML текста всех ссылок);
 [+] 19.11.01 Создание модуля GruString;
*)

unit GruString;

interface
uses SysUtils, Classes;

const
{ Символы в десятичной системы }
  LetInteger: array[0..9] of Char = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9');
{ Символы EN клавеатуры }
  EngLet: string =
  '`qwertyuiop[]asdfghjkl;''zxcvbnm,.~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>';
{ Символы RU клавеатуры }
  RusLet: string =
  'ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ';

  Spam: string =
  #$A#$B#$C#$D#$E#$F#$1A#$1B#$1C#$1D#$1E#$1F#$0#$1#$2#$3#$4
    + #$5#$6#$7#$8#$9#$10#$11#$12#$13#$14#$15#$16#$17#$18#$19;

  Arbits: array[0..19] of ShortString = (#13, #10,
    'target=_new', 'target=new',
    'target=_blank', 'target=blank',
    'target=_parent', 'target=parent',
    'target=_self', 'target=self',
    'target=_top', 'target=top',
    'class=_copyright', 'class=copyright',
    'class=_top', 'class=top',
    'class=_linkint', 'class=linkint',
    'class=_submenu', 'class=submenu');

// Государства
  state: array[0..240] of ShortString = ('Остров Вознесения', 'Андорра',
    'Объединенные Арабские Эмираты', 'Афганистан', 'Антигуа и Барбуда', 'Ангилла',
    'Албания', 'Армения', 'Антильские острова (Нидерланд.)', 'Ангола', 'Антарктика',
    'Аргентина', 'Американские Острова Самоа', 'Австрия', 'Австралия', 'Аруба',
    'Азербайджан', 'Босния и Герцеговина', 'Барбадос', 'Бангладеш', 'Бельгия',
    'Буркина-Фасо', 'Болгария', 'Бахрейн', 'Бурунди', 'Бенин', 'Бермуды',
    'Бруней Даруссалам', 'Боливия', 'Бразилия', 'Багамы', 'Бутан', 'острова Буве',
    'Ботсвана', 'Белоруссия', 'Белиз', 'Канада', 'Кокосовые острова',
    'Центральноафриканская Республика', 'Республика Конго', 'Швейцария',
    'Кот-д''Ивуар', 'Острова Кука', 'Чили', 'Камерун', 'Китай', 'Колумбия', 'Коста-Рика',
    'Куба', 'Кабо Верде', 'Остров Рождества', 'Кипр', 'Чешская Республика', 'Германия',
    'Джибути', 'Дания', 'Доминика', 'Доминиканская республика', 'Алжир', 'Эквадор',
    'Эстония', 'Египет', 'Западная Сахара', 'Эритрея', 'Испания', 'Эфиопия',
    'Финляндия', 'Фиджи', 'Фолклендские острова', 'Микронезия', 'Острова Фарое',
    'Франция', 'Габон', 'Гренада', 'Грузия', 'Гвиана', 'остров Гернси', 'Гана',
    'Гибралтар', 'Гренландия', 'Гамбия', 'Гвинея', 'Гваделупа',
    'Экваториальная Гвинея', 'Греция', 'Южная Георгия и Южные Сандвичевы острова',
    'Гватемала', 'Гуам', 'Гвинея-Биссау', 'Гвиана', 'Гонконг',
    'острова Херда и Макдональда', 'Гондурас', 'Хорватия', 'Гаити', 'Венгрия',
    'Индонезия', 'Ирландия', 'Израиль', 'Остров Мэн',
    'Британская Индийская и Океанская Территория', 'Ирак', 'Иран', 'Исландия',
    'Италия', 'Джерси', 'Ямайка', 'Иордания', 'Япония', 'Кения', 'Кыргызстан',
    'Камбоджа', 'Кирибати', 'Коморские острова', 'Сент-Китс и Невис',
    'Северная Корея', 'Южная Корея', 'Кувейт', 'Острова Кайман', 'Казахстан', 'Лаос',
    'Ливан', 'Сант-Лука', 'Лихтенштейн', 'Шри-Ланка', 'Либерия', 'Лесото', 'Литва',
    'Люксембург', 'Латвия', 'Ливия', 'Марокко', 'Монако', 'Республика Молдова',
    'Мадагаскар', 'Маршалловы острова', 'Македония', 'Мали', 'Мьянма', 'Монголия',
    'Макау', 'Северные Марианские острова', 'Мартиника', 'Мавритания', 'Монтсеррат',
    'Мальта', 'Маврикий', 'Мальдивы', 'Малави', 'Мексика', 'Малайзия', 'Мозамбик',
    'Намибия', 'Новая Каледония', 'Нигер', 'Остров Норфолк', 'Нигерия', 'Никарагуа',
    'Нидерланды', 'Норвегия', 'Непал', 'Науру', 'Нюи', 'Новая Зенландия', 'Оман',
    'Панама', 'Перу', 'Французская Полинезия', 'Папуа - Новая Гвинея', 'Филиппины',
    'Пакистан', 'Польша', 'Св. Пьер и Маквелон', 'Остров Питкерн', 'Пуэрто-Рико',
    'Палестинские территории', 'Португалия', 'Палау', 'Парагвай', 'Катар',
    'Остров Воссоединения', 'Румыния', 'Российская Федерация', 'Руанда',
    'Саудовская Аравия', 'Соломоновы острова', 'Сейшельские острова', 'Судан',
    'Швеция', 'Сингапур', 'остров Святой Елены', 'Словения',
    'острова Свалбард и Джен Майен', 'Словацкая республика', 'Сьерра-Леоне',
    'Сан-Марино', 'Сенегал', 'Сомали', 'Суринам', 'Cан-Томе и Принсипи',
    'Территории бывшего СССР', 'Сальвадор', 'Свазиленд', 'Острова Текс и Кайакос',
    'Чад', 'Французские южные территории', 'Того', 'Таиланд', 'Таджикистан', 'Токелау',
    'Туркмения', 'Тунис', 'Тонга', 'Восточный Тимор', 'Турция', 'Тринидад и Тобаго',
    'Тувалу', 'Тайвань', 'Танзания', 'Украина', 'Уганда', 'Великобритания',
    'Малые Отдаленные острова', 'Соединенные Штаты Америки', 'Уругвай', 'Узбекистан',
    'Ватикан', 'Сент-Винсент и Гренадины', 'Венесуэла',
    'Виргинские острова (британские)', 'Виргинские острова (США)', 'Вьетнам',
    'Вануату', 'Острова Уоллис и Футуна', 'Западное Самоа', 'Йемен', 'Майот',
    'Югославия', 'Южная Африка', 'Замбия', 'Зимбабве');

// ccTLD домены
  zone: array[0..240] of ShortString = ('AC',
    'AD', 'AE', 'AF', 'AG', 'AI', 'AL', 'AM', 'AN', 'AO', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AW',
    'AZ', 'BA', 'BB', 'BD', 'BE', 'BF', 'BG', 'BH', 'BI', 'BJ', 'BM', 'BN', 'BO', 'BR', 'BS',
    'BT', 'BV', 'BW', 'BY', 'BZ', 'CA', 'CC', 'CF', 'CG', 'CH', 'CI', 'CK', 'CL', 'CM', 'CN',
    'CO', 'CR', 'CU', 'CV', 'CX', 'CY', 'CZ', 'DE', 'DJ', 'DK', 'DM', 'DO', 'DZ', 'EC', 'EE',
    'EG', 'EH', 'ER', 'ES', 'ET', 'FI', 'FJ', 'FK', 'FM', 'FO', 'FR', 'GA', 'GD', 'GE', 'GF',
    'GG', 'GH', 'GI', 'GL', 'GM', 'GN', 'GP', 'GQ', 'GR', 'GS', 'GT', 'GU', 'GW', 'GY', 'HK',
    'HM', 'HN', 'HR', 'HT', 'HU', 'ID', 'IE', 'IL', 'IM', 'IO', 'IQ', 'IR', 'IS', 'IT', 'JE',
    'JM', 'JO', 'JP', 'KE', 'KG', 'KH', 'KI', 'KM', 'KN', 'KP', 'KR', 'KW', 'KY', 'KZ', 'LA',
    'LB', 'LC', 'LI', 'LK', 'LR', 'LS', 'LT', 'LU', 'LV', 'LY', 'MA', 'MC', 'MD', 'MG', 'MH',
    'MK', 'ML', 'MM', 'MN', 'MO', 'MP', 'MQ', 'MR', 'MS', 'MT', 'MU', 'MV', 'MW', 'MX', 'MY',
    'MZ', 'NA', 'NC', 'NE', 'NF', 'NG', 'NI', 'NL', 'NO', 'NP', 'NR', 'NU', 'NZ', 'OM', 'PA',
    'PE', 'PF', 'PG', 'PH', 'PK', 'PL', 'PM', 'PN', 'PR', 'PS', 'PT', 'PW', 'PY', 'QA', 'RE',
    'RO', 'RU', 'RW', 'SA', 'SB', 'SC', 'SD', 'SE', 'SG', 'SH', 'SI', 'SJ', 'SK', 'SL', 'SM',
    'SN', 'SO', 'SR', 'ST', 'SU', 'SV', 'SZ', 'TC', 'TD', 'TF', 'TG', 'TH', 'TJ', 'TK', 'TM',
    'TN', 'TO', 'TP', 'TR', 'TT', 'TV', 'TW', 'TZ', 'UA', 'UG', 'UK', 'UM', 'US', 'UY', 'UZ',
    'VA', 'VC', 'VE', 'VG', 'VI', 'VN', 'VU', 'WF', 'WS', 'YE', 'YT', 'YU', 'ZA', 'ZM', 'ZW');

// Домены верхнего уровня (gTLD)
  Domain: array[0..13] of ShortString = (
    'COM', 'NET', 'ORG', 'INFO', 'BIZ', 'INT', 'EDU', 'GOV', 'MIL',
{ Во второй половине 2002 г. полностью откроются }
    'NAME', 'MUSEUM', 'PRO', 'AERO', 'COOP');

{--------------------------------------------------------------------------}
// Проверка на преоброзование строки в Integer, функцией StrToInt
function ToLetInteger(const val: string): Boolean;

// Удаление из строки пробелов, возрощяет строку без пробелов.
function DeleteBlank(s: string): string;

// Удаление из строки двойных пробелов.
function DelDoubBlank(const s: string): string;

// Удаление из строки спама.
function DeleteSpam(const s: string): string;

// Удаление из строки спама.
function DeleteSpamA(const s: string): string;

// Удаления из списка строк всех пробелов в строках.
function DelBlankStrings(s: Tstrings): Tstrings;

// Удаления из списка строк всех пустых строк.
function DelEmpStrings(s: Tstrings): Tstrings;

// Удаления из списка строк всех повторяюших строк.
function DeleteCopy(s: Tstrings): Tstrings;

// Удаления из списка, строки повторяюшии в маске
function DelCopyMask(s, mask: Tstrings): Tstrings;

// Возвратит строку с указанной большой буквой
function LargeLtterStr(const s: string; N: integer): string;

// Возвращает строку где все слова начинаются с большой буквы
function LargeStr(const s: string): string;

// Возвращает аббревиатуру слов.
function AbbrevStr(const s: string): string;

// Возвращает слово наоборот  - торобоан.
function SrtTotrS(const s: string): string;

// Возвращает с английской раскладкой в русскою
function EngToRus(const s: string): string;

// Возвращает с русской раскладкой в английскою
function RusToEng(const s: string): string;

// Сравнивает две строки и возвращает процент сходства
function SimStrPro(const s1, s2: string): integer;

// Удаления из строки всех <Тегов>
function DeleteTag(s: string): string;

// Выделения из строки всех <Тегов>
function CopyTag(s: string): string;

// Замена спец. HTML символов (&nbsp; &amp; &lt; &gt; &quot;) на
// (пробел & < > ") и обратно
function ChangeHSym(s: string): string;
function ChangeTSym(s: string): string;
const HSym: array[0..4] of string = ('&nbsp;', '&amp;', '&lt;', '&gt;', '&quot;');
const TSym: array[0..4] of string = (' ', '&', '<', '>', '"');

// Выделения из HTML строки всех E-Mail <a href="mailto: ">
function GetHtmlMail(s: string): TStringList;

// Выделения из строки всех E-Mail tarasui@mail.ru
function StrToMail(s: string): TStringList;
const PSEM = ['A'..'Z', 'a'..'z', '0'..'9', '_', '-', '.', '@'];

// Выделения HTML текста всех ссылок
function GetHtmllink(const s: string): TStringList;

// Удаляет http:// из ссылки, если oн там есть
function DelHttp(s: string): string;

// Возвращает из http://grundic.hut.ru/files/index.htm > grundic.hut.ru
function CopyServer(const s: string): string;

// Возвращает локальность ссылки относительно маски
function CompareLink(s, mask: string): byte;
const
  L_NOTE = $3; // Неопределнно   (Но скорей всего)
  L_LOCAL = $0; // Локальная ссылка  (относительно)
  L_GLOBAL = $1; // Глобальная ссылка (относительно)

// Выделения расширения из ссылки (.ru .html .cgi)
function GetExtLink(const s: string): ShortString;

// Выделения ccTLD доменa (.ru .uk .ua)
function GetZone(const s: string): ShortString;

// Возвращает c ccTLD доменa назвавие страны(зоны) по русский
function ZoneToState(const s: ShortString): ShortString;

// Сложение ссылок (для неполных ссылок типа ../../foto/gala.html)
function ConcatLink(const link, val: string): string;

// Получение пути к папке (grundic.ru/foto/vasia.html > grundic.ru/foto/)
function ExtractPath(const link: string): string;

implementation

{--------------------------------------------------------------------------}
// Проверка на преоброзование строки в Integer, функцией StrToInt

function ToLetInteger(const val: string): Boolean;
var i, x: Byte;
begin
  result := true;
  for i := 1 to Length(val) do
    for x := 0 to High(LetInteger) do
    begin
      if val[i] = LetInteger[x] then Break;
      if x = 9 then result := false;
    end;
end;

{--------------------------------------------------------------------------}
// Удаление из строки пробелов, возрощяет строку без пробелов.

function DeleteBlank(s: string): string;
begin
  while pos(' ', s) <> 0 do
    Delete(s, (pos(' ', s)), 1);
  result := s;
end;

{--------------------------------------------------------------------------}
// Удаление из строки двойных пробелов.

function DelDoubBlank(const s: string): string;
var reS: string;
begin
  reS := s;
  while pos('  ', reS) <> 0 do
    Delete(reS, (pos('  ', reS)), 1);
  result := reS;
end;

{--------------------------------------------------------------------------}
// Удаление из строки спама.

function DeleteSpam(const s: string): string;
var reS: string;
  i, x: integer;
begin
  if s = '' then Exit;
  reS := s;
  for i := 1 to Length(S) do
    for x := 1 to Length(Spam) do
      if reS[i] = Spam[x] then Delete(reS, x, 1);
  result := reS;
end;

{--------------------------------------------------------------------------}
// Удаление из строки спама.

function DeleteSpamA(const s: string): string;
var reS: string;
  i: integer;
begin
  if s = '' then Exit;
  reS := s;
  for i := 1 to Length(Spam) do
  begin
    while pos(Spam[i], reS) <> 0 do
      Delete(reS, (pos(Spam[i], reS)), 1);
  end;
  result := reS;
end;

{--------------------------------------------------------------------------}
// Удаления из списка строк всех пробелов в строках.

function DelBlankStrings(s: Tstrings): Tstrings;
var i, con: integer;
  st: string;
begin
  con := s.Count;
  for i := 0 to con - 1 do
  begin
    st := s.Strings[i];
    while pos(' ', st) <> 0 do
      Delete(st, (pos(' ', st)), 1);
    s.Strings[i] := st;
  end;
  result := s;
end;

{--------------------------------------------------------------------------}
// Удаления из списка строк всех пустых строк.

function DelEmpStrings(s: Tstrings): Tstrings;
var i, b, p, con: integer;
  st: string;
  flag: boolean;
begin
  con := s.Count;
  for p := 0 to con do
    for i := 0 to con do
    begin
      st := s.Strings[i];
      flag := true;
      for b := 1 to Length(s.Strings[i]) do
        if st[b] <> ' ' then flag := false;
      if flag then
        s.Delete(i);
    end;
  result := s;
end;

{--------------------------------------------------------------------------}
// Удаления из списка строк всех повторяюших строк.

function DeleteCopy(s: Tstrings): Tstrings;
var i, n: integer;
begin
  i := 0;
  while i <> s.Count do begin
    n := i + 1;
    while n <> s.Count do
      if s.Strings[i] = s.Strings[n] then s.Delete(n) else n := n + 1;
    i := i + 1;
  end;
  result := s;
end;

{--------------------------------------------------------------------------}
// Удаления из списка, строки повторяюшии в маске

function DelCopyMask(s, mask: Tstrings): Tstrings;
var x, i: integer;
  ts: TStringList;
begin
  ts := TStringList.Create;
  for x := 0 to mask.Count - 1 do
  begin i := 0;
    while i <> s.Count do
      if mask.Strings[x] = s.Strings[i] then s.Delete(i) else i := i + 1;
  end;
  ts.AddStrings(s);
  result := ts;
end;

{--------------------------------------------------------------------------}
// Возвратит строку с указанной большой буквой

function LargeLtterStr(const s: string; N: integer): string;
var reS, v: string;
begin
  if s = '' then Exit;
  if (N <= 0) and (N < Length(s)) then Exit;
  reS := s;
  v := reS[N]; v := AnsiUpperCase(v);
  reS[N] := v[1];
  result := reS;
end;

{--------------------------------------------------------------------------}
// Возвращает строку где все слова начинаются с большой буквы

function LargeStr(const s: string): string;
var reS: string;
  i: integer;
begin
  reS := s;
  if reS = '' then Exit;
  reS := LargeLtterStr(reS, 1);
  for i := 1 to Length(reS) - 1 do
    if reS[i] = ' ' then
      reS := LargeLtterStr(reS, i + 1);
  result := reS;
end;

{--------------------------------------------------------------------------}
// Возвращает аббревиатуру слов.

function AbbrevStr(const s: string): string;
var reS, val: string;
begin
  reS := Trim(s);
  reS := DelDoubBlank(reS);
  if reS = '' then Exit;
  val := res[1];
  while Pos(' ', reS) > 0 do
  begin
    val := val + reS[(Pos(' ', reS)) + 1];
    reS[(Pos(' ', reS))] := 'x';
  end;
  result := AnsiUpperCase(val);
end;

{--------------------------------------------------------------------------}
// Возвращает слово наоборот  - торобоан.

function SrtTotrS(const s: string): string;
var reS, val: string;
  i: integer;
begin
  reS := s;
  for i := 1 to Length(reS) do
    val := Concat(reS[i], val);
  result := val;
end;

{--------------------------------------------------------------------------}
// Возвращает с английской раскладкой в русскою

function EngToRus(const s: string): string;
var reS: string;
  i, e: integer;
begin
  if s = '' then Exit;
  reS := s;
  for i := 1 to Length(Res) do
    for e := 1 to Length(EngLet) do
      if reS[i] = EngLet[e] then
        reS[i] := RusLet[e];
  result := reS;
end;

{--------------------------------------------------------------------------}
// Возвращает с русской раскладкой в английскою

function RusToEng(const s: string): string;
var reS: string;
  i, e: integer;
begin
  if s = '' then Exit;
  reS := s;
  for i := 1 to Length(Res) do
    for e := 1 to Length(RusLet) do
      if reS[i] = RusLet[e] then
        reS[i] := EngLet[e];
  result := reS;
end;

{--------------------------------------------------------------------------}
// Сравнивает две строки и возвращает процент сходства

function SimStrPro(const s1, s2: string): integer;
var pro, i: integer;
begin
  pro := 0;
  for i := 1 to Length(s1) do
    if s1[i] = s2[i] then pro := pro + 1;
  result := (100 div Length(s1)) * pro;
end;

{--------------------------------------------------------------------------}
// Удаления из строки всех <Тегов>

function DeleteTag(s: string): string;
var i, n: integer;
begin
  while Pos('<', s) <> 0 do
  begin
    n := 1;
    i := Pos('<', s);
    while s[i + n] <> '>' do
      n := n + 1;
    Delete(s, i, n + 1);
  end;
  result := s;
end;

{--------------------------------------------------------------------------}
// Выделения из строки всех <Тегов>

function CopyTag(s: string): string;
var i, n: integer;
  tag: string;
begin
  while Pos('<', s) <> 0 do
  begin
    n := 1;
    i := Pos('<', s);
    while s[i + n] <> '>' do
      n := n + 1;
    tag := tag + Copy(s, i, n + 1);
    Delete(s, i, n + 1);
  end;
  result := tag;
end;

{--------------------------------------------------------------------------}
// Замена спец. HTML символов (&nbsp; &amp; &lt; &gt; &quot;)на(пробел & < > ")

function ChangeHSym(s: string): string;
var p: integer;
  Flags: TReplaceFlags;
begin
  Flags := [rfReplaceAll];
  for p := 0 to high(HSym) do
    s := StringReplace(S, HSym[p], TSym[p], Flags);
  result := s;
end;

{--------------------------------------------------------------------------}
// Замена спец. символов из(пробел & < > ")на(&nbsp; &amp; &lt; &gt; &quot;)

function ChangeTSym(s: string): string;
var p: integer;
  Flags: TReplaceFlags;
begin
  Flags := [rfReplaceAll];
  s := StringReplace(S, '  ', ' &nbsp;', Flags);
  for p := 1 to high(TSym) - 1 do
    s := StringReplace(S, TSym[p], HSym[p], Flags);
  result := s;
end;

{--------------------------------------------------------------------------}
// Выделения из HTML строки всех E-Mail <a href="mailto: ">

function GetHtmlMail(s: string): TStringList;
var MailList: TStringList;
  n, i: integer;
begin
  MailList := TStringList.Create;
  s := CopyTag(s); //оставляем одни теги
  s := AnsiLowerCase(s); //переводем всё в нижний регистр
  S := DeleteSpam(S); //Удаление спама
// удаление из строк знака "   {-}
  while pos('"', s) <> 0 do {-}
    Delete(s, (pos('"', s)), 1); {-}
//-----------------------------{-}
// Удалять лишнии арбитры см. константу Arbits
  for n := 0 to high(Arbits) do
    while pos(Arbits[n], S) <> 0 do
      Delete(S, (pos(Arbits[n], S)), Length(Arbits[n]));
  s := DeleteBlank(s); //удаляем пробелы
  while pos('<ahref=mailto:', s) <> 0 do
  begin
    n := 1;
    i := pos('<ahref=mailto:', s);
    while s[i + n] <> '>' do
      n := n + 1;
    MailList.Append(Copy(s, i + 14, n - 14));
    Delete(s, i, n + 1);
  end;
  result := MailList;
end;

{--------------------------------------------------------------------------}
// Выделения из строки всех E-Mail tarasui@mail.ru

function StrToMail(s: string): TStringList;
var MailList: TStringList;
  E: string;
  I, N, t: Integer;
begin
  MailList := TStringList.Create;
  while pos('@', S) <> 0 do
  begin
    i := Pos('@', S); t := 0;
    if i > 1 then n := i - 1 else n := 1;
    while (S[n] in PSEM) and (n > 1) do Dec(n);
    if not (S[n] in PSEM) then Inc(n);
    e := Copy(S, n, 255);
    i := Pos('@', e);
    while (e[i] in PSEM) and (i < Length(e)) do Inc(i);
    if not (e[i] in PSEM) then Dec(i);
    e := Copy(e, 1, i);
    if (Length(Copy(e, 1, Pos('@', e) - 1)) > 0) and (Length(Copy(e, Pos('@', e) + 1, 255)) > 0) then
    begin
      for i := Pos('@', e) to Length(e) - 1 do if e[i] = '.' then t := t + 1;
   ///
      if t >= 1 then MailList.Append(e);
    end;
    Delete(s, Pos('@', S), 1);
  end;
  result := MailList;
end;

{--------------------------------------------------------------------------}
// Выделения HTML текста всех ссылок

function GetHtmllink(const s: string): TStringList;
var LinkList: TStringList;
  reS, vs: string;
  p, i, n: integer;
begin
  LinkList := TStringList.Create;
  reS := CopyTag(s); //оставляем одни теги
  reS := DeleteSpam(reS); //Удаление спама
// удаление из строк знака "
  while pos('"', reS) <> 0 do
    Delete(reS, (pos('"', reS)), 1);
//---------------------------------{-}
  reS := AnsiLowerCase(res); //переводем всё в нижний регистр
// Удалять лишнии арбитры см. константу Arbits
  for p := 0 to high(Arbits) do
    while pos(Arbits[p], reS) <> 0 do
      Delete(reS, (pos(Arbits[p], reS)), Length(Arbits[p]));
  reS := DelDoubBlank(reS); //удаление двойных пробелов
  while (pos('<a href=', reS) <> 0) do
  begin
    n := 1;
    i := pos('<a href=', reS);
    while reS[i + n] <> '>' do
      n := n + 1;
        // если ссылка начинается с #  \ + то ее путь на себя же
    if (reS[i + 8] = '@') or (reS[i + 8] = '&') or (reS[i + 8] = '?') or
           //(reS[i+8]=';')or(reS[i+8]=':')or(reS[i+8]='~')or(reS[i+8]='!')or
    (reS[i + 8] = '\') or (reS[i + 8] = '#') or (reS[i + 8] = '+') then Delete(reS, i, n + 1)
    else begin
      vs := Trim(Copy(reS, i + 8, n - 8));
        // После знака # идет ненужная метка
      for p := 1 to Length(vs) do begin
        if vs[p] = '#' then Delete(vs, p, Length(vs));
        if vs[p] = ' ' then Delete(vs, p, Length(vs));
               //if vs[p] = ';' then Delete(vs, p, Length(vs));
      end;
      if not ((Copy(vs, 1, 11) = 'javascript:') or (Copy(vs, 1, 7) = 'mailto:')) then
        LinkList.Append(vs);
      Delete(reS, i, n + 1);
    end;
  end;
  result := LinkList;
end;

{--------------------------------------------------------------------------}
// Удаляет http:// из ссылки, если oн там есть

function DelHttp(s: string): string;
begin
  if s = '' then Exit;
  if (s[1] + s[2] + s[3] + s[4] + s[5] + s[6] + s[7]) = 'http://' then
    Delete(s, 1, 7);
  result := s;
end;

{--------------------------------------------------------------------------}
// Возвращает из http://grundic.hut.ru/files/index.htm > grundic.hut.ru

function CopyServer(const s: string): string;
var res: string;
  t, i: integer;
begin
  if s = '' then Exit;
  if (Copy(s, 1, 7) = 'http://') or (Copy(s, 1, 4) = 'www.') then
  begin
    res := DelHttp(s);
    for i := 1 to Length(res) do
      if res[i] = '/' then
        Delete(res, i, Length(res));
    result := res;
    exit;
  end;
  for i := 1 to Length(res) do
    if res[i] = '/' then
      Delete(res, i, Length(res));
  t := 0;
  for i := 1 to Length(res) do
    if res[i] = '.' then t := t + 1;
  if t < 2 then
  begin
    result := '0';
    exit;
  end;
  result := res;
end;

{--------------------------------------------------------------------------}
// Возвращает локальность ссылки относительно маски

function CompareLink(s, mask: string): byte;
var i: integer;
begin
  if s[1] = '/' then begin
    result := L_NOTE;
    exit;
  end;
  if (Copy(s, 1, 7) = 'http://') or (Copy(mask, 1, 7) = 'http://') then
  begin
    s := DelHttp(s);
    mask := DelHttp(mask);
    for i := 1 to Length(S) do
      if S[i] = '/' then
        Delete(S, i, Length(S));
    for i := 1 to Length(mask) do
      if mask[i] = '/' then
        Delete(mask, i, Length(mask));
    if CompareText(s, mask) = 0 then begin
      result := L_LOCAL;
      Exit;
    end;
  end;
  s := DelHttp(s);
  mask := DelHttp(mask);
  if (Copy(s, 1, 4) = 'www.') or (Copy(mask, 1, 4) = 'www.') then
  begin
    if (Copy(s, 1, 4) = 'www.') then Delete(s, 1, 4);
    if (Copy(mask, 1, 4) = 'www.') then Delete(mask, 1, 4);
    for i := 1 to Length(S) do
      if S[i] = '/' then
        Delete(S, i, Length(S));
    for i := 1 to Length(mask) do
      if mask[i] = '/' then
        Delete(mask, i, Length(mask));
    if CompareText(s, mask) = 0 then begin
      result := L_LOCAL;
      Exit;
    end else
    begin
      result := L_GLOBAL;
      Exit;
    end;
  end;
  for i := 1 to Length(S) do
    if S[i] = '/' then
      Delete(S, i, Length(S));
  for i := 1 to Length(mask) do
    if mask[i] = '/' then
      Delete(mask, i, Length(mask));
  if CompareText(s, mask) = 0 then begin result := L_LOCAL; Exit; end;
  result := L_GLOBAL;
end;

{--------------------------------------------------------------------------}
// Выделения расширения из ссылки (.shtml .html .cgi)

function GetExtLink(const s: string): ShortString;
var reS: ShortString;
  i: Byte;
begin result := '0';
  reS := ExtractFileExt(s);
  if reS[1] <> '.' then Exit
  else Delete(res, 1, 1);
  for i := 1 to Length(reS) do
    if (reS[i] = '#') or (reS[i] = '?') or (reS[i] = '/') then
      Delete(reS, i, Length(reS));
  for i := 0 to high(zone) do
    if AnsiUpperCase(reS) = zone[i] then Exit;
  for i := 0 to high(domain) do
    if AnsiUpperCase(reS) = domain[i] then Exit;
  if reS = '' then Exit;
  result := reS;
end;

{--------------------------------------------------------------------------}
// Выделения ccTLD доменa из ссылки (.ru .uk .ua)

function GetZone(const s: string): ShortString;
var reS: ShortString;
  i: Byte;
begin
  if s = '' then Exit;
  result := '0';
  reS := DelHttp(s);
  Delete(res, (pos('/', res)), Length(reS));
  reS := ExtractFileExt(res);
  if reS[1] = '.' then Delete(res, 1, 1)
  else Exit;
  for i := 0 to high(zone) do
    if AnsiUpperCase(reS) = zone[i] then
    begin
      result := zone[i];
      Break;
    end
end;

{--------------------------------------------------------------------------}
// Возвращает c ccTLD доменa назвавие страны(зоны) по русский

function ZoneToState(const s: ShortString): ShortString;
var i: Byte;
begin
  for i := 0 to high(zone) do
    if AnsiUpperCase(s) = zone[i] then
    begin
      result := State[i];
      Break;
    end
    else
      result := '0';
end;

{--------------------------------------------------------------------------}
// Сложение ссылок (для неполных ссылок типа ../../foto/gala.html)

function ConcatLink(const link, val: string): string;
var i, n: integer;
  l, q: string;
begin
  result := val;
  if (link = val) or (Copy(val, 1, 7) = 'http://') or (Copy(val, 1, 4) = 'www.') then Exit;
  if not (Copy(val, 1, 3) = '../') then
  begin
    for i := 1 to Length(val) - 1 do
    begin
      if val[i] = '/' then Break;
      if val[i] = '.' then
      begin
        l := val;
        Delete(l, (pos('/', l)), Length(l));
        Delete(l, (pos('', l)), Length(l));
        l := AnsiUpperCase(ExtractFileExt(l));
        for n := 0 to Length(zone) do if l = '.' + zone[n] then Exit;
        for n := 0 to Length(Domain) do if l = '.' + Domain[n] then Exit;
      end;
    end;
    l := val;
    if l[1] = '/' then Delete(l, 1, 1);
    result := ExtractPath(link) + l;
    Exit;
  end
  else
  begin
    l := val;
    q := ExtractPath(link); Delete(q, Length(q), 1);
    while not (Copy(l, 1, 3) <> '../') do
    begin
      for i := Length(q) downto 1 do
        if q[i] = '/' then Break;
      Delete(q, i, Length(q));
      Delete(l, 1, 3);
    end;
    result := q + '/' + l;
  end;
end;

{--------------------------------------------------------------------------}
// Получение пути к папке (grundic.ru/foto/vasia.html > grundic.ru/foto/)

function ExtractPath(const link: string): string;
var i, n: integer;
  l: string;
begin
  l := link;
  if link[Length(link)] = '/' then Delete(l, Length(link), 1);
  if Pos('/', l) = 0 then begin result := l + '/'; Exit; end;
  result := l;
  for i := Length(l) downto 1 do
  begin
    if l[i] = '/' then begin result := l + '/'; Exit; end;
    if l[i] = '.' then
      for n := Length(l) downto 1 do
        if l[n] = '/' then begin result := copy(l, 1, n); Exit; end;
  end;
end;

{--------------------------------------------------------------------------}
end.
