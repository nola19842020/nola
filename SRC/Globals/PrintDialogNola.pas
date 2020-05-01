{
* Copyright (c) 2020, Reijo Pursiainen, Hannu Pursiainen
* All rights reserved.
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of Reijo Pursiainen, Hannu Pursiainen nor the
*       names of its contributors may be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY REIJO PURSIAINEN, HANNU PURSIAINEN AND
* CONTRIBUTORS ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
* BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
* A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL REIJO PURSIAINEN,
* HANNU PURSIAINEN AND CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
* INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
* LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}

unit PrintDialogNola;

{
     PrintDialogNola
     ===============

     DEVELOPER2 23.2.2002 versio 1.1

     Dialogi, jossa k‰ytt‰j‰ voi valita kirjoittimen. Sis‰lt‰‰
     tulostusrutiineja.
}

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Mask, LabelNola, Printers,WinSpool, ComboBoxXY,
  NolaForms, Settings, UITypes;

type
  TPrintMode      = (modeEdv, modeNj, modeSulake, modeA2, modeZS, modeBLANK);
  TPrintRangeNola = (rangeAllPages, rangePageNums, rangeHelpPages);

  TPrintDlgNola = class(TFormNola)
    OKBtn: TButton;
    CancelBtn: TButton;
    PrinterGroupBox: TGroupBox;
    CommentLabel: TLabelNola;
    PrinterLabel: TLabelNola;
    StatusLabel: TLabelNola;
    TypeLabel: TLabelNola;
    WhereLabel: TLabelNola;
    PrinterCombo: TComboBox;
    PropertiesBtn: TButton;
    StatusText: TLabelNola;
    TypeText: TLabelNola;
    WhereText: TLabelNola;
    CommentText: TLabelNola;
    CopiesGroupBox: TGroupBox;
    EdvRangeGroupBox: TGroupBox;
    EdvFromEdit: TMaskEdit;
    EdvToEdit: TMaskEdit;
    EdvAllBtn: TRadioButton;
    EdvRangeBtn: TRadioButton;
    EdvStartLabel: TLabel;
    EdvEndLabel: TLabel;
    CountEdit: TMaskEdit;
    CountLabel: TLabel;
    CollateCheckBox: TCheckBox;
    EdvOptionsGroupBox: TGroupBox;
    EdvAfterNewlineCheckBox: TCheckBox;
    EdvAfterNewPageCheckbox: TCheckBox;
    EdvTailCheckBox: TCheckBox;
    ZoomGroupBox: TGroupBox;
    ZoomComboBox: TComboBox;
    ZoomLabel: TLabel;
    EdvOpenCheckBox: TCheckBox;
    EdvHelpBtn: TRadioButton;
    EdvHeaderCheckBox: TCheckBox;
    SulakeRangeGroupBox: TGroupBox;
    SulakeAllBtn: TRadioButton;
    SulakeHelpBtn: TRadioButton;
    SulakeOptionsGroupBox: TGroupBox;
    SulakeHeaderCheckBox: TCheckBox;
    ZSRangeGroupBox: TGroupBox;
    ZSAllBtn: TRadioButton;
    ZSHelpBtn: TRadioButton;
    ZSOptionsGroupBox: TGroupBox;
    ZSHeaderCheckBox: TCheckBox;
    NJRangeGroupBox: TGroupBox;
    NJAllBtn: TRadioButton;
    NJHelpBtn: TRadioButton;
    NJOptionsGroupBox: TGroupBox;
    NJHeaderCheckBox: TCheckBox;
    PreviewBtn: TButton;
    TulSuuntaLb1: TLabelNola;
    TulSuuntaLb2: TLabelNola;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure PropertiesBtnClick(Sender: TObject);
    procedure PrinterComboChange(Sender: TObject);
    procedure RangeBtnClick(Sender: TObject);
    procedure AllBtnClick(Sender: TObject);
    procedure CountEditChange(Sender: TObject);
    procedure FromEditChange(Sender: TObject);
    procedure ToEditChange(Sender: TObject);
    procedure ZoomComboBoxChange(Sender: TObject);
    procedure EdvAfterNewlineCheckBoxClick(Sender: TObject);
    procedure EdvAfterNewPageCheckboxClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    RangeGroupBox:   TGroupBox;
    RangeBtn:        TRadioButton;
    AllBtn:          TRadioButton;
    HelpBtn:         TRadioButton;
    OptionsGroupBox: TGroupBox;
    HeaderCheckBox:  TCheckBox;
    form:            TFormNola;

    FPrintMode: TPrintMode;
    FFromPage: Integer;
    FToPage: Integer;
    FCollate: Boolean;
    FPrintRange: TPrintRangeNola;
    FMinPage: Integer;
    FMaxPage: Integer;
    procedure SetNumCopies(Value: Integer);
    procedure SetZoom(Value: Integer);
    procedure SetPrintHeader(Value: Boolean);
    procedure SetHAfterNP(Value: Boolean);
    procedure SetHAfterNL(Value: Boolean);
    procedure SetTailInRangePrint(Value: Boolean);
    procedure SetCollate(Value: Boolean);
    procedure SetOpenClosed(value: Boolean);
    procedure SetMaxPage(Value: integer);
    procedure SetMinPage(value: integer);
    procedure SetPrintMode(value: TPrintMode);
    function  GetNumCopies: integer;
    function  GetCollate: Boolean;
    function  GetZoom: Integer;
    function  GetPrintHeader: Boolean;
    function  GetHAfterNP: Boolean;
    function  GetHAfterNL: Boolean;
    function  GetTailInRangePrint: Boolean;
    function  GetOpenClosed: Boolean;

    procedure SetPrinterInfo;
    procedure SetRangeInfo;
    procedure SetCountInfo;

    function  GetPrinterHandle(printer: TPrinter): THandle;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

    function  Execute(amode: TPrintMode; form: TFormNola): Boolean;
    procedure SetProperties;
    procedure SetVisibles;

  published
    property PrintHeader: Boolean read GetPrintHeader write SetPrintHeader default False;
    property OpenClosed: Boolean read GetOpenClosed write SetOpenClosed default False;
    property Zoom: Integer read GetZoom write SetZoom default 100;
    property TailInRangePrint: Boolean read GetTailInRangePrint write SetTailInRangePrint default True;
    property HeaderAfterNewPage: Boolean read GetHAfterNP write SetHAfterNP default True;
    property HeaderAfterNewline: Boolean read GetHAfterNL write SetHAfterNL default True;
    property Collate: Boolean read GetCollate write SetCollate default False;
    property Copies: Integer read GetNumCopies write SetNumCopies default 1;
    property FromPage: Integer read FFromPage write FFromPage default 0;
    property MinPage: Integer read FMinPage write SetMinPage default 0;
    property MaxPage: Integer read FMaxPage write SetMaxPage default 0;
    property PrintRange: TPrintRangeNola read FPrintRange write FPrintRange default rangeAllPages;
    property ToPage: Integer read FToPage write FToPage default 0;
    property Mode: TPrintMode read FPrintMode write SetPrintMode default modeEdv;
  end;


  { Tulostaa otsikkon paperin yl‰reunaan }
  function PrintHeader(owner: TWinControl; canvas: TCanvas;
                       width: integer; leftMargin, topMargin: integer;
                       afileName: string; apage: integer; adate: TDateTime; atime: TDateTime;
                       zoom: integer; mult: real; printExtra: BOOLEAN): integer;

  { Tulostavat controllin ja sen lapset annettuun canvaasiin printtausta verten.
    Mik‰li controllin tag-muuttujan bitti PRINT_DISABLED on p‰‰ll‰ ei controllia tulosteta
    vaan sen tilalla on tyhj‰ paneeli joka on PRINT_BG_COLOR v‰rinen }
  procedure PrintControl(control: TControl; left, top: integer; canvas: TCanvas;
                         bgColor: TColor; useBgColor: boolean; pageWidth: integer);
  function PrintControlEx(control: TWinControl; left, top: integer; canvas: TCanvas;
                         zoom: real; bgColor: TColor; useBgColor: boolean; pageWidth: integer): integer;

  { Palauttaa annetusta prosenttimerkkijonosta (esim '99%') lukuarvon. Mik‰li
    merkkijono on virheellinen palautetaan zoomInError }
  function GetPros(zoomInString: string; zoomInError: integer): integer;

  { Tarkistaa onko tulostuksen zoomauskerroin oikein. Mik‰li arvo ei ole oikea palautetaan ylin
    tai alin arvo. }
  function CheckPrintZoom(zoom: integer): integer;

