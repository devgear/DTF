inherited DTFDBGridFrame: TDTFDBGridFrame
  Height = 225
  Padding.Left = 8
  Padding.Top = 4
  Padding.Right = 8
  ExplicitHeight = 225
  inherited tlbDataSet: TToolBar
    Left = 8
    Top = 4
    Width = 578
    ExplicitLeft = 8
    ExplicitTop = 4
    ExplicitWidth = 578
  end
  object grdMaster: TDBGrid [1]
    Left = 8
    Top = 49
    Width = 578
    Height = 176
    TabStop = False
    Align = alClient
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pnlSearchControlArea: TPanel [2]
    Left = 8
    Top = 26
    Width = 578
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Search controls. (default hidden)'
    TabOrder = 2
    Visible = False
    ExplicitWidth = 506
  end
end
