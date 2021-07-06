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
  DTF.App.Core,
  DTF.Service.Types,
  DTF.Config,
  MenuService;

type
  TApp = class(TAppCore<TApp>)
  private
    function GetConfigService: TConfig;
    function GetMenuService: TMenuService;
  protected
    procedure InitLoader; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property Config: TConfig read GetConfigService;
    property Menu: TMenuService read GetMenuService;
//    property Auth;
//    property View;

    // property Auth;
  end;

function App: TApp;

implementation

uses
  DTF.Logger.FileLog, DTF.Logger.ODS,
  DTF.Config.IniLoader;

function App: TApp;
begin
  Result := TApp.Instance;
end;

{ TApp }

procedure TApp.AfterConstruction;
begin
  inherited;

//  FConfigService := TConfigService.Create;
//
//  RegService(IDTFConfigService, TConfigService);

//  AddService()
end;

procedure TApp.BeforeDestruction;
begin
  inherited;

//  FConfigService.Free;
end;

function TApp.GetConfigService: TConfig;
begin
  Result := GetService(IDTFConfigService) as TConfig;
end;

function TApp.GetMenuService: TMenuService;
begin
  Result := GetService(IDTFMenuService) as TMenuService;
//  Result := ;
end;

procedure TApp.InitLoader;
var
  Logger: TFileLogger;
begin
  FServiceLoader.ServiceProvider[IDTFConfigService] := TConfig.Create({TIniConfigLoader.Create(Self, 'Config.ini')});

//  Logger := TFileLogger.Create;
//  Logger.FileFormat := 'YYYY-MM-DD.log';
//  FServiceLoader.ServiceProvider[IDTFLogService] := Logger;
  FServiceLoader.ServiceProvider[IDTFLogService] := TODSLogger.Create;
end;

initialization
//  App := TApp.Instance;

//  App.View;
finalization

end.
