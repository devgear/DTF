unit DTF.Config.IniLoader;

interface

uses
  DTF.Config.Types,
  DTF.Service.Config,
  System.SysUtils,
  System.IniFiles;


type
  TIniConfigLoader = class(TConfigLoader)
  private
    FIniFile: TIniFile;
    FFilename: string;

    procedure LoadIniFile;
    procedure LoadConfig;

    function IsDefaultType(AType: TTypeKind): Boolean;
  public
    procedure Load; override;
    procedure Save; override;
  end;

implementation

uses
  System.Rtti, System.TypInfo,
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

function TIniConfigLoader.IsDefaultType(AType: TTypeKind): Boolean;
begin
  Result := (AType in [
    tkInteger, tkInt64,
    tkString, tkUString, tkWString, tkLString
  ]);
end;

procedure TIniConfigLoader.Load;
begin
  LoadIniFile;
  LoadConfig;
end;

procedure TIniConfigLoader.Save;
begin
  FIniFile.Free;
end;

procedure TIniConfigLoader.LoadIniFile;
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

procedure TIniConfigLoader.LoadConfig;
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LProp: TRttiProperty;

  LAttr: TConfigPropAttribute;
  LValue, LDefault: TValue;
  EnumVal: Integer;
begin
  LCtx := TRttiContext.Create;
  try
    LType := LCtx.GetType(FConfig.ClassType);
    for LProp in LType.GetProperties do
    begin
      if not LProp.IsReadable then
        Continue;

      LAttr := TAttributeUtil.FindAttribute<TConfigPropAttribute>(LProp.GetAttributes);
      if not Assigned(LAttr) then
        Continue;

      if IsDefaultType(LProp.PropertyType.TypeKind) then
      begin
        LValue := FIniFile.ReadValue(LAttr.Section, LProp.Name, LAttr.Default);
        LProp.SetValue(FConfig, LValue);
      end
      else if LProp.PropertyType.TypeKind = tkEnumeration then
      begin
        if LAttr is BoolPropAttribute then
        begin
          LValue := FIniFile.ReadBool(LAttr.Section, LProp.Name, LAttr.Default.AsBoolean);
          LProp.SetValue(FConfig, LValue);
        end
        else if LAttr is EnumPropAttribute then
        begin
          EnumVal := GetEnumValue(LProp.PropertyType.Handle, LAttr.Default.AsString);
          LDefault := TValue.From<Integer>(EnumVal);
          LValue := TValue.From<Integer>(FIniFile.ReadInteger(LAttr.Section, LProp.Name, LDefault.AsInteger));
          { TODO : Integer value to Enum value }
//          LProp.SetValue(FConfig, LValue);
        end;
      end
      else if LProp.PropertyType.TypeKind = tkRecord then
      begin

      end;

    end;
  finally
    LCtx.Free;
  end;
end;

end.
