// Facade
unit DTF;

interface

uses
  DTF.Types,
  DTF.Core.Auth;

type
  TApp = class
  protected
    class var FAuthService: TAuthService;
  public
    class function Auth: TAuthService;
    { TODO : Loader / Injection Ã³¸® }
  end;

implementation

{ TApp }

class function TApp.Auth: TAuthService;
begin
  if Assigned(FAuthService) then
    Result := FAuthService
  else
    Result := TAuthService.Instance;
end;

end.
