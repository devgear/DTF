unit Environment;

interface

uses
  System.IniFiles, Vcl.Forms, System.Types;

type
  TEnv = class
  private
    FIni: TIniFile;
    function GetWindowState: TWindowState;
    procedure SetWidowState(const Value: TWindowState);
    function GetWindowBounds: TRect;
    procedure SetWindowBounds(const Value: TRect);
    function GetPasswordExpiredDays: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    property WindowState: TWindowState read GetWindowState write SetWidowState;
    property WindowBounds: TRect read GetWindowBounds write SetWindowBounds;

    property PasswordExpiredDays: Integer read GetPasswordExpiredDays;
  end;

  TUser = record
    Signed: Boolean;
    Name: string;
  end;

function Env: TEnv;

var
  User: TUser;

implementation

const
  PASSWORD_EXPIRED_DAYS = 180;

var
  _Env: TEnv;

function Env: TEnv;
begin
  if not Assigned(_Env) then
    _Env := TEnv.Create;
  Result := _Env;
end;

{ TEnv }

constructor TEnv.Create;
begin
  FIni := TIniFile.Create('.\Env.ini');
end;

destructor TEnv.Destroy;
begin
  FIni.Free;

  inherited;
end;

function TEnv.GetWindowState: TWindowState;
begin
  Result := TWindowState(FIni.ReadInteger('Window', 'State', 0));
end;

function TEnv.GetPasswordExpiredDays: Integer;
begin
  Result := PASSWORD_EXPIRED_DAYS;
end;

function TEnv.GetWindowBounds: TRect;
begin
  Result.Top := FIni.ReadInteger('Window', 'Top', 0);
  Result.Left := FIni.ReadInteger('Window', 'Left', 0);
  Result.Width := FIni.ReadInteger('Window', 'Width', 1280);
  Result.Height := FIni.ReadInteger('Window', 'Height', 1024);
end;

procedure TEnv.SetWidowState(const Value: TWindowState);
begin
  FIni.WriteInteger('Window', 'State', Ord(Value));
end;

procedure TEnv.SetWindowBounds(const Value: TRect);
begin
  FIni.WriteInteger('Window', 'Top', Value.Top);
  FIni.WriteInteger('Window', 'Left', Value.Left);
  FIni.WriteInteger('Window', 'Width', Value.Width);
  FIni.WriteInteger('Window', 'Height', Value.Height);
end;

end.
