unit DTF.Config;

interface

uses
  Vcl.Forms, System.Types,
  DTF.Service.Types,
  uIniConfig;

type
  [IniFilename('config.ini')]
  TConfigService = class(TIniConfig, IDTFService)
  private
    FWindowState: TWindowState;
    FWindowBounds: TRect;
    procedure Load;
    procedure Unload;

    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
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

procedure TConfigService.Load;
begin

end;

function TConfigService.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
end;

procedure TConfigService.Unload;
begin

end;

function TConfigService._AddRef: Integer;
begin

end;

function TConfigService._Release: Integer;
begin

end;

end.