var
  PrintDlgNola: TPrintDlgNola;

implementation
uses
    globals, defs, TextBaseTexts, StringGridNola, PrintPreview, Asetus,Y_{+6.0.4 AsetusFrm.Haltija,Demo};

{$R *.DFM}

constructor TPrintDlgNola.Create(AOwner: TComponent);
begin
  inherited;
  SetProperties;

  SulakeRangeGroupBox.top :=    EdvRangeGroupBox.Top;
  SulakeOptionsGroupBox.top :=  EdvOptionsGroupBox.Top;
  SulakeRangeGroupBox.left :=   EdvRangeGroupBox.left;
  SulakeOptionsGroupBox.left := EdvOptionsGroupBox.left;

  ZSRangeGroupBox.top :=    EdvRangeGroupBox.Top;
  ZSOptionsGroupBox.top :=  EdvOptionsGroupBox.Top;
  ZSRangeGroupBox.left :=   EdvRangeGroupBox.left;
  ZSOptionsGroupBox.left := EdvOptionsGroupBox.left;

  NJRangeGroupBox.top :=    EdvRangeGroupBox.Top;
  NJOptionsGroupBox.top :=  EdvOptionsGroupBox.Top;
  NJRangeGroupBox.left :=   EdvRangeGroupBox.left;
  NJOptionsGroupBox.left := EdvOptionsGroupBox.left;
end;

{ **********************************************************
   Asetetaan ikkunan asetukset

   DEVELOPER2 28.12.1997
  ********************************************************** }
procedure TPrintDlgNola.SetProperties;
var
   tmpList: TStringList;
   x: integer;
begin
    try
       SetVisibles;

       { Laitetaan mahdolliset printterit n‰kyviin }
       tmpList := TStringList.Create;

        for x := 0 to  printer.Printers.count - 1 do
             tmpList.AddObject(printer.Printers[x], TObject(x));

        tmpList.Sort;
        PrinterCombo.Items :=     tmpList;
        PrinterCombo.ItemIndex := tmpList.IndexOfObject(TObject(printer.PrinterIndex));
        tmpList.Free;
        OKBtn.enabled := true;
        PropertiesBtn.enabled := true;

        SetPrinterInfo;
        SetRangeInfo;
        SetCountInfo;
     except
           OKBtn.enabled := false;
           PropertiesBtn.enabled := false;
     end;
end;

