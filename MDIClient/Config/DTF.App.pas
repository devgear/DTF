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
  DTF.Config, MenuService, DTF.Logger;

type
  TApp = class(TAppCore<TApp>)
  private
    FConfigService: TConfigService;
    FMenuService: TMenuService;
    function GetConfigService: TConfigService;
//    function GetConfigSvc<T: class>: T;
    function GetMenuService: TMenuService;
    function GetLogService: TLogService;
  protected
    procedure InitLoader; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property Config: TConfigService read GetConfigService;
    property Menu: TMenuService read GetMenuService;

    property Log: TLogService read GetLogService;
//    property ConfigEx: TConfigService read GetConfigSvc<TConfigService>;
//    property Auth;
//    property View;
//    property Log; // LogService // TLogger
  end;

var
  App: TApp;

implementation

uses
  DTF.Logger.FileLog;

{ TApp }

procedure TApp.AfterConstruction;
begin
  inherited;

  FConfigService := TConfigService.Create;

  RegService(IDTFConfigService, TConfigService);

//  AddService()
end;

procedure TApp.BeforeDestruction;
begin
  inherited;

  FConfigService.Free;
end;

function TApp.GetConfigService: TConfigService;
begin
//  Result := GetSevice(IDTFConfigService) as TConfigService;
  Result := FConfigService;
end;

function TApp.GetLogService: TLogService;
begin
//  Result := TFileLogger.Create;
end;

//function TApp.GetConfigSvc<T>: T;
//begin
//  Result :=
//end;

function TApp.GetMenuService: TMenuService;
begin
  Result := FMenuService;
end;

procedure TApp.InitLoader;
var
  Logger: TFileLogger;
begin
  //
//  App.Service['Logger'] := TFileLogger;
//  IDTFLogService, function: IDTFLogService
//  begin
//    Result := TFileLogger.Create;
//    Result.Dir := '';
//  end;
  Logger := TFileLogger.Create;
  Logger.FileFormat := 'YYYY-MM-DD.log';
  FServiceLoader.ServiceProvider[IDTFLogService] := Logger;
//  FServiceLoader.RegistServiceProvider(IDTFLogService, Logger);
end;

initialization
  App := TApp.Instance;
finalization

end.
