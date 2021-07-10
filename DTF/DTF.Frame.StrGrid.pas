unit DTF.Frame.StrGrid;

interface

uses
  DTF.Types, DTF.Frame.View, DTF.Frame.Title, DTF.Utils.Extract,
  DTF.Utils.Export,

  System.Rtti, System.TypInfo,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBActns,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids,
  Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections, DTF.Frame.Base;

type
  TDTFStrGridFrame = class(TDTFViewFrame)
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
    procedure actPrintExecute(Sender: TObject);
  private
    FItemType: PTypeInfo;
    FDataValue: TValue;   // TValue로 Grid출력, 인쇄 등 자동화
    FPrintOptionProc: TPrinterOptionProc;

    procedure WriteGrid(const ADataTable: TDataTable);
  public
    procedure SetSearchPanel(APanel: TPanel);
    procedure SetPrintOption(ASetOptionProc: TPrinterOptionProc);

    procedure ClearGrid(AColCount: Integer = -1);

    procedure SetGridColumn<T>;
    procedure SetData<T>(const Value: T);

    procedure DisplayDatas<T>(AData: T); overload;
    procedure DisplayDatas; overload;

    procedure PrintDatas;
  end;

implementation

uses
  DTF.Utils;

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

procedure TDTFStrGridFrame.SetData<T>(const Value: T);
begin
  FDataValue := TValue.From<T>(Value);
  FItemType := TExtractUtil.ExtractItemType(FDataValue.TypeInfo);
end;

procedure TDTFStrGridFrame.actPrintExecute(Sender: TObject);
begin
  inherited;

  PrintDatas;
end;

procedure TDTFStrGridFrame.ClearGrid(AColCount: Integer = -1);
begin
  if AColCount > 0 then
    Grid.ColCount := AColCount;

  Grid.RowCount := Grid.FixedRows + 1;
  Grid.Rows[Grid.FixedRows].Clear;
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

procedure TDTFStrGridFrame.SetPrintOption(ASetOptionProc: TPrinterOptionProc);
begin
  FPrintOptionProc := ASetOptionProc;
end;

procedure TDTFStrGridFrame.WriteGrid(const ADataTable: TDataTable);
var
  I, Row, ColCount: Integer;
  DataRecord: TDataRecord;
begin
  if Length(ADataTable) = 0 then
    Exit;

  ColCount := Length(ADataTable[0]);
  Row := Grid.FixedRows;

  for DataRecord in ADataTable do
  begin
    for I := 0 to ColCount - 1 do
      Grid.Cells[I, Row] := DataRecord[I];

    Inc(Row);
  end;

  Grid.RowCount := Row;
end;

// DataRows Attr로 목록 확인
procedure TDTFStrGridFrame.DisplayDatas;
var
  ColProps: TColInfoProps;
  DataTable: TDataTable;
begin
  if not TExtractUtil.TryGetColProps(FItemType, ColProps) then
    Exit;

  DataTable := TExtractUtil.ExtractDataTable(ColProps, FDataValue);
  WriteGrid(DataTable);
end;

procedure TDTFStrGridFrame.DisplayDatas<T>(AData: T);
begin
  SetData<T>(AData);
  DisplayDatas;
end;

procedure TDTFStrGridFrame.PrintDatas;
begin
  if FDataValue.IsEmpty then
    Exit;

  TExportUtil.PrintFromDataValue(FDataValue, Title, FPrintOptionProc);
end;

end.
