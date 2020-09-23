unit MenuTypes;

interface
uses
  DTF.Builder.Factory, DTF.Form.MDIChild;

type
  PMenuData = ^TMenuData;
  TMenuData = record
    MenuId: string;
    MenuName: string;
  end;

  TDTFForm = TfrmDTFMDIChild;
  TDTFFormClass = class of TfrmDTFMDIChild;

  TMenuFactory = TAbstractFactory<string, TDTFFormClass>;

implementation

initialization
finalization
  TMenuFactory.Instance.Release;

end.
