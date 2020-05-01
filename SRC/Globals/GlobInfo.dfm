object ClobInfoFrm: TClobInfoFrm
  Left = 0
  Top = 0
  Caption = 'GlobInfoFrm / EI  VIEL'#196' K'#196'YT'#214'SS'#196' (ShowMessagen tilalle).'
  ClientHeight = 479
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Rich1: TRichEdit
    Left = 0
    Top = 0
    Width = 635
    Height = 443
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'Rich1')
    ParentFont = False
    TabOrder = 0
    Zoom = 100
  end
  object PanA: TPanel
    Left = 0
    Top = 443
    Width = 635
    Height = 36
    Align = alBottom
    TabOrder = 1
    object SuljeBtn: TButton
      Left = 10
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Sulje'
      TabOrder = 0
      OnClick = SuljeBtnClick
    end
    object TulostaBtn: TButton
      Left = 97
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Tulosta'
      TabOrder = 1
      OnClick = TulostaBtnClick
    end
    object TalletaBtn: TButton
      Left = 184
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Talleta'
      TabOrder = 2
      OnClick = TalletaBtnClick
    end
  end
  object SaveDlg: TSaveDialog
    Left = 278
    Top = 436
  end
end
