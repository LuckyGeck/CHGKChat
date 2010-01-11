unit frEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ToolWin, Menus, ImgList;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    ImageList1: TImageList;
    procedure ListBox1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure RenewQuestion;
    procedure ToolButton5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    procedure LoadList;
  end;

var
  Form2: TForm2;
  que: TStringList;
  num: integer = -1;
implementation

uses frMain;

{$R *.dfm}

procedure TForm2.RenewQuestion;
var
  i, k: integer;
  s: string;
begin
  k := -1;
  for i := 0 to listbox1.Count - 1 do
  begin
    if ListBox1.Selected[i] then
    begin
      k := i;
      break;
    end;
  end;
  if num >= 0 then
  begin
    s := Memo1.Text;
    if length(s) > 10 then
      listbox1.Items[num] := (inttostr(num + 1) + ')' + copy(s, 0, 10) + '...')
    else
      listbox1.Items[num] := (inttostr(num + 1) + ')' + s);
    que[num] := Form1.b64en.EncodeString(Memo1.Text);
  end;
  if k >= 0 then
  begin
    num := k;
    Memo1.Text := Form1.b64de.DecodeString(que[num]);
  end
  else
    Memo1.Text := '';
end;

procedure TForm2.LoadList;
var
  i: integer;
  s: string;
begin
  listbox1.Clear;
  for i := 0 to que.Count - 1 do

  begin
    s := Form1.b64de.DecodeString(que[i]);
    if length(s) > 10 then
      listbox1.Items.Add(inttostr(i + 1) + ')' + copy(s, 0, 10) + '...')
    else
      listbox1.Items.Add(inttostr(i + 1) + ')' + s);
  end;

  if que.count > 0 then

  begin
    listbox1.Selected[que.Count - 1] := true;
    try
      Memo1.Text := Form1.b64de.DecodeString(que[que.Count - 1]);
    except
      Memo1.Text := '';
    end;

    num := que.Count - 1;
  end

  else

    if que.Count = 0
      then Memo1.Text := '';

end;


procedure TForm2.ListBox1Click(Sender: TObject);
begin
  RenewQuestion;
end;

procedure TForm2.ToolButton1Click(Sender: TObject);
begin
//  ListBox1.Items.Add('Вопрос №' + inttostr(ListBox1.Count + 1));
  que.Add(Form1.b64en.EncodeString(inttostr(ListBox1.Count + 1)));
  loadlist;
end;

procedure TForm2.ToolButton2Click(Sender: TObject);
var
  i, k: integer;
begin
  if listbox1.Count > 0 then
  begin
    k := -1;
    for i := 0 to listbox1.Count - 1 do
    begin
      if listbox1.Selected[i] then
      begin
        k := i;
        break;
      end;
    end;
    if k >= 0 then
    begin
      listbox1.Items.Delete(k);
      que.Delete(k);
      LoadList;
    end;

{    if asked > questions.Count then
    begin
      asked := 0;
      Form1.Edit4.Text := '0';
    end;   }
  end;
end;

procedure TForm2.N3Click(Sender: TObject);
begin
  que.Clear;
  loadlist;
end;

procedure TForm2.N2Click(Sender: TObject);
begin
  if Form1.od.Execute then
  begin

    que.LoadFromFile(Form1.od.FileName);
    questions.LoadFromFile(Form1.od.FileName);
    LoadList;
    db := Form1.od.FileName;
  end;
end;

procedure TForm2.N4Click(Sender: TObject);
begin
  if Trim(db) <> '' then
  begin
    que.SaveToFile(db);
    questions.Text := que.Text;
  end
  else
    n5.Click;
end;

procedure TForm2.N5Click(Sender: TObject);
begin
  if Form1.sd.Execute then
  begin
    db := ChangeFileExt(Form1.sd.FileName, '.qdb');
    que.SaveToFile(db);
    questions.Text := que.Text;
  end;
end;

procedure TForm2.ToolButton4Click(Sender: TObject);
var i: integer;
begin
  RenewQuestion;
  if (que.Count > 2) and (num > 0) then begin
    que.Exchange(num, num - 1);
    i := num;
    loadlist;
    listbox1.Selected[i - 1] := true;
    RenewQuestion;
  end;
end;

procedure TForm2.ToolButton5Click(Sender: TObject);
var i: integer;
begin
  RenewQuestion;
  if (que.Count > 2) and (num < que.Count - 1) then begin
    que.Exchange(num, num + 1);
    i := num;
    loadlist;
    listbox1.Selected[i + 1] := true;
    RenewQuestion;
  end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  num := -1;
  que := TStringlist.Create;
  que.AddStrings(questions);
  LoadList;
end;

procedure TForm2.FormHide(Sender: TObject);
begin
  RenewQuestion;
  if (messagedlg('Хотите сохранить базу?', mtConfirmation, [mbYes, mbNo], 0) = mrYes)
    then
    N4.Click;
  que.Free;
  Form1.FillDbInfo;
  Form1.ReDrawQuestion(qnum);
end;

end.

