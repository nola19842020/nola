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

{############################################################### NOLAtyp.INC}
{ - Mietittävä, mitä näistä kantsuu sisällyttää PAAVAL-unittiin ja mitä
    alempiin, esim. EDV.PAS, vai onko niin, että liian moni muu unitti
    tarvitsee samoja tietoja, jolloin KAIKKI kantsuisi jättää PAAVALiin ????}
CONST Pii=3.14159;
      e_mk=5.94573;
      LueTR=TRUE;  LueFA=FALSE;      KysTR=TRUE;  KysFA=FALSE;     TalTR=TRUE;  TalFA=FALSE;
      AlTR= TRUE;  AlFA= FALSE;

      YvrkMax=50;                     //<Yläverkon parametrit rivien 11..41 mukaan (Col 0=Riv 11..19, 4=31..41)
      suToler=10;
      valitMax=6;   valitMrkMax=67;   //<NOLAcMOD.PAS<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      KHmaxNmm2 = 25;  KHmaxTyp = 4;  //KAAPELIHINTATAULUKON max.kaap:  mm2Lkm , lajeja <<<<<<<<<<<<

      edMaxKpl=20;{¤DEVELOPER1}             //<Ed.verkon peräkkäisten johto-osien max.lukumäärä
      edLmaxKpl=5;                    //<Liittymiä MaxKpl +6.2.2
      rinmax = 20;                    //<Ed.verkon johto-osien rinnakkaiskaapeleiden max.lukumäärä
      mm2NoMax=18; //< 0,6,10,16,25,35,50,70,95,120,150,185,240,300,600,900,1200,2400,3200 =SvJärj =19kpl
      kesmax = 25;                    //<Keskuksia ketjussa max
      //Vanhat arvot ..ker=100/g/Uý(kV)/1000
      //alker = 0.018717;       u% = PL alker / A
      //cuker = 0.012149;       u% = PL cuker / A    = kW m /mm2
      alg=37;   cug=57;   ctk=80;
      KeroMg=0.85;                    //<Katkaisijan Img :n kerroin, jolla max.YVasetus

      momax ={7}50;                   //<Moottorilähdöille <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      m_tasavImg=1.86;                //<-"- Img :n asetusarvoksi:  Img := m_tasavImg * Ist;


  Ik3vTR=TRUE;  Ik3vFA=FALSE;  NJkinTR=TRUE;  NJkinFA=FALSE;{...............................=FNC Iks kutsuun}

  aoPEkrj=0; //<,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,=Zik_Src_ -kutsuihin.
{//MaxZ -pisteessä.  Edj/Nj/Sj lopussa.   Napaoikosulku.
  MaxZk1v_sj = 1;   Zk1v_sj = 2;         Zk1v_s = 8;
//VainKunNj:kin.   J:n lopussa.   Napaoikos.   J:n lopussaTh(Tim)  NapaoikosTh(Tim)    J:n lopussaDyn. NapaoikosDyn.
  Zk3v_Nj_1 = 0;   Zk3v_sj = 3;   Zk3v_s = 4;  Zk3th_TIM_sj = 13;  Zk3th_TIM_s = 14;   Zk3d_sj = 23;   Zk3d_s = 24;}

   VersionSec = 'Version';
   VersionKey = 'VersioNo';            //<1415f: Takas (oli vex kauan).
   VersionMajorKey =   'VersionMajor';
   VersionMinorKey =   'VersionMinor';
   VersionReleaseKey = 'VersionReleas';
   DescriptionKey =    'Description';        
   FileTypeKey =       'FileType';
      EdvFileType =       'EdvFileNOE';
      NjFileType =        'NjFileNON';
    //KaapHavType=        'HavFileHAV'; //<,,+1414 Ei sittenkään, sis. kaikki paramt jo NON -fileeseen
      MoFileType =        'MoFileNOM';
      EdvFiletN =      'EdvNimet.txt';
      NjFiletN =       'NjNimet.txt';
    //KaapHavTypeN=    'HavNimet.txt';  //+1414
      MoFiletN =       'MoNimet.txt';
   FileCreatedKey =    'File_Created';
   FileModifiedKey =   'FileModified';                     //,Käytetään esim. EdvFile´n Section´ien visual.erottimena   
   RiviValiKey=        '^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'; //<Ei voi olla ===.. koska loppuun IniF lisää vielä '='
                                                           // eikä Key´tä läydy enää se jälkeen. TODETTU.!!!!!!!!!
   edv_NjL  =  'edv_NjL';       //<,,TINIfile -tiedostojen  SECTION-nimet
   edv_YLE  =  'edv_YLE';
   edv_Edka =  'edv_Edka';
   edv_Sorce = 'edv_Sorce';     //< +6.2.2
   NJ_HAV   =  'NJ_Hav';
   NJ_JY    =  'NJ_JY';
   NJ_JK    =  'NJ_jk';
   MO_Yle   =  'MO_Yle';
   MO_Rv    =  'MO_Rv';
   LastFileN = 'LastFileN';     //<  SETTINGS -tiedoston  tiedostoSECTION-nimi
    LastPreNet = 'LastPreNet';  //<,,SETTINGS -tiedoston  KEY-nimet
    LastBranch = 'LastBranch';
    LastCost   = 'LastCost';
    LastMotor  = 'LastMotor';   //,,Oletusnimet ao.ohaOsan tiedostoille: Nyt tarvitaan vain, jos
   filen_Ev = 'Olet-Ev.NOE';    //   talletetaan ekan istunnon oletustietoja, muuten lopputalletus
   filen_Nj = 'Olet-Nj.NON';    //   luetulla tai tallettuksessa jo käytetyllä nimellä
   filen_Ha = 'Olet-Ha.NOH';
   filen_Mo = 'Olet-Mo.NOM';
   filen_EvExt = 'NOE';         //>,,Tiedostonimien LAAJENNUSosat ao.ohaOsien OPEN/SAVE-Dialogeihin
   filen_NjExt = 'NON';
   filen_HaExt = 'NOH';
   filen_MoExt = 'NOM';
             //,Eka mjono=ao.TYYPIN "VIRALLINEN" tunnus. ";" :lla erotettu HYVÄKSYTTÄVÄT lyhen-
             //,teet, jotka korjataan 1.:ksi. "\"=TYYPPIEROTIN,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,¤DEVELOPER1
   S_KulSal= 'KULUTT.;K;KU;KUL;KULU;KULUT;KULUTT\SÄHKÖL.;S;SÄ;SÄH;SÄHK;SÄHKÖ;SÄHKÖL';

             //,,,,HUOM. HUOM. HUOM. HUOM. HUOM. JÄRJESTYS OLTAVA SAMA KUIN mm2arr[0..] ############
             {Kaikki tyypit:
              AMCMK3½ AMCMK3½½ AMCMK4½ AXMK AXCMK AMMK*
              KiskAbb-AlN KiskAbb-AlS KiskAbb-CuN KiskAbb-CuS KiskAbb-CuNx KiskAbb-CuSx
              SVsystAL3½ SVsystCu3½ SVsystAL4N SVsystCu4N SVsystAL5S SVsystCu5S
              APAKM* AMKA AVOJOHal
              MCMK3½ MCMK3½½ MCMK4½ MMJ/MMK* PLKVJ* AVOJOHcu}
 //S_KaTyp = 'AMCMK3½\AMCMK3½½\AMCMK4½\AMCMK4½HD\'{:+11.0.1:}'AMCMK3½o\' + //< o =25,35 +PEN 10 => 16 mm²
   S_KaTyp = 'AMCMK3½\AMCMK3½o\AMCMK3½HD\AMCMK3½½\AMCMK4½\' +     //< 3½o =25,35+PEN 10  ja 3½HD  = +11.0.1
             'AXMK;AXM\'  +'AXCMK;AXC;AXCM\'  +'AMMK*;AMM;AMMK\' +
             'KiskAbb-AlN\KiskAbb-AlS\KiskAbb-CuN\KiskAbb-CuS\KiskAbb-CuNx\KiskAbb-CuSx\'+          //<+6.0.2
             'SVsystAL3½\SVsystCu3½\SVsystAL4N\SVsystCu4N\SVsystAL5S\SVsystCu5S\' +                 //<+6.0.2
             'APAKM*;AP;APA;APAK;APAKM\'  +'AMKA;AMK\'  +
             'AVOJOHal;AVOa;AVOal;AVOJa;AVOJal;AVOJOa;AVOJOal;AVOJOHa\'+
             'MCMK3½\MCMK3½½\MCMK4½\'     +'MMJ/MMK*;MM;MMJ;MMK;MMJ,MMK;MMJ.MMK;MMJ:MMK;MMJ/MMK;MMJ MMK\'+
             'PLKVJ*;P;PL;PLK;PLKV;PLKVJ\'+                                  //,0=Lopetusmerkki<<<<<
             'AVOJOHcu;AVc;AVcu;AVOc;AVOcu;AVOJc;AVOJcu;AVOJOc;AVOJOcu;AVOJOHc'; //<Lopusta '\' vex   =-6.0.3
   njSVj  ='SVsystAL5S'; //<NJlaskennan SVtyyppi, oli <=6.0.1 "SVjärjest.", joka nyt "SVsyst3½":  +6.0.2
   njMCMK ='MCMK4½';     //<NJlaskennan ... +6.0.2
   njAMCMK='AMCMK4½';    //<NJlaskennan ... +6.0.2
   S_POT   = 'PotTas;P;PT;PoT;PotT;PotTa\EiPotTas;E;Ei;EiP;EiPo;EiPot;EiPotT;EiPotTa;';
   S_MUUN  = '16\30\50\100\160\200\250\315\400\500\630\800\1000\1250\1600\2000\2500\3150';
   S_MUUN_1= '200\315\500\630\800\1000\1250\1600\2000\2500\3150';                          //<HävSrj 1 uusi
   S_MUUN_2= '30\50\100\200\315\500\630\800\1000\1250\1600\2000';                          //<HävSrj 2 uusi
   S_MUUN_3= '30\50\100\160\200\250\315\400\500\630\800\1000\1250\1600\2000\2500\3150';    //<HävSrj 3 vanha
   S_AsTap = 'A\C\D';
   S_Usrj  = '100\380\400\410\480\500\600\660\690\710\1000';

{su_OFAg su_OFAm   su_IECg su_IECgAR su_IECgYR   su_IECd su_IECdAR su_IECdYR}
   su_OFAg = 'OFAAgG';   su_OFAm =   'OFAMaM';
   su_IECg = 'IECgG';    su_IECgAR = 'IECgG-ar';   su_IECgYR = 'IECgG-yr';
   su_IECd = 'IECdZ';    su_IECdAR = 'IECdZ-ar';   su_IECdYR = 'IECdZ-yr';

   mm2arr :array [0..29] of string =                                      //,,"PURETTAVA" ekax FNC  :lla
{ J  K   !} ({ 1 AMCMK3½}    '16\25\35\50\70\95\120\150\185\240\300',     //  s := f_Items(f_VarItems())
{ Ä  U   !}  { 2 AMCMK3½o}   '25\35',                                     //<,,+11.0.1  o =25,35 +PEN 10 => 16 mm²
{ R  U   !}  { 3 AMCMK3½HD}  '25\50\95\150',                              //<  +11.0.1 Uusi tyyppi (aurattava)
{ Ä  U   !}  { 4 AMCMK3½½}   '16\25\35\50\70\95\120\150\185\240',         //''####################################
{ R  I   !}  { 5 AMCMK4½}    '16\25\35\50\70\95\120\150\185\240\300',
{ J  N   !}  { 6 AXMK}       '16\25\35\50\70\95\120\150\185\240\300',
{ E  -   !}  { 7 AXCMK}      '16\35\50\70\120\185\300',                                          //<6.1.1  +50 mm²
{ S  K   !}  { 8 AMMK}       '25\35\50\70\95\120\150\185\240',
{ T  a   !}  { 9 KiskAbb-AlN} '800  1286A=04i\1600  2530A=06ii\3200  4074A=08iiXii',
{ Y  T   !}  {10 KiskAbb-AlS} '800  1286A=04i\1600  2530A=06ii\3200  4074A=08iiXii',
{ S  y   !}  {11 KiskAbb-CuN} '1600  3231A=06ii\3200  4320A=08ii-ii',
{ .  p   !}  {12 KiskAbb-CuS} '1600  3231A=06ii\3200  4320A=08ii-ii',
{ O  i   !}  {13 KiskAbb-CuNx}'3200  4930A=08iiXii',
{ L  s   !}  {14 KiskAbb-CuSx}'3200  4930A=08iiXii',
{ T  s   !}  {15 SVsystAL3½} '300  XZX 13 =500 A\600  XZX 23 =950 A\ 900  XZX 33 =1300 A\1200  XZX 43 =1800 A\2400  XZX 38 =2700 A\3200  XZX 48 =3600 A',
{ A  ä.  !}  {16 SVsystCu3½} '300  XZX 13 =630 A\600  XZX 23 =1200 A\900  XZX 33 =1640 A\1200  XZX 43 =2270 A',
{ V  .   !}  {17 SVsystAL4N} '300  XZX 13 =500 A\600  XZX 23 =950 A\ 900  XZX 33 =1300 A\1200  XZX 43 =1800 A\2400  XZX 38 =2700 A\3200  XZX 48 =3600 A',
{ A  .   !}  {18 SVsystCu4N} '300  XZX 13 =630 A\600  XZX 23 =1200 A\900  XZX 33 =1640 A\1200  XZX 43 =2270 A',
{ .  .   !}  {19 SVsystAL5S} '300  XZX 13 =500 A\600  XZX 23 =950 A\ 900  XZX 33 =1300 A\1200  XZX 43 =1800 A\2400  XZX 38 =2700 A\3200  XZX 48 =3600 A',
{ S  .   !}  {20 SVsystCu5S} '300  XZX 13 =630 A\600  XZX 23 =1200 A\900  XZX 33 =1640 A\1200  XZX 43 =2270 A',
{ A  .   !}  {21 APAKM}      '35\50\70\120\185\240',                  //<6.1.1  +50 mm²
{ M  .   !}  {22 AMKA}       '16\25\35\50\70\120',
{ A  .   !}  {23 AvoA}       '21\34\54\85',
{ .  .   !}  {24 MCMK3½}     '1.5\2.5\4\6\10\16\25\35\50\70\95\120\150\185\240\300', //<1\2\ +6.2.10  .5 ,,+6.2.16
{ .  .   !}  {25 MCMK3½½}    '1.5\2.5\4\6\10\16\25\35\50\70\95\120\150\185\240',     //<1\2\ +6.2.10
{ .  .   !}  {26 MCMK4½}     '1.5\2.5\4\6\10\16\25\35\50\70\95\120\150\185\240\300', //<1\2\ +6.2.10
{ .  .   !}  {27 MMJ  }      '1.5\2.5\4\6\10\16\25\35\50\70\95\120\150\185\240',     //<1\2\ +6.2.10
{ .  .   !}  {38 PLKVJ}      '10\16\25\35\50\70\95\120',
{ .  .   !}  {39 AvoC }      '10\16\25\35\50\70',
{ .  .   !}  {30 tyhjä }      '');                  //< =Merkiksi esim. iteroinnin lopettamiseksi. =32 alkiota.
//           [0.. ] koska muidenkin S_.. osoitteet samoin, ks. mm. SyoKut.INC / PRC EtsiOlet'''''

{DEVELOPER2 BEGIN}
 //,,arvo -tlkn osoitteita:,,     ,,RyhmaJohto -tlkn osoitt:,,      ,,NousuJohto -tlkn osoitteita:,,  ,,¤)=Ei käytetty: 1202.###################
     arvo_IK1V_1        = 1;       {rjohto_PISTORASIA_S_1 = 1;¤}     {njohto_NOUSUJOHTO_04_1    = 1;¤}
     arvo_IK3V_2        = 2;       {rjohto_RYHMAJOHTO_S_2 = 2;¤}     {njohto_NOUSUJOHTO_50_2    = 2;¤}
     arvo_IK3T_3        = 3;       {rjohto_PISTORASIA_B_3 = 3;¤}     {njohto_NOUSUJOHTO_04_OIK_3= 3;¤}
     arvo_IK3D_4        = 4;       {rjohto_RYHMAJOHTO_B_4 = 4;¤}     {njohto_NOUSUJOHTO_50_OIK_4= 4;¤}
     arvo_SUL_MAX_5s_5  = 5;       {rjohto_PISTORASIA_C_5 = 5;¤}
     arvo_SUL_OIKOS_6   = 6;       {rjohto_RYHMAJOHTO_C_6 = 6;¤}      njohto_MAX_4              = 4;
     arvo_SUL_YLIV_A_7  = 7;       {rjohto_PISTORASIA_D_7 = 7;¤}
     arvo_SUL_YLIV_C_8  = 8;       {rjohto_RYHMAJOHTO_D_8 = 8;¤}
     arvo_SUL_YLIV_D_9  = 9;
     arvo_KAT_OIKOS_10  =10;        rjohto_MAX_9        = 9;//8;  Muutos 8.0.7
     arvo_KAT_YLIV_A_11 =11;        rjohto_10aMAX_9     = 9;//8  <Ei käytetty +Muutos 8.0.7
     arvo_KAT_YLIV_C_12 =12;        rjohto_a_MAX = rjohto_MAX_9 +rjohto_10aMAX_9 +4{=22}; //<+6.2.2
     arvo_KAT_YLIV_D_13 =13;  {RyhmaJohto pituus -tlk:}{rjpituus_10_1 = 1;¤}   {rjpituus_16_2 = 2;¤}   rjpituus_MAX_2 = 2;
     arvo_KAT_AIKA_14   =14;
     arvo_MAX_GRID_14   =14;//<,,9.0.1  arvo_MAX_GRID´iin asti GRID´in rivejä, arvo_SUL_MAX_04s_15 vain arvotaulukossa.
     arvo_SUL_MAX_04s_15=15;
     arvo_MAX_15        =15;//<''9.0.1
     //==================================================================================================

     KtlkRivMax=100{tarve 75};  KtlkSarMax=20;  KtlkArvoTyh='-1'; //<KorjKerrointlklle Ktlk´a varten

{DEVELOPER2 END}

TYPE
   arvoTyyppi = (Intg, Reaa, Bool, Strg);
   desTyyppi  = RECORD Raj :real;  Des :integer;   END;   //< Des=MaxDes  Raj=MaxArvo, JOTA PIENEMMILLÄ MaxDes,
                                                          //'isommilla arvoilla DES pienenee (-1) per dekadi
   arvoTyyp = RECORD                                      //'Ei tarvita kuin Reaa :lla, muilla DES tiedetään!!!!!
                   tunniste :string;  //<Muuttujan KEY-nimi INIfilessä, SECTION-nimi hoidettava itse
                   onArvo :boolean;
                   arvoTyp :arvoTyyppi;
                   arvoInt :integer;
                   arvoRea :real;
                   arvoBoo :boolean;
                   arvoStr :string;
                   onAlar  :boolean;    //<Alaraja olemassa ON/EI
                     alarInt :integer;
                     alarRea :real;
                   onYlar  :boolean;    //<Yläraja olemassa ON/EI
                     ylarInt :integer;
                     ylarRea :real;
                   Rdsm :desTyyppi;   END;
   aslaji = RECORD
               nimi :string;          //<Kauppanimi t. tyyppi
               laji :boolean;         //<TRUE = Alum.
               jLkm :integer;   //<Johdinlukumäärä (4 tai 5)
               oh   :real;      //<Oik.  hyllylle        €/m
               kh   :real;      //<Kiin. hyllylle        €/m (ei käytössä)
               khme :real;      //<Kiinnit. määrävälein  €/m
            END;
   kahi   = RECORD   //,,= kahitau [].nimi  \.laji  \.jLkm  \.mm2    \.MMJ  \.MCMK .. jne.
               mm2  :real;            //<Poikkipinnan tunnistekenttä
              {MMJ, }MCMK,
               AMCMK,AXMK,SVjarj :aslaji   //<Tietuekentät as.lajin
            END;                           // mukaisille hinnoille
   tautyp = array [1..KHmaxNmm2] of kahi;
   KahiFileType = Text;{¤}

   {nj.jy/...}
   NJylTiedot =  RECORD
                UhRaja,                                  //< +3.0.3 (=4.0.0)
                ketjussa,
                NjKulSal,                                //<TRUE = Kuluttaja-asennus, muuten SÄHKÖL.verk.
                Tk1v,                                    //<Nj:n Resistanssin laskentalämpötila
                tasaus,                                  //<Nj:n kuormituksen tasoituskerroin
                astapa,                                  //<Asennustapa A/C/D
                korjaus,                                 //<Kuormitettavuuden korjauskerroin
                kasvuv :arvoTyyp;  END;                  //<1.Nj-ve:n kuorman minimikasvuvara
   {nj.jk[]..}
   NJjkTiedot =  RECORD
                tunnus,huom,
                dL,                                      //<Keskusten väli = Nj:n pituus (m)
                ala,                                     //<Ryhmitysala m2
                palV,                                    //<Ohjearvo W/m2
                cosV    :arvoTyyp;                       //<palV:n Cosini

                Ps,Qs,Ss,Iss,coss, //Pt,Qt,St,It,        //<Syötetään  (DELPHI: Is => Iss)
              //Pa,Qa,Sa,Ia,                             //<Lasketaan. HUOM: WITH jk[] DO sa := 'string' si-
              //Pl,Ql,Sl,Il,         Ph,Qh,Sh,Ih,        //<Päätellään       joittaisikin jk:n Sa :han eikä
                PTlop             :arvoTyyp;             //'apuStringiin sa ######
                onarvot           :boolean;  END;
   {nj.Hav. ...}
   NjHavTied = RECORD Tpit,Korko,Hprs,Tph, YOprs,Ktyh,dPprs,dWmkprs, PVpen,YOpen,Pmk  :arvoTyyp;   END;
   jkArrType = ARRAY [ 1..kesmax ] of NJjkTiedot;        //<Em. keskustiedot
   jkYHTtype = RECORD
                jy  :NJylTiedot;
                jk  :jkArrType;
                hav :NjHavTied;  END;
{DEVELOPER2 BEGIN}
{J,=Välittyy Johto/Johdot.PAS´siin.}
   {edv.YLE.SorceCount tms:}
{J}EdvTiedotType = RECORD   //Yleiset parametrit,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                SorceCount,                        //<Rinnakkaisliittymien lkm, tyyppi              <+6.2.2
                JohtoOsia,                         //<Johto-osien lukumäärä
                Kuvaus,    Un,                     //<Un=PÄÄjännite (DOS-NOLAssa oli Uvaihe)
                VaiheLkm,  cU,                     //<cU=Jännitekerroin, esim. 0.95
                LaakPmu,                           //<+130.2o:  +130.o: 3,5
              //PrRjMm2,            //<Pr ja Rj-resurssien laskentapoikkipinta (1=2.5/1.5, 2=10A2.5, 4 tai 6 mm²) +120.5, +130.0: ks. PRC TEdvNewFrm.PrRjMm2BxSelect
                PEN_PE,                            //<PEN+PE -yhdistämislenkki                      <+6.0.3            //'130.0: NYT vain IndexNo mistä
     {Edv+Nj >} IecOfa,                            //<TRUE =IECn mukainen sulake, muuten OFAA                          //'       FileEv.INC / PRC PrRj_Mm2Tim(VAR Mm²+Tim..) palauttaa nuo.
     {Edv+Nj >} PoisAika,                          //<Poiskytkentäaika kul.asennuksissa 0.4/5 s
                PRaika,AsTapa,                     //<Poiskytkentäaika pistorasioissa 0.4/0.2 s     <+8.0.0
                ZpeBx :arvoTyyp;  END;             //<Lisätty, jotta muutettaessa kuvaaja päivittyisi TR jos Lzpe valittu BxTZpe -boxissa.          <+9.0.1
   {edv..Sorc[]src.Smn tms:,,}
{J}EdvSorceType = RECORD    //Liittymäparametrit,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, +6.2.2
                SorceKind,                         //< 1=Transformer  2=LV-Cable  3=Generator  4=UPS
                Smn,                               //<Kulutt.muuntajakoko,
                TrfTyp,                            //<Muuntajatyyppi: 1,2... (häviösarja)
                yvRs,yvXs,                         //<Yläverkon Z-komponentit: Zk=2*yvZs+.. =n. ZsIa
                Iks1v,Iks3v,                       //<LIITTYMÄ 1v- ja 3v-Ik:t
                Iks1vCos,                          //<Liittymän Iks1v :n cosini
                pjLiitRs,pjLiitXs,                 //<Pj-liittymän Zs -komponentit, vrt. ZsIa
                gSn,gXd,gXd1,gXd2{,gX2,gX0},gRs, //<,GENER.<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< +6.2.2
                gTd1,gTd2,
                gtIkMin,gtIkSust,gIkSust,gK1vSust,   //<+8.0.8
                Ups_Ik1v,Ups_Ik3v,Ups_Cos :arvoTyyp; //<+141.1
                OnArvot :boolean;   END;             //<OnArvot +8.0.0

   {edv.NjL.yhtR1 tms:}
{J}EdvNjLahtoType = RECORD   {Edv:n jälkeen}
             {yhtUhRaja,edUhOsa,NjUhRaja,          //<Uh-raja Nj:n lopussa, Edv:n ja Nj:n osuus     <,-4.0.0
              OnPTlop,}
              yhtZe,yhtRe,yhtXe,yhtCosZe,          //<Kokon.oikos.imped. Nj:n alussa = Edv:n lopussa
              yhtZs,yhtRs,yhtXs,yhtCosZs,          //<Kokon.Zs-imped.    Nj:n alussa = Edv:n lopussa
              yhtR1,yhtX1,                         //<+6.0.0a
              Ik1v,Ik3v,Ik3t,Ik3d :arvoTyyp;
              Ik3thOfaOikos{rv8},Ik3thOfaVal{rv10},            //<+6.2.0
              Ik3dOfaOikos{rv9},Ik3dOfaVal{/rv10} :real;  END; //<+6.0.4

   {edv.edka[].ryhmaJohto[].pituus tms:}
   EdvRyhmaJohtoPituusType = RECORD
                pituus,pitZpe,Uk{+130.2e} :real;               //+9.0.1:Zpe-ehtoTäyttyy -pituus, Uk=kosketusjännite riveille 23-30 (32=Uk LääkMuunt).
                TUP    :integer;  END;
   {edv.edka[].nousuJohto[]...}                                                      //Edv rivit 17,18
   EdvRyhmaJohtoType = RECORD                                                         //  rjpituus2 [rjpituus_10_1]
                rjpituus: array [1..rjpituus_MAX_2] of EdvRyhmaJohtoPituusType;  END; //  rjpituus [rjpituus_16_2]

   EdvNousuJohtoType = RECORD   {Edv rivit 19-24}
                sulake :integer;       //<Sulakearvo
                mater  :boolean;       //<Johdon materiaali:  TRUE=Al  FALSE=Cu
                Amm2   :real;          //<Poikkipinta-ala
                pituus,pitZpe :real;   //<Johdon pituus, +9.0.1:Zpe-ehtoTäyttyy -pituus
                TUP    :integer;  END; //<TUPX arvot
   {edv.edka[].JkUps_Ik1v tms:}
{J}EdvPalstaType = RECORD   {Edv rivit 01,02}                                         //,+6.0.0
                JkUps,              //<0=JK  1=UPS=resurssijohtolaskennassa UPS //<+120.6
                nimi,               //<Keskustunnus
                kuluttaja,          //<TRUE = Kuluttaja-asennusta,  FALSE = SÄHKÖL :n jakeluverkkoa
                PTlopussa,          //<Potentiaalintasaus ao. johto-osan lopussa
                tyyppi,             //<Johdon tyyppi
                Amm2,               //<Johdinpoikkipinta
                PEker,              //<PE-johtimesta huomioitava osuus Ik1v :ssa (1=Koko Zpe, 0=Ohittuu kokonaan)
                lukumaara,          //<Rinnakkaisjohtojen lukumaara tässä osassa
                pituus,             //<Johdon pituus
                korjaus,            //<Kuormitettavuuden korjauskerroin
                lampotila,          //<Resistanssien laskentalämpötila
                OfaVal,             //<  +6.0.2 OFAsulakken valittu arvo
                Ph,Cosp,
                JkUps_Ik1v,         //<+130.2
              //JkUps_Ik3v,         //<+130.2  141.1: Ei tarvita.
                JkUps_Cos,          //<+141.1
                Uho,Uhp,Uhv,Uhvo,Tuh :arvoTyyp; //<+6.0.0 =Ph,Cosp,Uho(alku),Uhp(laskttu)Uhv(1-vaihe),Uhvo(alku+130.0),Tuh,Resist.LT)  Uhv=+6.2.15
                OnArvot   :boolean;             //'+130.0: Uhvo lisätty jotta edJosauh1 voifaan siirtää laskentaan, ks. EdvNewLask.PAS/PRC LaskeSij_uh.
                         { arvo-taulukko sisältää joukon johtoon liittyviä arvoja.
                           Taulukkoon sijoitus, ks. EdvNewLask.PAS.
                           Seuraavassa taulukossa on esitetty eri arvojen merkitykset

                           arvo[arvo_IK1V_1]      = 1-vaiheinen oikosulkuvirta
                           arvo[arvo_IK3V_2]      = 3-vaiheinen oikosulkuvirta
                           arvo[arvo_IK3T_3]      = 3-vaiheinen EKVIV.TERMINEN oikosulkuvirta
                           arvo[arvo_IK3D_4]      = 3-vaiheinen dynaaminen oikosulkuvirta !_NolaDOSssa:_
                           arvo[arvo_SUL_MAX_5s_5]= Maksimisulakkeen arvo:  5 s tai SÄL.
                           arvo[arvo_SUL_OIKOS_6] = Oikosulkusulakkeen arvo               ! = OikSul
                           arvo[arvo_SUL_YLIV_A_7]= Ylivirtasuojasulakkeen arvo asennus A ! = YvSulA
                           arvo[arvo_SUL_YLIV_C_8]= Ylivirtasuojasulakkeen arvo asennus C ! = YvSulC
                           arvo[arvo_SUL_YLIV_D_9]= Ylivirtasuojasulakkeen arvo asennus D ! = YvSulD
                           arvo[arvo_KAT_OIKOS_10] = Katkaisijan oikosulkuarvo
                           arvo[arvo_KAT_YLIV_A_11]= Katkaisijan Ylivirta-arvo asennus A
                           arvo[arvo_KAT_YLIV_C_12]= Katkaisijan Ylivirta-arvo asennus C
                           arvo[arvo_KAT_YLIV_D_13]= Katkaisijan Ylivirta-arvo asennus D
                           arvo[arvo_KAT_AIKA_14]  = Katkaisijan maksimi aika-asetus
                           arvo[arvo_SUL_MAX_04s]= 0.4 s:n Maksimisulakkeen arvo     +9.0.1 ks. LaskeRjPit.
                edv.edka[].arvo,,}
                arvo      :array [1..arvo_MAX_15] of real;   {''Edv rivit 1-15}
                          {arvoU:hun lasketaan OFAA -sulakkeen alentama Ik3dyn -arvo, ks.EdvLaskSij26-INC.,,+5.0.1
                edv.edka[].arvoU,,}         //,[2] Ik1v johto-osan alussa.                                < +6.0.2
                arvoU     :array [1..arvo_MAX_15] of real;                                             //<''+5.0.1
                                                                                                       //'  +6.0.0 ARRAY
                         { arvoU[3]=ValitunOFAAnRaj_Is   arvoU[4]=ValitunOFAAnRaj_Ith   arvoU[2]=Ik1vJohnAlussa
                           arvoU[5]=OFAAoikoSULraj_Ith   arvoU[1]=OFAAoikoSULraj_Is                 //<U[4,5]=+6.2.0
                         { Ryhmajohto -taulukko sisältää ryhmajohtojen arvot
                           Ryhmajohto[rjohto_PISTORASIA_S_1] = pistorasia   = .rjpituus[1/2]/.pituus /.pitZpe /.TUP
                           Ryhmajohto[rjohto_RYHMAJOHTO_S_2] = ryhmajohto
                           Ryhmajohto[rjohto_PISTORASIA_B_3] = pistorasia
                           Ryhmajohto[rjohto_RYHMAJOHTO_B_4] = ryhmajohto
                           Ryhmajohto[rjohto_PISTORASIA_C_5] = pistorasia
                           Ryhmajohto[rjohto_RYHMAJOHTO_C_6] = ryhmajohto
                           Ryhmajohto[rjohto_PISTORASIA_D_7] = pistorasia
                           Ryhmajohto[rjohto_RYHMAJOHTO_D_8] = ryhmajohto //<Ei käytetty 8.0.7
                edv.edka[].ryhmaJohto[1/2].rjpituus[1..rjohto_MAX_9 +..] /.pituus /.pitZpe /.TUP,,}
                RyhmaJohto :array [1..17{rjohto_a_MAX 22=}] of EdvRyhmaJohtoType;                   //<10.0.1
                                              //'r23..30 + Det2x4rv = 9+8rv=Yht 17  Kullakin rvllä 16/10A:n rjPit.
                                              //'vaikkakin rv31 ohjattu toisaalla/toisin.
                RyhmaJ_r31 :array [1..2] of EdvRyhmaJohtoType; //<Edv rivi  31: Samalle riville 2 kaksoisarvoa. 130.2e:  Nyt vain 1Pmu ja muOh=2j / muOh=1j
                           // 1.5/2.5mm², ks. EdvNewLask.PAS, 'ryhmaJohto [31] jää sitenKäyttämättä.   '+8.0.7
                           //'130.2e:  Nyt [1][1]=L2j / [1][2]=L1j.  [2][1]=uk2j / [2][2]=uk1j.  =esim:  35,4m/85,6m \\ 34,3V/ 26,7V ##################:130.2e
                           //'                                                                     tai:  35,4m 34,3V/85,6m 26,7V
                         { Nousujohdot -taulukko sisältää nousujohtojen arvot                        RyhmaJohtoPituusType = RECORD
                           NousuJohdot[njohto_NOUSUJOHTO_04_1]     = nousujohdon 0.4s ylivirtasuoja     pituus,pitZpe,Uk :real;  +130.2e:  Nys sis. Uk
                           NousuJohdot[njohto_NOUSUJOHTO_50_2]     = nousujohdon 5.0s ylivirtasuoja     TUP    :integer;  END;
                           NousuJohdot[njohto_NOUSUJOHTO_04_OIK_3] = nousujohdon 0.4s oikosulkusuoja    Esim:  RyhmaJ_r31[x].rjpituus[n].Uk
                           NousuJohdot[njohto_NOUSUJOHTO_50_OIK_4] = nousujohdon 5.0s oikosulkusuoja           RyhmaJ_r31[x].rjpituus[n].pituus
                edv.edka[].nousujohto[] /.sulake /.mater /.Amm2 /.pituus /.pitZpe /.TUP,,  =Nousujohtoresurssit}
                nousuJohto :array [1..njohto_MAX_4{4=r32..35}] of EdvNousuJohtoType;
             END;//EdvPalstaType      njohto'MAX=4

   edkatype  = ARRAY [1..edMaxKpl]  OF EdvPalstaType;
   SorceType = ARRAY [1..edLmaxKpl] OF RECORD
                     src  :EdvSorceType;        //< edv.Sorc[].src.SorceKind  ... .gX0
                     josa :EdvPalstaType;  END; //< edv.Sorc[].josa.Amm2 ... .Pituus jne.
   EdvYHTtype = RECORD                   //,,,,,,,,,,,,,,,,,,,,,KutsuEsim,,,,,,,,,,,,,,,,,,,,,,,,,,,
                OnLaskettu : boolean;
                edka :edkatype;          //edv.edka[].OnArvot  /.kuluttaja/.PTlopussa/.....lampotila
                YLE  :EdvTiedotType;     //edv.YLE.Un  /.VaiheLkm/.cU/.JohtoOsia/.IecOfa/...PoisAika
                Sorc :SorceType;         //edv.Sorc[].src.SorceKind ... .gX0    edv.Sorc[].josa.Amm2 ... .Pituus jne.
                NjL  :EdvNjLahtoType;    //edv.NjL.yhtUhRaja  /.edUhOsa/.NjUhRaja/yhtZe/....yhtCosZs
             END;
{DEVELOPER2 END}
//Moottorilähdöille ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
//Vois olla MOOT.PAS :ssa, mutta ei onaa siellä, todttu ??????????????????????????????????????????????????????
   MoNjRec = RECORD mInfo :string;  mSul :integer;  mPekv,mCosEkv,mItrm,mImg,mTim :real;  end; //<KorvaaValitRec'in
   moRecYlType = RECORD Kuvaus,Lahtoja,sulSft,Umo,Vrk :arvoTyyp; END;
   moRecRvType = RECORD kw,cos,tim,{:Reaa;}  nap,rno,kpl,{:Intg;}  asT,suT,{:Strg;}  korj,Lmo{:Reaa;} :arvoTyyp;
                        spec,onArvot :boolean;   END; //<spec =Moottorin Ist yms.tiedot ANNETTU, eiOHA
   moTauType = ARRAY [0..momax] OF moRecRvType;
   moYHTtype = RECORD moty :moRecYlType;          //<mo.moty.sulSft
                      motr :moTauType;  end;      //<mo.motr[rivi].kw  /.nap ... /.korj

{##################################################################################################### NOLAtyp.INC}
{VANHAT:
   edv  <- edka,                           //<edka=vikat, voimassa olevat arvot, edka[] := edkau ???
   edvf <- edka0,-!                        //<edkafile(=alkuper käynnist) talteen<<<<<<<<<<<<<<<<<<<
   edv0 <- edkaX  !-!  :edkatype;          //<edkafile(=edka alkuper) talt<<<<<<<<<<<<<<<<<<<<<<<<<<
UUDET:            ! !
           edv,   ! !                      //<edka=vikat, voimassa olevat arvot, edka[] := edkau ???
           edvf, -! !                      //<edkafile(=filestä luettu) talt<<<<<<<<<<<<<<<<<<<<<<<<
           edv0    -!  :edvYHTtype;        //<edkafile(=alkuper käynnist) talteen<<<<<<<<<<<<<<<<<<<
                       =edv.edka[].,,,  edv.YLE.,,, jne
VANHAT:
           jk,jkf,jk0  :jkarrtype;
UUDET:
           nj,njf,nj0  :jkYHTtype;         //<Oli jk,jkf,jk0 :jkarrtype;
                       =nj.jk[].,,,  jk.jy.,,,         --------------------------------------------}

















