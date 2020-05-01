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
unit Syotto;
{SijBtns sijoittaa Btns, Grds, Lbls jne Frm´ille.
 Tarkistus poistuttaessa syöttölomakkeesta:  OkBtnMouseUp / PRC edvPvitOK.
       ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,   ###########################################################################
       Apuruudun aukaisussa tapahtuu:  ###########################################################################
       '''''''''''''''''''''''''''''   ###########################################################################
         - OhjLaskIkkuna
         - AsetaLaskIkkuna
             => sijCyBx (11..41) => á arvoOKe  (sijoittaa Yvrk[] :oon)
         - LasEdiLy_Gr (99)
             => ChkSiirraBtns => fCyBxtOk  => á arvoOK  (sijoittaa Yvrk[] :oon).
       ..joten tämän PRCn kutsumissa rutiineissa (Sk_Ik1...SkRpX_RX1) pitää tarvittaessa tehdä arvotarkistukset
       ja SIJOITUKSET erikseen. arvoOK :ta ei ole (vissiin) käytetty kuin PRC CyBx_Change :ssa.
.....................................  ###########################################################################
10.0.4  PRC PvitaYHT:ssä sijoitus:  SyottoFrm.StrGrY2.Cells[1,12] := '0.0006408 / eRs=0.000591XXX'  paljasti,
        että liian pitkä mjono leväyttää koko lomakkeen hirveän leveäksi. =Otti viikon selvittää syy.
        Nyt leveys asetetaan PRC AsetaLaskIkkuna´ssa:  Cells[1,3] := '0.001898678XXXXXXXXX Zz';
                                                 oli:  Cells[1,3] := '0.001898678XXXXXXXXX';
        Virhettä ei ollut 10.0.3:ssa, missä ei ollut näin leveää tulostusta (PRC PvitaYHT:ssä).
}
{###################################################################################################
 SyoKut (=SyoOsa):
  1 = Edv:n liittymätietojen syöttö<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  2 = Edv:n johto-osatietojen syöttö<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  3 = Uh-rajan + edv:n uh%-osuuden syöttö<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Ei käytössä enää >= 4.0.0 :ssa
  5 = Häviökust/NjLaskenta<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  6 = Lisätään LIITTYMÄ  alkuun, väliin tai loppuun<<<<<<<<<<<<<<<<<<<<<<<
  7 = Lisätään johto-osa alkuun, väliin tai loppuun<<<<<<<<<<<<<<<<<<<<<<<
  8 = Moottorilähtöosan itemit (=MoKut/PaaVal Const)<<<<<<<<<<<<<<<<<<<<<<}// 6 => 8 = +8.0.0
            // 1=Liitt  2=EdvJ  3=Uh-raj(eiEnää)  5=Häviökust  6=LisätLIITTYMÄ  7=LisätJohto-osa  8=MoottItemit
{###################################################################################################
                    KOKEILTU:   i := 651500;
                                case i of 500 :s := 'Onnistui case 500';
                                         1500 :s := 'Onnistui case 1500';
                                        51500 :s := 'Onnistui case 51500';
                                       651500 :s := 'Onnistui case 651500';  end; //<Tämäkin OK!!!!!
- FORMin asetukset:         Ks. PRC AsBxSyotFrm /  PRC AsSyottoFrm
- SYÖTTÖruutujen asetukset: Ks. PRC AsBxSyotFrm
- SYÖTTÖruutujen SISÄLTÖ:   Ks. SyoKut.INC / PRC BxArvot / PRC sijAoBox  sis. StrGr -saraketekstit
- AVUSTEET:                 Ks. PRC Avuste()
- EXIT tapahtuu AINA, kun syöttöBOXISTA poistutaan, joten siihen ARVO/OIKEELLISUUSTARKISTUKSET<<<<<<
####################################################################################################
- Frm:n teon määrää:
  - CLOB.: syoKut     := Edv:n ao. johto-osan BtnClick, jotka käyttävät SyottoFrm.
                         SYOKUT käytetään Boxien itemien kokoamistietoon ja FNC arvoOK tarkistuksiin
                         =kertoo kutsuvan ohaosan. StrGr:n Bx:ille EI VOIDA ANTAA syoKut -ARVOA, kos
                         ka samanaikaisesti saattaa olla SyottoFrm auki, jolloin SYOKUT:n arvo ei
                         pysyisi ajan tasalla = StrGr:n Bx:ille ao. kutsuissa tieto mukana kutsuissa.
  - LOCAL: ao. ComBx   = Määrää käsiteltävän rivin
  - CLOB.: Edv :n EDI  = Määrää käsiteltävän edka,edkaX,edka0[edi] :n
- Ohan KULKU:         Syotto.PAS        Syotto.PAS                    SyottoAv.PAS
  - OnCreate kutsuu   PRC (TeeKutsu nyt:) TeeSyoFrm  =>  Lado_TeeSyoFrm (=StrGr-tekstit) => BxItems (=Box.Items)
    'Lado_TeeSyoFrm :n SijBox :ssa asetetaan boxien Text+Items sekä SIJOITETAAN Textiarvot edv :n (jms.)
    muuttujiin FNCkutsulla ArvoOK(), jotta voitaisiin mennä kursorilla suoraan haluttuun syöttökoh-
    taan; muutenhan arvot tulee tarkistetuksi ja SIJOITETUKSI vasta poistuttaessa ao. boxista !!!!!!
  - OnEnter  kutsuu   PRC BxArvot   =Aina tarkistetaan, josko jonkin Boxin arvo olisi vaikuttanut.
  - OnExit   kutsuu   FNC arvotOK(rv)
  - OkBtnMouseUp kuts FNC arvotOK(1...BoxRvja)   BOXRVJA := PRC Lado_TeeSyoFrm / sijBox
####################################################################################################
Jos MUUTAT / LISÄÄT ComBoxien syöttökohtaista TARKOITUSTA, TARKISTA MYÖS:      #####################
  - SyoKut.INC:   FNC BxItems        =ComBx:n OLETUSARVOT + (pudotus)ITEMIT    #####################
  - - " -         PRC Lado_TeeSyoFrm =StrGr -saraketekstit                     #####################
  - SyoArvOK.INC: FNC arvoOK         =Kunkin syöttötilanteen arvojen tarkistus #####################
####################################################################################################
StrGrY :n ja CyBx :n arvoyhteydet Col= 0 ja 4:   (RIV = Myös OSOITE Yvrk[riv] :iin @@@@@@@@@@@@@@@@@
- FNC fYriv (Sar,Riv :int) :int palauttaa RIV -arvon ###################,,,!!!!!!!!!!!!!!!!!!!!!!!!!
    SyoRv  Cells[COL,ROW] Riv   ComBox   Nimike Yvrk   Cells[COL,ROW]   Riv   ComBox   Nimike Yvrk
   (Vihreä)
       1           1,0     11   CyBx11    U1    [11]           4,0       31   CyBx12    R/X   [31]
       2           1,1     12   CyBx21    Sk    [12]           4,1       32   CyBx22    Ik3v  [32]
       3           1,2     13                                  4,2       33
       4           1,3     14   CyBx31    Ry    [14]           4,3       34   CyBx32    Xy    [34]
       5           1,4     15             Ry`   [15]           4,4       35             Xy`   [35]
       6           1,5     16   CyBx40    Sm    [16]           4,5       36
       7           1,6     17   CyBx51    Zk%   [17]           4,6       37   CyBx52    Pk    [37]
       8           1,7     18   CyBx61    U2    [18]           4,7       38   CyBx62    L[km] [38]
       9           1,8     19   CyBx71    Rv    [19]           4,8       39   CyBx72    Xv    [39]
       10          1,9     20                                  4,9       40
       11          1,10    21                                  4,10      41   CyBx80    Lv    [41]
       12          1,11    22                                  4,11      42             Cos   [42]
       13          1,12    23             Ry    [23]           4,12      43             Xy    [43]
       14          1,13    24             Sk    [24]           4,13      44             Ik3v  [44]
--------------------------------------------------------------------------------------------------
Muutokset:
§g - VV muutettu RadGrp.Index 2:een:  Oli: 0=SJ  1=PJ  2=VV (oli ups)  3=UPS (ennen ei mitään)     =+8.0.8
SyoUlos => SyoQuit  8.0.10  SyoBackQuit 10.0.4, =>1412: SyoPeruttu
³ =SetFocus:  Johto-osatietojen dialogin pud.valikot eivät auenneet klikkauksella, Focuseja poistettu -8.0.11
####################################################################################################}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, NolaForms,
  StdCtrls, ExtCtrls, ComboBoxXY, Grids, Mask, StringGridNola, LabelNola,
  PanelNola, Johto, CutInfo, ComCtrls, RichEditNola,LicenseFuncs,ShellApi{1411}{lvLT..}{,FileCtrl}{KoeWInfoA};

const WM_UPDATECOMBO = WM_USER+1000; //<Jani Järvisen Mailin mukaan 4.9.01  +5.0.0, ks. PRC WMUpdateCombo jälemp+..
type
  TSyottoFrm = class(TFormNola)
    Panel1: TPanel;
    OkBtn: TButton;
    PeruBtn: TButton;
    PoistaBtn: TButton;
    RadGrp: TRadioGroup;
    StrGr1: TStringGridNola;
    StrGr2: TStringGridNola;
    StrGr3: TStringGridNola;
    StrGr4: TStringGridNola;
    ComBx1: TComboBoxXY;
    ComBx2: TComboBoxXY;
    ComBx3: TComboBoxXY;
    ComBx4: TComboBoxXY;
    ComBx5: TComboBoxXY;
    ComBx6: TComboBoxXY;
    ComBx7: TComboBoxXY;
    ComBx8: TComboBoxXY;
    ComBx9: TComboBoxXY;
    ComBx10: TComboBoxXY;
    ComBx11: TComboBoxXY; //<''Ei voida lisätä MITÄÄN KOMPONENTTIA TURHAAN:  Handlet loppuvat -> Win32 API failure
    ComBx12: TComboBoxXY; //   Todettu DEVELOPER2 kanssa 2.12.2000   =4.0.0:  Mm. poistettu liikoja ylimääräisiä (W98)
    ComBx13: TComboBoxXY;
    ComBx14: TComboBoxXY;
    ComBx15: TComboBoxXY;
    OhitaBtn: TButton;
    DiskontPanel: TPanelNola;
    LopArvPanel: TPanelNola;
    Lask10Panel: TPanelNola;
    Lask11Panel: TPanelNola;
    Lask12Panel: TPanelNola;
    Lask20Panel: TPanelNola;
    Lask21Panel: TPanelNola;
    Lask22Panel: TPanelNola;
    AlkuPhPanel: TPanelNola;
    PanelY: TPanelNola;
    PanelYy: TPanelNola;
    Label1: TLabel;
    Label2: TLabel;
    ChkBxAv: TCheckBox;
    StrGrY1: TStringGridNola;
    ImgMuunt: TImage;
    StrGrY2: TStringGridNola;
    CyBx11: TComboBoxXY;
    CyBx12: TComboBoxXY;
    CyBx21: TComboBoxXY;
    CyBx22: TComboBoxXY;
    CyBx31: TComboBoxXY;
    CyBx32: TComboBoxXY;
    CyBx40: TComboBoxXY;
    CyBx51: TComboBoxXY;
    CyBx52: TComboBoxXY;
    CyBx61: TComboBoxXY;
    CyBx62: TComboBoxXY;
    CyBx71: TComboBoxXY;
    CyBx72: TComboBoxXY;
    CyBx80: TComboBoxXY;
    ImgVii: TImage;
    PanelYa: TPanelNola;
    LbYa2: TLabel;
    LbYa1: TLabel;
    SiirraA_Btn: TButton;
    SiirraY_Btn: TButton;
    PanelYa2: TPanelNola;
    aRich: TRichEditNola;
    UpDwnH: TUpDown;
    UpDwnW: TUpDown;
    CmBxKoe: TComboBoxXY;
    ListBx1: TListBox;
    MuuBtn: TButton;
    JkUpsChk: TCheckBox;
    JkUpsLbl: TLabel;
    ChkBxAvLbl: TLabel;
    procedure StrGr1WidestColInRow(Sender: TObject; ACol, ARow, newWidth: Integer);
    procedure StrGr2WidestColInRow(Sender: TObject; ACol, ARow, newWidth: Integer);
    procedure StrGr3WidestColInRow(Sender: TObject; ACol, ARow, newWidth: Integer);
    procedure StrGr4WidestColInRow(Sender: TObject; ACol, ARow, newWidth: Integer);
    procedure PoistaBtnClick(Sender: TObject);
    procedure OhitaBtnClick(Sender: TObject);
    procedure PeruBtnClick(Sender: TObject);

    procedure StrGr1_10MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure StrGr1_10MouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
    procedure StrGr1_10DblClick(Sender: TObject);
    procedure StrGr2MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);

    procedure DiskontPanelMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure DiskontPanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DiskontPanelDblClick(Sender: TObject);
    procedure AlkuPhPanelMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
    procedure AlkuPhPanelMouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure AlkuPhPanelDblClick(Sender: TObject);
    procedure LopArvPanelMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
    procedure LopArvPanelMouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LopArvPanelDblClick(Sender: TObject);
    procedure AlaPanels1MouseMove(Sender: TObject;   Shift: TShiftState; X, Y: Integer);
    procedure AlaPanels2MouseMove(Sender: TObject;   Shift: TShiftState; X, Y: Integer);
    procedure AlaPanels1MouseDown(Sender: TObject;   Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure AlaPanels2MouseDown(Sender: TObject;   Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure AlaPanels1DblClick(Sender: TObject);
    procedure AlaPanels2DblClick(Sender: TObject);

    procedure ComBx1_11MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure ComBx1_11Enter(Sender: TObject);
    procedure ComBx1_11Change(Sender: TObject); 
    procedure ComBx1_11Exit(Sender: TObject);
    procedure RadGrpClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure StrGrY1WidestColInRow(Sender: TObject; ACol, ARow, newWidth: Integer);
    procedure StrGrY2WidestColInRow(Sender: TObject; ACol, ARow, newWidth: Integer);
    procedure Label1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Label1DblClick(Sender: TObject);
    procedure StrGrY2MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure StrGrY2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure StrGrY2DblClick(Sender: TObject);
    procedure CyBx1_80MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure CyBx1_80KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure ComBx1_11KeyDown(Sender: TObject;  var Key: Word;  Shift: TShiftState);
    procedure CyBx1_80Enter(Sender: TObject);
    procedure CyBx1_80Change(Sender: TObject);
  //procedure CyBx_Exit(Sender: TObject);
    procedure SiirraY_BtnMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure SiirraA_BtnMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure SiirraY_BtnClick(Sender: TObject);
    procedure SiirraA_BtnClick(Sender: TObject);
    procedure LbYa1DblClick(Sender: TObject);
    procedure LbYa2DblClick(Sender: TObject);
    procedure LbYa1MouseDown(Sender: TObject;  Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
    procedure LbYa2MouseDown(Sender: TObject;  Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ChkBxAvClick(Sender: TObject);
    procedure ChkBxAvMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure ComBx1_80KeyPress(Sender: TObject; var Key: Char);
    procedure MuuBtnClick(Sender: TObject);
    procedure ListBx1MouseUp(Sender: TObject; Button: TMouseButton;  Shift: TShiftState;  X,Y: Integer);
    procedure ListBx1MouseMove(Sender: TObject; Shift: TShiftState;  X,Y: Integer);
    procedure MuuBtnMouseMove(Sender: TObject; Shift: TShiftState;  X,Y: Integer);
    procedure UpDwnHMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState;  X,Y: Integer);
    procedure UpDwnWMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState;  X,Y: Integer);
    procedure OkBtnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);
    procedure OkBtnMouseMove(Sender: TObject; Shift: TShiftState;  X,Y: Integer);
    procedure JkUpsChkMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ComBx3Select(Sender: TObject);
  private
    UusCombText :string;                                                 //<,Jani Järvisen Mailin mukaan 4.9.01 +5.0.0
    Procedure WMUpdateCombo(Var Msg : TMessage); Message WM_UPDATECOMBO; //  ks. myös ComBx1_11Change -eventti.
  public              //'Lisätietoja Helpistä: "message handlers" -> "Creating new message handlers" =TÄMÄ PAREMPI.
  end;

CONST BxMaxRv=30;                     //<+6.0.3
var
   MuuLsk :integer;                   //<+10.0.4  ListBx :n valinta, käyttö myös SyoArvOK.INC .
   SyottoFrm: TSyottoFrm;
   GrRvja :integer;                   //<,KÄYTTÖ: Tämän perusteella FOR i := 1 to GrRvt..if BxArr[i] and ArvoOK ..
   BxArr :array [0..BxMaxRv] of boolean; //<Ilmoittaa, onko ao. rivillä Boxi (TRUE) vai ei (vai vain StrGr.Cells).
   SrcEdka :boolean;                  //< TR kun käsitellään Sorc[],  FA kun käsitellään Edka[]. +6.2.2
   procedure editSyoFrm;              //'BxArr asetet./tarvitaan myös SyoKut.INC =Sen takia GLOBAALI !!!!!!!!!!!!!
   procedure AsBxSyotFrm (GrRvt,ApuOts :integer);
   function fLas_Iks1v_Zs (pj_Iks1vKA :real) :real;
procedure Wavu (si :string);     //121.4

implementation

             //EdvNew vain  if EdvNewFrm.ChkBxAv.Checked  then .. takia,,,,,,<<<<<<<<<<<<<<<<<<<<<<<
uses SyottoAv, Y_, Herja1, PaaVal, NjVrk, Unit1, EdvNewLask, Globals, Defs, EdvNew, LaskeeOd,
     Korj{=ComBx1_11Change/"Valintataulukko" -valinnan takia}, Unit0{+6.0.2}{, DetEv{Kokeiluun 6.2.0/EdiWindows},
     InfoDlgUnit, Asetus{Visible-tarkistus}, Koe;

{$R *.DFM}
const LF='<br>';     //<Koe}
    //_sarja=SyottoFrm.StrGrY2.ColCount-1;   _rivja=SyottoFrm.StrGrY2.RowCount-1;
//type WinTyp=RECORD enab :boolean;   nimi :string;  end; //<+6.2.x

var {SyoUlos -8.0.10,10.0.4=SyoBackQuit=>1412:}SyoPeruttu ,DblKlikki,Ctrl :Boolean;   //<Alustus initializ:ssa.  Ctrl =+8.0.3
    RuuArr :array [0..6,0..23] of string;            //+10.0.4 Tarkistettava ..Count. Apuruudun alp.textit talletetaan.
    NormClose{10.0.4} :boolean; //<Ks. PRC CloseNrm.
    edvo :EdvYHTtype;   //< edvu -> edvo 6.2.20
    Gray_Chkd :boolean; //<+4.0.1 Vain PRC ChkBxAvMouseDown ja ChkBxAvClick väliseen tiedonsiirtoon ILMAN EVENTIÄ
    SiirBtnYok,SiirBtnAok :boolean;    //<+10.0.4
  //WinARR :ARRAY of WinTyp; //<+6.2.x  ARRAY Form´sta, jotka olivat auki SyottoFrm´n avautuessa.
  //UpsNytVex :integer; //1412:  >0 =vex  -1412: NolaVar´iin.
    sq :string;         //<Glob kum.kutsukohtaStr.

procedure JVileen(si :string);      begin end; //+141.2
//   JFileen(si);  end;
procedure MuuLaskenta; forward;//10.0.4
procedure Koe_wrCtrls (oss :string); forward; //<10.0.4  Koe.

(*procedure AsBxTabOrders;      begin  with SyottoFrm  do begin                   //<,,Koe.
   {ComBx1.TabOrder :=  1;    ComBx2.TabOrder :=  2;    ComBx3.TabOrder :=  3;    ComBx4.TabOrder :=  4;
    ComBx5.TabOrder :=  5;    ComBx6.TabOrder :=  6;    ComBx7.TabOrder :=  7;    ComBx8.TabOrder :=  8;
    ComBx9.TabOrder :=  9;    ComBx10.TabOrder := 10;   ComBx11.TabOrder := 11;   ComBx12.TabOrder := 12;
    ComBx13.TabOrder := 13;   ComBx14.TabOrder := 14;   ComBx15.TabOrder := 15;   //<''Oltava oikea järjestys eikä}
    ComBx1.TabOrder :=  2;    ComBx2.TabOrder :=  3;    ComBx3.TabOrder :=  4;    ComBx4.TabOrder :=  5;
    ComBx5.TabOrder :=  6;    ComBx6.TabOrder :=  7;    ComBx7.TabOrder :=  8;    ComBx8.TabOrder :=  9;
    ComBx9.TabOrder :=  10;   ComBx10.TabOrder := 11;   ComBx11.TabOrder := 12;   ComBx12.TabOrder := 13;
    ComBx13.TabOrder := 14;   ComBx14.TabOrder := 15;   ComBx15.TabOrder := 16;   //<''Oltava oikea järjestys eikä
end; end;*)
//################################################################################################################
//################################################################################################################
//Ks.  Syotto-LstFileen-ÄläHävitä.INC  = Testauskäytössä hyviä, tulostaa tiedostoon ikkunakokoja, parametreja yms.
procedure KoeWInfoA (Viiva :integer;  ots :string);      begin  end;
//Varsinainen KoeWInfoA (), ks. Syotto-LstFileen-ÄläHävitä.INC
//################################################################################################################
//################################################################################################################
procedure Wavu (si :string);     begin end; (* VAR Lst :TStringList;  ff :TextFile;  fn,sx :string;  u :integer;   begin //121.4
      //C:\Projektit XE2\NolaKehi\BIN\$_UFileen.txt
      fn := gAjoPath +'$_avuFileen.txt';
      sx := '';  u := -1;
      Lst := TStringList.Create;
      if fFileExists(fn)  then begin
         Lst.LoadFromFile(fn);
         u := Lst.Count;  end;
      if NOT fFileExists(fn) OR (u=0)  then begin
         Lst.Add(DateTimeToStr(Now));
      end;
      Lst.Add(si);
      if Lst.Count>0  then
         wbeep([0,0]);
      Lst.SaveToFile(fn);
      Lst.free;
   end; //*)

procedure CloseNrm (Sender :TObject);      begin //10.0.4
   NormClose := true; //<TeeSyoFrm´ssa := FA, jos OnClosessa FA => edv := edvo, TR estää em. sijoituksen ennen Close´a.
   SyottoFrm.Close;   //PRCn Käyttö Close´n sijaan, jolloin jos Borderin X:stä lopetus erottuu koska FA jää "päälle".
end;

procedure avust (CmBx,Rv,SyoOsa :integer);      begin //Hiiren Move+Click ALARUUDUSSA kutsuu tätä.
   //Wavu('CmBx=' +Ints(CmBx) +' Rv=' +Ints(Rv) +' SyoOsa=' +Ints(SyoOsa));
   avuste(CmBx,Rv,SyoOsa, 0);
// if SyottoFrm.Showing  and SyottoFrm.Visible  then //<-8.0.14  ,³ takas 11.0.1
{³  SyottoFrm.SetFocus;  }end; //<Aiheutt. CAPTIONin 'vilkkumista', jos AVUSTE.INCssä BringToFront tms.
                               //'Jos SetFocus -> aiheuttaa SyottoFrm:n häviämisen alle
function avusf (CmBx,Rv,SyoOsa :integer) :string;      begin//+11.0.1
   //Wavu('avusf:  CmBx=' +Ints(CmBx) +' Rv=' +Ints(Rv) +' SyoOsa=' +Ints(SyoOsa));
   result := avuste(CmBx,Rv,SyoOsa, 0);
end;
function avusU (CmBx,RvOh,RvNr, SyoOsa :integer) :string;      begin//+120.5o:  RvOh=OhjaavaNo  RvNr=Edtoitava no.
   result := avusteU(CmBx,RvOh,RvNr,SyoOsa, 0);   //Oli käytössä hetken kun piti erikseen saada avusteteksti ja Bx. Nyt Dlgt samanlaiset =Samat avusteet
end;
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
function fYriv (Sar,Riv :integer) :integer;      VAR aRv :integer;      begin//Muuntaa Sar,Riv COL,ROW:ksi.
   if Sar>2  then aRv := Riv+30                //<,Riviavusteet alkavat aRv=11 :stä lukien, 10=Yleisohje
             else aRv := Riv+10;
   result := aRv;   end;
procedure anSarRiv (osRiv :integer;  VAR Sar,Riv :integer);      begin//Muuntaa OSRIV´in SAR,RIV´iksi.
   if osRiv>30  then begin  Sar := 4;  Riv := osRiv-31;  end  //<'Col 1 = riv 0..24,  Col 4 = riv 31..44
                else begin  Sar := 1;  Riv := osRiv-11;  end;   end;

procedure avustY (CmBx,Sar,Riv :integer);      VAR aRv :integer;     begin //APURUUDUN kompon Move+Clik kutsuu tätä.
   aRv := fYriv (Sar,Riv);                           //<Lisää +10 (sar<=2) tai 30 (sar>2)   ,,+10.0.4
                //SyottoFrm.Caption := Ints (aRv);   //,10= Yleisinfo.
   if aRv IN [10,11,12,14..19,23,24, 51,52, 31,32,34,35,37..39,41..44] //<Chk 10.0.4
      then avuste (CmBx,aRv,SyoKut, 0)               //<SyoKut tähän tultaessa AINA=1 !!!!!!!!!!!!!!!!!!!!!!!!!!!!
      else if NOT syoAktv                            //<Jos ei ole lukittu (lukittiin ListBx1MouseMove´issa.
      then SyottoAvFrm.Hide;

// if SyottoFrm.Showing  and SyottoFrm.Visible  then //<-8.0.14  ,³ takas 11.0.1
{³ SyottoFrm.SetFocus;  }end; //<Aiheutt. CAPTIONin 'vilkkumista', jos AVUSTE.INCssä BringToFront tms.
                              //'Jos SetFocus -> aiheuttaa SyottoFrm:n häviämisen alle
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}                                     //,Päivitetään CosFii -Celli
function fLas_Iks1v_Zs (pj_Iks1vKA :real) :real;      VAR  kU,Uv,Ik1v,Zs :real;      begin
   kU := a_getReaa (112, edv.YLE.cU);
   Uv := fUv;
   Ik1v := pj_Iks1vKA*1000;                                           //< 1000 = kA -> Ampeeriksi
   Zs := kU *3 *Uv / Ik1v;                                            //<  Zs  = cU*Uv/Iks1v   RR TARVITAAN,,,
   result := Zs;
end;

{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}                  //<,,+4.0.1,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
procedure pvtLiitRpX;      VAR okS :boolean;   rv :integer;   r,x,ik :real;   sr,sx,si :string;      begin//+3.0.2
   okS := false;           //Liittymädialogi:  Päivitetään R/X -Celli
   if syoKut IN [1,6]  then begin
      rv := 0;                           //SorceKind  1=Transformer  2=LV-Cable  3=Generator  4=UPS
      case SyottoFrm.RadGrp.ItemIndex of
      0 :begin                                                          //<,,, 0=SJ-liittyjä
           rv := 5;                      //<RV =Rivi, jolle "Liittymäverkon Rs/Xs ..."
           sr := SyottoFrm.ComBx3.Text;                                 //< Ry
           sx := SyottoFrm.ComBx4.Text;                                 //< Xy
         //if SokR (sr,r) and SokR (sx,x) and (r>0) and (x>0)   then begin //< -6.0.2
           if SokR (sr,r) and SokR (sx,x)  then begin                      //< +6.0.2
              okS := true;
              LiitRpX_Phi_Str (r,x,0, si,sx);  end; end;
            //procedure LiitRpX_Phi_Str (eR,eX,PJ_Ik1v :real;  VAR RpX_s,Phi_s :string);
      1 :begin                                                          //<,,, 1=PJ-liittyjä
           rv := 4;
           si := SyottoFrm.ComBx1.Text;                                 //< Ik1sv
           sr := SyottoFrm.ComBx3.Text;                                 //< eRs
         //if SokR (si,ik) and SokR (sr,r) and (ik>0) and (r>0)  then begin //< -6.0.2
           if SokR (si,ik) and SokR (sr,r) and (ik>0)  then begin           //< +6.0.2
              okS := true;
              LiitRpX_Phi_Str (r,0,ik, si,sx);  end;  end;
      2 :begin                                                          //<,,, 2=VV/Gener.           8.0.8 §g
           rv := 2;  end;
      3 :begin                                                          //<,,, 3=UPS (oli 2)        +8.0.8 §g
           rv := 2;  end;
      end;//case

      if okS  then begin
         SyottoFrm.StrGr1.Cells[1,rv] := CLR_BLB +' = ' +si;
         SyottoFrm.StrGr1.Cells[2,rv] := COLOR_BLUE +'(' +FONT_FII +'=' +sx +'°)';  end;
end; end;//pvtLiitRpX                                              //<''+4.0.1''''''''''''''''''''''''''''''''''''
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
function fHtilaPerRv  :integer;      VAR H :integer;    begin //,###################################
   with SyottoFrm.StrGr1  do begin                            //,Pitää olla asetettu ja myös Options
      H := DefaultRowHeight;                                  //,###################################
      if Options<>[]  then
         H := H +GridLineWidth;
      result := H;   end;
end;
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
function fGrLineWidth :integer;      begin //<,Muuttaa myös StrGridien värit, jotta liiallinen Width erottuisi!!!
   with SyottoFrm  do begin
      result := 0;
      if StrGr1.Options<>[]                   //,AsBxSyotFrm :ssa ##################################
         then result := StrGr1.GridLineWidth  //<Pitää olla asetettu ja myös Options ###############
   end;//with
end;
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
function fStrGr1Width :integer;      begin
   with SyottoFrm.StrGr1  do
         result := ColWidths[0] +ColWidths[1] +ColWidths[2] +ColCount*fGrLineWidth;  end;
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
function fRv (Y :integer) :integer;      VAR H :integer;    begin
   H := Y div fHtilaPerRv;  //< X=0,Y=0 =Caption-alueen ar:ssa.
   result := H;  end;
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
function fRv_1 (Y :integer) :integer;      VAR H :integer;    begin //< Palautaa riviN:on =Row+1 (Row=0->1 1->2..)
   H := fRv (Y);
   result := H+1;  end;
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
function fLy_Col (X,Y :integer) :integer;      var CelCol,CelRow :integer;      begin //<Pal Cellin AbsCOLn
  SyottoFrm.StrGrY2.MouseToCell(X,Y, CelCol,CelRow);                                  //'Scrollattu tai ei
  Result := CelCol;
end;//fLy_Col;
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
function fYhtBtnLev :integer;      begin    //<Komponenttien ottama tila
   with SyottoFrm  do                       //,,,,,,EiSisYhtLeveyteen koskei koskaan samanAikaisesti
                                            //,,,,,,formilla JA leveydet ovat samat (100),,,,,,,,,,,
   Result := OkBtn.Width +PoistaBtn.Width +PeruBtn.Width +16;  end; //<16 =2x(2+4)
                        //'''''''''''''''Tämä korvautuu KustHav :ssa OhitaBtn :lla <<<<<<<<<<<<<<<
//==================================================================================================
//==================================================================================================
          //Tänne tullaan:  setStrGrWidest asetaLftWidthsFrm´sta.                                               Muutettu 8.0.3, 120.6:  Kaikki uusittu, +JkUpsChk
procedure SijBtns{(FrmClientLeveys :integer)-120.6};    VAR b,n{1414d},BtnVali,OkBtnOik{,UpDwnYW} :integer;  PoisKumoaHint,AlpHint :string{1412};  begin

//:::::,         1=JoOk, |++Kysyttävä++++  ++++++|                    5=JoOK,,,,,  6=JoOK,,,,,,,,,  7=JoOK,,,,,,,,,,  8=JoOK,,,,,,, =JoOK=Käsitelty=Valmiit
//:::::,SyoKut:  1=Liitt  +JkUps   2=EdvJ  +JkUps  (3=Uh-raj eiEnää)  5=Häviökust  6=LisätLIITTYMÄ  7=LisätJohto-osa  8=MoottItemit #####################
//''PRC EditSyoFrm´ista.'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
{       SyoKut:  1=Liitt  2=EdvJ  3=Uh-raj(eiEnää)  5=Häviökust    6=LisätLIITTYMÄ  7=LisätJohto-osa  8=Moott.Itemit    |             Left EroEd    Wdth
          ve:t:  OkBtn   PoistaBtn   RadGrp   ---vex--  UpDnH+UpDnW   ChkBxAv   PeruBtn  |    6 LisätLIITTYMÄ           |   PeruBtn   486? ClintW-x   34
                 OkBtn   PoistaBtn¹  RadGrp   ---vex--  UpDnH+UpDnW   ChkBxAv   PeruBtn  |    1 Liitt         ¹=+10.0.7 |   ChkBxAv    426     54
                 OkBtn   PoistaBtn   ------   JkUpsChk  UpDnH+UpDnW   ChkBxAv   PeruBtn  |    2 EdvJ +SorceJ            |   UpDwnH	   367     16 (16+30Yht)
                 OkBtn   PoistaBtn   ------   --------  UpDnH+UpDnW   ChkBxAv   PeruBtn  |    7 LisätJohto              |   JkUpsLbl	336     17 (14 Chk))
                 OkBtn   OhitaBtn    ------   --------  -----------   ChkBxAv   PeruBtn  |    5 HavioKus                |   RadGrp	   152    160
                 ........'...........'........'.........'.............'.........'....... |                              |   OhitaBtn    98     50     34
              OkBtnOik^  ^PoisLeft   ^RadLeft ^JkUpsChk ^UpDnH.Left  |                   |                              |   PoistaBtn   52     46     40
              ´Sis +1 |--> BtnVali.........<--|....<--|                                                                     OkBtn	     6     46     34
        => Annetaan vakiosijoittelu oli ao.komponentti VISIBLE eli ei.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!(Lienee näin 120.6)!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        => Vakioasetukset:  PoistaBtn  ChkBxAv  PeruBtn, joten muut asetetaan PoistaBtn...ChkBx väliin.____             }
PoisKumoaHint := 'Poistaa johto-osan (tai kumoaa JkUps-haaran) ...'; //Oli:  "Poistaa johto-osan (tai JkUps-haaran) ..."
               //'Poistaa (tai kumoaa) johto-osan (tai JkUps-haaran) ...  //Oli:  "Poistaa johto-osan (tai JkUps-haaran) ..."
with SyottoFrm  do begin            //,,120.5n/6: RadGrp.Items´it nyt TeeSyoFrm´ssa kattavasti
   AlpHint := ChkBxAv.Hint;         //<1412:  Syokut=2´lle muuttuu, tämä palautetaan.
   RadGrp.Width := 160;             //<Tutkittu ObjIns´ssa.
  {if IsDebuggerPresent  then
     PutsEdellstJataNrot;}
  // Caption := 'SyoKut: ' +Ints(SyoKut);// +'  ' +                //<+12.0.0  -120.5o
      OkBtn.Visible :=     true;                                   //<,,LOPUSSA vielä loppuviilaukset:  Tasataan alapanelin Btn, RadGrp ja ups´in sijoituksia.
      PoistaBtn.Visible :=  false;
      OhitaBtn.Visible :=   false;
      RadGrp.Visible :=     false;  //<Tämä kopioidaan jälempna.
      JkUpsLbl.Visible :=   false;
      UpDwnH.Visible :=     false;
      UpDwnW.Visible :=     false;
      ChkBxAv.Visible :=    false;
      ChkBxAvLbl.Visible := false;
      PeruBtn.Visible :=   true;

      PeruBtn.Left := SyottoFrm.ClientWidth -5 -PeruBtn.Width;        //,Yleispätevä sijoitus, muut sijoitetaan tästä lähtien vasemmalle.
      ChkBxAv.Left :=  PeruBtn.Left -50;//2 -ChkBxAvLbl.Width;        //<,+1214. Oli: ChkBxAv.Left :=  PeruBtn.Left -6 -ChkBxAv.Width;
      ChkBxAvLbl.Left := ChkBxAv.Left -10;
    //UpDwnH.Left := ChkBxAv.Left -6 -UpDwnH.Width -UpDwnW.Width;     //<-1412.
      UpDwnH.Left := ChkBxAvLbl.Left -6 -UpDwnH.Width -UpDwnW.Width;  //<Tämäkin yleispätevä sij. silloin kun on esillä.
      UpDwnW.Left := UpDwnH.Left +UpDwnH.Width;                       //<Tämä aina yhdessä UpDwnH´n kanssa.
      JkUpsLbl.Left := UpDwnH.Left -6 -JkUpsLbl.Width;
      JkUpsChk.Left := JkUpsLbl.Left +2;                              //<Lbl on 3+3 leveämpi kuin Chk.
      OkBtnOik := OkBtn.Left +OkBtn.Width +1;                         //<Eli sisältää +1 ohi joka siis on lähin seur. kompon. mahd. alkupiste.
      BtnVali := {UpDwnH}JkUpsLbl.Left -OkBtnOik;                     //<Paikall. Globaali
         b := OkBtnOik +10 +PoistaBtn.Width +10 +RadGrp.Width +8 +JkUpsLbl.Width +8 +ChkBxAvLbl.Width +8 +PeruBtn.Width +5;
         //Caption := Caption +' b:' +Ints(b) +' w:' +Ints(Width);  //-120.5o
         if b > SyottoFrm.Width  then
            SyottoFrm.Width := b; //SyottoFrm.Width +(b -SyottoFrm.Width);  //<''+120.6 fKESKEN: FRMn leveystarkistus}
         //Caption := Caption +' bW:' +Ints(Width); //-120.5o
                                                                   //,,OkBtn +PeruBtn jo TR.###############################################################
      CASE SyoKut of                                               //,b =Komponenttien väliin jäävä tyhjä.
      6 :begin                                   //<6: LisäLIITTYMÄ  <,Kaikki kompont näkyvissä (paitsi OhitaBtn)<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        {if edv.YLE.SorceCount.arvoInt >=Edi     //'Tähän ekax, tämän jälkeen SIIRTYY/OHJAUTUU 2´eeen (EdvJ).##############################################
            then PoistaBtn.Visible := true;}     //'Ei koskaan voi olla TR, vastahan sitä tehdään tässä.
         RadGrp.Visible :=    true;
        {UpDwnH.Visible :=    true;              //<,,-130.3u
         UpDwnW.Visible :=    true;}
         ChkBxAv.Visible :=   true;
         b := Trunc((BtnVali-RadGrp.Width)/2);   //<Puolet välistä mol.puolelle.
         RadGrp.Left := OkBtnOik +b;  end;
      1 :begin                                   //<1: LIITTYMÄ<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
         PoistaBtn.Hint := PoisKumoaHint;        //<Oli:  "Poistaa johto-osan (tai JkUps-haaran) ..."
         ChkBxAv.Visible :=  true;
         JkUpsChk.Visible := false;              //<+1412.
        {UpDwnH.Visible :=   true;
         UpDwnW.Visible :=   true;}
         RadGrp.Visible :=   true;
         BtnVali := JkUpsLbl.Left -RadGrp.Width -PoistaBtn.Width -OkBtnOik;
         b := Trunc(BtnVali/3);
         if b<1  then b := 1;                    //<+120.5n/6

         if edv.YLE.SorceCount.arvoInt>1
            then PoistaBtn.Visible := true                         //<Tarvitaan PoistaBtn vain kun Count>1.
            else PoistaBtn.Visible := false;                       //<+1412.
         PoistaBtn.Left := OkBtnOik +b;
         RadGrp.Left := PoistaBtn.Left +PoistaBtn.Width +b;
         end;
      2 :begin                                   //<2: EdvJ tai SorceJohto (SrcEdka=TR).<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
         ChkBxAv.Visible :=   true;              //'Tähän SIIRTYY/OHJAUTUU 6´sta tai 1´stä, SrcEdka tietää onko Src/EdvJ, Edi=OK molemssa.#################
         PoistaBtn.Hint := PoisKumoaHint;        //<Oli:  "Poistaa johto-osan (tai JkUps-haaran) ..."
         b := Trunc (BtnVali/3);
         if UpsNyt  then JkUpsLbl.Left := OkBtnOik +2*b;
         //if {NOT SrcEdka} b>0  then PoistaBtn.Visible := true;   //<-1412.
