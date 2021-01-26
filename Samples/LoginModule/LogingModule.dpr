program LogingModule;

uses
  Vcl.Forms,
  Vcl.Controls,
  Unit1 in 'Unit1.pas' {frmMain},
  LoginForm in 'LoginForm.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  frmLogin := TfrmLogin.Create(nil);
  if frmLogin.ShowModal = mrOK then
  begin
    Application.CreateForm(TfrmMain, frmMain);
  end;
  frmLogin.Free;
  Application.Run;
end.