procedure TPrintDlgNola.SetVisibles;
begin
     ZoomGroupBox.visible :=          False;
     EdvRangeGroupBox.visible :=      False;
     EdvOptionsGroupBox.visible :=    False;
     SulakeRangeGroupBox.visible :=   False;
     SulakeOptionsGroupBox.visible := False;
     ZSRangeGroupBox.visible :=       False;
     ZSOptionsGroupBox.visible :=     False;
     NJRangeGroupBox.visible :=       False;
     NJOptionsGroupBox.visible :=     False;

     { Defaultit }
     OptionsGroupBox := EdvOptionsGroupBox;
     HeaderCheckBox :=  EdvHeaderCheckBox;
     HelpBtn :=         EdvHelpBtn;
     AllBtn :=          EdvAllBtn;
     RangeBtn :=        EdvRangeBtn;

     case Mode of
     modeEdv:     begin
                       RangeGroupBox :=   EdvRangeGroupBox;
                       RangeBtn :=        EdvRangeBtn;
                       AllBtn :=          EdvAllBtn;
                       HelpBtn :=         EdvHelpBtn;
                       OptionsGroupBox := EdvOptionsGroupBox;

                       RangeGroupBox.visible :=   True;
                       OptionsGroupBox.visible := True;
                       ZoomGroupBox.Visible :=    True;
                  end;

     modeSulake:  begin
                       RangeGroupBox :=   SulakeRangeGroupBox;
                       AllBtn :=          SulakeAllBtn;
                       HelpBtn :=         SulakeHelpBtn;
                       OptionsGroupBox := SulakeOptionsGroupBox;
                       HeaderCheckBox :=  SulakeHeaderCheckBox;

                       RangeGroupBox.visible :=   True;
                       OptionsGroupBox.visible := True;
                       ZoomGroupBox.Visible :=    True;
                  end;

     modeZS:  begin
                       RangeGroupBox :=   ZSRangeGroupBox;
                       AllBtn :=          ZSAllBtn;
                       HelpBtn :=         ZSHelpBtn;
                       OptionsGroupBox := ZSOptionsGroupBox;
                       HeaderCheckBox :=  ZSHeaderCheckBox;

                       RangeGroupBox.visible :=   True;
                       OptionsGroupBox.visible := True;
                       ZoomGroupBox.Visible :=    True;
                  end;

     modeNJ:  begin
                       RangeGroupBox :=   NJRangeGroupBox;
                       AllBtn :=          NJAllBtn;
                       HelpBtn :=         NJHelpBtn;
                       OptionsGroupBox := NJOptionsGroupBox;
                       HeaderCheckBox :=  NJHeaderCheckBox;

                       RangeGroupBox.visible :=   True;
                       OptionsGroupBox.visible := True;
                       ZoomGroupBox.Visible :=    True;
                  end;

     modeBLANK:  begin
                       RangeGroupBox.visible :=   False;
                       OptionsGroupBox.visible := False;
                       ZoomGroupBox.Visible :=    True;
                  end;

     modeA2:  begin
              end;
     end;
end;

function  TPrintDlgNola.Execute(amode: TPrintMode; form: TFormNola): Boolean;
begin
     mode := amode;
     self.form := form;

     printRange := rangeAllPages;
     SetProperties;

     if ShowModal = mrOK then
     begin
        result := True;

        case mode of
        modeEdv: begin
                      Collate := CollateCheckBox.Checked ;
                      HeaderAfterNewline := EdvAfterNewlineCheckBox.Checked;
                      HeaderAfterNewpage := EdvAfterNewpageCheckBox.Checked;
                      TailInRangePrint :=   EdvTailCheckBox.Checked;
                      OpenClosed :=         EdvOpenCheckBox.Checked;
                      PrintHeader :=        HeaderCheckBox.Checked;
                 end;

        modeSulake: begin
                      Collate :=            CollateCheckBox.Checked;
                      PrintHeader :=        HeaderCheckBox.Checked;
                    end;

        modeZS: begin
                      Collate :=            CollateCheckBox.Checked;
                      PrintHeader :=        HeaderCheckBox.Checked;
                end;

        modeNJ: begin
                      Collate :=            CollateCheckBox.Checked;
                      PrintHeader :=        HeaderCheckBox.Checked;
                    end;

        modeA2: begin
                      Collate :=            CollateCheckBox.Checked;
                    end;
        end;

        printer.printerIndex := Integer(PrinterCombo.Items.Objects[PrinterCombo.ItemIndex]);
     end
     else
         result := False;
end;

procedure TPrintDlgNola.OKBtnClick(Sender: TObject);
begin
     printer.PrinterIndex := PrinterCombo.ItemIndex;
     ModalResult := mrOK;
end;

procedure TPrintDlgNola.CancelBtnClick(Sender: TObject);
begin
     ModalResult := mrCancel;
end;

function TPrintDlgNola.GetPrinterHandle(printer: TPrinter): THandle;
var
  Device, Driver, Port: array[0..255] of char;
  hDeviceMode: THandle;
begin
  Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
  if not OpenPrinter(Device, Result, nil) then
    RaiseLastOSError;
end;

procedure TPrintDlgNola.PropertiesBtnClick(Sender: TObject);
var
   index: integer;
   ADevice, ADriver, APort: array [0..255] of WideChar;
   Mode: THandle;
   PMode: PDeviceModeW;
begin
     index := printer.printerIndex;
     printer.printerIndex := Integer(PrinterCombo.Items.Objects[PrinterCombo.ItemIndex]);
     printer.GetPrinter (@ADevice, @ADriver, @APort, mode);
     PMode := GlobalLock(mode);                                                           //,Dlg: Portrait/Landscape.
     DocumentProperties(self.handle, GetPrinterHandle(printer), @ADevice, PMode^, PMode^,
                                     DM_IN_BUFFER or DM_IN_PROMPT or DM_OUT_BUFFER);
   //Printer.Orientation := poLandscape;
     VaakaPysty := Printer.Orientation=poLandscape;
     fKESKEN('PrntDlg');                         //<''+120.6 koe

     Copies := Pmode^.dmCopies;

     GlobalUnLock(mode);
     printer.printerIndex := index;

     SetPrinterInfo;
     SetRangeInfo;
end;

procedure TPrintDlgNola.SetPrinterInfo;
var
   index: integer;
   APrinter, tmp: THandle;
   ADevice, ADriver, APort: array [0..255] of Char;
   PPrinterInfo: PPrinterInfo2;
   needed: DWORD;
