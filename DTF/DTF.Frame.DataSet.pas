unit DTF.Frame.DataSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.UITypes, 
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Frame.Base, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.DBActns, System.Actions, Vcl.ActnList, Data.DB, DTF.Types,
  DTF.Frame.Title;

type
  TDTFDataSetFrame = class(TDTFBaseFrame)
    ActionList: TActionList;
    actDSNewAppend: TDataSetInsert;
    actDSDelete: TDataSetDelete;
    actDSSavePost: TDataSetPost;
    actDSCancel: TDataSetCancel;

    tlbDataSet: TToolBar;
    btnDSNew: TToolButton;
    btnDSSave: TToolButton;
    btnDSCancel: TToolButton;
    btnDSDelete: TToolButton;
    DataSource: TDataSource;
    btnDSRefresh: TToolButton;
    actDSExportXls: TAction;
    btnExportXls: TToolButton;
    actDSSearch: TDataSetRefresh;
    actPrint: TAction;
    ToolButton2: TToolButton;
    DTFTitleFrame1: TDTFTitleFrame;

    procedure actDSNewAppendExecute(Sender: TObject);
    procedure actDSDeleteExecute(Sender: TObject);
    procedure actDSExportXlsUpdate(Sender: TObject);
    procedure actDSExportXlsExecute(Sender: TObject);
    procedure actDSSearchExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
  private
    FFocusControl: TWinControl;
    FSearchParamProc: TProc;
  public
    property FocusControl: TWinControl read FFocusControl write FFocusControl;
    procedure SetSearchParamProc(AProc: TProc);
  end;

implementation

{$R *.dfm}

uses
  DTF.Module.Resource,
  DTF.Utils.Export;

procedure TDTFDataSetFrame.actDSNewAppendExecute(Sender: TObject);
begin
  if Assigned(DataSource.DataSet) then
  begin
    DataSource.DataSet.Append;

    if Assigned(FFocusControl) then
      FFocusControl.SetFocus;
  end;
end;

procedure TDTFDataSetFrame.actDSSearchExecute(Sender: TObject);
begin
  if Assigned(FSearchParamProc) then
  begin
    DataSource.DataSet.Close;
    FSearchParamProc;
    DataSource.DataSet.Open;
  end
  else
    inherited;
end;

procedure TDTFDataSetFrame.actDSDeleteExecute(Sender: TObject);
begin
  if MessageDlg(SDSDeleteConfirm, mtConfirmation,[mbYes, mbNo], 0) = mrOK then
    DataSource.DataSet.Delete;
end;

procedure TDTFDataSetFrame.actDSExportXlsExecute(Sender: TObject);
var
  LDataSet: TDataSet;
  Dialog: TSaveDialog;
begin
  LDataSet := DataSource.DataSet;
  if Assigned(LDataSet) then
  begin
    Dialog := TSaveDialog.Create(nil);
    Dialog.Filter := 'XLSX file|*.xlsx';
    Dialog.FileName := TAction(Sender).Hint;
    if Dialog.Execute then
      TExportUtil.SaveToXlsFromDataset(LDataSet, Dialog.FileName);
//      LDataSet.ExportToXls(Dialog.FileName);
    Dialog.Free;
  end;
end;

procedure TDTFDataSetFrame.actPrintExecute(Sender: TObject);
var
  LDataSet: TDataSet;
begin
  LDataSet := DataSource.DataSet;
  if Assigned(LDataSet) then
    TExportUtil.PrintFromDataSet(LDataSet, TAction(Sender).Hint);
end;

procedure TDTFDataSetFrame.actDSExportXlsUpdate(Sender: TObject);
var
  LDataSet: TDataSet;
begin
  LDataSet := DataSource.DataSet;
  TAction(Sender).Enabled := Assigned(LDataSet) and LDataSet.Active and LDataSet.CanModify;
end;

procedure TDTFDataSetFrame.SetSearchParamProc(AProc: TProc);
begin
  FSearchParamProc := AProc;
end;

end.
