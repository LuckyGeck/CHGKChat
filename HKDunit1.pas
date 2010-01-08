unit HKDUnit1;

interface

Uses SysUtils,Messages,Windows,MMSystem,Classes,Variants,Dialogs,Graphics,Forms,
Controls,ShlOBJ,comctrls, WinInet, Masks, ExtCtrls, ShellAPI,StdCtrls, Menus,
aCTIVEx,RichEdit, inifiles;

type
   TKeyType = (ktCapsLock, ktNumLock, ktScrollLock);

{--------------РАБОТА С ФАЙЛАМИ------------------------------------}
//Проверка файла: 1-нет файла;0-файл присутствует
function CheckFile(filename:string):integer;
//Процедура открытия файла опред. размера, где s-содерж. файла
procedure fileOpenRead(filename: string;var s: string);
//Сохранение файла
procedure SaveFile(FN:string; txt:string);
//Функция возвращающая время и дату последнего изменения файла
function GetFileDate(FileName: string): string;
//Функция возвращающая дату последнего изменения файла
function GetFileDate2(FileName: string): string;
//Сколько занимает файл
function GetFileSize(FileName: String): LongInt;
//проверка доступности файла (другим процессом)
function IsFileInUse(const fName: TFileName): Boolean;
//Вынуть из пути, только путь к файлу, без имени файла
function ExtractDir(FileName: string): string;
//Возвращает из пути при TRUE - имя файла с расширением, иначе без него
function ExtractFileNameEx(FileName: string; ShowExtension: Boolean): string;
//Возвращает расширение файла
function GetFileExt(Filename: string): string;
{--------------ПРИЛОЖЕНИЕ----------------------------------}
function ApplicationPath: string;
{--------------РАБОТА С КАТОЛОГАМИ----------------------------------}
//Удалить папку
function MyRemoveDir(sDir: string): Boolean;
{------------------РИСОВАНИЕ И ГРАФИКА------------------------------}
//Создание тени для компонентов формы. Пример использования:
  {procedure TForm1.FormPaint(Sender: TObject);
   var i: Integer;
   begin
    for i := 0 to Self.ControlCount - 1 do
     ShadeIt(Self, Self.Controls[i], 3, clBlack);
   end;}
