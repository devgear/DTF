object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 467
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TreeView1: TTreeView
    Left = 24
    Top = 24
    Width = 441
    Height = 377
    Indent = 19
    TabOrder = 0
    OnDragDrop = TreeView1DragDrop
    OnDragOver = TreeView1DragOver
  end
  object Button1: TButton
    Left = 480
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 471
    Top = 231
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
end
