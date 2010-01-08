unit frGLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus;

type
  TfrGameLog = class(TForm)
    Memo1: TMemo;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    sd: TSaveDialog;
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frGameLog: TfrGameLog;

implementation

{$R *.dfm}

procedure TfrGameLog.N1Click(Sender: TObject);
begin
  if sd.Execute then
    memo1.Lines.SaveToFile(ChangeFileExt(sd.FileName, '.txt'));
end;

end.
