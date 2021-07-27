unit DTF.Service.View;

interface

uses
  DMX.DesignPattern,    // using DevMax frameworks(https://github.com/hjfactory/DevMax)
  DTF.Service.Types,
  DTF.Types.View,
  System.SysUtils,
  System.UITypes;

type
  TViewServiceProvider = class(TDTFServiceProvider, IDTFViewService)
  type
    TViewFactory = class(TClassFactory<string, TDTFFormClass>)
    protected
      function CalcKey(ACls: TDTFFormClass): string; override;
    end;
  private
    FFactory: TViewFactory;
  public
    function Show(AViewId: string; ACreationProc: TProc<TDTFForm>): Boolean;
    procedure Regist(ACls: TDTFFormClass);
  end;

implementation

uses
  DTF.App;

{ TViewServiceProvider.TViewFactory }

function TViewServiceProvider.TViewFactory.CalcKey(ACls: TDTFFormClass): string;
begin
  Result := ACls.GetViewId
end;

{ TViewServiceProvider }

procedure TViewServiceProvider.Regist(ACls: TDTFFormClass);
begin
  TViewFactory.Instance.Regist(ACls);
end;

function TViewServiceProvider.Show(AViewId: string; ACreationProc: TProc<TDTFForm>): Boolean;
var
  ViewCls: TDTFFormClass;
begin
  ViewCls := TViewFactory.Instance.GetClass(AViewId);
  if not Assigned(ViewCls) then
    Exit;



end;

initialization
  App.RegistService(IDTFViewService, TViewServiceProvider);

end.
