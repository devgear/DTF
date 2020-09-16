unit SubForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmSub = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSub: TfrmSub;

implementation

{$R *.dfm}

procedure TfrmSub.FormCreate(Sender: TObject);
begin
  FormStyle := fsMDIChild;

  Caption := FormatDateTime('HH:NN:SS.ZZZ', Now);
end;

initialization
  RegisterClass(TfrmSub);
finalization

end.
