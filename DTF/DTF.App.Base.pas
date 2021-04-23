// Facade
unit DTF.App.Base;

interface

uses
  DTF.Types,
  DTF.Service.Types,
  DMX.DesignPattern;

type
  TDTFApp<T: class> = class(TSingleton<T>, IDTFServiceLoader)
  protected
    function GetSevice<TS: IDTFService>(const AName: string): TS;
    procedure AddService(const IDTFService);
  public
  end;

implementation

{ TDTFApp }

{ TDTFApp<T> }

procedure TDTFApp<T>.AddService(const IDTFService);
begin

end;

function TDTFApp<T>.GetSevice<TS>(const AName: string): TS;
var
  S: IDTFService;
begin
  Result := S;
end;

end.
