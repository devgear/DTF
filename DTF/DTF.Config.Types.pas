unit DTF.Config.Types;

interface

uses
  System.SysUtils;

type
  IniFilenameAttribute = class(TCustomAttribute)
  private
    FFilename: string;
  public
    constructor Create(AFilename: string);
    property Filename: string read FFilename;
  end;

  TConfigPropAttribute<T> = class(TCustomAttribute)
  public
    constructor Create(ASection: string; ADefault: T);
  end;

  PropAttribute = class(TConfigPropAttribute<string>)
  end;

  IntPropAttribute = class(PropAttribute)
  end;


implementation

{ IniFilenameAttribute }

constructor IniFilenameAttribute.Create(AFilename: string);
begin
  FFilename := AFilename;
end;

{ TConfigPropAttribute<T> }

constructor TConfigPropAttribute<T>.Create(ASection: string; ADefault: T);
begin

end;

end.
