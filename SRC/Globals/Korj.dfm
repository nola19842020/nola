object KorjFrm: TKorjFrm
  Left = 295
  Top = 133
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 573
  ClientWidth = 643
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
  object PanelA: TPanel
    Left = 0
    Top = 540
    Width = 643
    Height = 33
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
    object SuljeBtn: TButton
      Left = 60
      Top = 4
      Width = 50
      Height = 25
      Hint = 'Hylk'#228#228' mahd. valinnat ja sulkee ikkunan.'
      Caption = '&Sulje'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = SuljeBtnClick
    end
    object OkBtn: TButton
      Left = 4
      Top = 4
      Width = 50
      Height = 25
      Hint = 
        'Hyv'#228'ksyy taulukoissa/alapanelissa n'#228'kyv'#228't KORJAUSKERROINvalinnat' +
        ', SIIRT'#196#196' ARVON VERKKOLASKENTAAN ja sulkee ikkunan.'
      Caption = '&OK'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = OkBtnClick
    end
    object RichInfo: TRichEditNola
      Left = 196
      Top = 2
      Width = 445
      Height = 29
      BorderStyle = bsNone
      Color = clBtnFace
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Lines.Strings = (
        'Teksti'#228' OnShow -eventiss'#228'.')
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 2
      Visible = False
      WantReturns = False
      Zoom = 100
      Text = 'Teksti'#228' OnShow -eventiss'#228'.'#13#10
    end
    object KPan1: TPanelNola
      Left = 113
      Top = 2
      Width = 72
      Height = 27
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'Korj1'
      Color = clInfoBk
      Enabled = False
      TabOrder = 3
      object Kedi1: TEdit
        Left = 30
        Top = 4
        Width = 40
        Height = 21
        Color = clBtnFace
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Text = 'X,xxx'
      end
    end
    object KPan2: TPanelNola
      Left = 185
      Top = 2
      Width = 82
      Height = 27
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'x  Korj2'
      Enabled = False
      TabOrder = 4
      object Kedi2: TEdit
        Left = 40
        Top = 4
        Width = 40
        Height = 21
        Color = clBtnFace
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Text = 'X,xxx'
      end
    end
    object KPan3: TPanelNola
      Left = 267
      Top = 2
      Width = 82
      Height = 27
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'x  Korj3'
      Color = clInfoBk
      Enabled = False
      TabOrder = 5
      object Kedi3: TEdit
        Left = 40
        Top = 4
        Width = 40
        Height = 21
        Color = clBtnFace
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Text = 'X,xxx'
      end
    end
    object KPanY: TPanelNola
      Left = 354
      Top = 2
      Width = 110
      Height = 27
      Hint = 
        'Taulukoista valittujen korjauskerrontekij'#246'iden yhteisvaikutus = ' +
        'KOKONAISkorjauskerroin, joka SIIRTYY VERKKOLASKENTAAN OK-painikk' +
        'eella.'
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      object KLabY: TLabelNola
        Left = 58
        Top = 7
        Width = 5
        Height = 13
        Hint = 
          'Taulukoista valittujen korjauskerrontekij'#246'iden yhteisvaikutus = ' +
          'KOKONAISkorjauskerroin, joka SIIRTYY VERKKOLASKENTAAN OK-painikk' +
          'eella.'
        AutoSize = True
        Caption = '= Korj.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        DesignScreenHeight = 1095
        DesignScreenWidth = 1773
      end
      object KediY: TEdit
        Left = 14
        Top = 4
        Width = 40
        Height = 21
        Hint = 
          'Taulukoista valittujen korjauskerrontekij'#246'iden yhteisvaikutus = ' +
          'KOKONAISkorjauskerroin, joka SIIRTYY VERKKOLASKENTAAN OK-painikk' +
          'eella.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = 'X,xxx'
      end
    end
    object KPanAlp: TPanelNola
      Left = 464
      Top = 2
      Width = 105
      Height = 27
      Hint = 'Aikaisemmin verkkolaskentaan sy'#246'tetty KOKONAISkorjauskerroin.'
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'Aikaisempi:'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      object KediAlp: TEdit
        Left = 60
        Top = 4
        Width = 40
        Height = 21
        Color = clBtnFace
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Text = 'X,xxx'
      end
    end
  end
  object TabCtrl: TTabControl
    Left = 0
    Top = 0
    Width = 643
    Height = 540
    Align = alClient
    HotTrack = True
    TabOrder = 1
    Tabs.Strings = (
      'Asennus maahan (D)'
      'Muut asennustavat (A...)')
    TabIndex = 1
    OnChange = TabCtrlChange
    object ScrBx: TScrollBox
      Left = 4
      Top = 24
      Width = 635
      Height = 512
      HorzScrollBar.ButtonSize = 20
      HorzScrollBar.Margin = 25
      HorzScrollBar.Range = 635
      HorzScrollBar.Size = 20
      HorzScrollBar.ThumbSize = 20
      HorzScrollBar.Tracking = True
      VertScrollBar.ButtonSize = 20
      VertScrollBar.Margin = 25
      VertScrollBar.Range = 750
      VertScrollBar.Size = 20
      VertScrollBar.ThumbSize = 20
      VertScrollBar.Tracking = True
      Align = alClient
      AutoScroll = False
      AutoSize = True
      BorderStyle = bsNone
      Color = clYellow
      ParentColor = False
      TabOrder = 0
      object C_Grd: TStringGridNola
        Left = 0
        Top = 263
        Width = 635
        Height = 69
        Align = alTop
        ColCount = 13
        DefaultRowHeight = 16
        FixedColor = clInfoBk
        FixedCols = 3
        RowCount = 3
        FixedRows = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goThumbTracking]
        TabOrder = 5
        OnSelectCell = C_GrdSelectCell
        OnWidestColInRow = A_GrdWidestColInRow
        OnAfterPaint = C_GrdAfterPaint
        SelectionEnabled = True
        DefaultCellAlign = alLeft
        DefaultCellVAlign = alAbove
        ColWidths = (
          35
          108
          103
          26
          25
          26
          25
          27
          27
          27
          27
          25
          27)
        RowHeights = (
          16
          16
          16)
      end
      object A_Pan: TPanel
        Left = 0
        Top = 0
        Width = 635
        Height = 30
        Hint = 'Ks. huomautukset ja rajoitukset ao. m'#228#228'r'#228'yskohdasta.'
        Align = alTop
        BevelInner = bvLowered
        Caption = 'A_Pan'
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object A_Grd: TStringGridNola
        Left = 0
        Top = 30
        Width = 635
        Height = 54
        Align = alTop
        ColCount = 14
        DefaultRowHeight = 16
        FixedColor = clInfoBk
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goThumbTracking]
        TabOrder = 1
        OnSelectCell = C_GrdSelectCell
        OnWidestColInRow = A_GrdWidestColInRow
        SelectionEnabled = True
        DefaultCellAlign = alLeft
        DefaultCellVAlign = alAbove
        ColWidths = (
          35
          108
          103
          26
          25
          26
          25
          27
          27
          27
          27
          26
          27
          64)
        RowHeights = (
          16
          16)
      end
      object C_Pan: TPanel
        Left = 0
        Top = 167
        Width = 635
        Height = 66
        Align = alTop
        BevelInner = bvLowered
        Caption = 'C_Pan'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        object C_Pan2: TPanel
          Left = 2
          Top = 34
          Width = 631
          Height = 30
          Hint = 'Ks. huomautukset ja rajoitukset ao. m'#228#228'r'#228'yskohdasta.'
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'C_Pan2'
          Color = clBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object C_Rad: TRadioGroup
          Left = 2
          Top = 2
          Width = 631
          Height = 32
          Hint = 'Ks. huomautukset ja rajoitukset ao. m'#228#228'r'#228'yskohdasta.'
          Align = alTop
          Color = clBlue
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            'Normaalias. ( /a,  /uo,  /s )'
            'Kaap.hyllyas. ( /kh ) monijohdin'
            'Kaap.hyllyas. ( /kh ) yksijohdin')
          ParentColor = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = C_RadClick
        end
      end
      object B_Pan: TPanel
        Left = 0
        Top = 84
        Width = 635
        Height = 30
        Hint = 'Ks. huomautukset ja rajoitukset ao. m'#228#228'r'#228'yskohdasta.'
        Align = alTop
        BevelInner = bvLowered
        Caption = 'B_Pan'
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object B_Grd: TStringGridNola
        Left = 0
        Top = 114
        Width = 635
        Height = 53
        Align = alTop
        ColCount = 4
        DefaultRowHeight = 16
        FixedColor = clInfoBk
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goThumbTracking]
        TabOrder = 3
        OnSelectCell = C_GrdSelectCell
        OnWidestColInRow = A_GrdWidestColInRow
        SelectionEnabled = True
        DefaultCellAlign = alLeft
        DefaultCellVAlign = alAbove
        ColWidths = (
          35
          64
          64
          64)
        RowHeights = (
          16
          16)
      end
      object D_Pan: TPanel
        Left = 0
        Top = 233
        Width = 635
        Height = 30
        Align = alTop
        BevelOuter = bvNone
        Color = clBlack
        TabOrder = 6
        object C_Redi0: TRichEdit
          Left = 0
          Top = 0
          Width = 45
          Height = 30
          BorderStyle = bsNone
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Lines.Strings = (
            'EiTexti'#228)
          ParentFont = False
          TabOrder = 0
          WordWrap = False
          Zoom = 100
        end
        object C_Redi1: TRichEdit
          Left = 50
          Top = 0
          Width = 83
          Height = 30
          Alignment = taCenter
          BorderStyle = bsNone
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Lines.Strings = (
            'Kaapeleiden '
            'asettelu')
          ParentFont = False
          TabOrder = 1
          WordWrap = False
          Zoom = 100
        end
        object C_Redi2: TRichEdit
          Left = 140
          Top = 0
          Width = 100
          Height = 30
          Alignment = taCenter
          BorderStyle = bsNone
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Lines.Strings = (
            'Korjauskertoimet A2  52-E1'
            'Yksijohdinvirtapiirien tai monijohdinkaapelien lukum.')
          ParentFont = False
          TabOrder = 2
          WordWrap = False
          Zoom = 100
        end
        object C_Redi4: TRichEdit
          Left = 306
          Top = 0
          Width = 100
          Height = 30
          Alignment = taCenter
          BorderStyle = bsNone
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Lines.Strings = (
            'HyllyLkm')
          ParentFont = False
          TabOrder = 3
          WordWrap = False
          Zoom = 100
        end
        object C_Redi5: TRichEdit
          Left = 410
          Top = 0
          Width = 100
          Height = 30
          Alignment = taCenter
          BorderStyle = bsNone
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Lines.Strings = (
            'Kaapelilukum'#228#228'r'#228
            'Korjauskerroin')
          ParentFont = False
          TabOrder = 4
          WordWrap = False
          Zoom = 100
        end
        object C_Redi3: TRichEdit
          Left = 250
          Top = 0
          Width = 40
          Height = 30
          Alignment = taCenter
          BorderStyle = bsNone
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Lines.Strings = (
            'Kuva')
          ParentFont = False
          TabOrder = 5
          WordWrap = False
          Zoom = 100
        end
      end
      object PitTstPan: TPanel
        Left = 0
        Top = 270
        Width = 185
        Height = 29
        BevelOuter = bvNone
        Caption = 'PitTstPan'
        Color = clRed
        TabOrder = 7
        Visible = False
      end
    end
  end
end
