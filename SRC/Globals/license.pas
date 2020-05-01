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

{/////////////////////////////////////////////////////////////////////////////////////////////////////////// DEVELOPER1:
Etsi: Lukee lisenssin =Luetaan C:\Wind.. tai C:\VARO..:sta.
########################### UUSIMMAT ja TƒRKEIMMƒT MUUTOKSET:  ks. PRC TeeDir_WarnF_CopyNosF ##########################
11.0.0
  TEEMA:  J‰rjestelm‰hakemistoon (haetaan FNC:lla GetWindowsDir :string) EI ENƒƒ KIRJOITETA MITƒƒN. Suositus oli
    jo XP:n tullessa jakeluun (siit‰ mahtoi muutamat lisenssikiusat aiheutua). VISTA ja Windows Server 2008 (il-
    meisesti myˆs tuleva Windows 7) EI ENƒƒ HYVƒKSY; ne ohjaavat kirjoituksen muualle(?).
    Kaikki KIRJOITTAMINEN tapahtuu C:\VARO_NOLA_LUE_WARNING\.. -hakemistoon ja sen alle, paitsi jos fWnd=TR, se
    ohjaa keinotekoisesti kirjoituksen vanhaan tyyliin WINDOWS-hakemistoon. Normaalisti asetus oltava fWnd=FA.
  HUOM: Sorcassa PaikallinenLisenssi =Yksitt‰islisenssi =EiVerkkoLisenssi.########################################
  Nyt t‰m‰ versio k‰ynnistytty‰‰n:
    -- Lukee WINDOWS\Nola\License\license.nos -tiedostosta lisenssitiedot, tekee C:\VARO_NOLA_LUE_WARNING\ -dirrin.
       ja kopioi C:\WINDOWS\..\license.nos => C:\VARO_NOLA_LUE_WARNING\License\license.nos ja tekee WARNING!.txt
  ###### TƒRKEƒƒ: - Kopioinnin j‰lkeen kirjoitetaan NOSfileen uusi lisenssidirrin luontiaika TEEPUTHAKEMISTOAIKAKOODI.
  ######          - License -dirrin LUONTIAJAKSI muutetaan sama DateTime kuin Win..\License¥n DateTime.
  ###### ENNESTƒƒN JO VALIDATE..PRC:ss‰ kirjoitetaan kahteen kertaan KONEEN TUNNISTE SINNE: PutLisenssiTunnus.####
       Kaikki n‰m‰ PRC TeeDir_WarnF_CopyNosF :ssa.
    -- P‰‰osa paramOhjailusta tapahtuu ValidateLicense¥ssa, jota kutsutaan kaksi kertaa (oli jo alp sorcassa):
         LicenseManager¥i‰ luotaessa (constructor TLicenseManager.Create) ja sen viimeisell‰ rvll‰.
  KULKU:  (yksitt‰islisenssill‰, p‰tee p‰‰piirteiss‰‰n myˆs vrklis:iin)
  - TeeDir_WarnF_CopyNosF              <<< TƒRKEƒ TƒRKEƒ TƒRKEƒ TƒRKEƒ TƒRKEƒ TƒRKEƒ TƒRKEƒ TƒRKEƒ TƒRKEƒ TƒRKEƒ TƒRKEƒ
    -- SiirttyUuteen_DirN := uDn;          ############################################################################
    (vasta nyt NOSf uudessa DIR:ss‰)       ############################################################################
  - ValidateLicense                    <<< TƒRKEIN:  TƒMƒN ALKUUN BreakPoint.   TƒRKEIN TƒRKEIN TƒRKEIN TƒRKEIN TƒRKEIN
  - OkDirLuontiAika                        ############################################################################
  - IsEqualSystemTime_Q                    ############################################################################
  - PutLisenssiTunnus ()
    (vasta nyt NOSf pvitetty)

  - Kaikista kohdista, miss‰ on paikallinenLisenssiHakemisto:on liittyvi‰ muutoksia, lˆytyy myˆs kommentti Lß .
  - Lßv   =Kommentti, kun GetWindowsDir korvattu GetValvooDir tai siihen liittyv‰ muu muutos. <'mrkint‰ EI EHKƒ AJANTASALLA.
  Aseta Breakpointit:
      License.PAS:
      rv 853:  if (varm = FLisenssiVarmisteRec.varmiste) then
      953:     if  NOT IsEqualSystemTime(created, GetHakemistoAika(hakemisto))  and paikallinenLisenssi  then
               // Selvitet‰‰n paikallisen lisenssihakemiston luontiaika, TR jos Handle OK.          ,+fWnd,+OR +11.0.0
      938:     if fWnd  and  NOT GetDirCreationTime (GetWindowsDir +'\' +ÂLICENSE_PAADIR+ '\' +
      1198:   begin//TeeDir_WarnF_CopyNosF...................

#################################################################################################################}
///////////////////////////////////////////////////////////////////////////////
//
// FileName:  License.pas
// Location:  src\Globals
// Abstract:  Lisenssin verifiointi.
//
///////////////////////////////////////////////////////////////////////////////
//
// Following fields are automatically generated by the version control system:
//
// $Revision: 1.5 $
//     $Date: 2005/10/15 09:01:36 $
//
///////////////////////////////////////////////////////////////////////////////
//
// Change Log. Old log entries can be removed by deleting them.
// $Log: license.pas,v $
// Revision 1.5  2005/10/15 09:01:36  DEVELOPER2
// Optimointia: lisenssi‰ ei aina tarkistetaan kun ReadOk-fuktioita kutsutaan. Lisenssi validoidaan vain  tarvittaessa.
//
// Revision 1.4  2005/10/09 14:01:50  DEVELOPER2
// Reijolta 26.9.2005
//
// 
// 15    5.09.04 10:33 DEVELOPER2
// Bug fix. FormatDateTime()-kutsut muutettu NolaDateStr() kutsuiksi, jotta
// p‰iv‰m‰‰r‰ muutettaisiin merkkijonoksi aina samalla tavoin kaikkialla
// lisenssin k‰sittelyss‰.
// 
// 14    28.03.04 14:35 DEVELOPER2
// LicensePanelNola
// - poistetaan verkkolisenssitiedosto, kun lisenssi asennetaan, jottei vanhaa
// verkkolisenssi‰ virheellisesti luettaisi
// 
// 13    20.03.04 10:16 DEVELOPER2
// Lisenssin laajuus toimintaa muokattu 
// - LicenseVersion -> LicenseScope
// - vapaa kent‰n k‰yttˆ muutettu tukemaan tulevia muutoksia.
//
// 12    14.03.04 17:01 DEVELOPER2
// Lis‰tty lisenssi laajuus Pro, Extended ja Global k‰yttˆ‰ varten.
// 
// 11    14.03.04 16:37 DEVELOPER2
// Bug fix. .NOS tiedosto luotiin virheellisesti ja liian monta Nola-ohjelmaa
// sallittiin.
//
// 10    14.03.04 16:04 DEVELOPER2
// Nime‰minen muutettu lisenssi.rtf mukaiseksi.
//
// 9     7.03.04 13:05 DEVELOPER2
// Funktioiden nimet korjattu oikeiksi.
// 
// 8     7.03.04 12:49 DEVELOPER2
// Korjattu verkkolisenssin toimimattomuus, kun ohjelman uusi versio asennetaan:
// - FCurrTunnus: j‰senmuuttuja poistettu
// - WriteLisenssiStr(): uudelleen nimetty SetInstalledLisenssiStr()-nimiseksi
// - WriteVarmisteStr(): uudelleen nimetty SetInstalledVarmisteStr()-nimiseksi
// - ReadLisenssiStr(): uudelleen nimetty GetInstalledLisenssiStr()-nimiseksi
// - ReadTunnusStr(): uudelleen nimetty GetNewTunnusStr()-nimiseksi
// - GetInstalledTunnusStr(): uusi funktio asennetun lisenssin tunnuksen
// lukemiseksi
// - tunnusStr: property poistettu ja korvattu funktioilla
// - lisenssiStr: property poistettu ja korvattu funktioilla
// - varmisteStr: property poistettu ja korvattu funktioilla
// - GetInstalledLisenssiStr(): merkkijono haetaan j‰senmuuttujasta laskemisen
// sijaan
// - GetInstalledVarmisteStr(): merkkijono haetaan j‰senmuuttujasta laskemisen
// sijaan
// - GetInstalledTunnusStr(): merkkijono haetaan j‰senmuuttujasta laskemisen
// sijaan
// - ValidateLicense(): 
// * tunnuskoodi haetaan aina tiedostosta j‰senmuuttujan sijaan
// * tunnuskoodimerkkijono koodataan uudestaan oikealla koneentunnisteella
// * ohjelmaversio tarkistetaan lisenssiversion sijaan, jos lisenssi ei sis‰ll‰
// p‰ivitysoikeutta
// 
// 7     25.02.04 20:24 DEVELOPER2
// Reijolta 24.2.2004
// 
// 6     5.01.04 19:26 DEVELOPER2
// LicenseCodeStatusToStr() funktio palautettu NolaReki‰ varten
// 
// 5     26.10.03 21:07 DEVELOPER2
// - Log file
// - Kaikki joita ei tarvita muissa moduuleissa siirretty privaateiksi
// - Bugi korjaus: NolaNet loi turhaan .nop tiedoston, jolloin yksi lisenssi
// hukkui
// - NolaNet erikoistoiminnallisuus siirretty NetLicenseManageriin
// 
// 4     5.10.03 19:15 DEVELOPER2
// LICENSE_DEFAULT_PATH otettu k‰yttˆˆn
// 
// 3     5.10.03 16:59 DEVELOPER2
// Verkkolisenssin hakemisto k‰ytt‰j‰n m‰‰ritelt‰viss‰
//

{DEVELOPER1 2.0.3:  T‰ss‰ sorcassa on tehty yleisen‰ muutoksena KAIKKI XxxXxx    := arvo -tyyppiset sijoitukset,
              jotka on MUUTETTU YHDELLE VƒLILY÷NNILLE tyyliin:   XxxXxx :=    arvo, jotta on mahista etsi‰
              ao. sijoituskohdat k‰skyll‰:                 Etsi "XxxXxx :=".
 Muut muutokset, etsi "DEVELOPER1"}

{ versio 1.1 DEVELOPER2 28.10.1998
            - Kes‰ll‰ 98 annetut lisenssit eiv‰t toimineet en‰‰ kes‰ajan p‰‰tytty‰
              koska Windowsin FileTimeToSystemTime-functio muuttaa tiedoston luontiaikaa riippuen
              onko kyseess‰ talvi- vai kes‰aika.
              T‰st‰ syntyi kaksi ongelmaa:
                    Ongelma 1: tiedoston aika oli eri lisenssi-tiedostossa verrattuna lennossa laskettuun.
                    Ratkaisu : hakemiston luontiajasta verrataan vain minuutteja, sekunteja ja millisekunteja.
                    Ongelma 2: koneentunniste lasketaan v‰‰rin, jolloin varmiste ei ole oikea
                    Ratkaisu : lasketaan kolme varmistetta: uusi jossa ei huomoida kuin minuutit,
                               sekunnit ja millisekunnit sek‰ kaksi vanhan muotoista joissa on huomioitu
                               tunnin poikkeama
            - Lis‰tty GetKoneenTunnisteKesa, joka palauttaa kes‰ll‰ 98 annetun varmisteen joka toimii kes‰ll‰
            - Lis‰tty GetKoneenTunnisteTalvi, joka palauttaa kes‰ll‰ 98 annetun varmisteen joka toimii talvella
            - muutokset merkitty //KESƒ98

     versio 1.2 DEVELOPER2 24.11.1998
            - CreateTunnusRec-funktiossa muutettu p‰iv‰m‰‰r‰n luomista.
              Voi vaikuttaa 'Asiakkaan p‰iv‰m‰‰r‰ v‰‰r‰'-ilmoitukseen.
            - Lis‰tty p‰iv‰m‰‰r‰n tarkistus, joka tuottaa dialogin virhetilanteessa
=================================================================================================================
- DEVELOPER1n kes‰aikaan siirtymisen (29.3.99 klo 03.00 -> 04.00) j‰lkeisen ajoyrityksen virheilmoituksen
  e8.211 korjaukset: ETSI 'DEVELOPER1Kes‰'
  Muutettu:   LicenseFuncs.PAS / FNC IsEqualSystemTime                              rivi: 1700
              License.PAS      / FNC TLicenseManager.GetKoneenTunnisteKesa (0->+1)         919
                               / FNC TLicenseManager.GetKoneenTunnisteTalvi(1->-1)         925
                               / FNC TLicenseManager.GetKoneenTunnisteKesa98               933 ks. 972
================================================================================================================}
unit license;

interface

uses  {graphics, inifiles, SysUtils,} classes, Windows,{ Messages, Controls, Forms, Dialogs,
  StdCtrls,} ExtCtrls,{ LabelNola, mask,comctrls, db} licenseFuncs,{ FileCtrl,}
  nolaCount, Koe{12.0.0}, System.UITypes;

type
  TLicenseManager = Class
  private
    { Private declarations }

    function  ReadOk: Boolean;
    function  ReadPaikallinenLisenssi: Boolean;
    function  ReadOikeusOk: boolean;
    function  ReadStatusText: string;
    function  ReadInfoText: string;
    function  ReadLisenssiNum: string;
    function  ReadLisenssiNumero: integer;
    function  ReadLisenssiLaajuus: LicenseScope;
    function  ReadLisenssiKoodiRec: TLicenseKoodi_10;

    function  InitKoodiRec:  TLicenseKoodi_10;
    function  LicenseStatusToStr(status: LicenseStatus): string;
  public
    { Public declarations }

    constructor Create;
    destructor Destroy; override;

    // Tarkistaa onko koneeseen asennettu koskaan lisenssi‰
    // return:   true, jos koneeseen on asennettu lisenssi
    function IsLicenseInstalled(): boolean;

    // Tarkistaa lisenssin oikeellisuuden
    procedure ValidateLicense;

    // Asettaa lisenssin siirretyksi
    procedure SetMoved;

    // Poistaa lisenssin koneesta
    function  RemoveLicense: BOOLEAN;

    // palauttaa VerkkoLisenssiHakemisto
    function  GetVerkkoLisenssiHakemisto: string;

    // Asettaa uuden VerkkoLisenssiHakemisto. Jos hakemisto on sama kuin aikaisemmin
    // mit‰‰n ei tehd‰
    function  SetVerkkoLisenssiHakemisto(const directory: string; bShowMsg: boolean): boolean;

    // Jos lisenssi on kunnossa arvo true
    property ok:          Boolean     read ReadOk;

    // Jos lisenssi on paikallinen arvo on true.  DEVELOPER1: PaikallinenLisenssi =Yksitt‰isLisenssi =EiVerkkolisenssi.
    property paikallinenLisenssi: Boolean     read ReadPaikallinenLisenssi;

    // Jos windows\Nola hakemistoon voidaan kirjoittaa, arvo on true
    property OikeusOk:    Boolean     read ReadOikeusOk;

    // Palauttaa lisenssitunnuksen, jota k‰ytet‰‰n kun luodaan uusi lisenssi
    // koneeseen. T‰ss‰ PROGRAM_VERSION_LICENSE on sama kuin ohjelmaa k‰‰nnett‰ess‰
    function GetNewLisenssiTunnusStr:   String;

    // Palauttaa lisenssitunnuksen, jota k‰ytet‰‰n k‰sitelless‰ asennettua lisenssi‰
    // T‰ss‰ PROGRAM_VERSION_LICENSE on sama kuin lisenssi‰ asennettaessa
    function GetInstalledLisenssiTunnusStr:   String;

    // Asettaa lisenssi‰ kuvaavan merkkijonon lisenssist‰, joka on asennettu
    procedure SetInstalledLisenssiKoodiStr(value: String);

    // Palauttaa kooditunnuksen, jota k‰ytet‰‰n k‰sitelless‰ asennettua lisenssi‰
    // T‰ss‰ PROGRAM_VERSION_LICENSE on sama kuin lisenssi‰ asennettaessa
    function  GetInstalledLisenssiKoodiStr: String;

    // Asettaa varmistetta kuvaavan merkkijonon lisenssist‰, joka on asennettu
    procedure SetInstalledLisenssiVarmisteStr(value: String);

    // Palauttaa varmistetunnuksen, jota k‰ytet‰‰n k‰sitelless‰ asennettua lisenssi‰
    // T‰ss‰ PROGRAM_VERSION_LICENSE on sama kuin lisenssi‰ asennettaessa
    function  GetInstalledLisenssiVarmisteStr: String;

    // Palauttaa lisenssikoodin
    property lisenssiKoodiRec: TLicenseKoodi_10 read ReadLisenssiKoodiRec;

    // Hakee lisenssin status tekstin, joka perustuu fStatus muuttujaan.
    property StatusText: string read ReadStatusText;

    // Palauttaa pitemm‰n info tekstin asetus ikkunaan
    property infoText:   string read ReadInfoText;

    // Palauttaa lisenssin numeron merkkijonona
    property lisenssiNum:   string read ReadLisenssiNum;

    // Palauttaa lisenssin numeron
    property lisenssiNumero: integer read ReadLisenssiNumero;

    // Palautta lisenssin laajuuden
    property lisenssiLaajuus: LicenseScope read ReadLisenssiLaajuus;
  end;

  { Palauttaa lisenssin koodistatuksen merkkijonona. }
  function LicenseCodeStatusToStr(status: LicenseCodeStatus): string;

implementation

uses
   globals, defs, math, settings, textbase, textbasetexts, Y_{fBrkt0,?KaikkiOikeudet_1x}, log, InfoDlgUnit,
    inifiles, SysUtils, Dialogs{, FileCtrl};

constructor TLicenseManager.Create;
begin
     inherited Create;
end;

destructor TLicenseManager.Destroy;
begin
     inherited Destroy;
end;

function  TLicenseManager.ReadOk: Boolean;
begin
     result := True;
end;

procedure TLicenseManager.SetMoved;
begin
end;

function  TLicenseManager.ReadPaikallinenLisenssi: boolean;
begin
  result := True;
end;

function  TLicenseManager.ReadOikeusOk: boolean;
begin
  result := True;
end;

function  TLicenseManager.ReadStatusText: string;
begin
     result := LicenseStatusToStr(lsPaikallinen);
end;

function  TLicenseManager.ReadLisenssiNum: string;
begin
     result := Format('%5.5d', [ReadLisenssiNumero])
end;

function  TLicenseManager.ReadLisenssiNumero: integer;
begin
     result := 99999;
end;

function  TLicenseManager.ReadLisenssiLaajuus: LicenseScope;
begin
     result := lisenssiKoodiRec.laajuus;
end;

function  TLicenseManager.ReadLisenssiKoodiRec: TLicenseKoodi_10;
begin
     result := InitKoodiRec();
end;

function  TLicenseManager.ReadInfoText: string;
begin
  result := myTextBase.Get(LICENSE_INFO_9);
end;

procedure TLicenseManager.SetInstalledLisenssiKoodiStr(value: String);
begin
end;

procedure TLicenseManager.SetInstalledLisenssiVarmisteStr(value: String);
begin
end;

function  TLicenseManager.GetInstalledLisenssiKoodiStr: String;
begin
     result := ''
end;

function  TLicenseManager.GetInstalledLisenssiVarmisteStr: String;
begin
     result := '';
end;

function  TLicenseManager.GetNewLisenssiTunnusStr: String;
begin
     result := '';
end;

function  TLicenseManager.GetInstalledLisenssiTunnusStr: string;
begin
     result := '';
end;

procedure TLicenseManager.ValidateLicense; //1102 ue¥ssa muotoiluja +apumuuttujia.
begin
end;

function  TLicenseManager.InitKoodiRec:  TLicenseKoodi_10;
var
   code: TLicenseKoodi_10;
begin
     code.verkko :=    False;
     code.paivitys :=  True;
     code.lukumaara := 1;
     code.vapaa :=     0;
     code.laajuus :=   lvGlobal;

     code.lopetuspvmStr := '';
     code.lopetuspvmTDT :=  0;

     result := code
end;
function TLicenseManager.RemoveLicense: BOOLEAN;
begin
    result := true;
end;

function  TLicenseManager.GetVerkkoLisenssiHakemisto: string;
begin
  result := '';
end;

function TLicenseManager.SetVerkkoLisenssiHakemisto(const directory: string; bShowMsg: boolean): boolean;
begin
  result := true;
end;

function TLicenseManager.IsLicenseInstalled(): boolean;
begin
  result := true
end;

function LicenseCodeStatusToStr(status: LicenseCodeStatus): string;
begin
     case status of
          lcOk:            result :=  myTextBase.Get(LICENSE_CODEERROR_1);     // 'Koodi on kunnossa'),
          lcVersionError:  result :=  myTextBase.Get(LICENSE_CODEERROR_2);     // 'Virheellinen. Versio on v‰‰rin.'),
          lcLengthError:   result :=  myTextBase.Get(LICENSE_CODEERROR_3);     // 'Virheellinen. Pituus on v‰‰rin.'),
          lcCrcError:      result :=  myTextBase.Get(LICENSE_CODEERROR_4);     // 'Virheellinen. Tarkiste on v‰‰rin.'),
          lcCodingError:   result :=  myTextBase.Get(LICENSE_CODEERROR_5);     // 'Virheellinen. Koodaus on v‰‰rin.'),
          lcTypeError:     result :=  myTextBase.Get(LICENSE_CODEERROR_6);     // 'Virheellinen. V‰‰r‰n tyyppinen koodi.'),
          lcDateError:     result :=  myTextBase.Get(LICENSE_CODEERROR_7);     // 'Virheellinen. P‰iv‰ys on virheellinen.'),
     end;
end;

function  TLicenseManager.LicenseStatusToStr(status: LicenseStatus): string; //12.0.0: Siirretty t‰nne loppuun.
begin
     case status of                                                                                     //,,TextBaseText¥ist‰:,,,,,,,,,,,,,, +11.0.0
     lsTyhja:                       result := myTextBase.Get(LICENSE_STATUS_1) +' (e1).'; //_1, 'Ei lisenssi‰. Esittelyversio.'),
     lsVanhentunut:                 result := myTextBase.Get(LICENSE_STATUS_2) +' (e2).'; //_2, 'Lisenssi on vanhentunut'),
     lsEta:                         result := myTextBase.Get(LICENSE_STATUS_3);                         //_3, 'Kunnossa.'),
     lsPaikallinen:                 result := myTextBase.Get(LICENSE_STATUS_4);                         //_4, 'Kunnossa.'),
     lsViallinen:                   result := myTextBase.Get(LICENSE_STATUS_5) +' (e3)';  //_5, 'Viallinen lisenssi'),
     lsPaivaysMuutettuMinor:        result := myTextBase.Get(LICENSE_STATUS_6) +' (e4)';  //_6, 'Aikavirhe'),
     lsPaivaysMuutettuMajor:        result := myTextBase.Get(LICENSE_STATUS_7) +' (e5)';  //_7, 'Aikavirhe'),
     lsVersioVirhe:                 result := myTextBase.Get(LICENSE_STATUS_8) +' (e6)';  //_8, 'Lisenssi ei k‰y t‰h‰n versioon'),
     lsHakemistoLukuVirhe:          result := myTextBase.Get(LICENSE_STATUS_9) +' (e7)';  //_9, 'Hakemiston lukuvirhe'),
     lsHakemistoAikaVirhe:          result := myTextBase.Get(LICENSE_STATUS_10)+' (e8)';  //_10,'Viallinen lisenssi'),
     lsEiPaivitetty:                result := myTextBase.Get(LICENSE_STATUS_11)+' (e9)';  //_11,'NolaNet-ohjelma ei ole p‰ivitt‰nyt lisenssi‰.'),
     lsPaivitysVirhe:               result := myTextBase.Get(LICENSE_STATUS_12)+' (e10)'; //_12,'P‰ivitysvirhe.'),
     lsOdottaa:                     result := myTextBase.Get(LICENSE_STATUS_16)+' (e14)'; //_16,'Odottaa lisenssin p‰ivityst‰...'),
     lsPaivitysTulevaisuudessa:     result := myTextBase.Get(LICENSE_STATUS_17)+' (e15)'; //_17,'P‰ivitysvirhe.'),
     lsLupaMenetetty:               result := myTextBase.Get(LICENSE_STATUS_18)+' (e16)'; //_18,'P‰ivitysvirhe.'),
     lsLupaPaivitysTulevaisuudessa: result := myTextBase.Get(LICENSE_STATUS_19)+' (e17)'; //_19,'P‰ivitysvirhe.'),
     lsVanhentunutLupaPaivitys:     result := myTextBase.Get(LICENSE_STATUS_20)+' (e18)'; //_20,'P‰ivitysvirhe.'),
     lsLupaPaivitysVirhe:           result := myTextBase.Get(LICENSE_STATUS_21)+' (e19)'; //_21,'P‰ivitysvirhe.'),
     lsVerkkoHakemistoVirhe:        result := myTextBase.Get(LICENSE_STATUS_24)+' (e20)'; //_24,'Verkkohakemiston k‰sittelyvirhe.'),
     end;                                                                                               //_22,'Lisenssi ei ole asennettu t‰h‰n koneeseen.'),
end;                                                                                                    //_23,'Koneessa voi olla k‰ynniss‰ vain yksi NolaNet-ohjelma.'),
                                                                                                        //_25,'Verkkolisenssin hakemistoa ei ole olemassa'),
end.                                                                                                    //_26,'Verkkolisenssin hakemistoon ei ole kirjoitusoikeutta.'),
                                                                                                        //_13,'Lisenssi ei ole verkkolisenssi.' ),
                                                                                                        //_14,'Verkkohakemistossa tulee olla kirjoitusoikeudet. Hakemisto = '),
                                                                                                        //_15,'Verkkohakemistossa tulee olla kirjoitusoikeudet. Hakemisto = '),

