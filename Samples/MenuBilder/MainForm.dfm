object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 459
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 296
    Top = 232
    object Createsubform1: TMenuItem
      Caption = 'Create sub form'
      OnClick = Createsubform1Click
    end
    object Createsub2form1: TMenuItem
      Caption = 'Create sub2 form'
      OnClick = Createsub2form1Click
    end
  end
end
