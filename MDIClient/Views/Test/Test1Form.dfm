inherited frmTest1: TfrmTest1
  Caption = #53580#49828#53944' 01'
  ClientHeight = 428
  OnCreate = FormCreate
  ExplicitHeight = 467
  PixelsPerInch = 96
  TextHeight = 13
  inline DTFDBGridFrame1: TDTFDBGridFrame
    Left = 2
    Top = 4
    Width = 682
    Height = 313
    Align = alClient
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    TabOrder = 0
    ExplicitLeft = 2
    ExplicitTop = 4
    ExplicitWidth = 682
    ExplicitHeight = 313
    inherited DTFTitleFrame1: TDTFTitleFrame
      Width = 678
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 686
      inherited pnlCaption: TPanel
        Width = 682
        ExplicitWidth = 682
      end
    end
    inherited grdMaster: TDBGrid
      Top = 107
      Width = 678
      Height = 204
    end
    inherited pnlSearchControlArea: TPanel
      Width = 678
      Height = 63
      ExplicitWidth = 686
      ExplicitHeight = 63
    end
    inherited tlbDataSet: TToolBar
      Width = 678
      ExplicitLeft = 0
      ExplicitTop = 20
      ExplicitWidth = 686
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
    inherited ActionList: TActionList
      Left = 96
      Top = 248
      inherited actPrint: TAction
        Visible = True
      end
      inherited actDSExportXls: TAction
        Visible = True
      end
    end
    inherited DataSource: TDataSource
      DataSet = qryMenuItems
      Left = 184
      Top = 248
    end
  end
  object pnlSearchPanel: TPanel
    Left = 8
    Top = 48
    Width = 476
    Height = 41
    BevelOuter = bvNone
    TabOrder = 1
    object edtSchMenuName: TSearchBox
      Left = 7
      Top = 8
      Width = 146
      Height = 21
      TabOrder = 0
      TextHint = #47700#45684' '#51060#47492
    end
  end
  object Panel7: TPanel
    Left = 2
    Top = 317
    Width = 682
    Height = 109
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = 0
    ExplicitTop = 319
    ExplicitWidth = 686
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
      DataSource = DTFDBGridFrame1.DataSource
      TabOrder = 0
    end
    object edtMenuName: TDBEdit
      Left = 16
      Top = 72
      Width = 289
      Height = 21
      DataField = 'MENU_NAME'
      DataSource = DTFDBGridFrame1.DataSource
      TabOrder = 1
    end
  end
  object qryMenuItems: TFDQuery
    Active = True
    Connection = dmDatabase.FDConnection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'MENU_SEQ_GEN'
    SQL.Strings = (
      'SELECT * FROM menu_items'
      'WHERE menu_name LIKE :menu_name')
    Left = 290
    Top = 264
    ParamData = <
      item
        Name = 'MENU_NAME'
        DataType = ftWideString
        ParamType = ptInput
        Size = 400
        Value = '%'
      end>
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
end
