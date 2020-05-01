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

{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NjLas38.INC }
{Häviökustannuslaskentaan liittyvät asiat kommentoitu vex:  H@ ...
NjTul30.INC, 31.INC, 31.INC, 37.INC, 38.INC INCLUUDATTU NjTul3.PAS :ssa
===================================================================================================}
//EtsiKaap, EtsiSulTapa, Tulosta, Ketjuteho
        {##### Nyt: IkSul    #####
         #####      KuorSul  ##### =Tulostuu:  MinSUL(=KuorSul)/MinKatk(=KuorKat).  (Sis. fKsul)
         #####      YVsul    ##### =AsTavan, kuormitettavuuden yms. määräämä sulake.
         #####      ZSsul    ##### =Zs-ehdon mukainen max.sulake.
         #####               #####
         #####      NJsul    ##### =Tämä TULOSTUU ve:na.!!!!!!!!!!!!
         #####      ImgKat   ##### =0.8*Ik1v
         #####      KuorKat  ##### =LASKETAAN ALUKSI: (Tästä lasket. sulakkeet) Kuorman edellyttämä katkaisijan terminen asetus.
         #####      YVkat    ##### =AsTavan, kuormitettavuuden yms. määräämä katkaijan terminen asetus.
         #####      ZSkat    ##### =Kuten sul.
         #####      NJkat    ##### =Kuten sul.}

PROCEDURE etsiKaap (uhkin :Boolean;   VAR pal :ohjaava);      VAR e :integer{+6.2.2};
                                       //uhkin=F kun etsit MINsulak
//CONST  AMCMK_='AMCMK';   MCMK_='MCMK'; //<Ohautuu RES,ResP,Xv_..:ssa 3½ -tyyppeihin -6.0.2  +6.0.2 ks.NolaTyp.INC
VAR   ar,apuker      :real;            //<Apumuuttuja alker/cuker:lle
      er,Vlkm,jx     :Integer;         //<Vlkm=vaihelkm. ER pitää olla KOKO PRClle, ettei välillä epäm.
      njn            :integer;         //<BreakPoint tms:ssa kertoo iterN:on
      N1ehto         :Boolean;         //<IksOK :n apumuuttuja <<<<
      uhehto,ulos    :Boolean;         //PARAM uhkin:nin -"-   <<<<
      uhx            :Real;            //'uhx=u%sis kasvuvar
      sri            :string;          //<ApuStringi IkKasvattiStr :lle (lyhyempi)

   PROCEDURE WrKaapLasF (os :integer);   begin
                (*VAR F :text;  Dir,LasFileN,s,sa :string;  i :integer;
                  {########## PYYHI SISÄLTÖ AINA AJON JÄLKEEN:  Täyttyy KUMULATIIVISESTI. ##########
                   ##########      Tekee E:\Projektit\NolaKehi\BIN\Koe\NJ-las.TXT         ##########}
      function fBoo2 (boo :boolean) :string;      begin
         if boo  then result := '++'
                 else result := '--';  end;
   BEGIN//WrKaapLasF,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   if IsDebuggerPresent  then begin
      Dir := gAjoPath; //+-12.0.05 oli: ExtractFilePath (Application.ExeName); //<Pelkkä polku ilman filenimeä
      if NOT DirectoryExists(Dir) then
         ForceDirectories(Dir);
      LasFileN := Dir +'Koe\NJ-las.TXT';            //<Extract.. teki jo 1x '\'. Ei tartte ForceDirectories ()
                 //'#############################################################################################
                 //'=E:\Projektit\NolaKehi\BIN\Koe\NJ-las.TXT  Sisältö pyyhkiytyy 6 mm2:lla
                 //'#############################################################################################
      if (NJmm2=6) and FileExists(LasFileN)     //<Ekalla mm2:lla delataan vanha
         then DeleteFile(LasFileN);
      AssignFile(F, LasFileN);
      if NOT FileExists(LasFileN)  then begin   //<Tiedosto oltava ennen Append´ia.
         Rewrite (F);
         CloseFile (F);  end;
      Append(F);

      if NJmm2=6  then                          //Ekaksi riviksi yleistietoa.
         Writeln(F,'IterNo    ... NJkat=YvSuoj  ImgKat=Ikm*0.8  ImgKat*KeroMg >= KuorKat else KatMgAli  KuorKat > jx* NJsul');

      s := fImrkt0(os,3)  +' ';
      sa := NJtyp;
      for i := Length (sa)+1 to 10  do          //< SVsystAL5S= 10 mrkiä
         s := s +' ';
      s := s +sa;
        if NJlaji  then sa := ' al'  else sa := ' CU';
      s := s +fImrkt0(NJkaapx,2) +'x'+fRmrkt0(NJmm2,4,0) +sa +'=' +fRmrkt0(NJkaapx*NJmm2,4,0);
      s := s +'  NJsul='+fImrkt0(NJsul,4) +' NJkat='+fRmrkt0 (NJkat,6,1) +' YVkat=' +fRmrkt0 (YVkat, 6,1) +
        ' KuorKat='+fRmrkt0 (KuorKat,6,1) +' ZSkat='+fRmrkt0 (ZSkat,6,1) +' ImgKat='+fRmrkt0 (ImgKat,6,1) +
        ' KatMgAli='+fBoo2 (KatMgAli)     +' N1ehto='+fBoo2 (N1ehto);

      Writeln(F,s);
      Flush(F);     //<insert code here that would require a Flush before closing
      CloseFile(F); //'the fileensures that the text was actually written to file
   end;//if IsDebuggerPresent*)
   end;//WrKaapLasF
//==================================================================================================
                                          //,PRC etsii ekan tulostamattoman mm2. Jos ei löydy, etsii
PROCEDURE kasva_NJmm2;                    //seuraavan MÄÄRÄTYSSÄ järjestyksessä = 212 ve :a <<<<<<<<
   VAR ao :integer;   //<Näyttää Watch listassa UNTIL :n kohdalla, mikä rivi lähettänyt EDN..testiin.
       //uNJkaapx :integer;  uNJtyp :string;  uNJmm2 :real;
   PROCEDURE koe;      {§VAR s :string;  {i,j,k,o,t :integer; {s...t =Kokeilua varten}BEGIN
   (*,,,§§§§§§§§§§§§§§§§§§§§§§§§§ TOSI HYVÄ LISTAUS LÄPIKÄYTYJEN mm2 :n TARKISTUKSEEN §§§§§§§§§§§§§§§§§§§§§§,,,
      //,,,
      if DetEvFrm.aRich.Lines[0]='aRich'
         then DetEvFrm.aRich.Clear;
      s := IntToStr (DetEvFrm.aRich.Lines.Count +1) +' ';
      s := s +fImrkt0 (ao,3) +'  ';                            //<Kertoo, mikä silmukkakohta (vikana) määrännyt.
      if NJlaji  then s := s +'al  '  else s := s +'cu      ';
      s := s +fRmrkt0 (NJmm2,1,0)+'  ';
      if NJkaapx>1  then s := s +fImrkt0 (NJkaapx,1);
      s := s +'<br>';

     {NjFrm.DetRad3.Checked := false;            //<NJ-tulostuslaajuus MAX vex.   =Ei onaa.
      NjFrm.DetRad1.Checked := true;             //<NJ-tulostuslaajuus minimiksi. =Ei onaa.}
      DetEvFrm.aRich.Font.Name := 'Courier New'; //<Ei vaikuta, OnShow´ssa ehkä fonttiasetus tms. (eioo, tarkisttu).
      DetEvFrm.aRich.AddText (s);
      DetEvFrm.Visible := true;
    //DetEvFrm.FormStyle := fsStayOnTop;         //<,Saman arvoisia: NjTulFrm kuitenkin pukkaa päälle.
      DetEvFrm.BringToFront;
      DetEvFrm.Top := 0;  DetEvFrm.Width := 200;  DetEvFrm.Left := Screen.Width-DetEvFrm.Width;
      DetEvFrm.Height := Screen.Height;
      DetEvFrm.Update; //''''''''''''''''''''''''§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§'''*)
   END;//koe
   PROCEDURE KaapIterF (os,haara :integer);      begin
                (*VAR F :text;  Dir,IterFileN,s,sa :string;  i :integer;
                  {########## PYYHI SISÄLTÖ AINA AJON JÄLKEEN:  Täyttyy KUMULATIIVISESTI. ##########
                   ##########      Tekee E:\Projektit\NolaKehi\BIN\Koe\NJ-iter.TXT        ##########}
      PROCEDURE ListaaTulostetut;      VAR si,sj,so :string;  i,j,o,t :integer;      BEGIN
      //,,,§§§§§§§§§§§§§§§§§§§§§§§§§ TOSI HYVÄ LISTAUS LÄPIKÄYTYJEN mm2 :n TARKISTUKSEEN §§§§§§§§§§§§§§§§§§§§§§,,
           {tultau      :ARRAY [1..3, 0..mm2NoMax, 0..rinmax]  OF Integer;
                                // Tulostetut mm2 muistiin NJLAJI'ttain(1=AL  2=CU  3=SVj), lkmäärittäin
                                // 1..3,0,1..rinmax  on varattu minimipoikkipinnalle<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                                // 1..3,0,0          on varattu etsitynJärjNo:lle, Ei käytössä.<<<<<<<<<<<<<<<<<<
            tultau [tultauTos(NJtyp), tultauAos (trunc(NJmm2)), NJkaapx] := trunc (NJmm2);
            tultauTos (NJtyp): SVj=3  Al=1  Cu=2    tultauAos (trunc(NJmm2)), NJkaapx]: 6=1  10=2 ... 3200=18}
         s := '          1x   2x   3x   4x   5x   6x   7x   8x   9x   10   11   12   13   14   15   16   '+
                        '17   18   19   20';
         Writeln(F,s);   t := 0;
         FOR i := 1 TO 3         DO BEGIN
            if i=1  then si := 'AMCMK'  else
            if i=2  then si := 'MCMK '  else
                         si := 'SVj  ';
            FOR j := 0 TO mm2NoMax  DO begin            //< 0 varattiin min.ve:lle
               sj := fImrkt0 (j,2) +' ';
               so := '';
               FOR o := 1 TO rinmax    DO begin            //< 6.1.1:  1 to => 0 to
                  if tultau[i,j,o]=0
                  then so := so +' ----'
                  else begin
                       so := so +fImrkt0 (tultau[i,j,o] *o, 5);
                       t := t+1;  end;
               end;
               Writeln(F,sj +si +so);
            end;
         END;
         s := 'TOT vaihtoehtoja yht = ' +fImrkt0 (t,1) +' ';
         if NJveAC=veCU  then s := s +'Cu'  else //< 2 = Cu
         if NJveAC=veAL  then s := s +'Al'  else //< 1 = Al
                              s := s +'Al+Cu';   //< 0 = Al+Cu
         Writeln(F, s +'.');
      END;//ListaaTulostetut

   BEGIN//KaapIterF,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   if IsDebuggerPresent  then begin
      Dir := gAjoPath; //+-12.0.05 oli: ExtractFilePath (Application.ExeName); //<Pelkkä polku ilman filenimeä
      if NOT DirectoryExists(Dir) then
         ForceDirectories(Dir);
      IterFileN := Dir +'Koe\NJ-iter.TXT';          //<Extract.. teki jo 1x '\'. Ei tartte ForceDirectories ()
                 //'#############################################################################################
                 //'=E:\Projektit\NolaKehi\BIN\Koe\NJ-iter.TXT ##################################################
                 //'#############################################################################################
      if (os=1) and FileExists(IterFileN)      //<Ekalla krlla delataan vanha
         then DeleteFile(IterFileN);
      AssignFile(F, IterFileN);
      if NOT FileExists(IterFileN)  then begin //<Tiedosto oltava ennen Append´ia.
         Dir := ExtractFilePath (IterFileN);   //<+8.0.14
         if NOT DirectoryExists(Dir) then      //<+8.0.14
            ForceDirectories(Dir);             //<+8.0.14, koska tuli Error Rewrite (F):sta.
         Rewrite (F);
         CloseFile (F);  end;
      Append(F);
      if os=0
      then  s := '---------------------------------------------'
      else begin
        {Writeln(F, fImrkt0(os,3)  +'  NJtyp= ' +NJtyp             +'  NJkaapx= '+fImrkt0(NJkaapx,1) +
                 '  NJmm2= '+fRmrkt0(NJmm2,1,0) +' ='+fRmrkt0(NJkaapx*NJmm2,1,0) +'  NJlaji= ' +fBmrkt0(NJlaji,2));}
         s := fImrkt0(os,3)  +' ';
        {if haara=0  then s := s +' --'
                     else s := s +fImrkt0(haara,3);
         s := s +'  ';}
         sa := NJtyp;
         for i := Length (sa)+1 to 10  do        //< SVsystAL5S= 10 mrkiä
            s := s +' ';
         s := s +sa;
         if NJtyp=njMCMK  then sa := ' c'  else sa := ' A';
         s := s +'  '+fImrkt0(NJkaapx,2) +' x '+fRmrkt0(NJmm2,4,0) +sa +
              ' ='+fRmrkt0(NJkaapx*NJmm2,5,0) +' ';
         if NJlaji  then sa := 'al'  else sa := 'CU';
         s := s +sa +'  NJsul='+fImrkt0(NJsul,1);  end;
      Writeln(F,s);
      if os=-1  then
         ListaaTulostetut;
      Flush(F);     //<insert code here that would require a Flush before closing
      CloseFile(F); //'the fileensures that the text was actually written to file
   end;//if IsDebuggerPresent'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''*)
   end;//KaapIterF
//==================================================================================================

   PROCEDURE unjKasv (uusTyp :string;  os :integer); //Vain AlCu :sta kutsuja
                                                     //,,Saa kutsua vain, KUN NJkaapx >=3 JA 120/150mm2,,,,,,,,,,
      procedure kasva_Ao;     VAR ala :real;     begin
         ala := NJmm2;
         CASE trunc (ala) OF
          1: IF NJlaji  THEN ala := 16  ELSE ala := 6;
          6: ala :=  10;     10: ala :=  16;    16: ala :=  25;    25: ala := 35;     35: ala :=   50;
         50: ala :=  70;     70: ala :=  95;    95: ala := 120;   120: ala := 150;   150: ala :=  185;
        185: ala := 240;    240: ala := 300;   300: ala := 600;   600: ala := 900;   900: ala := 1200;
       1200: ala := 2400;  2400: ala := 3200;  ELSE ala := 150;   END; //<150: Kunhan ei ole 0 #####
       NJmm2 := ala;   END; //HUOM! HUOM! HUOM! HUOM!''''''''''HUOM! HUOM! HUOM! HUOM! HUOM! HUOM!
       //HAVAINTO:  Tätä kutsuu vain UNJKASV, joka ESTÄÄ >300 arvot, joten em. 0 :n kieltokin TURHA !!!!!!!!
   BEGIN//unjKasv................................
      NJtyp := uusTyp;   NJlaji := fAlCu (NJtyp);
      NJkaapx := 2;
      REPEAT  NJkaapx := NJkaapx+1;
              IF SamIso (NJtyp,njMCMK)
                 then NJmm2 := 120
                 else NJmm2 := 150;
              while kaapontul  and (NJmm2>0.1)  and (NJmm2<300)   do kasva_Ao;
      UNTIL  NOT kaapontul  or  (NJkaapx=rinmax);
      KaapIterF (os,0);
      if kaapontul  and  (NJkaapx=rinmax)  and SamIso (NJtyp,njMCMK)                   //,##################
         then NJmm2 := 0;                                                              //<TÄMÄ LOPETTAA KOKO
   END;//unjKasv                                                                       //'EtsiKaap HOMMAN ##
   //..........................................                                        //'##################
   FUNCTION edn_p (vrtx :Integer;  vrtTyp :string;  vrtA :real;  o :integer) :Boolean;      BEGIN//Vain CuAl
    //KaapIterF (o,0);
      ao := o;
      IF ( (vrtx=1)  AND  (NJkaapx=1)   OR
           (vrtx=2)  AND  (NJkaapx=2)   OR
           (vrtx>2)  AND  (NJkaapx>2) )   AND
         SamIso (vrtTyp,NJtyp)  AND  (NJmm2<=vrtA)
         THEN Result := TRUE
         ELSE Result := FALSE;
   END;//ednp
   //...............................................................................................
   FUNCTION edn_ (vrtx :Integer;  vrtTyp :string;  vrtA :real;  o :integer) :Boolean;      BEGIN//Kaikki käyttää
    //KaapIterF (o,0);
      ao := o;
      IF (vrtx=NJkaapx)         AND
         SamIso (vrtTyp,NJtyp)  AND  (NJmm2=vrtA)
         THEN Result := TRUE
         ELSE Result := FALSE;
   END;//edn_
   //-----------------------------------------------------------------------------------------------
   PROCEDURE unj (uusx :Integer;  uusTyp :string;  uusA :real;  os :integer);      BEGIN
      NJkaapx := uusx;    NJtyp := uusTyp;    NJmm2 := uusA;    NJlaji := fAlCu (NJtyp);
      KaapIterF (os,0);
   END;
   //...............................................................................................
   FUNCTION ednj (vrtx :Integer;  vrtTyp :string;  vrtA :real;  os :integer) :Boolean;      BEGIN//Vain AlCu
    //KaapIterF (o,0);
    //ao := o;
      IF (vrtx=NJkaapx)         AND  (vrtA=NJmm2) AND
         SamIso (vrtTyp,NJtyp)
      THEN Result := TRUE
      ELSE Result := FALSE;
   END;//ednj
   //-----------------------------------------------------------------------------------------------

BEGIN{kasva_NJmm2}    {s := '';   o := 0;   REPEAT                    //<KoeLISTAUSkäyttöön <<<<<<<<}
                 {+6.1.1:  veAL ja veCU -tapaukset voitaisiin molemmat korvata veAlCu :lla, kun lopun
                           UNTIL -ehtoon lisättäisiin ao. testi. Tämä idea on testaamatta mutta tod.
                           näköisesti toimisi OK.###################################################}
njn := njn+1;
if NJveAC=veAlCu              //<JohdinmaterBtn =Al+Cu
then //etsiNj
REPEAT//TOT vaihtoehtoja yht = 212 Al+Cu.
      IF ednj (1   ,njMCMK  ,      1,   0)  THEN unj (1   ,njMCMK  ,      6,   1)   ELSE
      IF ednj (1   ,njMCMK  ,      6,   1)  THEN unj (1   ,njMCMK  ,     10,   2)   ELSE
      IF ednj (1   ,njMCMK  ,     10,   2)  THEN unj (1   ,njAMCMK , 16    ,   3)   ELSE
      IF ednj (1   ,njAMCMK , 16    ,   3)  THEN unj (1   ,njAMCMK , 25    ,   4)   ELSE
      IF ednj (1   ,njAMCMK , 25    ,   4)  THEN unj (1   ,njMCMK  ,     16,   5)   ELSE
      IF ednj (1   ,njMCMK  ,     16,   5)  THEN unj (1   ,njAMCMK , 35    ,   6)   ELSE
      IF ednj (1   ,njAMCMK , 35    ,   6)  THEN unj (1   ,njMCMK  ,     25,   7)   ELSE
      IF ednj (1   ,njMCMK  ,     25,   7)  THEN unj (1   ,njAMCMK , 50    ,   8)   ELSE //= 50          rv
      IF ednj (1   ,njAMCMK , 50    ,   8)  THEN unj (   2,njAMCMK , 25    ,   9)   ELSE //= 50
      IF ednj (   2,njAMCMK , 25    ,   9)  THEN unj (1   ,njMCMK  ,     35,  10)   ELSE //=      35
      IF ednj (1   ,njMCMK  ,     35,  10)  THEN unj (1   ,njAMCMK , 70    ,  11)   ELSE //= 70          rv
      IF ednj (1   ,njAMCMK , 70    ,  11)  THEN unj (   2,njAMCMK , 35    ,  12)   ELSE //= 70
      IF ednj (   2,njAMCMK , 35    ,  12)  THEN unj (1   ,njMCMK  ,     50,  13)   ELSE //=      50
      IF ednj (1   ,njMCMK  ,     50,  13)  THEN unj (   2,njMCMK  ,     25,  14)   ELSE //=      50
      IF ednj (   2,njMCMK  ,     25,  14)  THEN unj (1   ,njAMCMK , 95    ,  15)   ELSE //= 95          rv
      IF ednj (1   ,njAMCMK , 95    ,  15)  THEN unj (   2,njAMCMK , 50    ,  16)   ELSE //=100
      IF ednj (   2,njAMCMK , 50    ,  16)  THEN unj (1   ,njMCMK  ,     70,  17)   ELSE //=      70
      IF ednj (1   ,njMCMK  ,     70,  17)  THEN unj (   2,njMCMK  ,     35,  18)   ELSE //=      70
      IF ednj (   2,njMCMK  ,     35,  18)  THEN unj (1   ,njAMCMK ,120    ,  19)   ELSE //=120          rv
      IF ednj (1   ,njAMCMK ,120    ,  19)  THEN unj (   2,njAMCMK , 70    ,  20)   ELSE //=140
      IF ednj (   2,njAMCMK , 70    ,  20)  THEN unj (1   ,njMCMK  ,     95,  21)   ELSE //=      95
      IF ednj (1   ,njMCMK  ,     95,  21)  THEN unj (   2,njMCMK  ,     50,  22)   ELSE //=     100
      IF ednj (   2,njMCMK  ,     50,  22)  THEN unj (1   ,njAMCMK ,150    ,  23)   ELSE //=150          rv
      IF ednj (1   ,njAMCMK ,150    ,  23)  THEN unj (   2,njAMCMK , 95    ,  24)   ELSE //=190
      IF ednj (   2,njAMCMK , 95    ,  24)  THEN unj (1   ,njMCMK  ,    120,  25)   ELSE //=     120
      IF ednj (1   ,njMCMK  ,    120,  25)  THEN unj (   2,njMCMK  ,     70,  26)   ELSE //=     140
      IF ednj (   2,njMCMK  ,     70,  26)  THEN unj (1   ,njAMCMK ,185    ,  27)   ELSE //=185          rv
      IF ednj (1   ,njAMCMK ,185    ,  27)  THEN unj (   2,njAMCMK ,120    ,  28)   ELSE //=240
      IF ednj (   2,njAMCMK ,120    ,  28)  THEN unj (1   ,njMCMK  ,    150,  29)   ELSE //=     150
      IF ednj (1   ,njMCMK  ,    150,  29)  THEN unj (   2,njMCMK  ,     95,  30)   ELSE //=     190
      IF ednj (   2,njMCMK  ,     95,  30)  THEN unj (1   ,njAMCMK ,240    ,  31)   ELSE //=240          rv
      IF ednj (1   ,njAMCMK ,240    ,  31)  THEN unj (   2,njAMCMK ,150    ,  32)   ELSE //=300
      IF ednj (   2,njAMCMK ,150    ,  32)  THEN unj (1   ,njMCMK  ,    185,  33)   ELSE //=     185
      IF ednj (1   ,njMCMK  ,    185,  33)  THEN unj (   2,njMCMK  ,    120,  34)   ELSE //=     240
      IF ednj (   2,njMCMK  ,    120,  34)  THEN unj (1   ,njAMCMK ,300    ,  35)   ELSE //=300          rv
      IF ednj (1   ,njAMCMK ,300    ,  35)  THEN unj (1,njSVj      ,300    ,  36 )   ELSE//=300
      IF ednj (1,njSVj      ,300    ,  36 ) THEN unj (   2,njAMCMK ,185    ,  37)   ELSE //=370
      IF ednj (   2,njAMCMK ,185    ,  37)  THEN unj (1   ,njMCMK  ,    240,  38)   ELSE //=     240
      IF ednj (1   ,njMCMK  ,    240,  38)  THEN unj (1   ,njMCMK  ,    300,  39)   ELSE //=     300
      IF ednj (1   ,njMCMK  ,    300,  39)  THEN unj (   2,njMCMK  ,    150,  40)   ELSE //=     300     rv
      IF ednj (   2,njMCMK  ,    150,  40)  THEN unj (   2,njAMCMK ,240    ,  41)   ELSE //=480
      IF ednj (   2,njAMCMK ,240    ,  41)  THEN unj (   3,njMCMK  ,    120,  42)   ELSE //=     360
      IF ednj (   3,njMCMK  ,    120,  42)  THEN unj (   2,njMCMK  ,    185,  43)   ELSE //=     370
      IF ednj (   2,njMCMK  ,    185,  43)  THEN unj (   2,njAMCMK ,300    ,  44)   ELSE //=600
      IF ednj (   2,njAMCMK ,300    ,  44)  THEN unj (1,njSVj      ,600    ,  45 )   ELSE//=600
      IF ednj (1,njSVj      ,600    ,  45 ) THEN unj (   2,njMCMK  ,    240,  46)   ELSE //=     480     rv
      IF ednj (   2,njMCMK  ,    240,  46)  THEN unj (   3,njAMCMK ,150    ,  47)   ELSE //=450
      IF ednj (   3,njAMCMK ,150    ,  47)  THEN unj (   3,njAMCMK ,185    ,  48)   ELSE //=555
      IF ednj (   3,njAMCMK ,185    ,  48)  THEN unj (   2,njMCMK  ,    300,  49)   ELSE //=     600
      IF ednj (   2,njMCMK  ,    300,  49)  THEN unj (   3,njAMCMK ,240    ,  50)   ELSE //=720
      IF ednj (   3,njAMCMK ,240    ,  50)  THEN unj (   3,njMCMK  ,    150,  51)   ELSE //=     450     rv
      IF ednj (   3,njMCMK  ,    150,  51)  THEN unj (3   ,njAMCMK ,300    ,  52)   ELSE //=900
      IF ednj (3   ,njAMCMK ,300    ,  52)  THEN unj (1,njSVj      ,900    ,  53 )   ELSE//=900
      IF ednj (1,njSVj      ,900    ,  53 ) THEN unj (   3,njMCMK  ,    185,  54)   ELSE //=     555
      IF ednj (   3,njMCMK  ,    185,  54)  THEN unj (4   ,njAMCMK ,150    ,  55)   ELSE //=600
      IF ednj (4   ,njAMCMK ,150    ,  55)  THEN unj (   3,njMCMK  ,    240,  56)   ELSE //=     720
      IF ednj (   3,njMCMK  ,    240,  56)  THEN unj (4   ,njAMCMK ,185    ,  57)   ELSE //=740          rv
      IF ednj (4   ,njAMCMK ,185    ,  57)  THEN unj (   3,njMCMK  ,    300,  58)   ELSE //=     900
      IF ednj (   3,njMCMK  ,    300,  58)  THEN unj (4   ,njAMCMK ,240    ,  59)   ELSE //=960
      IF ednj (4   ,njAMCMK ,240    ,  59)  THEN unj (   4,njMCMK  ,    120,  60)   ELSE //=     480
      IF ednj (   4,njMCMK  ,    120,  60)  THEN unj (4   ,njAMCMK ,300    ,  61)   ELSE //=1200
      //-------Tähän mennessä Cu: 1..3x120..300 4x120   Al: 1..4x150..300   SV: 300  600  900  1200

      //,,SVjärjestelmien ohjaus,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
//            (1,njSVj      ,1200   ,  62 )
      IF ednj (4   ,njAMCMK ,300    ,  61)  THEN unj (1,njSVj      ,1200   , 101 )   ELSE //=1200
      IF edn_ (8   ,njAMCMK ,300    , 102)  THEN unj (1,njSVj      ,2400   , 102 )   ELSE //=2400
      IF edn_ (11  ,njAMCMK ,300    , 103)  THEN unj (1,njSVj      ,3200   , 103 )   ELSE //=3200

      IF edn_ (1,njSVj      ,1200   , 101 )  THEN unjKasv (njMCMK, 104)          ELSE //= N x Cu 300
      IF edn_ (1,njSVj      ,2400   , 102 )  THEN unjKasv (njMCMK, 105)          ELSE //= N x Cu 300
      IF edn_ (1,njSVj      ,3200   , 103 )  THEN unjKasv (njMCMK, 106)          ELSE //= N x Cu 300
      //''SVjärjestelmien ohjaus''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

      IF edn_p(   3,njMCMK  ,    300, 107)  THEN unjKasv (njAMCMK, 107)               ELSE //=
                                                 unjKasv (njMCMK , 108);
(*--------------------------------------------------------------------------------------------------
      IF edn_p(   x,njMCMK  ,    300,  x )  THEN unjKasv (njAMCMK, x  )               ELSE //=
      IF edn_p(x   ,njAMCMK ,300    ,  x )  THEN unjKasv (njMCMK , x  );

      IF ednj  THEN unj (   x,njMCMK  ,    x  ,  x )   ELSE //=     x
      IF ednj  THEN unj (x   ,njAMCMK ,x      ,  x )   ELSE //=x
      IF ednj  THEN unj (   x,njMCMK  ,    x  ,  x )   ELSE //=     x
      IF ednj  THEN unj (x   ,njAMCMK ,x      ,  x )   ELSE //=x
      IF ednj  THEN unj (   x,njMCMK  ,    x  ,  x )   ELSE //=     x
      IF ednj  THEN unj (x   ,njAMCMK ,x      ,  x )   ELSE //=x
--------------------------------------------------------------------------------------------------*)
                               //if kaapontul  then Y_piipit (1);  //<Vain koekäyttöön <<<<<<<<<<<<<
   UNTIL ((NJmm2>1)  AND  NOT kaapontul)  OR  (NJmm2=0)            //< =0 kun vikakaap <<<<<<<<<<<<<
   //TOT vaihtoehtoja yht = 212 Al+Cu.
else //''NJveAC=veAlCu =JohdinmaterBtn =Al+Cu
if NJveAC=veAL       //<JohdinmaterBtn =Al
then REPEAT //TOT vaihtoehtoja yht = 99 Al.
      //tultau[tultauTos(NJtyp),tultauAos(trunc(NJmm2)),NJkaapx] := trunc (NJmm2); //<@@=Eka laskettu merktty NÄIN
      IF edn_ (1   ,njAMCMK ,  1    ,   1)  THEN unj (1   ,njAMCMK , 16  ,   1)   ELSE //          1
      IF edn_ (1   ,njAMCMK , 16    ,   2)  THEN unj (1   ,njAMCMK , 25  ,   2)   ELSE //          2
      IF edn_ (1   ,njAMCMK , 25    ,   3)  THEN unj (1   ,njAMCMK , 35  ,   3)   ELSE //          3
      IF edn_ (1   ,njAMCMK , 35    ,   4)  THEN unj (1   ,njAMCMK , 50  ,   4)   ELSE //          4
      IF edn_ (1   ,njAMCMK , 50    ,   5)  THEN unj (   2,njAMCMK , 25  ,   5)   ELSE //          5
      IF edn_ (   2,njAMCMK , 25    ,   6)  THEN unj (1   ,njAMCMK , 70  ,   6)   ELSE //          6
      IF edn_ (1   ,njAMCMK , 70    ,   7)  THEN unj (   2,njAMCMK , 35  ,   7)   ELSE //          7
      IF edn_ (   2,njAMCMK , 35    ,   8)  THEN unj (1   ,njAMCMK , 95  ,   8)   ELSE //          8
      IF edn_ (1   ,njAMCMK , 95    ,   9)  THEN unj (   2,njAMCMK , 50  ,   9)   ELSE //          9
      IF edn_ (   2,njAMCMK , 50    ,  10)  THEN unj (1   ,njAMCMK ,120  ,  10)   ELSE //         10
      IF edn_ (1   ,njAMCMK ,120    ,  11)  THEN unj (   2,njAMCMK , 70  ,  11)   ELSE //         11
      IF edn_ (   2,njAMCMK , 70    ,  12)  THEN unj (1   ,njAMCMK ,150  ,  12)   ELSE //         12
      IF edn_ (1   ,njAMCMK ,150    ,  13)  THEN unj (1   ,njAMCMK ,185  ,  13)   ELSE //         13
      IF edn_ (1   ,njAMCMK ,185    ,  14)  THEN unj (   2,njAMCMK , 95  ,  14)   ELSE //         14
      IF edn_ (   2,njAMCMK , 95    ,  15)  THEN unj (1   ,njAMCMK ,240  ,  15)   ELSE //         15
      IF edn_ (1   ,njAMCMK ,240    ,  16)  THEN unj (   2,njAMCMK ,120  ,  16)   ELSE //=240     16
      IF edn_ (   2,njAMCMK ,120    ,  17)  THEN unj (1   ,njAMCMK ,300  ,  17)   ELSE //=300     17
      IF edn_ (1   ,njAMCMK ,300    ,  18)  THEN unj (   2,njAMCMK ,150  ,  18)   ELSE //=300     18
      IF edn_ (   2,njAMCMK ,150    ,  19)  THEN unj (1   , njSVj   ,300 ,  19)   ELSE //=300     19
      IF edn_ (1   , njSVj  ,300    ,  20)  THEN unj (   2,njAMCMK ,185  ,  20)   ELSE //=370     20
      //============================================================================================
      IF edn_ (   2,njAMCMK ,185    ,  21)  THEN unj (   3,njAMCMK ,150  ,  21)   ELSE //=450     21
      IF edn_ (   3,njAMCMK ,150    ,  22)  THEN unj (   2,njAMCMK ,240  ,  22)   ELSE //=480     22
      IF edn_ (   2,njAMCMK ,240    ,  23)  THEN unj (   3,njAMCMK ,185  ,  23)   ELSE //=555     23
      IF edn_ (   3,njAMCMK ,185    ,  24)  THEN unj (   2,njAMCMK ,300  ,  24)   ELSE //=600     24
      IF edn_ (   2,njAMCMK ,300    ,  25)  THEN unj (   4,njAMCMK ,150  ,  25)   ELSE //=600     25
      IF edn_ (   4,njAMCMK ,150    ,  26)  THEN unj (1   , njSVj   ,600 ,  26)   ELSE //=600     26
      IF edn_ (1   , njSVj   ,600   ,  27)  THEN unj (   3,njAMCMK ,240  ,  27)   ELSE //=720     27
      IF edn_ (   3,njAMCMK ,240    ,  28)  THEN unj (   4,njAMCMK ,185  ,  28)   ELSE //=740     28
      IF edn_ (   4,njAMCMK ,185    ,  29)  THEN unj (   5,njAMCMK ,150  ,  29)   ELSE //=750     29
      IF edn_ (   5,njAMCMK ,150    ,  30)  THEN unj (   3,njAMCMK ,300  ,  30)   ELSE //=900     30
      IF edn_ (   3,njAMCMK ,300    ,  31)  THEN unj (   6,njAMCMK ,150  ,  31)   ELSE //=900     31
      IF edn_ (   6,njAMCMK ,150    ,  32)  THEN unj (1   , njSVj   ,900 ,  32)   ELSE //=900     32
      IF edn_ (1   , njSVj   ,900   ,  33)  THEN unj (   5,njAMCMK ,185  ,  33)   ELSE //=925     33
      IF edn_ (   5,njAMCMK ,185    ,  34)  THEN unj (   4,njAMCMK ,240  ,  34)   ELSE //=960     34
      IF edn_ (   4,njAMCMK ,240    ,  35)  THEN unj (   7,njAMCMK ,150  ,  35)   ELSE //=1050    35
      IF edn_ (   7,njAMCMK ,150    ,  36)  THEN unj (   6,njAMCMK ,185  ,  36)   ELSE //=1110    36
      IF edn_ (   6,njAMCMK ,185    ,  37)  THEN unj (   4,njAMCMK ,300  ,  37)   ELSE //=1200    37
      IF edn_ (   4,njAMCMK ,300    ,  38)  THEN unj (   5,njAMCMK ,240  ,  38)   ELSE //=1200    38
      IF edn_ (   5,njAMCMK ,240    ,  39)  THEN unj (   8,njAMCMK ,150  ,  39)   ELSE //=1200    39
      IF edn_ (   8,njAMCMK ,150    ,  40)  THEN unj (   1, njSVj   ,1200,  40)   ELSE //         40
      IF edn_ (   1, njSVj   ,1200  ,  41)  THEN unj (   7,njAMCMK ,185  ,  41)   ELSE //=1295    41
      IF edn_ (   7,njAMCMK ,185    ,  42)  THEN unj (   9,njAMCMK ,150  ,  42)   ELSE //=1350    42
      IF edn_ (   9,njAMCMK ,150    ,  43)  THEN unj (   6,njAMCMK ,240  ,  43)   ELSE //=1440    43
      IF edn_ (   6,njAMCMK ,240    ,  44)  THEN unj (   8,njAMCMK ,185  ,  44)   ELSE //=1480    44
      IF edn_ (   8,njAMCMK ,185    ,  45)  THEN unj (   5,njAMCMK ,300  ,  45)   ELSE //=1500    45
      IF edn_ (   5,njAMCMK ,300    ,  46)  THEN unj (  10,njAMCMK ,150  ,  46)   ELSE //=1500    46
      IF edn_ (  10,njAMCMK ,150    ,  47)  THEN unj (  11,njAMCMK ,150  ,  47)   ELSE //=1650    47
      IF edn_ (  11,njAMCMK ,150    ,  48)  THEN unj (   9,njAMCMK ,185  ,  48)   ELSE //=1665    48
      IF edn_ (   9,njAMCMK ,185    ,  49)  THEN unj (   7,njAMCMK ,240  ,  49)   ELSE //=1680    49
      IF edn_ (   7,njAMCMK ,240    ,  50)  THEN unj (   6,njAMCMK ,300  ,  50)   ELSE //=1800    50
      IF edn_ (   6,njAMCMK ,300    ,  51)  THEN unj (  12,njAMCMK ,150  ,  51)   ELSE //=1800    51
      IF edn_ (  12,njAMCMK ,150    ,  52)  THEN unj (  10,njAMCMK ,185  ,  52)   ELSE //=1850    52
      IF edn_ (  10,njAMCMK ,185    ,  53)  THEN unj (   8,njAMCMK ,240  ,  53)   ELSE //=1920    53
      IF edn_ (   8,njAMCMK ,240    ,  54)  THEN unj (  13,njAMCMK ,150  ,  54)   ELSE //=1950    54
      IF edn_ (  13,njAMCMK ,150    ,  55)  THEN unj (  11,njAMCMK ,185  ,  55)   ELSE //=2035    55
      IF edn_ (  11,njAMCMK ,185    ,  56)  THEN unj (   7,njAMCMK ,300  ,  56)   ELSE //=2100    56
      IF edn_ (   7,njAMCMK ,300    ,  57)  THEN unj (  14,njAMCMK ,150  ,  57)   ELSE //=2100    57
      IF edn_ (  14,njAMCMK ,150    ,  58)  THEN unj (   9,njAMCMK ,240  ,  58)   ELSE //=2160    58
      IF edn_ (   9,njAMCMK ,240    ,  59)  THEN unj (  12,njAMCMK ,185  ,  59)   ELSE //=2220    59
      IF edn_ (  12,njAMCMK ,185    ,  60)  THEN unj (  15,njAMCMK ,150  ,  60)   ELSE //=2250    60
      IF edn_ (  15,njAMCMK ,150    ,  61)  THEN unj (   8,njAMCMK ,300  ,  61)   ELSE //=2400    61
      IF edn_ (   8,njAMCMK ,300    ,  62)  THEN unj (  10,njAMCMK ,240  ,  62)   ELSE //=2400    62
      IF edn_ (  10,njAMCMK ,240    ,  63)  THEN unj (  16,njAMCMK ,150  ,  63)   ELSE //=2400    63
      IF edn_ (  16,njAMCMK ,150    ,  64)  THEN unj (  13,njAMCMK ,185  ,  64)   ELSE //=2405    64
      IF edn_ (  13,njAMCMK ,185    ,  65)  THEN unj (   1, njSVj   ,2400,  65)   ELSE //         65
      IF edn_ (   1, njSVj   ,2400  ,  66)  THEN unj (  17,njAMCMK ,150  ,  66)   ELSE //=2550    66
      IF edn_ (  17,njAMCMK ,150    ,  67)  THEN unj (  14,njAMCMK ,185  ,  67)   ELSE //=2590    67
      IF edn_ (  14,njAMCMK ,185    ,  68)  THEN unj (  11,njAMCMK ,240  ,  68)   ELSE //=2640    68
      IF edn_ (  11,njAMCMK ,240    ,  69)  THEN unj (   9,njAMCMK ,300  ,  69)   ELSE //=2700    69
      IF edn_ (   9,njAMCMK ,300    ,  70)  THEN unj (  18,njAMCMK ,150  ,  70)   ELSE //=2700    70
      IF edn_ (  18,njAMCMK ,150    ,  71)  THEN unj (  15,njAMCMK ,185  ,  71)   ELSE //=2775    71
      IF edn_ (  15,njAMCMK ,185    ,  72)  THEN unj (  19,njAMCMK ,150  ,  72)   ELSE //=2850    72
      IF edn_ (  19,njAMCMK ,150    ,  73)  THEN unj (  12,njAMCMK ,240  ,  73)   ELSE //=2880    73
      IF edn_ (  12,njAMCMK ,240    ,  74)  THEN unj (  16,njAMCMK ,185  ,  74)   ELSE //=2960    74
      IF edn_ (  16,njAMCMK ,185    ,  75)  THEN unj (  10,njAMCMK ,300  ,  75)   ELSE //=3000    75
      IF edn_ (  10,njAMCMK ,300    ,  76)  THEN unj (  20,njAMCMK ,150  ,  76)   ELSE //=3000    76
      IF edn_ (  20,njAMCMK ,150    ,  77)  THEN unj (  13,njAMCMK ,240  ,  77)   ELSE //=3120    77
      IF edn_ (  13,njAMCMK ,240    ,  78)  THEN unj (  17,njAMCMK ,185  ,  78)   ELSE //=3145    78
      IF edn_ (  17,njAMCMK ,185    ,  79)  THEN unj (   1, njSVj   ,3200,  79)   ELSE //         79
      IF edn_ (   1, njSVj   ,3200  ,  80)  THEN unj (  11,njAMCMK ,300  ,  80)   ELSE //=3300    80
      IF edn_ (  11,njAMCMK ,300    ,  81)  THEN unj (  18,njAMCMK ,185  ,  81)   ELSE //=3330    81
      IF edn_ (  18,njAMCMK ,185    ,  82)  THEN unj (  14,njAMCMK ,240  ,  82)   ELSE //=3360    82
      IF edn_ (  14,njAMCMK ,240    ,  83)  THEN unj (  19,njAMCMK ,185  ,  83)   ELSE //=3515    83
      IF edn_ (  19,njAMCMK ,185    ,  84)  THEN unj (  12,njAMCMK ,300  ,  84)   ELSE //=3600    84
      IF edn_ (  12,njAMCMK ,300    ,  85)  THEN unj (  15,njAMCMK ,240  ,  85)   ELSE //=3600    85
      IF edn_ (  15,njAMCMK ,240    ,  86)  THEN unj (  20,njAMCMK ,185  ,  86)   ELSE //=3700    86
      IF edn_ (  20,njAMCMK ,185    ,  87)  THEN unj (  16,njAMCMK ,240  ,  87)   ELSE //=3840    87
      IF edn_ (  16,njAMCMK ,240    ,  88)  THEN unj (  13,njAMCMK ,300  ,  88)   ELSE //=3900    88
      IF edn_ (  13,njAMCMK ,300    ,  89)  THEN unj (  17,njAMCMK ,240  ,  89)   ELSE //=4080    89
      IF edn_ (  17,njAMCMK ,240    ,  90)  THEN unj (  14,njAMCMK ,300  ,  90)   ELSE //=4200    90
      IF edn_ (  14,njAMCMK ,300    ,  91)  THEN unj (  18,njAMCMK ,240  ,  91)   ELSE //=4320    91
      IF edn_ (  18,njAMCMK ,240    ,  92)  THEN unj (  15,njAMCMK ,300  ,  92)   ELSE //=4500    92
      IF edn_ (  15,njAMCMK ,300    ,  93)  THEN unj (  19,njAMCMK ,240  ,  93)   ELSE //=4560    93
      IF edn_ (  19,njAMCMK ,240    ,  94)  THEN unj (  16,njAMCMK ,300  ,  94)   ELSE //=4800    94
      IF edn_ (  16,njAMCMK ,300    ,  95)  THEN unj (  20,njAMCMK ,240  ,  95)   ELSE //=4800    95
      IF edn_ (  20,njAMCMK ,240    ,  96)  THEN unj (  17,njAMCMK ,300  ,  96)   ELSE //=5100    96
      IF edn_ (  17,njAMCMK ,300    ,  97)  THEN unj (  18,njAMCMK ,300  ,  97)   ELSE //=5400    97
      IF edn_ (  18,njAMCMK ,300    ,  98)  THEN unj (  19,njAMCMK ,300  ,  98)   ELSE //=5700    98
      IF edn_ (  19,njAMCMK ,300    ,  99)  THEN unj (  20,njAMCMK ,300  ,  99)   ELSE //=6000    99
      NJmm2 := 0;  //<TÄMÄ LOPETTAA.
                               //if kaapontul  then Y_piipit (1);  //<Vain koekäyttöön <<<<<<<<<<<<<
   UNTIL ((NJmm2>1)  AND  NOT kaapontul)  OR  (NJmm2=0)            //< =0 kun vikakaap <<<<<<<<<<<<<
   //TOT vaihtoehtoja yht = 99 Al.
else //''NJveAC=veAL =JohdinmaterBtn =Al
     //,,NJveAC=veCU =JohdinmaterBtn =Cu
   REPEAT//TOT vaihtoehtoja yht = 113 Cu.
      IF edn_ (1   ,njMCMK ,    1  ,   1)  THEN unj (1   ,njMCMK ,    6  ,   1)   ELSE
      IF edn_ (1   ,njMCMK ,    6  ,   2)  THEN unj (1   ,njMCMK ,   10  ,   2)   ELSE
      IF edn_ (1   ,njMCMK ,   10  ,   3)  THEN unj (1   ,njMCMK ,   16  ,   3)   ELSE
      IF edn_ (1   ,njMCMK ,   16  ,   4)  THEN unj (1   ,njMCMK ,   25  ,   4)   ELSE
      IF edn_ (1   ,njMCMK ,   25  ,   5)  THEN unj (1   ,njMCMK ,   35  ,   5)   ELSE
      IF edn_ (1   ,njMCMK ,   35  ,   6)  THEN unj (1   ,njMCMK ,   50  ,   6)   ELSE //=  50
      IF edn_ (1   ,njMCMK ,   50  ,   7)  THEN unj (   2,njMCMK ,   25  ,   7)   ELSE //=  50
      IF edn_ (   2,njMCMK ,   25  ,   8)  THEN unj (1   ,njMCMK ,   70  ,   8)   ELSE //=  70
      IF edn_ (1   ,njMCMK ,   70  ,   9)  THEN unj (   2,njMCMK ,   35  ,   9)   ELSE //=  70
      IF edn_ (   2,njMCMK ,   35  ,  10)  THEN unj (1   ,njMCMK ,   95  ,  10)   ELSE //=  95
      IF edn_ (1   ,njMCMK ,   95  ,  11)  THEN unj (   2,njMCMK ,   50  ,  11)   ELSE //= 100
      IF edn_ (   2,njMCMK ,   50  ,  12)  THEN unj (1   ,njMCMK ,  120  ,  12)   ELSE //= 120
      IF edn_ (1   ,njMCMK ,  120  ,  13)  THEN unj (   2,njMCMK ,   70  ,  13)   ELSE //= 140
      IF edn_ (   2,njMCMK ,   70  ,  14)  THEN unj (1   ,njMCMK ,  150  ,  14)   ELSE //= 150
      IF edn_ (1   ,njMCMK ,  150  ,  15)  THEN unj (1   ,njMCMK ,  185  ,  15)   ELSE //= 185
      IF edn_ (1   ,njMCMK ,  185  ,  16)  THEN unj (   2,njMCMK ,   95  ,  16)   ELSE //= 190
      IF edn_ (   2,njMCMK ,   95  ,  17)  THEN unj (1   ,njMCMK ,  240  ,  17)   ELSE //= 240
      IF edn_ (1   ,njMCMK ,  240  ,  18)  THEN unj (   2,njMCMK ,  120  ,  18)   ELSE //= 240
      IF edn_ (   2,njMCMK ,  120  ,  19)  THEN unj (1   ,njMCMK ,  300  ,  19)   ELSE //= 300
      IF edn_ (1   ,njMCMK ,  300  ,  20)  THEN unj (   2,njMCMK ,  150  ,  20)   ELSE //= 300
      IF edn_ (   2,njMCMK ,  150  ,  21)  THEN unj (   3,njMCMK ,  120  ,  21)   ELSE //= 360
      IF edn_ (   3,njMCMK ,  120  ,  22)  THEN unj (   2,njMCMK ,  185  ,  22)   ELSE //= 370
      IF edn_ (   2,njMCMK ,  185  ,  23)  THEN unj (   2,njMCMK ,  240  ,  23)   ELSE //= 480
      IF edn_ (   2,njMCMK ,  240  ,  24)  THEN unj (   2,njMCMK ,  300  ,  24)   ELSE //= 600
      //=================================================================================================
      IF edn_ (   2,njMCMK ,  300  ,  25)  THEN unj (   3,njMCMK ,  150  ,  25)   ELSE //= 450
      IF edn_ (   3,njMCMK ,  150  ,  26)  THEN unj (   4,njMCMK ,  120  ,  26)   ELSE //= 480
      IF edn_ (   4,njMCMK ,  120  ,  27)  THEN unj (   3,njMCMK ,  185  ,  27)   ELSE //= 555
      IF edn_ (   3,njMCMK ,  185  ,  28)  THEN unj (   4,njMCMK ,  150  ,  28)   ELSE //= 600
      IF edn_ (   4,njMCMK ,  150  ,  29)  THEN unj (   5,njMCMK ,  120  ,  29)   ELSE //= 600
      IF edn_ (   5,njMCMK ,  120  ,  30)  THEN unj (   3,njMCMK ,  240  ,  30)   ELSE //= 720
      IF edn_ (   3,njMCMK ,  240  ,  31)  THEN unj (   6,njMCMK ,  120  ,  31)   ELSE //= 720
      IF edn_ (   6,njMCMK ,  120  ,  32)  THEN unj (   4,njMCMK ,  185  ,  32)   ELSE //= 740
      IF edn_ (   4,njMCMK ,  185  ,  33)  THEN unj (   5,njMCMK ,  150  ,  33)   ELSE //= 750
      IF edn_ (   5,njMCMK ,  150  ,  34)  THEN unj (   7,njMCMK ,  120  ,  34)   ELSE //= 840
      IF edn_ (   7,njMCMK ,  120  ,  35)  THEN unj (   3,njMCMK ,  300  ,  35)   ELSE //= 900
      IF edn_ (   3,njMCMK ,  300  ,  36)  THEN unj (   6,njMCMK ,  150  ,  36)   ELSE //= 900
      IF edn_ (   6,njMCMK ,  150  ,  37)  THEN unj (   5,njMCMK ,  185  ,  37)   ELSE //= 925
      IF edn_ (   5,njMCMK ,  185  ,  38)  THEN unj (   4,njMCMK ,  240  ,  38)   ELSE //= 960
      IF edn_ (   4,njMCMK ,  240  ,  39)  THEN unj (   8,njMCMK ,  120  ,  39)   ELSE //= 960
      IF edn_ (   8,njMCMK ,  120  ,  40)  THEN unj (   7,njMCMK ,  150  ,  40)   ELSE //=1050
      IF edn_ (   7,njMCMK ,  150  ,  41)  THEN unj (   9,njMCMK ,  120  ,  41)   ELSE //=1080
      IF edn_ (   9,njMCMK ,  120  ,  42)  THEN unj (   6,njMCMK ,  185  ,  42)   ELSE //=1110
      IF edn_ (   6,njMCMK ,  185  ,  43)  THEN unj (   4,njMCMK ,  300  ,  43)   ELSE //=1200
      IF edn_ (   4,njMCMK ,  300  ,  44)  THEN unj (   5,njMCMK ,  240  ,  44)   ELSE //=1200
      IF edn_ (   5,njMCMK ,  240  ,  45)  THEN unj (   8,njMCMK ,  150  ,  45)   ELSE //=1200
      IF edn_ (   8,njMCMK ,  150  ,  46)  THEN unj (  10,njMCMK ,  120  ,  46)   ELSE //=1200
      IF edn_ (  10,njMCMK ,  120  ,  47)  THEN unj (   7,njMCMK ,  185  ,  47)   ELSE //=1295
      IF edn_ (   7,njMCMK ,  185  ,  48)  THEN unj (  11,njMCMK ,  120  ,  48)   ELSE //=1320
      IF edn_ (  11,njMCMK ,  120  ,  49)  THEN unj (   9,njMCMK ,  150  ,  49)   ELSE //=1350
      IF edn_ (   9,njMCMK ,  150  ,  50)  THEN unj (   6,njMCMK ,  240  ,  50)   ELSE //=1440
      IF edn_ (   6,njMCMK ,  240  ,  51)  THEN unj (  12,njMCMK ,  120  ,  51)   ELSE //=1440
      IF edn_ (  12,njMCMK ,  120  ,  52)  THEN unj (   8,njMCMK ,  185  ,  52)   ELSE //=1480
      IF edn_ (   8,njMCMK ,  185  ,  53)  THEN unj (   5,njMCMK ,  300  ,  53)   ELSE //=1500
      IF edn_ (   5,njMCMK ,  300  ,  54)  THEN unj (  10,njMCMK ,  150  ,  54)   ELSE //=1500
      IF edn_ (  10,njMCMK ,  150  ,  55)  THEN unj (  13,njMCMK ,  120  ,  55)   ELSE //=1560
      IF edn_ (  13,njMCMK ,  120  ,  56)  THEN unj (  11,njMCMK ,  150  ,  56)   ELSE //=1650
      IF edn_ (  11,njMCMK ,  150  ,  57)  THEN unj (   9,njMCMK ,  185  ,  57)   ELSE //=1665
      IF edn_ (   9,njMCMK ,  185  ,  58)  THEN unj (   7,njMCMK ,  240  ,  58)   ELSE //=1680
      IF edn_ (   7,njMCMK ,  240  ,  59)  THEN unj (  14,njMCMK ,  120  ,  59)   ELSE //=1680
      IF edn_ (  14,njMCMK ,  120  ,  60)  THEN unj (   6,njMCMK ,  300  ,  60)   ELSE //=1800
      IF edn_ (   6,njMCMK ,  300  ,  61)  THEN unj (  12,njMCMK ,  150  ,  61)   ELSE //=1800
      IF edn_ (  12,njMCMK ,  150  ,  62)  THEN unj (  15,njMCMK ,  120  ,  62)   ELSE //=1800
      IF edn_ (  15,njMCMK ,  120  ,  63)  THEN unj (  10,njMCMK ,  185  ,  63)   ELSE //=1850
      IF edn_ (  10,njMCMK ,  185  ,  64)  THEN unj (   8,njMCMK ,  240  ,  64)   ELSE //=1920
      IF edn_ (   8,njMCMK ,  240  ,  65)  THEN unj (  16,njMCMK ,  120  ,  65)   ELSE //=1920
      IF edn_ (  16,njMCMK ,  120  ,  66)  THEN unj (  13,njMCMK ,  150  ,  66)   ELSE //=1950
      IF edn_ (  13,njMCMK ,  150  ,  67)  THEN unj (  11,njMCMK ,  185  ,  67)   ELSE //=2035
      IF edn_ (  11,njMCMK ,  185  ,  68)  THEN unj (  17,njMCMK ,  120  ,  68)   ELSE //=2040
      IF edn_ (  17,njMCMK ,  120  ,  69)  THEN unj (   7,njMCMK ,  300  ,  69)   ELSE //=2100
      IF edn_ (   7,njMCMK ,  300  ,  70)  THEN unj (  14,njMCMK ,  150  ,  70)   ELSE //=2100
      IF edn_ (  14,njMCMK ,  150  ,  71)  THEN unj (   9,njMCMK ,  240  ,  71)   ELSE //=2160
      IF edn_ (   9,njMCMK ,  240  ,  72)  THEN unj (  18,njMCMK ,  120  ,  72)   ELSE //=2160
      IF edn_ (  18,njMCMK ,  120  ,  73)  THEN unj (  12,njMCMK ,  185  ,  73)   ELSE //=2220
      IF edn_ (  12,njMCMK ,  185  ,  74)  THEN unj (  15,njMCMK ,  150  ,  74)   ELSE //=2250
      IF edn_ (  15,njMCMK ,  150  ,  75)  THEN unj (  19,njMCMK ,  120  ,  75)   ELSE //=2280
      IF edn_ (  19,njMCMK ,  120  ,  76)  THEN unj (   8,njMCMK ,  300  ,  76)   ELSE //=2400
      IF edn_ (   8,njMCMK ,  300  ,  77)  THEN unj (  10,njMCMK ,  240  ,  77)   ELSE //=2400
      IF edn_ (  10,njMCMK ,  240  ,  78)  THEN unj (  16,njMCMK ,  150  ,  78)   ELSE //=2400
      IF edn_ (  16,njMCMK ,  150  ,  79)  THEN unj (  20,njMCMK ,  120  ,  79)   ELSE //=2400
      IF edn_ (  20,njMCMK ,  120  ,  80)  THEN unj (  13,njMCMK ,  185  ,  80)   ELSE //=2405
      IF edn_ (  13,njMCMK ,  185  ,  81)  THEN unj (  17,njMCMK ,  150  ,  81)   ELSE //=2550
      IF edn_ (  17,njMCMK ,  150  ,  82)  THEN unj (  14,njMCMK ,  185  ,  82)   ELSE //=2590
      IF edn_ (  14,njMCMK ,  185  ,  83)  THEN unj (  11,njMCMK ,  240  ,  83)   ELSE //=2640
      IF edn_ (  11,njMCMK ,  240  ,  84)  THEN unj (   9,njMCMK ,  300  ,  84)   ELSE //=2700
      IF edn_ (   9,njMCMK ,  300  ,  85)  THEN unj (  18,njMCMK ,  150  ,  85)   ELSE //=2700
      IF edn_ (  18,njMCMK ,  150  ,  86)  THEN unj (  15,njMCMK ,  185  ,  86)   ELSE //=2775
      IF edn_ (  15,njMCMK ,  185  ,  87)  THEN unj (  19,njMCMK ,  150  ,  87)   ELSE //=2850
      IF edn_ (  19,njMCMK ,  150  ,  88)  THEN unj (  12,njMCMK ,  240  ,  88)   ELSE //=2880
      IF edn_ (  12,njMCMK ,  240  ,  89)  THEN unj (  16,njMCMK ,  185  ,  89)   ELSE //=2960
      IF edn_ (  16,njMCMK ,  185  ,  90)  THEN unj (  10,njMCMK ,  300  ,  90)   ELSE //=3000
      IF edn_ (  10,njMCMK ,  300  ,  91)  THEN unj (  20,njMCMK ,  150  ,  91)   ELSE //=3000
      IF edn_ (  20,njMCMK ,  150  ,  92)  THEN unj (  13,njMCMK ,  240  ,  92)   ELSE //=3120
      IF edn_ (  13,njMCMK ,  240  ,  93)  THEN unj (  17,njMCMK ,  185  ,  93)   ELSE //=3145
      IF edn_ (  17,njMCMK ,  185  ,  94)  THEN unj (  11,njMCMK ,  300  ,  94)   ELSE //=3300
      IF edn_ (  11,njMCMK ,  300  ,  95)  THEN unj (  18,njMCMK ,  185  ,  95)   ELSE //=3330
      IF edn_ (  18,njMCMK ,  185  ,  96)  THEN unj (  14,njMCMK ,  240  ,  96)   ELSE //=3360
      IF edn_ (  14,njMCMK ,  240  ,  97)  THEN unj (  19,njMCMK ,  185  ,  97)   ELSE //=3515
      IF edn_ (  19,njMCMK ,  185  ,  98)  THEN unj (  12,njMCMK ,  300  ,  98)   ELSE //=3600
      IF edn_ (  12,njMCMK ,  300  ,  99)  THEN unj (  15,njMCMK ,  240  ,  99)   ELSE //=3600
      IF edn_ (  15,njMCMK ,  240  , 100)  THEN unj (  20,njMCMK ,  185  , 100)   ELSE //=3700
      IF edn_ (  20,njMCMK ,  185  , 101)  THEN unj (  16,njMCMK ,  240  , 101)   ELSE //=3840
      IF edn_ (  16,njMCMK ,  240  , 102)  THEN unj (  13,njMCMK ,  300  , 102)   ELSE //=3900
      IF edn_ (  13,njMCMK ,  300  , 103)  THEN unj (  17,njMCMK ,  240  , 103)   ELSE //=4080
      IF edn_ (  17,njMCMK ,  240  , 104)  THEN unj (  14,njMCMK ,  300  , 104)   ELSE //=4200
      IF edn_ (  14,njMCMK ,  300  , 105)  THEN unj (  18,njMCMK ,  240  , 105)   ELSE //=4320
      IF edn_ (  18,njMCMK ,  240  , 106)  THEN unj (  15,njMCMK ,  300  , 106)   ELSE //=4500
      IF edn_ (  15,njMCMK ,  300  , 107)  THEN unj (  19,njMCMK ,  240  , 107)   ELSE //=4560
      IF edn_ (  19,njMCMK ,  240  , 108)  THEN unj (  20,njMCMK ,  240  , 108)   ELSE //=4800
      IF edn_ (  20,njMCMK ,  240  , 109)  THEN unj (  16,njMCMK ,  300  , 109)   ELSE //=4800
      IF edn_ (  16,njMCMK ,  300  , 110)  THEN unj (  17,njMCMK ,  300  , 110)   ELSE //=5100
      IF edn_ (  17,njMCMK ,  300  , 121)  THEN unj (  18,njMCMK ,  300  , 121)   ELSE //=5400
      IF edn_ (  18,njMCMK ,  300  , 122)  THEN unj (  19,njMCMK ,  300  , 122)   ELSE //=5700
      IF edn_ (  19,njMCMK ,  300  , 123)  THEN unj (  20,njMCMK ,  300  , 123)   ELSE //=6000
      NJmm2 := 0;  //<TÄMÄ LOPETTAA.
                               //if kaapontul  then Y_piipit (1);  //<Vain koekäyttöön <<<<<<<<<<<<<
   UNTIL ((NJmm2>1)  AND  NOT kaapontul)  OR  (NJmm2=0);           //< =0 kun vikakaap <<<<<<<<<<<<<
   //TOT vaihtoehtoja yht = 113 Cu.
//''NjMater=Cu
koe;
//Y_piipit (1);
if (NJkaapx=rinmax)  and
   ( SamIso (NJtyp,njMCMK)  OR  (NJveAC=veAL)and SamIso (NJtyp,njAMCMK) )  and
   (tultau [tultauTos(NJtyp), tultauAos (trunc(NJmm2)), NJkaapx] = trunc (NJmm2))
   then KaapIterF (-1,0);                                      //< -1 =Tekee yhteenvedon TULTAU´sta.
END;//kasva_NJmm2
//............................................
PROCEDURE Laske_dPhu;      VAR i,j,t :Integer;   PIT,rr,xx,duh,{cosu,}dP :Real;      BEGIN //Uusiksi 6.0.0
//*********** dPhu% , dPh%u% ***********       Etsitään dPmax, jolla duh = uh_raja - uh :
{  RATKAISUKAAVA :dPhuh/keskus = duh = (rr*dP + xx*dQ) *L *Kesja *1000 *fV_U_k;
                  ======== ve1:  duh / (L *Kesja *1000 *fV_U_k) = (rr*dP + xx*dQ) = rr*dP +xx*dP*V¨[(1/cos²) -1]
                                                                = dP*( rr + xx*V¨[(1/cos²) -1] )
                                 dP = duh / (( rr + xx*V¨[(1/cos²) -1] ) *L *Kesja *1000 *fV_U_k)   =============

                  Helpompi ve2:  duh / (L *Kesja *1000 *fV_U_k) = (rr*dP + xx*dQ) = rr*dP +xx*dP*Qtas[1]/Ptas[1]
                                                                = dP*( rr + xx*Qtas[1]/Ptas[1] )
                                 dP = duh / (( rr + xx*Qtas[1]/Ptas[1] ) *L *Kesja *1000 *fV_U_k)   =============}
   PIT := 0;
   FOR i := 1 TO kesja  DO
   FOR j := 1 TO i      DO //<'Esim:  dL1=10  dL2=5  dL3=5  =>  10 + 10+5 + 10+5+5 = 45m
      PIT := PIT +a_getReaa (38045, nj.jk[j].dL);
   t := fTuh;                                         //<Jottei kutsu jokaKrt
   rr := res (NJtyp,NJmm2) / NJkaapx;                 //'Laski Sul-Neh erosta                    <,,6.0.0 Siirty ulos
   rr := rTkorj (NJlaji,rr,t);
   xx := Xv_ind (NJtyp,NJmm2) / NJkaapx;
   duh := a_getReaa (38047, nj.jy.UhRaja) - uh;

   if duh<=0
   then begin
        dp := 0;  dPhsuh := 0;  end
   else begin
       {cosu := Ptas[1] / Sqrt( Sqr(Ptas[1]) + Sqr(Qtas[1]) ); //< = Cos=P/S =P/V¨(P²+Q²), KASVU_% ei muuta cos´ia.
        dP := duh / ( (rr + xx*Sqrt (Sqr(1/cosu) -1)) *PIT *Kesja *1000 *fV_U_k );
        //''''''''' { [              (  (      )   )]                           }
        dP := duh / ( (rr + xx*Qtas[1]/Ptas[1]) *PIT *Kesja *1000 *fV_U_k );
        //''''''''' { [                       ]                           }
        dPhsuh := dP * kesja / Ptas[1] * 100;  end;         //<Lasketaan suht. kokon.dPres

   dPhuh := dP;
end;//Laske_dPhu
//............................................
PROCEDURE aseta_V_U_ker;   BEGIN
   Vlkm := a_getIntg (38011, edv.YLE.VaiheLkm); //< VAIHElkm
   IF NOT (Vlkm  IN [1,3])  THEN Vlkm := 3;     //<Varaus mahd. syötettövöön arvoon
   apuker := 100 / (Vlkm * Sqr(fUv)) * 1000;
   IF Vlkm=1  THEN apuker := apuker * 2;        //< Jos 1v

   IF NJlaji  THEN apuker := apuker / alg  //<Nämä vain tarkistuslaskentaa
              ELSE apuker := apuker / cug; //<'varten vanhalla kaavalla
END;//aseta_V_U_ker
//............................................
PROCEDURE Laske_uh;   VAR i,t :Integer;   a8{H},ar,PIT,rr,xx,Rv,Xv :Real;      BEGIN
   {                       Uh'= pitkittäiskompon.   Myös (ei tarvita):  sinÞ=Q/V¨(P²+Q²),  cosÞ=P/V¨(P²+Q²)
                              = IpR + IpXtanÞ       <= Ip=P/[(V¨3)*U],  tanÞ = Q/P
                                ,,Ip     *R +   Ip     *X*tanÞ,, ############### <<<<<<<<<<<<<<<<<<<
                              = (P/V¨3*U)*R + (P/V¨3*U)*X*Q/P  = (PR + QX)/V¨3*U <<<<<<<<<<<<<<<<<<<
                           uh%= Uh'*100/U                        ############### <<<<<<<<<<<<<<<<<<<
                           uh%= [ (PR + QX)/(V¨3U) ] *100/U
                              = [ (RP + XQ)/(V¨3)  ] *100/U²
                                ######################### <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                              = [100/(U²V¨3)] * (RP + XQ)      = 100/(U²V¨3) * P(R + X tanø)        +6.0.0
                                ######################### <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                           OLI: 100/U² * (RP + XQ)             = 100/Uv²     * P(R + X tanø)        -6.0.0
   ................................................................................................}
   uh := 0;   uhx := 0;
   a8 := 1;                                           //,,,Tähän, kun Hvrt=1 käytännössä, ellei koeajoa varten muu.
   IF NOT (Hvrt IN [0,10])                            //<Hvrt:  -1=SuljeBtn  0=Ohita  1=HäviöKust
      THEN a8 := fKertaSuor_Diskont (a_getReaa(3815,nj.hav.Tpit), a_getReaa(3815,nj.hav.dPprs)); //<+3.0.0
                            //''Jos häviöt huomioidaan, lasket lopputehon muk
   {--t := pyor (edka^[2].Ivks);                              //<[2].Ivks=cta
      IF t>70  THEN t := 70;   --}                    //<Ei voi>rakenteellMax
   t := fTuh;                                         //<Jottei kutsu jokaKrt
   rr := res (NJtyp,NJmm2) / NJkaapx;                 //'Laski Sul-Neh erosta                    <,,6.0.0 Siirty ulos
   rr := rTkorj (NJlaji,rr,t);
   xx := Xv_ind (NJtyp,NJmm2) / NJkaapx;
   FOR i := 1 TO kesja  DO BEGIN
      PIT := a_getReaa (38016, nj.jk[i].dL);
      Rv := PIT * rr;
      Xv := PIT * xx;
               //,uhv vielä näissä vain apuna<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                                                   //,fV_U_k = 100 / Sqr(fUn);   //< 3v=100/U²    <+6.0.0
      uhv := ( Rv *Ptas[i] + Xv *Qtas[i] ) *a8 *1000 *fV_U_k;
      uh :=  uh  + uhv;                               //<uhv tässä vain apuna
      IF Hvrt IN [0,10]  THEN uhv := uhv *(a_getReaa (38018, nj.jy.kasvuv)/100 +1); //<+3.0.0
      uhx := uhx + uhv;           //'KASVUV=kasvuvara, huomioid vain jos eiHÄVIÖparam:lla erikseen kasvatet.
   END;                           //Ptas[i],Qtas[i] = LOPPUketjun tasoitettu yhteisteho i-pisteessä.
                                 {ar := Ptas[1];   ar := ar *a8;
                                  if ar<-1  then beep;
                                  ar := Ptas[1] / Sqrt( Sqr(Ptas[1]) + Sqr(Qtas[1]) );//< =Cos =sama, vaikka KASV>1
                                  if ar<-1  then beep;//Deb=0.894427..}

   LedvUh := uh / ( (rr*Ptas[1] + xx*Qtas[1]) *a8*1000 *fV_U_k ); //<Sij VAIN tässä. käyttö NjTul31.INC +6.0.0
   //'Kylläkin esim:  40+5+5+5 => 40+45+50+55 = 190 => 190/4 = 47.5 m =SAMA YKSINKERTAISEMMIN.!!!!!!

   ar := 0;//a_getReaa (38019, edv.NjL.edUhOsa);                              -4.0.0
   uh :=  uh + ar;            //<'Nj:n u%:iin lisätään edeltävien johtojen u%
   uhx := uhx+ ar;            //< uhx sis. kasvuvaran, ks UNTIL <<<<<<<<<<<<<  Annetun nj.jy.UhRaja tarkistukseen.

   uhv := 0;        //<Vertailun vuoks lasketaan vanhalla tavalla ja kaavalla
   FOR i := 1 TO kesja  DO
      uhv := uhv + (a8 *Ptas[i] * a_getReaa (38020, nj.jk[i].dL) * apuker / NJmm2)  / NJkaapx;
                   {H}{'}     //'Tarkistus vanhalla kaavalla VAIN NJ:n OSALTA
                              //'uhv = VAIN NJ:n OSALLA <<<<<<<<<<<<<<<<<<<<<
   uhv := uhv + ar;           //<Lisättiin ed. johdon osuus (R+X muk lask)
END;//Laske_uh
//===========================================================================
procedure fs (o :integer);      begin //ssf esittely NjTul3.PAS.   +10.0.5
{  if o=0  then ssf := Ints(NJsul) +'/ '
           else ssf := ssf +Ints(o);
   if N1ehto  then ssf := ssf +'+'
              else ssf := ssf +'_';
   ssf := ssf +'(' +Ints(NJsul) +') ';
   if o<0  then ssf := '';  }end; //<Ehkei käyttöä.

BEGIN//etsiKaap
pal := OK;
uhx := 0;   uh := 0;
aseta_V_U_ker;                                       //<Pakko AINA, mm. Vlkm tarvitaan JOS uhkin ###
if tuxV<=0  then begin  //<@@ Ettei tulisi joka kierroksella iterointia NJmm2 = 1 :stä ALKAEN ######
   NJkaapx := 1;
   NJmm2 := 1;
end;
//@tut := 0;                                         //<Ei käytössä !!!!!!!!!!!! =Delphi: Never used
//@IF alpx=2  THEN i := 1  ELSE i := alpx;           //<Ei enää tarvetta ??????? =Delphi: Never used
uhehto := TRUE;  //<koe -tulostuksen takia jos uhkin=FALSE, Error: REAL Indef
ZSiso := FALSE;   IkKasvattiMm2 := FALSE;   KatMgAli := FALSE;   KatZSali := FALSE;
njn := 0;                 //<njn=Vain koesilmukkalaskuri. 6.1.1, OLI xn, AIHEUTTIKO VÄÄRISTYMIÄ!?!?!?!?!?!?!?!?!?
fs(-1);                   //,,,Tässä sijoitetaan alkuselvittelyn tulokset lopull.laskentaa varten = VAIN 1x,,,
REPEAT                    //,,,Muutoin vain kasvatetaan NJmm2 + Lkm ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
//§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.
      //##########################################################################################################
      //##########################################################################################################
      //############### ULOS -pääsyn määrää N1EHTO, joka säätelee UHEHTOa, ks. UNTIL -lopun edellä.###############
      //############### Pane BreakPointti N1EHTO := FA -kohtiin.##################################################
      //##########################################################################################################
{u}IF uhkin  AND (tuxV<=0)  AND uhehto    //<UhEHTO tarp josUh eiOK tutkitlla <@ Nyt TAAS VÄLTTÄMÄTN
   THEN BEGIN                             //<Etsitään 1.ve, joka selvitettiin '@'#### (tuxV<=0) ####
                     er := 0;  if er<-9999  then NJkaapx := 1;     //<Vain ettei Dephin Hinttiä<<<<<
      NJkaapx := alpx;                    //ja merkattiin PRC etsiSulTapa:ssa '@'###################
      NJlaji := fAlCu (NJtyp); //<TÄRKEÄ:  NJtyp arvo jäi voim etsiSulT:ssa ##################################
      IkKasvattiMm2 := alpIkKasvattiMm2;  //<,IkKasv..+ZSiso :n tutkimiseen ei enää päästä (vrt. tultau),@@@@@
      ZSiso := alpZSiso;                  //  joten nämä tiedot jäävät tutkimatta = välitetään näin.@@@@@@@@@@
      IF tultau[1 ,0,1] >0
      THEN BEGIN  NJlaji := TRUE;              {+@}//<Pakko olla jotta alkutieto
                  NJtyp :=  njAMCMK;           {+@}//<EiTarttis:  tultau ehtoki jo edellytti <<<<<<<
                  NJmm2 :=  tultau[1 ,0,1];  end
      ELSE IF tultau[2 ,0,1] >0
      then BEGIN  NJlaji := FALSE;             {+@}//<Pakko olla jotta alkutieto
                  NJtyp :=  njMCMK;            {+@}//<EiTarttis:  tultau ehtoki jo edellytti <<<<<<<
                  NJmm2 :=  tultau[2 ,0,1];  END
      else BEGIN  NJlaji := TRUE;              {+@}//<Pakko olla jotta alkutieto
                  NJtyp :=  njSVj;             {+@}//<EiTarttis:  tultau ehtoki jo edellytti <<<<<<<
                  NJmm2 :=  tultau[3 ,0,1];  END;
      tyhtultau;                               {+@@}//<Tyhjätään, jotta 2.EtsiSulTapassa tutkittu TULOSTUISI
      tultau[tultauTos(NJtyp),tultauAos(trunc(NJmm2)),NJkaapx] := trunc (NJmm2); //<@@=Eka laskettu merktään
    //if tuxV>0  then kasva_NJmm2;             //<@ nyt tarvitaan, kun alusta ..AND (tuxV<=0) vex <<
   END                                         //'@@'Nyt taas tarpeeton:  Alkuehto rajasi vex (tuxV<=0)
   ELSE kasva_NJmm2;

   IF NJkaapx=2  THEN jx := 1        //<SULAKElukumäärän hämäysmuuttuja, vrt.
                 ELSE jx := NJkaapx; //seur. IF...untilehto/KuorSul,2,Ikat <<
   ulos := FALSE;
fs(0);
IF NJmm2=0   //11111111111111111111111111111111111111111111111111111111111111
THEN ulos := TRUE                            //<Oli jo vika ve 20xCu240->ulos
ELSE BEGIN   //==============================================================
   YVsul := pyor (YvSuoj ({'G'}suCse,FALSE,FALSE,a_getStrg (38036, nj.jy.astapa),  //<FA=eiYhtSul  FA=eiKATK
                          a_getReaa (38037, nj.jy.korjaus), NJtyp,NJmm2,NJkaapx)); //<AinoaSijYVsulle
                    //''YVsul,ZSsul + YVkat,ZSkat oltava ennen LASKE_UH <- fTuh ##############################
{N}N1ehto := IksOK (Iskmin,Ikm,IkSul); //<LASKEE+ASETTAA Ikm ja IkSul := 1Neh arvot ##########################
   ZSsul := IkSul;                     //<'IkSul := IksOK :ssa ###############################################
   NJsul := YVsul;                     //<,,PieninMäärää NJsul´in.###########
   IF ZSsul>0   //22222222222222222222222222222222222222222222222222222222222
   THEN BEGIN                                           //,Vain KULnj :lle
{N}   IF a_getBool (38038, nj.jy.NjKulSal) AND N1ehto  THEN  BEGIN
         ar := a_getReaa (38039, edv.YLE.PoisAika);     //<ar =Tim ZsIa_OKlle
         if edNo<0  then e := edNo                      //<, +6.2.2  §?§
                    else e := edNo-1;
         WHILE NOT ZsIa_OK (12,suCse,e,0,TRUE,TRUE,     //<os,NJkin,KUL<<<<<< edNo=3.0.3  4.0.0
                            ZSsul,ar, '',0,0,0,0)
         DO BEGIN  ZSiso := TRUE;                       //<Mrktiin ZsIa ylit.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                   pienIsul (ZSsul);  END; END;         //<PienKunnes ZsIa_OK

fs(1);
      if ZSsul<NJsul    then NJsul := ZSsul;
      IF KuorKat > jx* NJsul                            //<,Jos jx*NJsul ei riitä KUORMALLE (=KuorKat)...
         THEN BEGIN NJsul := 0;                         // => Ohjataan KATKAISIJAlle! ############################
fs(2);
                    ZSiso := FALSE;  END;
      IF (KuorKat <= jx*YVsul) and                      //<YVsul riittävä kuormalle, mutta,,,,,,,,,,,,,,,,,,,,
         (KuorKat >  jx*ZSsul)                          //< johdn Ik1v :n sallima ZSsul KUORMALLE liian PIENI.
      then begin
         IkKasvattiMm2 := true;
         NJsul := 0;                                    //< =Ohjat KATKAIS:lle! ##############################
fs(3);
         ZSiso := FALSE;
         IF uhkin  then begin                           //<,,Vasta kun myös tulostetaan = ei alkututkinnassa !
            sri := IkKasvattiMm2Str;                                                   //<TYHJÄTTIIN 31.INCssä
                       {sri := sri +tab1 +'20 á SVjärjest. 3200'+tab1+'YVsulMax/IkSulMax = á 1500/1000A<br>';
                        sri := sri +tab1 +'SVjärjest. 3200'+tab1+'YVsulMax/IkSulMax = á 1500/1000A<br>';
                        sri := sri +tab1 +'20 á AMCMK 300'+tab1+'YVsulMax/IkSulMax = á 1500/500A<br>';}
                           { 	2 á AMCMK4½ 120	YVsulMax/IkSulMax = 250/160A
                              2 á MCMK4½ 95	YVsulMax/IkSulMax = 250/160A
                              2 á AMCMK4½ 150	YVsulMax/IkSulMax = 250/160A
                           MCMK4½ 185	YVsulMax/IkSulMax = 250/160A}

                       {if NJkaapx>1  then sri := sri +tab1  +fImrkt0(NJkaapx,1) +' á ';            -6.1.1
                                           sri := sri +NJtyp +' ' +fRmrkt0(NJmm2,1,0) +tab1 +'YVsulMax/IkSulMax = ';}

                               sri := sri +tab1;                                              //<,, +6.1.1
                        //if NJkaapx=1  then sri := sri +                  '     ';
            if NJkaapx>1  then sri := sri +fImrkt0(NJkaapx,1) +' á ';
                               sri := sri +NJtyp +' ' +fRmrkt0(NJmm2,1,0) +tab1 +'YVsulMax/IkSulMax = ';
            if NJkaapx>2  then sri := sri +'á ';
                               sri := sri +fImrkt0(YVsul,1) +'/' +fImrkt0(ZSsul,1) +'A<br>';
                               sri := sri +'';   //<Debuggerin takia
            IkKasvattiMm2Str := sri;
         end;//if uhkin
      end;//if (Kuorkat<=..  'Tulostetaan ennen kuin arvo vaihtuu, OK.
   END;//IF ZSsul>0  22222222222222222222222222222222222222222222222222222222
fs(6);
   //,,===========================YHTEISET KAIKILLE = JosEiKatkaisijakaan -> UUSI mm2 ============,,
   YVkat := YvSuoj ({'G'}suCse,TRUE{FALSE-10.0.5},TRUE,a_getStrg (38041, nj.jy.astapa),  //<TR=samaSul  TR=KATK
                    a_getReaa (38042, nj.jy.korjaus), NJtyp,NJmm2,NJkaapx);
   NJkat := YVkat;                                 //<EiTarttisSijVielä???.OK
   ImgKat := Ikm*0.8;
   IF ImgKat*KeroMg < KuorKat                      //<Mg-Term ero p.o. > 15% ???????????????????????????????????????????
   then begin                                      //,KaapKuormalle OK, mutta Ikm MÄÄRÄÄ ISOMMAKSI..
fs(7);
     {if KuorKat > ImgKat  then }KatMgAli := true; //<KuorKat eiVoi <= ImgKat, jos tähän päästy <<<<
{N}   N1ehto := FALSE;  end                        //<=Ohjataan seur mm2 :iin #################################!!!
   else IF YVkat < KuorKat                         //< Johdn kuormit  < Tarve
{N}THEN BEGIN
fs(8);
        N1ehto := FALSE;  END                      //<=Ohjataan seur mm2 :iin #################################!!!
   ELSE BEGIN         //<######### OPTIMOINTIA: Ei eteenpäin ellei edellst OK ####################################
                      //,######### Nyt Ik1v + YVkat (+NJkat) riittäv -> ZsIa? ####################################
      IF a_getBool (38043, nj.jy.NjKulSal)         //<Vain KULnj:lle <<<<<<<<
      THEN BEGIN
       //ZSkat := Ikatk_ZsIa (edmaxkpl,1,TRUE);       //< -4.0.0
         if edNo<0  then e := edNo                    //<,+6.2.2  §?§
                    else e := edNo-1;
         ZSkat := Ikatk_ZsIa (e,1,TRUE);              //< edmaxkpl -> EdNo 3.0.3  4.0.0
fs(9);
         IF ZSkat<KuorKat  THEN begin
            KatZSali := TRUE;                      //<Tulostustietoihin <<<<<                 {<ALI}
fs(10);
{N}         N1ehto := FALSE;    end; END           //<=Ohjataan seur mm2 :iin <<<<<<<<<<<<<<<<<<<<<<
{@+}  ELSE ZSkat := ImgKat;                        //<SÄL:n arvo jää tähän <<
                            {--------------------Vex: Lasketaan ja varoitetaan tulost:ssa/31.INC-----------,ImgTim-asetus EISAA=LYHYT
                                IF (0.1 > Tekv (Iksalterm (NJtyp,NJmm2),  //,0=Ik3v 1.JK:lle. =TimEkviv.
                                                iks (Ik3vTR, Ziks (0,edmaxkpl,NJkinTR,'',0,0,0,0, ar,ar,ar,ar)) ))
                                   OR  (0.1 >Tekv (Iksalterm (NJtyp,NJmm2), ImgKat))
                                   THEN N1ehto := FALSE;----------------------------------------------------}
   END;//..else IF YVkat < KuotKat..ELSE

{N}IF N1ehto  THEN if MootNj  then WITH MoNj  DO  //,[2]=ImgMinVaatim [3]=TimVaatim
      IF (MoNj.mImg > Iksalterm (NJtyp,NJmm2))  OR        //<MoNj... Jotta arvo näkyisi debugatessa. +7.0.5 Tek
       //(mTim > Tekv (Iksalterm (NJtyp,NJmm2), mImg))    //-6.0.0
         (mTim > Tekv_mn (edNo,mImg,TRUE{NJkin}))         //<TypOsMukaan,tamaIK,NJkin.  e=>edNo=+7.0.5
{N}   THEN N1ehto := FALSE;                               //'Kaapelin Ekviv_Ik1sAIKA < moot
         //'''''''FA ennen IF uhkin'''''                  //lähtöjen Ekviv_Ist1sTIM+käyväIn
         //,,,,,,,Vasta tässä. VoisOlla aikais. Joka tapauksessa oltava SULAKEarvot LOPULLISET, vrt. fTuh
fs(11);
{N}IF uhkin AND N1ehto  THEN BEGIN                        //<N1ehto..=optimointia
      laske_uh;     //< uh,uhx,uhv === YVsul,ZSsul,ZSkat oltava ennen LASKE_UH <- fTuh #####################
     {IF uhx > a_getReaa (38044, edv.NjL.yhtUhRaja)  THEN uhehto := FALSE
                                                     ELSE uhehto := TRUE;  END;                      -4.0.0}
{u}   IF uhx > a_getReaa (38044, nj.jy.UhRaja)  THEN uhehto := FALSE                             //< +4.0.0
                                                ELSE uhehto := TRUE;  END;
{N}IF uhkin   AND  NOT N1ehto
{u}   THEN uhehto := FALSE;                               //< Muuten jos ei IksOK aloittaa aina ekas-
{Nu}IF uhehto  AND     N1ehto                             //' ta mm2:sta=ikuinen silm ##############
      THEN ulos := TRUE;                                  //,,TÄSSÄ+31.INC #########################
 {@@IF uhkin  THEN }tultau[tultauTos(NJtyp),tultauAos(trunc(NJmm2)),NJkaapx] := trunc (NJmm2);
                     //'Mrkitään "tulostksi", ettei seurMm2:ssa tutkita samoja: @@=Nyt tarvitaan jo
                     //'tutkimisvaiheessa:  Tyhjennys UHKIN vaiheen alussa #########################
   WrKaapLasF (njn);
END;//IF NJmm2>0 ELSE  111111111111111111111111111111111111111111111111111111
UNTIL  ulos;  //############# Ulos vain jos SEKÄ N1ehto ETTÄ UhEhto TR. #################### Komm. 10.0.5 ########
//§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.§.

IF NJmm2=0
THEN pal := virhe
ELSE BEGIN
   IF uhkin  THEN
      Laske_dPhu;
END;//ELSE
if uh<-100  then beep;  //<BreakPointille
END;//etsiKaap

//##################################################################################################
//##################################################################################################
//##################################################################################################

PROCEDURE etsiSulTapa (VAR pal :ohjaava);   LABEL 9;   CONST Iohamax=5000; //Kutsu vain PRC OhjTul_eritNj :ssa.
          VAR   Imin,ekaA,ekaKat :real;   ekaSu,ekaNx,ekaXx :Integer;
                ekaT :string;      ekaL, qBtnAC,qBtnAL,qBtnCU :Boolean;      BEGIN
qBtnAC := fBtnAC;
qBtnAL := fBtnAL;
qBtnCU := fBtnCU;
pal := OK;
//Imin := Stas[1] *fKi *(a_getReaa (38052, nj.jy.Kasvuv)/100 +1); //< -3.0.0 =Korvattu seuraavalla,,,
IF Hvrt IN [0,10]                                                 //<,+3.0.0  0=EiHuomHäviöitä  1=HuomioiHäviöt.
 //THEN Imin := Stas[1] *fKi /0.9 *(a_getReaa (38051, nj.jy.Kasvuv)/100 +1)      //< /0.9 oli DOS-versiossa
 //THEN Imin := Stas[1] *fKi /     (a_getReaa (38051, nj.jy.Kasvuv)/100 +1)      //<-10.0.5
   THEN Imin := Stas[1] *fKi *     (a_getReaa (38051, nj.jy.Kasvuv)/100 +1)      //< 10.0.5 Imin pitää kasvaa.
   ELSE Imin := Stas[1] *fKi *fKertaSuor_Diskont (a_getReaa (38052, nj.hav.Tpit), a_getReaa(38052,nj.hav.dPprs));
                                  //''EiMuuta kasvuvaraa kuin dPprs<<<<<<<<<<    //'+3.0.0
tyhtultau;                        //<<<<< ALKUASETUS <<<<<<<<<<<<<<<<<<<<<<<<
tux := 0;   tuxV := 0;            //<<<<< ALKUASETUS tux = 0..VExKrt,   tuxV = kumulat.<<<<<<<<<<<<<
KuorKat := Imin;                  //<<<<< JÄÄ AINA VOIMAAN <<<<<<<<<<<<<<<<<<
KuorSul := 0;                            //<+10.0.5 jotta debuggerissa näkyisi 0 seur riville tultaessa.
   KuorSul := pyor (Imin/fKsul (suCse,pyor (Imin)));
   ZSsul := KuorSul;                     //<ZSsul tässä vielä vain apuna

   IF KuorSul>1250
   THEN KuorSul := 0
   ELSE BEGIN
      kasvaIsul (KuorSul);               //<Muokataan vakiokooksi!!!!!!!!!!!!
      pienIsul (KuorSul);                //<'kasvaIsul+pienIsul = vakiokooksi
      WHILE KuorSul < ZSsul  DO
            kasvaIsul (KuorSul);         //<ZSsul oli vain apuna
   END;

   if MootNj  then
      KuorSul := MoNj.mSul;       //<MOOTTLÄHDÖISSÄ oli laskettu Ist:n muk.<<
   alpx := 1;                     //< - " - <<<<< ALKUASETUS <<<<<<<<<<<<<<<<
   if qBtnCU                      //<Jos VAIN CUve valittu, AL ei edes kokeilla  6.1.1
      then begin
           NJtyp := njMCMK;       //<<<<< ALKUASETUS <<<<<<<<<<<<< - " - <<<<
           NJveAC := veCU;  end   //< CU
      else begin
           NJtyp := njAMCMK;
           NJveAC := veAL;  end;  //< AL
   NJlaji := fAlCu (NJtyp);       //<<<<< VAIHDETAAN PRC TULOSTA, KASVA_A <<< @=Pitää olla synkr + ekax.ALUM.
                                  //NJtyp, NJkaapx, NJlaji OHJAUKSET kasva_A:ssa
                                  //############################################
etsikaap (FALSE,pal);     //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Etsitään eka kaapeli (Al) <<<<<<<<<<<<<
IF (pal=virhe) and (qBtnCU or qBtnAL)  THEN GOTO 9;  //<Haluttiin vain CU- tai AL -veja ja 20x240 ei riittänyt
   ekaKat := NJkat;
   ekaSu :=  NJsul;                                  //<Talteen 1.ve:n tiedot
   ekaNx :=  NJkaapx;                                //<Talteen 1.ve:n tiedot
   ekaA :=   NJmm2;                                  //<Talteen 1.ve:n tiedot
   ekaT :=   NJtyp;                                  //<Talteen 1.ve:n tiedot
   ekaL :=   NJlaji;                                 //<Talteen 1.ve:n Al tai Cu <<<
   ekaIkKasvattiMm2 := IkKasvattiMm2;                //<Talteen 1.ve:n tiedot. Muuten tieto ohittuu tulostssa!
   ekaZSiso := ZSiso;                                //<Talteen 1.ve:n tiedot. Muuten tieto ohittuu tulostssa!
   IF NJkaapx=2  THEN ekaXx := 1  ELSE ekaXx := NJkaapx; //<-"- 1.ve:n tiedot

   //,,GOTO ohjaa tästä ohi jos tarve.########################################################################
   //,,Katsotaan  olisiko Cu:lla pienempi min.sulake. Al:lla alkaa 35A:sta <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if qBtnAC  then begin                     //<Pelkkä Cu (fBtnCU) tutkittiin äsken,  +6.1.1
   NJveAC := veCU;                        //< fBtnAC=Al+Cu lasketaan myös CU:lla (=2).
   NJtyp := njMCMK;                       //Min.sulake. Al:lla alkaa 35A:sta <<
   NJlaji := fAlCu (NJtyp);
   NJkaapx := 1;
   etsikaap (FALSE,pal);  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Etsitään toka kaapeli (Cu) <<<<<<<<<<<<
end;
IF pal=virhe  THEN GOTO 9;

   IF NJkaapx=2  THEN alpx := 1  ELSE alpx := NJkaapx;              //<,Seur.testiä varten. Kohta muuttuu ####
                                                              //,,Cu(=2.)VEn ekvivArvot pienmät @@@@@@@@@@@@@@
   IF (NJsul>0) AND ((NJsul*alpx < ekaSu*ekaXx)  OR (ekaSu=0))   or //<0=SVj3200
{@+}  (NJsul=0) and (ekaSu=0) and (NJkat<ekaKat)                    //<Ei SUL al+cu ja..
      THEN BEGIN {KuorSul := NJsul; ?}alpx := NJkaapx;              //<TÄSTÄ alpx välittää NJkaapx TULOST:seen
                  alpIkKasvattiMm2 := IkKasvattiMm2;                //'NJtyp,NJkaapx yms.jäävoim @@@@@@@@@@@@@
                  alpZSiso := ZSiso;
                  tultau[tultauTos(NJtyp),0,1] := trunc (NJmm2);  END
      ELSE BEGIN {KuorSul := ekaSu; ?}alpx := ekaNx;          //<,,PalautetaanPienmät = 1.ve @@@@@@@@@@@@@@@@@
                  NJsul := ekaSu;                                   //<Tarve ???????????????????????
                  NJlaji := ekaL;   NJkaapx := ekaNx;               //<ekaL voi=Al/Cu ##############
                  NJmm2 := ekaA;    NJtyp := ekaT;
                  alpIkKasvattiMm2 := ekaIkKasvattiMm2;             //<Ks. PRC etsiKaap alku @@@@@@@
                  alpZSiso := ekaZSiso;
                  tultau[tultauTos(NjTyp),0,1] := trunc (ekaA);  END;
                          //ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
                          //Takas alkuasetukset, muuten PÄÄOHAN KUTSUESSA 1.
9:                        //TULOSTUVA nj OLISI TÄSTÄ SEURAAVA. = TODETTU <<<<
                          //ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
if qBtnAC  then NJveAC := veAlCu  else //<,,6.1.1
if qBtnAl  then NJveAC := veAL    else
                NJveAC := veCU;        //<fBtnCU
END;//etsiSulTapa
//##################################################################################################
//##################################################################################################
//##################################################################################################
PROCEDURE ohjaaEditNj;      VAR ohj :ohjaava;  {i,j,k,t :integer;  }sa,sh :string;  ar :real;     BEGIN
ohj := OK;  tux := 0;       //'PRC Vaihtelee Al->Cu->Al <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
repeat
   if tuxV>0  then etsiKaap (TRUE,ohj); //<Ettei ETSISULTAPA :n jälkeen muuttaisi EKOJA LÖYDETTYJÄ ###############
   if ohj=OK  then begin                //<+6.2.2,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,TulNoEdi.Items.Add () siir-
      tulostaNousu;                     // retty 31.INC´iin jotta vikaVEno´kin tulisi pud.valikkoon. = +8.0.4
      tux := tux +1;                                  //<Lopputestiä varten <<<<<

      IF NJsul>isosul  THEN isosul := NJsul;          //<Olisi ilman testiäkinOK=1x   @TARVE ??????????????????
      IF NJkat>isokat  THEN isokat := NJkat;          //<<<< Ks. selektiveinfo..      @TARVE ??????????????????

{@@   IF NJtyp<>'SVjärjest.'      //<HUOM: OLE TARKKANA MERKKOJONON OIKEELLISUUDEN KANSSA #############
      THEN IF NJlaji  THEN begin  NJlaji := FALSE;    //<etsikaapAloittaa <<<<<<<
                                  NJtyp := njMCMK;      end  //@NJtyp := 'MMJ/MMK*';  end
                      ELSE begin  NJlaji := TRUE;     //1 mm2 ja NJkaapx=1 <<<<<<
                                  NJtyp := njAMCMK;    end; //@NJtyp := 'AMMK*';     end;
}  end;//if ohj=OK
until (ohj<>OK)  or  (tux>=VExKrt)  or  (NJmm2=0); //<Vaikka jos NJmm2=0 -> ohj := VIRHE <<<<<<<<<<<
                       (*@IF  (tux<VExKrt)  AND  (tuxV<VExKrt)  AND  {@edka[1].onarvot
                          THEN IF }(edRv (1,edmaxkpl{@edka[1].edjohtoja}, 3) > 0)
                          THEN WRITELN (
                             'Tutki voitaisiinko EDELTÄVIEN JOHTOJEN poikkipintaa kasvattaa !!!!!');
                          END;//IF (tux<VExKrt)...*)
                       //@-if NOT NJlaji  and (NJkaapx=rinmax)  and (NJmm2=240)   then
            (*,,,TOSI HYVÄ LISTAUS TULOSTETTUJEN mm2 :n TARKISTUKSEEN ######################################
                                 //str := '</in></in>';
                                 str := 'LASKETUT ve :t :<br>'; //<TULOSTANOUSU oli jo TYHJENTÄNYT str :n ##
                                 FOR k := 1 TO 3         DO
                                 FOR i := 1 TO mm2NoMax  DO BEGIN  t := 0;  //< 0 varattiin min.ve:lle
                                 FOR j := 1 TO rinmax    DO BEGIN
                                    if (i=1) and (j=1)  then case k of
                                       1 :str := str +'AMCMK<br>';
                                       2 :str := str +'MCMK<br>';   3 :str := str +'SVjärj.<br>';  end;
                                  //if tultau[k,i,j]= 0  then str := str +fImrkt0 (i,1) +'=' +fImrkt0 (tultau[k,i,j],1);
                                    if tultau[k,i,j]<>0  then begin  t := t+1;   str := str +fImrkt0 (j,1) +'x' +
                                                                     fImrkt0 (tultau[k,i,j],1) +'   ';  end;
                                    if (t>0) and (j=rinmax)  then str := str +'<br>';  END; END;
                                 NjTulFrm.aRich.AddText (str);   str := '';   //<a========================*)

                                     //@-IF (tux<VExKrt)  AND  (tuxV<VExKrt)   THEN
   if NJmm2=0  then begin   //if NOT NJlaji  and (NJkaapx=rinmax)  {and (NJmm2=0)  }or (tuxV=1)
      sh := 'Al';  if NOT fBtnAL  then sh := 'Cu';
      sa := 'Max.kaapelijärjestelmälaajuus 20 x 300 '+sh +' ylittyi.';            //<,Samat tulosteet aRich'iin
      if tuxV<=1  then sa := sa +'   Ei ainuttakaan kelvollista ratkaisua !   ';
      sa := sa +'   Onko ed.verkko liian heikko tai laskettu kuorma liian iso?';
      if a_getBool (38051, nj.jy.NjKulSal) and (a_getReaa (38051, edv.YLE.PoisAika) <1)
         then sa := sa +'  Tutki, onko mahdollista muuttaa poiskytkentäaikavaatimus 5 s :ksi?';
      sa := sa +'        Tulostettuja vaihtoehtoja:  '+fImrkt0 (tuxV,1) +' kpl';
      Beep;  EiOKinfo (sa);
                                                                                     //',Samat tulosteet aRich'iin
      sa := '</in></in>Max.kaapelijärjestelmälaajuus 20 x 300 '+sh +' ylittyi.<br>'; //<Mahd. sisennykset vex
      if tuxV<=1  then sa := sa +'Ei ainuttakaan kelvollista ratkaisua !<br>';
      if a_getBool (38052, nj.jy.NjKulSal) and (a_getReaa (38052, edv.YLE.PoisAika) <1)
         then sa := sa +'Tutki, onko mahdollista muuttaa poiskytkentäaikavaatimus 5 s :ksi?<br>';
      if tuxV<=50  then begin
         sa := sa +'Toteutuneita vaihtoehtoja vähän,  onko edeltävä verkko liian heikko tai käsitelty '+
               'kuorma '+fKmark (0,Stas[1],1,0) +' kVA';
         ar := a_getReaa (38053, nj.jy.tasaus);
         if ar<1  then sa := sa +' (tasaus '+fRmrkt0 (ar,1,3) +')';
         sa := sa +'  liian iso?<br>';
      end;

      NjTulFrm.aRich.AddText (sa);
   end;//if NJmm2=0
END;//ohjaaEditNj
//==================================================================================================
PROCEDURE ketjuarvot;   VAR i,j,m :Integer;  aPs,aSs,aQs,aIs,ar :real; //DOS Nola4.INC :stä
   PROCEDURE asetaTasaus;   VAR j :Integer;   tasNop,ka :real; //Qas :ARRAY [1..kesmax] OF real;
                          {Tas.kertoimen kaava:  Tas = Kmax + (1 - Kmax) * nopeusvak potsiin(Lkm-1?)
                                                 Ks. J.Jauhiaisen dipl.työ s.12-13. '-1 eiOK,p.o.'j}
      FUNCTION lukupotsiin (luku, expon :Real) :Real;   BEGIN  //<EI KÄYTETTY
                                       //Luku potsiin expon = Exp (expon * Ln (luku)).  LUKU p.o > 0
         IF luku>0  THEN Result := Exp ( expon * Ln (luku) )
                    ELSE Result := 0;
      END;
   BEGIN       //,,tas [1] :een syötettiin MAX.TAS. Jos kesja=1, TÄMÄ OHITTUU
      tas[1] := a_getReaa (38058, nj.jy.tasaus);                 //=+@. Muuttuu, jos kesja>1 <<<<<<<
      tasNop := 0.75;
      ka := 0;                         //<"Might not..init.: IF kesja>1 sulkee vex, mutta silloin ei
      IF kesja>1  THEN BEGIN           //'myöskään koskaa j<2, vrt FOR j := 2 to kesja -1 <<<<<<<<<<
         tas[kesja] := 1;                                        //<Ketjun vikassa tasaus=1 <<<<<<<<
         ka := (tas[1] - lukupotsiin (tasNop,kesja-1)) / (1 - lukupotsiin (tasNop,kesja-1)); //<DEVELOPER2
      END;                    //FOR j := 1 TO kesmax  DO Qas[j] := 0;
                              //Qas[1] := tas[1];   Qas[kesja] := tas[kesja];
      FOR j := 2 TO kesja-1  DO           //< [1] ja [kesja] asetettiin jo <<
      BEGIN
                           {if tas[1]<1                          //<Muuten antaa lukuja > 1 <<<<<<<<
                            then tas[j] := tas[1] + tas[1] * ( 1- Ln ((kesja-j+1)*1.7182/kesja +1) )
                            else tas[j] := 1;                                 //''1.7182=e- 1      }
                            //'''''''''''''' OK, mutta loiva, eikä nopeuskerrointa ;''''''''''''''''
                           {Qas[j] := tas[1] + (1 - tas[1]) * lukupotsiin(0.75, kesja-j);
                            tas[j] := Qas[j];                 //<'=USER2 parempi korjattuna   }
                           {! tas[j] =  tasMax + (1 - tasMax) * nopeusvak potenssiin(Lkm-1?)
                            ! tas[j] := tas[1] + (1 - tas[1]) * lukupotsiin(nopeus, kesja-j);}
         tas[j] := ka + (1 - ka) * lukupotsiin(tasNop, kesja-j); //<DEVELOPER2. DEVELOPER1: Nyt upea: Kun
         //[1]=0.5, tasNop=0.75, kesja=10 -> tas[1..10]=0.5 .514 .532 .556 .588 .63 .687 .763 .865 1
      END;
   END;//asetaTasaus
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
BEGIN//ketjuarvot
Pskok := 0;  Qskok := 0;  Akok := 0;   m := 0;  NJpit := 0;
kesja := a_getIntg (38061, nj.jy.ketjussa);  //<P.o. ennen PRC asetaTasaus kuts.
                                             //'GLOBAALI SIJ. ######################################
for i := 1 to kesja  DO BEGIN
   aPs := a_getReaa (38062, nj.jk[i].Ps);
   ar := a_getReaa (38063, nj.jk[i].Coss);          //<,, S = P / Cos                           ar =+8.0.4
   if ar>0                                          //<Varm.vuoksi, oli +6.0.0:   if aSs>aPs  then...
   then begin                                       //<Muutettu 8.0.4
      aSs := aPs / ar;
      aQs := Sqrt( Sqr(aSs) - Sqr(aPs) );  end      //,aQs := aPs => aQs := 0                       8.0.4
   else begin
      aSs := aPs;
      aQs := 0;
   end;                                             a_putReaa (38064, aSs, nj.jk[i].Ss);
                                                    a_putReaa (38065, aQs, nj.jk[i].Qs);
   aIs := aSs * fKi;                                a_putReaa (38066, aIs, nj.jk[i].Iss);
   NJpit := NJpit +a_getReaa (38065, nj.jk[i].dL);
END;//for
for i := 1 to kesja  DO BEGIN
   Pskok := Pskok + a_getReaa (38067, nj.jk[i].Ps);
   Qskok := Qskok + a_getReaa (38068, nj.jk[i].Qs);
   ar := a_getReaa (38069, nj.jk[i].ala);
   if ar>0  then BEGIN
      Akok := Akok + ar;
      m := m + 1;  END;

   Ptas[i] := 0;
   Qtas[i] := 0;
   j := kesja +1;
   REPEAT
      j := j - 1 ;                                          // 1.:ssä kaap.välissä kaikkien tehot,
      Ptas[i] := Ptas[i] + a_getReaa (38076, nj.jk[j].Ps);  // ei vielä huomioida tasoituksia
      Qtas[i] := Qtas[i] + a_getReaa (38077, nj.jk[j].Qs);  //'=[1]:ssä = [1,2..kesja].Ps,Qs !!!!!!!
   UNTIL j = i                                              //' [2]:ssa = [2,3..kesja].Ps,Qs jne.!!!
END;

IF m<kesja  then Akok := 0;          //<fRmrk5_ (Akok,1,1) => '- - - - -'
asetaTasaus;                         //<Asettaa tas [] #####################
for i := 1 to kesja  DO              // Tasoitetut tehot eri keskuspisteissä
BEGIN                                // Tas [1] :ssä MAX.TASAUS <<<<<<<<<<<<
   Ptas[i] := Ptas[i] * tas[i];                   //< u%:n laskemista varten
   Qtas[i] := Qtas[i] * tas[i];
   Stas[i] := Sqrt ( Sqr(Ptas[i]) + Sqr(Qtas[i]) );
END;
Sskok := Sqrt ( Sqr(Pskok) + Sqr(Qskok) );
//Iskok := Sskok * fKi;
END;//ketjuarvot
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NjLas38.INC }

{Kohtaan 1 jatkoksi,,,
      IF edn_ (   3,njMCMK  ,    120)  THEN unj (   3,njAMCMK    ,300    )   ELSE
      IF edn_ (   3,njAMCMK ,300    )  THEN unj (1   ,njSVj      ,900    )   ELSE
      IF edn_ (1   , njSVj  ,900    )  THEN unj (   3,njMCMK     ,    150)   ELSE

      IF edn_ (   3,njMCMK  ,    150)  THEN unj (   4,njAMCMK    ,150    )   ELSE
      IF edn_ (   4,njAMCMK ,150    )  THEN unj (   3,njMCMK     ,    185)   ELSE

      IF edn_ (   3,njMCMK  ,    185)  THEN unj (   4,njAMCMK    ,185    )   ELSE
      IF edn_ (   4,njAMCMK ,185    )  THEN unj (   3,njMCMK     ,    240)   ELSE
Kohtaan 1 jatkoksi'''}


