inherited frmTest4: TfrmTest4
  BorderWidth = 1
  Caption = 'frmTest4'
  ClientHeight = 485
  ClientWidth = 684
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inline DTFStrGridFrame1: TDTFStrGridFrame
    Left = 0
    Top = 0
    Width = 684
    Height = 485
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 684
    ExplicitHeight = 485
    inherited DTFTitleFrame1: TDTFTitleFrame
      Width = 684
      ExplicitWidth = 684
      inherited pnlCaption: TPanel
        Width = 680
        ExplicitWidth = 680
      end
    end
    inherited tlbDataSet: TToolBar
      Width = 684
      ExplicitWidth = 684
      inherited ToolButton2: TToolButton
        OnClick = nil
      end
    end
    inherited pnlSearchControlArea: TPanel
      Width = 684
      ExplicitWidth = 684
    end
    inherited Grid: TStringGrid
      Width = 684
      Height = 420
      ExplicitWidth = 684
      ExplicitHeight = 420
    end
    inherited ActionList: TActionList
      inherited actSearch: TAction
        OnExecute = DTFStrGridFrame1actSearchExecute
      end
      inherited actPrint: TAction
        Visible = True
      end
      inherited actExportXls: TAction
        Visible = True
      end
    end
  end
end
