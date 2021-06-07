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
    procedure FillDataRow<T>(ARow: Integer; AColProps: TGridColProps; AData: T);
  public
    procedure SetSearchPanel(APanel: TPanel);

    procedure ClearGrid(AColCount: Integer = -1);

    procedure FillDataRows<T>(const ADatas: TArray<T>); overload;
    procedure FillDataRows<T>(const ADatas: TList<T>); overload;
    procedure FillDataRowsRec<T>(const ADataRec: T); overload;
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

procedure TDTFStrGridFrame.FillDataRow<T>(ARow: Integer; AColProps: TGridColProps; AData: T);
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

procedure TDTFStrGridFrame.FillDataRows<T>(const ADatas: TList<T>);
begin
end;

procedure TDTFStrGridFrame.FillDataRows<T>(const ADatas: TArray<T>);
var
  ColProps: TGridColProps;

  Data: T;
  Row: Integer;
begin
  if not TExtractColProp.TryGetColProps<T>(ColProps) then
    Exit;

  Grid.BeginUpdate;
  try
    Grid.RowCount := Grid.FixedRows + Length(ADatas);
    Row := Grid.FixedRows;
    for Data in ADatas do
    begin
      FillDataRow<T>(Row, ColProps, Data);

      Inc(Row);
    end;
  finally
    Grid.EndUpdate;
  end;
end;

// DataRows Attr로 목록 확인
procedure TDTFStrGridFrame.FillDataRowsRec<T>(const ADataRec: T);
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LField: TRttiField;
  LMethod: TRttiMethod;
  LAttr: DataRowsAttribute;

  Info: PTypeInfo;
  Data: PTypeData;
begin
//  SetLength(ColProps, Grid.ColCount);
  LCtx := TRttiContext.Create;
  try
    LType := LCtx.GetType(TypeInfo(T));

    for LField in LType.GetFields do
    begin
      LAttr := TAttributeUtil.FindAttribute<DataRowsAttribute>(LField.GetAttributes);
      if not Assigned(LAttr) then
        Continue;


    end;
  finally
    LCtx.Free;
  end;
end;

end.
