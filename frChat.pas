unit frChat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls, RxRichEd, ComCtrls, HKDUnit1, RichEdit,
  MMSystem;

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
  TForm3 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    list: TListBox;
    Memo2: TMemo;
    Button1: TButton;
    Memo1: TRxRichEdit;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    PopupMenu1: TPopupMenu;
    PrivateMsg1: TMenuItem;
    onemsc: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure LogAdd(name, say: string); {; time: TDateTime}
    procedure col(ARow: Integer; bcolor: Tcolor; AColor: TColor);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure listMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PrivateMsg1Click(Sender: TObject);
    procedure onemscTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PutRTFSelection(RichEdit: TRxRichEdit; SourceStream: TStream);
    procedure DrawSmile(smile: string; path: string; ARow: integer);
    procedure PrivateMsg(forwho, say: string);
  end;

var
  Form3: TForm3;

implementation

uses frMain;

{$R *.dfm}

procedure TForm3.PrivateMsg(forwho, say: string);
var
  s, e: string;
begin
  Form1.client.SendCmd('<private> ' +
    Form1.b64en.Encode(Form1.b64en.Encode(forwho) + #13 +
    Form1.b64en.Encode(say)));
  repeat
    s := e;
    e := Form1.client.ReadLn;
  until e = '.';
  datetimetostring(e, 'd.m.yyyy h:nn:ss', now);
  if Form1.b64de.DecodeString(s) = 'OK' then
  begin
    LogAdd(MyName + ' > ' + forwho + ' (' + e + '):',
      say + #13);
    Memo2.Text := '';
    playsound(PChar(ExtractFileDir(Application.Exename) +
      '\data\sounds\msgSent.wav'), 0, SND_ASYNC);
  end
  else
  begin
    LogAdd(MyName + ' > ' + forwho + ' (' + e + '):', say + #13 +
      '/---возможно не доставлено адресату---/' + #13);
  end;
end;

procedure TForm3.DrawSmile(smile: string; path: string; ARow: integer);
var
  str2: string;
  SS: TStringStream;
  MyBMP: TBITMAP;
  i: integer;
begin
  smile := trim(smile);
  str2 := memo1.Lines.Strings[Arow];
  with memo1 do
  begin
    if fAnsiPos(smile, str2, 1) > 0 then
    begin
      i := 0;
      while fAnsiPos(smile, str2, 1) > 0 do
      begin
        MyBMP := TBitMap.Create;
        MyBmp.LoadFromFile('.\data\smiles\' + path + '.bmp');
        SS := TStringStream.Create(BitmapToRTF(MyBMP));
        //showmessage(ss.DataString);
    //------------
       // showmessage(inttostr(fAnsiPos(':)', str2, 1)));
        SelStart := SendMessage(memo1.Handle, EM_LINEINDEX, ARow, 0) +
          fAnsiPos(smile, str2, 1) + i - 1;
        str2 := copy(str2, 0, fAnsiPos(smile, str2, 1) - 1) + copy(str2,
          fAnsiPos(smile, str2, 1) + length(smile), length(str2));
        i := i + 1;
        SelLength := length(smile);
        SelText := '';
        //------------
        PutRTFSelection(memo1, ss);
        SelLength := 0;
        //------------
        ss.Free;
        MyBmp.Free;
      end;
    end;
  end;
end;

procedure TForm3.PutRTFSelection(RichEdit: TRxRichEdit; SourceStream:
  TStream);
var
  EditStream: TEditStream;
begin
  with EditStream do
  begin
    dwCookie := Longint(SourceStream);
    dwError := 0;
    pfnCallback := EditStreamInCallBack;
  end;
  RichEdit.Perform(EM_STREAMIN, SF_RTF or SFF_SELECTION,
    Longint(@EditStream));
end;

procedure TForm3.col(ARow: Integer; bcolor: Tcolor; AColor: TColor);
begin
  with memo1 do
  begin
    {:)}DrawSmile(':)', 'smile', ARow);
    {:-)}DrawSmile(':-)', 'smile', ARow);
    {:P}DrawSmile(':P', 'tongue', ARow);
    {>_<}DrawSmile('>_<', 'afraid', ARow);
    {:x}DrawSmile(':x', 'puge', ARow);
    {А}//DrawSmile('А', 'A', ARow);
    {Б}//DrawSmile('Б', 'Б', ARow);
  end;

  Memo1.SelStart := SendMessage(Memo1.Handle, EM_LINEINDEX, ARow, 0);
  Memo1.SelLength := length(Memo1.Lines[Arow]);
  Memo1.SelAttributes.BackColor := Bcolor;
  Memo1.SelAttributes.Color := Acolor;
  Memo1.SelAttributes.Style := Memo1.SelAttributes.Style + [fsBold];

  //fsBold, fsItalic, fsUnderline, fsStrikeOut
  Memo1.SelLength := 0;
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

procedure TForm3.LogAdd(name, say: string); {; time: TDateTime}
var
  // s, e: string;
  c, j: integer;
begin
  //  datetimetostring(s, 'd.m.yyyy h:nn:ss', time);
  with (Memo1.Lines) do
  begin
    add(name); { + ' (' + s + '):'}
    c := count - 1;
    add(say);
    if pos(MyName, name) <> 1 then
    begin
      Form1.AdvAlertWindow1.AlertMessages.Clear;
      if length(say) > 50 then
        say := copy(say, 0, 50) + '...';
      if (not Form3.Showing) or (not Form3.Active) then
      begin
        Form1.AdvAlertWindow1.AlertMessages.Add.Text.Add(name + #13 + say);
        Form1.AdvAlertWindow1.Show;
        Form1.Vspliv.Enabled := true;
      end;
    end;
    //add('');

    for j := c to memo1.Lines.Count - 1 do
    begin
      col(j, clWhite, clBlack);
    end;

    if pos(MyName, name) = 1 then
      col(C, clwhite, clGreen)
    else if pos('Admin', name) = 1 then
      col(C, clGreen, clRed)
    else
      col(c, clwhite, clMaroon);
  end;
  Memo1.Perform(WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  e: string;
  s: string;
  forwho: string;
begin
  if not logged then
    exit;

  if memo2.Text = '' then
    exit;
  if pos('<private to=', memo2.Text) = 1 then
  begin
    forwho := copy(memo2.Text, 13, pos('>', memo2.Text) - 13);
    PrivateMsg(forwho, copy(memo2.Text, pos('>', memo2.Text) + 1,
      length(memo2.text)));
  end
  else
  begin
    Form1.client.SendCmd('<msg_send> ' + Form1.b64en.Encode(memo2.Text));
    repeat
      s := e;
      e := Form1.client.ReadLn;
    until e = '.';
    datetimetostring(e, 'd.m.yyyy h:nn:ss', now);
    if Form1.b64de.DecodeString(s) = 'OK' then
    begin
      LogAdd(MyName + ' (' + e + '):', memo2.Text + #13);
      Memo2.Text := '';
      playsound(PChar(ExtractFileDir(Application.Exename) +
        '\data\sounds\msgSent.wav'), 0, SND_ASYNC);
    end
    else
    begin
      LogAdd(MyName + ' (' + e + '):', memo2.Text + #13 +
        '/---возможно не доставлено адресату---/' + #13);
    end;
  end;
end;

procedure TForm3.TrackBar1Change(Sender: TObject);
begin
  if TrackBar1.Position > 500 then
  begin
    TrackBar1.Position := Round(TrackBar1.Position / 500) * 500;
  end;
  TrackBar1Position := TrackBar1.Position;
  Form1.SetTimers;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  TrackBar1.Position := TrackBar1Position;

end;

procedure TForm3.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  canclose := false;
  Form3.Hide;
end;

procedure TForm3.N1Click(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TForm3.N2Click(Sender: TObject);
begin
  if Button1.Enabled then
    Button1.Click;
end;

procedure TForm3.N5Click(Sender: TObject);
begin
  memo2.PasteFromClipboard;
end;

procedure TForm3.N6Click(Sender: TObject);
begin
  memo2.CopyToClipboard;
end;

procedure TForm3.N7Click(Sender: TObject);
begin
  memo2.CutToClipboard;
end;

procedure TForm3.listMouseDown(Sender: TObject; Button: TMouseButton;
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
    I := List.ItemAtPos(Point, True);
    if not (i = NoHit) then
    begin
      // курсор попал на элемент списка с номером i
      // принудительно назначаем его текущим, т.е. отмеченным
      List.ItemIndex := I;
      popupmenu1.Tag := i;
      TListBox(Sender).PopUpMenu.AutoPopup := True;
    end
    else // курсор промахнулся , нет смысла активизировать меню
      TListBox(Sender).PopUpMenu.AutoPopup := False;
  end;
end;

procedure TForm3.PrivateMsg1Click(Sender: TObject);
begin
  if pos('<private to=', memo2.Text) = 1 then
    memo2.Text := copy(memo2.text, pos('>', memo2.Text) - 1,
      length(memo2.Text));
  memo2.Text := '<private to=' + list.Items[popupmenu1.tag] + '>' +
    memo2.Text;
end;

procedure TForm3.onemscTimer(Sender: TObject);
begin
  onemsc.Enabled := false;
  //showmessage(PChar(ExtractFileDir(Application.ExeName)));
  playsound(PChar(ExtractFileDir(Application.Exename) +
    '\data\sounds\msgGet.wav'), 0, SND_ASYNC);

end;

end.

