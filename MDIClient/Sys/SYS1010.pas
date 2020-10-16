unit SYS1010;

interface

uses
  DatabaseModule,
  DTF.Form.Base, DTF.Form.MDIChild,
  DTF.Frame.Base, DTF.Frame.DataSet, DTF.Frame.DBGrid,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.BaseImageCollection, Vcl.ImageCollection, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, Vcl.DBActns, System.Actions, Vcl.ActnList, Data.DB,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, DTF.Frame.Title;

type
  TfrmSYS1010 = class(TDTFMDIChildForm)
    qryMenuCates: TFDQuery;
    qryMenuCatesCATE_NAME: TWideStringField;
    pnlCate: TPanel;
    pnlPreview: TPanel;
    pnlGroup: TPanel;
    pnlMenu: TPanel;
    fmeCate: TDTFDBGridFrame;
    fmeGroup: TDTFDBGridFrame;
    qryMenuGroups: TFDQuery;
    qryMenuGroupsGROUP_NAME: TWideStringField;
    Panel1: TPanel;
    Label3: TLabel;
    edtCateName: TDBEdit;
    Panel2: TPanel;
    Label4: TLabel;
    edtGroupName: TDBEdit;
    fmeMenu: TDTFDBGridFrame;
    qryMenuItems: TFDQuery;
    qryMenuItemsMENU_NAME: TWideStringField;
    Panel7: TPanel;
    Label1: TLabel;
    edtMenuCode: TDBEdit;
    Label2: TLabel;
    edtMenuName: TDBEdit;
    trvMenus: TTreeView;
    btnMenuRefresh: TSpeedButton;
    Label5: TLabel;
    edtCateCode: TDBEdit;
    DTFTitleFrame1: TDTFTitleFrame;
    DTFTitleFrame2: TDTFTitleFrame;
    DTFTitleFrame3: TDTFTitleFrame;
    DTFTitleFrame4: TDTFTitleFrame;
    qryMenuCatesCATE_CODE: TWideStringField;
    qryMenuGroupsGROUP_CODE: TWideStringField;
    qryMenuGroupsCATE_CODE: TWideStringField;
    qryMenuGroupsSORT_INDEX: TIntegerField;
    qryCateLookup: TFDQuery;
    qryMenuGroupsCATE_NAME: TStringField;
    GridPanel1: TGridPanel;
    Label6: TLabel;
    edtGroupCode: TDBEdit;
    qryMenuItemsMENU_CODE: TWideStringField;
    qryMenuItemsGROUP_CODE: TWideStringField;
    qryMenuItemsSORT_INDEX: TIntegerField;
    qryGroupLookup: TFDQuery;
    qryMenuItemsGROUP_NAME: TStringField;
    qryMenuTree: TFDQuery;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnMenuRefreshClick(Sender: TObject);
    procedure qryMenuCatesAfterPost(DataSet: TDataSet);
    procedure qryMenuGroupsAfterPost(DataSet: TDataSet);
    procedure fmeCateDataSourceDataChange(Sender: TObject; Field: TField);
    procedure trvMenusCreateNodeClass(Sender: TCustomTreeView;
      var NodeClass: TTreeNodeClass);
  private
    { Private declarations }
    procedure LoadMenus(ACateCode: string);
  public
    { Public declarations }
  end;

var
  frmSYS1010: TfrmSYS1010;

implementation

{$R *.dfm}

uses
  MenuTypes, DTF.Module.Resource;

procedure TfrmSYS1010.fmeCateDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  LoadMenus(qryMenuCates.FieldByName('cate_code').AsString);
end;

procedure TfrmSYS1010.FormCreate(Sender: TObject);
begin
  inherited;

  qryMenuCates.Open;
  qryMenuGroups.Open;
  qryMenuItems.Open;

  qryCateLookup.Open;
  qryGroupLookup.Open;

  fmeCate.FocusControl := edtCateCode;
  fmeGroup.FocusControl := edtGroupCode;
  fmeMenu.FocusControl := edtMenuCode;
end;

procedure TfrmSYS1010.qryMenuCatesAfterPost(DataSet: TDataSet);
begin
  qryCateLookup.Refresh;
end;

procedure TfrmSYS1010.qryMenuGroupsAfterPost(DataSet: TDataSet);
begin
  qryGroupLookup.Refresh;
end;

procedure TfrmSYS1010.trvMenusCreateNodeClass(Sender: TCustomTreeView;
  var NodeClass: TTreeNodeClass);
begin
  NodeClass := TMenuNode;
end;

procedure TfrmSYS1010.btnMenuRefreshClick(Sender: TObject);
begin
//  qryPrvCates.Refresh;
//
//  DisplayMenus(qryPrvCates.FieldByName('cate_code').AsString, trvMenus);
end;

procedure TfrmSYS1010.LoadMenus(ACateCode: string);
var
  GroupName: string;
  Group, Item: TMenuNode;
begin
  trvMenus.Items.Clear;

  qryMenuTree.Close;
  qryMenuTree.ParamByName('cate_code').AsString := ACateCode;
  qryMenuTree.Open;

  trvMenus.Items.Clear;
  Group := nil;
  GroupName := '';
  while not qryMenuTree.Eof do
  begin
    GroupName := qryMenuTree.FieldByName('group_name').AsString;
    if not Assigned(Group) or (GroupName <> Group.Text) then
    begin
      Group := trvMenus.Items.Add(nil, GroupName) as TMenuNode;
      Group.Code := qryMenuTree.FieldByName('menu_code').AsString;
      Group.ImageIndex := 0;
      Group.SelectedIndex := 0;
    end;

    Item := trvMenus.Items.AddChild(Group, qryMenuTree.FieldByName('menu_name').AsString) as TMenuNode;
    Item.Code := qryMenuTree.FieldByName('menu_code').AsString;
    Item.ParentCode := qryMenuTree.FieldByName('group_code').AsString;
    Item.ImageIndex := 1;
    Item.SelectedIndex := 1;

    qryMenuTree.Next;
  end;

  trvMenus.FullExpand;
  trvMenus.Items.EndUpdate;
end;

initialization
  TMenuFactory.Instance.Regist('SYS1010', TfrmSYS1010);
finalization

end.
