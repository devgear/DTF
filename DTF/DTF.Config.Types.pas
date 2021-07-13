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
  protected
    FSection: string;
  public
    constructor Create(ASection: string; ADefault: T);
  end;

  IntPropAttribute = class(PropAttribute<Integer>)
  end;

  BoolPropAttribute = class(PropAttribute<Boolean>)
  end;

  StrPropAttribute = class(PropAttribute<string>)
  end;

  EnumPropAttribute = class(PropAttribute<string>)
  end;


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

end.
