unit DTF.Form.ChangePassword;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmDTFChangePwd = class(TForm)
    pnlTop: TPanel;
    pnlBottom: TPanel;
    pnlCotnet: TPanel;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDTFChangePwd: TfrmDTFChangePwd;

implementation

{$R *.dfm}

end.
