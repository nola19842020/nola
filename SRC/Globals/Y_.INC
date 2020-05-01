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

//¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤..\Globals\Y_.INC
function OnPvitysEstoListassa :boolean;      VAR i,u :integer;      begin //<,+6.0.0
  {if MyLicense.lisenssinumero IN LicEiPvitList             //<,-6.0.4  Ei onaa
      then result := true
      else result := false;}
   result := false;                                         //<,+6.0.4
   i := Length (LicEiPvitList);
   if i<=0  then                                            //<,+10.0.2
      SijLicEiPvitList; //<Jos ei vielä LicEiPvitList´iä ole luotu LicEiPvitStr:stä. Siirretty PaaVal.PAS´sta.

   u := Length (LicEiPvitList);                             //< +10.0.2
   for i := 0 to u-1  do                                    //Array of Integer =Dyn. array.  +12.0.03: -1
{$IFNDEF NOLALIS}
   if MyLicense.lisenssinumero = LicEiPvitList[i]  then begin
      result := true;
      Break;  end;
{$ENDIF NOLALIS}
end;
(*function OnPvitysEstoListassa :boolean;      VAR i :integer;      begin //<,+6.0.0
    {if MyLicense.lisenssinumero IN LicEiPvitList             //<,-6.0.4
        then result := true
        else result := false;}
     result := false;                                         //<,+6.0.4
     for i := 0 to Length (LicEiPvitList) -1  do
     if MyLicense.lisenssinumero = LicEiPvitList[i]  then begin
        result := true;
               //PaaValFrm.KayOikR2.Caption := Ints (LicEiPvitList[i]);
        Break;  end;
end;
CONST LicEiPvitStr='
13 14 22 26 29 30 32 37 40 41 42 44 46 47 48 54 58 64 65 66 67 68 70 74 75 77 78 88 94 96 100 101 104 105';  *)

(*function OnPvitysEstoListassa :boolean;    VAR sc,sn :string;  i,mja,alkuOs,vikaOs,maxOs :integer;  begin //<,+6.0.0
    {if MyLicense.lisenssinumero IN LicEiPvitList             //<,-6.0.4
        then result := true
        else result := false;}
     result := false;                                         //<,+6.0.4
     sn := Ints (MyLicense.lisenssinumero);
     mja := Length (LicEiPvitList);
     i := Length (sn);
     maxOs := mja -i+1;                                       //<maxOs =koko LicEi.. viimeisen nron 1. mrk.
     sc := '';  for i := 1 to Length (LicEiPvitList)  do
                    sc := sc +LicEiPvitList[i];
     alkuOs := Pos (sn +' ', LicEiPvitList);
     vikaOs := Pos (sn     , LicEiPvitList);
     if (alkuOs>0)  or (vikaOs>maxOs)
        then result := true;
     if (alkuOs<0) and (vikaOs<0) and (maxOs<0)  then beep;
end;*)
function LisLaajToStr (LisLaajuus :LicenseScope;  Pit :integer) :string;     VAR ss :string;    begin//<,,,,,,,,,,7.0.1
   case LisLaajuus of                              //'0=PRO  >0 PROfessional
      lvPRO      :if pit=0  then ss := 'PRO'    else ss := 'PROfessional';
      lvEXTended :if pit=0  then ss := 'EXT'    else ss := 'EXTended';
      lvGLOBal   :if pit=0  then ss := 'GLOB'   else ss := 'GLOBal';
   else                          ss := 'LT';  end;
   result := ss;
end;

function LisLaajToInt (LisLaajuus :LicenseScope) :integer;     VAR u :integer;    begin //+8.0.0
   case LisLaajuus of                              //'0=PRO  >0 PROfessional
      lvLT       :u := 1;
      lvPRO      :u := 2;
      lvEXTended :u := 3;
   else{lvGLOBal} u := 4;  end;
   result := u;
end;

function fVoimassaLaajTest :LicenseScope;   VAR VoimassaLaajuus :LicenseScope;  u,ru :integer;  begin//8.0.0  8.0.7
                            //<,fSALALAAJUUS määrävä =Vaikka esim. DEFS.PAS´in  TEST_LISENSSILAAJUUS tai asetettu
                            //  lisenssi olisi mitä vaan, fSALALAAJUUS MÄÄRÄÄ KAIKKIEN OHI.!!!!!!!!!!!!!!!!!!!!!!!
                            //  Se, onko mikään lisenssi voimassa, on oma asiansa, ks. esim. Demo.!!!!!!!!!!!!!!!!
   u := fSalaLaajuus (ru);                           //< -1 jos ei asetettu salaikkunassa 1...4, RU syntaxin takia.
                                                     //,u=-1 =Ei olla asetettu SalaEdit´issä, mikä olisi määräävä.
   if u=-1  then                                     //<'Salasana ohittaa LISENSSIn ja TEST_LISENSSILAAJUUDEN.
   if IsDebuggerPresent and (TEST_LISENSSILAAJUUS>0) //<TEST_LAAJUUS=0 =Ohitetaan testiajo jos IsDEBUGGERPRESENT
      then begin  u := TEST_LISENSSILAAJUUS;
                  if NOT (u IN [1..4])  then u := -1;  end;
   if u<0  then ;                                    //<'Never used.
   VoimassaLaajuus := lvLT;                          //<,,Might not.. initz. <'12.0.04
   if VoimassaLaajuus=lvLT then ;                     //<<'..never used.
{$IFNDEF NOLALIS}
   if (u=-1) and (AsetusFrm.DemoLisenssiLaajuus <> myLicense.lisenssilaajuus) //<,,+8.0.7
      then u := LisLaajToInt (AsetusFrm.DemoLisenssiLaajuus);

   if u<0  then                                      //< u=-1 =Laajuus ei ole vielä saanut arvoa =Salaikkunassa (>-1)
      VoimassaLaajuus := myLicense.lisenssilaajuus   // eikä Defs.PAS´sissa (>0) olla muuta laajuutta määrätty.
   else case u of                                    //, 1=lvLT  2=lvPRO  3=lvEXTended  4=lvGLOBal,  Ks. Y_.PAS
      1 :VoimassaLaajuus := lvLT;                    //Koeajoon: Mikä LISENSSILAAJUUS on asetettu TESTImielessä
      2 :VoimassaLaajuus := lvPRO;                   // voimaan vaikka voimassa olisi jokin muu lisenssilaajuus.
      3 :VoimassaLaajuus := lvEXTended;
      4 :VoimassaLaajuus := lvGLOBal;
    else VoimassaLaajuus := lvLT;  end;
{$ENDIF NOLALIS}
   result := VoimassaLaajuus;
end;//fVoimassaLaajTest
                     //,7.0.1  TR jos voim.oleva LisenssiLaajuus PIENEMPI kuin MinLisRaja, ehkä juuri nyt valittu.
function LisYliDemo_ (MinLisRaja :LicenseScope) :Boolean; //Esim.  LisYliDemo_ (lvPRO) = TR, jos lvLT´llä ajaa.
      VAR VoimassaLaajuus :LicenseScope;  boo :boolean;      begin//'############################################
                                           //LisenceFuncs.PAS:  LicenseScope= (lvLT, lvPro, lvExtended, lvGlobal);
                                        YFileen('LisYliDemo 0');
   boo := Demo(91);
   VoimassaLaajuus := fVoimassaLaajTest;                   //,TR jos MinLISenssiRAJA alittaa, FA jos
   boo := (MinLisRaja > VoimassaLaajuus)  OR  boo  OR      // MinLISenssiRAJA ylittää voimassa olevan lisenssin.
          (AsetusFrm.DemoLisenssiLaajuus>VoimassaLaajuus); //<Sama tarkistus ASETUKsissa mahd. tehtyyn DEMO-leh-
                  {if boo then PaaValFrm.Caption := 'LisenssiYLITYS.'                          // den valintaaan.
                   else PaaValFrm.Caption := 'Lisenssi OK.';}
   result := boo;
                                        YFileen('LisYliDemo 9');
end;

function LisYliDemo_Info (MinLisRaja :LicenseScope) :Boolean;      VAR s :string;  VoimassaLaajuus :LicenseScope;   begin
         {if IsDebuggerPresent  then  PaaValFrm.Caption := 'Nyt:' +LisLaajToStr (fVoimassaLaajTest,0) +
                   '  Dem:' +LisLaajToStr (AsetusFrm.DemoLisenssiLaajuus,0) +'  Raj:' +LisLaajToStrToStr (MinLisRaja,0);}
   result := LisYliDemo_ (MinLisRaja);
   if result  then begin
      VoimassaLaajuus := fVoimassaLaajTest;
      s := 'Tämä ohjelmaosa edellyttää vähintäin <b>' +LisLaajToStr (MinLisRaja,1) +'</b> ohjelman toimintalaajuutta';
      if Demo(92)
      then s := s +'. Nyt ilman tarvittavaa lisenssiä'
      else if MinLisRaja>VoimassaLaajuus
      then s := s +' (nyt voimassa laajuus <b>' +LisLaajToStr (VoimassaLaajuus,1) +'</b>),'
      else //if AsetusFrm.DemoLisenssiLaajuus>VoimassaLaajuus    //<Tähän tultaessa tämä ehto täyttyy aina = turha ehto.
           s := s +'. Demolaajuusvalinta = <b>' +LisLaajToStr (AsetusFrm.DemoLisenssiLaajuus,1) +'</b>, minkä takia';

      s := s +' ohjelmaosa <b>toimii esittelyversiona.</b> Jotkut ohjelman laskemat arvot eivät vastaa käyttäjän '+
           'antamien arvojen todellisia tuloksia.';
      InfoDlg (s, mtInformation, 'OK','','','',
                                 '' , '','','');
   end;
end;                                         //<''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''7.0.1

function PRO_Demo :Boolean;      begin
   result := LisYliDemo_ (lvPRO);
end;

   function fErikOikeus :Boolean;     //{VAR s :string{+12.0.04}; //8.0.0: Sallii EXT-laajuisen ajon, jos ent. Lic.asennus=OK.
         VAR boo :boolean;  i :integer;
      function fLisNo :integer;      VAR s :string;  no :integer;      begin
         no := -1;                   //<,,Might not.. initz. 12.0.04
         s := '';  if s=''  then ;
{$IFNDEF NOLALIS}
         s := Mylicense.LisenssiNum;
         while (s<>'') and (s[1]='0')  do
            Delete (s,1,1);
         if NOT (SokI (s,no) and (no>0))
            then no := -1;
{$ENDIF NOLALIS}
         result := no;
      end;//fLisNo

   begin//fErikOikeus.......................
      i := fLisNo;
      if i<0  then ;             //<'Never used.
      boo := false;              //<,,Might not.. initz. <'12.0.04
      if boo  then ;             //<..never used.
{$IFNDEF NOLALIS}
      boo := MyLicense.OK  and (i IN [{1,}10,12]); //< 1 =DEVELOPER1 testattu, OK. 10=USER1  12=USER2
{$ENDIF NOLALIS}
      result := boo;   if boo  then ;
   end;
function EXT_Demo :Boolean;      VAR boo :boolean;   begin //+8.0.0 TR= Demoajoksi jos LIS<lvEXTended (eikä ..1x).
   boo := LisYliDemo_ (lvEXTended) and (edv.YLE.SorceCount.arvoInt>1); //<Demo, jos rinnakk.liittymiä >1 ja <EXT

   if boo  then                  //<Jos olisi muuten Demoajo, mutta erikoisoikeus (USER1,USER2) sallitaan
   if fErikOikeus                // EXTended -laajuinen ajo.
      then boo := false;         //POISTAMALLA TÄMÄ OSA, SAADAAN NOLA TOIMIMAAN NORMAALEIN EHDOIN =EI KELLEKÄÄN
                                 //ERIKOISOIKEUKSIA.###########################################################
   if boo  and fKaikkiOikeudet_1x
      then boo := false;

   result := boo;   if boo  then ;
end;

function SalaSallii (MinLisRaja :LicenseScope) :Boolean;      VAR u1,u2,Q :integer;  boo :boolean;      begin
   u1 := fSalaLaajuus (u2);           //<u2 syntaxin takia.
   Q := LisLaajToInt (MinLisRaja);
   boo := (u1 IN [1..4]) and (u1>=Q); //<Jos SalaEdin arvo > MinLisRaja => SALLITAAN AJO.
   if NOT boo  then
      boo := fKaikkiOikeudet_1x;      //<SalaEdit´issä annettava 1x kaikkioikeudet -salasana.
   result := boo;        if boo  then ;
end;
             {KOEajotoimintaa voidaan ohjata KAHDELLA TAVALLA:,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                 Defs.PAS:  Ennen käänöstä:  TEST_LISENSSILAAJUUS>0.  LisYliDemo_ () KUTSUT ohjailevat toimintaa.
                                                                      '#########################################'
                   Y_.PAS:  Ajon aikana muutetaan:  Päävalikko / AsetusBtn => AsetusFrm.SalaEdi.Text '1'...'4'.
                            jolloin                                    FNC Demö := TR ja versiolaajuudeksi emNo
                                                                       '#########################################'}
function fSalaLaajuus (VAR TestiRaja :integer) :integer;                                          //Uusittu 8.0.0
      VAR s,s1,s2 :string;  u,u1,u2 :integer;      begin //< s1,u1 =TESTIRAJA   s2,u2 =LAAJUUS
    //,##########################################################################################################
    // SalaEdi´ssä voidaan antaa 2 arvoa: 1.=TESTIRAJA  2.=LAAJUUS, jos vain 1 kpl => LAAJUUS.###################
    //'##########################################################################################################
   s := Trim (AnsiUpperCase (AsetusFrm.SalaEdi.Text));        //Asetus.SalaEdi.Text´issä '1'..'4' ohjaa.   +8.0.0
   u := Pos (' ',s);
   if u>0
   then begin
      s1 := Copy (s,1,u-1);            //<Kopioidaan ' '-1 asti.    s1=TESTIRAJA.
      Delete (s,1,u);                  //<Deletoidaan u asti se ml.
      s := Trim (s);                   //<Putsataan jäljellä oleva.
      s2 := Copy (s,1,Length(s));  end //<                          s2=LAAJUUS.
   else begin                          //========================================
      s2 := s;  s1 := '';              //<                          s2=LAAJUUS.
   end;

   if s2=''  then s2 := s1;            //< Jos LAAJUUS -str oli tyhjä, TESTIRAJAstr => LAAJUUSstr

   for u := 1 to Length (s2)  do       //<,Poimitaan mjonosta 1. NUMERO.  +8.0.7
   if CharInSet(s2[u], ['0'..'9'])  then begin
      s2 := s2[u] ;  Break;  end;

   for u := 1 to Length (s1)  do       //<,Poimitaan mjonosta 1. NUMERO.  +8.0.7
   if CharInSet(s1[u], ['0'..'9'])  then begin
      s1 := s1[u] ;  Break;  end;

   if NOT SokI (s2,u2)                 //<,Jos EI kokon.luku OK eikä se 1..4 => -1
   then u2 := -1                       //  jos 1..4 => Haluttiin muuttaa ajo Demoversioksi "alemmil-
   else if NOT (u2 IN [1..4])          //  la" versioilla, esim. 2 => lvPRO ja edeltävillä laajuuk-
   then u2 := -1;                      //  silla (=lvLT,lvPRO) muuttaa toiminnan Demoksi.!!!!!!!!!!!

   if NOT SokI (s1,u1)
   then u1 := -1
   else if NOT (u1 IN [1..4])
   then u1 := -1;

   TestiRaja := u1;                                 //<,Palautuvat arvot.
   result :=    u2;
end;
                                        //DEVELOPER1: Demo päälle myös RENAME:lla WINDOWS -hakemistossa NOLA muuksi!!!!
function demoLisAs :Boolean;      begin //Käyttö OhjeEfect_ON:n esittämiseen
// result := true;
   if demo(93)  and  not LisAsennettu
      then result := true
      else result := false;//}
end;
//###################################################################################################################################
  //+12.0.03:  ,,OS lisätty kutsupaikan selvittämiseksi.
function  Demo(os :integer) :Boolean;    VAR SalaLaa,SalaRaj,DefLaa,Lic :integer;  s,sU,sA,sB :string; //UUSITTU 8.0.0, su-SB=1005
                                             esto, OnEsto,Lic_OK,Kaikki_1x,ErikOK,Debg_on,Sala_dem, bA,bB :boolean;
                                             DAr :array of string; //<+12.0.01
                                         CONST fa=false;
   procedure _DAr (so,si :string);      VAR L :integer;      begin//<,,+12.0.01
      L := Length(DAr);                 //'SO =Otsikkoteksti alkuun, esim: EriOK=.-.
      SetLength (DAr,L+1);
      DAr[L] := so +'= ' +si;  end;
   procedure DarS (so,ss :string);                begin _DAr (so,ss);             end;
   procedure DarI (so :string;  ii :integer);     begin _DAr (so,Ints(ii));       end;
   procedure DarB (so :string;  bb :boolean);     begin _DAr (so,fBmrkt0(bb,2));  end;

   procedure WrFileenDem;      //VAR ff :TextFile;  fn :string;  i :integer;  //<-120.5n
      //procedure wrRv (si :string);      begin Writeln (ff, si);  end;

   begin//WrFileenDem...................
     {fn := 'X:\Projektit XE2\NolaKehi\BIN\_Ajot\FileenDem.txt';       //120.5n:  Hannun koneessa eioo XX: -asemaa, TÄMÄ PRC vex kokonaan.
                                          DefsFileenZ('AssgnFile 18');
      AssignFile (ff,fn);
      if FileExists (fn)
         then Append (ff)
         else Rewrite(ff);
      Writeln(ff,'==============================D===== ' +DateTimeToStr(Now)); //+ ' ' + DateTimeToStr(time));
      i := Length (DAr);
      for i := 0 to i-1  do
         wrRv (DAr[i]);
      CloseFile (ff);}
   end;//WrFileenDem

   function ifLic :string;      begin result := '';
   {$IFNDEF NOLALIS}
      if MyLicense<>NIL  then result := '  øLic=OK'
                         else result := '  øLic=EIOK';
   {$ENDIF NOLALIS}
   end;//}

begin//Demo....................      //,,######################################################################,,
                                     //LisenceScope = (lvPRO,lvLT,lvEXTended,lvGLOBal), mutta paikallisesti,,,OK.
{function  Demo(os :integer) :Boolean;    VAR SalaLaa,SalaRaj,DefLaa,Lic :integer;  s,sU,sA,sB :string; //UUSITTU 8.0.0, su-SB=1005
                                             esto, OnEsto,Lic_OK,Kaikki_1x,ErikOK,Debg_on,Sala_dem, bA,bB :boolean;}
                                        YFileen ('Demo 0===' +' os=' +Ints(os));
   SalaLaa := 0;  SalaRaj := 0;  DefLaa := 0;  Lic := 0;  s := '';  sU := '';  sA := '';  sB := ''; //..,,never used
   ErikOK := fa;  Sala_dem := fa;  OnEsto := fa;  {Lic_OK := fa;  }Kaikki_1x := fa;  Debg_on := fa;  Lic_OK := fa;  bA := fa;  bB := fa;
   if (SalaLaa=0) or (SalaRaj=0) or (DefLaa=0) or (Lic=0) or (s='') or (sU='') or (sA='') or (sB='') or
      ErikOK or Sala_dem or OnEsto{=fa} or Lic_OK{=TR} or Kaikki_1x{=fa} or Debg_on{=TR} or Sala_dem{=fa}  then ;
   esto := true;  if esto or bB or bA or Lic_OK  then ;     //<..not been initz.

{$IFNDEF NOLALIS}
   case myLicense.lisenssilaajuus of //< 1=lvLT  2=lvPRO  3=lvEXTended  4=lvGLOBal (vrt.:' 1,0,2,3)
      lvLT       : Lic := 1;
      lvPRO      : Lic := 2;         //< lvPRO tulee ilmeisesti aina jo alustuksesta (siellä lvPRO=0, vrt. ed.)
      lvEXTended : Lic := 3;
   else{lvGLOBal}  Lic := 4;  end;
   LicLaajS := LisLaajToStr (myLicense.lisenssilaajuus,0);                             //<+12.0.08 mm.PaaVal´ssa MyLic.. eiOK, tämä korvaa.
          DarS ('LisLaaj',LisLaajToStr (myLicense.lisenssilaajuus,0)); //<lvLT,lvPRO..
   DefLaa :=  TEST_LISENSSILAAJUUS;  //< Defs.PAS´ssa TEST_LISENSSILAAJUUS (0,1...4).
          DarI ('DefLaa',DefLaa);
   SalaLaa := fSalaLaajuus(SalaRaj); //<AsetusFrm.SalaEdi.Text´ssä voidaan DEBUGGERIKONEESSA antaa '1'..'4'=lvLT..
          DarI ('SalaLaa',SalaLaa);  //'SalaRaj=(Mahd.) raja, jolla tai mitä alemmilla lis.laajuuksilla ajo Demoksi.
 //Lic_as :=    LisAsennettu;        //TR
   ErikOK :=    fErikOikeus;
          DarB ('ErikOK',ErikOK);
   OnEsto :=    OnPvitysEstoListassa;//fa       OnPvitysEstoListassa), jossa määritelty pvitys loppuneeksi.
          DarB ('OnEsto',OnEsto);
   Lic_OK :=    myLicense.ok;        //TR       //,,SalaEdit:ssä annetaan rajaversio (1=lvLT ..) millä ja mitä
          DarB ('Lic_OK',Lic_OK);
   Kaikki_1x := fKaikkiOikeudet_1x;  //fa       //  alemmilla lis.laajuuksilla ajo Demoksi.######################
          DarB ('Kaikki_1x',Kaikki_1x);
   Debg_on :=   IsDebuggerPresent;   //TR       //,,Sala...=Asetetaan AsetusFrm.SalaEdi´ssä,  DefLaa =Def.PAS´ssa
          DarB ('Debg_on',Debg_on);
                                        YFileen('Demo 1');
                                                //,,  <0   =Arvoa ei ole asetettu.###############################
   Sala_dem :=((SalaRaj>0) and (SalaLaa>0) and (SalaRaj<SalaLaa)               OR // SalaRaj määrää, DefLaa ei vaikuta
               (SalaRaj<0) and (SalaLaa>0) and                (SalaLaa<DefLaa) OR // SalaLaa < DefLaa määrää
                               (SalaLaa<0) and (DefLaa>0) and (DefLaa < Lic))     // DefLaa määrää jos ei Sala...
               and Debg_on;              //<VAIN OMASSAA koneessa (IsDebuggerPresent).###########################
             //'''SalaLaa ei voi olla <0, jos SalaRaj>0, koska AINA silloin SalaLaa := swn arvon.
          DarB ('Sala_dem',Sala_dem);
                                        YFileen('Demo 2');
MyLicStatusText := MyLicense.StatusText; //<,+12.0.06: Viedään tämä str PaaVal/PRC ChkLaajuusLbl´iin.
{µ~}LicNroS :=         MyLicense.LisenssiNum;
                                             //¿DefsFileenZ('Y_.INC:   øos=' +Ints (os) +' MyLicStatusText=' +MyLicStatusText +' ®® LicNroS=' +LicNroS +ifLic);
                                             YFileen('¿Y_.INC');
 { if fRePunPC(s)  then begin s := 'Y_.INC/Demo: '+ myTextBase.Get(LICENSE_INFO_23);  //<23="LISENSSI:"
                                    s := s +MyLicense.StatusText + chr(10);           //<"Kunnossa." tai ao. virheilmoitus, esim: "Odottaa lisenssin päivitystä..."
                                    ShowMessage(s);
                                    s := '';  end;}
   if OnEsto and NOT Kaikki_1x           //<NOT Kaikki_1x =Jos vaikka on unohtunut poistaa OnPvityslistasta, saadaan
   then esto := true                     // ajo DEVELOPER1:n paikalla ollessa toimimaan, vrt. koulututilaisuus.
   else if  NOT Lic_OK  and NOT ErikOK  and //< Erikoisoikeus:  LicNo.OK 1,10,12 =DEVELOPER1,USER1,USER2
            NOT Kaikki_1x   OR  //fa     // , Jos haluat DEMOksi, Sala_Dem -> (66=66)) tms.=TRUE´ksi
            Sala_Dem            //TR     //<,,Vain omassa koneessa < kokeiluun +8.0.0,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
          //and LisAsennettu                                    //<Tarpeeton: Oli asennettu eli ei => Demö -8.0.0
   then begin
        bA := false;  bB := false;
        if (demoInfoPrint = false) then begin                   // DEVELOPER2 2003-10-26 BEGIN   DEVELOPER1: Järjestely 8.0.0
           s := 'Y_.INC/Demo: '+ myTextBase.Get(LICENSE_INFO_23);  //<23="LISENSSI:"
           s := s +MyLicense.StatusText + chr(10);                 //<"Kunnossa." tai ao. virheilmoitus:
           if LisAsennettu                                         // "NolaNet-ohjelma ei ole päivittänyt lisenssiä"
           then begin                                           //,,+10.0.2 ,,,,,,,,,,,,,,,,,,,,,,,,uusittu 10.0.5u
                   sA := myTextBase.Get(LICENSE_STATUS_11);        //11="NolaNet-ohjelma ei ole päivittänyt lisenssiä."
                 //sB := myTextBase.Get(LICENSE_STATUS_8);         // 8="Lisenssi ei käy tähän versioon" +8.0.0
                   sB := 'Päivitysvirhe';
                bA := Mukana (SA,s);
                bB := Mukana (SB,s);                               //<Jos NolaNet ei päällä ehkä virheen syy ,,
                if bA or bB  then begin
                   s := s +CLR_REB +'>>> NolaNet.EXE ei ehkä ole käynnissä serverissä <<<   '+   //<,,+10.0.5u
                        FNT_B0 +'Toimii esittelyversiona. Fnc=';
                   if bA  then s := s +'bA';                       //<,,Jos NolaNet.EXE -varoitus, ilmaistaan,
                   if bA  and bB  then s := s +'+';                //   mitä virheitä on mukana.
                   if bB  then s := s +'bB';  end; end
           else begin                                              //<,,Jos lic ei asennettu vielä ollenkaan.
                SU := myTextBase.Get(LICENSE_INFO_24);             //<24="Lisätietoa kohdassa Asetukset/Lisenssi."
                s := s +SU;  end;                               //''''''''''''''''''''''''''''''''''uusittu 10.0.5u
           if OnEsto  then s := s +' (Estotila, LicNo: ' +mylicense.LisenssiNum +', ilmoita valmistajalle).'; //<+10.0.2
                                        YFileen('Demo 3');

         //Beep; //Y_piipit (5);                                   //<Beep vex -8.0.5
         //InfoDlg (s, mtCustom,  'OK','','','',  '','','','');    // DEVELOPER2 2003-10-26 END. Ei vielä luotu: "Acces violation..
           if bA or bB
           then HerjaY_S := s
           else begin
                HerjaY_S := '';
                MessageDlg (s, mtInformation, [mbOk], 0);
           end;                                                  //'''''''''''''''''''''''''''''''''uusittu 10.0.5u
        end;//demoInfoPrint=FA
        demoInfoPrint := true;
        esto := True;  end //==================<FNC => Demo := TRUE;  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   else begin//NOT Lic_OK and ..else
        esto := False;     //==================<FNC => Demo := FALSE; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        demoInfoPrint := false;
   end;
{$ENDIF NOLALIS}                                     //'Pitää Booleanmuuttujat näkyvissä debuggerille tähän asti.
   result := esto;
  {if esto
      then Windows.Beep (2500,50)                    //<,+12.0.06
      else Windows.Beep ( 100,50);}
          DarB ('FNC => ',esto);
                                        YFileen('Demo 4');
   //WrFileenDem;  //<12.0.0:  Kirjoittaa Demo´n kaikkien tekijöiden arvot fileen:  X:\Projektit XE2\NolaKehi\BIN\FileenDem.txt
                                             //¿DefsFileenZ('Y_.INC:  9øos=' +Ints (os) +' MyLicStatusText=' +MyLicStatusText +' ®® LicNroS=' +LicNroS +ifLic);
                                             YFileen('¿Y_.INC:  9..');
end;//Demo

