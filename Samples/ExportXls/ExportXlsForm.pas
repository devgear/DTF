unit ExportXlsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Vcl.StdCtrls,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    FDConnection: TFDConnection;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    qryMenuItems: TFDQuery;
    qryMenuItemsMENU_CODE: TWideStringField;
    qryMenuItemsMENU_NAME: TWideStringField;
    qryMenuItemsGROUP_NAME: TStringField;
    qryMenuItemsGROUP_CODE: TWideStringField;
    qryMenuItemsSORT_INDEX: TIntegerField;
    qryGroupLookup: TFDQuery;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  DTF.IO.Export;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  qryMenuItems.ExportToXls('D:\test.xlsx');
end;

end.