//if JkUpsChk_Cap or JkUpsChk_Box or JkUpsChk_Dlg  then ;          //<+1412.
         if UpsNyt  then begin
            if JkUpsChk_Box  then begin                   //1412: Haluttu että JkUpsChk Bx näkyy, tätä varten asetettu EditSyoFrm´ssa.
               if SrcEdka  then b := edv.Sorc[1].Josa.JkUps.ArvoInt   //<,,141.2
                           else b := edv.Edka[Edi].   JkUps.ArvoInt;
               if b>0  then SyottoFrm.JkUpsChk.State := cbChecked     //<Mutta JkUpsChk eioo näkyvissä, joten jää vain piiloon ja arvo jää (cbChecked) voimaan.
                       else SyottoFrm.JkUpsChk.State := cbUnchecked;
               JkUpsLbl.Visible := true;
            end;//if JkUpsChk_Box
            if JkUpsChk_Cap  then PoistaBtn.Visible := true;          //<+1412:  AINA BtnVisible jos halutaan perua (UPSi) edValinta.
         end;//if UpsNyt
       //if edi>1  then PoistaBtn.Visible := true;                    //<+1413:  Ei tullut näkyviin. -1414d.
         if SrcEdka  then n := edv.YLE.SorceCount.ArvoInt    //<,,+1414d
                     else n := edv.YLE.JohtoOsia .ArvoInt;
         if n>1  then PoistaBtn.Visible := true;                      //<+1413:  Ei tullut näkyviin. 1414d: n>1
       //if (edi>=1) and (b>1)  then PoistaBtn.Visible := true;       //<+1414d:  Ei tullut näkyviin 1413.
//if isDebuggerPresent  then {SyottoFrm.aRich.AddText(} Caption := Caption +'  ' +Ints(edi) +' .'; //<Tulee hyvin monta kertaa sama nro.
         end;
      5 :begin                                   //<Häviökust, RadVal ei näy.<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
         OhitaBtn.Visible :=  true;
         PoistaBtn.Visible := false;
         RadGrp.Visible :=    false;
         OhitaBtn.Left := OkBtnOik +30;  end
      else begin//case 7                         //<LisätJohtoOs.<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
         ChkBxAv.Visible := true;
       //JkUpsLbl.Visible :=  true;              //<-1412.
        {UpDwnH.Visible :=  true;
         UpDwnW.Visible :=  true;}
         RadGrp.Visible :=  false;
      end; end;//case                            //,,Loopusijoitukset Btn´lle, RadGrp ja ups´lle (resursiilask.valinta).

      if NOT RadGrp.Visible  //and NOT PoistaBtn.Visible
         then JkUpsLbl.Left := UpDwnH.Left -30;

      If NOT RadGrp.Visible                      //<Eikä väliä  oliko näkyvissä eli ei.
         then PoistaBtn.Left := OkBtnOik +30;
      ChkBxAvLbl.Visible := true;//SyottoFrm.ChkBxAv.Visible;     //<,+1412.
      ChkBxAv.Visible := true;
      JkUpsChk.Visible := JkUpsLbl.Visible;
{       SyoKut:  1=Liitt  2=EdvJ  3=Uh-raj(eiEnää)  5=Häviökust    6=LisätLIITTYMÄ  7=LisätJohto-osa  8=Moott.Itemit    |             Left EroEd    Wdth
          ve:t:  OkBtn   PoistaBtn   RadGrp   --------  UpDnH+UpDnW   ChkBxAv   PeruBtn  |    6 LisätLIITTYMÄ           |   PeruBtn   486? ClintW-x  34
                 OkBtn   PoistaBtn¹  RadGrp   --------  UpDnH+UpDnW   ChkBxAv   PeruBtn  |    1 Liitt         ¹=+10.0.7 |   ChkBxAv	   426    54
                 OkBtn   PoistaBtn   ------   JkUpsChk  UpDnH+UpDnW   ChkBxAv   PeruBtn  |    2 EdvJ  +SorcJ            |   UpDwnH	   367    16 (16+30Yht)
                 OkBtn   PoistaBtn   ------   --------  UpDnH+UpDnW   ChkBxAv   PeruBtn  |    7 LisätJohto              |   JkUpsLbl   336    17 (14 Chk))
                 OkBtn   OhitaBtn    ------   --------  -----------   ChkBxAv   PeruBtn  |    5 HavioKus                |   RadGrp	   152   160
                 ........'...........'..................'.............'.........'....... |                              |   OhitaBtn    98    50     34
              OkBtnOik^  ^PoisLeft   ^RadLeft ^JkUpsChk ^UpDnH.Left  |                   |                              |   PoistaBtn   52    46     40
              ´Sis +1 |--> BtnVali.........<--|....<--|                                                                     OkBtn	     6    46     34
{SyottoFrm.Caption := 'Vali='+Ints(BtnVali) +' b='+Ints(b) +' AvLft='+Ints(SyottoFrm.ChkBxAv.Left) +
                      ' dBtnW='+Ints(OhitaBtn.Width-PoistaBtn.Width);}
end; end;//with, SijBtns 1205f + 1206
//==================================================================================================
//==================================================================================================
procedure setStrGrWidest (VAR StrGrU: TStringGridNola;  aoCol,aoRow,uusiWidth :integer);

   //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   procedure asBx_samaXHW_ComBx1 (VAR BxU :TComboBoxXY);      begin //<,,+4.0.0
      BxU.Left :=   SyottoFrm.ComBx1.Left;          //<ComBx1.Left := PRC OnWidthest :ssa
      BxU.Height := SyottoFrm.ComBx1.Height;
      BxU.Width :=  SyottoFrm.ComBx1.Width;
    //BxU.SelLength := SyottoFrm.ComBx1.SelLength;  //< -3.0.3  Aiheutti "A Win32 API fnc failed".
   end;
   //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   procedure asetaLftWidthsFrm;      CONST Cap=3;   VAR i,BxRight,yp,ap,gw{,ww} :integer;

      //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      function fFrmWidth :integer;      var i,j :integer;      begin
         i := SyottoFrm.StrGr4.Left +SyottoFrm.StrGr4.Width +6;
         if SyoKut IN [1,6]                                                   //<Liittymätiedot
            then j := SyottoFrm.ImgVii.Left +SyottoFrm.ImgVii.Width +15       //< +4.0.0 Pj-liittymän apuruudunLev.
            else j := fYhtBtnLev;
         if i>j  then Result := i
                 else Result := j;   end;
   begin//...............................................
      gw := fGrLineWidth;
      with SyottoFrm  do begin                                                //<StrGr1.Left PRC AsBxSyotFrm :ssa
         StrGr1.Width := fStrGr1Width;
         StrGr2.Left :=  StrGr1.Left +StrGr1.Width +2;
        {ww := StrGr1.Left +StrGr1.Width +StrGr2.Width +StrGr4.Width;         //<,,+1414f. Kasvatetaan ComBx1 =Gr2´kin leviäisi=täyttäisi Frmin.
         if SyottoFrm.Width > ww  then
            ComBx1.Width := SyottoFrm.Width -ww -5;}                          //<''Tulee ikuinen silmukka, kosk Widest herää joka kerta.
         StrGr2.Width := ComBx1.Width +gw;                                    //<gw Ei väliä, ei käytetä muuhun
         ComBx1.Left := StrGr1.Width +2;
         asBx_samaXHW_ComBx1 (ComBx2); //<ComBx1.Left := PRC OnWidthest :ssa. Height,Width := tämän
         asBx_samaXHW_ComBx1 (ComBx3); //PRCn alussa, koska sitä käytetään StrGr.Height -määritykseen
         asBx_samaXHW_ComBx1 (ComBx4);
         asBx_samaXHW_ComBx1 (ComBx5);
         asBx_samaXHW_ComBx1 (ComBx6);
         asBx_samaXHW_ComBx1 (ComBx7);
         asBx_samaXHW_ComBx1 (ComBx8);
         asBx_samaXHW_ComBx1 (ComBx9);
         asBx_samaXHW_ComBx1 (ComBx10);
         asBx_samaXHW_ComBx1 (ComBx11);
         asBx_samaXHW_ComBx1 (ComBx12);
         asBx_samaXHW_ComBx1 (ComBx13);
         asBx_samaXHW_ComBx1 (ComBx14);
         asBx_samaXHW_ComBx1 (ComBx15);

         BxRight := ComBx1.Left +ComBx1.Width;
         if SyottoFrm.OhitaBtn.Visible
         then begin
            StrGr3.Left :=       BxRight;
            DiskontPanel.Left := BxRight;
            LopArvPanel.Left :=  BxRight;               //,AlkuArvo alkaa tämän kohdan jälkeen = "(38.3kW) ######
               i := Y_fPixPitB (SyottoFrm.Canvas, 'Loppuar', LopArvPanel.Font);
            AlkuPhPanel.Left :=  BxRight +i;

            yp := Y_fPixPit (SyottoFrm.Canvas, DiskontPanel.Caption, DiskontPanel.Font);
            ap := Y_fPixPit (SyottoFrm.Canvas, LopArvPanel.Caption,  LopArvPanel.Font);
            if yp>ap  then ap := yp;                      //<Jos yläpanelin (DiskontPanel) tarve isompi

            with StrGr3  do begin
               i := ColWidths[0] +ColWidths[1] +ColWidths[2] +ColWidths[3] +ColWidths[4] +ColCount*gw;
               Width := i;  end;

            if ap-Cap > i
               then ap := ap+Cap                          //<Saa mennä StrGr4 :n reunan yli lähemmäksi RvN:oa
               else ap := i;

            DiskontPanel.Width := ap;
            LopArvPanel.Width :=  ap;
            StrGr4.Left := BxRight +ap;
               i := BxRight + LopArvPanel.Width - AlkuPhPanel.Left;
            AlkuPhPanel.Width := i;
         end//if ..Visible
         else
            StrGr4.Left := BxRight;

         StrGr4.Width := StrGr4.ColWidths[0] +gw;          //<StrGr.Width ja Left oltava ennen fFrmWidth kutsua !
         SyottoFrm.Width := fFrmWidth;                     //SyottoFrm.Caption := fImrkt0 (ap,1);
         SijBtns;                          //Caption := 'BxR='+fImrkt0(BxRight,1) +' 4Lft='+fImrkt0(StrGr4.Left,1);
      end;//with
//Y_Piip;                       //<Tämä viivästyttää piipeillä (500) niin, että Widhestin muokkauksen ehtii nähdä
   end;//asetaLftWidthsFrm;
begin//setStrGrWidest...................................
   StrGrU.ColWidths[aoCol] := uusiWidth;
   asetaLftWidthsFrm;
end;//setStrGrWidest
//==================================================================================================

   procedure TSyottoFrm.StrGr1WidestColInRow(Sender: TObject; ACol, ARow,  newWidth: Integer);    begin
      setStrGrWidest (StrGr1,ACol,ARow,newWidth);  end; //<,,Näitä ei tarttis StrGr1..4 :ssä ollenkaan !!!!!
   procedure TSyottoFrm.StrGr2WidestColInRow(Sender: TObject; ACol, ARow,  newWidth: Integer);    begin
      if ComBx1.Width>newWidth  then                    //<,+1414f: ARVO: -otsikko maalauti vain ARVO:´n osalta.
         newWidth := ComBx1.Width;                      //WBeep([100,100,200,100]);
      setStrGrWidest (StrGr2,ACol,ARow,newWidth);  end; //<,,Näitä ei tarttis StrGr1..4 :ssä ollenkaan !!!!!
   procedure TSyottoFrm.StrGr3WidestColInRow(Sender: TObject; ACol, ARow,  newWidth: Integer);    begin
      setStrGrWidest (StrGr3,ACol,ARow,newWidth);  end;

   procedure TSyottoFrm.StrGr4WidestColInRow(Sender: TObject; ACol, ARow,  newWidth: Integer);   begin
      setStrGrWidest (StrGr4,ACol,ARow,newWidth);  end;
   //===============================================================================================

   procedure asApuruutuW;      VAR b :integer;      begin
      with SyottoFrm  do begin
         StrGrY2.Left :=  StrGrY1.Width +Trunc (0.9 *fHtilaPerRv);      //<fHtila.. määrää ImgMuunt :n leveyden
         ImgMuunt.Left := Trunc (StrGrY1.Width *1.1);                   //+Trunc (fHtilaPerRv/2);
         ImgVii.Left :=   StrGrY2.Left +StrGrY2.Width +fGrLineWidth +5;
         Width := StrGrY2.Width +ImgMuunt.Width +StrGrY2.Width +ImgVii.Width;
               //StrGrY1.Color := clAqua;    //<Kokeilua
         b := StrGrY2.ColWidths[1];//6;// +GridLineWidth;
         CyBx11.Width :=  b;   CyBx11.Width :=  b;   CyBx21.Width :=  b;   CyBx31.Width :=  b;
         CyBx40.Width :=  b;   CyBx51.Width :=  b;   CyBx61.Width :=  b;   CyBx71.Width :=  b;

         b := StrGrY2.ColWidths[4];//6;// +GridLineWidth;
         CyBx12.Width :=  b;   CyBx22.Width :=  b;   CyBx32.Width :=  b;   CyBx52.Width :=  b;
         CyBx62.Width :=  b;   CyBx72.Width :=  b;   CyBx80.Width :=  b;
   end;  end;

procedure TSyottoFrm.StrGrY1WidestColInRow(Sender: TObject; ACol,ARow,newWidth: Integer);      begin
   inherited;
   if PanelYa.Visible  then //< +4.0.4  Estetään Lado_TeeSyoFrm´n Puts_StrGr´n putsauksen tapahtuma.
   with StrGrY1  do begin
      ColWidths[aCol] := newWidth;
      Width := newWidth +fGrLineWidth{GridLineWidth};
      asApuruutuW;  end;
