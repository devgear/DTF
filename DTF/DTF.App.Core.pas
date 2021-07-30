// Facade
unit DTF.App.Core;

interface

uses
  System.SysUtils,
  System.Generics.Collections,

  DTF.Types,
  DTF.Service.Types,
  DTF.Service.Loader,
  DTF.Service.View,
  DTF.Logger,
  DMX.DesignPattern;

type
  TAppCore<T: class> = class(TSingleton<T>)
  private
    FBindFuncs: TDictionary<TGUID, TFunc<IDTFService>>;
    FInstances: TDictionary<TGUID, IDTFService>;
  protected
    FServiceLoader: TServiceLoader;

    procedure Bind(const AID: TGUID; AFunc: TFunc<IDTFService>); overload;
    procedure Bind(const AID: TGUID; AClass: TClass); overload;

    function GetService(const AID: TGUID): TDTFServiceProvider;
    procedure AddService(const AID: TGUID; const AService: IDTFService);

    function GetViewService: IDTFViewService;
    function GetLogService: IDTFLogService;

    procedure InitLoader; virtual;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure StartUp;

    procedure RegistService(const AID: TGUID; const ACls: TDTFServiceProviderClass);

    // property Auth;
     property View: IDTFViewService read GetViewService;
     property Log: IDTFLogService read GetLogService;
  end;

implementation

{ TAppCore<T> }

procedure TAppCore<T>.AfterConstruction;
begin
  inherited;

  FBindFuncs := TDictionary<TGUID, TFunc<IDTFService>>.Create;
  FInstances := TDictionary<TGUID, IDTFService>.Create;

//  RegistCoreServices;
//  RegistCustomServices;
end;

procedure TAppCore<T>.BeforeDestruction;
begin
  inherited;

  FBindFuncs.Free;
  FInstances.Free;
end;

procedure TAppCore<T>.Bind(const AID: TGUID; AClass: TClass);
begin
  Bind(AID, function: IDTFService
    var
      Intf: IDTFService;
    begin
      Supports(AClass.Create, IDTFService, Result);
    end);
end;

procedure TAppCore<T>.Bind(const AID: TGUID; AFunc: TFunc<IDTFService>);
begin
  FBindFuncs.Add(AID, AFunc);
end;

procedure TAppCore<T>.AddService(const AID: TGUID; const AService: IDTFService);
begin
end;

function TAppCore<T>.GetLogService: IDTFLogService;
begin
  Result := GetService(IDTFLogService) as IDTFLogService;
end;

function TAppCore<T>.GetService(const AID: TGUID): TDTFServiceProvider;
begin
  Result := FServiceLoader.ServiceProvider[AId];
end;

function TAppCore<T>.GetViewService: IDTFViewService;
begin
  Result := GetService(IDTFViewService) as IDTFViewService;
end;

procedure TAppCore<T>.InitLoader;
begin
end;

procedure TAppCore<T>.RegistService(const AID: TGUID; const ACls: TDTFServiceProviderClass);
begin
  FServiceLoader.RegistServiceProvider(AID, ACls);
end;

procedure TAppCore<T>.StartUp;
begin
//  FServiceLoader.RegistServiceProvider(IDTFViewService, TViewServiceProvider.Create);

  InitLoader;
end;

end.
