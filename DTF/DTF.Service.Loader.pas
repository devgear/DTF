unit DTF.Service.Loader;

interface

uses
  System.SysUtils, System.Generics.Collections,
  DTF.Service.Types;

type
  TServiceLoader = class
    type
      TProviderData = record
        Cls: TDTFServiceProviderClass;
        Instance: TDTFServiceProvider;
        LoaderPro: TFunc<TDTFServiceProvider>;
      end;
  private
    FDict: TDictionary<TGUID, TProviderData>;

    procedure DoRegistServiceProvider(const AID: TGUID; AClass: TDTFServiceProviderClass;
      AInstance: TDTFServiceProvider; ALoaderProc: TFunc<TDTFServiceProvider>);
    function GetServiceProvider(AID: TGUID): TDTFServiceProvider;
    procedure SetServiceProvider(AID: TGUID; const Value: TDTFServiceProvider);
  public
    constructor Create;
    destructor Destroy; override;

    procedure RegistServiceProvider(const AID: TGUID;
      AClass: TDTFServiceProviderClass); overload;
    procedure RegistServiceProvider(const AID: TGUID;
      AClass: TDTFServiceProviderClass; ALoaderProc: TFunc<TDTFServiceProvider>); overload;
    procedure RegistServiceProvider(const AID: TGUID;
      AInstance: TDTFServiceProvider); overload;

    property ServiceProvider[AID: TGUID]: TDTFServiceProvider read GetServiceProvider write SetServiceProvider;

  end;

implementation

{ TServiceLoader }

constructor TServiceLoader.Create;
begin
  FDict := TDictionary<TGUID, TProviderData>.Create;
end;

destructor TServiceLoader.Destroy;
begin
  FDict.Free;

  inherited;
end;

procedure TServiceLoader.DoRegistServiceProvider(const AID: TGUID;
  AClass: TDTFServiceProviderClass; AInstance: TDTFServiceProvider;
  ALoaderProc: TFunc<TDTFServiceProvider>);
begin

end;

function TServiceLoader.GetServiceProvider(AID: TGUID): TDTFServiceProvider;
begin

end;

procedure TServiceLoader.SetServiceProvider(AID: TGUID;
  const Value: TDTFServiceProvider);
var
  Data: TProviderData;
begin
  if FDict.TryGetValue(AID, Data) then
  begin
    Data.Instance := Value;
    FDict.Items[AID] := Data;
  end
  else
    RegistServiceProvider(AID, Value);
end;

procedure TServiceLoader.RegistServiceProvider(const AID: TGUID;
  AInstance: TDTFServiceProvider);
begin
  DoRegistServiceProvider(AID, nil, AInstance, nil);
end;

procedure TServiceLoader.RegistServiceProvider(const AID: TGUID;
  AClass: TDTFServiceProviderClass; ALoaderProc: TFunc<TDTFServiceProvider>);
begin
  DoRegistServiceProvider(AID, AClass, nil, ALoaderProc);
end;

procedure TServiceLoader.RegistServiceProvider(const AID: TGUID;
      AClass: TDTFServiceProviderClass);
var
  Data: TProviderData;
begin
  DoRegistServiceProvider(AID, AClass, nil, nil);
end;

end.
