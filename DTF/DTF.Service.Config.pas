unit DTF.Service.Config;

interface

uses
  DTF.Service.Types;

type
  TConfigLoader = class abstract
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
