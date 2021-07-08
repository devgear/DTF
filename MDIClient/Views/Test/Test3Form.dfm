inherited frmTest3: TfrmTest3
  Caption = 'StrGrid '#53580#49828#53944'2'
  ClientHeight = 505
  ClientWidth = 766
  OnCreate = FormCreate
  ExplicitWidth = 782
  ExplicitHeight = 544
  PixelsPerInch = 96
  TextHeight = 13
  inline DTFStrGridFrame1: TDTFStrGridFrame
    Left = 0
    Top = 0
    Width = 766
    Height = 505
    Align = alClient
    TabOrder = 0
    ExplicitTop = 20
    ExplicitWidth = 766
    ExplicitHeight = 485
    inherited tlbDataSet: TToolBar
      Width = 766
      ExplicitLeft = 0
      ExplicitTop = 20
      ExplicitWidth = 766
    end
    inherited pnlSearchControlArea: TPanel
      Width = 766
      Height = 47
      ExplicitTop = 42
      ExplicitWidth = 766
      ExplicitHeight = 47
    end
    inherited Grid: TStringGrid
      Top = 89
      Width = 766
      Height = 416
      ExplicitTop = 89
      ExplicitWidth = 766
      ExplicitHeight = 396
    end
    inherited DTFTitleFrame1: TDTFTitleFrame
      Width = 766
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 766
      inherited pnlCaption: TPanel
        Width = 766
        ExplicitWidth = 766
      end
    end
    inherited ActionList: TActionList
      inherited actSearch: TAction
        OnExecute = DTFStrGridFrame1actSearchExecute
      end
    end
  end
  object pnlSearchPanel: TPanel
    Left = 8
    Top = 48
    Width = 476
    Height = 41
    BevelOuter = bvNone
    TabOrder = 1
    object edtKeyword: TSearchBox
      Left = 7
      Top = 8
      Width = 146
      Height = 21
      TabOrder = 0
      TextHint = #47928#51088#50676
    end
  end
  object qryTestData: TFDQuery
    Connection = dmDatabase.FDConnection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'MENU_SEQ_GEN'
    SQL.Strings = (
      'SELECT * FROM test_data'
      'WHERE str_data LIKE :str')
    Left = 162
    Top = 88
    ParamData = <
      item
        Name = 'STR'
        DataType = ftWideString
        ParamType = ptInput
        Size = 1020
      end>
    object qryTestDataTEST_SEQ: TIntegerField
      FieldName = 'TEST_SEQ'
      Origin = 'TEST_SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryTestDataINT_DATA: TIntegerField
      FieldName = 'INT_DATA'
      Origin = 'INT_DATA'
    end
    object qryTestDataINT_DATA2: TIntegerField
      FieldName = 'INT_DATA2'
      Origin = 'INT_DATA2'
    end
    object qryTestDataSTR_DATA: TWideStringField
      FieldName = 'STR_DATA'
      Origin = 'STR_DATA'
      Size = 1020
    end
    object qryTestDataDBL_DATA: TSingleField
      FieldName = 'DBL_DATA'
      Origin = 'DBL_DATA'
    end
    object qryTestDataDTM_DATA: TSQLTimeStampField
      FieldName = 'DTM_DATA'
      Origin = 'DTM_DATA'
    end
  end
end
