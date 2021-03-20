// https://github.com/civilian7/CustomAttribute

unit uIniConfig;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Rtti,
  System.TypInfo,
  System.IniFiles;

type
  TCusumtIniAttribute = class(TCustomAttribute)
  private
    FSection: string;
    FIdent: string;
  public
    property Section: string read FSection;
    property Ident: string read FIdent write FIdent;

    function ReadIniData(AIniFile: TIniFile): TValue; virtual; abstract;
    procedure WriteIniData(AIniFile: TIniFile; AValue: TValue); virtual; abstract;
  end;

  IniAttribute<T> = class(TCusumtIniAttribute)
  private
    FDefault: T;
  public
    constructor Create(const ASection: string; ADefault: T); overload;
    constructor Create(const ASection, AIdent: string; ADefault: T); overload;

    property Default: T read FDefault;
  end;

  IniBooleanAttribute = class(IniAttribute<Boolean>)
  public
    function ReadIniData(AIniFile: TIniFile): TValue; override;
    procedure WriteIniData(AIniFile: TIniFile; AValue: TValue); override;
  end;

  IniDateTimeAttribute = class(IniAttribute<Double>)
  public
    constructor Create(const ASection, ADefault: string); overload;

    function ReadIniData(AIniFile: TIniFile): TValue; override;
    procedure WriteIniData(AIniFile: TIniFile; AValue: TValue); override;
  end;

  IniFloatAttribute = class(IniAttribute<Double>)
  public
    function ReadIniData(AIniFile: TIniFile): TValue; override;
    procedure WriteIniData(AIniFile: TIniFile; AValue: TValue); override;
  end;

  IniInt64Attribute = class(IniAttribute<Int64>)
  public
    function ReadIniData(AIniFile: TIniFile): TValue; override;
    procedure WriteIniData(AIniFile: TIniFile; AValue: TValue); override;
  end;

  IniIntegerAttribute = class(IniAttribute<Integer>)
  public
    function ReadIniData(AIniFile: TIniFile): TValue; override;
    procedure WriteIniData(AIniFile: TIniFile; AValue: TValue); override;
  end;

  IniStringAttribute = class(IniAttribute<string>)
  public
    function ReadIniData(AIniFile: TIniFile): TValue; override;
    procedure WriteIniData(AIniFile: TIniFile; AValue: TValue); override;
  end;

  IniEnumAttribute = class(IniAttribute<Integer>)
    function ReadIniData(AIniFile: TIniFile): TValue; override;
    procedure WriteIniData(AIniFile: TIniFile; AValue: TValue); override;
  end;

  //////
  TIniConfig = class(TObject)
  private
    FAutoSave: Boolean;
    FIniFile: TIniFile;
  public
    constructor Create(const AName: string = ''); virtual;
    destructor Destroy; override;

    procedure LoadFromFile;
    procedure SaveToFile;

    property AutoSave: Boolean read FAutoSave write FAutoSave;
  end;

implementation


{ IniAttribute<T> }

constructor IniAttribute<T>.Create(const ASection: string; ADefault: T);
begin
  FSection := UpperCase(ASection);
  FDefault := ADefault;
end;

constructor IniAttribute<T>.Create(const ASection, AIdent: string; ADefault: T);
begin
  FSection := UpperCase(ASection);
  FIdent   := AIdent;
  FDefault := ADefault;
end;

{ IniBooleanAttribute }

function IniBooleanAttribute.ReadIniData(AIniFile: TIniFile): TValue;
begin
  Result := AIniFile.ReadBool(FSection, FIdent, FDefault);
end;

procedure IniBooleanAttribute.WriteIniData(AIniFile: TIniFile; AValue: TValue);
begin
  AIniFile.WriteBool(FSection, FIdent, AValue.AsBoolean);
end;

{ IniDateTimeAttribute }

constructor IniDateTimeAttribute.Create(const ASection, ADefault: string);
begin
  FSection := UpperCase(ASection);
  if (ADefault <> '') then
    FDefault := StrToDateTime(ADefault)
  else
    FDefault := 0;
end;

function IniDateTimeAttribute.ReadIniData(AIniFile: TIniFile): TValue;
begin
  Result := AIniFile.ReadDateTime(FSection, FIdent, FDefault);
end;

procedure IniDateTimeAttribute.WriteIniData(AIniFile: TIniFile; AValue: TValue);
begin
  AIniFile.WriteDateTime(FSection, FIdent, AValue.AsExtended);
end;

{ IniFloatAttribute }

function IniFloatAttribute.ReadIniData(AIniFile: TIniFile): TValue;
begin
  Result := AIniFile.ReadFloat(FSection, FIdent, FDefault);
end;

procedure IniFloatAttribute.WriteIniData(AIniFile: TIniFile; AValue: TValue);
begin
  AIniFile.WriteFloat(FSection, FIdent, AValue.AsExtended);
