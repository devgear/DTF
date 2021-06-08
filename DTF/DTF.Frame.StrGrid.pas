unit DTF.Frame.StrGrid;

interface

uses
  DTF.Types, DTF.GridInfo,
  System.Rtti, System.TypInfo,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Frame.Base, Vcl.DBActns,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids,
  Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections;

type
  TDTFStrGridFrame = class(TDTFBaseFrame)
    tlbDataSet: TToolBar;
    btnDSRefresh: TToolButton;
    btnExportXls: TToolButton;
    ToolButton2: TToolButton;
    ActionList: TActionList;
    actPrint: TAction;
    actExportXls: TAction;
    actSearch: TAction;
    pnlSearchControlArea: TPanel;
    Grid: TStringGrid;
  private
    procedure SetDataRow<T>(const ARow: Integer; AColProps: TGridColProps; AData: T);
    procedure SetDataRows<T>(const AStartRow: Integer; AColProps: TGridColProps; ADatas: TArray<T>);
  public
    procedure SetSearchPanel(APanel: TPanel);

    procedure ClearGrid(AColCount: Integer = -1);

    procedure FillDataRows<T>(const ADatas: TArray<T>); overload;
    procedure FillDataRows<T>(const ADatas: TList<T>); overload;
    procedure FillDataRowsRec<DataType, ItemType>(const ADataRec: DataType); overload;
  end;

implementation

uses
  DTF.Intf, DTF.Utils;

{$R *.dfm}

{ TDTFStrGridFrame }

procedure TDTFStrGridFrame.SetSearchPanel(APanel: TPanel);
var
  I: Integer;
  SC: IDTFSetSearchControl;
begin
  pnlSearchControlArea.Visible := Assigned(APanel) and APanel.Visible;
  pnlSearchControlArea.Caption := '';
  if Assigned(APanel) then
  begin
    APanel.Parent := pnlSearchControlArea;
    APanel.Align := alClient;
    pnlSearchControlArea.Height := APanel.Height;

    // SearchEdit 등록(엔터키 처리)
    if Supports(GetParentForm(Self), IDTFSetSearchControl, SC) then
    begin
      for I := 0 to APanel.ControlCount - 1 do
      begin
        if APanel.Controls[I] is TCustomEdit then
          SC.SetSearchControl(APanel.Controls[I],
            procedure
            begin
              actSearch.Execute;
            end);
      end;
    end;
  end;
end;

procedure TDTFStrGridFrame.ClearGrid(AColCount: Integer = -1);
begin
  if AColCount > 0 then
    Grid.ColCount := AColCount;

  Grid.RowCount := Grid.FixedRows + 1;
  Grid.Rows[Grid.FixedRows].Clear;
end;

procedure TDTFStrGridFrame.SetDataRow<T>(const ARow: Integer; AColProps: TGridColProps; AData: T);
var
  I: Integer;
  ColProp: TGridColProp;
  Value: TValue;
  StrVal: string;
begin
  for I := 0 to Length(AColProps) - 1 do
  begin
    ColProp := AColProps[I];

    if not Assigned(ColProp.Attr) then
      Continue;

    Value := TValue.Empty;
    if Assigned(ColProp.Field) then
      Value := ColProp.Field.GetValue(@AData)
    else if Assigned(ColProp.Method) then
      Value := ColProp.Method.Invoke(TValue.From<Pointer>(@AData), []);

    if Value.IsEmpty then
      Continue;

    StrVal := ColProp.Attr.ValueToStr(Value);

    Grid.Cells[I, ARow] := StrVal;
  end;
end;

procedure TDTFStrGridFrame.SetDataRows<T>(const AStartRow: Integer; AColProps: TGridColProps; ADatas: TArray<T>);
var
  Data: T;
  Row: Integer;
begin
  Grid.BeginUpdate;
  try
    Row := AStartRow;
    for Data in ADatas do
    begin
      SetDataRow<T>(Row, AColProps, Data);

      Inc(Row);
    end;
  finally
    Grid.EndUpdate;
  end;
end;

procedure TDTFStrGridFrame.FillDataRows<T>(const ADatas: TList<T>);
begin
  FillDataRows<T>(ADatas.ToArray);
end;

procedure TDTFStrGridFrame.FillDataRows<T>(const ADatas: TArray<T>);
var
  ColProps: TGridColProps;
begin
  if not TExtractColProp.TryGetColProps<T>(ColProps) then
    Exit;

  if Length(ADatas) = 0 then
    Exit;

  Grid.RowCount := Grid.FixedRows + Length(ADatas);

  SetDataRows<T>(Grid.FixedRows, ColProps, ADatas);
end;

// DataRows Attr로 목록 확인
procedure TDTFStrGridFrame.FillDataRowsRec<DataType, ItemType>(const ADataRec: DataType);
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LField: TRttiField;
  LMethod: TRttiMethod;
  LAttr: DataRowsAttribute;

  ColProps: TGridColProps;

  Info: PTypeInfo;
  Data: PTypeData;
  LCount: Integer;
  Value: TValue;
begin
  if not TExtractColProp.TryGetColProps<ItemType>(ColProps) then
    Exit;

  LCtx := TRttiContext.Create;
  try
    LType := LCtx.GetType(TypeInfo(DataType));

    LCount := 0;
    for LField in LType.GetFields do
    begin
      LAttr := TAttributeUtil.FindAttribute<DataRowsAttribute>(LField.GetAttributes);
      if not Assigned(LAttr) then
        Continue;

      if LField.FieldType.TypeKind = tkDynArray then
      begin
        Value := LField.GetValue(@ADataRec);
//        (LField.FieldType as TRttiDynamicArrayType).ElementType;
        // ElementType 이 ItemType인지 확인
        SetDataRows<ItemType>(Grid.FixedRows + LCount, ColProps, Value.AsType<TArray<ItemType>>);
        LCount := LCount + Value.GetArrayLength;
      end
      else if LField.FieldType.IsRecord then
      begin
        Value := LField.GetValue(@ADataRec);
        SetDataRow<ItemType>(Grid.FixedRows + LCount, ColProps, Value.AsType<ItemType>);
        Inc(LCount);
      end;
    end;

    if LCount > 0 then
      Grid.RowCount := Grid.FixedRows + LCount;
  finally
    LCtx.Free;
  end;
end;

end.
