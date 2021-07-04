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
    function GetConfig: TConfigService;

//    class function ID: TGUID;
//    function GetInstance: IDTFService;
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

uses
  System.SysUtils;

const
  PASSWORD_EXPIRED_DAYS = 180;

{ TConfigService }

{ TConfigService }

function TConfigService.GetConfig: TConfigService;
begin
  Result := Self;
end;

//function TConfigService.GetInstance: IDTFService;
//var
//  Intf: IDTFService;
//begin
//  if Supports( then

//  Result := TConfigService.Create;
//end;
//
//function TConfigService.ID: TGUID;
//begin
//
//end;

initialization

finalization

end.
