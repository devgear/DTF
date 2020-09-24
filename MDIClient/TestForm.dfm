inherited frmTest: TfrmTest
  Caption = 'Test Form'
  PixelsPerInch = 96
  TextHeight = 13
  inherited tlbDataSet: TToolBar
    inherited ToolButton11: TToolButton
      ExplicitWidth = 75
    end
    inherited ToolButton1: TToolButton
      ExplicitWidth = 53
    end
    inherited ToolButton2: TToolButton
      ExplicitWidth = 75
    end
    inherited ToolButton3: TToolButton
      ExplicitWidth = 53
    end
    inherited ToolButton5: TToolButton
      ExplicitWidth = 53
    end
    inherited ToolButton6: TToolButton
      ExplicitWidth = 75
    end
  end
  inherited pnlMain: TPanel
    object CalendarPicker1: TCalendarPicker
      Left = 8
      Top = 37
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
      TabOrder = 0
      TextHint = 'select a date'
    end
  end
end
