unit DTF.Auth;

interface

uses
  System.Generics.Collections,
  DMX.DesignPattern;

type
  TAuthService = class(TSingleton<TAuthService>)
  private
//    FAuthorization: IAuthorization<string>;
    function GetAllowList: TList<string>;
  public
    function IsAllowRead(AMenuCode: string): Boolean;

//    function Allows(A
//    property
  end;

implementation

{ TAuthService }

function TAuthService.GetAllowList: TList<string>;
begin

end;

function TAuthService.IsAllowRead(AMenuCode: string): Boolean;
begin
end;

end.
