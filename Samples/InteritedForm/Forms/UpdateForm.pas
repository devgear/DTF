unit UpdateForm;

interface

uses
  DataSetForm,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, Vcl.Grids, Vcl.DBGrids, Vcl.DBActns, System.Actions,
  Vcl.ActnList, Vcl.BaseImageCollection, Vcl.ImageCollection, System.ImageList,
  Vcl.ImgList, Vcl.VirtualImageList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls,
  Vcl.Menus;

type
  TfrmUpdate = class(TfrmDTFDataSet)
    FDQuery1: TFDQuery;
    FDConnection1: TFDConnection;
    DBGrid2: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUpdate: TfrmUpdate;

implementation

{$R *.dfm}

end.
