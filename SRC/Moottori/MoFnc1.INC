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

//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ MoFnc1.INC
{ ChkOFAdzRaja
  fPseur   fPvmax   vakiokoot   fCos  fScos
  fEta     fStN
  fIn      fIst                                //<MoFnc1.INC siirretty tähän
============================================================================}
FUNCTION ChkOFAdzRaja (VAR sulTyp :string;  sulKoko :integer) :boolean;      VAR suCsu :string;      begin
   result := false;
   suCsu := sulTyp;                             //,Vaihdetaan tyyppi, jos aM tyyppi ei riitä (IsnikFnc muutti)
   if ( fSu_Sama (suCsu,su_OFAg) OR  fSu_Sama (suCsu,su_OFAm) ) and (sulKoko>630)  OR
      fSu_Sama (suCsu,su_IECd) and (sulKoko>100)
   then begin
      suCsu := su_IECg;
      result := true;  end;
   sulTyp := suCsu;   end;
//===========================================================================
function strRd (demoX :integer;  arvoR :real;  rajD :real;  desD :integer) :string;   begin //< demoX >0 =demotext
   if (demoX>0) and (demo(111) OR PRO_Demo)
      then result := 'X.xx'
    //else result := fRmrktRaj4 (arvoR,  raj1,des1, raj2,des2, raj3,des3, raj4,des4);  end;
      else result := fRmrkt0 (arvoR, 1,fDsm (arvoR, rajD,desD));  end;
//=========================================================================== ,,Ei käytetty
(*function strRf (demoX :integer;  arvoR :real;  alkio :arvoTyyp)  :string;      begin        //< demoX >0 =demotext
   if (demoX>0) and demo
      then result := 'X.xx'         //,,,,,OK vaikka OnArvo=FALSE ##################################
      else result := fRmrktRaj (arvoR,alkio);  {raj1,des1, raj2,des2, raj3,des3, raj4,des4);  }end;*)
//===========================================================================
function strKw (demoX :integer;  MoKw :real) :string;      VAR des :integer; //<Moottoritehoille
begin
   if MoKw>20    then des := 0  else
   if MoKw>1     then des := 1  else
   if MoKw>0.08  then des := 2  else des := 3; //<des=3 kun P=0.055 ... 0.075
   if (demoX>0) and (demo(112) OR PRO_Demo)
      then result := 'X.xx'
      else result := fRmrkt0 (MoKw,1,des);  end;
//===========================================================================
function sijI (demoX,arvoI :integer) :string;   begin                  //< demoX >0 =demotexti
   if (demox>0) and (demo(113) OR PRO_Demo)  then result := 'Xx'
                                        else result := fImrkt0 (arvoI, 1);   end;
//===========================================================================
FUNCTION fSeurP (SyoKW :Real) :Real;     VAR nro :Integer;
      PROCEDURE sij (vakKW :Real);                              BEGIN
         fSeurP := vakKW;   nro := nro+1;
         IF (SyoKW < vakKW)  OR  (vakKW = 0)   THEN  nro := 100;  END;//sij
BEGIN//fSeurP
   nro := 1;
   REPEAT  CASE nro OF    //Vakiokoot/ABB << 99 tms.=eiooKokoa <<<<<<<<<<<<<<
       1 :sij (0.055);  99 :sij (0.075);   2 :sij (0.09);   3 :sij (0.12);
       4 :sij (0.18 );   5 :sij (0.25 );   6 :sij (0.37);   7 :sij (0.55);
       8 :sij (0.75 );   9 :sij (1.1  );  10 :sij (1.5 );  11 :sij (2.2 );
      12 :sij (3.0  );  13 :sij (4.0  );  14 :sij (5.5 );  15 :sij (7.5 );
      16 :sij (11   );  17 :sij (15   );  18 :sij (18.5);  19 :sij (22  );
      20 :sij (30   );  21 :sij (37   );  22 :sij (45  );  23 :sij (55  );
      24 :sij (75   );  25 :sij (90   );  26 :sij (110 );  27 :sij (132 );
      28 :sij (160  );  29 :sij (200  );  30 :sij (250 );  31 :sij (315 );
      32 :sij (355  );  33 :sij (400  );  34 :sij (450 );  35 :sij (500 );
{+}   36 :sij (560  );  37 :sij (630  );  38 :sij (710 );  39 :sij (800 );
{+}   40 :sij (900  );  41 :sij (1000 );  42 :sij (1120);  43 :sij (1250);
{+}   44 :sij (1400 );  ELSE                  sij (0   );  END;//CASE
   UNTIL nro >= 100;
