unit UserAuthModule;

interface

uses
  UserAuthTypes,
  System.SysUtils, System.Classes, DTF.Core.Auth, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmUserAuth = class(TDataModule, IAuthService)
    FDConnection1: TFDConnection;
    qrySignIn: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function SignIn(AData: ISignInData): ISignInResult;
  end;

var
  dmUserAuth: TdmUserAuth;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule2 }

function TdmUserAuth.SignIn(AData: ISignInData): ISignInResult;
begin

end;

end.
