unit DTF.Utils.AutoComplete;

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
    procedure Complete;
    procedure CheckAdapter;
  end;

  IAutoCompleteForm = interface
  ['{7D7117EA-7EBC-4274-8747-AE4745125A2D}']
    procedure Initialize(AParent: TForm; AEdit: TEdit; AAdapter: IAutoCompleteAdapter);
  end;

  TAutoComplete = class
  private
    class var
      FList: TList<IAutoCompleteForm>;
  public
    class procedure Setup(AParent: TForm; AEdit: TEdit;
      AAdapter: IAutoCompleteAdapter; AFormClass: TFormClass = nil);
    class procedure ReleaseInstances;
  end;

  TAutoCompleteDSFilterAdapter = class(TInterfacedObject, IAutoCompleteAdapter)
  private
    FDataSet: TDataSet;
    FListFields,
    FKeyFields: TArray<string>;
    FCompleteProc: TProc<TArray<string>>;

    // Binding
    FBindSourceDB: TBindSourceDB;
    FBindingsList: TBindingsList;
    FLinkListControlToField: TLinkListControlToField;

    { IAutoCompleteAdapter }
    procedure BindControl(AListView: TListView);
    procedure ChangeText(AText: string);
    procedure Complete;
    procedure CheckAdapter;
  public
    constructor Create(ADataSet: TDataSet; AListFields, AKeyFields: TArray<string>;
      ACompleteProc: TProc<TArray<string>>); overload;
    destructor Destroy; override;

    // Builder
    function SetDataSet(AValue: TDataSet): TAutoCompleteDSFilterAdapter;
    function SetListFields(AValue: TArray<string>): TAutoCompleteDSFilterAdapter;
    function SetKeyFields(AValue: TArray<string>): TAutoCompleteDSFilterAdapter;
    function SetCompleteProc(AValue: TProc<TArray<string>>): TAutoCompleteDSFilterAdapter;
  end;

implementation

uses
  DTF.Utils.AutoCompleteForm;

const
  DefaultAutoCompleteFormClass: TFormClass = TfrmAutoComplete;

{ TAutoComplete }

class procedure TAutoComplete.Setup(
  AParent: TForm;
  AEdit: TEdit;
  AAdapter: IAutoCompleteAdapter;
  AFormClass: TFormClass
);
var
  Form: IAutoCompleteForm;
begin
  AAdapter.CheckAdapter;

  if not Assigned(AFormClass) then
    AFormClass := DefaultAutoCompleteFormClass;

  if not Supports(AFormClass, IAutoCompleteForm) then
    raise Exception.Create('Error Message');

  if not Assigned(FList) then
    FList := TList<IAutoCompleteForm>.Create;
  Form := AFormClass.Create(AParent) as IAutoCompleteForm;

  Form.Initialize(AParent, AEdit, AAdapter);
  FList.Add(Form);
end;

class procedure TAutoComplete.ReleaseInstances;
begin
  if Assigned(FList) then
    FList.Free;
end;

{ TACDataSetFilterAdapter }

procedure TAutoCompleteDSFilterAdapter.CheckAdapter;
begin
  if not Assigned(FDataSet) then
    raise Exception.Create('Not assigned dataset.');
  if Length(FListFields) = 0 then
    raise Exception.Create('List field is empty.');
  if Length(FKeyFields) = 0 then
    raise Exception.Create('Key field is empty.');
  if not Assigned(FCompleteProc) then
    raise Exception.Create('Not assigned complete procedure.');
end;

constructor TAutoCompleteDSFilterAdapter.Create(ADataSet: TDataSet; AListFields, AKeyFields: TArray<string>; ACompleteProc: TProc<TArray<string>>);
begin
  FDataSet := ADataSet;
  FListFields := AListFields;
  FKeyFields := AKeyFields;
  FCompleteProc := ACompleteProc;
end;

destructor TAutoCompleteDSFilterAdapter.Destroy;
begin
  if Assigned(FBindSourceDB) then
    FBindSourceDB.Free;
  if Assigned(FBindingsList) then
    FBindingsList.Free;
  if Assigned(FLinkListControlToField) then
    FLinkListControlToField.Free;

  inherited;
end;

{$REGION 'Builder'}
function TAutoCompleteDSFilterAdapter.SetCompleteProc(
  AValue: TProc<TArray<string>>): TAutoCompleteDSFilterAdapter;
begin
  FCompleteProc := AValue;
  Result := Self;
end;

function TAutoCompleteDSFilterAdapter.SetDataSet(
  AValue: TDataSet): TAutoCompleteDSFilterAdapter;
begin
  FDataSet := AValue;
  Result := Self;
end;

function TAutoCompleteDSFilterAdapter.SetKeyFields(
  AValue: TArray<string>): TAutoCompleteDSFilterAdapter;
begin
  FKeyFields := AValue;
  Result := Self;
end;

function TAutoCompleteDSFilterAdapter.SetListFields(
  AValue: TArray<string>): TAutoCompleteDSFilterAdapter;
begin
  FListFields := AValue;
  Result := Self;
end;
{$ENDREGION 'Builder'}

procedure TAutoCompleteDSFilterAdapter.BindControl(AListView: TListView);
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

  FLinkListControlToField.Active := True;
end;

procedure TAutoCompleteDSFilterAdapter.ChangeText(AText: string);
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

procedure TAutoCompleteDSFilterAdapter.Complete;
var
  I: Integer;
  Params: TArray<string>;
begin
  if (not FDataSet.Active) or (FDataSet.RecordCount = 0) then
    Exit;
  SetLength(Params, Length(FKeyFields));
  for I := 0 to Length(FKeyFields) - 1 do
    Params[I] := FDataSet.FieldByName(FKeyFields[I]).AsString;
  if Assigned(FCompleteProc) then
    FCompleteProc(Params);
end;

initialization
finalization
  TAutoComplete.ReleaseInstances;

end.
