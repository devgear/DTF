unit DTF.Form.DataSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Form.MDIChild, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.DBActns, System.Actions, Vcl.ActnList, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmDTFDataSet = class(TfrmDTFMDIChild)
    tlbDataSet: TToolBar;
    ToolButton11: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    pnlMain: TPanel;
    dsDataSet: TDataSource;
    aclDataSet: TActionList;
    actDSNewInsert: TDataSetInsert;
    actDSDelete: TDataSetDelete;
    actDSSavePost: TDataSetPost;
    actDSCancel: TDataSetCancel;
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

uses DTF.Module.Resource;

end.
