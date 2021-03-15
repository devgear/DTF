unit Sub2Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmSub2 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSub2: TfrmSub2;

implementation

{$R *.dfm}

uses ViewFactory;

initialization
  TViewFactory.Instance.Regist('sub2', TfrmSub2);
finalization

end.
