unit MenuService;

interface

uses
  Vcl.ComCtrls, Vcl.Menus;

type
  TMenuService = class
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
