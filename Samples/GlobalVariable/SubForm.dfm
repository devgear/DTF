object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 296
  ClientWidth = 423
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 95
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Set'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 176
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Get'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 95
    Top = 104
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 95
    Top = 77
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
end
