unit DTF.Core.Auth;

interface

uses
  System.Generics.Collections,
  DMX.DesignPattern,
  DTF.Core.AuthTypes;

type
  TAuthService = class(TSingleton<TAuthService>, IAuthorization<string>)
  private
    FAuthorization: IAuthorization<string>;
    function GetAllowList: TList<string>;
  public
    function IsAllow(AId: string): Boolean;

//    function Allows(A
//    property
  end;

implementation

{ TAuthService }

{ TAuthService }

function TAuthService.GetAllowList: TList<string>;
begin

end;

function TAuthService.IsAllow(AId: string): Boolean;
begin
  // Role

  // Privilege

  // 메뉴별 권한 확인 등

end;

end.
