program MenuBilderDemo;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  DTF.Builder.Factory in '..\..\Sources\DTF.Builder.Factory.pas',
  Sub1Form in 'Sub1Form.pas' {frmSub1},
  MenuFactory in 'MenuFactory.pas',
  Sub2Form in 'Sub2Form.pas' {frmSub2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmSub2, frmSub2);
  Application.Run;
end.
