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

{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NOLA01.INC }
  {fSama ('KiskAbb-AlN')  or fSama ('KiskAbb-AlS')  or
   fSama ('KiskAbb-CuN')  or fSama ('KiskAbb-CuS')  or
   fSama ('KiskAbb-CuNx') or fSama ('KiskAbb-CuSx')}
{function fSamOK (str1,str2 :string) :boolean;      begin //<,,Näillä voitetaan vain 831 ms => 621 ms 3:lla j-osalla.
   result := str1=str2;  end;
function SamIso (CONST str1,str2 :string) :boolean;      begin
   result := fSamOK (str1,str2);   end;}
{=================================================================================================================
11.0.1:  - Kommentissa:   "1101: oli *800"  =CASEssa esim.  "ELSE IF a>800  THEN sijVaro (0.0778*800/mm2)
                                                                            => sijVaro (0.0778*400/mm2)
         - Nämä esiintyvät Res yms. fnc:ssa, missä PE/PEN-johtimen poikkipinta pikkeaa vaiheMm2:sta.
         - fSam kutsui SamIso (si,tyyppi), joka on nyt korvattu FNC OnYksiSama (CONST si,vakS :string) :n kutsulla,
           missä SI vois sis. perääkäisiä kaapTyyppejä kukin ";" :lla erotettuna.
                       result := SamIso (si,tyyppi);   end;
                   =>  result := OnYksiSama (si,tyyppi);  end;

=================================================================================================================}
function OnYksiSama (CONST si,vakS :string) :boolean;      VAR str,sa :string;      begin //+11.0.1
   str := si;
   result := false;                                   // STR ='AMCMK3½½;xxx  ; zzzz' = ";":lla erotetut kaapTyypit
   str := Trim (str);                                 // " ":t (tyhjät välit) ohitetaan.
   sa := '';                                          //'vakS=Etsittävä mjono.
   while str<>''  do begin                            //'#########################################################
      if NOT (CharInSet(str[1], [';',' ']))
         then sa := sa +str[1];                               //,Length()<=1 =vikaMrk luettu jo, delautuuKohta.
      if (str[1]=';') or (Length(str)<=1)                     //< ";" on eri mjonojen erotusMrk.
      then begin
         Delete (str,1,1);
         if SamIso (vakS,sa)
         then begin
            result := true;   Break;  end
         else sa := '';
      end//if str[1]
      else Delete (str,1,1);
      str := Trim (str);
   end;//while
   if sa='§!"#¤%>'  then ;
end;

function fOnSV (CONST tyyppi :string) :boolean; //<TR jos tyyppi :ssä mikään SVsyst.. mukana (POS >=1). +6.0.2 ,,,6.0.3
   function fSama (CONST si :string) :boolean;      begin
      result := SamIso (si,tyyppi);   end;
begin
   if fSama ('SVsystAL3½') or fSama ('SVsystCu3½') or fSama ('SVsystAL4N') or
      fSama ('SVsystCu4N') or fSama ('SVsystAL5S') or fSama ('SVsystCu5S')
   then result := true
   else result := false;
end;

function fOnSVal (CONST tyyppi :string) :boolean;      begin//<TR jos STR :ssä 'SVsyst' ja 'AL' mukana (POS >=1). +6.0.2
   if fOnSV (tyyppi) and Mukana ('Al',tyyppi)               //<AnsiUpperCase
      then result := true
      else result := false;
end;

function fOnSVcu (CONST tyyppi :string) :boolean;      begin//<TR jos STR :ssä 'SVsyst' ja 'Cu' mukana (POS >=1). +6.0.2
   if fOnSV (tyyppi) and Mukana ('Cu',tyyppi)               //<AnsiUpperCase
      then result := true
      else result := false;
end;
//--------------------------------------------------------------------------------------------------
function fOnKIS (CONST tyyppi :string) :boolean; //<TR jos tyyppi :ssä mikään Kisk... mukana (POS >=1).     +6.0.2
   function fSama (CONST si :string) :boolean;      begin
      result := SamIso (si,tyyppi);   end;
begin
   if fSama ('KiskAbb-AlN')  or fSama ('KiskAbb-AlS')  or
      fSama ('KiskAbb-CuN')  or fSama ('KiskAbb-CuS')  or
      fSama ('KiskAbb-CuNx') or fSama ('KiskAbb-CuSx')
   then result := true
   else result := false;
end;

function fOnKISal (CONST tyyppi :string) :boolean;      begin//<TR jos STR :ssä 'Kisk..' ja 'AL' mukana (POS >=1).+6.0.2
   if fOnKIS (tyyppi) and Mukana ('Al',tyyppi)               //<AnsiUpperCase
      then result := true
      else result := false;
end;

function fOnKIScu (CONST tyyppi :string) :boolean;      begin//<TR jos STR :ssä 'Kisk..' ja 'Cu' mukana (POS >=1).+6.0.2
   if fOnKIS (tyyppi) and Mukana ('Cu',tyyppi)               //<AnsiUpperCase
      then result := true
      else result := false;
end;
//--------------------------------------------------------------------------------------------------

