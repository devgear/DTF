unit DTF.Frame.DataSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Frame.Base, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.DBActns, System.Actions, Vcl.ActnList, Data.DB;

type
  TfmeDTFDataSet = class(TfmeDTFBase)
    aclDataSet: TActionList;
    actNewAppend: TDataSetInsert;
    actDSDelete: TDataSetDelete;
    actDSSavePost: TDataSetPost;
    actDSCancel: TDataSetCancel;

    tlbDataSet: TToolBar;
    ToolButton11: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;

    dsDataSet: TDataSource;

    procedure actNewAppendExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
//    property NewButtonActiveControl: TControl
  end;

var
  fmeDTFDataSet: TfmeDTFDataSet;

implementation

{$R *.dfm}

uses DTF.Module.Resource;

procedure TfmeDTFDataSet.actNewAppendExecute(Sender: TObject);
begin
  if Assigned(TDataSetAction(Sender).DataSource)
    and Assigned(TDataSetAction(Sender).DataSource.DataSet) then
    TDataSetAction(Sender).DataSource.DataSet.Append;
end;

end.
