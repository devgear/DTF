unit Sub1Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MenuFactory;

type
  TfrmSub1 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSub1: TfrmSub1;

implementation

{$R *.dfm}

uses DTF.Builder.Factory;

initialization
  TMenuFactory.Instance.Regist('sub1', TfrmSub1);
finalization

end.