procedure ShadeIt(f: TForm; c: TControl; Width: Integer; Color: TColor);
//Масштабирование компонентов формы
procedure ControlResolution(oForm:TForm);
//Изображение градиента на форме пр. исп. [Grad (Form1.Canvas,$1654D3,$8BAACF,true);]
procedure Gradient(Holst:TCanvas;FColor,LColor:TColor; VertOrientation:boolean);
{------------ПРОЦЕДУРЫ ОЧИСТКИ/УДАЛЕНИЯ-----------------}
//Очистка документов в Пуске
procedure ClearDoc;
//Очистить корзину
procedure ClearReq;
//Очистить кеш IE
procedure DeleteIECache;
//Узнать путь к Temp
function c_GetTempPath: string;
//Увеличить изображение в несколько раз благодоря билинейной ин.
procedure Interpolate(var bm: TBitMap; dx, dy: single;pb:tprogressbar);
{-------------РАБОТА СО СТРОКАМИ----------------------------}
//Разбивает строку с заданной маской на строки GB
function Tokenize(Str: WideString; Delimiter: string): TStringList;
//Удаление из строки ненужных символов
function strtst(var Input: string; EArray: string; Action: integer): string;
//Процедура приведения строки к верхниму регистру
procedure strtoBig(s_1 : string; var s_2: string);
//Удаление подстроки из строки What - что удалаяем
function RemoveInvalid(what, where: string): string;
//Поиск первого вхожденя подстроки в строку, FromPos - с какого символаначинать (=1!)
function fAnsiPos(const Substr, S: string; FromPos: integer): Integer;
//Определяет присутствие подстроки в строке
function Find(const S, P: string): boolean;
{--------------------Преобразования--------------------------------------}
function StringToPWide(sStr: string; var iNewSize: integer): PWideChar;
function PWideToString(pw: PWideChar): string;
function strtoPchar(s:string):Pchar;
{--------------------СИСТЕМНЫЕ--------------------------------------}
//Завершение работы Windows
Procedure CloseWindows;
//Перезагрузка Windows
Procedure RestartWindows;
//Открытие CD-ROM
procedure OpenCD;
//Закрытие CD-ROM
procedure CloseCD;
//Задержка
procedure Delay(dwMilliseconds: Longint);
//Перезапустить свою программу
Procedure Restart_Program;
{--------------------ИНТЕРНЕТ-----------------------------------------------}
//Скачать файл с http
function GetInetFile(const fileURL, FileName: string): boolean;
{--------------------ДИАЛОГИ И ОКНА---------------------------------------------------}
//Диалог выбора папки с кнопкой создать
{AdvSelectDirectory('Caption', 'c:\', dir, False, False, True);
   Label1.Caption := dir;}
 function AdvSelectDirectory(const Caption: string; const Root: WideString;
   var Directory: string; EditBox: Boolean = False; ShowFiles: Boolean = False;
   AllowCreateDirs: Boolean = True): Boolean;
{-----------------------------Форма------------------------------------------------------------}
//Сохранение и загрузка размера формы
procedure SaveLoadFormParam(form1 : Tform; Patch : string; Loading : boolean);
{--------------------ПРИКОЛЫ---------------------------------------------------------}
//Включить или выклучить Num Caps Scroll индикаторы!
procedure SetLedState(KeyCode: TKeyType; bOn: Boolean);//ktCapsLock, ktNumLock, ktScrollLock//SetLedState(ktCapsLock, True);  // CapsLock on
{--------------------КОДИРОВАНИЕ---------------------------------------------------------}
//Кодер с паролем
procedure Code(var text: string; password: string; decode: boolean);
//Мой кодер
procedure HKDCoder(var s:string; decode:boolean);
{============Функции для компонентов===================}
{---------------------------RxRichEdit----------------------------------------------------------}
//Кодирование BMP -> RTF
function BitmapToRTF(pict: TBitmap): string;
function EditStreamInCallback(dwCookie: Longint; pbBuff: PByte; cb: Longint; var pcb: Longint): DWORD; stdcall;
{--------------------END---------------------------------------------------------}

implementation
{---------------------------------------------------------------------------}
procedure strtoBig(s_1 : string; var s_2: string);
var s__,S__2: string;
    i_,j_ : integer;
begin
s__:='абвгдеёжзийклмнопрстуфхцчшщъыьэюяabcdefghijklmnopqrstuvwxyz';
s__2:='АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯABCDEFGHIJKLMNOPQRSTUVWXYZ';
s_2:=s_1;
for i_:=1 to Length(s_1) do
 for j_:=1 to 59 do
  begin
  if s_1[i_]=s__[j_] then
                          s_2[i_]:=s__2[j_];
  end;
end;
{------------------------------------------------------------------------------}
function GetFileDate(FileName: string): string;
var
  FHandle: Integer;
begin
  FHandle := FileOpen(FileName, 0);
  try
    Result := DateTimeToStr(FileDateToDateTime(FileGetDate(FHandle)));
  finally
    FileClose(FHandle);
  end;
end;
{------------------------------------------------------------------------------}
function GetFileDate2(FileName: string): string;
var
  FHandle: Integer;
begin
  FHandle := FileOpen(FileName, 0);
  try
    Result:=DateTimeToStr(FileDateToDateTime(FileGetDate(FHandle)));
    Result[11]:=' ';
  finally
    FileClose(FHandle);
  end;
end;

Procedure CloseWindows;
begin
if not ExitWindows(EW_RebootSystem, 0) then
ShowMessage('Приложение не может завершить работу');
end;
{------------------------------------------------------------------------------}
Procedure RestartWindows;
begin
if not ExitWindows(EW_RebootSystem, 0) then
ShowMessage('Приложение не может завершить работу');
end;
{------------------------------------------------------------------------------}
procedure OpenCD;
var handle: thandle;
begin
mciSendString('Set cdaudio door open wait', nil, 0, handle);
end;
{------------------------------------------------------------------------------}
procedure CloseCD;
var handle: thandle;
begin
mciSendString('Set cdaudio door closed wait', nil, 0, handle);
end;
{------------------------------------------------------------------------------}
function CheckFile(filename:string):integer;
var f : file;
begin
assignfile(f,filename);
         {$I-}
         reset(f);
         closefile(f);
         {$I+}
if Ioresult <>0 then
                CheckFile:=1
                else
                CheckFile:=0
end;
{------------------------------------------------------------------------------}
procedure fileOpenRead(filename: string;var s: string);
var buf2 : array[0..500000] of char;
    stream: Tstream;
    i:integer;
begin
 try
  stream:=TfileStream.Create(filename, fmOpenRead);
  stream.Read(buf2,500000);
  finally
  s:=strPas(buf2);
  for i:=0 to length(s) do
   buf2[i]:=#0;
  Stream.Free;
 end;
end;
{------------------------------------------------------------------------------}
procedure Gradient(Holst:TCanvas;FColor,LColor:TColor; VertOrientation:boolean);
{Holst - Canvas, на котором мы будем рисовать, FColor - начальный,
а LColor - конечный цвет градиента, VertOrientation указывает на вертикальную
или горизонтальную ориентацию заливки}
type
TRGB=record
b,g,r:byte;
end;
ARGB=array [0..1] of TRGB;
PARGB=^ARGB;
var
b:TBitMap;
p:PARGB;
x,y:integer;
s1,s2,fb,fg,fr,lb,lg,lr:string;
r1,r2,g1,g2,b1,b2:byte;
//Эти переменные нужны для анализа заданных цветов
begin
s1:=IntToHex(FColor,6);
s2:=IntToHex(LColor,6);
if Length(s1)>6 then Delete(s1,1,Length(s1)-6);
if Length(s2)>6 then Delete(s2,1,Length(s2)-6);
fb:=Copy(s1,1,2);
fg:=Copy(s1,3,2);
fr:=Copy(s1,5,2);
lb:=Copy(s2,1,2);
lg:=Copy(s2,3,2);
lr:=Copy(s2,5,2);
//Анализируем заданные цвета
b1:=StrToInt('$'+fb);
b2:=StrToInt('$'+lb);
g1:=StrToInt('$'+fg);
g2:=StrToInt('$'+lg);
r1:=StrToInt('$'+fr);
r2:=StrToInt('$'+lr);
//Определяем начальное и конечное значение для каждого из RGB составляющего
b:=TBitMap.Create;
b.PixelFormat:=pf24bit;
b.Width:=Holst.ClipRect.Right-Holst.ClipRect.Left;
b.Height:=Holst.ClipRect.Bottom-Holst.ClipRect.Top;
{У TCanvas нет свойств Width и Height, для определения размеров BitMap
вычисляем размеры отрисовываемой области}
for y:=0 to b.Height-1 do
begin
p:=b.ScanLine[y];
for x:=0 to b.Width-1 do
begin
//Выполняем заливку
if VertOrientation then begin
p[x].r:=r1-(r1-r2)*y div b.Height;
p[x].g:=g1-(g1-g2)*y div b.Height;
p[x].b:=b1-(b1-b2)*y div b.Height;
end
else begin
p[x].r:=r1-(r1-r2)*x div b.Width;
p[x].g:=g1-(g1-g2)*x div b.Width;
p[x].b:=b1-(b1-b2)*x div b.Width;
end
end;
end;
Holst.Draw(0,0,b);
b.Free;
end;
{------------------------------------------------------------------------------}
procedure ShadeIt(f: TForm; c: TControl; Width: Integer; Color: TColor); 
var 
  rect: TRect; 
  old: TColor; 
begin 
  if (c.Visible) then 
  begin 
    rect := c.BoundsRect; 
    rect.Left := rect.Left + Width;
    rect.Top := rect.Top + Width;
    rect.Right := rect.Right + Width;
    rect.Bottom := rect.Bottom + Width; 
    old := f.Canvas.Brush.Color; 
    f.Canvas.Brush.Color := Color; 
    f.Canvas.fillrect(rect); 
    f.Canvas.Brush.Color := old; 
  end; 
end;
{------------------------------------------------------------------------------}
procedure ClearDoc;
begin
SHAddToRecentDocs(SHARD_PATH, nil);
end;
{------------------------------------------------------------------------------}
procedure ClearReq;
const
   SHERB_NOCONFIRMATION = $00000001;
   SHERB_NOPROGRESSUI = $00000002;
   SHERB_NOSOUND = $00000004;
type
   TSHEmptyRecycleBin = function(Wnd: HWND;
                                 pszRootPath: PChar;
                                 dwFlags: DWORD): HRESULT;  stdcall;
var
   SHEmptyRecycleBin: TSHEmptyRecycleBin;
   LibHandle: THandle;
begin  { EmptyRecycleBin }
   LibHandle := LoadLibrary(PChar('Shell32.dll'));
   if LibHandle <> 0 then @SHEmptyRecycleBin :=
       GetProcAddress(LibHandle, 'SHEmptyRecycleBinA')
   else
   begin
     MessageDlg('Failed to load Shell32.dll.', mtError, [mbOK], 0);
     Exit;
   end;

   if @SHEmptyRecycleBin <> nil then
     SHEmptyRecycleBin(Application.Handle,
                       nil,
                       SHERB_NOCONFIRMATION or SHERB_NOPROGRESSUI or SHERB_NOSOUND);
   FreeLibrary(LibHandle); @SHEmptyRecycleBin := nil;
end;
{------------------------------------------------------------------------------}
function c_GetTempPath: string;
var Buffer: array[0..1023] of Char;
begin
  SetString(Result, Buffer, GetTempPath(Sizeof(Buffer) - 1, Buffer));
end;
{------------------------------------------------------------------------------}
function MyRemoveDir(sDir: string): Boolean;
var
  iIndex: Integer;
  SearchRec: TSearchRec;
  sFileName: string;
begin
  Result := False;
  sDir := sDir + '/*.*';
  iIndex := FindFirst(sDir, faAnyFile, SearchRec);
  while iIndex = 0 do
  begin
    sFileName := ExtractFileDir(sDir)+'\'+SearchRec.name;
    if SearchRec.Attr = faDirectory then
    begin
      if (SearchRec.name <> '' ) and
         (SearchRec.name <> '.') and
         (SearchRec.name <> '..') then
        MyRemoveDir(sFileName);
    end
    else
    begin
      if SearchRec.Attr <> faArchive then
        FileSetAttr(sFileName, faArchive);
    end;
    iIndex := FindNext(SearchRec);
  end;
  //FindClose(SearchRec);
  RemoveDir(ExtractFileDir(sDir));
  Result := True;
end;
{------------------------------------------------------------------------------}
procedure Interpolate(var bm: TBitMap; dx, dy: single;pb:tprogressbar);
var
  bm1: TBitMap;
  z1, z2: single;
  k, k1, k2: single;
  x1, y1: integer;
  c: array [0..1, 0..1, 0..2] of byte;
  res: array [0..2] of byte;
  x, y: integer;
  xp, yp: integer;
  xo, yo: integer;
  col: integer;
  pix: TColor;
begin
  bm1 := TBitMap.Create;
  bm1.Width := round(bm.Width * dx);
  bm1.Height := round(bm.Height * dy);
  for y := 0 to bm1.Height - 1 do
  begin
    for x := 0 to bm1.Width - 1 do
    begin
      xo := trunc(x / dx);
      yo := trunc(y / dy);
      x1 := round(xo * dx);
      y1 := round(yo * dy);
      for yp := 0 to 1 do
        for xp := 0 to 1 do
        begin
          pix := bm.Canvas.Pixels[xo + xp, yo + yp];
          c[xp, yp, 0] := GetRValue(pix);
          c[xp, yp, 1] := GetGValue(pix);
          c[xp, yp, 2] := GetBValue(pix);
        end;
      for col := 0 to 2 do
      begin
        k1 := (c[1,0,col] - c[0,0,col]) / dx;
        z1 := x * k1 + c[0,0,col] - x1 * k1;
        k2 := (c[1,1,col] - c[0,1,col]) / dx;
        z2 := x * k2 + c[0,1,col] - x1 * k2;
        k := (z2 - z1) / dy;
        res[col] := round(y * k + z1 - y1 * k);
      end;
      bm1.Canvas.Pixels[x,y] := RGB(res[0], res[1], res[2]);
    end;
    pb.position :=round(100 * y / bm1.Height);
    Application.ProcessMessages;
    if Application.Terminated then
      Exit;
  end;
  bm := bm1;
end;
{------------------------------------------------------------------------------}
procedure ControlResolution(oForm:TForm);
var
  iPercentage:integer;
begin
  if Screen.Width > 800 then
  begin
    iPercentage:=Round(((Screen.Width-800)/800)*100)+100-1;
    oForm.ScaleBy(iPercentage,100);
  end;
end;
{------------------------------------------------------------------------------}
function Tokenize(Str: WideString; Delimiter: string): TStringList;
var
  tmpStrList: TStringList;
  tmpString, tmpVal: WideString;
  DelimPos: LongInt;
begin
  tmpStrList := TStringList.Create;
  TmpString := Str;
  DelimPos := 1;
  while DelimPos > 0 do
  begin
    DelimPos := LastDelimiter(Delimiter, TmpString);
    tmpVal := Copy(TmpString, DelimPos + 1, Length(TmpString));
    if tmpVal <> '' then
      tmpStrList.Add(tmpVal);
    Delete(TmpString, DelimPos, Length(TmpString));
  end;
  Tokenize := tmpStrList;
end;
{------------------------------------------------------------------------------}
function strtst(var Input: string; EArray: string; Action: integer): string;
begin
  case Action of
    1:
      begin
        while length(Input) <> 0 do
        begin
          if pos(Input[1], EArray) = 0 then
            delete(Input, 1, 1)
          else
          begin
            result := result + Input[1];
            delete(Input, 1, 1);
          end;
        end;
      end;
    2:
      begin
        while length(Input) <> 0 do
        begin
          if pos(Input[1], EArray) <> 0 then
            delete(Input, 1, 1)
          else
          begin
            result := result + Input[1];
            delete(Input, 1, 1);
          end;
        end;
      end;
  else
    messagebox(0, 'Не корректный вызов функции.', '', mb_ok);
  end;
end;
{------------------------------------------------------------------------------}
procedure SaveFile(FN:string; txt:string);
var i_1,i:integer;   
     f: file of char;
     p: array[1..500000] of char;
begin
i_1:=length(txt);
for I:=1 to i_1 do
 p[i]:=txt[i];
assignfile(f,FN);
rewrite(f);
for i:=1 to i_1 do
 write(f,p[i]);
closefile(f);
end;
{------------------------------------------------------------------------------}
procedure DeleteIECache; 
var 
  lpEntryInfo: PInternetCacheEntryInfo; 
  hCacheDir: LongWord; 
  dwEntrySize: LongWord; 
begin 
  dwEntrySize := 0; 
  FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize); 
  GetMem(lpEntryInfo, dwEntrySize); 
  if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize; 
  hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize); 
  if hCacheDir <> 0 then  
  begin 
    repeat 
      DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName); 
      FreeMem(lpEntryInfo, dwEntrySize); 
      dwEntrySize := 0; 
      FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize); 
      GetMem(lpEntryInfo, dwEntrySize); 
      if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize; 
    until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize); 
  end; 
  FreeMem(lpEntryInfo, dwEntrySize); 
  FindCloseUrlCache(hCacheDir); 
