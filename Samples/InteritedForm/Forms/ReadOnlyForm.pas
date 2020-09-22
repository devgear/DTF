unit ReadOnlyForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataSetForm, Data.DB, Vcl.DBActns,
  System.Actions, Vcl.ActnList, Vcl.BaseImageCollection, Vcl.ImageCollection,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmReadOnly = class(TfrmDTFDataSet)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    DBGrid1: TDBGrid;
    procedure actPrintExecute(Sender: TObject);
    procedure actDownloadExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReadOnly: TfrmReadOnly;

implementation

{$R *.dfm}

procedure TfrmReadOnly.actDownloadExecute(Sender: TObject);
begin
  inherited;

  ShowMessage('Download');
end;

procedure TfrmReadOnly.actPrintExecute(Sender: TObject);
begin
  inherited;

  ShowMessage('Print');
end;

end.
