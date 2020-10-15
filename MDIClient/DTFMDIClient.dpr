program DTFMDIClient;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {frmMain},
  DatabaseModule in 'DatabaseModule.pas' {dmDatabase: TDataModule},
  DTF.Form.Base in '..\DTF\DTF.Form.Base.pas' {frmDTFBase},
  DTF.Builder.Factory in '..\DTF\DTF.Builder.Factory.pas',
  MenuTypes in 'MenuTypes.pas',
  DTF.Form.MDIChild in '..\DTF\DTF.Form.MDIChild.pas' {frmDTFMDIChild},
  DTF.Form.DataSet in '..\DTF\DTF.Form.DataSet.pas' {frmDTFDataSet},
  TestForm in 'TestForm.pas' {frmTest},
  DTF.Types in '..\DTF\DTF.Types.pas',
  SYS1010 in 'Sys\SYS1010.pas' {frmSYS1010},
  DTF.Frame.Base in '..\DTF\DTF.Frame.Base.pas' {DTFBaseFrame: TFrame},
  DTF.Frame.DataSet in '..\DTF\DTF.Frame.DataSet.pas' {DTFDataSetFrame: TFrame},
  DTF.Module.Resource in '..\DTF\DTF.Module.Resource.pas' {dmResource: TDataModule},
  DTF.Frame.DBGrid in '..\DTF\DTF.Frame.DBGrid.pas' {DTFDBGridFrame: TFrame},
  DTF.Util.AutoCompleteForm in '..\DTF\DTF.Util.AutoCompleteForm.pas' {frmAutoComplete},
  DTF.Util.AutoComplete in '..\DTF\DTF.Util.AutoComplete.pas',
  Environment in 'Environment.pas',
  DTF.Core.Authentication in '..\DTF\DTF.Core.Authentication.pas',
  DTF.Core.AuthTypes in '..\DTF\DTF.Core.AuthTypes.pas',
  LoginModule in 'LoginModule.pas' {dmLogin: TDataModule},
  DTF.Form.UserLogin in '..\DTF\DTF.Form.UserLogin.pas' {frmUserLogin},
  DTF.Frame.Title in '..\DTF\DTF.Frame.Title.pas' {DTFTitleFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TdmResource, dmResource);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
