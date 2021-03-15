// https://github.com/civilian7/CustomAttribute

unit uIniConfig;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Rtti,
  System.IniFiles;

type
  TCusumtIniAttribute = class(TCustomAttribute)
  private
    FSection: string;
    FIdent: string;
  public
    property Section: string read FSection;
    property Ident: string read FIdent write FIdent;

    function ReadData(AIniFile: TIniFile): TValue; virtual; abstract;
    procedure WriteData(AIniFile: TIniFile; AValue: TValue); virtual; abstract;
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
    function ReadData(AIniFile: TIniFile): TValue; override;
    procedure WriteData(AIniFile: TIniFile; AValue: TValue); override;
  end;

  IniDateTimeAttribute = class(IniAttribute<Double>)
  public
    constructor Create(const ASection, ADefault: string); overload;
  end;

  IniFloatAttribute = class(IniAttribute<Double>)
  end;

  IniInt64Attribute = class(IniAttribute<Int64>)
  end;

  IniIntegerAttribute = class(IniAttribute<Integer>)
  end;

  IniStringAttribute = class(IniAttribute<string>)
  public
    function ReadData(AIniFile: TIniFile): TValue; override;
    procedure WriteData(AIniFile: TIniFile; AValue: TValue); override;
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

function IniBooleanAttribute.ReadData(AIniFile: TIniFile): TValue;
begin
  Result := AIniFile.ReadBool(FSection, FIdent, FDefault);
end;

procedure IniBooleanAttribute.WriteData(AIniFile: TIniFile; AValue: TValue);
begin
  inherited;

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

{ IniStringAttribute }

function IniStringAttribute.ReadData(AIniFile: TIniFile): TValue;
begin
  Result := AIniFile.ReadString(FSection, FIdent, FDefault);
end;

procedure IniStringAttribute.WriteData(AIniFile: TIniFile; AValue: TValue);
begin
  inherited;

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

        LProp.SetValue(Self, LIniAttribute.ReadData(FIniFile));
//
//        if LAttribute is IniBooleanAttribute then
//          LProp.SetValue(Self, FIniFile.ReadBool(LSection, LIdent, IniBooleanAttribute(LAttribute).Default))
//        else
//        if LAttribute is IniDateTimeAttribute then
//          LProp.SetValue(Self, FIniFile.ReadDateTime(LSection, LIdent, IniDateTimeAttribute(LAttribute).Default))
//        else
//        if LAttribute is IniFloatAttribute then
//          LProp.SetValue(Self, FIniFile.ReadFloat(LSection, LIdent, IniFloatAttribute(LAttribute).Default))
//        else
//        if LAttribute is IniInt64Attribute then
//          LProp.SetValue(Self, FIniFile.ReadInt64(LSection, LIdent, IniInt64Attribute(LAttribute).Default))
//        else
//        if LAttribute is IniIntegerAttribute then
//          LProp.SetValue(Self, FIniFile.ReadInteger(LSection, LIdent, IniIntegerAttribute(LAttribute).Default))
//        else
//        if LAttribute is IniStringAttribute then
//          LProp.SetValue(Self, FIniFile.ReadString(LSection, LIdent, IniStringAttribute(LAttribute).Default))
//        ;
      end;
    end;
  finally
    LRttiContext.Free;
  end;
end;

procedure TIniConfig.SaveToFile;
var
  LAttribute: TCustomAttribute;
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
        if LAttribute is IniBooleanAttribute then
          FIniFile.WriteBool(IniBooleanAttribute(LAttribute).Section, LProp.Name, LProp.GetValue(Self).AsBoolean)
        else
        if LAttribute is IniDateTimeAttribute then
          FIniFile.WriteDateTime(IniDateTimeAttribute(LAttribute).Section, LProp.Name, LProp.GetValue(Self).AsExtended)
        else
        if LAttribute is IniFloatAttribute then
          FIniFile.WriteFloat(IniFloatAttribute(LAttribute).Section, LProp.Name, LProp.GetValue(Self).AsExtended)
        else
        if LAttribute is IniInt64Attribute then
          FIniFile.WriteInt64(IniInt64Attribute(LAttribute).Section, LProp.Name, LProp.GetValue(Self).AsInt64)
        else
        if LAttribute is IniIntegerAttribute then
          FIniFile.WriteInteger(IniIntegerAttribute(LAttribute).Section, LProp.Name, LProp.GetValue(Self).AsInteger)
        else
        if LAttribute is IniStringAttribute then
          FIniFile.WriteString(IniStringAttribute(LAttribute).Section, LProp.Name, LProp.GetValue(Self).AsString);
      end;
    end;
  finally
    LRttiContext.Free;
  end;
end;

end.
