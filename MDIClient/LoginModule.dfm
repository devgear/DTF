object dmLogin: TdmLogin
  OldCreateOrder = False
  Height = 432
  Width = 597
  object qryLogin: TFDQuery
    Connection = dmDatabase.FDConnection
    SQL.Strings = (
      
        'SELECT USER_SEQ, USER_NAME, USER_ENC_PWD, LAST_PWD_UPDATED_AT FR' +
        'OM users'
      'WHERE USER_ID = :USER_ID')
    Left = 120
    Top = 64
    ParamData = <
      item
        Name = 'USER_ID'
        DataType = ftWideString
        ParamType = ptInput
        Size = 256
        Value = Null
      end>
    object qryLoginUSER_SEQ: TIntegerField
      FieldName = 'USER_SEQ'
      Origin = 'USER_SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryLoginUSER_NAME: TWideStringField
      FieldName = 'USER_NAME'
      Origin = 'USER_NAME'
      Required = True
      Size = 256
    end
    object qryLoginUSER_ID: TWideStringField
      FieldName = 'USER_ID'
      Origin = 'USER_ID'
      Required = True
      Size = 256
    end
    object qryLoginUSER_ENC_PWD: TWideStringField
      FieldName = 'USER_ENC_PWD'
      Origin = 'USER_ENC_PWD'
      Required = True
      Size = 256
    end
    object qryLoginPHONE_NO: TWideStringField
      FieldName = 'PHONE_NO'
      Origin = 'PHONE_NO'
      Size = 128
    end
    object qryLoginEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 1024
    end
    object qryLoginPOSTCODE: TWideStringField
      FieldName = 'POSTCODE'
      Origin = 'POSTCODE'
      Size = 48
    end
    object qryLoginADDRESS: TWideStringField
      FieldName = 'ADDRESS'
      Origin = 'ADDRESS'
      Size = 1024
    end
    object qryLoginLAST_PWD_UPDATED_AT: TSQLTimeStampField
      FieldName = 'LAST_PWD_UPDATED_AT'
      Origin = 'LAST_PWD_UPDATED_AT'
    end
    object qryLoginCREATED_AT: TSQLTimeStampField
      FieldName = 'CREATED_AT'
      Origin = 'CREATED_AT'
    end
    object qryLoginCREATED_USER: TIntegerField
      FieldName = 'CREATED_USER'
      Origin = 'CREATED_USER'
    end
    object qryLoginUPDATED_AT: TSQLTimeStampField
      FieldName = 'UPDATED_AT'
      Origin = 'UPDATED_AT'
    end
    object qryLoginUPDATED_USER: TIntegerField
      FieldName = 'UPDATED_USER'
      Origin = 'UPDATED_USER'
    end
  end
end
