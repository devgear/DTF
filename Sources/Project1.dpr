program Project1;

uses
  Vcl.Forms,
  MainForm in '..\Samples\MenuBilder\MainForm.pas' {Form1},
  DTF.Menu.Builder in 'DTF.Menu.Builder.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
