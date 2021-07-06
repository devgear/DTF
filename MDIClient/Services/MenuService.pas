unit MenuService;

interface

uses
  DTF.Service.Types,
  Vcl.ComCtrls, Vcl.Menus;

type
  IDTFMenuService = interface(IDTFDeferService)
    ['{675A0743-9D5C-443B-9ADF-487E5CAA1998}']
  end;

  TMenuService = class(TDTFServiceProvider, IDTFMenuService)
  public
    procedure LoadMenu(ACategory: string; ATreeView: TTreeView); overload;
    procedure LoadMenu(AMainMenu: TMainMenu); overload;
  end;

implementation

{ TMenuService }

procedure TMenuService.LoadMenu(AMainMenu: TMainMenu);
begin

end;

procedure TMenuService.LoadMenu(ACategory: string; ATreeView: TTreeView);
begin

end;

end.
