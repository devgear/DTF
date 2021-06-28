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
    function GetConfigService: TConfigService;
  protected
    procedure Initialize; override;
    procedure Finalize; override;
  public
    constructor Create;
    destructor Destroy; override;

    property Config: TConfigService read GetConfigService;
  end;

var
  App: TApp;

implementation

{ TApp }

constructor TApp.Create;
begin
end;

destructor TApp.Destroy;
begin

  inherited;
end;

procedure TApp.Finalize;
begin
  inherited;

  FConfigService.Free;
end;

function TApp.GetConfigService: TConfigService;
begin

end;

procedure TApp.Initialize;
begin
  inherited;

  FConfigService := TConfigService.Create;
end;

initialization
  App := TApp.Instance;
finalization

end.
