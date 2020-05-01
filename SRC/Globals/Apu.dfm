object ApuFrm: TApuFrm
  Left = 0
  Top = 0
  Caption = 'ApuFrm'
  ClientHeight = 728
  ClientWidth = 646
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
  object PanA: TPanel
    Left = 0
    Top = 695
    Width = 646
    Height = 33
    Align = alBottom
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Lbl1: TLabel
      Left = 170
      Top = 9
      Width = 221
      Height = 14
      Caption = 'Vasta 2. Alt+Click p'#228'ivitt'#228#228' fontin (koko frmiin).'
      Visible = False
    end
    object SuljeBtn: TButton
      Left = 4
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Sulje'
      TabOrder = 0
      OnMouseDown = SuljeBtnMouseDown
    end
    object TallBtn: TButton
      Left = 92
      Top = 4
      Width = 75
      Height = 25
      Hint = 
        'Alt+Click =Fonttimuutosvalikkoon,   ssCtrl+Click =Sulkee valikon' +
        '.'
      Caption = 'Talleta nimell'#228
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnMouseDown = TallBtnMouseDown
    end
  end
  object RichN: TRichEditNola
    Left = 0
    Top = 0
    Width = 646
    Height = 695
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'RichN')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
    Zoom = 100
    Text = 'RichN'#13#10
  end
  object ListBx: TListBox
    Left = 413
    Top = 622
    Width = 233
    Height = 73
    Color = clInfoBk
    ItemHeight = 13
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5')
    TabOrder = 2
    Visible = False
    OnMouseUp = ListBxMouseUp
  end
  object SaveDlg: TSaveDialog
    Left = 600
    Top = 700
  end
  object FntDlg: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 554
    Top = 700
  end
end
