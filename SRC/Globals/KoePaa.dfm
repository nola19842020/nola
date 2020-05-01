object KoePaaFrm: TKoePaaFrm
  Left = 927
  Top = 780
  Caption = 'KoePaaFrm'
  ClientHeight = 162
  ClientWidth = 337
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Rich2: TRichEdit
    Left = 0
    Top = 0
    Width = 337
    Height = 79
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'abcde fghij klmno pqrst uvwxy z'#229#228#246
      'ABCDE GGHIJ KLMNO PQRST UVQXY Z'#197#196#214)
    ParentFont = False
    TabOrder = 0
    Zoom = 100
    OnKeyDown = Rich2KeyDown
  end
  object Rich1: TRichEditNola
    Left = 0
    Top = 79
    Width = 337
    Height = 83
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Zoom = 100
    OnKeyDown = Rich1KeyDown
    Text = ''
  end
end
