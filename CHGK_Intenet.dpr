program CHGK_Intenet;

uses
  Forms,
  frMain in 'frMain.pas' {Form1},
  frSetup in 'frSetup.pas' {Form2},
  frChat in 'frChat.pas' {Form3},
  frGLog in 'frGLog.pas' {frGameLog},
  frResult in 'frResult.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.

