object frmUserLogin: TfrmUserLogin
  Left = 0
  Top = 0
  Caption = #47196#44536#51064
  ClientHeight = 199
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 392
    Height = 41
    Align = alTop
    Caption = #47196#44536#51064
    TabOrder = 0
    ExplicitLeft = 192
    ExplicitTop = 80
    ExplicitWidth = 185
  end
  object pnlContent: TPanel
    Left = 0
    Top = 41
    Width = 392
    Height = 117
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 72
    ExplicitTop = 184
    ExplicitWidth = 185
    ExplicitHeight = 41
    DesignSize = (
      392
      117)
    object Label1: TLabel
      Left = 48
      Top = 35
      Width = 33
      Height = 13
      Caption = #50500#51060#46356
    end
    object Label2: TLabel
      Left = 37
      Top = 65
      Width = 44
      Height = 13
      Caption = #48708#48128#48264#54840
    end
    object edtId: TEdit
      Left = 104
      Top = 32
      Width = 241
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object edtPassword: TEdit
      Left = 104
      Top = 62
      Width = 241
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object chkSaveId: TCheckBox
      Left = 104
      Top = 89
      Width = 97
      Height = 17
      Caption = #50500#51060#46356' '#51200#51109
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 158
    Width = 392
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = 72
    ExplicitTop = 312
    ExplicitWidth = 185
    DesignSize = (
      392
      41)
    object btnLogin: TButton
      Left = 220
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #47196#44536#51064
      TabOrder = 0
      ExplicitLeft = 303
    end
    object btnCancel: TButton
      Left = 301
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #52712#49548
      TabOrder = 1
      ExplicitLeft = 384
    end
  end
end
