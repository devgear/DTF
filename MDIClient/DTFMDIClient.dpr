program DTFMDIClient;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {frmMain},
  DatabaseModule in 'DatabaseModule.pas' {dmDatabase: TDataModule},
  DTF.Form.Base in '..\Forms\DTF.Form.Base.pas' {frmDTFBase},
  DTF.Builder.Factory in '..\Builders\DTF.Builder.Factory.pas',
  MenuFactory in 'MenuFactory.pas',
  DTF.Form.MDIChild in '..\Forms\DTF.Form.MDIChild.pas' {frmDTFMDIChild},
  DTF.Form.DataSet in '..\Forms\DTF.Form.DataSet.pas' {frmDTFDataSet},
  TestForm in 'TestForm.pas' {frmTest},
  DTF.Types in '..\Cores\DTF.Types.pas',
  SYS1010 in 'Sys\SYS1010.pas' {frmSYS1010},
  DTF.Frames.Base in '..\Forms\DTF.Frames.Base.pas' {fmeDTFBase: TFrame},
  DTF.Frames.DataSet in '..\Forms\DTF.Frames.DataSet.pas' {fmeDTFDataSet: TFrame},
  DTF.Module.Resource in '..\Forms\DTF.Module.Resource.pas' {dmResource: TDataModule},
  DTF.Frame.DBGrid in '..\Forms\DTF.Frame.DBGrid.pas' {fmeDTFDBGrid: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmResource, dmResource);
  Application.Run;
end.
