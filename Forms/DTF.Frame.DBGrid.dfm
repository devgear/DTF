inherited fmeDTFDBGrid: TfmeDTFDBGrid
  Height = 225
  ExplicitHeight = 225
  inherited tlbDataSet: TToolBar
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
    Left = 0
    Top = 22
    Width = 433
    Height = 203
    TabStop = False
    Align = alClient
    DataSource = dsDataSet
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end
