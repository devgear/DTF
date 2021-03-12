object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 469
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
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 32
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
    OnExit = Edit1Exit
  end
  object Edit2: TEdit
    Left = 504
    Top = 32
    Width = 121
    Height = 21
    PopupMenu = PopupMenu1
    TabOrder = 1
    Text = 'Edit2'
    OnKeyUp = Edit2KeyUp
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
  object CalendarPicker1: TCalendarPicker
    Left = 159
    Top = 21
    Height = 32
    CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
    CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
    CalendarHeaderInfo.DaysOfWeekFont.Height = -13
    CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
    CalendarHeaderInfo.DaysOfWeekFont.Style = []
    CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
    CalendarHeaderInfo.Font.Color = clWindowText
    CalendarHeaderInfo.Font.Height = -20
    CalendarHeaderInfo.Font.Name = 'Segoe UI'
    CalendarHeaderInfo.Font.Style = []
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TextHint = 'select a date'
  end
  object ComboBox1: TComboBox
    Left = 456
    Top = 272
    Width = 145
    Height = 21
    TabOrder = 4
    Text = 'ComboBox1'
    Items.Strings = (
      'asfd'
      'asfd'
      'sfad'
      'asfsaf'
      'sfa'
      'asf')
  end
  object RzColorEdit1: TRzColorEdit
    Left = 80
    Top = 328
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object RzMaskEdit1: TRzMaskEdit
    Left = 80
    Top = 368
    Width = 121
    Height = 21
    TabOrder = 6
    Text = ''
  end
  object RzDBDateTimeEdit1: TRzDBDateTimeEdit
    Left = 216
    Top = 328
    Width = 121
    Height = 21
    TabOrder = 7
    EditType = etDate
  end
  object RzComboBox1: TRzComboBox
    Left = 343
    Top = 328
    Width = 145
    Height = 21
    TabOrder = 8
    Items.Strings = (
      '1111111111111111111'
      '2111111111111111111'
      '3111111111111111111'
      '4111111111111111111')
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
  object PopupMenu1: TPopupMenu
    Left = 320
    Top = 240
    object test1: TMenuItem
      Caption = 'test'
    end
    object tst21: TMenuItem
      Caption = 'tst2'
    end
  end
end
