program InheritedForm;

uses
  Vcl.Forms,
  DataSetForm in 'Forms\DataSetForm.pas' {frmDTFDataSet},
  UpdateForm in 'Forms\UpdateForm.pas' {frmUpdate},
  BaseForm in 'Forms\BaseForm.pas' {frmDTFBase},
  ReadOnlyForm in 'Forms\ReadOnlyForm.pas' {frmReadOnly},
  MainForm in 'MainForm.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
