object dmLogin: TdmLogin
  OldCreateOrder = False
  Height = 432
  Width = 597
  object qryLogin: TFDQuery
    Connection = dmDatabase.FDConnection
    SQL.Strings = (
      'SELECT * FROM users'
      'WHERE USER_ID = :USER_ID')
    Left = 120
    Top = 64
    ParamData = <
      item
        Name = 'USER_ID'
        ParamType = ptInput
      end>
  end
end
