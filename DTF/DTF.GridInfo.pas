unit DTF.GridInfo;

interface

uses
  System.SysUtils, DTF.Utils,
  System.Rtti, System.TypInfo;

type
  {  Attributes }
  TGridColAttribute = class(TCustomAttribute)
  private
    FCol: Integer;
    FFormat: string;
    FColWidth: Integer;
  public
    constructor Create; overload;
    constructor Create(ACol: Integer; AFormat: string = ''); overload;
    constructor Create(ACol: Integer; AColWidth: Integer; AFormat: string = ''); overload;

    property Col: Integer read FCol;
    property ColWidth: Integer read FColWidth;
    property Format: string read FFormat;

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

  { Utils }
  TGridColProp = record
    Attr: TGridColAttribute;
    Field: TRttiField;
    Method: TRttiMethod;
  end;

  TGridColProps = TArray<TGridColProp>;

  TExtractColProp = class
    class function TryGetColProps(ATypeInfo: PTypeInfo; var Props: TGridColProps): Boolean; overload;
    class function TryGetColProps<T>(var Props: TGridColProps): Boolean; overload;
  end;

//  function DataRowcount: Integer;

implementation

{ TGridColAttribute }

constructor TGridColAttribute.Create;
begin

end;

constructor TGridColAttribute.Create(ACol: Integer; AFormat: string);
begin
  Create(ACol, -1, AFormat);
end;

constructor TGridColAttribute.Create(ACol, AColWidth: Integer; AFormat: string);
begin
  FCol := ACol;
  FColWidth := AColWidth;
  FFormat := AFormat;
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
  if FFormat = '' then
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
  var Props: TGridColProps): Boolean;
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LField: TRttiField;
  LMethod: TRttiMethod;
  LAttr: TGridColAttribute;
  LFieldType: TRttiType;

  LCount: Integer;
  Idx: Integer;
  cls: TClass;
begin
  Result := False;
  try
    LCtx := TRttiContext.Create;
    try
      LType := LCtx.GetType(ATypeInfo);

      if Length(Props) = 0 then
      begin
        LCount := TAttributeUtil.GetAttributeCount<TGridColAttribute>(LType);
        SetLength(Props, LCount);
      end;

      for LField in LType.GetFields do
      begin
        // 레코드 필드인 경우 레코드 분석
        if LField.FieldType.IsRecord then
        begin
          LFieldType := LField.FieldType;
          if not TryGetColProps(LFieldType.Handle, Props) then
            Exit;
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

        idx := LAttr.Col;
        if Idx >= Length(Props) then
          SetLength(Props, Idx + 1);

        Props[Idx].Attr := LAttr;
        Props[Idx].Field := LField;
      end;

      for LMethod in LType.GetMethods do
      begin
        LAttr := TAttributeUtil.FindAttribute<TGridColAttribute>(LMethod.GetAttributes);
        if not Assigned(LAttr) then
          Continue;

        idx := LAttr.Col;
        if Idx >= Length(Props) then
          SetLength(Props, Idx + 1);

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
