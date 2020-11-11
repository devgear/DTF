program ExportDataSetToXls;

uses
  Vcl.Forms,
  ExportXlsForm in 'ExportXlsForm.pas' {Form1},
  DTF.IO.Export in '..\..\DTF\DTF.IO.Export.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
