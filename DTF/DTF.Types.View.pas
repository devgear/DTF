unit DTF.Types.View;

interface

uses
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
