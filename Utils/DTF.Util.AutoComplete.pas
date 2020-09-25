unit DTF.Util.AutoComplete;

interface

uses
  System.Generics.Collections, System.SysUtils,
  Vcl.Forms, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB,
    // Bindings unit
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, Data.Bind.EngExt;


type
  IAutoCompleteAdapter = interface
    procedure BindControl(AListView: TListView);
    procedure ChangeText(AText: string);
  end;

  IAutoCompleteForm = interface
    procedure Initialize(AParent: TForm; AEdit: TEdit; AAdapter: IAutoCompleteAdapter);
  end;

  TAutoComplete = class
  private
    class var
      FList: TList<IAutoCompleteForm>;
  public
    class procedure Setup(AParent: TForm; AEdit: TEdit; AAdapter: IAutoCompleteAdapter);
    class procedure ReleaseInstances;
  end;

  TACDataSetFilterAdapter = class(TInterfacedObject, IAutoCompleteAdapter)
  private
    FDataSet: TDataSet;
    FListFields,
    FKeyFields: TArray<string>;

    // Binding
    FBindSourceDB: TBindSourceDB;
    FBindingsList: TBindingsList;
    FLinkListControlToField: TLinkListControlToField;

    { IAutoCompleteAdapter }
    procedure BindControl(AListView: TListView);
    procedure ChangeText(AText: string);
  public
    constructor Create(ADataSet: TDataSet; AListFields, AKeyFields: TArray<string>; ACompleteProc: TProc<TArray<string>>);
    destructor Destroy; override;
  end;

implementation

uses
  DTF.Util.AutoCompleteForm;

{ TAutoComplete }

class procedure TAutoComplete.ReleaseInstances;
begin
  if Assigned(FList) then
    FList.Free;
end;

class procedure TAutoComplete.Setup(AParent: TForm; AEdit: TEdit; AAdapter: IAutoCompleteAdapter);
var
  Form: IAutoCompleteForm;
begin
  if not Assigned(FList) then
    FList := TList<IAutoCompleteForm>.Create;
  Form := TfrmAutoComplete.Create(AParent);
  TfrmAutoComplete(Form).Parent := AParent;
  Form.Initialize(AParent, AEdit, AAdapter);
  FList.Add(Form);
end;

{ TACDataSetFilterAdapter }

procedure TACDataSetFilterAdapter.BindControl(AListView: TListView);
var
  I: Integer;
  Item: TFormatExpressionItem;
begin
  AListView.Columns.Clear;

  for I := 0 to Length(FListFields) - 1 do
  begin
    var Column := AListView.Columns.Add;
    Column.AutoSize := True;;
  end;

  FBindSourceDB := TBindSourceDB.Create(nil);
  FBindSourceDB.DataSet := FDataSet;

  FBindingsList := TBindingsList.Create(nil);

  FLinkListControlToField := TLinkListControlToField.Create(nil);
  FLinkListControlToField.DataSource := FBindSourceDB;
  FLinkListControlToField.Control := AListView;
  FLinkListControlToField.FieldName := FListFields[0];

  FLinkListControlToField.FillExpressions.Clear;
  for I := 1 to Length(FListFields) - 1 do
  begin
    Item := FLinkListControlToField.FillExpressions.Add as TFormatExpressionItem;
    Item.ControlMemberName := 'SubItems[' + IntToStr(I-1) + ']';
    Item.SourceMemberName := FListFields[I];
  end;
end;

procedure TACDataSetFilterAdapter.ChangeText(AText: string);
var
  Filter, Keyword: string;
begin
  Filter := '';
  for Keyword in FKeyFields do
  begin
    if Filter <> '' then
      Filter := Filter + ' OR ';
    Filter := Filter + Format('Lower(%s) LIKE Lower(''%%%s%%'')', [Keyword, AText]);
  end;
  FDataSet.Filter := Filter;
  FDataSet.Filtered := (AText <> '');
end;

constructor TACDataSetFilterAdapter.Create(ADataSet: TDataSet; AListFields, AKeyFields: TArray<string>; ACompleteProc: TProc<TArray<string>>);
begin
  FDataSet := ADataSet;
  FListFields := AListFields;
  FKeyFields := AKeyFields;
end;

destructor TACDataSetFilterAdapter.Destroy;
begin
  if Assigned(FBindSourceDB) then
    FBindSourceDB.Free;
  if Assigned(FBindingsList) then
    FBindingsList.Free;
  if Assigned(FLinkListControlToField) then
    FLinkListControlToField.Free;

  inherited;
end;

initialization
finalization
  TAutoComplete.ReleaseInstances;

end.
