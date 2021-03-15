unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections,
  Vcl.ExtCtrls, Vcl.StdCtrls, ViewFactory, Vcl.Menus;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Createsubform1: TMenuItem;
    Createsub2form1: TMenuItem;
    procedure Createsubform1Click(Sender: TObject);
    procedure Createsub2form1Click(Sender: TObject);
  private
    { Private declarations }
    procedure CreateMDIForm(AId: string);
  public
    { Public declarations }
  end;


var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.CreateMDIForm(AId: string);
var
  Form: TForm;
  FormClass: TFormClass;
begin
  FormClass := TViewFactory.Instance.GetClass(AId);
  if not Assigned(FormClass) then
    Exit;

  Form := FormClass.Create(Self);
  Form.FormStyle := fsMDIChild;
  Form.Show;
end;

procedure TForm1.Createsub2form1Click(Sender: TObject);
begin
  CreateMDIForm('sub1');
end;

procedure TForm1.Createsubform1Click(Sender: TObject);
begin
  CreateMDIForm('sub2');
end;

end.
