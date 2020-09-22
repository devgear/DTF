inherited fmeDTFDBGrid: TfmeDTFDBGrid
  Height = 225
  ExplicitHeight = 225
  inherited tlbDataSet: TToolBar
    ExplicitLeft = 0
    ExplicitWidth = 433
  end
  object DBGrid1: TDBGrid [1]
    Left = 0
    Top = 22
    Width = 433
    Height = 203
    Align = alClient
    DataSource = dsDataSet
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end
