inherited DTFDBGridFrame: TDTFDBGridFrame
  Height = 225
  ExplicitHeight = 225
  inherited DTFTitleFrame1: TDTFTitleFrame
    ExplicitWidth = 594
    inherited pnlCaption: TPanel
      Width = 590
    end
  end
  object grdMaster: TDBGrid [1]
    Left = 0
    Top = 65
    Width = 594
    Height = 160
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
    Left = 0
    Top = 42
    Width = 594
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Search controls. (default hidden)'
    TabOrder = 2
    Visible = False
  end
end
