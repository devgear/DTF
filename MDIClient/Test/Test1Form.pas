unit Test1Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Form.MDIChild, MenuTypes,
  Vcl.StdCtrls;

type
  TfrmTest1 = class(TDTFMDIChildForm)
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTest1: TfrmTest1;

implementation

{$R *.dfm}

uses
  DTF.Types;

initialization
  TMenuFactory.Instance.Regist('TST1010', TfrmTest1);
finalization

end.
