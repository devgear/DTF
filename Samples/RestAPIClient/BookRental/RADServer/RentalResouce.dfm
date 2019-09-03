object RentalsResource: TRentalsResource
  OldCreateOrder = False
  Height = 379
  Width = 553
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
  object qryRentalList: TFDQuery
    Active = True
    Connection = conBookRental
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'RENT_SEQ_GEN'
    UpdateOptions.AutoIncFields = 'RENT_SEQ'
    SQL.Strings = (
      'SELECT BOOK.BOOK_TITLE, USERS.USER_NAME, RENT.* '
      'FROM RENT, BOOK, USERS'
      'WHERE'
      '  RENT.BOOK_SEQ = BOOK.BOOK_SEQ AND'
      '  RENT.USER_SEQ = USERS.USER_SEQ')
    Left = 40
    Top = 96
    object qryRentalListBOOK_TITLE: TWideStringField
      FieldName = 'BOOK_TITLE'
      Origin = 'BOOK_TITLE'
      Size = 400
    end
    object qryRentalListUSER_NAME: TWideStringField
      FieldName = 'USER_NAME'
      Origin = 'USER_NAME'
      Size = 120
    end
    object qryRentalListRENT_SEQ: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'RENT_SEQ'
      Origin = 'RENT_SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryRentalListUSER_SEQ: TIntegerField
      FieldName = 'USER_SEQ'
      Origin = 'USER_SEQ'
      Required = True
    end
    object qryRentalListBOOK_SEQ: TIntegerField
      FieldName = 'BOOK_SEQ'
      Origin = 'BOOK_SEQ'
      Required = True
    end
    object qryRentalListRENT_DATE: TDateField
      FieldName = 'RENT_DATE'
      Origin = 'RENT_DATE'
    end
    object qryRentalListRENT_RETURN_DATE: TDateField
      FieldName = 'RENT_RETURN_DATE'
      Origin = 'RENT_RETURN_DATE'
    end
    object qryRentalListRENT_RETURN_YN: TStringField
      FieldName = 'RENT_RETURN_YN'
      Origin = 'RENT_RETURN_YN'
      FixedChar = True
      Size = 1
    end
  end
  object dsrRentalList: TEMSDataSetResource
    AllowedActions = [List]
    DataSet = qryRentalList
    KeyFields = 'RENT_SEQ'
    Left = 40
    Top = 176
  end
end