END;//fSeurP
//===========================================================================
FUNCTION fPvmax (napaN :Integer;   maxP :Boolean) :Real;   //<TRUE => PvakMAX
   VAR MTmin,MTmax, HXmin,HXmax :Real;                     //FALSE => PvakMIN
         //MT_ja HXR =moottorityyppejä. Valmiiksi molemmat. MT_määrääväNäissä
      PROCEDURE sij (Mmin,Mmax,Hmin,Hmax :Real);   BEGIN
         MTmin := Mmin;  MTmax := Mmax;   HXmin := Hmin;  HXmax := Hmax; END;
   BEGIN
   CASE napaN OF     //MTmax ei merkitystä, HXmin:llä on jos MT_=0. Limittäin
             //MT___,_MBT, HXR_______<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
       2 :sij (0.25 , 560,  400,1250);    //<,HXR:n FNCtietoja (Eta, cos yms.
       4 :sij (0.18 , 710,  400,1400);    //  on ohassa vain MBT:n max-arvos-
       6 :sij (0.12 , 400,  315,1250);    //  ta lähtien koskei tarvita. Täs-
       8 :sij (0.055, 400,  224,1250);    //  sä sillä ei ole merkitystä !!!!
      10 :sij (0    ,   0,   11, 160);      //<Pvittämättä
      12 :sij (0.075,0.37,  7.5, 132);      //<Pvittämättä
     ELSE sij (0,0, 0,0);{VarmuudenVuoksi vaikkei tarttis}  END;//CASE
   IF maxP                        //,MT:n tiedot pienempiin koneisiin<<<<<<<<
   THEN        fPvmax := HXmax    //<<HXR:n tiedot ylettää isompiin koneisiin
   ELSE BEGIN  fPvmax := MTmin;   IF MTmin=0  THEN fPvmax := HXmin;   END;
   IF maxP  THEN IF HXmax>710  THEN fPvmax := 710;   //<KEINOTEKOINENrajoitus <- f(Un) ????????????????????????
END;//fPvmax              ettei rinnakk.kaap.>=10. Moott.arvot ...1400kW asti
//===========================================================================
{SEURAAVISSA FNCssa kutsuparamPari:
        ,0 = Arvot löytyvät suoraan ao. koneelle ABB:n ltloista:  Oikos.moottorit, Tekn. perustietoa -95, s.23
        ,1 = EiooABBlla =Cosè saman NAPlkmn PIENEMMÄN kW:n koneesta
        ,2 =   - " -    =Cosè Lähinnä ISOMMAN NAPlkm saman kW:n -"-
        ,3 =   - " -    =Cosè ARVATTU isomman ja pienemmän, saman NAPlkmn kW:n koneen ARVOJEN VÄLISTÄ
        ,4 =   - " -    =Cosè ARVATTU (ISOMMAN NAPlkmn arvot liian huonoja ja epäjohdonmuk, arv todNäkParempi)
        ,6 = Varmuutta eioo: saattaa olla 0,1 tai 4. Alp kommentin mukaan LIENEE 0 = ABBn ltloarvo SUORAAN
        ,8 = Paavo Mäkysen Faxien 5.8.98 = E-Mailin 10.8.98 mukaan => ver 1.0.8
        ,9 = Alp, jos SAMA KUIN 8 @@@@@@@@@@@@@@@@@==========================================================}
