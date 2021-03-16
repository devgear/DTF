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

    function ReadData(AIniFile: TIniFile; ATypInf: PTypeInfo): TValue; virtual; abstract;
    procedure WriteData(AIniFile: TIniFile; AValue: TValue; ATypInf: PTypeInfo); virtual; abstract;
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
    function ReadData(AIniFile: TIniFile; ATypInf: PTypeInfo): TValue; override;
    procedure WriteData(AIniFile: TIniFile; AValue: TValue; ATypInf: PTypeInfo); override;
  end;

  IniDateTimeAttribute = class(IniAttribute<Double>)
  public
    constructor Create(const ASection, ADefault: string); overload;

    function ReadData(AIniFile: TIniFile; ATypInf: PTypeInfo): TValue; override;
    procedure WriteData(AIniFile: TIniFile; AValue: TValue; ATypInf: PTypeInfo); override;
  end;

  IniFloatAttribute = class(IniAttribute<Double>)
  public
    function ReadData(AIniFile: TIniFile; ATypInf: PTypeInfo): TValue; override;
    procedure WriteData(AIniFile: TIniFile; AValue: TValue; ATypInf: PTypeInfo); override;
  end;

  IniInt64Attribute = class(IniAttribute<Int64>)
  public
    function ReadData(AIniFile: TIniFile; ATypInf: PTypeInfo): TValue; override;
    procedure WriteData(AIniFile: TIniFile; AValue: TValue; ATypInf: PTypeInfo); override;
  end;

  IniIntegerAttribute = class(IniAttribute<Integer>)
  public
    function ReadData(AIniFile: TIniFile; ATypInf: PTypeInfo): TValue; override;
    procedure WriteData(AIniFile: TIniFile; AValue: TValue; ATypInf: PTypeInfo); override;
  end;

  IniStringAttribute = class(IniAttribute<string>)
  public
    function ReadData(AIniFile: TIniFile; ATypInf: PTypeInfo): TValue; override;
    procedure WriteData(AIniFile: TIniFile; AValue: TValue; ATypInf: PTypeInfo); override;
  end;

  IniEnumAttribute = class(IniIntegerAttribute)
    function ReadData(AIniFile: TIniFile; ATypInf: PTypeInfo): TValue; override;
    procedure WriteData(AIniFile: TIniFile; AValue: TValue; ATypInf: PTypeInfo); override;
  end;

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

function IniBooleanAttribute.ReadData(AIniFile: TIniFile; ATypInf: PTypeInfo): TValue;
begin
  Result := AIniFile.ReadBool(FSection, FIdent, FDefault);
end;

procedure IniBooleanAttribute.WriteData(AIniFile: TIniFile; AValue: TValue; ATypInf: PTypeInfo);
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

function IniDateTimeAttribute.ReadData(AIniFile: TIniFile; ATypInf: PTypeInfo): TValue;
begin
  Result := AIniFile.ReadDateTime(FSection, FIdent, FDefault);
end;

procedure IniDateTimeAttribute.WriteData(AIniFile: TIniFile; AValue: TValue; ATypInf: PTypeInfo);
begin
  AIniFile.WriteDateTime(FSection, FIdent, AValue.AsExtended);
end;

{ IniFloatAttribute }

function IniFloatAttribute.ReadData(AIniFile: TIniFile; ATypInf: PTypeInfo): TValue;
begin
  Result := AIniFile.ReadFloat(FSection, FIdent, FDefault);
end;

procedure IniFloatAttribute.WriteData(AIniFile: TIniFile; AValue: TValue; ATypInf: PTypeInfo);
begin
  AIniFile.WriteFloat(FSection, FIdent, AValue.AsExtended);
end;

{ IniInt64Attribute }

function IniInt64Attribute.ReadData(AIniFile: TIniFile; ATypInf: PTypeInfo): TValue;
begin
  Result := AIniFile.ReadInt64(FSection, FIdent, FDefault);
end;

procedure IniInt64Attribute.WriteData(AIniFile: TIniFile; AValue: TValue; ATypInf: PTypeInfo);
begin
  AIniFile.WriteInt64(FSection, FIdent, AValue.AsInt64);
end;

{ IniIntegerAttribute }

function IniIntegerAttribute.ReadData(AIniFile: TIniFile; ATypInf: PTypeInfo): TValue;
begin
  Result := AIniFile.ReadInteger(FSection, FIdent, FDefault);
end;

procedure IniIntegerAttribute.WriteData(AIniFile: TIniFile; AValue: TValue; ATypInf: PTypeInfo);
begin
  AIniFile.WriteInteger(FSection, FIdent, AValue.AsInteger);
end;

{ IniStringAttribute }

function IniStringAttribute.ReadData(AIniFile: TIniFile; ATypInf: PTypeInfo): TValue;
begin
  Result := AIniFile.ReadString(FSection, FIdent, FDefault);
end;

procedure IniStringAttribute.WriteData(AIniFile: TIniFile; AValue: TValue; ATypInf: PTypeInfo);
begin
  AIniFile.WriteString(FSection, FIdent, AValue.AsString);
end;

{ IniEnumAttribute }

function IniEnumAttribute.ReadData(AIniFile: TIniFile; ATypInf: PTypeInfo): TValue;
var
  LValue: Integer;
begin
  LValue := AIniFile.ReadInteger(FSection, FIdent, FDefault);
  TValue.Make(LValue, ATypInf, Result);
end;

procedure IniEnumAttribute.WriteData(AIniFile: TIniFile; AValue: TValue;
  ATypInf: PTypeInfo);
var
  LValue: Integer;
begin
  LValue := AValue.AsOrdinal;

  AIniFile.WriteInteger(FSection, FIdent, LValue);
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
begin
  LRttiContext := TRttiContext.Create;
  try
    LRttiType := LRttiContext.GetType(Self.ClassType);
    for LProp in LRttiType.GetProperties do
    begin
      for LAttribute in LProp.GetAttributes do
      begin
        LIniAttribute := TCusumtIniAttribute(LAttribute);
        if LIniAttribute.Ident = '' then
          LIniAttribute.Ident := LProp.Name;

        LProp.SetValue(Self, LIniAttribute.ReadData(FIniFile, LProp.PropertyType.Handle));
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
      for LAttribute in LProp.GetAttributes do
      begin
        LIniAttribute := TCusumtIniAttribute(LAttribute);
        if LIniAttribute.Ident = '' then
          LIniAttribute.Ident := LProp.Name;

        LIniAttribute.WriteData(FIniFIle, LProp.GetValue(Self), LProp.PropertyType.Handle);
      end;
    end;
  finally
    LRttiContext.Free;
  end;
end;

end.
