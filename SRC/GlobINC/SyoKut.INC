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

{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SyoKut.INC

 SyoKut (=SyoOsa): ,,Syot.PAS´sista(sama),,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  1 = Edv:n liittymätietojen syöttö<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  2 = Edv:n johto-osatietojen syöttö<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  3 = Uh-rajan + edv:n uh%-osuuden syöttö<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Ei käytössä enää >= 4.0.0 :ssa
  5 = Häviökust/NjLaskenta<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  6 = Lisätään LIITTYMÄ  alkuun, väliin tai loppuun<<<<<<<<<<<<<<<<<<<<<<<
  7 = Lisätään JOHTO-OSA alkuun, väliin tai loppuun<<<<<<<<<<<<<<<<<<<<<<<
  8 = Moottorilähtöosan itemit (=MoKut/PaaVal Const)<<<<<<<<<<<<<<<<<<<<<< // 6 => 8 = +8.0.0
            //SyoKut:  1=Liitt  2=EdvJ  3=Uh-raj(eiEnää)  5=Häviökust  6=LisätLIITTYMÄ  7=LisätJohto-osa  8=MoottItemit
  if SrcEdka ,,+1411
  then begin
       for i := 1 to edv.YLE.SorceCount.ArvoInt  do
           Edv.Sorc[i].Josa.JkUps.ArvoInt := JkUpsInt;  end        //<Kaikissa Src´ssa sama tieto, onko UPS-laite(1) vai 0.
  else Edv.Edka[Edi].JkUps.ArvoInt := JkUpsInt;                    //<'''141.1
###################################################################################################}
function UhBxON :boolean;      begin result := true; //,,-120.5:  Nyt myös Sorc().Josille, NY EI ENÄÄ KÄYTÖSSÄ.
  {if (edi>1) and (a_getReaa (90, edv.edka[edi-1].Ph) =0)  OR (edi=1) //<Kysytään alkupisteen Uho% vain
      then result := true
      else result := false;}
end;
{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f_VarItems (str :string) :String;      aaa;aa\bbb;bb\  => aaa;bbb
                                                AMCMK;AMC..\AXMK;AXM... => AMCMK;AXMK;...
                                              POISTAA S_..(=CONST, esim. S_KaTyp) sallitut syöttöva-
                                              riaatiot +"\":t =Poimii ekat VE:t +Lisää ";":
function f_Items (str :String) :TStringList;    aaa;bbb   =>   aaa bbb         f_Items(f_VarItems())
                                              POIMII rivierottimella ";" erotetut mjono-osat STR-
                                              mjonosta Item[0..] (Delphi)-listaksi.
function EtsiOlet(oh :integer;  str :String) :String;
                                              ETSII S_..(=CONST, esim. S_KaTyp):sta boxin OLETUSAR-
                                              VO-MJONON (tai seuraavan). Esim:
                                                AMCMK;AMC..\AXMK;AXM... => AMCMK;AXMK;... =aaa;bbb..
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%}
procedure asetaBx9Color;      VAR c1 :char;
  function ekaMrk (s :string) :Char;      VAR i :integer;  c :char;      begin
     c := ' ';
     for i := 1 to Length (s)  do
     if s[i]<>' '  then begin
        c := s[i];  Break;  end;
     result := c;  end;
begin
  with SyottoFrm.ComBx9  do begin
     c1 := ekaMrk (SyottoFrm.ComBx9.Text);     //<ComBx9 =Kpe´n arvo. ,2=Johtotietojen syöttö  7=Lisätään johto-osa
   //if (ekaMrk (SyottoFrm.ComBx9.Text)<>'1') and (SyoKut IN [2,7]) //< 7  +8.0.0
     if (c1<>'1') and (CharInSet(c1, ['0'..'9',',','.'{+8.0.5}])) and (SyoKut IN [2,7]) //< 7  +8.0.0
     then begin Font.Color := clRed;           //'1' Tuli punaiseksi, koska Text='ComBx9'
                Font.Style := [fsBold];  end
     else begin Font.Color := clBlack;
                Font.Style := [];  end;
  end;//with
end;//asetaBx9Color
//--------------------------------------------------------------------------------------------------
{,,Poimii kunkin TAPAUKSEN ekan mjono-osan ="VIRALLISEN VALINTANIMEN" ja lisää niiden väliin ";"
  == MMJ/MMK*;MM;MMJ;..\MCMK;MCM... => MMJ/MMK*;MCMK;...  KÄYTTÖ: KaapTyypin pudotusvalikon Items,,}
function f_VarItems (str :string) :String;      var s :string;  i :integer;      begin
  s := '';  i := 0;
  if str<>''  then                              //<Muuten: Acces Violation...
  repeat i := i+1;                              //'16\25\35\50\70\95\120\150\185\240'
         if (i<Length(str)) and CharInSet(str[i], [';','\']) //<+130.0:  Length()
         then begin
              s := s+';';                                    //<KaTyyppien erottimeksi
              if (i<Length(str)) and (str[i]<>'\')           //<Ettei kohdalla olevan"\" jälkeisen luvun ohi
              then repeat i := i+1;
                   until (i=Length(str)) or (str[i]='\'); //<Etsitään seur tyyypin erotin
         end else s := s +str[i];
  until i=Length(str);
  result := s;    //Y_Koe (2,'f_VarItems   ###str='+str+'     ###s='+s);
end;//f_VarItems;

{,,Poimii rivierottimella ";" erotetut mjono-osat STR-mjonosta omiksi Item[0..] riveikseen,,,,,,,,,,
   >>>>>>>>>>>>>>>>>>> str = MMJ/MMK*;AMCMK;,,,
                       Koklattu :TStrings => TStringList, myös ITMS,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
function f_Items (str :String) :TStringList;   var itms :TStringList;  s :String;  c :Char;  i :integer;
begin   //############ ITMS EI SAA TUHOTA TÄSSÄ FNC:ssä, VAAN... ks. esim. PRC AsKutsu #############
  itms := TStringList.Create; //####################################################################
  try                         //<',Ks. TStrings.AddStrings/Example #################################
    i := 0;                   //####################################################################
    s := '';                  // 11110;11111;11112;11113
    if Length(str)>0          // Ulos Text=11110   0=11110   1=11110   2=11112   3=11113
    then repeat i := i+1;  c := str[i];
                if (c=';') or (i=Length(str))         //<i=Leng.. koska vikan luvun jälk eioo mitään
                then begin  if c<>';'  then s := s+c; //<Muuten jää vika mrk huomioimatta, TODETTU
                               //Y_Koe (2,'f_Items   s='+s);
                            itms.Add(s);              //<Sijoitetaan se listaan
                            if (c=';') and (i=Length(str)) and (s<>'') //<Vikan itemmrkjonon perässä ';',
                               then itms.Add('');     // eli halutaan tyhjä itemi loppuun.########## +6.0.3
                            s := '';  end             //<Alustetaan seur. varten
                else s := s+c;                        //<Kerätään Item-rivi
         until i=Length(str);
    result := itms;
                 {str := 'f_Items   ###str='+str+'    >Text='+itms.Text;  for i := 0 to itms.Count-1
                            do  str := str+'   '+fImrkt0(i,1)+'='+itms.Strings[i];   Y_Koe (2,str);}
  finally    //#####################################################################################
//itms.Free; //########## ITMS EI SAA TUHOTA TÄSSÄ FNC:ssä, VAAN KUTSUVASSA... ks. esim. PRC AsKutsu
  end;       //#####################################################################################
end;//f_Items;

{,,Etsitään STR:n EKOISTA mjonoista ="VIRALLISISTA" ITEM:sta JOKO 1.(os=0 =PERUSOLETUKSEKSI) tai N.
   Tämä FNC olisi muutettavissa siten, että kutsuparam:na annettaisiin MYÖS Str, jonka JÄLKEI-
   NEN ITEM palautettaisiin FNC:n arvona,,,,,,AMCMK;AMC\AXMK;AXM;\...,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
       TÄTÄ EI OLLA KÄYTETTY OMANA KUTSUNAAN MISSÄÄN, mutta sitä ei saa toisen FNCn sisään,,,,,,,,,}
function _Olet(oh :integer;  str :String) :String;      var tmpItems :TStringList;
  begin                                   //,Tehdään STR(=AMCMK;\AXMK;..):sta ITEM-lista TmpITEMS
    tmpItems := f_Items(str);             //< => AMCMK | AXMK | ...jne.
    _Olet := '';
    if oh <= tmpItems.Count-1  then
      _Olet := tmpItems.Strings[oh];      //,,,,,,,Turhaa iteroida, sama suoraan sijoittamalla!!!
       {str := 'EtsiOlet  Text='+tmpItems.Text;  for i := 0 to tmpItems.Count-1  do str := str+'   '+
        fImrkt0(i,1)+'='+tmpItems.Strings[i];  str := str+'  oh='+fImrkt0(oh,1);   Y_Koe (2,str);}
    tmpItems.Free;   //<####### VASTA TÄSSÄ SAA TUHOTA. MUUTEN OSOITIN HÄVIÄÄ LIIAN AIKAISIN #######
  end;//_Olet;       //'############################################################################
function EtsiOlet(oh :integer;  str :String) :String;      VAR sa :string;
  begin                                             //,Tehdään STR(=AMCMK\AXMK;..:sta ITEM-lista
    sa := _Olet (oh, f_VarItems (str));             //< => AMCMK | AXMK | ...jne.
    result := sa;
  end;//EtsiOlet;    //############################################################################

{==================================================================================================}
  {function fXv_Lv (r :real) :real;      VAR ar :real;      begin
      ar := r / (314.15926/1000);  //< mH/km   /1000 ????????????
      result := ar;  end;}

  //,,Palauttaa VAR :issaan kaapelin kokonaisimpedanssin Zj,Rj,Xj. vaiheN = Vaihelukumäärä:  3 =3v, muuten 1v
   procedure ZkaapN (vaiheN :Integer;  typ :string;  mm2 :real;  clt :integer;   VAR Zj,Rj,Xj :real);
         VAR Rv,Rvo,Rn, Xv,Xvo,Xn, R,X :Real;      begin
      Zj := 0;  Rj := 0;  Xj := 0;
      Zkaap (typ, mm2,1, clt,  Rv,Rvo,Rn, Xv,Xvo,Xn); //< 1 =pituus [m].  Rvo +6.0.2
      if vaiheN=3
      then begin Zj := Sqrt ( Sqr(Rv) + Sqr(Xv) );
                 Rj := Rv;  Xj := Xv;  end
      else begin R :=  2*Rv+Rvo+3*Rn;   X := 2*Xv+Xvo+3*Xn; //< Rvo +6.0.2
                 Zj := Sqrt ( Sqr(R) + Sqr(X) );
                 Rj := R;   Xj := X;  end;
   end;
function fRpX_kaap (vaiheN :Integer;  typ :string;  mm2 :real;  clt :integer) :real;
      VAR Zj,Rj,Xj,ar :Real;      begin
   ZkaapN (vaiheN,typ,mm2,clt, Zj,Rj,Xj);
   ar := Rj/Xj;
   result := ar;
end;
function Ik1v_Zaxmk_Per_Zuusi (Qtyp :string;  Qmm2 :real;  clt :integer;  VAR Zaxmk_Per_Zuusi :real) :boolean;
      VAR Zaxmk,Zq, ar :Real;      begin
   Zaxmk_Per_Zuusi := 0;
   ZkaapN (1,'AXMK',185,clt, Zaxmk,ar,ar);
   ZkaapN (1, Qtyp,Qmm2,clt, Zq   ,ar,ar);
   result := SokR (SyottoFrm.ComBx1.Text, ar);
   if result  then
      Zaxmk_Per_Zuusi := ar * Zaxmk/Zq; //< ar=Ik1v -> Ik1v uudella kaapelityypillä
end;
{==================================================================================================}
{==================================================================================================}
{Tekee ao.Boxiin oletusMjonon + pudotusvalikon itemit. ,,SyoOs=SyoKut.<<<<<<<<<<<<<<<<<<<<<<<<<<<<<}
function BxItems (riv,SyoOs :integer) :String;
      VAR s,sa,sb,s1,s2,s3 :string;    recA,recB :EdvPalstaType{+6.2.2};   mmm :integer{+6.2.2};
          ValintaLaji,i,i1,i2,i3 :integer;  {r,}r1,r2,r3 :real;  boo :boolean;

  {,,,,,,,,,,,,,,,,,,,,,,,,ao.arvotarkistusta EDELTÄVÄT p.o. tod.arvoja,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
  function vRok(no :integer;  r1,r2,r3 :real) :boolean;      begin;      vRok := false;
    case no of
      1 :if (r1>0)  then vRok := true;    //<Tätä ei käytetty, yleensä sama testi ilman vRok-kutsua
      2 :if (r2>0) and (r2<>r1) and (r1>0)  then vRok := true;
    else if (r3>0) and (r3<>r2) and (r3>0)  and (r3<>r1) and (r1>0)  then vRok := true;  end;  end;
  {........................}
  function vIok(no, i1,i2,i3 :integer) :boolean;      begin;      vIok := false;
    case no of
      1 :if (i1>0)   then vIok := true;
      2 :if (i2>0) and (i2<>i1) and (i1>0)   then vIok := true;
    else if (i3>0) and (i3<>i2) and (i3>0)  and (i3<>i1) and (i1>0)   then vIok := true;  end;  end;
  {........................}
  function vSok(no :integer;  s1,s2,s3 :string) :boolean;      begin;      vSok := false;
    case no of
      1 :if (s1<>'')  then vSok := true;    //<Tätä ei käytetty, yleensä sama testi ilman vRok-kutsua
      2 :if (s2<>'') and (s2<>s1) and (s1<>'')  then vSok := true;
    else if (s3<>'') and  NOT SamIso (s3,s2) and (s2<>'') and  NOT SamIso (s3,s1) and (s1<>'')
         then vSok := true;  end; end;
//  else if (s3<>'') and (s3<>s2) and (s2<>'')  and (s3<>s1) and (s1<>'')  then vSok := true;  end; end; //=Alp.
  {################################################################################################}
  {,,,HUOM: Seuraavissa GLOBAALIT muuttujat: i,r1,r2,r3...s1,s2,s3,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
                                                   {vRok-kutsuna:..until vRok(1, r1,0 ,0 ) or (i=1)}
                                                   {            :..until vRok(2, r1,r2,0 ) or (i=1)}
                                                   {            :..until vRok(3, r1,r2,r3) or (i=1)}
                                                   {tai         :..until vR1; .. vR3;              }
  function vR1 :boolean;   begin  vR1 := vRok(1, r1,0 ,0 ) or (i=1);  end;
  function vR2 :boolean;   begin  vR2 := vRok(2, r1,r2,0 ) or (i=1);  end;
  function vR3 :boolean;   begin  vR3 := vRok(3, r1,r2,r3) or (i=1);  end;

  function vI1 :boolean;   begin  vI1 := vIok(1, i1,0 ,0 ) or (i=1);  end;
  function vI2 :boolean;   begin  vI2 := vIok(2, i1,i2,0 ) or (i=1);  end;
  function vI3 :boolean;   begin  vI3 := vIok(3, i1,i2,i3) or (i=1);  end;

  function vS1 :boolean;   begin  vS1 := vSok(1, s1,'','') or (i=1);  end;
  function vS2 :boolean;   begin  vS2 := vSok(2, s1,s2,'') or (i=1);  end;
  function vS3 :boolean;   begin  vS3 := vSok(3, s1,s2,s3) or (i=1);  end;
  {'''HUOM: Edellisissä GLOBAALIT muuttujat: r1,r2,r3...s1,s2,s3'''''''''''''''''''''''''''''''''''}
  {################################################################################################}

{ function veS4 (s1,s2,s3 :string) :String;      var sa1,sa2,sa3,ss :string;   begin //,,, -4.0.0
                                                         //Y_Koe (2,'s1='+s1+'  s2='+s2+'  s3='+s3);-2.0.5
    sa1 := '';    sa2 := '';    sa3 := '';               //<+4.0.0 eiVaikutusta:  "BxItems might be undefined"
    sa1 := AnsiUpperCase(s1);   sa2 := AnsiUpperCase(s2);   sa3 := AnsiUpperCase(s3);
    ss := '';
    if  sa1<>''                                 then ss := s1 +';';      //< 1.Item <<<<<<<<<<<<<<<<+2.0.5,,,,,,,
       if (ss<>'') and (ss[1]=';')  then Delete (ss,1,1);                //<Jos ekaa ei ollutkaan
    if (sa2<>'') and (sa2<>sa1)                 then ss := ss +s2 +';';  //< 2.Item <<<<<<<<<<<<<<<<
       if (ss<>'') and (ss[1]=';')  then Delete (ss,1,1);                //<Jos ed. ei ollutkaan
    if (sa3<>'') and (sa3<>sa1) and (sa3<>sa2)  then ss := ss +s3;       //< 3.Item <<<<<<<<<<<<<<<<
       if (ss<>'') and (ss[Length(ss)]=';') then Delete (ss,Length(ss),1); //<Jos ed. ei ollutkaan
    result := ss;
  end;//veS4               ''''''Voistais kaikki korvata vuorollaan kutsulla LisaaVEja (saX,ss)''''''''''''''''''}

  function veS4 (s1,s2,s3 :string) :String;      var sa1,sa2,sa3,ss :string;

     function puts (VAR s :string) :boolean;      begin
       while (s<>'') and ((s[1]=';') or (Pos(';;',s)>0) or (s[Length(s)]=';'))  do begin
          if s[1]=';'                       then Delete (s,1,1);
          if (s<>'') and (Pos(';;',s)>0)    then Delete (s,Pos(';;',s),1);     //<Poistetaan eka kahdesta ';;'
          if (s<>'') and (s[Length(s)]=';') then Delete (s,Length(s),1);   end;//while
       if s<>''  then result := true                                           //<Eka eikä vikakaan voi olla ';'
                 else result := false;
      end;
  begin//veS4.............................               //Y_Koe (2,'s1='+s1+'  s2='+s2+'  s3='+s3);-2.0.5
    sa1 := '';    sa2 := '';    sa3 := '';               //<+4.0.0 eiVaikutusta:  "BxItems might be undefined"
    sa1 := AnsiUpperCase(s1);   sa2 := AnsiUpperCase(s2);   sa3 := AnsiUpperCase(s3);
    ss := '';
    if  sa1<>''                                 then ss := s1;           //< 1.Item <<<<<<<<<<<<<<<<+2.0.5,,,,,,,
        if puts (ss)  then ss := ss +';';
    if (sa2<>'') and (sa2<>sa1)                 then ss := ss +s2;       //< 2.Item <<<<<<<<<<<<<<<<
        if puts (ss)  then ss := ss +';';
    if (sa3<>'') and (sa3<>sa1) and (sa3<>sa2)  then ss := ss +s3;       //< 3.Item <<<<<<<<<<<<<<<<
        puts (ss);
    result := ss;
  end;//veS4               ''''''Voistais kaikki korvata vuorollaan kutsulla LisaaVEja (saX,ss)''''''''''''''''''
  {........................}//,,+6.0.0 Loppunollat vex.#############################################
  function veA4_ (vex0 :integer;  alkio1,alkio2,alkio3 :arvoTyyp) :String;      VAR s1,s2,s3,ss :string;
                                                      //,,Tutkii onko SI niin pieni että AR= xxE-nn =scientificMuotoa, jolloin muuttaa AR´n desimLukuStr´ksi.
  begin//veA4_........................
    ss := '';
    s1 := fMrktRaj( alkio1); //<Tutkii alkiosta desimaalirajat ja muokkaa arvot desimaaleineen
       if vex0>0  then s1 := fVexN_ (s1); //<POISTAA LOPPUNOLLAT.###################################
    s2 := fMrktRaj( alkio2);
       if vex0>0  then s2 := fVexN_ (s2);
    s3 := fMrktRaj( alkio3); //  Y_Koe (2, s1+'///'+s2+'///'+s3+'   veA4='+veS4( s1,s2,s3));
       if vex0>0  then s3 := fVexN_ (s3);
       StoSok_e5(s1);  //<,,+130.2e
       StoSok_e5(s2);
       StoSok_e5(s3);
    ss := veS4( s1,s2,s3);
    result := ss;                                //<Tämä rivi oli lipsahtanus 8.0.12:sta vex, lisätty +8.0.13
  end;//veA4_

{//,Kokeilua §u
  function veS4 (s1,s2,s3 :string) :String;      begin
     result := '2.031';
  end;}

  {//Kokeilua,,
  function veA4_ (vex0 :integer;  alkio1,alkio2,alkio3 :arvoTyyp) :String;      VAR ss :string;     begin
    ss := '0.123';
    result := ss;
  end;//veA4_}
                             //,,6.0.0 Korvattu veA4_ kutsulla.#####################################
  function veA4 (alkio1,alkio2,alkio3 :arvoTyyp) :String;      VAR ss :string;     begin
          {s1 := ';';     s2 := '2;';    s3 := '3;;';   ss := veS4 (s1,s2,s3);
           s1 := '1;';    s2 := ';2;';   s3 := ';3;;';  ss := veS4 (s1,s2,s3);
           s1 := ';1';    s2 := ';;2;';  s3 := '3;;';   ss := veS4 (s1,s2,s3);
           s1 := '1;';    s2 := '2;';    s3 := '3;';    ss := veS4 (s1,s2,s3);}
    ss := veA4_(0, alkio1,alkio2,alkio3);
    result := ss;
  end;//veA4
  {........................}
  function veI4 (i1,i2,i3 :integer) :String;      VAR s1,s2,s3,ss :string;  begin
    s1 := fImrkt0( i1,1);
    s2 := fImrkt0( i2,1);
    s3 := fImrkt0( i3,1);
    ss := veS4( s1,s2,s3);
    result := ss;
  end;//veI4
  {........................}
  function veR4 (r1,r2,r3 :real;  alkio :arvoTyyp) :String;      VAR s1,s2,s3,ss :string;      begin
    s1 := fRmrktRaj (r1, alkio);
    s2 := fRmrktRaj (r2, alkio);
    s3 := fRmrktRaj (r3, alkio);
    ss := veS4( s1,s2,s3);
    result := ss;
  end;//veR4
{,,,,,,,,, TARKISTETTU, OK, Ei käytetty ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  //................................................................... ,,Etsii SAO :a S :stä ";" tai "\" :n
  function fSkplNo (SAO,S :string;  VAR arvoja,aoNo :integer) :boolean; // väleistä SEKÄ PALAUTTAA ARVOlkm +
        CONST ce1=';';  ce2='\';                                        // ARVO-OSOITTEEN (monesko arvo S :ssä).
        VAR o :integer;  Rao,Rau :real;  SSI,SU :string;

     function fAlkuLopEroMrkVex (si :string) :string;      begin//<,Poistaa alk/loppTYHJÄT ja -arvoEROTTIMET ";","\"
        while (Length (si)>0) and (si[1] IN [ce1,ce2,' '])  do           //<AlkuEROTT./TYHJÄT vex
              Delete (si,1,1);
        while (Length (si)>0) and (si[Length (si)] IN [ce1,ce2,' '])  do //<LoppuEROTT./TYHJÄT vex
              Delete (si,Length (si),1);
        result := si;  end;

              //,TR = arvo on olemassa (<> ce1,ce2,''). Tutkii SI :n alusta, josta POISTAA palauttamansa SO -osan.
     function fSeurS (VAR si,so :string) :boolean;      VAR i :integer;  su :string;      begin
        su := fAlkuLopEroMrkVex (si);
        so := '';  result := false;
        while (su<>'') and NOT (su[1] IN [ce1,ce2])  do begin
              so := so +su[1];
              Delete (su,1,1);                        //<Poistetaan SU :sta sitä mukaa juuri kopioitu mrk.
              result := true;  end;
        si := su;      
     end;
  begin//fSkplNo,,,,,,,,,,,,,,,,,,,
     arvoja := 0;  aoNo := 0;  SSI := S;
     while fSeurS (SSI,SU)  do begin
        arvoja := arvoja +1;
        o := Pos (SAO,SU);
        if (aoNo=0)  and (o>0)  then begin     //<Ei aikaisemmin vielä löytynyt, mutta nyt löytyi !!
           if SokR (SAO,Rao)                          //<Jos alp.vert.arvo=NUMEROarvo, on myös sellainen löydyttvä
           then begin
                if SokR (SU,Rau) and (Rao=Rau)        //<Jos NUMEROarvot ja samaNUMEROarvoisia.
                   then aoNo := arvoja;  end
           else begin                                 //<Ei NUMEROarvo =Täytyy olla SAMAstring, jos o>0
                if SamIso (SAO,SU)
                   then aoNo := arvoja;  end;
        end;
     end;//while
  end;//fSkplNo}

  {...................,,s1 ja s2 = ,,, muotoa: '111;222;333;444'. s2 :sta poistet samat itemit
  ....................,,0 = Lisätään s2 :n LOPPUUN VAIN ne, jotka eivät ole jo listassa s2........................
                      ,,1 = Lisätään s2 :n loppuun AINA, oli jo tai ei s2 :ssa, ELLEI JO OLE VIKANA,,}
  procedure lisaaVE_ (oh :integer;  s1 :string;  VAR s2 :string); //<,,###### UUSIKSI 2.0.5 ########
        var sa :string;                                           //,,,#############################
    //.......................................................................
   {procedure Fileen(si :string);     VAR ff :TextFile;  nm :string;      begin//+120.4 Tämä kirjoittaa $DefsFileen-Tst.TXT -fileeseen.
       nm := 'C:\Projektit XE2\NolaKehi\BIN\$_SyoKutAlkVex.txt';
       AssignFile(ff,nm);
       if fFileExists(nm)                                      //<130.0
          then Append(ff)
          else Rewrite(ff);
       Writeln(ff,si);
       Flush(ff);
       CloseFile(ff);
    end;//Fileen}
    function fS (ss :string) :string;      const erotin=';';      begin
        result := erotin +ss +erotin;  end;
     //.......................................................................
     procedure AlkLopTyhEroVex (VAR s :string);
           var mja,i,j,t1,t2,o,d :integer;  sa,sv,su :string;  {Lst :TStringList{+1411 Ei tarvittukaan, koko AlkLopTyhEroVex vex.}
     begin
//Fileen('0: ' +s);
        mja := Length (s);   sa := '';                     //<,,Putsataan ALKUPÄÄ ##################
      //Lst := TStringList.Create;
        o := 0;                                                                //<+1411
       {}for i := 1 to mja  do  if NOT (CharInSet(s[i], [' ',';']))  then begin //<Etsitään EKA merkki <> ' ',';' => [o]
            o := i;  break;  end; //<',-+1411{}
        //o := Pos(';',s);                                   //<'Alkutyhjät säilytettävä, jotta esim. "  Stamfor:..:" =sisäänvedetty väliotsikko +1411.
        if o>0  then for j := o to mja  do sa := sa +s[j];
        s := sa;
//Fileen('1: ' +s);
        i := Length (s);
        while {(s<>'')}(i>0) and (CharInSet(s[i], [' ',';']))  do begin //<Lopputyhjät ja loppuerottimet vex.
            Delete (s, i,1);
            i := i-1;  end;
//Fileen('2: ' +s);

        if o>0  then for j := o to mja  do sa := sa +s[j]; //<''Nämä korvautuisi Trim´illä.
        i := Pos (';;',s);             //<,,,,,Putsataan PERÄKKÄISET ';;..' ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, 5.0.1
        while i>0  do begin                                   // = 'XXX;;XXX' => 'XXX;XXX'
           Delete (s,i,2);                                    //<Poistetaan ';;' esiintymä ja
           Insert (';',s,i);                                  //<korvatataan se ';' :llä !!!!
           i := Pos (';;',s);  end;    //<''Poistellaan ';;' kunnes ';;;' :kin ';'.!!!!!!!!!!
        sa := s;                       //<''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''5.0.1
//Fileen('3: ' +s);

        t1 := 1;                       //<,,,,,Poistetaan turhat loppunollat +3.0.0,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
        while t1<=Length(sa)  do begin                        //,,"0.080;45.0" -> "0.08;45", mutta "2;0;0" säilyy
           t2 := 0;   o := 0;   d := 0;                                 //,1414d: +and (t1>0)
           while (t1<Length(sa)) and (sa[t1]<>';') and (t1>0)  do begin //,Ei ';' koska tähän ei tulla, jos sa[t1]=';'
              if CharInSet(sa[t1], ['0'..'9','.'])  then t2 := t2+1;    //<t2 DESIM.LUVUn merkiksi ###########
              if sa[t1]='.'  then d := d+1;                   //<Jos d>1 =merkkijono ###############
              o := o+1;                                       //<Itemin mrkLkm #####################
              t1 := t1+1;                                     //, o=1 =Vain yksi mrk, jos '0' EI SAA PYYHKIÄ,,,,,
           end;
           if t1=Length(sa)  then t1 := t1+1;                 //<Jotta ULOS ja yksillä Deleteosoitteilla ########

           while (d=1)  AND (t2>0)  AND  (o=t2)  AND          //<Vain jos 1xDesPilkku ja vain '0..9' ############
                 (t1-1 >= 1) and (CharInSet(sa[t1-1], ['0','.']))  do begin
              if sa[t1-1]='.'
              then begin Delete (sa, t1-1,1);
                         BreaK;  end
              else       Delete (sa, t1-1,1);                 //<Delataan vika '0' JA '.' muttei PISTEENedeltäv 0
              t1 := t1-1;
           end;
           t1 := t1+1;                                        //<Vaikka menisi ohi vikan !!!!!!!!!!!
        end;                           //<''+3.0.0
//Fileen('4: ' +sa);

        t1 := 0;
        repeat                         //<,,,,,Poistetaan samojen jäljemmät esiintymat (n kpl),,,,,,,,,,,,,,,,,,,
           t1 := t1+1;
           mja := Length (sa);  sv := '';
           while (t1<=mja) and (sa[t1]<>';')  do begin        //<Tehd vrtltava item 'XXX;..-> 'XXX'
                 sv := sv +sa[t1];   t1 := t1+1;  end;        //<SV on verrattava mjono <<<<<<<<<<<<
           t2 := t1;
           repeat                                             //, +1 =Ohitetaan ';' ################
              t2 := t2+1;                                     //<Vikan alkukohta jos s1 vikana #####
              mja := Length (sa);  su := '';
              while (t2<=mja) and (sa[t2]<>';')  do begin     //<Tehd vrtltava item 'XXX;..-> 'XXX'
                 su := su +sa[t2];   t2 := t2+1;  end;        //<SU on verrattava seur.mjono <<<<<<<

              i := t2 -Length (su);
              if (sv<>'') and SamIso (sv,su)  then
                 Delete (sa, i, Length(su)+1);                //< +1 = mahd. lopussa oleva ';' vex
              if (Length(sa)>0) and (sa[Length(sa)] = ';')  then
                 Delete (sa,Length(sa),1);                    //<Mahd. ed. Itemistä jäänyt ';' vex
           until (t2>=Length(sa));
        until (t1>=Length(sa));
        s := sa;
//Fileen('4: ' +s);
//Fileen('');
        //Lst.Free;
     end;//AlkLopTyhEroVex
     //.......................................................................
     function S1_JoLopussa :boolean;      var v,os :integer;  onJo :boolean;  {sa :string;      }begin
                             //,,,,,,,,,,,,,,,,,Tutkitaan onko S1 jo VIKANA,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
        onJo := false;
        if (s1<>'')  then begin                                     //<Jos s1='' FA jää voimaan #################
           if SamIso (s1,s2)                                        //<Ed.rvllä jo testattiin että s>''
           then onJo := true                                        //<Samat mjonot = on jo VIKANA (ainoa Item)
           else begin
                v := Length(s2)- Length(s1) +1;                     //<Vikan alkukohta jos s1 vikana ############
               {sa := Copy (s2, v, Length(s1));                     //<Kopioidaan mahd. vikan alusta SA :han
                if fMukanaSX (fS(s1), fS(sa), os) and (os>0) and (os=v)}
                if MukanaOs (fS(s1), fS(s2), os) and (os=v)
                   then onJo := true;
           end;
        end;
        result := onJo;
     end;//S1_JoLopussa
  begin//lisaaVE_ ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    {AlkLopTyhEroVex (s1);                                    //<Alku- +loppu';'+' ' vex ########################
     AlkLopTyhEroVex (s2);                                    //< onEkat =Jos Txt-osa + 1.item on jo.  Tarpeettomana vex: -1411.}

     if Pos('STAMFORD',AnsiUpperCase(s1)) >0  then                           //<,+1411:  Gener. param. iterointien lisäys.
        s1 := '»»»» Hae uudet »»»»;' +s1;
     sa := '';                  //<Jottei "BxItems might be undefined", ei tainnut auttaa
     if s2=''
     then sa := s1
     else if S1_JoLopussa
     then sa := s2              //<Vanha alp s2 sellaisenaan koska s1 on jo mukana <<<<<<<<<<<<<<<<<
     else if oh=0
          then begin
               sa := s2 +';' +s1;         //< +5.0.1
               AlkLopTyhEroVex (sa);  end //< +5.0.1  Putsataan samojen toiset esiintymät.##########
          else sa := s2 +';' +s1; //<S1 liitetään S2 :n jatkoksi =LisäITEM <<<<<<<<<<<<<<<<<<<<<<<<<

     if (sa<>'') and (sa[Length(sa)]=';')  then               //<Varmksi ehto ''
        Delete (sa,Length(sa),1);                             //<Poistetaan lopussa oleva ';' ######
     s2 := sa;
  end;//lisaaVe_
  //------------------------------------------------------------------------------------------------
  procedure lisaaVEja (s1 :string;  VAR s2 :string);      begin
{           SyottoAvFrm.Hide;  AvuChkSft (11);    //<Ettei koekäytössä avuste peitä sorsaa +Stack +Watch -ikkunaa
            s1 := '2s';     s2 := '';         lisaaVE_ (1,s1,s2);
            s1 := '2s';     s2 := '4s;4S;55'; lisaaVE_ (1,s1,s2);
            s1 := '2s';     s2 := '4S';       lisaaVE_ (1,s1,s2);
            s1 := '4s';     s2 := '4S';       lisaaVE_ (1,s1,s2);
            s1 := '2s';     s2 := '4S;55';    lisaaVE_ (1,s1,s2);
            s1 := '2s';     s2 := '4S;;55';   lisaaVE_ (1,s1,s2);
            s1 := '2s';     s2 := ';4S;55';   lisaaVE_ (1,s1,s2);
            s1 := '2s';     s2 := '4s;4S;55'; lisaaVE_ (1,s1,s2);
            s1 := ';2s';    s2 := '';         lisaaVE_ (1,s1,s2);
            s1 := '2s;';    s2 := '4S';       lisaaVE_ (1,s1,s2);
            s1 := ';4s;';   s2 := '4S';       lisaaVE_ (1,s1,s2);
            s1 := ';2s;';   s2 := '4S;55';    lisaaVE_ (1,s1,s2);
            s1 := ';2s;';   s2 := '4S;;55';   lisaaVE_ (1,s1,s2);
            s1 := ';2s;';   s2 := ';4S;55';   lisaaVE_ (1,s1,s2);
            s1 := ';2s;';   s2 := '4s;4S;55'; lisaaVE_ (1,s1,s2); //}
{           s1 := '0.080;40.0;45.0';  s2 := s1;  lisaaVE_ (1,s1,s2); //< ->0.08;40;45
            s1 := '0.080;40.0;45.0';  s2 := s1;  lisaaVE_ (1,s1,s2);
            s1 := '2;0;0';            s2 := s1;  lisaaVE_ (1,s1,s2); //<Jää näin
            s1 := '2;4;6';            s2 := s1;  lisaaVE_ (1,s1,s2); //<Jää näin
            s1 := '2;20;ab;c0';       s2 := s1;  lisaaVE_ (1,s1,s2); //<Jää näin }
     lisaaVE_ (1,s1,s2);  end;       //< 1=Lisätään AINA vikaksi (yleensä näin), ellei jo ole VIKANA
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
  {Ik1v =  0.95*3*Uv / V¨[(2Re+6Rv)² + [(2Xe+3Xv)²] ~~ 0.95*3*Uv / V¨[(6Rv)² + [(3Xv)²]
   Ik1v²~ (0.95*3*Uv)² / [(6Rv)² -  (3Xv)²]         -> (6Rv)²~ (0.95*3*Uv)² / Ik1v²   -  (3Xv)²
   (6Rv)²~ (0.95*3*Uv)² / Ik1v²   -  (3*Rv*TanPhi)² -> (6Rv)² + (3*Rv*TanPhi)² ~ (0.95*3*Uv)² / Ik1v²
   (3Rv)²*(2+TanPhi)² ~ (0.95*3*Uv)² / Ik1v²        -> (3Rv)²~~ (0.95*3*Uv)² / Ik1v² / (2+TanPhi)²
>>> 3Rv ~ V¨[(0.95*3*Uv)² / Ik1v² / (2+TanPhi)²]   ==> Rv ~ V¨[( 0.95*3*Uv)² / Ik1v² / (2+TanPhi)²] /3
                                                 Myös: Rv ~ V¨([(0.95*3*Uv/Ik1v)² - (3Xv)²] / 6²)
  ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,     Xv ~ V¨([(0.95*3*Uv/Ik1v)² - (6Rv)²] / 3²)   }
  function Iks3v_ol :real;   var {k,}Rv,Xv{,cosv} :real;  begin//<Lasketaan Iks3v 1v:n ja cos:n perustlla
     with edv.Sorc[mmm].src  do begin
{       k := 0.95*3*fUv;   cosv := a_getReaa(92,pjLiitRs);  //<cosv vielä apuna = R <<<<<<<<<<<<<<<<<
       cosv := cosv / ( Sqrt ( Sqr(cosv) + Sqr(a_getReaa(93,pjLiitXs)) ));
       Rv := Sqrt ( Sqr(k) / Sqr(a_getReaa(94,Iks1v)) / Sqr(2 + Tan(ArcCos(cosv))) )  / 3;
     //Rv := Sqrt ( Sqr(k) / Sqr(a_getReaa(94,Iks1v)) / Sqr(2 + cosv) )  / 3; //<Näin kunnes Math -unit
       Xv := Sqrt ( (Sqr(k/a_getReaa(95,Iks1v)) - Sqr(6*Rv))  / Sqr(3) );
       Result := fUv / Sqrt (Sqr(Rv) + Sqr(Xv));  end; end;                //Ik3v = Uv / V¨(Rv²+Xv²)-------}

{,,,,,,Ik1v=cU*3*Uv/Ze,  Ze=V¨[(3Re)²+(3Xe)²],   3Re=6eRs=3Rv+6Rv(n) -> Rv=6eRs/9,,,,,,,,,,,,,,,,,,,
                                                 3Xe=6eXs=3Xv        -> Xv=6eXs/3
       Rv := 6/9 *a_getReaa(92,pjLiitRs);
       Xv := 6/3 *a_getReaa(93,pjLiitXs);
       Result := fUv / Sqrt (Sqr(Rv) + Sqr(Xv));  end; end;                //Ik3v = Uv / V¨(Rv²+Xv²)

{,,,,,,Ik1v=cU*3*Uv/Ze,  Ze=V¨[3(Rv+Rn)]²+[3Xv+3Xn(=0)]² = V¨[3eRs]²+[3eXs]² ,,,,,,,,,,,,,,,,,,,,,,,
                             [3(Rv+2Rv)]²+[3Xv]²         =   [3eRs]²+[3eXs]²
                                   3Rv²  + Xv²           =     eRs² + eXs²   => Rv = eRs/3  Xv = eXs}
     //Rv := a_getReaa(92,pjLiitRs) /3;                                                             //< -6.0.2
       Rv := a_getReaa(92,pjLiitRs);                                                                //< +6.0.2
       Xv := a_getReaa(93,pjLiitXs);
       if Rv<=0                                          //<,+6.0.2:  pjLiitRs,Xs +Lyht voi olla 0.!!!!!!!!!!!!!!!
          then result := a_getReaa(94,Edv.Sorc[mmm].src.Iks3v)   //<Jos Rv=0, on Xv´kin 0.
          else result := fUv / Sqrt (Sqr(Rv) + Sqr(Xv));         //Ik3v = Uv / V¨(Rv²+Xv²)
  end; end;

  {........................}//,,Muuntajan napaoikosulkuvirta Ik:  MAX>0 =Ik3v,  YVRK>0 =Yläverkko 10 MVA 20 kV:n muk.
  function Ik_muuntS (max,yvrk :integer;  Sm :real) :string;
        VAR Ry,Xy, Rm,Rmo,Xm,Xmo,ar :real;  mi,m :integer;  s :string;      begin

     if yvrk=0  then begin Ry := 0;           Xy := 0;  end
                else begin Ry := 0.00189867;  Xy := 0.01196467;  end;//<10 MVA 20 kV:n mukaan.
     if max=0  then mi := 9  //< 9=MaxZ => Ik1v
               else mi := 8; //< 8=MinZ => Ik3v
     if max>0                                       //<,, Ik3v
     then begin
        asMparam_ (Sm,mi,{20}75, Rm,Rmo,Xm,Xmo, m); //<20°C->Rm,Rmo.  20=>75°C  6.0.4
        ar :=  fUv/Sqrt( Sqr(Rm)+Sqr(Xm) );  end
     else begin                                     //<,, Ik1v
        asMparam_ (Sm,mi,75, Rm,Rmo,Xm,Xmo, m);     //<75°C->Rm,Rmo
        ar := Sqrt( Sqr(2*Ry +2*Rm+Rmo) + Sqr(2*Xy +2*Xm+Xmo) );
        ar :=  a_getReaa (94, edv.YLE.cU) *3*fUv / ar;  end;

     s := '';  if ar>0  then s := fMrkvia (ar/1000,5);
     Result := s;
  end;
  {........................}
{ function eRs_COSta (cosn :real) :string;   var ar :real;  s :string;  begin//<Lasketaan eRs Iks1v:n ja cos:n perustlla
     ar := a_getReaa (94, edv.YLE.cU) *fUv / a_getReaa (94, edv.Sorc[mmm].src.Iks1v) /1000;  //<eZs
     ar := ar * cosn;
     s := '';  if ar>0  then s := fMrkvia (ar,8);
     Result := s;   end;}
  function eRs_RperX (RpX :real) :string;   VAR rr,ar{,er} :real;  s :string;  begin//<Lasketaan eRs Ik1v:n ja R/X:n perustlla
           //Ik1v = c×Uv / V¨(R²+X²) -> eRs = V¨[(c×Uv×RpX)²/(Ik1v²×RpX² +1)] = V¨[Z²×RpX²/(RpX² +1)]
     ar := a_getReaa (94, edv.YLE.cU) *fUv / a_getReaa (94, edv.Sorc[mmm].src.Iks1v) /1000;  //<eZs
     rr := Sqrt ( Sqr (ar*RpX)/(Sqr (RpX) +1) );                                           //<eRs = f (eZs,R/X)
     s := '';  if rr>0  then s := fMrkvia (rr,8);
     Result := s;
                                 {er := Sqrt (Sqr (ar) - Sqr(rr)); //< eXs ,,Kokeilun tarkistukseen
                                  ar := rr/er;                     //< eRs/eXs
                                  if (rr<0) and (ar<0)  then beep;}
  end;
  {........................}
  procedure koe_Y(o :integer);   begin  {Y_Koe (0,fImrkt0(o,1)+':  kesno='+fImrkt0(kesno,1)+'   r1='+
            fRmrkt0(r1,1,2)+'   r2='+fRmrkt0(r2,1,2)+'   r3='+fRmrkt0(r3,1,2) +'   ### s=' +s);  }end;
  procedure koe_Ys(o :integer);  begin  {_Koe (0,'8:  kesno='+fImrkt0(kesno,1)+'   r1='+
            fRmrkt0(r1,1,2)+'   s1=' +s1+'   s2=' +s2 +'   s3='+s3 +'   ### s=' +s);  }end;

   function SyoKut_PEN_PE (BxTxt :string) :string;      VAR s1,s2,s3,s :string;      begin //+8.0.12
      s1 := fMrktRaj( edv.YLE.PEN_PE);                  //'=PEN_PE-yhdist.BX-arvo kaikille liittymille.
      s2 := fMrktRaj(edvf.YLE.PEN_PE);                  //edv.YLE.PEN_PE.ArvoStr
      s3 := fMrktRaj(edv0.YLE.PEN_PE);
      s := s1 +';' +s2 +';' +s3;
      lisaaVeja ('',s);                         //<LisaaVEja poisti tyhjät itemit alusta (';')
      if s1=''  then s := ';' +s;               //<Oli valittu tyhjäksi, joten korjataan tyhjä takas +6.2.12
      s3 := '';  if s<>''  then s3 := ';';      //<,s3 = ';'(välimerkki) tai '' tilanteen muk.
      if s1='' then begin
         s1 := BxTxt;
         s1 := Trim (s1);
         if Length (s1) <14  then s1 := '';     //<Tarkistet ettei esim.j-osasyötön Tk -arvo ole jäänyt ed.krlta
         if s1<>'' then s := s1 +s3 +s +s3;     //<1 amc.. +'' +'' +''  TAI  1 amc.. +';' +'x..' +';'
      end;                    //'s3=>s2 =141.1
     {if (edv.YLE.PEN_PE.ArvoStr<>'') and
         (Pos(edv.YLE.PEN_PE.ArvoStr, s) =0) or (Pos(edv.YLE.PEN_PE.ArvoStr, s) >1)  then
            s := edv.YLE.PEN_PE.ArvoStr;                             }  //<''+141.1
      s := s +';' +'1 axmk4 300 20 80 (L=ekviv.)'; //<Ekaxi tyhjä itemi jos ei jo ole (tulee testaamatta). 141.1 oli: amcmk4½ 120
    //if (s[1]<>';') and (edv.YLE.PEN_PE.ArvoStr='')  then s := ';' +s; //<+141.1 KEHI KEHI KESKEN KESKEN
      if (s[1]<>';') OR (edv.YLE.PEN_PE.ArvoStr='')  then s := s +';';  //<Jos ei ekana tyhjää itemiä, lisätään loppuun tyhjä item.=sen valinta vastaa deletointia.
      result := s;
   end; //''VAIN NÄIDEN EKA ';' JÄTETÄÄN, KS. PRCn LOPPU (muista pyyhitään vex).###############''

//================================================================================================================
//================================================================================================================
//================================================================================================================
begin//BxItems... TÄSSÄ tehdään merkkijono ComboBoxin TEXTiksi + ITEMeiksi: Kukin osateksi erotetaan
                 {';' :llä, joka puretaan käyttöön fnc :lla f_Items ###############################}

  s := '';  sa := '';  sb := '';  s1 := '';  s2 := '';  s3 := '';  //< ?????????????????????????????
  mmm := edi; //<Sijoitus tarkistettava kun rinnakkaissyöttöNroMuuttuja on toteutettu,!!!!!!!!!!!!!!+6.2.2
  if SrcEdka
  then begin
     recA := edv.Sorc[edi].Josa;   recB := recA;   if edi>1  then recB := edv.Sorc[edi-1].Josa;  end
  else begin
     recA := edv.Edka[edi];        recB := recA;   if edi>1  then recB := edv.Edka[edi-1];
  end;

//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§,KUN RadGrp.ItemIndexit eli kun LIIT.RadGrp on näkyvissa.'§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
ValintaLaji := SyottoFrm.RadGrp.ItemIndex; //+8.0.12:  APULASKRUUTU avautuu vain Sj+Pj :llä ja Rv :=+10 joten jos
if (riv>10) and (ValintaLaji<2)  then      // RIV>=11, kutsu on apulaskRuudusta, minkä mrkiksi ValintaLaji=66.!!!!
   ValintaLaji := 66;                      //'muute ValintaLaji on sama kuin RadGrp.ItemIndex.!!!!!!!!!!!!!!!!!!!!
Wavu('0 SyoKut.INC/BxItems: SyoOs=' +Ints(SyoOs) +' riv=' +Ints(riv));
   //SyoOs=SyoKut.
   //,,¤¤¤¤¤¤¤¤¤¤ SyoOS:  0=VrkKuvaajan yläpanelin Bxt ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
case SyoOs  of //,SyoOs:  0=VrkKuvaajan yläpanelin Bxt  1=Liitt  2=EdvJ  (3=Uh-raj, eiEnää)  4=Nj
0 :case riv of //         5=Häviökust  6=LisätLIITTYMÄ  7=LisätJohto-osa  8=MoottLähdöt
   1 :s := fMrktRaj( edv.YLE.Un) +';'+f_VarItems(S_Usrj);                                         //<Un <<<<<<
   2 :s := veA4 ( edv.YLE.cU, edvf.YLE.cU, edv0.YLE.cU);                                          //<cU <<<<<<
   3 :s := veA4 ( edv.YLE.LaakPmu, edvf.YLE.LaakPmu, edv0.YLE.LaakPmu);  end;//case riv             < LaakPmu  +130.2o.
//,,¤¤¤¤¤¤¤¤¤¤¤ ValintaLaji:  0=Sj ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
1,6 :case ValintaLaji of
0 :case riv of //0=Sj.    ValintaLaji:  0=Sj  1=Pj  66=Apulask.  2=Gen  3=UPS,  edv.Sorc[mmm].src.SorceKind EHKEIokVielä.
{r}1 :begin
        s1 := Trim (SyottoFrm.ComBx2.Text);       //<Muuntajatyyppi 1...
        s := fMrktRaj( edv.Sorc[mmm].src.Smn);                                                   { Smn <<<<<}
        i := 0;
        if SokR (s1,r1)  then begin
           i := trunc (r1);
           case i of
           1     :s := s +';=== Srj 1 ===;'      + f_VarItems(S_MUUN_1); //<,,5.0.1
           2,9   :s := s +';=== Srj 2 ===;'      + f_VarItems(S_MUUN_2);
           3,8   :s := s +';=== Srj 3 ===;'      + f_VarItems(S_MUUN_3);
           11    :s := s +';=== Srj 1 (-93)===;' + f_VarItems(S_MUUN_1); //<,, >10=VanhatTyypit <,,6.0.0
           12,19 :s := s +';=== Srj 2 (-93)===;' + f_VarItems(S_MUUN_2);
           13,18 :s := s +';=== Srj 3 (-93)===;' + f_VarItems(S_MUUN_3);  end;//case
        end;                             //,Lisätään loppuun puuttuvat koot = eivät ole vakioita Srj 1..3 :ssa.
        if i<10  then begin                                                                      //< 6.0.0
          {sa := '=== Muut (vanhat -93) ===';                                                    //< 5.0.1
           lisaaVE_ (0,sa +';' +f_VarItems(S_MUUN),s);  end; //< 0 = Putsataan jäljemmät saman esiintymät.-6.0.4}
           sa := '=== Vanhat -93) ===';                                                          //< 6.0.4
           s := s +';' +sa +';' +f_VarItems(S_MUUN);  end;
                                                      {lisaaVE_ (0,sa+';100',s); //<Kokeilua =OK}
        i := Pos (sa,s);
        if i=Length (s) - Length (sa) +1            //<,Putsataan loppuosa jos ei muuta kuin väliotsikko.!!!!!!
           then Delete (s,i-1,Length (sa)+1);   end;//<Nyt ei kylläkään olisi tarvetta, mutta mahd.muutostTakia.

{r}2 :s := fMrktRaj( edv.Sorc[mmm].src.TrfTyp) +';'+ f_VarItems('1  NormPh\2  AlenTyhjPh\3  AlenKuormPh\'+
                                                                     '8  Ik3v max\9  Ik1v min\'+
                                                '=== Vanhat tyypit (-93)===\11  Srj 1\12  Srj 2\13  Srj3\'+
                                                '18  Ik3v max\19  Ik1v min\');

{r}3 :begin s := veA4( edv.Sorc[mmm].src.yvRs,  edvf.Sorc[mmm].src.yvRs,  edv0.Sorc[mmm].src.yvRs);                                { yvRs <<<<}
           r1 := a_getReaa (120,edv.Sorc[mmm].src.yvXs);                  //,Rs = Xs * RperX
           r2 := r1 * (0.000098/0.001597);                                //<Rs laskettuna Xs :stä 10 MVA:n muuntajan R/X -suhteella.!!
           LisaaVEja (fMrkvia (r2,8) +'  = f (Xs,10 MVA)', s);
           r3 := edv.Sorc[mmm].src.yvRs.ArvoRea;                          //<,,?130.2e .
         //SyottoFrm.StrGr1.Cells[2,3] := '2mOhm';  //KESKEN KESKEN       Ei tarvita muuntaa mOhm´ksi, koska nyt Str on rakennettu OIKEIN: 0.000098

           LisaaVEja ('0.000098 (10 MVA)',s);  end;//<Lisätään kylmästi loppuun, koska 10MVA puuttuu kuitenkin.

{r}4 :begin s := veA4( edv.Sorc[mmm].src.yvXs, edvf.Sorc[mmm].src.yvXs, edv0.Sorc[mmm].src.yvXs);                                 { yvXs <<<<}
           r1 := a_getReaa (120,edv.Sorc[mmm].src.yvRs);       //,Xs = Rs / RperX
           r2 := r1 / (0.000098/0.001597);           //<Xs laskettuna Rs :stä 10 MVA:n muuntajan R/X -suhteella.!!
           LisaaVEja (fMrkvia (r2,8) +'  = f (Rs,10 MVA)', s);
           LisaaVEja ('0.001597 (10 MVA)',s);  end;  //<Lisätään kylmästi loppuun, koska 10MVA puuttuu kuitenkin.
{r 5 =Tyhjä rivi =Ei Boxia.}
{r}6 :s := SyoKut_PEN_PE (SyottoFrm.ComBx6.Text);
   end;//case riv of

//,,¤¤¤¤¤¤¤¤¤¤¤ ValintaLaji:  1=Pj ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
1 :case riv of //1=Pj.    ValintaLaji:  0=Sj  1=Pj  66=Apulask.  2=Gen  3=UPS,  edv.Sorc[mmm].src.SorceKind EHKEIokVielä.
//,Iks1v
{r}1 :begin s := veA4 ( edv.Sorc[mmm].src.Iks1v, edvf.Sorc[mmm].src.Iks1v, edv0.Sorc[mmm].src.Iks1v); { Iks1v <<<}
           sa := Ik_muuntS (0,0,2000);    if sa<>''  then s := s +';' +sa +'  muunt. 2 MVA';          //<,, +4.0.1
           sa := Ik_muuntS (0,0,1600);    if sa<>''  then s := s +';' +sa +'  muunt. 1.6 MVA';
           sa := Ik_muuntS (0,0,1250);    if sa<>''  then s := s +';' +sa +'  muunt. 1.25 MVA';
           sa := Ik_muuntS (0,0,1000);    if sa<>''  then s := s +';' +sa +'  muunt. 1 MVA';
           sa := Ik_muuntS (0,0,800 );    if sa<>''  then s := s +';' +sa +'  muunt. 800 kVA';
           sa := Ik_muuntS (0,0,500 );    if sa<>''  then s := s +';' +sa +'  muunt. 500 kVA';
           sa := Ik_muuntS (0,0,200 );    if sa<>''  then s := s +';' +sa +'  muunt. 200 kVA';
           sa := Ik_muuntS (0,0,100 );    if sa<>''  then s := s +';' +sa +'  muunt. 100 kVA';
           sa := Ik_muuntS (0,0,50  );    if sa<>''  then s := s +';' +sa +'  muunt. 50 kVA';
           sa := Ik_muuntS (0,0,10  );    if sa<>''  then s := s +';' +sa +'  muunt. 10 kVA';
                             //,,Lasketaan AXMK 185 :lla laskettu Ik1v toiselle kaapelityypille.....//<,, +4.0.1
           s := s +';=== Siirra A jälkeen ===';
           if Ik1v_Zaxmk_Per_Zuusi ('AXMK' ,300,40, r1)  then s := s +';' +fMrkvia (r1,4) +'  axmk 300';
           if Ik1v_Zaxmk_Per_Zuusi ('AXMK' ,240,40, r1)  then s := s +';' +fMrkvia (r1,4) +'  axmk 240';
           if Ik1v_Zaxmk_Per_Zuusi ('AXMK' ,185,40, r1)  then s := s +';' +fMrkvia (r1,4) +'  axmk 185 olet.';
           if Ik1v_Zaxmk_Per_Zuusi ('AXMK' ,120,40, r1)  then s := s +';' +fMrkvia (r1,4) +'  axmk 120';
           if Ik1v_Zaxmk_Per_Zuusi ('AXMK' , 70,40, r1)  then s := s +';' +fMrkvia (r1,4) +'  axmk 70';
           if Ik1v_Zaxmk_Per_Zuusi ('AXMK' , 16,40, r1)  then s := s +';' +fMrkvia (r1,4) +'  axmk 16';
           if Ik1v_Zaxmk_Per_Zuusi ('AMCMK',240,40, r1)  then s := s +';' +fMrkvia (r1,4) +'  axmk 240';
           if Ik1v_Zaxmk_Per_Zuusi ('AMCMK',185,40, r1)  then s := s +';' +fMrkvia (r1,4) +'  axmk 185';
           if Ik1v_Zaxmk_Per_Zuusi ('AMCMK',120,40, r1)  then s := s +';' +fMrkvia (r1,4) +'  axmk 120';
           if Ik1v_Zaxmk_Per_Zuusi ('AMCMK', 70,40, r1)  then s := s +';' +fMrkvia (r1,4) +'  axmk 70';
           if Ik1v_Zaxmk_Per_Zuusi ('AMCMK', 16,40, r1)  then s := s +';' +fMrkvia (r1,4) +'  axmk 16';
           if Ik1v_Zaxmk_Per_Zuusi ('AMKA' ,120,40, r1)  then s := s +';' +fMrkvia (r1,4) +'  amka 120';
           if Ik1v_Zaxmk_Per_Zuusi ('AMKA' , 70,40, r1)  then s := s +';' +fMrkvia (r1,4) +'  amka 70';
           if Ik1v_Zaxmk_Per_Zuusi ('AMKA' , 16,40, r1)  then s := s +';' +fMrkvia (r1,4) +'  amka 16';
           s := s +';==================';
           //sa := '18.1101';{=800kVA:n navoissa}   if Pos (sa,s)=0  then s := s +';' +sa;  end;
           LisaaVEja ('18.1101 (800 kVA+yv)',s);  end; //<Lisätään kylmästi loppuun, koska ..kVA puuttuu kuitenkin.
//,Iks3v
{r}2 :begin s := veA4( edv.Sorc[mmm].src.Iks3v, edvf.Sorc[mmm].src.Iks3v, edv0.Sorc[mmm].src.Iks3v);
           sa := Ik_muuntS (1,0,2000);    if sa<>''  then s := s +';' +sa +'  muunt. 2 MVA';          //<,, +4.0.1
           sa := Ik_muuntS (1,0,1600);    if sa<>''  then s := s +';' +sa +'  muunt. 1.6 MVA';
           sa := Ik_muuntS (1,0,1250);    if sa<>''  then s := s +';' +sa +'  muunt. 1.25 MVA';
           sa := Ik_muuntS (1,0,1000);    if sa<>''  then s := s +';' +sa +'  muunt. 1 MVA';
           sa := Ik_muuntS (1,0,800 );    if sa<>''  then s := s +';' +sa +'  muunt. 800 kVA';
           sa := Ik_muuntS (1,0,500 );    if sa<>''  then s := s +';' +sa +'  muunt. 500 kVA';
           sa := Ik_muuntS (1,0,200 );    if sa<>''  then s := s +';' +sa +'  muunt. 200 kVA';
           sa := Ik_muuntS (1,0,100 );    if sa<>''  then s := s +';' +sa +'  muunt. 100 kVA';
           sa := Ik_muuntS (1,0,50  );    if sa<>''  then s := s +';' +sa +'  muunt. 50 kVA';
           sa := Ik_muuntS (1,0,10  );    if sa<>''  then s := s +';' +sa +'  muunt. 10 kVA';
           sa := Ik_muuntS (1,1,800 );    if sa<>''  then s := s +';' +sa +'  (800 kVA+yv)';
           //LisaaVEja (fRmrktRaj (Iks3v_ol/1000, edv.Sorc[mmm].src.Iks3v), s);  end;                   //< +2.0.5
           sa := fRmrktRaj (Iks3v_ol/1000, edv.Sorc[mmm].src.Iks3v);                                    //< +4.0.1
                                       if sa<>''  then s := s +';' +sa +'  = f (Ik1v,eRs)';
           LisaaVEja ('',s){Delaa loppunollat kuten ed. rvllä +8.0.8};  end;
//,pjLiitRs
{r}3:begin s := fMrktRaj( edv.Sorc[mmm].src.pjLiitRs); //,,Lasketaan pudotusvalikkoon itemit eRs :lle eri R/X -suhteilla.
         //if s<>''  then s := s +'  Ed.istunto';                                                      //,, +4.0.1
           sa := eRs_RperX (fRpX_kaap (1,'AXMK', 300,40));    if sa<>''  then s := s +';' +sa +'  axmk 300';
           sa := eRs_RperX (fRpX_kaap (1,'AXMK', 240,40));    if sa<>''  then s := s +';' +sa +'  axmk 240';
           sa := eRs_RperX (fRpX_kaap (1,'AXMK', 185,40));    if sa<>''  then s := s +';' +sa +'  axmk 185';
           sa := eRs_RperX (fRpX_kaap (1,'AXMK', 120,40));    if sa<>''  then s := s +';' +sa +'  axmk 120';
           sa := eRs_RperX (fRpX_kaap (1,'AXMK', 70 ,40));    if sa<>''  then s := s +';' +sa +'  axmk 70';
           sa := eRs_RperX (fRpX_kaap (1,'AXMK', 16 ,40));    if sa<>''  then s := s +';' +sa +'  axmk 16';
           sa := eRs_RperX (fRpX_kaap (1,'AMCMK',240,40));    if sa<>''  then s := s +';' +sa +'  amcmk 240';
           sa := eRs_RperX (fRpX_kaap (1,'AMCMK',185,40));    if sa<>''  then s := s +';' +sa +'  amcmk 185';
           sa := eRs_RperX (fRpX_kaap (1,'AMCMK',120,40));    if sa<>''  then s := s +';' +sa +'  amcmk 120';
           sa := eRs_RperX (fRpX_kaap (1,'AMCMK',70 ,40));    if sa<>''  then s := s +';' +sa +'  amcmk 70';
           sa := eRs_RperX (fRpX_kaap (1,'AMCMK',16 ,40));    if sa<>''  then s := s +';' +sa +'  amcmk 16';
           sa := eRs_RperX (fRpX_kaap (1,'AMKA', 120,40));    if sa<>''  then s := s +';' +sa +'  amka 120';
           sa := eRs_RperX (fRpX_kaap (1,'AMKA', 70 ,40));    if sa<>''  then s := s +';' +sa +'  amka 70';
           sa := eRs_RperX (fRpX_kaap (1,'AMKA', 16 ,40));    if sa<>''  then s := s +';' +sa +'  amka 16';
           sa := eRs_RperX (0.116);    if sa<>''  then s := s +';' +sa +'  muunt. 2 MVA';
           sa := eRs_RperX (0.167);    if sa<>''  then s := s +';' +sa +'  muunt. 800 kVA';
           sa := eRs_RperX (2.18 );    if sa<>''  then s := s +';' +sa +'  muunt. 10 kVA';
           sa := fMrktRaj( edvf.Sorc[mmm].src.pjLiitRs);  if Pos (sa,s)=0  then s := s +';' +sa; //<,=0 jos SA ei löydy S :stä
           sa := fMrktRaj( edv0.Sorc[mmm].src.pjLiitRs);  if Pos (sa,s)=0  then s := s +';' +sa;
              sa := Trim (SyottoFrm.ComBx1.Text);                                               //<+6.2.10
              if SokR (sa,r1)  then begin            //< sa = Ik1v [kA] => r1
                 r2 := fLas_Iks1v_Zs (r1);           //< Ik1v(=r1)      => Zs(=r2)
                 sa := fRmrkt0 (r2/3,1,-8);  s := s +';' +sa +'  MaxZs';  end;
          {sa := '0.00189867';                  if Pos (sa,s)=0  then s := s +';' +sa; //< 800kVA:n navoissa
           i := Pos (sa,s);   i1 := Length (sa);     //< sa :ssa vielä tallessa ao. arvo
           if i<>0  then begin                       //<Kylläkin pakko olla; vastahan lisättiin joseioo
              sb := Copy (s,1,i+i1-1);               //<Kopioidaan sa :n LOPPUUN, johon lisätään,,
              sb := sb +' (800kVA)';
              sb := sb +Copy (s,i+i1,Length (s));
              s := sb;  end;   end;}                      //, 800kVA:n navoissa
           LisaaVEja ('0.00189867 (800 kVA+yv)',s);  end; //<Lisätään kylmästi loppuun, koska ..kVA puuttuu kuitenkin.
{r 4 =Tyhjä rivi =Ei Boxia.}
{r}5 :s := SyoKut_PEN_PE (SyottoFrm.ComBx5.Text);
   end;//case riv of

//,,¤¤¤¤¤¤¤¤¤¤¤ ValintaLaji:  66=Apulask.¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
66:case riv of //66=Apulask.    ValintaLaji:  0=Sj  1=Pj  66=Apulask.  2=Gen  3=UPS,  edv.Sorc[mmm].src.SorceKind EHKEIokVielä.
{riv,,}
  11 :begin r1 := Yvrk [riv];                        //<===== U1 ===================================
            if r1>0  then s := fVexNS (r1)
                     else s := '20';
            sa := fVexNS (fUn/1000);
          //lisaaVEja (sa +';6;6.3;10;10.5;20;20.5;21;22;25;30;33;36;40;45;55;66;110;400', s);  end; -6.0.4
            s := s +';'+sa +';6;6.3;10;10.5;20;20.5;21;22;25;30;33;36;40;45;55;66;110;400';  end;
  12 :begin r1 := Yvrk [riv];                        //< Sk.
            sa := fMrkvia (r1,5);
            sb := '250;500';                         //< 250 MVA = 7.216878kA*V¨3*20kV, ks. AO.RIVIT,  500= +6.0.4
            if r1>0  then lisaaVEja (sa +';' +sb, s)
                     else s := sb;  end;
  14 :begin r1 := Yvrk [riv];                        //<===== Ry ===================================
            sa := fMrkvia (r1,8);  sb := '0.48';    //< Ry = Cos*Z;   Z = U1 /(V¨3*Ik3v) (Ruudulta pasted)
            if r1>0  then lisaaVEja (sa +';' +sb, s)
                     else s := sb;  end;
  16 :begin r1 := Yvrk [riv];                        //<===== Sm[MVA] ==============================
            sa := fMrkvia (r1,3);   sb := '3.15';
            if r1>0  then lisaaVEja (sa +';' +sb, s)
                     else s := sb;
           {lisaaVEja ('0.03;0.05;0.1;0.2;0.315;0.5;0.63;0.8;1.0;1.25;1.6;2.0;2.5;3.15;4;5;6.3;' +
                       '8;10;16;20;25;31.5;40;50;63', s);   end;                                    -6.0.4}
            s := s +';0.03;0.05;0.1;0.2;0.315;0.5;0.63;0.8;1.0;1.25;1.6;2.0;2.5;3.15;4;5;6.3;' +
                     '8;10;16;20;25;31.5;40;50;63';   end;
  17 :begin r1 := Yvrk [riv];                        //<===== Zk% ==================================
          //sa := fMrkvia (r1,3);   sb := '7.15  % 3.15 MVA';    //< 3.15 MVA :n (Sn) mukaan
            sa := fMrkvia (r1,3);   sb := '7.15';                //< 3.15 MVA :n (Sn) mukaan
            if r1>0  then lisaaVEja (sa +';' +sb, s)
                     else s := sb;                               //,,TTT v.2000 s.317..319
            s := s +';=== 20.5/0.4 kV ===;3.9  = 0.03 MVA;3.9  = 0.05 MVA;3.8  = 0.1 MVA;4.0  = 0.2 MVA;'+
                    '4.5  = 0.315 MVA;5.0  = 0.5 MVA;'+ //<'HävSrj 2
                    '5.0  = 0.63 MVA;5.5  = 0.8 MVA;5.5  = 1.0 MVA;5.5  = 1.25 MVA;5.5  = 1.6 MVA;'+
                    '6.0  = 2.0 MVA;6.0  = 2.5 MVA;'+   //<'HävSrj 1
                    '=== 20/10.5 kV ===;7.15  = 3.15 MVA;7.15  = 4 MVA;7.15  = 5 MVA;7.15  = 6.3 MVA;'+
                    '8.35  = 8 MVA;8.35  = 10 MVA;'+
                    '=== 110/21&10 kV ===;10  = 10 MVA;10  = 16 MVA;10  = 20 MVA;'+
                    '10  = 25 MVA;10  = 31.5 MVA;12  = 40 MVA;12  = 50 MVA;12  = 63 MVA';   end;
  18 :begin r2 := Yvrk [riv];                        //<===== U2 ===================================
            if r2>0  then s := fVexNS (r2)                       //<Loppunollat vex.
                     else r2 := 6;                               //<Alkueditointi = 1.krlla.
            r1 := Yvrk [11];                                     //< U1.
            if r1>r2  then s := fVexNS (r2)  else                //<Normaali tilanne = kaikki OK.
            if r1<=r2  then begin                                //<,,SiirraY_Btn´illa.
               if r1>110  then s := '110'  else
               if r1> 45  then s :=  '45'  else
               if r1> 21  then s :=  '21'  else
               if r1> 10  then s :=  '10'  else
               if r1>  6  then s :=  '6'  else
               if r1>1  then s := fVexNS (fUn/1000)
                        else s := '0.024';  end;                 //< 0.01 => 0.024  10.0.4 .
           {if SyottoFrm.RadGrp.ItemIndex=1  then }sb := fMrkvia (fUn/1000,3); //< 0=Sj,  1=Pj. edv...SjPj EHKEIokVielä.
          //lisaaVEja (sb+';6.3;10;10.5;20;20.5;21;22;25;30;33;36;40;45;55;66;110', s);  end;       -6.0.4
            s := s +';'+sb+';6.3;10;10.5;20;20.5;21;22;25;30;33;36;40;45;55;66;110';  end;
  19 :begin r1 := Yvrk [riv];                        //<===== Rv ===================================
            sa := fMrkvia (r1,6);  sb := '0.3';      //< 10 kV:n Wiski 120 mm²:n mukaan
            if r1>0  then lisaaVEja (sa +';' +sb, s)
                     else s := sb;                s := s +';' +
            '===AXMK 1kV===';                        //,,Vain r2 käytetään (r1=Zj, r2=Rj, r3=Xj     //<,, +4.0.1
               ZkaapN (1,'AXMK', 16,40, r1,r2,r3);   sa := fMrkvia (r2*1000,5);   s := s +';' +sa +'   16';
               ZkaapN (1,'AXMK', 35,40, r1,r2,r3);   sa := fMrkvia (r2*1000,5);   s := s +';' +sa +'   35';
               ZkaapN (1,'AXMK', 70,40, r1,r2,r3);   sa := fMrkvia (r2*1000,5);   s := s +';' +sa +'   70';
               ZkaapN (1,'AXMK',120,40, r1,r2,r3);   sa := fMrkvia (r2*1000,5);   s := s +';' +sa +'   120';
               ZkaapN (1,'AXMK',185,40, r1,r2,r3);   sa := fMrkvia (r2*1000,5);   s := s +';' +sa +'   185';
               ZkaapN (1,'AXMK',240,40, r1,r2,r3);   sa := fMrkvia (r2*1000,5);   s := s +';' +sa +'   240';
               ZkaapN (1,'AXMK',300,40, r1,r2,r3);   sa := fMrkvia (r2*1000,5);   s := s +';' +sa +'   300';
            s := s +';' +                                           //*1000'' =Ohm/km
            '===AMCMK3½ 1kV===';                     //,,Vain r2 käytetään (r1=Zj, r2=Rj, r3=Xj     //<,, +6.0.4
               ZkaapN (1,'AMCMK', 16,40, r1,r2,r3);   sa := fMrkvia (r2*1000,5);   s := s +';' +sa +'   16';
               ZkaapN (1,'AMCMK', 35,40, r1,r2,r3);   sa := fMrkvia (r2*1000,5);   s := s +';' +sa +'   35';
               ZkaapN (1,'AMCMK', 70,40, r1,r2,r3);   sa := fMrkvia (r2*1000,5);   s := s +';' +sa +'   70';
               ZkaapN (1,'AMCMK',120,40, r1,r2,r3);   sa := fMrkvia (r2*1000,5);   s := s +';' +sa +'   120';
               ZkaapN (1,'AMCMK',185,40, r1,r2,r3);   sa := fMrkvia (r2*1000,5);   s := s +';' +sa +'   185';
               ZkaapN (1,'AMCMK',240,40, r1,r2,r3);   sa := fMrkvia (r2*1000,5);   s := s +';' +sa +'   240';
               ZkaapN (1,'AMCMK',300,40, r1,r2,r3);   sa := fMrkvia (r2*1000,5);   s := s +';' +sa +'   300';
            s := s +';' +
            '===Wiski 10 kV===;'+ '0.3   120;'+   '0.2   185;'+   '0.15  240;'+   '0.12  300;'+
            '===Wiski 20 kV===;'+ '0.53  70;' +   '0.38  95;' +   '0.3   120;'+   '0.25  150;'+
                                  '0.2   185;'+   '0.15  240;'+   '0.12  300;'+
            '===ahxlmk3 taso==;'+ '0.15   300  110kV;'+   '0.1    500  110kV;'+   '0.078  800  110kV;'+
                                  '0.071  1200 110kV;'+
            '===ahxlmk3 kolmio=;'+  '0.15   300  110kV;'+     '0.11   500  110kV;'+    '0.08   800  110kV;'+
                                    '0.071  1200 110kV;'+
            '===Al/Fe avo<110 kV;'+ '0.692  Savo 42/25;'+     '0.543  Raven 54/9;'+    '0.32   Imatra 93/39;'+
                                    '0.275  Ssavo 106/25;'+   '0.192  Ostric 152/25;'+ '0.192  Piper 152/35;'+
                                    '0.145  Ibis 201/33;'+    '0.12   Hawk 242/39;'+   '0.0988  Duck 305/39;'+
                                    '0.0759  Condor 402/52;'+ '0.0549  Finch 565/72;'+
            '=== PLKVJ 10 kV===;'+  '1.909  10;'+  '1.299  16;'+  '0.787  25;'+  '0.568  35;'+  '0.422  50;'+
                                    '0.292  70;'+  '0.212  95;'+  '0.169  120;'+ '0.112  185;'+
            '=== APYAKMM 10 kV===;'+'0.792  25;'+  '0.573  35;'+  '0.899  50;'+  '0.485  70;'+  '0.353  95;'+
                                    '0.281  120;'+ '0.231  150;'+ '0.187  185;'+ '0.147  240;'+ '0.121  300';  end;

  //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Oikean puolen apulaskennan Boxit
  31 :begin r1 := Yvrk [riv];                        //<===== R/X ==================================
            sa := fMrkvia (r1,5);  if r1>0  then sa := sa +'   (=' +fMrkvia (arcTang (1/r1) ,3) +'°)';
            sb := '0.4'                                   +'   (=' +fMrkvia (arcTang (1/0.4),3) +'°)';
            if r1>0  then lisaaVEja (sa +';' +sb, s)
                     else s := sb;                s := s +';' +
            '===AXMK 1kV===';                        //,,Vain r2,r3 käytetään (r1=Zj, r2=Rj, r3=Xj    //<,, +6.0.4
               ZkaapN (1,'AXMK', 16,40, r1,r2,r3);   sa := fMrkvia (r2/r3,4);   s := s +';' +sa +'   16';
               ZkaapN (1,'AXMK', 35,40, r1,r2,r3);   sa := fMrkvia (r2/r3,4);   s := s +';' +sa +'   35';
               ZkaapN (1,'AXMK', 70,40, r1,r2,r3);   sa := fMrkvia (r2/r3,4);   s := s +';' +sa +'   70';
               ZkaapN (1,'AXMK',120,40, r1,r2,r3);   sa := fMrkvia (r2/r3,4);   s := s +';' +sa +'   120';
               ZkaapN (1,'AXMK',185,40, r1,r2,r3);   sa := fMrkvia (r2/r3,4);   s := s +';' +sa +'   185';
               ZkaapN (1,'AXMK',240,40, r1,r2,r3);   sa := fMrkvia (r2/r3,4);   s := s +';' +sa +'   240';
               ZkaapN (1,'AXMK',300,40, r1,r2,r3);   sa := fMrkvia (r2/r3,4);   s := s +';' +sa +'   300';
            s := s +';' +                                           //*1000'' =Ohm/km
            '===AMCMK3½ 1kV===';
               ZkaapN (1,'AMCMK', 16,40, r1,r2,r3);   sa := fMrkvia (r2/r3,4);   s := s +';' +sa +'   16';
               ZkaapN (1,'AMCMK', 35,40, r1,r2,r3);   sa := fMrkvia (r2/r3,4);   s := s +';' +sa +'   35';
               ZkaapN (1,'AMCMK', 70,40, r1,r2,r3);   sa := fMrkvia (r2/r3,4);   s := s +';' +sa +'   70';
               ZkaapN (1,'AMCMK',120,40, r1,r2,r3);   sa := fMrkvia (r2/r3,4);   s := s +';' +sa +'   120';
               ZkaapN (1,'AMCMK',185,40, r1,r2,r3);   sa := fMrkvia (r2/r3,4);   s := s +';' +sa +'   185';
               ZkaapN (1,'AMCMK',240,40, r1,r2,r3);   sa := fMrkvia (r2/r3,4);   s := s +';' +sa +'   240';
               ZkaapN (1,'AMCMK',300,40, r1,r2,r3);   sa := fMrkvia (r2/r3,4);   s := s +';' +sa +'   300';
            s := s +';' +                                           //*1000'' =Ohm/km
            '===Wiski 10kV===;'+  '2.586  120;'+  '1.873  185;'+  '1.5    240;'+  '1.2    300;'+    //<,, +4.0.1
            '===Wiski 20kV===;'+  '4.015  70;'+   '3.016  95;'+   '2.439  120;'+  '2.155  150;'+  '1.77   185;'+
                                  '1.364  240;'+  '1.121  300;'+
            '===ahxlmk3 taso==;'+   '0.77    300 110kV;'+     '0.5305  500 110kV;'+  '0.4434  800 110kV;'+ '0.4186  1200 110kV;'+
            '===ahxlmk3 kolmio=;'+  '1.085   300 110kV;'+     '0.854   500 110kV;'+  '0.6885  800 110kV;'+  '0.6455  1200 110kV;'+
            '===Al/Fe avo<110 kV;'+ '1.845   Savo 42/25;'+    '1.484   Raven 54/9;'+    '0.944   Imatra 93/39;'+
                                    '0.8594  S.savo 106/25;'+ '0.615   Ostric 152/25;'+ '0.621   Piper 152/35;'+
                                    '0.48    Ibis 201/33;'+   '0.4068  Hawk 242/39;'+   '0.3407  Duck 305/39;'+
                                    '0.2691  Condor 402/52;'+ '0.2026  Finch 565/72';   end;

  32 :begin r1 := Yvrk [riv];                        //<===== Ik3v =================================
            sa := fMrkvia (r1,4);   sb := '7.217';   //<250MVA =7.216878kA*V¨3*20kV, ks. AO.RIVIT (Ruudulta pasted)
            if r1>0  then lisaaVEja (sa +';' +sb, s)
                     else s := sb;  end;

  34 :begin{sa := fMrkvia (12345.123456, 4);
            sa := fMrkvia (12345.123456, 5);
            sa := fMrkvia (12345.123456, 6);
            sa := fMrkvia (12345.123456, 11);
            sa := fMrkvia (12345.123456, 12);
            sa := fMrkvia (12345.123456, 13);

            sa := fMrkvia (0.0000012345, 1);
            sa := fMrkvia (0.0000012345, 6);
            sa := fMrkvia (0.0000012345, 7);
            sa := fMrkvia (0.0000012345, 8);

            sa := fMrkvia (0.0000015263, 9);
            sa := fMrkvia (0.0000015263,10);
            sa := fMrkvia (0.0000015263,11);
            sa := fMrkvia (0.0000015263,12);//}

            r1 := Yvrk [riv];                        //<===== Xy ===================================
            sa := fMrkvia (r1,8);     sb := '1.5263027'; //< Xy = V¨(Z²-Ry²);   Z = U1 /(V¨3*Ik3v) (Ruudulta pasted)
            if r1>0  then lisaaVEja (sa +';' +sb, s)
                     else s := sb;  end;
  37 :begin r1 := Yvrk [riv];                        //<===== Pk ===================================
            sa := fMrkvia (r1,4);   sb := '25';      //< 3.15 MVA :n mukaan
            if r1>0  then lisaaVEja (sa +';' +sb, s)
                     else s := sb;                s := s +    //,,TTT v.2000 s.317..319
            ';=== 20.5/0.4 kV ===;0.585  = 0.03 MVA;0.885  = 0.05 MVA;1.485  = 0.1 MVA;2.295  = 0.2 MVA;'+
            '4.5  = 0.315 MVA;6.6  = 0.5 MVA;'+               //<'HävSrj 2
            '7.2  = 0.63 MVA;8.5  = 0.8 MVA;10.2  = 1.0 MVA;11.5  = 1.25 MVA;'+
            '14.1  = 1.6 MVA;16  = 2.0 MVA;18  = 2.5 MVA;'+   //<'HävSrj 1
            '=== 20/10.5 kV ===;25  = 3.15 MVA;29  = 4 MVA;36.5  = 5 MVA;'+
            '48  = 6.3 MVA;57.5  = 8 MVA;77.5  = 10 MVA;'+
            '=== 110/21&10 kV ===;82  = 16 MVA;96  = 20 MVA;112  = 25 MVA;'+
            '136  = 31.5 MVA;168  = 40 MVA;198  = 50 MVA;238  = 63 MVA';   end;
  38 :begin r1 := Yvrk [riv];                        //<===== L[km] ================================
            if r1<0  then r1 := 0;                   //<+10.0.4  Alustus -1 on jäänyt voimaan.
            sa := fMrkvia (r1,4);   {sb := '0.1';    //<,,6.0.0a
            if r1>0  then lisaaVEja (sa +';' +sb, s)
                     else s := sb;  end;}
            if sa=''  then sa := '0';                //<Varm.vuoksi +6.0.0a
            s := sa;  end;
  39 :begin r1 := Yvrk [riv];                        //<===== Xv ===================================
            sa := fMrkvia (r1,6);   sb := '0.116';   //< 10 kV:n Wiski 120 mm²:n mukaan
            if r1>0  then lisaaVEja (sa +';' +sb, s)
                     else s := sb;                s := s +';' +
            '===AXMK 1kV===';                        //,,Vain r3 käytetään (r1=Zj, r2=Rj, r3=Xj     //<,, +4.0.1
               ZkaapN (1,'AXMK', 16,40, r1,r2,r3);   sa := fMrkvia (r3*1000,5);   s := s +';' +sa +'   16';
               ZkaapN (1,'AXMK', 35,40, r1,r2,r3);   sa := fMrkvia (r3*1000,5);   s := s +';' +sa +'   35';
               ZkaapN (1,'AXMK', 70,40, r1,r2,r3);   sa := fMrkvia (r3*1000,5);   s := s +';' +sa +'   70';
               ZkaapN (1,'AXMK',120,40, r1,r2,r3);   sa := fMrkvia (r3*1000,5);   s := s +';' +sa +'   120';
               ZkaapN (1,'AXMK',185,40, r1,r2,r3);   sa := fMrkvia (r3*1000,5);   s := s +';' +sa +'   185';
               ZkaapN (1,'AXMK',240,40, r1,r2,r3);   sa := fMrkvia (r3*1000,5);   s := s +';' +sa +'   240';
               ZkaapN (1,'AXMK',300,40, r1,r2,r3);   sa := fMrkvia (r3*1000,5);   s := s +';' +sa +'   300';
            s := s +';' +                                           //*1000'' =Ohm/km
            '===AXMK 1kV===';                        //,,Vain r3 käytetään (r1=Zj, r2=Rj, r3=Xj     //<,, +6.0.4
               ZkaapN (1,'AMCMK', 16,40, r1,r2,r3);   sa := fMrkvia (r3*1000,5);   s := s +';' +sa +'   16';
               ZkaapN (1,'AMCMK', 35,40, r1,r2,r3);   sa := fMrkvia (r3*1000,5);   s := s +';' +sa +'   35';
               ZkaapN (1,'AMCMK', 70,40, r1,r2,r3);   sa := fMrkvia (r3*1000,5);   s := s +';' +sa +'   70';
               ZkaapN (1,'AMCMK',120,40, r1,r2,r3);   sa := fMrkvia (r3*1000,5);   s := s +';' +sa +'   120';
               ZkaapN (1,'AMCMK',185,40, r1,r2,r3);   sa := fMrkvia (r3*1000,5);   s := s +';' +sa +'   185';
               ZkaapN (1,'AMCMK',240,40, r1,r2,r3);   sa := fMrkvia (r3*1000,5);   s := s +';' +sa +'   240';
               ZkaapN (1,'AMCMK',300,40, r1,r2,r3);   sa := fMrkvia (r3*1000,5);   s := s +';' +sa +'   300';
            s := s +';' +                                           //*1000'' =Ohm/km
            '===Wiski 10kV===;'+ '0.116  120;'+   '0.1068 185;'+   '0.1    240;'+   '0.1    300;'+
            '===Wiski 20kV===;'+ '0.132  70;'+    '0.126  95;'+    '0.123  120;'+   '0.116  150;'+
                                 '0.113  185;'+   '0.11   240;'+   '0.107  300;'+
            '===ahxlmk3 taso===;'+  '0.1948  300 110kV;'+   '0.1885  500 110kV;'+    '0.1759  800 110kV;'+ '0.1696  1200 110kV;'+
            '===ahxlmk3 kolmio=;'+  '0.1382  300 110kV;'+   '0.1288  500 110kV;'+    '0.1162  800 110kV;'+ '0.11    1200 110kV;'+
            '===Al/Fe avo<110 kV;'+ '0.375  Savo 42/25;'+   '0.366  Raven 54/9;'+    '0.339  Imatra 93/39;'+
                                    '0.32   S.savo 106/25;'+ '0.312  Ostric 152/25;'+ '0.309  Piper 152/35;'+
                                    '0.302  Ibis 201/33;'+   '0.295  Hawk 242/39;'+   '0.29   Duck 305/39;'+
                                    '0.282  Condor 402/52;'+ '0.271  Finch 565/72;'+
            '=== >110 kV===;' +'0.4  Yleensä;'+  '0.3  Tandb,Nippu;'+
            '=== PLKVJ 10 kV===;'+  '0.141  10;'+  '0.132  16;'+  '0.123  25;'+  '0.113  35;'+  '0.107  50;'+
                                    '0.101  70;'+  '0.097  95;'+  '0.094  120;'+ '0.081  185;'+
             '=== APYAKMM 10 kV===;'+'0.132  25;'+ '0.125  35;'+  '0.118  50;'+  '0.112  70;'+  '0.101  95;'+
                                     '0.102  120;'+'0.101  150;'+ '0.097  185;'+ '0.094  240;'+ '0.082  300';
{'=== PLKVJ 10 kV===                    '=== APYAKMM 10 kV===
1.909/0.141   10    0.292/0.101   70    0.792/0.132   25
1.299/0.132   16    0.212/0.097   95    0.573/0.125   35
0.787/0.123   25    0.169/0.094  120    0.899/0.118   50
0.568/0.113   35    0.112/0.081  185    0.485/0.112   70
0.422/0.107   50                        0.353/0.101   95}
      end;
  41 :begin r1 := Yvrk [riv];                        //<===== Lv[mH/km] ============================
            sa := fMrkvia (r1,6);   sb := '0.37';    //< Lv = Xv*1000 / (2*Pii*f)
            if r1>0  then lisaaVEja (sa +';' +sb, s)
                     else s := sb;  end;
   end;//case riv
//end;//case ValintaLaji //<KoeSiirtoTähän ha loppu kommentoitu vex:  => OK =Poisti "might be undefined"

//,,¤¤¤¤¤¤¤¤¤¤¤ ValintaLaji:  2=Vv ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
2 :case riv of //2=Vv.    ValintaLaji:  0=Sj  1=Pj  66=Apulask.  2=Gen  3=UPS,  edv.Sorc[mmm].src.SorceKind EHKEIok
{riv,,}
   1 :begin s := veA4( edv.Sorc[mmm].src.gSn, edvf.Sorc[mmm].src.gSn, edv0.Sorc[mmm].src.gSn); //,Oli: '1985;1490;1110;1090;1000;910;800;400;350;300;250',s);  end;
           LisaaVEja ('  Stamford:..;1985;1490;1110;1090;1000;910;800;400;350;300;250;  Wilson:..;910;880;600;510;380;275;160;110;50;',s);  end; //+1411.
   2 :begin s := veA4( edv.Sorc[mmm].src.gXd, edvf.Sorc[mmm].src.gXd, edv0.Sorc[mmm].src.gXd);
            LisaaVEja ('3.11  (1985);2.60  (1490);2.82  (1110);2.82  (1090);2.73  (1000);2.70  (910);2.83  (800);'+
                       '2.45  (400);2.51  (350);2.85  (300);2.84  (250)',s);  end;
(*   end;//case riv of
end;//case ValintaLaji //<KoeSiirtoTähän ha loppu kommentoitu vex:  => OK =Poisti "might be undefined"
  §u Jos tästä loppuun kommentoitu vex, 'BxItems' might be undefined -herja jäisi vex.*)

   3 :begin s := veA4( edv.Sorc[mmm].src.gXd1, edvf.Sorc[mmm].src.gXd1, edv0.Sorc[mmm].src.gXd1);
            LisaaVEja ('0.16  (1490);0.17  (1110);0.17  (1090);0.22  (1000);0.23  (910);0.23  (800);0.16  (400);'+
                       '0.18  (350);0.18  (300);0.18  (250)',s);  end;
   4 :begin s := veA4( edv.Sorc[mmm].src.gXd2, edvf.Sorc[mmm].src.gXd2, edv0.Sorc[mmm].src.gXd2);
            LisaaVEja ('0.12  (1490);0.13  (1110);0.13  (1090);0.15  (1000);0.16  (910);0.16  (800);0.12  (400);'+
                       '0.13  (350);0.13  (300);0.13  (250)',s);  end;
   5 :begin s := veA4( edv.Sorc[mmm].src.gRs, edvf.Sorc[mmm].src.gRs, edv0.Sorc[mmm].src.gRs);
            LisaaVEja ('0.0008  (1985);0.00114 (1490);0.002   (1110);0.0016  (1090);0.0024  (1000);'+
                       '0.003   (910);0.003   (800);0.0073  (400);0.009   (350);0.0124  (300);'+
                       '0.0166  (250)',s);  end;
   6 :begin s := veA4( edv.Sorc[mmm].src.gTd1, edvf.Sorc[mmm].src.gTd1, edv0.Sorc[mmm].src.gTd1);
            LisaaVEja ('0.137 (1490);0.13  (1110);0.13  (1090);0.185 (1000);0.185 (910);0.185 (800);'+
                       '0.08  (400);0.08  (350);0.08  (300);0.08  (250)',s);  end;
   7 :begin s := veA4( edv.Sorc[mmm].src.gTd2, edvf.Sorc[mmm].src.gTd2, edv0.Sorc[mmm].src.gTd2);
            LisaaVEja ('0.01  (1490);0.01  (1110);0.01  (1090);0.025 (1000);0.025 (910);0.025 (800);'+
                       '0.019 (400);0.019 (350);0.019 (300);0.019 (250)',s);  end;
   8 :begin s := veA4( edv.Sorc[mmm].src.gtIkMin, edvf.Sorc[mmm].src.gtIkMin, edv0.Sorc[mmm].src.gtIkMin);
            LisaaVEja ('0.31  (1985);0.31  (1490);0.25  (1110);0.33  (1090);0.25  (1000);0.24  (910);'+
                       '0.24  (800);0.1   (400);0.11  (350);0.1   (300);0.095 (250)',s);  end;
   9 :begin s := veA4( edv.Sorc[mmm].src.gtIkSust, edvf.Sorc[mmm].src.gtIkSust, edv0.Sorc[mmm].src.gtIkSust);
            LisaaVEja ('0.9   (1985);0.9   (1490);0.6   (1110);1.0   (1090);0.55  (1000);0.55  (910);'+
                       '0.53  (800);0.24  (400);0.35  (350);0.25  (300);0.25  (250);',s);  end;
  10 :begin s := veA4( edv.Sorc[mmm].src.gIkSust, edvf.Sorc[mmm].src.gIkSust, edv0.Sorc[mmm].src.gIkSust);
            LisaaVEja ('9700  (1985);6800  (1490);5200  (1110);5150  (1090);3500  (1000);4000  (910);'+
                       '2900  (800);1750  (400);1600  (350);1200  (300);1100  (250)',s);  end;
  11 :begin s := veA4( edv.Sorc[mmm].src.gK1vSust, edvf.Sorc[mmm].src.gK1vSust, edv0.Sorc[mmm].src.gK1vSust);
            LisaaVEja ('2.5   (1985...200)',s);  end;
  12 :s := SyoKut_PEN_PE (SyottoFrm.ComBx12.Text);
   end;//case riv of

//,,¤¤¤¤¤¤¤¤¤¤¤ ValintaLaji:  3=UPS ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
3 :case riv of //3=UPS    ValintaLaji:  0=Sj  1=Pj  66=Apulask.  2=Gen  3=UPS,  edv.Sorc[mmm].src.SorceKind EHKEIok
   1 :s := veA4 ( edv.Sorc[mmm].src.Ups_Ik1v, edvf.Sorc[mmm].src.Ups_Ik1v, edv0.Sorc[mmm].src.Ups_Ik1v); //<,,+141.1
   2 :s := veA4 ( edv.Sorc[mmm].src.Ups_Ik3v, edvf.Sorc[mmm].src.Ups_Ik3v, edv0.Sorc[mmm].src.Ups_Ik3v);
   3 :s := veA4 ( edv.Sorc[mmm].src.Ups_Cos , edvf.Sorc[mmm].src.Ups_Cos,  edv0.Sorc[mmm].src.Ups_Cos);
   4 :s := SyoKut_PEN_PE (SyottoFrm.ComBx4.Text);         //<,,PEN_PE -lenkki SJ,PJ,Gen, Ehkei UPSille?#################
   end;//case riv of
end;//case ValintaLaji
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§'RadGrp.ItemIndexit LOPPUI, eli kun LIIT.RadGrp oli näkyvissa.'§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//2,7=SyoOs:  0=VrkKuvaajan yläpanelin Bxt  1=Liitt  2=EdvJ  (3=Uh-raj, eiEnää)  4=Nj  5=Häviökust  6=LisätLIITTYMÄ  7=LisätJohto-osa  8=MoottLähdöt
2,7 :if JkUpsChk_Dlg  or JkUpsChk_Cap//SyottoFrm.JkUpsChk.Checked  //(edv.Edka[Edi].JkUps.ArvoInt>0) //<,,+130.3u  +141.2 ..Checked
   then begin  JFileen('1 SyoKut, riv=' +Ints(riv));  Wavu('1 SyoKut.INC/BxItems: SyoOs 2,7=' +Ints(SyoOs) +' riv=' +Ints(riv));
      if SrcEdka  then
      case riv of
         1 :s := veA4(edv.Sorc[edi].Josa.JkUps_Ik1v,  edvf.Sorc[edi].Josa.JkUps_Ik1v,  edv0.Sorc[edi].Josa.JkUps_Ik1v);
       //2 :s := veA4( edv.Sorc[edi].Josa.JkUps_Ik3v,  edvf.Sorc[edi].Josa.JkUps_Ik3v,  edv0.Sorc[edi].Josa.JkUps_Ik3v); //<Ei käytössä JkUps´issa.
       else s := veA4( edv.Sorc[edi].Josa.JkUps_Cos,  edvf.Sorc[edi].Josa.JkUps_Cos,  edv0.Sorc[edi].Josa.JkUps_Cos);  end
      else
      case riv of
         1 :s := veA4( edv.edka[edi].JkUps_Ik1v,  edvf.edka[edi].JkUps_Ik1v,  edv0.edka[edi].JkUps_Ik1v);
       //2 :s := veA4( edv.edka[riv].JkUps_Ik3v,  edvf.edka[riv].JkUps_Ik3v,  edv0.edka[riv].JkUps_Ik3v);      //<Ei käytössä JkUps´issa.
       else s := veA4( edv.edka[edi].JkUps_Cos,   edvf.edka[edi].JkUps_Cos,   edv0.edka[edi].JkUps_Cos);  end; //<141.1
      WBeep([0,0]); //Breakpointille.
   end else                                                                                             //<''+130.3u
   case riv of{;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 2=ao.Edj ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;}//<7=+8.0.0
   1 :begin                                          {,,,,,,,,,,,,,,,,,,Kuluttaja,,,,,,,,,,,,,,,,,,} Wavu('2 SyoKut.INC/BxItems: SyoOs=' +Ints(SyoOs) +' riv=' +Ints(riv));
      IF fOnARv (recA.kuluttaja)
      THEN IF a_getBool (211,recA.kuluttaja)  THEN s := EtsiOlet(0,S_KulSal) //0=1.ve ='KULUTT.'
                                              ELSE s := EtsiOlet(1,S_KulSal) //1=Etsit.listasta 2.ve='SÄHKÖL.'
      ELSE IF (edi>1)
      THEN IF fOnARv (recB.kuluttaja)
           THEN IF a_getBool (212,recB.kuluttaja)  THEN s := EtsiOlet(0,S_KulSal)
                                                   ELSE s := EtsiOlet(1,S_KulSal);
      if s=''  THEN IF edi<=1                      THEN s := EtsiOlet(1,S_KulSal)  //<Perusolet='SÄHKÖL.'
                                                   ELSE s := EtsiOlet(0,S_KulSal);
      s := s+';'+f_VarItems(S_KulSal);       //< ';'=Oletus/Item -kenttäerotin, ks. FNC f_VarItems()
      s := TrimRight(s);                             //<,+6.0.3
      while (s[Length(s)]=';') or (s[Length(s)]='\')  do
         Delete (s,Length(s),1);   end;              //<'+6.0.3
   2 :begin                                          {,,,,,,,,,,,,,,,,,,EdKaTyp,,,,,,,,,,,,,,,,,,,,}
      IF fOnArv (recA.tyyppi)
      THEN s := a_getStrg (221,recA.tyyppi)
      ELSE IF (edi>1)
      THEN s := a_getStrg (222,recB.tyyppi);
     {if edi>edikayty  then begin  a_putStrg (223, 'AXMK',tyyppi);  s := 'AXMK';  end; //<Koe =OK}
      if s=''  THEN s := EtsiOlet(0,S_KaTyp);        //<0=EkaItem =Perusoletus
      s := s+';'+f_VarItems(S_KaTyp);   end; //< ';'=Oletus/Item -kenttäerotin, ks. FNC f_VarItems()
   3 :begin                                          {,,,,,,,,,,,,,,,,,,Amm2,,,,,,,,,,,,,,,,,,,,,,,}
        i := Trunc(recA.Amm2.arvoRea);               //<,,+130.3b:  Pisako raportoi: Vihreilm. .."ei tunne johtotyypin ".." äärijohdinta 3 mm² vastaavaa PE/PEN-johdinta.."
        if i IN [1,2]  then recA.Amm2.arvoRea := i +0.5  else
        if i=3  then recA.Amm2.arvoRea := 2.5; //<'+130.3b:  Pisako raportoi: Vihreilm. .."ei tunne johtotyypin ".." äärijohdinta 3 mm² vastaavaa PE/PEN-johdinta.."
           IF fOnArv (recA.Amm2)
              THEN s :=  fMrktRaj( recA.Amm2);    //<,,-11.0.1   Tässä tapahtui 2.5 => 3 => fDsm nyt korjattu, OK.
           IF fOnArv (recA.tyyppi)
              THEN sa := fMrktRaj( recA.tyyppi);
        IF (s='')  and (edi>1)      THEN s :=  fMrktRaj( recB.Amm2);    //<Pykälä pienempi Cu/Al ???
        IF (sa='') and (edi>1)      THEN sa := fMrktRaj( recB.tyyppi);
        s1 := Trim (SyottoFrm.ComBx2.Text);                    //'Oli sijoitettu, ks. 2:EdKaTyp ####
        if (recA.tyyppi.arvoStr<>s1{recE.tyyppi.arvoStr})
           then sa := s1;                            //<Jotta muuttunut kaaptyyppi saisi omat mm2-vet =+11.0.1}
        if s=''  THEN BEGIN                          //,Tähän ei koskaan ###########################
                   s := '70';                        //#############################################
                   sa :=  EtsiOlet(0,S_KaTyp);  END; //<'70 :lle 0=AMCMK =OK #######################
        s := s+';'; //,,,Tehdään pudotuslista: S_KaTyp:stä tehdään ve-lista AMCMK;AXMK;jne, jota
//      i := 0;     //   iteroidaan kunnes löytyy EdKaTyp, jolloin mm2Arr[i] = ao.16;25;35;jne.lista
//      while EtsiOlet(i,S_KaTyp)<>a_getStrg (231,tyyppi)  do i := i+1;             //<'Oli näin, OK
        i := -1;
        repeat  i := i+1;
                sb := EtsiOlet(i,S_KaTyp);     //###################################################
        until (sb=sa) or (sb='');              //<0..12=13 tyyppiä AMCMK..AvoC+'' ##################
        sa := mm2arr[i];
        i := edikayty;                         //<Vain, jotta debuggerin BreakPointillaEDIKAYTYnäkyy
        s := s +f_VarItems(sa);
          if (s='!') and (sa='!')  then ;      //<Breakpointille.
        end;//with
   4 :begin  IF fOnArv (recA.pituus)                {,,,,,,,,,,,,,,,,,,Pituus,,,,,,,,,,,,,,,,,,,,,}
      THEN begin
           if SrcEdka  then s := veA4( edv.Sorc[edi].Josa.pituus, edvf.Sorc[edi].Josa.pituus, edv0.Sorc[edi].Josa.pituus)
                       else s := veA4( edv.edka[edi].pituus,      edvf.edka[edi].pituus,      edv0.edka[edi].pituus);
      end
      ELSE IF (edi>1)
      THEN if SrcEdka  then s := veA4( edv.Sorc[edi-1].Josa.pituus, edvf.Sorc[edi-1].Josa.pituus, edv0.Sorc[edi-1].Josa.pituus)
                       else s := veA4( edv.edka[edi-1].pituus,      edvf.edka[edi-1].pituus,      edv0.edka[edi-1].pituus);
      lisaaVEja ('5;4.5;4;3.5;3', s);  end;          //<Lisää  s:n perään ;5;4.5...
   5 :begin                                          {,,,,,,,,,,,,,,,,,,Lukumaara,,,,,,,,,,,,,,,,,,}
      if SrcEdka
      then begin s := veA4( edv.Sorc[edi].Josa.lukumaara, edvf.Sorc[edi].Josa.lukumaara, edv0.Sorc[edi].Josa.lukumaara);
                 i1 := a_getIntg( 251,  edv.Sorc[edi].Josa.lukumaara);
                 i2 := a_getIntg( 252, edvf.Sorc[edi].Josa.lukumaara);
                 i3 := a_getIntg( 253, edv0.Sorc[edi].Josa.lukumaara);  end
      else begin s := veA4( edv.edka[edi].lukumaara,      edvf.edka[edi].lukumaara,      edv0.edka[edi].lukumaara);
                 i1 := a_getIntg( 251,  edv.edka[edi].lukumaara);
                 i2 := a_getIntg( 252, edvf.edka[edi].lukumaara);
                 i3 := a_getIntg( 253, edv0.edka[edi].lukumaara);  end;
      i := i1;   if i2>i  then i := i2;   if i3>i  then i := i3;
      i2 := 1;   if i=1   then i2 := 2;                          //<Ettei tule kolmatta '1'
     {IF s=''  then }for i3 := i2 to 10  do  if i3=1  then sa := '1;1'
                                                      else sa := sa +';'+fImrkt0 (i3,1);
      lisaaVEja (sa,s);  end;
   6 :begin                                          {,,,,,,,,,,,,,,,,,,Lampotila,,,,,,,,,,,,,,,,,,}
      if SrcEdka
      then begin s := veA4( edv.Sorc[edi].Josa.Lampotila, edvf.Sorc[edi].Josa.Lampotila, edv0.Sorc[edi].Josa.Lampotila);
                 i1 := a_getIntg( 261,  edv.Sorc[edi].Josa.lampotila);
                 i2 := a_getIntg( 262, edvf.Sorc[edi].Josa.lampotila);
                 i3 := a_getIntg( 263, edv0.Sorc[edi].Josa.lampotila);  end
      else begin s := veA4( edv.edka[edi].Lampotila, edvf.edka[edi].Lampotila, edv0.edka[edi].Lampotila);
                 i1 := a_getIntg( 261,  edv.edka[edi].lampotila); //<,,Havainto 6.0.0: Tehdäänkö näillä mitään nyt?
                 i2 := a_getIntg( 262, edvf.edka[edi].lampotila);
                 i3 := a_getIntg( 263, edv0.edka[edi].lampotila);  end;
      lisaaVEja ('40;70;80;145',s);  end;
   7 :begin                                          {,,,,,,,,,,,,,,,,,,Korjaus,,,,,,,,,,,,,,,,,,,,}
      s := '';                                       //<+8.0.7 ...BxItems undefined
      if SrcEdka
      then begin s := veA4( edv.Sorc[edi].Josa.Korjaus, edvf.Sorc[edi].Josa.Korjaus, edv0.Sorc[edi].Josa.Korjaus);
                 r1 := a_getReaa( 271,  edv.Sorc[edi].Josa.Korjaus);
                 r2 := a_getReaa( 272, edvf.Sorc[edi].Josa.Korjaus);
                 r3 := a_getReaa( 273, edv0.Sorc[edi].Josa.Korjaus);  end
      else begin s := veA4( edv.edka[edi].Korjaus,   edvf.edka[edi].Korjaus,   edv0.edka[edi].Korjaus);
                 r1 := a_getReaa( 271,  edv.edka[edi].Korjaus);
                 r2 := a_getReaa( 272, edvf.edka[edi].Korjaus);
                 r3 := a_getReaa( 273, edv0.edka[edi].Korjaus);  end;
      if (r1<>1) and (r2<>1) and (r3<>1)  then sa := '1';   lisaaVEja (sa,s);
      lisaaVEja ('0.7;0.75;0.8;0.85;0.9;0.95;1;1.05;1.1;1.15;1.2;1.25;1.3', s);
      s := s +';Valintataulukko';  end;
   8 :begin                                          {,,,,,,,,,,,,,,,,,,PTlopussa,,,,,,,,,,,,,,,,,,}
      s := '';                                       //<+8.0.7 ...BxItems undefined
      IF fOnArv (recA.PTlopussa) and a_getBool (281,recA.PTlopussa)    {,OnPT+OnPT+EiPT,,,,,,,,,,,,}
      THEN s := EtsiOlet(0,S_POT)+';'+EtsiOlet(0,S_POT)+';'+EtsiOlet(1,S_POT)
      ELSE s := EtsiOlet(1,S_POT)+';'+EtsiOlet(1,S_POT)+';'+EtsiOlet(0,S_POT);   end;
   9 :begin                                          {,,,,,,,,,,,,,,,,,,PEker,,,,,,,,,,,,,,,,,,,,,,}//<,,+2.0.7
      s := '';                                       //<+8.0.7 ...BxItems undefined
      if SrcEdka
      then begin s := veA4( edv.Sorc[edi].Josa.PEker, edvf.Sorc[edi].Josa.PEker, edv0.Sorc[edi].Josa.PEker);
                 r1 := a_getReaa( 271,  edv.Sorc[edi].Josa.PEker);
                 r2 := a_getReaa( 272, edvf.Sorc[edi].Josa.PEker);
                 r3 := a_getReaa( 273, edv0.Sorc[edi].Josa.PEker);  end
      else begin s := veA4( edv.edka[edi].PEker,     edvf.edka[edi].PEker,     edv0.edka[edi].PEker);
                 r1 := a_getReaa( 271,  edv.edka[edi].PEker);
                 r2 := a_getReaa( 272, edvf.edka[edi].PEker);
                 r3 := a_getReaa( 273, edv0.edka[edi].PEker);  end;
      if (r1<1) and (r2<1) and (r3<1)  then sa := '1';   lisaaVEja (sa,s);
      i := edi +1;
      while i>1  do begin                                                            //<Lisätään ed.j-osien arvot
         i := i-1;
         if SrcEdka  then s2 := fMrktRaj(edv.Sorc[i].Josa.PEker)
                     else s2 := fMrktRaj(edv.edka[i].PEker);
         if (s2<>'') and (s2[1]<>'1')  then lisaaVeja (s2,s);  end;                  //<Estetään toistuvat 1 :t
      asetaBx9Color;  end;
  10 :begin                                          {,,,,,,,,,,,,,,,,,,JK-tunnus,,,,,,,,,,,,,,,,,,}//<,,+2.0.5
      if (edi>1) and  SrcEdka                                               //Ei tarjota nimiä jos >1 Src. +8.0.8
      then s := '(Nimi vain 01:ssä)'
      else begin
         if SrcEdka                                                         //,Jo oleva =Tyhjä taiEi, PITÄÄKIN
         then begin i := edi;                         s1 := fMrktRaj( edv.Sorc[i].Josa.nimi);
                    i := edi +1;    repeat i := i-1;  s2 := fMrktRaj(edvf.Sorc[i].Josa.nimi);   until vS2;
                    i := edi +1;    repeat i := i-1;  s3 := fMrktRaj(edv0.Sorc[i].Josa.nimi);   until vS3;  end
         else begin i := edi;                         s1 := fMrktRaj( edv.edka[i].nimi);
                    i := edi +1;    repeat i := i-1;  s2 := fMrktRaj(edvf.edka[i].nimi);   until vS2;
                    i := edi +1;    repeat i := i-1;  s3 := fMrktRaj(edv0.edka[i].nimi);   until vS3;  end;
         s := s1;// +';' +s1;                                                                       //<,,+10.0.1
         if SrcEdka
         then begin
            if SokI (s1,i) and (i=1) //and (s2='') and (s3='') //<Jos ei filestä luettu eikä alkuluettu
               then s1 := '01';  end                           // sij. ainoa mahdollinen eli '01'.
         else begin                                            //'Sittenkin AINA 0 eteen, ainakin pudValikkoon.
            s1 := IntToStr (edi);
            s := s +';' +s1;  end;                                                                  //<''+10.0.1

         i := edi +1;
         while i>1  do begin
            i := i-1;
            if SrcEdka  then s2 := fMrktRaj(edv.Sorc[i].Josa.Nimi)
                        else s2 := fMrktRaj(edv.edka[i].Nimi);
            lisaaVeja (s2,s);  end;
       //if s='?&%'  then beep;
      end;//else                                     {,,,,,,,,,,,,,,,,,,OFAAchk,,,,,,,,,,,,,,,,,,,,}
      end;
//11 :s := fRmrkt0 (edv.edka[edi].arvoU[2],1,0) +
//         ';630;500;400;315;250;200;160;125;100;80;63;50;40;32;25;20;16;10;6'{;4;2};               //<,-6.0.2
  11 :begin                                                                                         //<,+6.0.2
      if SrcEdka
         then s := veA4( edv.Sorc[edi].Josa.OfaVal, edvf.Sorc[edi].Josa.OfaVal, edv0.Sorc[edi].Josa.OfaVal)
         else s := veA4( edv.edka[edi].OfaVal,      edvf.edka[edi].OfaVal,      edv0.edka[edi].OfaVal);
      if s=''  then s := '0';
      s := s +';630;500;400;315;250;200;160;125;100;80;63;50;40;32;25;20;16;10;6'{;4;2};  end;
  12 :begin                                          {,,,,,,,,,,,,,,,,,,Ph,,,,,,,,,,,,,,,,,,,,,,,,,}
      if SrcEdka
         then s := veA4_(1, edv.Sorc[edi].Josa.Ph, edvf.Sorc[edi].Josa.Ph, edv0.Sorc[edi].Josa.Ph)
         else s := veA4_(1, edv.edka[edi].Ph,      edvf.edka[edi].Ph,      edv0.edka[edi].Ph);
      s := s +';0';
      end;
  13 :begin                                          {,,,,,,,,,,,,,,,,,,Cosp,,,,,,,,,,,,,,,,,,,,,,,}
      if SrcEdka
         then s := veA4_(1, edv.Sorc[edi].Josa.Cosp, edvf.Sorc[edi].Josa.Cosp, edv0.Sorc[edi].Josa.Cosp)
         else s := veA4_(1, edv.edka[edi].Cosp,      edvf.edka[edi].Cosp,      edv0.edka[edi].Cosp);
      s := s +';1;0.95;0.9;0.85;0.8;0.75;0.7;0.65;0.6;0.55;0.5;0.45;0.4;0.35;0.3;0.25;0.2';
      end;
(*-120.5o:,,,
14,15:begin                                          {,,,,,,,,,,,,,,,,,,Uho,Tuh,,,,,,,,,,,,,,,,,,,,}
      if NOT SrcEdka and {UhBxON  and} (riv=14)    //<Uho-boxi 14 on auki vain Uh -laskettavan ekalle johto-osalle. 120.5o:  Nyt myös sorcille.
      then begin s := veA4_(1, edv.edka[edi].Uho,   edvf.edka[edi].Uho,   edv0.edka[edi].Uho);
                {if edi>1  then begin                              //<,,Turhaa, Uho´a ei kysytä jos [edi-1].Uho=0
                    r1 := a_getReaa (2141,edv.edka[edi-1].Uho);
                    if r1>0  then s := s +fRmrkt0 (r1,1,3);  end;}
                 LisaaVEja ('0',s);  end
      else begin
         if SrcEdka  then s := veA4_(1, edv.Sorc[edi].Josa.Tuh,   edvf.Sorc[edi].Josa.Tuh,   edv0.Sorc[edi].Josa.Tuh)
                     else s := veA4_(1, edv.edka[edi].Tuh,        edvf.edka[edi].Tuh,        edv0.edka[edi].Tuh);
                   {if (s='0') or (s='')                     //<,Muuten lisättäessä johto-osa, oletukseksi jää 0.
                       then s := '70';}
         s := s +';70  PVC;90  PEX;40  SÄL';  end;
      end;*)
  //,,120.5o:
  14 :begin if SrcEdka  then s := veA4_(1, edv.Sorc[edi].Josa.Uho,   edvf.Sorc[edi].Josa.Uho,   edv0.Sorc[edi].Josa.Uho)
                        else s := veA4_(1, edv.edka[edi].Uho,        edvf.edka[edi].Uho,        edv0.edka[edi].Uho);
            LisaaVEja ('0',s);  end;
  15 :begin if SrcEdka  then s := veA4_(1, edv.Sorc[edi].Josa.Tuh,   edvf.Sorc[edi].Josa.Tuh,   edv0.Sorc[edi].Josa.Tuh)
                        else s := veA4_(1, edv.edka[edi].Tuh,        edvf.edka[edi].Tuh,        edv0.edka[edi].Tuh);
            s := s +';70  PVC;90  PEX;40  SÄL';  end;
   end;//case riv zzz
//3 :case riv of{;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 3=Uh%;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;}//<,,-4.0.0
// 1 :s := veA4( edv.NjL.yhtUhraja, edvf.NjL.yhtUhraja, edv0.NjL.yhtUhraja);
// 2 :s := veA4( edv.NjL.edUhOsa,   edvf.NjL.edUhOsa,   edv0.NjL.edUhOsa);
// 3 :with edv.NjL  do begin                         {,,,,,,,,,,,,,,,,,,PotTas,,,,,,,,,,,,,,,,,,,,,}
//    IF fOnArv (OnPTlop) and a_getBool (331,OnPTlop)                  {,OnPT+OnPT+EiPT,,,,,,,,,,,,}
//    THEN s := EtsiOlet(0,S_POT)+';'+EtsiOlet(0,S_POT)+';'+EtsiOlet(1,S_POT)
//    ELSE s := EtsiOlet(1,S_POT)+';'+EtsiOlet(1,S_POT)+';'+EtsiOlet(0,S_POT);   end; end;//case riv

4 :case riv of//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 4=Nj;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
              //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> NÄISSÄ SARAKE => RIV <<<<<<<<<<<<<<<<<<<<<<<<<
   1 :begin                                          //,,,,,,,,,,,,,,,,,,Keskustunnus,,,,,,,,,,,,,,,
     {if (kesno<=kesja)  and  (kesja>0)  THEN s1 := nj.jk[kesno  ].tunnus;  //<Jo oleva
      IF (kesno> kesja)  and  (kesno>1)  THEN s2 := nj.jk[kesno-1].tunnus;  //<Edellinen
      IF  edn1>=kesno                    THEN s3 := nj.jkf[kesno ].tunnus;'''''''''''''''''''''''''}
      i := kesno+1;   repeat i := i-1;  s1 := fMrktRaj(  nj.jk[i].tunnus);  until vS1;   //<JoOleva
      i := kesno+1;   repeat i := i-1;  s2 := fMrktRaj( njf.jk[i].tunnus);  until vS2;
      i := kesno+1;   repeat i := i-1;  s3 := fMrktRaj( nj0.jk[i].tunnus);  until vS3;
      if (s1<>'')
      then begin                          //<,Tehdään item, missä vikaa N:oa on kasvatettu +1 <<<<<<
         sa := s1;
         if CharInSet(s1[Length(s1)], ['0'..'9'])  then begin
            i := Length(sa);                      //<Tehdään vikoista n:oista luku, johon lisätään 1
            while (i>0) and (CharInSet(sa[i], ['0'..'9']))   do begin
              sb := sa[i] +sb;                    //<sb alussa ''
              Delete (sa,Length(sa),1);           //<Pyyhitään jo sb :hen siirretty (vika)mrk vex<<<
              i := i-1;  end;

            sa := sa +fImrkt0(StrToInt(sb)+1,1);  //<Nyt sa=str, jossa vikoja n:oja kasvatettu +1<<<
            if s1 <> fMrktRaj( nj.jk[kesno].tunnus)    //<Eioo vielä"OMAA oikeaa" tunnusta, pannaan
               then s := s +sa +';' +sa +';' +s1+';'   //'sille "laskettu" ve EKAKSI. i := 1  merkik
                                                       //<si=EiLisätä vikaksi VE:ksi koskaOnJoEkana
               else s := s +s1 +';' +s1 +';' +sa+';';  //<On "OMA oikea" tunnus: i jää 0 :ksi<<<<<<<
            sa := s;
         end;                                  //,Tehdään ve, missä EDjk:n N:oa on kasvatettu +1 <<<
         s := sa;                                      //<Ettei "BxItems might be undefined"
         if kesno>1  then begin
            sa := fMrktRaj( nj.jk[kesno-1].tunnus);
            if sa<>''  then
            if CharInSet(sa[Length(sa)], ['0'..'9'])  then begin             //<Jos vaikka halutaan isompi +1
              if sa[Length(sa)] = '9'   then sa[Length(sa)] := '0'
                                        else sa[Length(sa)] := Chr( Ord( sa[Length(sa)] ) +1);
            //if sa <> nj.jk[kesno].tunnus  then s := s +sa +';';  end;
              if (sa<>s1) and (sa<>s2) and (sa<>s3)  then s := s +sa +';';  end;
         end;
         if (s2<>'') and (s1<>s2)  then s := s +s2 +';';
         if (s3<>'') and (s2<>s3)  then s := s +s3 +';';                   koe_Ys(1);  end
      else//if s1<>''
         s := 'RK ' +fImrkt0 (kesno,1);   end;
   2 :begin                                          {,,,,,,,,,,,,,,,,,,dL,,,,,,,,,,,,,,,,,,,,,,,,,}
                                                   {vRok-kutsuna:  until vRok(1, r1,0 ,0 ) or (i=1)}
                                                   {            :  until vRok(2, r1,r2,0 ) or (i=1)}
                                                   {            :  until vRok(3, r1,r2,r3) or (i=1)}
                                                   {tai         :  until vR1; .. vR3;              }
      i := kesno+1;   repeat i := i-1;  r1 := a_getReaa( 1421, nj.jk[i].dL);  until vR1; //<Jo oleva
{????Tähän vois pistää:  if r1=0  then begin i := kesno+1; repeat i :=..  r1 := njf.[].. until vR1;}
      i := kesno+1;   repeat i := i-1;  r2 := a_getReaa( 1422,njf.jk[i].dL);  until vR2;
      i := kesno+1;   repeat i := i-1;  r3 := a_getReaa( 1423,nj0.jk[i].dL);  until vR3;
      s := veR4 (r1,r2,r3, nj.jk[1].dL);
      if kesno>kesja  then begin sa := '3.5';        //<Uudelle riville oletuksesksi 3.5 m. +4.0.0
         if s<>''  then s := sa +';' +s;  end;
      for i := kesno-1 downto 1  do begin
         sa := fMrktRaj (nj.jk[i].dL);   lisaaVEja (sa,s);  end;
      lisaaVEja ('3',s);  lisaaVEja ('3.5',s);  lisaaVEja ('4',s);  koe_Y(2);  end;
   3 :begin                                          {,,,,,,,,,,,,,,,,,,Pt,,,,,,,,,,,,,,,,,,,,,,,,,}
      i := kesno+1;   repeat i := i-1;  r1 := a_getReaa( 1431, nj.jk[i].Ps);  until vR1; //<Jo oleva
      i := kesno+1;   repeat i := i-1;  r2 := a_getReaa( 1432,njf.jk[i].Ps);  until vR2;
      i := kesno+1;   repeat i := i-1;  r3 := a_getReaa( 1433,nj0.jk[i].Ps);  until vR3;
      s := veR4 (r1,r2,r3, nj.jk[1].Ps);
      for i := kesno-1 downto 1  do begin
         sa := fMrktRaj (nj.jk[i].Ps);   lisaaVEja (sa,s);  end;              koe_Y(3);  end;
   4 :begin                                          {,,,,,,,,,,,,,,,,,,Coss,,,,,,,,,,,,,,,,,,,,,,,}
      i := kesno+1;   repeat i := i-1;  r1 := a_getReaa( 1441, nj.jk[i].Coss);  until vR1;//<Jo oleva
      i := kesno+1;   repeat i := i-1;  r2 := a_getReaa( 1442,njf.jk[i].Coss);  until vR2;
      i := kesno+1;   repeat i := i-1;  r3 := a_getReaa( 1443,nj0.jk[i].Coss);  until vR3;
      s := veR4 (r1,r2,r3, nj.jk[1].Coss);
      for i := kesno-1 downto 1  do begin
         sa := fMrktRaj (nj.jk[i].Coss);   lisaaVEja (sa,s);  end;            koe_Y(4);  end;
   5 :begin                                          {,,,,,,,,,,,,,,,,,,palV,,,,,,,,,,,,,,,,,,,,,,,}
      i := kesno+1;   repeat i := i-1;  r1 := a_getReaa( 1452, nj.jk[i].palV);  until vR1;//<Jo oleva
      i := kesno+1;   repeat i := i-1;  r2 := a_getReaa( 1453,njf.jk[i].palV);  until vR2;
      i := kesno+1;   repeat i := i-1;  r3 := a_getReaa( 1454,nj0.jk[i].palV);  until vR3;
      s := veR4 (r1,r2,r3, nj.jk[1].palV);
      for i := kesno-1 downto 1  do begin
         sa := fMrktRaj (nj.jk[i].palV);   lisaaVEja (sa,s);  end;            koe_Y(5);  end;
   6 :begin                                          {,,,,,,,,,,,,,,,,,,CosV,,,,,,,,,,,,,,,,,,,,,,,}
      i := kesno+1;   repeat i := i-1;  r1 := a_getReaa( 1452, nj.jk[i].CosV);  until vR1;//<Jo oleva
      i := kesno+1;   repeat i := i-1;  r2 := a_getReaa( 1463,njf.jk[i].CosV);  until vR2;
      i := kesno+1;   repeat i := i-1;  r3 := a_getReaa( 1464,nj0.jk[i].CosV);  until vR3;
      s := veR4 (r1,r2,r3, nj.jk[1].CosV);
      for i := kesno-1 downto 1  do begin
         sa := fMrktRaj (nj.jk[i].CosV);   lisaaVEja (sa,s);  end;            koe_Y(6);  end;
   7 :begin                                          {,,,,,,,,,,,,,,,,,,Ala,,,,,,,,,,,,,,,,,,,,,,,,}
      i := kesno+1;   repeat i := i-1;  r1 := a_getReaa( 1452, nj.jk[i].ala);   until vR1;//<Jo oleva
      i := kesno+1;   repeat i := i-1;  r2 := a_getReaa( 1473,njf.jk[i].ala);   until vR2;
      i := kesno+1;   repeat i := i-1;  r3 := a_getReaa( 1474,nj0.jk[i].ala);   until vR3;
      s := veR4 (r1,r2,r3, nj.jk[1].ala);
      for i := kesno-1 downto 1  do begin
         sa := fMrktRaj (nj.jk[i].ala);   lisaaVEja (sa,s);  end;             koe_Y(7);  end;
   8 :with nj.jk[kesno]  do  begin                   {,,,,,,,,,,,,,,,,,,PTlop,,,,,,,,,,,,,,,,,,,,,,}
      IF fOnArv (PTlop) and a_getBool (881,PTlop)                      {,OnPT+OnPT+EiPT,,,,,,,,,,,,}
      THEN s := EtsiOlet(0,S_POT)+';'+EtsiOlet(0,S_POT)+';'+EtsiOlet(1,S_POT)
      ELSE s := EtsiOlet(1,S_POT)+';'+EtsiOlet(1,S_POT)+';'+EtsiOlet(0,S_POT);   end;
   9 :begin                                          {,,,,,,,,,,,,,,,,,,Huom,,,,,,,,,,,,,,,,,,,,,,,}
    //i := kesno+1;   repeat i := i-1;  s1 := fMrktRaj(  nj.jk[i].huom);        until vS1;   //<Jo oleva
      i := kesno;                       s1 := fMrktRaj(  nj.jk[i].huom);   //<Jo oleva =Tyhjä taiEi, PITÄÄKIN
      i := kesno+1;   repeat i := i-1;  s2 := fMrktRaj( njf.jk[i].huom);        until vS2;
      i := kesno+1;   repeat i := i-1;  s3 := fMrktRaj( nj0.jk[i].huom);        until vS3;
    //s := veS4 (s1,s2,s3);                                                              //<AinaArvoJosLöytyy
      s := s1;  if (s2<>s1) and (s2<>'')  then s := s+';'+s2;
                if (s3<>s2) and (s3<>'')  then s := s+';'+s3;
     {if s1=''  then s := s1+';'+s;}                                   koe_Ys(8);  end;  //<1.tyhjä jos tyhjä
    //s := s1 +';' +s2 +';' +s3;  {<TämäEIsamaKuin ''veS4 (s1,s2,s3)}  koe_Ys(8);  end;  //<1.tyhjä jos tyhjä
  //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Riv = ohjausnumero ao. Boxiin,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  11 :begin
          for i := a_getIntg (20,edv.YLE.JohtoOsia) +1  DownTo 1  do
          lisaaVEja (fImrkt0 (i,1), s);
          for i := a_getIntg (21,edv.YLE.SorceCount)    DownTo 1  do
          lisaaVEja (fImrkt0 (-1*i,1), s);  end;
  12 :with nj.JY  do begin                           {,,,,,,,,,,,,,,,,,,Kuluttaja,,,,,,,,,,,,,,,,,,}
      IF fOnARv (NjKulSal)
      THEN IF a_getBool (4111,NjKulSal)
              THEN s := EtsiOlet(0,S_KulSal)    //0=1.ve ='KULUTT.'
              ELSE s := EtsiOlet(1,S_KulSal)    //1=Etsit.listasta 2.ve='SÄHKÖL.'
      ELSE         s := EtsiOlet(0,S_KulSal);   //<Perusolet='KULUTT.'
      s := s+';'+f_VarItems(S_KulSal);  end; //< ';'=Oletus/Item -kenttäerotin, ks. FNC f_VarItems()
  13 :begin                                          {,,,,,,,,,,,,,,,,,,Lampotila,,,,,,,,,,,,,,,,,,}
      s := veA4( nj.jy.Tk1v,    njf.jy.Tk1v,    nj0.jy.Tk1v);
      lisaaVEja ('40;50;60;70;80',s);   end; //<Poistaa '...' :sta nj/njf/nj0.Tk1v sisältämän alkion
  14 :begin                                          {,,,,,,,,,,,,,,,,,,Uh%-raja,,,,,,,,,,,,,,,,,,,}
      s := veA4( nj.jy.UhRaja,  njf.jy.UhRaja,  nj0.jy.UhRaja);
      lisaaVEja ('1.5;3;4.5', s);   end;
  15 :begin                                          {,,,,,,,,,,,,,,,,,,Tasaus,,,,,,,,,,,,,,,,,,,,,}
      s := veA4( nj.jy.tasaus,  njf.jy.tasaus,  nj0.jy.tasaus);
      lisaaVEja ('0.7;0.75;0.8;0.85;0.9;0.95;1', s);   end;
  16 :begin                                          {,,,,,,,,,,,,,,,,,,AsTapa,,,,,,,,,,,,,,,,,,,,,}
      s := veA4( nj.jy.AsTapa,  njf.jy.AsTapa,  nj0.jy.AsTapa);
     lisaaVEja ('A;C;D', s);   end;
  17 :begin                                          {,,,,,,,,,,,,,,,,,,Korjaus,,,,,,,,,,,,,,,,,,,,}
      s := veA4( nj.jy.korjaus, njf.jy.korjaus, nj0.jy.korjaus);
      lisaaVEja ('0.7;0.75;0.8;0.85;0.9;0.95;1;1.05;1.1;1.15;1.2;1.25;1.3', s);  end;
  18 :begin                                          {,,,,,,,,,,,,,,,,,,Kasvuvara,,,,,,,,,,,,,,,,,,}
      s := veA4( nj.jy.kasvuv,  njf.jy.kasvuv,  nj0.jy.kasvuv);
      lisaaVEja ('0;5;10;15;20;25;30', s);   end;
  19 :begin                                          {,,,,,,,,,,,,,,,,,,Ve:ja,,,,,,,,,,,,,,,,,,,,,,}//<,+6.1.1
      if VExKrt>1  then
         s := fImrkt0 (VExKrt,1) +';';
      s := s +'1;2;3;4;5;6;8;10;12;14;16;20';  end; //<Erikseen myös NjTul3.PAS :ssa NjTulFrm.VExKrtBx :lle.
   end;//case riv
5 :case riv of{;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 5=Häviökust ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;}
   1 :begin s := veA4( nj.Hav.Tpit   ,  njf.Hav.Tpit   ,  nj0.Hav.Tpit);
                   lisaaVEja ('10;15;20;25;30', s);
                   lisaaVEja (fRmrkt0 (a_getReaa (301, HavTarif.Tpit   ),1,1), s);   end; //<Lisätään LOPPUUN filenOlet elleiJoOle
   2 :begin s := veA4( nj.Hav.Korko  ,  njf.Hav.Korko  ,  nj0.Hav.Korko);
                   lisaaVEja ('3;5;7.5;10;12.5;15;', s);
                   lisaaVEja (fRmrkt0 (a_getReaa (301, HavTarif.Korko  ),1,2), s);   end;
   3 :begin s := veA4( nj.Hav.Hprs   ,  njf.Hav.Hprs   ,  nj0.Hav.Hprs);
                   lisaaVEja ('0.5;0.75;1;1.25;1.5;1.75;2;2.25;2.5', s);
                   lisaaVEja (fRmrkt0 (a_getReaa (301, HavTarif.Hprs   ),1,2), s);   end;
   4 :begin s := veA4( nj.Hav.Tph    ,  njf.Hav.Tph    ,  nj0.Hav.Tph);
                   lisaaVEja ('1000;1250;1500;1750;2000;2250;2500;2750;3000;3500;4000;4500;5000;6000;'+
                              '7000;8760', s);
                   lisaaVEja (fRmrkt0 (a_getReaa (301, HavTarif.Tph    ),1,0), s);   end;
   5 :begin s := veA4( nj.Hav.YOprs  ,  njf.Hav.YOprs  ,  nj0.Hav.YOprs);
                   lisaaVEja ('3;5;10;15;20;30;37.5;40;45;50', s);
                   lisaaVEja (fRmrkt0 (a_getReaa (301, HavTarif.YOprs  ),1,1), s);   end;
   6 :begin s := veA4( nj.Hav.Ktyh   ,  njf.Hav.Ktyh   ,  nj0.Hav.Ktyh);
                   lisaaVEja (fRmrkt0 (a_getReaa (301, HavTarif.Ktyh   ),1,2), s);   end;
   7 :begin s := veA4( nj.Hav.dPprs  ,  njf.Hav.dPprs  ,  nj0.Hav.dPprs);
                   lisaaVEja ('0.7;0.8;1;1.25;1.5;1.75;2;2.25;2.5;3', s);
                   lisaaVEja (fRmrkt0 (a_getReaa (301, HavTarif.dPprs  ),1,2), s);   end;
   8 :begin s := veA4( nj.Hav.dWmkprs,  njf.Hav.dWmkprs,  nj0.Hav.dWmkprs);
                   lisaaVEja ('1.25;1.5;1.75;2;2.25;2.5;2.75;3;3.5;4;4.5;5', s);
                   lisaaVEja (fRmrkt0 (a_getReaa (301, HavTarif.dWmkprs),1,2), s);   end;
   9 :begin s := veA4( nj.Hav.PVpen  ,  njf.Hav.PVpen  ,  nj0.Hav.PVpen);
                   lisaaVEja (fRmrkt0 (a_getReaa (301, HavTarif.PVpen  ),1,2), s);   end;
  10 :begin
{i := FileAge (NjFilen);  //<,,,,,,,,,,,,,,Oli tarkoitus lisätä huomautus, jos mahd. EURotarkistus tarpeen. +5.0.1
if i>-1  then begin
//if FileDateToDateTime (i)< Now  then
if FileDateToDateTime (i)< StrToDate ('2002/1/1')  then
   beep;
end;}
            s := veA4( nj.Hav.YOpen  ,  njf.Hav.YOpen  ,  nj0.Hav.YOpen);
                   lisaaVEja (fRmrkt0 (a_getReaa (301, HavTarif.YOpen  ),1,2), s);   end;
  11 :begin s := veA4( nj.Hav.Pmk    ,  njf.Hav.Pmk    ,  nj0.Hav.Pmk);
                   lisaaVEja (fRmrkt0 (a_getReaa (301, HavTarif.Pmk    ),1,2), s);   end;
{ 12 :begin r := 0;
            r := fMuokDes (Ptas[1], fDsm(r,100,1));
               r1 := a_getReaa (5121, nj.Hav.TotPh);
               r1 := fMuokDes (r1,  fDsm(r1,100,1));
            if (r1>0) and (r1>=r)  then
                      s := s +fRmrkt0 (r1,1, fDsm(r1,100,1));
               r2 := a_getReaa (5121,njf.Hav.TotPh);
               r2 := fMuokDes (r2,  fDsm(r2,100,1));
               sa := fRmrkt0  (r2,1,fDsm(r2,100,1));
            if (r2>0) and (r2>=r) and  NOT fMukanaS (';'+sa+';' , ';'+s+';')  then begin
                      if s<>''  then s := s +';';
                      s := s +sa;  end;
               r3 := a_getReaa (5121,nj0.Hav.TotPh);
               r3 := fMuokDes (r1,  fDsm(r3,100,1));
               sa := fRmrkt0  (r3,1,fDsm(r3,100,1));
            if (r3>0) and (r3>=r) and  NOT fMukanaS (';'+sa+';' , ';'+s+';')  then begin
                      if s<>''  then s := s +';';
                      s := s +sa;  end;

            if s=''  then begin
               a_putReaa (5121, r, nj.Hav.TotPh);
               s := fRmrkt0 (r,1, fDsm(r,100,1));  end;                              end;'''''''''''}
   end;//case riv
8 :case riv of{;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 8=Moottorilähdöt ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;}// 6=>8=8.0.0
              {>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> NÄISSÄ SARAKE => RIV <<<<<<<<<<<<<<<<<<<<<<<<<}
   1 :begin  if (Mrv>motja) and (Mrv=1)              {,,,,,,,,,,,,,,,,,,NapaLkm,,,,,,,,,,,,,,,,,,,,}
      then s := '4'
      else begin
      i := Mrv+1;   repeat i := i-1;  i1 := a_getIntg( 1611, mo.motr[i].nap);   until vI1;//<Jo oleva
      i := Mrv+1;   repeat i := i-1;  i2 := a_getIntg( 1612,mof.motr[i].nap);   until vI2;
      i := Mrv+1;   repeat i := i-1;  i3 := a_getIntg( 1613,mo0.motr[i].nap);   until vI3;
      s := veI4 (i1,i2,i3);  end;{else}   lisaaVEja ('2;4;6;8;10;12', s);   end;
   2 :begin                                          {,,,,,,,,,,,,,,,,,,kW,,,,,,,,,,,,,,,,,,,,,,,,,}
      i := Mrv+1;   repeat i := i-1;  r1 := a_getReaa( 1621, mo.motr[i].kw);    until vR1;//<Jo oleva
      i := Mrv+1;   repeat i := i-1;  r2 := a_getReaa( 1622,mof.motr[i].kw);    until vR2;
      i := Mrv+1;   repeat i := i-1;  r3 := a_getReaa( 1623,mo0.motr[i].kw);    until vR3;
      s := veR4 (r1,r2,r3, mo.motr[1].kw);
      sa := S_Pnap2;  if a_getIntg (4061, mo.motr[Mrv].nap) =4  then sa := S_Pnap4;
      lisaaVEja (sa, s);   end;
   3 :with mo.motr[Mrv]  do begin                    {,,,,,,,,,,,,,,,,,,cos,,,,,,,,,,,,,,,,,,,,,,,,}
      if Mrv>motja
      then begin
         if kw.OnArvo  and nap.OnArvo  then
         s := fRMrktRaj (fCos (a_getReaa (1631, kw), a_getintg (1632, nap)), mo.motr[1].cos);
         lisaaVEja (s,s);  end                       //<Pud.valikon 1.:ksi sama
      else begin
         i := Mrv+1;   repeat i := i-1;  r1 := a_getReaa( 1634, mo.motr[i].cos);   until vR1;//<Jo oleva
         i := Mrv+1;   repeat i := i-1;  r2 := a_getReaa( 1635,mof.motr[i].cos);   until vR2;
         i := Mrv+1;   repeat i := i-1;  r3 := a_getReaa( 1636,mo0.motr[i].cos);   until vR3;
         s := veR4 (r1,r2,r3, mo.motr[1].cos);  end;//else
      lisaaVEja ('0.4;0.45;0.5;0.55;0.6;0.65;0.7;0.75;0.8;0.85;0.9;0.95;1', s);
      if kw.OnArvo  and nap.OnArvo  then
      sa := fRMrktRaj (fCos (a_getReaa (1637, kw), a_getintg (1638, nap)), mo.motr[1].cos);
      lisaaVEja (sa, s);   end;//with
   4 :with mo.motr[Mrv]  do begin                    {,,,,,,,,,,,,,,,,,,tim,,,,,,,,,,,,,,,,,,,,,,,,}
      if Mrv>motja
      then begin //NCTION fTim (kuormaON :Boolean;  P :Real;  Nap :Integer) :Real;
         if kw.OnArvo  and nap.OnArvo  then
         s := fRMrktRaj (fTim (TRUE,a_getReaa (1641, kw), a_getintg (1642, nap)), mo.motr[1].tim);
         lisaaVEja (s,s);  end                       //<Pud.valikon 1.:ksi sama.  '1,2, 0,2' jottei 0.02=>0.0
      else begin
         i := Mrv+1;   repeat i := i-1;  r1 := a_getReaa( 1644, mo.motr[i].tim);   until vR1;//<Jo oleva
         i := Mrv+1;   repeat i := i-1;  r2 := a_getReaa( 1645,mof.motr[i].tim);   until vR2;
         i := Mrv+1;   repeat i := i-1;  r3 := a_getReaa( 1646,mo0.motr[i].tim);   until vR3;
      s := veR4 (r1,r2,r3,  mo.motr[1].tim);  end;//else
      //,,MaxItems=36, jotta Bar´iton pysyy "pitämättä" auki, Barillinen 44 (Font iso), KOKEILTU,,,,
      lisaaVEja ('0.1;0.15;0.2;0.25;0.2;0.25;0.3;0.35;0.4;0.45;0.5;0.6;0.7;0.8;0.9;1;1.5;'+
                 '2;2.5;3;3.5;4;4.5;5;5.5;6;6.5;7;7.5;8;8.5;9;9.5;10', s);
      if kw.OnArvo  and nap.OnArvo  then
      sa := fRMrktRaj (fTim (FALSE, a_getReaa (1644, kw), a_getintg (1645, nap)), mo.motr[1].tim)+
       ';' +fRMrktRaj (fTim (TRUE,  a_getReaa (1646, kw), a_getintg (1647, nap)), mo.motr[1].tim);
      lisaaVEja (sa, s);   end;
   5 :begin  if (Mrv>motja) and (Mrv=1)              {,,,,,,,,,,,,,,,,,,Ryh,,,,,,,,,,,,,,,,,,,,,,,,}
      then s := '1'
      else begin                                                                        //,,Jo olevat
      i := Mrv+1;   repeat i := i-1;  i1 := a_getIntg( 1651, mo.motr[i].rno);   until vI1 or  mo.motr[i].onArvot;
      i := Mrv+1;   repeat i := i-1;  i2 := a_getIntg( 1652,mof.motr[i].rno);   until vI2 or mof.motr[i].onArvot;
      i := Mrv+1;   repeat i := i-1;  i3 := a_getIntg( 1653,mo0.motr[i].rno);   until vI3 or mo0.motr[i].onArvot;
      s := veI4 (i1,i2,i3);  end;     lisaaVEja ('1;2;3;4;5;6;7;8;9;0', s);   end; //Jotta 0 :kin olet:ksi'''''''
   6 :begin  if (Mrv>motja) and (Mrv=1)              {,,,,,,,,,,,,,,,,,,kpl,,,,,,,,,,,,,,,,,,,,,,,,}
      then s := '1'
      else begin
      i := Mrv+1;   repeat i := i-1;  i1 := a_getIntg( 1661, mo.motr[i].kpl);   until vI1;//<Jo oleva
      i := Mrv+1;   repeat i := i-1;  i2 := a_getIntg( 1662,mof.motr[i].kpl);   until vI2;
      i := Mrv+1;   repeat i := i-1;  i3 := a_getIntg( 1663,mo0.motr[i].kpl);   until vI3;
      s := veI4 (i1,i2,i3);  end;     lisaaVEja ('1;2;3;4;5;6;7;8;9;10', s);  end;
   7 :begin  if (Mrv>motja) and (Mrv=1)              {,,,,,,,,,,,,,,,,,,asT,,,,,,,,,,,,,,,,,,,,,,,,}
      then s := 'A'
      else begin
      i := Mrv+1;   repeat i := i-1;  s1 := fMrktRaj(  mo.motr[i].asT);         until vS1;//<Jo oleva
      i := Mrv+1;   repeat i := i-1;  s2 := fMrktRaj( mof.motr[i].asT);         until vS2;
      i := Mrv+1;   repeat i := i-1;  s3 := fMrktRaj( mo0.motr[i].asT);         until vS3;
      s := veS4( s1,s2,s3);  end;     lisaaVEja ('A;C;D', s);                 end;
   8 :begin  if (Mrv>motja) and (Mrv=1)              {,,,,,,,,,,,,,,,,,,korj,,,,,,,,,,,,,,,,,,,,,,}
      then s := '1'
      else begin
      i := Mrv+1;   repeat i := i-1;  r1 := a_getReaa( 1681, mo.motr[i].korj);  until vR1;//<Jo oleva
      i := Mrv+1;   repeat i := i-1;  r2 := a_getReaa( 1682,mof.motr[i].korj);  until vR2;
      i := Mrv+1;   repeat i := i-1;  r3 := a_getReaa( 1683,mo0.motr[i].korj);  until vR3;
      s := veR4 (r1,r2,r3,  mo.motr[1].korj);  end;
      lisaaVEja ('0.4;0.45;0.5;0.55;0.6;0.65;0.7;0.75;0.8;0.85;0.9;0.95;1', s);   end;
   9 :begin  if (Mrv>motja) and (Mrv=1)              {,,,,,,,,,,,,,,,,,,suT,,,,,,,,,,,,,,,,,,,,,,,,}
      then s := 'F'
      else begin
      i := Mrv+1;   repeat i := i-1;  s1 := fSu_Chr (a_getStrg (1691,  mo.motr[i].suT));   until vS1;//<Jo oleva
      i := Mrv+1;   repeat i := i-1;  s2 := fSu_Chr (a_getStrg (1692, mof.motr[i].suT));   until vS2;
      i := Mrv+1;   repeat i := i-1;  s3 := fSu_Chr (a_getStrg (1693, mo0.motr[i].suT));   until vS3;
      s := veS4( s1,s2,s3);
      lisaaVEja ('F', s);  lisaaVEja ('M', s);  lisaaVEja ('I', s);  lisaaVEja ('Z', s);  end;  end;
  10 :begin  if (Mrv>motja) and (Mrv=1)              {,,,,,,,,,,,,,,,,,,Lmo,,,,,,,,,,,,,,,,,,,,,,,}
      then s := '0'
      else begin
    //i := Mrv+1;   repeat i := i-1;  r1 := a_getReaa( 1681, mo.motr[i].Lmo);  until vR1;//<Jo oleva
                                      r1 := a_getReaa( 1681, mo.motr[Mrv].Lmo);          //<Jo oleva
      i := Mrv+1;   repeat i := i-1;  r2 := a_getReaa( 1682,mof.motr[i].Lmo);  until vR2;
      i := Mrv+1;   repeat i := i-1;  r3 := a_getReaa( 1683,mo0.motr[i].Lmo);  until vR3;
      s := veR4 (r1,r2,r3,  mo.motr[1].Lmo);  end; end;
     {                                r := a_getReaa( 1681, mo.motr[Mrv].Lmo);           //<Jo oleva
                                      i := 1;   if (r>=100) or (r=0)  then i := 0;
      if r<>r1  then s := fRmrkt0 (r,1,i) +';' +s;     end; end; //<Koska vR1 etsi ekan, joka oli >0. Lisät.ALKUUN
    //lisaaVEja (fRmrkt0 (r,1,i), s);   end; end; //<Tämä lisää r :n s :n LOPPUUN }
  11 :begin  if (Mrv>motja) and (Mrv=1)              {,,,,,,,,,,,,,,,,,,SulSft,,,,,,,,,,,,,,,,,,,,,}
      then s := '0'
      else begin
      i := Mrv+1;   repeat i := i-1;  r1 := a_getReaa( 1601, mo.moty.SulSft);   until vR1;//<Jo oleva
      i := Mrv+1;   repeat i := i-1;  r2 := a_getReaa( 1602,mof.moty.SulSft);   until vR2;
      i := Mrv+1;   repeat i := i-1;  r3 := a_getReaa( 1603,mo0.moty.SulSft);   until vR3;
      s := veR4 (r1,r2,r3,  mo.moty.SulSft);  end;
      lisaaVEja ('-10;-5;0;5;10', s);   end;
  12 :s := fMrktRaj( mo.moty.Umo) +';'+f_VarItems(S_Usrj);                                          { Umo <<<<<<}
  13 :begin                                                                                         { VrkoPiste<}
         s := fMrktRaj( mo.moty.Vrk);                                                           //<,,'+6.0.3
       //i1 := a_getIntg (1613, edv.YLE.SorceCount); //<,,+7.0.5,  11.0.1:  <0 = -1 =Aina lask 1.JK:hon = Vrk=0
        {i1 := 1;
         for i2 := -1 to -1*i1  do
            s := s +';' +IntToStr (i2);
         i1 := a_getIntg (1613, edv.YLE.JohtoOsia);
         if i1>0  then                                                //< +7.0.5
         for i2 := 1 to i1  do                                        //< 0 -> 1..i1
            s := s +';' +IntToStr (i2);}

         i2 := a_getIntg (1613, edv.YLE.JohtoOsia);                   //<,,11.0.1:  0:sta lähtien edja asti.
         for i1 := 0 to i2  do
            if i1<>mo.moty.Vrk.arvoInt  then s := s +';' +Ints (i1);  //< Ei 2x samaa. Vois myös testata:
      end;                                                            //  if ..Items.IndexOf ('...') > -1
   end;//case riv
(*§u*)
end;//case SyoOs  

(*boo := (SyoOs=1) and (SyottoFrm.RadGrp.ItemIndex<>2{UPS}) and (riv IN [5,6])  OR //<,Näistä ei poisteta TYHriviä
         (SyoOs=1) and (SyottoFrm.RadGrp.ItemIndex= 2{UPS}) and (riv=3{PEN_PE});   //<+6.2.10
  if (SyoOs<>1) OR  NOT boo  then                        //<  +6.0.3  PEN_PE:n tyhjää OLEVAA riviä ei saa poistaa.
  while (Length (s)>0) and (s[1] IN [';','\'])  do //<, -4.0.0  Poistetaan ekoina mrknä olevat ";", "\" ettei jää,
        Delete (s,1,1);                            //   jos vaikka ei varsinaisia itemeita olekaan, TODETTU.*)
                                                                                                  //''-8.0.8  §g
  i := SyottoFrm.RadGrp.ItemIndex;                                                                //<,-8.0.8  §g
  boo := (SyoOs=1) and ( (i=0 {SJ}) and (riv=6)  OR (i=1 {PJ}) and (riv=5)  OR //<,Näistä ei poisteta TYHrivejä.
                         (i=2 {VV}) and (riv=12) OR (i=3{UPS}) and (riv=3) );
  if SyoOs=6                                                               //,,+10.0.7: SyoOs=6: Lisättäessä SORCia,
  then while (Length (s)>=2) and (s[1]=';') and (s[2]=';')                 //  PEN_PE -lenkki "..axmk4" oletus  141.1 oli:  "..amcmk4½"
     do Delete (s,1,1)                                                     //  sijoitettiin väkisin.
  else if (SyoOs<>1) OR  NOT boo  then                        //<  +6.0.3  PEN_PE:n tyhjää OLEVAA riviä ei saa poistaa.
 {while (Length (s)>0) and (CharInSet(s[1], [';','\']))  do   //<, -4.0.0  Poistetaan ekoina mrknä olevat ";", "\" ettei jää,
        Delete (s,1,1);                                       //   jos vaikka ei varsinaisia itemeita olekaan, TODETTU. }
  while (Length (s)>0) and (Pos(';;',s)=1) do Delete (s,1,1); //<, -4.0.0  Muutetaan ekoina mrknä olevat ";;", "\" että jää vain yksi ";"(tyhjä itemRv.
{ s := '0.00123;0.000098';         fSkplNo ('0.000098',s, i,i3); //function fSkplNo (SAO,S :string;  VAR arvoja,aoNo :integer) :boolean;
  if (i<0) and (i3<0)  then beep;
  s := '0.00123;0.0000980';        fSkplNo ('0.000098',s, i,i3);
  if (i<0) and (i3<0)  then beep;
  s := '0.00123;0.00009800';       fSkplNo ('0.000098',s, i,i3);
  if (i<0) and (i3<0)  then beep;
  s := '0.00123;0.00000';          fSkplNo ('0.000098',s, i,i3);
  if (i<0) and (i3<0)  then beep;
  s := '0';                        fSkplNo ('0.000098',s, i,i3);
  if (i<0) and (i3<0)  then beep;
  s := '';                         fSkplNo ('0.000098',s, i,i3);}

  result := s;   Wavu('9 SyoKut.INC/BxItems: SyoOs=' +Ints(SyoOs) +' riv=' +Ints(riv) +' => s=' +s);
end;//BxItems; =Boxien oletus + pudotusvalikon Itemit
{==================================================================================================}
                                         //################################################################
                                         //################################################################
                                         //################################################################
                                         //,,TÄÄLLÄ TEHDÄÄN ComBx'ien ALKUSIJOITUKSET , esim. ComBx14.Text´iin.
                                         //################################################################
                                         //################################################################
procedure BxArvot(rivi,SyoOsa :integer); //################################################################ 120.5o(komtti)
  procedure sijAoBox (VAR BxU :TComboBoxXY);      VAR ss :string;  tmpItems :TStringList;  i :Integer;

     procedure SijEuroMuunnokset;      VAR n,i :integer;   ss,se :string;  ar :real;      begin
        n := BxU.Items.Count;
        if n>0  then begin
           BxU.Items.Add ('=== Euromuunnokset ===');
           for i := 0 to n  do begin
              ss := BxU.Items.Strings[i];
              if SokR (ss,ar) and (ar>0)  then begin
                 se := ss +' €';                     //<,Lisätään jokaisen itemin perään ' €' =VAIN TÄSSÄ.########
                 BxU.Items.Strings[i] := se;
                 BxU.Items.Add (fRmrkt0 (ar/e_mk,1,2) +'  <=  ' +ss + ' mk = ' +fRmrkt0 (ar/e_mk,1,2) +' €');
              end;
           end;
        end;//if n>0
     end;
  begin//sijAoBox.....................
    {######,,,,,,,TEKEE ITEM-LISTAN: 'Oletus;Item[0];Item[1]... #################################### ,,Muut.3.0.3}
     ss := BxItems (rivi,SyoOsa);           //<Haki oletustiedot Bx´iin.  ,Alkuosa, ks PRC Lado_TeeSyoFrm
     Wavu('10 SyoKut.INC/BxItems: SyoOs=' +Ints(SyoOsa) +' riv=' +Ints(rivi) +' => ss=' +ss);
//SyottoFrm.Caption := ss; //Koe:  Poista tämä
     tmpItems := f_Items(ss);                          //<Tehdään BXITEMS:stä ITEM-lista TmpITEMS
     {###################''#########################################################################}
     BxU.Items.Assign(tmpItems);     // KAI 2.12.2000   Oli:  SyottoFrm.Ly_Bx.Items.Assign(tmpItems);  =Ei tartte Clear
     tmpItems.Free;                  //<####### VASTA TÄSSÄ SAA TUHOTA. MUUTEN OSOITIN HÄVIÄÄ LIIAN AIKAISIN #####

     if (SyoOsa=5) and (rivi>=9)     //<Kun HÄVIÖKUS:n 9..11 Bx´in itemit jo sijoitettu.############ +5.0.1
        then SijEuroMuunnokset;
        
   //BxU.Text :=  BxU.Items.Strings[0];                //<Sijoittaa pudotusvalikon 1. ve:n Boxiin ##
     BxU.ItemIndex := 0;                               //<Sij. pud.valikon 1.ve:n Boxiin + MAALAA ## Fiksumpi
//Nyt juuri ComBx´ssä arvo.######################//,, [0] ja [1] saavat olla samoja !! #############
     i := 0;                                     //,, FOR i := ei käy koska Count muuttuu.##########
     while i<=BxU.Items.Count -2  do             //< -2 koska vika = [i+1] = [Count-1] !! ##########
        if AnsiUpperCase (BxU.Items.Strings[i]) = AnsiUpperCase (BxU.Items.Strings[i+1])
           then BxU.Items.Delete (i+1)           //<'Etsitään ja poistetaan PERÄKKÄISET esiintymät !
           else i := i+1;                                                                       //##########################################################
//if (SyottoFrm.ComBx14.Text<>'') or (edv.Sorc[1].Josa.Uho.arvoRea <0) or (SyoOsa>0)  then ; //<120.5o:  Tästä pääsee näkemään ..Bx14..:n alkusijoittelut.//
                                                                                             //##########################################################
              //ss := '';  for i := 0 to BxU.Items.Count -1  do ss := ss +BxU.Items.Strings[i] +';';
   //,,,,,,,,,,,,,,,,,,##################### VÄLTTÄMÄTTÖMÄT ASETUKSET ##############################
   //TabOrder := rivi+6;               //<TabOrd:  Sotkee = Ei ohjelmallisesti ainakaan tässä ######
     BxU.Visible := true;              //'Sotkee, koska asettaa vain yhden ja KeyPres ohjaa seuraa-
     BxU.DropDownCount := 100;         //'vaan, jota ei olekaan määrätty -> HYPPY SATUNNAISESTI, TODTTU.       ,,+8.0.12  //+8.0.14  Ks. myös ComBx1_11Enter
       //BxU.SelStart := 0;  i := Length (BxU.Text);  BxU.SelLength := i; {+1};  {BxU.SelectAll;} {if BxU.Showing  then ...} //if BxU.Visible  then BxU.SetFocus;}
       //BxU.SelLength := i;//+1;
       //BxU.SelectAll;  if BxU.Showing  then BxU.SelLength := 0;
  end;//sijAoBox;

begin//BxArvot......................................................................................
  with SyottoFrm  do
  case rivi of  1 :sijAoBox (ComBx1); //<,,Näistä mennään  SyoKut.INC/BxItems´iin.
                2 :sijAoBox (ComBx2);
                3 :sijAoBox (ComBx3);
                4 :sijAoBox (ComBx4);
                5 :sijAoBox (ComBx5);
                6 :sijAoBox (ComBx6);
                7 :sijAoBox (ComBx7);
                8 :sijAoBox (ComBx8);
                9 :sijAoBox (ComBx9);
               10 :sijAoBox (ComBx10);
               11 :sijAoBox (ComBx11);
               12 :sijAoBox (ComBx12);
               13 :sijAoBox (ComBx13);
               14 :sijAoBox (ComBx14);
               15 :sijAoBox (ComBx15);
  end;//case
  if (syoKut=2) and (rivi=9)  then
     asetaBx9Color;
end;//BxArvot;
{==================================================================================================}
procedure Lado_TeeSyoFrm (apuikkuna :integer); //VAR GrRvja :integer; =>Syotto.PAS glob.+6.0.3 //< 4.0.0: rivja->GrRvja
       VAR u :integer;                                                                    //' 4.0.0  Apuikkuna

  procedure sijBox(AsetaFrm,PyyhiBtn,RadioBtn,OhitBtn,BxTulee :integer;                   //< +4.0.0 BxTulee
                   str1,str2,str3 :String);      VAR i :integer;      begin
    with SyottoFrm  do begin
      GrRvja := GrRvja +1;        //<######################## As. vain tässä   #####################!!!!!!!!!!!!!!
      if BxTulee>0  then begin    //<OLTAVA TARKKANA BxTulee -parametrin kanssa #@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@
         BxArr [GrRvja] := TRUE;  //<######################## As. vain tässä   ##################### +6.0.3  BxArr
         BxArvot(GrRvja,syoKut);  end; //< 4.0.0 Oli Rivja = Aiheutti PAHAN sekoilun / TILTTI: BxRvt korvttu
                                       //''######################################################################''
      StrGr1.Cells[0,GrRvja] := str1;  //''######################################################################''
      StrGr1.Cells[1,GrRvja] := str2;  //''######################################################################''
      StrGr1.Cells[2,GrRvja] := str3;
      if AsetaFrm>0  then  begin
        if (PyyhiBtn=0){or (SrcEdka and (edi>srckayty)) or
                       (NOT SrcEdka and (edi>edikayty)) or (OhitBtn>0)}
      //if (PyyhiBtn=0) or (OhitBtn>0) or (edi>edikayty) or (edi<=1) //< edi<=1 ettei ekaa johtoa saa vex  +6.0.0
                           then PoistaBtn.Visible := false
                           else PoistaBtn.Visible := true;
        if (RadioBtn=0) or (OhitBtn>0)
                           then RadGrp.Visible := false
                           else RadGrp.Visible := true;
        if OhitBtn>0       then OhitaBtn.Visible := true
                           else OhitaBtn.Visible := false;
      //for i := 1 to BxRvt  do                //< +4.0.0  Oli RIVJA.      ,6.0.0 arvoOK -> arvoOKe  GrRvja=+6.0.3
        for i := 1 to GrRvja  do               //< +4.0.0  Oli RIVJA.      ,6.0.0 arvoOK -> arvoOKe  GrRvja=+6.0.3
        if BxArr[i]  then                      //< +6.0.3  Onko [i]-CellRivillä Boxi (TRUE) vai ei. Onhan myös pelkkiä
           arvoOKe (i,syoKut);                 //          opastavia rvja ilman Bx´ia, esim: Liittymaverkon Ry/Xy (PjLiit).
                                               //'SIJOITTAA KAIKKI ao. Box´ien arvot.
//if (SyottoFrm.ComBx14.Text<>'') or (edv.Sorc[1].Josa.Uho.arvoRea <0)  then ; //<120.5o:  KESKEN KESKEN Nyt arvo="70"
        AsBxSyotFrm (GrRvja,apuikkuna);        //<######################## Kutsu vain tässä  +4.0.0 -Rvja,BxRvja
      end;//if AsetaF                          //<########################'Käyttää myös GLOB:  BxRvt #############
    end;//with
  end;//sijBox;
{==================================================================================================}
  procedure puts_StrGr (GrU :TStringGridNola);      VAR c,r :integer;      begin //<,,+4.0.0
     for c := 0 to GrU.ColCount-1  do
     for r := 0 to GrU.RowCount-1  do Gru.Cells[c,r] := '';
  end;
  procedure puts_BxArr;      VAR i :integer;      begin //<,,+6.0.3
     for i := 1 to BxMaxRv  do BxArr[i] := false;
  end;

  function fPoistettava :integer;      VAR o :integer;      begin//Pal 1=PoistaBtn.Visible
    {if (NOT SrcEdka and edv.Edka[edi].OnArvot) OR (SrcEdka  and (edi>1))       -8.0.0 Nythän aina OnArvot
        then u := 1  else u := 0;             //<PoistaBtn mukaan (u=1) jos Src[>1] tai Edka[>=0]. +6.2.2}
     if SrcEdka  and (edi<=OldSrcja) and (OldSrcja>1)//<,OldSrcja´ssa joko SorceCount t. JohtoOsia. 8.0.0
     then o := 1                                     //<PoistaBtn mukaan (u=1)
     else if  NOT SrcEdka  and (edi<=OldSrcja) and (OldSrcja>0) //OldSrcja := Syotto.PAS/EditSyoFrm
     then o := 1
     else o := 0;
     result := o;
  end;//fPoistettava

begin//Lado_TeeSyoFrm...............................................................................
  GrRvja := 0;                    //<,##################### Nollaus vain tässä   ################### 4.0.0
  Puts_BxArr;                     //<BxRvt => BxArr[0..] +6.0.3
  with SyottoFrm  do begin                          //<,,Putsataan KAIKKI Cellit, jotta OnWidest
    puts_StrGr (StrGr1);                            //   -eventti pääsee tapahtumaan SEUR.KUTSULLAKIN
    puts_StrGr (StrGr2);
    puts_StrGr (StrGr3);
    puts_StrGr (StrGr4);
    puts_StrGr (StrGrY1);
    puts_StrGr (StrGrY2);  end;//with

case syoKut of //SyoKut:  1=Liitt  2=EdvJ  3=Uh-raj(eiEnää)  5=Häviökust  6=LisätLIITTYMÄ  7=LisätJohto-osa  8=MoottItemit
{         sijBox(0,0,0,0,0,'VasSarakeTexti        ',         'KeskiSarakTexti','OikSarakTexti'
                           'KUVAUS                ',         'RAJA-ARVOT     ','SYMBOLI    ');
                 . | | .==PoistaBtn ja RadioBt:ssa käytössä VAIN 1 tai 0, EIKÄ STRINGEJÄ HUOMIOIDA =''
                 . . . |==OhitaBtn vain HäviöKust käsittelyssä
                 0=EiVielä AsetaFrm   1=AsetaFrm         Pyyhi+RadBtns ONAA VASTA KUN AsetaFrm=1 #########
.................| 0=PoistaBtn vex    1=PoistaBtn on                       => 1.str = Caption
                 | | 0=RadioBtns vex  1=VasRadioBtnOlet  2=OikRadioBtnOlet => 1.str = PanelCaption
                 | | | 0=OhitaBtn vex 1=OhitaBtn on                           2.str = VasBtnCaption
                 | | | | 0=Ei Boxia   1=Boxi tulee                            3.str = Oik..        < +4.0.0
                 | | | | |                                                                          }
1,6 :begin//     | | | | |                         //<1?=Liit  6=LisätLIITTYMÄ
       case SyottoFrm.RadGrp.ItemIndex of          //+1412: DlgOli := 11=SjDlg  12 PjDlg  13=VvDlg  14=UpsDlg  2=JosaDlg  5=HävDlg  7=JkUpsDlg
       0 :begin //< SJ
          DlgOli := 11;
          sijBox(0,0,0,0,1,'Muuntajan näennäisteho',         ' 16 ... 2500 ',  ' Smn [kVA] ');
          sijBox(0,0,0,0,1,'Muuntajan tyyppi',               ' 1, 2, 3, 8, 9', ' Tyyppi '   );
          sijBox(0,0,0,0,1,'Yläverkon Rs-komponentti',       ' >=0 ',          ' Ry ['+FONT_OMEGA+'] ');
          sijBox(0,0,0,0,1,'Yläverkon Xs-komponentti',       ' >=0 ',          ' Xy ['+FONT_OMEGA+'] ');
          sijBox(0,0,1,0,0,'Liittymäverkon Ry/Xy',           ''    ,           ' ');  end;
       1 :begin //< PJ
          DlgOli := 12;
          sijBox(0,0,0,0,1,'Liittymäpisteen Ik1v',           ' 0.01 ... 300 ', ' Ik1v [kA] ');
          sijBox(0,0,0,0,1,'Liittymäpisteen Ik3v',           ' 0.01 ... 300 ', ' Ik3v [kA] ');
          sijBox(0,0,0,0,1,'Liittymäverkon Rs',              ' >0 ',           ' eRs ['+FONT_OMEGA+'] ');
          sijBox(0,0,1,0,0,'Liittymäverkon Rs/Xs',           ''    ,           ' ');  end;
       2 :begin //< VV                                                                 //<,,+6.2.10 +8.0.8 §g
          DlgOli := 13;
          sijBox(0,0,0,0,1,'Gener. näennäisteho',            ' 1 ... 3150 ',   ' Sn [kVA] ');  //gSn           1
          sijBox(0,0,0,0,1,'-"- suhteellinen X ',            ' >=0.001 ',      ' Xd ');        //gXd           2
          sijBox(0,0,0,0,1,'-"- suhteellinen muutosX ',      ' >=0.001 ',      ' X''d ');      //gXd1          3
          sijBox(0,0,0,0,1,'-"- suhteellinen alkuX ',        ' >=0.001 ',      ' X"d ');       //gXd2          4
          sijBox(0,0,0,0,1,'-"- staattorin R 22°C',          ' >=0.001 ',      ' Rs ['+FONT_OMEGA+'] ');//gRs  5
          sijBox(0,0,0,0,1,'-"- muutosaikavakio ',           ' >=0.001 ',      ' T''d [s]');   //gTd1          6
          sijBox(0,0,0,0,1,'-"- alkuaikavakio ',             ' >=0.001 ',      ' T"d [s]');    //gTd2          7
          sijBox(0,0,0,0,1,'-"- Min. Ik:n alkuhetki ',       ' >=0.001 ',      ' tIkMin [s]'); //gtIkMin       8
          sijBox(0,0,0,0,1,'-"- Jatkuvan Ik:n alkuh.',       ' >=0.001 ',      ' tIkSus [s]'); //gtIkSust      9
          sijBox(0,0,0,0,1,'-"- Jatkuvan tilan Ik ',         ' >=10 ',         ' IkSust [A]'); //gIkSust      10
          sijBox(0,0,0,0,1,'-"- Ik1v monikerta sustn ',      ' >=0.1 ',        ' K1vSustn ');  end; //gcIk1v   11  => gK1vSust :14.1.1
       3 :begin //< UPS                                                                //<,,+6.2.10  8.0.8 §g
          DlgOli := 14;
          sijBox(0,0,0,0,1,'UPS-syötön Ik1v',                ' 0.01 ... 300 ', ' Ik1v [kA] ');
          sijBox(0,0,0,0,1,'UPS-syötön Ik3v',                ' 0.01 ... 300 ', ' Ik3v [kA] ');
          sijBox(0,0,0,0,1,'UPS-syötön Cos' +FONT_FII,       ' 0.01 ... 1'   , ' Cos' +FONT_FII); end;
       end;//case
          u := fPoistettava;                                                           //,+6.0.3 Yhteinen ed:sille.
          sijBox(1,u,1,0,1,'PEN+PE:n yhdist.tiedot',         ''    ,           ' PEN+PE '); //<'##################
    end;  //#### ^ ############################################################################# Yhteinen edellisille.
2,7:if (SyoKut=2) and  (JkUpsChk_Cap) //or SyottoFrm.JkUpsChk.Checked //<..Chk_Cap tätä varten asetettu EdiSyoFrm´ssa.  (edv.Edka[Edi].JkUps.ArvoInt=1))  2=EdvJ  7=LisäJohto-osa
    then begin                                            JFileen('1/2 SyoKut"2,7"=' +Ints(SyoKut)); //<,,+130.3u
          DlgOli := 7;                                    Wavu('11 SyoKut.INC/BxItems: SyoKut=' +Ints(SyoKut));// +' riv=' +Inst(riv));
          sijBox(0,0,0,0,1,'UPS-lähtöhaara Ik1v',            ' 0.01 ... 300 ', ' Ik1v [kA] '); //<Oli:  UPS-kojeen
        //sijBox(0,0,0,0,1,'UPS-lähtöhaara Ik3v',            ' 0.01 ... 300 ', ' Ik3v [kA] '); //<Ei tarvita 3v koska vain pistorLaskentaan(1v).
          sijBox(1,0,0,0,1,'UPS-lähtöhaara Cos' +FONT_FII,   ' 0.01 ... 1',    ' Cos' +FONT_FII);
               JFileen('2/2 SyoKut ');
          SyottoFrm.JkUpsChk.Visible := false;//Checked := true;
          SyottoFrm.JkUpsLbl.Visible := false;//<'141.1:  Vex nyt koska äakeisessä edvJosaTietojen kyselyssä oli näkyvissä, tässä ei enää.
    end
    else begin                                     //<SyoKut=2 ilman JkUps´ia tai syoKut=7 =LisäJohto-osa
          DlgOli := 2;
   {begin}sijBox(0,0,0,0,1,'Kuluttaja/Sähkölaitos',          ' K/S ',          ' N-ehdot '  );
    {2}   sijBox(0,0,0,0,1,'Kaapelityyppi',                  ' (Valitse) ',    ' KaapTyp '  );
    {3}   sijBox(0,0,0,0,1,'Äärijohtimen mm²',               ' 6... ',         ' mm² '      );
    {4}   sijBox(0,0,0,0,1,'Kaap.osuuden pituus',            ' >=0 ',          ' L [m] '    );
    {5}   sijBox(0,0,0,0,1,'Rinnakkaiskaap. lukum.',         ' >=1 ',          ' Kpl '      );
    {6}   sijBox(0,0,0,0,1,'Laskentalämpötila',              ' 0 ... 300 ',    ' Tk [°C] '  );
    {7}   sijBox(0,0,0,0,1,'Kuormitettav. korjausK',         ' 0.01 ... 10 ',  ' <b><u>Korj</b> '+CLR_BLU +'(tlko)</u></f>');
    {8}   sijBox(0,0,0,0,1,'Pot.tasaus loppupäässä',         ' K/E ',          ' PotTas '   );
    {9}   sijBox(0,0,0,0,1,'PE-johtimen huomioiminen',       ' 1 ... 0 ',      ' Kpe '      );
   {10}   sijBox(0,0,0,0,1,'JK:n tunnus (johdn lopussa)',    ' ...... ',       ' <b>JK</b>-tunnus ');
   {11}   sijBox(0,0,0,0,1,'   Kokeile: OFAA sulake xxA',    ' 6 ... 630 ',    ' OFAAsul   ');
   {12}   sijBox(0,0,0,0,1,CLR_BLU+'Huippukuorma johdossa</f>',      CLR_BLU+' 0 ....</f> ',   CLR_BLU+' Ph [kW]</f>   ');
   {13}   sijBox(0,0,0,0,1,CLR_BLU+'Kuorman Cos' +FONT_FII +'</f>', CLR_BLU+' 0.05 ... 1</f>', CLR_BLU+' Cos' +FONT_FII +'</f>');
           //if NOT SrcEdka and UhBxON  then                        //<,Uh% ain ao.ekalle (mahd.)Ph>0 johto-osalle. 120.5o: Nyt myös Src[].Josille.
   {14}   sijBox(0,0,0,0,1,CLR_BLU+'Alkupään uh%</f>',              CLR_BLU+' 0 ....</f> ',    CLR_BLU+' Uho%</f>');
             u := fPoistettava;                                     //<PoistaBtn.Visible FA/TR.
   {15}   sijBox(1,u,0,0,1,CLR_BLU+'Johdinresistanssien T°C</f>',   CLR_BLU+'10 ...300</f> ',  CLR_BLU+' Tuh [°C]</f>');
    end;
//,,-4.0.0  3 Ei enää ole
3  :begin sijBox(0,0,0,0,1,'Uh%raja-arvo',                   ' 0.01 ... 25 [%] ',  ' Uh%NjRaja ');
          sijBox(0,0,0,0,1,'Edeltävän verkon osuus',         ' 0.01 ... 25 [%] ',  ' Uh%Edv '   );
          sijBox(1,0,0,0,1,'Pot.tasaus loppupäässä',         ' K/E ',              ' PotTas '   );
    end;
5  :begin
          DlgOli := 5;
          sijBox(0,0,0,0,1,'Mitoitusjakso',                  ' >0 (esim 20) ',     ' [a] '      ); //Tpit
          sijBox(0,0,0,0,1,'Laskentakorko',                  ' 0...    (12.0) ',   ' [%/a] '    ); //korko
          sijBox(0,0,0,0,1,'Huoltokustannukset',             ' 0...    (1.0) ',    ' [%/inv/a] '); //Hprs
          sijBox(0,0,0,0,1,'Huipun käyttöaika',              ' >0     (2800) ',    ' [h/a] '    ); //Tph
          sijBox(0,0,0,0,1,'YÖkulutuksen osuus',             ' 0...    (5.0) ',    ' [%] '      ); //YOprs
          sijBox(0,0,0,0,1,'Tyhjäkäyntivakio',               ' >0     (0.30) ',    ' '          ); //Ktyh
          sijBox(0,0,0,0,1,'   Ennuste: Huipputeho',         ' 0...    (1.0) ',    ' [%/a] '    ); //dPprs
          sijBox(0,0,0,0,1,'   Ennuste: Energ.hinta',        ' 0...    (2.0) ',    ' [%/a] '    ); //dWmkprs
          sijBox(0,0,0,0,1,'PVenergian hinta',               ' >0     (5.60) ',    ' [snt/kWh] '); //PVpen € 5.0.1
          sijBox(0,0,0,0,1,'YÖenergian hinta',               ' >0     (2.24) ',    ' [snt/kWh] '); //YOpen € 5.0.1
          sijBox(1,0,0,1,1,'Tehomaksu',                      ' >0     (38.85) ',   ' [€/kW/a] ');  //Pmk   € 5.0.1
        //sijBox(1,0,0,1,1,'Liittymän Ph',                   ' >Ph  (Rv 5) '   ,   ' [kW]');       //TotPh
                                                         //'Näiden ''''' oikeaSuoran saami- ########
    end;{        | | | | |                               // seksi olisi FNC Y_SamPitOikSuor ########
                 | | | | 0=Ei Boxia   1=Boxi tulee                            3.str = Oik..        < +4.0.0
                 | | | 0=OhitaBtn vex 1=OhitaBtn on                           2.str = VasBtnCaption
                 | | 0=RadioBtns vex  1=VasRadioBtnOlet  2=OikRadioBtnOlet => 1.str = PanelCaption
                 | 0=PoistaBtn vex    1=PoistaBtn on                       => 1.str = Caption
.................0=EiVielä AsetaFrm   1=AsetaFrm         Pyyhi+RadBtns ONAA VASTA KUN AsetaFrm=1 #########}

{                              Esim.    Dimens.          KOKONAISVAIKUTUS   6
 1 Mitoitusjakso               20          [a] : 21    ¯¿           Tpit    7
 2 Laskentakorko_______________12.00_____[%/a]_: 13    ¯Á7.1        korko   8
 3 Huoltokustannukset           1.00  [%inv/a] : 1.1     20.53      Hprs    9
 4 Huipun käyttöaika   1,2)  2800        [h/a] : 2801    !          Tph     10
 5 YÖkulutuksen osuus  1)       5.00       [%] : 10      !          YOprs   11
 6 Tyhjäkäyntivakio      2)     0.30           : .4      !          Ktyh    12
 7                Huipputeho    1.00     [%/a] : 2       !          dPprs   13
 8                Energ.hinta   2.00     [%/a] : 6.4     !          dWmkprs 14
 9 TARIFFImaksut: 1)PVenergia  33.30   [p/kWh] : 33.4    !          PVpen   15
10                1)YÖenergia  13.30   [p/kWh] : 13.4    !          YOpen   16
11                1)Tehomaksu 231.00 [€/kW/a]  : 232     !          Pmk     17
12 LASKETTU:      1)   HÄVIÖenerg. keskihinta = 31.28 snt/kWh               18
13                2)   HÄVIÖhuipun käyttöaika = 2465/2639.72 h/a (cos0.5/0.8)}
end;//case
end;//Lado_TeeSyoFrm;

