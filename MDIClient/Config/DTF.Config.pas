unit DTF.Config;

interface

uses
  DTF.Config.Types,
  DTF.Service.Config,
  Vcl.Forms, System.Types;

type
  [IniFilename('config.ini')]
  TConfig = class(TConfigServiceProvider)
  private
    FWindowState: TWindowState;
    FWindowBounds: TRect;
    FLogFileFormat: string;
    FInt: Integer;
  public
    [IntProp('Test', 10)]
    property Int: Integer read FInt write FInt;

    [IniEnum('Window', Ord(wsNormal))]
    property WindowState: TWindowState read FWindowState write FWindowState;
    [IniEnum('Window', Ord(wsNormal))]
    property WindowBounds: TRect read FWindowBounds write FWindowBounds;

    [IniString('Log', 'YYYYMMDD.log')]
    property LogFileFormat: string read FLogFileFormat write FLogFileFormat;
  end;

implementation

end.
