unit frSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, Wininet, IdAntiFreezeBase, IdAntiFreeze;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    http: TIdHTTP;
    IdAntiFreeze1: TIdAntiFreeze;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
function IsConnectedToInternet: Boolean;
implementation

uses frMain;

{$R *.dfm}

function IsConnectedToInternet: Boolean;
var
  dwConnectionTypes: DWORD;
begin
  dwConnectionTypes :=
    INTERNET_CONNECTION_MODEM +
    INTERNET_CONNECTION_LAN +
    INTERNET_CONNECTION_PROXY;
  Result := InternetGetConnectedState(@dwConnectionTypes, 0);
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  new: string;
begin
  http.Host := host;
  try
    Form2.Caption := 'Setup - connecting...';
    new := http.Get(url);
    {'http://localhost:8080/programlevap.narod/newvers.info'}
    Edit2.Text := new;
    Form2.Caption := 'Setup - OK';
  except
    Form2.Caption := 'Setup - ERROR';
    showmessage('Could not connect to Internet!!!' + #13 +
      '   =Check your connection!!!=   ');
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  MyName := Trim(Edit1.text);
  ServerIP := Trim(Edit2.Text);
  Form1.Label6.Caption := 'Твоё имя: ' + MyName + #13 + 'Адрес сервера: ' +
    serverip;
  ShowMessage('Saving - OK...');
  Form2.Close;
end;

end.
