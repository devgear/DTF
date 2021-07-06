unit DTF.Config.IniLoader;

interface

uses
  DTF.Service.Config,
  uIniConfig;

type
  TIniConfigLoader = class(TConfigLoader)
  private
    FIniConfig: TIniConfig; // TIniConfigAttrLoader
  public
    constructor Create(const ATarget: TObject; const AIniFilename: string = '');
    destructor Destroy; override;
  end;

implementation

{ TIniConfigLoader }

constructor TIniConfigLoader.Create(const ATarget: TObject; const AIniFilename: string);
begin
  FIniConfig := TIniConfig.Create(ATarget, AIniFilename);
end;

destructor TIniConfigLoader.Destroy;
begin
  FIniConfig.Free;

  inherited;
end;

end.
