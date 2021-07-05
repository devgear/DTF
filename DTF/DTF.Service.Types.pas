unit DTF.Service.Types;

interface

type
  TDTFServiceProvider = class(TInterfacedObject)
  end;
  TDTFServiceProviderClass = class of TDTFServiceProvider;

  IDTFService = interface
  end;

  IDTFImmediateService = IDTFService;

  IDTFDeferService = interface(IDTFService)
  end;

  IDTFConfigService = interface(IDTFImmediateService)
  ['{12BA2742-734A-45D0-A1AF-537C6AC5E7DB}']
  end;

  IDTFLogService = interface(IDTFDeferService)
  ['{61199B3F-0515-439F-8078-3A13D8EB19E4}']
  end;

implementation

end.
