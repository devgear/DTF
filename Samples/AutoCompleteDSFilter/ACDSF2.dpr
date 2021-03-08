program ACDSF2;

uses
  Vcl.Forms,
  MainForm2 in 'MainForm2.pas' {Form3},
  DTF.Util.AutoComplete in '..\..\DTF\DTF.Util.AutoComplete.pas',
  DTF.Util.AutoCompleteForm in '..\..\DTF\DTF.Util.AutoCompleteForm.pas' {frmAutoComplete};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
