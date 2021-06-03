inherited frmTest2: TfrmTest2
  Caption = 'StrGrid '#53580#49828#53944
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
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
    TabOrder = 0
    ExplicitWidth = 686
    inherited pnlCaption: TPanel
      Width = 686
      Caption = 'StrGridFrame '#53580#49828#53944
      ExplicitWidth = 686
      ExplicitHeight = 20
    end
  end
  inline DTFStrGridFrame1: TDTFStrGridFrame
    Left = 0
    Top = 20
    Width = 686
    Height = 467
    Align = alClient
    TabOrder = 1
    ExplicitTop = 20
    ExplicitWidth = 686
    ExplicitHeight = 467
    inherited tlbDataSet: TToolBar
      Width = 686
      ExplicitWidth = 686
    end
    inherited pnlSearchControlArea: TPanel
      Width = 686
      Height = 51
      ExplicitWidth = 686
      ExplicitHeight = 51
    end
    inherited Grid: TStringGrid
      Top = 73
      Width = 686
      Height = 394
      ExplicitTop = 73
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
    TabOrder = 2
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
