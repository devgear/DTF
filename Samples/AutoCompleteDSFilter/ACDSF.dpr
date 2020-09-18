program ACDSF;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  AutoCompleteForm in 'AutoCompleteForm.pas' {frmAutoComplete};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
