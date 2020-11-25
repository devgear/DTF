unit DTF.Form.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TDTFBaseForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  public
  end;

implementation

{$R *.dfm}

procedure TDTFBaseForm.FormCreate(Sender: TObject);
begin
  KeyPreview := True;
end;

procedure TDTFBaseForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    if Assigned(ActiveControl) then
      SelectNext(ActiveControl, True, True);
end;

end.
