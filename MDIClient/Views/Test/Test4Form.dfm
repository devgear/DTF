inherited frmTest4: TfrmTest4
  Caption = 'frmTest4'
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
    inherited pnlCaption: TPanel
      Width = 686
    end
  end
  inline DTFStrGridFrame1: TDTFStrGridFrame
    Left = 0
    Top = 20
    Width = 686
    Height = 467
    Align = alClient
    TabOrder = 1
    ExplicitLeft = -38
    inherited tlbDataSet: TToolBar
      Width = 686
    end
    inherited pnlSearchControlArea: TPanel
      Width = 686
    end
    inherited Grid: TStringGrid
      Width = 686
      Height = 422
    end
    inherited ActionList: TActionList
      inherited actSearch: TAction
        OnExecute = DTFStrGridFrame1actSearchExecute
      end
    end
  end
end
