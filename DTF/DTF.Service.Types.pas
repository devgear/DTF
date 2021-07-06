unit DTF.Service.Types;

interface

type
  TDTFServiceProvider = class(TInterfacedObject)
  end;
  TDTFServiceProviderClass = class of TDTFServiceProvider;

  IDTFService = interface
    ['{A4CE7D68-245A-43A5-92C9-4A9AF7BBD20D}']
  end;

  IDTFImmediateService = IDTFService;

  IDTFDeferService = interface(IDTFService)
    ['{1C649D62-CDAA-429E-B2C8-DB2BFB4F4E2D}']
  end;

  { Core services }
  IDTFViewService = interface(IDTFImmediateService)
    ['{CBF4176A-A149-4899-827B-38953EE767FC}']
  end;

  IDTFConfigService = interface(IDTFImmediateService)
    ['{12BA2742-734A-45D0-A1AF-537C6AC5E7DB}']
  end;

  IDTFLogService = interface(IDTFDeferService)
    ['{61199B3F-0515-439F-8078-3A13D8EB19E4}']
  end;

implementation

end.
