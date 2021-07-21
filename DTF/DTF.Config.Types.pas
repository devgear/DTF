unit DTF.Config.Types;

interface

uses
  System.Rtti,
  System.SysUtils;

type
  IniFilenameAttribute = class(TCustomAttribute)
  private
    FFilename: string;
  public
    constructor Create(AFilename: string);
    property Filename: string read FFilename;
  end;

  TConfigPropAttribute = class(TCustomAttribute)
  protected
    FSection: string;
    FDefault: TValue;
  public
    property Section: string read FSection;
    property &Default: TValue read FDefault;
  end;

  PropAttribute<T> = class(TConfigPropAttribute)
  public
    constructor Create(ASection: string; ADefault: T); overload;
    constructor Create(ASection: string); overload;
  end;

  StringPropAttribute = class(PropAttribute<string>)
  end;
  StrPropAttribute = StringPropAttribute;

  IntegerPropAttribute = class(PropAttribute<Integer>)
  end;
  IntPropAttribute = IntegerPropAttribute;

  Int64PropAttribute = class(PropAttribute<Int64>)
  end;

  FloatPropAttribute = class(PropAttribute<Double>)
  end;
  DblPropAttribute = FloatPropAttribute;

  DateTimeAttribute = class(PropAttribute<TDateTime>)
  end;

  BooleanPropAttribute = class(PropAttribute<Boolean>)
  end;
  BoolPropAttribute = BooleanPropAttribute;

{
    [EnumProp('Test', 'wsMaximized')]
    property WindowState: TWindowState read FWindowState write FWindowState;
}
  EnumerationPropAttribute = class(PropAttribute<string>)
  end;
  EnumPropAttribute = EnumerationPropAttribute;

  {
    [RecProp('Test', 'Left,Top', '10, 20')]
    [RecProp('Test', 'Left,Top,Rigth,Bottom', '10, 20')]
    property WindowBounds: TRect read FWindowBounds write FWindowBounds;
  }
  RecordPropAttribute = class(PropAttribute<string>)
  private
    FField: string;
    FFields: TArray<string>;
    FDefaults: TArray<string>;
  public
    constructor Create(ASection: string; AFields: string; ADefaults: string = ''); overload;

    property Field: string read FField;
    property Fields: TArray<string> read FFields;
    property Defaults: TArray<string> read FDefaults;
  end;
  RecPropAttribute = RecordPropAttribute;


implementation

uses
  DTF.Utils;

{ IniFilenameAttribute }

constructor IniFilenameAttribute.Create(AFilename: string);
begin
  FFilename := AFilename;
end;

{ PropAttribute<T> }

constructor PropAttribute<T>.Create(ASection: string; ADefault: T);
begin
  FSection := ASection;
  FDefault := TValue.From<T>(ADefault);
end;

constructor PropAttribute<T>.Create(ASection: string);
begin
  FSection := ASection;
  FDefault := TValue.From<T>(System.Default(T));
end;

{ RecordPropAttribute }

constructor RecordPropAttribute.Create(ASection, AFields, ADefaults: string);
begin
  FSection := ASection;
  FDefault := ADefaults;
  FField := AFields;

  FFields := FField.Split([',']);
  if not FDefault.IsEmpty then
    FDefaults := FDefault.AsString.Split([',']);

  TArrayUtil.Trim(FFields);
  TArrayUtil.Trim(FDefaults);
end;

end.
