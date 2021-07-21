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
  public
    [EnumProp('Window')]
    property WindowState: TWindowState read FWindowState write FWindowState;
    [RecProp('Window', 'Left,Top,Right,Bottom')]
    property WindowBounds: TRect read FWindowBounds write FWindowBounds;

    [StrProp('Log', 'YYYYMMDD.log')]
    property LogFileFormat: string read FLogFileFormat write FLogFileFormat;
  end;

implementation

end.
