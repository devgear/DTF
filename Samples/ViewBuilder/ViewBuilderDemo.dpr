program ViewBuilderDemo;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  Sub1Form in 'Sub1Form.pas' {frmSub1},
  ViewFactory in 'ViewFactory.pas',
  Sub2Form in 'Sub2Form.pas' {frmSub2},
  DMX.DesignPattern in '..\..\ThirdParty\DMX\DMX.DesignPattern.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmSub2, frmSub2);
  Application.Run;
end.
