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
  private
    FSection: string;
  protected
    FDefault: TValue;
  public
    property Section: string read FSection;
    property Default: TValue read FDefault;
  end;

  PropAttribute<T> = class(TConfigPropAttribute)
  public
    constructor Create(ASection: string; ADefault: T); overload; virtual;
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

  EnumerationPropAttribute = class(PropAttribute<string>)
  end;
  EnumPropAttribute = EnumerationPropAttribute;

  RecordPropAttribute = class(PropAttribute<string>)
//  public
//    constructor Create(ASection: string; ADefault: string); override;
  end;
  RecPropAttribute = RecordPropAttribute;


implementation

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
end;

{ RecordPropAttribute }

//constructor RecordPropAttribute.Create(ASection, ADefault: string);
//begin
//  inherited ;
//
//end;

end.
