object Form1: TForm1
  Left = -1192
  Top = 166
  Width = 1147
  Height = 131
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 20
  object Init_SpeedButton: TSpeedButton
    Left = 864
    Top = 64
    Width = 57
    Height = 17
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'Zero'
    OnClick = Init_SpeedButtonClick
  end
  object WordSpeedButton: TSpeedButton
    Left = 784
    Top = 64
    Width = 57
    Height = 17
    AllowAllUp = True
    GroupIndex = 1
    Caption = '6 Word'
    OnClick = WordSpeedButtonClick
  end
  object Word_Panel1: TPanel
    Left = 16
    Top = 16
    Width = 177
    Height = 33
    BevelInner = bvLowered
    Caption = '0000000000000000'
    TabOrder = 0
  end
  object Word_Panel2: TPanel
    Left = 200
    Top = 16
    Width = 177
    Height = 33
    BevelInner = bvLowered
    Caption = '0000'
    TabOrder = 1
  end
  object Word_Panel3: TPanel
    Left = 384
    Top = 16
    Width = 177
    Height = 33
    BevelInner = bvLowered
    Caption = '0000'
    TabOrder = 2
  end
  object Word_Panel4: TPanel
    Left = 568
    Top = 16
    Width = 177
    Height = 33
    BevelInner = bvLowered
    Caption = '0000'
    TabOrder = 3
  end
  object Word_Panel5: TPanel
    Left = 752
    Top = 16
    Width = 177
    Height = 33
    BevelInner = bvLowered
    Caption = '0000'
    TabOrder = 4
  end
  object Word_Panel6: TPanel
    Left = 936
    Top = 16
    Width = 177
    Height = 33
    BevelInner = bvLowered
    Caption = '0000'
    TabOrder = 5
  end
  object Shift_Button: TButton
    Left = 952
    Top = 64
    Width = 65
    Height = 17
    Caption = '-->'
    TabOrder = 6
    OnClick = Shift_ButtonClick
  end
  object reset_Button: TButton
    Left = 1040
    Top = 64
    Width = 73
    Height = 17
    Caption = 'Reset'
    TabOrder = 7
    OnClick = reset_ButtonClick
  end
end