FUNCTION fCos (P :Real;   napaN :Integer) :Real;         //<Nimellistehon Cos     //<Moot.PASn INTERFACEssa
   FUNCTION si (Ps, r2,f2, r4,f4, r6,f6, r8,f8, r10,f10, r12,f12 :Real) :boolean;    VAR ra :Real;    BEGIN
      si := false;                                       //'f.. vain tietolähteen ilmaisemiseksi @@@@@@@@@@
      if P<=Ps  then begin                               //'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         case napaN of  2 :ra := r2;
                        4 :ra := r4;
                        6 :ra := r6;
                        8 :ra := r8;
                       10 :ra := r10;
                     else  ra := r12;  end;//case
         ra := ra/100;   ra := fMuokdes (ra,2);   fCos := ra;
         si := true;  end;//if P<=Ps
   END;
BEGIN//...kW   ,  2     4     6     8     10    12nap          kW   ,  2     4     6     8     10    12nap
   IF si (0.055,  65,4, 65,4, 50,1, 61,0, 48,1, 47,1)  OR  si (0.075,  67,4, 67,4, 52,1, 62,4, 50,1, 47,1)  OR
      si (0.09,   65,4, 65,4, 55,1, 63,9, 52,1, 50,1)  OR  si (0.12,   65,4, 65,4, 56,9, 59,8, 52,1, 50,0)  OR
      si (0.18,   71,4, 63,0, 62,9, 56,9, 50,1, 47,1)  OR  si (0.25,   75,9, 67,9, 64,9, 55,9, 50,1, 47,0)  OR
      si (0.37,   80,9, 69,9, 66,9, 56,9, 49,1, 47,0)  OR  si (0.55,   80,9, 73,9, 67,9, 57,9, 49,1, 55,1)  OR
      si (0.75,   82,9, 74,9, 67,0, 59,9, 55,1, 55,1)  OR  si (1.1,    85,9, 81,8, 69,9, 64,9, 53,1, 55,1)  OR
      si (1.5,    82,9, 79,9, 69,8, 65,9, 51,1, 55,1)  OR  si (2.2,    86,9, 81,9, 74,9, 67,9, 50,1, 70,0)  OR
      si (3.0,    88,9, 81,9, 75,9, 68,9, 74,0, 70,0)  OR  si (4.0,    91,9, 80,9, 78,9, 69,9, 72,0, 72,0)  OR
      si (5.5,    88,9, 83,9, 78,9, 70,8, 71,0, 72,0)  OR  si (7.5,    90,9, 83,9, 79,8, 70,8, 74,0, 62,0)  OR
      si (11,     88,9, 81,9, 78,8, 76,8, 71,0, 72,0)  OR  si (15,     90,8, 84,8, 78,9, 82,9, 71,0, 62,0)  OR
      si (18.5,   91,8, 84,8, 81,9, 79,8, 71,0, 62,0)  OR  si (22,     89,8, 83,8, 81,9, 77,9, 69,0, 63,0)  OR
      si (30,     88,9, 83,9, 83,8, 82,8, 72,0, 62,0)  OR  si (37,     89,9, 84,9, 85,8, 78,9, 77,0, 63,0)  OR
      si (45,     88,9, 83,9, 84,9, 78,9, 79,0, 73,0)  OR  si (55,     89,9, 86,9, 84,9, 81,9, 79,0, 72,0)  OR
      si (75,     88,9, 86,9, 82,9, 82,9, 81,0, 72,0)  OR  si (90,     90,9, 87,9, 84,9, 82,9, 80,0, 75,0)  OR
      si (110,    86,9, 87,9, 83,8, 83,9, 80,0, 78,0)  OR  si (132,    88,9, 87,9, 83,8, 80,9, 80,0, 75,0)  OR
      si (160,    89,9, 86,9, 85,9, 80,9, 79,0, 77,1)  OR  si (200,    90,9, 86,8, 85,9, 77,9, 79,0, 77,1)  OR
      si (250,    92,9, 87,9, 84,9, 80,9, 79,0, 79,1)  OR  si (315,    92,9, 87,9, 84,9, 79,9, 77,0, 79,1)  OR
      si (355,    92,9, 87,9, 84,9, 79,9, 77,0, 80,1)  OR  si (400,    92,9, 87,9, 85,9, 83,9, 77,0, 80,1)  OR
      si (450,    92,9, 87,9, 85,9, 80,9, 77,0, 80,1)  OR  si (500,    93,8, 88,9, 85,9, 82,9, 77,0, 80,1)  OR
      si (560,    92,9, 90,9, 86,9, 82,9, 92,0, 92,0)  OR  si (630,    92,9, 87,9, 86,9, 83,9, 85,0, 85,0)  OR
      si (710,    93,9, 87,9, 88,9, 84,9, 86,0, 86,0)  OR  si (800,    92,9, 89,9, 87,9, 81,9, 86,0, 86,0)  OR
      si (900,    93,9, 90,9, 86,9, 83,9, 88,0, 88,0)  OR  si (1000,   92,0, 90,0, 86,0, 83,0, 88,0, 88,0)  OR
      si (1120,   93,0, 89,0, 87,0, 83,0, 89,0, 89,0)  OR  si (1250,   93,0, 88,0, 87,0, 83,0, 90,0, 90,0)
      THEN  begin end  ELSE
      si (1400,   90,4, 86,0, 84,4, 80,4, 85,4, 85,4);
