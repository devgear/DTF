program DTFMDIClient;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {frmMain},
  DatabaseModule in 'Modules\DatabaseModule.pas' {dmDatabase: TDataModule},
  DTF.Form.Base in '..\DTF\DTF.Form.Base.pas' {DTFBaseForm},
  MenuTypes in 'Common\MenuTypes.pas',
  DTF.Form.MDIChild in '..\DTF\DTF.Form.MDIChild.pas' {DTFMDIChildForm},
  DTF.Types in '..\DTF\DTF.Types.pas',
  SYS1010 in 'Sys\SYS1010.pas' {frmSYS1010},
  DTF.Frame.Base in '..\DTF\DTF.Frame.Base.pas' {DTFBaseFrame: TFrame},
  DTF.Frame.DataSet in '..\DTF\DTF.Frame.DataSet.pas' {DTFDataSetFrame: TFrame},
  DTF.Module.Resource in '..\DTF\DTF.Module.Resource.pas' {dmResource: TDataModule},
  DTF.Frame.DBGrid in '..\DTF\DTF.Frame.DBGrid.pas' {DTFDBGridFrame: TFrame},
  DTF.Util.AutoCompleteForm in '..\DTF\DTF.Util.AutoCompleteForm.pas' {frmAutoComplete},
  DTF.Util.AutoComplete in '..\DTF\DTF.Util.AutoComplete.pas',
  DTF.Config in 'Config\DTF.Config.pas',
  DTF.Core.Authentication in '..\DTF\DTF.Core.Authentication.pas',
  DTF.Core.AuthTypes in '..\DTF\DTF.Core.AuthTypes.pas',
  UserModule in 'Modules\UserModule.pas' {dmUser: TDataModule},
  DTF.Frame.Title in '..\DTF\DTF.Frame.Title.pas' {DTFTitleFrame: TFrame},
  DTF.IO.Export in '..\DTF\DTF.IO.Export.pas',
  SignInForm in 'User\SignInForm.pas' {frmSignIn},
  Test1Form in 'Test\Test1Form.pas' {frmTest1},
  uIniConfig in '..\ThirdParty\CustomAttribute\uIniConfig.pas',
  ManageUserForm in 'User\ManageUserForm.pas' {DTFMDIChildForm1},
  Vcl.Themes,
  Vcl.Styles,
  DTF.Core.Guard in '..\DTF\DTF.Core.Guard.pas',
  DTF.Core.Auth in '..\DTF\DTF.Core.Auth.pas',
  DTF.App.Base in '..\DTF\DTF.App.Base.pas',
  DTF.App in 'Config\DTF.App.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '::: DTF MDI Client :::';

  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TdmUser, dmUser);
  //  if (Env.UseSignup) and (not ExecSignIn) then
//  begin
//    Application.Terminate;
//    Exit;
//  end;

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmResource, dmResource);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
