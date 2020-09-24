{
  TODO
    포커스 벗어났을 경우 닫히도록 처리
    여러 컨트롤에서 사용가능하도록
    확장 가능하도록, DataSetFilter, RESTful
      TAutoComplete
        +------------------------+--------------------+
        |                        |                    |
        TAutoCompleteDSFilter    TAutoCompleteQuery   TAutoCompleteREST
}

unit AutoCompleteForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Data.DB,
  System.Generics.Collections, Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope;

type
  TfrmAutoComplete = class;

  TfrmAutoComplete = class(TForm)
    ListView: TListView;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB1: TBindSourceDB;
    procedure ListViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    class var
      FInstance: TfrmAutoComplete;
  private
    FDroppedDown: Boolean;

    FSearchEdit: TEdit;
    FDataSet: TDataSet;
    FListFields: TArray<string>;
    FKeyFields: TArray<string>;
    FEditWndProc, FListWndProc: TWndMethod;

    procedure Initialize;

    procedure EditWndProc(var Message: TMessage);
    procedure ListWndProc(var Message: TMessage);
    procedure SearchEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SearchEditClick(Sender: TObject);
  public
    procedure DropDown;
    procedure CloseUp;

    class procedure Setup(AParent: TForm; ASearchEdit: TEdit; ADataSet: TDataSet;
            AListFields: TArray<string>; AKeyFields: TArray<string>);
    class procedure ReleaseInstance;
  end;

implementation

uses
  System.Types;

{$R *.dfm}

{ TfrmAutoComplete }

procedure TfrmAutoComplete.SearchEditClick(Sender: TObject);
begin
  if FSearchEdit.Text <> '' then
    DropDown;
end;

procedure TfrmAutoComplete.SearchEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Filter, Keyword: string;
begin
  Filter := '';
  for Keyword in FKeyFields do
  begin
    if Filter <> '' then
      Filter := Filter + ' OR ';
    Filter := Filter + Keyword + ' LIKE ''%' + FSearchEdit.Text + '%''';
  end;
  FDataSet.Filter := Filter;
  FDataSet.Filtered := (FSearchEdit.Text <> '');

  if Key = VK_DOWN then
  begin
    DropDown;
    ListView.ItemIndex := 0;
    ListView.SetFocus;
    Exit;
  end;

  if Key = VK_ESCAPE then
  begin
    CloseUp;
    Exit;
  end;

  if FSearchEdit.Text = '' then
    CloseUp
  else
    DropDown;
end;

class procedure TfrmAutoComplete.Setup(AParent: TForm; ASearchEdit: TEdit; ADataSet: TDataSet;
  AListFields: TArray<string>; AKeyFields: TArray<string>);
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TfrmAutoComplete.Create(AParent);
    FInstance.Parent := AParent;
  end;
  FInstance.FSearchEdit := ASearchEdit;
  FInstance.FDataSet := ADataSet;
  FInstance.FListFields := AListFields;
  FInstance.FKeyFields := AKeyFields;
  FInstance.Initialize;
end;

procedure TfrmAutoComplete.EditWndProc(var Message: TMessage);
var
  Sender: TControl;
begin
  case Message.Msg of
  CM_CANCELMODE:
    begin
      OutputDebugString(PChar('Edit CM_CANCELMODE'));
      Sender := TControl(Message.LParam);

      if (Sender <> FSearchEdit) and (Sender <> ListView) then
        CloseUp;
    end;
  WM_KILLFOCUS:
    begin
      OutputDebugString(PChar('Edit WM_KILLFOCUS'));
      if not ListView.Focused then
        CloseUp;
    end;
//  WM_SETFOCUS:
//    begin
//      if FSearchEdit.Text <> '' then
//        DropDown;
//    end;
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
      OutputDebugString(PChar('List CM_CANCELMODE'));
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
      OutputDebugString(PChar('List WM_KILLFOCUS'));
      if not FSearchEdit.Focused then
      begin
        FSearchEdit.SetFocus;
        FSearchEdit.SelStart := Length(FSearchEdit.Text);
        CloseUp;
      end;
    end;
//  WM_SETFOCUS:
//    begin
//      if FSearchEdit.Text <> '' then
//        DropDown;
//    end;
  else
    FListWndProc(Message);
  end;
end;

procedure TfrmAutoComplete.DropDown;
begin
  Visible := True;

  FDroppedDown := True;
end;

procedure TfrmAutoComplete.FormDestroy(Sender: TObject);
begin
  OutputDebugString(PChar('AC.Destroy'));
end;

procedure TfrmAutoComplete.CloseUp;
begin
  if FDroppedDown then
  begin
    Visible := False;
    FDroppedDown := False;
  end;
end;

procedure TfrmAutoComplete.Initialize;
var
  I: Integer;
  Field: string;
  Column: TListColumn;
  Item: TFormatExpressionItem;
  P: TPoint;
begin
  FSearchEdit.OnKeyUp := SearchEditKeyUp;
  FSearchEdit.OnClick := SearchEditClick;

  FEditWndProc := FSearchEdit.WindowProc;
  FSearchEdit.WindowProc := EditWndProc;

  FListWndProc := ListView.WindowProc;
  ListView.WindowProc := ListWndProc;

  // Add ListControl Items
  ListView.Columns.Clear;
  for Field in FListFields do
  begin
    Column := ListView.Columns.Add;
    Column.AutoSize := True;
  end;

  // Set Data binding
  BindSourceDB1.DataSet := FDataSet;
  LinkListControlToField1.Control := ListView;
  LinkListControlToField1.FieldName := FListFields[0];

  for I := 1 to Length(FListFields) - 1 do
  begin
    Item := LinkListControlToField1.FillExpressions.Add as TFormatExpressionItem;
    Item.ControlMemberName := 'SubItems[' + IntToStr(I-1) + ']';
    Item.SourceMemberName := FListFields[I];
  end;

  // Set position
  P := FSearchEdit.ClientToParent(Point(0, 0), FSearchEdit.Parent);
  Left := P.X;
  Top := P.Y + FSearchEdit.Height;
end;

procedure TfrmAutoComplete.ListViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_UP) and (ListView.ItemIndex = 0) then
  begin
    FSearchEdit.SetFocus;
    FSearchEdit.SelStart := Length(FSearchEdit.Text);
  end;

  if Key = VK_ESCAPE then
  begin
    FSearchEdit.SetFocus;
    FSearchEdit.SelStart := Length(FSearchEdit.Text);
    CloseUp;
  end;
end;

class procedure TfrmAutoComplete.ReleaseInstance;
begin
  OutputDebugString(PChar('AC.finalization'));
//  if Assigned(FInstance) then
//  begin
//    FInstance.Parent := nil;
//    FInstance.Free;
//  end;
//  FInstance := nil;
end;

initialization
finalization
  TfrmAutoComplete.ReleaseInstance;

end.
