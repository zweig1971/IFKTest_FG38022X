object TEST_DatenEingabeForm: TTEST_DatenEingabeForm
  Left = 423
  Top = 380
  Width = 532
  Height = 163
  AutoSize = True
  Caption = 'Daten Eingabe'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 18
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 524
    Height = 90
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 13
      Top = 13
      Width = 157
      Height = 20
      Caption = 'Datum (TT.MM.JJ) :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 13
      Top = 54
      Width = 129
      Height = 19
      Caption = 'Uhrzeit (HH.MM):'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 325
      Top = 15
      Width = 61
      Height = 19
      Caption = 'Lfd. Nr.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 323
      Top = 53
      Width = 89
      Height = 19
      Caption = 'Bearbeiter :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 231
      Top = 53
      Width = 28
      Height = 19
      Caption = '24h'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DatenBenutzerEdit: TEdit
      Left = 415
      Top = 50
      Width = 74
      Height = 26
      TabOrder = 0
      Text = 'Mister L'
    end
    object DateMaskEdit: TMaskEdit
      Left = 176
      Top = 11
      Width = 73
      Height = 26
      EditMask = '!90/90/00;1;_'
      MaxLength = 8
      TabOrder = 1
      Text = '  .  .  '
    end
    object TimeMaskEdit: TMaskEdit
      Left = 176
      Top = 48
      Width = 49
      Height = 26
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 2
      Text = '  :  '
    end
  end
  object OK_Button: TButton
    Left = 198
    Top = 96
    Width = 113
    Height = 33
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = OK_ButtonClick
  end
  object LfdNrMaskEdit: TMaskEdit
    Left = 412
    Top = 12
    Width = 85
    Height = 26
    EditMask = 'ccccccccc;0;_'
    MaxLength = 9
    TabOrder = 2
  end
end
