unit DTF.Config;

interface

uses
  System.IniFiles, Vcl.Forms, System.Types;

type
  TConfigService = class
  private
    FIni: TIniFile;
    function GetWindowState: TWindowState;
    procedure SetWidowState(const Value: TWindowState);
    function GetWindowBounds: TRect;
    procedure SetWindowBounds(const Value: TRect);
    function GetPasswordExpiredDays: Integer;
    function GetUseSignUp: Boolean;
    function GetSavedUserId: string;
    procedure SetSavedUserId(const Value: string);
    function GetUserIdSave: Boolean;
    procedure SetUserIdSave(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    property WindowState: TWindowState read GetWindowState write SetWidowState;
    property WindowBounds: TRect read GetWindowBounds write SetWindowBounds;

    property SavedUserId: string read GetSavedUserId write SetSavedUserId;
    property UserIdSave: Boolean read GetUserIdSave write SetUserIdSave;

    property PasswordExpiredDays: Integer read GetPasswordExpiredDays;
    property UseSignup: Boolean read GetUseSignUp;
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

constructor TConfigService.Create;
begin
  FIni := TIniFile.Create('.\Config.ini');
end;

destructor TConfigService.Destroy;
begin
  FIni.Free;

  inherited;
end;

function TConfigService.GetWindowState: TWindowState;
begin
  Result := TWindowState(FIni.ReadInteger('Window', 'State', 0));
end;

function TConfigService.GetPasswordExpiredDays: Integer;
begin
  Result := PASSWORD_EXPIRED_DAYS;
end;

function TConfigService.GetSavedUserId: string;
begin
  Result := FIni.ReadString('Login', 'UserId', '');
end;

function TConfigService.GetUserIdSave: Boolean;
begin
  Result := FIni.ReadBool('Login', 'SaveUserId', False);
end;

function TConfigService.GetUseSignUp: Boolean;
begin
//  Result := False;
  Result := True;
end;

function TConfigService.GetWindowBounds: TRect;
begin
  Result.Top := FIni.ReadInteger('Window', 'Top', 0);
  Result.Left := FIni.ReadInteger('Window', 'Left', 0);
  Result.Width := FIni.ReadInteger('Window', 'Width', 1280);
  Result.Height := FIni.ReadInteger('Window', 'Height', 1024);
end;

procedure TConfigService.SetSavedUserId(const Value: string);
begin
  FIni.WriteString('Login', 'UserId', Value);
end;

procedure TConfigService.SetUserIdSave(const Value: Boolean);
begin
  FIni.WriteBool('Login', 'SaveUserId', Value);
end;

procedure TConfigService.SetWidowState(const Value: TWindowState);
begin
  FIni.WriteInteger('Window', 'State', Ord(Value));
end;

procedure TConfigService.SetWindowBounds(const Value: TRect);
begin
  FIni.WriteInteger('Window', 'Top', Value.Top);
  FIni.WriteInteger('Window', 'Left', Value.Left);
  FIni.WriteInteger('Window', 'Width', Value.Width);
  FIni.WriteInteger('Window', 'Height', Value.Height);
end;

end.
