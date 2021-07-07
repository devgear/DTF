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
  public
    constructor Create(ADisplayWidth: Integer = DEFAULT_COLWIDTH; AFormat: string = ''); overload;

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

  TExtractColProp = class
    class function TryGetColProps(ATypeInfo: PTypeInfo; var Props: TGridColProps; ArrayField: TRttiField = nil; ArrayIndex: Integer = -1): Boolean; overload;
    class function TryGetColProps<T>(var Props: TGridColProps): Boolean; overload;
  end;

//  function DataRowcount: Integer;

implementation

{ TGridColAttribute }

constructor TGridColAttribute.Create(ADisplayWidth: Integer; AFormat: string);
begin
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
  cls: TClass;
  Val: TValue;
  LTypeData: PTypeData;
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
            // add
//            Idx := Length(Props);
//            SetLength(Props, Idx + 1);
//
//            Props[Idx].Kind := cpkArray;
//            Props[Idx].Attr := LAttr;
//            Props[Idx].Field := LField;
//            Props[Idx].ArrayIndex := I;
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

end.
