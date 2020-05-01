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
{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NjVrk.INC}
//a_getIntg (1..
procedure pvitaDiskontStrGr;
      VAR i :integer;  s, s6,s7,s8,s81,s82,s83,s9,s91 :string;
          ar, qTpit,qKorko,qdPprs,qdWmkprs, qHprs,qPVpen,qYOpen,qPmk :real;

   //-------------------------------------------------------------------------------
   function fDes (r :real) :integer;      VAR i :integer;      begin
      if fMuokDes (r,0) >= 100  then i := 0   else
      if fMuokDes (r,1) >= 10   then i := 1   else i := 2;
      result := i;  end;
      
   function fDes4 (r :real) :integer;      VAR i :integer;      begin
      if fMuokDes (r,0) >= 100  then i := 1   else
      if fMuokDes (r,0) >= 10   then i := 2   else
      if fMuokDes (r,1) >= 1    then i := 3   else i := 4;
      result := i;  end;
   //-------------------------------------------------------------------------------
   PROCEDURE ifsi (col,riv :integer;  su :string);      {VAR sa :string;      }BEGIN
      with SyottoFrm  do begin                         //,,Sijoi vain jos muutoksia ettei turhia Widest -eventejä
{,,,,,,, sa := StrGr3.Cells[col,riv];
           if su<>sa  then                //<Tarpeeton ehto nyt, kun StrGr3 :een sijoitetaan kerralla kaikki '''}
           
         StrGr3.Cells[col,riv] := su;     // '=myös s6. Oli aikaisemmin StrGr3 := StrGr3 +s6, mikä aiheutti
   end; end;//ifsi,with                   // jokaisen StrGr :n elämisen joka Exit -eventissä -> pvitaDiskontStrGr
   //-------------------------------------------------------------------------------
   PROCEDURE nyk3_arv (riv :integer;  Kasvu :real);      VAR tim,ar :real;  s :string;      begin
         ar := fToistvSuor_nyk_arv (Kasvu,Kasvu);
      s := sRmrkt0vex (ar,1,2) +s6;
      ifsi (0,riv,s);
         tim := a_getReaa (1,nj.Hav.Tpit);
         ar := fToistvSuor_Diskont (tim,Kasvu);
      s :=  SyottoFrm.StrGr3.Cells[4,riv] +' =' +fRmrkt0 (ar,1,fDes4(ar)) +'×';
      ifsi (4,riv,s);
   end;
   //-------------------------------------------------------------------------------
   PROCEDURE lop3_arv (prosArvo :integer;  riv :integer;  suure,Kasvu :Real;  sp :string);
         VAR ar,tim :Real;  s :string;      BEGIN  //PROSARVO'=0 =Arvona, ei prosentteina   >0 =Prosentteja
      s := '';  if prosArvo>0  then s := '+' +s;
         ar := fKertaSuor_lop_arv (prosArvo, suure,Kasvu);
      s := s +sRmrkt0vex (ar,1,fDes(ar)) +sp;
    //SyottoFrm.StrGr3.Cells[0,riv] := s;
      ifsi (0,riv,s);
         tim := a_getReaa (1,nj.Hav.Tpit);
         ar := fKertaSuor_Diskont (tim,Kasvu);
      s :=  SyottoFrm.StrGr3.Cells[4,riv];
      if riv<=8
         then s := s +' =' +fRmrkt0 (ar,1,fDes4(ar)) +'×'  //,Mallina ed.rv, jos riv >9 vois kopioida ed. riviltä
        //function Y_SamPitOikSuor (malli,st1,st2 :string; CanvasOwner :TCanvas;  aFont :TFont) :string;
         else s := Y_SamPitOikSuor (SyottoFrm.StrGr3.Cells[4,riv-1], s9,s9 +'  ',
                                   SyottoFrm.Canvas, SyottoFrm.StrGr1.Font);
      ifsi (4,riv,s);
   end;
//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ oli NjHavKus.INC''''''''''''''''''
begin//pvitaDiskontStrGr.........................................................................................
   //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,4 vikaa saraketta (6..9):  %  <-  2%  *20a,,,,,,,,,,,,,,,,,,,,,,,,,
   //                                                                 :  6  7   8   9   '''''''''''''''''''''''''
   with nj.Hav  do begin
    //a_putReaa(2003,{10}7,nj.hav.Tpit);//< TTT :n s.14 (Esim1=10a, Esim2=8a) kokeiluun. Etsi mjono "TTT" (koeajoaset)
      qTpit :=    a_getReaa (1, Tpit);      qdPprs := a_getReaa (2, dPprs);    qKorko := {10}a_getReaa (3, Korko);
      qdWmkprs := a_getReaa (4, dWmkprs);
      qHprs :=    a_getReaa (5, Hprs);      qPVpen := a_getReaa (9, PVpen);    qYOpen := a_getReaa (10,YOpen);
      qPmk :=     a_getReaa (11,Pmk);     end;//with

   s6 :=  ' %';
   s7 :=  FONT_VASEMMALLE +' ';
   s8 := ' --"--';
   s9 := ' -- " --';                          //<''VAKIOT
   s81 := sRmrkt0vex (qKorko,1,2) +' %';
   s82 := sRmrkt0vex (qdPprs,1,2) +' %';
   s83 := sRmrkt0vex (qdWmkprs,1,2) +' %';
   s91 :=  '× ' +sRmrkt0vex (qTpit,1,1) +' a';

      //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Kaikkien rivien hännät,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   with SyottoFrm  do begin
      for i := 2 to 3  do begin //<Rivit 2 - 3
       //StrGrNo,Rv,Sijoitettava String <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
         ifsi (1,i,' '); //<Yhdellekin riville sijoitus riittäisi. P.o.<>'' ='.' tai ' ', ei siis ''
         ifsi (2,i,s7 );
         ifsi (3,i,s81);
         ifsi (4,i,s91);
      end;
                                           //<,StrGr3[1,] jää tyhjäksi, Riv 2 ja 3 asetti Widthin
         ifsi (2,7,s7 );   ifsi (2,8,s7 );
         ifsi (3,7,s82);   ifsi (3,8,s83);
         ifsi (4,7,s91);   ifsi (4,8,s91);

      for i := 9 to 12  do begin //<Rivit 9 - 12
         ifsi (2,i,s7);
         ifsi (3,i,s8);
      end;

      Lask10Panel.Caption := ' =HävEnergKeskihinta (Cos '+fRmrkt0 (fKeskiNjCos,1,3) +')';
      Lask20Panel.Caption := ' =HäviöPh  käyttöaika  (Cos '+fRmrkt0 (fKeskiNjCos,1,3) +')';
      Lask11Panel.Caption := ' [snt/kWh]';
      Lask21Panel.Caption := ' [h/a]';

      //þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ oli NjHavKus.INC,,,,,,,,,,,,
      //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Syötön perusteella lasketut loppuarvot = Sarake 5,,,,,,,,,,,,,,,,,,
      nyk3_arv (2,qKorko);
      nyk3_arv (3,qHprs);
      ifsi (0,4,' -- --');
      ifsi (0,5,' -- --');

      DiskontPanel.Caption := 'Diskontatut NYKYarvot:';
//    DiskontPanel.Caption := 'NYKYarvot:';

    //LopArvPanel.Caption := 'Loppuarvot:   Ph=' +sRdim (4, 123.456*1000,s) +s +'W'; //<4 merkitsevääNoa, s='k..T'
    //LopArvPanel.Caption := 'Loppuarvot:   Ph=' +sRdim (4, 3*1000,s) +s +'W'; //<4 merkitsevääNoa, s='k..T'
         ar := Ptas[1]*1000;
      AlkuPhPanel.Caption := ' (Alku Ph=' +sRdim (3, ar ,s) +s +'W)';
         ar := ar *fKertaSuor_Diskont (qTpit,qdPprs);
      LopArvPanel.Caption := 'Loppuarvot:   Ph=' +sRdim (3, ar ,s) +s +'W';
//    LopArvPanel.Caption := 'Loppuarvot:';

      lop3_arv (1,  7, qdPprs,   qdPprs,   s6); //< 1, .. =Prosentteina   0=Abs. arvona #########################
      lop3_arv (1,  8, qdWmkprs, qdWmkprs, s6);
      lop3_arv (0,  9, qPVpen,   qdWmkprs, '');
    //lop3_arv (0,  9, 1000,     5); //< TTT :n s.14 (Esim2= 1000mk 8a 5%) kokeiluun. 8a aset alussa koeajoaVarten
      lop3_arv (0, 10, qYOpen,   qdWmkprs, '');
      lop3_arv (0, 11, qPmk,     qdWmkprs, '');
      //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,2. alin rivi =Rv 12,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
     {12 Energian keskihinta  [snt/kWh]  123.56/123.56  123.56/123.56}
         ar := fKESmk (TRUE,fKeskiNjCos{0.6})*100;
      s :=  sRmrkt0vex (ar,1,2);
      Lask12Panel.Caption := ' '+s;

         ar := fKESmk (TRUE,fKeskiNjCos) *100;
         ar := ar*fKertaSuor_Diskont (qTpit, qdWmkprs);
         s :=  sRmrkt0vex (ar,1,fDes(ar));
      ifsi (0,12,s);
      ifsi (4,12,StrGr3.Cells[4,11]); //<,Samaksi kuin ed. rivi
      //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Alin rivi =Rv 13,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
     {13 Huipun käyttöaika   [h/a]   1111/782}
         ar := 1*fPHaika (TRUE,fKeskiNjCos);
         s :=  sRmrkt0vex (ar,1,0);
      Lask22Panel.Caption := ' '+s;

      ifsi (0,13,' ');
        {ar := 1000 *fToistvSuor_lop_arv (8,5);   s := sRmrkt0vex (ar,1,fDes(ar));
      ifsi (5,13,s);                                     //'TTT Esim2 s.14: 1000mk 8a 5% = 8549 =OK}
   end;//with SyottoFrm
end;//pvitaDiskontStrGr;
//==================================================================================================
//,,,,,,, - = FNC ei käytetty   % = Algoritmi tarkistettu =Top..VisibleCoun.. VEX  % = FNCa käytetty #########
//,,,,,,,fJKtoAbsROW = JKlähtörivstä CellRow :ksi, oli TopRow mikäVaan =ao.rivi pvittyy näkyi tai ei #########
function fJKtoAbsROW (r :integer) :integer;    begin  with NjFrm.StrGr  do                              //<%%
                                     result := r +FixedRows -1;  end;
function fJKtoAbsCOL (c :integer) :integer;    begin  with NjFrm.StrGr  do                              //<%%
                                     result := c +FixedCols -1;   end;
function fJKtoVisROW (r :integer) :integer;    begin  with NjFrm.StrGr  do       //<Näkyvä  Row->RIV       %%
                                  //§result := r -TopRow +FixedRows +2;   end;
                                     result := r +FixedRows -1;   end;
function fVisRow  :integer;   begin  result := fJKtoVisROW (Riv);   end; //<Ao. Riv -lähtörivi Row :ksi    %%
function fVisERow :integer;   begin  result := fJKtoVisROW (eRiv);  end; //<Ao.eRiv -lähtörivi Row :ksi    %%

function fJKtoVisCOL (c :integer) :integer;          begin  with NjFrm.StrGr  do //<Riv -> Näkyvä COL      %%
                                  //§result := c -LeftCol +FixedCols +2;   end;
                                     result := c +FixedCols -1;   end;
function fVisCol  :integer;   begin  result := fJKtoVisCOL (Sar);   end; //<Ao. SAR -sarake CellColl :ksi  %%

function fAbsROWtoRIV (AbsRow :integer) :integer;    begin  with NjFrm.StrGr  do //<Absol   Row->Riv       %%
                                     result := AbsRow -FixedRows +1;   end;
function fAbsCOLtoSAR (AbsCol :integer) :integer;    begin  with NjFrm.StrGr  do //<Absol   Row->Sar       %%
                                     result := AbsCol -FixedCols +1;   end;

//,,,,,,,fOKrw=Scrollaus huomioituna näpäytetty sallitulle riville,  fOKcl=sarakkeelle,  fOKclRw=molemmat OK
function fOKrw: boolean;      begin  result := false;   with NjFrm.StrGr  do
   if (fVisRow>=FixedRows) and (fVisRow<=fJKtoVisROW (kesja))   then result := true;   end; //<..ja <=kesja
function fOKcl: boolean;      begin  result := false;   with NjFrm.StrGr  do
   if (fVisCol>=FixedCols) and (fVisCol<=fJKtoVisCOL (vCol))    then result := true;   end; //<..ja <=kesja
function fOKrwCl: boolean;    begin  result := false;  //<Näp OSUU näkyvän scrollaavan StrGr :n celleihin
   if fOKrw and fOKcl   then result := true;   end;

{procedure koe (o :integer; s :string;  boo :boolean);      begin  {if o=0  then skoe := ' ';
  if o=10  then begin;  Delete (skoe,Length(skoe),1);  {Y_Koe (0,skoe); }{end else} //<KOE_tulostaaKOEn
  {Y_Koe (0,'');  KoeFrm.MeJK1.Lines.Add(skoe);   //<Tekee CutCopyllä yhden ylipitkän rivin<<<<<<<<}
(*skoe := skoe +fImrkt0(o,2)+':'+s+':  ve'+fImrkt0(jkVE,1)+'  kayt='+fImrkt0(kesja,1)+' -- eS='+
  fImrkt0(eSar,1)+'/'+fImrkt0(Sar,1)+'=Sar'+'  eR='+fImrkt0(eRiv,1)+'/'+fImrkt0(Riv,1)+'=Riv -- Pois='+
  fBmrkt0(poista,2)+'   Kop='+fBmrkt0(kopioi,2)+'  B='+fBmrkt0(boo,2)+Chr(10)+
  Chr(13)+' '; {Delete (skoe,Length(skoe),1);}   Y_Koe (0, skoe);  if o IN [11,22,32,42] then skoe := '';//*)
{end;                            //Jotta WordWrap tekisi rivinvaihdon LF+CR:n jälkeen #################''}
procedure Kok (Csar,Criv :integer;  str :string);      var i :integer;      begin
   i := 0;  NjFrm.StrGr.Cells[Csar,Criv] :='';                    //<,Tulostaa Cellin sarakkeisiin. '#'välissä
   with NjFrm.StrGr  do                                           //,,siirtää seuraavaan sarakkeeseen <<<<<<<<
   while i<Length (str)  do begin   i := i+1;
      if (str[i]='#') and (Csar<ColCount-1)  then begin
         Csar := Csar+1;
         Cells[Csar,Criv] :='';  end;
      if str[i]<>'#'  then Cells[Csar,Criv] := Cells[Csar,Criv] +str[i];
   end;
end;

procedure jkVEo;   begin  jkVE := 1;  end;
procedure FrmOtsikko;      VAR s :string;      begin;
    s := 'Pää-/NJ -laskenta.   ';                                                     //<Lyhennetty 10.0.5
    if MootNJ      then s := s+'Moottorilähtöjen k'
                   else s := s+'K';
    s := s+'eskustiedot:   ';
    if NjFilen=''  then begin  if NOT MootNj  then s := s +'(Oletusarvot)';  end
                   else                            s := s +NjFilen;
                   //ExpandFileName(NjFilen);        //<'On jo PRC EditNjFrm :ssa <<<<<<<<<<<<<<<<<<
    NjFrm.Caption := s;
end;

procedure pvRivi (nrv :integer);       var sb,qTunnus :string;  rw,vNo :integer;  qdL :arvoTyyp;      begin
  if (nrv>0) and (nrv<=kesmax)  then
  with NjFrm, nj.jk[nrv]  do begin
    rw := fJKtoAbsROW (nrv);//<###############################################################################
    if nrv<=kesja
    then begin                    //Y_Koe(2, '1 PVrivi  ['+fImrkt0(nrv,1)+'].tunnus='+nj.jk[nrv].tunnus);
      if MootNJ                         //,,,,,,,,,,+7.0.3 ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      then begin
         vNo := a_getIntg (11, mo.moty.Vrk);                              //<Moot -osassa ilmaistu j-osa, mihin lasketaan
         if vNo>0                                                         //<Norm. edvn johto-osa
         then begin qdL :=     edv.edka[vNo].Pituus;
                    qTunnus := edv.edka[vNo].Nimi.arvoStr;  end
         else if vNo<0
         then begin qdL :=     edv.Sorc[Abs(vNo)].josa.Pituus;            //<,Liittymän johto-osa
                    qTunnus := '';  end
         else begin qdL :=     dL;                                        //<Sij. jotta arvoTyp, onArvo jne. saisi arvot.
                    qdL.arvoRea := 0;                                     //<',Tähän tullaan jos Vrk=0.
                    qTunnus := '';  end //''''''''''+7.0.3''''''''''''''''''''''''''''''''''''''''''
      end
      else begin
         qTunnus := tunnus.arvoStr;
         qdL :=     dL;  end;
    //StrGr.Cells[1,rw] := '<left>'+a_getStrg (1,tunnus);    //Koe(31,'pvRiv'+fImrkt0(rw,2),TRUE);
      StrGr.Cells[1,rw] := '<left>'+qTunnus;                 //<+7.0.3
      StrGr.Cells[2,rw] := fMrktRaj( qdL  );                 //<+7.0.3
      StrGr.Cells[3,rw] := fMrktRaj( Ps  );
      StrGr.Cells[4,rw] := fMrktRaj( Coss);
      StrGr.Cells[5,rw] := fMrktRaj( palV);
      StrGr.Cells[6,rw] := fMrktRaj( CosV);
      StrGr.Cells[7,rw] := fMrktRaj( Ala );
                           if a_getBool(1,PTlop)  then sb := 'PotTas '
                                                  else sb := 'EiPotTas ';
      StrGr.Cells[8,rw] := {'<left>'+}sb;
      StrGr.Cells[9,rw] := '<left>'+fMrktRaj( Huom);           //<left tms. PIENILLÄ KIRJAIMILLA ###
                           sb := '';
                           if (a_getReaa(1,Ps)>0) and (a_getReaa(2,Coss)>0)  then
     {if demo  then sb := 'X.xx'
               else}sb := fRmrkt (a_getReaa(3,Ps)*1000/a_getIntg(1,edv.YLE.Un)/Sqrt(3)/
                                  a_getReaa(4,Coss), 1,1);                                   //<Itod
      StrGr.Cells[10,rw] := sb;
                            if (a_getReaa(5,Ps)>0) and (a_getReaa(6,Ala)>0)  then
      StrGr.Cells[11,rw] := fRmrkt0( a_getReaa(7,Ps)*1000/a_getReaa(8,Ala), 1,0)             //<W/m²
                                                                             else
      StrGr.Cells[11,rw] := '';

    end//if nrv<=kesja
    else if BxGAuki
    then begin
      if eSar IN [0,9]                          //,Siirretään Boxista Celliin =Näytölle ############
      then StrGr.Cells[eSar,fVisERow] := '<left>'+BxG.Text    //''On tutkittu tätä ennen = if arvoOK
      else StrGr.Cells[eSar,fVisERow] := BxG.Text;  end
{   else begin                                  //<Pätee myös POISTOssa ############################
      for i := 1 to StrGr.ColCount -1  do  //<Pätee myös POISTOssa.  [0,rw] sai arvon EditMoFrm :ssa
          StrGr.Cells[i,rw] := '';         //<Putsataan varmuudeksi loput SAMAN RIVIN SARAKKEET
    end;//else}
  end;//with
   if NjVeja    or fUusRv_Vajaa  then NjFrm.PalautBtn.Enabled := true         //< +4.0.0
                                 else NjFrm.PalautBtn.Enabled := false;
   if (kesja>1) or fUusRv_Vajaa  then NjFrm.PoistaBtn.Enabled := true         //<,+4.0.0
                                 else begin
                                      PoistaVex;
                                      NjFrm.PoistaBtn.Enabled := false;  end;
end;//pvRivi;

procedure EditNjFrm;   var i,j{,e} :integer;  fi :string;  begin //<Kutsutaan EdvFrm:sta/TiedotOKnapClick
  fi := FONT_FII;
  with NjFrm  do begin
   {Lb1.Hint := Bx1.Hint;    Lb2.Hint := Bx2.Hint;    Lb3.Hint := Bx3.Hint;
    Lb4.Hint := Bx4.Hint;    Lb5.Hint := Bx5.Hint;    Lb6.Hint := Bx6.Hint;}
    with NjFrm.StrGr  do begin
      j := ColCount -1;
      for i := 0 to j                    do Cells[i,0] := '<center>'+ fImrkt0 (i,1); //<Ylin OTSrivi =sar.n:ot
      for i := FixedRows to RowCount -1  do Cells[0,i] := fImrkt0 (i-FixedRows+1,1); //<RivinumerotVasMarg:iin
    end;
    StrGr.Cells[0,1] := 'n:o ';          StrGr.Cells[ 1,1] := '<left>Keskus ';  StrGr.Cells[ 2,1] := 'dL [m] ';
    StrGr.Cells[3,1] := 'Ptod [kW] ';    StrGr.Cells[ 4,1] := 'Cos'+fi +' ';    StrGr.Cells[ 5,1] := 'Pvrt[W/m²] ';
    StrGr.Cells[6,1] := 'Cos'+fi+'Vrt '; StrGr.Cells[ 7,1] := 'A [m²] ';        StrGr.Cells[ 8,1] := 'PotTasaus ';
    StrGr.Cells[9,1] := '<left>Huom., ryhmitysaluetietoa tms.';
                                         StrGr.Cells[10,1] := 'Itod [A] ';      StrGr.Cells[11,1] := 'p [W/m²] ';
                                  //,,Asetettu PAAVAL/ init.=FA,  Moot.PAS / OkBtnClick :ssa TRUE
    if MootNJ  then               //=Alla olevat, ennalleen jäävät:  nj.jk[].dL,tunnus,huom
    with nj.jk[1], MoNj  do begin //= nj.jy.NjKulSal,Tk1v,tasaus,astapa,korjaus,kasvuv
     //MootKasitt := true;  MootNj := false; //<######### MootNj nyt valmiina, jos MO:sta UUSI KUTSU #########-4.0.0
       NjFilen := ExtractFilePath (NjFilen);        //<MootNjFileNSamaan dir´iin => pelkkä polku ilman filenimeä.
       NjFilen := NjFilen +'MootNj.' +filen_NjExt;  //<Extract.. teki jo 1x '\'.          <' +4.0.0

       a_putStrg (1, '',nj.jk[1].tunnus);    // kesja := 1 jo MoFrm.OkBtnClick :ssä jamoin ,,a_put..(..ketjussa)
       onArvot := true;
       a_putStrg (3, MoNj.mInfo,huom);    a_putReaa (4, MoNj.mPekv,Ps);
       a_putReaa (5, MoNj.mCosEkv,Coss);  a_putReaa (6, 0,palV);    a_putReaa (7, 0,cosV);   a_putReaa (8, 0,ala);
       SijNjuIfVE1;                          //< +4.0.0
    end;//>NJ-osa:          nj.jy.+ketjussa,NjKulSal,Tk1v,tasaus,astapa,korjaus,kasvuv
        //>NJ-osa:          nj.jk[].Tunnus,Huom,+dL,+Ps,+Coss,palV,cosV,ala
        //>MootLähtöosasta: MoNj.mInfo :str;  mSul :i;  mPekv,mCosEkv, mItrm,mImg,mTim :r; =Loppuosa NjLas38.INC

    FrmOtsikko;
    kesja := a_getIntg (11,nj.jy.ketjussa);    //<Frmn avauksessa välttämätön, myös todettu ########
                                               //,Ettei jäisi kopioituja rivejä näkyviin, TODETTU (Nj:ssä)!!
    for i := fJKtoAbsROW (kesja+1) to StrGr.RowCount -1  do //<Putsataan loput rvt varmksi, esim. PALA
    for j :=                    1  to StrGr.ColCount -1  do //<'UTA ja POISTA saattoi jättää 'häntiä'
        StrGr.Cells[j,i] := '';

       j := a_getIntg (10,edv.YLE.JohtoOsia);                                                //< +4.0.0, -1=6.2.2
     //e := a_getIntg (11,edv.YLE.SorceCount);  //<-10.0.5                                   //< +6.2.2
       i := j+1;                                                                             //< +4.0.0 +1=6.2.21
{      if edNo=0                                //<,,-10.0.5 =Nyt aina lisätään loppuun.      //<,,+6.2.2
       then edNo := 1
       else if edNo<-1*e
       then edNo := -1*e
       else if (edNo>0) and (edNo>i+1)                  //<Jos vaikka edja muuttunut
       then i := edNo+1;                                //<edNo viittasi edja+1 -johto-osaan //< +4.0.0}
    Bx1.Text := fImrkt0 (i,1);                                                               //< +4.0.0
       if i=j+1  then NjFrm.Bx1.Text := Bx1.Text +' =loppuun';                               //< 6.2.21 =j+1

    MootVrkMuutosInfo := false;
    if MootNJ  then begin                                                                    //<,,+7.0.5
       j := a_getIntg (30100, mo.moty.Vrk);
      {if i<>j  then //,,Lähes sama herja myös NjVrk.PAS :ssa.                               //<,,-10.0.4
          InfoDlg ('Moottolähtöjen käsittelyosassa <b>"Verkkopiste"='+                       //8.0.10
                   Ints (j)) +'</b> poikkeaa tässä <b>"Laskettava ED.VERKON '+
                   'johto-osa" </b>-ikkunan arvosta (=<b>' +IntToStr (i) +')</b>. Korjaa, <b>jos '+
                   'laskentatilanne </b>niin edellyttää.',
                   mtCustom,'Jatka','','','',  '','','','');}
       if i<>j  then begin //,,Lähes sama herja myös NjVrk.PAS :ssa.
          Bx1.Text := Ints (j);                          //<Äsken sijoitettu korvataan tässä.
          MootVrkMuutosInfo := true;                     //< Info verkkopisteen muuttamisesta siirretty
       end;                                              //  NjVrk.PAS´siin. MootVrkMuutos ilmaisee infotarpeen.
    end;                                                                                  //<''-10.0.4
       if a_getBool (10, nj.jy.NjKulSal)  then
    Bx2.Text := 'KULUTT.'  else Bx2.Text := 'SÄHKÖL.';
    Bx3.Text := fMrktRaj (nj.jy.Tk1v   );
    Bx4.Text := fMrktRaj (nj.jy.UhRaja );
    Bx5.Text := fMrktRaj (nj.jy.tasaus );
    Bx6.Text := fMrktRaj (nj.jy.astapa );
    Bx7.Text := fMrktRaj (nj.jy.korjaus);
    Bx8.Text := fMrktRaj (nj.jy.kasvuv );
    Bx9.Text := fImrkt0 (VExKrt,1);       //<+6.1.1

    for i := 1 to kesja  do  if (i<=StrGr.RowCount -1) and (i<=kesmax)  then pvRivi(i);

   {SyottoAvFrm.FormStyle := fsNormal;    //< +1.1.3  Vaatii tämänkin ennenkuin SyottoAvFrm StayOnTop, TODETTU!!!
    SyottoAvFrm.FormStyle := fsStayOnTop;
    if NOT NjFrm.Visible  then ShowModal; //< +1.1.3 Oli SHOW;  Nyt ei enää olisi Edv:ssä tarpeen BtnClickeissä}
                                          //  yms. sulkea NjFrmia, koska ..Modal edellyttää KÄSIN sulkemista
   {SyottoAvFrm.FormStyle := fsNormal;
    SyottoAvFrm.FormStyle := fsStayOnTop;}
  //if NOT NjFrm.Visible  then NjFrm.ShowModal; //< +1.1.3 Oli SHOW;  -6.0.0
    if NOT NjFrm.Visible  then begin
       EdvNewFrm.Enabled := false;              //< +6.0.0
       PaaValFrm.Enabled := false;              //< +6.0.0
       NjFrm.Show;  end;                        //< +1.1.3 Oli SHOWMODAL ilman EdvNewFrm.Enab... +6.0.0
//§§Update;  //<Väliaikaisesti vex -4.0.0
  end;//with
end;//EditNjFrm;
//==================================================================================================
function fOKrivit :boolean;      var i :integer;  onOK :boolean;      begin
  onOK := true;       //with NjFrm.StrGr  DO Y_Koe (0,Cells[1,1]+'   '+Cells[1,2]+'   '+Cells[1,3]);
                      //if NjFrm.StrGr.Cells[1,3]=''  then Y_piipit (50);
  if kesja=0
  then begin onOK := false;
             HerjaInfo ('Kuormitustiedot puuttuvat, korjaa.');  end
  else with NjFrm  do begin
    i := 0;
    repeat i := i+1;
           with StrGr  do  if ((Cells[1,i]<>'') or (Cells[2,i]<>''))  and  (Cells[8,i]='')
                           then onOK := false;
    until  NOT onOK  or (i=StrGr.RowCount-1);// or ((StrGr.Cells[1,i]='') and (StrGr.Cells[2,i]=''));

    if NOT onOK  then HerjaInfo ('Rivi '+fImrkt0(i,1)+':   Tiedot puuttellisia, korjaa.')
  end;
  fOKrivit := onOK;
end;//fOKrivit
//==================================================================================================
function fAbsCo (JKsar :integer) :integer;      begin  Result := fJKtoAbsCOL (JKsar);   end;
function fAbsRw (JKriv :integer) :integer;      begin  Result := fJKtoAbsROW (JKriv);   end;
                                                             //,,,,,,,,,,,,,,,,Olet = EiOK..........
{function OkStr (JKsar,JKriv :integer) :boolean;     begin  Result := false;    //=Riv/Sar oltavaOK ja Cell<>''
   with NjFrm.StrGr  do        //,Varmksi tarkistetaan lukualue. Sallitaan luku VIKALTA OTSrv/sar:sta =Fixd.-1
   if (fAbsCo (JKsar) IN [FixedCols-1..ColCount-1]) and (fAbsRw (JKriv) IN [FixedRows-1..RowCount-1]) and
      (Cells[fAbsCo (JKsar),fAbsRw (JKriv)]<>'')    then Result := true;  end;}
function OkStr (JKsar,JKriv :integer) :boolean;      VAR Co,Rv :integer;      begin //=Riv/Sar oltavaOK ja Cell<>''
   Co := fAbsCo (JKsar);
   Rv := fAbsRw (JKriv);
                               //,Varmksi tarkistetaan lukualue. Sallitaan luku VIKALTA OTSrv/sar:sta =Fixd.-1
{  if (Co IN [NjFrm.StrGr.FixedCols-1..NjFrm.StrGr.ColCount-1]) and
      (Rv IN [NjFrm.StrGr.FixedRows-1..NjFrm.StrGr.RowCount-1]) and
      (NjFrm.StrGr.Cells[Co,Rv]<>'')
      then Result := true
      else Result := false;  end;}
   Result := false;
   if (Co IN [NjFrm.StrGr.FixedCols-1..NjFrm.StrGr.ColCount-1]) and
      (Rv IN [NjFrm.StrGr.FixedRows-1..NjFrm.StrGr.RowCount-1])
      then if NjFrm.StrGr.Cells[Co,Rv]<>''
              then Result := true;
      end;

{function fNapOK :boolean;     VAR cSar,cRiv :integer;  boa :boolean;    begin //< +4.0.0
   boa := false;   cSar := fAbsCo (Sar);   cRiv := fAbsRw (Riv);

   if (Sar IN [1..vCol+1]) and (Riv IN [1..kesmax])  then
   if (NjFrm.StrGr.Cells[cSar,cRiv]<>'') and (Riv IN [1..kesja])  OR   //<==Click t.Enter vanhalle riville
      ( (NjFrm.StrGr.Cells[cSar-1,cRiv]<>'')         AND                  //<,VasPuollaOltavaArvo UUDELLA RVLLÄ(tietenkin myös vanhalla)
        (Riv IN [1..kesja+1])  or                                         //< Uusi rivi(= +1)(mikä sarake vaan)
        ( (Sar=1)  AND                                                 //<==Clik t. Enter ekaan arvosar :een.
          (Riv=kesja+1) and (NjFrm.StrGr.Cells[vCol,cRiv-1]<>'')  or      //<EdRvllä vCol :ssa AINAoltavaArvo t.
          (Riv=kesja+2) and  BxGAuki  and (NjFrm.BxG.Text<>'')  and    //<BxG on auki uuden rivin lopussa ja
          (BxSar=vCol)  and (BxRiv=Riv-1) ) )                             // BxG :ssä on arvo.!!!!!!!!!!!!!!!!!
      then boa := true;
   Result := boa;   end;}

//==================================================================================================
       //Tarkistaa näpäytyskohdan + tarvittaessa myös arvoOK :n + kutsuu PvRIVI ####################
       //   ChkCelNo>0 = Tarkistetaan Mouse- t. KeyEnterClick´in (seur.)paikka =Onko SAR,RIV luvallinen kohta.####
       //   ChkCelNo=0 = Tarkistetaan VAIN BxG :n ARVO (text) JA VAIN, JOS BXGAUKI.###############################
function fEhkaTarkArvo (ChkCelNo :integer) :boolean;      VAR abo,boo, CHKos,napOK,UusSar,UusRvEnd, OnJoPiip :boolean;

                  //Sr,Rv = Sar,Riv ,,,,,,,,,,,,,,,,,,,,,,,,,, Vois olla globaali, nyt vain tässä ,,,,,,,,,,,,,,,,
   function fNapOK (Sr,Rv :integer) :boolean;    VAR cSr,cRv :integer;  boo,boE,boU,boV :boolean;  begin//< +4.0.0

      cSr := fAbsCo (Sr);   cRv := fAbsRw (Rv);
      boE := false;   boU := false;   boV := false;
                                                                  //,===Click t.Enter vanhalle rvlle 1..vCol+1 =OK.
      if (Sr IN [1..vCol+1]) and (Rv IN [1..kesmax])  then begin      //<,Estettävä AINAKIN, ettei cSr-1,cRv-1 < 0
         boE := (NjFrm.StrGr.Cells[cSr,cRv]<>'')   and (Rv IN [1..kesja]);

         boU := (Rv IN [1..kesja+1])  and                         //<=== Click/Enter uudelle riville.#############
                  (cSr-1>=0) and (NjFrm.StrGr.Cells[cSr-1,cRv]<>'')  OR        //<Vanhasta arvosta seur.oik.
                  BxGAuki    and (BxSar=Sr-1) and (BxRiv=Rv);                  //<,Vanhasta +2 ja heti vanhan jälk.
                                                                               //  seur (=+1) BxGAuki.!!!!!!!!!!!!
         boV := ( (Sr=1)  AND                                       //<=== Click/Enter uudelle rville Sar=1 :een.
                  ((Rv=kesja+1) and (NjFrm.StrGr.Cells[vCol,cRv-1]<>'')  or  //,EdRvllä vCol :ssa AINAoltavaArvo t.
                   (Rv=kesja+2) and  BxGAuki  and (NjFrm.BxG.Text<>'') and   //<BxG on auki uuden rivin lopussa ja
                   (BxSar=vCol)  and (BxRiv=Rv-1)) );                        //<< BxG :ssä on arvo.!!!!!!!!!!!!!!!
      end;
      boo := boE  or  boU  or  boV;
      Result := boo;   end;

   function OkClickKarkea (JKsar,JKriv :integer) :boolean;      VAR Co,Rv :integer;      begin
      Co := fAbsCo (JKsar);
      Rv := fAbsRw (JKriv);
      if (Co IN [NjFrm.StrGr.FixedCols..NjFrm.StrGr.ColCount-1]) and (Co IN [1..vCol+1])   and
         (Rv IN [NjFrm.StrGr.FixedRows..NjFrm.StrGr.RowCount-1]) and (Rv IN [1..kesmax])
         then Result := true
         else Result := false;  end;

   function BxGnAllaTyhjaCell :boolean;      VAR cSr,cRv :integer;      begin
      result := false;   cSr := fAbsCo (BxSar);   cRv := fAbsRw (BxRiv);
      if BxGAuki  and (NjFrm.StrGr.Cells[cSr,cRv]='')
         then result := true;  end;

begin//fEhkaTarkArvo..................................................Muokattu 4.0.0
                                                   //NjFrm.Caption := 'eS='+fImrkt0(eSar,1)+' s='+fImrkt0(Sar,1);
  napOK :=    false; //<Näpäytys OK-alueella = OKCelliin     '''FNC Strg vain pienemmän kirj./kutsutilan takia
  UusSar :=   false; //<UUSIsarake (uudelle riville), jo käyty TAI ei.   TR VAIN, jos <= KäytySar+1
  UusRvEnd := false; //<UUSIriviValmis
  if ChkCelNo>0  then CHKos := true   //< =Tarkistetaan Mouse- t. KeyEnterClick´in paikka =Onko luvallinen kohta.
                 else CHKos := false;
                        //   #####################################################################################
with NjFrm  do begin    //<,,######### HUOM: Jos BxG.Visible=TRUE, on sen paikka OK, eikä tartte testata.#########
                        //   ################### BxG.VISIBLEn ILMAISEE BxGAuki (asetettu tätä varten),############
                        //   ################### KOSKA jos TopLeftChanged => BxG.Visible := FALSE.    ############
                        //   #####################################################################################
  if Defs_KoeAjo  then
     SyottoAvFrm.Hide;  //<VAIN KOKEILUSSA = PIILOTTAA AVUSTEIKKUNAN, ettei peitä sorsaa BrekPoint -katselussa

  if NOT CHKos                              //<,, +4.0.0
  then napOK := true                        //<NapOK := myös jäljempnä (x1) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  else begin
     abo := OkClickKarkea (Sar,Riv);        //<1..kesmax =karkea raja, tarkentuu seur.
     boo := fNapOK (Sar,Riv);
     if abo  then
        napOK := boo;                       //<NapOK := myös jäljempnä (x1) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  end;
                                            //,,,,,,,,,,,,Oltiin UUDEN RVn viimCellissä;;;;;;;;;;;;;;;;;;;;;;;;;;;
  if (eSar IN [vCol..vCol+1]) and (eRiv=kesja+1)  and          //<eRiv=BxG VIELÄ AUKI [eSar,eRiv] :ssa ###########
     BxGAuki  and (NjFrm.BxG.Text<>'')                         //<BxGAuki, koska Visible := FA jos TopLeftChanged
     then UusRvEnd := true;
                                            //,,,,,,,,,,,,UudnRivn seurTaiVanhaSarakeVaikkVälilMuualla;;;;;;;;;;;;
  if (Sar IN [1..vCol+1]) AND (Riv IN [1..kesmax])  AND        //<Oltava aina ainakin OKsarak+OKriveissä
     (StrGr.Cells[vCol,fVisRow-1]<>'')  AND                    //<EdRvn vCol:ssa oltava OKarvo, OK vaikka = OTSriv
      ( BxGAuki and (BxG.text<>'') and                         //<BxGAuki, koska Visible := FA jos TopLeftChanged
        (eSar=Sar-1) and (eRiv=Riv)     OR                     //<'Vas.puolella oltava BxG AUKI+arvo tai,,
        NOT BxGAuki  and OkStr (Sar-1,Riv)  and (Riv=kesja+1) )//<Vas.puolella oltava BxG KIINNI JA str.
     then begin UusSar := true;   napOK := true;  end;         //<NapOK mahd. saanut arvon myös alussa

  OnJoPiip := false;
  abo := true;       //,KeyDwn rivn päässä/alussa aiheutti TopRow/LeftCol-aset. =>TopLeftChange =>BxG.Visible :=FA
  if BxGAuki  then begin                                       // MINKÄ TAKIA BxGAuki käytetty (BxG.Visible ei käy)
{    if NjFrm.BxG.Text<>''
        then begin}
             abo := arvoOK (eSar,4);                    //<###### arvoOK sijoitti BxG => jk[] ####################
             OnJoPiip := true; {end                            //<'ErPiip tuli jo arvoOK´ssa jos eiOK       +4.0.0
        else abo := false;}
     if abo  then begin                                        //'################################################
        SijNjuIfVE1;                                           //<Prc 4.0.0
        if NjVeja or fUusRv_Vajaa                       //<############## NjVeja testaa joka #####################
           then NjFrm.PalautBtn.Enabled := true         //'############## kerta myös jk0:n #######################
           else NjFrm.PalautBtn.Enabled := false;  end; end;

  if (UusRvEnd or UusSar)  and abo                             //<Ei sijoituksiin ellei arvoOK #####
  then begin
     if UusRvEnd  then begin               //<,Vasta kun rivi valmis. Pitäisköhän ekax tsekata ArvoOK ????????????
        if eRiv>kesja  then kesja := eRiv;
        a_putIntg (12,kesja, nj.jy.ketjussa);
        SijNjuIfVE1;                                           //<Prc 4.0.0
     end;
     NjFrm.PalautBtn.Enabled := true;
  end;//if Uus.. & abo

//if NOT OnJoPiip  and ( NOT abo  OR  NOT napOK{+4.0.0}  and (Sar IN [StrGr.FixedCols..vCol]) )
  if NOT OnJoPiip  and
    (NOT abo  OR  ( NOT napOK{+4.0.0}  and BxGAuki  and (Sar IN [StrGr.FixedCols..vCol+1]) ))
    then erPiip;//Y_Piipit (200);

  if abo  then begin                     //<,,###################### Muutos 4.0.0 ################################
     if eRiv>0  then pvRivi (eRiv);      //<<<###################### Päivitetään RIVI ############################
     if NjTulAuki  and BxGAuki//BxG.Visible
        then NjTulFrm.Close;             //<Arvot mahdMuuttui, laskenta eiEnääPäde
     BxGAukiVisOff;  end                 //<<<##### BxGauki+Visible := FA Vex vain jos SeurClick/KeyDown #########
  else if BxGnAllaTyhjaCell              //'  ##### OK. EI ENNEN, koska BxGAuki´a testataan ######################
  then BxGAukiVisOff                     //<Suljetaan vain jos ALLA TYHJÄ Celli t. ARVO OK (ks.ed. BxGAukiVisOff)
  else begin                             //'######################################################################
     if BxGAuki  then                    //'######################################################################
        NjFrm.BxG.Visible := true;
     if NjFrm.BxG.Visible  then          //<if.. ehto, etteiError: Can´t focus invisib..''
        NjFrm.BxG.SetFocus;  end;        //<Aiheuttaa OnBxGEnter´in -> SijBxG ####################################
                                         //'######################################################################
  if NOT napOK  then abo := false;       //<Oli jo ehkä arvoOK :sta := FA.
  result := abo;     //<################## RESULT //'#############################################################
end;//with           //'## = TRUE, jos Click OK-celliin JA ao. syöttökohdan ARVO=OK (joka silloin sijoitettiin) ##
end;//fEhkaTarkArvo; //'##########################################################################################
{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NjVrk.INC}

