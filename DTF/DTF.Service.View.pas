unit DTF.Service.View;

interface

uses
  DMX.DesignPattern,    // using DevMax frameworks(https://github.com/hjfactory/DevMax)
  DTF.Service.Types,
  DTF.Types.View,
  System.SysUtils,
  System.Generics.Collections,
  System.UITypes;

type
  TViewServiceProvider = class(TDTFServiceProvider, IDTFViewService)
  type
    TViewFactory = class(TClassFactory<string, TDTFViewClass>)
    protected
      function CalcKey(ACls: TDTFViewClass): string; override;
    end;
  private
    FViewItems: TList<TDTFView>;
  public
    constructor Create; override;
    destructor Destroy; override;

    function Show(AViewId: string; ACreationProc: TProc<TDTFView>): Boolean;
    procedure Regist(ACls: TDTFViewClass);
  end;

implementation

uses
  Vcl.Forms,
  DTF.App;

{ TViewServiceProvider.TViewFactory }

function TViewServiceProvider.TViewFactory.CalcKey(ACls: TDTFViewClass): string;
begin
  Result := ACls.GetViewId
end;

{ TViewServiceProvider }

constructor TViewServiceProvider.Create;
begin
  FViewItems := TList<TDTFView>.Create;
end;

destructor TViewServiceProvider.Destroy;
begin
  FViewItems.Free;

  inherited;
end;

procedure TViewServiceProvider.Regist(ACls: TDTFViewClass);
begin
  TViewFactory.Instance.Regist(ACls);
end;

function TViewServiceProvider.Show(AViewId: string; ACreationProc: TProc<TDTFView>): Boolean;
var
  ViewCls: TDTFViewClass;
  View: TDTFView;
begin
  Result := True;

  ViewCls := TViewFactory.Instance.GetClass(AViewId);
  if not Assigned(ViewCls) then
    Exit(False);

  for View in FViewItems do
  begin
    if View.ClassType = ViewCls then
    begin
      View.Show;
      Exit(True);
    end;
  end;

  View := ViewCls.Create(Application.MainForm);
  FViewItems.Add(View);

  if Assigned(ACreationProc) then
    ACreationProc(View);

  View.Show;
end;

end.
