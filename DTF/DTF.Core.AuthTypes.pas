unit DTF.Core.AuthTypes;

interface

uses
  System.Generics.Collections;

type
  TSignInResult = (srOk, srNotFound, srShortPassword, srIncorrectPassword, srExpiredPassword);

  IAuthentication = interface
    ['{10D258F7-635D-44DB-A118-E9B5CDCECE63}']
  end;

  // 사용해야 하는가?
  IAuthorization<T> = interface
    ['{650F6FFE-23EF-4656-B075-D046BD5087FB}']
    function IsAllow(AId: T): Boolean;
    function GetAllowList: TList<T>;
    property AllowList: TList<T> read GetAllowList;
  end;

implementation

end.
