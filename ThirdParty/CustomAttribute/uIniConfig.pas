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
  IniConfigAttribute = class(TCustomAttribute)
  private
    FFilename: string;
  public
    constructor Create(const AFilename: string);
    property Filename: string read FFilename;
  end;

  TCusumtIniAttribute = class(TCustomAttribute)
  private
    FSection: string;
    function GetTypeKind: TTypeKind; virtual; abstract;
  public
    property Section: string read FSection;
    property TypeKind: TTypeKind read GetTypeKind;

    function ReadIniData(AIniFile: TIniFile; AIdent: string): TValue; virtual; abstract;
    procedure WriteIniData(AIniFile: TIniFile; AIdent: string; AValue: TValue); virtual; abstract;
  end;

  IniAttribute<T> = class(TCusumtIniAttribute)
  private
    FDefault: T;
    function GetTypeKind: TTypeKind; override;
  public
    constructor Create(const ASection: string; ADefault: T); overload;

    property Default: T read FDefault;
  end;

  IniBooleanAttribute = class(IniAttribute<Boolean>)
  public
    function ReadIniData(AIniFile: TIniFile; AIdent: string): TValue; override;
    procedure WriteIniData(AIniFile: TIniFile; AIdent: string; AValue: TValue); override;
  end;

  IniDateTimeAttribute = class(IniAttribute<Double>)
  public
    constructor Create(const ASection, ADefault: string); overload;

    function ReadIniData(AIniFile: TIniFile; AIdent: string): TValue; override;
    procedure WriteIniData(AIniFile: TIniFile; AIdent: string; AValue: TValue); override;
  end;

  IniFloatAttribute = class(IniAttribute<Double>)
  public
    function ReadIniData(AIniFile: TIniFile; AIdent: string): TValue; override;
    procedure WriteIniData(AIniFile: TIniFile; AIdent: string; AValue: TValue); override;
  end;

  IniInt64Attribute = class(IniAttribute<Int64>)
  public
    function ReadIniData(AIniFile: TIniFile; AIdent: string): TValue; override;
    procedure WriteIniData(AIniFile: TIniFile; AIdent: string; AValue: TValue); override;
  end;

  IniIntegerAttribute = class(IniAttribute<Integer>)
  public
    function ReadIniData(AIniFile: TIniFile; AIdent: string): TValue; override;
    procedure WriteIniData(AIniFile: TIniFile; AIdent: string; AValue: TValue); override;
  end;

  IniStringAttribute = class(IniAttribute<string>)
  public
    function ReadIniData(AIniFile: TIniFile; AIdent: string): TValue; override;
    procedure WriteIniData(AIniFile: TIniFile; AIdent: string; AValue: TValue); override;
  end;

  IniEnumAttribute = class(IniAttribute<Integer>)
    function ReadIniData(AIniFile: TIniFile; AIdent: string): TValue; override;
    procedure WriteIniData(AIniFile: TIniFile; AIdent: string; AValue: TValue); override;
  end;

  //////
  IniFilenameAttribute = class(TCusumtIniAttribute)
  private
    FFilename: string;
  public
    constructor Create(AFilename: string);
    property Filename: string read FFilename;
  end;

  TIniConfig = class(TInterfacedObject)
  private
    FTarget: TObject;
    FIniFile: TIniFile;
  public
    constructor Create(const ATarget: TObject; const AName: string = ''); virtual;
    destructor Destroy; override;

    procedure LoadFromFile;
    procedure SaveToFile;
  end;

implementation


{ IniConfigAttribute }

constructor IniConfigAttribute.Create(const AFilename: string);
begin
  FFilename := AFilename;
end;

{ IniAttribute<T> }

constructor IniAttribute<T>.Create(const ASection: string; ADefault: T);
begin
  FSection := UpperCase(ASection);
  FDefault := ADefault;
end;

function IniAttribute<T>.GetTypeKind: TTypeKind;
begin
  Result := System.GetTypeKind(T);
end;

{ IniBooleanAttribute }

function IniBooleanAttribute.ReadIniData(AIniFile: TIniFile; AIdent: string): TValue;
begin
  Result := AIniFile.ReadBool(FSection, AIdent, FDefault);
end;

procedure IniBooleanAttribute.WriteIniData(AIniFile: TIniFile; AIdent: string; AValue: TValue);
begin
  AIniFile.WriteBool(FSection, AIdent, AValue.AsBoolean);
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

function IniDateTimeAttribute.ReadIniData(AIniFile: TIniFile; AIdent: string): TValue;
begin
  Result := AIniFile.ReadDateTime(FSection, AIdent, FDefault);
end;

procedure IniDateTimeAttribute.WriteIniData(AIniFile: TIniFile; AIdent: string; AValue: TValue);
begin
  AIniFile.WriteDateTime(FSection, AIdent, AValue.AsExtended);
end;

{ IniFloatAttribute }

function IniFloatAttribute.ReadIniData(AIniFile: TIniFile; AIdent: string): TValue;
begin
  Result := AIniFile.ReadFloat(FSection, AIdent, FDefault);
end;

procedure IniFloatAttribute.WriteIniData(AIniFile: TIniFile; AIdent: string; AValue: TValue);
begin
  AIniFile.WriteFloat(FSection, AIdent, AValue.AsExtended);
end;

{ IniInt64Attribute }

function IniInt64Attribute.ReadIniData(AIniFile: TIniFile; AIdent: string): TValue;
begin
  Result := AIniFile.ReadInt64(FSection, AIdent, FDefault);
