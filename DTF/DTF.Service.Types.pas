unit DTF.Service.Types;

interface

type
  IDTFService = interface
//    procedure Loaded;
//    procedure Unload;
  end;

  IDTFLazyLoadService = interface(IDTFService)
  end;

  IDTFConfigService<T> = interface(IDTFService)
  ['{12BA2742-734A-45D0-A1AF-537C6AC5E7DB}']
    function GetConfig: T;
    property Config: T read GetConfig;
  end;

  IDTFServiceLoader = interface
  ['{104E00BB-59C0-48EC-A70B-A17AC5F949BB}']
  end;

implementation

end.
