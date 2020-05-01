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

unit Moot;
{Erikoismerkkejä:  ø155,Ø157,×158,ƒ159,ª166,º167,¿168,®169,¬170,½171,¼172,¡173,«174,»175,©184,¢189,
                   ß225,µ230,þ231,Þ232,¯238,±241,¾243,¶244,÷246,¸247,°248,¨·250,¹251,³252,²253}
{###################################################################################################
 ed. ~toimiva:  MootEu.PAS  = Ennen:   TopRow, LeftCol   VisibleRowCount, VisibleColCount käytöstä luopumista
 TOIMINTAPERIAATE:  Ks. NjVrk.PAS
 P O I K K E U S :  Cellien rivimääritys ei onaa suoraan Rv tai eRv :llä, koska OTSIKKOrivejä on 3,
                    kun NjVrk :ssa oli vain 1, joten KÄYTETTÄVÄ FNC fRow yms. -kutsuja, joka lisää
                    tarvittavat korjaukset (= +2 =Otsikkorivejä 2 enemmän kuin NjVrk :ssa) #########
###################################################################################################}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, NolaForms,
  Grids, StringGridNola, StdCtrls, ExtCtrls, ComboBoxXY, {FileCtrl,} ComCtrls,
  RichEditNola, {DEVELOPER1+}inifiles, Printers, LabelNola, PanelNola;

type
  TMoFrm = class(TFormNola)
    StrGr: TStringGridNola;
    PanelY: TPanelNola;
    PanelA: TPanelNola;
    SuljeBtn: TButton;
    LueBtn: TButton;
    TalBtn: TButton;
    TulostaBtn: TButton;
    OkBtn: TButton;
    PalautBtn: TButton;
    KopBtn: TButton;
    PoistaBtn: TButton;
    OhjeBtn: TButton;
    Lb6: TLabel;
    Bx1: TComboBoxXY;
    ChkBxAv: TCheckBox;
    PanelY1: TPanelNola;
    LbY1r1: TLabelNola;
    BxG: TComboBoxXY;
    aRich: TRichEditNola;
    SaveDialog1: TSaveDialog;
    LbY1r2: TLabelNola;
    LbA1: TLabelNola;
    LbY1r0: TLabelNola;
    EdiY1: TEdit;
    ChkDet: TCheckBox;
    LbUn: TLabelNola;
    OpenDialog1: TOpenDialog;
    UmCmBx: TComboBoxXY;
    PvBtn: TButton;
    LbPvita: TLabelNola;
    LbYo: TLabelNola;
    LbY1o: TLabelNola;
    LbY1o1: TLabelNola;
    LbY1o2: TLabelNola;
    LbY1o3: TLabelNola;
    VrkLb: TLabel;
    VrkCmBx: TComboBoxXY;
    TaajKaytLb: TLabel;
    ComboBox1: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure StrGrWidestColInRow(Sender: TObject; ACol, ARow, newWidth: Integer);
    procedure StrGrMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure OhjeBtnClick(Sender: TObject);
    procedure ChkBxAvClick(Sender: TObject);
    procedure LbY1r1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure LbY1r2MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure EdiY1Change(Sender: TObject);
    procedure LbY1r0MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure EdiY1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure SuljeBtnClick(Sender: TObject);
    procedure PoistaBtnClick(Sender: TObject);
    procedure PalautBtnClick(Sender: TObject);
    procedure KopBtnClick(Sender: TObject);
    procedure StrGrMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BxGKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure TulostaBtnClick(Sender: TObject);
    procedure LueBtnClick(Sender: TObject);
    procedure TalBtnClick(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure Bx1_6Enter(Sender: TObject);
    procedure Bx1_6Exit(Sender: TObject);
    procedure Bx1_6MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure StrGrTopLeftChanged(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure StrGrSelectCell(Sender: TObject; Col, Row: Integer;  var CanSelect: Boolean);
    procedure StrGrClick(Sender: TObject);
    procedure StrGrDblClick(Sender: TObject);
    procedure StrGrKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure BxGEnter(Sender: TObject);
    procedure ChkDetClick(Sender: TObject);
    procedure StrGrAfterPaint(Sender: TObject);
    procedure UmCmBxExit(Sender: TObject);
    procedure UmCmBxEnter(Sender: TObject);
    procedure PvBtnClick(Sender: TObject);
    procedure Bx1Change(Sender: TObject);
    procedure UmCmBxChange(Sender: TObject);
    procedure PanelAMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure ChkBxAvMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X,Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure TaajKaytLbMouseMove(Sender: TObject;  Shift: TShiftState;  X,Y: Integer);
    procedure TaajKaytLbClick(Sender: TObject);
    procedure TaajKaytLbDblClick(Sender: TObject);
    procedure BxGKeyPress(Sender: TObject; var Key: Char);
    procedure LbUnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure LbPvitaMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure PanelAMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);
    procedure BxGChange(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
    procedure PrintContent;
  end;

CONST                       //<,Jotta SyottoAv / Avuste + SyoKut tunnistaisi
      S_Pnap2='0.055;0.075;0.09;0.12;0.18;0.25;0.37;0.55;0.75;1.1;1.5;2.2;3.0;4.0;5.5;7.5;11;15;18.5;22;30;'+
              '37;45;55;75;90;110;132;160;200;250;315;355;400;450;500;560;630;710;800;900;1000;1120;1250';
      S_Pnap4=S_Pnap2+';1400';                   //'''6,8,10 ja 12-napaiset ovat identtisiä 2-napaisten kanssa
      MoKut=8;                                   //<Aikaisemmin kutsuissa oli 6, nyt 8 ja CONST´iksi +8.0.0
var
  DetWdth :integer{:120.5k};
  MoFrm: TMoFrm;
  motja,Mrv,eMrv :integer; //<Mrv=ao., ed.näpäytetty mootlähtörivi. SyoKut + SyoArvOK :n takia tässä
  MoFile  :TIniFile;
  MoFileCreated :string;
  procedure EditMoFrm;
  function LueTalMoFile (LUE,KYSY :boolean;  inFilen :string) :boolean;
                                                                    //'Tässä, jotta PaaVal tunnistaa
  FUNCTION fCos (P :Real;   napaN :Integer) :Real;                  //<MoFnc.INC  SyoKut.INCn takia
  FUNCTION fTim (kuormaON :Boolean;  P :Real;  Nap :Integer) :Real; //<MoFnc1.INC SyoKut.INCn takia
  function fPoiskAikaRajaMo :real;
  function fPoiskAikaRajaMoS :string;

implementation

uses SyottoAv, Defs, Globals, PaaVal, Y_, Herja1, Koe, PrintDialogNola, Unit0, textBaseTexts, MoDet, Progres,
     Odota, EdvNew{=asetaIecOfaRadVal takia},Unit1,InfoDlgUnit,{!20.5k:}DetEv{,Control};

{$R *.DFM}

CONST INmax =5000;  vCol=10;
var Sar,eSar, moVE :integer; //< vCol=Vika syöttosarake,  moVE=1:  sijoitus myös MOU :hun
    poista,kopioi, NytChkScrol,DblClck, BxGAuki :boolean;
    nopeus, {ChkTop,}selCOL,selROW :integer; //<Nopeus,ChkTop ehkä turhia, selCOL+Row := SelectCell:ssä
    MoF_filen,Mo0_filen{,_12.0.0} :string;   //< MoF_ = Filesta luettu  Mo0_= Istunnon alussa
    alpSft :real;  alpUm,alpVrk :integer;    //<Käytetään PäivitäBtn ilmaisuun.  alpVrk +6.0.3
    Gray_Chkd :boolean; //<+1.1.3 Vain PRC ChkBxAvMouseDown ja ChkBxAvClick väliseen tiedonsiirtoon ILMAN EVENTIÄ
    BxSar,BxMrv :integer;                    //< := OnEnter. Osoittaa, MISSÄ VIKAX OLLUT AUKI.  +4.0.0

        {procedure KoeNayArvot (ekaSar,rv :integer;  s :string);      VAR e,r :integer;     begin
            with MoFrm.StrGr  do begin
               for r := rv to rv+6  do
               for e := ekaSar to ekaSar+5  do Cells[e,r] := '';
               e := ekaSar;
               Cells[e,rv] := s;
               Cells[e+1,rv] := 's,r '   +fImrkt0 (Sar,1)      +',' +fImrkt0 (Mrv,1);
               Cells[e+2,rv] := 'Es,r ' +fImrkt0 (eSar,1)     +',' +fImrkt0 (eMrv,1);
               Cells[e+3,rv] := 'Ss,r ' +fImrkt0 (selCOL,1)   +',' +fImrkt0 (selROW,1);
               Cells[e+4,rv] := 'au '    +fBmrkt0 (BxGAuki,1);
               Cells[e+5,rv] := 'vi '    +fBmrkt0 (MoFrm.BxG.Visible,1);  end; end;}
       {procedure KoeNay (ohje :integer;  si :string);      VAR s :string;      begin      with MoFrm  do begin
           if ohje>0  then s := ''  else s := EdiY1.Text +' // ';
           s := s +si;
           EdiY1.Text := s;  end; end;}

FUNCTION det :boolean;        begin  Result := false;   if MoFrm.ChkDet.Checked  then Result := true;  end;
function fUmn :integer;       begin  Result := a_getIntg (100,mo.moty.Umo);  end;
function fUmv :real;          begin  Result := fUmn / Sqrt (3);              end; //,fUmh = +6.0.3
function fUmh :real;          begin  Result := fUmn;                         end; //<uh% -laskennan vrtlu helppo muuttaa.
//function fUmo :integer;       begin  result := fUo_ (fUmn);                  end;  -6.0.1b
function fPoiskAikaRajaMo :real;      begin  result := fPoiskAikaRaja_ (fUmn);          end;
function fPoiskAikaRajaMoS :string;   begin  result := fRmrkt0 (fPoiskAikaRajaMo,1,1);  end;

procedure BxGAukiVisOff;      begin //< +4.0.0  := TRUE  PRC OnBxGEnter´issä.  EI SAA KUTSUA ENNEN
   BxGAuki := false;                //  fEhkaTarkArv -kutsua, jotta BxGAuki SÄILYY #################
   MoFrm.BxG.Visible := false;  end;
procedure SijMouIfVE1;      begin //< +4.0.0
   if moVE=1  then mou := mo;  end;
function fUusRv_Vajaa :boolean;      VAR s :string;      begin //<,, +4.0.0
   result := false;
   s := MoFrm.StrGr.Cells[MoFrm.StrGr.FixedCols, MoFrm.StrGr.FixedRows +motja]; //< 1x ohi vikan arvoRvn
 //s := TagVex (s);                                            //<TagVex ei tarvita koska Celli=''
   if (motja<momax) and (s<>'')
      then result := true;  end;

procedure NormCur;      begin Screen.Cursor := crDefault;  end; //<+12.0.0
procedure avust (CmBx,Sark,Tulst :integer);      begin; //<CmBx:   1=Boxin avuste (lukitsee) 0=Muu
   avuste(CmBx,Sark, 9, Tulst);                         //'Tulst:  1=TulostusPaperille       0=Edit.
// if MoFrm.Showing  and MoFrm.Visible  then            //<-12.0.0:  Esti PanrlA..Moven jälkeen avusteen.
      MoFrm.SetFocus;                    //<Jotta F1 = Frm.KeyDown workkisi JA FOCUS säilyis muutenkin
end;                                     //'Aiheutt. CAPTIONin 'vilkkumista', jos AVUSTE.INCssä BringToFront tms.

procedure PoistaVex; FORWARD;            //< +4.0.0
                              //,,Oli,,,,,,.........................................................
{$I '..\Moottori\FileMo.INC'} //=           //<,,DEVELOPER1
{$I '..\Moottori\MoFnc1.INC'} //NolaMF
{$I '..\Moottori\MoLas1.INC'} //NolaM1
{$I '..\Moottori\MoLas2.INC'} //NolaM2
{$I '..\Moottori\MoFnc2.INC'} //NolaMF1     //<fTim esiteltävä INTERFACE -lohkossa SyoKut.INCn takia
{$I '..\Moottori\Moot.INC'}   //=

procedure avustNJ (CmBx,Sark,Tulst :integer);    begin;
   avuste(CmBx,Sark, 4, Tulst);                  //<Käytetään NJ-osan avustetta ##############################
   if MoFrm.Showing  and MoFrm.Visible  then
      MoFrm.SetFocus;                            //<Jotta F1 = Frm.KeyDown workkisi JA FOCUS säilyis muutenkin
end;

procedure PoistaVex;      begin
              poista := false;
              Screen.Cursor := crDefault;
              MoFrm.PoistaBtn.Caption :=  myTextBase.Get(NJ_1);
              MoFrm.PoistaBtn.Font.Style := [];
              MoFrm.PoistaBtn.Font.Color := clBlack;
              MoFrm.PoistaBtn.Hint := myTextBase.Get(NJ_2);  end;
procedure KopioiVex;      begin
              kopioi := false;
              Screen.Cursor := crDefault;
              MoFrm.KopBtn.Caption := myTextBase.Get(NJ_3);
              MoFrm.KopBtn.Font.Style := [];
              MoFrm.KopBtn.Font.Color := clBlack;
              MoFrm.KopBtn.Hint := myTextBase.Get(NJ_4);  end;
procedure OhjeVex;      begin                                                 //<,,+2.0.5
         //if apuaOn  then begin                                              //<  -4.0.0
              apuaOn := false;
              MoFrm.OhjeBtn.Font.Size := 17;
              MoFrm.OhjeBtn.Font.Style := [fsBold];  end; //end;
procedure NormBtn;      begin                                                 //<,,+2.0.5
              PoistaVex;   if (motja>1) or fUusRv_Vajaa                       //<  +4.0.0
                                       then MoFrm.PoistaBtn.Enabled := true   //<, +4.0.0
                                       else MoFrm.PoistaBtn.Enabled := false;
              KopioiVex;   MoFrm.KopBtn.Enabled := true;                      //<  +4.0.0
              OhjeVex;
              MoFrm.OkBtn.Enabled := true;                                    //<,,+4.0.0
                           if MoVeja or fUusRv_Vajaa
                                       then MoFrm.PalautBtn.Enabled := true
                                       else MoFrm.PalautBtn.Enabled := false;
              MoFrm.  SuljeBtn.Enabled := true;
              MoFrm.    LueBtn.Enabled := true;
              MoFrm.    TalBtn.Enabled := true;
              MoFrm.TulostaBtn.Enabled := true;
              MoFrm.ChkDet.Enabled :=     true;  end;
procedure PvBtnOff;      begin  MoFrm.PvBtn.Font.Style := [];
                                MoFrm.PvBtn.Enabled := false;
                                NormBtn;  end;
procedure PvBtnOn;       begin  MoFrm.PvBtn.Font.Style := [fsBold];
                                MoFrm.     PvBtn.Enabled := true;
                                NormBtn;                                     //<,,+4.0.0
                                MoFrm.     OkBtn.Enabled := false;
                                MoFrm. PalautBtn.Enabled := false;
                                MoFrm.    KopBtn.Enabled := false;
                                MoFrm. PoistaBtn.Enabled := false;
                                MoFrm.  SuljeBtn.Enabled := false;
                                MoFrm.    LueBtn.Enabled := false;
                                MoFrm.    TalBtn.Enabled := false;
                                MoFrm.TulostaBtn.Enabled := false;
                                MoFrm.    ChkDet.Enabled := false;  end;

procedure Chk_SftUm_AsBtns;      VAR sF,sU,sV :string;      begin
  sF := sRmrkt0vex(alpSft,1,2);
  sU := fImrkt0   (alpUm,1);
  sV := fImrkt0   (alpVrk,1);
  if (sF=MoFrm.Bx1.Text) and (sU=MoFrm.UmCmBx.Text) and (sV=MoFrm.VrkCmBx.Text)
     then PvBtnOff
     else PvBtnOn;
end;

//  GridLineWith on vain Cellien väleissä, ei reunoilla ja kasvattaa RowHeight -arvoa pixeleillään, TODETTU
//,,BxG:n sijoitus lomakkeelle:   Left := fBxX(sar);   Top := fBxY(fRow(X,Y));,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
function fBxX (CelCol,CelRow :integer) :integer;      var CelXY :TRect;   begin //< Palautaa CELLin vasYläX:n
   CelXY := MoFrm.StrGr.CellRect (CelCol,CelRow);
   Result := CelXY.Left;
end;//fBxX;
function fBxY (CelCol,CelRow :integer) :integer;      var CelXY :TRect;   begin //< Palautaa CELLin vasYläY:n
   CelXY := MoFrm.StrGr.CellRect (CelCol,CelRow);
   Result := CelXY.Top +MoFrm.PanelY.Height;
end;//fBxY;
{TPoint = record  X: Longint;  Y: Longint;  end;
TRect = record  case Integer of  0: (Left, Top, Right, Bottom: Integer);  1: (TopLeft, BottomRight: TPoint);
   The coordinates are specified either as four separate integers representing the pixel locations of the left,
   top, right, and bottom sides, or as two points representing the pixel locations of the top left and bottom
   right corners. The origin of the pixel coordinate system is in the top left corner of the screen.}

function fCol (X,Y :integer) :integer;      var CelCol,CelRow :integer;      begin //<Pal Cellin AbsCOLn
  MoFrm.StrGr.MouseToCell(X,Y, CelCol,CelRow);                                     //'Scrollattu tai ei
  Result := CelCol;
end;//fCol;
function fRow (X,Y :integer) :integer;      var CelCol,CelRow :integer;      begin //<Pal Cellin AbsROWn
  MoFrm.StrGr.MouseToCell(X,Y, CelCol,CelRow);                                     //'Scrollattu tai ei
  Result := CelRow;
end;//fRow;
{,,,,,,,,,,,,,,,,,,,,,0=BxG,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
procedure sijBxG(sark,BxNo :integer);   VAR tmpItems :TStringList;      begin
                                                 //, BxG:ssä virhe (fEhka..:ssa SetFocus->BxGEnter->sijBxG) kutsuu
  if (BxNo=0)  OR               //<,+4.0.0       //< ekax tätä ja sen jälk. klikatusta Bx1 :stä, JOKA OHITETTAVA
     (BxNo>0) and NOT BxGAuki                    //' NIIN, ETTEI itemit tule BxNo 1 :n mukaan. !!!!!!!!!!!!!!!!!!!
  then with MoFrm.BxG  do begin //,,,,,,,,,,,,,,,TEKEE ITEM-LISTAN: 'Oletus;Item[0];Item[1]... #####
    if BxNo=0
       then tmpItems := f_Items(BxItems(sark,    MoKut)) //<Tehdään BXITEMS:stä ITEM-lista TmpITEMS
       else tmpItems := f_Items(BxItems(BxNo+10, MoKut));
    {###################'''''''####################################################################}
    Items.Assign(tmpItems);                      //<ASSIGN =ei tartte ekax Clear
    tmpItems.Free;   //<####### VASTA TÄSSÄ SAA TUHOTA. MUUTEN OSOITIN HÄVIÄÄ LIIAN AIKAISIN #######

    with Items  do begin //< =MoFrm.BxG.Items
      if MoFrm.BxG.Items.Count-1 >= 1  then
      if MoFrm.BxG.Items[0] = MoFrm.BxG.Items[1] //<,+4.0.0  Poistetaan pud.valikon 2.item(=1), jos sama kuin 1.(=0)
         then Delete (1);

      DropDownCount := 30;                       //< +4.0.0 .  Lopusta tähän +11.0.1
      case BxNo of                               //,Kopioidaan BxG:stä ao. Boxiin ##################
        0 : ;
        1 :MoFrm.Bx1.Items :=     Items;
        3 :MoFrm.VrkCmBx.Items := Items;  end;//case
      ItemIndex := 0;                            //< +4.0.0  Fiksumpi kuin Text := Strs[0] !!!!!!!!!
    end;//with Items                             //'+11.0.1:  Siirretty loppuun josko eka clikki => selected.
  end;//with BxG
end;//sijBxG;
{==================================================================================================}
procedure TMoFrm.StrGrWidestColInRow(Sender: TObject; ACol, ARow,  newWidth: Integer);      begin
   StrGr.ColWidths[ACol] := newWidth;                //Col,Row <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   PanelY1.Left := fBxX (     1,1) - 3;              //   ,    <,"Syöttöarvot" ja "Lasketut.." -palstaselit.
// LbY1o.Left :=   fBxX (vCol+1,1) - 2;              //  _,_   //<Koska Left mitattu PanelY1 :n Leftistä
// LbY1o.Left :=   fBxX (vCol+1,1) +PanelY1.Left -1; //  _,_   //<Koska Left mitattu PanelY1 :n Leftistä
   LbY1o.Left :=   fBxX (vCol+1,1) - fBxX ( 1,1) +1;
   LbY1o1.Left :=  fBxX (    20,1) - fBxX ( 1,1) +1;
   LbY1o2.Left :=  fBxX (    26,1) - fBxX ( 1,1) +1;
 //LbY1o3.Left :=  fBxX (    29,1) - fBxX ( 1,1);              //<Vain Rv -sarake enää jäljellä = Ei tarvita
   PanelY1.Visible := true;
   LbYo.Visible :=    true;
   LbY1o.Visible :=   true;
   LbY1o1.Visible :=  true;
   LbY1o2.Visible :=  true;
   LbY1o3.Visible := false;
end;

procedure TMoFrm.OhjeBtnClick(Sender: TObject);      begin
                                     Qedic_ ('<br>[===?btn]');
   fEhkaTarkArvo (0);                //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell.
   BxGAukiVisOff;                    //<Suljetaan BxG, alle jää cellin arvo, jos on. +4.0.0
   PoistaVex;
   KopioiVex;
   if apuaOn
   then begin
      OhjeVex;
      AvuChkSft (10);  end           //< Sama muihin Frmeihin  10=Vapauttaa  11=Lukitsee
   else begin
      PaaValFrm.Timer1.Enabled := false; //<+14å2:  Kytkee OhjeBtn´in Kysymysmerkin vilkunvex.
      avust (0,-1, 0);
      apuaOn := true;
      fSyoAktv (0);                  //< 0  =Vapauttaa
      AvuChkSft (11);                //< 11 =Lukitsee
      OhjeBtn.Font.Size := 10;
      OhjeBtn.Font.Style := [];  end;
end;//OhjeBtnClic

procedure TMoFrm.SuljeBtnClick(Sender: TObject);      begin
   if fEhkaTarkArvo (0)  then begin  //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell  +4.0.0
      SyottoAvFrm.Hide;              //< +3.0.0
      NormBtn;
    //AvuChkSft (10);                //< 0=Sijoittaa saman muihin Frmeihin  10=Vapauttaa  11=Lukitsee -4.0.0
      BxGAukiVisOff;                 //< +4.0.0  BxGAuki+Visible := FA, varm.vuoksi.
      Close;  end;
end;

procedure TMoFrm.PalautBtnClick(Sender: TObject);      begin
                                        Qedic_ ('<br>[===PalBtn]');
   if fEhkaTarkArvo (0)  then begin       //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell
      SyottoAvFrm.Hide;                   //< +3.0.0
    //AvuChkSft (0);                      //< 0=Sijoittaa saman muihin Frmeihin  10=Vapauttaa  11=Lukitsee.  -4.0.0
      case moVE of                        //< +4.0.0  case, oli if..else, lisätty väliin if..else case´hin
           //,, mof = FilestäLuettu,    mo0 = Istunnon alku,   eriMo=TR, jos Mo<>MoF,  := 1 Init. +PRC moVEo <- Lue/TalBtn ym.
           1  :if eriMo   then begin  moVE := 2;  mo := mof;  MoFilen := MoF_filen;  end else
               if eriMo0  then begin  moVE := 0;  mo := mo0;  MoFilen := Mo0_filen;  end else
                               begin  moVE := 1;  mo := mou;  MoFilen := MoF_filen;  end;

           2  :if eriMo0  then begin  moVE := 0;  mo := mo0;  MoFilen := Mo0_filen;  end else
               if eriMoU  then begin  moVE := 1;  mo := mou;  MoFilen := MoF_filen;  end else
                               begin  moVE := 2;  mo := mof;  MoFilen := MoF_filen;  end;

          else if eriMoU  then begin  moVE := 1;  mo := mou;  MoFilen := MoF_filen;  end else //< (0)
               if eriMo   then begin  moVE := 2;  mo := mof;  MoFilen := MoF_filen;  end else
                               begin  moVE := 0;  mo := mo0;  MoFilen := Mo0_filen;  end;  end;//case

      eSar := 0;  eMrv := 0;                    //, -4.0.0  motja := ... vex, koska sama EditMoFrm :ssa
      EditMoFrm;                                //<Asettaa myös PalautBtn. + PoistaBtn.Enabled TR/FA
                         {MoFrm.EdiY1.Text := '1:  fVisRow=' +fImrkt0 (i,1) +'  2:  fVisRow=' +fImrkt0 (fVisRow,1) +
                             '  Top=' +fImrkt0 (MoFrm.StrGr.TopRow,1) +'  FixR=' +fImrkt0 (MoFrm.StrGr.FixedRows,1);}
      MoFrm.StrGr.TopRow := MoFrm.StrGr.FixedRows; //< +4.0.0
   end;
   NormBtn;                               //< +2.0.5
end;//PalautBtnClic

procedure TMoFrm.KopBtnClick(Sender: TObject);      begin
                                     Qedic_ ('<br>[===KopBtn]');
   if fEhkaTarkArvo (0)  then begin           //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell  +4.0.0
      PoistaVex;
      OhjeVex;                                //< +2.0.5
      if syoAvOn  then                        //< +2.0.5
         avustNJ (0,22,0);                    //< +2.0.5
      if kopioi
      then begin  KopioiVex;
                  SyottoAvFrm.Hide;           //< +4.0.0
                  AvuChkSft (10);  end        //< +2.0.5
      else if motja=0                         //<OK, vaikkei ehtoa:  and  Mrv<=motja, KOKEILTU <<<<<<
      then        erPiip
      else begin  kopioi := true;
                  AvuChkSft (11);             //< +2.0.5
                  Screen.Cursor := crHandPoint;  {crSizeWE;}
                  KopBtn.Caption := myTextBase.Get(NJ_7);
                  KopBtn.Font.Style := [fsUnderline];
                  KopBtn.Font.Color := clBlue;
                  KopBtn.Hint := myTextBase.Get(NJ_8);
      end;
   end;//if
end;//KopBtnClic

procedure TMoFrm.PoistaBtnClick(Sender: TObject);      begin   Qedic_ ('<br>[===PoisBtn]');
//,,Rivipoistossa ASETETTAVA mo.motr[].onArvot := FALSE;
   if fEhkaTarkArvo (0)  then begin          //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell  +4.0.0
      KopioiVex;
      OhjeVex;                               //< +2.0.5
      if syoAvOn  then                       //< +2.0.5
         avustNJ (0,21,0);                   //< +2.0.5
      if poista
      then begin  PoistaVex;
                  SyottoAvFrm.Hide;          //< +4.0.0
                  AvuChkSft (10);  end       //< +2.0.5  ,,4.0.0 +fUusRv_Vajaa
      else if (motja<=1) and  NOT fUusRv_Vajaa //<Ei anneta edes valita, jos vain 1r. Estetty MouseDwn :kin
      then erPiip
      else begin  poista := true;
                  AvuChkSft (11);            //< +2.0.5
                  Screen.Cursor := crHandPoint;  {crSizeWE;}
                  PoistaBtn.Caption := myTextBase.Get(NJ_5);
                  PoistaBtn.Font.Style := [fsUnderline];
                  PoistaBtn.Font.Color := clBlue;
                  PoistaBtn.Hint := myTextBase.Get(NJ_6);
      end;
   end;//if
end;//PoistaBtnClic

procedure TMoFrm.StrGrMouseMove(Sender: TObject; Shift: TShiftState;  X,Y: Integer);      VAR Sar,Riv :integer;    begin
                                                 {MoFrm.EdiY1.Text := 'row'+fImrkt0 (fRow(X,Y),1)+' fix'+fImrkt0
                                                  (StrGr.FixedRows,1)+'vis'+fImrkt0 (StrGr.VisibleRowCount,1);//}
NormCur;                                                              //<+12.0.0:  TaajKaytLbl muutti crHandPoint´ksi.
{if MoFrm.Active  then begin                                                                      //<+6.1.1  -12.0.0}
   if NOT poista   and NOT kopioi  and NOT apuaOn  and                //<Näillä omat avusteet +2.0.5
      NOT syoAktv  and syoAvOn     and NOT BxGAuki{+4.0.0aa}          //<Näille Hide muualla  +2.0.5
   then begin                                                         //,,Muualla MouseDwn hoitaa avusteen
      Sar := fCol(X,Y);   Riv := fRow(X,Y);                           //<+12.0.0
      if (Sar>=0) and (Sar<=StrGr.ColCount-1) and
         (Riv>=0) and (Riv<=StrGr.RowCount-1)
      then avust (0,Sar, 0)
      else SyottoAvFrm.Hide;                                          //< 2.0.5 Korjattu
   end;
   if MoDetFrm.Visible                                                //<, +4.0.0  OK, vaikka MoDetFrm=Minimized
      then MoFrm.SetFocus;
{end; }end;
                                             //,SetFocus aiheuttaa OnBxGEnter -eventin, TODEETU (esim. fEhka..:ssa)
procedure TMoFrm.BxGEnter(Sender: TObject);   begin//,KeyDwn rivn päässä/alussa aiheutti TopRow/LeftCol-aset, joka
  inherited;                                 //aiheuttaa TopLeftChange => BxG.Visible :=FA =BxGauki ILMAISEE SAMAN.
   if BxGAuki  then begin                    //<,+4.0.0aa
      Sar := BxSar;    Mrv := BxMrv
   end;
   BxSar := Sar;  BxMrv := Mrv;
   BxGAuki := true;
   sijBxG (eSar,0);                          //<Sijoittaa ITEMIT Boxiin ###### Siirretty OHJAABXG :stä =4.0.0 ####
end;
{=======================================OHJAA SYÖTTÖclikIT=========================================}
                  //,,oh :n arvo muutettu:  nyt 0 = KeyEnteristä,   1 = VAIN MouseDown :sta  4.0.0aa
procedure ohjaaBxG (oh :integer);      VAR boa :boolean;  i,j,BxCo,BxRw :integer; //p :TPoint;
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}         //BxCo'BxRw ovat CELLcol,row -arvoja
  function fPixPit (str :String) :Integer; //,,,,,,,,,,,,,,,,,,,Mjonon pituus PIXeleinä,,,,,,,,,,,,,
    begin fPixPit := Y_fPixPit (MoFrm.StrGr.Canvas, str, MoFrm.BxG.Font);  end;//fPixPit;
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
  function fMrkPit (str :string) :Integer;  //,,,,,,,,,,,,,,,,,,,Mjonon pituus PIX,,,,,,,,,,,,,,,,,,
      var i,j :integer;   //,,Kaipaa +1, jotta mja mahtuisi boxiin!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    begin i := fPixPit(str) +20;                         //< +20 = Pudotusnuoli
          j := MoFrm.StrGr.ColWidths[fAbsCo (Sar)] +4;   //< Kaipaa +4 jotta kenttä täyttyisi,TODTTU
                                          //Kok (1,6, 'fPx#i#='+fImrkt0 (i,1)+'#j#='+fImrkt0 (j,1));
          if j>i  then i := j;  fMrkPit := i;  end;
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
begin//ohjaaBxG; - Tähän tullaan VAIN PRC StrGrMouseDown + BxGKeyDow :sta. UmCmBx yms :sta SUORAAN ArvoOK -kutsut
                {  ja jos eiOK, SetFocus takas, joten niiden arvot pakko olla OK, ja TÄSSÄ VAIN BxG :n KÄSITTELYÄ.
                 - OHA PYSYY TÄSSÄ:
                             OhjaaBxG/BxG.SetFocus  -> OnBxGEnter -> sijBx,
                   ELLEI fEhka..:ssa aseteta BxGAuki=FA :ksi, JOSTA TIEDETÄÄN, että BxG :tä EI ENÄÄ HALUTA AVAT-
                   TAVAKSI (ks. FNC fEhka...) ,,,,,,,,,,,,,,,,,,,,, Uusittu 4.0.0 ,,,,,,,,,,,,,,,,,,}
                                             //KoeNayArvot (1,6,'oh 0');
                                             //KoeNay (1,'OhjBxG 0/5');
if NOT MoFrm.PvBtn.Enabled  then begin  //< +4.0.0  ,,Varmempi kuin fEhka..(oh),,,,,,,,,,,,,,,,,,,,,
  boa := fEhkaTarkArvo (oh);            //<Jos oltiin BxG :ssa, tarkist + sij. + editoi Cellin !!!!! 4.0.0

  if boa  and (oh=0) and (Sar=1)        //<,Estetään KeyEnterillä uuden rivin aloitus =UUSI RIVI ON  +4.0.0
     then boa := false;                 //  ALOITETTAVA HIIREN CLICKILLÄ EKAAN ARVOSARAKKEESEEN!!!!!

  if boa  then begin //<,,,eSar ja eMrv := ... ja Box avataan VAIN jos OKarvo + OKclickAlue,,,,,,,,,,,,,,,,,,,,,,,
    eSar := Sar;  eMrv := Mrv;
    //,,,Jos Click vain OSITTAIN näkyvään StrGr :n osaan, siirretään RUUTUA, muuten PANELIOSAT supis-
    //,,,tuvat, TODETTU. Ja TÄMÄ VAIN, jos muuten Click OK, koska tähän päästy.!!!!!!!!!!!!!!!!!!!!!
    //   ############### selROW, selCOL := arvon SelectCell + KeyPres + MouseDwn:ssa ###############
    with MoFrm.StrGr  do begin
       if selROW > TopRow  +VisibleRowCount -1  then TopRow := TopRow +1  else
       if selROW < TopRow                       then TopRow := TopRow -1;

       if selCOL > LeftCol +VisibleColCount -1  then LeftCol := LeftCol +1  else
       if selCOL < LeftCol                      then LeftCol := LeftCol -1;

       BxRw := fVisRow;
       BxCo := fVisCol;
    end;//with
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Loppuarvot Boxin vas.yläkulmalle,,,,,,,,,,,,,,,,,,,,
    with MoFrm.BxG  do begin
                         //with MoFrm.StrGr  do i := MoFrm.BxG.Height -RowHeights[i] -GridLineWidth;
       Top :=  fBxY (BxCo,BxRw) -1;//-3;        //<,BxG :n sijoitus StrGr :n Celliin. -2*LWidth, jot  4.0.0 -3=>-1
       Left := fBxX (BxCo,BxRw) -2;             //<'tei vie tilaa liikaa alapuoln rvstä + OikSar:sta
                                                //KoeNay (0,'OhjBxG 1/5');
       i := MoFrm.StrGr.ColWidths[Sar] +21;             //<,, +4.0.0 ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
       j := i;
       with MoFrm.StrGr  do if Sar IN [FixedCols..vCol-1]  then //<vCol-1, koska vCol´ssa saa mennä ´pitkäksi´
            j := ColWidths[Sar] +ColWidths[Sar+1] -5;   //<Mahduttava 2sar :een -5 pix Clic-tilaa
       if (j<i) and (j>0)  then i := j;
       Width := i;    //'=min '0'. Riippuu kylläkin PixPerInch, ',' nyt ainakin OK (omassa koneessa)
    end;//with ..BxG
  end else//if boa
  if BxGAuki  then begin                          //<,+4.0.0
       Sar := BxSar;    Mrv := BxMrv;             //KoeNay (0,'OhjBxG 2/5');
  end;                                            //<'Ei:  else erPiip, koska on jo fEhka../arvoOK :ssa

  if boa  or  BxGAuki  then begin
     if syoAvOn  then begin
        fSyoAktv (0);  avust (1,eSar, 0);  fSyoAktv (1);
        SyottoAvFrm.Visible := true;              //KoeNay (0,'OhjBxG 3/5');
     end;
                                                  //KoeNay (0,'OhjBxG 4/5');
     MoFrm.BxG.Visible := true;                   //<Muuten Error:  Unable to focus invisible ...
     MoFrm.BxG.SetFocus;       //<Aiheuttaa OnBxGEnter´in.   Boxin arvo 'maalataan' ENTERkelpoiseksi
  end;                         //'########################!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                                                  //KoeNay (0,'OhjBxG 5/5');
end;//if NOT..
end;//ohjaaBxG;
{==================================================================================================}
procedure TMoFrm.StrGrMouseDown(Sender: TObject; Button: TMouseButton;   Shift: TShiftState; X, Y: Integer);
      var uSar,uMrv :integer;
   {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
   procedure P_poista;      var i :integer;      begin
    i := fMOtoAbsROW (Mrv);       //< i = Mrv +FixedRows -1
//  if (motja=1)  OR  (Mrv>motja) and (StrGr.Cells[1,fVisRow]='') and (StrGr.Cells[2,fVisRow]='') //< -4.0.0
    if (MoFrm.StrGr.Cells[MoFrm.StrGr.FixedCols, i] = '')  or                                     //<,+4.0.0aa
       (Mrv<1)  or (Mrv=1) and (motja=1)
    then erPiip
    else begin                    //,,##############################################################
      if Mrv<=motja  then begin   //<,Muutoin vajaa rivi, jolloin ei näitä muutoksia ###############
         for i := Mrv  to motja-1  do mo.motr[i] := mo.motr[i+1];
        {if NOT PalautBtn.Enabled  then begin //<Tilanne talteen ennen EKAA kopiota ################
            nj0 := njf;       //<jk0 :aan nyt alp JKF ##############################################
            njf := nj;        //<###################################################################}
         motja := motja -1;
         a_PutIntg (102, motja, mo.moty.lahtoja); //<Luetaan EditMoFrm :ssa, vrt. Lue :n jälk. #####
         if Mrv>motja  then Mrv := motja; //<Muuten jää vika OSOITETTU Mrv > motja, todettu ########
      end;
    //SijMouIfVE1;                        //<Prc 4.0.0  Ei sittenkään: Parempi, että palautettavissa
      EditMoFrm;          //<UUSI EDIT.##### Asettaa myös PalautBtn. + PoistaBtn.Enabled TR/FA #####
      if (motja<1)  and NOT fUusRv_Vajaa  then PoistaVex; //< +4.0.0
    end; end;//P_poista;
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
  procedure P_kopioi;      begin
    if (Mrv<1) or (Mrv>motja) or (motja>=momax) or (motja>=fAbsROWtoMRV (MoFrm.StrGr.RowCount-1))
    then begin erPiip; {KopioiVex; -4.0.0} end
    else begin
     {if NOT PalautBtn.Enabled  then begin //<Tilanne talteen ennen EKAA kopiota ###################
         nj0 := njf;      //<jk0 :aan nyt alp JKF ##################################################
         njf := nj;  end; //<#######################################################################}
      mo.motr[motja+1] := mo.motr[Mrv];
      motja := motja +1;
      a_putIntg (103, motja, mo.moty.lahtoja);
      SijMouIfVE1;                  //<Prc 4.0.0
      pvRivi (1,motja);     //<################################# Uusi edit.+ BxG=>Cell ARVO ########
    end;
  end;//P_kopioi;
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
begin//StrGrMouseDown ############# TÄHÄN TULLAAN AINA EKAX, KUN NÄPÄYTETÄÄN StrGr -ALUEELLE ############ <<,,+1.1.3
     {- Ennen tähän tuloa on eventi OnSelect tapahtunut, ks. lopussa ################################!!!!!!!!!!!!!
      - StrGrClick: TÄHÄN tullaan ja vasta sitten StrGrClick :iin oli BreakPoint päällä (tässä) eli ei !!!!!!!!!!!
      - DblClick:   Jos BreakPoint on   PÄÄLLÄ (tässä PRCssä), tullaan TÄHÄN ja SITTEN StrGrClick :iin!!!!!!!!!!!!
                    Jos - " -      EIOO - " -      - " -     , MENNÄÄN  DblClck :iin ja SITTEN VASTA TÄHÄN!!!!!!!!}
                                                //ediS ('(Dwn'+fImrkt0(StrGr.TopRow,1)+','+fImrkt0(ChkTop,1)+')');
                         Qedic_ ('[*StrMDwn]0:  selC='+fImrkt0 (selCOL,1) +',selR=' +fImrkt0 (selROW,1)+//+4.0.0
                                 '  s=' +fImrkt0 (Sar,1) +' r=' +fImrkt0 (Mrv,1));
if NOT MoFrm.PvBtn.Enabled  then begin  //< +4.0.0
   OhjeVex;                  //< +2.0.5
   if DblClck                //<Estetään OhjaaBx, koska ositt näkyvälle DblClick aiheuttaa ruudun siirtymisen:
   then begin                //'DblClikissä:  1)Select..  2)MouseDwn  3)Select..  4)Click  5)DblClick  6)MousDwn
      DblClck := false;      //'5) ja 6) ei tapahdu ollenkaan, jos tavallinen Click #############################
    //Y_piipit (10);         //< -4.0.0
      fSyoAktv (0);  end //<Vapauttaa avusteen
   else begin
    //,,##########################################################################################################
      uSar := fCol (X,Y);   uMrv := fRow (X,Y); //<,JOSSAIN VANHASSA VERSIOSSA JOSTAIN SYYSTÄ Click FixedRow/Col´
                                                //  iin ei vienyt OnSelectCell´iin. NYT EHKÄ selCOL,ROW TARPEETON.
      selCOL := uSar;  selROW := uMrv;             //<,, +4.0.0 ##################################################
                                                   //'############################################################
      Sar := fAbsCOLtoSAR (selCOL);                //<', fCol,fRow palauttaa AbsCol,AbsRow oli scrollattu tai ei
      Mrv := fAbsROWtoMRV (selROW);                //<'selCOL/Row := SelectCell + KeyPres :ssä ###################
                                                    //,,11.0.1:  Modif(=NOT vex) PRC StrGrClick´sta.
      if SyoAvOn  and NOT BxGAuki  and NOT Kopioi  and NOT Poista
      then begin                            //' +4.0.0  ,,Lukitaan avuste sarak :seen. BxG:n avust ks. ohjaaBxG
         fSyoAktv (0);                      //<,,130.2e:  Alekkain
         avust (0,uSar, 0);
         fSyoAktv (1);   end
      else AvuChkSft (11);                  //< 11 =Lukitsee avusteen.  <''11.0.1
     {if (uSar<StrGr.FixedCols) or (uMrv<StrGr.FixedRows)                             //<,Turhaa holhousta -11.0.1
         then erPiip;}          //<2.erPiip tulee hetken päästä fEhka..:sta, HYVÄ ################################
                          Qedic_ (' [1:]  selC='+fImrkt0 (selCOL,1) +',selR=' +fImrkt0 (selROW,1) + //+4.0.0
                                 '  s=' +fImrkt0 (Sar,1) +' r=' +fImrkt0 (Mrv,1));
                                {with MoFrm.StrGr  do ediO_('//Dwn: Sar'+fImrkt0(Sar,1)+' Mrv'+fImrkt0(Mrv,1)+
                                           ' Lft' +fImrkt0 (LeftCol,1)     +' visc'+fImrkt0 (VisibleColCount,1)+
                                           ' Top' +fImrkt0 (TopRow, 1)     +' visr'+fImrkt0 (VisibleRowCount,1)+
                                           ' viiMrv'+fImrkt0 (TopRow +VisibleRowCount -FixedRows, 1)+
                                           ' viiRow'+fImrkt0 (TopRow +VisibleRowCount -1, 1));//}
      if poista                             //<Ao. BtnClick asetti<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      then P_poista
      else if kopioi                        //<Ao. BtnClick asetti<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      then P_kopioi                         //,0 = Ei KeyPressed <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      else ohjaaBxG (1);                    //< 4.0.0aa  0 -> 1                        //ediO_('&');
   end;                                                                                //ediO_('~');
end;//if NOT...
                                Qedic_ (' [9:] s=' +fImrkt0 (Sar,1) +' r=' +fImrkt0 (Mrv,1) +'<br>'); //< +4.0.0
   // ChkBxAv.Hint := 'MouseDown'; //< +1.1.3
end;//..StrGrMouseDown
{==================================================================================================}
procedure TMoFrm.BxGKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);

    function ViimMaxRw (MOriv :integer) :boolean;   begin  Result := false;//,Varmistaa, jos ..Count/momaxEiOK
       if (MOriv>=momax) or (fAbsRw (MOriv)>=MoFrm.StrGr.RowCount-1)  then Result := true;  end;
                                                             //,,,,,,,,,,,,,,,,Olet = EiOK..........
    procedure VasYlos (Vaaka :boolean);   begin //,VAAKA=TR kun halut siirtyä vaakasuunt samal rvllä
      if vaaka and (Sar=1) and (Mrv=1)  OR      //,      FA kun pystysuunnassa #####################
         NOT Vaaka and (Mrv=1)
      then begin erPiip;
                 BxGAukiVisOff;  end            //< Muuten rupeaa selaamaan BxG:n itemeita, TODETTU.  Prc 4.0.0
      else begin                                //' Ei ehkä enää, koska fEhka.. ´ssa suljetaan !!!!?
         if Vaaka
         then begin
            Sar := Sar-1;                       //<SAR tai eSAR, koska SftUp haluttiin siirtäv 1xVAS
            if Sar=0  then begin Sar := vCol;  Mrv := Mrv-1;  end; end
         else Mrv := Mrv-1;                     //<CtrlYlosVas = haluttiin suoraan ylös ############

         with StrGr  do begin
            if Sar<LeftCol
            then LeftCol := LeftCol -1
            else if Sar+1 > LeftCol +VisibleColCount -1  then LeftCol := Sar -VisibleColCount +1;
                    //'+1 = Varataan BgG :lle 2 saraketta tilaa, muuten osuessaan SrolBarin alueelle,
                    //'     scrollaa itsekseen yhden yli, TODETTU ##################################
            if fVisRow<TopRow  then TopRow :=  TopRow -1;
         end;//with

         selCOL := fVisCol;
         selROW := fVisRow;
         ohjaaBxG (0);                          //< 0 =Ohjaus KeyPres :stä <<<<<<<<<<<<< 4.0.0aa  1 -> 0
    end;//else
    end;//VasYlos
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//,VAAKA=TR kun halut siirtyä vaakasuunt samal rvllä
    procedure OikAlas (Vaaka :boolean);                            //<VAAKA = FA, kun pystysuunnassa
        {var b1, b2,b21,b22, b3,b31, b4,b41,b42
             :boolean;//}
         function pysty :boolean;   begin Result := false;  if NOT vaaka  then Result := true;  end;
    begin //,,,BREAKPOINT -TARKASTELUA VARTEN ######################################################
{      b1 := NOT(Sar IN [1..vCol]) or NOT (Mrv IN [1..momax]);
        b21:= vaaka and  (Sar=vCol);  b22 := ViimMaxRw (Mrv);
      b2 := vaaka and  (Sar=vCol) and  ViimMaxRw (Mrv);
        b31:= pysty;
      b3 := pysty and ViimMaxRw (Mrv);
        b41:= NOT OkStr (Sar-1,Mrv+1);   b42:= NOT OkStr (vCol,Mrv);
      b4 := pysty and (b41 or b42);

      if b1  or  b2  or  b3  or  b4                or //<Tähän BREAKPOINT ##########################
         b1                                        or
         b21  and b22                              or
         b31  and b22                              or
         b31  and (b41  or  b42)//}

      if NOT(Sar IN [1..vCol])  or  NOT (Mrv IN [1..momax])                 or //<EIKOSKAAN: VAIN TÄSSÄ OHJAT.
         vaaka and (Sar=vCol) and  ViimMaxRw (Mrv)                          or //<Ohi viim Cellin <<<<<<<<<<<<
         pysty and                 ViimMaxRw (Mrv)                          or //<Ohi viim rivin  <<<<<<<<<<<<
         pysty and (NOT OkStr (Sar-1,Mrv+1)  or  NOT OkStr (vCol,Mrv))    //<Vas+EdRvnVikaCel:ssä oltava mrkjä}
      then begin erPiip;  //Y_piipit (50);
                 BxGAukiVisOff;  end            //< Muuten rupeaa selaamaan BxG:n itemeita, TODETTU.  Prc 4.0.0
      else begin                                //' Ei ehkä enää, koska fEhka.. ´ssa suljetaan !!!!?
         if Vaaka
         then begin
            Sar := Sar+1;                       //<SAR tai eSAR, koska SftUp haluttiin siirtäv 1xOIK
            if Sar>vCol  then begin  Sar := 1;  Mrv := Mrv+1;  end; end
         else Mrv := Mrv+1;                     //<CtrlAlasOik = haluttiin suoraan alas ############

         with StrGr  do begin //,,HUOM: LeftCol +TopRow -muutokset -> BxG.Visible := FA =HUOMIOITAVA fEhka....
            if Sar<LeftCol
            then LeftCol := FixedCols           //<vCol :sta 1. sar :een <<<<<<<<<<<<<<<<<<<<<<<<<<<
            else if Sar+1 > LeftCol +VisibleColCount -1  then LeftCol := LeftCol +1;
                    //'+1 = Varataan BgG :lle 2 saraketta tilaa, muuten osuessaan SrolBarin alueelle,
                    //'     scrollaa itsekseen yhden yli, TODETTU ##################################
            if fVisRow>TopRow +VisibleRowCount -1  then TopRow :=  TopRow +1;
         end;//with

         selCOL := fVisCol;
         selROW := fVisRow;
         ohjaaBxG (0);                          //< 0 =Ohjaus KeyPres .stä <<<<<<<<<<<<< 4.0.0aa  1 -> 0
    end;//else
    end;//OikAlas
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
begin{BxGKeyDown}                                   //ediS ('Key='+fImrkt0(key,1));
                                                    { 'sar'+fImrkt0(sar,1)+'bxc'+fImrkt0(BxCol,1)+'/';}
//if {-1.1.3=MoFrm.ChkBxAv.Checked 1.1.3->+} syoAktv   then begin  avust ( 1,Sar, 0);  fSyoAktv (0);  end;
  case key of                                                              //':= TR =Lukittiin ohjaaBxG:ssa
  13 :OikAlas (TRUE);                                         //<Enter
//40 :if Shift IN [ssShift,ssCtrl,ssAlt]  then AlasOik;       //< 40=AlasOik
//40 :if (Shift=[ssShift]) or (Shift=[ssCtrl]) or (Shift=[ssAlt])  then AlasOik; //< 40=AlasOik
  40 :if (Shift=[ssShift])  then OikAlas (TRUE)  else         //< 40=AlasOik:  Siirtym.SIVUsuunnassa
      if (Shift=[ssCtrl])   then OikAlas (FALSE);             //< 40=AlasOik:  Siirtym.PYSTYsuunnassa
  38 :if (Shift=[ssShift])  then VasYlos (TRUE)  else         //< 38=YlosVas:  Siirtym.SIVUsuunnassa
      if (Shift=[ssCtrl])   then VasYlos (FALSE);             //< 38=YlosVas:  Siirtym.PYSTYsuunnassa
//16 :SftOn := true;                                          //< Shift
                                              //,9 = Tab  =Ei tunnista, vaan siirtää FocusinBtneille
{  9 :if (Shift=[ssShift])  then VasYlos (TRUE)  else
      if (Shift=[ssCtrl])   then VasYlos (FALSE) else         //<  9=Tab:      Siirtym.PYSTYsuunnassa
                                 VasYlos (TRUE);}             //<  9=Tab:      Siirtym.SIVUsuunnassa
{ 33 :with StrGr  do                                          //< 33=PgUp.  Toimii myös ilmankin, mutta -1xRiv
         if TopRow <= FixedRows
         then erPiip
         else if TopRow -VisibleRowCount < FixedRows
         then TopRow := FixedRows
         else TopRow := TopRow -VisibleRowCount;
  34 :with StrGr  do                                          //< 34=PgDwn
         if TopRow +VisibleRowCount -1 > RowCount
         then erPiip
         else if TopRow +VisibleRowCount -1 > FixedRows
         then TopRow := RowCount - (TopRow +VisibleRowCount -1)
         else TopRow := TopRow +VisibleRowCount -1;
  35 :with StrGr  do                                          //< 35=End +Ctrl
         if (Shift=[ssCtrl])
         then TopRow := RowCount -VisibleRowCount
         else if NOT BxG.Visible
         then LeftCol := ColCount -(LeftCol +VisibleColCount -1) +1;
  36 :with StrGr  do                                          //< 36=Home +Ctrl
         if (Shift=[ssCtrl])
         then TopRow := FixedRows
         else if NOT BxG.Visible
         then LeftCol := FixedCols;}
  end;//case
end;//BxGKeyDown
{==================================================================================================}
procedure TMoFrm.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);      begin 
// StrGr.Cells[1,7] := fImrkt0 (key,1);  //<F1 = 112
   if key=112
   then begin                            //<112 = F1. HUOM: MoFrm.KeyPreview p.o. TRUE #############
    //if ChkBxAv.Checked  then ChkBxAv.Checked := false //-1.1.3
      if syoAvOn  then ChkBxAv.Checked := false //<+1.1.3
                  else ChkBxAv.Checked := true;
      AvuChkSft (0);  end                //<Päivitetään muihinkin lomakkeisiin <<<<<<<<<<<<<<<<<<<<<
// else BxGKeyDown(Sender,Key,Shift); //<Ei koskaan näköjään tähän, vaan siirtyy lomakkeelle, TODETTU
end;
procedure TMoFrm.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);      begin
  inherited;
   NormCur;                                                           //<+12.0.0:  TaajKaytLbl muutti crHandPoint´ksi.
end;

//'suljettava vex, muuten BxG :stä tultaessa tämä ohjaisi 2x, TODETTU !!

{procedure TMoFrm.StrGrKeyPress(Sender: TObject; var Key: Char);      begin
   Beep;  end;}
   
procedure TMoFrm.StrGrKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);      begin
  inherited;
   BxGKeyDown(Sender,Key,Shift); //<Ei koskaan näköjään tähän, vaan siirtyy lomakkeelle, TODETTU ###
end;
{==================================================================================================}
procedure TMoFrm.TulostaBtnClick(Sender: TObject);         //<Object Inspectorissa LINES p.o. TYHJÄ,
      const marg=200;                                      //'muuten aRich NÄKYY lomakkeella,TODETTU
      var   i,RivPit :integer;  s,s1,s2 :string;  alpSyoAktv,alpSyoAvOn :boolean;
  procedure LF;                        begin  aRich.AddText ('<br>');  end;
  procedure lisaaKpl (ss :string);     begin  if ss<>''  then begin
                                                 ss := ss+'<br>';  aRich.AddText (ss);  LF;  end; end;
begin
 if fEhkaTarkArvo (0)  THEN BEGIN         //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell +4.0.0
   NormBtn;                               //< +2.0.5
   AvuChkSft (10);                        //< 2.0.5  0->10
//IF PaaValFrm.PrinterSetupDialog1.Execute  then begin
//IF PaaValFrm.PrintDialog1.Execute  then begin
  IF PrintDlgNola.Execute (modeNj, self)  then begin         //<OK  //DEVELOPER2 6.12.1998
     TulostaBtn.Enabled := False;
     Screen.Cursor := crHourGlass;        //<Ilman SCREENiä vipattaa!!!
     alpSyoAktv := SyoAktv;               //< +3.0.0
     alpSyoAvOn := SyoAvOn;               //< +3.0.0
    try
       if PrintDlgNola.PrintRange = rangeHelpPages
       then begin          //<Tulostetaan AVUSTEET #################################################
         with aRich  do begin
           WordWrap := true;
           Lines.Clear;                                //<Pakko (???) tyhjätä, jää muuten osa alpsta
           RivPit := Printer.PageWidth;
           PageRect := Rect(marg,0, RivPit,Printer.PageHeight);  //=2326,3389 =oaX,Y
           RivPit := RivPit-marg;
           Alignment := taLeftJustify;                 //<Ei riittänyt Obj.Inspectorista asettaen<<<
         end;//with aRich                              //'=Tämäkään eiOK. Lisättävä 1.rvlle '<left>'
         fSyoAktv (0); {=1.1.3}                        //<Jotta avuste päivittyisi aRichiin<<<<<<<<<
         SyoAvOn := true;                              //< +4.0.0
         aRich.Font.Size :=  10;                  //<,Jo tässä, jotta WHILE-silmukka laskisi oikein.
         aRich.Font.Style := [fsBold];
         aRich.AddText ('<left>'); //<Muutetaan vasensuoraksi ######################################

         s1 := otsikko (RivPit,'MOOTTORILÄHTÖKÄSITTELYOSAN YLEISET OHJEET SEKÄ SELITYKSET: ',aRich.Font);
         s2 := otsikko (RivPit,'SARAKEKOHTAISET SELITYKSET: ',aRich.Font);
       //s3 := otsikko (RivPit,'SYÖTTÖIKKUNAKOHTAISET SELITYKSET: ',aRich.Font);
         aRich.Font.Size :=  8;                        //<,Vex, jotta <..> workkisi, muuten ei onaa,
         aRich.Font.Style := [];                       //<' TODETTU ################################
                           //,,Lisätään mjonot aRichiin ############################################
                           //,,Seuraavissa käytetään aRichin WordWrap:iä hyväksi rivijakoon ########
                           //aRich.Width := 850;  //<Pakotetaan rivt sopivn mittaisiksi ?770-200=570
         lisaaKpl ('<b><f n="" s="10">'+ s1 +'</f></b>');  LF;                //< LF=TyhjäRiviVäliin
         for i := 1 to {1}4  do begin
             s := avuste (0,-1*i,9,1);
             lisaaKpl (s);  end;

         lisaaKpl ('<b><f n="" s="10">'+ s2 +'</f></b>');  LF;    //</b> tässä järjestyksessä, nuuka
         for i := 1 to {1}35  do begin //< 31=vika
             s := avuste (0,i,9,1);
             lisaaKpl (s);  end;

         aRich.Print('');  //#######################################################################
       end//if syoAktv     //<Tulostettiin avusteet ################################################
       else begin          //<Tulostetaan LOMAKE ###################################################
         // NjFrm.PrintScale := poPrintToFit;
         // NjFrm.Print;
         PrintContent
       end;                    //NjFrm.Print; =Tulostaa FORMin painikkeineen + tlkn
    finally                                    //'NjFrm.StrGr.Print = Undeclared identifier
      TulostaBtn.Enabled := True;
      Screen.Cursor := crDefault;
      SyoAktv := alpSyoAktv;         //< +3.0.0
      SyoAvOn := alpSyoAvOn;         //< +3.0.0
      SyottoAvFrm.Hide;              //< +3.0.0 Poistetaan tulostuksesta näkyviin jäänyt vika avuste
    end;//finally
  end;//if ..Execute
 END;//if fEhka..
end;//TulostaBtnClic

procedure TMoFrm.PrintContent;
var
   destRect: TRect;
   mult: real;
   leftMargin, topMargin{, row, col},h,i : integer;
   tmpGrid: TStringGridNola;
   adate, atime: TDateTime;
 //empty: Boolean;
begin
     Screen.Cursor := crHourGlass;

     adate := date;
     atime := time;

     { Marginaali }
     if (Printer.Orientation = poPortrait) then
     begin
          leftMargin := PRINT_MARGINAL;
          topMargin :=  0;
     end
     else
     begin
          leftMargin := 0;
          topMargin :=  PRINT_MARGINAL;
     end;

     destrect.left := leftMargin;
     destrect.top :=  topMargin;

     printer.Title := PROGRAM_NAME;
     printer.BeginDoc;

     { Luodaan temp grid }
     tmpGrid :=         TStringGridNola.Create(nil);
     tmpGrid.Visible := False;
//   tmpgrid.Assign(TStringGrid(StrGr))
     tmpgrid.Assign(StrGr);                // DEVELOPER2 13.08.1998, lisätty tulostuksen ongelmien takia

     mult := printer.canvas.font.PixelsPerInch / font.PixelsPerInch * (PrintDlgNola.Zoom / 100);
     //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,DEVELOPER1
     if pyor (PrintDlgNola.Zoom) = 100  then begin //<Vois tutkia: IF PORTRAIT.., mutta riitänee näin.
        i := pyor (tmpGrid.GetMaxWidth * mult);
        if i > printer.PageWidth  then mult := printer.PageWidth / tmpGrid.GetMaxWidth;
     end; //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''DEVELOPER1

     { Luodaan otsikko }
     destrect.top := destrect.top + PrintHeader(self, printer.canvas, printer.PageWidth, leftMargin, topMargin,
                     caption, 1, adate, atime, PrintDlgNola.Zoom, mult,PrintDlgNola.PrintHeader);

     tmpGrid.Visible := False;
     tmpGrid.Parent :=  self;
     tmpGrid.Width :=   tmpGrid.GetMaxWidth;

     {Tulostetaan YLÄpaneeli}                 //<DEVELOPER1,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
     { Merkataan mitä ei tulostetaa }
    SuljeBtn.tag :=   SuljeBtn.tag          or PRINT_DISABLED;
    LueBtn.tag :=     LueBtn.tag            or PRINT_DISABLED;
    TalBtn.tag :=     TalBtn.tag            or PRINT_DISABLED;
    TulostaBtn.tag := TulostaBtn.tag        or PRINT_DISABLED;
    OkBtn.tag :=      OkBtn.tag             or PRINT_DISABLED;
    PalautBtn.tag :=  PalautBtn.tag         or PRINT_DISABLED;
    KopBtn.tag :=     KopBtn.tag            or PRINT_DISABLED;
    PoistaBtn.tag :=  PoistaBtn.tag         or PRINT_DISABLED;
    OhjeBtn.tag :=    OhjeBtn.tag           or PRINT_DISABLED;
    ChkBxAv.tag :=    ChkBxAv.tag           or PRINT_DISABLED;
    ChkDet.tag :=     ChkDet.tag            or PRINT_DISABLED;
    PvBtn.tag :=      PvBtn.tag             or PRINT_DISABLED;
    LbPvita.tag :=    LbPvita.tag           or PRINT_DISABLED;

     { Merkataan mitkä leviävät sivun levyisiksi }
     PanelY.tag := PanelY.tag or PRINT_WIDTH_FIT_TO_PAGE;
     PanelA.tag := PanelA.tag or PRINT_WIDTH_FIT_TO_PAGE;

     destrect.top := destrect.top +
      PrintControlEx(PanelY, destrect.left, destrect.top, printer.canvas, mult,
                     PRINT_BG_COLOR, true, printer.PageWidth - leftMargin);

     { Tulostetaan StrGr }
//   tmpGrid.Height  := tmpGrid.GetMaxHeight; //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,DEVELOPER1
     with tmpGrid  do begin                   //<,Tutkitaan vika arvorivi =jos FixedCols :ssa string
          h := 0;
          for i := 0 to RowCount -1  do
              if Cells [FixedCols,i] <>''  then h := h +RowHeights[i] +GridLineWidth
                                           else Break;
          i := tmpGrid.GetMaxHeight;
          if h > i  then Height := i       //<VarmVuoksi
                    else Height := h;
     end; //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''DEVELOPER1

     destrect.top := destrect.top +
        PrintControlEx(tmpGrid, destrect.left, destrect.top, printer.canvas,
                       mult, 0, false, printer.PageWidth - leftMargin );

     tmpGrid.Free;

     { Tulostetaan alapaneeli }
     destrect.top := destrect.top +
           PrintControlEx(PanelA, destrect.left, destrect.top, printer.canvas,
                          mult, PRINT_BG_COLOR, true, printer.PageWidth - leftMargin);

     printer.EndDoc;
     Screen.Cursor := crDefault;
end;//PrintContent

procedure TMoFrm.LueBtnClick(Sender: TObject);      VAR tyhb :boolean;      begin //,,Ks.Ari Becks, s.516
   tyhb := fEhkaTarkArvo (0);  //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell  +4.0.0
   if tyhb  and LueTalMoFile (LueTR,KysTR,MoFilen)  then begin
      SyottoAvFrm.Hide;        //<+3.0.0
      NormBtn;                 //< +2.0.5
    //AvuChkSft (10);          //< 0=Sijoittaa saman muihin Frmeihin  10=Vapauttaa  11=Lukitsee -4.0.0
      moVEo;
      EditMoFrm;           //<UUSI EDIT.##### Asettaa myös PalautBtn. + PoistaBtn.Enabled TR/FA ####
   end;
end;//LueBtnClic

procedure TMoFrm.TalBtnClick(Sender: TObject);      begin
   if fEhkaTarkArvo (0)  then begin          //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell +4.0.0
      SyottoAvFrm.Hide;                      //<+3.0.0
      NormBtn;                               //< +2.0.5
    //AvuChkSft (10);                        //< 2.0.5  0->10.  -4.0.0
      if fOKrivit
      then if LueTalMoFile (LueFA,KysTR,MoFilen)
              then FrmOtsikko;  end;
end;//TalBtnClic

procedure TMoFrm.OkBtnClick(Sender: TObject);      VAR i,j :integer;   //s :string;
begin//OkBtnClick
//if fUn<>fUmo  -6.0.1b
  i := fUn;
  j := fUmn;
  if i<>j
  then
  (*{if }MessageDlg('Verkkojännite edeltävässä verkossa '+fImrkt0 (fUn,1)+' V poikkeaa moottorilähtöjen '+
     'laskentajännitteestä.   Korjaa ensin moottorilähtöjännite tai edeltävän verkon jännite!',
     mtConfirmation, [mbOK{,mbYes{, mbNo}], 0){ = mrYes then ..}*)
     InfoDlg ('Verkkojännite edeltävässä verkossa '+fImrkt0 (fUn,1)+' V poikkeaa moottorilähtöjen '+ //+6.2.2
              'laskentajännitteestä.   Korjaa ensin joko moottorilähtöjen jännite tai edeltävän verkon jännite!',
                 mtCustom,  'OK','','','',  '','','','')
  else begin
     if fEhkaTarkArvo (0)                 //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell +4.0.0
     then if fOKrivit  then begin
        SyottoAvFrm.Hide;                 //<+3.0.0
        NormBtn;                          //< +2.0.5
      //AvuChkSft (10);                   //< 2.0.5  0->10.  -4.0.0
        Screen.Cursor := crHourGlass;
        j := 0;                           //,Jotta arvot päivittyisivät ############################
        for i := 11 to 11  do  if NOT arvoOK (i,{6}8)  then begin //else begin  FocusBak(Sender???);  6=>8=+8.0.2
           j := i;
         //erPiip;  EiOKinfo ('Alapanelin syöttöikkunoiden arvoissa ristiriitaa !'); //<ArvoOK piip+herja  4.0.0
           Break;  end;
        SijMouIfVE1;                      //< +4.0.0
        if j=0  then begin                //<j=0 = Kaikki ok <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
           OkBtn.Enabled := false;
           Update;                        //<Jotta StrGr :stä poistetun Boxin paikka korjautuisi <<<
         //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Siirtyminen NJ-laskentaan @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         //yhtArvot;       //<Varmksi, jos vaikka ei olekaan päivitetty. VEX: p.o FORWD, ~Lienee OK
           MootNJ := true; //<Ohjaa NjVrk.PASsia sijoittamaan MoNj -tietueen nj.jk[1] :een. := FA EdvNewFormCLOSE
           MoNj.mInfo := MoFrm.LbA1.Caption;          //<VAIN TÄSSÄ ##########################################
           kesja := 1;   a_putIntg (106,kesja, nj.jy.Ketjussa); //< +4.0.0  Siirretty NjVrk.INC/EditNjFrm :sta,
                                                                //' muut nj.jy.. sij. ao. Mo..INC :ssa !!!!!!!
           PaaValFrm.NjLaskentaNapClick(Sender);      //<Ohjaa NjVrk.INC / EditNjFrm :iin <<<<<<<<<<<<<<<<<<<<
           EdvNewFrm.OkBtnClick(Sender);              //<+7.0.3  Avaa NJ-laskentatietojen ikkunan suoraan.
        end;
        OkBtn.Enabled := true;
        Screen.Cursor := crDefault;
     end;
  end;//else
end;//OkBtnClic

{==================================================================================================}
function OKsenderBx1_6(Sender :Tobject;  var nro :integer) :boolean;   //var s :string;
     procedure prc(boxi :integer);   begin                     //###################################
       OKsenderBx1_6 := true;                                  //'KÄYTETÄÄN KAIKISSA ComBx EVENTssä
       nro := boxi;   end;                                     //'#### PALAUTTAA KUTSUVAN RIVIN ####
begin
  result := false;
  with MoFrm  do
    if Sender=Bx1      then prc(1)  else
    if Sender=VrkCmBx  then prc(3);
end;//FNC OKsenderBx1_6

procedure FocusBak(Sender :TObject);      var no :integer;      begin
  if OKsenderBx1_6(Sender,no)  then
  with MoFrm  do
  case no of
     1 :Bx1.SetFocus;
     3 :VrkCmBx.SetFocus;
  end;//case
end;//FocusBak

procedure TMoFrm.Bx1_6Enter(Sender: TObject);      VAR no :integer;      begin//<,Kylläkin vain yhtä Boxia varten
   SyottoAvFrm.Hide;                //< +4.0.0
  {if}fEhkaTarkArvo (0);//then begin//< +2.0.5 JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell.  +4.0.0 IF
      NormBtn;                      //< +2.0.5
      Chk_SftUm_AsBtns;             //< +4.0.0  Koska NormBtn muutti
    //AvuChkSft (0);                //< -4.0.0aa ???? Turha tässä ?????
      if OKsenderBx1_6(Sender,no)  then begin //<, 4.0.0  -PRC
         AvuChkSft (11);                                 //< +2.0.5
      //{if NOT syoAvOn  then }SyottoAvFrm.Hide;         //< +1.1.3 =SyoAktv korvattu, sekin tarpeeton
         sijBxG (0,no);                                  //< no = ao. Box, sijBxG :ssä +10 ohjaa oikeaan
     end;
//end;
end;//Bx1_6Enter
                                                                             
{#### OnKeyPress:iin myös tarkistus, koska siellä ohjataan seur. boxiin. Tässä: TAB+SfTAB+Click####}
procedure TMoFrm.Bx1_6Exit(Sender: TObject);      var no :integer;      begin //<1_6 = Nyt vain Bx1=SulSft
//fSyoAktv (0); {=1.1.3 +1.1.2}                 //< -2.0.5        //<Ks.Enter: Muuten avuste vilkkuu MouseMovella
  AvuChkSft (9);                                //< +2.0.5
  if ActiveControl<>SuljeBtn   then                               //<PäästäväPois ilman tarkistuksia
  if OKsenderBx1_6(Sender,no)  then             //,syoAktv := FA.. jotta seur. avuste mahdollinen
  if NOT arvoOK (no+10,{6}8)                    //< 6=>8=+8.0.2
     then FocusBak (Sender)
   //else editMoFrm;      //<Tutkimatta, onko todellisia muutoksia SulSft :ssä
     else begin
          SijMouIfVE1;           //< +4.0.0
         {if (alpSft=a_getReaa (120, mo.moty.sulSft)) and (alpUm=a_getIntg (120, mo.moty.Umo))
             then PvBtnOff
             else PvBtnOn;  end;}
          Chk_SftUm_AsBtns;                                //< +4.0.0
          alpSft := a_getReaa (120, mo.moty.sulSft);       //< +4.0.0  ALP-sij. Chk_..´n jälkeen. Takas +6.0.3
          alpVrk := a_getIntg (121, mo.moty.Vrk);  end;    //< +6.0.3
end;//Bx1_6Exit

(*procedure TMoFrm.Bx1_6KeyPress(Sender: TObject; var Key: Char);      var no :integer;      begin
 {if key=#32  then begin  Y_piipit(50);  //Bx1.Text := 'Ä';   end else }
  if key=#13
  then begin
    if OKsenderBx1_6(Sender,no)  then
    if arvoOK (no+10,{6}8)  then  //<Tarkistus riittää. RTN ei siirrä focusta, OK.  6=>8=+8.0.2
    case no of
       1 :SelectNext(Bx1, true,true);         4 :SelectNext(Bx4,  true,true);
       2 :SelectNext(Bx2, true,true);         5 :SelectNext(Bx5,  true,true);
       3 :SelectNext(Bx3, true,true);         6 :SelectNext(Bx6,  true,true);  end;//case
  end //if key=
end;//Bx1_6KeyPress *)

procedure TMoFrm.Bx1_6MouseMove(Sender: TObject;  Shift: TShiftState;  X,Y: Integer);        var no :integer;
     procedure prc (boxi :integer);   begin
       if syoAvOn and NOT syoAktv and NOT apuaOn        //< +1.1.3
          then begin end; {avust (1,boxi+40, 0);  }end; //< -2.0.5 Toimii OK, mutta otettu takas vex.
  begin  if OKsenderBx1_6 (Sender,no)  then prc (no);
         NormCur;                                       //<+12.0.0:  TaajKaytLbl muutti crHandPoint´ksi.
  end;//Bx1_6MouseMove

procedure TMoFrm.StrGrTopLeftChanged(Sender: TObject);      begin
{  BxG.Visible := false;
   PanelY1.Visible := false;
   PanelY1o.Visible := false;} //,########################################################################
   BxG.Visible := false;       //<BxGAuki´n arvo edelleen voimassa, joten MxG.Text -arvoa voi tutkia 4.0.0
   PanelY1.Visible := false;   //'########################################################################
   LbYo.Visible :=    false;
{  LbY1o.Visible :=   false;
   LbY1o1.Visible :=  false;
   LbY1o2.Visible :=  false;
   LbY1o3.Visible :=  false;}
end;

procedure TMoFrm.ChkBxAvMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState;  X,Y: Integer);
begin                            //'=TapahtuuKunKlikattu ChkBxAv :ta, CB -ARVO EI VIELÄ EHTINYT MUUTTUA, TODETTU.
  inherited;                     //,,Vaihdetaan cbUnChecked, muuten eventti vaihtaa Grayed -> Checked -> UnCheckd
   NormBtn;                      //< +2.0.5
   BxGAukiVisOff;                //< PRC 4.0.0  BxGAuki+Visible := FA, koska ei fEhka... -kutsua
   apuaOn := false;
                 //==Jos tässä sij. cb -arvo, menee ChkBxAvClick -eventiin, eli ei voi lisätä muuta: Menee ENDiin
   if ChkBxAv.State IN [cbGrayed,cbChecked]            //<Pakotet. cbGrayed t. cbChecked -> cbUnChecked
      then Gray_Chkd := true                           //<,Ei voi asettaa suoraan STATEa: aiheuttaa
      else Gray_Chkd := false;                         //  eventin, TODETTU.########################
                                     Qedic (ChkBxAv.State,'<br>[1]');  Qedic_ (' \Grd='+fBmrkt0 (Gray_Chkd,2));
end;                                                        //''Jos nämä tässä, EI ChkBxAvClick -EVENTIÄ, TODETTU
                                                       //,,AvCloseOK on aina päällä, FA vain AvuChkSf :stä
procedure TMoFrm.ChkBxAvClick(Sender: TObject);   begin//,,CheckedArvo onJo ehtínyt vaihtua Clickin jälk, TODETTU
                                     Qedic (ChkBxAv.State,' [2.1]' );  Qedic_ (' \Grd='+fBmrkt0 (Gray_Chkd,2));
 //ChkBxAv.State := cbChecked;  //<Aiheuttaa eventin jolloin tulee uudestaan tähän, jos State<>cbChecked, TODETTU
   if AvCloseOK  then begin                            //<Vain ekalla kerralla läpi, 2.krt tullaan AvuChkSf :stä
      if Gray_Chkd  then begin
         ChkBxAv.State := cbUnChecked;                 //<Vain ChkBxAvMouseDown :sta. Aiheuttaa EVENTIN @@@@@@@@@
{2.0.5+} fSyoAktv (0);  end;            //<Koska SYOAKTV+SYOAVONin perusteella Grayed/Chkd/UnChkd AvuChkSft :ssa
      if ChkBxAv.State=cbUnChecked
{2.0.5+} then begin syoAvOn := false;   //<, SYOAVON asetus VAIN TÄSSÄ + StrGrDblClick :ssä #####################
                    SyottoAvFrm.Hide;  end
{2.0.5+} else       syoAvOn := true;                   //<Kattaa cbGrayed + cbChecked
                                                                  Qedic (ChkBxAv.State,' [2.2s]');
      AvuChkSft (0);  end;
   Gray_Chkd := false;                                 //<Vain ChkBxAvMouseDown :ssa @@@@@@@@@@@@@@@@@@@@@@@@@@@@
                                                                  Qedic (ChkBxAv.State,' [2.3]' );
end;//ChkBxAvClick
//==================================================================================================
procedure TMoFrm.LbPvitaMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);      begin
  inherited;
   NormCur;                                                           //<+12.0.0:  TaajKaytLbl muutti crHandPoint´ksi.
end;

procedure TMoFrm.LbUnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);      begin
  inherited;
   NormCur;                                                           //<+12.0.0:  TaajKaytLbl muutti crHandPoint´ksi.
end;

procedure TMoFrm.LbY1r0MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);      begin
   if MoFrm.Active  then                                                                         //<+6.1.1
   if {MoFrm.ChkBxAv.Checked}syoAvOn  then avust ( 0,-2, 0);   end; //< -+1.1.3

procedure TMoFrm.EdiY1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);       begin
   if MoFrm.Active  then                                                                         //<+6.1.1
   if {MoFrm.ChkBxAv.Checked}syoAvOn  then avust ( 0,-2, 0);   end; //< -+1.1.3

procedure TMoFrm.LbY1r1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);      begin
// MoFrm.EdiY1.Text := '';
   if MoFrm.Active  then                                                                         //<+6.1.1
   if {MoFrm.ChkBxAv.Checked}syoAvOn  then avust ( 0,-3, 0);   end; //< -+1.1.3

procedure TMoFrm.LbY1r2MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);      begin
   if MoFrm.Active  then                                                                         //<+6.1.1
   if {MoFrm.ChkBxAv.Checked}syoAvOn  then avust ( 0,-4, 0);   end; //< -+1.1.3

procedure TMoFrm.EdiY1Change(Sender: TObject);      begin
   a_putStrg (30301, EdiY1.Text, mo.moty.Kuvaus);
   SijMouIfVE1;  end;                               //< +4.0.0
//==================================================================================================
procedure TMoFrm.FormActivate(Sender: TObject);
  procedure avu(boxi :integer);      begin                   //'Tapahtuu myös FrmCreatillä
    avust ( 1,boxi+30, 0);
  end;
begin//FormActivate
  if ActiveControl=Bx1  then avu(1);{else                    //<StrGr:n Box suljettiinAINA Deact:ssa
  if ActiveControl=Bx2  then avu(2)  else                    //joten Bx :ää ei tarvitse huomioida,
  if ActiveControl=Bx3  then avu(3)  else                    //koska se ei voi olla auki formin akti
  if ActiveControl=Bx4  then avu(4)  else                    //voituessa<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  if ActiveControl=Bx5  then avu(5)  else
  if ActiveControl=Bx6  then avu(6);}
end;
procedure TMoFrm.FormClose(Sender: TObject; var Action: TCloseAction);      begin //120.5k =Puuttui aiemmista versioista =tallensi vain TalBtn´illa.
  inherited;
   TalBtnClick(Sender);
end;

//FormActivate

procedure TMoFrm.FormDeactivate(Sender: TObject);      begin
 //BxGAukiVisOff;                             //< +4.0.0  BxGAuki+Visible := FA, varm.vuoksi.
   MoFrm.BxG.Visible := false;                //<Visible := FA, varm.vuoksi. EI BxGAuki := FA, TODETTU !!!!!!!!!!!
end;

procedure TMoFrm.FormShow(Sender: TObject);      VAR s :string;      begin
   s := MoFilen;
   Caption := PROGRAM_VERSIO_STRING +':  Moottorilähdöt' {+6.2.10} +':  '+s{+7.0.5};
   StrGr.Align := alClient;                   //< +4.0.0
   FormResize(Sender);     //< +2.0.5 =EdiY :n pituus
   eSar := 0;{+1.1.2}
   PanelA.SetFocus;                           //< +2.0.5 =Jotta Sft-? yms. workkisi
  {if syoAvOn  then ChkBxAv.Checked := true   //< -+1.1.3  +Oli FALSE,  ,,oli TRUE
               else ChkBxAv.Checked := false; //<' -2.0.5}
   AvuChkSft (0);                             //< +2.0.5
   OdotaFrm.Close;
   if demoLisAs  then begin
      OhjeEfect_ON;                           //< +2.0.5
      avuste (0, -1,9, 0);                    //< +2.0.5  Avust () ei käy, koska FrmEiNäy ja sisFocus -> Error
      OhjeEfect2_ON;  end;                    //<Lukitsee avusteen 5 sek :ksi
 //TaajKaytLb.Caption :='[ Taajuuskäytön käsittelyyn ohje TÄSTÄ ]'; //<+11.0.1:  ObjInsp:ssä jättää [  ] vex, nytOK.
   TaajKaytLb.Caption :='[ Taajuuskäyttö-, SulSiirto[%]-, Un- ja VerkkopisteOHJEET TÄSTÄ ]';
 //NayMemory;                                 //<PaaValFrm.Captionissa
end;//FormShow

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
{HELP/esim: procedure TForm1.StringGrid1SelectCell(Sender: TObject; Col, Row: Longint; var CanSelect: Boolean);
 begin  CanSelect := (StringGrid1.Cells[Col,Row]='')   end;}
procedure TMoFrm.StrGrSelectCell(Sender: TObject; Col, Row: Integer;  var CanSelect: Boolean);      begin
  {4.0.0: - StrGrMouseDown´iin lisätty selCOL,ROW :=.., JOTEN TÄMÄ LIENEE TURHA, KOKLATTU, OLKOON NÄIN.
          - Tähän tullaan AINA ekax (1. StringGridNola  2. StrGrMouseDown  3. StrGrMouseDown tms.) siis useita
            kertoja. Scrollausnytkäys clikattaessa alinta vajaasti näkyvää riviä ei näyttäisi vaikuttavan.
          - Nämä havainnot Delphi 5 :llä, mahtaiskohan ko. versio tuoneen muutoksen ???}
  inherited;                                     {ediS (fBmrkt0(NytChkScrol,2)+' top'+fImrkt0(StrGr.TopRow,1));
                                                        ' sar'+fImrkt0(sar,1)+' mrv'+fImrkt0(Mrv,2));}
                                                  //ediO ('Sel: Col'+fImrkt0(Col,1)+' Row'+fImrkt0(Row,1));
//if NOT (StrGr.Row IN [TopRow..TopRow+VisibleRowCount-1])  then CanSelect := false;
//if NOT (StrGr.Row IN [StrGr.TopRow..StrGr.TopRow+StrGr.VisibleRowCount-1])  then CanSelect := false;
//if StrGr.Row > StrGr.TopRow  then CanSelect := false; //<''Jostain syystä ei sama vaik. kuin,,,,,,
//if StrGr.Row > StrGr.FixedRows {+StrGr.VisibleRowCount -1  }then
                                            {MoFrm.EdiY1.Text := 'row'+fImrkt0 (fRow(X,Y),1)+' fix'+fImrkt0
                                               (StrGr.FixedRows,1)+'vis'+fImrkt0 (StrGr.VisibleRowCount,1);//}
// StrGr.SelectionEnabled := true;
{  if (Col IN [0..StrGr.ColCount])  and  (Row IN [0..StrGr.RowCount])
   then CanSelect := false
   else CanSelect := true;}
                        Qedic_ ('[*StrSel]0:  selC='+fImrkt0 (selCOL,1) +',selR=' +fImrkt0 (selROW,1) +//,+4.0.0
                                '  Col=' +fImrkt0 (Col,1) +' Row=' +fImrkt0 (Row,1));                  // +2.0.5
   CanSelect := false;      //<Tämä aih sen, ettei osittain näkyvän rivin Click aiheuta scrollia !!!!!!!!!!!!!
                            //'LAKKASI ÄKISTI TOIMIMASTA, SYY EI TIEDOSSA. LISÄTTY Glob bool:  NytChk..+ChkTop}
                            //'Olisikohan Delphi 3.02 -pvitys mahd. syyllinen ??? NYT TAAS TOIMII, KUMMA ?????
                            //'MUTTA NYT FixedRow t. FixedCol ALUEEN CLICK EI KOSKAAN ENÄÄ TULE TÄHÄN FNC:oon!
  if NytChkScrol            //<StrGrClick + StrGrDblClik :ssa := TRUE ########################################
  then begin {if Row > StrGr.TopRow +StrGr.VisibleRowCount -1         //<ROW=AbsolCelROW <<<<<<<<<<<<<<<<<<<<<
                then ChkTop := StrGr.TopRow;}
                                          {ediO_('//Sel: Col'+fImrkt0(Col,1)+' Row'+fImrkt0(Row,1)+'  Top'
                                           +fImrkt0(StrGr.TopRow,1)+'+visRw'+fImrkt0(StrGr.VisibleRowCount,1)+
                                           '-1='+fImrkt0(StrGr.TopRow+StrGr.VisibleRowCount-1,1)+' ');}
     //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,#################################################################
     selCOL := Col;  selROW := Row;       //<NÄMÄ MÄÄRÄÄVÄT AVAUTUVAN BxG :n PAIKAN+CELLin ###################
     //''''''''''''''''''''''''''''''''''''''#################################################################
     NytChkScrol := false;  end; //'Palautet koska Click liian alas siirsi. Toistuva chk estetty (sis.kierto)
//''EI VOI KÄYTTÄÄ  with StrGr do.. koska StrGr :n Col ja Eventin Col SEKOITTUISIVAT (tietenkin), TODETTU'''''
// StrGr.SelectionEnabled := false;
                         Qedic_ ('  [1:]  selC='+fImrkt0 (selCOL,1) +',selR=' +fImrkt0 (selROW,1) +   //< +4.0.0
                                 '  Col=' +fImrkt0 (Col,1) +' Row=' +fImrkt0 (Row,1) +'<br>');
                                         {ediS (' _ '+fBmrkt0(NytChkScrol,2)+' ctp'+fImrkt0(ChkTop,1));
                                          ediS (' COL' +fImrkt0(Col,1)+' ROW'+fImrkt0 (Row,2)+' / ');}
                                          //'vsR='+fImrkt0 (StrGr.VisibleRowCount,2)+'/ ');//}
end;//StrGrSelectCell +1.1.3
       //,,Kommentti +1.1.3:  Tähän tullaan AINA vasta MouseDown :n jälkeen (BreakPoint siellä eli ei)############
procedure TMoFrm.StrGrClick(Sender: TObject);      begin//<Tähän vasta StrGrMouseDown :n jälkeen
  inherited;                                                                       //ediS ('(Clk)');
                                       Qedic_ ('[*StrClk]'); //<+2.0.5
   if NOT MoFrm.PvBtn.Enabled  then begin   //< +4.0.0
      NytChkScrol := true;                  //<  := FALSE ..SelectSell -eventissä ################################

      if SyoAvOn  and NOT BxGAuki  and NOT Kopioi  and NOT Poista
      then begin                            //' +4.0.0  ,,Lukitaan avuste sarak :seen. BxG:n avust ks. ohjaaBxG
         fSyoAktv (0);                      //<,,130.2e:  Alekkain.
         avust ({0}1,Sar, 0);               //< CmBx:  1=Boxin avuste (lukitsee, 0=Muu avuste),  1=TulostusPaperille (0=Edit).
         fSyoAktv (1);   end                //+130.2e: 'CmBx oli 0, nyt 1 =Nyt avuste lukittu 1xKlik, vapautuu DblKlik.
      else AvuChkSft (11);                  //< 11 =Lukitsee avusteen.  -2.0.3  +2.0.5
end;//if NOT...
end;
       //,,Kommentti +1.1.3:  Tähän tullaan ennen MouseDown :nia, jonne mennään vasta tämän jälkeen. Jos BreakPoin
       //  on päällä StrGrClick :ssä tai MouseDown :ssa, EI TÄHÄN TULLA OLLENKAAN ################################
procedure TMoFrm.StrGrDblClick(Sender: TObject);      begin
  inherited;                                                                       //ediS ('(Dbl)');
   if NOT MoFrm.PvBtn.Enabled  then begin  //< +4.0.0
      DblClck := true;                     //<Estää MouseDown =OhjaaBx -tapahtuman, := FA MouseDwn ###############
      syoAvOn := true;                     //< +1.1.3 Vain tässä + ChkAvBxClick :ssä
      NormBtn;                             //< +2.0.5
      AvuChkSft (20);                      //< 10 =Vapauttaa avusteen.  -2.0.3  +2.0.5  10->20 +3.0.0
   end;//if NOT...
end;

procedure TMoFrm.ChkDetClick(Sender: TObject);      begin//<Tähän, kun MouseDwn tai MoDetFrm.Close ###############
   inherited;
   AvuChkSft (9);
   if ChkDet.Enabled  then          //<Estetty Checked :=.. aiheuttaman eventin jälkeisen seur. fEhka..-kutsun, ks.,,
   if fEhkaTarkArvo (0)
   then begin                       //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell. +4.0.0
      SyottoAvFrm.Hide;             //<+3.0.0
      NormBtn;                      //< +2.0.5
      AvuChkSft (0);                //< +2.0.5
    //BxGAukiVisOff;                //< +4.0.0  BxGAuki+Visible := FA, koska ei fEhka... -kutsua
      if ChkDet.Checked             //'Ei tarvittaisi ehkä, KOKLATTU
      then begin
           //if det  then begin
           MoDetFrm.aRich.Clear;
           Screen.Cursor := crHourGlass;       //<crDefault EdiMoFrm :ssa <<<<<<<<<<<<<<<<<<<<<<<<<<
           EditMoFrm;  end                     //<Putsaa ekax ja lisää loppuun:  ==..RIVEITTÄIN:==..
      else MoDetFrm.Close;  end                //<Avaus'' putsaa (=EditMoFrm :ssa Clear)
   else if ChkDet.Checked
   then begin
        ChkDet.Enabled := false;               //<Estää seur. Checked :=.. aiheuttaman eventin fEhka.. kutsun, ks.ed.
        ChkDet.Checked := false;               //<Clickaus muutti chekatuksi ja koska eiOK, muutetaan takas.
        ChkDet.Enabled := true;
        if BxGAuki  then begin
           BxG.Visible := false;               //<Ekax vex, jotta focus onaisi.
           BxG.Visible := true;
           BxG.SetFocus;   end;
   end;
end;
//ChkDetClick

procedure TMoFrm.StrGrAfterPaint(Sender: TObject);      begin
  inherited;
   if StrGr.LeftCol=1  then begin
      PanelY1.Visible := true;
      LbYo.Visible :=    true;
      LbY1o.Visible :=   true;
      LbY1o1.Visible :=  true;
      LbY1o2.Visible :=  true;
     {LbY1o3.Visible :=  true;}  end;
end;//StrGrAfterPaint

procedure TMoFrm.UmCmBxEnter(Sender: TObject);      VAR tmpItems :TStringList;  //i :Integer;
begin
  inherited;          //,,,,,,,TEKEE ITEM-LISTAN: 'Oletus;Item[0];Item[1]... #######################
    SyottoAvFrm.Hide;             //<+3.0.0
    fEhkaTarkArvo (0);            //< +2.0.5 JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell
    NormBtn;                                     //< +2.0.5
    Chk_SftUm_AsBtns;                            //< +4.0.0  Koska NormBtn muutti
    AvuChkSft (11);                              //< +2.0.5
    {###################,,,,,,,####################################################################}
    tmpItems := f_Items(BxItems(12,MoKut));               //<Tehdään BXITEMS:stä ITEM-lista TmpITEMS
    {###################'''''''####################################################################}
    MoFrm.UmCmBx.Items.Assign(tmpItems);                  //<ASSIGN =ei tartte ekax Clear
    tmpItems.Free;   //<####### VASTA TÄSSÄ SAA TUHOTA. MUUTEN OSOITIN HÄVIÄÄ LIIAN AIKAISIN #######

    with MoFrm.UmCmBx  do begin          //,, -4.0.0
     {Text := Items.Strings[0];                  //<Oletusikkunaan arvo ############################
      i := 2;                            //,EiOnaa: if Text=Str[0],koska Text onKoko"rimpsu",TODETTU
      if Items.Strings[0]=Items.Strings[1]  then begin
        while i<Items.Count  do begin            //<Siirret "ylemmäksi", koska [0]=strOletus (=Text)
          Items.Strings[i-1] := Items.Strings[i];//'ja [1]:ssä oli sama, joten [0] joutaa vex. Näin,
          i := i+1;                              //'vaikka listassa oleva SAMA varjostuukin, mutta
        end;                                     //'varjostus häviää, jos oletusarvo pyyhitään.
      Items.Delete(Items.Count-1);               //<Muuten  vikan rivn sisältö näkyy kahdella rivllä
      end;//if Strings..}
      ItemIndex := 0;                    //< +4.0.0
      DropDownCount := 30;               //< +4.0.0
    end; //with ..
end;//UmCmBxEnter

procedure TMoFrm.UmCmBxExit(Sender: TObject);
begin
  inherited;
   AvuChkSft (9);                        //< +2.0.5
   if NOT arvoOK (12,{6}8)               //< 6=>8=+8.0.2
      then UmCmBx.SetFocus
      else begin
           SijMouIfVE1;                  //< +4.0.0
          {if (alpSft=a_getReaa (130, mo.moty.sulSft)) and (alpUm=a_getIntg (130, mo.moty.Umo))
              then PvBtnOff
              else PvBtnOn;  end;}
           Chk_SftUm_AsBtns;                             //< +4.0.0
           alpUm :=  a_getIntg (130, mo.moty.Umo);  end; //< +4.0.0  ALP-sij. Chk_..´n jälkeen. Takas +6.0.3
end;

procedure TMoFrm.UmCmBxChange(Sender: TObject);      begin
  inherited;
  Chk_SftUm_AsBtns;
end;

procedure TMoFrm.Bx1Change(Sender: TObject);      begin
  inherited;
  Chk_SftUm_AsBtns;
end;

procedure TMoFrm.PvBtnClick(Sender: TObject);
begin
  inherited;                   Qedic_ ('[===PvBtn]');
   NormBtn;                    //< +2.0.5
   AvuChkSft (9);              //< +2.0.5  9=Jos syoAvOn ja syoAktv -> cbChecked
   editMoFrm;
   BxGAukiVisOff;              //< +4.0.0  BxGAuki+Visible := FA, koska ei fEhka... -kutsua
end;

procedure TMoFrm.PanelAMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);      begin
  inherited;                             //+12.0.0  Kaikki uutta.
   if apuaOn
      then apuaOn := false;
   avuste(0,99,9,0);                     //<Aina avuste, se vaihtuu, kunhan NOT syoAktv.
   if syoAktv
      then fSyoAktv (0)
      else fSyoAktv (1);
end;

procedure TMoFrm.PanelAMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  inherited;
   NormCur;                                                           //<+12.0.0:  TaajKaytLbl muutti crHandPoint´ksi.
 //if NOT syoAktv  then SyottoAvFrm.Hide;                                  //< Alp.
 //if NOT syoAktv  and  syoAvOn  and  NOT apuaOn  then SyottoAvFrm.Hide;   //< 1.1.3 Korjattu. -2.0.5
 //''''EI Lukittu   +   Ruksi     +   EI OhjeBtn
   if NOT apuaOn                            //<+12.0.0:  Ei poisteta klikattua "?" avust.
      then avuste(0,99,9,0);                //<+11.0.1:  Jotta eRv SyottoAv:ssa muuttuisi, vrt. TaajKaytLb...Move
                                            //,,-12.0.0
  {if MoFrm.Active  then                    //           '99 =Avu_9_Moo :n case -tlkossa ei ole 99.
   if NOT syoAktv  and  syoAvOn  then                                                            //<'+6.1.1
      SyottoAvFrm.Hide; //< 2.0.5 Korjattu.}
end;

procedure TMoFrm.FormResize(Sender: TObject);      begin //< +2.0.5
  inherited;
   EdiY1.Width := PanelY.Width -EdiY1.Left; //< =EdiY :n pituus
  {if IsDebuggerPresent  then
      MoFrm.Caption := Ints(MoDetFrm.Width); //+'  ' +Caption; //<+120.-5k}
end;

procedure TMoFrm.TaajKaytLbMouseMove(Sender: TObject;  Shift: TShiftState;  X,Y: Integer);      begin //+11.0.1
   inherited;
{//Hint := MoTaajMuut;
 //avuste(0,2, 9, 0); //~OK, mutta sis. Pn [2]...
  {TaajKaytLb.Hint := 'Taajuusmuuttajakäytöissä (myös ns. pehmokäynnistimet) valitse Pn [2] siten, että Ist [14] '+
           '(käynnistysvirta) on vähintäin taajuusmuuttajan In, mieluimmin hieman enemmän.';
   TaajKaytLb.ShowHint := True; //<''Nämä OK.================ Vaati TaajKaytLb eteen.}
   Screen.Cursor := crHandPoint;                //<+12.0.0
   avuste(0,52, 9,0);                           //<Pelkkä MoTaajMuut, (0,52, 9,0):ssa Pn [] yms.
   MoFrm.SetFocus;                              //<Jotta F1 = Frm.KeyDown workkisi JA FOCUS säilyis muutenkin
end;

procedure TMoFrm.TaajKaytLbClick(Sender: TObject);      begin//+11.0.1
   inherited;                                                //,,-12.0.0 Poistettu näkyvistä, näkyy jo PanelA/MouseMove´lla.
   if NOT MoFrm.PvBtn.Enabled  then begin //Kopioitu StrGrClick´istä;
      if SyoAvOn  and NOT BxGAuki  and NOT Kopioi  and NOT Poista
      then begin                               //' +4.0.0  ,,Lukitaan avuste sarak :seen. BxG:n avust ks. ohjaaBxG
         fSyoAktv (0);  {avust (0,Sar, 0);}
         avuste(0,52, 9,0);                    //<Pelkkä MoTaajMuut, (0,52, 9,0):ssa Pn [] yms.
         MoFrm.SetFocus;                       //<Jotta F1 = Frm.KeyDown workkisi JA FOCUS säilyis muutenkin
         fSyoAktv (1);   end
      else AvuChkSft (11);                     //< 11 =Lukitsee avusteen.
   end;
end;

procedure TMoFrm.TaajKaytLbDblClick(Sender: TObject);      begin//+11.0.1:  Kopioitu osittain StrGrDblClick´stä.
   inherited;
   syoAvOn := true;                     //< +1.1.3 Vain tässä + ChkAvBxClick :ssä
   NormBtn;                             //< +2.0.5
   AvuChkSft (20);                      //< 10 =Vapauttaa avusteen.  -2.0.3  +2.0.5  10->20 +3.0.0
end;

procedure TMoFrm.BxGKeyPress(Sender: TObject; var Key: Char);      begin //+11.0.1
   inherited;
  if Key=#13   then
     Key := #0;                                 //<11.0.1:  Enterin beep vex.
end;

procedure TMoFrm.BxGChange(Sender: TObject);
begin
  inherited;
   beep;
end;

procedure TMoFrm.ComboBox1Change(Sender: TObject);
begin
   beep;
end;


initialization
  sar := 0;  eSar := 0;   Mrv := 0;  eMrv := 0;
  BxGAuki := false;
  BxSar := 0;  BxMrv := 0;                      //< +4.0.0
  moVE := 1;                                    //< +4.0.0
  poista := false;    kopioi := false;
 {ChkTop := 0;  }NytChkScrol := true;    //<Pakko tässä, jotta ekallakin Clickillä TRUE ######################
  DblClck := false;  selCOL := 0;  selROW := 0;
  Gray_Chkd := false; //< +1.1.3
  MoFilen :=  '';
  DetWdth := -1;                                //+120.5k
end.
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

