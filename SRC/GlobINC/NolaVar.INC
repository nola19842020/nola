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

{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NOLAvar.INC }
VAR
   KahiFile  :KahiFileType;    //<KAAP.HINTATAULUKON <<<<<<<<<<<<<<<<<<<<<<<<
   eiKahiFile  :Boolean;       //<Tulostusohjauksessa
   kahitau   :tautyp;          //<Esim. kahitau[1].MK.oh  -> ...€/m
                                     // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   tyh_JK :NJjkTiedot;{<?¤?}         //<Alustettu jk-tietue <<<<<<<<<<<<<<<<
   nj,njf,nj0,nju :jkYHTtype;        //<NJ=Tietojen keruu  NJF=Filesta luettu  NJ0=Istunnon alussa, NJU kun jkVE=1
   NjFile  :TIniFile;
   NjFilen :string;                  //<NjF+Nj0.. NjVrk.PAS :ssa
   NjFileCreated :string;

   VExKrt :integer; //=6{2};         //<Yhdellä laskentakrlla tulostuvien VE:jen lkm
   kesno,kesja :integer;             //<Keskuksen "n:o", keskuslkm ketjussa = jk[].ketjussa
{=}Ptas,Qtas,{@+}Stas                //Tasoit.kokon.PÄTÖ-,LOIS- ja NÄENNÄISteho ao. kesk :n kohdalla
        :ARRAY [1..kesmax] of real;  

