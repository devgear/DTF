unit UserAuthTypes;

interface

uses DTF.Core.Auth;

type
  TSignInResultCode = (
    rcLoggined,           // 로그인 됨
    rcNotfoundId,         // 사용자를 찾을 수 없음
    rcInccrectPwd,        // 올바르지 않은 비밀번호
    rcExpiredPassword     // 유효기간이 지난 비밀번호
  );

  TUserSignInData = class(TInterfacedObject, ISignInData)
  private
    FId: string;
    FPassword: string;
  public
    property Id: string read FId write FId;
    property Password: string read FPassword write FPassword;
  end;

  TUserSignInResult = class(TInterfacedObject, ISignInResult)
  public
//    property Code: Integer read
  end;

function Auth: IAuth;

implementation

uses UserAuthModule;

var
  __Auth: IAuth;

function Auth: IAuth;
begin
  if not Assigned(__Auth) then
  begin
    __Auth := TDTFAuth.Create;
    __Auth.AuthService := dmUserAuth;
  end;
  Result := __Auth;
end;

initialization
finalization

end.
