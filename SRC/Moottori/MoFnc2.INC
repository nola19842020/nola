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

//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ MoFnc2.INC
{ fTim  yhteensa
//a_getIntg (30311..
============================================================================}
//NCTION fTim (kuormaON :Boolean;  P :Real;  Nap :Integer) :Real;  =INTERFACE -esittely MOOT.PAS :ssa
FUNCTION fTim;
   PROCEDURE si (rPm :Integer;  Tn,Tsn,Tmn,J :Real);   VAR Kj,Vl,r8 :Real;
   BEGIN
      Kj := 2;             //<2   =Kuorman Jl=Moottorin Jm (hitausmom)<<<<<<<
      Vl := 0.4;           //<0.4 =Tulettimet,pumput 0.5=Lingot 1=kuljettimet
      IF NOT kuormaON  THEN BEGIN Kj := 1;  Vl := 0;  END;    //<Tyhjä akseli
   {....... Kj *J * 2*pii * n / 60s [kgm2]         J  =HitausMom  n=Kierroslkm
   Tstart = ----------------------- ------ [=s]    Tn =NimelVääntöMom
            Tn * ((Tsn+Tmn)/2 - Vl)  [Nm]          Tsn=KäynnistMom/NimelMom
                                                   Tmn=MaxMom/NimelMom
   .........................................................................}
      r8 := (Kj *J *2*3.1416*rPm / 60) / (Tn *((Tsn+Tmn)/2 -Vl));
      r8 := fMuokdes (r8,2);   fTim := r8;                               END;
BEGIN//fTim
CASE Nap OF         //(r/min, Tn  , Tsn, Tmn,  J       )<<<<<<<<<<<<<<<<<<<<<
2 :IF P<=0.25 THEN si ( 2790, 0.85, 2.2, 2.7, 0.00018  )  ELSE
   IF P<=0.37 THEN si ( 2840, 1.25, 2.2, 2.7, 0.0004   )  ELSE
   IF P<=0.55 THEN si ( 2850, 1.9 , 2.2, 2.7, 0.0005   )  ELSE
   IF P<=0.75 THEN si ( 2860, 2.5 , 2.2, 2.7, 0.0009   )  ELSE
   IF P<=1.1  THEN si ( 2870, 3.7 , 2.4, 3  , 0.0011   )  ELSE
   IF P<=1.5  THEN si ( 2870, 5   , 2.4, 3  , 0.0019   )  ELSE
   IF P<=2.2  THEN si ( 2870, 7.5 , 2.7, 3.4, 0.0024   )  ELSE
   IF P<=3.0  THEN si ( 2900, 10  , 2.7, 3.6, 0.0041   )  ELSE
   IF P<=4.0  THEN si ( 2850, 13.4, 2.8, 3  , 0.01     )  ELSE
   IF P<=5.5  THEN si ( 2855, 18.4, 3.2, 3.4, 0.014    )  ELSE
   IF P<=7.5  THEN si ( 2855, 25.1, 3.4, 3.6, 0.016    )  ELSE
   IF P<=11   THEN si ( 2930, 36  , 2.8, 3  , 0.039    )  ELSE
   IF P<=15   THEN si ( 2930, 49  , 2.8, 3  , 0.047    )  ELSE
   IF P<=18.5 THEN si ( 2920, 61  , 3.1, 3.5, 0.053    )  ELSE
   IF P<=22   THEN si ( 2945, 71  , 2.6, 3.2, 0.077    )  ELSE
   IF P<=30   THEN si ( 2955, 97  , 2.4, 3.1, 0.15     )  ELSE
   IF P<=37   THEN si ( 2950, 120 , 2.5, 3.2, 0.18     )  ELSE
   IF P<=45   THEN si ( 2960, 145 , 2.5, 2.8, 0.26     )  ELSE
   IF P<=55   THEN si ( 2970, 177 , 2  , 3  , 0.29     )  ELSE
{1}IF P<=75   THEN si ( 2977, 241 , 2  , 2.9, 0.57     )  ELSE
   IF P<=90   THEN si ( 2975, 289 , 2.1, 2.7, 0.9      )  ELSE
   IF P<=110  THEN si ( 2982, 352 , 2  , 3  , 1.15     )  ELSE
   IF P<=132  THEN si ( 2982, 423 , 2.2, 3  , 1.4      )  ELSE
   IF P<=160  THEN si ( 2981, 513 , 2.3, 3  , 1.7      )  ELSE
   IF P<=200  THEN si ( 2976, 641 , 2.6, 3  , 2.1      )  ELSE
   IF P<=250  THEN si ( 2980, 801 , 1.3, 3  , 3.8      )  ELSE
   IF P<=315  THEN si ( 2978, 1010, 1.3, 3.3, 4.8      )  ELSE
   IF P<=400  THEN si ( 2982, 1281, 1.6, 3.3, 5.1      )  ELSE
   IF P<=450  THEN si ( 2977, 1444, 1.2, 3.2, 5.2      )  ELSE
   IF P<=500  THEN si ( 2977, 1604, 0.8, 2.8, 7.5      )  ELSE
   IF P<=560  THEN si ( 2983, 1793, 0.7, 3.4, 8.5      )  ELSE
{2}IF P<=630  THEN si ( 2984, 2016, 0.7, 2.6, 13       )  ELSE
   IF P<=710  THEN si ( 2984, 2272, 0.7, 2.5, 14       )  ELSE
   IF P<=800  THEN si ( 2985, 2560, 0.8, 2.5, 16       )  ELSE
   IF P<=900  THEN si ( 2986, 2878, 0.8, 2.6, 16       )  ELSE
   IF P<=1000 THEN si ( 2988, 3196, 0.7, 2.6, 26       )  ELSE
   IF P<=1120 THEN si ( 2987, 3581, 0.7, 2.5, 28       )  ELSE
     {P<=1250}     si ( 2986, 3995, 0.7, 2.5, 33       );
                    //(r/min, Tn  , Tsn, Tmn,  J       )<<<<<<<<<<<<<<<<<<<<<
