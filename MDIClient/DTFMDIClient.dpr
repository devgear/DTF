program DTFMDIClient;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {frmMain},
  DatabaseModule in 'Modules\DatabaseModule.pas' {dmDatabase: TDataModule},
  DTF.Form.Base in '..\DTF\DTF.Form.Base.pas' {DTFBaseForm},
  MenuTypes in 'Common\MenuTypes.pas',
  DTF.Form.MDIChild in '..\DTF\DTF.Form.MDIChild.pas' {DTFMDIChildForm},
  DTF.Types in '..\DTF\DTF.Types.pas',
  SYS1010 in 'Views\SYS\SYS1010.pas' {frmSYS1010},
  DTF.Frame.Base in '..\DTF\DTF.Frame.Base.pas' {DTFBaseFrame: TFrame},
  DTF.Frame.DataSet in '..\DTF\DTF.Frame.DataSet.pas' {DTFDataSetFrame: TFrame},
  DTF.Module.Resource in '..\DTF\DTF.Module.Resource.pas' {dmResource: TDataModule},
  DTF.Frame.DBGrid in '..\DTF\DTF.Frame.DBGrid.pas' {DTFDBGridFrame: TFrame},
  DTF.Util.AutoCompleteForm in '..\DTF\DTF.Util.AutoCompleteForm.pas' {frmAutoComplete},
  DTF.Util.AutoComplete in '..\DTF\DTF.Util.AutoComplete.pas',
  DTF.Config in 'Config\DTF.Config.pas',
  UserModule in 'Modules\UserModule.pas' {dmUser: TDataModule},
  DTF.Frame.Title in '..\DTF\DTF.Frame.Title.pas' {DTFTitleFrame: TFrame},
  DTF.IO.Export in '..\DTF\DTF.IO.Export.pas',
  Test1Form in 'Views\Test\Test1Form.pas' {frmTest1},
  uIniConfig in '..\ThirdParty\CustomAttribute\uIniConfig.pas',
  ManageUserForm in 'Views\USR\ManageUserForm.pas' {DTFMDIChildForm1},
  DTF.Auth in '..\DTF\DTF.Auth.pas',
  DTF.App.Base in '..\DTF\DTF.App.Base.pas',
  DTF.App in 'Config\DTF.App.pas',
  AuthService in 'Services\AuthService.pas',
  MenuService in 'Services\MenuService.pas',
  DTF.Service in '..\DTF\DTF.Service.pas',
  DTF.Service.Types in '..\DTF\DTF.Service.Types.pas',
  DTF.Intf in '..\DTF\DTF.Intf.pas',
  DTF.Frame.StrGrid in '..\DTF\DTF.Frame.StrGrid.pas' {DTFStrGridFrame: TFrame},
  Test2Form in 'Views\Test\Test2Form.pas' {frmTest2},
  DTF.Utils in '..\DTF\DTF.Utils.pas',
  Test3Form in 'Views\Test\Test3Form.pas' {frmTest3},
  DTF.GridInfo in '..\DTF\DTF.GridInfo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '::: DTF MDI Client :::';

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TdmUser, dmUser);
  Application.CreateForm(TdmResource, dmResource);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
