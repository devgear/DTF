unit DTF.Form.UserLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmUserLogin = class(TForm)
    pnlTop: TPanel;
    pnlContent: TPanel;
    pnlBottom: TPanel;
    btnLogin: TButton;
    btnCancel: TButton;
    edtId: TEdit;
    edtPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    chkSaveId: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUserLogin: TfrmUserLogin;

implementation

{$R *.dfm}

end.
