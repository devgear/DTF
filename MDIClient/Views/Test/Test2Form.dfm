inherited frmTest2: TfrmTest2
  Caption = 'StrGrid '#53580#49828#53944
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inline DTFStrGridFrame1: TDTFStrGridFrame
    Left = 0
    Top = 0
    Width = 686
    Height = 487
    Align = alClient
    TabOrder = 0
    ExplicitTop = 20
    ExplicitWidth = 686
    ExplicitHeight = 467
    inherited tlbDataSet: TToolBar
      Width = 686
      ExplicitLeft = 0
      ExplicitTop = 20
      ExplicitWidth = 686
    end
    inherited pnlSearchControlArea: TPanel
      Width = 686
      Height = 51
      ExplicitTop = 42
      ExplicitWidth = 686
      ExplicitHeight = 51
    end
    inherited Grid: TStringGrid
      Top = 93
      Width = 686
      Height = 394
      ExplicitTop = 93
      ExplicitWidth = 686
      ExplicitHeight = 374
    end
    inherited DTFTitleFrame1: TDTFTitleFrame
      Width = 686
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 686
      inherited pnlCaption: TPanel
        Width = 686
        ExplicitWidth = 686
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
    Left = 290
    Top = 264
    ParamData = <
      item
        Name = 'STR'
        ParamType = ptInput
      end>
  end
end
