object Form3: TForm3
  Left = 281
  Top = 181
  Width = 457
  Height = 426
  Caption = #1054#1082#1085#1086' '#1095#1072#1090#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 295
    Top = 0
    Height = 254
  end
  object Panel1: TPanel
    Left = 0
    Top = 254
    Width = 449
    Height = 138
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      449
      138)
    object Label1: TLabel
      Left = 152
      Top = 112
      Width = 52
      Height = 13
      Caption = '10000 msc'
    end
    object Memo2: TMemo
      Left = 1
      Top = 1
      Width = 447
      Height = 104
      Align = alTop
      PopupMenu = PopupMenu2
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object Button1: TButton
      Left = 358
      Top = 104
      Width = 89
      Height = 33
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
      Enabled = False
      TabOrder = 1
      OnClick = Button1Click
    end
    object TrackBar1: TTrackBar
      Left = 8
      Top = 106
      Width = 137
      Height = 36
      Ctl3D = True
      Max = 10000
      Min = 1
      ParentCtl3D = False
      PageSize = 500
      Frequency = 500
      Position = 10000
      TabOrder = 2
      ThumbLength = 15
      OnChange = TrackBar1Change
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 295
    Height = 254
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object Memo1: TRxRichEdit
      Left = 1
      Top = 1
      Width = 293
      Height = 252
      Align = alClient
      PopupMenu = PopupMenu2
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 298
    Top = 0
    Width = 151
    Height = 254
    Align = alClient
    TabOrder = 2
    object list: TListBox
      Left = 1
      Top = 1
      Width = 149
      Height = 252
      Align = alClient
      ItemHeight = 13
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnMouseDown = listMouseDown
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 88
    Top = 40
    object N1: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1099#1074#1086#1076
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = '-'
      ShortCut = 16397
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1096#1088#1080#1092#1090
      Enabled = False
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      OnClick = N5Click
    end
    object N6: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      OnClick = N6Click
    end
    object N7: TMenuItem
      Caption = #1042#1099#1088#1077#1079#1072#1090#1100
      OnClick = N7Click
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 256
    Top = 80
    object PrivateMsg1: TMenuItem
      Caption = 'Private Msg'
      OnClick = PrivateMsg1Click
    end
  end
  object onemsc: TTimer
    Enabled = False
    Interval = 1
    OnTimer = onemscTimer
    Left = 9
    Top = 25
  end
end
