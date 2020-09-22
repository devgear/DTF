inherited frmSYS1010: TfrmSYS1010
  Caption = #49884#49828#53596':: '#47700#45684' '#44288#47532
  ClientHeight = 514
  ClientWidth = 705
  OnResize = FormResize
  ExplicitWidth = 721
  ExplicitHeight = 553
  PixelsPerInch = 96
  TextHeight = 13
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 705
    Height = 248
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 176
    ExplicitTop = 56
    ExplicitWidth = 185
    ExplicitHeight = 41
    object pnlCate: TPanel
      Left = 1
      Top = 1
      Width = 360
      Height = 246
      Align = alLeft
      BevelOuter = bvLowered
      TabOrder = 0
      inline fmeCate: TfmeDTFDBGrid
        Left = 1
        Top = 21
        Width = 358
        Height = 163
        Align = alTop
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 14
        ExplicitWidth = 358
        ExplicitHeight = 163
        inherited tlbDataSet: TToolBar
          Width = 358
        end
        inherited DBGrid1: TDBGrid
          Width = 358
          Height = 141
        end
        inherited dsDataSet: TDataSource
          DataSet = qryMenuCates
        end
      end
      object Panel1: TPanel
        Left = 1
        Top = 184
        Width = 358
        Height = 61
        Align = alClient
        TabOrder = 1
        ExplicitLeft = 88
        ExplicitTop = 104
        ExplicitWidth = 185
        ExplicitHeight = 41
        object Label3: TLabel
          Left = 16
          Top = 16
          Width = 80
          Height = 13
          Caption = #47700#45684' '#52852#53580#44256#47532#47749
          FocusControl = DBEdit1
        end
        object DBEdit1: TDBEdit
          Left = 16
          Top = 32
          Width = 200
          Height = 21
          DataField = 'CATE_NAME'
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
        ExplicitLeft = 2
        ExplicitTop = 9
      end
    end
    object pnlPreview: TPanel
      Left = 361
      Top = 1
      Width = 343
      Height = 246
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 1
      ExplicitLeft = 264
      ExplicitTop = 104
      ExplicitWidth = 185
      ExplicitHeight = 41
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
        ExplicitLeft = 2
        ExplicitTop = 9
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 248
    Width = 705
    Height = 266
    Align = alBottom
    TabOrder = 1
    object pnlGroup: TPanel
      Left = 1
      Top = 1
      Width = 360
      Height = 264
      Align = alLeft
      BevelOuter = bvLowered
      TabOrder = 0
      inline fmeGroup: TfmeDTFDBGrid
        Left = 1
        Top = 21
        Width = 358
        Height = 163
        Align = alTop
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 14
        ExplicitWidth = 358
        ExplicitHeight = 163
        inherited tlbDataSet: TToolBar
          Width = 358
          ExplicitWidth = 358
        end
        inherited DBGrid1: TDBGrid
          Width = 358
          Height = 141
        end
        inherited dsDataSet: TDataSource
          DataSet = qryMenuGroup
        end
      end
      object Panel2: TPanel
        Left = 1
        Top = 184
        Width = 358
        Height = 79
        Align = alClient
        TabOrder = 1
        ExplicitLeft = 2
        ExplicitTop = 178
        ExplicitHeight = 86
        object Label4: TLabel
          Left = 16
          Top = 16
          Width = 58
          Height = 13
          Caption = #47700#45684' '#44536#47353#47749
          FocusControl = DBEdit2
        end
        object DBEdit2: TDBEdit
          Left = 16
          Top = 32
          Width = 200
          Height = 21
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
        ExplicitLeft = 2
        ExplicitTop = 9
      end
    end
    object pnlMenu: TPanel
      Left = 361
      Top = 1
      Width = 343
      Height = 264
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 1
      ExplicitLeft = 432
      ExplicitTop = 104
      ExplicitWidth = 185
      ExplicitHeight = 41
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
        TabOrder = 0
        ExplicitLeft = 80
        ExplicitTop = 112
        ExplicitWidth = 185
      end
    end
  end
  object qryMenuCates: TFDQuery
    Active = True
    Connection = dmDatabase.FDConnection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'CATE_SEQ_GEN'
    UpdateOptions.AutoIncFields = 'CATE_SEQ'
    SQL.Strings = (
      'SELECT * FROM menu_categories')
    Left = 144
    Top = 136
    object qryMenuCatesCATE_SEQ: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = #51068#47144#48264#54840
      FieldName = 'CATE_SEQ'
      Origin = 'CATE_SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
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
  object qryMenuGroup: TFDQuery
    Active = True
    IndexFieldNames = 'CATE_SEQ'
    MasterSource = fmeCate.dsDataSet
    MasterFields = 'CATE_SEQ'
    DetailFields = 'CATE_SEQ'
    Connection = dmDatabase.FDConnection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'GROUP_SEQ_GEN'
    UpdateOptions.AutoIncFields = 'GROUP_SEQ'
    SQL.Strings = (
      'SELECT * FROM menu_groups')
    Left = 152
    Top = 360
    object qryMenuGroupGROUP_SEQ: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = #51068#47144#48264#54840
      FieldName = 'GROUP_SEQ'
      Origin = 'GROUP_SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryMenuGroupCATE_SEQ: TIntegerField
      FieldName = 'CATE_SEQ'
      Origin = 'CATE_SEQ'
      Visible = False
    end
    object qryMenuGroupGROUP_NAME: TWideStringField
      DisplayLabel = #47700#45684' '#44536#47353#47749
      DisplayWidth = 40
      FieldName = 'GROUP_NAME'
      Origin = 'GROUP_NAME'
      Required = True
      Size = 400
    end
  end
end
