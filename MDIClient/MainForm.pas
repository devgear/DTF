unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.Tabs,
  Vcl.ComCtrls, Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
    MainMenu: TMainMenu;
    TabSet1: TTabSet;
    pnlMenu: TPanel;
    pnlMenuTop: TPanel;
    trvMenus: TTreeView;
    pnlShortCut: TPanel;
    lstFavorites: TListView;
    edtShortCut: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FormStyle := fsMDIForm;
end;

end.
