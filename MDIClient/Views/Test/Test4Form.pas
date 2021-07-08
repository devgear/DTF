unit Test4Form;

interface

uses
  DTF.Types.View, DTF.Utils.Extract,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Form.MDIChild, DTF.Frame.StrGrid,
  DTF.Frame.Base, DTF.Frame.Title;

type
  TRecItem7 = record
    [IntCol('숫자%d', 80)]
    I: Integer;
    [IntCol('넘버%d', 80)]
    J: Integer;
  end;
  T0to3 = 0..3;
  T1to4 = 1..4;
  TArr4<T> = array[T1to4] of T;
  TRec7 = record
    [StrCol('문자', 120)]
    S: string;
    [ColArray(4)]
    Ints: TArr4<TRecItem7>;
  end;
  TRecList7 = record
    [DataRows]
    Items: TArray<TRec7>;
  end;

  [ViewId('TST4010')]
  TfrmTest4 = class(TDTFMDIChildForm)
    DTFStrGridFrame1: TDTFStrGridFrame;
    procedure DTFStrGridFrame1actSearchExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DTFStrGridFrame1actPrintExecute(Sender: TObject);
  private
    { Private declarations }
    Datas: TRecList7;
  public
    { Public declarations }
  end;

var
  frmTest4: TfrmTest4;

implementation

{$R *.dfm}

uses DTF.Utils.Export, DTF.Utils.Print;

procedure TfrmTest4.FormCreate(Sender: TObject);
begin
  inherited;

//  DTFStrGridFrame1.ClearGrid(10);
  DTFStrGridFrame1.SetGridColumn<TRec7>;
end;

procedure TfrmTest4.DTFStrGridFrame1actPrintExecute(Sender: TObject);
begin
  inherited;

  TExportUtil.PrintFromDataRec<TRecList7, TRec7>(
    Datas, '테스트',
    procedure(APrinter: TDTFPrinter)
    begin
      APrinter.Options := APrinter.Options + [poHorzLine];
    end
  );
end;

procedure TfrmTest4.DTFStrGridFrame1actSearchExecute(Sender: TObject);
begin
  inherited;

  SetLength(Datas.Items, 2);
  Datas.Items[0].S := 'abc1';
  Datas.Items[0].Ints[1].I := 11;
  Datas.Items[0].Ints[2].I := 12;
  Datas.Items[0].Ints[3].I := 13;
  Datas.Items[0].Ints[4].I := 14;
  Datas.Items[0].Ints[1].J := 111;
  Datas.Items[0].Ints[2].J := 112;
  Datas.Items[0].Ints[3].J := 113;
  Datas.Items[0].Ints[4].J := 114;

  Datas.Items[1].S := 'abc2';
  Datas.Items[1].Ints[1].I := 21;
  Datas.Items[1].Ints[2].I := 22;
  Datas.Items[1].Ints[3].I := 23;
  Datas.Items[1].Ints[4].I := 24;
  Datas.Items[1].Ints[1].J := 121;
  Datas.Items[1].Ints[2].J := 122;
  Datas.Items[1].Ints[3].J := 123;
  Datas.Items[1].Ints[4].J := 124;

  DTFStrGridFrame1.SetData<TRecList7>(Datas);

  DTFStrGridFrame1.WriteDatas<TRecList7, TRec7>(Datas);
end;

initialization
  TViewFactory.Instance.Regist(TfrmTest4);
end.
