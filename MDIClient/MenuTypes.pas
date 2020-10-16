unit MenuTypes;

interface
uses
  DTF.Builder.Factory, DTF.Form.MDIChild, Vcl.ComCtrls;

type
  TMenuNode = class(TTreeNode)
  private
    FCode: string;
    FParentCode: string;
  public
    property Code: string read FCode write FCode;
    property ParentCode: string read FParentCode write FParentCode;
  end;

  TDTFForm = TDTFMDIChildForm;
  TDTFFormClass = class of TDTFMDIChildForm;

  TMenuFactory = TAbstractFactory<string, TDTFFormClass>;

implementation

initialization
finalization
  TMenuFactory.Instance.Release;

end.
