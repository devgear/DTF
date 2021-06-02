unit DTF.Frame.StrGrid;

interface

uses
  DTF.Types,
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
  public
    procedure SetSearchPanel(APanel: TPanel);

    procedure ClearGrid(AColCount: Integer = -1);
    procedure DisplayDatas<T>(const ADatas: TArray<T>); overload;
    procedure DisplayDatas<T>(const ADatas: TList<T>); overload;
  end;

implementation

uses
  DTF.Intf, DTF.Utils, System.Rtti;

{$R *.dfm}

{ TDTFStrGridFrame }

procedure TDTFStrGridFrame.ClearGrid(AColCount: Integer = -1);
begin
  if AColCount > 0 then
    Grid.ColCount := AColCount;

  Grid.RowCount := Grid.FixedRows + 1;
  Grid.Rows[Grid.FixedRows].Clear;
end;


procedure TDTFStrGridFrame.DisplayDatas<T>(const ADatas: TArray<T>);
type
  TColInfo = record
    Attr: TGridColAttribute;
    Field: TRttiField;
    Method: TRttiMethod;
  end;
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LField: TRttiField;
  LMethod: TRttiMethod;
  LAttr: TGridColAttribute;

  I: Integer;
  ColInfo: TColInfo;
  ColInfos: TArray<TColInfo>;

  Data: T;
  Row: Integer;
  Value: TValue;
  StrVal: string;
begin
  SetLength(ColInfos, Grid.ColCount);
  LCtx := TRttiContext.Create;
  try
    LType := LCtx.GetType(TypeInfo(T));

    for LField in LType.GetFields do
    begin
      LAttr := TAttributeUtil.FindAttribute<TGridColAttribute>(LField.GetAttributes);
      if not Assigned(LAttr) then
        Continue;

      ColInfos[LAttr.Col].Attr := LAttr;
      ColInfos[LAttr.Col].Field := LField;
    end;

    for LMethod in LType.GetMethods do
    begin
      LAttr := TAttributeUtil.FindAttribute<TGridColAttribute>(LMethod.GetAttributes);
      if not Assigned(LAttr) then
        Continue;

      ColInfos[LAttr.Col].Attr := LAttr;
      ColInfos[LAttr.Col].Method := LMethod;
    end;
  finally
    LCtx.Free;
  end;

  Grid.BeginUpdate;
  try
    Grid.RowCount := Grid.FixedRows + Length(ADatas);
    Row := Grid.FixedRows;
    for Data in ADatas do
    begin

      for I := 0 to Length(ColInfos) - 1 do
      begin
        ColInfo := ColInfos[I];

        if not Assigned(ColInfo.Attr) then
          Continue;

        Value := nil;
        if Assigned(ColInfo.Field) then
          Value := ColInfo.Field.GetValue(@Data)
        else if Assigned(ColInfo.Method) then
          Value := ColInfo.Method.Invoke(TValue.From<Pointer>(@Data), []);

        if not Assigned(Value) then
          Continue;

        StrVal := ColInfo.Attr.ValToStr(Value);

        Grid.Cells[I, Row] := StrVal;
      end;

      Inc(Row);
    end;
  finally
    Grid.EndUpdate;
  end;
end;

procedure TDTFStrGridFrame.DisplayDatas<T>(const ADatas: TList<T>);
begin

end;

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
          SC.SetSearchControl(APanel.Controls[I], procedure
            begin
              actSearch.Execute;
            end);
      end;
    end;
  end;
end;

end.
