// Facade
unit DTF.App;

interface

uses
  DTF.Types,
  DTF.Core.Auth;

type
  TCusotomApp = class
  protected
    class var FAuthService: TAuthService;
  public
//    class function Auth: TAuthService;
    class property Auth: TAuthService read FauthService;
    { TODO : Loader / Injection Ã³¸® }
  end;

implementation

{ TApp }

//class function TCusotomApp.Auth: TAuthService;
//begin
//  if Assigned(FAuthService) then
//    Result := FAuthService
//  else
//    Result := TAuthService.Instance;
//end;

end.
