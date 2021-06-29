unit DTF.App;

{
  How to use
    App.Config.UserId
    App.Logger.Log(ALog); // TLogger.Log

    App.Auth
    app.Perm

    App.Utils.Printer ??
    App.Utils.Export ??
}

interface

uses
  DTF.App.Base,
  DTF.Service.Types,
  DTF.Config, MenuService;

type
  TApp = class(TDTFApp<TApp>)
  private
    FConfigService: TConfigService;
    FMenuService: TMenuService;
    function GetConfigService: TConfigService;
  protected
    procedure Initialize; override;
    procedure Finalize; override;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  public
    constructor Create;
    destructor Destroy; override;

    property Config: TConfigService read FConfigService;
    property Menu: TMenuService read FMenuService;
  end;

var
  App: TApp;

implementation

{ TApp }

procedure TApp.AfterConstruction;
begin
  inherited;

  FConfigService := TConfigService.Create;
end;

procedure TApp.BeforeDestruction;
begin
  inherited;

  FConfigService.Free;
end;

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

end;

function TApp.GetConfigService: TConfigService;
begin

end;

procedure TApp.Initialize;
begin
  inherited;

end;

initialization
  App := TApp.Instance;
finalization

end.
