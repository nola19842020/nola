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

{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Moot.INC}
//a_getIntg (30111..
//ed. ~toimiva:  MootEu.INC  = Ennen:   TopRow, LeftCol   VisibleRowCount, VisibleColCount käytöstä luopumista
{Erikoismerkkejä:  ø155,Ø157,×158,ƒ159,ª166,º167,¿168,®169,¬170,½171,¼172,¡173,«174,»175,©184,¢189,
                   ß225,µ230,þ231,Þ232,¯238,±241,¾243,¶244,÷246,¸247,°248,¨·250,¹251,³252,²253}

//,,,,,,, - = FNC ei käytetty   % = Algoritmi tarkistettu =Top..VisibleCoun.. VEX  % = FNCa käytetty #########
//,,,,,,,fMOtoAbsROW = Moott.lähtörivstä CellRow :ksi, oli TopRow mikäVaan =ao.Mriv pvittyy näkyi tai ei #####
function fMOtoAbsROW (r :integer) :integer;    begin  with MoFrm.StrGr  do                              //<%%
                                     result := r +FixedRows -1;  end;
function fMOtoAbsCOL (c :integer) :integer;    begin  with MoFrm.StrGr  do                              //<%%
                                     result := c +FixedCols -1;   end;
function fMOtoVisROW (r :integer) :integer;    begin  with MoFrm.StrGr  do       //<Näkyvä  Row->Mrv       %%
                                  //§result := r -TopRow +FixedRows +2;   end;
                                     result := r +FixedRows -1;   end;
function fVisRow  :integer;   begin  result := fMOtoVisROW (Mrv);   end; //<Ao. MRV -lähtörivi Row :ksi    %%
function fVisERow :integer;   begin  result := fMOtoVisROW (eMrv);  end; //<Ao.eMRV -lähtörivi Row :ksi    %%

function fMOtoVisCOL (c :integer) :integer;          begin  with MoFrm.StrGr  do //<Mrv -> Näkyvä COL      %%
                                  //§result := c -LeftCol +FixedCols +2;   end;
                                     result := c +FixedCols -1;   end;
function fVisCol  :integer;   begin  result := fMOtoVisCOL (Sar);   end; //<Ao. SAR -sarake CellColl :ksi  %%

function fAbsROWtoMRV (AbsRow :integer) :integer;    begin  with MoFrm.StrGr  do //<Absol   Row->MRv       %%
                                     result := AbsRow -FixedRows +1;   end;
function fAbsCOLtoSAR (AbsCol :integer) :integer;    begin  with MoFrm.StrGr  do //<Absol   Row->Sar       %%
                                     result := AbsCol -FixedCols +1;   end;

//,,,,,,,fOKrw=Scrollaus huomioituna näpäytetty sallitulle riville,  fOKcl=sarakkeelle,  fOKclRw=molemmat OK
function fOKrw: boolean;      begin  result := false;   with MoFrm.StrGr  do
   if (fVisRow>=FixedRows) and (fVisRow<=fMOtoVisROW (motja))   then result := true;   end; //<..ja <=motja
function fOKcl: boolean;      begin  result := false;   with MoFrm.StrGr  do
   if (fVisCol>=FixedCols) and (fVisCol<=fMOtoVisCOL (vCol))    then result := true;   end; //<..ja <=motja
function fOKrwCl: boolean;    begin  result := false;  //<Näp OSUU näkyvän scrollaavan StrGr :n celleihin
   if fOKrw and fOKcl   then result := true;   end;

//LbY1r1MouseMove :een kannattaa laittaa:  ..Text := '', nyt kommentoitu vex #################################
procedure ediS (s :string);      begin  MoFrm.EdiY1.Text := s;  end;
procedure ediS_(s :string);      begin  MoFrm.EdiY1.Text := MoFrm.EdiY1.Text +s;  end;

procedure ediO (s :string);      begin  MoFrm.Caption := s;  end;
procedure ediO_(s :string);      begin  MoFrm.Caption := MoFrm.Caption +s;  end;

procedure Kok (Csar,Criv :integer;  str :string);      var i :integer;      begin
   i := 0;  MoFrm.StrGr.Cells[Csar,Criv] :='';                    //<,Tulostaa Cellin sarakkeisiin. '#'välissä
   with MoFrm.StrGr  do                                           //,,siirtää seuraavaan sarakkeeseen <<<<<<<<
   while i<Length (str)  do begin   i := i+1;          
      if (str[i]='#') and (Csar<ColCount-1)  then begin
         Csar := Csar+1;
         Cells[Csar,Criv] :='';  end;
      if str[i]<>'#'  then Cells[Csar,Criv] := Cells[Csar,Criv] +str[i];
   end;
end;

procedure moVEo;   begin  moVE := 1;  end; //<Asetetaan Moottorilähtötietueen oletusVE ############# 
procedure FrmOtsikko;      VAR s :string;      begin;
   s := 'Moottorilähdöt:   ';
   if MoFilen=''  then s := s +'(Oletusarvot)'
                  else s := s +MoFilen;
   MoFrm.Caption := s;
end;

function Blu (s :string) :string;      begin
   result := COLOR_BLUE+'<b>' +s +'</b>'+COLOR_END;  end; // = '</f>'
