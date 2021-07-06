unit DTF.Service.Loader;

interface

uses
  System.SysUtils, System.Generics.Collections,
  DTF.Service.Types;

type
  TServiceLoader = class
    type
      TProviderData = class
        Cls: TDTFServiceProviderClass;
        Instance: TDTFServiceProvider;
        LoaderProc: TFunc<TDTFServiceProvider>;
      public
        destructor Destroy; override;
      end;
  private
    FDict: TObjectDictionary<TGUID, TProviderData>;

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
  FDict := TObjectDictionary<TGUID, TProviderData>.Create([doOwnsValues]);
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
  if not FDict.ContainsKey(AId) then
    FDict.Add(AId, TProviderData.Create);

  FDict.Items[AId].Cls := AClass;
  if Assigned(FDict.Items[AId].Instance) then
    FDict.Items[AId].Instance.Free;
  FDict.Items[AId].Instance := AInstance;
  FDict.Items[AId].LoaderProc := ALoaderProc;
end;

function TServiceLoader.GetServiceProvider(AID: TGUID): TDTFServiceProvider;
var
  Data: TProviderData;
begin
  if not FDict.TryGetValue(AId, Data) then
    raise Exception.Create('Not registration service. ' + AID.ToString);

  if Assigned(Data.Instance) then
    Exit(Data.Instance);
end;

procedure TServiceLoader.SetServiceProvider(AID: TGUID;
  const Value: TDTFServiceProvider);
begin
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

{ TServiceLoader.TProviderData }

destructor TServiceLoader.TProviderData.Destroy;
begin
  if Assigned(Instance) then
    Instance.Free;

  inherited;
end;

end.