end;

procedure IniInt64Attribute.WriteIniData(AIniFile: TIniFile; AIdent: string; AValue: TValue);
begin
  AIniFile.WriteInt64(FSection, AIdent, AValue.AsInt64);
end;

{ IniIntegerAttribute }

function IniIntegerAttribute.ReadIniData(AIniFile: TIniFile; AIdent: string): TValue;
begin
  Result := AIniFile.ReadInteger(FSection, AIdent, FDefault);
end;

procedure IniIntegerAttribute.WriteIniData(AIniFile: TIniFile; AIdent: string; AValue: TValue);
begin
  AIniFile.WriteInteger(FSection, AIdent, AValue.AsInteger);
end;

{ IniStringAttribute }

function IniStringAttribute.ReadIniData(AIniFile: TIniFile; AIdent: string): TValue;
begin
  Result := AIniFile.ReadString(FSection, AIdent, FDefault);
end;

procedure IniStringAttribute.WriteIniData(AIniFile: TIniFile; AIdent: string; AValue: TValue);
begin
  AIniFile.WriteString(FSection, AIdent, AValue.AsString);
end;

{ IniEnumAttribute }

function IniEnumAttribute.ReadIniData(AIniFile: TIniFile; AIdent: string): TValue;
begin
  Result := AIniFile.ReadInteger(FSection, AIdent, FDefault);
end;

procedure IniEnumAttribute.WriteIniData(AIniFile: TIniFile; AIdent: string; AValue: TValue);
begin
  AIniFile.WriteInteger(FSection, AIdent, AValue.AsOrdinal);
end;

{ IniFilenameAttribute }

constructor IniFilenameAttribute.Create(AFilename: string);
begin
  FFilename := AFilename;
end;

{ TIniConfig }

constructor TIniConfig.Create(const ATarget: TObject; const AName: string);
var
  LRttiContext: TRttiContext;
  LRttiType: TRttiType;
  LAttribute: TCustomAttribute;
  LName, LFilename: string;
begin
  FTarget := ATarget;

  if AName <> '' then
    LName := AName
  else
  begin
    LRttiContext := TRttiContext.Create;
    try
      LRttiType := LRttiContext.GetType(FTarget.ClassType);
      for LAttribute in LRttiType.GetAttributes do
      begin
        if LAttribute is IniFilenameAttribute then
        begin
          LName := IniFilenameAttribute(LAttribute).Filename;
        end;
      end;
    finally
      LRttiContext.Free;
    end;
  end;

  if LName = '' then
    LFilename := ChangeFileExt(ParamStr(0), '.ini')
  else
    LFilename := ExtractFilePath(Paramstr(0)) + LName;

  FIniFile := TIniFile.Create(LFilename);
  LoadFromFile;
end;

destructor TIniConfig.Destroy;
begin
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
  LValue, LPropValue: TValue;
  // For record
  LRecord: TRttiRecordType;
  LField: TRttiField;
  LClass: TRttiInstanceType;
begin
  LRttiContext := TRttiContext.Create;
  try
    LRttiType := LRttiContext.GetType(FTarget.ClassType);
    for LProp in LRttiType.GetProperties do
    begin
      if not LProp.IsReadable then
        Continue;

      for LAttribute in LProp.GetAttributes do
      begin
        LIniAttribute := TCusumtIniAttribute(LAttribute);

        if LProp.PropertyType.TypeKind = tkEnumeration then
        begin
          LValue := LIniAttribute.ReadIniData(FIniFile, LProp.Name);
          LPropValue := TValue.FromOrdinal(LProp.PropertyType.Handle, LValue.AsInt64);
        end
        else if LProp.PropertyType.TypeKind = tkRecord then
        begin
//          LProp.GetValue(Self).TypeInfo.
          LRecord := LRttiContext.GetType(LProp.GetValue(Self).TypeInfo).AsRecord;
//          LRecord.
          for LField in LRecord.GetFields do
          begin
            if LField.FieldType.TypeKind = LIniAttribute.TypeKind then
            begin
//              if LField.GetValue(Self).AsInteger = 0 then
//              begin
//                LField.SetValue(Self, TValue.From<Integer>(1));
//              end;
              LValue := LIniAttribute.ReadIniData(FIniFile, LProp.Name + '.' + LField.Name);
//              LField.SetValue(Self, LValue);
              LField.SetValue(LRecord, LValue);
//              LField.SetValue(LField, LValue);
            end;
          end;
          LPropValue := LProp.GetValue(Self);
        end
        else
          LPropValue := LIniAttribute.ReadIniData(FIniFile, LProp.Name);


//        TValue.FromVarRec()

        LProp.SetValue(Self, LPropValue);
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
    LRttiType := LRttiContext.GetType(FTarget.ClassType);
    for LProp in LRttiType.GetProperties do
    begin
      if not LProp.IsWritable then
        Continue;

      for LAttribute in LProp.GetAttributes do
      begin
        LIniAttribute := TCusumtIniAttribute(LAttribute);

        if LProp.PropertyType.TypeKind = tkRecord then
        begin

//          LIniAttribute.WriteIniData(FIniFIle, LProp.Name, LProp.GetValue(Self));
        end
        else
          LIniAttribute.WriteIniData(FIniFIle, LProp.Name, LProp.GetValue(Self));
      end;
    end;
  finally
    LRttiContext.Free;
  end;
end;

end.
