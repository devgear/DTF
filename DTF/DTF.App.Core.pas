// Facade
unit DTF.App.Core;

interface

uses
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
  protected
    FServiceLoader: TServiceLoader;

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

uses
  System.SysUtils;

{ TDTFApp<T> }

procedure TAppCore<T>.AfterConstruction;
begin
  inherited;

  FServiceLoader := TServiceLoader.Create;
end;

procedure TAppCore<T>.BeforeDestruction;
begin
  inherited;

  FServiceLoader.Free;
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