begin
     try
        index := printer.printerIndex;
        printer.printerIndex := Integer(PrinterCombo.Items.Objects[PrinterCombo.ItemIndex]);
      //printer.printerIndex := {Integer(PrinterCombo.Items.Objects[}PrinterCombo.ItemIndex; //<,120+.6 kokeilua
        printer.GetPrinter (@ADevice, @ADriver, @APort, tmp);
        OpenPrinter(@ADevice, APrinter,  nil);

        PPrinterInfo := nil;
        GetPrinter(aPrinter, 2, PPrinterInfo, 0, @needed);
        GetMem(PPrinterInfo, needed);

        if (GetPrinter(aPrinter, 2, PPrinterInfo, needed, @needed) = FALSE) then
           StatusText.caption := 'Virhe';

        CommentText.caption := PPrinterInfo^.pComment;
        TypeText.caption :=    PPrinterInfo^.pDriverName;
        WhereText.caption :=   PPrinterInfo^.pPortName;

        case PPrinterInfo^.Status of
          PRINTER_STATUS_BUSY:                StatusText.caption := myTextBase.Get(PRINTER_STATUS_BUSY_TEXT);
          PRINTER_STATUS_DOOR_OPEN:           StatusText.caption := myTextBase.Get(PRINTER_STATUS_DOOR_OPEN_TEXT);
          PRINTER_STATUS_ERROR:               StatusText.caption := myTextBase.Get(PRINTER_STATUS_ERROR_TEXT);
          PRINTER_STATUS_INITIALIZING:        StatusText.caption := myTextBase.Get(PRINTER_STATUS_INITIALIZING_TEXT);
          PRINTER_STATUS_IO_ACTIVE :          StatusText.caption := myTextBase.Get(PRINTER_STATUS_IO_ACTIVE_TEXT);
          PRINTER_STATUS_MANUAL_FEED:         StatusText.caption := myTextBase.Get(PRINTER_STATUS_MANUAL_FEED_TEXT);
          PRINTER_STATUS_NO_TONER:            StatusText.caption := myTextBase.Get(PRINTER_STATUS_NO_TONER_TEXT);
          PRINTER_STATUS_NOT_AVAILABLE:       StatusText.caption := myTextBase.Get(PRINTER_STATUS_NOT_AVAILABLE_TEXT);
          PRINTER_STATUS_OFFLINE:             StatusText.caption := myTextBase.Get(PRINTER_STATUS_OFFLINE_TEXT);
          PRINTER_STATUS_OUT_OF_MEMORY:       StatusText.caption := myTextBase.Get(PRINTER_STATUS_OUT_OF_MEMORY_TEXT);
          PRINTER_STATUS_OUTPUT_BIN_FULL:     StatusText.caption := myTextBase.Get(PRINTER_STATUS_OUTPUT_BIN_FULL_TEXT);
          PRINTER_STATUS_PAGE_PUNT:           StatusText.caption := myTextBase.Get(PRINTER_STATUS_PAGE_PUNT_TEXT);
          PRINTER_STATUS_PAPER_JAM:           StatusText.caption := myTextBase.Get(PRINTER_STATUS_PAPER_JAM_TEXT);
          PRINTER_STATUS_PAPER_OUT:           StatusText.caption := myTextBase.Get(PRINTER_STATUS_PAPER_OUT_TEXT);
          PRINTER_STATUS_PAPER_PROBLEM:       StatusText.caption := myTextBase.Get(PRINTER_STATUS_PAPER_PROBLEM_TEXT);
          PRINTER_STATUS_PAUSED:              StatusText.caption := myTextBase.Get(PRINTER_STATUS_PAUSED_TEXT);
          PRINTER_STATUS_PENDING_DELETION:    StatusText.caption := myTextBase.Get(PRINTER_STATUS_PENDING_DELETION_TEXT);
          PRINTER_STATUS_PRINTING:            StatusText.caption := myTextBase.Get(PRINTER_STATUS_PRINTING_TEXT);
          PRINTER_STATUS_PROCESSING:          StatusText.caption := myTextBase.Get(PRINTER_STATUS_PROCESSING_TEXT);
          PRINTER_STATUS_TONER_LOW:           StatusText.caption := myTextBase.Get(PRINTER_STATUS_TONER_LOW_TEXT);
          PRINTER_STATUS_USER_INTERVENTION:   StatusText.caption := myTextBase.Get(PRINTER_STATUS_USER_INTERVENTION_TEXT);
          PRINTER_STATUS_WAITING:             StatusText.caption := myTextBase.Get(PRINTER_STATUS_WAITING_TEXT);
          PRINTER_STATUS_WARMING_UP:          StatusText.caption := myTextBase.Get(PRINTER_STATUS_WARMING_UP_TEXT);
      else
          StatusText.caption := myTextBase.Get(PRINTER_STATUS_FREE_TEXT);
      end;

      ClosePrinter(aPrinter);
      FreeMem(PPrinterInfo);

      printer.printerIndex := index;
     except
        CommentText.caption := '';
        TypeText.caption :=    '';
        WhereText.caption :=   '';
        StatusText.caption :=  '';

     end;
end;

procedure TPrintDlgNola.SetRangeInfo;
begin
     case PrintRange of
          rangeAllPages: AllBtnClick(self);
          rangePageNums: RangeBtnClick(self);
          rangeHelpPages:HelpBtnClick(self);
     end;

     zoom := CheckPrintZoom(zoom);

     ZoomComboBox.text := IntToStr(Zoom) +
                          myTextBase.Get(SYMBOLI_PROSENTTI);

     case Mode of
     modeEdv: begin
                   CollateCheckBox.Checked := Collate;
                   EdvAfterNewlineCheckBox.Checked := HeaderAfterNewline;
                   EdvAfterNewpageCheckBox.Checked := HeaderAfterNewpage;
                   EdvTailCheckBox.Checked :=         TailInRangePrint;
                   EdvOpenCheckBox.Checked :=         OpenClosed;
                   HeaderCheckBox.Checked :=          PrintHeader;

                   if (EdvAfterNewLineCheckBox.Checked = True) then
                      EdvAfterNewPageCheckBox.Checked := True;

                   if (EdvAfterNewPageCheckBox.Checked = False) then
                      EdvAfterNewLineCheckBox.Checked := False;
             end;

     modeSulake: begin
                   CollateCheckBox.Checked :=      Collate;
                   SulakeHeaderCheckBox.Checked := PrintHeader;
             end;

     modeZS: begin
                   CollateCheckBox.Checked := Collate;
                   HeaderCheckBox.Checked :=  PrintHeader;
             end;

     modeNJ: begin
                   CollateCheckBox.Checked := Collate;
                   HeaderCheckBox.Checked :=  PrintHeader;
             end;

     modeA2: begin
                   CollateCheckBox.Checked := Collate;
             end;
     end;
end;