END;//fCos
//============================================================================================================
FUNCTION fScos (P :Real;   napaN :Integer) :Real;         //<Käynnistysvirran Cos  //<Moot.PASn INTERFACEssa
   FUNCTION si (Ps, r2,f2, r4,f4, r6,f6, r8,f8, r10,f10 :Real) :boolean;    VAR ra :Real;    BEGIN
      si := false;                                       //'f.. vain tietolähteen ilmaisemiseksi @@@@@@@@@@
      if P<=Ps  then begin
         case napaN of  2 :ra := r2;
                        4 :ra := r4;
                        6 :ra := r6;
                        8 :ra := r8;
                     else  ra := r10;  end;//case :10+12
         ra := ra/100;   fScos := ra;
         si := true;  end;//if P<=Ps
   END;
BEGIN//...kW   ,  2     4     6     8     10+12nap        kW  ,  2     4     6     8     10+12nap
   IF si (0.055,  91,6, 89,6, 70,4, 70,4, 70,4)  OR  si (0.09 ,  90,6, 92,6, 82,6, 80,8, 75,4)  OR
      si (0.12 ,  90,6, 92,6, 82,9, 80,8, 78,4)  OR  si (0.18 ,  85,6, 92,6, 82,9, 80,9, 80,4)  OR
      si (0.25 ,  91,8, 92,9, 82,9, 80,9, 80,4)  OR  si (0.37 ,  90,9, 92,9, 82,9, 79,8, 75,4)  OR
      si (0.55 ,  90,8, 87,9, 82,9, 79,9, 76,4)  OR  si (0.75 ,  85,9, 87,9, 78,9, 70,8, 65,4)  OR
      si (1.1  ,  85,9, 80,9, 78,9, 70,9, 65,4)  OR  si (1.5  ,  79,9, 80,9, 74,9, 60,9, 55,4)  OR
      si (2.2  ,  79,9, 75,9, 65,9, 60,9, 55,4)  OR  si (3.0  ,  76,9, 75,9, 60,9, 60,9, 55,4)  OR
      si (4.0  ,  70,9, 60,9, 60,9, 55,9, 51,4)  OR  si (5.5  ,  70,9, 60,9, 60,9, 55,9, 51,4)  OR
      si (7.5  ,  70,9, 60,9, 55,9, 55,9, 51,4)  OR  si (11   ,  50,9, 55,9, 55,9, 50,9, 51,4)  OR
      si (15   ,  50,9, 55,9, 50,9, 40,9, 36,4)  OR  si (18.5 ,  50,9, 50,9, 45,9, 46,8, 41,4)  OR
      si (22   ,  50,9, 50,9, 45,9, 46,9, 41,4)  OR  si (30   ,  45,9, 50,9, 46,8, 48,8, 43,4)  OR
      si (37   ,  45,9, 42,9, 47,8, 33,8, 30,4)  OR  si (45   ,  38,8, 42,9, 45,8, 33,9, 30,4)  OR
      si (55   ,  39,8, 42,9, 45,9, 30,8, 27,4)  OR  si (75   ,  35,8, 45,9, 39,8, 30,9, 27,4)  OR
      si (90   ,  35,9, 45,9, 39,9, 30,9, 27,4)  OR  si (110  ,  36,8, 40,9, 39,9, 30,9, 27,4)  OR
      si (132  ,  36,9, 40,9, 39,9, 30,9, 27,4)  OR  si (160  ,  36,9, 40,9, 27,9, 30,9, 27,4)  OR
      si (200  ,  36,9, 40,9, 27,9, 30,9, 27,4)  OR  si (250  ,  25,9, 25,9, 27,9, 30,9, 27,4)  OR
      si (315  ,  25,9, 25,9, 27,9, 25,9, 22,4)  OR  si (355  ,  25,9, 25,9, 27,9, 25,8, 22,4)  OR
      si (400  ,  25,9, 25,9, 22,9, 25,8, 22,4)  OR  si (450  ,  25,9, 25,9, 22,9, 25,8, 22,4)  OR
      si (500  ,  17,9, 25,9, 22,9, 25,8, 22,4)  OR  si (560  ,  17,8, 20,9, 22,8, 25,8, 22,4)  OR
      si (630  ,  17,8, 20,9, 22,8, 25,8, 22,4)  OR  si (710  ,  17,8, 20,9, 22,8, 25,8, 22,4)  OR
      si (800  ,  17,8, 20,9, 22,8, 25,8, 22,4)  OR  si (900  ,  17,8, 20,9, 22,8, 25,8, 22,4)
      THEN  begin end  ELSE
      si (1400 ,  15,4, 17,4, 19,4, 22,4, 20,4);//=Täysin arvattu
