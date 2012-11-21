object SRNummerEingabe: TSRNummerEingabe
  Left = 619
  Top = 240
  Width = 201
  Height = 147
  AutoSize = True
  Caption = 'Serien Nummer überprüfen'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 193
    Height = 81
    BevelInner = bvLowered
    TabOrder = 0
    object Label3: TLabel
      Left = 13
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
    object DontShowCheckBox: TCheckBox
      Left = 11
      Top = 52
      Width = 150
      Height = 17
      Caption = 'nicht mehr anzeigen'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object LfdNrMaskEdit: TMaskEdit
      Left = 80
      Top = 12
      Width = 89
      Height = 26
      EditMask = 'ccccccccc;0;_'
      MaxLength = 9
      TabOrder = 1
    end
  end
  object OKButton: TButton
    Left = 56
    Top = 88
    Width = 89
    Height = 25
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = OKButtonClick
  end
end
