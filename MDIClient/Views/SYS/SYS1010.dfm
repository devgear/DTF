inherited frmSYS1010: TfrmSYS1010
  Caption = #49884#49828#53596':: '#47700#45684' '#44288#47532
  ClientHeight = 558
  ClientWidth = 927
  OnCreate = FormCreate
  ExplicitWidth = 943
  ExplicitHeight = 597
  PixelsPerInch = 96
  TextHeight = 13
  object GridPanel1: TGridPanel
    Left = 0
    Top = 0
    Width = 927
    Height = 558
    Align = alClient
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = pnlCate
        Row = 0
      end
      item
        Column = 1
        Control = pnlPreview
        Row = 0
      end
      item
        Column = 0
        Control = pnlGroup
        Row = 1
      end
      item
        Column = 1
        Control = pnlMenu
        Row = 1
      end>
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    TabOrder = 0
    object pnlCate: TPanel
      Left = 1
      Top = 1
      Width = 462
      Height = 278
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 0
      inline fmeCate: TDTFDBGridFrame
        Left = 1
        Top = 1
        Width = 460
        Height = 175
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 21
        ExplicitWidth = 460
        ExplicitHeight = 155
        inherited tlbDataSet: TToolBar
          Left = 0
          Top = 20
          Width = 460
          ExplicitTop = 24
          ExplicitWidth = 444
          ExplicitHeight = 44
          inherited btnDSRefresh: TToolButton
            ExplicitWidth = 53
          end
          inherited btnDSNew: TToolButton
            ExplicitWidth = 75
          end
          inherited btnDSSave: TToolButton
            ExplicitWidth = 53
          end
          inherited btnDSCancel: TToolButton
            ExplicitWidth = 75
          end
          inherited btnDSDelete: TToolButton
            ExplicitWidth = 53
          end
          inherited btnExportXls: TToolButton
            ExplicitWidth = 89
          end
          inherited ToolButton2: TToolButton
            ExplicitWidth = 53
          end
        end
        inherited grdMaster: TDBGrid
          Left = 0
          Top = 65
          Width = 460
          Height = 110
        end
        inherited pnlSearchControlArea: TPanel
          Left = 0
          Top = 42
          Width = 460
          ExplicitTop = 68
          ExplicitWidth = 444
        end
        inherited DTFTitleFrame1: TDTFTitleFrame
          Left = 0
          Top = 0
          Width = 460
          ExplicitTop = 4
          ExplicitWidth = 444
          inherited pnlCaption: TPanel
            Width = 460
            Caption = #47700#45684' '#52852#53580#44256#47532
            ExplicitWidth = 444
          end
        end
        inherited DataSource: TDataSource
          DataSet = qryMenuCates
          OnDataChange = fmeCateDataSourceDataChange
        end
      end
      object Panel1: TPanel
        Left = 1
        Top = 176
        Width = 460
        Height = 101
        Align = alBottom
        TabOrder = 1
        DesignSize = (
          460
          101)
        object Label3: TLabel
          Left = 8
          Top = 52
          Width = 80
          Height = 13
          Caption = #47700#45684' '#52852#53580#44256#47532#47749
          FocusControl = edtCateName
        end
        object Label5: TLabel
          Left = 8
          Top = 8
          Width = 69
          Height = 13
          Caption = #52852#53580#44256#47532' '#53076#46300
          FocusControl = edtCateCode
        end
        object edtCateName: TDBEdit
          Left = 8
          Top = 68
          Width = 375
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          DataField = 'CATE_NAME'
          DataSource = fmeCate.DataSource
          TabOrder = 1
        end
        object edtCateCode: TDBEdit
          Left = 8
          Top = 24
          Width = 108
          Height = 21
          DataField = 'CATE_CODE'
          DataSource = fmeCate.DataSource
          TabOrder = 0
        end
      end
    end
    object pnlPreview: TPanel
      Left = 463
      Top = 1
      Width = 463
      Height = 278
      Align = alClient
      Anchors = []
      BevelOuter = bvLowered
      TabOrder = 1
      DesignSize = (
        463
        278)
      object btnMenuRefresh: TSpeedButton
        Left = 415
        Top = 57
        Width = 36
        Height = 36
        Action = actMenuTreeRefresh
        Anchors = [akTop, akRight]
        Images = dmResource.vilMenus
      end
      object SpeedButton1: TSpeedButton
        Left = 415
        Top = 99
        Width = 36
        Height = 36
        Action = actMenuTreeUp
        Anchors = [akTop, akRight]
        Images = dmResource.vilMenus
      end
      object SpeedButton2: TSpeedButton
        Left = 415
        Top = 134
        Width = 36
        Height = 36
        Action = actMenuTreeDown
        Anchors = [akTop, akRight]
        Images = dmResource.vilMenus
      end
      object SpeedButton3: TSpeedButton
        Left = 415
        Top = 176
        Width = 36
        Height = 36
        Action = actMenuTreeSave
        Anchors = [akTop, akRight]
        Images = dmResource.vilMenus
      end
      object Label7: TLabel
        Left = 12
        Top = 35
        Width = 317
        Height = 13
        AutoSize = False
        Caption = #47700#45684' '#49692#49436#47484' '#48320#44221'('#47560#50864#49828#47196' '#46300#47000#44536', '#50629'/'#45796#50868' '#48260#53948') '#54980' '#51200#51109#54616#49464#50836'.'
      end
      object trvMenus: TTreeView
        Left = 10
        Top = 54
        Width = 399
        Height = 210
        Anchors = [akLeft, akTop, akRight, akBottom]
        DragMode = dmAutomatic
        Images = dmResource.vilMenus
        Indent = 19
        ShowButtons = False
        TabOrder = 0
        OnCreateNodeClass = trvMenusCreateNodeClass
        OnDragDrop = trvMenusDragDrop
        OnDragOver = trvMenusDragOver
      end
      inline DTFTitleFrame2: TDTFTitleFrame
        Left = 1
        Top = 1
        Width = 461
        Height = 20
        Margins.Left = 8
        Align = alTop
        Color = clBtnFace
        ParentBackground = False
        ParentColor = False
        TabOrder = 1
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 461
        inherited pnlCaption: TPanel
          Width = 461
          Caption = #48120#47532#48372#44592
          ExplicitWidth = 461
        end
      end
    end
    object pnlGroup: TPanel
      Left = 1
      Top = 279
      Width = 462
      Height = 278
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 2
      inline fmeGroup: TDTFDBGridFrame
        Left = 1
        Top = 1
        Width = 460
        Height = 167
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 21
        ExplicitWidth = 460
        ExplicitHeight = 147
        inherited tlbDataSet: TToolBar
          Left = 0
          Top = 20
          Width = 460
          ExplicitTop = 24
          ExplicitWidth = 444
          ExplicitHeight = 44
          inherited btnDSRefresh: TToolButton
            ExplicitWidth = 53
          end
          inherited btnDSNew: TToolButton
            ExplicitWidth = 75
          end
          inherited btnDSSave: TToolButton
            ExplicitWidth = 53
          end
          inherited btnDSCancel: TToolButton
            ExplicitWidth = 75
          end
          inherited btnDSDelete: TToolButton
            ExplicitWidth = 53
          end
          inherited btnExportXls: TToolButton
            ExplicitWidth = 89
          end
          inherited ToolButton2: TToolButton
            ExplicitWidth = 53
          end
        end
        inherited grdMaster: TDBGrid
          Left = 0
          Top = 65
          Width = 460
          Height = 102
        end
        inherited pnlSearchControlArea: TPanel
          Left = 0
          Top = 42
          Width = 460
          ExplicitTop = 68
          ExplicitWidth = 444
        end
        inherited DTFTitleFrame1: TDTFTitleFrame
          Left = 0
          Top = 0
          Width = 460
          ExplicitTop = 4
          ExplicitWidth = 444
          inherited pnlCaption: TPanel
            Width = 460
            Caption = #47700#45684' '#44536#47353
            ExplicitWidth = 444
          end
        end
        inherited ActionList: TActionList
          inherited actPrint: TAction
            Hint = #47700#45684' '#44536#47353
            Visible = True
          end
          inherited actDSExportXls: TAction
            Visible = True
          end
        end
        inherited DataSource: TDataSource
          DataSet = qryMenuGroups
        end
      end
      object Panel2: TPanel
        Left = 1
        Top = 168
        Width = 460
        Height = 109
        Align = alBottom
        TabOrder = 1
        DesignSize = (
          460
          109)
        object Label4: TLabel
          Left = 8
          Top = 56
          Width = 58
          Height = 13
          Caption = #47700#45684' '#44536#47353#47749
          FocusControl = edtGroupName
        end
        object Label6: TLabel
          Left = 8
          Top = 12
          Width = 47
          Height = 13
          Caption = #44536#47353' '#53076#46300
          FocusControl = edtGroupCode
        end
        object edtGroupName: TDBEdit
          Left = 8
          Top = 72
          Width = 375
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          DataField = 'GROUP_NAME'
          DataSource = fmeGroup.DataSource
          TabOrder = 1
        end
        object edtGroupCode: TDBEdit
          Left = 8
          Top = 28
          Width = 160
          Height = 21
          DataField = 'GROUP_CODE'
          DataSource = fmeGroup.DataSource
          TabOrder = 0
        end
      end
    end
    object pnlMenu: TPanel
      Left = 463
      Top = 279
      Width = 463
      Height = 278
      Align = alClient
      Anchors = []
      BevelOuter = bvLowered
      TabOrder = 3
      inline fmeMenu: TDTFDBGridFrame
        Left = 1
        Top = 1
        Width = 461
        Height = 167
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 21
        ExplicitWidth = 461
        ExplicitHeight = 147
        inherited tlbDataSet: TToolBar
          Left = 0
          Top = 20
          Width = 461
          ExplicitTop = 24
          ExplicitWidth = 445
          ExplicitHeight = 44
          inherited btnDSRefresh: TToolButton
            ExplicitWidth = 53
          end
          inherited btnDSNew: TToolButton
            ExplicitWidth = 75
          end
          inherited btnDSSave: TToolButton
            ExplicitWidth = 53
          end
          inherited btnDSCancel: TToolButton
            ExplicitWidth = 75
          end
          inherited btnDSDelete: TToolButton
            ExplicitWidth = 53
          end
          inherited btnExportXls: TToolButton
            ExplicitWidth = 89
          end
          inherited ToolButton2: TToolButton
            ExplicitWidth = 53
          end
        end
        inherited grdMaster: TDBGrid
          Left = 0
          Top = 65
          Width = 461
          Height = 102
        end
        inherited pnlSearchControlArea: TPanel
          Left = 0
          Top = 42
          Width = 461
          ExplicitTop = 68
          ExplicitWidth = 445
        end
        inherited DTFTitleFrame1: TDTFTitleFrame
          Left = 0
          Top = 0
          Width = 461
          ExplicitTop = 4
          ExplicitWidth = 445
          inherited pnlCaption: TPanel
            Width = 461
            Caption = #47700#45684
            ExplicitWidth = 445
          end
        end
        inherited ActionList: TActionList
          Left = 48
          Top = 48
          inherited actDSExportXls: TAction
            Hint = #55180#53944#55180#53944
            Visible = True
          end
        end
        inherited DataSource: TDataSource
          DataSet = qryMenuItems
          Left = 136
          Top = 48
        end
      end
      object Panel7: TPanel
        Left = 1
        Top = 168
        Width = 461
        Height = 109
        Align = alBottom
        TabOrder = 1
        object Label1: TLabel
          Left = 16
          Top = 12
          Width = 47
          Height = 13
          Caption = #47700#45684' '#53076#46300
          FocusControl = edtMenuCode
        end
        object Label2: TLabel
          Left = 16
          Top = 56
          Width = 36
          Height = 13
          Caption = #47700#45684' '#47749
          FocusControl = edtMenuName
        end
        object edtMenuCode: TDBEdit
          Left = 16
          Top = 28
          Width = 160
          Height = 21
          DataField = 'MENU_CODE'
          DataSource = fmeMenu.DataSource
          TabOrder = 0
        end
        object edtMenuName: TDBEdit
          Left = 16
          Top = 72
          Width = 289
          Height = 21
          DataField = 'MENU_NAME'
          DataSource = fmeMenu.DataSource
          TabOrder = 1
        end
      end
    end
  end
  object qryMenuCates: TFDQuery
    AfterPost = qryMenuCatesAfterPost
    Connection = dmDatabase.FDConnection
    SQL.Strings = (
      'SELECT * FROM menu_categories')
    Left = 216
    Top = 88
    object qryMenuCatesCATE_CODE: TWideStringField
      DisplayLabel = #53076#46300
      DisplayWidth = 8
      FieldName = 'CATE_CODE'
      Origin = 'CATE_CODE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 64
    end
    object qryMenuCatesCATE_NAME: TWideStringField
      DisplayLabel = #52852#53580#44256#47532' '#51060#47492
      DisplayWidth = 40
      FieldName = 'CATE_NAME'
      Origin = 'CATE_NAME'
      Required = True
      Size = 400
    end
  end
  object qryMenuGroups: TFDQuery
    Active = True
    AfterPost = qryMenuGroupsAfterPost
    IndexFieldNames = 'CATE_CODE'
    MasterSource = fmeCate.DataSource
    MasterFields = 'CATE_CODE'
    DetailFields = 'CATE_CODE'
    Connection = dmDatabase.FDConnection
    SQL.Strings = (
      'SELECT * FROM menu_groups'
      'ORDER BY cate_code, sort_index')
    Left = 192
    Top = 336
    object qryMenuGroupsGROUP_CODE: TWideStringField
      DisplayLabel = #44536#47353' '#53076#46300
      DisplayWidth = 12
      FieldName = 'GROUP_CODE'
      Origin = 'GROUP_CODE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 64
    end
    object qryMenuGroupsGROUP_NAME: TWideStringField
      DisplayLabel = #44536#47353' '#51060#47492
      DisplayWidth = 32
      FieldName = 'GROUP_NAME'
      Origin = 'GROUP_NAME'
      Required = True
      Size = 400
    end
    object qryMenuGroupsCATE_CODE: TWideStringField
      FieldName = 'CATE_CODE'
      Origin = 'CATE_CODE'
      Visible = False
      Size = 64
    end
    object qryMenuGroupsCATE_NAME: TStringField
      DisplayLabel = #52852#53580#44256#47532
      FieldKind = fkLookup
      FieldName = 'CATE_NAME'
      LookupDataSet = qryCateLookup
      LookupKeyFields = 'CATE_CODE'
      LookupResultField = 'CATE_NAME'
      KeyFields = 'CATE_CODE'
      Lookup = True
    end
    object qryMenuGroupsSORT_INDEX: TIntegerField
      FieldName = 'SORT_INDEX'
      Origin = 'SORT_INDEX'
      Visible = False
    end
  end
  object qryMenuItems: TFDQuery
    Active = True
    IndexFieldNames = 'GROUP_CODE'
    MasterSource = fmeGroup.DataSource
    MasterFields = 'GROUP_CODE'
    DetailFields = 'GROUP_CODE'
    Connection = dmDatabase.FDConnection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'MENU_SEQ_GEN'
    UpdateObject = FDUpdateSQL1
    SQL.Strings = (
      'SELECT * FROM menu_items'
      'ORDER BY group_code, sort_index')
    Left = 688
    Top = 352
    object qryMenuItemsMENU_CODE: TWideStringField
      DisplayLabel = #47700#45684' '#53076#46300
      DisplayWidth = 12
      FieldName = 'MENU_CODE'
      Origin = 'MENU_CODE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 64
    end
    object qryMenuItemsMENU_NAME: TWideStringField
      DisplayLabel = #47700#45684' '#51060#47492
      DisplayWidth = 32
      FieldName = 'MENU_NAME'
      Origin = 'MENU_NAME'
      Required = True
      Size = 400
    end
    object qryMenuItemsGROUP_NAME: TStringField
      DisplayLabel = #44536#47353
      DisplayWidth = 16
      FieldKind = fkLookup
      FieldName = 'GROUP_NAME'
      LookupDataSet = qryGroupLookup
      LookupKeyFields = 'GROUP_CODE'
      LookupResultField = 'GROUP_NAME'
      KeyFields = 'GROUP_CODE'
      Lookup = True
    end
    object qryMenuItemsGROUP_CODE: TWideStringField
      FieldName = 'GROUP_CODE'
      Origin = 'GROUP_CODE'
      Visible = False
      Size = 64
    end
    object qryMenuItemsSORT_INDEX: TIntegerField
      FieldName = 'SORT_INDEX'
      Origin = 'SORT_INDEX'
      Visible = False
    end
  end
  object qryCateLookup: TFDQuery
    Active = True
    Connection = dmDatabase.FDConnection
    SQL.Strings = (
      'SELECT cate_code, cate_name FROM menu_categories')
    Left = 272
    Top = 336
  end
  object qryGroupLookup: TFDQuery
    Active = True
    Connection = dmDatabase.FDConnection
    SQL.Strings = (
      'SELECT group_code, group_name FROM menu_groups')
    Left = 776
    Top = 352
  end
  object qryMenuTree: TFDQuery
    Active = True
    Connection = dmDatabase.FDConnection
    SQL.Strings = (
      'SELECT'
      '  grp.group_code, group_name, grp.sort_index grp_sort,'
      '  menu_code, menu_name, item.sort_index menu_sort'
      'FROM'
      '  menu_groups grp'
      '    LEFT OUTER JOIN menu_items item'
      '    ON item.group_code = grp.group_code'
      'WHERE'
      '  Upper(cate_code) = Upper(:cate_code)'
      'ORDER BY'
      '  grp.sort_index, item.sort_index')
    Left = 520
    Top = 96
    ParamData = <
      item
        Name = 'CATE_CODE'
        DataType = ftString
        ParamType = ptInput
        Value = 'HOME'
      end>
  end
  object actMenuTree: TActionList
    Images = dmResource.vilMenus
    Left = 664
    Top = 96
    object actMenuTreeRefresh: TAction
      ImageIndex = 2
      ImageName = 'icons8-refresh'
      OnExecute = actMenuTreeRefreshExecute
    end
    object actMenuTreeSave: TAction
      ImageIndex = 3
      ImageName = 'icons8-save'
      OnExecute = actMenuTreeSaveExecute
      OnUpdate = actMenuTreeSaveUpdate
    end
    object actMenuTreeUp: TAction
      ImageIndex = 4
      ImageName = 'icons8-up'
      OnExecute = actMenuTreeUpExecute
      OnUpdate = actMenuTreeUpUpdate
    end
    object actMenuTreeDown: TAction
      ImageIndex = 5
      ImageName = 'icons8-down'
      OnExecute = actMenuTreeDownExecute
      OnUpdate = actMenuTreeDownUpdate
    end
  end
  object qryMenuUpdate: TFDQuery
    Connection = dmDatabase.FDConnection
    Left = 520
    Top = 152
  end
  object FDUpdateSQL1: TFDUpdateSQL
    Left = 776
    Top = 448
  end
end
