inherited DTFDBGridFrame: TDTFDBGridFrame
  Height = 225
  Padding.Left = 8
  Padding.Top = 4
  Padding.Right = 8
  ExplicitHeight = 225
  inherited tlbDataSet: TToolBar
    Left = 8
    Top = 24
    Width = 578
    ExplicitLeft = 8
    ExplicitTop = 4
    ExplicitWidth = 578
    inherited btnDSRefresh: TToolButton
      ExplicitWidth = 85
    end
    inherited btnDSNew: TToolButton
      ExplicitWidth = 85
    end
    inherited btnDSSave: TToolButton
      ExplicitWidth = 85
    end
    inherited btnDSCancel: TToolButton
      ExplicitWidth = 85
    end
    inherited btnDSDelete: TToolButton
      ExplicitWidth = 85
    end
    inherited btnExportXls: TToolButton
      ExplicitWidth = 85
    end
    inherited ToolButton2: TToolButton
      ExplicitWidth = 85
    end
  end
  object grdMaster: TDBGrid [1]
    Left = 8
    Top = 69
    Width = 578
    Height = 156
    TabStop = False
    Align = alClient
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pnlSearchControlArea: TPanel [2]
    Left = 8
    Top = 46
    Width = 578
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Search controls. (default hidden)'
    TabOrder = 2
    Visible = False
    ExplicitTop = 26
    ExplicitWidth = 506
  end
  inherited DTFTitleFrame1: TDTFTitleFrame
    Left = 8
    Top = 4
    Width = 578
    ExplicitWidth = 594
    inherited pnlCaption: TPanel
      ExplicitWidth = 594
    end
  end
end