procedure TPrintDlgNola.SetCountInfo;
begin
     try
        CollateCheckBox.checked := collate;
        CountEdit.Text :=          IntToStr(Copies);

        if (mode = modeEdv) then
        begin
             if (frompage > topage) then
                topage := frompage;

             if (frompage > maxpage) then
                frompage := maxpage;

             if (frompage < minpage) then
                frompage := minpage;

             if (topage < frompage) then
                frompage := topage;

             if (topage > maxpage) then
                topage := maxpage;

             if (topage < minpage) then
                topage := minpage;

             EdvFromEdit.Text := IntToStr(frompage);
             EdvToEdit.Text :=   IntToStr(topage);
        end;
     except
     end;
end;


procedure TPrintDlgNola.SetNumCopies(Value: Integer);
begin
     printer.Copies := value;
     SetCountInfo;
end;

procedure TPrintDlgNola.SetCollate(Value: Boolean);
var
   index: integer;
   mode: THandle;
   ADevice, ADriver, APort: array [0..255] of Char;
   PMode: PDeviceModeA;
begin
     index := printer.printerIndex;
     printer.printerIndex := Integer(PrinterCombo.Items.Objects[PrinterCombo.ItemIndex]);
     printer.GetPrinter (@ADevice, @ADriver, @APort, mode);
     PMode := GlobalLock(mode);

     if (value = True) then
        PMode^.dmCollate := DMCOLLATE_TRUE
     else
         PMode^.dmCollate := DMCOLLATE_FALSE;

     // DocumentProperties(self.handle, printer.printerHandle, @ADevice, PMode^, PMode^, DM_IN_BUFFER);

     GlobalUnLock(mode);
     printer.printerIndex := index;

     FCollate := value;
     SetCountInfo;
end;

procedure TPrintDlgNola.SetHAfterNP(Value: Boolean);
begin
     myRegSettings.SetBooleanValue(SETTINGS_USED, PRINT_WINDOW_AFTER_NEWPAGE, value);
end;

procedure TPrintDlgNola.SetHAfterNL(Value: Boolean);
begin
     myRegSettings.SetBooleanValue(SETTINGS_USED, PRINT_WINDOW_AFTER_NEWLINE, value);
end;

procedure TPrintDlgNola.SetTailInRangePrint(Value: Boolean);
begin
     myRegSettings.SetBooleanValue(SETTINGS_USED, PRINT_WINDOW_TAIL, value);
end;

procedure TPrintDlgNola.SetZoom(Value: integer);
begin
     case mode of
     modeEdv:     myRegSettings.SetIntegerValue(SETTINGS_USED, PRINT_WINDOW_ZOOM_EDV, value);
     modeNJ:      myRegSettings.SetIntegerValue(SETTINGS_USED, PRINT_WINDOW_ZOOM_NJ, value);
     modeSulake:  myRegSettings.SetIntegerValue(SETTINGS_USED, PRINT_WINDOW_ZOOM_SULAKE, value);
     modeZS:      myRegSettings.SetIntegerValue(SETTINGS_USED, PRINT_WINDOW_ZOOM_ZS, value);
     end;
end;

procedure TPrintDlgNola.SetMinPage(Value: integer);
begin
     FMinPage := value;
     SetCountInfo;
end;

procedure TPrintDlgNola.SetMaxPage(Value: integer);
begin
     FMaxPage := value;
     SetCountInfo;
end;

procedure TPrintDlgNola.SetPrintMode(Value: TPrintMode);
begin
     FPrintMode := value;
     SetProperties;
end;

procedure TPrintDlgNola.SetOpenClosed(value: Boolean);
begin
     myRegSettings.SetBooleanValue(SETTINGS_USED, PRINT_WINDOW_OPEN_CLOSED, value);
end;

procedure TPrintDlgNola.SetPrintHeader(value: Boolean);
begin
     myRegSettings.SetBooleanValue(SETTINGS_USED, PRINT_WINDOW_PRINT_HEADER, value);
end;

function  TPrintDlgNola.GetPrintHeader: Boolean;
begin
     result := myRegSettings.AutoGetBooleanValue(PRINT_WINDOW_PRINT_HEADER, True);
end;

function  TPrintDlgNola.GetOpenClosed: Boolean;
begin
     result := myRegSettings.AutoGetBooleanValue(PRINT_WINDOW_OPEN_CLOSED, True);
end;

function  TPrintDlgNola.GetZoom: Integer;
begin
     case mode of
     modeEdv:     result := myRegSettings.AutoGetIntegerValue(PRINT_WINDOW_ZOOM_EDV,    100);
     modeSulake:  result := myRegSettings.AutoGetIntegerValue(PRINT_WINDOW_ZOOM_SULAKE, 100);
     modeZS:      result := myRegSettings.AutoGetIntegerValue(PRINT_WINDOW_ZOOM_ZS,     100);
     modeNJ:      result := myRegSettings.AutoGetIntegerValue(PRINT_WINDOW_ZOOM_NJ,     100);
     else
         result := 100;
     end;
end;

function  TPrintDlgNola.GetHAfterNP: Boolean;
begin
     result := myRegSettings.AutoGetBooleanValue(PRINT_WINDOW_AFTER_NEWPAGE, TRUE);
end;

function  TPrintDlgNola.GetHAfterNL: Boolean;
begin
     result := myRegSettings.AutoGetBooleanValue(PRINT_WINDOW_AFTER_NEWLINE, TRUE);
end;

function  TPrintDlgNola.GetTailInRangePrint: Boolean;
begin
     result := myRegSettings.AutoGetBooleanValue(PRINT_WINDOW_TAIL, TRUE);
end;

function  TPrintDlgNola.GetNumCopies: integer;
begin
     result := printer.Copies;
end;

function  TPrintDlgNola.GetCollate: Boolean;
begin
     result := FCollate;
end;

procedure TPrintDlgNola.PrinterComboChange(Sender: TObject);
begin
     SetPrinterInfo;
     SetRangeInfo;
end;

procedure TPrintDlgNola.RangeBtnClick(Sender: TObject); //<"Alue" -EdvRangeGrouBox/Alimmainen alekkaisista TRadioBtn "Johdot" 120.6(kommntti)
begin
     EdvStartLabel.Enabled := True;
     EdvEndLabel.Enabled :=   True;
     EdvFromEdit.Enabled :=   True;
     EdvToEdit.Enabled :=     True;
     PrintRange :=            rangePageNums;

     EdvAfterNewPageCheckbox.enabled := True;
     EdvAfterNewLineCheckbox.enabled := True;
     EdvTailCheckBox.enabled := True;
     EdvOpenCheckBox.enabled := True;
     ZoomLabel.enabled :=       True;
     ZoomComboBox.enabled :=    True;

     OptionsGroupBox.Enabled := True;
     HeaderCheckBox.enabled :=  True;
     HelpBtn.Checked :=         False;
     AllBtn.Checked :=          False;
     RangeBtn.Checked :=        True;