4 :IF P<=0.18 THEN si ( 1370, 1.25, 2.2, 2.6, 0.00028  )  ELSE
   IF P<=0.25 THEN si ( 1400, 1.7 , 2.2, 2.7, 0.00073  )  ELSE
   IF P<=0.37 THEN si ( 1410, 2.5 , 2.2, 2.7, 0.00098  )  ELSE
   IF P<=0.55 THEN si ( 1420, 3.7 , 2.2, 2.7, 0.0017   )  ELSE
   IF P<=0.75 THEN si ( 1420, 5   , 2.2, 2.7, 0.0021   )  ELSE
   IF P<=1.1  THEN si ( 1410, 7.5 , 2.2, 2.7, 0.0032   )  ELSE
   IF P<=1.5  THEN si ( 1420, 10  , 2.4, 2.9, 0.0043   )  ELSE
   IF P<=2.2  THEN si ( 1430, 15  , 2.4, 2.9, 0.0039   )  ELSE
   IF P<=3.0  THEN si ( 1430, 20  , 2.5, 2.9, 0.0082   )  ELSE
   IF P<=4.0  THEN si ( 1435, 26.6, 2.9, 3.1, 0.015    )  ELSE
   IF P<=5.5  THEN si ( 1450, 36.2, 2.2, 3  , 0.031    )  ELSE
   IF P<=7.5  THEN si ( 1450, 49.4, 2.5, 3.2, 0.038    )  ELSE
   IF P<=11   THEN si ( 1455, 72  , 3.1, 3.3, 0.067    )  ELSE
   IF P<=15   THEN si ( 1460, 98  , 3.2, 3.5, 0.091    )  ELSE
   IF P<=18.5 THEN si ( 1475, 120 , 2.6, 3.2, 0.161    )  ELSE
   IF P<=22   THEN si ( 1475, 142 , 2.6, 3.2, 0.191    )  ELSE
   IF P<=30   THEN si ( 1475, 194 , 2.6, 2.8, 0.29     )  ELSE
   IF P<=37   THEN si ( 1475, 236 , 3.6, 3.2, 0.34     )  ELSE
   IF P<=45   THEN si ( 1480, 290 , 2.7, 2.6, 0.42     )  ELSE
{1}IF P<=55   THEN si ( 1480, 355 , 2.3, 2.8, 0.49     )  ELSE
   IF P<=75   THEN si ( 1484, 483 , 2.3, 2.8, 0.88     )  ELSE
   IF P<=90   THEN si ( 1483, 580 , 2.4, 2.7, 1.5      )  ELSE
   IF P<=110  THEN si ( 1487, 706 , 2  , 2.5, 1.85     )  ELSE
   IF P<=132  THEN si ( 1487, 848 , 2.6, 2.7, 2.6      )  ELSE
   IF P<=160  THEN si ( 1487, 1028, 2.4, 2.7, 2.9      )  ELSE
   IF P<=200  THEN si ( 1486, 1285, 2.5, 2.7, 3.5      )  ELSE
   IF P<=250  THEN si ( 1487, 1606, 2.3, 2.8, 6.5      )  ELSE
   IF P<=315  THEN si ( 1488, 2022, 2.5, 3  , 8.2      )  ELSE
   IF P<=355  THEN si ( 1486, 2281, 2.2, 2.7, 8.2      )  ELSE
   IF P<=400  THEN si ( 1489, 2565, 1.6, 2.8, 10       )  ELSE
   IF P<=450  THEN si ( 1489, 2886, 1.5, 3  , 10       )  ELSE
   IF P<=500  THEN si ( 1489, 3207, 1.3, 2.9, 10.5     )  ELSE
   IF P<=560  THEN si ( 1489, 3591, 1.1, 2.6, 14       )  ELSE
   IF P<=630  THEN si ( 1489, 4040, 1.2, 2.8, 15       )  ELSE
   IF P<=710  THEN si ( 1488, 4556, 1.2, 2.7, 15       )  ELSE
{2}IF P<=800  THEN si ( 1493, 5119, 1  , 2.1, 30       )  ELSE
   IF P<=900  THEN si ( 1492, 5759, 0.9, 2.2, 32       )  ELSE
   IF P<=1000 THEN si ( 1493, 6397, 0.9, 2.2, 36       )  ELSE
   IF P<=1120 THEN si ( 1494, 7161, 0.7, 2.4, 51       )  ELSE
   IF P<=1250 THEN si ( 1494, 7989, 0.7, 2.4, 57       )  ELSE
     {P<=1400}     si ( 1496, 8945, 0.7, 2.4, 64     );
                    //(r/min, Tn  , Tsn, Tmn,  J       )<<<<<<<<<<<<<<<<<<<<<
