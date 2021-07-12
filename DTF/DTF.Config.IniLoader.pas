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
    function ReadData<T>(const Section, Ident: string; Default: T): T;
    procedure WriteData<T>(const Section, Ident: string; Value: T);
    function ReadValue(const Section, Ident: string; Default: TValue): TValue;
  end;

function TIniFileHelper.ReadData<T>(const Section, Ident: string;
  Default: T): T;
var
  Value: TValue;
begin
  case PTypeInfo(TypeInfo(T)).Kind of
    tkInteger: Value := ReadInteger(Section, Ident, TGenericUtil.AsInteger(Default));
    tkString: Value := ReadString(Section, Ident, TGenericUtil.AsString(Default));
  end;
end;

function TIniFileHelper.ReadValue(const Section, Ident: string;
  Default: TValue): TValue;
begin
  Result := TValue.Empty;
  case Default.TypeInfo.Kind of
    tkInteger: Result := TValue.From<Integer>(ReadInteger(Section, Ident, Default.AsInteger));
  end;

end;

procedure TIniFileHelper.WriteData<T>(const Section, Ident: string; Value: T);
begin

end;

{ TIniConfigLoader }

procedure TIniConfigLoader.Load;
begin
  LoadIniFile;
  LoadConfig;
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
  LValue: TValue;
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

      { TODO : 타입의존성 제거할 것 }
      // FIniFile.ReadValue(S, I, Default): TValue;
      if LProp.PropertyType.TypeKind in [tkInteger, tkInt64] then
      begin
        LValue := FIniFile.ReadValue(LAttr.Section, LProp.Name, LAttr.Default);
        LProp.SetValue(FConfig, LValue);
      end;

    end;
  finally
    LCtx.Free;
  end;
end;

procedure TIniConfigLoader.Save;
begin
  FIniFile.Free;
end;

end.
