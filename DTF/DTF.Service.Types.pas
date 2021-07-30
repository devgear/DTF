unit DTF.Service.Types;

interface

uses
  DMX.Classes,
  DTF.Types.View,
  System.SysUtils;

type
  TDTFServiceProvider = class(TdxInterfacedObject)
  public
    constructor Create; virtual;
  end;
  TDTFServiceProviderClass = class of TDTFServiceProvider;

  IDTFService = interface
    ['{A4CE7D68-245A-43A5-92C9-4A9AF7BBD20D}']
  end;

  IDTFViewService = interface(IDTFService)
    ['{CBF4176A-A149-4899-827B-38953EE767FC}']
    function Show(AViewId: string; ACreationProc: TProc<TDTFView>): Boolean;
    procedure Regist(ACls: TDTFViewClass);
  end;

  IDTFConfigService = interface(IDTFService)
    ['{12BA2742-734A-45D0-A1AF-537C6AC5E7DB}']
  end;

  IDTFLogService = interface(IDTFService)
    ['{61199B3F-0515-439F-8078-3A13D8EB19E4}']
    procedure Info(const ALog: string);
  end;

implementation

{ TDTFServiceProvider }

constructor TDTFServiceProvider.Create;
begin
end;

end.
