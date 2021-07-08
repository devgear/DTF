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
  DTF.Utils.AutoCompleteForm in '..\DTF\DTF.Utils.AutoCompleteForm.pas' {frmAutoComplete},
  DTF.Utils.AutoComplete in '..\DTF\DTF.Utils.AutoComplete.pas',
  DTF.Config in 'Config\DTF.Config.pas',
  UserModule in 'Modules\UserModule.pas' {dmUser: TDataModule},
  DTF.Frame.Title in '..\DTF\DTF.Frame.Title.pas' {DTFTitleFrame: TFrame},
  DTF.Utils.Export in '..\DTF\DTF.Utils.Export.pas',
  Test1Form in 'Views\Test\Test1Form.pas' {frmTest1},
  uIniConfig in '..\ThirdParty\CustomAttribute\uIniConfig.pas',
  ManageUserForm in 'Views\USR\ManageUserForm.pas' {DTFMDIChildForm1},
  DTF.Auth in '..\DTF\DTF.Auth.pas',
  DTF.App.Core in '..\DTF\DTF.App.Core.pas',
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
  DTF.Utils.Extract in '..\DTF\DTF.Utils.Extract.pas',
  DTF.Utils.Print in '..\DTF\DTF.Utils.Print.pas',
  DTF.Types.View in '..\DTF\DTF.Types.View.pas',
  DTF.Logger in '..\DTF\DTF.Logger.pas',
  DTF.Service.Loader in '..\DTF\DTF.Service.Loader.pas',
  DTF.Logger.FileLog in '..\DTF\DTF.Logger.FileLog.pas',
  DTF.Logger.ODS in '..\DTF\DTF.Logger.ODS.pas',
  DTF.Service.Config in '..\DTF\DTF.Service.Config.pas',
  DTF.Config.IniLoader in '..\DTF\DTF.Config.IniLoader.pas',
  DTF.Service.View in '..\DTF\DTF.Service.View.pas',
  Test4Form in 'Views\Test\Test4Form.pas' {frmTest4};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '::: DTF MDI Client :::';

  ReportMemoryLeaksOnShutdown := True;

  App.StartUp;

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TdmUser, dmUser);
  Application.CreateForm(TdmResource, dmResource);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
