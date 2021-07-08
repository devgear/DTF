inherited DTFStrGridFrame: TDTFStrGridFrame
  Width = 724
  ExplicitWidth = 724
  object tlbDataSet: TToolBar
    Left = 0
    Top = 20
    Width = 724
    Height = 22
    AutoSize = True
    ButtonWidth = 85
    Images = dmResource.vilToolButton
    List = True
    ShowCaptions = True
    TabOrder = 0
    ExplicitLeft = -3
    ExplicitTop = 37
    object btnDSRefresh: TToolButton
      Left = 0
      Top = 0
      Action = actSearch
      AutoSize = True
    end
    object btnExportXls: TToolButton
      Left = 53
      Top = 0
      Action = actExportXls
      AutoSize = True
    end
    object ToolButton2: TToolButton
      Left = 142
      Top = 0
      Action = actPrint
      AutoSize = True
    end
  end
  object pnlSearchControlArea: TPanel
    Left = 0
    Top = 42
    Width = 724
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Search controls. (default hidden)'
    TabOrder = 1
    Visible = False
    ExplicitTop = 22
  end
  object Grid: TStringGrid
    Left = 0
    Top = 65
    Width = 724
    Height = 323
    Align = alClient
    TabOrder = 2
    ExplicitTop = 45
    ExplicitHeight = 343
  end
  inline DTFTitleFrame1: TDTFTitleFrame
    Left = 0
    Top = 0
    Width = 724
    Height = 20
    Margins.Left = 8
    Align = alTop
    Color = clBtnFace
    ParentBackground = False
    ParentColor = False
    TabOrder = 3
    ExplicitLeft = 8
    ExplicitTop = 8
    inherited pnlCaption: TPanel
      Width = 724
    end
  end
  object ActionList: TActionList
    Images = dmResource.vilToolButton
    Left = 24
    Top = 64
    object actSearch: TAction
      Category = 'Dataset'
      Caption = #51312#54924
      ImageIndex = 6
      ImageName = 'icons8-search'
    end
    object actPrint: TAction
      Category = 'Dataset'
      Caption = #51064#49604
      ImageIndex = 2
      ImageName = 'icons8-print'
      Visible = False
    end
    object actExportXls: TAction
      Category = 'Dataset'
      Caption = #50641#49472#47196' '#51200#51109
      ImageIndex = 7
      ImageName = 'icons8-xls'
      Visible = False
    end
  end
end
