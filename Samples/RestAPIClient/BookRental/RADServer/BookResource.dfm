object BooksResource: TBooksResource
  OldCreateOrder = False
  Height = 260
  Width = 507
  object conBookRental: TFDConnection
    Params.Strings = (
      
        'Database=D:\Projects\DTF\Samples\RestAPIClient\BookRental\DB\BOO' +
        'KRENTAL.IB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=IB')
    LoginPrompt = False
    BeforeConnect = conBookRentalBeforeConnect
    Left = 40
    Top = 24
  end
  object qryBook: TFDQuery
    Connection = conBookRental
    UpdateOptions.AutoIncFields = 'BOOK_SEQ'
    SQL.Strings = (
      'SELECT BOOK_SEQ, BOOK_TITLE, BOOK_AUTHOR, BOOK_PRICE FROM BOOK')
    Left = 296
    Top = 96
  end
  object qryBookList: TFDQuery
    Connection = conBookRental
    SQL.Strings = (
      'SELECT BOOK_SEQ, BOOK_TITLE, BOOK_AUTHOR FROM BOOK'
      'WHERE BOOK_TITLE LIKE :TITLE')
    Left = 40
    Top = 96
    ParamData = <
      item
        Name = 'TITLE'
        DataType = ftWideString
        ParamType = ptInput
        Size = 400
        Value = Null
      end>
  end
  object dsrBookList: TEMSDataSetResource
    AllowedActions = [List]
    OnGetParam = dsrBookListGetParam
    DataSet = qryBookList
    KeyFields = 'BOOK_SEQ'
    Left = 40
    Top = 176
  end
  object qryBookItem: TFDQuery
    BeforeInsert = qryBookItemBeforeInsert
    Connection = conBookRental
    UpdateOptions.AssignedValues = [uvRefreshMode, uvGeneratorName]
    UpdateOptions.GeneratorName = 'BOOK_SEQ_GEN'
    UpdateOptions.AutoIncFields = 'BOOK_SEQ'
    SQL.Strings = (
      'SELECT '
      '  BOOK_SEQ, BOOK_TITLE, BOOK_ISBN, BOOK_AUTHOR, BOOK_PRICE, '
      '  BOOK_LINK, BOOK_RENT_YN, BOOK_DESCRIPTION'
      'FROM BOOK'
      'WHERE'
      '  BOOK_SEQ = :BOOK_SEQ')
    Left = 184
    Top = 96
    ParamData = <
      item
        Name = 'BOOK_SEQ'
        ParamType = ptInput
      end>
  end
  object dsrBookItem: TEMSDataSetResource
    AllowedActions = [Get, Post, Put, Delete]
    DataSet = qryBookItem
    KeyFields = 'BOOK_SEQ'
    MappingMode = rmEntityToFields
    Options = [roEnableParams, roEnablePaging, roEnableSorting, roReturnNewEntityKey, roReturnNewEntityValue, roAppendOnPut]
    Left = 184
    Top = 176
  end
end
