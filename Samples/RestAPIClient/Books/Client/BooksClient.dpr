program BooksClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  BooksModule in 'Modules\BooksModule.pas' {dmDataAccess: TDataModule},
  MainForm in 'Forms\MainForm.pas' {Form1},
  BooksRepository in 'Repositories\BooksRepository.pas',
  BooksRestApi in 'Apis\BooksRestApi.pas',
  DTF.DAO in '..\..\..\..\Sources\Core\DTF.DAO.pas',
  DTF.DAO.Rest in '..\..\..\..\Sources\Core\DTF.DAO.Rest.pas',
  DTF.Repository in '..\..\..\..\Sources\Core\DTF.Repository.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
