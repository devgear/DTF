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

    procedure LoadIniFile;
    procedure LoadConfig;

    function IsDefaultType(AType: TTypeKind): Boolean;
    function ConvertStrToValue(AType: TTypeKind; AStr: string): TValue;
  public
    procedure Load; override;
    procedure Save; override;
  end;

implementation

uses
  System.TypInfo,
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

function TIniConfigLoader.ConvertStrToValue(AType: TTypeKind;
  AStr: string): TValue;
begin
  case AType of
    tkInteger,
    tkInt64: Result := TValue.From<Integer>(StrToIntDef(AStr, 0));

    tkFloat: ;

    tkString,
    tkLString,
    tkWString,
    tkUString: Result := TValue.From<string>(AStr);

    tkUnknown: ;
    tkEnumeration: ;
    tkSet: ;
    tkClass: ;
    tkMethod: ;
    tkVariant: ;
    tkArray: ;
    tkRecord: ;
    tkInterface: ;
    tkDynArray: ;
    tkClassRef: ;
    tkPointer: ;
    tkProcedure: ;
    tkMRecord: ;
  end;
end;

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
  LField: TRttiField;
  LRecord: TRttiRecordType;

  LAttr: TConfigPropAttribute;
  LValue, LDefaultValue: TValue;
  EnumInt, DefEnumInt: Integer;

  I: Integer;
  LDefaultVals: TArray<string>;
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
          DefEnumInt := GetEnumValue(LProp.PropertyType.Handle, LAttr.Default.AsString);
          EnumInt := FIniFile.ReadInteger(LAttr.Section, LProp.Name, DefEnumInt);
          LValue := TValue.FromOrdinal(LProp.PropertyType.Handle, EnumInt);
          LProp.SetValue(FConfig, LValue);
        end;
      end
      else if LProp.PropertyType.TypeKind = tkRecord then
      begin
        if not (LAttr is RecPropAttribute) then
          Exit;

        LRecord := LCtx.GetType(LProp.GetValue(FConfig).TypeInfo).AsRecord;
        LDefaultVals := LAttr.Default.AsString.Split([',']);
        for I := 0 to Length(LRecord.GetFields) - 1 do
        begin
          LField := LRecord.GetFields[I];
          if IsDefaultType(LField.FieldType.TypeKind) then
          begin
            LDefaultValue := ConvertStrToValue(LField.FieldType.TypeKind, LDefaultVals[I]);

            LValue := FIniFile.ReadValue(LAttr.Section, LProp.Name + '.' + LField.Name, LDefaultValue);
            WriteLn(LValue.ToString);

            { TODO : 어떤 인스턴스를 전달해야 하는가? }

//            LField.SetValue(LRecord.Handle.TypeData, LValue);
//            LField.SetValue(LRecord.AsInstance, LValue);
            LField.SetValue(LRecord, LValue);
//            LField.SetValue(FConfig, LValue);
          end;
        end;
      end;
    end;
  finally
    LCtx.Free;
  end;
end;

end.
