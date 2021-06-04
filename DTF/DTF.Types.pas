unit DTF.Types;

interface

uses
  System.Types, System.SysUtils,
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

end.
