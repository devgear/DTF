object dmDataAccess: TdmDataAccess
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 334
  Width = 518
  object memBookList: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 64
    Top = 112
  end
  object memBookDetail: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 160
    Top = 112
    object memBookDetailBOOK_SEQ: TWideStringField
      FieldName = 'BOOK_SEQ'
      Size = 255
    end
    object memBookDetailBOOK_TITLE: TWideStringField
      FieldName = 'BOOK_TITLE'
      Size = 255
    end
    object memBookDetailBOOK_ISBN: TWideStringField
      FieldName = 'BOOK_ISBN'
      Size = 255
    end
    object memBookDetailBOOK_AUTHOR: TWideStringField
      FieldName = 'BOOK_AUTHOR'
      Size = 255
    end
    object memBookDetailBOOK_PRICE: TIntegerField
      FieldName = 'BOOK_PRICE'
      DisplayFormat = '#,#'
    end
    object memBookDetailBOOK_LINK: TWideStringField
      FieldName = 'BOOK_LINK'
      Size = 255
    end
    object memBookDetailBOOK_DESCRIPTION: TWideStringField
      FieldName = 'BOOK_DESCRIPTION'
      Size = 255
    end
  end
  object dsBookList: TDataSource
    DataSet = memBookList
    OnDataChange = dsBookListDataChange
    Left = 64
    Top = 48
  end
end
