unit Test3Form;

interface

uses
  DTF.Types,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Form.MDIChild, DTF.Frame.StrGrid,
  DTF.Frame.Base, DTF.Frame.Title, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

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
    procedure DTFStrGridFrame1actSearchExecute(Sender: TObject);
  private
    { Private declarations }
    FDatas: TGridData;
  public
    { Public declarations }
  end;

var
  frmTest3: TfrmTest3;

implementation

{$R *.dfm}

uses DatabaseModule;

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

procedure TfrmTest3.DTFStrGridFrame1actSearchExecute(Sender: TObject);
begin
  inherited;

  DTFStrGridFrame1.DisplayDatas<TGridData, TDataItem>(FDatas);
end;

initialization
  TViewFactory.Instance.Regist(TfrmTest3);

end.
