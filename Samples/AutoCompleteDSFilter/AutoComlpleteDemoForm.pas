unit AutoComlpleteDemoForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, Vcl.WinXCalendars, Vcl.Mask,
  Vcl.Menus, Vcl.ExtCtrls;

type
  TfrmACDemo = class(TForm)
    Edit1: TEdit;
    FDMemTable1: TFDMemTable;
    procedure FormCreate(Sender: TObject);
  public
    procedure CreateDataSetFields;
    procedure GenerateDataSetValues;
  end;

var
  frmACDemo: TfrmACDemo;

implementation

{$R *.dfm}

uses DTF.Util.AutoComplete, DTF.Util.AutoCompleteForm, Unit2;

procedure TfrmACDemo.CreateDataSetFields;
begin
  FDMemTable1.FieldDefs.Add('menu_code', ftString, 255);
  FDMemTable1.FieldDefs.Add('menu_name', ftString, 255);
  FDMemTable1.FieldDefs.Add('cate', ftString, 255);
end;

procedure TfrmACDemo.GenerateDataSetValues;
begin
  FDMemTable1.Open;
  FDMemTable1.AppendRecord(['SYS1010', 'Menus', 'MNU']);
  FDMemTable1.AppendRecord(['SYS1020', 'Categories', 'MNU']);
  FDMemTable1.AppendRecord(['SYS2010', 'Log', 'LOG']);
  FDMemTable1.AppendRecord(['SYS2020', 'Log analysis', 'LOG']);

  FDMemTable1.AppendRecord(['USR1010', 'Users', 'USR']);
  FDMemTable1.AppendRecord(['USR1020', 'User persmission', 'USR']);

end;

procedure TfrmACDemo.FormCreate(Sender: TObject);
begin
  CreateDataSetFields;
  GenerateDataSetValues;

  FormStyle := fsNormal;
//  FormStyle := fsMDIForm;

  TAutoComplete.Setup(
    Self,
    Edit1,
    TAutoCompleteDSFilterAdapter.Create
      .SetDataSet(FDMemTable1)
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
