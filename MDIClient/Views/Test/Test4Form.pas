unit Test4Form;

interface

uses
  DTF.Types.View, DTF.Utils.Grid,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Form.MDIChild, DTF.Frame.StrGrid,
  DTF.Frame.Base, DTF.Frame.Title;

type
  TRecItem7 = record
    [IntCol]
    I: Integer;
    [IntCol]
    J: Integer;
  end;
  TArr4<T> = array[0..3] of T;
  TRec7 = record
    [StrCol]
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
    DTFTitleFrame1: TDTFTitleFrame;
    DTFStrGridFrame1: TDTFStrGridFrame;
    procedure DTFStrGridFrame1actSearchExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTest4: TfrmTest4;

implementation

{$R *.dfm}

procedure TfrmTest4.DTFStrGridFrame1actSearchExecute(Sender: TObject);
var
  Datas: TRecList7;
begin
  inherited;

  SetLength(Datas.Items, 2);
  Datas.Items[0].S := 'abc1';
  Datas.Items[0].Ints[0].I := 11;
  Datas.Items[0].Ints[1].I := 12;
  Datas.Items[0].Ints[2].I := 13;
  Datas.Items[0].Ints[3].I := 14;
  Datas.Items[0].Ints[0].J := 111;
  Datas.Items[0].Ints[1].J := 112;
  Datas.Items[0].Ints[2].J := 113;
  Datas.Items[0].Ints[3].J := 114;

  Datas.Items[1].S := 'abc2';
  Datas.Items[1].Ints[0].I := 21;
  Datas.Items[1].Ints[1].I := 22;
  Datas.Items[1].Ints[2].I := 23;
  Datas.Items[1].Ints[3].I := 24;
  Datas.Items[1].Ints[0].J := 121;
  Datas.Items[1].Ints[1].J := 122;
  Datas.Items[1].Ints[2].J := 123;
  Datas.Items[1].Ints[3].J := 124;

  DTFStrGridFrame1.WriteDatas<TRecList7, TRec7>(Datas);
end;

procedure TfrmTest4.FormCreate(Sender: TObject);
begin
  inherited;

  DTFStrGridFrame1.ClearGrid(10);
end;

initialization
  TViewFactory.Instance.Regist(TfrmTest4);
end.
