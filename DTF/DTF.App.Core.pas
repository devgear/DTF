// Facade
unit DTF.App.Core;

interface

uses
  DTF.Types,
  DTF.Service.Types,
  System.Generics.Collections,
  DTF.Log.Service,
  DMX.DesignPattern;

type
  TAppCore<T: class> = class(TSingleton<T>, IDTFServiceLoader)
  private
    FServices: TDictionary<TGUID, IDTFService>;
    function GetLogService: TLogService;
  protected
    function GetSevice(const AID: TGUID): IDTFService;
    procedure AddService(const AID: TGUID; const AService: IDTFService);
    procedure RegService(const AID: TGUID; const ACls: TClass);
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    // property Auth;
     property Log: TLogService read GetLogService;
  end;

implementation

{ TDTFApp }

{ TDTFApp<T> }

procedure TAppCore<T>.AfterConstruction;
begin
  inherited;

  FServices := TDictionary<TGUID, IDTFService>.Create;
end;

procedure TAppCore<T>.BeforeDestruction;
begin
  inherited;

  FServices.Free;
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

procedure TAppCore<T>.RegService(const AID: TGUID; const ACls: TClass);
begin

end;

end.
