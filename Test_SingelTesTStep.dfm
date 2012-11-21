object EXPMainMenueForm: TEXPMainMenueForm
  Left = 350
  Top = 339
  Width = 648
  Height = 323
  AutoSize = True
  Caption = 'Tes'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 20
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 321
    Height = 249
    BevelInner = bvLowered
    TabOrder = 0
    object IFKFlashProgButton: TButton
      Left = 24
      Top = 20
      Width = 273
      Height = 41
      Caption = 'IFK Flash programmieren'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = IFKFlashProgButtonClick
    end
    object Test2Button: TButton
      Left = 24
      Top = 74
      Width = 273
      Height = 41
      Caption = 'Test 2: VG-Leisten shift Test  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Test2ButtonClick
    end
    object Test3Button: TButton
      Left = 24
      Top = 131
      Width = 273
      Height = 41
      Caption = 'Test 3: VG-Leisten select Test'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object Test4Button: TButton
      Left = 24
      Top = 187
      Width = 273
      Height = 41
      Caption = 'Test 4: VG-Leisten direc. Test'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
  end
  object CloseButton: TButton
    Left = 536
    Top = 256
    Width = 104
    Height = 33
    Caption = 'Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = CloseButtonClick
  end
  object Panel2: TPanel
    Left = 319
    Top = 0
    Width = 321
    Height = 249
    BevelInner = bvLowered
    TabOrder = 2
    object Test5Button: TButton
      Left = 24
      Top = 20
      Width = 273
      Height = 41
      Caption = 'Test 5: Piggy-Stecker shift Test'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object Test6Button: TButton
      Left = 24
      Top = 73
      Width = 273
      Height = 41
      Caption = 'Test 6: Timing Test                   '
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object Test7Button: TButton
      Left = 24
      Top = 130
      Width = 273
      Height = 41
      Caption = 'Test 7: DRQ DRY INTRL Test'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object Test8Button: TButton
      Left = 24
      Top = 186
      Width = 273
      Height = 41
      BiDiMode = bdLeftToRight
      Caption = 'Test 8: Externe Clock Test    '
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 3
    end
  end
end
