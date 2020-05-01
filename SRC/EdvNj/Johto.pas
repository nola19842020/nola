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

{120.6 version Johto.PAS
1414fu/1415a:  HeadeGrid´in 114/86 yms -arvot on kolvattuina TextBaseTex-.PAS´sissa.
§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§ ResizeGrid GetMaxWidth
 §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
 øN on erinomainen paikallistamiskeino näytöllä vs. sorsassa = näyttää mikä kohta sorsassa näkyy missäkin näytöllä.

 TÄSSÄ FILESSÄ mm:  "Ik1v"... Sulakerivit..."Resurssitarkastelu".
 ETSI: Rivi Rivit Rivt Riv

 koeColor := TR/FA asettaa värit havainnollisiksi SEKÄ pistää tunnusmrkt øN celliStringeihin.
    LocationIndex: 0...n (n=SorceCount+JohtoOsia-1)    ArrayIndex: 1 ...SorceCount ja 1 ...JohtoOsia  //<,,Siirretty 120.6
    LocationIndex: integer; // Kertoo indeksin EdvNewFrmissa.     0..n:    0=Eka Sorce,  1=seur Src tai Edj
    arrayIndex: integer;    // Kertoo indeksin tietorakenteessa.  1..n+1:  1=Eka Sorce,  2=seur Src tai Edj, eli ArrayIndex on aina LocationIndex +1.
               [01]----[02]---PK---[1]---[2]--...   <JohtoBtns:  Src1 Src2 (PK) Edj1  Edj2
       ArrIndx:  0       1          2     3
       LocIndx:  1       2          3     4
    (ArrayIndex>edv.YLE.SorceCount.arvoInt)    <,,Käyttöesimerkkejä,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    edv.Edka[ArrayIndex]
    EdvJohto.
    a_getBool(101000, EdvJohto.Kuluttaja)  tai  EdvJohto.Kuluttaja.arvoBoo
    a_getReaa(101080, EdvJohto.Ph)
    ra := a_getReaa(101000, ReadEdvJohto().Pituus);
    ra :=                   ReadEdvJohto().Pituus.arvoRea;  <'Samoja.

    - HeaderGrid =RiviNimiGrid´i EdvKuvaajan vas.laidassa.
    - HeaderImage on epäselvä (mikä se on, aiheuttaa kuitenkin MouseMoveRow4´n). //<''+12.0.0
12.0.2:  - LahdotGrid => ResursGrid  =Nimi nyt kuvaavampi, -muutos aiheuttaa errorin:  Could not create output name ...\dcu,
           joten LahdotGrid palautettu takas.
         - Lisätty 411.4 :n testerinnäyttämävaatimus, esim. (132A/98.4A)
12.0.4:  _Em:n korjaus (kerroin 1.2 => 1.25 = (132A/98.4A) => (137.5/102.5)

§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§}
{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q+,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $01000000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q+,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $01000000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q+,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $01000000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$IFDEF PROFILE} {$O-} {$WARNINGS OFF} {$ENDIF }

///////////////////////////////////////////////////////////////////////////////
//
// FileName:  Johto.pas
// Location:  src\edvnj
// Abstract:  Sisältää edeltävän verkon yhden johto-osan
// ###############################################################################################################
// ###############################################################################################################
// -Verkkokuvaaja saadaan päivittymään ..., etsi "IsEqualEdvTiedotType" ja "IsEqualEdvPalstaType".
// -RefreshNormal:ssa riveille arvot, [x] x = RivinimiPanelin riviNo -5, eli x=1 =panelin rv 6. Kommnt +12.0.0
// ###############################################################################################################
// ###############################################################################################################
//
// Johto.PAS / procedure TJohto.RefreshConnection:                   Siirretty CabelImage´sta tähän 10.0.4,  6.2.2
//                 JohtoBtn vieressä LIITTYMÄtietojen (3) riviä:::::::::::::::::::::::::::::::::::::
//                      Muuntaja: 800 kVA  <,,JohtoBtn´in viereiset 3 tekstiriviä
//                      +Zy=...
//                      R1y/X1y=...
// FormatCable.PAS / FormatCablePanel:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//                 KirjakuvakeBtn (OpenBtn) viereiset tekstit, 2(?) riviä +Jakokeskuksen NIMI/TUNNUS:
//                      5xAXCMK 300 mm²                          //<Etsi "Amm²"
//                      8.0 m SÄL 80° k=1
// Johto.PAS / RefreshNormal:
//                 Varsinaiset rivien 6...34 tekstit::::::::::::::::::::::::::::::::::::::::::::::::
//                       Ik1v...Sulakkeet...Resurssit
// CabelImages.PAS: SL-liitin.PJ-liitin,Gener.,UPS- jne. -symbolit
// ###############################################################################################################
// ###############################################################################################################
//Kutsujärjestys / -tapahtumat, kun muutetaan esim. AsTapa  A => C:       Br.pointit "//AsTapa§" -merkittyihin paikkoihin
//   TEdvNewFrm.UpdateValues;                         edvE := edv;
//   TEdvNewFrm.WriteEdv(var value: EdvYHTtype)       YLE := value.YLE;
//   TJohdot.WriteEdka(var value: edkatype);          FEdka := value;
//   TJohto.WriteEdvJohto(var value: EdvPalstaType);  FEdvJohto := value;
//     'kutsuu:  FNC IsEqualEdvPalstaType,  JOS FA, PÄIVITETÄÄN KUVAAJA <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//     Pakko:    if edv.YLE.ZpeBx.arvoBoo<>edvE.YLE.ZpeBx.arvoBoo...   Koska IsEqua.. (edellä) ei hokaa.
//   TJohto.ReFresh;
//   TJohto.RefreshNormal ==> Tulostus näytölle.

        {Ohan kulku AsTapa-muutoksessa (Bx):
         TEdvNewFrm.UpdateValues @:01
         EdvNewFrm.WriteEdv      @:02
         TEdvNewFrm.WriteYLE     @:03
         TJohdot.WriteYLE     @:1            <,,Nämä merkityt sorceen, etsi: "@:"
         TJohdot.WriteEdka    @:2
         TJohto.WriteEdvJohto @:3
         TJohto.ReFresh;      @:4
         TJohto.ReFreshNormal =Edit.
         @3  @4
         @3  @4 jne. johto-osakertaa.}

//GRIDIT:  SulakeGrid: TStringGridNola; =
//         LahdotGrid: TStringGridNola;
//Nämä näet, kun asetat  koeColor := TRUE; ########################################## HYVÄ, HAVAINNOLLINEN.!!!!!!
//                                         Defs.PAS´sa on vielä useita asetettavia, yleensä txtVärejä,å: tärkein
//     EDV_POHJA_COLOR                = {clAqua;} clWhite;  // Pohjan   väri 12.0.0: clAqua erottuakseen.
//   HeaderPanel.Color := clAqua;     //§§§c§§§  clSilver on tummempi kuin clBtnFace
//   DataPanel.Color :=   clLime;     //§§§c§§§  SulakeGrid´ille ja LahdotGrid´ille.
//   HidePanel.Color :=   clBlue;     //§§§c§§§
//   CablePanel.Color :=  clYellow;   //§§c§§ koe OK +806  Otsikkopanelin =vaakaviivan yläp. osa kullakin johto-osalla.
//   LahdotGrid.Color :=  clFuchsia;  //§§§c§§§ Pistor.resurssiRvstä 23..35 alasp. DataPanel´issa.
//   SulakeGrid.Color :=  clRed;      //§§§c§§§ Gridi riveille 6..21 DataPanel´issa.
//
//     Lasketut arvot johto-osalle sijoitetaan LahdotGrid.Cell´eihin 0..4, 5.=tyhjä (ColCount=6, RowCount=13=[12])
//     Rivi  8 (9):  [0]"-\-"  [1]="<center>/"  [2]="40.2m\87.7m"  [3]=""  [4]=""  [5]=""
//                   -\- / 40.2m\87.7m
//     Rivi 12(13):  [0]="1250A"  [1]="<center>/"  [2]="2x300"  [3]="AMCMK3½"  [4]="963.3m"  [5]=""  Rws=13 Cls=6
//                   1250A /     2x300 AMCMK3½ 963.3m
//
// Johto.PAS / procedure TJohto.RefreshConnection:                                                          6.2.2
//                 JohtoBtn vieressä LIITTYMÄtietojen (3) riviä:::::::::::::::::::::::::::::::::::::
//                      Muuntaja: 800 kVA  <,,JohtoBtn´in viereiset 3 tekstiriviä
//                      +Zy=...
//                      R1y/X1y=...
// FormatCable.PAS / FormatCablePanel:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//                 KirjakuvakeBtn viereiset tekstit, 2(?) riviä +Jakokeskuksen NIMI/TUNNUS:
//                      5xAXCMK 300 mm²                          //<Etsi "Amm²"
//                      8.0 m SÄL 80° k=1
// Johto.PAS / RefreshNormal:
//                 Varsinaiset rivien 6...34 tekstit::::::::::::::::::::::::::::::::::::::::::::::::
//                       Ik1v...Sulakkeet...Resurssit
//             SetText(LahdotGrid, EDV_MIDDLE_COL_1 , x , tmp);    // 1.5/2.5 mm² palstojen välistä.
//             SetText(SulakeGrid, EDV_MIDDLE_COL_1 , x , tmp);
//             SetText(SulakeGrid, EDV_HEADER_COL, 3, EDV_COLOR_FONT_POHJA + tmp);
//             EDV_HEADER_COL=0   EDV_MIDDLE_COL_1=1   EDV_SULAKE_COL_2=2  =muitakin, ks. Defs.PAS
//                SulakeGrid(.rowCount) =Rivit n.  6...21 DEVELOPER1
//                LahdotGrid(.rowCount) =Rivit n. 23...34 DEVELOPER1
// CabelImages.PAS: SL-liitin.PJ-liitin,Gener.,UPS- jne. -symbolit
// ==============================================================================================================
// MUUTOS Kain JOHTOLUONTIKUVIOIHIN:  +8.0.0  DEVELOPER1:
// Ks. procedure TJohto.WriteEdvJohto(var value: EdvPalstaType);
// CablePanel.InfoButtonOnLeft := false/true //<Muuten poistettaessa Edka[1] tai lisättäessä Sorc[]   InfoButton [1]
//                                           // ei tule oikeaan kohtaan: Src=VasYlös, Edka=Johtoon.
//############################################# Tutkitaan PRC TCablePanelNola.SetLayout´issa.####################
// ==============================================================================================================
///////////////////////////////////////////////////////////////////////////////
//
// Following fields are automatically generated by the version control system:
//
// $Revision: 1.11 $
//     $Date: 2005/10/15 08:22:17 $
//
///////////////////////////////////////////////////////////////////////////////
//
// Change Log. Old log entries can be removed by deleting them.
// $Log: Johto.pas,v $
// Revision 1.11  2005/10/15 08:22:17  DEVELOPER2
// Optimointi: johdot.resize() kutsutaan vain EdvNew modulista tarvittaessa
//
// Revision 1.10  2005/10/15 06:27:46  DEVELOPER2
// Johtojen "välkyntää" lisättäessä vähennetty.
//
// Revision 1.9  2005/10/14 17:54:37  DEVELOPER2
// Optimointia: päivitetään ruutua vain kun on tarve
//
// Revision 1.7  2005/10/09 14:00:46  DEVELOPER2
// Reijolta 26.9.2005
//
// Revision 1.5  2005/08/29 20:12:43  DEVELOPER2
// Korjattu liittymäjohdon lisäys
//
// Revision 1.4  2005/08/29 18:20:30  DEVELOPER2
// reijolta 29.8.2005
//I ..\globals\defines.inc}
//
// 33    18.08.04 19:49 DEVELOPER2
// Reijolta 2004-08-18
//
// 31    28.02.04 17:43 DEVELOPER2
// Bug fix. Viimeinen johto ei toiminut oikein, kun johto-osia poistettiin. Korjattiin estämällä viimeisen johto-osan tuhoaminen ja päivittämällä johtojen indeksit oikeiksi tuhoamisen jälkeen.
//
// 30    28.02.04 13:05 DEVELOPER2
// Reijolta 28.2.2004
//
// 27    16.01.04 22:13 DEVELOPER2
// Otettu käyttöön muutettu liittymajohtojen tietorakenne:
// - TJohtoType: uusi tyyppi JOHTO_LIITTYMA liittymajohtoja varten.
// - locationIndex: index nimetty uudelleen locationIndex jäseneksi.
// - arrayIndex: lisätty kuvaamaan johdon sijaintia tietorakenteissa.
// - FIsSrcValid: lisätty kuvaamaan onko liittymatiedot asetettu.
// - Fsrc: lisätty liittymajohdon tietojen tallenusta varten.
// - WriteYLE, WriteNjL, WriteEdvJohto: var-esittely otettu käyttöön koodin optimoimiseksi.
// - Writesrc: lisätty liittymajohtojen tietojen kirjoittamista varten.
// - Create(): aindex uudelleen nimetty alocationIndexiksi, lisätty aArrayIndex.
// - HasConnection(): korvaantunut JOHTO_LIITTYMA tyypillä
// - src: lisätty liittymatietojen tallentamista varten.
// - IsEqualEdvTiedotType(), IsEqualEdvPalstaType(), IsEqualEdvSorceType(): var-esittely otettu käyttöön koodin optimoimiseksi.
// - IsEqualEdvNjLahtoTyp(): lisätty liittymatietojen vertailua varten.
// - DrawJohto(): JOHTO_LIITTYMA lisätty.
// - SetTexts(): JOHTO_LIITTYMA lisätty.
// - Resize(): HasConnection() korvattu JOHTO_LIITTYMA.
// - GetNextJohto(): index korvattu locationIndex.
// - HasNextJohtoConnection(): HasConnection() korvattu JOHTO_LIITTYMA.
// - DrawGraphics(): JOHTO_LIITTYMA lisätty.
// - DrawNousuJohto: JOHTO_LIITTYMA lisätty.
// - Refresh(): JOHTO_LIITTYMA lisätty.
// - RefreshNormal(): index korvattu arrayIndex.
// - RefreshConnection(): Edv.Sorc[nro].src korvattu src:llä joka viittaa oikeaan src indeksiin.
//
//
// 26    13.01.04 21:32 DEVELOPER2
// Reijolta 13.1.2004
//
// 25    11.01.04 16:42 DEVELOPER2
// Korjattu johto-osien nappien tekstit alkamaan ykkösestä:
// - johto-jäsen poistettu TJohto-oliosta.
// - Create(): AOwner ja ajohto poistettu tarpeettomina. GetName() otettu käyttöön.
// - GetName(): Funktio lisätty tekstin muostamiseksi nappiin ja vihjeteksteihin.
// - SetTexts(): GetName()-funktiota käytetään vihjetekstien muodostamiseen.
// - Resize(): Tarpeeton ParentDataPanel-komponentin käsittely poistettu.
// - SetVisibles(): Tarpeeton ParentDataPanel-komponentin käsittely poistettu.
// - Refresh(): GetName()-funktiota käytetään nappitekstin muodostamiseen.
//
// 24    11.01.04 15:24 DEVELOPER2
// Reijolta 11.01.2004
//
// 23    10.01.04 13:26 Kai
// Korjattu normaalin johto-osan tietojen siirtyminen pari riviä ylös:
// - Refresh(): Lisätty CablePanelin rivien 0-2 tyhjentäminen sijoittamalla niihin tyhjä välilyönti, jolloin em. rivien korkeus ei jää nollaksi.
//
// 22    10.01.04 13:20 DEVELOPER2
// Korjattu edeltävän verkon viimeisen johto-osan yksiköiden peittyminen:
// - GetVBorder(): poistettu tarpeettomana, GridLineWidth properti tekee saman
// - GetHBorder(): poistettu tarpeettomana, GridLineWidth properti tekee saman
// - SetGridHeight(): poistettu tarpeettomana, GetMaxHeight metodi tekee saman
// - SetGridWidth(): poistettu tarpeettomana, GetMaxWidth metodi tekee saman
// - ResizeGrid(): SetGridHeight ja SetGridWidth funktiot korvattu GetMaxHeight ja GetMaxWidth metodeilla
// - GetRealWidth(): korjattu taulukoiden koon laskenta käyttämällä GetMaxWidth metodia width propertin sijaan
// - GridHighestRow(): SetGridHeight funktio korvattu GetMaxHeight metodilla
// - GridWidestCol():  SetGridWidth funktio korvattu GetMaxWidth metodilla
//
// 21    22.11.03 10:45 DEVELOPER2
// - Rinnakkaisliitynnä käsittely lisätty
// - Turhia paneeleja poistettu
// - Turhia käännöslippuja poistettu
// - FIRST_CABLE ja sen käsittely poistettu
//
// 20    9.11.03 15:23 DEVELOPER2
// Korjaus: Johto-osien johdot ja jakokeskukset korjattu piirtymään oikein, kun johto-osia listään, poistetaan tai ladataan.
//
// 19    9.11.03 14:10 DEVELOPER2
// - Korjaus: Muuntajalta (johto-osa 0) tuleva johto korjattu näkymään
//
// 18    9.11.03 14:05 DEVELOPER2
// Päivitykset Reijolta 3.11.2003
//
// 16    2.11.03 13:11 DEVELOPER2
// Korjaus. Unit johto lisätty
//
// 15    2.11.03 12:24 DEVELOPER2
// CableNola otettu käyttöön

unit Johto;

interface

uses
  { Omat unitit }
  Globals,    { Globaalit määritykset }
  Settings,   { Asetusolio }
  TextBase,   { Tekstivarasto }
  Defs,       { Yleiset asetukset }
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, StringGridNola, LabelNola, PanelNola, NolaComp,
  ToolWin, ComCtrls, ExtCtrls, Buttons,
  Unit1,Unit0{6.0.0},InfoDlgUnit{130.2e},
  CablePanelNola, CableImages, {=§u§ +8.0.7 lvExtended=}licenseFuncs, SyottoAv{Hide +120.5u};

type
  TJohtoType = (JOHTO_LAST, JOHTO_NORMAL, JOHTO_LIITTYMA);

  TJohto = class(TObject)
    canRefresh: boolean;
    locationIndex: integer; // Kertoo indeksin EdvNewFrmissa
    arrayIndex: integer;    // Kertoo indeksin tietorakenteessa
    FYLE: EdvTiedotType;
    FIsYLEValid: boolean;
    FIsSrcValid: boolean;
    FNjL:  EdvNjLahtoType;
    johtoType: TJohtoType;
    Fsrc: EdvSorceType;
    johdot: TObject;
    isSettingGridDimensions: boolean;

    currDataImagePotTasaus: Boolean;
    currDataImageHeight, currDataImageBorder: integer;

    { Propertien sisäiset muuttujat }
    FOpen: Boolean;
    // Flahto: TLahto;       { Lahto-johdot }
    FEdvJohto:  EdvPalstaType;
    FIsEdvJohtoValid: boolean;

    FWidth, FHeight, FLeft, FHeaderHeight, FFromLeft, FJohdotTop: integer;
    FRealWidth, FRealHeight, FRealFromLeft: integer;
    FRealHeaderHeight: integer;

    DefaultOpenButton: TSpeedButton;
    DefaultHideButton: TSpeedButton;

    { Komponentit }
    ParentHeaderPanel: TPanel;
    ParentDataPanel: TPanel;
    DataPanel:   TPanel;
    HeaderPanel: TPanel;
    headerImage, JakoKeskusImage, DataImage: TImage;
    HidePanel: TPanel;
    HideDataPanel: TPanel;
    HideButton: TSpeedButton; //<HideButton = KirjaAukiKuvakeBtn.
    OpenButton: TSpeedButton; //<OpenButton = KirjaKiinniKuvake (sinimen).
    Button: TButton;          //<Liittymän ja johto-osan Btn (= 0,1...n), kommentti +6.2.2
    ButtonHide: TButton;
    SulakeGrid, LahdotGrid: TStringGridNola;
    CablePanel: TCablePanelNola;

    procedure WriteYLE(var value: EdvTiedotType);
    procedure WriteNjL(var value: EdvNjLahtoType);
    procedure WriteEdvJohto(var value: EdvPalstaType);
    procedure WriteSrc(var value: EdvSorceType);
    function ReadYLE: EdvTiedotType;
    function ReadNjL: EdvNjLahtoType;
    function ReadEdvJohto:EdvPalstaType;
    function ReadSrc: EdvSorceType;
    procedure SetHeight(value: integer);
    procedure SetWidth(value: integer);
    procedure SetLeft(value: integer);
    procedure SetHeaderHeight(value: integer);
    procedure SetFromLeft(value: integer);
    procedure SetOpen(value: Boolean);
    function  GetRealWidth: integer;
    function  ReadCablePos: integer;

    // Function returns next TJohto object after this object
    // return: nil or next TJohto object
    function  GetNextJohto: TJohto;

    // Function checks if the next johto object has a connection
    // return: true if the next johto object exists and it has connection
    function  HasNextJohtoConnection: boolean;

    // Function refresh texts of the normal cable
    procedure RefreshNormal;

    // Function refresh texts of the last cable
    procedure RefreshLast;

    // Function refresh texts of the connection cable
    procedure RefreshConnection;

    // Sets the grids width and height to the correct ones
    function SetGridDimensions: boolean;

    procedure GridHighestRow(Sender: TObject; ACol, ARow: longint; newHeight: integer);
    procedure GridWidestCol(Sender: TObject; ACol, ARow: longint; newWidth: integer);
    procedure SetVisibles;
    procedure HideButtonClick(sender: TObject);
    procedure OpenButtonClick(sender: TObject);
    procedure  PohjaClick(Sender: TObject);
    procedure  PohjaDblClick(Sender: TObject);

    { Hiirenliikkeet}
    procedure DataMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MouseMoveRow1(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MouseMoveRow2(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MouseMoveRow4(Sender: TObject; Shift: TShiftState; X, Y: Integer);

  public

    constructor Create(ajohdot: TObject; aLocationIndex, aArrayIndex: integer;
                       atype: TJohtoType; aheaderPanel, adataPanel: TPanel;
                       aleft, awidth, aheight, afromLeft, aheaderHeight: integer;
                       aJohdotTop: integer;
                       aDefaultOpenButton, aDefaultHideButton: TSpeedButton);

    destructor Destroy; override;
    procedure  DrawGraphics;

    function   GetText(johto: integer; kohta: real): string;
    procedure  ReFresh;
    procedure  SetTexts;
    procedure  ReSize(aleft, awidth, aheight, afromLeft, aJohdotTop,aheaderHeight: integer);
    procedure  ReCalcRealValues;
    procedure  DrawToMetaFile(metafile: TMetaFile; OpenClosed: Boolean;
                              bgColor: TColor; pageWidth: integer);
    procedure  DrawNousuJohto (SjEj :boolean{+141.1});
    procedure  Hide;

// DEVELOPER2 2005-08-29 BEGIN +8.0.0
    function SetType(atype: TJohtoType): boolean;
    function SetArrayIndex(aArrayIndex: integer): boolean;
// DEVELOPER2 2005-08-29 END

    // Function returns the name of the cable that is used e.g. in the buttons
    // return: true if the the cable has connection cable
    function  GetName(): string;

    //property NjL:                  EdvNjLahtoType read FNjL       write WriteNjL;
    //property YLE:                  EdvTiedotType  read FYLE       write WriteYLE;
    //property EdvJohto:             EdvPalstaType  read FEdvJohto  write WriteEdvJohto;
    //property Src:                  EdvSorceType   read FSrc       write WriteSrc;
    property width:                integer read fwidth            write setWidth;
    property height:               integer read fheight           write setHeight;
    property headerHeight:         integer read fheaderheight     write setHeaderHeight;
    property fromLeft   :          integer read ffromLeft         write setFromLeft;
    property left:                 integer read fleft             write setLeft;
    property JohdotTop:            integer read fJohdotTop        write fJohdotTop;
    property realWidth:            integer read frealWidth        write FRealWidth;
    property realHeight:           integer read frealHeight       write FRealHeight;
    property realFromLeft:         integer read frealFromLeft     write FRealFromLeft;
    property realHeaderHeight:     integer read frealHeaderHeight write FRealHeaderHeight;
    property Open:                 Boolean read FOpen             write SetOpen;
    property CablePos:             integer read readCablePos;
  end;

  function ResizeGrid(grid: TStringGridNola): boolean;
  procedure SetText(grid: TStringGridNola; acol, arow: integer ; text: string);

  // Piirto funktiot

  // Procedure fills the whole image with white color.
  // Image: Image that is cleared
  procedure Clear(Image: TImage);

  procedure DrawAlasJohto(Image: TImage; height, border,{120.6:}ArrIndx,LocIndx,NayUPS: integer;  qType: TJohtoType);
  procedure DrawJohto(image: TImage; atype: TJohtoType; cablePos: integer);
  procedure DrawJakoKeskus(image: TImage; height: integer; middlePos: integer);

  procedure DrawLiittymaOsa(Image: TImage; middlePos: integer;
                            drawConnection: boolean; StartImageIndex: integer);

  procedure DrawMuuntaja(image: TImage; Sj: bool;  PenStyle :TPenStyle); //< 3.0.2  DEVELOPER1: lisätty  PenStyle

  // Yleisiä
  function  IsEqual(a, b: Pointer; size: integer): bool;
  function  IsEqualEdvTiedotType(var a, b: EdvTiedotType): bool;
  function  IsEqualEdvPalstaType(var a, b: EdvPalstaType): bool;
  function  IsEqualEdvSorceType(var a, b: EdvSorceType): bool;
  function  IsEqualEdvNjLahtoType(var a, b: EdvNjLahtoType): bool;

implementation
uses
    Johdot, Syotto, PaaVal, Y_, math, textBaseTexts, PrintDialogNola{, EdvNew{Kokeiluun r.2652},
    FormatCable, EdvNew{=§DemoL§ +8.0.7=},Asetus, Koe{KoeW_ 12.0.0};

const
  // Määrittelee rivin, kuinka monta riviä CablePanelNola-komponentissa on.
  // Kasvattamalla tätä lukua, voidaan rivien lukumäärää kasvattaa.
  CABLE_ROW_COUNT = 6;

  // Määrittelee rivin, josta alaspäin tiedot CablePanelNola-komponentissa kuvaavat
  // varsinaista johto-osaa eikä liityntäjohtoa.
  // Muuttamalla tätä arvoa, voidaan johto-osan ensimmäistä riviä siirtää.
  // Rivit 0-2 varattu liityntäjohdolle
  // Rivit 3-5 varattu johto-osalle.
  FIRST_CABLE_ROW = 3;

  // Määrittelee sulake symbolin etäisyyden yläreunasta rinnakkaisliitynnässä.
  CONNECTION_FUSE_TOP = 30;

  koeColor=false;    //<'Nyt tässä CONST´ina
  //koeColor=True;     //boolean; //<+9.0.1  Siirrtty1202 TJohto.Create´sta function g_()´n takia;
//================================================================================================================
procedure DefsFiL(si :string);      begin//+120.5no
   //¿DefsFileen(si);  end;
   YFileen('¿DefsFilL');  end;
function g_(CONST SI :string) :string;      begin  if isDebuggerPresent or KoeColor  then result := SI  else result := '';  end;
function q_(CONST SI :string) :string;      begin  if isDebuggerPresent or KoeColor  then result := SI  else result := '';    end; //<,+130.2e.
function q2(y,x :integer) :string;          begin  if isDebuggerPresent or KoeColor  then result := '~y'+Ints(y) +'x'+Ints(x)  else result := '';  end;
//,TulostusCellien etsintään kokeiluissa,  Etsi "Cmrk" ############################################ +8.0.0
function Cmrk (CONST si :string) :string;      begin if isDebuggerPresent or KoeColor  then result := si  else result := '';  end;
//================================================================================================================
procedure KorvaaDesMrk(VAR str :string);      VAR u :integer;  {boo :boolean;}      begin //<+120.5u:  DesimPISTE muutetaan PILKUKSI.
  {repeat u := u+1;
          boo := (u>1) AND (u<Length(str)) AND (str[u]='.') AND (CharInSet(str[u-1],['0'..'9'])); //[1]<>'.' & [vikaMrk]<>'.' & Pisteen edellä Nro.
          if boo  then
             str[u] := ',';
   until (u=Length(str)) or boo; //<Piste jonka vasPuol Nro.}
   for u := 1 to Length(str)  do                                  //<,,+120.5n
   if (u>1) and (str[u]='.') and (CharInSet(str[u-1],['0'..'9'])) //<Piste jonka vasPuol Nro.
      then str[u] := ',';
end;
//================================================================================================================
         //,,Palauttaa IkStrAlp :n stingin DIMension mukaiseksi muunnettuna stringiksi !!!!!!!!!!!!!!
function fIkDimAlpS (IkU :real;  IkStrAlp :string;  VAR Suus,Sdim :string) :string; //<,,,,,,,+5.0.1  6.0.2  6.0.4
      VAR Salp :string;

   function DimOK (dimSi :string) :boolean;      VAR d,divK,des :integer;  ar,ur,rr :real;
   begin
      result := false;                                //<,,Otettu ulos IF IkU>0 then begin -lauseesta 6.0.4
      d := Pos (dimSi,IkStrAlp);     //< ('kA','54.65 kA') =Tutkitaan, onko etsittävä dimensio (MA/kA/A) IkStr:ssä.
    //divK := 1;                                      //<Ettei warning:  Might not have been init.
      if d>0
      then begin                                      //<,,3.854 kA => 3.855 (2.673) kA,,,,,,,,,,,,,,,,,,,,,,,,,,,
         result := true;
         Sdim := dimSi;                               //<FNC palatuttaa tämän(kin)
         if Pos ('MA',IkStrAlp) > 0  then divK := 1000000  else
         if Pos ('kA',IkStrAlp) > 0  then divK :=    1000  else
                                          divK :=       1;
         ur := IkU/divK;
         SokR (IkStrAlp,ar);
         rr := ur;
         if rr=0  then rr := ar;
         if rr=0
         then  des := 0
         else begin                                   //<,,+6.2.1  UUSITTU:  Nyt desimLkm tutkitaan AlpStringistä
            d := Pos ('.',IkStrAlp);
            if d=0
            then des := 3
            else begin
               d := d +1;                             //<Aloitetaan desim.erottimen jälkeisestä
               des := 0;
               while (d<Length (IkStrAlp)) and (CharInSet(IkStrAlp[d], ['0'..'9']))  do begin
                  des := des +1;
                  d := d +1;  end;
            end;
         end;
         Suus := fRmrkt0 (ur,1,des);
         ar := fMuokDes (ar,des);
         Salp := fRmrkt0 (ar,1,des);  end
      else begin
         Suus := '0 ';                    //<6.2.1  Oli '0'
         Sdim := 'A';  end;
   end;
begin//fIkDimAlpS
   IkStrAlp := Trim (IkStrAlp);
   Salp := '';   Suus := '';   Sdim := '';
   if NOT DimOK ('MA')  then
   if NOT DimOK ('kA')  then
   if NOT DimOK ( 'A')  then Salp := IkStrAlp;            //<Jos ei mitään dimensiota, palautetaan ALP.
   KorvaaDesMrk(Salp);  //<+120.5u
   result := Salp;
end;//fIkDimAlpS
                  //,oh >0 =Demotesti +8.0.0        ,IkStr = Vertailuarvo, mihin verrataan:  Onko IkVaimOFAA pienempi.!!!
function fOFAAvaim_ (oh :integer;  IkVaimOFAA :real;  IkStr :string;  VAR IkOfaR,IkR :real;  VAR IkOfaS,IkS,Sdim :string) :string;
//+6.2.0             Esim. 1827.56      '17.23 kA'           1.83 17.23         '1.83' '17.23' 'kA'    => '1.83'
//                         0            '3.696 kA'           0      3.7         '0.00' '3.696' 'kA'    => '- - - -'
      VAR sx :string;  OnIecOfa,boo :boolean;   begin //IkVaimOFAA = Sulakkeen vaimentama Ik
                                                      //IkStr      = Ik, johon IkVaimIFAA:ta verrataan: onko eroa
   sx := IkStr;                                       //IkOfaR     = IkVaimOFAA, jossa desim.piste siirretty DIM muk.
  {OnIecOfa := a_getBoo (10001,edv.YLE.IecOfa);}      //IkR        = IkStr (ilman stringin dimensiotunnusta, real)
   OnIecOfa := true;
   if OnIecOfa OR  NOT OnIecOfa //<,,,,,,,,,,,,,,,,,,,,,Nyt ilmoitetaan AINA oli OFAA eli ei.!!!!,,,
   then begin                         //,Tekee IkStr:sta IkS:n, tutkii IkStr:sta myös dimension 'kA' tms. -> Sdim.
      IkS := fIkDimAlpS (IkVaimOFAA,IkStr, IkOfaS,Sdim);          //Tekee samalla dim:lla IkVaimOFAA:sta IkOfaS:n.
      SokR (IkS,IkR);   SokR (IkOfaS,IkOfaR);
    //sx := IkStr;                                                //<KOKEILU:  Näkee, onko vertailtava arvo oikein.
      if IkOfaR=0                                                 //<,,6.2.1  IkR => IkOfaR
      then sx := myTextBase.Get(EDV_VIRHE)//'- - - -'
      else
         if (IkOfaR>0) and (IkOfaR<IkR)
         then sx := IkOfaS
         else sx := myTextBase.Get(EDV_VIRHE);//'- - - -';
   end;
   boo := demo(31);
   if (oh>0) and boo  then                                                                       //<+8.0.0
      sx := sDemI;//'Xxx'; //fDemIx (1,666, 1); //< 1=Demotesti,  666=arvo,  Tab
   result := sx;
end;//fOFAAvaim_

///////////////////////////////////////////////////////////////////////////////
                   //,oh>0 =Demotesti   oo>0 =Näytetän OFAAn vaikutus.  +8.0.0
function fOFAAvaimIs (oh,oo :integer;  IkVaimOFAA :real;  IkStr :string) :string; //<,+5.0.1  6.0.2  6.0.4  6.2.0
                   //Rv 8,9:  Esim. 17231,        26.7 kA      => (17.2)26.7 kA  + VAIN SULKUOSA VÄRJÄTÄÄN.
                   //                   0         17.6 kA      => (----)17.6 kA
      VAR IkOfaR,IkR :real;  IkOfaS,IkS,Sdim, sx :string;  sulkuOs :integer;  boo :boolean;      begin

   boo := demo(32);
   sx := fOFAAvaim_ (oh,IkVaimOFAA,IkStr, IkOfaR,IkR, IkOfaS,IkS,Sdim); //<IkOfaR ja IkOfaS ei tässä tarvittaisi.
   if (oh>0) and (boo  or EXT_Demo)  then                                                                       //<+8.0.0
      Iks := sDemI;//'Xxx';
   if oo=0                                           //,############# Palautettava str ##########################
   then       sx :=                IkS +' ' +Sdim    //<  Ei laskettu/näytetä OFAAn vaikutusta.
   else begin sx := '(' +sx +') ' +IkS +' ' +Sdim;
      sulkuOs := Pos ('(',sx);                       //<,,Etsitään erikoisvärjäyksen alkukohta. JOS HALUTAAN
      if sulkuOs>0  then begin                       //   ERIKSEEN VÄRJÄTÄ MYÖS SULKEITA EDELTÄVÄ OSA, ON SE
         insert (COLOR_IK3D_,sx,sulkuOs);            //   TEHTÄVÄ KUTSUKOHDASSA, ETSI: "fOFAAvaimI..".
         sulkuOs := Pos (')',sx);
         if sulkuOs>0
            then insert ('</f>',sx,sulkuOs+1)
            else sx := sx +'</f>';
      end;
   end;
   result := sx;
end;
///////////////////////////////////////////////////////////////////////////////
                    //,oh>0 =Demotesti   oo>0 =Näytetän OFAAn vaikutus.  +8.0.0
function fOFAAvaimIts (oh,oo :integer;  IkVaimOFAA_th,IkVaimOFAA_s :real;  IkStrTh,IkStrD :string) :string; //<+6.2.0  6.2.1
      //Rv 10:  Esim. 17231,       23432         '23.4 kA'    => ofa Ik3t/3d (17.2/23.4 kA) + SULKUOSA VÄRJÄTÄÄN.
      VAR IkOfaR,IkR, eIkOfaR,eIkR :real;  IkOfaS,IkS,Sdim, sx,su :string;  boo,ebo :boolean;      begin

   boo := demo(33);  ebo := EXT_Demo;
   if oo=0
   then sx := ''
   else if (oh>0) and (boo  or ebo)                                                           //<,,,+8.0.0
   then sx := COLOR_IK3D_ +'(' +sDemI +'/' +sDemI +')</f>'
   else begin
      sx := fOFAAvaim_ (oh,IkVaimOFAA_th,IkStrTh, IkOfaR,IkR, IkOfaS,IkS,Sdim); //<IkOfaS ja IkS ei tässä tarvittaisi.
      eIkOfaR := IkOfaR;
      eIkR :=    IkR;
      sx := COLOR_IK3D_ +'(' +sx +'/';
      su := fOFAAvaim_ (oh,IkVaimOFAA_s,IkStrD, IkOfaR,IkR, IkOfaS,IkS,Sdim);   //<IkOfaS ei tässä tarvittaisi.
      if ((eIkOfaR=0) or (eIkOfaR>0) and (eIkOfaR>=eIkR))  AND               //<,,+6.2.1  UUSITTU. Estää tyhjien
         (( IkOfaR=0) or ( IkOfaR>0) and ( IkOfaR>= IkR))                    //   '----' kenttien loppuun 'kA' tai
         then Sdim := ''                                                     //   'A':n tulostumisen.
         else Sdim := ' ' +Sdim;                                             //<Eteen välilyönti.
      sx := sx +su +Sdim +')</f>';                   //<############# Palautettava str ##########################
   end;
   result := sx;
end;

///////////////////////////////////////////////////////////////////////////////
function IsEqual(a, b: Pointer; size: integer): bool;
begin
     result := CompareMem(a, b, size);
end;

///////////////////////////////////////////////////////////////////////////////
function  IsEqualEdvTiedotType(var a, b: EdvTiedotType): bool;      VAR boo :boolean{8.0.7};
begin     //'edv.YLE                //FNC Päivittää edv -kuvaajan jos TR 10.0.4u, kutsu ekaan (?) kuvaajan tekoon.
   //result := IsEqual(Addr(a), Addr(b), sizeof(EdvTiedotType));          //§DemoL§
     boo := IsEqual(Addr(a), Addr(b), sizeof(EdvTiedotType)); //< @:n strt//<Jos FA => piirretään.  AsTapDeb§
    {if boo  then                                                         //<Jos EI eroja, tarkist. josko lic.ero
        boo := NOT DemoLaajMuutos;                                        //<+8.0.7 Nyt piirtää uusiksi jos Demo-}
     result := boo;                                                       //        Laajuus muuttuu. 'TätäEiTarvita
end;

/////////////////////////////////////////////////////////////////////// ,,,Päivittää edv -kuvaajan jos FA 10.0.4u
function  IsEqualEdvPalstaType(var a,b: EdvPalstaType): bool;      (*VAR onSama :boolean{8.0.7};  srcja :integer;  ar :real{+130.2e};
begin     //'edv.Edka[]     Kutsu:  TJohto.WriteYLE(var value: EdvTiedotType); :stä     //<edv.YLE
          //                        if (IsEqualEdvTiedotType(value,FYLE) = FALSE) then  //AsTapDeb§   @:n käynnistyksessä
          //KUTSUSSA SIIS FYLE =IsEqualEdvPalstaType.
   onSama := IsEqual(Addr(a), Addr(b), sizeof(EdvPalstaType));             //<Jos FA => piirretään.
   if onSama  then                                                         //<Jos EI eroja, tarkist. josko lic.ero
      onSama := NOT DemoLaajMuutos;                                        //<+8.0.7 Nyt piirtää uusiksi jos DemoLaa
   srcja := edv.YLE.SorceCount.arvoInt;                                    //        juus muuttuu.
   if onSama  and (srcja>1) then //EdvJohto edv.edka[1]                    //<,,+8.0.8 Ei piirtänyt uusiksi jos [1]
      onSama := a.Nimi.arvoStr = edv.edka[srcja].Nimi.arvoStr;             //   .Nimi ja [vika].Nimi olivat eri, eli
  {if a.Nimi.arvoStr <> b.Nimi.arvoStr                                     //   jos nimi muuttui [1]:een ja [vika]
      then beep;}                                                          //   oli vanha.
  {if FYLE.AsTapa.arvoStr<>''                                              //<Ei onaaa.
      then beep;}
 //if edvE<>edv                                                            //<Ei onaa.
   if edv.YLE.ZpeBx.arvoBoo<>edvE.YLE.ZpeBx.arvoBoo //<,Erikoistesti pakko, IsEqua.. ei havaitse ZpeBx:n muutosta.
      then onSama := false;                         //<'+9.0.1

   if onSama  then                                  //<,,+10.0.4§  TR = Ei ollut kuvaajan päivitystarvetta.
   if AsetusOkBtnSulkiSyoFrmin  and                 //<Ks. Asetus.PAS + Syotto.PAS OnCloseForm.
      (fKaikkiOikeudet_1x  or alpKaikkiOikeudet_1x)
      then onSama := false;                         //<'KaikkiOikeudet_1x-muutos ei päivittänyt kuvaajaa.+10.0.4§

   if onSama  then                                  //<,,+10.0.4§  TR = Ei ollut kuvaajan päivitystarvetta.
   if edi>=Edv.Yle.JohtoOsia.ArvoInt  then begin
      SokR(EdvNewFrm.LaakMBx.Text,ar);
      if (ar<>alpLaakPmu) or (alpSuk<>EdvNewFrm.UkBx.Text)
         then onSama := false;
      alpLaakPmu := edv.Yle.LaakPmu.ArvoRea;        //<+130.2e  <,Nämä siirretty tänne, jotta testi menisi oikein, muualla muuttuisi liian aikaisin.
      alpSuk := Trim (EdvNewFrm.UkBx.Text);         //<+130.2e}
   end;//-------- *)
begin
   result := false;//}onSama;                       //<FA saa kuvaajan päivittymään.  Nykyisillä koneilla vaikka aina kuvake uusitaan, ei viivettä synny.
end;                                                //'Nykyisi viimeisin ongelma oli: pvitti jOsa 1´n muttei 01´tä

///////////////////////////////////////////////////////////////////////////////
function  IsEqualEdvSorceType(var a, b: EdvSorceType): bool;      VAR boo :boolean{8.0.8};
begin     //'edv.Sorc[]
     boo := IsEqual(Addr(a), Addr(b), sizeof(EdvSorceType));
     result := {false;//}boo; //<Tässäkin FA saa aikaan uudelleenpiirtämisen.
end;

///////////////////////////////////////////////////////////////////////////////
function  IsEqualEdvNjLahtoType(var a, b: EdvNjLahtoType): bool;
begin     //'edv.NjL
     result := IsEqual(Addr(a), Addr(b), sizeof(EdvNjLahtoType));
end;

///////////////////////////////////////////////////////////////////////////////
procedure Clear(Image: TImage);
begin
     image.canvas.brush.color := {£$£c: clSilver; }clWhite;
     image.Canvas.FillRect(Rect(0,0, image.width{-4£$£},image.height));
end;

///////////////////////////////////////////////////////////////////////////////
procedure DrawAlasJohto(Image: TImage; height, border,{120.6:}ArrIndx,LocIndx,NayUPS: integer;  qType: TJohtoType);
   VAR x1,x2, y1,y2,n: integer;  ri,rc :real{1412};

   procedure DrawUPSj;      VAR X,Y, h,w :integer; //<,,Tämä kopioitu CableImage.PAS / PRC UPS, muokattu samalle Imagelle kuinAlasJohto. +120.6
      function half (mitta :integer) :integer;      begin result := trunc (mitta/2 +0.5);  end; //ReadEdvJohto().PTLopussa.ArvoBool
   begin//DrawUPSj...........................................                                   //ReadEdvJohto().RyhmaJohto[ao1].rjpituus[ao2].pituus.ArvoReal
      h := 18;//HEIGTH;
      w := 22;//20;
if NayUPS>0  then begin  //<1412:  Kylläkin jo testattu.//<141.1:  Jos 0, ei AlasJohtoUps´ia piirretä.
      Image.Canvas.Brush.Style := bsClear;
      Image.Canvas.Brush.Color := clWhite;//}clAqua;    //<HAVAINNOLLINEN, isompi kuin pyyhittävä alue.
      Image.Canvas.Pen.Color := clFuchsia;              //<Raamin piirtoväri.
      X := x1+half(w)-2;  Y := 0;                       //<',,Jostain syystä mitat muuttuivat, nyt tarkasti oikein.  //120.5n: -2
    //Image.Canvas.FillRect(Rect(X,Y, X+30,Y+30));      //<'+120.6: Putsataan alastuleva johtoviiva UPS´in kohdalta. -120.5n/6U
      Image.Canvas.FillRect(Rect(X,Y, X+30,Y{+30}));    //<'+120.6: Putsataan alastuleva johtoviiva UPS´in kohdalta.

      x1 := image.width{220} - EDV_JOHTO_BORDER{20} + EDV_JAKOKESKUS_WIDTH{8} div 2; //<204
    //X := x1-half(w);  Y := 0;  //Oli 120.5h
      Image.Canvas.Rectangle(Rect(X-1,Y, X+w,Y+h));     //<'+120.6: Putsataan alastuleva johtoviiva UPS´in kohdalta.
//if NayUus>0  then begin                                 //<141.1:  Jos 0, ei AlasJohtoUps´ia piirretä.
      Image.Canvas.Font.Size := 8;
      Image.Canvas.Pen.Width := 1;
     {Image.Canvas.TextOut (half(w - Image.Canvas.TextWidth('ups')),            // ups -teksti keskelle suorakaidetta
                            half(h - Image.Canvas.TextHeight('ups')-3), 'ups'); //< -3 korkeusaseman korjaus.}
      Image.Canvas.TextOut (X+2,1,'ups'); //<141.2: 2=>1 ja upS =löytyy haulla "upS" case sensitv.
end;//if NayUPS>0
                           {if IsDebuggerPresent  then begin
                               Image.Canvas.TextOut (X+3,20,'jNo'+Ints(NayUus));
                               Image.Canvas.TextOut (X+3,32,'arx'+Ints(ArrIndx));
                               Image.Canvas.TextOut (X+3,44,'lox'+Ints(LocIndx));
                               DrawUpsFileen('arx:'+Ints(ArrIndx) +' lox:'+Ints(LocIndx) +'  jNo:'+Ints(NayUus) +'  X:' +Ints(X));
                               DrawUpsFileen('');
                            end;}
  //end;//if ..IndexOf <0
   end;//DrawUPSj


   procedure AngleTextOut(ACanvas: TCanvas; Angle, X, Y: Integer; Str: string); //http://www.scalabium.com/faq/dct0002.htm +1412.
   var
     LogRec: TLogFont;
     OldFontHandle,
     NewFontHandle: hFont;
   begin
     GetObject(ACanvas.Font.Handle, SizeOf(LogRec), Addr(LogRec));
     LogRec.lfEscapement := Angle*10;
     NewFontHandle := CreateFontIndirect(LogRec);
     OldFontHandle := SelectObject(ACanvas.Handle, NewFontHandle);
     ACanvas.TextOut(X, Y, Str);
     NewFontHandle := SelectObject(ACanvas.Handle, OldFontHandle);
     DeleteObject(NewFontHandle);
   end;

begin//DrawAlasJohto........................................
//NayUPS := 0;
     Clear(image);
     { Piirretään johto. DEVELOPER1: Alas lähtevä, alapäästän vino =´Resurssi´johto}
     image.canvas.pen.color := EDV_JOHTO_COLOR;
     image.canvas.pen.width := EDV_JOHTO_WIDTH{1};
     image.canvas.pen.style := psSolid;
//JFileen('');                                           //,,+120.5n/6, 1412. Windows.beep(4000,500);  Windows.beep(500,50); Windows.beep(1000,50); Windows.beep(2000,50);
                            {if UpsNyt then begin        //jNo := edv.YLE.SorceCount.ArvoInt; //Edja :=  edv.YLE.JohtoOsia.ArvoInt;
                                x1 := LocIndx +ArrIndx;  //N1+2, N0+1, L0+1, N1+2,     N=Normal L=Liittymä
                                //x1 := LocIndx;
                                if x1>edi then ;
                                if qType=JOHTO_LIITTYMA
                                   then JFileen('>A JOHTO_LIITTYMA')  //<  ">" poistaa päiväyksen alusta.
                                   else if qType=JOHTO_NORMAL
                                     then JFileen('>A JOHTO_NORMAL')
                                     else  JFileen('>A Johto???');
                                JFileen('  A LocIndx=' +Ints(LocIndx));
                                JFileen('  A ArrIndx=' +Ints(ArrIndx));
                                JFileen('  A x1     =' +Ints(x1));
                                JFileen('  A Edi    =' +Ints(Edi));
                             end;//if UpsNyt}
     x1 := image.width{220} - EDV_JOHTO_BORDER{20} + EDV_JAKOKESKUS_WIDTH{8} div 2; //<204
     y1 := 0;
     x2 := x1;                    //<Delphi: Never used ??? -8.0.0
     y2 := height{224}-15;        //<130.23: -15  Vino viivaosuus jäi uk -rvn(22) alle.

                             if UpsNyt and (NayUPS>0)  then begin        //<,,+120.5n/6  NayUps:+1412
                                {Image.Canvas.TextOut (X1-10,y2-10,'TXTupsikoe'); //£$£ upsKoeTxt  =OK.
                                 AngleTextOut(ACanvas: TCanvas; Angle, X, Y: Integer; Str: string);}
                                image.canvas.font.Name := 'Arial';                                 //<,,+1412.,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                                //image.canvas.font.Style := [fsBold];
                                image.canvas.font.Size := 10;
                                image.canvas.font.Color := clFuchsia;
                                //n := ArrayIndex-Srcja;             //<Ei worki täällä. => Edi.
                                n{Srcja} := edv.YLE.SorceCount.ArvoInt;
                                n := {Edi;  //Oli: }ArrIndx -n{Srcja};  //=1412:  Nyt Edi workkii täällä OK.
                                ri := 0;  rc := 0;
                                if qType=JOHTO_LIITTYMA
                                then begin
                                   if edv.Sorc[1].Josa.JkUps.ArvoInt >0
                                      then begin ri := edv.Sorc[1].Josa.JkUps_Ik1v.ArvoRea;
                                                 rc := edv.Sorc[1].Josa.JkUps_Cos.ArvoRea;  end; end
                                else if edv.Edka[n].JkUps.ArvoInt >0
                                     then begin ri := edv.Edka[n].JkUps_Ik1v.ArvoRea;
                                                rc := edv.Edka[n].JkUps_Cos.ArvoRea;  end;
                                if (ri>0) and (rc>0)  then
                                   AngleTextOut(image.canvas,    -90,    X1,y2-180, 'Ik1v: ' + fRmrkt0(ri,1,2) +' kA  Cos: ' +fRmrkt0(rc,1,2));
                             end;//if UpsNyt

     image.canvas.pen.color := EDV_JOHTO_COLOR;
     image.canvas.MoveTo(x1, y1); //<109, 0
     image.canvas.LineTo(x2, y2); //<109, 0

     x1 := x1 - EDV_NOUSUJOHTO_FROM_RIGHT{20}; //<204, 184
   //y1 := y2 + border{14};
     y1 := y2 + border{14}+20;          //<130.23: +..
     image.canvas.LineTo(x1 , y1);      //<DEVELOPER1: Vasemmalle vinoon alas              //,,+120.6
   //image.canvas.LineTo(x1-20, y1+50); //<DEVELOPER1: Vasemmalle vinoon alas              //,,+120.6
     JFileen('>>>Pysähdys Johto.PAS / A JOHTO_');  //JFileen('');
                             //if EdvJohto{ReadEdvJohto()}.JkUps.ArvoInt >0  then
                             //if edv.Edka[jNo].JkUps.ArvoInt >0  then    *)
   if NayUPS >= 0
      then DrawUPSj;
(*,,Nämä tarkemmin tutkittu kutsukohdassa. =141.1 ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
{}   if UpsNyt then                                                             //<,,+120.5n/6         //,Tai  (a_getIntg(6666,edv.Edka
     [edi].JkUps>0)
     if (qType=JOHTO_NORMAL)   and (edv.Edka[edi].JkUps.ArvoInt<>0) OR   //(ArrayIndex=edv.YLE.SorceCount.arvoInt)
        (qType=JOHTO_LIITTYMA) and (edv.Sorc[edi].Josa.JkUps.ArvoInt<>0) //<,,SrcEdka workkisi tässäkin, koklattu.
        then begin                                                       //if NOT SrcEdka and (edv.Edka[edi].JkUps.ArvoInt<>0)     OR
           DrawUPSj;                                                     //       SrcEdka and (edv.Sorc[edi].Josa.JkUps.ArvoInt<>0)
      //then DrawUPSj;                  //<+120.6: Vasta tässä jotta FillRect pyyhkisi viivasta osan altaan vex.
           JFileen('B  [edi='+Ints(Edi) +'].JkUps.ArvoInt='      +Ints(edv.Edka[edi].JkUps.ArvoInt));
           JFileen('B  [edi='+Ints(Edi) +'].Josa.JkUps.ArvoInt=' +Ints(edv.Sorc[edi].Josa.JkUps.ArvoInt));
           JFileen('  B x1     =' +Ints(LocIndx +ArrIndx));
        end else begin
           JFileen('C  [edi='+Ints(Edi) +'].JkUps.ArvoInt='      +Ints(edv.Edka[edi].JkUps.ArvoInt));
           JFileen('C  [edi='+Ints(Edi) +'].Josa.JkUps.ArvoInt=' +Ints(edv.Sorc[edi].Josa.JkUps.ArvoInt));
           JFileen('  C x1     =' +Ints(LocIndx +ArrIndx));  end;
   //EdvNewFrm.OpenButton.{Refresh}Transparent := false;          //<+120.6: oskohan korjaisi OpenButtonin ehjäksi, avautui OK, mutta klikkaukset muualle*)
                         x1 := LocIndx +ArrIndx;     //N1+2, N0+1, L0+1, N1+2,     N=Normal L=Liittymä                              'poisti vähän vasOsaa.
                         if x1 >edi then ;           //<''Vain kokeiluun.
     JkUpsChk_Dlg := false;                          //<+130.3u: FA kun Dlg -vaihe valmis =Kun piirretty. 1412: Mahtaako enää olla OK (vrt.OnCloseFrm´ssa := ???).
end;//DrawAlasJohto

///////////////////////////////////////////////////////////////////////////////
procedure DrawJohto(Image: TImage; atype: TJohtoType{DEVELOPER2}; cablePos: integer);
var
   x1, x2, y1{, y2}: integer;
begin
     // Poistetaan edelliset kaapelien piirrot
     Clear(image);

     image.canvas.pen.color := EDV_JOHTO_COLOR;
     image.canvas.pen.width := EDV_JOHTO_WIDTH;

     case atype of
     JOHTO_LAST:                   image.canvas.pen.style := psDot;
     JOHTO_NORMAL..JOHTO_LIITTYMA: image.canvas.pen.style := psSolid;
     end;

     x1 := -1;
     y1 := cablePos;
     x2 := Image.Width + 1;
     //y2 := y1;

     image.canvas.MoveTo(x1 , y1);
     image.canvas.LineTo(x2 , y1);
end;

///////////////////////////////////////////////////////////////////////////////
procedure DrawJakoKeskus(Image: TImage; height: integer; middlePos: integer);
var
   aRect: tRect;
begin
     // Poistetaan edelliset piirrot
     Clear(image);

if height<28  then height := 28;                  //<+1412:  Rupesi tekemään matalia jakokeskuksia, tämä varmistukseksi, tarpeen, puhdistamiseen tms joskus 253,
                                                  //         mahtaisiko johtua ettei F9 riitä aina, po. Build All =Kokeilin, ei auta, korjaus tarvitaan.
     image.canvas.brush.color := EDV_JOHTO_COLOR; //clSilver; =tunnistamiseen, Image tässä on Jakokeskus.
  if KoeColor  then                               //<,+120.5o
     image.canvas.brush.color := clSilver;

     image.canvas.Brush.style := bsSolid;

     arect.top :=    middlePos - height{28} div 2; //=22 MiddPos kertoo kaapelin sijainnin joten jakokeskus on keskitettävä sen ympärille.

     arect.Left :=   -1;
     arect.bottom := arect.top + height;// -40;    //<130.2e:  -40 =JKmustasa alaosa delautuu, ylös jää ~15pix mustaa JKn symbolista.
     arect.right :=  EDV_JAKOKESKUS_WIDTH;

     image.canvas.FillRect(aRect); //KESKEN KESKEN??

     // Piirretään johdon jatko
     image.canvas.MoveTo(0 , middlePos);
     image.canvas.LineTo(image.width, middlePos);
end;

///////////////////////////////////////////////////////////////////////////////
procedure DrawLiittymaOsa(Image: TImage; middlePos: integer; drawConnection: boolean;
                          StartImageIndex: integer);
var
  symbol: TImage;
  symbolLeft: integer;   Kind :integer{DEVELOPER1};
begin
     // Poistetaan edelliset piirrot
     Clear(image);

     image.canvas.brush.color := EDV_JOHTO_COLOR;
  if KoeColor  then                            //<,+120.5o
     image.canvas.brush.color := clSilver;
     image.canvas.Brush.style := bsSolid;

//,,,TÄSSÄ "toistetaan" LIITTYMÄN SYMBOLI: SJ/PJ/Gener/UPS. SYMBOLI ON MÄÄRÄTTY PRC TJohdot.DrawGraphics,,,,,,,,,
     // Liityntä kuvaajan symboli. Kopioidaan symbolin pystyssä oleva versio.
     Kind := StartImageIndex;
     symbol := SorceImages[Kind].imageVertical; //<Kind:   1=Transformer  2=LV-Cable  3=Generator  4=UPS

     // Keskitetään symboli
//   if symbol<>NIL  then                                 //<+12.0.04  Ehto lisätty. symbol=NIL todettu => Err.  NOLALIS´n tarkistusten jälkeen eiTarvita.
        symbolLeft := (Image.width - symbol.Width) div 2;
    {w := symbol.Width;
     symbolLeft := (Image.width - w) div 2;}
     image.Canvas.CopyMode := cmSrcCopy;
     image.canvas.CopyRect(Rect(symbolLeft, 0, symbolLeft + symbol.width, symbol.height),
                           symbol.canvas,
                           Rect(0,0, symbol.width, symbol.height));

     // Viiva alas symbolin jälkeen
     image.canvas.MoveTo(Image.Width div 2, symbol.height);
     image.canvas.LineTo(Image.Width div 2, middlePos);

     // Sulake
     // Kopioidaan symbolin pystyssä oleva versio
     symbol := ProtectImages[CABLE_IMAGES_SULAKE].imageVertical;

     // Keskitetään symboli
     symbolLeft := (Image.width - symbol.Width) div 2;
     image.Canvas.CopyMode := cmSrcCopy;
     image.canvas.CopyRect(Rect(symbolLeft, CONNECTION_FUSE_TOP, symbolLeft + symbol.width, CONNECTION_FUSE_TOP + symbol.height),
                           symbol.canvas,
                           Rect(0,0, symbol.width, symbol.height));

     // Viiva jako-osien väliin
     if (drawConnection) then
        // Piirretään yhdistävä viiva johto-osien väliin
        image.canvas.MoveTo(0, middlePos)
     else
        // Piirretään vain oikean puoleinen johto-osa
        image.canvas.MoveTo(Image.Width div 2, middlePos);

     image.canvas.LineTo(Image.Width, middlePos);
end;

///////////////////////////////////////////////////////////////////////////////
procedure DrawMuuntaja(image: TImage; Sj: bool;  PenStyle :TPenStyle); //< 3.0.2  DEVELOPER1: lisätty  psSolid
var
   x1,y1, x2,y2: integer;
begin
     image.canvas.pen.color := EDV_JOHTO_COLOR;
     image.canvas.pen.width := EDV_JOHTO_WIDTH;

   //image.canvas.pen.style := psSolid;
     image.canvas.pen.style := PenStyle;  //< 3.0.2  DEVELOPER1

     image.canvas.brush.color := EDV_JOHTO_COLOR;
     image.canvas.Brush.style := bsClear;

     image.Canvas.brush.style := bsSolid;
     image.canvas.FillRect(Rect(0,0, image.width, image.height));
     image.Canvas.brush.style := bsClear;
     if (SJ = TRUE) then
     begin {Suurjännite }
          x1 := image.width - (EDV_JOHTO_BORDER + EDV_MUUNTAJA_WIDTH div 2);
          y1 := 0;
          x2 := image.width - EDV_JOHTO_BORDER;
          y2 := EDV_MUUNTAJA_HEIGHT;

          image.canvas.Ellipse(X1, Y1, X2, Y2);

          x1 := x1;
          y1 := y2 - 4;
          x2 := x2;
          y2 := y1 + y2;

          image.canvas.Ellipse(X1, Y1, X2, Y2);

          x1 := x1 + (x2 -x1) div 2;
          image.canvas.MoveTo(x1 , y2);
          image.canvas.LineTo(x1 , image.height);
     end
     else
     begin {Pienjännite }
          x1 := image.width - (EDV_JOHTO_BORDER + EDV_MUUNTAJA_WIDTH div 4 + 1);
          y1 := EDV_MUUNTAJA_HEIGHT;
          image.canvas.MoveTo(x1 , y1);

          x2 := image.width - (EDV_JOHTO_BORDER + EDV_MUUNTAJA_WIDTH div 2);
          y2 := 2;
          image.canvas.LineTo(x2 , y2);

          x2 := image.width - EDV_JOHTO_BORDER; //<120.5no:  Oli ;;
          y2 := y2;
          image.canvas.LineTo(x2 , y2);

          x1 := x1;
          y1 := y1;
          image.canvas.LineTo(x1 , y1);

          image.canvas.LineTo(x1 , image.height);
     end

end;//DrawMuuntaja

///////////////////////////////////////////////////////////////////////////////
function ResizeGrid(grid: TStringGridNola): boolean;
begin
     result := false;

     if grid <> nil then
     begin
          if (grid.height <> grid.GetMaxHeight) then
          begin
               grid.height := grid.GetMaxHeight;
               result := true;
          end;

          if (grid.width <> grid.GetMaxWidth) then
          begin
               grid.width := grid.GetMaxWidth;
               result := true;
          end;

          if (result) then
               grid.refresh;
     end;
end;//ResizeGrid

///////////////////////////////////////////////////////////////////////////////
procedure SetText(grid: TStringGridNola; acol, arow: integer; text: string);     {VAR sn :string;      }begin
     if grid <> nil then
     begin              {if grid.Cells[acol-1,arow] <>''
                            then ;}   {sn := TagVex(text);  sn := Trim(sn);  if sn='!"#¤'  then ;
                        if isDebuggerPresent  then begin
                           if (arow>=grid.RowCount)
                              then Wbeep([200,200, 0,300, 200,200]);
                           if (acol>=grid.ColCount)
                              then Wbeep([2000,200, 0,300, 2000,200]);  end;}
          if (arow >= 0) and (arow < grid.RowCount) and
             (acol >= 0) and (acol < grid.ColCount) then
             grid.Cells[acol, arow] := text;
         {if (arow >= 0) and (arow+1 < grid.RowCount) and  //<+130.2e: +1  £uk
             (acol >= 0) and (acol   < grid.ColCount) then //begin
             grid.Cells[acol, arow+1] := text;             //<+130.2e: +1  £uk}
                             {if (acol=2) and (arow>11) and (Pos('5x',text)=0)  then              //<,+130.2e: +1  £uk
                                 grid.Cells[0, arow] := 'c:' +Ints(acol) +' r:' +Ints(arow);  end;}
         {if sn<>''
             then ;}
     end;
end;

///////////////////////////////////////////////////////////////////////////////
constructor TJohto.Create(ajohdot: TObject; aLocationIndex, aArrayIndex: integer;
                          atype: TJohtoType; aHeaderPanel, aDataPanel: TPanel;
                          aleft, awidth, aheight, afromLeft, aHeaderHeight: integer;
                          aJohdotTop: integer;
                          aDefaultOpenButton, aDefaultHideButton: TSpeedButton);      VAR koeColor :boolean;//+130.2e
begin
  koeColor := false; //+9.0.1:  FA normaaliajossa.
//koeColor := true;  //+9.0.1:  TR=Vaihtaa testivärit +tunnistusmrkt (øN). 120,5no:  Oli ;  <,NYT CONST alussa.
Tics ('TJohto.Create 1');
     DataImage :=         nil;
     canRefresh :=        false;
     locationIndex :=     aLocationIndex;
// DEVELOPER2 2005-08-29 BEGIN +8.0.0
     setArrayIndex(aArrayIndex);
// DEVELOPER2 2005-08-29 END
     DefaultOpenButton := aDefaultOpenButton;
     DefaultHideButton := aDefaultHideButton;
     fopen :=             True;
     johdot :=            ajohdot;
     ParentDataPanel :=   aDataPanel;
     ParentHeaderPanel := aHeaderPanel;
// DEVELOPER2 2005-08-29 BEGIN +8.0.0
     SetType(atype);
// DEVELOPER2 2005-08-29 END
     isSettingGridDimensions := false;
     FLeft :=             -1;
     FWidth :=            -1;
     FHeight :=           -1;
     FFromLeft :=         -1;
     FHeaderHeight :=     -1;
     FJohdotTop :=        -1;

     FRealWidth :=        0;
     FRealHeight :=       0;
     FRealHeaderHeight := 0;
     FIsYLEValid :=       false;
     FIsSrcValid :=       false;
     FIsEdvJohtoValid :=  false;

     HeaderPanel :=          TPanel.Create(nil); //<,,SulakeSymboli + JohtoNoBtn + JK-symboli,,,,,,,
     HeaderPanel.Visible :=  False;
     HeaderPanel.Left :=     Left;
     HeaderPanel.Width :=    Width;
     HeaderPanel.Height :=   HeaderHeight;
     Headerpanel.Parent :=   parentHeaderPanel;
     HeaderPanel.Caption :=  '';
     HeaderPanel.Color :=    EDV_POHJA_COLOR; //<En saa esim. clAqua´ksi.
     //{£$£c:} HeaderPanel.Color := clLime;
   if koeColor  then
     HeaderPanel.Color :=    clAqua; //§§§c§§§  clSilver on tummempi kuin clBtnFace
     Headerpanel.BevelOuter :=  bvNone;
     HeaderPanel.Visible :=     True;
     HeaderPanel.OnMouseMove := MouseMoveRow2;
     headerPanel.OnClick :=     PohjaClick;
     headerPanel.OnDblClick :=  PohjaDblClick;

     DataPanel :=          TPanel.Create(nil); //<,,Ik1,Ik3v,Sulake yms.,,,,,,,,,,,,,,,,,,,,,,,,,,,,
     DataPanel.Visible :=  False;
     DataPanel.Left :=     Left;
     DataPanel.Width :=    Width;
     DataPanel.Height :=   Height;
     Datapanel.Parent :=   parentDataPanel;
     DataPanel.Caption :=  '';
     DataPanel.Color :=    {clFuchsia;//Lime;//}EDV_POHJA_COLOR;
     //{£$£c:} DataPanel.Color := clYellow;
   if koeColor  then
     DataPanel.Color :=    clYellow;//clLime; //§§§c§§§ Otsikkopanelin = 6..35 korkuinen, johto-osan levyinen.
     Datapanel.BevelOuter:=bvNone;
     DataPanel.Visible :=  True;
     DataPanel.OnMouseMove := DataMouseMove;
     DataPanel.OnClick :=     PohjaClick;
     DataPanel.OnDblClick :=  PohjaDblClick;

     HidePanel :=          TPanel.Create(nil); //<,,Kavennettu johto-osatietojen palsta,,,,,,,,,,,,,
     HidePanel.Visible :=  False;
     HidePanel.Left :=     Left;
     HidePanel.Height :=   HeaderHeight;
     HidePanel.Width :=    width;
     HidePanel.Parent :=   parentHeaderPanel;
     HidePanel.Caption :=  '';
     HidePanel.Color :=    EDV_POHJA_COLOR;
     //{£$£c:} HidePanel.Color := clBlue;
   if koeColor  then
     HidePanel.Color :=    clBlue; //§§§c§§§
     HidePanel.BevelOuter := bvNone;
     HidePanel.OnClick :=    PohjaClick;
     HidePanel.OnDblClick := PohjaDblClick;

     HideDataPanel :=           TPanel.Create(nil);
     HideDataPanel.Visible :=   False;
     HideDataPanel.Parent :=    parentDataPanel;
     HideDataPanel.Caption :=   '';
     HideDataPanel.Color :=     EDV_POHJA_COLOR;
     //{£$£c:} HideDataPanel.Color := clGreen;
   if koeColor  then
     HideDataPanel.Color :=     clYellow; //§§§c§§§ +120.5o
     HideDataPanel.BevelOuter:=bvNone;
     HideDataPanel.Ctl3D :=       False;
     HideDataPanel.BorderStyle := bsSingle;
     HideDataPanel.OnMouseMove := DataMouseMove;
     HideDataPanel.OnClick :=     PohjaClick;
     HideDataPanel.OnDblClick :=  PohjaDblClick;

     // Create a cable panel
     CablePanel := TCablePanelNola.Create(HeaderPanel);
     CablePanel.parent := HeaderPanel;
     CablePanel.left := 0;
   //CablePanel.Color := clYellow; //<+130.2e: Jossain muualla ajoversion Color. Otsikkopaneli =Ylin osa verkkokuvaajasta.###################################
   if koeColor  then               // =Liittymä + johto PK´lle +yläpuolen tekstit: Muuntaja 800kVA +5xAMCMK 185 ... 8m SÄL 80° k=1.
     CablePanel.Color := clAqua;   //§§c§§ koe OK +806  Otsikkopanelin =vaakaviivan yläp. osa kullakin johto-osalla.
//   CablePanel.OnClick :=  PohjaClick;//TxtClick; //<+8.0.3

     // Määrätään kuinka monta riviä on käytössä johdon yläosassa.
     CablePanel.rowcount := CABLE_ROW_COUNT;
     HideButton := CablePanel.MinimizeButton;

     HideButton.tag :=     PRINT_DISABLED;              //<,,HideButton = KirjaAukiKuvakeBtn, kommentti +8.0.6
     // HideButton.Parent :=  HeaderPanel;
     HideButton.Visible := True;
     HideButton.OnClick := HideButtonClick; //TJohdot(johdot).ButtonClick; //806 koe: Ei tapahdu mitään.
     HideButton.Glyph :=   DefaultOpenButton.Glyph;
     HideButton.Height :=  EDV_BUTTON_HEIGHT;//DefaultOpenButton.Height-2; //<, -2 =3.0.2  DEVELOPER1, -3 =8.0.6
     HideButton.Width :=   EDV_BUTTON_WIDTH; //DefaultOpenButton.Width -2; //Jos tämän muuttaa -3:ksi, häviää Btn osaksi InfoBtn´in alle.
     HideButton.OnMouseMove := MouseMoveRow2;          //'806

     OpenButton :=         TSpeedButton.Create(HidePanel); //<,,OpenBtn=KirjaKiinni
     OpenButton.tag :=     PRINT_DISABLED;
     OpenButton.Parent :=  HidePanel;
     OpenButton.Visible := True;
     OpenButton.OnClick := OpenButtonClick;
     OpenButton.Glyph :=   DefaultHideButton.Glyph;
     OpenButton.Height :=  EDV_BUTTON_HEIGHT;//DefaultHideButton.Height-3; //<, -2 =3.0.2  DEVELOPER1, -3 =8.0.6
     OpenButton.Width :=   EDV_BUTTON_WIDTH{£$£c}; //DefaultHideButton.Width -3;
     OpenButton.OnMouseMove := MouseMoveRow2;
     HidePanel.Width :=        OpenButton.width;
     HideDataPanel.Width:=     OpenButton.width;

    { HideDataimage :=             TImage.Create(HideDataPanel);
     HideDataimage.Parent :=      HideDataPanel;
     HideDataimage.Transparent := True;
     HideDataImage.Width :=       OpenButton.Width;
     HideDataimage.Height :=      2000;
     HideDataimage.Autosize :=    False;
     HideDataimage.Stretch :=     False;  }

      buttonHide :=         TButton.Create(HidePanel);
      buttonHide.Parent :=  HidePanel;
      buttonHide.Visible := True;
      buttonHide.Width :=   EDV_BUTTON_WIDTH;
      buttonHide.Height :=  EDV_BUTTON_HEIGHT; //<'Samoja mittoja. Vaihdettu 8.0.6  806
      buttonHide.tag :=     Integer(self);
      buttonHide.OnClick := TJohdot(johdot).ButtonClick;
      buttonHide.OnMouseMove := MouseMoveRow4;

      CablePanel.InfoButtonOnLeft := false;

      // button :=         TButton.Create(HeaderPanel);
      button := CablePanel.InfoButton;     //<DEVELOPER1: Johto-osan Btn [01]...[n],,,,,,,,,,,,,,,,,,,,,,,
      // button.Parent :=  HeaderPanel;
      // button.Visible := True;
      if johtoType=JOHTO_LAST  then        //<, 4.0.0
         button.Visible := FALSE;
     {button.Width :=   EDV_BUTTON_HEIGHT;
      button.Height :=  EDV_BUTTON_WIDTH;}
      button.Width :=   EDV_BUTTON_WIDTH;// +1; //<,+8.0.6  Ei voidakaan muuttaa: kirja-Btn häviää KaapTekstin alle valtaosin.  120.5o: NoNappi johdossa.
      button.Height :=  EDV_BUTTON_HEIGHT;   //<'Samoja mittoja. Vaihdettu ja +1  8.0.6/806. KORJAUS ks, CablePanelNola
      button.tag :=     Integer(self);
      button.OnClick := TJohdot(johdot).ButtonClick;
      button.OnMouseMove := MouseMoveRow4;

      CablePanel.OnMouseMove := MouseMoveRow2;
      CablePanel.OnClick := PohjaClick;           //<Lisätty DEVELOPER2 ohjeen muk. +8.0.3  ei803ssa
      CablePanel.OnDblClick := PohjaDblClick;     //<Lisätty DEVELOPER2 ohjeen muk. +8.0.3  ei803ssa
      CablePanel.rows[FIRST_CABLE_ROW + 2] := '';

      JakoKeskusImage :=             TImage.Create(HeaderPanel);
      JakoKeskusImage.Parent :=      HeaderPanel;
      JakoKeskusImage.BringToFront;
      JakoKeskusImage.OnMouseMove := MouseMoveRow4;
      JakokeskusImage.OnClick :=     PohjaClick;
      JakokeskusImage.OnDblClick :=  PohjaDblClick;

      JakokeskusImage.OnClick :=     PohjaClick;
      JakokeskusImage.OnDblClick :=  PohjaDblClick;
      JakokeskusImage.Transparent := False;

      JakoKeskusImage.Width :=       EDV_JOHTO_BORDER;
      // Tämän tulee olla niin suuri, koska sitä ei pystytä
      // muuttamaan dynaamisesti
      JakoKeskusImage.Height :=      500;
      JakoKeskusImage.Autosize :=    False;
      JakoKeskusImage.Stretch :=     False;

      HeaderImage :=             TImage.Create(HeaderPanel);
      HeaderImage.Parent :=      HeaderPanel;
      HeaderImage.BringToFront;
      HeaderImage.Width :=       EDV_MAX_IMAGE_WIDTH;
      HeaderImage.Height :=      EDV_BUTTON_HEIGHT;
      HeaderImage.OnMouseMove := MouseMoveRow4;

      JakokeskusImage.BringToFront;

      LahdotGrid := TStringGridNola.Create(DataPanel);   //<,,Resurssitarkasteluosan StringGrid,,,,,,,,,,,,,,,,,,,,,
   if koeColor  then
      LahdotGrid.Color :=             clGreen;           //<DEVELOPER1 koe401 §§§c§§§ Pistor.resurssiRvstä (23..) alasp. johto-osittain
    //LahdotGrid.Color :=             clWindow;          //<DEVELOPER1 4.0.1:  OK =Hävitetään viivat, jos SYSssä eri.
      LahdotGrid.Name :=              'LahdotGrid' + GetName(); //'...mutta värjää vain Col + Row -viivat.!!!!
      LahdotGrid.Visible :=           True;
      LahdotGrid.Left :=              fromLeft;
      LahdotGrid.Parent :=            DataPanel;
      LahdotGrid.SelectionEnabled :=  False;
      LahdotGrid.DefaultCellAlign :=  alRight;
      LahdotGrid.DefaultCellVAlign := alMiddle;
      LahdotGrid.rowCount :=          rjohto_MAX_9 +njohto_MAX_4 +1; //< 9 +4=13  130.2e: +1=14    £uk
      LahdotGrid.colCount :=          EDV_LAHDOT_COLS_6;             //< =6: Näköjään yksi johto-osapalsta on jaettu 6:een celliin.
      LahdotGrid.Top :=               {0;}-22;                       //<+130.2e
      LahdotGrid.fixedCols :=         0;
      LahdotGrid.fixedRows :=         0;
      LahdotGrid.OnHighestColInRow := GridHighestRow;
      LahdotGrid.OnWidestColInRow :=  GridWidestCol;
      LahdotGrid.align :=             alNone;
      LahdotGrid.ScrollBars :=        ssNone;
      LahdotGrid.BorderStyle :=       bsNone;
      LahdotGrid.GridLineWidth :=     1;                       //<DEVELOPER1 -4.0.1:  OK, mutta teksteistä jää margin. vex, jos 0=>jako ei stemmaa
   if koeColor  then                                           //<,+1202        'kun KoeColor=TR.
      LahdotGrid.BorderStyle :=       bsSingle;                //<Ei vaikutusta.
      LahdotGrid.options :=           [goFixedHorzLine, goFixedVertLine]; //1202< oli: [goFixedHorzLine];  GridRaamit eivät näkyneet vaikka KoeColor=TR, nyt näkyy.
      LahdotGrid.OnMouseMove :=       DataMouseMove;
      LahdotGrid.OnClick :=           PohjaClick;
      LahdotGrid.OnDblClick :=        PohjaDblClick;

      SulakeGrid := TStringGridNola.Create(dataPanel); //<,,Ik1v,Ik3v,SulMax yms. StringGrid,,,,,,,,,,,,,,,,,,,,,,
      SulakeGrid.Hint :=             'Klik lukitsee avusteen, DblKlik vapauttaa.'; //<,+10.0.3
      SulakeGrid.ShowHint :=         true;
   if koeColor  then
      SulakeGrid.Color :=            clRed;                    //<DEVELOPER1 koe401 §§§c§§§
    //SulakeGrid.Color :=            clWindow;                 //<DEVELOPER1 4.0.1:  OK =Hävitetään viivat, jos SYSssä eri.
      SulakeGrid.Name :=             'SulakeGrid' + GetName();
      SulakeGrid.Visible :=          True;
      SulakeGrid.Left :=             0;
      SulakeGrid.Parent :=           DataPanel;
      SulakeGrid.SelectionEnabled := False;
      SulakeGrid.DefaultCellAlign := alRight;
      SulakeGrid.DefaultCellVAlign := alMiddle;
      SulakeGrid.rowCount :=         arvo_MAX_GRID_14 +1 +1;    //<+9.0.1: 14+1+1=16
      SulakeGrid.colCount :=         EDV_SULAKE_COLS_3;         //< =3: Näköjään yksi johto-osapalsta on jaettu 3:een celliin.
      SulakeGrid.Top :=              0;
      SulakeGrid.fixedCols :=        0;
      SulakeGrid.fixedRows :=        0;
      SulakeGrid.OnHighestColInRow:= GridHighestRow;
      SulakeGrid.OnWidestColInRow := GridWidestCol;
      SulakeGrid.align :=            alNone;
      SulakeGrid.ScrollBars :=       ssNone;
      SulakeGrid.BorderStyle :=      bsNone;
   if koeColor  then                                           //<+130.2e:      GridViivat näkyviin.
      SulakeGrid.GridLineWidth :=    1;                        //<DEVELOPER1 -4.0.1:  OK, mutta teksteistä jää margin. vex. Jos 0=>jako ei stemmaa
   if koeColor  then                                           //<,+1202        'kun KoeColor=TR.
      SulakeGrid.BorderStyle :=      bsSingle;                 //<Ei vaikutusta.
      SulakeGrid.options :=          [goFixedHorzLine, goFixedVertLine];
      SulakeGrid.OnMouseMove :=      DataMouseMove;
      SulakeGrid.OnClick :=          PohjaClick;
      SulakeGrid.OnDblClick :=       PohjaDblClick;

      HeaderImage.Transparent := True;
      HeaderImage.Stretch :=     False;
      HeaderImage.Autosize :=    False;
      HeaderImage.OnClick :=     PohjaClick;
      HeaderImage.OnDblClick :=  PohjaDblClick;

      SetTexts;

      ResizeGrid(SulakeGrid);
      ResizeGrid(LahdotGrid);

      ReSize(aleft, awidth, aheight, aFromLeft, aJohdotTop, aheaderHeight);

      SulakeGrid.Visible := True;
      LahdotGrid.Visible := True;

      ReCalcRealValues;

      inherited Create;

      Fopen := True;
Tics ('TJohto.Create 9');
end;//TJohto.Create

///////////////////////////////////////////////////////////////////////////////
destructor TJohto.Destroy;
begin
      HeaderPanel.Free;
      DataPanel.Free;
      HidePanel.Free;
      HideDataPanel.Free;

      inherited;
end;

///////////////////////////////////////////////////////////////////////////////
procedure  TJohto.Hide;
begin
Tics ('TJohto.Hide 1-1');
      HeaderPanel.Visible := False;
      DataPanel.Visible := False;
      HidePanel.Visible := False;
      HideDataPanel.Visible := False;

      inherited;
end;

// DEVELOPER2 2005-08-29 BEGIN +8.0.0
///////////////////////////////////////////////////////////////////////////////
function TJohto.SetType(atype: TJohtoType): boolean;
begin
     result := false;

     if (johtoType <> atype) then
     begin
          johtoType := atype;
          result := true;
     end;
end;

///////////////////////////////////////////////////////////////////////////////
function TJohto.SetArrayIndex(aArrayIndex: integer): boolean;
begin
     result := false;

     if (arrayIndex <> aArrayIndex) then
     begin
          arrayIndex := aArrayIndex;
          result := true;
     end;
end;
// DEVELOPER2 2005-08-29 END

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.SetTexts;
var
  x{,y}: integer;
  tmp, tmp2, color: string;
begin
Tics ('TJohto.SetText 1');
     case Johtotype of
     JOHTO_LAST :begin
          // Laitetaan teksti
          for x := 0 to SulakeGrid.rowCount - 1 do //<0 .. 16-1
          begin
               tmp2 :=  myTextBase.Get(EDV_HEADERS_LAHTO + '-row-'+ intToStr(x + 1));

               If (x + 1 = 6) then                              //<DEVELOPER1: 6 =Eka ots.panelirivi.
               begin
                  color := STYLE_BOLD_BEGIN + EDV_COLOR_FONT_NJ //<<Green.
               end
               else
                   color := COLOR_BLACK; //Oli: EDV_COLOR_FONT_POHJA_HEADER; //<Blue. fKESKEN KOE.

               tmp := color + ALIGN_LEFT + tmp2;
               SetText(SulakeGrid, EDV_HEADER_COL_0 , x , tmp);

               if (tmp2 <> '') then
               begin
                  tmp := color + ALIGN_CENTER + EDV_SULAKE_EROTIN //= '<f n="" s="" c="xx.."><center>':'
               end
               else
                  tmp := ' ';

               SetText(SulakeGrid, EDV_MIDDLE_COL_1 , x , tmp);
          end;

          tmp := color + ALIGN_CENTER + EDV_SULAKE_EROTIN;                      //< color<..><center>':'
          SetText(SulakeGrid, EDV_MIDDLE_COL_1 , 0 , tmp);
          SetText(SulakeGrid, EDV_MIDDLE_COL_1 , 1 , tmp);
          SetText(SulakeGrid, EDV_MIDDLE_COL_1 , 2 , tmp);                      //<,DEVELOPER1: Väliin Ik3th
          SetText(SulakeGrid, EDV_MIDDLE_COL_1 , 3 , tmp);                      //<,DEVELOPER1: +1
          tmp := myTextBase.Get(EDV_HEADERS_LYHYT + '-row-1');
          SetText(SulakeGrid, EDV_HEADER_COL_0, 0, EDV_COLOR_FONT_POHJA + tmp);
          tmp := myTextBase.Get(EDV_HEADERS_LYHYT + '-row-2');
          SetText(SulakeGrid, EDV_HEADER_COL_0, 1, EDV_COLOR_FONT_POHJA + tmp);
          tmp := myTextBase.Get(EDV_HEADERS_LYHYT + '-row-3');                //<,DEVELOPER1: Väliin Ik3th
          SetText(SulakeGrid, EDV_HEADER_COL_0, 2, EDV_COLOR_FONT_POHJA + tmp);
          tmp := myTextBase.Get(EDV_HEADERS_LYHYT + '-row-4');                //<,DEVELOPER1: +1
          SetText(SulakeGrid, EDV_HEADER_COL_0, 3, EDV_COLOR_FONT_POHJA + tmp);

          // Tyhjennetään lahdot-osio koska ollaan viimeisessä johto-osassa,    DEVELOPER1: Sis. Pr 10/16, Sul Nj mm² m
         {for x := 0 to LahdotGrid.rowCount - 1 do                                             //<,,-8.0.0
          for y := 0 to LahdotGrid.colCount - 1 do
              SetText(LahdotGrid, y , x , ' ');    //<Oltava ' ', ei '', muuten PALSTALEVEYDET EIVÄT PVITY}
         {for y := 0 to LahdotGrid.colCount - 1 do //<,PALSTALEVEYKSILLE riittää kun YHDELLÄ rvllä Cellit := ' '.
              SetText(LahdotGrid, y , 1 , ' ');                                                //<' +8.0.0}

          SetText(LahdotGrid, 1,1 , ' ');          //<PALSTALEVEYKSILLE riittää kun YKSI Celli := ' '.  +8.0.0
     end;//johtoType=JOHTO_LAST

     JOHTO_NORMAL..JOHTO_LIITTYMA :begin
            // Tyhjennetään taulukot ensin.  DEVELOPER1: Rivit n. 6...21 ,,######### TARPEETON ########## -8.0.0
           {for x := 0 to SulakeGrid.rowCount - 1 do
            for y := 0 to SulakeGrid.colCount - 1 do
                SetText(SulakeGrid, y , x , ' ');}
              //SetText(SulakeGrid, y , x , Cmrk(IntToStr(x))); //<Ei tulostu mitään näytölle

           {for x := 0 to LahdotGrid.rowCount - 1 do            //DEVELOPER1:  Rivit n. 23...34, palsta- &riviHAVAINNOT.
            for y := 0 to LahdotGrid.colCount - 1 do
               SetText(LahdotGrid, y , x , ' ');}
             //SetText(LahdotGrid, y , x , Cmrk('&'));
           {LahdotGrid.Cells[0,0] := 'QQQQQQQQQQQQQQ';
            LahdotGrid.Cells[LahdotGrid.colCount -1, LahdotGrid.rowCount -1] := 'WWWWWWWWWWWWWW'; //Ccount=6 Rw=12}
          for x := 0 to SulakeGrid.rowCount-1 do //<,,Sulak+Virtasarak vas.puolelle arvn nimi, esim. "Oikos. suoj."
          begin
             //tmp2 := myTextBase.Get(EDV_HEADERS_LYHYT + '-row-'+ intToStr(x + 1));                      -6.0.0
  {            if x+1=5                                                                               //<,+6.0.0
                  then if EdvJohto.arvoU[2]>0                                   //<, p.o. OfaVal 6.0.2
                       then begin
                            tmp2 := '</f>ofa '+ fRmrkt0 (EdvJohto.arvoU[2],1,0) +':'; //§§§u§§§
                            tmp := '';  end
                       else tmp2 := ''      //<Muuten jää ed. x :n mukainen Ik3d näkyviin, TODETTU.!!!
                  else }tmp2 := myTextBase.Get(EDV_HEADERS_LYHYT + '-row-'+ intToStr(x + 1));          //<'+6.0.0

               {$IFDEF arvot_oikealle}
               if (x = 0) then
               begin
                  tmp := ALIGN_RIGHT + EDV_COLOR_FONT_POHJA_HEADER + tmp2 +
                  myTextBase.Get(SYMBOLI_OIKEALLE, FONT_OIKEALLE);
               end
               else if ( x < 4) then                                              //<DEVELOPER1:  x<3 -> x<4
               begin
                  tmp := ALIGN_LEFT + EDV_COLOR_FONT_POHJA_HEADER +
                         myTextBase.Get(SYMBOLI_VASEMMALLE)
                         + tmp2;
               end
               else
               {$ENDIF}
                  tmp := ALIGN_RIGHT + EDV_COLOR_FONT_POHJA_HEADER + tmp2;

               SetText(SulakeGrid, EDV_HEADER_COL_0 , x , tmp{+'@'+Ints(x)});     //<Ik1v, Ik3v, Ik3th,..Ik3d,.. Oikos.suoj. ..t Max_Ik3th   Pos('Max_Ik3th',tmp)>0

               if (x <> EDV_SUL_OIKOSULKUSUOJAUS_HEADER_ROW_10) and
                  (x <> EDV_MAX_SULAKKEET_HEADER_ROW_4) then
               begin
                  tmp := ALIGN_CENTER + EDV_COLOR_FONT_POHJA_HEADER + EDV_SULAKE_EROTIN; //<center><color..>':'
               end
               else
                  tmp := ' ';

               SetText(SulakeGrid, EDV_MIDDLE_COL_1 , x , tmp{+'$'+Ints(x)});
          end;// for x

          //,,Tähän tullaan vain TJohto.Create´sta ja sinne ei aina (ehkä jos johto-osa/Liittymät(?) kasvaa???).
          //  Nyt VÄLIMERKKI hoidettu MYÖS PRC RefreshNormal:ssa, missä myös putsataan vanha SrcCountSarake.
          //  Pakko sijoittaa myös tässä, jotta PALSTALEVEYS asettuisi, TODETTU. ,,,,,,,,,,,,,,,,,,,,,,,,,=+8.0.0
        (*for x := 0 to LahdotGrid.rowCount - 1 do  begin         //,,+8.0.0  Ks. myös:  PRC TJohto.RefreshNormal
               if (JohtoType=JOHTO_LIITTYMA) and (ArrayIndex=edv.YLE.SorceCount.arvoInt)  OR
                  (JohtoType=JOHTO_NORMAL)
               then tmp := ALIGN_CENTER + EDV_COLOR_FONT_POHJA + EDV_LAHDOT_EROTIN //<Vain TÄSSÄ "/" +RefReshNorm.
               else tmp := ' ';                                   //<Poistetaan "/" johtojen resurssipalstalta}
                 {then tmp := ALIGN_CENTER + EDV_COLOR_FONT_POHJA + Cmrk('%')
                  else tmp := Cmrk('§');}
               SetText(LahdotGrid, EDV_MIDDLE_COL_1 , x , tmp);     // 1.5/2.5 mm² palstojen väliin/välistä.
          end;//*)

          SetText(LahdotGrid, EDV_MIDDLE_COL_1, 1 , ' '); //<' ' YAHTEEN CELLIIN riittää palstalev.pvitykseen +8.0.0
     end;//JOHTO_NORMAL..JOHTO_LIITTYMA
     end;//case Johtotype

     button.Hint :=     button.Hint;
     HideButton.Hint := hidebutton.Hint;
     OpenButton.Hint := OpenButton.Hint;
     buttonHide.Hint := ButtonHide.Hint;

     if (button.Hint <> '')
     then begin
          if (JohtoType = JOHTO_NORMAL) then button.Hint := GetName() + button.Hint;
          button.ShowHint := True;  end
     else button.ShowHint := False;

     if (Hidebutton.Hint <> '')
     then begin
          if (JohtoType = JOHTO_NORMAL) then Hidebutton.Hint := GetName() + Hidebutton.Hint;
          Hidebutton.ShowHint := True;  end
     else Hidebutton.ShowHint := False;

     if (Openbutton.Hint <> '')
     then begin
          if (JohtoType = JOHTO_NORMAL) then Openbutton.Hint := GetName() + Openbutton.Hint;
          Openbutton.ShowHint := True;  end
     else Openbutton.ShowHint := False;

      if (buttonHide.Hint <> '')
      then begin
          if (JohtoType = JOHTO_NORMAL) then buttonHide.Hint := GetName() + buttonHide.Hint;
          buttonHide.ShowHint := True;  end
     else buttonHide.ShowHint := False;

     ReCalcRealValues;

     if (canRefresh = true) then
        refresh;
Tics ('TJohto.SetText 9');
end;//SetTexts

///////////////////////////////////////////////////////////////////////////////
procedure  TJohto.ReSize(aleft, awidth, aheight, afromLeft,
                         ajohdotTop, aheaderHeight: integer);
{var
     isChanged: boolean;  Never used 1412.}
begin
Tics ('TJohto.ReSize 1');
     //isChanged := false; //<DEVELOPER1 +8.0.0 :..might not have been initialized.            //Never used.
     if (aleft <> Fleft) or (awidth <> Fwidth) or (aheight <> Fheight) or
        (afromLeft <> FFromLeft) or (ajohdotTop <> LahdotGrid.Top) or
        (aheaderHeight <>  FHeaderHeight) then
     begin
          //isChanged := true; Never used.
     end;

     Fleft :=         aleft;
     Fwidth :=        awidth;
     Fheight :=       aheight;
     FFromLeft :=     aFromLeft;
     FHeaderHeight := aHeaderHeight;

     DataPanel.left :=     left;
     DataPanel.Height :=   height;
     DataPanel.width :=    width;
     DataPanel.refresh;

     HidePanel.left :=     left;
     HidePanel.Height :=   fHeaderHeight;
     HidePanel.Width :=    OpenButton.Width;
     HidePanel.refresh;

     HideDataPanel.left :=   left;
     HideDataPanel.Height := fheight;
     HideDataPanel.Width :=  HidePanel.Width;
     HideDataPanel.refresh;

     if johtoType = JOHTO_LIITTYMA then
        ButtonHide.top := 0
     else
        ButtonHide.Top := HidePanel.Height - ButtonHide.Height {-10}; //<Ei vaikuta.

     ButtonHide.Left :=  (HidePanel.Width  - ButtonHide.Width) div 2 {-10}; //<Ei vaikuta.

     if johtoType=JOHTO_LAST  then //<, +4.0.0  =Estetään %-nappulan näkyminen, Visible := FA ei worki tässä. DEVELOPER1{}?
      begin
        ButtonHide.Width :=  0;
        CablePanel.LineStyle := psDot;
      end;

     if open = True then
        HeaderPanel.Width := FWidth;

     headerPanel.Left :=     left;
     HeaderPanel.Height :=   FHeaderHeight;
     HeaderPanel.refresh;

     CablePanel.height :=    FHeaderHeight;
     CablePanel.width :=     FWidth - JakoKeskusImage.width;
     CablePanel.refresh;
                        //........|=> £uk                                                    //,130.2e:  £uk Saadaa "Max.Lähdöt/Pit..<tietoa>" -riville uk -arvot.
     LahdotGrid.Top :=  aJohdotTop -(LahdotGrid.RowHeights[1] +LahdotGrid.GridLineWidth) +2; //<130.2e:  £uk Nostetaan ylin rv yksi rv ylemmäksi.
     SulakeGrid.Left := 0;
     HeaderImage.Top := HeaderPanel.Height - HeaderImage.Height;

     HeaderImage.Left:= 0;
     JakoKeskusImage.Top := 0;
     JakoKeskusImage.Left:= HeaderPanel.Width  - JakoKeskusImage.Width;

     OpenButton.Top := HideButton.Top;

     if open = False then
     begin
         fwidth := HidePanel.width;
     end;

     SetVisibles;

     {£$£u g: if (isChanged) then  -1412:  Kun tämä kommentoitu vex, Edv piityy 1x vähemmän kuin ennen, silloin vilkahteli 1x useammin koko kuvaaja.
          DrawGraphics};
Tics ('TJohto.ReSize 9');
end;//ReSize

///////////////////////////////////////////////////////////////////////////////
procedure  TJohto.SetVisibles;
begin
Tics ('TJohto.SetVisibles 1');
     if (Open = True) then
     begin
          HidePanel.Visible :=     False;
          HideDataPanel.Visible := False;
          HeaderPanel.Visible :=   True;
          DataPanel.Visible :=     True;
     end
     else
     begin
          HidePanel.Visible :=     True;
          HideDataPanel.Visible := True;
          HeaderPanel.Visible :=   False;
          DataPanel.Visible :=     False;
     end;
Tics ('TJohto.SetVisibles 9');
end;

///////////////////////////////////////////////////////////////////////////////
procedure  TJohto.ReCalcRealValues;
begin
     SetGridDimensions;
     RealHeaderHeight := CablePanel.TrueHeight;
     RealHeight := LahdotGrid.Top + LahdotGrid.Height;
     RealWidth := GetRealWidth;
     RealFromLeft :=    0;
end;

///////////////////////////////////////////////////////////////////////////////
function  TJohto.GetRealWidth: integer;
var
   widest: integer;
begin
     widest := CablePanel.TrueWidth + JakoKeskusImage.width;

     if (SulakeGrid.left + SulakeGrid.GetMaxWidth + EDV_POTTASAUS_FROM_RIGHT > widest) then
        widest := SulakeGrid.left + SulakeGrid.GetMaxWidth + EDV_POTTASAUS_FROM_RIGHT;

     if (LahdotGrid.left + LahdotGrid.GetMaxWidth > widest) then
        widest := LahdotGrid.left + LahdotGrid.GetMaxWidth;

     if (HidePanel.Width > widest) then
        widest := HidePanel.Width;

     Result := widest;
end;

///////////////////////////////////////////////////////////////////////////////
function  TJohto.readCablePos: integer;
begin
     result := CablePanel.LineTop;
end;

///////////////////////////////////////////////////////////////////////////////
function  TJohto.GetNextJohto: TJohto;
begin
  result := nil;
  if johdot <> nil then
  begin
    // Haetaan osoitin seuraavan johto objectiin
    result := TJohdot(johdot).GetJohto(locationIndex + 1);
  //result := TJohdot(johdot).johto[locationIndex];     //<Tällä tulee toinen liittymä viereen.
//    PaaValFrm.Caption := PaaValFrm.Caption +IntToStr (locationIndex + 1);
  end;
end;

///////////////////////////////////////////////////////////////////////////////
function  TJohto.HasNextJohtoConnection: boolean;
begin
  result := false;
  // Haetaan seuraava johto-objecti ja katsotaan onko sillä rinnaikkaisliittymä
  if (GetNextJohto() <> nil) then
  begin
    result := (GetNextJohto().johtoType = JOHTO_LIITTYMA);
  end;
end;

///////////////////////////////////////////////////////////////////////////////
procedure  TJohto.DrawGraphics;      VAR Kind,h{1412} :integer;
begin
Tics ('TJohto.DrawGraphics 1');
     if (canRefresh) then
     begin
        DrawJohto(HeaderImage, JohtoType, CablePanel.LineTop);

        case JohtoType of
        JOHTO_LIITTYMA:
                  begin
                       // Liityntäjohdolla sulaketta ei piirretä normaaliin paikkaan
                       CablePanel.Start.Visible := false;

                       DrawNousuJohto (true{Sorce});

                       // Tarkistetaan onko seuraavalla johto-osalla liityntä
                       if (HasNextJohtoConnection) then
                       begin
                          // Seuravalla johto-osalla oli liittymä, joten piirretään sellainen
                        //DrawLiittymaOsa (JakoKeskusImage, cablePos, true, 4); // 4=Generaattori
                          Kind := a_getIntg (10011, edv.Sorc[arrayIndex+1].Src.SorceKind);
                          DrawLiittymaOsa (JakoKeskusImage, cablePos, true,Kind);
                       end                   //'Kind:  1=Transformer  2=LV-Cable  3=Generator  4=UPS
                       else
                       begin
                          // Seuraava johto-osa on normaali, joten piirretään normaali jakokeskus
                          DrawJakoKeskus(JakoKeskusImage, 2 * (CablePanel.Height - cablePos), cablePos);
                       end;
                  end;
        JOHTO_NORMAL:
                  begin
                       CablePanel.Start := ProtectImages[CABLE_IMAGES_SULAKE].imageHorizontal;
                       CablePanel.Start.Visible := true;

                       DrawNousuJohto (false); //<FA=NOT Sorce

                       // Seuraava johto-osa on normaali, joten piirretään normaali jakokeskus
                       h := 2 *(CablePanel.Height - cablePos);                //<+1412.
                       DrawJakoKeskus(JakoKeskusImage, h, cablePos);          //<h joskus a8, po. 28, korjaus ks. DrawJakoKeskus +1412.
                  end;
        JOHTO_LAST:
                  begin
                       CablePanel.Start := ProtectImages[CABLE_IMAGES_SULAKE].imageHorizontal;
                       CablePanel.Update; //<Ei kohdistanut oikealle korolle, nyt OK (myös Refresh=OK) +6.2.2

                    // Puhdistetaan jakokeskus edellisistä piirroista
                    Clear(JakoKeskusImage);
                 end;
        end;
    end;
Tics ('TJohto.DrawGraphics 9');
end;//DrawGraphics

///////////////////////////////////////////////////////////////////////////////
procedure  TJohto.DrawNousuJohto (SjEj :boolean{+141.1});     VAR Srcja,{Edja,}n,ogUPS{=141.1}:integer{:+120.5/6U};  boo :boolean{1412};  sa :string;
begin
Tics ('TJohto.DrawNousuJohto 1');
  if (FIsEdvJohtoValid) then
  begin//@1
     // PT-merkintä näytetään vain jos seuraavalla johto-osalla ei ole rinnakkaisliityntää
     if (HasNextJohtoConnection) then
        cablePanel.ShowPt := false
     else
        CablePanel.ShowPt := a_getBool(101000, ReadEdvJohto().PTLopussa);
// DEVELOPER2 2005-08-29 BEGIN -8.0.0
// Päivitys tarpeen tarkistus poistettu, jotta alas menevä johto puhdistetaan kun
// lisätään uusi liittymäjohto.
{       if ((DataImage = nil) or
           (currDataImagePotTasaus <> a_getBool(101000, EdvJohto.PTLopussa)) or
           (DataImage.Width     <> DataPanel.Width) or
           (DataImage.Height    <> DataPanel.Height) or
           (currDataImageBorder <> LahdotGrid.Top - (SulakeGrid.Top + SulakeGrid.Height)) or
           (currDataImageHeight <> SulakeGrid.Top + SulakeGrid.Height)) and
          ((JohtoType = JOHTO_NORMAL) or ((JohtoType = JOHTO_LIITTYMA))) then }
// DEVELOPER2 2005-08-29 END
       begin//@2
            if (DataImage <> nil) then
               DataImage.Destroy;

            DataImage :=             TImage.Create(nil);
            DataImage.Parent :=      DataPanel;
            DataImage.BringToFront;
            DataImage.Transparent := True;
            DataImage.Width :=       DataPanel.Width;
            DataImage.Height :=      DataPanel.Height;
            DataImage.Autosize :=    False;
            DataImage.Stretch :=     False;
            DataImage.Align :=       alRight;
  //½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½½ ½
            DataImage.OnMouseMove := DataMouseMove;
            DataImage.OnClick :=     PohjaClick;
            DataImage.OnDblClick :=  PohjaDblClick;

            currDataImagePotTasaus := a_getBool(101001, ReadEdvJohto().PTLopussa);
            currDataImageBorder :=    LahdotGrid.Top - (SulakeGrid.Top + SulakeGrid.Height) ;
            currDataImageHeight :=    SulakeGrid.Top + SulakeGrid.Height;

            // Alas menevää johtoa ei piirretä jos seuraavalla johdolla on rinnakkaisliityntä
if edv.Sorc[arrayIndex+1].Src.SorceKind.ArvoInt =1  then ;  //,,,Watch List´iin;
if edv.YLE.SorceCount.ArvoInt =1   then ; //=1 sorce        //edv.Sorc[1].Src.Smn.ArvoInt
if edv.YLE.JohtoOsia.ArvoInt =1    then ; //=1 edj          //edv.Sorc[2].Src.Smn.ArvoInt
{if SrcEdka
   then }
if edv.Sorc[1].Src.Smn.ArvoInt=800 then ;                   //edv.Edka[1].Pituus.ArvoRea
if edv.Edka[1].Pituus.ArvoRea=200  then ;                   //edv.Edka[2].Pituus.ArvoRea
if edi=1                           then ;                   //edi ArrayIndex LocationIndex
if ArrayIndex =1  then ;                 //=2 =1xSrc +1xEdj    arrayIndex:
if LocationIndex=1  then ;               //<2 =2xSrc           LocationIndex: 0...n (n=SorceCount+JohtoOsia-1)
{       [01]----[02]---PK---[1]---[3]... <JohtoBtns:  Src1 Src2 (PK) Edj1            | JohtoBtns: Src1 Src2     (PK) Edj1
                                                                                     |            [01]----[02]---PK---[1]--...
ArrIndx:  0       1          2     3     Alkuluvussa järjestys:  3  1  2  1  2  3    |   ArrIndx:  0       1          2
LocIndx:  1       2          3     4                             2  0  1  0  1  2    |   LocIndx:  1       2          3
   Olet-Ev 2s2j.NOE: ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
        [01]----[02]---PK---[1]---[2]... <JohtoBtns:  Src1 Src2 (PK) Edj1  Edj2
ArrIndx:  0       1          2     3     Alkuluvussa järjestys:  3f 4f 1f 2f 1f 2f   s=Sorce  f=NOT SrcEdka=EdJ  =SRCEDKA EI WORKI TÄÄLLÄ.
LocIndx:  1       2          3     4 = Srcja(2) +Edja(2)         2f 3f 0s 1s 0s 1s 2f 3f #################################################################
                                                        // Edi:  1  1  1  1  1  1        =AINA 1 =EDI ja SRCEDKA EI WORKI TÄÄLLÄ #########################}
        (*Srcja := edv.YLE.SorceCount.ArvoInt;          // n:    0  1  0  1  0  1  0  1
          Edja :=  edv.YLE.JohtoOsia.ArvoInt;           // oh:   0  0  0  0  0  0  0  0
          SrcNyt := LocationIndex <= Srcja;      //<ScrNyt := SjEj;  Indxstä laskettu lienee todellinen. ?!?!?!
        //SrcNyt := (JohtoType=JOHTO_LIITTYMA) ; //<Tämäkään ehkei pidä paikkaansa
          if SrcNyt  then n := LocationIndex
                     else n := LocationIndex -Srcja;
          //if (not HasNextJohtoConnection()) and (JkUpsInt>0{+141.1})  then begin
          //if (not HasNextJohtoConnection()) and SyottoFrm.UpsChk.Checked{+141.1}  then begin
          if SrcNyt  then oh := edv.Sorc[1].Josa.JkUps.ArvoInt //,Kaikissa Srs´ssa sama tieto, onko UPS-laite(1) vai ei
                     else oh := edv.Edka[n].JkUps.ArvoInt; *)
                                                          JFileen('1/2 Johto.PAS / DrawAlasJohto ');
//LocationIndex ja ArrayIndex eivät worki täällä näköjään, testattu. Nyt käydään kaikki Src´t ja EdJ´t läpi ja piirretään DrawAlasJohto jos JkUps >0.
//Ei liene liiaksi aikaa ottavaa piirtää mahd. sama AlasJohto ueamminkin.
            Srcja := edv.YLE.SorceCount.ArvoInt;          // n:    0  1  0  1  0  1  0  1
          //Edja :=  edv.YLE.JohtoOsia.ArvoInt;           // oh:   0  0  0  0  0  0  0  0

            n := ArrayIndex-Srcja;//} Edi; //<+1412
           {oh := 0; }ogUPS := 0;  sa := '---';                                           //<ogUPS=0 =Vain delataan vanha JkUps alta.
            if (JohtoType=JOHTO_LIITTYMA)                                                 //ve: JOHTO_NORMAL
               then begin  if (ArrayIndex<=Srcja) and (edv.Sorc[1].Josa.JkUps.ArvoInt >0) //and (JkUpsChk_ed >0)
                              then begin {oh := 1;  }ogUPS := 1;  sa := 'Src';  end; end  //<oh :=  never used;
               else        if (edv.Edka[n].JkUps.ArvoInt >0) //and (JkUpsChk_ed >0)  //<' +1412  Jostain syystä JkUps.ArvoInt -arvot ei synkkaa, .._ed tarvitaan.
                              then begin {oh := 1;  }ogUPS := 1;  sa := 'Edka';  end;     //<oh :=  never used;

          //if (n >0) or (Edi <0) or (Srcja <0) or (Edja <0) or SrcNyt  then ;
            boo := HasNextJohtoConnection();            //<1412: boo := .
            if NOT boo  then begin //and (oh>0){+141.1}  then
               UpsFileen('===DrawAlasJ: Edi=' +Ints(Edi) +' n=' +Ints(n) +' JType=' +sa +' ArrayIndex=' +Ints(ArrayIndex) +' LocationIndex=' +Ints(LocationIndex) +' ogUPS=' +Ints(ogUPS));
               DrawAlasJohto(DataImage,currDataImageHeight, currDataImageBorder, {120.6:}ArrayIndex,LocationIndex, ogUPS ,JohtoType);  end;
       end;//@2
  end;//@1
Tics ('TJohto.DrawNousuJohto 9');
end;//TJohto.DrawNousuJohto;

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.WriteEdvJohto(var value: EdvPalstaType);      VAR onSama :boolean; //<edv.edka[]
begin
Tics ('TJohto.SetEdvJohto 1-1');
     onSama := IsEqualEdvPalstaType(value, FEdvJohto);                    //<edv.edka[] //AsTapa§ AsTapDeb§  @:3
     if NOT onSama  then begin
       FEdvJohto := value;                                                //AsTapa§  EiOhjaudu <<<<<<<<<<<<<<<<<<<
       FIsEdvJohtoValid := true;
       if JohtoType=JOHTO_NORMAL
          then CablePanel.InfoButtonOnLeft := false //<,+8.0.0  DEVELOPER1:  Tutkitaan PRC TCablePanelNola.SetLayout´issa.
          else CablePanel.InfoButtonOnLeft := true; //<' FA/TR, muuten poistettaessa Edka[1] tai lisättäessä Sorc[]
       canRefresh := true;
       Refresh;                                                           //<Editointiin >>>>>>>>>>>>>>>>>>>>>>>>>
     end;// else                                    //   Button ei tule oikeaan kohtaan: Src=VasYlös, Edka=Johtoon
end;//}

// DEVELOPER2 2005-08-29 BEGIN +8.0.0
///////////////////////////////////////////////////////////////////////////////
procedure TJohto.WriteSrc(var value: EdvSorceType); //<edv.Sorc[]
begin
Tics ('TJohto.WriteSrc 1-1');
     if (IsEqualEdvSorceType(value, FSrc) = FALSE) then //<edv.Sorc[]
     begin
          FSrc := value;
          FIsSrcValid := true;
          CablePanel.InfoButtonOnLeft := true;
          Refresh;
     end;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.WriteYLE(var value: EdvTiedotType); //<edv.YLE
begin
Tics ('TJohto.WriteYle 1-1');
     if (IsEqualEdvTiedotType(value,FYLE) = FALSE) then  //AsTapDeb§   @ Vain käynnistyksessä tullaan tänne.
     begin
          canRefresh := true;
          FYLE := value;
          FIsYLEValid := true;
          CablePanel.InfoButtonOnLeft := true;
          Refresh;
     end
end;
// DEVELOPER2 2005-08-29 END

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.WriteNjL(var value: EdvNjLahtoType);
begin
Tics ('TJohto.WriteNjL 1-1');
     if (IsEqualEdvNjLahtoType(value,FNjL) = FALSE) then
     begin
          canRefresh := true;
          FNjL := value;
          Refresh;
     end
end;

function TJohto.ReadYLE: EdvTiedotType; begin result := FYLE; end;
function TJohto.ReadNjL: EdvNjLahtoType; begin result := FNjL; end;
function TJohto.ReadEdvJohto:EdvPalstaType; begin result := FEdvJohto; end;
function TJohto.ReadSrc: EdvSorceType; begin result := FSrc; end;

///////////////////////////////////////////////////////////////////////////////
procedure  TJohto.SetHeight(value: integer);
begin
Tics ('TJohto.SetHigh 1-1');
     FHeight := value;
     // myPanel.height := FHeight;
     Refresh;
end;

///////////////////////////////////////////////////////////////////////////////
procedure  TJohto.SetWidth(value: integer);
begin
Tics ('TJohto.SetWidth 1-1');
     FWidth := value;
     // myPanel.Width := FWidth;
     Refresh;
end;

///////////////////////////////////////////////////////////////////////////////
procedure  TJohto.SetLeft(value: integer);
begin
Tics ('TJohto.SetLeft 1-1');
     FLeft := value;
     // myPanel.Left := FLeft;
     Refresh;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.SetHeaderHeight(value: integer);
begin
Tics ('TJohto.SetHigh 1-1');
     FHeaderHeight := value;
     // myPanel.Width := FWidth;
     Refresh;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.SetFromLeft(value: integer);
begin
Tics ('TJohto.SetFromLeft 1-1');
     FFromLeft := value;
     // myPanel.Width := FWidth;
     Refresh;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.SetOpen(value: boolean); //<Tapahtuu, kun painetaan johto-osan N:O -painiketta
begin
Tics ('TJohto.SetOpen 1-1');
     FOpen := value;
     Refresh;
     TJohdot(johdot).Resize; // Varmistetaan että johto-osa piirretään oikein
end;

///////////////////////////////////////////////////////////////////////////////
procedure  TJohto.ReFresh;
begin//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
Tics ('TJohto.ReFresh 1');
     SetVisibles;

     case johtoType of
     JOHTO_LIITTYMA:
     begin
        // Asetetaan painikkeiden tiedot
        button.Caption := GetName();
        buttonHide.Caption := button.Caption;

        // Päivitettään liitynnän tiedot jos YLE rakenne on kunnossa
        if FIsSrcValid then
          RefreshConnection;

        // Päivitettään liitynnän tiedot jos EdvJohto rakenne on kunnossa
        if FIsEdvJohtoValid then
          RefreshNormal;
     end;

     JOHTO_NORMAL:
     begin
        // Asetetaan painikkeiden tiedot
      //button.Caption := GetName();                             //<-8.0.0
      //button.Caption := IntToStr(arrayIndex-LocationIndex);    //< button.Caption := GetName();  =>... +8.0.0 DEVELOPER1
        button.Caption := IntToStr(arrayIndex - edv.YLE.SorceCount.arvoInt); //< button.Caption := GetName();  =>... +8.0.0 DEVELOPER1
        buttonHide.Caption := button.Caption;                                //'DEVELOPER2 tarkista??? GetName antaa aina 1 Norm.johdolle
        // Tyhjennetään kolme ensimmäistä riviä, joissa ovat mahdollisesti
        // vanhat liityntätiedot.
        CablePanel.rows[0] := ' '; // Välilyönti, jotta rivikorkeus tulisi oikeaksi
        CablePanel.rows[1] := ' ';
        CablePanel.rows[2] := ' ';

        // Päivitettään liitynnän tiedot jos EdvJohto rakenne on kunnossa
        if FIsEdvJohtoValid then      //<AsTapDeb§  @:4
          RefreshNormal;              //<Tästä lähdetään editoimaan.
     end;
     JOHTO_LAST: RefreshLast;
  end;//case
     ReCalcRealValues;
     DrawGraphics;
Tics ('TJohto.Refresh 9');
end;//ReFresh

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TJohto.RefreshNormal;
CONST vas0=0;  oik2=2;               //<+130.2e.
var
   x,y,valeja,ai,ii,k,nr :integer;   //<DEVELOPER1:  +ai 2.0.3  +k 8.0.0, 130.2e
   tmp,tmp2,sp   :string;
   rr,xr,ar, ua1,ua2,uy1,uy2 :real;  //<+130.2e: ala- ja ylämaxUkt
   boo,nayUk   :boolean;             //<DEVELOPER1:  +boo  +3.0.3=zs  +130.2e £uk
   sa,sn,ss,su :string;              //<DEVELOPER1   +sa,sn 2.0.7  +ss 6.0.3  +su 6.2.1
   Pmrk        :string;              //<+9.0.1  Pmrk := arvon jos Lzpe < Ltim, eli Zpe -ehto on lyhentänyt pituutta.
 //aoRec,Ej_1Rec :EdvPalstaType;     //<DEVELOPER1   +6.2.2  Ej_1Rec = [arrayIndex-1]

   function fPh_Ih :real;      VAR ar,ac :real;
   begin //<, I = P*1000 / (Un *cos *V¨3)         +6.0.0
       ac := a_getReaa (101081, ReadEdvJohto().Cosp);      //<Cos voi olla 0 vain, jos FNC ArvotOK ei ole saanut syöttö-
       if ac<=0.01  then ac := 0.01;                 // arvovirhettä kiinni tai Y_.PAS:ssa fVexN '' => 0, eli muut-
       ar := a_getReaa(101080, ReadEdvJohto().Ph) *1000 / ( Sqrt(3) *fUn *ac);    //ti tyhjän stringin nollaksi. Ei enää.
      result := ar;                                                         //'6.2.1  0.01=>1=>0.01
   end;
                                                     //,,Tutkii SN:stä dimension ja muokkaa Ik:n samaksi +6.0.2
   function fTeeSamaAmp (IkUstr :string;  Ik :real) :string;      VAR Salp,Suus,Sdim :string;
   begin
      Salp := fIkDimAlpS (Ik,IkUstr,  Suus,Sdim);
    //result := 'X.xx';
      result := Suus;// +'/' +Salp +' ' +Sdim;
   end;
                                                     //,,Muuttaa Tik -ajan sekunnit ms :ksi tarvittaessa +6.0.3
   function fTikToDim (aika :real) :string;      VAR ar :real;  sa :string;
   begin
      ar := fMuokDes (aika,2);
      if aika = 0   then sa := myTextBase.Get(EDV_VIRHE)  else //  < =0    => '- - - -'
//    if aika = 0   then sa := ' - # - -'                 else //  < =0    => '- - - -'
      if ar < 0.01  then sa := '<10 ms'                   else //  < 0.01s
      if ar < 10    then sa := fRmrkt0 (aika,1,2) +' s'   else //  < 10  s = 0.01s - 9.99s
      if ar < 100   then sa := fRmrkt0 (aika,1,1) +' s'   else //  < 100 s = 10.0s - 99.9s
      if ar = 100   then sa := fRmrkt0 (aika,1,0) +' s'   else //  = 100 s = 100s
                         sa := '>100'             +' s';       // >= 100 s = 100s - ...
      result := ' ' +sa;
   end;
   function fTikToStrDim (SulTyp :string;  Isul,Ik :real) :string;      VAR ar :real;  sa :string;
   begin
      if (Pos ('OFA',SulTyp)>0) and  (Isul > 630)  or (Isul=0)          //'< Ik +6.0.4
      then sa := '<left> ' +myTextBase.Get(EDV_VIRHE) +'<right>'
      else begin
           ar := TikYR (SulTyp, pyor (Isul), Ik);                       //< suCse -> SulTyp, Ik 6.0.4
           sa := fTikToDim (ar);
         //if a_getReaa (1010102,edv.YLE.PoisAika) < ar                                                        //<-6.2.15
           if  a_getBool(1010102,ReadEdvJohto().Kuluttaja) and (a_getReaa (1010103,edv.YLE.PoisAika) < ar)  OR //<KUL +6.2.15
           NOT a_getBool(1010102,ReadEdvJohto().Kuluttaja) and (ReadEdvJohto().arvo[arvo_SUL_MAX_5s_5] < Isul) //<SÄL +6.2.15
              then sa := COLOR_RED +sa +FNT_0;
           sa := '<left>' +sa +' <right>';
       end;
       result := sa;
   end;

   function fncLzpeBx :boolean;      VAR s :string;      begin//+9.0.1
     {result := false;                                   //<Nyt voisi testata suoraan if edv.YLE.ZpeBx.arvoBoo ...
      s := AnsiUpperCase (Trim (EdvNewFrm.BxTZpe.Text)); // edv.YLE.ZpeBx lienee nyt tarpeeton.
      if Pos ('LZP',s) >0  then
         result := true;} //'-,+120.5n
      s := AnsiUpperCase (Trim (EdvNewFrm.BxTZpe.Text)); // edv.YLE.ZpeBx lienee nyt tarpeeton.
      result := Pos ('LZP',s) >0;
   end;
      //,FNC Palauttaa PITUUDEN laskettuna TIM tai Zpe muk.   ,GRV =+10.0.4
      function Tim_Zpe_ve (Ltim,Lzpe :real;  TUP,grv :integer) :real; //,,,,,,,,,,,,+9.0.1,,,,,,,,,
            VAR pit :real;   booLzpeBx :boolean{<+10.0.4'};

         function TUPonP :boolean;      VAR s :string;  o :integer;      begin //'T,U,P,X'
            Result := false;
            s := IntS (TUP);   o := Length (s); //1000=T  100=U  10=P  1=X   => esim. 1011=TPX
            if (o>=2)  and (s [o-2 +1]='1')  then Result := true;  //< P = '10' tai '11'
           {if TUP>0
               then beep;
            if (o>=1)  and (s [     o]='1')  //'X':llä piippi kokeiltaessa.
               then beep;}
         end;

      begin//Tim_Zpe_ve .......................
        {if TUPonP
            then beep;}
         Pmrk := '';                             //<Paikallisesti Globaali.
         booLzpeBx := fncLzpeBx;                   //<,+10.0.4
         pit := Ltim;  //<Jää ehkä voimaan.      //,-10.0.4
       //if qLzpeBx and qTUPonP and (Lzpe<Ltim)  //<FNC fLzpe.. valitsee BxTZpe.Text -Bx:n joko Ltim tai Lzpe mukaan.
                                                 //,,10.0.4   ,Nyt näytetään aina BxTZpe:n valinnan mukaan.
         if booLzpeBx and {,+10.0.4}             //<FNC fLzpe.. valitsee BxTZpe.Text -Bx:n joko Ltim tai Lzpe mukaan.
            (JohtoType<>JOHTO_LIITTYMA) and      //<Ei Liittymille
            (ReadEdvJohto().Kuluttaja.arvoBoo)   //<..ja vain KUL j-osille.
         then begin                              //<ZpeL voi olla pienempi kuin Ltim vain, jos BxTZpe :ssa ZpeL.
            if grv IN [1..4,9,101,103]  then begin //Vain edv 23-26,32,34 => grv=edvRv-22, ks. kutsu. +10.0.4
               Pmrk := '¹';                        //'101,102 ks. PRC NJpit_Tim_Zpe_ve (siellä kasvatettu 100).
               if Abs (Lzpe-pit) <0.1
                  then Pmrk := '¹°';//`';
               pit := Lzpe;  end;
         end;//else =Ltim jää voimaan.
         result := pit;
      end;//Tim_Zpe_ve

   function r31pit_Tim_Zpe_ve (ao1,ao2 :integer) :real;      begin             //<9.0.1  EdvJohto.RyhmaJ_r31 :lle.
      result := Tim_Zpe_ve (ReadEdvJohto().RyhmaJ_r31[ao1].rjpituus[ao2].pituus,     //<,,Asettaa Glob. Pmrk:n '¹'/''
                            ReadEdvJohto().RyhmaJ_r31[ao1].rjpituus[ao2].pitZpe,
                            ReadEdvJohto().RyhmaJ_r31[ao1].rjpituus[ao2].TUP, ao1);
   end;
   function RJpit_Tim_Zpe_ve (ao1,ao2 :integer) :real;      begin              //<9.0.1  EdvJohto.RyhmaJohto :lle. fLzpe BxTZpe -Bx:n joko Ltim tai Lzpe mukaan.
      result := Tim_Zpe_ve (ReadEdvJohto().RyhmaJohto[ao1].rjpituus[ao2].pituus,
                            ReadEdvJohto().RyhmaJohto[ao1].rjpituus[ao2].pitZpe,
                            ReadEdvJohto().RyhmaJohto[ao1].rjpituus[ao2].TUP, ao1);
   end;
   function NJpit_Tim_Zpe_ve (ao :integer) :real;         begin                //<9.0.1  EdvJohto.Nousujohto :lle.
                             ao := ao +100;                        //<+10.0.4 tässä ao=1..4, +100 jotta erottuisi
      result := Tim_Zpe_ve (ReadEdvJohto().Nousujohto[ao-100].pituus,    //         muista riviosoitteista 1..9 .
                            ReadEdvJohto().Nousujohto[ao-100].pitZpe,    //<,' -100 koska äskeinen +100 vääristää.
                            ReadEdvJohto().Nousujohto[ao-100].TUP, ao);
   end;
//=============================================================================================================================================
//function Y_fPixPit (CanvasOwner :TCanvas;  CONST Txt :String;  TxtFont :TFont) :Integer;   headerCanvas johdot.headerimage.canvas
   procedure asetaValit (ekaRv,vikaRv :integer); //Lukee LahdotGrid.Cells[2,i]´n ja tutkii +säätelee loppuriviä.
         //TYPE arT :array of array of integer;
      //µVAR m1, xm1,xm2,xm3,  i,u,v,dPixB,xB,PPP :integer;  c_,SC, c1,c2,c3,cP,cX, SQ, sx{,CA} :string;
         VAR {u1,u2,u3,} m1,{m2,m3,} xm1,xm2,xm3,  i,{j,n,}u,v,{loc,}dPixB,xB,PPP :integer;  c_,SC,{cs,} c1,c2,c3,cP,cX, SQ, sx{,CA} :string;
                    //PRC säätää testerinäyttövaatimukset alekkain tarkasti alku"{", väli"/" ja loppumrkn"}" mukaan= {132A/98.4A} alekkain.
                                                              //                                            m|1  m|2   m|3 #################### <=m1,m2,m3
                                                              //            Cel=0---------------|1|Cel=2----------------|  ####################
                                                              //                                 |-----(q1)c1| c2 | c3  | c4  =StrSisTagit
                                                              //########## "<f n=xx n=xxx..> 116m/<..>96,6m  {132A/98.4A} #####################
                                                              //########## "<f n=xx n=xxx..>82.6m/<..>92,6m  { 96A/60A  } #####################
                                                              //#############################################''''''''''''######################
   function fPix2x (si :string;  PixB :integer) :integer;      VAR ix :integer;      begin
    //if (Pos('T',SC)>0) or (Pos('P',SC)>0) or (Pos('X',SC)>0)  then result := PixB*2  else result := 0;  end;
      if (Pos('T',SC)=0) and (Pos('P',SC)=0) and (Pos('X',SC)=0)
         then ix := 0
         else ix := PixB*7; //Kokeillen haettu.
      result := ix;  end;
   procedure  wre(si :string);     {begin end; {}VAR f :TextFile;  k :integer;  fn,s :string;      begin //Erinomainen.
      if PPP>0  then begin
         fn := gAjoPath +'_Johto Valit[ ].txt';      //C:\Projektit XE2\NolaKehi\BIN\..
         AssignFile(f,fn);
         if fFileExists (fn)
            then Append(f)
            else Rewrite(f);
         s := '';
         k := Pos('----',si);
         if (si<>'') and (k=0)  then s := DateTimeToStr(Now);
         s := s +'  ' +si; //<Ei fileen aikaleimaa jos "----.."
         Writeln(f,s);
         Flush(f);
         Close(f);
      end;//if PPP>0
   end;//*)

   begin//asetaValit......................................K Ä Y T Y   L Ä P I   K O K O N A A N, muutoksia  130.2e...........................................
PPP := 0;  c_ := ' '; //<0=Ei (wre)tiedostoonkirjoitusta.  c_ =Tyhjän välin korvaa mrk kehiVaiheeseen (erottuu hyvästi ruudulta ja filestä.
      c1 := ''; c2 := ''; c3 := '';                           //<+130.0
      xm1 := 0; xm2 := 0; xm3 := 0; dPixB := 0;               //<+130.2e
      for i := ekaRv to vikaRv  do begin                      //<,,Etsitään pisimmällä olevat "{/}" :n esiintymät, jotka kohdistetaan alekkain.
       //######################################################################################################################################
         SQ := LahdotGrid.Cells[2,i];     //<ALP CellinRv, joka putsataan kaikesta. Täällä laitetaan <left> +CLR_PURP, helpompi.###############
wre('SQ:  ' +SQ);
       //######################################################################################################################################
       //####################################,,Etsitään etäismmällä olevat kohdistettavat: "{", "/" ja "}", jos ###############################
       //####################################  eioo '/', laitetaan vasemman '(' kanssa suoraksi.###############################################
         SC := TagVexB_Ero (SQ,u);
         if u>dPixB  then dPixB := u;                  //<dPixB on voimassa koko rivillä =samalla Cells[2,i]-osalla =SQ,SC´llä.
wre('SC:  ' +SC);                                      //SQ:  <left><f n="" s="" c="16711680">72,2m<b><f n="" s="" c="255">P</f></b>{142,5/105}
         c1 := '';  c2 := '';  c3 := '';               //SC:  72,2mP{142,5/105}
         u := Pos ('{',SC);
         if u>0  then begin
{c1---}     c1 := Copy (SC,1,u-1);                                        //SC:  72,2mP{142,5/105}
            v := u;                                                       //<..........'v= {´n sijainti.  c1="72,2mP"
            u := Y_fPixPit (EdvNewFrm.Canvas, c1, EdvNewFrm.Font); //<Etsitään pisin pix.<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            if u>xm1  then
               xm1 := u;                                           //< xm1 = "{"n SUURIN etäisyys pix´nä.
wre('i=' +Ints(i) +' c1:  "' +c1 +'" xm1(pix)=' +Ints(xm1));

            u := Pos ('/',SC);
            if u>0  then begin                                            //SC:  72,2mP{142,5/105}
{c2---}        c2 := Copy (SC,v+1,u-v-1);                                 //<...........'''''=c2="142,5"
            v := u;                                                       //<v= edellinen U.
               u := Y_fPixPit (EdvNewFrm.Canvas, c2, EdvNewFrm.Font);
               if u>xm2  then xm2 := u;                                   //< m2 = /´n etäisyys pix´nä.
wre('i=' +Ints(i) +' c2:  "' +c2 +'" xm2(pix)=' +Ints(xm2));               //<xm2= etäisyys pixnä "/"mrkiin.
            end;
            u := Pos ('}',SC);
            if u>0  then begin                                            //SC: "72,2mP{142,5/105}"
{c3---}        c3 := Copy (SC,v+1,u-v-1);                                 //<.................'''=c2="105"
               u := Y_fPixPit (EdvNewFrm.Canvas, c3, EdvNewFrm.Font);
               if u>xm3  then xm3 := u;                                   //< m3 = )´n etäisyys pix´nä.
wre('i=' +Ints(i) +' c3:  "' +c3 +'" xm3(pix)=' +Ints(xm3));
            end;//u>0
         end;//u>0
wre('');
      end;//for i
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//,,===================== {../..} alekkaiset erilevyiset justeerataan saman mittaisiksi "/"n suhteen siihen keskittäen m1,m2,m3 mukaan.======================
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§ {.../...}§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
                                         wre(',,,,,,,,,,,,,,,');    //,,Rakennetaan koko txt uudelleen koska ei onaa sijoittaa pätkää väliin
      if (c1<>'') and {(c2<>'') and} (c3<>'')  then                 //<..,,Pannaan kaikki "{" "/" ja "}" omiin linjoihinsa panemalla NIIDEN eteen välejä.
      for i := ekaRv to vikaRv  do begin                            //'§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
         SQ := LahdotGrid.Cells[2,i];                                     //<VAR dPixB on Bold- ja NormTextn pixERO = +130.2e.
         SC := TagVex (SQ);              wre('SQ: "' +SQ +'"');           //s_="<f n="" s="" c="16711680"><left>72,2mP<f n="" s="" c="8388736">{"
                        {m1 := Y_fPixPit (EdvNewFrm.Canvas, 'XXXXXXXXXX', EdvNewFrm.Font);  m2 := Y_fPixPitB(EdvNewFrm.Canvas, 'XXXXXXXXXX', EdvNewFrm.Font);
                         m3 := m2-m1;  SC := SC +' m2-m1=' +Ints(m2-m1) +' =m3=' +Ints(m3); //m3=10=1Pix/'X' }
                                         wre('SC:  ' +SC);                //SC: "72,2mP{142,5/105}"
         c1 := '';  c2 := '';  c3 := '';  //CA := '';                     //<CA vain xm1..xm3 {/} pix´ien näyttämiseen lopputekstien tilalle Celliin[2.i].
         m1 := Pos ('{',SC);
         if (m1>0)  then begin                                            //SC: "72,2mP{142,5/105}"
{c1---}     c1 := Copy (SC,1,m1-1);                                       //<    ''''''=c1="72,2mP"
            c2 := Copy(SC,1,m1);                                          //<Avuksi, vertailtavaksi.
                                       wre('c1: "' +c1 +'" c2`=' +c2);
            cP := '';
            while (Length(c1)>0) and  CharInSet(c1[Length(c1)], ['T','P','X'])  do  //Delataan ja kirjoitetaan takas väreineen + boldeineen.. +</f>
               if c1[Length(c1)]='X'  then begin cP := cP +CLR_GRB +'X' +'</b></f>';  Delete(c1,Length(c1),1);  end else
               if c1[Length(c1)]='P'  then begin cP := cP +CLR_REB +'P' +'</b></f>';  Delete(c1,Length(c1),1);  end else
               if c1[Length(c1)]='T'  then begin cP := cP +CLR_REB +'T' +'</b></f>';  Delete(c1,Length(c1),1);  end;
               //COLOR_BLUE ='<f n="" s="" c="16711680">';  OLOR_GREEN='<f n="" s="" c="32768">';  CLR_PURP   = '<f n="" s="" c="8388736">';
                                       wre('c1: "' +c1 +'"');
            cX := '<left>' +EDV_COLOR_FONT_POHJA +c1 +cP;             //<ALKUOSA C1=>cX JO VALMIS= 72,2m §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
                                       wre('1cX: "' +cX +'"');
         v := m1;
            sx := '';
            xB := fPix2x(SC,dPixB);                                   //<Vaikuttaa KOKO rivillä.§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
            u := Y_fPixPit (EdvNewFrm.Canvas, c1, EdvNewFrm.Font);        //<Tageja eioo vrtlussa mukana (c1).
            while (u+xB<xm1)  do begin                                    //<+dPix B jotta lisättävä BoldMrk varaisi oikein (=á+1Pix).
               sx := sx +c_;     //<Tyhjä väli.
               u := Y_fPixPit (EdvNewFrm.Canvas, c1 +sx, EdvNewFrm.Font);
            end;
            //if xB>0 then xB := xB*1;  //<Ei auta:  Not show for.. optimization..
                                       wre('c1+sx=)pix(u): ' +Ints(u) +' xm1=' +Ints(xm1) +' dPixB=' +Ints(dPixB));
            cX := cX +' ' +sx +CLR_PURP +'{';          //CA := '{' +Ints(u) +' ';
                                       wre('2cX: "' +cX +'"');
{c2---}     c2 := '';                                                     //..........m1    m2  m3 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            u := Pos ('/',SC);                   //>>>>>>>>>>>>>>>>>>>>>>>.............|.....|...| <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            if (u>0)  then begin                                          //SC: "72,2mP{142,5/105"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
               c2 := Copy (SC,v+1,u-v-1);                                 //<..cX''''''|'''''=c2="142,5"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                                       wre('c2: "' +c2 +'"');             //.................|'''=c3="105"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            v := u;                                     //<v= edellinen U.//Pixnä:..xm1|..xm2|xm3|
               sx := '';
               u := Y_fPixPit (EdvNewFrm.Canvas, c2, EdvNewFrm.Font);     //<Tageja eioo vrtlussa mukana (c1).
               while (u{+xB}<xm2)  do begin                                 //<Boldin ja NormTextin ero huomioidaan.
                  sx := sx +c_;
                  u := Y_fPixPit (EdvNewFrm.Canvas, c2 +sx, EdvNewFrm.Font);
               end;
                                       wre('c2: "' +c2 +'"');
               cX := cX +sx +c2 +'/';                  //CA := CA +Ints(u) +'/';
                                       wre('3cX: "' +cX +'"');
            end;//if (u>0)

            u := Pos ('}',SC);
            if (u>0)  then begin
{c3---}        c3 := Copy (SC,v+1,u-v-1);                                 //SC:  72,2mP{142,5/105}
                                       wre('c3: "' +c3 +'"');             //<.................'''=c3="105"
               sx := '';
               u := Y_fPixPit (EdvNewFrm.Canvas, c3, EdvNewFrm.Font);     //<Tageja eioo vrtlussa mukana (su).
               while (u{+xB}<xm3)  do begin                                 //<Boldin ja NormTextin ero huomioidaan.
                  sx := sx +c_;
                  u := Y_fPixPit (EdvNewFrm.Canvas, c3 +sx, EdvNewFrm.Font);
               end;
               cX := cX +c3 +sx +'}</f>';              //CA := CA +Ints(u) +'}';
                                       wre('4cX: "' +cX +'"');
                                       wre('');
            end;
         end;//if (m1>0)..
         LahdotGrid.Cells[2,i] := cX; //'<left>Lft1234 '+CLR_PURP+'{1234/567}</f>';  OK.
         //LahdotGrid.Cells[2,i] := CA; //'<left>Lft1234 '+CLR_PURP+'{1234/567}</f>';  OK.
      end;//for i *)
                                       wre('===============');
   end;//asetaValit
//=============================================================================================================================================
                                              //,,+120.5:  Testerinäyttämäpalsta siirretty PRC´ksi.########################################################
   function fTesteriLukemaPalsta (si :string) :string;      VAR s0,SV,SO,SX :string;
      //Desim.erottimet on muutettu PILKUIKSI TextBaseText.PAS´ssa, koska'Fucshia -colorasetus ei onannut, jos perässä kaukanakin oli "." .
      function AnnaVastaava (sA :string) :string;     VAR sQ :string;
         function tee (sb :string) :string;      VAR su :string;  m :integer;  a0,ar :real;      begin//130.0:  Nyt kaikki lasketaan alla =ei taulukkoarvoja.
           {if sb='46,5' then su := '58,1'  else //<Oik.puoli = 1.25 x vas.puoli.
            if sb= '50'  then su := '62,5'  else
            if sb= '65'  then su := '81,3'  else
            if sb= '70'  then su := '87,5'  else
            if sb= '80'  then su := '100'   else
            if sb= '82'  then su := '102,5' else
            if sb='100'  then su := '125'   else
            if sb='110'  then su := '137,5' else       //110/82A) muuttui:  =>(114/84),
            if sb='112'  then su := '140'   else
            if sb='160'  then su := '200'   else
            if sb='200'  then su := '250'   else
            if sb='320'  then su := '400'   else begin}
                            //su := '---';(*else
               SokR(sb,ar);
               a0 := 1.25 *ar;                         //<SFS 6000-4-1/411.4  epäyhtälöstä Z <= 4Uo/5I
               ar := fMuokDes (a0,1);
               su := fRmrkt0(ar,1,1);  m := Length(su);
               if CharInSet (su[m], ['0','1','2'])
               then begin ar := trunc(ar);
                          su := fRmrkt0(ar,1,0);  end
               else if CharInSet (su[m], ['3','4','5','6','7'])
               then begin ar := trunc(ar) +0.5;
                          su := fRmrkt0(ar,1,1);  end
               else su := fRmrkt0(ar,1,0);             //<Tämä ainoa rivi, jos vain kokonaislukuarvot riittäisi.
{m := Pos(',5',su);                                    //1415b: Testailen paljonko J-osapalsta kapenee jos testerinäyttämän ,5 pyöristetään vex.
if m>0  then Delete(su,m,2);}                          //'      Ei vaikutusta lev=60.5 mm edelleenkin.
               if su<>'' {a0+ar>1}  then typ;
          //end;//if sb= else
            result := su;
         end;//tee 130.0'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
      begin//AnnaVastaava....................................
         {sQ := tee ('46,5');
          if sQ='1'  then beep;  sQ := tee ('40.08');  //50.1
          if sQ='1'  then beep;  sQ := tee ('40.16');  //50.2
          if sQ='1'  then beep;  sQ := tee ('40.24');  //50.3
          if sQ='1'  then beep;  sQ := tee ('40.32');  //50.4
          if sQ='1'  then beep;  sQ := tee ('40.4 ');  //50.5
          if sQ='1'  then beep;  sQ := tee ('40.48');  //50.6
          if sQ='1'  then beep;  sQ := tee ('40.56');  //50.7
          if sQ='1'  then beep;  sQ := tee ('40.64');  //50.8
          if sQ='1'  then beep;  sQ := tee ('40.72');  //50.9
          if sQ='1'  then beep;  sQ := tee ('40.8 ');  //51.0 }

          if sQ='1'  then beep;  sQ := tee (sA);
          if sQ='1'  then beep;  result := sQ;
       (*xr := Trunc(ar+0.5);

         SokR(sb,ar);  ar := 1.25 *ar;  xr := Trunc(ar+0.5);
         if xr>ar  then SV := fRmrkt0(xr,1,1)                                  //<Luku pyöristyisi seur.desimaaliin =ei ole kokonaisluku. TESTATTAVA.
                   else SV := fRmrkt0(xr,1,0);
         SokR(SO,ar);  ar := 1.25 *ar;  xr := Trunc(ar+0.5);
         if xr>ar  then SO := fRmrkt0(xr,1,1)                                  //<Luku pyöristyisi seur.desimaaliin =ei ole kokonaisluku. TESTATTAVA.
                   else SO := fRmrkt0(xr,1,0);}
         StringReplace(SO,',' ,'.',[rsReplaceAll,rsIgnoreCase]);               //<[]rf´llähän ei tässä ole merkitystä.*)

         result := sQ;
      end;//AnnaVastaava

   begin//fTesteriLukemaPalsta.................................
      s0 := si;                                                             //<+130.0:  Talteen
      while (si<>'') and NOT CharInSet(si[Length(si)],['0'..'9'])  do
         Delete(si,Length(si),1);                                           //<Vikamrkt"A)" vex.
      si := Trim(si);
      SX := '';
      while (si<>'') and CharInSet(si[Length(si)],['0'..'9', '.', ','])  do begin
         SX := si[Length(si)] +SX;
         Delete(si,Length(si),1);  end;                                     //<Välimrkiin "/" asti.. SO =RIVIN VIKAN OIK.PALSTAN LUKU.######################
      StringReplace(SX,'.' ,',',[rfReplaceAll,rfIgnoreCase]);               //<[]rf´llähän ei tässä ole merkitystä.
      SO := AnnaVastaava(SX);

      if (si<>'') and (si[Length(si)]<>'(')  then begin                     //<1414d: (si<>''). '+130.0:  Nyt usein vain yksi luku (xxx) eikä (xxx/zzz).
         while NOT CharInSet(si[Length(si)],['0'..'9', '.', ','])  do
            Delete(si,Length(si),1);                                        //<"/" yms. välistä vex.
         si := Trim(si);
         SX := '';
         while (si<>'') and CharInSet(si[Length(si)],['0'..'9', '.', ','])  do begin //,SV=VIKAA EDELTÄVÄ VAS.PALSTAN LUKU.####################################
            SX := si[Length(si)] +SX;
            Delete(si,Length(si),1);  end;                                     //Joku muu kuin Nro lopettaa. SV=VIKAA EDELTÄVÄ LUKU.
         StringReplace(SX,'.' ,',',[rfReplaceAll,rfIgnoreCase]);               //<[]Näillähään ei tässä ole merkitystä.
         SV := AnnaVastaava(SX);
         if si[Length(si)]='('  then                                           //<,+130.2e.
            Delete(si,Length(si),1);
      end;
      SX := '{';
      if SV<>''
         then SX := SX +SV +'A/';
      SX :=  SX +SO +'A}';
    //SX := si +SX;             //<130.2e:  s0 +  Ei missään nimessä: Tulisi Otsikkorivipanelin txt jatkoksi.
      Result := SX;
   end;//fTesteriLukemaPalsta
//================================================================================================================
//===============================================================================================================
   procedure  wrn(LF :integer;  si :string);     begin end; {VAR f :TextFile;  fn,s :string;      begin //141.1  ar := ReadEdvJohto().RyhmaJohto[x].rjpituus[2].uk; Johto.PAS/Err selvittelyyn
      fn := gAjoPath +'PrRvtJOH.txt';      //C:\Projektit XE2\NolaKehi\BIN\..
      AssignFile(f,fn);
      if fFileExists (fn)
         then Append(f)
         else begin
              Rewrite(f);
              Writeln(f,'Johto.pas/PRC Wrn rv 2343:');  end;
      s := '';
      if (si<>'')  then s := DateTimeToStr(Now);
      s := s +'  ' +si;
      Writeln(f,s);
      if LF>0  then Writeln(f,'');
      Flush(f);
      Close(f);
   end;//}

begin//RefreshNormal
Tics ('<b>TJohto.RefreshNorm 1</b>');
    // Edeltävän verkon pohjassa rivit 0-2 on varattu liityntäjohdolle,
    // aloitetaan tietojen kirjoittaminen riviltä 3 = FIRST_CABLE_ROW
                                          //¿DefsFileenZ('Johto.PAS/1');
                                          YFileen('¿Johto.PAS/1');
    FormatCablePanel(ReadEdvJohto(), arrayIndex, CablePanel, FIRST_CABLE_ROW, JohtoType);
    HeaderPanel.Width := CablePanel.TrueWidth;                         //'Lisätty JohtoType: DEVELOPER1 7.2.2004 +6.2.2
    HeaderPanel.refresh;
    DataPanel.Width :=   CablePanel.TrueWidth;
    DataPanel.refresh;

        (* if (JohtoType=JOHTO_LIITTYMA) and (ArrayIndex>1) and //<,,Putsataan ed.SorceCount -sarake      +8.0.0
              (ArrayIndex=edv.YLE.SorceCount.arvoInt-1)  then   //   Jos uusi>edSrcCount, edSrc kirjoitetaan yli.
           for y := 0 to LahdotGrid.RowCount-1  do              //<,,Putsataan KAIKKI  23...34, muuten jää
           for x := 0 to LahdotGrid.ColCount-1  do              //   vanha SorceCount -sarakkeen tiedot osittain
             //SetText(LahdotGrid, x,y, Cmrk('$'));             //   näkyviin, TODETTU.
             //LahdotGrid.Cells[x,y] := Cmrk('$');
              {if x<>EDV_MIDDLE_COL_1  then }LahdotGrid.Cells[x,y] := '';//*)

    // Tämä on irrotettu FormatCablePanel funtiosta tähän
    tmp2 := EDV_COLOR_FONT_POHJA_HEADER + '(' + EDV_COLOR_FONT_INPUT;

    if a_getBool(101015, ReadEdvJohto().kuluttaja) = True then
    begin
      tmp2 := tmp2 + PoisAikaToStr(a_getReaa(101111, TJohdot(johdot).ReadYLE().PoisAika), ' ', False) +
              myTextBase.Get(SYMBOLI_SEKUNTI);
    end
    else
    begin
    if (ReadEdvJohto().arvo[10] > 63) then
      tmp2 := tmp2 + myTextBase.Get(EDV_SUOJAUSEHDOT_3)
    else
      tmp2 := tmp2 + myTextBase.Get(EDV_SUOJAUSEHDOT_2);
    end;

    tmp2 := tmp2 + EDV_COLOR_FONT_POHJA_HEADER + ')';
    //DEVELOPER2 7.12.1998. Absoluuttinen rivi suhteelliseksi EDV_MAX_SULAKKEET_HEADER_ROW_4 nähden
    SetText(SulakeGrid, EDV_HEADER_COL_0, EDV_MAX_SULAKKEET_HEADER_ROW_4 + 1, tmp2);  //< Ik/3.0
//#####################################################################################################################
//#####################################################################################################################
//###############################,,x = RivinimiPanelin riviNo -5, eli x=1 =panelin rv 6.##### Kommnt +1200.############
//#####################################################################################################################
//#####################################################################################################################
    sa := EdvNewFrm.UkBx.Text;                                //<,+130.2e.
    nayUk := Pos('ON',AnsiupperCase(sa))>0;
    valeja := 0;   ua1 := 0; uy1 := 0;   ua2 := 0;  uy2 := 0;
    for x := 1 to arvo_MAX_GRID_14+1+1  do //arvo_MAX_GRID_14 = (paneli)riviNrointi 6-20.    //<MAX=>MAX_GRID=14 9.0.1,  130.2e: +1+1 =uk´n lisäys rvlle 22 .
    begin                                  //,,Tyhjä rivi riveille 3, 9 (panelirivit 10, 15).
         if (x + valeja = EDV_SUL_OIKOSULKUSUOJAUS_HEADER_ROW_10 + 1) or                                               //<£ x=1 2 3 4 5 6 7 8 9 10 11 12 13
            (x + valeja = EDV_MAX_SULAKKEET_HEADER_ROW_4 + 1) then                                                     //     14 15
            valeja := valeja + 1;

{1}      if (x = 1) then //______Ik1v___PANEELI_________________________________________________________________
         begin
            tmp2 := myTextBase.Get(EDV_HEADERS_LYHYT + '-row-'+ intToStr(x));
            tmp := ALIGN_RIGHT + EDV_COLOR_FONT_POHJA_HEADER + tmp2;
            {$IFDEF arvot_oikealle}
            tmp := tmp + myTextBase.Get(SYMBOLI_OIKEALLE);
            {$ENDIF }
            SetText(SulakeGrid, EDV_HEADER_COL_0, x{-1}, tmp);  // <right>Ik1v  -130.2e: -1 vex

            tmp := EDV_COLOR_FONT_POHJA;
         end
         else begin      //______MUUT ________________________________________________________________________ 120.6+: Rivi Rivit Rivt Riv Rv
            tmp := EDV_COLOR_FONT_POHJA;
            //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,+6.0.2
{6}         if x=6  then begin //<,,=Rv 11: SuojEhdSallii.  Vas.palstalle -row-6 = '', joka nyt tehdään TILANT.MUK.    //<£ x=6
               tmp2 := EDV_COLOR_FONT_POHJA_HEADER + {'§'}{'(' +} EDV_COLOR_FONT_INPUT;     //< "(" -9.0.1
               if a_getBool (101061, ReadEdvJohto().Kuluttaja)                                    //'oli: "(Ik/3.0)"
               then begin
                 {boo := (x=6) and (demo or EXT_Demo);                                      //< boo +8.0.0
                  tmp2 := tmp2 + PoisAikaToStr(a_getReaa(101062, TJohdot(johdot).YLE.PoisAika), ' ', boo) +
                                               myTextBase.Get(SYMBOLI_SEKUNTI); //< '(5.0 s)'/'(0,4 s)'//<''-9.0.1}
                //tmp2 := tmp2 +'5 / 0,4 s';                                                     //<+9.0.1
                  tmp2 := tmp2 +'MaxSul';                                                        //<+9.0.1
               end
               else begin
{Muut rvt}        if (ReadEdvJohto().arvo[10] > 63) then
                     tmp2 := tmp2 + myTextBase.Get(EDV_SUOJAUSEHDOT_3)  //< 'Ik/3.0'
                  else
                     tmp2 := tmp2 + myTextBase.Get(EDV_SUOJAUSEHDOT_2); //< 'Ik/2.5'
                //tmp2 := tmp2 + ' ' +myTextBase.Get(EDV_SAHKOLAITOS);
               end;

             //tmp2 := tmp2 + EDV_COLOR_FONT_POHJA_HEADER + ')';                             //< ")" -9.0.1
               SetText(SulakeGrid, EDV_HEADER_COL_0 , x{-1} , tmp2 +q_(''));                   //<x-1=5 = rv 11=Max. sulakkeet) 130.2e.   -130.2e: -1 vex
            end;//x<6 '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''+6.0.2
         end;    //Etsittäväksi:  t_Max_Ik3v t_MaxIk3v tMaxIk3v , myös jälempnä.
{Kaikki} //,,_____14+2=15+1 =t Max_Ik3v (esim. 810 ms)___________________________________________________________
         nr := (x + valeja);
         k := EDV_MAX_AIKA_ASETUS_15 + 1; //< x= 2.. <'+130.2e.
         if nr=k  then
         begin
            if ReadEdvJohto().arvo[x]=0                                       //<,+7.0.5 (Varaus rinn.syötöille)       //<£ x=14
            then tmp := tmp +myTextBase.Get(EDV_VIRHE) //< = '- - - -'
            else tmp := tmp + AikaToStr(ReadEdvJohto().arvo[x], ' ', false) + //<DEVELOPER1:  FA, oli TR =Nyt Demokin arvt
                              myTextBase.Get(SYMBOLI_SEKUNTI);          //t Max_Ik3v:  60 ms     Etsittäväksi: tMaxIk3v t_Max_Ik3v
         end
         else begin
            //if (x > 3) and (x < 15) and (ReadEdvJohto().arvo[x] = 0) then                              -6.0.2
{4..14}       if (x IN [4..14]) and (ReadEdvJohto().arvo[x] = 0) then
              begin//,,______Ik3d ... t Max_Ik3v ________________________________________________________________
                   tmp := tmp + myTextBase.Get(EDV_VIRHE);                                                            //<£ x=4..14
              end
              else
{Muut}        begin //,DEVELOPER1:  1.1.2
                 //if (x >= 5) and (x <= 8) and (a_getIntg(101051, ReadEdvJohto().lukumaara) > 2) then
                 //if (x >= 6) and (x <= 9) and (a_getIntg(101051, ReadEdvJohto().lukumaara) > 2) then   -6.0.2
{6..9}             if (x IN [6..9]) and (a_getIntg(101052, ReadEdvJohto().lukumaara) > 2) then        //<+6.0.2       //<£ x=6..9
                      tmp := tmp + myTextBase.Get(SYMBOLI_PERKPL);

{5}                if x = 5 //(=r11),,_____OfaIk3tVaim/OfaIk3dVaim________________________________________,,+6.0.0
                   then begin                                                       //,,6.0.2 +6.0.4 uusittu
                           {arvoU[3]=ValitunOFAAnRaj_Is   arvoU[4]=ValitunOFAAnRaj_Ith   arvoU[2]=Ik1vJohnAlussa
                            arvoU[5]=OFAAoikoSULraj_Ith   arvoU[1]=OFAAoikoSULraj_Is             //<U[4,5]=+6.2.0
                            Uusittu 6.2.0.}
                      ss := '';                                                                                        //<£ x=5
                      sa := ''; //<,SA=VasPalstanNimi. Jos oli aikaisemmin valittu OFAA-sul>0
                      sn := ''; //  ja nyt =0, täytyy vanha ots. + arvot pyyhkiä vex.

                      //ReadEdvJohto().OfaVal => OTSIKKO JA AIKA=  ofa 125: 1.04s #####################################
                      ai := 0;        //=> EDELTÄVÄ OfaVal  =ai, jonka VAIKUTUS lasketaan EdvJohto -pisteessä.
                                                   //Src:ssa ei lasketa VAIMENTAVAA VAIKUTUSTA=8.0.0  ,,+6.2.2
                                                   //vain OTSIKKO ja AIKA lasketaan =eiOo edellä OFAA.
                                                   //OfaVal´ista AINA sijoitetaan arvo >0 tai =0.################
                      if johtoType<>JOHTO_LIITTYMA  then begin                    //<,,JOHTO_NORMAL =Edka -osa,,,,
                         {if arrayIndex>1}
                          if arrayIndex-Edv.YLE.SorceCount.arvoInt-1 >0                          //<,,+8.0.6
                       //then ai := a_getIntg (101051, edv.Edka[arrayIndex-1].OfaVal) //<Edeltävä Edka[].OfaVal
                         then ai := a_getIntg (101051, edv.Edka[arrayIndex-Edv.YLE.SorceCount.arvoInt{+8.0.6}-1].OfaVal)
                         else begin                                                   //<,,Sorc[].Josa.OfaVal
                            ai := 0;
                            for k := 1 to Edv.YLE.SorceCount.arvoInt  do begin   //<,,Etsitään src-j-osa, missä
                               ii := a_getIntg (101052, edv.Sorc[k].Josa.OfaVal);//  suurin OFAVAL.
                               if ii>ai  then ai := ii;  end;
                         end;
                      end;                                                                     //'''+6.2.2

                      if (ReadEdvJohto().OfaVal.arvoInt >0) or (ai>0)                  //<Otsikko TAI MYÖS laskettu arvo.
                      then begin
                         sa := COLOR_IK3D_ +'ofa </f>';
                         if ReadEdvJohto().OfaVal.arvoInt >0  then begin               //<,OFAAn arvo jos on TÄSSÄ
                            sa := sa +IntToStr (ReadEdvJohto().OfaVal.arvoInt) +' A';  //< ofa 160 A
                            ss := fTikToStrDim (su_OFAg, ReadEdvJohto().OfaVal.ArvoInt,
                                                ReadEdvJohto().arvo [arvo_IK1V_1]);  end; //<'RED jos > TIMasetus

                         if JohtoType<>JOHTO_LIITTYMA  then begin                 //6.2.2  8.0.0: Ei liittymälle.
                            su := VirtaToStr (ReadEdvJohto().arvo[arvo_IK3T_3], ' ', FALSE) + myTextBase.Get(SYMBOLI_AMPEERI);
                            sn := VirtaToStr (ReadEdvJohto().arvo[arvo_IK3D_4], ' ', FALSE) + myTextBase.Get(SYMBOLI_AMPEERI);
                            ii := 0;
                            if JohtoType<>JOHTO_LIITTYMA                 //<Kylläkin turha, vrt. ehto edellä, OK.
                               then ii := 1;                             //< >0=Lasket.+ näytetään OFAAn vaikutus.
                                               //,ii=Edellä oleva OfaVal, jonka vaikutus lasketaan.##############
                            sn := fOFAAvaimIts (1,ii, ReadEdvJohto().arvoU[4], ReadEdvJohto().arvoU[3], su, sn); //<, +6.2.1
                         end;                  //'=> Ik3th[=4]/Ik3d[=3], kun suojaava valittu OFAA huomioitu.
                         sn := ss +sn;         //'=> (17.1/27.6 kA). Asettaa + lopettaa myös tekstivärin:  COLOR_IK3D_
                      end;
                                   //sa := 'XXXXX';                                  //,VasenPalsta=Otsakepalsta
                      SetText(SulakeGrid, EDV_HEADER_COL_0, x{-1}, ALIGN_RIGHT +sa); //<VasenPalsta ="ofa 160 A"    <,-130.2e: -1 vex
                      SetText(SulakeGrid, EDV_SULAKE_COL_2, x{-1}, ALIGN_RIGHT +sn); //<OikeaPalsta =Arvo
                      if sa<>''
                         then sa := EDV_COLOR_FONT_POHJA_HEADER +ALIGN_CENTER + EDV_SULAKE_EROTIN //< color<..><center>':'
                         else sa := ' '; //<,"' '"=Putsataan ":" jos ei tule vas.otsikkopalstaan mitään.
                      SetText(SulakeGrid, EDV_MIDDLE_COL_1 , x{-1} ,sa); //<'ofa 160 A´n jälk. ":" => "160 A :"      -130.2e: -1 vex
                                         //'Tyhjä SA pitää olla ' ', '' ei KASVATA riviä, todettu.!!!!!!!!!!

                      //,Samalla silmukkakerralla sijoitettava myös MaxSul =arvo[5] !!!!!!!!!!!!!!!!!!!!!!!!
                     {boo := Demö or EXT_Demo;                                   //< boo=MaxSu ei jos Demö +8.0.0
                      tmp := tmp + SulakeToStr(Trunc(ReadEdvJohto().arvo[x]), ' ', boo) +              //<-9.0.1
                             myTextBase.Get(SYMBOLI_AMPEERI);}
                      //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,+9.0.1,,,,,,,,
                     {sa := SulakeToStr(Trunc(ReadEdvJohto().arvo[arvo_SUL_MAX_5s_5]), ' ', boo) +'A'; //<5s:n MaxSul AINA.
                      if ReadEdvJohto().Kuluttaja.ArvoBoo  then begin
                        sa := '5s=' +sa +' <b>\</b> ';
                        sa := sa +'.4s=' +SulakeToStr(Trunc(ReadEdvJohto().arvo[arvo_SUL_MAX_04s_15]), ' ', boo) + 'A';  end;
                                                             //''''''''+9.0.1 ''=OK, mutta punainen väri puuttuu.}
                      rr := ReadEdvJohto().arvo[arvo_SUL_MAX_5s_5]; //<rr = 5 s:n sulakekoko (x=5)
                      if (Demo(34)  or EXT_Demo) and (x<>9)         //<Todellinen arvo demossa vain asD :lle.
                         then sa := sDemI                           //< ='Xxx'
                         else sa := fRmrkt0 (rr,1,0);
                      sa := sa +' A';

                      ai := a_getIntg (1010101, ReadEdvJohto().Lukumaara);
                      if ai=2  then ai := 1;              //<2:lla rinnakkaisjohdolla yhteinen suoja.
                      rr := rr *ai;
                      xr := fPh_Ih;
                      if rr < xr  then                    //<Ei väliä vaikka Ph=0. Ih SAA OLLA = Isul !!!!!!
                         sa := CLR_RED +sa +FNT_0 +CLR_BLU;

                      if ReadEdvJohto().Kuluttaja.ArvoBoo  then begin
                            sn := fPoiskAikaRajaS;
                            if (sn<>'') and (sn[1]='0')  then Delete (sn,1,1); //< 0.4 => .4
                         sa := '5s=' +sa +' <b>\</b> ' +sn +'s=';
                         rr := ReadEdvJohto().arvo[arvo_SUL_MAX_04s_15]; //<rr =0,4 s:n sulakekoko (x=5)
                         rr := rr *ai;                    //<ai pätee vielä.
                         sn := '';
                         if rr < xr  then                 //<Ei väliä vaikka Ph=0. Ih SAA OLLA = Isul !!!!!!
                            sn := CLR_RED;
                         if (Demo(35)  or EXT_Demo) and (x<>9)     //<Todellinen arvo demossa vain asD :lle.
                            then sa := sa +sDemI               //< ='Xxx'
                            else sa := sa + sn +fRmrkt0 (rr,1,0);
                         sa := sa +' A';
                         KorvaaDesMrk(sa); //<+120.5u
                      end;
                      //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''+9.0.1''''''''
                      tmp := tmp +sa;
                   end//if x=5 ---------------------------------------------------------
                   else
{6..9}             if x IN [6..9] //,,_____OikSul=arvo[6]...Yliv.AsD=arvo[9] (=r12...15)_________________________      //<£ x=6..9
                   then begin
                                                  //TJohtoType = (JOHTO_LAST, JOHTO_NORMAL, JOHTO_LIITTYMA);
                      {if johtoType = JOHTO_LIITTYMA
                       then rec := EdvJohto
                       else}
                     {tmp := tmp + SulakeToStr(Trunc(ReadEdvJohto().arvo[x]), ' ', false) +              //<-6.0.3
                                   myTextBase.Get(SYMBOLI_AMPEERI);}

                      {if (locationIndex<0) or            // Kertoo indeksin EdvNewFrmissa
                          (arrayIndex<0)  then beep;      // Kertoo indeksin tietorakenteessa}
                                                          //,rr =rvn 6..9 sulakekoko.
                      rr := ReadEdvJohto().arvo[x]; //<,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,+6.0.3
                      if (Demo(36)  or EXT_Demo) and (x<>9)   //<Todellinen arvo demossa vain asD :lle.
                         then sa := sDemI//'Xxx'
                         else sa := fRmrkt0 (rr,1,0);
                      sa := sa +' A';

                      ai := a_getIntg (1010101, ReadEdvJohto().Lukumaara);
                      if ai=2  then ai := 1;              //<2:lla rinnakkaisjohdolla yhteinen suoja  +6.0.4
                      rr := rr *ai;
                      xr := fPh_Ih;
                      if rr < xr                          //<Ei väliä vaikka Ph=0. Ih SAA OLLA = Isul !!!!!!
                         then sa := CLR_RED +sa +FNT_0;   //''''''''''''''''''''''''''''''''''''''''''+6.0.3
                      tmp := tmp +sa;  end
{Muut}             else begin //<,,x =_____1,2,3,4, 10,11,12,13,14_______________________________________________    //<£ x=1 2 3 4 10 11 12 13 15
                                                      //,Ik1v ja KatkaisijaOikosSuoj.aset ei näytetä demo tilassa.
                       boo := (x IN [1, 3,4, 10,11,12])  and (demo(37) or EXT_Demo);      //< Demö +6.0.2, EXT_ 8.0.0
                       sa := ' ';                              //< SA=Välimrk, jos SA<>'' Kpe < 1 !!!!!!!,,,+2.0.7
                       if x=1  then begin                      //< x=1 =Ik1v =rv 6 <<<<<<<<<<<
                          rr := a_getReaa (1010102, ReadEdvJohto().PEker);
                          if rr<1  then sa := '¹';             //<Välimerkki = m/v -paperitulosteessa näkyisi
                       end;
                                                               //,arvo[3]=Ik3d  arvo[4]=Ik3t
                       sn := VirtaToStr(ReadEdvJohto().arvo[x], sa, boo)   + myTextBase.Get(SYMBOLI_AMPEERI);
                       KorvaaDesMrk(sn); //<+120.5u
                     //su := VirtaToStr(ReadEdvJohto().arvo[x], sa, boo)   + myTextBase.Get(SYMBOLI_AMPEERI);
                     //su := VirtaToStr(ReadEdvJohto().arvo[x], sa, FALSE) + myTextBase.Get(SYMBOLI_AMPEERI); //<+8.0.0
                                             //'su = OFAAkäsittelyyn koska VirtaToStr mahd. muutti arvon Xxx :ksi.
                       if x=1  then begin                      //<,Lisätään alkuun kiskostoIk1v +"/". +6.0.2
                        //sn := fTeeSamaAmp (sn,ReadEdvJohto().arvoU[2]) +'/' +sn;               //<Oli OK, -6.2.17
                          sn := VirtaToStr(ReadEdvJohto().arvoU[2], sa, boo) + myTextBase.Get(SYMBOLI_AMPEERI) +'/' +sn;
                          KorvaaDesMrk(sn);  end; //<+120.5u
                       if sa<>' '  then                                  //'Nyt molemmille puolille omat dimensiot
                          sn := CLR_RED + sn +FNT_0;                     //'+6.2.17

                       ai := 0;
                       if JohtoType<>JOHTO_LIITTYMA
                          then ai := 1;                          //< >0=Lasket.+ näytetään OFAAn vaikutus. +8.0.0
                       if (x=3{=Ik3th}) and (arrayIndex>=1)              //<,,,,,,,,,,,,,,,,,,,,,,,,+6.2.0, 6.2.2
                       then begin
                          ar := ReadEdvJohto().arvoU[5];                       //< [5]=OFAAoikoSULraj_Ith
                          sa := fOFAAvaimIs(1,ai, ar, sn{su});
                          KorvaaDesMrk(sa); //<+120.5u
                          sn := sa;  end                                 //<''''''''''''''''''''''''''+6.2.0
                       else
                       if (x=4{=Ik3d}) and (arrayIndex>=1)  then begin   //<,,,,,,,,,,,,,,,,,,,,,,,,+5.0.1, 6.2.2
                          ar := ReadEdvJohto().arvoU[1];                       //< [1]=OFAAoikoSULraj_Is <,,+6.0.4
                          sa := fOFAAvaimIs(1,ai, ar, sn{su});
                          KorvaaDesMrk(sa); //<+120.5u
                          sn := sa;  end;                                //<''''''''''''''''''''''''''+5.0.1
                                        //,VäliOtsRivi jää silmukasta vex = 12=>11
{,,,,,,,, 6.0.1 ? ,,,} if x IN [11..13] //<,,Katk.Yliv.as.A ... C -riveille RED jos >Isall.,,,+6.0.1 ?,,,,,,
                       then begin
                          case x of  11 :xr := ReadEdvJohto().arvo[arvo_KAT_YLIV_A_11];
                                     12 :xr := ReadEdvJohto().arvo[arvo_KAT_YLIV_C_12];
                               else {13} xr := ReadEdvJohto().arvo[arvo_KAT_YLIV_D_13];
                          end;//case
                          ar := fPh_Ih;            //arvo[arvo_KAT_AIKA_14] = Katkaisijan maksimi aika-asetus
                          if xr < ar               //<Ei väliä vaikka Ph=0
                             then sn := CLR_RED +sn +FNT_0;
                       end; //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''+5.0.3''''''''}
                       tmp := tmp +sn;
                   end;//else
              end;
         end;
         //,,+6.0.3,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
{5..9}   if x IN [5..9]  then begin //<,,_____Tik sulakerivien alkuun____________________________________________ //<£ x=5..9
            ss := '';               //,,OFAval hoidettu ylempänä:  Etsi: 'OfaVal'.
            if x<>5  then
               ss := EDV_COLOR_FONT_JOHTO_HEADER;     //<Väri siniseksi muille kuin x=5 (MaxSul) väri jää Black.
            if NOT ReadEdvJohto().Kuluttaja.ArvoBoo  then begin                                        //<+9.0.1
               ss := ss +fTikToStrDim (suCse,ReadEdvJohto().arvo [x],ReadEdvJohto().arvo [arvo_IK1V_1]);
               KorvaaDesMrk(ss);  end;                                                           //<+120.5u
            tmp := ss +tmp;        //'<left> 2.04 s <right>                                      //'+6.0.4
         end;
            //tmp := tmp+'#x'+IntS (x)+'v'+IntS (valeja); //<Koe: Havainnollistaa hyvästi.!!!
//___________________________________________________________________________________________________________________________________________________________
//___________________________________________________________________________________________________________________________________________________________
//___________________________________________________________________________________________________________________________________________________________
       //tmp := tmp +IntToStr(x)+' ' +IntToStr(valeja);                      //,TÄMÄ TULOSTAA KAIKKI RVT Ik1v...t MaxIk3th.###############################
         SetText(SulakeGrid, EDV_SULAKE_COL_2, x-1 + valeja, tmp{+q2(y,x)}); //< 16.8 kA/14.5 kA (=Ik1v/Ik1v, Ik3v..Ik3d Sulak.   130.2e: x-1 pitää olla, muu-
    end;//for x := 1 to arvo_MAX_GRID_14 do                                  //' 60ms,  x=1..14  =Rv 6..21                        'ten txt väärille riveille.
    {''t Max_Ik3th´hen =rv 21 asti¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
//___________________________________________________________________________________________________________________________________________________________
//___________________________________________________________________________________________________________________________________________________________
//___________________________________________________________________________________________________________________________________________________________
    { Pisorasia, ryhmä- ja nousujohdot =Resurssitarkastelu(DEVELOPER1)___________________________________________}
    if (JohtoType=JOHTO_LIITTYMA) and (ArrayIndex>=edv.YLE.SorceCount.arvoInt)  OR
       (JohtoType=JOHTO_NORMAL)
    then for x := 1 to rjohto_MAX_9    do begin                                                                                           //<£uk
       boo := (x IN [1..3,6..7])  and (demo(38) or EXT_Demo);                         //< Demö +6.0.2, EXT_ 8.0.0 //<£
       tmp := EDV_COLOR_FONT_POHJA;
       if (x=1) and (EdvNewFrm.PRradVal.ItemIndex=1)  then //<,+8.0.8 PistorPoiskAika 0.4/0.2s
          tmp := COLOR_FUCHSIA;
       //==========================================================================================================
       if x=9                 //<,,130.2e:  LääktTilan Prj rv 31. J Ä R J E S T E L Y  ON  K O K O N A A N  U U S I.
       then begin             //,,Tässä hoidetaan samalla kerralla molemmat LääkTilan Prj palstat (vas +oik)_______.
          if {x>0//}LisYliDemo_ ({lvExtended}lvPRO) and NOT fKaikkiOikeudet_1x //< and .. +10.0.4§:  =Ohi tästä =ELSE´een. Testissä hyvä x>0 +130.2e.
        //or (x>0) //<141.1 kokeilua.
          then begin                                                    //'lvEXTended => lvPRO =11.0.1
             SetText(LahdotGrid, vas0, x{-1}, tmp +'<right>Xxx');         //< 68.4m.1:  <Oli x{-1}
             SetText(LahdotGrid, oik2, x{-1}, tmp +'<left>Xxx');          //            <Oli x{-1}
           (*SetText(LahdotGrid, 3, x{-1}, tmp +'<left>\\<right>Xxx/'); //<,130.2e  £uk: LääkTilaan enää vain 2 arvoa.
             SetText(LahdotGrid, 4, x{-1}, tmp +'<left>Xxx'); *)end
          else begin //,,Rv=31,,,,,,,,,,,,,,,,,,,,,,,,,,,VASEN PALSTA,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
           //ss := PituusToStr(ReadEdvJohto().RyhmaJ_r31[1].rjpituus[1].pituus, '', boo,1);
               ar := ReadEdvJohto().RyhmaJ_r31[1].rjpituus[1].uk;
               if (ar>0) and ((ar<ua1) or (ua1=0))  then ua1 := ar;                    //<Etsitään pienin uk £uk.
               if (ar>0) and ((ar>uy1) or (uy1=0))  then uy1 := ar;                    //<Etsitään suurin uk £uk.
wrn(0, '1r1: ReadEdvJohto().RyhmaJ_r31[1].rjpituus[1].uk=' +fRmrkt0(ar,5,1));
             sa := '';  sp := '';
             sp := PituusToStr (r31pit_Tim_Zpe_ve (1,1), '', boo,1);                   //<Pmrk :=
             if nayUk  then if Pos('- -',sp)>0
                then sa := '  - - - -'
                else sa := ' '+fRmrkt0(ar,1,1) +'V '+Pmrk;   //<+130.2e  uk-lisäys     //£130.2e: uk edit vain rvllä 22.
             ss := tmp +sp +sa;                                                        //,       ,,,,,
             KorvaaDesMrk(ss); //<+120.5u                                              //,130.2e: -1 vex £uk
//ss := '[31 x' +Ints(x);      //<PARAS, HVANNOLLISIN +130.2e.
//ss := '1:  ' +ss;
{ø1}         SetText(LahdotGrid, vas0, x{-1}, ss {+g_'ø1'});                             //<rv 31: 35.4m / 82.5m  141.1: <Oli x{-1}    <130.2e: -1 £uk

             //,,Rv=31,,,,,,,,,,,,,,,,,,,,,,,,,,,OIKEA PALSTA,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
               ar := ReadEdvJohto().RyhmaJ_r31[1].rjpituus[2].uk;
               if (ar>0) and ((ar<ua2) or (ua2=0))  then ua2 := ar;                    //<Etsitään pienin uk £uk.
               if (ar>0) and ((ar>uy2) or (uy2=0))  then uy2 := ar;                    //<Etsitään suurin uk £uk.
wrn(0, '1r2: ReadEdvJohto().RyhmaJ_r31[1].rjpituus[2].uk=' +fRmrkt0(ar,5,1));
             sa := '';  sp := '';                                                      //,Pmrk :=
             sp := PituusToStr (r31pit_Tim_Zpe_ve (1,2), '', boo,1);                   //'               '''''
             if nayUk  then if Pos('- -',sp)>0
                then sa := '  - - - -'
                else sa := ' '+fRmrkt0(ar,1,1) +'V '+Pmrk;   //<+130.2e  uk-lisäys     //£130.2e: uk edit vain rvllä 22.
             ss := sp +sa;                                                             //'               '''''
             KorvaaDesMrk(ss); //<+120.5u
//tmp := '[32 x' +Ints(x);     //<PARAS, HVANNOLLISIN +130.2e.
{ø2}         ss := tmp +'<left>' +ss;// +g_('ø2');                                     //'               '''''
//ss := ss +'2: ';
             SetText(LahdotGrid, oik2, x{-1}, ss{ +'£12' {+q2(x)});                      //'               ,,,,,         <Oli x{-1}    <130.2e: -1 £u
          end;//else
       end//''if x=9 =rv31 ====================================================== ''LääkTila rv 31 =======================================================
       else begin //,,rv=23-30   x=1 2 3 4 5 6 7 8 (9 hoituiEd) ================= ,,NormRivit 23-30=========VASEN PALSTA==================================
       {//µ}//ai := ReadEdvJohto().RyhmaJohto[x].rjpituus[1].TUP;                      //<+130.2e:  Debuggerille TUP.
            rr := ReadEdvJohto().RyhmaJohto[x].rjpituus[1].uk;
          //rr := ReadEdvJohto().RyhmaJ_r31[1].rjpituus[1].uk;
wrn(0, '1:  ReadEdvJohto().RyhmaJohto[x' +Ints(x) +'].rjpituus[1].uk=' +fRmrkt0(rr,5,1));
            ar := rr;
            if (ar>0) and ((ar<ua1) or (ua1=0))  then ua1 := ar;                       //<Etsitään pienin uk £uk.
            if (ar>0) and ((ar>uy1) or (uy1=0))  then uy1 := ar;                       //<Etsitään suurin uk £uk.
wrn(0, '1´: ua1=' +fRmrkt0(ua1,4,1) +' uy1=' +fRmrkt0(uy1,4,1));
          sa := '';  sp := '';
          sp := PituusToStr (RJpit_Tim_Zpe_ve (x,1), '', boo,1);    //<Pmrk:=          //'               '''''
          if nayUk  then if Pos('- -',sp)>0                                            //<'"- - - -" tuli edRvllä.
             then sa := '  - - - -'
             else sa := ' '+fRmrkt0(ar,1,1) +'V ' +Pmrk;   //<+130.2e  uk-lisäys       //£130.2e: uk edit vain rvllä 22.
          ss := sp +sa;
          KorvaaDesMrk(ss); //<+120.5u
          sa := TupToStr(ReadEdvJohto().RyhmaJohto[x].rjpituus[1].TUP);                //<+130.2e.TUP
        //sa := TupToStr(ReadEdvJohto().RyhmaJ_r31[1].rjpituus[1].TUP);                //<+141.1
          tmp := tmp +ss +sa;
//tmp := '3:  ' +tmp;
{ø5}      SetText(LahdotGrid, vas0, x{-1}, tmp);//+'£13'{+'ø5'+q2(x)});  //< 68.  4m /

          //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,OIKEA PALSTA,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
          tmp := EDV_COLOR_FONT_POHJA;
          if (x=1) and (EdvNewFrm.PRradVal.ItemIndex=1)  then //<,+8.0.8 PistorPoiskAika 0.4/0.2s
             tmp := COLOR_FUCHSIA;
            rr := ReadEdvJohto().RyhmaJohto[x].rjpituus[2].uk;
          //rr := ReadEdvJohto().RyhmaJ_r31[1{x}].rjpituus[2].uk;
wrn(0, '2:  ReadEdvJohto().RyhmaJohto[x' +Ints(x) +'].rjpituus[2].uk=' +fRmrkt0(rr,5,1));
//n(0, '2:  ReadEdvJohto().RyhmaJ_r31[1].rjpituus[1].uk=' +fRmrkt0(rr,5,1));
            ar := rr;
            if (ar>0) and ((ar<ua2) or (ua2=0))  then ua2 := ar;                       //<Etsitään pienin uk £uk.
            if (ar>0) and ((ar>uy2) or (uy2=0))  then uy2 := ar;                       //<Etsitään suurin uk £uk.
wrn(1, '2´: ua2=' +fRmrkt0(ua2,4,1) +' uy2=' +fRmrkt0(uy2,4,1));
          sa := '';  sp := '';
          sp := PituusToStr (RJpit_Tim_Zpe_ve (x,2), '', boo,1);    //<Pmrk:=
          if nayUk  then if Pos('- -',sp)>0
             then sa := '  - - - -'
             else sa := ' '+fRmrkt0(ar,1,1) +'V ' +Pmrk;   //<+130.2e  uk-lisäys
          ss := sp +sa;
          KorvaaDesMrk(ss); //<+120.5u
          sa := TupToStr(ReadEdvJohto().RyhmaJohto[x].rjpituus[2].TUP);              //<+130.2e.TUP
          tmp := tmp +ss +sa;

//1202:====Testerin pitää näyttää,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
        //,#####################################################################################
        //1414fu/1415a:  HeadeGrid´in 114/86 yms -arvot on kolvattuina TextBaseText.PAS´sissa.
        //'#####################################################################################
        //tmp := tmp +'<colspan c="3"><left></f>   {132A/98.4A}';  +1202, Rivistä luettu+laskettu +120.5,,,,,,,,,,,,,,,,,,,,,,,,,,
//sa := 'ö';{
          sa := EdvNewFrm.Johdot.HeaderGrid.Cells[1,16+x]; //<,,rv 23-30.                          sa= "Pistor...Dz 0.4s 16/10A ...(114/84A)
          sa := Trim(sa);  SU := '';                       //,,,,,,,,,,,,,,+130.0 VarmVuoksi.      ,+130.2e: +(Length(sa)>0)
          if (Length(sa)>0) and (sa[Length(sa)]  =')') and (Length(sa)-2 >0) and CharInSet(sa[Length(sa)-3],['0'..'9'])  OR   //,JOSKUS myös tunnistuksen erikMrk "`", "¨" tms.
             (Length(sa)>1) and (sa[Length(sa)-1]=')') and (Length(sa)-3 >0) and CharInSet(sa[Length(sa)-3],['0'..'9'])  then //<Rivin lopussa on (165/102.5) tms. '+130.0
            SU := fTesteriLukemaPalsta (sa);                                 //<+120.5:  Testerinäyttämäpalsta siirretty PRC´ksi.####################}
//tmp := '[oik x' +Ints(x);    //<PARAS, HVANNOLLISIN +130.2e.
          ss := '<left>' +tmp +SU;
//ss := '4: ' +ss;
{ø5}      SetText(LahdotGrid, oik2, x{-1}, ss);// +'µ');//+'£13'{+'ø5'+q2(x)});       //< 68.  4m /                                          ££
(*                                                                                                                  Ei onaa vinoviivan piirto.
//procedure DrawAlasJohto(Image: TImage; height, border,{120.6:}LocIndx,ArrIndx: integer;  qType: TJohtoType);      VAR x1,x2, y1,y2: integer;
          LahdotGrid.Canvas.Pen.color := clRed;
   {Image}LahdotGrid.Canvas.brush.color := clRed;
   //{Image}LahdotGrid.Canvas.FillRect(Rect(0,0, image.width,image.height));
     {Image}LahdotGrid.Canvas.Pen.Width := 3;
     {Image}LahdotGrid.canvas.MoveTo(50, 50);
     {Image}LahdotGrid.canvas.LineTo(10,100);//*)
       end;//if x=9 else
       if x=9  then begin           //<,,+130.2e:  Kun on vika rvkin editoitu, editoidaan uk -yleistilanne rvlle 22.
          asetaValit (1,8); //<1..8 =Cell -osoitteita (Row).                        //<Asettaa (132A/98.4A) vasSuoraksi +väri +<left>.

wrn(0,'3>: x=' +Ints(x) +'  ar=uy1(' +fRmrkt0(uy1,1,1) +') - ua1(' +fRmrkt0(ua1,1,1) +') =' +fRmrkt0(uy1-ua1,1,1) +' /uy1/100(' +fRmrkt0(uy1/100,1,1));
          if uy1<>0
          then begin
             ar := (uy1 -ua1 /uy1) /100; //,+1412.
             sa := {EDV_COLOR_FONT_POHJA +' '+}fRmrkt0(uy1,1,1) +'V:' +fRmrkt0(ar,1,1) +'%';  end //<Alkuun väli ettei näytä tungetulta.Ei hyvä!?!?
          else sa := '---V: ---%';       //<'+1412.
//sa := '5:  ' +sa;
          SetText(LahdotGrid, vas0, 0, sa);

wrn(1,'3´: x=' +Ints(x) +'  ar=uy2(' +fRmrkt0(uy2,1,1) +') - ua2(' +fRmrkt0(ua2,1,1) +') =' +fRmrkt0(uy2-ua2,1,1) +' /uy2/100(' +fRmrkt0(uy2/100,1,1));
          if uy2<>0
          then begin
             ar := (uy2-ua2/uy2)/100;    //,+1412.
             sa := {EDV_COLOR_FONT_POHJA +}fRmrkt0(uy2,1,1) +'V:' +fRmrkt0(ar,1,1) +'%';  end
          else sa := '---V: ---%';       //<'+1412.
//sa := '6:  ' +sa;
          SetText(LahdotGrid, oik2, 0, '<left>' +sa);
       end;//if x=9
    end;//for x := ..
//___________________________________________________________________________________________________________________________________________________________
//_______'X silmukka loppui._________________________________________________________________________________________________________________________________
//___________________________________________________________________________________________________________________________________________________________
    //,,Putsataan KAIKKI rvt 31...35, muuten jää vanha SorceCount -sarakkeen tiedot osittain näkyviin, TODETTU.##############################################
    if (JohtoType=JOHTO_LIITTYMA) and (ArrayIndex<edv.YLE.SorceCount.arvoInt)                  //<,,+8.0.0   130.2e:  VinOsa res johdsta häviää uk´n takia.
    then for y := 0 to LahdotGrid.RowCount-1  do
         for x := 0 to LahdotGrid.ColCount-1  do
            LahdotGrid.Cells[x,y] := ''//Cmrk('€')
    else for y := 0 to LahdotGrid.RowCount-1  do  //<,Vain TÄSSÄ erotin "/" (ks. SetText)########################
         LahdotGrid.Cells[EDV_MIDDLE_COL_1,y] := ALIGN_CENTER + EDV_COLOR_FONT_POHJA + //Cmrk('~') +
                                                 EDV_LAHDOT_EROTIN +' '; // ="/". Väilyönti lisätty, muuten osa mrkstä häviää.
                                                                         //'TÄMÄ sijoittaa "/" -mrkn ao. rvlle.
{ Nousujohdot =Resurssitarkastelu(DEVELOPER1)_______________________________________________________________________________________________________}
    if (JohtoType=JOHTO_LIITTYMA) and (ArrayIndex=edv.YLE.SorceCount.arvoInt)  OR                //<+8.0.0
       (JohtoType=JOHTO_NORMAL)
  //if arrayIndex>=edv.YLE.SorceCount.arvoInt  //<+8.0.0  Ks. myös: Etsi "EDV_MIDDLE_COL_1" ja samalla rivillä
    then for x := 1 to njohto_MAX_4  do begin  //'                  "EDV_LAHDOT_EROTIN" =PRC TJohto.SetTexts; :ssa
                                               //                   missä poistetaan "/" 1.5/2.5 mm² välistä.
         boo := (x<njohto_MAX_4)  and (demo(39) or EXT_Demo);               //<VikaRvlle aina arvot(TR) +8.0.0
         ss := '';
         if ReadEdvJohto().nousujohto[x].sulake>0
            then       tmp := IntToStr (ReadEdvJohto().nousujohto[x].sulake)
          //else begin tmp := '- - - ';  ss := tmp +'m';  end;    //<Pituus asetetaan valmiiksi 0 :ksi = '- - - m'
            else begin tmp := myTextBase.Get(EDV_VIRHE);  ss := tmp +'m';  end; //<Pituus asetetaan valmiiksi 0 :ksi = '- - - - m'
                     //tmp := myTextBase.Get(EDV_VIRHE);  ss := tmp +'m';
         SetText(LahdotGrid, EDV_LAHDOT_SULAKE_COL_0, rJohto_MAX_9 + x{-1},                                                           //<130.2e: -1 vex £uk
                             EDV_COLOR_FONT_POHJA +'<right>' +tmp +                          //<rv 32-35:  160A /  185 AMCMK3½ 799.9m
{ø7}                         myTextBase.Get(SYMBOLI_AMPEERI));// +g_('ø7µ4´'));                    //            ''''

//,,ø8 ja ø9 nyt samalla kerralla [2,x-1]´een,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
         tmp := EDV_COLOR_FONT_POHJA +'<left>';
         ai := a_getIntg (1010110, ReadEdvJohto().Lukumaara);
         if ai>1  then tmp := tmp +IntToStr (ai) +'x';
         tmp := tmp +PoikkiPintaToStr(ReadEdvJohto().nousujohto[x].Amm2, '', boo) +' ';
{ø8+ø9}  tmp := tmp +{g_('ø8') +}a_getStrg (1010111, ReadEdvJohto().Tyyppi) +{g_('ø9') +}' ';  //< AMCMK3½

         if ss<>''                                //<,Asetettiin edellä if ...sulake>0 mukaan   <,,,+6.2.19
            then tmp := tmp +ss                   //<= jos SULAKE=0 => pituus = '- - - m'
          //else tmp := PituusToStr (ReadEdvJohto().nousujohto[x].PITUUS, '', boo,1);// + myTextBase.Get(SYMBOLI_METRI);
            else begin //,,,,,,,,,,,,,,,,,,Tim_Zpe_ve valitsee joko PITUUS tai PitZPE:n EdvBx:n mukaan.
                 ar := NJpit_Tim_Zpe_ve (x);                                                 //<ar =+10.0.4 ,+9.0.1
                 su := PituusToStr (ar, '', boo,1);
                 KorvaaDesMrk(su); //<+120.5u
                 tmp := tmp +su;                                                             //<,+9.0.1
            end;
         if NOT ReadEdvJohto().Kuluttaja.ArvoBoo        //<SÄL -johto-osalle merkiksi '¨'.       +8.0.7
            then tmp := tmp +'¨';//¯';//³';
        {SetText(LahdotGrid, EDV_LAHDOT_PITUUS_COL_4, rJohto_MAX_9 + x -1,     //'Nyt Symboli ..ToStr :ssa.
                 EDV_COLOR_FONT_POHJA +tmp+'@');                               //< 234,6 m     //<'-9.0.1 }

         ar := NJpit_Tim_Zpe_ve (x);                                      //<Muuttaa Prmk´inkin. ar 10.0.4
         if ar>0.1                                                                              //<,+9.0.1
         then begin
            if Pmrk<>''                                                                         //<,+9.0.1
               then tmp := tmp +Pmrk
               else if (ReadEdvJohto().Nousujohto[x].TUP >0)  then //<,Tekee muuten vain tyhjän mrkn ' ' loppuun, eiHyvä???
                       tmp := tmp + ' ' + TupToStr(ReadEdvJohto().Nousujohto[x].TUP);  end
         else tmp := tmp +Pmrk;                              //<Pmrk lisätään 0.0 :kin perään       +10.0.4

            ai := rJohto_MAX_9 + x{-1};                                                         //<130.2e: -1 vex £uk
{øz}     SetText(LahdotGrid, EDV_LAHDOT_PPINTA_COL_2, ai, EDV_COLOR_FONT_POHJA +tmp);           //< 234,6 m       //<rv 32-35:  160A /  185 AMCMK3½ 799.9m
                           //EDV_COLOR_FONT_POHJA +{'<left>' +g_('øz') +}tmp{+'%'+Ints(x) +g_('ø§µ5´')});
//       if x=njohto_MAX_4  then begin //ai,ii,k                                                //<,,Koe §u§ +8.0.7                                 ''''''
    end;//for x
Tics ('<b>TJohto.RefreshNorm 9</b>');
                                          //DefsFileenZ('Johto.PAS/9');
end;//RefreshNormal

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.RefreshLast; //Edv´n viimeisen eli NousuLähdön johto-osan arvoja.
var
   ai,ii,u,oa{120.5n} :integer;     //<DEVELOPER1:  +ai   2.0.3  ii,u: +10.0.3
   tmp :string;  boo,boa :boolean;  //<DEVELOPER1   +boo  8.0.0  boa:  +10.0.3
   rr,xr,zs,ar :real;
   sa,sn,ss,su :string;             //<DEVELOPER1   +sa,sn 2.0.7  +ss 6.0.3  +su 6.2.1
begin
Tics ('TJohto.RefreshLast 1');
 {button.Caption := '%';            //<,, -4.0.0 ----------------------------------------------
  buttonHide.Caption := '%';

  tmp := EDV_COLOR_FONT_INPUT;
  tmp := tmp + myTextBase.Get(EDV_LAHTO_VERKON_RAJA_ARVO);
  tmp := tmp + EDV_LAHTO_EROTIN + ProsenttiToStr(a_getReaa(101101, NjL.yhtUhRaja), '', False);
  tmp := tmp + myTextBase.Get(SYMBOLI_PROSENTTI);
  label1.caption := tmp;

  tmp := EDV_COLOR_FONT_INPUT;
  tmp := tmp + myTextBase.Get(EDV_LAHTO_EDELTAVAN_VERKON_OSUUS);
  tmp := tmp + '  ' + EDV_LAHTO_EROTIN + ProsenttiToStr(a_getReaa(101102, NjL.edUhOsa), '', False);
  tmp := tmp + myTextBase.Get(SYMBOLI_PROSENTTI);
  label2.caption := tmp;

  tmp := EDV_COLOR_FONT_POHJA;
  tmp := tmp + myTextBase.Get(EDV_LAHTO_NJ_VERKON_OSUUS);                             //,DEVELOPER1:  oli TR
  tmp := tmp + EDV_LAHTO_EROTIN + ProsenttiToStr(a_getReaa(101104, NjL.NjUhRaja), '', false);
  tmp := tmp + myTextBase.Get(SYMBOLI_PROSENTTI);
  label3.caption := tmp;}


  // label1.caption := ' ';         //<,, +4.0.0  Oltava ' ', ei '', muuten ei rivikorkeus OK.
  // label2.caption := ' ';
  // label3.caption := ' ';
  // DEVELOPER2 2003-11-21 BEGIN
  CablePanel.rows[FIRST_CABLE_ROW + 0] := ' ';        //<,, +4.0.0  Oltava ' ', ei '', muuten ei rivikorkeus OK.
  CablePanel.rows[FIRST_CABLE_ROW + 1] := ' ';
  CablePanel.rows[FIRST_CABLE_ROW + 2] := ' ';
  // DEVELOPER2 2003-11-21 END
  // Sulakkeet
  // Jos kommenttisulut poistetaan, ei %-prosenttipalstassa näy Ikv-arvoja
  // mikäli johto-osia on nolla.
  { if (index = 1)  then
  begin
       // Tyhjennetään solut
       SetText(SulakeGrid, EDV_SULAKE_COL_2, 0, ' ');
       SetText(SulakeGrid, EDV_SULAKE_COL_2, 1, ' ');
       SetText(SulakeGrid, EDV_SULAKE_COL_2, 2, ' ');
       SetText(SulakeGrid, EDV_HEADER_COL_0, 0, ' ');
       SetText(SulakeGrid, EDV_HEADER_COL_0, 1, ' ');
       SetText(SulakeGrid, EDV_HEADER_COL_0, 2, ' ');
       SetText(SulakeGrid, EDV_MIDDLE_COL_1, 0, ' ');
       SetText(SulakeGrid, EDV_MIDDLE_COL_1, 1, ' ');
       SetText(SulakeGrid, EDV_MIDDLE_COL_1, 2, ' ');
  end
  else
  begin }
    //,,,Oikea palsta =Viereen vasemmalle tulee tämän jälkeen vielä arvojen nimet,,,,,,,,,,,,,,,,,,,
    boo := demo(40) or EXT_Demo;                                                                    //< +8.0.0
    tmp := VirtaToStr(a_getReaa(101103, ReadNjL().Ik1v), ' ', boo) +
           myTextBase.Get(SYMBOLI_AMPEERI);
    KorvaaDesMrk(tmp); //<+120.5u
    SetText(SulakeGrid, EDV_SULAKE_COL_2, 0, STYLE_BOLD_BEGIN + EDV_COLOR_FONT_NJ + tmp);

    tmp := VirtaToStr(a_getReaa(101104, ReadNjL().Ik3v), ' ', FALSE) +
           myTextBase.Get(SYMBOLI_AMPEERI);
    KorvaaDesMrk(tmp); //<+120.5u
    SetText(SulakeGrid, EDV_SULAKE_COL_2, 1, STYLE_BOLD_BEGIN + EDV_COLOR_FONT_NJ + tmp);

    tmp := VirtaToStr(a_getReaa(101104, ReadNjL().Ik3t), ' ',boo) +         //<,DEVELOPER1: Ik3th väliin   <boo +8.0.0
           myTextBase.Get(SYMBOLI_AMPEERI);
       ar := edv.NjL.Ik3thOfaOikos;          //<OFAAraj_Is OikosSUL laskettu ed.j-osan OikoSUL :sta. +6.2.0
       tmp := fOFAAvaimIs (1,1, ar, tmp);
    KorvaaDesMrk(tmp); //<+120.5u
    SetText(SulakeGrid, EDV_SULAKE_COL_2, 2, EDV_COLOR_FONT_POHJA + tmp);

    tmp := VirtaToStr(a_getReaa(101104, ReadNjL().Ik3d), ' ',boo) +                                //<boo +8.0.0
           myTextBase.Get(SYMBOLI_AMPEERI);
                                                          //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,+6.0.4,,,,,,,
       ar := edv.NjL.Ik3dOfaOikos;                        //<OFAAraj_Is OikosSUL laskettu ed.j-osan OikoSUL :sta.
       tmp := fOFAAvaimIs (1,1,ar, tmp);
    KorvaaDesMrk(tmp); //<+120.5u
    SetText(SulakeGrid, EDV_SULAKE_COL_2, 3, EDV_COLOR_FONT_POHJA + tmp);                       //<Ik3d
  //        SetText(SulakeGrid, EDV_SULAKE_COL_2, 3, EDV_COLOR_FONT_POHJA + tmp +'\1;');

    sn := '';                                                   //<Pyyhkii vanhan tiedon.
    sa := '';
    ai := a_getIntg(101105, edv.YLE.JohtoOsia);                 //<Sorcen jälkeisiä jOsia.
    ii := edv.YLE.SorceCount.arvoInt;                           //<Sorcen jOsia.                //<,,+10.0.3
  //boa := false;
    if ii<-1  then ShowMessage('Johto.PAS: ii -laskurin poikkeus <0 (tarkkailuarvo), ei ongelmia, JATKA.');     //<+120.5n/6
   {if ai IN [0..1]                                                                             //<,,-120.5n/6
    then begin
       for u := 1 to ii  do
          if edv.Sorc[u].Josa.OfaVal.arvoInt >0  then boa := true;  end
    else  if edv.Edka[ai].OfaVal.arvoInt >0      then boa := true;                              //<''+10.0.3}

//,,Jos vain 1 src JA sen jOsalle ennettu OFAA TAI edvn jOsissa annettu OFAA-arvo, lasketaan vaikutus viimeisimmän EDELLISEN OFAAn mukaan.
//  Tutkittu +laskenta EdvNewLask.PAS´sa. :+1205n/6
    oa := 0;
    for u := ai-1 to 1  do                       //<,,Etsitään Edv´n vika OFAA.
    if edv.Edka[u].OfaVal.arvoInt >0
       then oa := edv.Edka[u].OfaVal.arvoInt;

    if (oa=0)  then                              //<Jos ei ollut Edj´ssa OFAA, etsitään SorcJ´sta PIENIN.
    for u := 1 to ii  do
    if (oa=0) or ((oa>0) and (edv.Sorc[u].Josa.OfaVal.arvoInt <oa))
       then oa := edv.Sorc[u].Josa.OfaVal.arvoInt;
    boa := oa>0;                                                                                //<''+120.5n/6'''''''''''''''''''''''''''

  //if (ai>0) and (a_getIntg (101105, edv.edka[ai].OfaVal) >0)  then begin                      //,,-6.2.0
    if boa  then begin                                                                          //,,-6.2.0 <10.0.3
      {sn := VirtaToStr (a_getReaa (101105, edv.NjL.Ik3d), ' ', FALSE) + myTextBase.Get(SYMBOLI_AMPEERI);
       if a_getIntg (101105, edv.edka[ai].OfaVal) >0  then begin
          sa := EDV_COLOR_FONT_POHJA_HEADER +ALIGN_CENTER + EDV_SULAKE_EROTIN;
          sn := fOFAAvaimIs (edv.NjL.Ik3dOfaVal, sn);  end;             //< ValitunOFAAnRaj_Is
       sn := COLOR_IK3D_ + sn +'</f>';}

       sa := EDV_COLOR_FONT_POHJA_HEADER +ALIGN_CENTER + EDV_SULAKE_EROTIN;             //,,UUSITTU 6.2.1  < color<..><center>':'
       su := VirtaToStr (a_getReaa(101105, edv.NjL.Ik3t), ' ', boo) + myTextBase.Get(SYMBOLI_AMPEERI); //<boo +8.0.0
       KorvaaDesMrk(su); //<+120.5u
       sn := VirtaToStr (a_getReaa(101105, edv.NjL.Ik3d), ' ', boo) + myTextBase.Get(SYMBOLI_AMPEERI); //<boo +8.0.0
       KorvaaDesMrk(sn); //<+120.5u
  //           sn := VirtaToStr (a_getReaa(101105, edv.NjL.Ik3d), ' ', FALSE) + 'Q';//myTextBase.Get(SYMBOLI_AMPEERI);
       sn := fOFAAvaimIts (1,1, edv.NjL.Ik3thOfaVal, edv.NjL.Ik3dOfaVal, su, sn);
                {Ik1v,Ik3v,Ik3t,Ik3d :arvoTyyp;
                 Ik3thOfaOikos,Ik3thOfaVal,
                 Ik3dOfaOikos,Ik3dOfaVal :real;}
                                               //'=> Ik3th/Ik3d, kun suojaava OFAA huomioitu.
       KorvaaDesMrk(sn); //<+120.5u
       sn := ss +sn;                           //'=> (17.1/27.6 kA). Asettaa + lopettaa myös tekstivärin:  COLOR_IK3D_
    end;
    SetText(SulakeGrid, EDV_SULAKE_COL_2, 4, sn);
    SetText(SulakeGrid, EDV_MIDDLE_COL_1, 4 ,sa);                         //< Arvon jälkeen joko ':' tai '';
  //        SetText(SulakeGrid, EDV_SULAKE_COL, 4, sn +'\2;');
  //        SetText(SulakeGrid, EDV_MIDDLE_COL_1, 4 ,sa +'\3;');                  //< Arvon jälkeen joko ':' tai '';
                                                    //''''''''''''''''''''''''''''''''''''''''+6.0.4''''''''
    //,,,Vasen palsta =Viereen oikealle tulevien arvojen nimet,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    tmp := myTextBase.Get(EDV_HEADERS_LYHYT + '-row-1');
    SetText(SulakeGrid, EDV_HEADER_COL_0, 0, STYLE_BOLD_BEGIN + EDV_COLOR_FONT_NJ + tmp);
    tmp := myTextBase.Get(EDV_HEADERS_LYHYT + '-row-2');
    SetText(SulakeGrid, EDV_HEADER_COL_0, 1, STYLE_BOLD_BEGIN + EDV_COLOR_FONT_NJ + tmp);
    tmp := myTextBase.Get(EDV_HEADERS_LYHYT + '-row-3');                //<,DEVELOPER1: Ik3th väliin
    SetText(SulakeGrid, EDV_HEADER_COL_0, 2, EDV_COLOR_FONT_POHJA + tmp);
    tmp := myTextBase.Get(EDV_HEADERS_LYHYT + '-row-4');                //<,DEVELOPER1: +1
    SetText(SulakeGrid, EDV_HEADER_COL_0, 3, EDV_COLOR_FONT_POHJA + tmp);

    tmp := '';                                                                                  //,,+6.0.4
  //ai := a_getIntg(101106, edv.YLE.JohtoOsia);                             //<Never used.          -10.0.3
  //if (ai>0) and (a_getIntg (101105, edv.edka[ai].OfaVal) >0)  then        //<Ei tosin merkitystä. +10.0.3
  //if (edv.NjL.Ik3thOfaOikos>0) or (edv.NjL.Ik3dOfaOikos>0)  then                               //<+10.0.3
    if boa  then begin                                                                           //<+10.0.3
       tmp := ALIGN_RIGHT +COLOR_IK3D_ +'ofa </f>';
       KorvaaDesMrk(tmp);  end; //<+120.5u
    if tmp=''  then tmp := ' ';                    //<Pakko lisätä välilyönti jotta tyhjä rivi tulostuisi. +6.2.16
    SetText(SulakeGrid, EDV_HEADER_COL_0, 4, tmp);

    tmp := ALIGN_CENTER + EDV_SULAKE_EROTIN;                                                //< <center>':'
    SetText(SulakeGrid, EDV_MIDDLE_COL_1 , 0 , STYLE_BOLD_BEGIN + EDV_COLOR_FONT_NJ + tmp);
    SetText(SulakeGrid, EDV_MIDDLE_COL_1 , 1 , STYLE_BOLD_BEGIN + EDV_COLOR_FONT_NJ + tmp);
    SetText(SulakeGrid, EDV_MIDDLE_COL_1 , 2 , EDV_COLOR_FONT_POHJA + tmp);
  //end;

    // Seuraavassa asetetaan viimeisen johto-osan Rs-, Xs- ja Zs-arvot
    // DEVELOPER2 7.12.1998. Absoluuttinen rivi suhteelliseksi EDV_MAX_SULAKKEET_HEADER_ROW_4 nähden
    rr := a_getReaa(101104, ReadNjL().yhtRs);                                  //< +3.0.3  YhtRs -> rr
    tmp := ResistanssiToStr(rr, ' ', FALSE) +
           myTextBase.Get(SYMBOLI_OHM);
    KorvaaDesMrk(tmp); //<+120.5u
    SetText(SulakeGrid, EDV_SULAKE_COL_2, EDV_MAX_SULAKKEET_HEADER_ROW_4 + 1,
            STYLE_BOLD_BEGIN + EDV_COLOR_FONT_NJ + tmp);

    xr := a_getReaa(101104, ReadNjL().yhtXs);
    tmp := ResistanssiToStr(xr, ' ', FALSE) +
           myTextBase.Get(SYMBOLI_OHM);
    KorvaaDesMrk(tmp); //<+120.5u
    SetText(SulakeGrid, EDV_SULAKE_COL_2, EDV_MAX_SULAKKEET_HEADER_ROW_4 + 2,
            EDV_COLOR_FONT_POHJA + tmp);

    zs := a_getReaa(101104, ReadNjL().yhtZs);                                   //< +3.0.3  YhtZs -> zs
    tmp := ResistanssiToStr(zs, ' ', FALSE) +
           myTextBase.Get(SYMBOLI_OHM);
    KorvaaDesMrk(tmp); //<+120.5u
    SetText(SulakeGrid, EDV_SULAKE_COL_2, EDV_MAX_SULAKKEET_HEADER_ROW_4 + 3,
            EDV_COLOR_FONT_POHJA + tmp);

   {xr := rr/zs;                                                          //<,,+3.0.3  CosFii = xr (tässä)
    tmp := fMrkvia (xr,4) +' (' +fMrkvia (arcCosi (xr),3) +'°)';}         //<' -4.0.1  DEVELOPER1
    LiitRpX_Phi_Str (rr,xr,0, sa,sn);                                     //<, +4.0.1  sa="rr/xr", sn="Phi"
    KorvaaDesMrk(sa); //<+120.5u
    KorvaaDesMrk(sn); //<+120.5u
    tmp := sa +' ' +FONT_FII +sn +'°';
    KorvaaDesMrk(tmp); //<+120.5u

    SetText(SulakeGrid, EDV_SULAKE_COL_2, EDV_MAX_SULAKKEET_HEADER_ROW_4 + 4,
            EDV_COLOR_FONT_POHJA + tmp);

    rr := a_getReaa(101104, ReadNjL().yhtR1);                                   //< +6.0.1a,,,,,,,,,,,,,,,,,,,,,,,
    xr := a_getReaa(101104, ReadNjL().yhtX1);
    LiitRpX_Phi_Str (rr,xr,0, sa,sn);                                     //<,sa="R1/X1", sn="Phi"
    KorvaaDesMrk(sa); //<+120.5u
    KorvaaDesMrk(sn); //<+120.5u
    tmp := sa +' ' +FONT_FII +sn +'°';
    KorvaaDesMrk(tmp); //<+120.5u
  //tmp := fRmrkt0 (rr,1,5)+'/' +fRmrkt0 (xr,1,5);                        //<Tarkistettu: Uv/(V¨r²+x²)=Ik3v

    SetText(SulakeGrid, EDV_SULAKE_COL_2, EDV_MAX_SULAKKEET_HEADER_ROW_4 + 5,
            EDV_COLOR_FONT_POHJA + tmp);
Tics ('TJohto.RefreshLast 9');
end;//RefreshLast

// DEVELOPER2 2003-11-21 BEGIN
///////////////////////////////////////////////////////////////////////////////
procedure TJohto.RefreshConnection;      VAR rr,xr :real;  kerroin,ai :integer;  tmp,sa,sn :string;
begin                                    //Liittymätiedot, ei sis. johtotietoja.
Tics ('TJohto.RefreshConnection 1');
//'''''''''''''''''' Tesiajoon POISTA rivin alusta kommenttisulku '''''''''''''''''''''''''''''''''''''''''''''
//Testausta varten,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
{ CablePanel.rows[0] := '<1>Muuntaja 500 kVA srj 1 (normPh)'; //Tesiajoon POISTA rivin alusta kommenttisulku ,,,
  CablePanel.rows[1] := '<2>Zy=0.098+j1.157m'+FONT_OMEGA;
  CablePanel.rows[2] := '<3>Johto.PAS  Etsi: "<1>" tms.'; //}
//===============================================================================================================

(*,,,,,,,,,,,,,,,,,, Testiajoon POISTA tämän rivin lopusta kommenttisulku,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,*)
                         // Seuraava on kopioitu funktiosta refresh() kohdasta FIRST_CABLE
                         //#######################################################################################
                         //#######################################################################################
                                               //<DEVELOPER1:  arrayIndex Kertoo indeksin tietorakenteessa.
                                           {if (locationIndex=99  and         // Kertoo indeksin EdvNewFrmissa
                                                (arrayIndex=99)  then beep;   // Kertoo indeksin tietorakenteessa}
                         // Edv.Sorc[nro].src.XXXX  muutettu src.XXX   KAI 2004-01-16
                         //#######################################################################################
                         //#######################################################################################
  CablePanel.rows[0] := ' '; //Muuntaja: 800 kVA  <,,JohtoBtn´in viereiset 3 tekstiriviä
  CablePanel.rows[1] := ' '; //+Zy...
  CablePanel.rows[2] := ' '; //R1y/X1y...

  case a_getIntg (101002, ReadSrc().SorceKind) of //< 1=Transformer  2=LV-Cable  3=Generator  4=UPS
  1 :begin //< 1=SJ-LIITTYMÄ =====================================================================================
     //DrawMuuntaja(SulakeImage, TRUE, psSolid); //< 3.0.2  DEVELOPER1: lisätty  psSolid                  //-6.2.2
       rr := a_getReaa(101063, ReadSrc().yvRs);
       xr := a_getReaa(101073, ReadSrc().yvXs);
       kerroin := 0;

       if (rr > xr) then
          RealToStrForceTail(rr, TRUE, TRUE, 4, kerroin, SMALLEST_RESISTANSSI, ' ')
       else
          RealToStrForceTail(xr, TRUE, TRUE, 4, kerroin, SMALLEST_RESISTANSSI, ' ');

       tmp := EDV_COLOR_FONT_JOHTO_HEADER +myTextBase.Get(EDV_YLAVERKKO_MUUNTAJA) +':';
  {,1600 kVA muuttui 2 MVA :ksi, korjattu väliaikaisesti ??? / DEVELOPER1 ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  alp=         tmp := tmp + ' ' + EDV_COLOR_FONT_INPUT + IntgToStr(a_getIntg(101003, src.Smn) * 1000, TRUE, INFINITE, 1, ' ');
       tmp := tmp + myTextBase.Get(SYMBOLI_VOLTTI);
       tmp := tmp + myTextBase.Get(SYMBOLI_AMPEERI)+  COLOR_END +' + ';}
       //,Korjaus DEVELOPER1,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
       tmp := tmp + ' ' + EDV_COLOR_FONT_INPUT + fImrkt0(a_getIntg(101003, ReadSrc().Smn),1) +' kVA';
       ai := a_getIntg(101003, ReadSrc().TrfTyp);
       sa := '';                                         //<,, +6.0.0
       if ai>10  then begin
          sa := ' (-93)';
          ai := ai-10;  end;
       tmp := tmp +COLOR_BLUE +' srj</f><b> ' +fImrkt0 (ai,1) +'</b>' +sa; //< +2.0.3  3.0.1  8.0.8
     //if ai=3  then tmp := tmp + '(minZ)';             //< +3.0.1 -3.0.1
       case ai of                                       //<,,+6.0.2
          1 :tmp := tmp + '(normPh)';
          2 :tmp := tmp + '(aleTyhPh)';
          3 :tmp := tmp + '(aleInPh)';
          8 :tmp := tmp + '(maxIk3v)';
          9 :tmp := tmp + '(minIk1v)';  end;
       tmp := tmp +COLOR_END;                           //< +2.0.3
     CablePanel.rows[0] := tmp;
       //'Korjaus DEVELOPER1'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

     //tmp := EDV_COLOR_FONT_INPUT + '+Zy=' +
       tmp := EDV_COLOR_FONT_JOHTO_HEADER + '+Zy=' +{+8.0.8}EDV_COLOR_FONT_INPUT +
              RealToStrForceTail(a_getReaa(101004, ReadSrc().yvRs), TRUE, TRUE, 4, kerroin, SMALLEST_RESISTANSSI, ' ') +
              myTextBase.Get(SYMBOLI_OHM) +' + '+COLOR_BLUE +'j</f>' +{+8.0.8}EDV_COLOR_FONT_INPUT +
              RealToStrForceTail(a_getReaa(101005, ReadSrc().yvXs), TRUE, TRUE, 4, kerroin,  SMALLEST_RESISTANSSI, ' ') +
              myTextBase.Get(SYMBOLI_OHM);
     CablePanel.rows[1] := tmp;
     CablePanel.rows[1] := ChkDesimErotin(CablePanel.rows[1]); //<+130.3b  Vasta suoraan CaabelPanel.rows[] -sijoitus korjaa pilkuksi.

       LiitRpX_Phi_Str (rr,xr,0, sa,sn);         //<rr,xr := paljon ylempnä                         //<DEVELOPER1 +4.0.1
     //??tmp := tmp + ',  R1y/X1y=' +sa +'  ' +FONT_FII +'1y=' +sn +'°' +COLOR_END +') ';           //<DEVELOPER1+4.0.1
     //tmp := EDV_COLOR_FONT_INPUT + 'R1y/X1y=' +sa +COLOR_END;                                     //-DEVELOPER1+4.0.1
       tmp := COLOR_BLUE + 'R1y/X1y=</f>' +sa +'  ' +COLOR_BLUE +FONT_FIIe +'1y=' +sn +'°' +COLOR_END; //Korj 8.0.8
     CablePanel.rows[2] := tmp;
     CablePanel.rows[2] := ChkDesimErotin(CablePanel.rows[2]); //<+130.3b  Vasta suoraan CaabelPanel.rows[] -sijoitus korjaa pilkuksi.
     end; //SjPj (DEVELOPER1)
 2,4:begin//<2=PJ-LIITTYMÄ  4=UPS ===============================================================================
     //DrawMuuntaja(SulakeImage, FALSE, psSolid); //< 3.0.2  DEVELOPER1: lisätty  psSolid                 //-6.2.2
       rr := a_getReaa(101083, ReadSrc().pjLiitRs);
       xr := a_getReaa(101093, ReadSrc().pjLiitXs);     //<Aina jo sijoitettu kun tähän tullaan
       kerroin := 0;

       if (rr > xr) then
          RealToStrForceTail(rr, TRUE, TRUE, 4, kerroin, SMALLEST_RESISTANSSI, ' ')
       else
          RealToStrForceTail(xr, TRUE, TRUE, 4, kerroin, SMALLEST_RESISTANSSI, ' ');

       tmp := EDV_COLOR_FONT_JOHTO_HEADER;
       if ReadSrc().SorceKind.arvoInt=4 //< 1=Transformer  2=LV-Cable  3=Generator  4=UPS  +6.2.10
          then tmp := tmp +'UPS-syöttö:'
          else tmp := tmp + myTextBase.Get(EDV_PJ);
     CablePanel.rows[0] := tmp;
       tmp := myTextBase.Get(EDV_HEADERS_LYHYT + '-row-1');
       tmp := tmp + '=' + EDV_COLOR_FONT_INPUT + VirtaToStr(a_getReaa(101092, ReadSrc().Iks1v)* 1000, ' ', False);
       tmp := tmp + myTextBase.Get(SYMBOLI_AMPEERI) + COLOR_END;
       tmp := tmp + ' ';
       tmp := tmp + myTextBase.Get(EDV_HEADERS_LYHYT + '-row-2');
       tmp := tmp + '=' + EDV_COLOR_FONT_INPUT + VirtaToStr(a_getReaa(101092, ReadSrc().Iks3v)* 1000, ' ', False);
       tmp := tmp + myTextBase.Get(SYMBOLI_AMPEERI) + COLOR_END;
     CablePanel.rows[1] := tmp;
      {tmp := tmp + '  =';
       tmp := tmp + myTextBase.Get(EDV_LIITTYMAVERKKO);
       tmp := tmp + ': ' + myTextBase.Get(EDV_LIITTYMAVERKKO_R);
       tmp := tmp + '=' + EDV_COLOR_FONT_INPUT + RealToStrForceTail(a_getReaa(101094, src.pjLiitRs), TRUE, TRUE, 4, kerroin,  SMALLEST_RESISTANSSI, ' ');}
                                                      //,,Ei UPS´ille.###########################################
       if ReadSrc().SorceKind.arvoInt<>4  then begin //< 1=Transformer  2=LV-Cable  3=Generator  4=UPS  +6.2.10
          tmp := EDV_COLOR_FONT_JOHTO_HEADER +'eRs/eXs=';
          tmp := tmp +EDV_COLOR_FONT_INPUT + RealToStrForceTail(a_getReaa(101094, ReadSrc().pjLiitRs), TRUE, TRUE, 4, kerroin,  SMALLEST_RESISTANSSI, ' ');
            while NOT (CharInSet(tmp[Length (tmp)], ['0'..'9']))  do Delete (tmp,Length (tmp),1); //<Poistetaan dimensio
         {tmp := tmp + myTextBase.Get(SYMBOLI_OHM)+ COLOR_END + ' + ';
          tmp := tmp + myTextBase.Get(EDV_LIITTYMAVERKKO_X);}
          tmp := tmp + '/' + EDV_COLOR_FONT_INPUT + RealToStrForceTail(a_getReaa(101094, ReadSrc().pjLiitXs), TRUE, TRUE, 4, kerroin,  SMALLEST_RESISTANSSI, ' ');
          tmp := tmp + myTextBase.Get(SYMBOLI_OHM)+ '=' +COLOR_END;
{3.0.2:        tmp := tmp + myTextBase.Get(EDV_IKS1VCOS);
          tmp := tmp + '=' + EDV_COLOR_FONT_INPUT + KulmaToStr(a_getReaa(101093, src.Iks1vCos), '', False) + COLOR_END;}
          LiitRpX_Phi_Str (rr,xr,0, sa,sn);         //<rr,xr := ylempnä
{DEVELOPER1 +4.0.1>  tmp := tmp + 'eRs/eXs=' +EDV_COLOR_FONT_INPUT +sa +'  ' +FONT_FIIe +'=' +sn +'°' +COLOR_END +') ';}
          tmp := tmp + EDV_COLOR_FONT_INPUT +sa +COLOR_END;
        //tmp := tmp +' '+IntToStr(button.Width)+IntToStr(button.Height); //Koe 806:  w=22 h=22 =OK.
     //ChkDesimErotin(tmp);                                      //<+130.3b  Ei vaikuta, vasta suoraan CaabelPanel.rows[] -sijoitus toimii.
       CablePanel.rows[2] := tmp;
       CablePanel.rows[2] := ChkDesimErotin(CablePanel.rows[2]); //<+130.3b  Vasta suoraan CaabelPanel.rows[] -sijoitus korjaa pilkuksi.
       end;//if rr>0
     end;//2,3: PJ-liit,UPS
  else begin //3: =Generaattori =================================================================================
             // gSn,gXd,gXd1,gXd2,gX2,gX0,gRs, Td1,Td2                                              +8.0.8  §g
       tmp :=      EDV_COLOR_FONT_JOHTO_HEADER +'Gener.: ' +EDV_COLOR_FONT_INPUT +fImrkt0 (ReadSrc().gSn.arvoInt ,1) +' kVA';
      {tmp := tmp +EDV_COLOR_FONT_JOHTO_HEADER +' X2='    +EDV_COLOR_FONT_INPUT +fRmrkt0 (ReadSrc().gX2.arvoRea, 1,4);
       tmp := tmp +EDV_COLOR_FONT_JOHTO_HEADER +' X0='    +EDV_COLOR_FONT_INPUT +fRmrkt0 (ReadSrc().gX0.arvoRea, 1,4);}
                //gtIkMin,gtIkSust,gIkSust,gcIk1vK1vSust :arvoTyyp; //<,,+8.0.8
       tmp := tmp +EDV_COLOR_FONT_JOHTO_HEADER +' tMin=' +EDV_COLOR_FONT_INPUT +fRmrkt0 (ReadSrc().gtIkMin.arvoRea, 1,3);
       tmp := tmp +EDV_COLOR_FONT_JOHTO_HEADER +' tSus=' +EDV_COLOR_FONT_INPUT +fRmrkt0 (ReadSrc().gtIkSust.arvoRea,1,3);
     CablePanel.rows[0] := tmp;

       tmp :=      EDV_COLOR_FONT_JOHTO_HEADER +'X"d='  +EDV_COLOR_FONT_INPUT +fRmrkt0 (ReadSrc().gXd2.arvoRea,1,2);
       tmp := tmp +EDV_COLOR_FONT_JOHTO_HEADER +' X''d=' +EDV_COLOR_FONT_INPUT +fRmrkt0 (ReadSrc().gXd1.arvoRea,1,2);
       tmp := tmp +EDV_COLOR_FONT_JOHTO_HEADER + ' Xd='  +EDV_COLOR_FONT_INPUT +fRmrkt0 (ReadSrc().gXd.arvoRea, 1,2);
     CablePanel.rows[1] := tmp;               //'Ik3 siirretty FormatCable.PAS´siin

       tmp :=      EDV_COLOR_FONT_JOHTO_HEADER +'T"d='   +EDV_COLOR_FONT_INPUT +fRmrkt0 (ReadSrc().gTd2.arvoRea,1,3);
       tmp := tmp +EDV_COLOR_FONT_JOHTO_HEADER +' T''d=' +EDV_COLOR_FONT_INPUT +fRmrkt0 (ReadSrc().gTd1.arvoRea,1,3);
       tmp := tmp +EDV_COLOR_FONT_JOHTO_HEADER +' rr='   +EDV_COLOR_FONT_INPUT +fRmrkt0 (ReadSrc().gRs.arvoRea, 1,5);
       tmp := tmp +COLOR_END;                //'cK1v siirretty FormatCable.PAS´siin
     CablePanel.rows[2] := tmp;
     CablePanel.rows[2] := ChkDesimErotin(CablePanel.rows[2]); //<+130.3b  Vasta suoraan CaabelPanel.rows[] -sijoitus korjaa pilkuksi.
     end;//3: =Gener.
  end;//case
(*'''''''''''''''''' Testiajoon POISTA seur rivin alusta kommenttisulku ''''''''''''''''''''''''''''''''''''''''''''*)
{//Testausta varten,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  CablePanel.rows[0] := '<1>Muuntaja 500 kVA srj 1 (normPh)';
  CablePanel.rows[1] := '<2>Zy=0,098+j1,157m'+FONT_OMEGA;
  CablePanel.rows[2] := '<3>Johto.PAS  Etsi: "<1>" tms.'; //}
Tics ('TJohto.RefreshConnection 9');
end;//RefreshConnection
// DEVELOPER2 2003-11-21 END

///////////////////////////////////////////////////////////////////////////////
function TJohto.SetGridDimensions: boolean;
begin
     result := false;

     isSettingGridDimensions := true;
     LahdotGrid.ForceDimensionEvents;
     SulakeGrid.ForceDimensionEvents;
     isSettingGridDimensions := false;

     // Optiomointia: tarkistetaan muuttuiko mikään ja palautetaan tieto
     if ResizeGrid(lahdotGrid) then
          result := true;

     if ResizeGrid(sulakeGrid) then
          result := true;
end;

///////////////////////////////////////////////////////////////////////////////
procedure  TJohto.DrawToMetaFile(metafile: TMetaFile; OpenClosed: Boolean; bgColor: TColor; pageWidth: integer);
var
   MyCanvas: TMetaFileCanvas;
begin
Tics ('TJohto.DrawToMetaFile 1');
     myCanvas := TMetafileCanvas.Create(metafile, 0);

     if (fopen = True) or (OpenClosed = True) then
     begin
          PrintControl(HeaderPanel, 0, 0, myCanvas, bgColor, true, pageWidth);
          PrintControl(DataPanel, 0, HeaderPanel.height, myCanvas, bgColor, true, PageWidth);
     end
     else
     begin
          PrintControl(HidePanel, 0, 0, myCanvas, bgColor, true, PageWidth);
          PrintControl(HideDataPanel, 0, HidePanel.height, myCanvas, bgColor, true, PageWidth);
     end;

     myCanvas.Destroy;
Tics ('TJohto.DrawToMetaFile 9');
end;

///////////////////////////////////////////////////////////////////////////////
function  TJohto.GetText(johto: integer; kohta: real): string;
begin
     // Result := TJohdot(johdot).GetText(johto, kohta);
end;

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.GridHighestRow(Sender: TObject; ACol, ARow: longint; newHeight: integer);
begin
Tics ('TJohto.GridHighestRow 1-1');
     if (isSettingGridDimensions) then
     begin
          TStringGridNola(sender).RowHeights[ARow] := newHeight;
//          TStringGridNola(sender).height := TStringGridNola(sender).GetMaxHeight;
     end;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.GridWidestCol(Sender: TObject; ACol, ARow: longint; newWidth: integer);
begin
Tics ('TJohto.GridWidestCol 1-1');
     if (isSettingGridDimensions) then
     begin //if ACol<>2 then								 //<Oli lisätty +1202
          TStringGridNola(sender).ColWidths[ACol] := newWidth;
//        TStringGridNola(sender).width := TStringGridNola(sender).GetMaxWidth;
     end;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.HideButtonClick(sender: TObject);
begin
     open := False;
end;

///////////////////////////////////////////////////////////////////////////////
function  TJohto.GetName(): string;      VAR s :string;
begin
  if (johtoType = JOHTO_LIITTYMA) then                  //<,LiittymäjohtoBtn´in NUMERO 01, 02 ..jne.
    // Rinnakkaisliitynnän tunnus on 00, 01, 02 jne
    // result := '0' + IntToStr(arrayIndex - 1)
    //,Rinnakkaisliitynnän tunnus on 01, 02, 03 jne  //<,DEVELOPER1 6.2.2
    s := '0' + IntToStr(arrayIndex)
  else
     // Tavallisten johto-osien nimi on 1,2,3,4 jne
     s := IntToStr(arrayIndex);                                 //<-8.0.0
   //s := IntToStr(arrayIndex - edv.YLE.SorceCount.arvoInt +1); //<+8.0.0
   //if locationIndex<-20  then ;
     result := s;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.OpenButtonClick(sender: TObject);
begin
     open := True;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.DataMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
   tmp: TPoint;  aCol :integer{12.0.0};
begin
     if johdot <> nil then
     begin
        tmp.x := x;
        tmp.y := y;
        tmp := TControl(sender).ClientToScreen(tmp);
        tmp := TJohdot(Johdot).HeaderGrid.ScreenToClient(tmp);
{KoeWInfo ('J        DataMouseMove(xy) x:' +Ints(x) +' y:' +Ints(y) +' LocI:' +Ints(LocationIndex) +' arI:' +Ints(ArrayIndex), 1);
KoeWInfo ('J        " :HeaderGrid(xy)            W:' +Ints(TJohdot(Johdot).HeaderGrid.Width) +
              '  C_Cnt:' +Ints(TJohdot(Johdot).HeaderGrid.ColCount), 1);        //12.0.0    }
        aCol := -1 *(LocationIndex +1);  //<0 muutetaan -1´ksi, muutkin negat, korjataan AVUST-selvittelyssä.
                                         //'Tämä jotta 0 ja 1 jäisivät RiviSelitPanelin (HeaderGrid) 2:lle Col´lle.
      //TJohdot(Johdot).HeaderGridMouseMove(sender, shift, 1, tmp.y); =ALP ennen 12.0.0
        TJohdot(Johdot).HeaderGridMouseMove(sender, shift, aCol, tmp.y); //<'12.0.0
     end;
end;

 (*procedure nay (os, x,y :integer);      var s :string;      begin//åå  PRC Nay ei käytetty missään: 120.5i
      s := 'os: ' +fImrkt0 (os,1) +' x' +fImrkt0 (x,1) +' y' +fImrkt0 (y,1);
      EdvNewFrm.Caption := s;  end;//*)
///////////////////////////////////////////////////////////////////////////////  //,,Yläosan kuvaajarivien avustRvt 2-4
   procedure NayXY (os :string;  x,y :integer);      begin                                    //<+120.5
      //if IsDebuggerPresent  then EdvNewFrm.Caption := {EdvNewFrm.Caption +}'Johto: (' +os +')x:' +Ints(x) + ' y:' +Ints(y); //<+Capt+Capt +120.5i
   end;
procedure TJohto.MouseMoveRow1(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
//KoeWInfo('EdvRw1 x' +Ints (x) +' y' +Ints(y),1);
//beep;// ([1000,500]); //=500Hz 500ms + 200Hz 500ms + 500Hz 500ms ... rajattomasti.
   NayXY('JMMv1',x,y);                  //<Sievennetty NayXY´ksi 120.5
   if johdot <> nil then
      TJohdot(Johdot).MouseMove(2,1);   //nay (1,x,y); //<Hyvä kokeilussa +2.0.5
end;                                    //'+12.0.0: 2=Col =Vai olisko 1 paree (=Paneli)).

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.MouseMoveRow2(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
//KoeWInfo('EdvRw2 x' +Ints (x) +' y' +Ints(y),1);
//wbeep ([500,100]); //=500Hz 500ms + 200Hz 500ms + 500Hz 500ms ... rajattomasti.
   NayXY('JMMv2',x,y);                  //<Sievennetty NayXY´ksi 120.5
     if johdot <> nil then
        TJohdot(Johdot).MouseMove(2,2); //nay (2,x,y); //<Hyvä kokeilussa +2.0.5
end;                                      //'+12.0.0: 2=Col =Vai olisko 1 paree (=Paneli)).

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.MouseMoveRow4(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin   //TÄNNE VAIN Button(JohtoBtn =PITÄÄ OLLA NORM.J-OSIA), ButtonHide,JakoKeskusImage ja HeaderImage -MouseMovella.
        //'############################################################################################################
        //'############################################################################################################
//KoeWInfo('EdvRw4 x' +Ints (x) +' y' +Ints(y),1);
//wbeep ([3000,500]); //=500Hz 500ms + 200Hz 500ms + 500Hz 500ms ... rajattomasti.
   NayXY('JMMv4',x,y);                  //<Sievennetty NayXY´ksi 120.5
     if johdot <> nil then
       {if X>21  then TJohdot(Johdot).MouseMove(4)  //< -2.0.3, korj 2.0.5  DEVELOPER1
                else }TJohdot(Johdot).MouseMove(2,{1}4); //< +2.0.3, korj 2.0.5  DEVELOPER1
        //nay (4,x,y); //<Hyvä kokeilussa +2.0.5         //'+12.0.0: 2=Col =Vai olisko 1 paree (=Paneli)).
end;

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.PohjaClick(Sender: TObject);
begin
     if johdot <> nil then
        TJohdot(Johdot).PohjaClick(sender);
end;

///////////////////////////////////////////////////////////////////////////////
procedure TJohto.PohjaDblClick(Sender: TObject);
begin
     if johdot <> nil then
        TJohdot(Johdot).PohjaDblClick(sender);
end;

end.
