unit SignInForm;

interface

uses
  DTF.App,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Form.Base, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TfrmSignIn = class(TDTFBaseForm)
    Panel3: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtUserId: TEdit;
    edtPassword: TEdit;
    chkUserIdSave: TCheckBox;
    Panel1: TPanel;
    Panel2: TPanel;
    btnLogin: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ExecSignIn: Boolean;

implementation

{$R *.dfm}

uses DTF.Core.AuthTypes, UserModule;

function ExecSignIn: Boolean;
var
  Form: TfrmSignIn;
begin
  Form := TfrmSignIn.Create(nil);
  Form.ShowModal;
  Form.Free;

//  Result := User.Signed;
end;

procedure TfrmSignIn.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSignIn.btnLoginClick(Sender: TObject);
const
  PASSWORD_VALIDCHECK_MINLEN = 8;
var
  SigninResult: TSignInResult;
begin
  if edtUserId.Text = '' then
  begin
    ShowMessage('아이디를 입력하세요.');
    edtUserId.SetFocus;
    Exit;
  end;

  if edtPassword.Text = '' then
  begin
    ShowMessage('비밀번호를 입력하세요.');
    edtPassword.SetFocus;
    Exit;
  end;

  SigninResult := dmUser.SignIn(edtUserId.Text, edtPassword.Text);

  if SigninResult = srShortPassword then
  begin
    ShowMessage(Format('비밀번호 정책이 맞지 않습니다.'#13#10 +
      '  국가정보보안 기본지침 제76조(비밀번호관리)에 근거'#13#10 +
      '  비밀번호를 숫자, 영문자, 특수문자 포함 %d자리이상 권고사항임', [PASSWORD_VALIDCHECK_MINLEN]));
//    ShowChangePasswordForm(edtSabun.Text);
    Exit;
  end;

  if SigninResult = srExpiredPassword then
  begin
    ShowMessage('비밀번호를 180일 이상 변경하지 않았습니다. 새로운 비밀번호로 변경해 주세요.');
//    ShowChangePasswordForm(edtSabun.Text);
    Exit;
  end;

  if SigninResult <> srOK then
  begin
    ShowMessage('아이디 또는 비밀번호가 잘못되었습니다');
    edtPassword.Clear;
    edtUserId.SetFocus;
    Exit;
  end;

//  User.Signed := True;
//  User.Name := '';
//  User.Id := edtUserId.Text;

  // [로그인 정보 저장] 환경파일에 저장
  if chkUserIdSave.Checked then
    App.Config.SavedUserId := edtUserId.Text;
  App.Config.UserIdSave := chkUserIdSave.Checked;

  Close;
end;

procedure TfrmSignIn.FormShow(Sender: TObject);
begin
  if App.Config.UserIdSave then
  begin
    edtUserId.Text := App.Config.SavedUserId;
    chkUserIdSave.Checked := True;
    edtPassword.SetFocus;
  end
  else
  begin
    edtUserId.SetFocus;
  end;
end;

end.
