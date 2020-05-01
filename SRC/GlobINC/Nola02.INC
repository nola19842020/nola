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

{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NOLA02.INC }
{  Ei sis. JK/EDKA globaaleja. 16.5.97 Muokattu DELPHIin

130.0:  Lisätty 2A Dz ja gG -tyyppeihin. Vaikea selvittää jatkuva virhe "Inval. floating..", vika löytyi
        kohdista SulRangeOK (ja fSu_PerusSama), joihin olin unohtanut lisätä 2A sulakekoon pienimmäksi.
}
//==================================================================================================
{'AMKA'A  'AXMK'X      'APAKM*'P  'AXCMK'Z  'SVjärjest.'S  'AMMK*'M  'AMCMK'C  'AVOJOHal'V
 'MCMK'C  'MMJ/MMK*'M  'PLKVJ*'J  'AVOJOHcu'V}

FUNCTION Isal (CONST tyyppi :string;  mm2 :real;  tapa :string) :Real;      var a :integer; //+10.0.1 tarkist.
              //PALAUTTAA: Isal = f (tyyppi,a=mm2) [A] !! Jatkuva.  3johdolla, Tjohdin=70°C, Tymp=25°C/Tmaa=15°C
              //Avojohdot  T=?/SLY... Muut A2-94/ 52-C3,52-C4  ja SFS 6000 v.2007/A.52-3 "Kuormitettavuudet ABCD".
              //Vain AVOJOHDOILLA ja PEXeillä eri.  AMKA vanhan StM :n mukaan <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

   function fSam (CONST si :string) :boolean;      begin                    //<+6.0.2  CONST+SamIso +6.0.3
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1

  {PROCEDURE s3 (r3 :Real);         BEGIN  Isal := r3;  END;}
   PROCEDURE si (rA,rC,rD :Real);   BEGIN  IF tapa='A'  THEN Isal := rA  ELSE
                                           IF tapa='C'  THEN Isal := rC
                                                   {D=} ELSE Isal := rD; END;
BEGIN
a := fM2 (mm2);
if fSam ('AVOJOHal')  then               //< AVOJOHTO Al <<<<<<<<<<<<<<<<<<<<<<<<
   CASE a OF //A__,C,D                       85=NOKIA, Muut=SLY=samat kuin NOKIA
       85 :si (360,0,0);   34 :si (210,0,0);
       54 :si (280,0,0);   21 :si (155,0,0);
  {ELSE IF a>85  THEN si (360,0,0)   ELSE si (155,0,0);  END;}
      ELSE si (0,0,0);  end  else
if fSam ('AVOJOHcu')  then               //<70,50=NOKIA, Muut=SLY=NOKIA<<<<<<<<<<
   CASE a OF //A__,C,D
       70 :si (370,0,0);   35 :si (240,0,0);   16 :si (145,0,0);
       50 :si (305,0,0);   25 :si (195,0,0);   10 :si (105,0,0);
    {ELSE IF a>70  THEN si (360,0,0)   ELSE si (105,0,0);  END;}
     ELSE si (0,0,0);  end  else
if fOnKIS (tyyppi)
then begin
   if fOnKISal (tyyppi)  
   then CASE a of
           1600 :si (2530,2530,0);  else if a>1600
            then si (4074,4074,0)       //< 3200
            else si (1286,1286,0);  end //< 800
   else CASE a of
           1600 :si (3231,3231,3231);  else if a>1600
            then if fSam ('KiskAbb-CuNx ;KiskAbb-CuSx')
                 then si (4938,4938,0)
                 else si (4320,4320,0)
            else si (0,0,0);  end    //< 800
end else
(*if (tyyppi='SVjärjest.')  then                                                                    //<,,-6.0.2
   CASE a OF //A___,C___,D___         //<Tapa A=pysty  C,D=vaaka / NOKIA<<<<<<
     3200 :si (3150,3600,3600);   900 :si (1150,1300,1300);
     2400 :si (2400,2700,2700);   600 :si (900,950,950);
     1200 :si (1600,1800,1800);   300 :si (480,500,500);
    {ELSE IF a>3200  THEN si (3100,3400,3400)  ELSE si (480,500,500); END;}
     ELSE  si (0,0,0);  end  else*)
if fOnSV (tyyppi)  then                                                                             //<,,6.0.2
begin                                            //,NOKIA,,,,,,,,,,,
   if fOnSVal (tyyppi)
      then//SVsystAL..
         CASE a OF //A___,C___,D___  //<Tapa A=pysty  C,D=vaaka / NOKIA ,,,1kV:n kaap.järjest.luettelosta.
           2400 :si (2400,2700,2700);
           1200 :si (1600,1800,1800);
            900 :si (1150,1300,1300);
            600 :si ( 900, 950, 950);
         else if a>2400
            then si (3150,3600,3600)  {3200}
            else si ( 480, 500, 500); {300} END//case
      else//SVsystCu..
         CASE a OF //A___,C___,D___  //<Tapa A=pysty  C,D=vaaka / NOKIA ,,,1kV:n kaap.järjest.luettelosta.
            900 :si (1450,1640,1640);
            600 :si (1140,1200,1200);
         else if a>900
            then si (2020,2270,2270)  {1200}
            else si ( 600, 630, 630); {300} END//case
end else
if fSam ('AMKA')  then                             //<AMKA / SLY
   CASE a OF //A,C__,D
      120 :si (250,0,0);      50 :si (140,0,0);      25 :si (95,0,0);
       70 :si (180,0,0);      35 :si (115,0,0);      16 :si (70,0,0);
     {ELSE IF a>120  THEN si (250,0,0)   ELSE si (70,0,0);  END;}
      ELSE si (0,0,0);  end  else
if fSam ('AXMK ;AXCMK')  then           //<A2-94 /52-C4
   CASE a OF
     {300 :si (358,457,463);  120 :si (204,254,279);   35 :si (97,116,140);
      240 :si (312,395,408);   95 :si (177,219,246);   25 :si (79,93,117);
      185 :si (266,335,355);   70 :si (147,180,207);   16 :si (60,79,91);
      150 :si (235,294,315);   50 :si (117,141,168);}
    //ELSE IF a>300  THEN si (358,457,463)  ELSE si (60,79,91);  END;
                                                                            //,,10.0.1
      300 :si (325,458,430);  120 :si (187,255,255);   35 :si (90,116,125); //<,,SFS 6000 v.2007/A.52-3, 3 kuor-
      240 :si (283,397,375);   95 :si (163,219,220);   25 :si (73, 94,100); //   mitettua johdinta -sarakkeesta.
      185 :si (242,336,330);   70 :si (136,181,185);   16 :si (57, 79,78);
      150 :si (214,294,280);   50 :si (108,141,150);
      ELSE si (0,0,0);  end  else
if fSam ('APAKM* ;AMMK* ;AMCMK ;AMCMK3½ ;AMCMK3½o ;AMCMK3½HD ;AMCMK3½½ ;AMCMK4½')  then //A2-94/52-C3,52-C4
   CASE a OF                                                                            //'3½o,3½HD=11.0.1
     {300 :si (276,372,395);  120 :si (157,208,237);   35 :si (74,96,121);
      240 :si (240,323,349);   95 :si (136,180,208);   25 :si (60,77,100);
      185 :si (205,274,304);   70 :si (113,148,176);   16 :si (45,62,78);
      150 :si (180,240,269);   50 :si (89,116,142);}
    //ELSE IF a>300  THEN si (276,372,395)  ELSE si (45,62,78);  END;
                                                                           //,,10.0.1
      300 :si (257,372,430);  120 :si (143,209,255);   35 :si (69,95,125); //<,,SFS 6000 v.2007/A.52-2, 3 kuormi-
      240 :si (219,323,375);   95 :si (125,180,220);   25 :si (56,77,100); //   tettua johdinta -sarakkeesta.
      185 :si (187,274,330);   70 :si (104,148,185);   16 :si (43,62, 78);
      150 :si (164,240,280);   50 :si ( 83,117,150);
      ELSE si (0,0,0);  end  else
   CASE a OF //'MCMK', 'MMJ/MMK*', 'PLKVJ*'
     {300 :si (347,491,510);   70 :si (144,195,228);   6 :si (32,43,57);
      240 :si (303,427,450);   50 :si (114,152,185);   4 :si (25,33,46);
      185 :si (262,361,389);   35 :si (94,126,156);    2 :si (19,25,36);
      150 :si (228,311,349);   25 :si (77,101,130);    1 :si (13.5,18.5,26);
      120 :si (199,274,308);   16 :si (59,80,101);   //''2=2.5  1=1.5
       95 :si (173,236,271);   10 :si (44,60,78);}
    //ELSE IF a>300  THEN si (347,491,510)  ELSE si (13.5,18.5,26); END;
                                                                           //,,10.0.1
      300 :si (316,492,550);   70 :si (133,195,240);   6 :si (31,43,57);   //<,,SFS 6000 v.2007/A.52-2, 3 kuor-
      240 :si (278,427,480);   50 :si (105,153,190);   4 :si (24,34,46);   //   mitettua johdinta -sarakkeesta.
      185 :si (236,361,420);   35 :si ( 88,126,160);   2 :si (19,25,35);
      150 :si (208,317,370);   25 :si ( 72,102,130);   1 :si (14,18.5,26);
      120 :si (182,274,325);   16 :si ( 55, 80,100);   //''2=2.5  1=1.5
       95 :si (159,236,285);   10 :si ( 41, 60, 77);
      ELSE si (0,0,0);  END;
END;//Isal
//==================================================================================================
PROCEDURE pienIsul (VAR IsulNim :Integer);
   function fsi (isu :integer) :boolean;      begin
      Result := false;
      if IsulNim>isu  then begin  IsulNim := isu;
                                  Result := true;    end; end;
BEGIN           //'Esim:  1500..1251 -> 1250   1250..1001 -> 1000'''''''''''''''''''''''''''''''''''
   if fsi(1250)  or  fsi(1000)  or  fsi (800)  or  fsi (630)  or  fsi (500)  or  fsi (400)  or
      fsi (315)  or  fsi (250)  or  fsi (200)  or  fsi (160)  or  fsi (125)  or  fsi (100)  or
      fsi ( 80)  or  fsi ( 63)  or  fsi ( 50)  or  fsi ( 40)  or  fsi ( 32)  or  fsi ( 25)  or
      fsi ( 16)  or  fsi ( 10)  or  fsi (  6)  THEN begin end  ELSE IsulNim := 0;
END;//pienIsul                                                    //''''''''''Testattavissa kutsussa
//==================================================================================================
PROCEDURE kasvaIsul (VAR Isu :Integer);   BEGIN
   IF isu< 6   THEN isu :=  6    ELSE IF isu< 10  THEN isu :=  10   ELSE
   IF isu< 16  THEN isu :=  16   ELSE IF isu< 20  THEN isu :=  20   ELSE
   IF isu< 25  THEN isu :=  25   ELSE IF isu< 32  THEN isu :=  32   ELSE
   IF isu< 40  THEN isu :=  40   ELSE IF isu< 50  THEN isu :=  50   ELSE
   IF isu< 63  THEN isu :=  63   ELSE IF isu< 80  THEN isu :=  80   ELSE
   IF isu< 100 THEN isu :=  100  ELSE IF isu< 125 THEN isu :=  125  ELSE
   IF isu< 160 THEN isu :=  160  ELSE IF isu< 200 THEN isu :=  200  ELSE
   IF isu< 250 THEN isu :=  250  ELSE IF isu< 315 THEN isu :=  315  ELSE
   IF isu< 400 THEN isu :=  400  ELSE IF isu< 500 THEN isu :=  500  ELSE
   IF isu< 630 THEN isu :=  630  ELSE IF isu< 800 THEN isu :=  800  ELSE
   IF isu<1000 THEN isu := 1000  ELSE{IF isu<1250 THEN}isu := 1250 {ELSE //< -1500  2.0.1
                    isu := 1500;}
END;//kasvaIsul
//==================================================================================================
FUNCTION fKsul (CONST suCs :string;  Isul :Integer) :Real;    // SFS 6000/433.1:  Ib <= In <= Iz  ja I2 <= 1,45*Iz.
                                                              // Ib =Virta jolle piiri on suunniteltu.  Iz =Jatkuva
                                                              //     kuormitettavuus.  In =Suojalaitteen nimellvirta.
                                                              //     I2 =I jolla varmasti toimii. (Komm. 10.0.5).
     //'SulakeKerroin. YR :lla ei enää päde, jos kerran on tie-
     //'dossa, ollaanko sulakekäyrän YR/AR:lla, mutta toisaalta tätä FNCta kutsutaan VAIN TIEDOLLA: IEC/OFAg/OFAm
      VAR suojatyp :Char; //<suojatyp: 'G'=IEC/OFAA/OFAM  'Z'=(diaZed)  'B,C,D'=JSK-tyypi :'G'<=25 -> Z:ksi
                //,kZ,kG,kJ =Tulppasulakkeelle,gG+gL,Johdonsuojakatkaisijalle. Kommentteja ym. täydennetty, ei
   PROCEDURE sijK (kZ,kG,kJ :Real);   VAR Ksu,fnc{+8.0.4} :Real;  BEGIN                       //'muutoksia. +8.0.4
      CASE suojatyp OF
                   'Z' :Ksu := kZ;       //<dZ
           'B','C','D' :Ksu := kJ;       //<Johdonsuojat
                  ELSE  Ksu := kG;  END; //<Muuten aina gG-tyyppinen =IECgG/OFAAgG/OFAMaM
      fnc := 1.45/Ksu;                   //< =JSA :lla fKsu := 1 <<<<<<<<<<<<<<
      result := fnc;
   END;           //  Ib      <= In     <= Iz      ja   I2        <= 1,45 Iz
                  //  Imitoit <= Isunim <= Ijsal   ja   Isultehok <= 1,45 Ijsal
                  //  >>>  In <= Iz 1.45 / K  =>  Iz <= In K / 1.45  <<<<<<<<<<
BEGIN//fKsul                   //' Isunim < (1.45/1.6) x 26A = 23.5A -> 20A
   suojatyp := suCs[1];        //< B,C ja D JSK :t
   if (fSu_Perus (suCs)=su_IECg) OR (fSu_Perus (suCs)=su_IECd) OR (fSu_Perus (suCs)=su_OFAg) OR
      (fSu_Perus (suCs)=su_OFAm) OR fSu_Sama (suCs,'G')  THEN suojatyp := 'G';
   IF Isul >  25  THEN sijK (1.6 , 1.6, 1.45)  ELSE       //<,A2/433.2 + D1 s.108:  Kertoimet ylemmälle sulamisra-
   IF Isul >= 16  THEN sijK (1.75, 1.6, 1.45)  ELSE       //  javirralle =+10.0.5.
   IF Isul >  10  THEN sijK (1.75, 1.9, 1.45)  ELSE
   IF Isul >  4   THEN sijK (1.9 , 1.9, 1.45)  ELSE
                       sijK (2.1 , 2.1, 1.45);            //<2 ja 4A
END;//fKsul
//............................................
FUNCTION fKrin (tapa :string;  kpl :Integer) :Real;   BEGIN // RINNkaapKorj: A2-94/52
   //,,,D ja A,C -sarakkeet olivat vaihtuneet. Virhe jo DOS -ajalta. KORJAUS +4.0.2 ,,,,,,,,,,,,,,,,
   TAPA := AnsiUpperCase (TAPA);                        //<,,Ei ole ilmennyt tarvetta, mutta varm.vuoks.
   while (Length(TAPA)>0) and (TAPA[1]=' ')             do Delete (TAPA,1,1);            //<Alkutyhjät  vex.
   while (Length(TAPA)>0) and (TAPA[Length(TAPA)]=' ')  do Delete (TAPA,Length(TAPA),1); //<Lopputyhjät vex.

   IF TAPA='D'
   THEN IF kpl >= 6  THEN fKrin := 0.60  ELSE               //< D = Maahan:  A2-94/52-E2, s.236
        IF kpl >= 5  THEN fKrin := 0.65  ELSE
        IF kpl >= 4  THEN fKrin := 0.70  ELSE
        IF kpl >= 3  THEN fKrin := 0.75  ELSE
        IF kpl >= 2  THEN fKrin := 0.85  ELSE  fKrin := 1
   ELSE IF kpl >=16  THEN fKrin := 0.65  ELSE               //< A, C:        A2-94/52-E1, s.235
        IF kpl >= 6  THEN fKrin := 0.70  ELSE
        IF kpl >= 4  THEN fKrin := 0.75  ELSE
        IF kpl >= 3  THEN fKrin := 0.80  ELSE
        IF kpl >= 2  THEN fKrin := 0.85  ELSE  fKrin := 1;
END;//fKrin
//--------------------------------------------------------------------------------------------------
                          //PRC koska FNC kirjoittaa 2x = EI SAA KUTSUA FNCn KAUTTA KIRJOITTAMAAN =
                          //YvSuo kutsuttava erikseen, jos halutaan DETtietoa kirjoitettavaksi <<<<<
                          // SPECIAL p.o. = 0 !!!!!!!!!!!!!     ,,StM :n mukainen sorce = YvSuoj.STM
                          // DELPHImuutos: PRC -> FNC :string;
function YvSuo (oh, special :Integer;  CONST suCs :string;  samaSul,katkaisija :Boolean;   TAPA :string;
                 korjkerr :Real;  CONST tyyppi :string;  mm2 :real;  kaapkpl :Integer;   VAR Suoja :Real) :string;
                          {Palauttaa STRINGnä kertoimet yms. ja PARAMssa YLIVIRTAsuojan/KATKAISIJAN aset.arvot
                               HUOM HUOM HUOM: 1.5 JA 2.5mm2 EI muokata MUOTOON 1 JA 2 ENNEN KUTSUA !!!!!!!!!!
                           SamaSUL=Esim.moott.lähtöjen yhteissulake. Tapauksissa, missä 2kaap:n Isal
                           isompi kuin sulake sallisi. Kuten KATKAISIJA, mutta lisäksi *Ksu !!!!!!!!
                 ''OH=0       =Arvo tulostetaan ilman demotestiä
                 ''SPECIAL >0 =LISÄINFOA SULVALINNASTA, ASETUS nolaHkus.INC}
