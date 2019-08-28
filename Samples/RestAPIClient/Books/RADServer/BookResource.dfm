object BooksResource1: TBooksResource1
  OldCreateOrder = False
  Height = 260
  Width = 507
  object conBookRental: TFDConnection
    Params.Strings = (
      
        'Database=D:\Projects\DTF\Samples\RestAPIClient\Books\DB\BOOKRENT' +
        'AL.IB'
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
    Left = 40
    Top = 96
  end
end
