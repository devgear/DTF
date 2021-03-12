unit DTF.Util.AutoCompleteForm;

interface

uses
  DTF.Util.AutoComplete,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmAutoComplete = class(TForm, IAutoCompleteForm)
    ListView: TListView;
    procedure FormCreate(Sender: TObject);
    procedure ListViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ListViewDblClick(Sender: TObject);
  private
    FDroppedDown: Boolean;

    FParent: TForm;
    FAdapter: IAutoCompleteAdapter;
    FSearchEdit: TEdit;

    FEditWndProc, FListWndProc: TWndMethod;

    procedure Initialize(AParent: TForm; AEdit: TEdit;
      AAdapter: IAutoCompleteAdapter);

    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure CMVisibleChanged(var Message: TMessage);// message CM_VISIBLECHANGED;

    procedure EditWndProc(var Message: TMessage);
    procedure ListWndProc(var Message: TMessage);
    procedure SearchEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SearchEditClick(Sender: TObject);
    procedure SearchEditExit(Sender: TObject);

    procedure DoComplete;
  public
    procedure DropDown;
    procedure CloseUp;
  end;

implementation

uses
  System.Types, System.Math;

{$R *.dfm}

{ TfrmAutoComplete }

procedure TfrmAutoComplete.FormCreate(Sender: TObject);
begin
  BorderStyle := bsNone;
  Visible := False;
end;

procedure TfrmAutoComplete.FormShow(Sender: TObject);
begin
  // Set position
//  with FSearchEdit.ClientToParent(Point(0, 0), Parent) do
  with FSearchEdit.ClientOrigin do
  begin
    Left := X;
    Top := Y + FSearchEdit.Height;
  end;
end;

procedure TfrmAutoComplete.Initialize(AParent: TForm; AEdit: TEdit;
  AAdapter: IAutoCompleteAdapter);
begin
  if not Assigned(AParent) or not Assigned(AEdit) or not Assigned(AAdapter) then
    raise Exception.Create('Not enough parameters.');

  FParent := AParent;
  FAdapter := AAdapter;

  FSearchEdit := AEdit;
  FSearchEdit.OnKeyUp := SearchEditKeyUp;
  FSearchEdit.OnClick := SearchEditClick;
  FSearchEdit.OnExit := SearchEditExit;

//  FListWndProc := ListView.WindowProc;
//  ListView.WindowProc := ListWndProc;

//  if FParent.FormStyle <> fsMDIForm then
//  begin
    FEditWndProc := FSearchEdit.WindowProc;
    FSearchEdit.WindowProc := EditWndProc;
//  end;

  FAdapter.BindControl(ListView);
end;

procedure TfrmAutoComplete.SearchEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key in [VK_DOWN] then
  begin
    DropDown;
    ListView.ItemIndex := Min(0, ListView.ItemIndex);
    ListView.SetFocus;
    Exit;
  end
  else if Key = VK_ESCAPE then
  begin
    CloseUp;
    Exit;
  end
  else if Key = VK_RETURN then
  begin
    DoComplete;
    Exit;
  end;

  FAdapter.ChangeText(FSearchEdit.Text);

  if FSearchEdit.Text = '' then
    CloseUp
  else
    DropDown;
end;

procedure TfrmAutoComplete.WMActivate(var Message: TWMActivate);
begin
  OutputDebugString(PChar('TfrmAutoComplete.WMActivate'));
end;

procedure TfrmAutoComplete.SearchEditClick(Sender: TObject);
begin
  if FSearchEdit.Text <> '' then
    DropDown;
end;

procedure TfrmAutoComplete.SearchEditExit(Sender: TObject);
var
  ActCtl: TWinControl;
begin
  ActCtl := Screen.ActiveControl;

//  if (ActCtl <> FSearchEdit) and (ActCtl <> ListView) then
//    CloseUp;
end;

procedure TfrmAutoComplete.ListViewDblClick(Sender: TObject);
begin
  DoComplete;
end;

procedure TfrmAutoComplete.ListViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_UP) and (ListView.ItemIndex = 0) then
  begin
    FSearchEdit.SetFocus;
    FSearchEdit.SelStart := Length(FSearchEdit.Text);
    Exit;
  end
  else if Key = VK_ESCAPE then
  begin
    FSearchEdit.SetFocus;
    FSearchEdit.SelStart := Length(FSearchEdit.Text);
    CloseUp;
    Exit;
  end
  else if Key = VK_RETURN then
  begin
    DoComplete;
    Exit;
  end;
end;

procedure TfrmAutoComplete.CMVisibleChanged(var Message: TMessage);
begin
  if Visible then
  begin
    SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
    ShowWindow(Handle, SW_SHOWNOACTIVATE);
  end
  else
  begin
    ShowWindow(Handle, SW_HIDE);
  end;

  OutputDebugString(PChar('TfrmAutoComplete.CMVisibleChanged'));

end;

procedure TfrmAutoComplete.DoComplete;
begin
  FSearchEdit.Clear;
  FAdapter.Complete;
  CloseUp;
end;

procedure TfrmAutoComplete.DropDown;
begin
  if FDroppedDown then
    Exit;

//  SetWindowPos(Handle, HWND_TOP, Left, Top, Width, Height, SWP_NOACTIVATE);
//  ShowWindow(Self.Handle, SW_SHOWNOACTIVATE);
//  SetWindowPos(WindowHandle, HWND_TOP, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);

//  Self.DefocusControl(Self, True);

  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  ShowWindow(Handle, SW_SHOWNOACTIVATE);
  Visible := True;
//  Show;

//  if FParent.FormStyle <> fsMDIForm then
//    FSearchEdit.WindowProc := EditWndProc;

  FDroppedDown := True;
end;

procedure TfrmAutoComplete.CloseUp;
begin
  if FDroppedDown then
  begin
//    if FParent.FormStyle <> fsMDIForm then
//      FSearchEdit.WindowProc := FEditWndProc;
    Visible := False;
    FDroppedDown := False;
    ListView.ItemIndex := -1;
  end;
end;

procedure TfrmAutoComplete.EditWndProc(var Message: TMessage);
var
  Sender: TControl;
begin
  case Message.Msg of
  CM_CANCELMODE:
    begin
      Sender := TControl(Message.LParam);

      if (Sender <> FSearchEdit) and (Sender <> ListView) then
        CloseUp;
    end;
  WM_KILLFOCUS:
    begin
      if not ListView.Focused then
        CloseUp;
    end;
  else
    FEditWndProc(Message);
  end;
//  Dispatch(Message);
end;

procedure TfrmAutoComplete.ListWndProc(var Message: TMessage);
var
  Sender: TControl;
begin
  case Message.Msg of
  CM_CANCELMODE:
    begin
      Sender := TControl(Message.LParam);

      if (Sender <> FSearchEdit) and (Sender <> ListView) then
      begin
        FSearchEdit.SetFocus;
        FSearchEdit.SelStart := Length(FSearchEdit.Text);
        CloseUp;
      end;
    end;
  WM_KILLFOCUS:
    begin
      if csDestroying in ComponentState then
        Exit;
      if not FSearchEdit.Focused then
      begin
        FSearchEdit.SetFocus;
        FSearchEdit.SelStart := Length(FSearchEdit.Text);
        CloseUp;
      end;
    end;
  else
    FListWndProc(Message);
  end;
end;

end.
