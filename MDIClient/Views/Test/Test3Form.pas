unit Test3Form;

interface

uses
  DTF.Types.View, DTF.Utils.Extract,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Form.MDIChild, DTF.Frame.StrGrid,
  DTF.Frame.Base, DTF.Frame.Title, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Vcl.Grids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.ExtCtrls, DTF.Frame.View;

type
  TDataItem = record
    [IntCol]
    Int: Integer;

    [IntCol(80, '#,###')]
    Int2: Integer;

    [StrCol]
    Str: string;

    [DblCol(100, '#,##0.###')]
    Dbl: Single;

    [DtmCol(100, 'YYYY-MM-DD')]
    Dtm: TDatetime;


    [IntCol]
    Sum: Integer;

    [DblCol(100, '#,##0.###')]
    Avg: Single;

//    [AutoCalc]
    procedure Calc;
  end;

  TGridData = record
    [DataRows]
    Items: TArray<TDataItem>;

    [DataRows]
    Sum: TDataItem;

    procedure Calc;
  end;

  [ViewId('TST3010')]
  TfrmTest3 = class(TDTFMDIChildForm)
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
  public
    { Public declarations }
  end;

var
  frmTest3: TfrmTest3;

implementation

{$R *.dfm}

uses
  DTF.App,
  DatabaseModule, System.StrUtils;

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
  ZeroMemory(@Sum, SizeOf(Sum));
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

  DTFStrGridFrame1.SetSearchPanel(pnlSearchPanel);

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

    Item.Calc;

    Data.Items[qryTestData.RecNo-1] := Item;

    qryTestData.Next;
  end;

  Data.Calc;

  DTFStrGridFrame1.DisplayDatas(Data);
end;

initialization
  App.View.Regist(TfrmTest3);

end.
