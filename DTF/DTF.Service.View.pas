unit DTF.Service.View;

interface

uses
  DTF.Service.Types;

type
  TViewServiceProvider = class(TDTFServiceProvider, IDTFViewService)
  public
    procedure ShowView(AViewId: string);
  end;

implementation

{ TViewServiceProvider }

procedure TViewServiceProvider.ShowView(AViewId: string);
begin

end;

end.
