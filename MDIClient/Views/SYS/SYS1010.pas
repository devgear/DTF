unit SYS1010;

interface

uses
  DatabaseModule,
  MenuTypes,
  DTF.Types,
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
  [ViewId('SYS1010')]
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
    actMenuTree: TActionList;
    actMenuTreeRefresh: TAction;
    actMenuTreeSave: TAction;
    actMenuTreeUp: TAction;
    actMenuTreeDown: TAction;
    qryMenuUpdate: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure qryMenuCatesAfterPost(DataSet: TDataSet);
    procedure qryMenuGroupsAfterPost(DataSet: TDataSet);
    procedure trvMenusCreateNodeClass(Sender: TCustomTreeView;
      var NodeClass: TTreeNodeClass);
    procedure actMenuTreeRefreshExecute(Sender: TObject);
    procedure actMenuTreeUpExecute(Sender: TObject);
    procedure actMenuTreeDownExecute(Sender: TObject);
    procedure actMenuTreeUpUpdate(Sender: TObject);
    procedure actMenuTreeDownUpdate(Sender: TObject);
    procedure trvMenusDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure trvMenusDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure actMenuTreeSaveExecute(Sender: TObject);
    procedure actMenuTreeSaveUpdate(Sender: TObject);
    procedure fmeCateDataSourceDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    FIsChagnedMenuTree: Boolean;
    procedure LoadMenus(ACateCode: string = '');
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  DTF.Module.Resource;

procedure TfrmSYS1010.actMenuTreeDownExecute(Sender: TObject);
var
  Src, Dst: TTreeNode;
begin
  Src := trvMenus.Selected;
  Dst := Src.getNextSibling;
  if not Assigned(Dst) then
    Exit;

  Dst.MoveTo(Src, naInsert);
  trvMenus.FullExpand;

  FIsChagnedMenuTree := True;
end;

procedure TfrmSYS1010.actMenuTreeDownUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(trvMenus.Selected) and (trvMenus.Selected.getNextSibling <> nil);
end;

procedure TfrmSYS1010.actMenuTreeRefreshExecute(Sender: TObject);
begin
//  LoadMenus;
  LoadMenus(qryMenuCates.FieldByName('cate_code').AsString);
end;

procedure TfrmSYS1010.actMenuTreeSaveExecute(Sender: TObject);
var
  I: Integer;
  Node: TMenuNode;
begin
  trvMenus.Items.BeginUpdate;
  for I := 0 to trvMenus.Items.Count - 1 do
  begin
    Node := TMenuNode(trvMenus.Items[I]);

    OutputDebugString(PChar(Format('%d %s, %s %d', [I, Node.Text, Node.Code, Node.SortIndex])));

    if (Node.Index <> Node.SortIndex) or (Assigned(Node.Parent) and (Node.ParentCode <> TMenuNode(Node.Parent).Code)) then
    begin
      // Group
      if Node.Level = 0 then
      begin
        qryMenuUpdate.SQL.Text := 'UPDATE menu_groups SET sort_index = :SORT_INDEX WHERE group_code = :GROUP_CODE';
        qryMenuUpdate.ParamByName('SORT_INDEX').AsInteger := Node.Index;
        qryMenuUpdate.ParamByName('GROUP_CODE').AsString := Node.Code;
        qryMenuUpdate.ExecSQL;
      end
      // Menu
      else
      begin
        qryMenuUpdate.SQL.Text := 'UPDATE menu_items SET sort_index = :SORT_INDEX, group_code = :GROUP_CODE WHERE menu_code = :MENU_CODE';
        qryMenuUpdate.ParamByName('SORT_INDEX').AsInteger := Node.Index;
        qryMenuUpdate.ParamByName('GROUP_CODE').AsString := TMenuNode(Node.Parent).Code;
        qryMenuUpdate.ParamByName('MENU_CODE').AsString := Node.Code;
        qryMenuUpdate.ExecSQL;
      end;
    end;
  end;
  trvMenus.Items.EndUpdate;

  LoadMenus;
end;

procedure TfrmSYS1010.actMenuTreeSaveUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := FIsChagnedMenuTree;
end;

procedure TfrmSYS1010.actMenuTreeUpExecute(Sender: TObject);
var
  Src, Dst: TTreeNode;
begin
  Src := trvMenus.Selected;
  Dst := Src.getPrevSibling;
  if not Assigned(Dst) then
    Exit;

  Src.MoveTo(Dst, naInsert);
  trvMenus.FullExpand;

  FIsChagnedMenuTree := True;
end;