end;

procedure TPrintDlgNola.AllBtnClick(Sender: TObject); //<"Alue" -EdvRangeGrouBox/Keskimm‰inen alekkaisista TRadioBtn "Kaikki ..johdot" 120.6(kommntti)
begin
     EdvStartLabel.Enabled := False;
     EdvEndLabel.Enabled :=   False;
     EdvFromEdit.Enabled :=   False;
     EdvToEdit.Enabled :=     False;
     PrintRange := rangeAllPages;
     ZoomGroupBox.Enabled :=  True;

     EdvAfterNewPageCheckbox.enabled := True;
     EdvAfterNewLineCheckbox.enabled := True;
     EdvTailCheckBox.enabled := True;
     EdvOpenCheckBox.enabled := True;
     ZoomLabel.enabled :=       True;
     ZoomComboBox.enabled :=    True;

     OptionsGroupBox.Enabled := True;
     HeaderCheckBox.enabled :=  True;
     HelpBtn.Checked :=  False;
     AllBtn.Checked :=   True;
     RangeBtn.Checked := False;
end;

procedure TPrintDlgNola.CountEditChange(Sender: TObject);
begin
     copies := StrToIntDef(countEdit.text, copies);
     SetCountInfo;
end;

procedure TPrintDlgNola.FromEditChange(Sender: TObject);
begin
     frompage := StrToIntDef(EdvfromEdit.text, frompage);
     SetCountInfo;
end;

procedure TPrintDlgNola.ToEditChange(Sender: TObject);
begin
     topage := StrToIntDef(EdvtoEdit.text, topage);
     SetCountInfo;
end;

procedure TPrintDlgNola.ZoomComboBoxChange(Sender: TObject);
begin
     zoom := GetPros(ZoomComboBox.text, zoom);
     SetRangeInfo;
end;

procedure TPrintDlgNola.EdvAfterNewlineCheckBoxClick(Sender: TObject);
begin
     if (EdvAfterNewLineCheckBox.Checked = True) then
        EdvAfterNewPageCheckBox.Checked := True;
end;

procedure TPrintDlgNola.EdvAfterNewPageCheckboxClick(Sender: TObject);
begin
     if (EdvAfterNewPageCheckBox.Checked = False) then
        EdvAfterNewLineCheckBox.Checked := False;
end;

procedure TPrintDlgNola.HelpBtnClick(Sender: TObject);
begin
     EdvStartLabel.Enabled := False;
     EdvEndLabel.Enabled := False;
     EdvFromEdit.Enabled := False;
     EdvToEdit.Enabled :=   False;
     PrintRange := rangeHelpPages;

     ZoomGroupBox.Enabled := False;

     EdvAfterNewPageCheckbox.enabled := False;
     EdvAfterNewLineCheckbox.enabled := False;
     EdvTailCheckBox.enabled := False;
     EdvOpenCheckBox.enabled := False;
     ZoomLabel.enabled :=       False;
     ZoomComboBox.enabled :=    False;

     OptionsGroupBox.Enabled := False;
     HeaderCheckBox.enabled :=  False;
     HelpBtn.Checked :=         True;
     AllBtn.Checked :=          False;
     RangeBtn.Checked :=        False;
end;


{ Tulostetaan otsikkotiedot p‰iv‰ys yms }
function PrintHeader(owner: TWinControl; canvas: TCanvas;
                     width: integer; leftMargin, topMargin: integer;
                     afileName: string; apage: integer; adate: TDateTime; atime: TDateTime;
                     zoom: integer; mult: real; printExtra: BOOLEAN): integer;
var
   otsikkoMetaFile: TMetafile;
   otsikkoCanvas:   TMetaFileCanvas;
   panel: TPanel;
   filename, paivays, page,Copyright,Haltija{+6.0.4}: TLabelNola;
   suurin, border: integer;
   tmpdate,ss{+6.0.4}: string;
   rect: TRect;
