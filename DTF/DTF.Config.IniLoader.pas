unit DTF.Config.IniLoader;

interface

uses
  DTF.Config.Types,
  DTF.Service.Config,
  System.SysUtils,
  System.IniFiles,
  System.Rtti;


type
  TIniConfigLoader = class(TConfigLoader)
  private
    FIniFile: TIniFile;
    FFilename: string;

    procedure CreateIniFile;
  protected
    function ReadValue(const ASection, AIdent: string; ADefault: TValue): TValue; override;
    procedure WriteValue(const AAttr: TConfigPropAttribute; const ASection, AIdent: string; AValue: TValue); override;
  public
    procedure LoadConfig; override;
    procedure SaveConfig; override;
  end;

implementation

uses
  System.Types,
  DTF.Utils;

{ TIniFileHelper }

type
  TIniFileHelper = class helper for TIniFile
  public
    function ReadValue(const Section, Ident: string; Default: TValue): TValue;
  end;

function TIniFileHelper.ReadValue(const Section, Ident: string;
  Default: TValue): TValue;
begin
  Result := TValue.Empty;

  case Default.TypeInfo.Kind of
    tkInteger:  Result := TValue.From<Integer>(ReadInteger(Section, Ident, Default.AsInteger));
    tkInt64:    Result := TValue.From<Int64>(ReadInt64(Section, Ident, Default.AsInt64));
    tkString,
    tkUString,
    tkWString,
    tkLString:  Result := TValue.From<string>(ReadString(Section, Ident, Default.AsString));
    tkEnumeration:  Result := TValue.From<Boolean>(ReadBool(Section, Ident, Default.AsBoolean));
{
ReadString
ReadInt64
ReadBool
ReadFloat

}
  end;

end;

{ TIniConfigLoader }

procedure TIniConfigLoader.LoadConfig;
begin
  CreateIniFile;

  inherited LoadConfig;
end;

procedure TIniConfigLoader.SaveConfig;
begin
  inherited;

  FIniFile.Free;
end;

procedure TIniConfigLoader.CreateIniFile;
var
  LName: string;
  LAttr: IniFilenameAttribute;
begin
  LAttr := TAttributeUtil.FindAttribute<IniFilenameAttribute>(FConfig);
  if Assigned(LAttr) then
    LName := LAttr.Filename;

  if LName = '' then
    FFilename := ChangeFileExt(ParamStr(0), '.ini')
  else
    FFilename := ExtractFilePath(Paramstr(0)) + LName;
  FIniFile := TIniFile.Create(FFilename);
end;

function TIniConfigLoader.ReadValue(const ASection, AIdent: string;
  ADefault: TValue): TValue;
begin
  case ADefault.TypeInfo.Kind of
    tkString,
    tkLString,
    tkWString,
    tkUString:
      Result := TValue.From<string>(FIniFile.ReadString(ASection, AIdent, ADefault.AsString));
    tkInteger:
      Result := TValue.From<Integer>(FIniFile.ReadInteger(ASection, AIdent, ADefault.AsInteger));
    tkInt64:
      Result := TValue.From<Int64>(FIniFile.ReadInt64(ASection, AIdent, ADefault.AsInt64));
    tkFloat:
      Result := TValue.From<Double>(FIniFile.ReadFloat(ASection, AIdent, ADefault.AsExtended));
    tkEnumeration:
      if ADefault.TypeInfo.Name = 'Boolean' then
        Result := TValue.From<Boolean>(FIniFile.ReadBool(ASection, AIdent, ADefault.AsBoolean))
      else
      begin
        var IntVal := FIniFile.ReadInteger(ASection, AIdent, ADefault.AsOrdinal);
        Result := TValue.FromOrdinal(ADefault.TypeInfo, IntVal);
      end
  else
    Result := TValue.Empty;
  end;
end;

procedure TIniConfigLoader.WriteValue(const AAttr: TConfigPropAttribute;
  const ASection, AIdent: string; AValue: TValue);
begin
  if AAttr is IntegerPropAttribute then
    FIniFile.WriteInteger(ASection, AIdent, AValue.AsInteger);
end;

end.