END;//fScos
//============================================================================================================
FUNCTION fEta (P :Real;   napaN :Integer) :Real;         //<Nimellistehon Cos     //<Moot.PASn INTERFACEssa
   FUNCTION si (Ps, r2,f2, r4,f4, r6,f6, r8,f8, r10,f10, r12,f12 :Real) :boolean;    VAR ra :Real;    BEGIN
      si := false;                                       //'f.. vain tietolähteen ilmaisemiseksi @@@@@@@@@@
      if P<=Ps  then begin
         case napaN of  2 :ra := r2;
                        4 :ra := r4;
                        6 :ra := r6;
                        8 :ra := r8;
                       10 :ra := r10;
                     else  ra := r12;  end;//case
         ra := ra/1000;   fEta := ra;
         si := true;  end;//if P<=Ps
   END;
BEGIN//...kW   ,  2      4      6      8      10     12nap
   IF si (0.055,  650,1, 550,1, 500,1, 434,8, 300,1, 320,1)  OR
      si (0.075,  650,1, 550,1, 500,1, 434,8, 350,1, 380,0)  OR
      si (0.09 ,  670,1, 570,1, 500,1, 434,8, 370,1, 400,1)  OR
      si (0.12 ,  670,1, 570,1, 554,8, 486,8, 420,1, 370,0)  OR
      si (0.18 ,  680,1, 600,0, 578,8, 544,8, 520,1, 420,0)  OR
      si (0.25 ,  706,8, 668,8, 620,8, 586,8, 560,1, 430,0)  OR
      si (0.37 ,  727,8, 705,8, 680,8, 615,8, 600,1, 500,0)  OR
      si (0.55 ,  761,9, 740,9, 698,8, 629,8, 640,1, 520,1)  OR
      si (0.75 ,  788,8, 770,9, 715,8, 729,8, 710,1, 540,1)  OR
      si (1.1  ,  801,8, 775,8, 744,8, 740,8, 720,1, 740,1)  OR
      si (1.5  ,  801,8, 803,8, 782,8, 745,9, 740,1, 750,1)  OR
      si (2.2  ,  828,8, 817,8, 805,9, 805,9, 750,1, 770,0)  OR
      si (3.0  ,  838,8, 835,8, 845,9, 820,9, 790,1, 780,0)  OR
      si (4.0  ,  860,9, 845,9, 855,9, 841,8, 810,1, 800,0)  OR
      si (5.5  ,  860,9, 870,9, 860,9, 847,8, 820,1, 830,0)  OR
      si (7.5  ,  870,9, 880,9, 893,8, 863,8, 830,1, 860,0)  OR
      si (11   ,  912,8, 903,8, 898,8, 887,8, 880,0, 865,0)  OR
      si (15   ,  917,8, 911,8, 908,8, 911,9, 885,0, 870,0)  OR
      si (18.5 ,  924,8, 923,8, 911,9, 911,8, 890,1, 880,1)  OR
      si (22   ,  928,8, 924,8, 917,9, 915,9, 895,0, 890,0)  OR
      si (30   ,  932,9, 929,9, 928,8, 922,8, 910,0, 905,0)  OR
      si (37   ,  936,9, 936,8, 930,8, 934,8, 620,0, 908,0)  OR
      si (45   ,  939,9, 942,9, 945,9, 940,8, 925,0, 917,0)  OR
      si (55   ,  943,9, 940,8, 947,9, 943,9, 932,0, 922,0)  OR
      si (75   ,  949,9, 950,8, 950,9, 948,9, 931,0, 923,0)  OR
      si (90   ,  951,8, 952,9, 955,9, 951,9, 936,0, 935,0)  OR
      si (110  ,  951,8, 956,9, 956,9, 952,9, 940,0, 935,0)  OR
      si (132  ,  954,8, 958,9, 958,9, 950,9, 940,0, 930,0)  OR
      si (160  ,  961,9, 960,9, 959,9, 952,9, 945,0, 940,1)  OR
      si (200  ,  963,9, 962,9, 959,9, 955,9, 950,1, 940,1)  OR
      si (250  ,  961,9, 965,9, 960,9, 957,9, 950,1, 950,1)  OR
      si (315  ,  966,9, 967,9, 962,9, 960,9, 960,1, 950,1)  OR
      si (355  ,  964,8, 967,9, 964,9, 962,9, 960,1, 950,1)  OR
      si (400  ,  966,9, 968,9, 965,9, 966,9, 960,1, 950,1)  OR
      si (450  ,  966,9, 968,9, 965,9, 964,9, 960,1, 960,1)  OR
      si (500  ,  966,9, 968,9, 965,9, 965,9, 960,1, 960,4)  OR
      si (560  ,  967,9, 969,9, 971,9, 966,9, 962,4, 960,4)  OR
      si (630  ,  969,9, 969,9, 971,9, 968,9, 962,4, 960,4)  OR
      si (710  ,  971,9, 969,9, 971,9, 969,9, 962,4, 960,4)  OR
      si (800  ,  972,9, 975,9, 972,9, 969,9, 962,4, 962,4)  OR
      si (900  ,  974,9, 975,9, 973,9, 970,9, 962,4, 962,4)  OR
      si (1000 ,  974,0, 976,0, 974,0, 971,0, 962,4, 962,4)  OR
      si (1120 ,  975,0, 976,0, 975,0, 972,0, 962,4, 962,4)  OR
      si (1250 ,  976,0, 977,0, 976,0, 972,0, 962,4, 962,4)
      THEN  begin end  ELSE
      si (1400 ,  976,4, 977,0, 976,4, 972,4, 962,4, 962,4);//=Täysin arvattu
