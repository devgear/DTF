inherited frmTest2: TfrmTest2
  Caption = 'StrGrid '#53580#49828#53944
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inline DTFStrGridFrame1: TDTFStrGridFrame
    Left = 2
    Top = 4
    Width = 682
    Height = 481
    Align = alClient
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    TabOrder = 0
    ExplicitLeft = 2
    ExplicitTop = 4
    ExplicitWidth = 682
    ExplicitHeight = 481
    inherited DTFTitleFrame1: TDTFTitleFrame
      Width = 678
      ExplicitWidth = 686
      inherited pnlCaption: TPanel
        Width = 682
        ExplicitWidth = 682
      end
    end
    inherited tlbDataSet: TToolBar
      Width = 678
      ExplicitWidth = 686
    end
    inherited pnlSearchControlArea: TPanel
      Width = 678
      Height = 51
      ExplicitWidth = 686
      ExplicitHeight = 51
    end
    inherited Grid: TStringGrid
      Top = 95
      Width = 678
      Height = 384
      ExplicitTop = 93
      ExplicitWidth = 686
      ExplicitHeight = 394
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
