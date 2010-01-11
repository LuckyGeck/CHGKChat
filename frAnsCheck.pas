unit frAnsCheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, frMain, ExtCtrls;

type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    GroupBox2: TGroupBox;
    CheckListBox1: TCheckListBox;
    Panel1: TPanel;
    Button1: TButton;
    Splitter1: TSplitter;
    procedure ReDoAnswer;
    procedure ReSetAns;
    procedure RefreshList;
    procedure ReGiveMarks;
    procedure ListBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  selected: integer;
  exiting: boolean;
implementation

{$R *.dfm}

procedure TForm3.ReGiveMarks;
var
  i: integer;
begin
  for i := 0 to Users.Count - 1 do
  begin
    inc(TClient(Users[i]).points, TClient(Users[i]).dpoints);
    TClient(Users[i]).p_answers.Add(inttostr(TClient(Users[i]).dpoints));
    TClient(Users[i]).dpoints := 0;
  end;
end;

procedure TForm3.RefreshList;
var
  i: integer;
begin
  listbox1.Items.Clear;
  for i := 0 to Users.Count - 1 do
  begin
    listbox1.Items.Add(TClient(users[i]).Name);
    selected := i;
    ReDoAnswer;
  end;
  listbox1.Selected[0] := true;
  selected := 0;
  ReDoAnswer;
  exiting := false;
end;

procedure TForm3.ReSetAns;
var
  a1, a2, a3: string;
  b1, b2, b3: boolean;
  i1, i2, i3: integer;
begin
  a1 := Form1.b64en.Encode(CheckListBox1.Items.Strings[0]);
  a2 := Form1.b64en.Encode(CheckListBox1.Items.Strings[1]);
  a3 := Form1.b64en.Encode(CheckListBox1.Items.Strings[2]);
  b1 := CheckListBox1.Checked[0];
  b2 := CheckListBox1.Checked[1];
  b3 := CheckListBox1.Checked[2];

  if b1 then
    i1 := 1
  else
    i1 := 0;
  if b2 then
    i2 := 1
  else
    i2 := 0;
  if b3 then
    i3 := 1
  else
    i3 := 0;

  TClient(Users[selected]).answers[TClient(Users[selected]).answers.Count - 1] := Form1.b64en.Encode(Form1.b64en.Encode(a1 + #13 + a2 + #13 + a3) + #13 + inttostr(i1) + #13 + inttostr(i2) + #13 + inttostr(i3));
  TClient(users[selected]).dpoints := i1 + i2 + i3;
end;

procedure TForm3.ReDoAnswer;
var
  a1, a2, a3: string;
  par: Tstringlist;
  i1, i2, i3: bool;
begin
  a1 := TClient(Users[selected]).answers[TClient(Users[selected]).answers.Count - 1];
  par := TStringList.Create;
  par.Text := Form1.b64de.DecodeString(a1);
  TClient(users[selected]).dpoints := strtoint(par[1]) + strtoint(par[2]) + strtoint(par[3]);
  if (par[1] = '1') then
    i1 := true
  else
    i1 := false;
  if (par[2] = '1') then
    i2 := true
  else
    i2 := false;
  if (par[3] = '1') then
    i3 := true
  else
    i3 := false;

  par.Text := Form1.b64de.DecodeString(par[0]);
  a1 := Form1.b64de.DecodeString(par[0]);
  a2 := Form1.b64de.DecodeString(par[1]);
  a3 := Form1.b64de.DecodeString(par[2]);
  CheckListBox1.Items.Clear;
  CheckListBox1.Items.Add(a1);
  CheckListBox1.Items.Add(a2);
  CheckListBox1.Items.Add(a3);
  CheckListBox1.Checked[0] := i1;
  CheckListBox1.Checked[1] := i2;
  CheckListBox1.Checked[2] := i3;
  par.Free;
end;

procedure TForm3.ListBox1Click(Sender: TObject);
var
  i: integer;
begin
  ReSetAns;
  for i := 0 to listbox1.Items.Count - 1 do
  begin
    if listbox1.Selected[i] then break;
  end;
  selected := i;
  ReDoAnswer;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  if (messagedlg('Вы точно поставили все оценки?', mtConfirmation, [mbYes, mbNo], 0) = mrYes)
    then
  begin
    ReSetAns;
    ReGiveMarks;
    exiting := true;
    Close;
  end;
end;

procedure TForm3.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if exiting then
    canclose := true
  else
    case (messagedlg('Вы точно поставили все оценки?' + #13 + 'Сохранить и выйти?', mtConfirmation, [mbYes, mbNo, mbCancel], 0)) of
      mrYes:
        begin
          ReSetAns;
          ReGiveMarks;
          canclose := true;
        end;
      mrNo:
        begin
          canclose := true;
        end;
      mrCancel:
        begin
          canclose := true;
        end;
    end;
end;
end.

