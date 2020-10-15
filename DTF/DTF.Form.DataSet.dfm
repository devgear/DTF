inherited frmDTFDataSet: TfrmDTFDataSet
  Caption = 'DTF:: DataSet & Action Base form'
  PixelsPerInch = 96
  TextHeight = 13
  object tlbDataSet: TToolBar
    Left = 0
    Top = 0
    Width = 686
    Height = 22
    AutoSize = True
    ButtonWidth = 71
    Images = dmResource.vilToolButton
    List = True
    ShowCaptions = True
    TabOrder = 0
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
    object ToolButton4: TToolButton
      Left = 256
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 5
      ImageName = 'icons8-download'
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 264
      Top = 0
      Action = actPrint
      AutoSize = True
    end
    object ToolButton6: TToolButton
      Left = 317
      Top = 0
      Action = actDownload
      AutoSize = True
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 22
    Width = 686
    Height = 465
    Align = alClient
    TabOrder = 1
  end
  object dsDataSet: TDataSource
    Left = 128
    Top = 144
  end
  object aclDataSet: TActionList
    Images = dmResource.vilToolButton
    Left = 128
    Top = 72
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
    object actPrint: TAction
      Category = 'IO'
      Caption = #51064#49604
      ImageIndex = 2
      ImageName = 'icons8-print'
    end
    object actDownload: TAction
      Category = 'IO'
      Caption = #45796#50868#47196#46300
      ImageIndex = 5
      ImageName = 'icons8-download'
    end
  end
end
