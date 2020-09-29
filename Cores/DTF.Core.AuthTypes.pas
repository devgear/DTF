unit DTF.Core.AuthTypes;

interface

type
  TSignInResult = (srOk, srNotFound, srIncorrectPassword, srExpiredPassword);

  IAuthentication = interface
    ['{10D258F7-635D-44DB-A118-E9B5CDCECE63}']
  end;

  IAuthService = interface
    ['{3E668828-90B4-473A-ACD8-97985981498D}']

    function SignIn(AId, APassword: string): TSignInResult;
  end;

implementation

end.
