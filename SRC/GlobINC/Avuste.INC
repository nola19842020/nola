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

//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//,,Avu_0_Versiot/Avuste.INC,, Tämä on Incluudattu TextBaseText.PAS´issa.§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§

//#####################################################################################################################
//#####################################################################################################################
//#####################################################################################################################
//,,########## Jos tähän muutoksia, TextBase.NOL tuhottava jotta UUSI SYNTYISI JA TEHDYT MUUTOKSET NÄKYISIVÄT.#########
//############ Nyt Globals.PAS´ssa TextBaseFileN delataan ja poisto tsekataan ja huomautetetaan josEIok.###############
//#####################################################################################################################
//#####################################################################################################################
(BASE_Avu_0_Versiot1,
       CLR_BLB +'<u>MUUTOSHISTORIA</u>' {+FNT_B0 }+'</b> (ylinnä viimeisin versionumero ja muutosselitykset):'+
       //CLR_BLU +'<b>Ennakkotietoa mahd. tulevista muutoksista:</b></f>'  +CLR_BLU +
        {SisX_+'UPS-syötön laskentaa varten on liittymätietona pitänyt kuvata edeltävä verkon osa erillisessä ' +    //?????????????????????????????
           'arvosyöttöikkunassa, mikäli N- ja PE-kiskojen yhdistäminen sijaitsee aikaisemmin verkossa. ' +
           '<b>Seuraavassa muutoksessa 12.0.6 => 14.1.2 UPS-laite voidaan sijoittaa</b> jokaiseen verkkokuvaajan keskukseen '+
           'yksintertaisella valinnalla.'+}
        {SisX_+'NOLAn verkkoversion NolaNet.EXE´n ajomahdollisuus Service -sovelluksena, jolloin sen käynnistä'+
           'minen voidaan automatisoida, eikä se vaadi laajoja hallintaoikeuksia.'+
         SisX_+'Selvitämme mahdollisuutta, voitaisiinko IEC/OFAA-sulake- ja/tai poiskytkentäaikavalinnat ' +
           'ottaa johto-osakohtaiseksi valinnaksi.'+}

'</f>'+
'<br><br><b>15.0.0    01.05.2020</b>' +
         SisX_+'Lisenssi on muutettu avoimeksi BSD-lisenssiksi (ks. license.txt)'+
         SisX_+'Käyttörajoitukset on poistettu ja toimintalaajuus on pakotettu laajimmaksi (GLOB).'+
         SisX_+'Ohjelmaa voi käyttää ja kehittää lisenssin mukaisesti, mutta alkuperäiset kehittäjät eivät enää tarjoa tukea.'+

'<br><br><b>14.1.6    3.12.2017</b>' +     {1416 (=1415f merkitty sorcessa):
                                                - SyottoAv.PAS/AvuChkSft/if (aState=cbGrayed) and NOT syoAktv  then...  aieutti Acces violation´in.
                                                  Lähti näköjään asettelemaan ChkBx´eja kaikkiin Frm´eihin, lisäsin if EdvFrm<>NIL  then ..State := ..
                                                - PRC SijKutsuLkmt uusittu kokonaan.   Halt; = Application.Terminate tämä ehkä vahvempi???;
                                                - Y_.PAS + FileLstN.PAS/fSaveFileDlg lisätty EdvFileN := jne.
                                                - Main.PAS(Net)´iin lisätty DebWr -seurantakirjoitusrivejä ~kaikkiin FNC/PRC´hin.
                                                - Y_.PAS´siin lisätty PRC Valivii,joka lisää .NOD ja .NOM 'fileisiin Sectionin eteen "´´´´´.." väliRvn.
                                                - OletusTiedostojen talletus UUSITTU.
                                                - Ekatal_NOE (boo) lisätty jos EdvFilen eioo filenä Olet-Ev.NOE, ks. FileEv.INC (Mo,NON?) / fLue_Talleta.
                                                - Olet-Ev.NOL (ja EsimEv.NOE) POISTETTU vanhoja peruja YLE´stä:  pjLiitRs,pjLiitXs ja Iks1vCos -rivit.
                                                  pjLiitRs=5,111000 korjattu 0,359  ja pjLiitXs=0,01156159 => 0,00651, ettei aina herja liian isosta eRs.
                                                  Sama korjaus myös alus_EdvSorce´en.
                                                - Lisättiin LueTalFilenReg´iin RegFnVirhe jos ajo sopimattomasta asemasta, siirretty Defs.PAS + NOLA.DPR.
                                                  Alp kehitelmä kokonaisuudessaan tallessa Y_ $DArrEd.pas´ssa.
                                                - KOKO LueTalFilenReg uusittu.
                                                - LapiRegKerta SetStrings.. chk ja nollaus jos >5000 Globals.PAS´issa.
                                                - Jos eioo EdvFileä, tehdään FN (joOllutkin) ja LueTalEdvFile LueTalFilenReg´ssä, myösReg´iin joOllutkin.
                                                - RegFnVirhe: string lisätty: Jos alkuluvussa PaaValFrm eioo vielä, virhe MessageDlg´llä kun PaaVal.Show.
                                                  Nyt Nola.DPR: if RegFnVirhe<>''  then Exit; //<+1415f. Tässä Exit lopettaa ajon, OK.
                                                  Virhe tuli olemattomasta polusta jos oli AJO ollut USB-tikusta =Z:\..., korjattu LueTalFilenReg´ssä.
                                                - ZKoeMem1.Visible :=   //1415e Z   Etsi ZkoeMem1 ja 2                    //<,Nyt tarpeeton, jää VARALLE.
                                               -ß lisättu 2´een kohtaan Y_.PAS/Y_gLueTal_FileLista/$_KolvattuaAjoTietoa.txt JA
                                                                        Defs.PAS/DefsFileen_U/$_KolvattuaAjotietoaX1.txt  JOSKO nämä vikoja ENNEN ERR.
                                               1415e:
                                               - fRePunKehi´ssä xFileExists =>  DirectoryExists. PAHA virhe, ei päivittänyt NOLA.NOR´ria viimMuutostejälk.
                                               - SyottoAv TabClick´n kulkua pääsee seuraamaan TabCtrlAvChange´sta alkaen ja TabNo := sij seuraten. Nyt
                                                 TabCtrlAv.Change´n TabClick´ien  PaaVal.OnShow´n "TabNo := 0; -1415eU?" kommentoitu vex KOSKA muut tabit
                                                 eivät workkineet.
                                               - if isDeb  then DetEvFrm.Visible := true; //<-1415eU koment vex: Tuli estämään deb näkymää vaikka := Hide.
                                               - Lisätty WrKoeF 1(..6) -fileenkirjoituksia EdvNevLask.PAS´iin Floating point overflow kohdan löytämiseksi.
                                                 NjLaskentaNapClick: if NOT LicAsttuOK ja if NOT lvEXTok POISTETTU KaikkiOik ehtoketjusta.
                                               - PaaVal.PAS / PRC NjLaskentaNapClick´iin x := fLisNoStrToInt(mylicense.LisenssiNum) ja ..(if x<>33) then ..
                                                 eli LisNo 33 (=YhtyneetInst)´lle EI aikaehtoa Yli6kkAjojaJalkeenLicDirPvm(=160 pv)
                                         if x<>33  then //<+1415e vapaa ajo, ei estoa = 33=Yhtyneet Insinöörit Oy.´lle ohitus. JOSKUS POISTETTAVA ohitus.
                                               1415d:
                                                - Tekee filen DebWr loppuun yhteenvedon DebWr-kutsuista.
                                                - LogFileen if fDirectoryExists (KaikkiOikDirN)  then su := 'AllRightsDirN=TR.'.
                                                - FNC isTypeNolaFileOkI poistettu (jäiköhän kesken aikais.) FileLstN.PAS/FNC isTypeNolaFileOk riittää.
                                                - Koe.PAS/WrKoeF (SI :string)´ään lisätty ohjaus PRC DefsFileen(), jotta EdvNewLask.PAS´in edvLaskennan
                                                  kulun KoeF´kutsut saataisiin $-Kolvat..tuihin. Siirtokutsut erottuvat "WrK:"
                                                - Kaikissa kulunseurTiedostoissa ($_DebWr.txt, $_KolvattuaAjotietoaX.txt, YFileen.TXT) nyt DateTimeMrkt
                                                  +versioleima pvMäärineen.
                                                Defs.PAS/FNC fRePuKehi´stä on sievennetty, pääosassa tiedoston FnRePunEhdotOHI('$_RePunEhdotOHI.oma') läsnäolo
                                                     ja lisänä'\NOLAKEHI\' ja 'REIJO..PC´n läsnäolo ja tunnistaminen. Vertailuajo 1415c ja 1415d välillä
                                                     ei eroja.

                                                Lisätty LOG´iin "Ohjelma käynnistettiin: .." rvn loppuun if fDirectoryExists (KaikkiOikDirN)  then su := 'AllRightsDirN=TR.'
                                                         mutta ei vielä käännetty jakeluversioon 15.8.2014.
                                                FileLstN.PAS: isTypeNolaFil2eOK(COHA,uFilen,str); //<+1415c: COHA. ..2eOK oli ´itsekseen´ syntynyt VIRHE?!
                                                              isTypeNolaFileOK (COHA,uFilen,str); //<1414d   ' Vain 1x kutsu, nyt =>..FileOK
                                                         eli RESULT saisi aina arvon  FA, mutta ..Fil2eOK FNC´tiotahan ei ole, joten vain kännösherja.
                                                DebWr(0,'','') => DebWr(-1,'','') OLI: '','' YhtVeto kutsuLkm´stä => DebWr(-1, ...).
                                                1415c:
                                                - Filenluku  REGistä ei sittenkään onannut, YhtInst´lla ikuinen silmukka js StackOverFlow. Nyt TOSIyritys
                                                  UUDELLEEN = Y_.Pas \ FNC LueTalFilenReg uusiksi täysin + siihen littyvät
                                                - Tiedoston talletus omalle nimelle ei toiminut.
                                                - Reg´iin kirjoituksen yhteydessä AINA myös SijFnListaan (edvNimet.txt yms).
                                                - LueTalFilenReg => LueTalFN_LstReg
                                                - YhtInst StackOverload err syy selvisi: LueTalFN_LstReg kutsuu teePolkuDataFilen mikä kutsui takas jne.
                                               -- Y_.PAS/LueTalFilenReg´in sisälle FNC teePolkuDataFilen ja kutsu vain sisältä, muut teePolku..kutsutVex,
                                                  joten KUTSUTAAN VAIN  LueTalFilenReg. }
         SisX_+'Virheiden seurantajärjestelyä apuhakemiston kautta on yksinkertaistettu niin, että kaikki tieto viedään yhteen tiedostoon '+
            '($_DebWr.txt), joten nyt kaikki seurantamerkinnät ovat luonnostaan krnologisessa ja loogisessa järjestyksessä. Lisätiedostoon '+
            '($_DebWr-EsiintymäLkmt.txt) on koottu samojen kutsujen lukumäärät. Tiedostolla on käyttöä vain NOLAN kehitystyössä.'+
         SisX_+'Seurantatiedoston kokorajoitus on nostettu 5000 riviin, ylityksestä seuraa ajon keskeytyminen. Syntyneet tiedostot ovat kuitenkin '+
            'käyttökelpoisia, on vain poistettava tai uudelleennimettävä toiminnan laukaiseva hakemistonimi, jolloin NOLAn normaaliajo on taas mahdollista. '+
            'Ohjeet seuranta-ajon järjestelyyn annetaan tapauskohtaisesti.'+
         SisX_+'Verkkokuvaajan (ruudun vasen laita) riviotsakepanelin rivien 23,27 (Dz 0,4 ja 5s) sekä rivien 28-30 (jkB-jkD 5s) vaadittujen '+
            'minimioikosulkuvirtojen arvot on ajanmukaistettu käyttäjähavainnon ansiosta. Aikaisempiin arvoihin oli jäänyt SFS 6000 alkuaikojen '+
            'kehitysvaiheen arvoja. Suurimmat muutokset ovat johdonsuojakatkaisijoiden 5s´n poiskytkentäajalla +8%..+52%. Vaikutukset näkyvät '+
            'verkkokuvaajan johto-osakohtaisissa mittaustilanteessa/testerinäytön minivaatimuksissa, esim. <b>5s jkC,jkD</b> '+
            CLR_PURP +'{92A/57,5A} => {140A/87,5>}</f>.'+ //Nyt kaikki muutkin oikosulkuvirtavaatimukset on tarkistettu.
         SisX_+'Ajotiedoston talletus omalle nimelle ei aina toiminut, korjattu.' +

       //SisX_+'Virhetarkastelun seurantatietojen kirjoitus ohjataan nyt samaan erikseen määritettävään hakemistoon (valmistaja antaa ohjeet tapauskoht.)'+
'<br><br><b>14.1.5   27.08.2017d </b>' + {Ed oli 14.1.4 13.02.2017fu, siis: 1414fu sorcissa on sama kuin 14.1.5,  25.10.2016 b.
                                         1414b´llä merkattu: - Kysyi "Poistetaanko loputkin" kun EDI oli vikan jOsan kohdalla.
                                                             - edi := edvo esti/kumosi jOsan poiston.
                                         1414d: - Paha moka: FileListaa ei voikaan löytyä jos eioo ListFilNimeä EIKÄ Reg´istä :Y_.PAS r2761
                                                - Em´n lisäksi 20+~10 kpl Str -testejä PUUTTUI, oli esim:  if s[1]='1' => korjattu:  if (s<>'') AND (s[1]=..).
                                                - fRePunKone,-KehiAjo,-VainAjo, yms.vvex,   jää VAIN: fPePunKehi, fRePunAjoJAKELUUN_pakkoTxtBaseChk.
                                         1414e: - DefsFileen kutsut ohjautuu DefsFileen_o´hon, joka on pelkistetympi ja KOLVATTU kirjFileen AINA.
                                                - fRePunKone => fRePunPC,  FNC fDefsFileeseenON => DefsFileeseenFON.
                                                - DefsFileeseenONdn => DefsFileenKirjONdn, lisätty: DefsFileenFLueONdn =FileLUVUN tarkistusKirjoitukseen,
                                                  nyt voidaan erikseen LueFile ja DefFileen kirjoituksia ohjata ON/OFF.
                                                - Pelkistetty DEVELOPER1 -fnct, nyt enää fRePunKehi ja fRePunAjoJAKELUUN_pakkoTxtBaseChk käytössä.
                                         1414f: --Tiedostoluettelon (esim. EdvNimet.txt) käsittelyssä päiväykset näkyivät tiedostonimessä = "List bound error(0)"
                                                - Kaikki DefsFileen() kutsut korvattu YFileen kutsulla, joka kirjoittaa SUORAAN fileen (APPEND) rivejä.
                                                - DefsFileenKirjONdn=>DefsFileChkLueONdn =kirjoitus omaan dirriin.
                                                - LiitRpX_Phi_Str tutkinta onko Rs OK ja korjKehotus ja alust. sijoitus.
                                                - Syotto.PAS/edvPvitOK´ssa korjattu V¨(Ze²-ar²) => floating point invalid oper.. virhe. Etsi "1414f Sqrt"
                                                - KorjKerrTlkosta paluu lisäsi palauuarvon loppuun ~, korjattu,
                                                - Llist index out of bounds (0) -herja tuli lopulliseksi kiusaksi. Kävin KAIKKI StringList´it läpi ja
                                                  lopulta jäi vain FileLstN.PAS/LstF.Free virhelähteeksi. Löysin FileEv.INC´stä 2xLstF := ..Create, eikä
                                                  niiden tarkoitus selvinnyt (ilmeisesti oli 2x jos oli jo Free´ttu ja uudelleen luotu?).
                                                  Lisäsin LstFk FileEv´hen ja POISTIN FileLstN.PAS/LstF.Free, mikä näytti korjaavan koko ihmevirheen.
                                                  eioo_FLst´kin nyt tulostuu näytölle (NotePad).
                                                - if isDeb ehto lisätty PaaVal.PAS´iin LicenssiLtlto pvityksen lopettajien luettelo varten DetEvFrm vex.
                                               -- Poista FileLstN.PAS´sta rvltä 1083 WBeep + CopyFile JAKELUCVERSIOSTA (vaikuttaa VAIN jos isDeb).
                                               -- ¶¶ø  KEHIVAIHEEN välttämättömyys, etsi ne 2 sorsakohtaa yht: FileLstN.PAS .
                                               -- ¶° ¶- ¶" ´lla merkitty kehiTärkeät breakPoint-kohdat FileLstN.PAS´ssa, sen ALUSSA käytönkuvaukset.
                                               -- IterEsto := TR ja FA FileLstN.PAS´ssa aivan lopussa: estää FileEvInc´in ikuisen silmukan FileEvINC /
                                                  Y_gLueTal_FileLista´n kautta.
                                               -- LueTalFilenReg K O K O N A A N  UUSITTU.§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
                                               -- $DefsFileChkLue-204 poistettu j tilalle --$DefsFileChkLue-203.§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
                                               -- SyoAvHide =SyottoAvFrm.Hide Siirtty ChkLisensLista_NolaRek´sta PaaVal valintojen jälkeen.
}
         SisX_+'Verkkokuvaajan johto-osien lisäys/poisto eivät toimineet oikein kaikissa laajuusverioissa (EXT,PRO,LT), korjattu.' +
         SisX_+'Tiedostoluettelon (esim. EdvNimet.txt) käsittelyssä päiväykset näkyivät tiedostonimessä, mistä error: "List index out of bounds (0)".' +
         SisX_+'Verkkokuvaajan laskennan tiedostonimien valinnassa on oletusnimet suojattu siten ettei ensiajon oletusnimiä (Olet-Ev.NOE, Olet-Nj.NON, '+
            'Olet-Mo.NOM) voi enää käyttää omien verkkorakenteiden talletusniminä.' +
         SisX_+'Käynnistyksen yhteydessä tapahtuvat silmukat on optimoitu karsimalla ja yhdistelemällä algoritmeja minimiin.' +

'<br><br><b>14.1.4   10.10.2016</b>' +//6.07.2016</b>' + {- FrmOtsikko -kutsu otettu vex TEdvNewFrm.FooterPanelMouseMove´sta (haittoja?).}
         SisX_+'Kehitysympäristö on tällä versiolla Windows 10, eikä eri dialogien väreihin ole tehty muutoksia, vaan ne ovat w10 asetusten mukaisia, '+
            'joten ne määräytyvät käyttäjän omien asetusvalintojen mukaan.'+
         SisX_+'Lisättäessä verkkokuvaajan johto-osia, niitä tuli yhden sijasta aina 2 lisää. Korjattu.'+
         SisX_+'Talletettaessa NOE(verkkokuvaaja/ed.verkko), NON(nousujohtolask.), NOM(moottorilask.) tai NOH(häviökust.) -päätteisiä ajotiedostoja '+
            'toisin kun on alunperin tarkoitettu, yritys ottaa näitä tiedostoja käyttöön muuhun ohjelmaosaan aiheuttaa ajonaikaisia virheitä. Näiden '+
            'virheiden välttäminen on ollut pääaiheena viimekuukausien korjauksissa. Virhe on nyt hoidettu siten, että haluttu tiedosto tarkistetaan, '+
            'onko se soveltuva kyseiseen ohjelmaosaan ja väärissä tapauksissa avataan tiedosto NOTEPADiin, missä selostetaan virheet (esim. puuttuvat '+
            'tiedostot, väärät tiedostotyypit) ja annetaan toimintaohjeita. NOLAn tekemät tiedostot ovat puhdasta tekstitiedostoa (ASCII), joita '+
            'voi tarkastella tekstieditoreilla (esim. em. NotePad). Tiedostoon voidaan esim. lisätä verkkokuvaajan johto-osia, muuttamalla '+
            'johto-osien lukumäärää <b>JohtoOsia=</b>X halutuksi, jolloin <b>kutakin uutta johto-osaa</b> varten tulee tehdä oma <b>[edv_EdkaX]</b> '+
            'tunnisteosa ja kaikki parametrit mallin mukaan, ks. esim. ..\NOLA\Data\Olet-Ev.NOE tai ...EsimEdv.NOE .' +
         SisX_+'Lopetettaessa istunto, käytetyn työtiedoston mahd. muutokset tutkittiin virheelliaesti. Vaikka aikaisemmissa ajoissa oli tiedostoon '+
             'jo korjattu uudet JkUps -tiedot, mitä ei oltu kuitenkaan tulkittu oikein ja tiedoston muuttumisesta ilmoitettiin virheellisesti ja '+
             'pyydettiin vahvistusta tallettamiseen.'+
                                       {Lisäyksiä: - Virheellisen tiedoston poimimisesta virheilmoitus.
                                       }
'<br><br><b>14.1.3   25.04.2016</b>' + {- LueFileErr.. käyttöön: FNC LueTalFile´ssa tarkisustuloksia ei voi tiedottaa ShowMessage´lla tms. => Err. koskei
                                          niitä vielä ole luotu. Tiedot talletetaan txtFileen, josta tiedot voidaan poimia.
                                        - Kun KaikkiOikDirN asetettu, Lisenssitiedot korvattu => "Licenssintarkistus ohitettu, OK."
                                        LueFileErr kehitys nyt keskeytetty (FileLstN.PAS), nyt ohitettu kohta merkittu µ£µ kommettisulkujen sisällä.
                                        - Keskityin  korjaamaan virhettä 1412´ssa:  LisääBtn lisäsi 2 j-osaa eikä näytä Poista-Btn´ia.
                                        - SortInif´iin lisättävä NjL -osan sorttaaminen listan viimeiseksi, Jätin sen myöhemmäksi tehtäväksi.
}
'<br><br><b>14.1.2   12.04.2016</b>' + //, jolloin RELEASE on juokseva vähäisissä (väli)muutoksissa. Siten edellinen versiotunnuts oli 13.0.3 pvXx.. b}
                                              {- JkUpsInt otettu sittenkin takaisin apusuureeksi, koska edv.edka[].JkUps.ArvoInt´iin suora sijoitus häviää
                                                 jostain syystä. Nyt sijoitus ekax JkUpsInt´iin, mistä sijoitus: edv.Edka[Edi].JkUps.ArvoInt := JkUpsInt;
                                              >- Yläpaneliin lisätty ukOFF/ukON valinta, jolla vaikutetaan uk´n ilmaisulaajuuteen.
                                               - FNC TyhjaNimi oli väärin, mahtaako antaa saman kuin ennen (ks. FileLstN.pas/FNC TyhjaNimi ???
                                               - 10.INC´ssä PrLsk muutettu JkUps´iksi
                                               - PRC TeeKutsu muutettu PRC TeeSyoFrm´iksi
                                               - TUTKI+KORJAA "---V: ---%" -kohdat, jotka näkyvät SrcJosan rvt 22..31
                                               - JVileen -fileenkirjoitusrvt poistettu, ne ovat tallella ..Globals\Syotto sis-JVileen.PAS´ssa.
                                            >>>- £$£u g: -kohdassa PRC TJohto.ReSize´ssa "if IsChanged .." poistettu kokonaan =piirtää 1x Edv´n harvemmin.
                                              >- Lisätty UPS-syöattökojeen sijoittelu JK´hon.
                                               - Verkkokuvaaja avustetekstejä tarkistettu
                                            >>>- DlgOli: 11=SjDlg  12 PjDlg  13=VvDlg  14=UpsDlg  2=JosaDlg  5=HävDlg  7=JkUpsDlg
                                                         'Nämä arvot sijoitettiin BxItems´issä =kertoo missä dlg´ssä oltiinJust.  Tarvis vain 1x !!!!!!!!!
}
{####################################################################################################################################
gcIk1v => gK1vSust  Tarkista UPSnyt -version mukaanotossa, onko sen SORCissa "gcIk1v" ,mukana.?  Tämä muutos on 14.1.1´ssä joteutettu.
##################################################################################################################################### }
         SisX_+'Johto-osuuksien tietoikkunavalintoihin on nyt lisätty pitkään lupailtu <b>UPS-kojeiden lisäysmahdollisuus</b>, jolloin resurssirivien '+
           '(ryhmäjohtojen max.pituuksien rvt 23..31) laskentaan ei vaikuta jakokeskusten edeltävät johto-osuudet ja liittymätiedot, vaan vain '+
           'UPS-laitteen sisäiset parametrit (Ik1v ym), mistä seuraa että eri jakokeskuksiin sijoitetut identtiset UPSit antavat samat max.johtopituudet.' +
         SisX_+'Varavoimageneraattoreista on puuttunut parametrien valinta. Käyttäjähavainnon jälkeen aikaisempien kokemusten perusteella on '+
           //'(mm. sulakekäyrien väliarvojen laskennassa käytetty)
           'otettu käyttöön NOLAN lisäosaan <b>iterointimenetelmä</b>, joka laskee tiedossa olevien koneyksiköiden yksikkökokojen ja parametrien '+
           'suhteesta iteroidut halutun koneen kaikkien parametrien arvot. Arvoihin voidaan vaikuttaa haluttaessa käyttäjän oman harkinnan mukaan '+
           'niin, että arvomuutokset ovat nähtävissä tosiaikaisesti teoreettisesti laskettuihin arvoihin verrattuna.'+
         SisX_+'Yläpaneliin lisätty ukOFF/ukON valinta, jolla voidaan vaikuttaa uk´n ilmaisulaajuuteen joko löydettynä max.arvona tai riveittäin.'+
         SisX_+'Aikaisemmin väliversiot on ilmaistu päiväyksen jälkeisellä kirjaimella "a".. jne. keskimmäisen numeron (MINOR) '+
           'pysyessä "0":na. Siten edellinen muutosversio oli "13.0.3  13.05.2015 b" joka nyt muuttuu tästä versiosta lähtien <b>14.1.1</b>(2)  pv..., '+
           'siis MAJOR.MINOR.RELEASE yleisemmän käytännön mukaan.'+
'<br><br><b>13.0.3   13.05.2015 b</b>' +
         //H A A M U T E K S T I  korjattu:,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
         SisX_+                       {(Lisenssi)Components\LicensePanelNola.pas´in LT,PRO,EST,GLOB -tabeilla oli haamuteksti hieman alapuolelle TAI oli
                                       maalautuneena koko alueet, nyt ne kaikki käydään läpi asettaen päälle ja sitten vain se oikea (PRC SetComponentStatus).}
           'Windows(7) Aero -teemalla (Theme) lisenssiasetuksissa näkyi haamukomponentteina painikkeita ja tekstejä häiriten lisenssilaajuusvalintoja. '+
           'Nyt löytyi ohjelmallinen kiertomenettely kiusan poistamiseksi.'+
        {SisX_+'UPS-verkkokojeen käyttöä on laajennettu siten, että se voidaan sijoittaa myös jokaiseen jakokeskukseen ' +
           'syöttämään resurssitarkatelurivien kojeita (rivit 23..35).' +}
         SisX_+'Johto-osien tiedoissa 2,5 mm²:n johtoa luettaessa NOE-tiedostosta pyöristyi oikeaoppisesti 3:ksi, ja parametritarkistuksista tulee '+
           'ilmoitus (esim): "NOLA ei tunne johtotyypin "MCMK4½" äärijohdinta 3 mm² vastaavaa PE/PEN-johdinta, arvo lasketaan..." ,koska NOLA käyttää '+
           'poikkipintoina vain kokonaislukuja, jolloin 2,5 ja 1,5 pitäisi pyöristyä pienempään kokonaislukuun (2 ja 1). Nyt mm2 -arvo korjataan '+
           'näillä poikkipinnoilla jo tiedostoluvussa.'+
         SisX_+'Varavoimalaitteiston generaattorien parametrien iterointiin on tehty ohjelmaosa, jolla voidaan laskea poikkeavien koneyksilöiden arvot '+
           'lähimpien vakiokoon koneyksiköiden arvojen ja tehojen suhteessa, joissa mahdollisuus käsinkorjaukseen.'+
'<br><br><b>13.0.2   25.02.2015 e</b>' +{      - if NOT fFileExists(NolaRekPFN) testejä 1)Globals  2) RekPaa´han lisätty jos vaikka NolaRek-ajoa mistäVaan.
                                               - 130.2d: Samoin DirectoryExists korvattu fDirectoryExists´llä koska ei ehkä aina tiennyt oikein. Samalla
                                                 poistettu eteen lisätyt "Exs_". Joku korvattu myös if fFileExists('..\TextBase.txt'), mikä on myös LUOTETTAVA.
                                               - Res ym.FNC´ssa MMJ/MMK*´n lisäksi lisätty erikseen 'MMJ'.
                                               - Kosketusjännitelaskenta (uk) lisätty verkkokuvaajan riveille 23..31.
                                               - Lääkintätilojen IT-muuntaja on muutettu annettavaksi/valittavaksi suureeksi.
                                               - Verkkokuvaajan max.pituustulostukset on yli 100m´n pituuksilla pyöristetty lähimpiin metreihin.
                                               - Lääkintätilojen IT-ryhmäjohtojen max.pituuslaskentaan (rv31) on algoritmi uusittu täysin:  ensin lasketaan
                                                 poiskytkentäajan ja ryhmäjohtopoikkipinnan mukainen max.pituus johdolle (Lmax) kuten ennenkin, nyt lisätyn
                                                 kosketusjännitteen uk laskennassa puolet tästä pituudesta redusoidaan vastaamaan MK6´n impedanssia kuvan
                                                 "LaakMuunt_IT.bmp" mukaan (suojamaad.johdot), missä 2j ja 1j -haarat on laskettu saman pituisina kuin
                                                 ryhmäjohto, joten uk on arvona sama, laskettiin se 2j tai 1j´n mukaan, johdettu kaava:
                                                       //Laµ=2.5mm²´n pituus.  Lbµ=6mm²´n pitus;  6/2.5=2.4;  2.4xLaµ-ur = Laµ+ur => ur=0.7xLaµ
                                                       //Yhdmukaistetaan=redusoidaan pituudet samoiksi = La po.= Lb; => La := Laµ+ur ja Lb := Laµ-ur .
                                               - Verkkolisenssihakemiston testaus lisätty, pitäisi lisätä testaus myös serveriosuudelle erikseen ???.
                                               - Impedanssien käsittelyosassa laskentalämpötilan muutos ei astunut voimaa haluttaessa.
                                               - Verkkokuvaajan avusteet toimivat taas myös vasemman reunan panelissa (rivien nimet/selitykset).
                                              -- Käynnistyessä OaaNal.PAS´ssa ollut "//£$£-1412" -kommentilla poistettu LaskeEdvArvotOK -kutsu vähentää
                                                 KAIKILLE J-osille kyseiset laskenta- ja piirtotapahtumat 2´sta yhteen.}
         SisX_+'Kosketusjännitelaskenta (uk) lisätty verkkokuvaajan riveille 23..31.'+
         SisX_+'Lääkintätilojen IT-muuntaja on muutettu annettavaksi/valittavaksi suureeksi, jolloin tulostetaan valitun muuntajan rj-pituudet /´n '+
           'jälkeisellä palstalla 7,5 kVA´n muuntajalla laskettuna..'+
         SisX_+'Verkkokuvaajan max.pituustulostukset on yli 100m´n pituuksilla pyöristetty lähimpiin metreihin.'+
         SisX_+'Lääkintätilojen poikkipinnan mukainen max.pituus rj-johdolle redusoidaan vastaamaan MK6´n impedanssia kuvan "LaakMuunt_IT.bmp" mukaan.'+
         SisX_+'Impedanssien käsittelyosassa laskentalämpötilan muutos ei astunut voimaa haluttaessa.'+
         SisX_+'Huomattuaan ettei Config -hakemiston polku ollut oikein, NOLA tarjosi dialogia, missä oli mahdollisuus korjata polkumääritystä, mutta '+
           'korjaus ei tallentunutkaan oikein. Korjattu.'+
         SisX_+'Polkutarkistuksissa (DirectoryExists) on herännyt luotettavuusepäily, minkä takia tarkistuksessa otettu käyttöön laajempi rutiini.'+
         SisX_+'Verkkolisenssin asennusohjeita (mappaus) täydennetty  (Päävalikko / Ohjeet/Tietoa / Asennus- ym. ohjeita..), ja ikkunaan on lisätty Etsi '+
           '(merkkijono)-toiminta.'+

'<br><br><b>13.0.1   5.10.2014 a</b>' +{       - Sulakekäyrän taulukoihin lisätty 2A sulake ja rivn Pistor. Dz 0,4s 16/10A (110/82A) muuttui:  =>(114/84),
                                                 IECn tulppasulakekäyriltä tarkistettu. Lisätty Sulaketarkasteluosaan.
                                               - Johdonsuojakatkaisijoiden (B,C,D) 5s´n käyräpisteet muuttuneet 7x ja 9x => 4.6x kaikilla samat.
                                               - Lisätty PrRj-reservilaskentVe´ja ..2A´iin asti.
                                               - Testerin näyttämävatimuksessa tarkkuus vakioitu 0,5A´iin.
                                               - Koko Sulaketarkasteluosa jouduttu käymään läpi, koska lisätty uusi SuTim(TComboboxXY), aikavalinnat 0.1-5s.
                                                 ZS_TMed ja ZS_LMed vaihtuivat paikoin.
                                               - Uh-laskenta muutettu EXTended -laajuusversiossa siten, että vain yhden liittymäjohdon jännitealenema
                                                 lasketaan haluttaessa mukaan.}

         SisX_+'Sulakekäyrän taulukoihin lisätty 2A sulake ja rivin Pistor. Dz 0,4s 16/10A (110/82A) muuttui:  =>(114/84 IECn tulppasulakekäyriltä ' +
               'tarkistettu). Lisätty NOLAn Sulaketarkasteluosaan. '+
         SisX_+'Johdonsuojakatkaisijoiden toimintapisteet ja tulkinnat on tarkistettu uudelleen ja muutokset näkyvät verkkokuvaajan virtavaatimuskentissä '+
           'esim. "10A jkB (44.6A)". Kaikilla tyypeillä B,C ja D 5s:n toimintapiste on sama 4,6×In).' +
         SisX_+'Lisätty PrRj-reservilaskentavaihtoehtoja (..2A´iin asti yläpanelin valintaboxiin.' +
         SisX_+'Testerin näyttämävatimuksessa tarkkuus vakioitu 0,5A´iin.'+
         SisX_+'Koko Sulaketarkasteluosa jouduttu käymään läpi, koska lisätty uusi SuTim(poiskytkentäaikavalinnat 0.1-5s).'+

'<br><br><b>12.0.5   17.06.2014 o</b>'+
                                     {ITSELLE: - Tässä versiossa lisätty KaikkiOikDirN´lle aikaraja 180 pv, jonka jälk. pyyd.ottamaan yhteyttä valmistajaan.
                                                 Aika lasketaan VARO_NOLA_LUE_WARNING´in aikaleimasta.
                                               - Perussyy Invalid floating.. virheeseen:  FilelstN.PAS/PRC fLueTalOrdLista VAR ListFile :TextFile; PUUTTUI
                                               - Liittymäjohdon tietojen syötön rivin 14 avuste korjattu(uh% => T°C).
                                               - Maakaapelin korjauskertoimen valintaikkunan väpätys korjattu.
                                               - 120.5o:  KAIKKIIN Dir..(FileExists-testeissä file-/polkunimien eteen lisätty '\\?\' (=Exs_).
                                               - FileLstN.pas´ssa oli esittelemätön i (laskuri) (Etsi '120.5oooo')
                                                 MAHTAISKO VAIKUTTAA, ETTEI FLOATING POINT. OPER. VIRHEILMOITUKSIA ENÄÄ TULISI !?!?!?!?!?
}
         SisX_+'Verkkokuvaajan jännitealenemalakenta ulotettu myös liittymäkaapeleihin.' +
         SisX_+'Korjauskertoimien valintaikkunoista maakaapeliosan väpätys korjattu.'+
         SisX_+'Verkkokuvaajan "Lisää" (johto-osa) aiheutti List index virheilmoituksen, korjattu.' +
         SisX_+'Desimaalimerkkinä piste on korvattu kansallisen stardandin mukaisesti pilkulla.' +
         SisX_+'OFAA-sulakkeiden kokeilualgoritmia (rv 10) on tarkennettu niin, että jos verkkokuvaajassa on peräkkäisillä johto-osilla OFAAn '+
           'arvoja, vaikutus seuraaviin lasketaan verkossa edellisen johto-osan OFAA-arvon mukaan. Jos verkossa on rinnakkaisia liittymäjohtoja '+
           'ja niissä useita OFAA-arvoja, lasketaan niistä pienimmän OFAAn mukaan.'+
'<br><br><b>12.0.5   31.03.2014 m</b>'+
                                     {ITSELLE: - Tässä versiossa (g+) on tehty muutoksia Paaval.PAS´ssa: NolaRek -tarkistuksen editoinnin
                                                 sanamuodoissa, jotka eivät tulleet jakeluversionn =vain itselle näkyy muutenkaan.
                                               - NolaNet´ti ei käynyt ollenkaan EtsiExenJuuri_TeeAjoDir, joten KAIKKI gAjo.. -nimet jäivät vex.
                                                 Muutenkin viritelty Input.. dialogien infoja.
                                               - gAjo..´n jälkeen filenimen t. polkujatkeen edelle oli lisätty "\" =Oli PAHA virhe (teki xx\\Filen).
                                                 Hyvin monia korjauksia. KAIKKI gAjo..´t käyty läpi, "+'\'" poistettu. PAHA PAHA PAHA, nyt OK.
                                               - Verkkokuvaajassa arvojen desim.pisteet muutettu PILKUIKSI.}
         SisX_+'Moottorilähtöjen laksennassa on ollut harmillinen virhe: moottorikeskuksen edellä olevien keskusten pääjohtojen vaikutusta '+
            'laskettaessa algoritmissa ja kaavaansijoituksessa oli virhe, minkä takia max.moottoriryhmäjohtopituudet (LxSu- ja LxMax -sarakkeet '+
            '22,23, 28,29) näytettiin liian pitkinä. Moottoriosan det.valinnan tiedoissa kuvataan laskentamenetelmien erot ja arvoina esitetään '+
            'sekä käynnistys- että normaalikäynnin laskentatiedot LxSu- ja LxMax -sarakkeille.'+
         SisX_+'Lopetuspainikkeella päävalikosta poistuttaessa tutkitaan myös moottolähtöosassa tehdyt muutokset ja kysytään mahd. talletustarve.'+
         SisX_+'Moottorilähtöjen käsittelyssä selkeytetty ja täsmennetty verkkopisteen valinnan vaikutuksia ja laskentaperiaatteita avusteissa.' +
         SisX_+'Havaittaessa viallinen ajotiedosto (*.NOE, *.NOM jne.), virheilmoitukseen on sisällytetty valinta editoita joko ajotiedostoa tai' +
            'ajotiedostolistaa Notepad´issä.'+
         SisX_+'Verkkokuvaajassa keskusnimien fontti muutettu selkeämmäksi (yksinkertainen bold).'+
         SisX_+'Verkkokuvaajan liittymä- ja johtotietojen ikkunassa oli osittain näkyvissä seuraavaa tulevaa muutosta (12.0.6 UPS-'+
           'verkkohaaran laskentavalintaa) ennakoiva, päällekkäiset komponentit korjattu.'+
         SisX_+'Sovelluskehittimen desimaalipisteen syntaksivaatimukset edellyttivät joidenkin liukulukukäsittelyjen yhteydessä '+
           '<u>verkkokuvaajassa</u> desimaalierottimena käytettäväksi pisteen sijasta pilkkua, minkä takia kaikki verkkokuvaajassa '+
           'esitetyt liukuluvut on nyt muutettu pilkullisiksi (myös Suomen kansallinen käytäntö). ' +
         SisX_+'Käynnistyspolun ja aputiedostojen polkujen lukurutiinit tarkistettu.' +
         SisX_+'Verkkokuvaajan yläpaneeliin on lisätty pudotusvalintaboxi, josta voidaan valita resurssiriven lakentaan (rivit '+
           '23-30) ryhmäjohtopoikkipintoja tavanomaisten 2,5/1,5 mm²:n <b>tilalle 4..16 mm²</b> 16A/10A sulakkeilla, jolloin ' +
           'heikossa verkossa voidaan syöttää muutoin mahdottomia pistorasia- tms. etäisyyksiä. Aloite tullut käyttäjäkunnasta.' +
'<br><br><b>12.0.4   13.12.2013</b>'+
         SisX_+'"Invalid floating point operation" virhe joissain ympäristöissä alkulatauksessa korjattu.' +
         SisX_+'Testerinäyttämävaatimukset on laskettu uudelleen; aikaisemmin kerroin oli 1.2 mutta käyttäjäkommentin herättämänä '+
           'virhe huomattiin vasta nyt, oikea kerroin on 1.25 ja muutokset vaikuttavat verkkokuvaajan riveille 23-30.' +
         SisX_+'Virheilmoituksen "Invalid file name - %s" syy käynnisstyksen alussa on korjattu.' +

'<br><br><b>12.0.3   22.10.2013</b>'+
         SisX_+'Projektitiedostojen tallennus ja/tai luku toimi vanhojen ajojen tiedostonimiä käsiteltäessä liian rajoittavasti. '+
           'Nyt jos listoissa (esim. EdvNimet.txt) olevia tiedostoja ei löydy ja NOLA on käynnistetty verkon yli (tunnistus polun '+
           '"<b>\\</b>" -alkumerkinnästä), tutkitaan tiedostonimen alkuun liitettävällä polun verkko-osalla (esim. <b>\\FirmaOma\d</b>). '+
           'Jos tällä nimellä löytyy hyväksyttävä tiedosto, editoidaan se valintalistassa. Lista kuitenkin tarkistetaan, ettei '+
           'sama nimi esiinny kahteen kertaan samassa listassa.' +
         SisX_+'NOLAn sisäisiä käynnistys- ja ajonaikaisia polkutietojen päättelyratkaisuja on 11.x.x versioista lähtien voinut '+
           'seurata lisäämällä <b>NOLA...exe</b> tiedoston sijaintihakemistoon tunnistushakemisto "<b>_$DefsFileeseenON</b>", joka '+
           'olemassa olollaan ohjaa luotavaksi alleen tiedoston, mistä näitä tietoja voi seurata mm. virhetarkastelussa.' +
         SisX_+' Alkulatauskuvan käyrien värit on ''nykyaikaistettu'', siis: ruskea, mussta, valkoinen.' +

'<br><br><b>12.0.2   18.06.2013</b>'+
//- LueTalFilen muutettu LueTalFilenReg´ksi (koska lukee/tallet. registryyn). Testeri Asennustesteri
         SisX_+'Verkkokuvaajan ryhmäjohtojen <b>resurssiriveille 23..30 on lisätty </b>määräyksen SFS 6000-4-1 kohdan '+
           '411.4 vikavirtapiirin epäyhtälöstä ' +FONT_COURIER +'Z ' +FONT_PIENPI +FONT_COURIER +' 4Uo/5I ' +FONT_SSERIF+
           'ja kuvaajan vasemmassa reunassa olevassa panelissa näkyvien vaadittavien oikosulkuvirtojen korjatut '+
           '<b>oikosulkuvirta-arvot, jotka on ASENNUSTESTEREIDEN VÄHINTÄIN näytettävä.</b> Epäyhtälöstä '+
           'ratkaistuna kerroin on 1.25, mikä korjaa / yhdenmukaistaa laskennassa käytetyn ja mittaustilanteen '+
           'vallitsevia lämpötilaeroja. Esim. rivin 23  16A ja 10A:n tulppasulakkeille 114A×1.25 ja 84A×1.25, '+               //<Korjattu 130.2e myös tähän
           'NOLAssa ilmaistuna ' +CLR_PURP +'<b>{142.5A/105A}.</b></f> Rivin 22 avusteisiin on lisätty tämä sama tietolisäys '+// koskei varmuutta riittikö
           'sekä <b>avusteikkunaan kuvallinen lisälehti</b>'+                                                                  // korjaus vain TextBase.txt´iin.
         SisX_+'Verkkokuvaajan <b>riville 31 on lisätty avusteikkunaan lisälehti</b> (nyt: "Avuste" ja "rv31 havainnekuva"), '+
           'missä kuvassa on esitetty havainnepiirustus vikavirtojen kytkeytymisestä lääkintäerotusmuuntajan IT-järjestelmässä ' +
           'suojakiskon kautta ja pot.tasauskiskon kautta. Sama kuva on tarkasteltavissa ? -painikkeen jälkeen lehdeltä '+
           '"LääkMuunt_IT".'+
         SisX_+'Ajotiedostoja uudelleen valittaessa verkkokuvaajan "Lue" -valinnassa tiedostojen käsittelyssa oli virhe, '+
           'joka esti tiedoston uudellenvalinnan ilmoittaen "Tiedosto virheellinen, valitse uudelleen!". Sovelluskehittimen '+
           'aikaisemman Delphi 5:n ja nykyisen Delphi XE2:n käsittelyeroista aiheutunut virhe korjattu.'+

'<br><br><b>12.0.1   26.05.2013</b>'+
         SisX_+'<b>Pikakorjaus:</b> Kaapelihintatiedoston (KaapHinD.NOL) polku ei kaikissa ympäristöissä määrittynyt oikein '+
           'käynnistyksessä, polkuun syntyi ylimääräinen Config ja sai aikaan ennakoivan virheilmoituksen '+
           '"K:\Nola\Config\Config\KaapHinD.NOL puuttuu, nousujohtotulostus tapahtuu ilman hinnoittelua."'+
{Itselle tiedoksi:
 - Globals´issa nimitysmuutoksia:  CurrDir => actPath, GLOBAALIT: gAjoPath,gAjoConfPath
 - mySettings => myRegSettings.
 - $IFNDEF NOLALIS kommentoitu vex koemielessä Clobals.PAS rvt 57 (esittely) ja 339 (Create).
 - Val (s,R/I) muutettu StrToFloatQ/StrToInt´ksi.
 - SokR´ssä muutettu ","´n vaihto "."´ksi päinvastaiseksi (XE2 lukee ilmeisesti maa-asetuksia) jotka nyt XE2´ssa asetettu
   (Globals.PAS/CreateGlobals) SysUtils.FormatRegSettings.DecimalSeparator := '.';
 - so[i] IN [..] => CharInSet(so[i], ['0'..'9','.']) XE2 muutatti.
 - NOLA tutkii 32/64 -bittisyyden ja käynnistä oikean version.
 - Riviavusteista on sisennykset poistettu, koska alkuun on lisätty tieto Clik/DblClickin jälkeistä sisennystä en saanut
   workkimaan. Sisennys ks. SyottoAv.PAS ja Avuste1.INC.
 - DetEvFrm.aRich´in asetuksista poistettu Horisontal ScrollBar, jolloin WordWrap, workkii taas OK.
 - 10.INC´ssä 30..50[n] Ziks antoi eri arvon kuin 31..51[n-1] eli edJ-osan loppuun oli eri arvo kuin seur. alkuun
 - NjVrk.PAS:   Enterin Beep vex.
 - Moot.PAS:    TaajKaytLb.MouseMove xrHandPoin päälle, muualla PRC NormCur.
 - Globals.PAS: TextBase.NOL -file tehdään jos sitä ei ole ja debug´ssa kysytään poistetaanko, MolaRek.EXE -ajossa
   tehdään uusi (koska sitä ei ole sen EXEn dirrissä ja tekohan käy vikkelästi).
 - DEFS.PAS´sin muutoksia:
      LICENSE_WINDOWS_DIR             => LICENSE_PAADIR   "Nola"
      LICENSE_WINDOWS_LICENSE_DIR     => LICENSE_DIR      "License"
      LICENSE_WINDOWS_LICENSE_DIR_TMP => LICENSE_DIR_TMP  "License.tmp"
      LICENSE_WINDOWS_FILE            => LICENSE_FILE     "License.nos"
 - CalcCreationTime => GetDirCreationTime,  PutHakemistoAika => TeePutHakemistoAikaKoodi.
 - Näiden lisäksi NolaVAR.INC´iin on lisätty useita Win.. / VAL.. muuttujia, joiden sijoituksiss on käytetty em.
   DEF´sejä, ks. Globals.PAS / PRC SijWinValvDIRrit.
   Näiden eri jatkoversioiden nimien eteen on sorcessa sijoitettu mrk å, jottei Search/FindInFiles -haut löytäisi
   turhia vanhoja.
}
'<br><br><b>12.0.0   12.05.2013</b>'+
         SisX_+'Pääteemana on <b>Win7 x32 ja x64 ja niiden jälkeen näköpiirissä olevien versioiden '+
           'yhteensopivuus</b>. NOLAssa käytetyn sovelluskehittimen (Delphi XE2) maahantuojan (Moonsoft Oy) mukaan '+
           'ohjelmat ovat yhteensopivia:  W95, W98, Windows ME, Windows NT, 2000,  XP (x32  ja x64), Vista (x32 ja '+
           'x64),  W7 (x32 and x64), W8 (x32 ja x64), WServer 2003, WServer 2008 (x32 ja x64),  WServer 2008 R2 (x32 '+
           'ja x64), WServer 2012 (x32 ja x64). <br>'+
           'Kehitystyössä käyttö- ja testausympäristönä on koko ajan ollut W7 (2 kpl x64,x32) ja XP (1 kpl x32)'+
         {SisX_+'NOLA on nyt muutettu <b>32 B</b> (esim. Windows XP, Vista/32B, Win7/32B) ja <b>64 B</b> '+
           'yhteensopiviksi (Vista/64B..Win7/64B.}
         SisX_+'NOLA on siis muutettu 32- ja 64-bittisiksi. Ohjelmat voidaan käynnistää yksittäin käsin, mutta <b>NOLA</b> '+
           'tutkii ajettavan koneen käyttöjärjestelmän vaatimukset (32/64B). Jos x64 ympäristössä yritetään käynnistää '+
           'x32 -versiota, NOLA käynnistää x64 -version ja ajo jatkuu keskeytyksettä. Jos x32 ympäristössä yritetään '+
           'käynnistää x64 -versiota, käyttöjärjestelmä <b>ilmoittaa virheestä, eikä ajo jatku</b>.'+
         SisX_+'NOLAn asetukset tallennetaan erikseen käyttäjäkohtaisesti kun aiemmin ne tallennettiin ' +
           'konekohtaisesti. Tällöin verkkolisenssin hakemisto tulee asettaa kullekin käyttäjälle erikseen '+
           'NOLA - Asetukset ikkunassa. Tämä koskee myös konetta, jossa ajetaan NolaNet ohjelmaa.'+

'<br><br><b>11.0.1   18.10.2009/18.01.2010</b>'+
//################################################################################################################
//################################################################################################################
//############################### 11.0.1: ########################################################################
//############################### Mo-osan VrkCmBx:n (mo.moty.Vrk) oletus 1 muu- ##################################
//############################### tettu 0 :ks. Jos ongelmia, etsi: "Vrk" Word. ###################################
//################################################################################################################
//################################################################################################################
         SisX_+'Verkkokuvaajan johtotyyppiä muutettaessa johdinpoikkipintojen pudotusvalikossa esitettiin '+
           'aikaisemmin valitun typpin poikkipintavalikoima, nyt <b>ne esitetään meneillään olevan valinnan mukaan</b>.'+
         SisX_+'AMCMK3½ -kaapeleissa tapahtui Praga NK Cables´illa SFS 6000:n aiheuttamissa tarkistuksissa '+
           'PEN-poikkipintojen muutoksia, kun 25AL ja 35AL -vaihejohtimien <b>10cu:n PEN-johdin muuttui '+
           '16cu:ksi. </b>Koska asennuskannassa on nyt kahdenlaisia kaapeleita samalla tyyppinimellä ja '+
           'samoilla vaihejohdinpoikkipinnoilla, on vanha AMCMK3½ -tyyppi nyt nimetty AMCMK3½o :ksi ja '+
           'AMCMK3½ -merkintä <b>tarkoittaa nyt uuden PEN-poikkipinnan mukaista kaapelityyppiä</b>. Uusi '+
           'tyyppitunniste AMCMK3½o käsittää vain AMCMK 3x25Al/10Cu ja 3x35Al/10Cu kaapelit. NOLA 11.0.1 ja '+
           'tulevia uudempia versioita käynnistettäessä NOLA tutkii verkkokuvaajan kaapelityypit ja jos löytyy '+
           'vanhemmalla NOLAn versiolla tehtyjä ajotiedostoja, <b>25 ja 35 mm²:n AMCMK3½ -tyyppi muutetaan '+
           'AMCMK3½o -tyypiksi automaattisesti</b>, jota ennen vanhasta tehdään varmistustiedosto "-Ver1101" '+
           '-tunnisteella ja siitä tiedotetaan käyttäjälle.'+
         SisX_+'Kaapelityyppivalikoimaan on lisätty Pragan aurattava AMCMK-HD 3x25/16 AN, 3x50/29 AN, 3x95/57 '+
           'AN ja 3x150/88 AN, joiden tunnuksena NOLAssa on käytetty <b>AMCMK3½HD</b>. PE-johdin on Cu.'+
         SisX_+'Kotisivumme hinnastossa on mainittu <b>lääkintätilojen ryhmäjohtopituuslaskennan </b>sisältyvän '+
           'PRO-laajuuteen, mutta on käytännössä edellyttänyt EXTended-laajuutta. Korjattu: PRO-laajuus riittää.'+
         SisX_+'<b><u>Moottorilähtöosassa:</u></b>'+
         SisX_+'Taulukkoon on alapaneliin lisätty <b>taajuusmuuttajakäsittelyn ohjeen </b>aukaiseva '+
           'kehotekohta.'+
         SisX_+'Aikaisemman istunnon jotkut tiedot eivät päivittyneet tiedostostaluvun yhteydessä. Korjattu.'+
         SisX_+'Ensimmäisessä JK:ssa laskettiin aina olevan PT. Nyt se <b>aina etsitään verkosta, jäljemmistä '+
           'vasta </b>jos edellä ei ole riittävän pieni Zpe (Uk>50V). Aikaisemmin laskettiin jäljempiin jos '+
           'niiden Zpe oli pienempi vaikka edellä oleva olisi ollut riittävän pieni. Näistä opastetaan avusteissa.'+
         SisX_+'<b>Pienin Verkkopiste =0</b>, ennen oli rinnakkaislittymälukumäärää vastaava negattiivinen luku '+
           'ja 0 ilmaisi, ettei Uk:ta haluta laskettavan. Nyt 0 :lla ilmoitetaan, jos Uh% -laskennassa (LxSu,'+
           'LxMax) <b>ei haluta huomioida Verkkopistettä edeltävää verkkoa</b>. Muuten verkkoa huomioidaan 1.'+
           'keskukseen asti.'+
         SisX_+'Kosketusjännitelaskennassa (Uk) ryhmäjohdon osuus laskennassa tarkistettu. SFS 6000 / '+
           '413.1.3.5 :n kaavasta ratkaistuna  Uk = Zpe × Uo/Zs, jossa Zpe on moottorilähtökeskuksen ja PT-'+
           'pisteen välisen PE:n impedanssi ja Zs on koko oikosulkupiirin impedanssi ääripisteeseen asti '+
           '(ei maZ). Kaavasta näkee, että kun Zs kasvaa, Uk pienenee. Kun Zs:ään <b>lisätään lasketun '+
           'ryhmäjohdon impedanssiosuus</b>, suhde muuttuu edullisemmaksi ja <b>Uk pienenee tuntuvasti.</b> '+
           'Nyt laskentamenetelmä on yhdenmukainen verkkokuvaajan resurssitarkastelurivien (>22) kanssa.'+
         SisX_+'Verkkokuvaajan johtotietojen syötön arvoikkunoissa vaati kaksi hiirenklikkausta ennen kuin '+
           'syöttötila aktivoitui (versioissa 10.0.3 - 11.0.0). Nyt korjattu yhdellä klikillä aktivoituvaksi.'+

        {SisX_+'Jännitealenemalaskennassa sarakkeille LxSu ja LxMax edeltävää verkkoa huomioidaan nyt vain '+
           '1.:een keskukseen asti.'+
- Rinnakkaisliittymillä ei ole merkitystä mottorilähtöjen Uk ja Uh% (LxSu,LxMax) laskennassa.???}
'<br><br><b>11.0.0   02.03.2009</b>'+
         SisX_+'Vista:ssa, Windows Server 2008:ssa ja tulollaan olevassa Windows 7:ssä, joissain asennuksissa '+
           'myös Windows Server 2003:ssa, on C:\WINDOWS -hakemistoon kirjoittaminen estetty ja se on jälleen'+
           'ohjattu hakemistoon, mistä NOLA ei sitä osannut etsiä, mikä aiheutti lisenssivirheilmoituksia. Nyt '+
           'NOLA tekee C:n juureen C:\VARO_NOLA_LUE_WARNING nimisen hakemiston, minne lisenssitiedot '+
           'kirjoitetaan. <b>Hakemiston LUONTIpäiväys ja aikatiedot eivät saa muuttua</b>, muuten lisenssi '+
           'vioittuu. Hakemiston alla on tiedosto WARNING!.TXT, jossa tekstissä varoitetaan vioittumisuhasta. '+
         SisX_+'Avusteikkunan avautumiskorkeus oli määräytynyt edellisen istunnon korkeuden mukaan, mutta '+
           'rajoitettu avautuessaan max. 400 pixeliin. Nyt rajaksi on asetettu näytön korkeus .200.'+
//Ei näytetä, mutta muutos 2.3.2009: KaikkiOikDirN='C:\TESTMANAGER-FI§$253ENIGMA';  nyt voimassa, otin kommntn vex.
         SisX_+'Ikkunatietojen talletusrekisteri muutettu HKEY_CUURENT_USER :sta HKEY_LOCAL_MACHINE :ksi' +
           '(\Sofware\Nola).'+

'<br><br><b>10.0.7   10.02.2009</b>'+
         SisX_+'Ik3v-napaoikosulkulaskennassa >10.0.4 -versioissa liittymäjohtojen impedanssitekijät '+
           'huomioitiin liian pieninä, jolloin napaIk3:t ilmaistiin liian isoina. Korjattu. '+
           'Suojausehtotarkastelun Ik1v (rivi 6) oli oikein.'+
         SisX_+'Rinnakkaisliittymien vaikutusta (EXTended käyttölaajuus) ei Ik1v-laskennassa aikaisemmin '+
           'huomioitu. Muutettu siten, että rinnakkaiset liittymät aina vaikuttavat koko laskettavaan verkkoon '+
           '(kuten Il3v-laskennassa oli) ja mahd. käyttökytkimien tai erottimien asennot sekä liittymälajien '+
           'pysyvyyden/luotettavuuden arviointi jätetään käyttäjälle.'+
         SisX_+'Rinnakkaisliittyminen impedansseissa laskettiin 1/Z käänteisarvot komponenteittain (1/R+1/jX), '+
           'jolloin isoilla X/R -eroilla kulmavirhe kasvatti kokonaisimpedanssin eroa. Nyt ennen käänteisarvo-'+
           'operaatiota komponenttimuotoinen Z (R+jX) muunnetaan polarimuotoiseksi Z kulmassa arcTan(X/R) ja '+
           'summattaessa osatekijöitä, muunnetaan polarimuotoiset impedanssit ensin komponenttimuotoon '+
           'R=Z × cos(' +FONT_FIIe +') ja X=Z × sin(' +FONT_FIIe +').'+
         SisX_+'Lisättäessä rinnakkaisia liittymiä, PEN_PE -yhdistyslenkiksi sijoittui "1 amcmk4½ 120 .." '+
           'automaattisesti ja sen joutui poistamaan käsin. Nyt se on siirretty pudotusvalikkoon erikseen '+
           'valittavaksi. Tällä vältytään yllättäviltä impedanssien kasvuilta oikosulkulaskennassa.'+
         SisX_+'SVsyst..-kaapelijärjestelmien max.impedanssiarvon käsittelyä on muutettu. Verkkoluvaajan '+
           'rivin 6 johto-osakohtaisista arvopareista ennen kauttaviivaa oleva arvo (Ik1v johdon alussa) '+
           'säilyy ennallaan, mutta max.impedanssiarvon kasvaessa kauttaviivan jälkeinen arvo (Ik1v maxZ-'+
           'kohdassa) pienenee.'+
         SisX_+'Verkkokuvaajan johtotietojen syötön arvoikkunoissa vaati kaksi hiirenklikkausta ennen kuin '+
           'syöttötila aktivoitui (versioissa 10.0.3 - 11.0.0). Nyt korjattu yhdellä klikillä aktivoituvaksi.'+

'<br><br><b>10.0.6   10.12.2008</b>'+
         SisX_+'Päivityslistatarkistus, ei näy käyttäjille.' +

'<br><br><b>10.0.5   08.09.2008</b>'+
         SisX_+'NJ-laskentaosan tulostuksen yleistiedoissa <b>MinSUL/..</b> arvo ilmoitetaan vain, jos suojaus '+
           'voidaan toteuttaa yhdellä sulakkeella eikä useammalla rinnakkaisjohdolla ao. suojineen. Rivin '+
           'selitystekstiä tarkennettu. Vaihtoehtotulostusten <b>IsulMax</b>´in valintaperusteen selitystä '+
           'täsmennetty (' +FONT_PIENPI +' Isal) ja lisätty huomautus, että jäävät kasvuvarat näkyvät seur. '+
           'riveillä.'+
         SisX_+'Samassa ohjelmaosassa <b>MinKatk</b> -arvoksi (johdolta vaadittava kuormitettavuus) näytettiin '+
           'lukemaa, missä ei oltu huomioitu kasvuvaraa (oli laskettu virheellisesti), vaikka selitysteksti '+
           'niin kertoi. Korjattu. Häviökustannusperusteinen kasvuvara oli laskettu oikein.'+
         SisX_+'Verkkoversion edellyttämän NolaNet.EXE:n päälläolotarpeesta tiedotetaan ao. virhetilanteissa '+
           'selkeämmin, jos syy voidaan jäljittää: "...'+CLR_REB +'NolaNet.EXE ei ehkä ole päällä' +FNT_B0 +'"' +

'<br><br><b>10.0.4   16.07.2008</b>'+
         SisX_+'Liittymätietojen apulaskentaikkunan <b>yleinen avusteosa ei herännyt</b> klikattaessa yläpanelin '+
           'alempaa riviä eikä yleistietoa saanut tulostettua panelin tiedoista poiketen. Korjattu.'+
         SisX_+'Em. ikkunaan lisätty SJ- ja PJ-liittymän Ry, Xy:n laskenta sellaisia tapauksia varten, missä '+
           'liittymän (ylä)verkkotiedoista on <b>saatu vain Ik ja ' +cosf +'</b>. Tämä löytyy apulaskenta'+
           'ikkunan yläpanelin painikkeesta "<b>Muut keinot</b>". Painikkeen ja avautuvan valikon avuste '+
           'kertoo toiminnat. Kaikki apulaskentaikkunan algoritmit on tarkistettu ja päivitetty.'+
         SisX_+'Johto- ja liittymätietojen arvoikkunoiden merkkijonot muuttuivat aktiivisiksi ja joskus myös '+
           'painikeklikkaukset heräsivät vasta toisella hiirenklikkauksella. Muutettu yhdellä klikillä '+
           'tapahtuvaksi.'+
         SisX_+'Liittymä- ja johtotietojen arvojen syöttöikkunan käyttöjärjestelmän oma ikkunansulkupainike '+
           '(X-painike oik. yläkulmassa) ei kumonnut tehtyjä muutoksia kaikissa tilanteissa. Muutettu niin, '+
           'että ikkunan <b>sulkeminen aina hylkää kaikki muutokset</b>.'+
         SisX_+'Moottorilähtöosassa valittaessa "NJ Laskenta", NJ-parametrien syöttöikkunaan tultaessa tuli '+
           'varoitus laskentapisteen määrittelyerosta Moottorienkäsittelyosan ja NJ-parametri-ikkunan välillä. '+
           'Nyt arvo <b>muutetaan automaattisesti parametri-ikkunaan</b> ja muutoksesta tiedotetaan.'+
         SisX_+'Katuvalojohtojen laskennan (Verkkolaskenta / NJ Laskenta => NJ-laskentaparametrien ikkunasta Alt+'+
           'NJ Laskenta) ao. selitystekstit ja kuvaukset on uusittu paremmin ymmärrettäviksi, ks.   ..\NOLA\Data\'+
           'Katuvalo\Katu.TXT.   <b>Laskennan valintapainike on lisätty </b>päävalikkoon, vanha käynnistystapa '+
           '(em. Alt+NJ Laskenta) on myös säilytetty ennallaan.'+
         SisX_+'Verkkokuvaajan rivin 31 (Lääkintä-IT) resurssipituuksien viimeisen arvon tilalle tulostui '+
           'rivin 20 (Yliv.As.D) arvo. Korjattu.'+
         SisX_+'Verkkokuvaajan yläpanelin "<b>T/Zpe r>22" Ltim tai Lzpe</b> -resurssilaskennan vaihtoehtojen '+
           'valinnoissa Lzpe -pituus tulostettiin vain, jos Zpe-ehdon mukainen pituus oli suurempi ja jos Zpe-'+
           'ehto ei täyttynyt, eli vastakkaiset ehdot, joten Lzpe-valinnan mukainen pituus ei tullut koskaan '+
           'esiin. Nyt <b>tämä pituus näytetään aina valinnan mukaan </b>täyttyi Zpe-ehto taikka ei. Zpe -'+
           'laskentaperuste ilmaistaan pituusluvun perässä näkyvällä yläindeksillä ¹ ja jos eroja '+
           'poiskytkentäajan perusteella laskettuun pituuteen (Ltim) ei ole, näytetään vielä perään aste(nollan) '+
           'merkki, siis esim. 43.4m¹°.' +
         SisX_+'Lisättäessä verkkokuvaajaan johto-osia nro>6, tuli turhaan lukualueen virheilmoitus. Korjattu' +

'<br><br><b>10.0.3   24.02.2008</b>'+
         SisX_+'Jos verkkokuvaajassa ei ole kuin liittymäjohto, oikosulkusuojien rajoittamat ehdolliset'+
           'Ik3th ja Ik3d -arvot (rivit 8,9) näytettiin <b>'+COLOR_IK3D_ +'(- - - / ..) </f></b>. Nyt viivojen '+
           'tilalle lasketaan liittymistä (jos useita rinnan) suurimman löytyneen oikosulkusuojan mukaan. Huomaa, '+
           'että esim. kiskostoille NOLA ilmoittaa oikosulkusulakkeeksi 0 (- - -..), koska arvot ovat >1250 A).'+
         SisX_+'Verkkokuvaajan rivien 8, 9 ja 10 avusteisiin on lisätty havainnolistava kuva sulakkeiden ja '+
           'ehdollisten Ik3th ja Ik3d sekä OFAA -arvojen riippuvuuksista. Tämä on valittavissa avusteen '+
           'lehdeltä<b> "Rvt 8..10 selit.kuva"</b>, muuten näytetään oletusarvoisesti <b>"Avuste"</b>-lehdellä '+
           'tutut avusteet. Kuva selittää asiat näppärästi jo yleissilmäyksellä, vaikeatajuiseen sanalliseen '+
           'kuvaukseen ei välttämättä enää tarvitse syventyä.'+
         SisX_+'Hiirtä liikutettaessa verkkokuvaajan riveillä, cursorin alle on lisätty näkymään hetken aikaa '+
           'vihje (hint), että <b>"Klikkaus lukitsee, kaksoisklikkaus vapauttaa avusteen"</b>. Tällähän on aina '+
           'ennenkin päässyt asettelemaan avusteikkunaa.'+
         SisX_+'Versiosta 6.2.0 lähtien on liittymäjohtojen oikosulkusuojan oikosulkuvirtaa rajoittavan '+
           'ominaisuuden laskemisessa huomioitu sulake yhtenä arvona myös useammalla rinnakkaisella '+
           'liittymäjohdolla, muualla verkossa on sulakemäärä (3v) 1 kun johtoja ' +FONT_PIENPI +' 2 ja '+
           'muulloin rinnakkaisjohtolukumäärän mukainen. Nyt myös liittymäjohtojen sulakemäärät huomioidaan '+
           'saman periaatteen mukaan, minkä takia '+ COLOR_IK3D_ +'<b>rivien 8..10 sulkeissa esitetyt arvot '+
           'eivät ole vertailukelpoisia aikaisempien versioiden tuloksiin, virta-arvot kasvavat '+
           'merkittävästi.</b></f> ' +COLOR_BLUE +'(Käyttäjän havainto).</f>'+

'<br><br><b>10.0.2   16.02.2008</b>'+
         SisX_+'Verkkolisenssin virheilmoituksen tietosisällön täsmennys. Ei toiminnallista muutosta.' +

'<br><br><b>10.0.1   17.12.2007</b>'+
//Kokeilinkin jo ja sulakkeet (rivit 13-15) muuttuivat esim. AMCMK 3½  185 kun korj=0,8   => asA=160 A (oli 100), asC=200 A (125 A),  asD=200 A (160 A).
         SisX_+'Johtojen <b>kuormitettavuus- ja korjauskerrointaulukot on uusittu kokonaan </b>(ks. '+
           'verkkokuvaajan johto-osien pudotusvalikko / rivi 7: valintataulukko) ja vastaa nyt SFS 6000 (v.2007). '+
           'Edellinen versio oli A2:n mukainen. <b>Verkkokuvaajan tulostusversiossa '+
           'on tästä varoitus </b>(tulosteet eivät ole vertailukelpoisia aikaisempiin nähden). Yhteenvetona '+
           'kuormitettavuuksista: asennustavalla A kuormitettavuusarvot ovat pienentyneet, C :llä pysyneet '+
           'entisellään ja D :llä kasvaneet, poikkeuksiakin on, erot +/- ~10%.'+
         SisX_+'Verkkokuvaajan johto-osien <b>korjauskertoimien käsittelyä on muutettu.</b> Sen lisäksi, mitä '+
           'käyttäjä oli mahd. pudotusvalikosta valinnut ryhmäasennuskertoimen osana tai muuten syöttänyt '+
           'tähän arvokohtaan, NOLA otti automaattisesti vielä itsekin sen huomioon, joten johdon '+
           'kuormitettavuus laski entisestään. Muutos vaikuttaa vain niillä johto-osilla, joissa oli 2 tai '+
           'useampia rinnakkaisia johtoja, eli kuormitettavuus paranee / sulakearvot kasvavat.'+
         SisX_+'Detaljit -tulostuksessa 10 A MMJ 2,5 mm²:n resurssipituuksina ilmoitettiin tiedoston '+
           'alustettuja arvoja 0 m, eikä laskettuja todellisia pituuksia ao. kommentteineen "OK / eiOK".'+
         SisX_+'Sulakkeiden tarkastelussa valittaessa Ik-taulukko, klikattaessa jotain arvoikkunaa, avautui '+
           'sulakkeiden pudotusvalikko päälle. Korjattu.'+
//=========================================================================

//Sul j2 3 AMCMK3½ 185
//Nyt k=1:    asA=160  asC=200  asD=250
//Oli k=1:    asA=125  asC=160  asD=200

//Nyt k=0.8:  asA=125  asC=160  asD=200
//Oli k=0.8:  asA=100  asC=125  asD=160
'<br><br><b>9.0.1   30.05.2007</b>'+
         SisX_+'<b>Zpe -ehtotarkastelua on muutettu.</b> A2:n julkistuksen jälkeen ennen sen voimaantuloa '+
           '(1995) tulkitsimme (silloisen) NolaWin´in ensimmäiseen versioon kohdan 413.1.3.5 :n Zs :n '+
           'laskentatarpeen niin, että se laskettiin resurssitarkasteluissa (verkkokuvaajan rivit 23...) '+
           'jakokeskukseen asti, <b>eikä siitä jatkuvan ryhmäjohdon etäisimpään pisteeseen asti</b>, '+
           'jolloin Zpe '+ FONT_PIENPI +' 50 × Zs / Uo -ehtotarkastelun tekijä Zs jäi ryhmäjohto-osuuden verran '+
           'liian pieneksi nykyiseen tulkintaan verrattuna. Tämä ns. Zpe -ehtotarkastelu on säilynyt ennallaan '+
           'kunnes aivan äsken eräs käyttäjä havaitsi epäloogisuutta tuloksissa. Suoritetuissa tarkistusajoissa '+
           'ero tuli esiin ja ohjelmaa on nyt muutettu niin, että Zs :n laskenta tehdään ryhmä- yms. johdon '+
           'etäisimpään pisteeseen '+CLR_BLB +'JA tarkistus tehdään aikaisemman 5 s:n poiskytkentäajan '+
           'sijasta 0.4 s:n ryhmäjohdoille ' +FNT_B0 +'(rivit 27...30 '+FONT_OIKEALLE +' 23...26). Vaikutus '+
           'näkyy siten, että em. verkkokuvaajan resurssitarkasteluriveillä varoitus ' +CLR_REB +'P ' +FNT_B0 +
           'tulee huomattavasti harvemmin esiin, eli '+CLR_REB +'ehto "helpottuu",' +FNT_B0+ ' vaikka pituudet '+
           'lyhenevät pienemmän poiskytkentäajan 0.4 s takia.'+
         SisX_+'Yläpaneeliin on lisätty boxi ("<b>T/Zp r>22</b>") resurssipituuksien (rivit 23...35) '+
           'laskentatapojen valintaan. Valinnalla "<b>Ltim</b>" lasketaan kuten ennenkin poiskytkentäajan '+
           'perusteella, eli pituus, millä poiskytkentäaika vielä toteutuu ja valinnalla "<b>Lzpe</b>" '+
           'lasketaan pituus, millä Zpe -ehto vielä toteutuu. Ks. rivin 22 avuste.' +
         SisX_+'Em. rivien (23...) varoituksista '+CLR_REB +'TUP' +FNT_B0 +CLR_GRB +'X' +FNT_B0 +' on T ja U '+
           'jätetty pois, koska jos poiskytkentäaika ei toteudu (' +CLR_REB +'T' +FNT_B0 +'), ei ZsIa '+
           '-ehtokaan ('+CLR_REB +'U' +FNT_B0 +') toteudu ja merkintä "- - - -" ilmaisee jo saman (L=0 m), eli '+
           'nyt varoitusmerkit voivat olla enimmillään '+CLR_REB +'P' +FNT_B0 +CLR_GRB +'X' +FNT_B0 +'.'+
         SisX_+'<b>Rivin 11 "Suojausehdot sallivat" -rivin tulostusta on muutettu:</b>  rivillä ilmoitetaan '+
           'nyt max.sulakkeet molemmilla, <b>sekä 5 että 0.4 s</b> :n poiskytkentäajoilla, esim. ' +CLR_BLB +
           'MaxSul: 5 s=250 A \ .4 s=125 A' +FNT_B0 +'. Arvoista on nyt helppo todeta, edellyttääkö '+
           'todellisessa verkkotilanteessa valittu sulake PT- tms. lisäsuojaustoimenpiteitä em. '+ CLR_REB +'P' +
           FNT_B0 +'-varoituksen takia. Tulostuserittely on tarpeellinen vain KULuttajan johto-osuuksilla, '+
           'sähkölaitoksen jakeluverkon johto-osilla tulostus on ennallaan.'+
         SisX_+'Päävalikon "<b>Ohjeet / Tietoa</b>" välilehdelle "<b>Ohjelman siirto, poisto, varmistus</b>" '+
         'on ' +CLR_BLB +'lisätty ohjeet NOLAn varmuuskopion tekemiseksi '+FNT_B0 +'käyttöoikeuden '+
         'palautusmahdollisuuden turvaamiseksi ja välilehdellä <b>"Asennus- ym. ohjeita, rajoituksia"</b> on '+
         CLR_BLB +'verkkolisenssin asennusohjeita täydennetty.'+

'<br><br><b>8.0.14   16.04.2007</b>'+
         SisX_+'Varavoimaliittymien arvoikkunoissa päivittyminen ei kaikilla riveillä toiminut luotettavasti, '+
           'korjattu ja muidenkin littymätapojen arvoikkunoiden käsittely uusittu ja toiminnat varmistettu.'+
         SisX_+'Verkkokuvaajan Un ja cU -arvoikkunoiden käsittely oli karsiutunut pois, eli arvoja ei saanut '+
           'näkyviin lainkaan, korjattu.'+

'<br><br><b>8.0.13   12.04.2007</b>'+
         SisX_+'8.0.12 korjauksessa jäi testausasetuksista virhe, mikä esti arvojen päivittymisen '+
           'syöttöikkunoihin, korjattu.'+

'<br><br><b>8.0.12   08.04.2007</b>'+
         SisX_+'Liittymätietojen alin arvoikkuna (PEN+PE :n yhdistämistiedot) eikä varavoiman rivi 11 '+
           'päästänyt muuttamaan arvoaan, korjattu.'+

'<br><br><b>8.0.11   12.03.2007</b>'+
         SisX_+'Johto-osien tietodialogin pudotusvalikot eivät heränneet aina toistuvissa valinnoissa ilman '+
           'ylimääräisiä hiirenklikkailuja, korjattu.'+
         SisX_+'Verkkokuvaajan riveillä <b>32 ja 33 </b>on aikaisemmin esitetty ao. johto-osan max.pituudet '+
           '<b>asennustavalla A.</b> Nyt asennustapa on tehty valittavaksi yläpanelin "<b>NjAs r32..</b>" '+
           '-arvoikkunassa (A/C/D). Arvoista päästään nyt havainnollisesti seuraamaan pituuden muuttumista '+
           'lähestyttäessä rivien 34,35 MaxSul -arvoja (rivi 11: Suoj.ehdot sallivat).<br>'+
           'Ominaisuus on lisätty käyttäjän tarpeesta.'+

'<br><br><b>8.0.10   15.11.2006</b>'+
         SisX_+'Liittymätapakäsittelyssä peruttaessa tehtyjä liittymätapa- tai arvovalintoja "Sulje" -'+
           'painikkeella, suoritetut valinnat eivät kaikissa tilanteissa peruuntuneetkaan, esim. jos SJ-'+
           'liittymän vaihtoi UPS´iksi, jäi valinta voimaan "Sulje" -valinnasta huolimatta. Korjattu.'+
         SisX_+'UPS-liittymätapavalinta ohjasi laskennan varavoimaliittymän laskentaan, mikä aiheutti '+
           'puuttuvien muuttujien takia "Floating point division by zero" -virheilmoituksen. Korjattu.'+
         SisX_+'Poistettaessa rinnakkaisia liittymiä (EXTended laajuus) ei tietorakenne pysynyt kaikilta '+
           'osin ajan tasalla aiheuttaen joissain tilanteissa niinikään "Floating point division by zero" '+
           '-virheilmoituksen. Korjattu.'+

'<br><br><b>8.0.9   06.10.2006</b>'+
         SisX_+CLR_REB +'Pikakorjaus:' +FNT_B0 +'  Laskettaessa termistä oikosulkuvirtaa Ik3th´ta käytettiin '+
           'lausekkeessa ' +FONT_2JUURI +'[(m+1) × Tim]  aikatekijänä (Tim) valittua poiskytkentäaikaa, eikä '+
           'sitä rajoitettu 1 s :iin kuten aikaisemmin tai myös jos sulake toimii tätäkin lyhyemmässä ajassa. '+
           'Tämä kasvatti laskettua arvoa merkittävästi jos poiskytkentäajaksi oli valittu 5 s. Korjattu.'+

'<br><br><b>8.0.8   03.10.2006</b>'+
         SisX_+'Generaattorien oikosulkulaskenta muutettu standardiparametreille ja (varavoima)generaattori'+
           'liittymä muutettu omaksi valinnakseen: SJ,PJ,Vv,UPS, joista muut paitsi UPS-liittymät voivat olla '+
           'toisilleen rinnakkaisia (max. 5 kpl) NOLAn EXTended versiossa. Epästandardeista suureista on '+
           'ao. rivillä kuvallinen avuste. Verkkokuvaajan " ? " -painikkeeseen on lisätty selventäviä kuvia.'+
         SisX_+'Verkkokuvaajan 6. rivin Ik1v alussa/max.imped.pisteessä viimeisen johto-osan max.impedanssi-'+
           'piste on versiosta 6.2.21 lähtien laskettu olevan johto-osan lopussa. Nyt se on muutettu takaisin '+
           'maxZ-pisteeseen, mikä rinnakkaiskaapelilukumäärän ollessa >2 on ennen johto-osan loppua (ks. '+
           'ao. kohdan avuste).'+
         SisX_+'Lääkintätilojen muuntajan ja 0.2 s:n pistorasiaryhmäjohtojen testausasetus oli jäänyt '+
           'epähuomiossa päälle, minkä takia 5 s:n ryhmäjohdot esitettiin saman pituisina kuin 0.4 s:n.'+
         SisX_+'Resurssitarkastelurivin 33 sulakkeeksi on aikaisemmin sijoitettu avusteesta poiketen rivin 11 '+
           'sulake (suojausehtojen sallima), nyt korjattu rivin 13 sulakkeeksi (asA:n maksimisulake).'+
         SisX_+'Resurssitarkastelurivien 27...30 laskentaperusteet on muutettu. Aikaisemmin tutkittiin, '+
           'toimiiko 16 ja 10 A:n sulakkeet <0.4 s:ssa, mutta oli unohdettu, että näiden rivien ryhmäjohdon '+
           'pituus laskettiin 5 s poiskytkentäajan mukaan, jolloin Zpe-ehto täytyy tarkistaa. Nyt näillekin '+
           'riveille tulee punainen ' +CLR_REB +'P' +FNT_B0 +' jos PT:tä ei löydy riittävän läheltä (ks. rivin '+
           '22 avuste) eli 413.1.3.5 -ehto ei täyty.'+

'<br><br><b>8.0.7   1.06.2006</b>'+
         SisX_+'Verkkokuvaajan arvotaulukkoon on lisätty rivi 31, missä on laskettu jakokeskukseen lisätyn '+
           'erotusmuuntajan (2 ja 7.5 kVA) perään asennettavan 2.5 mm²:n ryhmäjohdon max.pituudet kahdella '+
           'tavalla kahdessa samanaikaisessa vikatapauksessa IT-järjestelmässä:  2j) vikavirta kiertää '+
           'jakokeskuksen kautta  1j) vikavirta oikaisee toiseen vikapiiriin lisäpot.tasauksen kautta. '+
           'Kytkentäkaava on esitetty <b>"?"</b> -painikkeen <b>"LääkMuunt-IT"</b> välilehdellä. Ominaisuus '+
           'edellyttää EXTended laajuutta.'+
         SisX_+'<b>"?"</b> -painikkeen avusteisiin on lisätty välilehdet em. <b>"LääkMuunt-IT"</b> sekä '+
           '<b>"RinnakLiit"</b>, missä kuvataan rinnakkaisliittymän (tämäkin ominaisuus edellyttää EXTended '+
           'laajuutta) kokonaisimpedanssin laskentaperiaate.'+
         SisX_+'Rivien 32..35 laskentaa muutettiin versiossa 6.2.2 pv 2.03.2004 siten, että se ilmaisee '+
           'ao. pääjohdon resurssit. Avusteissa kuvataan, että sähkölaitoksen osuuksilla pituus lasketaan '+
           'sulakearvojen perusteella. Tässä oli tapahtunut virhe siten, että sulakearvoa käsiteltiin '+
           'yksinkertaisina, eikä >63 A:n sulakkeilla 3x ja muilla 2.5-kertaisina oikosulkuvirtaa määrättäessä. '+
           'Nyt tehty korjaus <b>supistaa sähkölaitoksen em. nollausehtojen mukaan laskettuja pituuksia '+
           'merkittävästi </b>(esim. 23 km => 7 km). Jotta sähkölaitoksen sulakkeen 3x tai 2.5x monikerran '+
           'määräämät johtopituudet erottuisivat kuluttajan suojausehtojen määräämistä, on pituusarvon '+
           'dimension perään lisätty vaatimaton merkki ¨, ks. ao. avuste. '+
           '   Näillä riveillä kuluttajan johto-osilla tarkistetaan ZsIa -ehto (413.1.3.3). Aikaisemmin '+
           'resurssipituudeksi ilmoitettiin tämän ehdon rajoittama pituus, mutta yleisemmin rajoittava tekijä '+
           'tässäkin on poiskytkentäaika, minkä takia <b>nyt ZsIa:n rajoittama pituus ilmoitetaan vain, jos se '+
           'rajoittaa johtoa lyhyemmäksi kuin poiskytkentäaika</b> (=tuskin koskaan). Tämän takia peräkkäisten '+
           'johto-osien resurssipituudet näillä riveillä ovat loogisempia kuin aikaisemmin. Esim: jos rivillä '+
           '32 ilmoitetaan max. pituudeksi 657.1 m ja johto-osan pituus on 656 m, seur.johto-osassa (jos johto '+
           'jatkuu samanlaisena) ilmoitetaan pituudeksi 1.1 m.'+
         SisX_+'<b>Päävalikko / Asetukset / Demo -välilehden laajuusvalinnan toimintaa on laajennettu niin, '+
           'että valinnalla päästään kokeilemaan eri laajuusvaihtoehtoja myös alaspäin, esim. EXTend´istä '+
           'PROfessional´iin tms.'+
         SisX_+'Muutoshistoriaa on lyhennetty tästä ikkunasta muistitilan säästämiseksi. Historia ylettyy '+
           'nyt <b>versioon 5.0.0   25.09.2001</b> asti, vanhempien kuvaukset löytyvät kotisivultamme linkistä '+
           '"<b><u>Versiomuutokset</u></b>".'+
         SisX_+'Näiden avusteiden rivityksessä on vaivannut koko NOLAn Windows-historian ajan <b>sisennyksen '+
           'sattumanvarainen toimivuus, johon nyt löytyi ilmeisesti ratkaisu.</b>' +

'<br><br><b>8.0.6   23.04.2006</b>'+
         SisX_+'Verkkokuvaajan "Lisää" -painikkeen johto-osien valintajärjestys muutettu: oletukseksi lisätään '+
           'aina johtoketjun viimeiseksi. <b>Väliin lisättäessä LIITTYMIÄ </b>(EXTended laajuus), johto-osiin '+
           'kopioitui edellisen johto-osan tietoja virheellisesti. Korjattu.'+
         SisX_+'Version 8.0.1 jälkeen verkkokuvaajan kirjakuvakkeella varustettu <b>palstan supistuspainike</b> '+
           'ei toiminut. Korjattu.'+
         SisX_+'Verkkokuvaajan "?" -painikkeen avusteita on lisätty rinnakkaisliittymien vaikutustiedoilla '+
           '(välilehti "Vihjeitä").'+

'<br><br><b>8.0.5   11.04.2006</b>'+
         SisX_+'<b>Vaihdettaessa näytön resoluutiota</b>, uudessa ajossa ei kaikki ikkunat mahtuneet näyttöön. '+
           'NOLA on kyllä tarkistanut tapaukset, joissa x/y-asetus ohjaa ikkunan ohi näytön, mutta se ei '+
           'tunnistanut liian isoa ikkunaa resoluution muutoksen jälkeen.'+
         SisX_+'<b>"Ohjeet/Tietoa"</b> avusteen "Ohjeita ongelmiin" -lehdelle on lisätty käyttöjärjestelmän '+
           '<b>W2003 verkkokäytön</b> ongelman ratkaisuvihjeitä.'+
         SisX_+'<b>Verkkolaskennan <b>"?"</b> -painikkeen avusteisiin on lisätty lehdet: <b>'+
           '"Pähkinänkuoressa", "Yleiset toimintaohjeet", "Vihjeitä" ja "Esimerkit".</b> Vihjeisiin on '+
           'jatkossakin tarkoitus koota mm. käyttäjiltä tulleita käyttövihjeitä ja muualla hajanaisesti '+
           'olleita ohjeita. Esimerkit on otettu <b>ensikäyttäjien</b> toiveista mukaan.'+
         SisX_+CLR_BLB +'NOLAn käyttämien hakemistojen käyttöoikeusrajoituksia ja vaatimuksia on nyt kuvattu '+
           'yksityiskohtaisesti ja Windows 2003 SERVER´in käyttäjille' +FNT_B0+' on lisätty ohjeita <b>'+
           '"Päävalikko / Ohjeet/Tietoa / Asennus- ym. ohjeita, rajoituksia"</b> -lehdelle kohtaan <b>"OHJELMAN '+
           'ASENNUS- JA KÄYTTÖEDELLYTYKSET".' +
{Systeemihakemistoon (tyypillisesti C:WINDOWS), mihin NOLA tekee '+
           'käyttöoikeusmerkintöjä, W2003 kirjoittaa virtuaalisesti, jolloin tiedot menevät esim. '+
           'C:\Documents and Settings\käyttäjätunnus\WINDOWS, ellei virtualisointia ole valittu pois.'+}

'<br><br><b>8.0.4   06.03.2006</b>'+
         SisX_+'Käynnistäminen neitseellisessä koneessa sai aikaan virheilmoituksen, koska järjestelmässä '+
           'ei ole vielä ikkunatietoja. Korjattu: ohjelma tarkistaa ennen avausta, onko ao. ikkunaa ollut '+
           'olemassa ja operoi vasta sen tiedon perusteella.'+
         SisX_+'NJ-laskennan <b>tulostusvaihtoehdoissa ve-1 :tä</b> ei saanut tulostettua erikseen. Samoin '+
           'mielivaltaiset, ´maalatut´ osatulosteet tai viimeisen vaihtoehdon erillistulostus ei onnistunut. '+
           'Korjattu.'+
         SisX_+'Versiossa 6.0.0 oltiin käyty laajasti läpi jakolaskun ja juurilausekkeiden laskennat '+
           'mahdollisten virhetilanteiden, esim. "Real diveded by zero" tms. välttämiseksi. NJ-laskennassa oli '+
           'loistehon Q = ' +FONT_2JUURI +'(S²-P²) laskennan parametrien ehtotarkistuksissa tutkittu, että S>P '+
           'ennenkuin juurilauseke lasketaan, muuten <b>Q :lle annettiin arvo P</b>. Tämä johti virheelliseen '+
           'tulokseen, jos cos=1, kun toisaalla taas lasketaan: S = '+FONT_2JUURI +'(P²+Q²) ja se taas <b>'+
           'kasvatti minimisulaketta virheellisesti</b>. Korjattu: arvojen oikeellisuus tarkistetaan '+
           'vertaamalla, että 0 < cos <= 1 ja nyt lasketaan S = P/cos.'+
         SisX_+'Em. virhe tuli esiin erään käyttäjän havaittua, että 188 A:n kuormalle NOLA ilmoitti '+
           '(NJ-laskentatulosteessa) minimisulakekooksi 315 A. Ero on silmiinpistävä semminkin, kun vieläkin '+
           'on usein käsitys, että sulakkeen saa valita nimelliskuormitusvirtaa vastaavaksi. Näinhän asia ei '+
           'ole, ks. SFS 6000 (A2)/ 443.2. Nämä ehdot on esitelty ymmärrettävämmässä muodossa NOLAn "<b>'+
           'Impedanssit / A2"</b> osassa, mistä yleisimpänä tilanteena on hyvä muistaa sulakekertoimen arvo '+
           '0.904, mikä palauttaa mieliin StM:n (A1) aikaisen yleisen käytännön, missä kuormituskertoimen '+
           'ollessa 0.9 katsottiin, ettei johto ollut täyteen kuormitettu ja kuormitettavuuden korjauskertoimia '+
           'ei tarvinnut laskea.'+

'<br><br><b>8.0.3   14.02.2006</b>'+
         SisX_+'Liittymätietojen apulaskentaikkunan laajemman avusteen esiin saanti vaati ylimääräisen hiiren '+
           'liikautuksen muualle ikkunassa. Korjattu. Laajan avusteen tulostusmahdollisuus lisätty '+
           '(yläpanelin Ctrl + DblClick) ja syöttötapahtumakohtaisten avusteiden tulostettavuutta "herkistetty", '+
           'liittymätietojen rivien avusteiden lukitusmahdollisuus lisätty (lukittuu nyt kuten muualla '+
           'kuvaajassa).'+
         SisX_+'Verkkokuvaajan arvojen syöttötapahtumien avusteikkunan koon säätö on muutettu '+
           'alapanelin nuolipainikkeille "<b>Avust on/ei</b>" -valinnan viereen. Avusteikkunan asetusten '+
           'talletus/luku tarkistettu (avasi ikkunan aina ruudun alalaitaan).'+

'<br><br><b>8.0.2   8.12.2005</b>'+
         SisX_+'Moottorilähtöjen käsittelyosassa mentäessä mihin tahansa arvosarakkeeseen, siitä yritettäessä '+
           'siirtyä muuhun sarakkeeseen/arvokenttään, arvotarkistukset ohjautuivat liittymän johto-osan '+
           'tarkistusosaan, jolloin ohjelma ei päästänyt eteenpäin ja vaati (virheellisesti) arvon korjausta.'+

'<br><br><b>8.0.1   1.12.2005</b>'+
         SisX_+'Eräillä verkon liittymätilanteilla, mikä sattuu olemaan pohjana, kun muutetaan liittymää UPS´'+
           'iksi, tulee käyttöjärjestelmätason virheilmoitus: "Floating point overflow". Virhe pystytty '+
           'havaitsemaan ja korjaamaan (reaktanssiosuuden alustamattomuus) asiakkaalta saadun .NOE -tiedoston '+
           'perusteella.'+
         SisX_+'Kun verkon johto-osia ei ole yhtään, vain liittymän johto, lisättäessä johto-osia (alapanelin '+
           '"Lisää" -painike), tulee lukutapahtuman virheilmoitus. Tämä johtuu siitä, että ohjelma oli koodattu '+
           'kopioimaan olemattoman johto-osan tietoa. Nyt kopioituu vastaavassa tilanteissa viimeisen '+
           'liittymäjohdon, muulloin edellisen johto-osan tiedot.<br>'+
           '   Lisättäessä johto-osia, tuli laskentavaiheessa ilmoitus "NOLA ei tunne johtotyypin äärijohdinta '+
           '1.0 mm² vastaavaa PE/PEN-johdinta. Laskenta ei ole luotettava.", minkä jälkeen tuli sama "Floating '+
           'point overflow" -virhe, minkä syynä oli niinikään virheellinen johto-osien sisäinen osoitus.'+
         SisX_+'Käyttäjältä tuli perusteltu epäily, että liittymätietojen muuntajien häviösarjojen mukaiset '+
           'Ik3v -arvot ovat ristiriitaisia; normaaleilla kuormitushäviökriteeleillä suunniteltu muuntajan '+
           '(Srj 2) pitäisi antaa isomman oikosulkuvirran kuin alennetuilla tyhjäkäyntihäviökriteereillä '+
           'suunniteltu (Srj 1) muuntaja, kun muuntajakoko on 1000 kVA. Tarkistusta hankaloittaa se, että NOLAN '+
           'häviösarjaluokituksen 11 ja 12 (vuosikerta <1993) impedanssit on ABB:ltä saatu absoluuttisina '+
           'arvoina mutta uudempien muuntajien (Srj 1 ja 2) arvot on annettu nykytyylin mukaan suhteellisina '+
           'arvoina (esim. Rm = Rk[%] * Un²[V]² / (100*Sn[kVA]*1000)   [=ohm/vaihe] 2000 kVA:iin asti). '+
           'Suoritetun tarkistuksen mukaan NOLAn laskemat arvot eli siis muuntajien komponenttiarvot ovat '+
           'oikein. NOLA ilmoittaa :<br>'+
           '   Ik3v:  Srj 2 = 24.04 kA  Srj 12(-93) = 20,62 kA<br>'+
           '   Ik3v:  Srj 1 = 21.33 kA  Srj 11(-93) = 23,98 kA, kun yläverkon impedanssit ovat alkuperäisen '+
           'oletuksen mukaisia, mitkä siis on nyt tarkistettu ja todettu oikeiksi tuloksiksi.'+

'<br><br><b>8.0.0   08.11.2005</b>'+
         SisX_+'Lääkintätilojen pistorasialähtöjen (0.2 s) laskentamahdollisuus on lisätty. Valintaa 0.4/0.2 '+
           's varten yläpaneliin on lisätty ao. painikkeet. Näytöllä vastaava rivi (23) esitetään '+
           COLOR_FUCHSIA +'poikkeavalla värillä.</f>'+
         SisX_+'Rinnakkaisliittymien laskentamahdollisuus on lisätty. Tämä ominaisuus edellyttää <b>EXTended '+
           '-käyttöoikeuslaajuutta</b>. Rinnakkaisliittymien vaikutus huomioidaan myös napaoikosuluissa.'+
         SisX_+'Ohjelman kehityksen myötä käynnistymisen ottama aika on venynyt häiritsevän pitkäksi. '+
           'Ohjelmakoodin optimoinnin jälkeen olemme saaneet <b>käynnistymisen nopeutumaan omassa '+
           'laiteympäristössämme n. 74%</b>.<br><br>'+
                                 //Tähän väliin kuuluu teksti:  E:\Projektit\NolaKehi\SRC\GlobINC\Avuste-EdVersiot.INC,
                                 //joka piti siirtää pois, koska aiheutti selittämättömiä toimintaeroja.
         {SisX_+}''+
'</in>'), //<Sisennyksen lopetus, SisVex_´iä ei onaa käyttää.???
//   SisVeX_), //<+8.0.7 PRC SisX_´stä poistettiin alusta '</in>' joten se on tässä nyt tehtävä jotta sis. ei jäisi.
//''Avu_0_Versiot/Avuste.INC''§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§

