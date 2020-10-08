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

    procedure EditWndProc(var Message: TMessage);
    procedure ListWndProc(var Message: TMessage);
    procedure SearchEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SearchEditClick(Sender: TObject);

    procedure DoComplete;
  public
    procedure DropDown;
    procedure CloseUp;
  end;

implementation

uses
  System.Types;

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
  with FSearchEdit.ClientToParent(Point(0, 0), Parent) do
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

  FEditWndProc := FSearchEdit.WindowProc;
  FSearchEdit.WindowProc := EditWndProc;

  FListWndProc := ListView.WindowProc;
  ListView.WindowProc := ListWndProc;

  FAdapter.BindControl(ListView);
end;

procedure TfrmAutoComplete.SearchEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DOWN then
  begin
    DropDown;
    ListView.ItemIndex := 0;
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

procedure TfrmAutoComplete.SearchEditClick(Sender: TObject);
begin
  if FSearchEdit.Text <> '' then
    DropDown;
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

procedure TfrmAutoComplete.DoComplete;
begin
  FSearchEdit.Clear;
  FAdapter.Complete;
  CloseUp;
end;

procedure TfrmAutoComplete.DropDown;
begin
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

procedure TfrmAutoComplete.EditWndProc(var Message: TMessage);
var
  Sender: TControl;
begin
  case Message.Msg of
  { TODO : MDIForm does not send CM_CANCELMODE }
  CM_CANCELMODE:
    begin
      OutputDebugString(PChar('Edit.CM_CANCELMODE'));

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
end;

procedure TfrmAutoComplete.ListWndProc(var Message: TMessage);
var
  Sender: TControl;
begin
  case Message.Msg of
  CM_CANCELMODE:
    begin
      OutputDebugString(PChar('List.CM_CANCELMODE'));
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
      OutputDebugString(PChar('List.WM_KILLFOCUS'));
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