{=}tas  :ARRAY [1..kesmax] OF real; //Tasauskertoimet k1... tähän
{=}Pskok, Qskok, Sskok,{@Iskok,}Akok :real;  //<Akok = tot. ryhmitysala =0, jos jokin ala puuttuu !,
{@ kokalask,}NJlaji :Boolean;       //<FALSE jos ei yhtäkään ala-arvoa annettu @=Akok=0 korvaa
   NJtyp   :string;                 //<'V','M','C'...'Z'
   NJkaapx :integer;                //<Kaapelilukumäärä
   NJmm2,                           //<Kaapelin poikkipinta
   NJpit :real;                     //<NJpit= NJ:n kokonaispituus vikalle JK:lle asti
      {##### Nyt:   IkSul     ##### Oli:   Isul  = Poiskytk.ajan määräämä sulake  #####
       #####        KuorSul   #####        Isul1 = Kuorman muk min.sulake         #####
       #####        YVsul     #####        YVsul = Isal * äKorj                   #####
       #####        ZSsul     #####        Isul2 = IsuMax=Isal*äKorj. Jos ZsIa<Uo #####
       #####                  #####                'pienentänyt, on Ziso=TRUE     #####
       #####        NJsul     #####        Pienempi YVsul, ZSsul :sta <<<<<<<<<<< #####
       #####        KuorKat   #####        Ikat1 = Kuorman muk. min.katk.yv.aset. #####
       #####        ZSkat     #####        Ikat2 = Kuten Isul2                    #####}

      {##### Nyt:   IkSul     ##### Oli:   Isul  = Poiskytk.ajan määräämä sulake  #####
       #####        KuorSul   #####        Isul1 = Kuorman muk min.sulake         #####
       #####        YVsul     #####        YVsul = Isal * äKorj                   #####
       #####        ZSsul     #####        Isul2 = IsuMax=Isal*äKorj. Jos ZsIa<Uo #####
       #####                  #####                'pienentänyt, on Ziso=TRUE     #####
       #####        NJsul     #####        Pienempi YVsul, ZSsul :stä  <<<<<<<<<< #####
       #####        ImgKat    #####          (uusi@ = Ik1v * 0.8)                 #####
       #####        KuorKat   #####        Ikat1 = Kuorman muk. min.katk.yv.aset. #####
       #####        YVkat     #####          (uusi@)                              #####
       #####        ZSkat     #####          (uusi@)                              #####
       #####        NJkat     #####        Ikat2 = Kuten Isul2 (Nyt: PieninMäärää)#####}
   NJsul,YVsul,IkSul,               //Iskmin=StM:n vaatimus Iks= f(Isulake)
   KuorSul,ZSsul :Integer;          //<KuormanMuk min Isul, Kaap:n max Isul
   isosul :Integer;                 //Isoin sul 6:sta tulostetustaJotta sel
   isokat :Real;                    //ektiveinfo ajantasalla. Isoin katk <<<<
   KuorKat,YVkat,ZSkat,NJkat,       //<Katkaisija-asetukset kuten Isul1,2
   ImgKat :real;                    //<Katkaisijan Mg-asetus =Ik1v*0.8
   Iskmin,Ikm  :Real;               //Ikm=MMK-kaapelin oikosulkuvirta Ik1v, Iskmin=Sulakkeen Isnik
   alpx,                            //<Kaapx Isul1:lle <<<<<<<<<<<<<<<<<<<<<<
   tuxV        :integer;            //<Kaap.ve n:o, kumulat.<<<<<<<<<<<<<<<<<

   OldSrcja,              //<SyoFrm´iin tultaessa sijoitetaan tiedoksi edellisestä SorceCount t. JohtoOsia +8.0.0
   edNo        :integer;            //<Johto-osan N:o, jonka arvoiksi Nj-laskentaparam. annetaan +4.0.0 !!!!!!!!!
   edv,                             //<edka=vikat, voimassa olevat arvot, edka[] := edkau {¤DEVELOPER1Lisäys}
   edvE,                            //<edka=vikat EDITOIDUT, johon mm. ERIEDV vertaa. edvE := edv
                                    //'sen jälkeen, kun EdvNewFrm on päivitetty ####################
   edvf,                            //<edkafile(=filestä luettu) talt<<<<<<<<
   edv0        :edvYHTtype;         //<edkafile(=alkuper käynnist) talteen<<<
   tyh_EdvEdka{,tyhA_EdvEdka+8.0.1 ks. FileEv.INC + Syotto.PAS} :EdvPalstaType;
   EdvFile     :TIniFile;
   EdvFilen,EdvF_filen,Edv0_filen :string;
   EdvFileCreated :string;
   suCse :string;                           //<Edv+Nj:n sulaketyyppi. Toistaiseksi päätellään IEC TR/FA:sta
                                            //'=Nyt joko IECgG tai OFAAgG ja saa arvon EdvLaskSij26-INC:ssä #####
   ALmrk,CUmrk   :Real;                     //<Alin njve:n hinta tulostetuista

//NOLAHmod------
   hav2,HavTarif :NjHavTied;
   Hvrt,TabNo :Integer;             //< Hvrt = 0=EiHäviötMuk 1=Tiivistäen 2=Eritell 3=Special.  TabNo SyottoAv´sta 12.0.0.
   KUSfilen,nimifKUS :String;       //' -1=SuljeBtn  0=Ohita  1=HäviöKust
   edi,EdiKayty,SrcKayty :integer;  //<EDI:= ao.EdjBtnClick(?), Edi/SrcKayty:=SyottoFrmOKbtnClick(?)

   DetEvAuki :boolean;              //<Ks. DetEv.PAS / Init. + EdvNew.Pas / ...
//Moottorilähdöille ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
//Vois olla MOOT.PAS :ssa, samoitn TYYPIT, mutta ei onaa siellä, todttu ??????????????????????????????????????
   MoNj    :MoNjRec;                //<Korvaa ValitRec'in <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   MootNJ  :boolean;                //<MootNj=TR jos moottorilähdöistä siirrytään laskemaan sille NJ:tä.
   MoFilen :string;
   mo,mof,mo0, mou :moYhtType;      //<EnnenLukua MOU := MO[], muulloin vain kun moVE=1
   Yvrk :ARRAY [0..YvrkMax] of real; //<Yläverkon arvot, ks. Syotto.PAS:  Säilöö CyBx..:n arvot poistuttaessa välillä

//Johto-osuuksien (Myös NJ) KorjKertoimille,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   Ktlk :array [1..KtlkRivMax,1..KtlkSarMax] of string;   //<A2:n mukaisten asennustapojen korjKerrointaulukko
   FileLukuVirhe{,WrOtsS},koS,RegFnVirhe{1415f} :string; //<WrOtsS,koefileen kirjoitukseenOhjuun +10.0.7, RegFnVirhe{1415f} Käynnistysvirhe tikusta tms.
   AsetusOkBtnSulkiSyoFrmin,WrNyt,                        //<+10.0.4  WrOnEi =>WrNyt =12.0.0               'jolloin polkua ei saa osoittaa sinne.
   Chk64B_ohitus{+120.4} :boolean;
                               LICENSE_VALV_PATH,//      = "C:\VARO_NOLA_LUE_WARNING"    <,,+12.0.0
                            //(LICENSE_VALV_DirN ;;;;;;  = "C:\VARO_NOLA_LUE_WARNING\Nola")  ;;;;;;;;;;;;;;;;; <Ei käytetä
                               LICENSE_VALV_DirL,//      = "C:\VARO_NOLA_LUE_WARNING\NOLA\License"
                               LICENSE_VALV_DirL_FN,//   = "C:\VARO_NOLA_LUE_WARNING\NOLA\License\License.nos"

                             //LICENSE_WIN_PATH,//       = "C:\WINDOWS"                    Ei tarvetta.
                               LICENSE_WIN_DirN,//       = "C:\WINDOWS\Nola
                               LICENSE_WIN_DirN_DirL,   //= "C:\WINDOWS\Nola\License"
                               LICENSE_WIN_DirN_DirL_FN,//= "C:\WINDOWS\Nola\License\License.nos"
TextBaseFileN,MyLicStatusText,LicNroS,LicLaajS :string; //<Koska MyLicense ei tunnu olevan luotu PaaVal/PRC ChkLaajuusLbl´ssa, tällä se tuodaan Y_.INC´stä.
PrRjIndx :Integer;        //<Pr ja Rj-resurssien laskentapoikkipinta (1=2.5/1.5, 2=10A2.5, 4 tai 6 mm²) +120.5, +130.0: ks. PRC TEdvNewFrm.PrRjMm2BxSelect
JkUpsInt :integer;        //<+130.5ups 141.1(oli Syotto.PAS´ssa) sijoitus emPAS / ShowModal jälkeen.
UpsNytVex,Panrv :integer;  //141.1:  >0 =vex  -1412: NolaVar´iin. 1412: Panrv = sij_PrRjNj´n ao.palstariviNo, sama kuin r, käyttö ZaoFileen riviOsoitukseen.
{YLst :TStringList; =PaaVal´ssa} YLstFN :string; //<+1412: SyottoFrm kulunSeurntaan.
//UpsNama :TSringList;    //<+141.1:  Local.. ArrayIndex eivät näy oikein PRC DrawUPSj..´ssa. Tässä luettelo UpsLaiteLähtöjen johto-osista >100 = EdJ-osia
{µ} lvEXTok,LicAsttuOK :boolean; //<+120.5n:  TR jos lvEXTended tai isompi (lvGLOB).     //'Ltlossa VAIN UpsLähdöt eli ne, joissa JkUps.ArvoInt =1.
alpLaakPmu{130.2e} :real;
alpSuk{130.2e},{edEioo_FLstFN{:1413:,edEiOK_FLstFN,}LstOutErrFn :string;
gOha{1414 FileLstN´lle, := Y_´ssä},ChkDebWr_kertoja{1415f} :integer;
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NOLAvar.INC }//LicNroS.. yms ei tarvita jos ajo onnistuu.







