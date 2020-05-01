object FileLstFrm: TFileLstFrm
  Left = 878
  Top = 521
  ClientHeight = 184
  ClientWidth = 309
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TPanelNola
    Left = 0
    Top = 156
    Width = 309
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
    object KoeLb: TLabel
      Left = 215
      Top = 7
      Width = 31
      Height = 13
      Caption = 'KoeLb'
    end
    object SuljeBtn: TButton
      Left = 3
      Top = 3
      Width = 65
      Height = 23
      Hint = 'Sulkee ikkunan'
      Cancel = True
      Caption = '&Sulje'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = SuljeBtnClick
    end
    object NaytaBtn: TButton
      Left = 137
      Top = 3
      Width = 72
      Height = 23
      Hint = 'N'#228'ytt'#228#228' koko levysis'#228'll'#246'n'
      Caption = '&N'#228'yt'#228' kaikki '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = NaytaBtnClick
    end
    object TamaBtn: TButton
      Left = 72
      Top = 3
      Width = 65
      Height = 23
      Hint = 'Valittu tiedosto avataan'
      Caption = '&T'#228'm'#228
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = TamaBtnClick
    end
  end
  object StrGr: TStringGridNola
    Left = 0
    Top = 34
    Width = 200
    Height = 113
    BorderStyle = bsNone
    Color = clLime
    DefaultColWidth = 20
    DefaultRowHeight = 17
    FixedCols = 0
    RowCount = 2
    GridLineWidth = 0
    Options = [goRowSelect, goThumbTracking]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnDblClick = StrGrDblClick
    OnKeyDown = StrGrKeyDown
    OnMouseDown = StrGrMouseDown
    OnWidestColInRow = StrGrWidestColInRow
    OnAfterPaint = StrGrAfterPaint
    SelectionEnabled = True
    DefaultCellAlign = alLeft
    DefaultCellVAlign = alMiddle
    ColWidths = (
      20
      20
      20
      20
      20)
  end
  object OpenDlg: TOpenDialog
    Left = 202
    Top = 51
  end
  object SaveDlg: TSaveDialog
    Left = 202
    Top = 99
  end
end
