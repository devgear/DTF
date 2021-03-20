program EnvironmentSample;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form3},
  Environment in 'Environment.pas',
  SubForm in 'SubForm.pas' {Form2},
  uIniConfig in '..\..\ThirdParty\CustomAttribute\uIniConfig.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
