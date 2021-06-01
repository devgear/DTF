unit DTF.Form.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TDTFBaseForm = class(TForm)
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FOrgCaption: string;
    function GetSimpleCaption: string;
  public
    constructor Create(AOwner: TComponent); override;

    class function GetViewId: string;
    property SimpleCaption: string read GetSimpleCaption;
  end;

implementation

uses
  System.Rtti, DTF.Types;

{$R *.dfm}

constructor TDTFBaseForm.Create(AOwner: TComponent);
begin
  inherited;

  KeyPreview := True;
  FOrgCaption := Caption;
  Caption := Format('%s | %s', [GetViewId, Caption]);
end;

procedure TDTFBaseForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    if Assigned(ActiveControl) then
    begin
      if (ActiveControl.ClassName = 'TSearchBox') then
        Exit;

      SelectNext(ActiveControl, True, True);
    end;
  end;
end;

function TDTFBaseForm.GetSimpleCaption: string;
begin
  Result := FOrgCaption;
end;

class function TDTFBaseForm.GetViewId: string;
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LAttr: TCustomAttribute;
  ClsName: string;
begin
  // Attribute
  LCtx := TRttiContext.Create;

  LType := LCtx.GetType(Self);
  for LAttr in LType.GetAttributes() do
    if LAttr is ViewIdAttribute then
      Exit(ViewIdAttribute(LAttr).ViewId);

  // Classname
  ClsName := ClassName;
  if ClsName.StartsWith('Tfrm') then
    Exit(ClsName.Substring(5, ClsName.Length).ToUpper);

  Result := ClsName.Substring(2, ClsName.Length).ToUpper;
end;

end.