end; 
{------------------------------------------------------------------------------}
function GetFileSize(FileName: String): LongInt;
var
  InfoFile: TSearchRec;
  AttrFile: Integer;
  ErrorReturn: Integer;
begin
  AttrFile := $0000003F; {Any file}
  ErrorReturn := FindFirst(FileName, AttrFile, InfoFile);
  if ErrorReturn <> 0 then
    Result := -1
  else
    Result := InfoFile.Size;
  //FindClose(InfoFile); 
end;
{------------------------------------------------------------------------------}
procedure Delay(dwMilliseconds: Longint);
 var
   iStart, iStop: DWORD;
 begin
   iStart := GetTickCount;
   repeat
     iStop := GetTickCount;
     Application.ProcessMessages;
   until (iStop - iStart) >= dwMilliseconds;
 end;
{------------------------------------------------------------------------------}
function GetInetFile(const fileURL, FileName: string): boolean;
const
  BufferSize = 1024;
var
  hSession, hURL: HInternet;
  Buffer: array[1..BufferSize] of Byte;
  BufferLen: DWORD;
  f: file;
  sAppName: string;
begin
  Result := False;
  sAppName := ExtractFileName(Application.ExeName);
  hSession := InternetOpen(PChar(sAppName),
  INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  try
    hURL := InternetOpenURL(hSession, PChar(fileURL), nil, 0, 0, 0);
    try
      AssignFile(f, FileName);
      Rewrite(f,1);
      repeat
        InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen);
        BlockWrite(f, Buffer, BufferLen);
      until
        BufferLen = 0;
      CloseFile(f);
      Result := True;
    finally
      InternetCloseHandle(hURL);
    end;
  finally
    InternetCloseHandle(hSession);
  end;
