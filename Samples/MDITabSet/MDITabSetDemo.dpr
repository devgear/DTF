program MDITabSetDemo;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  SubForm in 'SubForm.pas' {frmSub};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
