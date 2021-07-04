unit DTF.Service.Types;

interface

type
  IDTFService = interface
//    procedure Loaded;
//    procedure Unload;
//    function ID: TGUID;
//    function GetInstance: IDTFService;
  end;

  IDTFDeferService = interface(IDTFService)
  end;

  IDTFConfigService = interface(IDTFDeferService)
  ['{12BA2742-734A-45D0-A1AF-537C6AC5E7DB}']
  end;

  IDTFLogService = interface(IDTFDeferService)
  ['{61199B3F-0515-439F-8078-3A13D8EB19E4}']
  end;

  IDTFServiceLoader = interface
  ['{104E00BB-59C0-48EC-A70B-A17AC5F949BB}']
  end;

implementation

end.
