// Facade
unit DTF.App.Core;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  DMX.DesignPattern,    // using DevMax frameworks(https://github.com/hjfactory/DevMax)

  DTF.Types,
  DTF.Service.Types;

type
  TAppCore<T: class> = class(TSingleton<T>)
  private
    FBindFuncs: TDictionary<TGUID, TFunc<TDTFServiceProvider>>;
    FInstances: TObjectDictionary<TGUID, TDTFServiceProvider>;
  protected
    procedure Bind(const AID: TGUID; AFunc: TFunc<TDTFServiceProvider>); overload;
    procedure Bind(const AID: TGUID; AClass: TDTFServiceProviderClass); overload;

    procedure RegistCoreServices;
    procedure RegistCustomServices; virtual;

    function GetService(const AID: TGUID): TDTFServiceProvider;

    function GetViewService: IDTFViewService;
    function GetLogService: IDTFLogService;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    // Default core serivce
    property View: IDTFViewService read GetViewService;
    property Log: IDTFLogService read GetLogService;
  end;

implementation

uses
  DTF.Service.View,
  DTF.Logger.ODS;

{ TAppCore<T> }

procedure TAppCore<T>.AfterConstruction;
begin
  inherited;

  FBindFuncs := TDictionary<TGUID, TFunc<TDTFServiceProvider>>.Create;
  FInstances := TObjectDictionary<TGUID, TDTFServiceProvider>.Create([doOwnsValues]);

  RegistCoreServices;
  RegistCustomServices;
end;

procedure TAppCore<T>.BeforeDestruction;
begin
  inherited;

  FBindFuncs.Free;
  FInstances.Free;
end;

procedure TAppCore<T>.Bind(const AID: TGUID; AClass: TDTFServiceProviderClass);
begin
  Bind(AID, function: TDTFServiceProvider
    begin
      Result := AClass.Create;
    end);
end;

procedure TAppCore<T>.Bind(const AID: TGUID; AFunc: TFunc<TDTFServiceProvider>);
begin
  FBindFuncs.Add(AID, AFunc);
end;

procedure TAppCore<T>.RegistCoreServices;
begin
  Bind(IDTFViewService, TViewServiceProvider);
  Bind(IDTFLogService,  TODSLogger);
end;

procedure TAppCore<T>.RegistCustomServices;
begin
end;

function TAppCore<T>.GetService(const AID: TGUID): TDTFServiceProvider;
var
  Func: TFunc<TDTFServiceProvider>;
begin
  if not FInstances.TryGetValue(AID, Result) then
  begin
    if FBindFuncs.TryGetValue(AID, Func) then
    begin
      Result := Func as TDTFServiceProvider;
      FInstances.Add(AID, Result);
    end
    else
      raise Exception.CreateFmt('Service is not registered.(IID: %s)', [AID.ToString]);
  end;
end;

function TAppCore<T>.GetLogService: IDTFLogService;
begin
  Result := GetService(IDTFLogService) as IDTFLogService;
end;

function TAppCore<T>.GetViewService: IDTFViewService;
begin
  Result := GetService(IDTFViewService) as IDTFViewService;
end;

end.
