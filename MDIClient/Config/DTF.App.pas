unit DTF.App;

interface

uses
  DTF.App.Base,
  DTF.Service.Types,
  DTF.Config;

type
  TApp = class(TDTFApp<TApp>)
  private
    FConfigService: TConfigService;
  public
    constructor Create;
    destructor Destroy; override;

    property Config: TConfigService read FConfigService;
  end;

var
  App: TApp;

implementation

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
  App := TApp.Instance;
  App.Initialize;
finalization

end.
