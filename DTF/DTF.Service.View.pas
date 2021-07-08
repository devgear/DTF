unit DTF.Service.View;

interface

uses
  DTF.Service.Types,
  System.UITypes;

type
  TViewServiceProvider = class(TDTFServiceProvider, IDTFViewService)
  public
    procedure ShowView(AViewId: string);
    function ShowModal(AViewId: string): TModalResult;
  end;

implementation

uses
  DTF.App;

{ TViewServiceProvider }

function TViewServiceProvider.ShowModal(AViewId: string): TModalResult;
begin

end;

procedure TViewServiceProvider.ShowView(AViewId: string);
begin

end;

initialization
  App.RegistService(IDTFViewService, TViewServiceProvider);

end.