end;

   procedure AsetaCyBxt;      VAR w :integer;
      procedure aseta (sar,riv :integer;  VAR BxU: TComboBoxXY);    VAR i,j,s_pos,s_len :integer;  s :string;  begin
            s := BxU.Text;                            //<,,Talteen, kohta palautetaan, ks. jäljempnä !!!!!!!!!!!
          //s_pos := BxU.SelStart;                    //<-10.0.4
            s_pos := Length (s);                      //<+10.0.4
            s_len := BxU.SelLength;                   //<Tarvitaan, todettu 10.0.4 .
            w := w +s_len;
           {if s_len>0  then
               SyottoFrm.PanelY.Color := clTeal;      //<Ylipitkän sijoitus [1,12] := '0.0006408 / eRs=0.000591' }
         with SyottoFrm.StrGrY2  do begin             //'aiheutti koko StrGrY2:n levähtämisen PvitaYht:ssä 10.0.4
            j := Left;                                //, Sar-1, koska edellisen lev määrää kohdan
            for i := 0 to sar-1  do  j := j +ColWidths[i] +fGrLineWidth{SyottoFrm.StrGrY2.GridLineWidth};
            BxU.Left :=   j;
            BxU.Top :=    Top + riv *fHtilaPerRv;          //,Ei mene pienemmäksi kuin 21, todettu.!!!!!!!!!!!!!!!
            BxU.Height := DefaultRowHeight -fGrLineWidth-2;//GridLineWidth; //< -... jotta avuste heräisi varmemmn
         //¤BxU.Width :=  ColWidths[sar] +6;// +GridLineWidth; //< -4.0.4 Siirretty OnWidest eventiin
         end;//with                                        
         BxU.Text := s;                                    //<Otettiin talteen alussa'' ja nyt sij. takas. Pakko,
         BxU.SelStart := s_pos;                            // muuten OnChangen Text -arvo palautuu takas, TODETTU.
         BxU.SelLength := 0;//s_len; //< 0 =10.0.4         // Esim. (Sk) 250 muutetaan 25, Textiksi palautuisi 250.}
      end;          
   begin//AsetaCyBxt
      with SyottoFrm  do begin
         w := 0;
         aseta (1, 0, CyBx11);    aseta (4, 0, CyBx12);
         aseta (1, 1, CyBx21);    aseta (4, 1, CyBx22);
         aseta (1, 3, CyBx31);    aseta (4, 3, CyBx32);
         aseta (1, 5, CyBx40);
         aseta (1, 6, CyBx51);    aseta (4, 6, CyBx52);
         aseta (1, 7, CyBx61);    aseta (4, 7, CyBx62);
         aseta (1, 8, CyBx71);    aseta (4, 8, CyBx72);
                                  aseta (4,10, CyBx80);
         SijBtns;
      end;
   end;//AsetaCyBxt

procedure TSyottoFrm.StrGrY2WidestColInRow(Sender: TObject; ACol,ARow,newWidth: Integer);
      CONST c='=';   VAR i,b :integer;  s :string;      begin//',,ARow = 0..RowCount-1 ja Fromlla edit. 1..RowCount
   inherited;
// if ARow<>11  then
   if PanelYa.Visible  then //< +4.0.4  Estetään Lado_TeeSyoFrm´n Puts_StrGr´n putsauksen tapahtuma.
   with StrGrY2  do begin //<,,Tehdään '=====..' -merkit riville 11(=12) ColWiths´in leveydeltä JOKAISEEN sarakkeeseen
      StrGrY2.ColWidths[aCol] := newWidth;
      b := 0;
      for i := 0 to FixedCols-1  do
         b := b +ColWidths[i] +fGrLineWidth;//GridLineWidth;
      Width := b;

    //if NOT (ACol IN [3,4]) and (ARow<>11)  then begin //<Col 3+4, Row 11(=12) varattu Cos2 :lle !!!!!!!!!!!!!!!!
      if (ACol<3) and (ARow<>11)  then begin //<Col 3+4, Row 11(=12) varattu Cos2 :lle. Muutos 4.0.0 !!!!!!!!!!!!!
         s := '';
         while Y_fPixPit (SyottoFrm.Canvas, c+s, SyottoFrm.StrGrY2.Font) <= newWidth  do
            s := s +c;
         Cells[ACol,11] := s;      //<BxSij + Lev tarpeen ja StrGrY2 Cellien leveyden muk. Pakko myös tässä, koska
      end;                         // kun eka avaus + suljettu, seur. avaus aiheuttaa viimeisiä eventtejä vasta
      asApuruutuW;                 // ShowModalin jälkeen. Sama kutsu myös LasEdiLy_Gr :n lopussa (=ennen tätä)!!!
   end;
end;//StrGrY2WidestColInRow
//==================================================================================================
function OK_Ly_Bx (Sender :Tobject;  VAR nro,sar,riv :integer) :boolean; //PALAUTTAA SAR,RIV, jonka tutkii Bx:sta.
     procedure prc(no,col,row :integer);   begin
       result := true;
       nro := no;  sar := col;  riv := row;   end;
begin
  result := false;
  with SyottoFrm  do
    if Sender=CyBx11 then prc(11,1,1)  else  if Sender=CyBx12 then prc(12,4,1)  else
    if Sender=CyBx21 then prc(21,1,2)  else  if Sender=CyBx22 then prc(22,4,2)  else
    if Sender=CyBx31 then prc(31,1,4)  else  if Sender=CyBx32 then prc(32,4,4)  else
    if Sender=CyBx40 then prc(40,1,6)  else
    if Sender=CyBx51 then prc(51,1,7)  else  if Sender=CyBx52 then prc(52,4,7)  else
    if Sender=CyBx61 then prc(61,1,8)  else  if Sender=CyBx62 then prc(62,4,8)  else
    if Sender=CyBx71 then prc(71,1,9)  else  if Sender=CyBx72 then prc(72,4,9)  else
                                             if Sender=CyBx80 then prc(80,4,11);
end;//FNC OK_Ly_Bx

procedure ImpedInfoRich;      VAR Rv20,Rvo20,Rn20, Rv,Rvo,Rn, Xv,Xvo,Xn,  yRv,yRvo,yRn, yXv,yXvo,yXn, //<+6.2.0
                                  mm2,pit,{LzmaxSuht, }ar,Z1v,Z3v, Ph,Ih,Pj,cosP :real;
                                  su,tyyp :string;  lkm,Tk,Tuh,mvia :integer;
                                  rec :EdvPalstaType;  boo :boolean;      begin//SyöttöFrmn alalaidan ARich´iin
                                                                               // imped.kompon.tietoja.
if SrcEdka  then rec := edv.Sorc[edi].josa
            else rec := edv.edka[edi];
SyottoFrm.aRich.Lines.Clear;
su := '';                             //<+6.2.19
if (SyoKut IN [2,7]) and (edi>0)  then begin //< 2=Edj  7=J:n lisäys +8.0.0  Edi>0 -ehtoa ehkei tarvittaisi
   tyyp := a_getStrg (21011, rec.tyyppi);
   mm2 :=  a_getReaa (21012, rec.Amm2);
   pit :=  a_getReaa (21013, rec.pituus);
   lkm :=  a_getIntg (21014, rec.lukumaara);
   Tk :=   a_getIntg (21015, rec.Lampotila);
                                  //,resP -kutsu ainoa, joka voi aiheuttaa herjan. Testataan jotta voidaan ohittaa.
   resPok (FALSE,tyyp,mm2, boo);  //<BOO palauttaa tiedon, onko ao.tyypin mm2:lla PE:n resP -arvoa. +6.2.19
   if boo  then begin
      Rv20 :=  res   (tyyp,mm2);
      Rvo20 := resVo (tyyp,mm2);
      Rn20 :=  resP  (tyyp,mm2);
      Xv :=  Xv_ind  (tyyp,mm2);
      Xvo := Xv0_ind (tyyp,mm2);
      Xn :=  Xp_ind  (tyyp,mm2);

      Rv :=  rTkorj (fAlCu (tyyp), Rv20, Tk);
      Rvo := rTkorj (fAlCu (tyyp), Rvo20, Tk);
      Rn :=  rTkorj (fPal (tyyp), resP (tyyp,mm2), Tk);

      yRv :=  Rv  *pit/lkm;
      yRvo := Rvo *pit/lkm;
      yRn :=  Rn  *pit/lkm;

      yXv :=  Xv  *pit/lkm;
      yXvo := Xvo *pit/lkm;
      yXn :=  Xn  *pit/lkm;

      mvia := 4;
      SyottoFrm.aRich.Lines.Clear;
      SyottoFrm.aRich.AddText ('<b>[á]:</b> Rv=' +fMrkviaN (Rv20, mvia,1) +' Rvo=' +fMrkviaN (Rvo20, mvia,1) +
                                ' Rn=' +fMrkviaN (Rn20, mvia,1) +
                                ' Xv=' +fMrkviaN (Xv  , mvia,1) +' Xvo=' +fMrkviaN (Xvo  , mvia,1) +
                                ' Xn=' +fMrkviaN (Xn  , mvia,1) +
                                ' <b>[' +FONT_OMEGA +'/m, 20°C]</b><br>');
             //,,,Ao. johto-osan loppuun. IKS :llä pääsee kätevästi tarkistamaan, onko arvot kuten verkkokuvaajassa.
             //......,,,,,,,Ik1v----1=MinI,   NJkin,  '',0, , , ,   ,  ,  ,...<<<<<<<<<<<<<<<<<<<<<<<<<
        {Z1v := iks (Ik3vFA, Ziks_ (2,edi,0,NJkinFA, '',0,0,0,0, ar,ar,ar,ar)); //<2,i-1=EdLoppuun,0  0=PEker huomioid.
             //......Ik3v..,--------...., NJkin,  '',0,0,0,0,....<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
         Z3v := iks (Ik3vTR, Ziks (3,edi,NJkinFA, '',0,0,0,0, ar,ar,ar,ar)); //<FALSE=EiNj  3=osJohdnLopussa}
             //.......11=Ik1vLoppuun  ,Tim,'',0, , , ,   ,  ,  ,...<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
         Z1v := Ziks_ (11,edi,0,NJkinFA,0, '',0,0,0,0, ar,ar,ar,ar); //<11=Loppuun,..0=PEker huomioid..
             //............,  NJkin,Tim,'',0,0,0,0,....<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
         Z3v := Ziks (31,edi,NJkinFA,0,  '',0,0,0,0, ar,ar,ar,ar); //<31=Ik3v os johdon lopussa
      su := '<b>[' +fImrkt0 (edi,1) +']:</b>' +
            ' Rv=' +fMrkviaN (yRv,  mvia,1) +' Rvo=' +fMrkviaN (yRvo , mvia,1) +
            ' Rn=' +fMrkviaN (yRn,  mvia,1) +
            ' Xv=' +fMrkviaN (yXv,  mvia,1) +' Xvo=' +fMrkviaN (yXvo , mvia,1) +
            ' Xn=' +fMrkviaN (yXn,  mvia,1) +
            ' => Loppuun Z1v=' +fMrkviaN (Z1v, mvia,1) +' Z3v=' +fMrkviaN (Z3v, mvia,1) +
            ' <b>[' +FONT_OMEGA +', L/kpl, ' +fImrkt0 (Tk,1) +'°C].</b>';
      Ph := a_getReaa (21021, rec.Ph);
      cosP := a_getReaa (21022, rec.Cosp);
      if (Ph>0) and (cosP>0)  then begin               //< cosP =+7.0.1
         Ih :=  Ph*1000 / ( Sqrt(3) *fUn *cosP);
         Tuh := a_getIntg (21023, rec.Tuh);
         ar :=  rTkorj (fAlCu (tyyp), Rv20, Tuh);      //<Rv Tuh°C:ssa
         ar :=  ar *pit/lkm;
         Pj :=  3 *ar *Sqr (Ih);                       //<P = UI*3 = RI*I*3 = UI²*3  (*3 = vaihLkm)
         su := su +'  Häviöt <b>Pj=</b>' +fRmrkt0 (Pj, 1,0) +'W';
      end;
   end;//if boo...
   SyottoFrm.aRich.AddText (su);

{  su := '<br>==='+IntToStr (Screen.FormCount-1) +' ';
   for  Lkm := 0 to Screen.FormCount-1 do begin
      su := su +'[' +IntToStr (Lkm) +']'+Screen.Forms[Lkm].Name +' ';
      if Screen.Forms[Lkm].Visible
         then su := su +'+'
         else su := su +'-';
      if Screen.Forms[Lkm].Enabled
         then su := su +'+'
         else su := su +'-';
   end;
   SyottoFrm.aRich.AddText (su);}
end//if ...
end;//ImpedInfoRich

function OKsenderComBx1_11(Sender :Tobject;  VAR nro :integer) :boolean;   //var s :string;
     procedure prc(rivi :integer);   begin                     //###################################
       result := true;                                         //'KÄYTETÄÄN KAIKISSA ComBxssa. EVENT
       nro := rivi;                                            //'#### PALAUTTAA KUTSUVAN RIVIN ####
       {s := s+'OKsendr  box/no  '+fImrkt0(box,1)+'/'+fImrkt0(rivi,1)+LF;  Y_Koe(0,s);  }end;
begin
  result := false;
  with SyottoFrm  do
    if Sender=ComBx1  then prc(1)  else
    if Sender=ComBx2  then prc(2)  else
    if Sender=ComBx3  then prc(3)  else
    if Sender=ComBx4  then prc(4)  else
    if Sender=ComBx5  then prc(5)  else
    if Sender=ComBx6  then prc(6)  else
    if Sender=ComBx7  then prc(7)  else
    if Sender=ComBx8  then prc(8)  else
    if Sender=ComBx9  then prc(9)  else
    if Sender=ComBx10 then prc(10) else
    if Sender=ComBx11 then prc(11) else
    if Sender=ComBx12 then prc(12) else
    if Sender=ComBx13 then prc(13) else
    if Sender=ComBx14 then prc(14) else
    if Sender=ComBx15 then prc(15);
end;//FNC OKsenderComBx1_11
//==================================================================================================
procedure Tal_RuutuTxt;      VAR sar,riv :integer;      begin //10.0.4 Apuruudun alp.textit talletetaan.
   for riv := 0 to SyottoFrm.StrGrY2.RowCount-1  do
   for sar := 0 to SyottoFrm.StrGrY2.ColCount-1  do
      RuuArr[sar,riv] := SyottoFrm.StrGrY2.Cells[sar,riv];
end;
procedure Pal_RuutuTxt;      VAR sar,riv :integer;      begin //10.0.4 Palauttaa apuruudun alp.textit.
   for riv := 0 to SyottoFrm.StrGrY2.RowCount-1  do
   for sar := 0 to SyottoFrm.StrGrY2.ColCount-1  do
      SyottoFrm.StrGrY2.Cells[sar,riv] := RuuArr[sar,riv];
end;
//==================================================================================================
procedure sij_Bx (riv,syoOsa :integer;  VAR BxU :TComboBoxXY);      VAR ss :string;  tmpItems :TStringList;
begin                                          //TEKEE ITEM-LISTAN: 'Oletus;Item[0];Item[1].........
   ss := BxItems(riv,syoOsa);                  //<Tehdään BXITEMS:stä ITEM-lista TmpITEMS ##########
   {####################,,##########################################################################}
   tmpItems := f_Items (ss);
   BxU.Items.Assign(tmpItems);  // KAI 2.12.2000   Oli:  SyottoFrm.Ly_Bx.Items.Assign(tmpItems);  =Ei tartte Clear
   {#################''''''''#######################################################################}
   tmpItems.Free; //<####### VASTA TÄSSÄ SAA TUHOTA. MUUTEN OSOITIN HÄVIÄÄ LIIAN AIKAISIN ##########

 //BxU.Text := BxU.Items.Strings[0];                   //<Sijoittaa pudotusvalikon 1. ve:n Boxiin
   BxU.ItemIndex := 0;                                 //<Sij. pud.valikon 1.ve:n Boxiin + MAALAA ## Fiksumpi
   BxU.DropDownCount := 50;
end;//sij_Bx;
//==================================================================================================
function fCyBxtOK :boolean;      begin            //<,, CyBxtOK +4.0.1
   result := false;                               //,,ArvoOK SIJOITTAA Yvrk[] :oon SAMALLA #########
   if arvoOK (11,syoKut){U1}    then
   if arvoOK (31,syoKut){Ry/Xy} then
   if arvoOK (12,syoKut){Sk}    then
   if arvoOK (32,syoKut){Ik3v}  then
   if arvoOK (14,syoKut){Ry}    then
   if arvoOK (34,syoKut){Xy}    then
   if arvoOK (16,syoKut){Sm}    then
   if arvoOK (17,syoKut){Zk}    then
   if arvoOK (37,syoKut){Pk}    then
   if arvoOK (18,syoKut){U2}    then
   if arvoOK (38,syoKut){L }    then
   if arvoOK (19,syoKut){Rv}    then
   if arvoOK (39,syoKut){Xv}    then
   if arvoOK (41,syoKut){Lv}    then
   result := true;
end;//fCyBxtOK
//==================================================================================================
  (*Näyttää hyvästi Cellien sisällön ja sitä seur.rvlla Bx´ien sisällön jos Bx samassa Cellissä.
   fSs_ summaa sYht:een kaikki seuraavat PRC:en stringit, WR nollaa sen. #######################################*)
   procedure Koe_WrApuruu (ohj :integer;  PosInfo :string);    //< OHJ>0 =Erotusviiva "\\\ DatTim \\\\\\\\\\\\..."
         VAR ChkFileN,sYht :string;   ChkFile :Text;   Pals,RvNo,secE :integer; //<secE =edellisen tulostuksen sec.
             arr :array [1..9] of integer;// =(16,25,15,19,14,13);// = (19,45,61,88,104,120,{varalla=}136,152,169);

      procedure wr (si :string;  riviNro :integer);      VAR sa :string;      begin
         sa := '';                               //<,Jotta alku-/inforiville ei tulisi rivino:a ja se tulostuisi
         if riviNro>0  then                      // ilman marginaalia.
            if riviNro>RvNo                      //<,Estää toisen rivin RvNo:n tulostumasta.
            then begin
               RvNo := riviNro;
               sa := fImrkt0(RvNo,2) +'  ';  end //<Ekalle pastalle ekax RvNo ...
            else sa := '    ';                   //<... tai RvNo:n tilalle tyhjää.

         si := sa +si;       {ChkFileN := Application.ExeName;
                              ChkFileN := ChangeFileExt (ChkFileN,'.');   Delete (ChkFileN, Length (ChkFileN) ,1);
                              ChkFileN := ChkFileN +'-Apur.txt';}
         ChkFileN := 'E:\Projektit\NolaKehi\SRC\Globals\_Ajot\Koeajo-Apuruu.txt';
                                       {DefsFileenZ}DebWr(0, '+®+','AssgnFile 13');
         AssignFile (ChkFile,ChkFileN);
         if NOT fFileExists(ChkFileN)
            then Rewrite (ChkFile)
            else Append (ChkFile);
         WRITELN (ChkFile, si);
         Flush (ChkFile);
         CloseFile (ChkFile);
         sYht := '';   Pals := 0;
      end;

      procedure fSs_ (s :string);    VAR MAX,i :integer;      begin//Tätä kutsuttava jokaiselle palstaMrk-
         Pals := Pals +1;                                          //jonolle, jotta PALS kasvaisi.
         MAX := arr[Pals];                           //<MAX =mrkin järj.no minkä yli palstaleveys ei saa mennä.
         for i := Length (s)+1  to MAX do            //<,Lopputyhjiä vajaaseen kenttäleveyteen.
            s := s +'¨';
         while (Length (s) >MAX)  and
               (s[Length(s)] ='¨')  do               //<Ei oteta "oikeita" arvomerkkejä, vain täytemrkt.
            Delete (sYht,Length (sYht),1);           //<Jos liian pitkä, lyhennetään MAX-mrkiin.
         if sYht<>''  then
            s := '  ' +s;                            //<Jos eioo eka palsta, lisätään ekax palstojen väli, ekalle
         sYht := sYht +s;                            //'palstalle RvNo jos..., ks. PRC wr.
      end;

      procedure Cs (sar,riv :integer);  overload;     VAR s :string;      begin
         s := SyottoFrm.StrGrY2.Cells[sar,riv];
         s := TagVex (s);
       //s := Trim (s);
         fSs_ (s);  end;
      procedure Bs (Bx :TComboBoxXY);      VAR s :string;      begin
         s := 'Bx=' +Bx.Text;
         fSs_ (s);  end;
      procedure Ys (os :integer);      VAR rr :real;  s :string;      begin
         rr := Yvrk[os];
         s := 'Yv[' +Ints(os) +']=' +fRmrkt0 (rr,1,-7);
         fSs_ (s);  end;
      procedure Tyh;
         begin fSs_ ('');  end; //<Tyhjä palsta.

      function fDatTim (vii :integer) :string;      VAR stU,str,sv :string;  i,secU :integer;   begin//PvmAikaleima.
         str := DateTimeToStr (now);           //'VII =viivarivi, ei PvmAikaleimaa (kutsutaan á tul.osien jälkeen.
         i := Length(str);   stU := '';                              //,secE =edellisen tulostuksen sekuntti.
         while (i>0) and (CharInSet(str[i], ['0'..'9']))  do begin            //<stU =uuden aikalaimauksen sekunnit.
            stU := str[i] +stU;   i := i-1;  end;                    //<Luetaan lopusta, lisätään stU:n alkuun.
         if stU[1]='0'  then Delete (stU,1,1);                       //<Poistetaan alun nolla (1 kpl).

         SokI (stU,secU);
         if secU>secE  then                                          //<,SecU uuden minuutin alussa.
            secU := secU +60;

         sv := str;                                             //<,,str=DatTim, tulee VAIN VIKAN TULOST. jälkeen
         if (ohj>0) and (vii>0)         //< OHJ>0 =vikaKerralla.     //, +SA = aikaleimaus loppuviivaMrkien väliin,
         then sv :=                     //' ja kun viivaa halutaan.  //< kun ohj>0 =halut. kaikkien jälkeen "@@@.."
                    '^^@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ' +sv +
                    ' @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
         else if vii>0

         then sv := '¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤' +
                    '¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤'                      //<JOKAISEN TULOST. JÄLKEEN yksink.väliviiva.
         else if secU-secE < 2                                       //<,Jos edTulostKertaan <2 s, ei aikaleimausta.
         then sv := '';                                              //='samalla kirjKerralla vain alkuihin aikaleima
                                                                     //' ja loppuviivaan.
         str := sv;

         secE := secU;
         result := str;
      end;

   begin//Koe_WrApuruu................
(*      with SyottoFrm.StrGrY2  do begin//,,TYH siirtää kirjoituksen seuraavaan palstaan, jos ao. ei ole mjä.
               arr[1] := 16;   arr[2] := 25;   arr[3] := 16;   arr[4] := 11;   arr[5] := 19;   arr[6] := 13;
               arr[7] := 13;   arr[8] := 13;;  arr[9] := 13;  //7,8,9=varalla
               Pals := 0;   RvNo := 0;                        //<RvNo := 0 jotta eka WR:n vrtlu RvNo<riviNro.
               wr (PosInfo +'  ' +fDatTim(0){EiViivaa}, 0);   { ,Bx oli ,,,,,,,,,,,,,,,,,,,,,,,sijoitettu Celliin
         0,x=Symbol  Bx t. allaOvaCell[1,x]  Yvrk[]    3,x=,Sybol  Bx t. allaOvaCell[1,x]  Yvrk[]    KirjRiviNollaa.}
         Cs(0,0 );   Cs(1,0 );{U1}           Tyh;      Cs(3,0 );   Cs(4,0 );{R/X}                    wr (sYht,1);
           Tyh;      Bs(SyottoFrm.CyBx11);   Ys(11);   Tyh;        Bs(SyottoFrm.CyBx12);   Ys(31);   wr (sYht,1);
         Cs(0,1 );   Cs(1,1 );{Sk}           Tyh;      Cs(3,1 );   Cs(4,1 );{Ik3v}                   wr (sYht,2);
           Tyh;      Bs(SyottoFrm.CyBx21);   Ys(12);   Tyh;        Bs(SyottoFrm.CyBx22);   Ys(32);   wr (sYht,2);

         Cs(0,3 );   Cs(1,3 );{Ry}           Tyh;      Cs(3,3 );   Cs(4,3 );{Xy}                     wr (sYht,3);
           Tyh;      Bs(SyottoFrm.CyBx31);   Ys(14);   Tyh;        Bs(SyottoFrm.CyBx32);   Ys(34);   wr (sYht,3);
         Cs(0,4 );   Cs(1,4 );{Ry` Ei Bx´ia} Ys(15);   Cs(3,4 );   Cs(4,4 );{Xy` Ei Bx´ia} Ys(35);   wr (sYht,4);
         Cs(0,5 );   Cs(1,5 );{Sm}           Tyh;      Cs(4,5 );                                     wr (sYht,5);
           Tyh;      Bs(SyottoFrm.CyBx40);   Ys(16);                 {<Bx vain vas:lla}              wr (sYht,5);
         Cs(0,6 );   Cs(1,6 );{Zk%}          Tyh;      Cs(3,6 );   Cs(4,6 );{Pk}                     wr (sYht,6);
           Tyh;      Bs(SyottoFrm.CyBx51);   Ys(17);   Tyh;        Bs(SyottoFrm.CyBx52);   Ys(37);   wr (sYht,6);
         Cs(0,7 );   Cs(1,7 );{U2}           Tyh;      Cs(3,7 );   Cs(4,7 );{L[km]}                  wr (sYht,7);
           Tyh;      Bs(SyottoFrm.CyBx61);   Ys(18);   Tyh;        Bs(SyottoFrm.CyBx62);   Ys(38);   wr (sYht,7);
         Cs(0,8 );   Cs(1,8 );{Rv}           Tyh;      Cs(3,8 );   Cs(4,8 );{Xv}                     wr (sYht,8);
           Tyh;      Bs(SyottoFrm.CyBx71);   Ys(19);   Tyh;        Bs(SyottoFrm.CyBx72);   Ys(39);   wr (sYht,8);
                                                                     {,Bx vain oikealla (CyBx80)}
         Cs(0,10);   Cs(1,10);{Hz}           Tyh;      Cs(3,10);   Cs(4,10);{Lv}                     wr (sYht,10);
           Tyh;      Tyh;                    Tyh;      Tyh;        Bs(SyottoFrm.CyBx80);   Ys(41);   wr (sYht,10);
         Cs(0,11);   Cs(1,11);{===}          Tyh;      Cs(3,11);   Cs(4,11);{Cos}          Ys(42);   wr (sYht,11);
         Cs(0,12);   Cs(1,12);{Ry}           Ys(23);   Cs(3,12);   Cs(4,12);{Xy}           Ys(43);   wr (sYht,12);
         Cs(0,13);   Cs(1,13);{Sk}           Ys(24);   Cs(3,13);   Cs(4,13);{Ik3v}         Ys(44);   wr (sYht,13);
         wr(fDatTim(1){ViivaRv},0{=EiRvNoa});  wr('',0){Vikalle rvlle LF};   end; *)
   end;//Koe_WrApuruu
//==================================================================================================
//##################################################################################################}//,,Tänne 6.0.4 FNCn fRsXsApur_.. takia
              //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,PERUSSUUREET,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
              //,Tätä kutsut. myös, jos U1 muuttuu (=Sk säilyy, muuttuvat: Ik3v, Ry,Xy(R,X hoid. omilla kutsuilla)
     function fYvrk(os :integer) :real;     begin//Yvrk:n arvot Debuggaukseen saa PvitaYHT:n lopun IF lauseesta.
        if IsDebuggerPresent  then               //Kikka 2: Avaa 2. ikkuna: Wiev / Nev Edit Window, johon em. IF..
        if Yvrk[os]<0  {and (os<>38)  }then      //< [38]:ssa (=L[km]) on oletuksena 0.
           InfoDlg ('Yvrk[' +Ints(os) +'] <0, po. >=0, sijoitus puuttuu.', mtCustom, 'OK','','','',  '','','','');
        result := Abs(Yvrk[os]);                 //Yvrk:n arvot Debuggaukseen saa PvitaYHT:n lopun IF lauseesta.
     end;        

{kA} function fSk_Ik1 :real;      VAR ar :real;      begin
                                  ar := fYvrk(12){Sk[MVA]}/(fYvrk(11){U1[kV]}*Sqrt(3)); //<Ik[kA]=Sk/(U*V¨3)
                                  result := ar;  end;
{MVA}function fIk_Sk1 :real;      VAR ar :real;      begin
                                  ar := fYvrk(32){Ik3v[kA]}*fYvrk(11){U1[kV]}*Sqrt(3); //<Sk[MVA]=Ik3v*U*V¨3
                                  result := ar;  end;
              //''''''''''''''''''''''''''''''Siirretty LasEdiLy_Gr :sta 10.0.4'''''''''''''''''''''''''''''''''''
    function fSk_Z1 :real;    VAR ar :real;      begin                                            //,-10.0.4
                            //ar := Sqr (fYvrk(11)){U1[kV]} / fYvrk(12){Sk[MVA]}; //<1000²/1000000 =1. < Z=U²/Sk
                              ar := fYvrk(12){Sk[MVA]} /          //< 1000000 /                   //<,+10.0.4
                                    (3*Sqr(fYvrk(32){Ik3v[kA]})); //<  1000² =1.                    < Z=Sk/(3*Ik²).
                              result := ar;   end;
    function fRpX_Cos :real;  VAR RpX,ar :real;    begin  RpX := fYvrk(31){R/X};
                             {ar := Sqrt (  1 / (1 +1/Sqr(RpX)) );   //Cos = V¨[ 1 / (1 +1/RpX²) ]          +4.0.1
                              if ar>0  then}                                                    //',Ei eroja.
                                 ar := cosi (arcTang (1/RpX));                                  //<'10.0.4
                              result := ar;                                          end;
    function fSk_R1 :real;    VAR r1,r2 :real;    begin
                              if MuuLsk=1  then
                                 fIk_Sk1;                       //<Laskettava ekax Sk koska sitä tarvitaan +10.0.4
                              r1 := fSk_Z1{Z};
                              r2 := fRpX_Cos;
                              r2{R} := r1{Z} *r2;
                              result := r2;                                          end;//< R=Z*Cos
    function fSk_X1 :real;    VAR r1,r2 :real;      begin
                              if MuuLsk=1  then
                                 fIk_Sk1;                       //<Laskettava ekax Sk koska sitä tarvitaan +10.0.4
                              r1 := fSk_Z1{Z};
                              r2 := fSk_R1{Ry};
                              if r1>r2
                                 then r2 := Sqrt (Sqr(r1) - Sqr(r2){Ry})             //< X=V¨(Z²-R²)
                                 else r2 := r1;
                              result := r2;                                          end;
    function f_R1_2 :real;    VAR ar :real;      begin //Sk:sta R1 toisiopuolelle redusoituna.
                              if MuuLsk=1  then
                                 fIk_Sk1;                       //<Laskettava ekax Sk koska sitä tarvitaan +10.0.4
                              ar := fSk_R1{Ry};
                              if MuuLsk<>1  then                //<Kun MuuLsk=1, ei ole muuntajaa +10.0.4
                                 ar := ar * Sqr (fYvrk(18){U2} / fYvrk(11){U1});     //< R1_2=R1(U2/U1)²
                              result := ar;   end;
    function f_X1_2 :real;    VAR ar :real;      begin //Sk:sta X1 toisiopuolelle redusoituna.
                              if MuuLsk=1  then
                                 fIk_Sk1;                       //<Laskettava ekax Sk koska sitä tarvitaan +10.0.4
                              ar := fSk_X1{Xy};
                              if MuuLsk<>1  then                //<Kun MuuLsk=1, ei ole muuntajaa +10.0.4
                                 ar := ar * Sqr (fYvrk(18){U2} / fYvrk(11){U1});       //< X1_2=R1(U2/U1)²
                              result := ar;  end;
     procedure AnnaMuunt_PkZk_RmXm (VAR Rm,Rmo, Xm,Xmo :real);                   //Siirretty tähän PRC:ksi 10.0.4
           //Muutettu niin, että kutsupaikassa lasketaan Zk3v tai Zk1v.
           VAR Zm,Smin,Smax,Kmin,Kmax,km :real;      begin
        Rm := fYvrk(37){Pk[kW]}  *Sqr(fYvrk(18){U2[kV]}) /Sqr (fYvrk(16){Sm[MVA]}) /1000;  //< Rm=Pk*U2²/Sm²
                    //' 1000          *      '1000²   /    ('1000²           )='/1000
        Zm := fYvrk(17){Zk%}/100 *Sqr(fYvrk(18){U2[kV]}) /(fYvrk(16){Sm[MVA]});            //< Zm=(Zk%/100)*U2²/Sm
                    //'                      '1000²   /('1000*1000       ) = '1
        if Zm>Rm                                                                           //<Varm.vuoksi +6.0.0
           then Xm := Sqrt (Sqr(Zm) - Sqr(Rm))                                             //< Xm=V¨(Zm²-Rm²)
           else Xm := Rm;      //,Lasket. ABBn ohjeen muk:  Xmo = 1.1 .. 1.2 × Xm (0.003..63 MVA), =>Ik1v = n. 0.95×Ik3v).
                                               //  Sm-Smin     Km-Kmin              Sm-Smin
        Rmo := Rm;                             // --------- = ---------  =>  Km := ---------(Kmax-Kmin) +Kmin
        Smin := 0.03;  Kmin := 1.1;            // Samx-Smin   Kmax-Kmin            Smax-Smin
        Smax := 63;    Kmax := 1.2;
        km := ((fYvrk(16){Sm[MVA]} -Smin)*(Kmax-Kmin) / (Smax-Smin)) +Kmin; //<' Km × Xm => Xmo  =1.1 .. 1.2 ×Xm.
        Xmo := km*Xm;                          //Oli:  Xmo = 2*Xm + Xm;  (=2Xm + Xmo}
                                               //Oli:  Rmo = 2*Rm + Rm;  (=2Rm + Rmo}
                        //Zm := Sqrt (Sqr(Rm) + Sqr(Xm));        //< Xm=V¨(Rm²+Xm²)
       {Rm := 0;  Rmo := 0;  Xm := 0;  Xmo := 0; //<Koe, poista. Saa Sk2:n samaksi kuin Sk ja Ik3v2 = Ik3v*U1/U2,
                                                    (kun L=0), jos ei, on jossain virhe. Koklattu 10.0.4 .}
     end;//AnnaMuunt_PkZk_RmXm
//==================================================================================================
         //,,V_lkm:  1=Ik1v  3=Ik3v käytetty vain koemielessä, ks. PRC PvitaYHT vähän alempana.
function fRsXsApur_1v (rxS :string;  v_lkm :integer) :real;                      //Sorsa siirretty FNC :ksi +6.0.4
            VAR Ry,Rm,Rmo,Rv, Xy,Xm,Xmo,Xv, ar :real;      begin
         (*Ik1v = 3*cU*Uv / Zk1v.   Zk1v = V¨{[2Ry +2Rm+Rmo +3(Rv+Rn)]² + [2Xy +2Xm+Xmo +2Xv+Xvo+3Xn)]²}
                                         = V¨{[2Ry +2Rm+Rmo +6Rv]²      + [2Xy +2Xm+Xmo +6Xv]²}   <,,,AXMK :lla
           Merkitään:               Zk1v = V¨{[     3eRs        ]²      + [     3eXs        ]²}   <',,Rn=Rv, Xn=Xv
                            3eRs² + 3eXs²=    [2Ry +2Rm+Rmo +6Rv]²      + [2Xy +2Xm+Xmo +6Xv]²}
                             eRs² +  eXs²=   {[2Ry +2Rm+Rmo +6Rv]/3}²   +{[2Xy +2Xm+Xmo +6Xv]/3}²
           eli:  eRs = (2Ry +2Rm+Rmo +6Rv) /3 <###################################################################
                 eXs = (2Xy +2Xm+Xmo +6Xv) /3 <###################################################################
           eli: Ik1v = 3*c*Uv/V¨[(3eRs)²  + (3eXs)²]   josta kolmoset supistuvat vex, eli AINA:
                ####################################-----#########################################################
                Ik1v =   c*Uv/V¨[  eRs²   +   eXs² ]     #########################################################
                ####################################-----#######################################################*)
   Ry := f_R1_2;                      Xy := f_X1_2;      //<Yläverkon R,X-kompon U2-puolella =(U2/U1)² huomioitu.
   Rv := fYvrk(19){Rv} *fYvrk(38){L};   Xv := fYvrk(39){Xv} *fYvrk(38){L};

 //ar := Yvrk[16]{Sm}*1000;                              //< Sm oli [MVA]
   Rm := 0;  Rmo := 0;  Xm := 0;  Xmo := 0;              //<+10.0.5
   if MuuLsk<>1  then                                    //<,10.0.4:  MuuLsk=1:llä jää 0:ksi, asetus edellä.
    //asMparam_ (ar,1,75,Rm,Rmo,Xm,Xmo, ai);             //< 1=MuuntTyp  ai =Palautuva muuntTyyppi(=1 ei käyttöä)}
      AnnaMuunt_PkZk_RmXm (Rm,Rmo,Xm,Xmo);               //<asMparam_ oli vain 0.016 .. 3.15 MVA:lle, nyt ..63 MVA

   ar := 0;                                              //<,,Siirretty ylempää tähän 10.0.4 .
   rxS := Trim (rxS);
        if (rxS<>'') and CharInSet(rxS[1], ['r','R'])    //1414d: +(rxS<>'')
   then if V_lkm=1
           then ar := 2*Ry +2*Rm+Rmo +6*Rv               //<,Rv+Rn, AXMK :lla Rn=Rv => 2Rv, ks. kuvaus alussa.!!
           else ar := Ry +Rm +Rv                         //<Ik3v :lle vain myötäkomponentit
   else if (rxS<>'') and CharInSet(rxS[1], ['x','X'])    //1414d: +(rxS<>'')
   then if V_lkm=1
           then ar := 2*Xy +2*Xm+Xmo +6*Xv
           else ar := Xy +Xm +Xv;

   if V_lkm=1  then
      ar := ar/3;
   result := ar;
end;//fRsXsApur_1v

function fIk1vApur_KA :real;      VAR arIk1v,Rs,Xs, uc,Une,Zk1v :real;    begin //<Sorsa siirretty FNC :ksi +6.0.4
   arIk1v := 0;
   Une := fUn/1000;
   if (MuuLsk<>1) and (Yvrk[18]=Une)  OR                       //<[18]=U2              //<,MuuLsk.. +10.0.4
      (MuuLsk =1) and (Yvrk[11]=Une) then begin                //<[11]=U1
      Rs := fRsXsApur_1v ('R',1);             //<,Ks. kuvaus FNC fRsXsApur_1v :ssa.
      Xs := fRsXsApur_1v ('X',1);
      uc := a_getReaa (303, edv.YLE.cU);
      Zk1v := Sqrt ( Sqr(Rs) + Sqr(Xs) );     //< Ks. kuvaus FNC fRsXsApur_1v :ssa.
      arIk1v := uc * fUv / Zk1v /1000;        //< [kA]
   end;
   result := arIk1v;
end;
//==================================================================================================
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,PÄÄSIJOITUSRUTIINI,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
procedure sijCyBx (riv :integer);
   procedure sij (VAR BxU :TComboBoxXY);      begin
      sij_Bx (riv,syoKut,BxU);   end;
begin//,,,,,,,,,,,,,,,,,,,,,,,,,
   with SyottoFrm  do
   case riv of
      11 :sij (CyBx11);{U1}    31 :sij (CyBx12);{Ry/Xy}
      12 :sij (CyBx21);{Sk}    32 :sij (CyBx22);{Ik3v}
      14 :sij (CyBx31);{Ry}    34 :sij (CyBx32);{Xy}
      16 :sij (CyBx40);{Sm}
      17 :sij (CyBx51);{Zk}    37 :sij (CyBx52);{Pk}
      18 :sij (CyBx61);{U2}    38 :sij (CyBx62);{L }
      19 :sij (CyBx71);{Rv}    39 :sij (CyBx72);{Xv}
                               41 :sij (CyBx80);{Lv}
   end;//case
   arvoOKe(riv,syoKut);                           //<SIJOITTAA Yvrk[] :oon SAMALLA ################# 5.0.1 OK=>OKe
end;//sijCyBx;
                        //,Sijoittaa +edit:  Yvrk[aoRv] + CyBx + StrGrY2.Cell[] (jos eivät ole Bx´n alla. +10.0.4 .
procedure sij_YvrCelBx (ra :real; aoRv :integer);     VAR col,row{=Cellit} :integer;      begin
   Yvrk[aoRv] := ra;   sijCyBx (aoRv);                                          //,,Ks. sijCyBx vähän aikaisemmin.
 //if aoRv IN [1..24,31..44]  then begin
   if aoRv IN [15,20..24, 35,36,42..44]  then begin //<20(tyh) ja 22("===") =ei käytössä.
      case aoRv of
         11..24 :begin col := 1;  row := aoRv-11;  end;     //< 11 => 0 .. 24 => 13.
         31..44 :begin col := 4;  row := aoRv-31;  end;     //< 31 => 0 .. 44 => 13.
      else       begin col := 0;  row := 0;        end; end;//case
      SyottoFrm.StrGrY2.Cells[col,row] := fRmrkt0 (ra{Yvrk[aoRv]},1,-7) +'.'; //"." pyykiytyy jos sij. muualta.
   end;
end;
procedure sijYvrk_CyBx (ra :real; aoRv :integer);     begin
// Yvrk[aoRv] := ra;   sijCyBx (aoRv);  end; //<Korvattu ,:llä 10.0.4 .
   sij_YvrCelBx (ra,aoRv);  end;
//==================================================================================================
procedure LasEdiLy_Gr (riv :integer);         //- RIV>=50 -> Päivittää KOKO YLÄVERKKORUUDUN #####################
       VAR osf :integer; //<Sisääntulon/Sij.- //- OnExit:ssa tarkistettu SokR (..Bx.Text) +Sij Yvrk[] ###########
                         // kutsun OSOITE.    //- Yvrk[11..41] =vas Bxit 11..19=rw+11 === oik. Bxit 31..41 =rw+31

   procedure tRwToSar (ySarRv :integer; VAR tRiv,Sar,Riv :integer);      begin
      tRiv := ySarRv;
      if ySarRv>400  then begin Sar := 4;  Riv := ySarRv-400;  end else //Käytössä nyt vain >400 ja >0 .
      if ySarRv>300  then begin Sar := 3;  Riv := ySarRv-300;  end else
      if ySarRv>200  then begin Sar := 2;  Riv := ySarRv-200;  end else
      if ySarRv>100  then begin Sar := 1;  Riv := ySarRv-100;  end else
                          begin Sar := 1;  Riv := ySarRv;  end;
   end;
   procedure sij_Yvrk_Cells (r :real; merkitsevia,Yrv,SarRv :integer); //Uusittu 10.0.4  Oli sijArrYvrk_Cells.
         VAR s :string;  ii,Sar,Riv,Code :integer;      begin
    //anSarRiv (aoRv, Sar,Riv);                 //<Antoi aoRv>30 => Riv:=aoRv-31 Sar:=4  ELSE Riv:=aoRv-11 Sar:=1.
      tRwToSar (SarRv, ii,Sar,Riv);             //< 413 => ii=413  Sar=4  Riv=13,  <100 => Sar=1  Riv=SarRv.
      s := fMrkvia (r,merkitsevia);                         //<StrArvo halutulla tarkkuudella
      Val(s,r,Code);                                        //<Muutetaan R esitystarkkuuden mukaiseksi !!!!!!!!!!
      Yvrk[Yrv] := r;                                       //<Arvo taulukkoon.  "Yvrk :=" löytyy etsi´llä.
      SyottoFrm.StrGrY2.Cells[Sar,Riv] := s;   end;         //<Arvo näkyviin halutulla tarkkuudella
              //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,APUSUUREET,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
        (*  function fCos_Tan1 :real; begin  result := tang (arcCosi (Yvrk[31]{Cos}));        end;
            function fCosX_R1  :real; begin  result := Yvrk[34]{Xy} /fCos_Tan1;               end;
            function fCosR_X1  :real; begin  result := Yvrk[14]{Ry} *fCos_Tan1;               end; *)
        (*  function fRy_Xy1   :real; begin  result := Yvrk[14]{Ry} *fCos_Tan1;               end;//<X=R*tang
            function fXy_Ry1   :real; begin  result := Yvrk[34]{Xy} /fCos_Tan1;               end;//<R=X/tang *)
              //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,SIJOITUSRUTIINIT,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   //,,,,,,,,,Sk_.. = Sk muuttuu => Lasketaan XX+,, SIJOITETAAN Yvrk[Ik1v] :oon + aoBx :iin #####################
   procedure Sk_Ik1;     begin  sijYvrk_CyBx (fSk_Ik1,32);{Ik3v} end; //'''++++++++'''''''''#####################
   procedure Ik_Sk1;     begin  sijYvrk_CyBx (fIk_Sk1,12);{Sk}   end;
   procedure SkRpX_RX1;    VAR r,x :real;   begin
                         r := fSk_R1;    x := fSk_X1;          sijYvrk_CyBx (r,14){Ry};       //< Ry = Z*Cos
                                                               sijYvrk_CyBx (x,34){Xy};  end; //< Xy = V¨(Zy²-Ry²)
   procedure RX_RpXSkIk;   VAR r1,r2,r3 :real;   begin
                         r1 := fYvrk(14){Ry};     r2 := fYvrk(34){Xy};
                         r3 := Sqrt (Sqr(r1)+Sqr(r2));                                        //< Z = V¨(R²+X²)
                         r1 := r1 / r2;{R/X}                    sijYvrk_CyBx (r1,31){R/X};
{1000 [kA] !!!!!}        r1 := fYvrk(11){U1}/(r3*Sqrt(3));      sijYvrk_CyBx (r1,32){Ik3v};    //< Ik=U/(Z*V¨3) [kA]
{1000 [MVA]!!!!!}        r1 := fYvrk(11){U1}*r1{Ik3v} *Sqrt(3); sijYvrk_CyBx (r1,12){Sk};  end;//< Sk=U*Ik*V¨3 [MVA]
              //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,U2-PUOLEN ARVOT,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   procedure Xv_Lv;        VAR r1,r2 :real;   begin
                         r1 := fYvrk(39){Xv};   r2 := r1*1000 / (2*Pii*50);       //< L=X/(2Pii*f)[mH/km]
                                                                sijYvrk_CyBx (r2,41){Lv};   end;
   procedure Lv_Xv;        VAR r1,r2 :real;   begin
                         r1 := fYvrk(41){Lv};   r2 := r1 *2*Pii*50/1000;          //< X=L*2Pii*f/1000)[mH->ohm/km]
                                                                sijYvrk_CyBx (r2,39){Xv};   end;
   function f (r :real) :string;      begin result := fRmrkt0 (r,1,-8);  end; //<Ei muuta tarvetta kuin kutsukohdan debuggaus.
   //=============================================================================================================
   //=============================================================================================================
   procedure PvitaYHT;     VAR R1,X1,Z1, Rm,Xm, R2,X2, Rt,Xt, Ik,{uc,}ar :real;  s,cw :string;
                               {ai,}Sar,Riv,tRw :integer;  ON_eRXs :boolean{+10.0.4};
      procedure sijCell (si :string;  ySarRv :integer);      VAR ii,qSar,qRiv :integer;      begin
         tRwToSar (ySarRv, ii,qSar,qRiv);            //< 413 => ii=413  Sar=4  Riv=14,  <100 => Sar=1  Riv=SarRiv.
         SyottoFrm.StrGrY2.Cells[qSar,qRiv] := si;  end;
      function annCell (ySarRv :integer) :string;      VAR ii,qSar,qRiv :integer;  so :string;      begin
         tRwToSar (ySarRv, ii,qSar,qRiv);            //< 413 => ii=413  Sar=4  Riv=14,  <100 => Sar=1  Riv=SarRiv.
         so := SyottoFrm.StrGrY2.Cells[qSar,qRiv];
         result := so;
      end;

   begin//PvitaYHT.............
Koe_WrApuruu (0,'1 Alku       ');
         //#######################################################################################################
         //############## Tähän tultaessa arvoOKe on jo sijoittanut Yvrk[]:oon OK -arvon, EiKaikkia!##############
         //#######################################################################################################
         //################## fMrkvia (1.00123456, 4)  => 1.001, tai esim. 0.001 =MERKITSEVIA=4 ##################
         //#######################################################################################################
      if MuuLsk=1 //,,Z-,R- ja X-arvoja ei tarvitse/saa muuntaa toisioon koska toisiota eioo. AINA SAMA U1-PORRAS.
      then begin  //<',,+10.0.4  
         Z1 := fYvrk(11){U1[kV} / (Sqrt(3) *fYvrk(32){Ik[kA]}); //<Z1 =Ik:sta laskettu Z.    Z1=U1/(Ik[kA]*V¨3).
         Rt := Z1 *fYvrk(31){cosf};                             //<R1=Z*cosf.
         Xt := Sqrt (Sqr(Z1) -Sqr(Rt));                         //<X1=V¨(Z²-R²)
            Yvrk[14]{Ry} := Rt;   Yvrk[34]{Xy} := Xt;           //<Oisko tarpeen, mahd. jos vaihtuu MuuLs => <>1.
            SyottoFrm.CyBx31.Text := fRmrkt0(Rt,1,7);       //<Bx on unenabloituna. Lienee OK, vaikka vahdettaisiin
            SyottoFrm.CyBx32.Text := fRmrkt0(Xt,1,7);       //'   MuuLs => <>1.
         R2 := fYvrk(19){Rv/km} *fYvrk(38){L[kM]};          //<R2=Rv*L[km]
         X2 := fYvrk(39){Xv/km} *fYvrk(38){L[kM]};          //<X2=Xv*L[km]
         R2 := Rt +R2;
         X2 := Xt +X2;
         Rt := R2;   Xt := X2;                            //<Jotta alempna editointi olisi sam.arvoisia, vrt. Rt..
                                                          //'Tarvitaan kohta Z1 := ...
               //'Rt ja Xt :tä ON SÄILYTTÄVÄ, TARVITAAN EDIT:SSA [1,12] ja [4,12] !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Koe_WrApuruu (0,'2 MuuLs=1/9  '); //<Tulostaa Cellien + Yvrk:n kutsukohdan senhetkiset sisällöt tiedostoon.
      end
      else begin//Norm.laskenta eli MuuLsk<>1.
       //#########################################################################################################
       //Oli:  anSarRiv (15, Sar,Riv); 15-11 => 4 sar=1  tai >30 -31 sar=4.  ,Oli: 35 => 35-11=4, nyt 404 =sar=4 riv=4
       //,tRwToSar (413, tRw,Sar,Riv):  413  => tRw=413 Sar=4  Riv=14,   1..100 esim. 13 => tRw=13  Sar=1  Riv=13.
       //'Nyt:                          413  => 413, 413,4,14 =tRw,Sar,Riv   1..100 esim. 13 => 13, 13,1,13 =tRw,Sar,Riv
       //###############################'''  => '''''''''''''''''''''                 '' => '''''''''''''''''''''.
       //#########################################################################################################
         R1 := f_R1_2;       X1 := f_X1_2; //<Yläverkon R,X-kompon U2-puolella =(U2/U1)² huomioitu. Laskee Sk-
                                           //'perust:sti, jos MuuLsk=1 => laskee Ik:sta, vaikkei silloin kutsutakaan.
                                           //'Korjaa silloin myös että (U2=U1)² => 1 .
         (*Sar=1;  Riv := 4;                   sij_Yvrk_Cells (R1,8, 15,Riv);           //<R1 U2-puolella (Ry`)
         s := SyottoFrm.StrGrY2.Cells[Sar,Riv] +' (' +fVexNS (Yvrk[18]{U2}) +' kV)';    //< Riv<400 => Sar=1.
                                               sijCell (s,Riv);                         //<'Äskeisen jatkoksi U2.*)
       //'Nyt korvattu tRwToSar,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
       //tRwToSar (413, tRw,Sar,Riv):  413  => tRw=413  Sar=4  Riv=14,   1..100 esim. 13 => tRw=13  Sar=1  Riv=13.
       //############################# '''  => ''''''''''''''''''''''                 '' => '''''''''''''''''''''.
         tRwToSar (4, tRw,Sar,Riv){=4,1,4};      sij_Yvrk_Cells (R1,8, 15,tRw);       //<R1 U2-puolella (Ry`)
         s := annCell (tRw);      {Ry`}                                               //<,JustEdRvllä kirjoitetun
         s := s +' (' +fVexNS (fYvrk(18){U2}) +' kV)';                                //  jatkoksi.
                                                 sijCell (s,tRw);                     //<'Äskeisen jatkoksi U2.
         tRwToSar (404, tRw,Sar,Riv){=404,4,4};  sij_Yvrk_Cells (X1,8, 35,tRw);       //<X1 U2-puolella (Xy`)
         s := annCell (tRw);      {Xy`}                                               //<,JustEdRvllä kirjoitetun
         s := s +' (' +fVexNS (fYvrk(18){U2}) +' kV)';                                //  jatkoksi.
                                                sijCell (s,tRw);
       AnnaMuunt_PkZk_RmXm (Rm,ar, Xm,ar);      //<asMparam_ oli vain 0.016 .. 3.15 MVA:lle, nyt ..63 MVA =10.0.4

         R2 := fYvrk(19){Rv} *fYvrk(38){L};   X2 := fYvrk(39){Xv} *fYvrk(38){L};
         Rt := R1 +Rm +R2;                    Xt := X1 +Xm +X2;         //<U1_puolen R,X, MuuntR,X U2:ssa ja Rv,Xv
                                                                        //'Tarvitaan kohta Z1 := ...
               //'Rt ja Xt :tä ON SÄILYTTÄVÄ, TARVITAAN EDIT:SSA [1,12] ja [4,12] !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
(*                                             sij_Yvrk_Cells (Rt{U2:ssa},8, 23,12);    //<,Myötäkomponentit, Ry.
                                               sij_Yvrk_Cells (Xt{U2:ssa},8, 43,412);   //<'Siirra_Y :lle,    Xy.*)
Koe_WrApuruu (0,'3 MuuLs=<>1/9');
      end;//if MuuLsk=1..else ===================,''Äsken laskettu sekä MuuLsk=1  että MuuLsk<>0.=================
      //==========================================================================================================
                                               sij_Yvrk_Cells (Rt{U2:ssa},8, 23,12);    //<,Myötäkomponentit, Ry.
                                               sij_Yvrk_Cells (Xt{U2:ssa},8, 43,412);   //<'Siirra_Y :lle,    Xy.
      ar := 0;                                                                          //,Div.By Zero +6.0.4
      if Xt>0  then begin  ar := Rt/Xt;        sij_Yvrk_Cells (ar,4, 42,411){Ry/Xy=[4,11]};  end;
         if MuuLsk=1  then CW := COLOR_WHITE
                      else CW := '';
                                               SyottoFrm.StrGrY2.Cells[3,11] := CW +'Ry/Xy<right>=';
         s := SyottoFrm.StrGrY2.Cells[4,11];
      if ar>0  then s := s +'  (' +FONT_FII +'=' +fMrkvia (arcTang (1/ar),3) +'°)';     //<,Lisätään kulma-arvo °
                                               SyottoFrm.StrGrY2.Cells[4,11] := CW +s;
//,,................................. Alarivit Grd [11..13] =NäkyvätRivt 12..14 ..................................
      Z1 := Sqrt (Sqr(Rt)+Sqr(Xt)){Zt};
               //,       *1000  / 1000[k] => 1[kA]
      Ik{kA} := fYvrk(18){U2[kV]} / (Z1{Zt}*Sqrt(3));                                //< Ik3v2[kA]=U2/(Zt*V¨3) =OK
      ar{kVA} := Ik{Ik3v2[kA]} *fYvrk(18){U2[kV]}*Sqrt(3) *1000;                     //< Sk2 [kVA]=Ik3v*U2*V¨3 =OK
                                               sij_Yvrk_Cells (ar{Sk2}  ,4, 24,13);  //<,SiirraY :lle ############
                                               sij_Yvrk_Cells (Ik{Ik3v2},4, 44,413);
      ar := fUn/1000;                          //,,Ry,Xy,Ik3v :n jälkeen /eRs,eXs,Ik1v  ,,,,,,,,,,,,+6.0.4,,,,,,,,
      if (SyottoFrm.RadGrp.ItemIndex=1)  and   //<,,PJ +NormLsk = eRS=...  10.0.4  UUSITTU,,,,,,,,,,,,,,,,,,,,,,,,
         ((MuuLsk =1)  and (fYvrk(11){U1[kV]} =ar)  OR                   //<U2:han on unenabloitu, U1 on ainoa U
          (MuuLsk<>1)  and (fYvrk(18){U2[kV]} =ar))                      // ja lasketaan vain Zliittymä + Zjohto.
         then ON_eRXs := true                                            //'Norm.laskenta ja U2=edv.Un
         else ON_eRXs := false;

      tRwToSar (12, tRw,Sar,Riv){=12,1,12};
                     (*Ei saa tässä asetettua uutta ColW, todettu 10.0.4 .
                       ai := Y_fPixPit (SyottoFrm.Canvas, '0.0006408 / eRs=0.000591XXX',  SyottoFrm.StrGrY2.Font);
                       if ai>SyottoFrm.StrGrY2.ColWidths[1]  then SyottoFrm.StrGrY2.ColWidths[1] := ai +2;
                       if ai<-99  then beep;                          //'Kokeilua: tämä leväytti koko StrCrY2:n.
                       sijCell ('0.0006408 / eRs=0.000591XXX', tRw);  //'=Otti viikon selvittää syy.#########*)
      if ON_eRXs  then begin
           ar := fRsXsApur_1v ('R',1);
         s := SyottoFrm.StrGrY2.Cells[1,Riv];                      //'§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
         s := s +'  eRs=' +{fRmrkt0 (ar,1,6);//}fMrkvia (ar,8{merkitseviä});
                                               sijCell (s,tRw);                   //<'Äskeisen jatkoksi eRs.
           ar := fRsXsApur_1v ('X',1);                                            //,10.0.4
         SyottoFrm.StrGrY2.Cells[4,12] := SyottoFrm.StrGrY2.Cells[4,12] +'  eXs=' +{fRmrkt0 (ar,1,6);}fMrkvia (ar,8);
           ar := fIk1vApur_KA;
         SyottoFrm.StrGrY2.Cells[4,13] := SyottoFrm.StrGrY2.Cells[4,13] +'  Ik1v='+fMrkvia (ar,4);
      end;
      
Koe_WrApuruu (1,'4 END. Pitäis olla kaikki valmista!'); //<1 =vikan kutsun loppuun "¤¤¤.." eroviivan.
(*if              //,,Kommenttisulut vex => Yvrk, Cell´ien ja Bx´ien arvot näkyy Debuggerin hiirellä.#############
SyottoFrm.StrGrY2.Cells[1,0 ]{U1} +SyottoFrm.CyBx11.Text +f(Yvrk[11]) +SyottoFrm.StrGrY2.Cells[4,0 ]{R/X}  +SyottoFrm.CyBx12.Text +f(Yvrk[31])+
SyottoFrm.StrGrY2.Cells[1,1 ]{Sk} +SyottoFrm.CyBx21.Text +f(Yvrk[12]) +SyottoFrm.StrGrY2.Cells[4,1 ]{Ik3v} +SyottoFrm.CyBx22.Text +f(Yvrk[32])+
SyottoFrm.StrGrY2.Cells[1,2 ]      {Tyhjä rivi}                       +SyottoFrm.StrGrY2.Cells[4,2 ]                                          +
SyottoFrm.StrGrY2.Cells[1,3 ]{Ry} +SyottoFrm.CyBx31.Text +f(Yvrk[14]) +SyottoFrm.StrGrY2.Cells[4,3 ]{Xy}   +SyottoFrm.CyBx32.Text +f(Yvrk[34])+
SyottoFrm.StrGrY2.Cells[1,4 ]{Ry`}                       +f(Yvrk[15]) +SyottoFrm.StrGrY2.Cells[4,4 ]{Xy`}                         +f(Yvrk[35])+
SyottoFrm.StrGrY2.Cells[1,5 ]{Sm} +SyottoFrm.CyBx40.Text +f(Yvrk[16]) +SyottoFrm.StrGrY2.Cells[4,5 ]                                          +
SyottoFrm.StrGrY2.Cells[1,6 ]{Zk%}+SyottoFrm.CyBx51.Text +f(Yvrk[17]) +SyottoFrm.StrGrY2.Cells[4,6 ]{Pk}   +SyottoFrm.CyBx52.Text +f(Yvrk[37])+
SyottoFrm.StrGrY2.Cells[1,7 ]{U2} +SyottoFrm.CyBx61.Text +f(Yvrk[18]) +SyottoFrm.StrGrY2.Cells[4,7 ]{L[km]}+SyottoFrm.CyBx62.Text +f(Yvrk[38])+
SyottoFrm.StrGrY2.Cells[1,8 ]{Rv} +SyottoFrm.CyBx71.Text +f(Yvrk[19]) +SyottoFrm.StrGrY2.Cells[4,8 ]{Xv}   +SyottoFrm.CyBx72.Text +f(Yvrk[39])+
SyottoFrm.StrGrY2.Cells[1,9 ]      {Tyhjä rivi}                       +SyottoFrm.StrGrY2.Cells[4,9 ]                                          +
SyottoFrm.StrGrY2.Cells[1,10]      {f = 50 Hz}                        +SyottoFrm.StrGrY2.Cells[4,10]{Lv}   +SyottoFrm.CyBx80.Text +f(Yvrk[41])+
SyottoFrm.StrGrY2.Cells[1,11]                                         +SyottoFrm.StrGrY2.Cells[4,11]{Cos}                         +f(Yvrk[42])+
SyottoFrm.StrGrY2.Cells[1,12]{Ry}                        +f(Yvrk[23]) +SyottoFrm.StrGrY2.Cells[4,12]{Xy}                          +f(Yvrk[43])+
SyottoFrm.StrGrY2.Cells[1,13]{Sk}                        +f(Yvrk[24]) +SyottoFrm.StrGrY2.Cells[4,13]{Ik3v}                        +f(Yvrk[44])
=''   then beep;*)
if osf<0  then beep;                                   //<OSF =Kutsukohdan sijainti PRC LasEdiLy_Gr :sta.
   end;//PvitaYHT end.
//==================================================================================================

   procedure ChkAsSiirraBtns;      VAR U1,U2,ar :real;  okY,okA,BxtOK :boolean;      begin
      with SyottoFrm  do begin                        //,,Vois vissiin testata myös Yvrk[riv] = Sama lopputulos!!
         okY := false;  okA := false;
         if NOT (SyottoFrm.RadGrp.ItemIndex IN [2{vv},3{ups}]) //<,,Ei enabloida Siirra..Btn´eita jos VV tai UPS.
      then                                                                                     //'= +8.0.8 §g
         if      SokR (SyottoFrm.CyBx11.Text, U1) //<,,,,,,,,,,,,,,, U1  Näitä kaikkia (eikä fCyBxtOK:ssa) tarvisisi
         then if SokR (SyottoFrm.CyBx12.Text, ar) //< R/X                tarkistaa, koska kaikkia ei tarvita, kun
         then if SokR (SyottoFrm.CyBx21.Text, ar) //< Sk                 MuuLs=1, kaikki tarkistukset tarpeen
         then if SokR (SyottoFrm.CyBx22.Text, ar) //< Ik3v               vain, kun MuuLs=2 tai 66.
         then if SokR (SyottoFrm.CyBx31.Text, ar) //< Ry
         then if SokR (SyottoFrm.CyBx32.Text, ar) //< Xy                 '',,Muutettu .. and .. => then if -listaksi
         then if SokR (SyottoFrm.CyBx40.Text, ar) //< Sm                 jotta olisi debugattavissa. =10.0.4
         then if SokR (SyottoFrm.CyBx51.Text, ar) //< Sk%
         then if SokR (SyottoFrm.CyBx52.Text, ar) //< Pk
         then if SokR (SyottoFrm.CyBx61.Text, U2) //<,,,,,,,,,,,,,,, U2
         then if SokR (SyottoFrm.CyBx62.Text, ar) //< L[km]
         then if SokR (SyottoFrm.CyBx71.Text, ar) //< Rv
         then if SokR (SyottoFrm.CyBx72.Text, ar) //< Xv
         then if SokR (SyottoFrm.CyBx80.Text, ar) //< Lv
            then begin                                             //,U2 oltava min. esim. 6.3 kV
                BxtOK := fCyBxtOK;
                ar := fUn/1000;                                    //<fUn = Edvn Un.  U2>ar =ei edvn Un:nää pienpi.
                if BxtOK and (U2>=0.024) (*and
                   (fYvrk(18){U2} >ar)   and                        //<Nyt sallitaan mikä U tahansa =6.0.0a
                   (fYvrk(11){U1} > (fYvrk(18){U2})) *)              //<..kunhan U2 on pienenpi kuin ylävrkn U1 +10.0.4
                   then okY := true;                               //'20 - >23V 6.0.4    ''Lisäyksiä 10.0.4 .

                if BxtOK and (SyottoFrm.RadGrp.ItemIndex=0) and    //<,,10.0.4 MUUTOS.  Indx=0=SJ,,,,,,,,,,,,,,,,,
                   ((MuuLsk=1) and (U1>ar)  OR (MuuLsk<>1))        //<Ei TR ellei U1>fUn jos MuuLs=1 .
                   then okA := true;                               //'Vois sallia U1=ar, olkoon (jos ajattelis 400V=SJ).
                if BxtOK and (SyottoFrm.RadGrp.ItemIndex=1) and    //,MuuLs=66,2.  Indx=1=PJ,,,,,,,,,,,,,,,,,,,,,
                   ((MuuLsk =1)  and (U1=ar)  OR                   //<U1=ar =edv Un kun MuuLs.
                    (MuuLsk<>1)  and (U2=ar))                      //<U2=ar =edv Un kun EiMuuLs. 
                   then okA := true;                               //<''+10.0.4'''''''''''''''''''''''''''''''''''
            end;

         SiirraY_Btn.Enabled := okY;
         SiirraA_Btn.Enabled := okA;
         SiirBtnYok := okY;                                           //<,+10.0.4
         SiirBtnAok := okA;
   end; end;//ChkAsSiirraBtns
                         (* procedure KoeTulostus;    VAR r1,r2,r3,r4, k,yr,yx :real;   sr,sx :string;      begin
                                  r1 := fSk_Z1;   k := Sqr(Yvrk[18]{U2}/Yvrk[11]{U1});   r2 := r1*k;
                               SyottoFrm.Label1.Caption := '(Z1)' +fRmrkt0 (r1 ,1,11) +' x(U2/U1)²' +fRmrkt0 (k,1,3) +
                                  '=(Z1_2)' +fRmrkt0 (r2,1,11);
                                  sr := 'r1=' +fRmrkt0 (fSk_R1,1,11);   sx := 'x1=' +fRmrkt0 (fSk_X1,1,11);        //<R,X  U1 :ssa
                               SyottoFrm.Label2.Caption := sr +'  ' +sx;
                                  yr := fSk_R1*k;   yx := fSk_X1*k;                                                //<R,X  U2 :ssa
                               sr := 'ry' +fRmrkt0 (yr,1,11);   sx := 'xy'+fRmrkt0 (yx,1,11);
                                  r1 := Yvrk[37]{Pk[kW]}  *Sqr(Yvrk[18]{U2[kV]}) / Sqr (Yvrk[16]{Sm[MVA]}) /1000;  //< Rm=Pk*U2²/Sm²
                                  r2 := Yvrk[17]{Zk%}/100 *Sqr(Yvrk[18]{U2[kV]}) / (Yvrk[16]{Sm[MVA]});            //< Zm=(Zk%/100)*U2²/Sm
                                  r2 := Sqrt (Sqr(r2{Zm}) - Sqr(r1));                                              //< Xm=V¨(Zm²-Rm²)
                                  r3 := Yvrk[19]{Rv} *Yvrk[38]{L};   r4 := Yvrk[39]{Xv} *Yvrk[38]{L};
                               sr := sr +'+rm' +fRmrkt0 (r1,1,7) +'+rv' +fRmrkt0 (r3,1,7);
                               sx := sx +'+xm' +fRmrkt0 (r2,1,7) +'+xv' +fRmrkt0 (r4,1,7);
                                  yr := yr +r1 +r3;   yx := yx +r2 + r4;   r1 := Sqrt (Sqr(yr) + Sqr(yx));         //<yr=R  yx=X  r1=Z
                               sr := sr +'=Rt' +fRmrkt0 (yr,1,8);   sx := sx +'=Xt' +fRmrkt0 (yx,1,8);
                               SyottoFrm.LbYa1.Caption := sr;    SyottoFrm.LbYa2.Caption := sx;
                                                  r2 := Yvrk[18]{U2[kV]}/(r1{Zt}*Sqrt(3));                         //< Ik3v2[kA]=U/(Z*V¨3)
                                                        //'   *1000  / 1000[k] => 1[kA]
                                                  r3 := r2{Ik3v[kA]} *Yvrk[18]{U2[kV]}*Sqrt(3) *1000;              //< Sk2 [kVA]=Ik3v*U*V¨3
                                                        //'*1000[A]  *       '1000[V] / 1000[k] => *1000[kVA]
                               SyottoFrm.PanelYa2.Caption := 'Zt=' +fRmrkt0 (r1,1,8) +
                                  '  Ik=' +fRmrkt0 (r2,1,5) +
                                  '  Sk=' +fRmrkt0 (r3,1,2);
                            end;//KoeTulostus*)

   procedure LasSij_RyXy_fIkCosU;     VAR {Z1,R1,X1,ku,}Ry,Xy  :real;      begin//10.0.4
(*----Z1 := 1000*fYvrk(11){U1} / (Sqrt(3)*1000*fYvrk(32){Ik}); //< Z1 = U / [(Sqrt(3) × Ik3v] = 20000 V / [1.73 × 10000 A] = 11.56 ohm.
      R1 := Z1 *fYvrk(31){Cosfi};                              //< R1 = Z1 *cosf
      X1 := Sqrt (Sqr(Z1)-Sqr(R1));                            //< X1 = V¨(Z1²-R1²) *(U2/U1)²
         ku := Sqr (fYvrk(18){U2} / fYvrk(11){U1});            //< ku = (U2/U1)²    ==Kumpikin kA => 1000* supistuisi.
      if MuuLsk=1                                       //<,,Jää nyt vex koska MuuLs ex 1 vaihtui ex 2:ksi ja se
      then begin                                        //   nyt 1:ksi.
         Ry := R1 *ku;                                  //  Kun Ik=10 kA, U=20 kV, cosfi=0.23 :
         Xy := X1 *ku;  end                             //      Z1=1.155   R1=0.266 X1=1.124   Ry=0.000106 Xy=0.000449
      else begin //MuuLs=2,66                           //<Nyt 1,66 eli AINA. ----*)
         Ry := fYvrk(19){Rv} *fYvrk(38){L};
         Xy := fYvrk(39){Xv} *fYvrk(38){L};
     {end;}
      Yvrk[23]{Ry} := Ry;   Yvrk[43]{Xy} := Xy;         //<Celliin[1,12] ja [4,12]
//      SyottoFrm.StrGrY2.Cells[1,12] := fRmrkt0 (Ry,1,6);    SyottoFrm.StrGrY2.Cells[4,12] := fRmrkt0 (Xy,1,6);
//      SyottoFrm.Caption := fRmrkt0 (Ry,1,6) +'  ' +fRmrkt0 (Xy,1,6);           //<'Kokeilua 2 rviä.
   end;

begin//LasEdiLy_Gr.................................................

      {Apuruudun aukaisussa tapahtuu:  Ks. muutosselityksien alku aivan alussa.}
   if riv>=50  then riv := 99;

            //,,,,,,,,OnChange :ssä jo tarkistettu näiden BxTxtit ja SIJOITETTU Yvrk[] :oon !!!!!!!!
   if (MuuLsk<>1)  and                                              //<+10.0.4 Ettei laske Sk:n perust. jota eioo.
      (riv IN [11,12,31,99]){U1,Sk,Cos} then begin                  //< 99 = Alkueditoinnissa #######
                                        osf := 1;  Sk_Ik1;          //<,,osf = Sisääntulon/Sijoituskutsun OSOITE.
                                                   SkRpX_RX1;   end else //'VAIN DEBUGGAUKSEEN PvitYHT:ssä.
   if riv IN [32         ]{Ik}        then begin
                                        osf := 2;  Ik_Sk1;
                                                   SkRpX_RX1;   end else
   if riv IN [14,34      ]{Ry,Xy}     then begin
                                        osf := 3;  RX_RpXSkIk;  end else
   if riv IN [39         ]{Xv}        then begin
                                        osf := 4;  Xv_Lv;       end else
   if riv IN [41         ]{Lv}        then begin
                                        osf := 5;  Lv_Xv;       end else
                                      begin
                                        osf := 6;  Ik_Sk1;           //<,+10.0.4:  Esim. kun MuuLsk=1 ja riv=99.
                                                   SkRpX_RX1;   end; //<'Kun MuuLsk=1, laskettava Ik:n perust.
 PvitaYHT;
   AsetaCyBxt;                                             //< BxSij + Lev tarpeen ja tilanteen muk.
         // Write_FrmTest ('-@LasEdi');
   ChkAsSiirraBtns;
        {SyottoFrm.CyBx11.SelectAll;                       //<Ei auttanut 10.0.4
         SyottoFrm.CyBx11.SetFocus;                        //< +5.0.1,  takas 10.0.4 mutta ei focusoitunut}
         //KoeTulostus;
end;//LasEdiLy_Gr
//==================================================================================================
procedure TSyottoFrm.SiirraY_BtnClick(Sender: TObject);      VAR r1{,r2,r3} :real;
   function fSeurU2 :real;      VAR edU2,au :real;
      function ifSij (newU :real) :boolean;      begin
         result := false;
         if newU<edU2  then begin
            au := newU;  result := true;  end; end;
   begin//fSeurU2
      edU2 := Yvrk[18]{U2};  au := 0;
      if NOT ifSij (110)   and NOT ifSij (45)  and NOT ifSij (20.5)  and
         NOT ifSij (10.5)  and NOT ifSij (6.3)  then au := 6;
      result := au;   end;
begin//SiirraY_BtnClick
   inherited;
{Tämä sama info aivan PASsin alussa:
StrGrY :n ja CyBx :n arvoyhteydet Col= 1 ja 4:   (RIV = Myös OSOITE Yvrk[riv] :iin @@@@@@@@@@@@@@@@@
       Rv  Cells[COL,ROW] Riv   ComBox   Nimike Yvrk   Cells[COL,ROW]   Riv   ComBox   Nimike Yvrk

       1           1,0     11   CyBx11    U1    [11]           4,0       31   CyBx12    R/X   [31]
       2           1,1     12   CyBx21    Sk    [12]           4,1       32   CyBx22    Ik3v  [32]
       3           1,2     13                                  4,2       33
       4           1,3     14   CyBx31    Ry    [14]           4,3       34   CyBx32    Xy    [34]
       5           1,4     15             Ry`   [15]           4,4       35             Xy`   [35]
       6           1,5     16   CyBx40    Sm    [16]           4,5       36
       7           1,6     17   CyBx51    Zk%   [17]           4,6       37   CyBx52    Pk    [37]
       8           1,7     18   CyBx61    U2    [18]           4,7       38   CyBx62    L[km] [38]
       9           1,8     19   CyBx71    Rv    [19]           4,8       39   CyBx72    Xv    [39]
       10          1,9     20                                  4,9       40
       11          1,10    21                                  4,10      41   CyBx80    Lv    [41]
       12          1,11    22                                  4,11      42             Cos   [42]
       13          1,12    23             Ry    [23]           4,12      43             Xy    [43]
       14          1,13    24             Sk    [24]           4,13      44             Ik3v  [44]
####################################################################################################}
   if fCyBxtOK  then begin                                      //< fCyBxtOK +4.0.1
       (*r1 := Yvrk[23]{Rt};   r2 := Yvrk[43]{Xt};
         r3 := Sqrt (Sqr(r1)+Sqr(r2));             //< Z = V¨(R²+X²)
         r1 := r1 / r3;                            //< Cos = R / Z  *)
         r1 := Yvrk[42];                           //< Cos
      //,,Yvrk[11] := Yvrk[18] ja CyBx11 := Yvrk[11] ...........................,[31] := r1,........
      sijYvrk_CyBx (Yvrk[18]{U2}      , 11{U1});     sijYvrk_CyBx (r1      {Cos2} , 31{Cos1});
      sijYvrk_CyBx (Yvrk[24]/1000{Sk2}, 12{Sk1});    sijYvrk_CyBx (Yvrk[44]{Ik3v2}, 32{Ik3v1});

      sijYvrk_CyBx (Yvrk[23]{Ry2}, 14{Ry1});         sijYvrk_CyBx (Yvrk[43]{Xy2}  , 34{Xy1});
      sijYvrk_CyBx (fSeurU2,       18{U2});     //<'Muut alaosasta jää käyttäjän muutettavaksi !

      LasEdiLy_Gr (50); //<Laskee, sijoittaa CyBx :eihin ja Celleihin uusien mukaiset arvot ########
      SyottoFrm.CyBx11.SetFocus;                    //< +5.0.1
   end;
end;//SiirraY_BtnClick

procedure TSyottoFrm.SiirraA_BtnClick(Sender: TObject);      VAR Ik3v,Ik1v,Rs,Xs,ar :real;      begin
   inherited;
   //ar := fUn/1000;
   if fCyBxtOK  then begin                                      //< fCyBxtOK +4.0.1
   case RadGrp.ItemIndex of                                     //<SorceKind -tieto talletettu kyllä jo RadGrpClic´issä.
      0 :begin              //<,,SJ-liittymä,,,,,,,,,,,,,,,,,,, //,,10.0.4 Uusiksi(MuuLs..)      <,,+6.0.4
             //LasEdiLy_Gr (18{U2});              //<Ei väliä param(RIV):lla, koklattu 18 ja 32 (32=Ik3v) +10.0.4
            ar := Yvrk[23];                       //<,Jotta debuggerista luettavissa +130.2e.
            a_putReaa (301, ar{Yvrk[23]}{Ry},  edv.Sorc[edi].src.yvRs);
            a_putReaa (302, Yvrk[43]{Xy},  edv.Sorc[edi].src.yvXs);
            sij_Bx (3{riv},1,ComBx3);
            sij_Bx (4{riv},1,ComBx4);  end;                                                     //<''+6.0.4
      1 :begin              //<,,PJ-liittymä,,,,,,,,,,,,,,,,,,,
            Ik3v := Yvrk[44];                                  //< Ik3v (U2)
            Ik1v := fIk1vApur_KA;                              //< [kA]  Sorsa siirretty FNC :ksi  6.0.4
            Rs := fRsXsApur_1v ('R',1);                        //<,YHTÄLÖLLE:  Ik1v = 3*c*Uv/V¨[(3Rs)²+(3Xs)²]
            Xs := fRsXsApur_1v ('X',1);                        //<'Ks. FNC fRsXsApur_.. ##########################
            a_putReaa (304, Ik1v, edv.Sorc[edi].src.Iks1v);    //< [kA]
            a_putReaa (305, Ik3v, edv.Sorc[edi].src.Iks3v);    //< [kA]
            a_putReaa (306, Rs,   edv.Sorc[edi].src.pjLiitRs);
            a_putReaa (307, Xs,   edv.Sorc[edi].src.pjLiitXs);
            sij_Bx (1{riv},1,ComBx1);
            sij_Bx (2{riv},1,ComBx2);
            sij_Bx (3{riv},1,ComBx3);  end;
      end;//case
   end;//if fCyBxtOK
end;//SiirraA_BtnClick
//==================================================================================================
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,KUTSU AsKutsu :sta / SyoKut.INC #######################
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,BxArr=SYÖTTÖBOXrivit + GrRvja =SyottoFrm:n asetukset ##
procedure AsBxSyotFrm (GrRvt,ApuOts :integer);      VAR gw,dy,i,j{,k} :integer;  //< dy=rivisiirtymä
                          //'ApuOts +4.0.4                                       //' gw=GrdLineWidth 0 tai >0
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
  function fStrGrHeight (LisaaJosOhitBtn :integer) :integer;      VAR tot,H :integer;    begin
     tot := GrRvt;
     if SyottoFrm.OhitaBtn.Visible  then
        tot := tot +LisaaJosOhitBtn;
     H := (tot +1) * fHtilaPerRv;          //< +1 =Otsikkorivi lisäksi. DefRowH asetettu StrGr1 :ssä
     result := H;                          //      ComBx1.Height :n mukaan, ks. alempna ############
  end;
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
  {function eroC (mja :integer) :string;      VAR i :integer;  s :string;      begin
     s := '';
     for i := 1 to mja  do s := s +'=';
     result := s;
   end;}
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
  procedure asStrGr_sama (StrGrV: TStringGridNola;  VAR StrGrU: TStringGridNola);      begin //<,,+3.0.2
   //StrGrU.Align :=            StrGrV.Align;            {< +3.0.2} //< -4.0.4
     StrGrU.Color :=            StrGrV.Color;            {< +3.0.2}
     StrGrU.ColCount :=         StrGrV.ColCount;         {< +3.0.2}
     StrGrU.DefaultRowHeight := StrGrV.DefaultRowHeight; {< +3.0.2  Oli StrGr1}
     StrGrU.Enabled :=          StrGrV.Enabled;          {< +3.0.2}
     StrGrU.FixedColor :=       StrGrV.FixedColor;       {< +3.0.2}
     StrGrU.FixedCols :=        StrGrV.FixedCols;        {< +3.0.2}
     StrGrU.GridLineWidth :=    StrGrV.GridLineWidth;    {< +3.0.2  Oli StrGr1}
     StrGrU.Height :=           StrGrV.Height;
     StrGrU.Options :=          StrgrV.Options;          {< +3.0.2  Oli StrGr1}
     StrGrU.RowCount :=         StrGrV.RowCount;         {< +3.0.2}
     StrGrU.Top :=              StrGrV.Top;              {< +3.0.2}
     StrGrU.Visible :=          StrGrV.Visible;          {< +3.0.2  Oli TRUE} //<?§?§? Otettu vex 303:ssa
  end;
  procedure asStrGr_A_sama (StrGrV: TStringGridNola;  VAR StrGrU: TStringGridNola);      begin
{    asStrGr_sama (StrGrV,StrGrU);
     StrGrU.Height :=  StrGrV.Height;
     StrGrU.Visible := true;
  end;}
     StrGrU.Options :=          SyottoFrm.Strgr1.Options;
     StrGrU.Color :=            SyottoFrm.Strgr1.Color;       //< +4.0.4
     StrGrU.GridLineWidth :=    SyottoFrm.StrGr1.GridLineWidth;
     StrGrU.Top :=              SyottoFrm.StrGr1.Top;
     StrGrU.DefaultRowHeight := SyottoFrm.StrGr1.DefaultRowHeight;
     StrGrU.Height :=           StrGrV.Height;
     StrGrU.RowCount :=         StrGrV.RowCount;              //< +6.0.0
     StrGrU.FixedRows :=        StrGrV.FixedRows;             //< +6.0.0
     StrGrU.Visible :=          true;
  end;
  procedure asStrGr_HavK_sama (StrGrV: TStringGridNola;  VAR StrGrU: TStringGridNola);      begin
     asStrGr_A_sama (StrGrV,StrGrU);
     if SyottoFrm.OhitaBtn.Visible
     then
          StrGrU.Height := fStrGrHeight (2)   //< Str5 ... 9 :ssa 2 kpl selitysriviä ohi Bx -rivien
     else begin
        //SyottoFrm.Visible := false;
          StrGrU.Height := fStrGrHeight (0);
          StrGrU.Width := 0;                  //< Nollaksi, jotta Col 10 :n alkukohta laskettaisiin oikein
          StrGrU.Visible := false;  end;      //< -4.0.4
  end;
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
   procedure KaapPaate (Xkeski,yr :integer);      VAR Xvyk,Yvyk,dx :integer;      begin //<Kaapelipääte
      with SyottoFrm.ImgMuunt  do begin
         dx := Trunc (2*Width/3);
         Xvyk := Xkeski - Trunc (dx/2);
         Yvyk := yr + Trunc (dx/2);
         Canvas.MoveTo (Xvyk,Yvyk);
         Canvas.LineTo (Xvyk+dx,Yvyk);
         Canvas.LineTo (Xvyk+dx -Trunc (dx/2), Yvyk+dx);
         Canvas.LineTo (Xvyk,Yvyk);
   end; end;
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
   procedure SiirtoViiva (yr :integer);      VAR c,dx,x1,dy,y1 :integer;      begin //<Nuoli vas:lle rvn keskelle
      with SyottoFrm.ImgVii  do begin
         c := 0;             //<Marginaali vas.reunaan: TÄLLÄ SÄÄDETÄÄN VAS.ALKUKOHTA:  0 = ImgVii:n VAS.REUNA
         dx := Trunc (Width/2);                       //<Nuolen leveys ½ imagen leveydestä
         dy := yr*fHtilaPerRv +Trunc (fHtilaPerRv/2); //<Nuolen kärki puolivälissä riviä
         y1 := 3;                                     //<Nuolen yhden osan korkeus
         Canvas.MoveTo (dx+c,dy-y1);             //<Tehdään nuolen kärki (<) vas:lle 1.rvn keskelle pystysuunnassa
         Canvas.LineTo (0 +c,dy);
         Canvas.LineTo (dx+c,dy+y1+1);           //< +1 = Hienosäätöä muodon parantamiseksi !!!!
         Canvas.MoveTo (0 +c,dy);                //<Viivan alku nuolen kärjestä alkaen
         x1 := Width-1;                          //<Viiva irti oikeasta reunasta, jotta näkyy
         Canvas.LineTo (x1,dy);
         if yr=0  then begin                     //<,,Alas -viiva vain ekalla kerralla
            SyottoFrm.ImgVii.Canvas.Pen.Style := {psDash;}psDot;
            y1 := SyottoFrm.StrGrY1.FixedRows *fHtilaPerRv +Trunc (fHtilaPerRv/2) +3;
            Canvas.LineTo (x1,y1);
            Canvas.LineTo (0 ,y1);
         end;
         SyottoFrm.ImgVii.Canvas.Pen.Style := psSolid; //<Valmiiksi seur. kertaa varten
   end; end;
  {,,;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;}

   procedure AsetaLaskIkkuna;      VAR i,H,x1,y1,y2 :integer;  moh,ss :string;      begin
// Write_FrmTest// ('-@As');
      with SyottoFrm.StrGrY1  do begin
         asStrGr_sama (SyottoFrm.StrGr1,SyottoFrm.StrGrY1);
         ColCount :=  2;                                  //<ColCount yksi enemmän kuin tarve -> FIXED asti käyt.
         RowCount :=  15;                                 //<,+6.0.0 #######,################,#################,##
         FixedRows := RowCount-1;                         //################'################'#################'##
         Left := 0;                                       //<Muut LEFTit, ks. OnWidest eventti ja jäljempänä.
         Top :=  SyottoFrm.PanelYy.Top +SyottoFrm.PanelYy.Height; //<Nyt turha koska alTop
         i := fHtilaPerRv;
{¤}      H := i*SyottoFrm.StrGrY1.FixedRows;//RowCount;   //<Muuten vikaRow näkyy valkoisena, TODETTU.  H = +4.0.4
         Height := H;                                     //<Height muuttuu:  AsBxSyotFrm kutsuu fStrGrHeight.!!!
         for i := 0 to FixedRows -1  do Cells[0,i] := CLR_GRB +fImrkt0(i+1,2); //<Rivinumerot
      end;//with                                                               //'OnWidest asettaa WIDTHin
                                                                               //,Näkyi pieni valk ala StrGrY1 alap.
      SyottoFrm.PanelY.Height := SyottoFrm.StrGrY1.Top    +H +                    //,-4 oli -2 =10.0.4
                                 SyottoFrm.PanelYa.Height +SyottoFrm.PanelYa2.Height -4;// +5; //<-4.0.4
{¤,,} SyottoFrm.PanelYa2.Top :=  SyottoFrm.PanelY.Height  -SyottoFrm.PanelYa2.Height;          //<+4.0.4

      with SyottoFrm.StrGrY2  do begin
         asStrGr_sama (SyottoFrm.StrGrY1,SyottoFrm.StrGrY2);
         ColCount := 6;                                   //<ColCount yksi enemmän kuin tarve -> FIXED asti käyt.
         FixedCols := ColCount-1;
       //''''WIDTH := OnWidest -eventissä ##########################################################
//    Write_FrmTest//'-@AsECe');
       //,,Sar=0,                       Sar=2,                            Sar=3,
         moh := FONT_OMEGA;
         Cells[0, 0] := CLR_REB+'U1'+FNT_B0+' [kV]<right>=';  Cells[3,0] := 'Ry/Xy<right>=';
         if MuuLsk=1  then ss := ''
                      else ss := 'Sk [MVA]<right>='; //ifc(0,1, 'Sk [MVA]<right>=','');
         SyottoFrm.StrGrY2.Cells[0, 1] := ss;                 Cells[2, 1] := '<center>'+CLR_BLB +' TAI ';  Cells[3,1] := 'Ik3v [kA]<right>=';
         Cells[0, 2] := '<right>  '+CLR_BLB +'TAI ';
         Cells[0, 3] := 'Ry  [' +moh +']<right>=';            Cells[3, 3] := 'Xy  [' +moh +']<right>=';
         Cells[0, 4] := 'Ry` [' +moh +']<right>=';            Cells[3, 4] := 'Xy` [' +moh +']<right>=';
         Cells[0, 5] := 'Sm [MVA]<right>=';
         Cells[0, 6] := 'Zk [%]<right>=';                     Cells[3, 6] := 'Pk [kW]<right>=';
         Cells[0, 7] := CLR_REB+'U2'+FNT_B0+' [kV]<right>=';  Cells[3, 7] := 'L [km]<right>=';
         Cells[0, 8] := 'Rv[' +moh +'/km]<right>=';           Cells[3, 8] := 'Xv [' +moh +'/km]<right>=';
                                                              Cells[3, 9] := '<right>  '+CLR_BLB +'TAI  ';
         Cells[0,10] := COLOR_BLUE +'( f = 50 Hz )';          Cells[3,10] := 'Lv[mH/km]<right>=';
         Cells[0,12] := 'Ry [' +moh +']<right>=';             Cells[3,12] := 'Xy [' +moh +']<right>=';
         Cells[0,13] := 'Sk [kVA]<right>=';                   Cells[3,13] := 'Ik3v [kA]<right>=';
         //,#####################################################################################################
         //,#####################################################################################################
         //,################## Kasvatettu "_Zz":lla, +10.0.4 koska "0.0006408 / eRs= 0.000591" ##################
         //,################## [1,12]:ssa aiheutti koko StrGrY2:n levähtämisen ´hirveästi'. #####################
         Cells[1,3] := '0.001898678XXXXXXXXX Zz';  Cells[4,3] := Cells[1,3]; //<Nämä määrää WidestCol'in, joka sovitettu
         //'###### BxLevTarpeen muk. ennen AsetaCyBxt -kutsua. HUOM:  LasEdiLy_Gr SAATTAA vielä muuttaa !!!!#####
         //'###### Tällä leveydellä mahtuu ComBoxien pud.valikkojen TEKSTIOSATKIN näkyviin.######################
         //'#####################################################################################################
      end;//with

      with SyottoFrm  do begin
         SiirraY_Btn.Left := 2;
         LbYa1.Left := SiirraY_Btn.Left + SiirraY_Btn.Width +2;

         SiirraA_Btn.Left := SiirraY_Btn.Left;
         LbYa2.Left := LbYa1.Left;
      end;
    //SyottoFrm.ImgMuunt.Canvas.Brush.Color := clYellow; //clLtGray;
    //SyottoFrm.ImgMuunt.Canvas.Brush.Style := bsSolid; //< 3.0.2  DEVELOPER1 KOKEILUA
    //DrawMuuntaja(SyottoFrm.ImgMuunt, TRUE, psSolid);
      with SyottoFrm.ImgMuunt  do begin
         Transparent := true;                        //< = Alta näkyy Formin väri, FA = Ei näy läpi
         Top :=    SyottoFrm.StrGrY1.Top;
         Height := SyottoFrm.StrGrY1.Height;
         Width :=  Trunc (fHtilaPerRv *2/3);

         Canvas.Pen.Style := psSolid;          //<,,,Piirretään muuntaja ========================================
         Canvas.Brush.Style := bsClear;              //<Style = Täyttötapa:  bsSolid=PEITTÄÄ, bsClear=EI peitä

         x1 := Trunc (Width/2);                //<,,,Aloitusviiva ekan rivin yr
         KaapPaate (x1,0);                           //<Ylempi kaapelipääte
         Canvas.MoveTo (x1,0);
         y1 := 5*fHtilaPerRv;
         Canvas.LineTo (x1,y1);

         Canvas.Ellipse(0,y1, Width,y1+Width);       //<Muuntajan vas. yk = 5.rivin yr
         y2 := y1 +Trunc (Width*2/3);
         Canvas.Ellipse(0,y2, Width,y2+Width);

         Canvas.MoveTo (x1,y2+Width);                //<,Loppuhäntä viivalle
         Canvas.LineTo (x1, y2 +Width +8*fHtilaPerRv);

         KaapPaate (x1,13*fHtilaPerRv);              //<Alempi kaapelipääte
      end;
      with SyottoFrm.ImgVii  do begin
         Transparent := true;                        //< = Alta näkyy Formin väri, FA = Ei näy läpi
         Top :=    SyottoFrm.StrGrY1.Top;
         Height := SyottoFrm.PanelY.Height;

      //¤SyottoFrm.PanelYa.Width := Left;            //<Alapaneli loppuu, mistä ImgVii alkaa !!!!!!! -4.0.4 NytAutoSize
              {Transparent := false;                 //<,,Kokeilua:  OK
               Canvas.Brush.Color := clWhite;
               Canvas.FillRect(ClientRect);          //<Putsaa vanhan pohjan, ks. Help/Canvas.LineTo}
         SiirtoViiva (0);
         SiirtoViiva (1);
         SiirtoViiva (3);
                    {with SyottoFrm.PanelYy  do begin
                     Label1.Caption := 'YH='+IntToStr(Height) +' }
      end;                                           //,,Text+PudValikko Bx:iin ####################
      sijCyBx (11);   sijCyBx (31);                  //<Tarvittais vain Textit, ei kaikkia Itemeitä
      sijCyBx (12);   sijCyBx (32);                  // OnEnterissä sama
      sijCyBx (14);   sijCyBx (34);
      sijCyBx (16);
      sijCyBx (17);   sijCyBx (37);
      sijCyBx (18);   sijCyBx (38);
      sijCyBx (19);   sijCyBx (39);
                      sijCyBx (41);
      LasEdiLy_Gr (99);                              //<Päivittää Bx:ien ja StrGrY2:n KAIKKI arvot
   end;//AsetaLaskIkkuna
   //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

   procedure OhjLaskIkkuna (avaa :integer);    //VAR k :integer; //avaa = 0 =Vain avausinfo   >0 =Avaa apulask.ikkuna

      procedure AsBoxVisible (boo :boolean);      begin
           SyottoFrm.CyBx11.Visible := boo;    SyottoFrm.CyBx12.Visible := boo;
           SyottoFrm.CyBx21.Visible := boo;    SyottoFrm.CyBx22.Visible := boo;
           SyottoFrm.CyBx31.Visible := boo;    SyottoFrm.CyBx32.Visible := boo;
           SyottoFrm.CyBx40.Visible := boo;
           SyottoFrm.CyBx51.Visible := boo;    SyottoFrm.CyBx52.Visible := boo;
           SyottoFrm.CyBx61.Visible := boo;    SyottoFrm.CyBx62.Visible := boo;
           SyottoFrm.CyBx71.Visible := boo;    SyottoFrm.CyBx72.Visible := boo;
                                               SyottoFrm.CyBx80.Visible := boo;  end;
   begin//OhjLaskIkkuna,,,,,,,,,,,,,,,,,,,,Nämä siirretty 4.0.4 AsBxSyotFrm :sta tähän.###############
      with SyottoFrm  do
      if avaa=0                            //< AVAA=0 =Ei apulaskentaruutua
      then begin
           PanelY.Height := PanelYy.Height +PanelYa2.Height;
           PanelYa2.Top :=  PanelYy.Height;
           Label1.Font.Color := clTeal;
           Label1.Caption := '<  APUlaskentaruutu avautuu kaksoisKLIKKAAMALLA TÄSTÄ  >';
           Label2.Caption := '';

           PanelY.Visible :=   true;
           PanelYa.Visible :=  false;
           MuuBtn.Visible :=   false; //<+10.0.4

          {StrGrY1.Visible :=  false;      //PanelY, PanelYy ja PanelYa2 AINA Visible=TRUE.
           StrGrY2.Visible :=  false;      //<',Ei välttämättömiä, jos kohdistus on oikein = NÄKYVIIN JÄÄVÄT
           ImgMuunt.Visible := false;      //   PANELIT PEITTÄÄ TARPEETTOMAT KOMPONENTIT.
           ImgVii.Visible :=   false;}

           AsBoxVisible (FALSE);
      end
      else begin
           Label1.Font.Color := clBlue;
           Label1.Caption := 'Apulaskentaruutu LIITTYMÄÄ EDELTÄVILLE yläverkon osille';
           Label2.Caption := '< YLEISTIETOA tästä,  tulostus = Ctrl + DblKlik >';       //<,Muutos 8.0.3, 10.0.4
//                           '                                     .';                  //<jotta MuuBtn mahtuisi.
           MuuBtn.Visible :=   true;  //<+10.0.4
           PanelY.Visible :=   true;
           PanelYa.Visible :=  true;

          {StrGrY1.Visible :=  true;
           StrGrY2.Visible :=  true;
           ImgMuunt.Visible := true;
           ImgVii.Visible :=   true;}

           AsBoxVisible (TRUE);
           AsetaLaskIkkuna;
      end;
   end;//OhjLaskIkkuna
//''==============================================================================================================

   function fPixPit (str :String) :Integer; //,,,,,,,,,,,,,,,,,,,Mjonon pituus PIXeleinä,,,,,,,,,,,,,
     begin result := Y_fPixPit (SyottoFrm.Canvas, str, SyottoFrm.ComBx1.Font);  end;//fPixPit;
   {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
   function fMrkPit (str :string) :Integer;      var i,k :integer;  //<Mjonon pituus PIXeleinä<<<<<<<
     begin  k := 0;                                       //,,Kaipaa +1, jotta mja mahtuisi boxiin
       for i := 1 to Length (str)  do k := k +fPixPit(str[i]); //<Lasketaan merkeittäin<<<<<<<<<<<<<<
       k := k+20;  Result := k;  end;                          //<+20=Pudotusvalikon nuolinappi<<<<<<
   {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
   procedure AsSyottoFrm;      VAR h :integer;      begin      //<,,Koko formin korkeus #############
     with SyottoFrm  do begin   //,,,,,,,,,,,,,,,,,,,,,,,SyottoFrm :n mitta-asetukset,,,,,,,,,,,,,,,,,,
     //h := SyottoFrm.StrGr4.Height +SyottoFrm.PanelY.Height;          //< +3.0.2  -4.0.0
       h := SyottoFrm.StrGr4.Height;                                   //< +4.0.0
       if SyottoFrm.PanelY.Visible  then
          h := h +SyottoFrm.PanelY.Height;                             //< +4.0.0
       if aRich.Visible  then                    //<,Vain johto-osien tietojen syötössä näkyvissä
          h := h +aRich.Height;                                        //< +6.2.0
       h := h +Panel1.Height +25{=FrmCaption} +2;// +Pyor (GrRvt *7/12);
       SyottoFrm.Height := h;                    //<Ainoa paikka sijoitukselle:  SyottoFrm.Height :=
      end;//with SyottoFrm
   end;//AsSyottoFrm;
   procedure asVisibParam;      begin
      with SyottoFrm  do
      if StrGr1.Options<>[]  then begin
         StrGr1.Color := clYellow;          //<Muut Grdt asettuvat tämän mukaan.
           {Kokeiluun,,,,,,,,,,,,,,,,,,,,,}
            StrGr1.FixedColor := clLime;
            StrGr2.FixedColor := clFuchsia;
            StrGr3.FixedColor := clGreen;
            StrGr4.FixedColor := clAqua;

            PanelYy.Color :=     clAqua;
            PanelYa.Color :=     clGray;
            PanelYa2.Color :=    clRed;
            PanelYa.BevelOuter := bvRaised; //<Helpompi hahmottaa komponenttien asemia. Korjautuu fGrLineWidth }
      end;
   end;

begin//AsBxSyotFrm==================================================================================
  with SyottoFrm  do begin
    with StrGr1  do begin
//  Write_FrmTest ('-@1');
      //,,######################### TÄRKEITÄ ARVOJA ALUSSA########################################################
      //,,########################################################################################################
      //,,################# DefaultRowHeight + Options + GridLineWidth määrää FNC:n fHtilaPerRv ##################
      StrGr1.Color := clBtnFace;              //<.._sama kutsut kopioivat muihinkin StrGr´ideihin.
      PanelYa.BevelOuter := bvNone;           //<'+4.0.4
      Options := [];
      //,,########################################################################################################
      //,,########################################################################################################
      //,,########################################################################################################
//,,========================Koeajoon hyvä, PRC asVisibParam MUUTTAA loput OPTIONS mukaan.!!! =====================
{Options := [goFixedVertLine,goFixedHorzLine];//<HYVÄ ASEMOINTIIN. goVert/HorzLine näkyy vain jos muitakin kuin Fixed..
                                              //'Options[] ARVOA TUTKITAAN MUISSA FNC:ssakin #####################
asVisibParam;                                 //<Asettaa parametreja KOEKÄUTTÖÖN OPT[] mukaan ####################
      //''########################################################################################################
      //''########################################################################################################
      //''########################################################################################################
//''========================Koeajoon hyvä ========================================================================}
      GridLineWidth := 1;                           //,Nyt vsta voi kutsua FNC fHtilaPerRv #######################
      DefaultRowHeight := 20;                       //< 2=Pienin näkyvä (koska FixedRows ylettyy alimmale rvlle)?
                                                    //'24. Määrää ComBx :n IKKUNAKOON. Jos Opt=[] ->LineWidth=0
    //ComBx1.Width := fMrkPit ('MMJ/MMK*-MMM');     //'Pienin/Delphi:  24=ComBx :lle, 21=DefRwH,  min.ItemHigh=13
      ComBx1.Width := fMrkPit ('0.00189867 (800kVA)XX'); //'Pienin/Delphi:  24=ComBx :lle, 21=DefRwH,  min.ItemHigh=13

      i := fMrkPit ('0.00009800X');                 //<Lasketaan MMJ..mjonon mukaan ##############################
           if i>ComBx1.Width  then ComBx1.Width := i;
      i := fMrkPit ('SVsystAL5SX'); //< +6.0.2   'SVjärjest.X' =-6.0.2
           if i>ComBx1.Width  then ComBx1.Width := i;
                                                    //, -1 -> -3  =4.0.1
      i := fHtilaPerRv -3;                          //<Jotta jäisi reunaa AVUSTn heräämiselle StrGr :n väleissä
      SyottoFrm.ComBx1.Height := i;                 //'-1 vois olla -10, pienentää vain 24 :ään, TODETTU.!!!!!!!!!

      gw := fGrLineWidth;                           //<Kutsu vasta kun StrGr1.GridLineWidth + Options asetettu!!!!
      Left := 0;
      //,,########################################################################################################
      RowCount :=  GrRvt +2;       //<,+6.0.0  +2 jotta FiexedRows voi olla pienempi (kuten pitää) mutta kuitenkin
      FixedRows := RowCount -1;    // Fixed riitettävä kaikille Boxeille. Tässä varm.vuoksi jos ObjInsp:ssa ei ole
                                   //'huomattu muutosten yhteydessä kasvattaa AtrGr1:n rivimääriä, TODETTU.#######
      //''########################################################################################################
      SyottoFrm.StrGr1.Height := fStrGrHeight (0);  //< +4.0.0  Pakko olla ennen AsetaLaskIkkuna kutsuan !!!!!!!!!

      ComBx1.Visible := false;                      //<,,Visible := FA  +4.0.1  =Pois näkyvistä RadClickin muutok-
      ComBx2.Visible := false;                      //   sen ajaksi.##############################################
      ComBx3.Visible := false;                      //   RadClickissä myös, TÄSSÄkin AUTTAA VAIN VÄHÄN.###########
      ComBx4.Visible := false;
      ComBx5.Visible := false;
      ComBx6.Visible := false;
      ComBx7.Visible := false;
      ComBx8.Visible := false;
      ComBx9.Visible := false;
      ComBx10.Visible := false;
      ComBx11.Visible := false;
      ComBx12.Visible := false;
      ComBx13.Visible := false;
      ComBx14.Visible := false;
      ComBx15.Visible := false;
                                                    //BreakPoint
      if SyoKut IN [2,7]                            //<,,+6.2.0  2=Edj  7=J:n lisäys +8.0.0
         then aRich.Visible := true                 //<,Aputeksti-ikkuna auki vain johto-osien tietojen syötössä.
         else aRich.Visible := false;
      if SyoKut=1                                   //< Muutos 3.0.1  =Apulaskentaikkuna liittymädialogiin
         then begin
           //AsetaLaskIkkuna;                  //<##################################################
             OhjLaskIkkuna (ApuOts);           //<' +4.0.4  ''Korvattu tällä, jonne siirretty Visible :=  sijoitukset
             Top := PanelY.Height;   end                //<Vasta AsetaLask'' :n jälkeen =asetti H :n
         else begin
             Top := 0;                         //,########### Apulaskentaikkuna vex ################
            //PanelY.Height := 0;
             PanelY.Visible := false;          //<  +4.0.0  Oli:  PanelY.Height := 0; Muut seuraavat PanelY:tä
         end;

      Cells[0,0] := 'SELITYS:';
    end;//with StrGr1

    //,,,,,,,,,,,,,,,,,,,,#######################################################################################
    if SyottoFrm.OhitaBtn.Visible                      //<,PVITADISKOTSTRGR PAKKO OLLA VASTA TÄSSÄ, muuten eivät
    then pvitaDiskontStrGr                             //< StrGr_ -leveydet pvity, TODETTU ######################
    else  for j := 0 to StrGr3.RowCount-1  do          //<Pakko tyhjätä mahd. ed.Hav.käsittelykerran Cellit, jot
          for i := 0 to StrGr3.ColCount-1  do          // ta tyhjentäminen kutsuisi OnWidest -eventin ja se kut-
              StrGr3.Cells[i,j] := '';                 // suisi edelleen PRC asetaLftWidthsFrm.  TODETTU !!!!!!!!
    //''''''''''''''''''''#######################################################################################

    with StrGr1  do begin       //<,,,,,,,,,Cells[]:iin sijoitukset asettivat ColWidts[]:n,,,,,,,,,,
      Cells[1,0] := 'Raja-arvot:';          //<Oltava ennen Width := ... jotta WidestIn... tarkistaa
      if OhitaBtn.Visible  then Cells[2,0] := ' DIMENSIO:' //<Oltava ennen Width :=... jotta WidestIn... tarkistaa
                           else Cells[2,0] := ' SYMBOLI:';
    end;//with StrGr1

    with StrGr2  do begin    //,,Tässäkin RowCount = FixedRows(12)+1, jotta cursori ei muuttais CELLn
      Cells[0,0] := 'ARVO:'; //,,väriä. 2.rivi (=Col 1) jää ComBox1 :n alle, mutta HEIGHT:lla OK!!!!!!!!
    //StrGr2.Width := ComBx1.Width;                       //<+1414f. Ei vaikuta.
      asStrGr_A_sama (StrGr1,StrGr2);
      DefaultRowHeight := DefaultRowHeight -2*gw;         //<Riittävän matala
      Height := DefaultRowHeight -gw;                     //<Vain yhden rn korkuinen, alle ComBxit
    end;//with StrGr2
    //..............................................................................................
    with StrGr3  do begin
      asStrGr_HavK_sama (StrGr1,StrGr3);
      DefaultRowHeight := StrGr1.DefaultRowHeight;
      if OhitaBtn.Visible  then begin                             //<Vain HavKust -laskennassa.  ,,+6.0.0
//         SyottoFrm.StrGr3.Height := StrGr3.Height +fHtilaPerRv;
         RowCount :=  RowCount  +2;
         FixedRows := FixedRows +2;   end;                        //<'Mahd. ylimääräinen peitetään alapanelilla tms.
    end;//with StrGr3
                                    //,##########################################################################
    with StrGr4  do begin           //,###################### Ei tarvita, TODETTU ###############################
      if OhitaBtn.Visible                                 //<Vain HavKust -laskennassa.
         then asStrGr_HavK_sama (StrGr3,StrGr4)
         else asStrGr_A_sama    (StrGr1,StrGr4);          //<Asettaa Height :in StrGr2 :n korkeaksi = yksi rivi
      Cells[0,0] := 'Rv';                                 //<Oltava ennen Width := ... jotta WidestIn... tarkistaa
      i := GrRvt;
      if OhitaBtn.Visible                                 //<Vain HavKust -laskennassa.
         then i := i+1;                                   //<+6.0.0  Muuten vikarv jää ilman noa
      for i := 1 to i  do Cells[0,i] := fImrkt0(i,2);     //< 4.0.0  GrRvt ilmaisee nyt suoraan StrGr-rivimäärän!!

      Height := StrGr3.Height;                            //''<..korjataan tässä, muuten ei näy kuin otsikko "rv"
    end;//with StrGr4
    //..............................................................................................

    with ComBx1  do begin //<ComBx1.Left := PRC OnWidthest :ssa
       dy := fHtilaPerRv;  i := 0;  //<ComBx :n Height on asetettu alussa +2, DY :hyn lisää vain puolet siitä
       Top := StrGr1.Top  +  dy +i;
       ComBx2.Top :=  Top + 1*dy +i;    ComBx3.Top :=  Top +2*dy +i;    ComBx4.Top :=  Top +3*dy +i;
       ComBx5.Top :=  Top + 4*dy +i;    ComBx6.Top :=  Top +5*dy +i;    ComBx7.Top :=  Top +6*dy +i;
       ComBx8.Top :=  Top + 7*dy +i;    ComBx9.Top :=  Top +8*dy +i;    ComBx10.Top := Top +9*dy +i;
       ComBx11.Top := Top +10*dy +i;    ComBx12.Top := Top +11*dy +i;   ComBx13.Top := Top +12*dy +i;
       ComBx14.Top := Top +13*dy +i;    ComBx15.Top := Top +14*dy +i;
    end;//with ComBx1

    if SyottoFrm.OhitaBtn.Visible
    then with SyottoFrm  do begin
       DiskontPanel.Top :=     StrGr3.Top +fHtilaPerRv;     //StrGr1.DefaultRowHeight; //<Vasta tokalle riville
       DiskontPanel.Height :=  fHtilaPerRv;//StrGr1.DefaultRowHeight;
       DiskontPanel.Visible := true;

       AlkuPhPanel.Top :=     ComBx5.Top +gw;               //<Paneli 5. :n rvn kohdalle. Huomaa ComBx5 ei StrGr3
       AlkuPhPanel.Height :=  DiskontPanel.Height;          //'vaikka eroa lienee yksi pixeli = tämä tarkempi!!!!
       AlkuPhPanel.Visible := true;

       LopArvPanel.Top :=     ComBx6.Top +gw;               //<Paneli 6. :n rvn kohdalle. Huomaa ComBx6 ei StrGr3
       LopArvPanel.Height :=  DiskontPanel.Height;          //'vaikka eroa lienee yksi pixeli = tämä tarkempi!!!!
       LopArvPanel.Visible := true;

       Lask10Panel.Top :=     StrGr3.Top + 12 *fHtilaPerRv;
       Lask11Panel.Top :=     Lask10Panel.Top;                 Lask12Panel.Top :=      Lask10Panel.Top;

       Lask10Panel.Height :=  DiskontPanel.Height;             Lask11Panel.Height :=   DiskontPanel.Height;
       Lask12Panel.Height :=  DiskontPanel.Height;

       Lask20Panel.Top :=     StrGr3.Top + 13 *fHtilaPerRv;    Lask21Panel.Top :=      Lask20Panel.Top;
       Lask22Panel.Top :=     Lask20Panel.Top;

       Lask20Panel.Height :=  DiskontPanel.Height;             Lask21Panel.Height :=  DiskontPanel.Height;
       Lask22Panel.Height :=  DiskontPanel.Height;

       Lask10Panel.Left :=    StrGr1.Left;
       Lask10Panel.Width :=   StrGr1.ColWidths[0] +StrGr1.ColWidths[1] +2*gw;
       Lask11Panel.Left :=    Lask10Panel.Width;               Lask11Panel.Width :=   StrGr1.ColWidths[2];
       Lask12Panel.Left :=    ComBx1.Left -1;                  Lask12Panel.Width :=   ComBx1.Width -gw;

       Lask20Panel.Left :=    Lask10Panel.Left;                Lask20Panel.Width :=   Lask10Panel.Width;
       Lask21Panel.Left :=    Lask11Panel.Left;                Lask21Panel.Width :=   Lask11Panel.Width;
       Lask22Panel.Left :=    Lask12Panel.Left;                Lask22Panel.Width :=   Lask12Panel.Width;

       with Lask10Panel  do begin
          if StrGr1.Options<>[]
             then BevelInner := bvRaised
             else BevelInner := bvNone;
          Lask11Panel.BevelInner := BevelInner;      Lask12Panel.BevelInner := BevelInner;
          Lask20Panel.BevelInner := BevelInner;
          Lask21Panel.BevelInner := BevelInner;      Lask22Panel.BevelInner := BevelInner;
       end;

       Lask10Panel.Visible :=  true;       Lask11Panel.Visible :=  true;       Lask12Panel.Visible :=  true;
       Lask20Panel.Visible :=  true;       Lask21Panel.Visible :=  true;       Lask22Panel.Visible :=  true;
    end
    else begin
       DiskontPanel.Visible := false;      AlkuPhPanel.Visible :=  false;      LopArvPanel.Visible :=  false;
       Lask10Panel.Visible :=  false;      Lask11Panel.Visible :=  false;      Lask12Panel.Visible :=  false;
       Lask20Panel.Visible :=  false;      Lask21Panel.Visible :=  false;      Lask22Panel.Visible :=  false;
    end;
                             //,####################################################################
    AsSyottoFrm;             //<######################## Tämän PRC:n alussa ########################
                             //'####################################################################
    if BxArr[1 ]  then  ComBx1.Visible :=  true; //<,,+4.0.1,  ks. := fa alussa.####################
    if BxArr[2 ]  then  ComBx2.Visible :=  true; //<',,BxArr[] +6.0.3
    if BxArr[3 ]  then  ComBx3.Visible :=  true;
    if BxArr[4 ]  then  ComBx4.Visible :=  true;
    if BxArr[5 ]  then  ComBx5.Visible :=  true;
    if BxArr[6 ]  then  ComBx6.Visible :=  true;
    if BxArr[7 ]  then  ComBx7.Visible :=  true;
    if BxArr[8 ]  then  ComBx8.Visible :=  true;
    if BxArr[9 ]  then  ComBx9.Visible :=  true;
    if BxArr[10]  then  ComBx10.Visible := true;
    if BxArr[11]  then  ComBx11.Visible := true;
    if BxArr[12]  then  ComBx12.Visible := true;
    if BxArr[13]  then  ComBx13.Visible := true;
    if BxArr[14]  then  ComBx14.Visible := true;
    if BxArr[15]  then  ComBx15.Visible := true;

    SyottoFrm.UpDwnH.Position := 10;
    SyottoFrm.UpDwnW.Position := 10;
    if SyottoFrm.RadGrp.Visible  or  SyottoFrm.PoistaBtn.Visible  or (SyoKut IN [6,7]){Lisää +8.0.5}
       then begin {SyottoFrm.UpDwnH.Visible := true;       //<-130.3u
                  SyottoFrm.UpDwnW.Visible := true;   }end
       else begin SyottoFrm.UpDwnH.Visible := false;
                  SyottoFrm.UpDwnW.Visible := false;  end;
  (*if NOT SyottoFrm.RadGrp.Visible and  (SyoKut=2)  then begin //<,,+120.4:  Johto-osatietojen syöttöä.  1412: Siirrtty SijBtns´iin.####################
      {JkUpsChk.Left :=  UpDwnH.Left -JkUpsLbl.Width -10;       //'SyoKut:  1=Liitt  2=EdvJ  3=Uh-raj(eiEnää)  5=Häviökust  6=LisätLIITTYMÄ  7=LisätJohto-osa  8=Moott.Itemit
       JkUpsLbl.Left := JkUpsChk.Left -5;£}
       if UpsNyt                                                //<:= PaaVal =Oli väliversioissa FA jotta vois niitä hioa väliversioidn aikana.
       then begin
          JkUpsChk.Visible := true;                             //<,,+120.4  120.5  130.5 ups?
          if edv.edka[edi].JkUps.ArvoInt>0                      //<Tai:  a_getIntg(99,edv.edka[edi].JkUps) >0
             then JkUpsChk.State := cbChecked
             else JkUpsChk.State := cbUnChecked;  end
       else begin
          JkUpsChk.Visible := false;
          JkUpsLbl.Visible := false;
       end;
    end;*)
//Koe_wrCtrls ('Alust. -1');
//AsBxTabOrders;              //<'Koe.
   {if SyottoFrm.OhitaBtn.Visible  then
       SyottoFrm.CyBx11.SetFocus;       //<'+10.0.4  ei focusoidu.}
end;//with SyottoFrm
   pvtLiitRpX;                //<+3.0.2
// Write_FrmTest ('-@8');
//Koe_wrCtrls ('Alust. -9');  
end;//AsBxSyotFrm;

//===========================================================================YLÄVERKON APULASK.RUUTU,,,,,,,,,,,,,
procedure FocusBak_Ly_ (nro :integer);      begin
   with SyottoFrm  do
   case nro of
       11 :CyBx11.SetFocus;       12 :CyBx12.SetFocus;
       21 :CyBx21.SetFocus;       22 :CyBx22.SetFocus;
       31 :CyBx31.SetFocus;       32 :CyBx32.SetFocus;
       40 :CyBx40.SetFocus;
       51 :CyBx51.SetFocus;       52 :CyBx52.SetFocus;
       61 :CyBx61.SetFocus;       62 :CyBx62.SetFocus;
       71 :CyBx71.SetFocus;       72 :CyBx72.SetFocus;
       80 :CyBx80.SetFocus;  end;//case
end;//FocusBak_Ly_
procedure FocusBak_Ly (Sender :TObject);      VAR nro,sar,riv :integer;      begin
   if OK_Ly_Bx (Sender,nro,sar,riv)  then
     FocusBak_Ly_ (nro);
end;//FocusBak_Ly
//==================================================================================================
procedure TSyottoFrm.Label1MouseMove(Sender: TObject; Shift: TShiftState;  X,Y: Integer);      begin//
  inherited;
   if syoAvOn  then
      avustY (0,0,0);  end;

procedure TSyottoFrm.Label1MouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState;  X,Y: Integer);
begin
  inherited;
   //SyottoFrm.Caption := SyottoFrm.Caption +' Dwn';   //<Tämä eventti tapahtuu ennen Label1DblClick´iä
   if ssCtrl IN Shift
      then Ctrl := true
      else Ctrl := false;
 (*if NOT DblKlikki  then begin                        //,,,,,,,,Ennen 10.0.4,,,,,,,,,,,,,,,,,,,,,,,
     {syoAktv := false;                                //<,,-8.0.3  Tarpeeton
      if Sender=Label2  then
      if syoAvOn  then avustY (0,0,0);
      AvuChkSft (11);  }end;                           //<'''''''Ennen 10.0.4'''''''''''''''''''''''*)

   if Sender=Label2  then begin                        //<,,+10.0.4  Yleisavuste ei workkinut.,,,,,,
      if DblKlikki and Ctrl
      then avustY (0,0,1)                              //< 0,0,1 =CmBx,aRv,(SyoOsa aina 1), tulost=1
      else if DblKlikki
      then AvuChkSft (10)                              //<Vapautetaan avuste.
      else if syoAvOn  then begin
           avustY (0,0,0);
           AvuChkSft (11);  end;                       //<Lukitaan avuste.
   end;
   if Sender=Label1  then                              //<,,+10.0.4  Yleisavuste lukkiutui, tämä korjasi.
   if DblKlikki and syoAvOn  then
      AvuChkSft (10);                                  //<''+10.0.4 ''''''''''''''''''''''''''''''''

   DblKlikki := false;
end;

procedure TSyottoFrm.Label1DblClick(Sender: TObject);      begin
  inherited;
   //SyottoFrm.Caption := SyottoFrm.Caption +' Clk';   //<1. Label1MouseDown   2. vasta tämä (Label1DblClick)eventti.
if RadGrp.ItemIndex IN [0,1]  then begin          //<+8.0.12 =Ei avata apulask.ruutua muille kuin Sj+Pj :lle, jol-
   DblKlikki := true;                             //          loin ei tule epäselvyyttä SyoKut´surivien kanssa.
   eCmBx := 66;                                        //<+8.0.3:  Herättää avusteen vaihtamaan tekstin,
   AvuChkSft (20);                                     //' ks. SyottoAv.PAS:  if (((Rv<>eRv) or (CmBx<>eCmBx)) ...
   if Pos ('avautuu',Label1.Caption) > 0               //<,, +4.0.4
      then begin
           Screen.Cursor := crHourGlass;
           SyottoFrm.Visible := false; //<Estää lomakkeen välähtämisen rakentumisen ajaksi.
           Lado_TeeSyoFrm (1);         //<Avaa   apulaskentaruudun
           SyottoFrm.Visible := true;
           Screen.Cursor := crDefault;  end
    //else Lado_TeeSyoFrm (0);          //<Sulkee apulaskentaruudun
      else if Ctrl and (ChkBxAv.State=cbChecked) and SyottoAvFrm.Visible //<Ctrl + DbkClick = Tulost. tämä avuste.
      then begin                                                         //<'+8.0.3
           avustY (0,0,0);
           SyottoAvFrm.SyoAv.Print('');
           Ctrl := false;   end         //<Apulaskentaikkunan tulostuksen ohjaukseen +8.0.3
      else if Sender=Label1             //<+10.0.4  Jotta DblClickLbl2 vain vapauttaisi avusteen.
      then Lado_TeeSyoFrm (0);          //<Sulkee apulaskentaruudun
end;
end;
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

procedure TSyottoFrm.StrGrY2MouseMove(Sender: TObject; Shift: TShiftState;  X,Y: Integer);      begin//
  inherited;
  {Caption := 'X='+fImrkt0 (X,1) +'  Y='+fImrkt0 (Y,1) +'  Col='+fImrkt0 (fY_Col (X,Y),1) +'  Row='+
              fImrkt0 (fRv_1 (Y),1);}
   if syoAvOn  then
      avustY (0,fLy_Col (X,Y),fRv_1(Y));  end;

procedure TSyottoFrm.StrGrY2MouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
   if NOT DblKlikki  then begin
      syoAktv := false;
      if syoAvOn  then
         avustY (0,fLy_Col (X,Y),fRv_1(Y));
      AvuChkSft (11);  end;
   DblKlikki := false;  end;

procedure TSyottoFrm.StrGrY2DblClick(Sender: TObject);      begin//
  inherited;
   DblKlikki := true;
   AvuChkSft (20);
end;

//,Oli +8.0.3=OnClick => MouseDown +10.0.4 ja koon muutos => PRC AvusteKoko.
procedure TSyottoFrm.UpDwnHMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState;  X,Y: Integer);

   procedure AvFrmYls (YlosAlas :boolean); //Siirretty tähän +10.0.4=MouseDown. UpDn.. Sisään 11.0.1
         CONST dyI=80;  dyM=8;  minH=150;      VAR dy :integer;      begin
      if ssCtrl IN Shift
         then dy := dyM
         else dy := dyI;
      with SyottoAvFrm  do begin
         if YlosAlas                                            //<,,Kasvatetaan YLÖS,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
         then begin
            if ssShift IN Shift                                 //<=== Halutaan VAIN siirtää KOKO IKKUNAA (=Sft)=======
            then SyottoAvFrm.Top := SyottoAvFrm.Top -dy
            else begin
               SyottoAvFrm.Top := SyottoAvFrm.Top -dy;             //<+130.3u
               if Height < Screen.Height
                  then Height := Height+dy;                        //Top säilyy ennallaan, tarkist. jälempnä.
               if Height > Screen.Height                           //<Max.koko rajoitetaan.
                  then SyottoAvFrm.Height := Screen.Height;
            end;
            if Top +Height > Screen.Height                         //<Alareuna oli painunut näkymättömiin
               then Top := Screen.Height - Height;  end
         else begin                             //<,,DwnBtn (pienentää alhaalta)==================================
            if ssShift IN Shift                                 //<=== Halutaan VAIN siirtää KOKO IKKUNAA (=Sft)=======
            then begin
               SyottoAvFrm.Top := SyottoAvFrm.Top +dy;
               if Top+Height > Screen.Height
                  then Top := Screen.Height -Height;  end
            else begin
               if Height > minH  then begin                        //<,,Pienennetään ylhäältä = Top := ...
                  Height := Height-dy;
                  Top := Top +dy;  end;                                                                   //<+8.0.3
               if Height < minH  then Height := minH;
            end;
         end;
         Refresh;
      end;//with
   end;//AvFrmYls

begin//UpDwnHMouseDown..............
   inherited;
   if Y<=UpDwnH.Height DIV 2
      then AvFrmYls (true)    //<Ylös
      else AvFrmYls (false);  //<Alas
end;//UpDwnHMouseDown

//,Oli +8.0.3=OnClick => MouseDown +10.0.4 ja koon muutos => PRC AvusteKoko.
procedure TSyottoFrm.UpDwnWMouseDown(Sender: TObject;  Button: TMouseButton;  Shift: TShiftState;  X,Y: Integer);

   procedure AvFrmOik (OikVas :boolean); //Siirrtty tähän  +10.0.4=MouseDown.  Korj+ikkunanSiirtomahis 11.0.1
         CONST dxI=80;  dxP=8;  minW=150;      VAR dx,w :integer;      begin
      if ssCtrl IN Shift
         then dx := dxP
         else dx := dxI;
      with SyottoAvFrm  do begin
         if OikVas                              //<,,OikBtn (levitetään)==========================================
         then begin                                             //,,,SyottoAvFrm.. jotta debugissa näkyisi arvot.
            if ssShift IN Shift                                 //<=== Halutaan siirtää KOKO IKKUNAA (=Sft)=======
            then SyottoAvFrm.Left := SyottoAvFrm.Left +dx
            else begin
               w := SyottoAvFrm.Width +dx;                      //<Kasvatetaan leveyttä.
               if w > Screen.Width
                  then w := Screen.Width;                       //<Rajoitetaan ikkunan leveys jo tässä.
               Width := w;
            end;
            if SyottoAvFrm.Left +Width > Screen.Width
               then Left := Screen.Width -Width;  end
         else begin                             //<,,VasBtn (kavennetaan)=========================================
            if ssShift IN Shift                                 //<=== Halutaan siirtää KOKO IKKUNAA (=Sft)=======
            then SyottoAvFrm.Left := SyottoAvFrm.Left -dx
            else begin                                          //?+130.3u
               w := SyottoAvFrm.Width -dx;                      //'ssShift =Halutaan siirtää koko ikkuna.
               if w < minW                                      //<,Tarkistetaan ikkunan leveys jo tässä.
                  then w := minW;
               Width := w;  end;
            if SyottoAvFrm.Left<0  then Left := 0;
         end;
      end;//with
   end;//AvFrmOik

begin//UpDwnWMouseDown..............
   inherited;
   if X>=UpDwnW.Width DIV 2         //< X>=.. =Click puolivälin oik.puolelle. Oli UpDwnH  :11.0.1
      then AvFrmOik (true)          //<Oik.
      else AvFrmOik (false);        //<Vas.
end;//UpDwnWMouseDown                                         //,,+120.5n/6, 141.1:  SijBts´ssa asetetaan VAIN JkUpsChk -sijoittelu, TÄÄLLÄ Checked := ..
                                                              //,,Tänne tultaessa Checked on jo vaihtunut vastakkaiseksi.
procedure TSyottoFrm.JkUpsChkMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);      begin
   inherited;
   if JkUpsChk.Checked  then begin                            //<+130.3u, a,141.1 JkUpsChk.Vis => JkUpsChk.Checked
      JkUpsChk.Visible := false;                              //<+141.1  Poistetaan myös ChkBx´in näkyvistä.
      JkUpsChk_Dlg := true;                                   //<141.1:  Siirrty alempaa. Vain tämän Josa-Dialogin lopuksi.  1412: FA DrawAlas ja OnCloseFrm´ssa.
      JkUpsInt := 1;                                          //,JkUps.ArvoInt arvot häviää, pitää käyttää JKUPSINT´ia, josta siirto ShowModalin jälkeen.
      UpsNytVex := 0;
   end else begin                                             //<'141.1  ShowModalin jälkeen TUTKIT SrcEdka ja sijoitetaan sen muk.
      JkUpsChk.Visible := false;//true;
      JkUpsLbl.Visible := false;
      JkUpsChk_Dlg := false;
      JkUpsInt := 0;                                          //<,141.1
      UpsNytVex := 1;                                         //<141.1:  Ainoa keino kertoa että nyt JkUps vex.
   end;
   SyottoFrm.Close;       //<-1412.
end;//UpsChkMouseUp

//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
procedure PRNavuste;      begin
// Beep;
   SyottoAvFrm.SyoAv.Print('');
end;

procedure TSyottoFrm.CyBx1_80MouseMove(Sender: TObject; Shift: TShiftState;  X,Y: Integer);
      VAR nro,sar,riv :integer;      begin
   inherited;
   if OK_Ly_Bx (Sender, nro,sar,riv) and syoAvOn
      then avustY (1,sar,riv);   end;

procedure TSyottoFrm.CyBx1_80KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
      VAR nro,sar,riv  :integer;      begin
   inherited;
   if (Key IN [80,112])  and  (ssCtrl IN Shift) //<,, 80=P  112=p  = Ctrl+P :llä tulostus +8.0.3
   then PRNavuste
   else if {key=#13}key=13
   then begin
      Key := 0;                                  //<Beeppi vex Enteristä.  +8.0.8 ei tosin taida workkia.
      if OK_Ly_Bx (Sender,nro,sar,riv)
      then begin                                 //< Ei ELSE, koska EXIT:ssä FocusBak_Ly
        {if arvoOK (no,syoKut)  then             //<Tarkistus riittää. RTN ei siirrä focusta, OK}
         case nro of
             11 :SelectNext(CyBx11, true,true);       12 :SelectNext(CyBx12, true,true);
             21 :SelectNext(CyBx21, true,true);       22 :SelectNext(CyBx22, true,true);
             31 :SelectNext(CyBx31, true,true);       32 :SelectNext(CyBx32, true,true);
             40 :SelectNext(CyBx40, true,true);
             51 :SelectNext(CyBx51, true,true);       52 :SelectNext(CyBx52, true,true);
             61 :SelectNext(CyBx61, true,true);       62 :SelectNext(CyBx62, true,true);
             71 :SelectNext(CyBx71, true,true);       72 :SelectNext(CyBx72, true,true);
             80 :SelectNext(CyBx80, true,true);  end;//case
      end;{if OKsend..}
      Key := 0;                                  //<Beeppi vex Enteristä.  +8.0.8 ei tosin taida workkia.
   end;{if key=}                                                 //s := s+'KeyPrs '+fImrkt0(no,1)+LF;
end;//TSyottoFrm.CyBx_KeyDown

procedure TSyottoFrm.CyBx1_80Enter(Sender: TObject);      VAR nro,sar,riv  :integer;
   procedure prc;      begin
      if syoAvOn  then begin
         fSyoAktv (0);                                 //<Tai avuChkSft (10), olisi aivan sama muttei cbChecked/UnChecked.
         avustY (1,sar,riv);  avuChkSft (11);  end;
//############################''''''''''''''????????##############################################################
      riv := fYriv (sar,riv);               //<Text+PudValikko Bx:iin. fRivY muutta riveiksi 11..41 SAR :n mukaan
      sijCyBx (riv);
                                                     //,10.0.4:  Kumma ettei ComBx_Enter´issä näitä tarvitaan!!!!!
     {TComboBoxXY(Sender).SelectAll;                 //<+10.0.4  <,Nämä workkii =Text maalautuu ja BS delaa,
      TComboBoxXY(Sender).SetFocus;                  //<+10.0.4    ^C palauttaa, Entert siirtää focusin seuraavaan.}
   end;                                              //''Ei tarvitakaan, workkii paremmin nyt ilman. Vaati useita
begin//..............................                //  klikkejä ennen kuin suostui avaamaan pud.valikon.
   inherited;
   if OK_Ly_Bx (Sender, nro,sar,riv)  then prc;
end;//CyBx_Enter

{procedure TSyottoFrm.CyBx_Exit(Sender: TObject);      VAR nro,sar,riv  :integer;      begin <,,,-10.0.4
 #################################################################################################################
 ##################### OnExit aihautti sen, että jos olit muuttamassa jotain Bx:n arvoa ja #######################
 ##################### yritetään painaa Siirra_A -painiketta, sitä täytyy klikata kahdesti,#######################
 ##################### ja onhan OnExit turhakin, koska OnChange päivittää koko ajan.       #######################
 #################################################################################################################
end;//..Exit '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''-10.0.4}

procedure TSyottoFrm.CyBx1_80Change(Sender: TObject);      VAR nro,sar,riv  :integer;  {boo :boolean;      }begin
   inherited;
   if OK_Ly_Bx (Sender,nro,sar,riv)  then begin                    //,,syoKut=1 TÄSSÄ AINA ######################
      riv := fYriv (sar,riv);                                      //<Muutetaan RIVitiedoksi SAR:n mukaan.#######
    //s := TComboBoxXY(Sender).Text;                               //<+10.0.4    =OK, mutta ei tarvetta S:lle.
     {case nro of                                                  //<,,-10.0.4  Korvattu TCombo...Text edellä.
          11 :s := CyBx11.Text;       12 :s := CyBx12.Text;  ... 80 :s := CyBx80.Text;  end;//case}


//    if SokR (s,ar) and (ar>0)  then                           //<Ekax tarkistus ettei keskeneräisestä herja.
      if arvoOKe (riv,syoKut)        //<..OKe = EiHerjaa        //,syoAktv := FA.. jotta seur. avuste mahdollinen
      then begin
          {TComboBoxXY(Sender).SelLength := 0;                  //<,+10.0.4  <Muuten cursori häviää, todettu.
           TComboBoxXY(Sender).Setfocus;}                       //<'Ei sittenkään tarpeen.
         //LasEdiLy_Gr (99)                                     //<Päivitetään KOKO RUUTU ########################
           LasEdiLy_Gr (riv);  end                              //<Päivitetään vaikutukset #########
      else FocusBak_Ly (Sender);
   end;
   if MuuLsk=1  then                                            //<+10.0.4
      MuuLaskenta;                                              // Ei muuten pysynyt Grd White´na.
end;//CyBx_Change
//.........................................
procedure TSyottoFrm.SiirraY_BtnMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);      begin//
  inherited;
   if syoAvOn  then
      avustY (0,0,41);  end; //< 41: avustY lisää +10 -> 51

procedure TSyottoFrm.LbYa1MouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
begin
   inherited;
   if NOT DblKlikki  then begin
      syoAktv := false;
      if syoAvOn  then
         avustY (0,0,41);    //< 41: avustY lisää +10 -> 51
      AvuChkSft (11);  end;
   DblKlikki := false;  end;

procedure TSyottoFrm.LbYa1DblClick(Sender: TObject);      begin
   inherited;
   DblKlikki := true;
   AvuChkSft (20);  end;
   
//.........................................

procedure TSyottoFrm.SiirraA_BtnMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);      begin
  inherited;
   if syoAvOn  then
      avustY (0,0,42);  end; //< 42: avustY lisää +10 -> 52

procedure TSyottoFrm.LbYa2MouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
begin
   inherited;
   if NOT DblKlikki  then begin
      syoAktv := false;
      if syoAvOn  then
         avustY (0,0,42);    //< 42: avustY lisää +10 -> 52
      AvuChkSft (11);  end;
   DblKlikki := false;  end;

procedure TSyottoFrm.LbYa2DblClick(Sender: TObject);      begin
   inherited;
   DblKlikki := true;
   AvuChkSft (20);  end;
//===========================================================================YLÄVERKON APULASK.RUUTU'''''''''''''

procedure TSyottoFrm.StrGr1_10MouseMove(Sender: TObject; Shift: TShiftState;  X,Y: Integer);     begin
//if isDebuggerPresent  then SyottoFrm.Caption := 'SYOTT: Col=' +Ints(fLy_Col (X,Y)) +' Rw=' +Ints(fRv_1(y)) +'  Syokut=' +Ints(SyoKut); //+130.2e  130.3u.
   if syoAvOn  then
      avust(0,fRv(Y),syoKut);  end; //<1.1.4 Chckd -> syoAvOn

procedure TSyottoFrm.StrGr2MouseMove(Sender: TObject; Shift: TShiftState;  X,Y: Integer);        begin
 //if syoAvOn  then avust(1,0,syoKut);  end;      //< Ei tartte laskea riviä =0, 1=ComBx -avuste
   if NOT syoAktv  then
      SyottoAvFrm.Hide;  end;

procedure TSyottoFrm.StrGr1_10MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   inherited;
   if NOT DblKlikki  then begin
      syoAktv := false;
      if syoAvOn  then avust(0,fRv(Y),syoKut);
      AvuChkSft (11);  end;
   DblKlikki := false;  end;

procedure TSyottoFrm.StrGr1_10DblClick(Sender: TObject);      begin
   DblKlikki := true;
   AvuChkSft (20);  end;
//..........................................................
procedure TSyottoFrm.DiskontPanelMouseMove(Sender: TObject;  Shift: TShiftState;  X,Y: Integer);      begin
   inherited;
   if syoAvOn  then avust(0,1,syoKut);  end;
procedure TSyottoFrm.DiskontPanelMouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   inherited;
   if NOT DblKlikki  then begin
      syoAktv := false;
      if syoAvOn  then avust(0,1,syoKut);
      AvuChkSft (11);  end;
   DblKlikki := false;  end;
procedure TSyottoFrm.DiskontPanelDblClick(Sender: TObject);      begin
   inherited;
   DblKlikki := true;
   AvuChkSft (20);  end;

procedure TSyottoFrm.AlkuPhPanelMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);      begin
   inherited;
   if syoAvOn  then avust(0,5,syoKut);  end;
procedure TSyottoFrm.AlkuPhPanelMouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
begin
   inherited;
   if NOT DblKlikki  then begin
      syoAktv := false;
      if syoAvOn  then avust(0,5,syoKut);
      AvuChkSft (11);  end;
   DblKlikki := false;  end;
procedure TSyottoFrm.AlkuPhPanelDblClick(Sender: TObject);      begin
   inherited;
   DblKlikki := true;
   AvuChkSft (20);  end;

procedure TSyottoFrm.LopArvPanelMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);      begin
   inherited;
   if syoAvOn  then avust(0,6,syoKut);  end;
procedure TSyottoFrm.LopArvPanelMouseDown(Sender: TObject;   Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   inherited;
   if NOT DblKlikki  then begin
      syoAktv := false;
      if syoAvOn  then avust(0,6,syoKut);
      AvuChkSft (11);  end;
   DblKlikki := false;  end;
procedure TSyottoFrm.LopArvPanelDblClick(Sender: TObject);      begin
   inherited;
   DblKlikki := true;
   AvuChkSft (20);  end;

procedure TSyottoFrm.AlaPanels1MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);      begin
  inherited;
   if syoAvOn  then avust(0,12,syoKut);  end;
procedure TSyottoFrm.AlaPanels2MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);      begin
  inherited;
   if syoAvOn  then avust(0,13,syoKut);  end;

procedure TSyottoFrm.AlaPanels1MouseDown(Sender: TObject;   Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   inherited;
   if NOT DblKlikki  then begin
      syoAktv := false;
      if syoAvOn  then avust(0,12,syoKut);
      AvuChkSft (11);  end;
   DblKlikki := false;  end;
procedure TSyottoFrm.AlaPanels2MouseDown(Sender: TObject;   Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   inherited;
   if NOT DblKlikki  then begin
      syoAktv := false;
      if syoAvOn  then avust(0,13,syoKut);
      AvuChkSft (11);  end;
   DblKlikki := false;  end;

procedure TSyottoFrm.AlaPanels1DblClick(Sender: TObject);      begin
  inherited;
   DblKlikki := true;
   AvuChkSft (20);  end;
procedure TSyottoFrm.AlaPanels2DblClick(Sender: TObject);      begin
  inherited;
   DblKlikki := true;
   AvuChkSft (20);  end;
//==================================================================================================

procedure TSyottoFrm.ComBx1_11MouseMove(Sender: TObject; Shift: TShiftState;  X, Y: Integer);      var no :integer;
     procedure prc(rivi :integer);   begin
        if syoAvOn  then begin
           avust(1,rivi,syoKut);     //< 1=>0 :11.0.1 Ei tunnu olevan vaikutusta, ON JO VAIHTANUT avun.
         //SyottoFrm.SetFocus;          //<+8.0.14  Ei auttanut:  Ei siirrä focusta aoBxiin.
        end; //<1.1.4 Chckd -> syoAvOn
     end;
begin  if OKsenderComBx1_11(Sender,no)
          then prc(no);
end;
procedure TSyottoFrm.ComBx3Select(Sender: TObject);      begin //+130.2e Jotta pudValValinnassa voitaisiin korjata 9.8E-5000 =>0.00098´ksi (<= 0.0001)
   inherited;
   SyottoFrm.Caption := 'ComBx3: ' +SyottoFrm.ComBx3.Text;
end;

//==================================================================================================
procedure FocusBak_(no :integer);

   procedure Foc (VAR BxU :TComboBoxXY);      begin//+5.0.0
      if BxU.Visible  then begin
         BxU.SetFocus;                             //< -5.0.0  +5.0.0 takaisin.
         BxU.SelLength := Length (BxU.Text);  end; //< +5.0.0
   end;
begin     //no := 0; s := s+'==FocusBak'+LF;
  with SyottoFrm  do
  case no of
         1 :Foc (ComBx1);    2 :Foc (ComBx2);    3 :Foc (ComBx3);    4 :Foc (ComBx4);    5 :Foc (ComBx5);
         6 :Foc (ComBx6);    7 :Foc (ComBx7);    8 :Foc (ComBx8);    9 :Foc (ComBx9);   10 :Foc (ComBx10);
        11 :Foc (ComBx11);  12 :Foc (ComBx12);  13 :Foc (ComBx13);  14 :Foc (ComBx14);  15 :Foc (ComBx15);
  end;{case}                                                    //s := s+'FocBak '+fImrkt0(no,1)+LF;
end;//FocusBak_
procedure FocusBak(Sender :TObject);      VAR no :integer;      begin     //no := 0; s := s+'==FocusBak'+LF;
  if OKsenderComBx1_11(Sender,no)  then
     FocusBak_ (no);
end;//FocusBak
//==================================================================================================
{procedure NayTabs;      //koe
   procedure tabi (BxU :TComboBoxXY);      begin
      if (BxU.Name='x') and
         (BxU.TabOrder<0)  then beep;  end;
begin  with SyottoFrm  do begin
   tabi (ComBx1);   tabi (ComBx2);   tabi (ComBx3);   tabi (ComBx4);    tabi (ComBx5);    tabi (ComBx6);
   tabi (ComBx7);   tabi (ComBx8);   tabi (ComBx9);   tabi (ComBx10);   tabi (ComBx11);   tabi (ComBx12);
   tabi (ComBx13);  tabi (ComBx14);  tabi (ComBx15);  end;
end;}
   procedure Koe_wrCtrls (oss :string);     VAR ChkFileN,sY :string;  ChkFile :Text;  //i :integer; //<,,10.0.4  

      procedure wr (si :string);      begin
                             {ChkFileN := Application.ExeName;
                              ChkFileN := ChangeFileExt (ChkFileN,'.');   Delete (ChkFileN, Length (ChkFileN) ,1);
                              ChkFileN := ChkFileN +'-Apur.txt';}
         ChkFileN := 'E:\Projektit\NolaKehi\SRC\Globals\Apuja\Koeajo-Ctrls.txt';
                                       {DefsFileen}DebWr(0,'+®+','AssgnFile 13');
         AssignFile (ChkFile,ChkFileN);
         if NOT fFileExists(ChkFileN)
            then Rewrite (ChkFile)
            else Append (ChkFile);
         WRITELN (ChkFile, si);
         Flush (ChkFile);
         CloseFile (ChkFile);
      end;
   begin//Koe_wrCtrls.........................
      sY := '(' +oss +'):  ';   with SyottoFrm  do
      sY := sY +' Bx1:'+Ints(ComBx1.TabOrder) +' Bx2:'+Ints(ComBx2.TabOrder) +' Bx3:'+Ints(ComBx3.TabOrder) +
                ' Bx4:'+Ints(ComBx4.TabOrder) +' Bx5:'+Ints(ComBx5.TabOrder) +' Bx6:'+Ints(ComBx6.TabOrder) +
                ' Bx7:'+Ints(ComBx7.TabOrder) +' Bx8:'+Ints(ComBx8.TabOrder) +' Bx9:'+Ints(ComBx9.TabOrder) +
                ' Bx10:'+Ints(ComBx10.TabOrder) +' Bx11:'+Ints(ComBx11.TabOrder) +' Bx12:'+Ints(ComBx12.TabOrder)+
                ' Bx13:'+Ints(ComBx13.TabOrder) +' Bx14:'+Ints(ComBx14.TabOrder) +' Bx15:'+Ints(ComBx15.TabOrder);
     {for i := 0 to SyottoFrm.ControlCount -1  do
         sY := sY +' '+Ints(i) +':Nm='+SyottoFrm.Controls[i].Name;// +' Tb='+//SyottoFrm.Controls[i].TabOrder;}
             //Ints(SyottoFrm.Controls[i].TabOrder);
             //(SyottoFrm.Controls[i] as TWinControl).TabOrder;
      //if i MOD 3=0  then sY := sY +'<br>'  else sY := sY +'  ';
{      wr (sY);
'''''''''''''''Ainoa tiedostoon kirjoittava rivi.}
   {if (Sender is TComboBox) then
    with (Sender as TComboBox) do
        {if  SyottoFrm.Controls[i] is TWinControl  then
         if (SyottoFrm.Controls[i] as TWinControl).Focused  and
            (SyottoFrm.Controls[i] is TComboBoxXY)  then
         if i<SyottoFrm.ControlCount-1
        {then SyottoFrm.Controls[i+1].SetFocus   //<Siirretään focus seuraavaan boxiin tai jos vika Bx,
         else SyottoFrm.Controls[1  ].SetFocus;  // siirretään ekaan.
         then SyottoFrm.FocusControl (Controls[i+1])
         else SyottoFrm.FocusControl (SyottoFrm.Controls[  1]);}
       //SyottoFrm.Controls[BxU.TabOrder+1].SetFocus;
       //SyottoFrm.ActiveControl (SyottoFrm.Controls[BxU.TabOrder+1]);
       //SyottoFrm.ActiveControl.Controls[BxU.TabOrder+1];  <Acces violation.
       //TComboBoxXY (Sender).SetFocus;
   end;//Koe_wrCtrls

 (*procedure Koe_wwCtrls (oss :string;  Sender: TObject);
         VAR ChkFileN,sY :string;  ChkFile :Text;  i :integer; //<,,10.0.4

      procedure wr (si :string);      begin
                             {ChkFileN := Application.ExeName;
                              ChkFileN := ChangeFileExt (ChkFileN,'.');   Delete (ChkFileN, Length (ChkFileN) ,1);
                              ChkFileN := ChkFileN +'-Apur.txt';}
         ChkFileN := 'E:\Projektit\NolaKehi\SRC\Globals\Apuja\Koeajo-Ctrls.txt';
         AssignFile (ChkFile,ChkFileN);
         if NOT FileExists (ChkFileN)
            then Rewrite (ChkFile)
            else Append (ChkFile);
         WRITELN (ChkFile, si);
         Flush (ChkFile);
         CloseFile (ChkFile);
      end;
   begin//Koe_wwCtrls.........................
      sY := '(' +oss +'):  ';   with SyottoFrm  do
      sY := sY +'Name oli=' +TComboBoxXY(Sender).Name +' => ' +ActiveControl.Name +
                ' TbOrd oli=' +Ints(TComboBoxXY(Sender).TabOrder) +' => ' +Ints(ActiveControl.TabOrder);
      wr (sY);  //<Ainoa tiedostoon kirjoittava rivi.
   end;//Koe_wwCtrls*)

          //,,Tapahtuu ennen Exittiä          //,,4.0.4 KeyPres vaihdettu KeyDown´iksi mutta JÄI VAIN Bx1:lle.!!!!
procedure TSyottoFrm.ComBx1_11KeyDown(Sender: TObject;  var Key: Word;  Shift: TShiftState); //+5.0.0 =KaikkiBxt
      VAR no :integer;

   procedure SelNextTabi  (BxU :TComboBoxXY);      VAR s :string;{i :integer;      }begin//10.0.4
                   //SyottoFrm.Caption :=
                   //if BxU.Name +'  ' +Ints(BxU.TabOrder) +'  Parent=' +BxU.Parent.Name ='9'  then beep;
      //if BxU.TabOrder then                                                                  //<,,+1412:  Estetään vikasta ComBx´ista siirtyminen aRichiin,
      //if NOT FindNextControl as TComboBoxXY                                                 //           Nyt ohjataan focus OkBtn´iin.
      //if NOT (FindNextControl(BxU,true,true,true) as TComboBoxXY  then beep;  EiOK.
      s := (FindNextControl(BxU,true,true,true) as TWinControl).Name;  //then s := TWinControl.Name; =OK.
      if Pos('COMBX',AnsiUpperCase(s))=0
         then OkBtn.SetFocus                                                                  //<''+1412
         else SyottoFrm.SelectNext(BxU, true,true);
                   //case no of 1 :SelectNext(ComBx1..//<,,Korvattu SelNextTabi´lla 10.0.4
      //BxU.SetFocus;                              //<Focusoi vanhaan, ei seuraavaan.
   end;
begin//ComBx1_11KeyDown...................
   inherited;
   if (Key IN [80,112])  and  (ssCtrl IN Shift) //<,, 80=P  112=p  +8.0.3
   then PRNavuste
   else if Key=13
   then begin
      if (Shift=[ssCtrl]) and PanelYy.Visible     //<PanelYy AINA NÄKYVISSÄ, JOS ollaan LIITTYMÄOSAssa
      then Label1DblClick(Sender)                 //<'Nämä vain koekaäytön helpottamiseen:  Pääsy LIITTYMÄARVOIHIN
      else if OKsenderComBx1_11(Sender,no)
      then begin                                  //< Ei ELSE, koska EXIT:ssä FocusBak
         if arvoOK (no,syoKut)  then              //<Tarkistus riittää. RTN ei siirrä focusta, OK
            SelNextTabi (TComboBoxXY(Sender));    //< =OK.
        {if NOT (ActiveControl is TComboBoxXY)    //<,Koe.
            then SelectNext(ActiveControl as TWinControl,False,True); //<Kohdistetaan valinta takas edelliseeen.}

         ActiveControl.SetFocus;                  //<+10.0.4  Välttämätön, HavKust:ssa ei focusoi Boxeihin muuten.
      end;//if OKsend..
   end{if key=13}                                                     //s := s+'KeyPrs '+fImrkt0(no,1)+LF;
 //else begin end;                                //<if Key=13 else
end;//TSyottoFrm.ComBx1_11KeyDown

procedure TSyottoFrm.ComBx1_80KeyPress(Sender: TObject;  var Key: Char);      begin //+8.0.8  Eventti tulee KeyDow´n jälkeen.
   inherited;
   if Key = #13 then //<,Asettamalla arvoksi #0 ei tule Beep´piä enää, OK, todettu. Ks. Delphi vihjeet.
      Key := #0;
end;
            {,,,,,8.0.0a Oli ongelma: Jos focus oli esim. Box4, Clicki ei siirtänyt focusta ylemmäksi, esim. Box3:een.
                     Ratkaisu: ObjInsp:ssa yhteiseksi OnClick -eventiksi ComBx1_11Enter, ja HOMMA KORJAANTUI.
            {,,,,,Enter tapahtuu heti, kun boxin alueella Click =ENNEN, kuin OnClickEvent reagoi !!!!!!!!!!!!!!!!}
procedure TSyottoFrm.ComBx1_11Enter(Sender: TObject);      VAR no :integer;  //comp :TComponent;
            {#####################################################################################################
             #####################################################################################################
             #### 11.0.1 yleistilanne:  Klikkaus maalaa aoBx:n mrkt ja key-näppäilyt siirtyvät arvokenttään KUN:##
             #### - ComBx1Exit´ssä ei mitään sorsarivejä.                                                     ####
             #### - Tässä (..Enter) VAIN:                                                                     ####
             ####      if syoAvOn  then                                                                       ####
             ####         avust(1,rivi,syoKut);                                                               ####
             #####################################################################################################
             ############# 10.0.3 on vika versio, missä Enter maalasi BxnArvon ja alkoi heti muuttaa #############
             ############# txtiä kuten pitääkin ennen tätä versiota (11.0.1). NYT VATII 2xClick.     #############
             ####################################################################################################}
     procedure prc(rivi :integer);   VAR sv :string;  an :integer;      begin
                        {sv := 'd:\nettest\nola'+IntToStr(Integer(application.handle)) +'.txt'; //LICENSE.PAS/WriteLog´ista.
                         if sv='§½!"#'  then beep; //HANDLE muuttuu(?), tieto ks. netistä.}
        if syoAvOn  then begin                      //,=Avaa, avuChkSft (10) pvittää muut frm´it. Koklattu 11.0.1.
           fSyoAktv(0);                             //,,+120.5o:,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
         //Cnt := StrGr1.RowCount;                              //Liittymän johdn rv 14="Johdinresistanssien T°C",  J-osilla="Alkupään uh%" (13 on 14. BxRv).
           sv := StrGr1.Cells[0,rivi];                          //<Rivi 15 => Count=17, eli Norm.j-osilla:  Rivi(13=.."Cos")  14=.."uh%"  15=.."T°C"
           an := Pos('T°C',sv);                                 //            Count=16,     Liitt.j-osilla:     (13=.."Cos")  14=.."T°C"
           if (rivi=14) and (an>0)                                            //<,Jos T°C on rivillä 14, on se liittymän johto => avuste 14 => 15 rvn mukaan.
              then SyottoAvFrm.SyoAv.Text := avusU(1,rivi+1,rivi,syoKut)      //<rivi+1 =avusU´n ohjaava os, rivi=editoitava NO.
              else SyottoAvFrm.SyoAv.Text := avusf(1,       rivi,syoKut);
                                                    //<''+120.5o'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
         //SyottoAvFrm.SyoAv.Text := avusf(1,rivi,syoKut); //<rivi=avuste ao. Box´in mukaan.
           fSyoAktv(1);                             //<=Lukitsee, avuChkSft (11) pvittää muut frm´it. Koklattu 11.0.1.
        end;
        BxArvot(rivi,syoKut);                       //<Oletus+Itemit boxiin
     end;//prc

begin//ComBx1_11Enter.............  {no := 0;  sv := sv+'==Enter'+LF;

   if OKsenderComBx1_11(Sender,no)                        //<,Kokonaan vex -10.0.4 (Sen jälkeen kun OnExit vex).
      then prc(no);          //,Jos eiComBxKokeilua, pyyhitään alapanelin aRich tyhjäksi ja lisätään tämä tieto:
end;//ComBx1_11Enter

{###################################################################################################
##### OnEXIT tapahtuu AINA, kun syöttöBOXISTA poistutaan = TÄHÄN ARVO/OIKEELLISUUSTARKISTUKSET #####
##### OnKeyPress:iin myös tarkistus, koska siellä ohjataan seur. boxiin. Tässä: TAB+SfTAB+Click#####
######## TARKISTUS MYÖS OnDeactivate -tapahtumassa, jotta mahista SIIRTYÄ SEUR.JOHTO-OSAAN #########}
procedure TSyottoFrm.ComBx1_11Exit(Sender: TObject);   VAR no :integer; //10.0.4:  Tämän aikana focus siirtyy
begin                                                                   // Sender´istä ActiveControl´liin, todettu.
   inherited;                                        //11.0.1 todettu: Tähän tultaessa focus jo uudessa Bx´ssa,
                                                     //                ainakin ActiveControl.Name´ssa uusi nimi.
  syoAktv := false; //<Lisätty 1.0.8/10.10.98: Ekan BxClicin jälkeen ei avusteet vaihtuneet Boxeihin, nyt OK.
  pvtLiitRpX;                                        //<+3.0.2

//Poistettu 1.0.8 :aan = tarkistetaan vain Enterille ja OnOKbtnClick :ssä @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  if (ActiveControl<>RadGrp) and (ActiveControl<>PeruBtn) and    //<PäästäväPois ilman tarkistuksia
     (ActiveControl<>PoistaBtn)  then                             //,+no=2 10.10.98 jotta mm2-valikkoOK
  if OKsenderComBx1_11(Sender,no) {and (no IN [2,3])}  then begin //< -1.1.4 =Nyt KAIKKI rivit. YHT.tarkistOKbtn..
     if arvoOK (no,syoKut)                                        //,syoAktv := FA.. jotta seur. avuste mahdollinen
        then begin  if syoAvOn  then syoAktv := false;            //<1.1.4 Chckd -> syoAvOn
                    if syoKut=5  then                             //<5=HävK. Boxin arvot aiheuttaa tarkist.tarpeen,
                       pvitaDiskontStrGr;                         //< mm. Tim,Korko +Ph yms.  +'2.0.7
             ImpedInfoRich;  end
        else FocusBak(Sender);   //end;
        BxArvot(no,syoKut);  end;                                 //<Oletus+Itemit boxiin +5.0.0 VALINTATLKn takia
end;//ComBx1_11Exit
                                                          //,,+5.0.0
   procedure TSyottoFrm.WMupdateCombo(VAR Msg: TMessage); //<,Tarpeen vain KorjFrm´ista palautettavalle arvolle.
   begin                                                  //Jani Järvisen meilistä ???:
     ComBx7.Text := UusCombText;
     ComBx7.SelStart := Length (UusCombText);
   end;
//======================================================================================================================= //,+2.0.7
procedure TSyottoFrm.ComBx1_11Change(Sender: TObject);      VAR no,ai :integer;  ar :real;  CfgFn,sp,IterExeFN,GomatParFN :string;  Lst :TStringList{1411};

   procedure TeeCfgFn;      VAR s,sa :string;   begin
      sa := Application.ExeName;                //<,,Goman param talletukseen.
      s := IncludeTrailingPathDelimiter (ExtractFilePath(sa));
      //CfgFn := ExtractFileName(sa);
      //CfgFn := s +'_' +CfgFn;
      //CfgFn := ChangeFileExt(CfgFn, s +'_Iteroi-Cfg.txt'); //<Oli: '..\_Iteroi-Cfg.txt => '..\_Iteroi-CfgGen.txt EI HYVÄ: Iter.exe´ssä kolvattu CfgFn -nimi
      CfgFn := s +'_Iteroi-Cfg.txt'; //< ..\_Iteroi-CfgGen.txt oltav oikein, Iter.exe´ssä kolvattu CfgFn -nimi.
   end;//}

   procedure TeeTalletaEdvCfg;      VAR s{,sa{,OutFn} :string;  txf :TextFile; //+1412:  Tämä on kopio Iteroi.exe´ssä. Tässä tallennetaan Cfg -fileen jotta
      procedure Wr (s1,s2 :string);      CONST lev=10;  VAR sa :string;  u :integer;   begin // näkyisi vertailuerotkun Iteroi.exe avautuu. Tämä VAIN jos
         sa := '';                                                                           // Iteroi.exe ei ole AIKAISEMMIN tallentatnut tällaista filettä.
         for u := Length(s1) to lev  do s1 := s1 +' '; //<NroArvoPalsta vakioleveydeksi.
         Writeln (txf, s1 +s2);  end;

   begin//TeeTalletaEdvCfg........................
     {if IterFrm.CmBx.Visible and (eCol>0) and (eRow>0) and (IterFrm.CmBx.Text<>'')           //<,Nämä jäänteitä Iter.PAS´sista.
         then toCell (eCol,eRow, IterFrm.CmBx.Text); //<Muuten ei Celliarvo ole pvittynyt. toCell lihavoi lasket´staEroavat.}
      AssignFile(txf,CfgFn);
      Rewrite (txf);
      Wr (Ints(SyottoFrm.Top),   ' =Top');   //<,,Oli IterFrm, OK vaikka IteFrm tulisi päälle.
      Wr (Ints(SyottoFrm.Left),  ' =Left');
      Wr (Ints(SyottoFrm.Height),' =Height');
      Wr (Ints(SyottoFrm.Width), ' =Width');

      s := fImrkt0 (Edv.Sorc[edi].Src.gSn.     arvoInt, 1  );  Wr (s  ,' =rv 1  Sn');
                                                               Wr ('1',' =rv 2  Typ');  //  NOLAssa oli alp. 1 (Stamford).
      s := fRmrkt0 (Edv.Sorc[edi].Src.gXd.     arvoRea, 1,3);  Wr (s  ,' =rv 3  Xd');
      s := fRmrkt0 (Edv.Sorc[edi].Src.gXd1.    arvoRea, 1,3);  Wr (s  ,' =rv 4  X''d');
      s := fRmrkt0 (Edv.Sorc[edi].Src.gXd2.    arvoRea, 1,3);  Wr (s  ,' =rv 5  X"d');
      s := fRmrkt0 (Edv.Sorc[edi].Src.gRs.     arvoRea, 1,4);  Wr (s  ,' =rv 6  Rs 22°C');
      s := fRmrkt0 (Edv.Sorc[edi].Src.gTd1.    arvoRea, 1,3);  Wr (s  ,' =rv 7  T''d');
      s := fRmrkt0 (Edv.Sorc[edi].Src.gTd2.    arvoRea, 1,3);  Wr (s  ,' =rv 8  T"d');
      s := fRmrkt0 (Edv.Sorc[edi].Src.gtIkMin. arvoRea, 1,3);  Wr (s  ,' =rv 9  tIkm');
      s := fRmrkt0 (Edv.Sorc[edi].Src.gtIkSust.arvoRea, 1,3);  Wr (s  ,' =rv 10 tIkS');
      s := fImrkt0 (Edv.Sorc[edi].Src.gIkSust. arvoInt, 1  );  Wr (s  ,' =rv 11 IkSus');
      s := fRmrkt0 (Edv.Sorc[edi].Src.gK1vSust.arvoRea, 1,3);  Wr (s  ,' =rv 12 K1vSust');
      CloseFile (txf);
     {if NOLAan  then begin                        //,Ei onanut OnShow´ssa.
         sa := Application.ExeName;                //<,,Goman param talletukseen.
         s := ExtractFilePath(sa);                 //<,,POLKU: OutFn =Goman param SIIRTOON NOLAan (tms).
         OutFn := s +'$_GomatParamNOLAan.txt';
         CopyFile(PChar(CfgFn), PChar(OutFn),false); //<###############################################
      end;}
   end;//TeeTalletaEdvCfg
//=======================================================================================================================
   function fLueGomatParam (tunnus :string) :real;      VAR i,m,er :integer;  rr :real;  s,sa,se :string;   begin //+1411
      tunnus := Trim(tunnus);  se := '';  rr := 0;
      s := GomatParFN;  er := 0;
      for i := 0 to Lst.Count-1  do begin
         sa := Lst[i];
         er := 0;
         m := Pos(AnsiUpperCase(tunnus), AnsiUpperCase(sa));
         if m>0  then begin            //<Rvltä löytyy tunnus.
            m := Pos(' ',sa);
            se := Copy(sa,1,m-1);
            m := Pos(',',se);
            if m>0  then se[m] := '.'; //<'DesimPilkku muutetaan pisteeksi.
            if NOT SokR(se,rr)
               then er := 9;
            Break;
         end;//if m>0                  //<+1412: +";"
      end;//for            //,,,,,,,(m=0) => (se='') :1412
      if (i=Lst.Count-1) and (se='') or (er>0)
          then if NOT InputQuery('Parametrien käsittely.', 'Tunnusta "' +tunnus +'" ei löydy, selvitä puuttuminen tiedostosta: ', s)
                  then Halt; //<Keskeytetään ajo.
         if er<0  then ;
      result := rr;
   end;//LueGomatParam

   //,Use ShellExecuteEx instead: - See more at: http://codeverge.com/embarcadero.delphi.general/shellexecute-showmodal/1057606#sthash.zR8jD9Pv.dpuf
   procedure ShellModalNola (ExeFN :string);      VAR info: TShellExecuteInfo;   begin //<Toimii kuten ShowModan:
      FillChar(info, sizeof(info), 0);                                             //http://codeverge.com/embarcadero.delphi.general/shellexecute-showmodal/1057606
      info.cbSize := sizeOf(info);
      info.lpVerb := 'open';
      info.lpFile := PChar(ExeFN);//'c:\temp\test.rtf';
      info.nShow := sw_Show;
      info.fMask := SEE_MASK_NOCLOSEPROCESS;
      ShellExecuteEx(@info);
      WaitForSingleObject(info.hProcess, Infinite);
   end;

begin//ComBx1_11Change..........................
   inherited;                                               ////Jani Järvisen meilistä:             //'ai =+10.0.1
  {if OKsenderComBx1_11(Sender,no) and (syoKut=2) and (no=9)  then
      asetaBx9Color;}
   if OKsenderComBx1_11(Sender,no)  then begin                                         //,EdvJohto-osan KORJkerr.
      if (syoKut IN [2,7]) and (no=7) and (Pos ('VALINTATAULUKKO',AnsiUpperCase (ComBx7.Text)) >0) //< 2,7=+8.0.0
      then begin
         if SrcEdka  then ai := -1
                     else ai := 1;
         KorjFrm.KediY.Text := IntToStr (ai*edi); //<+10.0.1  Välitetään tieto KORJ:lle, onko SCR vai EDKA. //Korjaa???
         KorjFrm.ShowModal;                       //<'+4.0.2    <,,,+5.0.0
         UusCombText := KorjFrm.KediY.Text;       //<Tähän sijoitettiin MYÖS vanha arvo, jos Cancel. KediY on kokonaisKorjKerroin.
         UusCombText := Trim(UusCombText);
         if NOT CharInSet(UusCombText[Length(UusCombText)],['0'..'9'])  then //<,+1414f:  Kun KorjRlkn sulki, 1´n jälkeen tuli ~, elie "1~", ~vex.
            Delete (UusCombText,Length(UusCombText),1);
         PostMessage(Handle,WM_UPDATECOMBO,0,0);  //<The PostMessage property contains the message that is going to
      end                      //'be sent. The TPostMessage object is used for storing an outgoing E-Mail message.
      else begin               //'TNMSMTP contains an instance of TPostMessage as the PostMessage property.
         if (syoKut=1) and (Pos ('HAE UUDET',AnsiUpperCase (ComBx1.Text)) >0)
         then begin
            TeeCfgFn;                       //<CfgFn -nimi täytyy olla sama kuiin Iter.exe´en kolvattu.<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            if fFileExists(CfgFn)  then     //<Jotta nykyinen tapaus voitaisiin sovittaa Iteroi.exe´en.
               DeleteFile(CfgFn);
            TeeTalletaEdvCfg;               //<Tekee  CfgFn -filen Edv.Sorc[edi].Src.... tiedoista jotta Iteroi.exe näyttäisi alp.NOLAn Gen tiedot.
               sp := ExtractFilePath (Application.ExeName);
            IterExeFN := sp +'Iteroi.exe';
            if NOT fFileExists(IterExeFN)   //<Tässä: ..\Iteroi.exe .
            then InfoDlg ({'<left>}'Parametrien käsittelyohjelma "' +IterExeFN +'" puuttuu, kopioi se takaisin tähän NOLAn juurihakemistoon.',
                          mtCustom, 'OK','','','',  '','','','')
            else begin
               ShellModalNola (IterExeFN); //<Oma Shell joka vastaa ShowModal -ideaa.
             //ShellExecute(Application.Handle, 'open', PChar(GomatParFN),'','',SW_SHOWNORMAL); //<+1411,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
               GomatParFN := sp +'$_GomatParamNOLAan.txt';
               if NOT fFileExists(GomatParFN)
               then begin
                  Windows.Beep(30,50);  Windows.Beep(300,200);  Windows.Beep(1000,50);
                  Windows.Beep(30,50);  Windows.Beep(300,200);  Windows.Beep(1000,50);
                  InfoDlg ({'<left>}'Iterointiosasta siirrettävien arvojen tiedosto<br> <t>' +GomatParFN +'<br>puuttuu, palauta '+ //<Tässä vain kokeilussa.
                          'se takaisin tai mene uudelleen arvojen käsittelyyn ja valitse "<b>»»»» Hae uudet »»»»</b>"', mtCustom, 'OK','','','',  '','','','');
               end
               else begin
                  Lst := TStringList.Create;
                  Lst.LoadFromFile(GomatParFN);                                 //,,fLueGomatParam siirtää arvot myös syoArvoikkunaan. <,,+1411
                                                  ar := fLueGomatParam ('Sn');          //  1000        =rv 1  Sn
                  Edv.Sorc[edi].Src.gSn.     arvoInt := Trunc(ar +0.5);                 // (~Stamford:  =rv 2  Typ)
                  Edv.Sorc[edi].Src.gXd.     arvoRea := fLueGomatParam ('Xd');          //  2.73        =rv 3  Xd
                  Edv.Sorc[edi].Src.gXd1.    arvoRea := fLueGomatParam ('X''d');        //  0.22        =rv 4  X'd
                  Edv.Sorc[edi].Src.gXd2.    arvoRea := fLueGomatParam ('X"d');         //  0.15        =rv 5  X"d
                  Edv.Sorc[edi].Src.gRs.     arvoRea := fLueGomatParam ('Rs 22°C');     //  0.0024      =rv 6  Rs 22°C
                  Edv.Sorc[edi].Src.gTd1.    arvoRea := fLueGomatParam ('T''d');        //  0.185       =rv 7  T'd
                  Edv.Sorc[edi].Src.gTd2.    arvoRea := fLueGomatParam ('T"d');         //  0.025       =rv 8  T"d
                  Edv.Sorc[edi].Src.gtIkMin. arvoRea := fLueGomatParam ('tIkm');        //  0.25        =rv 9  tIkm
                  Edv.Sorc[edi].Src.gtIkSust.arvoRea := fLueGomatParam ('tIkS');        //  0.25        =rv 10 tIkS
                                                  ar := fLueGomatParam ('IkSus');       //  3600        =rv 11 IkSus
                  Edv.Sorc[edi].Src.gIkSust. arvoInt := Trunc(ar +0.5);
                  Edv.Sorc[edi].Src.gK1vSust.arvoRea := fLueGomatParam ('K1vSust');     //   2.5         =rv 12 K1vSust

                  Lado_TeeSyoFrm (0);      //<Tämä näyttää uudelleen ed. ikkunan mutta nyt muutetuilla arvoilla. +1411''''''''''''''''''''''''''''''''''''
               end;//if NOT fFileExists(..) else
            end;//else
         end//if (syoKut=1)..
         else begin
            if (syoKut IN [2,7]) and (no=9) //<  2=Edvn johto-osatiedot  7=+8.0.0
               then asetaBx9Color;
           {if syoKut=1  then               //<, 1=Liittymätiedot  +3.0.2  -10.0.4
           {if arvoOKe (no,syoKut)          //<..OKe = EiHerjaa  //<,,-5.0.1  Esti <1.00 arvon antamisen Ik1v:ksi
               then pvtLiitRpX              //,4.0.1 TÄRKEÄ ###########################################
               else BxArvot (no,syoKut);    //<=Jos virheellinen arvo, palauttaa vikan OK-arvon Boxiin+Focus}
            if SyoKut=5  then               //<,+10.0.4  =päivittyy tosiaikaisesti.
            if arvoOKe (no,syoKut)          //<..OKe = EiHerjaa  //<,,-5.0.1  Esti <1.00 arvon antamisen Ik1v:ksi
            then begin
               pvitaDiskontStrGr;
               ImpedInfoRich;  end;         //<Siirretty OnExit´istä.
         end;//else 2
      end;//else 1
   end;
end;//ComBx1_11Change
//##################################################################################################

procedure TSyottoFrm.RadGrpClick(Sender: TObject);      VAR u :integer;      begin
   ComBx1.Visible := false;                      //<,,Visible := FA  +4.0.1  =Pois näkyvistä RadClickin muutok-
   ComBx2.Visible := false;                      //   sen ajaksi.##############################################
   ComBx3.Visible := false;
   ComBx4.Visible := false;
   ComBx5.Visible := false;
   ComBx6.Visible := false;
   ComBx7.Visible := false;
   ComBx8.Visible := false;
   ComBx9.Visible := false;
   ComBx10.Visible := false;
   ComBx11.Visible := false;
   ComBx12.Visible := false;
   ComBx13.Visible := false;
   ComBx14.Visible := false;
   ComBx15.Visible := false;
 //if RadGrp.ItemIndex=0  then a_putIntg (0, 1, Edv.Sorc[edi].src.SorceKind)  //<Sij jotta ajantas. ja
   case RadGrp.ItemIndex of                         //,,a_pu=>u := ...                //<,,if=>case +6.2.10
     0 :u := 1;                                     //<,,Sij jotta ajantas. ja tietoa seur. kertaan.
     1 :u := 2;
     2 :u := 3;                                                                                 //< +8.0.8 §g 
   else begin                                       //u= 1=Transformer  2=LV-Cable  3=Generator  4=UPS
        u := 4;                                     //,,RadGrpClick´ssä EDI=aoSrc, kommentti= +10.0.4 .
        Edv.Sorc[edi].Src.pjLiitRs.arvoRea :=  0;                                               //<,+8.0.0
        Edv.Sorc[edi].Src.pjLiitXs.arvoRea :=  0;   end; end;
   a_putIntg (0, u, Edv.Sorc[edi].Src.SorceKind);  //,-1412:  Palautettu takas, ei aiheutakaan häiriöta ja Vv ym. valinnat vaatii.
   if NOT OhitaBtn.Visible                 //<Vaikkei vahinkoa, vaikka kutsuttaisiin vaikkei HävKust.
      then Lado_TeeSyoFrm (0);             //<ItemIndex muuttui, PRC Lado_TeeSyoFrm ohjautuu sen muk.  Sulkee apuruudn. £$£uu}
   if ComBx1.Visible and SyottoFrm.Visible //< +8.0.8 Vaihdeltaessa liittymätapaa (toistuvasti) Bx1 oli maalattuna
      then ComBx1.SetFocus;                //  muttei valittuna ei totellut Enteriä. Menee 1.:llä ohi!!!!!!!!!!!!!
   if u=4  then                            //<,+120.5n
      {DefsFileen}DebWr(0,'+®+','Oli UPS-click valinta:  / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /');
      //DefsFileen(999,0,'Oli UPS-click valinta:  / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /');
end;//RadGrpClick                          //'³ Vaatii SetFocusin, koklattu, OK =8.0.11.

procedure {Teekutsu}TeeSyoFrm (si :string);      VAR s :string;  u,m :integer;      begin //SI vain kutsukohdan erottamiseen Debugissa.
      sq := sq +' ' +si;                                                    //<Kasvattaa vain SQ´hun kutsupaikkatietoa.
                                      //if (Edv.YLE.SorceCount.arvoInt>1) or (Edv.Sorc[edi].Src.SorceKind.arvoInt<>4)
   SyottoFrm.RadGrp.Items.Clear;                                                               //<,,+8.0.0
   with SyottoFrm.RadGrp  do begin //,,120.5n/6: SJ => Sj  PJ => Pj ..jne.
      Items.Add ('Sj ');
      Items.Add ('Pj ');
      Items.Add ('Vv ');                                                                       //<  +8.0.8 §g
      if (edi=1) and (Edv.YLE.SorceCount.ArvoInt=1)  //<Sorceja vain 1 kpl =Ei rinnakkaisiin UPSia, edi=2 ehto turha (120.5n/6)
         then begin Items.Add ('Ups ');
                    Columns := 4;                                                              //<+120.5n/6
                    Width := 170;  end                                                         //<  +8.0.8 §g
         else begin Columns := 3;                                                              //<+120.5n/6:  Error tuli kun lisäsiJhdn, tämä korjasi.
                    Width := 135;  end;                                                        //<   8.0.8 §g
   end;

   if SrcEdka  then begin                                            //<+10.0.4 :YSP´n meili 4.7.08 Vesa Veijanen.
      m := Edv.Sorc[edi].Src.SorceKind.arvoInt;        //<Sijoitus m:ään +10.0.4 .
      case m of                                        //,,,Asetettava, jotta TeeSyoFrm=>Lado_TeeSyoFrm=>BxItems osaisi..
        1 :u := 0;          //< SJ  =Btn 1    -1=EiKumpikaan=Alustamaton ',,+6.2.10
        2 :u := 1;          //< PJ  =Btn 2
        3 :u := 2;          //< Gen =Btn 3                                                     //<OliTyhjä, 8.0.10
      else u := 3;  end;    //< UPS =Btn 4                                                     //<Oli 2, 8.0.10
      if u>SyottoFrm.RadGrp.Items.Count-1                                                      //<,,+8.0.0
         then SyottoFrm.RadGrp.ItemIndex := SyottoFrm.RadGrp.Items.Count-1
         else SyottoFrm.RadGrp.ItemIndex := u;         //<141.2: Nyt siellä estetty OnClikin ohjaus Lado.. (BxItems´iin).
   end;//if SrcEdka
                                      {  syoKut := 3;  edi := 2;  edikayty := 5;}     //<VAIN KOEKÄYTÖSSÄ, muuten OHAn kulku asettaa #####
//''''''''''''''''''''''''''''''''''''''''##########################################################
   case syoKut of
     1 :s := 'Liittymän 0'+IntToStr (edi) +' tiedot';              //<+edi =8.0.0
     2 :if SrcEdka                                                 //<,+6.2.2
           then begin
              if JkUpsChk_Cap and (JkUpsInt>0)                     //<,,+1412
                 then s := 'Liittymän johdon(/johtojen) ' +{n:o 0' +fImrkt0(edi,1)+}'JÄLKEISEN UPS-lähtöHAARAn tiedot.'
                 else s := 'Liittymän jälkeisen johdon n:o 0' +fImrkt0(edi,1)+' tiedot';  end
           else //s := 'Johto-osan n:o '                  +fImrkt0(edi,1)+' tiedot';
                if JkUpsChk_Cap
                   then s := 'Johto-osan n:o '          +fImrkt0(edi,1)+'/UPS-lähtöhaaran tiedot'
                   else s := 'Johto-osan n:o '          +fImrkt0(edi,1)+' tiedot';
     3 :s := 'Jännitealenema- ja nousujohdon pot.tasaustiedot';    //<Ei enää käytössä -4.0.0
     5 :s := 'Häviökustannustekijöiden käsittely';
     6 :s := 'Rinnakkaisliittymän (0' +IntToStr (edi) +') lisäys/muutos'; //<,+8.0.0
     7 :s := 'Verkon johto-osan ('    +IntToStr (edi) +') lisäys/muutos'; //<'1414b (/muutos)
   end;
   if isDebuggerPresent  then s := '(' +Ints(DlgOli) +':DlgOli)  ' +si +' § ' +s; //<+1412.
   SyottoFrm.Caption := s;
   Lado_TeeSyoFrm (0);    //<ks. I '..\Globals\SyoKut.INC'  =Hoitaa BxArvot -kutsun.  Sulkee apuruudn.
   NormClose := false;    //<FA =alp.syoArvot palautuvat OnClose´ssa ENNEN OnClose, ks. PRC CloseNrm +10.0.4
end;//TeeSyoFrm;          //'#######################################################################

//==================================================================================================
procedure Kuvaus_JkUpsTietoa(si :string);      CONST LF=Chr(10);  VAR sg,su :string;   begin
if isDebuggerPresent  then begin        //<,,+1412. <,,Vain tällaisiin erikoiskäyttöihin.
   //se := EdvNewFrm.KuvausEdit.Text;
   sg := '   ';
   su := si +LF;
   su := su +sg  +'Src[1].JkUps=' +Ints(edv. Sorc[1].Josa.JkUps.ArvoInt) +
                ' oSrc[1].JkUps=' +Ints(edvo.Sorc[1].Josa.JkUps.ArvoInt) +' ///' +
              ' Edka[Edi].JkUps=' +Ints(edv. Edka[Edi].   JkUps.ArvoInt) +
             ' oEdka[Edi].JkUps=' +Ints(edvo.Edka[Edi].   JkUps.ArvoInt);// +'  JkUpsChk_ed= ' +Ints(JkUpsChk_ed);
               //'JkUps:  Src[1]=' +Ints(edv. Sorc[1].Josa.JkUps.ArvoInt) +'oSrc[1]=' +Ints(edvo.Sorc[1].Josa.JkUps.ArvoInt) +' ///' +...
   UpsFileen(su);
   //EdvNewFrm.KuvausEdit.Text := su;
end; end;
//=======================================================================================================================================================

procedure editSyoFrm;      VAR MaxKpl{+8.0.6},i :integer;   boo :boolean{1412}; //########################### Tätä kutsutaan EdvFrm :sta ##########.####

   procedure SijEdvArvot (SrcOsa :boolean);      VAR johja,i,u,os :integer;      begin //+8.0.0
                      {-EdwNewFrm.LisaaBtnClick´issä tarkistettu EDI, että pysyy kurantilla alueella (-1..EdLmax/
                        Sorcja+1 / 1..EdMax/Johtoja+1).
                       -Tähän tullaan EdwNewFrm.LisaaBtnClicki´llä mutta MYÖS Johdot.ButtonClick´illä, JOLLOIN
                        MYÖS SORCJA ja JOHTOJA KASVAA ja NE (koko tietorakenne) KORJATAAN PoistaBtnClick´ISSÄ (?).}
      if SrcOsa //<,,Liittymäosa, sen Josa käsitellään heti seur. ELSE -osassa ===================================
      then begin
       //if NOT LisYliDemo_ (lvEXTended)  then begin //< Alle lvEXT tämä vain ohitetaan = käsitellään Sorc[1]´aa.
            os := Abs (edi);
            johja := a_getIntg (15, edv.YLE.SorceCount);
            if      os>johja                           //<,LISÄTÄÄN LIITTYMÄ muiden jälkeen ========
            then edv.Sorc[edi] := edv.Sorc[edi-1]          //<..eli kopioidaan edellisestä
            else if SyoKut=6                               //< 6=Lisätään SRC  7=Lisätään Edj (7 ei tässä koskaan)+8.0.0
            then for i := johja+1 DownTo edi+1  do     //<,Lisätään LIITTYMÄ muiden väliin =========
            begin
                 u := i;                                   //<,Jostain syystäVaati toisenMuuttujan kuin i´n +8.0.6
                 edv.Sorc[u] := edv.Sorc[u-1];  end;       //<Kopioidaan SORCJA+1´een asti edelliset EDIstä alkaen.
        {end;}end                                          //'SorceCount sij. vasta JOHTO-OSAN sij. JÄLKEEN,,,,
      else begin //<,,Josa TAI Edka -osa =========================================================================
         if SrcEdka
         then begin //<,,################################### LISÄTÄÄN Josa (Liittymän j-osa)######################
            johja := a_getIntg (16, edv.YLE.SorceCount);     //SyoKut: 6=Lisätään SRC  7=Lisätään Edj     +8.0.0
            if      edi>johja                            //<,Lisätään muiden jälkeen ===============
            then edv.Sorc[edi].Josa := edv.Sorc[edi-1].Josa  //<..eli kopioidaan edellisestä
            else for i := johja+1 DownTo edi+1  do begin //<,Lisätään muiden väliin ================
                 edv.Sorc[i].Josa := edv.Sorc[i-1].Josa;     //<Kopioidaan JOHJA+1´een asti edelliset EDIstä alkaen.
                 edv.Sorc[i].Josa.Nimi := edv.Sorc[1].Josa.Nimi; //<[1] määrää rinnakk.johtojen jälkeisen JK-NIMEn
                 if i<99 then ;  end;                        //, Vaikka jos 7, ei tulla tähän, OK.
            if SyoKut in [6,7]  then begin
               SrcKayty := johja+1;                                                              //<+8.0.6
               a_putIntg (17, johja+1, edv.YLE.SorceCount);  end; //<'SorceCount tässä vasta JOHTO-OSAN sij. LOPUSSA
         end
         else begin //<,,################################### LISÄTÄÄN Edka -osa ##################################
            johja := a_getIntg (18, edv.YLE.JohtoOsia);
            if johja=0                                       //<,Ei ole vielä, mitä kopioida =uusi =====<,,+8.0.1
            then begin                                       //<,,...jolloin EDI po. 1 !!!!!!!!!!!!!
              {edi := 1;                                     //<Vaikkakin EdvNew.LisaaBtnClik´ssä tms. jo tarkistettu.
               edv.Edka[1] := tyhA_EdvEdka;  end             //< Vain tätä varten FileEv´ssä alustettu. <''+8.0.1}
               i := edv.YLE.SorceCount.ArvoInt;              //'tyhA_EdvEdka nyt otettu vex:  -8.0.1
               edv.Edka[1] := edv.Sorc[i].Josa;  end         //<Otetaan Src:n vika j-osa [edi=1]:n pohjaksi.
            else if edi>johja                                //<,Kopioiden edellisestä.             +8.0.6
            then edv.Edka[edi] := edv.Edka[edi-1]            //<Lisätään muiden jälkeen ============
           ;{else for i := johja+1 DownTo edi+1  do begin //<,Lisätään muiden väliin ================EhdotVex 8.0.6
               edv.Edka[i] := edv.Edka[i-1];                 //<Kopioidaan JOHJA+1´een asti edelliset EDIstä alkaen. -1414: Lisättäessä 1 tuli 2, korjaus.
               a_putIntg (19, johja+1, edv.YLE.JohtoOsia);   //<Tähän tullaan vain jos 6,7 =LISÄYS.
            end;              //SyoKut: 1 = Edv:n liittymätietojen syöttö<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< }
         end;                 //        2 = Edv:n johto-osatietojen syöttö<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      end;                    //        3 = Uh-rajan + edv:n uh%-osuuden syöttö<<<<<<<<<<<<< Ei käytössä enää >= 4.0.0 :ssa
KoeWInfoA (0,'EditSyoFrm-Sij'); //      5 = Häviökust/NjLaskenta<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   end;//SijEdvArvot          //        6 = Lisätään LIITTYMÄ  alkuun, väliin, kohdalle tai loppuun<<<<<<<<<<<<<
                              //        7 = Lisätään JOHTO-OSA alkuun, väliin, kohdalle tai loppuun<<<<<<<<<<<<<
                              //        8 = Moottorilähtöosan itemit (=MoKut/PaaVal Const)<<<<<<<<<<<<<<<<<<<<<< 6 => 8 = +8.0.0
   procedure YAdd(tab :integer;  si :string);      VAR i :integer;  st :string;   begin //<tab, =Alkusisennys.
                                                       //     {if isDebuggerPresent  then begin //<,,+1412
                                                       //         if fFileExists(YLstFN)  then
                                                       //            YLst.LoadFromFile(YLstFN);}
                                                       //        {st := '';  for i := 1 to tab  do st := st +' ';
                                                       //         YLst.Add(st +si);  YLst.SaveToFile(YLstFN);  end;}
      st := '';  for i := 1 to tab  do st := st +' ';  //         Wrb(st +si); //<Defs.PAS´ssa.
   end;

begin//EditSyoFrm............
sq := '';                 //<SQ = kumul tieto TeeSyoFrm KÄYDYISTA kutsukohdista +141.1 .
//if isDebuggerPresent  then SyottoAvFrm.Close;          //KoeWInfoA (1,'EditSyoFrm-0');
   LaskeeOdFrm.NayLaskeeOdota;
   SyoPeruttu := false;  //< +8.0.10  10.0.4 .
   SrcEdka := false;      //< Merkataan, että käsitellään Edka[] -johto-osaa.
   if edi<0               //,Merkataan, että käsitellään Sorc[] -liittymää.
   then begin
      SrcEdka := true;
      edi := Abs (edi);   //<PeruBtn:lla = tämä palautetaan  //######################################                              ''''''''''''''''''''''
      MaxKpl := edLmaxKpl;                                   //<+8.0.6
      OldSrcja := a_getIntg (15, edv.YLE.SorceCount);  end   //<,Tieto talteen vanhoista rajoista, ks. SyoKut.INC ja edellä PRC SijEdvArvot
   else begin
      MaxKpl := edMaxKpl;                                    //<+8.0.6
      OldSrcja := a_getIntg (17, edv.YLE.JohtoOsia);
   end;
   if (SyoKut IN [6,7]) and (OldSrcja<edLmaxKpl)  then begin //<SyoKut=6 LisätLiitt  n>0 SyoKut=7 LisätJohto, ks. EdvNew.LisaaBtnClick.
      sijEdvArvot (SrcEdka);  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   end;

   JkUpSVex := false;                                      //<+1412:  PoistaBtnClickíssä := TR.
   JkUpsChk_Cap := false;                                 //<+1412:  Kylläkin tarpeeton, lienee AINA automsti FA.
   if SrcEdka
      then JkUpsChk_Box := false                          //<,+1412:  Mrkiksi TeeSyoFrm´iin ettEI  ChkBx näkyviin.
      else JkUpsChk_Box := true;                          //<,+1412:  Mrkiksi TeeSyoFrm´iin että   ChkBx näkyviin.
   DlgOli := 0;                                           //<         Ei tarttis, mutta TeeSyo..´ssa käytössä.
{=}TeeSyoFrm('1/3 A');       //<01 .. Src-Josa tai Edv-Josa  tai SyoKut: 1,2,5,6,7,8.   JNoBtnKlikin JÄLKEEN tähän.======================================

   Hvrt := -1;              //< +3.0.2  Muuttuu vain, kun SyoKut=5 =HävKustKäsittelyssä ##############
   LaskeeOdFrm.Close;                                     //< +3.0.3  ,+6.2.0
   ImpedInfoRich;           //, 1): Liittymätiedot => Johtotiedot => UPS -valinta.
                            //, 2): (NormEdj)..... => Johtotiedot => UPS -valinta.
UpsFileen('EditSyoFrm 1/3 Ae  [' +DateTimeToStr(Now) +']'); //<Tätä ennen on alkupiirtämisten DrawAlas...
   edvo := edv;                                           //<Siltä varalta, että PERUTAAN KESKEN//#######################################################
if SrcEdka
   then JkUpsChk_ed := edv.Sorc[1].Josa.JkUps.ArvoInt     //<,Jos PeruBtnClick, näihin arvoihin palataan, tämä param. pitää DrawAlasUPSj´n oikeana.
   else JkUpsChk_ed := edv.Edka[Edi].   JkUps.ArvoInt;
Kuvaus_JkUpsTietoa('Ennen 1.ShwMod');                     //<Siellä UpsFileen -kutsu.

if edv.YLE.JohtoOsia.ArvoInt <0  then ;
{+}SyottoFrm.ShowModal; {#1}//<,Liittymä- TAI JosaDlg´iin  tai SyoKut: 1,2,5,6,7,8.   ShowModal, jottei esim. seur.edjNo napista pääse ulos=-6.2.x
UpsFileen('EditSyoFrm 1/3 Aj');
//,,+1412: 11=SjDlg  12 PjDlg  13=VvDlg  14=UpsDlg  2=JosaDlg  5=HävDlg  7=JkUpsDlg :Nämä arvot sijoitettiin BxItems´issä =kertoo missä dlg´ssä oltiinJust.
//:::::::,Tähän tullaan Src:n (ed)ShowModal´in jälkeen Josa JA/TAI JkUps-tietokyselyyn.##################################################################
//:::::::,         1=JoOk, |++Kysyttävä++++  ++++++|                    5=JoOK,,,,,  6=JoOK,,,,,,,,,  7=JoOK,,,,,,,,,,  8=JoOK,,,,,,, =JoOK=Käsitelty=Valmiit
//:::::::,SyoKut:  1=Liitt  +JkUps   2=EdvJ  +JkUps  (3=Uh-raj eiEnää)  5=Häviökust  6=LisätLIITTYMÄ  7=LisätJohto-osa  8=MoottItemit ###################
                                                 //if isDebuggerPresent  then WBeep([1200,50, 1200,50, 200,1500]);
//=======================================================================================================================================================
(*                                                        //1412: Liit- tai JosaArvoDlg oli just edellä:  Sorcelle seur on JOSA-Dlg, edvJosalle UpsArvoDlg.
{2}boo := SrcEdka  and NOT SyoPeruttu and (SyoKut IN [1,6]) and
          NormClose  OR NOT SrcEdka and (JkUpsChk_ed=0);  //<1412:  Muuten tulee 2. JkUpsDlg, todettu.
{2}if boo  then begin*)

{2}if DlgOli IN [11..14,2]  then begin                    //<,+1412:  Sj,Pj,VV,Ups, 2=Josa
{2}  if NOT SrcEdka  then
     if JkUpsChk_Dlg                                      //<,+1412:  Oltiin klikattu JkUpsChkBx´ia JosaDlg´ssä. Muuten ei DrawAlasJohto -käskyn param OK.
{2}     then edv.Edka[Edi].JkUps.ArvoInt := JkUpsInt
{2}     else edv.Edka[Edi].JkUps.ArvoInt := 0;

{2}  if SyoKut=1  then SyoKut := 2;                       //<Sorc´n Josa -tietojen syöttöön, ed.ShowModal´issa kysyttiin Sorce, seur. sen Josa.
{2}  if (SyoKut IN [6,7]) and (OldSrcja<MaxKpl)  OR SrcEdka{???}  then //<Jos oli jo max, osoitti kopioinnin +1 liikaa. +8.0.6   Ei kylläkään 7´lla tänne, vrt. ed.
{2}     sijEdvArvot (FALSE); //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'+6,7 =+8.0.6
{2}                          //,,JkUpsChk_Dlg := VAIN PRC JkUpsChkMouseUp´ssa,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
{2}  if SrcEdka  then begin  //Silloin AINA JosaDlg´hen//<,+1412:  Sorc´elle JosaDlg.########################################################################
{2}     JkUpsChk_Cap := false;                            //<,+1412:  Mrkiksi TeeSyoFrm´iin että Caption´iin muu kuin UPS -teksti =ohjaa SijBtns JosaDlg´lle.
{2}     JkUpsChk_Box := true;   end                       //<,+1412:  Mrkiksi TeeSyoFrm´iin että ChkBx näkyviin (SijBtns´lle)     =ohjaa SijBtns UpsChk´n.
{2}  else begin                     //<,, Edj´lle JkUpsChk_Dlg mahd. klikattiin 1/3´ssa =PRC SijBtn´lle + Lado_TeeSyoFrm´lle tieto, että seur halutaan JkUpsChk_Dlg.
{2}     JkUpsChk_Cap := true;                             //<,+1412:  Mrkiksi TeeSyoFrm´iin että Caption´iin UPS -teksti          =ohjaa SijBtns UpsDlg´lle.
{2}     JkUpsChk_Box := false;  end;                      //<,+1412:  Mrkiksi TeeSyoFrm´iin ettEI ChkBx näkyviin (SijBtns´lle, oli jo edShowModal´issa).
{2}
{2}  boo := SyottoFrm.JkUpsChk.State=cbChecked;       //,,+1412: JkUpsChk_Dlg oli edvJosan Dlg´ssä ChkBx´iin klikattu TR => seur Dlg´hen Chk_Bx näkyviin.
{2}  if NOT SyoPeruttu and (SrcEdka OR JkUpsChk_Dlg OR boo)  then begin
{=}    TeeSyoFrm('2/3 B');                            //<'+1412:  Sorc´elle JosaDlg TAI edvJosa´lle JkUpsDlg =jos klikattu.##############################
UpsFileen('EditSyoFrm 2/3 Be');
{+}    SyottoFrm.ShowModal; {#2}                          //<Aukesi SrcJosaDlg tai edvJosan JkUps´in arvotDlg (JkUpsDlg) => DlgOli := 7.

UpsFileen('EditSyoFrm 2/3 Bj');
{2}    if NOT SrcEdka and JkUpsVex                        //<JkUpsDlg´ssä PoistaBtnClik.
{2}       then edv.Edka[Edi].JkUps.ArvoInt := 0;          //<'+1412.
UpsFileen('EditSyoFrm 2/3 Bj+');
{2}
{3 =====================================================================================================================================================}
//,,Tänne vain SrcEdka -tapaus JA JOS JkUpsChk_Dlg (=JkUps valittu). ,.._Cap tarvitaan SyoKut.INC´ssä.
{3}     JkUpsChk_Cap := true;                                          //<Ettei enää ohjaa väärin mm. Frm.CaptionTxt´iä eikä seur TeeSyoFrm´ia ellei UPS valittu.
{3}     JkUpsChk_Box := true;              //<,,+1412: Nämä vain Sorce´lle. Nyt vasta Sorcen Josa´n JkUps -tiedot, ei jos JkUpsChk´sta klikattu ruksi vex.
{3}     if SrcEdka  then begin
{3}        if JkUpsChk_Dlg  OR (JkUpsInt>0) {SyottoFrm.JkUpsChk.Visible}
{3}        then begin
{3}           if JkUpsChk_Cap and NOT SyoPeruttu
{3}           then begin
{=}              TeeSyoFrm('3/3 C');                                    //<SrcJ JOHTOtietojen Dlgn tekoon. Jos Ups klikataan => JkUpsChk_Dlg saa arvot.
{3}              //edvo := edv;  Palautus PRC´n tulon tilanteeseen.     //<Siltä varalta, että PERUTAAN KESKEN//#########################################
UpsFileen('EditSyoFrm 3/3 Ce');
{+}              SyottoFrm.ShowModal; {#3} //<Aukesi SrcJ JOHTOtietojen Dlg. Tässä vasta kysytään tieto onko SorceJ´llä JkUps eli ei.==========================
UpsFileen('EditSyoFrm 3/3 Cj');
{3}              if JkUpsVex
{3}              then for i := 1 to edv.YLE.SorceCount.ArvoInt  do         //<,,JkUpsInt := PRC UpsChkMouseUp´issa.
{3}                      edv.Sorc[i].Josa.JkUps.ArvoInt := 0               //<Kaikissa Srs´ssa sama tieto, onko UPS-laite(1) vai 0.
{3}              else for i := 1 to edv.YLE.SorceCount.ArvoInt  do         //<,,JkUpsInt := PRC UpsChkMouseUp´issa.
{3}                      edv.Sorc[i].Josa.JkUps.ArvoInt := JkUpsInt;//JkUpsChk_ed;    //<Kaikissa Srs´ssa sama tieto, onko UPS-laite(1) vai 0. TÄMÄ SIJOITUS USEIMMIN.
{3}                    //§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
{3}           end else //§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
{3}              for i := 1 to edv.YLE.SorceCount.ArvoInt  do              //<,,JkUpsInt := PRC UpsChkMouseUp´issa.
{3}                 edv.Sorc[i].Josa.JkUps.ArvoInt := 0                    //<Kaikissa Srs´ssa sama tieto, onko UPS-laite(1) vai 0.
{3}        end else
{3}           for i := 1 to edv.YLE.SorceCount.ArvoInt  do                 //<,,- " - Tämä kun oltiin SrcDlg´n JosaDlg´ssä klikattu JkUpsChk´sta ruksi vex.
{3}              edv.Sorc[i].Josa.JkUps.ArvoInt := 0;                      //<Kaikissa Srs´ssa sama tieto, onko UPS-laite(1) vai 0.
UpsFileen('EditSyoFrm 3/3 Cj');
{3}     end;//if SrcEdka
{3}  end;//if JkUpsChk_Dlg or ..
{>}end;//if SrcEdka  and NOT (2)
                                                //if (sq<'')  then ;       //<Debuggitietoa. SQ kertoo käydyt TeeSyoFrm -kohdat.
end;//EditSyoFrm
//==================================================================================================
function edvPvitOK :boolean;      var i,o,k :integer;   ar,ur,Rs,Zs,Ik1v :real;   fnc :boolean;  s :string;   begin
  fnc := true;  //,,,,,,BxArr GLOBAALI vain TÄTÄ VARTEN (???)#######''o +1.1.5 #####################
  o := 0;  if syoKut IN [2,7]  then o := 20;//< +1.1.5 =Vain edvn OKbtnTarkistuksissa ##############

  for i := 1 to BxMaxRv  do                 //begin Y_Koe(2,'PvitOK-tarkistus, rivi '+fImrkt0(i,1)); +6.0.3
    if BxArr[i]  then                                                                             //<+6.0.3
    if NOT arvoOK (i+o,syoKut)  then begin  //< +1.1.4 = i+20 =OKbtnMouseUp -tarkistuksissa ##########
    //HerjaInfo ('Rivi '+fImrkt0(i,1)+':   Ristiriitainen tai puuttuva arvo.'); //<Herja jo FNC arvoOKssa
      o := i;                               //<FocusBak_ osoite talteen +3.0.0
      fnc := false;   Break;  end;

  if fnc  then
  case syoKut of
 1,6:case SyottoFrm.RadGrp.ItemIndex of           //<Edv:n liittymätietojen syöttö<<<<<<<<<<<<<<<<< UUSITTU 6.2.8
     0 :begin                                     //< 0=SJ  1=PJ-liittyjä  3=VV §g  2 §g(3)=UPS  -1=Ei mikään=EiOletusta.
           ar := a_getIntg (112,Edv.Sorc[edi].src.Smn);
           ur := fUn;
         (*if SyottoFrm.PanelY.Visible and (Yvrk[18]{U2}*1000=fUn) and (Yvrk[16]{Sm}*1000<>ar)  then
              EiOkInfo ('Apulaskentaruudun muuntajakoko (Sm, rivi 6) poikkeaa liittymäikkunan muuntajan koosta, '+
                        'Tarkista valinnat.');
           end*)
           if SyottoFrm.CyBx11.Visible and (Abs(Yvrk[18]{U2}*1000-ur)<1) and (Yvrk[16]{Sm}*1000<>ar)  then
          {if (MessageDlg ('Apulaskentaruudun muuntajakoko (Sm, rivi 6) poikkeaa liittymäikkunan muuntajan koosta, '+
                        'Haluatko tarkistaa (Yes) vai jatketaanko (No) ?', mtInformation, [mbYes,mbNo], 0) = mrYes)}
           if InfoDlg ('Apulaskentaruudun muuntajakoko (Sm, rivi 6) poikkeaa liittymäikkunan muuntajan koosta. '+
                       'Haluatko tarkistaa vai jatketaanko ?',                                      //<+6.2.2
                       mtCustom, 'Tarkista','Jatka','','',
                                 'Palataan tarkistukseen' ,'Jatketaan tarkistamatta','','') = 1
              then fnc := false;
           if fnc  then Edv.Sorc[edi].src.SorceKind.arvoInt := 1; //<1=Transformer  2=LV-Cable  3=Generator  4=UPS. +6.2.2
        end;
     1 :begin                                                     //< 1=PJ-liit
           o := 3;                                                          //<Palautus mahd. tälle riville = eRs
           Rs := a_getReaa (112, Edv.Sorc[edi].src.pjLiitRs);               //<  Rs
           Ik1v := a_getReaa (113, Edv.Sorc[edi].src.Iks1v);                //<  Iks1v
           Zs := fLas_Iks1v_Zs (Ik1v{Iks1v});                               //< +3.0.2
           if Rs<=0
           then begin
              k := InfoDlg ('Liittymäverkon eRs -arvoksi on annettu 0, jolloin koko impedanssi on reaktanssia '+
                            '(eXs=eZs =' +fRmrkt0 (Zs/3,1,8) +' ' +FONT_OMEGA +'), oletko varma?',
                   mtCustom,  'Kyllä','Peru','','',  '','','','');
              if k IN [2,9]                              //<"Peru"
              then fnc := false
              else begin                                 //<"Kyllä" = eRs=0 => eXs=eZs  =Lasketaan eXs
                 ar := Sqrt (Ik1v) /3;                                      //<  Xs  = V¨(Zs²) /3.
                 Edv.Sorc[edi].src.pjLiitXs.arvoRea := ar;  end; end
           else begin
              ar := 3*Rs;                                                   //<,+1414f Sqrt
              ur := ((Zs-ar)/Zs)*100;                                       //<,,Y_.PAS´ssa yritetty jo estää ettei olisi Xs pahasti pielessä.
              if ur<0                                                       //<,Jos <0, tulisi "floating point invalid oper.."
                 then ar := Zs*0.001;                                       //< AR´ksi 0.1% Zs eli 1 promille.
              ar := Sqr (Zs) - Sqr (ar);                                    //<  Xs² = Zs² - Rs².  3* =+4.0.1
              ar := Sqrt (ar) /3;                                           //<  Xs  = V¨(Xs²). /3=+4.0.1, 6.2.13

              if (ar<0) or NOT SijSRajAlkio (fRmrkt0 (ar,1,8), Edv.Sorc[edi].src.pjLiitXs) //< ar<0 = Rs liian iso
             {if (ar<0) or (Edv.Sorc[edi].src.pjLiitRs.arvoaRea<=0) or
                 NOT SijSRajAlkio (fRmrkt0 (ar,1,8), Edv.Sorc[edi].src.pjLiitXs)}
                 then fnc := false;                               //'SijSRaj.. tarkistaa ala/ylärajat + sijoittaa

              if NOT fnc  then begin //<,,4.0.1 :ssä riisuttu Ik -laskentavertailu. Nyt pelkkä FNC -tarkistus ######
                 s := 'Liittymäverkon eRs -arvo virheellinen; <b>liian iso annetulle Ik1v :lle.</b><br>'+
                      '   <b>Max arvo eRs = ' +fMrkvia (Zs,10) +' ' +FONT_OMEGA +', korjaa!</b><br>';
                 s := s +'   Annetussa eRs :n komponentissa saattaa olla mukana IEC :n laskentamenetelmän '+
                         'mukainen kerroin 3, kokeile jakamalla eRs -arvo 3 :lla tai tarkista asia '+
                         'verkkoyhtiöltä.';
                 HerjaInfo (s);  end;
           end;
           if fnc  then Edv.Sorc[edi].src.SorceKind.arvoInt := 2; //<1=Transformer  2=LV-Cable  3=Generator  4=UPS. +6.2.2
        end;
     2 :begin                                              //< 2=VV                                 8.0.8 §g
           Edv.Sorc[edi].src.SorceKind.arvoInt := 3;       //<1=Transformer  2=LV-Cable  3=Generator  4=UPS.
           Edv.Sorc[edi].src.pjLiitRs.arvoRea := 0;
           Edv.Sorc[edi].src.pjLiitXs.arvoRea := 0;   end;
     3 :begin                                              //< 3=UPS (oli 2)                        8.0.8 §g
           Edv.Sorc[edi].src.SorceKind.arvoInt := 4;       //<1=Transformer  2=LV-Cable  3=Generator  4=UPS.
           Edv.Sorc[edi].src.pjLiitRs.arvoRea := 0;
           Edv.Sorc[edi].src.pjLiitXs.arvoRea := 0;   end;
     end;//case
 2,7:begin                   //<Edv:n johto-osatietojen syöttö<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
     //with edv.edka[edi]  do if (a_getStrg (121,tyyppi)='SVjärjest.') and (a_getIntg (122,lukumaara)>1) //< -6.0.2
     //Edv.Sorc[1].src. ... [1...] Huomioitava myös tässä                                          +6.2.2
       with edv.edka[edi]  do
         if fOnSV (a_getStrg (121,tyyppi)) and (a_getIntg (122,lukumaara)>1)
         then begin fnc := false;  o := 5;           //< +3.0.0  o := 5
                    HerjaInfo ('SVjärjestelmälle rinnakkainasennus ei sallittu');  end //<' +1.1.4  ,,+6.2.16  ,,-6.2.19
        {else if (    fAlCu (a_getStrg (123,tyyppi)) and (a_getIntg (124,lukumaara)>1) and (a_getReaa (125,Amm2)<150))  OR
                 (NOT fAlCu (a_getStrg (123,tyyppi)) and (a_getIntg (124,lukumaara)>1) and (a_getReaa (125,Amm2)<120))
         then begin fnc := false;  o := 3;
                    HerjaInfo ('Pienille poikkipinnoille(Al<150, Cu<120) rinnakkainasennus ei sallittu');  end; //<''+6.2.16}
         else if (    fAlCu (a_getStrg (123,tyyppi)) and (a_getIntg (124,lukumaara)>2) and (a_getReaa (125,Amm2)<150))  OR
                 (NOT fAlCu (a_getStrg (123,tyyppi)) and (a_getIntg (124,lukumaara)>2) and (a_getReaa (125,Amm2)<120))  OR
                 (    fAlCu (a_getStrg (123,tyyppi)) and (a_getIntg (124,lukumaara)>1) and (a_getReaa (125,Amm2)< 16))  OR
                 (NOT fAlCu (a_getStrg (123,tyyppi)) and (a_getIntg (124,lukumaara)>1) and (a_getReaa (125,Amm2)<  6))
         then if InfoDlg ('SFS 6000 ei rajoita, mutta A1-89 rajoitti minimi-mm²:  Jos Kpl ' +FONT_SUURPI +
                          '3, mm² p.o. '+FONT_SUURPI +'Cu 120/Al 150   tai  jos Kpl ' +FONT_SUURPI +
                          '2, mm² p.o. '+FONT_SUURPI +'Cu 16/Al 25.<br>' +
                          'PALAATKO KORJAAMAAN VAI JATKETAANKO?',
                          mtCustom, 'Korjaukseen','Hyväksy','','',  '' ,'','','')=1
                  then begin fnc := false;  o := 3;  end;                                     //<'' +6.2.19

       if NOT SrcEdka and  fnc and (edi>0) and (edi>edikayty)  OR    //< +1.1.4 = +fnc and ..
              SrcEdka and  fnc and (edi>0) and (edi>srckayty)  then  //<  +8.0.0  NOT SrcEdka and (edi>0) =+6.2.6
       if SrcEdka                                                    //<,,+8.0.0
       then begin
          srckayty := edi;
          a_putIntg (11,srckayty, edv.YLE.SorceCount);
          for i := 1 to edi  do                                                                 //<,+8.0.0
             edv.Sorc[i].Src.OnArvot :=  true;
          for i := 1 to edi  do
             edv.Sorc[i].Josa.OnArvot := true;  end
       else begin                                                  //<,,-1414:  (1.) sijEdvArvot´ssa on myös, joten kasvaa 2´lla kun saiai olla vain 1.
          edikayty := edi;
          a_putIntg (11,edikayty, edv.YLE.johtoOsia);   //<Onkohan muualla(kin) vanhassa sorcessa ??
          for i := 1 to edi  do
             edv.edka[i].OnArvot := true;
       end;//}
     //if fnc and (edi=1) and  NOT a_getBool (122,edv.edka[edi].PTlopussa)  then //<OnArvo juuri ehkä asetettiin TRUE
       if fnc and SrcEdka {and (edi=1) }and  NOT a_getBool (122,edv.Sorc[edi].josa.PTlopussa)  then //<OnArvo juuri ehkä asetettiin TRUE.  130.2e: -edi=1
          if InfoDlg ('Ensimmäisen pääjohdon lopussa on yleensä pääkeskus, missä PÄÄPOT.TASAUS. '+  //+6.2.2  9.0.1
                      'Palataanko korjaamaan PotTas -valintasi?',
                      mtCustom,  'Ei palata','Palaa','','',  '','','','') IN [2,9]
          then begin  fnc := false;  o := 8;  end;      //< +3.0.0  o := 8

       i := fPEkEkaJ; //<Eka johto-osa, jossa PT. Jos Sorc:n johtojen lopussa = 0 (=PK:ssa), -1 jos ei ollenkaan.
     //if fnc and ((edi=1) or (edi<=i)) and (a_getReaa (123,edv.edka[edi].PEker) <1) //<-6.2.6
       if fnc and ( SrcEdka and (i=0)  or  NOT SrcEdka and (edi>0) and (edi<=i) )    //<,,+6.2.6,,,,,,,,,,,,,,,,,
       then begin                                         //'Sorc:ssa sekä edka[1..edi<=i].PEker po. 1
          o := -1;                                        //<Muuttuu jos löytyy PEker<1
          if SrcEdka
          then begin
             for k := 1 to edv.YLE.SorceCount.arvoInt  do
             if edv.Sorc[k].Josa.PEker.arvoRea < 1  then begin
                o := k;  Break;  end;  end
          else begin
             for k := 1 to edv.YLE.JohtoOsia.arvoInt  do
             if edv.Edka[k].PEker.arvoRea < 1  then begin
                o := k;  Break;  end;
          end;
          if o>-1  then begin
             Herjainfo ('Ennen ensimmäistä pot.tasausta ei PE-johtimen ohitusta huomioida, PEker '+
                        'p.o. 1.00, korjaa!');
             fnc := false;  o := 9;           //< +3.0.0  o := 9   <,-6.2.6
             SyottoFrm.ComBx9.SetFocus;  end; //<Fnc -ehto, ettei mahd.aiempi SetFocus ohitu}  //<''-6.2.6
         {if o>-1  then begin
             Herjainfo ('Ennen ensimmäistä pot.tasausta ei PE-johtimen ohitusta huomioida, PEker '+
                        'p.o. 1.00, NOLA korjaa arvon automaattisesti, OK');
             if SrcEdka
             then for k := 1 to edv.YLE.SorceCount.arvoInt  do
                      edv.Sorc[k].Josa.PEker.arvoRea := 1
             else edv.Edka[edi].PEker.arvoRea := 1;
          end;} //<''Ei sittenkään korjata automaattisesti jos vaikka käyttäjä haluaisi korjata muutakin.
       end;                                                                          //<''+6.2.6'''''''''''''''''
     end;
{ 3 :with edv.NjL  do begin  //,Uh-rajan + edv:n uh%-osuuden syöttö<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< -4.0.0  EiEnää
       ar := a_getReaa (12,yhtUhRaja);   rr := a_getReaa (13,EdUhOsa);
       if ar - rr < 0.01
          then begin  fnc := false;  o := 1;            //< +3.0.0  o := 1
                      HerjaInfo ('Jännitealenemaero <0.01 liian pieni.');  end
          else a_putReaa (14,ar-rr,NjUhRaja);
     end;                                               //'Muut param tarkistettiin ARVOOKssa <<<<<<}
{ 5 :begin                   //<HavKust syöttö <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//< +3.0.0
       ar := a_getReaa (12,Nj.Hav.TotPh);
       if ar<Ptas[1]
          then begin  fnc := false;  o := 12;
                      HerjaInfo ('Kiinteistön kokonais-Ph pienempi kuin käsiteltävä Ph.');  end;
     end;                                               //'Muut param tarkistettiin ARVOOKssa <<<<<<}
  end;//case
  if NOT fnc  then FocusBak_(o);
  Result := fnc;
end;//edvPvitOK
//==================================================================================================
procedure TSyottoFrm.PoistaBtnClick(Sender: TObject);      VAR i,s,e,nVe,val :integer;  ss :string;      begin
   s := a_getIntg (11, edv.YLE.SorceCount);
   e := a_getIntg (12, edv.YLE.JohtoOsia);                                              //,,-1411: <,,Muutosalue ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

   nVe := 0;
//UpsFileen('PoistaBtnClick 1');

 if (Pos('UPS-',AnsiUpperCase(SyottoFrm.StrGr1.Cells[0,1])) >0) {and
    (SrcEdka and (edv.Sorc[1].Josa.JkUps.ArvoInt>0)  OR NOT SrcEdka and (edv.Edka[Edi].JkUps.ArvoInt>0)) //<,+141.2}
 then begin
    ss := 'Haluatko poistaa / kumota  UPS-lähtöhaaran jakokeskuksesta ?';
    val := InfoDlg (ss, mtCustom, 'Poista/Kumoa','Peru','','',  '' ,'','',''); //Kyllä=1, Peru=2, X=9.
    if val=1 then begin
       JkUpsVex := true;               //<+1412:  EitSyoFrm´issa sijoitukset ..JkUps.ArvoInt := 0;
       CloseNrm (Sender);              //<Asettaa NormClosen TR, jottei edv := edvo;  OKclick ainoa jolle EditSyoFrm:ssa
    end;
 end//if Pos('UPS-'..
 else begin
   if SrcEdka  then ss := 'Haluatko poistaa liittymän N:o 0' + fImrkt0 (edi,1) +' ?'
               else ss := 'Haluatko poistaa johto-osan N:o ' + fImrkt0 (edi,1) +' ?';
 //if SrcEdka and (edi>=2) and (s>=edi+1) OR NOT SrcEdka and (e>=2)                       //<1411: Edin jälkeenkin vielä johtoja. EiOK jos edi=edja =tarjosi "..loputkin"
   if (edi>=2) and (SrcEdka and (edi<s)  OR NOT SrcEdka and (edi<e))                      //<1414b: Edin jälkeenkin vielä johto-osia.
   then begin
      ss := ss +' vai myös sen jälkeiset ';
      nVe := 2;
      if SrcEdka
      then begin  ss := ss +'liittymät ... ';
                  if edi=1  then i := s-1
                            else i := s;
                  ss := ss +'0' +IntToStr (i);
                //if (edi>=2) and (s>=3)  then begin  ss := ss +' (viimeinen liittymä jätetään)';  nVe := 2;  end;
       end
       else begin
                  ss := ss +'johto-osat ... ' +IntToStr (e);  end
   end//if SrcEdka and (edi>=2) and (s>=edi+1) OR NOT SrcEdka and (e>=2)                            //<1411: Edin jälkeenkin vielä johto-osia.
   else if SrcEdka and (s>=2) and (Edi=s) OR NOT SrcEdka and (e>=2) and (Edi=e)                     //<1411: Jos vikan kohdalla =Vain yksi poistomahis.
        then nVe := 1;
   ss := ss +'?';

   if nVe IN [0,1]  //<0,1 =Poista tämä  2 =Poista loputkin.
   then val := InfoDlg (ss, mtCustom, 'Kyllä','Peru','','',  '' ,'','','')
   else val := InfoDlg (ss, mtCustom, 'Poista tämä','Poista loputkin','Peru','',  '' ,'','','');
        //Valittu:    ,1="Poista tämä"               ,2="Poista loputkin"
   if (nVe IN [0,1]) and (val=1)  OR  (nVe=2) and (val IN [1,2])  then begin //<Joku poisto valittu.
      Screen.Cursor := crHourGlass;      //<Ilman SCREENiä vipattaa!!!                 //''-1411: <''Muutosalue '''''''''''''''''''''''''''''''''''''''''
      SyottoFrm.Close;                   //<+1412: Oli otettu vex, JOsan poisto ei onannut.  +1414: +SyottoFrm.
      SyottoAvFrm.Hide;
      edv := edvo;                       //<Palautetaan ekax edeltävä tieto.                        +8.0.0
      if val=1                           //<Valittu YKSI poistettava, ketjun vika tai välistä yksi vex.
      then begin
         if SrcEdka
         then begin                      //<,,Liittymätiedot,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
            SyoPeruttu := true;          //<FA estäisi johtotietokyseyyn menon +8.0.10
            for i := edi to edLmaxKpl-1  do
               edv.Sorc[i] := edv.Sorc[i+1]; //<Siirretään loppupäätä -1.
            edv.Sorc[s].Josa.OnArvot := false;                            //<,Aikaisempi vika Josa FA.
            edv.Sorc[s].Src.OnArvot :=  false;                                                   //<+8.0.0
            if s>0  then begin                                            //<Varm.vuoksi ehto.
               srckayty := s-1;
               a_putIntg (13,srckayty, edv.YLE.SorceCount);  end;
          PvitaEdvFrm;                                                  //<+1414:  Hoitaa koko edvNewFrm´in päivittämisen.
         end
         else begin
            for i := edi to edMaxKpl-1  do
               edv.Edka[i] := edv.Edka[i+1];                              //<Siirretään loppupäätä -1.
            edv.Edka[e].OnArvot := false;                                 //<Aikaisempi vika (e) FA.
            if e>0  then begin                                            //<Varm.vuoksi ehto.
               edikayty := e-1;
               a_putIntg (14,edikayty, edv.YLE.JohtoOsia);  end; end;  end//<JohtoOsia pienenee 1:llä.
      else begin                         //<Valittu tämä + loputkin poistettaviksi.#################
         if SrcEdka
         then begin
           SyoPeruttu := true;           //<FA estäisi johtotietokyseyyn menon +8.0.10
            if edi=1
            then begin                   //<Jos poistettava kaikki 1. muk.luk., jätetään vika    <,,+8.0.0
               edv.Sorc[1] := edv.Sorc[s];                 //<Siirretään vika ekaxi ja muut vex
               for i := 2 to edLmaxKpl  do edv.Sorc[i].Josa.OnArvot := false;
               for i := 2 to edLmaxKpl  do edv.Sorc[i].Src.OnArvot :=  false;
               SrcKayty := 1;
               a_putIntg (14,SrcKayty, edv.YLE.SorceCount);  end
            else begin
               for i := edi to edLmaxKpl  do edv.Sorc[i].Josa.OnArvot := false;
               for i := edi to edLmaxKpl  do edv.Sorc[i].Src.OnArvot :=  false;                  //<+8.0.0
               SrcKayty := edi-1;
               a_putIntg (16,SrcKayty, edv.YLE.SorceCount);  end; end
         else begin
            for i := edi  to edMaxKpl  do edv.Edka[i].OnArvot := false;
            EdiKayty := edi-1;
            a_putIntg (17,EdiKayty, edv.YLE.johtoOsia);  end;

      end;
      //edvo := edv;   //<Koska OnClosessa kun SyoPeruttu=TR => edv := edvo -8.0.10
   end;//if (nVe=...   //'-1412.
 end;//if Pos('UPS-'..) ELSE
   Screen.Cursor := crDefault;
//UpsFileen('PoistaBtnClick 9');
end;//PoistaBtnClick
//==================================================================================================
procedure TSyottoFrm.OhitaBtnClick(Sender: TObject);      begin
   inherited;
   if SyoKut=5
      then LisYliDemo_Info (lvPRO);   //<Ilmoittaa demotoiminnasta jos lisenssi < lvPRO  =+7.0.1
   Hvrt := 0;   //< +3.0.2
// Screen.Cursor := crHourGlass;      //<Ilman SCREENiä vipattaa!!!
   CloseNrm (Sender);                 //<,+-10.0.4
 //Close;
   SyottoAvFrm.Hide;
// Screen.Cursor := crDefault;
end;

//==================================================================================================
{######## TARKISTUS MYÖS OnDeactivate -tapahtumassa, jotta mahista SIIRTYÄ SEUR.JOHTO-OSAAN #######}
procedure TSyottoFrm.OkBtnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);      begin
   inherited;
  {if IsDebuggerPresent and (Pos ('Debug:',OkBtn.Hint)=0)  then
      OkBtn.Hint := OkBtn.Hint +' Debug:  Ctrl+Shft +Klik = Putsaa KoeFrm´n,..+Alt = Fileen.';}
end;

procedure TSyottoFrm.OkBtnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);
begin                                              //'12.0.0:  BtnClick muutettu OkBtnMouseUp´ksi, jotta saadaan
   inherited;                                      //          KoeFr.Rich1 putsatuksi.
   if IsDebuggerPresent  then begin
      if (ssCtrl IN Shift) and (ssShift IN Shift) and (ssAlt IN Shift)
         then KoeFrm.TulostBtnMouseDown(Self,mbLeft,[ssAlt,ssLeft], 1,1)  //<Tulostus fileen.
         else if (ssCtrl IN Shift) and (ssShift IN Shift)                 //<Tämä ei voi olla ekana.0
              then KoeFrm.Rich1.Lines.Clear;  end;                        //<''+12.0.0
   if SyoKut=5                        //<Häviökust.
      then LisYliDemo_Info (lvPRO);   //<Ilmoittaa HavKust :n demotoiminnasta jos lisenssi < lvPRO  =+7.0.1
   Screen.Cursor := crHourGlass;      //<Ilman SCREENiä vipattaa!!!
   if edvPvitOK  then begin           //<Siellä kasvaa Josat.(1414)
      CloseNrm (Sender);              //<Asettaa NormClosen TR, jottei edv := edvo;  OKclick ainoa jolle EditSyoFrm:ssa
      SyottoAvFrm.Hide;  end;         //'NormClose -ehto määrää uuden FyottoFrm´in edit. =uusi TeeSyoFrm -kutsu.
   Screen.Cursor := crDefault;
   if SyoKut=5
      then Hvrt := 1;
   AvuChkSft (10);                                               //<SyoAktv FA
 //SyoPeruttu  := false;              //<FA ohjaa mahd. johto-osan kyselyyn +8.0.0.  Tarpeeton -8.0.10
  {laskeEdvArvotOk (1);               //<,,+6.2.x Siirretty Johdot.PAS´ista
//£$£u -1412   EdvNewFrm.UpdateValues;            //<  +6.2.x oli EdvNew:ssa:  TEdvNewFrm(owner).UpdateValues;}
end;

procedure TSyottoFrm.PeruBtnClick(Sender: TObject);      begin //Toiminnat siirrty FormCloseen 10.0.4 .
   if eri_cU_Un                                                   //<Ei väliä oli SyoKut mikä vaan,
   then beep                                                      //'sijoitettiin PRC editSyoFrmssa.
   else begin                         //, -8.0.0  OnClosessa sij. //<Palautetaan edeltävä tieto, joka
//      UpsFileen('PeruBtnClick 1');                              //'sijoitettiin PRC editSyoFrmssa.
      Kuvaus_JkUpsTietoa('PeruBtnClick 1 _____________'); //<+1412
      edv := edvo;                                                //<+1212.
      if SrcEdka                                                  //,,Nämä koska JkUps.ArvoInt ei pysy ajan tasalla PeruBtn -tapauksessa, todettu.
         then edv.Sorc[1].Josa.JkUps.ArvoInt := JkUpsChk_ed
         else edv.Edka[Edi].   JkUps.ArvoInt := JkUpsChk_ed;
      JkUpsInt := JkUpsChk_ed;
      SyoPeruttu := true;                                         //<VAIN TÄSSÄ: TR merkiksi että perutaan syöttöarvot +8.0.10
      SyottoFrm.Close;                                            //<+1412: SyottoFrm.
     {SyottoAvFrm.Hide;   }                                       //<-1412.
      Kuvaus_JkUpsTietoa('PeruBtnClick 9 _____________'); //<+1412
   end;
   if SyoKut=5
      then Hvrt := -1;                //<Paluuohjeen merkiksi
   AvuChkSft (10);                    //<SyoAktv FA  +6.0.0 Ei vapauttanut aikais. versiossa.
//   UpsFileen('PeruBtnClick 9');
end;//SuljeBtnClick

{#######,Tässä jotta mahista SIIRTYÄ SEUR.JOHTO-OSAAN. TARKIST MYÖS OKbtnClick -tapahtumassa.#######}
{procedure TSyottoFrm.FormDeactivate(Sender: TObject);       begin
  if ActiveControl<>PeruBtn  then
     edvPvitOK;
end;}

procedure TSyottoFrm.FormActivate(Sender: TObject);                    //<Tapahtuu myös FrmCreatillä
  procedure sij(Rv :integer);      begin
    if syoAvOn  then begin avust(1,Rv,syoKut);  avuChkSft (11);  end; end; //<1.1.4 Chckd -> syoAvOn
begin//FormActivate
   if syoAvOn  then syoAktv := false;                                      //<1.1.4 Chckd -> syoAvOn
   if ActiveControl=ComBx1  then sij(1)  else
   if ActiveControl=ComBx2  then sij(2)  else
   if ActiveControl=ComBx3  then sij(3)  else
   if ActiveControl=ComBx4  then sij(4)  else
   if ActiveControl=ComBx5  then sij(5)  else
   if ActiveControl=ComBx6  then sij(6)  else
   if ActiveControl=ComBx7  then sij(7)  else
   if ActiveControl=ComBx8  then sij(8)  else
   if ActiveControl=ComBx9  then sij(9)  else
   if ActiveControl=ComBx10 then sij(10) else
   if ActiveControl=ComBx11 then sij(11) else
   if ActiveControl=ComBx12 then sij(12) else
   if ActiveControl=ComBx13 then sij(13) else
   if ActiveControl=ComBx14 then sij(14) else
   if ActiveControl=ComBx15 then sij(15);
end;//FormActivate

procedure TSyottoFrm.FormClose(Sender: TObject;  VAR Action: TCloseAction);     //VAR {1412:} s :string;

  {procedure WinBACK;      VAR i,o,n :integer;      begin //+6.2.x  Asettaa takaisin ENABloinnin, jotka oli
      n := Length (WinARR);                           //UnEnabloitu (ks. PRC WinOFF_setARR) SyottoFrm´n ajaksi.
      for  i := 0 to Screen.FormCount-1  do           //<Käydään läpi kaikki ikkunat ...
      for  o := 0 to n-1  do begin                    //<... joiden kunkin aikaisemmat Enab -asetukset palautetaan.
         if (Screen.Forms[i].Name <> 'SyottoFrm')    AND
            (Screen.Forms[i].Name <> 'SyottoAvFrm')  AND
            (WinARR [o].Nimi = Screen.Forms[i].Name)
         then Screen.Forms[i].Enabled := WinARR [o].Enab;
      end;
      EdiWindows;
   end;//WinBACK}

{begin//FormClose
   inherited;
             //PaaValFrm.Caption := 'OnClose';
   LaskeeOdFrm.NayLaskeeOdota; //<Kylläkin myös Johto/Johdot :ssa, mutta viiveellä
// EdvNewFrm.Update;           //<Jotta NJ-laskennassa Frm häviäisi kokonaan ennen ProgresBaria. -5.0.0 Ks. Johdot
//   SuljeBtnClick(Sender);      //< +6.2.19 Jätti muutokset johto-osatietoihin
//   edv := edvo;                //<Palautetaan edeltävä tieto. +6.2.19
//   SuljeFrm_aseta;
   LaskeeOdFrm.Close;          //< +4.0.0
 //EdvNewFrm.Enabled := true;  //< +6.0.0  ShowModal muutettiin EdvNewFrm.Enabled := false´ksi
                               // Ei kylläkään häviä, mutta ei ainakaan pirstoudu = parempi.
 //WinBACK;                    //< +6.2.x
end;}

   procedure jaljita;      {VAR se,ac :integer;  sn :string;      }begin//10.0.4
 (*if IsDebuggerPresent  then begin
     {if Sender is TComboBoxXY        then se := 1  else  if Sender is TButton          then se := 2  else
                                                          if Sender is TFormNola        then se := 3  else se := 4;
      if ActiveControl is TComboBoxXY then ac := 1  else  if ActiveControl is TButton   then ac := 2  else
                                                          if ActiveControl is TFormNola then ac := 3  else ac := 4;
      if se+ac <-99  then beep;  end;}                    //,SN korvaa hyvinkin SE:n,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
     {sn := 'SenderName=' +TComboBoxXY(Sender).Name +' tbOrd=' +Ints(TComboBoxXY(Sender).TabOrder) +
                 '  NextActName=' +ActiveControl.Name +' tbOrd=' +Ints(ActiveControl.TabOrder); // }
      if Sender is TComboBoxXY  then sn := TComboBoxXY(Sender).Name   else
      if Sender is TButton      then sn := TButton(Sender).Name       else
      if Sender is TFormNola    then sn := TFormNola(Sender).Name;
      sn := 'SenderName=' +sn +'  ActName=' +ActiveControl.Name +'  ' +DateTimeToStr (Now);
      //if sn='-99'  then beep;
      EdvNewFrm.Caption := sn;
      //wbeep ([500,500, 200,500, 500,500]); //<Antaa 500Hz 0.5s + 200Hz 0.5s + 500Hz 0.5s, ks. Y_.PAS .
   end; *)end;

begin//FormClose  Sender -kokeiluja, ks. E:\ProjektiDelphi-vihjeet\SenderHavaintoja.txt yms. 10.0.4 .
   inherited;                            //,+11.0.1: OnShow´ssa := fsNormal:  SyottoFrm on fsStayOnTop (objInsp),
 //SyottoAvFrm.FormStyle := fsStayOnTop; // nyt takas fsStayOnTop.            //<'Ei sittenkään, ks. ComBx1_11Enter.
   Jaljita;                              //,SyoPeruttu := SuljeBtnClik´issä +8.0.10
//UpsFileen('FormClose 1');

   Kuvaus_JkUpsTietoa('FormClose 1');      //<+1412.

  {if SyoPeruttu  OR NOT NormClose  AND //<NormClose := TR  PRC CloseNrm :ssa.                   <,+10.0.4§ -1414b: edv := palautti vaikka haluttiin poistaa.
      NOT AsetusOkBtnSulkiSyoFrmin       //<Kun mentiin ASETUSFRM´iin ja sieltä poistuttiin OK´lla (ainakin).
      then edv := edvo;                  // sieltä suljettiin monia formeja, mm. tämä => LUKUVIRHE a_getReaa (10,..) PoisAika ym.}
                                         //'Palautetaan edeltävä tieto. +6.2.19  '= HALUTAANKO VANHAT ARVOT TAKAS.
   LaskeeOdFrm.NayLaskeeOdota; //<Kylläkin myös Johto/Johdot :ssa, mutta viiveellä
// EdvNewFrm.Update;           //<Jotta NJ-laskennassa Frm häviäisi kokonaan ennen ProgresBaria. -5.0.0 Ks. Johdot
   LaskeeOdFrm.Close;          //< +4.0.0
 //WinBACK;                    //< +6.2.x
KoeWInfoA (0,'EditSyoFrm-FormClose+Ulos');
   UpsFileen('FormClose 9');
end;//FormClose

//==================================================================================================,, +4.0.1                                                                                                    //,, +4.0.1
procedure TSyottoFrm.ChkBxAvClick(Sender: TObject); begin//,,CheckedArvo onJo ehtínyt vaihtua Clickin jälk, TODETTU
                                   Qedic (ChkBxAv.State,' [2.1]' );  Qedic_ (' \Grd='+fBmrkt0 (Gray_Chkd,2));
   if AvCloseOK  then begin                            //<Vain ekalla kerralla läpi, 2.krt tullaan AvuChkSf :stä
      if Gray_Chkd  then begin
         ChkBxAv.State := cbUnChecked;                  //<Vain ChkBxAvMouseDown :sta. Aiheuttaa EVENTIN @@@@@@@@@
         fSyoAktv (0);  end;              //<Koska SYOAKTV+SYOAVONin perusteella Grayed/Chkd/UnChkd AvuChkSft :ssa
      if ChkBxAv.State=cbUnChecked
         then begin syoAvOn := false;     //<, SYOAVON asetus VAIN TÄSSÄ + StrGrDblClick :ssä ####################
                    SyottoAvFrm.Hide;  end
         else begin syoAvOn := true;      //<Kattaa cbGrayed + cbChecked
                    fSyoAktv (0);         //<Koska SYOAKTV+SYOAVONin perusteella Grayed/Chkd/UnChkd AvuChkSft :ssa
                    AvuChkSft (10);  end; //<''+11.0.1
                                                                //Qedic (ChkBxAv.State,' [2.2s]');
      AvuChkSft (0);  end;
   Gray_Chkd := false;                                  //<Vain ChkBxAvMouseDown :ssa @@@@@@@@@@@@@@@@@@@@@@@@@@@@
                                                                Qedic (ChkBxAv.State,' [2.3]' );
end;//ChkBxAvClick

procedure TSyottoFrm.ChkBxAvMouseDown(Sender: TObject;  Button: TMouseButton;  Shift: TShiftState;  X,Y: Integer);
begin                             //'=TapahtuuKunKlikattu ChkBxAv :ta, CB -ARVO EI VIELÄ EHTINYT MUUTTUA, TODETTU.
  inherited;      //==Jos tässä sij. cb -arvo, menee ChkBxAvClick -eventiin, eli ei voi lisätä muuta: Menee ENDiin
   if ChkBxAv.State IN [cbGrayed,cbChecked]            //<Pakotet. cbGrayed t. cbChecked -> cbUnChecked
      then Gray_Chkd := true                           //<,Ei voi asettaa suoraan STATEa: aiheuttaa
      else Gray_Chkd := false;                         //  eventin, TODETTU.########################
                                   //Qedic (ChkBxAv.State,'<br>[1]');  Qedic_ (' \Grd='+fBmrkt0 (Gray_Chkd,2));
end;                                                        //''Jos nämä tässä, EI ChkBxAvClick -EVENTIÄ, TODETTU
//=================================================================================================='' +4.0.1                                                                                                    //,, +4.0.1
                                                //,Tämä tapahtuu asetukset, PRC OhjLaskIkkuna yms. JÄLKEEN =VIKAX.
procedure TSyottoFrm.FormShow(Sender: TObject);      VAR s :string; // +4.0.4
                                                    //,,+5.0.0 w2000 :ssa SyottoFrm ekan kerran avatessa KAIKKI
   procedure Aseta (VAR BxU :TComboBoxXY);     begin//,,BOXIT=SELECTED =Tässä hoidetaan näkymä niin, että vainBx1.
      BxU.Enabled := true;                          //<+10.0.4  Jottei jäisi mahd. ed. krran unenablet päälle.
      if BxU.Visible  then
         BxU.SelStart := Length (BxU.Text);  end;

begin
  inherited;                           //,+11.0.1: OnClosessa takas fsStayOnTop:  SyottoFrm on fsStayOnTop (objInsp)
//SyottoAvFrm.FormStyle := fsNormal;   // ja koska AvFrm on myös, ristiriita estää SelectAll +mrkEdit:n, todettu.
 //BorderIcons := BorderIcons - [biMinimize];//[biSystemMenu]; //+10.0.4  =>Caanot change onVisible.. tms.
 //EdvNewFrm.Enabled := false;         //< +6.0.0  Oli ShowModal, ks. korvattu muutettiin EdvNewFrm.Enabled := false´ksi
   MuuLsk := 66;                       //<+10.0.4  Alkutilanne =tallettaa ruutuTxtn jaettei SyoArvOk herjaisi Sm:sta (=0).
   s := MuuBtn.Caption;
   while CharInSet(s[Length (s)], ['0'..'9',' ']) //<,,+10.0.4
      do Delete (s, Length (s),1);
   MuuBtn.Caption := s;
   ListBx1.Visible := false;             //<''+10.0.4  Jos vaihdettiin Sj/Pj/Sj-liittymätapaa, todettu joskus taphtuvan.

   Aseta (CyBx11);   Aseta (CyBx12);
   Aseta (CyBx21);   Aseta (CyBx22);
   Aseta (CyBx31);   Aseta (CyBx32);
   Aseta (CyBx40);
   Aseta (CyBx51);   Aseta (CyBx52);
   Aseta (CyBx61);   Aseta (CyBx62);
   Aseta (CyBx71);   Aseta (CyBx72);
                     Aseta (CyBx80);
   Aseta (ComBx1);   Aseta (ComBx2);   Aseta (ComBx3);   Aseta (ComBx4);   Aseta (ComBx5);   Aseta (ComBx6);
   Aseta (ComBx7);   Aseta (ComBx8);   Aseta (ComBx9);   Aseta (ComBx10);  Aseta (ComBx11);  Aseta (ComBx12);
   Aseta (ComBx13);  Aseta (ComBx14);  Aseta (ComBx15);

  {if OhitaBtn.Visible                  //<-10.0.4
   then OhitaBtn.SetFocus               //< +6.0.0
   else if SyottoFrm.aRich.Visible
   then begin
      SyottoFrm.aRich.SelStart := Length (SyottoFrm.aRich.Text); //<,,+6.2.0
      SyottoFrm.aRich.SelLength := 0;   //<JosKommentoi vex ja NOT ENABLED, PÄIVITTYMINEN NÄKYY TOSIAIKSTI, hidas.
      SyottoFrm.aRich.SetFocus;
    //SyottoFrm.Update;
   end
   else }ComBx1.SetFocus;          //< -6.0.4, Takaisin 8.0.8, muuten ei maalaudu avauksessa.  Aina focus=+10.0.4

   MuuBtn.Top :=  PanelYy.Height -MuuBtn.Height -2; //<,+10.0.4
   MuuBtn.Left := PanelYy.Width  -MuuBtn.Width  -2;
end;//FormShow

procedure MuuLaskenta; //10.0.4

   procedure AsBoxit;                                CONST crW=COLOR_WHITE;
                                                           crB=COLOR_BLUE;  crR=COLOR_RED;
      procedure asBx (VAR BxU :TComboBoxXY;  LskOhj :integer{+10.0.4});      VAR enab :boolean{+10.0.4};     begin
                             //,Jos MUULS sama ja jokin näistä, kytketään UnEnabled => 2 muuttaa ENABLEksi.
         if (MuuLsk=LskOhj)   OR                       //<,+10.0.4
            (MuuLsk IN [1]) and (LskOhj=12)            //Nyt 12 ei ole enää käytössä (oli kehitysvaiheessa).
            then enab := false
            else enab := true;                         //< +10.0.4
         BxU.Enabled := enab;  end;

      procedure Black_White (coi,rwi :integer);      VAR sa :string;      begin
         sa := SyottoFrm.StrGrY2.Cells[coi,rwi];
         sa := crW +sa ;
         SyottoFrm.StrGrY2.Cells[coi,rwi] := sa;
      end;//Black_White
             //,crB crR
      procedure BlueRed_White (CLR :string;  coi,rwi :integer);      VAR sa,sb :string;  k,n :integer;      begin
         sa := SyottoFrm.StrGrY2.Cells[coi,rwi];    //PRC muuttaa sinisen "TAI" ja punaisen "U2" valkoiseksi.
         if MuuLsk<>0
         then begin                                 //<,,Aina tähän, MuuLs=1,2,66
            k := Pos (CLR,sa);                      //<Etsitään värimmäärityskohta.
            n := Length(CLR);
            if k>0  then begin                      //<,,Vaihdetaan COLOR_REB COLOR_WHITE´ksi.
               Delete (sa,k,n);                     //<Delataan se.
               sb := crW;
             //Insert (sb,sa,k);  end;              //<Tilalle WHITE SA:han.
               Insert (sb,sa,k);                    //<Tilalle WHITE SA:han.

               k := Pos ('</f>',sa);                //<Etsitään värinlopetus, joka estää esim. "[kV]":n valkaisun.
               if k>0  then
                  Delete (sa,k,4);   end            //<Delataan se.
         end
         else begin //Ei koskaan tänne. Varm.vuoksi herja:
            InfoDlg ('Ohjelnointivirhe, ilmoita: "SyottoFrm.PAS / PRC BlueRed_White', mtCustom,
                     'OK','','','',  '' ,'','','');  
           {k := Pos (crW,sa);
            n := Length(crW);
            if k>0  then begin
               Delete (sa,k,n);
               sb := CLR;
               Insert (sb,sa,k);  end;}
         end;
         SyottoFrm.StrGrY2.Cells[coi,rwi] := sa;
      end;//Red_White

   begin//AsBoxit........................
      with SyottoFrm  do begin  //,0=Aina päällä  1=Pois kun MuuLs=1  2=Pois kun MuuLs=2 ... 12=Pois kun 1 tai 2.
        {asBx (CyBx11,  0 );    asBx (CyBx12,  0  );  Ylimmän rvn bxt jää. joten tarpeetonta tutkia/asett. MuuLs}
         asBx (CyBx21, 12 );  //asBx (CyBx22,  0  );
         asBx (CyBx31, 12 );    asBx (CyBx32, 12 );
         asBx (CyBx40, 12 );  //< Sm
         asBx (CyBx51, 12 );    asBx (CyBx52, 12 ); //< Pk
         asBx (CyBx61,  1 );  //asBx (CyBx62,  1 ); //< L[km] pitää olla enabloitu 2 :lla (ja 3).  Nyt AINA, kun
       //asBx (CyBx71,  1 );    asBx (CyBx72,  1 ); //< Xv                            <' MuuLs ve´ja enää 1,2,66.
                                asBx (CyBx80, 12 ); //< Lv ,,Näissäkin (Col,Row). Row=Ruudulla näkyvä vihreä nro-1,
         if MuuLsk IN [1]                           //     esim. (..,1) = "vihreä" rivi 2 (= 2 "Sk [MVA]".
            then SyottoFrm.StrGrY2.Cells[3,0] := 'Cos' +FONT_FII +'<right>='
            else SyottoFrm.StrGrY2.Cells[3,0] := 'Ry/Xy <right>=';
    if NOT (MuuLsk IN [2,66])  then begin //<Jätetään muuttamatta koska Pal_RuutuTxt on palauttanut jo alkuperäisen asun + txt.
     //, "U1 [kV]  ="          Vas. CyBx                                                Oik.CyBx
     //,, i: Col 0...........     Col 1...........  Col 2..........   Col 3...........     Col 4..........
         Black_White (0,1);   {=U1}             BlueRed_White (crB,2,1);//"TAI" Oli Blue_White (2,1);
   BlueRed_White (crB,0,2);   //<Rvllä vain "TAI"  Oli Blue_White (0,2);
         Black_White (0,3);   {=Sk}                               Black_White (3,3);
         Black_White (0,4);   Black_White (1,4);                  Black_White (3,4);   Black_White (4,4); //<Ry´..
         Black_White (0,5);
         Black_White (0,6);   {Sm}                                Black_White (3,6);
             {U2 -rivi =7}    {U2}             {if MuuLs=1  then Black_White (3,7);  <,Nyt eiEnää kun MuuLs 2=>1}
     {if MuuLsk=1  then begin}
       //Black_White (0,8);   {Rv}                                Black_White (3,8);   end;
                                                             BlueRed_White (crB,3,9);  {TAI} //Oli Blue_White (3,9);
                                                                  Black_White (3,11);  Black_White (4,11); //<Ry/Xy  =..
         Black_White (0,10);                                      Black_White (3,10);
       //Black_White (0,12);  Black_White (1,12); {Ry}            Black_White (3,12);  Black_White (4,12); //<Xy
       //Black_White (0,13);  Black_White (1,13); {Sk =..}        Black_White (3,13);  Black_White (4,13); //Ik3v..
        if MuuLsk=1  then                                //'(1,13) ja (4,13) hoidetaan PRC PvitaYHT:ssa.
           BlueRed_White (crR,0,7);                      //<U2 punainen valk:ksi.
    end;//if NOT MuuLs [2,6]
    end; end;//with, AsBoxit

begin//MuuLaskenta...............
   if MuuLsk IN [1] //Tämän jälkeen vasta tulee PviraYHT  Cells[] := ..
   then begin
      SyottoFrm.SiirraY_Btn.Enabled := false;
      SyottoFrm.SiirraY_Btn.Enabled := false;
      if MuuLsk=1                                        //<,,+10.0.4  Ei tarttis, OK. Oli aikanaan:  if ..IN [1,2]
      then begin                                         //            mutta nyt ei enää ole 2:ta.
       //SyottoFrm.CyBx61.Text := SyottoFrm.CyBx11.Text; //<U2 := U1  Ei muutetakaan, kun palataan norm:ksi, jää
         SyottoFrm.CyBx61.Enabled := false;              // tämä U2=U1, jota käyttäjä ei ehkä hoksaa.
      end;
   end
   else begin
      SyottoFrm.SiirraY_Btn.Enabled := SiirBtnYok; //<,Sijoitus PRC ChkAsSiirraBtns :ssa ehtotarkistuksen jälkeen.
      SyottoFrm.SiirraA_Btn.Enabled := SiirBtnAok;
   end;
                               //,Laskee ja sijoittaa Yvrk + GrdCell´it.
 //LasEdiLy_Gr (13);           //<Jos vaikka oli ed.krsta UnChecked ja nyt Checked, Clickki ei päivittänyt. OliOK.
// LasEdiLy_Gr (99);           //<Päivittää Bx:ien ja StrGrY2:n KAIKKI arvot.  
   AsBoxit; //<Ks. yläp. '.    // Ry,Xy rvllä 13 aina. Kutsussa nyt param:na 13, koklattu 10, OK, ei liene väliä.
end;//MuuLaskenta

procedure TSyottoFrm.MuuBtnClick(Sender: TObject);      VAR h,n :integer;      begin
   inherited;
   ListBx1.Items.Clear;                                                    //'=Vaidettiin AVISTA. Paluu valikkoon.
 //ListBx1.Items.Add ('1 »»  Laske Ry, Xy = f (Ik,cosf)');
{0}ListBx1.Items.Add ('1 »»  Laske Ry, Xy = f (Ik,cosf,johto)');
{1}ListBx1.Items.Add ('2 »»  Palaa täyslaajuuslaskentaan');
{2}ListBx1.Items.Add ('3 »»  SULJE tämä apuvalikko »»»»»');
   h := ListBx1.Items.Count;                  //<h tässä vain apuna.
   n := h *ListBx1.ItemHeight +4;
   ListBx1.Height := n;                       //<'n tässä vain apuna.
   ListBx1.Width := 196;
   ListBx1.Top :=   PanelYy.Height;
   ListBx1.Left :=  PanelY.Width -ListBx1.Width;
   ListBx1.Visible := true;
end;

procedure TSyottoFrm.ListBx1MouseUp(Sender: TObject; Button: TMouseButton;  Shift: TShiftState;  X,Y: Integer);
   VAR ss :string;                                                                               //PRC 10.0.4
begin
   inherited;
              {Caption := '';// }
   if ListBx1.ItemIndex+1 IN [1,2]       //<Oli CASE, korvattu:  MuuLs := ..Index+1;
   then begin
      if MuuLsk IN [66,2]  then          //<Tähän tultaessa voimassa olevat arvot.  MuuLs := 66 OnShow:ssa.
         Tal_RuutuTxt;                   //<Tallet. ennen kuin ruutu muuttuu. Tallennetaan NORMAALIapuruudun textit.
              {if MuuLs IN [66,2]  then
                  Caption := 'Oli (talletti)='+Ints (MuuLs);}
      MuuLsk := ListBx1.ItemIndex+1;
              {Caption := Caption +'  uusi='+Ints (MuuLs);}

      Pal_RuutuTxt;                      //<,,Palauttaa Cellien alp. tekstit väreineen yms..
      MuuLaskenta;                       //<Ind=2:ssakin tarvitaan koska muuten jää CyBx´it UnEnabled.
      LasEdiLy_Gr (99);       //<Päivittää kaikki arvot.  TÄSTÄ VIRHEESEEN. 
   end;                                  //Else =vanha MuuLs jää voimaan.

   ListBx1.Visible := false;
   ss := MuuBtn.Caption;
   while CharInSet(ss[Length (ss)], ['0'..'9',' '])  do //<Delataan lopusta nrot ja tyhjä väli, joka tehdään uudestaan.
      Delete (ss,Length (ss),1);
   if MuuLsk IN [1]
      then ss := ss +' ' +Ints (MuuLsk);
   MuuBtn.Caption := ss;                       //<Liitetään loppun MuuLs -nro.
   AvuChkSft (10);                             //<10=Vapauttaa avusteen.
end;

procedure TSyottoFrm.ListBx1MouseMove(Sender: TObject;  Shift: TShiftState;  X,Y: Integer);      begin
   inherited;
   avust (0{Box},60,1{Liittymä});
   AvuChkSft (11);                //<11=Lukitsee avusteen.
end;

procedure TSyottoFrm.MuuBtnMouseMove(Sender: TObject; Shift: TShiftState;  X,Y: Integer);      begin
   inherited;
   avust (0{Box},60,1{Liittymä});
end;

initialization
   UpsNytVex := 0;             //<141.1
   SyoPeruttu := false;
   DblKlikki := false;
   Ctrl :=      false;         //<+8.0.3
   Gray_Chkd := false;
end.
