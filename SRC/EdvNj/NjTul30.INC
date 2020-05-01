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
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NjTul30.INC }
{Häviökustannuslaskentaan liittyvät asiat kommentoitu vex:  H@ ...
 NjTul30.INC, 31.INC, 31.INC, 37.INC, 38.INC INCLUUDATTU NjTul3.PAS :ssa
----------------------------------------------------------------------------------------------------
//DOS -versiossa:  LAR=TRUE jos Hvrt..>tulKierrs. PRCn Tulostakesk lopussa := TRUE + GOTO alkuun
if kesja>1 then begin
   kesja := kesja+1;   beep;   kesja := kesja-1;  end;
===================================================================================================}
FUNCTION fTuh :Integer;    //<Palauttaa JOHDINLT:n uh%- ja haviokusLaskentaan
   VAR Tsal,Ty,            //IDEA: Koska jatkuvtilassa T on suor verrannollin
       Tapu,Tj :Integer;   //      virran neliöön, jajos YvSuoj rajoittaa LTn
       YVkat   :Real;      //      maxArvoon, 1Neh rajoittaa sen alemmaksi !!
     //OikSul :integer;    //Arvo pätee vain PVC-kaaplle.### ks.KOE_LT.PAS###
                           //     ks. myos NOLA (47) / USER2 !!!!!!!!!!!
                           //Vois olla eri arvo SVjärjestlle + avojohdlle ???
BEGIN                      //Sekä KUL että SÄL nj:lle<<<<<<<<<<<<<<<<<<<<<<<<
   Ty := 25;    //YVkat := 0;    //<Ilmeisesti OK vaikkaKORJlla Ty muutettu??
   IF a_getStrg (30016, nj.jy.Astapa)='D'   THEN Ty := 15;
 //IF SamIso (NJtyp,'SVjärjest.') or SamIso (NJtyp,'AXCMK') or SamIso (NJtyp,'AXMK') //< -6.0.2
   IF fOnSV (NJtyp) or SamIso (NJtyp,'AXCMK') or SamIso (NJtyp,'AXMK')               //< +6.0.2
   THEN IF njmm2>=2400  THEN Tsal := 90     //<SVj :lla Tsal isompi<<<<<<<<<<
                        ELSE Tsal := 90
   ELSE                      Tsal := 70;
   Tj := a_getIntg (30017, nj.jy.Tk1v);        //<Syötetty arvo!!<<<<<<><<<<<

   //OikSul := OikSuoj (NJtyp,NJmm2,NJkaapx);
   IF (NJsul>0) AND (YVsul>0)    //,YVsul(ainaKyllkin>0) =Johdon Isal * äKorj
   THEN Tapu := pyor (Sqr (NJsul/YVsul) *(Tsal-Ty) +Ty)      //<ks.KOE_LT.PAS
   ELSE BEGIN        //samaS,Katk ,
      YVkat := YvSuoj ({'G'}suCse,FALSE,TRUE ,a_getStrg (30118, nj.jy.Astapa),a_getReaa (30019,nj.jy.Korjaus),
                       NJtyp,NJmm2,NJkaapx);
      IF (NJkat>0) AND (YVkat>0)
         THEN Tapu := pyor (Sqr (NJkat/YVkat) *(Tsal-Ty) +Ty)
         ELSE Tapu := Tj;
   END;
                                             //,Jos ed. laskenta olikin KAS-
   IF Tsal<Tapu  THEN Tapu := Tsal;          //<VATTANUT eikäPIENENTÄNYT Tapu
   IF Tj  <Tapu  {AND (edka^[4].Ivks>0.1)}          //<SÄL & syötetty pienpi.
                 THEN Tapu := Tj;                   //'Sittenkin myös KUL!!!!
   IF a_getBool (30119, nj.jy.NjKulSal)
      THEN BEGIN IF Tapu<25  THEN Tapu := 25; END   //<Ettei mene tolkuttoman
      ELSE       IF Tapu<50  THEN Tapu := 50;       //pieneksi,vrt.mahdAlkuLT
Result := Tapu;
END;//fTuh
//==================================================================================================
{$I ..\EdvNj\NjXpe.INC} //<+7.0.4
//==================================================================================================
                               //Hvrt:           0=EiHuomHäviöitä       1=Huomioidaan häviöt
                               //DOS-versiossa:  0=EiHuomHäviöitä       1=Tiivis (1:nä arvona)
                               //                2=Eritellen(1r)     >=10=DetTietoja <<<<<<<<<
                           //,,ve2 = 1=Lasketaan 1.ve:n jatkoksi 2.ve (ed.oli esim. AMCMK, nyt AXMK)
                           //,,Jos st1<>'' -> stv='='. Kutsussa riittää testi:  if sa<>'' <<<<<<<<<<
                           //,,st1 = 'MCMK'/'AMCMK' tms.   stv = '='/''   st2 = 'XX.xx €' <<<<<<<<<<
PROCEDURE laskeTulHinta (ve2 :integer);
                    //'Käsittelee vain MCMK, AMCMK, AXMK ja SVj kaapeleita as.menetelmillä OH + KHME
                      //'Lasketaan 2 ve :a (jos on):  AMCMK + AXMK  (Cu :lla on vain 1). Tiedot pai-
                      //'kallisiin muuttujiin (MrkA,MrkB) ja TULOSTETAAN VASTA LOPUSSA (koska muuten
                      //'ei voida vrtlua suorittaa ja NÄYTTÖÄ OHJATA HALVEMMAN mukaan <<<<<<<<<<<<<<
                      //- Hinnoista tutkitaan toteutuneet vaihtoehdot <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
