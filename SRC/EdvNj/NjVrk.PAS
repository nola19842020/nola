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
unit NjVrk; //m++ =Kopioitu (mahd. vain osa) Moot.PAS :sta, esim. fSyoAktv ();  ..MouseMove.. yms.
{###################################################################################################
 NjVrk.INC:  (NjFrm.)ShowModal; //< +1.1.3  Nyt ei enää olisi Edv:ssä tarpeen BtnClickeissä yms. sulkea NjFrmia
 TOIMINTAPERIAATE: - StrGr -alueella tapahtuvat näpäytykset ohjautuvat StrGrMouseDown-tapahtumaan,
                     josta FNC fEhkaTarkArvo tutkii, oliko näp sallitulla alueella ja oliko BxG auki.
                     Jos BxG oli auki, tutkitaan sisällön oikeellisuus FNC arvoOK:ssa, joka sijoit-
                     taa arvon kutsuparametriinsa (jk[]...). BxG suljetaan ja sen sisältö siirretään
                     StrGr:n Celliin (PRC pvRivi/EditNjFrm).
                   - Painikenäpäytykset aiheuttavat samat rutiinit kuin edellä on kuvattu.
                   - Tarkistuksen jälkeen OHJAABxG avaa BxG:n haluttuun paikkaan.
                   - FNC fEhkaTarkArvo valvoo, että uudella rivillä tietoja voidaan syöttää vain sa-
                     rakejärjestyksessä peräkkäin.
             >>>>> - Koska TOP/LEFTCOL -asetukset siirtävät ruutua (jos säädetty pieneksi) ja liikautus
                     SULKEE BxG :n, asetetaan BxG :n OnENTER -eventissä BxGauki -muuttuja TR(FA:=fEhka..),
                     mistä tiedetään, että BxG.Text :n arvo on luettavissa vaikka VISIBLE=FA !!!!!!!
                   - MouseDown -tapahtumat ohjautuvat aina (ei fixedROW/COL -alueelta) OnSelectCell -
                     eventiin, missä määrätään selCOL ja selROW sekä talletetaan TOP ja LEFTCOL (selLFT,
                     selTOP), mistä selvitetään, mahtuiko CELLI kokonaan ruutuun: Jos ei asetetaan
                     TOP/LEFTCOL uudelleen MOUSEDOWNssa.
                        Jos Click FIXED.. alueelle, tutkitaan paikka jo MouseDouwn :ssa.
                   - BxGKeyPres -eventissä asetetaan Sft/Ctrl yms. ohjausten mukaan myös BxCol/Row

nj,njf,nj0,nju:    - NJ :hin syöttötiedot, jotka siirretään NJU:hun (nju := nj)
                   - PALAUTA-napilla vuorotellen NJ := NJF,NJ0,NJU
                   - NJF ja NJ0 :n ARVOIHIN EI KAJOTA
                   - Frm:n aktivoituessa tarkistetaan, onko NJ, NJF tai NJ0 :ssa eri tietoja (NjVeja)
                     ja PalBtnEnabled := sen mukaan (TR/FA) => NYT AINA VAIN PVRIVI HOITAA !!!!!!!!!
                   - Muutos testataan myös syöttötapahtumien aikana (NjVeja testaa myös NJ0:n, eriNJ
                     testaa vain NJF:n mutta sitä eioo käytetty, koska NjVeja testi kattaa senkin)
###################################################################################################}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs, Forms, NolaForms,
  Grids, StringGridNola, StdCtrls, ExtCtrls, ComboBoxXY, {FileCtrl,} ComCtrls,
  RichEditNola, {DEVELOPER1+}inifiles, Printers, Settings, System.UITypes;

type
  TNjFrm = class(TFormNola)
    Panel1: TPanel;
    SuljeBtn: TButton;
    StrGr: TStringGridNola;
    PoistaBtn: TButton;
    OkBtn: TButton;
    TulostaBtn: TButton;
    OhjeBtn: TButton;
    BxG: TComboBoxXY;
    LueBtn: TButton;
    TalBtn: TButton;
    KopBtn: TButton;
    PalautBtn: TButton;
    aRich: TRichEditNola;
    Lb1: TLabel;
    Lb2: TLabel;
    Lb3: TLabel;
    Lb4: TLabel;
    Lb5: TLabel;
    Lb6: TLabel;
    Lb7: TLabel;
    Lb8: TLabel;
    Lb9: TLabel;
    Bx1: TComboBoxXY;
    Bx2: TComboBoxXY;
    Bx3: TComboBoxXY;
    Bx4: TComboBoxXY;
    Bx5: TComboBoxXY;
    Bx6: TComboBoxXY;
    Bx7: TComboBoxXY;
    Bx8: TComboBoxXY;
    Bx9: TComboBoxXY;
    ChkBxAv: TCheckBox;
    DetRad: TGroupBox;
    DetRad1: TRadioButton;
    DetRad2: TRadioButton;
    DetRad3: TRadioButton;
    AlCuRad: TGroupBox;
    AlBtn: TRadioButton;
    CuBtn: TRadioButton;
    AlCuBtn: TRadioButton;
    Label1: TLabel;
    procedure StrGrWidestColInRow(Sender: TObject; ACol, ARow, newWidth: Integer);
//  ,,Otettu ObjInsp :ssa vex, jotta Cell-korkeus saataisiin asetettua 18 :ksi, CmBx :ssa = 24
//  procedure StrGrHighestColInRow(Sender: TObject; ACol, ARow, newHeight: Integer);
    procedure SuljeBtnClick(Sender: TObject);
    procedure OhjeBtnClick(Sender: TObject);
    procedure PoistaBtnClick(Sender: TObject);
    procedure PalautBtnClick(Sender: TObject);
    procedure KopBtnClick(Sender: TObject);
//  procedure StrGrClick(Sender: TObject);
    procedure StrGrMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure StrGrMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
    procedure BxGKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure TulostaBtnClick(Sender: TObject);
    procedure LueBtnClick(Sender: TObject);
    procedure TalBtnClick(Sender: TObject);
//  procedure OkBtnClick(Sender: TObject);
    procedure Bx1_6Enter(Sender: TObject);
    procedure Bx1_6Exit(Sender: TObject);
    procedure Bx1_6KeyPress(Sender: TObject; var Key: Char);
    procedure Bx1_6MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure StrGrTopLeftChanged(Sender: TObject);
    procedure ChkBxAvClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure StrGrSelectCell(Sender: TObject; Col, Row: Integer;  var CanSelect: Boolean);
    procedure StrGrClick(Sender: TObject);
    procedure StrGrDblClick(Sender: TObject);
    procedure BxGEnter(Sender: TObject);
    procedure DetRad1_3Click(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure ChkBxAvMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
    procedure ChkBxAvMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure Lb1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure DetRadEnter(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OkBtnMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BxGKeyPress(Sender: TObject; var Key: Char);
  private
  public
    procedure PrintContent;
  end;

var
  NjTulAuki,onjoPinf,onRJinf :boolean;
  NjFrm: TNjFrm;
  Katuval :boolean;                   //<+7.0.3
  procedure EditNjFrm;                                            //<,,Tässä, jotta PaaVal tunnistaa
  function LueTalNjFile (LUE,KYSY :boolean;  inFilen :string) :boolean;
  function det1 :boolean;
  function det2 :boolean;
  function det3 :boolean;
  procedure pvitaDiskontStrGr;
  FUNCTION fKertaSuor_Diskont  (Tim,KasvuPrs :Real) :Real;
  function fKertaSuor_lop_arv (prosArvo :integer;  Suure,KasvuPrs :Real) :real;
  FUNCTION fToistvSuor_Diskont (Tim,KasvuPrs :Real) :Real;
  function fToistvSuor_nyk_arv (Suure,KasvuPrs :Real) :real;
//FUNCTION fToistvSuor_lop_arv (Suure,Tim,KasvuPrs :Real) :Real; //<Ei käytetty
  FUNCTION fKeskiNjCos :real;               //<PRC ketjuarvot PITÄÄ OLLA KUTSUTTU ENNEN TÄTÄ KUTSUA.
  FUNCTION fPHaika (uusin :Boolean;  cosPH :Real) :Integer;  //<FNC=HÄVIÖhuipn käyttöaika[h/a]. GLOB
  FUNCTION fKESmk  (uusin :Boolean;  cosPH :Real) :Real;     //<HÄVIÖenergKESKIhinta[€]. GLOB

  function njAL :boolean;                //<,,Siirretty 6.0.0
  function njCU :boolean;
  FUNCTION mm2i (mm2 :real) :integer;    //<### UUSI =Palauttaa KAHITAUn []-osoitteen = f(mm2) #####

implementation
                                         //,,SyottoAvFrm.SyoAv.Clear :n takia. KOE ..Lines.Add takia
uses Syotto,SyottoAv, Defs, Globals, PaaVal, Y_, Herja1, {}Koe, PrintDialogNola, NjTul3, textBaseTexts,
     LaskeeOd, EdvNew{Updaten takia 4.0.0},InfoDlgUnit{7.0.5};

{$R *.DFM}

CONST  vCol=8;
var Sar,eSar,Riv,eRiv, jkVE :integer;                  //<jkVE =VikaxPalaut nj:  0=nju  1=njf  2=nj0
    poista,kopioi, NytChkScrol,DblClck, BxGAuki :boolean;
    selCOL,selROW, selLFT,selTOP :integer;
    NjF_Filen,Nj0_Filen :string;                       //<Siirretty NolaVar.INC :iin ###############
    Gray_Chkd :boolean; //<+1.1.3 Vain PRC ChkBxAvMouseDown ja ChkBxAvClick väliseen tiedonsiirtoon ILMAN EVENTIÄ
    BxSar,BxRiv :integer;                              //< := OnEnter. Osoittaa, MISSÄ VIKAX OLLUT AUKI.  +4.0.0
    MootVrkMuutosInfo :boolean;                        //<+10.0.4

function njAL :boolean;      begin  Result := false;   if     NJlaji  then Result := true;   end;
function njCU :boolean;      begin  Result := false;   if NOT NJlaji  then Result := true;   end;

FUNCTION mm2i (mm2 :real) :integer;    //<### UUSI =Palauttaa KAHITAUn []-osoitteen = f(mm2) #######
BEGIN  CASE  trunc (mm2)  OF           //<### esim: hinta := yhtL * kahitau[mm2i(NJmm2)].MCMK.oh ###
     1 :mm2i := 1;      2 :mm2i := 2;       4 :mm2i := 3;       6 :mm2i := 4;  //'käyt: PaaKaHi.INC
    10 :mm2i := 5;     16 :mm2i := 6;      25 :mm2i := 7;      35 :mm2i := 8;  //       NjTul30.INC
    50 :mm2i := 9;     70 :mm2i := 10;     95 :mm2i := 11;    120 :mm2i := 12;
   150 :mm2i := 13;   185 :mm2i := 14;    240 :mm2i := 15;    300 :mm2i := 16;
   600 :mm2i := 17;   900 :mm2i := 18;   1200 :mm2i := 19;   2400 :mm2i := 20;
  else  mm2i := 21;{=3200}   END;
END;
//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ oli NjHavKus.INC,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
         //,,KERTASUORITUKSEN DISKONTOINTI. Käyttö:  Ph,dPprs,dWmkprs,PVpen,YOpen,Pmk ,,,, DOS-versiossa: Korolle
         //,,LOPPUARVO DISKONTATTUNA alkuhetkeen, kun KERTASUORITUKSEN KORKO LISÄTÄÄN jokaisen vuoden lopussa
FUNCTION fKertaSuor_Diskont (Tim,KasvuPrs :Real) :Real;      VAR ar,alfa :Real;      BEGIN
   ar := 1;   alfa := 1 + KasvuPrs/100;
   IF (KasvuPrs<>0) or (Tim<>0)  THEN                       //< +2.0.7 Muuten ErrorRealDivide ByZero
      ar := Exp (Tim*Ln(alfa));                             //<<Alfa potsiin Tim <<<<<<<<<<<<<<<<<<<
   result := ar;   END;
//-------------------------------------------------------------------------------
function fKertaSuor_lop_arv (prosArvo :integer;  Suure,KasvuPrs :Real) :real;      VAR ar :Real;      BEGIN
                           //PROSARVO'=0 =Arvona, ei prosentteina   >0 =Prosentteja
   ar := Suure * fKertaSuor_Diskont (a_getReaa(2006,nj.hav.Tpit), KasvuPrs);
   IF (prosArvo>0) and (ar>0)  THEN
      ar := ar/KasvuPrs *100 -100;
   result := ar;   end;
//-------------------------------------------------------------------------------
         //,,TOISTUVAISSUORITUKSEN DISKONTOINTI. Käyttö:  Korko,Hprs ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Oli fDiskont
         //,,NYKYARVO, kun VAKIOERÄ suoritetaan jokaisen vuoden LOPUSSA (jos ALUSSA Tim oltava Tim-1)
FUNCTION fToistvSuor_Diskont (Tim,KasvuPrs :Real) :Real;    VAR ar :Real;  BEGIN //Tarkistettu TTT s.14 Esim.(1):
   ar := 1;                                  //< 2.0.7:  0 -> 1                  //'5000mk 10a 6% = 36800 =OK
   IF (KasvuPrs<>0) and (Tim<>0)  THEN BEGIN //<Muuten ErrorRealDivide ByZero
      ar := fKertaSuor_Diskont (Tim,KasvuPrs);
      ar := 100/KasvuPrs * (1 - 1/ar);  END;
   result := ar;   END;
//Alfa potsiin Tim,,,,
//-------------------------------------------------------------------------------
function fToistvSuor_nyk_arv (Suure,KasvuPrs :Real) :real;      VAR ar :Real;      BEGIN
   ar := fToistvSuor_Diskont (a_getReaa(2003,nj.hav.Tpit), KasvuPrs);
   ar := Suure *ar;
   result := ar;   end;
{,,Ei käytetty,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
                              //,Jos suorit jokaisen vuoden lopussa, anna AIKA = t+1 ############################
         //,,LOPPUARVO, kun suorit jokaisen vuoden ALUSSA,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
FUNCTION fToistvSuor_lop_arv (Suure,Tim,KasvuPrs :Real) :Real;      VAR alfa,ar,alfaPotT,alfaPotT1 :Real;   BEGIN
   IF (KasvuPrs=0) or (Tim=0)
   THEN ar := 1                                          //<'+2.0.7 Muuten ErrorRealDivide ByZero
   else begin
        alfa :=      1 + KasvuPrs/100;
        alfaPotT :=  Exp (Tim*Ln(alfa));                 //<Alfa potsiin Tim <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        alfaPotT1 := Exp ((Tim-1)*Ln(alfa));             //<Alfa potsiin Tim-1 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        ar :=       (1 - 1/alfaPotT1) *100 / KasvuPrs;   //<TTT s.14 Esim2:  1000mk 8a(maksu 7a vuodn alussa) 5%
        ar :=       ar * alfaPotT;  end;                 //'alfaPotT = 1.477455  alfaPotT1 = 1.407100
   result := Suure *ar;                                  //'ar = 5.78637 ==> 8549 ------------------------------}
END;
//===============================================================================
FUNCTION fKeskiNjCos :real;      VAR i :integer;  ar,rr :real;   begin //<PRC ketjuarvot PITÄÄ OLLA KUTSUTTU ENNEN TÄTÄ KUTSUA.
   ar := 0;  rr := 0;
   for i := 1 to kesja  do begin                             // Tasoitetut tehot eri keskuspisteissä
      ar := ar +a_getReaa (2001,nj.jk[i].Ps);                // Tasaus ei vaikuta Cosiniin !!!!!!!!!
      rr := rr +a_getReaa (2001,nj.jk[i].Qs);   end;
   ar := ar / Sqrt (Sqr(ar)+Sqr(rr));                        //< AR = Kokonaiskuorman Cosini = P/S
   result := ar;   end;
//-------------------------------------------------------------------------------
FUNCTION fPHaika (uusin :Boolean;  cosPH :Real) :Integer; //<FNC=HÄVIÖhuipn käyttöaika[h/a]. GLOBAALI PRC / Nj
      VAR sinPH,eps,th,aKtyh,aTph,vuosiTun :Real;         //'cosPH=MaxKuorman aikainen cosiniPhii
   procedure sij (qHav :NjHavTied);   BEGIN
      WITH qHav  DO BEGIN
           aKtyh := a_getReaa (2001,Ktyh);  aTph :=  a_getReaa (2001,Tph);
   end; END;
BEGIN//fPHaika............................................
   IF uusin  THEN sij ( nj.hav)
             ELSE sij (njf.hav);
   vuosiTun := 8760;                                      //<Tunteja vuodessa 365*24=8760
   eps := aTph/vuosiTun;                                  //<USER2 (31)
   th := vuosiTun *( (Sqr(eps) *(2 + Sqr(eps))) / (1 + 2*eps) );     //<(30)
   if Sqr (cosPH) <1                                      //<Varm.vuoksi +6.0.0
      then sinPH := Sqrt (1-Sqr (cosPH))
      else sinPH := 0;
   result := Trunc ( vuosiTun*( th/vuosiTun + Sqr (aKtyh) *Sqr (sinPH) *
                            (1- th/vuosiTun) ) +0.5 );    //<USER2 (32)
END;//fPHaika
//-------------------------------------------------------------------------------
FUNCTION fKESmk (uusin :Boolean;  cosPH :Real) :Real;     //<HÄVIÖenergKESKIhinta[€]. GLOBAALI PRC / Nj #####
      VAR K,aYOprs,aPmk,aPVpen,aYOpen :Real;              //'cosPH=MaxKuorman aikainen cosiniPhii
   procedure sij (qHav :NjHavTied);      BEGIN
      WITH qHav  DO BEGIN
           aYOprs := a_getReaa (2002,YOprs);   aPmk :=   a_getReaa (2002,Pmk);
           aPVpen := a_getReaa (2002,PVpen);   aYOpen := a_getReaa (2002,YOpen);
   end; END;
BEGIN//fKESmk.............................................
   IF uusin  THEN sij ( nj.hav)                           //<UUSIN TR/FA = perua DOSversiosta:
             ELSE sij (njf.hav);                          //<'jos eroja -> scd = Bold (DOS)!!!!!!!!!
   K := Sqr (aYOprs / (100-aYOprs));                      //<Sqr=HÄVIÖIDEN suhe
                                                          //     /100=,,,,pen €:ksi, Pmk on jo [€]
   result := aPmk/fPHaika (uusin,cosPH) + (1/(1+K))*(aPVpen +K*aYOpen)/100;
END;//fKESmk
//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ oli NjHavKus.INC''''''''''''''''''

procedure BxGAukiVisOff;      begin //< +4.0.0 := TRUE  PRC OnBxGEnter´issä.  EI SAA KUTSUA ENNEN
   BxGAuki := false;                //  fEhkaTarkArv -kutsua, jotta BxGAuki SÄILYY #################
   NjFrm.BxG.Visible := false;  end;
procedure SijNjuIfVE1;      begin //< +4.0.0
   if jkVE=1  then Nju := Nj;  end;
function fUusRv_Vajaa :boolean;      VAR s :string;      begin //<,, +4.0.0
   result := false;
   s := NjFrm.StrGr.Cells[NjFrm.StrGr.FixedCols, NjFrm.StrGr.FixedRows +kesja]; //< 1x ohi vikan arvoRvn
 //s := TagVex (s);                                            //<TagVex ei tarvita koska Celli=''
   if (kesja<kesmax) and (s<>'')
      then result := true;  end;

procedure avust (CmBx,Sark,Tulst :integer);      begin;
   if NOT NjTulFrm.Visible  then avuste(CmBx,Sark, 4, Tulst);
{  if NjFrm.Showing  and NjFrm.Visible  then                   //< -4.0.0oz  1_6Bx´ien ItemDropit ei workkinut
      NjFrm.SetFocus;  }end; //<Jotta F1 = Frm.KeyDown workkisi JA FOCUS säilyis muutenkin
                             //'Aiheutt. CAPTIONin 'vilkkumista', jos AVUSTE.INCssä BringToFront tms.
procedure PoistaVex; FORWARD;            //< +4.0.0

{$I '..\EdvNj\TarifHin.INC'}
{$I '..\EdvNj\FileNj.INC'}
{$I '..\EdvNj\NjVrk.INC'}

function det1 :boolean;      begin  Result := false;   if NjFrm.DetRad1.Checked  then Result := true;   end;
function det2 :boolean;      begin  Result := false;   if NjFrm.DetRad2.Checked  then Result := true;   end;
function det3 :boolean;      begin  Result := false;   if NjFrm.DetRad3.Checked  then Result := true;   end;
//function det  :boolean;      begin  Result := false;   if det2 or det3  then Result := true;   end;

procedure PoistaVex;      begin
              poista := false;
              Screen.Cursor := crDefault;
              NjFrm.PoistaBtn.Caption :=  myTextBase.Get(NJ_1);
              NjFrm.PoistaBtn.Font.Style := [];
              NjFrm.PoistaBtn.Font.Color := clBlack;
              NjFrm.PoistaBtn.Hint := myTextBase.Get(NJ_2);  end;
procedure KopioiVex;      begin
              kopioi := false;
              Screen.Cursor := crDefault;
              NjFrm.KopBtn.Caption := myTextBase.Get(NJ_3);
              NjFrm.KopBtn.Font.Style := [];
              NjFrm.KopBtn.Font.Color := clBlack;
              NjFrm.KopBtn.Hint := myTextBase.Get(NJ_4);  end;
procedure OhjeVex;      begin                                                 //<,,+2.0.5
         //if apuaOn  then begin                                              //<  -4.0.0
              apuaOn := false;
              NjFrm.OhjeBtn.Font.Size := 17;
              NjFrm.OhjeBtn.Font.Style := [fsBold];  end; //end;
procedure NormBtn;      begin                                                 //<,,+2.0.5
              PoistaVex;   if (kesja>1) or fUusRv_Vajaa                       //<  +4.0.0
                                       then NjFrm.PoistaBtn.Enabled := true   //<, +4.0.0
                                       else NjFrm.PoistaBtn.Enabled := false;
              KopioiVex;   NjFrm.KopBtn.Enabled := true;                      //<  +4.0.0
              OhjeVex;
              NjFrm.OkBtn.Enabled := true;                                    //<,,+4.0.0
                           if NjVeja or fUusRv_Vajaa
                                       then NjFrm.PalautBtn.Enabled := true
                                       else NjFrm.PalautBtn.Enabled := false;
              NjFrm.  SuljeBtn.Enabled := true;
              NjFrm.    LueBtn.Enabled := true;
              NjFrm.    TalBtn.Enabled := true;
              NjFrm.TulostaBtn.Enabled := true;  end;

//  GridLineWith on vain Cellien väleissä, ei reunoilla ja kasvattaa RowHeight -arvoa pixeleillään, TODETTU
//,,BxG:n sijoitus lomakkeelle:   Top := fBxY(fRow(X,Y));  Left := fBxX(sar); ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
function fBxX (CelCol,CelRow :integer) :integer;      var CelXY :TRect;   begin //< Palautaa CELLin vasYläX:n
   CelXY := NjFrm.StrGr.CellRect (CelCol,CelRow);
   Result := CelXY.Left;
end;//fBxX;
function fBxY (CelCol,CelRow :integer) :integer;      var CelXY :TRect;   begin //< Palautaa CELLin vasYläY:n
   CelXY := NjFrm.StrGr.CellRect (CelCol,CelRow);
   Result := CelXY.Top;
end;//fBxY;
{TPoint = record  X: Longint;  Y: Longint;  end;
TRect = record  case Integer of  0: (Left, Top, Right, Bottom: Integer);  1: (TopLeft, BottomRight: TPoint);
   The coordinates are specified either as four separate integers representing the pixel locations of the left,
   top, right, and bottom sides, or as two points representing the pixel locations of the top left and bottom
   right corners. The origin of the pixel coordinate system is in the top left corner of the screen.}

function fCol (X,Y :integer) :integer;      var CelCol,CelRow :integer;      begin //<Pal Cellin AbsCOLn
  NjFrm.StrGr.MouseToCell(X,Y, CelCol,CelRow);                                     //'Scrollattu tai ei
  Result := CelCol;
end;//fCol;
function fRow (X,Y :integer) :integer;      var CelCol,CelRow :integer;      begin //<Pal Cellin AbsROWn
  NjFrm.StrGr.MouseToCell(X,Y, CelCol,CelRow);                                     //'Scrollattu tai ei
  Result := CelRow;
end;//fRow;
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
procedure sijBxG(sark,BxNo :integer);   var tmpItems :TStringList;  {i :Integer;}    begin //< 0=BxG###
                                                 //, BxG:ssä virhe (fEhka..:ssa SetFocus->BxGEnter->sijBxG) kutsuu
  if (BxNo=0)  OR               //<,+4.0.0       //< ekax tätä ja sen jälk. klikatusta Bx1 :stä, JOKA OHITETTAVA
     (BxNo>0) and NOT BxGAuki                    //' NIIN, ETTEI itemit tule BxNo 1 :n mukaan. !!!!!!!!!!!!!!!!!!!
  then with NjFrm.BxG  do begin //,,,,,,,,,,,,,,,TEKEE ITEM-LISTAN: 'Oletus;Item[0];Item[1]... #####
    if BxNo=0
       then tmpItems := f_Items(BxItems(sark, 4)) //<Tehdään BXITEMS:stä ITEM-lista TmpITEMS
       else tmpItems := f_Items(BxItems(BxNo+10, 4));
    {###################'''''''####################################################################}
    Items.Assign(tmpItems);                      //<ASSIGN =ei tartte ekax Clear
    tmpItems.Free;   //<####### VASTA TÄSSÄ SAA TUHOTA. MUUTEN OSOITIN HÄVIÄÄ LIIAN AIKAISIN #######

    with Items  do begin //< =BxG.Items
      if NjFrm.BxG.Items.Count-1 >= 1  then
      if NjFrm.BxG.Items[0] = NjFrm.BxG.Items[1] //<,+4.0.0  Poistetaan pud.valikon 2.item(=1), jos sama kuin 1.(=0)
         then Delete (1);

      ItemIndex := 0;                            //< +4.0.0  Fiksumpi kuin Text := Strs[0] !!!!!!!!!
      case BxNo of                               //,Kopioidaan BxG:stä ao. Boxiin ##################
        0 : ;
        1 :NjFrm.Bx1.Items := Items;      6 :NjFrm.Bx6.Items := Items;
        2 :NjFrm.Bx2.Items := Items;      7 :NjFrm.Bx7.Items := Items;
        3 :NjFrm.Bx3.Items := Items;      8 :NjFrm.Bx8.Items := Items;
        4 :NjFrm.Bx4.Items := Items;      9 :NjFrm.Bx9.Items := Items;
        5 :NjFrm.Bx5.Items := Items;   end;//case
                     //Y_Koe (0,'Items='+Items.Strings[0]+' !!!!! Bx1='+NjFrm.Bx1.Items.Strings[0]);
    end;//with Items
    DropDownCount := 30;
  end;//with BxG
end;//sijBxG;
{==================================================================================================}

procedure TNjFrm.StrGrWidestColInRow(Sender: TObject; ACol, ARow,  newWidth: Integer);      begin
  StrGr.ColWidths[ACol] := newWidth;  end;
//,,Event otettu ObjInsp :ssa vex, jotta Cell-korkeus saataisiin asetettua 18 :ksi, CmBx :ssa = 24
{procedure TNjFrm.StrGrHighestColInRow(Sender: TObject; ACol, ARow,  newHeight: Integer);    begin
  if ARow<=StrGr.RowCount-1  then StrGr.RowHeights[ARow] := newHeight;  end;
//StrGr.RowHeights[ARow] := newHeight;  end;}

procedure TNjFrm.OhjeBtnClick(Sender: TObject);      begin
   fEhkaTarkArvo (0);             //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell.
   BxGAukiVisOff;                 //<Suljetaan BxG, alle jää cellin arvo, jos on. +4.0.0
   PoistaVex;
   KopioiVex;
   if apuaOn
   then begin
      OhjeVex;
      AvuChkSft (10);  end        //< Sama muihin Frmeihin  10=Vapauttaa  11=Lukitsee
   else begin
      TabNo := 0;                 //< +5.0.1, 12.0.0
      avust (0,-1, 0);
      apuaOn := true;
      fSyoAktv (0);               //< 0  =Vapauttaa
      AvuChkSft (11);             //< 11 =Lukitsee
      OhjeBtn.Font.Size := 10;
      OhjeBtn.Font.Style := [];  end;
end;//OhjeBtnClic

procedure TNjFrm.SuljeBtnClick(Sender: TObject);      begin
   if fEhkaTarkArvo (0)  then begin  //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell
      SyottoAvFrm.Hide;              //< Siirretty 4.0.0
      NjTulFrm.Close;                //<Siellä NJtulAuki := false ##################################
      NormBtn;
    //AvuChkSft (10);                //< 0=Sijoittaa saman muihin Frmeihin  10=Vapauttaa  11=Lukitsee. -4.0.0
      BxGAukiVisOff;                 //< +4.0.0  BxGAuki+Visible := FA, varm.vuoksi.
      Close;  end;
end;

procedure TNjFrm.PalautBtnClick(Sender: TObject);      begin //skoe := ('PalBtn ve='+fImrkt0(jkVE,1));
   if fEhkaTarkArvo (0)  then begin       //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell
      SyottoAvFrm.Hide;                   //<+3.0.0
      NjTulFrm.Close;                     //<Siellä NJtulAuki := false #############################
    //AvuChkSft (0);                      //< 0=Sijoittaa saman muihin Frmeihin  10=Vapauttaa  11=Lukitsee.  -4.0.0
      case jkVE of                        //< +4.0.0  case, oli if..else, lisätty väliin if..else case´hin
           //,, njf = FilestäLuettu,    nj0 = Istunnon alku,   eriNj=TR, jos Nj<>NjF, := 1 Init. +PRC jkVEo <- Lue/TalBtn ym.
           1  :if eriNj   then begin  jkVE := 2;  Nj := Njf;  NjFilen := NjF_filen;  end else
               if eriNj0  then begin  jkVE := 0;  Nj := Nj0;  NjFilen := Nj0_filen;  end else
                               begin  jkVE := 1;  Nj := Nju;  NjFilen := NjF_filen;  end;

           2  :if eriNj0  then begin  jkVE := 0;  Nj := Nj0;  NjFilen := Nj0_filen;  end else
               if eriNjU  then begin  jkVE := 1;  Nj := Nju;  NjFilen := NjF_filen;  end else
                               begin  jkVE := 2;  Nj := Njf;  NjFilen := NjF_filen;  end;

          else if eriNjU  then begin  jkVE := 1;  Nj := Nju;  NjFilen := NjF_filen;  end else //< (0)
               if eriNj   then begin  jkVE := 2;  Nj := Njf;  NjFilen := NjF_filen;  end else
                               begin  jkVE := 0;  Nj := Nj0;  NjFilen := Nj0_filen;  end;  end;//case

      eRiv := 0;  eSar := 0;                    //, -4.0.0  kesja := ... vex, koska sama EditNjFrm :ssa
      EditNjFrm;
      NjFrm.StrGr.TopRow := NjFrm.StrGr.FixedRows; //< +4.0.0
   end;
   NormBtn;                            //< +2.0.5
end;//PalautBtnClic

procedure TNjFrm.KopBtnClick(Sender: TObject);      begin  //Y_Koe(0,'KopBtn ve='+fImrkt0(jkVE,1));
   if fEhkaTarkArvo (0)  then begin           //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell
      NjTulFrm.Close;                         //<Siellä NJtulAuki := false #########################
      PoistaVex;                              //<Ei kantsu= if poista  then
      OhjeVex;                                //< +2.0.5
      if syoAvOn  then                        //< +2.0.5
         avust (0,22,0);                      //< +2.0.5
      if kopioi
      then begin  KopioiVex;
                  SyottoAvFrm.Hide;           //< +4.0.0
                  AvuChkSft (10);  end        //< +2.0.5
      else if kesja=0
      then        erPiip
      else begin  kopioi := true;   //avust( 0,22, 0); -4.0.0
                  AvuChkSft (11);                //< +2.0.5
                  Screen.Cursor := crHandPoint;  {crSizeWE;}
                  KopBtn.Caption := myTextBase.Get(NJ_7);
                  KopBtn.Font.Style := [fsUnderline];
                  KopBtn.Font.Color := clBlue;
                  KopBtn.Hint := myTextBase.Get(NJ_8);
      end;
   end;//if
end;//KopBtnClic

procedure TNjFrm.PoistaBtnClick(Sender: TObject);    begin //Y_Koe (0,'PoisBtn ve='+fImrkt0(jkVE,1));
   if fEhkaTarkArvo (0)  then begin          //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell
      NjTulFrm.Close;                        //<Siellä NJtulAuki := false #####
      KopioiVex;                             //<Ei kantsu= if kopioi  then
      OhjeVex;                               //< +2.0.5
      if syoAvOn  then                       //< +2.0.5
         avust (0,21,0);                     //< +2.0.5
      if poista
      then begin  PoistaVex;
                  SyottoAvFrm.Hide;          //< +4.0.0
                  AvuChkSft (10);  end       //< +2.0.5  ,,4.0.0 +fUusRv_Vajaa
      else if (kesja<=1) and  NOT fUusRv_Vajaa //<Ei anneta edes valita, jos vain 1r. Estetty MouseDwn :kin
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

procedure TNjFrm.StrGrMouseMove(Sender: TObject; Shift: TShiftState; X,  Y: Integer);
begin                                            {MoFrm.EdiY1.Text := 'row'+fImrkt0 (fRow(X,Y),1)+' fix'+fImrkt0
                                                  (StrGr.FixedRows,1)+'vis'+fImrkt0 (StrGr.VisibleRowCount,1);//}
   if NOT poista   and NOT kopioi  and NOT apuaOn  and                //<Näillä omat avusteet +2.0.5
      NOT syoAktv  and syoAvOn     and NOT BxGAuki{+4.0.0aa}          //<Näille Hide muualla  +2.0.5
   then begin                                                         //,,Muualla MouseDwn hoitaa avusteen
      if (fCol(X,Y)>=0) and (fCol(X,Y)<=StrGr.ColCount-1) and
         (fRow(X,Y)>=0) and (fRow(X,Y)<=StrGr.RowCount-1)
      then avust (0,fCol(X,Y), 0)
      else ValmistaNollaaAvuste;                                      //< +3.0.0 Sis. SyoAvFrm..Hide
   end;
{  if NjTulFrm.Visible  then begin                                    //<Jotta vaihtaisi foc. NjTulFrm´sta vaikka
      StrGr.SetFocus;                                                 // osuisi Cellien ulkopuolelle +4.0.0
      if}                                                             //<''Ei hyvä:  BxG :n toiminta häiriintyy!!!
end;

procedure TNjFrm.BxGEnter(Sender: TObject);   begin//,KeyDwn rivn päässä/alussa aiheutti TopRow/LeftCol-aset, joka
  inherited;                                 //aiheuttaa TopLeftChange => BxG.Visible :=FA =BxGauki ILMAISEE SAMAN.
   if BxGAuki  then begin                    //<,+4.0.0aa
      Sar := BxSar;    Riv := BxRiv
   end;
   BxSar := Sar;  BxRiv := Riv;
   BxGAuki := true;
   sijBxG (eSar,0);                          //<Sijoittaa ITEMIT Boxiin ###### Siirretty OHJAABXG :stä =4.0.0 ####
end;
{=======================================OHJAA SYÖTTÖclikIT=========================================}
                  //,,oh :n arvo muutettu:  nyt 0 = KeyEnteristä,   1 = VAIN MouseDown :sta  4.0.0aa
procedure ohjaaBxG (oh :integer);      var boa :boolean;  i,j,BxRw,BxCo :integer; //p :TPoint;
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}           //BxRow'BxCol ovat CELLrow,col -arvoja
  function fPixPit (str :String) :Integer; //,,,,,,,,,,,,,,,,,,,Mjonon pituus PIXeleinä,,,,,,,,,,,,,
    begin fPixPit := Y_fPixPit (NjFrm.StrGr.Canvas, str, NjFrm.BxG.Font);  end;//fPixPit;
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
  function fMrkPit (str :string) :Integer;  //,,,,,,,,,,,,,,,,,,,Mjonon pituus PIX,,,,,,,,,,,,,,,,,,
      var i,j :integer;   //,,Kaipaa +1, jotta mja mahtuisi boxiin!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    begin i := fPixPit(str) +20;                         //< +20 = Pudotusnuoli
          j := NjFrm.StrGr.ColWidths[fAbsCo (Sar)] +4;   //< Kaipaa +4 jotta kenttä täyttyisi,TODTTU
                                          //Kok (1,6, 'fPx#i#='+fImrkt0 (i,1)+'#j#='+fImrkt0 (j,1));
          if j>i  then i := j;  fMrkPit := i;  end;
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
begin//ohjaaBxG; - Tähän tullaan VAIN PRC StrGrMouseDown + BxGKeyDow :sta. UmCmBx yms :sta SUORAAN ArvoOK -kutsut
                {  ja jos eiOK, SetFocus takas, joten niiden arvot pakko olla OK, ja TÄSSÄ VAIN BxG :n KÄSITTELYÄ.
                 - OHA PYSYY TÄSSÄ:
                             OhjaaBxG/BxG.SetFocus  -> OnBxGEnter -> sijBx,
                   ELLEI fEhka..:ssa aseteta BxGAuki=FA :ksi, JOSTA TIEDETÄÄN, että BxG :tä EI ENÄÄ HALUTA AVAT-
                   TAVAKSI (ks. FNC fEhka...) ,,,,,,,,,,,,,,,,,,,,, Uusittu 4.0.0 ,,,,,,,,,,,,,,,,,,}

  boa := fEhkaTarkArvo (oh);            //<Jos oltiin uudella rivillä BxG:ssä, tarkist + editoi Cell

  if boa  and (oh=0) and (Sar=1)        //<,Estetään KeyEnterillä uuden rivin aloitus =UUSI RIVI ON  +4.0.0
     then boa := false;                 //  ALOITETTAVA HIIREN CLICKILLÄ EKAAN ARVOSARAKKEESEEN!!!!!

  if boa  then begin //<,,,eSar ja eMrv := ... ja Box avataan VAIN jos OKarvo + OKclickAlue,,,,,,,,,,,,,,,,,,,,,,,
    eSar := Sar;  eRiv := Riv;
    kesno := riv;                       //< 4.0.0u  Oli näin, tarve???????????????????????????????????????????????
    //,,,Jos Click vain OSITTAIN näkyvään StrGr :n osaan, siirretään RUUTUA, muuten PANELIOSAT supis-
    //,,,tuvat, TODETTU. Ja TÄMÄ VAIN, jos muuten Click OK, koska tähän päästy, vrt. IF BOA <<<<<<<<
    //   ############### selROW, selCOL := arvon SelectCell + KeyPres + MouseDwn:ssa ###############
    with NjFrm.StrGr  do begin                 //<,Muut ehdot OK, jos tähän päästy, vrt. IF BOA <<<<
                             //Kok (4,6,'lft'+fImrkt0(LeftCol,1)+'#vis'+fImrkt0(VisibleColCount,1));
       if selROW > TopRow  +VisibleRowCount -1  then TopRow := TopRow +1  else
       if selROW < TopRow                       then TopRow := TopRow -1;

       if selCOL > LeftCol +VisibleColCount -1  //,,Tarkistetaan, ettei osoiteta olematonta Col´ia
          then if LeftCol+2 <= ColCount-1  then LeftCol := LeftCol +2  //<2 koska jotkut Sar leveitä
          else if LeftCol+1 <= ColCount-1  then LeftCol := LeftCol +1; //<Jos ei tämäkään onaa, jää enn.
       if selCOL < LeftCol                 then LeftCol := LeftCol -1;

       BxRw := fVisRow;
       BxCo := fVisCol;       //Kok (4,7,'lft'+fImrkt0(LeftCol,1)+'#BxC'+fImrkt0(BxCol,1));
    end;//with
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Loppuarvot Boxin vas.yläkulmalle,,,,,,,,,,,,,,,,,,,,  //m++
    with NjFrm.BxG  do begin
                         //with MoFrm.StrGr  do i := MoFrm.BxG.Height -RowHeights[i] -GridLineWidth;
       Top :=  fBxY (BxCo,BxRw) -1;//-3       //<,BxG :n sijoitus StrGr :n Celliin. -2*LWidth, jot
       Left := fBxX (BxCo,BxRw) -2;           //<'tei vie tilaa liikaa alapuoln rvstä + OikSar:sta
      {case Sar of                          //,,,Bx:n lev: +20 =Pudotusvalikon nuoliBtn, ks. fPixPit     ,,,-4.0.0
         1 :begin                                      //,Huom.   +4 = Jotta kenttä täyttyisi, TODETTU
            i := fMrkPit(NjFrm.StrGr.Cells[1,Riv]) +4; //<KeskusTUNNUS
            j := fMrkPit('NK-A1.3.32');  //Kok (4,7,'i'+fImrkt0(i,1)+'#j'+fImrkt0(j,1));
            if j>i  then i := j;
            with NjFrm.StrGr  do j := ColWidths[1] +ColWidths[2] -7;   //<Mahduttava 2sar :een -7pix Clickille
            if j<i  then i := j;  end;                                 //'=2.sarEiSaaTäyttyä, jottaMahtuuClick
         2 :i := fMrkPit('123450');                    //< dL       = 12345 (m) =5 mrk
         3 :i := fMrkPit('123.40');                    //< Pt       = 123.4 (kW)=5 mrk
         4 :i := fMrkPit('0.6500');                    //< Cos      = 0.65      =4 mrk
         5 :i := fMrkPit('650');                       //< PtVrt    = 65        =2 mrk
         6 :i := fMrkPit('0.6500');                    //< CosVrt   = 0.65      =4 mrk
         7 :i := fMrkPit('88880');                     //< m²       = 1234      =4 mrk
         8 :i := fMrkPit('EIPOTTAS');                  //< EiPotTas = 12345678  =8 mrk
         9 :begin
            i := fMrkPit(NjFrm.StrGr.Cells[9,Riv]) +4; //<HUOM:
            j := fMrkPit('Aaaaaaaaaaa aaaaaaaaaaa aaaaaaaaaaa'); //Kok (4,8,'i'+fImrkt0(i,1)+'#j'+fImrkt0(j,1));
            if j>i  then i := j;
            with NjFrm.StrGr  do j := ColWidths[9] +ColWidths[10] +ColWidths[11]; //<Mahduttava StrGr alueelle
            if j<i  then i := j;
            end;
       end;{case}     //'Pitää mahtua 1 mrk enemmän jotta näkee merkLkmn syöttötapahtumassa =min '0'

       i := NjFrm.StrGr.ColWidths[Sar] +21;             //<,, +4.0.0 ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
       j := i;
     //with NjFrm.StrGr  do if Sar<ColCount-2  then                 //< -4.0.0
       with NjFrm.StrGr  do if Sar IN [FixedCols..ColCount-1]  then //< +4.0.0
            j := ColWidths[Sar] +ColWidths[Sar+1] -5;   //<Mahduttava 2sar :een -5 pix Clic-tilaa
       if (j<i) and (j>0)  then i := j;
       Width := i;
    end//with
  end else//if boa
  if BxGAuki  then begin                          //<,+4.0.0
       Sar := BxSar;    Riv := BxRiv;
  end;                                            //<'Ei:  else erPiip, koska on jo fEhka../arvoOK :ssa

  if boa  or  BxGAuki  then begin
     if syoAvOn  then begin
        fSyoAktv (0);  avust (1,eSar, 0);  fSyoAktv (1);
        SyottoAvFrm.Visible := true;
     end;

     NjFrm.BxG.Visible := true;                   //<Muuten Error:  Unable to focus invisible ...
     NjFrm.BxG.SetFocus;       //<Aiheuttaa OnBxGEnter´in.   Boxin arvo 'maalataan' ENTERkelpoiseksi
  end;                         //'########################!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
end;//ohjaaBxG;
{==================================================================================================}
procedure TNjFrm.StrGrMouseDown(Sender: TObject; Button: TMouseButton;   Shift: TShiftState; X, Y: Integer);
      var uSar,uRiv :integer;
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
   procedure P_poista;      var i :integer;      begin
    i := fJKtoAbsROW (Riv);       //< i = Mrv +FixedRows -1
  //if (kesja=1)  OR  (Riv>kesja) and (StrGr.Cells[1,fVisRow]='') and (StrGr.Cells[2,fVisRow]='') //< -4.0.0
    if (NjFrm.StrGr.Cells[NjFrm.StrGr.FixedCols, i] = '')  or                                     //<,+4.0.0aa
       (Riv<1)  or (Riv=1) and (kesja=1)
    then erPiip
    else begin
      if Riv<=kesja  then begin              //<,Muutoin vajaa rivi, jolloin ei näitä muutoksia ####
        {if NOT PalautBtn.Enabled  then begin //<Tilanne talteen ennen EKAA kopiota ################
            nj0 := njf;      //<jk0 :aan nyt alp JKF ###############################################
            njf := nj;  end; //<####################################################################}
         for i := Riv to kesja-1  do nj.jk[i] := nj.jk[i+1];
         kesja := kesja -1;
         a_putIntg (21,kesja, nj.jy.ketjussa);
         if Riv>kesja  then Riv := kesja; //<Muuten jää vika OSOITETTU Mrv > motja, todettu ########
      end;
    //SijNjuIfVE1;                        //<Prc 4.0.0  Ei sittenkään: Parempi, että palautettavissa
      EditNjFrm;          //<UUSI EDIT.##### Asettaa myös PalautBtn. + PoistaBtn.Enabled TR/FA #####
      if (kesja<1)  and NOT fUusRv_Vajaa  then PoistaVex; //< +4.0.0
    end; end;//P_poista;
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
  procedure P_kopioi;      var sa,sb :string;  i :integer;       begin
    if (Riv<1) or (Riv>kesja) or (kesja>=kesmax) or (kesja>=fAbsROWtoRIV (NjFrm.StrGr.RowCount-1))
    then begin erPiip; {KopioiVex; -4.0.0} end
    else begin
     {if NOT PalautBtn.Enabled  then begin //<Tilanne talteen ennen EKAA kopiota ###################
         nj0 := njf;      //<jk0 :aan nyt alp JKF ##################################################
         njf := nj;  end; //<#######################################################################}
      nj.jk[kesja+1] := nj.jk[Riv];
      kesja := kesja +1;
      sa := a_getStrg (2,nj.jk[kesja-1].tunnus);
      if CharInSet(sa[Length(sa)], ['0'..'9'])  then begin
        sb := '';
        i := Length(sa);                    //<Tehdään vikoista n:oista luku, johon lisätään 1<<<<<<
        while (i>0) and (CharInSet(sa[i], ['0'..'9']))   do begin
          sb := sa[i] +sb;
          Delete (sa,Length(sa),1);         //<Pyyhitään jo sb :hen siirretty (vika)mrk vex<<<<<<<<<
          i := i-1;  end;

        sa := sa + fImrkt0(StrToInt(sb)+1,1); //<Nyt sa =str, jossa vikoja n:oja kasvatettu +1<<<<<<
        a_putStrg (1,{'<left>'+}sa, nj.jk[kesja].tunnus);
      end;
      a_putIntg (22,kesja, nj.jy.ketjussa);
      
      SijNjuIfVE1;                          //<Prc 4.0.0
      pvRivi (kesja);     //<################################# Uusi edit.+ BxG=>Cell ARVO ##########
    end;
  end;//P_kopioi;
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
begin//StrGrMouseDown ############# TÄHÄN TULLAAN AINA, KUN NÄPÄYTETÄÄN StrGr -ALUEELLE ############ <<,,+1.1.3
     //  Ennen tähän tuloa on eventi OnSelect tapahtunut, ks. lopussa ##############################
                                        //'###################### KS. MOOT.PAS #####################
                                        //'#########################################################
   OhjeVex;                  //< +2.0.5
   if DblClck                //<Estetään OhjaaBx, koska ositt näkyvälle DblClick aiheuttaa ruudun siirtymisen:
   then begin                //'DblClikissä:  1)Select..  2)MouseDwn  3)Select..  4)Click  5)DblClick  6)MousDwn
      DblClck := false;      //'5) ja 6) ei tapahdu ollenkaan, jos tavallinen Click #############################
    //Y_piipit (10);         //< -4.0.0
      fSyoAktv (0);  end     //< +1.1.3 (olikohan jo MoFrm.PAS :ssa, ei ainakaan+1.1.3-kommenttia.Vapauttaa avusteen
   else begin                     //,OnSelect :ssä Lft/Top =Muuttui = Clikattu liian oik/alas =KORJ+PIIP #########
    //,,##########################################################################################################
      uSar := fCol (X,Y);   uRiv := fRow (X,Y); //<,JOSSAIN VANHASSA VERSIOSSA JOSTAIN SYYSTÄ Click FixedRow/Col´
                                                //  iin ei vienyt OnSelectCell´iin. NYT EHKÄ selCOL,ROW TARPEETON.
      selCOL := uSar;  selROW := uRiv;             //<,, +4.0.0 ##################################################
                                                   //'############################################################
      Sar := fAbsCOLtoSAR (selCOL);                //<', fCol,fRow palauttaa AbsCol,AbsRow oli scrollattu tai ei
      Riv := fAbsROWtoRIV (selROW);                //<'selCOL/Row := SelectCell + KeyPres :ssä ###################

      if (uSar<StrGr.FixedCols) or (uRiv<StrGr.FixedRows)
         then erPiip;           //<2.erPiip tulee hetken päästä fEhka..:sta, HYVÄ ################################

      if poista                             //<Ao. BtnClick asetti<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      then P_poista
      else if kopioi                        //<Ao. BtnClick asetti<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      then P_kopioi                         //,0 = Ei KeyPressed <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      else ohjaaBxG (1);                    //< 4.0.0aa  0 -> 1                         
   end;
end;//..MouseDown
{==================================================================================================}
procedure TNjFrm.BxGKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);

    function ViimMaxRw (JKriv :integer) :boolean;   begin  Result := false;//,Varmistaa,jos ..Count/kesmaxEiOK
       if (JKriv>=kesmax) or (fAbsRw (JKriv)>=NjFrm.StrGr.RowCount-1)  then Result := true;  end;
                                                             //,,,,,,,,,,,,,,,,Olet = EiOK..........
    procedure VasYlos (Vaaka :boolean);   begin //,VAAKA=TR kun halut siirtyä vaakasuunt samal rvllä
      if vaaka and (Sar=1) and (Riv=1)  OR      //,      FA kun pystysuunnassa #####################
         NOT Vaaka and (Riv=1)
      then begin erPiip;
                 BxGAukiVisOff;  end            //< Muuten rupeaa selaamaan BxG:n itemeita, TODETTU.  Prc 4.0.0
      else begin                                //' Ei ehkä enää, koska fEhka.. ´ssa suljetaan !!!!?
         if Vaaka
         then begin
            Sar := Sar-1;                       //<SAR tai eSAR, koska SftUp haluttiin siirtäv 1xVAS
            if Sar=0  then begin Sar := vCol+1;  Riv := Riv-1;  end; end
         else Riv := Riv-1;                     //<CtrlYlosVas = haluttiin suoraan ylös ############

         with StrGr  do begin
            if Sar<LeftCol
            then LeftCol := LeftCol -1
            else if Sar+1 > LeftCol +VisibleColCount -1  then LeftCol := Sar -VisibleColCount +1;
                    //'+1 = Varataan BgG :lle 2 saraketta tilaa, muuten osuessaan SrolBarin alueelle,
                    //'     scrollaa itsekseen yhden yli, TODETTU ##################################
            if fVisRow<TopRow  then TopRow :=  TopRow -1;
         end;//with

         selROW := fVisRow;
         selCOL := fVisCol;
         ohjaaBxG (0);                          //< 0 =Ohjaus KeyPres :stä <<<<<<<<<<<<< 4.0.0aa  1 -> 0
    end;//else
    end;//VasYlos
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//,VAAKA=TR kun halut siirtyä vaakasuunt samal rvllä
    procedure OikAlas (Vaaka :boolean);                            //<VAAKA = FA, kun pystysuunnassa
        {var b1, b2,b21,b22, b3,b31,b32,b33, b4,b41,b42
             :boolean;//}
         function pysty :boolean;   begin Result := false;  if NOT vaaka  then Result := true;  end;
    begin //,,,BREAKPOINT -TARKASTELUA VARTEN ######################################################
      if NOT(Sar IN [1..vCol+1])  or  NOT (Riv IN [1..kesmax])              or //<EIKOSKAAN: VAIN TÄSSÄ OHJAT.
         vaaka and (Sar=vCol+1) and  ViimMaxRw (Riv)                        or //<Ohi viim Cellin <<<<<<<<<<<<
         pysty and                   ViimMaxRw (Riv)                        or //<Ohi viim rivin  <<<<<<<<<<<<
         pysty and (NOT OkStr (Sar-1,Riv+1)  or  NOT OkStr (vCol,Riv))    //<Vas+EdRvnVikaCel:ssä oltava mrkjä}
      then begin erPiip;  //Y_piipit (50);
                 BxGAukiVisOff;  end            //< Muuten rupeaa selaamaan BxG:n itemeita, TODETTU.  Prc 4.0.0
      else begin                                //' Ei ehkä enää, koska fEhka.. ´ssa suljetaan !!!!?
         if Vaaka
         then begin
            Sar := Sar+1;                       //<SAR tai eSAR, koska SftUp haluttiin siirtäv 1xOIK
            if Sar>vCol+1  then begin Sar := 1;  Riv := Riv+1;  end; end
         else Riv := Riv+1;                     //<CtrlAlasOik = haluttiin suoraan alas ############

         with StrGr  do begin //,,HUOM: LeftCol +TopRow -muutokset -> BxG.Visible := FA =HUOMIOITAVA fEhka....
            if Sar<LeftCol                      //,,ASETUS AIH. LftTopChange => BxG.Visible := FA ##
            then LeftCol := FixedCols           //<vCol :sta 1. sar :een <<<<<<<####################
            else if Sar+1 > LeftCol +VisibleColCount -1  then LeftCol := LeftCol +1;
                    //'+1 = Varataan BgG :lle 2 saraketta tilaa, muuten osuessaan SrolBarin alueelle,
                    //'     scrollaa itsekseen yhden yli, TODETTU ##################################
            if fVisRow>TopRow +VisibleRowCount -1  then TopRow :=  TopRow +1;
         end;//with

         selROW := fVisRow;
         selCOL := fVisCol;
         ohjaaBxG (0);                          //< 0 =Ohjaus KeyPres .stä <<<<<<<<<<<<< 4.0.0aa  1 -> 0
    end;//else
    end;//OikAlas
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
begin{BxGKeyDown}                                   //edi1 ('Key='+fImrkt0(key,1));
                                                    { 'sar'+fImrkt0(sar,1)+'bxc'+fImrkt0(BxCol,1)+'/';}
//if {-1.1.3=NjFrm.ChkBxAv.Checked 1.1.3->+} syoAktv   then begin  avust( 1,Sar, 0);  syoAktv := false;  end;
  case key of                                                              //':= TR =Lukittiin ohjaaBxG:ssa
 {13 :with Bx  do begin                                       //<Enter  -4.0.0
      Enteri := true;  bRiv := Riv;  bSar := Sar;
      OikAlas (TRUE);  end;}
  13 :OikAlas (TRUE);                                         //<Enter
  40 :if (Shift=[ssShift])  then OikAlas (TRUE)  else         //< 40=AlasOik:  Siirtym.SIVUsuunnassa
      if (Shift=[ssCtrl])   then OikAlas (FALSE);             //< 40=AlasOik:  Siirtym.PYSTYsuunnassa
  38 :if (Shift=[ssShift])  then VasYlos (TRUE)  else         //< 38=YlosVas:  Siirtym.SIVUsuunnassa
      if (Shift=[ssCtrl])   then VasYlos (FALSE);             //< 38=YlosVas:  Siirtym.PYSTYsuunnassa
  end;//case
end;procedure TNjFrm.BxGKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

end;

//BxGKeyDown
//==================================================================================================
procedure TNjFrm.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);      begin//1.1.3 m++
  inherited;
   if key=112  then begin                //<112 = F1. HUOM: NjFrm.KeyPreview p.o. TRUE #############
    //if ChkBxAv.Checked  then ChkBxAv.Checked := false //-1.1.3
      if syoAvOn  then ChkBxAv.Checked := false //<+1.1.3
                  else ChkBxAv.Checked := true;
      AvuChkSft (0);  end;               //<Päivitetään muihinkin lomakkeisiin <<<<<<<<<<<<<<<<<<<<<
end;

procedure TNjFrm.FormKeyPress(Sender: TObject; var Key: Char); //<+12.0.0:  Enter aiheutti BEEPin, nyt ei.
begin
   inherited;
   if Key=#13  then begin
      Key := #0;
      BxGEnter(Sender);
   end;
end;

(*procedure TNjFrm.BxGKeyPress(Sender: TObject; var Key: Char);      var x,y :integer;      begin
  if key=#13  then begin
    Sar := eSar+1;
    if sar>8  then begin Sar := 1;  Riv := Riv+1;  end;
    x := fXvy (Sar);  y := fYvy (Riv) +3;        //< Y ok, jos min. +2, koklattu. =Muuten Bx edRvlle
    ohjaaBxG(1,x,y);                             //< >0 = 'Maalaa' boxin arvon ENTERkelpoiseksi ####
  end else  if key=#16  then LueBtn.Caption := 'Sifti'
  else LueBtn.Caption := 'Muu';
//end;
end;//BxGKeyPress*)
{==================================================================================================}
procedure TNjFrm.TulostaBtnClick(Sender: TObject);         //<Object Inspectorissa LINES p.o. TYHJÄ,
      const marg=200;                                      //'muuten aRich NÄKYY lomakkeella,TODETTU
      var   i,RivPit :integer;  s,s1,s2,s3,s4 :string;  alpSyoAktv,alpSyoAvOn :boolean;
  procedure LF;                        begin  aRich.AddText ('<br>');  end;
  procedure lisaaKpl (ss :string);     begin  if ss<>''  then begin
                                              ss := ss+'<br>';  aRich.AddText (ss);  LF;  end; end;
begin
  NjTulFrm.Close;                                                 //<Siellä NJtulAuki := false #####
  if fEhkaTarkArvo (0)  then begin        //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell
   NormBtn;                               //< +2.0.5
   AvuChkSft (10);                        //< 2.0.5  0->10
//IF PaaValFrm.PrinterSetupDialog1.Execute  then begin
//IF PaaValFrm.PrintDialog1.Execute  then begin
  IF PrintDlgNola.Execute (modeNj, self)  then begin         //DEVELOPER2 6.12.1998
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
         fSyoAktv (0);                                 //<,Jotta avuste_päivittyisi aRichiin<<<<<<<<
         SyoAvOn := true;                              //< +3.0.0
         aRich.Font.Size :=  10;                  //<,Jo tässä, jotta WHILE-silmukka laskisi oikein.
         aRich.Font.Style := [fsBold];
         aRich.AddText ('<left>');                //<Muutetaan vasensuoraksi #######################
                                //,,OLTAVA TÄSSÄ [fsBold] in jälkeen jotta tila laskettaisiin oikein
         s1 := otsikko (RivPit,'KESKUSTIETOJEN SYÖTÖN YLEISET OHJEET SEKÄ SELITYKSET: ',aRich.Font);
         s2 := otsikko (RivPit,'SARAKEKOHTAISET SELITYKSET: ',aRich.Font);
         s3 := otsikko (RivPit,'SYÖTTÖIKKUNAKOHTAISET SELITYKSET: ',aRich.Font);
         s4 := otsikko (RivPit,'HÄVIÖKUSTANNUSTEKIJÖIDEN SELITYKSET: ',aRich.Font);
         aRich.Font.Size :=  8;                      //<,Vex, jotta ..rivintäyte workkisi, muuten ei
         aRich.Font.Style := [];                     //<' onaa, TODETTU ############################
                           //,,Lisätään mjonot aRichiin ############################################
         lisaaKpl ('<b><f n="" s="10">'+ s1 +'</f></b>');  LF;                //< LF=TyhjäRiviVäliin
         lisaaKpl (avuste (0,-1,4,1));

         lisaaKpl ('<b><f n="" s="10">'+ s2 +'</f></b>');  LF;    //</b> tässä järjestyksessä, nuuka
                           //,,Seuraavassa käytetään aRichin WordWrap:iä hyväksi rivijakoon ########
                           //aRich.Width := 850;  //<Pakotetaan rivt sopivn mittaisiksi ?770-200=570
         for i := 0 to 13  do begin
             s := avuste (0,i,4,1);
             lisaaKpl (s);  end;

         lisaaKpl ('<b><f n="" s="10">'+ s3 +'</f></b>');  LF;
         for i := 31 to 38  do begin
             s := avuste (0,i,4,1);
             lisaaKpl (s);  end;

         lisaaKpl ('<b><f n="" s="10">'+ s4 +'</f></b>');  LF;
         for i := 1 to 15  do begin
             s := avuste (0,i,5,1);
             lisaaKpl (s);  end;

       //avuste (0,avuRv,0, 0);                 //<Avusteikkunassa vilisti kaikki avust. Alp takas
         aRich.Print('');  //#######################################################################
       end//if PrintDlg..  //<Tulostettiin avusteet ################################################
       else begin          //<Tulostetaan LOMAKE ###################################################
         // NjFrm.PrintScale := poPrintToFit;
         // NjFrm.Print;
         PrintContent
       end;                                     //NjFrm.Print; =Tulostaa FORMin painikkeineen + tlkn
    finally                                     //'NjFrm.StrGr.Print = Undeclared identifier
      TulostaBtn.Enabled := True;
      Screen.Cursor := crDefault;
      SyoAktv := alpSyoAktv;         //< +3.0.0
      SyoAvOn := alpSyoAvOn;         //< +3.0.0
      SyottoAvFrm.Hide;              //< +3.0.0 Poistetaan tulostuksesta näkyviin jäänyt vika avuste
    end;//finally
  end;//if ..Execute
  END;//if tyhb
end;//TulostaBtnClic

procedure TNjFrm.PrintContent;
var
   destRect: TRect;
   mult: real;
   leftMargin, topMargin, i: integer;
   tmpGrid: TStringGridNola;
   adate, atime: TDateTime;
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
     tmpGrid := TStringGridNola.Create(nil);
     tmpGrid.Visible := False;
     tmpgrid.Assign(TStringGrid(StrGr));

     mult := printer.canvas.font.PixelsPerInch / font.PixelsPerInch * (PrintDlgNola.Zoom / 100);
     //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,DEVELOPER1
     if pyor (PrintDlgNola.Zoom) = 100  then begin //<Vois tutkia: IF PORTRAIT.., mutta riitänee näin.
        i := pyor (tmpGrid.GetMaxWidth * mult);
        if i > printer.PageWidth  then mult := printer.PageWidth / tmpGrid.GetMaxWidth;
     end; //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''DEVELOPER1

     { Luodaan otsikko }
     destrect.top := destrect.top + PrintHeader(self, printer.canvas, printer.PageWidth, leftMargin, topMargin,
                     caption, 1, adate, atime, PrintDlgNola.Zoom, mult,PrintDlgNola.PrintHeader);

     { Muokataan gridiä }
     tmpGrid.Visible := False;
     tmpGrid.Parent :=  self;
     tmpGrid.Width :=   tmpGrid.GetMaxWidth;                         // Laitetaan leveys oikeaksi
     tmpGrid.RowCount:= tmpGrid.GetFirstEmptyRow(tmpGrid.FixedCols); // Vain täydet rivit
     tmpGrid.Height :=  tmpGrid.GetMaxHeight;                        // Laitetaan korkeus oikeaksi

     { Tulostetaan StrGr }
     destrect.top := destrect.top +
          PrintControlEx(tmpGrid, destrect.left, destrect.top, printer.canvas,
                         mult, PRINT_BG_COLOR, false, printer.PageWidth - leftMargin);

     tmpGrid.Free;

     { Tulostetaan alapaneeli }
     { Merkataan controllit joita ei haluata printata }
     OkBtn.tag :=      OkBtn.tag              or PRINT_DISABLED;
     SuljeBtn.tag :=   SuljeBtn.tag           or PRINT_DISABLED;
     PoistaBtn.tag :=  PoistaBtn.tag          or PRINT_DISABLED;
     TulostaBtn.tag := TulostaBtn.tag         or PRINT_DISABLED;
     OhjeBtn.tag :=    OhjeBtn.tag            or PRINT_DISABLED;
     LueBtn.tag :=     LueBtn.tag             or PRINT_DISABLED;
     TalBtn.tag :=     TalBtn.tag             or PRINT_DISABLED;
     KopBtn.tag :=     KopBtn.tag             or PRINT_DISABLED;
     PalautBtn.tag :=  PalautBtn.tag          or PRINT_DISABLED;
     ChkBxAv.tag :=    ChkBxAv.tag            or PRINT_DISABLED;
     DetRad.tag :=     DetRad.tag             or PRINT_DISABLED;

     Panel1.tag :=     Panel1.tag             or PRINT_WIDTH_FIT_TO_PAGE;

     destrect.top := destrect.top +
       PrintControlEx(Panel1, destrect.left, destrect.top,
                      printer.canvas, mult, PRINT_BG_COLOR, true, printer.PageWidth - leftMargin);

     printer.EndDoc;
     Screen.Cursor := crDefault;
end;//PrintContent

procedure TNjFrm.LueBtnClick(Sender: TObject);      VAR tyhb :boolean;      begin //,,Ks.Ari Becks, s.516
   tyhb := fEhkaTarkArvo (0);     //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell  +4.0.0
   if tyhb  and LueTalNjFile (LueTR,KysTR,NjFilen)  then begin
      MootNj := false;            //<######### MootNj vex =Tämän jälk. tämä on norm. keskus ######## +4.0.0
      SyottoAvFrm.Hide;           //<+3.0.0
      NjTulFrm.Close;             //<Siellä NJtulAuki := false #####################################
      NormBtn;                    //< +2.0.5
    //AvuChkSft (10);             //< 2.0.5  0->10.  -4.0.0
      jkVEo;
      EditNjFrm;
   end;
end;//LueBtnClic

procedure TNjFrm.TalBtnClick(Sender: TObject);      begin
   if fEhkaTarkArvo (0)  then begin   //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell
      MootNj := false;                //<######### MootNj vex =Tämän jälk. tämä on norm. keskus #### +4.0.0
      SyottoAvFrm.Hide;               //<+3.0.0
      NormBtn;                        //< +2.0.5
      NjTulFrm.Close;                 //<Siellä NJtulAuki := false #################################
    //AvuChkSft (10);                 //< 2.0.5  0->10.  -4.0.0
      if fOKrivit
      then if LueTalNjFile (LueFA,KysTR,NjFilen)
              then FrmOtsikko;  end;
end;//TalBtnClic

procedure TNjFrm.OkBtnMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X,Y: Integer);
      VAR i :integer;
   //........................................................ ,,+3.0.0
   function poisOK :boolean;      VAR i :integer;  qPs,qAla :real;      begin
      result := true;

      if NOT fEhkaTarkArvo (0)  or NOT fOKrivit    //< 1=Kutsu BtnClickistä 2=ComBx auki
      then result := false
      else  for i := 1 to kesja  do begin          //,, 5,i=palV,  6,i=CosV  7,1=Ala
         qPs :=  a_getReaa (2003,nj.jk[i].Ps) *1000;
         qAla := a_getReaa (2003,nj.jk[i].Ala);
         if (qAla>0) and (qPs/qAla >= 10000)
         then begin
            LaskeeOdFrm.Close;                     //< +3.0.3
            EiOkInfo ('Pinta-ala liian pieni tehoon nähden, korjaa isommaksi tai aseta nollaksi!');
            result := false;
            Break;  end;
      end;//else
   end;
   //....................................................... ,,Muutetttu 3.0.0
   procedure LaskeNj;      VAR i,j :integer;      begin
      Screen.Cursor := crHourGlass;
      j := 0;                              //,Jotta arvot päivittyisivät ###########################
      for i := 11 to 18  do if NOT arvoOKe (i,4)  then begin //else begin  FocusBak(Sender???); //< 4.0.0 OK->OKe
          j := i;
          LaskeeOdFrm.Close;               //< +3.0.3
          erPiip;  EiOKinfo ('Alapanelin syöttöikkunoiden arvoissa ristiriitaa !'); //<Piip+Herja, vrt.arvoOKe 4.0.0
          Break;  end;
      SijNjuIfVE1;                         //< +4.0.0
      if j=0  then begin                   //<j=0 = Kaikki ok <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
         if NjTulAuki and not eriNj        //<1.1.0
         then begin                        //<1.1.0
          //EiOkInfo ('NjTulAuki= ON');
            NjTulFrm.Show;  end            //<Jotta NjTulFrm tulisi päällimäiseksi
         else begin
          //EiOkInfo ('NjTulAuki= EIOO');
            NjFrm.OkBtn.Enabled := false;
            NjFrm.Update;                  //<Jotta StrGr :stä poistetun Boxin paikka korjautuisi <<
            EditNj;  end;
      end;
      NjFrm.OkBtn.Enabled := true;
      Screen.Cursor := crDefault;
   end;//LaskeNj

   procedure LaskeKatuval;      begin //+7.0.3
      Screen.Cursor := crHourGlass;
      if NjTulAuki and not eriNj        //<1.1.0
      then begin                        //<1.1.0
         NjTulFrm.Show;  end            //<Jotta NjTulFrm tulisi päällimäiseksi
      else begin
         NjFrm.OkBtn.Enabled := false;
         NjFrm.Update;                  //<Jotta StrGr :stä poistetun Boxin paikka korjautuisi <<
         EditNj;                        //<Siellä valtaosa ohitetaan =Tulostaa vain edv:n tiedot.
         LueLaskeKatuval;               //<######## PÄÄKUTSU #######################################
      end;
      NjFrm.OkBtn.Enabled := true;
      Screen.Cursor := crDefault;
   end;//LaskeNj

begin//OkBtnMouseDown.......................................

   inherited;
   if ssAlt IN Shift               //<,,+7.0.3
   then begin
      Katuval := true;
      SyottoAvFrm.Hide;           //< +3.0.0   0u???
      NormBtn;                    //< +2.0.5
                                  //<EditSyoFrm jäi tästä vex
      PaaValFrm.Update;      //<Päivittää (poistaa SyotFrm:sta jääneitä tkestejä)  +4.0.0
      EdvNewFrm.Update;      //<Päivittää (poistaa SyotFrm:sta jääneitä tkestejä)  +4.0.0
      LaskeKatuval;
      NjTulFrm.VExKrtBx.Enabled := false; //<,,+7.0.3
      NjTulFrm.Jatka.Enabled :=    false;
      NjTulFrm.TulNoEdi.Enabled := false;
   end
   else if poisOK  then begin     //''+7.0.3  ,+7.0.5 ,,Sama herja NjVrk.INC :ssa
      if SokI (Bx1.Text{Laskettava Edj.osa},i) and (i<>a_getIntg (30100, mo.moty.Vrk))  and MootNj{+8.0.14}  then
        {InfoDlg ('Moottolähtöjen käsittelyosassa <b>"Verkkopiste" = '+
                  IntToStr (a_getIntg (30100, mo.moty.Vrk)) +'</b>. Tässä <b>"Laskettava ED.VERKON johto-osa" = '+
                  IntToStr (i) +'</b> ei vastaa samaa verkkotilannetta. Korjaa, jos <b>laskentatilanne </b>niin '+
                  'edellyttää.',}
         InfoDlg ('Moottolähtöjen käsittelyosassa <b>"Verkkopiste"='+                               //8.0.10
                  IntToStr (a_getIntg (30100, mo.moty.Vrk)) +'</b> poikkeaa tässä <b>"Laskettava ED.VERKON '+
                  'johto-osa" </b>-ikkunan arvosta (=<b>' +IntToStr (i) +')</b>. Korjaa, jos <b>'+
                  'laskentatilanne </b>niin edellyttää ja/tai käytät Moottorilähtöosan tietoja laskennassa.',
                  mtCustom,'Jatka','','','',  '','','','');
      Katuval := false;           //<+7.0.3
      SyottoAvFrm.Hide;           //< +3.0.0   0u???
      NormBtn;                    //< +2.0.5
    //AvuChkSft (10);             //< 2.0.5  0->10.  -4.0.0
      ketjuArvot;            //<NjLas38.INC  Ptas[1] :n arvoa tarvitaan NjVrk.INC/SyottoFrm -operssa
      syoKut := 5;
      editSyoFrm;
      PaaValFrm.Update;      //<Päivittää (poistaa SyotFrm:sta jääneitä tkestejä)  +4.0.0
      EdvNewFrm.Update;      //<Päivittää (poistaa SyotFrm:sta jääneitä tkestejä)  +4.0.0
      if Hvrt > -1           //<Sai arvon -1 SyottoFrm :n SuljeBtnClickissä
         then LaskeNj;
      NjTulFrm.VExKrtBx.Enabled := true; //<,,+7.0.3
      NjTulFrm.Jatka.Enabled :=    true;
      NjTulFrm.TulNoEdi.Enabled := true;
   end;
end;//OkBtnMouseDown

{==================================================================================================}
function OKsenderBx1_6(Sender :Tobject;  var nro :integer) :boolean;   //var s :string;
     procedure prc(boxi :integer);   begin                     //###################################
       OKsenderBx1_6 := true;                                  //'KÄYTETÄÄN KAIKISSA ComBx EVENTssä
       nro := boxi;   end;                                     //'#### PALAUTTAA KUTSUVAN RIVIN ####
begin
  result := false;
  with NjFrm  do
    if Sender=Bx1  then prc(1)  else
    if Sender=Bx2  then prc(2)  else
    if Sender=Bx3  then prc(3)  else
    if Sender=Bx4  then prc(4)  else
    if Sender=Bx5  then prc(5)  else
    if Sender=Bx6  then prc(6)  else
    if Sender=Bx7  then prc(7)  else
    if Sender=Bx8  then prc(8)  else
    if Sender=Bx9  then prc(9);
end;//FNC OKsenderBx1_6

procedure FocusBak(Sender :TObject);      var no :integer;      begin
  if OKsenderBx1_6(Sender,no)  then
  with NjFrm  do
  case no of
     1 :Bx1.SetFocus;     2 :Bx2.SetFocus;     3 :Bx3.SetFocus;     4 :Bx4.SetFocus;    5 :Bx5.SetFocus;
     6 :Bx6.SetFocus;     7 :Bx7.SetFocus;     8 :Bx8.SetFocus;     9 :Bx9.SetFocus;    end;//case
end;//FocusBak

procedure TNjFrm.Bx1_6Enter(Sender: TObject);      VAR no :integer;      begin
   SyottoAvFrm.Hide;                  //< +4.0.0
  {if}fEhkaTarkArvo (0);//then begin  //< +2.0.5 JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell.  +4.0.0 IF
      NormBtn;                        //< +2.0.5
    //AvuChkSft (0);                  //< +2.0.5  Oli 10.  -4.0.0
      if OKsenderBx1_6(Sender,no)  then begin
         AvuChkSft (9);               //< +2.0.5  4.0.0 = 0->9
         if syoAvon  then begin       //< 1.1.3 ..Checked->syoAvOn
            fSyoAktv (0);
            avust (1,no+30, 0);
            AvuChkSft (11);  end;     //< +2.0.5  ???Vrt ed.????0aa
         sijBxG(0,no);                //<boxi=ao. Box.  +30 ohjaa oikeaan
      end;
// end;
end;//Bx1_6Enter

{#### OnKeyPress:iin myös tarkistus, koska siellä ohjataan seur. boxiin. Tässä: TAB+SfTAB+Click####}
procedure TNjFrm.Bx1_6Exit(Sender: TObject);      var no :integer;      begin //m++
                   //if ActiveControl=SuljeBtn  then Y_Koe(2,'Exit  Sulje')  else Y_Koe(2,'Exit  ');
  NjTulFrm.Close;                                                 //<Siellä NJtulAuki := false #####
//fSyoAktv (0);     {+1.1.2 -2.0.5}                               //<Ks.Enter: Muuten avuste vilkkuu MouseMovella
  AvuChkSft (9);    //< +2.0.5
  if ActiveControl<>SuljeBtn   then                               //<PäästäväPois ilman tarkistuksia
  if OKsenderBx1_6(Sender,no)  then             //,syoAktv := FA.. jotta seur. avuste mahdollinen
  if NOT arvoOK (no+10,4)  then FocusBak(Sender)           //,,1.1.3 järjestys =-> NOT arvo..
                           else SijNjuIfVE1;               //< +4.0.0
end;//Bx1_6Exit

procedure TNjFrm.Bx1_6KeyPress(Sender: TObject; var Key: Char);      var no :integer;      begin
 {if key=#32  then begin  Y_piipit(50);  //Bx1.Text := 'Ä';   end else }
  if key=#13
  then begin
    if OKsenderBx1_6(Sender,no)  then
    if arvoOK (no+10,4)  then  //<Tarkistus riittää. RTN ei siirrä focusta, OK
    case no of
       1 :SelectNext(Bx1, true,true);         6 :SelectNext(Bx6, true,true);
       2 :SelectNext(Bx2, true,true);         7 :SelectNext(Bx7, true,true);
       3 :SelectNext(Bx3, true,true);         8 :SelectNext(Bx8, true,true);
       4 :SelectNext(Bx4, true,true);         9 :SelectNext(Bx9, true,true);
       5 :SelectNext(Bx5, true,true);   end;//case
  end //if key=
end;//Bx1_6KeyPress

procedure TNjFrm.Bx1_6MouseMove(Sender: TObject; Shift: TShiftState; X,  Y: Integer); //m++
  var no :integer;
     procedure prc (boxi :integer);   begin
      if syoAvOn and NOT syoAktv and NOT apuaOn         //< +1.1.3
         then //begin end;}                             //<'+6.2.21
       avust (1,boxi+30, 0);   end;                     //< -2.0.5 Toimii OK, mutta otettu takas vex. Takas +4.0.0
  begin  if OKsenderBx1_6 (Sender,no)  then prc (no);
end;//Bx1_6MouseMove

procedure TNjFrm.StrGrTopLeftChanged(Sender: TObject);      begin
   NjFrm.BxG.Visible := false;   end;

procedure TNjFrm.ChkBxAvMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
begin                            //'=TapahtuuKunKlikattu ChkBxAv :ta, CB -ARVO EI VIELÄ EHTINYT MUUTTUA, TODETTU.
  inherited;                     //,,Vaihdetaan cbUnChecked, muuten eventti vaihtaa Grayed -> Checked -> UnCheckd
   NormBtn;                      //< +2.0.5
   BxGAukiVisOff;                //< Prc 4.0.0  Varm.vuoksi. JOTTA SEUR. fEhkaTarkArv TIETÄISI.!!!!!
   apuaOn := false;
                 //==Jos tässä sij. cb -arvo, menee ChkBxAvClick -eventiin, eli ei voi lisätä muuta: Menee ENDiin
   if ChkBxAv.State IN [cbGrayed,cbChecked]            //<Pakotet. cbGrayed t. cbChecked -> cbUnChecked
      then Gray_Chkd := true                           //<,Ei voi asettaa suoraan STATEa: aiheuttaa
      else Gray_Chkd := false;                         //  eventin, TODETTU.########################
end;
                                                       //,,AvCloseOK on aina päällä, FA vain AvuChkSf :stä
procedure TNjFrm.ChkBxAvClick(Sender: TObject);   begin//,,CheckedArvo onJo ehtínyt vaihtua Clickin jälk, TODETTU
   if AvCloseOK  then begin                            //<Vain ekalla kerralla läpi, 2.krt tullaan AvuChkSf :stä
      if Gray_Chkd  then begin
         ChkBxAv.State := cbUnChecked;                 //<Vain ChkBxAvMouseDown :sta. Aiheuttaa EVENTIN @@@@@@@@@
{2.0.5+} fSyoAktv (0);  end;            //<Koska SYOAKTV+SYOAVONin perusteella Grayed/Chkd/UnChkd AvuChkSft :ssa
      if ChkBxAv.State=cbUnChecked
{2.0.5+} then begin syoAvOn := false;   //<, SYOAVON asetus VAIN TÄSSÄ + StrGrDblClick :ssä #####################
                    SyottoAvFrm.Hide;  end
{2.0.5+} else       syoAvOn := true;                   //<Kattaa cbGrayed + cbChecked

      AvuChkSft (0);  end;
   Gray_Chkd := false;                                 //<Vain ChkBxAvMouseDown :ssa @@@@@@@@@@@@@@@@@@@@@@@@@@@@
end;//ChkBxAvClick
//==================================================================================================
procedure TNjFrm.FormActivate(Sender: TObject);              //<Pakko, muuten mm. FNC arvoOK eiOK
  procedure avu(boxi :integer);      begin                   //'Tapahtuu myös FrmCreatillä
    avust( 1,boxi+30, 0);
  end;
begin//FormActivate
  if ActiveControl=Bx1  then avu(1)  else                    //<StrGr:n Box suljettiinAINA Deact:ssa
  if ActiveControl=Bx2  then avu(2)  else                    //joten Bx :ää ei tarvitse huomioida,
  if ActiveControl=Bx3  then avu(3)  else                    //koska se ei voi olla auki formin akti
  if ActiveControl=Bx4  then avu(4)  else                    //voituessa<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  if ActiveControl=Bx5  then avu(5)  else
  if ActiveControl=Bx6  then avu(6)  else
  if ActiveControl=Bx7  then avu(7)  else
  if ActiveControl=Bx8  then avu(8)  else
  if ActiveControl=Bx9  then avu(9);
end;//FormActivate

procedure TNjFrm.FormDeactivate(Sender: TObject);      begin
 //BxGAukiVisOff;                             //< +4.0.0  BxGAuki+Visible := FA, varm.vuoksi.
   NjFrm.BxG.Visible := false;                //<Visible := FA, varm.vuoksi. EI BxGAuki := FA, TODETTU !!!!!!!!!!!
end;

procedure TNjFrm.FormShow(Sender: TObject);      begin//m++
   Caption := PROGRAM_VERSIO_STRING +':  Pää-/NJ -laskenta.   Keskustiedot:'; //+6.2.10  <Lyhennetty 10.0.5
   Caption := Caption +NjFilen;               //<Vaikka olisi tyhjä fileNimi.                    //<+10.0.5
   StrGr.Align := alClient;                   //< +4.0.0
   eSar := 0;
  {if syoAvOn  then ChkBxAv.Checked := true   //< -+1.1.3  +Oli FALSE,  ,,oli TRUE
               else ChkBxAv.Checked := false; //< -2.0.5}
   AvuChkSft (0);                             //< +2.0.5
   if demoLisAs  then begin
      OhjeEfect_ON;                           //< +2.0.5
      avuste(0, -1,4, 0);                     //< +2.0.5  Avust () ei käy, koska FrmEiNäy ja sisFocus -> Error
      OhjeEfect2_ON;  end;                    //<Lukitsee avusteen 5 sek :ksi
   OkBtn.SetFocus;
end;//FormShow                                //<+6.2.2

procedure TNjFrm.StrGrSelectCell(Sender: TObject; Col, Row: Integer;  var CanSelect: Boolean);   begin
 {inherited;}   //,,,Ks. Moot.PAS ############################################################################
  CanSelect := false;
  if NytChkScrol            //<StrGrClick + StrGrDblClik :ssa := TRUE ########################################
  then begin
     //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,#################################################################
     selCOL := Col;  selROW := Row;       //<NÄMÄ MÄÄRÄÄVÄT AVAUTUVAN BxG :n PAIKAN+CELLin ###################
     if Row > StrGr.TopRow  +StrGr.VisibleRowCount -1  then selTOP := StrGr.TopRow;
     if Col > StrGr.LeftCol +StrGr.VisibleColCount -1  then selLFT := StrGr.LeftCol;
     //''''''''''''''''''''''''''''''''''''''#################################################################
     NytChkScrol := false;  end; //'Palautet koska Click liian alas siirsi. Toistuva chk estetty (sis.kierto)
end;//StrGrSelectCell

procedure TNjFrm.StrGrClick(Sender: TObject);      begin//m++  Tähän vasta StrDrMouseDown :n jälkeen
  inherited;                                                                       //ediS ('(Clk)');
   NytChkScrol := true;                //< := FALSE ..SelectSell -eventissä ###################################
      if SyoAvOn  and NOT BxGAuki  and NOT Kopioi  and NOT Poista
      then begin                            //' +4.0.0  ,,Lukitaan avuste sarak :seen. BxG:n avust ks. ohjaaBxG
         fSyoAktv (0);  avust( 0,Sar, 0);  fSyoAktv (1);   end
      else AvuChkSft (11);                  //< 11 =Lukitsee avusteen.  -2.0.3  +2.0.5
   selLFT := 0;  selTOP := 0;
end;

procedure TNjFrm.StrGrDblClick(Sender: TObject);      begin//m++
  inherited;
   DblClck := true;                     //<Estää MouseDown =OhjaaBx -tapahtuman, := FA MouseDwn ###############
   syoAvOn := true;                     //< +1.1.3 Vain tässä + ChkAvBxClick :ssä
   NormBtn;                             //< +2.0.5
   AvuChkSft (20);                      //< +2.0.5  10 =Vapauttaa avusteen.  4.0.0:  10 -> 20
end;

procedure TNjFrm.DetRad1_3Click(Sender: TObject);      begin //<1.1.0  4.0.0 1,2,3 -> 1_3
  inherited;
   if fEhkaTarkArvo (0)  then begin     //<JosOltiinUudella rivillä BxG:ssä, tarkist + editoi Cell +4.0.0
      NormBtn;                          //< +2.0.5
    //AvuChkSft (10);                   //< +2.0.5  0->10 =Vapauttaa avusteen.  -4.0.0
      if NjTulAuki then NjTulFrm.Close;
   end;
end;

procedure TNjFrm.Panel1MouseMove(Sender: TObject;  Shift: TShiftState;  X,Y: Integer); //m++
begin
  inherited;
  {if NOT syoAktv  then begin                                //<,, -1.1.3
      SyottoAvFrm.Hide;
      eCmBx := 0;   end; //< := 0, jotta avuste heräisi, jos ulos bx:sta ja palataankin takas}

   {,,Vex +4.0.0  jottei panelin ComBoxien päällä hiirellä liikutaessa välkkyisi ikävästi,,,,,,,,,,,
   if NOT syoAktv  and  syoAvOn  and  NOT apuaOn  then begin //< +1.1.3 +Korjattu
   //''EI Lukittu   +   Ruksi     +   EI OhjeBtn
      SyottoAvFrm.Hide;                                      //< 1.1.3 Korjattu
      eCmBx := 0;   end; //< := 0, jotta avuste heräisi, jos ulos bx:sta ja palataankin takas}
  //,,+10.0.4  Siirretty
   if MootVrkMuutosInfo
   then begin //+10.0.4
      Lb1.Font.Style := [fsBold];         //<Johto-osaN:on Lbl boldiksi.
      InfoDlg ('Syöttöikkunan alapanelin  "<b>Laskettava ED.VERKON johto-osa</b>"  on muutettu  Moottorilähtöjen '+
               'käsittelyosassa asetetun  "<b>Verkkopiste</b>" -arvoikkunan mukaiseksi (=<b>' +
               Ints (mo.moty.Vrk.ArvoInt) +'</b>). <b>Korjaa, jos laskentatilanne </b>niin edellyttää.',
               mtCustom,'Jatka','','','',  '','','','');
      MootVrkMuutosInfo := false;  end
   else Lb1.Font.Style := [];
end;

procedure TNjFrm.ChkBxAvMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);      begin
   inherited;
 //SyottoAvFrm.Hide;        //< -3.0.0
   if NOT syoAktv  then
      ValmistaNollaaAvuste; //< +3.0.0
end;

procedure TNjFrm.Lb1MouseMove(Sender: TObject;  Shift: TShiftState; X,Y: Integer);      VAR no :integer;

   function LBLsender (Sender :Tobject;  VAR nro :integer) :boolean;
        procedure prc(LBLno :integer);   begin
          LBLsender := true;
          nro := LBLno;   end;
   begin
     result := false;
     with NjFrm  do
       if Sender=Lb1  then prc(1)  else
       if Sender=Lb2  then prc(2)  else
       if Sender=Lb3  then prc(3)  else
       if Sender=Lb4  then prc(4)  else
       if Sender=Lb5  then prc(5)  else
       if Sender=Lb6  then prc(6)  else
       if Sender=Lb7  then prc(7)  else
       if Sender=Lb8  then prc(8);
   end;//FNC LBLsender
begin//,,,,,,,,,,,,,,,,,,,,,,
   inherited;
   if LBLsender (Sender,no) and syoAvOn and NOT syoAktv and NOT apuaOn
       then avust (1,no+30, 0);                         //<'+6.2.21
end;

procedure TNjFrm.DetRadEnter(Sender: TObject);      begin
   inherited;
   fEhkaTarkArvo (0);                          //< +4.0.0 Jos tultiin BxG:stä, tarkist + editoi Cell
end;

procedure TNjFrm.FormHide(Sender: TObject);      begin //< +6.0.0
   inherited;
   EdvNewFrm.Enabled := true;
   PaaValFrm.Enabled := true;
end;

procedure TNjFrm.FormClose(Sender: TObject; var Action: TCloseAction);      begin //< +6.0.0
   inherited;
   FormHide(Sender);
   MootNJ := false;  //<+8.0.0
end;

initialization
  MootVrkMuutosInfo := false;                   //<+10.0.4
  NjTulAuki := false;
  sar := 0;  eSar := 0;   riv := 0;  eRiv := 0;
  BxGAuki := false;
  BxSar := 0;  BxRiv := 0;                      //< +4.0.0
  jkVE := 1;                                    //< +4.0.0
  poista := false;    kopioi := false;   jkVEo; //< 1. palaut=jkf, 0=jku
  NytChkScrol := true;                   //<Pakko tässä, jotta ekallakin Clickillä TRUE ######################
  DblClck := false;  selCOL := 0;  selROW := 0;  selLFT := 0;  selTOP := 0;
  Gray_Chkd := false; //< +1.1.3
  NjF_Filen :=  '';
  Nj0_Filen :=  '';
end.

