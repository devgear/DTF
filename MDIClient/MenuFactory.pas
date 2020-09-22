unit MenuFactory;

interface
uses
  DTF.Builder.Factory, DTF.Form.MDIChild;

type
  TDTFForm = TfrmDTFMDIChild;
  TDTFFormClass = class of TfrmDTFMDIChild;

  TMenuFactory = TAbstractFactory<string, TDTFFormClass>;

implementation

initialization
finalization
  TMenuFactory.Instance.Release;

end.
