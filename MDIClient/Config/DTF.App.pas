unit DTF.App;

interface

uses
  DTF.App.Core,
  DTF.Config;

type
  TApp = class(TAppCore<TApp>)
  private
    function GetConfigService: TConfig;
  protected
    procedure RegistCustomServices; override;
  public
    property Config: TConfig read GetConfigService;
  end;

function App: TApp;

implementation

uses
  DTF.Service.Types,

  DTF.Logger.FileLog, DTF.Logger.ODS,
  DTF.Config.IniLoader;

function App: TApp;
begin
  Result := TApp.Instance;
end;

{ TApp }

procedure TApp.RegistCustomServices;
begin
  inherited;

  Bind(IDTFConfigService, function: TDTFServiceProvider
    begin
      Result := TConfig.Create(TIniConfigLoader.Create);
    end);
end;

function TApp.GetConfigService: TConfig;
begin
  Result := GetService(IDTFConfigService) as TConfig;
end;

end.
