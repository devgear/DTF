unit TestDTFStrGridFrame;

interface

uses
  DTF.GridInfo,
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestDTFStrGrid = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestGetColProps;
  end;


implementation

procedure TTestDTFStrGrid.Setup;
begin
end;

procedure TTestDTFStrGrid.TearDown;
begin
end;

type
  TArrData = record
    [IntCol(0)]
    Int: Integer;

    [IntCol(1)][ColColor]
    Int2: Integer;

    [StrCol(2)]
    Str: string;

    [DblCol(3, '#,##0.###')]
    Dbl: Single;

    [DtmCol(4, 100, 'YYYY-MM-DD')]
    Dtm: TDatetime;

    [IntCol(5)]
    function Sum: Integer;
  end;

function TArrData.Sum: Integer;
begin
  Result := Int + Int2;
end;

procedure TTestDTFStrGrid.TestGetColProps;
var
  ColProps: TGridColProps;
begin
  ColProps := TExtractColProp.GetColProps<TArrData>;

  Assert.AreEqual(Length(ColProps), 6);

  Assert.AreEqual(ColProps[0].Field.Name, 'Int');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestDTFStrGrid);

end.
