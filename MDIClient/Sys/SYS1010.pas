unit SYS1010;

interface

uses
  DatabaseModule,
  DTF.Form.Base, DTF.Form.MDIChild,
  DTF.Frame.Base, DTF.Frame.DataSet, DTF.Frame.DBGrid,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Form.DataSet,
  Vcl.BaseImageCollection, Vcl.ImageCollection, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, Vcl.DBActns, System.Actions, Vcl.ActnList, Data.DB,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, DTF.Frame.Title;

type
  TfrmSYS1010 = class(TfrmDTFMDIChild)
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
    qryPrvGroups: TFDQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    WideStringField1: TWideStringField;
    qryPrvItems: TFDQuery;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    dsPrvGroups: TDataSource;
    qryPrvCates: TFDQuery;
    IntegerField5: TIntegerField;
    WideStringField4: TWideStringField;
    WideStringField5: TWideStringField;
    dsPrvCates: TDataSource;
    cbxPrvCates: TDBLookupComboBox;
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
    procedure FormCreate(Sender: TObject);
    procedure btnMenuRefreshClick(Sender: TObject);
    procedure dsPrvCatesDataChange(Sender: TObject; Field: TField);
    procedure qryMenuCatesAfterPost(DataSet: TDataSet);
    procedure qryMenuGroupsAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    procedure DisplayMenus(ACateCode: string; ATreeView: TTreeView);
  public
    { Public declarations }
  end;

var
  frmSYS1010: TfrmSYS1010;

implementation

{$R *.dfm}

uses
  MenuTypes, DTF.Module.Resource;

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

procedure TfrmSYS1010.btnMenuRefreshClick(Sender: TObject);
begin
  qryPrvCates.Refresh;

  DisplayMenus(qryPrvCates.FieldByName('cate_code').AsString, trvMenus);
end;

procedure TfrmSYS1010.DisplayMenus(ACateCode: string; ATreeView: TTreeView);
var
  Group, Item: TTreeNode;
begin
  qryPrvGroups.Refresh;
  qryPrvItems.Refresh;

  ATreeView.Items.Clear;

  qryPrvGroups.First;
  qryPrvItems.First;

  ATreeView.Items.BeginUpdate;
  while not qryPrvGroups.Eof do
  begin
    Group := ATreeView.Items.Add(nil, qryPrvGroups.FieldByName('group_name').AsString);
    Group.ImageIndex := 0;
    Group.SelectedIndex := 0;

    qryPrvItems.First;
    while not qryPrvItems.Eof do
    begin
      Item := ATreeView.Items.AddChild(Group, qryPrvItems.FieldByName('menu_name').AsString);
      Item.Data := nil;
      Item.ImageIndex := 1;
      Item.SelectedIndex := 1;

      qryPrvItems.Next;
    end;

    qryPrvGroups.Next;
  end;

  ATreeView.FullExpand;
  ATreeView.Items.EndUpdate;
end;

procedure TfrmSYS1010.dsPrvCatesDataChange(Sender: TObject; Field: TField);
begin
  DisplayMenus(qryPrvCates.FieldByName('cate_code').AsString, trvMenus);
end;

initialization
  TMenuFactory.Instance.Regist('SYS1010', TfrmSYS1010);
finalization

end.
