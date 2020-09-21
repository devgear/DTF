unit DataSetForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBActns, System.Actions,
  Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.BaseImageCollection,
  Vcl.ImageCollection, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.ExtCtrls, Vcl.Menus, BaseForm;

type
  TfrmDTFDataSet = class(TfrmDTFBase)
    VirtualImageList1: TVirtualImageList;
    ImageCollection1: TImageCollection;
    aclMain: TActionList;
    actDSNewInsert: TDataSetInsert;
    actDSDelete: TDataSetDelete;
    actDSSavePost: TDataSetPost;
    actDSCancel: TDataSetCancel;
    dsMain: TDataSource;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    ToolBar2: TToolBar;
    ToolButton11: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    actPrint: TAction;
    actDownload: TAction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDTFDataSet: TfrmDTFDataSet;

implementation

{$R *.dfm}

end.