//==================================================================================================
procedure pvRivi (nytYht,mr :integer); //<nytYht >0 =LASKETAAN + päivitetään "NJ-Laskentaan" yms. tiedot
                                       //#####################################################################
                                       //#####################################################################
                                       //'MR oltava OIKEA osoite MOTR[] OSOITTEINA, EI SIIS CelliRvnä
                                       //#####################################################################
                                       //#####################################################################
                                       const cnt='<center>';  s_=' - - - ';  {120.5k::}DetFA=false;  DetTR=true;
                                       var rw,i,k,napM{,rnoM,kplM} :integer;       suCsm :string;   boo :boolean; //<,,+4.0.0
                                           ar,rr,kwM,cosM,timM,korjM,Lmin :real;   ss,sa,astM :string;
                                           //,,PRC RJarvot -kutsuun,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                                           qj_sul        :integer;                          //<,,,,,Paluuarvot

                                           qj_xCu        :integer;    qj_mmCu      :real;   //<Cu,,,,,,,,,,,,,
                                           qj_LmaxCu     :real;       qj_ChrCu,qj_ChrOikCU :string;
                                           qj_PmaxCu     :real;
                                           qj_LmaxPmaxCu :real;       qj_ChrPmaxCu :string;

                                           qj_xAl        :integer;    qj_mmAl      :real;  //<Al,,,,,,,,,,,,,,
                                           qj_LmaxAl     :real;       qj_ChrAl,qj_ChrOikAL :string;
                                           qj_PmaxAl     :real;
                                           qj_LmaxPmaxAl :real;       qj_ChrPmaxAl :string;

  //,,Lasketaan Uk=Zpe*Uo/Zs, missä Zpe on jakokeskuksen ja pääPT:n välisen PE-johtimen Z.  Lääkintä Leikkaussali Lääk.
  function fUkmoS (AlCu :boolean;  xMm2 :real;  xKpl :integer;  xL :real) :string;        //<,,Kosketusjännite Uk
           VAR ar,Rn,Xn,Zn, {uRn,uXn,} Zk{,Zk0, Ik} :real;  xTyp,su :string;              //<,,VrkNo,Rk..Zk +6.0.3
               VrkNo,ohj :integer;  {boo :Boolean;{+7.0.3 -11.0.1}          begin         //'uRn,uXn -11.0.1
//Moottorilähtöjen verkkopiste (ed.verkon kuvaajan AO. JOHTO-OSAN JÄLKEEN).
     VrkNo := a_getIntg (30105, mo.moty.Vrk);                             //<VrkNo = Verkon solmupisteen nro ,-11.0.1
    {if VrkNo>0  then boo := a_getBool (30104, edv.edka[VrkNo].PTlopussa) //<,+7.0.3  VrkNo osoitettiin jNon loppuun.
                 else boo := a_getBool (30104, edv.Sorc[1].josa.PTlopussa);//, = Moottorilähtökeskuksen sij.piste
    {if (xMm2=0) or (xKpl=0) or (VrkNo=0) or boo                          //<Jos ao.vrkopisteessa on, eiTartteTutkia
     then result := s_                                                    //'<Nämä ehdot vain, kun rj:n Zpe:tä eiTartteTutkia}
     if (xMm2=0) or (xKpl=0)                                              //'- <+11.0.1: Ei johtoa jota tutkia.
     then result := s_
    {else if (VrkNo=0) or boo                                             //<11.0.1: Nyt aina tutkitaan =etsit. PT
     then result := '<center>PT»'                                         //<+11.0.1 »« Kokeilu: PT» }
     else begin
        if AlCu  then xTyp := 'AMCMK3½'  else xTyp := 'MCMK3½';
          //Loppuun=11, Asti,NJkin  ,  QJtyp,QJmm2........................  //, Koko oikos.piirin Zk1v moottori-
        Zk := Ziks (11,VrkNo,NJkinFA,0, xTyp,xMm2,xL,xKpl,80, ar,ar,ar,ar); //  ryhmäjohdon LOPPUUN =Zs.
        Zk := Zk/3;                                                       //<6.0.3:n korjaus: Ziks sis. 3.!!!!!!!!
        {,,,,,,,,,,,,,,,,,,,,,,,Tarvitaan vain, kun laskettiin Uk moottoriRj:n Zpe mukaan,,,,,,,,,,,,,,,,,,,,,,,,
               if VrkNo<1  then begin
                  Zk0 := Ziks (2,VrkNo,NJkinFA, '',0,0,0,0, ar,ar,ar,ar); //<Zk mottoriryhmäjohdon ALKUUN.
                  Zk := Zk -Zk0;  end;                                    //<Erotus = pelkän moottoriryhmäjohdon Zk.
               Ik := Iks (Ik3vFA,Zk);                                     //<FALSE =NOT IkMax =Ik1v
               Rn := resP (xTyp,xMm2);
                  Rn := rTkorj (fPal (xTyp),Rn,80) *xL/xKpl;              //<FA =Myös AMCMK:lla PEN=Cu
               Xn := Xp_ind (xTyp,xMm2);
               Xn := Xn *xL/xKpl;
        ''''''''''''''''''''''''Näitä tarvittiin vain, kun laskettiin Uk moottoriRj:n Zpe mukaan'''''''''''''''''}
        ar := fUmv;                              //<Vain debuggerille.
        Zn := 50*Zk/fUmv;                        //<,Yläraja Zn:lle laskeEdvZpe -kutsuun:   Uk = Zpe*Uo/Zs.  +11.0.1
        laskeEdvZpe (mr,VrkNo,Zn, ohj,Rn,Xn,ar); //<ohj,uRn,uXn =Palautuvia arvoja =Laskee edvn PE:n Zn :n.
                                                 //'MR=moOs, ar vain syntaxin takia
//KESKEN tarkistuslaskennat???
        if ar<0  then ;
        Zn := Sqrt (Sqr (Rn) + Sqr (Xn));                 //<uRn,uXn nyt tarpeeton = -11.0.1 . KosketusJännite KoskJännite LääkintätilanKosketusJännite.
                   {ar := Ik * Zn;       =Tätä tarvittiin vain, kun laskettiin Uk moottoriRj:n Zpe mukaan: -6.0.3}
        ar := Zn*fUmv/Zk;                                 //<Uk = Uo*Zpe/Zs , vrt. A2 413.1.3.5 ja Treen AMKK. <=+6.0.3 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        //.........................################### 130.2e: '=> Uk/Zpe = Uo/Zs  == KoskJännite/Zpe = Uo/Zpe.###############################################
        //'Uk (=ar) nyt pienempi:  Ziks_a :ssa QJ ohittuikin (vastoin aiempia käsityksiä), ks. 10.INC/Ziks_a: 11.0.1
        //>>>>>>>>>>>>>>>>>>>>>>>> Uk = Uv*Zpe/Zs. Zpe=Zpe-jhtimen Z pääpot.kiskoon asti,  Zs=KokonaisOikosImped pääpot. asti. (Lähde: Treen AMKK).
        //>>>>>>>>>>>>>>>>>>>>>>>>'###############################################################################################################'
                                           if MoFrm.EdiY1.Text<>''  then begin //"Kuvaus"-bxiin annettuna str´nä.
                                               su := Trim (MoFrm.EdiY1.Text);   SokI (su,ohj);   Delete (su,1,1);
                                               su := Trim (su);                 SokR (su,ar);    end;//}
           su := fRmrkt0 (ar,1,1);
        if ar>50  then
           su := CLR_REB +su;
ar := edRp(1,2,3);
if ar<0  then ;
        case ohj of                         //<OHJ:  1=PT kohdalla   2=PTedellä   3=PTjäljssä   0=PTtäEiooEdv:ssä.
           0 :result := CLR_REB +'eiPT';         //< 0 =Ei PT:tä verkossa ollenkaan.               +11.0.1
           1 :result := su;                      //< 1 =PT kohdalla => Näytetään arvo.             +11.0.1
           2 :result := su;                      //<Riittävän pieni Zpe edellä verkossa =yleensä näin, 7.0.3
           3 :result := CLR_BLU +su +'<b>~';     //<Merkiksi, että OK Zpe löytyi jälempää verkosta.
        else  result := '???';  end;//case
     end;
  end;//fUkmoS
(*function fLuk50V :real;      VAR ar,Rv,Xv,Zv, Xvo,Zvo, Rn,Xn,Zn :real;    begin //<,,L, kun kosketusjännite=50v
          { Zik = V¨[3Lik(Rv+Rn)]²+[Lik(2Xv+Xvo+3Xn)]² = Lik V¨[3(Rv+Rn)]²+[(2Xv+Xvo+3Xn)]²  =  Lik*Zik
            Seuraavassa Zik ja Zn ovat PITUUSYKSIKKÖÄ KOHTI,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
            Yhtälöparista:   Ik1v = 3*c*Uv / (Lik*Zik)  ja  Uk = Ik1v*Lzn*Zn,   johon sij Ik1v
                             Uk =   3*c*Uv*Lzn*Zn / (Lik*Zik),                  mistä ratkaistaan Lzn
                             Lzn =  Uk*Lik*Zik / (3*c*Uv*Zn)
            Havaitaan:  Jos  Lik=Lzn, kosketusjännitteen Uk:n määrää kaapeliominaisuudet. Vasta kun Lzn<>Lik,
                        voidaan Lzn ratkaista muista tekijöistä eli, kun PT on muualla verkossa !!!!!!!!!!!!}
     Rv := res ('MCMK',qj_mmCu);
        Rv := rTkorj (FALSE,Rv,80);
        Rv := Rv   /qj_xCu;
     Xv := Xv_ind ('MCMK',qj_mmCu);
        Xv := Xv   /qj_xCu;
     Zv := Sqrt ( Sqr(Rv) + Sqr(Xv) );

     Xvo := Xv0_ind ('MCMK',qj_mmCu);
        Xvo := Xvo /qj_xCu;
     Zvo := Sqrt ( Sqr(Rv) + Sqr(Xvo) );

     Rn := resP ('MCMK',qj_mmCu);
        Rn := rTkorj (FALSE,Rn,80);
        Rn := Rn   /qj_xCu;
     Xn := Xp_ind ('MCMK',qj_mmCu);
        Xn := Xn   /qj_xCu;
     Zn := Sqrt ( Sqr(Rn) + Sqr(Xn) );

     ar := 3*0.95 * fUmv * Zn / ( 50 *(2*Zv + Zvo + 3*Zn) );
     result := ar;
   //result := fRmrkt0 (ar,1,1);
  end;//fLuk50V*)

  procedure Kutsu_RJarvot(DetNyt :boolean);      begin//Erillisenä RJ..kutsu koska sitä kutsuttava 2x:  alussa + DetEv´hen lopussa.
      RJarvot (DetNyt,mr, suCsm, Lmin, qj_sul, //<suCsm muuttui kutsussa, jos suCsm :n tyypissä ei riittävän isoa==<>==!
                            qj_xCu,    qj_mmCu,                                                               //!
                            qj_LmaxCu, qj_ChrCu,qj_ChrOikCU,                                                  //!
                            qj_PmaxCu,                                                                        //!
                            qj_LmaxPmaxCu,qj_ChrPmaxCu,                                                       //!
                                                                                                              //!
                            qj_xAl,    qj_mmAl,                                                               //!
                            qj_LmaxAl, qj_ChrAl,qj_ChrOikAL,                                                  //!
                            qj_PmaxAl,                                                                        //!
                            qj_LmaxPmaxAl,qj_ChrPmaxAl);                                                      //!
  end;//Kutsu_RJarvot
               //################################################################################################
begin {pvRivi    ######## Tulosteet (>=2.0.1) joiltain osin saattavat poiketa version 2.0.0 tulosteista, ########
                 ######## koska 2.0.1: ssä otettu käyttöön TikAR ja IktAR -fnct. AINOA TULOSEROJA        ########
                 ########       AIHEUTTAVA KOHTA (grid):         NolaM2.INC  r.30  (fSul)      TikAR     ########
                 ######## (IktAR -kutsut vastaavat aikaisempia Ikt -kutsuja, joissa vastaavat kertoimet).########
                 ################################################################################################}

  if IsDebuggerPresent  then DetEvFrm.Hide; //<+120.5k
  if (mr>0) and (mr<=momax)  then     //,########################################################################
  with MoFrm, mo.motr[mr]  do begin   //<MR oltava OIKEA osoite MOTR[] OSOITTEINA, EI SIIS CelliRvnä ############
    rw := fMOtoAbsROW (mr);//<###################################################################################
    if mr<=motja           //<EI SAA PÄSTÄÄ LASKEMAAN VAJAATA RIVIÄ =KAIKKI RIVIN ARVOT OLTAVA, TODETTU!!!!!!!###
    then begin             //<###################################################################################
      //napM := a_getIntg (30111, nap);    Jostain syystä ei worki 130.0
      napM := mo.motr[mr].nap.ArvoInt;     //<+130.0
      kwM :=  a_getReaa (30113, kw);      {kplM :=  a_getIntg (30114, kpl);}
      cosM := a_getReaa (30115, cos);      astM :=  a_getStrg (30116, asT);
      timM := a_getReaa (30117, tim);      korjM := a_getReaa (30118, korj);
      Lmin := a_getReaa (30112, Lmo);

      suCsm := a_getStrg (30119, suT); //<Iter.vaiheessa MoLas2.INC :ssä saattaa muuttua + palautuu kutsussa=>==!
      suCsm := fSu_Str (suCsm);                                                                               //!
                                                                                                              //!
      Kutsu_RJarvot(DetFA); //+120.5:  RJarvot -kutsu siellä, kutsu myös PRC pvRivi´n lopussa =yht 2x.
{     RJarvot (mr, suCsm, Lmin, qj_sul, //<suCsm muuttui kutsussa, jos suCsm :n tyypissä ei riittävän isoa==<>==!
                            qj_xCu,    qj_mmCu,                                                               //!
                            qj_LmaxCu, qj_ChrCu,qj_ChrOikCU,                                                  //!
                            qj_PmaxCu,                                                                        //!
                            qj_LmaxPmaxCu,qj_ChrPmaxCu,                                                       //!
                                                                                                              //!
                            qj_xAl,    qj_mmAl,                                                               //!
                            qj_LmaxAl, qj_ChrAl,qj_ChrOikAL,                                                  //!
                            qj_PmaxAl,                                                                        //!
                            qj_LmaxPmaxAl,qj_ChrPmaxAl);                                                      //!}
                                                                                                              //!
      if ( fSu_Sama (suCsm,su_OFAg) OR  fSu_Sama (suCsm,su_OFAm) ) and (qj_sul>630)  OR //<==================<==!
         fSu_Sama (suCsm,su_IECd) and (qj_sul>100)    //<',Ehkei koskaan enää tähän =========================<==!
         then suCsm := su_IECg;                                                                               //!
                                                                                                              //!
      boo := eriMo0;                                  //< +4.0.0                                              //!
      a_putStrg (30119, suCsm, suT);                  //<Koska IsnikFnc muutti, jos ao. tyyppi ei riittänyt==<==!
      a_putStrg (30119, suCsm, moF.motr[mr].suT);     //<+4.0.0  Myös MoF´iin jotta MOVEJA=FA => PalautEnab := FA
      if NOT boo  then                                //<+4.0.0  ja MYÖS Mo0´aan JOS EI MUITA eroja => - " - - " -
      a_putStrg (30119, suCsm, mo0.motr[mr].suT);
      SijMouIfVE1;                                    //< +4.0.0

      if det  then begin
         ss := '<b>Rivi  '+fImrkt0(mr,1)+':   ';
         if kwM<1   then ss := ss + fRmrkt0(kwM,1,3)  else
         if kwM<20  then ss := ss + fRmrkt0(kwM,1,1)  else ss := ss + fRmrkt0(kwM,1,0);
{ad}     adStF (ss +' kW   '+fImrkt0(napM,1)+' nap ================================:</b>');  end;
      StrGr.Cells[1,rw] := '<center>'+{fMrktRaj( nap );} Ints(nap.ArvoInt); //<130.0
    //StrGr.Cells[1,rw] := 'A';
        {k := 0;
         if kW.ArvoRea <10  then k := 1  else
         if kW.ArvoRea <1   then k := 2  else
         if kW.ArvoRea <0.1 then k := 3;}
      StrGr.Cells[2,rw] :=            fMrktRaj( kw  ); //fRmrkt0(kW.ArvoRea,1,k); //<130.0
      StrGr.Cells[3,rw] :=            fMrktRaj( cos );
      StrGr.Cells[4,rw] :=            fMrktRaj( tim );
         k := rno.ArvoInt;
         if k<0  then;
      StrGr.Cells[5,rw] := '<center>'+{fMrktRaj( rno );} Ints(k); //130.0
      StrGr.Cells[6,rw] :=            fMrktRaj( kpl );
      StrGr.Cells[7,rw] := '<center>'+fMrktRaj( asT );
      StrGr.Cells[8,rw] :=            fMrktRaj( korj);

    //StrGr.Cells[9,rw] := '<center>'+fMrktRaj( suT ); //< -§~
      StrGr.Cells[9,rw] := '<center>'+fSu_Chr (suCsm);
      StrGr.Cells[10,rw] :=           fMrktRaj( Lmo);
      StrGr.Cells[11,rw] := Blu (
                            strKw (0, fIn   (kwM,cosM,napM)));                              //<In
      StrGr.Cells[12,rw] := strRd (0, fEta  (kwM,napM), 1,3);                               //<Hyötys.
      StrGr.Cells[13,rw] := strRd (0, fStN  (kwM,napM), 10,2);                              //<Is/In
                               RR :=  fIst  (kwM, fCos(kwM,napM), napM);                    //<Ist            //!
      StrGr.Cells[14,rw] := strRd (0, RR, 1,2);                                       //<'RR SÄILYy, ks.JÄLEMP<<!
                                                                                                              //!
      StrGr.Cells[15,rw] := strRd (0, fScos (kwM,napM), 1,3);                               //<CosStart       //!
         ss := s_;          ar := m_tasavImg * fIst (kwM, fCos(kwM,napM), napM);            //<Img-asetus     //!
                               ss := strRd (0, ar, 1,2);                                    //'=StartVara *Ist//!
      StrGr.Cells[16,rw] := '<b>' +ss +'</b>';                                                                //!
         ss := s_;          if qj_sul > 0  then ss := sijI (1, qj_sul);                     //<    <4A >630 =0//!
      StrGr.Cells[17,rw] := '<b>' +ss +'</b>';                        //,KsftYR = 1 + (Sft+tole)/100   -2.0.1 //!
         ss := s_;          IF qj_sul > 0  THEN begin //,Herkistetään sulaketta =kasvatet Ist, koklattu, OK.  //!
                              {ar := fIst (kwM, fCos(kwM,napM), napM) * KsftYR;             //< -2.0.1        //!
                               ar := Tik (sucM,qj_sul, ar);                                 //< -2.0.1 Sal[s] //!}
                             //'',,Nyt TikA_R ottaa huomioon toler.siirron (aiemmin oli vain Tik) @@@@@@@@@@@@//!
                             //ar := 1 / (1 - fMsuSft/100);                   //<= 1/0.9    //< +2.0.1        //!
                               ar := 1 + fMsuSft/100;                         //<= 10% =1.1 //< +2.0.1        //!
                               ar := fIst (kwM,fCos(kwM,napM), napM) *ar;                                     //!
{Tulos sama 2.0.0=2.0.1 :ssa'>}ar := TikAR (suCsm,qj_sul, ar);                //<'Sftn verran isompi Ist @@@@@//!
                               ss := strRd (0, ar, 1,2);  end;                              //'Ist -virtaa    //!
      StrGr.Cells[18,rw] := ss;                                                                               //!
         ss := s_;          IF qj_sul > 0  THEN begin                                                         //!
                             //ar := Ikt (sucM,qj_sul,timM) * KsftAR; //<KsftYR = 1 + (Sft-tole)/100   -2.0.1 //!
                             //'',,Nyt IktA_R ottaa huomioon toler.siirron (aiemmin oli vain Tik) @@@@@@@@@@@@//!
                             //ar := 1 / (1 + fMsuSft/100);                   //<= 1/1.1    //< +2.0.1        //!
                               ar := 1 - fMsuSft/100;                         //<= 10% =0.0 //< +2.0.1        //!
{Tulos sama 2.0.0=2.0.1 :ssa'>}ar := IktAR (suCsm,qj_sul,timM) *ar;           //<'1/Sftn verran pienpi Ik @@@@//!
                               sa := '';
                               if ar<RR  then begin         //<,RR säilytettiin tätä varten, ks. YLEMPNÄ!!!!!!!!!
                                  ar := RR;  sa := '´';  end; //<'Ei pitäisi enää tulla koskaan tähän ###########
                               ss := sa +strRd (0, ar, 1,2);  end;                          //<Sul sallii
      StrGr.Cells[19,rw] := ss;
      {==================== Cu ,,================================================================================}
         ss := s_;          if (qj_mmCu >0) and (qj_xCu >0)  then begin
                               ss := '';   if qj_xCu >1  then ss := fImrkt0 (qj_xCu,1)+'x';
                               ss := ss+ strRd (1, qj_mmCu, 3,1);                           //<N x mm2 CU
                               ss := ss +qj_ChrOikCU;  end;                                 //<+7.0.3
      StrGr.Cells[20,rw] := '<b>' +ss +'</b>';
         ss := s_;          if (qj_mmCu >0) and (qj_xCu >0)  then begin
                                                //1xSUL,Katk,....,.....,......,mm2..,kpl...),,,,,,,,
                               ar := YvSuoj (suCsm,TRUE,TRUE,astM,korjM,'MCMK',qj_mmCu,qj_xCu);
                               ss := strRd (1, ar, 1,2);                                    //<Iterm

                               if det  then begin //<,,SA :=... =Detaljilomakkeelle tulostusta,,,,,,,,,,,,,,,,
                                  if qj_sul>0  then begin
                                     sa := 'MCMK    ';
                                        i := 0;   if qj_mmCu<3  then i := 1;
                                     sa := sa +fRmrkt0(qj_mmCu,1,i);
                                        ar := Isal ('MCMK',qj_mmCu,astM);
                                     sa := sa +' sallii SUL   :lle  Isal '+fRmrkt0(ar,1,1);
                                        rr := korjM;                 sa := sa +' * Kas ' +fRmrkt0(rr,1,3);
                                           ar := ar * rr;
                                        rr := fKrin (astM,qj_xCu);   sa := sa +' * Krin '+fRmrkt0(rr,1,3);
                                           ar := ar * rr;
                                        rr := fKsul (suCsm,qj_sul);  sa := sa +' * Ksu ' +fRmrkt0(rr,1,3);
                                           ar := ar * rr;
                                     sa := sa +' = '+fRmrkt0(ar,1,1);
                                     if qj_xCu >1  then sa := sa +' *'+fImrkt0(qj_xCu,1) +' = '+
                                                             fRmrkt0(ar*qj_xCu, 1,1);
                                     sa := sa +'A.';
{ad}                                 ad1SF (sa);
                                  end;
                                  sa := 'MCMK    ';
                                     i := 0;   if qj_mmCu<3  then i := 1;
                                  sa := sa +fRmrkt0(qj_mmCu,1,i);
                                     ar := Isal ('MCMK',qj_mmCu,astM);
                                  sa := sa +' sallii KATK :lle  Isal '+fRmrkt0(ar,1,1);
                                     rr := korjM;                  sa := sa +' * Kas ' +fRmrkt0(rr,1,3);
                                        ar := ar * rr;
                                     rr := fKrin (astM,qj_xCu);    sa := sa +' * Krin '+fRmrkt0(rr,1,3);
                                        ar := ar * rr;
                                  sa := sa +' = '+fRmrkt0(ar,1,1);
                                  if qj_xCu >1  then sa := sa +' *'+fImrkt0(qj_xCu,1) +' = '+
                                                          fRmrkt0(ar*qj_xCu, 1,1);
                                  sa := sa +'A.';
{ad}                              ad1SF (sa);
                               end;//if det
                            end;
      StrGr.Cells[21,rw] := ss; //< - - - Säilyy, jos ei kaapelia
         ss := s_;          if (qj_LmaxCu >0) and (qj_sul>0)  then begin
                               ss := strRd (1, qj_LmaxCu, 100,1);                           //<RajaL
                               ss := ss +qj_ChrCu;  end;
      StrGr.Cells[22,rw] := ss;
         ss := s_;          if qj_LmaxPmaxCu >0  then begin
                               ss := strRd (0, qj_LmaxPmaxCu, 100,1);                       //<RajaL(Pmax)
                               ss := ss +qj_ChrPmaxCu;  end;
      StrGr.Cells[23,rw] := ss;
         ss := s_;          if qj_PmaxCu >0  then
                               ss := strKw (0, qj_PmaxCu);                                  //<Pmax
      StrGr.Cells[24,rw] := ss;
                            ss := fUkmoS (FALSE, qj_mmCu,qj_xCu,qj_LmaxCu);                 //<Uk
      StrGr.Cells[25,rw] := ss;
     {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      RJarvot (mr, suCsm, Lmin, qj_sul,                   |
                             qj_xCu,    qj_mmCu,          |> qj_xAl,    qj_mmAl,
                             qj_LmaxCu, qj_ChrCu,         |  qj_LmaxAl, qj_ChrAl,
                             qj_PmaxCu,                   |  qj_PmaxAl,
                             qj_LmaxPmaxCu,qj_ChrPmaxCu, >|  qj_LmaxPmaxAl,qj_ChrPmaxAl);}

         ss := s_;          if (qj_mmAl >0) and (qj_xAl >0)  then begin
                               ss := '';   if qj_xAl >1  then ss := fImrkt0 (qj_xAl,1)+'x';     //,N x mm2 AL
                               ss := '<b>'+ss +strRd (1, qj_mmAl, 3,1);
                               ss := ss +qj_ChrOikAL +'</b>';  end;                             //<+7.0.3
      StrGr.Cells[26,rw] := {'<left>'+}ss;//< - - - Säilyy, jos ei kaapelia

     {,,,,,,Uudet lisäykset, AL ,,===============================================================================}
         ss := s_;          if (qj_mmAl >0) and (qj_xAl >0)  then begin
                                                //1xSUL,Katk,....,.....,......,mm2..,kpl...),,,,,,,,
                               ar := YvSuoj (suCsm,TRUE,TRUE,astM,korjM,'AMCMK',qj_mmAl,qj_xAl);
                               ss := strRd (1, ar, 1,2);                                        //<Iterm

                               if det  then begin //<,,SA :=... =Detaljilomakkeelle tulostusta,,,,,,,,,,,,,,,,
                                  if qj_sul>0  then begin
                                     sa := 'AMCMK ';
                                     i := 0;   if qj_mmAl<3  then i := 1;
                                     sa := sa +fRmrkt0(qj_mmAl,1,i);
                                        ar := Isal ('AMCMK',qj_mmAl,astM);
                                     sa := sa +' sallii SUL   :lle  Isal '+fRmrkt0(ar,1,1);
                                        rr := korjM;                 sa := sa +' * Kas ' +fRmrkt0(rr,1,3);
                                           ar := ar * rr;
                                        rr := fKsul (suCsm,qj_sul);  sa := sa +' * Ksu ' +fRmrkt0(rr,1,3);
                                           ar := ar * rr;
                                        rr := fKrin (astM,qj_xAl);   sa := sa +' * Krin '+fRmrkt0(rr,1,3);
                                           ar := ar * rr;
                                     sa := sa +' = '+fRmrkt0(ar,1,1);
                                     if qj_xAl >1  then sa := sa +' *'+fImrkt0(qj_xAl,1) +' = '+
                                                             fRmrkt0(ar*qj_xAl, 1,1);
                                     sa := sa +'A.';
{ad}                                 ad1SF (sa);
                                  end;
                                  sa := 'AMCMK ';
                                     i := 0;   if qj_mmAl<3  then i := 1;
                                  sa := sa +fRmrkt0(qj_mmAl,1,i);
                                     ar := Isal ('AMCMK',qj_mmAl,astM);
                                  sa := sa +' sallii KATK :lle  Isal '+fRmrkt0(ar,1,1);
                                  rr := korjM;                  sa := sa +' * Kas ' +fRmrkt0(rr,1,3);
                                     ar := ar * rr;
                                  rr := fKrin (astM,qj_xAl);    sa := sa +' * Krin '+fRmrkt0(rr,1,3);
                                     ar := ar * rr;
                                  sa := sa +' = '+fRmrkt0(ar,1,1);
                                  if qj_xAl >1  then sa := sa +' *'+fImrkt0(qj_xAl,1) +' = '+
                                                          fRmrkt0(ar*qj_xAl, 1,1);
                                  sa := sa +'A.';
{ad}                              ad1SF (sa);
                               end;//if det
                            end;
      StrGr.Cells[27,rw] := ss; //< - - - Säilyy, jos ei kaapelia

     {RJarvot (mr, suCsm, Lmin, qj_sul,                   |
                             qj_xCu,    qj_mmCu,          |> qj_xAl,    qj_mmAl,
                             qj_LmaxCu, qj_ChrCu,         |  qj_LmaxAl, qj_ChrAl,
                             qj_PmaxCu,                   |  qj_PmaxAl,
                             qj_LmaxPmaxCu,qj_ChrPmaxCu, >|  qj_LmaxPmaxAl,qj_ChrPmaxAl);}
         ss := s_;          if (qj_LmaxAl >0) and (qj_sul>0)  then begin
                               ss := strRd (1, qj_LmaxAl, 100,1);                           //<RajaL
                               ss := ss +qj_ChrAl;   end;
      StrGr.Cells[28,rw] := ss;
         ss := s_;          if qj_LmaxPmaxAl >0  then begin
                               ss := strRd (0, qj_LmaxPmaxAl, 100,1);                       //<RajaL(Pmax)
                               ss := ss +qj_ChrPmaxAl;   end;
      StrGr.Cells[29,rw] := ss;
         ss := s_;          if qj_PmaxAl >0  then
                               ss := strKw (0, qj_PmaxAl);                                  //Pmax
      StrGr.Cells[30,rw] := ss;
                            ss := fUkmoS (TRUE, qj_mmAl,qj_xAl,qj_LmaxAl);                  //<Uk
      StrGr.Cells[31,rw] := ss;

      if nytYht>0  then yhteensa; //##########################################################################
      if det  then
         Kutsu_RJarvot(DetTR); //<'+120.5:  RJarvot -kutsu siellä, kutsu myös tämän PRCn (pvRivi) alussa =yht 2x.
    end//if mr<=motja   // 'jotta em. GrdCelliTxt tulisi ekax ja vasta sen jälkeen LxSu -detaljit.
    else if BxGAuki
    then begin
       ss := '';  //ss := '´';  if eSar=7  then ss := '<center>'; //<Turhaa =UUSrv erottuu paremmin
       StrGr.Cells[eSar,fVisERow] := ss +MoFrm.BxG.Text; //<On tutkittu + sij tätä ennen = if arvoOK
    end;                            //'MoFrm tässä näkyvissä, jotta debuggeri näyttäisi Textin arvon
   {else if mr=motja
    then for i := fMOtoVisROW (motja) to morGr.ColCount -1  do //<Putsataan loput rvt varmksi <<<<<<<
     //<Pätee myös POISTOssa.  [0,rw] sai arvon EditMoFrm :ssa
              StrGr.Cells[i,rw] := '';          //<Putsataan varmuudeksi loput SAMAN RIVIN SARAKKEET}
   {else  for i := 1 to StrGr.ColCount -1  do   //<Pätee myös POISTOssa.  [0,rw] sai arvon EditMoFrm :ssa
              StrGr.Cells[i,rw] := '';          //<Putsataan varmuudeksi loput SAMAN RIVIN SARAKKEET}
// if nytYht>0  then begin
                                                //,,Vois testata ekax:  if PvBtn.Enabled  then begin.. mutta näinOK
      if MoVeja    or fUusRv_Vajaa  then MoFrm.PalautBtn.Enabled := true         //< +4.0.0
                                    else MoFrm.PalautBtn.Enabled := false;
      if (motja>1) or fUusRv_Vajaa  then MoFrm.PoistaBtn.Enabled := true         //<,+4.0.0
                                    else begin
                                         PoistaVex;
                                         MoFrm.PoistaBtn.Enabled := false;  end;
    //end;
  end;//with
end;//pvRivi;
//==================================================================================================
procedure EditMoFrm;     const fi=FONT_FII;  eta=FONT_EETTA;  cnt='<center>';  cno='<center>'; //lft='<left>';
                               {b=' '; }c='  ';  var i,j,progRaja :integer;   sa :string; //'cno =otsikon kokeiluun
      procedure lihavoiOts (color,sar :integer);      var a,e :string;   begin
                a := '';  e := '';   if color>0  then begin a := COLOR_BLUE;  e := COLOR_END;  end;
                MoFrm.StrGr.Cells[ sar,0] := a+'<b><u>'+MoFrm.StrGr.Cells[ sar,0] +'</b></u>'+e;
                MoFrm.StrGr.Cells[ sar,1] := a+'<b>'   +MoFrm.StrGr.Cells[ sar,1] +'</b>'+e;
                MoFrm.StrGr.Cells[ sar,2] := a+'<b>'   +MoFrm.StrGr.Cells[ sar,2] +'</b>'+e;  end;
begin
  alpSft := a_getReaa (30120, mo.moty.sulSft);
  alpUm :=  a_getIntg (30120, mo.moty.Umo);
  alpVrk := a_getIntg (30120, mo.moty.Vrk);    //<,,+6.0.3
  i := a_getIntg (30120, edv.YLE.JohtoOsia);
  if alpVrk>i  then begin
     alpVrk := i;
     a_putIntg (30120, i, mo.moty.Vrk);  end;  //<''+6.0.3  Editointi jälempnä.

  with MoFrm.StrGr  do begin  //,,,= Xcol,Yrow
    j := ColCount -1;         //< (-2 = Ei vikaan rivin:o-sarakkeeseen).  ,CNT ="<center>" =CNO
    for i := 0 to j   do begin   sa := cnt + fImrkt0 (i,1);     //<Ylin OTSrivi = sar.n:ot <<<<<<<<<<<<<<<<<<<<<<<
                                 if i IN [19..22, 25..28]  then sa := sa +'¹ ';  //<Loppuun lisätty " " +11.0.1
                                 if i IN [2, 14]           then            //,CNT pitää saada mekien vas.puolelle.
                                    sa := cnt +{'·}'´' +fImrkt0 (i,1);     //<TaajuusmuttajanTarkkailuSar. +11.0.1
{Erikoismerkkejä:  ø155,Ø157,×158,ƒ159,ª166,º167,¿168,®169,¬170,½171,¼172,¡173,«174,»175,©184,¢189,
                   ß225,µ230,þ231,Þ232,¯238,±241,¾243,¶244,÷246,¸247,°248,¨·250,¹251,³252,²253}
                                 Cells[i,0] := sa;   end;
    for i := 1 to RowCount -1 do Cells[0,i] :=          fImrkt0(i-2,1); //<RiviN:ot näkyviin =i-2, vrt ots.rivit
    for i := 1 to RowCount -1 do Cells[ColCount-1,i] := fImrkt0(i-2,1);

    {Rv  }Cells[0,1] := cno+'Rv ';     {In==}Cells[11,1] := Blu(cno+'In ');  {Cu-mm²}Cells[20,1] := cno+'mm² ';
          Cells[0,2] := cno+'no ';           Cells[11,2] := Blu(cno+'[A] ');         Cells[20,2] := cno+'Cu ';
    {Nap }Cells[1,1] := cno+'nap ';    {Eeta}Cells[12,1] := cno+'';          {Itrm}  Cells[21,1] := cno+'Iterm ';
          Cells[1,2] := cno+'lkm ';          Cells[12,2] := cno+eta;                 Cells[21,2] := cno+'[A] ';

    {KW  }Cells[2,1] := cno+'Pn ';     {IsIn}Cells[13,1] := cno+'Is/In ';    {LxSu}  Cells[22,1] := cno+'LxSu ';
          Cells[2,2] := cno+'[kW] ';         Cells[13,2] := '';                      Cells[22,2] := cno+'[m] ';
    {Cos }Cells[3,1] := cno+'';        {Ist }Cells[14,1] := cno+'Start ';    {LxKat} Cells[23,1] := cno+'LxMax ';
          Cells[3,2] := cno+'cos'+fi;        Cells[14,2] := cno+'[A] ';              Cells[23,2] := cno+'[m] ';

    {Tim }Cells[4,1] := cno+'Start ';  {SCos}Cells[15,1] := cno+'Start ';    {Pmax}  Cells[24,1] := cno+'Pmax ';
          Cells[4,2] := cno+'[s]';           Cells[15,2] := cno+'cos'+fi;            Cells[24,2] := cno+'[kW] ';
    {Ryh }Cells[5,1] := cno+'St. ';    {Img }Cells[16,1] := cno+'Img ';      {Uk}    Cells[25,1] := cno+'Uk ';
          Cells[5,2] := cno+'ryh. ';         Cells[16,2] := cno+'[A] ';              Cells[25,2] := cno+'[V] ';

    {Kpl }Cells[6,1] := cno+'St. ';    {SUL }Cells[17,1] := cno+'SUL ';      {Al-mm²}Cells[26,1] := cno+'mm² ';
          Cells[6,2] := cno+'kpl  ';         Cells[17,2] := cno+'[A] ';              Cells[26,2] := cno+'Al ';
    {AsT }Cells[7,1] := cnT+'As. ';    {tMax}Cells[18,1] := cno+'tMax ';     {Itrm}  Cells[27,1] := cno+'Iterm ';
          Cells[7,2] := cnT+'tap ';          Cells[18,2] := cno+'[s] ';              Cells[27,2] := cno+'[A] ';

    {Korj}Cells[8,1] := cno+'Korj. ';  {Sal }Cells[19,1] := cno+'iSal ';     {LxSu}  Cells[28,1] := cno+'LxSu ';
          Cells[8,2] := cno+'kerr. ';        Cells[19,2] := cno+'[A] ';              Cells[28,2] := cno+'[m] ';
    {gGaM}Cells[9,1] := cno+'Sul. ';                                         {LxKat} Cells[29,1] := cno+'LxMax ';
          Cells[9,2] := cno+'typ. ';                                                 Cells[29,2] := cno+'[m] ';

    {Lmo} Cells[10,1] := cno+'Rj ';                                          {Pmax}  Cells[30,1] := cno+'Pmax ';
          Cells[10,2] := cno+'[m] ';                                                 Cells[30,2] := cno+'[kW] ';
                                                                             {Uk}    Cells[31,1] := cno+'Uk ';
{Rv  }Cells[ColCount-1,1] := cno+'Rv '; {Rv }Cells[32,1] := cno+'Rv ';               Cells[31,2] := cno+'[V] ';
      Cells[ColCount-1,2] := cno+'no ';      Cells[32,2] := cno+'no ';

    lihavoiOts (1,11);  lihavoiOts (0,14);  lihavoiOts (0,16);  lihavoiOts (0,17);
    lihavoiOts (0,20);  lihavoiOts (0,21);  lihavoiOts (0,24);
    lihavoiOts (0,26);  lihavoiOts (0,27);  lihavoiOts (0,30);
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    motja := a_getIntg( 2,mo.moty.lahtoja);  //<Frmn avauksessa välttämätön, myös todettu (NJ:ssä)!!
    progRaja := 40;
    sa := '';  if det  then sa := 'Tekstitietoja valmistellaan'
                       else sa := 'Moottorilähtöjen arvoja lasketaan';
       asetaProgres (sa,1 + motja);
       if motja>=prograja  then esitaProgres ('Lähdöt (1..' +fImrkt0 (motja,1) +').  ' ,0)  //<Perään ei n:oja
                           else esitaProgres ('Lähdöt ('    +fImrkt0 (motja,1) +'):  ' ,0); //<Perään n:oja
                                                                  //,,4.0.0  Siirretty ennen PvRivi´ä !!!!!!
    for i := fMOtoAbsROW (motja+1) to MoFrm.StrGr.RowCount -1  do //<Putsataan loput rvt varmksi, esim. PALA
    for j :=                    1  to MoFrm.StrGr.ColCount -1  do //<'UTA ja POISTA saattoi jättää 'häntiä'
        MoFrm.StrGr.Cells[j,i] := '';

{Siirretty lopusta tähän 11.0.1:  Alkuedit:ssa  MoFrm.VrkCmBx.Text :ssa puuttuiVrk-arvo.}
   FrmOtsikko;
   MoFrm.EdiY1.Text :=    a_GetStrg (30320, mo.moty.Kuvaus);
// MoFrm.Bx1.Text :=      fMrkt (mo.moty.sulSft, 1,1);
// MoFrm.Bx1.Text :=      fRmrkt0 (a_GetReaa (30321,mo.moty.sulSft), 1,1);
   MoFrm.Bx1.Text :=      sRmrkt0vex (a_GetReaa (30321,mo.moty.sulSft), 1,1);
   MoFrm.UmCmBx.Text :=   fImrkt0 (fUmn, 1);
   MoFrm.VrkCmBx.Text :=  fImrkt0 (a_GetIntg (30321, mo.moty.Vrk),1);
   MoFrm.aRich.Clear;                            //<Jos ei tyhjä, Visible=FA ei auta =Varmksi ######
   MoFrm.aRich.Visible := false;
   MoFrm.Show;
   MoFrm.Update;
   MoFrm.PvBtn.Font.Style := [];
   MoFrm.PvBtn.Enabled := false;
                                       //,,Siirretty lopusta tähän  4.0.0
    j := motja;                        //<Ettei jäisi kopioituja rivejä näkyviin, TODETTU (Nj:ssä)!!
    for i := 1 to j  do begin          //'Edellä täytettiin CELLien otsakerivit = 0 .. FixecRows-1
      //if det  then begin             //,,Ei mahdu:  1+2+3...+19+..
        if motja<progRaja  then begin  //,,Ei mahdu:  1+2+3...+19+..
           if i>1  then sa := {'+'}','
                   else sa := '';
           sa := sa + fImrkt0 (i,1);
             esitaProgres (sa, i);  end //<esitaProgres kasvattaa merkkijonoa (sa):  Lähdöt: 1,2,3,4... jne.}
        else esitaProgres ('', i);      //<esitaProgres kasvattaa merkkijonoa (sa):  Lähdöt: 1,2,3,4... jne.
      //end;//if det
        if i<j  then pvRivi (0,i)      //<LÄHTÖRIVEINÄ, ei CELL-riveinä ############################
                else pvRivi (1,i);     //< >0=Lask + Päivitetään yläpanelin tiedot. Putsaa loppurivt
    end;//for
       ProgresFrm.Close;
    if det  then begin
       if NOT MoDetFrm.Visible  then MoDetFrm.Show;
       Screen.Cursor := crDefault;  end;                          //<Asetettiin OnChkDetClick :ssä crHourGlass

//,,Kokeilu arvoilla,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
(*  i := motja+4;   //<Koska otsikkorivit = 0,1,2 ja halutaan (tässä) 1 tyhjä rivi väliin <<<<<<<<<<<<<<<<<<<<
    Cells[ 0,i] := '13';          Cells[11,i] := '5.2';             Cells[22,i] := '2.67';
    Cells[ 1,i] := '12';          Cells[12,i] := '8.5';             Cells[23,i] := '0.789';
    Cells[ 2,i] := '2.2';         Cells[13,i] := '0.789';           Cells[24,i] := '0.892';
    Cells[ 3,i] := '0.68';        Cells[14,i] := '6';               Cells[25,i] := '6';
    Cells[ 4,i] := '1.2';         Cells[15,i] := '5.8';             Cells[26,i] := '5.6';
    Cells[ 5,i] := '1';           Cells[16,i] := '0.678';           Cells[27,i] := '2.67';
    Cells[ 6,i] := '1';           Cells[17,i] := '6.4';             Cells[28,i] := '0.789';
    Cells[ 7,i] := '<center>A';   Cells[18,i] := '1.5';
    Cells[ 8,i] := '0.9';         Cells[19,i] := '<left>16';
    Cells[ 9,i] := '2.26';        Cells[20,i] := '2.2';
    Cells[10,i] := '0.6';         Cells[21,i] := '0.22';
    i := motja+5;
    Cells[ 0,i] := '14';          Cells[11,i] := '4.5';             Cells[22,i] := '9999';
    Cells[ 1,i] := '12';          Cells[12,i] := '99999';           Cells[23,i] := '0.789';
    Cells[ 2,i] := '1500';        Cells[13,i] := '0.678';           Cells[24,i] := '0.781';
    Cells[ 3,i] := '0.678';       Cells[14,i] := '1500';            Cells[25,i] := '1500';
    Cells[ 4,i] := '120';         Cells[15,i] := '3200';            Cells[26,i] := '888.8';
    Cells[ 5,i] := '1';           Cells[16,i] := '0.746';           Cells[27,i] := '99999';
    Cells[ 6,i] := '222';         Cells[17,i] := '3600';            Cells[28,i] := '0.678';
    Cells[ 7,i] := '<center>C';   Cells[18,i] := '20x185cu';
    Cells[ 8,i] := '0.899';       Cells[19,i] := '<left>20x300al';
    Cells[ 9,i] := '99999';       Cells[20,i] := '2000';
    Cells[10,i] := '0.567';       Cells[21,i] := '1500';//----------------------------------------*)
   end;//with MoFrm
{11.0.1:  Tästä siirretty:  FrmOtsikko; ... MoFrm.PvBtn.Enabled := false;    j := motja; :n edelle (ennen pvRivi kutsusilmukkaa)
   FrmOtsikko;
   MoFrm.EdiY1.Text :=    a_GetStrg (30320, mo.moty.Kuvaus);
// MoFrm.Bx1.Text :=      fMrkt (mo.moty.sulSft, 1,1);
// MoFrm.Bx1.Text :=      fRmrkt0 (a_GetReaa (30321,mo.moty.sulSft), 1,1);
   MoFrm.Bx1.Text :=      sRmrkt0vex (a_GetReaa (30321,mo.moty.sulSft), 1,1);
   MoFrm.UmCmBx.Text :=   fImrkt0 (fUmn, 1);
   MoFrm.VrkCmBx.Text :=  fImrkt0 (a_GetIntg (30321, mo.moty.Vrk),1);
   MoFrm.aRich.Clear;                            //<Jos ei tyhjä, Visible=FA ei auta =Varmksi ######
   MoFrm.aRich.Visible := false;
   MoFrm.Show;
   MoFrm.Update;
   MoFrm.PvBtn.Font.Style := [];
   MoFrm.PvBtn.Enabled := false;//}

{  MoFrm.EdiY1.Text := '';
   for i := 80 to 250  do begin MoFrm.EdiY1.Text := MoFrm.EdiY1.Text +chr(i);
            if i mod 10=0  then MoFrm.EdiY1.Text := MoFrm.EdiY1.Text +'='+fImrkt0(i,1)+' ';  end;}

                                          {MoFrm.StrGr.Cells[27,5] := 'eriMo='  +fBmrkt0 (eriMo ,2); //<,,+4.0.0
                                           MoFrm.StrGr.Cells[28,5] := 'eriMo0=' +fBmrkt0 (eriMo0,2);
                                           MoFrm.StrGr.Cells[29,5] := 'eriMoU=' +fBmrkt0 (eriMoU,2);}
                                                     {i := 0;  if eriMo   then i := 1; //< Mo <> MoF
                                if i=10  then beep;   i := 0;  if eriMo0  then i := 1; //< Mo <> Mo0
                                if i=10  then beep;   i := 0;  if eriMoU  then i := 1; //< Mo <> MoU
                                if i=10  then beep;}
   if det  then
      MoDetFrm.SetFocus;        //< +4.0.0
end;//EditMoFrm;
//==================================================================================================
function fOKrivit :boolean;      var i,j :integer;  onOK :boolean;      begin
  onOK := true;       //with NjFrm.StrGr  DO Y_Koe (0,Cells[1,1]+'   '+Cells[1,2]+'   '+Cells[1,3]);
                      //if NjFrm.StrGr.Cells[1,3]=''  then Y_piipit (50);
  if motja=0
  then begin onOK := false;
             HerjaInfo ('Moottoritiedot puuttuvat, korjaa.');  end
  else with MoFrm  do begin
  //i := fMOtoVisROW (1) -1;
    i := fMOtoAbsROW (1) -1;
    j := fAbsROWtoMRV (StrGr.RowCount-1);
    if momax<j  then j := momax;
    repeat i := i+1;
           with StrGr  do  if ((Cells[1,i]<>'') or (Cells[2,i]<>''))  and  (Cells[vCol,i]='')
                           then onOK := false;
    until  NOT onOK  or (i=j);// or ((StrGr.Cells[1,i]='') and (StrGr.Cells[2,i]=''));

    if NOT onOK  then HerjaInfo ('Rivi '+fImrkt0 (fAbsROWtoMRV (i),1)+':   Tiedot puuttellisia, korjaa.')
  end;
  result := onOK;
end;//fOKrivit
//==================================================================================================
function fAbsCo (MOsar :integer) :integer;      begin  Result := fMOtoAbsCOL (MOsar);   end;
function fAbsRw (MOriv :integer) :integer;      begin  Result := fMOtoAbsROW (MOriv);   end;
                                                                      //,,Sar,Mrv p.o.OK ja Cell<>''
function OkStr (MOsar,MOriv :integer) :boolean;      VAR cSar,cRiv :integer;      begin
   Result := false;   cSar := fAbsCo (MOsar);   cRiv := fAbsRw (MOriv);
   with MoFrm.StrGr  do        //,Varmksi tarkistetaan lukualue. Sallitaan luku VIKALTA OTSrv/sar:sta =Fixd.-1
   if (cSar IN [FixedCols-1..ColCount-1]) and (cRiv IN [FixedRows-1..RowCount-1]) and
      (MoFrm.StrGr.Cells[cSar,cRiv]<>'')
      then Result := true;   end;

//==================================================================================================
       //Tarkistaa näpäytyskohdan + tarvittaessa myös arvoOK :n + kutsuu PvRIVI ####################
       //   ChkCelNo>0 = Tarkistetaan Mouse- t. KeyEnterClick´in (seur.)paikka =Onko SAR,RIV luvallinen kohta.####
       //   ChkCelNo=0 = Tarkistetaan VAIN BxG :n ARVO (text) JA VAIN, JOS BXGAUKI.###############################
function fEhkaTarkArvo (ChkCelNo :integer) :boolean;      VAR abo,boo, CHKos,napOK,UusSar,UusRvEnd, OnJoPiip :boolean;

                  //Sr,Rv = Sar,Mrv ,,,,,,,,,,,,,,,,,,,,,,,,,, Vois olla globaali, nyt vain tässä ,,,,,,,,,,,,,,,,
   function fNapOK (Sr,Rv :integer) :boolean;                                                          //< +4.0.0
         VAR cSr,cRv :integer;  boo,boE,boU,boV :boolean;      begin

      cSr := fAbsCo (Sr);   cRv := fAbsRw (Rv);
      boE := false;   boU := false;   boV := false;
                                                                       //,===Click t.Enter vanhalle rvlle 1..vCol =OK.
      if (Sr IN [1..vCol]) and (Rv IN [1..momax])  then begin            //<,Estettävä AINAKIN, ettei cSr-1,cRv-1 < 0
         boE := (MoFrm.StrGr.Cells[cSr,cRv]<>'')   and (Rv IN [1..motja]);

         boU := (Rv IN [1..motja+1])  and                              //<=== Click/Enter uudelle riville.###########
                  (cSr-1>=0) and (MoFrm.StrGr.Cells[cSr-1,cRv]<>'')  OR           //<Vanhasta arvosta seur.oik.
                  BxGAuki    and (BxSar=Sr-1) and (BxMrv=Rv);                     //<,Vanhasta +2 ja heti vanhan jälk.
                                                                                  //  seur (=+1) BxGAuki.!!!!!!!!!!!!
         boV := ( (Sr=1)  AND                                          //<=== Click/Enter uudelle rville Sar=1 :een.
                  ((Rv=motja+1) and (MoFrm.StrGr.Cells[vCol,cRv-1]<>'')  or     //,EdRvllä vCol :ssa AINAoltavaArvo t.
                   (Rv=motja+2) and  BxGAuki  and (MoFrm.BxG.Text<>'') and      //<BxG on auki uuden rivin lopussa ja
                   (BxSar=vCol)  and (BxMrv=Rv-1)) );                           //<< BxG :ssä on arvo.!!!!!!!!!!!!!!!
      end;
      boo := boE  or  boU  or  boV;
      Result := boo;   end;

   function OkClickKarkea (MOsar,MOriv :integer) :boolean;     begin  Result := false;  with MoFrm.StrGr  do
      if (fAbsCo (MOsar) IN [FixedCols..ColCount-1]) and (MOsar IN [1..vCol])   and
         (fAbsRw (MOriv) IN [FixedRows..RowCount-1]) and (MOriv IN [1..momax])  then Result := true;   end;

   function BxGaukiAllaTyhjaCell :boolean;      VAR cSr,cRv :integer;      begin
      result := false;   cSr := fAbsCo (BxSar);   cRv := fAbsRw (BxMrv);
      if BxGAuki  and (MoFrm.StrGr.Cells[cSr,cRv]='')
         then result := true;  end;

begin//fEhkaTarkArvo..................................................Muokattu 4.0.0
  napOK :=    false;               //<Näpäytys OK-alueella = OKCelliin
  UusSar :=   false;               //<UUSIsarake (uudella rivillä), jo käyty TAI ei.   TR VAIN, jos <= KäytySar+1.
  UusRvEnd := false;               //<UUSIriviValmis.
  if ChkCelNo>0  then CHKos := true   //< =Tarkistetaan Mouse- t. KeyEnterClick´in paikka =Onko luvallinen kohta.
                 else CHKos := false;
                        //   #####################################################################################
with MoFrm  do begin    //<,,######### HUOM: Jos BxG.Visible=TRUE, on sen paikka OK, eikä tartte testata.#########
                        //   ################### BxG.VISIBLEn ILMAISEE BxGAuki (asetettu tätä varten),############
                        //   ################### KOSKA jos TopLeftChanged => BxG.Visible := FALSE.    ############
                        //   #####################################################################################
  if Defs_KoeAjo  then
     SyottoAvFrm.Hide;  //<VAIN KOKEILUSSA = PIILOTTAA AVUSTEIKKUNAN, ettei peitä sorsaa BrekPoint -katselussa

  if NOT CHKos                              //<,, +4.0.0
  then napOK := true                        //<NapOK := myös jäljempnä (x1) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  else begin
     abo := OkClickKarkea (Sar,Mrv);        //<1..momax =karkea raja, tarkentuu seur.
     boo := fNapOK (Sar,Mrv);
     if abo  then
        napOK := boo;                       //<NapOK := myös jäljempnä (x1) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  end;
                                            //,,,,,,,,,,,,Oltiin UUDEN RVn viimCellissä;;;;;;;;;;;;;;;;;;;;;;;;;;;
  if (eSar=vCol)  and (eMrv=motja+1)  and                      //<eMrv=BxG VIELÄ AUKI [eSar,eMrv] :ssa ###########
     BxGAuki      and (MoFrm.BxG.Text<>'')                     //<BxGAuki, koska Visible := FA jos TopLeftChanged
     then UusRvEnd := true;
                                            //,,,,,,,,,,,,UudnRivn seurTaiVanhaSarakeVaikkVälilMuualla;;;;;;;;;;;;
  if (Sar IN [1..vCol])  AND (Mrv IN [1..momax])  AND          //<Oltava aina ainakin OKsarak+OKriveissä
     (StrGr.Cells[vCol,fVisRow-1]<>'')  AND                    //<EdRvn vCol:ssa oltava OKarvo, OK vaikka = OTSriv
      ( BxGAuki and (BxG.text<>'') and                         //<BxGAuki, koska Visible := FA jos TopLeftChanged
        (eSar=Sar-1) and (eMrv=Mrv)     OR                     //<'Vas.puolella oltava BxG AUKI+arvo tai,,
        NOT BxGAuki  and OkStr (Sar-1,Mrv) and (Mrv=motja+1) ) //<Vas.puolella oltava BxG KIINNI JA str.
     then begin UusSar := true;   napOK := true;  end;         //<NapOK mahd. saanut arvon myös alussa

  OnJoPiip := false;
  abo := true;       //,KeyDwn rivn päässä/alussa aiheutti TopRow/LeftCol-aset. =>TopLeftChange =>BxG.Visible :=FA
  if BxGAuki  then begin                                       // MINKÄ TAKIA BxGAuki käytetty (BxG.Visible ei käy)
     abo := arvoOK (eSar,8);                            //<###### arvoOK sijoitti BxG => motr[]. 6=>8=+8.0.2 #####
     OnJoPiip := true;                                         //<'ErPiip tuli jo arvoOK´ssa jos eiOK       +4.0.0
     if abo  then begin                                        //'################################################
        SijMouIfVE1;                                           //<Prc 4.0.0
        if moVeja or fUusRv_Vajaa                       //<############## moVeja testaa joka #####################
           then MoFrm.PalautBtn.Enabled := true         //'############## kerta myös mo0:n #######################
           else MoFrm.PalautBtn.Enabled := false;  end; end;

  if (UusRvEnd or UusSar)  and abo                             //<Ei sijoituksiin ellei arvoOK #####
  then begin
     if UusRvEnd  then begin               //<,Vasta kun rivi valmis. Pitäisköhän ekax tsekata ArvoOK ????????????
        if eMrv>motja  then motja := eMrv;
        a_PutIntg (2, motja, mo.moty.lahtoja);
        SijMouIfVE1;                                           //<Prc 4.0.0
     end;
     MoFrm.PalautBtn.Enabled := true;
  end;//if Uus.. & abo

  if NOT OnJoPiip  and
    (NOT abo  OR  ( NOT napOK{+4.0.0}  and BxGAuki  and (Sar IN [StrGr.FixedCols..vCol]) ))
    then erPiip;//Y_Piipit (200);

  if abo  then begin                     //<,,###################### Muutos 4.0.0 ################################
     if eMrv>0  then pvRivi (1,eMrv);    //<<<###################### Päivitetään RIVI ############################
     BxGAukiVisOff;  end                 //<<<##### BxGauki+Visible := FA Vex vain jos SeurClick/KeyDown #########
  else if BxGaukiAllaTyhjaCell           //'  ##### OK. EI ENNEN, koska BxGAuki´a testataan ######################
  then BxGAukiVisOff                     //<Suljetaan vain jos ALLA TYHJÄ Celli t. ARVO OK (ks.ed. BxGAukiVisOff)
  else begin                             //'######################################################################
     if BxGAuki  then                    //'######################################################################
        MoFrm.BxG.Visible := true;
     if MoFrm.BxG.Visible  then          //<if.. ehto, etteiError: Can´t focus invisib..''
        MoFrm.BxG.SetFocus;  end;        //<Aiheuttaa OnBxGEnter´in -> SijBxG ####################################
                                         //'######################################################################
  if NOT napOK  then abo := false;       //<Oli jo ehkä arvoOK :sta := FA.
  result := abo;     //<################## RESULT //'#############################################################
end;//with           //'## = TRUE, jos Click OK-celliin JA ao. syöttökohdan ARVO=OK (joka silloin sijoitettiin) ##
end;//fEhkaTarkArvo; //'##########################################################################################
{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Moot.INC}

