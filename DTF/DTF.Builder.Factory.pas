unit DTF.Builder.Factory;

interface

uses
  System.Generics.Collections, Vcl.Forms;

type
  TAbstractFactory<TKey, TValue> = class
  private
    class var
      FInstance: TAbstractFactory<TKey, TValue>;
  private
    FList: TDictionary<TKey, TValue>;
  public
    constructor Create;
    destructor Destroy; override;

    class function Instance: TAbstractFactory<TKey, TValue>;
    class procedure Release;

    procedure Regist(AKey: TKey; AValue: TValue);
    function Get(AKey: TKey): TValue;
  end;

implementation

uses
  System.SysUtils;

{ TMenuBilder }

class function TAbstractFactory<TKey, TValue>.Instance: TAbstractFactory<TKey, TValue>;
begin
  if not Assigned(FInstance) then
    FInstance := TAbstractFactory<TKey, TValue>.Create;
  Result := FInstance;
end;

class procedure TAbstractFactory<TKey, TValue>.Release;
begin
  if Assigned(FInstance) then
    FInstance.Free;
  FInstance := nil;
end;

constructor TAbstractFactory<TKey, TValue>.Create;
begin
  FList := TDictionary<TKey, TValue>.Create;
end;

destructor TAbstractFactory<TKey, TValue>.Destroy;
begin
  FList.Free;

  inherited;
end;

procedure TAbstractFactory<TKey, TValue>.Regist(AKey: TKey; AValue: TValue);
begin
  if FList.ContainsKey(AKey) then
    raise Exception.Create('Duplicate item.');

  FList.Add(AKey, AValue);
end;

function TAbstractFactory<TKey, TValue>.Get(AKey: TKey): TValue;
begin
  FList.TryGetValue(AKey, Result);
end;


end.