6 :IF P<=0.12 THEN si ( 930 , 1.2 , 2.3, 2.7, 0.0007   )  ELSE
   IF P<=0.18 THEN si ( 920 , 1.9 , 2  , 2.4, 0.0007   )  ELSE
   IF P<=0.25 THEN si ( 920 , 2.6 , 2  , 2.4, 0.0009   )  ELSE
   IF P<=0.37 THEN si ( 920 , 3.8 , 2.1, 2.5, 0.0017   )  ELSE
   IF P<=0.55 THEN si ( 930 , 5.7 , 2.1, 2.5, 0.0021   )  ELSE
   IF P<=0.75 THEN si ( 930 , 7.5 , 1.9, 2.3, 0.0032   )  ELSE
   IF P<=1.1  THEN si ( 930 , 11  , 1.9, 2.3, 0.0043   )  ELSE
   IF P<=1.5  THEN si ( 950 , 15  , 1.9, 2.3, 0.0082   )  ELSE
   IF P<=2.2  THEN si ( 940 , 22.3, 2.1, 2.7, 0.015    )  ELSE
   IF P<=3.0  THEN si ( 960 , 29.8, 2.4, 2.6, 0.031    )  ELSE
   IF P<=4.0  THEN si ( 960 , 39.7, 2.6, 2.8, 0.038    )  ELSE
   IF P<=5.5  THEN si ( 955 , 55  , 2.8, 2.8, 0.045    )  ELSE
   IF P<=7.5  THEN si ( 975 , 73  , 2.3, 2.3, 0.089    )  ELSE
   IF P<=11   THEN si ( 970 , 108 , 2.3, 3.1, 0.105    )  ELSE
   IF P<=15   THEN si ( 975 , 145 , 2.6, 3.3, 0.217    )  ELSE
   IF P<=18.5 THEN si ( 985 , 179 , 2.5, 2.7, 0.37     )  ELSE
   IF P<=22   THEN si ( 980 , 214 , 2.5, 2.7, 0.43     )  ELSE
   IF P<=30   THEN si ( 980 , 292 , 3.3, 3  , 0.64     )  ELSE
   IF P<=37   THEN si ( 985 , 359 , 3.1, 3  , 0.75     )  ELSE
   IF P<=45   THEN si ( 990 , 434 , 2.7, 2.6, 1.49     )  ELSE
{1}IF P<=55   THEN si ( 990 , 531 , 2.8, 2.6, 2.2      )  ELSE
   IF P<=75   THEN si ( 990 , 723 , 2.4, 2.7, 2.85     )  ELSE
   IF P<=90   THEN si ( 990 , 868 , 2.5, 2.6, 4.1      )  ELSE
   IF P<=110  THEN si ( 989 , 1062, 2.7, 2.7, 4.9      )  ELSE
   IF P<=132  THEN si ( 989 , 1275, 2.7, 2.7, 5.8      )  ELSE
   IF P<=160  THEN si ( 992 , 1540, 1.8, 2.7, 10.4     )  ELSE
   IF P<=200  THEN si ( 992 , 1925, 2  , 2.7, 12.5     )  ELSE
   IF P<=250  THEN si ( 992 , 2407, 2.2, 2.8, 12.5     )  ELSE
   IF P<=315  THEN si ( 991 , 3036, 2  , 3  , 14.6     )  ELSE
   IF P<=355  THEN si ( 991 , 3421, 1.5, 3  , 15.8     )  ELSE
   IF P<=400  THEN si ( 992 , 3851, 1.2, 2.7, 16.5     )  ELSE
   IF P<=450  THEN si ( 993 , 4328, 1.3, 2.8, 19       )  ELSE
   IF P<=500  THEN si ( 992 , 4813, 1.3, 2.8, 19       )  ELSE
   IF P<=560  THEN si ( 994 , 5381, 1.1, 2  , 28       )  ELSE
{2}IF P<=630  THEN si ( 994 , 6054, 1  , 2.1, 37       )  ELSE
   IF P<=710  THEN si ( 994 , 6823, 0.9, 2.1, 38       )  ELSE
   IF P<=800  THEN si ( 994 , 7688, 1  , 2.1, 48       )  ELSE
   IF P<=900  THEN si ( 993 , 8652, 0.9, 2  , 58       )  ELSE
   IF P<=1000 THEN si ( 994 , 9612, 0.9, 2  , 65       )  ELSE
   IF P<=1120 THEN si ( 994 ,10763, 0.9, 2  , 80       )  ELSE
     {P<=1250}     si ( 994 ,12007, 0.9, 2.1, 93       );
    //,,,,,,,,,,,Tarkasti VAIN 8-napaisille,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
