unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.Menus;

type
  TfrmMain = class(TForm)
    tbMainMenu: TToolBar;
    pnlLayout: TPanel;
    btnMenuRent: TToolButton;
    btnMenuBook: TToolButton;
    btnMenuUser: TToolButton;
    ToolButton4: TToolButton;
    btnMenuClose: TToolButton;
    ilToolbar: TImageList;
    MainMenu1: TMainMenu;
    F1: TMenuItem;
    C1: TMenuItem;
    F2: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    StyleMenu: TMenuItem;
    procedure btnMenuCloseClick(Sender: TObject);
    procedure btnMenuBookClick(Sender: TObject);
    procedure btnMenuUserClick(Sender: TObject);
    procedure btnMenuRentClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure StyleClick(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  BookForm, UserForm, RentForm, Vcl.Themes;

procedure TfrmMain.btnMenuBookClick(Sender: TObject);
begin
  if not Assigned(frmBook) then
    frmBook := TfrmBook.Create(Self);
  frmBook.Parent := pnlLayout;
  frmBook.BorderStyle := bsNone;
  frmBook.Align := alClient;
  frmBook.Show;
end;

procedure TfrmMain.btnMenuCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnMenuRentClick(Sender: TObject);
begin
  if not Assigned(frmRent) then
    frmRent := TfrmRent.Create(Self);
  frmRent.Parent := pnlLayout;
  frmRent.BorderStyle := bsNone;
  frmRent.Align := alClient;
  frmRent.Show;
end;

procedure TfrmMain.btnMenuUserClick(Sender: TObject);
begin
  if not Assigned(frmUser) then
    frmUser := TfrmUser.Create(Self);
  frmUser.Parent := pnlLayout;
  frmUser.BorderStyle := bsNone;
  frmUser.Align := alClient;
  frmUser.Show;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  Style: String;
  Item: TMenuItem;
begin
  for Style in TStyleManager.StyleNames do
  begin
    Item := TMenuItem.Create(StyleMenu);
    Item.Caption := Style;
    Item.OnClick := StyleClick;
    if TStyleManager.ActiveStyle.Name = Style then
      Item.Checked := true;
    StyleMenu.Add(Item);
  end;
end;

procedure TfrmMain.StyleClick(Sender: TObject);
var
  StyleName: String;
  i: Integer;
begin
  //get style name
  StyleName := StringReplace(TMenuItem(Sender).Caption, '&', '',
    [rfReplaceAll, rfIgnoreCase]);
  //set active style
  TStyleManager.SetStyle(StyleName);
  //check the currently selected menu item
  (Sender as TMenuItem).Checked := true;
  //uncheck all other style menu items
  for I := 0 to StyleMenu.Count -1 do begin
    if not StyleMenu.Items[i].Equals(Sender) then
      StyleMenu.Items[i].Checked := false;
  end;
end;

end.
