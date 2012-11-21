object DebugForm: TDebugForm
  Left = 301
  Top = 19
  Width = 731
  Height = 178
  Caption = 'debug'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DebugListBox: TListBox
    Left = 21
    Top = 8
    Width = 681
    Height = 97
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 616
    Top = 112
    Width = 89
    Height = 17
    Caption = 'Clear'
    TabOrder = 1
    OnClick = Button1Click
  end
end