end;
{------------------------------------------------------------------------------}
 function AdvSelectDirectory(const Caption: string; const Root: WideString;
   var Directory: string; EditBox: Boolean = False; ShowFiles: Boolean = False;
   AllowCreateDirs: Boolean = True): Boolean;
  function SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: lParam): Integer;
     stdcall;
   var
     PathName: array[0..MAX_PATH] of Char;
   begin
     case uMsg of
       BFFM_INITIALIZED: SendMessage(Wnd, BFFM_SETSELECTION, Ord(True), Integer(lpData));
      {BFFM_SELCHANGED: 
      begin 
        SHGetPathFromIDList(PItemIDList(lParam), @PathName); 
      end;}
     end;
     Result := 0;
   end;
 var
   WindowList: Pointer;
   BrowseInfo: TBrowseInfo;
   Buffer: PChar;
   RootItemIDList, ItemIDList: PItemIDList;
   ShellMalloc: IMalloc;
   IDesktopFolder: IShellFolder;
   Eaten, Flags: LongWord;
 const
  BIF_USENEWUI = $0040;
   BIF_NOCREATEDIRS = $0200;
 begin
   Result := False;
   if not DirectoryExists(Directory) then
     Directory := '';
   FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
   if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then
   begin
     Buffer := ShellMalloc.Alloc(MAX_PATH);
     try
       RootItemIDList := nil;
       if Root <> '' then
       begin
         SHGetDesktopFolder(IDesktopFolder);
         IDesktopFolder.ParseDisplayName(Application.Handle, nil,
           POleStr(Root), Eaten, RootItemIDList, Flags);
       end;
       OleInitialize(nil);
       with BrowseInfo do
       begin
         hwndOwner := Application.Handle;
         pidlRoot := RootItemIDList;
         pszDisplayName := Buffer;
         lpszTitle := PChar(Caption);
        ulFlags := BIF_RETURNONLYFSDIRS or BIF_USENEWUI or
           BIF_EDITBOX * Ord(EditBox) or BIF_BROWSEINCLUDEFILES * Ord(ShowFiles) or
           BIF_NOCREATEDIRS * Ord(not AllowCreateDirs);
         lpfn    := @SelectDirCB;
         if Directory <> '' then
           lParam := Integer(PChar(Directory));
       end;
       WindowList := DisableTaskWindows(0);
       try
         ItemIDList := ShBrowseForFolder(BrowseInfo);
       finally
         EnableTaskWindows(WindowList);
       end;
       Result := ItemIDList <> nil;
       if Result then
       begin
         ShGetPathFromIDList(ItemIDList, Buffer);
         ShellMalloc.Free(ItemIDList);
         Directory := Buffer;
       end;
     finally
       ShellMalloc.Free(Buffer);
     end;
   end;
 end;
{------------------------------------------------------------------------------}
procedure SetLedState(KeyCode: TKeyType; bOn: Boolean);
 var
   KBState: TKeyboardState;
   Code: Byte;
 begin
   case KeyCode of
     ktScrollLock: Code := VK_SCROLL;
     ktCapsLock: Code := VK_CAPITAL;
     ktNumLock: Code := VK_NUMLOCK;
   end;
   GetKeyboardState(KBState);
   if (Win32Platform = VER_PLATFORM_WIN32_NT) then
   begin
     if Boolean(KBState[Code]) <> bOn then
     begin
       keybd_event(Code,
                   MapVirtualKey(Code, 0),
                   KEYEVENTF_EXTENDEDKEY,
                   0);

       keybd_event(Code,
                   MapVirtualKey(Code, 0),
                   KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP,
                   0);
     end;
   end
   else
   begin
     KBState[Code] := Ord(bOn);
     SetKeyboardState(KBState);
   end;
 end;
{------------------------------------------------------------------------------}
procedure Code(var text: string; password: string; decode: boolean);
var
  i, PasswordLength: integer;
  sign: shortint;
