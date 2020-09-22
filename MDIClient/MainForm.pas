unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.Tabs,
  Vcl.ComCtrls, Vcl.StdCtrls, MenuFactory, Vcl.BaseImageCollection,
  Vcl.ImageCollection, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList;

type
  TfrmMain = class(TForm)
    MainMenu: TMainMenu;
    MDITabSet: TTabSet;
    pnlMenu: TPanel;
    pnlMenuTop: TPanel;
    trvMenus: TTreeView;
    pnlShortCut: TPanel;
    lstFavorites: TListView;
    edtShortCut: TEdit;
    F1: TMenuItem;
    X1: TMenuItem;
    pmnMDI: TPopupMenu;
    mnuMDIClose: TMenuItem;
    mnuMDICloseAll: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Splitter1: TSplitter;
    N3: TMenuItem;
    MDI1: TMenuItem;
    vilMenus: TVirtualImageList;
    imcMenus: TImageCollection;
    procedure FormCreate(Sender: TObject);
    procedure MDITabSetMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnuMDICloseClick(Sender: TObject);
    procedure mnuMDICloseAllClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure MDI1Click(Sender: TObject);
  private
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    function TabSetShortCut(AKey: Integer): Boolean;

    procedure ChildFormActivate(Sender: TObject);
    procedure ChildFormDestroy(Sender: TObject);

    procedure CreateMDIForm(AMenuId: string);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
var
  Group, Item: TTreeNode;
begin
  FormStyle := fsMDIForm;

  Constraints.MinWidth := 1024;
  Constraints.MinHeight := 768;

  Application.OnMessage := AppMessage;

  Group := trvMenus.Items.Add(nil, 'Group #1');
  Group.ImageIndex := 0;
  Item := trvMenus.Items.AddChild(Group,'Menu #1');
  Item.ImageIndex := 1;
  Item.SelectedIndex := 1;
  Item := trvMenus.Items.AddChild(Group,'Menu #1');
  Item.ImageIndex := 1;
  Item.SelectedIndex := 1;
  Item := trvMenus.Items.AddChild(Group,'Menu #1');
  Item.ImageIndex := 1;
  Item.SelectedIndex := 1;

  trvMenus.FullExpand;
//  Item := TTreeNode.Create(nil);
//  Item.Parent := Group;
//  Item.Text := 'Menu #1';
//  Item.

  // test
//  TMenuFactory.Instance.Regist('test', TfrmDTFMDIChild);
//  TMenuFactory.Instance.Regist('test', TfrmDTFDataset);
end;

procedure TfrmMain.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin
  if Assigned(ActiveMDIChild) and (Msg.message = WM_KEYDOWN) and (GetKeyState(VK_CONTROL) < 0) then
    Handled := TabSetShortCut(Msg.wParam);
end;

procedure TfrmMain.CreateMDIForm(AMenuId: string);
var
  Form: TDTFForm;
  FormClass: TDTFFormClass;
begin
  FormClass := TMenuFactory.Instance.Get(AMenuId);
  if not Assigned(FormClass) then
  begin
    ShowMessage(Format('해당 메뉴의 폼을 찾을 수 없습니다.(Menu Id: %s)', [AMenuId]));
    Exit
  end;

  Form := FormClass.Create(Self);
//  Form.Parent := Self;

  Form.OnMDIActivate := ChildFormActivate;
  Form.OnMDIDestroy := ChildFormDestroy;

  Form.WindowState := wsMaximized;
  Form.Show;

  MDITabSet.Tabs.AddObject(Form.Caption, Form);
  MDITabSet.TabIndex := MDITabSet.Tabs.Count - 1;
end;

{$REGION 'MDI Control'}
procedure TfrmMain.ChildFormActivate(Sender: TObject);
var
  I: Integer;
begin
  if not (csFreeNotification in TComponent(Sender).ComponentState) and (Sender is TForm) and (TForm(Sender).FormStyle = fsMDIChild) then
  begin
    for I := 0 to MDITabSet.Tabs.Count - 1 do
    begin
      if MDITabSet.Tabs.Objects[I] = Sender then
      begin
        MDITabSet.TabIndex := I;
        Exit;
      end;
    end;
  end;
end;

procedure TfrmMain.ChildFormDestroy(Sender: TObject);
var
  I: Integer;
begin
  if not (csDestroying in ComponentState) and (Sender is TForm) and (TForm(Sender).FormStyle = fsMDIChild) then
  begin
    for I := 0 to MDITabSet.Tabs.Count - 1 do
    begin
      if MDITabSet.Tabs.Objects[I] = Sender then
      begin
        MDITabSet.Tabs.Delete(I);

        if MDITabSet.Tabs.Count > I then
          TForm(MDITabSet.Tabs.Objects[I]).SetFocus;
        Exit;
      end;
    end;
  end;
end;

function TfrmMain.TabSetShortCut(AKey: Integer): Boolean;
var
  TabIndex: Integer;
begin
  Result := False;

  case AKey of
  VK_TAB:
    begin
      if GetKeyState(VK_SHIFT) < 0 then
        TabIndex := MDITabSet.TabIndex - 1
      else
        TabIndex := MDITabSet.TabIndex + 1;
      if TabIndex < 0 then
        TabIndex := MDIChildCount - 1
      else if TabIndex >= MDIChildCount then
        TabIndex := 0;

      MDITabSet.TabIndex := TabIndex;
      Result := True;
    end;
  Ord('1')..Ord('9'):
    begin
      AKey := AKey - Ord('1');
      if MDIChildCount > AKey then
        MDITabSet.TabIndex := AKey;
      Result := True;
    end;
  Ord('w'), Ord('W'):
    begin
      ActiveMDIChild.Close;
    end;
  end;
end;

procedure TfrmMain.MDI1Click(Sender: TObject);
begin
  CreateMDIForm('SYS1010');
end;

procedure TfrmMain.MDITabSetMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Idx: Integer;
begin
  if Button <> mbRight then
    Exit;

  Idx := MDITabSet.ItemAtPos(TPoint.Create(X, Y));

  if Idx >= 0 then
  begin
    MDITabSet.TabIndex := Idx;
    pmnMDI.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  end;
end;

procedure TfrmMain.mnuMDICloseAllClick(Sender: TObject);
var
  I: Integer;
begin
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].Close;
end;

procedure TfrmMain.mnuMDICloseClick(Sender: TObject);
begin
  ActiveMDIChild.Close;
end;
procedure TfrmMain.N2Click(Sender: TObject);
begin
  //
  CreateMDIForm('test');
end;

procedure TfrmMain.N3Click(Sender: TObject);
begin
  CreateMDIForm('test');
end;

{$ENDREGION}
end.
