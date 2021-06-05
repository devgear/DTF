unit TestDTFExtractColProp;

interface

uses
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
    procedure TestGetAttrCount;

    [Test]
    procedure TestGetColPropsRec;

    [Test]
    procedure TestGetColPropsRecDepth;
  end;


implementation

uses
  System.Rtti,
  DTF.GridInfo, DTF.Utils;

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

procedure TTestDTFExtractColProp.TestGetAttrCount;
var
  LCtx: TRttiContext;
  C1, C2: Integer;
begin
  LCtx := TRttiContext.Create;
  try
//    C1 := TAttributeUtil.GetAttributeCount<TGridColAttribute>(LCtx.GetType(TypeInfo(TRec1)));
//    Assert.AreEqual(C1, 6);

    C2 := TAttributeUtil.GetAttributeCount<TGridColAttribute>(LCtx.GetType(TypeInfo(TRec2)));
    Assert.AreEqual(C2, 5);
  finally
    LCtx.Free;
  end;
end;

procedure TTestDTFExtractColProp.TestGetColPropsRec;
var
  ColProps: TGridColProps;
begin
  if not TExtractColProp.TryGetColProps<TRec1>(ColProps) then
    Assert.Fail;
//
//  Assert.AreEqual(Length(ColProps), 6);
//
//  Assert.AreEqual(ColProps[0].Field.Name, 'Int');
end;

procedure TTestDTFExtractColProp.TestGetColPropsRecDepth;
var
  ColProps: TGridColProps;
begin
  if not TExtractColProp.TryGetColProps<TRec2>(ColProps) then
    Assert.Fail;

  Assert.AreEqual(Length(ColProps), 5);

  Assert.AreEqual(ColProps[0].Field.Name, 'Int');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestDTFExtractColProp);

end.
