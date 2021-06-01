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
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.WinXCalendars;

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
    qryMenuTree: TFDQuery;
    qryMenuShortcut: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure MDITabSetMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnuMDICloseClick(Sender: TObject);
    procedure mnuMDICloseAllClick(Sender: TObject);
    procedure btnMenuExitClick(Sender: TObject);
    procedure MDITabSetChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure btnCateMenuClick(Sender: TObject);
    procedure trvMenusCreateNodeClass(Sender: TCustomTreeView;
      var NodeClass: TTreeNodeClass);
    procedure trvMenusChange(Sender: TObject; Node: TTreeNode);
  private
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);

    function TabSetShortCut(AKey: Integer): Boolean;

    procedure ChildFormActivate(Sender: TObject);
    procedure ChildFormDestroy(Sender: TObject);

    procedure CreateMDIForm(AMenuId: string);

    procedure LoadTreeMenu(ACateCode: string);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  DatabaseModule,
  DTF.App,
  DTF.Types,
  DTF.Module.Resource,
  DTF.Util.AutoComplete;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FormStyle := fsMDIForm;

  Application.OnMessage := AppMessage;

  LoadTreeMenu('home');

  qryMenuShortcut.Open;
  TAutoComplete.Setup(
    Self,
    edtShortCut,
    TAutoCompleteDSFilterAdapter.Create
      .SetDataSet(qryMenuShortcut)
      .SetListFields(['menu_name', 'menu_code', 'cate'])
      .SetKeyFields(['menu_code', 'menu_name'])
      .SetCompleteProc(
        procedure(Values: TArray<string>)
        begin
          CreateMDIForm(Values[0]);
        end)
  );

  WindowState := App.Config.WindowState;
  BoundsRect := App.Config.WindowBounds;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  App.Config.WindowState := WindowState;
  if WindowState <> wsMaximized then
    App.Config.WindowBounds := BoundsRect;
end;

procedure TfrmMain.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin
  if Assigned(ActiveMDIChild) and (Msg.message = WM_KEYDOWN) and (GetKeyState(VK_CONTROL) < 0) then
  begin
    Handled := TabSetShortCut(Msg.wParam)
  end
  // Issue : MDIForm does not send CM_CANCELMODE
  else if (Msg.message = WM_LBUTTONDOWN) and Assigned(ActiveControl) then
  begin
    var Ctrl := FindControl(Msg.hwnd);
    if not Assigned(Ctrl) then
      Exit;

    ActiveControl.Perform(CM_CANCELMODE, 0, Winapi.Windows.LPARAM(Ctrl));
    Handled := False;
  end;
end;

procedure TfrmMain.CreateMDIForm(AMenuId: string);
var
  I: Integer;
  Form: TDTFForm;
  FormClass: TDTFFormClass;
begin
  FormClass := TViewFactory.Instance.GetClass(AMenuId);
  if not Assigned(FormClass) then
  begin
    ShowMessage(Format('해당 메뉴의 폼을 찾을 수 없습니다.(Menu Id: %s)', [AMenuId]));
    Exit
  end;

  for I := 0 to MDIChildCount - 1 do
  begin
    if MDIChildren[I].ClassType = FormClass then
    begin
      MDICHildren[I].Show;
      Exit;
    end;
  end;

  Form := FormClass.Create(Self);
  Form.OnMDIActivate  := ChildFormActivate;
  Form.OnMDIDestroy   := ChildFormDestroy;

  Form.WindowState := wsMaximized;
  Form.Show;

  MDITabSet.Tabs.AddObject(Form.SimpleCaption, Form);
  MDITabSet.TabIndex := MDITabSet.Tabs.Count - 1;
end;

procedure TfrmMain.LoadTreeMenu(ACateCode: string);
var
  GroupName: string;
  Group, Item: TMenuNode;
begin
  if ACateCode = '' then
    Exit;

  qryMenuTree.Close;
  qryMenuTree.ParamByName('cate_code').AsString := ACateCode;
  qryMenuTree.Open;

  trvMenus.Items.Clear;
  Group := nil;
  GroupName := '';

  while not qryMenuTree.Eof do
  begin
    GroupName := qryMenuTree.FieldByName('group_name').AsString;
    if not Assigned(Group) or (GroupName <> Group.Text) then
    begin
      Group := trvMenus.Items.Add(nil, GroupName) as TMenuNode;
      Group.Code := qryMenuTree.FieldByName('group_code').AsString;
      Group.ImageIndex := 0;
      Group.SelectedIndex := 0;
    end;

//    trvMenus.Items.addchildobj

    Item := trvMenus.Items.AddChild(Group, qryMenuTree.FieldByName('menu_name').AsString) as TMenuNode;
    Item.Code := qryMenuTree.FieldByName('menu_code').AsString;
    Item.ParentCode := Group.Code;
    Item.ImageIndex := 1;
    Item.SelectedIndex := 1;

    qryMenuTree.Next;
  end;

  trvMenus.FullExpand;
end;

procedure TfrmMain.btnMenuExitClick(Sender: TObject);
begin
  if Assigned(ActiveMDIChild) then
    ActiveMDIChild.Close
  else
    Close;
end;

procedure TfrmMain.btnCateMenuClick(Sender: TObject);
begin
  LoadTreeMenu(TToolButton(Sender).Hint);
end;

procedure TfrmMain.trvMenusChange(Sender: TObject; Node: TTreeNode);
begin
  if Node.Level = 1 then
    CreateMDIForm((Node as TMenuNode).Code);
end;

procedure TfrmMain.trvMenusCreateNodeClass(Sender: TCustomTreeView;
  var NodeClass: TTreeNodeClass);
begin
  NodeClass := TMenuNode;
end;

{$REGION 'MDI Control'}
procedure TfrmMain.ChildFormActivate(Sender: TObject);
var
  I: Integer;
begin
  if (Sender is TForm) and (TForm(Sender).FormStyle = fsMDIChild) then
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

procedure TfrmMain.MDITabSetChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  TForm(MDITabSet.Tabs.Objects[NewTab]).Show;
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