END;//fEta
//============================================================================================================
FUNCTION fStN (P :Real;   napaN :Integer) :Real;     //<Moottorin Ist/InSUHDE
   FUNCTION si (Ps, r2,f2, r4,f4, r6,f6, r8,f8, r10,f10, r12,f12 :Real) :boolean;    VAR ra :Real;    BEGIN
      si := false;                                       //'f.. vain tietolähteen ilmaisemiseksi @@@@@@@@@@
      if P<=Ps  then begin
         case napaN of  2 :ra := r2;
                        4 :ra := r4;
                        6 :ra := r6;
                        8 :ra := r8;
                       10 :ra := r10;
                     else  ra := r12;  end;//case
         ra := ra/10;   fStN := ra;
         si := true;  end;//if P<=Ps
   END;
BEGIN//...kW   ,  2     4     6     8     10    12nap          kW   ,  2     4     6     8     10    12nap
   IF si (0.055,  40,1, 30,1, 30,1, 15,0, 40,1, 20,1)  OR  si (0.075,  40,1, 30,1, 30,1, 20,1, 40,1, 20,0)  OR
      si (0.09 ,  40,1, 30,1, 30,1, 20,9, 40,1, 20,1)  OR  si (0.12 ,  40,1, 30,1, 25,9, 20,9, 40,1, 20,0)  OR
      si (0.18 ,  40,1, 30,0, 25,9, 25,9, 40,1, 20,0)  OR  si (0.25 ,  40,9, 35,9, 30,9, 25,9, 40,1, 20,0)  OR
      si (0.37 ,  45,9, 40,9, 35,9, 30,9, 40,1, 20,0)  OR  si (0.55 ,  50,9, 40,9, 35,9, 30,9, 40,1, 40,1)  OR
      si (0.75 ,  50,9, 45,9, 40,9, 35,9, 40,1, 40,1)  OR  si (1.1  ,  55,9, 50,9, 40,9, 35,9, 40,1, 40,1)  OR
      si (1.5  ,  55,9, 50,9, 45,9, 41,9, 40,1, 40,1)  OR  si (2.2  ,  70,9, 55,9, 56,9, 53,9, 40,1, 67,1)  OR
      si (3.0  ,  75,9, 55,9, 61,9, 55,9, 42,0, 35,0)  OR  si (4.0  ,  75,9, 70,9, 71,9, 52,8, 45,0, 45,0)  OR
      si (5.5  ,  78,9, 73,9, 69,9, 54,9, 45,0, 42,0)  OR  si (7.5  ,  85,9, 79,9, 67,8, 54,8, 44,0, 46,0)  OR
      si (11   ,  63,8, 67,8, 71,9, 59,8, 52,0, 50,0)  OR  si (15   ,  66,8, 68,8, 70,8, 74,9, 52,0, 46,0)  OR
      si (18.5 ,  73,8, 70,8, 70,9, 62,8, 52,1, 48,1)  OR  si (22   ,  72,8, 70,8, 72,9, 60,9, 52,1, 48,0)  OR
      si (30   ,  73,9, 67,9, 66,8, 71,9, 50,0, 55,0)  OR  si (37   ,  73,9, 66,8, 70,8, 73,8, 67,0, 53,0)  OR
      si (45   ,  73,9, 67,9, 67,8, 76,8, 66,0, 50,0)  OR  si (55   ,  69,8, 66,8, 70,9, 71,9, 62,0, 52,0)  OR
      si (75   ,  75,9, 69,8, 74,9, 71,9, 55,0, 50,0)  OR  si (90   ,  76,8, 72,8, 75,9, 74,9, 64,0, 55,0)  OR
      si (110  ,  76,9, 72,8, 74,9, 73,9, 57,0, 55,0)  OR  si (132  ,  74,9, 71,8, 75,9, 58,9, 55,0, 55,0)  OR
      si (160  ,  75,9, 72,8, 68,9, 63,9, 55,0, 60,1)  OR  si (200  ,  78,9, 72,8, 71,9, 66,9, 55,1, 60,1)  OR
      si (250  ,  66,9, 72,9, 75,9, 66,9, 55,1, 60,1)  OR  si (315  ,  77,9, 76,9, 73,9, 63,9, 55,1, 60,1)  OR
      si (355  ,  71,8, 68,9, 76,9, 66,9, 55,1, 60,1)  OR  si (400  ,  77,9, 69,9, 64,9, 57,9, 55,1, 60,1)  OR
      si (450  ,  79,9, 76,9, 68,9, 54,9, 55,1, 60,1)  OR  si (500  ,  70,9, 76,9, 68,9, 54,9, 55,1, 60,1)  OR
      si (560  ,  73,9, 66,9, 60,9, 55,9, 55,4, 60,4)  OR  si (630  ,  62,9, 69,9, 58,9, 55,9, 55,4, 60,4)  OR
      si (710  ,  62,9, 68,9, 57,9, 54,9, 57,4, 62,4)  OR  si (800  ,  64,9, 60,9, 58,9, 54,9, 57,4, 62,4)  OR
      si (900  ,  64,9, 60,9, 57,9, 54,9, 57,4, 62,4)  OR  si (1000 ,  63,0, 61,0, 57,0, 56,0, 57,4, 62,4)  OR
      si (1120 ,  61,0, 61,0, 58,0, 56,0, 57,4, 62,4)  OR  si (1250 ,  62,0, 62,0, 58,0, 57,0, 57,4, 62,4)
      THEN  begin end  ELSE
      si (1400 ,  62,4, 62,0, 58,4, 57,4, 57,4, 62,4);//=Täysin arvattu
