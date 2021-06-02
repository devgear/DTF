unit Test1Form;

interface

uses
  DTF.TYpes,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Form.MDIChild, MenuTypes,
  Vcl.StdCtrls, Vcl.ExtCtrls, DTF.Frame.Title, DTF.Frame.Base,
  DTF.Frame.DataSet, DTF.Frame.DBGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.WinXCtrls, Vcl.Mask,
  Vcl.DBCtrls;

type
  [ViewId('TST1010')]
  TfrmTest1 = class(TDTFMDIChildForm)
    DTFDBGridFrame1: TDTFDBGridFrame;
    DTFTitleFrame1: TDTFTitleFrame;
    pnlSearchPanel: TPanel;
    qryMenuItems: TFDQuery;
    qryMenuItemsMENU_CODE: TWideStringField;
    qryMenuItemsMENU_NAME: TWideStringField;
    qryMenuItemsGROUP_CODE: TWideStringField;
    qryMenuItemsSORT_INDEX: TIntegerField;
    edtSchMenuName: TSearchBox;
    Panel7: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtMenuCode: TDBEdit;
    edtMenuName: TDBEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmTest1.FormCreate(Sender: TObject);
begin
  inherited;

  DTFDBGridFrame1.SetSearchPanel(
    pnlSearchPanel,
    procedure
    begin
      qryMenuItems.ParamByName('menu_name').AsString := edtSchMenuName.Text + '%';
    end);
end;

initialization
  TViewFactory.Instance.Regist(TfrmTest1);
finalization

end.
