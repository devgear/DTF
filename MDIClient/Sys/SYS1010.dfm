inherited frmSYS1010: TfrmSYS1010
  Caption = #49884#49828#53596':: '#47700#45684' '#44288#47532
  ClientHeight = 551
  ClientWidth = 705
  OnResize = FormResize
  ExplicitWidth = 721
  ExplicitHeight = 590
  PixelsPerInch = 96
  TextHeight = 13
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 705
    Height = 281
    Align = alClient
    TabOrder = 0
    object pnlCate: TPanel
      Left = 1
      Top = 1
      Width = 360
      Height = 279
      Align = alLeft
      BevelOuter = bvLowered
      TabOrder = 0
      inline fmeCate: TfmeDTFDBGrid
        Left = 1
        Top = 21
        Width = 358
        Height = 156
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 21
        ExplicitWidth = 358
        ExplicitHeight = 156
        inherited tlbDataSet: TToolBar
          Width = 358
          ExplicitWidth = 358
        end
        inherited grdMaster: TDBGrid
          Width = 358
          Height = 134
        end
        inherited dsDataSet: TDataSource
          DataSet = qryMenuCates
        end
      end
      object Panel1: TPanel
        Left = 1
        Top = 177
        Width = 358
        Height = 101
        Align = alBottom
        TabOrder = 1
        DesignSize = (
          358
          101)
        object Label3: TLabel
          Left = 16
          Top = 52
          Width = 80
          Height = 13
          Caption = #47700#45684' '#52852#53580#44256#47532#47749
          FocusControl = DBEdit1
        end
        object Label5: TLabel
          Left = 16
          Top = 8
          Width = 69
          Height = 13
          Caption = #52852#53580#44256#47532' '#53076#46300
          FocusControl = DBEdit5
        end
        object DBEdit1: TDBEdit
          Left = 16
          Top = 68
          Width = 273
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          DataField = 'CATE_NAME'
          DataSource = fmeCate.dsDataSet
          TabOrder = 1
        end
        object DBEdit5: TDBEdit
          Left = 16
          Top = 24
          Width = 108
          Height = 21
          DataField = 'CATE_CODE'
          DataSource = fmeCate.dsDataSet
          TabOrder = 0
        end
      end
      object Panel5: TPanel
        Left = 1
        Top = 1
        Width = 358
        Height = 20
        Margins.Left = 12
        Align = alTop
        Alignment = taLeftJustify
        Caption = '   '#47700#45684' '#52852#53580#44256#47532
        Color = clActiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlightText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Padding.Left = 12
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
      end
    end
    object pnlPreview: TPanel
      Left = 361
      Top = 1
      Width = 343
      Height = 279
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 1
      DesignSize = (
        343
        279)
      object btnMenuRefresh: TSpeedButton
        Left = 287
        Top = 58
        Width = 36
        Height = 36
        Anchors = [akTop, akRight]
        ImageIndex = 2
        ImageName = 'icons8-refresh'
        Images = dmResource.vilMenus
        OnClick = btnMenuRefreshClick
      end
      object Panel6: TPanel
        Left = 1
        Top = 1
        Width = 341
        Height = 20
        Margins.Left = 12
        Align = alTop
        Alignment = taLeftJustify
        Caption = '   '#48120#47532#48372#44592
        Color = clActiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlightText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Padding.Left = 12
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
      end
      object trvMenus: TTreeView
        Left = 16
        Top = 58
        Width = 265
        Height = 208
        Anchors = [akLeft, akTop, akRight, akBottom]
        Images = dmResource.vilMenus
        Indent = 19
        TabOrder = 1
      end
      object cbxPrvCates: TDBLookupComboBox
        Left = 16
        Top = 31
        Width = 145
        Height = 21
        KeyField = 'CATE_SEQ'
        ListField = 'CATE_NAME'
        ListSource = dsPrvCates
        TabOrder = 2
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 281
    Width = 705
    Height = 270
    Align = alBottom
    TabOrder = 1
    object pnlGroup: TPanel
      Left = 1
      Top = 1
      Width = 360
      Height = 268
      Align = alLeft
      BevelOuter = bvLowered
      TabOrder = 0
      inline fmeGroup: TfmeDTFDBGrid
        Left = 1
        Top = 21
        Width = 358
        Height = 137
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 21
        ExplicitWidth = 358
        ExplicitHeight = 137
        inherited tlbDataSet: TToolBar
          Width = 358
          ExplicitWidth = 358
        end
        inherited grdMaster: TDBGrid
          Width = 358
          Height = 115
        end
        inherited dsDataSet: TDataSource
          DataSet = qryMenuGroups
        end
      end
      object Panel2: TPanel
        Left = 1
        Top = 158
        Width = 358
        Height = 109
        Align = alBottom
        TabOrder = 1
        DesignSize = (
          358
          109)
        object Label4: TLabel
          Left = 16
          Top = 12
          Width = 58
          Height = 13
          Caption = #47700#45684' '#44536#47353#47749
          FocusControl = DBEdit2
        end
        object DBEdit2: TDBEdit
          Left = 16
          Top = 28
          Width = 273
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          DataField = 'GROUP_NAME'
          DataSource = fmeGroup.dsDataSet
          TabOrder = 0
        end
      end
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 358
        Height = 20
        Margins.Left = 12
        Align = alTop
        Alignment = taLeftJustify
        Caption = '   '#47700#45684' '#44536#47353
        Color = clActiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlightText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Padding.Left = 12
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
      end
    end
    object pnlMenu: TPanel
      Left = 361
      Top = 1
      Width = 343
      Height = 268
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 1
      inline fmeMenu: TfmeDTFDBGrid
        Left = 1
        Top = 21
        Width = 341
        Height = 137
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 21
        ExplicitWidth = 341
        ExplicitHeight = 137
        inherited tlbDataSet: TToolBar
          Width = 341
          ExplicitWidth = 341
        end
        inherited grdMaster: TDBGrid
          Width = 341
          Height = 115
        end
        inherited aclDataSet: TActionList
          Left = 64
          Top = 72
        end
        inherited dsDataSet: TDataSource
          DataSet = qryMenuItems
        end
      end
      object Panel3: TPanel
        Left = 1
        Top = 1
        Width = 341
        Height = 20
        Margins.Left = 12
        Align = alTop
        Alignment = taLeftJustify
        Caption = '   '#47700#45684' '#50500#51060#53596
        Color = clActiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlightText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Padding.Left = 12
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
      end
      object Panel7: TPanel
        Left = 1
        Top = 158
        Width = 341
        Height = 109
        Align = alBottom
        TabOrder = 2
        object Label1: TLabel
          Left = 16
          Top = 12
          Width = 36
          Height = 13
          Caption = #47700#45684' ID'
          FocusControl = DBEdit3
        end
        object Label2: TLabel
          Left = 16
          Top = 56
          Width = 36
          Height = 13
          Caption = #47700#45684' '#47749
          FocusControl = DBEdit4
        end
        object DBEdit3: TDBEdit
          Left = 16
          Top = 28
          Width = 160
          Height = 21
          DataField = 'MENU_ID'
          DataSource = fmeMenu.dsDataSet
          TabOrder = 0
        end
        object DBEdit4: TDBEdit
          Left = 16
          Top = 72
          Width = 289
          Height = 21
          DataField = 'MENU_NAME'
          DataSource = fmeMenu.dsDataSet
          TabOrder = 1
        end
      end
    end
  end
  object qryMenuCates: TFDQuery
    Active = True
    AfterPost = qryMenuCatesAfterPost
    Connection = dmDatabase.FDConnection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'CATE_SEQ_GEN'
    SQL.Strings = (
      'SELECT * FROM menu_categories')
    Left = 240
    Top = 80
    object qryMenuCatesCATE_SEQ: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = #51068#47144#48264#54840
      FieldName = 'CATE_SEQ'
      Origin = 'CATE_SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryMenuCatesCATE_CODE: TWideStringField
      DisplayLabel = #52852#53580#44256#47532' '#53076#46300
      DisplayWidth = 8
      FieldName = 'CATE_CODE'
      Origin = 'CATE_CODE'
      Size = 32
    end
    object qryMenuCatesCATE_NAME: TWideStringField
      DisplayLabel = #47700#45684' '#52852#53580#44256#47532#47749
      DisplayWidth = 40
      FieldName = 'CATE_NAME'
      Origin = 'CATE_NAME'
      Required = True
      Size = 400
    end
  end
  object qryMenuGroups: TFDQuery
    Active = True
    IndexFieldNames = 'CATE_SEQ'
    MasterSource = fmeCate.dsDataSet
    MasterFields = 'CATE_SEQ'
    DetailFields = 'CATE_SEQ'
    Connection = dmDatabase.FDConnection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'GROUP_SEQ_GEN'
    SQL.Strings = (
      'SELECT * FROM menu_groups')
    Left = 256
    Top = 360
    object qryMenuGroupsGROUP_SEQ: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = #51068#47144#48264#54840
      FieldName = 'GROUP_SEQ'
      Origin = 'GROUP_SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryMenuGroupsCATE_SEQ: TIntegerField
      FieldName = 'CATE_SEQ'
      Origin = 'CATE_SEQ'
      Visible = False
    end
    object qryMenuGroupsGROUP_NAME: TWideStringField
      DisplayLabel = #47700#45684' '#44536#47353#47749
      DisplayWidth = 40
      FieldName = 'GROUP_NAME'
      Origin = 'GROUP_NAME'
      Required = True
      Size = 400
    end
  end
  object qryMenuItems: TFDQuery
    Active = True
    IndexFieldNames = 'GROUP_SEQ'
    MasterSource = fmeGroup.dsDataSet
    MasterFields = 'GROUP_SEQ'
    Connection = dmDatabase.FDConnection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'MENU_SEQ_GEN'
    SQL.Strings = (
      'SELECT * FROM menu_items')
    Left = 608
    Top = 352
    object qryMenuItemsMENU_SEQ: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = #51068#47144#48264#54840
      FieldName = 'MENU_SEQ'
      Origin = 'MENU_SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryMenuItemsGROUP_SEQ: TIntegerField
      FieldName = 'GROUP_SEQ'
      Origin = 'GROUP_SEQ'
      Visible = False
    end
    object qryMenuItemsMENU_ID: TWideStringField
      DisplayLabel = #47700#45684' ID'
      DisplayWidth = 12
      FieldName = 'MENU_ID'
      Origin = 'MENU_ID'
      Required = True
      Size = 64
    end
    object qryMenuItemsMENU_NAME: TWideStringField
      DisplayLabel = #47700#45684' '#47749
      DisplayWidth = 40
      FieldName = 'MENU_NAME'
      Origin = 'MENU_NAME'
      Required = True
      Size = 400
    end
  end
  object qryPrvGroups: TFDQuery
    Active = True
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
    Active = True
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
    Active = True
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
end
