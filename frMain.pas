unit frMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, StdCtrls, ExtCtrls, frSetup, IdCoder, IdCoder3to4,
  IdCoderMIME, inifiles, ComCtrls, AdvAlertWindow, MMSystem;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    client: TIdTCPClient;
    XPManifest1: TXPManifest;
    b64en: TIdEncoderMIME;
    b64de: TIdDecoderMIME;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Button3: TButton;
    checkinet: TTimer;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Button4: TButton;
    game_timer: TTimer;
    time_sec: TTimer;
    tmUsrList: TTimer;
    Memo1: TMemo;
    AdvAlertWindow1: TAdvAlertWindow;
    Vspliv: TTimer;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure clientDisconnected(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure game_timerTimer(Sender: TObject);
    procedure time_secTimer(Sender: TObject);
    procedure tmUsrListTimer(Sender: TObject);
    procedure VsplivTimer(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    procedure ClearAll;
    procedure DisableAll;
    procedure EnableAll;
    procedure EnableEdits;
    procedure DisableEdits;
    function RegAndLogin(login: string): byte;
    procedure Report(s: string);
    procedure StartGame;
    procedure SetTimers;
  end;

const
  time_minute = 60;
  time_write = 10;
  sEgg = 'CHGKRULEZ';
  iEggLength = length(sEgg);

var
  Form1: TForm1;
  MyName: string = '';
  ServerIP: string = '';
  logged: boolean = false;

  ini_path: string = '/setings.ini';
  Ini: TIniFile;

  time_question: integer;
  TrackBar1Position: integer;
  icnt: integer;
  host: string = 'http://luckygeck.tut.su';
  url: string = 'http://luckygeck.tut.su/info.txt';

  Gamelog: tStringList;
  questions_asked: integer;
  //  time_writequestion:integer;

implementation

uses frChat, frGLog, frResult;

{$R *.dfm}

procedure TForm1.SetTimers;
var
  i: integer;
begin
  i := Form3.TrackBar1.Position;
  tmUsrList.Interval := i;
  checkinet.Interval := i;
  game_timer.Interval := i;
  Form3.Label1.Caption := inttostr(i) + ' msc';
end;

procedure TForm1.StartGame;
var
  s: TStringList;
  e: string;
begin
  if not client.Connected then
    exit;
  client.SendCmd('<start_game> ' + 'OK');
  s := TStringList.Create;
  repeat
    e := client.ReadLn;
    s.Add(e);
  until e = '.';
  e := b64de.DecodeString(s[0]);
  s.Text := e;
  if (pos('Вопрос', s[0]) > 0) then
  begin
    s.Delete(0);
    //  FlashWindow(Application.Handle, True);

    beep;
    Memo1.Lines.Text := s.Text;
    inc(questions_asked);
    GameLog.Add('Вопрос №' + inttostr(questions_asked));
    GameLog.Add(s.Text);
    GameLog.Add('');
    if length(s.Text) > 50 then
      e := copy(s.text, 0, 50) + '...'
    else
      e := s.Text;

    AdvAlertWindow1.AlertMessages.Clear;
    advalertwindow1.AlertMessages.Add.Text.Add('ВНИМАНИЕ, ВОПРОС!' + #13 + e);
    advalertwindow1.Show;
    vspliv.Enabled := true;
    playsound(PChar(ExtractFileDir(Application.Exename) +
      '\data\sounds\Vopros.wav'), 0, SND_ASYNC);

    game_timer.Enabled := false;
    Form1.Caption := 'Своя Игра - Inet - [Думаем ещё ' + inttostr(time_minute) +
      ' сек ]';
    time_question := 0;
    time_sec.Enabled := true;
    button2.Enabled := false;
    enableedits;
  end;
end;

procedure TForm1.Report(s: string);
begin
  Label5.Caption := s;
end;

function TForm1.RegAndLogin(login: string): byte;
var
  s: TStringList;
  e: string;
begin
  if not client.Connected then
    exit;
  client.SendCmd('<login> ' + b64en.Encode(login));

  //---//
  s := TStringlIst.Create;
  repeat
    e := client.ReadLn;
    s.Add(e);
  until e = '.';
  e := s[0];
  s.Free;
  //---//

  if b64de.DecodeString(e) = 'OK' then
  begin
    logged := true;
    result := 0;
  end
  else if b64de.DecodeString(e) = 'ErrorLogin' then
  begin
    ShowMessage('Your login is alredy occupied!' + #13 + 'Change it!');
    logged := false;
    result := 1;
    client.Disconnect;
  end
  else
  begin
    ShowMessage('Something wrong on the server! Maybe, there are some technical problems on it.'
      + #13 + 'For more info contact server''s administrator!');
    logged := false;
    result := 2;
  end;
end;

procedure TForm1.ClearAll;
begin
  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  memo1.Text := '';
end;

procedure TForm1.DisableAll;
begin
  Edit1.Enabled := false;
  Edit2.Enabled := false;
  Edit3.Enabled := false;
  Form3.Button1.Enabled := false;
  Button3.Enabled := false;
  Button7.Enabled := false;
end;

procedure TForm1.DisableEdits;
begin
  Edit1.Enabled := false;
  Edit2.Enabled := false;
  Edit3.Enabled := false;
  Button5.Enabled := false;
end;

procedure TForm1.EnableAll;
begin
  Form3.Button1.Enabled := true;
  Button3.Enabled := true;
  Button7.Enabled := true;
end;

procedure TForm1.EnableEdits;
begin
  Edit1.Enabled := true;
  Edit2.Enabled := true;
  Edit3.Enabled := true;
  Button5.Enabled := true;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form2 := TForm2.Create(Application);
  Form2.Edit1.Text := MyName;
  Form2.Edit2.Text := ServerIp;
  Form2.ShowModal;
  Form2.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: integer;
  s: string;
begin
  i := 0;
  if client.Connected then
  begin
    try
      client.Disconnect;
      button2.Caption := 'Connect';
      logged := false;
      ClearAll;
      DisableAll;
      disableedits;
    except
      begin
        button2.Caption := 'Connect';
        ClearAll;
        logged := false;
        DisableAll;
        disableedits;
        MessageBox(Application.Handle, PChar('Error while disconnecting!'),
          PChar('Disconnect error!'), MB_ICONSTOP);
      end;
    end;
  end
  else
  begin
    try
      client.Host := copy(ServerIP, 0, pos(':', ServerIP) - 1);
      client.Port := strtoint(copy(ServerIP, pos(':', ServerIP) + 1,
        length(ServerIP)));
      client.Connect;
      s := client.ReadLn;
      if s = 'GameOnline' then
      begin
        logged := false;
        client.Disconnect;
        ShowMessage('There is a game online, so you cannot enter the Server.' +
          #13 + ' Try later ');
      end
      else
      begin
        i := RegAndLogin(MyName);
        button2.Caption := 'Disconnect';
        ClearAll;
        logged := true;
        EnableAll;
        disableedits;
        Application.ProcessMessages;
        button3.Click;
      end
    except
      begin
        button2.Caption := 'Connect';
        logged := false;
        ClearAll;
        DisableAll;
        disableedits;
        MessageBox(Application.Handle, PChar('Error while connecting!' + #13 +
          'Check your internet conncetion!'), PChar('Connect error!'),
          MB_ICONSTOP);
      end
    end;
    if i > 0 then
    begin
      DisableAll;
      disableedits;
      logged := false;
      button2.Caption := 'Connect';
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  e: string;
  s, s1: TStringList;
  i: integer;
begin
  if not logged then
    exit;
  s := TStringList.Create;
  s1 := TStringList.Create;
  client.SendCmd('<ready> ' + b64en.Encode('OK'));
  repeat
    e := client.ReadLn;
    s.Add(e);
  until e = '.';
  if b64de.DecodeString(s[0]) = 'OK' then
  begin
    LAbel5.caption := b64de.DecodeString(s[1]);
    if s.Count > 3 then
    begin
      s.Text := b64de.DecodeString(s[2]);
      for i := 0 to s.Count - 1 do
      begin
        s1.Text := b64de.DecodeString(s[i]);
        Form3.onemsc.Enabled := true;
        Form3.LogAdd(b64de.DecodeString(s1[0]), b64de.DecodeString(s1[1]));
        Form3.Memo1.Lines.Add('');
      end;

    end;
  end
  else
  begin
    button2.Click;
    ShowMessage('You were kicked from the server.' + #13 + 'Comments: ' +
      b64de.DecodeString(s[0]));
  end;
  s.Free;
  s1.Free;
  Application.ProcessMessages;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Form1.Label6.Caption := 'Твоё имя: ' + MyName + #13 + 'Адрес сервера: ' +
    serverip;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if Form3.Showing then
    Form3.Hide
  else
    Form3.Show;
end;

procedure TForm1.clientDisconnected(Sender: TObject);
begin
  button2.Caption := 'Connect';
  ClearAll;
  DisableAll;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  KeyPreview := true;
  icnt := 1;
  questions_asked := 0;
  GameLog := TStringlist.Create;
  time_question := 0;
  //time_writequestion:=0;
  ini_path := Extractfiledir(Application.ExeName) + ini_path;
  Ini := TiniFile.Create(ini_path);
  MyName := Ini.ReadString('Personal', 'name', 'My Name');
  ServerIP := Ini.ReadString('Network', 'serverip', '');
  host := Ini.ReadString('Network', 'host', 'http://www.chgk-online.tu2.ru/');
  url := Ini.ReadString('Network', 'url', 'info.txt');
  url := host + url;
  try
    begin
      i := Ini.ReadInteger('Personal', 'refresh', 10000);
      if (i > 10000) or (i < 1) then
        i := 10000;
      TrackBar1Position := i;
    end
  except
    TrackBar1Position := 10000;
  end;
  Ini.Free;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Ini := TiniFile.Create(ini_path);
  Ini.WriteString('Personal', 'name', MyName);
  Ini.WriteString('Network', 'serverip', ServerIP);
  //Ini.WriteString('Network', 'host', host);
  //Ini.WriteString('Network', 'url', url);
  Ini.WriteInteger('Personal', 'refresh', TrackBar1Position);
  Ini.Free;
  GameLog.Free;
end;

procedure TForm1.game_timerTimer(Sender: TObject);
begin
  try
    startgame;
  except
    Showmessage('ERROR!');
    Button2.Click;
  end;
  Application.ProcessMessages;
end;

procedure TForm1.time_secTimer(Sender: TObject);
var
  s: TStringList;
  e: string;
begin
  try
    begin
      inc(time_question);
      if time_question <= time_minute then
      begin
        Form1.Caption := 'Своя Игра - Inet - [Думаем ещё ' + inttostr(time_minute
          - time_question) + ' сек ]';

        if time_question = time_minute then
          playsound(PChar(ExtractFileDir(Application.Exename) +
            '\data\sounds\Sig1.wav'), 0, SND_ASYNC);
      end
      else if (time_question >= time_minute) and (time_question < time_write +
        time_minute) then
      begin

        Form1.Caption := 'Своя Игра - Inet - [Пишем и сдаём через ' +
          inttostr(time_write + time_minute - time_question) + ' сек ]';
      end
      else
      begin
        playsound(PChar(ExtractFileDir(Application.Exename) +
          '\data\sounds\SigM.wav'), 0, SND_ASYNC);
        Form1.Caption := 'Своя Игра - Inet';
        client.SendCmd('<ans_send> ' + b64en.Encode(b64en.Encode('1)' +
          Edit1.Text) + #13 + b64en.Encode('2)' + Edit2.Text) + #13 +
          b64en.Encode('3)' + Edit3.Text)));
        //---//
        time_sec.Enabled := false;

        GameLog.Add('Ваши ответы:');
        GameLog.Add('1)' + Edit1.Text);
        GameLog.Add('2)' + Edit2.Text);
        GameLog.Add('3)' + Edit3.Text);
        GameLog.Add('');

        s := TStringlIst.Create;
        repeat
          e := client.ReadLn;
          s.Add(e);
        until e = '.';
        e := s[0];

        //---//
        if e <> b64en.Encode('OK') then
          ShowMessage('Что-то пошло не так и ваши ответы не обработались сервером!!!'
            + #13 + 'Сообщите админу!!!');

        client.SendCmd('<right_ans> OK');
        s.Clear;
        repeat
          e := client.ReadLn;
          s.Add(e);
        until e = '.';
        e := s[0];
        s.Free;

        GameLog.Add(b64de.DecodeString(e));
        GameLog.Add('');
        GameLog.Add('');
        playsound(PChar(ExtractFileDir(Application.ExeName) +
          '\data\sounds\RightAns.wav'), 0, SND_ASYNC);
        ShowMessage(b64de.DecodeString(e));
        Edit1.Text := '';
        Edit2.Text := '';
        Edit3.Text := '';
        memo1.Text := '';
        disableedits;
        game_timer.Enabled := true;
        button2.Enabled := true;
      end;
    end
  except
    ShowMessage('Fatal Error!!!' + #13 + 'Closing');
    game_timer.Enabled := true;
    button2.Enabled := true;
    time_sec.Enabled := false;
    Close;
  end;
  Application.ProcessMessages;
end;

procedure TForm1.tmUsrListTimer(Sender: TObject);
var
  s: TStringList;
  e: string;
begin
  if not logged then
    exit;
  client.SendCmd('<usr_list>  OK');
  s := TStringlIst.Create;
  repeat
    e := client.ReadLn;
    s.Add(e);
  until e = '.';
  s.Text := b64de.DecodeString(s[0]);
  //---//
  Form3.list.Items.Text := s.Text;
  s.Free;
  Application.ProcessMessages;
end;

procedure TForm1.VsplivTimer(Sender: TObject);
begin
  vspliv.Enabled := false;
  AdvAlertWindow1.Hide;
  AdvAlertWindow1.AlertMessages.Clear;
  Application.ProcessMessages;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  s: TStringList;
  e: string;
begin
  playsound(PChar(ExtractFileDir(Application.Exename) +
    '\data\sounds\SigM.wav'), 0, SND_ASYNC);
  Form1.Caption := 'Своя Игра - Inet';
  client.SendCmd('<ans_send> ' + b64en.Encode(b64en.Encode('1)' +
    Edit1.Text) + #13 + b64en.Encode('2)' + Edit2.Text) + #13 +
    b64en.Encode('3)' + Edit3.Text)));
  //---//
  time_sec.Enabled := false;
  GameLog.Add('Ваши ответы:');
  GameLog.Add('1)' + Edit1.Text);
  GameLog.Add('2)' + Edit2.Text);
  GameLog.Add('3)' + Edit3.Text);
  GameLog.Add('');
  s := TStringlIst.Create;
  repeat
    e := client.ReadLn;
    s.Add(e);
  until e = '.';
  e := s[0];

  //---//
  if e <> b64en.Encode('OK') then
    ShowMessage('Что-то пошло не так и ваши ответы не обработались сервером!!!'
      + #13 + 'Сообщите админу!!!');

  client.SendCmd('<right_ans> OK');
  s.Clear;
  repeat
    e := client.ReadLn;
    s.Add(e);
  until e = '.';
  e := s[0];
  s.Free;
  playsound(PChar(ExtractFileDir(Application.ExeName) +
    '\data\sounds\RightAns.wav'), 0, SND_ASYNC);
  ShowMessage(b64de.DecodeString(e));
  GameLog.Add(b64de.DecodeString(e));
  GameLog.Add('');
  GameLog.Add('');

  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  memo1.Text := '';
  disableedits;
  game_timer.Enabled := true;
  button2.Enabled := true;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  frGameLog := TfrGameLog.Create(Application);
  frGameLog.Memo1.Text := GameLog.Text;
  frGamelog.ShowModal;
  frGameLog.Free;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  s: TStringList;
  e: string;
  i: integer;
begin
  if not client.Connected then
    exit;
  client.SendCmd('<results> OK');
  s := TStringlIst.Create;
  repeat
    e := client.ReadLn;
    s.Add(e);
  until e = '.';
  s.Delete(s.Count - 1);
  //---//
  form4.StringGrid1.RowCount := s.Count;

  form4.StringGrid1.ColWidths[0] := Round(form4.Width / 2) - 5;
  form4.StringGrid1.ColWidths[1] := Round(form4.Width / 2) - 5;

  for i := 0 to s.Count - 1 do
  begin
    e := s[i];
    with Form4.StringGrid1 do
    begin
      Cells[0, i] := copy(e, 0, pos(#9, e) - 1);
      Cells[1, i] := copy(e, pos(#9, e) + 1, length(e));
    end;
  end;
  form4.ShowModal;
  s.Free;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  e: string;
  s: TStringlist;
begin
  if ssCtrl in Shift then
  begin
    if Key = Ord(sEgg[icnt]) then
    begin
      if (icnt = iEggLength) and (client.Connected) then
      begin
        icnt := 1;
        s := TStringlist.Create;
        client.SendCmd('<right_ans> OK');
        repeat
          e := client.ReadLn;
          s.Add(e);
        until e = '.';
        e := s[0];
        s.Free;
        ShowMessage(b64de.DecodeString(e));
      end

      else
        inc(icnt);
    end
    else
      icnt := 1;
  end;
end;
end.

