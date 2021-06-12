unit DTF.Utils.AutoCompleteForm;

interface

uses
  DTF.Utils.AutoComplete,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmAutoComplete = class(TForm, IAutoCompleteForm)
    ListView: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListViewDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FInActivate,
    FEditFocused: Boolean;

    FDroppedDown: Boolean;

    FParent: TForm;
    FSearchEdit: TEdit;
    FAdapter: IAutoCompleteAdapter;

    FEditWndProc,
    FFormWndProc: TWndMethod;

    procedure Initialize(AParent: TForm; AEdit: TEdit;
      AAdapter: IAutoCompleteAdapter);

    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;

    procedure FormWndProc(var Message: TMessage);
    procedure EditWndProc(var Message: TMessage);
    procedure SearchEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SearchEditClick(Sender: TObject);

    procedure DoComplete;
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
  FInActivate := False;

  BorderStyle := bsNone;
  Visible := False;
end;

procedure TfrmAutoComplete.FormDestroy(Sender: TObject);
begin
  OutputDebugString(PChar(''));
end;

procedure TfrmAutoComplete.FormShow(Sender: TObject);
begin
  with FSearchEdit.ClientOrigin do
  begin
    Left  := X - 2;
    Top   := Y + FSearchEdit.Height - 2;
  end;
end;

procedure TfrmAutoComplete.Initialize(AParent: TForm; AEdit: TEdit;
  AAdapter: IAutoCompleteAdapter);
begin
  if not Assigned(AParent) or not Assigned(AEdit) or not Assigned(AAdapter) then
    raise Exception.Create('Not enough parameters.');

  FParent := AParent;
  FFormWndProc := FParent.WindowProc;
  FParent.WindowProc := FormWndProc;
  FAdapter := AAdapter;

  FSearchEdit := AEdit;
  FSearchEdit.OnKeyUp := SearchEditKeyUp;
  FSearchEdit.OnClick := SearchEditClick;
  FEditWndProc := FSearchEdit.WindowProc;
  FSearchEdit.WindowProc := EditWndProc;

  FAdapter.BindControl(ListView);
end;

procedure TfrmAutoComplete.DropDown;
begin
  if FDroppedDown then
    Exit;

  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  ShowWindow(Handle, SW_SHOWNOACTIVATE);
  Visible := True;

  FDroppedDown := True;
end;

procedure TfrmAutoComplete.CloseUp;
begin
  if FDroppedDown then
  begin
    Visible := False;
    FDroppedDown := False;
    ListView.ItemIndex := -1;
  end;
end;

procedure TfrmAutoComplete.SearchEditClick(Sender: TObject);
begin
  FAdapter.ChangeText(FSearchEdit.Text);
  if FSearchEdit.Text <> '' then
    DropDown;
  FEditFocused := False;
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
    if Assigned(ListView.Selected) then
      DoComplete;
    Exit;
  end;

  FAdapter.ChangeText(FSearchEdit.Text);

  if FSearchEdit.Text = '' then
    CloseUp
  else
    DropDown;
end;

procedure TfrmAutoComplete.ListViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_UP) and (ListView.ItemIndex = 0) then
  begin
    FEditFocused := True;
    FSearchEdit.SetFocus;
    Exit;
  end
  else if Key = VK_ESCAPE then
  begin
    FSearchEdit.SetFocus;
    CloseUp;
    Exit;
  end
  else if Key = VK_RETURN then
  begin
    if Assigned(ListView.Selected) then
      DoComplete;
    Exit;
  end;
end;

procedure TfrmAutoComplete.ListViewDblClick(Sender: TObject);
begin
  if Assigned(ListView.Selected) then
    DoComplete;
end;

procedure TfrmAutoComplete.DoComplete;
begin
  FSearchEdit.Clear;
  FAdapter.Complete;
  CloseUp;
end;

procedure TfrmAutoComplete.WMActivate(var Message: TWMActivate);
begin
  FInActivate := Message.Active <> WA_INACTIVE;

  if not FInActivate then
  begin
    if Message.ActiveWindow = FParent.Handle then
      Application.ProcessMessages;

    if not FEditFocused and (not FSearchEdit.Focused) then
      CloseUp;
    FEditFocused := False;
  end;
end;

procedure TfrmAutoComplete.EditWndProc(var Message: TMessage);
begin
  case Message.Msg of
  WM_KILLFOCUS:
    if not FInActivate and not ListView.Focused then
      CloseUp;
  CM_MOUSEACTIVATE:
    FEditFocused := True;
  end;
  FEditWndProc(Message);
end;

procedure TfrmAutoComplete.FormWndProc(var Message: TMessage);
begin
  // MDIForm의 경우 Form 클릭(폼이동) 시(TCustomForm.SendCancelMode)
    // CM_CANCELMODE 호출되지 않음
  case Message.Msg of
  WM_LBUTTONDOWN,
  WM_NCLBUTTONDOWN:
    if FSearchEdit.Focused then
      CloseUp;
  end;
  FFormWndProc(Message);
end;

end.
