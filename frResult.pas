unit frResult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids;

type
  TForm4 = class(TForm)
    StringGrid1: TStringGrid;
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.FormResize(Sender: TObject);
begin
  form4.StringGrid1.ColWidths[0] := Round(form4.Width / 2) - 5;
  form4.StringGrid1.ColWidths[1] := Round(form4.Width / 2) - 5;
end;

end.
