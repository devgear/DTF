unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections,
  Vcl.ExtCtrls, Vcl.StdCtrls, MenuFactory;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Form: TForm;
  FormClass: TFormClass;
begin
  FormClass := TMenuFactory.Instance.Find('sub1');
  if not Assigned(FormClass) then
    Exit;

  Form := TFormClass.Create(Self);
  Form.Parent := Panel1;
  Form.Align := alClient;
  Form.Show;
end;

end.
