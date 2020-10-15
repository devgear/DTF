inherited DTFDataSetFrame: TDTFDataSetFrame
  object tlbDataSet: TToolBar
    Left = 0
    Top = 0
    Width = 433
    Height = 22
    AutoSize = True
    ButtonWidth = 71
    Images = dmResource.vilToolButton
    List = True
    ShowCaptions = True
    TabOrder = 0
    object ToolButton4: TToolButton
      Left = 0
      Top = 0
      Action = actDSRefresh
    end
    object ToolButton11: TToolButton
      Left = 71
      Top = 0
      Action = actDSNewAppend
      AutoSize = True
    end
    object ToolButton1: TToolButton
      Left = 146
      Top = 0
      Action = actDSSavePost
      AutoSize = True
    end
    object ToolButton2: TToolButton
      Left = 199
      Top = 0
      Action = actDSCancel
      AutoSize = True
    end
    object ToolButton3: TToolButton
      Left = 274
      Top = 0
      Action = actDSDelete
      AutoSize = True
    end
  end
  object ActionList: TActionList
    Images = dmResource.vilToolButton
    Left = 24
    Top = 64
    object actDSRefresh: TDataSetRefresh
      Category = 'Dataset'
      Caption = #49352#47196#44256#52840
      Hint = #49352#47196#44256#52840
      ImageIndex = 6
      ImageName = 'icons8-refresh'
      ShortCut = 116
    end
    object actDSNewAppend: TDataSetInsert
      Category = 'Dataset'
      Caption = #49352#47196#52628#44032
      Hint = #52628#44032
      ImageIndex = 0
      ImageName = 'icons8'
      ShortCut = 16429
      OnExecute = actDSNewAppendExecute
      DataSource = DataSource
    end
    object actDSSavePost: TDataSetPost
      Category = 'Dataset'
      Caption = #51200#51109
      Hint = 'Post'
      ImageIndex = 3
      ImageName = 'icons8-save'
      ShortCut = 4179
      DataSource = DataSource
    end
    object actDSDelete: TDataSetDelete
      Category = 'Dataset'
      Caption = #49325#51228
      Hint = 'Delete'
      ImageIndex = 4
      ImageName = 'icons8-trash'
      ShortCut = 16430
      OnExecute = actDSDeleteExecute
      DataSource = DataSource
    end
    object actDSCancel: TDataSetCancel
      Category = 'Dataset'
      Caption = #51077#47141#52712#49548
      Hint = 'Cancel'
      ImageIndex = 1
      ImageName = 'icons8-delete_sign'
      DataSource = DataSource
    end
  end
  object DataSource: TDataSource
    Left = 112
    Top = 64
  end
end
