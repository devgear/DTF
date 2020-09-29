unit DTF.Core.Auth;

interface

uses
  System.SysUtils,
  System.Generics.Collections;

type
  IAuthService = interface;
  ISignInData = interface;
  ISignInResult = interface;

  IAuth = interface
    ['{F2DBCB38-3049-4E40-9072-794029E2FE76}']
    function GetAuthService: IAuthService;
    procedure SetAuthService(const AValue: IAuthService);
    property AuthService: IAuthService read GetAuthService write SetAuthService;

    function SignIn(AData: ISignInData): ISignInResult;
  end;

  IAuthService = interface
    ['{FD372895-644A-4D09-972E-81157FB3742F}']
    function SignIn(AData: ISignInData): ISignInResult;
  end;

  ISignInData = interface
    ['{5814944A-A543-4B73-AFC1-AEF6FD6CA882}']
  end;

  ISignInResult = interface
    ['{EE330BFF-15D7-4FCE-864C-0A9C8CD1C17D}']
  end;

  TDTFAuth = class(TInterfacedObject, IAuth)
  private
    FAuthService: IAuthService;
    function GetAuthService: IAuthService;
    procedure SetAuthService(const Value: IAuthService);
  public
    property AuthService: IAuthService read GetAuthService write SetAuthService;

    function SignIn(AData: ISignInData): ISignInResult;
  end;

implementation

{ TDTFAuth }

function TDTFAuth.GetAuthService: IAuthService;
begin
  if not Assigned(FAuthService) then
    raise Exception.Create('AuthService is empty.');

  Result := FAuthService;
end;

procedure TDTFAuth.SetAuthService(const Value: IAuthService);
begin
  FAuthService := Value;
end;

function TDTFAuth.SignIn(AData: ISignInData): ISignInResult;
begin
  Result := AuthService.SignIn(AData);
end;

end.