VAR yhtL :real;  Jryh :integer;
   qTpit,qKorko,qHprs,qdPprs,qdWmkprs,
   A,B,G, apu1Y,apu1A,apu2Y,apu2A,Ih,AlCuX, //<Ih=Ihuippukuorm 1.vuonna
   cosH,Pj1,PjV,Disk  :Real;
   dTsal :Integer;
{kahitau [mm2os].MCMK   .nimi  .laji  .jLkm  .OH  .KH  .KHME
                .AMCMK  .nimi  .laji  .jLkm  .OH  .KH  .KHME
                .AXMK   .nimi  .laji  .jLkm  .OH  .KH  .KHME
                .SVjarj .nimi  .laji  .jLkm  .OH  .KH  .KHME
                 '''''=Htietue,   mm2os:  NJmm2= 1.5->aoOs=1   2.5->2   4->3  6mm2->5 jne. =f(NJmm2)
       Esim: KaapNimike := JAtietue.Nimi ##########################################################}
//...........................................................................
   function fJtietue (nimiRyh :integer;  Qmm2 :real) :aslaji;      begin
      case nimiRyh of
         1 :Result := kahitau [ mm2i (Qmm2) ].MCMK;
         2 :Result := kahitau [ mm2i (Qmm2) ].AMCMK;
         3 :Result := kahitau [ mm2i (Qmm2) ].AXMK;
      else  Result := kahitau [ mm2i (Qmm2) ].SVjarj;  end;//case
   end;//fAOtietue
   //-----------------------------------------------------------------------------------------------
   function hinta (MkTietue :aslaji) :real;      VAR  y :integer;      BEGIN
      yhtL := 0;
      FOR y := 1 TO kesja  DO WITH nj.jk[y] DO yhtL := yhtL + a_getReaa (30027, dL);

      WITH MkTietue DO  IF yhtL >= 3   THEN Result := ( 3*KHME + (yhtL-3)*OH ) * NJkaapx
                                       ELSE Result := yhtL*KHME*NJkaapx;
   END;//hinta
   //-----------------------------------------------------------------------------------------------
(* PROCEDURE tul_1_3_1;            BEGIN
     {IF Hvrt IN [12..15]  THEN WITH hav2 DO  BEGIN
         WRITELN ('Ý=== ' +fRmrkt0 (res (kalaji,katyp,njmm2) *1000,1,3) +'ê/v/km  '+
                  fRmrkt0 (qTpit,1,1) +'a/' +fRmrkt0 (qKorko,1,2) +'%  Kdisk=>' +fRmrkt0 (Disk,1,3) +
                  '   1Y/A=' +fRmrkt0 (apu1A,1,6) +'  2Y/A=' +fRmrkt0 (apu2A,1,6);
         WRITELN ('Ý===   1Y       1A       2Y       2A       1-1Y      1-',
                  '1A      1-2Y      1-2A');
         WRITELN ('Ý   ' +fRmrkt0 (apu1Y,1,5) +fRmrkt0 (apu1A,9,5) +fRmrkt0 (apu2Y,9,5) +fRmrkt0 (apu2A,9,5) +
                  fRmrkt0 (1-apu1Y,9,5) +fRmrkt0 (1-apu1A,10,5) +fRmrkt0 (1-apu2Y,10,5) +fRmrkt0 (1-apu2A,10,5));
         WRITELN ('Ý=== kW     A    ->A    cos   snt/',
                  'kWh   h/a Isal[A] dL*mê/1v äHäv[€]');   END;}
   END;//tul_1_3_1*)
   //...............................................................................................
      {  A^4 = A potsiin 4 = Exp (4*Ln (A))
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                     ,,,,,,,,,,=apu1Y
                                                             1- (B²*G/A)^T
        haviomk = 3 *HävHuipKäyAika *HävEnrgKesHinta *R20 *[ ------------- *
                                                             1- (B²*G/A)
                                                   1- (B^4 *G/A)^T
                 Ih² + (rTkorjR20/Isall²) *dTsall *--------------- *Ih^4 ]
   ............................................... 1- (B^4 *G/A) ...................................
                                                      ''''''''''=apu2A<<<<<<<<}
   function fHaviomk :real;      VAR i :integer;  ar,haviomk :real;      begin

      haviomk := 0;
      WITH nj.Hav  DO  BEGIN
         IF fAlCu (NJtyp)  THEN AlCuX := 0.00403       //<Näin, koska rTkorj :n kut
                           ELSE AlCuX := 0.00393;      //sussa tarvittaisiin R <<<<
         A := 1 + (qKorko /100);                       //<A=laskentakorkotekijä<<<<
         B := 1 + (qdPprs /100);                       //<B=kuorm.virrankasvutek./a
         G := 1 + (qdWmkprs/100);                      //<G=sähkönReaalihinn-"- ./a
         apu1A := Sqr(B)      *G/A;        apu1Y := Exp (qTpit*Ln(apu1A));
         apu2A := Sqr(Sqr(B)) *G/A;        apu2Y := Exp (qTpit*Ln(apu2A));
         if (1-apu1A<>0) and (1-apu2A<>0)                          //<Vois tietenkin tutkia ja sijoittaa erikseen
            then begin  apu1A := (1-apu1Y) / (1-apu1A);
                        apu2A := (1-apu2Y) / (1-apu2A);  end
            else begin  apu1A := 0;
                        apu2A := 0;  end;
//    {Û}tul_1_3_1;
         IF a_getStrg (30021,nj.jy.astapa)='D'  THEN dTsal := fTuh-15
                                                ELSE dTsal := fTuh-25;
         FOR i := 1 TO kesja  DO BEGIN          //,,FOR = Huomioi JOHTO-OSIEN eriAIKAISET häviökustan/Tpit,,,,,,,
            Ih := Sqrt ( Sqr(Ptas[i]) + Sqr(Qtas[i]) ) *fKi/NJkaapx;                 //<Ih=Ihuippu ao.johto-osasa
            ar := rTkorj (fAlCu (NJtyp), res (NJtyp,NJmm2), fTuh) *                  //<Resist. fTuh oli 80
                  a_getReaa (30022,nj.jk[i].dL) *NJkaapx *3;                         //<ar = Rv/Kaap *KaapLkm *3
            Pj1 := Pj1 + ar *Sqr (Ih);                                               //,=PjV häviöP VIKAvuonna
            PjV := PjV + ar *Sqr (Ih *fKertaSuor_Diskont (qTpit,qdPprs));            //< R*Iý*korolle

            cosH := Ptas[i] / Sqrt( Sqr(Ptas[i]) + Sqr(Qtas[i]) );                   //<cos=P/S
//Ei koskaan tähän (NolaWi),,,,,,,,,,,,,,,,,,,,,//,,JAUHIAINEN, s.26: Huomioi eriaikaiset häviöt ajalla Tpit,,,,,
            IF Hvrt IN [14,15] THEN             // =USER2 120alParametrlla      ,,/1000=Iý*R[VA]->kVA
               haviomk := haviomk + 3 *1287 *0.266 /1000 *                           //<1287h,26.6p/kWh
                          0.000253 *a_getReaa (30023, nj.jk[i].dL) *NJkaapx *        //<0.253mê/m,KaLkm
                          ( apu1A *Sqr(Ih) + (AlCuX/Sqr(218*0.85))                   //<218*.85=Isal 120al
                         *dTsal *apu2A *Sqr(Sqr(Ih)) )           //< dT oli 70 t.80   '=1375.80mk Ph=2x15kW cos.6
            ELSE
               haviomk := haviomk + 3 *fPHaika (TRUE,cosH) *fKESmk (TRUE,cosH) /1000 *
                          res (NJtyp,NJmm2) *a_getReaa (30024, nj.jk[i].dL) *NJkaapx *
                          ( apu1A *Sqr(Ih) + (AlCuX / Sqr(Isal (NJtyp,NJmm2,a_getStrg (30025, nj.jy.astapa))))
                          *dTsal *apu2A *Sqr(Sqr(Ih)) );         //<fTuh-25 oli 70 t.80
         END;//FOR
      END;//WITH
      result := haviomk;
   END;//fHaviomk
   //-----------------------------------------------------------------------------------------------
   function sMk (Xmrk :real) :string;      VAR s :string;      begin
      IF Xmrk>=100000000.0  then s := fKmark_PRO (0, Xmrk/1000000.0 ,1,2) +{' Mmk'}' €'   else
      IF Xmrk>=1000000.0    then s := fKmark_PRO (0, Xmrk/1000      ,1,0) +{' Kmk'}' €'   else
      IF Xmrk>=100000.0     then s := fKmark_PRO (0, Xmrk/1000      ,1,2) +{' Kmk'}' €'   else
                                 s := fKmark_PRO (0, Xmrk           ,1,0) +{' mk'} ' €';
      result := s;   end;
   //===============================================================================================
   procedure LasTulArvot;      VAR s1,s2, sei :string;  halpa :boolean;  Htietue :aslaji;  t :integer;
                                   invMk,huoMk,havMk, TOTmk, muuTOTprs,muuINVprs :real;
      //..............................................                   //'Htietueesta tarvit vain NIMI -kenttä
      function hintaVrtEd  (Xmrk :real) :boolean;     BEGIN //<Vertaa hintaa aikaisempiin, tarvittaessa
         Result := FALSE;                                   //'alkusijoittaa <<<<<<<<<<<<<<<<<<<<<<<
         IF (tuxV<=1) and (ve2=0)  THEN BEGIN  ALmrk := 0;   CUmrk := 0;  END;  //<AL/CUmrk=edAL/edCUve:n hinta

         IF Xmrk>0
         THEN BEGIN
            IF  njAL  AND   (Xmrk<ALmrk)  OR
                njCU  AND  ((Xmrk<CUmrk)  OR  (Xmrk<ALmrk))
                THEN {if njAL and (tuxV>ALve1) and (ALve1>0)  or  njCU and (tuxV>CUve1) and (CUve1>0)
                         then}Result := TRUE;               //'Ei ekan NJve :n 2.ve :lle (AXMK) <<<<
            IF njAL  //'VEX: Ei näytä tulevan muitakaan halvmpia, koska tulJärjs muutettu 1AL50 2AL25 tms.
            THEN BEGIN IF ALmrk=0  THEN ALmrk := Xmrk;      //EKA hinta muistiin <<<<<<<<<<<<<<<<<<<
                       if ALve1=0  then ALve1 := tuxV;  END
            ELSE begin IF CUmrk=0  THEN CUmrk := Xmrk;      //<'ALmrk+CUmrk globaaleja / NolaVAR.INC
                       if CUve1=0  then CUve1 := tuxV;  end;
         END;          //'Tässä ALve1 ja CUve1 sij. nyt turhia, niiden vaikutushan poistettiin juuri edllä
      END;//hintaVrtEd
   begin//LasTulArvot.................................
      s1 :='';    s2 := '';   PjV := 0;   Pj1 := 0;
      Htietue := fJtietue (Jryh,NJmm2);
      invMk := hinta (Htietue);
      Disk := fToistvSuor_Diskont (qTpit,qKorko);

      if (invMk=0) and (yhtL>0)
      then begin
         case Jryh of
            1 :sei := 'MCMK';
            2 :sei := 'AMCMK';
            3 :sei := 'AXMK';
         else  sei := 'SVjärj.';  end;//case
         ad3SF (1,'','',tab1 +'Ei hinnoiteltua '+sei +' -kaapelia');  end
      else begin
         huoMk := 0;      havMk := 0;
         muuTOTprs := 0;  muuINVprs := 0;
         if Hvrt>0
         then begin
              huoMk := invMk*qHprs/100;
              havMk := fHavioMk;
              TOTmk := (invMk + huoMk) *Disk +havMk;

              muuTOTprs := (huoMk*Disk +havMk) / TOTmk *100; //<Muiden kuin INVkustannust. osuus KOKON.kust :sta
              muuINVprs := (huoMk*Disk +havMk) / invMk *100; //<Muiden kuin INVkustannust. osuus alkuINVkust :sta
         end
         else TOTmk := invMk;

         halpa := hintaVrtEd (TOTmk);
         if halpa  then s1 := CLR_GRB    //< st1 ####### 1.String ##################################
                   else s1 := '<b>';     //< Muuten vain tavallinen Bold ###########################
         s1 := s1 +Htietue.Nimi;                                   //<Ainoa tarve Htietueelle (Nimi)
       //s1 := s1 +'AMCMK3½½';                                     //<TulKentän leveystestiin !!!!!!

         s2 := sMk (TOTmk);              //< st2 ####### 3.String ##################################
         s2 := s2 +FNT_B0 +tab1;             //< +tab1 siirtää ad3SF :llä selitys- +sisennystab :iin
         if Hvrt>0   then s2 := s2 +'<b>Kokon.</b>kustannukset:  '
                     else s2 := s2 +'Hinta asennettuna:   ';
         if yhtL>=3  then s2 := s2 +'3m KHME + '+fRmrkt0 (yhtL-3,1,1) +'m OH'
                     else s2 := s2 +fRmrkt0 (yhtL,1,1)+'m KHME';
         if Det3  then s2 := s2 +' (ei sis. lähtö-/haaroituskust. Hinta-asetukset: ks. ..\Nola\Config\KaaphinD.NOL)';
         IF halpa  THEN BEGIN                                   //'+6.2.21
            s2 := s2 +'.' +CLR_GRB;
            IF tuxV=1
            then begin
               s2 := s2 +'   Halvempi kuin edellinen ';
               IF njAL  THEN s2 := s2 +'Al -ve'
                        ELSE s2 := s2 +'Cu -ve';  end
            else begin
               s2 := s2 +'   Halvempi kuin edelliset ';
               IF njAL  THEN s2 := s2 +'Al -ve :t'
                        ELSE s2 := s2 +'Cu -ve :t';  end;
         END;
         s2 := s2 +FNT_B0 +'.';

         if Hvrt<=0
         then       ad3SF (1,s1,'=',s2)
         else  if Det1
         then begin
                       s2 := s2 +' ...';
                    ad3SF (1,s1,'=',s2);  end             //<Eka rivi:  'AMCMK 4½ = 4567 €  Kokon.kustann.+...
         else  if Det2
         then  begin    s2 := s2 +'  <b>Kust.erittely :</b>';
                    ad3SF (1,s1,'=',s2);                  //<Eka rivi:  'AMCMK 4½ = 4567 €  Kokon.kustann. Erit:
                       s2 := 'Diskont.invest = ' +sMk (invMk*Disk) +',  alkuinv = <b>' +sMk (invMk) +'</b>,  '+
                             'huolto = ' +sMk (huoMk*Disk) +',  huolAlku = ' +sMk (invMk*qHprs/100);
                       IF PjV>=1000  THEN s1 := fRmrkt0 (PjV/1000,1,2) +'k'   ELSE
                       if PjV>=10    then s1 := fRmrkt0 (PjV,1,0)             else s1 := fRmrkt0 (PjV,1,1);
                       s1 := '  HäviöPj = ' +s1 +'W,  ';
                       s2 := s2 +s1 +'Disk.häviökust '+sMk (havMk);
                    ad3SF (1,'','',s2);   end
{det3}   else  begin    s2 := s2 +'  <b>Kust.erittely :</b>';
                    ad3SF (1,s1,'=',s2);                  //<Eka rivi:  'AMCMK 4½ = 4567 €  Kokon.kustann. Erit:
                       s2 := sMk (invMk*Disk) +tab1 +'<b>Invest.</b>kustannusten diskontattu<b>[2]</b> '+
                             'nykyarvo, <b>alkuarvo = ' +sMk (invMk) +'</b> (hankintahinta),  Kdiskont = ' +
                             fRmrkt0 (Disk,1,5) +' (' +fRmrkt0(qKorko,1,2) +'% ' +fRmrkt0(qTpit, 1,1) +'a)';
                    ad3SF (1,'','',s2);
                       s2 := sMk (huoMk*Disk) +tab1 +'<b>Huolto</b>kustannusten diskontattu<b>[2]</b> '+
                             'nykyarvo, alkuarvo = ' +sMk (invMk*qHprs/100) +' (' +fRmrkt0 (qHprs,1,2) +
                             '%/inv/a), diskontt.tekijät ks. edellä';
                    ad3SF (1,'','',s2);
                          IF PjV>=1000  THEN s1 := fRmrkt0 (PjV/1000,1,2) +'k'   ELSE
                          if PjV>=10    then s1 := fRmrkt0 (PjV,1,0)             else s1 := fRmrkt0 (PjV,1,1);
                          s1 := s1 +'W';
                       s2 := sMk (havMk) +tab1 +'<b>Häviö</b>kustannusten diskontattu<b>[3]</b> nykyarvo, '+
                             'johtohäviöt Pj = ' +s1 +' pitoajan lopussa ';
                          IF Pj1>=1000  THEN s1 := fRmrkt0 (Pj1/1000,1,2) +'k'   ELSE
                          if Pj1>=10    then s1 := fRmrkt0 (Pj1,1,0)             else s1 := fRmrkt0 (Pj1,1,1);
                          s1 := '(' +s1 +'W alkuarvo)';
                       s2 := s2 +s1 +',  Keskihinta = ' +fRmrkt0 (fKESmk (TRUE,fKeskiNjCos)*100,1,2) +'snt/kWh,  ';
                             s1 := '';   if kesja>1  then s1 := 'Keski';   s1 := s1 +'Cos' +FONT_FII +' = ';
                       s2 := s2 +s1 +fRmrkt0 (fKeskiNjCos,1,3) +',  Häviöhuipun käyttöaika = '+
                             fRmrkt0 (1*fPHaika (TRUE,fKeskiNjCos),1,0) +'h/a.  '+
                             'Huipun kasvuennuste ks. tulosteen alussa.';
                    ad3SF (1,'','',s2);
                    if kesja>1  then
                    ad3SF (1,'','',tab1 +'     Häviökust.nykyarvo todellisuudessa laskettu ketjun johto-'+
                                   'osakohtaisilla, eriaikaisilla häviöillä (Pj) ja häviöhuipun käyttöajoilla, '+
                                   'Cos' +FONT_FII +' -arvot pysyvät samoina. Resistanssin dT :ssä huomioitu '+
                                   'suoj.ehtojen mahd. pienentämän suojan vaikutus.');
                             t := 0;  if muuTOTprs<50  then t := 1;   s1 := fRmrkt0 (muuTOTprs,1,t);
                       s2 := s1 +'/';
                             t := 0;  if muuINVprs<50  then t := 1;   s1 := fRmrkt0 (muuINVprs,1,t);
                       s2 := s2 +s1 +' %' +tab1 +'<b>Muiden</b> kuin invest.kustannusten (<b>=huolto+häviöt)'+
                             '</b> osuus KOKONAISkustannuksista / INVESToinnin alkuarvosta.';
                    ad3SF (1,'','',s2);
         end;
                                  {s2 := 'TTT:  Disk 5000 10a 6% (=36800) = ' +fRmrkt0 (5000 *fToistvSuor_Diskont
                                         (10,6),1,2) +'  Korko 1000 8a 5% = ' +fRmrkt0 (fToistvSuor_lop_arv
                                         (1000,8,5),1,2) +'  7a = ' +fRmrkt0 (fToistvSuor_lop_arv (1000,7,5),1,2);
                                   ad3SF (1,'','',s2);}
      end;//if invMk>0.. else
   end;//LasTulArvot
begin
{VAIHTOEHTO N:o 1 ¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨Al
         s1     sv      s2       +tab1  +...
	mm2	=	2 á 35 Al	Kaapelilukumäärä,  vaihe-mm² ja -materiaali.   Arvot AMCMK:n mukaan
	AMCMK4½	=	2.194 €	Hinta asennettuna:   3m KHME + 24.5m OH
	AXMKn	=	1.683 €	Hinta asennettuna:   3m KHME + 24.5m OH.   Halvempi kuin edellinen Al -ve}
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
                                   // Käydään läpi kaap.poikkipintoja (aa) kaapelittyyppikohtaisesti (ty).
//BEGIN//laskeTulHinta               // Poikkipinnan löydyttyä -> Lashinta, KaLa1/KaLa2 := ty (jotta tulostettaessa
                                   // tiedettäisiin laji, ellei oikea mm2. Eikaap := eikaap + 1 (jos oikea laji)
//kurkur := 0;
IF eiKahiFile
THEN ad3SF (1,'','','Kaapelihintatiedosto puuttuu !')
//ELSE  if (ve2=0)  or  (NJtyp<>'SVjärjest.') and NJlaji  //<SVj :lle ja MCMK :lle ei 2.ve :ta ##### -6.0.2
ELSE  if (ve2=0)  or  NOT fOnSV (NJtyp) and NJlaji        //<SVj :lle ja MCMK :lle ei 2.ve :ta ##### +6.0.2
THEN  with nj.Hav  do BEGIN
   qTpit :=  a_getReaa (30028,Tpit);      qHprs :=  a_getReaa (30028,Hprs);
   qKorko := a_getReaa (30028,Korko);     qdPprs :=   a_getReaa (30028,dPprs);
   qdPprs := a_getReaa (30028,dPprs);     qdWmkprs := a_getReaa (30028,dWmkprs);

   if ve2=0                                    //<####### Eka johtotyyppiVE ########################
   then begin                                        // ,,,,,,,Jryh = Kaapelin tyypin mukainen ryhmä
    //if NJtyp='SVjärjest.'  then Jryh := 4   else   //<SVjärjest.             'KAHITAUn Htietueessa -6.0.2
      if fOnSV (NJtyp)  then Jryh := 4   else        //<SVjärjest.             'KAHITAUn Htietueessa +6.0.2
      if NJlaji         then Jryh := 2   else        //<AMCMK, seur.krlla ve=1 -> Jryh := 3 = AXMK
                             Jryh := 1;  end         //<MCMK   = NOT NJlaji
   else                      Jryh := 3;        //<####### AXMK =JohtotyyppiVE AMCMK:lle ############
                   {aoOs := mm2i (NJmm2);}
   LasTulArvot;
END;//ELSE if ve2=0  then with
END;//laskeTulHinta
//==================================================================================================
//==================================================================================================
PROCEDURE tulostakesk;      LABEL 9{+7.0.3};
VAR i,j :Integer;   ar,rr,ra,YHTpSyo,YHTpVrt,kasv :Real;  //,<kasv =Kuorman kasvukerroin <<<<<<<<<<<
    sa,sv :string;         //<VARO esim. ss on käytössä jk[].ss yms. ja WITH jk[]:n jälkeen ONGELMIA
   //............................................
  {function fDes (r :real) :integer;      VAR i :integer;      begin
      if fMuokDes (r,0) >= 100  then i := 0   else
      if fMuokDes (r,1) >= 10   then i := 1   else i := 2;
      result := i;  end;}
   //............................................
   function Stoistv_nyk_arv (Kasvu :Real) :string;      VAR tim,disk,ar :Real;  s :string;      BEGIN
      tim :=  a_getReaa (30024,nj.Hav.Tpit);
      disk := fToistvSuor_Diskont (tim,Kasvu);
      ar := fToistvSuor_nyk_arv (Kasvu,Kasvu);
      s :=  tab1 +FONT_OIKEALLE +'   '+fRmrkt0{sRmrkt0vex} (ar,1,2{fDes(ar)}) +' %' +tab1 +
            '= Nykyarvo[2] '+FONT_VASEMMALLE +'  '+fRmrkt0 (Kasvu,1,2) +'% × '+
            fRmrkt0 (a_getReaa (30024,nj.Hav.Tpit),1,1) +'a'+
            ' =' +fRmrkt0 (disk,1,3) +'×';
      result := s;  end;
   //............................................
   function Slop_arv (prosArvo :integer;  Arvo,Kasvu :Real) :string;      VAR ar,tim :Real;  s :string;     BEGIN
                    //PROSARVO'=0 =FNC palauttaa arvona, ei prosentteina   >0 =Prosentteina
      ar := fKertaSuor_lop_arv (prosArvo, Arvo,Kasvu);
      s :=  tab1 +FONT_OIKEALLE +'   ';
         if prosArvo>0  then s := s +'+';
      s := s +fRmrkt0{sRmrkt0vex} (ar,1,1{fDes(ar)});
         if prosArvo>0  then s := s +' %';
         tim := a_getReaa (30024,nj.Hav.Tpit);
      s := s +tab1 +'= Loppuarvo[1] ' +FONT_VASEMMALLE +'  ' +fRmrkt0 (Kasvu,1,2) +'% × '+
           fRmrkt0 (tim,1,1) +'a';
      ar := fKertaSuor_Diskont (tim,Kasvu);
      s := s +' =' +fRmrkt0 (ar,1,3) +'×'; //<Lisäys 10.1.2000
      result := s;  end;
   //--------------------------------------------
   function isomp (s1,s2 :string) :string;     VAR i1,i2 :integer;  begin //Palauttaa (pix)pitemmän param:n
      i1 := fMrkPix (s1);   i2 := fMrkPix (s2);
      if i1>i2  then Result := s1  else Result := s2;   end;
   //............................................
   procedure sarakenimet (o :integer);       VAR s,sKesk :string;      begin
      sKesk := '';   if o>0  then sKesk := 'KESKUS';
      s := 'n:o '+tab1 +sKesk+tab1 +'dL ' +tab1 +'Ph '  +tab1 +'Qh ' +tab1  +'Sh '+tab1  +
           'Cos'+FONT_FII+tab1 +'Ih '+tab1 +' p '+tab1  +'Ala '+tab1 +'pVrt '+tab1 +'PotTas'{+'HävHka'};
      adStF (s);
      s :=       tab1       +tab1 +'m'  +tab1 +'kW'  +tab1 +'kVAr'+tab1 +'kVA'+tab1 +tab1 +
           'A'+tab1 +'W/m²'+tab1 +'m²' +tab1 +'W/m²'+tab1 {+'h/a'};
      adStF (s);
   end;
   //............................................
   procedure asTabXnSis_VAK;      begin
    //asTabXnSisB (1,'MinSUL / MinKatk\=_\20*630/1412.2A\@8888.8\8888.8\'); //<Oli alp ennen 3.0.0
    //asTabXnSisB (1,'MinSUL/MinKatk\=_\20*630/1412.2A\@888.8\888.8\');  end;                        -4.0.0
    //asTabXnSisB (1,'MinSUL/MinKatk__\=_\20*630/1412.2 A_\@888.8 snt/kWh_\-> 888.8 %_\');  end;
    //asTabXnSisB (1,'HävEnergKeskiHinta__\=_\20*630/1412.2 A_\@888.8 snt/kWh_\-> 888.8 %_\');  end; //+4.0.0
      asTabXnSisB (1,'HävEnergKeskiHinta___\=_\231.00 €/kWh/a___\@8888.8 snt/kWh_\-> 8888.8 %_\');  end; //+4.0.0
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
BEGIN//tulostakesk
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
{//,,,,,,Tab poiston kokeilua,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
adStF ('KoeTab<t>1<t>2<t>3<t>4</tab>');
adStF ('KoeTab<t>11<t>22<t>33<t>44</tab>');
adStF ('Screen:  dpi=' +fImrkt0 (Screen.PixelsPerInch,1) +' FntDpi=' +fImrkt0 (NjTulFrm.aRich.Font.PixelsPerInch,1) +
//     '   TabCount=' +fImrkt0 (NjTulFrm.aRich.ParaAttributes.TabCount,1));
       '   TabCount=' +fImrkt0 (NjTulFrm.aRich.Paragraph.TabCount,1));
NjTulFrm.aRich.AddText (str);   str := '';
NjTulFrm.aRich.Paragraph.Tab[0] := 0;
NjTulFrm.aRich.Paragraph.Tab[1] := 0;
NjTulFrm.aRich.Paragraph.Tab[2] := 0;
NjTulFrm.aRich.Paragraph.Tab[3] := 0;
NjTulFrm.aRich.Paragraph.Tab[4] := 0;
NjTulFrm.aRich.Paragraph.TabCount := 0;
NjTulFrm.aRich.Lines.Add('KoeTab<t>1<t>2<t>3<t>4   ' +fImrkt0 (NjTulFrm.aRich.Paragraph.TabCount,1));
//NjTulFrm.aRich.AddText('KoeTab<t>1<t>2<t>3<t>4   ' +fImrkt0 (NjTulFrm.aRich.Paragraph.TabCount,1));
NjTulFrm.aRich.Lines.Add('KoeTab<t>1<t>2<t>3<t>4   ' +fImrkt0 (NjTulFrm.aRich.Paragraph.TabCount,1));
    NjTulFrm.aRich.Paragraph.Alignment := taLeftJustify;
    NjTulFrm.aRich.Paragraph.FirstIndent := 10;
    NjTulFrm.aRich.Lines.Add('');
    NjTulFrm.aRich.Lines.Add('Parking lot repair');
    NjTulFrm.aRich.Lines.Add('Cost overruns' +fImrkt0 (NjTulFrm.aRich.Paragraph.TabCount,1));
//''''''Tab poiston kokeilua''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''}

if Katuval //<,,,+7.0.3
then begin
     NjTulFrm.aRich.ReadOnly :=    false;
     NjTulFrm.aRich.WantReturns := true;
     NjTulFrm.aRich.WordWrap :=    false;  end
else begin
     NjTulFrm.aRich.ReadOnly :=    true{olet};
     NjTulFrm.aRich.WantReturns := false{olet};
     NjTulFrm.aRich.WordWrap :=    true{olet};  end;
NjTulFrm.aRich.Font.Name := 'MS Sans Serif'; //<7.0.3  KatuvalF.INC:ssä asetettu Courier jää muuten päälle.
if demo(81) OR PRO_Demo  then adStF (CLR_REB +'(Esittelyversion luvunesitys:</b>    Eräät lasketut arvot on '+
                                 'korvattu  <b>Xxx, DemoX</b> tms. -merkinnällä<b>)' +FNT_B0);
asTabXnSisB (0,'Tiedosto/Edeltävä verkko:__');   //<String tab -kohdan määrittämiseksi + merkkaamiseksi
sa :=       '<b>Tiedosto/Edeltävä verkko:</b>' +tab1;
if EdvFilen=''  then sa := sa +'(Oletustiedot)'
                else sa := sa +EdvFilen;
adStF (sa);
if NOT Katuval //<+7.0.3
then begin
   sa :=       ' <b>Tiedosto/Keskustiedot:</b>' +tab1+tab1+tab1;
   if MootNj  then begin
                   if MoFilen<>''  then sa := sa +MoFilen +'  ';
                   sa := sa +'<b>(Moottorikeskus)</b>';    end else
   if NjFilen=''  then sa := sa +'(Oletustiedot)'
                  else sa := sa +NjFilen;
   adStF (sa);
//adStF ('0'+tab1+'1'+tab1+'2'+tab1+'3'+tab1+'4');      //<Tab-kohtien kokeilua =OK
LF;       
end;

ClearTabs; //adSt_ ('</tab>'); //<Tabit vex. Lopussa pitää olla ' ', jos seur. mrk alkaa '<..', TODETTU
sisVex;    //< +4.0.0
if NOT Katuval  then begin //<+7.0.3
   sa := CLR_GRB+'Yksityiskohtaisempia laskentatietoja saat, jos siirrät lasketun nousujohtovaihtoehdon '+
       'tiedot edeltävän verkon johto-osaksi ja painat Detaljit -painiketta.<br>'+
       '   TULOSTUSLAAJUUTEEN voit vaikuttaa keskustietolomakkeen oikean alakulman "TulostLaaj." '+
       'valinnoilla 1/2/3.   Nyt valittu LAAJUUS ';
       if det1  then sa := sa +'1 (suppein:  Johtosuureet á 1 rivi, ei ryhmäjohtoerittelyä, '+
                               FNT_B0 +CLR_REB +'hälyttävät tiedot vihjeenä)'   else
       if det2  then sa := sa +'2 (selitykset á 1 rivi, '+
                               FNT_B0 +CLR_REB +'hälyttävät tiedot vihjeenä)'   else
                     sa := sa +'3 (laajin)';     sa := sa +'.'+FNT_B0;
   adStF (sa);
   LF;
end;

// 2  2 × APAKM*  240  500.0 m
asTabXnSisB (0,'   \21__\25 x_\MMJ/AMCMK3½½__\3200__\9999.9 m__\KUL__\140oC__\k=8.888__\');
adStF ('<b>Laskettavaa johto-osaa n:o ' +fImrkt0 (edNo,1)  +'  edeltävä verkko:</b>');
       j := a_getIntg (30001, Edv.YLE.SorceCount);
       for i := 1 to j  do begin
          case a_getIntg (30002,Edv.Sorc[i].src.SorceKind) of //< 1=Transformer  2=LV-Cable  3=Generator  4=UPS
             1 :sa := 'Suurjänniteliittymä';
             2 :sa := 'Pinjänniteliittymä ';
             3 :sa := 'Generaattori         ';
          else  sa := 'UPS-syöttö             ';  end;
          if j>1  then sa := '<t>0' +IntToStr (i) +'<t>' +sa
                  else sa := '<t>' +sa;
          adStF (sa);
       end;//for
       adStF ('<t>(Ks. syöttöverkon tarkemmat tulosteet/tiedot verkkokuvaajasta.');
       sa := a_getStrg (30002,edv.YLE.Kuvaus);
       if sa<>''  then adStF ('Kuvaus: <t>' +sa);
       if edNo<=0                                                                               //<,+6.2.2
       then adStF ('<t>Johtoa ei edellä muita johtoja.')
       else for i := 1 to edNo -1  do begin
           sa := '<t>';  if i<10  then sa := sa +'  ';
           sa := sa + fImrkt0 (i,1) +'<t>';
           j :=               a_getIntg (30003,edv.edka[i].Lukumaara);
           if (j<10) and (j>1)  then sa := sa +'  ';
           if j>1   then sa := sa +fImrkt0 (j,1) +' ×';              sa := sa +'<t>';
           sa := sa +               a_getStrg (30004,edv.edka[i].Tyyppi)      +'<t>';
           sa := sa +      fRmrkt0 (a_getReaa (30005,edv.edka[i].Amm2)  ,1,0) +'<t>';
           sa := sa +      fRmrkt0 (a_getReaa (30006,edv.edka[i].Pituus),1,1) +' m<t>';
                                 if a_getBool (30007,edv.edka[i].Kuluttaja)  then sa := sa +'KUL'
                                                                             else sa := sa +'SÄL';   sa := sa +'<t>';
           sa := sa +      fImrkt0 (a_getIntg (30008,edv.edka[i].Lampotila),1) +' °C<t>';
           sa := sa +'k=' +fRmrkt0 (a_getReaa (30009,edv.edka[i].Korjaus),1,2) +'<t>';
           j := 0;
           if i=1  then                                                                        //<,,+6.2.2
           for j := 1 to a_getIntg (10086,edv.YLE.SorceCount)  do
           if a_getBool (1087,edv.Sorc[j].josa.PTlopussa)  THEN Break;

           if a_getBool (30010,edv.edka[i].PTlopussa)
           then begin sa := sa +'OnPT';
                      if j>0  then sa := sa +', myös liittymässä.';  end
           else begin sa := sa +'EiPT';
                      if j>0  then sa := sa +', liittymässä OnPT.';  end;

           adStF (sa);
      end;
if Katuval  then GOTO 9; //<+7.0.3
LF;
//ClearTabs; //< +4.0.0
//sisVex;    //< +4.0.0
//str := str +'0'+tab1+'1'+tab1+'2'+tab1+'3'+tab1+'4';  //<OK
//adStF ('0'+tab1+'1'+tab1+'2'+tab1+'3'+tab1+'4');      //<'Tab-kohtien kokeilua =OK
asTabSisB ('MinSUL / MinKatk__'); //<Asettaa 1.sis=tabB(10) + 15xTab á10 + Sis.kohdan "maxSu__" +.. jälkeen
      adStF (Pisteviiva ('Pää-/nousujohtolaskennan yleiset parametrit ja selitykset :'));
      ad1S_ ('Uv = Un / '+FONT_2JUURI +'3,     Un = '+fImrkt0 (a_getIntg (30011, edv.YLE.Un),1) +
             '  ' +FONT_OIKEALLE +'  Uv = '+fRmrkt0 (fUv,1,3)+'  '+FONT_OIKEALLE +'  Uo = '+fImrkt0 (fUo,1)+
             ',   cU = '+fRmrkt0 (a_getReaa (30012, edv.YLE.cU),1,3) );
asTabXnSis_VAK;
sisB;
      ad3SF (1,'Vaihelukumäärä','=',fImrkt0 (a_getIntg (30013,edv.YLE.VaiheLkm),1));
         sa := 'Suojausehtojen tarkastelutapa =' +tab1;
         if a_getBool (30014, nj.jy.NjKulSal)  then sa := sa +'KULUTTAJA-asennus'
                                               else sa := sa +'SÄHKÖLAITOKSEN jakeluverkko';
         sa := sa +',   TN -järjestelmä';
      ad1SF (sa);
         if a_getBool (30015, nj.jy.NjKulSal)
            then sa := '<b>' +fRmrkt0 (a_getReaa (30016, edv.YLE.PoisAika),1,1) +' s</b>'+tab1 +
                       'Poiskytkentäaikatavoite kuluttaja-asennuksissa'
            else sa := '<b>SÄHKÖL.</b>verkon nollausehdon mukaan (Isul = Ik1v / 3.0  tai  Ik1v / 2.5)';
      ad3SF (1,'<b>Poiskytkentäaika</b>','=',sa);
         if a_getBool (30017,edv.YLE.IecOfa)  then sa := 'IEC'  else  sa := 'OFAA';
      ad3SF (1,'Sulaketyyppi','=',sa);
      ad3SF (1,'Tk1v','=',fImrkt0 (a_getIntg (30018, nj.jy.Tk1v),1) +' °C' +tab1 +
             'Resistanssien laskentalämpötila Ik1v :ssä');
        //sa := AnsiUpperCase (a_getStrg (30019, nj.jy.AsTapa));
          sa := 'A=as. putkeen; huono jäähd.   B=as. pinnalle; hyvä jäähd.   D=as. maahan, ks. A2/taulukko '+
                '52-B1';
      ad3SF (1,'As.tapa × Korjaus','=',a_getStrg (30019, nj.jy.AsTapa) +' × ' +
             fRmrkt0 (a_getReaa (30020, nj.jy.Korjaus),1,3)   +tab1 +sa);

     {ad3SF (1,'Uh% -raja','=',fRmrkt0 (a_getReaa (30021, edv.NjL.yhtUhRaja),1,3) +' % '  +tab1 +   <,,-4.0.0
             'Max. kokonaisUh% -arvo nousujohdon päässä,   josta:');
      ad3SF (1,'Uh%edv','=',fRmrkt0 (a_getReaa (30022, edv.NjL.edUhOsa),1,3) +' %' +tab1 +
             'Edeltävän verkon osuus,   joista:');
      ad3SF (1,'Uh%Nj -raja','=',fRmrkt0 (a_getReaa (30023, edv.NjL.NjUhRaja),1,3) +' %' +tab1 +
             'KokonaisUh% :n nousujohdolle jäävä osuus');                                           -----}
      ad3SF (1,'Uh% -raja','=',fRmrkt0 (a_getReaa (30021, nj.jy.UhRaja),1,3) +' % '  +tab1 +        //< +4.0.0
             'Max. Uh% -arvo nousujohdon päässä');

       //IF alpx IN [1,2]  THEN sa := ''  ELSE sa := fImrkt0 (alpx,1) +'á';       //<Varokelukumäärä ja SA -10.0.5
         if KuorSul=0  then sa := 'n ×..'                                         //<,,Muutos SA +SV 10.0.5
                       else sa := '(' +fDemIx_PRO (1,KuorSul,1) +')';
         sa := sa +'/'+fDemRx (1,KuorKat,1,1) +' A' +
               tab1 +'Kuorman edellyttämä minimi (yksittäis)sulake/-katkaisijan terminen asetus</b> sis. minimi '+
               '<b>(haluttu) kasvuvara ja tasaus</b>  (ks. seur.).   MinSUL = ';

         if Hvrt=0            //,,Nämä kasvuvarasijoitukset on siirretty alempaa, KASV käytetty muuallakin jotta
            then kasv := a_getReaa (30024, nj.jy.Kasvuv)              //päästy samalla KASV sijoituksella =+10.0.5
            else kasv := fKertaSuor_lop_arv (1, a_getReaa (30024, nj.Hav.dPprs),a_getReaa (30024, nj.Hav.dPprs) );

         if a_getBool (30018,edv.YLE.IecOfa)  then sv := 'IEC'  else  sv := 'OFAA';                 //<+8.0.4
           ar := fKsul (sv,KuorSul);                                          //<,,Erittelylaajennus +10.0.5
           rr := ((kasv/100)+1) *a_getReaa (30025, nj.jy.tasaus) / ar;
           sv := ' MinKatk = Ih ×Kvara ×Ktas = ×Kyht ' +fDemRx (1,rr*ar,1,2); //<*ar koska MinKat:ssa eioo Ksul´ia.
         if KuorSul=0  then sa := sa +'"n ×.." = yhteisarvo MinKatk mukaan.'
                       else sa := sa +fDemRx (1,KuorKat,1,1) +' ×Kvara ' +fDemRx (1,(kasv/100)+1, 1,2) +
                                  ' ×Ktas ' +fDemRx (1,a_getReaa (30025, nj.jy.tasaus), 1,2) +
                                  ' / Ksu ' +fDemRx (1,ar,1,3) +'  = ×Kyht ' +fDemRx (1,rr,1,3) +' = '+
                                  fDemRx (1, KuorKat *rr, 1,1) +' A ' +
                                  FONT_OIKEALLE +' Lähin '+ FONT_SUURPI +' vakiokoko.';
          sa := sa +sv;                                                                 //<''Muutos SA +SV 10.0.5
      ad3SF (1,'<b>MinSUL/MinKatk','=',sa);

         sa := fRmrkt0 (a_getReaa (30025, nj.jy.tasaus),1,3) +
               tab1 +'Kuormituksen tasauskerroin (Ktas)';
      ad3SF (1,'KuorTasaus','=',sa);

      if Hvrt=0
      then sa := fRmrkt0 (kasv,1,0) +' %' +
               //tab1 +'1. lasketun/tulostetun johdon minimi kuorman kasvuvara';
                 tab1 +'Annettu minimi kuorman kasvuvara johdolle'
      else          //,,Tässä olleet kasvuvarasijoitukset on siirretty ylemmäksi, KASV käytetty muuallakin +10.0.5
           sa := fRmrkt0 (kasv,1,1) + ' %' +tab1 +'Ph :n <b>kasvuennusteen</b> mukainen kasvuvara, ks. seur.';
      ad3SF (1,'MinKasvuvara','=',sa +' (Kvara)');
//HävEnergKeskiHinta
      if Hvrt>0  then with nj.Hav  do begin
         LF;
         ad1SF ('<b>Annetut häviökustannustekijät:' +tab1 +'Diskontatut arvot, tekijät ja diskont.kerroin:</b>');
         ad1SF ('     (Hakasulkeissa [ ] esitetyt numerot viittaavat diskonttausmenetelmäyhtälöön, esim. [2])');
         ad1SF ('     (Rivin lopussa on esitetty diskonttauskerroin, jolla nyky-/loppuarvo saadaan, esim. =7.469×)');
         ad3SF (1,'Mitoitusjakso','=',         fRmrkt0 (a_getReaa (30024,Tpit),    1,1) +' a');
               sa := fRmrkt0  (a_getReaa (30024,Korko),   1,2) +' %/a'     +Stoistv_nyk_arv (a_getReaa (30024,Korko));
         ad3SF (1,'Laskentakorko','=',sa);
               sa := fRmrkt0  (a_getReaa (30024,Hprs),    1,2) +' %/inv/a' +Stoistv_nyk_arv (a_getReaa (30024,Hprs));
         ad3SF (1,'Huoltokustannukset','=',sa);
         ad3SF (1,'Huipun käyttöaika','=',     fRmrkt0 (a_getReaa (30024,Tph),     1,0) +' h/a');
         ad3SF (1,'Yökulutuksen osuus','=',    fRmrkt0 (a_getReaa (30024,YOprs),   1,2) +' %');

         ad3SF (1,'Tyhjäkäyntivakio','=',      fRmrkt0 (a_getReaa (30024,Ktyh),    1,2));
                                                                               //1, =Prosentteina   0=Abs. arvona
                        ar := a_getReaa (30024,dPprs);
                     sa := fRmrkt0 (ar,1,2) +' %/a' +Slop_arv (1,ar,ar); //+' =' +fRmrkt0 (1+rr/100,1,2) +'×';
         ad3SF (1,'Ph:n kasvu<b>ennuste</b>','=',sa);
                        ar := a_getReaa (30024,dWmkprs);
                     sa := fRmrkt0 (ar,1,2) +' %/a' +Slop_arv (1,ar,ar);
         ad3SF (1,'Energ.hintaennuste','=',sa);
                        ar := a_getReaa (30024,PVpen);   rr := a_getReaa (30024,dWmkprs);
                     sa := fRmrkt0 (ar,1,2) +' snt/kWh' +Slop_arv (0,ar,rr);
         ad3SF (1,'   PVenergian hinta','=',sa);
                        ar := a_getReaa (30024,YOpen);                        //<,RR pysyy ennallaan
                     sa := fRmrkt0 (ar,1,2) +' snt/kWh' +Slop_arv (0,ar,rr);
         ad3SF (1,'   YÖenergian hinta','=',sa);
                        ar := a_getReaa (30024,Pmk);                          //<,RR pysyy ennallaan
                     sa := fRmrkt0 (ar,1,2) +' €/kWh/a' +Slop_arv (0,ar,rr);
         ad3SF (1,'   Tehomaksu','=',sa);                                     //<,RR pysyy ennallaan

         ad1SF ('<b>Ed:n perusteella laskettu:</b>');
                        ra := fKeskiNjCos;                     //< ra = Kokonaiskuorman Cosini = P/S
                        ar := fKESmk (TRUE,ra)*100;            //< ra = cosPhii -> keskihinta, *100=penneiksi 
                     sa := fRmrkt0 (ar,1,2) +' snt/kWh';
                        ar := fKertaSuor_lop_arv (0,ar,rr);    //,##################################
{!<-SV}              SV := sa +' [4]';                         //<### SV tarvitaan myös ALEMPNA ####
{!}                  sa := SV +tab1 +FONT_OIKEALLE +'   '+sRmrkt0vex (ar,1,1{fDes(ar)});
{!}                  sa := sa +'[1]' +tab1 +'= Loppuarvo ' +FONT_VASEMMALLE +'  Cos' +FONT_FII +
{!}                        fRmrkt0 (fKeskiNjCos,1,3) +'  ' +fRmrkt0 (a_getReaa (30024,nj.Hav.dWmkprs),1,2) +'% × '+
{!}                        fRmrkt0 (a_getReaa (30024,nj.Hav.Tpit),1,1) +'a';
{!}       //ad3SF (1,'EnergKeskiHinta','=',sa);
{!}         ad3SF (1,'HävEnergKeskiHinta','=',sa);
{!}                     ar := 1*fPHaika (TRUE,fKeskiNjCos);
{!}                  sa := fRmrkt0 (ar,1,0) +' h/a';  //<sa :n perään välejä + '[5]' niin että SV:n[4] kohdakkain
{!->SV}              sa := Y_SamPitOikSuor (SV, sa,'[5]', NjTulFrm.Canvas,NjTulFrm.aRich.Font); //<''''''''''''''
                     sa := sa +tab1 +'Cos' +FONT_FII +'=' +fRmrkt0 (fKeskiNjCos,1,3) +' :lla';
         ad3SF (1,'HäviöPhKäyAika','=',sa);

      if Det2 or Det3  then begin
    //sisVex; //<Ei tarvita, sisA hoitaa (ainakin uuden)
      sisA;
         adStF ('<b>Diskonttausmenetelmät :');
         adStF ('Merkinnät:</b>     A<b>^</b>n = A potenssiin n,   '{Exp(n) = e^n, }+'korkotekijä <b>'+
                FONT_ALFA +'</b> = 1 + korko% / 100,   <b>t</b> = pitoaika (mitoitusjakso)');
         ad1SF ('<b>[1]   Kertasuoritukseen </b>lisätään korko kunkin vuoden lopussa, diskontointi <b>'+
                'loppuarvoksi :</b>');
         ad1SF ('Loppuarvo = Alkuarvo × Kdiskont,     Kdiskont = '+FONT_ALFA +'^t');
         ad1SF ('<b>[2]   Toistuvaissuoritus </b>kunkin vuoden lopussa, diskontointi <b>nykyarvoksi</b> :');
         ad1SF ('Nykyarvo =   Alkuarvo × Kdiskont,     Kdiskont = [1- 1/('+FONT_ALFA +'^t)] × 100 / korko%');
         ad1SF ('<b>[3]   Johtohäviöiden </b>kapitalisointi ja diskontointi :');
         ad1SF ('Häviokust = 3 ×HävPhKäyAika ×HävEnergKeskiHinta ×R20 × {  [ (1- (B²×G/A)^t) / (1- (B²×G/A)) ]'+
                '×Ih² + (Rtod°C / Isall²) ×dTsall × [ (1- (B^4 ×G/A)^t) / (1- (B^4 ×G/A)) ]×Ih^4  }');
         ad1SF ('missä  A = 1 + p%/100,    B = 1 + PhKasvuennuste%/100,    G = 1 + EnergHinnanKasvuennuste%/100');
         ad1SF ('<b>[4]   Energian keskihinta</b> :     (Yhtälöön [3])');
         ad1SF ('EnergKeskiHinta = Tehomaksu / HäviöPhKäyAika + [ 1 / (1+K) × (PVenergHinta + K×YÖenergHinta) ] '+
                '/ 100,     missä K = YÖosuus%/(100-YÖosuus%)');
         ad1SF ('<b>[5]   Häviöhuipun käyttöaika</b> :     (Yhtälöön [3])');
         ad1SF ('HäviöPhKäyAika = 8760 × [ th/8760 + Ktyhjäkvak² × Sin²' +FONT_FII +' × (1- th/8760) ]');
         ad1SF ('missä '+FONT_EPSIL +' = PhKäyAika / 8760,   th = 8760 × [ '+FONT_EPSIL +' ² × (2+'+
                FONT_EPSIL +' ²) ] / (1+ 2' +FONT_EPSIL +')');
    //asTabXnSis_VAK; //<,Ei tarvita, todettu
    //sisB;
      end; end;//if Det2 or Det3, if Hvrt>0

LF;
sisVex;
//**************************************************************************************************
//*********************************** KESKUSARV. SAR. OTSAK. ***************************************
{@IF lar  THEN BEGIN jat (1, 1,0);  scd; WRITELN ('LOPPUARVOT:     Kasvu=',
   hav2.dPprs:1:2,'%/a Mitoitusjakso=',Trunc (hav2.Tpit+0.5):1,'a   ',
   'Häviöhuipun käyttöaika');  END; @}
{           //...................,dL,....,Ph....,Qh..................<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< ,-4.0.0
asTabXnSisB (0,'Yht= \JK-A-2.3.456\@8888.8\8888.8\'+isomp('kVAr','8888.8') +
               '\8888.8\8.8888\8888.8\8888.8\88888.8\8888.8\HävHka');//<LISÄÄ SELITYS: ..=Häviöhuipn Käyttaika
             // 'Sh....'Cos...'Ih....'W/m²..'m².....'W/m²..'h/a.......HUOM: DemoX mahduttava <<<<<<<<}
            //........,...............,dL,......,Ph......,Qh........................<<<<<<<<<<<<<<<< ,+4.0.0
asTabXnSisB (0,'Yht=__\JK-A-2.3.456___\@8888.8__\8888.8__\'+isomp('kVAr__','8888.8__') +
               '\8888.8__\8.8888__\8888.8__\8888.8__\88888.8__\8888.8__\HävHka__\Varasar');
             // 'Sh......'Cos.....'Ih......'W/m²....'m².......'W/m²....'h/a.....HUOM: DemoX mahduttava
//sisB;
sarakenimet (1);
          //............................,dL...........,Ph...........,Qh...........,Sh...............
{adStF ('<b>1'+tab1+'JK-A-2.3.456'+tab1+'8888.8'+tab1+'8888.8'+tab1+'8888.8'+tab1+'8888.8'+tab1+
       '8.8888'+tab1+'8888.8'+tab1+'8888.8'+tab1+'88888.8'+tab1+'8888.8'+tab1+'88888</b>');     //<'Kokeilu
     //'Cos..........'Ih...........'W/m².........'m²...........'W/m²..........'HävHKa'''''''''''''''
adStF ('2'+tab1+fMaxMrkt ('JK-A-2.3.456','JK-A-2.3.456')+tab1+'8888.8'+tab1+'8888.8'+tab1+'8888.8'+tab1+
       '8888.8'+tab1+'8888.8'+tab1+'8.8888'+tab1+'8888.8'+tab1+'8888.8'+tab1+'8888.8');         //<'Kokeilu
adStF ('3'+tab1+fMaxMrkt ('JK-A-2.3.456789','JK-A-2.3.456')+tab1+'8888.8'+tab1+'8888.8'+tab1+'8888.8'+tab1+
       '8888.8'+tab1+'8888.8'+tab1+'8.8888'+tab1+'8888.8'+tab1+'88888.8'+tab1+'8888.8');        //<'Kokeilu}
{adStF ('0'+tab1+'1'+tab1+'2'+tab1+'3'+tab1+'4'+tab1+'5'+tab1+'6'+tab1+'7'+tab1+'8'+tab1+'9');  //<<Kokeilu}
{adStF (fImrkt0 (fMrkPix (' '),1)+' 255='+Chr(255)+' pit='+fImrkt0 (fMrkPix (Chr(255)),1)+
       ' 129='+Chr(129)+' pit='+fImrkt0 (fMrkPix (Chr(129)),1)+
       ' 8 pit='+fImrkt0 (fMrkPix ('8'),1)); //=2 5 5                                           //<'Kokeilu}

adStF ('SYÖTETYT alkuarvot:');

for i := kesja downto 1  DO //======================== KESKUSKOHT. ARVOT ===========================
WITH nj.jk[i] DO BEGIN  //i,tunnus,  dL,Ps,Qs,Ss,Coss,Iss,  p,ala,palV,HävHka,,,,,,,,,,,,,,,,,,,,,,,
    //ar := a_getReaa (30051, Ps) /a_getReaa (30052, Ss);   //<Cosini, KASV ei vaikuta <<<<<<<<<<<<<
   sa := fImrkt0 (i,1)+tab1           +fMaxMrkt (a_getStrg (30053, tunnus),'JK-A-2.3.456') +tab1;
      if i>1  then sa := sa +'+';
   sa := sa +fRkilo0_PRO (0, a_getReaa (30054, dL)  ,1,1)+tab1  +'<b>'+fRkilo0_PRO (0, a_getReaa (30055, Ps) ,1,1)+'</b>'+tab1  +
             fRkilo0_PRO (0, a_getReaa (30056, Qs)  ,1,1)+tab1  +fRkilo0_PRO (0, a_getReaa (30057, Ss) ,1,1)+tab1  +
             fRmrkt0     (   a_getReaa (30058, Coss),1,3)+tab1  +fRkilo0_PRO (0, a_getReaa (30059, Iss),1,1)+tab1;
      ar := a_getReaa (30060, ala);
      rr := 0;  if ar>0  then rr := a_getReaa (30061, Ps)*1000 / ar;  {= p[W/m²]}
   sa := sa +
         fRmrk5x_PRO (0, rr ,1,1)+tab1 {= p[W/m²]}          +fRkil5x_PRO (0, ar ,1,1)+tab1 {= ala[m²]} +
         fRmrk5x_PRO (0, a_getReaa (30062, palV),1,1)+tab1;
      if a_getBool (30061,PTlop)  then sa := sa +'OnPT'
                                  else sa := sa +'EiPT';
   adStF (sa);
END;//for

   YHTpSyo := 0;  YHTpVrt := 0;
if kesja>1
then begin  //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, KESKUSKOHT. ARVOT / Yht= rivi,,,,,,,,,,,,,,,,,,,,,,,,
      ar := Pskok / Sskok; //<Cos
   sa := 'Yht='+tab1 +'====='+tab1 +
         fRkilo0_PRO (0, NJpit ,1,1)+tab1  +'<b>'+fRkilo0_PRO (0, Pskok ,1,1)+'</b>'+tab1  +fRkilo0_PRO (0, Qskok     ,1,1)+tab1  +
         fRkilo0_PRO (0, Sskok ,1,1)+tab1  +fRmrkt0 (ar{=cos} ,1,3)+tab1  +fRkilo0_PRO (0, Sskok*fKi ,1,1)+tab1; {=Iskok}
      j := 0;
      if Akok>0  then begin
         for i := 1 to kesja  DO WITH nj.jk[i] DO BEGIN
            YHTpSyo := YHTpSyo +a_getReaa (30063, Ps);
            ar := a_getReaa (30064, ala);              //<On varmasti arvo jos Akok>0 ##############
            rr := a_getReaa (30064, palV);
            if rr>0  then YHTpVrt := YHTpVrt + ar*rr   //<Lasketaan kumulat.:  ALA * pVrt = PyhtVrt
                     else j := i;
         end;
         YHTpSyo := YHTpSyo *1000 / Akok;
         if j=0  then YHTpVrt := YHTpVrt / Akok        //<Ei *1000 koska oli W/m² ##################
                 else YHTpVrt := 0;
      end;//if Akok>0

   sa := sa +fRmrk5x_PRO (0, YHTpSyo ,1,1)+tab1   +fRkil5x_PRO (0, Akok ,1,1)+tab1   +fRmrk5x_PRO (0, YHTpVrt ,1,1);
   adStF ('<b>'+sa+'</b>');
end;//if kesja>1        //'''''''''''''''''''''''''' KESKUSKOHT. ARVOT '''''''''''''''''''''''''''''
                        //=================== KESKUSKOHT. TASATUT + LOPPUARVOT =====================
IF (Hvrt>0) or
   (kesja>1)  or (tas[1]<1)        //<tas[1] asetettiin 38.INC/PRC ketjuarvot :ssa
THEN BEGIN
if kesja>15  then sarakenimet (0); //<KUMMA:  Jos ehto = esim. kesja>5, ei kaikki rivin:ot tulostu ?????????
LF;                                //<<<<<<<  mutta mm. LF; tässä korjaa tilanteen -- RichNolan erikoisuus??
   if kesja>1
      then sa := 'LASKETUT loppuarvot (sis. kasvu) / <b>läpimenevät tehot</b>'
      else sa := 'LASKETUT loppuarvot (sis. kasvu)';
   sa := sa +' (sis. mahd. tasoitus)';

   kasv := 1;                      //<Kommentti 10.0.5: KASV käytetty muuallakin.
   IF Hvrt>0
   THEN with nj.Hav  do begin      //<,3.0.0
      kasv := fKertaSuor_Diskont (a_getReaa (30065,Tpit), a_getReaa (30065,dPprs));
      sa := sa +' kasvuennusteen mukaan:';   end
   ELSE sa := sa +':';
   adStF (sa);

   IF Hvrt>0
   THEN with nj.Hav  do begin      //<,3.0.0
      ar := a_getReaa (30064,dPprs);
      rr := fKertaSuor_lop_arv (1, ar,ar);
      sa := '(<b>Kasvu =</b> ' +fRmrkt0 (ar,1,2) +'%/a  ' +fRmrkt0 (a_getReaa (30064,Tpit),1,1) +'a  ' +
            FONT_OIKEALLE +'  +' +fRmrkt0 (rr,1,2) +'%  = <b>' +fRmrkt0 (1+rr/100,1,2) +'×</b>)';
      adStF (sa);
   end;

for i := kesja downto 1  DO
WITH nj.jk[i] DO BEGIN  //i,TASAUS,  dL,Ps,Qs,Ss,Coss,Iss,  p,ala,palV,HävHka,,,,,,,,,,,,,,,,,,,,,,,
   sa := fImrkt0 (i,1)+tab1;           //+fMaxMrkt (a_getStrg (30063, tunnus),'JK-A-2.3.456') +tab1;
     {if (kesja>1) and (a_getReaa (30064, nj.jy.tasaus)<1)
         then }sa := sa +'tas='+fRmrkt0 (tas[i],1,3);
   sa := sa +tab1;
      if i=1  then j := 1  else j := 0;                   //<DemoX vain jk[1] :n eräisiin palstoihin
      if i>1  then sa := sa +'+';
      ra := a_getReaa (30064, Coss);                      //<  Cos sama, vaikka kasv > 1  +3.0.0
      rr := Ptas[i]*kasv / ra;                            //< =Stas = P / Coss
      if rr <= Ptas[i]*kasv                               //<+6.0.0 Aiheutti Floating point err. kun V¨(10²-10²)
         then ar := 0
         else ar := Sqrt ( Sqr(rr) - Sqr(Ptas[i]*kasv) ); //< =Qtas = V¨(S² - P²), Coss pysyy samana
   sa := sa +fRkilo0_PRO (0, a_getReaa (30064, dL)  ,1,1) +tab1   +'<b>'+fRkilo0_PRO (0, Ptas[i] *kasv    ,1,1) +'</b>'+tab1 +
             fRkilo0_PRO (0, ar{=Qtas*~kasv}        ,1,1) +tab1   +fRkilo0_PRO (j, rr{=Stas*~kasv}  ,1,1) +tab1 +
             fRmrkt0     (   ra{=Coss}              ,1,3) +tab1   +fRkilo0_PRO (j, rr{=-"-..} *fKi  ,1,1) +tab1;
      rr := 0;  ar := 0;                                 //<Pitää olla jos ei Akok #################
      if Akok>0  then begin
         for j := i to kesja  do ar := ar +a_getReaa (30066, nj.jk[j].ala); //< AR = yhtAla =kumulat
         rr := Ptas[i]*1000*kasv / ar; {rr= p[W/m²]  ar= yht[m²]}
      end;//if Akok>0
   sa := sa +fRmrk5x_PRO (0, rr ,1,1){= p[W/m²]}      +tab1   +fRkil5x_PRO (0, ar ,1,1)+tab1; {= yht[m²]}
      rr := 0;                                           //<,AR tarvitaan vielä =yhtAla ############
      if Akok>0  then begin                              //<if Akok>0 -> AR vielä voimassa #########
         for j := i to kesja  do begin
            with nj.jk[j]  do ra := a_getReaa (30067, palV) * a_getReaa (30068, ala);
            if ra=0  then begin rr := 0;  Break;  end    //<Kumulat summa palV * ala (JK:ssa [i]) ##
                     else       rr := rr +ra;
         end;//for
      end;//if Akok>0
      YHTpVrt := 0;                  //<Vaikka turha laskea: On sama kuin ed. taulukon YHTpVrt -arvo
      if ar>0
         then begin  YHTpVrt := rr;   rr := rr/ar;  end     //<YHTpVrt tässä = KUMULAT [i] palV*ala
         else        rr := 0;                               //'YHTpVrt apuna. Sij. joka krlla, mutta
   sa := sa +fRmrk5x_PRO (0, rr,1,1)+tab1;                  //'käytetään vasta FOR-silmukan JÄLKEEN.
   adStF (sa);
END;//for               //'''''''''''''''''''''''''' KESKUSKOHT. TASATUT +LOPPUARVOT '''''''''''''''
                        //,,,,,,,,,,,,,,,,,,,,,,,,,, KESKUSKOHT. - " - / Yht -rivi,,,,,,,,,,,,,,,,,,
Pedv := Ptas[1] *kasv;  //<Sij absol.vain tässä, käyttö NjTul31.INC
if kesja>1  then begin
      ra := Ptas[1] / Sqrt( Sqr(Ptas[1]) + Sqr(Qtas[1]) );//< =Cos =P/S =sama =0.894427, vaikka KASV>1  +3.0.0
      rr := Ptas[1]*kasv / ra;                            //< =Stas
      if rr <= Ptas[1]*kasv                               //<+6.0.0 Varm. vuoksi ettei Floating point err. V¨(10²-10²)
         then ar := 0
         else ar := Sqrt ( Sqr(rr) - Sqr(Ptas[1]*kasv) ); //< =Qtas = V¨(S² - P²), Coss pysyy samana
   sa := 'Yht='+tab1 +'=========='+tab1 +
      fRkilo0_PRO (0, NJpit           ,1,1)+tab1  +'<b>'+fRkilo0_PRO (0, Pedv{=Ptas[1]} ,1,1)+'</b>'+tab1  +
      fRkilo0_PRO (0, ar{=Qtas*~kasv} ,1,1)+tab1  +fRkilo0_PRO (1, rr{=Stas*~kasv}      ,1,1)+tab1  +
      fRmrkt0     (   ra{=cos}        ,1,3)+tab1  +fRkilo0_PRO (1, rr{=-"-..}*fKi       ,1,1)+tab1;

      rr := 0;
      if Akok>0  then begin  rr := Ptas[1]*1000*kasv / Akok;   YHTpVrt := YHTpVrt / Akok;  end;
   sa := sa +
      fRmrk5x_PRO (0, rr{W/m²} ,1,1)+tab1  +fRkil5x_PRO (0, Akok ,1,1)+tab1  +fRmrk5x_PRO (0, YHTpVrt ,1,1);
                                    //Laskettiin jo SYOTTOtulostussilmukassa''''ja pätee edelleen
                     //Laskettu turhaan uudelleen: On sama kuin ed. taulukon'''''YHTpVrt -arvo ##
   adStF ('<b>'+sa+'</b>');
   if kesja>10  then sarakenimet (0);
         //............................,dL...........,Ph...........,Qh...........,Sh.............
{  adStF ('<b>1'+tab1+'JK-A-2.3.456'+tab1+'8888.8'+tab1+'8888.8'+tab1+'8888.8'+tab1+'8888.8'+tab1+
       '8.8888'+tab1+'8888.8'+tab1+'8888.8'+tab1+'88888.8'+tab1+'8888.8'+tab1+'88888</b>'); //<'Kokeilu}
     //'Cos..........'Ih...........'W/m².........'m²...........'W/m²..........'HävHKa'''''''''''''''
sisVex; sisVex; sisVex;
   adStF ('Loppuarvon <b>Yht=</b> rivin arvot ovat samoja, kuin ketjun 1. keskuksen läpi menevä kuorma (sis. oma).');
   adStF ('<b>Yht=</b> -rivien arvot on laskettu pyöristämättömillä desimaaleilla, joiden summa pyöristetty.');
   if a_getReaa (30069, nj.jy.tasaus) < 1  then begin
      adStF ('<b>tas[aoKesNo]</b> = tas[1] + (1 - tas[1]) × tasNop potenssiin(keskusLkm - aoKesNo),');
      adStF ('missä  tas[1] = anTas,     tas[viimKesNo] = 1.000,     tas[ ] = Laskettu tasauskerroin,'+
             '     anTas = annettu max.tasaus,     tasNop = tasausnopeusvakio = 0.75');
   end;
end;//if kesja>1
//2 LF; //LF; = adStF ('');  -> 1xLF jättää vikasta adStF (''):stä tulostamatta </b>:n '>':n
               //' = RichNolan bugi. Nyt 3xLF aiheuttaa 3xLF :n mutta 1xLF EI AINUTTAKAAN ??????????????????
END;// ELSE//if Hvrt>0..
//2 LF;
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*)
   {if isDebuggerPresent  then
      LaskeEkvivZpituus; //<'+7.0.4}
   esitaProgres ('Lasketut vaihtoehdot:  Yle',1);
9: //+7.0.3
   NjTulFrm.aRich.AddText (str);   str := '';
END;//tulostakesk
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NjTul30.INC }
  {esitaProgres ('Johdot (1..'+fImrkt0 (kesja,1)+') :  Yle',1);
                                     //'Tämäkin vain, kun os=1 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<}
{     if os=1  then sa := '+'  else sa := ',';
      sa := sa + fImrkt0 (os,1);
   esitaProgres (sa, os+1);    //<esitaProgres kasvattaa merkkijonoa (sa):  Johdot: Yle+1,2,3,4... jne.}


