unit DTF.Service.Config;

interface

uses
  DTF.Service.Types, DTF.Config.Types,
  System.Rtti, System.TypInfo;

type
  TConfigServiceProvider = class;

  TConfigLoader = class
  private
    function TryConvertStrToValue(ATypeInfo: PTypeInfo;
      AStr: string; var Value: TValue): Boolean;
  protected
    FConfig: TConfigServiceProvider;

    procedure LoadConfig; virtual;
    procedure SaveConfig; virtual;

    /// ******** ///
    ///  ����� �޼ҵ� �籸�� : ASection, AIdent ���� �о� ��ȯ(������ ADefault ��ȯ)
    function ReadValue(const ASection, AIdent: string;
      ADefault: TValue): TValue; virtual; abstract;
    ///  ����� �޼ҵ� �籸�� : ASection, AIdent ������ ����
    procedure WriteValue(const ASection, AIdent: string;
      AValue: TValue);  virtual; abstract;
    /// ******** ///
  public
    constructor Create{(AConfig: TConfigServiceProvider)};
  end;

  TConfigServiceProvider = class(TDTFServiceProvider, IDTFConfigService)
  private
    FLoader: TConfigLoader;
  public
    constructor Create(ALoader: TConfigLoader = nil);
    destructor Destroy; override;
  end;

implementation

uses
  System.Types,
  System.SysUtils,
  DTF.Utils,
  DTF.Config.IniLoader;

{ TConfigLoader }

constructor TConfigLoader.Create{(AConfig: TConfigServiceProvider)};
begin
//  FConfig := AConfig;
end;

// FConfig���� TConfigPropAttribute ������ �׸��� ���� �о�(ReadValue ȣ��) �Ҵ�
procedure TConfigLoader.LoadConfig;
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LProp: TRttiProperty;
  LField: TRttiField;

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

      LValue := TValue.Empty;

      if LAttr is EnumPropAttribute{default = string} then
      // [������] �⺻�� = ���ڿ�
        // ���ڿ��⺻���� ������Ÿ������ ��ȯ �� �б�
      begin
        var DefaultValue: TValue;
        if TryConvertStrToValue(LProp.PropertyType.Handle, LAttr.Default.AsString, DefaultValue) then
          LValue := ReadValue(LAttr.Section, LProp.Name, DefaultValue);
      end
      else if LAttr is RecPropAttribute{default = 'string,string,..'} then
      // [����ü] �⺻�� = ���ڿ�(��ǥ�� ���� ����)
        // ����ü �ʵ忡 ������ �ε�
      begin
        LValue := LProp.GetValue(FConfig);

        var Idx := 0;
        var DefStrVals: TArray<string> := LAttr.Default.AsString.Split([',']);

        for LField in LProp.PropertyType.GetFields do
        begin
          if Length(DefStrVals) <= Idx then
            Break;

          var DefaultValue: TValue;
          if TryConvertStrToValue(LField.FieldType.Handle, DefStrVals[Idx], DefaultValue) then
          begin
            var FieldValue: TValue := ReadValue(LAttr.Section, LProp.Name + '.' + LField.Name, DefaultValue);
            LField.SetValue(LValue.GetReferenceToRawData, FieldValue);

            Inc(Idx);
          end;
        end;
      end
      else
        LValue := ReadValue(LAttr.Section, LProp.Name, LAttr.Default);

      if LValue.IsEmpty then
        raise Exception.CreateFmt('[TConfigLoader] Not support property type.(type: %s)', [LProp.PropertyType.Name]);

      LProp.SetValue(Fconfig, LValue);
    end;
  finally
    LCtx.Free;
  end;
end;

procedure TConfigLoader.SaveConfig;
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LProp: TRttiProperty;
  LField: TRttiField;

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

      if LAttr is RecPropAttribute{default = 'string,string,..'} then
      // [����ü] ������ �ʵ常 ����
      begin
        for LField in LProp.PropertyType.GetFields do
        begin
        end;
      end
      else
        WriteValue(LAttr.Section, LProp.Name, LProp.GetValue(FConfig));
    end;
  finally
    LCtx.Free;
  end;
end;

function TConfigLoader.TryConvertStrToValue(ATypeInfo: PTypeInfo; AStr: string;
  var Value: TValue): Boolean;
begin
  Value := TValue.Empty;
  try
    case ATypeInfo.Kind of
      tkInteger: Value := TValue.From<Integer>(StrToInt(AStr));
      tkInt64: Value := TValue.From<Int64>(StrToInt64(AStr));

      tkFloat: Value := TValue.From<Double>(StrToFloat(AStr));

      tkString,
      tkLString,
      tkWString,
      tkUString: Value := TValue.From<string>(AStr);

      tkEnumeration:
        begin
          var EnumValue: Integer := GetEnumValue(ATypeInfo, AStr);
          Value := TValue.FromOrdinal(ATypeInfo, EnumValue);
        end;

      // not support
      tkUnknown: ;
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
  except
    Value := TValue.Empty;
  end;

  Result := not Value.IsEmpty;

end;

{ TConfigServiceProvider }

constructor TConfigServiceProvider.Create(ALoader: TConfigLoader);
begin
  if not Assigned(ALoader) then
    ALoader := TIniConfigLoader.Create;//(Self);

  FLoader := ALoader;
  FLoader.FConfig := Self;
  FLoader.LoadConfig;
end;

destructor TConfigServiceProvider.Destroy;
begin
  FLoader.SaveConfig;
  FLoader.Free;

  inherited;
end;

end.
