unit UserModule;

interface

uses
  DTF.App,
  System.SysUtils, System.Classes, DatabaseModule, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmUser = class(TDataModule)
    qrySignin: TFDQuery;
    qrySigninUSER_SEQ: TIntegerField;
    qrySigninUSER_NAME: TWideStringField;
    qrySigninUSER_ID: TWideStringField;
    qrySigninUSER_ENC_PWD: TWideStringField;
    qrySigninPHONE_NO: TWideStringField;
    qrySigninEMAIL: TWideStringField;
    qrySigninPOSTCODE: TWideStringField;
    qrySigninADDRESS: TWideStringField;
    qrySigninLAST_PWD_UPDATED_AT: TSQLTimeStampField;
    qrySigninCREATED_AT: TSQLTimeStampField;
    qrySigninCREATED_USER: TIntegerField;
    qrySigninUPDATED_AT: TSQLTimeStampField;
    qrySigninUPDATED_USER: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
//    function SignIn(AId, APassword: string): TSignInResult;
  end;

var
  dmUser: TdmUser;

implementation

uses
  System.Hash, System.DateUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmLogin }

//function TdmUser.SignIn(AId, APassword: string): TSignInResult;
//var
//  Pwd, EncPwd: string;
//  LastUpdate: TDateTime;
//  Period: Integer;
//begin
//  qrySignin.Close;
//  qrySignin.ParamByName('USER_ID').AsString := AId;
//  qrySignin.Open;
//
//  if qrySignin.RecordCount = 0 then
//    Exit(srNotFound);
//
//  // 잘못된 비밀번호
//  Pwd := qrySignin.FieldByName('USER_ENC_PWD').AsString;
//  EncPwd := THashSHA2.GetHashString(APassword, THashSHA2.TSHA2Version.SHA256);
//  if Pwd <> EncPwd then
//    Exit(srIncorrectPassword);
//
//  // 비밀번호 유효기간 확인
//  LastUpdate := qrySignin.FieldByName('LAST_PWD_UPDATED_AT').AsDateTime;
//  Period := Trunc(DaySpan(Now, LastUpdate));
//  if Period >= App.Config.PasswordExpiredDays then
//    Exit(srExpiredPassword);
//
//  // 정상
//  Result := srOk;
//end;

end.
