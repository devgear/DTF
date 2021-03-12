unit MainForm2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, Vcl.WinXCalendars, Vcl.Mask, RzEdit,
  RzDBEdit, RzCmboBx, Vcl.Menus;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    qryMenuShortcut: TFDQuery;
    FDConnection: TFDConnection;
    Edit2: TEdit;
    Memo1: TMemo;
    CalendarPicker1: TCalendarPicker;
    ComboBox1: TComboBox;
    RzColorEdit1: TRzColorEdit;
    RzMaskEdit1: TRzMaskEdit;
    RzDBDateTimeEdit1: TRzDBDateTimeEdit;
    RzComboBox1: TRzComboBox;
    PopupMenu1: TPopupMenu;
    test1: TMenuItem;
    tst21: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses DTF.Util.AutoComplete, DTF.Util.AutoCompleteForm, Unit2;

procedure TForm3.Edit1Exit(Sender: TObject);
begin
  Memo1.Lines.Add('Edit1Exit');
end;

procedure TForm3.Edit2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Form2 := TForm2.Create(Self);
    FOrm2.Show;
  end;
end;

procedure TForm3.FormActivate(Sender: TObject);
begin
  OutputDebugString(PChar('TForm3.FormActivate'));

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  FormStyle := fsMDIForm;
//  FormStyle := fsNormal;

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

procedure TForm3.FormDeactivate(Sender: TObject);
begin
  OutputDebugString(PChar('TForm3.FormDeactivate'));
end;

end.
