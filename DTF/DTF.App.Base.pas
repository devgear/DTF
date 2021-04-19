// Facade
unit DTF.App.Base;

interface

uses
  DTF.Types,
  DTF.Service.Types,
  DMX.DesignPattern;

type
  TDTFApp<T: class> = class(TSingleton<T>, IDTFServiceLoader)
  private
    function GetSevice<TS: IDTFService>(const AName: string): TS;
  public
  end;

implementation

{ TDTFApp }

{ TDTFApp<T> }

function TDTFApp<T>.GetSevice<TS>(const AName: string): TS;
var
  S: IDTFService;
begin
  Result := S;
end;

end.
