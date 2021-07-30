unit DTF.Types.View;

interface

uses
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

implementation

{ ViewIdAttribute }

constructor ViewIdAttribute.Create(AViewId: string);
begin
  FViewId := AViewId;
end;

end.