VAR Isunim :Integer;   ar,Ijsal :Real;   {+}str :string;
   FUNCTION fKsu :Real;     BEGIN fKsu := fKsul (suCs,Isunim);   END;
   FUNCTION fKri :Real;     BEGIN fKri := fKrin (tapa,kaapkpl);  END;
   FUNCTION fIsuYR (IaSal :Real) :Real;   BEGIN fIsuYR := IaSal *korjkerr *fKsu {*fKri -10.0.1};  END;//fIsuYR
//............................................
BEGIN//YvSuo
{+}str := '';
   Ijsal := Isal (tyyppi,mm2,tapa);
   IF katkaisija
   THEN BEGIN Suoja := kaapkpl *Ijsal *korjkerr {*fKri -10.0.1};
      IF special>0  THEN BEGIN //<,SPECIAL vain detaljitietojen editoimiseen ,,,,,,,,,,,,,,,,,,,,,,,
              //,,,,Palauttaa:   1163.50  <-  Isal = á358.0*5 = 1790.0 * Kyht = 0.650   = Kas 1.00 * Krin 0.65
       //str := str + fDemRx (oh, kaapkpl *Ijsal *korjkerr *fKri ,1,1) +' A  '+ FONT_VASEMMALLE +'  Isal = ';//-10.0.1
         str := str + fDemRx (oh, kaapkpl *Ijsal *korjkerr       ,1,1) +' A  '+ FONT_VASEMMALLE +'  Isal = ';
         IF kaapkpl>1  THEN str := str +'á';   str := str +fDemRx (oh, Ijsal,1,1);
         IF kaapkpl>1  THEN str := str +' ×' +fImrkt0 (kaapkpl,1); // +' = ' +fDemRx (oh, Ijsal*kaapkpl,1,1);
        {str := str + ' × Kyht = ' +fDemRx (oh, korjkerr *fKri,1,3) +                               <,-9.0.2
                      '   = Kas '  +fDemRx (oh, korjkerr,1,2) +' × Krin ' +fDemRx (oh, fKri,1,2);  END; END}
         str := str + ' × Kyht = ' +fDemRx (oh, korjkerr,1,3) +'   = Kas';                         END; END//<+9.0.2
   ELSE BEGIN //,,,,,,,,,,,,,,,,,,SULAKKEILLE,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      ar := Ijsal;  IF (kaapkpl=2) OR samaSul  THEN ar := kaapkpl*Ijsal;   //<Yhteinen sulake, yhteiskuormitettavuus.

      Isunim := 2000;                                                      //<Tästä lähdet pienentäm
      WHILE  (Isunim > fIsuYR(ar)) AND (fIsuYR(ar) > 0)  DO pienIsul (Isunim);

      IF Isunim>1250  THEN Isunim := 0;                                    //<Testattavaksi<<<<<<<<<
      Suoja := 1*Isunim;
      IF special>0  THEN BEGIN //<,SPECIAL vain detaljitietojen editoimiseen ,,,,,,,,,,,,,,,,,,,,,,,
               //,,,,Palauttaa:  583.5 A <- Isal = á303.0 *2 * Kyht = 0.963 = Kas 1.25 * Ksu 0.906 * Krin 0.85
       //str := str + fDemRx (oh, kaapkpl *Ijsal *korjkerr *fKsu *fKri,1,1) +' A  ' +FONT_VASEMMALLE +'  Isal = ';//-10.0.1
         str := str + fDemRx (oh, kaapkpl *Ijsal *korjkerr *fKsu      ,1,1) +' A  ' +FONT_VASEMMALLE +'  Isal = ';
         IF kaapkpl>1  THEN str := str +'á';   str := str +fDemRx (oh, Ijsal,1,1);
         IF kaapkpl>1  THEN str := str +' ×' +fImrkt0 (kaapkpl,1); // +' = ' +fDemRx (oh, Ijsal*kaapkpl,1,1);
        {str := str + ' × Kyht = ' +fDemRx (oh, korjkerr*fKsu*fKri,1,3) +                           <,,-9.0.2
                '   = Kas ' +fDemRx (oh, korjkerr,1,2) +' × Ksu ' +fDemRx (oh, fKsu,1,3) +
                ' × Krin '  +fDemRx (oh, fKri,1,2);   END;}
         str := str + ' × Kyht = ' +fDemRx (oh, korjkerr*fKsu     ,1,3) +                           //<,,9.0.2
                '   = Kas ' +fDemRx (oh, korjkerr,1,3) +' × Ksu ' +fDemRx (oh, fKsu,1,3);  END;
   END;
{+}Result := str;
END;//YvSuo
//............................................
                                      //,,StM :n mukainen sorce = YvSuoj.STM
FUNCTION YvSuoj (CONST suCs :string;  samaSul,katkaisija :Boolean;  TAPA :string;  korjkerr :Real;
                 CONST tyyppi :string;  mm2 :real;  kaapkpl :Integer) :Real;
                           {Palauttaa YLIVIRTAsuojan/KATKAISIJAN aset.arvon
                                   HUOM HUOM HUOM: 1.5 JA 2.5mm2 EI muokata
                                   MUOTOON 1 JA 2 ENNEN KUTSUA !!!!!!!!!!!!
                            SamaSUL=Esim.moott.lähtöjen yhteissulake. Tapau
                            ksissa, missä 2kaap:n Isal isompi kuin sulake s
                            allisi. Kuten KATKAISIJA, mutta lisäksi *Ksu!!!
                 ''SPECIAL >0 =LISÄINFOA SULVALINNASTA, ASETUS nolaHkus.INC}
VAR  fnc :Real;
BEGIN
   YvSuo (0,0, suCs,samaSul,katkaisija,TAPA,korjkerr,tyyppi,mm2,kaapkpl, fnc);
   YvSuoj := 1*fnc;                                   //Tähän palautuu YvSuoj'''....................
END;//YvSuoj
//===========================================================================
function OikSuoSFSt (CONST suCs :string;  CONST tyyppi :string;  mm2 :real;  kpl :Integer;  Tim :real) :Integer;
   VAR aa2 :integer;  //Palauttaa OIKOSULKUsuojan arvon SFS 434.5.2 (vanha 434.3.2) mukaan laskien:     //'+10.0.1
     //ar :real;      //   t = k² × A²/Ik²  =>  Ik = V¨(k² × A²/t)  =>  Ik = k×A/V¨t (=k×A  kun t=1s)
                      //     A = [mm²]  Ik = [A] ja luetaan IECgG käyrältä t=1 s:n Ik -arvo yr-käyrältä.
                      //   Ks. PRC VrtOikSuo.   Esim. 10 ...
                   {Taulukko 43A Kertoimen k arvot vaihejohtimille. s.166
                                               PVC         PVC        EPR/PEX  Kumi   Mineraali
                                               <= 300 mm2  > 300 mm2           60 °C  PVC:llä       Paljas
                                                                                      päällystetty
                    Alkulämpötila °C           70          70         90       60     70            105
                    Loppulämpötila °C          160         140        250      200    160           250
                    Johtimen materiaali:       ___         ___        ___DEVELOPER1: Nämä huomioidaan.
                     Kupari                    115         103        143      141    115           135/115a
                     Alumiini                  76          68         94       93     –             –
                     Tinalla juotetut          115         –          –        –      –             –
                             ''''''''DEVELOPER1: Juottamista ei huomioitu}
   function fSam (CONST si :string) :boolean;      begin
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1

   function fK :real;      VAR ak :real;  AlCu :boolean;      begin
      AlCu := fAlCu (tyyppi);   aa2 := fM2 (mm2);
      if AlCu
      then begin                  //,,,,,,Al,,,,,,,,,,,,,,,,,,,,,,,
         if fSam ('AXMK ;AXCMK')
         then ak := 94                      //<PEX´ille
         else if aa2<=300
              then ak := 76                 //<,PVC´lle.
              else ak := 68;  end
      else begin                  //,,,,,,Cu,,,,,,,,,,,,,,,,,,,,,,,
         if aa2<=300
            then ak := 115                  //<,PVC´lle.
            else ak := 103;
      end;
//      ak := ak/3;  //<????????????????????????????????????????????
      result := ak;
   end;

       //,ALA/YLÄraja/KeskiArvo -Tik (SULtypin mukaan),,,,,,,,,,,,,,,,,esim. FNC:lla SulTypOKrajat
       //FUNCTION Ikt_R (CONST suCs :string;  Isul :Integer;  Tim :Real) :Real;
   function fSul :integer;      VAR af,rr,ik :real;  sul :integer;      begin //af  =SFS:n mukainen kerroin
      af := fK;   sul := 5000;                                                //sul =Sulake   ik=Oikos.virta Ik
      af := af*mm2;                //,,Etsitään SULake, jonka IecYR:ltä 1 s:n Ik-arvo <= fK*mm2 (jos SUL isompi,
     {repeat pienIsul (sul);       //,,se ei rajoita lämpötilaa sallituksi).
             if sul>0  then        //su_OFAg su_OFAm   su_IECg su_IECgAR su_IECgYR   su_IECd su_IECdAR su_IECdYR
                rr := Ikt_R (suCs,sul,Tim);
      until (sul=0) or  (sul>0) and (rr<af);}
      Ik := af/Sqrt(Tim);
      repeat pienIsul (sul);       //,,se ei rajoita lämpötilaa sallituksi).
             rr := 0;
             if sul>0  then        //su_OFAg su_OFAm   su_IECg su_IECgAR su_IECgYR   su_IECd su_IECdAR su_IECdYR
                rr := Ikt_R (suCs,sul,1);
      until (sul=0) or  (sul>0) and (rr<ik);
      result := sul;
   end;//fSul

begin//OikSuoSFS............................
{  ar := fK;
//   ar := ar/Sqrt(5);
   result := Pyor (ar*mm2);}
   result := fSul;
end;

{function OikSuoSFS (CONST suCs :string;  CONST tyyppi :string;  mm2 :real;  kpl :Integer) :Integer; //<'+10.0.1
   begin  OikSuoSFSt (suCs,tyyppi,mm2,kpl,1);  end;}
//===========================================================================
FUNCTION OikSuoj (CONST suCs :string;  CONST tyyppi :string;  mm2 :real;  kpl :Integer) :Integer;
   var a :integer;                 //Palauttaa OIKOSULKUsuojan arvon.  StM Tlk 25.2-20 ja D1 2005 Tlk 43.2
                                   //HUOM HUOM HUOM: 1.5 JA 2.5mm² EI muokata
                                   //             MUOTOON 1 JA 2 ENNEN KUTSUA
   function fSam (CONST si :string) :boolean;      begin                                 //<+6.0.2  +6.0.3
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1

   PROCEDURE sij (Sul_gG,Sul_aM :Integer);
   BEGIN
     {IF kpl>1  THEN OikSuoj := 0  ELSE}
      if fSu_Sama (suCs,su_OFAm)  then OikSuoj := Sul_aM
                                  else OikSuoj := Sul_gG;
   END;
    //Kaksoiskaapeli oikosSuojataan yhden kaap mukaan, vrt. oikos vain 1*kaap
BEGIN
//a := Trunc (mm2); <<<<< MUOKATAAN 1.5 ja 2.5  1:ksi ja 2:ksi <<<<<<<<<<<<<<
a := fM2 (mm2);
if fSam ('AVOJOHal ;AVOJOHcu')  then
   sij (0,0)  else
{--------------------------------------        //<Ehkä viisaampaa sittenkin 0
       CASE laji OF            // AVOJOHTO Al ja Cu = 1.N-ehto määrää ???/SLY
        TRUE  :CASE mm2 OF          //<,,OIKOS.SULAKKEEKSI MAX.YLIVIRTASULAKE
                   85 :sij (250);                            //< Arvattu
                   54 :sij (200);                            //< AVOj Al /SLY
                   34 :sij (160);
                   21 :sij (125);
                  ELSE IF mm2>85  THEN sij (250)
                                  ELSE sij (  0);  END;
        FALSE :CASE mm2 OF          //<,,OIKOS.SULAKKEEKSI MAX.YLIVIRTASULAKE
                   70 :sij (315);                            //< Arvattu
                   50 :sij (250);                            //< Arvattu
                   35 :sij (200);
                   25 :sij (160);
                   16 :sij (125);
                   10 :sij ( 80);
                  ELSE IF mm2>70   THEN sij (315)
                                   ELSE sij (  0);  END;               END;
----------------------------------------------------------------------------}
if fOnKIS (tyyppi)  then                                                                                     //<+6.0.2
   sij (0, 0)  else //<Päätelty: Ei löydy riittävä isoa sulaketta edes 800 mm²:lle.
(*if (tyyppi='SVjärjest.')  then                                                                    //<,,-6.0.2
   CASE a OF  600 :sij (1250,1250);              //<,,aM arvattu 23.10.98
              300 :sij (1250,1250);
              else sij (0,0);  end  else*)
if fOnSV (tyyppi)  then                                                                             //<,,6.0.2
   if a=300  then sij (1250,1250)                //<,aM arvattu 23.10.98
             else sij (   0,   0)  else
if fSam ('AMKA')  then                           //< AMKA, VAIN LIITT.JOHDLLE
   CASE a OF   120 :sij (315,0);                 //<,,aM pitää tutkia //< SLY
                70 :sij (250,0);                                      //< SLY
                50 :sij (200,0);                                      //< SLY
                35 :sij (200,0);                                      //< SLY
                25 :sij (160,0);                                      //< SLY
                16 :sij (125,0);                                      //< SLY
   ELSE IF a>120  THEN sij (315,0)                                    //< SLY
                  ELSE sij (  0,0);  END else
if fSam ('AMCMK ;AMCMK3½ ;AMCMK3½o ;AMCMK3½HD ;AMCMK3½½ ;AMCMK4½')  then //<3½o,3½HD=+11.0.1
   CASE a OF  240 :sij (630,500);   70 :sij (250,160);       //'AMCMK / StM A1-89 gG s.193 = D1-95 s. 113 gG+aM
              185 :sij (500,400);   50 :sij (160,125);
              150 :sij (400,315);   35 :sij (125,80);
              120 :sij (400,315);   25 :sij (125,80);
               95 :sij (250,200);   16 :sij (100,63);
   ELSE IF a>240  THEN sij (630,630)
                  ELSE sij (  0,0);  END else           //,MCMK / StM A1-89 gG s.193 = D1-95 s. 113 gG+aM
if fSam ('MCMK ;MCMK3½ ;MCMK3½½ ;MCMK4½')  then
   CASE a OF  240 :sij (800,800);   70 :sij (315,250);   10 :sij ( 80,63);
              185 :sij (630,630);   50 :sij (250,200);    6 :sij ( 63,40);
              150 :sij (500,500);   35 :sij (160,125);    4 :sij ( 40,25);
              120 :sij (500,500);   25 :sij (160,125);    2 :sij ( 32,16);  //<2.5
               95 :sij (400,315);   16 :sij (125,100);    1 :sij ( 25,10);  //<1.5
   ELSE IF a>240  THEN sij (800,800)
                  ELSE sij (  0,0); {=0,75 Cu}   END else
if fSam ('AXMK')  then                         //< AXMK / StM A1-89 s.192 = D1-95 s. 112 gG+aM
   CASE a OF  800 :sij (1250,1250);   240 :sij (1000,1000);   70 :sij (400,315);
              630 :sij (1250,1250);   185 :sij ( 800,800);    50 :sij (315,250);
              500 :sij (1250,1250);   150 :sij ( 630,630);    35 :sij (250,200);
              400 :sij (1250,1250);   120 :sij ( 630,630);    25 :sij (160,125);
              300 :sij (1250,1250);    95 :sij ( 500,500);    16 :sij (125,80);
   ELSE IF a>800  THEN sij (1250,1250)
                  ELSE sij (   0,0);  END else
if fSam ('AXCMK ;APAKM*')  then    //< AXCMK, APAKM / StM A1-89 s.193 = D1-95 s. 113 gG+aM
   CASE a OF  300 :sij (800,800);   70 :sij (315,250);          // Paperi+PEX rinnastettavissa
              185 :sij (630,500);   35 :sij (160,125);          // OLET: APAKM=vanha kaapeli,
              120 :sij (500,400);   16 :sij (125,80);           //       AXCMK oikeampi ve kuin AXMK
   ELSE IF a>300  THEN sij (800,800)
                  ELSE sij (  0,0);  END else
if fSam ('MMJ/MMK* ;MMJ ;PLKVJ*')  then //< MMJ,MMK, PLKVJ / StM A1-89 s.191 = D1-95 s. 111 gG+aM.  MMJ+130.2e
   CASE a OF  300 :sij (1250,1250);  95 :sij (500,500);  16 :sij (125,100); //'PLKVJ oletettu vastaavan MMK-
              240 :sij (1000,1250);  70 :sij (400,400);  10 :sij ( 80,63);  //'ta, EI MCMKta <<<<<<<<<<<<<<
              185 :sij (1000,1000);  50 :sij (315,315);   6 :sij ( 63,40);  4 :sij (40,25){=D´ +10.0.1};
              150 :sij ( 800,800);   35 :sij (250,200);   2 :sij ( 32,16{=D´, oli 25}); //<2.5  <',D´=D1 2005, 10.0.1 
              120 :sij ( 630,630);   25 :sij (200,160);   1 :sij ( 25,10{=D´, oli 16}); //<1.5
   ELSE IF a>300  THEN sij (1250,1250)
                  ELSE sij (  10,10);  END else  //,, AMMK / StM A1-89 s.192 = D1-95 s. 112 gG+aM
   CASE a OF  800 :sij (1250,1250);   240 :sij (800,800);   70 :sij (315,250);
              630 :sij (1250,1250);   185 :sij (630,630);   50 :sij (250,200);
              500 :sij (1250,1250);   150 :sij (630,500);   35 :sij (200,125);
              400 :sij (1000,1250);   120 :sij (500,400);   25 :sij (125,100);
              300 :sij (1000,1000);    95 :sij (400,315);   16 :sij (100, 63);
   ELSE IF a>800  THEN sij (1250,1250)
                  ELSE sij (   0,0);  END;