END;//fStN
FUNCTION fIn (P,COS :Real;   NAP :Integer) :Real;            // In = Pn[kW] / { (Un/1000) * V¨3 *cos *Eta }
var Uv,eta,r :real;   BEGIN
   Uv := fUmv;  eta := feta (P,NAP);                         //<Uv,eta,r  Debuggerin Breakpointin takia
   IF (P=0)  OR  (COS=0)  OR  (NAP=0)
   THEN r := 0
 //ELSE fin := P /( Umo/1000 * Sqrt (3) * COS * feta (P,NAP) );  //=Alp. #####################################
   ELSE r :=  P / ( (Uv/1000) * 3 * COS * eta);               //<fUmv/1000 = kW :lle #######
   Result := r;                                               //'In = Pn[kW] / { (Uv/1000) *   3 *cos *Eta }
END;                                                          //,,KUTSUT:  Moot.INC, NolamF1.INC, Nolam2.INC
FUNCTION fIst (P,COS :Real;   NAP :Integer) :Real;     VAR Im,StM :real;   BEGIN
   Im := fIn (P,COS,NAP);                                     //<,Debuggerin takia <<<<<<<<<<<<<<<<<
   StM := fStN (P,NAP);
   Result := Im * StM;
  {Result := fIn (P,COS,NAP) * fStN (P,NAP);   }END;
{''Kutsussa COS pitää antaa fCos(Pnim,CosNim) mukaisena, koska Ist = fIn * fStN ja fStn :ssä on jo huomioitu
   CosStart. Näin, jotta fIn palauttaisi oikean arvon fIst :lle @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ MoFnc1.INC

