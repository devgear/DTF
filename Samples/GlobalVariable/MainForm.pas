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
    Button3: TButton;
    Button4: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses Environment, SubForm, Rtti;
type
  TMyEnum = (etOne, etTwo, etThree, etFour, etFive);
  TMySets = set of TMyEnum;

procedure TForm3.Button1Click(Sender: TObject);
begin
//  with TRttiSetType(TRttiContext.Create.GetType(TypeInfo(TMySets))).ElementType as TRttiOrdinalType do
//  begin
//    var I: Integer;
//    for I := MinValue to MaxValue do
//        Memo1.Lines.Add(GetEnumName(Handle, I));
//  end;
//
  Memo1.Lines.Clear;
  Memo1.Lines.Add(Format('Env.Id: %s',    [Env.UserId]));
  Memo1.Lines.Add(Format('EnvObj.Id: %s', [EnvObj.UserId]));
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  if EnvObj.WindowState = wsMinimized then
  begin
    ShowMessage('wow');
  end;

//  Form2 := TForm2.Create(Self);
//  Form2.Show;
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  EnvObj.WindowState := wsMaximized;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  EnvObj.WindowState := wsMinimized;
end;

end.
