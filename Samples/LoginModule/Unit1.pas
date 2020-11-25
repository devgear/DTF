unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  System.Hash;

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  Edit2.Text := THashSHA2.GetHashString(Edit1.Text, THashSHA2.TSHA2Version.SHA256);
end;

end.
