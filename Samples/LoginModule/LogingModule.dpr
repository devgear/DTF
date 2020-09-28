program LogingModule;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  DTF.Core.Auth in 'DTF.Core.Auth.pas',
  UserAuthModule in 'UserAuthModule.pas' {dmUserAuth: TDataModule},
  UserAuthTypes in 'UserAuthTypes.pas',
  DTF.Form.ChangePassword in 'DTF.Form.ChangePassword.pas' {frmDTFChangePwd},
  DTF.Form.Login in 'DTF.Form.Login.pas' {frmDTFLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmUserAuth, dmUserAuth);
  Application.CreateForm(TfrmDTFChangePwd, frmDTFChangePwd);
  Application.CreateForm(TfrmDTFLogin, frmDTFLogin);
  Application.Run;
end.
