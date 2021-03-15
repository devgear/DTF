unit SubForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
//  UserId: string;

implementation

{$R *.dfm}

uses Environment;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Env.UserId := Edit1.Text;
  EnvObj.UserId := Edit1.Text;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  Memo1.Lines.Add(Format('Env.Id: %s',    [Env.UserId]));
  Memo1.Lines.Add(Format('EnvObj.Id: %s', [EnvObj.UserId]));
end;

end.
