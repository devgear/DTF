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
    procedure TestGetColPropsChildRec;

    [Test]
    procedure TestGetColPropsArrayT;

    [Test]
    procedure TestGetDataRowsArrayType;

    procedure Test<T>(ADatas: TArray<T>);

    [Test]
    procedure TestFillDataRowsRec;

    [Test]
    procedure TestGetColPropsStaticArray;

    [Test]
    procedure TestDataRecStaticArray;

    [Test]
    procedure TestDetectItemType;
    function DetectItemType<T>(Value: T): string;
  end;


implementation

uses
  System.Rtti, System.TypInfo, System.SysUtils,
  DTF.Utils.Extract, DTF.Utils, DTF.Frame.StrGrid;

procedure TTestDTFExtractColProp.Setup;
begin
end;

procedure TTestDTFExtractColProp.TearDown;
begin
end;

{$REGION 'Data type'}
type
  TRec1 = record
    [IntCol]
    Int: Integer;

    [IntCol][ColColor]
    Int2: Integer;

    [StrCol]
    Str: string;

    [DblCol(100, '#,##0.###')]
    Dbl: Single;

    [DtmCol(120, 'YYYY-MM-DD')]
    Dtm: TDatetime;

    [IntCol]
    function Sum: Integer;
  end;

function TRec1.Sum: Integer;
begin
  Result := Int + Int2;
end;

type
  TRecItem2 = record
    [IntCol]
    Int: Integer;

    [IntCol]
    Int2: Integer;
  end;

  TRec2 = record
    Item: TRecItem2;

    [StrCol]
    Str: string;

    [DblCol(100, '#,##0.###')]
    Dbl: Single;

    [DtmCol(120, 'YYYY-MM-DD')]
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

  TRec4_2 = record
    [DataRows]
    Sum: TRec1;
    [DataRows]
    Items: TArray<TRec1>;
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

  TRecItem7 = record
    [IntCol]
    I: Integer;
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
{$ENDREGION}

procedure TTestDTFExtractColProp.TestGetAttrCount;
var
  LCtx: TRttiContext;
  C1, C2, C3, C6: Integer;
begin
  LCtx := TRttiContext.Create;
  try
    // Rec
    C1 := TAttributeUtil.GetAttributeCount<TColumnInfoAttribute>(LCtx.GetType(TypeInfo(TRec1)));
    Assert.AreEqual(C1, 6);

    // Rec in Rec
    C2 := TAttributeUtil.GetAttributeCount<TColumnInfoAttribute>(LCtx.GetType(TypeInfo(TRec2)));
    Assert.AreEqual(C2, 5);

    // TArray<Rec>
    C3 := TAttributeUtil.GetAttributeCount<TColumnInfoAttribute>(LCtx.GetType(TypeInfo(TRec3)));
    Assert.AreEqual(C3, 6);

    C6 := TAttributeUtil.GetAttributeCount<TColumnInfoAttribute>(LCtx.GetType(TypeInfo(TRec6)));
    Assert.AreEqual(C6, 8);

  finally
    LCtx.Free;
  end;
end;

procedure TTestDTFExtractColProp.TestGetColPropsRec;
var
  ColProps: TColInfoProps;
begin
  if not TExtractUtil.TryGetColProps<TRec1>(ColProps) then
    Assert.Fail;

  Assert.AreEqual(Length(ColProps), 6);

  Assert.AreEqual(ColProps[0].Field.Name, 'Int');
end;

procedure TTestDTFExtractColProp.TestGetColPropsChildRec;
var
  ColProps: TColInfoProps;
begin
  if not TExtractUtil.TryGetColProps<TRec2>(ColProps) then
    Assert.Fail;

  Assert.AreEqual(Length(ColProps), 5);

  Assert.AreEqual(ColProps[0].Field.Name, 'Int');
end;

procedure TTestDTFExtractColProp.TestGetColPropsArrayT;
var
  ColProps: TColInfoProps;
begin
  if not TExtractUtil.TryGetColProps<TRec3>(ColProps) then
    Assert.Fail;

  Assert.AreEqual(Length(ColProps), 6);

  Assert.AreEqual(ColProps[0].Field.Name, 'Int');
end;

procedure TTestDTFExtractColProp.Test<T>(ADatas: TArray<T>);
begin
  WriteLn(Length(ADatas).ToString);
