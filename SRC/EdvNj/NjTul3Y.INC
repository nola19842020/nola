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
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NjTul3Y.INC }
{$I ..\GlobINC\KatuvalF.INC} //<+7.0.3
{ ##################  Ole varovainen PAIKALLISTEN sa :stringien ja  SISVEX,SISA,SISB,ASTAB..  ##################
  ##################  yms. kanssa, koska NÄMÄ SIJOITTAVAT GLOBAALIIN Str -muuttujaan, jolloin ##################
  ##################  adStF (SA).. tms. saattaa tulla ERI KOHTAAN kuin oli tarkoitus.!!!!!!!! ##################
  ################## !!!!!!!! HUOLEHDI, ETTÄ adStF (SA) tms. EDELTÄ sisA TMS. KUTSUA !!!!!!!! ##################
  ##############################################################################################################}
  function fMrkPix (str :string) :Integer;      VAR k :integer;  ar :real;  apuImage :TImage;    //<Str PIXeleinä
      function fPixPit (str :String) :Integer;  VAR n :integer;                       //<,Mjonon pituus PIXeleinä
        begin apuImage := TImage.Create(NIL);
              apuImage.Visible := false;
              apuImage.Parent := NjTulFrm;
            //apuImage.Canvas.Font := NjTulFrm.aRich.Font;
            //apuImage.Canvas.Font.Assign (NjTulFrm.aRich.Font); //< -5.0.0  Kun CharSet oli ANSI_CHARSET
              apuImage.Canvas.Font.Assign (NjTulFrm.Font);       //< +5.0.0  Koska aRich CharSet := SYMBOL_CHARSET
            //n := Y_fPixPit (apuImage.Canvas, str, apuImage.Canvas.Font);
              n := apuImage.Canvas.TextWidth (str);        //<'Samat lopputulokset prikulleen ######
            //n := Y_fPixPit (apuImage.Canvas, str, NjTulFrm.aRich.Font);
            //Result := pyor (n/2);    //,##########################################################
            //Result := n;             //,0.64 =luita myöten, koklattu: 0.52 -- 0.65, 0.67, =jolloin varattu tila
              Result := pyor (n*0.75); //<täysin käytössä ja pienikin lisä heittää seur. tab:iin. DEVELOPER1 0.64,
              apuImage.Free;   end;    //'DEVELOPER2 0.6 . NYT KERROIN 0.85 TAKAA VARMASTI RIITTÄVÄN PALSTALEVEYDEN
                                       //'ILMAN, ETTÄ TARVITSISI ANTAA KUTSUSSA LISÄMERKKEJA esim. 300 mm²__ tms.
  begin                                //'(vrt. '__' = varmuusvara ##############################################
     ar := fKpix;
     k := pyor (ar *fPixPit (str));
     Result := k;
  end;
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}//###############################################
  procedure ClearTabs;   begin  str := str+ '</tab> ';   end; //< ' ' jatkona, jos seur. mrk alkaa '<..', TODETTU
  procedure sisVex;      begin  str := str+ '</in>';     end;
{ procedure sijSis (i :integer);      begin
     str := str+ '<in f="" l="'+ fImrkt0 (i,1)+ '">';  end;          //<f="" =Ekaa riviä EiSisennetä}
  procedure asetaSis (sisStr :string);  begin  str := str+ '<in f="" l="'+sisStr+'">';  end; //<,,KutsutVainTässä
  procedure sisB;  begin  asetaSis (sisBstr);  end;           //<,Ks. sis: PRC asTabSisB / asTabXnSisB
  procedure sisA;  begin  asetaSis (sisAstr);  end; //'SIS.. AIHEUTTAA AINA lf, joten ed. ad.. p.o. ad.._

{,,Putsaa ekax vanhat TABit,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   Asettaa TAB-kohdat TABC-välein SEKÄ LASKEE sisB-kohdan SYMB esim.'XXX = ' pixelien mukaan laskettuna
    sen jälkeiseen ALKUKOHTAAN. Kun 1 x SisVex, sisennys palaa edelliseen ASETETTUUN = 1.tabV :hen jne.
  - Tällä kutsulla saadaan laskettua sisB -kohta ja TALLETETTUA se muuttujaan SISA. ################
  - Tämän kutsun jälkeen VASTA VOIDAAN KUTSUA PRC sisB, ellei erikseen kutsuta SISB. ###############
  - sisA = Sis 1.tabV,  sisB = 'Xvo =  ':n jälkeen. ################################################
  - Koska sorcassa 1. tarvittava sis. = 1.tabV, täytyy TÄMÄN KUTSUN jälkeen antaa 1 x SisVex. ######
  ,TABA=Eka tab, josta alkaa SYMB =MJono, jonka JÄLKEEN tab2.  KUTSUesim: ('Xvo_') ================}
  procedure asTabSisB (symb :string);      var t,x :integer;
   //procedure tabSet (s :string);   begin  str := str+ s;   end;//s='10,15,..jne //,'</tab>'=PutsatVanhat
                                                       //,,,,,,+' ' muuten ClearTabs ei onaa, TODTTU
     procedure tabSet (s :string);   begin  str := str+ '</tab> <tab s="'+s+'">';  end;//s='10,15,..jne
     function tbS (o :integer) :string;      begin  Result := fImrkt0 (o,1)+',';   end; //<Palauttaa TabStr
     function tb_ (o :integer) :string;      begin  Result := fImrkt0 (o,1);       end; //<Palauttaa TabStr
  begin
    t := fMrkPix (symb);   x := tabC +t-4;              //<Nyt t=tab2  x=sisennKohta, -4=Hienosäätöä
    sisAstr := fImrkt0 (tabC, 1);                       //<SISA jää VOIMAAN ########################
    sisBstr := fImrkt0 (x, 1);                          //<SISB jää VOIMAAN ########################
           //,,ekaTab ,,,'='  ,,Sis  ,,,,,,tab4  ,,,,,,,,tab5  ,,,,,,,,tab6 ,,,,,,,,,tab7<<<<<<<<<<<
    tabSet ( tbS(tabC)+tbS(t)+tbS(x)+tbS(x+tabC)+tbS(x+2*tabC)+tbS(x+3*tabC)+tbS(x+4*tabC)
            +tbS(x+5*tabC)+tbS(x+6*tabC)+tbS(x+7*tabC)+tbS(x+8*tabC)+tbS(x+9*tabC)+tbS(x+10*tabC)
            +tbS(x+11*tabC)+tbS(x+12*tabC)+tbS(x+13*tabC)+tbS(x+14*tabC) + tb_(x+15*tabC) );
                                                                    {Vikana'''TAB_ #######}     END;
{,,Putsaa ekax vanhat TABit,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
     {,,,Tutkii STG-mallimjonon ja asettaa TABin jokaisen '\':n jälkeen. SISennys @TABn alkuun,,,,,}
     {              //sisA,,tab.., sisB,@(eipakko)   ,....tab....,......, jne...<<<<<<<<<<<<<<<<<<<}
     {     asTabXnSisB (10,'22---\20x--\@MMJ/MMK*----\3200 mm2---\SÄL---\88888 m---\300 °C---\.....}
     {,,,,,                '10   '23   '37           '80         '116   '135       '165      '190..}
  procedure asTabXnSisB (Vmarg :integer;  stg :string);    var st,sp :string;  tabV,mja,i :integer;
     procedure LISAA;   begin
        if sp<>''  then sp := sp +',';
        sp := sp +fImrkt0 (tabV +fMrkPix (st),1);  END;
  begin
    mja := Length (stg);                                       //'tabul kohdat= '<tab s="n1,n2,...">
    sisAstr := fImrkt0 (tabC,1);  //<Asetti sisA -kohdan TABC:hen. Asetettava erikseen ON ##########
    sp := '';  tabV := 0;
    if Vmarg>0  then begin
       tabV := tabC;              //,1.tab.kohta oltava, koska AD1SF/AD3SF yms. antaa ekax TAB; ####
       sp := fImrkt0 (tabV,1);  end;
    i := 0;   st := '';
    while i<mja do begin
       i := i+1;
       if stg[i]='\'                                               //<TAB -kohta ###################
       then LISAA
       else if stg[i]='@'                                          //<SisB -kohta ##################
       then sisBstr := fImrkt0 (tabV +fMrkPix (st),1)              //<Asetti sisB -kohdan. #########
       else begin                                                  //'AsetettavaErikseen ON =SISB ##
          st := st +stg[i];
          if i=mja  then LISAA;  end;                              //<Näin ei tartte loppuun '\'####
    end;                     //,</tab> :in jälkeen p.o. muuta kuin <..>, muuten ei ClearTab, TODETTU
    sp := '</tab> <tab s="' +sp +'">';        //<  '</tab>' = Sarkainkohdat EKAX putsataan vanhoista
    str := str +sp; //<Nyt sekä sisA + sisB asetettu ###############################################
  end;//asTabXnSisB
  //================================================================================================
  procedure tab;           begin  str := str +'<t>';  end;         //<Siirtää seur tabiin<<<<<<<<<<<
  function tab1 :string;   begin  Result := '<t>';    end;         //<- " -
              //,Vika "F" = sis. LineFeed<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  procedure LF;                  begin       str := str+ '<br>';  end;
  procedure adSt_ (s :string);   begin       str := str+ s;       end; //< String vas.marg.  Ei LF
  procedure adStF (s :string);   begin       str := str+ s;  LF;  end; //< String vas.marg.   LF
  procedure ad1S_ (s :string);   begin  tab; str := str+ s;       end; //< - " -  1.tabV     Ei LF
  procedure ad1SF (s :string);   begin  tab; str := str+ s;  LF;  end; //< - " -   - " -      LF
        //,,Esim: (1,        'Xv0','=','Selitys....' = t*Tab+s1 + tab+s2 + s3 sisentäen<<<<<<<<<<<<<
  procedure ad3S_ (t :integer;  s1, s2, s3 :string);    var i :integer;   begin  //< 3xStr 1.tabV + Ei LF
                                 for i := 1 to t  do tab;  adSt_ (s1);
                                 tab; adSt_ (s2);  tab; adSt_ (s3);       end;
  procedure ad3SF (t :integer;  s1, s2, s3 :string);   begin ad3S_ (t,s1,s2,s3);  LF;  end; // - " - + LF
(*procedure ad1SF (s :string);   begin  sisA; tab; str := str+ s; {sisVex; }end;//<SISalkuun, SISVEX eiLF
        //,,Esim: (1,        'Xv0','=','Selitys....' = t*Tab+s1 + tab+s2 + s3 sisentäen<<<<<<<<<<<<<
  procedure ad3SF (t :integer;  s1, s2, s3 :string);    var i :integer;   begin //<Sisentää SIAan txtin.
                                 sisB;  for i := 1 to t  do tab;  adStr (s1);   //<SIS oltava alussa<<<
                                 tab; adStr (s2);  tab; adStr (s3); {sisVex; }end;//<=LF muttaStacnTakia VEX*)
//'''############################################################################################'''
//######### PITÄISI OTTAA sisVex, mutta SE AIHEUTTAA YLIMÄÄRÄISEN RIVINVAIHDON !?!?!?!?!?###########
//##################################################################################################
  function fMaxMrkt (str,raj :string) :string;      VAR sa :string;  maxL,L,m,i :integer;      begin
     maxL := fMrkPix (raj);   L := fMrkPix (str);   //'Lyhentää STR:ää jos >RAJ, ja lisää loppuun '~'
     sa := str;
     m := Length (str);  i := m;
     if L>maxL  then begin
        while (L>maxL) and (i>1)  do begin                           //S := 'ABCDEF';
           i := i-1;                                                 //S := Copy(S, 2, 3); { 'BCD' }
           sa := Copy (str,1,i);                                     //'2=B,  3=BCD (=lkm)
          {sa := '';   for j := 1 to i  do sa := sa +str[j];}
           L := fMrkPix (sa);
        end;
        if m>i  then sa[i] := '~';
     end;
     Result := sa;  end;
//............................................
        function fPixPitNjB (str :string) :integer;      begin                    //<Käytetty vain PisteviivaTest
           result := pyor (Y_fPixPitB (NjTulFrm.Canvas, str, NjTulFrm.aRich.Font));  end;

  function Pisteviiva (str :string) :string;      const pist='¨';   var sa :string;      begin
     sa := '';                                                                          //ScrollBarLev,,,+vara
     while Y_fPixPitB (NjTulFrm.Canvas, str+' ' +sa+pist, NjTulFrm.aRich.Font) < NjTulFrm.aRich.Width -30
        do sa := sa +pist;                  //Ulos_+SA=200 -> RichW=639 s=406 u=605
                                            {adSt_ ('Ulos_+SA=' +fImrkt0 (fPixPitNjB (' '+sa),1) +' -> ');}
     sa := str +' ' +sa;                    {adStF ('RichW=' +fImrkt0 (NjTulFrm.aRich.Width,1) +' s=' +fImrkt0 (
                                                   fPixPitNjB (str),1) +' u=' +fImrkt0 (fPixPitNjB (sa),1));}
     sa := '<b>' +sa +'</b>';
     Result := sa;   end;

  function Pisteviiva2 (strA,strB :string) :string;      const pist='¨';   var sa :string;      begin
     sa := '';                                                                          //ScrollBarLev +vara ,,,
   //while Y_fPixPitB (NjTulFrm.Canvas, strA +' '+sa+pist +strB, NjTulFrm.aRich.Font) < NjTulFrm.aRich.Width -30
     while Y_fPixPitB (NjTulFrm.Canvas, strA +'  '+sa+pist +strB, NjTulFrm.aRich.Font) < NjTulFrm.aRich.Width -40
        do sa := sa +pist;                  //'''' Jottei joskus lykkäisi alkua seur rvlle      ''4.0.0  30 -> 40
     sa := strA +' '+sa +strB;            {adStF ('RichW=' +fImrkt0 (NjTulFrm.aRich.Width,1) +' a+b=' +fImrkt0 (
                                                 fPixPitNjB (strA+strB),1) +' u=' +fImrkt0 (fPixPitNjB (sa),1));}
     sa := '<b>' +sa;                       //<Bold -merkintä ei saa olla kutsuS :ssa mukana, tulisi virhePixPit
     result := sa;   end;
//............................................
function TUPon (ch :char;  TUP :integer) :boolean;         begin //<'T,U,P'
   Result := false;
   ch := AnsiUpperCase (ch)[1];
   if CharInSet(ch, ['U','u','P','p','X','x'])  then if TUP>=1000  then TUP := TUP-1000;
   if CharInSet(ch, [        'P','p','X','x'])  then if TUP>= 100  then TUP := TUP- 100;
   if CharInSet(ch, [                'X','x'])  then if TUP>=  10  then TUP := TUP-  10;
   case ch of
     'T' :if TUP>=1000  then Result := true;      //<Ei enää käytössä 9.0.1
     'U' :if TUP>= 100  then Result := true;      //<Ei enää käytössä 9.0.1
     'P' :if TUP>=  10  then Result := true;
     'X' :if TUP>=   1  then Result := true;  end;//case
end;
//............................................
function TarveIk (s :string) :string;     begin  if s=''  then Result := s
                                                          else Result := ' (tarvittava Ik=' +s +').';  end;
function EiTUPraj :string;      begin  Result := ' <t>A2/413.1.3.3- .5 = OK.';  end;
procedure TUPsel (TUPX :integer;  s :string);     VAR ss :string;   begin
(* if TUPx>0  then ad1SF (fImrkt0 (TUPX,1){+
              '  t='+AnsiUpperCase ('t')[1]}); //<<<<<<<<< TESTIÄ, ONKO TUPSEL OK <<<<<<<<<<<<<<<<<<*)
  {boo := false;
   if TUPon ('T',TUPX) or TUPon ('U',TUPX) or TUPon ('P',TUPX)   then boo := true;}
   if TUPon ('T',TUPX)  then ad3SF (1,CLR_REB+'T','=',tab1 +'Poiskytk.aika ei toteudu' +FNT_B0 +TarveIk (s) +'.');
   if TUPon ('U',TUPX)  then ad3SF (1,CLR_REB+'U','=',tab1 +'ZsIa -ehto A2/413.1.3.3 ei täyty,'+FNT_B0);

 //if TUPon ('P',TUPX)  then ad3SF (1,CLR_REB+'P','=',tab1 +'Zpe -ehto A2/413.1.3.5 ei täyty. ' +FNT_B0 +
   if TUPon ('P',TUPX)  then begin ss := tab1 +'Zpe -ehto A2/413.1.3.5 ei täyty.' +FNT_B0;
      if NOT det3       then ad3SF (1,CLR_REB+'P','=',ss +'..')                            else
      if onjoPinf       then ad3SF (1,CLR_REB+'P','=',ss +' Ks. aikaisemmat '+CLR_REB +' P'+FNT_B0 +' -selitykset.')
                        else ad3SF (1,CLR_REB+'P','=',ss +
         'Ehto on jouduttu tarkistamaan, koska valittu poiskytkentäaika >' +fPoiskAikaRajaS +'s.  Kun ehto ei '+
         'täyty, kohoaa kosketusjännite samaan <b>syöttävään </b>jakokeskukseen liitetyissä <b>muissa '+
         'ryhmäjohdoissa </b>vikatapauksessa >50 V :n, jolloin potentiaalin nousemisen '+
         'rajoittamiseksi potentiaalintasaukselle ja PE-johtimen impedanssille on asetettu raja-ehtoja '+
         '(SFS 6000-A1/413.1.3.5). Koska tässä tapauksessa jakokeskuksen yhteydessä ei ole potentiaalintasausta, '+
      'ei Zpe saa olla > 50×Zs / Uo, mikä nyt ei täyty. '+
      '<b>>' +fPoiskAikaRajaS +' s:n ryhmäjohdoissa on ryhdyttävä toimenpiteisiin vain, jos niitä on liitetty '+
      'samaan jakokeskukseen tai samaan pääjohtoon edellisen pot.tasauspisteen jälkeen tai ennen seuraavaa '+
      'pot.tasausta.</b>');
      onjoPinf := true;
   end;//if TUPon ('P',..)
      //'JK:ssa eioo PT :tä. Jos olisi, ehto täyttyisi ilman ZPE -impedanssin tarkistusta !!! ######
 //if boo               then ad1SF (CLR_REB +'Käytä vikavirtasuojakytkintä tai pot.tasausta.'+FNT_B0);
   if TUPon ('X',TUPX)  then ad3SF (1,CLR_GRB+'    X'+FNT_B0,'=','Zpe -ehto SFS 6000-A1/413.1.3.5 täyttyy '+
                               'vain jäljempänä verkossa olevaan pääpot.tasauspisteeseen laskien.');
 //if TUPX=0  then ad1SF ({1,'','',}'<b>Ei TUP -rajoituksia.</b>');
end;//TUPsel
//............................................
PROCEDURE Tul_PrRj (Qsul :integer;  Qtim,Qmm2 :real;  QsuC :string;    s1,s2,s3 :string);
 VAR rr,pit :real;  i,ai,d :integer;  ss :string;      begin

 //laskeRJpit (TRUE{Nj}, edmaxkpl,Qsul,50,Qtim, Qmm2, QsuC,'A',rr,ar, ai,i);    //< -4.0.0
 //laskeRJpit (TRUE{Nj}, edNo-1,Qsul,50,Qtim, Qmm2, QsuC,'A',rr,ar, ai,i);      //< -6.0.2
   laskeRJpit ('Tul', NJkinTR, edNo,  Qsul,50,Qtim, Qmm2,0, 1,'', QsuC,'A', rr,pit,rr, ai,i); //< edNo-1 => edNo 6.0.2
   ai := 1;   if CharInSet(QsuC[1], ['d','D']) then ai := 0;                //<Jsk-D :lle aina arvot       //TUPX='i'
   d :=  1;   if pit<0.1  then d := 0;
   ss := fDemRx (ai,pit,1,d) +' m' +tab1;
   ss := ss +s2 +'<t>' +TarveIk (s3);
   if i=0 then ss := ss +EiTUPraj;                                  //<Ei kylläkään 0.4s :lla 'P'
   if det1  then begin  if {TUPon ('T',i) or TUPon ('U',i) or }TUPon ('P',i)   then onRJinf := true;  end //<9.0.1
            else begin  ad3SF (1,s1,'=',ss);
                        TUPsel (i,s3);  end;
end;
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
                                                     //,  -12345.78 -> -12.345,78  -0.34 -> -0,34
//,Koklattu: 7.89 67.89 567.89 4567.89 34567.89 34567.89 234567.89 1234567.89 + samat -7.89 -67.89..=OK
FUNCTION mrkDekadit (ar :real) :string;      VAR i,k :integer;   ss,str :string;      BEGIN
   ss := fRmrkt0 (ar,1,2);
   str := '';
   k := 0;
   for i := Length (ss) downto 1  do begin
      k := k+1;
      if ss[i]='.'
      then begin  str := ','+str;  k := 0;         end    //< -xxxx.78 ->       ,78
      else if (k=4) {and (i>1) }and (ss[i]<>'-')
      then begin  str := ss[i]+'.'+str;  k := 1;   end    //< -x345.78 ->  2.345,78
      else        str := ss[i]+str;                       //< -xxxx.78 -> -xxxx5,78
   end;                                                   //  -xxx5.78 -> -xxx45,78
   Result := str;                                         //  -xx45.78 -> -xx345,78
end;//mrkDekadit
//==================================================================================================
//==================================================================================================
{I ..\GlobINC\KatuvalF.INC} //<+7.0.3
PROCEDURE OhjTul_eritNj;      VAR ohj :ohjaava;  s,sh :string; //Uusittu 6.1.1
   function fEdvHeikko :string;      begin
      if (edNo>1) or (tuxV<30)
         then result := '   Ed.verkko heikko?  uh%-raja tiukka?' //< +4.0.0, >1 =6.1.1
         else result := '';          end;
   function fSjEhka :string;      VAR i,j :integer;     begin
      j := 0;
      for i := 1 to a_getIntg (39011, Edv.YLE.SorceCount)  do
      if a_getIntg (39012, Edv.Sorc[i].src.SorceKind) = 1   //< 1=Transformer  2=LV-Cable  3=Generator  4=UPS
         then begin  j := i;  Break;  end;
      if j=0  then result := '   Sj-liittymä saattaisi helpottaa tilannetta !'
              else result := '';      end;

BEGIN
   tux := 0;

   NjTulFrm.aRich.Clear;
   sisAstr := '';   sisBstr := '';
   str := '';                                 //<Tähän tuloste, tästä aRichiin Nola3x.INC :ssä
   Screen.Cursor := crHourGlass;              //<Ilman SCREENiä vipattaa!!!

   if NOT Katuval  then begin       //<+7.0.3
      if NOT NjTulAuki  then        //<,+7.0.4
       //asetaProgres ('Tekstitietoja valmistellaan (1 ... '+fImrkt0 (VExKrt,1) +')',1 + VExKrt);
         asetaProgres ('Tekstitietoja valmistellaan', 0);
      etsiSulTapa (ohj);  end;      //<Vain tässä @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   tulostaKesk;
   s := '';
   sh := 'Al';  if NOT fBtnAL  then sh := 'Cu';
   if NOT Katuval  then begin          //<+7.0.3
      IF ohj=OK                        //,Vasta tässä tutkitaan OHJ =AINA tulostetaan KESKUSosa #######
      then begin                       //,Merkkinä, onko jo 'LADATTU' #################################
         if NOT NjTulAuki  then        //< := FALSE PRC:ssä DetEv.OnClose, := TRUE  ks. n. 5r alempana
            asetaProgres ('Tekstitietoja valmistellaan (1 ... '+fImrkt0 (VExKrt,1) +')',1 + VExKrt);
         etsiKaap (TRUE,ohj);                //<EtsisulTapa :ssa tutkittiin 1.CU+AL ve:t, joista päätet
         IF ohj=OK                           // tiin kumpi tulost.EKAX! ###############################
            then ohjaaEditNj                 //<Hoitaa jatko-ohjailut VE:n mukaan #####################
            else s := '20 x 300 '+sh +' ylittyy !' +fEdvHeikko +fSjEhka;
      END
      ELSE s := 'Kuorma liian iso:   20 x 300 '+sh +' ylittyy !' +fEdvHeikko +fSjEhka;
   end;

   NjTulFrm.Visible := true;              //<Nyt vasta Frm näkyviin ettei näy Edv:n latauksen aikana.
   NjTulFrm.Show;                         //'Oli asetettu ObjInsp :ssa FALSEksi ####################
   NjTulFrm.aRich.Enabled := false;       //<,,Näkymä aRICHIn alkuun vain kun eka aukaisu ##########
   NjTulFrm.aRich.SelStart := 0;
   NjTulFrm.aRich.SelLength := 0;
   NjTulFrm.aRich.Enabled := true;

   NjTulFrm.aRich.Hide;                             //<,,Muutetaan tulfrmn kokoa hetkellisesti, jolloin sisennyk-
   NjTulFrm.aRich.Width := NjTulFrm.aRich.Width -1; //   set päivittyvät oikein. Aikaisemmin kun Frm suljettiin
   NjTulFrm.aRich.Width := NjTulFrm.aRich.Width +1; //   ja taas avattiin, sisennykset alkoivat monta tabia lii-
   NjTulFrm.aRich.Show;                             //<''aksi oikealle Ik1v :n jälkeen (DEVELOPER2 korjaus) <<<<<<<<<<
   NjTulFrm.aRich.SetFocus;                      
   NjTulAuki := true;                               //<Merkiksi: On jo 'LADATTU' ################################
   Screen.Cursor := crDefault;

   if s<>''  then begin
      Beep;  EiOKinfo (s);  end;
   ProgresFrm.Close;

   NjTulFrm.aRich.Enabled := true;     //<,,+7.0.4 Tulostuslomakkeeseen sallitaan nyt muutoksia ja omia tekstejä.
   NjTulFrm.aRich.WantReturns := true;
   NjTulFrm.aRich.ReadOnly := false;
end;//OhjTul_eritNj*)
//==================================================================================================

