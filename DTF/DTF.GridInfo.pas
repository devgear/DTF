unit DTF.GridInfo;

interface

uses
  System.SysUtils, System.Rtti, DTF.Utils;

type
  {  Attributes }
  TGridColAttribute = class(TCustomAttribute)
  private
    FCol: Integer;
    FFormat: string;
    FColWidth: Integer;
  public
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
    class function TryGetColProps<T>(var Props: TGridColProps): Boolean;
  end;

implementation

{ TGridColAttribute }

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

class function TExtractColProp.TryGetColProps<T>(var Props: TGridColProps): Boolean;
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LField: TRttiField;
  LMethod: TRttiMethod;
  LAttr: TGridColAttribute;

  LCount: Integer;
  Idx: Integer;
begin
  Result := True;
  try
    LCtx := TRttiContext.Create;
    try
      LType := LCtx.GetType(TypeInfo(T));

      LCount := TAttributeUtil.GetAttributeCount<TGridColAttribute>(LType);
      SetLength(Props, LCount);

      for LField in LType.GetFields do
      begin
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
  except
    Result := False;
  end;
end;

end.
