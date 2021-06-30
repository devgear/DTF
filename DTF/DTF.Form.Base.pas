unit DTF.Form.Base;

interface

uses
  DTF.Intf,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  System.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TDTFBaseForm = class(TForm, IDTFSetSearchControl)
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FOrgCaption: string;
    FSearchCtrls: TDictionary<TControl, TProc>;
    function GetSimpleCaption: string;

    procedure SetSearchControl(AControl: TControl; ASearchProc: TProc);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetViewId: string;

    property SimpleCaption: string read GetSimpleCaption;
  end;

implementation

uses
  System.Rtti, DTF.Types.View;

{$R *.dfm}

constructor TDTFBaseForm.Create(AOwner: TComponent);
begin
  inherited;

  KeyPreview := True;
  FOrgCaption := Caption;
  Caption := Format('%s | %s', [GetViewId, Caption]);
end;

destructor TDTFBaseForm.Destroy;
begin
  if Assigned(FSearchCtrls) then
    FSearchCtrls.Free;

  inherited;
end;

procedure TDTFBaseForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  SearchProc: TProc;
begin
  if Key = VK_RETURN then
  begin
    if Assigned(ActiveControl) then
    begin
      if Assigned(FSearchCtrls) and FSearchCtrls.TryGetValue(ActiveControl, SearchProc) then
        SearchProc
      else
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
  // Using ViewIdAttribute
  LCtx := TRttiContext.Create;
  try
    LType := LCtx.GetType(Self);
    for LAttr in LType.GetAttributes() do
      if LAttr is ViewIdAttribute then
        Exit(ViewIdAttribute(LAttr).ViewId);
  finally
    LCtx.Free;
  end;

  // Classname
  ClsName := ClassName;
  if ClsName.StartsWith('Tfrm') then
    Exit(ClsName.Substring(5, ClsName.Length).ToUpper);

  Result := ClsName.Substring(2, ClsName.Length).ToUpper;
end;

procedure TDTFBaseForm.SetSearchControl(AControl: TControl; ASearchProc: TProc);
begin
  if not Assigned(FSearchCtrls) then
    FSearchCtrls := TDictionary<TControl, TProc>.Create;
  FSearchCtrls.Add(AControl, ASearchProc);
end;

end.
