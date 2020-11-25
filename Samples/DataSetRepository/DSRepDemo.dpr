program DSRepDemo;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  DTF.Data.DataSetRepository in 'DTF.Data.DataSetRepository.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
