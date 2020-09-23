unit MainForm;

interface

uses
  MenuTypes,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.Tabs,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.BaseImageCollection, Vcl.ImageCollection,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.ToolWin,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

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
    Label1: TLabel;
    Panel4: TPanel;
    Panel1: TPanel;
    qryMenuCates: TFDQuery;
    IntegerField5: TIntegerField;
    WideStringField4: TWideStringField;
    WideStringField5: TWideStringField;
    qryMenuGroups: TFDQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    WideStringField1: TWideStringField;
    qryMenuItems: TFDQuery;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    dsMenuCates: TDataSource;
    dsMenuGroups: TDataSource;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    btnMenuShow: TToolButton;
    ToolButton3: TToolButton;
    ToolButton10: TToolButton;
    btnMenuHR: TToolButton;
    btnMenuMkt: TToolButton;
    btnMenuCS: TToolButton;
    ToolButton9: TToolButton;
    ToolButton8: TToolButton;
    btnMenuExit: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure MDITabSetMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnuMDICloseClick(Sender: TObject);
    procedure mnuMDICloseAllClick(Sender: TObject);
    procedure MDI1Click(Sender: TObject);
    procedure btnMenuExitClick(Sender: TObject);
    procedure trvMenusDeletion(Sender: TObject; Node: TTreeNode);
    procedure trvMenusClick(Sender: TObject);
  private
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    function TabSetShortCut(AKey: Integer): Boolean;

    procedure ChildFormActivate(Sender: TObject);
    procedure ChildFormDestroy(Sender: TObject);

    procedure CreateMDIForm(AMenuId: string);

    procedure DisplayMenu(ACateCode: string);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses DTF.Module.Resource;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  Group, Item: TTreeNode;
begin
  FormStyle := fsMDIForm;

  Constraints.MinWidth := 1024;
  Constraints.MinHeight := 768;

  Application.OnMessage := AppMessage;

  DisplayMenu('SYS');
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

procedure TfrmMain.DisplayMenu(ACateCode: string);
var
  Group, Item: TTreeNode;
  MenuData: PMenuData;
begin
  if not qryMenuCates.FindKey([ACateCode]) then
    Exit;

  trvMenus.Items.Clear;

  qryMenuGroups.First;
  trvMenus.Items.BeginUpdate;
  while not qryMenuGroups.Eof do
  begin
    Group := trvMenus.Items.Add(nil, qryMenuGroups.FieldByName('group_name').AsString);
    Group.ImageIndex := 0;
    Group.SelectedIndex := 0;

    qryMenuItems.First;
    while not qryMenuItems.Eof do
    begin
      Item := trvMenus.Items.AddChild(Group, qryMenuItems.FieldByName('menu_name').AsString);
      New(MenuData);
      MenuData^.MenuId := qryMenuItems.FieldByName('menu_id').AsString;
      MenuData^.MenuName := qryMenuItems.FieldByName('menu_name').AsString;
      Item.Data := MenuData;
      Item.ImageIndex := 1;
      Item.SelectedIndex := 1;

      qryMenuItems.Next;
    end;

    qryMenuGroups.Next;
  end;

  trvMenus.FullExpand;
  trvMenus.Items.EndUpdate;
end;

procedure TfrmMain.btnMenuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.trvMenusClick(Sender: TObject);
var
  MenuData: TMenuData;
begin
  if Assigned(trvMenus.Selected) and Assigned(trvMenus.Selected.Data) then
  begin
    MenuData := TMenuData(trvMenus.Selected.Data^);
    CreateMDIForm(MenuData.MenuId);
  end;
end;

procedure TfrmMain.trvMenusDeletion(Sender: TObject; Node: TTreeNode);
begin
  if Assigned(Node.Data) then
    Dispose(Node.Data);
end;

procedure TfrmMain.MDI1Click(Sender: TObject);
begin
  CreateMDIForm('SYS1010');
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
{$ENDREGION}

end.
