program Chgk_server;

uses
  Forms,
  frMain in 'frMain.pas' {Form1},
  frEditor in 'frEditor.pas' {Form2},
  frAnsCheck in 'frAnsCheck.pas' {Form3},
  HKDUnit1 in 'HKDunit1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

