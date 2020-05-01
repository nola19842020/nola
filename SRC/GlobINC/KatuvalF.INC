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

//##################################################################################### KatuValF.INC
PROCEDURE LueLaskeKatuval; //,,,,,KAIKKI PRC:t + FNC:t pääPRC :n sisällä
      TYPE RecTyp = RECORD Rno, nP1,P1,Cos1, nP2,P2,Cos2, nP3,P3,Cos3, LT,Krj,mm2,Sul,Pit :real;
                           Tun,AsT,KaTyp :String;   KUL,Iec :boolean;  END;
      VAR KatuPolkuFilen,hs :string;  KatuFile :Text;
          ArrRec :Array of RecTyp;  Rec :RecTyp;

   procedure Eherja (sh :string);   begin
    //MessageDlg (sh, mtInformation, [mbOk], 0);   end;
      InfoDlg (sh,mtError, 'OK','','','', '','','','');  end;
   procedure Iherja (sh :string);   begin
    //MessageDlg (sh, mtInformation, [mbOk], 0);   end;
      InfoDlg (sh,mtInformation, 'OK','','','', '','','','');  end;

   //...............................................................................................
   PROCEDURE LueSijFile;     CONST aosMax=17;           //,RV=ao.sorcerivi  AOS=ao.arvo rivillään.
                             VAR lukuja,k,rv,aos, GliitNo :Integer;  sorc,alpS,s,sa :string;  onOK, LueEka :boolean;
                                 Guha{alkuUh%} :real;                       //LueEka=1.rivin '''luku (liit.tiedot)
                               //osu{[uusiOs]},ohu{10,11} :integer;
      //............................................................................................
      procedure FarvoEiOK (sh :string);   begin
         if sh<>''  then InfoDlg (sh +' -arvo virheellinen.',mtError, 'OK','','','', '','','','');
         onOK := false;  end;
      //............................................................................................
     {procedure sorceherja;   begin
         Eherja ('Tiedostossa '''+KatuPolkuFilen+''' virhe,   Rivi: '+fImrkt0 (rv,1) +'. Tutkimatta: <br>'+sorc+
                 '<br>Yleisin virhe tehosarakkeissa: kerroinmerkki "x" tai "*" puuttuu.');  end;}
      //............................................................................................
     {function fInt (ss :string) :integer;       VAR  i :integer;    BEGIN //<,,Ei käytetty
         if not SokI (ss,i)  then begin  sorceherja;  i := 0;   end;   Result := i;   end;}
      //............................................................................................
      procedure fRea (ss :string;  VAR arvo :Real; sh :string);      VAR  r :real;  BEGIN //,Hoitaa myös ',' -> '.'
         if NOT SokR (ss,r)
          //then begin  sorceherja;  r := 0;   end;
            then begin  r := 0;  FarvoEiOK (sh);  end;
         arvo := r;
      end;

      procedure fStr (ss :string;  VAR alkio :string);      BEGIN
         alkio := ss;
      end;
      procedure fBoo (ss :string;  VAR alkio :boolean;  sh :string);      BEGIN
         if AnsiUpperCase (ss) = 'KUL'  then        alkio := TRUE  else
         if AnsiUpperCase (ss) <>'SÄL'  then begin  alkio := FALSE;  FarvoEiOK (sh);  end
                                        else        alkio := FALSE;
      end;
      procedure fS_R (ss :string;  VAR nn :Real;  VAR rr :Real;  sh :string); //< ss = '12x125' = nn x rr
            VAR  s1,s2 :string;
         function krtMrk (mrk :string) :boolean;      CONST c1='x';  c2='*';      begin
            result := false;
            if (mrk=c1) or (mrk=c2)  then result := true;  end;
      BEGIN //,SokR Hoitaa myös ',' -> '.'
         nn := 0;  rr := 0;
         s1 := '';
         if ss<>''  then
         repeat s1 := s1 +ss[1];  Delete (ss,1,1);
         until (ss='') or  ((ss<>'') and (krtMrk(s1[Length (s1)]))); //<Vikax S1:hon kopioitui kertomerkki 'x' tai '*'

         s2 := '';   ss := Trim (ss);
         if ss<>''  then
         repeat s2 := s2 +ss[1];  Delete (ss,1,1);
         until (ss='') or  (ss[1]=' ');                            //<Vikax S2:hon kopioitui jokin oikea mrk.

         if krtMrk(s1[Length (s1)])  then begin                    //<R1:n vikana mrkinä on 'x' tai '*'
            Delete (s1,Length (s1),1);                             //... joka delataan.
            if NOT SokR (s1,nn)  or  NOT SokR (s2,rr)  then begin
               nn := 0;  FarvoEiOK (sh);  end;
         end;//if krtMrk
      end;//fS_R
      //============================================================================================
      function okC (c :char) :boolean;      begin
         result := CharInSet(c, ['0'..'9','.']);  end;

      function LueLopustaDel (VAR s :string) :string;      VAR su :string;      begin
         s := Trim (s);  su := '';
         repeat if s<>''  then begin
                   su := s[Length (s)] +su;      //<Liitetään mjonon ALKUUN.
                   Delete (s,Length(s),1);  end; //<Delataan luetut (LOPUSTA).
         until (Length(s)=0) or (Length(s)>0) and (s[Length(s)]=' ');
         result := su;
      end;

      function LueEkaArvoDel (VAR s :string) :string;      VAR su :string;      begin
         s := Trim (s);  su := '';
         repeat if s<>''  then begin
                   su := su +s[1];               //<Liitetään mjonon loppuun.
                   Delete (s,1,1);  end;         //<Delataan luetut (ALUSTA).
       //until (Length(s)=0) or (Length(s)>0) and (s[1]=' ');    -10.0.4  OliOK
         until (s='')  or (s<>'') and (s[1]=' ');             //< 10.0.4  Näin helpompi, OK.
         result := su;
      end; 
      //--------------------------------------------------------------------------------------------
      procedure Nayta;      VAR ar,aa, pr,ir,rr, yp,yq,pp,qq,uhn, ZRv,ZXv, p1,p2,p3, q1,q2,q3 :real;
                                ii,ai, i,j,k,n,vikaOs{=pisja-1} :integer;  str,sa,sb,su :string;

             {PALAUTTAA:   XZN:  X: 1=PT kohdalla   2=PT edellä   3=PT jäljessä   4=PT´tä ei ole edv:ssä 100..400
                                  Z: 1=Uk<=50(75)    2=Uk>50(75)                                         110..420
                                   N: 1=SULok         2=SUL liian iso                                    111..422}
               //,Kopioitu alunp. Moot.INC:stä / fUkmoS.  ,KUL = ao.johto-osuuden suoj.ehto.
         function fUkChk (os :integer;  VAR Uk,PEpit,palSul :real) :integer;//=111...422 //:string; (=oli alunperin)

                  VAR Rn,Xn,Zn, uRn,uXn, Zk,Tim :real;  sulS :string;
                      i,ai, ohj,pal :integer;
                      xRv,xRv0,xRn, xXv,xXv0,xXn, Ik1v,
                      qRv,qRv0,qRn, qXv,qXv0,qXn, Rsz,Xsz,Zsz,LszKer,Lsz :real;      begin

               if ArrRec[os].KUL  then Tim := 5                          //<Kiinteän laitteen poiskytk.aika = 5 s.
                                  else Tim := 15;
               if ArrRec[os].Iec  then sulS := su_IECgYR
                                  else sulS := su_OFAg;
                                                                               //GliitNo = Verkon solmupisteen nro
               Ziks_ (11 ,GliitNo,1,NJkinFA,Tim, '',0,0,0,0, Rsz,Xsz,LszKer,Lsz); //<11=Ik1v [os]:n lopussa
               qRv := 0;  qRv0 := 0;  qRn := 0;   qXv := 0;  qXv0 := 0;  qXn := 0;
               for i := 1 to os  do begin                                                //<,Lasketaan KatuvalZjohto
                  xRv := res      (        ArrRec[i].KaTyp , ArrRec[i].mm2 ) *ArrRec[i].Pit;
                  xRv := rTkorj   ( fAlCu (ArrRec[i].KaTyp), xRv, Pyor (ArrRec[i].LT) );
                      qRv := qRv +xRv;
                  xXv := Xv_ind   (        ArrRec[i].KaTyp , ArrRec[i].mm2 ) *ArrRec[i].Pit;
                      qXv := qXv +xXv;
                  xRv0 := resN    (        ArrRec[i].KaTyp , ArrRec[i].mm2 ) *ArrRec[i].Pit;
                  xRv0 := rTkorj  ( fAlCu (ArrRec[i].KaTyp), xRv0, Pyor (ArrRec[i].LT) );
                      qRv0 := qRv0 +xRv0;
                  xXv0 := Xv0_ind (        ArrRec[i].KaTyp , ArrRec[i].mm2 ) *ArrRec[i].Pit;
                      qXv0 := qXv0 +xXv0;
                  xRn := resP     (        ArrRec[i].KaTyp , ArrRec[i].mm2 ) *ArrRec[i].Pit;
                  xRn := rTkorj   ( fPal  (ArrRec[i].KaTyp), xRn, Pyor (ArrRec[i].LT) );
                      qRn := qRn +xRn;
                  xXn := Xp_ind   (        ArrRec[i].KaTyp , ArrRec[i].mm2 ) *ArrRec[i].Pit;
                      qXn := qXn +xXn;
               end;
               Rsz := Rsz +2*qRv +qRv0 +3*qRn;
               Xsz := Xsz +2*qXv +qXv0 +3*qXn;
               Zsz := Sqrt (Sqr(Rsz) + Sqr(Xsz));
               Zk := Zsz;
               Zsz := Zsz/3;                                                 //<6.0.3:n korj: Ziks sis. 3.!!!!!!!!

               Rn :=  0;  Xn :=  0;               //<Pitää alustaa nyt, kun sijoitukset edeltä kommentoitu vex.###
               uRn := 0;  uXn := 0;  PEpit := 0;  //, (0,... Jos 1 -> tekee mjonoa 1.rvstä m-tiedoista, ei tärkeä.
                                                           //,0=ZpeYR50V ei anneta.+11.0.1
               laskeEdvZpe (1,GliitNo,0,ohj,uRn,uXn,PEpit);//<ohj,uRn,uXn =Palautuvia arvoja =Laskee edvn PE:n Zn :n.
               Rn := Rn +uRn;   Xn := Xn +uXn;         //PEpit on SÄL 2.nollausehtoa varten, ei vielä käytetty.
               Zn := Sqrt (Sqr (Rn) + Sqr (Xn));       //'########################################################
              {ar := Ik * Zn;                     //<Kosketusjännite.<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
               ''''''''''''''''''''''''Tätä tarvittiin vain, kun laskettiin Uk moottoriRj:n Zpe mukaan''''''''''''}
               pal := 400;
               case ohj of  //,,,,,,,OHJ:  1=PT kohdalla   2=PTedellä(<Zpe)   3=PTjäljssä(<Zpe)   0=PTtäEiooEdv:ssä
                  0 :pal := 400; //< OHJ=0:  Ei PE-johdinta edVerkossa.  = PAL=400:  Ei PE-johdinta edVerkossa.
                  1 :pal := 100; //<     1:  PT kohdalla                 = PAL=100:  PT kohdalla
                  2 :pal := 200; //<     2:  Pienpi Zpe edellä verkossa. = PAL=200:  PT edellä   (+ Zpe pienpi)
                  3 :pal := 300; //<     3:  Pienpi Zpe jälmpnä vrkssa.  = PAL=300:  PT jäljessä (+ Zpe pienpi)
               end;//case
               Uk := Zn*fUv/Zsz;                  //<Uk = Zpe*Uo/Zs ##############################################
                                //XZN:  X: 1=PT kohdalla   2=PTedellä   3=PTjäljssä   4=PTtäEiooEdv:ssä 100..400
               if ArrRec[os].KUL //      Z: 1=Uk<=50(75)    2=Uk>50(75)                                  110..420
               then if Uk<=50     //      N: 1=SULok         2=SUL liian iso                              111..422
                       then pal := pal +10        //<PAL 110..410
                       else pal := pal +20        //<PAL 120..420
               else if Uk<=75
                       then pal := pal +10        //<PAL 110..410
                       else pal := pal +20;       //<PAL 120..420
               result := pal;
               //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,MaxSulNeh,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
               Ik1v := iks (Ik3vFA, GliitNo, Zk);       //<,Ik1v ao.johto-osuuden lopussa
               ai := fSul_Neh (sulS,Ik1v,Tim);          //<Ei sis. ZsIa -tarkistusta =RAAKA
              {FUNCTION fSul_ZsIa (suCs :string;  os,alpNehSul :Integer;  PEk :real;  NJkin,KulSal :Boolean;  Tim :Real;
                                   QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer) :Integer;}
               palSul := fSul_ZsIa (sulS,os,ai, 0, FALSE,ArrRec[os].KUL, Tim, '',0,0,0,0); //<MaxSallSul
         end;//fUkChk
                                                                  //,Pätee milelivaltaiselle kokonaislukukoodille.
         function fArv3 (sar,koodi :integer) :integer;      VAR s :string;  o :integer;      begin
                     //Palauttaa: XZN:  X: 1=PT kohdalla   2=PTedellä   3=PTjäljssä   4=PTtäEiooEdv:ssä 100..400
                     //                  Z: 1=Uk<=50(75)    2=Uk>50(75)                                  110..420
                     //                   N: 1=SULok         2=SUL liian iso                              111..422
            s := IntToStr (koodi);
            if sar<0  then begin
              {Iherja ('Parametrina liian pieni luku ('+IntToStr (sar) +'), Max='+IntToStr (Length (s)) +
                       ' , korjataan 1 :ksi.');}
               sar := 1;  end;
            if sar>Length (s)  then begin
              {Iherja ('Parametrina liian iso luku ('+IntToStr (sar) +'), Max='+IntToStr (Length (s)) +
                       ' , korjataan '+IntToStr (Length (s)) +' :ksi.');}
               sar := Length (s);  end;
            if NOT SokI (s[sar],o)  then
               Eherja ('Jostain syystä kokonaislukumuunnos ei onnistu, ota yhteys valmistajaan. Virhe: '+
                       'KatuvalF.INC/FNC arv3');
            result := o;
         end;

         function fAnnaSulTap (os :Integer) :Integer;      VAR sa :string;  ei :integer;      BEGIN
            sa := AnsiUpperCase (ArrRec[os].AsT);
            case sa[1] of
               //  :ei := OikSuoj ({'G'}suCse,tyyp,mm2,lkm);
               'A' :ei := pyor (YvSuoj ({'G'}suCse,FALSE,FALSE,'A',ArrRec[os].Krj, ArrRec[os].Katyp, ArrRec[os].mm2, 1{lkm}));
               'C' :ei := pyor (YvSuoj ({'G'}suCse,FALSE,FALSE,'C',ArrRec[os].Krj, ArrRec[os].Katyp, ArrRec[os].mm2, 1));
               'D' :ei := pyor (YvSuoj ({'G'}suCse,FALSE,FALSE,'D',ArrRec[os].Krj, ArrRec[os].Katyp, ArrRec[os].mm2, 1));
            else ei := 0;  end;
            result := ei;
         END;//sijSul

      begin//Nayta............................................................
         NjTulFrm.aRich.Lines.Add(''); //<Ilman tätä teksti lisääntyy alkuun ja jo tehty teksti tulee sen jälkeen.
         str := '<f n="Courier New">'; //str := '<f n="Symbol">a</f>';
         str := str +'============================================================================================================<br>';
         str := str +'<b>Tiedosto/Katuvalotiedot:  ' +KatuPolkuFilen +'</b><br>';
         str := str +CLR_BLB +'Tällä tiedostolla välitetään NOLAlle laskettavan katuvaloverkon tiedot sarakkeissa (1)..13), NOLA laskee 14)..<br>';
         str := str +'Tiedoston käyttö korvaa käyttöliittymän.<br>';
         str := str +'Tiedot tulee siis saattaa laskentatilannetta vastaavaksi ENNEN tiedoston kutsumista ja ne<br>';
         str := str +'voidaan päivittää laskennan välillä. Käytä ASCII-editoria (esim. Notepad).<br>' +FNT_B0;
         str := str +'Tässä näkyvät TIETOSISÄLLÖN KUVAUS ja selitykset esitetään kaikissa laskentatapauksissa vaikkei niitä olisi tähän avatussa tiedostossa.<br><br>';
         str := str +'<b><u>TÄMÄN TIEDOSTON SISÄLLÖN KUVAUS:</u></b><br>';
         str := str +'- Otsikkorivien (1) 2)  3)...<br>';
         str := str +'                Riv Ryh Lt...<br>';
         str := str +'                No  Tun ²C...  ' +COLOR_BLUE +'jälkeen vasta alkavat '+
                     'laskentaparametririvit (RivNo:t 0..), joista<br>';
         str := str +'  RivNo=0 on erikoisrivi, missä välilyönneillä erotettuna:</f><br>';
         str := str +'     <b>RiviNo (ei pakollinen)  LaskentapisteenNo  Alkujännitealenema</b><br>';
         str := str +'     esim:  0 0              =Laskennan lähtöpisteenä liittymän jälkeinen JK, alku-Uh%=0<br>';
         str := str +'- Kukin rivi edustaa omaa johto-osaa esitettynä järjestyksessä VERKON alusta päin.<br>';
         str := str +'- NOLA käsittelee arvoriveinä vain ne rivit, jotka ALKAVAT numerolla "0"..."9" tai desimaalierottimella "," tai "."<br>';
         str := str +'<b><u>SARAKESELITYKSET / Annettavat laskentaparametrit:</u></b><br>';
         str := str +'(1,2) Vapaasti annettava rivi- ja ryhmä(tms.)numero. Ei liity laskentaan, on vain visuaalisena apuna rivierottelussa.<br>';
         str := str +'(3)   LT = Johdinresistanssien laskentalämpötila:  Yleensä SÄL 40°C, KUL 80°C.<br>';
         str := str +'(4)   SUOJ.EHD.: (Suoj.ehdon tarkastelutapa) Sähkölaitoksen jakeluverkko (A1) =SÄL,  Kuluttaja-as. (SFS 6000) =KUL.<br>';
         str := str +'(5,6) Tehosarakkeissa (n x P1...P3, esim: 1x26500) tehot on annettava muodossa KPL x P [W], P1 on vaiheelle L1.. jne.<br>';
         str := str +'      NOLA laskee eri pisteiden kokonaistehot (läpimenevät tehot) tehosarakkeista itse.<br>';
         str := str +'(7)   As. tap = Johdon asennustapa (A,C,D=maa).<br>';
         str := str +'(8)   Korj kerr = Johdon asennusolosuhteiden mukainen kuormitettavuuden korjauskerroin.<br>';
         str := str +'(9)   SUL[A] = Valittu sulake [A].<br>';
         str := str +'(10)  SUL typ = Käytettävä sulaketyyppi:  i (tai I) = IEC-Gg  F = OFAA.<br>';
         str := str +'(11)  mm2 = Äärijohtimen poikkipinta. Jos riittämätön, NOLA kasvattaa ja huomauttaa lisämerkillä ''<''.<br>';
         str := str +'(12)  NOLA hyväksyy kaapelityyppeinä:<br>';
         str := str +'         AMCMK3½ AMCMK3½½ AMCMK4½ AXMK AXCMK AMMK* APAKM* AMKA AVOJOHal<br>';
         str := str +'         MCMK3½ MCMK3½½ MCMK4½ MMJ/MMK* PLKVJ* AVOJOHcu<br>';
        {str := str +'         KiskAbb-AlN KiskAbb-AlS KiskAbb-CuN KiskAbb-CuS KiskAbb-CuNx KiskAbb-CuSx<br>';
         str := str +'         SVsystAL3½ SVsystCu3½ SVsystAL4N SVsystCu4N SVsystAL5S SVsystCu5S<br>';}
         str := str +'         (A)MCMK tulkitaan (A)MCMK4½:ksi. Ei enää tuotannossa -merkki ''*'' pitää olla tyypissä mukana.<br>';
         str := str +'(13)  L[m] =Johto-osan pituus [m].<br>';
         str := str +'<b><u>SARAKESELITYKSET / NOLA laskee:</u></b><br>';         
         str := str +'(14)  YvS/OiS =Asennustavan korjauskertoimen mukainen max.ylivirtasuojasulake kaap.tyypin mm2:lle (YvS), <br>';
         str := str +'              /Ois =Sille sallittu oikosulkusuoja. '+CLR_REB +'0 = As.tapa ei sallittu (esim. AMKA /D)'+FNT_B0+'.<br>';
         str := str +'(15)  MaxS =Suojausehtojen (KUL=5s / SÄL=2.5x .. 3x) SALLIMA max.sulake, jos '+CLR_REB +'SUL>MaxS, käytetään punaista väriä'+FNT_B0+'.<br>';
         str := str +'(16)  Seh  =Suojausehdoista (ks. myös MaxS 14) tarkistetaan kosketusjännite Uk ja SÄL´n 2. nollausehto.<br>';
         str := str +'      Uk>50(75) = '+CLR_REB +'Uk' +FNT_B0 +', <b>edeltä</b> (SÄL)verkosta ei löydy maadoitusta ('+
                     FONT_PIENPI +'200m) = '+CLR_REB +'2' +FNT_B0 +', <b>ao. ehto kunnossa = -</b><br>';
         str := str +'(17)  I1/I2/I3 -sarake = Ao. (L1, L2, L3) vaihevirta.<br>';
         str := str +'(18)  =Yht[kW] =Kaikkien vaiheitten yhteisteho ao. pisteessä. Tämän (ja yhteisQ:n) perusteella uhY%.<br>';
         str := str +'(19)  uhY%= Ao. pisteen (3v)uh%, kun kaikien vaiheitten tehot [kW] on summattu kumulatiivisesti.<br>';
         str := str +'<br>';
         str := str +CLR_BLB +
                     '(1) 2)  3)  4)    5)     6)     7)     6)     5)     6)  7)   8)   9) 10) 11)   12)    13)    ' +FNT_B0 +
                                                                                                                   '14)    15) 16)    17)      =18)      19)=<br>';
         str := str +'Riv Ryh LT SUOJ Pylväs- ja vaihekoht. tehot P[W] ja Cos  As. Korj SUL SUL mm² Tyyppi       ' +CLR_BLB +
                                                                                                                '|--> NOLA laskee ...........................<br>'+FNT_B0;
         str := str +'No  Tun °C EHD. n x P1  Cos1  n x P2  Cos2  n x P3  Cos3 tap kerr [A] typ              L[m] YvS/OiS MaxS Seh I1/I2/I3[A] =Yht[kW] uhY%=<br>';

         NjTulFrm.aRich.AddText (str);   str := '';

{1.rv}   str := str +'0 '{RivNo} +Ints (GliitNo) +' ' +fRmrkt0 (Guha,1,2) +' '; //<,+10.0.4:  RivNo=0 .
         str := str +'  =(RivNo) Liittymäpiste  Alku-uh% (erikoisrivi, ks. kuvaus edellä)';

         NjTulFrm.aRich.AddText (str +'<br>');   str := '';

         vikaOs := Length (ArrRec) -1;
         n := 0;   uhn := Guha;         //<Lisätään alkupisteen uh%.
         for i := 0 to vikaOs  do begin
            n := n +1;                  //<Rivikontrollilaskuri: Tarkkaillaan, onko RinNo sama, jos ei ->PUNAINEN.
{Sar:Rno 1} str := fRmrkt0 (ArrRec[i].Rno,1,0);
          //if n>-1 then n := Pyor (ArrRec[i].Rno)-2;
            if n<>ArrRec[i].Rno-1  then ;//str := CLR_REB +str +FNT_B0;
            if ArrRec[i].Rno<10   then str := str +'  '  else        //< Oli 1..9   -> '9--'
            if ArrRec[i].Rno<100  then str := str +' ';              //<    10..99     '99-', muuten '999'
            str := str +' ';

{2 Tun}     str := str +ArrRec[i].Tun +' ';
                if Length (ArrRec[i].Tun)=0  then str := str +'   '  else
                if Length (ArrRec[i].Tun)=1  then str := str +'  '   else
                if Length (ArrRec[i].Tun)=2  then str := str +' ';

{3 LT°}     str := str +fRmrkt0 (ArrRec[i].LT,2,0) +' ';
{4 KUL}     if ArrRec[i].KUL  then str := str +'KUL '  else str := str +'SÄL ';

{5 N x P}   str := str +fRmrkt0 (ArrRec[i].nP1,3,0) +'x' +fRmrkt0 (ArrRec[i].P1,1,0);
                if ArrRec[i].P1<10      then str := str +'  '  else
                if ArrRec[i].P1<100     then str := str +' '   else
                if ArrRec[i].P1>=999999 then str := str +fRmrkt0 (ArrRec[i].P1/1000,1,0);  str := str +'  ';
{6 cos}     str := str +fRmrkt0 (ArrRec[i].Cos1,4,2) +' ';

{5 N x P}   str := str +fRmrkt0 (ArrRec[i].nP2,3,0) +'x' +fRmrkt0 (ArrRec[i].P2,1,0);
                if ArrRec[i].P2<10      then str := str +'  '  else
                if ArrRec[i].P2<100     then str := str +' '   else
                if ArrRec[i].P2>=999999 then str := str +fRmrkt0 (ArrRec[i].P2/1000,1,0);  str := str +'  ';
{6 cos}     str := str +fRmrkt0 (ArrRec[i].Cos2,4,2) +' ';

{5 N x P}   str := str +fRmrkt0 (ArrRec[i].nP3,3,0) +'x' +fRmrkt0 (ArrRec[i].P3,1,0);
                if ArrRec[i].P3<10      then str := str +'  '  else
                if ArrRec[i].P3<100     then str := str +' '   else
                if ArrRec[i].P3>=999999 then str := str +fRmrkt0 (ArrRec[i].P3/1000,1,0);  str := str +'  ';
{6 cos}     str := str +fRmrkt0 (ArrRec[i].Cos3,4,2) +'  ';

{7 AsT}     str := str +ArrRec[i].AsT +' ';
{8 Krj}     str := str +fRmrkt0 (ArrRec[i].Krj,5,2) +' ';
{9 SUL}     str := str +fRmrkt0 (ArrRec[i].Sul,3,0) +'  ';
{10 SulTyp} if ArrRec[i].Iec  then str := str +'i '  else str := str +'F ';

{11 mm2}    if ArrRec[i].mm2<3   then str := str +fRmrkt0 (ArrRec[i].mm2,3,1) +' '
                                 else str := str +fRmrkt0 (ArrRec[i].mm2,3,0) +' ';

{12 Tyyppi} str := str +ArrRec[i].KaTyp +' ';
               if Length (ArrRec[i].KaTyp)<4  then str := str +' ';
               if Length (ArrRec[i].KaTyp)<5  then str := str +' ';
               if Length (ArrRec[i].KaTyp)<6  then str := str +' ';
               if Length (ArrRec[i].KaTyp)<7  then str := str +' ';
               if Length (ArrRec[i].KaTyp)<8  then str := str +' ';
{13 Pit}    str := str +fRmrkt0 (ArrRec[i].Pit,4,1) +' '; //< AMCMK3½½ = 8 mrk

{14 Yvs/OiS}if PRO_Demo
            then str := str +'Xxx/Xxx '
            else begin
               ii := fAnnaSulTap (i);
               if ArrRec[i].Iec  then su := su_IECg  else su := su_OFAg;
               ai := OikSuoj (su, ArrRec[i].KaTyp,ArrRec[i].mm2,1{Kpl});

               su := fImrkt0 (ii,1);             //<ii=YvSuoja
               for j := Length (su)+1 to 3  do   //Kentän alkuosalle varattu 3 mrkiä
                  su := ' ' +su;                 //<Tehdään väliä eteen.
               if (ii=0) or (ii<ArrRec[i].Sul)   //<,Ristiriita: Ilmoitettu sulake isompi kuin sallittu
                  then su := CLR_REB +su +FNT_B0;
               su := su +'/';

               sa := fImrkt0 (ai,1);             //<ai=OikSuoja
               k := Length (sa);
               for j := k+1 to 3  do             //<Jälkimmäiselle osallekin varattu 3 mrkiä
                  sa := sa +' ';

               if (ai=0) or (ai<ArrRec[i].Sul)   //<,Ristiriita: Ilmoitettu sulake isompi kuin sallittu
                  then sa := CLR_REB +sa +FNT_B0;

               su := su +sa;
            str := str +su +' ';                 //<Lopuks lisätään varsinaisen STR:n jatkoksi.
            end;//if Demo else
            //========== Yht ao. rivi: ===========================================================================
               //function fUkChk (os :integer;  VAR Uk,PEpit,palSul :real) :integer;//=111...422 //:string; (=oli alunperin)
                     //Palauttaa: XZN:  X: 1=PT kohdalla   2=PTedellä   3=PTjäljssä   4=PTtäEiooEdv:ssä 100..400
                     //                  Z: 1=Uk<=50(75)    2=Uk>50(75)                                  110..420
                     //                   N: 1=SULok         2=SUL liian iso                              111..422
{15 SEH}    if PRO_Demo
            then str := str +' Xxx '
            else begin
               ii := fUkChk (i, ar{Uk},rr{PEpit},aa{palSul}); //<Uk :ta ei toistaiseksi käytössä: Tieto käytetään PALUUarvosta -Z- :sta
                  //if rv=42  then aa := 160;
               su := fRmrkt0 (aa,1,0);              //<Tilaa MaxSulake -arvolle on 4 mrk, esim. "<250"
               j := Length (su);                    //< j = SU:n mrkLkm
               sa := '';   sb := '';
                  //if (Pyor (ArrRec[i].Sul) > Pyor (aa)) or (rv=42)
               if Pyor (ArrRec[i].Sul) > Pyor (aa)
               then begin
                  sa := CLR_REB;
                  sb := FNT_B0;
                  su := FONT_PIENPI +su;            //<Liitetään valmiiksi PienpiYhtäKun -mrk m/v -tulostusta varten.
                  k := 4 -j -1;  end                //< -1 = PienpiYhtäsuuri.. -mrkn ottama tila = 1 mrk.
               else
                  k := 4 -j;

               for j := 1 to k  do
                  su := ' ' +su;                    //<Lisätään alkuun tyhjiä =Oikea suora.
               str := str +sa +su +sb +' ';         //<''''''''''''''''MaxSul -tulostusta'''''''''''''''''''''''''

             //str := str +fRmrkt0 (ii,3,0) +' ';

                  sa := CLR_REB;
                  sb := FNT_B0;                     //,function fArv3 (sar,koodi :integer) :integer;
               if fArv3 (2,ii)=2                    //<,Uk>50(75)
                  then str := str +sa + 'U' +sb
                  else str := str +'-';
               if NOT ArrRec[i].KUL and (rr>200)    //< PEpit>200m =SÄL´n 2. nollausehto ei täyty
                  then str := str +sa + '2' +sb     //'200m on laskettu piennemmän impedanssin mukaan kahdesta:
                  else str := str +'-';             // edellä verkossa (PEpit1) vs. jäljessä vrkssa (PEpit2).

                       {str := str +sa + 'U' +sb;   //<Kokeilua
                        str := str +sa + '2' +sb;}

               str := str +' ';
            end;//if Demo else

{16 I1/...}    yp := 0;   yq := 0;              //<,,Näihin lasketaa kumulatiivinen summa, joista lasketaan uh%
               for j := i to vikaOs  do begin   //<,,Summavirrat: Lasketaan tämän + loppujen pisteiden summaP,Q.
                  pr := ArrRec[j].nP1 * ArrRec[j].P1; //<P1 [W] ==================================================
                  yp := yp +pr;
                  if (pr>0) and (ArrRec[j].Cos1>0)
                     then yq := yq +pr *Sqrt (1/Sqr(ArrRec[j].Cos1));  //< Q = P V¨(1/cos²)
               end;//for j
                //ir := PYht / (fUv * ArrRec[j].Cos1);                 //< I = P / (Uv * Cos)
               ir := Sqrt (Sqr(yp) + Sqr(yq));                     //< L1:n kokonais S (näennäisteho pisteessä i).
               ir := ir / fUv;                                     //< I = S / Uv
               p1 := yp;   q1 := yq;
            str := str +fRmrkt0 (ir,1,1) +'<b>/</b>';              //< I1/I2/I3 -sarake

               yp := 0;   yq := 0;              //<,,Näihin lasketaa kumulatiivinen summa, joista lasketaan uh%
               for j := i to vikaOs  do begin   //<,,Summavirrat: Lasketaan tämän + loppujen pisteiden summaP,Q.
                  pr := ArrRec[j].nP2 * ArrRec[j].P2; //<P2 [W] ==================================================
                  yp := yp +pr;
                  if (pr>0) and (ArrRec[j].Cos2>0)
                     then yq := yq +pr *Sqrt (1/Sqr(ArrRec[j].Cos2));  //< Q = P V¨(1/cos²)
               end;//for j
               ir := Sqrt (Sqr(yp) + Sqr(yq));                     //< L2:n kokonais S (näennäisteho pisteessä i).
               ir := ir / fUv;                                     //< I = S / Uv
               p2 := yp;   q2 := yq;
            str := str +fRmrkt0 (ir,1,1) +'<b>/</b>';

               yp := 0;   yq := 0;              //<,,Näihin lasketaa kumulatiivinen summa, joista lasketaan uh%
               for j := i to vikaOs  do begin   //<,,Summavirrat: Lasketaan tämän + loppujen pisteiden summaP,Q.
                  pr := ArrRec[j].nP3 * ArrRec[j].P3; //<P3 [W] ==================================================
                  yp := yp +pr;
                  if (pr>0) and (ArrRec[j].Cos3>0)
                     then yq := yq +pr *Sqrt (1/Sqr(ArrRec[j].Cos3));  //< Q = P V¨(1/cos²)
               end;//for j
               ir := Sqrt (Sqr(yp) + Sqr(yq));                     //< L3:n kokonais S (näennäisteho pisteessä i).
               ir := ir / fUv;                                     //< I = S / Uv
               p3 := yp;   q3 := yq;
            str := str +fRmrkt0 (ir,1,1);
            //--------------------------------------------------------------------------------------
            pp := p1+p2+p3;   qq := q1+q2+q3;         //<Kumulatiivinen summaP ja -Q kaikista vaiheista.

            ZRv := res (ArrRec[i].KaTyp, ArrRec[i].mm2) *ArrRec[i].Pit;
            ZRv := rTkorj ( fAlCu (ArrRec[i].KaTyp), ZRv, Pyor (ArrRec[i].LT) );
            ZXv := Xv_ind (        ArrRec[i].KaTyp , ArrRec[i].mm2 ) *ArrRec[i].Pit;

            uhn := uhn +( ZRv*pp + ZXv*qq ) *fV_U_k;       //< uh% := fV_U_k * (RP + XQ)
          //uhn := uhn +Guha;                              //<Lisätään alkupisteen uh%.

            str := str +' <b>=</b>' +fRmrkt0 (pp/1000,1,2) +' ' + //< =Pyht
                   'uhY%=';
            if PRO_Demo
            then str := str +'Xxx '
            else str := str +fRmrkt0 (uhn,1,2) +' ';              //< =uhTot%

                   //str := str +' L=' +fRmrkt0 (rr,1,1);
            NjTulFrm.aRich.AddText (str +'<br>');
         end;//for i
         //---------------------------- Liittymäpisteen arvot --------------------------------------
         p1 := 0;  p2 := 0;  p3 := 0;   //<,Näihin lasketaa kumulatiivinen summa.
       //q1 := 0;  q2 := 0;  q3 := 0;
         for i := 0 to vikaOs  do begin                    //<,,Lasketaan P ja Q -summat vaiheittain koko ketjussa.
            rr := (ArrRec[i].nP1 * ArrRec[i].P1);
            p1 := p1 +rr;
           {if ArrRec[i].Cos1>0  then
               q1 := q1 +rr *Sqrt (1/Sqr(ArrRec[i].Cos1)); //< Q = P V¨(1/cos²)}

            rr := (ArrRec[i].nP2 * ArrRec[i].P2);
            p2 := p2 +rr;
           {if ArrRec[i].Cos2>0  then
               q2 := q2 +rr *Sqrt (1/Sqr(ArrRec[i].Cos2)); //< Q = P V¨(1/cos²)}

            rr := (ArrRec[i].nP3 * ArrRec[i].P3);
            p3 := p3 +rr;
           {if ArrRec[i].Cos3>0  then
               q3 := q3 +rr *Sqrt (1/Sqr(ArrRec[i].Cos3)); //< Q = P V¨(1/cos²)}
         end;

         str := 'Kokonaistehot vaiheittain verkon alussa [kW]: P1=' +fRmrkt0 (p1/1000,1,2) +
                '  P2=' +fRmrkt0 (p2/1000,1,2) +'  P3=' +fRmrkt0 (p3/1000,1,2) +
                '  TOT=' +fRmrkt0 ((p1+p2+p3)/1000,1,2) +' kW';

         NjTulFrm.aRich.AddText (str +'<br>');
       //NjTulFrm.aRich.Font.Name := 'Courier New'; //<Jättää bold´it vex 1.krlla. NYT OK = Ks. ALKU =<f n="Courier New">
      end;//Nayta

      procedure RvIherja (ss :string);      begin
         Iherja ('Rivi: '+IntToStr (rv) +'   '+ss);  end;
      procedure RvEherja (ss :string);      begin
         Eherja ('Rivi: '+IntToStr (rv) +'   '+ss);  end;

      function LukuArvoja (ss :string) :Integer;      VAR rr :real;  ii,ui :integer;      begin //10.0.4
                                     //FNC= Montako lukuarvoa SS:ssä vielä on, esim. "0 0.0  =Liittymäpiste.." = 2
         ss := Trim (ss);            //     ja sitä ennen on ollut RivNo "0 " eli: "0 0 0.0  =Liittymäpiste.." = 3
         ui := 0;
         if SokI (ss,ii)  or SokR (ss,rr)  then
         while (ss<>'') and (CharInSet(ss[1], ['0'..'9',',','.'])) and
               SokI (ss,ii)  or SokR (ss,rr)  do begin
            ui := ui +1;
            while (ss<>'') and (CharInSet(ss[1], ['0'..'9',',','.']))  do
               Delete (ss,1,1);
            ss := Trim (ss);
         end;//while
         Result := ui;
      end;//LukuArvoja

   BEGIN//LueSijFile::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

   rv := 0;  alpS := '';   onOK := true;   LueEka := true;         //<LueEka = Liittymätietorivin luku.
   while NOT Eof (KatuFile) and onOK   do begin
      rv := rv+1;
      Readln (KatuFile, sorc);                                     //<Luetaan riveittäin ja tutkitaan se sa-
                                                                   // rakkeittain.
      sorc := Trim (sorc);                                         //<Poistetaan alku- + lopputyhjät
      aos := 0;
      if (sorc<>'') and (CharInSet(sorc[1], ['0'..'9']))  then begin   //<Tutkitaan vain rivit, jotka alkavat NUMEROLLA.
         lukuja := LukuArvoja (sorc);                         //<+10.0.4:  Rv alussa olevien arvjn lkm ennen selitystä.
         alpS := sorc;                                        //<Talteen tukittavaksi onko mahd. filessä kamaa
         if LueEka
         then REPEAT
            aos := aos +1;             //,-10.0.4: LueEkaArvoDel otti ekan lukuarvon ja delasi sen sorc:sta.
            s := sorc;                 //,,+10.0.4: EdVersioissa oli vain LiitPiste +aUh, esim: "0 0 =Liittymäpiste  Alku-uh%"
            case aos of //01 2 i       //  Nyt voi tiedoston rv olla muotoa "0 0 0 =RivNo Liittymäpiste  Alku-uh%".
               1 :begin                //  Eka RivNo on AINA 0, editoidaan 0:ksi riippumatta filen 1.:stä luvusta.
                     if lukuja>=3  then
                        s := LueEkaArvoDel (sorc);            //<'Jos lukuja >= 3, on eka riviNo, joka ohitetaan.
                     s := LueEkaArvoDel (sorc);               //<Vasta seur. arvo sijoitetaan, ed. S ohitetaan.
                     if (s<>'') and (s[1]='0')                //<Otetaan seur.luku SORC:sta, loput palautuu takas.
                     then GliitNo := 0
                     else if (s<>'') and (s[1]='-')
                     then begin onOK := false;
                                RvEherja ('<0 -luvut eivät ole sallittuja.');  end
                     else if NOT SokI (s,GliitNo)
                     then begin onOK := false;
                                RvEherja ('Virheellinen arvo [' +s +'] liittymäpisteen numeroksi.');  end;  end;
               2 :fRea (s, Guha, 'Alkujännitealenema');
            end;//case
            if aos=3  then aos := 0;     //<,Lopettaa ekaRivin käsittelyn.  aos=2 => 3 =10.0.4
            LueEka := false;
         UNTIL aos=0 //ifLueEka
         else begin
            REPEAT
               aos := aos +1;
               sorc := Trim (sorc);
               s := '';                                 //,PITUUS -sarake on VARMASTI OK, aloitetaan siitä ja
               case aos  of                             //,luetaan rivin yksi tekijä rivin. Delaa samalla SORCen
                  1, 2      :s := LueLopustaDel (sorc); //<,,merkkejä. Näiden 2:n jälkeen vain alkusarak.jäljellä.
                  3..aosMax :s := LueEkaArvoDel (sorc);  end; //<Siirrytään lukemaan rivin alusta.

               if s<>''  then //TYPE RecTyp = RECORD Rno,uha, nP1,P1,Cos1, nP2,P2,Cos2, nP3,P3,Cos3, LT,Krj,mm2,Pit :real;
               case aos  of   //                     Tun,AsT,KaTyp :String;  KUL :boolean;  END;
                  1 :fRea (s, rec.Pit, 'Pituus'); //<,Aloitettiin 2:sta vikasta sarakkeesta:  S => rec.Arvo
                  2 :begin
                     fStr (s, rec.KaTyp);  s := rec.KaTyp; //<KaTyp jää alkuperäiseksi
                     if NOT typOK (0,s)  then              //<s :ään palautuu oikeamuotoinen KaTyp
                     if rec.Katyp='AMCMK'  then rec.Katyp := 'AMCMK4½'  else
                     if rec.Katyp= 'MCMK'  then rec.Katyp :=  'MCMK4½'  else
                        FarvoEiOK ('Kaapelityyppi');  end;
                  3 :fRea (s, rec.Rno, 'Rivinumero');      //<,,Siirryttiin lukemaan rivin alusta,,,,,,,,,,,,,,,,,
                  4 :fStr (s, rec.Tun);
                  5 :fRea (s, rec.LT,         'Lämpötila');
                  6 :fBoo (s, rec.KUL,        'Suoj.ehtojen tarkastelutapa');
                  7 :fS_R (s, rec.nP1,rec.P1, 'L1-vaiheen kuormitustiedot');
                  8 :fRea (s, rec.Cos1,       'L1-vaiheen tehokerooin');
                  9 :fS_R (s, rec.nP2,rec.P2, 'L2-vaiheen kuormitustiedot');
                 10 :fRea (s, rec.Cos2,       'L2-vaiheen tehokerooin');
                 11 :fS_R (s, rec.nP3,rec.P3, 'L3-vaiheen kuormitustiedot');
                 12 :fRea (s, rec.Cos3,       'L3-vaiheen tehokerooin');
                 13 :begin
                     fStr (s, rec.AsT);   rec.AsT := AnsiUpperCase (Trim (rec.AsT));
                     if (rec.AsT<>'') and NOT (CharInSet(rec.AsT[1], ['A','C','D']))
                        then RvEherja (' Asennustapa pitää olla ''A'', ''C'' tai ''D''.');
                     if rec.AsT='D'  then rec.AsT := 'd';  end; //<Erottuu paremmin C:stä kuin iso D.
                 14 :fRea (s, rec.Krj,        'Korjauskerroin');
                 15 :fRea (s, rec.Sul,        'Sulake');
                 16 :begin
                     fStr (s, sa);   sa := AnsiUpperCase (sa);
                     if sa[1] = 'I'  then rec.Iec := true   else
                     if sa[1] = 'F'  then rec.Iec := false  else
                                     RvIherja ('Rivi '+IntToStr (rv) +' Virheellinen sulaketyyppimerkki [' +sa +
                                               '], muutetaan IEC:ksi (i).');  end;
                 17 :fRea (s, rec.mm2,        'Johdinpoikkipinta');
              else onOK := false;   end;
            UNTIL  NOT onOK or (sorc='');

            if NOT onOK  then
            if aos>aosMax
            then RvEherja ('Tiedostossa '''+KatuPolkuFilen+''' liikaa sarakkeita (max=' +IntToStr (aosMax) +
                           ',   Rivi: '+fImrkt0 (rv,1) +'  Sarakkeita: ' +IntToStr (aos) +'. Tarkista '+
                           'ettei Tehosarakkeissa ole välilyöntejä sarakkeen sisällä.')
            else if aos<aosMax
            then RvEherja ('Tiedostossa '''+KatuPolkuFilen+''' liian vähän sarakkeita (ja arvoja p.o.=' +
                           IntToStr (aosMax) +',   Rivi: '+fImrkt0 (rv,1) +'  Sarakkeita: ' +IntToStr (aos) +'.');

            if onOK  then begin
               k := Length (ArrRec);
               k := k+1;
               SetLength (ArrRec,k);
               ArrRec[k-1] := rec;
            end;
         end;//
      end;//if sorc<>..[1] IN [] ELSE
   end;//while NOT Eof()
      if onOK  then Nayta;
      if alpS=''  then //if (rv=1) and Eof (KatuFile)  then     //alpS='' =Filessä ei ole ollutkaan mitään.
         Eherja ('Tiedosto tyhjä tai virheellinen, ei laskettavaa.');
   end;//LueSijFile
   //...............................................................................................
   function fRegistryKEYnimi :string;      begin result := 'LastStreet';  end;

BEGIN//LueLaskeKatuval :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
NjTulFrm.Hide;
{if LisYliDemo_ (lvLT)     //<,Tätä ei enää tarvita, sorcassa nyt: IF PRO_Demo  THEN 'Xxx' ELSE ...
then Iherja ('Katuvalojohtojen laskenta ei sisälly LT-laajuuteen, sulje tulostusikkuna ja valitse uudelleen.')}
hs := '';
   LisYliDemo_Info (lvPRO);
   NjTulFrm.Caption := PROGRAM_VERSIO_STRING +':  Katuvalojohtojen laskenta.';
 //KatuPolkuFilen := myRegSettings.GetStringValue (Settings_Used, fRegistryKEYnimi); //<Luetaan rekisterisä  -130.0
 //KatuPolkuFilen := 'E:\Projektit\NolaKehi\Bin\Data\Katu.TXT';
                                                        //KatuFilen := 'Katu.TXT';
                                                        //KatuPolku := 'E:\Projektit\NolaKehi\Bin\;
                                                        //KatuPolku := 'E:\Projektit\NolaKehi\Bin\Data\Katu.TXT';
 //if KatuPolkuFilen=''  then
    //KatuPolkuFilen := fHaePolkuFilen (DATA_PATH_ID) +'\Katuvalo\Katu.TXT';  //<fHae.. siirrtty Y_.PAS´siin 12.0.05
      KatuPolkuFilen := gAjoConfPath +'Katuvalo\Katu.TXT';                    //<+130.0
   NjTulFrm.OpenDlg1.FileName := KatuPolkuFilen;
   NjTulFrm.OpenDlg1.Options := [ofHideReadOnly,ofOverwritePrompt,ofPathMustExist, ofFileMustExist,
                                 ofNoReadOnlyReturn,ofEnableSizing];
   NjTulFrm.OpenDlg1.Title := 'Katuvalaistustiedosto: (' +KatuPolkuFilen +')';
   if NjTulFrm.OpenDlg1.Execute
   then begin
      KatuPolkuFilen := NjTulFrm.OpenDlg1.FileName;
   try
                               //¿DefsFileen('AssgnFile 8');
         AssignFile (KatuFile, KatuPolkuFilen);
         Reset (KatuFile);
         LueSijFile;
         CloseFile (KatuFile);                                                        //,Kirjoitetaan rekisteriin.
         myRegSettings.SetStringValue (Settings_Used, fRegistryKEYnimi, KatuPolkuFilen); //<Palauttaa FALSE josEi onaa
        {NjTulFrm.Width := NjTulFrm.Width -1;
         NjTulFrm.Width := NjTulFrm.Width +1;}
      except
         on E:Exception  do CloseFile (KatuFile);
      end;//try
   end else//if OpenDlg1.
   begin                                                //,HS<>'' ilmaisee vain, että tiedosto OpenGlg on peruttu.
      hs := 'Tiedostoa ei ole valittu, sulje avautuva tulostusikkuna ja valitse uudelleen.';
      NjTulAuki := false;                                                                        //<+10.0.4
   end;
//end;//if NOT LisYliDemo_()
if hs=''  then                //<,HS´ää ei enää tarvita, nyt vain ohitetaan seur show.
   NjTulFrm.Show;                                                                            //,10.0.4  2.Show vex.
//KatuVal := false;
END;//LueLaskeKatuval



