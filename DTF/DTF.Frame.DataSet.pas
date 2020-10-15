unit DTF.Frame.DataSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
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
    ToolButton11: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    DataSource: TDataSource;
    actDSRefresh: TDataSetRefresh;
    ToolButton4: TToolButton;

    procedure actDSNewAppendExecute(Sender: TObject);
    procedure actDSDeleteExecute(Sender: TObject);
  private
    FFocusControl: TWinControl;
    { Private declarations }
  public
    { Public declarations }
    property FocusControl: TWinControl read FFocusControl write FFocusControl;
  end;

var
  DTFDataSetFrame: TDTFDataSetFrame;

implementation

{$R *.dfm}

uses DTF.Module.Resource;

procedure TDTFDataSetFrame.actDSDeleteExecute(Sender: TObject);
begin
  if MessageDlg(SDSDeleteConfirm, mtConfirmation,[mbYes, mbNo], 0) = mrOK then
  begin
    DataSource.DataSet.Delete;
  end;
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
