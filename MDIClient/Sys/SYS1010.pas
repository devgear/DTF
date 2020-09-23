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
  Vcl.Buttons;

type
  TfrmSYS1010 = class(TfrmDTFMDIChild)
    qryMenuCates: TFDQuery;
    qryMenuCatesCATE_SEQ: TIntegerField;
    qryMenuCatesCATE_NAME: TWideStringField;
    pnlClient: TPanel;
    pnlBottom: TPanel;
    pnlCate: TPanel;
    pnlPreview: TPanel;
    pnlGroup: TPanel;
    pnlMenu: TPanel;
    fmeCate: TfmeDTFDBGrid;
    fmeGroup: TfmeDTFDBGrid;
    qryMenuGroups: TFDQuery;
    qryMenuGroupsGROUP_SEQ: TIntegerField;
    qryMenuGroupsGROUP_NAME: TWideStringField;
    Panel1: TPanel;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Panel2: TPanel;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    qryMenuGroupsCATE_SEQ: TIntegerField;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    fmeMenu: TfmeDTFDBGrid;
    Panel3: TPanel;
    qryMenuItems: TFDQuery;
    qryMenuItemsMENU_SEQ: TIntegerField;
    qryMenuItemsGROUP_SEQ: TIntegerField;
    qryMenuItemsMENU_ID: TWideStringField;
    qryMenuItemsMENU_NAME: TWideStringField;
    Panel7: TPanel;
    Label1: TLabel;
    DBEdit3: TDBEdit;
    Label2: TLabel;
    DBEdit4: TDBEdit;
    trvMenus: TTreeView;
    btnMenuRefresh: TSpeedButton;
    qryMenuCatesCATE_CODE: TWideStringField;
    Label5: TLabel;
    DBEdit5: TDBEdit;
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
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMenuRefreshClick(Sender: TObject);
    procedure dsPrvCatesDataChange(Sender: TObject; Field: TField);
    procedure qryMenuCatesAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    procedure PanelResize;
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

{$REGION 'Applied at design time' }
  qryMenuCates.FieldByName('cate_seq').DisplayLabel := '일련번호';
  qryMenuCates.FieldByName('cate_name').DisplayLabel := '카테고리 명';
  qryMenuCates.FieldByName('cate_name').DisplayWidth := 40;
  qryMenuCates.UpdateOptions.GeneratorName := 'CATE_SEQ_GEN';

  qryMenuGroups.FieldByName('group_seq').DisplayLabel := '일련번호';
  qryMenuGroups.FieldByName('group_name').DisplayLabel := '그룹 명';
  qryMenuGroups.FieldByName('group_name').DisplayWidth := 40;
  qryMenuGroups.MasterSource := fmeCate.dsDataSet;
  qryMenuGroups.MasterFields := 'cate_seq';
  qryMenuGroups.IndexFieldNames := 'cate_seq';
//  qryMenuGroups.DetailFields := 'cate_seq';
  qryMenuGroups.UpdateOptions.GeneratorName := 'GROUP_SEQ_GEN';

  qryMenuItems.FieldByName('menu_seq').DisplayLabel := '일련번호';
  qryMenuItems.FieldByName('menu_id').DisplayLabel := '메뉴 ID';
  qryMenuItems.FieldByName('menu_name').DisplayLabel := '메뉴 명';
  qryMenuItems.FieldByName('menu_id').DisplayWidth := 12;
  qryMenuItems.FieldByName('menu_name').DisplayWidth := 40;
  qryMenuItems.MasterSource := fmeGroup.dsDataSet;
  qryMenuItems.MasterFields := 'group_seq';
  qryMenuItems.IndexFieldNames := 'group_seq';
//  qryMenuItems.DetailFields := 'group_seq';
  qryMenuItems.UpdateOptions.GeneratorName := 'MENU_SEQ_GEN';
{$ENDREGION}

  qryMenuCates.Open;
  qryMenuGroups.Open;
  qryMenuItems.Open;

  cbxPrvCates.KeyValue := qryPrvCates.FieldByName('CATE_SEQ').Value;
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

procedure TfrmSYS1010.FormResize(Sender: TObject);
begin
  PanelResize;
end;

procedure TfrmSYS1010.PanelResize;
begin
  pnlBottom.Height := Height div 2;

  pnlCate.Width := Width div 2;
  pnlGroup.Width := Width div 2;
end;

procedure TfrmSYS1010.qryMenuCatesAfterPost(DataSet: TDataSet);
begin
  inherited;

  qryPrvCates.Refresh;
end;

initialization
  TMenuFactory.Instance.Regist('SYS1010', TfrmSYS1010);
finalization

end.
