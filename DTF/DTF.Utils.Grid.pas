unit DTF.Utils.Grid;

interface

uses
  System.SysUtils, DTF.Utils,
  System.Rtti, System.TypInfo;

type
{$REGION 'GridAttribute'}
  {  Attributes }
  TGridColAttribute = class(TCustomAttribute)
  const
    DEFAULT_COLWIDTH = 64;
  private
    FFormat: string;
    FColWidth: Integer;
    FCaption: string;
  public
    constructor Create(ACaption: string; ADisplayWidth: Integer = DEFAULT_COLWIDTH; AFormat: string = ''); overload;
    constructor Create(ADisplayWidth: Integer = DEFAULT_COLWIDTH; AFormat: string = ''); overload;

    property Caption: string read FCaption;
    property Format: string read FFormat;
    property ColWidth: Integer read FColWidth;

    function ValueToStr(Value: TValue): string; virtual; abstract;
  end;

  StrColAttribute = class(TGridColAttribute)
  public
    function ValueToStr(Value: TValue): string; override;
  end;

  IntColAttribute = class(TGridColAttribute)
  public
    function ValueToStr(Value: TValue): string; override;
  end;

  FloatColAttribute = class(TGridColAttribute)
  public
    function ValueToStr(Value: TValue): string; override;
  end;
  DblColAttribute = FloatColAttribute;

  DatetimeColAttribute = class(TGridColAttribute)
  public
    function ValueToStr(Value: TValue): string; override;
  end;
  DtmColAttribute = DatetimeColAttribute;

  ///////////////////////////
  /// Concept
  ColColorAttribute = class(TCustomAttribute)
//  public
//    constructor Create(AFontColor, ABgColor: TColor)
  end;

  SumAttribute = class(TCustomAttribute)
  private
    FFields: TArray<string>;
  public
    constructor Create(AFields: TArray<string>);
    property Fields: TArray<string> read FFields;
  end;

  AvgAttribute = class(TCustomAttribute)
  private
    FFields: string;
  public
    constructor Create(AFields: string);
    property Fields: string read FFields;
  end;

  DataRowsAttribute = class(TCustomAttribute)
  end;
{$ENDREGION 'GridAttribute'}

  { Utils }
  TGridColPropKind = (cpkField, cpkMethod, cpkArray);
  TGridColProp = record
    Kind: TGridColPropKind;
    Attr: TGridColAttribute;
    Field: TRttiField;
    Method: TRttiMethod;
    ArrayField: TRttiField;
    ArrayIndex: Integer;
  end;

  TGridColProps = TArray<TGridColProp>;
  TDataRecord = TArray<string>;
  TDataTable = TArray<TDataRecord>;

  TExtractColProp = class
    class function TryGetColProps(ATypeInfo: PTypeInfo; var Props: TGridColProps; ArrayField: TRttiField = nil; ArrayIndex: Integer = -1): Boolean; overload;
    class function TryGetColProps<T>(var Props: TGridColProps): Boolean; overload;

    class function GetRowCount<T>(ADataRec: T): Integer;

    class function ExtractDataRow<T>(AColProps: TGridColProps; AData: T): TDataRecord;
    class function ExtractDataTable<T>(AColProps: TGridColProps; ADatas: TArray<T>): TDataTable; overload;
    class function ExtractDataTable<DataType, ItemType>(AColProps: TGridColProps; ADataRec: DataType): TDataTable; overload;

  end;

//  function DataRowcount: Integer;

implementation

{ TGridColAttribute }

constructor TGridColAttribute.Create(ADisplayWidth: Integer; AFormat: string);
begin
  FFormat := AFormat;
  FColWidth := ADisplayWidth;
end;

constructor TGridColAttribute.Create(ACaption: string; ADisplayWidth: Integer;
  AFormat: string);
begin
  FCaption := ACaption;
  FFormat := AFormat;
  FColWidth := ADisplayWidth;
end;

{ StrColAttribute }

function StrColAttribute.ValueToStr(Value: TValue): string;
begin
  Result := Value.AsString;
end;

{ IntColAttribute }

