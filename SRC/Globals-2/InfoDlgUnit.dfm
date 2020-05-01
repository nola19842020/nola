object InfoDlgFrm: TInfoDlgFrm
  Left = 576
  Top = 767
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 210
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBtn: TPanel
    Left = 0
    Top = 179
    Width = 435
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    OnClick = PanelBtnClick
    object Btn1: TButton
      Tag = 1
      Left = 20
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Btn1'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Visible = False
      OnClick = Btn1Click
    end
    object Btn2: TButton
      Tag = 2
      Left = 120
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Btn2'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Visible = False
      OnClick = Btn2Click
    end
    object Btn3: TButton
      Tag = 3
      Left = 206
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Btn3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Visible = False
      OnClick = Btn3Click
    end
    object Btn4: TButton
      Tag = 4
      Left = 292
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Btn4'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Visible = False
      OnClick = Btn4Click
    end
  end
  object PanelY: TPanel
    Left = 0
    Top = 0
    Width = 435
    Height = 138
    Align = alClient
    BevelOuter = bvNone
    Color = clHighlightText
    TabOrder = 1
    object RediN: TRichEditNola
      Left = 0
      Top = 0
      Width = 435
      Height = 57
      Align = alTop
      BorderStyle = bsNone
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Lines.Strings = (
        'RediN'
        '222'
        '333'
        '444'
        '555')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WantReturns = False
      Zoom = 100
      OnKeyUp = RediNKeyUp
      OnMouseDown = RediNMouseDown
      Text = 'RediN'#13#10'222'#13#10'333'#13#10'444'#13#10'555'#13#10
    end
    object StrGr: TStringGridNola
      Left = 0
      Top = 57
      Width = 435
      Height = 81
      Align = alBottom
      BorderStyle = bsNone
      Color = clAppWorkSpace
      ColCount = 8
      DefaultColWidth = 10
      DefaultRowHeight = 16
      FixedCols = 7
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goThumbTracking]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnWidestColInRow = StrGrWidestColInRow
      SelectionEnabled = True
      DefaultCellAlign = alLeft
      DefaultCellVAlign = alMiddle
      RowHeights = (
        16
        16
        16
        16
        16)
    end
  end
  object PanelBx: TPanel
    Left = 0
    Top = 138
    Width = 435
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object ComBx1: TComboBoxXY
      Left = 232
      Top = 6
      Width = 80
      Height = 21
      TabOrder = 0
      Text = 'ComBx1'
      OnKeyDown = ComBx1KeyDown
    end
  end
end
