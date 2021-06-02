inherited frmTest1: TfrmTest1
  Caption = #53580#49828#53944' 01'
  ClientHeight = 428
  OnCreate = FormCreate
  ExplicitHeight = 467
  PixelsPerInch = 96
  TextHeight = 13
  inline DTFDBGridFrame1: TDTFDBGridFrame
    Left = 0
    Top = 20
    Width = 686
    Height = 299
    Align = alClient
    Padding.Left = 8
    Padding.Top = 4
    Padding.Right = 8
    TabOrder = 0
    ExplicitTop = 20
    ExplicitWidth = 686
    ExplicitHeight = 299
    inherited tlbDataSet: TToolBar
      Width = 670
      ExplicitWidth = 670
    end
    inherited grdMaster: TDBGrid
      Top = 89
      Width = 670
      Height = 210
    end
    inherited pnlSearchControlArea: TPanel
      Width = 670
      Height = 63
      ExplicitWidth = 670
      ExplicitHeight = 63
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
  inline DTFTitleFrame1: TDTFTitleFrame
    Left = 0
    Top = 0
    Width = 686
    Height = 20
    Margins.Left = 8
    Align = alTop
    Color = clBtnFace
    ParentBackground = False
    ParentColor = False
    TabOrder = 1
    ExplicitWidth = 686
    inherited pnlCaption: TPanel
      Width = 686
      Caption = #47700#45684' '#51312#54924
      ExplicitWidth = 686
      ExplicitHeight = 20
    end
  end
  object pnlSearchPanel: TPanel
    Left = 8
    Top = 52
    Width = 476
    Height = 41
    BevelOuter = bvNone
    TabOrder = 2
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
    Left = 0
    Top = 319
    Width = 686
    Height = 109
    Align = alBottom
    TabOrder = 3
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