function IntColAttribute.ValueToStr(Value: TValue): string;
begin
  Result := Value.AsInteger.ToString;
end;

{ FloatColAttribute }

function FloatColAttribute.ValueToStr(Value: TValue): string;
begin
  if FFormat = '' then
    Result := FloatToStr(Value.AsExtended)
  else
    Result := FormatFloat(FFormat, Value.AsExtended);
end;

{ DatetimeColAttribute }

function DatetimeColAttribute.ValueToStr(Value: TValue): string;
begin
  if Value.AsExtended = 0 then
    Result := ''
  else if FFormat = '' then
    Result := DatetimeToStr(Value.AsType<TDatetime>)
  else
    Result := FormatDatetime(FFormat, Value.AsType<TDatetime>);
end;

{ SumAttribute }

constructor SumAttribute.Create(AFields: TArray<string>);
begin
  FFields := AFields;
end;

{ AvgAttribute }

constructor AvgAttribute.Create(AFields: string);
begin
  FFields := AFields;
end;

{ TExtractColProp }

// 중복오류
// ColIdx 지정하지 않고 순서대로 설정
// Out of index

class function TExtractColProp.TryGetColProps(ATypeInfo: PTypeInfo;
  var Props: TGridColProps; ArrayField: TRttiField = nil; ArrayIndex: Integer = -1): Boolean;
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LField: TRttiField;
  LMethod: TRttiMethod;
  LAttr: TGridColAttribute;
  LFieldType: TRttiType;
  LArrType: TRttiArrayType;

  LCount: Integer;
  I, J, Idx, MinVal, MaxVal: Integer;
begin
  Result := False;
  try
    LCtx := TRttiContext.Create;
    try
      LType := LCtx.GetType(ATypeInfo);

      for LField in LType.GetFields do
      begin
        if not Assigned(LField.FieldType) then
          raise Exception.Create('If using static array then define the type first.(e.g. array[0..1] of string -> TArr2<string>, TArr2<T> = array[0..2] of T)');

        // 레코드 필드인 경우 레코드 분석
        if LField.FieldType.IsRecord then
        begin
          LFieldType := LField.FieldType;
          if not TryGetColProps(LFieldType.Handle, Props) then
            Exit;
        end;

        // 정적배열
        if LField.FieldType.TypeKind = tkArray then
        begin
          LArrType := LField.FieldType as TRttiArrayType;

          for I := 0 to (LArrType.TotalElementCount div LArrType.DimensionCount) - 1 do
          begin
            if not TryGetColProps(LArrType.ElementType.Handle, Props, LField, I) then
              Exit;
          end;
        end;

        // 배열인 경우 배열 타입 분석
        if LField.FieldType.TypeKind = tkDynArray then
        begin
          LFieldType := (LField.FieldType as TRttiDynamicArrayType).ElementType;
          if not TryGetColProps(LFieldType.Handle, Props) then
            Exit;
        end;

        LAttr := TAttributeUtil.FindAttribute<TGridColAttribute>(LField.GetAttributes);
        if not Assigned(LAttr) then
          Continue;

        Idx := Length(Props);
        SetLength(Props, Idx + 1);

        if Assigned(ArrayField) then
          Props[Idx].Kind := cpkArray
        else
          Props[Idx].Kind := cpkField;
        Props[Idx].Attr := LAttr;
        Props[Idx].Field := LField;
        Props[Idx].ArrayField := ArrayField;
        Props[Idx].ArrayIndex := ArrayIndex;
      end;

      for LMethod in LType.GetMethods do
      begin
        LAttr := TAttributeUtil.FindAttribute<TGridColAttribute>(LMethod.GetAttributes);
        if not Assigned(LAttr) then
          Continue;

        Idx := Length(Props);
        SetLength(Props, Idx + 1);

        Props[Idx].Kind := cpkMethod;
        Props[Idx].Attr := LAttr;
        Props[Idx].Method := LMethod;
        Props[Idx].ArrayField := ArrayField;
        Props[Idx].ArrayIndex := ArrayIndex;
      end;
    finally
      LCtx.Free;
    end;
    Result := True;
  except
  end;
