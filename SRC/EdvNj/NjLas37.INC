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

{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NjLas37.INC }
{NjTul30.INC, 31.INC, 31.INC, 37.INC, 38.INC INCLUUDATTU NjTul3.PAS :ssa
===================================================================================================}
FUNCTION fKi :Real;            //< Kerroin fKi muuttaa S :n (kVA)  I :ksi (A)
      VAR N :Integer;  ar{+8.0.4} :real;      BEGIN
   N := a_getIntg (37011, edv.YLE.VaiheLkm);
   IF not (N  IN [1,3])  THEN N := 3;          //< Varm.vuoksi
   ar := fUv;                           //Uv=220 ki=4.54545, Uv=230 ki=4.3478
   ar := 1 / (N*ar/1000);               //<U=381 ki=1.51515, U =398 ki=1.4493
   result := ar;                        //Uv=220 U=381.05    Uv=230 U=398.372
   if (ar<999) and (2<1)  then beep;    //<Debuggerille +8.0.4
END;//FNC fKi
//=========================================================================== ,fV_U_k siirretty Y_.PAS  6.0.0
FUNCTION tultauTos (QJtyp :string) :Integer;      BEGIN //<TULTAUn TYYPIn osoite
 //if QJtyp='SVjärjest.'  then Result := 3  else        //<TYYPPI on oltava EHDOTTOMASTI OIKEIN #### -6.0.2
   if fOnSV (QJtyp)  then Result := 3  else             //<TYYPPI on oltava EHDOTTOMASTI OIKEIN #### +6.0.2
   if fAlCu (QJtyp)  then Result := 1  else Result := 2;   end;

FUNCTION tultauAos (mm2 :Integer) :Integer;       VAR os :integer;   BEGIN//<TULTAUn njmm2 :n osoite
   CASE mm2 OF         6 :os := 1;      10 :os := 2;      16 :os := 3;
    25 :os := 4;      35 :os := 5;      50 :os := 6;      70 :os := 7;
    95 :os := 8;     120 :os := 9;     150 :os := 10;    185 :os := 11;
   240 :os := 12;    300 :os := 13;    600 :os := 14;    900 :os := 15;
  1200 :os := 16;   2400 :os := 17;   else  os := 18;{=3200} END;  Result := os;   END;
//............................................
FUNCTION kaapontul :Boolean;                        //,0 varattiin min.ve:lle
BEGIN kaapontul := FALSE;
      IF tultau[tultauTos(NJtyp),tultauAos(trunc (NJmm2)),NJkaapx] >0.1  THEN kaapontul := TRUE;
END;//kaapontul
//............................................
PROCEDURE tyhtultau;  VAR i,j :Integer;
   (*PROCEDURE seurA (VAR nykA :Integer);     BEGIN   <<<EI TARVITA !!!!!!!!!
      CASE nykA OF     {1 :nykA :=  2;     2 :nykA :=  6;}   6 :nykA := 10;
      10 :nykA := 16;  16 :nykA := 25;    25 :nykA := 35;   35 :nykA := 50;
      50 :nykA := 70;  70 :nykA := 95;    95 :nykA :=120;  120 :nykA :=150;
     150 :nykA :=185; 185 :nykA :=240;   240 :mykA :=300;  300 :nykA := 600;
     600 :nykA :=900; 900 :nykA :=1200; 1200 :mykA :=2400;2400 :mykA :=3200;
     OTHERWISE nykA := 6;  END;   END; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*)
BEGIN  FOR i := 0 TO mm2NoMax  DO                  //< 0 varattiin min.ve:lle
       FOR j := 0 TO rinmax    DO BEGIN            //< 6.1.1:  1 to => 0 to                  
          tultau[1,i,j] := 0;
          tultau[2,i,j] := 0;
          tultau[3,i,j] := 0;  END;
//beep; beep; beep; beep; beep; beep;//KOE §
END;//tyhtultau
//===========================================================================
FUNCTION IksOK (VAR IknMin,Ikn :real;  VAR PoiskSul :integer) :Boolean;
                                      //Tarkistaa sulakesuojauksen KULuttajan
   VAR sulAli,boo :Boolean;           //+SL:n jakeluverkossa. Määräävänä kaap
       tim :Real;                     //tyyppinä on xMMK, koska IkMMK<IkMCMK.
                                      //Asettaa VAIN TÄSSÄ arvot Ikm :lle <<<
                             //EKAX KUTSUTTAVA IksOK ENNEN Ikm,Iskmin käyttöä
//.............................................................
   PROCEDURE pienennaIsul (VAR isu :Integer);   BEGIN
      pienIsul (isu);
      IF isu < KuorSul         //<KuorSu =Kuorman edellyttmä =pyor(Imin)/fKsu
         THEN BEGIN  sulAli := TRUE;  IksOK := FALSE;  END;
   END;//pienennaIsul
//.......................................
BEGIN//IksOK                               //IksOK ohjaa h2 :n kasvua, sulAli
   PoiskSul := 1250;  //<PoiskSul KORJAUTUU  //tätä PRC:a <<<<<<<<<<<<<<<<<<<
   boo := TRUE;                              //< 6.1.1 -IksOK +boo
   sulAli := FALSE;
       //'PoiskSul korjataan näissä PRC :ssa jos tarvis, PoiskSul = KuorSu AI-
       //NA OK, koska KUORMA EDELLYTTÄÄ SEN ja UNTIL uh<...IksOK etsiKaap :ssa
       //kasvattaa IksOK:n ohjaamana NJmm2:ta kunnes IksOK <<<<<<<<<<<<<<<<<<<
             //EiMaxI,.....MaxZ,os......,NJkin<<<<<<<<<<<<<<<<<<<<<<<<<<<=Ik1v
   Ikn := iks (Ik3vFA, edmaxkpl, Ziks (12,edmaxkpl,NJkinTR,0, '',0,0,0,0, ar,ar,ar,ar));

   IF NOT a_getBool (37013, nj.jy.NjKulSal)
      THEN tim := 15.0                                //<IkIsu SÄL=n*Isu, mutta Isnik -kutsua varten
      ELSE tim := a_getReaa (37014, edv.YLE.PoisAika);

   IF PoiskSul>0                 //<Ei voi olla enää 0. Ei väliä. OK. := 1250
   THEN BEGIN                    //,,ASETTI Iskmin, OLTAVA EKAX<<<<<<<<<<<<<<
      IknMin := Isnik (suCse,PoiskSul,tim);
                                 //,,Pienennet maxsulaketta (PoiskSul) kunnes
                                 //NIIN PIENI, että SILLE VAADITTU oikosulku-
                                 //virta Isnik <= verkon Ik1v (=Ikn)<<<<<<<<<
      WHILE (Ikn < IknMin{Iskmin})  AND  NOT sulAli  DO BEGIN //<6.1.1 Iskmin (kutsuparam.) => IknMin
         pienennaIsul (PoiskSul);
         IknMin := Isnik (suCse,PoiskSul,tim);  END;
   END
   ELSE BEGIN                 //<Jos PoiskSul=0, on kyseessä >1250A sulake ja N1-
      boo := FALSE;           //ehto määräytyy 0.8xIkm mukaan. Ikn siis vält-
      IknMin := 0;  END;      //tämätön. Sen takia em. WHILE silmukan ohitus,
   Result := boo;             //jotta IksOK-kutsu mahista, kun PoiskSul=0 <<<
END;//IksOK
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NjLas37.INC }

