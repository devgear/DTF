// Facade
unit DTF.App.Core;

interface

uses
  DTF.Types,
  DTF.Service.Types,
  DTF.Service.Loader,
  System.Generics.Collections,
  DTF.Logger,
  DMX.DesignPattern;

type
  TAppCore<T: class> = class(TSingleton<T>)
  private
    FServices: TDictionary<TGUID, IDTFService>;
    function GetLogService: TLogService;
  protected
    FServiceLoader: TServiceLoader;

    function GetSevice(const AID: TGUID): IDTFService;
    procedure AddService(const AID: TGUID; const AService: IDTFService);
    procedure RegService(const AID: TGUID; const ACls: TClass);

    procedure InitLoader; virtual;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure StartUp;

    // property Auth;
     property Log: TLogService read GetLogService;
  end;

implementation

{ TDTFApp<T> }

procedure TAppCore<T>.AfterConstruction;
begin
  inherited;

  FServices := TDictionary<TGUID, IDTFService>.Create;
  FServiceLoader := TServiceLoader.Create;
end;

procedure TAppCore<T>.BeforeDestruction;
begin
  inherited;

  FServices.Free;
  FServiceLoader.Free;
end;

procedure TAppCore<T>.AddService(const AID: TGUID; const AService: IDTFService);
begin
  FServices.Add(AID, AService);
end;

function TAppCore<T>.GetLogService: TLogService;
begin
  Result := GetSevice(IDTFLogService) as TLogService;
end;

function TAppCore<T>.GetSevice(const AID: TGUID): IDTFService;
//var
//  S: IDTFService;
begin
  Result := nil;
end;

procedure TAppCore<T>.InitLoader;
begin
end;

procedure TAppCore<T>.RegService(const AID: TGUID; const ACls: TClass);
begin

end;

procedure TAppCore<T>.StartUp;
begin

end;

end.
