object Form1: TForm1
  Left = 271
  Top = 225
  Width = 660
  Height = 585
  Caption = #1057#1074#1086#1103' '#1048#1075#1088#1072' - '#1057#1077#1088#1074#1077#1088
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 652
    Height = 558
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1048#1075#1088#1072
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 457
        Height = 161
        Caption = #1042#1086#1087#1088#1086#1089
        TabOrder = 0
        object Memo1: TMemo
          Left = 2
          Top = 15
          Width = 453
          Height = 144
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
      object GroupBox2: TGroupBox
        Left = 0
        Top = 192
        Width = 457
        Height = 337
        Caption = #1063#1072#1090
        TabOrder = 1
        object Button6: TButton
          Left = 408
          Top = 288
          Width = 43
          Height = 41
          Caption = 'Send'
          TabOrder = 0
          OnClick = Button6Click
        end
        object memo2: TRxRichEdit
          Left = 8
          Top = 16
          Width = 441
          Height = 265
          Color = clMoneyGreen
          PopupMenu = PopupMenu1
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
        end
        object Memo3: TMemo
          Left = 8
          Top = 288
          Width = 393
          Height = 41
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          PopupMenu = PopupMenu1
          TabOrder = 2
        end
      end
      object Button7: TButton
        Left = 344
        Top = 164
        Width = 105
        Height = 25
        Caption = #1055#1086#1089#1083#1072#1090#1100' '#1074#1086#1087#1088#1086#1089
        TabOrder = 2
        OnClick = Button7Click
      end
      object BitBtn1: TBitBtn
        Left = 8
        Top = 164
        Width = 25
        Height = 25
        Caption = '<'
        TabOrder = 3
        OnClick = BitBtn1Click
      end
      object BitBtn2: TBitBtn
        Left = 40
        Top = 164
        Width = 25
        Height = 25
        Caption = '>'
        TabOrder = 4
        OnClick = BitBtn2Click
      end
      object Panel1: TPanel
        Left = 256
        Top = 168
        Width = 65
        Height = 17
        BevelInner = bvLowered
        Caption = '0/0/0'
        TabOrder = 5
      end
      object GroupBox8: TGroupBox
        Left = 459
        Top = 0
        Width = 185
        Height = 530
        Align = alRight
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080' Online:'
        TabOrder = 6
        object ListBox1: TListBox
          Left = 2
          Top = 15
          Width = 181
          Height = 513
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          PopupMenu = PopupMenu2
          TabOrder = 0
          OnMouseDown = ListBox1MouseDown
        end
      end
      object Wait1: TWait
        Left = 88
        Top = 164
        Width = 145
        Height = 25
        Caption = '70'
        ModalResult = 0
        Interval = 1000
        OnTimeout = Wait1Timeout
        Visible = False
        IsControl = True
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099
      ImageIndex = 1
      object GroupBox6: TGroupBox
        Left = 504
        Top = 0
        Width = 140
        Height = 530
        Align = alRight
        Caption = #1057#1074#1086#1076#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
        TabOrder = 0
        object ComInfo: TStringGrid
          Left = 2
          Top = 15
          Width = 136
          Height = 513
          Align = alClient
          ColCount = 2
          FixedCols = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnMouseMove = ComInfoMouseMove
        end
      end
      object GroupBox7: TGroupBox
        Left = 0
        Top = 0
        Width = 504
        Height = 530
        Align = alClient
        Caption = #1055#1086#1083#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
        TabOrder = 1
        object FullResult: TStringGrid
          Left = 2
          Top = 15
          Width = 500
          Height = 513
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnMouseMove = FullResultMouseMove
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1054#1087#1094#1080#1080
      ImageIndex = 2
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 209
        Height = 129
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 40
          Width = 44
          Height = 16
          Caption = #1042#1072#1096' IP:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 8
          Top = 16
          Width = 93
          Height = 16
          Caption = #1048#1075#1088#1086#1074#1086#1081' '#1087#1086#1088#1090':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Button1: TButton
          Left = 8
          Top = 96
          Width = 75
          Height = 25
          Caption = 'Start'
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button3: TButton
          Left = 8
          Top = 64
          Width = 193
          Height = 25
          Caption = #1054#1073#1085#1086#1074#1080#1090#1100' IP '#1080' '#1079#1072#1083#1080#1090#1100' '#1085#1072' '#1089#1072#1081#1090
          TabOrder = 1
          OnClick = Button3Click
        end
        object Edit2: TEdit
          Left = 64
          Top = 38
          Width = 137
          Height = 21
          Color = clMoneyGreen
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
        end
        object Edit1: TEdit
          Left = 112
          Top = 14
          Width = 41
          Height = 21
          TabOrder = 3
          Text = '1561'
        end
        object CheckBox1: TCheckBox
          Left = 96
          Top = 100
          Width = 97
          Height = 17
          Hint = 
            #1069#1090#1086' '#1076#1077#1083#1072#1077#1090#1089#1103' '#1076#1083#1103' '#1090#1086#1075#1086', '#1095#1090#1086#1073#1099' '#1074#1086' '#1074#1088#1077#1084#1103' '#1080#1075#1088#1099' '#1085#1080#1082#1090#1086' '#1083#1080#1096#1085#1080#1081' '#1085#1077' '#1079#1072#1074#1072#1083 +
            #1080#1074#1072#1083' '#1074' '#1080#1075#1088#1091'.'#13#10#1042' '#1087#1088#1086#1090#1080#1074#1085#1086#1084' '#1089#1083#1091#1095#1072#1077' '#1084#1086#1075#1091#1090' '#1087#1086#1081#1090#1080' '#1089#1073#1086#1080'!!!'
          Caption = #1047#1072#1082#1088#1099#1090#1100' '#1042#1061#1054#1044
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = CheckBox1Click
        end
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 128
        Width = 209
        Height = 193
        Caption = #1041#1072#1079#1072' '#1074#1086#1087#1088#1086#1089#1086#1074
        TabOrder = 1
        DesignSize = (
          209
          193)
        object Label6: TLabel
          Left = 8
          Top = 17
          Width = 80
          Height = 16
          Caption = #1055#1091#1090#1100' '#1082' '#1073#1072#1079#1077':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 128
          Top = 65
          Width = 7
          Height = 16
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 8
          Top = 65
          Width = 113
          Height = 16
          Caption = #1042#1086#1087#1088#1086#1089#1086#1074' '#1074' '#1073#1072#1079#1077':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 8
          Top = 89
          Width = 124
          Height = 16
          Caption = #1042#1086#1087#1088#1086#1089#1086#1074' '#1089#1099#1075#1088#1072#1085#1086':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Edit3: TEdit
          Left = 8
          Top = 36
          Width = 193
          Height = 24
          Color = clMoneyGreen
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object Button4: TButton
          Left = 8
          Top = 120
          Width = 193
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1074#1086#1087#1088#1086#1089#1086#1074
          TabOrder = 1
          OnClick = Button4Click
        end
        object Button5: TButton
          Left = 8
          Top = 160
          Width = 193
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1074#1086#1087#1088#1086#1089#1099
          TabOrder = 2
          OnClick = Button5Click
        end
        object Edit4: TEdit
          Left = 138
          Top = 88
          Width = 25
          Height = 21
          TabOrder = 3
          Text = '0'
        end
        object Button2: TButton
          Left = 170
          Top = 86
          Width = 31
          Height = 25
          Caption = 'OK'
          TabOrder = 4
          OnClick = Button2Click
        end
      end
      object GroupBox5: TGroupBox
        Left = 208
        Top = 0
        Width = 433
        Height = 321
        Caption = #1054#1089#1090#1072#1083#1100#1085#1086#1077'...'
        TabOrder = 2
        object Button8: TButton
          Left = 8
          Top = 56
          Width = 153
          Height = 25
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1089#1090#1086#1088#1080#1102' '#1095#1072#1090#1072
          Enabled = False
          TabOrder = 0
        end
        object Button9: TButton
          Left = 8
          Top = 16
          Width = 153
          Height = 25
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1080#1075#1088#1099
          Enabled = False
          TabOrder = 1
        end
      end
    end
  end
  object server: TIdTCPServer
    Bindings = <>
    CommandHandlers = <
      item
        CmdDelimiter = ' '
        Command = '<login>'
        Disconnect = False
        Name = 'Login'
        OnCommand = serverLoginCommand
        ParamDelimiter = ' '
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 0
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = '<ready>'
        Disconnect = False
        Name = 'ready'
        OnCommand = serverreadyCommand
        ParamDelimiter = ' '
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 0
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = '<msg_send>'
        Disconnect = False
        Name = 'msg_send'
        OnCommand = servermsg_sendCommand
        ParamDelimiter = ' '
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 0
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = '<start_game>'
        Disconnect = False
        Name = 'start_game'
        OnCommand = serverstart_gameCommand
        ParamDelimiter = ' '
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 0
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = '<ans_send>'
        Disconnect = False
        Name = 'ans_send'
        OnCommand = serverans_sendCommand
        ParamDelimiter = ' '
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 0
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = '<usr_list>'
        Disconnect = False
        Name = 'usr_list'
        OnCommand = serverusr_listCommand
        ParamDelimiter = ' '
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 0
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = '<results>'
        Disconnect = False
        Name = 'results'
        OnCommand = serverresultsCommand
        ParamDelimiter = ' '
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 0
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = '<private>'
        Disconnect = False
        Name = 'private'
        OnCommand = serverprivateCommand
        ParamDelimiter = ' '
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 0
        Tag = 0
      end>
    DefaultPort = 0
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnConnect = serverConnect
    OnDisconnect = serverDisconnect
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    ReplyUnknownCommand.Text.Strings = (
      'unknown command')
    Left = 424
    Top = 104
  end
  object b64en: TIdEncoderMIME
    FillChar = '='
    Left = 392
    Top = 104
  end
  object b64de: TIdDecoderMIME
    FillChar = '='
    Left = 456
    Top = 104
  end
  object http: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 0
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 392
    Top = 72
  end
  object XPManifest1: TXPManifest
    Left = 424
    Top = 72
  end
  object od: TOpenDialog
    Filter = 'Questions DataBase|*.qdb'
    Title = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083' '#1089' '#1074#1086#1087#1088#1086#1089#1072#1084#1080'...'
    Left = 392
    Top = 40
  end
  object sd: TSaveDialog
    Filter = 'Questions DataBase|*.qdb'
    Title = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1092#1072#1081#1083' '#1089' '#1074#1086#1087#1088#1086#1089#1072#1084#1080'...'
    Left = 424
    Top = 40
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 356
    Top = 104
  end
  object Timer2: TTimer
    Enabled = False
    OnTimer = Timer2Timer
    Left = 316
    Top = 104
  end
  object PopupMenu1: TPopupMenu
    Left = 148
    Top = 288
    object N1: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1099#1074#1086#1076
      OnClick = N1Click
    end
    object N7: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1099#1074#1086#1076
      OnClick = N7Click
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
      ShortCut = 49224
      OnClick = N4Click
    end
    object Dcnfdbnm1: TMenuItem
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      OnClick = Dcnfdbnm1Click
    end
    object N5: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      OnClick = N5Click
    end
    object N6: TMenuItem
      Caption = #1042#1099#1088#1077#1079#1072#1090#1100
      OnClick = N6Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 519
    Top = 216
    object kick1: TMenuItem
      Caption = 'Kick user'
      OnClick = kick1Click
    end
    object PrivateMsg1: TMenuItem
      Caption = 'Private Msg'
      OnClick = PrivateMsg1Click
    end
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 460
    Top = 72
  end
  object onemsc: TTimer
    Enabled = False
    Interval = 1
    OnTimer = onemscTimer
    Left = 20
    Top = 64
  end
end
