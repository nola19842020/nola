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

{############################################################### EdvNjAs.INC}
{  Alkuosa poimittu: NolaJ.PAS, Nola4.INC joista otettu soveltuvat osat
   kokeilukäyttöön DELPHIin. KUTSUJÄRJESTYS JA KATTAVUUS EI VASTAA ALKU-
   PERÄISIÄ. ===== TARKISTETTAVA KÄYTTÖVERSIOON ============================
  - INCLUUDATTU PaaVal.PAS :ssa,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}

//nction EdvEro (ve :integer) :boolean;      var eja,i :integer;   ev :EdvYHTtype;   eib :boolean;
function EdvEro (edvA,edvB :EdvYHTtype) :boolean;     var eja,sja,i,k :integer;  {eib}{1414:}eri :boolean;  s :string;

  procedure koe(o :integer);      begin s := s+'i'+fImrkt0 (i,1)+'  no'+fImrkt0 (o,1)+'  edvF,edv0/edv='
                                        {'  eri='+fBmrkt0 (eib,2)};  {Beep; }end;

  function sama (n :integer;  alp,uus :arvoTyyp) :boolean;

    procedure onEri;      begin
       sama := false;
       {eib}eri := true;   koe (n);  end;

  begin sama := true;
   {if alp.arvTyp  <>uus.arvoTyp   then eri  else}
    if alp.OnArvo  <>uus.OnArvo    then onEri  else
    case alp.arvoTyp of                                    //,,,,,Koe :tta varten,,,,,,,,,,,,,,,,,,,,,,,,
      Intg :if alp.arvoInt<>uus.arvoInt    then begin  onEri;  s := s+fImrkt0(alp.arvoInt,1)+  '/'+
                                                                    fImrkt0(uus.arvoInt,1);    end;
      Reaa :if alp.arvoRea<>uus.arvoRea    then begin  onEri;  s := s+fRmrkt0(alp.arvoRea,1,7)+'/'+
                                                                    fRmrkt0(uus.arvoRea,1,7);  end;
      Bool :if alp.arvoBoo<>uus.arvoBoo    then begin  onEri;  s := s+fBmrkt0(alp.arvoBoo,0)+  '/'+
                                                                    fBmrkt0(uus.arvoBoo,0);    end;
      Strg :if alp.arvoStr<>uus.arvoStr    then begin  onEri;  s := s+alp.arvoStr+'/'+
                                                                    uus.arvoStr;   end;
    end;//case
  end;//sama
begin//EdvEro
{ case ve of  1 :ev := edvf;       //<,Näitä verrataan edv :hen ####################################
              0 :ev := edv0;  end;}
  eri := false;   s := '';         //<s := ''  Koe :n takia
  eja := a_getIntg( 102,edvA.YLE.JohtoOsia);    i := a_getIntg( 103,edvB.YLE.JohtoOsia);
  sja := a_getIntg( 102,edvA.YLE.SorceCount);   k := a_getIntg( 103,edvB.YLE.SorceCount); //<+6.2.2
  if (eja<>i) or (sja<>k)
  then eri := true
  else begin
    with edvA.YLE do //<Oli ev = 1=edvf 0=edv0  ,,,,,,,Nämä aina EDV,,,,,,,,,,,,,. Nyt KUTSUN edvB,,
       if sama( 1, JohtoOsia ,edvB.YLE.JohtoOsia)   then if sama( 2, Kuvaus,    edvB.YLE.Kuvaus)     then
       if sama( 3, Un,        edvB.YLE.Un)          then if sama( 4, VaiheLkm,  edvB.YLE.VaiheLkm)   then
       if sama( 5, cU,        edvB.YLE.cU)          then if sama( 6, PEN_PE,    edvB.YLE.PEN_PE)     then
       if sama( 7, IecOfa,    edvB.YLE.IecOfa)      then if sama( 8, PoisAika,  edvB.YLE.PoisAika)   then
       if sama( 9, PRaika,    edvB.YLE.PRaika)      then //< +8.0.0
       if sama(10, AsTapa,    edvB.YLE.AsTapa)      then //< +8.0.11
       if sama(11, ZpeBx,     edvB.YLE.ZpeBx)       then //< +9.0.1
    for i := 1 to sja  do
    with edvA.Sorc[i].src do begin
       if sama( 1, SorceKind, edvB.Sorc[i].src.SorceKind) then//f sama( 2, SjPj,     edvB.Sorc[i].src.SjPj)     then -6.2.2
       if sama( 3, Smn,       edvB.Sorc[i].src.Smn)       then if sama( 4, TrfTyp,   edvB.Sorc[i].src.TrfTyp)   then
       if sama( 5, Iks1v,     edvB.Sorc[i].src.Iks1v)     then if sama( 6, Iks3v,    edvB.Sorc[i].src.Iks3v)    then
       if sama( 7, yvRs,      edvB.Sorc[i].src.yvRs)      then if sama( 8, yvXs,     edvB.Sorc[i].src.yvXs)     then
       if sama( 9, pjLiitRs,  edvB.Sorc[i].src.pjLiitRs)  then if sama(10, pjLiitXs, edvB.Sorc[i].src.pjLiitXs) then
       if sama(11, gSn,       edvB.Sorc[i].src.gSn)       then if sama(12, gXd,      edvB.Sorc[i].src.gXd)      then
       if sama(13, gXd1,      edvB.Sorc[i].src.gXd1)      then if sama(14, gXd2,     edvB.Sorc[i].src.gXd2)     then
     //if sama(15, gX0,       edvB.Sorc[i].src.gX0)       then    sama(16, gX2,      edvB.Sorc[i].src.gX2); ,,+8.0.8
       if sama(15, gRs,       edvB.Sorc[i].src.gRs)       then if sama(16, gTd1,     edvB.Sorc[i].src.gTd1)     then
       if sama(17, gTd2,      edvB.Sorc[i].src.gTd2)      then if sama(18, gtIkMin,  edvB.Sorc[i].src.gtIkMin)  then
       if sama(18, gtIkSust,  edvB.Sorc[i].src.gtIkSust)  then if sama(19, gIkSust,  edvB.Sorc[i].src.gIkSust)  then
       if sama(20, gK1vSust,  edvB.Sorc[i].src.gK1vSust)    then                                         //<''-8.0.8
       if eri  then Break;  end;
    if NOT eri  then
    for i := 1 to sja  do           //<,,+6.2.20
    with edvA.Sorc[i].josa do begin
       if OnArvot<>edvB.Sorc[i].josa.OnArvot  then eri := true  else
       if sama(40,Nimi,     edvB.Sorc[i].josa.Nimi)       then if sama(41,Amm2,      edvB.Sorc[i].josa.Amm2)      then
       if sama(42,kuluttaja,edvB.Sorc[i].josa.kuluttaja)  then if sama(43,lukumaara, edvB.Sorc[i].josa.lukumaara) then
       if sama(44,PTlopussa,edvB.Sorc[i].josa.PTlopussa)  then if sama(45,pituus,    edvB.Sorc[i].josa.pituus)    then
       if sama(46,tyyppi,   edvB.Sorc[i].josa.tyyppi)     then if sama(47,korjaus,   edvB.Sorc[i].josa.korjaus)   then
       if sama(48,lampotila,edvB.Sorc[i].josa.lampotila)  then if sama(49,OfaVal,    edvB.Sorc[i].josa.OfaVal)    then
       if sama(50,Ph,       edvB.Sorc[i].josa.Ph)         then if sama(51,Ph,        edvB.Sorc[i].josa.Ph)        then
       if sama(52,Cosp,     edvB.Sorc[i].josa.Cosp)       then if sama(53,JkUps,     edvB.Sorc[i].josa.JkUps)     then//+120.5n/6
      {,,Uho,Uhp,Uhv,Tuh VAIN laskettavia arvoja, ei talletettuavia.                                       -9.0.1
       if sama(53,Uho,       edvB.Sorc[i].josa.Uho)       then
       if sama(54,Uhp,      edvB.Sorc[i].josa.Uhp)        then    sama(55,Tuh,       edvB.Sorc[i].josa.Tuh);}
       if eri  then Break;  end;
   {with edvA.NjL do                              {,,,...Ze,Zs on kyllä talletettu, muttaAinaLasketaan}
     (*if sama(21,yhtUhRaja,edvB.NjL.yhtUhRaja)  then{if sama(22,yhtCosZe, edvB.NjL.yhtCosZe)   then}  <,-4.0.0
       if sama(23,edUhOsa,  edvB.NjL.edUhOsa)    then{if sama(24,yhtZs,    edvB.NjL.yhtZs)      then}
       if sama(25,NjUhRaja, edvB.NjL.NjUhRaja)   then{if sama(26,yhtRs,    edvB.NjL.yhtRs)      then}---*)
      {if sama(27,yhtZe,    edvB.NjL.yhtZe)      then if sama(28,yhtXs,    edvB.NjL.yhtXs)      then}
      {if sama(29,yhtRe,    edvB.NjL.yhtRe)      then if sama(30,yhtCosZs, edvB.NjL.yhtCosZs)   then}
      {if sama(31,yhtXe,    edvB.NjL.yhtXe)      then}{if sama(32,onPTlop,  edvB.NjL.onPTlop)    then -4.0.0}
    if NOT eri  then
    for i := 1 to eja  do
    with edvA.edka[i]   do begin
       if OnArvot<>edvB.edka[i].OnArvot  then eri := true  else
       if sama(40,Nimi,     edvB.edka[i].Nimi)       then if sama(41,Amm2,      edvB.edka[i].Amm2)      then
       if sama(42,kuluttaja,edvB.edka[i].kuluttaja)  then if sama(43,lukumaara, edvB.edka[i].lukumaara) then
       if sama(44,PTlopussa,edvB.edka[i].PTlopussa)  then if sama(45,pituus,    edvB.edka[i].pituus)    then
       if sama(46,tyyppi,   edvB.edka[i].tyyppi)     then if sama(47,korjaus,   edvB.edka[i].korjaus)   then
       if sama(48,lampotila,edvB.edka[i].lampotila)  then if sama(49,OfaVal,    edvB.edka[i].OfaVal)    then
       if sama(50,Ph,       edvB.edka[i].Ph)         then if sama(51,Ph,        edvB.edka[i].Ph)        then
       if sama(52,Cosp,     edvB.edka[i].Cosp)       then if sama(53,JkUps,     edvB.edka[i].JkUps)     then//+120.5n/6
      {,,Uho,Uhp,Uhv,Tuh VAIN laskettavia arvoja, ei talletettuavia.                                       -9.0.1
       if sama(53,Uho,       edvB.edka[i].Uho)       then
       if sama(54,Uhp,      edvB.edka[i].Uhp)        then    sama(55,Tuh,       edvB.edka[i].Tuh);         -9.0.1}
       if eri  then Break;  end;
  end;//else
  Result := eri;
//s := 'Param='+fImrkt0 (ve,1)+':  '+s;     //<Vain koekäyttöön
//if eri  then Y_Koe(2,s)  else Y_koe(0,s);
end;//EdvEro
{--------------------------------------------------------------------------------------------------}
function EdvVeja :boolean;      begin
  Result := false;   if EdvEro(edvf,edv) or EdvEro(edv0,edv)  then Result := true;
  {Y_koe(2,'EdvEro(edvf)='+fBMrkt0(EdvEro(1),2)+'  EdvEro(edv0)='+fBMrkt0(EdvEro(0),2));  }end;
function eriEdvf :boolean;      begin
  Result := false;   if EdvEro(edvf,edv)  then Result := true;  end;
function eriEdv :boolean;      begin //<,OK, mutta EI ENÄÄ käytössä ####################################
//Result := false;   if EdvEro(edvf,edv)  then Result := true;  end;
  Result := false;   if EdvEro(edvE,edv)  then Result := true;  end;
{function uusEdv (edvU :EdvYHTtype) :boolean;      begin              //<Ei vielä käytetty
  Result := false;    if EdvEro(edvU,edv)  then Result := true;  end;}
{function eri_cU_Un :boolean;      begin                               -6.2.2
//Result := false;   if EdvEro(edvf,edv)  then Result := true;  end;
  Result := false;
  if NOT a_getBool (105,edvE.YLE.SjPj) and
     (a_getReaa (106,edvE.YLE.cU) * a_getIntg (107,edvE.YLE.Un) <>
      a_getReaa (108,edv.YLE.cU)  * a_getIntg (109,edv.YLE.Un) )  then Result := true;   end;}
function eri_cU_Un :boolean;      VAR boo :boolean;  i :integer;      begin
  boo := false;
  for i := 1 to a_getIntg (104,edv.YLE.SorceCount)  do          //<,,+6.2.2   SorceKind=1 = Muuntaja
//if NOT a_getBool (105,edvE.YLE.SjPj) and
  if (a_getIntg (105,edvE.Sorc[i].src.SorceKind) <> a_getIntg (105,edv.Sorc[i].src.SorceKind))  and
     (a_getReaa (106,edvE.YLE.cU) * a_getIntg (107,edvE.YLE.Un) <>
      a_getReaa (108,edv. YLE.cU) * a_getIntg (109,edv. YLE.Un) )  then begin
      boo := true;  break;  end;
  Result := boo;
end;
{==================================================================================================}
function NjEro (ve :integer) :boolean;      var nja,i :integer;   aj :jkYHTtype;   eib :boolean;
  procedure koe(o :integer);      begin {Y_Koe(2,'no'+fImrkt0 (o,1)+'  i'+fImrkt0 (i,1)+
                                        '  eri='+fBmrkt0 (eib,2));  }{Beep; }end;
  function sama (o :integer;  alp,uus :arvoTyyp) :boolean;
    procedure eri;      begin sama := false;  eib := true;  end;
  begin sama := true;
   {if alp.arvTyp  <>uus.arvoTyp   then eri  else}
    if alp.OnArvo  <>uus.OnArvo    then eri  else
    case alp.arvoTyp of
      Intg :if alp.arvoInt<>uus.arvoInt    then eri;
      Reaa :if alp.arvoRea<>uus.arvoRea    then eri;
      Bool :if alp.arvoBoo<>uus.arvoBoo    then eri;
      Strg :if alp.arvoStr<>uus.arvoStr    then eri;  end;//case
  end;//sama
begin//NjEro
  case ve of  1 :aj := njf;        //<,Aina verrataan nj :hin ######################################
              0 :aj := nj0;
            else aj := nju;  end;  //< +4.0.0
  eib := false;
  nja := a_getIntg( 110,aj.jy.ketjussa);   i := a_getIntg( 111,nj.jy.ketjussa);
  if nja<>i
  then eib := true
  else begin
    with aj.Hav do
         if sama(1, Tpit,  nj.Hav.Tpit)   or  sama(2, Korko,  nj.Hav.Korko)    or
            sama(3, Hprs,  nj.Hav.Hprs)   or  sama(4, Tph,    nj.Hav.Tph)      or
            sama(5, YOprs, nj.Hav.YOprs)  or  sama(6, Ktyh,   nj.Hav.Ktyh)     or
            sama(7, dPprs, nj.Hav.dPprs)  or  sama(8, dWmkprs,nj.Hav.dWmkprs)  or
            sama(9, PVpen, nj.Hav.PVpen)  or  sama(10,YOpen,  nj.Hav.YOpen)    or
            sama(11,Pmk,   nj.Hav.Pmk)    then
    with aj.jy do
         if sama(21,ketjussa, nj.jy.ketjussa)  then if sama(22,NjKulSal, nj.jy.NjKulSal)  then
         if sama(23,Tk1v,     nj.jy.Tk1v)      then if sama(24,UhRaja,   nj.jy.UhRaja)    then
         if sama(25,tasaus,   nj.jy.tasaus)    then if sama(26,astapa,   nj.jy.astapa)    then
         if sama(27,korjaus,  nj.jy.korjaus)   then if sama(28,kasvuv,   nj.jy.kasvuv)    then
    for i := 1 to nja  do begin            //<Tähän ei tulla ollenkaan jos lukumäärät ovat erilaisia
    with aj.jk[i] do                       //,Ehkä: if onarvot  then..
         if sama(30,tunnus, nj.jk[i].tunnus)   then if sama(31,palV,  nj.jk[i].palV)   then
         if sama(32,huom,   nj.jk[i].huom)     then if sama(33,cosV,  nj.jk[i].cosV)   then
         if sama(34,dL,     nj.jk[i].dL)       then if sama(35,Ps,    nj.jk[i].Ps)     then
         if sama(36,ala,    nj.jk[i].ala)      then if sama(37,PTlop, nj.jk[i].PTlop)  //< +4.0.0  PTlop
                                               then    sama(38,coss,  nj.jk[i].coss);
    if eib  then Break;  end;
  end;//else
  Result := eib;
end;//NjEro
{--------------------------------------------------------------------------------------------------}
function NjVeja :boolean;      begin
  result := false;   if NjEro(1) or NjEro(0) or NjEro(2)  then result := true;  end; //<+4.0.0  +(2)
function eriNj :boolean;      begin
  result := false;    if NjEro(1)  then result := true;  end;
function eriNj0 :boolean;      begin //< TR jos Nj0<>Nj
  result := NjEro(0);  end;
function eriNjU :boolean;      begin //< TR jos NjU<>Nj
  result := NjEro(2);  end;
{==================================================================================================}
              //,,Aina verrataan Mo -tietueeseen:    ve=1:  MoF vs. Mo     ve=0:  Mo0 vs. Mo  ve>1: MoU vs. Mo
function MoEro (ve :integer) :boolean;      var mja,i :integer;   aj :moYHTtype;   eib :boolean;
                                                //'Pal TRUE, jos on EROJA ##########################
  function sama (o :integer;  alp,uus :arvoTyyp) :boolean;
     procedure eri;      begin
        sama := false;   eib := true;  end;
  begin sama := true;
    if alp.OnArvo  <>uus.OnArvo    then eri  else
    case alp.arvoTyp of
      Intg :if alp.arvoInt<>uus.arvoInt    then eri;
      Reaa :if alp.arvoRea<>uus.arvoRea    then eri;
      Bool :if alp.arvoBoo<>uus.arvoBoo    then eri;
      Strg :if alp.arvoStr<>uus.arvoStr    then eri;  end;//case
  end;//sama
begin//MoEro
  case ve of  1 :aj := mof;        //<,Aina verrataan mo :hin ######################################
              0 :aj := mo0;
            else aj := mou;  end;  //< +4.0.0
  eib := false;
  
  mja := a_getIntg (112, aj.moty.lahtoja);   i := a_getIntg (113, mo.moty.lahtoja);
  if (mja<>i) and (mja>0) and (i>0)          //< +4.0.0 Lisäehdot ''oli mo  +4.0.0 !!!!!!!!!!!!!!!!!
  then eib := true
  else begin
    with aj.moty do
         if sama (1,kuvaus, mo.moty.kuvaus)  and  sama (2,sulSft,   mo.moty.sulSft)  and
            sama (1,Umo   , mo.moty.Umo   )  and  sama (1,Vrk   ,   mo.moty.Vrk   )  THEN
    for i := 1 to mja  do begin             //'Ei sittenkään tarpeen +6.0.3, +120.5k: Sittenkin tarpeen.
    with aj.motr[i] do
         if sama(10,nap,    mo.motr[i].nap)  and  sama(11,kw,   mo.motr[i].kw)    and
            sama(12,cos,    mo.motr[i].cos)  and  sama(13,tim,  mo.motr[i].tim)   and
            sama(14,rno,    mo.motr[i].rno)  and  sama(15,kpl,  mo.motr[i].kpl)   and
            sama(16,asT,    mo.motr[i].asT)  and  sama(17,korj, mo.motr[i].korj)  and
            sama(18,suT,    mo.motr[i].suT)  and  sama(19,Lmo,  mo.motr[i].Lmo)
         then begin end  else Break;  end;//for
  end;//else
  Result := eib;
end;//MoEro
{--------------------------------------------------------------------------------------------------}
function MoVeja :boolean;      begin
  result := false;   if MoEro(1) or MoEro(0) or MoEro(2)  then result := true;  end; //<+4.0.0  +(2)
function eriMo :boolean;      begin //< TR jos moF<>mo
  result := false;    if MoEro(1)  then result := true;  end;
function eriMo0 :boolean;      begin //< TR jos mo0<>mo
  result := MoEro(0);  end;
function eriMoU :boolean;      begin //< TR jos moU<>mo
  result := MoEro(2);  end;
{==================================================================================================}
function typOK(MUUNT :integer;  var Tstr :String) :boolean;  //Tutkii Ktyp variaatiot ja pal HALUTUKSI
  function o(S :String) :boolean;     begin      //''jos alkuOK =esim. MMJ -> MMJ/MMK* + palauttaa sen.
    result := false;                             //''MUUNT=0=EIhyväksytäMUUNTAJ.
    if SamIso (Tstr,S) and Mukan_1 (S,Tstr)
        then result := true;                //'''''''''''''''''''' +6.0.2
   {KoeFrm.ListBx.Items.Text := AnsiUpperCase(Tstr);
    KoeFrm.ListBx.Items.Add(AnsiUpperCase(Tstr));
    KoeFrm.Show;  }end;                                         //,,,,Muuten jää alkuperäisekseen!!!
  procedure sij (S :String);  begin
       Ktyp := S;  typOK := true;   Tstr := S;  end;
begin                                //''''Glob. sijoitus !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  typOK := false;
  if o('MM') or o('MMJ') or o('MMK') or o('MMJ,MMK') or o('MMJ.MMK') or o('MMJ;MMK') or
     o('MMJ:MMK') or o('MMJ/MMK') or o('MMJ/MMK*')
     then sij ('MMJ/MMK*')
 {else if o('MC') or o('MCM') or o('MCMK')  //<,-2.0.3
       then sij('MCMK')}
  else if o('MCMK3½')   then sij('MCMK3½')  //<,+2.0.3
  else if o('MCMK3½½')  then sij('MCMK3½½') //<,+2.0.3
  else if o('MCMK4½')   then sij('MCMK4½')  //< +2.0.3
  else if o('P') or o('PL') or o('PLK') or o('PLKV') or o('PLKVJ') or o('PLKVJ*')
       then sij('PLKVJ*')
  else if o('AVc') or o('AVcu') or o('AVOc') or o('AVOcu') or o('AVOJc') or o('AVOJcu') or
          o('AVOJOc') or o('AVOJOcu') or o('AVOJOHc') or o('AVOJOHcu')
       then sij('AVOJOHcu')
 {else if o('AMC') or o('AMCM') or o('AMCMK')   //<,-2.0.3
       then sij('AMCMK')}                      
  else if o('AMCMK3½')   then sij('AMCMK3½')    //<+2.0.3
  else if o('AMCMK3½o')  then sij('AMCMK3½o')   //<+11.0.1
  else if o('AMCMK3½HD') then sij('AMCMK3½HD')  //<+11.0.1
  else if o('AMCMK3½½')  then sij('AMCMK3½½')   //<+2.0.3
  else if o('AMCMK4½')   then sij('AMCMK4½')    //<+2.0.3
  else if o('AMM') or o('AMMK') or o('AMMK*')
       then sij('AMMK*')
  else if o('AMK') or o('AMKA')
       then sij('AMKA')
  else if o('AXM') or o('AXMK')
       then sij('AXMK')
  else if o('AXC') or o('AXCM') or o('AXCMK')
       then sij('AXCMK')
  else if o('AP') or o('APA') or o('APAK') or o('APAKM') or o('APAKM*')
       then sij('APAKM*')
  else if o('KiskAbb-AlN' )  then sij('KiskAbb-AlN' ) //<,,Ei liene merkitystä                      //<,,+6.0.4
  else if o('KiskAbb-AlS' )  then sij('KiskAbb-AlS' )
  else if o('KiskAbb-CuN' )  then sij('KiskAbb-CuN' )
  else if o('KiskAbb-CuS' )  then sij('KiskAbb-CuS' )
  else if o('KiskAbb-CuNx')  then sij('KiskAbb-CuNx')
  else if o('KiskAbb-CuSx')  then sij('KiskAbb-CuSx')
 {else if o('S') or o('SV') or o('SVj') or o('SVjä') or o('SVjär') or o('SVjärj') or                //< -6.0.2
          o('SVjärje') or o('SVjärjes') or o('SVjärjest') or o('SVjärjest.')}
  else if o('SVsystAL3½')  then sij('SVsystAL3½')
  else if o('SVsystCu3½')  then sij('SVsystCu3½')
  else if o('SVsystAL4N')  then sij('SVsystAL4N')
  else if o('SVsystCu4N')  then sij('SVsystCu4N')
  else if o('SVsystAL5S')  then sij('SVsystAL5S')
  else if o('SVsystCu5S')  then sij('SVsystCu5S')                                                   //<''+6.0.2
  else if o('AVOa') or o('AVOal') or o('AVOJa') or o('AVOJal') or o('AVOJOa') or o('AVOJOal') or
          o('AVOJOHa') or o('AVOJOHal')
       then sij('AVOJOHal')
  else if (o('Mu1') or o('Muu1') or o('Muun1') or o('Muunt1') or o('Muunta1') or o('Muuntaj1') or
           o('Muuntaja1') or o('Muuntajat1') or
           o('Mu 1') or o('Muu 1') or o('Muun 1') or o('Muunt 1') or o('Muunta 1') or o('Muuntaj 1') or
           o('Muuntaja 1') or o('Muuntajat 1'))  and (MUUNT>0)
       then sij('Muuntajat 1')
  else if (o('Mu2') or o('Muu2') or o('Muun2') or o('Muunt2') or o('Muunta2') or o('Muuntaj2') or
           o('Muuntaja2') or o('Muuntajat2') or
           o('Mu 2') or o('Muu 2') or o('Muun 2') or o('Muunt 2') or o('Muunta 2') or o('Muuntaj 2') or
           o('Muuntaja 2') or o('Muuntajat 2'))  and (MUUNT>0)
       then sij('Muuntajat 2')
  else if (o('Mu3') or o('Muu3') or o('Muun3') or o('Muunt3') or o('Muunta3') or o('Muuntaj3') or
           o('Muuntaja3') or o('Muuntajat3') or
           o('Mu 3') or o('Muu 3') or o('Muun 3') or o('Muunt 3') or o('Muunta 3') or o('Muuntaj 3') or
           o('Muuntaja 3') or o('Muuntajat 3'))  and (MUUNT>0)
       then sij('Muuntajat 3');
end;//typOK
{############################################################### EdvNjAs.INC}


