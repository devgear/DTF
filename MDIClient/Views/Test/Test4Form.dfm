inherited frmTest4: TfrmTest4
  BorderWidth = 1
  Caption = 'frmTest4'
  ClientHeight = 485
  ClientWidth = 684
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inline DTFStrGridFrame1: TDTFStrGridFrame
    Left = 2
    Top = 4
    Width = 680
    Height = 479
    Align = alClient
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    TabOrder = 0
    ExplicitLeft = 2
    ExplicitTop = 4
    ExplicitWidth = 680
    ExplicitHeight = 479
    inherited DTFTitleFrame1: TDTFTitleFrame
      Width = 676
      ExplicitWidth = 684
      inherited pnlCaption: TPanel
        Width = 680
        ExplicitWidth = 680
      end
    end
    inherited tlbDataSet: TToolBar
      Width = 676
      ExplicitWidth = 684
    end
    inherited pnlSearchControlArea: TPanel
      Width = 676
      ExplicitWidth = 684
    end
    inherited Grid: TStringGrid
      Width = 676
      Height = 410
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
