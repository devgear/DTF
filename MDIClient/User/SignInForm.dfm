inherited frmSignIn: TfrmSignIn
  Caption = #47196#44536#51064
  ClientHeight = 222
  ClientWidth = 361
  OnShow = FormShow
  ExplicitWidth = 377
  ExplicitHeight = 261
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 41
    Width = 361
    Height = 140
    Align = alClient
    TabOrder = 0
    ExplicitLeft = -8
    ExplicitTop = 35
    ExplicitWidth = 447
    ExplicitHeight = 226
    DesignSize = (
      361
      140)
    object Label2: TLabel
      Left = 50
      Top = 29
      Width = 33
      Height = 13
      Caption = #50500#51060#46356
    end
    object Label3: TLabel
      Left = 50
      Top = 72
      Width = 44
      Height = 13
      Caption = #48708#48128#48264#54840
    end
    object edtUserId: TEdit
      Left = 115
      Top = 26
      Width = 196
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      TextHint = #50500#51060#46356
      ExplicitWidth = 282
    end
    object edtPassword: TEdit
      Left = 115
      Top = 69
      Width = 196
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      PasswordChar = '*'
      TabOrder = 1
      TextHint = #48708#48128#48264#54840
      ExplicitWidth = 282
    end
    object chkUserIdSave: TCheckBox
      Left = 115
      Top = 96
      Width = 97
      Height = 17
      Caption = #50500#51060#46356' '#51200#51109
      TabOrder = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 361
    Height = 41
    Align = alTop
    Caption = #47196#44536#51064
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = 136
    ExplicitTop = 152
    ExplicitWidth = 185
  end
  object Panel2: TPanel
    Left = 0
    Top = 181
    Width = 361
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 185
    DesignSize = (
      361
      41)
    object btnLogin: TButton
      Left = 137
      Top = 6
      Width = 130
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #47196#44536#51064
      TabOrder = 0
      OnClick = btnLoginClick
      ExplicitLeft = 223
    end
    object btnCancel: TButton
      Left = 273
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #52712#49548
      TabOrder = 1
      OnClick = btnCancelClick
      ExplicitLeft = 359
    end
  end
end
