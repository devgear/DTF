unit MainForm2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    qryMenuShortcut: TFDQuery;
    FDConnection: TFDConnection;
    Edit2: TEdit;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses DTF.Util.AutoComplete, DTF.Util.AutoCompleteForm;

procedure TForm3.FormCreate(Sender: TObject);
begin
  TAutoComplete.Setup(
    Self,
    Edit1,
    TACDataSetFilterAdapter.Create
      .SetDataSet(qryMenuShortcut)
      .SetListFields(['menu_name', 'menu_code', 'cate'])
      .SetKeyFields(['menu_code', 'menu_name'])
      .SetCompleteProc(
        procedure(Values: TArray<string>)
        begin
          ShowMessage(Values[0]);
        end)
  );

end;

end.
