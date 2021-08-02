unit DTF.Service.Auth;

interface

uses
  System.SysUtils,
  DTF.Service.Types;

type
  TAuthServiceProvider = class(TDTFServiceProvider, IDTFAuthService)
  protected
    function SignIn: Boolean; overload; virtual; abstract;
    function SignIn(ACredential: IDTFAuthCredential): Boolean; overload; virtual; abstract;
  end;

implementation

end.
