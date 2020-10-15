inherited DTFDBGridFrame: TDTFDBGridFrame
  Height = 225
  Padding.Left = 8
  Padding.Top = 4
  Padding.Right = 8
  ExplicitHeight = 225
  inherited tlbDataSet: TToolBar
    Left = 8
    Top = 4
    Width = 417
    ExplicitLeft = 8
    ExplicitTop = 4
    ExplicitWidth = 417
    inherited ToolButton11: TToolButton
      ExplicitWidth = 75
    end
    inherited ToolButton1: TToolButton
      ExplicitWidth = 53
    end
    inherited ToolButton2: TToolButton
      ExplicitWidth = 75
    end
    inherited ToolButton3: TToolButton
      ExplicitWidth = 53
    end
  end
  object grdMaster: TDBGrid [1]
    Left = 8
    Top = 26
    Width = 417
    Height = 199
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
  inherited ActionList: TActionList
    inherited actDSRefresh: TDataSetRefresh
      DataSource = DataSource
    end
  end
end