FUNCTION fSV6 (CONST tyyppi :string;  r1,r2,r3,r4,r5,r6 :Real) :Real;      VAR  ar :real;      BEGIN
   if SamIso (tyyppi, 'SVsystAL3½')  then ar := r1  else             //Valitsee/Palauttaa TYYPIN mukaisen REAL´in
   if SamIso (tyyppi, 'SVsystCu3½')  then ar := r2  else
   if SamIso (tyyppi, 'SVsystAL4N')  then ar := r3  else
   if SamIso (tyyppi, 'SVsystCu4N')  then ar := r4  else
   if SamIso (tyyppi, 'SVsystAL5S')  then ar := r5  else
  {if SamIso (tyyppi, 'SVsystCu5S'}       ar := r6;
   result := ar;
end;

FUNCTION fKis6 (CONST tyyppi :string;  r1,r2,r3,r4,r5,r6 :Real) :Real;     VAR  ar :real;      BEGIN
   if SamIso (tyyppi, 'KiskAbb-AlN')   then ar := r1  else            //Valitsee/Palauttaa TYYPIN mukaisen REAL´in
   if SamIso (tyyppi, 'KiskAbb-AlS')   then ar := r2  else
   if SamIso (tyyppi, 'KiskAbb-CuN')   then ar := r3  else
   if SamIso (tyyppi, 'KiskAbb-CuS')   then ar := r4  else
   if SamIso (tyyppi, 'KiskAbb-CuNx')  then ar := r5  else
  {if SamIso (tyyppi, 'KiskAbb-CuSx')}      ar := r6;
   result := ar;
end;
(*----------------------------------------------------------------------------------------------------------------
FUNCTION rTkorj (AlCu :boolean;   Resist :Real;   t :Integer) :Real;      BEGIN                     //<,,-6.0.2
      if AlCu  then result := Resist * (1+ 0.00403*(t-20))    {<Al}
               else result := Resist * (1+ 0.00393*(t-20));   {<Cu}  END;

FUNCTION fR20 (AlCu :boolean;   Ralp :Real;   Talp :Integer) :Real;      VAR ar :real;    BEGIN
   if AlCu  then ar := 1+ 0.00403*(Talp-20)    {<Al}         //',,Laskee R20°C esim. R40°C:sta
            else ar := 1+ 0.00393*(Talp-20);   {<Cu}         //<'Talp = RESIST :n alkup.lämpötila
   result := Ralp / ar;   END; //''Talp-20 oli 2.0.4:ssä, korj. +2.0.5   Ralp*ar -> Ralp/ar =3.0.0
----------------------------------------------------------------------------------------------------------------*)
   FUNCTION rDt20_Kerr (AlCu :boolean;  Talp :Integer) :Real;      VAR Ka,ar :real;      BEGIN //<+6.0.2
         if AlCu  then Ka := AlfaAL  //< Al //Muuntaa Ralp -resist:n 20°:een:  Ru = Ra/rDt20_Kerr(AlCu,Talp).#####
                  else Ka := AlfaCU; //< Cu //Muunnos isommasta 20°:een, esim. 70° -> 20° :een pitää tehdä tällä
         ar := 1+ Ka*(Talp-20);             //FNC:lla, jotta taas 20°->70° tulisi samaksi, ks. ed. Ru=Ra/rDt20_...
         result := ar;                      //<Tuntuisi toimivan jos 20 korvattaisiin suoraan halutulla uudella Tu:lla,
   END;                                     // esim. Talp=160 ja Tu=70, koklattu.        <''Kommenttirivit +10.0.7
  {10.0.7: Esim:  AlfaAL= 0.000403;  AlfaCU=0.00393;                                     <,,+10.0.7
                  Ta=160,  Tu=70  =>      FNC := 1 /(1+ AlfaAL*(160-70)) =0.73384
                  Takaisinpäin laskenta:  R   := 0.73384 * (1+ AlfaAL*(160-70) = 1 }
//,,,%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{FUNCTION rTkorj (AlCu :boolean;  R20 :Real;  Tuus :Integer) :Real;   VAR ar :real;  BEGIN//R:n LTkorj T20°C -> Tu°C:een
   procedure Koe_rTaTu; //<Algor. kokeiluun
      procedure rTu (Resist :Real;  Talp,Tuus :Integer);      VAR r1,r2,r3,r4,r5 :real;      begin
         r1 := Resist * (1+ 1*(Tuus-Talp)); //,###################################################################
         r2 := r1 / (1+ 1*(Talp-Tuus));     //,###################################################################
         r3 := r1 * (1+ 1*(Talp-Tuus));     //,###################################################################
         r4 := r1 * (1+ 1*(Tuus-Talp));     //,###################################################################
         r5 := r1 / (1+ 1*(Tuus-Talp));     //<Tämä palauttaa saman arvon kuin PRC:hen tultaessa RESIST oli,!!!!!!
                                            //'################### oli Talp>Tuus tai Talp<Tuus ###################
         if (Resist=r1) and (r2=r3) and (r4=r5) and (Tuus=Talp)   then ;
      end;
   BEGIN rTu (1,70,20);  rTu (1,20,70);  rTu (2,70,20);  rTu (2,20,70);  rTu (0.1,70,20);  rTu (0.1,20,70);  END;}
      {- Alfa on oikeastaan riippuvainen lämpötilasta:  AlfaTaCu = 1 / (235 + Ta[°C]) -> Tulisi poikkeavia arvoja,
         olisikohan päivitettävä??? Ks. Martti Paavola, S-tekniikan oppikirja, 1968, s.34 ========================
       - Ei onaa kattavasti yhdellä kaavalla, ks. FNC rTaT20:  Jos muunnetaan R70°:sta 20°:een ja taas takaisin,
         ARVO EI TULE SAMAKSI. TÄMÄN TAKIA LT-KORJAUKSET YLÖS- JA ALASPÄIN TÄYTYY LASKEA ERIKSEEN, ks. FNC rTaT20
         / FNC Koe_rTaTu -> FNC rTuT20.
       - AlCu parempi kuin TYYPPI, koska fPal tarvitsee myös tätä.-----------------------------------------------}
FUNCTION rTkorj (AlCu :boolean;  R20 :Real;  Tuus :Integer) :Real;   VAR ar :real;  BEGIN//R:n LTkorj T20°C -> Tu°C:een
  {Koe_rTaTu;}
      ar := R20 * rDt20_Kerr (AlCu,Tuus); //<Muunnos isommasta 20°:een, esim. 70° -> 20° :een pitää tehdä FNC
      result := ar;  END;                 // rTaT20 :lla, jotta taas 20°->70° tulisi samaksi tällä FNC rTkorj:lla.

       //,, Korvaa FNC fR20 :n = Aivan sama, paitsi rDt20_Kerr ulkoistettu.  =Ralp:n LT korjaus Talp°C -> 20°C:een
FUNCTION rTaT20 (AlCu :boolean;   Ralp :Real;   Talp :Integer) :Real;   VAR ar :real;  BEGIN
                    {                 ar := 1 / rDt20_Kerr (AlCu, 70); //< Muuntaa 1 Ohmin 70°:n resist:n 20°:een
                     if ar<0  then ;  ar :=     rTKorj (AlCu, ar, 70); //< Muuntaa resist:n takas 70°:een: p.o. 1.!!
                     if ar<0  then ;}
      ar := Ralp / rDt20_Kerr (AlCu, Talp); //< Muuntaa Ralp -resist:n 20°:een
      result := ar;  END;
//'''%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

{FUNCTION R70_20 (CONST tyyppi :string;  rr :Real) :Real;      VAR  ar :real;  AlCu :boolean;    BEGIN
   AlCu := fAlCu (tyyppi);                                     // Al/Cu 70° Res 20°C:een
   ar := rTaT20 (AlCu,rr, 70);
   result := ar;  end;}

FUNCTION svj70_20 (CONST tyyppi :string;  r1,r2,r3,r4,r5,r6 :Real) :Real;      VAR  ar :real;  AlCu :boolean;   BEGIN
   if fOnSVcu (tyyppi)  then AlCu := FALSE                               //Al/Cu SVjärjest:n 70° Res 20°C:een
                        else AlCu := TRUE;
   ar := fSV6 (tyyppi, r1,r2,r3,r4,r5,r6);
   ar := rTaT20 (AlCu,ar, 70);          //<SVjärjest:n R ilmoitettu 70°C :ssa.!!!!!!!!!!!!!!!!!!!!!!
   result := ar;  end;

FUNCTION kis90_20 (CONST tyyppi :string;  r1,r2,r3,r4,r5,r6 :Real) :Real;      VAR  ar :real;  AlCu :boolean;   BEGIN
   if fOnKIScu (tyyppi)  then AlCu := FALSE                              //Al/Cu KiskABB:n 90° Res 20°C:een
                         else AlCu := TRUE;
   ar := fKis6 (tyyppi, r1,r2,r3,r4,r5,r6);
   ar := rTaT20 (AlCu,ar, 90);          //<KiskAbb:n R ilmoitettu 90°C :ssa.!!!!!!!!!!!!!!!!!!!!!!!!
   result := ar;  end;

//==================================================================================================
//==================================================================================================
procedure teeKtlk;      VAR i,j :integer;

   procedure sij (riv :integer;  CONST si :string);      VAR c :integer;   sa,su :string;   {ar :real;      }begin
      sa := si;   sa := TrimRight (sa);            //<SI säilytetään debuggauksen takia, SA:ta manipuloidaan
      c := 0;
      while (sa<>'') and (c<KtlkSarMax)  do begin
         sa := TrimLeft (sa);
         c := c+1;   su := '';
         while (sa<>'') and (sa[1]<>' ')  do begin
            if sa[1]=','  then sa[1] := '.';       //<Varm.vuoksi mahd. desim.pilkku pisteeksi.
            su := su +sa[1];
            Delete (sa,1,1);  end;
        {if SokR (su,ar)
            then Ktlk [riv,c] := ar;}
        {if SokR (su,ar) or (Pos(FONT_SUURPI,su)>0)
            then }Ktlk [riv,c] := su;
      end;
   end;
   //................................,##############################################################
   //................................,##############################################################
   //...................,###########################,...............................................
begin//teeKtlk.  TÄSSÄ:  SFS -5/... = SFS 6000-5-52/... eli v.2007, mikä korvaa aikaisemmat A2:n taulukkoarvot.
   for i := 1 to KtlkRivMax  do    //'##############################################################
   for j := 1 to KtlkSarMax  do    //'##############################################################
       Ktlk[i,j] := KtlkArvoTyh; //<',Alustetaan KOKO tlk -1 :llä (osoittaa, ettei arvoa ole olemassa)
//========== MAA-asennus ===========================================================================
{Oli 52-D2 s234 -----------------------------------------------------------------------------------
    Ots      sij ( 1, '10    15    20    25    30    35    40    45    50    55    60    65    70    75    80  ');
    PVC      sij ( 2, '1.04  1     0.95  0.90  0.84  0.8   0.73  0.67  0.6   0.52  0.42  0     0     0     0   ');
    PEX/..   sij ( 3, '1.02  1     0.96  0.92  0.89  0.85  0.81  0.76  0.73  0.68  0.62  0.57  0.5   0.44  0.36');}
//SFS 6000 v.2007/A.52-15
    {Ots}    sij ( 1, '0     5     10    15    20    25    30  ');
    {PVC}    sij ( 2, '1.13  1.09  1.05  1     0.95  0.9   0.85');
    {PEX/..} sij ( 3, '1.1   1.06  1.03  1     0.96  0.93  0.89');
             //'######### Näitä rivejä kutsutaan Ktlk :sta:  KsijCelliin (.._Grd, 1,3, ..) #########
             //'##################################################################'''###############
             //'####################################################################################
//SFS 6000 v.2007/A.52-16 = sama kuin 52-D3 s234 ---------------------------------------------------
{Ots K m/W}  sij ( 4, '0.7   1     1.2   1.5   2     2.5   3   ');
{Korj}       sij ( 5, '1.1   1     0.92  0.85  0.75  0.69  0.63');
{Oli 52-E2 s236 ------------------------------------------------------------------------------------
             sij ( 6, '2     0.75  0.8   0.85  0.9   0.9 ');
             sij ( 7, '3     0.65  0.7   0.75  0.8   0.85');
             sij ( 8, '4     0.6   0.6   0.7   0.75  0.8 ');
             sij ( 9, '5     0.55  0.55  0.65  0.7   0.8 ');
             sij (10, '6     0.5   0.55  0.6   0.7   0.8 ');}
//SFS 6000 v.2007/A.52-18
             sij ( 6, '0     0.79  0.69  0.63  0.58  0.55  0.5   0.46 '); //<Ots +10.0.1  ks. korj.PAS
             sij ( 7, '70    0.85  0.75  0.68  0.64  0.6   0.56  0.53 ');
             sij ( 8, '250   0.87  0.79  0.75  0.72  0.69  0.66  0.64 ');
           //Tästä ' eteenpäin riviN:ot korjattu, seur = 9 10 11 jne. =10.0.1
{Oli 52-E3 A s237 ----------------------------------------------------------------------------------
             sij (11, '2     0.85  0.9   0.95  0.95');
             sij (12, '3     0.75  0.85  0.9   0.95');
             sij (13, '4     0.7   0.8   0.85  0.9 ');
             sij (14, '5     0.65  0.8   0.85  0.9 ');
             sij (15, '6     0.6   0.8   0.8   0.9 ');}
//SFS 6000 v.2007/A.52-19
             sij ( 9, '0     0.8   0.75  0.65  0.6   0.6   0.55  0.55  0.5  '); //<Ots +10.0.1  ks. korj.PAS
             sij (10, '70    1     0.75  0.7   0.65  0.6   0.6   0.55  0.55 ');
             sij (11, '250   1     0.75  0.7   0.7   0.65  0.65  0.65  0.65 ');
{//52-E3 B s237 ------------------------------------------------------------------------------------ -10.0.1
 Yksijohtimista versiota ei ole SFS -5 :ssä enää, tämä nyt siis kokonaan poistettu
 =TabCtrl.TabIndex=0 / C_Rad.ItemIndex MAX =0 tai 1.
             sij (16, '2     0.8   0.9   0.9   0.95');
             sij (17, '3     0.7   0.8   0.85  0.9 ');
             sij (18, '4     0.65  0.75  0.8   0.9 ');
             sij (19, '5     0.6   0.7   0.8   0.9 ');
             sij (20, '6     0.6   0.7   0.8   0.9 ');}


//========== /a,/uo,/s = VAPAASTI ILMAAN AS.========================================================
//SFS 6000 v.2007/A.52-14, oli 52-D1 s234 ------------------------------------------------------------------------
{Ots}        sij (12{21}, '10    15    20    25    30    35    40    45    50    55    60    65    70    75    80  ');
{PVC}        sij (13{22}, '1.15  1.1   1.05  1     0.94  0.88  0.82  0.75  0.67  0.58  0.47  0     0     0     0   ');
             //Oli 52-D1  '                                          0.74  0.66  0.57  MUUT SAMOJA''',,,
{PEX/..}     sij (14{23}, '1.1   1.07  1.04  1     0.96  0.92  0.88  0.84  0.79  0.73  0.68  0.62  0.56  0.48  0.39');
             //Oli 52-D1  '            1.03                    0.87  0.83  0.78                    0.55
//Oli 52-E1 s235 -------------------------------------------------------------------------------------------------
            {Ktlk[15,8] :=                          FONT_SUURPI+'8';        //<,Korvataan kokonaan. Ei voida jättää
             Ktlk[15,9] :=                                FONT_SUURPI+'12'; //  SIJ´n parsittavaksi: FONT_:ssa ' '
             //''Ei SIJ´parsittavaksi:  Jos jää TAGin alku, mutta ei loppua samasta sellistä => Index Range error
             //  kun NolaComp yrittää ratkaista TAGIn loppua, esim.: FONT_SUURPI='<f n="Symbol">'+Chr(179)+'</f>'
             //  ############################################,,TODETTU,,##########################################
             sij (24, '1     2     3     4     5     6     7     8     12    16    18    20  ');
             sij (25, '1     0.8   0.7   0.65  0.6   0.55  0.55  0.5   0.45  0.4   0.4   0.4 ');
             sij (26, '1     0.85  0.8   0.75  0.75  0.7   0.7   0.7   0.7   0.65  0.65  0.65');
             sij (27, '1     0.95  0.9   0.9   0.9   0.9   0.9   0.9   0.9   0.9   0.9   0.9 ');
             sij (28, '0.95  0.8   0.7   0.7   0.65  0.65  0.65  0.6   0.6   0.55  0.55  0.55');
             sij (29, '0.95  0.85  0.85  0.85  0.85  0.85  0.85  0.85  0.85  0.85  0.85  0.85');}//,,SisSarakeLisäykset+Vähenn.
//SFS 6000 v.2007/A.52-17                          //10.0.1:  Lisätty ,9, Välistä vex 18
             sij (15, '1     2     3     4     5     6     7     8     9     12    16    20  '); // 24
             sij (16, '1     0.8   0.7   0.65  0.6   0.57  0.54  0.52  0.5   0.45  0.41  0.38'); // 25
             sij (17, '1     0.85  0.79  0.75  0.73  0.72  0.72  0.71  0.7 ');                   // 26
             sij (18, '0.95  0.81  0.72  0.68  0.66  0.64  0.63  0.62  0.61 ');                  // 27
             sij (19, '1     0.88  0.82  0.77  0.75  0.73  0.73  0.72  0.72 ');                  // 28
             sij (20, '1     0.87  0.82  0.8   0.8   0.79  0.79  0.78  0.78 ');                  // 29
//SFS 6000 v.2007/A.52-20 ------------------------------------------------ ,,Oli 52-E4 s238 ---------------------------
{Ots}        sij (21,     '1   2     3     4     6     9');    // (21,     '1     2     3     4     6     9');    // 30
             sij (22, '1   1   0.88  0.82  0.79  0.76  0.73'); // (22, '1   0.95  0.85  0.8   0.75  0.7   0.7 '); // 31
             sij (23, '2   1   0.87  0.8   0.77  0.73  0.68'); // (23, '2   0.95  0.85  0.75  0.75  0.7   0.65'); // 32
             sij (24, '3   1   0.86  0.79  0.76  0.71  0.66'); // (24, '3   0.95  0.85  0.75  0.7   0.65  0.6 '); // 33
             sij (25, '1   1   1     0.98  0.95  0.91      '); // (25, '1   1     0.95  0.95  0.95  0.9   0   '); // 34
             sij (26, '2   1   0.99  0.96  0.92  0.87      '); // (26, '2   0.95  0.95  0.9   0.9   0.85  0   '); // 35
             sij (27, '3   1   0.98  0.95  0.91  0.85      '); // (27, '3   0.95  0.95  0.9   0.9   0.85  0   '); // 36
             sij (28, '1   1   0.88  0.82  0.78  0.73  0.72'); // (28, '1   1     0.9   0.8   0.8   0.75  0.75'); // 37
             sij (29, '2   1   0.88  0.81  0.76  0.71  0.7 '); // (29, '2   1     0.85  0.8   0.75  0.75  0.7 '); // 38
                                                               // (30, '3   1     0.85  0.8   0.75  0.7   0.65'); // 39
             sij (30, '1   1   0.91  0.89  0.88  0.87      '); // (31, '1   1     1     1     0.95  0.9   0   '); // 40
             sij (31, '2   1   0.91  0.89  0.87  0.85      '); // (32, '2   1     1     0.95  0.9   0.85  0   '); // 41
                                                               // (33, '3   1     1     0.95  0.9   0.85  0   '); // 42
             sij (32, '1   1   0.87  0.82  0.8   0.79  0.78'); // (34, '1   1     0.9   0.8   0.75  0.75  0.7 '); // 43
             sij (33, '2   1   0.86  0.8   0.78  0.76  0.73'); // (35, '2   1     0.9   0.8   0.75  0.7   0.7 '); // 44
             sij (34, '3   1   0.85  0.79  0.76  0.73  0.7 '); // (36, '1   1     0.9   0.9   0.9   0.85  0   '); // 45
             sij (35, '1   1   1     1     1     1         '); // (37, '2   1     0.9   0.9   0.85  0.85  0   '); // 46
             sij (36, '2   1   0.99  0.98  0.97  0.96      '); // (38, '1   1     0.85  0.8   0.8   0.8   0.8 '); // 47
             sij (37, '3   1   0.98  0.97  0.96  0.93      '); // (39, '2   1     0.85  0.8   0.8   0.75  0.75'); // 48
             //'=17 riviä                                      // (40, '3   1     0.85  0.8   0.75  0.75  0.7 '); // 49
                                                               // (41, '1   1     1     1     1     1     0   '); // 50
                                                               // (42, '2   1     1     1     0.95  0.95  0   '); // 51
                                                               // (43, '3   1     1     0.95  0.95  0.95  0   '); // 52  '=23 riviä
//SFS 6000 v.2007/A.52-21 -------------------------------- ,,Oli 52-E5 s239 -----------------------/
{Ots}        sij (38,     '1     2     3');    // (44,       '1     2     3');    // 53
             sij (39, '1   0.98  0.91  0.87'); // (45, '1     0.95  0.9   0.85'); // 54
             sij (40, '2   0.96  0.87  0.81'); // (46, '2     0.92  0.85  0.8 '); // 55
             sij (41, '3   0.95  0.85  0.78'); // (47, '3     0.9   0.8   0.75'); // 56
             sij (42, '1   0.96  0.86      '); // (48, '1     0.95  0.9   0.85'); // 57
             sij (43, '2   0.95  0.84      '); // (49, '2     0.95  0.85  0.8 '); // 58
                                               // (50, '3     0.9   0.85  0.8 '); // 59
             sij (44, '1   1     0.97  0.96'); // (51, '1     0.95  0.85  0   '); // 60
             sij (45, '2   0.98  0.93  0.89'); // (52, '2     0.9   0.85  0   '); // 61
             sij (46, '3   0.97  0.9   0.86'); // (53, '1     1     0.95  0.95'); // 62
             sij (47, '1   1     0.98  0.96'); // (54, '2     0.95  0.9   0.9 '); // 63
             sij (48, '2   0.97  0.93  0.89'); // (55, '3     0.95  0.9   0.85'); // 64
             sij (49, '3   0.96  0.92  0.86'); // (56, '1     1     0.95  0.95'); // 65
             sij (50, '1   1     0.91  0.89'); // (57, '2     0.95  0.9   0.85'); // 66
             sij (51, '2   1     0.9   0.86'); // (58, '3     0.95  0.9   0.85'); // 67
             sij (52, '1   1     1     1   '); // (59, '1     1     1     0.95'); // 68
             sij (53, '2   0.97  0.95  0.93'); // (60, '2     0.95  0.95  0.9 '); // 69
             sij (54, '3   0.96  0.94  0.9 '); // (61, '3     0.95  0.9   0.85'); // 70
             //'=17 riviä                      // (62, '1     1     0.9   0.9 '); // 71
                                               // (63, '2     1     0.9   0.85'); // 72
                                               // (64, '1     1     1     1   '); // 73
                                               // (65, '2     0.95  0.95  0.95'); // 74
                                               // (66, '3     0.95  0.95  0.9 '); // 75  '=23 riviä
end;//teeKtlk
//==================================================================================================

function fAlCu (CONST tyyppi :string) :boolean; //<Palauttaa VAIHEjohdinmater:  Al=TR  Cu=FA

   function fSam (CONST si :string) :boolean;      begin                                            //<+6.0.2
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1
begin
   Result := true;
  {if fSam ('MCMK')     or fSam ('MCMK3½') or fSam ('MCMK3½½')  or fSam ('MCMK4½') or               //<,-11.0.1
      fSam ('MMJ/MMK*') or fSam ('PLKVJ*') or fSam ('AVOJOHcu') or
      fOnSVcu (tyyppi)  or fOnKIScu (tyyppi)                                                        //<,,+6.0.2}
   if fSam ('MCMK;MCMK3½;MCMK3½½;MCMK4½;MMJ/MMK*;MMJ;PLKVJ*;AVOJOHcu') or                           //<11.0.1, MMJ+130.2e
      fOnSVcu (tyyppi)  or fOnKIScu (tyyppi)                                                        //<,,+6.0.2
      then Result := false;  end;
//--------------------------------------------------------------------------------------------------
FUNCTION fPal (CONST tyyppi :string) :Boolean; //<Palauttaa PE-johdinmateriaalin:  Al=TR  Cu=FA
   function fSam (CONST si :string) :boolean;      begin                                            //<+6.0.2
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1
BEGIN
   Result := true;                                  //,,PLKVJ* :lle huomattava -> Cu=FALSE. ,3½o ja HD =+11.0.1
   IF fSam ('AMCMK ;AMCMK3½ ;AMCMK3½o ;AMCMK3½HD ;AMCMK3½½ ;AMCMK4½ ;MCMK ;MCMK3½ ;MCMK3½½ ;MCMK4½ ;' +
            'AXCMK ;MMJ/MMK* ;MMJ ;PLKVJ* ;AVOJOHcu')  or                                //<,,+6.0.2 vaikka S lie-
      fOnSVcu (tyyppi)  or fOnKIScu (tyyppi)                                             //'nee aina SVj:ssä Cu.!   MMJ+130.2e
      THEN Result := FALSE;   END; //''MMJ+PLKVJ+AVOJcu lisätty 1.1.7, APAKM* poistettu 2.0.3.
//--------------------------------------------------------------------------------------------------

FUNCTION fNal (CONST tyyppi :string) :Boolean;      VAR AlCu :boolean;//<Palauttaa N-johdinmater.:  Al=TR  Cu=FA
   function fSam (CONST si :string) :boolean;      begin                                            //+6.2.15
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1
BEGIN
   AlCu := false;        //< FA=Cu   ,AMCMK=4½ =al   ,AMCMK4½ =al   ,APAKM* +11.0.1
   IF fSam ('AMCMK ;AMCMK3½½ ;AMCMK4½ ;AVOJOHal ;APAKM*')  or fOnSVal (tyyppi)  or fOnKISal (tyyppi)
 {Cu: fSam ('AMCMK3½')   or fSam ('MCMK')     or fSam ('MCMK3½')    or fSam ('MCMK3½½')   or fSam ('MCMK4½')  or
      fSam ('AXCMK' =cu) or fSam ('MMJ/MMK*') or fSam ('PLKVJ*')       //=uusi ryhmittely 11.0.1}
      THEN AlCu := TRUE;
   Result := AlCu;
END;//fNal
//==================================================================================================

(*function SVsuhtL (mm2 :real) :real;      var ar :real;      begin                                  -6.0.2
   CASE trunc (mm2) OF  300 :ar := 1.000;             //<,Suht pituus
                        600 :ar := 1.000;
                        900 :ar := 0.8767;
                       1200 :ar := 0.8468;
                       2400 :ar := 0.8278;
                  else{3200} ar := 0.7832;  END;
   result := ar;
end;*)
function SVsuhtL (CONST tyyppi :string;  mm2 :real) :real; //SVsyst suht.maxZ-pisteen etäis. Korj 6.0.2

   PROCEDURE svj (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;      BEGIN
      ar := fSV6 (tyyppi, r1,r2,r3,r4,r5,r6);
      result := ar;  END;
      
begin//.................
   CASE Pyor(mm2) OF                    //,,,NOKIA/SVjärjest. sis.muistio/Risto Kivisaari/Fax 3.12.91
        //         1        2        3        4        5        6
        //syst=   AL3½,    Cu3½,    AL4N,    Cu4N,    AL5S,    Cu5S
     2400 :svj (0.8328,  0     ,  0.6247,  0     ,  0.8278,  0     );
     1200 :svj (0.8713,  0.9010,  0.7126,  0.7272,  0.8468,  0.8524);
      900 :svj (0.8702,  0.8476,  0.7108,  0.6745,  0.8767,  0.8466);
      600 :svj (1     ,  1     ,  1     ,  1     ,  1     ,  1     );  ELSE  IF mm2>2400 //< a -> mm2 6.1.x  3.12.02
     THEN  svj (0.9193,  0     ,  0.6118,  0     ,  0.7832,  0     )   //< =3200
     ELSE  svj (1     ,  1     ,  1     ,  1     ,  1     ,  1     );  //< =300
   END;//case
end;
//--------------------------------------------------------------------------------------------------
function fM2 (mm2 :real) :integer;      begin
   if mm2<3
      then fM2 := trunc (mm2)
      else fM2 := trunc (mm2+0.5);  end;
//==================================================================================================

FUNCTION mm2_Pj (CONST tyyppi :string;  mm2 :real) :Real;  //<mm2=vaihej:n ala,  FNC palauttaa N/PE :n alan
     VAR a :integer;

   function fSam (CONST si :string) :boolean;      begin                                            //<+6.0.2
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1

   PROCEDURE sij (aa2 :Real);   BEGIN  result := aa2;  END;

BEGIN//............................
   {Kaikki tyypit:
    AMCMK3½ AMCMK3½o AMCMK3½HD AMCMK3½½ AMCMK4½ AXMK AXCMK AMMK*                     //<AMCMK3½o ja ..HD +11.0.1
    KiskAbb-AlN KiskAbb-AlS KiskAbb-CuN KiskAbb-CuS KiskAbb-CuNx KiskAbb-CuSx
    SVsystAL3½ SVsystCu3½ SVsystAL4N SVsystCu4N SVsystAL5S SVsystCu5S
    APAKM* AMKA AVOJOHal    MCMK3½ MCMK3½½ MCMK4½ MMJ/MMK* PLKVJ* AVOJOHcu}
a := fM2 (mm2);
IF a<3
THEN result := mm2                                                                   //< a => mm2  +6.2.16
ELSE if fOnKIS (tyyppi)  then //< Kiskot / Abb:  vaihe=800 1600 3200                                //<,,+6.0.2
        if a<=800  then sij (a)                                                                     //<  +6.2.15
                   else sij (Pyor (a/2))
ELSE if fOnSV (tyyppi)   then                                                                       //<,,+6.0.2
        if Mukana ('4',tyyppi) //<,Vain 4N :ssä kaikki N- ja PE-mm2:t samoja                        //<, +6.2.15
        then sij (a)
        else
         CASE a OF            //< SUURVIRTAJÄRJESTELMÄ SVsyst/ NOKIA <<<<<<<<<<<<                {S}
           3200 :sij (1600);   900 :sij (600);
           2400 :sij (1200);   600 :sij (300);
           1200 :sij (600);    300 :sij (300);
         ELSE IF a>3200
            THEN sij (3200)                                                                         //<  +6.2.15
            ELSE sij (150);
         END//case
else
if fSam ('AVOJOHal ;AVOJOHcu ;AXMK')  then                                                   //< V,X
         result := a   else                //< AVOJOHDoilla ja AXMK lla Nj = vaihejohdin
if fSam ('AMKA')  then                                                                       //< A
         CASE a OF                         //< AMKA lla 0j=Al ja porr. poikkeaa
            185 :sij (120); {<Valmiina, arvattu}   50 :sij ( 70);
            150 :sij (120); {<Valmiina, arvattu}   35 :sij ( 50);
            120 :sij ( 95); {<Max. nykyään}        25 :sij ( 35);
             70 :sij ( 95);                        16 :sij ( 25);  ELSE IF a>185
            THEN sij (120)
            ELSE sij ( 25);   END  else
if fSam ('AMCMK ;AMCMK3½ ;AMCMK3½o ;AMCMK3½½ ;AMCMK4½ ;AXCMK')  then       //< Cal,Z   <AMCMK3½o, =+11.0.1
         CASE a OF                             //< 0j=Cu=rTkorjEiTarkka
            300 :sij (88);    150,120:sij (41);    50    :sij (16{15 -11.0.1}); //,.............+11.0.1 ....,
            240 :sij (72);     95    :sij (29);    35,25 :if fSam ('AMCMK3½o')  then sij (10)  else sij (16);
            185 :sij (57);     70    :sij (21);    16    :sij (10);     //'Vaikka AMCMK3½o :lla vain 25 ja 35 mm².
            ELSE IF a>300
            THEN sij (120)
            ELSE sij (mm2);  END  else        //<Varaus.  a => mm2  +6.2.16
if fSam ('AMCMK3½HD')  then                                                                   //<,,+11.0.1
         CASE a OF
            95 :sij (57);    50 :sij (29);
            ELSE IF a>100{150}
            THEN sij (88)
            ELSE sij (16);  END  else
if (fSam ('MMJ/MMK*') or fSam('MMJ')) and (a<=25)  then                                       //< MMJ+130.2e
                     sij (mm2)    else        //< a => mm2  +6.2.16
CASE a OF                                     //< KAIKKI MUUT= APAKM*, PLKVJ*, MMJ/MMK*, MMJ, MCMK_, AMMK
            800 :sij (400);{Arvattu}    240 :sij (120);       70 :sij ( 35);
            630 :sij (300);{Arvattu}    185 :sij ( 95);       50 :sij ( 25);
            500 :sij (240);{Arvattu}    150 :sij ( 70);       35 :sij ( 16);
            400 :sij (185);{Arvattu}    120 :sij ( 70);       25 :sij ( 16);
            300 :sij (150);{Arvattu}     95 :sij ( 50);  ELSE IF a>300
            THEN sij (200)
            ELSE sij (mm2);  END; //< a => mm2  +6.2.16
END;//FNC mm2_Pj
//==================================================================================================

FUNCTION mm2_Nj (CONST tyyppi :string;  mm2 :real) :Real;  //<mm2=vaihej:n ala,  FNC palauttaa N-johtimen alan
     VAR a :integer;                                       //+6.2.15

   function fSam (CONST si :string) :boolean;      begin
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1

   PROCEDURE sij (aa2 :Real);   BEGIN  result := aa2;  END;

BEGIN//............................
   {Kaikki tyypit:
    AMCMK3½ AMCMK3½o AMCMK3½HD AMCMK3½½ AMCMK4½ AXMK AXCMK AMMK*                          3½o, HD =+11.0.1
    KiskAbb-AlN KiskAbb-AlS KiskAbb-CuN KiskAbb-CuS KiskAbb-CuNx KiskAbb-CuSx
    SVsystAL3½ SVsystCu3½ SVsystAL4N SVsystCu4N SVsystAL5S SVsystCu5S
    APAKM* AMKA AVOJOHal    MCMK3½ MCMK3½½ MCMK4½ MMJ/MMK* PLKVJ* AVOJOHcu}
a := fM2 (mm2);
if fSam ('AMCMK3½½')  then                                                                          //<  +6.2.15
         CASE a OF
            300 :sij (150);   150,120:sij (70);    50       :sij (25);
            240 :sij (120);    95    :sij (50);    35,25,16 :sij (16);
            185 :sij (95);     70    :sij (35);  ELSE IF a>300
            THEN sij (150)
            ELSE sij (mm2);  END  else  //<Varaus.  a => mm2  +6.2.16
result := mm2_Pj (tyyppi,mm2);          //<Muut alkuperäisen Nmm2-fnc:n muk.
END;//FNC mm2_Nj
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//==================================================================================================

FUNCTION res (CONST tyyppi :string;  mm2 :real) :Real;   VAR a :integer; //<Vaihejohtimen ACresist. [ohm/1m], a=mm2

   function fSam (CONST si :string) :boolean;      begin                                            //<+6.0.2
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1

   PROCEDURE sij (r :Real);        BEGIN  res := r/1000;  END;   //<,, [ohm/1m] @@@@@@@@@@@@@@@@@@@@

   PROCEDURE AL90 (r :Real);       var  ar :real;    BEGIN    //<Muuntaa 90°:n 20°C:een
      ar := rTaT20 (TRUE,r, 90);   //<R ilmoitettu 90°C :ssa.
      sij (ar);   END;
   PROCEDURE AL80 (r :Real);       var  ar :real;    BEGIN    //<Muuntaa 80°:n 20°C:een
      ar := rTaT20 (TRUE,r, 80);   //<R ilmoitettu 80°C :ssa.
      sij (ar);   END;
   PROCEDURE AL70 (r :Real);       var  ar :real;    BEGIN    //<Muuntaa 70°:n 20°C:een
      ar := rTaT20 (TRUE,r, 70);   //<R ilmoitettu 70°C :ssa.
      sij (ar);   END;
   PROCEDURE AL40 (r :Real);       var  ar :real;    BEGIN    //<Muuntaa 40°:n 20°C:een
      ar := rTaT20 (TRUE,r, 40);   //<R ilmoitettu 40°C :ssa.
      sij (ar);   END;
   PROCEDURE Cu70 (r :Real);       var  ar :real;    BEGIN    //<Muuntaa 70°:n 20°C:een
      ar := rTaT20 (FALSE,r, 70);  //<R ilmoitettu 70°C :ssa.
      sij (ar);   END;
   PROCEDURE Cu40 (r :Real);       var  ar :real;    BEGIN    //<Muuntaa 40°:n 20°C:een
      ar := rTaT20 (FALSE,r, 40);  //<R ilmoitettu 40°C :ssa.
      sij (ar);   END;
   PROCEDURE sv_70 (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;      BEGIN //70° Al/Cu Res 20°C:een
      ar := svj70_20 (tyyppi, r1,r2,r3,r4,r5,r6);
      sij (ar);   END;
   PROCEDURE kis_90 (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;     BEGIN //90° Al/Cu Res 20°C:een
      ar := kis90_20 (tyyppi, r1,r2,r3,r4,r5,r6);
      sij (ar);   END;

BEGIN//res.......................................
a := fM2 (mm2);                                 //##### Tyypit kirjoitettava EHDOTTOMAN OIKEIN #####
IF fSam ('AMKA')  THEN                          //##################################################
      CASE a OF    //,,Rac 70°C  Tarkist/Muutettu 6.0.2 ############################################
         16 :AL70 (2.3);     35 :AL70 (1.0 );     70 :AL70 (0.53);
         25 :AL70 (1.4);     50 :AL70 (0.77);    120 :AL70 (0.30);
      ELSE if a<16  then AL70 (2.3 * 16/mm2)
                    else AL70 (0.3 *120/mm2);  END  else

if fOnKIS (tyyppi)  then //< Kiskot / Abb                                                           //<,,+6.0.2
      CASE a OF          //,,,ABB:n s-postista:  E:\Projektit\NolaKehi\SRC\ABB\Kiskot\ .PDF :nä
            //           1       2       3       4       5       6
            //          AlN ,   AlS ,   CuN ,   CuS ,   CuNx,   CuSx =[Ohm/km]. LT 90°, AlCu tutkitaan FNC kis_90 :ssa.
        1600 :kis_90 (0.0308, 0.0308, 0.0201, 0.0201, 0     , 0      );  ELSE IF a>1600
        THEN  kis_90 (0.0147, 0.0147, 0.0131, 0.0131, 0.0094, 0.00094)   //< = 3200
        ELSE  kis_90 (0.0519, 0.0519, 0     , 0     , 0     , 0      );  //< = 800
      END else
if fOnSV (tyyppi)  then //,NOKIA,,,,,,,,,,, +6.0.2 = SIJ korvattu sv_70 :lla, 1600 ja 150 poistettu. ,,6.0.2
      CASE a OF         //,,,1kV:n kaap.järjest.luettelosta (=R), NormJärjest =ei N tai S
            //         1      2      3      4      5      6
            //syst=   AL3½,  Cu3½,  AL4N,  Cu4N,  AL5S,  Cu5S   =[Ohm/km]. LT 70°, AlCu tutkitaan FNC sv_70 :ssa.
        2400 :sv_70 (0.016,     0, 0.016,     0, 0.016,     0);
        1200 :sv_70 (0.030, 0.019, 0.030, 0.019, 0.030, 0.019);
         900 :sv_70 (0.040, 0.025, 0.040, 0.025, 0.040, 0.025);
         600 :sv_70 (0.061, 0.037, 0.061, 0.037, 0.061, 0.037);  ELSE IF a>2400
        THEN  sv_70 (0.012*3200/a,           0, 0.012*3200/a,           0, 0.012*3200/a,           0)  //< = 3200
        ELSE  sv_70 (0.121* 300/a, 0.074*300/a, 0.121* 300/a, 0.074*300/a, 0.121* 300/a, 0.074*300/a); //< = 300
      END else                   //'''''oli 0.74 => 0.074 +6.2.2
if fSam ('AVOJOHcu')  then
      CASE a OF             //<Cu AVOJOHTO:  NOKIA 20°C Rac,  SLY 40°C
         240 :sij (0.078);  {<NOKIA}     70 :sij (0.266);  {<NOKIA}
         185 :sij (0.101);  {<NOKIA}     50 :sij (0.365);  {<NOKIA}
         150 :sij (0.122);  {<NOKIA}     35 :sij (0.526);  {<NOKIA}
         120 :sij (0.150);  {<NOKIA}     25 :sij (0.718);  {<NOKIA}
          95 :sij (0.195);  {<NOKIA}     16 :sij (1.14 );  {<NOKIA}
                                         10 :Cu40(1.93 );  {<SLY}
       ELSE IF a>240
         THEN sij (0.0766*240/mm2)
         ELSE sij (1.7894* 10/mm2);   END else  // ohm/km
if fSam ('PLKVJ*')  then
      CASE a OF     //,,NOKIA 70°C,  SLY 40°C
         240 :Cu70 (0.097);{Mcmk3½}   70 :cu40 (0.292);         10 :cu40 (1.95);
         185 :Cu70 (0.124);{Mcmk3½}   50 :cu40 (0.420);          6 :Cu70 (3.08);{Mcmk4}
         150 :Cu70 (0.153);{Mcmk3½}   35 :cu40 (0.568);          4 :Cu70 (4.61);{Mcmk4}
         120 :cu40 (0.169);           25 :cu40 (0.787);
          95 :cu40 (0.212);           16 :cu40 (1.23 );
          ELSE IF a>240  THEN sij (0.081*300/mm2) {Mcmk3½}
                         ELSE sij (4.61 *  4/mm2);   END else
(*,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, -6.0.2
if fSam ('MCMK') or fSam ('MCMK4½')  then
       CASE a OF                          //NOKIA-99 Rdc.  SUL=Rdc/S-as/SSUL-91
         500 :sij (0.0366);{SUL}     120 :sij (0.153);          16 :sij (1.15);{mcmk4}
         400 :sij (0.047 );{SUL}      95 :sij (0.193);          10 :sij (1.83);{mcmk4}
         300 :sij (0.0601);           70 :sij (0.268);           6 :sij (3.08);{mcmk4}
         240 :sij (0.0754);           50 :sij (0.387);           4 :sij (4.61);{mcmk4}
         185 :sij (0.0991);           35 :sij (0.524);           2 :sij (7.41); //2.5
         150 :sij (0.124 );           25 :sij (0.727);           1 :sij (12.1); //1.5
       ELSE IF a>500  THEN sij (0.0366*500/a)
                      ELSE sij (4.61*4/a);      END else //<Ei ainakaan 1 tai 2*/a
//####### MMK*:n resistanssit ovat -83 ltlon mukaan pienempiä, uusien tuontikaap. takia näin.#######
if fSam ('MCMK3½') or fSam ('MCMK3½½') or fSam ('MMJ/MMK*')  then
       CASE a OF                          //Muut Cu-KAAPELIT. SUL=Rdc/S-as/SSUL-91, muut Rac / NOKIA
                                          //NOKIA-83 ltlossa MMK:n Rvac kylläkin pienempiä !!!!!!!!!
         500 :sij (0.0366);{SUL}     120 :sij (0.157);          16 :sij (1.15);{mcmk4}
         400 :sij (0.047 );{SUL}      95 :sij (0.196);          10 :sij (1.83);{mcmk4}
         300 :sij (0.0601);{mcmk4½}   70 :sij (0.27 );           6 :sij (3.08);{mcmk4}
         240 :sij (0.084 );           50 :sij (0.389);           4 :sij (4.61);{mcmk4}
         185 :sij (0.106 );           35 :sij (0.525);           2 :sij (7.41); //2.5
         150 :sij (0.129 );           25 :sij (0.728);           1 :sij (12.1); //1.5
       ELSE IF a>500  THEN sij (0.0366*500/a)
                      ELSE sij (4.61*4/a);      END else //<Ei ainakaan 1 tai 2*/a
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' -6.0.2 *)

if fSam ('MCMK ;MCMK3½ ;MCMK4½')  then    //Rac ,,+6.0.2
       CASE a OF                          //NOKIA-94/-99 Rac 70°C.  SUL=Rdc 20°/S-as/SSUL-91
         500 :sij  (0.0366);{SUL}
         400 :sij  (0.047 );{SUL}
         300 :if fSam ('MCMK3½')  then Cu40 (0.081) {-99}
                                  else Cu40 (0.080);{-99}
         240 :Cu70 (0.097);           70 :Cu70 (0.323);         10 :Cu70 (2.19);{mcmk4}
         185 :Cu70 (0.124);           50 :Cu70 (0.465);          6 :Cu70 (3.69);{mcmk4}
         150 :Cu70 (0.153);           35 :Cu70 (0.628);          4 :sij  (4.61);
         120 :Cu70 (0.187);           25 :Cu70 (0.871);          2 :Cu70 (8.87); //2.5
          95 :Cu70 (0.234);           16 :Cu70 (1.38 );{mcmk4}   1 :Cu70 (14.5); //1.5
       ELSE IF a>500  THEN sij (0.0366*500/mm2)
                      ELSE sij (4.61  *  4/mm2);   END else //<Ei ainakaan 1 tai 2*/a
if fSam ('MCMK3½½') then                                                                   //<Rac ,,+6.0.2
       CASE a OF                          //NOKIA-94 Rac 70°C.  SUL=Rdc 20°/S-as/SSUL-91
         500 :sij  (0.0366);{SUL}    120 :Cu70 (0.185);         16 :Cu70 (1.38);{mcmk4}
         400 :sij  (0.047 );{SUL}     95 :Cu70 (0.234);{mcmk3½} 10 :Cu70 (2.19);{mcmk4}
         300 :Cu70 (0.080 );{mcmk4½}  70 :Cu70 (0.322);          6 :Cu70 (3.69);{mcmk4}
         240 :Cu70 (0.0938);          50 :Cu70 (0.465);{mcmk3½}  4 :sij  (4.61);
         185 :Cu70 (0.124 );          35 :Cu70 (0.628);          2 :Cu70 (8.87); //2.5
         150 :Cu70 (0.153 );{mcmk3½}  25 :Cu70 (0.871);{mcmk3½}  1 :Cu70 (14.5); //1.5
       ELSE IF a>500  THEN sij (0.0366*500/mm2)
                      ELSE sij (4.61  *  4/mm2);   END else //<Ei ainakaan 1 tai 2*/a

if fSam ('MMJ/MMK*') or fSam('MMJ')  then                                                   //<Rac ,,+6.0.2   MMJ+130.2e
       CASE a OF      //NOKIA-83 Rac 70°C.  SUL=Rdc 20°/S-as/SSUL-91.   mcmk3½=NOKIA-90   mcmk4½=NOKIA-99
         500 :sij  (0.0366);{SUL}    120 :Cu70 (0.184);{MMK}    16 :Cu70 (1.38);{mcmk4 -90}
         400 :sij  (0.047 );{SUL}     95 :Cu70 (0.234);{mcmk3½} 10 :Cu70 (2.19);{mcmk4 -90}
         300 :Cu70 (0.080 );{mcmk4½}  70 :Cu70 (0.321);{MMK}     6 :Cu70 (3.69);{mcmk4 -90}
         240 :Cu70 (0.097 );{mcmk3½}  50 :Cu70 (0.465);{mcmk3½}  4 :sij  (4.61);
         185 :Cu70 (0.121 );{MMK}     35 :Cu70 (0.627);{MMK}     2 :Cu70 (8.87); //2.5
         150 :Cu70 (0.153 );{mcmk3½}  25 :Cu70 (0.871);{mcmk3½}  1 :Cu70 (14.5); //1.5
       ELSE IF a>500  THEN sij (0.0366*500/mm2)
                      ELSE sij (4.61  *  4/mm2);   END else //<Ei ainakaan 1 tai 2*/a
if fSam ('APAKM*')  then
      CASE a OF     //,,NOKIA -83 80°C Rac,  amcmk3½ =-83.  Tarkist/Muutettu 6.0.2
         240 :AL80 (0.161 );          70 :AL80 (0.552);
         185 :AL80 (0.208 );          50 :AL70 (0.771);{amcmk3½} //<Tarkista: 6.1.1:een lisätty valintamahis
         150 :AL70 (0.250 );{amcmk3½} 35 :AL40 (0.941);{SLY}
         120 :AL80 (0.317 );          25 :AL70 (1.44 );{amcmk3½}
          95 :AL70 (0.386 );{amcmk3½} 16 :AL70 (2.30 );{amcmk3½}
      ELSE IF a>240  THEN AL80 (0.161*240/mm2)
                     ELSE sij (1.91  * 16/mm2);   END else
(*    CASE a OF                              //AL ohm/km, SUL=Rdc/S-as/SSUL-91 s285. MUUT Rac/NOKIA ,,,-6.0.2
                                             //85,54,34,21 = AvojohtoAL/SLY, r40°C-muutettu 20°C:ksi
//##### 'AXMK', 'AXCMK', 'AMMK*', 'AMCMK,3½,3½½,4½', 'AVOJOHal' ####################################
         800 :sij (0.0367);{SUL91}   120 :sij (0.256 );         50 :sij (0.642 );
         630 :sij (0.0469);{SUL91}    95 :if fSam ('AXMK')  then sij (0.321)  else sij (0.322);
                                                                41 :sij (0.443 );
         500 :sij (0.0605);{SUL91}    88 :sij (0.206 );         35 :sij (0.869 );
         400 :sij (0.0778);{SUL91}    85 :sij (0.3378);         34 :sij (0.8486);
         300 :sij (0.13  );           72 :sij (0.253 );         29 :sij (0.641 );
         240 :if fSam ('AMCMK3½½') or fSam ('AMCMK4½')  then sij (0.129)  else sij (0.130 );
                                      70 :sij (0.444 );         25 :sij (1.2   );
         185 :sij (0.168 );           57 :sij (0.32  );         21 :sij (1.3604);
         150 :if fSam ('AXMK')  then sij (0.208)  else sij (0.209);
                                      54 :sij (0.5367);         16 :sij (1.91  );
      ELSE IF a>800  THEN sij (0.0367*800/mm2)
                     ELSE sij (1.91  * 16/mm2);   END; '''''''''''''''''''''''''''''''''''''''''''''*)

if fSam ('AXCMK')  then                      //AL ohm/km, SUL=Rdc 20°/S-as/SSUL-91 s.285,
      CASE a OF                              // AMCMK 70°, AXCMK Rac/NOKIA 90°C
         240 :AL70 (0.154);{amcmk}   70 :AL90 (0.533);
         185 :AL90 (0.214);          50 :AL70 (0.77 );{amcmk}
         150 :AL70 (0.248);{amcmk}   35 :AL90 (1.11 );
         120 :AL90 (0.327);          25 :AL70 (1.4  );{amcmk}
          95 :AL70 (0.385);{amcmk}
      ELSE IF a>240  THEN AL90 (0.134*300/mm2)
                     ELSE AL70 (2.3  * 16/mm2);{amcmk}  END else

//,,,##### AXMK, AMMK*, AMCMK3½, AMCMK3½o, AMCMK3½HD, 3½½,4½, AVOJOHal ################# AMCMK3½o,HD=+11.0.1 ######
      CASE a OF                       //AL ohm/km, SUL=Rdc 20°/S-as/SSUL-91 s.285,
                                      //85,54,34,21 = AvojohtoAL/SLY r40°C,  MUUT (sij) Rac 20° NOKIA
         800 :sij  (0.0367);{SUL91}   95 :AL70 (0.385);         41 :sij  (0.443);{?}
         630 :sij  (0.0469);{SUL91}   89 :sij  (0.349);{Dotterl}35 :AL70 (1.043);
         500 :sij  (0.0605);{SUL91}   85 :AL40 (0.365);{Pigeon} 34 :AL40 (0.917);{Sparrow}
         400 :sij  (0.0778);{SUL91}   72 :sij  (0.253);{?}      29 :sij  (0.641);{?}
         300 :AL70 (0.13  );          70 :AL70 (0.533);         25 :if fSam ('AXMK')  then AL70 (1.5)  else AL70 (1.4);
         240 :if fSam ('AXMK')  then AL70 (0.16)  else AL70 (0.154);
         185 :AL70 (0.198);           57 :sij  (0.32 );{?}      21 :AL40 (1.47 );
         150 :AL70 (0.248);           54 :AL40 (0.58 );{Raven}  16 :AL70 (2.3  );
         120 :AL70 (0.305);           50 :AL70 (0.77 );
      ELSE IF a>800  THEN sij  (0.0367*800/mm2)
                     ELSE AL70 (2.3   * 16/mm2);   END;

{-----------------------------------------------------------------------------------------------------------------
           =========== T°C                                      85           54     34     21
SLY        AvojohAL    40°                                      0.365        0.58   0.917  1.47

           =========== T°C  300    240    185    150    120     95    70     50     35     25     16
NOKIA -94  axcmk       90°  0.134         0.214         0.327         0.569         1.11 <<<<<HUOM. 90°, muissa 70°

           axmk        70°  0.13   0.16   0.2    0.25   0.31    0.39  0.53   0.77   1.0    1.5    2.3
      -83  ammk*       70°         0.151  0.198  0.248  0.305   0.385 0.533  0.770  1.043
           amcmk 4½    70°  0.13   0.15   0.2    0.25   0.31    0.39  0.53   0.77   1.0
           amcmk 3½    70°  0.13   0.15   0.2    0.25   0.31    0.39  0.53   0.77   1.0    1.4    2.3
           amcmk 3½½   70°         0.154  0.2           0.306         0.533         1.043
-----------------------------------------------------------------------------------------------------------------}

END;//FNC res
//==================================================================================================
FUNCTION resVo (CONST tyyppi :string;  mm2 :real) :Real;     VAR a :integer;             //<,,a=mm²<,,,+6.0.2
              //'FNC PALAUTTAA  vaihejohtimen NOLLAresistanssin [ohm/1m],   mm2=VAIHEJOHTIMEN ala.
(* function fSam (CONST si :string) :boolean;      begin                                            //<+6.0.2
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1*)

   PROCEDURE sij (r :Real);        BEGIN  resVo := r/1000;  END;
   PROCEDURE kis_90 (r1,r2,r3,r4,r5,r6 :Real);     VAR  ar :real;      BEGIN //90° Al/Cu Res 20°C:een
      ar := kis90_20 (tyyppi, r1,r2,r3,r4,r5,r6);
      sij (ar);   END;
   PROCEDURE sv_70 (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;      BEGIN //70° Al/Cu Res 20°C:een
      ar := svj70_20 (tyyppi, r1,r2,r3,r4,r5,r6);
      sij (ar);   END;                          //##################################################
                                                //##################################################
BEGIN//........................................ //##### Tyypit kirjoitettava EHDOTTOMAN OIKEIN #####
a := fM2 (mm2);                                 //##################################################
                                                //##################################################
if fOnKIS (tyyppi)  then //< Kiskot / Abb                                                           //<,,+6.0.2
      CASE a OF          //,,,ABB:n s-postista:  E:\Projektit\NolaKehi\SRC\ABB\Kiskot\ .PDF :nä
            //           1       2       3       4       5       6
            //          AlN  ,  AlS  ,  CuN  ,  CuS  ,  CuNx ,  CuSx =[Ohm/km]. LT 90°, AlCu tutkitaan FNC kis_90 :ssa.
        1600 :kis_90 (0.0233 ,0.01251,0.01331,0.0081 ,0      ,0      );  ELSE IF a>1600
        THEN  kis_90 (0.01163,0.00965,0.00797,0.00666,0.00797,0.00666)   //< = 3200
        ELSE  kis_90 (0.02962,0.02599,0      ,0      ,0      ,0      );  //< = 800
      END else
if fOnSV (tyyppi)  then                                                                             //<,,6.0.2
begin
      CASE a OF                    //,,,ohm/km Pirelli D007877_1 kV kaapelijärjestelmien nollaimpedanssit.PDF
             //         1       2       3       4       5       6
             //syst=   AL3½,   Cu3½,   AL4N,   Cu4N,   AL5S,   Cu5S   =[Ohm/km]
        2400 :sv_70 (0.0154,      0, 0.0171,      0, 0.0226,      0);
        1200 :sv_70 (0.0303, 0.0185, 0.0303, 0.0185, 0.0303, 0.0185);
         900 :sv_70 (0.042 , 0.0251, 0.0444, 0.0271, 0.0523, 0.0337);
         600 :sv_70 (0.0605, 0.037 , 0.0605, 0.037 , 0.0605, 0.037 );  ELSE  IF a>2400
        THEN  sv_70 (0.0116*3200/a,            0, 0.0116*3200/a,            0, 0.0116*3200/a,           0)  //< =3200
        ELSE  sv_70 (0.121 * 300/a, 0.074 *300/a, 0.121 * 300/a, 0.074 *300/a, 0.121 * 300/a, 0.074*300/a); //< =300
      END;//case
end else
   result := res (tyyppi,mm2); //<ÄÄRIJOHTIMEN res mukaan.
END;//resVo
//==================================================================================================
                                                         //,mm2=VAIHEJOHTIMEN mm², a=mm²
FUNCTION resPok (herjakin :boolean;  CONST tyyppi :string;  mm2 :real;  VAR onPE :boolean) :Real;   VAR a :integer;
              //PALAUTTAA PE-johtimen DCresistanssin [ohm/1m].  HERJAKIN=Herjaa jos resP eioo ao. mm2 :lle
   function fSam (CONST si :string) :boolean;      begin                                            //<+6.0.2
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1

   PROCEDURE Varoita;      var s :string;      begin
      onPE := false;
      if herjakin  then begin                                                     //<if herjakin... +6.2.19
         s := 'NOLA ei tunne johtotyypin "'+tyyppi +'" äärijohdinta ';
         if mm2<3  then s := s +fRmrkt0 (mm2,1,1)
                   else s := s +fImrkt0 (a,1);
         s := s +' mm² vastaavaa PE/PEN-johdinta, arvo lasketaan pienimmän tunnetun poikkipinnan suhteella, '+
                 'laskenta ei ole ehdottoman tarkka, OK.';
       //MessageDlg (s,mtInformation, [mbOK], 0);   end;                                         //'130.2e
         InfoDlg (s, mtCustom, 'OK','','','',  '','','','');  end;                               //<+6.2.2
   end;
   PROCEDURE sij (r :Real);        BEGIN  result := r/1000;  END;
   procedure sijVaro (r :real);    begin  sij (r);  Varoita;   end;
   PROCEDURE AL40 (r :Real);       var  ar :real;    BEGIN    //<Muuntaa AL 40°:n 20°C:een
      ar := rTaT20 (TRUE,r, 40);   //<R ilmoitettu 40°C :ssa.}
      sij (ar);   END;
   PROCEDURE Cu40 (r :Real);       var  ar :real;    BEGIN    //<Muuntaa Cu 40°:n 20°C:een
      ar := rTaT20 (FALSE,r, 40);  //<R ilmoitettu 40°C :ssa.}
      sij (ar);   END;
   PROCEDURE kis_90 (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;     BEGIN //90° Al/Cu Res 20°C:een
      ar := kis90_20 (tyyppi, r1,r2,r3,r4,r5,r6);
      sij (ar);   END;
   PROCEDURE sv_70 (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;      BEGIN //70° Al/Cu Res 20°C:een
      ar := svj70_20 (tyyppi, r1,r2,r3,r4,r5,r6);
      sij (ar);   END;
                                                //##################################################
BEGIN//resPok.................................. //##################################################
onPE := true;
a := fM2 (mm2);                                 //##### Tyypit kirjoitettava EHDOTTOMAN OIKEIN #####
IF fSam ('AMKA')  THEN                          //##################################################
         CASE a OF       //NOKIA 20°            //##################################################
            120 :sij (0.363);{95}  50 :sij (0.493);{70}  25 :sij (0.986);{35}
             70 :sij (0.363);{95}  35 :sij (0.72); {50}  16 :sij (1.38); {25}
         ELSE if a>120  then sijVaro (0.363*95/mm2)      //<,Menee kyllä karkeasti pieleen?  1101:  oli 0.363*120
                        else sijVaro (1.38 *16/mm2);  END ELSE
if fOnKIS (tyyppi)  then //< Kiskot / Abb                                                      //<,,+6.0.2
      CASE a OF          //,,,ABB:n s-postista:  E:\Projektit\NolaKehi\SRC\ABB\Kiskot\ .PDF :nä
            //           1       2       3       4       5       6
            //          AlN  ,  AlS  ,  CuN  ,  CuS  ,  CuNx ,  CuSx =[Ohm/km]. LT 90°, AlCu tutkitaan FNC kis_90 :ssa.
        1600 :kis_90 (0.0504 ,0.02252,0.03529,0.02252,0      ,0      );  ELSE IF a>1600
        THEN  kis_90 (0.02748,0.02147,0.01748,0.02147,0.01748,0.02147)   //< = 3200
        ELSE  kis_90 (0.06568,0.0216 ,0      ,0      ,0      ,0      );  //< = 800
      END else
{IF tyyppi='SVjärjest.'  then                                //<!½,,NÄMÄ 2 RIVIÄ VAIN NYT, KUNNES NK-Energy korjaa ???
         resP := res (tyyppi, mm2_Pj (tyyppi,mm2)) *2   else //<!½''NÄMÄ 2 RIVIÄ VAIN NYT, KUNNES NK-Energy korjaa ???}
if fOnSV (tyyppi)  then                                                                             //<,,6.0.2
begin                          //,NOKIA 70°,,,,,,, +6.0.2 = SIJ korvattu sv_70 :lla, 1600 ja 150 poistettu.
      CASE a OF                //,,,ohm/km Pirelli "D007877_1 kV kaapelijärjestelmien nollaimpedanssit.PDF"
             //         1       2       3       4       5       6
             //syst=   AL3½,   Cu3½,   AL4N,   Cu4N,   AL5S,   Cu5S   =[Ohm/km]
        2400 :sv_70 (0.0268,      0, 0.0195,      0, 0.0287,      0); //<,,LT + AlCu tutkitaan FNC sv_70 :ssa.!!!!
        1200 :sv_70 (0.0605, 0.037 , 0.0303, 0.0185, 0.0642, 0.0397);
         900 :sv_70 (0.0671, 0.0418, 0.0486, 0.0303, 0.0712, 0.0445);
         600 :sv_70 (0.1294, 0.0802, 0.0682, 0.0427, 0.1294, 0.0802);  ELSE  IF a>2400
        THEN  sv_70 (0.0233*3200/a,           0, 0.0137*3200/a,           0, 0.0254*3200/a,           0)  //< =3200
        ELSE  sv_70 (0.121 * 300/a, 0.074*300/a, 0.121 * 300/a, 0.074*300/a, 0.121 * 300/a, 0.074*300/a); //< =300
      END;//case
end else
if fSam ('AVOJOHal ;AVOJOHcu')  then
          result := res (tyyppi,mm2)   else
if fSam ('PLKVJ*')  then                          //SLY 40°.  MCK=varm.vuoksi mukana ja ne MCMK:n mukaan 20°.
       CASE a OF                                  //Cu ohm/km, SUL=Rdc/S-as/SSUL,-91 s.285 20°, MUUT Rdc 20°.
          240 :sij (0.153 );{MCK120}  120 :Cu40 (0.292);{70}   50 :Cu40 (0.787);{25}   16 :Cu40 (1.234);{16}
          185 :sij (0.193 );{MCK95}    95 :Cu40 (0.420);{50}   35 :Cu40 (1.234);{16}   10 :Cu40 (1.953);{10}
          150 :sij (0.268 );{MCK70}    70 :Cu40 (0.568);{35}   25 :Cu40 (1.234);{16}
          ELSE IF a>240  THEN sijVaro (0.153*120/mm2)      //<,Menee kyllä karkeasti pieleen?  1101: oli 0.153*240
                         ELSE begin  Cu40 (1.953*10/mm2);
                                     Varoita;  end;   END else
                         //,,NOKIA -83 Rdc 20°,  HUOM: Kaapelityyppi =4 x mm2.  ### Result := res (tyyppi, mm2) =ei onaa.
if fSam ('APAKM*')  then //11.0.1:  amcmk=>axmk =SAMOJA, ei muutoksia. Laskettu myös ohjelmallisesti vrt.arvoja
       CASE a OF         //         PaaVal.PAS/ApuLaske, Al k=0.00403 -kertoimilla.  HUOM: AL-vaippa=PEN-johdin.
          240 :sij (0.125 );{NOK83}   70 :AL40 (0.479);{SLY}
          185 :sij (0.164 );{NOK83}   50 :sij  (0.641);{axmk}         //<Tarkista: 6.1.1:een lisätty valintamahis
          150 :sij (0.206 );{axmk}    35 :AL40 (0.941);{SLY}          //AL40(0.941) => 0.87081
          120 :sij (0.253 );{NOK83}   25 :sij  (1.2  );{axmk}
           95 :sij (0.320 );{axmk}    16 :sij  (1.91 );{axmk}
           ELSE IF a>240  THEN sij (0.125*240/mm2)           
                          ELSE sij (1.91 * 16/mm2);   END else
if fSam ('AXMK')  then
       CASE a OF     //,,NOKIA -99 Rdc 20°.  HUOM: Kaapelityyppi = 4 x mm2
          300 :sij (0.100 );            120 :sij (0.253 );             35 :sij (0.868);
          240 :sij (0.125 );             95 :sij (0.320 );             25 :sij (1.20 );
          185 :sij (0.164 );             70 :sij (0.443 );             16 :sij (1.91 );
          150 :sij (0.206 );             50 :sij (0.641 );
          ELSE IF a>300  THEN sijVaro (0.100*300/mm2)              //<,Menee kyllä karkeasti pieleen?
                         ELSE sijVaro (1.91 * 16/mm2);   END  else //''ohm/km
if fSam ('MCMK ;MCMK3½ ;MCMK3½½ ;MCMK4½ ;MMJ/MMK* ;MMJ')  then     //< MMJ+130.2e
       CASE a OF     //Muut Cu-KAAPELIT ohm/km, Rdc / NOKIA
          500 :sij (0.0754);{240SUL}  120 :sij (0.268);{70}          16 :sij (1.15);{mcmk4}
          400 :sij (0.0991);{185SUL}   95 :sij (0.387);{50}          10 :sij (1.83);{mcmk4}
          300 :sij (0.124 );{150}      70 :sij (0.524);{35}           6 :sij (3.08);{mcmk4}
          240 :sij (0.153 );{120}      50 :sij (0.727);{25}           4 :sij (4.61);{mcmk4}
          185 :sij (0.193 );{95}       35 :sij (1.15 );{16}           2 :sij (7.41);{mcmk4}
          150 :sij (0.268 );{70}                                      1 :sij (12.1);{mcmk4}
                                       25 :if fSam ('MMJ/MMK*') or fSam('MMJ')              //< MMJ+130.2e
                                                                then sij (0.727) {25}
                                                                else sij (1.15 );{16}
          ELSE IF a>500  THEN sijVaro (0.0754*240/mm2)   //<,Menee kyllä karkeasti pieleen?  1101: oli 0.0754*500
                         ELSE sijVaro (4.61  *  4/mm2);   END else//<Ei ainakaan 1 tai 2*/a
(*if fSam ('AMCMK') or fSam ('AMCMK4½')  then ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,-6.0.2
       CASE a OF                           //NOKIA.  88,72,57,41,29,21,15,10=AMCMK_/AXCMK :n 0j:n Rdc
          300 :sij (0.206 );{88cu}      120 :sij (0.443 );{41cu}       35 :sij (1.15  );{16cu}
          240 :sij (0.253 );{72cu}       95 :sij (0.641 );{29cu}       25 :sij (1.91  );{10cuArvio}
          185 :sij (0.320 );{57cu}       70 :sij (0.868 );{21cu}       16 :sij (1.91  );{10cuArvio}
          150 :sij (0.443 );{41cu}       50 :sij (1.15  );{16cu}
          ELSE IF a>300  THEN sijVaro (0.206*300/a)             //<,Menee kyllä karkeasti pieleen?
                         ELSE sijVaro (1.91 *16/a);   END  else //''ohm/km ''''''''''''''''''''''''''''''*)
if fSam ('AMCMK ;AMCMK3½ ;AMCMK3½o ;AMCMK3½½ ;AMCMK4½ ;AXCMK')  then                  //<AMCMK3½o =+11.0.1
       CASE a OF                           //NOKIA.  88,72,57,41,29,21,15,10=AMCMK_/AXCMK :n 0j:n Rdc  //,+11.0.1
          300 :sij (0.206 );{88cu4½}    120 :sij (0.443 );{41cu}       35 :if fSam ('AMCMK3½o')  then sij (1.91{10cu}) else sij (1.15{16cu});
          240 :sij (0.253 );{72cu}       95 :sij (0.641 );{29cu}       25 :if fSam ('AMCMK3½o')  then sij (1.91{10cu}) else sij (1.15{16cu});
          185 :sij (0.320 );{57cu}       70 :sij (0.868 );{21cu}       16 :sij (1.91  );{10cu}
          150 :sij (0.443 );{41cu}       50 :sij (1.20  );{15cu}
          ELSE IF a>300  THEN sijVaro (0.206*88/mm2)      //<,Menee kyllä karkeasti pieleen?  1101: oli 0.206*300
                         ELSE sijVaro (1.91 *10/mm2);   END  else //''ohm/km
if fSam ('AMCMK3½HD')  then                //Dragan nettisivut 23.10.09 +Jorma Tahvanainen.   //<AMCMK3HD =+11.0.1
       CASE a OF
          150 :sij (0.206 );{88cu}       50 :sij (0.641);{29cu}
           95 :sij (0.320 );{57cu}       25 :sij (1.15 );{16cu}
          ELSE IF a>150  THEN sijVaro (0.206*88/mm2)      //<,Menee kyllä karkeasti pieleen?  1101: oli 0.206*300
                         ELSE sijVaro (1.15 *16/mm2);   END  else //''ohm/km
//'AMMK*',,,,,,,,,,,,,,,,//NOKIA.  Al ohm/km, SUL=Rdc/S-as/SSUL,-91 s285. MUUT Rac
       CASE a OF         //800..400 on otettu ½ mm2:n tai lähinnä pienemmän mm2:n FNC RES :n arvosta
          800 :sij (0.0778);{SUL 400}      185 :sij (0.32 );{ammk -83}    35 :sij (1.91 );{ammk -83}
          630 :sij (0.100 );{AXM 300}      150 :sij (0.443);{ammk -83}    25 :sij (1.91 );{AXM 16}
          500 :sij (0.125 );{AXM 240}      120 :sij (0.443);{ammk -83}    16 :sij (1.91 );{AXM 16}
          400 :sij (0.164 );{AXM 185}       95 :sij (0.641);{ammk -83}    10 :sij (1.91 );{AXM 16}
          300 :sij (0.206 );{AXM 150}       70 :sij (0.868);{ammk -83}
          240 :sij (0.253 );{ammk -83}      50 :sij (1.20 );{ammk -83}
          ELSE IF a>800  THEN sijVaro (0.0778*400/mm2)         //<,Menee kyllä karkeasti pieleen?  1101: oli *800
                         ELSE sijVaro (1.91  * 16/mm2);   END; // ohm/km
END;//FNC resPok
//==================================================================================================
FUNCTION resP (CONST tyyppi :string;  mm2 :real) :Real;      VAR boo :boolean;      begin
         result := resPok (TRUE, tyyppi, mm2, boo);  end;    //'mm2=ÄÄRIJOHTIMEN mm², a=mm².
//==================================================================================================

FUNCTION resN (CONST tyyppi :string;  mm2 :real) :Real;     VAR a :integer; 
              //'FNC PALAUTTAA  N-johtimen resistanssin [ohm/1m] :+6.2.15,   'mm2,a=VAIHEJOHTIMEN ala.
   function fSam (CONST si :string) :boolean;      begin
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1

  {PROCEDURE Varoita;      var s :string;      begin
      s := 'NOLA ei tunne johtotyypin "'+tyyppi +'" äärijohdinta ';
      if mm2<3  then s := s +fRmrkt0 (mm2,1,1)
                else s := s +fImrkt0 (a,1);
      s := s +' mm² vastaavaa PE/PEN-johdinta. Laskenta ei ole luotettava.';
    //MessageDlg (s,mtInformation, [mbOK], 0);   end;
      InfoDlg (s, mtCustom, 'OK','','','',  '','','','');  end;                                     //<+6.2.2}
   PROCEDURE sij (r :Real);        BEGIN  result := r/1000;  END;
  {procedure sijVaro (r :real);    begin  sij (r);  Varoita;   end;}
  {PROCEDURE AL40 (r :Real);       var  ar :real;    BEGIN    //<Muuntaa AL 40°:n 20°C:een
      ar := rTaT20 (TRUE,r, 40);   //<R ilmoitettu 40°C :ssa.
      sij (ar);   END;}
  {PROCEDURE Cu40 (r :Real);       var  ar :real;    BEGIN    //<Muuntaa Cu 40°:n 20°C:een
      ar := rTaT20 (FALSE,r, 40);  //<R ilmoitettu 40°C :ssa.
      sij (ar);   END;}
  {PROCEDURE kis_90 (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;     BEGIN //90° Al/Cu Res 20°C:een
      ar := kis90_20 (tyyppi, r1,r2,r3,r4,r5,r6);
      sij (ar);   END;}
   PROCEDURE sv_70 (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;      BEGIN //70° Al/Cu Res 20°C:een
      ar := svj70_20 (tyyppi, r1,r2,r3,r4,r5,r6);
      sij (ar);   END;

BEGIN//resN.................................... //##################################################
a := fM2 (mm2);
if fOnSV (tyyppi)
then if Mukana ('5s',tyyppi) //,NOKIA 70°,,,,,,, +6.0.2 = SIJ korvattu sv_70 :lla, 1600 ja 150 poistettu.
     then CASE a OF          //,,,ohm/km Pirelli "D007877_1 kV kaapelijärjestelmien nollaimpedanssit.PDF"
             //      1     2     3     4       5       6 (Mukana ('5s'..) rajaa sar:een 5 ja 6)
             //syst= AL3½, Cu3½, AL4N, Cu4N, AL5S,   Cu5S   =[Ohm/km]
        2400 :sv_70 (0   , 0   , 0   , 0   , 0.0267,      0); //<,,LT + AlCu tutkitaan FNC sv_70 :ssa.!!!!
        1200 :sv_70 (0   , 0   , 0   , 0   , 0.0642, 0.0397);
         900 :sv_70 (0   , 0   , 0   , 0   , 0.0669, 0.0417);
         600 :sv_70 (0   , 0   , 0   , 0   , 0.1294, 0.0802);  ELSE  IF a>2400
        THEN  sv_70 (0   , 0   , 0   , 0   , 0.0263*3200/a,           0)  //< =3200
        ELSE  sv_70 (0   , 0   , 0   , 0   , 0.121 * 300/a, 0.074*300/a); //< =300
      END//case
      else result := resP (tyyppi,mm2)
else if fSam ('MCMK ;MCMK4½ ;AMCMK ;AMCMK4½ ;AXMK')
   then result := res  (tyyppi,mm2) //<AXMK 4x ja _MCMK 4½x N-johdin on samaMm2 kuin vaihejohdin. Kommentti+11.0.1
   else result := resP (tyyppi,mm2);
END;//FNC resN
//==================================================================================================
                                                                               //,mm2,a=VAIHEJOHTIMEN ala.
FUNCTION Xv_ind (CONST tyyppi :string;  mm2 :real) :Real;      VAR a :integer; //Vaihejohtimen reaktanssi [ohm/1m]
   function fSam (CONST si :string) :boolean;      begin                                            //<+6.0.2
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1

   PROCEDURE sio (ohm_km :Real);  BEGIN  result := ohm_km/1000;  END;
   PROCEDURE siL (mH_km :Real);   BEGIN  result := (mH_km *314.15926/1000)/1000; END;
   PROCEDURE kis_o (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;     BEGIN
      ar := fKis6 (tyyppi, r1,r2,r3,r4,r5,r6);
      sio (ar);   END;

BEGIN//Xv_ind.............................
a := fM2 (mm2);
if fOnKIS (tyyppi)  then //< Kiskot / Abb                                                      //<,,+6.0.2
      CASE a OF                    //,,,ABB:n s-postista:  E:\Projektit\NolaKehi\SRC\ABB\Kiskot\ .PDF :nä
            //          1       2       3       4       5       6
            //         AlN ,   AlS ,   CuN ,   CuS ,   CuNx,   CuSx =[Ohm/km]
        1600 :kis_o (0.112 , 0.112 , 0.11  , 0.11  , 0     , 0      );  ELSE IF a>1600
        THEN  kis_o (0.044 , 0.044 , 0.107 , 0.107 , 0.044 , 0.044  )   //< = 3200
        ELSE  kis_o (0.12  , 0.12  , 0     , 0     , 0     , 0      );  //< = 800
      END else
if fOnSV (tyyppi)  then                                                                             //<,,6.0.2
      CASE a OF                    //<............ ohm/km SUURVIRTAJÄRJEST. SVsyst / NOKIA
         2400 :sio (0.033);        //<,,1kV:n kaap.järjest.luettelosta (=X). Ei muutosta 6.0.2 ,,,,,
         1200 :sio (0.041);
          900 :sio (0.036);
          600 :sio (0.052);  ELSE IF a>2400
         THEN  sio (0.039)
         ELSE  sio (0.124);  END else
if fSam ('AVOJOHal')  then
      CASE a OF          //<ohm/km:
         85 :sio (0.321);{SLY}      34 :sio (0.359);{SLY}
         54 :sio (0.34 );{SLY}      21 :sio (0.378);{SLY}
         ELSE IF a>85  THEN sio (0.321)
                       ELSE sio (0.378);  END else
if fSam ('AVOJOHcu')  then
      CASE a OF          //<ohm/km:
         70 :sio (0.32 );{SLY}      25 :sio (0.364);{SLY}
         50 :sio (0.33 );{SLY}      16 :sio (0.38 );{SLY}
         35 :sio (0.353);{SLY}      10 :sio (0.396);{SLY}
         ELSE IF a>70  THEN sio (0.32 )
                       ELSE sio (0.396);  END else
if fSam ('AMKA')  then
      CASE a OF          //<ohm/km:  NOKIA=SLY
         120 :sio (0.092);      50 :sio (0.101);      25 :sio (0.106);
          70 :sio (0.097);      35 :sio (0.104);      16 :sio (0.108);  //<???
         ELSE IF a>120  THEN sio (0.092)
                        ELSE sio (0.108);   END else
if fSam ('PLKVJ*')  then
      CASE a OF          //<ohm/km:  SLY
         120 :sio (0.085);    50 :sio (0.088);    16 :sio (0.105);
          95 :sio (0.085);    35 :sio (0.094);    10 :sio (0.11 );
          70 :sio (0.088);    25 :sio (0.094);
         ELSE IF a>120  THEN sio (0.085)
                        ELSE sio (0.11 );   END else
if fSam ('APAKM*')  then
      CASE a OF          //<mH/km:  NOKIA
         240 :siL (0.19);              50,70 :siL (0.21);{50varm.vuoksi} //<Tarkista: 6.1.1:een lisätty valintamahis
     185,150 :siL (0.19);{150varmksi}     35 :sio (0.072);{SLY}
     120,95  :siL (0.20);{ 95varmksi}
         ELSE IF a>240  THEN siL (0.19)
                        ELSE sio (0.072);    END else
if fSam ('AXMK')  then
      CASE a OF          //<mH/km:  NOKIA=SLY
         300,240:siL (0.25);            95,70 :siL (0.27);
         185,150:siL (0.26);          50,35,25:siL (0.28);
             120:siL (0.26);               16 :siL (0.29);
      ELSE IF a>300  THEN siL (0.25)
                     ELSE siL (0.29);    END else
if fSam ('AXCMK')  then
      CASE a OF          //<mH/km:  NOKIA=SLY
         300 :siL (0.22);               70 :siL (0.23);
         185 :siL (0.22);               35 :siL (0.24);
         120 :siL (0.22);               16 :siL (0.25);{Olet/eioo}
         ELSE IF a>300  THEN siL (0.22)
                        ELSE siL (0.25);    END else
if fSam ('AMMK* ;MMJ/MMK* ;MMJ')  then
       CASE a OF                                //<mH/km:  AMMK, MMJ/MMK / NOKIA=SLY
     300,240 :siL (0.24);      95 :siL (0.25);      25 :siL (0.26);{mcmk}  4 :siL (0.32);{mcmk}
         185 :siL (0.25);      70 :siL (0.25);      16 :siL (0.26);{mcmk}  2 :siL (0.32);{mcmk}
         150 :siL (0.25);      50 :siL (0.26);      10 :siL (0.28);{mcmk}  1 :siL (0.34);{mcmk}
         120 :siL (0.25);      35 :siL (0.26);       6 :siL (0.30);{mcmk}
         ELSE IF a>300  THEN siL (0.24)
                        ELSE siL (0.34);    END else
if fSam ('MCMK ;MCMK4½ ;AMCMK ;AMCMK4½')  then  //<_MCMK -> _MCMK4½
       CASE a OF                                //<mH/km:  AMCMK4½, MCMK4½ / NOKIA
         300,240,185,150,120,95 :siL (0.26);           10 :siL (0.28);{mcmk4}
                             70 :siL (0.26);            6 :siL (0.30);{mcmk4}
                          50,35 :siL (0.27);            4 :siL (0.32);{mcmk4~}
                             25 :siL (0.28);            2 :siL (0.32);{mcmk4}
                             16 :siL (0.26);{mcmk4}     1 :siL (0.34);{mcmk4}
         ELSE IF a>300  THEN siL (0.26)
                        ELSE siL (0.34);    END else //mH/km '''mcmk=amcmk, todettu!!!!!!!!!!!!!!!!!
if fSam ('MCMK3½½ ;AMCMK3½½')  then
       CASE a OF                                //<mH/km:  AMCMK3½½, MCMK3½½ / NOKIA
         300,240,185,150,120,95 :siL (0.25);
                             70 :if fSam ('MCMK3½½')  then siL (0.26)
                                                      else siL (0.25); //<Vain AMCMK3½½ :lla
                          50,35 :siL (0.26);            6 :siL (0.30);{mcmk4}
                             25 :siL (0.28);{mcmk}      4 :siL (0.32);{mcmk4~}
                             16 :siL (0.27);{arvio}     2 :siL (0.32);{mcmk4}
                             10 :siL (0.28);{mcmk4}     1 :siL (0.34);{mcmk4}
         ELSE IF a>300  THEN siL (0.26)
                        ELSE siL (0.34);    END else //mH/km '''mcmk=amcmk, todettu!!!!!!!!!!!!!!!!!
CASE a OF                               //<mH/km:  AMCMK3½,AMCMK3½o,AMCMK3½HD,MCMK3½ / NOKIA=SLY //<3½o,HD=+11.0.1
            300,240,185,150,120 :siL (0.23);
                          95,70 :siL (0.24);
                             50 :siL (0.25);
                             35 :siL (0.26);             6 :siL (0.30);{mcmk}
                             25 :siL (0.26);             4 :siL (0.32);{mcmk}
                             16 :siL (0.26);             2 :siL (0.32);{mcmk}
                             10 :siL (0.28);{mcmk}       1 :siL (0.34);{mcmk}
         ELSE IF a>300  THEN siL (0.23)
                        ELSE siL (0.34);    END; //mH/km '''mcmk=amcmk, todettu!!!!!!!!!!!!!!!!!!!!!
{-----------------------------------------------------------------------------------------------------------------
mH/km(/1000)          300    240    185    150    120     95    70     50     35     25     16  10  6  2,5  1,5
NOKIA      amcmk 3½   23     23     23     23     23      24    24     25     26     26     26 (28  30 32   34)
           amcmk 3½½  -      25     25     -      25      -     25     -      26     -      -
           amcmk 4½   26     26     26     26     26      26    26     27     27     -      -
NOKIA      mcmk 3½    23     23     23     23     23      24    24     25     26     26     -
           mcmk 3½½   -      25     25     -      25      -     26     -      26     -      -
           mcmk 4½    26     26     26     26     26      26    26     27     27     28     -

SAMANARVOISET RYHMITELTYNÄ:
mH/km(/1000)          300    240    185    150    120     95    70     50     35     25     16  10  6  2,5  1,5
           amcmk 3½   23     23     23     23     23      24    24     25     26     26     26 (28  30 32   34)
           mcmk 3½    23     23     23     23     23      24    24     25     26     26     -

           amcmk 3½½  -      25     25     -      25      -     25     -      26     -      -
           mcmk 3½½   -      25     25     -      25      -     26     -      26     -      -

           amcmk 4½   26     26     26     26     26      26    26     27     27     -      -
           mcmk 4½    26     26     26     26     26      26    26     27     27     28     -
-----------------------------------------------------------------------------------------------------------------}
END;//FNC Xv_ind  [Ohm/m]
//==================================================================================================

FUNCTION Xv0_ind (CONST tyyppi :string;  mm2 :real) :Real;      VAR a :integer;
         //'FNC PALAUTTAA: VAIHEjohtimen 0-reaktanssin [ohm/1m]. Riippuu rakent.   mm2,a=Vaihejohtimen poikkipinta.
   function fSam (CONST si :string) :boolean;      begin                                            //<+6.0.2
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1

   PROCEDURE sio (ohm_km :Real);  BEGIN  result := ohm_km/1000;  END;
   PROCEDURE svj (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;      BEGIN
      ar := fSV6 (tyyppi, r1,r2,r3,r4,r5,r6);
      sio (ar);
   end;
   PROCEDURE kis_o (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;     BEGIN
      ar := fKis6 (tyyppi, r1,r2,r3,r4,r5,r6);
      sio (ar);   END;
BEGIN//Xv0_ind................................
a := fM2 (mm2);

if fOnKIS (tyyppi)  then //< Kiskot / Abb                                                      //<,,+6.0.2
      CASE a OF          //,,,ABB:n s-postista:  E:\Projektit\NolaKehi\SRC\ABB\Kiskot\ .PDF :nä
            //          1       2       3       4       5       6
            //         AlN  ,  AlS  ,  CuN  ,  CuS  ,  CuNx ,  CuSx =[Ohm/km]
        1600 :kis_o (0.0435 ,0.057  ,0.0415 ,0.0564 ,0      ,0      );  ELSE IF a>1600
        THEN  kis_o (0.0415 ,0.0349 ,0.0408 ,0.0338 ,0.0408 ,0.0338 )   //< = 3200
        ELSE  kis_o (0.0583 ,0.0483 ,0      ,0      ,0      ,0      );  //< = 800
      END else
if fOnSV (tyyppi)  then //,,NOKIA,,,,,,,,,,, +6.0.2 = SIJ korvattu svj :lla, 1600 ja 150 poistettu. ,,6.0.2
      CASE a OF                    //,,,ohm/km Pirelli D007877_1 kV kaapelijärjestelmien nollaimpedanssit.PDF
             //syst= AL3½,   Cu3½,   AL4N,   Cu4N,   AL5S,   Cu5S   =[Ohm/km]
        2400 :svj (0.0363, 0,      0.0456, 0,      0.1169, 0     );
        1200 :svj (0.0048, 0.0048, 0.032 , 0.032 , 0.032 , 0.032 );
         900 :svj (0.0385, 0.039 , 0.0494, 0.049 , 0.1269, 0.1231);
         600 :svj (0.1374, 0.1374, 0.1374, 0.1374, 0.1374, 0.1374);  ELSE  IF a>2400
        THEN  svj (0.0025*3200/a, 0           , 0.0664*3200/a, 0           , 0.087 *3200/a, 0           ) //< =3200
        ELSE  svj (0.1929* 300/a, 0.1929*300/a, 0.1929* 300/a, 0.1929*300/a, 0.1526* 300/a, 0.1526*300/a);//< =300
      END else
{if tyyppi='SVjärjest.'  then  //< ohm/km ............ SUURVIRTAJÄRJEST. / NOKIA
   result := Xv_ind (tyyppi,a)  else //<!½ Kunnes NK-Energy korjaa                                 //< -6.0.2 }
if fSam ('AVOJOHal ;AMKA')  then
     CASE a OF                //<.............. ohm/km AVOJOHTOal + AMKA  /SLY
         120 :sio (0.03 );{AMKA /NOK=SLY}        85 :sio (0.503);{AVOJ /SLY}
          70 :sio (0.045);{AMKA /NOK=SLY}        54 :sio (0.525);{AVOJ /SLY}
          50 :sio (0.045);{AMKA /NOK=SLY}        34 :sio (0.551);{AVOJ /SLY}
          35 :sio (0.045);{AMKA /NOK=SLY}        21 :sio (0.567);{AVOJ /SLY}
          25 :sio (0.045);{AMKA /NOKIA=SLY}
          16 :sio (0.055);{AMKA /NOKIA=SLY}
         ELSE IF a>120  THEN if fSam ('AMKA')  then sio (0.03)
                                               else sio (0.503)
                        ELSE if fSam ('AMKA')  then sio (0.055)
                                               else sio (0.567);  END else
if fSam ('AVOJOHcu')  then  //<.................... ohm/km AVOJOHTO Cu  /SLY
     CASE a OF
         70 :sio (0.523);      25 :sio (0.557);
         50 :sio (0.535);      16 :sio (0.58 );
         35 :sio (0.543);      10 :sio (0.599);
         ELSE IF a>70  THEN sio (0.523)
                       ELSE sio (0.599);     END else
result := Xv_ind (tyyppi,a); //<..._MCMK,APAKM*,MMJ,AMMK,PLKVJ,AXMK,AXCMK =Xvaihe
END;//FNC Xv0_ind
//==================================================================================================
FUNCTION Xp_ind (CONST tyyppi :string;  mm2 :real) :Real;      VAR a :integer;
         //'FNC PALAUTTAA: SUOJAjohtimen reaktanssin [ohm/1m]. Riippuu rakent. //<NOLAjohtimen => SUOJA.. 10.0.3
         //'mm2,a=VAIHEJOHTIMEN ala = Xp_ind saadaan Xp_ind=f(a) = suoraan ltloista.
   function fSam (CONST si :string) :boolean;      begin                                            //<+6.0.2
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1

   PROCEDURE sio (ohm_km :Real);  BEGIN  result := ohm_km/1000;  END;
   PROCEDURE svj (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;      BEGIN
      ar := fSV6 (tyyppi, r1,r2,r3,r4,r5,r6);
      sio (ar);
   end;
   PROCEDURE kis_o (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;     BEGIN
      ar := fKis6 (tyyppi, r1,r2,r3,r4,r5,r6);
      sio (ar);   END;
BEGIN//Xp_ind,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,ohm/km
a := fM2 (mm2);
if fOnKIS (tyyppi)  then //< Kiskot / Abb                                                           //<,,+6.0.2
      CASE a OF          //,,,ABB:n s-postista:  E:\Projektit\NolaKehi\SRC\ABB\Kiskot\ .PDF :nä
            //          1       2       3       4       5       6
            //         AlN  ,  AlS  ,  CuN  ,  CuS  ,  CuNx ,   CuSx =[Ohm/km]
        1600 :kis_o (0.1203 ,0.0372 ,0.1125 ,0.0364 ,0      , 0      );  ELSE IF a>1600
        THEN  kis_o (0.126  ,0.0327 ,0.1239 ,0.0327 ,0.1239 , 0.0327 )   //< = 3200
        ELSE  kis_o (0.1217 ,0.0218 ,0      ,0      ,0      , 0      );  //< = 800
      END else
if fOnSV (tyyppi)  then  //,NOKIA,,,,,,,,,,, +6.0.2 = SIJ korvattu svj :lla, 1600 ja 150 poistettu. ,,6.0.2
      CASE a OF          //,,,ohm/km Pirelli D007877_1 kV kaapelijärjestelmien nollaimpedanssit.PDF
           //sno =    1       2       3       4       5       6
           //syst=   AL3½,   Cu3½,   AL4N,   Cu4N,   AL5S,   Cu5S   =[Ohm/km]
        2400 :svj (0.0826,      0, 0.0429,      0, 0.0948,      0);
        1200 :svj (0.0975, 0.0975, 0.068 , 0.068 , 0.109 , 0.108 );
         900 :svj (0.0904, 0.0886, 0.0494, 0.0475, 0.1042, 0.1016);
         600 :svj (0.1385, 0.1356, 0.0846, 0.082 , 0.1385, 0.1356);  ELSE  IF a>2400
        THEN svj (0.093 *3200/a, 0           , 0.0306*3200/a, 0           , 0.0589*3200/a, 0           ) //< =3200
        ELSE svj (0.1468* 300/a, 0.1468*300/a, 0.1468* 300/a, 0.1468*300/a, 0.1334* 300/a, 0.1334*300/a);//< =300
      END else                                                                                    //,3½o,HD=11.0.1
if fSam ('AMCMK ;AMCMK3½ ;AMCMK3½o ;AMCMK3½HD ;AMCMK3½½ ;AMCMK4½ ;MCMK ;MCMK3½ ;MCMK3½½ ;MCMK4½ ;APAKM*')  then
      result := 0  else                         //< = Xnjohd = 0 =Konsentr0j
if fSam ('AXCMK')  then                         //<................................. AXCMK /SLY
      IF a>=120  THEN sio (0.001)
                 ELSE result := 0  else
if fOnKIS (tyyppi)  then //< Kiskot / Abb                                                           //<,,+6.0.2
      CASE a OF                    //,,,ABB:n s-postista:  E:\Projektit\NolaKehi\SRC\ABB\Kiskot\ .PDF :nä
            //          1       2       3       4       5       6
            //         AlN  ,  AlS  ,  CuN  ,  CuS  ,  CuNx ,   CuSx =[Ohm/km]
        1600 :kis_o (0.0504 ,0.02252,0.03529,0.02252,0      , 0      );  ELSE IF a>1600
        THEN  kis_o (0.02748,0.02147,0.01748,0.02147,0.01748, 0.02147)   //< = 3200
        ELSE  kis_o (0.06568,0.0216 ,0      ,0      ,0      , 0      );  //< = 800
      END else
if fSam ('AVOJOHal ;AMKA')  then //<..........AVOJOHTO Al + AMKA
     CASE a OF
        120 :sio (0.078);{AMKA /NOK=SLY}  85 :sio (0.337);{AVOJ /SLY}
         70 :sio (0.07 );{AMKA /NOK=SLY}  54 :sio (0.358);{AVOJ /SLY}
         50 :sio (0.071);{AMKA /NOK=SLY}  34 :sio (0.377);{AVOJ /SLY}
         35 :sio (0.073);{AMKA /NOK=SLY}  21 :sio (0.396);{AVOJ /SLY}
         25 :sio (0.073);{AMKA /NOKIA=SLY}
         16 :sio (0.074);{AMKA /NOKIA=SLY}
         ELSE IF a>120  THEN sio (0.078)
                        ELSE sio (0.074);     END else
if fSam ('AVOJOHcu')  then  //<............................AVOJOHTO Cu  /SLY
     CASE a OF
         70 :sio (0.34 );      25 :sio (0.382);
         50 :sio (0.34 );      16 :sio (0.398);
         35 :sio (0.371);      10 :sio (0.414);
         ELSE IF a>70  THEN sio (0.34 )
                       ELSE sio (0.414);      END else
result := Xv_ind (tyyppi,a); //<.......... AXMK,AMMK*,MMJ/MMK*,PLKVJ* = Xvaihe
END;//FNC Xp_ind
//==================================================================================================

FUNCTION Xn_ind (CONST tyyppi :string;  mm2 :real) :Real;      VAR a :integer; //+6.2.15
         //'FNC PALAUTTAA: NOLLAjohtimen reaktanssin [ohm/1m]. Riippuu rakent.
         //'mm2,a=VAIHEJOHTIMEN ala = Xn_ind saadaan Xn_ind=f(a) = suoraan ltloista
   function fSam (CONST si :string) :boolean;      begin
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1

   PROCEDURE sio (ohm_km :Real);  BEGIN  result := ohm_km/1000;  END;
   PROCEDURE svj (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;      BEGIN
      ar := fSV6 (tyyppi, r1,r2,r3,r4,r5,r6);
      sio (ar);
   end;
BEGIN//Xn_ind,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,ohm/km
a := fM2 (mm2);
if fOnSV (tyyppi)
then if Mukana ('5s',tyyppi) //,NOKIA 70°,,,,,,, +6.0.2 = SIJ korvattu sv_70 :lla, 1600 ja 150 poistettu.
     then CASE a OF          //,,,ohm/km Pirelli "D007877_1 kV kaapelijärjestelmien nollaimpedanssit.PDF"
           //      1     2     3     4       5       6
           //syst= AL3½, Cu3½, AL4N, Cu4N, AL5S,   Cu5S   =[Ohm/km]
        2400 :svj (0   , 0   , 0   , 0   , 0.0699,      0); //<,,LT + AlCu tutkitaan FNC sv_70 :ssa.!!!!
        1200 :svj (0   , 0   , 0   , 0   , 0.109 , 0.108 );
         900 :svj (0   , 0   , 0   , 0   , 0.078 , 0.076 );
         600 :svj (0   , 0   , 0   , 0   , 0.1385, 0.1356);  ELSE  IF a>2400
        THEN  svj (0   , 0   , 0   , 0   , 0.0767*3200/a,           0)   //< =3200
        ELSE  svj (0   , 0   , 0   , 0   , 0.1238* 300/a, 0.1238*300/a); //< =300
      END//case
      else result := resP (tyyppi,mm2)                                   //,_MCMK=4½
else if fSam ( 'MCMK ;MCMK4½ ;MCMK3½½ ;AMCMK ;AMCMK4½ ;AMCMK3½½ ;AXMK')        
   then result := Xv_ind (tyyppi,mm2)        //<N-johdin on =vaihejohtimen ind.
   else result := Xp_ind (tyyppi,mm2);
END;//FNC Xn_ind
   {Kaikki tyypit:
    AMCMK3½ AMCMK3½o AMCMK3½HD AMCMK3½½ AMCMK4½ AXMK AXCMK AMMK*                     //<AMCMK3½o ja ..HD +11.0.1
    KiskAbb-AlN KiskAbb-AlS KiskAbb-CuN KiskAbb-CuS KiskAbb-CuNx KiskAbb-CuSx
    SVsystAL3½ SVsystCu3½ SVsystAL4N SVsystCu4N SVsystAL5S SVsystCu5S
    APAKM* AMKA AVOJOHal    MCMK3½ MCMK3½½ MCMK4½ MMJ/MMK* PLKVJ* AVOJOHcu}
//==================================================================================================

FUNCTION Xkap (CONST tyyppi :string;  mm2 :real) :Real;      VAR pii100 :Real;  a :integer;
       {FNC PALAUTTAA: Vaihejohtimen kap.reaktanss.[F/1m]. Riippuu rakenteesta.    'mm2,a=VAIHEJOHTIMEN ala
        TARKISTAMATTA:  AVOJOHDOT,  AMKA  = NYT OLETETTU
        TÄTÄ FNCta EI OLE KÄYTETTY = EI KUTSUJA, VAIKUTUS HÄVIÄVÄ 10e-6}
   function fSam (CONST si :string) :boolean;      begin                                            //<+6.0.2
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1

   PROCEDURE sic (uF_km :Real);   BEGIN
      Xkap := uF_km/1000000.0/1000*pii100;  END;
BEGIN
   a := fM2 (mm2);
   pii100 := 3.1415927*100;
if fSam ('AXMK')  then       //<................................. uF/km AXMK / NOKIA
     CASE a OF
             300 :sic (0.26);
             240 :sic (0.27);   25..95 :sic (0.29);
        120..185 :sic (0.28);       16 :sic (0.3 );
        ELSE IF a>300  THEN sic (0.26)
                       ELSE sic (0.3 );   END else
if fSam ('AXCMK')  then      //<................................ uF/km AXCMK / NOKIA
     CASE a OF                                                   //,,Arviot +6.0.2
        300 :sic (0.54);          70 :sic (0.5 );
        240 :sic (0.5 );{arvio}   50 :sic (0.4 );{arvio}
        185 :sic (0.47);          35 :sic (0.32);
        150 :sic (0.45);{arvio}   25 :sic (0.32);
        120 :sic (0.44);          16 :sic (0.28);
         95 :sic (0.45);{arvio}
        ELSE IF a>300  THEN sic (0.54)
                       ELSE sic (0.28);   END else
if fSam ('MMJ/MMK* ;MMJ ;AMMK* ;APAKM* ;PLKVJ*')  then           //< MMJ+130.2e
     CASE a OF   //_MMK*,APAKM*,PLKVJ, ks. Pentti Alatalo: Voimakaapelit ja asennusjohdot 1975, s.51
                 //APAKM* ks. myös Sähköasennukset 1 (SUL), s.287.
                 //ARVOT APAKM*´n mukaan, (arvio) = arvioitu SUL´n suhteessa ao. AMCMK3½ :een
        300 :sic (0.99);{arvio}  95 :sic (0.70);{arvio} 16 :sic (0.4 );{arvio}
        240 :sic (0.94);         70 :sic (0.63);        10 :sic (0.4 );{arvio}
        185 :sic (0.87);         50 :sic (0.58);{arvio}  6 :sic (0.35);{arvio}
        150 :sic (0.82);{arvio}  35 :sic (0.53);{arvio}  4 :sic (0.35);{arvio}
        120 :sic (0.78);         25 :sic (0.43);{arvio}  2 :sic (0.3 );{arvio}
        ELSE IF a>300  THEN sic (0.99)
                       ELSE sic (0.25);   END else     //<1.5mm²
if fSam ('AMCMK3½ ;AMCMK3½½ ;AMCMK3½o ;AMCMK3½HD ;MCMK3½')   then //<3½o,3½HD=11.0.1
     CASE a OF
        300 :sic (0.90);         95 :sic (0.75);        16 :sic (0.4 );
        240 :sic (0.85);         70 :sic (0.65);        10 :sic (0.4 );
        185 :sic (0.85);         50 :sic (0.6 );         6 :sic (0.35);
        150 :sic (0.8 );         35 :sic (0.55);         4 :sic (0.35);
        120 :sic (0.8 );         25 :sic (0.45);         2 :sic (0.3 );
        ELSE IF a>300  THEN sic (0.9)
                       ELSE sic (0.25);   END else //<1.5mm²
if fSam ('AMCMK ;AMCMK4½ ;MCMK ;MCMK4½')  then     //< _MCMK -> _MCMK4½
     CASE a OF
        300 :sic (0.8 );         95 :sic (0.65);        16 :sic (0.35);{arvio}
        240 :sic (0.8 );         70 :sic (0.55);        10 :sic (0.35);{arvio}
        185 :sic (0.75);         50 :sic (0.5 );         6 :sic (0.3 );
        150 :sic (0.7 );         35 :sic (0.45);         4 :sic (0.3 );
        120 :sic (0.7 );         25 :sic (0.4 );         2 :sic (0.3 );
        ELSE IF a>300  THEN sic (0.8)
                       ELSE sic (0.25);   END else //<1.5mm²
if fSam ('MCMK3½½')  then
     CASE a OF
        300 :sic (0.95);{arvio}  95 :sic (0.80);{arvio} 16 :sic (0.4 );{arvio}
        240 :sic (0.93);         70 :sic (0.71);        10 :sic (0.4 );{arvio}
        185 :sic (0.91);         50 :sic (0.65);{arvio}  6 :sic (0.35);
        150 :sic (0.85);{arvio}  35 :sic (0.55);         4 :sic (0.35);
        120 :sic (0.85);         25 :sic (0.45);{arvio}  2 :sic (0.3 );
        ELSE IF a>300  THEN sic (0.95)
                       ELSE sic (0.25);   END else //<1.5mm²
sic (0);        //<............................ AVOJOH, AMKA, SVjärjest.
{-----------------------------------------------------------------------------------------------------------------
uF/km(/1000)          300    240    185    150    120     95    70     50     35     25     16  10  6  2,5  1,5
NOKIA      amcmk 3½   90     85     85     80     80      75    65     60     55     45     40 (40  35 30   25)
           amcmk 3½½  -      85     85     -      80      -     65     -      55     -      -
           amcmk 4½   80     80     75     70     70      65    55     50     45     -      -
NOKIA      mcmk 3½    90     85     85     80     80      75    65     60     55     45     -
           mcmk 3½½   -      93     91     -      85      -     71     -      55     -      -
           mcmk 4½    80     80     75     70     70      65    55     50     45     40     -

SAMANARVOISET RYHMITELTYNÄ:
uF/km(/1000)          300    240    185    150    120     95    70     50     35     25     16  10  6  2,5  1,5
NOKIA      amcmk 3½   90     85     85     80     80      75    65     60     55     45     40 (40  35 30   25)
           mcmk 3½    90     85     85     80     80      75    65     60     55     45     -
           amcmk 3½½  -      85     85     -      80      -     65     -      55     -      -

           amcmk 4½   80     80     75     70     70      65    55     50     45     -      -
           mcmk 4½    80     80     75     70     70      65    55     50     45     40     -

           mcmk 3½½   -      93     91     -      85      -     71     -      55     -      -
-----------------------------------------------------------------------------------------------------------------}
END;//FNC Xkap                                                [Ohm/m]
//==================================================================================================
(*FUNCTION RmaxSV (syst :Integer;  mm2 :real) :Real;      var a :integer; //<syst: 1=norm  2=N  3=S
   PROCEDURE sij (arvo1,arvo2,arvo3 :Real); {ohm/m}   BEGIN
      CASE syst OF  1 :RmaxSV := arvo1 / 1000;    2 :RmaxSV := arvo2 / 1000;
      ELSE   RmaxSV := arvo3 / 1000;    END; END;                 //<Syst 3
BEGIN  a := fM2(mm2);  CASE a OF                  //XZX __   XZX __N  XZX _S
  3200 :sij (0.03125, 0.02730, 0.03298);  900 :sij (0.0911,  0.07985, 0.0941);   //<,,-6.0.2
  2400 :sij (0.03665, 0.03035, 0.03838);  600 :sij (0.15682, 0.10606, 0.15682);
  1200 :sij (0.07985, 0.06674, 0.08221);  ELSE sij (0.20125, 0.20125, 0.20125);  {<300} END;
END;//FNC RmaxSV*)
                                                  //,,,NOKIA/sis.muistio/Risto Kivisaari/Fax 3.12.91
FUNCTION RmaxSV (CONST tyyppi :string;  mm2 :real) :Real;      VAR a :integer;

   PROCEDURE svj (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;      BEGIN
      ar := fSV6 (tyyppi, r1,r2,r3,r4,r5,r6);
      result := ar / 1000; {ohm/m}
   end;

BEGIN  a := fM2(mm2);  CASE a OF
//,,Pirelli/ E:\ProjektitOhat\SVjarj\SJjarjC.exe 12.4.2002,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, +6.0.2
//,,Suoraan Jari ViVirjamo/Risto Kivisaari 10.9.1991:n muistion zMax=R+jX arvojen R -osa.(KommenttiLisätty 10.0.7)
//  R ilmoitettu: áAL300²=160°C  áAL800²=130°C,  áCu300²=130°C  
     //sno =    1       2       3       4       5       6
     //syst=   AL3½,   Cu3½,   AL4N,   Cu4N,   AL5S,   Cu5S   =[Ohm/km]
  2400 :svj (0.0529, 0     , 0.0438, 0     , 0.0554, 0     );
  1200 :svj (0.1249, 0.0697, 0.1044, 0.0585, 0.1286, 0.0727);
   900 :svj (0.1425, 0.0808, 0.1249, 0.0701, 0.1472, 0.0840);
   600 :svj (0.2453, 0.1398, 0.1659, 0.0949, 0.2453, 0.1398);  ELSE if a>2400
  THEN  svj (0.0451, 0     , 0.0394, 0     , 0.0476, 0     )  {<3200}
  ELSE  svj (0.3148, 0.1770, 0.3148, 0.1770, 0.3148, 0.1770); {<300 } END;//case
END;//FNC RmaxSV
//==================================================================================================
(*FUNCTION XmaxSV (syst :Integer;  mm2 :real) :Real;      var a :integer; //<syst: 1=norm  2=N  3=S
   PROCEDURE sij (arvo1,arvo2,arvo3 :Real); {ohm/m}   BEGIN
      CASE syst OF  1 :XmaxSV := arvo1 / 1000;    2 :XmaxSV := arvo2 / 1000;
      ELSE   XmaxSV := arvo3 / 1000;    END; END;                 //<Syst 3
BEGIN  a := fM2(mm2);  CASE a OF               //XZX __   XZX__N  XZX _S
  3200 :sij (0.1608, 0.1309, 0.1514);   900 :sij (0.153,  0.1387, 0.1881);
  2400 :sij (0.1418, 0.1308, 0.1743);   600 :sij (0.2465, 0.1924, 0.2465);
  1200 :sij (0.1674, 0.1571, 0.1839);  ELSE  sij (0.3567, 0.3567, 0.3198);  {<300} END;
END;//FNC XmaxSV*)

FUNCTION XmaxSV (CONST tyyppi :string;  mm2 :real) :Real;      VAR a :integer;

   PROCEDURE svj (r1,r2,r3,r4,r5,r6 :Real);      VAR  ar :real;      BEGIN
      ar := fSV6 (tyyppi, r1,r2,r3,r4,r5,r6);
      result := ar / 1000; {ohm/m}
   end;

BEGIN  a := fM2(mm2);  CASE a OF
//,,Pirelli/ E:\ProjektitOhat\SVjarj\SJjarjC.exe 12.4.2002,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, +6.0.2
//,,Suoraan Jari ViVirjamo/Risto Kivisaari 10.9.1991:n muistion zMax=R+jX arvojen X -osa.(KommenttiLisätty 10.0.7)
     //sno =    1       2       3       4       5       6
     //syst=   AL3½,   Cu3½,   AL4N,   Cu4N,   AL5S,   Cu5S   =[Ohm/km]
  2400 :svj (0.1418, 0     , 0.1308, 0     , 0.1743, 0);
  1200 :svj (0.1674, 0.1679, 0.1571, 0.1573, 0.1839, 0.1829);
   900 :svj (0.1530, 0.1509, 0.1387, 0.1375, 0.1881, 0.1844);
   600 :svj (0.2465, 0.2424, 0.1924, 0.1886, 0.2465, 0.2424);  ELSE if a>2400
  THEN  svj (0.1608, 0     , 0.1309, 0     , 0.1514, 0     )  {<3200}
  ELSE  svj (0.3567, 0.3567, 0.3567, 0.3567, 0.3198, 0.3198); {<300 } END;//case
END;//FNC XmaxSV
//=================================================== Nola10.INC ===================================
FUNCTION fZd1_ (alcu :Boolean;  mm2 :real) :Real;    var a :integer;//##############################
   PROCEDURE si (r :Real);   BEGIN  fZd1_ := r/1000;  END; //< HUOM:  r/1000  HUOM  HUOM  HUOM  HUOM
BEGIN                                                      //#######################################
   a := fM2 (mm2);                                         //<,'D1 :n tlk 41.5 s.80 SELLAISENAAN!!!!
   CASE alcu OF              //,,21,34,54,85 ovat AVOjohtoja<<<<<<<<<<<<<<<<<
   TRUE  :CASE a OF                        //Tlk D1 / 41.5 s.80,  ohm/km 80°C
       21,16 :si (2.326);  85,70 :si (0.557);   185 :si (0.222);
          25 :si (1.492);     95 :si (0.406);   240 :si (0.18 );
       34,35 :si (1.089);    120 :si (0.326);   300 :si (0.155);
       54,50 :si (0.8  );    150 :si (0.27 );   else si (0); END;
   FALSE :CASE a OF        //,,AMCMK_+AXCMK:n PEN<<<<<<<<<<<<<<<<<<<<<<<<<<<<
           1 :si (14.62);     29,25 :si (0.902);   150 :si (0.174);
           2 :si (8.77 );     41,35 :si (0.657);   185 :si (0.148);
           4 :si (5.48 );     57,50 :si (0.489);   240 :si (0.124);
           6 :si (3.66 );  88,72,70 :si (0.346);   300 :si (0.111);
       15,10 :si (2.246);        95 :si (0.257);
       21,16 :si (1.418);       120 :si (0.211);   else si (0); END;
   END;                    //'''Erikoiset luvut ovat AMCMK_/AXCMKn PENejä!!!!
END;//fZd1_
//..........................................
FUNCTION fZd1 (CONST tyyppi :string;  mm2 :real) :Real;    //<,Palauttaa D1-julkaisun mukaiset arvot x2 ##
      {VAR Zv,Zn :Real8;  mmN :Integer;  alN :Boolean;      }BEGIN
   fZd1 := 2*fZd1_ (fAlCu(tyyppi), fM2 (mm2));
(*---------------------------------------------------------------------
      alN := Nal (alcu,tyyppi,mm2);    {<,,Otti huomioon erikseen Zv+Zn, nyt}
      mmN := mm2_Pj (alcu,tyyppi,mm2); {takaisin 2*Zv = Alkuper D1:n ohje!!!}
   Zn := fZd1_ (alN,mmN);
            {^^^= Zn := fZd1_ (Nal (alcu,tyyppi), mm2_Pj (alcu,tyyppi,mm2));}
   fZd1 := Zv + Zn;
---------------------------------------------------------------------*)
END;//fZd1
//==================================================================================================
FUNCTION IksalTerm (CONST tyyppi :string;  mm2 :Real) :Real;      var a :integer;
         //'FNC Palauttaa VAIHEJOHTIMEN sallitun Max.IksTerm 1 s.    mm2,a=VAIHEJOHTIMEN ala
//################################################################################################################
//################################################################################################################
//##################### Pitäiskohän muuttaa PE/PEN-johtimen max. arvon mukaan, JOKA ON PIENEMPI ##################
//##################### JA SITEN RAJOITTAVAMPI ??????????????????????????????????????? :11.0.1 ###################
//################################################################################################################
//################################################################################################################



















   function fSam (CONST si :string) :boolean;      begin                                            //<+6.0.2
      result := {SamIso}OnYksiSama (si,tyyppi);  end;                                               //<11.0.1

   PROCEDURE sij (sal :Real);   BEGIN   IksalTerm := sal*1000;  END; //< *1000 = kA :sta A :ksi
                                                               // ##################################
BEGIN//...................................................     // ######### ALKU-LT = 70°C #########
a := fM2(mm2);                                                 // ##################################
if fSam ('AVOJOHal')  then                        //NOKIA avoAsOhj, 180C=T1 lk
   CASE a OF   54 :sij (5.0);    40 :sij (4.0);    34 :sij (3.2);
   ELSE   if a>54  then sij (mm2/85 *8.0) {=85}
                   else sij (mm2/21 *1.9);{=21}  END else
if fSam ('AVOJOHcu')  then                        //.... IkTrm ei tietoa, arvio
   CASE a OF   50 :sij (6.9);   35 :sij (4.8);   25 :sij (3.5);   16 :sij (2.2);
   ELSE   if a>50  then sij (mm2/70 *9.5)  {=70}
                   else sij (mm2/10 *1.38);{=10}  END else  //<10: laskettu
if fSam ('AMKA')  then                            //............... IkTrm/NOKIA
   CASE a OF   70 :sij (4.5);   50 :sij (3.20);   35 :sij (2.30);   25 :sij (1.6);
   ELSE   if a>70  then sij (mm2/120 *7.8) {=120}
                   else sij (mm2/ 16 *1.0);{=16}  END else
if fSam ('AXMK')  then                          //............... IkTrm/NOKIA
   CASE a OF  240 :sij (22.6);   120 :sij (11.3);   50 :sij (4.7);
              185 :sij (17.4);    95 :sij ( 8.9);   35 :sij (3.3);
              150 :sij (14.1);    70 :sij ( 6.6);   25 :sij (2.3);
   ELSE   if a>240  then sij (mm2/300 *28.3) {=300}
                    else sij (mm2/ 16 *1.5 );{=16}  END else
if fSam ('AXCMK')  then                         //............... IkTrm/NOKIA
   CASE a OF  240 :sij (18.2);   120 :sij (9.1);   50 :sij (3.8);
              185 :sij (14.0);    95 :sij (7.2);   35 :sij (2.6);
              150 :sij (11.4);    70 :sij (5.3);   25 :sij (1.9);
   ELSE   if a>240  then sij (mm2/300 *22.8) {=300}
                    else sij (mm2/ 16 *1.2 );{=16}  END else
if fOnKIS (tyyppi)  then
   CASE a of
      1600 :sij (80);  else if a>1600
       then sij (100)
       else sij (50);
   end else
(*if fSam ('SVjärjest.')  then               //a yhden osakaapln IkTermSall/NOKIA  -6.0.2
   CASE a OF 1600..3200 :sij (53.8);       //<AlkuT=70øC => AMMK 800mm2=53.8 kA
              300..1200 :sij (22.8);       //< - " -        AMMK 300mm2=22.8 kA
   ELSE   if a>3200  then sij (mm2/3200 *53.8) {=3200}
                     else sij (mm2/ 300 *22.8);{=300}  END else*)
if fOnSV (tyyppi)  then                                                                             //<,,+6.0.2
begin //,,Yhden osakaapln IkTermSall koska yksi johdin kestettävä, jos vain ao. osajohtimessa oikosulku.
      if fOnSVcu (tyyppi)
      then sij (46.3)  //< XMK Cu á 300 Talku = 70°C
      else if a>=2400
      then sij (80.1)  //< AXMK á 800 Talku = 70°C
      else sij (30.4); //< AXMK á 300 Talku = 70°C
end else
if fSam ('APAKM*')  then                   //.................. NOKIA. (Oli IkTrm/TTT-90 s.462)
   CASE a OF   185 :sij (18.2);   120 :sij (11.9);   70 :sij (7.0);
   ELSE   if a>185  then sij (mm2/240 *23.6) {=240}
                    else sij (mm2/ 35 *3.7 );{=35}  END else
if fSam ('PLKVJ*')  then                   //.................. IkTrm/TTT-90 s.462
   CASE a OF   95 :sij (15.0);   70 :sij (11.1);   50 :sij (7.98);
               35 :sij (5.62);   25 :sij (4.03);   16 :sij (2.6);
   ELSE   if a>95  then sij (mm2/120 *19.0) {=120}
                   else sij (mm2/ 10 *1.64);{=10}  END else
if fSam ('AMCMK ;AMCMK3½ ;AMCMK3½o ;AMCMK3½HD ;AMCMK3½½ ;AMCMK4½')  then//<NOKIA-99. +2.0.3   //<3½o,3HD=+11.0.1
   CASE a OF  240 :sij (18.2);    185 :sij (14.0);   150 :sij (11.4);   //<NOKIA. Oli 300: SSUL/S-as. s309, Alatalo s101
              120 :sij ( 9.1);     95 :sij ( 7.2);    70 :sij ( 5.3);
               50 :sij ( 3.8);     35 :sij ( 2.6);    25 :sij ( 1.9);
   ELSE   if a>240  then sij (mm2/300 *22.8) {=300}
                    else sij (mm2/ 16 *1.2 );{=16}  END else
if fSam ('AMMK*')  then                                                 //<NOKIA. Tämä oli <2.0.3 myös AMCMK:lle
   CASE a OF  240 :sij (17.3);    185 :sij (13.3);   150 :sij (10.8);   //<300: SSUL/S-as. s309, Alatalo s101
              120 :sij (8.7);      95 :sij (6.9);     70 :sij (5.1);
               50 :sij (3.6);      35 :sij (2.6);     25 :sij (1.89);
   ELSE   if a>240  then sij (mm2/300 *21.6) {=300}
                    else sij (mm2/ 16 *1.2 );{=16}  END else
if fSam ('MMJ/MMK* ;MMJ')  then                                         //<NOKIA. MMJ+130.2e
   CASE a OF  240 :sij (26.3);    185 :sij (20.3);
              150 :sij (16.5);    120 :sij (13.2);     95 :sij (10.5);
               70 :sij (7.7);      50 :sij (5.5);      35 :sij (3.9);
               25 :sij (2.8);      16 :sij (1.8);      10 :sij (1.1);
                6 :sij (0.7);       4 :sij (0.47);      2 :sij (0.3);  //< 2=2.5 mm2 ###############
   ELSE   if a>240  then sij (mm2/300 *32.8) {=300}        //<300: 32.8 /SSUL/S-as. s309, Alatalo s101
                    else sij (mm2/ 16 *1.2 );{=16}  END else
   CASE a OF  //............................................. njMCMK //NOKIA-99
              240 :sij (27.5);    185 :sij (21.2);
              150 :sij (17.2);    120 :sij (13.7);     95 :sij (10.9);
               70 :sij ( 8.0);     50 :sij ( 5.7);     35 :sij ( 4.0);//Tästä eteenp. ennallaan 25,16..1.5mm²
               25 :sij ( 2.8);     16 :sij ( 1.8);     10 :sij ( 1.1);
                6 :sij ( 0.7);      4 :sij (0.47);      2 :sij ( 0.3); //< 2=2.5 mm2 ###############
   ELSE   if a>240  then sij (mm2/300 *34.4) {=300}        //<NOKIA. Oli 300: 32.8 /SSUL/S-as. s309, Alatalo s101
                    else sij (mm2/1.5 *0.18);{=1.5} END;
END;//FNC IksalTerm
//================================================================================================================

FUNCTION fUn_Umn :real;   VAR um :integer;  ue,ka :real;      begin //<Muuntajan nimellisjännite +6.0.4
   ka := 0.95;
   ue := fUn;
   if ue > 1200*ka  then um := 1200  else
   if ue > 1000*ka  then um := 1000  else
   if ue >  840*ka  then um := 840   else
   if ue >  710*ka  then um := 710   else
   if ue >  525*ka  then um := 525   else
                         um := 410;
   result := um;  end;

FUNCTION fTrAlCu (HavSrj :integer;  Sm :real) :boolean;      begin
 //IF (HavSrj=1) AND (Sm>=250)    //< -5.0.1  Olivat 16.6.1993 saatujen (=7.11.2001:aa edeltävä) tietojen mukaisia.
   IF (HavSrj IN [1,11]) AND (Sm>=2500) //<  5.0.1  7.11.2001 saatujen tietojen (ABB/Juhani Ala-Toppari) mukaan.
      then result := true         //<Al     '6.0.0  11=Vanha tyyppi (>10)
      else result := false;  end; //<Cu
//================================================================================================================
//procedure HaeGparam_ (row :integer;  VAR rvS :string);      begin ... Nyt kuitenkin omana ohjelmanaa, jota kutsutaan ShellExec....
//================================================================================================================
//,,TYP: 1=Häviösrj.1=Norm.häviöt       2=Häviösrj.2=AlennTyhjKhäviöt     3=Häviösrj.3=AlennKuormitHäviöt
//       8=Etsi MinZ :n antava tyyppi   9=Etsi MaxZ :n antava tyyppi
//'''''''+10 = Vanhoilla (-93) tyypeillä.
PROCEDURE asMparam_ (qSmn :Real;  qTyp,qTuus :integer;  VAR qRm,qRmo, qXm,qXmo :Real;  VAR qMtyp :integer);
      CONST armax=25;                                                        //Ei tarvita Umn tietoa koska apuruu-
      TYPE  recType=Record  tSm,tRm,tXm,tRm0,tXm0 :real;  end;               //dustakin kutsuttaessa U2 = fUn.!!!!
            arType =ARRAY [1..armax] of recType;
      VAR Mar1,Mar2,Mar3,MarX{apu} :arType; //<Mar1[].tSm jne.
          u,alpTyp :integer;        {§VAIN testikäyttöön RecFilen :string;  RecFile :text;
                                     PROCEDURE AvaaSSfile;      begin
                                       RecFilen := 'M_ParamTest.txt';  AssignFile (RecFile,RecFilen);
                                       Rewrite (RecFile);  end;//§}
                    {£££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££
                    Testikäyttöön }{MuFilen :string;  MuFile :text;}
                     PROCEDURE wnF (sf :string);      begin end;{
                     if IsDebuggerPresent  then begin
                        MuFilen := gAjoPath; //+-12.0.05 oli: ExtractFilePath (Application.ExeName); //<Pelkkä polku ilman filenimeä
                        MuFilen := MuFilen +'Koe';//Data';                //< 10.0.7
                        if NOT DirectoryExists (MuFilen)  then             //<KoeFilen tässä vain DIR
                           ForceDirectories (MuFilen);
                        MuFilen := MuFilen +'\Muunt.TXT';
                        AssignFile (MuFile,MuFilen);
                        if NOT FileExists (MuFilen)
                           then Rewrite (MuFile)  //<Vain alkuluvussa kirjoitetaan uusiksi.
                           else Append  (MuFile); //<Muuten kirjoitetaa loppuun (kun tullaan >= 2.kerran tänne).
                        writeln (MuFile, sf +'   ' +DateTimeToStr (Now)); //< Tai:  sd := TimeToStr(Time);

                        CloseFile (MuFile);
                     end; end;//wnF £££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££}
   //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, +5.0.1
   PROCEDURE AlustaMar (VAR Mar :arType);      VAR i :integer;      begin //<,Arrey´ien alustus
      for i := 1 to armax  do begin
         Mar[i].tSm := 0;   Mar[i].tRm :=  0;   Mar[i].tXm :=  0;
                            Mar[i].tRm0 := 0;   Mar[i].tXm0 := 0;  end;  end;
   PROCEDURE Msij (VAR os :integer;  Sm,Rm,Xm,Rm0,Xm0 :real);      begin
      if os<=armax
      then begin
         MarX[os].tSm := Sm;   MarX[os].tRm :=  Rm;    MarX[os].tXm :=  Xm;
                               MarX[os].tRm0 := Rm0;   MarX[os].tXm0 := Xm0;  end
      else EiOkInfo ('Ilmoita valmistajalle:  Virhe muuntaja-arvotaulukkokoossa :  Varattu koko ' +
                      fImrkt0 (armax,1) +'  tarve>= '+fImrkt0 (os,1) +' /01.INC/asMparam_/Msij.  '+
                     'Ohjelma saattaa keskeytyä!');

      os := os +1;   end;

   PROCEDURE MsijU (VAR os :integer;  Sm,Rm,Xm,Rm0,Xm0, Un,Umn :real);      VAR k :real;      begin //+6.0.4
      k := Sqr (Un/Umn);              //YHTEISMITALLISTAA esim. 693 V :ssa annetut Z-komponentit 400 V :iin (tms.)
      Rm := Rm*k;  Rm0 := Rm0*k;      //MsijU käytetään kun Z-komponentit on annettu (Un) 400 V :sta poikkeavassa
      Xm := Xm*k;  Xm0 := Xm0*k;      //jännitteessä JA KUN KOMPONENTIT ON ANNETTU ohmeina. Yleensä Umn = 600,
      Msij (os, Sm,Rm,Xm,Rm0,Xm0);    //693, 710 V tms. !#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#
      Msij (os, Sm,Rm,Xm,Rm0,Xm0);    //Yleensä Un = 400 V.
   end;
   //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   PROCEDURE LoppuSij (rec1,rec2,rec3 :recType);      VAR R1,X1,R1o,X1o, R2,X2,R2o,X2o, R3,X3,R3o,X3o :Real;

      procedure sij (R,X,Ro,Xo :Real;  Utyp :integer);      VAR k,umn :real;  //sb :string{+8.0.1}; -10.0.7

       //FUNCTION rTkorjMuunt (Ralp :real;  HavSrj,Umn,Smn,Tuus :integer) :real;
         FUNCTION TkorjKerrMuunt :real;                                   //Palautta LT:n KorKer Tuus :lle. +6.0.4
               CONST aCU=235;  aAL=225;   VAR ar,aUmn,aSmn :real;  AlCu :boolean;  aK :integer;      begin
            ar := 1;             //Korjaa 75°C:sta poikkevan Rm,Rmo.  Huomioi Rac :n/Esa Virtanen e-mail 4.10.2002
            if qTuus<>75  then begin
               AlCu := fTrAlCu (Utyp{HavSrj},qSmn);
               aK := aCU;
               if AlCu  then aK := aAL;
               aUmn := fUn_Umn/1000;    //< V   => kV
               aSmn := qSmn/1000;       //< kVA => MVA
               ar := ( (aK+qTuus)/(aK+75) + 0.04*(aK+75)*aSmn/(aUmn*(aK+qTuus)) ) /
                     (1 + 0.04*aSmn/aUmn);
            end;
            result := ar;
         end;

        {Nyt ei enää tarvita kuin <>410 V lla, koska JO SIJOITUKSISSA 693, 700 V yms. YHTEISMITALLISTETTU 410 V:iin
         FUNCTION fUmn_Z_K (Smn,Umn :real) :real;      VAR k :real;      begin   //<Muuntajan Z -korjaukset +6.0.4
                                                   //Muuntajan KAIKKI imped.kompon. muuttuvat jännitteiden suhteen
                                                   //neliössä, isompi Umn => isompi Z. =Esa Virtanen 13.9.2002.!!
            if (Smn>=2250) and (Umn<>710)  then k := Sqr (Umn/710)  else //< 2500 kVA :n muuntajien imped. oli an-
            if (Smn <2250) and (Umn<>410)  then k := Sqr (Umn/410)       //  nettu 710 V :n muuntajien arvoina,
                                           else k := 1;                  //  muut 410 V :n arvoina.
            result := k;  end; ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''}
         FUNCTION fUmn_Z_K (Umn :real) :real;      VAR k :real;      begin //<Muuntajan Z -korjaukset +6.0.4
                                                    {Muuntajan KAIKKI imped.kompon. muuttuvat jännitteiden suhteen
                                                     neliössä, isompi Umn => isompi Z. =Esa Virtanen 13.9.2002.!!}
            if Umn<>410  then k := Sqr (Umn/410)       //Sijoituksissa jo YHTEISMITALLISTETTU 410 V:iin. Ohmiarvot
                         else k := 1;                  //samoja, vaikka Umn olisi ollut 400 V:  Esa Virtanen.!!!!!
            result := k;  end;
      begin//sij
         k := TkorjKerrMuunt;                                                  //<,Ekax korjataan perusmuuntajan
         R := R*k;  Ro := Ro*k;                                                //  arvot/Esa Virtanen mail 4.10.02
         umn := fUn_Umn;
         k := fUmn_Z_K ({qSmn,}umn);                                           //<,Imped. jännitekorjaus
         R := R*k;  X := X*k;  Ro := Ro*k;  Xo := Xo*k;                        //< Esa Vitanen, ks. fUmn_Z.. ed.
         qMtyp := Utyp;   qRm := R;   qRmo := Ro;   qXm := X;   qXmo := Xo;
               //=================================================================================================
                 if IsDebuggerPresent  then begin                              //,,+8.0.1, +10.0.7=Rmo,Xmo
                    wnF ('alpTyp=' +fImrkt0(alpTyp,2) + ' qTyp=' +IntToStr(qTyp) +'  sM=' +fRmrkt0(rec1.tSm,4,0) +
                         ' Rm=' +fRmrkt0 (qRm,1,6) + ' Rmo=' +fRmrkt0 (qRmo,1,6) +
                         ' Xm=' +fRmrkt0 (qXm,1,6) + ' Xmo=' +fRmrkt0 (qXmo,1,6) +
                         ' Zm=' +fRmrkt0 (Sqrt(Sqr(qRm)+Sqr(qXm)),1,6));
                 end;//'£££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££'
               //=================================================================================================
      end;//sij

      function ekaPienpi (Ra,Xa, Rb,Xb :real) :boolean;   begin  result := false;
         if (Ra + Xa) < (Rb + Xb)  then result := true;    end;
                                                                    //,Järjestys muutettu 3.0.0 (oli kylläkin OK)
      function ekaIsompi (Ra,Xa,Rao,Xao, Rb,Xb,Rbo,Xbo :real) :boolean;   begin     result := false;
         if Sqr (2*Ra+Rao) + Sqr (2*Xa+Xao) > Sqr (2*Rb+Rbo) + Sqr (2*Xb+Xbo)  then result := true;  end;

   BEGIN//LoppuSij.........................
      with rec1  do begin  R1 := tRm;   X1 := tXm;   R1o := tRm0;   X1o := tXm0;  end;              //<, +5.0.1
      with rec2  do begin  R2 := tRm;   X2 := tXm;   R2o := tRm0;   X2o := tXm0;  end;
      with rec3  do begin  R3 := tRm;   X3 := tXm;   R3o := tRm0;   X3o := tXm0;  end;
   CASE qTyp  of
     1 :sij (R1,X1,R1o,X1o, 1);  //< Häviösrj 1 >=2500 kVA = Al <<<<<<<<<<<<<<<<<
     2 :sij (R2,X2,R2o,X2o, 2);  //< Häviösrj 2+3:ssa kaikki koot = Cu <<<<<<<<<<
     3 :sij (R3,X3,R3o,X3o, 3);  //< Häviösrj 2+3:ssa kaikki koot = Cu <<<< ,,,,,,,,,,,,,,JärjestysKorjattu 3.0.0
     8 :if ekaPienpi (R1,X1, R2,X2) and ekaPienpi (R1,X1, R3,X3)  then sij (R1,X1,R1o,X1o, 1)  else
        if ekaPienpi (R2,X2, R1,X1) and ekaPienpi (R2,X2, R3,X3)  then sij (R2,X2,R2o,X2o, 2)  else
                                                                       sij (R3,X3,R3o,X3o, 3);
     9 :if ekaIsompi (R1,X1,R1o,X1o, R2,X2,R2o,X2o) and ekaIsompi (R1,X1,R1o,X1o, R3,X3,R3o,X3o) //<,ekaIsompiJär
                                                                  then sij (R1,X1,R1o,X1o, 1)  else//jestMuutettu
        if ekaIsompi (R2,X2,R2o,X2o, R1,X1,R1o,X1o) and ekaIsompi (R2,X2,R2o,X2o, R3,X3,R3o,X3o)   //<'3.0.0
                                                                  then sij (R2,X2,R2o,X2o, 2)  else
                                                                       sij (R3,X3,R3o,X3o, 3);
    else begin EiOkInfo ('Ilmoita valmistajalle:  Virhe muuntajaparametrikutsussa [Muuntajatyyppi: ' +
                         fImrkt0 (qTyp,1) +'], 01.INC/asMparam_.  Ohjelma jatkaa Häviösarjan 1 muuntajatyypillä.');
               sij (R1,R1o,X1,X1o, 1);  end;
   END; END;//case,LoppuSij
   //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, +5.0.1
   PROCEDURE EtsiSijParam; //,Sijoittaa edellisen (isomman) muuntajan arvot eXrec´iin ja <= koon arvot mXrec´iin
      VAR e1rec,e2rec,e3rec,                //<e1rec.tSm jne. =Edellinen (isompi) luettu arvo ao.tyypillä.
          m1rec,m2rec,m3rec :recType;       //<Näihin ao. koon tai pienemp. arvot Mar1[os]..Mar3[os] taulukoista.
                              {§arec :recType; //<FileenKirjoitukseen: Alp_mXrec ennen väliarv. =Vain testikäyttöön
                                PROCEDURE wRecs (eRec,mRec :recType); //<uRec=ao. mXrec VÄLIARVON sij.jälkeen
                                   PROCEDURE wr (s :string;  rec :recType);      begin
                                      with rec  do writeln (RecFile,s +'=' +
                                      fRmrkt0 (rec.tSm,5,0) +fRmrkt0 (rec.tRm, 9,5) +fRmrkt0 (rec.tXm, 9,5) +
                                                             fRmrkt0 (rec.tRm0,9,5) +fRmrkt0 (rec.tXm0,9,5)); end;
                                begin
                                   if qSmn>eRec.tSm
                                   then begin  wr ('    Sm',mRec);  wr ('Isompi',eRec);  wr ('Pienpi',aRec);  end
                                   else if qSmn<aRec.tSm
                                   then begin  wr ('Isompi',eRec);  wr ('Pienpi',aRec);  wr ('    Sm',mRec);  end
                                   else begin  wr ('Isompi',eRec);  wr ('    Sm',mRec);  wr ('Pienpi',aRec);  end;
                                   writeln (RecFile);
                                end;//§}
      PROCEDURE LasValiArvo (eXrec :recType;  VAR mXrec :recType);

         function fValiX (a1,a2 :real) :real;      VAR am :real;      begin//Laskee X väliarvon S/R mukaan
                         {Väliarvo pisteen Sm1,X1 ja Sm2,X2 :n välillä:   X2-X1   X2-am               X2-X1
                          am =X.. tai R.. ao. suureen mukaan.             ----- = -----  => am = X2 - -----(Sm-S2)
                                                                          S1-S2   Sm-S2               S1-S2       }
            if qSmn=mXrec.tSm     //<,,Ettei err: Float.point dividing by zero (jos S1-S2=0 tms.)!!!
            then am := a2         //<Edeltävässä sij.silmukassa a2 := aina arvo, min. a2=a1.!!!!!!!!
            else begin
               if qSmn>eXrec.tSm              //,Jos > isoin, arvot saattaisi <0, TODEETU, esim. Typ2 4 MVA.######
               then am := a1 *eXrec.tSm/qSmn  //<Jos menee tauluko yläpuolelle = Isommalla pienmät R,X :t
               else if qSmn<mXrec.tSm
               then am := a2 *mXrec.tSm/qSmn  //<Jos menee tauluko alapuolelle = Pienemmällä isommat R,X :t
               else am := a2 - (a2-a1)*(qSmn-mXrec.tSm)/(eXrec.tSm-mXrec.tSm)  //<Isommalla pienmät R,X :t
            end;                  //'Imped.komponenteissa vähennetään isomman muuntajan (=pienemmistä) arvoista.
            result := am;
         end;
      begin//LasValiArvo,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
         mXrec.tRm :=  fValiX (eXrec.tRm, mXrec.tRm);
         mXrec.tXm :=  fValiX (eXrec.tXm, mXrec.tXm);
         mXrec.tRm0 := fValiX (eXrec.tRm0,mXrec.tRm0);
         mXrec.tXm0 := fValiX (eXrec.tXm0,mXrec.tXm0);
         mXrec.tSm :=  qSmn;  //<Merkiksi mahd. väliarvosta. Käyttöä nyt vain TestFileen tulostuksessa.!!!
      end;//LasValiArvo       //'Kylläkin OK, koska mRec.tSm oli ALKUPERÄINEN kulmakerrointa laskettaessa.

      PROCEDURE EtsiSij (Xar :arType;  VAR eXrec,mXrec :recType);      VAR o :integer;      begin
         for o := 1 to armax  do begin
            if (Xar[o].tSm>0) or (o=1)        //< o=1 =Jotta aina olisi ainakin suurin sijoitettuna.
                then eXrec := Xar[o];         //<Viimeisen isomman muuntajakoon arvot EXreci´in.
            if (eXrec.tSm<=qSmn) or (Xar[o].tSm=0)  then begin
                       if o>armax  then ;//beep; //<Breakpointille.
               Break;  end;
         end;
         if o=1              //<,,Selvitetään eXre´in kohta, joka ohjaa mRecin kohtaa.##############
         then o := o+1
         else if Xar[o].tSm=0                 //<,Oli taulukon vikan arvon ohi =eXrec´iin edellinen
         then begin                           //  ja mRec´iin vika.
              eXrec := Xar[o-2];
              o := o-1;  end
         else eXrec := Xar[o-1];              //< o jää voimaan mXrec´ille.

         mXrec := Xar[o];
                  if o>armax  then ;//beep;      //<Breakpointille.
      end;//EtsiSij
   begin//EtsiSijParam,,,,,,,,,,,,,,,,,,,,,,,
      with e1rec  do begin  tSm := 0;  tRm := 0;  tXm := 0;  tRm0 := 0;  tXm0 := 0;  end; //<,Alustus
                       e2rec := e1rec;  e3rec := e1rec;
      m1rec := e1rec;  m2rec := e1rec;  m3rec := e1rec;

      EtsiSij (Mar1,e1rec,m1rec); //<,,Sijoittaa edellisen (isomman) muuntajan arvot eXrec´iin,
      EtsiSij (Mar2,e2rec,m2rec); //<,'ja ao. tai pienempi koko mXrec´iin.
      EtsiSij (Mar3,e3rec,m3rec);
                                 //§arec := m1rec;       //<Talteen ennen väliarvon sij.
      LasValiArvo (e1rec,m1rec); //§wRecs (e1rec,m1rec); //<,,Laskee isomman Sm:n (eXrec) ja pienemmän (mXrec) perusteella
                                 //§arec := m2rec;       //<,'ao. Sm kokoa vastaavan väliarvon ja sijoittaa mXrec´iin.
      LasValiArvo (e2rec,m2rec); //§wRecs (e2rec,m2rec);
                                 //§arec := m3rec;
      LasValiArvo (e3rec,m3rec); //§wRecs (e3rec,m3rec);
{Debuggauksen tarkkailuun:,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
1  Msij (u, 3150,  0.00039, 0.00358,  0.00059, 0.00411); //<5.0.1 uusi
   Msij (u, 2500,  0.00051, 0.00403,  0.00074, 0.00451); //<5.0.1 uusi
   Msij (u,  630,  0.00312, 0.01307,  0.00347, 0.01334); //<5.0.1 uusi // 630,  0.0027,  0.0116,   0.0031,  0.012);   //<Vanha-93
    VäliARVO 550:  0.00378, 0.01455,  0.00423, 0.01506
   Msij (u,  500,  0.00420, 0.01547,  0.00471, 0.01614); //<5.0.1 uusi // 500,  0.0037,  0.0139,   0.0042,  0.0143);  //<Vanha-93
   Msij (u,   30,  0.16,    0.1411,   0.0704,  0.0091);  //<Vanha-93
   Msij (u,   16,  0.37,    0.18,     0.2,     0.012);   //<Vanha-93
2  Msij (u, 2000,  0.00057, 0.00504,  0.00084, 0.00555); //<5.0.1 uusi  //2000,  0.0006,  0.0048,   0.0006,  0.0052);  //<Vanha-93
   Msij (u, 1600,  0.00074, 0.00630,  0.00105, 0.00672); //<5.0.1 uusi  //1600,  0.0008,  0.0060,   0.0008,  0.0065);  //<Vanha-93
   Msij (u,  630,  0.00237, 0.01201,  0.00267, 0.01254); //<5.0.1 uusi  // 630,  0.0024,  0.0125,   0.0025,  0.0130);  //<Vanha-93
   Msij (u,  500,  0.00329, 0.01479,  0.00370, 0.01513); //<5.0.1 uusi  // 500,  0.0032,  0.0157,   0.0033,  0.0163);  //<Vanha-93
   Msij (u,   50,  0.05951, 0.12103,  0.06052, 0.12103); //<5.0.1 uusi  //  50,  0.07,    0.107,    0.072,   0.011);   //<Vanha-93
   Msij (u,   30,  0.10927, 0.19612,  0.05603, 0.01121); //<5.0.1 uusi  //  30,  0.133,   0.167,    0.06,    0.008);   //<Vanha-93
3  Msij (u, 3150,  0.1067, 0.1786,  0.0469, 0.0115); //<Vanha-93 tieto, vasta nyt käyttöön =UUSI
   Msij (u, 2500,  0.0486, 0.1149,  0.0505, 0.1161); //<Vanha-93 tieto, vasta nyt käyttöön =UUSI
   Msij (u,   50,  0.0486, 0.1149,  0.0505, 0.1161); //<Vanha-93
   Msij (u,   30,  0.1067, 0.1786,  0.0469, 0.0115); //<Vanha-93                                   }
                                    //##############################################################
      LoppuSij (m1rec,m2rec,m3rec); //##############################################################
               {½if Mar1[1].tSm=-888  then beep;                                 //<Breakpointille.}
   end;//EtsiSijParam               //##############################################################
BEGIN//-----------------------------------------------------------------------------------------------------------
   alpTyp := qTyp;                         //<,+6.0.0  Laskenta vanhoilla muuntajatyypeillä (-93) = 11,12,13,18,19
   if alpTyp>10  then qTyp := qTyp -10;    //  Ei tarvetta tutkia tässä muualla, koska edv.pud.valikoissa karsittu.
                                     {****************************************************************************
                                      Uudet arvot on laskettu Rk%...Xk0% perusteisesti Esa Virtasen ohjeen mukaan:
                                         Esim:  Rm = Rk% * Un²[kV] / (100 * Sn[MVA])
                                                Xo = Xo% * Un²[kV] / (100 * Sn[MVA]) jne.
                                      ABB/Juhani Ala-Topparin 7.11.2001 e-mail´in liitetiedoston:
                                         C:\My Documents\ABB\vastusarvotPursiainen.prn  arvoista =>
                                         E:\Projektit\NolaKehi\Nola_Yle\ABB\Muunt\MUUNTvastusarvotPursiainen.prn.
                                      Ks. EdvNj\DetEv.PAS /TDetEvFrm.FormShow.
                                      ****************************************************************************}
   AlustaMar (MarX);
   Mar1 := MarX;   Mar2 := MarX;   Mar3 := MarX;
   u := 1;               //Msij kasvattaa u :ta +1.
if alpTyp<10  then begin //<,,UUDET TYYPIT. Väliarvot vanhoilla tyypeillä jos on: Käyttö myös Imped.tarkast.osassa.
   //       Sn:    Rm       Xm        Rm0      Xm0   =ohm T = 75°C   Häviösrj 1 = Array Mar1.
  {Msij (u, 3150,  0.00039, 0.00358,  0.00059, 0.00411); //<5.0.1 uusi  410 V
   Msij (u, 2500,  0.00051, 0.00403,  0.00074, 0.00451); //<5.0.1 uusi  410 V    -6.0.4}
   MsijU(u, 3150,  0.00110, 0.01013,  0.00166, 0.01164,  400,690); //<6.0.4 uusi  690 V  <,,MsijU  6.0.4
   MsijU(u, 2500,  0.00145, 0.01143,  0.00209, 0.01276,  400,690); //<6.0.4 uusi  690 V
   Msij (u, 2000,  0.00071, 0.00496,  0.00092, 0.00546);           //<5.0.1 uusi
   Msij (u, 1600,  0.00092, 0.00567,  0.00116, 0.00620);           //<5.0.1 uusi
   Msij (u, 1250,  0.00124, 0.00726,  0.00148, 0.00780);           //<5.0.1 uusi
   Msij (u, 1000,  0.00171, 0.00908,  0.00202, 0.00958);           //<5.0.1 uusi
   Msij (u,  800,  0.00223, 0.01135,  0.00252, 0.01177);           //<5.0.1 uusi
   Msij (u,  630,  0.00312, 0.01307,  0.00347, 0.01334);           //<5.0.1 uusi
   Msij (u,  500,  0.00420, 0.01547,  0.00471, 0.01614);           //<5.0.1 uusi
   Msij (u,  400,  0.0048,  0.0173,   0.0054,  0.0178);            //<Vanha-93
   Msij (u,  315,  0.00747, 0.02295,  0.00800, 0.02348);           //<5.0.1 uusi
   Msij (u,  250,  0.0097,  0.0237,   0.0105,  0.0242);            //<Vanha-93
   Msij (u,  200,  0.01034, 0.03194,  0.01093, 0.03278);           //<5.0.1 uusi
   Msij (u,  160,  0.0163,  0.0365,   0.0173,  0.0371);            //<Vanha-93
   Msij (u,  100,  0.0312,  0.0559,   0.0328,  0.0565);            //<Vanha-93
   Msij (u,   50,  0.0832,  0.0973,   0.0864,  0.0982);            //<Vanha-93
   Msij (u,   30,  0.16,    0.1411,   0.0704,  0.0091);            //<Vanha-93
   Msij (u,   16,  0.37,    0.18,     0.2,     0.012);             //<Vanha-93
end else begin //,,VANHAT (1993) TYYPIT,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   MsijU(u, 3150,  0.0010,  0.0106,   0.0017,  0.0176,  400,693);  //<Vanha-93.  <,,MsijU  6.0.4
   MsijU(u, 2500,  0.0013,  0.0134,   0.0020,  0.0203,  400,693);  //<Vanha-93.
   Msij (u, 2000,  0.0006,  0.0048,   0.0009,  0.0052);            //<Vanha-93
   Msij (u, 1600,  0.0008,  0.0059,   0.0011,  0.0064);            //<Vanha-93
   Msij (u, 1250,  0.0011,  0.0076,   0.0014,  0.0081);            //<Vanha-93
   Msij (u, 1000,  0.0015,  0.0079,   0.0018,  0.0083);            //<Vanha-93
   Msij (u,  800,  0.0018,  0.0092,   0.0021,  0.0096);            //<Vanha-93
   Msij (u,  630,  0.0027,  0.0116,   0.0031,  0.012);             //<Vanha-93
   Msij (u,  500,  0.0037,  0.0139,   0.0042,  0.0143);            //<Vanha-93
   Msij (u,  400,  0.0048,  0.0173,   0.0054,  0.0178);            //<Vanha-93
   Msij (u,  315,  0.0064,  0.0214,   0.007,   0.0219);            //<Vanha-93
   Msij (u,  250,  0.0097,  0.0237,   0.0105,  0.0242);            //<Vanha-93
   Msij (u,  200,  0.0112,  0.03,     0.012,   0.0305);            //<Vanha-93
   Msij (u,  160,  0.0163,  0.0365,   0.0173,  0.0371);            //<Vanha-93
   Msij (u,  100,  0.0312,  0.0559,   0.0328,  0.0565);            //<Vanha-93
   Msij (u,   50,  0.0832,  0.0973,   0.0864,  0.0982);            //<Vanha-93
   Msij (u,   30,  0.16,    0.1411,   0.0704,  0.0091);            //<Vanha-93
   Msij (u,   16,  0.37,    0.18,     0.2,     0.012);             //<Vanha-93 ???????
 //Msij (u,   10,  0.6,     0.3,      0.5,     0.04);              //<Vanha-93 arvattu
end;
   Mar1 := MarX;                                      //<Msij sijoitti MarX :ään.!!!!!!!!!!!!!!!!!!!

   AlustaMar (MarX);                                  //<Poistaa lopusta vanhoja tietoja alta.
   u := 1;               //Msij kasvattaa u :ta +1.
if alpTyp<10  then begin //<,,UUDET TYYPIT,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   //       Sn:    Rm       Xm        Rm0      Xm0   =ohm T = 75°C   Häviösrj 2 = Array Mar2.
   Msij (u, 2000,  0.00057, 0.00504,  0.00084, 0.00555); //<5.0.1 uusi
   Msij (u, 1600,  0.00074, 0.00630,  0.00105, 0.00672); //<5.0.1 uusi
   Msij (u, 1250,  0.00098, 0.00699,  0.00121, 0.00753); //<5.0.1 uusi
   Msij (u, 1000,  0.00134, 0.00790,  0.00151, 0.00841); //<5.0.1 uusi
   Msij (u,  800,  0.00179, 0.00967,  0.00210, 0.01009); //<5.0.1 uusi
   Msij (u,  630,  0.00237, 0.01201,  0.00267, 0.01254); //<5.0.1 uusi
   Msij (u,  500,  0.00329, 0.01479,  0.00370, 0.01513); //<5.0.1 uusi
   Msij (u,  400,  0.0043,  0.0195,   0.0045,  0.0203);  //<Vanha-93
   Msij (u,  315,  0.00534, 0.02241,  0.00587, 0.02295); //<5.0.1 uusi
   Msij (u,  250,  0.0082,  0.0289,   0.0084,  0.0295);  //<Vanha-93
   Msij (u,  200,  0.00967, 0.03194,  0.01009, 0.03278); //<5.0.1 uusi
   Msij (u,  160,  0.0147,  0.037,    0.0151,  0.038);   //<Vanha-93
   Msij (u,  100,  0.02505, 0.06220,  0.02522, 0.06388); //<5.0.1 uusi
   Msij (u,   50,  0.05951, 0.12103,  0.06052, 0.12103); //<5.0.1 uusi
   Msij (u,   30,  0.10927, 0.19612,  0.05603, 0.01121); //<5.0.1 uusi
end else begin //,,VANHAT (1993) TYYPIT,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   Msij (u, 2000,  0.0006,  0.0048,   0.0006,  0.0052);  //<Vanha-93
   Msij (u, 1600,  0.0008,  0.0060,   0.0008,  0.0065);  //<Vanha-93
   Msij (u, 1250,  0.0010,  0.0076,   0.0011,  0.0081);  //<Vanha-93
   Msij (u, 1000,  0.0014,  0.0095,   0.0015,  0.0100);  //<Vanha-93
   Msij (u,  800,  0.0018,  0.0107,   0.0019,  0.0113);  //<Vanha-93
   Msij (u,  630,  0.0024,  0.0125,   0.0025,  0.0130);  //<Vanha-93
   Msij (u,  500,  0.0032,  0.0157,   0.0033,  0.0163);  //<Vanha-93
   Msij (u,  400,  0.0043,  0.0195,   0.0045,  0.0203);  //<Vanha-93
   Msij (u,  315,  0.0058,  0.0248,   0.0059,  0.0253);  //<Vanha-93
   Msij (u,  250,  0.0082,  0.0289,   0.0084,  0.0295);  //<Vanha-93
   Msij (u,  200,  0.011,   0.034,    0.0113,  0.035);   //<Vanha-93
   Msij (u,  160,  0.0147,  0.037,    0.0151,  0.038);   //<Vanha-93
   Msij (u,  100,  0.028,   0.058,    0.0287,  0.06);    //<Vanha-93
   Msij (u,   50,  0.07,    0.107,    0.072,   0.011);   //<Vanha-93
   Msij (u,   30,  0.133,   0.167,    0.06,    0.008);   //<Vanha-93
   Msij (u,   16,  0.344,   0.205,    0.155,   0.01);    //<Vanha-93
 //Msij (u,   10,  0.5,     0.35,     0.4,     0.03);    //<Vanha-93 arvattu
end;
   Mar2 := MarX;                                      //<Msij sijoitti MarX :ään.!!!!!!!!!!!!!!!!!!!

   AlustaMar (MarX);                                  //<Poistaa lopusta vanhoja tietoja alta.
   u := 1;               //Msij kasvattaa u :ta +1.   UUSISSA TYYPEISSÄ EI OLE ENÄÄ tyyppiä 3.!!!!!!
   //       Sn:    Rm      Xm       Rm0     Xm0   =ohm T = 75°C   Häviösrj 3 = Array Mar3.
   MsijU(u, 3150,  0.0009, 0.0106,  0.0015, 0.0177,  400,693); //<Vanha-93 tieto, vasta nyt käyttöön =UUSI. <,MsijU  6.0.4
   MsijU(u, 2500,  0.0012, 0.0115,  0.0017, 0.0174,  400,693); //<Vanha-93 tieto, vasta nyt käyttöön =UUSI
   Msij (u, 2000,  0.0005, 0.0048,  0.0007, 0.0053);           //<Vanha-93
   Msij (u, 1600,  0.0007, 0.006,   0.0009, 0.0064);           //<Vanha-93
   Msij (u, 1250,  0.0009, 0.0063,  0.0011, 0.0067);           //<Vanha-93
   Msij (u, 1000,  0.0011, 0.0079,  0.0013, 0.0083);           //<Vanha-93
   Msij (u,  800,  0.0015, 0.0099,  0.0018, 0.0103);           //<Vanha-93
   Msij (u,  630,  0.0019, 0.0105,  0.0022, 0.0108);           //<Vanha-93
   Msij (u,  500,  0.0024, 0.0126,  0.0028, 0.0129);           //<Vanha-93
   Msij (u,  400,  0.0032, 0.0153,  0.0036, 0.0156);           //<Vanha-93
   Msij (u,  315,  0.0042, 0.0194,  0.0046, 0.0198);           //<Vanha-93
   Msij (u,  250,  0.0058, 0.0243,  0.0062, 0.0248);           //<Vanha-93
   Msij (u,  200,  0.0078, 0.0302,  0.0084, 0.0307);           //<Vanha-93
   Msij (u,  160,  0.0103, 0.0376,  0.0109, 0.0382);           //<Vanha-93
   Msij (u,  100,  0.02,   0.0591,  0.021,  0.0598);           //<Vanha-93
   Msij (u,   50,  0.0486, 0.1149,  0.0505, 0.1161);           //<Vanha-93
   Msij (u,   30,  0.1067, 0.1786,  0.0469, 0.0115);           //<Vanha-93
 //Msij (u,   16,  0.37,   0.18,    0.2,    0.012);            //<Vanha-93 arvattu
 //Msij (u,   10,  0.6,    0.3,     0.5,    0.04);             //<Vanha-93 arvattu
   Mar3 := MarX;                                  //<Msij sijoitti MarX :ään.!!!!!!!!!!!!!!!!!!!!!!!
                                   {§AvaaSSfile;
                                     Mar3[armax].tRm := qTyp; Mar3[armax].Tsm := qSmn;//<Alp. kutsuparam. TALTEEN.
                                     qSmn := 4000; EtsiSijParam;    qSmn := 3150; EtsiSijParam;
                                     qSmn := 16;   EtsiSijParam;    qSmn := 10;   EtsiSijParam;
                                     qSmn := 100;  EtsiSijParam;    qSmn := 550;  EtsiSijParam;
                                     qSmn := 700;  EtsiSijParam;
                                     qTyp := Trunc (Mar3[armax].tRm); qSmn := Mar3[armax].Tsm; //<Alp. PALAUTET.
                                     CloseFile (RecFile);//§}
   EtsiSijParam; //<Tämä ohjaa kaiken lopun.########################################################
   if alpTyp>10  then qMtyp := qMtyp +10;
END;//asMparam_
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NOLA01.INC }
{TTT v. 2000 s.378:  Oikosulkukestoisuus. Taulukko 13.6g. Muuntajien nimellis- ja oikosulkuvirrat eri jännitteillä
       ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, Ik [kA] ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
       ..............410 V...........    ..............525 V............    ..............710 V............
 kVA   S1..Nola   S2..Nola   S3..Nola    S1..Nola   S2..Nola   S3...Nola    S1..Nola   S2..Nola   S3...Nola  kVA
 100   3.7        3.5         -           2.9        2.7         -           2.1        2.0         -         100
 200   7.0        7.0         -           5.5        5.5         -           4.1        4.1         -         200
 315   9.9        9.9       11.1          7.7        7.7        8.7          5.7        5.7        6.4        315
 500  14.1       15.6       15.6         11.0       12.2       12.2          8.1        9.0        9.0        500
 800  20.5       22.5       22.5         16.0       17.6       17.6         11.8       13.0       13.0        800
1000  25.6       28.2       28.2         20.0       22.0       22.0         14.8       16.3       16.3       1000
1250  32.0         -        32.0         25.0         -        25.0         18.5         -        18.5       1250
1600  41.0         -        41.0         32.0         -        32.0         23.7         -        23.7       1600
2000  46.9         -        46.9         36.7         -        36.7         27.1         -        27.1       2000
2500  58.7         -        58.7         45.8         -        45.8         33.9         -        33.9       2500
3150  63.4         -        68.2         49.5         -        53.3         36.6         -        39.4       3150
Ry/Xy=0.0001249/0.0003122''''''''''''    0.0002047/0.0005118''''''''''''    0.0003744/0.0009361''''''''''''

Yläverkko 500 MVA, U1 = 20.5 kV, U2 = 0.41, 0.525, 0.710 kV.   Ik3v = Umn / V¨3 / Zk  = Uv / Zk.}





