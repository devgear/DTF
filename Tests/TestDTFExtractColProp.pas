unit TestDTFExtractColProp;

interface

uses
  DTF.GridInfo,
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestDTFExtractColProp = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestGetColPropsRec;

    [Test]
    procedure TestGetColPropsRecDepth;
  end;


implementation

procedure TTestDTFExtractColProp.Setup;
begin
end;

procedure TTestDTFExtractColProp.TearDown;
begin
end;

{$REGION 'Data type'}
type
  TRec1 = record
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

function TRec1.Sum: Integer;
begin
  Result := Int + Int2;
end;
{$ENDREGION}

procedure TTestDTFExtractColProp.TestGetColPropsRec;
var
  ColProps: TGridColProps;
begin
  ColProps := TExtractColProp.GetColProps<TRec1>;

  Assert.AreEqual(Length(ColProps), 6);

  Assert.AreEqual(ColProps[0].Field.Name, 'Int');
end;

{$REGION 'Data type'}
type
  TRecItem2 = record
    [IntCol(0)]
    Int: Integer;

    [IntCol(1)]
    Int2: Integer;
  end;

  TRec2 = record
    Item: TRecItem2;

    [StrCol(2)]
    Str: string;

    [DblCol(3, '#,##0.###')]
    Dbl: Single;

    [DtmCol(4, 100, 'YYYY-MM-DD')]
    Dtm: TDatetime;
  end;
{$ENDREGION}

procedure TTestDTFExtractColProp.TestGetColPropsRecDepth;
var
  ColProps: TGridColProps;
begin
  ColProps := TExtractColProp.GetColProps<TRec2>;

  Assert.AreEqual(Length(ColProps), 5);

  Assert.AreEqual(ColProps[0].Field.Name, 'Int');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestDTFExtractColProp);

end.
