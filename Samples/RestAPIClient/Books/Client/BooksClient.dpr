program BooksClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  BooksModule in 'Modules\BooksModule.pas' {dmDataAccess: TDataModule},
  BooksForm in 'Forms\BooksForm.pas' {frmBooks},
  BooksRepository in 'Repositories\BooksRepository.pas',
  BooksRestApi in 'Apis\BooksRestApi.pas',
  DTF.DAO in '..\..\..\..\Sources\Core\DTF.DAO.pas',
  DTF.DAO.Rest in '..\..\..\..\Sources\Core\DTF.DAO.Rest.pas',
  DTF.Repository in '..\..\..\..\Sources\Core\DTF.Repository.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBooks, frmBooks);
  Application.Run;
end.
