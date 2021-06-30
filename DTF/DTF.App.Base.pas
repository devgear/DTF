// Facade
unit DTF.App.Base;

interface

uses
  DTF.Types,
  DTF.Service.Types,
  System.Generics.Collections,
  DMX.DesignPattern;

type
  TDTFApp<T: class> = class(TSingleton<T>, IDTFServiceLoader)
  private
    FServices: TList<IDTFService>;
  protected
    function GetSevice<TS: class>(const IID: TGUID): TS;
    procedure AddService(const AService: IDTFService);
    procedure RegService(const ACls: TClass);
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

{ TDTFApp }

{ TDTFApp<T> }

procedure TDTFApp<T>.AfterConstruction;
begin
  inherited;

  FServices := TList<IDTFService>.Create;
end;

procedure TDTFApp<T>.BeforeDestruction;
begin
  inherited;

  FServices.Free;
end;

procedure TDTFApp<T>.AddService(const AService: IDTFService);
begin
  FServices.Add(AService);
end;

function TDTFApp<T>.GetSevice<TS>(const IID: TGUID): TS;
//var
//  S: IDTFService;
begin
  Result := nil;
end;

procedure TDTFApp<T>.RegService(const ACls: TClass);
begin

end;

end.