END;//FNC OikSuoj
//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ,,,SULfnc.VS
{............................................... Ks. \pascal\nola\KOETik1.PAS
Ks. FNC Tim := k1 * Exp (k2 * Ik) +k3, ratkaistaan Ik :::::::::::::::::::::::
=>  Exp (k2 * Ik) = (Tim - k3) /k1                    : Otetaan Ln mol puol
 (  Ln Exp (C) => C * Ln (e)   ))))))))))))))))))))))): Ln (e) = 1 <<<<<<<<<<
=>  Ln Exp (k2 * Ik) = Ln ((Tim - k3) /k1)            : Tim = AIKA
=>  k2 * Ik          = Ln ((Tim - k3) /k1)
=>  Ik               = Ln ((Tim - k3) /k1) /k2        :<<<<<<<<<<<<<<<<<<<<<}
//============================================================================================================
(*procedure SULfncM (Isul :Integer;  VAR alueita :integer;  VAR a1,b1,c1, raj2,a2,b2,c2, raj3,a3,b3,c3 :Real);
   procedure s3 (aa1,bb1,cc1, raja2,aa2,bb2,cc2, raja3,aa3,bb3,cc3 :Real);   begin //'Alueita 1 t. 3''''''''''
      alueita := 3;                  a1 := aa1;  b1 := bb1;  c1 := cc1;            //,,,,,aM(OFAM) sulakkeille
                     raj2 := raja2;  a2 := aa2;  b2 := bb2;  c2 := cc2;
                     raj3 := raja3;  a3 := aa3;  b3 := bb3;  c3 := cc3;  end;
   procedure s1 (aa1,bb1,cc1 :Real);    begin                                    //<,Yksi fnc kattaa koko käyrän
      alueita := 1;              a1 := aa1;  b1 := bb1;  c1 := cc1;
                     raj2 := 0;  a2 := 0;    b2 := 0;    c2 := 0;
                     raj3 := 0;  a3 := 0;    b3 := 0;    c3 := 0;    end;
begin//SULfncM
   CASE Isul of
      6 :s3 (12.9 ,-70 ,-3.5,    57, 12.2 ,-113,-3.5,  39, 11.5,-273,-4.4);
     10 :s3 (15.86,-165,-4  ,    84, 15.86,-163,-4  ,  59, 16  ,-225,-4.32);
     16 :s1 (17.29,-365 ,-3.9  );        125 :s1 (29.23,-1105,-4.277);
     20 :s1 (18.2 ,-417 ,-3.94 );        160 :s1 (30.72,-1170,-4.293);
     25 :s1 (20.5 ,-598 ,-4.15 );        200 :s1 (32.1 ,-1235,-4.293);
     32 :s1 (22.7 ,-520 ,-4.28 );        250 :s1 (33.1 ,-1275,-4.292);
     40 :s1 (23.6 ,-567 ,-4.28 );        315 :s1 (34.1 ,-1440,-4.292);
     50 :s1 (24.39,-673 ,-4.234);        355 :s1 (34.7 ,-1765,-4.299);
     63 :s1 (26.23,-650 ,-4.28 );        400 :s1 (35.15,-1885,-4.293);
     80 :s1 (27.4 ,-722 ,-4.28 );        500 :s1 (36.22,-2095,-4.293);
    100 :s1 (28.23,-870 ,-4.277);
   else
   if Isul<6
   then s3 (12.45, -48,-3.876,  36, 11.5,-100,-4,  26, 12,-130,-4.5 ) //<- 4A
   else if Isul>500
   then s1 (36.88,-2685,-4.292)
   else s1 (0,0,0); end;//CASE
end;//SULfncM
//--------------------------------------------------------------------------------------------------------------
         //,,Ik, jolla Isul toimii ajassa TIM (0.01-100s) aM-sulakkeella.
//FUNCTION SULfncM_Ik (Isul :Integer;  Tim :Real) :Real;

FUNCTION SULfncM_Tik (Isul :Integer;  Ik :Real) :Real; //<Tik=Oikosulun kestoaika (=0.01-100s) aM-sulakkeella.
      var alueita :integer;   a1,b1,c1, raj2,a2,b2,c2, raj3,a3,b3,c3 :Real;
   procedure sij (a,b,c :real);      begin  result := exp (a -(b/Ik) + c*ln(Ik));  end;
begin
   SULfncM (Isul,  alueita,  a1,b1,c1, raj2,a2,b2,c2, raj3,a3,b3,c3);
   if alueita=1
   then sij (a1,b1,c1)
   else if Ik> raj2  then  sij (a1,b1,c1)  else //<Ik >  KESKIALUEEN raja-arvo =Isoin alue
        if Ik>=raj3  then  sij (a2,b2,c2)  else //<Ik >= ALIMMAN ALUEEN - " -  =Keskialue
                           sij (a3,b3,c3);      //<Ik ALIMMALLA ALUEELLA (pienin virta) =Alin alue
end;//SULfncM_Tik*)
//============================================================================================================
FUNCTION fSu_Sama (CONST suCs,suCo :string) :boolean;      begin
   result := SamIso (suCs,suCo);   end;
FUNCTION fSu_MuotoR (CONST suCs :string;  VAR suCo :string) :boolean; //<Tut+Pal myös IEC-YLÄ/ALArajaVE:t (Ei käytetty)
  {FUNCTION tama (sus :string);     begin if fSu_Sama (suCs,sus)  then suCo := sus;  end;}
   FUNCTION tama (CONST sus :string) :boolean;     begin     result := false;
      if fSu_Sama (suCs,sus)  then begin suCo := sus;  result := true;  end;  end;
begin
   result := false;
   suCo := suCs;
   if tama (su_OFAg)  or  tama (su_OFAm)    or
      tama (su_IECg)  or  tama (su_IECgAR)  or  tama (su_IECgYR)  or
      tama (su_IECd)  or  tama (su_IECdAR)  or  tama (su_IECdYR)
   then result := true;
end;//fSu_MuotoR
FUNCTION fSu_Muoto (CONST suCs :string;  VAR suCo :string) :boolean; //<EI TUT+PAL IEC-YLÄ/ALArajaVE :ja (Ei käytetty)
   procedure si (CONST sus :string);     begin result := true;  suCo := sus;  end;
  {FUNCTION tama (sus :string);     begin if fSu_Sama (suCs,sus)  then suCo := sus;  end;}
   FUNCTION tama (CONST sus :string) :boolean;     begin     result := false;
      if fSu_Sama (suCs,sus)  then begin suCo := sus;  result := true;  end;  end;
begin
   result := false;
   suCo := suCs;
   if tama (su_OFAg)  or  tama (su_OFAm)  or  tama (su_IECg)  or  tama (su_IECd)
   then result := true;
end;//fSu_Muoto
FUNCTION fSu_Chr (CONST suCs :string) :string;     begin         //<su_OFAg:stä 'F' jne. #########################
   if fSu_Sama (suCs,'F') OR fSu_Sama (suCs,su_OFAg)
      then result := 'F'  else
   if fSu_Sama (suCs,'M') OR fSu_Sama (suCs,su_OFAm)
      then result := 'M'  else
   if fSu_Sama (suCs,'I') OR fSu_Sama (suCs,su_IECg)
      then result := 'I'
      else result := 'Z';  end;//<Dz
FUNCTION fSu_Str (CONST suCs :string) :string;     begin         //<'F':stä su_OFAg jne. #########################
   if fSu_Sama (suCs,'F') OR fSu_Sama (suCs,su_OFAg)
      then result := su_OFAg  else
   if fSu_Sama (suCs,'M') OR fSu_Sama (suCs,su_OFAm)
      then result := su_OFAm  else
   if fSu_Sama (suCs,'I') OR fSu_Sama (suCs,su_IECg)
      then result := su_IECg
      else result := su_IECd;  end;//<Dz
FUNCTION fSu_Perus (CONST suCs :string) :string;     begin       //<su_OFAgAR :stä su_OFAg jne. ##################
   if fSu_Sama (suCs,su_OFAg)
      then result := su_OFAg
      else
   if fSu_Sama (suCs,su_OFAm)
      then result := su_OFAm
      else
   if fSu_Sama (suCs,su_IECg) OR fSu_Sama (suCs,su_IECgAR) OR fSu_Sama (suCs,su_IECgYR)
      then result := su_IECg
      else result := su_IECd;  end;
FUNCTION fSu_PerusSama (CONST suCs,suCv :string) :boolean;     begin  //<su_OFAgAR :stä su_OFAg jne. #############
   result := false;
   if fSu_Perus (suCs) = fSu_Perus (suCv)
      then result := true;   end;

   {      //,,,,,Tutkii, onko SULtyp VALITTU oikein:  YR/AR/OFAg/OFAm -tarkasteluja varten
FUNCTION SulTypOKrajat (suCs :string) :boolean;      begin
   result := fasle;                     //su_OFAg su_OFAm su_IECg su_IECgAR su_IECgYR su_IECd su_IECdAR su_IECdYR
   if fSu_sama (suCs,su_IECgAR)  or  fSu_sama (suCs,su_IECdAR)  or
      fSu_sama (suCs,su_IECgYR)  or  fSu_sama (suCs,su_IECdYR)  or
      fSu_sama (suCs,su_OFAg)    or  fSu_sama (suCs,su_OFAm)    //<''Ulkopuolelle jää vain:  su_IECg ja su_IECd
   then result := true;
end;}
//===============================================================================================================
//===============================================================================================================
               //,,OFAAgG ohjautuu toisaalle ####################################################################
               //,IECg/d ohjataan AUTOMAATTISESTI YLÄRAJA-ARVOIHIN, ELLEI -ar/-yr ###############################
               //,AlaRaja:  Tutkitaan ALARAJAKÄYRÄÄ (VAIN IEC :llä AR/YR, OFAg/m :llä ON VAIN KESKIARVOKÄYRÄ).
               //,PalAika:  TRUE => FNC := TIK(param: TR, ISUL,0,VIRTA)  = Halutaan FNC:ltä VIRTAa vastaava AIKA
               //,          muuten  FNC := IKT(param: FA, ISUL,AIKA,0)   = Halutaan FNC:ltä AIKAa  vastaava VIRTA
{os =              1        2       3       4       5       6       7       8       9      10      11      12
                  13       14      15      16      17      18      19      20      21      22      23
      4   :si('  97.0     70.0    63.0    54.3    46.6    39.5    36.0    32.1    30.3    29.1    28.5    27.9 '+
              '  27.5     26.9    26.5    26.0    25.0    24.3    23.3    22.7    22.0    21.3    21      ');}
//function SULfncX (suCs :string;  PalAika :boolean;  Isul :Integer;  AIKA,VIRTA :real) :real; //<Riced Exeption
//nction SULfncX (suCs :string;  PalAika :boolean;  Isul :Integer;  AIKA :real;  VAR VIRTA :real) :real;    -6.0.3
function SULfncX (CONST suCs :string;  PalAika :boolean;  Isul :Integer;  AIKA,VIRTA :real) :real;       //<+6.0.3
      CONST arMax=23;   TYPE IkArType = array [1..ArMax] of real;
      VAR fnc, Ik1,Ik2 :real;   os1,os2,i :integer;  //<1=Pienempi Ik kahdesta arvosa (=tim1)  2=Isompi Ik (tim2)
          ar{,rr,a,r} :real;   IkAr :IkArType;       //'fnc :hen sijoitetaan arvo, joka palautuu FNC:sta kutsuun
          qVIRTA,Tim1,Tim2 :real;                     //< +6.0.3 'IkAR :iin sijoitetaan sulakkeen taulukkotiedot.

   function fMaxOs :integer;      begin  result := arMax;  //,,Dz :lla vain 20 aika-arvoa,,,,,,,,,,,
                                         if fSu_PerusSama (suCs,su_IECd)  then result := 20  else
                                         if fSu_PerusSama (suCs,su_OFAg)  then result := 22;  end;
   procedure si (so :string);     VAR i,v,os,osja :integer;  ar :real;  sa :string;  arvoOn :boolean;
      function ohavirhe :string;      begin  result := '02.INC / ' +suCs +' / ' +fImrkt0 (osja,1);  end;
   begin
      osja := 0;  sa := '';
      for i := 1 to Length(so)  do                        //<,+130.0:  Korjataan desimErotin ("," EI SAA OLLA, koska Delphi VAATII).
         if so[i]=','  then so[i] := '.';
      for i := 1 to Length(so)  do begin                  //<,Tutkitaan mjonon arvojen lkm, p.o. 20 tai 23 @@@@@@
         if CharInSet(so[i], ['0'..'9','.'])                       //<Onko '.67' estettävä ???????????????????????????????
         then begin  sa := sa +so[i];
                     if i=Length(so)
                        then osja := osja +1;  end        //<Välin tai välimerkin (,;:! tms.) jälk.yksittäinen No
         else if NOT (CharInSet(so[i], [' ']))      //,,@@@@@ ViallMerkistä syntyy väli + os := os+1 ja jos os>arMax,@@@@@
         then begin                        //,,@@@@@ OHA SEKOAA, koska sijoittaa olemattomaan, TODETTU. @@@@@@@@@
             {if MessageDlg('Virheellinen merkki sulakkeen toimintapistetaulukossa :  '+ohavirhe +' : "' +
                            so[i] +'".  Suljetaanko koko ohjelma (muuten virheellinen merkki vain ohitetaan) ?',
                            mtConfirmation, [mbYes, mbNo], 0) = mrYes  then}
              if InfoDlg ('Virheellinen merkki sulakkeen toimintapistetaulukossa :  '+ohavirhe +' : "' +
                          so[i] +'".  Suljetaanko koko ohjelma ?',  mtCustom,
                             'Kyllä','Ei','','',  'Ohjelma suljetaan','Virheellinen merkki vain ohitetaan','','')
                          = 1  then
                 {Application.Terminate;  }PaaValFrm.Close;  end
         else if (i=Length(so)) or (sa<>'')               //<Kahden arvon väliksi tulkittava ' ' tai muu mrk @@@@
         then begin  osja := osja +1;                     //'Väli- tms. arvon jälkeiset MUUT mrkt ohittuvat @@@@@
                     sa := '';   end
      end;
      if fSu_PerusSama (suCs,su_IECd) and (osja<>20)  or
         fSu_PerusSama (suCs,su_OFAg) and (osja<>22)  or
         NOT fSu_PerusSama (suCs,su_IECd)  and NOT fSu_PerusSama (suCs,su_OFAg) and (osja<>23)
      then EiOKinfo ('Ohjelmavirhe, anna tiedot valmistajalle :  '+ ohavirhe);

      for i := 1 to arMax  do IkAr[i] := 0;                         //<Alustetaan <<<<<<<<<<<<<<<<<<
      i := 1;   os := 0;   v := Length(so);
      while i<=v  do begin
         sa := '';  arvoOn := false;
         while (i<=v) and (CharInSet(so[i], ['0'..'9','.']))  do begin
            sa := sa +so[i];
            i := i+1;
            arvoOn := true;
         end;
         if arvoOn  then begin//Val(sa,ar,Code);
                                ar := StrToFloatQ (sa);
                                os := os+1;
                                IkAr[os] := ar; {* Ksu} end
                              (*if Code=0  then IkAr[os] := ar {* Ksu}
                                           else IkAr[os] := 0;  end *)
                    else i := i+1;
      end;//while
      if IkAr[1]=0  then begin     //<,@@@@@@@@@@@@@@ Haluttua sulakekokoa ei löytynyt @@@@@@@@@@@@@
        {if MessageDlg ('Sulakekokoa (' +fImrkt0 (Isul,1) +' A) ei valitulla tyypillä ole. Anna tiedot '+
                        'valmistajalle :  '+ohavirhe +'.   Suljetaanko koko ohjelma (saattaa lukkiutua) ?',
                         mtConfirmation, [mbYes, mbNo], 0) = mrYes
         then PaaValFrm.Close;           //<Ei worki esim. Kayra :stä}
         EiOkInfo ('Sulakekokoa (' +fImrkt0 (Isul,1) +' A) ei valitulla tyypillä ole. Anna tiedot '+
                   'valmistajalle :  '+ohavirhe +'.   Ohjelma saattaa lukkiutua.');
         Abort;  end;
   end;
   procedure YrAr_Keskiarvo (Sar,Syr :string);      VAR SarrAr,SarrYr :array [1..50] of string;  RarrAr,RarrYr :array [1..50] of real; //+130.0
                                                        sa :string;  arvoOn :boolean;  i,os,v :integer;  rr :real;      begin
      for i := 1 to 50 do begin
          if (Sar<>'') and (Sar[i]=',')  then Sar[i] := '.';       //<,1414d: +Sar<>''
          if (Syr<>'') and (Syr[i]=',')  then Syr[i] := '.';  end;
      for i := 1 to 50 do SarrAr[i] := '';   SarrYr := SarrAr;

      i := 1;   os := 0;   v := Length(Sar);
      while i<=v  do begin
         sa := '';  arvoOn := false;
         while (i<=v) and (CharInSet(Sar[i], ['0'..'9','.']))  do begin
            sa := sa +Sar[i];
            i := i+1;
            arvoOn := true;
         end;
         if arvoOn  then begin  rr := StrToFloatQ (sa);
                                os := os+1;
                                RarrAr[os] := rr;  end
                    else i := i+1;
      end;//while

      i := 1;   os := 0;   v := Length(Syr);
      while i<=v  do begin
         sa := '';  arvoOn := false;
         while (i<=v) and (CharInSet(Syr[i], ['0'..'9','.']))  do begin
            sa := sa +Syr[i];
            i := i+1;
            arvoOn := true;
         end;
         if arvoOn  then begin  rr := StrToFloatQ (sa);
                                os := os+1;
                                RarrYr[os] := rr;  end
                    else i := i+1;
      end;//while

      for i := 1 to os do begin //< OS po. arAR´ssa ja arYr´ssä samat.
         rr := (RarrAr[i] +RarrYr[i]) /2;
         //ShowMessage ('Sar=' +Ints(i) +'  Ar=' +fRmrkt0(RarrAr[i],1,3) +'  Ar=' +fRmrkt0(RarrYr[i],1,3) +' => keskiarvo=' +fRmrkt0(rr,1,3));
         sa := fRmrkt0(rr,1,3);
         if InputQuery('Sar=' +Ints(i) +'  Ar=' +fRmrkt0(RarrAr[i],1,3) +'  Yr=' +fRmrkt0(RarrYr[i],1,3), '=> keskiarvo=' ,sa) =False  then Halt;
      end;
   end;//YrAr_Keskiarvo

   function fTim (os :integer) :real;      VAR t :real;      begin
      if fSu_PerusSama (suCs,su_IECd) //,,IECd :llä 20
      then  case os of
         1  :t := 0.1;      6  :t := 3;      11 :t := 8;       16 :t := 30;
         2  :t := 0.2;      7  :t := 4;      12 :t := 9;       17 :t := 40;
         3  :t := 0.5;      8  :t := 5;      13 :t := 10;      18 :t := 60;
         4  :t := 1;        9  :t := 6;      14 :t := 15;      19 :t := 80;
         5  :t := 2;        10 :t := 7;      15 :t := 20;
        else t := 100;  end//<os=20
      else if fSu_PerusSama (suCs,su_OFAg) //,,OFAAgG :llä 22
      then  case os of
         1  :t := 0.01;     6  :t := 2;     11 :t := 10;     16 :t := 60;       21 :t := 7200;
         2  :t := 0.1;      7  :t := 3;     12 :t := 15;     17 :t := 100;
         3  :t := 0.2;      8  :t := 4;     13 :t := 20;     18 :t := 300;
         4  :t := 0.5;      9  :t := 6;     14 :t := 30;     19 :t := 1000;
         5  :t := 1;        10 :t := 8;     15 :t := 40;     20 :t := 3600;
        else t := 10000;  end//<os=22
      else  case os of //<Kaikilla muilla sulaketyypeillä 23 tutkittua tarkistuspistettä
         1  :t := 0.01;     6  :t := 0.5;     11 :t := 5;     16 :t := 10;     21 :t := 60;
         2  :t := 0.03;     7  :t := 1;       12 :t := 6;     17 :t := 15;     22 :t := 80;
         3  :t := 0.07;     8  :t := 2;       13 :t := 7;     18 :t := 20;
         4  :t := 0.1;      9  :t := 3;       14 :t := 8;     19 :t := 30;
         5  :t := 0.2;      10 :t := 4;       15 :t := 9;     20 :t := 40;
        else t := 100;  end;//<os=23
      result := t;
   end;//fTim
//---------------------------------------------------------------------------------------------------------------
begin//SULfncX                                     //@@@@@@@@@@@@ HUOM: 1.rivien lopussa OLTAVA AI- @@@@@@@@@@,,@
                                                   //@@@@@@@@@@@@       NAKIN YKSI VÄLI TAI ","     @@@@@@@@@@,,@ ???
{YrAr_Keskiarvo ('9.79  5.82   5.11   4.43  4.15  3.96  3.81  3.78  3.66  3.6   3.58  3.51  3.46  3.39  3.36  3.32  3.25  3.13  3.05  2.93  2.9   2.87',  //=IECgG-ar 
                 '47.06 22.4   18.8   15.2  13.0  11.1  10.2  9.6   8.9   8.5   8.2   7.6   7.15  6.7   6.44  6.05  5.68  5.0   4.4   4.2   4.11  4.04'); //=IECgG-yr }
if fSu_Sama (suCs,su_OFAg)  then begin
   CASE Isul of//,,OFAAgG keskiarvokäyrä,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      //,,IECgG-ar/yr´stä tähän kopioitu poistaen 0.03 0.07 5 7 9 ja 80s´n sarakkeet ja lisätty 300..10000s.
      //Aika[s] 0,01   0,1    0,2   0,5   1     2     3     4     6     8     10    15    20    30    40    60    100   300   1000  3600  7200  10000
      2   :si( '28.4   14.1   12.0  9.8   8.6   7.5   7.0   6.7   6.3   6.1   5.9   5.6   5.3   5.0   4.9   4.7   4.5   4.5   4.1   3.7   3.6   3.5'); //<ks. YrAr_Keskiarvo edellä.      
      4   :si(' 53     25     20    16    14    13    12    11.5  11.3  11    10.8  10.5  10.2  10    9.8   9.5   9     9     8     8     8     8');
      6   :si(' 84     40     33    24    20    18    17.2  17    16    15.8  15.5  15    14.5  14    14    13.5  13    12    11    11    10    10');
      10  :si(' 101    64     57    47    41    37    34    32    30    29    28    27    26    25    24    23    22    21    20    19    19    18');
      16  :si(' 218    127    108   87    76    67    62    59    55    52    50    47    45    43    41    38    36    31    27    25    24    24');
      20  :si(' 296    156    133   105   91    79    73    69    64    61    58    55    52    49    47    44    41    36    32    29    29    28');
      25  :si(' 355    183    154   121   103   91    83    79    74    71    68    64    62    58    56    53    50    44    40    38    38    37');
      32  :si(' 426    247    214   177   154   137   125   119   112   107   103   97    91    85    83    78    73    63    55    52    50    49');
      40  :si(' 623    362    304   243   211   183   166   156   144   135   129   118   112   103   98    91    84    74    66    63    63    63');
      50  :si(' 806    424    356   285   243   208   192   183   169   161   154   144   137   129   123   115   107   92    81    72    71    71');
      63  :si(' 1143   547    459   362   314   276   255   243   228   218   208   197   189   177   169   161   151   133   117   104   98    97');
      80  :si(' 1414   716    602   489   418   356   329   309   285   272   259   240   232   214   208   195   180   156   135   121   116   115');
      100 :si(' 1803   909    763   611   513   445   411   386   356   334   324   300   285   268   255   243   225   198   174   160   157   155');
      125 :si(' 2557   1310   1135  867   740   641   583   556   505   474   459   425   404   380   362   340   309   263   228   199   188   185');
      160 :si(' 3391   1636   1352  1049  881   728   662   621   574   538   513   480   452   418   398   374   345   299   263   244   240   239');
      200 :si(' 4417   2177   1800  1396  1172  980   895   840   770   716   694   640   611   565   538   505   459   392   334   295   277   273');
      250 :si(' 6264   2944   2395  1828  1511  1289  1172  1100  1000  953   909   845   801   740   705   672   611   521   459   416   401   394');
      315 :si(' 8183   4175   3397  2677  2248  1858  1716  1585  1464  1374  1310  1200  1135  1049  984   924   848   712   598   513   475   462');
      400 :si(' 10498  5646   4741  3796  3137  2634  2395  2248  2043  1918  1820  1640  1560  1418  1352  1249  1135  933   788   676   623   611');
      500 :si(' 12407  6831   5646  4520  3796  3239  2898  2719  2472  2284  2143  1979  1858  1716  1610  1487  1352  1118  924   801   743   727');
      630 :si(' 21112  10826  9091  7051  5921  4972  4520  4175  3796  3506  3275  3010  2850  2593  2433  2248  2050  1673  1383  1178  1069  1037');
     else  si(' 0      0      0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0'); end;//CASE
end else//<'OFAAgG
if fSu_Sama (suCs,su_OFAm)  then begin
{Timo Jokiniemen arvot
   CASE Isul of//,,OFAMaM keskiarvokäyrä,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
     //Aika[s]  0.01,  0.03,  0.07,   0.1,    0.2,    0.5,     1,      2,      3,      4,      5,      6,      7,       8,      9,     10,     15,     20,     30,     40,     60,     80,    100)
      4   :si('   97     70     63    54.3    46.6    39.5    36.0    32.1    30.3    29.1    28.5    27.9    27.5     26.9    26.5    26.0    25.0    24.3    23.3    22.7    22.0    21.3    21');
      6   :si('  172    132    113    94.6    79.0    65.1    56.6    50.7    46.6    45.4    43.7    42.3    41.5     40.6    40.0    39.5    37.3    36.8    35.3    34.8    33.9    33.7    33');
      10  :si('  213    173    158   130.2   113.3    94.6    83.5    74.7    70.7    66.9    65.0    63.3    62.0     60.7    60.0    59.0    55.1    53.6    51.4    50.0    47.9    46.5    46');
      16  :si('  360    293    250   233.6   204.1   176.0   155.9   138.1   129.2   124.0   123.0   116.0   113.0    111.4   109.5   108.4   101.4    98.7    93.5    91.0    86.2    83.5    82');
      20  :si('  420    340    287   270.9   239.9   204.1   185.8   164.6   155.9   147.8   144.0   140.0   137.0    134.5   131.5   129.2   120.7   116.0   111.4   107.0   101.4    98.0    94');
      25  :si('  545    455    388   369.2   327.1   282.0   253.2   227.4   215.4   204.1   197.0   193.4   189.5    185.8   183.5   180.8   169.1   164.6   155.9   151.8   141.9   140.5   139');
   32,35  :si('  700    567    481   458.0   400.3   340.5   305.8   270.9   253.2   239.9   233.0   224.3   220.0    215.4   210.0   206.9   193.4   188.3   178.4   173.7   162.4   160.5   159');
      40  :si('  850    675    577   538.3   483.3   400.3   359.4   318.4   297.6   282.0   273.0   263.7   260.0    253.2   250.0   246.5   230.4   221.3   209.7   201.4   190.9   187.0   183');
      50  :si(' 1080    850    720   676.7   599.5   510.0   458.0   405.7   379.3   364.3   349.0   336.0   328.0    322.7   314.0   309.9   289.7   278.3   263.7   253.2   236.7   232.0   224');
      63  :si(' 1500   1192    950   897.9   774.3   658.7   583.6   517.0   483.3   458.0   442.0   428.1   414.0    411.2   400.0   394.9   369.2   354.6   331.5   318.4   293.7   283.0   276');
      80  :si(' 1930   1596   1307  1159.7  1000.0   839.4   733.7   649.9   607.6   575.7   553.0   538.3   523.0    510.0   500.0   489.8   458.0   445.8   416.8   400.3   369.2   359.0   347');
      100 :si(' 2350   1861   1592  1419.2  1207.5  1000.0   885.9   784.8   733.7   695.2   664.0   649.9   627.0    615.8   605.0   599.5   553.0   538.8   503.2   476.8   451.8   432.0   418');
      125 :si(' 3000   2400   1954  1833.0  1580.6  1309.1  1159.7  1027.3   947.6   897.9   864.0   839.4   812.0    795.4   780.0   774.3   704.6   676.7   632.7   607.6   560.5   536.0   517');
      160 :si(' 3890   3105   2666  2432.0  2154.4  1760.4  1559.5  1363.0  1240.4  1175.4  1161.0  1084.1  1077.0   1027.3  1000.0   986.6   910.0   862.3   806.2   763.9   714.2   677.0   656');
      200 :si(' 5400   4294   3571  3250    2833    2300    2010    1810    1690    1640    1550    1500    1462     1420    1392    1310    1270    1170    1065     990     925     878     855');
      250 :si(' 6750   5308   4437  4100    3570    2900    2550    2200    2000    1925    1846    1790    1750     1710    1674    1600    1555    1440    1325    1250    1135    1058    1020');
      315 :si(' 8600   6750   5538  5100    4445    3635    3150    2735    2520    2366    2253    2167    2080     2000    1969    1940    1846    1730    1615    1527    1404    1327    1270');
      355 :si(' 9700   7600   6250  5800    4910    4055    3550    3048    2800    2666    2533    2453    2367     2313    2230    2200    2030    1904    1786    1712    1569    1500    1460');
      400 :si('10950   8555   7000  6550    5615    4588    3980    3476    3285    2967    2853    2766    2700     2600    2567    2500    2333    2166    1962    1884    1769    1700    1620');
      500 :si('14400  10846   8667  8000    6958    5925    5150    4563    4187    3950    3762    3619    3524     3428    3314    3270    3000    2800    2600    2433    2230    2067    1990');
      630 :si('16750  13154  10192  9560    8205    7000    6050    5368    4937    4625    4562    4250    4125     4000    3905    3850    3619    3333    3048    2867    2666    2520    2430');
     else  si( '0     0      0      0       0       0       0       0       0       0       0       0       0        0       0       0       0       0       0       0       0       0       0'); end;//CASE}
{DEVELOPER1 viilaamat, käyrien alapäiden mutkia suorittu:}
  CASE Isul of//,,OFAMaM keskiarvokäyrä,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, Tämä käytössä OFAM-aM sulakkeille.
     //Aika[s]  0.01,  0.03,  0.07,   0.1,    0.2,    0.5,     1,      2,      3,      4,      5,      6,      7,       8,      9,     10,     15,     20,     30,     40,     60,     80,    100)
      4   :si('   97     70     60    54.3    46.6    39.5    36.0    32.1    30.3    29.1    28.5    27.9    27.5     26.9    26.5    26.0    25.0    24.3    23.3    22.7    22.0    21.3    21');
      6   :si('  172    132    105    94.6    79.0    65.1    56.6    50.7    46.6    45.4    43.7    42.3    41.5     40.6    40.0    39.5    37.3    36.8    35.3    34.8    33.9    33.7    33');
      10  :si('  213    173    140   130.2   113.3    94.6    83.5    74.7    70.7    66.9    65.0    63.3    62.0     60.3    59.5    59.0    55.1    53.6    51.4    50.0    47.9    46.5    46');
      16  :si('  360    293    250   233.6   204.1   176.0   155.9   138.1   129.2   124.0   120     116.0   113.0    111.4   109.5   108.4   103      98.7    93.5    91.0    86.2    83.5    82');
      20  :si('  420    340    287   270.9   239.9   204.1   185.8   164.6   155.9   147.8   144.0   140.0   137.0    134.5   131.5   129.2   120.7   116.0   111.4   107.0   101.4    98.0    94');
      25  :si('  545    455    388   369.2   327.1   282.0   253.2   227.4   215.4   204.1   197.0   193.4   189.5    185.8   183.5   180.8   169.1   164.6   155.9   151.8   141.9   140.5   139');
   32,35  :si('  700    567    481   458.0   400.3   340.5   305.8   270.9   253.2   239.9   233.0   224.3   220.0    215.4   210.0   206.9   193.4   188.3   178.4   173.7   162.4   160.5   159');
      40  :si('  850    675    577   538.3   483.3   400.3   359.4   318.4   297.6   282.0   273.0   263.7   260.0    253.2   250.0   246.5   230.4   221.3   209.7   201.4   190.9   187.0   183');
      50  :si(' 1080    850    720   676.7   599.5   510.0   458.0   405.7   379.3   364.3   349.0   336.0   328.0    322.7   314.0   309.9   289.7   278.3   263.7   250     236.7   232.0   224');
      63  :si(' 1500   1192    950   897.9   774.3   658.7   583.6   517.0   483.3   458.0   442.0   428.1   416      411.2   400.0   394.9   369.2   354.6   331.5   315     293.7   283.0   276');
      80  :si(' 1930   1596   1307  1159.7  1000.0   839.4   733.7   649.9   607.6   575.7   553.0   538.3   523.0    510.0   500.0   489.8   458.0   440     416.8   400.3   369.2   359.0   347');
      100 :si(' 2350   1861   1592  1419.2  1207.5  1000.0   885.9   784.8   733.7   695.2   664.0   649.9   627.0    615.8   605.0   590     553.0   530     503.2   476.8   451.8   432.0   418');
      125 :si(' 3000   2400   1954  1833.0  1580.6  1309.1  1159.7  1027.3   947.6   897.9   864.0   839.4   812.0    795.4   780.0   760     704.6   676.7   632.7   607.6   560.5   536.0   517');
      160 :si(' 3890   3105   2666  2432.0  2154.4  1760.4  1559.5  1363.0  1240.4  1175.4  1130    1084.1  1050     1027.3  1000.0   970     910.0   862.3   806.2   763.9   714.2   677.0   656');
      200 :si(' 5400   4294   3571  3250    2833    2300    2010    1810    1690    1620    1550    1500    1462     1420    1392    1350    1270    1170    1065     990     925     878     855');
      250 :si(' 6750   5308   4437  4100    3570    2900    2550    2200    2050    1940    1846    1790    1750     1710    1674    1650    1555    1440    1325    1250    1135    1058    1020');
      315 :si(' 8600   6750   5538  5100    4445    3635    3150    2735    2520    2366    2253    2167    2080     2000    1969    1940    1846    1730    1615    1527    1404    1327    1270');
      355 :si(' 9700   7600   6250  5800    4910    4055    3550    3048    2800    2666    2533    2453    2367     2313    2230    2200    2030    1904    1786    1712    1569    1500    1460');
      400 :si('10950   8555   7000  6550    5615    4588    3980    3476    3200    3000    2853    2766    2700     2600    2550    2500    2333    2166    1962    1884    1769    1700    1620');
      500 :si('14400  10846   8667  8000    6958    5925    5150    4563    4187    3950    3762    3619    3524     3428    3314    3270    3000    2800    2600    2433    2230    2067    1990');
      630 :si('16750  13154  10192  9560    8205    7000    6050    5368    4937    4625    4400    4250    4125     4000    3905    3850    3619    3333    3048    2867    2666    2520    2430');
     else  si( '0     0      0      0       0       0       0       0       0       0       0       0       0        0       0       0       0       0       0       0       0       0       0'); end;//CASE}
end else//<'OFAMaM
//,,,IECg + IECgAR + IECgYR--------------------------------------------------------------------------------------
if fSu_Sama (suCs,su_IECg) or fSu_Sama (suCs,su_IECgAR) or fSu_Sama (suCs,su_IECgYR)  then BEGIN
   if fSu_Sama (suCs,su_IECgAR)                    //<fSu_..jos vaikka kutsutaan suoraan Ikt(ei..AR)
   then begin//,,IEC-gG-ALAraja,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      CASE Isul of
      {Aika[s]  0.01, 0.03,  0.07,   0.1,   0.2,   0.5,   1,     2,     3,     4,     5,     6,      7,     8,     9,    10,    15,    20,    30,    40,    60,    80,    100)}
      2   :si( '9.79   7.45   6.30   5.82   5.11   4.43   4.15   3.96   3.81   3.78   3.7    3.66   3.64    3.6    3.6    3.58  3.51   3.46   3.39   3.36   3.32   3.26   3.25'); //<+130.0 2A lisätty.
      4   :si( '26     19.2   14.3   13.2   12     10.6   9.6    8.9    8.6    8.4    8.3    8.2     8.1    8      7.9    7.8   7.7    7.6    7.4    7.35   7.2    7.15   7.1');
      6   :si( '46.3   34.2   27.5   25     21.5   17.5   15.5   13.7   12.7   12.2   12     11.7   11.4   11.2   11     10.9   10.7   10.3   10.1   9.8    9.55    9.4   9.3');
      10  :si( '104    78     64     58     51     40.7   35     30.5   28.2   26.7   25.8   24.8   24.2   23.7   23.3   22.9   21.8   20.7   20     19.3   18.4   18     17.7');
      16  :si( '167    120    88     83     70     57     51     45     42     39.5   38     37     36     35.5   34.7   34.2   32.2   31.5   29.5   28.3   26.5   26     25');
      //,,Tästä eteenpäin KOPIOITU YLÄRAJAkäyrän pisteiksi siten, että VAIN LOPPUPÄÄSSÄ EROJA,,,,,,,
      20  :si( '243    166    127    115    97     77     66     57     52     49.7   47.5   46     45     44     43.5   43     40.4   39.5   37.5   36     34.7   33.9   33.2');
      25  :si( '320    220    170    150    125    103    90     78     72     68     66     64     62     61     60     58     55     53     49     47     44.2   42.5   41.5');
   32,35  :si( '440    300    222    200    165    140    115    103    96     90     87     84     82     80     78     76     72     68     65     62     58     57     55');
      40  :si( '530    378    285    260    217    172    147    125    119    112    107    104    103    101    100    98     92     88     84     81     76     73     72');
      50  :si( '730    507    393    361    310    260    223    190    173    163    157    150    147    143    142    140    134    125    117    110    103    98     95');
      63  :si( '930    660    508    460    380    300    256    222    206    198    190    183    181    177    173    169    161    152    145    141    132    125    123');
      80  :si( '1270   900    700    630    540    443    382    323    293    278    262    257    247    243    240    236    220    207    197    187    177    167    162');
      100 :si( '1670   1150   900    810    660    515    438    377    347    330    318    303    300    292    283    281    263    250    237    224    212    205    200');
      125 :si( '2200   1560   1220   1100   970    800    665    550    492    462    442    423    410    400    383    381    350    327    303    287    270    257    250');
      160 :si( '2970   2070   1610   1420   1200   997    830    715    652    610    580    560    540    520    510    500    460    425    395    373    343    327    317');
      200 :si( '3820   2730   2195   1990   1700   1400   1190   960    855    800    760    725    700    677    660    648    585    551    500    475    445    437    407');
      250 :si( '4950   3590   2800   2520   2060   1600   1330   1130   1050   970    940    905    875    850    830    815    752    715    660    620    565    540    520');
      315 :si( '6505   4730   3820   3530   2990   2410   2040   1680   1520   1400   1320   1270   1215   1190   1150   1120   1030   980    903    852    780    742    710');
      400 :si( '8600   6270   4950   4460   3620   2790   2350   1995   1820   1690   1605   1550   1500   1450   1420   1400   1325   1220   1140   1065   965    903    870');
      500 :si( '11700  8430   6600   6000   4990   3900   3270   2790   2500   2390   2230   2160   2035   2005   1985   1920   1770   1670   1530   1430   1310   1250   1200');
      630 :si( '15000  11000  8800   8000   6600   5200   4320   3550   3200   2950   2800   2630   2540   2450   2395   2300   2080   1920   1770   1670   1550   1465   1400');
      800 :si( '20000  15300  11600  10800  8720   6800   5650   4785   4380   4100   3900   3750   3610   3530   3430   3380   3090   2865   2615   2450   2230   2085   2000');
      1000:si( '29000  20500  15750  14250  11700  8800   7400   6200   5650   5250   4930   4700   4600   4500   4400   4300   3950   3670   3350   3150   2900   2720   2580');
      1250:si( '37000  27800  22000  19800  16300  12700  10600  9000   8100   7550   7150   6800   6550   6400   6170   6000   5490   5050   4570   4230   3830   3570   3400');
     else  si( '0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0'); end;//case
                  //''IEC-gG-ALAraja
   end else begin //,,IEC-gG-YLÄraja,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      CASE Isul of
      {Aika[s]  0.01,  0.03,  0.07,  0.1,   0.2,   0.5,    1,     2,     3,     4,     5,     6,     7,     8,     9,    10,    15,    20,    30,    40,    60,    80,    100)}
      2   :si( '47.06  32.3   25.1   22.4   18.8   15.2   13.0   11.1   10.2    9.6    9.2    8.9    8.6    8.5    8.4   8.2    7.6    7.15    6.7    6.44   6.05   5.87   5.68'); //<+130.0 2A lisätty, kopio Dz´sta.
      4   :si( '97     68     52     46.7   38.3   30.2   25.9   22.4   20.6   19.5   18.7   18.1   17.7   17.1   16.9   16.4   15.5   14.6   14     13.4   12.7   12.1   11.8');
      6   :si( '147    102    77.5   69     56.5   44.5   37.4   32.4   29.8   28     26.8   26.1   25.4   24.7   24.3   23.8   22.5   21.5   20.3   19.5   18.3   17.8   17.2'); //<D1 .4/5s=46.5/28
      10  :si( '243    166    127    115    97     77     66     57     52     49.3   46.5   45.7   44     43.7   42.2   41     38.4   36.3   33.7   32.3   30.2   28.8   28');   //<D1 .4/5s=82/46.5
      16  :si( '320    220    164    150    125    103    90     78     72     68     65     64     62     61     60     58     55     53     49     47     44.2   42.5   41.5'); //<D1 .4/5s=110/65
      20  :si( '440    300    222    200    165    135    115    103    96     90     87     84     82     80     78     76     72     68     65     62     58     56.7   54.8'); //<D1 .4/5s=145/85
                                                                                                                                                            //HUOM: ''''Oli 56,7  -> Oha sekosi @@@@@
      25  :si( '530    378    285    260    217    172    147    125    119    112    107    104    103    101    100    98     92     88     84     81     76     73     72');   //<D1 .4/5s=180/110
   32,35  :si( '730    507    393    361    310    260    223    190    173    163    157    150    147    143    142    138    130    123    117    110    103    98     95');   //<D1 .4/5s=270/150
      40  :si( '930    660    508    460    380    300    256    222    206    198    190    183    181    177    173    169    161    152    145    141    132    125    123');  //<D1 .4/5s=???/???
      50  :si( '1270   900    700    630    540    443    382    323    293    278    262    257    247    243    240    236    220    207    197    187    177    167    162');  //<D1 .4/5s=470/250
      63  :si( '1670   1150   900    810    660    515    438    377    347    330    318    303    300    292    283    281    263    250    237    224    212    203    195');  //<D1 .4/5s=550/320
      80  :si( '2200   1560   1220   1100   970    800    665    550    492    462    442    423    410    400    383    381    350    327    303    283    260    247    237');  //<D1 .4/5s=840/425
      100 :si( '2970   2070   1610   1420   1200   997    830    715    652    610    580    560    540    520    510    500    460    425    395    373    343    327    317');  //<D1 .4/5s=1450/715
      125 :si( '3820   2730   2195   1990   1700   1390   1160   955    855    800    760    725    700    677    660    648    585    551    500    470    430    410    393');
      160 :si( '4950   3590   2800   2520   2060   1600   1330   1130   1040   970    940    905    875    850    830    815    752    715    660    620    565    525    502');
      200 :si( '6505   4730   3820   3530   2990   2410   2040   1680   1520   1400   1320   1270   1215   1190   1150   1120   1030   980    903    852    780    742    710');
      250 :si( '8600   6270   4950   4460   3620   2790   2350   1995   1820   1690   1605   1550   1500   1450   1420   1400   1305   1220   1140   1065   965    903    870');
      315 :si( '11700  8430   6600   6000   4990   3900   3270   2790   2510   2360   2230   2160   2065   2005   1960   1920   1770   1670   1530   1430   1320   1250   1200');
      400 :si( '15000  11000  8800   8000   6600   5200   4320   3550   3200   2950   2800   2630   2540   2450   2395   2300   2080   1920   1770   1670   1550   1465   1400');
      500 :si( '20000  15300  12000  10800  8720   6800   5650   4785   4380   4100   3900   3750   3610   3530   3430   3350   3090   2865   2615   2450   2230   2085   2000');
      630 :si( '29000  20500  15750  14250  11700  8800   7400   6200   5650   5300   4930   4800   4730   4530   4410   4300   3950   3670   3350   3150   2900   2720   2580');
      800 :si( '37000  27800  22000  19800  16300  12700  10600  9000   8100   7550   7150   6800   6550   6400   6170   6000   5490   5050   4570   4230   3830   3570   3400');
      1000:si( '49000  34500  26700  24000  19600  15300  13000  11300  10400  9700   9200   8700   8400   8150   7800   7550   6700   6250   5600   5200   4700   4370   4070');
      1250:si( '68000  49500  39200  35500  29100  23000  19300  16350  14850  13950  13100  12500  12050  11700  11300  10800  9750   8800   7800   7150   6400   5900   5600');
      else si( '0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0'); end;//case
   end; //''IEC-gG-YLÄraja
//'''IECg + IECgAR + IECgYR--------------------------------------------------------------------------------------
END else//,,IEC-Dz-ALAraja
   if fSu_Sama (suCs,su_IECdAR)                    //<fSu_..jos vaikka kutsutaan suoraan Ikt(ei..AR)
   then begin//,,IEC-Dz-ALAraja,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, 2A lisätty 29.8.2014/130.0
      CASE Isul of
      {Aika [s] 0.1,    0.2,   0.5,    1,     2,     3,     4,      5,      6,     7,      8,     9,   10,     15,    20,    30,    40,    60,    80,    100)}
      2   :si( '6.0     5.28   4.66    4.31   4.05   3.98   3.91    3.80    3.82   3.79    3.79   3.74  3.74    3.66   3.63   3.57   3.57   3.51   3.45   3.44'); //<+130.0 2A lisätty.
      4   :si( ' 14     12     10.28   9.55   9      8.7    8.56    8.45    8.3    8.15    8.1    8.06   8      7.8    7.7    7.6    7.5    7.4    7.3    7.2');
      6   :si( ' 26     22     18     15.7   13.8   12.95  12.4    12.1    11.8   11.5    11.4   11.2   11     10.5   10.4   10.1   10      9.8    9.6    9.55');
      10  :si( ' 60     50.5   40.5   34.3   29.8   27.3   26      24.8    24.1   23.5    22.9   22.7   22.3   21.2   20.2   19     18.7   18     17.3   17.1');
      16  :si( ' 85     72     58     51     45.5   42.3   41      39.7    38.3   37.7    37.2   36.2   35.8   34     32.1   30.8   29.8   28     27     26.1');
      20  :si( '113     96.5   77.5   65.5   56.5   52     49.3    47.3    45.3   44.3    44     43.7   43.2   41     39.8   37.8   36.3   34.7   34     33.3');
   25,32  :si( '154    130    106     92     80     74.8   71      67.5    65.5   64      62.5   62     60     56.5   54     50.5   48     45.7   44     42.5');
   35,40  :si( '255    217    178    148    128    118    109     104     101     98      95     93     91     86     81     75     72     68     65     63');
      50  :si( '349    298    255    215    180    167    159     152     148    144     141    139    137    129    121    113    108    101     97.5   93');
      63  :si( '473    393    310    262    230    213    201     193     189    184     180    177    173    163    157    147    141    132    128    124');
      80  :si( '617    530    440    379    320    287    268     254     248    243     238    232    229    215    207    197    187    173    167    160');
      100 :si( '847    697    535    450    390    361    341     327     315    307     300    295    290    272    260    246    237    224    215    210');
      else si( '0      0      0      0      0      0      0       0       0      0       0      0      0      0      0      0      0      0      0       0');  end;//case
                  //''IEC-Dz-ALAraja
   end else begin //,,IEC-Dz-YLÄraja,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      CASE Isul of
      {Aika [s] 0.1,    0.2,   0.5,    1,     2,     3,     4,       5,      6,     7,    8,      9,    10,    15,    20,    30,    40,    60,    80,    100)}
      2   :si( '  22.7   19.06  15.4   13.0   11.7   10.3    8.9     8.52    8.25   8.0    7.81   7.65  7.62   7.04   6.68    6.3    6.07   5.77   5.37   5.28'); //<+130.0 2A lisätty.
      4   :si( '  46.7   38.7   30.3   25.5   22     20.3   19.3    18.7    18     17.3   17.1   16.8   16.5   15.5   14.8   14     13.4   12.5   12.3   11.9');
      6   :si( '  70.1   57.5   43.9   38     32.5   30     28.5    27.3    26.5   25.8   25.4   24.8   24.3   23     22     20.7   20     18.8   18.1   17.5');
      10  :si( ' 113     96.5   77.5   65.5   56.5   52     49.3    47.3    45.3   44     43     42     41.3   38.5   36.7   34.3   32.7   30.7   29.1   28.1');
      16  :si( ' 154    130    106     92     80     74.8   71      67.5    65.5   64     62.5   62     60     56.5   54     50.5   48     45.7   44     42.5');
      20  :si( ' 198    171    141    121    104     95     89      85      83     81     78     77     76     71     68     64.5   62     58     56.5   55.5');
   25,32  :si( ' 264    223    177    151    131    122    117     112     109    107    104    102.5  101     95     91     85     82     79     74     73');
   35,40  :si( ' 445    367    293    251    211    195    181     171     166    160    156    153    149    137    128    119    112    104     98.5   95');
      50  :si( ' 617    530    440    379    320    287    270     260     248    243    238    232    229    215    207    197    187    173    167    160');
      63  :si( ' 847    697    535    450    390    361    341     327     315    307    300    295    290    272    260    246    237    222    212    203');
      80  :si( '1100    950    780    651    535    487    459     434     417    401    390    381    373    344    323    300    281    259    247    236');
      100 :si( '1490   1270   1006    865    730    670    620     590     570    551    530    520    510    473    440    402    382    354    338    323');
      else si( '0      0      0       0      0      0      0       0       0      0      0      0      0      0      0      0      0      0      0       0');  end;//case
