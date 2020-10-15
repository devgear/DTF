unit DTF.Form.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmDTFBase = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TDTFFormClass = class of TfrmDTFBase;

var
  frmDTFBase: TfrmDTFBase;

implementation

{$R *.dfm}

procedure TfrmDTFBase.FormCreate(Sender: TObject);
begin
  KeyPreview := True;

//  Constraints.MinWidth := 1024;
//  Constraints.MinHeight := 768;
end;

procedure TfrmDTFBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    if Assigned(ActiveControl) then
      SelectNext(ActiveControl, True, True);
end;

end.
