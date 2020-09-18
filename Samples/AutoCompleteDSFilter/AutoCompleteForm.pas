unit AutoCompleteForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Data.DB,
  System.Generics.Collections, Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope;

type
  TfrmAutoComplete = class(TForm)
    ListView1: TListView;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB1: TBindSourceDB;
  private
    { Private declarations }
    class var
      FInstance: TfrmAutoComplete;
  private
    FSearchEdit: TEdit;
    FDataSet: TDataSet;
    FListFields: TArray<string>;
    FKeyFields: TArray<string>;
    procedure SetSearchEdit(AEdit: TEdit);

    procedure SearchEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    { Public declarations }
    procedure Initialize;
    class procedure Setup(
            AParent: TForm;
            ASearchEdit: TEdit;
            ADataSet: TDataSet;
            AListFields: TArray<string>;
            AKeyFields: TArray<string>
          );
    class procedure ReleaseInstance;
  end;

implementation

{$R *.dfm}

{ TfrmAutoComplete }

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
    ListView1.SetFocus;

  Visible := (FSearchEdit.Text <> '');
end;

procedure TfrmAutoComplete.SetSearchEdit(AEdit: TEdit);
begin
  FSearchEdit := AEdit;
//  FDataSet := ADataSet;
  FSearchEdit.OnKeyUp := SearchEditKeyUp;
end;

class procedure TfrmAutoComplete.Setup(
            AParent: TForm;
            ASearchEdit: TEdit;
            ADataSet: TDataSet;
            AListFields: TArray<string>;
            AKeyFields: TArray<string>
          );
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TfrmAutoComplete.Create(AParent);
    FInstance.Parent := AParent;
    FInstance.Left := 100;
    FINstance.Top := 100;
  end;
  FInstance.FSearchEdit := ASearchEdit;
  FInstance.FDataSet := ADataSet;
  FInstance.FListFields := AListFields;
  FInstance.FKeyFields := AKeyFields;
  FInstance.Initialize;
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

  ListView1.Columns.Clear;
  for Field in FListFields do
  begin
    Column := ListView1.Columns.Add;
    Column.AutoSize := True;
  end;

  // Data binding
  BindSourceDB1.DataSet := FDataSet;
  LinkListControlToField1.FieldName := FListFields[0];

  for I := 1 to Length(FListFields) - 1 do
  begin
    Item := LinkListControlToField1.FillExpressions.Add as TFormatExpressionItem;
    Item.ControlMemberName := 'SubItems[' + IntToStr(I-1) + ']';
    Item.SourceMemberName := FListFields[I];
  end;

  P := FSearchEdit.ClientToParent(Point(0, 0), FSearchEdit.Parent);
  Left := P.X;
  Top := P.Y + FSearchEdit.Height;

end;

class procedure TfrmAutoComplete.ReleaseInstance;
begin
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
