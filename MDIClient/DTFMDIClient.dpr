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
  Environment in 'Common\Environment.pas',
  DTF.Core.Authentication in '..\DTF\DTF.Core.Authentication.pas',
  DTF.Core.AuthTypes in '..\DTF\DTF.Core.AuthTypes.pas',
  UserModule in 'Modules\UserModule.pas' {dmUser: TDataModule},
  DTF.Frame.Title in '..\DTF\DTF.Frame.Title.pas' {DTFTitleFrame: TFrame},
  DTF.IO.Export in '..\DTF\DTF.IO.Export.pas',
  SignInForm in 'User\SignInForm.pas' {frmSignIn},
  Test1Form in 'Test\Test1Form.pas' {frmTest1},
  uIniConfig in '..\ThirdParty\CustomAttribute\uIniConfig.pas',
  ManageUserForm in 'User\ManageUserForm.pas' {DTFMDIChildForm1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '::: DTF MDI Client :::';

  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TdmUser, dmUser);
  Application.CreateForm(TDTFMDIChildForm1, DTFMDIChildForm1);
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
