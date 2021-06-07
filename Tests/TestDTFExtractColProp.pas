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
    // 구조체의 그리드 컬럼정보가 설정된 컬럼 갯수 확인
    procedure TestGetAttrCount;

    [Test]
    procedure TestGetColPropsRec;

    [Test]
    procedure TestGetColPropsRecDepth;

    [Test]
    procedure TestGetColPropsArrayT;
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

  TRec3 = record
    Items: TArray<TRec1>;
  end;

  TRec4 = record
    [DataRows]
    Items: TArray<TRec1>;
    [DataRows]
    Sum: TRec1;
  end;

  TRecItem5 = record
    [IntCol]
    Int: Integer;
    [StrCol]
    Str: string;
  end;
  TRec5 = record
    A,
    B,
    C: TRecItem5; // 6 cols
  end;

  TRec6 = record
    [IntCol]
    Int: Integer;
    A,
    B: TRecItem5;
    [StrCol]
    Str: string;
    C: TRecItem5; // 8 cols
  end;
{$ENDREGION}

procedure TTestDTFExtractColProp.TestGetAttrCount;
var
  LCtx: TRttiContext;
  C1, C2, C3: Integer;
begin
  LCtx := TRttiContext.Create;
  try
    // Rec
    C1 := TAttributeUtil.GetAttributeCount<TGridColAttribute>(LCtx.GetType(TypeInfo(TRec1)));
    Assert.AreEqual(C1, 6);

    // Rec in Rec
    C2 := TAttributeUtil.GetAttributeCount<TGridColAttribute>(LCtx.GetType(TypeInfo(TRec2)));
    Assert.AreEqual(C2, 5);

    // TArray<Rec>
    C3 := TAttributeUtil.GetAttributeCount<TGridColAttribute>(LCtx.GetType(TypeInfo(TRec3)));
    Assert.AreEqual(C3, 6);
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

  Assert.AreEqual(Length(ColProps), 6);

  Assert.AreEqual(ColProps[0].Field.Name, 'Int');
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

procedure TTestDTFExtractColProp.TestGetColPropsArrayT;
var
  ColProps: TGridColProps;
begin
  if not TExtractColProp.TryGetColProps<TRec3>(ColProps) then
    Assert.Fail;

  Assert.AreEqual(Length(ColProps), 6);

  Assert.AreEqual(ColProps[0].Field.Name, 'Int');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestDTFExtractColProp);

end.