begin
     { Tehd‰‰n otsikko }
     mult := mult / (zoom / 100);
     tmpdate := FormatDateTime('dd/mm/yyyy', adate) + ' ' + FormatDateTime('hh:nn:ss', atime);

     panel := TPanel.Create(nil);
     panel.top :=     0;
     panel.left :=    0;
     panel.visible := False;
     panel.parent :=  owner;
     panel.Height :=  200;
     panel.width :=   Trunc((width  - leftMargin) / mult);
     panel.BevelInner := bvNone;
     panel.BevelOuter := bvNone;
     panel.Color :=      clWhite;
     panel.caption :=    '';

     Copyright :=          TLabelNola.Create(panel);
     Copyright.parent :=   panel;
     Copyright.autosize := TRUE;

     Haltija :=          TLabelNola.Create(panel); //<,,Haltija +6.0.4
     Haltija.parent :=   panel;
     Haltija.autosize := TRUE;
     ss := Trim (AsetusFrm.Haltija); //myRegSettings.AutoGetStringValue(ASETUS_HALTIJA, '');
     if demo(51) //demoLisAs                    //<demoLisAs = Demoversio eik‰ lisenssi‰ asennettu
        then ss := 'ESITTELYVERSIO.'
        else ss := 'K‰yttˆoikeus:  ' +ss;
     Haltija.Caption := '<b>' +ss +'</b>';

     fileName := TLabelNola.Create(panel);
     fileName.parent := panel;
     fileName.autosize := TRUE;

     paivays := TLabelNola.Create(panel);
     paivays.parent := panel;
     paivays.autosize := TRUE;

     page := TLabelNola.Create(panel);
     page.parent := panel;
     page.autosize := TRUE;

   //Copyright.Caption := STYLE_BOLD_BEGIN + PROGRAM_NAME_LONG + STYLE_BOLD_END;  //<, 4.0.0 DEVELOPER1
     Copyright.Caption := STYLE_BOLD_BEGIN + PROGRAM_NAME_LONG +
                          '.   Ver '+IntToStr (PROGRAM_VERSION_MAJOR)   +'.' +
                                     IntToStr (PROGRAM_VERSION_MINOR)   +'.' +
                                     IntToStr (PROGRAM_VERSION_RELEASE) +' '+
{$IFNDEF NOLALIS}
                                     LisLaajToStr (myLicense.lisenssilaajuus,0) +'  '+
{$ENDIF NOLALIS}
                                     PROGRAM_BUILD_DATE +
                         {'   <u>HUOM: Ik3v...d laskentapistemuutos ver. ' +FONT_SUURPI +'6.0.0</u>' +
                          STYLE_BOLD_END;}
                          '   <u>HUOM: Riveill‰ '+FONT_SUURPI +' 31 (Ik)laskentapistemuutos '+ FONT_SUURPI +
                          '6.2.19, johtojen kuormit. 10.0.1</u>' +STYLE_BOLD_END;

     if (printExtra) then
     begin
          if (afileName <> '') then
             Filename.caption := STYLE_BOLD_BEGIN +
                            afilename +
                            STYLE_BOLD_END + ' ';

          paivays.caption := tmpdate;
     end;

     page.caption := STYLE_BOLD_BEGIN +
                            myTextBase.Get(PRINT_PAGE) +
                            STYLE_BOLD_END + ' ' + inttostr(apage);

     border :=        3;
     copyright.top := border;
     page.top :=      border;

     Haltija.top := copyright.top + copyright.height; //<+6.0.4

     fileName.top :=  Haltija.top + Haltija.height;
     paivays.top :=   fileName.top;

     fileName.left :=  border;
     copyright.left := filename.left;
     Haltija.left :=   filename.left;                //+6.0.4
     page.left :=      panel.width - page.width - border;
     paivays.left :=   panel.width - paivays.width - border;

     suurin := copyright.top + copyright.height + Haltija.height;
     if (page.top + page.height > suurin)       then
        suurin := page.top + page.height;

     if (printExtra) then
     begin
          if (filename.top + filename.height > suurin)  then
             suurin := filename.top + filename.height;
          if (paivays.top + paivays.height > suurin)    then
             suurin := paivays.top + paivays.height;
     end;

     panel.height:= suurin + 2;

     { Tulostetaan otsikko }
     otsikkoMetafile := TMetafile.Create;
     otsikkoCanvas :=   TMetafileCanvas.Create(otsikkometafile, 0);
     panel.PaintTo(otsikkoCanvas.handle, 0,0);

     { Tulostetaan ymp‰rˆiv‰ boxi}
     rect := panel.BoundsRect;
     otsikkocanvas.brush.color := clBlack;
     otsikkocanvas.FrameRect(rect);
     otsikkoCanvas.free;

     otsikkoMetafile.MMHeight := Trunc(mult * otsikkoMetafile.MMHeight + 0.5); //<,fKESKEN
     otsikkoMetafile.MMWidth :=  Trunc(mult * otsikkoMetafile.MMWidth + 0.5);{
     otsikkoMetafile.MMHeight := mmH1500(Trunc(mult * otsikkoMetafile.MMHeight + 0.5));
     otsikkoMetafile.MMWidth :=  mmW2000(Trunc(mult * otsikkoMetafile.MMWidth + 0.5));}

     if (suurin > 0) then
        canvas.Draw(leftMargin, topMargin, otsikkoMetafile);

     otsikkoMetafile.free;
     panel.free;

     if (suurin > 0) then
        result := Trunc(mult * (panel.height + 1) + 0.5)
     else
        result := 0;
end;

procedure PrintControl(control: TControl; left, top: integer; canvas: TCanvas; bgColor: TColor; useBgColor: boolean; pageWidth: integer);
var
   tmpLabel: TLabelNola;
   x: integer;
   btn: TPanel;
   src: TButton;
   rect, srcRect: TRect;
   grid: TStringGridNola;
   over: integer;
   c: TControl;
