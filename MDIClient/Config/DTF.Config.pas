unit DTF.Config;

interface

uses
  DTF.Service.Config,
  Vcl.Forms, System.Types;

type
  [IniFilename('config.ini')]
  TConfig = class(TConfigServiceProvider)
  private
    FWindowState: TWindowState;
    FWindowBounds: TRect;
    FLogFileFormat: string;
  public
    [IniEnum('Window', Ord(wsNormal))]
    property WindowState: TWindowState read FWindowState write FWindowState;
    property WindowBounds: TRect read FWindowBounds write FWindowBounds;

    [IniString('Log', 'YYYYMMDD.log')]
    property LogFileFormat: string read FLogFileFormat write FLogFileFormat;
  end;

implementation

end.
