object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 290
  ClientWidth = 649
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 32
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 504
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Memo1: TMemo
    Left = 32
    Top = 72
    Width = 433
    Height = 169
    Lines.Strings = (
      #51068#48152' '#54268#51008' '#51221#49345
      'MDIForm'#51032' '#44221#50864' '#45796#47480' '#52968#53944#47204#51060' '#51060#48292#53944#47484' '#44032#51256#44048)
    TabOrder = 2
  end
  object qryMenuShortcut: TFDQuery
    Active = True
    Connection = FDConnection
    SQL.Strings = (
      'SELECT'
      '  menu_code, menu_name, cate_name||'#39'>'#39'||group_name as CATE'
      'FROM'
      '  menu_categories cate, '
      '  menu_groups grp, '
      '  menu_items item'
      'WHERE'
      '  cate.cate_code = grp.cate_code AND'
      '  grp.group_code = item.group_code')
    Left = 72
    Top = 160
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=D:\Projects\DTF\DB\DTFDB.IB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    Left = 112
    Top = 80
  end
end