end;//''IEC-Dz-YLÄraja
//---------------------------------------------------------------------------------------------------------------
   if PalAika //<,,Halutaan etsiä TUNNETTUA VIRTAa vastaava AIKA halutulle sulakkeelle ISUL,,,,,,,,,,,,,,,,,,,,,,
   then begin //  =Etsitään ko. VIRTApiste (isompi t.sama) SEKÄ SEUR.PIENMPI ja lasketaan niiden vastaava AIKA
              //,,,os2 :een PIENEMMÄN virran =isomman AJAN os.  os1 :een ISOMMAN virran =pienemmän AJAN os @@@@@@
      qVIRTA := VIRTA;
      i := 0;   os2 := i;   Ik2 := 0;               //<Aloitetaan ekasta alkiosta = SUURIN virta-arvo =PIENIN AIKA
      repeat i := i+1;                 //<,Etsitään sulaketaulukosta VIRTAA vastaava tai PIENMPI arvo @@@@@@@@@@@
             if IkAr[i] >0  then begin
                Ik2 := IkAr[i];
                os2 := i;   end;                   //<os2 = ETSITTY tai PIENEMPI VIRTA-arvo @@@@@@@@@@@@@@@@@@@@@
      until (Ik2<=qVIRTA) and (Ik2>0)  or (i=fMaxOs);

      if Ik2=qVIRTA
      then fnc := fTim(os2)
      else begin
         if os2=1                     //<ETSITTY VIRTA on ISOMPI kuin tlkn ISOIN virta IkAr[1] ==================
         then begin os1 := 1;                      //<ISOMMAN VIRRAN os1:een, PIENMÄN os2 :een jotta kulmakerr.
                    os2 := 1;                      //',mahista laskea.
              repeat os2 := os2+1;                 //<,Jos vaikka peräkkäiset arvot olivat samoja ###############
              until (IkAr[os2]<IkAr[os1]) and (IkAr[os2]>0)  or (os2=fMaxOs);  end
         else begin  os1 := os2;      //<ETSITTY VIRTA on ISOMPI kuin IkAr[os2] =================================
              repeat os1 := os1-1;                 //<Os1 = ISOMMAN VIRRAN os os1:een, PIENMÄN os2 :een #########
              until (IkAr[os1]>IkAr[os2]) and (IkAr[os1]>0)  or (os1=1);  end; //<'JosVaikka peräkk.olivat samoja
                                                   //,,,     Ik2-Ik1   Ik2-Ik                Ik2-Ik
            Ik1 := IkAr[os1];   Ik2 := IkAr[os2];  //,,,     ------- = ------ => t = (t1-t2) ------- + t2
            Tim1 := fTim(os1);  Tim2 := fTim(os2); //,,,     t1 - t2   t - t2                Ik2-Ik1
