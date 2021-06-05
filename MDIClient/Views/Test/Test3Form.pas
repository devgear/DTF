unit Test3Form;

interface

uses
  DTF.Types, DTF.GridInfo,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Form.MDIChild, DTF.Frame.StrGrid,
  DTF.Frame.Base, DTF.Frame.Title, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Vcl.Grids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.ExtCtrls;

type
  TDataItem = record
    [IntCol(0)][FieldName('INT_DATA')]
    Int: Integer;

    [IntCol(1, '#,###')][FieldName('INT_DATA2')]
    Int2: Integer;

    [StrCol(2)][FieldName('STR_DATA')]
    Str: string;

    [DblCol(3, '#,##0.###')][FieldName('DBL_DATA')]
    Dbl: Single;

    [DtmCol(4, 100, 'YYYY-MM-DD')][FieldName('DTM_DATA')]
    Dtm: TDatetime;


    [IntCol(5)]
    Sum: Integer;

    [IntCol(6)][Avg('Int, Int2')]
    Avg: Single;

    [AutoCalc]
    procedure Calc;
  end;

  TGridData = record
    [DataRows]
    Items: TArray<TDataItem>;
    [DataRows][SumRows('Int, Int2, Dbl, Sum, Avg')]
    Sum: TDataItem;

    [AutoCalc]
    procedure Calc;
  end;

  [ViewId('TST3010')]
  TfrmTest3 = class(TDTFMDIChildForm)
    DTFTitleFrame1: TDTFTitleFrame;
    DTFStrGridFrame1: TDTFStrGridFrame;
    qryTestData: TFDQuery;
    qryTestDataTEST_SEQ: TIntegerField;
    qryTestDataINT_DATA: TIntegerField;
    qryTestDataINT_DATA2: TIntegerField;
    qryTestDataSTR_DATA: TWideStringField;
    qryTestDataDBL_DATA: TSingleField;
    qryTestDataDTM_DATA: TSQLTimeStampField;
    pnlSearchPanel: TPanel;
    edtKeyword: TSearchBox;
    procedure DTFStrGridFrame1actSearchExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FGrid: TStringGrid;
    FDatas: TGridData;
  public
    { Public declarations }
  end;

var
  frmTest3: TfrmTest3;

implementation

{$R *.dfm}

uses DatabaseModule, System.StrUtils;

{ TDataItem }

procedure TDataItem.Calc;
begin
  Sum := Int + Int2;
  Avg := Sum / 2;
end;

{ TGridData }

procedure TGridData.Calc;
var
  Item: TDataItem;
begin
  for Item in Items do
  begin
    Sum.Int := Sum.Int + Item.Int;
    Sum.Int2 := Sum.Int2 + Item.Int2;

    Sum.Dbl := Sum.Dbl + Item.Dbl;
  end;

  Sum.Calc;
end;

procedure TfrmTest3.FormCreate(Sender: TObject);
begin
  inherited;

  DTFStrGridFrame1.ClearGrid(6);

  FGrid := DTFStrGridFrame1.Grid;
  FGrid.Rows[0].AddStrings(['����', '����2', '����', '�Ǽ�', '��¥', '�հ�(Method)']);
end;


procedure TfrmTest3.DTFStrGridFrame1actSearchExecute(Sender: TObject);
var
  Data: TGridData;
  Item: TDataItem;
begin
  qryTestData.Close;
  qryTestData.ParamByName('str').AsString := IfThen(edtKeyword.Text = '', '%', edtKeyword.Text);
  qryTestData.Open;

  SetLength(Data.Items, qryTestData.RecordCount);
  while not qryTestData.Eof do
  begin
    Item := Default(TDataItem);
    Item.Int  := qryTestData.FieldByName('INT_DATA').AsInteger;
    Item.Int2 := qryTestData.FieldByName('INT_DATA2').AsInteger;
    Item.Str  := qryTestData.FieldByName('STR_DATA').AsString;
    Item.Dbl  := qryTestData.FieldByName('DBL_DATA').AsSingle;
    Item.Dtm  := qryTestData.FieldByName('DTM_DATA').AsDateTime;


    Data.Items[qryTestData.RecNo-1] := Item;

    qryTestData.Next;
  end;

  DTFStrGridFrame1.DisplayDataRec<TGridData>(Data);
end;

initialization
  TViewFactory.Instance.Regist(TfrmTest3);

end.