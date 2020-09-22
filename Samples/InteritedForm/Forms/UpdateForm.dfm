inherited frmUpdate: TfrmUpdate
  Caption = 'Form3'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited pnlMain: TPanel
      object DBGrid1: TDBGrid
        Left = 16
        Top = 16
        Width = 649
        Height = 281
        DataSource = dsMain
        Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object Edit1: TEdit
        Left = 16
        Top = 312
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'Edit1'
      end
    end
  end
  inherited dsMain: TDataSource
    DataSet = FDQuery1
  end
  object FDQuery1: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM BOOK')
    Left = 112
    Top = 304
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Projects\BookRental\DB\BOOKRENTAL.IB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=IB')
    Connected = True
    Left = 112
    Top = 248
  end
end
