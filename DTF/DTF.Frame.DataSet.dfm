inherited DTFDataSetFrame: TDTFDataSetFrame
  Width = 594
  ExplicitWidth = 594
  object tlbDataSet: TToolBar
    Left = 0
    Top = 20
    Width = 594
    Height = 22
    AutoSize = True
    ButtonWidth = 85
    Images = dmResource.vilToolButton
    List = True
    ShowCaptions = True
    TabOrder = 0
    ExplicitTop = 40
    object btnDSRefresh: TToolButton
      Left = 0
      Top = 0
      Action = actDSSearch
      AutoSize = True
    end
    object btnDSNew: TToolButton
      Left = 53
      Top = 0
      Action = actDSNewAppend
      AutoSize = True
    end
    object btnDSSave: TToolButton
      Left = 128
      Top = 0
      Action = actDSSavePost
      AutoSize = True
    end
    object btnDSCancel: TToolButton
      Left = 181
      Top = 0
      Action = actDSCancel
      AutoSize = True
    end
    object btnDSDelete: TToolButton
      Left = 256
      Top = 0
      Action = actDSDelete
      AutoSize = True
    end
    object btnExportXls: TToolButton
      Left = 309
      Top = 0
      Action = actDSExportXls
      AutoSize = True
    end
    object ToolButton2: TToolButton
      Left = 398
      Top = 0
      Action = actPrint
      AutoSize = True
    end
  end
  inline DTFTitleFrame1: TDTFTitleFrame
    Left = 0
    Top = 0
    Width = 594
    Height = 20
    Margins.Left = 8
    Align = alTop
    Color = clBtnFace
    ParentBackground = False
    ParentColor = False
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 8
    inherited pnlCaption: TPanel
      Width = 594
    end
  end
  object ActionList: TActionList
    Images = dmResource.vilToolButton
    Left = 24
    Top = 64
    object actDSSearch: TDataSetRefresh
      Category = 'Dataset'
      Caption = #51312#54924
      ImageIndex = 6
      ImageName = 'icons8-search'
      ShortCut = 116
      OnExecute = actDSSearchExecute
      DataSource = DataSource
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
    object actPrint: TAction
      Category = 'Dataset'
      Caption = #51064#49604
      ImageIndex = 2
      ImageName = 'icons8-print'
      Visible = False
      OnExecute = actPrintExecute
    end
    object actDSExportXls: TAction
      Category = 'Dataset'
      Caption = #50641#49472#47196' '#51200#51109
      ImageIndex = 7
      ImageName = 'icons8-xls'
      Visible = False
      OnExecute = actDSExportXlsExecute
      OnUpdate = actDSExportXlsUpdate
    end
  end
  object DataSource: TDataSource
    Left = 112
    Top = 64
  end
end
