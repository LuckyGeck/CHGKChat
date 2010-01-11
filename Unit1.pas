unit Unit1;

interface

uses
  Windows, Messages, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  Menus,  SysUtils, Classes, IdFTP,
  IdLogEvent, IdFTPCommon, IdFTPList, FileCtrl,inifiles, hkdunit1, //XPMan,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, Buttons,
  MPlayer, IdAntiFreezeBase, IdAntiFreeze,RichEdit, ImgList, RxRichEd,jpeg,  mmsystem;

 type
   TEditStreamCallBack = function(dwCookie: Longint; pbBuff: PByte;
     cb: Longint; var pcb: Longint): DWORD;
   stdcall;

   TEditStream = record
     dwCookie: Longint;
     dwError: Longint;
     pfnCallback: TEditStreamCallBack;
   end;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    Edit2: TEdit;
    Button4: TButton;
    MediaPlayer1: TMediaPlayer;
    Button7: TButton;
    ListView1: TListView;
    Button9: TButton;
    IdFTP1: TIdFTP;
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    N9: TMenuItem;
    IdAntiFreeze1: TIdAntiFreeze;
    ImageList1: TImageList;
    RichEdit2: TRxRichEdit;
    Timer2: TTimer;
    Timer3: TTimer;
    Image1: TImage;
    ComboBox2: TComboBox;
    Edit3: TEdit;
    Edit1: TEdit;
    RichEdit1: TRxRichEdit;
    Button5: TBitBtn;
    Button1: TButton;
    Button6: TButton;
    Button3: TButton;
    Button8: TButton;
    BitBtn1: TSpeedButton;
    SpeedButton1: TSpeedButton;
    ComboBox1: TComboBox;
    ProgressBar1: TProgressBar;
    Button2: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Create_(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Show_(Sender: TObject);
    procedure Close_(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Disconnected_(Sender: TObject);
    procedure Resize_(Sender: TObject);
    procedure EnterPress(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Hint_3(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Hint2(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure F5FORRICH(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DCLICKclear(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ChangeEdit(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure RE_MouseUp_NICK(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure E3click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure Hint6(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure N9Click(Sender: TObject);
    procedure SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Button9Click(Sender: TObject);
    procedure Paint_(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Hint4(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Timer2Timer(Sender: TObject);
    procedure SelectCB2(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  private
    { Private declarations }
    AbortTransfer: Boolean;
    TransferrignData: Boolean;
    BytesToTransfer: LongWord;
    STime: TDateTime;
  public
    { Public declarations }
  end;

procedure PutRTFSelection(RichEdit: TRxRichEdit; SourceStream: TStream);
function Get_Priv(const str:string):string;
function Get_Priv_Nick(const str:string):string;
function Get_Priv_MyNick(const str:string):string;
Procedure Re_SL(var s: TstringList;overwind:boolean);
procedure reColor(RE:TrxrichEdit);
procedure RE_ColorLine(ARichEdit: TRxRichEdit; ARow: Integer; AColor: TColor);
var
  Form1: TForm1;
  I,obnov:integer;
  bool,Press, ob:boolean;
  col: array[0..9] of Tcolor;
  FormCaption : string;
  PRIV : string;

implementation

uses Unit2, Unit3, Unit4, Unit6, Unit8, Unit9;

{$R *.dfm}
{$R .\DATA\SMILEY.RES}
var AverageSpeed: Double=0;

procedure PutRTFSelection(RichEdit: TRxRichEdit; SourceStream: TStream);
 var
   EditStream: TEditStream;
 begin
   with EditStream do
   begin
     dwCookie := Longint(SourceStream);
     dwError := 0;
     pfnCallback := EditStreamInCallBack;
   end;
   RichEdit.Perform(EM_STREAMIN, SF_RTF or SFF_SELECTION, Longint(@EditStream));
 end;

function Get_Priv_MyNick(const str:string):string;
var str2:string;
    i1,i2:integer;
begin
 str2:=str;
 i1:=fansipos('{',str2,1)+6;
 i2:=fansipos('=>',str2,1);
 result:='';
 if (i1<>0) and (i2<>0) then
   begin
     delete(str2,1,i1);
     i2:=fansipos('=>',str2,1)-2;
     str2:=copy(str2,1,i2);
     result:=str2;
   end;
end;

function Get_Priv_Nick(const str:string):string;
var str2:string;
    i1,i2:integer;
begin
 str2:=str;
 i1:=fansipos(' => ',str2,1)+3;
 i2:=fansipos('} ->',str2,1);
 result:='';
 if (i1<>0) and (i2<>0) then
   begin
     delete(str2,1,i1);
     i2:=fansipos('} ->',str2,1)-1;
     str2:=copy(str2,1,i2);
     result:=str2;
   end;
end;

function Get_Priv(const str:string):string;
var j,i1,i2:integer;
    str2:string;
begin
  Result:='';
  str2:=str;
  i1:=fansipos(' -> ',str2,1)+3;
  i2:=fansipos(', ',str2,10);
  if (i1<>0) and (i2<>0) then
   begin
    delete(str2,1,i1);
    i2:=fansipos(', ',str2,1);
    str2:=copy(str2,1,i2);
    get_priv:=str2;
    result:=str2;
   end;    
end;

procedure Get_Nic(const s:TstringList;var nick : TstringList);
var i,i1,i2,i3,j,r: integer;
    str,n:string;
    bol:boolean;
    number : TstringList;
begin
Bol:=false;
number:=TstringList.Create;
nick.Clear; 
for i:=0 to s.Count-1 do
begin
  i1:=0;i2:=0;
  str:=s.Strings[i];
  i1:=fansiPos('] ',str,1);
  i2:=fansiPos(' -> ',str,1)-11;
  if i2=0 then else begin
  if i1=0 then
            begin
            i1:=fansiPos(') ',str,1);
            i2:=fansiPos(' -> ',str,1)-9;
            end;
                    end;
  if (i1=0) or (i2=0) then else
  begin
   n := Copy(str, i1+2 , i2 );
   for j:=0 to Nick.Count-1 do
   begin
    if n=Nick.Strings[j] then Bol:=true;
   end;
   if (nick.Find(n,i3)<>true) and (n<>form1.Edit2.Text) and (bol<>true) then nick.Add(n);
   Bol:=false;
  end;
end;    
end;

Procedure Re_SL(var s: TstringList;overwind:boolean);
var s2:TstringList;
    i,sCount: integer;
begin
s2:=TstringList.Create;
sCount:=s.Count;
if overwind=true then
begin
 for i:=0 to s.Count-1 do
 begin
   sCount:=sCount-1;
   s2.Add(s.Strings[sCount]);
 end;
s.Assign(s2);
s2.Free;
end
else if overwind=false then
begin
 for i:=0 to s.Count-1 do
 begin
   sCount:=sCount-1;
   s2.Add(s.Strings[sCount]);
 end;
s.Assign(s2);
s2.Free;
end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
 f : Tinifile;
begin
f:=tIniFile.Create('twain32m.dll');
Form5.Show;Form5.Update; 
if checkfile('.\data\news.hkd')=0 then deletefile('.\data\news.hkd');
 Button1.Enabled:=false;
 if IdFTP1.Connected
 then
  try
   if TransferrignData
   then IdFTP1.Abort;
   IdFTP1.Quit;
  finally
  Statusbar1.Panels.Items[0].Text:=' не соединён';
  StatusBar1.Refresh;
   Button1.Caption:='Connect';
   Button1.Enabled:=true;
   Button2.Enabled:=false;
   Button3.Enabled:=false;
   Button8.Enabled:=false;
   Button1.Default:=true;
   Timer1.Enabled:=false;
   n6.Enabled:=false;
  end
else
  with IdFTP1 do try
  Statusbar1.Panels.Items[1].Text:=' подключение к серверу';
  StatusBar1.Refresh;
   Username:='anonymous';
   Password:='1';
   Host:='game.issr.ru';
   Connect;
   ListView1.Clear;
       Statusbar1.Panels.Items[1].Text:=' вход в каталог';
       StatusBar1.Refresh;
    if f.ReadBool('Options','Chat',true)=true then
    IdFTP1.ChangeDir('/upload/1. Soft от H.K.D/Soft/data')
    else IdFTP1.ChangeDir('/upload/jek/1/2/');
    IdFTP1.TransferType:=ftBinary;
        Button3Click(Sender); 
    Timer1.Enabled:=true;
    i:=0;
  finally
   Button1.Enabled:=true;
   Button2.Enabled:=true;
   Button3.Enabled:=true;
   Button8.Enabled:=true;
   n6.Enabled:=true;
   form5.Hide;
   if Connected
   then
    begin
     Statusbar1.Panels.Items[0].Text:=' соединён';
     Statusbar1.Panels.Items[1].Text:='';
     StatusBar1.Refresh;
     Button1.Caption:='Disconnect';
     Button1.Default:=false;
     form5.Close;
    end;
  end;
form5.Close;
f.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
var t,tt, nic,s : string;
    j2,i1,size,q,w:integer;
    col: integer;
    dob : boolean;
    sl:TstringList;

begin
ProgressBar1.Position:=0;
if ob=true then
           Showmessage('Идёт обновление...');
Form1.Caption:=FormCaption;
sl:=TstringList.Create;
If Edit2.Text='Логин' then Showmessage('Введите СВОЙ логин')
else if Edit2.Text='' then Showmessage('Зарегистрируйте свой ник')
else if Edit1.Text='' then Showmessage('Прежде чем добавить нужно ввести сообщение!')
else
begin
if (Edit3.Text='Всем') or (Edit3.Text='') then nic:=''
                     else nic:=Edit3.Text+', ';
if timetostr(Time)[2]=':' then
                          tt:=copy(timetostr(Time),0,4)+' '
else tt:=copy(timetostr(Time),0,5);
if ComboBox1.Text='Белый' then col:=0;
if ComboBox1.Text='Жёлтый' then col:=1;
if ComboBox1.Text='Светло зелёный' then col:=2;
if ComboBox1.Text='Голубой' then col:=3;
if ComboBox1.Text='Светло голубой' then col:=4;
if ComboBox1.Text='Зелёный' then col:=5;
if ComboBox1.Text='Оливковый' then col:=6;
if ComboBox1.Text='Сиреневый' then col:=7;
if ComboBox1.Text='Зелёный 2' then col:=8;
if ComboBox1.Text='Красный' then col:=9;
ProgressBar1.Position:=5;
  Statusbar1.Panels.Items[1].Text:=' ...добавление...';
  StatusBar1.Refresh;
w:=0;
i:=0;
if IsFileInUse('.\data\chat.hkd')=false then begin
Button2.Enabled:=false;
size:=GetFileSize('.\data\chat.hkd');
IdFTP1.Get('chat.hkd', '.\data\chat.hkd', true);
if GetFileSize('.\data\chat.hkd')<size then
 begin
 delay(1000);
 IdFTP1.Get('chat.hkd', '.\data\chat.hkd', true);
 end;
sl.LoadFromFile('.\data\chat.hkd'); 
ProgressBar1.Position:=10;
    if sl.Count>35 then
     begin
      for j2:=0 to sl.Count-1 do
       begin
        if sl.Count>35 then
                    sl.Delete(0)
                                    else Break;
       end;
     end;
ProgressBar1.Position:=20;
if ComboBox2.Text='Приват'
then begin 
sl.Add('['+tt+' '+inttostr(col)+'] '+Edit2.Text+' -> '+nic+edit1.Text);
ProgressBar1.Position:=30;
Re_SL(sl,true);ProgressBar1.Position:=40;
RichEdit2.Lines.Assign(sl);
Re_SL(sl,false);ProgressBar1.Position:=50;
sl.SaveToFile('.\data\chat.hkd');ProgressBar1.Position:=60;StatusBar1.Refresh;
reColor(richEdit2);ProgressBar1.Position:=70;
RichEdit2.Lines.SaveToFile('.\data\_.~tmp');ProgressBar1.Position:=75;StatusBar1.Refresh;
RichEdit1.Lines.LoadFromFile('.\data\_.~tmp');ProgressBar1.Position:=70;
sl.Free;ProgressBar1.Position:=80;  StatusBar1.Refresh;
IdFTP1.Put('.\data\chat.hkd','chat.hkd');ProgressBar1.Position:=90;   StatusBar1.Refresh;
s:=Edit1.Text;
  Statusbar1.Panels.Items[1].Text:='';
  StatusBar1.Refresh;
ProgressBar1.Position:=100; StatusBar1.Refresh;
if bool=true then Edit1.Clear;   end
 else begin
        ProgressBar1.Position:=10;
        sl.Add('{'+tt+' '+Edit2.Text+' => '+Combobox2.Text+'} -> '+edit1.Text);
        Re_SL(sl,true); ProgressBar1.Position:=20; StatusBar1.Refresh;
        RichEdit2.Lines.Assign(sl);
        Re_SL(sl,false);        ProgressBar1.Position:=30; StatusBar1.Refresh;
        sl.SaveToFile('.\data\chat.hkd');ProgressBar1.Position:=50;StatusBar1.Refresh;
        reColor(richEdit2);ProgressBar1.Position:=60;StatusBar1.Refresh;
        RichEdit2.Lines.SaveToFile('.\data\_.~tmp');ProgressBar1.Position:=70; StatusBar1.Refresh;
        RichEdit1.Lines.LoadFromFile('.\data\_.~tmp');ProgressBar1.Position:=80;
        sl.Free;
        IdFTP1.Put('.\data\chat.hkd','chat.hkd');ProgressBar1.Position:=90; StatusBar1.Refresh;
        s:=Edit1.Text;
        Statusbar1.Panels.Items[1].Text:='';ProgressBar1.Position:=100;
        StatusBar1.Refresh;
        if bool=true then Edit1.Clear;
      end;
Button2.Enabled:=true;
 end
  else begin
     //
  end;
end;
ProgressBar1.Position:=0;
end;

procedure TForm1.Button3Click(Sender: TObject);
var j,j2,PR: integer; s,s2,nick, priva: TstringList; f : TInifile;
begin
ob:=false;
priva:=TStringList.Create;
f:=Tinifile.Create('twain32m.dll');
i:=0;
j2:=0;
nick:=TstringList.Create;
s:=TstringList.Create;
s2:=TstringList.Create;
if IsFileInUse('.\data\chat.hkd')=false then
begin
 ob:=true;
   Statusbar1.Panels.Items[1].Text:=' ...обновление...';
   StatusBar1.Refresh;
 s2.LoadFromFile('.\data\chat.hkd');
 IdFTP1.Get('chat.hkd', '.\data\chat.hkd',true);
 s.LoadFromFile('.\data\chat.hkd');
 if (s2.Count>2) and (s.Count>1) then begin
 if s.Count>3 then begin
 for j:=0 to s.Count-2 do
  begin
  if (s.Strings[j]=s2.Strings[s2.Count-1]) then
                          begin
                         if f.ReadBool('Sound','New',true)=true then
                         PlaySound(PChar('SYSTEMASTERISK'), 0, SND_ASYNC);
                         Form1.Caption:=FormCaption+' Появились новые сообщения: '+inttostr(s.Count-j-1);
                         break;
                         end
                        else
                         Form1.Caption:=FormCaption;
  end;
  end;
  end;
 Get_Nic(s,nick);
 ListView1.Items.Clear;
 ComboBox2.Items.Clear;
 Combobox2.Items.Add('Приват');
 ComboBox2.ItemIndex:=0;
 for j:=0 to nick.Count-1 do
  begin
   if (nick.Strings[j]<>'') and (nick.Strings[j]<>' ') then
    begin
     ListView1.Items.Add.Caption:=nick.Strings[j];
     ComboBox2.Items.Add(nick.Strings[j])
    end;
  end;
 PR:=100;
 priva.Assign(Combobox2.Items);
 for j:=0 to Priva.Count-1 do
  begin
  if (Priva.Strings[j]=priv) and (Priva.Strings[j]<>'') then PR:=j;
  end;
 if PR<>100 then Combobox2.ItemIndex:=PR;
 Re_SL(s,true);
 RichEdit2.Lines.Assign(s);
 reColor(richEdit2);
 RichEdit2.Lines.SaveToFile('.\data\_.~tmp');
 RichEdit1.Lines.LoadFromFile('.\data\_.~tmp');
  Statusbar1.Panels.Items[1].Text:='';
  StatusBar1.Refresh;
  ob:=false;  
end;
s.Free;
s2.Free;
nick.Free;
f.Free;
end;

procedure TForm1.Create_(Sender: TObject);
var f: Tinifile;
    i:integer;
    s:string;
begin    
Form1.Left:=round(Screen.Width/2-form1.Width/2);
Form1.Top:=round(Screen.Height/2-form1.Height/2);
 f:=tIniFile.Create('twain32m.dll');
 Form1.Width:=f.ReadInteger('Size','Width',0);
 Form1.Height:=f.ReadInteger('Size','Height',0);
 Form1.Top:=f.ReadInteger('Size','Top',0);
 Form1.Left:=f.ReadInteger('Size','Left',0);
 obnov:=f.Readinteger('Options','Auto', 15);
 s:=f.ReadString('Other','Name',s);
 code(s,'zncjr025632445551522335540000',true);
 edit2.Text:=s;
 bool:=f.ReadBool('Options','App',false);
 f.Free;
i:=0;
  with ProgressBar1 do
  begin
    Parent := StatusBar1;
    Position := 0;
    Top := 2;
    Left := 206;
    Height := StatusBar1.Height - Top;
    Width := 100//StatusBar1.Panels[0].Width - Left;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
RichEdit1.Lines.Clear;
Richedit1.Lines.SaveToFile('.\data\chat.hkd');
IdFTP1.Put('.\data\chat.hkd','chat.hkd');
DeleteFile('.\data\chat.hkd');
end;

procedure TForm1.Show_(Sender: TObject);
var f : Tinifile; s:string;
begin
Gradient(Image1.Canvas,clBlack,clWhite,true);   
col[0]:=clWhite;
col[1]:=clYellow;
col[2]:=clLime;
col[3]:=clBlue;
col[4]:=clSkyBlue;
col[5]:=clGreen;
col[6]:=clOlive;
col[7]:=clFuchsia;
col[8]:=clTeal;
col[9]:=clRed;
f:=tIniFile.Create('twain32m.dll');
ComboBox1.ItemIndex:=f.ReadInteger('Color','Text',0);
if f.ReadBool('Options','Color',false)=false then
Begin
col[0]:=clBlack;
col[1]:=clBlack;
col[2]:=clBlack;
col[3]:=clBlue;
col[4]:=clBlack;
col[5]:=clGreen;
col[6]:=clBlack;
col[7]:=clFuchsia;
col[8]:=clTeal;
col[9]:=clRed;
end;
 if f.ReadBool('Options','Color',false)=true then RichEdit1.Color:=clBlack else
                                            Begin
                                            if f.ReadBool('Options','FontColor',true)=true then
                                            begin
                                              col[0]:=clBlack;
                                              col[1]:=clBlack;
                                              col[2]:=clBlack;
                                              col[3]:=clBlack;
                                              col[4]:=clBlack;
                                              col[5]:=clBlack;
                                              col[6]:=clBlack;
                                              col[7]:=clBlack;
                                              col[8]:=clBlack;
                                              col[9]:=clBlack;
                                            end;
                                            Combobox1.Color:=clWhite;
                                            ComboBox1.Font.Color:=clBlack;
                                            RichEdit1.Color:=clWhite;
                                            RichEdit1.Font.Color:=clBlack;
                                            ListView1.Color:=clWhite;
                                            ListView1.Font.Color:=clNavy;
                                            end;
if f.ReadString('Other','Name','Логин')='Логин' then
                                                begin
                                                ShowMessage('Зарегистрируйтесь!');
                                                Button1.Visible:=false;
                                                Form9.show;
                                                end
else
 begin
 s:=f.ReadString('Other','Name','Логин');  
 code(s,'zncjr025632445551522335540000',true);
 form1.Caption:=form1.Caption+' ['+s+']';
 formCaption:=form1.Caption;
 end;
if f.ReadBool('Options','Admin',false)=true then Button9.Visible:=true;;
f.Free;
AnimateWindow(Handle, 500, AW_CENTER or AW_SLIDE);
Statusbar1.Panels.Items[0].Text:=' не соединён';
StatusBar1.Refresh;
end;

procedure TForm1.Close_(Sender: TObject; var Action: TCloseAction);
begin
AnimateWindow(handle, 1000, AW_BLEND or AW_HIDE);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
i:=i+1;      
if i=obnov then
begin
 i:=0;
 Button3Click(Sender);  
end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TForm1.Disconnected_(Sender: TObject);
begin
Statusbar1.Panels.Items[0].Text:=' не соединён';
   Button1.Caption:='Connect';
   Button2.Enabled:=false;
   Button3.Enabled:=false;
   Button8.Enabled:=false;
   Timer1.Enabled:=false;
   n6.Enabled:=false;
end;

procedure TForm1.Resize_(Sender: TObject);
var x,y:real;
begin
x:=642-form1.Width;
y:=451-form1.Height;
Button5.Left:=round(552-x);
Edit2.Left:=round(472-x);
Button2.Left:=round(552-x);
Button2.Top:=round(351-y);
Edit1.Width:=round(345-x);
Edit1.Top:=round(353-y);
Edit3.Top:=round(353-y);
RichEdit1.Width:=round(497-x);
RichEdit2.Width:=round(497-x);  
RichEdit1.Height:=round(309-y);
Listview1.Left:=round(512-x);
ListView1.Height:=round(309-y);
Combobox2.Top:=round(353-y);
Image1.Width:=round(633-x);
Image1.Height:=round(401-y);
//Gradient(Image1.Canvas,clBlack,clWhite,true);
end;

procedure TForm1.EnterPress(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if button2.Enabled=true then
begin
  case Key of
     VK_F5 : Button3Click(sender);
  end;
if  GetAsyncKeyState(VK_RETURN) <> 0 then
 BUTTON2cLICK(SENDER);
end;
end;

procedure TForm1.Hint_3(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
Button3.Hint:='F5';
Button3.ShowHint:=true;
end;    
procedure TForm1.Hint2(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
Button2.Hint:='Enter';
Button2.ShowHint:=true;
end;
procedure TForm1.Hint4(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
SpeedButton1.Hint:='Коды смайлов';
SpeedButton1.ShowHint:=true;
end;

procedure TForm1.KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Button3.Enabled=true then
 begin
  case Key of
     VK_F5 : Button3Click(sender);
  end;
 end;
end;

procedure TForm1.F5FORRICH(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Button3.Enabled=true then
 begin
  case Key of
     VK_F5 : Button3Click(sender);
  end;
 end;
end;

procedure TForm1.DCLICKclear(Sender: TObject);
begin
Edit1.Clear;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
Form2.Show;
tIMER1.Enabled:=false;
end;

procedure TForm1.ChangeEdit(Sender: TObject);
begin
i:=0;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
Close;
end;


procedure TForm1.N4Click(Sender: TObject);
begin
MediaPlayer1.Close;
MediaPlayer1.FileName:='.\data\sound1.mid';
MediaPlayer1.Open;
MediaPlayer1.Play;
programmer.Show;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
Form5.Show;Form5.Update;
Button3.Visible:=false;
Button2.Visible:=false;
Button6.Visible:=true;
Button7.Visible:=true;
Edit1.Visible:=false;
Timer1.Enabled:=false;
IdFTP1.Get('news.hkd', '.\data\news.hkd',true);
RichEdit1.Lines.LoadFromFile('.\data\news.hkd');
DeleteFile('.\data\news.hkd');
form5.Close;
end;
procedure TForm1.Button6Click(Sender: TObject);
begin
Button8.Visible:=true;
Form5.Show;Form5.Update;
Button7.Visible:=false;
Button6.Visible:=false;
Button3.Visible:=true;
Button2.Visible:=true;
Edit1.Visible:=true;
Timer1.Enabled:=true;
Button3Click(sender);
Form5.Close;
reColor(richEdit1);
end;
procedure TForm1.Button7Click(Sender: TObject);
begin
Form6.Show;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
if IsFileInUse('.\data\chat.hkd')=false then begin
  Statusbar1.Panels.Items[1].Text:='...объявления...';
  StatusBar1.Refresh;
n6Click(sender);
Button8.Visible:=false;
  Statusbar1.Panels.Items[1].Text:='';
  StatusBar1.Refresh;
end;
end;

procedure TForm1.RE_MouseUp_NICK(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var s : string;
    i : integer;
begin
{s:=Edit3.Text;
Edit3.Text:=RichEdit1.SelText;
if Length(edit3.Text)>15 then
   Edit3.Text:=Copy(edit3.Text,0,15)+'...';
if Edit3.Text='' then Edit3.Text:=s;
i:=Length(Edit3.Text);   }
end;

procedure RE_ColorLine(ARichEdit: TRxRichEdit; ARow: Integer; AColor: TColor);
var str,str2:string; i1,i2,i3:integer;
SS: TStringStream;
ResStream: TResourceStream;
MyBMP: TBITMAP;
begin
   with ARichEdit do
   begin
     str:=ARichEdit.Lines.Strings[Arow-1];
     str2:=ARichEdit.Lines.Strings[Arow-1];
i3:=1;
if Length(str2)>1 then
                  begin
                  if str2[1]='(' then i3:=10;
                  end;
{-------------------Смайлы-----------------}
{:)}
if fAnsiPos(':)',str2,1)>0 then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos(':)',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY1', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{:(}
if fAnsiPos(':(',str2,1)>0 then
      begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos(':(',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY2', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
   end;
{smoke}
if fAnsiPos('smoke',str2,1)>0 then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('smoke',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY3', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{bad}
if fAnsiPos('bad',str2,1)>0 then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('bad',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY4', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{good}
if fAnsiPos('good',str2,1)>0 then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('good',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY5', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{:Р}
if (fAnsiPos(':P',str2,1)>0) or (fAnsiPos(':Р',str2,1)>0)  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos(':P',str2,1)+fAnsiPos(':Р',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY6', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{question}
if fAnsiPos('question',str2,1)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('question',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY8', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{love}
if fAnsiPos('love',str2,1)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('love',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY7', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{attention}
if fAnsiPos('attent',str2,1)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('attent',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY9', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{):}
if fAnsiPos('):',str2,1)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('):',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY10', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{bay}
if fAnsiPos('bay',str2,1)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('bay',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY11', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{8)}
if fAnsiPos('8)',str2,i3)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('8)',str2,i3)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY12', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{;)}
if fAnsiPos(';)',str2,1)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos(';)',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY13', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{help}
if fAnsiPos('help',str2,1)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('help',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY14', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{nobody}
if fAnsiPos('nobody',str2,1)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('nobody',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY15', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{beer}
if fAnsiPos('beer',str2,1)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('beer',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY16', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{cold}
if fAnsiPos('cold',str2,1)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('cold',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY17', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{dead}
if fAnsiPos('dead',str2,1)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('dead',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY18', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{class}
if fAnsiPos('class',str2,1)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('class',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY19', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{walk}
if fAnsiPos('walk',str2,1)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('walk',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY20', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{p.s.}
if fAnsiPos('p.s.',str2,1)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('p.s.',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY21', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{exit}
if fAnsiPos('exit',str2,1)>0  then
    begin
      MyBMP := TBitMap.Create;
      SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+fAnsiPos('exit',str2,1)-1;
      ResStream := TResourceStream.Create(HInstance, 'SMILEY22', RT_RCDATA);
      MyBMP.LoadFromStream(ResStream);
      SS  := TStringStream.Create(BitmapToRTF(MyBMP));
      PutRTFSelection(ARichEdit,ss);
      MyBmp.Free;
    end;
{-------------------Смайлы-----------------}
     i1:=fansiPos('] ',str,1);
     i2:=fansiPos(' -> ',str,1)-9;
     if i2=0 then else begin
     if i1=0 then
            begin
            i1:=fansiPos(') ',str,1);
            i2:=fansiPos(' -> ',str,1)-9;
            end;
                    end;
      if (i1=0) or (i2=0) then else
    begin
     SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0)+i1+1;
     SelLength :=i2-i1+7;
     //fsBold, fsItalic, fsUnderline, fsStrikeOut
     SelAttributes.Style:=[fsItalic]+[fsUnderline]+[fsBold];
     SelLength := 0;
   end;
     if Get_Priv(Lines[Arow-1])=Form1.Edit2.Text+',' then
       begin
           SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0);
           SelLength := Length(Lines[ARow - 1]);
           SelAttributes.BackColor:=$00FEE7CF;  
           //SelAttributes.Size:=9;
           SelLength := 0;
       end;
     SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0);
     SelLength := Length(Lines[ARow - 1]);
     SelAttributes.Color := AColor;
     SelLength := 0;
     if length(Lines[Arow-1])>1 then begin
     if Lines[Arow-1][1]='{' then
      begin
       if (Get_Priv_Nick(Lines[Arow-1])=Form1.Edit2.Text) or (Get_Priv_MyNick(Lines[Arow-1])=Form1.Edit2.Text)
        then begin
              SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0);
              SelLength := Length(Lines[ARow - 1]);
              SelAttributes.BackColor:=$00E0E2E2;
              SelAttributes.Color:=clBlack;
              SelAttributes.Style:=[fsBold];
              SelLength := 0;
             end
        else Lines[ARow - 1]:='';
      end;
                                      end;
end;
end;

procedure reColor(RE:TrxrichEdit);
var i,j:integer;
    s,s2,s3:string;
    str:string;
begin
j:=0;
for i:=0 to RE.Lines.Count do
begin
  s:=RE.Lines.Strings[i];
  if length(s)>7 then
                 s2:=s[8];
  if (s2='0') or (s2='1') or (s2='2') or (s2='3') or (s2='4') or (s2='5') or (s2='6') or (s2='7') or (s2='8') or (s2='9') then
   begin
    j:=strtoint(s2);
   end
  else if Length(s)>1 then begin
  if s[1]='(' then j:=0;

  end;
RE_ColorLine(RE,i+1,col[j]);
end;
end;


procedure TForm1.E3click(Sender: TObject);
begin
Edit3.Text:='Всем';
end;


procedure TForm1.N7Click(Sender: TObject);
begin
Form2.Show;
end;

procedure TForm1.Hint6(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
BitBtn1.Hint:='Настройки';
bitbtn1.ShowHint:=true;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
Form8.Show;
end;



procedure TForm1.SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
Edit3.Text:=Item.Caption;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
RichEdit1.Lines.Clear;
RichEdit1.PlainText:=true;
RichEdit1.Lines.SaveToFile('.\data\chat.hkd');
RichEdit1.PlainText:=false;
IdFTP1.Put('.\data\chat.hkd','chat.hkd');
end;

procedure TForm1.Paint_(Sender: TObject);
var i: Integer;
begin
{
   ShadeIt(Self, Button1, 3, clBlack);
   ShadeIt(Self, Button6, 3, clBlack);
   ShadeIt(Self, Button1, 3, clBlack);
   ShadeIt(Self, Button8, 3, clBlack);
   ShadeIt(Self, BitBtn1, 3, clBlack);
   ShadeIt(Self, Button3, 3, clBlack);
   ShadeIt(Self, Button5, 2, clBlack);
   ShadeIt(self, Button1, 3, clBlack);
   ShadeIt(Self, Button2, 2, clBlack);
   ShadeIt(Self, Button7, 3, clBlack);
   ShadeIt(Self, Edit1, 3, clBlack);
   ShadeIt(Self, Edit3, 3, clBlack);
   ShadeIt(Self, Combobox1, 3, clBlack);
   ShadeIt(Self, Combobox2, 3, clBlack);
   ShadeIt(Self, speedButton1, 3, clBlack);}
end;


procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
RichEdit1.Lines.Clear;
RichEdit1.Lines.Add('Коды смайлов. (для выхода нажмите Обновить/Connect) ');
RichEdit1.Lines.Add(':)');
RichEdit1.Lines.Add('8)');
RichEdit1.Lines.Add(';)');
RichEdit1.Lines.Add(':(');
RichEdit1.Lines.Add(':P');
RichEdit1.Lines.Add('):');
RichEdit1.Lines.Add('smoke');
RichEdit1.Lines.Add('love');
RichEdit1.Lines.Add('attent');
RichEdit1.Lines.Add('question');
RichEdit1.Lines.Add('good');
RichEdit1.Lines.Add('bad');
RichEdit1.Lines.Add('exit');
RichEdit1.Lines.Add('help');
RichEdit1.Lines.Add('nobody');
RichEdit1.Lines.Add('bay');
RichEdit1.Lines.Add('beer');
RichEdit1.Lines.Add('walk');
RichEdit1.Lines.Add('class');
RichEdit1.Lines.Add('cold');
RichEdit1.Lines.Add('dead');
RichEdit1.Lines.Add('p.s.');
reColor(richEdit1);
i:=0;
end;



procedure TForm1.Timer2Timer(Sender: TObject);
var f: Tinifile;
begin 
f:= TIniFile.Create('twain32m.dll');  
f.WriteInteger('Size','Width',Form1.Width);
f.WriteInteger('Size','Height',Form1.Height);
f.WriteInteger('Size','Top',form1.Top);
f.WriteInteger('Color','Text',ComboBox1.ItemIndex);
f.Free;
end;

procedure TForm1.SelectCB2(Sender: TObject);
begin
PRIV:=Combobox2.Text;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin 
if Combobox2.Text<>'Приват' then begin
  Statusbar1.Panels.Items[3].Text:=' Включён приват с '+Combobox2.Text+' /остальные не смогут прочитать о чём вы говорите/';
  StatusBar1.Refresh;
  end
else Statusbar1.Panels.Items[3].Text:='';

end;


end.