//          fnc := (fTim(os2)-fTim(os1)) * ((qVIRTA-Ik1)/(Ik2-Ik1)) + fTim(os1); //<Antaa saman tuloksen, koklattu
          //fnc := (Tim1-Tim2) * ((Ik2-qVIRTA)/(Ik2-Ik1)) + Tim2;                //< -6.0.3
            fnc := ( (qVIRTA-Ik2)/(Ik2-Ik1) ) *(Tim2-Tim1) +Tim2;                //<,+6.0.3  
            if fnc<0  then fnc := 0.000999;                                      //< +6.0.3  Tutkittavissa (eiKäytetty)
      end;//else ': (t-t2)/(Ik-Ik2)=(t2-t1)/(Ik2-Ik1) => t = [(Ik-Ik2)/Ik2-Ik1)] *(t2-t1) +t2  =+6.0.3
   end//if PalAika  'Sama, onko Ik-Ik2 vai Ik2-Ik, kunhan sama logiikka muissakin.!!!!!!!!!!!
   else begin //<,,Halutaan etsiä TUNNETTUA AIKAa vastaava VIRTA,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
              //,,,Etsitään ko.pisteen viereiset VIRTA-arvot ja lasketaan niiden perusteella VIRTAA vastaava AIKA
              //,,,os1 :een PIENEMMÄN virran =isomman AJAN os.  o2 :een ISOMMAN virran =pienemmän AJAN os @@@@@@@
      i := 0;  os1 := 1;                           //<Ekassa alkiossa AINA PIENIN aika-arvo = SUURIN VIRTA <<<<<<
      repeat i := i+1;                     //,,,IkAr[1] > IkAr[MaxOs] @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
             ar := fTim(i);                //,,,fTim(1) < fTim(MaxOs) @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
             if IkAr[i] >0  then os1 := i;         //<Viimeisin osoite talteen (saataa olla < AIKA), ellei 0
      until (ar>=AIKA) or (i=fMaxOs);      //<'''Etsitään OS-arvo, jonka Tim >= etsitty AIKA @@@@@@@@@@@@@@@@@@@@
                                           //''''@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if fTim(os1)=AIKA                            //<Tämä, jos AIKA=fTim[1] =Alkusijoitus, ks. edellä
      then fnc := IkAr[os1]
      else begin
         if os1=1                 //,TUNNETTU AIKA on pienempi kuin tlkn pienin aikasarake =[1] =================
         then begin os2 := 1;                      //<ISOMMAN VIRRAN os os1:een ja PIENEMMÄN VIRRAN os os2:een,
                    os1 := 1;                      // jotta kulmakerr.mahista laskea. @@@@@@@@@@@@@@@@@@@@@@@@@@@
              repeat os1 := os1+1;                 //<,Jos vaikka peräkkäiset arvot olivat samoja ###############
              until (IkAr[os1]<IkAr[os2]) and (IkAr[os1]>0)  or (os1=fMaxOs);  end
         else begin  os2 := os1;  //<TUNNETTU AIKA on pienpi kuin os1 ===========================================
              repeat os2 := os2-1;                 //<,Jos vaikka peräkkäiset arvot olivat samoja ###############
              until (IkAr[os2]>IkAr[os1]) and (IkAr[os2]>0)  or (os2=1);  end;
                                                   //,,,     Ik2-Ik1   Ik2-Ik                        t -t2
            Ik1 := IkAr[os1];                      //,,,     ------- = ------ => Ik = Ik2 - (Ik2-Ik1)-----
            Ik2 := IkAr[os2];                      //,,,     t1 - t2   t - t2                        t1-t2
                          {ar := Ik2-Ik1;
                           rr := AIKA-fTim(os2);
                           a :=  fTim(os1);
                           r :=  fTim(os2);
                           fnc := Ik2 - ar*rr / (a-r); //}
            fnc := Ik2 - (Ik2-Ik1)*(AIKA-fTim(os2)) / (fTim(os1)-fTim(os2));
      end;//else
   end;//if PalAika else
   result := fnc;
end;//SULfncX
//============================================================================================================
PROCEDURE SULfncOFAg (Isul :Integer;   VAR ka10,kb10,kc10, ka3,kb3,kc3,
                                        ka1,kb1,kc1, ka03,kb03,kc03  :Real);
PROCEDURE s (a1,b1,c1, a2,b2,c2, a3,b3,c3, a4,b4,c4 :Real);
BEGIN
 ka10 := a1;  kb10 := b1;  kc10 := c1;   ka3 :=  a2;  kb3 :=  b2;  kc3 :=  c2;
 ka1 :=  a3;  kb1 :=  b3;  kc1 :=  c3;   ka03 := a4;  kb03 := b4;  kc03 := c4;
END;
BEGIN{SULfncOFAg}  CASE Isul OF            //Oikosulun kestoaika = 0.1-15s
     //,,,Järjestyksessä:  PITKÄ AIKA........LYHYT AIKA -alueen FNCt,,,,,,,,,
     6 :s (114366.679 ,-0.6045   ,0.2238  ,  1540.43868 ,-0.359    ,0.11518,
           42.5602148 ,-0.18508  ,0.07661 ,  1.65069695 ,-0.07382  ,0.0106 );
    10 :s (6428.17733 ,-0.2373   ,0.11398 ,  2144.53349 ,-0.2036   ,0.06823,
           370.2606   ,-0.1571   ,0.03468 ,  69.9438    ,-0.12     ,0.01976);
    16 :s (1454.14892 ,-0.1057   ,0.17806 ,  215.1803   ,-0.0733   ,0.08196,
           35.0293966 ,-0.0484   ,0.02483 ,  24.682613  ,-0.0448   ,0.02025);
    20 :s (1109.2377  ,-0.0832   ,0.1519  ,  266.748332 ,-0.06333  ,0.0765,
           54.98108   ,-0.04546  ,0.03485 ,  16.659337  ,-0.03494  ,0.02057);
    25 :s (1853.13438 ,-0.08194  ,0.1967  ,  184.460371 ,-0.05271  ,0.081196,
           36.7189924 ,-0.03641  ,0.03616 ,  11.4652    ,-0.02754  ,0.02157);
    32 :s (1218.11426 ,-0.04979  ,0.1536  ,  266.677022 ,-0.03730  ,0.0715,
           61.4464699 ,-0.02748  ,0.03024 ,  23.6217039 ,-0.02248  ,0.01815);
    40 :s (592.848109 ,-0.0366   ,0.1521  ,  168.99658  ,-0.028    ,0.07879,
           35.9241563 ,-0.01955  ,0.03398 ,  13.1357219 ,-0.01541  ,0.02118);
    50 :s (978.368249 ,-0.03174  ,0.168   ,  193.794632 ,-0.02295  ,0.08708,
           29.4126247 ,-0.01471  ,0.03026 ,  11.9071799 ,-0.011889 ,0.02057);
    63 :s (704.476996 ,-0.02322  ,0.1583  ,  183.764439 ,-0.01757  ,0.08659,
           30.0236265 ,-0.01146  ,0.03461 ,  11.2285907 ,-0.009    ,0.02278);
    80 :s (573.349108 ,-0.01653  ,0.1568  ,  155.525083 ,-0.01247  ,0.08182,
           30.5286    ,-0.00844  ,0.03203 ,  11.375355  ,-0.00661  ,0.01735);
   100 :s (1213.87798 ,-0.0151   ,0.1613  ,  272.157233 ,-0.01138  ,0.09042,
           34.8681369 ,-0.00721  ,0.03735 ,  9.80911    ,-0.005273 ,0.02084);
   125 :s (503.535124 ,-0.0092   ,0.1653  ,  127.9585   ,-0.006766 ,0.08356,
           28.22019   ,-0.00464  ,0.03197 ,  11.9030843 ,-0.00375  ,0.02005);
   160 :s (813.579742 ,-0.007875 ,0.1693  ,  163.354358 ,-0.00564  ,0.08157,
           34.1198424 ,-0.00391  ,0.03828 ,  8.2163483  ,-0.002718 ,0.01753);
   200 :s (1016.88621 ,-0.006807 ,1.2732  ,  124.660213 ,-0.00401  ,0.08353,
           25.4775    ,-0.00269  ,0.003444,  7.60981613 ,-0.001955 ,0.01765 );
   250 :s (1151.28398 ,-0.0051   ,0.2013  ,  133.425946 ,-0.003266 ,0.09037,
           22.2299525 ,-0.00207  ,0.03709 ,  6.58508293 ,-0.001477 ,0.01794);
   315 :s (323.82862  ,-0.00282  ,0.1689  ,  75.6872918 ,-0.00195  ,0.05764,
           37.4303113 ,-0.001634 ,0.03462 ,  11.5565241 ,-0.001231 ,0.01823);
   400 :s (484.295    ,-0.002276 ,0.1503  ,  183.172231 ,-0.001848 ,0.102,
           17.464892  ,-0.00101  ,0.02685 ,  9.7764889  ,-0.000861 ,0.01575);
   500 :s (756.224345 ,-0.001911 ,0.3544{&}, 756.224345 ,-0.001911 ,0.3544{&},{2x10-.3}
           6.58853735 ,-0.0006253,0.01388 ,  3.79503    ,-0.0005361,0.007388);{3-.3,.3-03}
ELSE  IF Isul<6  // 4A tai 630>
   THEN s (200748.09 ,-0.9237    ,0.6643{&}, 200748.09  ,-0.9237   ,0.6643{&},
          //'''>>> Aivan tarkka koko alueella 1.0-10s <<<<<<<<<<<<<<<<<<<<'''
          111.534231 ,-0.3324    ,0.06968 ,  13.7443088 ,-0.21     ,0.0234)
   ELSE s (258.907117,-0.00099   ,0.1481  ,  96.1528843 ,-0.000772 ,0.07587,
           25.3062019,-0.0005455 ,0.02907 ,  14.9095609 ,-0.00048  ,0.02212); END;
END;//SULfncOFAg
//===============================================================================================================
{su_OFAg su_OFAm   su_IECg su_IECgAR su_IECgYR   su_IECd su_IECdAR su_IECdYR
 ''''''' 4...630   '''''''''''''''''' 4...1250   ''''''''''''''''''' 4...100}                     //+6.2.0
FUNCTION SulRangeOK (CONST suCs :string;  CONST Isul :integer) :boolean; //TRUE jos SULAKEKOKO = OK ao. tyypillä.
      VAR fnc :boolean;      begin
   fnc := false;
   if fSu_PerusSama (suCs,su_IECd) and (Isul>=2) and (Isul<=100 )  OR //fSu_PerusSama () = su_OFAgAR :stä su_OFAg jne.  <,,130.0: 4A=>2A
      fSu_PerusSama (suCs,su_IECg) and (Isul>=2) and (Isul<=1250)  OR
      fSu_PerusSama (suCs,su_OFAg) and (Isul>=2) and (Isul<=630 )  OR //<''+130.0:  Näissä 4A=>2A
      fSu_PerusSama (suCs,su_OFAm) and (Isul>=4) and (Isul<=630 )
      then fnc := true;
   result := fnc;
end;
//===============================================================================================================
FUNCTION IkT (CONST suCs :string;  Isul :Integer;  Tim :Real) :Real; //<Ik, jolla IsulToimii ajassa 0.03-10s
        VAR k1,k2,k3, ka10,kb10,kc10, ka3,kb3,kc3,
                      ka1,kb1,kc1, ka03,kb03,kc03 :Real;   //ik :real; -6.0.3
   PROCEDURE sijalue;
      PROCEDURE s (t03,t1,t3 :Real);
         PROCEDURE sijK (a1,a2,a3 :Real);    BEGIN
            k1 := a1;  k2 := a2;  k3 := a3;   END;
      BEGIN//s
         IF Tim<t03  THEN  sijK (ka03,kb03,kc03)  ELSE    //pieniT=isoIK<<<<<
         IF Tim<t1   THEN  sijK (ka1 ,kb1 ,kc1 )  ELSE
         IF Tim<t3   THEN  sijK (ka3 ,kb3 ,kc3 )  ELSE
                           sijK (ka10,kb10,kc10);  END;//s
   BEGIN//sijalue       //>>>>>>>>>>>Oikosulun kestoaika = 0.03-10s<<<<<<<<<<
      CASE Isul OF      //<Jos t > ao.XX, ko.fnc (.03-10s)antaaTarkemman AJAN
                        //Raja-arvot saatu ajamalla KOESULF1.EXE, Arvot t [s]
                        //{&} = SULfncOFAg :ssa ERI ALUEITA SAMALLA FNC:lla<<
        //>>>>>>>LYHYT_________PITKÄaika: Vaihtokohdat (mielivalt.)<<<<<<<<<<
         6 :s (  0.145,  0.97,   2.8 );     80 :s (  0.33,   0.96,   2.7 );
        10 :s (  0.33,   0.93,   2.67);    100 :s (  0.32,   0.97,   2.71);
        16 :s (  0.41,   0.96,   2.74);    125 :s (  0.34,   0.99,   2.72);
        20 :s (  0.33,   0.95,   2.71);    160 :s (  0.32,   0.96,   2.73);
        25 :s (  0.33,   0.96,   2.75);    200 :s (  0.39,   0.85,   3.15);
        32 :s (  0.34,   0.95,   2.7 );    250 :s (  0.32,   0.97,   2.78);
        40 :s (  0.33,   0.96,   2.71);    315 :s (  0.33,   0.96,   2.73);
        50 :s (  0.29,   0.96,   2.73);    400 :s (  0.36,   0.98,   2.69);
        63 :s (  0.33,   0.96,   2.71);    500 :s (  0.18,   0.35{?},0.35{&});
                                                      //ARVIO'''''   ''''<<<<
      ELSE IF Isul<6  THEN s (  0.33,   1.11{&},1.11{&})             //<   4A
                      ELSE s (  0.35,   0.95,   2.72);  END;         //< 630A
   END;//sijalue         RAJA-ARVOT''''''''t [s] mistä läht.seurFNCtarkempi
//............................................
BEGIN//IkT
  {if Isul<=0          //< +2.0.1                           //<,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,-6.2.0
      then result := 0 //< +2.0.1
    //ELSE result := SULfncX (suCs,FALSE,Isul,1*Tim,ik)     //<FALSE=eiPALAIKA =Ik  -6.0.3
      ELSE result := SULfncX (suCs,FALSE,Isul,1*Tim,0)      //<FALSE=eiPALAIKA =Ik  +6.0.3}
   if NOT SulRangeOK (suCs,Isul)                            //<,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,+6.2.0
      then result := 0
      ELSE result := SULfncX (suCs,FALSE,Isul,1*Tim,0)      //<FALSE=eiPALAIKA =Ik  +6.0.3
END;//IkT            1*Tim koska jostain syystä '''''SULfncX:ssä Tim muuttuu 0:ksi joskus ##########
//===============================================================================================================
{su_OFAg su_OFAm   su_IECg su_IECgAR su_IECgYR   su_IECd su_IECdAR su_IECdYR}
//,,Ei käytetty muualta kuin Ikt_R,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
FUNCTION IktYR (suCs :string;  Isul :Integer;  Tim :Real) :Real;      VAR arvo,kf :real;      begin
   arvo := IkT (suCs,Isul,Tim);   kf := 1;
   if  fSu_PerusSama (suCs,su_IECg)   then  suCs := su_IECgYR    else //<fSu_Perus palauttaa YR/AR:stä perustyypin
   if  fSu_PerusSama (suCs,su_IECd)   then  suCs := su_IECdYR    else // esim. su_IECdYR -> su_IECd ##############
   if  fSu_sama (suCs,su_OFAg)  or  fSu_sama (suCs,su_OFAm)
     //then  kf := 1 / (1- suToler/100);       //<= 1/0.9 =Toler.verran OIK. KESKIARVOKÄYRÄSTÄ=Ik:ta kasvatetaan
       then  kf := 1 + suToler/100;            //<= 1.1 =Toler.verran OIK. KESKIARVOKÄYRÄSTÄ=Ik:ta kasvatetaan
   arvo := arvo *kf;                           //'Muilla AR tulee SUCSn mukaan
   result := arvo;
end;                                                        //,,Ik, jolla IsulToimii ALArajallaan ajassa 0.03-10s
FUNCTION IktAR (suCs :string;  Isul :Integer;  Tim :Real) :Real;      VAR arvo,kf :real;      begin
   arvo := IkT (suCs,Isul,Tim);   kf := 1;
   if  fSu_PerusSama (suCs,su_IECg)   then  suCs := su_IECgAR    else //<fSu_Perus palauttaa YR/AR:stä perustyypin
   if  fSu_PerusSama (suCs,su_IECd)   then  suCs := su_IECdAR    else // esim. su_IECdYR -> su_IECd ##############
   if  fSu_sama (suCs,su_OFAg)  or  fSu_sama (suCs,su_OFAm)
     //then  kf := 1 / (1+ suToler/100);       //<= 1/1.1 =Toler.verran VAS. KESKIARVOKÄYRÄSTÄ=Ik:ta pienennetään
       then  kf := 1 - suToler/100;            //<= 0.9 =Toler.verran VAS. KESKIARVOKÄYRÄSTÄ=Ik:ta pienennetään
   arvo := arvo *kf;                           //'Muilla AR tulee SUCSn mukaan
   result := arvo;
end;
       //,,,,,ALA/YLÄraja/KeskiArvo -Tik (SULtypin mukaan),,,,,,,,,,,,,,,,,esim. FNC:lla SulTypOKrajat ##########
FUNCTION Ikt_R (CONST suCs :string;  Isul :Integer;  Tim :Real) :Real;      VAR fnc :real;
begin    if       fSu_sama (suCs,su_IECgAR)  or  fSu_sama (suCs,su_IECdAR)
         then fnc := IktAR (suCs,Isul,Tim)
         else if  fSu_sama (suCs,su_IECgYR)  or  fSu_sama (suCs,su_IECdYR)
         then fnc := IktYR (suCs,Isul,Tim)
         else fnc := IkT   (suCs,Isul,Tim);                          //<OFAg/m KESKIARVOKÄYRÄLLE #############
         result := fnc;
end;
//===============================================================================================================
FUNCTION Tik (CONST suCs :string;  Isul :Integer;  Ik :Real) :Real; //<Tik=Oikosulun kestoaika (=0.03-10s) Ik :lla
      VAR k1,k2,k3, ka10,kb10,kc10, ka3,kb3,kc3,
          ka1,kb1,kc1, ka03,kb03,kc03, fnc :Real;
  PROCEDURE sijalue;
    PROCEDURE s (ir03,ir1,ir3 :Real);
       PROCEDURE sijK (a1,a2,a3 :Real);   BEGIN
       k1 := a1;  k2 := a2;  k3 := a3;     END;
    BEGIN //s
       IF Ik>ir03  THEN  sijK (ka03,kb03,kc03)  ELSE //<=  ir03 > ir1 > ir3
       IF Ik>ir1   THEN  sijK (ka1 ,kb1 ,kc1 )  ELSE
       IF Ik>ir3   THEN  sijK (ka3 ,kb3 ,kc3 )  ELSE
                         sijK (ka10,kb10,kc10);
    END;//s             //>>>>'isoIK=pieniT<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  BEGIN //sijalue       //>>>>>>>>>>>Oikosulun kestoaika = 0.03-10s<<<<<<<<<<
      CASE Isul OF      //<Jos Ik > ao.XX, ko.fnc (.03-10s)antaaTarkemmanAJAN
                        //Raja-arvot saatu ajamalla KOESULF1.EXE, Arvot I [A]
                        // {&} = SULfncOFAg :ssa ERI ALUEITA SAMALLA FNC:lla<
        //>>>>>>>LYHYT_________PITKÄaika: Vaihtokohdat (mielivalt.)<<<<<<<<<<
         6 :s (  34.2,   20.9,   17.7);     80 :s ( 548  ,  415  ,  327.6);
        10 :s (  45.4,   38.4,   33  );    100 :s ( 666.5,  504.3,  408.3);
        16 :s (  93.3,   75  ,   60  );    125 :s ( 977.1,  732.3,  574.2);
        20 :s ( 114.9,   90.4,   73  );    160 :s (1225.7,  926.8,  731.8);
        25 :s ( 133.1,  101.5,   80.4);    200 :s (1556.3, 1269  ,  924.9);
        32 :s ( 192.6,  153.1,  123.9);    250 :s (2105  , 1538.8, 1196  );
        40 :s ( 245.3,  187.9,  148.8);    315 :s (2969.9, 2273.9, 1715.3);
        50 :s ( 320.2,  235.1,  187.3);    400 :s (3916.2, 2890.1, 2306.6);
        63 :s ( 402.3,  304.2,  242.1);  //500 :s (5937.2,  750  ,  750  );
                                           500 :s (5937.2,  12500,  750  );
{500A I= 5937.18  t1-t2=  0.165 - 0.175= -0.010 = 1_2 Minimi= -0.010s 5937.177A   =KoeSul1u.EXE :llä
      I=12500.08  t1-t2=  0.017 - 0.354= -0.338 = 2_3         -0.338s12500.080A
      I=  750.10  t1-t2=180.704 -180.704= 0.000 = 3_4          0.000s  750.100A}
                                                       //ARVIOT''''''  '''''''<<<<<<<<<<<<<<<<<<<<<<
      ELSE IF Isul<6  {  4A} THEN s (  18.2,   14.1{&}, 6.1{&})
                      {630A} ELSE s (7936.8, 6073.6, 4652.9);  END;
   END;//sijalue           RAJA-ARVOT''''''Ik[A] mistä läht.seurFNCtarkempi <<<<<<<<<<<<<<<<<<<<<<<<
//............................................
BEGIN//Tik
 //if Isul<=0          //< +2.0.1                  //< -6.2.0
   if NOT SulRangeOK (suCs,Isul)                   //< +6.2.0
      then fnc := 0    //< +2.0.1,  fnc=+6.2.15
      ELSE fnc := SULfncX (suCs,TRUE,Isul,0,Ik);   //< TRUE=PALAIKA
   result := fnc;
END;//Tik
//===============================================================================================================
//,,Ei käytetty muualta kuin Tik_R. Nyt myös EdvLaskSij26-INC :ssä +6.0.3 ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
FUNCTION TikYR (suCs :string;  Isul :Integer;  Ik :Real) :Real;      VAR arvo,kf :real;      begin
                                                        //''Tim, jonka sulake kestää YLÄrajallaan virtaa Ik.
      {Aika[s]  0.01, 0.03,   0.07,  0.1,   0.2,   0.5,    1,     2,     3,     4,     5,     6,     7,     8,     9,    10,    15,    20,    30,    40,    60,    80,    100)
      1250:si( '68000  49500  39200  35500  29100  23000  19300  16350  14850  13950  13100  12500  12050  11700  11300  10800  9750   8800   7800   7150   6400   5900   5600');
             ^1   ^2  ^3                                        ^4                                                                                                      ^5     ^6}
                                            {arvo := Tik (su_IECgYR,1250, 70000); //< ^1  t=0.00783... =OK
                         if arvo<0  then ;   arvo := Tik (su_IECgYR,1250, 68000); //< ^2  t=0.01       =OK
                         if arvo<0  then ;   arvo := Tik (su_IECgYR,1250, 60000); //< ^3  t=0.01864... =OK
                         if arvo<0  then ;   arvo := Tik (su_IECgYR,1250, 17000); //< ^4  t=1.77966... =OK
                         if arvo<0  then ;   arvo := Tik (su_IECgYR,1250, 5800 ); //< ^5  t=86.6666... =OK
                         if arvo<0  then ;   arvo := Tik (su_IECgYR,1250, 5000 ); //< ^6  t=140...     =OK
                         if arvo<0  then ;}
   kf := 1;
   if  fSu_PerusSama (suCs,su_IECg)   then  suCs := su_IECgYR    else //<fSu_Perus palauttaa YR/AR:stä perustyypin
   if  fSu_PerusSama (suCs,su_IECd)   then  suCs := su_IECdYR    else // esim. su_IECdYR -> su_IECd ##############
   if  fSu_sama (suCs,su_OFAg)  or  fSu_sama (suCs,su_OFAm)
     //then  kf := 1 / (1+ suToler/100);       //<= 1/1.1 =Toler.verran VAS. KESKIARVOKÄYRÄSTÄ=Ik:ta pienennetään
       then  kf := 1 - suToler/100;            //<= 0.9 =Toler.verran VAS. KESKIARVOKÄYRÄSTÄ=Ik:ta pienennetään
   arvo := Ik*kf;                              //'Muilla AR tulee SUCSn mukaan.   arvo := Ik*kf =+6.2.15
   arvo := Tik (suCs,Isul,arvo);
   result := arvo;
end;
FUNCTION TikAR (suCs :string;  Isul :Integer;  Ik :Real) :Real;      VAR arvo,kf :real;      begin
   kf := 1;                                                   //''Tim, jonka sulake kestää ALArajallaan virtaa Ik
   if  fSu_PerusSama (suCs,su_IECg)   then  suCs := su_IECgAR    else //<fSu_Perus palauttaa YR/AR:stä perustyypin
   if  fSu_PerusSama (suCs,su_IECd)   then  suCs := su_IECdAR    else // esim. su_IECdYR -> su_IECd ##############
   if  fSu_sama (suCs,su_OFAg)  or  fSu_sama (suCs,su_OFAm)
     //then  kf := 1 / (1- suToler/100);       //<= 1/0.9 =Toler.verran OIK. KESKIARVOKÄYRÄSTÄ=Ik:ta kasvatetaan
       then  kf := 1 + suToler/100;            //<= 1.1 =Toler.verran OIK. KESKIARVOKÄYRÄSTÄ=Ik:ta kasvatetaan
   arvo := Ik*kf;                              //'Muilla AR tulee SUCSn mukaan.   arvo := Ik*kf =+6.2.15
   arvo := Tik (suCs,Isul,arvo);
   result := arvo;
end;
       //,,,,,ALA/YLÄraja/KeskiArvo -Tik (SULtypin mukaan),,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
FUNCTION Tik_R (CONST suCs :string;  Isul :Integer;  Ik :Real) :Real;
begin    if       fSu_sama (suCs,su_IECgAR)  or  fSu_sama (suCs,su_IECdAR)
         then result := TikAR (suCs,Isul,Ik)
         else if  fSu_sama (suCs,su_IECgYR)  or  fSu_sama (suCs,su_IECdYR)
         then result := TikYR (suCs,Isul,Ik)
         else result := Tik   (suCs,Isul,Ik);                           //<OFAg/m KESKIARVOKÄYRÄLLE #############
end;
//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ'''SULfnc.VS
//===============================================================================================================
//VANHA:         //,,Palauttaa SULAKETTA (Isul) vastaavan MIN.OIKOS.VIRRAN (SÄL tai KUL+TIM<=5s)
                 //,,'G'=OFAAgG   'I'=IECgG   'M'=OFAMaM   'Z'=Diazed   'B,C,D'=Johdonsuojakatkaisijoita =suojaC
                 //  joista tarvitaan NYT VAIN OFAAgG ja OFAMaM #################################################
                 //,,,,NYT olisi mahista kutsua IkT () FNC :ta, koska se nyt kattava = MYÖS IEC #################

//UUSIIN:                         //,,Palauttaa SULAKETTA (Isul) vastaavan MIN.OIKOS.VIRRAN (SÄL tai KUL+TIM<=5s)
                                  //,,OFAAgG, OFAMaM, IECgG, IECdZ tai  'B,C,D'=Johdonsuojakatkaisijoita
                                  //  joista VAIN OFAAgG ja OFAMaM :lle huomioitava TOLERANSSI 10% !!!!!!!!!!!!!!
                                  //,,IECg/d ohjataan AUTOMAATTISESTI YR :ksi VAIKKA olisi KUTSUSSA AR ##########
{su_OFAg su_OFAm   su_IECg su_IECgAR su_IECgYR   su_IECd su_IECdAR su_IECdYR
 '''''''-----------''''''' = Valittu Edv:n napeilla
 '''''''-'''''''---''''''' = Valittu MootFrm:n ComBx}
FUNCTION Isnik (suCs :string;  Isul :Integer;  Tim :Real) :Real;       VAR Cjk :Char;

  {function Iyr_fJkTim :real;      VAR Iyr :real;  Cjk :Char;
                      .4s=..5xIn¹ 10xIn¹ 20xIn¹ ## 5s=.. 4,2xIn* 3,9xIn*  <= ¹=Taulukosta/UTU  ks. C:\Projektit XE2\NolaKehi\SRC\Sulake\Johdonsuojakäyrät
                             JkB   JkC    JkD            JkB,C   JkD         *=Luettu käyriltä
                  2A  .4s=.. 10    20     40       5s=.. 8,4     7,8      <,,-- Nämä Isnik´ssä--,,>
                  4   .4s=.. 20    40     80       5s=.. 16,8    15,6
                  6   .4s=.. 30    60     120      5s=.. 25,2    23,4
                  10  .4s=.. 50    100    200      5s=.. 42      39
                  16  .4s=.. 80    160    320      5s=.. 67,2    62,4}
   procedure si (r :real);      begin  Result := r;  end;
BEGIN                           //,,Muutetaan mahd. YR/AR normaalityypiksi, joilla ohjataan AINA YR:ään #########
   suCs := Trim(AnsiUpperCase(suCs));
   Cjk := ' ';
   if Length(suCs)=1
      then Cjk := suCs[1];            //<''+130.0

   if fSu_Sama (suCs,su_IECgYR) OR fSu_Sama (suCs,su_IECgAR)  then suCs := su_IECg   else
   if fSu_Sama (suCs,su_IECdYR) OR fSu_Sama (suCs,su_IECdAR)  then suCs := su_IECd;

   //,,======================================= SL:n jakeluverkossa ==============================================
   IF Tim > 5.1
   THEN IF Isul > 63  THEN  si (3   * Isul)
                      ELSE  si (2.5 * Isul)                                                     //,OFAgG t. OFAaM
   ELSE IF  ( fSu_Sama (suCs,su_OFAg) OR fSu_Sama (suCs,su_OFAm) ) AND (Isul<=630)              // >630 =IEC
   //,,======================================= Lauk.aika 5s TAI 0.4s ============================================
   THEN si (IktYR (suCs,Isul,Tim) {*1.1})                   //< OFAA/OFAM tarkat arvot.  -6.2.15=1.1 onJo IktYR:ssä
   ELSE IF  fSu_Sama (suCs,su_IECd) AND (Isul<=100)         // >100 =IECgG
   THEN si (IktYR (suCs,Isul,Tim))                          //< IEC-Dz    tarkat arvot. EI +10%!!!!(sis.aoFNCoon)
   ELSE IF  fSu_Sama (suCs,su_OFAg) OR fSu_Sama (suCs,su_OFAm) OR fSu_Sama (suCs,su_IECg)
   THEN si (IktYR (su_IECg,Isul,Tim))                       //< IEC-gG    tarkat arvot. EI +10%!!!!(sis.aoFNCoon)
                 //'''''''#######################################################################################
   //,,======================================= Lauk.aika 5s =====================================================
   ELSE if Cjk<>' '                            //<,,Sievennetty 130.0 .
   then begin
      if Isul>125
      then si(0)                               //<Kuten ennen:  eioo isompia JK´ta.
      else begin
         IF Tim > 1
         THEN si(Isul*4.6)                     //< 5s Kaikki JSKtyypit samanlaisia, käyrät yhtyvät 5s´n kohdalla (tuskin sattumaa), MITATTU=LASKETTU logKäyrältä.
            (*then si (Isul *{7}3.9)                     //< 5s JSKtyyppt C,D samoja / SSUL - " -   =In*7  => UTU In*3.9  KÄYRÄLTÄ!!!?!?!
              else si (Isul *{5}4.2)                     //< 5s JSKtyyppi B   / SSUL USER1   =In*5  => UTU In*4.2                  <''130.0 *)
         //,,======================================= Lauk.aika 0.4s ===================================================
         ELSE case Cjk of
            'B' :si(Isul *5);                            //< 0.4s JSKtyyppi B / SSUL USER1   =In*5   Nämä edelleen voimassa/UTU 130.0
            'C' :si(Isul *10);                           //< 0.4s JSKtyyppi C / SSUL USER1   =In*10
            'D' :si(Isul *20); end;                      //< 0.4s JSKtyyppi D / SSUL USER1   =In*20
      end;//elsse
   end
   ELSE si (IktYR (su_IECg,Isul,Tim));                         //< IEC-gG VARM.VUOKSI ..ELSE ####################
                         //''''''''##############################################################################
END; //FNC Isnik
//===============================================================================================================
FUNCTION sys_ker (R,X :Real) :Real;       BEGIN //<Sysäyskerroin Ik :lle =KAPPA
   IF X=0  THEN sys_ker := 1.0  ELSE
 sys_ker := 1.02 +  0.98  * Exp (-3*R/X);      END; //<Testattu = OK    Lähde: INSKO 183-89 II  -5.0.1
//   sys_ker := 1.022 + 0.969 * Exp (-3.03*R/X);   END; //<Testattu = OK    7.1.02/VDE 0102 / ABB Timo Jokiniemi
//-------------------------------------------------
FUNCTION m_tasav (sys,aika :Real) :Real;  BEGIN   //<Tasavirtatekijä Ik:lle
                                    {                    1
                                     m_tasav = --------------------- * Exp (200*aika* ln (sys-1)) -1
                                               100*aika* ln (sys-1))                                }
   IF (aika<0.01)    THEN aika := 0.01;           //<p.o.>0, 0.01 = «jaksoa
   IF  sys<1.000001  THEN sys := 1.000001  ELSE   //<Err: LN of non positive
   IF  sys>1.999999  THEN sys := 1.999999;{ELSE}  //<Err: REAL divide by 0
   m_tasav := ( 1 / (100*aika* ln (sys-1)) ) *    //Delphi: FNC might be undefined:
              ( Exp (200*aika* ln (sys-1)) -1 ); END; //'Korjaus: ELSE vex
//------------------------------------------------_   //''FNC Testattu = OK
{FUNCTION Tekv (IkSal,Ikmax :Real) :Real;       //<Aika, jolla Ikmax:lla IkSal
   BEGIN    //Kaava:  IkSal = Ikmax V¨[(m+n)t]  =>  t = (IkSal/Ikmax)²/(m+n)
            //FNC laskee PELKISTETYSTI:             t = (IkSal/Ikmax)²/(0+1)
   Result := Sqr (IkSal/Ikmax);                //<''  = (IkSal/Ikmax)²
END;}
//===============================================================================================================
          //################################## Kokonaiskuvio uusittu +7.0.5 Tek ##################################
          //     ,TypOsMukaan oltava<>0, muuten epäaito korjaus -> TypOsMukaan := -1. ############################
          //     ,FNC palauttaa AJAN T, jolla [TypOsMuk-1]:n lopussa antava Ik3th mahistaa [TypOsMuk]:ssa IkSal:n.
FUNCTION Tekv_mn (TypOsMukaan :integer;  tamaIk :real;  NJkin :boolean) :Real;
          //                               'tamaIk>0 -> IkMax´ina käytetään tätä, eikä lasketa Ik3t.##############
          //         HUOM: tamaIk :n R,X tarvittaisiin sysKer :n laskemiseksi, nyt puuttuu, korjattava ehkä joskus.<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
          //        'TypOsMukaan =IkSal kaapelityyppi Edvn johto-osan edka[TypOsMukaan].tyyppi mukaan.
          //     'Ik3th -laskenta ohjataan J-osan alkuun / loppuun TypOsMukaan (onko TypOsMukaan <=> 0).
          // OS määräytyy em. Alun/Lopun ja TypOsMukaan perusteella joko edellisen tai saman j:n loppuun.
          // OS = edjNo-1 tai LiitNo(Sorc). Jos os=0, lasketaan yhtIkSal Src[-1..-n]  =>  1/yIk = 1/Ik1 +.. 1/Ikn
          //:Jos tarkistetaan t Max_Ik3v -aikaa IkSal kestävyyteen, tutkitaan tilanne ao.johto-osan alkuSENTEILLÄ
          // ja OS määrätään TypOsMuk:n ED.johdn loppuun ja TypOsMukaan ao.johto-osan mukaan, koska senhän kestoi-
          // suutta halutaan tutkia. TypOsMukaan VOI OLLA myös = OS !#!#!#!#!#!#!#!#!#!#!#!#!#!!#!#!#!#!#!#!#!#!#!
          //   SIIS:  Jos TypOsMuk=0 => yhteisIkSal = kaikkien liittymäjohtojen summa.############################
          //   LASKET. kahdet tiedot:  1) Oikosulkuvirta Ik3th [os] :n lopussa. ##################################
          //                           2) IkSal tarkasteltavssa =[TypOsMuk] :ssa j :ssa.##########################
                                       //,,Ik3t joko [n-1] tai [n] muk. IkSal aina [n] muk. Kutsussa määrätään.,,,
                                                         // SJ------ -1 -------|----- +1 -----|----- +2 ------|...
                                                         // PJ------ -2 -------|
                                                         //  G------ -3 -------|               ,##################
                                                         //     'B TypOsMuk<0    'B TypOsMuk>0  <<< A,B tark.pisteet
                                                         //   'A os<0         'A os=0           <<< A voi = B ####
                                                         //Lasketaan:  Pisteessä A: Ik3th (sysk =R,X)   B: IkSal
                                                         //¯¯¯¯¯¯¯¯¯¯############¯¯¯¯¯¯¯¯###############¯¯¯¯¯¯¯¯
                                                         //,,,,,,=OH,os,TypOsMuk,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                                                         //Esim: 0,-1,-1 = Liitj[-1] napaoikos, TypOsMuk=[-1]
                                                         //      1,-1,-1 = Liitj[-1] lopussa,   TypOsMuk=[-1]
                                                         //      1, 0, 1 =(0,1,1)= YhtLiit lopussa, TypOsMuk=[1]
      Label 1;                                           //      1, 1, 2 =(0,2,2)= [1] lopussa, TypOsMuk=[2]
      VAR JTyp :string;   ar,sysk,Jmm2,IkMax,PoisAika,   //Korjataan 0, 0, 0  =>  0,-1,-1
          R8,X8, IkSal, Zka, fnc  :real;                 //          1, 0, 0  =>  1,-1,-1
          KUL :boolean;  rec :EdvPalstaType;             //          1,-1, 0  =>  0,-1,-1
          OH,os,ao :integer;                             //          1,-2, 0  =>  0,-2,-2 jne.
                                   //,TypOs välittää TÄHÄN ekax tarvittavan arvon, josta KAIKKI määräytyy.########
   procedure Evos_ToOhOs (VAR OHJ,eOs,TypOs :integer);      VAR aTypOs :integer; // +7.0.5:
      //   PRC määrittää TUTKITTAVAA JOHTOA (=TypOs) EDELTÄVÄN JOHDON OSOITTEEN (=eOs) sekä niitä vastaavan
      //   OHJAUSNron (=OHJ) sen mukaan, ollaanko liittymäjohdoissa vai edv:ssa.
      //              Jos TypOs>0 :  OHJ=31 tai 30 (=ed.J:n loppuun) ja eOs=TypOs-1 ######### PÄÄSÄÄNTÖ ##########
      //                  TypOs<=0:  OHJ=30        (=ao.J:n alkuun)  ja eOs=TypOs.  ######### PÄÄSÄÄNTÖ ##########
      //Kutsuesim: Evos_ToOhOs (os, OH,ee,uu);
      procedure prc;      begin
         if TypOs=0
         then begin  OHJ := 30;  eOs := -1;       TypOs := -1;  end //<'Korjataan kylmästi [-1] :een + alkuun.
         else if TypOs<0
         then begin  OHJ := 30;  eOs := TypOs;    end               //< OHJ ao.j-osan alkuun  (30) = napaoikos.
         else begin  OHJ := 31;  eOs := TypOs-1;  end;              //< OHJ ed.j-osan loppuun (31)

         {Vrt.:   if s_e=1  then begin  fo := -1*os;   f_ := fo;     end  //<,Näillä ohjataan ao. tai edelliseen
                            else begin  fo :=  os;     f_ := os -1;  end; //  alkioon. -1* =Ziks_:ssä erottuu Sorceksi.}
         if (ohj>99) and (eOs>99) and (TypOs>99)  then ; //beep; //<Debuggerille
      end;
      procedure tee;      begin  //,,OHJ ohjaa laskennan johdon ALKUun/LOPPUun, eOs määrää em:n osoitteen.
                   //,,Joista tulee:   OHJ   eOs  TypOs  <= Kun iTypOs<=0, OHJ=30(alkuun), muuten OHJ=31(loppuun).
         TypOs :=  0;   prc;       //=> 30    -1   -1  =Korj. kylmästi Src[1]. Vois ohjata Edv[1]
         TypOs := -1;   prc;       //=> 30    -1   -1  =EiKorjattavaa (OHJ, TypOs), ei yhteisIk.
         TypOs := -2;   prc;       //=> 30    -2   -2  =EiKorjattavaa (OHJ, TypOs)
         TypOs :=  1;   prc;       //=> 31     0    1  =EiKorjattavaa (OHJ, TypOs)
         TypOs :=  2;   prc;       //=> 31     1    2  =EiKorjattavaa (OHJ, TypOs)
         TypOs :=  3;   prc;       //=> 31     2    3  =EiKorjattavaa (OHJ, TypOs)
         if TypOs>999  then ; //Debuggerille (Stop paikka ennen End´iä)
      end;
   begin//Evos_ToOhOs
      aTypOs := TypOs;  //<Alp talteen
//    tee;              //<Kokeilut jakeluversiosta VEX, tämä mukana vain TESTAUKSESSA.
      TypOs := aTypOs;  //<,Alp takaisin ja lopullinen, haluttu sijoitus.
      prc;
   end;//Evos_ToOhOs

begin//Tekv_mn
   if TypOsMukaan=0  then   //if (TypOsMukaan=0) OR (os=0) and (TypOsMukaan<0)  OR (TypOsMukaan<os)  then
      InfoDlg ('FNC Tekv_mn (...) / Nola02.INC kutsussa virhe todellisessa parametrissa (TypOsMukaan=0). '+
               'Arvo korjataan (-1), jolloin laskenta ei ehkä vastaa tarvetta. <b>Virhe on ohjelmallinen. Ota '+
               'laskentaparametrit ylös (mitä arvoja mahd. olit muuttanut)</b> ja ilmoita tilanteesta '+
               'valmistajalle.',
               mtCustom, 'OK','','','',  '','','','');
                                                    //DefsFileenZ(0,'Tekv_mn: 11´:  OH=' +Ints(OH) +'  os=' +Ints(os) +' TypOs=' +Ints(TypOsMukaan));
                                                    {InputBox('Tekv_mn','','Tekv_mn 1´: >TypOsMuk=' +Ints(TypOsMukaan) +' >TamaIk=' +fRmrkt0(tamaIk,1,4) +
                                                             ' NJkin=' +fBmrkt0(NJkin,2) +' TypOs=' +Ints(TypOsMukaan)); //}
   Evos_ToOhOs (OH,os,TypOsMukaan);                          //<Palauttaa KORJATUT:  OH,OS,TypOsMukaan
                //except InputBox('Leikkaa/kopioi viesti:', 'Ilmoita valmistajalle VIRHE 2´:', 'Nola01.INC/Evos_toOhOs');  Halt;  end;//try
                                                    //DefsFileenZ(0,'Tekv_mn: 2´:  OH=' +Ints(OH) +'  os=' +Ints(os) +' TypOs=' +Ints(TypOsMukaan));
                                                    //InputBox('Tekv_mn','','Tekv_mn 2´: OH=' +Ints(OH) +' os=' +Ints(os) +' TypOs=' +Ints(TypOsMukaan));
   Ziks (OH,os,NJkin,1, '',0,0,0,0, R8,X8,ar,ar);   //InputBox('Tekv_mn','','Tekv_mn 3´: R8=' +fRmrkt0(R8,1,5) +' X8=' +fRmrkt0(X8,1,5));
                {except InputBox('Leikkaa/kopioi viesti:', 'Ilmoita valmistajalle VIRHE 3´:', 'Nola01.INC/Ziks:  OH=' +Ints(OH) +' os=' +Ints(os) +'TypOsMuk=' +
                                 Ints(TypOsMukaan) +' !! R8=' +fRmrkt0(R8,1,4) +' X8=' +fRmrkt0(X8,1,4));  Halt;  end;//try}
                                                    //DefsFileenZ(0,'Tekv_mn: 3´:  R8=' +fRmrkt0(R8,1,5) +'  X8=' +fRmrkt0(X8,1,5));
   ao := Abs (TypOsMukaan);
   if TypOsMukaan<0  then rec := edv.Sorc[ao].josa           //<Sijoitetaan IkSal:n j-osan tiedot REC´iin.
                     else rec := edv.Edka[ao];               //<,NJ-tapaus ohittaa TypOsMuk -ve:n.
   if NJkin  then begin JTyp := NJtyp;
                        Jmm2 := NJmm2;
                        KUL :=  a_getBool (31, nj.jy.NjKulSal);  end
             else begin JTyp := a_getStrg (32, rec.Tyyppi);
                        Jmm2 := a_getReaa (33, rec.Amm2);
                        KUL :=  a_getBool (34, rec.Kuluttaja);  end;
                                                    //DefsFileenZ(0,'Tekv_mn: 4´:  JTyp=' +JTyp +'  Jmm2=' +fRmrkt0(Jmm2,1,1));
                                                    //DefsFileenZ(0,'Tekv_mn: 5:  IkSal=' +fRmrkt0(IkSal,1,3));
                                                    //InputBox('Tekv_mn','','Tekv_mn 4´: IkSal=' +fRmrkt0(IkSal,1,5));

   IkSal := Iksalterm (JTyp,Jmm2);                  //<+120.6: ..migt not have been initialized.
   if NOT KUL   then begin
      IkSal := Iksalterm (JTyp,Jmm2);
      IkSal := IkSal/Sqrt (5);  end;                //<SÄL:n Iksal redus. 5s :iin
   if tamaIk>0
      then IkMax := tamaIk                          //<sysk :lle pitäisi R,X selvittää myös tamaIk :lla.
      else begin
           Zka := Sqrt (Sqr(R8) + Sqr(X8));         //<Tähän nyt vain NJ-laskennassa.
           IkMax := iks (Ik3vTR, os, Zka);  end;
         //Kaava:  IkSal = Ikmax V¨[(m+n)t]  =>  t = (IkSal/Ikmax)²/(m+n),   n=1 kun Ik"=Ik
   sysk := sys_ker (R8,X8);                         //< sysk =SYSKERR, jota käytetään jälempnä Ik3th :ssa
                                                    //DefsFileenZ(0,'Tekv_mn: 6:  sysk=' +fRmrkt0(sysk,1,4));
   PoisAika := 1;
   R8 := m_tasav (sysk,PoisAika);                   //DefsFileenZ(0,'Tekv_mn: 7:  tasav=' +fRmrkt0(R8,1,5));
                                                    //InputBox('Tekv_mn','','Tekv_mn 5´: IkSal=' +fRmrkt0(IkSal,1,3) +' IkMax=' +fRmrkt0(IkMax,1,3) +
                                                    //         ' R8+1=' +fRmrkt0(R8+1,1,3));//}
//############################################################################################################################################################
//,################################## Tämä rivi aiheuttaa errorin, minkä takia muuttujat välitetään globaaleina kutsukohtaan.#################################
   fnc := Sqr (IkSal/IkMax) / (R8 +1);              //<Tässä tapahtuu jotain virhettä, koska kun tämä laskenta tapahtuu, tapahtuu EdvNewLask.PAS´ssa EXCEPT,
// fKESKEN('Tekv_mn');                              //'120.6: Lauseke oli korvattu KOLVATULLA ARVOLLA 0.019 . Nyt ei enää error´ia.
   Result := fnc;                                   {InputBox('Tekv_mn','','Tekv_mn 6´: IkSal=' +fRmrkt0(IkSal,1,5) +' sysk=' +fRmrkt0(sysk,1,5) +' m_tasav=' +
                                                             fRmrkt0(R8,1,6) +' Result(FNC Tekv_mn)=' +fRmrkt0(Xd,1,5));//}
end;//Tekv_mn.................................................................................................................................................
//===============================================================================================================
//FNC Tekv_mn ´ssa debugOngelma: Debuggaus, DefFileen kirjoitus, InputBox yms. ei paljasta virhettä. Se on saatu paikallistettua laskentaoperaatioon TRY 5´
//    siten, että kukin TRY..EXCEPT pari on vuorollaaan sijoitettu toimintaan. Kun 5´:ssä laskenta Xd := 0.02;  korvataan ao. kaavalla Xd := Sqr... JA KAIKKI
//    TRY .. EXCEPT parit on kommentoitu vex, SYNTYY ERROR. Kokeilin muuttaa Relit R8,X8 Doubleksi Rd,Xd, muttei vaikutusta.
//============================================================================================================================================================
function OFAAraj_Is (IsuOFAA,Ip,Id :real)  :real; //<fnc =OFAAsulakkeen rajoittama Is.      +5.0.1
                                                  //', Ip =Ik3th =Prospektiivinen Ik (rms).   Id = Ik3d=Alkuper.Ik3d (rajoittamaton)
   procedure las (K :real);      VAR ar :real;      begin       //Ip Potenssiin n = e Potenssiin (n ln(Ip))
    //ar := K *Sqrt (2) *Exp (0.41* ln(Ip/1000)); //< =OK  /1000 =[A]  => [kA]. ' = Exp          (n ln(Ip))
      ar := Power (Ip/1000,0.41);                 //< =OK  /1000 =[A]  => [kA].     OFAM: 0.41 => 0.34
      ar := K *Sqrt (2) *ar;                      //<'Jaettu osiin debuggausta varten  10.0.3.
      ar := ar *1000;                             //< *1000 =[kA] => [A].
      if Id<=ar  then                             //<Jos AR>Ik3d, ei olla sulakkeen RAJOITTAVALLA osalla.
         ar := 0;
      result := ar;
   end;

   {Ks. \GlobINC\ABB-OFA-IkRaj-Delphi.~txt.,,,,,,,,,,,,,,,,,     OFAA	        OFAM
    OFAA ja OFAM –sulakkeiden virranrajoituskäyrien funktiot:    Sulakkeen      kerroin     Sulakkeen      kerroin
    Funktioita ei yleiseen jakeluun. #######################     Nimellisvirta   x          nimellisvirta    x
    	OFAA       Ip,,Potenssiin 0.41      OFAM                      2            0.095         2             0.2216
    	îc = x*V¨2*Ip**0.41                 îc = x*V¨2*Ip**0.34       4            0.141         4             0.365
    	îc = sulakkeen rajoittaman virran huippuarvo [kA]             6            0.19          6             0.57
     x  = sulakkeen nimellisvirrasta riippuva kerroin             10            0.23         10             0.69
    	Ip = prospektiivinen oikosulkuvirta (r.m.s) [kA]             16            0.28         16             0.74
                                                                  20            0.33         20             0.9
                                                                  25            0.41         25             0.97
                                                                  32            0.58         32             1.21
                                                                  40            0.85         40             1.3
                                                                  50            1.0          50             1.52
                                                                  63            1.25         63             1.85
                                                                  80            1.54         80             2.2
                                                                 100            1.85        100             2.45
                                                                 125            2.3         125             2.92
                                                                 160            2.89        160             3.25
                                                                 200            3.25        200             4.0
                                                                 250            3.65        250             4.5
                                                                 315            4.27        315             5.3
                                                                                            355             5.9
                                                                 400            5.1         400             6.5
                                                                 500            5.8         500             7.8
                                                                 630            6.9         630             8.8
                                                                                            800             8.92}

begin//OFAAraj_Is,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   case Pyor (IsuOFAA) of
     2 :las (0.095);     25 :las (0.41);     100 :las (1.85);     400 :las (5.1 );
     4 :las (0.141);     32 :las (0.58);     125 :las (2.3 );     500 :las (5.8 );
     6 :las (0.19);      40 :las (0.85);     160 :las (2.89);     630 :las (6.9 );
    10 :las (0.23);      50 :las (1.0 );     200 :las (3.25);
    16 :las (0.28);      63 :las (1.25);     250 :las (3.65);
    20 :las (0.33);      80 :las (1.54);     315 :las (4.27);  //end //case                      K=2..K=1
   else result := 0;  end; //case                              //<Siirretty alusta tähän 10.0.3
   if result=-111  then Sysutils.beep;                                  //<+10.0.3
                                             {Ip := 50000;  las (5.8 ); //< ic= ~40500  Isu=500: FNC= ic=40786.899
                                              Ip := 10000;  las (1.85); //< ic= ~ 6700  Isu=100:      ic= 6724.913
                                              Ip :=  5000;  las (1.85); //< ic= ~ 5050  Isu=100:      ic= 5061.327
                                              Ip :=  5000;  las (1.0 ); //< ic= ~ 2700  Isu= 50:      ic= 2735.852}
end;//OFAAraj_Is
//===============================================================================================================
{ FUNCTION uhik (Rn,Xn,Ioikos :Real) :Real;   BEGIN
   uhik := Ioikos * Sqrt ( Sqr(Rn) + Sqr (Xn) );  END;}
//===============================================================================================================
//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NOLA02.INC
{su_OFAg su_OFAm su_IECg su_IECgAR su_IECgYR su_IECd su_IECdAR su_IECdYR}
{
su_OFAg su_OFAm   su_IECg su_IECd
fSu_Sama (suCs,su_
}













