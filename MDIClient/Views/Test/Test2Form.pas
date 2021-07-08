unit Test2Form;

interface

uses
  DTF.Types.View, DTF.Utils.Extract,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Form.MDIChild, DTF.Frame.StrGrid,
  DTF.Frame.Base, DTF.Frame.Title, Vcl.StdCtrls, Vcl.WinXCtrls, Vcl.Grids, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  { TODO : Design 관련 Attr 추가하면 좋을 듯
     - Align, Color, Caption 등 }
  TGridData = record
    [IntCol]
    Int: Integer;

    [IntCol][ColColor]
    Int2: Integer;

    [StrCol(120)]
    Str: string;

    [DblCol(100, '#,##0.###')]
    Dbl: Single;

    [DtmCol(100, 'YYYY-MM-DD')]
    Dtm: TDatetime;

    [IntCol]
    function Sum: Integer;
  end;

  [ViewId('TST2010')]
  TfrmTest2 = class(TDTFMDIChildForm)
    DTFStrGridFrame1: TDTFStrGridFrame;
    pnlSearchPanel: TPanel;
    edtKeyword: TSearchBox;
    qryTestData: TFDQuery;
    procedure DTFStrGridFrame1actSearchExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FGrid: TStringGrid;
  public
    { Public declarations }
  end;

var
  frmTest2: TfrmTest2;

implementation

{$R *.dfm}

uses DatabaseModule, System.StrUtils;

{ TGridData }

function TGridData.Sum: Integer;
begin
  Result := Int + Int2;
end;

procedure TfrmTest2.FormCreate(Sender: TObject);
begin
  DTFStrGridFrame1.SetSearchPanel(pnlSearchPanel);

  DTFStrGridFrame1.ClearGrid(6);

  FGrid := DTFStrGridFrame1.Grid;
  FGrid.Rows[0].AddStrings(['숫자', '숫자2', '문자', '실수', '날짜', '합계(Method)']);

  FGrid.ColAlignments[0] := taRightJustify;
  FGrid.ColAlignments[1] := taRightJustify;
  FGrid.ColAlignments[4] := taCenter;
end;

procedure TfrmTest2.DTFStrGridFrame1actSearchExecute(Sender: TObject);
var
  Data: TGridData;
  Datas: TArray<TGridData>;
begin
  qryTestData.Close;
  qryTestData.ParamByName('str').AsString := IfThen(edtKeyword.Text = '', '%', edtKeyword.Text);
  qryTestData.Open;

  SetLength(Datas, qryTestData.RecordCount);
  while not qryTestData.Eof do
  begin
    Data.Int  := qryTestData.FieldByName('INT_DATA').AsInteger;
    Data.Int2 := qryTestData.FieldByName('INT_DATA2').AsInteger;
    Data.Str  := qryTestData.FieldByName('STR_DATA').AsString;
    Data.Dbl  := qryTestData.FieldByName('DBL_DATA').AsSingle;
    Data.Dtm  := qryTestData.FieldByName('DTM_DATA').AsDateTime;

    Datas[qryTestData.RecNo-1] := Data;

    qryTestData.Next;
  end;

  DTFStrGridFrame1.WriteDatas<TGridData>(Datas);
end;

initialization
  TViewFactory.Instance.Regist(TfrmTest2);

end.
