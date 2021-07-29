unit DTF.Types.View;

interface

uses
  DMX.DesignPattern,    // using DevMax frameworks(https://github.com/hjfactory/DevMax)
  DTF.Form.MDIChild,
  DTF.Form.Base;

type
  ///////////////////////////////////////////////
  ///  View
  TDTFView = TDTFBaseForm;
  TDTFVIewClass = class of TDTFView;

  TDTFMDIForm = TDTFMDIChildForm;

  ViewIdAttribute = class(TCustomAttribute)
  private
    FViewId: string;
  public
    constructor Create(AViewId: string);
    property ViewId: string read FViewId;
  end;

  TViewFactory = class(TClassFactory<string, TDTFVIewClass>)
  protected
    function CalcKey(ACls: TDTFVIewClass): string; override;
  end;

implementation

{ ViewIdAttribute }

constructor ViewIdAttribute.Create(AViewId: string);
begin
  FViewId := AViewId;
end;

{ TViewFactory }

function TViewFactory.CalcKey(ACls: TDTFVIewClass): string;
begin
  Result := ACls.GetViewId
end;

end.
