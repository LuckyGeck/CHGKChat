object Form3: TForm3
  Left = 425
  Top = 232
  Width = 443
  Height = 305
  Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1086#1090#1074#1077#1090#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 177
    Top = 0
    Height = 248
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 177
    Height = 248
    Align = alLeft
    Caption = #1048#1075#1088#1086#1082#1080
    TabOrder = 0
    object ListBox1: TListBox
      Left = 2
      Top = 15
      Width = 173
      Height = 231
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
      OnClick = ListBox1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 180
    Top = 0
    Width = 255
    Height = 248
    Align = alClient
    Caption = #1048#1093' '#1086#1090#1074#1077#1090#1099
    TabOrder = 1
    object CheckListBox1: TCheckListBox
      Left = 2
      Top = 15
      Width = 251
      Height = 231
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 248
    Width = 435
    Height = 30
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      435
      30)
    object Button1: TButton
      Left = 356
      Top = 0
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
