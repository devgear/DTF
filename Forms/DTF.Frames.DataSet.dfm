inherited fmeDTFDataSet: TfmeDTFDataSet
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
    ExplicitLeft = -253
    ExplicitWidth = 686
    object ToolButton11: TToolButton
      Left = 0
      Top = 0
      Action = actDSNewInsert
      AutoSize = True
    end
    object ToolButton1: TToolButton
      Left = 75
      Top = 0
      Action = actDSSavePost
      AutoSize = True
    end
    object ToolButton2: TToolButton
      Left = 128
      Top = 0
      Action = actDSCancel
      AutoSize = True
    end
    object ToolButton3: TToolButton
      Left = 203
      Top = 0
      Action = actDSDelete
      AutoSize = True
    end
  end
  object aclDataSet: TActionList
    Images = dmResource.vilToolButton
    Left = 72
    Top = 56
    object actDSNewInsert: TDataSetInsert
      Category = 'Dataset'
      Caption = #49352#47196#52628#44032
      Hint = 'Insert'
      ImageIndex = 0
      ImageName = 'icons8'
      DataSource = dsDataSet
    end
    object actDSDelete: TDataSetDelete
      Category = 'Dataset'
      Caption = #49325#51228
      Hint = 'Delete'
      ImageIndex = 4
      ImageName = 'icons8-trash'
      DataSource = dsDataSet
    end
    object actDSSavePost: TDataSetPost
      Category = 'Dataset'
      Caption = #51200#51109
      Hint = 'Post'
      ImageIndex = 3
      ImageName = 'icons8-save'
      DataSource = dsDataSet
    end
    object actDSCancel: TDataSetCancel
      Category = 'Dataset'
      Caption = #51077#47141#52712#49548
      Hint = 'Cancel'
      ImageIndex = 1
      ImageName = 'icons8-delete_sign'
      DataSource = dsDataSet
    end
  end
  object dsDataSet: TDataSource
    Left = 72
    Top = 120
  end
end
