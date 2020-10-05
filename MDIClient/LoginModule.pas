unit LoginModule;

interface

uses
  System.SysUtils, System.Classes, DatabaseModule, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DTF.Core.AuthTypes,
  Environment;

type
  TdmLogin = class(TDataModule, IAuthService)
    qryLogin: TFDQuery;
    qryLoginUSER_SEQ: TIntegerField;
    qryLoginUSER_NAME: TWideStringField;
    qryLoginUSER_ID: TWideStringField;
    qryLoginUSER_ENC_PWD: TWideStringField;
    qryLoginPHONE_NO: TWideStringField;
    qryLoginEMAIL: TWideStringField;
    qryLoginPOSTCODE: TWideStringField;
    qryLoginADDRESS: TWideStringField;
    qryLoginLAST_PWD_UPDATED_AT: TSQLTimeStampField;
    qryLoginCREATED_AT: TSQLTimeStampField;
    qryLoginCREATED_USER: TIntegerField;
    qryLoginUPDATED_AT: TSQLTimeStampField;
    qryLoginUPDATED_USER: TIntegerField;
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
  System.Hash, System.DateUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmLogin }

function TdmLogin.SignIn(AId, APassword: string): TSignInResult;
var
  Pwd, EncPwd: string;
  LastUpdate: TDateTime;
  Period: Integer;
begin
  qryLogin.Close;
  qryLogin.ParamByName('USER_ID').AsString := AId;
  qryLogin.Open;

  if qryLogin.RecordCount = 0 then
    Exit(srNotFound);

  // 잘못된 비밀번호
  Pwd := qryLogin.FieldByName('USER_ENC_PWD').AsString;
  EncPwd := THashSHA2.GetHashString(APassword, THashSHA2.TSHA2Version.SHA256);
  if Pwd <> EncPwd then
    Exit(srIncorrectPassword);

  // 비밀번호 유효기간 확인
  LastUpdate := qryLogin.FieldByName('LAST_PWD_UPDATED_AT').AsDateTime;
  Period := Trunc(DaySpan(Now, LastUpdate));
  if Period >= Env.PasswordExpiredDays then
    Exit(srExpiredPassword);

  // 정상
  Result := srOk;
end;

end.