begin
  PasswordLength := length(password);
  if PasswordLength = 0 then
    Exit;
  if decode then
    sign := -1
  else
    sign := 1;
  for i := 1 to Length(text) do
    text[i] := chr(ord(text[i]) + sign *
      ord(password[i mod PasswordLength + 1]));
end;
{------------------------------------------------------------------------------}
function RemoveInvalid(what, where: string): string;
var
  tstr: string;
begin
  tstr:=where;
  while pos(what, tstr)>0 do
    tstr:=copy(tstr,1,pos(what,tstr)-1) +
  copy(tstr,pos(what,tstr)+length(tstr),length(tstr));
  Result:=tstr;
end; 
{------------------------------------------------------------------------------}
function fAnsiPos(const Substr, S: string; FromPos: integer): Integer;
var
  P: PChar;
begin
  Result := 0;
  P := AnsiStrPos(PChar(S) + fromPos - 1, PChar(SubStr));
  if P <> nil then
    Result := Integer(P) - Integer(PChar(S)) + 1;
end;
{------------------------------------------------------------------------------}
function BitmapToRTF(pict: TBitmap): string;
var
   bi, bb, rtf: string;
   bis, bbs: Cardinal;
   achar: ShortString;
   hexpict: string;
   I: Integer;
 begin
   GetDIBSizes(pict.Handle, bis, bbs);
   SetLength(bi, bis);
   SetLength(bb, bbs);
   GetDIB(pict.Handle, pict.Palette, PChar(bi)^, PChar(bb)^);
   rtf := '{\rtf1 {\pict\dibitmap ';
   SetLength(hexpict, (Length(bb) + Length(bi)) * 2);
   I := 2;
   for bis := 1 to Length(bi) do
   begin
     achar := Format('%x', [Integer(bi[bis])]);
     if Length(achar) = 1 then
       achar := '0' + achar;
     hexpict[I - 1] := achar[1];
     hexpict[I] := achar[2];
     Inc(I, 2);
   end;
   for bbs := 1 to Length(bb) do
   begin
     achar := Format('%x', [Integer(bb[bbs])]);
     if Length(achar) = 1 then
       achar := '0' + achar;
     hexpict[I - 1] := achar[1];
     hexpict[I] := achar[2];
     Inc(I, 2);
   end;
   rtf := rtf + hexpict + ' }}';
   Result := rtf;
 end;
{------------------------------------------------------------------------------}
function EditStreamInCallback(dwCookie: Longint; pbBuff: PByte; cb: Longint; var pcb: Longint): DWORD; stdcall;
 var
   theStream: TStream;
   dataAvail: LongInt;
 begin
   theStream := TStream(dwCookie);
   with theStream do
   begin
     dataAvail := Size - Position;
     Result := 0;
     if dataAvail <= cb then
     begin
       pcb := read(pbBuff^, dataAvail);
       if pcb <> dataAvail then
         Result := UINT(E_FAIL);
     end
     else
     begin
       pcb := read(pbBuff^, cb);
       if pcb <> cb then
         Result := UINT(E_FAIL);
     end;
   end;
 end;
{------------------------------------------------------------------------------}
function IsFileInUse(const fName: TFileName): Boolean;
 var
   HFileRes: HFILE;
 begin
   Result := False;
   HFileRes := CreateFile(PChar(fName),
                          GENERIC_READ or GENERIC_WRITE,
                          0,
                          nil,
                          OPEN_EXISTING,
                          FILE_ATTRIBUTE_NORMAL,
                          0);
   Result := (HFileRes = INVALID_HANDLE_VALUE);
   if not Result then
     CloseHandle(HFileRes);
 end;
{------------------------------------------------------------------------------}
function Find(const S, P: string): boolean;
var
  i, j: Integer;
