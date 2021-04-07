object dmDatabase: TdmDatabase
  OldCreateOrder = False
  Height = 475
  Width = 656
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=D:\Projects\DTF\DB\DTFDB.IB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=IB')
    LoginPrompt = False
    Left = 112
    Top = 80
  end
end
