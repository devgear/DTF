unit LoginModule;

interface

uses
  System.SysUtils, System.Classes, DatabaseModule, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DTF.Core.AuthTypes;

type
  TdmLogin = class(TDataModule, IAuthService)
    qryLogin: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function SignIn(AId, APassword: string): TSignInResult;
  end;

var
  dmLogin: TdmLogin;

implementation

uses
  System.Hash;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmLogin }

function TdmLogin.SignIn(AId, APassword: string): TSignInResult;
var
  Pwd, EncPwd: string;
begin
  qryLogin.Close;
  qryLogin.ParamByName('USER_ID').AsString := AId;
  qryLogin.Open;

  if qryLogin.RecordCount = 0 then
    Exit(srNotFound);

  // 잘못된 비밀번호
  Pwd := qryLogin.FieldByName('user_password').AsString;
  EncPwd := THashSHA2.GetHashString(APassword, THashSHA2.TSHA2Version.SHA256);
  if Pwd <> EncPwd then
    Exit(srIncorrectPassword)

  // 비밀번호 유효기간 확인

  // 정상

end;

end.
