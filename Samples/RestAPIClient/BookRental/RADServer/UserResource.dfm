object UsersResource: TUsersResource
  OldCreateOrder = False
  Height = 374
  Width = 457
  object conBookRental: TFDConnection
    Params.Strings = (
      
        'Database=D:\Projects\DTF\Samples\RestAPIClient\BookRental\DB\BOO' +
        'KRENTAL.IB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object qryUserList: TFDQuery
    Active = True
    Connection = conBookRental
    SQL.Strings = (
      'SELECT '
      '  USER_SEQ, USER_NAME, USER_BIRTH, USER_PHONE, USER_REG_DATE, '
      '  USER_OUT_YN, USER_RENT_COUNT '
      'FROM '
      '  USERS')
    Left = 40
    Top = 96
  end
  object dsrUserList: TEMSDataSetResource
    AllowedActions = [List]
    DataSet = qryUserList
    KeyFields = 'USER_SEQ'
    Left = 40
    Top = 176
  end
  object qryUser: TFDQuery
    Connection = conBookRental
    UpdateOptions.AutoIncFields = 'BOOK_SEQ'
    SQL.Strings = (
      'SELECT BOOK_SEQ, BOOK_TITLE, BOOK_AUTHOR, BOOK_PRICE FROM BOOK')
    Left = 296
    Top = 96
  end
  object qryUserItem: TFDQuery
    Connection = conBookRental
    UpdateOptions.AssignedValues = [uvRefreshMode, uvGeneratorName]
    UpdateOptions.GeneratorName = 'BOOK_SEQ_GEN'
    UpdateOptions.AutoIncFields = 'BOOK_SEQ'
    SQL.Strings = (
      'SELECT '
      '  USER_SEQ, USER_NAME, USER_BIRTH, USER_SEX, USER_PHONE,'
      
        '  USER_MAIL, USER_REG_DATE, USER_OUT_YN, USER_OUT_DATE, USER_REN' +
        'T_COUNT'
      'FROM USERS'
      'WHERE'
      '  USER_SEQ = :USER_SEQ')
    Left = 184
    Top = 96
    ParamData = <
      item
        Name = 'USER_SEQ'
        ParamType = ptInput
      end>
  end
  object dsrUserItem: TEMSDataSetResource
    AllowedActions = [Get, Post, Put, Delete]
    DataSet = qryUserItem
    KeyFields = 'USER_SEQ'
    MappingMode = rmEntityToFields
    Options = [roEnableParams, roEnablePaging, roEnableSorting, roReturnNewEntityKey, roReturnNewEntityValue, roAppendOnPut]
    Left = 184
    Top = 176
  end
end
