object Form1: TForm1
  Left = 271
  Top = 238
  Width = 537
  Height = 315
  Caption = #1057#1074#1086#1103' '#1048#1075#1088#1072' - Inet'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 342
    Top = 0
    Width = 187
    Height = 281
    Align = alRight
    TabOrder = 0
    object Button1: TButton
      Left = 132
      Top = 248
      Width = 49
      Height = 25
      Caption = 'Setup'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 58
      Top = 248
      Width = 69
      Height = 25
      Caption = 'Connect'
      TabOrder = 1
      OnClick = Button2Click
    end
    object GroupBox3: TGroupBox
      Left = 4
      Top = 0
      Width = 177
      Height = 201
      Caption = 'Status'
      TabOrder = 2
      object Label5: TLabel
        Left = 8
        Top = 32
        Width = 3
        Height = 13
      end
      object Label6: TLabel
        Left = 8
        Top = 152
        Width = 26
        Height = 13
        Caption = 'Login'
      end
      object Label7: TLabel
        Left = 16
        Top = 128
        Width = 144
        Height = 13
        Caption = '________________________'
      end
      object Label8: TLabel
        Left = 8
        Top = 16
        Width = 157
        Height = 16
        Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1089#1077#1088#1074#1077#1088#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
    end
    object Button3: TButton
      Left = 4
      Top = 248
      Width = 49
      Height = 25
      Caption = 'Refresh'
      Enabled = False
      TabOrder = 3
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 48
      Top = 208
      Width = 89
      Height = 25
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1063#1040#1058
      TabOrder = 4
      OnClick = Button4Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 342
    Height = 281
    Align = alClient
    TabOrder = 1
    object GroupBox2: TGroupBox
      Left = 1
      Top = 138
      Width = 340
      Height = 142
      Align = alClient
      Caption = #1054#1090#1074#1077#1090#1099
      TabOrder = 0
      object Label4: TLabel
        Left = 8
        Top = 88
        Width = 10
        Height = 16
        Caption = '3.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 8
        Top = 56
        Width = 10
        Height = 16
        Caption = '2.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 8
        Top = 24
        Width = 10
        Height = 16
        Caption = '1.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Edit1: TEdit
        Left = 24
        Top = 24
        Width = 305
        Height = 21
        Enabled = False
        TabOrder = 0
      end
      object Edit2: TEdit
        Left = 24
        Top = 56
        Width = 305
        Height = 21
        Enabled = False
        TabOrder = 1
      end
      object Edit3: TEdit
        Left = 24
        Top = 88
        Width = 305
        Height = 21
        Enabled = False
        TabOrder = 2
      end
      object Button5: TButton
        Left = 248
        Top = 112
        Width = 81
        Height = 25
        Caption = #1057#1076#1072#1090#1100' '#1086#1090#1074#1077#1090'!'
        Enabled = False
        TabOrder = 3
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 8
        Top = 112
        Width = 91
        Height = 25
        Caption = #1055#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1083#1086#1075
        TabOrder = 4
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 128
        Top = 112
        Width = 75
        Height = 25
        Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099
        Enabled = False
        TabOrder = 5
        OnClick = Button7Click
      end
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 340
      Height = 137
      Align = alTop
      Caption = #1042#1086#1087#1088#1086#1089':'
      TabOrder = 1
      object Memo1: TMemo
        Left = 2
        Top = 15
        Width = 336
        Height = 120
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clBtnFace
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object client: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 0
    OnDisconnected = clientDisconnected
    Port = 0
    Left = 272
    Top = 49
  end
  object XPManifest1: TXPManifest
    Left = 304
    Top = 48
  end
  object b64en: TIdEncoderMIME
    FillChar = '='
    Left = 240
    Top = 48
  end
  object b64de: TIdDecoderMIME
    FillChar = '='
    Left = 208
    Top = 48
  end
  object checkinet: TTimer
    Interval = 10000
    OnTimer = Button3Click
    Left = 112
    Top = 80
  end
  object game_timer: TTimer
    Interval = 10000
    OnTimer = game_timerTimer
    Left = 153
    Top = 81
  end
  object time_sec: TTimer
    Enabled = False
    OnTimer = time_secTimer
    Left = 193
    Top = 81
  end
  object tmUsrList: TTimer
    Interval = 10000
    OnTimer = tmUsrListTimer
    Left = 73
    Top = 81
  end
  object AdvAlertWindow1: TAdvAlertWindow
    AlertMessages = <>
    AlwaysOnTop = True
    AutoHide = False
    AutoSize = False
    AutoDelete = True
    BorderColor = 9731196
    BtnHoverColor = 14483455
    BtnHoverColorTo = 6013175
    BtnDownColor = 557032
    BtnDownColorTo = 8182519
    CaptionColor = 12560296
    CaptionColorTo = 9731196
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    GradientDirection = gdVertical
    HintNextBtn = 'Next'
    HintPrevBtn = 'Previous'
    HintCloseBtn = 'Close'
    HintDeleteBtn = 'Delete'
    HintPopupBtn = 'Popup'
    Hover = False
    MarginX = 4
    MarginY = 1
    PopupLeft = 0
    PopupTop = 0
    PopupWidth = 150
    PopupHeight = 100
    PositionFormat = '%d of %d'
    WindowColor = 16249843
    WindowColorTo = 15128792
    ShowDelete = False
    ShowPopup = False
    AlphaEnd = 180
    AlphaStart = 0
    FadeTime = 0
    DisplayTime = 5000
    FadeStep = 1
    WindowPosition = wpRightBottom
    Version = '1.3.1.0'
    Left = 113
    Top = 33
  end
  object Vspliv: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = VsplivTimer
    Left = 81
    Top = 33
  end
end
