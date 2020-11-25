program LogingModule;

uses
  Vcl.Forms,
  Vcl.Controls,
  Unit1 in 'Unit1.pas' {frmMain},
  DTF.Core.Auth in 'DTF.Core.Auth.pas',
  UserAuthModule in 'UserAuthModule.pas' {dmUserAuth: TDataModule},
  UserAuthTypes in 'UserAuthTypes.pas',
  DTF.Form.ChangePassword in 'DTF.Form.ChangePassword.pas' {frmDTFChangePwd},
  DTF.Form.Login in 'DTF.Form.Login.pas' {frmDTFLogin},
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
