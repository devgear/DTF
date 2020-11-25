object dmUser: TdmUser
  OldCreateOrder = False
  Height = 298
  Width = 477
  object qrySignin: TFDQuery
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
    object qrySigninUSER_SEQ: TIntegerField
      FieldName = 'USER_SEQ'
      Origin = 'USER_SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrySigninUSER_NAME: TWideStringField
      FieldName = 'USER_NAME'
      Origin = 'USER_NAME'
      Required = True
      Size = 256
    end
    object qrySigninUSER_ID: TWideStringField
      FieldName = 'USER_ID'
      Origin = 'USER_ID'
      Required = True
      Size = 256
    end
    object qrySigninUSER_ENC_PWD: TWideStringField
      FieldName = 'USER_ENC_PWD'
      Origin = 'USER_ENC_PWD'
      Required = True
      Size = 256
    end
    object qrySigninPHONE_NO: TWideStringField
      FieldName = 'PHONE_NO'
      Origin = 'PHONE_NO'
      Size = 128
    end
    object qrySigninEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 1024
    end
    object qrySigninPOSTCODE: TWideStringField
      FieldName = 'POSTCODE'
      Origin = 'POSTCODE'
      Size = 48
    end
    object qrySigninADDRESS: TWideStringField
      FieldName = 'ADDRESS'
      Origin = 'ADDRESS'
      Size = 1024
    end
    object qrySigninLAST_PWD_UPDATED_AT: TSQLTimeStampField
      FieldName = 'LAST_PWD_UPDATED_AT'
      Origin = 'LAST_PWD_UPDATED_AT'
    end
    object qrySigninCREATED_AT: TSQLTimeStampField
      FieldName = 'CREATED_AT'
      Origin = 'CREATED_AT'
    end
    object qrySigninCREATED_USER: TIntegerField
      FieldName = 'CREATED_USER'
      Origin = 'CREATED_USER'
    end
    object qrySigninUPDATED_AT: TSQLTimeStampField
      FieldName = 'UPDATED_AT'
      Origin = 'UPDATED_AT'
    end
    object qrySigninUPDATED_USER: TIntegerField
      FieldName = 'UPDATED_USER'
      Origin = 'UPDATED_USER'
    end
  end
end
