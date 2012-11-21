object SingelBitMusterForm: TSingelBitMusterForm
  Left = 130
  Top = 238
  Width = 1065
  Height = 611
  AutoSize = True
  Caption = 'Experten Modus: Shit Anzeige'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clRed
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1057
    Height = 529
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Bevel1: TBevel
      Left = 8
      Top = 7
      Width = 1041
      Height = 274
    end
    object Label13: TLabel
      Left = 13
      Top = 12
      Width = 121
      Height = 19
      Caption = 'Read bit pattern'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label26: TLabel
      Left = 12
      Top = 113
      Width = 120
      Height = 19
      Caption = 'Write bit pattern'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 12
      Top = 234
      Width = 281
      Height = 41
    end
    object Label28: TLabel
      Left = 19
      Top = 245
      Width = 58
      Height = 19
      Caption = 'Errors :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label29: TLabel
      Left = 544
      Top = 296
      Width = 139
      Height = 19
      Caption = 'System messages'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Panel4: TPanel
      Left = 12
      Top = 33
      Width = 1027
      Height = 73
      BevelInner = bvLowered
      TabOrder = 0
      object Label2: TLabel
        Left = 853
        Top = 4
        Width = 18
        Height = 19
        Caption = '15'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 1006
        Top = 4
        Width = 9
        Height = 19
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 832
        Top = 4
        Width = 18
        Height = 19
        Caption = '16'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 689
        Top = 4
        Width = 18
        Height = 19
        Caption = '31'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 664
        Top = 4
        Width = 18
        Height = 19
        Caption = '32'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 518
        Top = 4
        Width = 18
        Height = 19
        Caption = '47'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 493
        Top = 4
        Width = 18
        Height = 19
        Caption = '48'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 350
        Top = 4
        Width = 18
        Height = 19
        Caption = '63'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 326
        Top = 4
        Width = 18
        Height = 19
        Caption = '64'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 182
        Top = 4
        Width = 18
        Height = 19
        Caption = '79'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 160
        Top = 4
        Width = 18
        Height = 19
        Caption = '80'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 14
        Top = 4
        Width = 18
        Height = 19
        Caption = '95'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RWort1HBPanel: TPanel
        Left = 854
        Top = 19
        Width = 81
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 0
      end
      object RWort1LBPanel: TPanel
        Left = 933
        Top = 19
        Width = 82
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 1
      end
      object RWort2HBPanel: TPanel
        Left = 688
        Top = 19
        Width = 81
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 2
      end
      object RWort2LBPanel: TPanel
        Left = 767
        Top = 19
        Width = 82
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 3
      end
      object RWort3HBPanel: TPanel
        Left = 518
        Top = 19
        Width = 81
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 4
      end
      object RWort3LBPanel: TPanel
        Left = 597
        Top = 19
        Width = 82
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 5
      end
      object RWort4HBPanel: TPanel
        Left = 350
        Top = 19
        Width = 81
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 6
      end
      object RWort4LBPanel: TPanel
        Left = 429
        Top = 19
        Width = 82
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 7
      end
      object RWort5HBPanel: TPanel
        Left = 182
        Top = 19
        Width = 81
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 8
      end
      object RWort5LBPanel: TPanel
        Left = 261
        Top = 19
        Width = 82
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 9
      end
      object RWort6HBPanel: TPanel
        Left = 14
        Top = 19
        Width = 81
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 10
      end
      object RWort6LBPanel: TPanel
        Left = 93
        Top = 19
        Width = 82
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 11
      end
    end
    object Panel15: TPanel
      Left = 11
      Top = 132
      Width = 1025
      Height = 97
      BevelInner = bvLowered
      TabOrder = 1
      object Label14: TLabel
        Left = 853
        Top = 4
        Width = 18
        Height = 19
        Caption = '15'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 1006
        Top = 4
        Width = 9
        Height = 19
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label16: TLabel
        Left = 832
        Top = 4
        Width = 18
        Height = 19
        Caption = '16'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label17: TLabel
        Left = 689
        Top = 4
        Width = 18
        Height = 19
        Caption = '31'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label18: TLabel
        Left = 664
        Top = 4
        Width = 18
        Height = 19
        Caption = '32'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label19: TLabel
        Left = 518
        Top = 4
        Width = 18
        Height = 19
        Caption = '47'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label20: TLabel
        Left = 493
        Top = 4
        Width = 18
        Height = 19
        Caption = '48'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label21: TLabel
        Left = 350
        Top = 4
        Width = 18
        Height = 19
        Caption = '63'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label22: TLabel
        Left = 326
        Top = 4
        Width = 18
        Height = 19
        Caption = '64'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label23: TLabel
        Left = 182
        Top = 4
        Width = 18
        Height = 19
        Caption = '79'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label24: TLabel
        Left = 160
        Top = 4
        Width = 18
        Height = 19
        Caption = '80'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label25: TLabel
        Left = 14
        Top = 4
        Width = 18
        Height = 19
        Caption = '95'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object OneShiftSpeedButton: TSpeedButton
        Left = 640
        Top = 66
        Width = 81
        Height = 17
        AllowAllUp = True
        GroupIndex = 2
        Caption = 'One shift'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = OneShiftSpeedButtonClick
      end
      object RunSpeedButton: TSpeedButton
        Left = 960
        Top = 66
        Width = 57
        Height = 17
        AllowAllUp = True
        GroupIndex = 2
        Caption = '>>>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = RunSpeedButtonClick
      end
      object SWort1HBPanel: TPanel
        Left = 854
        Top = 19
        Width = 81
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 0
      end
      object SWort1LBPanel: TPanel
        Left = 933
        Top = 19
        Width = 82
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 1
      end
      object SWort2HBPanel: TPanel
        Left = 688
        Top = 19
        Width = 81
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 2
      end
      object SWort2LBPanel: TPanel
        Left = 767
        Top = 19
        Width = 82
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 3
      end
      object SWort3HBPanel: TPanel
        Left = 518
        Top = 19
        Width = 81
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 4
      end
      object SWort3LBPanel: TPanel
        Left = 597
        Top = 19
        Width = 82
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 5
      end
      object SWort4HBPanel: TPanel
        Left = 350
        Top = 19
        Width = 81
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 6
      end
      object SWort4LBPanel: TPanel
        Left = 429
        Top = 19
        Width = 82
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 7
      end
      object SWort5HBPanel: TPanel
        Left = 182
        Top = 19
        Width = 81
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 8
      end
      object SWort5LBPanel: TPanel
        Left = 261
        Top = 19
        Width = 82
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 9
      end
      object SWort6HBPanel: TPanel
        Left = 14
        Top = 19
        Width = 81
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 10
      end
      object SWort6LBPanel: TPanel
        Left = 93
        Top = 19
        Width = 82
        Height = 33
        BevelInner = bvLowered
        Caption = '01234567'
        TabOrder = 11
      end
      object StepButton: TButton
        Left = 896
        Top = 66
        Width = 57
        Height = 17
        Caption = '>>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        OnClick = StepButtonClick
      end
      object ResetButton: TButton
        Left = 728
        Top = 66
        Width = 65
        Height = 17
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 13
        OnClick = ResetButtonClick
      end
      object SingelStepButton: TButton
        Left = 832
        Top = 66
        Width = 57
        Height = 17
        Caption = '>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 14
        OnClick = SingelStepButtonClick
      end
    end
    object ErrorPanel: TPanel
      Left = 81
      Top = 242
      Width = 113
      Height = 24
      BevelInner = bvLowered
      Caption = '0'
      TabOrder = 2
    end
    object ClearCountsButton: TButton
      Left = 219
      Top = 249
      Width = 65
      Height = 17
      Caption = 'clear'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = ClearCountsButtonClick
    end
    object SysMessListBox: TListBox
      Left = 544
      Top = 320
      Width = 489
      Height = 169
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 4
    end
    object ClearSysMessButton: TButton
      Left = 968
      Top = 499
      Width = 65
      Height = 17
      Caption = 'clear'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = ClearSysMessButtonClick
    end
    object GroupBox1: TGroupBox
      Left = 40
      Top = 296
      Width = 177
      Height = 193
      Caption = ' Status Master '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object MDrOupEnabelButton: TButton
        Left = 24
        Top = 24
        Width = 129
        Height = 33
        Caption = 'Driver output enabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = MDrOupEnabelButtonClick
      end
      object MDrDirecButton: TButton
        Left = 24
        Top = 64
        Width = 129
        Height = 33
        Caption = 'Driver Direction '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = MDrDirecButtonClick
      end
      object MOutputRegButton: TButton
        Left = 24
        Top = 104
        Width = 129
        Height = 33
        Caption = 'Output Register'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = MOutputRegButtonClick
      end
      object MInputRegButton: TButton
        Left = 24
        Top = 144
        Width = 129
        Height = 33
        Caption = 'Input Register'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = MInputRegButtonClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 256
      Top = 296
      Width = 177
      Height = 193
      Caption = ' Status Slave'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      object SDrOupEnabelButton: TButton
        Left = 24
        Top = 24
        Width = 129
        Height = 33
        Caption = 'Driver output enabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = SDrOupEnabelButtonClick
      end
      object SDrDirecButton: TButton
        Left = 24
        Top = 64
        Width = 129
        Height = 33
        Caption = 'Driver Direction '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = SDrDirecButtonClick
      end
      object SOuttRegButton: TButton
        Left = 24
        Top = 104
        Width = 129
        Height = 33
        Caption = 'Output Register'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = SOuttRegButtonClick
      end
      object SInputRegButton: TButton
        Left = 24
        Top = 144
        Width = 129
        Height = 33
        Caption = 'Input Register'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = SInputRegButtonClick
      end
    end
  end
  object CloseButton: TButton
    Left = 920
    Top = 536
    Width = 137
    Height = 41
    Caption = 'C L O S E'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = CloseButtonClick
  end
end
