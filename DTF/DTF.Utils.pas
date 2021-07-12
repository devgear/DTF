unit DTF.Utils;

interface

uses
  System.Rtti, System.SysUtils;

type
  TAttributeUtil = class
    class function FindAttribute<T: TCustomAttribute>(const Attrs: TArray<TCustomAttribute>): T; overload;
    class function FindAttribute<T: TCustomAttribute>(const AObject: TObject): T; overload;
    class function GetAttributeCount<T: TCustomAttribute>(const AType: TRttiType): Integer;
  end;

  TGenericUtil = class
    class function AsString(const Value): string;
    class function AsInteger(const Value): Integer;
  end;

implementation

{ TAttributeUtil }

class function TAttributeUtil.FindAttribute<T>(
  const Attrs: TArray<TCustomAttribute>): T;
var
  Attr: TCustomAttribute;
begin
  Result := nil;
  for Attr in Attrs do
  begin
    if Attr is T then
      Exit(Attr as T);
  end;
end;

class function TAttributeUtil.FindAttribute<T>(const AObject: TObject): T;
begin
  Result := FindAttribute<T>(
    TRttiContext.Create
      .GetType(AObject.ClassType)
      .GetAttributes
  );
end;

class function TAttributeUtil.GetAttributeCount<T>(const AType: TRttiType): Integer;
var
  LField: TRttiField;
  LMethod: TRttiMethod;
  LAttr: TCustomAttribute;
  LFieldType: TRttiType;
begin
  Result := 0;

  for LField in AType.GetFields do
  begin
    if LField.FieldType.IsRecord then
    begin
      LFieldType := LField.FieldType;
      Result := Result + GetAttributeCount<T>(LFieldType);
      Continue;
    end;

    if LField.FieldType.TypeKind = tkDynArray then
    begin
      LFieldType := (LField.FieldType as TRttiDynamicArrayType).ElementType;
      Result := Result + GetAttributeCount<T>(LFieldType);
      Continue;
    end;

    for LAttr in LField.GetAttributes do
      if LAttr is T then
        Inc(Result);
  end;

  for LMethod in AType.GetMethods do
    for LAttr in LMethod.GetAttributes do
      if LAttr is T then
        Inc(Result);
end;

{ TGenericUtil }

class function TGenericUtil.AsInteger(const Value): Integer;
begin
  Result := Integer(Value);
end;

class function TGenericUtil.AsString(const Value): string;
begin
  Result := string(Value);
end;

end.
