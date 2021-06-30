unit DTF.Config;

interface

uses
  Vcl.Forms, System.Types,
  uIniConfig,
  DTF.Service.Types;

type
  [IniFilename('config.ini')]
  TConfigService = class(TIniConfig, IDTFConfigService)
  private
    FWindowState: TWindowState;
    FWindowBounds: TRect;
  public
    [IniEnum('Window', Ord(wsNormal))]
    property WindowState: TWindowState read FWindowState write FWindowState;
    property WindowBounds: TRect read FWindowBounds write FWindowBounds;
  end;

  TUser = record
    Signed: Boolean;
    Name: string;
    Id: string;
  end;

var
  User: TUser;

implementation

const
  PASSWORD_EXPIRED_DAYS = 180;

{ TConfigService }

initialization

finalization

end.
