inherited frmTest3: TfrmTest3
  Caption = 'StrGrid '#53580#49828#53944'2'
  ClientHeight = 505
  ClientWidth = 766
  ExplicitWidth = 782
  ExplicitHeight = 544
  PixelsPerInch = 96
  TextHeight = 13
  inline DTFTitleFrame1: TDTFTitleFrame
    Left = 0
    Top = 0
    Width = 766
    Height = 20
    Margins.Left = 8
    Align = alTop
    Color = clBtnFace
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    inherited pnlCaption: TPanel
      Width = 766
      ExplicitHeight = 20
    end
  end
  inline DTFStrGridFrame1: TDTFStrGridFrame
    Left = 0
    Top = 20
    Width = 766
    Height = 485
    Align = alClient
    TabOrder = 1
    ExplicitLeft = -38
    inherited tlbDataSet: TToolBar
      Width = 766
      inherited btnDSRefresh: TToolButton
        ExplicitWidth = 53
      end
      inherited btnExportXls: TToolButton
        ExplicitWidth = 89
      end
      inherited ToolButton2: TToolButton
        ExplicitWidth = 53
      end
    end
    inherited pnlSearchControlArea: TPanel
      Width = 766
    end
    inherited Grid: TStringGrid
      Width = 766
      Height = 440
    end
    inherited ActionList: TActionList
      inherited actSearch: TAction
        OnExecute = DTFStrGridFrame1actSearchExecute
      end
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
