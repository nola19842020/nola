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

{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SyoArvOK.INC}
{Pitäisi lisätä Reaalilukusijoituksiin desim.osan katkaisut, jos vaikka annettu enemmän kuin esim.
 pudotusvalikoissa ja Cellisijoituksissa on esitetty. NYT vasta talletuksessa katkaistaan!!!!!!!!!!}
function arvoOK_(HerjOn :integer;  riv,SyoOsa :integer) :boolean;
      VAR nnn :integer{+6.2.2};   rec :EdvPalstaType{+6.2.2};
          FNC,OKbtnChk :boolean;  ValintaLaji, ii,j :integer;
          {ra,}rr,ar{+5.0.1} :real;  apus,sa,st :string;  ch :char;
  procedure mrkHerja_ (lisaherja :string);      var s :string;      begin
            if HerjOn>0  then begin             //< 0=Herja tulee  >0 =Ei herjaa
               case SyoOsa of                   //<Case  +4.0.0
                  4 :if riv<10   then s := 'Sarake '   +fImrkt0(riv,1)+' Rivi '+fImrkt0(kesno,1)
                                 else s := 'Ikkuna '   +fImrkt0(riv-10,1);
                  0  :                s := 'Ikkuna '   +fImrkt0(riv,1);
                  6  :if riv<11  then s := 'Sarake '   +fImrkt0(riv,1)  else
                      if riv=11  then s := 'Sulakekäyrän siirto[%] '    else
                                      s := 'Um ';
               else                   s := 'Rivi '+  fImrkt0(riv,1);  end;//case

               if (SyoOsa=1) and (riv>10)  then begin
                  s := lisaherja;  lisaherja := '';  end; //<Siirretään LISAHERJA ALKUUN S :ksi #######
               erPiip;                                    //< +4.0.0
               EiOkInfo {HerjaInfo }(s +' '+':   Arvo virheellinen tai puuttuu.'+lisaherja);
            end; end;
  procedure mrkHerja;      begin  mrkHerja_ ('');  end;

  procedure siOKr (r :real;    VAR tahan :real);       begin  tahan := r;  FNC := true;  end;
  procedure siOKi (i :integer; VAR tahan :integer);    begin  tahan := i;  FNC := true;  end;
  procedure siOKs (s :string;  VAR tahan :string);     begin  tahan := s;  FNC := true;  end;

  function okx (str :string;  VAR alkio :arvoTyyp): boolean;      begin  okx := false;
    if SijSRajAlkio (str, alkio)  then begin  okx := true;
                                              FNC := true;  end
                                  else mrkHerja;
  end;//okx
                                //,Oltava VAR tama, jotta kutsun SokR (..,rr,..) sijoittuisi KUTSUUN, TODETTU ###
  procedure TestSiOKr (OK_EHTO :boolean;  VAR tama,tahan :real;  EiOkHerja :string);      begin
     if OK_EHTO  then siOKr (tama,tahan)
                 else mrkHerja_ (EiOkHerja);   end;

  function RsOK_herja :boolean;      VAR Ik1v,Rs,cU,ar :real;      begin
     result := true;
    {if SyottoFrm.RadGrp.ItemIndex > 0  then begin //<PJ-liittyjä
         Ik1v := a_getReaa (110, edv.Sorc[nnn].src.Iks1v);                  //<ComBx1.Text}
   //if (SyottoFrm.RadGrp.ItemIndex > 0) and SokR (SyottoFrm.ComBx1.Text, Ik1v)  //and (Ik1v>0)  -6.2.10
     if (SyottoFrm.RadGrp.ItemIndex <> 1) and SokR (SyottoFrm.ComBx1.Text, Ik1v) //< <>1=+6.2.10 
     then begin //<PJ-liittyjä                                              //Ik1v>0 ''''''-ehto. Tuli err: Float.
         Rs :=   a_getReaa (110, edv.Sorc[nnn].src.PjLiitRs); //<ComBx3.Text  'point divByZero (jo 1.mrkstä) +5.0.1
         cU :=   a_getReaa (110, edv.YLE.cU);                 //,Xe = V¨{ [3*cU*fUv/(Ik1v*1000)]² - (3*Re)² } / 3
         ar := Sqrt ( Sqr (cU*fUv/(Ik1v*1000)));              //      V¨{ [cU*fUv/(Ik1v*1000)]² - Re² }
         if {Zs}ar<Rs  then begin                //<Ik1v :stä laskettu MaxRs liian iso =Xe pitäisi olla <0.!!!!
            result := false;
            EiOkInfo ('1) Annetulla eRs :n arvolla Ik1v ei toteudu, eXs pitäisi olla <0,  korjaa Rs tai Ik1s.');
                      {'Korjaa Ik1v takaisin ja Rs pienemmäksi.');  }end;
     end;
  end;
{,,,,,,,,,,,,,,,,,,,,,,,,,, Tutkii Box.Text(=sInp) ja vertaa sitä mjonoon sVrt.,,,,,,,,,,,,,,,,,,,,,
                            Jos löytyy, palauttaa "VIRALLISEN"(VAR tahan) tunnistejonon            }
{   M2_AvoCu = '10\16\25\35\50\70';
    S_POT    = 'PotTas;P;PT;PoT;PotT;PotTa\EiPT;E;Ei;EiP';
sInp=KULUTT. ### 'KULUTT.;K;KU;KUL;KULU;KULUT;KULUTT\SÄHKÖL.;S;SÄ;SÄH;SÄHK;SÄHKÖ;SÄHKÖL' ### s= ### sPO=KULUTT.}

(*function sVeOK_ (sInp,sVrt :string; VAR tahan :string;  lisaherja :string) :boolean;
      var i,o,mja :integer;  s,sv :string;  c :Char;  mjOK :boolean;          //< s = Tutkittu pätkä
   //...............................................................
   procedure AlkLopTyhVex (si :string);      var i,o :integer;  s :string;      begin //<+2.0.2
      i := Length(si)+1;  o := 0;
      if i>1  then                                          //<Jos i=1, sInp=tyhjä, koska äsken +1
         repeat i := i-1;
                if si[i]=' '  then o := i;
         until (si[i]<>' ') or (i=1);
      s := '';
      if o>0  then begin                                    //<Lopputyhjät vex
         for i := 1 to o-1  do s := s +si[i];
         si := s;   end;                                    //<Nyt si:ssä ei alku/lopputyhjiä
   end;
begin//sVeOK_
   result := false;
   mja := Length(sVrt);
   mjOK := true;                                            //<Uusiksi koko FNC ,,,,,,,,,,,,,,+2.0.1
   for i := 1 to Length(sInp)  do
      if sInp[i] IN [';','\']                               //<EiSallitut merkit hämäisivät sVrt';..\'
      then begin  mjOK := false;                            // =Estetään sen käyttö = lopussa herja
                  Break;  end;
   if mjOK then begin
      i := 0;
      repeat i := i+1;
             if (i<=Length(sInp))  and                      //<+4.0.1 =Aiheutti Errorin
                (sInp[i]<>' ')  then s := s + sInp[i];
      until i=Length(sInp);                                 //<Alkutyhjät vex
      sInp := s;
      if sInp=''  then mjOK := false;
   end;//if mjOK

   o := 0;
   if mjOK then begin                                       //<,,Selvitetään lopputyhjien lkm
      AlkLopTyhVex (sInp);                                  //< +2.0.2
      if sInp=''  then mjOK := false;

      AlkLopTyhVex (sVrt);                                  //< +2.0.2
      if NOT (sVrt[Length(sVrt)] IN ['\',';'])              //,Pakko lisätä, muuten \300\..\3200 :sta 3200 eiLöydy
         then sVrt := sVrt +'\';                            //<TODEETU 2.0.1 -> =korjattu 2.0.2
   end;//if mjOK
   if mjOK then begin
      s := AnsiUpperCase(sInp);  sv := AnsiUpperCase(sVrt); //<,,Tutkit onko sInp SALLITTUJEN LYHENT.JOUKOSSA ###
      if NOT (sv[1] IN ['\',';'])  then sv := '\' +sv;      //<Jotta 1. mrk erottuisi, ks.seur. testit o := Pos..
                   o := Pos ('\' + s + '\'  ,sv);           //<,,Lisätään ALKU- ja LOPPUmrkt, jotta tulisi koko
      if o=0  then o := Pos ('\' + s + ';'  ,sv);           //   VAADITTAVA mjono tutkittua SVRT :sta ###########
      if o=0  then o := Pos (';' + s + '\'  ,sv);
      if o=0  then o := Pos (';' + s + ';'  ,sv);

      if o=0                                                //< o = Löydetyn ALKUKOHDAN 1. mrk, jos >0
      then mjOK := false                                    //<Eioo löytynyt okVRTLYHENNETTÄ ####################
      else begin
         i := o+1;
         repeat i := i-1;  c := sVrt[i];                    //<,Etsitään kohdalla olevan LYHENTEEN ALKU sVrt :sta
         until (c IN [';','\']) or (i=1);                   //<Löytyi mjonon LYHENNEmjonon ALKU ';' t. SAUMA'\'

         if c IN [';','\']  then i := i+1;                  //<Ettei eka c := ';','\', ks. seur.
         i := i-1;  s := '';
         repeat i := i+1;  c := sVrt[i];                    //<,Etsitään LYHENNEmjonon LOPPU sVrt :sta
                if NOT (c IN [';','\'])
                   then s := s+c;                           //< s =mjono, JOTA VERRATAAN sInp :iin
         until (i>=mja) or (c IN [';','\']);                //<Löytyi mjonon loppu';' t. SAUMA'\'

         if AnsiUpperCase(sInp) <> AnsiUpperCase(s)
            then mjOK := false;                             //<Jos sInp eioo löydetyn VRTLYHENTEEN mukainen =EiOK
      end;
   end;//if mjOK
   if mjOK then begin                                       //<,Ei tähän jos ei o :lla arvoa
      i := o+1;
      repeat i := i-1;  c := sVrt[i];                       //<,Etsitään "VIRALL." mjonon ALKU
      until (c='\') or (i=1);                               //<Löytyi mjonon SAUMAmrk'\'="VIRALL." ALKU

      if c IN [';','\']  then i := i+1;                     //<Ettei eka c := ';','\', ks. seur.
      i := i-1;  s := '';
      repeat i := i+1;  c := sVrt[i];                       //<,Etsitään "VIRALL." mjonon LOPPU
             if NOT (c IN [';','\'])
                then s := s+c;                              //< s =mjono, joka mahd. sijoitet.
      until (i>=mja) or (c IN [';','\']);                   //<Löytyi mjonon loppu';' t. SAUMA'\'
   end;//if mjOK

   if mjOK //and (sInp<>'') and (s<>'') and (AnsiUpperCase(sInp)=AnsiUpperCase(s))
      then begin  result := true;  tahan := s;  FNC := true;  end
      else        mrkHerja_ (lisaherja);
              //Y_Koe(0,'sVeOK:  s='+s+'/// sInp='+sInp+'/// sVrt='+sVrt+'/// FNC='+fBmrkt0(FNC,2));
  end;//sVeOK_*)
//================================================================================================================

(*//,,RAJOITUS:  ARVO-OSASSA EI SAA OLLA VÄLILYÖNTIÄ =esim. "JO KINtekstiOsa" :sta HUOMIOIDAAN VAIN "JO". ##########
  function sVeOK_ (sInp,sVrt :string; VAR tahan :string;  lisaherja :string) :boolean; //4.0.2 Kokonaan uusiksi
    //VAR i,o,mja :integer;  s,sv :string;  c :Char;  mjOK :boolean;
      VAR i,o,oP,oV,oT :integer;  s,sV :string;  mjOK :boolean;                        //'= Ei huomioinut info-osaa
          tmpItms :TStringList; //' s = Tutkittu pätkä                                 //lopussa, esim.: "8 Ik3v"
      //...............................................................
begin//sVeOK_                                  //Siirretään ";", "\" ja " " väleissä olevat mjonot listaksi, josta
   tmpItms := TStringList.Create();            //helppo tutkia Items.IndexOf :lla, onko sVrt niissä edustettuina.
   tmpItms.Clear;
   sV := sVrt;
{AMCMK3½\AMCMK3½½\AMCMK4½\
AXMK;AXM\
AXCMK;AXC;AXCM\AMMK*;AMM;AMMK\
SVjärjest.;SVj;SVjä;SVjär;SVjärj;SVjärje;SVjärjes;SVjärjest\          //<-6.0.2
SVsystAL3½\SVsystCu3½\SVsystAL4N\SVsystCu4N\SVsystAL5S\SVsystCu5S\    //<+6.0.2
APAKM*;AP;APA;APAK;APAKM\
AMKA;AMK\
AVOJOHal;AVOa;AVOal;AVOJa;AVOJal;AVOJOa;AVOJOal;AVOJOHa\
MCMK3½\MCMK3½½\MCMK4½\
MMJ/MMK*;MM;MMJ;MMK;MMJ,MMK;MMJ.MMK;MMJ:MMK;MMJ/MMK;MMJ MMK\
PLKVJ*;P;PL;PLK;PLKV;PLKVJ\
AVOJOHcu;AVc;AVcu;AVOc;AVOcu;AVOJc;AVOJcu;AVOJOc;AVOJOcu;AVOJOHc\ }
   while Length (sV)>0  do begin
      while (Length (sV)>0) and (sV [1] IN [';','\',' '])  do
         Delete (sV,1,1);                                      //<'Alkutyhjät ja alkuerottimet vex
      while (Length (sV)>0) and (sV [Length (sV)] IN [';','\',' '])  do
         Delete (sV,Length (sV),1);                            //<'Lopputyhjät ja loppuerottimet vex
                                                               //,Etsitään erottimet, mihin asti kopioitaisiin
      oP := Pos (';',sv);   oV := Pos ('\',sv);   oT := Pos (' ',sv);
      o := 0;
      if oP>0  then o := oP;                                //< ";" ,,Etsitään lähin erotin = lyhyin mjono
      if (oV>0) and ((oV<o) or (o=0))  then o := oV;        //< "\"
      if (oT>0) and ((oT<o) or (o=0))  then o := oT;        //< " "

      if o=0                                                //<Erotinta ei löytynyt =Otetaan koko mjono
      then begin s := sv;
                 i := Length (sV)+1;  end                   //<Ohjaa ulos Whilesta
      else begin s := Copy (sV,1,o-1);                      //<Kopiodaan erotinta edeltävään mrkiin asti
                 i := oP;
                 if (oV>0) and ((oV<i) or (i=0))  then i := oV;
                 i := i+1;  end;
      tmpItms.Add(s);
      sV := Copy (sV,i,200);
   end;

   sInp := Trim (sInp);
   s := '';
   for i := 1 to Length (sInp)  do
      if sInp[i]=' '  then Break
                      else s := s +sInp[i];

   mjOK := false;
   sV := '';
   o := tmpItms.IndexOf (AnsiUpperCase (s));
   if (s<>'') and (o>-1)  then begin
      sV := tmpItms[o];
      mjOK := true;  end;

   result := false;
   if mjOK //and (sInp<>'') and (s<>'') and (AnsiUpperCase(sInp)=AnsiUpperCase(s))
      then begin  result := true;  tahan := sV;  FNC := true;  end
      else        mrkHerja_ (lisaherja);
              //Y_Koe(0,'sVeOK:  s='+s+'/// sInp='+sInp+'/// sVrt='+sVrt+'/// FNC='+fBmrkt0(FNC,2));
  tmpItms.free;
  end;//sVeOK_;*)
//================================================================================================================
(* procedure NollaaMuutPht;      VAR u,oli :integer;  s :string;      begin //<+120.5o:  Nollaa muutPh´t myös RinnSorceissa. EI SITTENKÄÄN KÄUTÖSSÄ.
      if HerjOn>0  then begin
         oli := 0;
         if SrcEdka                                        //,,Tarkistetaan ja muutetaan 0´ksi jos on muissa pisteissä jo Ph-arvot + ilmoitetaan muutoksista.
         then begin
            for u := 1 to edv.YLE.SorceCount.ArvoInt  do
            if u<>edi  then begin
               a_putReaa (2111, 0,edv.Sorc[u].josa.Ph);
               oli := oli +1;  end; end
         else for u := 1 to edv.YLE.JohtoOsia.ArvoInt  do  //,,OLI kasvaa VAIN jommalla kummalla osuudella:  Sorc tai Edka.
            if u<>edi  then begin
               a_putReaa (2111, 0,edv.edka[u].Ph);
               oli := oli +1;  end;

         s := 'olevat Ph-arvot uh%-laskentaan nollattu.';
         if oli>0  then
         if SrcEdka
            then ShowMessage('Muissa liittymäkaapeleissa ' +s)
            else ShowMessage('Muissa johto-osuuksissa ' +s);
   end; end;//NollaaMuutPht *)
//================================================================================================================
//,,######################### RAJOITUS:  ARVO-OSASSA EI SAA OLLA VÄLILYÖNTIÄ #####################################
                                      //4.0.2 Kokonaan uusiksi = Ei huomioinut info-osaa lopussa, esim.: "8 Ik3v".
  function sVeOK_ (REA :boolean;  sInp,sVrt :string; VAR tahan :string;  lisaherja :string) :boolean;
                 //'''TR = Tutkitaan vain alun REAL = lopun selitystxt ei huomioida. =+6.0.2
      CONST arrRowMax=100;  arrColMax=10; {arrRowMax=4;  arrColMax=4;}
      VAR i,o,row,col, oP,oV :integer;  s,sV :string;  mjOK :boolean;  ri,rv :real;  //<row,col =Arrayn osoitteet.
          arr :array [1..arrRowMax,1..arrColMax] of string; //' s = Tutkittu pätkä   ''";"=col -erotin, "\"=row -erotin
          //''AMCMK3½\AMCMK3½½\AMCMK4½\  => Esim. arr[1,1]='AMCMK3½',  arr[1,2..20]=''
          //''                                    arr[2,1]='AMCMK3½½', arr[2,2..20]=''  jne.
          //''AXMK;AXM\                  =>       arr[1,1]='AXMK',     arr[1,2]='AXM',  arr[1,3..]=''
      //...............................................................
begin//sVeOK_                                  //Siirretään ";", "\" ja " " väleissä olevat mjonot listaksi, josta
{  S_KaTyp = '
AMCMK3½\AMCMK3½½\AMCMK4½\AXMK;AXM\AXCMK;AXC;AXCM\AMMK*;AMM;AMMK\KiskAbb-AlN\KiskAbb-AlS\KiskAbb-CuN\KiskAbb-CuS\KiskAbb-CuNx\KiskAbb-CuSx\SVsystAL3½\SVsystCu3½\SVsystAL4N\SVsystCu4N\SVsystAL5S\SVsystCu5S\APAKM*;AP;APA;APAK;APAKM\AMKA;AMK\AVOJOHal;AVOa;AVOal;AVOJa;AVOJal;AVOJOa;AVOJOal;AVOJOHa\MCMK3½\MCMK3½½\MCMK4½\MMJ/MMK*;MM;MMJ;MMK;MMJ,MMK;MMJ.MMK;MMJ:MMK;MMJ/MMK;MMJ MMK\PLKVJ*;P;PL;PLK;PLKV;PLKVJ\AVOJOHcu;AVc;AVcu;AVOc;AVOcu;AVOJc;AVOJcu;AVOJOc;AVOJOcu;AVOJOHc\
'Riveiksi putettuna,,,:                                             ,,DetEvFrm.aRcih´iin tulostettuna (nyt OK):
AMCMK3½\                   -      -      -      -      -      -      1:  AMCMK3½|#|#|#|#|#|#|#|#|#|                                         
AMCMK3½½\                  -      -      -      -      -      -      2:  AMCMK3½½|#|#|#|#|#|#|#|#|#|                                        
AMCMK4½\                   -      -      -      -      -      -      3:  AMCMK4½|#|#|#|#|#|#|#|#|#|                                         
AXMK;AXM\                  -      -      -      -      -      -      4:  AXMK|AXM|#|#|#|#|#|#|#|#|                                          
AXCMK;AXC;AXCM\            -      -      -      -      -      -      5:  AXCMK|AXC|AXCM|#|#|#|#|#|#|#|                                      
AMMK*;AMM;AMMK\            -      -      -      -      -      -      6:  AMMK*|AMM|AMMK|#|#|#|#|#|#|#|                                      
KiskAbb-AlN\               -      -      -      -      -      -      7:  KiskAbb-AlN|#|#|#|#|#|#|#|#|#|                                     
KiskAbb-AlS\               -      -      -      -      -      -      8:  KiskAbb-AlS|#|#|#|#|#|#|#|#|#|                                     
KiskAbb-CuN\               -      -      -      -      -      -      9:  KiskAbb-CuN|#|#|#|#|#|#|#|#|#|                                     
KiskAbb-CuS\               -      -      -      -      -      -     10:  KiskAbb-CuS|#|#|#|#|#|#|#|#|#|                                     
KiskAbb-CuNx\              -      -      -      -      -      -     11:  KiskAbb-CuNx|#|#|#|#|#|#|#|#|#|                                    
KiskAbb-CuSx\              -      -      -      -      -      -     12:  KiskAbb-CuSx|#|#|#|#|#|#|#|#|#|                                    
SVsystAL3½\                -      -      -      -      -      -     13:  SVsystAL3½|#|#|#|#|#|#|#|#|#|                                      
SVsystCu3½\                -      -      -      -      -      -     14:  SVsystCu3½|#|#|#|#|#|#|#|#|#|                                      
SVsystAL4N\                -      -      -      -      -      -     15:  SVsystAL4N|#|#|#|#|#|#|#|#|#|                                      
SVsystCu4N\                -      -      -      -      -      -     16:  SVsystCu4N|#|#|#|#|#|#|#|#|#|                                      
SVsystAL5S\                -      -      -      -      -      -     17:  SVsystAL5S|#|#|#|#|#|#|#|#|#|                                      
SVsystCu5S\                -      -      -      -      -      -     18:  SVsystCu5S|#|#|#|#|#|#|#|#|#|                                      
APAKM*;AP;APA;APAK;APAKM\  -      -      -      -      -      -     19:  APAKM*|AP|APA|APAK|APAKM|#|#|#|#|#|                                
AMKA;AMK\                                                           20:  AMKA|AMK|#|#|#|#|#|#|#|#|
AVOJOHal;AVOa;AVOal;AVOJa;AVOJal;AVOJOa;AVOJOal;AVOJOHa\            21:  AVOJOHal|AVOa|AVOal|AVOJa|AVOJal|AVOJOa|AVOJOal|AVOJOHa|#|#|       
MCMK3½\                    -      -      -      -      -      -     22:  MCMK3½|#|#|#|#|#|#|#|#|#|                                          
MCMK3½½\                   -      -      -      -      -      -     23:  MCMK3½½|#|#|#|#|#|#|#|#|#|                                         
MCMK4½\                    -      -      -      -      -      -     24:  MCMK4½|#|#|#|#|#|#|#|#|#|                                          
MMJ/MMK*;MM;MMJ;MMK;MMJ,MMK;MMJ.MMK;MMJ:MMK;MMJ/MMK;MMJ MMK\        25:  MMJ/MMK*|MM|MMJ|MMK|MMJ,MMK|MMJ.MMK|MMJ:MMK|MMJ/MMK|MMJ MMK|#|     
PLKVJ*;P;PL;PLK;PLKV;PLKVJ\                                         26:  PLKVJ*|P|PL|PLK|PLKV|PLKVJ|#|#|#|#|
AVOJOHcu;AVc;AVcu;AVOc;AVOcu;AVOJc;AVOJcu;AVOJOc;AVOJOcu;AVOJOHc\   27:  AVOJOHcu|AVc|AVcu|AVOc|AVOcu|AVOJc|AVOJcu|AVOJOc|AVOJOcu|AVOJOHc|}

   for i := 1 to arrRowMax  do                                 //<,Alustus +6.0.2
   for o := 1 to arrColMax  do  arr[i,o] := '';         {DetEvFrm.aRich.Clear;
                                                         DetEvFrm.aRich.Font.Name := 'Courier New';}
   sV := sVrt;
   Row := 1;  Col := 1;
   while Length (sV)>0  do begin                        {DetEvFrm.aRich.Lines.Add (''); DetEvFrm.aRich.Lines.Add (sV);
                                                         //DetEvFrm.ShowModal;//}
      while (Length (sV)>0) and (CharInSet(sV [1], [';','\',' ']))  do
         Delete (sV,1,1);                                      //<'Alkutyhjät ja alkuerottimet vex
      while (Length (sV)>0) and (CharInSet(sV [Length (sV)], [';','\',' ']))  do
         Delete (sV,Length (sV),1);                            //<'Lopputyhjät ja loppuerottimet vex
                                                               //,Etsitään erottimet, mihin asti kopioitaisiin
      oP := Pos (';',sv);   oV := Pos ('\',sv);             //<Sakake-erotin (oP) ja rivierotin (oV)
      o := 0;
      if oP>0  then o := oP;                                //< ";" ,,Etsitään lähin erotin = lyhyin mjono
      if (oV>0) and ((oV<o) or (o=0))  then o := oV;        //< "\"

      if o=0                                                //<Erotinta ei löytynyt =Otetaan koko mjono
      then begin s := sV;
                 i := Length (sV)+1;  end                   //<Erottimesta SEUR. mrkstä lähtien.  Ohjaa ulos Whilesta
      else begin s := Copy (sV,1,o-1);                      //<Kopiodaan erotinta edeltävään mrkiin asti
                 i := oP;                                   //<,Seur.iter.varten kopioidaan sV :hen seur.mrkstä alkaen.
                 if (oV>0) and ((oV<i) or (i=0))  then i := oV;
                 i := i+1;  end;

      arr[Row,Col] := s;                                    //,6.0.2 korj:  Oli 300, nyt Length (sVrt)
      sV := Copy (sV,i,Length (sVrt));                      //<sV :hen erottimesta SEUR. mrkstä lähtien.
      
      if o=oV                                               //<,Yhden vaihtoehtoSARJAN loppu, esim. 'A;AA\...'
      then begin
         Row := Row+1;  Col := 1;  end
      else Col := Col+1;
   end;{Length (sV)>0}                              (*DetEvFrm.aRich.Lines.Add ('');  sV := '';
                                                      for i := 1 to 30{arrRowMax}  do begin
                                                         DetEvFrm.aRich.Lines.Add (sV);   sV := '';
                                                         for o := 1 to arrColMax  do begin  s := arr[i,o];
                                                            if s=''  then s := '#';
                                                            if o=1  then s := fImrkt0 (i,2) +':  ' +s; //<RivNo
                                                            sV := sV +s +'|';  end;  end;   DetEvFrm.ShowModal;//*)
   sInp := Trim (sInp);                                   //<,,Putsataan SINP:sta tyhjän välin jälkeiset infotVex
   s := '';
   for i := 1 to Length (sInp)  do
      if sInp[i]=' '  then Break
                      else s := s +sInp[i];
   mjOK := false;
   sV := '';
   for i := 1 to arrRowMax  do
   for o := 1 to arrColMax  do
       if arr[i,o]=''
       then break
      {else if AnsiUpperCase (arr[i,o]) = AnsiUpperCase (s)
       then begin  sv := arr[i,1];
                   mjOK := true;
                   break;  end;}                     //,,Selitysosa Real/Intg -osan jälk. poistetaan = +6.0.2
       else if     REA  and SokR (s,ri)  and SokR (arr[i,o], rv)  and (ri=rv)  OR
               NOT REA  and SamIso (arr[i,o], s)
       then begin  sV := arr[i,1];
                   mjOK := true;
                   break;  end;

   result := false;
   if mjOK //and (sInp<>'') and (s<>'') and (AnsiUpperCase(sInp)=AnsiUpperCase(s))
      then begin  result := true;  tahan := sV;  FNC := true;  end
      else        mrkHerja_ (lisaherja);
              //Y_Koe(0,'sVeOK:  s='+s+'/// sInp='+sInp+'/// sVrt='+sVrt+'/// FNC='+fBmrkt0(FNC,2));
  end;//sVeOK_;
  {,,,,,,,,,,,,,,,,,,,,,,,,,}
  function sVeOK (sInp,sVrt :string; VAR tahan :string) :boolean;      begin
    {sVeOK_ ('8 Ik3vMax', '1\8\9',         tahan,'');
     sVeOK_ ('8 Ik3vMax', '\2\8 Ik3v\9',   tahan,'');
     sVeOK_ ('8 Ik3vMax', '  1\\\8\9',     tahan,'');
     sVeOK_ ('8 Ik3vMax', '',              tahan,'');
     sVeOK_ ('8 Ik3vMax', ' ',             tahan,'');
     sVeOK_ ('8 Ik3vMax', '\\\\',          tahan,'');
     sVeOK_ ('8 Ik3vMax', '1 \8\9',        tahan,'');
     sVeOK_ ('8 Ik3vMax', '8 Ik3v\9',      tahan,'');}
    {sVeOK_ ('8 Ik3vMax', '8\9',           tahan,'');
     sVeOK_ ('8 Ik3vMax', '7;8;9\a',       tahan,'');
     sVeOK_ ('8 Ik3vMax', 'a\7;8;9\B',     tahan,'');}

     result := sVeOK_ (FALSE,sInp,sVrt,tahan,'');                                         //< +FALSE = +6.0.2
  end;
  {,,,,,,,,,,,,,,,,,,,,,,,,,}
  function sVeOKr (sInp,sVrt :string; VAR tahan :string) :boolean;      begin                       //<+6.0.2
     result := sVeOK_ (TRUE, sInp,sVrt,tahan,''); //< TR = Tutkitaan vain alun REAL = lopun selitystxt ei huomda.
  end;
  {,,,,,,,,,,,,,,,,,,,,,,,,,}

  function cVeOK (sInp,sVrt :string;  VAR tahan :char) :boolean;
       var i,mja :integer;  s :string;      begin
    Result := false;
    mja := Length(sVrt);                                 //<sVrt = esim. (as.tavat: S_AsTap) A\C\D
    i := 0;  s := '';                                    //< s :ään tutkittu sVrt :n pätkä
    if sVrt<>''  then
    repeat
       s := '';
       i := i+1;                      //,,,,,,'\' riittäisi <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
       while (i< mja) and     (CharInSet(sVrt[i], [';','\']))  do i := i+1;
       while (i<=mja) and NOT (CharInSet(sVrt[i], [';','\']))  do begin  s := s+sVrt[i];  i := i+1;  end;
       if i<mja  then i := i-1;      //<Pakitetaan 1x, muuten c menee ohi, TODETTU, MUTTA testi pa-
                                     //'kollinen, muuten ikuinen silmukka joissain tap:ssa, TODETTU.
                                     //'Vikan mrkn jälk i=mja+1, joten UNTIL lopettaa ##############
    until SamIso (sInp,s) and (sInp<>'') or (i>=mja);

    if SamIso (sInp,s) and (sInp<>'')
       then begin  Result := true;  tahan := s[1];  FNC := true;  end
       else        mrkHerja;
  end;//cVeOK;
//================================================================================================================
//================================================================================================================
//================================================================================================================
begin//arvoOK_                            SyoOsa / Riv / Index  =>  SyoOsa / Index(=ValintaLaji) / Riv =8.0.14
nnn := edi; //<Sijoitus tarkistettava kun rinnakkaissyöttöNroMuuttuja on toteutettu,!!!!!!!!!!!!!!!!+6.2.2
FNC := false;      //,,RadGrp.  //apus := 'FNCarvoOK  Alku:  Riv='+fImrkt0(riv,1);   Y_Koe (2,apus);
                   //¿DefsFileenZ('SyoArvOK.INC/arvoOK_:1  Riv:' +Ints(riv) +'  SyoOsa:' +Ints(SyoOsa));
ValintaLaji := SyottoFrm.RadGrp.ItemIndex; //+8.0.12:  APULASKRUUTU avautuu vain Sj+Pj :llä ja Rv :=+10 joten jos
if (riv>10) and (ValintaLaji<2)  then      // RIV>=11, kutsu on apulaskRuudusta, minkä mrkiksi ValintaLaji=66.!!!!
   ValintaLaji := 66;                      //'muute ValintaLaji on sama kuin RadGrp.ItemIndex.!!!!!!!!!!!!!!!!!!!!

with SyottoFrm  do //,,ItemIndex, Rivit,,,,,,,,,,,,,,,,,,,,,  LIITTYMÄT (SyoOsa1,6):  NÄMÄ RIVIT KÄYTÖSSÄ =OLTAVA TOIMINTA.!!!!!!!!!!
                        // 0=Sj:  1,2,3,4,-,6                 - = <,Tyhjä rivi =Ei arvoBoxia =Ei sijoitettavaa.
                        // 1=Pj:  1,2,3,-,5                       SyoOsa (=SyoKut) on kuvattu Syotto.PAS´in alussa.
                        // 2=Vv:  1,2,3,4,5,6,7,8,9,10,11,12
   //SyoOsa<=SyoKut.    // 3=UPS: 1,2,3
case SyoOsa of //,SyoOsa:  0=VrkKuvaajan yläpanelin Bxt  1=Liitt  2=EdvJ  (3=Uh-raj, eiEnää)  4=Nj
0 :case riv of //          5=Häviökust  6=LisätLIITTYMÄ  7=LisätJohto-osa  8=MoottLähdöt
   1 :okx( EdvNewFrm.UnCmBx.Text, edv.YLE.Un);           //<,VrkKuvaajan yläpanelin Bxt
   2 :okx( EdvNewFrm.cUCmBx.Text, edv.YLE.cU);
   3 :okx( EdvNewFrm.LaakMBx.Text,edv.YLE.LaakPmu);  end;//case riv <+130.2e
{,SyoOsa}
1,6 :case ValintaLaji of//ValintaLaji:  0=Sj  1=Pj  66=Apulask.  2=Gen  3=UPS,  edv.Sorc[mmm].src.SorceKind EHKEIokVielä.
0 :case riv of //ValintaLaji:  0=Sj ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
{r}1 :okx( ComBx1.Text, edv.Sorc[nnn].src.Smn);
   2 :if sVeOK (SyottoFrm.ComBx2.Text, '1\2\3\8\9\11\12\13\18\19',apus)  then
      okx( SyottoFrm.ComBx2.Text, edv.Sorc[nnn].src.TrfTyp);
   3 :okx( SyottoFrm.ComBx3.Text, edv.Sorc[nnn].src.yvRs);
   4 :okx( SyottoFrm.ComBx4.Text, edv.Sorc[nnn].src.yvXs);
  {5 =Tyhjä rivi =Ei Boxia.}
   6 :begin ar := 0;  rr := 0;  sa := SyottoFrm.ComBx6.Text;
         fnc := PEN_PE_LenkkiOK  (sa, ar,rr);             //<ar,rr kasvaa jos OK (ei käyttöä tässä).
         SyottoFrm.ComBx6.Text := sa;                     //<Lisätään palautunut str box´iin (sis. CLR_RED) +9.0.1
         if fnc  then SijStrAlkio(sa, edv.YLE.PEN_PE);  end;end;//case
1 :case riv of //ValintaLaji:  1=Pj ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
{r}1 :if RsOK_herja  then                      //<,"Annetulla eRs :n arvolla Ik1v toteuTUU" (muuten herja siellä).
      okx( SyottoFrm.ComBx1.Text, edv.Sorc[nnn].src.Iks1v);
   2 :okx( SyottoFrm.ComBx2.Text, edv.Sorc[nnn].src.Iks3v);
   3 :okx( SyottoFrm.ComBx3.Text, edv.Sorc[nnn].src.PjLiitRs);
  {4 =Tyhjä rivi =Ei Boxia.}
   5 :begin ar := 0;  rr := 0;  sa := SyottoFrm.ComBx5.Text;    //<,+8.0.12
         fnc := PEN_PE_LenkkiOK  (sa, ar,rr);             //<ar,rr kasvaa jos OK (ei käyttöä tässä).
         SyottoFrm.ComBx6.Text := sa;                     //<Lisätään palautunut str box´iin (sis. CLR_RED) +9.0.1
         if fnc  then SijStrAlkio(sa, edv.YLE.PEN_PE);  end;end;//case
66:case riv of //ValintaLaji:  66=Apulask.¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
               //,,Puuttuu riv: 15,23,24,35,42..44, mutta sijoitus PRC PvitaYHT :ssä.
               //,,Herja jos EHTO,,.............................) ei täyty, TALLETTAA jos täyttyy.
{r}11 :TestSiOKr (SokR (SyottoFrm.CyBx11.Text,rr) and (rr>=0.024)       ,rr, Yvrk[riv], 'U1');
   12 :TestSiOKr (SokR (SyottoFrm.CyBx21.Text,rr) and (rr>0.0001)       ,rr, Yvrk[riv], 'Sk');
   14 :TestSiOKr (SokR (SyottoFrm.CyBx31.Text,rr) and (rr>0)            ,rr, Yvrk[riv], 'Ry');
   16 :TestSiOKr (SokR (SyottoFrm.CyBx40.Text,rr) and (rr>0.001)        ,rr, Yvrk[riv], 'Sm');

   17 :TestSiOKr (SokR (SyottoFrm.CyBx51.Text,rr) and (rr>1)            ,rr, Yvrk[riv], 'Zk%');
 (*18 :begin {ra := fUn/1000;}   ar := Yvrk[11];                        //<ar=U1
       TestSiOKr (SokR (SyottoFrm.CyBx61.Text,rr) and (ar>=0.01{10V})  ,rr, Yvrk[riv], 'U2');  end;  //<+6.0.0a*)
   18 :begin {ra := fUn/1000;}   //ar := Yvrk[11{U1}];                                               //<-10.0.4
       TestSiOKr (SokR (SyottoFrm.CyBx61.Text,rr) and (rr>=0.024{24V})  ,rr, Yvrk[riv], 'U2');  end; //<+6.0.0a
   19 :TestSiOKr (SokR (SyottoFrm.CyBx71.Text,rr) and (rr>0)            ,rr, Yvrk[riv], 'Rv');
                                                                            //,,Yläverkon oikea Bx-palsta
   31 :if MuuLsk IN [1]  then
       TestSiOKr (SokR (SyottoFrm.CyBx12.Text,rr) and (rr>0) and (rr<1) ,rr, Yvrk[riv], 'Cosfi')  else //<+10.0.4
       TestSiOKr (SokR (SyottoFrm.CyBx12.Text,rr) and (rr>0)            ,rr, Yvrk[riv], 'Ry/Xy');
   32 :TestSiOKr (SokR (SyottoFrm.CyBx22.Text,rr) and (rr>0.01)         ,rr, Yvrk[riv], 'Ik3v');
   34 :TestSiOKr (SokR (SyottoFrm.CyBx32.Text,rr) and (rr>0)            ,rr, Yvrk[riv], 'Xy');
   37 :TestSiOKr (SokR (SyottoFrm.CyBx52.Text,rr) and (rr>0.1)          ,rr, Yvrk[riv], 'Pk');
   38 :TestSiOKr (SokR (SyottoFrm.CyBx62.Text,rr) and (rr>=0)           ,rr, Yvrk[riv], 'L[m]');
   39 :TestSiOKr (SokR (SyottoFrm.CyBx72.Text,rr) and (rr>0)            ,rr, Yvrk[riv], 'Xv');
   41 :TestSiOKr (SokR (SyottoFrm.CyBx80.Text,rr) and (rr>0)            ,rr, Yvrk[riv], 'Lv');   end;//case riv
2 :case riv of //ValintaLaji:  2=Vv ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
{r}1 :okx( SyottoFrm.ComBx1.Text,  edv.Sorc[nnn].src.gSn);
   2 :okx( SyottoFrm.ComBx2.Text,  edv.Sorc[nnn].src.gXd);
   3 :okx( SyottoFrm.ComBx3.Text,  edv.Sorc[nnn].src.gXd1);
   4 :okx( SyottoFrm.ComBx4.Text,  edv.Sorc[nnn].src.gXd2);
   5 :okx( SyottoFrm.ComBx5.Text,  edv.Sorc[nnn].src.gRs);
   6 :okx( SyottoFrm.ComBx6.Text,  edv.Sorc[nnn].src.gTd1);
   7 :okx( SyottoFrm.ComBx7.Text,  edv.Sorc[nnn].src.gTd2);
   8 :okx( SyottoFrm.ComBx8.Text,  edv.Sorc[nnn].src.gtIkMin);
   9 :okx( SyottoFrm.ComBx9.Text,  edv.Sorc[nnn].src.gtIkSust);
  10 :okx( SyottoFrm.ComBx10.Text, edv.Sorc[nnn].src.gIkSust);
  11 :okx( SyottoFrm.ComBx11.Text, edv.Sorc[nnn].src.gK1vSust);
  12 :begin ar := 0;  rr := 0;  sa := SyottoFrm.ComBx12.Text;
         fnc := PEN_PE_LenkkiOK  (sa, ar,rr);                   //<ar,rr kasvaa jos OK (ei käyttöä tässä).
         if fnc  then SijStrAlkio(sa, edv.YLE.PEN_PE);  end;end;//case
3 :case riv of //ValintaLaji:  3=UPS ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
{r}1 :begin okx( SyottoFrm.ComBx1.Text,  edv.Sorc[nnn].src.{Iks1v}Ups_Ik1v); //<,,,141.1  FileEv.INC´ssä myös jo hoidettu.
            for j := 1 to edv.YLE.SorceCount.ArvoInt  do                     //<,,Kaikkiin sama arvo vaikka ei rinnakkaisia olekaan.
               edv.Sorc[j].src.Ups_Ik1v.ArvoRea := edv.Sorc[nnn].src.Ups_Ik1v.ArvoRea;  end;
   2 :begin okx( SyottoFrm.ComBx2.Text,  edv.Sorc[nnn].src.{Iks3v}Ups_Ik3v);
            for j := 1 to edv.YLE.SorceCount.ArvoInt  do
               edv.Sorc[j].src.Ups_Ik3v.ArvoRea := edv.Sorc[nnn].src.Ups_Ik3v.ArvoRea;  end;
   3 :begin okx( SyottoFrm.ComBx3.Text,  edv.Sorc[nnn].src.Ups_Cos);         //<,,+141.1  Tämä on kokonaan uusi rv.
            for j := 1 to edv.YLE.SorceCount.ArvoInt  do
               edv.Sorc[j].src.Ups_Cos.ArvoRea := edv.Sorc[nnn].src.Ups_Cos.ArvoRea;  end;
   4 :begin ar := 0;  rr := 0;  sa := SyottoFrm.ComBx4.Text;
         fnc := PEN_PE_LenkkiOK  (sa, ar,rr);             //<ar,rr kasvaa jos OK (ei käyttöä tässä).
         SyottoFrm.ComBx4.Text := sa;                     //<Lisätään palautunut str box´iin (sis. CLR_RED) +9.0.1
         if fnc  then SijStrAlkio(sa, edv.YLE.PEN_PE);  end;end;//case
end;//case ValintaLaji
//,SyoOsa:  2=Edv  7=LisätJohto-osa ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
2,7 :begin OKbtnChk := false;  if riv>20  then begin OKbtnChk := true;  riv := riv -20;  end; //< +1.1.4
     if SrcEdka  then rec := edv.Sorc[nnn].Josa
                 else rec := edv.Edka[nnn];
//130.3u,,141.1
   if JkUpsChk_Dlg  or JkUpsChk_Cap //SyottoFrm.JkUpsChk.Checked //(edv.Edka[Edi].JkUps.ArvoInt=1{+141.2})       //<,,+130.3ups  141.2
   then begin
             {JFileen('2/1 "2,7"SyoArvOK / SyoKut=' +Ints(SyoKut) +' riv=' +Ints(riv));
              JFileen('2/1 SyoArvOK /');
             {If IsDebuggerPresent
                 then ShowMessage('JkUps_Ik..cos kesken');}
      case riv of
         1 :okx( SyottoFrm.ComBx1.Text,  rec.JkUps_Ik1v);
       //2 :okx( SyottoFrm.ComBx2.Text,  rec.JkUps_Ik3v);      //<Ei tarvita JkUPS -haaraan.
         2 :okx( SyottoFrm.ComBx2.Text,  rec.JkUps_Cos);       //<ComBx3 => ComBx2
      else  begin ar := 0;  rr := 0;  sa := SyottoFrm.ComBx3.Text;
                  fnc := PEN_PE_LenkkiOK  (sa, ar,rr);               //<ar,rr kasvaa jos OK (ei käyttöä tässä).
                  if fnc  then SijStrAlkio(sa, edv.YLE.PEN_PE);  end;end;//case
               {if fRePunPC(sa)  then begin SyottoAvFrm.Hide;                               //<,,+1411 fRePunKone => fRePunPC
                   EdvNewFrm.KuvausEdit.Text := 'JkUps[' +Ints(nnn) +']: Ik1v:' +SyottoFrm.ComBx1.Text +' rc:' +fRmrkt0(rec.JkUps_Ik1v.ArvoRea,1,2) +
                                                '  Cos:' +SyottoFrm.ComBx2.Text +' rc:' +fRmrkt0(rec.JkUps_Cos.ArvoRea,1,2) +
                                                ' Edka.Ik1v:' +fRmrkt0(edv.Edka[nnn].JkUps_Ik1v.ArvoRea,1,2); end;}
     {if SrcEdka  then edv.Sorc[nnn].Josa := rec                                              //<,Nämä 2 rv oli lopummassa, nyt tähän josko JkUps_:=  nytOK?
                  else edv.Edka[nnn]      := rec;}
      if riv<-99  then ;
   end else//if JkUpsChk_Dlg                                                                  //<,,+130.3ups
//130.3u''141.1
   case riv of//,,+20 := OkBtnClick / edvPvitOK :ssa = Tarkistus poistuttaessa syöttölomakkeesta
   1 :if sVeOK( ComBx1.Text,S_KulSal,apus)           //,, (0,S_KulSal)  0=1.VE ='KULUTT.' Tiedetään
         then if apus=EtsiOlet(0,S_KulSal)  then a_putBool (211,TRUE, rec.kuluttaja)
                                            else a_putBool (212,FALSE,rec.kuluttaja);
   2 :if sVeOK( ComBx2.Text,S_KaTyp,apus)   then begin  {,,,,,,,,,,,,,,,,Tyyppi,,,,,,,,,,,,,,,,,,,,}
         SijStrAlkio( apus, rec.tyyppi);
        {if OKbtnChk  then                              //<+1.1.4 = if OKbtnChk .. +POISTETTU: Syy LKM:ssä, eiTYP
         with edv.edka[edi]  do if (a_getStrg (221,tyyppi)='SVjärjest.') and (a_getIntg (222,lukumaara)>1)
              then begin FNC := false;  mrkHerja;  end;  }end;
   3 :begin                                             {,,,,,,,,,,,,,,,mm2,,,,,,,,,,,,,,,,,,,,,,,,}
         ii := 0;                                       //<,,UUSITTU 1.1.4
      if OKbtnChk                                       //<,,OKbtnCkick =Tarkistetaan VALITUN tyypin mm2:n mukaan
      then begin
         apus := a_getStrg(1231,rec.tyyppi);            //<Etsitään S_KaTyp:stä TYYPPIosoite =N:o =ii
         sa := EtsiOlet(0,S_KaTyp);                     //<,Etsit. APUS:sta oikea mm2 -lista(osoite)=ii
         while sa<>apus  do begin
               ii := ii+1;
               sa := EtsiOlet(ii,S_KaTyp);
         end;//ii=1   EtsioleKutsJälk=AMCMK;AXMK;AXCMK;AMMK*;SVjärjest.;APAKM*;AMKA;AVOJOHal;MCMK;MMJ/MMK*;PLKVJ*;AVOJOHcu;
         if sVeOKr(ComBx3.Text,mm2arr[ii],apus)  then SijStrAlkio( apus, rec.Amm2);  end      //< sVeOKr = +6.0.2
      else//,,Korjattu 5.0.0                               //<,,Tarkistetaan YLEISTEN mm2:n mukaan. Tyypikohtaisen
                               //,1.5\2.5 =+6.2.16         // mm2 :n tarkistus VASTA poistuttaessa OK :lla.,,,,,,,
      ch := SysUtils.FormatSettings.DecimalSeparator;      //<+12.0.0 .3b: http://www.nexusdb.com/forums/showthread.php?t=16311yt PRC CreateGlobals´ssa.
         sa := Trim(SyottoFrm.ComBx3.Text);                //+,,130.3b
         if (sa='2')  then sa := '1' +ch +'5'  else        //< 2 => 1,5
         if (sa='3')  then sa := '2' +ch +'5';             //< 3 => 2,5
         SyottoFrm.ComBx3.Text := sa;
         if sVeOKr (SyottoFrm.ComBx3.Text,'1.5\2.5\6\10\16\21\25\34\35\50\54\70\85\95\120\150\185\240\300\600\800\900\1200\1600\2400\3200', apus)
              then SijStrAlkio( apus, rec.Amm2);                                              //' sVeOKr = +6.0.2
      end;//with                                                                              //' 1600 Kisk+6.0.2
   4 :okx( ComBx4.Text, rec.Pituus);
   5 :begin
      okx( ComBx5.Text, rec.Lukumaara);
      if OKbtnChk                                               //<+1.1.4 = if OKbtnChk ..
      then begin                                   //<riv=25 kun OkBtnClickistä tarkistetaan #######
         //if (a_getStrg (251,tyyppi)='SVjärjest.') and (a_getIntg (252,lukumaara)>1)               //< -6.0.2
           if fOnSV (a_getStrg (251,rec.tyyppi)) and (a_getIntg (252,rec.lukumaara) >1)             //< +6.0.2
           then begin FNC := false;  mrkHerja_ ('  SVjärjest :lle ei sallita rinnakkaisjärjestelmiä '+
                                                '(toistaiseksi)');  end
           else if fOnKIS (a_getStrg (251,rec.tyyppi)) and (a_getIntg (252,rec.lukumaara) >1)       //< +6.0.2
           then begin FNC := false;  mrkHerja_ ('  KISKOjärjest :lle ei sallita rinnakkaisjärjestelmiä '+
                                                '(toistaiseksi)');  end
           else FNC := true;  end                                                                   //< +6.0.2
      else FNC := true;  end;                                   //<+1.1.4 = else ..
   6 :okx( ComBx6.Text, rec.Lampotila);
   7 :{if Pos ('VALINTATAULU',AnsiUpperCase (ComBx7.Text)) >0
         then begin KorjFrm.ShowModal;
                    fnc := true;  end                           //<'PITÄÄ TARKISTAA LOPULLISESSA VERSIOSSA!!!!!!!!
         else }okx( ComBx7.Text, rec.Korjaus);
{  7 :if Pos ('VALINTATAULU',AnsiUpperCase (ComBx7.Text)) >0
         then begin KorjFrm.ShowModal;
                    ComBx7.Text := KorjFrm.KediY.Text;
                    okx( ComBx7.Text, edv.edka[edi].Korjaus);  end
         else okx( ComBx7.Text, edv.edka[edi].Korjaus);}
   8 :begin if sVeOK (ComBx8.Text,S_POT,apus)                         //,,(0,S_POT)  0=1.VE ='PotTas' =Tiedetään
         then if apus=EtsiOlet(0,S_POT)  then a_putBool (281,TRUE, rec.PTlopussa)
                                         else a_putBool (282,FALSE,rec.PTlopussa);
         //if nnn>1  then                                                                         //<,+8.0.0
         if SrcEdka  then //rec.PTlopussa := edv.Sorc[1].Josa.PTlopussa; //<[1] määrää rinnakk.johtojen jälkeisen PT:n
         for ii := 1 to edv.YLE.SorceCount.ArvoInt  do            //<,+'-130.2e
            edv.Sorc[ii].Josa.PTlopussa.ArvoBoo := rec.PTlopussa.ArvoBoo;
      end;
   9 :okx( ComBx9.Text, rec.PEker);
  10 :begin fnc := true;
         SijStrAlkio( SyottoFrm.ComBx10.Text, rec.nimi);
         if nnn>1  then if SrcEdka  then                                                            //<,+8.0.0
            rec.nimi := edv.Sorc[1].Josa.Nimi; //<[1] määrää rinnakk.johtojen jälkeisen PK-NIMEn
      end;
  11 :if SokI (ComBx11.Text,ii)                                                                     //< +6.0.2
      then if (ii=0)  OR //(ii>=6) and (ii<=630) and
              (ii=630) or (ii=500) or (ii=400) or (ii=315) or
              (Pyor (ii) IN [250,200,160,125,100,80,63,50,40,32,25,20,16,10,6{,4,2}])
           then begin
                FNC := true;
              //edv.edka[edi].arvoU[2] := ar;  end                                                  //< -6.0.2
                a_putIntg (2111, Pyor (ii), rec.OfaVal);  end                                       //< +6.0.2
           else mrkHerja_ ('')
      else mrkHerja_ ('');
  12 :begin                                                                                         //< +6.0.0
      okx( SyottoFrm.ComBx12.Text, rec.Ph); //,,,Sittenkin jätetään oleva Cosp olemaan ja näkymään.!!!!!!!!!!!!!!!!!!!!!
    //NollaaMuutPht;                                 //<+120.5o:  EI SITTENKÄÄN NOLLATA.  Oli:  Nollaa muutPh´t myös RinnSorceissa.
     {if FNC  then begin                             //<,,Jos Ph=0, muutetaan Cosp myös, jotta mahd. mentäessä
         rr := a_getReaa (2111, edv.edka[edi].Ph);   //   muualle kuin CospBoxiin, arvo sijoittuisi vastaamaan
         if rr=0  then begin                         //   Ph:n arvoa.
           a_putReaa (2112, 0.0,edv.edka[edi].Cosp);
           ComBx13.Text := '0';  end; end;}
     if SrcEdka and (HerjOn=1) and (nnn>1) and (edv.Sorc[nnn-1].Josa.Ph.ArvoRea>0) //<,,130.0:  Ei voida laskea useamman rinnakkaisliittymän johtoja Uh´hon.
     and (Trim(SyottoFrm.ComBx12.Text)<>'0')   then begin
        rec.Ph.ArvoRea :=   0;
        rec.Cosp.ArvoRea := 1;
        rec.Uho.ArvoRea :=  0;
      //FNC := false;
        {if HerjOn=1  then }ShowMessage('Rinnakkaisliittymien johto-osuuksia voidaan laskea jännitealenemaan mukaan vain yhden osalta kerrallaan. '+
                                      'Arvot korjataan.');
     end;
      if FNC and (a_getReaa (2111, rec.Ph) =0)
         then a_putReaa (2112, 0,rec.Uho);           //<Nollataan mahd. aikaisempi alkuarvo.
      end;
  13 :begin                                          //<cosP                                        //< +6.0.0
      rr := a_getReaa (2121, rec.Cosp);              //,,Tutkittava tarkemmin, koska ar määrätty 0.05:ksi.
      if rr=0
      then begin                                     //,,Tutkittava tarkemmin, koska CosP määrätty 0.05:ksi.
//         if SokR (SyottoFrm.ComBx13.Text,ar) and (ar>=a_getReaa (2121, rec.alarRea)) and (ar<=1)
           if SokR (SyottoFrm.ComBx13.Text,ar) and (ar>=rec.cosP.alarRea) and (ar<=1)
              then begin
                   FNC := true;
                   a_putReaa (2122, ar,rec.Cosp);  end  //< +7.0.1
              else begin //mrkHerja;                 //<'Alkulatauksessa aina tähän:  arvoOK => arvoOKe
                   FNC := true;                      //<,TRUE koska VAIN TÄSSÄ HYVÄKSYTÄÄN COSP:ksi 0 (muuten >0.05)
                   a_putReaa (2122,  0,rec.Cosp);    //<,Ph=0 ja cosP on virheellinen =korjataan 0 :ksi.
                   SyottoFrm.ComBx13.Text := '0';  end; //<' +7.0.1
      end
      else okx( SyottoFrm.ComBx13.Text, rec.Cosp);   //< 0.05 ... 1 . Asetti jo FNC := ...
      end;
                                                     //,,,120.5o:  NÄMÄ TÄYSIN UUSIA 14,15 ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  14 :begin FNC := true;                             //<,,120.5o:  Nyt myös SorcenJosa´lla Ph..Tuh
            okx (SyottoFrm.ComBx14.Text, rec.Uho); end;
  15 :begin FNC := true;                             //<,,120.5o:  Nyt myös SorcenJosa´lla Ph..Tuh
            okx (SyottoFrm.ComBx14.Text, rec.Uho)  end;
  66 :begin end;                                 //<+120.5n/6:  UPS-lähdön reservilaskenta valittu.
//end;//if JkUpsChk_Dlg  else +141.1
  end;{case riv}
//################################################################################################################
  if SrcEdka  then edv.Sorc[nnn].Josa := rec                                                   //<,+6.2.2
              else edv.Edka[nnn]      := rec;
                 {EdvNewFrm.KuvausEdit.Text :=} if ''<>'JkUps[' +Ints(nnn) +']: Ik1v:' +SyottoFrm.ComBx1.Text +' rc:' +fRmrkt0(rec.JkUps_Ik1v.ArvoRea,1,2) +
                                                '  Cos:' +SyottoFrm.ComBx2.Text +' rc:' +fRmrkt0(rec.JkUps_Cos.ArvoRea,1,2) +
                                                ' Edka.Ik1v:' +fRmrkt0(edv.Edka[nnn].JkUps_Ik1v.ArvoRea,1,2)  then ;
                                              if edv.Sorc[nnn].Josa.Ph.ArvoRea>0  then ;
  end;
//,SyoOsa:  3=Uh% ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤<,,-4.0.0
(*3 :case riv of
   1 :okx( ComBx1.Text, edv.NjL.yhtUhraja);          //<,,Ei enää tarvetta +3.0.3
   2 :okx( ComBx2.Text, edv.NjL.EdUhOsa);
// 3 :okx( ComBx3.Text, edv.NjL.OnPTlop);   end;//case riv
   3 :if sVeOK( ComBx3.Text,S_POT,apus)
         then if apus=EtsiOlet(0,S_POT)  then a_putBool (331,TRUE, edv.NjL.OnPTlop)
                                         else a_putBool (332,FALSE,edv.NjL.OnPTlop);
   end;//case riv*)
//,SyoOsa:  4=Nj ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
4 :case riv of//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Näissä RIV=>SAR ja kesno=RIV;;;;;;;;;;;;;;;;;;
   1 :fnc := SijStrAlkio( NjFrm.BxG.Text, nj.jk[kesno].tunnus);
   2 :okx( NjFrm.BxG.Text, nj.jk[kesno].dL);
   3 :okx( NjFrm.BxG.Text, nj.jk[kesno].Ps);
   4 :okx( NjFrm.BxG.Text, nj.jk[kesno].Coss);
   5 :okx( NjFrm.BxG.Text, nj.jk[kesno].palV);
   6 :okx( NjFrm.BxG.Text, nj.jk[kesno].CosV);
   7 :okx( NjFrm.BxG.Text, nj.jk[kesno].Ala);
   8 :if sVeOK (NjFrm.BxG.Text,S_POT,apus)              //,,(0,S_POT)  0=1.VE ='PotTas' =Tiedetään
         then if apus=EtsiOlet(0,S_POT)  then a_putBool (481,TRUE, nj.jk[kesno].PTlop)
                                         else a_putBool (482,FALSE,nj.jk[kesno].PTlop);
   9 :okx( NjFrm.BxG.Text, nj.jk[kesno].Huom);  //<Vaikka ei ole tarkistettavaa
  //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Riv = ohjausnumero ao. Boxiin,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  11 :if NOT SokI (NjFrm.Bx1.Text, ii)                                                    //< +3.0.3  4.0.0
      then mrkHerja
      else begin
           j := a_getIntg (10,edv.YLE.JohtoOsia);
           if ii IN [1.. j+1]
           then begin
              edNo := ii;                            //<edNo = Ed.vrkn johto-osa, jolle seur. laskentaparametrit.!
              if edNo=j+1  then NjFrm.Bx1.Text := fImrkt0 (edNo,1) +' =Loppuun';
              fnc := true;  end
           else begin                                         //<,,+6.2.2
              j := a_getIntg (11,edv.YLE.SorceCount);
              if (ii<0) and (Abs(ii) IN [1..j])  then begin
                 edNo := ii;
                 NjFrm.Bx1.Text := fImrkt0 (edNo,1);
                 fnc := true;  end
              else mrkHerja;
           end;
      end;
  12 :if sVeOK (NjFrm.Bx2.Text,S_KulSal,apus)        //,,(0,S_KulSal)  0=1.VE ='KULUTT.' Tiedetään
         then if apus=EtsiOlet(0,S_KulSal)  then a_putBool (4111,TRUE, nj.jy.NjKulSal)
                                            else a_putBool (4112,FALSE,nj.jy.NjKulSal);
  13 :okx( NjFrm.Bx3.Text, nj.jy.Tk1v);
  14 :okx( NjFrm.Bx4.Text, nj.jy.UhRaja);                                                 //< +3.0.3
  15 :okx( NjFrm.Bx5.Text, nj.jy.Tasaus);
  16 :if cVeOK (NjFrm.Bx6.Text,S_AsTap, ch)  then a_putStrg (4141,ch, nj.jy.AsTapa);
  17 :okx( NjFrm.Bx7.Text, nj.jy.Korjaus);
  18 :okx( NjFrm.Bx8.Text, nj.jy.Kasvuv);
  19 :begin FNC := SokI (NjFrm.Bx9.Text,ii) and (ii IN [1..99]);                          //<,+6.1.1
            if FNC  then VExKrt := ii;  end;
   end;//case riv
//,SyoOsa:  5=Häviöiden kapitalisointi ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
5 :case riv of
   1 :okx( SyottoFrm.ComBx1.Text,  nj.Hav.Tpit   );
   2 :okx( SyottoFrm.ComBx2.Text,  nj.Hav.Korko  );
   3 :okx( SyottoFrm.ComBx3.Text,  nj.Hav.Hprs   );
   4 :okx( SyottoFrm.ComBx4.Text,  nj.Hav.Tph    );
   5 :okx( SyottoFrm.ComBx5.Text,  nj.Hav.YOprs  );
   6 :okx( SyottoFrm.ComBx6.Text,  nj.Hav.Ktyh   );
   7 :okx( SyottoFrm.ComBx7.Text,  nj.Hav.dPprs  );
   8 :okx( SyottoFrm.ComBx8.Text,  nj.Hav.dWmkprs);
   9 :okx( SyottoFrm.ComBx9.Text,  nj.Hav.PVpen  );
  10 :okx( SyottoFrm.ComBx10.Text, nj.Hav.YOpen  );
  11 :okx( SyottoFrm.ComBx11.Text, nj.Hav.Pmk    );
   end;//case riv
//,SyoOsa:  8=Moottorilähdöt ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
8 :case riv of{;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Näissä RIV=>SAR ja kesno=RIV;;;;;;;;;;;;;;;;;;}
   1 :if sVeOKr (MoFrm.BxG.Text,'2\4\6\8\10\12',apus)        then begin {Val (apus, ii,j);} ii  := StrToInt (apus);
         if j=0  then a_putIntg (6001, ii, mo.motr[eMrv].nap);  end;                                //' sVeOKr = +6.0.2
   2 :okx( MoFrm.BxG.Text, mo.motr[eMrv].kw);
   3 :okx( MoFrm.BxG.Text, mo.motr[eMrv].cos);
   4 :okx( MoFrm.BxG.Text, mo.motr[eMrv].tim);
   5 :if sVeOKr (MoFrm.BxG.Text,'1\2\3\4\5\6\7\8\9\0',apus)  then begin {Val (apus, ii,j);} ii := StrToInt (apus);
         if j=0  then a_putIntg (6001, ii, mo.motr[eMrv].rno);  end;                                //' sVeOKr = +6.0.2
   6 :okx( MoFrm.BxG.Text, mo.motr[eMrv].kpl);
   7 :if cVeOK (MoFrm.BxG.Text,S_AsTap, ch)        then
      a_putStrg (6701, ch, mo.motr[eMrv].asT);
   8 :okx( MoFrm.BxG.Text, mo.motr[eMrv].korj);
   9 :if cVeOK (MoFrm.BxG.Text, 'F\M\A\I\Z',  ch)  then begin st := fSu_Str (ch);
                                                        if CharInSet(ch, ['a','A'])  then ch := 'M';
                                                        if CharInSet(ch, ['i','I'])  then st := su_IECg  else
                                                        if CharInSet(ch, ['z','Z'])  then st := su_IECd  else
                                                        if CharInSet(ch, ['m','M'])  then st := su_OFAm  else
                                                                                 st := su_OFAg;
                                                        a_putStrg (6901,st, mo.motr[eMrv].suT); //,Oltava OK,
                                                        mo.motr[eMrv].OnArvot := TRUE;  end;    //<josTähänPäästy
  10 :okx( MoFrm.BxG.Text, mo.motr[eMrv].Lmo);
  11 :okx( MoFrm.Bx1.Text, mo.moty.sulSft);
  12 :if sVeOKr (MoFrm.UmCmBx.Text,S_Usrj,apus)  then begin {Val (apus, ii,j);} ii := StrToInt (apus);
         if j=0  then a_putIntg (6001, ii, mo.moty.Umo);  end;                                  //< sVeOKr = +6.0.2
//13 :if SokI (MoFrm.VrkCmBx.Text, j) and (j IN [0..a_getIntg (6013, edv.YLE.JohtoOsia)])       //<, +6.0.3
  13 :if SokI (MoFrm.VrkCmBx.Text, j) AND                                                       //,1 => 0 =11.0.1
      (*((j >={1} 0) and  (j <= a_getIntg (6013, edv.YLE.JohtoOsia))  {OR                       //< 0->1 +7.0.5
         (j <=  -1)  and  (j >= -1*a_getIntg (6013, edv.YLE.SorceCount)))              //< +7.0.5 -11.0.1*)
         (j >= 0) and  (j <= a_getIntg (6013, edv.YLE.JohtoOsia))                      //< 0->1 +7.0.5  1=>0 11.0.1
         then begin
              a_putIntg (6013, j,mo.moty.Vrk);
              FNC := true;  end
         else if HerjOn>0  then
                 EiOkInfo ('Verkkopiste virheellinen.');
   end;//case riv
end;{case SyoOsa}    {Y_piipit(10); Y_Koe (2,'FNCarvoOK  ULOS  Riv='+fImrkt0(riv,1)+'>>>>>'+ );}
// if NOT FNC  then erPiip;                 //<1.0.8 10.10.98  -4.0.0  ks. FNC arvoOK_/HerjaON/MrkHerja/erPiip
   arvoOK_ := FNC;   //Y_Koe(2, 'FNC arvoOK');
                 //¿DefsFileenZ('SyoArvOK.INC/arvoOK_:9  Riv:' +Ints(riv) +'  SyoOsa:' +Ints(SyoOsa));
                 //JFileen('SyoArvOK ulos.');
end;//FNC arvoOK_


function arvoOK (riv,SyoOsa :integer) :boolean;     begin result := arvoOK_ (1, riv,SyoOsa);  end; //<HerjaJosEiOK
function arvoOKe(riv,SyoOsa :integer) :boolean;     begin result := arvoOK_ (0, riv,SyoOsa);  end; //<EiHerjaa

