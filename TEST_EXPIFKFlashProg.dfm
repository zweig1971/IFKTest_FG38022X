object EXPIFKFLprogForm: TEXPIFKFLprogForm
  Left = 514
  Top = 410
  Width = 329
  Height = 267
  AutoSize = True
  Caption = 'Experten Modus : IFK Flash prog.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 20
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 321
    Height = 185
    BevelInner = bvLowered
    TabOrder = 0
    object IFKTestProgButton: TButton
      Left = 24
      Top = 24
      Width = 273
      Height = 57
      Caption = 'IFK Testprogr. programmieren'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = IFKTestProgButtonClick
    end
    object IFKFirProgButton: TButton
      Left = 24
      Top = 96
      Width = 273
      Height = 57
      Caption = 'IFK Firmware programmieren'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = IFKFirProgButtonClick
    end
  end
  object CLOSEButton: TButton
    Left = 200
    Top = 192
    Width = 121
    Height = 41
    Caption = 'CLOSE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = CLOSEButtonClick
  end
end
