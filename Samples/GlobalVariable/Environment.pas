unit Environment;

interface

uses
  System.IniFiles;

type
  // 레코드를 이용, 단순 데이터 사용(휘발성)
  TUserInfo = record
    UserId,
    Name: string;
  end;
  TEnv = record
    UserId: string;
    ShopCode: string;
    User: TUserInfo;
  end;

  // 객체 이용, 환경파일 저장 등(지속적 사용)
  TEnvObj = class
  private
    FIni: TIniFile;

    FUserId: string;
    function GetUserId: string;
    procedure SetUserId(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    property UserId: string read GetUserId write SetUserId;
  end;

// 전역변수 사용 시 그룹
var
  Env: TEnv;
//  UserId: string;
//  UserName: string;

// Sigleton patterun
function EnvObj: TEnvObj;

implementation

var
  _EnvObj: TEnvObj;

function EnvObj: TEnvObj;
begin
  if not Assigned(_EnvObj) then
    _EnvObj := TEnvObj.Create;
  Result := _EnvObj;
end;

{ TEnvObj }

constructor TEnvObj.Create;
begin
  FIni := TIniFile.Create('.\Env.ini');
  FUserId := FIni.ReadString('User', 'Id', '');
end;

destructor TEnvObj.Destroy;
begin
  FIni.WriteString('User', 'Id', FUserId);

  FIni.Free;

  inherited;
end;

function TEnvObj.GetUserId: string;
begin
  Result := FUserId;
end;

procedure TEnvObj.SetUserId(const Value: string);
begin
  FUserId := Value;
end;

initialization
finalization
  if Assigned(_EnvObj) then
    _EnvObj.Free;

end.
