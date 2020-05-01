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
{## INCluudattu ja kutsuttu (LaskeEkvivZpituus) NjTul30.INC :ssä ################################################
 ## Laskee ja tulostaa 3v-johdinkaapelin Xvo :n JA erillisPE-johtimen Xn :n kaavaa Xk1v = V¨(2Xv + Xvo + 3Xn) ###
 ## varten.  2Xv saadaan ao. kaapelin Xv_ind :stä.  Xvo ja Xn lasketaan kumpikin omilla SÄDE R :n arvoilla ja ###
 ## tilanteen mukaisen ETÄISYYS A :n arvolla. Xvo :n säde lasketaan ns. ekvivalenttisena arvona (=siinä JUJU).###}
PROCEDURE LaskeEkvivZpituus;      CONST pii=3.1416;  pii2f=314.16;
      {VAR s,sa,tyyppi :string;  {i,j,o :integer;  sade,etais,Lu,Xu,KekvPit :real;}

   function fLv (etaisA,sadeR :real) :real;      VAR ar :real;       begin //<Johdon induktanssi PER johdin = L
      ar := 0.0001 * (2 *( Ln(etaisA/sadeR) )+0.5);                        //' 1- tai 3v ########################
      result := ar;
   end;

   {,,M.Paavolan "Sähköjohtojen laskeminen" -kirjan s.128 esimerkki a) :n laskemiseen
   //,,1v-johdon kokonaisinduktanssi X, kun kaksi SAMANLAISTA johdinta = 2* ,,,,,,,,,,,,,,,,,,,,,,,,
   function fL1v (etaisA,sadeR :real) :real;      VAR ar :real;      begin
      ar := 2 *fLv (etaisA,sadeR);
      ar := ar *5;                                   //<Pituus=5 km -> L=0.0125H  X=3.9216W =OK / M.Paavola s.128
//      ar := ar /1000;                                //= [km] -> [m]
      result := ar;
   end;}

   function fXv (etaisA,sadeR :real) :real;      VAR ar :real;      begin  //<JohdinKOHTAINEN reaktanssi  = Xa
      ar := fLv (etaisA,sadeR) *pii2f /1000;    {=[ohmia/m]}               //< /1000 = [km] -> [m]
      result := ar;
   end;

   {,,Ei tarvita,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   function fX3v (etaisA,sadeR :real) :real;      VAR ar :real;      begin //<3v-johdon reaktanssi PER johdin =Xv
      result := fLv (etaisA,sadeR) *pii2f /1000;                           //'=Sama kuin fXv ####################
   end;}
   //................................................,,Ei käytetty
   function fEriste (tyyp :string;  mm2 :integer) :real;         VAR ar :real;      begin //<Eristepaksuus [mm]
      if (tyyp='AXMK') or (tyyp='AXCMK')                                //<,,Kari Aarela / 60502 IEC 1997 A1 1997
      then case mm2 of {=PEX [mm]}
             16     :ar := 0.7;
             25,35  :ar := 0.9;
             50     :ar := 1.0;
             70,95  :ar := 1.1;
             120    :ar := 1.2;
             150    :ar := 1.4;
             185    :ar := 1.6;
             240    :ar := 1.7;
           else{300} ar := 1.8; end
      else case mm2 of {PVC [mm]}
             16     :ar := 1;
             25,35  :ar := 1.2;
             50,70  :ar := 1.4;
             95,120 :ar := 1.6;
             150    :ar := 1.8;
             185    :ar := 2;
             240    :ar := 2.2;
           else{300} ar := 2.4; end;
      result := ar;
   end;//fEriste
   //................................................
   function fSade (mm2 :integer) :real;         VAR ar :real;      begin
      ar := Sqrt (mm2/pii);
      result := ar;
   end;
   //................................................

   procedure LaskeArvot (tyyp :string;  mm2 :integer);
         VAR Xv,sade,g_sade,ekv_r,g_etais,myy,ar :real;  sa :string;
                {'Palauttaa ekvivalenttisen SÄDEarvon R, jota voidaan käyttää 3v-kaapelin NOLLAreaktanssin laske-
                  miseen yksivaihetapauksena. Tällä lasketaan monijohdinkaapelin Xvo, Xn lasketaan erillisPE:n
                  SÄTEEn arvolla, ETÄISYYS A annetaan tilanteen mukaan reaktansseja laskettaessa.}
      //.............................................
      procedure tulost (s1 :string;  PEetaisU,sadeU :real;  Amm :integer;  s2 :string);
            VAR s :string;  ar,uXv :real;  d :integer;

         //..........................................,,Johdon reaktanssi PER johdin = L,  1- tai 3v
                                    {,,L = (myy/2*pii)*(Ln a/r +1/4),   X=2*pii*f  => X=(2*pii*f *myy/2*pii)*(..)
                                       X = f*myy * [ Ln(a/r) + 1/4] ,,,,,,,,,,,}
         function fXvo (etaisA,sadeR :real) :real;      VAR ar :real;       begin
            ar := 50*myy *( Ln(etaisA/sadeR) +0.25);    //< =[ohmia/m], koska myy :ssä jo huomioitu /1000 !!!!!!!
            result := ar;
         end;
               //..........................................
         function eroXv :real;      begin
            result := (uXv/Xv -1) *100;   end;
      begin//Tulost
         ar := PEetaisU;  if ar>=1000  then begin s := ' m';  ar := ar/1000;  end
                                       else       s := ' mm';
            if fMuokDes (ar,1) >= 100   then d := 0  else
            if fMuokDes (ar,2) >= 10    then d := 1  else
            if fMuokDes (ar,3) >= 1     then d := 2  else  d := 3;

         uXv := fXv (PEetaisU,sadeU);
       //adStF ('          '+s2);       //,*1000 = Ohmia -> milliOhmeiksi
         s := s1 +'   Xpe = ' +fRmrkt0 (uXv*1000,1,4) +' m' +FONT_OMEGA +tab1 +'   eroXv = ' +
              fRmrkt0 (eroXv,1,2) +'%    ' +tab1 +'a = ' +fRmrkt0 (ar,1,d) +s +tab1 +'r = ' +
              fRmrkt0 (sadeU,1,4)+' mm   mm² = ' +fImrkt0 (Amm,1) +'     '+s2;
         adStF (s);
      end;//Tulost
   begin//LaskeArvot,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      myy := 4*3.1416*0.0001/1000; //< [H/m]
      Xv := Xv_ind  (tyyp,mm2);                                               //<TYYP ='AMCMK3½' tms.
      sade := fSade (mm2);                            //<1.5mm² r=0.69,  6mm² r=1.38,  300mm² r=9.77
                    (*Geometrinen keskiETÄISYYS a laskettuna Xv :stä, kun olet  r tunnetuksi:,,,,,,,
                              Xvo = f*myy* [Ln(a/r) +1/4]  =  f*myy [Ln(a)-Ln(r) +1/4]
                              Xvo/(f*myy) = Ln(a) - Ln(r) + 1/4
                              =>  Ln(a) = Xvo/(f*myy) + Ln(r) - 1/4
                              Koska  Ln(a)=c  ja  Exp(c)=a
{1}                           =>=>   a = Exp { Xvo/(f*myy) + Ln(r) - 1/4 }   '
                      Ekviv. SÄDE r laskettuna Xv :stä, kun olet  a tunnetuksi:
{2}                           =>=>   r = Exp { Ln(a) + 1/4 - Xvo/(f*myy) }   '''''''''''''''''''''''*)
{1}      g_etais := Exp ( Xv/(50*myy) + Ln(sade) - 1/4 );             //<Johdinetäisyyksien geometrinen keskiarvo
{3}      g_sade :=  Exp ( (1/3) *Ln(sade*Sqr(g_etais)) );             //< 3 :s juuri (r*g_etais²) :sta
            ar := 2*( sade+fEriste(tyyp,mm2) );
{2}      ekv_r := Exp ( Ln(ar) + 1/4 - Xv/(50*myy) );

      sa :=  'A   ' +tyyp +' ' +fImrkt0 (mm2,1) +'    Xvo = Xv ' +tab1 +tab1 +'= ' +fRmrkt0 (Xv*1000,1,4) +' m' +
             FONT_OMEGA +'/m';
      adStF (sa);
      adStF ('B   Äärijohtimen säde r´' +tab1 +tab1 +'= '+fRmrkt0 (sade,1,4) +'   = ' +FONT_2JUURI +'(mm²/' +FONT_PII +')');
{1}   adStF ('C   Äärijohdinnipun geom.keskietäis. ' +tab1 +'= ' +fRmrkt0 (g_etais,1,4) +'   Laskettuna Xv :sta, '+
             ' kun r = r´.');
//{3}   adStF ('D   Äärijohdinnipun ekviv. säde ' +tab1 +'= ' +fRmrkt0 (g_sade,1,4) +'   = 3.juuri (r´ * geomkeskietäis²)');
{3}   adStF ('D   Äärijohdinnipun ekviv. säde ' +tab1 +'= ' +fRmrkt0 (g_sade,1,4) +'   = ³' +FONT_2JUURI +' (r´ * geomkeskietäis²)');
{2}   adStF ('E   Äärijohdinnipun ekviv. säde ' +tab1 +'= ' +fRmrkt0 (ekv_r,1,4) +'   Laskettuna Xv :stä, kun '+
             'a = 2(r´+eriste).');
      adStF ('F   Äärijohdinnipun keskipistesäde ' +tab1 +'= ' +fRmrkt0 (g_etais/Sqrt(3),1,4) +
           //'   = Geom.keskiet./'+FONT_2JUURI +'3');
             '   = Geom.keskiet./' +FONT_2JUURI +'3'); //<Koe 7.0.4
            //,  ekv_a = äärijohtimien keskietäisyys');

      adStF ('.  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .');
{1}   tulost ('  1',g_etais,sade,mm2,
                   '= Kun a = ekviv. etäisyys f(Xv,r),   r = r´.');
{2}   tulost ('  2' ,ar ,ekv_r, mm2,
                   '= Kun a = 2 * (r´ + eriste),   r = f(Xv,a).');
{3}   tulost ('  3',2*( sade+fEriste(tyyp,mm2) ),  sade,mm2,
                   '= Kun a = 2 * (r´ + eriste),   r = r´.');
{4}   tulost ('  4',2*( sade+fEriste(tyyp,mm2) ), g_Sade,mm2,
                   '= Kun a = 2 * (r´ + eriste),   r = geometrinen keskisäde = ³' +FONT_2JUURI +'(r´ * a²)  '+
                   '= 3.juuri(r´ * a²).');
      tulost ('  5' ,3*( sade+fEriste(tyyp,mm2) ), sade,mm2,
                   '= Kun a = 3 * (r´ + eriste),   r = r´ (tämä vain uteliaisuudesta).');
      tulost ('  6' ,2*sade +fEriste(tyyp,mm2)  ,  sade,mm2,
                   '= Kun a = 2 * r´ + eriste,   r = r´ (tämäkin vain uteliaisuudesta).');

      adStF ('.  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .');
      ar := mm2;
      if ar<0  then ;
    //tulost ('  7',100,fSade(mm2_0j(tyyp,mm2)),mm2_0j(tyyp,mm2),  //<PE:n etaisyys pääjohdosta, PE:n mm2=PENmm2
//      procedure tulost (s1 :string;  PEetaisU,sadeU :real;  Amm :integer;  s2 :string);
//      function fSade (mm2 :integer) :real;         VAR ar :real;      begin
//////tulost ( s1  ,PEetaisU,
//////                  sadeU :real;                 ,Amm :integer;            s2 :string);
      tulost ('  7',100,fSade(pyor(mm2_Pj(tyyp,mm2))),pyor(mm2_Pj(tyyp,mm2)), '= Kun mm² = PEmm².');
      //'PE:n etaisyys pääjohdosta, PE:n mm2=PENmm2
      tulost ('  8',100,fSade(mm2),mm2,'');                        //<PE:n etaisyys pääjohdosta, PE:n mm2=VaiheMm2
      tulost ('  9',500,fSade(mm2),mm2,'');
      tulost ('10',1000,fSade(mm2),mm2,'');
      tulost ('11',5000,fSade(mm2),mm2,'');
      tulost ('12',10000,fSade(mm2),mm2,'');
      tulost ('13',100000,fSade(mm2),mm2,'');
   end;//LaskeArvot
   //................................................
begin//..............................................................
   LF;  //,+07.0.4
   adStF ('\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\');
 //adStF ('<b>Erillisen suojajohtimen aiheuttama pää-/nousujohdon pituuden korjauskerroin Kpit :</b>');
 //adStF ('<b>Erillisen suojajohtimen reaktansseja (Xpe), kun PEmm² = vaihejohtimen mm² :</b>');
   adStF ('<b>Erillisen suojajohtimen reaktansseja (Xpe) :</b>');
   adStF ('TAVOITE:   '+tab1 +'Löytää parametrit, joilla saadaan lasketuksi erillisPE-johtimen reaktanssi Xn ja '+
          'sitä ''syöttävän'' monijohdinkaapelin NOLLAreaktanssi Xvo.');
   adStF ('LÄHTÖKOHTA:   '+tab1 +'Monijohdinkaapelin NOLLAreaktanssi Xvo tunnetaan silloin, kun PE-johdin on samassa '+
          'rakenteessa.');
   adStF ('RATKAISUTAPOJA:');
   adStF ('1)   Käytetään SÄTEENÄ äärijohtimen mm² :n perusteella laskettua aritmeettista arvoa r = ' +FONT_2JUURI +
         '(mm²/ ' +FONT_PII +') ja lasketaan ekvivalenttinen ETÄISYYS tunnetun Xv :n perusteella.');
   adStF ('2)   Käytetään ETÄISYYTENÄ a = 2*(aritm. säde + eriste) ja ekviv. SÄDE lasketaan tunnetun Xv :n '+
         'perusteella.');
   adStF ('3)   Lasketaan etäisyys ja säde äärijohtimen poikkipinnan ja eristekerroksen perusteella.');
   adStF ('4)   Käytetään ETÄISYYTENÄ a = 2*(aritm. säde + eriste) ja SÄTEENÄ ekviv. säde r = 3.juuri(r*a²).');
   adStF ('5)   Kokeillaan muilla johdon pääteltävissä olevien parametrien yhdistelmillä.');
   adStF ('TARKISTUS:   '+tab1 +'Lasketaan ''takaisinpäin''. Tulokseksi pitäisi laskentatavan mukaisella etäisyyden '+
          'ja säteen arvolla tulla ko. kaapelin Xv, ero ilmenee sarakkeesta "eroXv".');
   adStF ('<b>>>> Seuraavissa r = johtimen laskentasäde,   r´ = '+FONT_2JUURI +'(mm²/' +FONT_PII +')   laskettuna '+
          'äärijohtimesta,   eroXv = (Xpe/Xv -1)*100 %,   a = PE-johtimen etäisyys:</b>');

 //adStF ('(Alustava laskenta-algoritmi, arvot tarkistamatta)');
   LF;
               {,,M.Paavolan "Sähköjohtojen laskeminen" -kirjan s.128 esimerkki a) :n laskemiseen
                sade := 0.225;   etais := 90;               //<Oltava sama pituusyksikkö, joka saa olla mikä vaan
                Lu := fL1v (etais,sade);
                Xu := fX1v (etais,sade);
                ad1SF ('L=' +fRmrkt0 (Lu,1,4) +'H     X=' +fRmrkt0 (Xu,1,4) +FONT_OMEGA);}
   LaskeArvot ('AMCMK3½',35);
      adStF ('= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =');
   LaskeArvot ('AMCMK3½',70);
      adStF ('= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =');
   LaskeArvot ('AMCMK3½',120);
      adStF ('= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =');
   LaskeArvot ('AMCMK3½',240);
      adStF ('= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =');
      adStF ('= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =');
   LaskeArvot ('AMMK*',35);
      adStF ('= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =');
   LaskeArvot ('AMMK*',70);
      adStF ('= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =');
   LaskeArvot ('AMMK*',120);
      adStF ('= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =');
   LaskeArvot ('AMMK*',240);
end;//LaskeEkvivZpituus

