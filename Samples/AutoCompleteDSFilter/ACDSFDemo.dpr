program ACDSFDemo;

uses
  Vcl.Forms,
  AutoComlpleteDemoForm in 'AutoComlpleteDemoForm.pas' {frmACDemo},
  DTF.Util.AutoComplete in '..\..\DTF\DTF.Util.AutoComplete.pas',
  DTF.Util.AutoCompleteForm in '..\..\DTF\DTF.Util.AutoCompleteForm.pas' {frmAutoComplete};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmACDemo, frmACDemo);
  Application.Run;
end.
