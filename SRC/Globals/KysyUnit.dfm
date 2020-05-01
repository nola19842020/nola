object KysyFrm: TKysyFrm
  Left = 564
  Top = 417
  Caption = 'KysyFrm'
  ClientHeight = 73
  ClientWidth = 445
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanA: TPanel
    Left = 0
    Top = 50
    Width = 445
    Height = 23
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Btn1: TButton
      Left = 64
      Top = 1
      Width = 75
      Height = 22
      Cancel = True
      Caption = 'Btn1'
      Default = True
      TabOrder = 0
      OnKeyDown = Btn1KeyDown
      OnMouseDown = Btn1MouseDown
    end
    object Btn2: TButton
      Left = 144
      Top = 1
      Width = 75
      Height = 22
      Caption = 'Btn2'
      TabOrder = 1
      Visible = False
      OnKeyDown = Btn1KeyDown
      OnMouseDown = Btn1MouseDown
    end
    object Btn3: TButton
      Left = 226
      Top = 1
      Width = 75
      Height = 22
      Caption = 'Btn3'
      TabOrder = 2
      Visible = False
      OnKeyDown = Btn1KeyDown
      OnMouseDown = Btn1MouseDown
    end
    object Btn4: TButton
      Left = 310
      Top = 1
      Width = 75
      Height = 22
      Caption = 'Btn4'
      TabOrder = 3
      Visible = False
      OnKeyDown = Btn1KeyDown
      OnMouseDown = Btn1MouseDown
    end
  end
  object REdi: TRichEditNola
    Left = 0
    Top = 0
    Width = 445
    Height = 50
    Align = alClient
    Alignment = taCenter
    BorderStyle = bsNone
    Color = clScrollBar
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'REdi'
      
        ' Btn1'#180'ss'#228' ainoana Default=TR =Enter vastaa klikki'#228'. Kyll'#228'kin ALT' +
        ' workkii, '
      'ei Enter.')
    ParentFont = False
    TabOrder = 1
    Zoom = 100
    OnKeyDown = REdiKeyDown
    Text = 
      'REdi'#13#10' Btn1'#180'ss'#228' ainoana Default=TR =Enter vastaa klikki'#228'. Kyll'#228'k' +
      'in ALT workkii, '#13#10'ei Enter.'#13#10
  end
end
