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

{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NOLA1.INC }
//erOs= 1000 .. = 1001 .. 10xx
FUNCTION ZRXyv (os, Z_ :Integer) :Real;   BEGIN  //< 0=Z   1=R  >1 =X ##########
case Z_ of  0 :result := Sqrt ( Sqr(a_getReaa (1001,Edv.Sorc[os].src.yvRs)) + Sqr(a_getReaa (1002,Edv.Sorc[os].src.yvXs)) );
            1 :result := a_getReaa (1003,Edv.Sorc[os].src.yvRs);
          else result := a_getReaa (1004,Edv.Sorc[os].src.yvXs);  end;
END;
//==================================================================================================
   function edTc (eros,ao,oh :integer) :integer;      var ct :integer;      begin
      ct := 0;
      WITH edv.edka[ao]  DO
      IF onarvot  THEN BEGIN                      //,,,Keskiarvo EIkäytössä, ks. 3:
        {IF ctk>edTa THEN ct := Trunc ((ctk-a_getIntg (1011,lampotila)) /
                                        2 +a_getIntg (1011,lampotila))   //<CTKnTAn«
                     ELSE ct := a_getIntg (1011,lampotila);              //< edTA > }
         CASE oh OF  0: ct := 20;                          //< 20°C =Ik3v
                     1: ct := a_getIntg (eros,lampotila);      //<
                     2: ct := ctk;                         //< Ik1v
                     3: ct := a_getIntg (eros,lampotila);      //<
                   else ct := oh;   END;                   //<Muuten KUTSUN ARVO
      END;  edTc := ct;
   end;//edTc                                                        //>>>
//--------------------------------------------------------------------------------------------------
FUNCTION edRv (lahtien,asti, oh :Integer) :Real;  //PALAUTTAA summaRESv:n   KUTSUJA VAIN:  1,7,8.INC
         VAR i,ct :Integer;  ar8,ur8 :Real;  //OH:  0=20 1=Ta 2=Tk 3=KULSÄL(T annetun muk)''''''''''
BEGIN  ur8 := 0;                             //     muuten KUTSUN T <<<<<<< ''''''''''''''''''''''''
   if asti>edmaxkpl                          //<,+120.5i
      then asti := edmaxkpl;
   FOR i := lahtien TO asti  DO              //<EI VOI SIJ to edjohtoja <<< ''''''''''''''''''''''''
   IF (i>0)  THEN
   WITH edv.edka[i]  DO
   IF onarvot  THEN BEGIN
      ct := edTc (1010,i,oh);
     {ar8 := res (a_getStrg (1011,tyyppi),a_getReaa (1012,Amm2)) * a_getReaa (1013,pituus) / a_getIntg (1014,lukumaara);}
      ar8 := res (edv.edka[i].Tyyppi.arvoStr, edv.edka[i].Amm2.ArvoRea) * edv.edka[i].Pituus.ArvoRea / edv.edka[i].Lukumaara.ArvoInt;
      ur8 := ur8 + rTkorj (fAlCu (a_getStrg (1015,tyyppi)),ar8,ct);
   END;
   result := ur8;
END;//FNC edRv
//--------------------------------------------------------------------------------------------------
FUNCTION edRv0 (lahtien,asti, oh :Integer) :Real;  //PALAUTTAA summaRESvo:n   KUTSUJA VAIN:  1,7,8.INC
         VAR i,ct :Integer;  ar8,ur8 :Real;  //OH:  0=20 1=Ta 2=Tk 3=KULSÄL(T annetun muk)''''''''''''
BEGIN  ur8 := 0;                             //     muuten KUTSUN T <<<<<<< ''''''''''''''''''''''''''
   if asti>edmaxkpl                          //<,+120.5i
      then asti := edmaxkpl;
   FOR i := lahtien TO asti  DO              //<EI VOI SIJ to edjohtoja <<< ''''''''''''''''''''''''
   IF (i>0)  THEN
   WITH edv.edka[i]  DO
   IF onarvot  THEN BEGIN
      ct := edTc (1010,i,oh);
      ar8 := resVo (a_getStrg (1011,tyyppi),a_getReaa (1012,Amm2)) * a_getReaa (1013,pituus) /
                    a_getIntg (1014,lukumaara);
      ur8 := ur8 + rTkorj (fAlCu (a_getStrg (1015,tyyppi)),ar8,ct);
   END;
   result := ur8;
END;//FNC edRvo
//--------------------------------------------------------------------------------------------------
FUNCTION edRn (lahtien,asti, oh :Integer) :Real;  //PALAUTTAA summaRESn:n   KUTSUJA VAIN:  1,7,8.INC
         VAR i,ct :Integer;  ar8,ur8 :Real;  //OH:  0=20 1=Ta 2=Tk 3=KULSÄL(T annetun muk)''''''''''
BEGIN  ur8 := 0;                             //     muuten KUTSUN T <<<<<<< ''''''''''''''''''''''''
   if asti>edmaxkpl                          //<,+120.5i
      then asti := edmaxkpl;
   FOR i := lahtien TO asti  DO              //<EI VOI SIJ to edjohtoja <<< ''''''''''''''''''''''''
   IF (i>0)  THEN
   WITH edv.edka[i]  DO
   IF onarvot  THEN BEGIN
      ct := edTc (1020,i,oh);
      {ar8 := res (edlaji,edlajiMK, mm2_Pj (edlaji,edlajiMK,edmm2)) * edpit / edkplx;}
      ar8 := resP (a_getStrg (1021,tyyppi),a_getReaa (1022,Amm2)) * a_getReaa (1023,pituus) /
                   a_getIntg (1014,lukumaara);
      ur8 := ur8 + rTkorj (fPal (a_getStrg (1025,tyyppi)), ar8,ct);
   END;
   result := ur8;
END;//FNC edRn
//--------------------------------------------------------------------------------------------------
FUNCTION edRp (lahtien,asti, oh :Integer) :Real;  //+130.2e: PALAUTTAA PE-j´n summaRES:n Lääk.Kosketus Uk´n takia.
         VAR i,ct{,Lkm} :Integer;  ar8,ur8 :Real;   //OH:  0=20 1=Ta 2=Tk 3=KULSÄL(T annetun muk)''''''''''#######
             {su,tyyp :string;}  onPE :boolean;     //     muuten KUTSUN T <<<<<<< ''''''''''''''''''''''''#######
BEGIN  ur8 := 0;
         if asti>edmaxkpl
            then asti := edmaxkpl;
         if lahtien<0
            then lahtien := 1;
   FOR i := lahtien TO asti  DO
   WITH edv.edka[i]  DO
   IF onarvot  THEN BEGIN
      ct := edTc (1020,i,oh);
      {ar8 := res (edlaji,edlajiMK, mm2_Pj (edlaji,edlajiMK,edmm2)) * edpit / edkplx;}
      ar8 := resPok (true,tyyppi.arvoStr,Amm2.arvoRea, {VAR}onPE)  //TR=Herjakin jos eioo PEmm².
             * pituus.arvoRea / lukumaara.arvoInt;
      ur8 := ur8 + rTkorj (fPal (tyyppi.arvoStr), ar8,ct);
   END;
   result := ur8;
END;//FNC edRp
//==================================================================================================
   FUNCTION edX (eros :integer;  Xkompon :Char;  lahtien,asti :Integer) :Real;
      VAR i :Integer;  ar8,ur8 :Real;                                       //''PALAUTTAA SUMMA_Xedv
   BEGIN   ur8 := 0;
      if asti>edmaxkpl                          //<,+120.5i
         then asti := edmaxkpl;
      FOR i := lahtien TO asti  DO              //<EI VOI SIJ to edjohtoja <<< ''''''''''''''''''''''''
      IF (i>0)  THEN
      WITH edv.edka[i]  DO
      IF onarvot  THEN BEGIN  ar8 := 0;
         CASE Xkompon OF
            'V' :ar8 := Xv_ind  (a_getStrg (eros  , tyyppi),  a_getReaa (eros+1, Amm2)) *
                                 a_getReaa (eros+2, pituus) / a_getIntg (eros+3, lukumaara);
            '0' :ar8 := Xv0_ind (a_getStrg (eros+4, tyyppi),  a_getReaa (eros+5, Amm2)) *
                                 a_getReaa (eros+6, pituus) / a_getIntg (eros+7, lukumaara);
            'N' :ar8 := Xp_ind  (a_getStrg (eros+8, tyyppi),  a_getReaa (eros+9, Amm2)) *
                                 a_getReaa (eros+10,pituus) / a_getIntg (eros+11,lukumaara);  END;
         ur8 := ur8 + ar8;
      END;
   result := ur8;
   END;//FNC edX
//--------------------------------------------------------------------------------------------------
FUNCTION edXv (lahtien,asti :Integer)  :Real;         //<PALAUTTAA SUMMA_Xv:n
   BEGIN  edXv :=  edX (1030,'V',lahtien,asti);  END;
//--------------------------------------------------------------------------------------------------
FUNCTION edXv0 (lahtien,asti :Integer)  :Real;        //PALAUTTAA SUMMA_Xv0:n
   BEGIN  edXv0 := edX (1050,'0',lahtien,asti);  END;
//--------------------------------------------------------------------------------------------------
FUNCTION edXn (lahtien,asti :Integer)  :Real;          //PALAUTTAA SUMMA_Xn:n
   BEGIN  edXn :=  edX (1060,'N',lahtien,asti);  END;
//==================================================================================================
//==================================================================================================
//,,Väliaikaisessti fJKno_, vain koekäytössä ollessaan. Tätä EI KUTSUTA MUUALTA SUORAAN KUIN: fJKnoEiOk, fJKno :sta
         //,,Tällä muutetaan FNC ZpeOK :n paluuVARstr arvoNO kokonaisluvuksi :ksi,,,,,,,,,,,,,,,,,,,Pelkist. 4.0.0
      function fJKno_ (no :integer;  str :string) :integer;      VAR ohiNo :integer;   su :string;      BEGIN
         ohiNo := 0;   su := '';
         while (no>0)  and (str<>'')  and (ohiNo<no)  do begin
            while (str<>'')  and  NOT (CharInSet(str[1], ['0'..'9']))  do     //<Pyyhitään alkutyhjät ja -muut mrkt
                  Delete (str,1,1);
            su := '';
            while (Length (str)>0)  and (CharInSet(str[1], ['0'..'9']))  do begin       //<Siirretään NoLuku SU´hun
                  su := su +str[1];   Delete (str,1,1);  end;
            if su<>''  then ohiNo := ohiNo +1;
         end;//while (str<>'')..

         if (no>0)  and (ohiNo=no)  and (su<>'')
            then result := StrToInt (su)
            else result := 0;
      END;
         //,,Tutkii, mikä KesNO EI OLE mukana OKSTR :ssa ja palauttaa ne str:nä, esim. OKstr = '2,4,5' => '1,3'.
function fJKnoEiOK (OKstr :string) :string;                                                         //< +4.0.0
      VAR sArr :ARRAY [1..kesmax] of string;  vikaJK,u,no :integer;   su :string;      BEGIN

   vikaJK := a_getIntg (1083,nj.jy.Ketjussa);
// vikaJK := 7;
   for u := 1 to vikaJK  do
       sArr [u] := IntToStr (u);               //<Ao. JK:n järj.no strnä, pyyhkiytyy vex, jos on mukana OKstr :ssä
   for u := 1 to vikaJK  do begin
       no := fJKno_ (u,OKstr);                 //< NO = alkio nro U int´nä, esim. str:n alkio nro 1 '3,4,5,' = '3'
       if no>0  then sArr [no] := '';          //<Pyyhitään äsken alustettu JKno vex, koska sen Zpe olikin OK
    end;
    su := '';
    for u := 1 to vikaJK  do begin
        no := Length (su);                     //<no tässä strLengthinä
        if (su<>'')  and (sArr [u]<>'')  and (su[no]<>',')
           then su := su +',';
        su := su +sArr [u];
    end;
    result := su;
end;
function fJKno (no :integer;  str :string) :integer;      BEGIN
 //fJKno_ (1, '  1,2,3');  fJKno_ (2, '  1,2,3');  fJKno_ (3, '  1,2,3');  fJKno_ (4, '  1,2,3');  fJKno_ (5, '  1,2,3,');
 //su := fJKnoEiOK ('2,4,5');
   result := fJKno_ (no,str);
END;
{oo=1=========!=2=========!=3=========!=4=========!-Nj- -!1- - -!2- - -!3- - -!4   10.INC/laskeRJpit
           - jalessaNrot = Zpe-ehto täyttyy VAIN verkossa JÄLEMPNÄ KesNo:ssa olevIIN PT:hen laskien.
       ¹)    - PALUUARVO str, jossa N:ot STR:nä kukin N:o erotettuna ',' :lla, EDV:lle VAIN 1 luku.
             - Edv :n JALESSANrot voi olla VAIN yksi luku, koska FNC kutsutaan osoitteittain. ######
               EdVrkn jälempää vrkoa eiVoida tutkia NJn puolelleAsti muutenKuin NJ:n kutsusta käsin.
       ¹)  - OkNrot = NJ:n ZpeOK keskusN:ot STR:nä kukin N:o erotettuna ',' :lla, EDV:lle VAIN 1 luku.
           + Jos QJtyp<>'', ollaan lisäämässä resurssiNJtä edv[os]:n haaraksi TAI NJkin :n jälkeen.
           + QJ:n luokse ei oleteta PTtä: Jos sielä olisi, ei tarttis edes laskea = Zpe=OK #########

       ¹) = Str:n JALESSANrot ja OkNrot purku,
                  EDV:  i := fJKno (1,jalessaNrot);   if i>0  then PTnoJäljessäOKno := i;
                  NJ:   o := 0;  i := 0;
                        while i>0  do begin  o := o+1;  i := fJKno (o,OkNrot);
                              if i>0  then write ('Zpe-ehto täyttyy JK n:oissa ', i:1);
       ,,FNCn IDEA: Tutkitaan EKAX os :sta alkuunpäin. Jos NJkin, tutkitaan silmukassa JKno 1..Kes-
                    Lkm :sta alkuunpäin. Jos alkupäästä ei löydy, tutkitaan loppuunpäin.
                  - Jos löytyy ALKUUNpäin,  FNC:=TR + merkataan osoite OkNrot      var-paluuStrgiin
                  - Jos löytyy LOPPUUNpäin, FNC:=TR + merkataan osoite JALESSANrot var-paluuStrgiin.
                  - Jos NJkin ja ketjussa jokin Zpe=OK -> FNC := TR, EiOK:t fJKnoEiOK :lla
       ,,TUTKIMINEN: Ks. FNC chkZpe:  LASKETAAN Zs johdon loppuun ja LASKETAAN Zpe JK:sta edv:n    <,+9.0.1
                     EDELLISEEN (tai SEURAAVAAN) PT:hen.
       `````````````````````````````````````````````````````````````````````````````````````````````}
                                                     //Jos ,,,,,QJtyp='', ei perään LISÄTÄ QJ´tä.....
function ZpeOK (os :Integer;  PEk :real;  NJkin :Boolean;  QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer;
                VAR OkNrot,jalessaNrot :string;  VAR RJmax_pit :real{+9.0.1}) :Boolean;
                //,,Tässä tarkastetaan Zpe -ehto.######################################################################
                //Muutos 9.0.1:- Lasketaan RJmax_pit, mikä ilmaisee maxPit, jolla Zpe -ehto toteutuu.
                //             - Zs laskettiin maxZ -kohtaan (ohj=12), nyt loppuun (ohj=11). Zs laskettiin vain
                //               Nj:n tai Rj:n alkuun, ei loppuun, nyt loppuun eli nyt Rj:kin huomioidaan.
      LABEL 2,8;
      VAR i,j,k,o,n,edja,vnj :Integer;   eRn,eXn :real;   {f :TextFile;   }strJalesNrot,strOkNrot,fn :string;
          tyyp :string;   mm2,pit,totPit :real;   kpl,clt :Integer;      Pt1,Pt2,kulNJ, fncPE{130.2e}  :Boolean;  //LstA :TStringList;

 (*procedure  wre(sA :string);     begin end; (*VAR sE,sB,sX,sU,S_ :string;  o,tab,krt :integer;      //Erinomainen. +130.2e

      function StoK {(os :integer)} :string;      VAR S :string;  u :integer;      begin
         s := '';  for u := 1 to k  do            //<k
                      S := S +sA[u];
         result := S;  end;

   begin//wre...............................
      fn := gAjoPath +'_EdvNewLsk chkPE.txt';      //C:\Projektit XE2\NolaKehi\BIN\..
      AssignFile(f,fn);
      if fFileExists (fn)
         then Append(f)
         else Rewrite(f);
      sB := 'jOsa:' +Ints(os) +'  ';
      S_ := '';  sE := sA;                                  //<Alkuperäinen sA talteen.
//Writeln(f,'');                                            //<Tyhjä välirivi alkuun.
//Writeln(f,'sE= ' +sE);                                    //<'Hyvät kehiVaiheessa, näkyy TAB-mrkt.
      krt := 0;
      if sA=''
      then writeln(f,sB)                                    //<Vain tyhjä rv esim. eri j-osien laskennan väleihin.
      else if Pos('|',sA) =0
      then writeln(f,sA)
      else begin
            k := 1;
            while (k<Length(sA))  do begin  {while 1.}
               krt := krt+1;
               while (k<Length(sA)) and (sA[k]<>'|')  do    //<,Luetaan |-mrkiin asti.   Pos('| ',sA) <20
                  k := k+1;
               if(sA[k]='|')  then begin
                  Delete(sA,k,1);                           //<Delataan "|", K säilyy.
                  S_ := StoK;
                  sX := '';
                  while (k<Length(sA)) and (sA[k]<>'|') and (sA[k] IN ['0'..'9'])  do begin //<Luetaan "|"n jälkeen oleva TAB -integ.arvo.
                     sX := sX +sA[k];
                     Delete(sA,k,1);  end;                  //<Delataan, k-osoite säilyyDelauksessa
                  SokI(sX,tab);
                  k := k+1;
                  S_ := StoK;
                  sU := '';
                  while (k<Length(sA)) and (sA[k]<>'|')  do begin //Ohjataan k seuraavaan TAB-mrkiin |.
                     sU := sU +sA[k];
                     k := k+1;  end;
                  S_ := StoK;
                  sX := '';
                  if(sA[k]='|')  then begin                 //<Testiäkään ei tarttis.
                     for o := Length(sU) to tab  do //begin //"|" säilytetään seur.kierrokselle.
                        sX := sX +' '{'^'};
                  end;
                  S_ := StoK;
                  Insert(sX,sA,k);
                  if sA='!"#¤'  then ;                      //<''''Jos | ilman nroita, se delautuu ja loput sA´sta jää, OK.
//Writeln(f,sA +' krt=' +Ints(krt)); //<Hyvä kehiVaiheessa: Jokaisen tietoerän (|...| -välisen erän jälkeen LOPPURIVIKIN tulostetaan näkyviin fileeseen.
               end;//if sA[k-
            end;//while
Writeln(f,DateTimeToStr(Now) +'  ' +sB +sA);
         end;
      Flush(f);
      Close(f);
   end;//*)

 (*procedure Kirjoita;      VAR arr :array of integer;  i,k,o,n,max,x,ohj,ari :integer;  sA,sU,sX :string;      begin
      ari := 0;             V I E   K A U H E A N   K A U A N   A I K A A.<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      ohj := 1;                                          //<TR =ekax tutkitaan palstaleveydet.
      while (ohj<=2)  do begin
      for i := 0 to LstA.Count-1  do begin               //<,,Tarkoittaa että myös filestäluettu käsitellään alusta asti uudelleen
         sA := LstA.Strings[i];
         o := Pos('|',sA);
         if o>0  then begin
            sU := Copy(sA,1,o-1);                        //<"|" poislukien (o-1)
            k := o+1;                                    //< -mrkn jälkeen
            while (k<Length(sA))  do begin  {while 1.}
               sU := '';
               while (k<Length(sA)) and (sA[k]<>'|')  do begin //Lasketaan txt-kentän pituus ja tutkit onko isompi => max, 1.krlla merkataan ARRayhun
                  sU := sU +sA[k];                             // max´it kullekin "|..|"-välille ja 2.krlla säädetään kukinväli samoiksi ARRayn mukaan.
                  k := k+1;
               end;
               sX := '';
               if ohj=2  then begin                            //2.krlla yhdenmukaistetaan palstat.
                  for x := Length(sU) to arr[ari]  do
                     sX := sX +' ';
                  Insert(sX,sA,k);
               end
               else begin                                      //1.krlla tutkitaan palstaleveydet
                  if (k<Length(sA)) and (sA[k]='|')
                     then k := k+1;
                  n := Length(arr);
                  x := Length(sU);
                  SetLength(arr,n+1);
                  if x>max  then
                     arr[n] := x;
               end;
            end;//while(1.)
         end;//if o>0
      end;//for i
        ohj := ohj+1;
      end;//while ohj<=2
//   end;//Kirjoita*)

   function chkZpe :boolean;      VAR Zpe,Zs,ar,az,rU :real;   fnc :boolean;
                                      {+9.0.1: }Zs_ev,aZs_rj{, Qmm2,Qpit} :real;  //Qtyp :string;  Qkpl,Qlampot :integer;

      function mrkt (P :boolean) :string;      VAR s :string;      begin//+9.0.1: Vain koe-editointiin.,,,,,,,,,,,
         case Trunc(QJmm2) of 2 :s := ' 2.5mm²';
                              1 :s := ' 1.5mm²';
                            else s := '       ';  end;
         if P  then s := CLR_REB +'P' +FNT_B0 +s
               else s :=          '-'         +s;
         result := s;  end;
      function PitClr (L1,L2 :real) :string;      VAR s :string;      begin//+9.0.1: Vain koe-editointiin.,,,,,,,,
         s := '<b>' +fRmrkt0 (L1,6,1) +'</b> ' +FONT_OIKEALLE;
         if L2<L1
         then if L2<0  then s := s +         fRmrkt0 (L2,6,1)
                       else s := s +CLR_REB +fRmrkt0 (L2,6,1) +FNT_B0
         else               s := s +CLR_BLB +fRmrkt0 (L2,6,1) +FNT_B0;
         result := s;  end;

   begin//chkZpe,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//,,##################################################
      fnc := FALSE;                  //,,130.2e:  Pitäisi käyttää Pn fnc´tä, mutta sehän antaa samat arvot kuin Rn.
      Zpe := Sqrt (Sqr(eRn) + Sqr(eXn));                    //<Laskettu kumalatiivisesti PRC KasvaZpe :ssä.
          if (edv.edka[os].tyyppi.ArvoStr<>'') or (edv.edka[os].Amm2.ArvoRea>0)  then ; //<130.2e: Debuggiin.
      Zs := fZs (11,os,PEk,NJkin, QJtyp,QJmm2,QJpit,QJkpl,QJlampot, ar,ar,ar,ar);    //<ohj= 12=>11  9.0.1
      rU := fUo;                                            //Ehto:  Zpe <= 50*Zs / Uo           ,TarkistOK 10.0.4
      az := Zs / rU;                                        //       Zpe <= [50*(Zs_ev +aZs_rj*RJpit)] / Uo .
      ar := 50*az;                                          //       RJpit <= (Zpe*Uo -50*Zs_ev) / (50*aZs_rj) .
      IF Zpe <= ar  THEN fnc := TRUE;                       //      =RJmax_pit := ((Zpe*Uo/50) -Zs_ev) / aZs_rj .
      Result := fnc;                                        //''FNC Ziks lisää QJ:n =fZs kutsuu FNC Ziks.
                                                            //''##################################################
   //+9.0.1:,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,RJpe_pit := tässä PRC:ssa koska Zpe jo tässä PRC:ssa.
              {Qmm2 := Qmm2;         if Qmm2=0  then Qmm2 := edv.edka[os].Amm2.arvoRea;
               Qpit := QJpit;        if Qpit=0  then Qpit := edv.edka[os].Pituus.arvoRea;
               Qtyp := QJtyp;        if Qtyp='' then Qtyp := edv.edka[os].Tyyppi.arvoStr;
               Qkpl := QJkpl;        if Qkpl=0  then Qkpl := edv.edka[os].Lukumaara.arvoInt;
               Qlampot := QJlampot;  if Qlampot=0;  if Qlampot=0  then Qlampot := edv.edka[os].Lampotila.arvoInt;}
   RJmax_pit := QJpit;                                              //,KUL-ehto vaikka tänne ei tulla SÄL -johdoilla.
   if (os>0)  and edv.edka[os].Kuluttaja.ArvoBoo  then              //,QJmm2<4=-10.0.4  Jotta laskisi NJ:llekin.
   if (QJtyp<>'') {and (QJmm2<4)}  then begin //,,,Lasketaan maxZpe pituus jolla Zpe-ehto vielä täyttyy.,,########
      Zs_ev := fZs (11,os,PEk,NJkin, '',0,0,0,0, ar,ar,ar,ar);      //<Zs_ev  =Zs ilman Rj:tä.  11= Edj:n loppuun.
      aZs_rj := fZj (QJtyp,QJmm2,1{QJpit},1{QJkpl},QJlampot);       //<aZs_rj =JOHDON QJtyp.. QJpit imped Zekv.
      RJmax_pit := ((Zpe*rU/50) -Zs_ev) / aZs_rj;                   //<aZs_rj=RJ:n Zs per 1m. RJmax_pit =Lzpe edellä.
    //,,Editointi DetEvFrm.aRich :ille,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
         (* if IsDebuggerPresent {and EdvNewFrm.Visible  and} then begin //<Yhtälölle: Ik1v = c*Uv/Ze.=== HYVÄ ===
               DetEvFrm.aRich.AddText ('<f n="Courier New">'       +'Os=' +IntS (os) +'  tuPx= ' +mrkt (fnc) +
                  '  RJalp_pit ' +FONT_OIKEALLE +' RJzs_maxPit=' +PitClr (QJpit,RJmax_pit) +
                  '  Zs= '              +fRmrkt0 (Zs,1,4)          +'  Zs_rj= '      +fRmrkt0 (aZs_rj*QJpit,6,4) +
                  '  Zs_ev_rj -Zs_rj= ' +fRmrkt0 (Zs - aZs_rj*QJpit,6,4) +'<br>');
                  DetEvFrm.Show;  end;//*)
   end;//if QJTyp                                       //,Alkuosa ehdosta -10.0.4  ,RJmax_pit<0 JOS Zpe*rU/50 < Zs_ev
   if {((RJmax_pit>QJpit) and (RJmax_pit>0))  OR}       //<RJmax_pit := QJpit jos RJmax_pit "löysempi" kuin f(Tim)
      (RJmax_pit<0)                                     // eli QJpit < RJmax_pit TAI RJmax_pit on negatiivinen.
      then RJmax_pit := QJpit;                          //'Alkusijoitus hoiti jos tässä ei korjausta.
   END;

  procedure kasvaZpe(oo :integer;  so :string);      VAR {Apit,ATot,}Rn :real;  sa :string;      begin
     //ATot := totPit;  Apit := pit;
     totPit := totPit +pit;                        //<TotPit:  9.0.1 nyt ynnäytyy myös RJ. ??????????
     Rn :=  resP (tyyp,mm2) * pit / kpl;
     eRn := eRn + rTkorj (fPal (tyyp), Rn, clt);   //<,Summataan aikaisempiin/edellisiin.
     eXn := eXn + Xp_ind  (tyyp,mm2) * pit / kpl;
     if oo=3  then sa := '3 '                      //<Yleisin käsittelyosa on 3.
              else sa := ' ' +Ints(oo);            //<Jos <>3 => aloitus1mrk oikeammalle.
    {wre(sa +so +':|12 Tyyp=' +tyyp +'|8 mm²=' +fRmrkt0(mm2,1,0) +'|10 Apit=' +fRmrkt0(ATot,1,1) +'|12 +pit ' +fRmrkt0(Apit,1,1) +'|9 =' +
         fRmrkt0(totPit,1,1) +'|10 Rpe=' +fRmrkt0(eRn,1,4) +'|10 Xpe=' +fRmrkt0(eXn,1,4));// +'| OKt: ' +strOkNrot +' JalOkNrot: ' +strJalesNrot);}
  end;//'+130.2e '' "|"=tulostussarkainAlkamis/PäättymisMrk.                                   'Pelkkä | =Loput sellaisenaan.

     procedure lisaaQJ;       begin //Ei käytetty ..130.2e
        if QJtyp<>''  then begin    //<Vain optimointia
           tyyp := QJtyp;   mm2 := QJmm2;   pit := QJpit;   kpl := QJkpl;   clt := QJlampot;
           kasvaZpe(0,'qj');
     end;  END;
     procedure lisaaEdj (os,o :integer);      begin
           tyyp := edv.edka[o].tyyppi.ArvoStr;     mm2 := edv.edka[o].Amm2.ArvoRea;
           pit :=  edv.edka[o].pituus.ArvoRea;     kpl := edv.edka[o].lukumaara.ArvoInt;
           clt :=  edv.edka[o].lampotila.ArvoInt;
        kasvaZpe(os,'EJ');
     END;
     procedure lisaaNj (o :integer);      begin
        tyyp := NJtyp;   mm2 := NJmm2;   pit := a_getReaa (1076,nj.jk[o].dL); //< dL=Pituus EDELL.:stä
        kpl := NJkaapx;  clt := a_getIntg (1077,nj.jy.Tk1v);
        kasvaZpe(0,'nj');
     END;

  function fBmrkt (bo :boolean) :string;    begin  if bo  then result := 'TR'  else result := ' fa '; end;//11.0.1
  procedure kasvaOkNrot  (o :integer);      VAR p :string;      begin
                         p := '';        if strOkNrot<>''  then p := ',';    //<JosJoMrkjä ->","erotin
                         strOkNrot :=    strOkNrot    +p +fImrkt0 (o,1);   Pt1 := true;   END;
  procedure kasvaJalNrot (o :integer);      VAR p :string;      begin
                         p := '';        if strJalesNrot<>''  then p := ','; //<JosJoMrkjä ->","erotin
                         strJalesNrot := strJalesNrot +p +fImrkt0 (o,1);   Pt2 := true;   END;

BEGIN//ZpeOK........................................................................................
   //LstA := TStringList.Create;;
 //wre('');                                                //<Välirivi +130.2e
                                                           //Varm.vuoksi'', jotta jälemmät testit OK:  IF QJtyp=''
   if fEmtyS (QJtyp) or (QJmm2=0) or (QJpit=0) or (QJkpl=0)  then QJtyp := '';
   edja := a_getIntg (1081,edv.YLE.JohtoOsia);
 //IF (os>edja) or NJkin  THEN os := edja;                 //<Korj koska Nj:sta kutsu edmaxkpl tms. -3.0.3
   IF os>edja  THEN os := edja;                            //<Varm.vuoksi. Nj:sta kutsu edNo !!!!!! +3.0.3

   kulNJ := a_getBool (1082,nj.jy.NjKulSal);
   Pt1 := FALSE;  Pt2 := FALSE;   strJalesNrot := '';   strOkNrot := '';
 //if isDebuggerPresent  then Wbeep([200,100, 0,100{, 1000,50}]);
{                                      Lopussa..PT
oo=0=========!=1=========!=2=========!=3=========!-Nj- -!1- - -!2- - -!3- - -!4  (10.INC/laskeRJpit)
Tutkit. Nj ALKUUNpäin         <............(1)..........^..........(2)......>! +QJ
                            NJstä tutkitaan kaikki JKt YHDELLÄ KUTSULLA.############################
                            Tutkitaan 1.) Alkuunpäin, jos EiOkPT1 -> 2.) tutkitaan loppuunpäin.
                            Jos SÄL = PE-johdinta eioo, ei Zpe-ehto täyty kuin ao:n KOHDALLA (jos
                            siinä on PT). Jos KUL, tutkitaan 1.JKsta alkuunpäin, seur. 2.JKsta jne.
                            Jos ei ZpeOK, tutkit. SAMANTIEN loppuunpäin, koska vain näin tiedetään
                            onkoOK kumpaankaan suuntaan.
                               Jos OK ALKUUNPÄIN,  merkataan tiedoksi VAR-paluustringiin OkNrot.
                               Jos OK loppuunpäin, merkataan tiedoksi VAR-paluustringiin JALESSANrot.
                            LISAA.. sijoittaa Tyyp,mm2 jne. ja niistä kasvatetaan eRn,eXn seur. chkZpe
                            kutsua varten.}
totPit := 0;                //<TotPit pitää nollata, jos suoraan 2: een.  EI VAIKUTA TARKASTELUUN.  +6.1.1
IF NOT NJkin  THEN GOTO 2; //<HYPÄTÄÄN suoraan EDV:koon ############################################
IF NJkin  THEN BEGIN       //<Turha ehto, OK: Jos joskus muuttuu koodi, ehto näkyy <<<<<<<<<<<<<<<<<
   vnj :=  a_getIntg (1083,nj.jy.Ketjussa);
   IF kulNJ
   THEN BEGIN
      for i := 1 to vnj  do BEGIN                 //< i=Tutkittavan JKn n:o ########################
         eRn := 0;  eXn := 0;  totPit := 0;       //,,Vex koska Zpe lasketaan VAIN pää- ja Nj-johdoissa =JK:hon
       //if i=vnj  then lisaaQJ; //<++++++++++++++//                                  asti, ei RJ.  -9.0.1
         for j := i DOWNTO 1  do BEGIN            //<TUTKITAAN kukin JK (j) ########################
            if a_getBool (1084,nj.jk[j].PTlop)                           //<PT ao.JKssa. 4.0.0  j-1 => j #########
            THEN BEGIN
               if chkZpe  then kasvaOkNrot (i);   //<=====1======//<HUOM: (i) OKtieto paluustringiin
               Break;  END                        //<BREAK AINA, kun PT löytyy #####################
            ELSE lisaaNj (j);      //<++++++++++++//<Kasvatetaan Zpe -arvoja #######################
{EDV,,,,============================================================================================}
            if j=1  then  //,,##### JosEiVieläLöytynyt (EiBreak), jatketaan Edv ALKUUNpäin #########
            for k := edja DOWNTO 1  DO BEGIN
               if a_getBool (1085,edv.edka[k].PTlopussa)
               THEN BEGIN
                  if chkZpe  then kasvaOkNrot (i); //<=====1======//<HUOM:(i) OKtieto paluustringiin
                  Break;  END
               ELSE BEGIN
                  lisaaEdj (1,k);     //<++++++++++++//,[1] ilmaisi vain PTn lopussa, sen etupuolella
                  if k=1 THEN BEGIN                //<voi olla vain PK:ssa PT.######################
                     //=============================================================================,,+6.2.2
                     for n := a_getIntg (10086,edv.YLE.SorceCount) DOWNTO 1  do //<for turha, src[1] riittäisi.
                     if a_getBool (1087,edv.Sorc[n].josa.PTlopussa)
                     THEN BEGIN
                        if chkZpe  then kasvaOkNrot (0); //<=====?======//<HUOM:(0) OKtieto paluustringiin
                        Break;  END                                     //       0 = PK:ssa
                     ELSE if n=1
                     THEN BEGIN                                         //<'''''''''''''''''''''''''''+6.2.2
                     // lisaaEdj (k);     //<++++++++++++
                        eRn := 0;  eXn := 0;          //<,Tutkitaan PTt NJ JK[i]stä loppuunpäin #######
                        totPit := 0;
                        for o := i+1 TO vnj  DO BEGIN //< i -> i+1 = +4.0.0  Seur.keskuksen etäis=1x dL
                           lisaaNj (o);  //<+++++++++++
                           if a_getBool (1088,nj.jk[o].PTlop)  then BEGIN
                              if chkZpe  then begin
                                 kasvaJalNrot (o);           //<=====2=====//<HUOM:(o)OKtietoStrgiin. 4.0.0  i -> o
                                 kasvaOkNrot (i);  end;      //<' +4.0.0  [i]Zpe=OK [o]:n ansiosta!!!!!
                              Break;  END;                   //<BREAK, PT on, kauempana ei ainak.paree!
                        END;//for n
                     END;//else if n=1 then
                  END;//if k=1
               END;//else
            END;//for k
         END;//for j
      END; END//for i, IF kulNJ
   ELSE  if NOT a_getBool (1089,nj.jk[vnj].PTlop)                        //<PT ao.JKssa. 4.0.0  vnj-1 => vnj #####
   THEN BEGIN                                 //<'SÄLnj =Vain mahd. vikan JK:n + QJ:n PT1 OK =TUTKIT.
      eRn := 0;  eXn := 0;  totPit := 0;      //<+130.2e:  +tot..
    //lisaaQJ; //<+++++++++++ <Vex koska Zpe lasketaan VAIN pää- ja Nj-johdoissa =JK:hon asti, ei RJ. -9.0.1
      if chkZpe  then kasvaOkNrot (vnj);      //<=====1======//<HUOM: (vnj) OKtieto paluustringiin
   END;
GOTO 8;          //<######################### LOPPUOSA OHITETAAN ###################################
END;//if NJkin   //#################################################################################
                 //#################################################################################
2:               //<Tähän hyppy suoraan, jos EiNJ ##################################################
                 //#################################################################################
                 //#################################################################################
{=================== Tutkit. Edv ALKUUNpäin o=====================================================================
                     Tutkitaan silmukassa ja lasketaan samalla KUMULATIIVIsesti Zpe,
                     esim. jos os=3 ja edell. PT on 2:n lopussa, lasketaan edka[3]: }
eRn := 0;  eXn := 0;  totPit := 0{+130.2e};
//lisaaQJ; //<+++++++++++++  <Vex koska Zpe lasketaan VAIN pää- ja Nj-johdoissa =JK:hon asti, ei RJ.-9.0.1
if os>0  then                                       //<Ei Sorc´ella (vaikka DownTo kyllä estäisi)   +6.2.2
for i := os DOWNTO 1  DO
   if edv.edka[i].PTlopussa.arvoBoo                 //<Löytyi PT====================================
   THEN BEGIN                             //,Nyt VASTA tutkitaan OHITETUT PITUUDET #################
      if chkZpe                           //,#######################################################
         then kasvaOkNrot (i);            //<=====1======//<HUOM: (i) OKtieto paluustringiin #######
       //else Wbeep([0,5]);               //<130.2e:  ... dewbuggerille breakpntKohta ([0,5] Hz=0 =Ei ääntä.
      Break;  END
   ELSE BEGIN                             //,Parametrit FNC chkZpe varten, TUTKIT... ks.ed.THEN ####
      lisaaEdj (2,i);  //<+++++++++++++                            //,EiOhi SÄL:nJohdn.
    //if NOT edv.edka[i].kuluttaja.arvoBoo  THEN Break;            //<Nyt vex: PE on vain välillä PEN´issä -11.0.1
   END;
//for n := edv.YLE.SorceCount.arvoInt  DOWNTO 1  do                              //<,,,,,,,,,,,,,,,,+6.2.2 -11.0.1
if (os<0) and edv.Sorc[1].josa.PTlopussa.arvoBoo  THEN begin  //<'Vaikka SyoArvOK:ssa sijoitettu sama PTlop kaikkiin.
//if chkZpe  then                   //<=====?======//<HUOM:(0) OKtieto paluustringiin            //<'-+130.2e.
   Pt1 := true;                                                                                  //<+130.2e: TR.
   kasvaOkNrot (0);  end;                          //       0 = PK:ssa           //<''''''''''''''''+6.2.2
           {DetEvFrm.aRich.AddText ('os=' +IntToStr (os) +'<br>   1  Tot=' +fRmrkt0 (TotPit,1,1) +'  Pt1=' +fBmrkt (Pt1) +
            ' mm2=' +fRmrkt0(QJmm2,1,0) +' L=' +fRmrkt0(QJpit,1,1) +'  OKt: '+OkNrot +' Jälj: ' +strJalesNrot +'<br>');//}

{=================== Tutkit. LOPPUUNpäin o========================================================================
                     ,,NJei voida tutkia edv:sta: Ei vielä laskettu.}
                         //,,,,,,,,,-11.0.1 ei vaikuta.     //,NOT Pt1-ehdonVoisPoistaa: TutkittaisMYÖSjälem.
if NOT Pt1 and (os<edja) //and (os>0) //=Ei NJkin: edja=os  //,Etsitään LÄHIN SEURAAVA PotTas. Lasketaan sa-            os>=edja-1
THEN BEGIN                          //'nytEi muutenkaan NJ  //<malla KUMULAT:sti Zpe, esim. jos os=3 ja ed.
 //if isDebuggerPresent  then Wbeep([500,50, 0,50, 3000,50]);
   eRn := 0;  eXn := 0;                                     //'PT on 4:n lopussa, lasketaan edka[4]:n Zpe
   totPit := 0;                              //<AlkuunpLaskien saatu TotPit pitää nollata, TODETTU. +6.1.1
 //lisaaQJ; //<+++++++++++++ <Vex koska Zpe lasketaan VAIN pää- jaNj-johdoissa =JK:hon asti, ei RJ. -9.0.1
     i := os;                                               //<,Jos OS on liittymäjohtoja (<0), aloitetaankin
     if os<0  then i := 1;                                  //  niiden jälkeen: 1..edja. < If os<0..=11.0.1
   for i := i TO edja  DO BEGIN                             //<Vois tutkia edv.NjL.PT muttEioo laskettuVielä
      if NOT edv.edka[i].kuluttaja.arvoBoo                  //<EiOhi SÄL:nJohdn.           Ehto vex -11.0.1  +130.2e: Nyt takas (oli vex).
      THEN Break                                            //<'PE on vain välillä PEN´issä.        -11.0.1
      ELSE BEGIN
         lisaaEdj (3,i); //<+++++++++++++                   //<Parametrit FNC chkZpe varten <<<<<<<<
         IF edv.edka[i].PTlopussa.arvoBoo  then BEGIN       //<Löytyi PT.
            if chkZpe
               then begin
                    kasvaJalNrot(i);  //<Siellä Pt2 := TR   =====2======//<HUOM: (i) OKtieto paluustringiin #######
                  //if isDebuggerPresent  then Wbeep([500,50, 0,100, 3000,50, 0,100, 5000,50]);
                    end
               else Wbeep([0,5]);                      //<130.2e:  ... dewbuggerille BreakpntKohta ([0,5] Hz=0 =Ei ääntä.
            Break;  END;                            //'#######################################################
         if (strOkNrot +strJalesNrot ='!"#¤%&') and (totPit>0)  then ;
      END;//else
   END;//for
END;       {DetEvFrm.aRich.AddText ('   2  Tot=' +fRmrkt0 (TotPit,1,1) +'  Pt2=' +fBmrkt (Pt2) +' mm2=' +fRmrkt0(QJmm2,1,0) +
            ' L=' +fRmrkt0(QJpit,1,1) +'  OKt: '+OkNrot +' Jälj: ' +strJalesNrot +'<br>');  DetEvFrm.Show;}
8: OkNrot := strOkNrot;
   jalessaNrot := strJalesNrot;
   //fncPE := (OkNrot<>'') or (jalessaNrot<>'');       //<Olisi näinkin OK.
   fncPE := Pt1 or Pt2;                                //<TRUE, jos jompi kumpi TRUE
   result := fncPE;
   fn := DateTimeToStr(Now);
   if (OkNrot<>'') or (jalessaNrot<>'')  then fn := fn +'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>';
   fn := fn +'  OkNrot: ' +OkNrot +'  jalessaNrot: ' +jalessaNrot;
//wre(fn +'  FNC=' +fBmrkt0(fncPE,2));
              (*if IsDebuggerPresent  then begin                                                       //<,,+8.0.8
               //if (EdvNewFrm.KuvausEdit.Text<>'') and (EdvNewFrm.KuvausEdit.Text[1]<>'@')  then
                {if os=-1  then                             //<Ei tyhjennetä kokonaan kuin vain ekalla j-osalla.
                    EdvNewFrm.KuvausEdit.Text := '';        //'Ei koskaan <0  -9.0.1
                 if (OkNrot<>'') or (jalessaNrot<>'')  then
                    EdvNewFrm.KuvausEdit.Text := EdvNewFrm.KuvausEdit.Text +'@ Os=' +IntToStr(os) +
                                                 ' okNr='+OkNrot + ' jälNr=' +jalessaNrot +Chr(10); //-----------}
                 DetEvFrm.aRich.AddText ('Os=' +IntToStr(os) +' okNr='+OkNrot + '   jälNr=' +jalessaNrot +'<br>');
                 DetEvFrm.Show;
              end;//*)
   {Kirjoita;
   LstA.SaveToFile(fn);
   LstA.Free;}
END;//ZpeOK
//==================================================================================================
FUNCTION iks (maxI :Boolean;  os :integer;  Zik :Real) :Real; //< maxI=Ik3v
      VAR Kind,i :integer;  ikLa,ikLi :Real;  sa :string;
                                   //'OS tarpeen SRC-haaran laskennassa +6.2.5., ei väliä vaikka OS=edmaxkpl tms.
   function fIk3v :real;      VAR Uv,ar :real;      begin
      Uv := fUv;
      ar := Uv / Zik;          //< Ik3v = Uv/Zk
      result := ar;  end;
   function fIk1v :real;      VAR kU,Uv,ar :real;   begin
      kU := a_getReaa (1110,edv.YLE.cU);
      Uv := fUv;
      ar := kU *3 *Uv / Zik;   //< Ik1v = c 3 Uv/Zk
      result := ar;  end;

begin//iks,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

IF Zik <= 0       //',,,"Floating point divided by zero" ilmoituksen takia,,,,,,,,,,,,,,,,,,,,,,,,,,+6.2.4,,,,,,,
then begin        //<'Mahdollista vain UPSilla heti liittymässä ilman johtoa.#######################+6.2.7uusiksi
 //if (os<0) and (edv.Sorc[Abs(os)].src.SorceKind.arvoInt=4){UPS} //<1=Transformer  2=LV-Cable  3=Generator 4=UPS
 //##############################################################################################################
 //########################## OS voi olla myös >0, jos L=0 m, minkä takia täytyy asia   #########################
 //########################## TUTKIA JA ETSIÄ ikLi>0 arvo ja Zik voi olla 0 vain UPS´illa.########################
 //##############################################################################################################
   ikLa := 0;
   for i := 1 to edv.YLE.SorceCount.arvoInt  do begin         //,,Annetut UPSin liittymäIk:t JÄÄVÄT LOPPUARVOIKSI.
      if MaxI then ikLa := edv.Sorc[i].src.{Iks3v}Ups_Ik1v.arvoRea*1000  //<, *1000 = Ik1v, Oli kA :na   <141.1:  Iks1v = Ups_Ik1v, ,..3v
              else ikLa := edv.Sorc[i].src.{Iks1v}Ups_Ik3v.arvoRea*1000; //<'Eka löytynyt Iks3v/1v on UPS´in koska niitä ei
      if ikLa>0                                                          //  voi olla rinnakkaisia.
         then Break;
   end;
   if ikLa<=0  then begin
        sa := 'Ilmoita valmistajalle (leikkaa/liimaa tästä), os=' +IntToStr(os) +' :  '+
              'Nola1.INC/FNC Iks (Ziks) impedanssi ';
        if MaxI  then sa := sa +'Zik3v=0'
                 else sa := sa +'Zik1v=0';
        sa := sa +', ajo saattaa keskeytyä "Floating point divided by '+
                  'zero" -virheilmoitukseen (vrt. ik = U/Zk). ';
        if os>=0
        then sa := sa +'Ziks=0 vielä liittymäjohtojen jälkeen.'
        else begin
             Kind := edv.Sorc[Abs(os)].src.SorceKind.arvoInt;
             sa := sa +IntToStr (Kind);
             case Kind of
                1 :sa := sa +'=Transformer';
                2 :sa := sa +'=LV-Cable';
                3 :sa := sa +'=Generator';
                4 :sa := sa +'=UPS';  end;
        end;
        InfoDlg (sa,  mtCustom,  'OK','','','',  '','','','');
   end;//if ikLa<=0
end//'''''Zik<=0''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
(*ELSE BEGIN
   if maxI
   then begin
        ikLa := fIk3v;                                 //<Ik3v kutsun Zik:n mukaan =Zik oltava > 0 !!
        ikLi := a_getReaa (1114,edv.Sorc[1].src.Iks3v)*1000;  end //< *1000 = Ik3v, oli kA
   else begin
        ikLa := fIk1v;                                 //<Ik1v kutsun Zik:n mukaan =Zik oltava > 0 !!
        ikLi := a_getReaa (1115,edv.Sorc[1].src.Iks1v)*1000;      //< *1000 = Ik3v, oli kA
   end;                        //,Jos SorceKind <> 1(SJ-liit) JA laskettu Ik > liittymänIk => KORJATAAN.
   if edv.Sorc[1].src.SorceKind.arvoInt <> 4 //<1=Transformer  2=LV-Cable  3=Generator 4=UPS
      then ikLi := 0;                        //<EHDOTTOMAN TÄRKEÄ; EI WORKI MUUTEN OIKEIN, TODETTU.+6.2.8
 //if (ikLa>ikLi) and (ikLi>0)               //<OK mutta ei kata kaikkea.
   if ((edv.Sorc[1].src.SorceKind.arvoInt = 4)  OR //<1=Transformer  2=LV-Cable  3=Generator 4=UPS
        (os>=0))  and
      (ikLa>ikLi) and (ikLi>0)
      then ikLa := ikLi        //<'Esim, PJ-liit. tai UPS +0 m Ik3v voi olla > Iks3v. Tässä asia tarkist. + korjat.
      else if (ikLa<0) and (ikLi>0)  then beep;
END;//ELSE*)
(*ELSE BEGIN
   if maxI
   then begin
        ikLa := fIk3v;                                 //<Ik3v kutsun Zik:n mukaan =Zik oltava > 0 !!
        ikLi := a_getReaa (1114,edv.Sorc[1].src.Iks3v)*1000;  end //< *1000 = Ik3v, oli kA
   else begin
        ikLa := fIk1v;                                 //<Ik1v kutsun Zik:n mukaan =Zik oltava > 0 !!
        ikLi := a_getReaa (1115,edv.Sorc[1].src.Iks1v)*1000;      //< *1000 = Ik3v, oli kA
   end;                        //,Jos SorceKind <> 1(SJ-liit) JA laskettu Ik > liittymänIk => KORJATAAN.
   if (edv.Sorc[1].src.SorceKind.arvoInt IN [2,4]) and //<1=Transformer  2=LV-Cable  3=Generator 4=UPS
      (ikLa>ikLi) and (ikLi>0)
      then ikLa := ikLi        //<'Esim, PJ-liit. tai UPS +0 m Ik3v voi olla > Iks3v. Tässä asia tarkist. + korjat.
      else if IsDebuggerPresent  then begin
            case edv.Sorc[1].src.SorceKind.arvoInt of //<1=Transformer  2=LV-Cable  3=Generator 4=UPS
               1 :sa := '1=Transformer';
               2 :sa := '2=LV-Cable';
               3 :sa := '3=Generator';
               4 :sa := '4=UPS';  end;
            sa := EdvFilen +':   ' +sa;
            EdvNewFrm.LisaLbl.Caption := sa;
            EdvNewFrm.LisaLbl.Visible := true;
         end;
END;//ELSE
   Result := ikLa;
END;//FNC iks*)

ELSE BEGIN                     //SorceKind:  1=Transformer  2=LV-Cable  3=Generator 4=UPS ========= Uusittu 6.2.9
   if MaxI
      then ikLa := fIk3v
      else ikLa := fIk1v;
   ikLi := 0;
   if edv.Sorc[1].src.SorceKind.arvoInt = 4 //< UPS, muilla pakko olla ainakin liittymän Z:  Ry+Rm, Zg, eZs
   then if MaxI                             //,[1]=OK koska rinnakkaisia UPSeja ei hyväksytä NOLAssa.
        then ikLi := a_getReaa (1114,edv.Sorc[1].src.Iks3v)*1000         //< *1000 = Ik3v, oli kA
        else ikLi := a_getReaa (1115,edv.Sorc[1].src.Iks1v)*1000;        //< *1000 = Ik1v, oli kA

   if (ikLa>ikLi) and (ikLi>0)  then             //<Jos esim. UPSilla Ziks=0, (eRs annettu 0).
      ikLa := ikLi;
END;
   Result := ikLa;
   if (os>10000) and (os<-10000)  then SysUtils.beep;     //<+7.0.4 Jotta os säilyisi = ei häviäisi optimization´issa.
END;//FNC iks
//==================================================================================================
PROCEDURE asMparamEdv_Ik3v (os :integer;  VAR Rm,Rmo, Xm,Xmo :Real);    VAR  Mtyp,t :integer;    begin
        //asMparam_ (a_getIntg (1115,Edv.Sorc[os].src.Smn), 8, Rm,Rmo, Xm,Xmo, Mtyp);  end;   //< 8=MinZ  9=MaxZ.-5.0.0
          t := a_getIntg (1115,Edv.Sorc[os].src.TrfTyp);                                     //< Määrätty tyyppi, voi
          asMparam_ (a_getIntg (1115,Edv.Sorc[os].src.Smn), t,75, Rm,Rmo, Xm,Xmo, Mtyp);  end;// 'olla 9 !!!! +5.0.0
PROCEDURE asMparamEdv_Ik1v (os :integer;  VAR Rm,Rmo, Xm,Xmo :Real);    VAR  Mtyp,t :integer;    begin //'20°=>75°C 6.0.4
          t := a_getIntg (1115,Edv.Sorc[os].src.TrfTyp);                                      //< Määrätty tyyppi, voi
          asMparam_ (a_getIntg (1115,Edv.Sorc[os].src.Smn), t,75, Rm,Rmo, Xm,Xmo, Mtyp);  end;// 'olla 9 !!!!!
//PROCEDURE asMparam (Smn :Real;  maxI :Boolean;  VAR Rm,Rmo, Xm,Xmo :Real);
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NOLA1.INC }
