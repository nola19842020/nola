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

{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ DetEv-1.INC }
{##################################################################################################'Oli: Det10.INC
 VINKKI: Ohjelman latautuminen nopeutuu merkittävästi, kun "Etsi/Korvaa \\,,, -> \\,,,*) ###########
         JA/TAI for silmukka i := 1 to 1                                                 ###########
-141.1:  Lähes koko detTulostus voidaan ohittaa sulkuparilla (*..*), etsi pari µ .. µ .
####################################################################################################}
PROCEDURE tul_eritEdv;
   const tabC=10;   d1=8;                      //<tabC=Tabuln vakiovälit   d1=Ohmien desim.lkm
   VAR sa,{se,}str, sisAstr,sisBstr :String;     //<sisA =Vika voimassa oleva SYMBOLIN jälkeinen
                                               //'sisennyskohta, pvittyy PRC tabSis :ssä
       aa,rr,ar,ra,a8,r8,r7,{a3,}  Rs,Xs,Zs{,Ls,  Rv,Rvo,Rn,Xv},Xo{,Xn}  :Real;
       Ik1v,Ik3v,rinKer,Ls :Real;
       Gtyp :string;   GUn,Gkpl,Glampot  :Integer;   Gmm2,Gpit,Gkorj, Gtim,GcU,GKpe :Real;
       Gkul,Gpt{, Giec}{,PselOnJo,XselOnJo{+9.0.1} :Boolean;

                                           //,,,,,,,,,,,,,,,,,,,,,,,,, ###########################????????
  function fMrkPix (str :string) :Integer;      var k :integer;  apuImage :TImage;  //<Str PIXeleinä
      function fPixPit (str :String) :Integer;  VAR n :integer;          //<,Mjonon pituus PIXeleinä
        begin apuImage := TImage.Create(NIL);
              apuImage.Visible := false;
              apuImage.Parent := DetEvFrm;
            //apuImage.Canvas.Font := DetEvFrm.aRich.Font;
            //apuImage.Canvas.Font.Assign (DetEvFrm.aRich.Font); //< -5.0.0  Kun CharSet oli ANSI_CHARSET
              apuImage.Canvas.Font.Assign (DetEvFrm.Font);       //< +5.0.0  Koska aRich CharSet := SYMBOL_CHARSET
            //n := Y_fPixPit (apuImage.Canvas, str, apuImage.Canvas.Font);
              n := apuImage.Canvas.TextWidth (str);        //<'Samat lopputulokset prikulleen ######
            //n := Y_fPixPit (apuImage.Canvas, str, DetEvFrm.aRich.Font);
            //Result := pyor (n/2);    //,##########################################################
            //Result := n;             //,0.64 =luita myöten, koklattu: 0.52 -- 0.65, 0.67
              Result := pyor (n*0.85); //<=jolloin varattu tila täysin käytössä ja pienikin lisä
              apuImage.Free;   end;    //'heittää seur. tab:iin. DEVELOPER1 0.64, DEVELOPER2 0.6 !!!!!!!!!!
  begin                                //'NYT KERROIN 0.85 TAKAA VARMASTI RIITTÄVÄN PALSTALEVEYDEN
     k := fPixPit (str);               //'ILMAN, ETTÄ TARVITSISI ANTAA KUTSUSSA LISÄMERKKEJA esim.
     Result := k;  end;                //'300 mm²__ tms. (vrt. '__' = varmuusvara ##################
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}//###############################################
  procedure sisVex;   begin  str := str+ '</in>';   end;
{ procedure sijSis (i :integer);      begin
     str := str+ '<in f="" l="'+ fImrkt0 (i,1)+ '">';  end;          //<f="" =Ekaa riviä EiSisennetä}
  procedure asetaSis (sisStr :string);  begin  end;//str := str+ '<in f="" l="'+sisStr+'">';  end;
  procedure sisB;  begin  asetaSis (sisBstr);  end;           //<,Ks. sis: PRC asTabSisB / asTabXnSisB
  procedure sisA;  begin  asetaSis (sisAstr);  end; //'SIS.. AIHEUTTAA AINA lf, joten ed. ad.. p.o. ad.._

{,,Asettaa TAB-kohdat TABC-välein SEKÄ LASKEE sisB-kohdan SYMB esim.'XXX = ' pixelien mukaan laskettuna
    sen jälkeiseen ALKUKOHTAAN. Kun 1 x SisVex, sisennys palaa edelliseen ASETETTUUN = 1.tabV :hen jne.
  - Tällä kutsulla saadaan laskettua sisB -kohta ja TALLETETTUA se muuttujaan SISA. ################
  - Tämän kutsun jälkeen VASTA VOIDAAN KUTSUA PRC sisB. ############################################
  - sisA = Sis 1.tabV,  sisB = 'Xvo =  ':n jälkeen. ################################################
  - Koska sorcassa 1. tarvittava sis. = 1.tabV, täytyy TÄMÄN KUTSUN jälkeen antaa 1 x SisVex. ######
  ,TABA=Eka tab, josta alkaa SYMB =MJono, jonka JÄLKEEN tab2.  KUTSUesim: ('Xvo_') ================}
  procedure asTabSisB (symb :string);      var t,x :integer;
   //procedure tabSet (s :string);   begin  str := str+ s;   end;//s='10,15,..jne //,'</tab>'=PutsatVanhat
     procedure tabSet (s :string);   begin  str := str+ '</tab><tab s="'+s+'">';  end;//s='10,15,..jne
     function tbS (o :integer) :string;      begin  Result := fImrkt0 (o,1)+',';  end; //<Palauttaa TabStr
     function tb_ (o :integer) :string;      begin  Result := fImrkt0 (o,1);      end; //<Palauttaa TabStr
  begin
    t := fMrkPix (symb);   x := tabC +t-4;              //<Nyt t=tab2  x=sisennKohta, -4=Hienosäätöä
    sisAstr := fImrkt0 (tabC, 1);                       //<SISA jää VOIMAAN ########################
    sisBstr := fImrkt0 (x, 1);                          //<SISB jää VOIMAAN ########################
           //,,ekaTab ,,,'='  ,,Sis  ,,,,,,tab4  ,,,,,,,,tab5  ,,,,,,,,tab6 ,,,,,,,,,tab7<<<<<<<<<<<
    tabSet ( tbS(tabC)+tbS(t)+tbS(x)+tbS(x+tabC)+tbS(x+2*tabC)+tbS(x+3*tabC)+tbS(x+4*tabC)
            +tbS(x+5*tabC)+tbS(x+6*tabC)+tbS(x+7*tabC)+tbS(x+8*tabC)+tbS(x+9*tabC)+tbS(x+10*tabC)
            +tbS(x+11*tabC)+tbS(x+12*tabC)+tbS(x+13*tabC)+tbS(x+14*tabC) + tb_(x+15*tabC) );
                                                                    {Vikana'''TAB_ #######}     END;
     {,,,Tutkii STG-mallimjonon ja asettaa TABin jokaisen '\':n jälkeen. SISennys 2. TABn alkuun,,,}
     {              //sisA,,tab.., sisB,@(eipakko)   ,....tab....,......, jne...<<<<<<<<<<<<<<<<<<<}
     {     asTabXnSisB (10,'22---\20x--\@MMJ/MMK*----\3200 mm2---\SÄL---\88888 m---\300 °C---\.....}
     {,,,,,                '10   '23   '37           '80         '116   '135       '165      '190..}
  procedure asTabXnSisB (stg :string);    var st,sp :string;  mja,i :integer;  begin
    mja := Length (stg);                                       //'tabul kohdat= '<tab s="n1,n2,...">
    sisAstr := fImrkt0 (tabC,1);  //<Asetti sisA -kohdan TABC:hen. Asetettava erikseen ON ##########
    sp := fImrkt0 (tabC,1);       //<1.tab.kohta oltava, koska AD1SF/AD3SF yms. antaa ekax TAB; ####
    i := 0;   st := '';
    while i<mja do begin
       i := i+1;
       if stg[i]='\'                                               //<TAB -kohta ###################
       then BEGIN  if sp<>''  then sp := sp +',';
                   sp := sp +fImrkt0 (tabC +fMrkPix (st),1);  END
       else if stg[i]='@'                                          //<SisB -kohta ##################
       then sisBstr := fImrkt0 (tabC +fMrkPix (st),1)              //<Asetti sisB -kohdan. #########
       else st := st +stg[i];                                      //'Asetettava erikseen ON #######
    end;
   {if sp<>''  then }sp := '<tab s="' +sp +'">';
    str := str +sp; //<Nyt sekä sisA + sisB asetettu ###############################################
  end;//asTabXnSisB
  //================================================================================================
  procedure tab;      begin  str := str +'<t>';  end;                //<Siirtää seur tabiin<<<<<<<<<
  function tab1 :string;   begin tab1 := '<t>';  end;                //<- " -
              //,Vika "F" = sis. LineFeed<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  procedure LF;                  begin       str := str+ '<br>';  end;
  procedure adSt_ (s :string);   begin       str := str+ s;       end; //< String vas.marg.  Ei LF
  procedure adStF (s :string);   begin       str := str+ s;  LF;  end; //< String vas.marg.   LF
  procedure ad1S_ (s :string);   begin  tab; str := str+ s;       end; //< - " -  1.tabV     Ei LF
  procedure ad1SF (s :string);   begin  tab; str := str+ s;  LF;  end; //< - " -   - " -      LF
        //,,Esim: (1,        'Xv0','=','Selitys....' = t*Tab+s1 + tab+s2 + s3 sisentäen<<<<<<<<<<<<<
  procedure ad3S_ (t :integer;  s1, s2, s3 :string);    var i :integer;   begin  //< 3xStr 1.tabV + Ei LF
                                 for i := 1 to t  do tab;  adSt_ (s1);           //t = x '<t>'
                                 tab; adSt_ (s2);  tab; adSt_ (s3);       end;
  procedure ad3SF (t :integer;  s1, s2, s3 :string);   begin ad3S_ (t,s1,s2,s3);  LF;  end; // - " - + LF
//procedure ad1SF (s :string);   begin  sisA; tab; str := str+ s; {sisVex; }end;//<SISalkuun, SISVEX eiLF
//      //,,Esim: (1,        'Xv0','=','Selitys....' = t*Tab+s1 + tab+s2 + s3 sisentäen<<<<<<<<<<<<<
//procedure ad3SF (t :integer;  s1, s2, s3 :string);    var i :integer;   begin //<Sisentää SIAan txtin.
//                               sisB;  for i := 1 to t  do tab;  adStr (s1);   //<SIS oltava alussa<<<
//                               tab; adStr (s2);  tab; adStr (s3); {sisVex; }end;//<=LF muttaStacnTakia VEX
//'''############################################################################################'''
//######### PITÄISI OTTAA sisVex, mutta SE AIHEUTTAA YLIMÄÄRÄISEN RIVINVAIHDON !?!?!?!?!?###########
//##################################################################################################
//function Pisteviiva (str :string) :string;      const pist=' . . .';   var sa :string;       begin}
//   sa := '';
//  {while Y_fPixPit (DetEvFrm.Canvas, str +sa+pist, DetEvFrm.aRich.Font) < DetEvFrm.aRich.Width
//         do sa := sa+pist;
//   //sa := ' ='+fRmrkt0 (DetEvFrm.aRich.Width,1,0);  //< =OK
//   Result := str + sa;  end;}
//   Result := str {+ sa;  }end;

  function Pisteviiva (str :string) :string;      const pist='¨';   var sa :string;       begin
     sa := '';                                                                          //ScrollBarLev,,,+vara
     while Y_fPixPitB (DetEvFrm.Canvas, str +' '+sa+pist, DetEvFrm.aRich.Font) < DetEvFrm.aRich.Width -30
           do sa := sa +pist;
     //sa := ' ='+fRmrkt0 (DetEvFrm.aRich.Width,1,0);  //< =OK
     Result := '<b>' +str +' '+sa +'</b>';  end;
//............................................
function TUPon (ch :char;  TUP :integer) :boolean;      VAR s :string;  o :integer;      begin //<'T,U,P,X'
   Result := false;                        //,,,,,,,,,,,,+9.0.1,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   ch := AnsiUpperCase (ch)[1];
   s := IntToStr (TUP);   o := Length (s); //1000=T  100=U  10=P  1=X   => 1011=TPX jne.
   case ch of
     'T' :if (o>=4)  and (s<>'') and (s [o-4 +1]='1')  then Result := true;  //< 1000 Ei enää käytössä 9.0.1  <,,1414d: +s<>''
     'U' :if (o>=3)  and (s<>'') and (s [o-3 +1]='1')  then Result := true;  //<  100 Ei enää käytössä 9.0.1
     'P' :if (o>=2)  and (s<>'') and (s [o-2 +1]='1')  then Result := true;  //<   10
     'X' :if (o>=1)  and (s<>'') and (s [o-1 +1]='1')  then Result := true;  end;// 1 case
end;
//............................................
function EiTUPraj :string;      begin Result := 'SFS 6000-A1/413.1.3.3- .5 = ' +CLR_BLB +'OK.' +FNT_B0;  end; //'-6.0.3

//===============================================================================================================
//===============================================================================================================
PROCEDURE tul_erit (os :integer);         LABEL 9;   VAR i,j,k :integer;  sc :string;

  function lisatietoJ1 {(str :string)} :string;      VAR sa :string;       begin
     sa := {str;}'';
     {if os>1  then }sa := sa +'Lisätietoa, <b>ks. JOHTO-OSA 1.</b>';
     Result := sa;
  end;

function UPS_huom :string;      begin  result := //<,,+6.0.3
         '<b>HUOM: </b>UPS-syötössä (eRs=eXs=eZs=0, vakiovirtasyöttö) johtoverkon impedanssit alkavat vaikuttaa '+
         '(pienentää) oikosulkuvirtoja vasta, kun Ik1v < liittymän (UPSin) Ik1v, vaikka laskennallinen '+
         '(todellinen) johtoverkon impedanssi onkin > 0. Tämä huomoidaan <b>vertailemalla laskennallista ja '+
         'ilmoitettuja virta-arvoja (tässä näytetään niistä pienempi) ja pätee myös Ik3v :lle.<b><br>';  end;
function fOik :string;      begin  Result := FONT_OIKEALLE;    end; //< Nuoli oikealle
function fVas :string;      begin  Result := FONT_VASEMMALLE;  end; //< Nuoli vasemmalle
function fOhm :string;      begin  Result := ' '+FONT_OMEGA;   end;
function fOhK :string;      begin  Result := fOhm + '/km';     end;
//===============================================================================================================
{     Tul_PrRj (1,edv.edka[os].r-yhmaJohto[1].rjpituus[1], 'Dz  16', 'Dz-tulppasulakkeella',      ' 0.4s => 110 A');
 => Dz  16	= 100.3 m    Dz-tulppasulakkeella (tarvittava Ik= 0.4s =>) 110 A ® 1.994483  W. A2/413.1.3.3- .5 = OK.
    ''s1''   '''''''''''s2'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''}
procedure TUPsel (TUPX :integer;  pit :real;  s1,s2 :string);      VAR sP,sX,s_ :string;          //9.0.1 uusittu.

 (*procedure parsiEdi (s :string);      VAR i,mja,br :integer;  su :string;      begin
      su := '';   mja := Length (s);
      for i := 1 to mja  do begin
         if s[i]='<'  then su := su +'{'  else
         if s[i]='>'  then su := su +'}'  else
                           su := su +s[i];              //,Vaihdetaan <br> takaisin, jotta rivi vaihtuisi aRich´ssä.
         br := Pos ('{br}',su);
         if br>0  then begin                                         //S := 'ABCDEF';
            Delete (su,br,4);                                        //S := Copy(S, 2, 3); { 'BCD' }
            su := Copy (su,1,br-1) +'<br>';  end;                    //'2=B,  3=BCD (=lkm)
      end; //'tai su := su +'<br>'  koska {br} delattiin mjonon lopusta.
      adStF (su);  end;*)

begin//TUPsel..................                         //adStF ('   s1=' +s1 +'<br>   s2=' +s2 +'<br>'); //<HYVÄ.
   sP := '';   s_ := '';
   if TUPon ('P',TUPX)  then sP := CLR_REB +'P' +FNT_B0;
   if (sP<>'')  and (pit>0.1)  then s_ := sP;            //<Ehto pit>0.01 koska joskus tulee P -herja vaikka 0 m.

   sX := '';
   if TUPon ('X',TUPX)  then sX := CLR_GRB +'X' +FNT_B0;
   if sX<>''  then begin                                 //<On P -virhe.
      if s_<>''  then s_ := s_ +', ';                    //<Välimerkki mahd. ed. "P" :n jälkeen.
      s_ := s_ +sX;  end;

   if s_<>''  then
      s_ := ' <t>' +s_ +'  '+'  ks. kuvaukset edellä.'; //< "ks. P,X selitykset edellä."
 //ad3SF (1,'jkD 10','=', '1234.5 m <t>D-tyypin js-katkaisijalla <t>(tarvittava Ik = <t>In×20 <t>1200 A <t>= 11.0970 W).Uusi 1 asTabXnSisB');
                                    //parsiEdi ('   s1=' +s1 +'<br>   s2=' +s2 +'<br>'); //<HYVÄ.
   ad3SF (1, s1+' ', '=', s2 +s_);  //<s1+' ' :n ' ' tarvitaan, jotta s1 :t pysyisivät linjassa alekkain.
end;//TUPsel
//---------------------------------------------------------------------------------------------------------------
{Nyt 9.0.1:    (,5aika,1demo,                     TUP/95.3, ,s1,,,,,  ,s2,,,,,,,,,,,,,,,,,,,,,,,,  ,s3,,,,   Ik);
      Tul_PrRj_(5,1,edv.edka[os].r-yhmaJohto[2].rjpituus[1], 'jkB 16', 'B-tyypin js-katkaisijalla', 'In×5 ',  80);
	jkB 16 	=	95.3 m   	B-tyypin js-katkaisijalla  	 (tarvittava Ik = In×5   	= 80 A 	= 2.74241 W).   A2/413.1.3.3- .5 = OK.
  's1'''      'pit''      's2''''''''''''''''''''''                       's3'       'Ik}
PROCEDURE Tul_PrRj_ (aika :real;  koe :integer;   rec :EdvRyhmaJohtoPituusType;  s1,s2,s3 :string;  Ik :real);
VAR pit :real;  upx,d :integer;  ss,efe,ef0 :string;                                     //'koe=0 =Tod.arvot aina.

   function fTabPit (pituus :real;  des :integer) :string;      VAR s,sp :string;  n,x :integer;
                                                                begin     //9.0.1: Tekee etutyhjät jotta tab osut-
      s := fRmrkt0 (pituus,1,des);   n := Length (s);  //,, 1234.1 = 6 mja         taisi oikein seur Str :lle.
      x := 6;   if n>x  then x := n;                   //<Kukin puuttuva merkki 6:sta vaatii 2 välilyöntiä, todettu.
      n := Trunc ((x-n-1) *1.5 +1);                    //< -1 ja +1 on desimPisteen tila.
    //if des=0  then n := n+3;                         //< 3 =desimPisteen + 1.desin tila.
      sp := '';
      if n>1  then                                     //??? Hoituisiko fPixPit :lla ??????
      for x := 1 to n  do
         sp := sp +' ';
      sp := sp +s;
      result := sp;  end;

begin//Tul_PrRj_..............
                             {if NOT PselOnJo  then begin adStF ('<f n="Courier New">Tul_PrRj_ alku='); //<,,HYVÄ.
                                 adStF ('   s1=' +s1 +'<br>   s2=' +s2 +'<br>   s3=' +s3);  end;//}
   with rec  do begin  pit := pituus;  upx := TUP;  end;                                //     =1 =Xxxx, jos Demo.
   if pit<0.1  then begin  d := 0;  efe := CLR_REB;  ef0 := FNT_B0;  end  //<,efe+ef0 +10.0.1
               else begin  d := 1;  efe := '';       ef0 := '';      end;
 //ss := fDemRx (koe,pit,1,d) +' m <t><t>';               //<, <t> +6.0.3
   if (koe>0)  and Demo(101)
      then ss := 'Xxx.x'
    //else ss := fTabPit (pit,d);
      else ss := efe +fRmrkt0 (pit,1,d);                  //<,efe+ef0 =+10.0.1
   ss := ss +' m <t>' +ef0 +s2 +'<t>(tarvittava Ik =<t>' +s3 +'<t>';
   if Trunc (Ik) < Ik  then d := 1                 //<Desimaaleja 1 jos Ik poikkeaa tasaluvusta, esim. 46.5 => d=1
                       else d := 0;
   ss := ss +fRmrkt0 (Ik,1,d) +' A <t>= ';
   if pit<0.1  then ss := ss +' -  -  -  -'               //<+10.0.1  =Ohmiarvoja ei ilmaista jos pit=0.
               else ss := ss +fRmrkt0 (a_getReaa (10100,edv.YLE.cU)*fUv / Ik, 1,4);
   ss := ss +fOhm +').   ';
   if pit<0.1
   then ss := ss +'SFS 6000-A1/413.1.3.3 = '  +CLR_REB +'eiOK.' +FNT_B0 //<+10.0.1  Kaikkia seuraavia vrtluja ei tarvitsisi.
   else if aika>1                                         //<,,5s :n rj:t
   then if pit>0.1
      then if upx=0
         then ss := ss +'SFS 6000-A1/413.1.3.3 = '  +CLR_BLB +'OK.  ' +FNT_B0
         else ss := ss +'SFS 6000-A1/413.1.3.3 = '  +CLR_REB +'eiOK.' +FNT_B0
      else    ss := ss +'SFS 6000-A1/413.1.3.3 = '  +CLR_REB +'eiOK.' +FNT_B0  //< = 0.0 m
   else if upx=0                                   //<,,0.4 s rj:  aika +9.0.1:  TUP tarkistettava vain 0.4 s:n rj:lle.
   then ss := ss +EiTUPraj                         //< "   SFS 6000-A1/413.1.3.3- .5 = OK."
   else ss := ss +'SFS 6000-A1/413.1.3.3- .5 = ' +CLR_REB +'eiOK.' +FNT_B0;
                             {if NOT PselOnJo  then begin //<,,HYVÄ.
                                 adStF (    'Tul_PrRj_:<br>   s1=' +s1 +'<br>   s2=' +s2 +'<br>   s3=' +s3);
                                 adStF (    'Kutsussa :<br>   s1=' +s1 +'<br>   ss=' +ss +'<br>  +s3=' +s3 +'#)');
                                 adStF ('Oli,,,,,,,,,,:<br>   s1=' +s1 +'<br>   ss=' +ss +'#)</f>');
                                 PselOnJo := true;  end;//}
   TUPsel (upx,pit, s1, ss);                       //<Tulostaa pitemmin jos ei _selOnJo, muuten str ss :n jatkoksi.
end;//Tul_PrRj_

   PROCEDURE Tul_PrRj5 (demo :integer;   rec :EdvRyhmaJohtoPituusType;  s1,s2,s3 :string;  Ik :real);      begin
      Tul_PrRj_ (5, demo,rec, s1,s2,s3, Ik);  end;

   PROCEDURE Tul_PrRj  (demo :integer;   rec :EdvRyhmaJohtoPituusType;  s1,s2,s3 :string;  Ik :real);      begin
      Tul_PrRj_ (0, demo,rec, s1,s2,s3, Ik);  end;
//===============================================================================================================
function fIk1v   (ar :real) :real;    begin
         if ar>0                           //<+6.0.3
         then Result := GcU * 3 * fUv / ar
         else result := 999999.999;  end;  //<+6.0.3
function fErrArv (ok,ar :real) :real;    begin  Result := (ar/ok -1)*100;     end;
function f_0     (ar :real) :real;    begin  Result := ar;
               //if (fRmrkt0 (ar,1,0)='0') and (ar<0)  then Result := -1 * ar;  end; //< -2.0.7
                 if (fMuokDes (ar,0)=0) and (ar<0)  then Result := 0;  end;    //<Jottei -0.049999 tulostuisi -0.0

procedure NjResr (Nriv :integer);      VAR sr :string; Lnj :real;  px,ei :integer;      begin
   with edv.edka[os].nousuJohto[Nriv]  do begin  Lnj := pituus;  px := TUP; //<sulake,mater,Amm2 jäljmpnä
   case Nriv of
      1 :sr := '<b>Nj ' +fPoiskAikaRajaS +'s asAsul</b>   = Johto-osan max.pituus annetuilla johto-osatiedoilla '+
            'asennustavalla ' +EdvNewFrm.BxAsT.Text +' laskettuna kuormitettavuuden korjauskertoimella 1.00 ja ' +
         fPoiskAikaRajaS +'s :n poiskytkentäajan </b>perusteella:';
      2 :sr := '<b>Nj ' +                '5s asAsul</b>   = Johto-osan max.pituus annetuilla johto-osatiedoilla '+
            'asennustavalla ' +EdvNewFrm.BxAsT.Text +' laskettuna kuormitettavuuden korjauskertoimella 1.00 ja ' +
                         '5s :n poiskytkentäajan </b>perusteella:';
      3 :sr := '<b>Nj ' +fPoiskAikaRajaS +'s MaxSul</b>   = Johto-osan max.pituus annetuilla johto-osatiedoilla '+
            'asennustavalla ' +EdvNewFrm.BxAsT.Text +' laskettuna kuormitettavuuden korjauskertoimella 1.00 ja ' +
         fPoiskAikaRajaS +'s :n poiskytkentäajan </b>perusteella:';
    else sr := '<b>Nj ' +fPoiskAikaRajaS +'s MaxSul</b>   = Johto-osan max.pituus annetuilla johto-osatiedoilla '+
            'asennustavalla ' +EdvNewFrm.BxAsT.Text +' laskettuna kuormitettavuuden korjauskertoimella 1.00 ja ' +
                         '5s :n poiskytkentäajan </b>perusteella:';  end;//case
       //KULUTTAJAn johto-osilla ' +fPoiskAikaRajaS +'s :n poiskytkentäajan ja SÄHKÖLAITOKSEN johto-osilla SULAKKEEN </b>perusteella:');
      ad1S_ (sr);
   sisB;
         sa := fDemIx (1,sulake,1) +' A <t>= Johdolle sallittu asennustavan ' +EdvNewFrm.BxAsT.Text +' mukainen '+
               'max.sulake';
         if NOT TUPon ('T',px)  then sa := sa +', jolla poiskytkentäaika ' +fPoiskAikaRajaS +' s vielä tässä '+
            'tapauksessa toteutuu';
       //sa := sa +'. Arvo on tarkistettu, että täyttää ZsIa -ehdon kuluttaja-asennuksissa.'; //<,..,6.2.21
        {if os>1
         then sa := sa +'.'
         else }{sa := sa +' JA on selektiivinen edellisten johto-osien max.sulakkeiden kanssa '+
                       'siten, että edeltävillä KULuttajan johto-osilla on selektiivisyys tarkistettu '+
                       'asennustavan A/'+fPoiskAikaRajaS +' s :n sulakkeen ja sen ZsIa -ehdon mukaan. Edeltävillä '+
                       'SÄHKÖLAITOKSEN johto-osilla tarkistus on tehty johdon max.oikosulkusuojan mukaan. '+
                       '     Selektiivisyysvalinnoista seuraa, että sulakearvo pienenee jokaisessa '+
                       'solmupisteessä vaikka esim. kuluttajan johto-osan jälkeen olisi sähkölaitoksen '+
                       'jakeluverkon osa (teoreettinen tilanne), jonka nollausehtojen mukainen max.sulake '+
                       'olisikin merkittävästi isompi.';}
         sa := sa +'. Selektiivisyystarkastelu jää käyttäjälle.';
      ad3SF (1,'maxSu','=',sa);
         sa := fMm2Des (Amm2,1);
         sa := sa +' mm²   <t>= Sulakkeen edellyttämä minimikaapeli ';
         ei := a_getIntg (1010110, edv.edka[os].Lukumaara);
         if ei>1  then sa := sa +IntToStr (ei) +'x';
         if mater  then sa := sa +'AMCMK'
                   else sa := sa +'MCMK';
      ad3SF (1,'mm² ',  '<t>=',sa);
         sa := fRmrkt0 (pituus,1,1) +' m <t>= Max.pituus';
         if px>0  then sa := sa +', rajoitukset :'
                  else sa := sa +':  '+EiTUPraj;
    //ad3SF (1,'Lmax','=',sa);
{&DEFINE TstAjo} //Ei worki käännettäessä eikä ajossa (& vaihdettava $ :ksi).
{TestiAjo
      TUPsel (px, ')');  LF; //< '' => ')' =+6.0.3 //Poista kommenttisulut}
      TUPsel (px, Lnj, 'Lmax ', sa);  LF; //<Tulostaa pitemmin jos ei _selOnJo, muuten str ss :n jatkoksi.
   end;//with
end;//NjResr
//===============================================================================================================
//,Tämä PRC PrRj_osuudet on 'VAR-osaa lukOttamatta siirretty 2.sta kutsukohdastaan, etsi "Siirretty PrRj_osuudet".
procedure PrRj_osuudet (ao :integer);      VAR m :integer;  Tkc,Ikc :real{+9.0.1};           //10.0.1 siirto tähän.
                                               rek :EdvPalstaType;                      begin
   LF;//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
sisVex;
   ad1SF ('<u><b>RESURSSITARKASTELUT  (solmupisteen Max.lähdöt/Sulakkeet/Pituudet) </u>:</b>'); //:::::::::
   ad1SF ('Jäljempänä esiintyvät <b>js-katkaisija = johdonsuojakatkaisija</b>.');
   if ao=-1  then begin                                            //<,,Esitetään vain yhden kerran 10.0.1
      LF;
      ad1SF ('<b>Käsinlaskentavihje:</b>    Lrj = [c×Uv×(IkEdv - IkSul) / (IkEd×IkSul)] / zrj,    '+
      'missä Lrj = ryhmäjohdon rajapituus,   c×Uv = 219.4 V (kun pääjännite on 400 V),   IkEdv = ryhmäjohdon '+
      'lähtöpisteen Ik1v,   IkSul = suojalaitteen ao. poiskytkentäajalla tarvitsema Ik1v (ks. oheiset '+
      'arvot:   tarvittava Ik=...)   ja zrj = ryhmäjohdon impedanssi pituusyksikköä kohti (2,5mm² = '+
      '16.59   ja 1,5mm² = 27.09 ohm/km).   Laskentamenetelmän virhe aiheutuu siitä, että mahd. '+
      'suurireaktanssisen edeltävän verkon johto-osan jatkoksi lasketaan lähes puhdas resistiivinen '+
      'ryhmäjohto-osa, eikä vaihekulmaeroja huomioida. Virhe on tässä verraten pieni, yleensä <1.0 m.   '+
      'Seuraavat max.ryhmäjohtopituudet on laskettu todellisilla impedanssikomponenteilla resistanssien '+
      'laskentalämpötilalla 50°C. Ilmoitettu (max.)impedanssi on laskettu:  Zk = <b>c×Uv/Ik.</b><br>' +
{  FUNCTION fZj (QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer): real; //<Yhtälölle: Ik1v = c*Uv/Ze
                                                                                     //'=KÄYTTÖ:  Vain Det10.INC}
      '<t><t>MMJ 2,5 mm²   20°C:   Zk = '+fRmrkt0 (fZj ('MMJ/MMK*',2,1000,  1,20), 1,5) +
                     '     50°C:   Zk = '+fRmrkt0 (fZj ('MMJ/MMK*',2,1000,  1,50), 1,5) +fOhm +' / km<br>' +
      '<t><t>MMJ 1,5 mm²   20°C:   Zk = '+fRmrkt0 (fZj ('MMJ/MMK*',1,1000,  1,20), 1,5) +
                     '     50°C:   Zk = '+fRmrkt0 (fZj ('MMJ/MMK*',1,1000,  1,50), 1,5) +fOhm +' / km.');
     {ad1SF ('<b>HUOM:</b>   Pistorasiaryhmäjohtojen pituudet on laskettu poiskytkentäaikavalinnan mukaan '+
             'vaikka ollessa <0.4 s, on pituudet laskettu xxxx'+}
   end else//if ao=-1
      ad1SF ('Käsinlaskentavihje, ks. viimeisen liittymän johto-osa.');                          //<10.0.1
      
   LF;
// ad1SF ('Jos varoitusmerkki '+CLR_REB+{'T,U,}'P'+FNT_B0 +' tai '+CLR_GRB +'X' +FNT_B0 +' esiintyy, on ao. '+
//        'SFS 6000-A1 / 413.1.3.5 :n kohta ja vaihtoehtoiset toimenpiteet selitetty. <b>Ehto tarkistetaan vain '+
//        fPoiskAikaRajaS +' s:n ryhmäjohdoilla.</b>');
   ad1SF ('<b>SFS 6000-A1 / 413.1.3.5 :n ehdon tarkistuksen tulokset:</b>  (tarkistetaan ehdon mukaan vain '+
          fPoiskAikaRajaS +' s:n ryhmäjohdoilla)');
   ad3SF (1,CLR_REB+{'T,U,}'P'+FNT_B0, '=', 'Ehto ei täyty. Se jouduttiin tarkastamaan KULuttajan johto-'+
          'osilla, koska verkkopisteiden sulakkeita ei tiedetä. Mikäli lähimmän pot.tasauksen (PT) ja ao. '+
          'jakokeskuksen välissä, joko alkuunpäin- tai loppuunpäin tutkien, on <b>suurempia sulakkeita kuin '+
          'kuvaajan rivillä 11 '+CLR_BLU +'"Suojausehdot sallivat":  MaxSul \.4s=XXX A  </f>JA jakokeskukseen '+
          'on saatettu liittää myös 5 s:n ryhmäjohtoja.</b>');
   ad3SF (1,'','', '   Jos ehto ei täyty, kohoaa kosketusjännite samaan <b>syöttävään </b>jakokeskukseen '+
           'liitetyissä <b>muissa ryhmäjohdoissa liian pitkäksi aikaa </b>vikatapauksessa >50 V :n, '+
           'jolloin potentiaalin nousemisen rajoittamiseksi potentiaalintasaukselle ja PE-johtimen '+
           'impedanssille on asetettu rajaehtoja (SFS 6000-A1/413.1.3.5). Koska tässä tapauksessa jakokeskuksen '+
           'yhteydessä ei ole potentiaalintasausta, ei Zpe saa olla > 50 × Zs / Uo, mikä ehto ei nyt täyty.');
   ad3SF (1,'','','   Tällaisessa tapauksessa on jakokeskuksessa käytettävä <b>lisäpotentiaalintasausta tai 5 '+
           's :n lähdöissä vikavirtasuojakytkintä.</b>');
   ad3SF (1,CLR_GRB+'X'+FNT_B0, '=', 'Ehto täyttyy vain verkossa jäljempänä olevaan pääpot.tasauspisteeseen '+
              '(PT) laskien (mahd. merkintätarve).');
   ad1SF (CLR_REB+'eiOK' +FNT_B0 +' rivin lopussa ilman selityksiä tarkoittaa, että poiskytkentäaika '+
          'ei toteudu millään ryhmäjohdon pituudella, eli L = 0 m.');

{ if IsDebuggerPresent  then begin
   //,Tässä kokeilen eroja asTabSisB :llä ennen ja jälkeen muutoksen.
   ad1SF ('');
   ad3SF (1,'jkD 10','=', '1234.5 m <t>\D-tyypin js-katkaisijalla <t>(tarvittava Ik = <t>In×20 <t>1200 A <t>= 11.0970 W).Ennen 1');
   ad3SF (1,'!','=', '!<t>!<t>!<t>!<t>!<t>X.Ennen 1 asTabXnSisB');
//  asTabXnSisB ('22\20x\@MMJ/MMK*\3200 mm2\SÄL\88888.8 m\300 °C\'+
// ,+9.0.1            'korj=10.888\-----------\-----------\-----------\-----------\-----------');  =malliksi
   ad3SF (1,'!','=', '!<t>!<t>!<t>!<t>!<t>X.Ennen 1 asTabXnSisB');
   ad3SF (0,'!','=', '!<t>!<t>!<t>!<t>!<t>X.Ennen 0 asTabXnSisB');
   ad1SF ('22\jkD 10  \= \1234.5 m  \D-tyypin js-katkaisijalla  \(tarvittava Ik = In×20  \1200 A  \= 11.0970 W).   ');//A2/413.1.3.3- .5
   //                       1          2                           3                 4       5        6
   asTabXnSisB ('jkD 10  \= \1234.5 m  \D-tyypin js-katkaisijalla  \(tarvittava Ik = \In×20  \1200 A  \= 11.0970 W).   ');//A2/413.1.3.3- .5
   ad3SF (0,'!','=', '!<t>!<t>!<t>!<t>!<t>X.Uusi 0 asTabXnSisB');
   ad3SF (1,'!','=', '!<t>!<t>!<t>!<t>!<t>X.Uusi 1 asTabXnSisB');
   ad3SF (1,'!','<t>=', '1<t>2<t>3<t>4<t>5<t>6<t>7<t>8X.Uusi 1t= asTabXnSisB');
   ad3SF (1,'jkD 10','=', '1234.5 m <t>D-tyypin js-katkaisijalla <t>(tarvittava Ik = <t>In×20 <t>1200 A <t>= 11.0970 W).Uusi 1 asTabXnSisB');
end;//if IsDebuggerPresent }

   asTabXnSisB ('jkD 10  \= \1234.5 m  \D-tyypin js-katkaisijalla  \(tarvittava Ik = \In×20  \1200 A  \= 11.0970 W).   ');//A2/413.1.3.3- .5
sisB;
Tkc := Edv.YLE.PRaika.arvoRea; //<0.4 s tai 0.2 s
sa := fRmrkt0 (Tkc,1,1);
   ad1SF ('(1/6) <b>Pistorasiaryhmäjohdon max.pituus, ' +sa +' s,  16A MMJ 2,5mm²:</b>');
               if edv.YLE.IecOfa.arvoBoo  then sc := su_IECg
                                          else sc := su_OFAg;
               if Tkc>0.21  then Ikc := 110
                            else Ikc := Ikt_R (sc,16,Tkc);         //<Ikt = f(PRaika (0.2 s))
               if ao<0  then rek := edv.Sorc[Abs(ao)].josa                                      //<,+10.0.1
                        else rek := edv.edka[ao];
                                       //[,]=PrRivi  ,1,=Vas. palsta  2=Oik. palsta
    //Tul_PrRj (1,rek.ryhmaJohto[1].rjpituus[1], 'Dz  16', 'Dz-tulppasulakkeella  '   , '0.4s =>', 110);
      Tul_PrRj (1,rek.ryhmaJohto[1].rjpituus[1], 'Dz  16', 'Dz-tulppasulakkeella  '   , ' ' , Ikc{110});
      Tul_PrRj (1,rek.ryhmaJohto[2].rjpituus[1], 'jkB 16', 'B-tyypin js-katkaisijalla', 'In×5 ',  80);
      Tul_PrRj (1,rek.ryhmaJohto[3].rjpituus[1], 'jkC 16', 'C-tyypin js-katkaisijalla', 'In×10', 160);
      Tul_PrRj (0,rek.ryhmaJohto[4].rjpituus[1], 'jkD 16', 'D-tyypin js-katkaisijalla', 'In×20', 320);
//..Pr 10 0.4s ..................................................................
   LF;
   ad1SF ('(2/6) <b>Pistorasiaryhmäjohdon max.pituus, ' +sa +' s,  10A MMJ 1,5mm²:</b>');
               if Tkc>0.21  then Ikc := 82
                            else Ikc := Ikt_R (sc,10,Tkc);
//    Tul_PrRj (1,rek.ryhmaJohto[1].rjpituus[2], 'Dz  10', 'Dz-tulppasulakkeella  '   , '0.4s =>', 82);
      Tul_PrRj (1,rek.ryhmaJohto[1].rjpituus[2], 'Dz  10', 'Dz-tulppasulakkeella  '   , ' ' , Ikc{82});
      Tul_PrRj (1,rek.ryhmaJohto[2].rjpituus[2], 'jkB 10', 'B-tyypin js-katkaisijalla', 'In×5 ',  50);
      Tul_PrRj (1,rek.ryhmaJohto[3].rjpituus[2], 'jkC 10', 'C-tyypin js-katkaisijalla', 'In×10', 100);
      Tul_PrRj (0,rek.ryhmaJohto[4].rjpituus[2], 'jkD 10', 'D-tyypin js-katkaisijalla', 'In×20', 200);
//==Rj 16 5s ====================================================================
   LF;
   ad1SF ('(3/6) <b>Kiinteän laitteen ryhmäjohdon max.pituus, 5 s,  16A MMJ 2,5mm²:</b>');
      Tul_PrRj5(1,rek.ryhmaJohto[5].rjpituus[1], 'Dz  16', 'Dz-tulppasulakkeella  '   , ' ' ,  65);
      Tul_PrRj5(1,rek.ryhmaJohto[6].rjpituus[1], 'jkB 16', 'B-tyypin js-katkaisijalla', 'In×4,6', 71); //<130.1: Oli 'In×5 ',  80);
      Tul_PrRj5(1,rek.ryhmaJohto[7].rjpituus[1], 'jkC 16', 'C-tyypin js-katkaisijalla', 'In×4,6', 71); //<130.1: Oli 'In×7 ', 112);
      Tul_PrRj5(0,rek.ryhmaJohto[8].rjpituus[1], 'jkD 16', 'D-tyypin js-katkaisijalla', 'In×4,6', 71); //<130.1: Oli 'In×7 ', 112);
//..Rj 10 5s ....................................................................
   LF;
   ad1SF ('(4/6) <b>Kiinteän laitteen ryhmäjohdon max.pituus, 5 s,  10A MMJ 1,5mm²:</b>');
      Tul_PrRj5(1,rek.ryhmaJohto[5].rjpituus[2], 'Dz  10', 'Dz-tulppasulakkeella  '   , ' ' , 46.5);
      Tul_PrRj5(1,rek.ryhmaJohto[6].rjpituus[2], 'jkB 10', 'B-tyypin js-katkaisijalla', 'In×4,6', 71); //<130.1: Oli 'In×5 ', 50);
      Tul_PrRj5(1,rek.ryhmaJohto[7].rjpituus[2], 'jkC 10', 'C-tyypin js-katkaisijalla', 'In×4,6', 71); //<130.1: Oli 'In×7 ', 70);
      Tul_PrRj5(0,rek.ryhmaJohto[8].rjpituus[2], 'jkD 10', 'D-tyypin js-katkaisijalla', 'In×4,6', 71); //<130.1: Oli 'In×7 ', 70);

//..Pr 10 2.5mm² 0.4s =========================================================== <,,+3.0.2
   LF;                m := rjohto_Max_9; //,902: j+1 nyt 9+1... Oli aikaisemmin 13...20. //Ikc edelleen voimassa,,.
   ad1SF ('(5/6) <b>Pistorasiaryhmäjohdon max.pituus, '+CLR_BLB +sa +' s,  10A MMJ 2,5mm²:' +FNT_B0 +'</b>');
    //Tul_PrRj (1,rek.ryhmaJohto[13].rjpituus[1], 'Dz  10', 'Dz-tulppasulakkeella  '   , '0.4s =>',  82);
      Tul_PrRj (1,rek.ryhmaJohto[m+1].rjpituus[1], 'Dz  10', 'Dz-tulppasulakkeella  '   , ' ' ,   Ikc{82});
      Tul_PrRj (1,rek.ryhmaJohto[m+2].rjpituus[1], 'jkB 10', 'B-tyypin js-katkaisijalla', 'In×5 ', 50); //< <t>=+9.0.1
     {Tul_PrRj (1,rek.ryhmaJohto[m+3].rjpituus[1], 'jkC 10', 'C-tyypin js-katkaisijalla', 'In×10',   100);
      Tul_PrRj (0,rek.ryhmaJohto[m+4].rjpituus[1], 'jkD 10', 'D-tyypin js-katkaisijalla', 'In×20',   200);}
//..Pr 10 2.5mm² 5s ============================================================= <,,+3.0.2
   LF;
   ad1SF ('(6/6) <b>Kiinteän laitteen ryhmäjohdon max.pituus, '+CLR_BLB +'5 s,  10A MMJ 2,5mm²:' +FNT_B0 +'</b>');
      Tul_PrRj5(1,rek.ryhmaJohto[m+5].rjpituus[1], 'Dz  10', 'Dz-tulppasulakkeella  '   , ' ' ,  46.5);
      Tul_PrRj5(1,rek.ryhmaJohto[m+6].rjpituus[1], 'jkB 10', 'B-tyypin js-katkaisijalla', 'In×4,6', 71); //<130.1: Oli 'In×5 ', 50); //< <t>=+9.0.1
      Tul_PrRj5(1,rek.ryhmaJohto[m+7].rjpituus[1], 'jkC 10', 'C-tyypin js-katkaisijalla', 'In×4,6', 71); //<130.1: Oli 'In×7 ', 70); //< <t>=+9.0.1
      Tul_PrRj5(0,rek.ryhmaJohto[m+8].rjpituus[1], 'jkD 10', 'D-tyypin js-katkaisijalla', 'In×4,6', 71); //<130.1: Oli 'In×7 ', 70); //< <t>=+9.0.1

//==Nj.4s asA================================================================
   LF;
end;//PrRj_osuudet

{procedure FileeseenRich;     begin end; {VAR txt :TextFile;  fn,si :string;  i :integer;      begin
   fn := gAjoPath +'_DetRvtRich.txt'; //C:\Projektit XE2\NolaKehi\BIN\_DetRvtRich.txt
   AssignFile(txt,fn);
   Rewrite(txt);
   for i := 0 to DetEvFrm.aRich.Lines.Count  do begin
      si := DetEvFrm.aRich.Lines[i];
      Writeln(txt,si);  end;
   Flush(txt);
   CloseFile(txt);
end;//}
{procedure Fileeseen (si :string);      begin end; {VAR txt :TextFile;  fn :string;  i :integer;      begin
   fn := gAjoPath +'_DetRvt.txt'; //C:\Projektit XE2\NolaKehi\BIN\_DetRvt.txt
   AssignFile(txt,fn);
   if fFileExists(fn)
      then Append(txt)
      else Rewrite(txt);
   Writeln(txt,si);
   Flush(txt);
   CloseFile(txt);
end;//}
//...............................................................................................................
//###############################################################################################################
{$I '..\GlobINC\DetEv-2.INC'}
//###############################################################################################################
BEGIN //tul_erit   Tähän tullaan vain os>=1... (=Edka -johto-osat) ja Sorc -osat hoidet, kun os=1.  6.2.2
DetEvFrm.aRich.Lines.Clear;                    //<+141.1:  Koko tulostus oli siftToRight ja tämä kosjasi sen, löytyi
if os>1                                        // sattumalta. Kokeiluun Fileeseen ja FileeseenRich.
   THEN LF; //:::::::::::::::::::::::::::::::::::: =Välirivi j-osien väliin. :::::::::::::::::::::::

if os=1    //,%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% if os=1 %%%%%
then BEGIN //,%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% if os=1 %%%%%
//DetEvFrm.aRich.Alignment := taLeftJustify; //+141.1  Ei worki; Kaikki oikealle !!!
      with edv.YLE  do begin
           Gtim := a_getReaa (10111,PoisAika);   //<Ks. korjaustarkistus jäljempnä:  IF NOT Gkul ...
         //Giec := a_getBool (10112,IecOfa);
           GUn :=  a_getIntg (10113,Un);
           GcU :=  a_getReaa (10114,cU);
      end;
      if demo(102) OR PRO_Demo  then adStF ('<b>(Esittelyversion luvunesitys :</b>    Eräät lasketut arvot '+
                                             'on korvattu  <b>DemoX</b> tai <b>Xxx</b>  -merkinnällä<b>)</b>');
      adStF ('<b>Tiedosto :</b>   '+EdvFilen);             //'DemoX = +8.0.0
//Fileeseen('1 ' +str);
      LF;
//Fileeseen('2 ' +str);
    //asTabSisB ('maxSu__=_'); //<Asettaa 1.sis=tabB(10) + 15xTab á10 + Sis.kohdan "maxSu__" +.. jälkeen
      asTabSisB ('maxSu'); //<Asettaa 1.sis=tabB(10) + 15xTab á10 + Sis.kohdan "maxSu__" +.. jälkeen
//Fileeseen('3 ' +str);
//,,,\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\,,,
      //str := str+ '<tab s="10,20,30,40">';                     //,,Ei LF, koska seur SIS tekee sen
      adSt_ ('<b>Laskentamenetelmät:</b>');
//Fileeseen('4 ' +str);
//FileeseenRich;
{DetEvFrm.aRich.Lines.Add(str);
DetEvFrm.aRich.Lines.SaveToFile(gAjoPath +'_DetRvtSaveTo 1.txt');
DetEvFrm.aRich.AddText(str);
DetEvFrm.aRich.Lines.SaveToFile(gAjoPath +'_DetRvtSaveTo 2.txt');}

//if str=''  then ;
//(*µ
  sisA;       //<Asetetaan 1. sisennyskohta = 1.tabC, JOKA JÄÄ VOIMAAN. TAB = Teksti alkaa 1.tabC :stä
      ad1SF ('Jäljempänä esiintyvät impedanssi- ja oikosulkuvirtayhtälöt perustuvat IEC 909 ja 746 :n '+
            'laskentaohjeisiin, mikä taas perustuu ns. symmetristen komponenttien menetelmään '+
            'ja on perusmuodossaan:');
      ad1SF ('     \1\     <u>I</u> = 3E / (<u>Z</u>1 + <u>Z</u>2 + <u>Z</u>0),   missä alaindeksit  1 = '+
            'myötä-,  2 = vasta-  ja 0 = nollakomponentti.   Koska pienjänniteverkossa ei yleensä tahtikoneita '+
            'ole/huomioida, on vastaimpedanssit saman suuruisia kuin myötäimpedanssit. Kun eo. ekvivalinttinen '+
            'virtalähde E korvataan piirin vaikuttavalla jännitteellä Uv ja kun huomioidaan jännitekerroin cU, '+
            'saadaan yhtälö muotoon:');
      ad1SF ('     \2\     I = cU×3×Uv/(2<u>Z</u>1 + <u>Z</u>0),   mikä impedanssilauseke purettuna '+
            'johtokomponentteihin (selitykset, ks. jäljempänä):');
      ad1SF ('     \3\<b>     Ze = '+FONT_2JUURI+'{Re ² + Xe ²}   =   '+FONT_2JUURI+
            '{[2Ry+2Rm+Rmo+2Rv+Rvo+3Rn] ² + [2Xy+2Xm+Xmo+2Xv+Xvo+3Xn] ²}</b>.   Yläverkon komponentit '+
            'huomioidaan kertoimella 2, koska 0-verkko ei voi muuntajan takia jatkua yläverkon '+
            'puolelle.   Pienjänniteliittyjälle');
      ad1SF ('     \4\<b>     Ze = '+FONT_2JUURI+'{Re ² + Xe ²}   =   '+FONT_2JUURI+
            '{[3eRs+2Rv+Rvo+3Rn] ² + [3eXs+2Xv+Xvo+3Xn] ²}</b>,   joilla');
      ad1SF ('     \5\<b>     Ik1v = cU×3×Uv/Ze</b>');
      ad1SF ('     \6\        Ik3v = E /<u>Z</u>1 = Uv / Zv');
      adStF ('     "SFS 6000-A1 käsittelee kuitenkin oikosulkupiirin '+
            'impedanssia termillä Zs, mitä ei ole tarkemmin eritelty.   413.1.3.3 (ZsIa'+FONT_PIENPI+
            'Uo)-ehto kuitenkin viittaa siihen, että oikosulkuvirta laskettaisiin lausekkeesta:   '+
            'Ik1v = cU×Uv/Zs,   jolloin oltaisiin oletettu 0-komponentti saman suuruiseksi kuin '+
            'myötä- ja vastakomponentit, eli IEC :n lausekkeesta supistuisi kolmoset pois.   '+
            '0-komponentit ovat yleensä samoja kuin myötä(- ja vasta)komponentit, mutta avojohdoilla, '+
            'AMKAlla ja erikoisjärjestelmillä näin ei ole, joten yleispätevässä yhtälössä niitä ei '+
            'voida poistaa, <b>ellei impedanssia käsitellä suureena, joka sisältää jakajan 3.   Tämän '+
            'takia NOLAssa ilmaistaan IEC :n mukainen impedanssi termillä Ze ja SFS 6000-A1 :n mukainen '+
            'impedanssi termillä Zs,   (eli Zs = Ze / 3).</b>');
      LF;
//    adStF ('<b>Edeltävän verkon laskentaparametrit ja selitykset :</b>');
      adStF (Pisteviiva ('Edeltävän verkon laskentaparametrit ja selitykset :'));
      ad1SF ('Uv = Un / '+FONT_2JUURI +'3,     Un = '+fImrkt0 (a_getIntg (10126,edv.YLE.Un),1) +
             '  '+fOik+'  Uv = '+fRmrkt0 (fUv,1,3)+'  '+fOik+'  Uo = '+fImrkt0 (fUo,1)+
             ',   cU = '+fRmrkt0 (GcU,1,3) );
      ad1SF ('Poiskytkentäaika kuluttaja-asennuksissa = '+fRmrkt0 (Gtim,1,1)+'s');
         sa := 'Sulaketyyppi = ' +suCse;
       //if Giec  then sa := sa+'IEC'  else  sa := sa+'OFAA';
      ad1SF (sa);
      //str := str+'';                                                   //<BreakPointilla str näkyy
      ad1SF ('Vaihelukumäärä = '+fImrkt0 (a_getIntg (10127,edv.YLE.VaiheLkm),1) +',   TN -järjestelmä');
      ad1S_ ('Yläverkon ja muuntajan impedanssikomponenttiarvot on <b>redusoitu alajännitepuolelle.</b>');  LF{141.1};
      //''Ei ad1SF, jossa LF, koska seur. sisB aiheuttaa LF:n, TODETTU #############################        ''LF koska seur. Ry=.. tuli tälle samalle rvlle.
sisB; ad3SF (1, 'Ry', '=','Suurjänniteliittyjän yläverkon oikosulkuresistanssi');
      ad3SF (1, 'Xy', '=','Suurjänniteliittyjän yläverkon oikosulkureaktanssi');
      ad3SF (1, 'eRs','=','Pienjänniteliittyjän liittymäpistettä edeltävän verkon oikosulkuresistanssi');
      ad3SF (1, 'eXs','=','Pienjänniteliittyjän liittymäpistettä edeltävän verkon oikosulkureaktanssi');
      ad3SF (1, 'eZs','=','Pienjänniteliittyjän liittymäpistettä edeltävän verkon oikosulkuimpedanssi, '+
                          '<b>jolla   Ik1v = cU×Uv/Zs</b>');
      ad3SF (1, '', '',   '<b>HUOM:</b>   Verkkoyhtiöltä on tarkistettava, ettei eZs -komponenteissa '+
                          'ole mukana kerrointa kolme, <b>jos on, on arvot jaettava 3 :lla ennen '+
                          'ohjelmaan syöttämistä</b>');
      ad3SF (1, 'Re', '=','Tarkasteltavan verkkopisteen resistanssi');
      ad3SF (1, 'Xe', '=','Tarkasteltavan verkkopisteen reaktanssi');
      ad3SF (1, 'Ze', '=','Tarkasteltavan verkkopisteen lausekkeen [3,4] mukainen impedanssi');
      ad1SF ('Rs,Xs,Zs = Tarkasteltavan verkkopisteen impedanssikomponentit SFS 6000-A1 :n mukaan, ks. teksti edellä');
      ad3SF (1, 'Rm', '=','Muuntajan oikosulkuresistanssi (myötä)');
      ad3SF (1, 'Rmo','=','Muuntajan nollaresistanssi');
      ad3SF (1, 'Xm', '=','Muuntajan oikosulkureaktanssi (myötä)');
      ad3SF (1, 'Xmo','=','Muuntajan nollareaktanssi');
      ad3SF (1, 'Rv', '=','Vaihejohtimen myötäresistanssi, peräkkäisten summa');
      ad3SF (1, 'Rvo','=','Vaihejohtimen nollaresistanssi, peräkkäisten summa');
      ad3SF (1, 'Rn', '=','PE/PEN-johtimen myötäresistanssi, peräkkäisten summa');
      ad3SF (1, 'Xv', '=','Vaihejohtimen myötäreaktanssi, peräkkäisten summa');
      ad3SF (1, 'Xvo','=','Vaihejohtimen nollareaktanssi, peräkkäisten summa');
      ad3SF (1, 'Xn', '=','PE/PEN-johtimen myötäreaktanssi, peräkkäisten summa');
      ad3SF (1, 'Kpe', '=','PE-johtimen huomiointikerroin (1=Koko Ik1v kulkee PE:ssä   0=PE-johdin ohittuu '+
                             'kokonaisuudessaan rakenteiden kautta, millä Ik1v kasvaa yleensä n. 62...67%).');

sisVex; //sisVex; //<Sis kokonaan vex = Oli sisB :ssa ################################################
      LF;   //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      ad1SF ('<b>Johtojen impedanssit luettelotiedoista :</b>');
      ad1SF ('Rv ja Rvo saadaan luettelotiedoista kohdasta "Vaihejohtimen vaihtovirtaresistanssi 20°C" ja Rn '+
            'kohdasta "PEN-johtimen resistanssi". Arvot tulee korjata laskentalämpötilaan kaavalla :');
      ad1SF ('     R = R20×(1 + '+FONT_ALFA+'×(Ta - 20)),   missä R20 on resistanssi '+
            'peruslämpötilassa 20°C, '+FONT_ALFA+' = 0.00403 <b>kaapelijohdin</b>alumiinille ja 0.00393 '+
            '<b>kaapelijohdin</b>kuparille. Kertoimet käsinlaskentaan, kun T 20°C '+fOik+' 80°C:  Kal = '+
            '1.2418  ja  Kcu = 1.2358.    <b>Huomaa, että varsinkin konsentrisen PE/PEN-johtimen '+
            'materiaali</b> poikkeaa useissa kaapelityypeissä äärijohtimien materiaalista.');
      ad1SF ('     Vaihtovirtaresistanssi ottaa huomioon pinta- ja lähivaikutukset, jolloin arvo on '+
            'tasavirta-arvoa hieman suurempi. Erot ovat häviävän pieniä laskentatarkkuuden puitteissa, '+
            'joten esim. vaihtovirtaresistanssin arvoja voidaan käyttää myös PE/PEN-johtimille (ja '+
            'päin vastoin).');
      ad1SF ('Xv saadaan luettelotietojen kohdasta "Induktanssi vaihetta kohden" kaavalla :');
      ad1SF ('     Xv = 2 '+FONT_PII+' f Lx [mH/km] /1000   ['+fOhK+']');
      ad1SF ('Xvo=Xv muilla paitsi AMKA, avojohtot, suurvirtajärjestelmät yms.   <b>Konsentrisilla '+
            'kaapeleilla Xn=0.  Yleensä Xn=Xv</b>, milloin PE/PEN-johdin on kerrattu äärijohtimien kanssa. '+
            'Vasta suurimmilla poikkipinnoilla em. arvoissa ilmenee hyvin pientä eroa, jolla ei '+
            'kuitenkaan kokonaisimpedanssiin ole näkyvää vaikutusta');

      LF;   //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      ad1SF ('<b>Rinnakkaisjohtojen impedanssit :</b>');
      ad1SF ('Kun kpl (=rinnakk.kaapelilukumäärä) '+FONT_SUURPI+' 2,   Lzmax = '+
            'kpl / (2 (kpl-1))×Ljohto, eli kun esim. kpl=4, maximi-impedanssipiste esiintyy '+
            'lähtöpisteestä lukien kohdassa, joka on 2/3 johto-osan kokonaispituudesta.   '+
            'Suurvirtajärjestelmillä käytetään suoraan järjestelmätoimittajan (NK-Energy Oy) tähän '+
            'tarkoitukseen erikoisesti ilmoittamia kertoimia.');
      ad1SF ('     Tästä seuraa, että kun johtoja on useita rinnakkain, saattaa seuraavan johto-osan minimi '+
            'oikosulkuvirta olla <b>suurempi</b> kuin edellisessä johto-osassa, koska seuraavan johto-osan '+
            'impedanssiin kytkeytyy edellisen johto-osan kaikki johdot rinnakkain loppupäässään, eikä sen '+
            'max.impedanssipisteessä!  Näin käy varsinkin, jos seuraavassa johto-osassa on vähemmän '+
            'rinnakkaiskaapeleita ja kyseessä on lyhyt johto-osuus verrattuna edelliseen.');
      ad1SF ('     Laskentamenetelmässä oletetaan oikosulun tapahtuvan yhden osajohdon vaihejohtimessa, '+
            'mikä antaa suurimman oikosulkuimpedanssin, koska kpl-1 rinnakkaisjohtimen kanssa sarjaan '+
            'kytkeytyy (vika)johtimen vikapaikan jälkeinen yhden johtimen impedanssi ja tämän '+
            'summaimpedanssin rinnalle kytkeytyy alkuosa vikajohtimen impedanssista');

      LF;   //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      ad1SF ('<b>Todelliset impedanssit ja suojajohtimen (PE) impedanssin ohittuminen :</b>');
      ad1SF ('Todellinen (esim. mittaamalla saatava) <b>Ik1v on yleensä laskettua suurempi</b>, koska mittaus'+
             'tilanteessa <b>resistanssien lämpötila </b>saattaa olla huomattavasti alhaisempi, jopa ''pakkasen '+
             'puolella'' ja lisäksi impedanssien nollakomponenttiin liittyy PE/PEN-johtimien <b>rinnalle '+
             'kytkeytyvät johtavat rakenteet</b>. Ohittumisen vaikutuksen max.arvo voidaan laskea siten, että '+
             '<b>Zn lasketaan nollaksi pääpot.tasauspisteen jälkeisessä verkon osassa.</b> Lämpötilan (0°C = '+
             '50%) ja suojajohtimien ohittumisen (n. 67%) yhteisvaikutus saattaa siten olla jopa yli 100% '+
             '(esim. em. 50+67=112%).  Huomaa, että jo suojamaadoitettujen, johtava-aineisten jakokeskusten, '+
             'valaisinten yms. kiinnittäminen johtaviin rakenteisiin synnyttää rinnakkaispiirin pääjohdon '+
             'PE/PEN-johtimelle (Zn :lle) ja <b>näin käy kaikissa (varsinkin kiinteiden laitteiden) '+
             'ryhmäjohdoissa.</b>');
      ad1SF ('     Kun pääjohto muodostuu '+FONT_SUURPI +' 2 rinnakkaisjohdosta, <b>max.impedanssipiste ei '+
             'esiinnykkään johdon loppupäässä. </b>Kuten edellä on kuvattu, tämä piste voidaan matemaattisesti '+
             'helposti laskea, mutta oikosulkuvirran mittaaminen ehjästä monijohtojärjestelmästä on mahdotonta '+
             'vaurioittamatta kaapelia. Tämän takia seuraavat minimioikosulkuvirta-arvot (<b>Ik1vo</b>) on '+
             'laskettu jakokeskukseen, jolloin laskemalla saatujen ja mitattujen arvojen vertailu on '+
             'yhteismitallista.');

      sa := 'Suojajohtimen ohittumisen aiheuttama <b>Ik1vo </b>ilmoitetaan seuraavissa laskelmissa <b>'+
            'ensimmäisen (pää)POT.TASAUKSEN jälkeisille</b> johto-osille.';

      LF;   //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      ad1SF ('Seuraavissa laskelmissa <b>Ik1vo</b> -arvoissa on huomioitu em. PE/PEN-johtimien ohittuminen '+
             'rakenteiden kautta eri Kpe -arvoilla. Kpe=1.0, kun koko oikosulkuvirta kulkee PE/PENin kautta, '+
             'eikä ohittumista tapahdu (IEC:n mukainen tilanne), eli Ik1vo=Ik1v. Ohittumista tapahtuu aina '+
             'myös vikapaikan jälkeisten maadoituspisteiden kautta, mutta ne on oletettu huomioiduksi '+
             'kertoimen arvossa Kpe.');
      ad1SF ('     Kun Kpe < 1.0, vastaa se todellista oikosulkutapausta, eli mittaamalla saatavaa arvoa '+
             'olettaen, että mittaamalla saatua impedanssia on kasvatettu tai oikosulkuvirtaa pienennetty '+
             'vastaamaan pahimman tilanteen mukaista resistanssien lämpötilaa (20°C'+fOik+'80°C n. 25%) ja '+
             'mittausmenetelmästä aiheutuvaa virhettä (ei ota huomioon reaktanssia, virhe jopa -78%).');
      ad1SF ('     PEn ohittumisen vaikutus on suurimmillaan verkon loppupäässä ja sitä isompi, mitä lähempänä '+
             'liittymäpistettä ensimmäinen PT sijaitsee. <b>Oikosulku on tässä aina laskettu tapahtuvaksi '+
             'jakokeskuksen kiskostossa, eikä siten välttämättä max.impedanssipisteessä (ks. edellä).</b>');
      ad1SF ('     <b>HUOM:</b>  Tämän laskentamenetelmän luotettavuus riippuu ohituskertoimen luotettavuudesta, '+
             'mistä ei vielä ole tutkittua tietoa. On oletettavaa, että rakennustyypin (teräs-/puurunko/rakenne), '+
             'rakennuksen ja LVI-/prosessitekniikan laajuuden sekä ohituskertoimen välillä on yhteys. Tätä '+
             'algoritmia kehitetään sitä mukaa kun luotettavaa, tutkittua tietoa tulee julki.');
      LF;   //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      ad1SF ('<b>Suhtaudu toistaiseksi varauksella alla oleviin Ik1vo -arvoihin. Seuraa näitä tietoja ja, jos '+
             'mahdollista, vertaa niitä mitattuihin arvoihin.  HUOM: Jäykässä verkossa mitatut arvot ovat '+
             'epäluotettavia, ne ovat jopa viisinkertaisia todellisiin verrattuna. Virhe johtuu '+
             'mittausmenetelmästä,</b> kuten edellä on kuvattu.');

      LF;//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      k := fPEkEkaJ;       //< Johto-osan [k] lopussa, joten eka edj, jolle voidaan laskea PE:n ohitus on k+1
    //if a_getIntg (10150, edv.YLE.JohtoOsia) =0  then begin
      if k<0  then begin
         ad1SF ('<b> Tästä verkkorakenteesta ei löydy PT:tä tai sen jälkeistä verkon osaa </b>(Ik1vo :ta '+
                'ei voida laskea).');
         LF;  end;//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

      ad1SF (CLR_REB +'Käsikirja D1 :n laskentamenetelmä :' +FNT_B0);
      ad1SF ('<b>D1 :n taulukosta nähdään jo silmämääräisesti, että se soveltuu '+
            'kuluttaja-asennuksiin nykykäytännössä vain harvoissa tapauksissa:  nykyäänhän 3/5-'+
            'johdinasennukset ovat vallitsevia ja niissä PE-johdin on yleisimmin puolet vaihejohtimen '+
            'poikkipinnasta, jolloin sen resistanssikomponentti on suuruusluokaltaan KAKSINKERTAINEN '+
            'vaihejohtimiin verrattuna.');
      ad1SF ('     Kun lisäksi huomataan (ks. aikaisemmat impedanssilausekkeet), että '+
            'konsentrisilla kaapeleilla, jotka ovat vallitsevia niin uudis- kuin olemassa olevasta '+
            'asennuskannasta, PE-johtimen reaktanssi Xn=0 ja kun PE-johdin on kerrattu, on Xn=Xv, '+
            'mistä yksistään aiheutuu jo suuruusluokaltaan n. 25%:n virhe, joten näin pelkistettyä '+
            'impedanssitaulukkoa ei voida tehdä kaikkia johto- ja verkkotyyppejä kattaviksi. Kun lisäksi '+
            'ohjeet eivät sisällä kuvausta, kuinka PEN/PE -johtimen impedanssit tulisi huomioida, lopputulos '+
            'on tältäkin osalta käyttäjänsä oivallusten varassa.');
      ad1SF ('     Lisäksi esitetyt impedanssiarvot eivät ole samoja minkään kaupallisen, '+
             'nykyisin Suomessa saatavilla olevan kaapelityypin arvojen kanssa, koska ne on määritetty '+
             'johtavuusarvojen perusteella. Kaapelistandardit määrittelevät tarkasti johdinresistanssien '+
             'arvot, avojohdoissa on käytössä em. johtavuusarvot.</b> Impedanssieroista tarkemmin, ks. '+
             'Päävalinta / Impedanssit');
      LF;//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      ad1SF (CLR_BLB +'Mitä tehdä, jos suojausehdot eivät täyty :' +FNT_B0);
      ad1SF ('Määräykset edellyttävät vikavirtapiirin mittaamista, <b>mikäli käytettävissä '+
            'ei ole "laskelmaa vikavirtapiirin impedanssista"</b>, mutta ei määrittele mittaustapahtuman '+
            'perusvaatimuksia riittävästi.   Tästä seuraa väistämättä, että mitatut impedanssit ovat '+
            'selkeästi pienempiä kuin esim. 80°C :ssa määritetyt laskennalliset impedanssit.   Jos '+
            'laskentatulokset osoittavat, että esim. haluttua sulakekokoa joudutaan suojausehtojen takia '+
            'pienentämään enemmän kuin käyttötarve edellyttäisi, '+CLR_REB +'voidaan joissain tapauksissa '+
            'määräystenkin mukaan selvitä seuraavilla vaihtoehtoisilla tavoilla:'+FNT_B0);
      ad1SF ('-   "Syötön automaatisen poiskytkennän toiminnan" (SFS 6000-A1 / 612.6) '+CLR_REB +
            'tarkistaminen suoritetaan mittaamalla, '+FNT_B0+'jolloin mittaustilanteen alhaisemmat '+
            '<b>resistanssin lämpötilat, testereiden käyttämän induktanssin tunnistamattoman mittaustavan sekä '+
            'rakenteiden kautta tapahtuvat suojajohtimen ohittumiset </b>(merkittävä tekijä) antavat yleensä '+
            'ratkaisevasti pienemmät impedanssiarvot. <b>Jakokeskustasolla tehdyt mittaukset antavat mittarien '+
            'käyttämän menetelmän takia jopa '+CLR_REB +'VIISINkertaisia virta-arvoja' +FNT_B0 +'</b> '+
            'todelliseen verrattuna, ryhmäjohtojen ääripituuksilla mittausarvot ovat verraten tarkkoja.   '+
            'Jäljemmässä tulostusosassa on laskettu myös testereiden näkemät minimioikosulkuvirran arvot '+
            CLR_REB +'Ik1vm.'+ FNT_B0);
      ad1SF ('-   Tehdään "laskelmat vikavirtapiirin impedanssista" '+CLR_REB +'D1 :n mukaan '+
            'laskien, jolloin saadaan parhaimmillaan n. 57 % pienemmät impedanssit.   Tällä saavutetaan '+
            'joskus jopa KAHDEN sulakeportaan etu' +FNT_B0);
      LF;//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

      k := a_getIntg (10131, Edv.YLE.SorceCount);
        adStF (COLOR_BLUE +Pisteviiva ('LIITTYMÄTIEDOT :') +FNT_B0);
        adStF ('Liittymiä ' +IntToStr(k) +' kpl.');
      LF;//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      for i := 1 to k  do begin
         j := a_getIntg (10131,Edv.Sorc[i].src.SorceKind);         //< 1=Transformer  2=LV-Cable  3=Generator  4=UPS
         case j of
         1 :ediSj  (-1*i);  //< 1=Transformer
         3 :ediGen (-1*i);  //< 3=Generator
         4 :ediUPS (-1*i);  //< 4=UPS
         else begin         //< 2=LV-Cable
         //adSt_ (Pisteviiva ('Pienjänniteliittymä :'));           //<Ei LF, koska seur SIS tekee sen. -8.0.0
           adStF ('<b><u>N:o 0' +IntToStr (i) +' Pienjänniteliittymä :</u></b>'); //<Tässä halutaan ylimäär. LF
              r8 := a_getReaa (10132,Edv.Sorc[i].src.Iks1v)*1000;
sisB;      ad3SF (1,'Ik1v', '=',fRmrkt0 (r8,1,0) +' A');
              a8 := a_getReaa (10133,Edv.Sorc[i].src.Iks3v)*1000;
           ad3SF (1,'Ik3v', '=',fRmrkt0 (a8,1,0) +' A');
              r8 := a_getReaa (10134,Edv.Sorc[i].src.pjLiitRs);
           if r8>0  then  j := d1  else j := 0;                //<,,if ..+6.0.3
           ad3SF (1, 'eRs', '=',fRmrkt0 (r8,1,j)+ fOhm);
              a8 := a_getReaa (10135,Edv.Sorc[i].src.pjLiitXs);
           ad3SF (1, 'eXs', '=',fRmrkt0 (a8,1,j)+ fOhm);       //<' i = Des  +6.0.3
              ar := Sqrt (Sqr(r8) + Sqr(a8));
              sa := '';
              if ar=0  then sa := ' (<b>0 = VakiovirtaUPS-syöttö).</b>';//< Täyd. +6.0.3
           ad3SF (1, 'eZs', '=',fRmrkt0 (ar,1,i)+ fOhm +sa);   //<' i = Des  +6.0.3
         //ad3SF (1, '', '',   '<b>HUOM:</b>   Verkkoyhtiöltä on tarkistettava ennen ohjelmaan syöttöä, '+
           ad1S_ ('<b>HUOM:</b>   Verkkoyhtiöltä on tarkistettava ennen ohjelmaan syöttöä, '+
                 'ettei eZs -komponenteissa ole mukana kerrointa <b>kolme, jos on, on arvot jaettava 3</b> :lla.');
              r8 := iks (Ik3vFA, 0, Ziks (12,0,NJkinFA,0, '',0,0,0,0, rr,rr,rr,rr)); //< 1 => 12 =MaxZ 6.2.18
           LF;                  //<',, +6.0.3
           if ar>0  then        //<ar sai arvon Sqrt (...) edellä
           ad3SF (1,'Ik1v', '=',fRmrkt0 (r8,1,0) +' A   laskettuna annetun impedanssikomponetin eRs ja '+
                 'siitä lasketun eXs perusteella.   Mikäli laskettu arvo eroaa ilmoitetusta, on joko '+
                 'annetut impedanssitekijä (eRs) tai oikosulkuvirta-arvo (Ik1v) virheellisiä. Tämä '+
                 'tarkistetaan jo tietojen syöttövaiheessa (tarkkuusvaatimus +/- 1%).');
           ad1S_ (UPS_huom);                                   //<+6.0.3
           ediJohtoDet (-1*i);                                 //<+8.0.0  -1*=+10.0.1: Ei ohjautunut liittymäjohtoon, nyt OK.
         end;{case else}  end{+10.0.1};//case                   2.end =+10.0.1
       //LF;//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::-10.0.1
      end;//for i := 1 to k   (k=SorceCount)
//end;//if os>1 else  = os=1 EHTO UUSITTU os=1. Ed. case´en END´in lisäyksen jälkeen tämä rv kommentoitu vex.-10.0.1

      k := Edv.YLE.SorceCount.ArvoInt;
      PrRj_osuudet (-1*k); //Vikan liittymäjohdon JÄLKEISEN pisteen PrRjResurssit. +10.0.1

//###############################################################################################################
//###############################################################################################################
adStF (Pisteviiva ('JAKELUVERKKO :'));
if a_getIntg (10114,edv.YLE.JohtoOsia) =0  then begin
   adStF ('   Jakeluverkon johto-osia ei ole!');
   GOTO 9;  end; //<################################################################################
{     asTabXnSisB ('MM\MM\@MM\MM');
sisB;
      ad3SF (1,'1','2','3'+tab1+'4'+tab1+'5'+tab1+'6'+tab1+'7'+tab1+'8'+tab1+'9-kokeilua AD3SF:llä, '+
            'josko jakaisi sisB:hen. Xxxx xxxxxxxxx xxxxxxxxxxxx xxxxxxxxxx.');
      ad1SF ('1'+tab1+'2'+tab1+'3'+tab1+'4'+tab1+'5'+tab1+'6'+tab1+'7'+tab1+'8'+tab1+'9-kokeilua AD1SF:llä, '+
            'josko jakaisi sisB:hen. Xxxx xxxxxxxxx xxxxxxxxxxxx xxxxxxxxxx.'); //<'AD1SF ja AD3SF samanlaisia
sisVex; sisVex;}

             {sisA, tab, sisB,@(eipakko)   ,....tab...,....., jne...<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                  ,10  ,24   ,41           ,90         ,131  ,150         ,190     ,216}
      {asTabXnSisB ('22__\20x__\@MMJ/MMK*____\3200 mm2___\SÄL__\88888.8 m___\300 °C__\'+
                    'korj=10.888____\-----------\-----------\-----------\-----------\-----------');}
      asTabXnSisB ('22\20x\@MMJ/MMK*\3200 mm2\SÄL\88888.8 m\300 °C\'+
                   'korj=10.888\-----------\-----------\-----------\-----------\-----------');
sisB;            //''Ei riitä tab -leveydet, vrt. seur. testi ######################################
     {ad1SF ('22'+tab1+'20x'+tab1+'MMJ/MMK*'+tab1+'3200 mm²'+tab1+'KUL'+tab1+'88888.8 m'+tab1+
            '300 °C'+tab1+'korj=10.888'); //<'Hyvä testi}
         k := a_getIntg (10115,edv.YLE.JohtoOsia);
      for j := 1 to k  do
         ad1SF (fImrkt0 (j,2) +' ' +tab1 +ediJohto (edv.edka[j], tab1)); //< =1    20 x AMCMK....

        {ad1SF ('aRich.Width = '+fImrkt0 (DetEvFrm.aRich.Width,1)); //<fMrkPix :n kokeilua<<<<<<<<<<
         adStF ('Ik3v = 21432.9 A = yleensä pienempi kuin '+
               'häviösarjan 1 arvoilla, minkä takia :');
         ad1SF ('Ik3w...fMrkPix = '+fImrkt0 (fMrkPix ('Ik3v = 21432.9 A = yleensä pienempi kuin '+
               'häviösarjan 1 arvoilla, minkä takia :'),1));}
sisVex; sisVex;
      LF;//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      //esitaProgres ('Johdot:  ',1);
      esitaProgres ('Johdot (1..'+fImrkt0 (a_getIntg (10141,edv.YLE.JohtoOsia),1) +
                    ') :  Yle',1);    //Tämäkin vain, kun os=1 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
END;//if os=1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% if os=1 %%%%%
    //'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% if os=1 %%%%%

   with edv.edka[os]  do begin
        if not OnArvot  then GOTO 9; //<############################################################
        Gkul :=    a_getBool (10142,kuluttaja);
        if not Gkul  then Gtim := 15;                       //<Varm.vuoksi<<<<<<<<<<<<<<<<<<<<<<<<<<
        Gpt :=     a_getBool (10143,PTlopussa);
        Gtyp :=    a_getStrg (10144,tyyppi);
        Gmm2 :=    a_getReaa (10145,Amm2);
        Gkpl :=    a_getIntg (10146,lukumaara);
        Gpit :=    a_getReaa (10147,pituus);
        Glampot := a_getIntg (10148,lampotila);
        Gkorj :=   a_getReaa (10149,korjaus);
        GKpe :=    a_getReaa (10149,PEker);
   end;
//,,,\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\,,,
//###############################################################################################################
//###############################################################################################################
// asTabSisB ('maxSu__=_'); //<Asettaa 1.sis=tabB(10) + 15xTab á10 + Sis.kohdan "maxSu__" +.. jälkeen
   asTabSisB ('maxSu'); //<Asettaa 1.sis=tabB(10) + 15xTab á10 + Sis.kohdan "maxSu__" +.. jälkeen
   adSt_ (COLOR_BLUE+Pisteviiva ('JOHTO-OSAN  N:o  ' +fImrkt0 (os,1) +' TIEDOT :') +FNT_B0);
sisA;                                                          //' </f> = värimäärityksenkin lopetus
   if NOT ediJohtoDet (os)  then GOTO 9;
sisVex;
//###############################################################################################################
//###############################################################################################################
   ad1SF ('<b>Katkaisija-asetuksiin vaikuttavat tekijät, oikosulkusuojaus :</b>'); //:::::::::::::::
   ad1S_ ('Katkaisija-asetukset on laskettu oletuksella, että rinnakkaiskaapelit on suojattu '+
         'yhteisellä katkaisijalla.');
sisB;
      ar := Ik1v*0.8;
   ad3SF (1, 'OikS','=',fDemRx (1,ar,1,1)+' A   = Katkaisijan asetusarvo (Img) johdon '+
         'oikosulkusuojaukseen = 0.8×Ik1v ('+fRmrkt0 (Ik1v,1,1)+' A).');
if os=1  then begin
   ad3SF (1,'','','     Mikäli jäljempänä laskettavat <b>Ia tai Iksal</b> -arvot ovat pienempiä kuin '+
         'esitetty OikS -arvo, korvataan se pienimmällä määräävällä tekijällä. Sähkölaitoksen '+
         'jakeluverkon Iksal -arvo redusoidaan 5 s :n arvoksi, mikä vastaa paremmin verkkoyhtiöiden '+
         'käytäntöä. Rinnakkaiskaapeleissa kunkin osajohdon tulee kestää Iksal, joten rinnakkaiskaa'+
         'pelilukumäärä ei vaikuta tähän arvoon.');
   ad3SF (1,'','','     Määräysten SFS 6000-A1 / 413.1.3.3  s.53 mukaan  <b>Zs×Ia  saa olla KULUTTAJA-'+
         'asennuksissa enintään = Uo</b>, (Un='+fImrkt0 (GUn,1)+ ' '+fOik+' Uo='+fImrkt0 (fUo,1)+ ' V) :');
   ad3SF (1,'','','     Yhtälö voidaan muuntaa muotoon   Uo/Zs = Ia.  Jos Ia on pienempi kuin edellä '+
         'esitetty OikS (=0.8×Ik1v), on se määräävä ja OikS :n arvo korvataan Ia :lla');
end else
   ad3SF (1,'','','     '+lisatietoJ1);
      Zs := fZs (12,os,2,NJkinFA, '',0,0,0,0,  Rs,Xs,rinKer,Ls);  //< rinKer =TotZ :n kerroin.  2=PEker=EiHuomioid,EhkeiVäliä
      rr := fUo/Zs;
      sa := fRmrkt0 (rr,1,1)+' A   = Uo/Zs  ';
      if ar <= rr
      then begin sa := sa+ '>  OikS, joten ZsIa -ehto ei vaikuta katkaisijan Img -asetukseen.';
                 if not Gkul  then sa := sa+ ' Koska kyseessä on SÄHKÖLAITOKSEN jakeluverkkoon kuuluva '+
                                   'johto-osa, ei määräyksen täyttymisellä olisikaan merkitystä.';  end
      else begin sa := sa+ FONT_PIENPI+'  OikS,   joten katkaisijan Img -asetus määräytyy ZsIa -ehdon perusteella';
                 if Gkul  then sa := sa+ ', minkä takia OikS -arvona on ilmoitettu Ia :n arvo.'
                          else sa := sa+ '. Koska kyseessä on SÄHKÖLAITOKSEN jakeluverkkoon kuuluva '+
                                         'johto-osa, ei määräyksen täyttymistä vaadita.';  end;
   ad3SF (1, 'Ia','=',sa);
   ad3SF (1,'','','     ZsIa -ehdon vaikutus Img -asetukseen, ks. <b>"Sulakkeiden valintaan vaikuttavat '+
         'tekijät"</b> edellä');

      ar := Iksalterm (Gtyp,Gmm2);  //< ar
   ad3SF (1, 'Iksal' ,'=',fRmrkt0 (ar,1,0)+' A   = Johdon terminen oikosulkukestoisuus (1 s).   '+
         'Mikäli tämä arvo on pienempi kuin OikS, ilmoitetaan OikS :n arvona Iksal :n arvo');
      rr := ar/Sqrt (5);            //< rr
   ad3SF (1, 'Iksal5','=',fRmrkt0 (rr,1,0)+' A   = Johdon terminen oikosulkukestoisuus redusoituna '+
         '5 s :iin lausekkeella  Iksal / '+FONT_2JUURI+ '5.   '+
         'Mikäli tämä arvo on pienempi kuin OikS, ilmoitetaan OikS :n arvona Iksal5 :n arvo '+
         '(sähkölaitoksen jakeluverkossa)');
      if Gkul  then r8 := ar  else r8 := rr; //< r8 -arvo NYT VARATTU, ks. jäljmpnä R8=R8=R8=R8=R8=R8=R8=R8
                                             //' := ar,rr <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      r7 := edv.edka[os].arvo [arvo_KAT_AIKA_14];
      j := 2;   if r7<1  then j := 3;
      sa := '';
        if r7<0.2  then sa := CLR_REB;
      sa := sa +fRmrkt0 (r7,1,j)+' s';
        if r7<0.2  then sa := FNT_B0;
      sa := sa +'   = (t Max_Ik3v';   if NOT Gkul  then sa := sa +',  Iksal5 mukaan';
      sa := sa +')  Suurin sallittu katkaisijan aika-asetus laskettuna johto-osan <b>alun Ik3v :lla</b>'+
            ' johdon termisen ominaisuuden perusteella (yli 5 s :n arvoihin tulee suhtautua varauksella, '+
            'vrt. kaapelivalmistajien ohjeet).';
        if r7<0.2  then sa := sa +CLR_REB +'   Huomaa verraten lyhyt laukaisuaikavaatimus < 0.2 s!'+
           FNT_B0 +', joka saattaa olla </b> '+CLR_REB +'määräävä '+FNT_B0 +'<b>(pienempi kuin esim. '+
           'kuluttaja-asennusten valittu poiskytkentäaika).</b>';
   ad3SF (1, 't_Max','=',sa);
if os=1  then begin
   ad3SF (1,'','','     t_Max = (IkSal/Ikmax)²/(m+n),   missä m = Ik3v:n tasavirtatekijä ja   n = '+
         'vaihtovirtatekijä.   m = {1 / [2 f t ln('+FONT_KAPPA+'-1)]} × [exp(4 f t ln('+FONT_KAPPA+
         '-1) -1].   '+FONT_KAPPA+', ks. <b>"Ik3v :n minimi - impedanssipisteen tekijät"</b> edellä.');
   ad3SF (1,'','','     // exp( ) = e potenssiin( ) //.');
   ad3SF (1,'','','     Kun R/X > 1, sysäyskertoimeksi ('+FONT_KAPPA+') tulee 1.0 .'+{, josta määritettynä '+
         'm = 0 (pitkilläkin katkaisuajoilla) ja } 'Kun alku- ja jatkuvan tilan oikosulkuvirtojen suhde '+
         'Ik3v"/Ik3v = 1, on vaihtovirtatekijä n = 1.0, jolloin alkuperäinen lauseke saadaan muotoon  '+
         't_Max = (IkSal/Ikmax)² / (m+1).');
end else
   ad3SF (1,'','','     '+lisatietoJ1);

   ad3SF (1,'','','     Kun suojaus toteutetaan tämän max.aika-asetuksen mukaan, ei kolmivaiheinen '+
         'oikosulku pysty lähelläkään johdon alkupäätä sattuessaan vaurioittamaan kaapelia, ks. seur.');

     {a7 := iks (Ik3vTR, Ziks (3,os,FALSE,'',0,0,0,0, a3,a3,a3,a3)); //Ik3v [os], eo. t_Max oli Ik3v[os-1]  -6.0.0
      r7 := Tekv (r8,a7);   //< r8=Iksal 1s/5s, NYT VAPAA, ks. ylempänä R8=R8=R8=R8=R8=R8=R8=R8=R8=R8=R8=R8}
      r7 := Tekv_mn (os,0,NJkinFA);       //< os=TypOsMukaan (ei väliä NJllä),tamaIK,NJkin. os=Tässä johdnLoppuun
      j := 2;   if r7<1  then j := 3;     //'+6.0.0
      sa := fRmrkt0 (r7,1,j)+' s   = ';   if NOT Gkul  then sa := sa +'(Iksal5) ';
      sa := sa +'Suurin sallittu katkaisijan aika-asetus kuten edellä, mutta laskettuna johto-osan '+
            '<b>lopun Ik3v :n mukaan</b>.   Jos suojaus toteutetaan tämän max.aika-asetuksen mukaan, '+
            'saattaa 3-vaiheinen oikosulku johdon alkuosassa vaurioittaa kaapelia.';
   ad3SF (1, 't_Max','=',sa);
   LF; //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
sisVex;
   ad1SF ('<b>Katkaisija-asetuksiin vaikuttavat tekijät, ylivirtasuojaus :</b>'); //::::::::::::::::
   ad1S_ ('Asetusarvot (Iterm) johdon ylivirtasuojauksessa eri asennustavoilla :');
sisB;                                              //,,AR palauttaa asetusarvon ####################
      sa := YvSuo (1,1, {'G'}suCse,TRUE,TRUE,'A',Gkorj,Gtyp,Gmm2,Gkpl,ar);//<Dem(1),Eritt(1),YhteisSuoja,Katkais
   ad3SF (1,'asA','=',fRmrkt0 (ar,1,1) +' A   ' +fVas +'  '+ sa);
      sa := YvSuo (1,1, {'G'}suCse,TRUE,TRUE,'C',Gkorj,Gtyp,Gmm2,Gkpl,ar);//<Dem(1),Eritt(1),YhteisSuoja,Katkais
   ad3SF (1,'asC','=',fRmrkt0 (ar,1,1) +' A   ' +fVas +'  '+ sa);
      sa := YvSuo (0,1, {'G'}suCse,TRUE,TRUE,'D',Gkorj,Gtyp,Gmm2,Gkpl,ar);//<Dem(1),Eritt(1),YhteisSuoja,Katkais
   ad3SF (1,'asD','=',fRmrkt0 (ar,1,1) +' A   ' +fVas +'  '+ sa);

PrRj_osuudet (os); //Johto-osuuksien PrRjResurssit. Siirretty PRC PrRj_osuudet.
sisVex;
   sa := '<b>Seuraavilla riveillä on laskettu max.pituudet annetulla johdolla asennustavan ' +
         EdvNewFrm.BxAsT.Text +' sekä suojausehtojen sallimalla Max.sulakkeella.<b> Arvot kuvaavat, kuinka '+
         'pitkä annettu johto-osa voi olla:';
   ad1SF (sa);
   LF;
NjResr (1);                                                                                    //<,,6.2.21
//..Nj5s asA.................................................................
sisVex;
//==Nj.4s OikS===============================================================
sisVex;
NjResr (2);
//==Nj.4s OikS===============================================================
sisVex;
NjResr (3);
//..Nj5s OikS................................................................
sisVex;
NjResr (4);

   if os=1  then sa := '+'  else sa := ',';
   sa := sa + fImrkt0 (os,1);
esitaProgres (sa, os+1);    //<esitaProgres kasvattaa merkkijonoa (sa):  Johdot: Yle+1,2,3,4... jne.
//µ*)
//end; //µ
9:
//Fileeseen('99 ' +str);
END;//tul_erit
//==================================================================================================
{Ohan kulku:   DetEv-1.INC:  1. tul_eritEdv
                             2. erittele
                             3. tul_erit
               DetEv-2.INC:  ediJohtoDet  ediSj  ediGen  ediUPS}
procedure erittele;      var ao,i :integer;      begin//<,,Tämä hoitaa koko Det editoinnin:  for i := ...
   sisAstr := '';   sisBstr := '';
   DetEvFrm.aRich.Clear;
   ao := a_getIntg (10199,edv.YLE.JohtoOsia);
   if ao=0  then ao := 1;                           //<,Jos eioo johto-osia, TUL_ERITOK:ssa ohari
//DetEvFrm.aRich.AddText ('</in>'); //+141.1
   for i := 1 to  {1}ao do begin                    //  Sorc -osat hoidetaan TUL_ERIT´ssä kun i=1.  +10.0.1
      str := '';                                    //<Tyhjättävä, koska ed.krlla lisättiin(AddText)
     {PselOnJo := false;    //<, := TR TUPsel :ssä. +9.0.1
      XselOnJo := false;}                           //,#############################################
      tul_erit (i);                                 //<###### Tämä hoitaa koko Det editoinnin.######
//DetEvFrm.aRich.Lines.Add ('</in>');                 //'#############################################
      DetEvFrm.aRich.AddText (str);                 //'#############################################
    //DetEvFrm.aRich.AddText ('</in>' +str);                 //'#############################################
   end;                                             //'#############################################
end;//erittele                                      //'#############################################
//==================================================================================================
begin//tul_eritEdv
//¿DefsFileenZ('DetEv-1.INC/tul_eritEdv 1');
   erittele;
   //OdotaFrm.Close;  //<Ei tarvittu enää; ProgrsFrm.ProgrsBar hoitaa asian paremmin
   ProgresFrm.Close;
//¿DefsFileenZ('DetEv-1.INC/tul_eritEdv 9');
end;

{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ DetEv-1.INC }