procedure TfrmSYS1010.actMenuTreeUpUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(trvMenus.Selected) and (trvMenus.Selected.getPrevSibling <> nil);
end;

procedure TfrmSYS1010.fmeCateDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
// 10.4에서는 1회만 호출 됨
// 10.1에서는 여러회 호출 됨(마지막은 fsCreating 제외하고 호출됨)
//  if fsCreating in FormState then
//    Exit;
//
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

procedure TfrmSYS1010.trvMenusDragDrop(Sender, Source: TObject; X, Y: Integer);
  function Sort(AList: TArray<TTreeNode>): TArray<TTreeNode>;
  var
    I, J, Idx: Integer;
    Item: TTreeNode;
    Temps: TArray<TTreeNode>;
  begin
    SetLength(Temps, Length(AList));

    for I := 0 to Length(AList) - 1 do
    begin
      Idx := I;
      Item := AList[I];

      // Temps에는 I-1개가 담겨 있음
      for J := 0 to I-1 do
      begin
        // 이번에 담을 것이 기존에 담긴 것보다 작으면
        if Item.Index < Temps[J].Index then
        begin
          Idx := J;
          Break;
        end;
      end;
      if Idx <> I then
      begin
        for J := I-1 downto Idx do
          Temps[J+1] := Temps[J];
      end;

      Temps[Idx] := AList[I];
    end;

    Result := Temps;
  end;
var
  I: Integer;
  Src, Dst: TTreeNode;
  Selections: TArray<TTreeNode>;
begin
  if trvMenus.SelectionCount = 1 then
  begin
    Src := trvMenus.Selected;
    Dst := trvMenus.GetNodeAt(X, Y);

    if Dst.Level = 0 then
      Src.MoveTo(Dst, naAddChild)
    else
      Src.MoveTo(Dst, naInsert);
  end
  else
  // Multi select
  begin
    Dst := trvMenus.GetNodeAt(X, Y);
    SetLength(Selections, trvMenus.SelectionCount);

    // 정렬
    for I := 0 to trvMenus.SelectionCount - 1 do
      Selections[I] := trvMenus.Selections[I];
    Selections := Sort(Selections);

    for I := 0 to Length(Selections) - 1 do
    begin
      Src := Selections[I];
      if Dst.Level = 0 then
        Src.MoveTo(Dst, naAddChild)
      else
        Src.MoveTo(Dst, naInsert);

      OutputDebugString(PChar(Format('%d / %d(%s)', [Dst.Index, Src.Index, Src.Text])));
    end;
  end;
  FIsChagnedMenuTree := True;
end;

procedure TfrmSYS1010.trvMenusDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  Src, Dst: TTreeNode;
begin
  Src := trvMenus.Selected;
  Dst := trvMenus.GetNodeAt(X, Y);

  Accept := Assigned(Dst) and (Src <> Dst) and (Src.Level > 0);
end;

procedure TfrmSYS1010.LoadMenus(ACateCode: string);
var
  GroupName, MenuName: string;
  Group, Item: TMenuNode;
begin
  FIsChagnedMenuTree := False;

  if ACateCode = '' then
    qryMenuTree.Refresh
  else
  begin
    qryMenuTree.Close;
    qryMenuTree.ParamByName('cate_code').AsString := ACateCode;
    qryMenuTree.Open;
  end;

  trvMenus.Items.Clear;
  Group := nil;
  GroupName := '';
  qryMenuTree.First;
  while not qryMenuTree.Eof do
  begin
    GroupName := qryMenuTree.FieldByName('group_name').AsString;
    if not Assigned(Group) or (GroupName <> Group.Text) then
    begin
      Group := trvMenus.Items.Add(nil, GroupName) as TMenuNode;
      Group.Code := qryMenuTree.FieldByName('group_code').AsString;
      Group.SortIndex := qryMenuTree.FieldByName('grp_sort').AsInteger;
      Group.ImageIndex := 0;
      Group.SelectedIndex := 0;
//      Group.Test := 'abcd';
    end;

    Item := trvMenus.Items.AddChild(Group, qryMenuTree.FieldByName('menu_name').AsString) as TMenuNode;
    Item.Code := qryMenuTree.FieldByName('menu_code').AsString;
    Item.SortIndex := qryMenuTree.FieldByName('menu_sort').AsInteger;
    Item.ParentCode := Group.Code;
    Item.ImageIndex := 1;
    Item.SelectedIndex := 1;

    qryMenuTree.Next;
  end;

  trvMenus.FullExpand;
//  trvMenus.Items.EndUpdate;
end;

initialization
  TViewFactory.Instance.Regist(TfrmSYS1010);

finalization

end.
