object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Devgear Training Framework - MDI Client'
  ClientHeight = 501
  ClientWidth = 749
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TabSet1: TTabSet
    Left = 0
    Top = 480
    Width = 749
    Height = 21
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ExplicitLeft = 288
    ExplicitTop = 264
    ExplicitWidth = 185
  end
  object pnlMenu: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 480
    Align = alLeft
    TabOrder = 1
    ExplicitLeft = 288
    ExplicitTop = 248
    ExplicitHeight = 41
    object pnlMenuTop: TPanel
      Left = 1
      Top = 1
      Width = 183
      Height = 232
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object pnlShortCut: TPanel
        Left = 0
        Top = 0
        Width = 183
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitTop = 96
        ExplicitWidth = 185
        object edtShortCut: TEdit
          Left = 8
          Top = 11
          Width = 165
          Height = 21
          TabOrder = 0
        end
      end
      object lstFavorites: TListView
        Left = 0
        Top = 41
        Width = 183
        Height = 191
        Align = alClient
        Columns = <>
        TabOrder = 1
        ExplicitLeft = -32
        ExplicitTop = 40
        ExplicitWidth = 250
        ExplicitHeight = 150
      end
    end
    object trvMenus: TTreeView
      Left = 1
      Top = 233
      Width = 183
      Height = 246
      Align = alClient
      Indent = 19
      TabOrder = 1
      ExplicitLeft = 32
      ExplicitTop = 192
      ExplicitWidth = 121
      ExplicitHeight = 97
    end
  end
  object MainMenu: TMainMenu
    Left = 216
    Top = 72
  end
end
