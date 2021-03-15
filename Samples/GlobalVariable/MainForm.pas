unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses Environment, SubForm;

procedure TForm3.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  Memo1.Lines.Add(Format('Env.Id: %s',    [Env.UserId]));
  Memo1.Lines.Add(Format('EnvObj.Id: %s', [EnvObj.UserId]));
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  Form2 := TForm2.Create(Self);
  Form2.Show;
end;

end.
