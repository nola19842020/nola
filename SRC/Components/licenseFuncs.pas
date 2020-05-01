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

///////////////////////////////////////////////////////////////////////////////
//
// FileName:  LicenseFuncs.pas
// Location:  src\Globals
// Abstract:  Rutiineja linsessin k�sittely� varten.
//
///////////////////////////////////////////////////////////////////////////////
//
// Following fields are automatically generated by the version control system:
//
// $Revision: 1.4 $
//     $Date: 2005/10/09 14:01:50 $
//
///////////////////////////////////////////////////////////////////////////////
//
// Change Log. Old log entries can be removed by deleting them.
// $Log: licenseFuncs.pas,v $
// Revision 1.4  2005/10/09 14:01:50  DEVELOPER2
// Reijolta 26.9.2005
//
//
// 10    22.09.04 20:06 DEVELOPER2
// Bug fix: Invalid Input value -viesti n�ytettiin avattaessa
// AsetusFrm-lomaketta.
// Ongelma johtui v��rin muotoilun p�iv�m��r�n sijoittamisesta
// MaskEdit-komponenttiin.
// - StrToDateTimeDef: lis�tty ylim��r�isten v�lily�ntien poistaminen
// p�iv�m��r�st�.
//
// 9     5.09.04 10:39 DEVELOPER2
// Buf fix. Korjattu NolaRekin Stack Overflow, joka johtui p�iv�yksen
// muuttamisesta merkkijonoksi eri tavoin eri paikoissa. Tuli ilmi kun NolaReki�
// k�ytettiin kuukauden alussa kun p�iv�ys oli < 10. Osassa koodista p�iv�ys
// muutettiin muotoon '1.9.2004' ja toisaalla '01.9.2004'. Nyt k�ytet��n
// j�lkimm�ist� muotoa kaikkialla.
// - lis�tty NolaDateToStr()-funktio: M��rittelee kuinka p�iv�m��r� muutetaan
// merkkijonoksi.
// - Korvattu FormatDateTime()-kutsut NolaDateToStr()-kutsuiksi
// - Muutettu StrToDateTimeDef()-funktioita siten, ett� se tunnistaa tyhj�n
// p�iv�m��r�n eik� turhaa exceptionia generoida
//
// 8     9.04.04 10:20 DEVELOPER2
// Bug fix. NolaRek ei anna oikeaa varmistetta, jos asiakkaan antamaa
// lisenssikoodia ei muuteta NolaRek ohjelmassa. Ongelma johtui siit�, ettei
// GetKoodiRec()-funktiossa lopetuspvmTDT ja lopetusSTR muuttujia alustettu
// tyhjiksi.
//
// 7     28.03.04 14:37 DEVELOPER2
// LicensePanelNola
// - StrToDateTimeDef muutettu k�ytt�m��n StrToDate funktioita, jotta
// m��r�aikainen lisenssi toimisi
// - P�iv�yksen formaatti muutettu k�ytt�j�rjestelm�ss� asetettuun muotoon
//
// 6     20.03.04 10:22 DEVELOPER2
// Kommentointia tarkennettu
//

unit licenseFuncs;

{
=================================================================================================================
- DEVELOPER1 kes�aikaan siirtymisen (29.3.99 klo 03.00 -> 04.00) j�lkeisen ajoyrityksen virheilmoituksen
  e8.211 korjaukset: ETSI 'DEVELOPER1Kes�'
  Muutettu:   LicenseFuncs.PAS / FNC IsEqualSystemTime                              rivi: 1703 ks.1721+1722
              License.PAS      / FNC TLicenseManager.GetKoneenTunnisteKesa (0->+1)         919
                               / FNC TLicenseManager.GetKoneenTunnisteTalvi(1->-1)         925
                               / FNC TLicenseManager.GetKoneenTunnisteKesa98               933 ks.972
================================================================================================================}
interface


uses
    classes, SysUtils, windows, settings;

type
  LicenseType       = (ltJatkuva, ltMaara);
  LicenseStatus     = (lsTyhja, lsViallinen, lsVanhentunut, lsPaikallinen, lsEta,
                       lsPaivaysMuutettuMinor, lsPaivaysMuutettuMajor, lsVersioVirhe,
                       lsHakemistoLukuVirhe, lsHakemistoAikaVirhe, lsPaivitysVirhe,
                       lsEiPaivitetty, lsOdottaa, lsPaivitysTulevaisuudessa,
                       lsLupaMenetetty, lsLupaPaivitysTulevaisuudessa,
                       lsVanhentunutLupaPaivitys, lsLupaPaivitysVirhe,
                       lsVerkkoHakemistoVirhe);
  LicenseCodeStatus = (lcOk, lcVersionError, lcLengthError, lcCrcError,
                       lcCodingError, lcTypeError, lcDateError);
  LicenseScope      = (lvLT, lvPro, lvExtended, lvGlobal);

  // Katso lisenssi versio 1.0
  TLicenseKoodi_10 = record
              status:         LicenseCodeStatus;
              versio:         integer;
              avain:          integer;
              tyyppi:         integer;
              paivitys:       Boolean;
              verkko:         Boolean;
              lukumaara:      integer;

              // Varattu tulevaa k�ytt��varten
              vapaa:          integer;

              laajuus:        LicenseScope;

              // lopetuspvm
              lopetuspvmTDT:  TDateTime;
              lopetuspvmStr:  string;
              paiva:          integer;
              kuukausi:       integer;
              vuosi:          integer;     // Todellinen vuosi esim 1997

              crc:            integer;
  end;

implementation

end.
