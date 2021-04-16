unit DTF.App;

interface

uses
  DTF.App.Base,
  DTF.Config;

type
  TApp = class(TDTFApp)
  private
    FConfigService: TConfigService;
  public
    constructor Create;
    destructor Destroy; override;

    property Config: TConfigService read FConfigService;
  end;

function App: TApp;

implementation

var
  _App: TApp = nil;

function App: TApp;
begin
  if not Assigned(_App) then
    _App := TApp.Create;
  Result := _App;
end;

{ TApp }

constructor TApp.Create;
begin
  FConfigService := TConfigService.Create;
end;

destructor TApp.Destroy;
begin
  FConfigService.Free;

  inherited;
end;

initialization
finalization
  if Assigned(_App) then
    _App.Free;

end.
