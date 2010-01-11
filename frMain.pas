unit frMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdCoder, IdCoder3to4, IdCoderMIME, IdBaseComponent,
  IdComponent, IdTCPServer, IdIPWatch, XPMan, IdTCPConnection, IdTCPClient,
  IdHTTP, frEditor, ComCtrls, Grids, RxRichEd, Buttons, ExtCtrls, Menus,
  IdAntiFreezeBase, IdAntiFreeze, HKDUnit1, Wait, MMSystem;

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
    server: TIdTCPServer;
    b64en: TIdEncoderMIME;
    b64de: TIdDecoderMIME;
    http: TIdHTTP;
    XPManifest1: TXPManifest;
    od: TOpenDialog;
    sd: TSaveDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    GroupBox2: TGroupBox;
    Button6: TButton;
    GroupBox3: TGroupBox;
    Button1: TButton;
    Button3: TButton;
    Label2: TLabel;
    Edit2: TEdit;
    Edit1: TEdit;
    Label1: TLabel;
    GroupBox4: TGroupBox;
    Edit3: TEdit;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Button4: TButton;
    Button5: TButton;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    ComInfo: TStringGrid;
    GroupBox7: TGroupBox;
    FullResult: TStringGrid;
    memo2: TRxRichEdit;
    Button7: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Memo3: TMemo;
    Timer1: TTimer;
    Panel1: TPanel;
    Timer2: TTimer;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    GroupBox8: TGroupBox;
    ListBox1: TListBox;
    Label3: TLabel;
    Edit4: TEdit;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Button8: TButton;
    Button9: TButton;
    PopupMenu2: TPopupMenu;
    kick1: TMenuItem;
    N4: TMenuItem;
    Dcnfdbnm1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    IdAntiFreeze1: TIdAntiFreeze;
    Wait1: TWait;
    N7: TMenuItem;
    onemsc: TTimer;
    PrivateMsg1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ReDrawGreed;
    procedure ReDrawComInfo;
    procedure ReDrawUsersList;
    procedure BlockQuestions;
    procedure UnBlockQuestions;
    procedure DoAnswers;
    procedure FullResultMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure serverLoginCommand(ASender: TIdCommand);
    procedure serverreadyCommand(ASender: TIdCommand);
    procedure ComInfoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure serverDisconnect(AThread: TIdPeerThread);
    procedure servermsg_sendCommand(ASender: TIdCommand);
    procedure serverstart_gameCommand(ASender: TIdCommand);
    procedure Button6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ReDrawQuestion(i: integer);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure serverans_sendCommand(ASender: TIdCommand);
    procedure Timer2Timer(Sender: TObject);
    procedure serverusr_listCommand(ASender: TIdCommand);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure serverConnect(AThread: TIdPeerThread);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure kick1Click(Sender: TObject);
    procedure Dcnfdbnm1Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure serverresultsCommand(ASender: TIdCommand);
    procedure Wait1Timeout(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure onemscTimer(Sender: TObject);
    procedure PrivateMsg1Click(Sender: TObject);
    procedure serverprivateCommand(ASender: TIdCommand);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure KickUser(name: string);
    procedure FillDbInfo;
    procedure PublishMsg(name, say: string; time: TDateTime);
    procedure PrivateMsg(forwho, name, say: string; time: TDateTime);
    procedure col(ARow: Integer; bcolor: Tcolor; AColor: TColor);
    procedure PutRTFSelection(RichEdit: TRxRichEdit; SourceStream: TStream);
    procedure DrawSmile(smile: string; path: string; ARow: integer);
  end;

const
  host = 'http://www.chgk-online.tu2.ru/';
  url = 'http://www.chgk-online.tu2.ru/set.php';

type
  TClient = class(TObject)
    Name: string;
    Status: string;
    Thread: Pointer;
    answers: Tstringlist;
    p_answers: Tstringlist;
    points: integer;
    dpoints: integer;
    cache: string;
    b: boolean;
  end;

var
  Form1: TForm1;
  questions: TStringList;
  users: TList;
  db: string = '';
  qnum: integer;
  UsersQuestionsSent: integer;
  UsersAnsSent: integer;
  GameOnline: boolean;
  Asked: integer;
  //-------
  onesec_name: string;
  onesec_say: string;
  onesec_time: TDateTime;

procedure SendMCICommand(Cmd: string);

implementation

uses frAnsCheck, RichEdit;

{$R *.dfm}

procedure SendMCICommand(Cmd: string);
var
  RetVal: Integer;
  ErrMsg: array[0..254] of char;
begin
  RetVal := mciSendString(PChar(Cmd), nil, 0, 0);
  if RetVal <> 0 then
  begin
    {get message for returned value}
    mciGetErrorString(RetVal, ErrMsg, 255);
    MessageDlg(StrPas(ErrMsg), mtError, [mbOK], 0);
  end;
end;

procedure TForm1.DrawSmile(smile: string; path: string; ARow: integer);
var
  str2: string;
  SS: TStringStream;
  MyBMP: TBITMAP;
  i: integer;
begin
  smile := trim(smile);
  str2 := memo2.Lines.Strings[Arow];
  with memo2 do
  begin
    if fAnsiPos(smile, str2, 1) > 0 then
    begin
      i := 0;
      while fAnsiPos(smile, str2, 1) > 0 do
      begin
        MyBMP := TBitMap.Create;
        MyBmp.LoadFromFile(ExtractFileDir(Application.ExeName) + '\data\smiles\' + path + '.bmp');
        SS := TStringStream.Create(BitmapToRTF(MyBMP));
        //showmessage(ss.DataString);
    //------------
       // showmessage(inttostr(fAnsiPos(':)', str2, 1)));
        SelStart := SendMessage(memo2.Handle, EM_LINEINDEX, ARow, 0) + fAnsiPos(smile, str2, 1) + i - 1;
        str2 := copy(str2, 0, fAnsiPos(smile, str2, 1) - 1) + copy(str2, fAnsiPos(smile, str2, 1) + length(smile), length(str2));
        i := i + 1;
        SelLength := length(smile);
        SelText := '';
    //------------
        PutRTFSelection(memo2, ss);
        SelLength := 0;
    //------------
        ss.Free;
        MyBmp.Free;
      end;
    end;
  end;
end;

procedure TForm1.PutRTFSelection(RichEdit: TRxRichEdit; SourceStream: TStream);
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

procedure TForm1.KickUser(name: string);
var
  i, k: integer;
begin
  k := -1;
  for i := 0 to users.Count - 1 do
  begin
    if TClient(Users[i]).Name = Name then
    begin
      k := i;
      break;
    end;
  end;
  if k >= 0 then
  begin
    TClient(Users[k]).Status := InputBox('Введите причину', 'Введите причину, по которой вы кикаете человка:', '-');
  end;
  PublishMsg('Admin', TClient(Users[k]).Name + ' was kicked out from game! Reason: "' + TClient(Users[k]).Status + '"', now);
end;

procedure TForm1.DoAnswers;
begin
  if (usersQuestionsSent = Users.Count) and not (wait1.Running) then
  begin
    wait1.Tag := 0;
    wait1.Caption := '70';
    wait1.Start;
  end;
  if (UsersAnsSent >= Users.Count) then
  begin
    //Form3 := TForm3.Create(Application);
    timer2.Enabled := false;
    Form3.RefreshList;
    Form3.ShowModal;
    panel1.Caption := '0/0/0';
    UsersAnsSent := 0;
    UsersQuestionsSent := 0;
    wait1.Caption := '70';
    wait1.Stop;
   // Form3.Free;
   // UnBlockQuestions;
  end;
end;

procedure TForm1.BlockQuestions;
begin
  BitBtn1.Enabled := false;
  BitBtn2.Enabled := false;
  Button7.Enabled := false;
 // Button4.Enabled := false;
  //Button5.Enabled := false;
end;

procedure TForm1.UnBlockQuestions;
begin
  BitBtn1.Enabled := true;
  BitBtn2.Enabled := true;
  Button7.Enabled := true;
 // Button4.Enabled := true;
 // Button5.Enabled := true;
end;

procedure TForm1.ReDrawQuestion(i: integer);
begin
  if questions.Count > i then
  begin
    GroupBox1.Caption := 'Вопрос №' + inttostr(i + 1);
    Memo1.Text := b64de.DecodeString(questions[i]);
    qnum := i;
  end
  else
  begin
    GroupBox1.Caption := 'Вопрос';
    Memo1.Text := '';
  end;
end;

procedure TForm1.ReDrawUsersList;
var
  x: integer;
begin
  ListBox1.Items.Clear;
  for x := Users.Count downto 1 do
  begin
    ListBox1.Items.Add(TClient(Users[x - 1]).Name);
  end;
end;

procedure TForm1.col(ARow: Integer; bcolor: Tcolor; AColor: TColor);
begin
  with memo2 do
  begin
{:)}DrawSmile(':)', 'smile', ARow);
{А}//DrawSmile('А', 'A', ARow);
{Б}//DrawSmile('Б', 'Б', ARow);
  end;

  with (memo2) do
  begin
    SelStart := SendMessage(Handle, EM_LINEINDEX, ARow, 0);
    SelLength := length(Lines[Arow]);
    SelAttributes.BackColor := Bcolor;
    SelAttributes.Color := Acolor;
    SelAttributes.Style := SelAttributes.Style + [fsBold]; //fsBold, fsItalic, fsUnderline, fsStrikeOut
    SelLength := 0;

  {   if length(Lines[Arow-1])>1 then begin
     if Lines[Arow-1][1]='{' then
      begin
       if (Get_Priv_Nick(Lines[Arow-1])=Form1.Edit2.Text) or (Get_Priv_MyNick(Lines[Arow-1])=Form1.Edit2.Text)
        then begin
              SelStart := SendMessage(Handle, EM_LINEINDEX, ARow - 1, 0);
              SelLength := Length(Lines[ARow - 1]);
              Memo1.SelAttributes.BackColor:=$00E0E2E2;
              Memo1.SelAttributes.Color:=clBlack;
              Memo1.SelAttributes.Style:=[fsBold];
              SelLength := 0;
             end   }
  end;
end;

procedure TForm1.PrivateMsg(forwho, name, say: string; time: TDateTime);
var
  s: string;
  i, j: integer;
begin
if trim(say)='' then exit;
  datetimetostring(s, 'd.m.yyyy h:nn:ss', time);
  for i := 0 to users.Count - 1 do
  begin
    if TClient(Users[i]).Name = forwho then
    begin
      if TClient(Users[i]).cache <> '' then
        TClient(Users[i]).cache := TClient(Users[i]).cache + #13;
      TClient(Users[i]).cache := TClient(Users[i]).cache + b64en.Encode(b64en.Encode('<!Private!> ' + name + ' (' + s + '):') + #13 +
        b64en.Encode(say));
    end;
  end;
  if name = 'Admin' then
  begin
    Memo2.Lines.Add(name + ' (' + s + '):');

    I := memo2.Lines.Count;
    Memo2.Lines.Add(say);
    Memo2.Lines.Add('');

    for j := i - 1 to memo2.Lines.Count - 2 do
    begin
      col(j, clMoneyGreen, clBlack);
    end;
    {if name = 'Admin' then }
    col(I - 1, clgreen, clRed);
    //else col(i - 1, clwhite, clRed);
       // memo2.AllowObjects := true;
    Memo2.Perform(WM_VSCROLL, SB_BOTTOM, 0);
  end;
end;

procedure TForm1.PublishMsg(name, say: string; time: TDateTime);
var
  s: string;
  i, j: integer;
//  pict: TBitmap;
begin
if trim(say)='' then exit;
//  pict := TBitmAp.Create;
//  pict.LoadFromFile('O:\1.bmp');
  datetimetostring(s, 'd.m.yyyy h:nn:ss', time);
  for i := 0 to users.Count - 1 do
  begin
    if TClient(Users[i]).Name <> name then
    begin
      if TClient(Users[i]).cache <> '' then
        TClient(Users[i]).cache := TClient(Users[i]).cache + #13;
      TClient(Users[i]).cache := TClient(Users[i]).cache + b64en.Encode(b64en.Encode(name + ' (' + s + '):') + #13 +
        b64en.Encode(say));
    end;
  end;

  Memo2.Lines.Add(name + ' (' + s + '):');

  I := memo2.Lines.Count;
  Memo2.Lines.Add(say);
  Memo2.Lines.Add('');

  for j := i - 1 to memo2.Lines.Count - 2 do
  begin
    col(j, clMoneyGreen, clBlack);
  end;
  if name = 'Admin' then col(I - 1, clgreen, clRed)
  else col(i - 1, clwhite, clRed);


 // memo2.AllowObjects := true;
  Memo2.Perform(WM_VSCROLL, SB_BOTTOM, 0);
 // pict.Free;
end;

procedure TForm1.ReDrawComInfo;
var
  j, x: integer;
begin
  j := Users.Count;
  ComInfo.ColCount := 2;
  ComInfo.RowCount := j + 1;
  with ComInfo do
  begin
    Cells[0, 0] := 'Имя';
    Cells[1, 0] := 'Очки';
    for x := j downto 1 do
    begin
      cells[0, x] := TClient(Users[x - 1]).Name;
      cells[1, x] := inttostr(TClient(Users[x - 1]).points);
//      RoWidths[x] := 20;
    end;
    if j > 0 then ComINfo.FixedRows := 1
    else ComINfo.FixedRows := 0;
  end;
end;

procedure TForm1.ReDrawGreed;
var
  i, j, x, y: integer;
begin
  i := questions.Count;
  j := Users.Count;
  FullResult.ColCount := i + 1;
  FullResult.RowCount := j + 1;
  with FullResult do
  begin
    Cells[0, 0] := 'Имя\№';
    for x := i downto 1 do
    begin
      cells[x, 0] := inttostr(x);
      ColWidths[x] := 20;
    end;
    for y := j downto 1 do
    begin
      cells[0, y] := TClient(Users[y - 1]).Name;
      for x := 1 to TClient(Users[y - 1]).p_answers.Count do
      begin
        cells[x, y] := TClient(Users[y - 1]).p_answers[x - 1];
      end;
    end;
    if j > 0 then FixedRows := 1
    else FixedRows := 0;
  end;
end;

procedure TForm1.FillDbInfo;
begin
  label5.Caption := inttostr(questions.Count);
  Edit3.Text := trim(db);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if server.Active then
  begin
    try
      server.Active := false;
      Button1.Caption := 'Start';
    except
      ShowMessage('Ошибка отключения сервера!' + #13 + 'Пользователи будут недовольны!!! =(');
    end
  end
  else
  begin
    try
      server.DefaultPort := strtoint(Edit1.Text);
      Server.Active := true;
      Button1.Caption := 'Stop';
    except
      ShowMessage('Не могу активировать сервер - проблемы со связью или занят порт!' + #13 + 'P.S. Смените порт в настройках...');
    end;
  end;
  users.Clear;
end;


procedure TForm1.Button3Click(Sender: TObject);
var
  new: string;
begin
  http.Host := host;
  try
    new := http.Get(url + '?port=' + Trim(Edit1.Text));
    new := copy(new, 0, pos('<!', new) - 1);
      {'http://localhost:8080/programlevap.narod/newvers.info'}
    if (new = 'Ошибка1') or (new = 'Ошибка2') then SHowMessage('Сайт не работает или работает неправильно!' + #13 + 'Игра не будет работать!')
    else
    begin
      Edit2.Text := new;
      ShowMessage('Всё ОК! Можно запускать сервер!');
    end;

  except
    showmessage('    Не могу подсоедениться к интернету!' + #13 +
      '=Проверьте своё соединение с Интернетом!!!=');
  end;
  try
    http.Disconnect
  except
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SendMCICommand('open waveaudio shareable');

  UsersQuestionsSent := 0;
  GameOnline := false;
  questions := TStringList.Create;
  users := Tlist.Create;
  qnum := 0;
  asked := 0;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  questions.Free;
  users.Free;

  SendMCICommand('close waveaudio');
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
//  Form2 := TForm2.Create(Application);
  Form2.Show; //Modal;
//  Form2.Free;
{  if asked > questions.Count then
  begin
    asked := 0;
    Form1.Edit4.Text := '0';
  end;    }
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if od.Execute then
  begin
    questions.LoadFromFile(od.FileName);
    db := od.FileName;
    filldbinfo;
    ReDrawQuestion(0);
    if asked > questions.Count then
    begin
      asked := 0;
      Edit4.Text := '0';
    end;
  end;
end;

procedure TForm1.FullResultMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  ReDrawGreed;
end;

procedure TForm1.serverLoginCommand(ASender: TIdCommand);
var
  s: string;
  i: integer;
  b: boolean;
  usr: TClient;
begin
  s := ASender.Params[0];
  s := b64de.DecodeString(s);
  b := true;
  for i := 0 to users.Count - 1 do
  begin
    if TClient(users.Items[i]).Name = s then
      b := false;
  end;
  if b then
  begin
    usr := TClient.Create;
    usr.Name := s;
    usr.answers := TStringList.Create;
    usr.p_answers := TStringList.Create;
    usr.points := 0;
    usr.Thread := ASender.Thread;
    usr.Status := 'OK';
    usr.cache := '';
    usr.b := false; ;
    ASender.Thread.Data := usr;
    users.Add(usr);
    ASender.Response.Clear;
    ASender.Response.Add('OK');
    ASender.Response.Add(b64en.Encode('OK'));
    ASender.SendReply;
  end
  else
  begin
    ASender.Response.Clear;
    ASender.Response.Add('ara');
    ASender.Response.Add(b64en.Encode('ErrorLogin'));
    ASender.SendReply;
 //   ASender.Thread.TerminateAndWaitFor;
  end;

end;


procedure TForm1.serverreadyCommand(ASender: TIdCommand);
var
  s: TStringList;
begin
  s := TStringList.Create;

  //INFO for CLIENT
  s.Add('Сервер v0.07 - "ЧГК Online"');
  s.Add('Пользователей: ' + inttostr(Users.Count));
  s.Add('Вопросов в базе: ' + inttostr(questions.Count));
  s.Add('Вопросов сыграно: ' + inttostr(asked));
  //END;

  ASender.Response.Text := '';
  ASender.Response.Add('ok');
  ASender.Response.Add(b64en.Encode(TClient(ASender.Thread.Data).Status));
  ASender.Response.Add(b64en.Encode(s.Text));
  if TClient(ASender.Thread.Data).cache <> '' then
  begin
    ASender.Response.Add(b64en.Encode(TClient(ASender.Thread.Data).cache));
    TClient(ASender.Thread.Data).cache := '';
  end;
  ASender.SendReply;
  s.Free;
end;

procedure TForm1.ComInfoMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  ReDrawComInfo;
end;

procedure TForm1.serverDisconnect(AThread: TIdPeerThread);
var
  I: integer;
  b: boolean;
begin
  if AThread.Data <> nil then
  begin
    b := false;
    for i := 0 to users.Count - 1 do
    begin
      if TClient(users[i]).Name = TClient(AThread.Data).Name then
      begin
        b := true;
        break;
      end;
    end;
    if b then
    begin
  //  AThread.Data.Free;
      TClient(Users[i]).answers.Free;
      TClient(Users[i]).p_answers.Free;
      users.Delete(i);
    end;
  end;
 // AThread.Stop;
end;

procedure TForm1.servermsg_sendCommand(ASender: TIdCommand);
var
  s: string;
begin
  SendMCICommand('play "' + ExtractFileDir(application.exename) + '\data\sounds\msgGet.wav"');

  s := b64de.DecodeString(ASender.Params[0]);
  ASender.Response.Clear;
  ASender.Response.Add('OK');
  ASender.Response.Add(b64en.Encode('OK'));
  ASender.SendReply;

  onesec_name := TClient(ASender.Thread.Data).Name;
  onesec_say := s;
  onesec_time := now;
  onemsc.Enabled := true;
end;

procedure TForm1.serverstart_gameCommand(ASender: TIdCommand);
begin
  ASender.Response.Text := 'asdf';
  if TClient(ASender.Thread.Data).b then
  begin
    TClient(ASender.Thread.Data).b := false;
    inc(UsersQuestionsSent);
    Panel1.Caption := inttostr(UsersAnsSent) + '/' + inttostr(UsersQuestionsSent) + '/' + inttostr(Users.Count);
    ASender.Response.Add(b64en.Encode('Вопрос №' + inttostr(qnum + 1) + #13) + questions[qnum]);
  end
  else
    ASender.Response.Add(b64en.Encode('OK'));
  ASender.SendReply;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  forwho: string;
begin
  if pos('<private to=', memo3.Text) = 1 then
  begin
    forwho := copy(memo3.Text, 13, pos('>', memo3.Text) - 13);
    PrivateMsg(forwho, 'Admin', copy(memo3.Text, pos('>', memo3.Text)+1, length(memo3.text)) ,now);
  end
  else
  begin
    PublishMSG('Admin', memo3.Text, now);
  end;
//TIdPeerThread(TClient(users[0]).Thread).Connection.Write('Privet');
  memo3.Text := '';
  SendMCICommand('play "' + ExtractFileDir(application.exename) + '\data\sounds\msgSent.wav"');
end;



procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  if BitBtn2.Enabled then
  begin
    if questions.Count > qnum + 1 then
      ReDrawQuestion(qnum + 1)
    else
      ReDrawQuestion(0);
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  if BitBtn1.Enabled then
  begin
    if questions.Count > 0 then
    begin
      if qnum > 0 then
        ReDrawQuestion(qnum - 1)
      else
        ReDrawQuestion(questions.Count - 1);
    end
    else
      ReDrawQuestion(0);
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  i: integer;
begin
  if (users.Count > 0) and (questions.Count > 0) then
  begin
    if Button7.Enabled then
    begin
      UsersQuestionsSent := 0;
      UsersAnsSent := 0;
      Panel1.Caption := '0/0/' + inttostr(Users.Count);
      //GameOnline := true;
      timer2.Enabled := true;
      BlockQuestions;
      for i := 0 to Users.Count - 1 do
      begin
        TClient(Users[i]).b := true;
      end;
      inc(asked);
      Edit4.Text := inttostr(asked);
    end;
  end;
end;

procedure TForm1.serverans_sendCommand(ASender: TIdCommand);
begin
  TClient(ASender.Thread.Data).answers.Add(b64en.Encode(Asender.Params[0] + #13 + '0' + #13 + '0' + #13 + '0'));
 // DoAnswers;
 //ShowMessage('OK');
  UsersAnsSent := UsersAnsSent + 1;
  Panel1.Caption := inttostr(UsersAnsSent) + '/' + inttostr(UsersQuestionsSent) + '/' + inttostr(Users.Count);
  ASender.Response.Clear;
  ASender.Response.Add(b64en.Encode('OK'));
  ASender.Response.Add(b64en.Encode('OK'));
  ASender.SendReply;
  if UsersAnsSent = Users.Count then
  begin
    //GameOnline := false;
    UnBlockQuestions;
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
//Checking if All answers are here
  DoAnswers;
  Application.ProcessMessages;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
//Upd Greeds Info
  ReDrawGreed;
  Application.ProcessMessages;

  ReDrawComInfo;
  Application.ProcessMessages;

  ReDrawUsersList;
  Application.ProcessMessages;
end;

procedure TForm1.serverusr_listCommand(ASender: TIdCommand);
var
  s: TStringlist;
  i: integer;
begin
  ASender.Response.Clear;
  s := TStringlist.Create;
  for i := 0 to Users.Count - 1 do
  begin
    s.Add(TClient(Users[i]).Name);
  end;
  asender.Response.Add('OKOK');
  aSender.Response.Add(b64en.Encode(s.Text));
  s.Free;
  ASender.SendReply;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  Memo2.Clear;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  Button6.Click;
end;

procedure TForm1.serverConnect(AThread: TIdPeerThread);
begin
  if gameonline then
  begin
    AThread.Connection.WriteLn('GameOnline');
  end
  else
    AThread.Connection.WriteLn('GameOffline');
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  GameOnline := Checkbox1.Checked;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: integer;
begin
  try
    begin
      i := strtoint(Edit4.Text);
      if (i >= 0) and (i <= questions.Count) then
      begin
        asked := i;
        ShowMessage('Changed OK!');
      end
      else
      begin
        Edit4.Text := inttostr(asked);
        ShowMessage('Error!');
      end
    end
  except
    begin
      beep;
      Edit4.Text := inttostr(asked);
      ShowMessage('Error!');
    end;
  end;
end;

procedure TForm1.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Point: TPoint;
  I: Integer;
const
  NoHit = -1;
begin
  if Button = mbRight then
  begin
    // Если нажата правая кнопка мыши, выяснить, не попал ли курсор
    // на элемент списка UserList
    Point.X := x;
    Point.Y := y;
    I := ListBox1.ItemAtPos(Point, True);
    if not (i = NoHit) then
    begin
      // курсор попал на элемент списка с номером i
      // принудительно назначаем его текущим, т.е. отмеченным
      ListBox1.ItemIndex := I;
      popupmenu2.Tag := i;
      TListBox(Sender).PopUpMenu.AutoPopup := True;
    end
    else // курсор промахнулся , нет смысла активизировать меню
      TListBox(Sender).PopUpMenu.AutoPopup := False;
  end;
end;

procedure TForm1.kick1Click(Sender: TObject);
begin
  kickUser(listbox1.Items[popupmenu2.tag]);
end;

procedure TForm1.Dcnfdbnm1Click(Sender: TObject);
begin
  memo3.PasteFromClipboard;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
  memo3.CopyToClipboard;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  memo3.CutToClipboard;
end;

procedure TForm1.serverresultsCommand(ASender: TIdCommand);
var
  i: integer;
  max, k_max: integer;
  s1, s2: TStringList;
begin
  max := -1;
  k_max := -1;
  ASender.Response.Text := 'OK';
  s1 := TStringList.Create;
  s2 := TStringList.Create;
  for i := 0 to Users.Count - 1 do
  begin
    s1.Add(TClient(Users[i]).Name);
    s2.Add(inttostr(TClient(Users[i]).points));
  end;

  repeat
    for i := 0 to s2.Count - 1 do
    begin
      if strtoint(s2[i]) > max then
      begin
        max := strtoint(s2[i]);
        k_max := i;
      end;
    end;
    Asender.Response.Add(s1[k_max] + #9 + s2[k_max]);
    s1.Delete(k_max);
    s2.Delete(k_max);
    max := -1;
    k_max := -1;
  until s1.Count < 1;
  ASender.SendReply;
  s1.Free;
  s2.Free;
end;

procedure TForm1.Wait1Timeout(Sender: TObject);
begin
  if wait1.Tag = 0 then
  begin
    wait1.Tag := 0;
    wait1.Caption := '70';
    wait1.Stop;
  end;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
  wait1.Visible := not wait1.Visible;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
  sd.Filter := 'TXT files|*.txt';
  if sd.Execute then
    memo2.Lines.SaveToFile(sd.FileName);
  sd.Filter := 'Questions DataBase|*.qdb';
end;

procedure TForm1.onemscTimer(Sender: TObject);
begin
  onemsc.Enabled := false;
  PublishMsg(onesec_name, onesec_say, onesec_time);
end;

procedure TForm1.PrivateMsg1Click(Sender: TObject);
begin
  if pos('<private to=', memo3.Text) = 1 then
    memo3.Text := copy(memo3.text, pos('>', memo3.Text) - 1, length(memo3.Text));
  memo3.Text := '<private to=' + listbox1.Items[popupmenu2.tag] + '>' + memo3.Text;
end;

procedure TForm1.serverprivateCommand(ASender: TIdCommand);
var
s:TStringlist;
begin
s:=TStringlist.Create;
s.Text:=b64de.DecodeString(Asender.Params[0]);
PrivateMsg(b64de.DecodeString(s[0]),TClient(ASender.Thread.Data).Name,b64de.DecodeString(s[1]),now);
ASender.Response.Text:='ok';
ASender.Response.Add(b64en.Encode('OK'));
ASender.SendReply;
s.Free;
end;

end.