end;

procedure TTestDTFExtractColProp.TestDataRecStaticArray;
var
  Datas: TRecList7;
  Frame: TDTFStrGridFrame;
begin
  Frame := TDTFStrGridFrame.Create(nil);
  try
    SetLength(Datas.Items, 2);
    Datas.Items[0].S := 'abc1';
    Datas.Items[0].Ints[0].I := 11;
    Datas.Items[0].Ints[1].I := 12;
    Datas.Items[0].Ints[2].I := 13;
    Datas.Items[0].Ints[3].I := 14;

    Datas.Items[1].S := 'abc2';
    Datas.Items[1].Ints[0].I := 21;
    Datas.Items[1].Ints[1].I := 22;
    Datas.Items[1].Ints[2].I := 23;
    Datas.Items[1].Ints[3].I := 24;

    Frame.WriteDatas<TRecList7, TRec7>(Datas);

    Assert.AreEqual(Frame.Grid.Cells[1, 1], '11');

  finally
    Frame.Free;
  end;
end;

function TTestDTFExtractColProp.DetectItemType<T>(Value: T): string;
var
  LType: TRttiType;
  LField: TRttiField;
begin
  LType := TRttiContext.Create.GetType(TypeInfo(T));
  case LType.TypeKind of
  tkDynArray:
    Result := (LType as TRttiDynamicArrayType).ElementType.Name;
  tkRecord:
    begin
      for LField in LType.GetFields do
      begin
        if Assigned(TAttributeUtil.FindAttribute<DataRowsAttribute>(LField.GetAttributes)) then
        begin
          if LField.FieldType.TypeKind = tkDynArray then
            Exit((LField.FieldType as TRttiDynamicArrayType).ElementType.Name)
          else if LField.FieldType.TypeKind = tkRecord then
            Exit(LField.FieldType.Name);
        end;
      end;
    end;
  end;
end;

procedure TTestDTFExtractColProp.TestDetectItemType;
var
  A1: TArray<TRec1>;
  R4: TRec4;  // [DaraRow]Items: TArray<TRec1>
  R42: TRec4_2;  // [DaraRow]Sum: TRec1
begin
  Assert.AreEqual(DetectItemType<TArray<TRec1>>(A1),  'TRec1');
  Assert.AreEqual(DetectItemType<TRec4>(R4),          'TRec1');
  Assert.AreEqual(DetectItemType<TRec4_2>(R42),       'TRec1');
end;

procedure TTestDTFExtractColProp.TestGetDataRowsArrayType;
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LField: TRttiField;

  Datas: TRec4;
begin
  LCtx := TRttiContext.Create;
  try
    LType := LCtx.GetType(TypeInfo(TRec4));
    LField := LType.GetField('Items');

    SetLength(Datas.Items, 2);

    Test<TRec1>(Datas.Items);
    Test<TRec1>(LField.GetValue(@Datas).AsType<TArray<TRec1>>);
  finally
    LCtx.Free;
  end;
end;

procedure TTestDTFExtractColProp.TestGetColPropsStaticArray;
var
  ColProps: TColInfoProps;
begin
  if not TExtractUtil.TryGetColProps<TRec7>(ColProps) then
    Assert.Fail;

  Assert.AreEqual(Length(ColProps), 5);
end;

procedure TTestDTFExtractColProp.TestFillDataRowsRec;
var
  Datas: TRec4;
  Frame: TDTFStrGridFrame;
begin
  Frame := TDTFStrGridFrame.Create(nil);
  try
    SetLength(Datas.Items, 2);
    Datas.Items[0].Int := 10;
    Datas.Items[0].Int2 := 21;
    Datas.Items[0].Str := 'abc';
    Datas.Items[0].Dbl := 1.123;
    Datas.Items[0].Dtm := Now;

    Datas.Items[1].Int := 20;
    Datas.Items[1].Int2 := 42;
    Datas.Items[1].Str := '가나다';
    Datas.Items[1].Dbl := 1.234;
    Datas.Items[1].Dtm := Now + 10;

    Frame.WriteDatas<TRec4, TRec1>(Datas);

    Assert.AreEqual(Frame.Grid.Cells[0, 1], '10');

  finally
    Frame.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestDTFExtractColProp);

end.
