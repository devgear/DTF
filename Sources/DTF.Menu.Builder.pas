unit DTF.Menu.Builder;

interface

type
  TMenuBuilder = class
  private
    class var
      FInstance: TMenuBuilder;
  public
    class function Instance: TMenuBuilder;
  end;

implementation

{ TMenuBilder }

class function TMenuBuilder.Instance: TMenuBuilder;
begin
  if not Assigned(FInstance) then
    FInstance := TMenuBuilder.Create;
  Result := FInstance;
end;

end.