end;

class function TExtractColProp.TryGetColProps<T>(var Props: TGridColProps): Boolean;
begin
  Result := TryGetColProps(TypeInfo(T), Props);
end;

class function TExtractColProp.ExtractDataRow<T>(AColProps: TGridColProps;
  AData: T): TDataRecord;
var
  I: Integer;
  ColProp: TGridColProp;
  Value, ArrValue: TValue;
  StrVal: string;
begin
  SetLength(Result, Length(AColProps));
  for I := 0 to Length(AColProps) - 1 do
  begin
    ColProp := AColProps[I];

    if not Assigned(ColProp.Attr) then
      Continue;

    Value := TValue.Empty;

    case ColProp.Kind of
      cpkField:
        Value := ColProp.Field.GetValue(@AData);
      cpkMethod:
        Value := ColProp.Method.Invoke(TValue.From<Pointer>(@AData), []);
      cpkArray:
        begin
          ArrValue := ColProp.ArrayField.GetValue(@AData);
          Value := ArrValue.GetArrayElement(ColProp.ArrayIndex);
          if Value.TypeInfo.Kind = tkRecord then
            Value := ColProp.Field.GetValue(ArrValue.GetReferenceToRawArrayElement(ColProp.ArrayIndex))
        end;
    end;

    if Value.IsEmpty then
      Continue;

    StrVal := ColProp.Attr.ValueToStr(Value);

    Result[I] := StrVal;
  end;
end;

class function TExtractColProp.ExtractDataTable<DataType, ItemType>(
  AColProps: TGridColProps; ADataRec: DataType): TDataTable;
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LField: TRttiField;
  LMethod: TRttiMethod;
  LAttr: DataRowsAttribute;

  ColProps: TGridColProps;

  Info: PTypeInfo;
  Data: PTypeData;
  LCount: Integer;
  Value: TValue;
begin
  if not TExtractColProp.TryGetColProps<ItemType>(ColProps) then
    Exit;

  LCtx := TRttiContext.Create;
  try
    LType := LCtx.GetType(TypeInfo(DataType));

    LCount := 0;
    for LField in LType.GetFields do
    begin
      LAttr := TAttributeUtil.FindAttribute<DataRowsAttribute>(LField.GetAttributes);
      if not Assigned(LAttr) then
        Continue;

      if LField.FieldType.TypeKind = tkDynArray then
      begin
        Value := LField.GetValue(@ADataRec);
        Result := Result + ExtractDataTable<ItemType>(ColProps, Value.AsType<TArray<ItemType>>);
      end
      else if LField.FieldType.IsRecord then
      begin
        Value := LField.GetValue(@ADataRec);
        Result := Result + [ExtractDataRow<ItemType>(ColProps, Value.AsType<ItemType>)];
      end;
    end;
  finally
    LCtx.Free;
  end;
end;

class function TExtractColProp.ExtractDataTable<T>(AColProps: TGridColProps;
  ADatas: TArray<T>): TDataTable;
var
  I: Integer;
begin
  SetLength(Result, Length(ADatas));
  for I := 0 to Length(ADatas) - 1 do
    Result[I] := ExtractDataRow<T>(AColProps, ADatas[I]);
end;

class function TExtractColProp.GetRowCount<T>(ADataRec: T): Integer;
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LField: TRttiField;
  LAttr: DataRowsAttribute;
  Value: TValue;
begin
  LCtx := TRttiContext.Create;
  try
    LType := LCtx.GetType(TypeInfo(T));

    Result := 0;
    for LField in LType.GetFields do
    begin
      LAttr := TAttributeUtil.FindAttribute<DataRowsAttribute>(LField.GetAttributes);
      if not Assigned(LAttr) then
        Continue;

      if LField.FieldType.TypeKind = tkDynArray then
      begin
        Value := LField.GetValue(@ADataRec);
        Result := Result + Value.GetArrayLength;
      end
      else if LField.FieldType.IsRecord then
      begin
        Inc(Result);
      end;
    end;
  finally
    LCtx.Free;
  end;
end;

end.