begin
  Result := false;
  if Length(P) > Length(S) then
    Exit;
  for i := 1 to Length(S) - Length(P) + 1 do
    for j := 1 to Length(P) do
      if P[j] <> S[i + j - 1] then
        Break
      else if j = Length(P) then
      begin
        Result := true;
        Exit;
      end;
end;
{------------------------------------------------------------------------------}
procedure HKDCoder(var s:string; decode:boolean);
var n,i: integer;
begin
n:=Length(s);
if decode=false then
 begin
  for i:=0 to n do
  begin
  case s[i] of
   //Английские буквы
   'A':s[i]:='1'; 'a':s[i]:='9'; 'B':s[i]:='7'; 'b':s[i]:='3'; 'C':s[i]:='8';
   'c':s[i]:='2'; 'D':s[i]:='Д'; 'd':s[i]:='4'; 'E':s[i]:='6'; 'e':s[i]:='5';
   'F':s[i]:='0'; 'f':s[i]:='Й'; 'G':s[i]:='ц'; 'g':s[i]:='И'; 'H':s[i]:='У';
   'h':s[i]:='Ц'; 'I':s[i]:='К'; 'i':s[i]:='Е'; 'K':s[i]:='Щ'; 'k':s[i]:='Г';
   'L':s[i]:='Ш'; 'l':s[i]:='к'; 'M':s[i]:='З'; 'm':s[i]:='у'; 'N':s[i]:='Х';
   'n':s[i]:='Ф'; 'O':s[i]:='Ы'; 'o':s[i]:='А'; 'P':s[i]:='Н'; 'p':s[i]:='з';
   'R':s[i]:='в'; 'r':s[i]:='а'; 'S':s[i]:='П'; 's':s[i]:='^'; 'T':s[i]:='Р';
   't':s[i]:='р'; 'U':s[i]:='п'; 'u':s[i]:='х'; 'V':s[i]:='ф'; 'v':s[i]:='г';
   'W':s[i]:='ш'; 'w':s[i]:='%'; 'X':s[i]:='В'; 'x':s[i]:='щ'; 'Y':s[i]:='ы';
   'y':s[i]:='н'; 'Z':s[i]:='ъ'; 'z':s[i]:='е'; 'Q':s[i]:='б'; 'q':s[i]:='Б';
   //Цифры
   '1':s[i]:=')'; '2':s[i]:='о'; '3':s[i]:='Ж'; '4':s[i]:='м'; '5':s[i]:='Л';
   '6':s[i]:='л'; '7':s[i]:='М'; '8':s[i]:='ж'; '9':s[i]:='О'; '0':s[i]:='д';
   //Знаки
   '+':s[i]:='Э'; '-':s[i]:='Ю'; '*':s[i]:='Я'; '/':s[i]:='Ч'; '.':s[i]:='ч';
   ',':s[i]:='я'; ':':s[i]:='ю'; ';':s[i]:='э'; ' ':s[i]:='('; '=':s[i]:='~';
   '!':s[i]:='<'; '?':s[i]:='|'; '"':s[i]:='\'; '(':s[i]:=chr(1);
   ')':s[i]:=chr(2); '[':s[i]:=chr(3); ']':s[i]:=chr(4); '{':s[i]:=chr(5);
   '}':s[i]:=chr(6); '_':s[i]:=chr(7); '@':s[i]:=chr(8); '#':s[i]:=chr(9);
   '&':s[i]:=chr(17); '\':s[i]:=chr(11); '|':s[i]:=chr(12); '^':s[i]:=chr(18);
   '>':s[i]:=chr(14); '<':s[i]:=chr(15); '%':s[i]:=chr(16);
   //Русские буквы
   'А':s[i]:='H'; 'а':s[i]:='y'; 'Б':s[i]:='#'; 'б':s[i]:='+'; 'В':s[i]:='.';
   'в':s[i]:='V'; 'Г':s[i]:=','; 'г':s[i]:='M'; 'Д':s[i]:=':'; 'д':s[i]:='X';
   'Е':s[i]:='B'; 'е':s[i]:='E'; 'Ж':s[i]:='I'; 'ж':s[i]:='A'; 'З':s[i]:='i';
   'з':s[i]:='{'; 'И':s[i]:='K'; 'и':s[i]:='}'; 'Й':s[i]:='L'; 'й':s[i]:='d';
   'К':s[i]:=';'; 'к':s[i]:='@'; 'Л':s[i]:='C'; 'л':s[i]:='W'; 'М':s[i]:='*';
   'м':s[i]:='D'; 'Н':s[i]:='/'; 'н':s[i]:='z'; 'О':s[i]:='h'; 'о':s[i]:='f';
   'П':s[i]:='g'; 'п':s[i]:='&'; 'Р':s[i]:='Y'; 'р':s[i]:='Z'; 'С':s[i]:='x';
   'с':s[i]:='v'; 'Т':s[i]:='w'; 'т':s[i]:='l'; 'У':s[i]:='m'; 'у':s[i]:='b';
   'Ф':s[i]:='q'; 'ф':s[i]:='u'; 'Х':s[i]:='G'; 'х':s[i]:='a'; 'Ц':s[i]:='o';
   'ц':s[i]:='['; 'Ч':s[i]:='P'; 'ч':s[i]:='t'; 'Ш':s[i]:='F'; 'ш':s[i]:='U';
   'Щ':s[i]:='k'; 'щ':s[i]:='S'; 'ъ':s[i]:='c'; 'ь':s[i]:='n'; 'Ы':s[i]:='e';
   'ы':s[i]:='O'; 'Э':s[i]:='N'; 'э':s[i]:='p'; 'Ю':s[i]:='s'; 'ю':s[i]:='Q';
   'Я':s[i]:='T'; 'я':s[i]:='R';
 end;
 end;
 end
 else begin
   for i:=0 to n do
 begin
 case s[i] of
      //Английские буквы
      '1':s[i]:='A'; '9':s[i]:='a'; '7':s[i]:='B'; '3':s[i]:='b'; '8':s[i]:='C';
      '2':s[i]:='c'; 'Д':s[i]:='D'; '4':s[i]:='d'; '6':s[i]:='E'; '5':s[i]:='e';
      '0':s[i]:='F'; 'Й':s[i]:='f'; 'ц':s[i]:='G'; 'И':s[i]:='g'; 'У':s[i]:='H';
      'Ц':s[i]:='h'; 'К':s[i]:='I'; 'Г':s[i]:='k'; 'Ш':s[i]:='L'; 'к':s[i]:='l';
      'З':s[i]:='M'; 'у':s[i]:='m'; 'Х':s[i]:='N'; 'Ф':s[i]:='n'; 'Ы':s[i]:='O';
      'А':s[i]:='o'; 'Н':s[i]:='P'; 'з':s[i]:='p'; 'в':s[i]:='R'; 'а':s[i]:='r';
      'П':s[i]:='S'; '^':s[i]:='s'; 'Р':s[i]:='T'; 'р':s[i]:='t'; 'п':s[i]:='U';
      'х':s[i]:='u'; 'ф':s[i]:='V'; 'г':s[i]:='v'; 'ш':s[i]:='W'; '%':s[i]:='w';
      'В':s[i]:='X'; 'щ':s[i]:='x'; 'ы':s[i]:='Y'; 'н':s[i]:='y'; 'ъ':s[i]:='Z';
      'е':s[i]:='z'; 'Е':s[i]:='i'; 'Щ':s[i]:='K'; 'б':s[i]:='Q'; 'Б':s[i]:='q';
      //Цифры
      ')':s[i]:='1'; 'Ж':s[i]:='3'; 'о':s[i]:='2'; 'м':s[i]:='4'; 'Л':s[i]:='5';
      'л':s[i]:='6'; 'М':s[i]:='7'; 'ж':s[i]:='8'; 'О':s[i]:='9'; 'д':s[i]:='0';
      //Знаки
      'Э':s[i]:='+'; 'Ю':s[i]:='-'; 'Я':s[i]:='*'; 'Ч':s[i]:='/'; 'ч':s[i]:='.';
      'я':s[i]:=','; 'ю':s[i]:=':'; 'э':s[i]:=';'; '(':s[i]:=' '; '~':s[i]:='=';
      '<':s[i]:='!'; '|':s[i]:='?'; '\':s[i]:='"'; chr(1):s[i]:='(';
      chr(2):s[i]:=')'; chr(3):s[i]:='['; chr(4):s[i]:=']'; chr(5):s[i]:='{';
      chr(6):s[i]:='}'; chr(7):s[i]:='_'; chr(8):s[i]:='@'; chr(9):s[i]:='#';
      chr(17):s[i]:='&'; chr(11):s[i]:='\'; chr(12):s[i]:='|';
      chr(18):s[i]:='^'; chr(14):s[i]:='>'; chr(15):s[i]:='<';
      chr(16):s[i]:='%';
      //Русские буквы
      'H':s[i]:='А'; 'y':s[i]:='а'; '#':s[i]:='Б'; '+':s[i]:='б'; '.':s[i]:='В';
      'V':s[i]:='в'; ',':s[i]:='Г'; 'M':s[i]:='г'; ':':s[i]:='Д'; 'X':s[i]:='д';
      'B':s[i]:='Е'; 'E':s[i]:='е'; 'I':s[i]:='Ж'; 'A':s[i]:='ж'; 'i':s[i]:='З';
      '{':s[i]:='з'; 'K':s[i]:='И'; '}':s[i]:='и'; 'L':s[i]:='Й'; 'd':s[i]:='й';
      ';':s[i]:='К'; '@':s[i]:='к'; 'C':s[i]:='Л'; 'W':s[i]:='л'; '*':s[i]:='М';
      'D':s[i]:='м'; '/':s[i]:='Н'; 'z':s[i]:='н'; 'h':s[i]:='О'; 'f':s[i]:='о';
      'g':s[i]:='П'; '&':s[i]:='п'; 'Y':s[i]:='Р'; 'Z':s[i]:='р'; 'x':s[i]:='С';
      'v':s[i]:='с'; 'w':s[i]:='Т'; 'l':s[i]:='т'; 'm':s[i]:='У'; 'b':s[i]:='у';
      'q':s[i]:='Ф'; 'u':s[i]:='ф'; 'G':s[i]:='Х'; 'a':s[i]:='х'; 'o':s[i]:='Ц';
      '[':s[i]:='ц'; 'P':s[i]:='Ч'; 't':s[i]:='ч'; 'F':s[i]:='Ш'; 'U':s[i]:='ш';
      'k':s[i]:='Щ'; 'S':s[i]:='щ'; 'c':s[i]:='ъ'; 'n':s[i]:='ь'; 'e':s[i]:='Ы';
      'O':s[i]:='ы'; 'N':s[i]:='Э'; 'p':s[i]:='э'; 's':s[i]:='Ю'; 'Q':s[i]:='ю';
      'T':s[i]:='Я'; 'R':s[i]:='я';
 end;
 end;
end;
end;
{------------------------------------------------------------------------------}
function ExtractDir(FileName: string): string;
var
  I: Integer;
  S: string;
begin
  I := Length(FileName);
  if I <> 0 then
  begin
    while (FileName[i] <> '\') and (i > 0) do
      i := i - 1;
    S := Copy(FileName, 0 , i);
    Result:=s;
    i := Length(S);
    if i = 0 then
    begin
      Result := '';
      Exit;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function ExtractFileNameEx(FileName: string; ShowExtension: Boolean): string;
var
  I: Integer;
  S, S1: string;
begin
  I := Length(FileName);
  if I <> 0 then
  begin
    while (FileName[i] <> '\') and (i > 0) do
      i := i - 1;
    S := Copy(FileName, i + 1, Length(FileName) - i);
    i := Length(S);
    if i = 0 then
    begin
      Result := '';
      Exit;
    end;
    while (S[i] <> '.') and (i > 0) do
      i := i - 1;
    S1 := Copy(S, 1, i - 1);
    if s1 = '' then
      s1 := s;
    if ShowExtension = TRUE then
      Result := s
    else
      Result := s1;
  end
  else
    Result := '';
end;
{------------------------------------------------------------------------------}
function GetFileExt(Filename: string): string;
var
  I: Integer;
   S, S1: string;
Begin
I := Length(FileName);
if I <> 0 then
  begin
    while (FileName[i] <> '\') and (i > 0) do
      i := i - 1;
    S := Copy(FileName, i + 1, Length(FileName) - i);
    i := Length(S);
    if i = 0 then
     begin
      Result := '';
      Exit;
     end;
    while (S[i] <> '.') and (i > 0) do
      i := i - 1;
    //... и сохраням это имя файла в переменную s1
    Result := Copy(S, i +1,i+4);
  end;
end;
{------------------------------------------------------------------------------}
function StringToPWide(sStr: string; var iNewSize: integer): PWideChar;
var
  pw: PWideChar;
  iSize: integer;
begin
  iSize := Length(sStr) + 1;
  iNewSize := iSize * 2;
  pw := AllocMem(iNewSize);
  MultiByteToWideChar(CP_ACP, 0, PChar(sStr), iSize, pw, iNewSize);
  Result := pw;
end;
{------------------------------------------------------------------------------}
function PWideToString(pw: PWideChar): string;
var
  p: PChar;
  iLen: integer;
begin
  iLen := lstrlenw(pw) + 1;
  GetMem(p, iLen);
  WideCharToMultiByte(CP_ACP, 0, pw, iLen, p, iLen * 2, nil, nil);
  Result := p;
  FreeMem(p, iLen);
end;
{------------------------------------------------------------------------------}
function strtoPchar(s:string):Pchar;
begin
  S := S+#0;
  result:=StrPCopy(@S[1], S) ;
end;
{------------------------------------------------------------------------------}
Procedure Restart_Program;
 var
   FullProgPath: PChar;
begin
  FullProgPath := PChar(Application.ExeName);
  WinExec(FullProgPath, SW_SHOW);
  Application.Terminate;
end;
{------------------------------------------------------------------------------}
procedure SaveLoadFormParam(form1 : Tform; Patch : string; Loading : boolean);
var f : TiniFile;
begin
if Loading=false then
   begin
    f:=TiniFile.Create(patch);
    f.WriteInteger('Form','Width',Form1.Width);
    f.WriteInteger('Form','Height',Form1.Height);
    f.WriteInteger('Form','Left',Form1.Left);
    f.WriteInteger('Form','Top',Form1.Top);
    f.Free;
   end
else
   begin
    f:=TiniFile.Create(patch);
    Form1.Width:=f.ReadInteger('Form','Width',Form1.Width);
    Form1.Height:=f.ReadInteger('Form','Height',Form1.Height);
    Form1.Left:=f.ReadInteger('Form','Left',Form1.Left);
    Form1.Top:=f.ReadInteger('Form','Top',Form1.Top);
    f.Free;
   end;
end;
{------------------------------------------------------------------------------}
function ApplicationPath: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
end.
 