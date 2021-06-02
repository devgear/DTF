unit DTF.Types;

interface

uses
  System.Types, System.SysUtils, System.Rtti,
  DMX.DesignPattern,    // using DevMax frameworks(https://github.com/hjfactory/DevMax)
  DTF.Form.MDIChild;

type
  ///////////////////////////////////////////////
  ///  View
  TDTFForm = TDTFMDIChildForm;
  TDTFFormClass = class of TDTFForm;

  TAttributeClass = class of TCustomAttribute;

  ViewIdAttribute = class(TCustomAttribute)
  private
    FViewId: string;
  public
    constructor Create(AViewId: string);
    property ViewId: string read FViewId;
  end;

  TViewFactory = class(TClassFactory<string, TDTFFormClass>)
  protected
    function CalcKey(ACls: TDTFFormClass): string; override;
  end;

  ///////////////////////////////////////////////
  ///  StrGrid
  TGridColAttribute = class(TCustomAttribute)
  private
    FCol: Integer;
    FFormat: string;
    FColWidth: Integer;
  public
    constructor Create(ACol: Integer; AFormat: string = ''); overload;
    constructor Create(ACol: Integer; AColWidth: Integer; AFormat: string = ''); overload;

    property Col: Integer read FCol;
    property ColWidth: Integer read FColWidth;
    property Format: string read FFormat;

    function ValToStr(Value: TValue): string; virtual; abstract;
  end;

  StrColAttribute = class(TGridColAttribute)
  public
    function ValToStr(Value: TValue): string; override;
  end;

  IntColAttribute = class(TGridColAttribute)
  public
    function ValToStr(Value: TValue): string; override;
  end;

  FloatColAttribute = class(TGridColAttribute)
  public
    function ValToStr(Value: TValue): string; override;
  end;
  DblColAttribute = FloatColAttribute;

  DatetimeColAttribute = class(TGridColAttribute)
  public
    function ValToStr(Value: TValue): string; override;
  end;
  DtmColAttribute = DatetimeColAttribute;

  ColColorAttribute = class(TCustomAttribute)
//  public
//    constructor Create(AFontColor, ABgColor: TColor)
  end;

resourcestring
  // DataSet
  SDSDeleteConfirm = '선택한 데이터를 삭제할까요?';

implementation

{ ViewIdAttribute }

constructor ViewIdAttribute.Create(AViewId: string);
begin
  FViewId := AViewId;
end;

{ TViewFactory }

function TViewFactory.CalcKey(ACls: TDTFFormClass): string;
begin
  Result := ACls.GetViewId
end;

{ TGridColAttribute }

constructor TGridColAttribute.Create(ACol: Integer; AFormat: string);
begin
  Create(ACol, -1, AFormat);
end;

constructor TGridColAttribute.Create(ACol, AColWidth: Integer; AFormat: string);
begin
  FCol := ACol;
  FColWidth := AColWidth;
  FFormat := AFormat;
end;

{ StrColAttribute }

function StrColAttribute.ValToStr(Value: TValue): string;
begin
  Result := Value.AsString;
end;

{ IntColAttribute }

function IntColAttribute.ValToStr(Value: TValue): string;
begin
  Result := Value.AsInteger.ToString;
end;

{ FloatColAttribute }

function FloatColAttribute.ValToStr(Value: TValue): string;
begin
  if FFormat = '' then
    Result := FloatToStr(Value.AsExtended)
  else
    Result := FormatFloat(FFormat, Value.AsExtended);
end;

{ DatetimeColAttribute }

function DatetimeColAttribute.ValToStr(Value: TValue): string;
begin
  if FFormat = '' then
    Result := DatetimeToStr(Value.AsType<TDatetime>)
  else
    Result := FormatDatetime(FFormat, Value.AsType<TDatetime>);

end;

end.
