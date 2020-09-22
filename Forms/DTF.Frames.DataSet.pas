unit DTF.Frames.DataSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Frames.Base, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.DBActns, System.Actions, Vcl.ActnList, Data.DB;

type
  TfmeDTFDataSet = class(TfmeDTFBase)
    aclDataSet: TActionList;
    actDSNewInsert: TDataSetInsert;
    actDSDelete: TDataSetDelete;
    actDSSavePost: TDataSetPost;
    actDSCancel: TDataSetCancel;
    tlbDataSet: TToolBar;
    ToolButton11: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    dsDataSet: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmeDTFDataSet: TfmeDTFDataSet;

implementation

{$R *.dfm}

uses DTF.Module.Resource;

end.
