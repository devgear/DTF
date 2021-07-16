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
    procedure WriteValue(const ASection, AIdent: string; AValue: TValue); override;
  public
    procedure LoadConfig; override;
    procedure SaveConfig; override;
  end;

implementation

uses
  System.Types, System.TypInfo,
  DTF.Utils;

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

procedure TIniConfigLoader.WriteValue(const ASection, AIdent: string; AValue: TValue);
begin
  case AValue.Kind of
    tkString,
    tkLString,
    tkWString,
    tkUString:
      FIniFile.WriteString(ASection, AIdent, AValue.AsString);
    tkInteger:
      FIniFile.WriteInteger(ASection, AIdent, AValue.AsInteger);
    tkInt64:
      FIniFile.WriteInt64(ASection, AIdent, AValue.AsInt64);
    tkFloat:
      FIniFile.WriteFloat(ASection, AIdent, AValue.AsExtended);
    tkEnumeration:
      if AValue.TypeInfo.Name = 'Boolean' then
        FIniFile.WriteBool(ASection, AIdent, AValue.AsBoolean)
      else
        FIniFile.WriteInteger(ASection, AIdent, AValue.AsOrdinal);
  else
    raise Exception.CreateFmt('[TIniConfigLoader] Not support type.(type: %s)', [AValue.TypeInfo.Name]);
  end;
end;

end.
