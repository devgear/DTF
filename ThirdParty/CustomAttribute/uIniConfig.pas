// https://github.com/civilian7/CustomAttribute

unit uIniConfig;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Rtti,
  System.IniFiles;

type
  IniBooleanAttribute = class(TCustomAttribute)
  private
    FSection: string;
    FValue: Boolean;
  public
    constructor Create(const ASection: string; const AValue: Boolean);

    property Section: string read FSection;
    property Value: Boolean read FValue;
  end;

  IniDateTimeAttribute = class(TCustomAttribute)
  private
    FSection: string;
    FValue: TDateTime;
  public
    constructor Create(const ASection, AValue: string);

    property Section: string read FSection;
    property Value: TDateTime read FValue;
  end;

  IniFloatAttribute = class(TCustomAttribute)
  private
    FSection: string;
    FValue: Double;
  public
    constructor Create(const ASection: string; const AValue: Double);

    property Section: string read FSection;
    property Value: Double read FValue;
  end;

  IniInt64Attribute = class(TCustomAttribute)
  private
    FSection: string;
    FValue: Int64;
  public
    constructor Create(const ASection: string; const AValue: Int64);

    property Section: string read FSection;
    property Value: Int64 read FValue;
  end;

  IniIntegerAttribute = class(TCustomAttribute)
  private
    FSection: string;
    FValue: Integer;
  public
    constructor Create(const ASection: string; const AValue: Integer);

    property Section: string read FSection;
    property Value: Integer read FValue;
  end;

  IniStringAttribute = class(TCustomAttribute)
  private
    FSection: string;
    FValue: string;
  public
    constructor Create(const ASection, AValue: string);

    property Section: string read FSection;
    property Value: string read FValue;
  end;

  IniAttribute<T> = class(TCustomAttribute)
  private
    FSection: string;
    FValue: T;
  public
    constructor Create(const ASection: string; AValue: T);

    property Section: string read FSection;
    property Value: T read FValue;
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

{ IniBooleanAttribute }

constructor IniBooleanAttribute.Create(const ASection: string; const AValue: Boolean);
begin
  FSection := UpperCase(ASection);
  FValue := AValue;
end;

{ IniDateTimeAttribute }

constructor IniDateTimeAttribute.Create(const ASection, AValue: string);
begin
  FSection := UpperCase(ASection);
  if (AValue <> '') then
    FValue := StrToDateTime(AValue)
  else
    FValue := 0;
end;

{ IniFloatAttribute }

constructor IniFloatAttribute.Create(const ASection: string; const AValue: Double);
begin
  FSection := UpperCase(ASection);
  FValue := AValue;
end;

{ IniInt64Attribute }

constructor IniInt64Attribute.Create(const ASection: string; const AValue: Int64);
begin
  FSection := UpperCase(ASection);
  FValue := AValue;
end;

{ IniIntegerAttribute }

constructor IniIntegerAttribute.Create(const ASection: string; const AValue: Integer);
begin
  FSection := UpperCase(ASection);
  FValue := AValue;
end;

{ IniStringAttribute }

constructor IniStringAttribute.Create(const ASection, AValue: string);
begin
  FSection := UpperCase(ASection);
  FValue := AValue;
end;

{ IniAttribute<T> }

constructor IniAttribute<T>.Create(const ASection: string; AValue: T);
begin
  FSection := UpperCase(ASection);
  FValue := AValue;
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
          LProp.SetValue(Self, FIniFile.ReadBool(IniBooleanAttribute(LAttribute).Section, LProp.Name, IniBooleanAttribute(LAttribute).Value))
        else
        if LAttribute is IniDateTimeAttribute then
          LProp.SetValue(Self, FIniFile.ReadDateTime(IniDateTimeAttribute(LAttribute).Section, LProp.Name, IniDateTimeAttribute(LAttribute).Value))
        else
        if LAttribute is IniFloatAttribute then
          LProp.SetValue(Self, FIniFile.ReadFloat(IniFloatAttribute(LAttribute).Section, LProp.Name, IniFloatAttribute(LAttribute).Value))
        else
        if LAttribute is IniInt64Attribute then
          LProp.SetValue(Self, FIniFile.ReadInt64(IniStringAttribute(LAttribute).Section, LProp.Name, IniInt64Attribute(LAttribute).Value))
        else
        if LAttribute is IniIntegerAttribute then
          LProp.SetValue(Self, FIniFile.ReadInteger(IniIntegerAttribute(LAttribute).Section, LProp.Name, IniIntegerAttribute(LAttribute).Value))
        else
        if LAttribute is IniStringAttribute then
          LProp.SetValue(Self, FIniFile.ReadString(IniStringAttribute(LAttribute).Section, LProp.Name, IniStringAttribute(LAttribute).Value))
//        else
//        if LAttribute is IniAttribute then
//          LProp.SetValue(Self, FIniFile.ReadString(IniStringAttribute(LAttribute).Section, LProp.Name, IniStringAttribute(LAttribute).Value))
        ;
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