begin
     rect.Left :=   left;
     rect.top :=    top;
     rect.Right:=   rect.Left + control.width;
     rect.bottom := rect.top + control.height;

     if (control.tag and PRINT_WIDTH_FIT_TO_PAGE) <> 0 then
     begin
          rect.Right := pageWidth;
     end;

     if (control.tag and PRINT_DISABLED) <> 0  then
     begin
         canvas.fillRect(rect);
     end
     else if ((control is TLabel) or
         (control is TLabelNola) or
         (control is TComboBox) or
         (control is TComboBoxXY) or
         (control is TMaskEdit)) then
     begin
          tmpLabel := TLabelNola.Create(nil);
          tmpLabel.visible := false;
          tmpLabel.Parent :=  control.parent;
          tmpLabel.Assign(control);

          if (useBgColor) then
             tmpLabel.color := bgColor;

          tmpLabel.PaintTo(canvas, left, top);
          tmpLabel.free();
     end
     else if (control is TStringGridNola) then
     begin
          { Luodaan v‰liaikainen grid }
          grid := TStringGridNola.Create(nil);
          grid.visible := false;
          grid.parent :=  control.parent;
          grid.Assign(control);
          if (useBgColor) then
          begin
               grid.FixedColor := bgcolor;
          end;
          grid.PaintTo(canvas.Handle, left, top);
          grid.Free();
     end
     else if (control is TButton) then
     begin
         src := TButton(control);
         { Luodaan v‰liaikainen panel }
          btn := TPanel.Create(nil);
          btn.visible :=     false;
          btn.parent :=      src.parent;
          btn.BevelOuter :=  bvNone;
          btn.BevelInner :=  bvNone;
          btn.BorderStyle := bsNone;

          { Kuvallisia buttonit peitet‰‰n muihin j‰tet‰‰n reunukset }
          if (src.brush.bitmap = nil) then
             btn.BorderStyle := bsSingle;

          btn.Ctl3D :=  false;
          btn.width :=  src.width;
          btn.height := src.Height;

          if (useBgColor) then
             btn.color := bgColor
          else
             btn.color := src.brush.color;
          btn.caption :=  src.caption;

          btn.PaintTo(canvas.handle, left, top);
          btn.free();
     end
     else if (control is TPanel) then
     begin
         if (not useBgColor) then
            bgColor := TPanel(control).color;

         canvas.pen.color :=   bgColor;
         canvas.brush.color := bgColor;
         canvas.fillRect(rect);
     end
     else if (control is TForm) then
     begin
         if (not useBgColor) then
            bgColor := TForm(control).color;

         canvas.pen.color :=   bgColor;
         canvas.brush.color := bgColor;
         canvas.fillRect(rect);
     end
     else if (control is TWinControl) then
     begin
         TWinControl(control).paintTo(canvas.handle, left, top);
     end
     else if (control is TImage) then
     begin
         srcRect.top :=    0;
         srcRect.left :=   0;
         srcRect.Right :=  control.width;
         srcRect.Bottom := control.Height;

         { Leikataan kuvasta pois se mit‰ ei tarvitse n‰ytt‰‰ }
         if (control.top  < 0) then
         begin
              srcRect.top := -control.top;
              rect.top :=    rect.top +  srcRect.top;
         end;
         if (control.left < 0) then
         begin
            srcRect.left := -control.left;
            rect.left :=    rect.left +  srcRect.left;
         end;

         over := (control.height + control.top) - control.parent.Height;
         if (over > 0) then
         begin
            srcRect.Bottom := control.top + control.Height - over;
            rect.bottom :=    rect.bottom - over;
         end;

        over := (control.width + control.left) - control.parent.width;
        if (over > 0) then
        begin
             srcRect.Right := control.left + control.width - over;
             rect.right :=    rect.right - over;
        end;

         canvas.CopyRect(rect, TImage(control).canvas, srcRect);
     end;

     if (control is TWinControl) and ((control.tag and PRINT_DISABLED) = 0) then
     begin
      for x:= 0 to TWinControl(control).ControlCount - 1 do
      begin
          c := TWinControl(control).Controls[x];
          if (c.visible = TRUE) then
          begin
               PrintControl(c, left + c.left, top + c.top, canvas, bgColor, useBgColor, pageWidth);
          end;
      end;
     end;

     if (control is TPanel) and ((control.tag and PRINT_DISABLED) = 0) then
     begin
         { Mik‰li paneeli on "korotettu" laitetaan ymp‰rille reunus }
         if ((TPanel(control).BorderStyle <> bsNone) and (TPanel(control).BorderWidth > 0)) or
            (TPanel(control).BevelInner <> bvNone) or
            (TPanel(control).BevelOuter <> bvNone) then
         begin
              canvas.pen.Width :=   TPanel(control).BorderWidth;
              canvas.brush.color := clBlack;
              canvas.FrameRect(rect);
         end;
     end;

     control.Refresh;   // DEVELOPER2 23.2.2002: Lis‰tty ksoka muutoin EdvNj:n kent‰t
                        // j‰‰v‰t p‰ivittym‰tt‰ oikein tulostuksen j‰lkeen. 
end;

function PrintControlEx(control: TWinControl; left, top: integer; canvas: TCanvas; zoom: real; bgColor: TColor; useBgColor: boolean; pageWidth: integer): integer;
var
   myMetaFile: TMetaFile;
   myCanvas: TCanvas;
   newWidth: integer;
begin
     control.Repaint;  // DEVELOPER2 13.08.1998, lis‰tty tulostuksen ongelmien takia

     if (zoom <> 1) then
     begin
         MyMetafile := TMetafile.Create;
         myCanvas :=   TMetafileCanvas.Create(mymetafile, 0);
         { Koska lopputulosta zoomataan on sivun leveytt‰ muutettava }
         newWIdth := Trunc(pageWidth / zoom);
         PrintControl(control, 0, 0, myCanvas, bgColor, useBgColor, newWidth);
         myCanvas.Free;

        myMetafile.MMHeight := Trunc(zoom * myMetafile.MMHeight + 0.5);
         myMetafile.MMWidth :=  Trunc(zoom * myMetafile.MMWidth + 0.5);{
         myMetafile.MMHeight := mmH1500(Trunc(zoom * myMetafile.MMHeight + 0.5)); //<,fKESKEN
         myMetafile.MMWidth :=  mmW2000(Trunc(zoom * myMetafile.MMWidth + 0.5));}

         canvas.Draw(left, top, myMetafile);

         myMetaFile.Free;
     end
     else
     begin
          PrintControl(control, left, top, canvas, bgColor, useBgColor, pageWidth);
     end;
     result := Trunc(zoom * control.height + 0.5);
end;


{ Palauttaa annetusta prosenttimerkkijonosta (esim '99%') lukuarvon. Mik‰li
  merkkijono on virheellinen palautetaan zoomInError }
function GetPros(zoomInString: string; zoomInError: integer): integer;
var
   pros: integer;
begin
     pros := Pos('%', zoomInString);

     if (pros <> 0) then
        Delete(zoomInString, pros, 1000);

     result := StrToIntDef(zoomInString, zoomInError);
end;


{ Tarkistaa onko zoomauskerroin oikein. Mik‰li arvo ei ole oikea palautetaan ylin
  tai alin arvo. }
function CheckPrintZoom(zoom: integer): integer;
begin
     result := zoom;
     if (zoom < PRINT_ZOOM_MIN)  then result := PRINT_ZOOM_MIN;
     if (zoom > PRINT_ZOOM_MAX) then  result := PRINT_ZOOM_MAX;
end;

procedure TPrintDlgNola.PreviewBtnClick(Sender: TObject);
begin
  inherited;
  if (PrintPreviewDlg.execute(zoom, form)) then
  begin
       zoom := PrintPreviewDlg.GetZoom;
       SetRangeInfo;
  end;
end;

procedure TPrintDlgNola.FormPaint(Sender: TObject);      begin//+7.0.3  FormShow korvattu
  inherited;
   if Printer.Orientation = poLandscape
   then TulSuuntaLb2.Caption := 'Vaaka (Landscape)'
   else TulSuuntaLb2.Caption := 'Pysty (Portrait)';
end;

end.
