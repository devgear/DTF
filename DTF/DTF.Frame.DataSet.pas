unit DTF.Frame.DataSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.UITypes, 
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Frame.Base, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.DBActns, System.Actions, Vcl.ActnList, Data.DB, DTF.Types;

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
    actDSRefresh: TDataSetRefresh;
    btnDSRefresh: TToolButton;
    actDSExportXls: TAction;
    btnExportXls: TToolButton;

    procedure actDSNewAppendExecute(Sender: TObject);
    procedure actDSDeleteExecute(Sender: TObject);
    procedure actDSExportXlsUpdate(Sender: TObject);
    procedure actDSExportXlsExecute(Sender: TObject);
  private
    FFocusControl: TWinControl;
  public
    property FocusControl: TWinControl read FFocusControl write FFocusControl;
  end;

var
  DTFDataSetFrame: TDTFDataSetFrame;

implementation

{$R *.dfm}

uses
  DTF.Module.Resource,
  DTF.IO.Export;

procedure TDTFDataSetFrame.actDSDeleteExecute(Sender: TObject);
begin
  if MessageDlg(SDSDeleteConfirm, mtConfirmation,[mbYes, mbNo], 0) = mrOK then
  begin
    DataSource.DataSet.Delete;
  end;
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
    if Dialog.Execute then
      LDataSet.ExportToXls(Dialog.FileName);
    Dialog.Free;
  end;
end;

procedure TDTFDataSetFrame.actDSExportXlsUpdate(Sender: TObject);
var
  LDataSet: TDataSet;
begin
  LDataSet := DataSource.DataSet;
  Enabled := Assigned(LDataSet) and LDataSet.Active and LDataSet.CanModify;
end;

procedure TDTFDataSetFrame.actDSNewAppendExecute(Sender: TObject);
begin
  if Assigned(DataSource.DataSet) then
  begin
    DataSource.DataSet.Append;

    if Assigned(FFocusControl) then
      FFocusControl.SetFocus;
  end;
end;

end.
