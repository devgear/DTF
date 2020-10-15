inherited frmSYS1010: TfrmSYS1010
  Caption = #49884#49828#53596':: '#47700#45684' '#44288#47532
  ClientHeight = 496
  ClientWidth = 804
  ExplicitWidth = 820
  ExplicitHeight = 535
  PixelsPerInch = 96
  TextHeight = 13
  object GridPanel1: TGridPanel
    Left = 0
    Top = 0
    Width = 804
    Height = 496
    Align = alClient
    Caption = 'GridPanel1'
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
      Width = 401
      Height = 247
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 0
      inline fmeCate: TDTFDBGridFrame
        Left = 1
        Top = 21
        Width = 399
        Height = 124
        Align = alClient
        Padding.Left = 8
        Padding.Top = 4
        Padding.Right = 8
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 21
        ExplicitWidth = 399
        ExplicitHeight = 124
        inherited tlbDataSet: TToolBar
          Width = 383
          ExplicitWidth = 383
        end
        inherited grdMaster: TDBGrid
          Width = 383
          Height = 98
        end
        inherited DataSource: TDataSource
          DataSet = qryMenuCates
        end
      end
      object Panel1: TPanel
        Left = 1
        Top = 145
        Width = 399
        Height = 101
        Align = alBottom
        TabOrder = 1
        DesignSize = (
          399
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
          Width = 314
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
      inline DTFTitleFrame1: TDTFTitleFrame
        Left = 1
        Top = 1
        Width = 399
        Height = 20
        Align = alTop
        Color = clActiveCaption
        ParentBackground = False
        ParentColor = False
        TabOrder = 2
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 399
        inherited Title: TLabel
          Width = 388
          Height = 15
          Caption = #50629#47924' '#44396#48516'('#52852#53580#44256#47532')'
          ExplicitWidth = 104
        end
      end
    end
    object pnlPreview: TPanel
      Left = 402
      Top = 1
      Width = 401
      Height = 247
      Align = alClient
      Anchors = []
      BevelOuter = bvLowered
      TabOrder = 1
      DesignSize = (
        401
        247)
      object btnMenuRefresh: TSpeedButton
        Left = 345
        Top = 58
        Width = 36
        Height = 36
        Anchors = [akTop, akRight]
        ImageIndex = 2
        ImageName = 'icons8-refresh'
        Images = dmResource.vilMenus
        OnClick = btnMenuRefreshClick
        ExplicitLeft = 287
      end
      object trvMenus: TTreeView
        Left = 16
        Top = 58
        Width = 323
        Height = 176
        Anchors = [akLeft, akTop, akRight, akBottom]
        Images = dmResource.vilMenus
        Indent = 19
        TabOrder = 0
      end
      object cbxPrvCates: TDBLookupComboBox
        Left = 16
        Top = 31
        Width = 145
        Height = 21
        KeyField = 'CATE_SEQ'
        ListField = 'CATE_NAME'
        ListSource = dsPrvCates
        TabOrder = 1
      end
      inline DTFTitleFrame2: TDTFTitleFrame
        Left = 1
        Top = 1
        Width = 399
        Height = 20
        Align = alTop
        Color = clActiveCaption
        ParentBackground = False
        ParentColor = False
        TabOrder = 2
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 399
        inherited Title: TLabel
          Width = 388
          Height = 15
          Caption = #48120#47532#48372#44592
          ExplicitWidth = 44
        end
      end
    end
    object pnlGroup: TPanel
      Left = 1
      Top = 248
      Width = 401
      Height = 247
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 2
      inline fmeGroup: TDTFDBGridFrame
        Left = 1
        Top = 21
        Width = 399
        Height = 116
        Align = alClient
        Padding.Left = 8
        Padding.Top = 4
        Padding.Right = 8
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 21
        ExplicitWidth = 399
        ExplicitHeight = 116
        inherited tlbDataSet: TToolBar
          Width = 383
          ExplicitWidth = 383
        end
        inherited grdMaster: TDBGrid
          Width = 383
          Height = 90
        end
        inherited DataSource: TDataSource
          DataSet = qryMenuGroups
        end
      end
      object Panel2: TPanel
        Left = 1
        Top = 137
        Width = 399
        Height = 109
        Align = alBottom
        TabOrder = 1
        DesignSize = (
          399
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
          Width = 314
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
      inline DTFTitleFrame3: TDTFTitleFrame
        Left = 1
        Top = 1
        Width = 399
        Height = 20
        Align = alTop
        Color = clActiveCaption
        ParentBackground = False
        ParentColor = False
        TabOrder = 2
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 399
        inherited Title: TLabel
          Width = 388
          Height = 15
          Caption = #47700#45684' '#44536#47353
          ExplicitWidth = 48
        end
      end
    end
    object pnlMenu: TPanel
      Left = 402
      Top = 248
      Width = 401
      Height = 247
      Align = alClient
      Anchors = []
      BevelOuter = bvLowered
      TabOrder = 3
      inline fmeMenu: TDTFDBGridFrame
        Left = 1
        Top = 21
        Width = 399
        Height = 116
        Align = alClient
        Padding.Left = 8
        Padding.Top = 4
        Padding.Right = 8
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 21
        ExplicitWidth = 399
        ExplicitHeight = 116
        inherited tlbDataSet: TToolBar
          Width = 383
          ExplicitWidth = 383
        end
        inherited grdMaster: TDBGrid
          Width = 383
          Height = 90
        end
        inherited ActionList: TActionList
          Left = 64
          Top = 72
        end
        inherited DataSource: TDataSource
          DataSet = qryMenuItems
        end
      end
      object Panel7: TPanel
        Left = 1
        Top = 137
        Width = 399
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
      inline DTFTitleFrame4: TDTFTitleFrame
        Left = 1
        Top = 1
        Width = 399
        Height = 20
        Align = alTop
        Color = clActiveCaption
        ParentBackground = False
        ParentColor = False
        TabOrder = 2
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 399
        inherited Title: TLabel
          Width = 388
          Height = 15
          Caption = #47700#45684
        end
      end
    end
  end
  object qryMenuCates: TFDQuery
    Active = True
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
    SQL.Strings = (
      'SELECT * FROM menu_items'
      'ORDER BY group_code, sort_index')
    Left = 608
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
  object qryPrvGroups: TFDQuery
    IndexFieldNames = 'CATE_SEQ'
    MasterSource = dsPrvCates
    MasterFields = 'CATE_SEQ'
    Connection = dmDatabase.FDConnection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'GROUP_SEQ_GEN'
    UpdateOptions.AutoIncFields = 'GROUP_SEQ'
    SQL.Strings = (
      'SELECT * FROM menu_groups')
    Left = 416
    Top = 136
    object IntegerField1: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = #51068#47144#48264#54840
      FieldName = 'GROUP_SEQ'
      Origin = 'GROUP_SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object IntegerField2: TIntegerField
      FieldName = 'CATE_SEQ'
      Origin = 'CATE_SEQ'
      Visible = False
    end
    object WideStringField1: TWideStringField
      DisplayLabel = #47700#45684' '#44536#47353#47749
      DisplayWidth = 40
      FieldName = 'GROUP_NAME'
      Origin = 'GROUP_NAME'
      Required = True
      Size = 400
    end
  end
  object qryPrvItems: TFDQuery
    IndexFieldNames = 'GROUP_SEQ'
    MasterSource = dsPrvGroups
    MasterFields = 'GROUP_SEQ'
    DetailFields = 'GROUP_SEQ'
    Connection = dmDatabase.FDConnection
    SQL.Strings = (
      'SELECT * FROM menu_items')
    Left = 416
    Top = 200
    object IntegerField3: TIntegerField
      DisplayLabel = #51068#47144#48264#54840
      FieldName = 'MENU_SEQ'
      Origin = 'MENU_SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object IntegerField4: TIntegerField
      FieldName = 'GROUP_SEQ'
      Origin = 'GROUP_SEQ'
      Visible = False
    end
    object WideStringField2: TWideStringField
      DisplayLabel = #47700#45684' ID'
      DisplayWidth = 12
      FieldName = 'MENU_ID'
      Origin = 'MENU_ID'
      Required = True
      Size = 64
    end
    object WideStringField3: TWideStringField
      DisplayLabel = #47700#45684' '#47749
      DisplayWidth = 40
      FieldName = 'MENU_NAME'
      Origin = 'MENU_NAME'
      Required = True
      Size = 400
    end
  end
  object dsPrvGroups: TDataSource
    DataSet = qryPrvGroups
    Left = 496
    Top = 136
  end
  object qryPrvCates: TFDQuery
    Connection = dmDatabase.FDConnection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'CATE_SEQ_GEN'
    UpdateOptions.AutoIncFields = 'CATE_SEQ'
    SQL.Strings = (
      'SELECT * FROM menu_categories')
    Left = 416
    Top = 80
    object IntegerField5: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = #51068#47144#48264#54840
      FieldName = 'CATE_SEQ'
      Origin = 'CATE_SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object WideStringField4: TWideStringField
      DisplayLabel = #52852#53580#44256#47532' '#53076#46300
      DisplayWidth = 8
      FieldName = 'CATE_CODE'
      Origin = 'CATE_CODE'
      Size = 32
    end
    object WideStringField5: TWideStringField
      DisplayLabel = #47700#45684' '#52852#53580#44256#47532#47749
      DisplayWidth = 40
      FieldName = 'CATE_NAME'
      Origin = 'CATE_NAME'
      Required = True
      Size = 400
    end
  end
  object dsPrvCates: TDataSource
    DataSet = qryPrvCates
    OnDataChange = dsPrvCatesDataChange
    Left = 496
    Top = 80
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
    Left = 704
    Top = 352
  end
end