ELSE//8,(10,12)..(r/min, Tn  , Tsn, Tmn,  J       )<<<<<<<<<<<<<<<<<<<<<<<<<<
   IF P<=0.12 THEN si ( 680 , 1.8 , 1.7, 2  , 0.0009   )  ELSE
   IF P<=0.18 THEN si ( 700 , 2.5 , 1.8, 2.3, 0.0017   )  ELSE
   IF P<=0.25 THEN si ( 700 , 3.4 , 1.9, 2.4, 0.0021   )  ELSE
   IF P<=0.37 THEN si ( 700 , 5   , 1.9, 2.4, 0.0032   )  ELSE
   IF P<=0.55 THEN si ( 700 , 7.5 , 1.9, 2.4, 0.0043   )  ELSE
   IF P<=0.75 THEN si ( 700 , 10  , 2.1, 2.7, 0.0069   )  ELSE
   IF P<=1.1  THEN si ( 700 , 15  , 2.1, 2.7, 0.0082   )  ELSE
   IF P<=1.5  THEN si ( 695 , 20.6, 1.9, 2.4, 0.016    )  ELSE
   IF P<=2.2  THEN si ( 720 , 29.2, 1.9, 2.5, 0.038    )  ELSE
   IF P<=3.0  THEN si ( 720 , 39.8, 2.4, 2.5, 0.045    )  ELSE
   IF P<=4.0  THEN si ( 725 , 53  , 2.2, 3.3, 0.072    )  ELSE
   IF P<=5.5  THEN si ( 725 , 72  , 2  , 3.1, 0.091    )  ELSE
   IF P<=7.5  THEN si ( 725 , 99  , 2  , 3  , 0.131    )  ELSE
   IF P<=11   THEN si ( 720 , 146 , 1.6, 2.1, 0.224    )  ELSE
   IF P<=15   THEN si ( 740 , 194 , 1.8, 3  , 0.45     )  ELSE
   IF P<=18.5 THEN si ( 745 , 237 , 1.7, 2.8, 0.54     )  ELSE
   IF P<=22   THEN si ( 730 , 288 , 1.9, 2.7, 0.68     )  ELSE
   IF P<=30   THEN si ( 735 , 390 , 2.1, 3.3, 0.8      )  ELSE
{1}IF P<=37   THEN si ( 741 , 477 , 1.6, 2.7, 1.85     )  ELSE
   IF P<=45   THEN si ( 741 , 580 , 1.8, 2.8, 2.2      )  ELSE
   IF P<=55   THEN si ( 740 , 710 , 1.6, 2.7, 2.85     )  ELSE
   IF P<=75   THEN si ( 740 , 968 , 1.7, 2.7, 4.1      )  ELSE
   IF P<=90   THEN si ( 740 , 1161, 1.8, 2.7, 4.9      )  ELSE
   IF P<=110  THEN si ( 740 , 1420, 1.8, 2.7, 5.8      )  ELSE
   IF P<=132  THEN si ( 742 , 1699, 1.5, 2.3, 10.4     )  ELSE
   IF P<=160  THEN si ( 742 , 2059, 1.7, 2.4, 12.5     )  ELSE
   IF P<=200  THEN si ( 743 , 2571, 1.8, 2.7, 14.6     )  ELSE
   IF P<=250  THEN si ( 744 , 3209, 1.5, 3  , 15.8     )  ELSE
   IF P<=315  THEN si ( 744 , 4043, 1.4, 2.6, 16.5     )  ELSE
   IF P<=355  THEN si ( 744 , 4557, 1.5, 2.7, 19       )  ELSE
{2}IF P<=400  THEN si ( 744 , 5136, 1.2, 2.2, 28       )  ELSE
   IF P<=450  THEN si ( 744 , 5774, 1.1, 2  , 26       )  ELSE
   IF P<=500  THEN si ( 744 , 6416, 1.1, 2  , 31       )  ELSE
   IF P<=560  THEN si ( 744 , 7185, 1.1, 1.9, 35       )  ELSE
   IF P<=630  THEN si ( 745 , 8081, 1.1, 1.9, 41       )  ELSE
   IF P<=710  THEN si ( 745 , 9108, 1.1, 1.9, 51       )  ELSE
   IF P<=800  THEN si ( 745 ,10255, 1  , 2  , 58       )  ELSE
   IF P<=900  THEN si ( 745 ,11530, 1  , 2  , 67       )  ELSE
   IF P<=1000 THEN si ( 745 ,12819, 1  , 2  , 76       )  ELSE
   IF P<=1120 THEN si ( 745 ,14353, 1  , 2.1, 91       )  ELSE
     {P<=1250}     si ( 745 ,16017, 1  , 2.1, 98       );
