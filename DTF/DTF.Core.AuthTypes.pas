unit DTF.Core.AuthTypes;

interface

type
  TSignInResult = (srOk, srNotFound, srShortPassword, srIncorrectPassword, srExpiredPassword);

  IAuthentication = interface
    ['{10D258F7-635D-44DB-A118-E9B5CDCECE63}']
  end;

  IAuthorization = interface
    ['{650F6FFE-23EF-4656-B075-D046BD5087FB}']
  end;

implementation

end.