end;

{ IniInt64Attribute }

function IniInt64Attribute.ReadIniData(AIniFile: TIniFile): TValue;
begin
  Result := AIniFile.ReadInt64(FSection, FIdent, FDefault);
end;

procedure IniInt64Attribute.WriteIniData(AIniFile: TIniFile; AValue: TValue);
begin
  AIniFile.WriteInt64(FSection, FIdent, AValue.AsInt64);
end;

{ IniIntegerAttribute }

function IniIntegerAttribute.ReadIniData(AIniFile: TIniFile): TValue;
begin
  Result := AIniFile.ReadInteger(FSection, FIdent, FDefault);
end;

procedure IniIntegerAttribute.WriteIniData(AIniFile: TIniFile; AValue: TValue);
begin
  AIniFile.WriteInteger(FSection, FIdent, AValue.AsInteger);
end;

{ IniStringAttribute }

function IniStringAttribute.ReadIniData(AIniFile: TIniFile): TValue;
begin
  Result := AIniFile.ReadString(FSection, FIdent, FDefault);
end;

procedure IniStringAttribute.WriteIniData(AIniFile: TIniFile; AValue: TValue);
begin
  AIniFile.WriteString(FSection, FIdent, AValue.AsString);
end;

{ IniEnumAttribute }

function IniEnumAttribute.ReadIniData(AIniFile: TIniFile): TValue;
begin
  Result := AIniFile.ReadInteger(FSection, FIdent, FDefault);
end;

procedure IniEnumAttribute.WriteIniData(AIniFile: TIniFile; AValue: TValue);
begin
  AIniFile.WriteInteger(FSection, FIdent, AValue.AsOrdinal);
end;

{ TIniConfig }

constructor TIniConfig.Create(const AName: string);
var
  LName: string;
begin
  FAutoSave := True;

  if (AName = '') then
    LName := ChangeFileExt(ParamStr(0), '.ini')
  else
    LName := ExtractFilePath(ParamStr(0)) + AName;

  FIniFile := TIniFile.Create(LName);
  if FAutoSave then
    LoadFromFile;
end;

destructor TIniConfig.Destroy;
begin
  if FAutoSave then
    SaveToFile;

  FIniFile.Free;

  inherited;
end;

procedure TIniConfig.LoadFromFile;
var
  LAttribute: TCustomAttribute;
  LIniAttribute: TCusumtIniAttribute;
  LProp: TRttiProperty;
  LRttiContext: TRttiContext;
  LRttiType: TRttiType;
  LValue: TValue;
  // For record
  LRecord: TRttiRecordType;
  LField: TRttiField;
begin
  LRttiContext := TRttiContext.Create;
  try
    LRttiType := LRttiContext.GetType(Self.ClassType);
    for LProp in LRttiType.GetProperties do
    begin
      if not LProp.IsReadable then
        Continue;

      for LAttribute in LProp.GetAttributes do
      begin
        LIniAttribute := TCusumtIniAttribute(LAttribute);
        if LIniAttribute.Ident = '' then
          LIniAttribute.Ident := LProp.Name;

        LValue := LIniAttribute.ReadIniData(FIniFile);
        if LProp.PropertyType.TypeKind = tkEnumeration then
          LValue := TValue.FromOrdinal(LProp.PropertyType.Handle, LValue.AsInt64)
        else if LProp.PropertyType.TypeKind = tkRecord then
        begin
//          LProp.GetValue(Self).TypeInfo.
          LRecord := LRttiContext.GetType(LProp.GetValue(Self).TypeInfo).AsRecord;
          for LField in LRecord.GetFields do
          begin
            if LField.Name = '' then
            begin
            end;

            if LField.FieldType.TypeKind = tkInteger then
            begin
            end;
          end;


//          LValue := TValue.Make(LProp.GetValue(Self))
        end;

//        TValue.FromVarRec()

        LProp.SetValue(Self, LValue);
      end;
    end;
  finally
    LRttiContext.Free;
  end;
end;

procedure TIniConfig.SaveToFile;
var
  LAttribute: TCustomAttribute;
  LIniAttribute: TCusumtIniAttribute;
  LProp: TRttiProperty;
  LRttiContext: TRttiContext;
  LRttiType: TRttiType;
begin
  LRttiContext := TRttiContext.Create;
  try
    LRttiType := LRttiContext.GetType(Self.ClassType);
    for LProp in LRttiType.GetProperties do
    begin
      if not LProp.IsWritable then
        Continue;

      for LAttribute in LProp.GetAttributes do
      begin
        LIniAttribute := TCusumtIniAttribute(LAttribute);
        if LIniAttribute.Ident = '' then
          LIniAttribute.Ident := LProp.Name;

        LIniAttribute.WriteIniData(FIniFIle, LProp.GetValue(Self));
      end;
    end;
  finally
    LRttiContext.Free;
  end;
end;

end.