END;{CASE} END;//fTim
//---------------------------------------------------------------------------
//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ,,, NOLAm3.INC
PROCEDURE yhteensa;   CONST arMax=10;   VAR i,j,n,m :Integer;  ss :string;      //<+2.0.5  arMax
                                            rP,rX, inY,istY,istYe,MgTim :Real;
                                            arr :ARRAY [0..arMax] Of Real;      //<[10]=KÄYVÄyhtKW
                                            Qnap,Qkpl :integer;   Qkw,Qcos,Qtim :real;
                                         //,Vaihdetaan SUCSE -tyyppi, jos aM tyyppi ei riitä (IsnikFnc muutti)
   PROCEDURE tarkista_ChkOFAdzRaja (VAR sulTyp :string;  sulKoko :integer);      begin
      if ChkOFAdzRaja (sulTyp,sulKoko)
      then begin
         EiOkInfo ('Edeltävän verkon sulaketyyppivalinta joudutaan vaihtamaan OFAAgG :stä IECgG :ksi, '+
                   'koska OFAAgG :ssa ei ole >630 A :n sulaketta. Muutos vaikuttaa myös tässä yläpanelin '+
                   '"Sulake" -tyyppiin!');
         asetaIecOfaRadVal (sulTyp);  end;
   end;
//,,SijNjSul sijoittaa MoNj.mSul,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
PROCEDURE SijNjSul;       VAR i,j,m,i1,sul, Anap :Integer;   at,ap, Akw,Acos :Real;
   { ### N p.o. si-### }      tar :ARRAY [1..momax] Of Integer;   //suQs :string;
   { ### joitettu!!### }                            //'tar =n OSOITTEETsortat
                                            BEGIN   //tuna LYHYIMÄSTÄ tim:stä
   m := 0;  sul := 0;                               //PISIMPÄÄN <<<<<<<<<<<<<
if motja>0  then begin
   FOR i := 1 TO motja  DO
   IF (a_getIntg (30311, mo.motr[i].rno) =n)  AND
      (a_getIntg (30312, mo.motr[i].kpl) >0)  THEN BEGIN
      m := m+1;                                    //varm vuoksi''<<<<<<<<<<<
      tar [m] := i;   END;                      //<TARissa n -rno:n osoitteet

   FOR i := 1 TO m-1   DO BEGIN
      j := i;
      REPEAT  j := j+1;
         at := a_getReaa (30313, mo.motr[tar [i]].tim);
         IF a_getReaa (30314, mo.motr[tar [j]].tim) < at  THEN BEGIN   //<Oli pienempi TIM<<<<<<
            i1 := tar [i];                          //<EntOS [i] talteen<<<<<
            tar [i] := tar [j];                     //<UusOS aikaisemmksi=[i]
            tar [j] := i1;          END;            //<EntOS [i] jälemmäksi<<
      UNTIL  j=m;
   END;//FOR i                                //,,,SUL p.o. > InYHTtot<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   sul := 0;   REPEAT  seurSul (sul);   UNTIL  (sul>=inY*1.1)  OR  (sul=0);
   IF sul>0  THEN BEGIN
      ap := 0;                                           //,Lasket valmiiksiMAXvirta, jotaSilmukassa
      FOR i := 1 TO m   DO  WITH mo.motr[tar [i]]        //<pienennet = vähemmän operaatioita ######
         DO BEGIN
           {ap := ap +fIst (a_getReaa (30315,kw), a_getReaa (30316,cos),
                            a_getIntg (30317,nap)) * a_getIntg (30318,kpl);}
            Akw := a_getReaa (30315,kw);   Anap := a_getIntg (30316,nap);   Acos := fCos (Akw,Anap);
            ap := ap +fIst (Akw,Acos,Anap) * a_getIntg (30317,kpl);  END; //'=fIst AINA nimellisCosinin muk.!!

      ap := ap + inY;                                    //<MAXvirta-arvo = Käynnistyvän RNOn Ist + inYHTtot
     {if a_getStrg (30315, edv.YLE.IecOfa)  then suQs := su_IECg
                                            else suQs := su_OFAg;}
      FOR i := 1 TO m   DO  WITH mo.motr[tar [i]]  DO BEGIN
                                                         //SUL p.o. > InYHTtot<<<<<<<<<<<<<,,,<<<<<<
       //WHILE (Tik (suQs,sul,ap*1.1) < a_getReaa (30318,tim))  AND  (sul>0)   DO seurSul (sul);    //< -2.0.1
                             //'''Isontaa 10% virta-arvoa =lähentää SULkäyrää<<<<<<<<<<<<<<<<<<<<<<<
         tarkista_ChkOFAdzRaja (suCse,sul); //<Vaihdetaan SUCSE -tyyppi, jos aM tyyppi ei riitä (IsnikFnc muutti)
                //,###### Yht.SULakkeen kestettvä AP -virtaa myös toler.AR:n kohdalla ajan TIM ##### ='2.0.1=0.0
         WHILE (TikAR (suCse,sul,ap) < a_getReaa (30318,tim))  AND  (sul>0)   DO begin //<'SamaTulos
            seurSul (sul);
            tarkista_ChkOFAdzRaja (suCse,sul); //<Vaihdetaan SUCSE -tyyppi, jos aM tyyppi ei riitä (IsnikFnc muutti)
         end;
        {ap := ap -fIst (a_getReaa (30322,kw), a_getReaa (30322,cos),  //<Seur VIRTA pienen TIM kasv
                         a_getIntg (30323,nap)) * a_getIntg (30324,kpl);}
                                                                          //,=fIst AINA nimellisCosinin muk.!!
         Akw := a_getReaa (30322,kw);   Anap := a_getIntg (30323,nap);   Acos := fCos (Akw,Anap);
         ap := ap -fIst (Akw,Acos,Anap) * a_getIntg (30324,kpl);         //<Seur VIRTA pienen TIM kasv

         IF ap<0  THEN ap := 0;                 //<Mahd laskentaepätarkkTakia
      END;
   END;//ELSE
end;//if motja>0
   MoNj.mSul := sul; //<SIJOITUS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
END;//SijNjSul;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
BEGIN//yhteensä
   rP := 0;  rX := 0;    for i := 1 to arMax  do arr [i] := 0;  //<ARR apuna->Ps,Coss    +2.0.5  for i
   FOR i := 1 TO motja   DO  WITH mo.motr[i]   DO begin
      Qnap := a_getIntg (30331,nap);
      Qkpl := a_getIntg (30332,kpl);
      Qkw :=  a_getReaa (30333,kw);
      Qcos := a_getReaa (30334,cos);
      IF (Qkw>0) AND (Qcos>0)  THEN BEGIN //,,
{Py}     rP := rP +Qkpl*QkW;                                      //< Pystysarak Pyht
         if Qkw/Qcos > Qkw                                        //<Varm.vuoksi +6.0.0
{Qy}        then rX := rX +Qkpl*Sqrt ( Sqr(Qkw/Qcos) - Sqr(Qkw) ) //< rX= Q =V¨(Sý-Pý)
            else rX := rX +Qkpl*Qkw;
         IF a_getIntg (30335, rno) >0  THEN BEGIN
{Pe}        arr [1] := arr [1] + Qkpl*Qkw/fEta (Qkw,Qnap);  //<EtallaKorjttu yhtEkvPn, jotta I=P/(U*V¨3Cos)@@@
            if Qkw/Qcos > Qkw                                     //<Varm.vuoksi +6.0.0
{Qe}           then arr [2] := arr [2] + Qkpl*Sqrt ( Sqr(Qkw/Qcos) - Sqr(Qkw) ) //<yhtQekv=V¨(S²-P²)/eta @@@@@@@@
                                         /fEta (Qkw,Qnap)   //<fEtaTässäkin,todttu ##############################
               else arr [2] := arr [2] + Qkpl*Qkw/fEta (Qkw,Qnap);
         END; END;
   end;//with

   MoNj.mPekv := arr [1];                                 //<NOLAj: EkvivPs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if MoNj.mPekv>0  then begin //<+2.0.5  if ..>0  Ohitetaan LOPPUUN asti ##########################################
   IF rP>0  THEN
      {MoNj.mCosEkv := cosi (arctang (arr[2]/arr[1]));        //<NOLAj: EkvivCoss %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      ''=alp}        //,,P / V¨(Q²+P²) = P / S ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      MoNj.mCosEkv := arr[1] / Sqrt ( Sqr(arr[2]) + Sqr(arr[1]) ); //<NOLAj: EkvivCoss %%%%%%%%%%%%%%%%%%%%%%%%%%
                                                          //'cos (Arct(Q/P))-------------------------------------
   ss := '=>     Pyht = '+strKw (0, rp)+' kW   Cos'+FONT_FII+' = '+
  {fRmrkt0 (cosi (arctang (rX/rP)), 1,3)+'     =>     <b>Pekv = </b>';     //<alp}
         fRmrkt0 (rp / Sqrt ( Sqr(rP) + Sqr(rX) ), 1,3)+'     =>     <b>Pekv = </b>';

   //################################### inY,istY,istYe lask.osa ############
      FOR i := 0 TO 10  DO arr [i] := 0;   //<SIJOITETAAN arr [] ############
      rP := 0;   n := 0;   m := 0;         //<EKAXetsitään MAXkwRNO =n ######
   FOR i := 0 TO 9  DO  BEGIN   rX := 0;   j := 0;    //<i=RNO<<<<<<<<<<<<<<<
   WHILE j<motja    DO  BEGIN   j := j+1;             //'m='_' ja '+' tarve<<
   WITH mo.motr[j]  DO
      IF a_getIntg (30336, kpl)=0   THEN j := motja   ELSE //<motja ohjaa ulos WHILE
      IF a_getIntg (30337, rno)=i   THEN                   //<RNO alustettu 0ksi
         rX := rX+ a_getReaa (30341, kw) * a_getIntg (30342, kpl);
   END;//WHILE,WITH                             //,,SuurinKWosa+RNO(n)talteen
      IF (i>0) AND (rX>rP)   THEN BEGIN  rP := rX;  n := i;  END;
      arr [i] := rX;                            //<Talteen tulostVarten RnoKW
      IF (i>0) AND (rX>0) AND (i>0)             //'''RNO=0 myös sijoitettu. O
         THEN m := m+1;   //''''lisäys17.4.94   //lisi vertailtavissa IF[0]>
   END;//FOR i                                  //[n].xx ja herjattavissa####
                                       //'''m=KÄYTÖSSÄ OLEVIA RNOja pl. 0(=i)
   FOR i := 1 TO 9  DO                               //<1 TO..= [0] EI HUOMDA
      IF i<>n  THEN arr [10] := arr [10] +arr [i];   //<KÄYVÄn osan YhtKW<<<<

      inY := 0;   istY := 0;  istYe := 0;            //<inY  =In YHT   -rno=0
      MgTim := 0;   rX := 0;                         //'istY =Ist YHT  -rno=0
   FOR i := 1 TO motja  DO                           //'istYe=rnoN käynnistyy
   WITH mo.motr[i]      DO                           //'      muut käy -rno=0
   IF a_getIntg (30343, kpl) =0  THEN Break
   ELSE  IF a_getIntg (30344, rno) >0  THEN BEGIN//<Poisluk. RNO=0 ##########
      Qnap := a_getIntg (30335,nap);
      Qkpl := a_getIntg (30336,kpl);
      Qkw :=  a_getReaa (30337,kw);
      Qcos := a_getReaa (30338,cos);
      Qtim := a_getReaa (30339,tim);
      inY :=  inY  +fIn  (Qkw,Qcos,Qnap) *Qkpl;
    //istY := istY +fIst (Qkw,Qcos,Qnap) *Qkpl;              //<## EI KÄYTÖSSÄ ##############
      istY := istY +fIst (Qkw, fCos(Qkw,Qnap), Qnap) *Qkpl;  //<## EI KÄYTÖSSÄ ##############
      IF a_getIntg (30339, rno) =n  THEN BEGIN   //,,,KÄYNNISTYVIEN ekviv.Ik1s ##
       //istYe := istYe +Sqrt (Sqr (fIst (Qkw,Qcos,Qnap)) *Qtim) *Qkpl;
         istYe := istYe +Sqrt (Sqr (fIst (Qkw, fCos(Qkw,Qnap), Qnap)) *Qtim) *Qkpl; //<fIst AINA nimellisCosinin muk.!!
         IF Qtim>MgTim  THEN MgTim := Qtim;  END    //<Pisin aika määrääväksi
      ELSE rX := rX +fin (Qkw,Qcos,Qnap) *Qkpl;     //<rX =KÄYVIEN RNOn InYHT
   END;//IF rno>0,WITH,FOR

   IF istYe>0  THEN istYe := Sqrt (Sqr (istYe)/MgTim);
                                              //'Ekviv. Iks redusoituna MgTim
                                              // -aikaan (katkaisija-asetus)
   istYe := istYe + rX;                    //<LISÄTÄÄN KÄYVIEN Ist = +rX ####

   MoNj.mItrm := inY;                         //<NOLAj: <<<<<<<<<InYht eiRno0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   MoNj.mImg := istYe;                        //<NOLAj: <<<<<<<<<IstYht<<-"-< %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   MoNj.mTim := MgTim;                        //<NOLAj: TimEkviv/IstYht<<-"-< %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

{¤-IF inY>INmax  THEN BEGIN  piip; scd; scb;  eiulos := TRUE;  END //?????????????????????????????????????????
                 ELSE eiulos := FALSE;}
   SijNjSul; //<Laski + sij NJ-sulakkeen:  MoNj.mSul := sul %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   ss := ss          +strKw (1, MoNj.mPekv) +' kW   '+               //<Pekv
         'Cos'+FONT_FII+'ekv = '+
                      strKw (1, MoNj.mCosEkv) +'     =>     '+       //<CosEkv
         '<b>Sulake = </b>';
   if MoNj.mSul >0
      then ss := ss +sijI (1, MoNj.mSul)
      else ss := ss +'- - -';
   ss := ss+' A (' +suCse +')     <b>Katkaisija :</b>   ImgMin = '+
                      strRd (1, MoNj.mImg,  1,2)+' A / '+            //<Img
                      strRd (1, MoNj.mTim,  1,1)+' s   '+            //<Tim
          'IthMin = '+strRd (1, MoNj.mItrm, 1,2)+' A.';              //<ITerm =In
   MoFrm.LbY1r2.Caption := ss; //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   ss := '<b>Nj-mitoituksessa :</b>   ';
   j := 0;                                 //<j ilmaisee '+'-tarpeen = IF j<m
   IF m>1  THEN ss := ss +'RyhN:o ';
   FOR i := 1 TO 9  DO
   IF (arr [i]>0) AND (i<>n)  THEN BEGIN
      ss := ss +fImrkt0 (i,1);
      j := j+1;
      IF j<m-1  THEN ss := ss +'+'         //<+2 =i+ '+'
                ELSE ss := ss +'=';        //<+3 =i+ '= '
   END;//FOR i, IFF (arr..

   ss := '<b>';
   ss := ss +strKw (0, arr [10]) +' kW  KÄY</b>   RyhN:o '+
             sijI (0, n) +' = <b>'+
             strKw (1, rP) +' kW  KÄYNNISTYY.</b>     ';

   j := 0;
   IF m>1  THEN BEGIN
      ss := ss +'Käytetyt käynnnistysryhmät :   ';
      FOR i := 1 TO 9  DO
      IF arr [i] >0   THEN BEGIN
         IF j>0  THEN ss := ss +'  ';                   //<Väli ed:n jälkeen
         IF i=n  THEN ss := ss +'<b>';
         ss := ss +fImrkt0 (i,1){+' = '+strKw (0, arr[i])};
         IF i=n  THEN ss := ss +'</b>';
         j := j+1;
      END;
   END;//IF m>1, FOR i, IF arr [i]>0
   MoFrm.OkBtn.Enabled := true;
   MoFrm.LbY1r1.Caption := ss; //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end//if MoNj.mPekv>0
else begin
   MoFrm.OkBtn.Enabled := false;
   MoFrm.LbY1r1.Caption := ''; //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   MoFrm.LbY1r2.Caption := '=>     Pyht = 0 kW   <b>Ei kuormittavia lähtöjä käynnistysryhmissä 1..9.</b>';
end;
   n := 0;  FOR i := 1 TO motja  DO  n := n +a_getIntg (30336, mo.motr[i].kpl);
   MoFrm.LbA1.Caption := 'Rivejä :  <b>'+fImrkt0 (motja,1)+'</b>    moottorilähtöjä yht :  '+
                   '<b>'+fImrkt0 (n,1)+'</b> kpl.'; //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
END;//yhteensa
//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ MoFnc2.INC


