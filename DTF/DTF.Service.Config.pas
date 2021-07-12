unit DTF.Service.Config;

interface

uses
  DTF.Service.Types;

type
  TConfigServiceProvider = class;

  TConfigLoader = class abstract
  protected
    FConfig: TConfigServiceProvider;
  public
    constructor Create(AConfig: TConfigServiceProvider);

    procedure Load; virtual; abstract;
    procedure Save; virtual; abstract;
  end;

  TConfigServiceProvider = class(TDTFServiceProvider, IDTFConfigService)
  private
    FLoader: TConfigLoader;
  public
    constructor Create(ALoader: TConfigLoader = nil);
    destructor Destroy; override;
  end;

implementation

uses
  DTF.Config.IniLoader;

{ TConfigLoader }

constructor TConfigLoader.Create(AConfig: TConfigServiceProvider);
begin
  FConfig := AConfig;
end;

{ TConfigServiceProvider }

constructor TConfigServiceProvider.Create(ALoader: TConfigLoader);
begin
  if not Assigned(ALoader) then
    ALoader := TIniConfigLoader.Create(Self);

  FLoader := ALoader;
end;

destructor TConfigServiceProvider.Destroy;
begin
  FLoader.Free;

  inherited;
end;

end.
