unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDQuery1EMP_NO: TSmallintField;
    FDQuery1FIRST_NAME: TStringField;
    FDQuery1LAST_NAME: TStringField;
    FDQuery1PHONE_EXT: TStringField;
    FDQuery1HIRE_DATE: TSQLTimeStampField;
    FDQuery1DEPT_NO: TStringField;
    FDQuery1JOB_CODE: TStringField;
    FDQuery1JOB_GRADE: TSmallintField;
    FDQuery1JOB_COUNTRY: TStringField;
    FDQuery1SALARY: TFMTBCDField;
    FDQuery1FULL_NAME: TStringField;
    Button1: TButton;
    Label1: TLabel;
    Panel1: TPanel;
    ComboBox1: TComboBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses AutoCompleteForm;

procedure TForm1.AppMessage(var Msg: TMsg; var Handled: Boolean);
var
  Cntl: TWinControl;
begin
//  Msg.

  if Msg.message = WM_LBUTTONDOWN then
  begin
    if ActiveControl <> nil then
    begin
      Cntl := FindControl(Msg.hwnd);
      OutputDebugString(PChar('WM_LBUTTONDOWN - ' + ActiveControl.Name + ' / ' + Cntl.Name));
      ActiveControl.Perform(CM_CANCELMODE, 0, Winapi.Windows.LPARAM(Cntl));
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Text := '';
  FormStyle := fsMDIForm;
  Application.OnMessage := AppMessage;

  TfrmAutoComplete.Setup(
    Self,
    Edit1,
    FDQuery1,
      ['FIRST_NAME', 'LAST_NAME', 'JOB_COUNTRY'],
      ['FIRST_NAME']);


end;

end.
