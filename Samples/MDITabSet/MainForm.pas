unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Menus, Vcl.Tabs;

type
  TForm1 = class(TForm)
    TabSet: TTabSet;
    MainMenu1: TMainMenu;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImageList1: TImageList;
    Files1: TMenuItem;
    PopupMenu1: TPopupMenu;
    C1: TMenuItem;
    N1: TMenuItem;
    NewSubForm1: TMenuItem;
    N2: TMenuItem;
    Closeform1: TMenuItem;
    Closeall1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure TabSetChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure TabSetMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure C1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure NewSubForm1Click(Sender: TObject);
    procedure Closeform1Click(Sender: TObject);
    procedure Closeall1Click(Sender: TObject);
  private
    { Private declarations }

    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    function TabSetShortCut(AKey: Integer): Boolean;

    procedure ShowMDIChild(AFormCode: string);

    procedure ChildFormClose(Sender: TObject; var Action: TCloseAction);
    procedure ChildFormActivate(Sender: TObject);
    procedure ChildFormDestroy(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FormStyle := fsMDIForm;
  Caption := 'MDI TabSet Demo';

  Application.OnMessage := AppMessage;
end;

procedure TForm1.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin
  if Assigned(ActiveMDIChild) and (Msg.message = WM_KEYDOWN) and (GetKeyState(VK_CONTROL) < 0) then
    Handled := TabSetShortCut(Msg.wParam);
end;

procedure TForm1.ChildFormActivate(Sender: TObject);
var
  I: Integer;
begin
  if (Sender is TForm) and (TForm(Sender).FormStyle = fsMDIChild) then
  begin
    for I := 0 to TabSet.Tabs.Count - 1 do
    begin
      if TabSet.Tabs.Objects[I] = Sender then
      begin
        TabSet.TabIndex := I;
        Exit;
      end;
    end;
  end;
end;

procedure TForm1.ChildFormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm1.ChildFormDestroy(Sender: TObject);
var
  I: Integer;
begin
  if not (csDestroying in ComponentState) and (Sender is TForm) and (TForm(Sender).FormStyle = fsMDIChild) then
  begin
    for I := 0 to TabSet.Tabs.Count - 1 do
    begin
      if TabSet.Tabs.Objects[I] = Sender then
      begin
        TabSet.Tabs.Delete(I);

        if TabSet.Tabs.Count > I then
          TForm(TabSet.Tabs.Objects[I]).SetFocus;
        Exit;
      end;
    end;
  end;
end;

procedure TForm1.ShowMDIChild(AFormCode: string);
var
  I: Integer;
  FormClass: TFormClass;
  Form: TForm;
begin
  FormClass := TFormClass(GetClass(AFormCode));

  // Not found formclass
  if not Assigned(FormClass) then
    Exit;

  // Exist form
//  for I := 0 to MDIChildCount - 1 do
//  begin
//    if MDIChildren[I].ClassType = FormClass then
//    begin
//      MDICHildren[I].SetFocus;
//      Exit;
//    end;
//  end;

  Form := FormClass.Create(Self);
  Form.WindowState := wsMaximized;
  Form.OnClose := ChildFormClose;
  Form.OnActivate := ChildFormActivate;
  Form.OnDestroy := ChildFormDestroy;
  Form.Show;

  TabSet.Tabs.AddObject(Form.Caption, Form);
  TabSet.TabIndex := TabSet.Tabs.Count - 1;
end;

procedure TForm1.TabSetChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  TForm(TabSet.Tabs.Objects[NewTab]).SetFocus;
end;

procedure TForm1.TabSetMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Idx: Integer;
begin
  if Button <> mbRight then
    Exit;

  Idx := TabSet.ItemAtPos(TPoint.Create(X, Y));

  if Idx >= 0 then
  begin
    TabSet.TabIndex := Idx;
    PopupMenu1.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  end;
//    TForm(TabSet.Tabs.Objects[Idx]).Close;
end;

function TForm1.TabSetShortCut(AKey: Integer): Boolean;
var
  TabIndex: Integer;
begin
  Result := False;

  case AKey of
  VK_TAB:
    begin
      if GetKeyState(VK_SHIFT) < 0 then
        TabIndex := TabSet.TabIndex - 1
      else
        TabIndex := TabSet.TabIndex + 1;
      if TabIndex < 0 then
        TabIndex := MDIChildCount - 1
      else if TabIndex >= MDIChildCount then
        TabIndex := 0;

      TabSet.TabIndex := TabIndex;
      Result := True;
    end;
  Ord('1')..Ord('9'):
    begin
      AKey := AKey - Ord('1');
      if MDIChildCount > AKey then
        TabSet.TabIndex := AKey;
      Result := True;
    end;
  Ord('w'), Ord('W'):
    begin
      ActiveMDIChild.Close;
    end;
  end;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  ShowMDIChild('TfrmSub');
end;

procedure TForm1.C1Click(Sender: TObject);
begin
  ActiveMDIChild.Close;
end;

procedure TForm1.N1Click(Sender: TObject);
var
  I: Integer;
begin
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].Close;
end;

procedure TForm1.NewSubForm1Click(Sender: TObject);
begin
  ShowMDIChild('TfrmSub');
end;

procedure TForm1.Closeall1Click(Sender: TObject);
var
  I: Integer;
begin
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].Close;
end;

procedure TForm1.Closeform1Click(Sender: TObject);
begin
  ActiveMDIChild.Close;
end;

end.
