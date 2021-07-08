unit DTF.Frame.StrGrid;

interface

uses
  DTF.Types, DTF.Frame.Title, DTF.Utils.Extract,

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
    DTFTitleFrame1: TDTFTitleFrame;
    Grid: TStringGrid;
  private
    FItemType: PTypeInfo;
    FDataValue: TValue;   // TValue로 Grid출력, 인쇄 등 자동화

    procedure SetDataRow<T>(const ARow: Integer; AColProps: TColInfoProps; AData: T);
    procedure SetDataRows<T>(const AStartRow: Integer; AColProps: TColInfoProps; ADatas: TArray<T>);
  public
    procedure SetSearchPanel(APanel: TPanel);
    procedure ClearGrid(AColCount: Integer = -1);
    procedure SetGridColumn<T>;

//    property Data: TValue read FData write SetData;
    procedure SetData<T>(const Value: T);

    procedure WriteDatas<ItemType>(const ADatas: TArray<ItemType>); overload;
    procedure WriteDatas<ItemType>(const ADatas: TList<ItemType>); overload;
    procedure WriteDatas<DataType, ItemType>(const ADataRec: DataType); overload;
    procedure WriteDatas; overload;
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

procedure TDTFStrGridFrame.SetData<T>(const Value: T);
begin
  FDataValue := TValue.From<T>(Value);
end;

procedure TDTFStrGridFrame.SetDataRow<T>(const ARow: Integer; AColProps: TColInfoProps; AData: T);
begin
  Grid.Rows[ARow].AddStrings(TExtractUtil.ExtractDataRow<T>(AColProps, AData));
end;

procedure TDTFStrGridFrame.SetDataRows<T>(const AStartRow: Integer; AColProps: TColInfoProps; ADatas: TArray<T>);
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

procedure TDTFStrGridFrame.SetGridColumn<T>;
var
  I: Integer;
  ColProps: TColInfoProps;
begin
  if not TExtractUtil.TryGetColProps<T>(ColProps) then
    Exit;

  Grid.ColCount := Length(ColProps);
  for I := 0 to Length(ColProps) - 1 do
  begin
    Grid.Cells[I, 0] := ColProps[I].Caption;
    Grid.ColWidths[I] := ColProps[I].ColWidth;
  end;

  Grid.RowCount := Grid.FixedRows + 1;
  Grid.Rows[Grid.FixedRows].Clear;
end;

procedure TDTFStrGridFrame.WriteDatas<ItemType>(const ADatas: TList<ItemType>);
begin
  WriteDatas<ItemType>(ADatas.ToArray);
end;

procedure TDTFStrGridFrame.WriteDatas<ItemType>(const ADatas: TArray<ItemType>);
var
  ColProps: TColInfoProps;
begin
  if not TExtractUtil.TryGetColProps<ItemType>(ColProps) then
    Exit;

  if Length(ADatas) = 0 then
    Exit;

  Grid.RowCount := Grid.FixedRows + Length(ADatas);

  SetDataRows<ItemType>(Grid.FixedRows, ColProps, ADatas);
end;

// DataRows Attr로 목록 확인
procedure TDTFStrGridFrame.WriteDatas;
begin

end;

{
  DataType을 보내야하나? Variant 또는 TValue로 받는다면?
}
procedure TDTFStrGridFrame.WriteDatas<DataType, ItemType>(const ADataRec: DataType);
var
  Row: Integer;
  ColProps: TColInfoProps;
  DataTable: TDataTable;
  DataRow: TDataRecord;
begin
  if not TExtractUtil.TryGetColProps<ItemType>(ColProps) then
    Exit;

  DataTable := TExtractUtil.ExtractDataTable<DataType, ItemType>(ColProps, ADataRec);

  Grid.BeginUpdate;
  try
    Row := Grid.FixedRows;
    for DataRow in DataTable do
    begin
      Grid.Rows[Row].AddStrings(DataRow);

      Inc(Row);
    end;

    Grid.RowCount := Row;
  finally
    Grid.EndUpdate
  end;
end;

end.
