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

{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NOLA10.INC
 Tämä sisältää VERKON IMPEDANSSITIETOJEN laskentarutiinit Unit1/Nola1,10.INC, verkon komponenttien
 (kaapelit, muuntajat) impedanssikomponentit, ks. Unit0/Nola01,02.INC.
---------------------------------------------------------------------------------------------------}
 procedure ZaoFileen (si :string);      begin end; (*VAR Lst :TStringList;  ff :TextFile;  fn,sx :string;  u :integer;   begin //121.4
      //C:\Projektit XE2\NolaKehi\BIN\$_UFileen.txt
      fn := gAjoPath +'Z_ _ups_Fileen.txt';
      sx := '';  u := -1;
      Lst := TStringList.Create;
      if fFileExists(fn)  then begin
         Lst.LoadFromFile(fn);
         u := Lst.Count;  end;
      if NOT fFileExists(fn) OR (u=0)  then begin
         sx := DateTimeToStr(Now) +'  Kun r>38 => PanRv := r-8, (Prv=Panrv).' +Chr(10) +
               '    !!___________________________ 1.NroVasMarg´ssa = edvKuvaajan PANELIrivin nro(Prv).' +Chr(10) +
               '    ...!!!_______________________ 2.Nro =Kirjoitetun rivin (TStringList.Count+1)nro.' +Chr(10) +
               '    ............... !.r!!/[1]____ 3.Nro =laskeRJpit´n 1. param(=tunniste Loc.r(PanRv)/[Josa]).' +Chr(10);
      end;
      sx := sx +'Prv ' +fImrkt0(Panrv,2) +' ' +fImrkt0(Lst.Count+1, 2); //<Panrv(oli YLrj) =ao. palstan rvNo PRC sij_PrRjNj´ssa, vain tätä varten.
      if Pos('A=',si) >0  then si := si +' __________';
      Lst.Add(sx +' ' +si);
      if Lst.Count>0  then
         wbeep([0,0]);
      Lst.SaveToFile(fn);
      Lst.free;
   end; //*)

function strRjX (Ra,Xa :real) :string;      VAR sc,Sa :string;      begin//Käytetty fileenkirj:ssa WrKoeF.
   sc := '--------';
   if Ra<=0  then Sa := sc
             else Sa := fRmrkt0 (Ra,8,6);
   if Xa<=0  then Sa := Sa +'+j' +sc
             else Sa := Sa +'+j' +fRmrkt0 (Xa,8,6);
   result := Sa;  end;

function fPoiskAikaRaja_ (Uo :integer) :real;      var T :real;      begin
   if Uo <= 120+1  then T := 0.8  else
   if Uo <= 230+1  then T := 0.4  else
   if Uo <= 277+1  then T := 0.4  else
   if Uo <= 400+1  then T := 0.2  else
                        T := 0.1;      // >400 V
   Result := T;
end;

function fUo_ (Un  :integer) :integer;    var Uv,Uao :integer;      begin //,,,Siirretty 6.0.0  Y_.PAS :sta
         Uv := Pyor (Un/Sqrt(3));
         if Uv < 120*1.1  then Uao := Uv   else //< Un=207.8  Uv=120
         if Uv < 230*1.1  then Uao := 230  else //< Un=400    Uv=230.9
         if Uv < 277*1.1  then Uao := 277  else //< Un=480    Uv=277
         if Uv < 400*1.1  then Uao := 400  else //< Un=692.8  Uv=400
                               Uao := Uv;
         Result := Uao;
end;//S_Usrj:  Un = '100  \380   \400_  \415   \480_  \500   \600   \660    \690_  \1000_';  _ = Nim.U srj
    //         Uv =  57.7 \219.4 \230.9 \239.6 \277.1 \288.7 \346.4 \381.01 \393.4 \577.4
    //      Uv+10%=  63.5 \241.3 \254   \263.6 \304.8 \317.5 381    \410.2  \438.2 \635.1

function fUn :integer;    VAR U :integer;      begin                                       //<Edvn pääjännite
                                    U := a_getIntg (100,edv.YLE.Un);  {230;}{400;}
                                    Result := U;  end;
function fUv :real;       VAR U :real;      begin                                          //<Edvn vaihejännite
                                    U := fUn / Sqrt (3);
                                    Result := U;  end;
function fUo :integer;    VAR U :integer;      begin                                       //<Edvn NIM.vaihejännite
                                    U := fUo_ (fUn);
                                    if U<0  then ;
                                    Result := U;  end;
function fPoiskAikaRaja :real;      begin
                                    result := fPoiskAikaRaja_ (fUo);         end;
function fPoiskAikaRajaS :string;   begin
                                    result := fRmrkt0 (fPoiskAikaRaja,1,-1);  end;       //< -1 = +6.2.21

function fValittuPoisAika :real;      begin                                              //<,, +6.2.21
                                    result := a_getReaa (37011, edv.YLE.PoisAika);  end;
function fValittuPoisAikaS :string;   begin
                                    result := fRmrkt0 (fValittuPoisAika,1,-1);  end;

{FUNCTION fV_U_k :Real;           //< uh% -laskuihin, uh% := V_U_k * (RP + XQ)
VAR ar :Real;   N :Integer;      BEGIN                //' * (Yht_kW+Yht_kVAr
   N := a_getIntg (37012, edv.YLE.VaiheLkm);
   IF not (N  IN [1,3])  THEN N := 3;       //< Varm.vuoksi
   ar := 100 / (N*Sqr(fUv));                //< 3v=100/(V¨3Uv)² = 100/(3 Uv²)  //<P.o. fUn havaittu 6.0.0:
   IF N=1  THEN a8 := a8*2;                 //< 1v=200/1(Uv)²                                      -6.0.0 Korj.
// IF N=1  THEN ar := ar*2;                 //< 1v=200/1(Uv)²    Oli:  IF N=1  THEN a8 := a8*2;    +6.0.0 Korj.
   Result := ar;                            //                   ''''  KAMALA VIRHE (ei vissiin) ?!?!?!?!?!?!?!?!?
END;//FNC fV_U_k}
// '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''-6.0.0
{UNCTION fV_U_k :Real;      VAR ar :Real;   N :Integer;      BEGIN //< uh% -laskuihin, uh% := V_U_k * (RP + XQ)
   N := a_getIntg (37012, edv.YLE.VaiheLkm);
   IF NOT (N  IN [1,3])  THEN N := 2;       //< Varm.vuoksi
   if N=1
      then ar := 600 / Sqr(fUn)             //< 1v=600/U²                     +6.0.0 #############################
      else ar := 100 / Sqr(fUn);            //< 3v=100/U²                     +6.0.0 #############################
   Result := ar;
END;//FNC fV_U_k}
// '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''-7.0.4
FUNCTION fV_U_k :Real;      VAR ar :Real;   N :Integer;      BEGIN //< uh% -laskuihin, uh% := fV_U_k * (RP + XQ)
   N := a_getIntg (37012, edv.YLE.VaiheLkm);                       //uh3v% = (Ip*R + Iq*X)100 /Uv,  Ip=P/(V¨3 Un cos)
   IF NOT (N  IN [1,3])  THEN N := 2;       //< Varm.vuoksi        //      = (
   if N=1                                                          //      = P(R*cos + X*sin)100/(V¨3 UnUn/V¨3)
      then ar := fUv             //< 1v=100/Uv²  7.0.4: Oli 600/U² //      = (PR + QX) 100 / Un² #################
      else ar := fUn;            //< 3v=100/Un²                    //uh1v% = (PR + QX) 100 / Uv² #################
   ar := 100 / Sqr(ar);
   Result := ar;
END;//FNC fV_U_k}
//=========================================================================================================''7.0.4
                   //qOhj: 1=PT kohdalla   2=PTedellä            3=PTjäljssä   0=PTtäEiooEdv:ssä
                   // =                    2=Zn pienmpi edellä   3=Zn pienmpi jälempnä        //,Siirretty 7.0.3 Moot.INC:stä
                   //,,PRC laskee Edv' n PE´n Zp'n...........................................................................
procedure laskeEdvZpe (mrw,EdjNo :integer;  Zpe50V :real;  VAR qOhj :integer;  VAR qRn,qXn,PEpit :real);
                   //mrw'= MOOT.INC´in MR,  EdjNo= ent. VrkNo                  //'Ei vastaa ollenkaan ed.?? Haittaako??
                   //MRW:  Jos=0, ollaan laskemassa nromaalien Pr,Rj ja LääkMuuntjPr´n Uk'ta, jolloin tutkitaan, onko ko. Edj´n ALUSSA PT, jolloin
                   //+130.2e: Kun MRW=0, Lasketaan Pr,Rj tai LääkPr´n Uk´ta EdvNewLask´ssa, jolloin EdjNo KORJATAAN -1´llä, KOSKA PT voiOlla jo Josan ALUSSA,
      VAR eja,i,j :integer;                                                         //' jolloin seuraavia PT´ta ei tarvitse enää tutkia kumpaankaan suuntaan
        //eTyp :string;  eMm2,ePit :real;  eKpl,eTk :integer;                       //' ja kutsukohdassa Zpe´hen sijoitetaan Za(~"Zpe50V").
          Rn1,Xn1,Zn1, Rn2,Xn2,Zn2 :real;  s1,s2 :string;
          PEpit1,PEpit2 :real; //<+7.0.3
   procedure summaaZpe (os:integer;  VAR _Rn,_Xn,_Pit :real);  //<_Pit +7.0.3  Katuval takia, MOOT:ssa ei käyttöä.
         VAR aTyp :string;  aRn,aXn,aMm2,aPit,aPEker :real;  aKpl,aTk :integer;
             rec :EdvPalstaType;        begin //<+7.0.3
      if os=0  then os := -1;                 //<Ohjataan Sorc[1].josa´aan
      if os<=0  then rec := edv.Sorc[Abs(os)].josa //<+7.0.3  130.2e: Abs (tuli err -1´stä).
                else rec := edv.edka[os];
      aTyp :=   a_getStrg (30103, rec.Tyyppi);
      aMm2 :=   a_getReaa (30103, rec.Amm2);
      aPit :=   a_getReaa (30103, rec.Pituus);
      aKpl :=   a_getIntg (30103, rec.Lukumaara);
      aTk :=    a_getIntg (30103, rec.Lampotila);
      aPEker := a_getReaa (30103, rec.PEker);

      aRn := resP (aTyp,aMm2);
         aRn := rTkorj (fPal (aTyp),aRn,aTk) *aPit/aKpl *aPEker;
      aXn := Xp_ind (aTyp,aMm2);
      aXn := aXn *aPit/aKpl *aPEker; //<'PEker PE-johtimsta huomioitava osuus (1=Koko Zpe, 0=Ohittuu kokonaan)
      _Rn := _Rn +aRn;
      _Xn := _Xn +aXn;
      _Pit := _Pit +aPit; //<+7.0.3  200 m:n rajan tarkistamiseen
   end;//summaaZpe

   procedure info;      begin end;
   {if (EdjNo=1) and ((s1<>'') or (s2<>''))  then EiOKinfo ('Liitoskohta: '+IntToStr (EdjNo) +',  PT-johto-osaN:ot '+
       'Edellä:  ' +fRmrkt0 (PEpit1,1,1) +'m '+s1 +'   Jäljessä:  ' +fRmrkt0 (PEpit2,1,1) +'m '+s2);  end;}

begin//laskeEdvZpe.................
   qOhj := 0;              //< 0=PTtäEiooEdv:ssä
   qRn := 0;  qXn := 0;
   Rn1 := 0;  Xn1 := 0;  Zn1 := 0;  PEpit1 := 0{Pituus PT:hen +7.0.3};
   Rn2 := 0;  Xn2 := 0;  Zn2 := 0;  PEpit2 := 0{Pituus PT:hen +7.0.3};
   s1 := '';  s2 := '';
      eja := {a_getIntg (30104,}edv.YLE.JohtoOsia.ArvoInt; //,EdjNo on ent. MR (Moot.INC:ssä: Varmisti ettei osoiteta 0 -osoitteeseen)
      if EdjNo>eja  then EdjNo := eja;            //<Ehkä jo tarkistettu muualla. ,,,,,,,,,,,,,,,,,,,,+7.0.3,,,,,,,,
      if (mrw=0)  then                            //<,,Pr,Rj tai LääPr´n Uk-laskennassa kutsu tulee EdvNewLsk´sta jossa J-osan [Edi]´n alussa voi olla PT,
         EdjNo := EdjNo -1;                       //   jolloin muut PT-tapaukset eivät voi antaa pienempää Zpe´tä, eikä niitä kantsu tutkia.
      if (EdjNo=0)  then EdjNo := -1;             //<''+130.2e:  Ohjautuu Sorc.Josa´lle.
                          //qOhj: 1=PT kohdalla   2=PTedellä   3=PTjäljssä   0=PTtäEiooEdv:ssä
                          //   =                  2=Zn pienempi edellä   3=Zn pienempi jälempänä :11.0.1: EiEnään.
   if (EdjNo<=0) and edv.Sorc[1].josa.PTlopussa.arvoBoo  OR //<,PT on edj:n lopussa =kohdalla, Zpe yms. jääEnnall.
      (EdjNo> 0) and edv.edka[EdjNo]. PTlopussa.arvoBoo  OR //<',Ehdot + sij. yhdistetty      =11.0.1
      (mrw=0) and ( (EdjNo>0) and edv.Edka[EdjNo].PTlopussa.arvoBoo OR
                    (EdjNo<0) and edv.Sorc[1].Josa.PTlopussa.arvoBoo )
   then
      qOhj := 1
   else begin                        //<,,Etsitään EDELTÄ VERKOSTA.===============================================
      if EdjNo>0  then                                                                     //<Ehto +11.0.1
         for i := EdjNo DownTo 1  do                                //<EdjNo testattiin jo edellä, mutta 1 otettava mukaan.
         if edv.edka[i].PTlopussa.arvoBoo
         then begin
            for j := i+1 to EdjNo  do BEGIN                         //<i+1 koska PT on johto-osan [j] JÄLJESSÄ eikä
               summaaZpe (j,Rn1,Xn1,PEpit1);                        // sen PE-johdinta SAA LASKEA.
               if mrw=1  then
                  s1 := s1 +IntToStr (j) +'  ';  END;
            if (Rn1>0) or (Xn1>0)  then                             //<Ettei epätarkkuutta, jos molemmat =0.
               Zn1 := Sqrt (Sqr (Rn1) + Sqr (Xn1));
            Break;  end
         else if i=1
         then begin                                                 //<Edv:ssä ei ollut PT´tä, tutkitaan PK  +6.2.2
            j := 1;                                                 //<+7.0.3
            if edv.Sorc[j].josa.PTlopussa.arvoBoo  then BEGIN       //<Tutkitaan VAIN [1].         ,,,+7.0.3
               for j := 1{i=1} to EdjNo  do begin                   //<Lasketaan Zpe liitokseen asti =[1..EdjNo]
                  summaaZpe (j,Rn1,Xn1,PEpit1);                     //< 1 -> j  =7.0.3
                  if mrw=1  then
                     s1 := s1 +IntToStr (j) +'  ';  end;            //<Vain debuggaukseen, ks. PRC info edellä.
               if (Rn1>0) or (Xn1>0)  then                          //<Ettei epätarkkuutta, jos molemmat =0.
                  Zn1 := Sqrt (Sqr (Rn1) + Sqr (Xn1));  END;
         end;                                                       //<'''''''''''''''''''''''''''''''+6.2.2  7.0.3

      for i := EdjNo+1 to eja  do    //<,,Etsitään JÄLJEMPÄÄ VERKOSTA.============================================
      if edv.edka[i].PTlopussa.arvoBoo  then begin
         for j := EdjNo+1 to i  do BEGIN
            summaaZpe (j,Rn2,Xn2,PEpit2);
            if mrw=1  then
               s2 := s2 +IntToStr (j) +'  ';  END;
         if (Rn2>0) or (Xn2>0)  then                                    //<Ettei epätarkkuutta, jos molemmat =0.
            Zn2 := Sqrt (Sqr (Rn2) + Sqr (Xn2));
         Break;
      end;
{     PEpit := 0;                                                       //<Ehkei olisi tarve.  <,,-11.0.1
      if (Zn1<=Zn2) and (Zn1>0) or (Zn2=0)                              //########################################
      then begin qOhj := 2;  qRn := Rn1;  qXn := Xn1;  PEpit := PEpit1; //<qOhj: 2=PTedellä     3=PTjäljessä
                 if Zn1=0  then                                         //       1=PTkohdalla   0=PTtäEiooEdv:ssä
                    qOhj := 0;  end                                     //########################################
      else if Zn2>0                                                          //,##################################
      then begin qOhj := 3;  qRn := Rn2;  qXn := Xn2;  PEpit := PEpit2; end; //<Muuten qOhj jää 0 :ksi.###########}

      PEpit := 0;                                                       //<Ehkei olisi tarve.
      if (Zn1<=Zpe50V) and ((Zn1>0) or (Zn2=0))        //<Modif Zpe50V 11.0.1 //########################################
      then begin qOhj := 2;  qRn := Rn1;  qXn := Xn1;  PEpit := PEpit1; //<qOhj: 2=PTedellä     3=PTjäljessä
                 if Zn1=0  then                                         //       1=PTkohdalla   0=PTtäEiooEdv:ssä
                    qOhj := 0;  end                                     //########################################
      else if Zn2>0                                                          //,##################################
      then begin qOhj := 3;  qRn := Rn2;  qXn := Xn2;  PEpit := PEpit2; end; //<Muuten qOhj jää 0 :ksi.###########
      info;                                                                  //'##################################
   end;//if edjNo<=0 else
end;//laskeEdvZpe
//================================================================================================================
//,,Palauttaa kertoimen, jolla YHDEN kaapelin imped.komponentit kerrottuna antaa KPL-rinnankytketyn
//,,kaapelin ao. YHTEIS-/KONONAISimpedanssikomponentit:  OHJ=12=MaxZ -pisteeseen, MUUTEN JOHDN PÄÄHÄN
function fKxTot (ohj :integer;  tyyp :string;  mm2 :real;  kpl :integer): real;      begin //<Oli fKxLz
             //ohj'=12=MaxZ....''''''''''''''''''tarv.VAIN, jos SVjärjestelmä ######################
   if ohj<>12                              //<Ei huomioida maxZ -pistettä = Johdon loppuun <<<<<<<<<
   then if  kpl>0  THEN Result := 1/kpl    //<Varm.vuoksi = TARPEEN ################################
                   ELSE Result := 1
   ELSE if  fOnSV (tyyp)                   //<,,MaxZ -pisteelle, ohj=12 ############################ +6.0.2
   then Result := SVsuhtL (tyyp,mm2)
   ELSE if  kpl>=2
   then Result := kpl/(4*(kpl-1))          //<Jos kpl=2  kerr=0.5,   kpl=3  kerr=3/8 jne.
   ELSE if  kpl>0  THEN Result := 1/kpl    //<Varm.vuoksi = TARPEEN ################################
                   ELSE Result := 1;  END;
//==================================================================================================
//,,###########,,,,,,,,,,,#################################...##################################....
//,,fKxSuhLz = MaxZ (=aina) PISTEEN SUHTEELLISEN etäisyyden:  totZ = fKxSuhLz * Johto-osanPituus ###
function fKxSuhLz (tyyp :string;  mm2 :real;  kpl :integer): real;      begin
                 //''''''''''''''''''''''''tarv.VAIN, jos SVjärjestelmä ############################
   if  fOnSV (tyyp)                        //<MaxZ -pisteelle / SVjärjest.########################## +6.0.2
   then Result := SVsuhtL (tyyp,mm2)
   ELSE if  kpl>2                          //<MaxZ -pisteelle / kpl > 2 ############################
   then Result := kpl/(2*(kpl-1))          //< 2 EiOo vahinko !#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#
   ELSE Result := 1;  END;                 //<MaxZ -pisteelle, MaxZ = Johto-osan päässä:  kpl < 3 ##
//==================================================================================================
function fPEkEkaJ :integer;      VAR asti,i,j :integer;    begin//PE-ohitus vasta seur.johto-osilla.
   asti := a_getIntg (10011, edv.YLE.JohtoOsia);      //(PT:n sij)Result = -1 jos eioo, 0 jos Sorc:ssa, >0 jos Edv.
   result := -1;                        //< Oli 0, => -1 = EiPT:tä, jää jos ei Liitt.johdossakaan <'6.2.2
   j := 0;
   for i := 1 to a_getIntg (10011,edv.YLE.SorceCount)  do
   if a_getBool (10012,edv.Sorc[i].josa.PTlopussa)      //<Tutkitaan onko yhdenkään Sorc[].josa :ssa PT lopussa.
      then begin j := i;  Break;  end;

   if j>0                                               //<Löytyi liittymistä.
   then result := 0                                     //<'merkiksi := 0
   else for i := 1 to asti  do                          //< 0 = Ei löytynyt Liittymän jälkeisestä JK:sta. +6.2.2
   if a_getBool (10012,edv.edka[i].PTlopussa)
      then begin  result := i;                          //<PE-ohitus vasta seur.johto-osilla (PT on [i]:n lopussa)
                  Break;  end;
end;
//==================================================================================================
                                      //,,Tapaus IH/Vantaa/Mäenpää: Lisää impedanssiin PEN+PE -johtimen imped. kun
                                      //  PEN-PE -yhdistäminen on 60 m:n päässä. =Käsitellään vikaimpedanssina.!!!
                                      //,,############## NYT OHITETTU, ks. kutsu ennen Rtot := ...################
function PEN_PE_LenkkiOK (VAR pen_peS :string;  VAR qR,qX :real) :boolean; //<qR,qX p.o.<>'' KASVAA.##############
                             CONST errC=' Error (';                        //'####################################
                             VAR ar,ax, qRpen,qXpen,qRpe,qXpe,pit,mm2 :real;  tyyp,capt :string;  kpl,Tk :integer;
                                 boA :boolean;
      //PEN+PE -laskentaan : Kpl Tyyppi  mm2 Pit Tk                                                  UUSITTU 9.0.1
      //                     1   AMCMK4½ 120 60  80  => axmk4 300 ...
   function PEN_PE_lisausOK (VAR Qkpl :integer; VAR Qtyyp :string; VAR Qmm2,Qpit :real; VAR Qtk :integer) :boolean;
         VAR s,sa,su,sErr :string;  boo :boolean;  E{errOs +9.0.1},ai{+10.0.3} :integer;

      procedure aTyhVex (VAR ss :string;  VAR os :integer);     VAR i,w :integer;  begin//Laskee + poistaa alkutyhjät.
         w := Length (ss);
         for i := 1 to w  do
            if ss[i]<>' '
            then Break
            else begin
               os := os+1;
               Delete (ss,1,1);  end;
      end;
      procedure ifboo (ots :string);      VAR i :integer;      begin
         if boo
         then sErr := ''
         else begin
              for i := 1 to Length (sErr)  do
              if (sErr[i]=' ') or (i=Length (sErr))  then begin
                 if i=Length (sErr)
                    then sErr := sErr +FNT_B0                //<,Mmuuten jää vika mrk värjäämättä, todettu.
                    else Insert (FNT_B0,sErr,i);             //<Seur. välilyönnin kohdalle fonttivärin nollaus..
                 sErr := CLR_REB +sErr;                      //<..ja strgn alkuun pun.väri.
                 Break;  end;
              sErr := COLOR_RED +ots +'</f>) :  ' +sErr;  end;
      end;

   begin//PEN_PE_lisausOK............
      with EdvNewFrm  do begin
         PEN_PE_inf.Width := HeaderPanel.Width - PEN_PE_inf.Left -2;
         with EdvNewFrm.ApuLbl  do begin                             //<,Jotta ApuLbl´n Hint toimisi (sama kuin
            Top :=   PEN_PE_inf.Top;    Left :=   PEN_PE_inf.Left;   //  PEN_..:n hint) apuna (transparent) koskei
            Width := PEN_PE_inf.Width;  Height := PEN_PE_inf.Height; //  PEN_PE_inf´n hint worki.
            Caption := '';  end;
      end;
      sErr := '';
      E := 0;
      boo := false;
                                       //,,pen_peS´sin sijoitus puuttuu, ei löydy mistään, havainto 10.0.3
      pen_peS := TagVex (pen_peS);            //<Tagit (COLOR´it yms.) + alku-/lopputyhjät vex.
      if pen_peS=''                           //<,Tyhjä str OK =ei PE_PEN -lenkkiä =NORMAALI tilanne.
      then boo := true
      else begin                              //,,Poistetaan S:n ekoja mja samalla laskien mahd. löytyvän virheen
         s := pen_peS;                        //  alkukohtaa E, johon lisätään lopussa CLR_RED´in alku.
         sa := '';                                         //,Luetaan kunnes välilyönti.
         while (Length (s)>0) and (s[1]<>' ')  do begin    //<,,Qkpl ===============================
            sa := sa +s[1];
            E := E +1;                                     //<Sijainti muistiin E :hen.
            Delete (s,1,1);  end;
         boo := SokI (sa,Qkpl);
         if boo
         then begin
            aTyhVex (s,E);   sa := '';                     //<Alkutyhjät vex, samalla päivitetään E.
            sErr := s;
            while (Length (s)>0) and (s[1]<>' ')  do begin //<,,Qtyyp ==============================
               sa := sa +s[1];
               E := E +1;                                  //<Sijainti muistiin E :hen.
               Delete (s,1,1);  end;
            Qtyyp := sa;
          //boo := Length (Qtyyp)>3
            boo := typOK (1,Qtyyp);               //<Täydentää tarvittaessa (ks. EdvNjAs.INC).
            ifboo ('Johtotyyppi');  end
         else  ifboo ('Kpl');

         if boo  then begin
            aTyhVex (s,E);   sa := '';                     //<Alkutyhjät vex, samalla päivitetään E.
            sErr := s;
            while (Length (s)>0) and (s[1]<>' ')  do begin //<,,Qmm2 ===============================
               sa := sa +s[1];
               E := E +1;                                  //<Sijainti muistiin E :hen.
               Delete (s,1,1);  end;
            boo := SokR (sa,Qmm2);
            ifboo ('mm2');
         end;
         if boo  then begin
            aTyhVex (s,E);   sa := '';                     //<Alkutyhjät vex, samalla päivitetään E.
            sErr := s;
            while (Length (s)>0) and (s[1]<>' ')  do begin //<,,Qpit ===============================
               sa := sa +s[1];
               E := E +1;                                  //<Sijainti muistiin E :hen.
               Delete (s,1,1);  end;
            boo := SokR (sa,Qpit);
            ifboo ('Pituus');
         end;
         if boo  then begin
            aTyhVex (s,E);   sa := '';                     //<Alkutyhjät vex, samalla päivitetään E.
            sErr := s;
            while (Length (s)>0) and (s[1]<>' ')  do begin //<,,Qtk ================================
               sa := sa +s[1];
               E := E +1;                                  //<Sijainti muistiin E :hen.
               Delete (s,1,1);  end;
            boo := SokI (sa,Qtk);
            ifboo ('Lämpötila');
         end;
      end;//else
      su := 'PEN+PE:  ';
      if sErr<>''                                          //<,On virheitä.
      then begin
         capt := su +errC{=' Error: ('} +sErr {+s};
         Insert (CLR_RED, pen_peS, E+1);  end              //<Virheen alkukohdasta alkaen PUNAINEN väri.
      else if pen_peS<>''                             //<Ei virheitä.  pen_peS on kutsun muuttamaton (vielä) str.
           then capt := su +pen_peS;

      s := Trim (edv.Sorc[1].josa.nimi.arvoStr);
      if s<>''  then s := '"<b>' + s +'</b>"';               //<""mrkt vain jos nimi on.

      if boo  then
      if edv.Sorc[1].josa.PTlopussa.arvoBoo //<,,+9.0.1,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,.
      then begin
        {if pen_peS<>''                               //<Oikein kuvattu pen_.., mutta jos PT jk:ssa => ristiriita.
         then begin                                   //,,PT sittenkin sallittu (tietenkin), vrt. mm.Zpe -ehto.
            if Pos ('PT=0',AnsiUpperCase (pen_peS)) >0 //<,Mjonossa ilmaistaan "PT=0" :lla halu poistaa PT.
            then begin
               boo := true;
               edv.Sorc[1].josa.PTlopussa.arvoBoo := false;  end
            else begin
               boo := false;
               su := su +CLR_RED +'1. jk :ssa  ' + s+'  on PT, ristiriitainen PE+PEN -laskennan kanssa!</f>';
               capt := su;  end; end
         else begin}
            boo := true;
            if edv.YLE.PEN_PE.arvoStr<>''                                              //<,,+10.0.3
            then begin
                 s := su +edv.YLE.PEN_PE.arvoStr;
                 ai := Pos ('(L=',s);
                 if ai>0  then Delete (s,ai,99);      //<Delataan lopusta "(L=ekviv.)
                 s := s +'(=Kpl Typ mm² Pit °C)';
                 capt := s;  end                                                       //<''+10.0.3
            else capt := su +'Yhdistäminen jakokeskuksessa tai vieressä, OK.';  {end;}
      end
      else begin
         su := su +CLR_RED +'1. jk :sta  ' + s+'  puuttuu PT ?</f>';
         boo := true;                       //<TR =Puuttuminen saattaa olla tietoinen valinta.
         capt := su;
      end;                                  //<''+9.0.1''''''''''''''''''''''''''''''''''''''''''''''''''''''''''.

      result := boo;
          //EdvNewFrm.PEN_PE_inf.Text := 'H='+IntToStr(EdvNewFrm.PEN_PE_inf.Height) +'. Kokeilua, miten workkii.';
          //EdvNewFrm.PEN_PE_inf.Height := 12; //<Autosize muutti.
   end;//PEN_PE_lisausOK
begin//PEN_PE_LenkkiOK...................................

   boA := PEN_PE_lisausOK (kpl,tyyp,mm2,pit,Tk);
   result := boA;

   ar := qR;  ax := qX;
   if boA  and (pen_peS<>'')
   then begin                                           //<,Ei saa laskea tänne ellei tyypit ym. OK.
    //result := true;
      qRpen := res    (tyyp,mm2);                       //<AMCMK4½ 120 :lla Rpen=Rv
      qRpen := rTkorj (fAlCu(tyyp), qRpen,Tk) *pit/kpl; //< -- " --         Rpen AlCu=Vaihejohtimen AlCu
      qRpe :=  resP   (tyyp,mm2);
      qRpe :=  rTkorj (fPal(tyyp),  qRpe, Tk) *pit/kpl;

      qXpen := Xv_ind  (tyyp,mm2) *pit/kpl;
      qXpe :=  Xp_ind  (tyyp,mm2) *pit/kpl;

              {EdvNewFrm.KuvausEdit.Text := sAlkuosa +'.  Program report:  Piiriin lisätty Zpen+Zpe '+
                  'lenkki:  ' +Tyyp +' ' +fRmrkt0 (mm2,1,0) +'  ' +fRmrkt0 (pit,1,1) +'m  T=' +IntToStr (Tk) +'°C'+
                  '  = (' +fRmrkt0 (qRpen+qRpe,1,6) +'+j' +fRmrkt0 (qXpen+qXpe,1,6) +') Ohm';}
                                   //,,#############################################################
      ar := ar +qRpen +qRpe;       //<,Käsitellään vikaimpedanssina
      ax := ax +qXpen +qXpe;       //<'KASVATETAAN KUTSUPARAMETRIEN ARVOA.##########################
      capt := capt +'  = (' +fRmrkt0 (qRpen+qRpe,1,6) +' + j ' +fRmrkt0 (qXpen+qXpe,1,6) +') ' +FONT_OMEGA;
   end; //else EdvNewFrm.KuvausEdit.Text := '';
   EdvNewFrm.PEN_PE_inf.Caption := capt;
   qR := ar;  qX := ax;            //<KASVOI EDELLÄ, JOS OK, MUUTEN PALAUTUU KUTSUTTU ARVO.#########
end;//PEN_PE_LenkkiOK              //''#############################################################
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§//§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§//§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§//§
//===================, ==========================================================================================//§
{                               edel->|           edj<-!->nj                               n1                          //§
          ====|=======|=======|=======|----------------|===========|==========|============|                           //§
                                                ^maxZ  ^minZ       ^minZ,asti>=0    ^maxZ  ^minZ,asti<0                //§
                                                 Edj    Edj         Nj               Nj     Nj                         //§
          Ik1v = 3Uv / V¨( [2Ry+2Re+ 2Rm+Rm0 + 2Rv+Rvo+3Rn)]² + (2Xy+2Re + 2Xm+Xm0 + 2Xv+Xv0+3Xn)² )                   //§
          Ik3v =  Uv / V¨( [ Ry+ Re+  Rm     +  Rv         ]² + ( xy+ Re + Xm     +  Xv         )² )                   //§
          Viim. j-osa:   Ik1v :lle   2Rv+Rvo+3Rn) *L*LxKer  ja  (2Xv+Xv0+3Xn) *L*LxKer  <- LxKer = n/(4(n-1))          //§
                         Ik3v :lle    Rv          *L/n      ja         Xv     *L/n                                     //§
-----------------------------------------------------------------------------------------------------------------      //§
               QJ,,, =Joko Edv:n resurssiNJ, resurssiRJ tai LaskeNj:n Rj,,,,,,,,,,,,,,,,,,,,,,,,,,,,                   //§
         - Jos QJtyp ='', saa muutkin QJ..:t olla 0 ja TÄLLÖIN OHJ+NJon määrää, mitä lasketaan.                        //§
           Jos QJtyp<>'', lasketaan edka[ASTI] tai NJn jatkoksi OHJn mukaan. ...........................               //§
         - PEk=2      =Edvn PEker ei huomioida missään johdossa tai johto-osassa.                    EI Ik3v :ssa      //§
           PEk >0..<1 =Kutsun PEk -arvoa käytetään kaikissa edvn johto-osilla VAKIOna.               EI Ik3v :ssa      //§
           PEk=0      =Edvn PEker huomioidaan edvssa syötettyjen arvojen mukaisina ao. johto-osassa. EI Ik3v :ssa      //§
-----------------------------------------------------------------------------------------------------------------      //§
,,,,,¹   = Mukana alkuperäisessä Ziks_ :ssa, muut +6.2.2 ........................................,,,Uusittu 6.2.2      //§
OHJ: ¹12 = MaxZ (Min. Ik1v) = Huomioidaan rinnakkaiskaapeleiden + SVjärj :n SUHT.pituuskerroin ###...............      //§
                              edka[] tai NJ'''''''''''''''''''''''''''''''''''''''''''''''''''''''                     //§
     ¹11 = Zik  (Norm.Ik1v) = Ei huomioida suhteellista pituuskorjausta = Z * PIT / KPL .........................      //§
                              edka[] tai NJ = Lasketaan johto-osan LOPPUUN'''''''''''''                                //§
                              NJn EKAN tai väliJKn Ik :lle ei VIELÄ tässä keinoja.                                     //§
      10 = Zik  (Norm.Ik1v) Johdon ALUSSA = Myös muuntajan, gener. tm. TOISION NAVOISSA .........................      //§
                                                                                                                       //§
      30 = Zik  (Ik3v)      = Johdon ALUSSA = Myös muuntajan, gener. tm. TOISION NAVOISSA .......................      //§
     ¹31 = Zik  (Ik3v)      = Johdon LOPUSSA:                            = Z * PIT / KPL ........................      //§
     ¹32 = Zik  (Ik3v)      = VAIN kun NJkin: 1.JK:ssa                   = Z * PIT / KPL ........................      //§
      40 = Zik  (Ik3th(TIM) = Johdon ALUSSA = Myös muuntajan, gener. tm. TOISION NAVOISSA .......................      //§
      41 = Zik  (Ik3th(TIM) = Johdon LOPUSSA:                            = Z * PIT / KPL ........................      //§
      50 = Zik  (Ik3dyn)    = Johdon ALUSSA = Myös muuntajan, gener. tm. TOISION NAVOISSA .......................      //§
      51 = Zik  (Ik3dyn)    = Johdon LOPUSSA:                            = Z * PIT / KPL ........................      //§
      ==== 30,40,50 tarvitaan, koska ohjaus edelliseen esim. os = os-1 (=-1-1) ohjaisi väärään SRC:hen. ==========     //§
      ==== 31,41,51 tarvitaan, jotta vikassa j-osassakin mahista laskea, koska ei voi ohjata os = os+1. ==========     //§
                                                                                                                       //§
eli:                     Sorc[os]....           Edka[os] TAI Edka[os]   myös  FNCt:  if Src                            //§
                         OHJ: os:               OHJ: os: === OHJ: os:    os:  then begin fo := -1*os;  f_ := fo;   end //§
      Ik1v      alussa:  10   os = -1...-n ²)   10   os  t.  11   os-1   f_   else begin fo :=  os;    f_ := os-1; end;//§
      Ik1v     lopussa:  11   "       "    ²)   11   os      =    =      fo                                            //§
      Ik1v MaxZ:ssa:     12   "       "    ²)   12   os      =    =      fo                                            //§
                                                                                                                       //§
      Ik3v  j:n alussa:  30   os = -1...-n ²)   30   os  t.  31   os-1   f_    ²) = koska SRC -tapauksessa fo=f_,      //§
               lopussa:  31   "       "    ²)   31   os      =    =      fo         voidaan sen OS -viittauksina       //§
              1.JK:ssa:  32   --      --   --   32   os      =    =      fo         käyttää samoja kuin EDKAnkin.      //§
      Ik3th j:n alussa:  40   "       "    ²)   40   os      41   os-1   f_                                            //§
               lopussa:  41   "       "    ²)   41   os      =    =      fo                                            //§
      Ik3d  j:n alussa:  50   "       "    ²)   50   os      51   os-1   f_                                            //§
               lopussa:  51   "       "    ²)   51   os      =    =      fo                                            //§
                                                                                                                       //§
ASTI: 1) <=0 = -1...-SorceCount =ko. Src   Kun OS=0 => YhteisZik (PK:ssa)........................................      //§
      2) >=1 =  1....JohtoOsia  =EdJohdot .......................................................................      //§
                                                                                                                       //§
TIM:  => Ik3th(TIM) Ajankohta (vaikuttaa VAIN GENERAATTOREILLA) oikos. alusta....................................      //§
         TIM merkitystä vain kun OHJ IN [40,41] tai kun GENER.LIITTYMÄ ja Tim<1. +8.0.9 .               '''+6.2.2      //§
                                                                                                          ,+6.2.2      //§
HUOM: - Zk3th + Zk3dyn on käsitelty TÄSSÄ, koska GENERAATTOREILLA impedanssit ovat erilaisia näissä tapauksissa.       //§
      - Jos halutaan edka[] ALUSSA -> KUTSU [os-1], Sorc[]] ko. osoitteen mukaan. ...............................      //§
                                                                                                                       //§
§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§//§
§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§//§
§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§//§
§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§//§
######################### koS on poistettu täältä kommenttisuluilla (merkitty ½koS) ###################################//§
   Esim: (1,os,PEk,FALSE, '',0,0,0,0, ar,ar,ar,ar); }                                                            //§
FUNCTION Ziks_a(OHJ :Integer;  asti :Integer;  PEk :real;  NJkin :boolean; //<,FNC = KOKON.Zk: YhtOhm. Uusitt 6.2.2    //§
                TIM :real;  QJtyp :string;  QJmm2,QJpit,muP :real;  QJkpl,QJlampot :integer;       //§u§ mu_=+8.0.7    //§
                VAR  Rsz,Xsz,LszKer,Lsz :real) :Real;      //<LszKer=Kerrottuna yhden kaapln Rv..yms. antaa            //§
                //'TIM merkitystä vain kun 40 tai 41        'maxZ:n arvot.### Lsz=MaxZ -pisteen etäisyys alusta.       //§
                //'tai kun GENER.LIITTYMÄ.                   muP=LääkMuuntajan teho[kVA].                              //§
                                                           //####'''''''AINA MaxZ-etäis.###############                //§
   VAR eRv,eRv0,eRn, Rv,Rv0,Rn, eRs,PEqq  :Real;   i,j,eja,edel,PEkEkaJ,JkUpsLsk{141.1} :Integer; //<PEkEkaJ=Seur.johto-osilla //§
       eXv,eXv0,eXn, Xv,Xv0,Xn, eXs,ar,ax :Real;   fIk3v :boolean;                                //'PEker huomioidaan.//§
       tyyp,sa :string;   mm2,pit :Real;   SrcNo,AlpAsti,kpl,clt :Integer;                        //'MaxZ-10.0.7       //§
       Rtot,Xtot, LszKer_E,Lsz_E, LszKer_U,Lsz_U :real;         //sk :string{+12.0.0};                                 //§
       //'NÄISTÄ VASTA SIJ. VAR-param:iin Rsz,Xsz.. :=  =VOI KUTSUA ..,0,0,ar,ar,ar,ar);                               //§
       //tulOK :boolean; //<KoeF:een kirjoittamiseen, WrOtsS -testi=EiSamaaRviä2x +10.0.7 .                            //§
                                                                                                                       //§
   //-------------------------------------------------------------------------------------------------------------     //§
            //PRC WrKoeF siirretty Koe.PAS´siin =12.0.0                                                                //§
            //Ks. C:\Projektit XE2\NolaKehi\SRC\GlobINC\NOLA10 KoeFileenKirjoituksia Ennen130,3ups.INC                 //§
            //..................                                                                                       //§
   procedure qWrKoeF (si :string);      begin {WrKoeF(si);  }end;//+141.1
   procedure AnnaRX (OHJA :integer;  Atyyp :string;  Amm2,Apit :real; Akpl,Aclt :integer; //Siirretty 6.2.2 OHJA+10.0.7  //§
                     VAR aRv,aXv, aRv0,aXv0, aRn,aXn, aLxKer,aLx :real);      begin       //'aoMaxZ +7.0.1               //§
      IF fOnSV (Atyyp) AND (OHJA=12) //AND (ALPasti<0)    //<MaxZ -> MinIk1v, Muuten otetaan norm R..+6.0.2  6.2.2       //§
      THEN BEGIN                     //ALPast<0 -10.0.7   //,Rv sis. KAIKKI RESISTANSSIT <<<<<<<<<<<<<<<<<<<<<<<<<       //§
         aRv :=  rTkorj (fAlCu (Atyyp), RmaxSV (Atyyp,Amm2), Aclt);                                                      //§
             //,3*=Virjamon dipl.työstä, testattu, ks. E:\Projektit\NolaKehi\BIN\Koe\SVj-Z_vs_Virjamo.TXT =+10.0.7       //§
         aRv :=  3* aRv;                                                                                                 //§
         aRv0 := aRv/3;  aRv := aRv -aRv0;                //<Zik -lausekkeeseen tuli Rv0 lisää =2Rv+Rv0+3Rn.+6.0.2       //§
         aRn :=  0;                                                                             //< +6.2.17              //§
         aXv :=  XmaxSV (Atyyp,Amm2);                     //<Xv ss. KAIKKI REAKTANSSIT <<<<<<<<<<<<<<<<<<<<<<<<<<<       //§
         aXv :=  3* aXv;                                  //<+10.0.7: 3*=Virjamon dipl.työstä, vrt. aRv edellä.          //§
         aXv0 := aXv/3;  aXv := aXv -aXv0;                //<Zik = 2Xv +Xv0 +3Rn =Olisi pitänytOllaJoAiemm. +6.0.2 !!!!! //§
         aXn := 0;  END                                   //'Ei vaikuttane tulokseen = Zkok=Rv,Xv,  havainto 6.2.2       //§
      ELSE BEGIN                                          //'Jos a800mm2, Tmax=130°C muuten 160°C. Nyt clt }             //§
         aRv :=  rTkorj (fAlCu (Atyyp), res  (Atyyp,Amm2), Aclt);                                                        //§
         aRv0 := rTkorj (fAlCu (Atyyp), resVo(Atyyp,Amm2), Aclt);                                                        //§
         aRn :=  rTkorj (fPal  (Atyyp), resP (Atyyp,Amm2), Aclt);                                                        //§
         aXv :=  Xv_ind  (Atyyp,Amm2);                    //<Jos 'S', muut jää 0:ksi, OK #########################       //§
         aXv0 := Xv0_ind (Atyyp,Amm2);                                                                                   //§
         aXn :=  Xp_ind  (Atyyp,Amm2);                                                                                   //§
      END;                                                                                                               //§
                                                                                                                         //§
    //if (ohj=12) and {+7.0.1=}aoMaxZ  //Uusittu 6.2.2     //,,Jos OHJ=12 + aoMaxZ = huomioidaan maxZ-piste ko.j-osassa. //§
      if (OHJA=12) {and apMaxZ -10.0.7}//Uusittu 6.2.2     //,,Jos OHJ=12 + aoMaxZ = huomioidaan maxZ-piste ko.j-osassa. //§
      then if fOnSV (Atyyp)                                //,,Jos OHJA=12 =huomioidaan maxZ-piste ko.j-osassa.          //§
         then begin                                                                                                      //§
              aLxKer := 1;                                 //<LxKer on jo huomioitu RmaxSV :ssa.                         //§
              aLx := SVsuhtL (Atyyp,Amm2);                 //'OK kun väliaik Zsvj lasketaan (2Rv+Rv0+..)   +10.0.7       //§
              aLx := Apit * aLx;  end                      //<aLx =MaxZ -kohdan etäisyys [m]. TämäKommentRv+10.0.7       //§
         else begin                                        //,12=MaxZ. Johdon konais Zk = (Zv+...Zn)*LxKer,              //§
              aLxKer := fKxTot (ohj,Atyyp,Amm2,Akpl);      //<eli Rv...Xn =Yhden johdon arvo * LxKer.                    //§
              aLx := Apit * fKxSuhLz (Atyyp,Amm2,Akpl); end//<aLx =MaxZ -kohdan etäisyys [m]. TämäKommentRv+10.0.7       //§
      else begin                                                                                                         //§
           aLxKer := 1/Akpl;                               //<Johdon konais Zk = (Zv+...Zn)*LxKer,                       //§
           aLx := Apit;                                    //'eli Rv...Xn =Yhden johdon arvo * LxKer.                    //§
      end;                                                                                                               //§
// procedure AnnaRX (OHJA :integer;  Atyyp :string;  Amm2,Apit :real; Akpl,Aclt :integer; //Siirretty 6.2.2 OHJA+10.0.7  //§
      qWrKoeF ('AnnaRX: oh=' +Ints(Ohja) +' typ=' +Atyyp +' mm2=' +fRmrkt0(Amm2,1,1) +' L=' +fRmrkt0(Apit,1,1) +         //§
              ' kpl=' +Ints(Akpl) +' T=' +Ints(Aclt) +' + LxKer=' +fRmrkt0(aLxKer,1,4) +' Lx=' +fRmrkt0(aLx,1,3) +       //§
              ' Rv=' +fRmrkt0(aRv,1,6) +' Xv=' +fRmrkt0(aXv,1,6) +' Rv0=' +fRmrkt0(aRv0,1,6) +' Xv0=' +                  //§
              fRmrkt0(aXv0,1,6) +' Rn=' +fRmrkt0(aRn,1,6) +' Xn=' +fRmrkt0(aXn,1,6));                                    //§
   end;//AnnaRX                                                                                                          //§
   //------------------------------------------------------------------------------------------------------------        //§
     //,FNC fK3t palauttaa kerroinarvon MM jolla Ik3th = MM * Ik3v .................................                     //§
   FUNCTION fK3t (Rk,Xk,Tim :real; VAR SU :string) :real;    VAR m,a :real; //Ik3th =  Uv * fK3t() / Zk3v   26.INC:stä 6.2.2 //§
      FUNCTION m_tasavEdj :real;      VAR mm,ar :real;   begin //'SU +12.0.0 WrKoeF´n avuksi kutsukohtaan.               //§
         ar := sys_ker (Rk,Xk);                      //<AR :ssä nyt SYSKERR, jota käytetään jälempnä Ik3th :ssa          //§
         mm := m_tasav (ar,Tim);                     //<m_tasavKerroin = f(sysKerr,Aika). ARsys..arvo sij.aiemmin        //§
         Result := mm;                                                                                                   //§
         SU := ' [fK3t: SysK=' +fRmrkt0(ar,1,5) +'Tim=' +fRmrkt0(Tim,1,4) +' TasavK(=f(SysK,Tim)=' +fRmrkt0(mm,1,4);     //§
      END;                                                                                                               //§
   begin                                                                                                                 //§
      if Tim=0  then Tim := a_getReaa (10020,edv.YLE.PoisAika); //<Kutsussa 0, jos halutaan valittu PoisAika.            //§
      if Tim>1  then Tim := 1;                                  //<+8.0.9 varm.vuoksi.                                   //§
      m := m_tasavEdj;                                          //<m = m_tasavKerroin = f(sysKerr,Aika) edellä.          //§
      a := Sqrt ((m +1)*Tim);                                                                                            //§
      Result := a;                                                                                                       //§
      SU := SU + ' =>fK3t =Sqrt ((TasavK +1)*Tim)=' +fRmrkt0(a,1,4) +' ]';                                               //§
   END;                                                                                                                  //§
   //..........................................                                                                          //§
     //,FNC fK3d palauttaa kerroinarvon RR jolla Ik3d = RR * Ik3v ..................................                     //§
   FUNCTION fK3d (Rk,Xk :real; VAR SU :string) :real;      var rr,ar :real;      begin //Ik3d =  Uv * fK3d() / Zk3v      //§
      rr := sys_ker (Rk,Xk);                                           //ALP: Ik3d = Ik3v * Sqrt (2) * sys_ker           //§
      ar := {2.84;}Sqrt (2) * rr;                                                                                        //§
      Result := ar;                                                                                                      //§
      SU := ' [fK3d: SysK=' +fRmrkt0(rr,1,4) +' fK3d=' +fRmrkt0(ar,1,4) +' ]';                                           //§
   END;                                                                                                                  //§
   //====================================================================================================================//§
   FUNCTION LaskeSrcZ (OHJ,No :Integer;   VAR Rsx,Xsx,LxKer,Lx :real) :Real; //Palauttaa liittymän Z ja kompon R,X.      //§
                                     //':TäysUUSITTU 10.0.7:  R,X:n polarimuunoksilla laskenta ja muunnokset takas.      //§
         VAR  Sorcja,i,j :integer;   //,yRs,yXs,yZs VASTA SIJ. VAR-muuttujiin Rsx,Xsx..=VOI KUTSUA ..,0,0, ar,ar,ar,ar); //§
        {Oli: qRs,qXs, aR,aX,   sR,sX,   jR,jX, eRs,eXs,eZs,eDg                   :real;   uudet:}                       //§
              iRs,iXs, iRj,iXj, oRs,oXs, oRj,oXj, yRs,yXs,yZs,yDg, uRs,uXs,uZs,uDg  :real;                               //§
        {     i..'=IterMukaisenZ  o..=NO:nZ       y..=YhteisZ=LoppuZ  u..=ApuZ                                           //§
              ..s'=Sorc  ..j=Johto                '=mahd. käänteisarvo.       }                                          //§
      {procedure ZaoSrc (ko :integer;  VAR aRs,aXs :real);       begin //<,,Koeajoon #############################       //§
         aRs := 2;  aXs := 3;  end;                                                                                      //§
      procedure ZaoJoh (jo :integer;  VAR aRs,aXs :real);       begin                                                    //§
         aRs := 5;  aXs := 4;  end;}                                                                                     //§
                                                                                                                         //§
      function fZ_rx (R,X :real;  VAR kulma :real) :real;      begin//Laskee Z = V¨(R²+X²) .                             //§
         result := Sqrt (Sqr(R)+Sqr(X));                            //Kulma    = arcTang(X/R) .                          //§
         if R>0                                                                                                          //§
            then kulma := arcTang(X/R)                                                                                   //§
            else kulma := 0;                                                                                             //§
      end;                                                                                                               //§
      procedure eZs_0_Herja;      begin                                                                                  //§
         InfoDlg ('Nola10.INC/PRC LaskeSrcZ: verkkoimpedanssin (yZs) arvoa ei pystytty laskemaan. Jos ohjelman '+        //§
                  'ajo keskeytyy, ota nämä tiedot ylös (leikkaa/kopioi) ja ilmoita ohjelman valmistajalle.',             //§
                  mtWarning,  'OK','','','',  '','','','');  end;                                                        //§
                                                                                                                         //§
      procedure ZaoSrc (vo :integer;  VAR aRs,aXs :real); //Lasketaan LIITTYMÄN impedanssit.#####################        //§z
            VAR Ry, Rm,Rm0, Xy, Xm,Xm0, rr :Real;                                                                        //§z
                                                                                                                         //§z
//,,,GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG       //§z
         procedure Z_Gen (VAR Rg,Xg :real);      VAR Zg,Ig,ar,Ikx, jSg,jRs,jcIk1v, Tig :real;                            //§z
                                                                                                                         //§z
                  //,E:\ProjektitOhat\ST-artik\ST.INC, paremmin: E:\ProjektitKoe\IkKayra.PAS / y := fK_IkIn ();          //§z
                     //,Laskee Ik:n kokonaisarvon ajalle t SIIVUTTAEN käyrän dt=0.001 aikajaksoihin Ik=(i1²+i2²)t/2      //§z
                     //,Tätä ei voida laskea kertoimena, koska i² <> k² = virta i laskettava ennen i².############       //§z
                     //'FNC palauttaa myös kertoimen Kgth =virtakerroin Ik = Kgth*Ig =fIgth.######################       //§z
            function fIgth (t :real;  VAR Kgth :real) :real;      VAR dt,ta,tu,i1,i2,ii,fnc :real;                       //§z
                                                                            //10.0.4:  q.. vaihdttu p:ksi =erottuu.      //§z
               function fK_IkIn (tx :real) :real;      VAR fK,ri, pXd,pXd1,pXd2,{pX2,pX0,}                               //§z
                                                           pTd1,pTd2,ptIkMin,ptIkSust,pIkSust :real;                     //§z
                    {Generaattorin vaimenevan Ik-käyrän tehollisarvo HETKELLÄ t (t=Ik:n kestoaika):                      //§z
                                                     cIk      1    cIk    -t/T'd     1     1     -t/T"d                  //§z
                                                     --- +  (--- - ---)* e        +(--- - ---)* e                        //§z
                                                     Xd      X'd    Xd              X"d   X'd                            //§z
                     Antaa Ik/In -kertoimen fK.       Kun t=0 => exp(0    )=1  => fK =1/X"d                              //§z
                                                      Kun t>> => exp(-1*>>)=0  => fK =cIk/Xd =Juhani Mantere 14.8.06     //§z
                     Kerroin cIk tulee generaattorin magnetoinnin ohjausparametreistä, joilla säädetään ulostulo an-     //§z
                     tamaan 2,5...3x jatkuvaa oikosulkuvirtaa suojien toiminnan varmistamiseksi. Perusmuodossaan kaa-    //§z
                     van cIk = 1 . Usein generaattorin ominaisKÄYRÄ menee em. exp.function mukaan kunnes IkIn=n. 1.59,   //§z
                     mistä alkaa kivuta lineaarisesti kertoimeen 2.5 . ABB:llä laskevat (Juhani Mantere 14.8.06), että   //§z
                     käyrä kääntyy suoraan min.arvoonsa, ks. E:\ProjektitKoe\IkKayra.PAS / y := fK_IkIn (0,3.5,t)}       //§z
                                  //fK := cIk/Xd + (1/Xd1 - cIk/Xd)*Exp(-1*tu/Td1) + (1/Xd2 - 1/Xd1)*Exp(-1*tu/Td2);     //§z
                                  //fK :=   1/Xd + (1/Xd1 -   1/Xd)*Exp(-1*tu/Td1) + (1/Xd2 - 1/Xd1)*Exp(-1*tu/Td2);     //§z
                  function fK_ao (tn :real) :real;      VAR cIk,A,B,fKn :real;      begin                                //§z
                     cIk := 1;                    //,Kun  t=0: Exp(0)       =1 =>  fK=1/Xd2=6.667                        //§z
                     A := cIk/pXd;   B := 1/pXd2; //,Kun  t>>: Exp(-t / T..)=0 =>  fK=1/Xd=0,366 ja fK=ki/Xd=2,5/Xd=0,916//§z
                     fKn := A + (1/pXd1 - A)*Exp(-1*tn/pTd1) + (B - 1/pXd1)*Exp(-1*tn/pTd2) -                            //§z
                                ((arctan(tn/(pTd1/100)))/pii) *Exp(-1*tn/pTd1); //<Tämä korjaa käyräeron Stamfordiin.    //§z
                     result := fKn; //Kuuluu olla '''100, muuten käyrä ei korjaudu oikein, ks. E:\ProjektitOhat\ST-artik\ST.INC
                  end;                                                                                                   //§z
                                                                                                                         //§z
               begin//fK_IkIn ...................                                                                        //§z
                  pXd :=      a_getReaa (10004,Edv.Sorc[vo].Src.gXd);      // Xd =2.73                                   //§z
                  pXd1 :=     a_getReaa (10005,Edv.Sorc[vo].Src.gXd1);     // Xd1=0.22                                   //§z
                  pXd2 :=     a_getReaa (10006,Edv.Sorc[vo].Src.gXd2);     // Xd2=0.15                                   //§z
                  pTd1 :=     a_getReaa (10008,Edv.Sorc[vo].Src.gTd1);     // Td1=0.185                                  //§z
                  pTd2 :=     a_getReaa (10009,Edv.Sorc[vo].Src.gTd2);     // Td2=0.025                                  //§z
                  ptIkMin :=  a_getReaa (10010,Edv.Sorc[vo].Src.gtIkMin);  // tIkMin =0.25                               //§z
                  ptIkSust := a_getReaa (10011,Edv.Sorc[vo].Src.gtIkSust); // tIkSust=0.55                               //§z
                  pIkSust :=  a_getIntg (10012,Edv.Sorc[vo].Src.gIkSust);  // IkSust =3600                               //§z
                                                                                                                         //§z
                  if tx<ptIkMin         //<,Käyrää noudatetaan vain IkMin -ajanhetkeen asti, sitten kasvaa lineaarisesti.//§z
                  then fK := fK_ao (tx)                                                                                  //§z
                  else if tx>=ptIkSust  //<,Ollaan kuoppakohdan ohi jatkuvan tilan alueella.                             //§z
                  then fK := pIkSust/Ig          //<fK on kerroin, jolla Ik(t) := fK(t)*Ig                               //§z
                  else begin            //,Ollaan kuoppakohdan ja jatkuvan tilan välisessä "kuopassa": kasvaa lineaarisesti.}
                       fK := fK_ao (ptIkMin);    //<Fnc:n arvo (kerroin) minimikohdassa.                                 //§z
                       ri := Ig*fK;              //<Minimikohdan virta-arvo.                                             //§z
                       fK := ri + (pIkSust -ri) * ((tx-ptIkMin) / (ptIkSust-ptIkMin));                                   //§z
                       fK := fK/Ig;              //<Otetaan Ig vex kertoimesta => puhdas kerroin.                        //§z
                  end;                           //'fK on kerroin, jolla Ik(t) := fK(t)*Ig                               //§z
                  result := fK;                                                                                          //§z
               end;//fK_IkIn                                                                                             //§z
                                                                                                                         //§z
            begin//fIgth.........................                                                                        //§z
               fnc := 0;          //t := 5;  Ing := 1;  dt := 1;//2;//0.05; //<KOKEILUUN.!!!!!!!!!!!!!!                  //§z
               dt := 0.001;                       //<Antaa jo promilleluokan tarkkuuden.                                 //§z
               i1 := fK_IkIn (0);                 //<Ix ekassa aikapisteessä  = ta=0 ja Kx=6,6667                        //§z
               i1 := Ig*i1;                                                                                              //§z
               i1 := Sqr(i1);                                                                                            //§z
               if t<dt                                                                                                   //§z
               then begin                                                                                                //§z
                  i2 := fK_IkIn (t);                                                                                     //§z
                  i2 := Ig*i2;                                                                                           //§z
                  i2 := Sqr(i2);                                                                                         //§z
                  fnc := (i1+i2)/2;               //<OK vaikka t = 0, koska k jo tumplaantui tässä.                      //§z
                  if t=0                                                                                                 //§z
                     then fnc := Sqrt(fnc)                   //<fnc = (i1(t=0) + i2(t=0)) /2                             //§z
                     else fnc := Sqrt(fnc/t);  end                                                                       //§z
               else begin                                                                                                //§z
                  ta :=  0;                                  //< ta = kumul. aikaväli ko. iter.kohtaan mennessä          //§z
                  while ta<t  do begin                       //Eka k1 vielä tallessa tähän tultaessa.                    //§z
                     if ta+dt>t                              //<,Ettei integraalisiivu TU mene liian isoksi, otetaan     //§z
                     then begin                              //  vain se osa, mikä mahtuu T:hen.                         //§z
                        tu := t-ta;  ta := t;  end           //<,TU = aikaväli laskentaan:  dt tai pienempi.             //§z
                     else begin                                                                                          //§z
                        tu := dt;    ta := ta +dt;  end;                                                                 //§z
                     i2 := fK_IkIn (ta);                     //<Kx tokassa aikapisteessä = ta                            //§z
                     i2 := Ig*i2;                                                                                        //§z
                     i2 := Sqr(i2);                                                                                      //§z
                     ii := (i1+i2)/2;                        //<Kahden arvon keskiarvo                                   //§z
                     fnc := fnc + ii*tu;                     //<Virran NELIÖN ja ajan tulojen kumul. summa.              //§z
                     i1 := i2;                               //<Siirretään seur.silmukkakerran ekaxi arvoksi.            //§z
                  end;                                                                                                   //§z
                  fnc := Sqrt (fnc/t);                       //< t ei voi olla <0 joten ei pääse fnc/0, ks. alku.        //§z
               end;                                          //' Neliöjuuri funktion arvon / ajan suhteesta.             //§z
               result := fnc;                                                                                            //§z
               Kgth := fnc/Ig;                                                                                           //§z
            end;//fIgth                                                                                                  //§z
                                                                                                                         //§z
         begin//Z_Gen........................................                                                            //§z
            jSg :=      a_getIntg (10003,Edv.Sorc[vo].Src.gSn);                                                          //§z
            jRs :=      a_getReaa (10007,Edv.Sorc[vo].Src.gRs);    // gRs=0.00240                                        //§z
            jRs :=      rTkorj (FALSE{Cu},jRs,80);                 // jRs kylläkin 22°C:ssa, virhe eioo iso.             //§z
            jcIk1v :=   a_getReaa (10013,Edv.Sorc[vo].Src.gK1vSust); // gK1vSust=2.500                                   //§z
            Ig := jSg*1000/(fUn*Sqrt(3));                          //<Ig paikallisesti.                                  //§z
            if Tim>1                                               //<,+8.0.9                                            //§z
               then TIG := 1                                                                                             //§z
               else TIG := Tim;                                                                                          //§z
            if TIG<=0           //<,mm. ImpedInfoRich:stä kutsu OH = 11 ja 31 ja TIM=0, myös laskeIkSulOK:sta.           //§z
               then TIG := 1;   //<'Jos TIG=0, tulee "Floating point devide by zero".              +8.0.10               //§z
            case OHJ of                                            //,,_0=Alussa _1=Lopussa _2=MaxZ.                     //§z
                 10,11,12 :Ikx := fIgth (TIG,ar) *jcIk1v; //< Ik1v  => Ik1th(t). AR =Ik/In -suhde.                       //§z
                 30,31,32 :Ikx := fIgth (TIG,ar);         //< Ik3v  => Ik3th(t). Oli jatkuvan tilan Kx := kXd            //§z
                 40,41    :Ikx := fIgth (TIG,ar);         //< Ik3th(t)                                                   //§z
            else{50,51}    Ikx := fIgth (0,ar);  end;     //< Ik3d  => Alkutilan Ig/Xd2.                                 //§z
                                                                                                                         //§z
            if (TIG<1) and (OHJ<49)  then                //<,Lyhyt aikavaikutus muutetaan 1 s:iin. Ei Ik3d  +8.0.9       //§z
               Ikx := Sqrt (Sqr(Ikx)*TIG/1);//,Generaattorin Z = U²/S  <= S=U*I*V¨3=3*Uv*I , I=S/(3*Uv) ,Uv=U/V¨3        //§z
                                           //,,Ero näkyy vasta Z:n 5. tai 4. desim:ssa (4. tai 3. merkitvässä (1000kVA). //§z
            Zg := fUn/Ikx;                 //<Zg := Sqr(fUn)/(jSg*1000);  =Generaattorin Zg = U²/Sg                      //§z
            Rg := jRs;                     //<Rg   Condition:             (asti<0) and (OHJ IN [30,40,50])               //§z
            Xg := Sqrt(Sqr(Zg) - Sqr(Rg)); //<Xg:  Otetaan Zg:stä Rg:n osuus vex ja jäävä Xg korjataan kertoimella.      //§z
            if Rg+Xg<0                     //<Jotta debugatessa arvot näkyisi.                                           //§z
               then SysUtils.beep;                                                                                       //§z
     {procedure ZaoSrc (vo :integer;  VAR aRs,aXs :real); //Lasketaan LIITTYMÄN impedanssit.#####################        //§z
            VAR Ry, Rm,Rm0, Xy, Xm,Xm0, rr :Real;}                                                                       //§z
      qWrKoeF ('SRC ZaoSrc Gen: OHJ=' +Ints(OHJ) +' vo=' +Ints(vo) +' Sg=' +fRmrkt0(jSg,1,1) +' Rg=' +fRmrkt0(Rg,1,6) +  //§z
              ' Xg=' +fRmrkt0(Xg,1,6) +' Ig=' +fRmrkt0(Ig,1,1) +' Ix{=f(OH)}=' +fRmrkt0(Ikx,1,1) +' TIG=' +              //§z
              fRmrkt0(TIG,1,4) +' VAR aRs=' +fRmrkt0(aRs,1,6) +' aXs=' +fRmrkt0(aXs,1,6));                               //§z
         end;//Z_Gen ====================================================================================================//§z
                  //Jos ,eRs=<0 eXs=>eZ                                                                                  //§z
    procedure Z_UPS (VAR eRs,eXs :real);     VAR qIk1v,qIk3v,qCos,uv :real;   begin                                      //§z  //VAR Rsx,Xsx,LxKer,Lx
                                {UPS: Liittymä TAI JkUps-haara +141.1 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//§z
                                 function fIk3v :real;      VAR Uv,ar :real;      begin //<,,NOLA1.INC/Fnc iks           //§z
                                 Uv := fUv;                 ar := Uv / Zik;  result := ar;  end; //< Ik3v = Uv/Zk     Nämä kumpkin eri fnc, tässä muistin tueksi.
                                 kU := edv.YLE.cU.ArvoRea;  ar := kU *3 *Uv / Zik;               //< Ik1v = c 3 Uv/Zk }  //§z}
      uv := fUv;  qIk1v := 0; {+1411:} qCos := 1;  qIk3v := 0;                                                           //§z
      if JkUpsLsk=-1  //-1=Ei JkUps -haaraa vaan UPS-liittymä. Alp= if asti<0                                            //§z  <,,+1412
      then begin  //,UPSliittymäsyöttö, ei hyväksytä kuin 1 kpl, =Ei rinnakkaisia.                                       //§z
         if edv.Sorc[1].Src.SorceKind.ArvoInt=4  then begin          //4=UPS:   Ups_Ik1v,   Ups_Ik3v,   Ups_Cos          //§z
             qIk1v := edv.Sorc[1].Josa.JkUps_Ik1v.ArvoRea *1000;     //< Ik1v = c 3 Uv/Zk   <,,NOLA1.INC/Fnc iks         //§z
             qIk3v := qIk1v; //edv.Sorc[1].Josa.JkUps_Ik3v.ArvoRea *1000;     //< Ik3v = Uv/Zk,  (JkUps_Ik3v Eioo        //§z
             qCos :=  edv.Sorc[1].Josa.JkUps_Cos. ArvoRea;  end;                                                         //§z
      end//if JkUpsLsk=-1 (Oli: if asti<0)                           //,, 0=JkUps Sorc´essa  1=Edka´ssa.                 //§z  <,,+1412
      else if JkUpsLsk=1  then begin //1=EDKA.  Oli: if Edv.Edka[vo].JkUps.ArvoInt>0                                     //§z
             qIk1v := Edv.Edka[vo].JkUps_Ik1v.ArvoRea *1000;         //JkUps, JkUps_Ik1v, (JkUps_Ik3v Eioo), JkUps_Cos   //§z
             qIk3v := qIk1v; //Edv.Edka[vo].JkUps_Ik3v.ArvoRea *1000;  Vaikkei JkUPS´illa ole 3vIk´ta.                   //§z
             qCos :=  Edv.Edka[vo].JkUps_Cos. ArvoRea;                                                                   //§z
      end                                                                                                                //§z
      else if JkUpsLsk=0  then begin //<0=SORCE.                     //< 0=JkUps Sorc´en j-haarassa.                     //§z  <,,+1412
             qIk1v := {4}      Edv.Sorc[1].Josa.JkUps_Ik1v.ArvoRea *1000;                                                //§z
             qIk3v := qIk1v; //Edv.Edka[1].JkUps_Ik3v.ArvoRea *1000;  Vaikkei JkUPS´illa ole 3vIk´ta.  JkUps_Ik3v Eioo)  //§z
             qCos :=  {0.87;}  Edv.Sorc[1].Josa.JkUps_Cos. ArvoRea;                                                      //§z
      end;                                                                                                               //§z
      if qIk1v>0  then begin                                                                                             //§z
         if fIk3v                                                //<OHJ >= 30  = Ik3v.                                   //§z
            then eRs := (                       uv) /qIk3v                                                               //§z
            else eRs := (edv.YLE.cU.ArvoRea *3 *uv) /qIk1v;                                                              //§z
         eRs := eRs*qCos;                                                                                                //§z
         eXs := eRs*Sqrt(1-Sqr(qCos));                           //< Sin=V¨(1-Cos²)                                      //§z
                        ZaoFileen('Z_UPS:  eRs=' +fRmrkt0(eRs,1,4) +' eXs=' +fRmrkt0(eXs,1,5) +' <= JkUpsLsk=' +Ints(JkUpsLsk) +
                                  ' gIk1v=' +fRmrkt0(qIk1v,1,2) +' gIk3v=' +fRmrkt0(qIk3v,1,2) +' qCos=' +fRmrkt0(qCos,1,3));
      end;//if qIk1v>0                                                                                                   //§z
   end;//Z_UPS                                                                                                           //§z
//'''GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG       //§z
                                                                                                                         //§z
      begin//ZaoSrc......................                                                                                //§z
         aRs := 0;  aXs := 0;            //<+8.0.1 Floating point overflow =Ei alustanut aXs´ää UPSilla.                 //§z
         if vo=0  then begin                                                                   //<,,+10.0.4              //§z
            InfoDlg ('Nola10.INC/PRC ZaoSrc :  vo=0 osoite tässä virheellinen!!!!!!!!.  PRCn '+                          //§z
                     'palauttamat arvot ovat arvaamattomia! Ota nämä tiedot ylös (maalaa/kopioi) ja ilmoita '+           //§z
                     'ohjelman valmistajalle.',  mtWarning,  'OK','','','',  '','','','');                               //§z
            vo := 1;  end; //',Jos vo=0 tulee NJ-laskennassa Error...''Herja                                             //§z
            //,,+141.1:  JkUPS-Pistorasiahaaran laskenta:  -1=EiJkUps´ia  0=Sorcessa  1=Edka´ssa.                        //§z
         if JkUpsLsk >=0                //<,+1412:  0=JkUps Sorc´essa  1=Edka´ssa.  UPS-liittymä aelmpna.                //§z
         then begin                                                                                                      //§z
            Z_UPS (aRs,aXs);                                                                                             //§z
            if aRs<0  then ;  end                                                                                        //§z
         else                                                                                                            //§z
         case {a_getIntg (10001,}Edv.Sorc[vo].Src.SorceKind.ArvoInt of //1=Transformer  2=LV-Cable  3=Generator  4=UPS   //§z
            1 :begin                     //<<<<<<<<<<<<<<<<< 1=Transformer <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<        //§z
                  Ry := ZRXyv (vo,1);    //<, 1=R  2=X  0=Z                                                              //§z
                  Xy := ZRXyv (vo,2);                                                                                    //§z
                  if fIk3v                                                                                               //§z
                  then begin                                                                                             //§z
                       asMparamEdv_Ik3v (vo, Rm,Rm0, Xm,Xm0);   //<,Asettaa 0 josEiMuunt =Smn<16                         //§z
                       aRs := Ry +Rm;                                                                                    //§z
                       aXs := Xy +Xm;  end                                                                               //§z
                  else begin                                                                                             //§z
                       asMparamEdv_Ik1v (vo, Rm,Rm0, Xm,Xm0);                                                            //§z
                       aRs := 2*Ry +2*Rm +Rm0;                                                                           //§z
                       aXs := 2*Xy +2*Xm +Xm0;                                                                           //§z
                  end;                                                                                                   //§z
      qWrKoeF ('SRC ZaoSrc  Sj: OHJ=' +Ints(OHJ) +' vo=' +Ints(vo) +' Ry=' +fRmrkt0(Ry,1,1) +' Xy=' +fRmrkt0(Xy,1,6) +   //§z
              ' Rm=' +fRmrkt0(Rm,1,6) +' Rm0=' +fRmrkt0(Rm0,1,1) +' Xm=' +fRmrkt0(Xm0,1,1) +                             //§z
              ' VAR aRs=' +fRmrkt0(aRs,1,6) +' aXs=' +fRmrkt0(aXs,1,6));                                                 //§z
               end;                                                                                                      //§z
            2 :begin                     //<<<<<<<<<<<<<<<<< 2=LV-Cable <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<        //§z
               aRs := a_getReaa (10031,Edv.Sorc[vo].Src.pjLiitRs);    //<Otetaan annettu  eRs                            //§z
               aXs := a_getReaa (10032,Edv.Sorc[vo].Src.pjLiitXs);    //<Otetaan laskettu eXs                            //§z
               if {NOT -6.2.9}fIk3v                                   //<,,Lasketaan kokonais R + jX    <,,+6.0.2        //§z
               then begin       //,,Rm,Xm vain apuna +6.0.2  Rik3v=V¨[Zik3v²Rs²/(Rs²+Xs²)] =Rik3v Rs/Xs suhteessa.       //§z
                  Rm := a_getReaa (10033,Edv.Sorc[vo].Src.Iks3v)*1000;//< =Iks3v, Rm ym. apuna. Lasketaan Zik3v:..       //§z
                  rr := fUv/Rm;                                      //< Zik3v =rr =Uv/Ik3v                              //§z
                  if aRs+aXs=0                     //<Varm.vuoksi tässäkin:  Rs+Xs=0 mahd. esim. vakiovirtaUPSilla.      //§z
                  then begin                                                                                             //§z
                     Rm := rr/Sqrt(2);  Xm := Rm;  end                  //<Kun R1=X1 => Z1=V¨(2*R1²) => R1=Z1/V¨2        //§z
                  else begin                                            //,,Z1=V¨(R1²+X1²) johon X1=R1*Xs/Rs,,,,,        //§z
                     Rm := Sqrt (Sqr(rr)*Sqr(aRs)/(Sqr(aRs)+Sqr(aXs))); //<ar=Rik3v =V¨[Zk3v²*Rs²/(Rs²+Xs²)] =R/X suhteessa
                     Xm := Sqrt (Sqr(rr)-Sqr(Rm));  end;                //<Xm=Xik3v =V¨(Zik3v²-Rik3v²).                  //§z
                  aRs := Rm;  aXs := Xm;  end                      //<Muuten (Ik3v:ssa) jää aikais. aRs..voimaan.        //§z
               else begin                                                                                                //§z
                    aRs := 3*aRs;  aXs := 3*aXs;                                                                         //§z
               end;                                                                                                      //§z
                               koS := 'SRC ZaoSrc  Pj: OHJ=' +Ints(OHJ) +' ';                                            //§z
                               if fIk3v  then koS := koS +'(Ik3v)'                                                       //§z
                                         else koS := koS +'(Ik1v)';                                                      //§z
                               koS := koS +'VAR aRs=' +fRmrkt0(aRs,1,6) +' aXs=' +fRmrkt0(aXs,1,6);                      //§z
                               qWrKoeF (koS);                                                                            //§z
               end;                      //,Edellinen siirretty Z_gen´iin  +8.0.8                                        //§z
            3 :Z_Gen (aRs,aXs);          //<<<<<<<<<<<<<<<<< 3=Generator <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//§z
            4 :Z_UPS (aRs,aXs);          //UPS: Liittymä +141.1 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//§z
         end; //case <<<<<<<<<<<< ELSE:  UPSeja (ei voi olla rinnan),  aRs, aXs jää 0. <<<<<<<<<<<<<<<<<<<<<<<<<<<<<     //§z
              qWrKoeF ('SRC ZaoSrc END. Sj: OHJ=' +Ints(OHJ) +' VAR aRs=' +fRmrkt0(aRs,1,6) +' aXs=' +fRmrkt0(aXs,1,6)); //§z
      end;//ZaoSrc                                                                                                       //§z
                                                                                                                         //§
      procedure ZaoJoh (OHJU,jo :integer;  VAR aRs,aXs :real); //LiittymäKAAPELEIDEN impedanssit.##### OHJU+10.0.7       //§
            VAR Rv,Rv0,Rn, Xv,Xv0,Xn,  mm2,pit :Real;   tyyp :string;                                                    //§
                kpl,clt :integer;  {aoMaxZ :boolean;     }begin //<aoMaxZ -10.0.7                                        //§
                                                                                                                         //§
         tyyp := a_getStrg (10010,Edv.Sorc[jo].josa.tyyppi);   //<,,,Nämä sij. vain tarvittaessa [10...] 7.0.5           //§
         mm2 :=  a_getReaa (10011,Edv.Sorc[jo].josa.Amm2);                                                               //§
         kpl :=  a_getIntg (10012,Edv.Sorc[jo].josa.lukumaara);                                                          //§
         pit :=  a_getReaa (10013,Edv.Sorc[jo].josa.pituus);                                                             //§
                                                               //,  MaxZ-pisteen muk. VAIN kun ko. j-osa =               //§
       //aoMaxZ := (OHJ=12) and (AlpAsti<0);                   //<  SORCJAn j-osa, muuten LOPPUUN.  -10.0.7              //§
         IF fIk3v  THEN clt := 20                              //<Ik3v peruslämpötilassa.                                //§
                   ELSE clt := a_getIntg (10014,Edv.Sorc[jo].Josa.Lampotila);                                            //§
qWrKoeF ('SRC ZaoJoh,,,,:');                                                                                             //§
         AnnaRX (OHJU, tyyp,mm2,pit,kpl,clt,  Rv,Xv, Rv0,Xv0, Rn,Xn, LxKer,Lx); //<''Lx.. pitää saada paluuarvo.         //§
                                                                                                                         //§
         if fIk3v                                                                                                        //§
         then begin aRs := Rv *pit*LxKer;                  aXs := Xv *pit*LxKer;  end                                    //§
         else begin aRs := (2*Rv +Rv0 +3*Rn) *pit*LxKer;   aXs := (2*Xv +Xv0 +3*Xn) *pit*LxKer;  end; //<EhkäSittenkin?  //§
                                                                                                                         //§
koS := 'SRC ZaoJoh END:';                                                                                                     //§
if fIk3v  then koS := koS +'(Ik3v):'                                                                                     //§
          else koS := koS +'(Ik1v):';                                                                                    //§
koS := koS +'VAR aRs=' +fRmrkt0(aRs,1,6) +' aXs=' +fRmrkt0(aXs,1,6);                                                     //§
qWrKoeF (koS);                                                                                                           //§
      end;//ZaoJoh                                                                                                       //§
//,,§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§       //§
//,,§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§       //§
//,,§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§       //§
                                         {procedure Tst;   VAR j :integer;  //=OK.                                       //§
                                             procedure Doo (OHJ :integer);   begin //Olisi sama kuin:  Trunc(OHJ/10) +1 .//§
                                                j := (OHJ DIV 10)*10 +1;  end; //<10,12,31,41,51 => 11,11,31,41,51:  Halutun src:n sisZ SijEdellä.
                                                if j<0  then ;                                                           //§
                                          begin Doo(10); Doo(10); Doo(12); Doo(31); Doo(41); Doo(51);  end;}             //§
      begin//LaskeSrcZ..............................................................................                     //§
                                          {aR := 1/2 +(1 / (3 + 1/0.45));     //< po. aR = 0.691489                      //§
                                           aR := 1/aR;                        //< po. aR = 1.4461538                     //§
                                           if aR<-1  then ;                                                              //§
                                           aR := 1/2 +(1 / (3 + 1/(1/4+1/5)));                                           //§
                                           if aR<-1  then ;                   //< po. aR = 0.691489                      //§
                                           aR := 1/aR;}                       //< po. aR = 1.4461538                     //§
           {aR := 0;                                        //<,,Nimittäjän arvokokeilua,,,,,,,,,,,,                     //§
            eRs := -1;  //Rsx := 1/qRs +(1 / (aR + 1/eRs));                                                              //§
            Rsx := 1 / (aR + 1/eRs);                        //<aR sa olla 0, eRs po.<>0 !!!!!!!!!!!!                     //§
            if Rsx>=-10  then beep;}                                                                                     //§
     {============================================================================================================       //§
      A)  NAPAoikosulussa Zs:n RINNALLE kytkeytyy systeemi, missä Zj:n sarjassa on MUIDEN Zs+Zj:n rinnakkaisvaikutus:    //§
          Puoligraafisesti:                                                                                              //§
             >---Zs1--------------------|     <= Zs1:n Zj1 kytkeytyy sarjaan rinnak.liittymien kanssa ja tämä sys-       //§
                 |---Zs2+Zj2---|---Zj1--|        teemi kytkeytyy Zs1:n rinnalle. Kuvassa Z alkaa vasYlhltä ja kään       //§
             >---|---Zs3+Zj3---|                 tyy 2.rvllä vaslle, missä rinnakkaiset liittymät.################       //§
                                                                                                                         //§
             Zs1---|---Zj1---|---Zs2+Zj2---|  <= Ylläoleva kuva voitaisiin esittää myös näin.                            //§
                   ^         |---Zs3+Zj3---|                                                                             //§
                   ^ =Oikos.piste  s =Liittymäosa  j =Liitt.johto-osa                                                    //§
                                                                                                                         //§
          eli:  1    1             1                      ,####################################                          //§
rv 1            - = --- + -----------------------         ,####################################                          //§
                Z   Zs1                 1                                     #################                          //§
   2                      Zj1 + -----------------------                       #################                          //§
                                   1         1                                #################                          //§
   3                            ------- + ------- + ...                    <<<################# <Tästä aloitetaan.       //§
                                Zs2+Zj2   Zs3+Zj3         '####################################                          //§
                                                          '####################################                          //§
                sar 1     2     3         4            5=viittaukset koodissa esim. (Kohta) §33 =rv 3 sar 3              //§
               '###########################################################################################'             //§
                     1) Lasketaan Za ... lisätään Zj1 jne.                                                               //§
                     2) Lasketaan lausekekokonaisuus ja otetaan siitä käänteisarvo 1/Z, eli                              //§
                Z = 1 / ( ...   ) .                       <<<#######################################                     //§
                                                                                                                         //§
      B)  PK:ssa kaikki Zs+Zj :t kytkeytyvät keskenään rinnan:                                                           //§
             >---Zs1------Zj1--|              <= Kukin Zs+Zj kytkeytyy lopussa (PK) rinnakkain kaikkien kanssa.          //§
                 |---Zs2+Zj2---|                                                                                         //§
             >---|---Zs3+Zj3---|                                                                                         //§
                                                                     !!!!!      Alussa Lopussa MaxZ:                     //§
            1/Z = 1/(Zs1+Zj1) +1/(Zs2+Zj2) +1/(Zs3...)               !!!!! Ik1v   10     11     12                       //§
            eli:  1      1         1         1                       !!!!! Ik3v   30     31    (32 =1.JKssa)             //§
                  - = ------- + ------- + -------                    !!!!! Ik3d   50     51     --                       //§
                  Z   Zs1+Zj1   Zs2+Zj2   Zs3+Zj3                    !!!!! Ik3th  40     41     --                       //§
                                                                                                                         //§
//,,##############################################################################################################       //§
//,,##############################################################################################################       //§
      :::::::::::::::::::::::::::::::: ######################################### :::::::::::::::::::::::::::::::::       //§
      ################################ Tämä koko LaskeSrcZ uusittu TÄYSIN 10.0.7 #################################       //§
      :::::::::::::::::::::::::::::::: ######################################### :::::::::::::::::::::::::::::::::}      //§
//VrtSVjZ;                                                                                                               //§
        Sorcja := {a_getIntg (10001,} edv.YLE.SorceCount.ArvoInt; //,,,,,,,,UUSITTU 10.0.4, ed.=ZaoSrc-enn1004.txt .#####//§
         Rsx := 0;  Xsx := 0;                                                                                            //§
         oRs := 0;  oXs := 0;                                                                                            //§
         oRj := 0;  oXj := 0;                                                                                            //§
         yRs := 0;  yXs := 0;  yZs := 0;  yDg := 0;                                                                      //§
         iRs := 0;  iXs := 0;                                                                                            //§
         iRj := 0;  iXj := 0;                                                                                            //§
       //uRs := 0;  uXs := 0;  uZs := 0;  uDg := 0; //<Ei olisi pakko, mutta helpottaa debuggauksen seurantaa.           //§
//,,##############################################################################################################       //§
//,,!!!!!!!!!!!!!!!!!!!!!!! OHJ: Ik1v=10,11,12maxZ  Ik3v=30,31  Ik3th=40,41  Ik3d=50,51  <=Alussa,Lopussa,maxZ:ssa.      //§
//,,##############################################################################################################       //§
//,,#################### Tätä LaskeSrcZ kutsutaan VAIN LIITTYMIEN + SEN JOHTOJEN Z laskemsksi.####################       //§
//,,#################### =Ei tarvetta laskea jäljempiä johto-osia => Max = 0 #####################################       //§
//,,##############################################################################################################       //§
//,,####################### No>0  =Ziks_ pyytää Zsrc +Zjohdn ALUSSA(napa)/LOPUSSA/MaxZ-kohdssa.###################       //§
//,,####################### No=0  =Ziks_ pyytää Zsrc +Zjohdn RINNAKKAIS(yhteis)ARVO PK:ssa. ######################       //§
//,,####################### AINA Ziks_ laskee MUUN OSAN Edvj:n Z-arvot.###########################################       //§
//,,##############################################################################################################       //§
//,,##############################################################################################################       //§
qWrKoeF ('SRC LaskeSrcZ alku,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,');     //§
{Tst;} j := OHJ; //<Siirrtty 1412.                                                                                       //§
      if JkUpsLsk >=0                              //<,+1412:  0 =JkUps Sorc´ssa  1 =Edkassa.                            //§
      then begin                                                                                                         //§
         ZaoSrc (asti,oRs,oXs);                    //,ZaoJoh oZj lisätään jälempnä srjaan joko muiden...ks. jälemp.      //§
                        ZaoFileen('Laske:  oRs=' +fRmrkt0(oRs,1,4) +' oXs=' +fRmrkt0(oXs,1,5));                          //§
         yRs := oRs;  yXs := oXs;                  //<+1412 £$£yy                                                        //§
         if oRs<0  then ;  end                                                                                           //§
      else                                                                                                               //§
      for i := 1 to Sorcja  do //,No=SorceNo  //,,OHJ=12 => ZaoJoh sijoittaa oZj:hin MaxZ -arvon.############            //§
      if (i=No)  OR (No=0) and (i=1)               //<Src[No>0] tai Src[1].  No=[0,1..5], 5=MaxSrcLkm.############       //§
      then begin                //<,,===== TARKASTELTAVAN [No]LIITTYMÄN Z-kompontit.##############################       //§
         ZaoSrc (i,oRs,oXs);                       //,ZaoJoh oZj lisätään jälempnä srjaan joko muiden...ks. jälemp.      //§
         j := OHJ;                                                                                                       //§
         if AlpAsti>=0  then                       //,j=12 vain kun AlpAsti<0, muulloin OHJataan 11,31,41,51=Loppuun.    //§
            j := (OHJ DIV 10)*10 +1;               //<10,12,31,41,51 => 11,11,31,41,51:  Halutun src:n sisZ SijEdellä.   //§
                                                   //'31,41,51 Jäävät ennalleen 141.1                                    //§
         ZaoJoh (j ,i,oRj,oXj);           //½koS := koS +'  LaskeSrcZ A:  No=' +Ints(No) +' j='+Ints(j) +' i='+Ints(i) +'  oRs=' +strRjX (oRs,oXs) +'  oRj=' +strRjX (oRj,oXj);  WrKoeF (koS);  koS := '';
      end                                                                                                                //§
      else begin                //<,,===== VIEREISTEN LIITTYMIEN Zs+Zj-kompont, summaus yhteisZ:aan jälempnä.##########  //§
         ZaoSrc (  i, iRs,iXs);                    //<Liittymän Z.                                                       //§
       //j := (OHJ DIV 10)*10 +1;                  //<10,12,31,41,51 => 11,11,31,41,51:  Halutun src:n sisZ SijEdellä.   //§
         if OHJ IN [10,12]      //31,41,51 Jäävät ennalleen 141.1                                                        //§
            then j := 11;                                                                                                //§
         ZaoJoh (j,i, iRj,iXj);                    //<Liittymän JohZ, huomioi OHJ-arvon (11,11,31,41,51), ks. edRv.      //§
{o,,=OHJ,,,,,,,,,,,,,,,,,//,,===== Muunnetaan lisättävän rinnakkLiittZ:n POLAARIarvot ja otetaan käänteisarvo 1/Z.}      //§
{o33,34} uZs := fZ_rx (iRs+iRj, iXs+iXj, uDg);     //<fZ_rx palauttaa:  Z := Sqrt() ja palauttaa uDg := arcTang(X/R).    //§
         uZs := 1/uZs;                                                                                                   //§
         yRs := yRs +uZs *cosi(uDg);               //<,Polarimuotoinen käänteinen osaZ takas kompon.muotoon joten        //§
         yXs := yXs +uZs *sini(uDg);               //  nyt taas summattava komponentteina.                               //§
         yZs := fZ_rx (yRs,yXs, yDg);              //<Muuttui juuri, lasketaan nyt uusiksi: yRs,yXs tarvitaan kohta.     //§
                     //################# TÄHÄN tultaessa yZs jo käänteisenä (yZs = 1/yZs).#############################  //§
                           {½koS := koS +'  LaskeSrcZ B:       j='+Ints(j) +' i='+Ints(i) +'  iRs=' +strRjX (iRs,iXs) +  //§
                           '  iRj=' +strRjX (iRj,iXj);  WrKoeF (koS);  koS := '';              //<'##### KOEAJOA #####}  //§
      end;//for i :=.. if..else                                                                                          //§
      //,,,,,,,,NAPAOIKOSULKU: Johdn Zj SARJAAN yhdessä muiden KESKENÄÄN RINNAKKAIN olevien liit- ###################### //§
      //,,,,,,,,tymien kanssa.  Laskenta 1/Z = 1/Z1 +.. 1/Zn ja lopuksi käännetään takas Z = 1/Z .###################### //§
      //        >--ooX--Zj---|---Zj--oo--<  =Tarkastelupiste X(napaIk), oikealta tulee toinen liittymä.                  //§
   if JkUpsLsk <0  then begin //<+1412 ##################################################################################//§
      if (OHJ in [10,30,40,50]) and (AlpAsti<=0) //< and (AlpAsti<=0 =+12.0.0: NapaIk tarvitaan VAIN LIITTYMÄSARAKKssa.  //§
      then begin                              //'AlpAsti>0 kutsuja vain 10.INC/PRC LaskeLrj/FNC ToisastPOS, eikä näkö-   //§
{C1:====}if yZs>0  then                       // jään vaikuta RjPituuksiin oli tämä ehto eli ei, KOKLATTU.#############  //§
{o23:}      yZs := 1/yZs;                     //<KÄÄNNETÄÄN TAKAISIN NORM. "tasolle" oZj:n kanssa. Estettävä 1/0.        //§
         yRs := yZs *cosi(yDg);               //,Jos yZs=0, on myös yDg=0 (alustusarvo).                                 //§
         yXs := yZs *sini(yDg);               //<,Polarimuotoinen käänteinen osaZ takas kompon.muotoon summattavaksi.    //§
                                                                                                                         //§
{o22:}   if Sorcja>1  then begin              //<,Lisätään tarkasteltavan Src:n JOHTO-OSAN oZj SARJAAN muiden src´ien    //§
            yRs := yRs +oRj;                  //  (rinnakkais)yZs:n kanssa.                                              //§
            yXs := yXs +oXj;                                                                                             //§
            yZs := fZ_rx (yRs,yXs, yDg);      //<1/yZs jakolaskua varten polarimuotoiseksi.                              //§
            if yZs>0  then                    //<Jos =0 => yDg 0 ja cosi yms := 0, OK.                                   //§
{o12:}        yZs := 1/yZs;                                                                                              //§
            yRs := yZs *cosi(yDg);            //<,Komponenteiksi summausta varten.                                       //§
            yXs := yZs *sini(yDg);                                                                                       //§
         end;                             //,,,,,Kytketään em:n rinnakkaisten Zsrc:n rinnalle haluttu Zsrc ilman johtoa. //§
{o11:}   uZs := fZ_rx (oRs,oXs, uDg);         //<1/uZs jakolaskua varten polarimuotoiseksi ja sille kulma uDg.           //§
         if uZs>0  then                                                                                                  //§
            uZs := 1/uZs;                                                                                                //§
         oRs := uZs *cosi(uDg);               //<,Komponenteiksi summausta varten.                                       //§
         oXs := uZs *sini(uDg);                                                                                          //§
                                                                                                                         //§
{o01:}   yZs := fZ_rx (yRs+oRs,yXs+oXs, yDg);    //<'1/uZs +1/yZs =rinnankytkentä navoissa.############################  //§
koS := 'SRC LaskeSrcZ NapaIk    : yRs:' +fRmrkt0(yRs+oRs,1,6) +' yXs:' +fRmrkt0(yXs+oXs,1,6) +' yZs:' +fRmrkt0(yZs,1,6); //§
                                                 //½koS := 'LaskeSrcZ C1/2: Nap 10_50      ';                            //§
      end else//''Oli Zk napaoikosulkutapaus''.                                                                          //§
      begin   //,,,,,,,,,,,KAIKKI liittymät johtoineen rinnakkain keskenään PK asti. ##################################  //§
              //        >--oo--Zj---X---Zj--oo--<  =Tarkastelupiste X(PK), oikealta tulee toinen liittymä.               //§
{C2:====}uRs := oRs+oRj;                         //Jos OHJ=12 on ZaoJoh sijoittanut oZj:hin MaxZ -arvon. ##############  //§
         uXs := oXs+oXj;                         //<'Näitä ei oltu vielä käännetty kuten yRs,Yxs.                        //§
         uZs := fZ_rx (uRs,uXs, uDg);            //<uDg vain syntaxin takia, sitä ei tarvita enää.                       //§
         if uZs>0  then                                                                                                  //§
            uZs := 1/uZs;                        //<Käänteisarvo samalle "tasolle" yZs :n kanssa.                        //§
         uRs := uZs *cosi(uDg);                  //,Jos yZs=0, on myös yDg=0 (alustusarvo).                              //§
         uXs := uZs *sini(uDg);                  //<,Polarimuotoinen käänteinen osaZ takas kompon.muotoon joten          //§
         yRs := yRs+uRs;                         //  summattavissa.                                                      //§
         yXs := yXs+uXs;                                                                                                 //§
         yZs := fZ_rx (yRs,yXs, yDg);            //½koS := 'LaskeSrcZ C2/2: 11,12_51       ';                            //§
//£$ koS := 'SRC LaskeSrcZ EiNapaIk  : yRs:' +fRmrkt0(yRs+oRs,1,6) +' yXs:' +fRmrkt0(yXs+oXs,1,6) +' yZs:' +fRmrkt0(yZs,1,6); //§
      end;//if OHJ in ...                                                                                                //§
                                                                                                                         //§
      if yZs>0  then                                                                                                     //§
         yZs := 1/yZs;                           //<,LOPPUKÄÄNTEINEN 1/Z: =Loppusijoitukset.                             //§
      yRs := yZs *cosi(yDg);                     //,Polarimuotoinen käänteinen osaZ takas kompon.muotoon.                //§
      yXs := yZs *sini(yDg);              //,,,"Käsiarvoilla ajoa", kun Sorcja=3 á Zs=2+j3  Zj=5+j4 ============         //§
   end;//if JkUpsLsk <0  +1412.           //   uZs := 1/fZ_rx(2  ,3  ,uDg);                  //<,uDg=Z:n kulma.          //§
      Rsx := yRs;                         //   uRs := uZs*cosi(uDg);   uXs := uZs*sini(uDg); //<uZs komponMuodossa.      //§
      Xsx := yXs;                         // yZs := 1/fZ_rx(8.5,7.5,uDg);                                                //§
      Result := yZs;                      //   oRs := yZs*cosi(uDg);   oXs := yZs*sini(uDg);                             //§
                                          //   uRs := uRs +oRs;        uXs := uXs +oXs;                                  //§
qWrKoeF(koS);                                                                                                            //§
qWrKoeF('SRC LaskeSrcZ_9: Rsx:' +fRmrkt0(Rsx,1,6) +' Xsx:' +fRmrkt0(Xsx,1,6) +' yZs:' +fRmrkt0(yZs,1,6));                //§
                         //½koS := '';                                                     //<'##### KOEAJOA #####       //§
   end;//LaskeSrcZ                                                                                                       //§
//''§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§       //§
//''§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§       //§
//''§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§       //§
                                                                                                                         //§
   procedure kasvaEv_RX;      VAR uRv,uRv0,uRn, uXv,uXv0,uXn :real;      begin                                           //§
         uRv := 0;  uRv0 := 0;  uRn := 0;  uXv := 0;  uXv0 := 0;  uXn := 0;                                              //§
         if (tyyp<>'') and (mm2>0) and (pit>0) and (kpl>0)  then begin //<,Estettävä ettei "Err: Real div.by zero."      //§
            uRv :=  res    (tyyp,mm2);                                 //  PIT voisi olla, mutta näin sama tulos.        //§
            uRv :=  rTkorj (fAlCu (tyyp), uRv,clt) * pit / kpl;                                                          //§
            uRv0 := resVo  (tyyp,mm2);                                                                                   //§
            uRv0 := rTkorj (fAlCu(tyyp), uRv0,clt) * pit / kpl;                                                          //§
            uRn :=  resP   (tyyp,mm2);                                                                                   //§
            uRn :=  rTkorj (fPal (tyyp), uRn,clt)  * pit / kpl;                                                          //§
            uXv :=  Xv_ind  (tyyp,mm2) *pit/kpl;                                                                         //§
            uXv0 := Xv0_ind (tyyp,mm2) *pit/kpl;                                                                         //§
            uXn :=  Xp_ind  (tyyp,mm2) *pit/kpl;                                                                         //§
         end;                                                                                                            //§
         eRv :=  eRv  + uRv;                                                                                             //§
         eRv0 := eRv0 + uRv0;                                                                                            //§
         eRn :=  eRn  + uRn;                                                                                             //§
         eXv :=  eXv  + uXv;                                                                                             //§
         eXv0 := eXv0 + uXv0;                                                                                            //§
         eXn :=  eXn  + uXn;                                                                                             //§
   end;//kasvaEv_RX                                                                                                      //§
           { PEk=2      =Edvn PEker ei huomioida missään johdossa tai johto-osassa.                                      //§
             PEk >0..<1 =Kutsun PEk -arvoa käytetään kaikissa edvn johto-osilla VAKIOna.                                 //§
             PEk=0      =Edvn PEker huomioidaan edvssa syötettyjen arvojen mukaisina ko. johto-osassa.}                  //§
   function fPEk (os :integer) :real;      VAR pa :real;      begin                                                      //§
      result := 1;             //<,+6.2.2                                                                                //§
      if os>=1  then begin     //<if.. =Jos vaikka kutsussa os=0.  +6.2.2                                                //§
         if edv.edka[os].PEker.OnArvo  then pa := a_getReaa (10010,edv.edka[os].PEker) //<Turha, varm. vuoksi            //§
                                       else pa := 1;                                                                     //§
         if PEk>1.1   then result := 1  else//< PEk =2    =Lasket.KAIKKIj.osat ILMAN PE:nOHITUSTA -> PEk := 1            //§
         if PEk<0.001 then result := pa     //< PEk =0    =Lasket.ko. j.osan PEker :lla           -> PEk := [].PEker     //§
                      else result := PEk;   //< PEK >0..<1=Lasket.KAIKKIj.osatKutsun vakioPEk:lla -> PEk := PEk          //§
       end;                                                                                                              //§
    end;                                                                                                                 //§
                                                                                                                         //§
   procedure LasSijLaakMu (mP :real;  VAR Rm,Xm :real);            //Lääkintätilan muuntaja, mP[kVA].   §u§ +8.0.7       //§
                                                                                                                         //§
         procedure sij (mPn,Ur,Ux :real);      VAR Uo :real;      begin                                                  //§
            Uo := 230;                     //Rm = (Ur/100) x (Uo²/Sm) => Rm = (2.881/100) x (0.23²/3.5) = 0.000435 ohm.  //§
            Rm := (Ur/100) * (Sqr(Uo/1000)/mPn);                                                                         //§
            Xm := (Ux/100) * (Sqr(Uo/1000)/mPn);                                                                         //§
            Rm := Rm*3;                    //01.INC/asMparam_ R := 2*Rm + Rmo                                            //§
            Xm := Xm*3;                                                                                                  //§
            Rm := Rm *mPn/mP;              //<,Lopullinen kompon. arvo suhteessa tehoon: Nimellisraja-arvoa mPn pie-     //§
            Xm := Xm *mPn/mP;              //  nemmässä muuntajassa on isommat kompon.arvot.                             //§
         end;//sij                                                                                                       //§
        {procedure koeLasMparam;      VAR Rmo,Xmo :real;  n :integer;      begin                                         //§
            asMparam_ (mP,1,75, Rm,Rmo,Xm,Xmo, n);                                                                       //§
                                                                                                                         //§
            Rm := 2*Rm +Rmo;                                                                                             //§
            Xm := 2*Xm +Xmo;  end;//                                                                                     //§}
                                                      //,,Uudet > v.2009:                                                //§
   begin//LasSijLaakMu............................    //Kiviniemi 9.12.2014:  Käämit Al(2009..)                          //§
                                                      //          r     x     z         75°C Täysteholla.                //§
      if mP<=4.0  then sij (3.5,  2.51, 1.38)  else   //< 3.5 kVA 2,51  1,38  2,9       2kVA ei koestettu                //§
      if mP<=6.0  then sij (5.5,  1.95, 1.21)  else   //< 5.5 kVA 1,95  1,21  2,3       'ei käytetty enää.               //§
                       sij (7.5,  1.85, 1.38);        //< 7.5 kVA 1,85  1,38  2,3                                        //§
                                                      //,,Vanhat <=2009:                                                 //§
    { //,,Lopullinen arvo lasketaan suhteessa mP:hen. //            r(100°C) x        z                                  //§
      if mP<=2.5  then sij (2.0,  2.372, 0.259)  else //< 2.0 kVA   2.372    0.259    2.386                              //§
      if mP<=4.0  then sij (3.5,  2.881, 1.394)  else //< 3.5 kVA   2.881    1.394    3.2                                //§
      if mP<=6.0  then sij (5.5,  2.59 , 1.238)  else //< 5.5 kVA   2.59     3.2      2.876                              //§
                       sij (7.5,  2.232, 0.508);      //< 7.5 kVA   2.232    0.508    2.289                              //§ }
    //koeLasMparam;                                   //''Ks. e-Mail Ilkka Kiviniemi /Muuntosähkö/Trafok tms. 24.5.06    //§
   end;//LasSijLaakMu                                 //''Muutokset 2009: Cu => Al (käämit), p: 020 7933 700.            //§
                                                                                                                         //§
 (*procedure EriFileen (si :string);      VAR {Lst :TStringList;  }ff :TextFile;  fn :string;   begin //141.1            //§
      fn := gAjoPath +'EriAjo_Ziks_a.txt';       //Kun esim. laskeRJpit´ssä BreakPoint jatääne tullan sieltä, saa-       //§
      AssignFile(ff,fn);                              //daan tässä tieto, mitä ja minkälaisia paramja on käytössä, jotta //§
      if fFileExists(fn)                              //voidaan päätellä esim. kinka voisi päätellä milloin sieltä tultu //§
         then Append(ff)                              //tänne.                                                           //§
         else Rewrite(ff);                            //<Kumma:  Aina tänne mutta kuitenkin kasvattaa fileenrivejä .     //§
      si := DateTimeToStr(Now) +'  ' +si;                                                                                //§
      Writeln(ff,si);                                                                                                    //§
      Flush(ff);                                                                                                         //§
      CloseFile(ff);                                                                                                     //§
     {if fFileExists(fn)  then begin                  //voidaan päätellä esim. kinka voisi päätellä milloin sieltä tultu //§
         Lst := TStringList.Create;                                                                                      //§
         Lst.LoadFromFile(fn);                                                                                           //§
         Lst.Add(si);                                                                                                    //§
         Lst.SaveToFile(fn);                                                                                             //§
         Lst.free;                                                                                                       //§
      end;                                                                                                               //§}
   end;                                                                                                                  //§*)
{FUNCTION Ziks_a(OHJ :Integer;  asti :Integer;  PEk :real;  NJkin :boolean; //<,FNC = KOKON.Zk: YhtOhm. Uusitt 6.2.2     //§
                TIM :real;  QJtyp :string;  QJmm2,QJpit,muP :real;  QJkpl,QJlampot :integer;       //§u§ mu_=+8.0.7      //§
                VAR  Rsz,Xsz,LszKer,Lsz :real) :Real;      //<LszKer=Kerrottuna yhden kaapln Rv..yms. antaa              //§
                //'TIM merkitystä vain kun 40 tai 41        'maxZ:n arvot.### Lsz=MaxZ -pisteen etäisyys alusta.         //§
                //'tai kun GENER.LIITTYMÄ.                   muP=LääkMuuntajan teho[kVA].                                //§
                                                           //####'''''''AINA MaxZ-etäis.###############  <''Tähän+12.0.0}//§
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////§
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////§
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////§
//FUNCTION Ziks_a(OHJ :Integer;  asti :Integer;  PEk :real;  NJkin :boolean; //<,FNC = KOKON.Zk: YhtOhm. Uusitt 6.2.2    //§
//               TIM :real;  QJtyp :string;  QJmm2,QJpit,muP :real;  QJkpl,QJlampot :integer;       //§u§ mu_=+8.0.7     //§
//               VAR  Rsz,Xsz,LszKer,Lsz :real) :Real;      //<LszKer=Kerrottuna yhden kaapln Rv..yms. antaa             //§
//               //'TIM merkitystä vain kun 40 tai 41        'maxZ:n arvot.### Lsz=MaxZ -pisteen etäisyys alusta.        //§
//               //'tai kun GENER.LIITTYMÄ.                   muP=LääkMuuntajan teho[kVA].                               //§
//                                                          //####'''''''AINA MaxZ-etäis.###############                 //§
BEGIN//Ziks_a.......................................................................................                    //§§
                                  {EriFileen('OHJ=' +fImrkt0(OHJ,3) +' Asti=' +fImrkt0(asti,2) +' Tim=' +fRmrkt0(Tim,4,1) +' Qjtyp=' +Qjtyp +' QJmm2=' +fRmrkt0(QJmm2,1,1) +
                                             ' QJpit=' +fRmrkt0(QJpit,1,1) +' muP=' +fRmrkt0(muP,1,1) +' QJkpl=' +Ints(QJkpl) +' QJlt=' +Ints(QJlampot));}
                                   //,,Kun JkUpsLsk>=0, ei tarvita/haeta mitään johtotietoja, vain JkUps´in oRs,oXs.    //§§
JkUpsLsk := -1;                    //<+141.1:  JkUPS-Pistorasiahaaran laskenta:  -1=EiJkUps´ia  0=Sorcessa  1=Edka´ssa. //§§
if OHJ>1000  then  begin           //<+141.1:  Jotta kutsupaikka ja PistorRjPitLaskenta tunnistuu = JkUpsLsk saa TR/FA. //§§
   OHJ := OHJ-1000;                                                                                                     //§§
   JkUpsLsk := 1;  end             //< 1 =JkUps -haara Edka´ssa.                                                        //§§
else if OHJ>100  then begin                                                                                             //§§
   OHJ := OHJ-100;                                                                                                      //§§
   JkUpsLsk := 0;  end;            //< 0 =JkUps -haara Sorc´essa.  1 ja 0 -tapauksissa haetaan vain JkUpsin Ik,Cos -tiedot.//§§
                                   //¿DefsFileenZ('10.INC/Ziks_a: 1: ohj:' +Ints(ohj) + ' asti:' +Ints(asti));              //§§
            if {IsDebuggerPresent and }NOT (OHJ IN [10,11,12,30,31,32,40,41,50,51])  then                               //§§
               InfoDlg ('Nola10.INC/PRC Ziks_ :  OHJ=' +IntToStr (OHJ) +' ei ole.!!!!!!!!. Ziks_ palauttamat '+         //§§
                        'arvot ovat arvaamattomia! Ota nämä tiedot ylös (maalaa/kopioi) ja ilmoita ohjelman '+          //§§
                        'valmistajalle.',  mtWarning,  'OK','','','',  '','','','');                                    //§§
AlpAsti := asti;                     //<AnnaRX yms varten.  BreakPoint:  (QJmm2=1) or (QJmm2=2)                         //§§
if (asti=0) then case OHJ of         //<Jos osoitus on pääkeskuksen eteen ja toiminthttp://www.gonzoxxxmovies.com/out/?l=YTo5OntzOjE6ImMiO2k6MTtzOjM6InNpZCI7aTo4NDtzOjM6ImlpZCI7aToxO3M6MjoiaXQiO3M6MjoidGMiO3M6MzoiZ2lkIjtzOjg6Ijg5MjI1NjA2IjtzOjQ6Imt3aWQiO2k6MTM4ODA7czo0OiJjc2lkIjtzOjM6IjU2MSI7czozOiJwb3MiO2k6MTtzOjI6InJzIjtpOjExO30=&u=http://www.katestube.com/videos/26207/incredible-czech-babe-katka-paid-for-sex/?utm_source=donnie&utm_medium=cpc&utm_campaign=katesaOHJe on laskea Zik                 //§§
                10 :OHJ := 11;       // johdon alkuun, muutetaan OHJe laskea loppuun koska alkuun voidaan               //§§
                30 :OHJ := 31;       // laskea vain, jos tiedetään, mikä Sorcehaara. ASTI=0 vain jos                    //§§
                40 :OHJ := 41;       // osoitetaan laskentapiste alkuun esim. ASTI-1 kun ASTI=1.                        //§§
                50 :OHJ := 51;  end; //<'Vois olla:  OHJ+1                                                              //§§
qWrKoeF('Ziks_a   0: OH=' +Ints(OHJ) +' asti='+ Ints(asti));                                                            //§§
                                                                                                                        //§§
fIk3v := OHJ>=30;                         //<Kun halutaan jokin Zk3v -versio = EI Zk1v -versio.                         //§§
eRs := 0;   eRv := 0;   eRv0 := 0;   eRn := 0;                                                                          //§§
eXs := 0;   eXv := 0;   eXv0 := 0;   eXn := 0;                                                                          //§§
Rv :=  0;   Rv0 := 0;   Rn :=   0;                                                                                      //§§
Xv :=  0;   Xv0 := 0;   Xn :=   0;   pit := 0; //<Pit := 0  XP:ssä "Invalid floating..." FNC sys_ker :ssa  +6.2.3       //§§
LszKer_E := 0;   Lsz_E := 0;    PEqq := 1;     //<PEqq :+11.0.1                                                         //§§
LszKer_U := 0;   Lsz_U := 0;                                                                                            //§§
tyyp := '';                                                              //<Siirto lopummasta tähän 11.0.1              //§§
eja := a_getIntg (10015, edv.YLE.JohtoOsia);                                                                            //§§
IF NJkin     THEN if edNo>0  then asti := edNo-1 //<Varm.vuoksi +3.0.3  4.0.0, if edNo>0 +6.2.2!!!!! -6.2.21            //§§
                             else asti := edNo;                                                                         //§§
IF asti>eja  THEN asti := eja;            //<Varm.vuoksi +3.0.3, Nyt jos NJkin, asti=edNo kutsussa                      //§§
IF NJkin  THEN edel := asti               //<Edvn ko. kohta, NJ:n alkupiste. <<<<<<<<<<<<<<<<<<<<<< 4.0.0               //§§
          ELSE edel := asti-1;            //<Jos<0 eiVäliä=eiMennäSinne. ViimJohto-osaKäsitJälempnä -6.0.2              //§§
                           ///////,"Ziks_ 0:" EI SAA MUUTTAA: EI TULOSTU FILEEN: vrtluStringi.####################      //§§
                          {½koS := 'Ziks_ 0:  OHJ='+Ints(OHJ)+' AlpAsti='+Ints(AlpAsti)+' asti='+Ints(asti)+            //§§
                                   ' SrcNno=' +Ints(Abs(asti)) +'  edel=' +Ints(edel) +   //<''##### KOEAJOA #####      //§§
                                   '  SORCJA=' +Ints(edv.YLE.SorceCount.arvoInt);         //<''##### KOEAJOA #####      //§§
                           WrKoeF (koS);  koS := '';                                      //<''##### KOEAJOA #####}     //§§
qWrKoeF ('Ziks_a   1: asti=' +Ints(asti) +' edel=' +Ints(edel));                                                        //§§
if (asti<=0) and NOT NJkin //<,Pelkän liittymäosien laskentaan, ks. ELSE´n jälk. NOT NJkin=NJlaskenta AINA ELSE´een     //§§
then SrcNo := Abs (asti)                                        //  0=Rinnakkaisliittymien yhteis/rinnakkaisimped.      //§§
else begin//____________________________________________________//  PK:ssa =Edv[1] :n alussa oleva Ziks_._________      //§§
   SrcNo := 0;   asti := Abs (asti);                  //<Liittymäosan huomioimiseen Edv:n eteen yhteisimpedanssina.     //§§
//__________________________LASKetaan ASTI -j-osaa EDELTÄVÄn verkon arvot,johon myöh. lisätään liittymä___________      //§§
   IF fEmtyS (QJtyp)  then QJtyp := '';               //<Varm.vuoksi, jotta jälemmät testit OK:  IF QJtyp='' ...        //§§
   i := 0;  if NOT fIk3v  then i := 3;                        //<Ik1v :lle 3 = Lampotila annetun mukaan.                //§§
   eRv :=  edRv  (1,edel,i);                                  //<,Vain johto-osat, Sorce huomioidaan myöh.              //§§
   eRv0 := edRv0 (1,edel,i);                                                                                            //§§
   eXv :=  edXv  (1,edel);                                    //<ASTI edeltävä Xyht <<<<<<<<<<                          //§§
   eXv0:= edXv0  (1,edel);                                                                                              //§§
qWrKoeF('Ziks_a   2: eRv=' +fRmrkt0(eRv,1,6) +' eRv0=' +fRmrkt0(eRv0,1,6) +' eXv=' +fRmrkt0(eXv,1,6) +' eXv0=' +        //§§
       fRmrkt0(eXv0,1,6));                                                                                              //§§
   eRn := 0;  eXn := 0;                                                                                                 //§§
   PEkEkaJ := fPEkEkaJ;                   //< 0=PK:ssa,  -1=EiOo,  >0=Jäljempnä ko. JK:ssa                              //§§
   for j := 1 to edel  do                 //<############## ViimJohto-osa käsit erikseen jäljempnä ###############      //§§
      if (PEkEkaJ<>-1) and (j<PEkEkaJ)                                                                                  //§§
      then begin                                              //<,,Jos PT on johto-osan jäljessä, ei                    //§§
         eRn := eRn + 1.0  *edRn  (j,j,i);                    //   ohituskerroin PEker huomioida (=1.0)                 //§§
         eXn := eXn + 1.0  *edXn  (j,j);  end                                                                           //§§
      else begin                                                                                                        //§§
         PEqq := fPEk (j);                                                                                              //§§
         eRn := eRn + PEqq*edRn  (j,j,i);                                                                               //§§
         eXn := eXn + PEqq*edXn  (j,j);  end;                                                                           //§§
//__________________________ASETetaan ASTI -j-osan laskenta-arvot___________________________________                    //§§
                            //Tässä asetetaan TYYP...CLT PRC lisaaRvRn :n kutsua varten_____________                    //§§
   mm2 := 1;                                                          //<¤Delphi...might not..init..                    //§§
   clt := ctk;                                                        //<Vaikka pakkohan nämä ollaOK. -11.0.1           //§§
   pit := 0;    kpl := 0; //<KPL voi olla = 0, ks. lopussa ########## //<PIT voi olla koemielessä 0                     //§§
                          //'samoin TYYP, PIT jne. vrt. edka[0]       // mm. NOUSUketjun L t. edka[]                    //§§
//.............................................................                                                         //§§
   PEqq := 1;                                                         //<Jää voimaan jos NJkin tai NOT onArvot          //§§
   IF NJkin  THEN BEGIN                                                                                                 //§§
      tyyp := NJtyp;   mm2 := NJmm2;   kpl := NJkaapx;                                                                  //§§
      IF ohj=32 then pit := a_getReaa (10020,nj.jk[1].dL)             //<Ik3v NJn 1.JK :lle<<<<<<<<<                    //§§
                else for i := 1 to a_getIntg (10021,nj.jy.Ketjussa) do//<NJn LOPPUUN.                                   //§§
                              pit := pit + a_getReaa (10022,nj.jk[i].dL); //''####################''                    //§§
      IF fIk3v  THEN clt := 20                                        //<Ik3v peruslämpötilassa <<<<                    //§§
                ELSE clt := a_getIntg (10023,nj.jy.Tk1v);                                                               //§§
   END //<if NJkin                                                                                                      //§§
   ELSE IF (asti>0) AND edv.edka[asti].OnArvot  //<Vikan edj L ym. Voi olla < 0, esi, os-1 ??? #####                    //§§
   THEN WITH edv.edka[asti]  DO BEGIN                                                                                   //§§
      tyyp := a_getStrg (10022,tyyppi);      mm2 := a_getReaa (10023,Amm2);                                             //§§
      kpl :=  a_getIntg (10024,lukumaara);   pit := a_getReaa (10025,pituus);                                           //§§
      IF fIk3v  THEN clt := 20                                 //<Ik3v peruslämpötilassa <<<<                           //§§
                ELSE clt := a_getIntg (10026,lampotila);                                                                //§§
      PEqq := fPEk (asti);                                                                                              //§§
   END;                                                                                                                 //§§
{<½1 .. ½2 kommenttiväli siirretty tästä "if asti<=0 else" lauseosan jälkeen:  QJ ohittui         11.0.1                //§§
 moottorilähtöjen Uk -laskennassa, ks. Moot.INC/fUkmoS, muualla oli OK.##########################################}      //§§
end;//if asti<=0 else ____________________________________________________________________________________________      //§§
//½1________________________LASKetaan [ASTI] johdon arvot SEKÄ ASETET. QJn param._________________________________      //§§
//__________________________Metrikohtaiset resistanssit edka[asti]__________________________________                    //§§
//__________________________NJ tai QJ :lle myöhempään käsittelyyn___________________________________                    //§§
   if QJtyp<>''  THEN BEGIN //<edka[asti] ##########################################################                    //§§
      kasvaEv_RX;           //<Kasvatetaan tähänastiset muuttujiin eRv...eXv0, jotta tyyp ... pit yms. käytettävissä.   //§§
      tyyp := QJtyp;   mm2 := QJmm2;   pit := QJpit;   kpl := QJkpl;   clt := QJlampot;                                 //§§
   END;                                                                                                                 //§§
qWrKoeF('Ziks_a   3: typ=' +tyyp +' mm2=' +fRmrkt0(mm2,1,1) +' pit=' +fRmrkt0(pit,1,1) +' kpl=' +Ints(kpl) +' T°=' +Ints(clt));
qWrKoeF('Ziks_a   3 => AnnaRx...');                                                                                     //§§
                                                                                                                        //§§
   if tyyp<>''  then //__________________________Tätä ei ellei ole tarve kutsua AnnaRX._____________                    //§§
      AnnaRX (OHJ, tyyp,mm2,pit,kpl,clt,  Rv,Xv, Rv0,Xv0, Rn,Xn, LszKer_E,Lsz_E);                                       //§§
                                                                                                                        //§§
   PEkEkaJ := fPEkEkaJ;                            //< 0=PK:ssa, -1=EiOo, >0=Jäljempnä ko. JK:ssa  +11.0.1              //§§
   IF NOT fOnSV (tyyp) AND NOT fIk3v  AND (kpl>0)   //<Ei SVjärjestelmille eikä Zk3v:lle.    Muutos 6.2.2               //§§
      and (PEkEkaJ<asti)  THEN BEGIN                //<asti=0 jos NOT MAXZ ja eka edj->RvRn =0 #####                    //§§
          Rn := Rn *PEqq;                           //<,PEker huomioidaan vain ekaPTn jälkeen ######                    //§§
          Xn := Xn *PEqq;                           //<'Näitä ei huomioida LIITTYMÄN JOHDOISSA.                         //§§
   END;//<''½1 .. ½2 kommenttiväli siirrtetty "if asti<=0 else" lauseosasta tähän 11.0.1==================''½1..½2}     //§§
//__________________________________________________________________________________________________                    //§§
//__________________________LISÄTään YLÄVERKKO + LIITTYMÄ tms.______________________________________                    //§§
   LaskeSrcZ (OHJ,SrcNo, eRs,eXs,LszKer_U,Lsz_U);   //<Siellä UPS-käsittely.########################                    //§§
   if JkUpsLsk >=0  then begin                      //<141.2:  JkUPS -haarassa eRs,eXs´ssa vain Ik1v,Cos                //§§
      LszKer_U := 1;  Lsz_U := 0;                   //<        ja MaxZ-kohdan paituus =0.                               //§§
   end;                                                                                                                 //§§
//eRs := 0; eXs := 0; //<Uk´n tarkistukseen:  Zs~Zpe jolloin uk~230V                                                    //§§
   if LszKer_E = 0  then begin                      //<,Jos edv:n laskennassa tuli arvo, on siellä laskettu             //§§
      LszKer_E := LszKer_U;   Lsz_E := Lsz_U;  end; //  johto-osa mukana, koska silloin SRC on sitä edellä.             //§§
//__________________________________________________________________________________________________                    //§§
//__________________________________________________________________________________________________                    //§§
//__________________________LASKetaan MinZ tai MaxZ_________________________________________________                    //§§
   //Rtot := 0;  Xtot := 0;                             //<141.1: Might not..                                           //§§
   IF NOT fIk3v  //<,,,,,,Ik1v,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,                    //§§
   THEN BEGIN                                                                                                           //§§
      sa := a_getStrg (10040,edv.YLE.PEN_PE);         //<Ei voida suoraan sij.kutsuun, koska VAR-palautus.              //§§
//    if NOT isUPSi_Z(asti,1{vaihe}, eRv,eXv)  then begin //<function isUPSi.. VAR qR,qX :real) :boolean;               //§§  +141.1: eRv..Sis koko Ik1vZ´t.
         if asti>0  then                              //<Asti>0 = ei lisätä napaoikos.tap:ssa.<',+6.0.3 +0=6.2.2        //§§
            PEN_PE_LenkkiOK (sa, eRn,eXn);            //<eRn,eXn kasvaa jos OK.                                         //§§
           eRv := 2*eRv +eRv0 +3*eRn;                 //<eRv =edv:n      Rk1v.  <,,10.0.7 jaettu osiin.                 //§§
           eXv := 2*eXv +eXv0 +3*eXn;                 //<     - " -      Xk1v                                           //§§
           Rv := (2*Rv  +Rv0  +3*Rn)*pit*LszKer_E;    //<Rv  =ko. johd:n Rk1v                                           //§§
              ar := Rn*pit;  ax := Xn*pit;                                                                              //§§
              if ar*ax<-999  then ;                   //<,,uk´n käsinlaskentaan: ar=Zp:  uk = 231*Zp/Zs +130.2e //§§    //§§
            //ar := Sqrt(Sqr(ar) +Sqr(ax)); //<'Näissä ei tarvita enää jakoa 3´lla.                                     //§§
           Xv := (2*Xv  +Xv0  +3*Xn)*pit*LszKer_E;    //<     - " -      Xk1v                                           //§§
         if JkUpsLsk >=0  then begin                  //<,+1412.                                                        //§§
            Rtot := eRs{=Liittymä};                                                                                     //§§
            Xtot := eXs{=Liittymä};  end                                                                                //§§
         else begin                                                                                                     //§§
            Rtot := eRs{=Liittymä} +eRv +Rv;             //<''Jaettu osiin erojen helpompaan havaitsemiseen debugissa.  //§§
            Xtot := eXs{=Liittymä} +eXv +Xv;                                                                            //§§
         end;                                                                                                           //§§
         if muP>0  then begin                         //<,,Lääkintätilan muuntaja, muP[kVA].   §u§ +8.0.7               //§§
            LasSijLaakMu (muP, eRv,eXv);                                                                                //§§
            Rtot := Rtot +eRv;                                                                                          //§§
            Xtot := Xtot +eXv;                                                                                          //§§
         end;//if muP>0                                                                                                 //§§
//    end;//NOT isUPSi_Z                                                                                                //§§
   END//NOT fIk3v =Ik1v                                                                                                 //§§
   ELSE BEGIN      //<,,,,,,Ik3v,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,                     //§§
//    if NOT isUPSi_Z(asti,1{vaihe}, eRv,eXv)  then begin //<function isUPSi.. VAR qR,qX :real) :boolean;               //§§  +141.1: eRv..Sis koko Ik1vZ´t.
         if OHJ MOD 10 =0  then begin                 //<,+12.0.0: J-osan alkuun laskettaessa, edRv() yms. on jo laske- //§§
            Rv := 0;  Xv := 0;  end;                  //           nut edJ´n loppuun eli tämän alkuun, joten ei saa kas-//§§
         Rv := Rv*pit*LszKer_E;                       //           vattaa enää =OLI VÄÄRIN AIKAISEMMIN.                 //§§
            Rtot := {Liittymä=}eRs +eRv +Rv;          //<Rs,Xs Ik3v :lle #######                                        //§§
         Xv := Xv*pit*LszKer_E;                                                                                         //§§
            Xtot := {Liittymä=}eXs +eXv +Xv;                                                                            //§§
                      //,,Nämä pitää huomioida myös VV-gener´lle, esim. Ik3d = n. 2 * V¨(2), =epäsymm + huippuarvo.     //§§
         case OHJ of  //,,Lasketaan Ik3th(t) ja Ik3d. Korjattu/huomioitu LaskeSrcZ:ssa, jotta nämä eivät vääristäisi.   //§§
            40,41 :begin  ar := fK3t (Rtot,Xtot,TIM, koS);       //<40,41 = Ik3th(t) VIRTAkerroin käännetään 1/ar       //§§
                          Rtot := Rtot/ar;                                                                              //§§
                          Xtot := Xtot/ar;                                                                              //§§
qWrKoeF(koS);      end;                                                                                                 //§§
            50,51 :begin  ar := fK3d (Rtot,Xtot, koS);           //<50,51 = Ik3d                                        //§§
                          Rtot := Rtot/ar;                                                                              //§§
                          Xtot := Xtot/ar;                       //<'Ik3d = Ik3v * Kappa * V¨(2);                       //§§
qWrKoeF(koS);      end; end;                                     //       = Uv / [Zk3v / (Kappa * V¨(2)];               //§§
//    END;                                                                                                              //§§
   end;                                                                                                                 //§§
   Rsz := Rtot;   Xsz := Xtot;              //<,Näin, jotta VAR param. KUTSUSSA VOISI OLLA (..ar,ar)                    //§§
   ar := Sqrt ( Sqr(Rtot) + Sqr(Xtot) );                                                                                //§§
   Result := ar;                                                                           //,,##### KOEAJOA #####      //§§
                      {½koS := 'Ziks_ 9: 3eRp=' +strRjX (3*eRn,3*eXn) +' eRv=' +strRjX (eRv,eXv) +                      //§§
                               ' Rv=' +strRjX (Rv,Xv) +' Rtot=' +strRjX (Rtot,Xtot) +' Ztot=' +fRmrkt0(ar,8,6);         //§§
                       WrKoeF (koS);  WrKoeF ('');                                         //<Tyhjä välirivi.}          //§§
//½koS := '';                               //<Putsattava, muuten Ziks_a:n alussa näkyy.                                //§§
   LszKer := LszKer_E;   Lsz := Lsz_E;                                                                                  //§§
qWrKoeF('Ziks_a   9: Rsz=' +fRmrkt0(Rsz,1,6) +' Xsz=' +fRmrkt0(Xsz,1,6) +' Zs=' +fRmrkt0(ar,1,6) +                      //§§
       ' LszK=' +fRmrkt0(LszKer,1,4) +' Lsz=' +fRmrkt0(Lsz,1,3));                                                       //§§
qWrKoeF('Ziks_a 99: ==============================================================================================================');
   if asti<-100  then SysUtils.beep;                                                                                    //§§
                                   //¿DefsFileenZ('10.INC/Ziks_a: 9: ohj:' +Ints(ohj) + ' asti:' +Ints(asti));              //§§
END;//FNC Ziks_a                                                                                                        //§§
{###################################################################################################################### //§§
§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§ //§§
§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§ //§§
§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§ //§§
§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§}//§§

FUNCTION Ziks_ (OHJ :Integer;  asti :Integer;  PEk :real;  NJkin :boolean;     //<,Ziks_´iin lisätty MUP, MUOH, ks.
               TIM :real;  QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer; //LaskeRjPit (LääkMuuntRj).
               VAR  Rsz,Xsz,LszKer,Lsz :real) :Real;      begin
   result := Ziks_a (OHJ,asti,PEk, NJkin, TIM,QJtyp, QJmm2,QJpit,0{muP}, QJkpl,QJlampot, Rsz,Xsz,LszKer,Lsz);
end;
//==================================================================================================
FUNCTION Ziks (ohj :Integer;  asti :Integer;  NJkin :boolean;  //<,Ziks = KOKONAISoikosImpedanssi: TodYhtOhm
               TIM :real;  QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer;
               VAR  Rsz,Xsz,LszKer,Lsz :real) :Real;              begin
   result := Ziks_ (ohj,asti, 0 ,NJkin, TIM,                   //< 0 =PEker huomioidaan ko. j.osan mukaan
                    QJtyp,QJmm2,QJpit,QJkpl,QJlampot,
                    Rsz,Xsz,LszKer,Lsz);   end;
//==================================================================================================
FUNCTION fZs (ohj :integer;  asti :Integer;  PEk :real;  NJkin :boolean;    //<=KOKONAISoikos MaxZk1v Impedanssi: YhtOhm
              QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer;  //'yhtälölle: Ik1v = 3*c*Uv/Ze
              VAR Rsz,Xsz,LszKer,Lsz :real) :Real;                          //'=KÄYTTÖ: ZsIa_OK, Zs ymv
      VAR Re,Xe, Rs,Xs :real;      BEGIN
   Ziks_ ({12}ohj,asti,PEk,NJkin,0, QJtyp,QJmm2,QJpit,QJkpl,QJlampot, Re,Xe,LszKer,Lsz); //<Ei oteta suoraan Ze ja /3
   Rs := Re/3;   Xs := Xe/3;                     //< Zse = Zs/3  ja  Zs = V¨(R²+X²)/3 = V¨[(R/3)²+(X/3)²] = V¨(R²/9+X²/9)
   Result := Sqrt ( Sqr(Rs) + Sqr(Xs) );         //Vrt: Ia = Uvo/Zs  ja  Ik1v = c Uv/(Ze/3)
END;//fZs                                        
//================================================================================================''Siirretty 6.0.0
//,,Palauttaa VAR -muuttujissa halutun kaapelin parametrit Rv,Rvo,Rn, Xv,Xvo,Xn ,,,,,,,,,,,,,,,,,,,,
   procedure Zkaap (typ :string;  mm2,pit :real;  clt :integer;   VAR Rv,Rvo,Rn, Xv,Xvo,Xn :real);  //< Rvo +6.0.2
        {VAR  Rsz,Xsz,LszKer,Lsz :Real;      }begin
      Rv := 0;  Rvo := 0;  Rn := 0;  Xv := 0;  Xvo := 0;  Xn := 0;
     {IF (tyyp='SVjärjest.') AND (ohj=1)               //<MaxZ -> MinIk1v, Muuten otetaan norm R....
      THEN BEGIN                                       //,Sis. KAIKKI RESISTANSSIT <<<<<<<<<<<<<<<<<
         IF mm2>1200  THEN Rv := rTkorj (fAlCu (tyyp), RmaxSV (3,mm2), clt)
                      ELSE Rv := rTkorj (fAlCu (tyyp), RmaxSV (3,mm2), clt);
         Xv := XmaxSV (3,mm2);  END                    //<Sis. KAIKKI REAKTANSSIT <<<<<<<<<<<<<<<<<<
      ELSE BEGIN                                       //'Jos a800mm2, Tmax=130°C muuten 160°C. Nyt clt}
         Rv :=  rTkorj (fAlCu (typ), resVo(typ,mm2), clt);
         Rvo := rTkorj (fAlCu (typ), res  (typ,mm2), clt);
         Rn :=  rTkorj (fPal  (typ), resP (typ,mm2), clt);
         Xv :=  Xv_ind  (typ,mm2);                     //<Jos 'S' muut jää 0:ksi, OK ###############
         Xvo := Xv0_ind (typ,mm2);
         Xn :=  Xp_ind  (typ,mm2);
     {END;}
   end;//Zkaap
//================================================================================================== ,+7.0.0
FUNCTION fZj (QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer): real; //JOHDON QJtyp.. QJpit imped Zekv.
      VAR Rv,Rvo,Rn, Xv,Xvo,Xn, Zj :real;      begin                              //<Yhtälölle: JOHDON Ik1v=c*Uv/fZj
   Rv :=  rTkorj (fAlCu (QJtyp), res  (QJtyp,QJmm2), QJlampot);                   //'=KÄYTTÖ:  Vain Det10.INC
   Rvo := rTkorj (fAlCu (QJtyp), resVo(QJtyp,QJmm2), QJlampot);                   //  ja ZpeOK (ja... <,,+10.0.4)
   Rn :=  rTkorj (fPal  (QJtyp), resP (QJtyp,QJmm2), QJlampot);
   Xv :=  Xv_ind  (QJtyp,QJmm2);
   Xvo := Xv0_ind (QJtyp,QJmm2);
   Xn :=  Xp_ind  (QJtyp,QJmm2);
   Zj := QJpit * Sqrt ( Sqr (2*Rv +Rvo +3*Rn) + Sqr (2*Xv +Xvo +3*Xn) ) / QJkpl /3; //< /3 =vrt. alkukommentti.!!!
   result := Zj;
end;//fZj
//==================================================================================================
                                                //0=EiKulTestiä, =1 KulSal ei väliä. Jos KulSal, KulTesti eiVäliä.
FUNCTION ZsIa_OK_ (ohj :integer;  suCs :string;  asti,KulTesti :Integer;  PEk :real;  NJkin,KulSal :Boolean;  Isu :Integer;  Tim :Real;
                   QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer) :Boolean; {+@}
VAR Ia,Zs,ar,Ua :Real;  //FNC Zs x Ia <=Uo. =======Tim tarvitVAIN IEC/OFAA varten'''''<<<<<<<<<<<<<<
BEGIN
   Result := TRUE;
   IF KulSal or (KulTesti=1)  THEN BEGIN
      Ia := Isnik (suCs,Isu,Tim);
      Zs := fZs (ohj,asti,PEk,NJkin, QJtyp,QJmm2,QJpit,QJkpl,QJlampot, ar,ar,ar,ar);
      Ua := fUo;
      if Zs * Ia > Ua
         THEN Result := FALSE;
   END;
END;//ZsIa_OK_
//==================================================================================================
FUNCTION ZsIa_OK (ohj :integer;  suCs :string;  asti :Integer;  PEk :real;  NJkin,KulSal :Boolean;  Isu :Integer;  Tim :Real;
                  QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer) :Boolean; {+@}
      BEGIN             //FNC Zs x Ia <=Uo. =======Tim tarvitVAIN IEC/OFAA varten'''''<<<<<<<<<<<<<<
   Result := ZsIa_OK_ (ohj,suCs,asti,1,PEk, NJkin,KulSal,Isu, Tim, QJtyp,QJmm2,QJpit,QJkpl,QJlampot);
END;//ZsIa_OK                // '1'=KULtesti huomioidaan <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//==================================================================================================
(*FUNCTION ZsIa_OKo (suCs :string;  asti :Integer;  PEk :real;  NJkin :Boolean;  Isu :Integer;  Tim :Real;
                   QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer) :Boolean; {+@}
      BEGIN             //FNC Zs x Ia <=Uo. =======Tim tarvitVAIN IEC/OFAA varten'''''<<<<<<<<<<<<<<
   Result := ZsIa_OK_ (suCs,asti,0,PEk, NJkin,FALSE{=EiVäliä},Isu, Tim, QJtyp,QJmm2,QJpit,QJkpl,QJlampot);
END;//ZsIa_OKo               // '0'=KULtestiä EI <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*)
//==================================================================================================
//==================================================================================================
                             //....,KulTesti=0 =EiKulTestiä jolloin KulSal eiVäliä <<<<<<<<<<<<<<<<<
FUNCTION fSu4_ (suCs :string;  asti,KulTesti :Integer;  PEk :real;  NJkin,KulSal :Boolean;  Isu :Integer; //<maxSul 0.4s :lle
                QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer;  VAR ylit :integer) :Integer;
      VAR ar,ik :Real;  su :Integer;      BEGIN                              //''Ylit=1, jos ZsIa vaikutti
   su := 1250; //1500; -2.0.1
   ik := iks (Ik3vFA, asti, Ziks_ (12,asti,PEk,NJkin,0.4, '',0,0,0,0, ar,ar,ar,ar));
           //EiMaxI'''-----maxZ'--------------------------------------------=Ik1v <<<<<<<<<<<<<<<<<<
   WHILE  (ik < Isnik (suCs,su,fPoiskAikaRaja))  AND (su >=6)
      DO pienIsul (su);
   ylit := 0;
   WHILE  NOT ZsIa_OK_ (12,suCs,asti,KulTesti,PEk, NJkin,KulSal, su, fPoiskAikaRaja, QJtyp,QJmm2,QJpit,QJkpl,QJlampot) AND (su>6)
      DO begin  ylit := 1;  pienIsul (su);  end; //''Tim, jota tässä juuri tutkitaan <<<<<<<<<<<<<<<
   Result := su;
END;//fSu4_
//==================================================================================================
FUNCTION fSu4 (suCs :string;  asti :Integer;  PEk :real;  NJkin,KulSal :Boolean;  Isu :Integer;   //<maxSul 0.4s :lle
               QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer;  VAR ylit :integer) :Integer;
      BEGIN                                                                  //''Ylit=1, jos ZsIa vaikutti
   Result := fSu4_ (suCs,asti,1,PEk, NJkin,KulSal, Isu, QJtyp,QJmm2,QJpit,QJkpl,QJlampot, ylit);
END;//fSu4                // '1'=KULtesti huomioidaan <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//==================================================================================================
FUNCTION fSu4o (suCs :string;  asti :Integer;  PEk :real;  NJkin :Boolean;  Isu :Integer;   //<maxSul 0.4s :lle
               QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer;  VAR ylit :integer) :Integer;
      BEGIN                                                                  //''Ylit=1, jos ZsIa vaikutti
   Result := fSu4_ (suCs,asti,0,PEk, NJkin,FALSE{=EiVäliä}, Isu, QJtyp,QJmm2,QJpit,QJkpl,QJlampot, ylit);
END;//fSu4o               // '0'=KULtestiä ei huomioida <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//==================================================================================================
//==================================================================================================
//,,,Lisätty DELPHIIN
//==================================================================================================
FUNCTION Ikatk_ZsIa (asti :Integer;  PEk :real;  NJkin :boolean) :Real;
     VAR fnc,ar,Iks1v :real;  i :integer;     BEGIN
  ar := fZs (12,asti,PEk,NJkin, '',0,0,0,0, ar,ar,ar,ar);
  if ar<=0  //<,,+6.0.2: Err: Divide by zero (kun UPS eRs=0 ja L=0m) =,,Lasketaan NJnä 0.001 m :llä.#############
  then begin//,FNC fZs (ohj,asti :Integer;  PEk :real;  NJkin :boolean; QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer;}
     ar := fZs (12,asti,PEk,NJkin, 'AXMK4',300,0.001,1,80, ar,ar,ar,ar); //141.1:  Oli: 'AMCMK4½',300,0.001,1,80, ar,ar,ar,ar);
     if ar<=0                               //<,,Ei kyllä enää pitäisi olla 0. Jos on, lasketaan liittymätietojen
     then begin                             //   perusteella:  Ik1v * Uo/(c Uv). JOS ar=0, asti p.o. <= 0 !!!!!!
        ar := a_getReaa (10041,edv.YLE.cU); //   ar=0 mahdollista myös UPsilla, JOS JOHTO-OSA 1:n L=0m.##########
        ar := ar*fUv;                       //''#################################################################
        if asti<=0  then begin              //<Sorc[0] eioo, sillekin pitää etsiä arvo >0.     //<,,+6.2.2
           asti := Abs (asti);
           for i := 1 to a_getIntg (10042, Edv.YLE.SorceCount)  do
              if {a_getIntg (10043,} Edv.Sorc[i].src.SorceKind.ArvoInt IN [2,4] //<2=LV-Cable  4=UPS, jolle ei hyväksytty rinnakk.liittymiä ja
                 then begin  asti := i;  Break;  end;                           // JohtohaaraUPSeja vain yksi vaikka JkUps_Ik1v,JkUps_Ik3v SIJOITTU KAIKKIIN.
        end;                                                                                   //<''+6.2.2
        Iks1v := a_getReaa (10033,Edv.Sorc[asti].src.Iks1v)*1000;
        fnc := Iks1v *fUo/ar;                           //<Liittymän Ik1v * Uo/(c Uv)
        Result := fnc;   end
     else Result := fUo / ar;  end
  else    Result := fUo / ar;
END;//Ikatk_ZsIa
//==================================================================================================
//==================================================================================================
//==================================================================================================
         //Uusi FNC Delphiin <- 61.INC/PRC wrkatk + NJkin lisätty + _Oiks + _Yv YHDISTETTY #########
         //Tähän vois lisätä QJ:n tiedot -> QJ:n katkaisija-asetuksiksi. Nyt ei tarvetta <<<<<<<<<<<
         //,,OIKOS=OikosSuojaus/YlivSuoj
         //,,RAAKA(OIKOS)=EI Iterm + ZsIa, (YLIV)=EI .8xIk1v + ZsIa  tarkistuksia.
         //,,YLITYS: +100=ZsIa   +10=Iterm   +1=0.8xIk1v.  Jos RAAKA, arvoksi jää 0 ################
         //...........................................ASTAP tarvitaan vain ,,,,, jos NOT OIKOS #####
function Ikatk_Aset (oikos,raaka :boolean;  os :Integer;  PEk :real;  NJkin :Boolean;  Qastap :Char;
                     VAR Ylitys :integer) :real;
      VAR ar, Ikat,Im,Iz,It :real;   ao,ylit :integer;
          tyyp :string;   mm2,korj,tim :real;   kplx :Integer;   Kul :Boolean;  rec :EdvPalstaType;

   procedure sij (Iarvo :real;  luku :integer);   begin  Ikat := Iarvo;   ylit := ylit + luku;  end;

BEGIN
   ao :=  Abs (os);
   if os<=0  then rec := edv.Sorc[ao].josa
             else rec := edv.Edka[ao];
   if NJkin  THEN BEGIN os := edmaxkpl;
                        tyyp := NJtyp;
                        mm2 :=  NJmm2;
                        kplx := NJkaapx;
                        korj := a_getReaa (10051, nj.jy.korjaus);
                        Kul :=  a_getBool (10052, nj.jy.NjKulSal);  END
             ELSE BEGIN
                        tyyp := a_getStrg (10053, rec.tyyppi);
                        mm2 :=  a_getReaa (10054, rec.Amm2);
                        kplx := a_getIntg (10055, rec.lukumaara);
                        korj := a_getReaa (10056, rec.korjaus);
                        Kul :=  a_getBool (10057, rec.kuluttaja);  END;
   IF Kul  then tim := a_getReaa (10054, edv.YLE.PoisAika) //<Aina alle 5s <<<<<< <- Redus AINA ???????????
           else tim := 5;                                  //<Kaapln 5s TermKesto
   Im := 0;
   IF oikos OR NOT raaka  then //<,Optimointia: Ei lasketa ellei tarvita ###########################
      Im := Ziks_ (12,os,PEk,NJkin,0, '',0,0,0,0, ar,ar,ar,ar);
      Im := 0.8 * iks (Ik3vFA, os, Im);
   IF oikos  then Ikat := Im
             else Ikat := YvSuoj (suCse,FALSE,TRUE,Qastap,korj,tyyp,mm2,kplx);

   ylit := 0;
   IF NOT raaka  THEN BEGIN
      Iz := Ikatk_ZsIa (os,PEk,NJkin);
      It := IksalTerm (tyyp,mm2);  //<JOKAISEN OSAJOHTIMEN KESTETTÄVÄ Ik -> EI It/kpl ##############
      It := It / Sqrt (tim);                         //<Ikmax=IkSal/V¨t(5s) <- Redus AINA ?????????????????
      IF (Iz<Ikat) and Kul        THEN sij (Iz,100); //'ja max.arvo=AINA YHDEN KPLn ARVO =EI It/kpl
      IF  It<Ikat                 THEN sij (It,10);  //,Jos OIKOS, Im=Ikat < mahd.sisäin.luvuntarkk.
    //IF (Im<Ikat) and NOT oikos  THEN sij (Im,1);   //<= Iy ei saa ylittää Img, mutta: ks. avuste r16
    //IF (Iy<Ikat) and oikos      THEN sij (Iy,1000);//<Iy ja Im pitäisSijoitt.AINA ,mutta:ks.avuste r16
   END;
   Ylitys := ylit;
   Result := Ikat;
END;//Ikatk_Aset
//==================================================================================================
//==================================================================================================
FUNCTION fSul_ZsIa (suCs :string;  os,alpNehSul :Integer;  PEk :real;  NJkin,KulSal :Boolean;  Tim :Real;
                    QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer) :Integer;
   VAR apuSul :Integer;                                       //''TÄMÄN KUTSU HIDASTAA RATKAISEVASTI
BEGIN
   apuSul := alpNehSul;
{FUNCTION ZsIa_OK (ohj :integer;  suC :Char;  asti :Integer;  NJkin,KulSal,IEC :Boolean;  Isu :Integer;  Tim :Real
                   QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer) :Boolean; =@}
   IF KulSal  THEN                                                     //<A2-94 ei koske SÄL<<<
      WHILE NOT ZsIa_OK (12,suCs,os,PEk,NJkin,KulSal, apuSul,tim, QJtyp,QJmm2,QJpit,QJkpl,QJlampot)
                DO pienIsul (apuSul);

   Result := apuSul;                                //<SijMyösSÄL
  {Result := alpNehSul;  //<SULKEMALLA MUUT vex, näkee NOP.ERON ####################################}
END;//fSul_ZsIa
//..................................................................................................
FUNCTION fSul_Neh (suCs :string;  Ik1v :real;  Tim :Real) :Integer;    VAR ai :Integer;  BEGIN //<Uusi FNC +2.0.1
   ai := 1250;                                 //<2.0.1:  1500 -> 1250
   WHILE (Ik1v < Isnik (suCse,ai,tim))  AND (ai >=6)
         DO pienIsul (ai);
   Result := ai;
END;//fSul_Neh
//..................................................................................................
FUNCTION fSul_Tot (ohj :integer;  suCs :string;  os :Integer;  PEk :real;  NJkin,KulSal :Boolean;  Tim :Real;
                   QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer) :Integer;
   VAR apuSul :Integer;  Ik1v,ar :real;                       //''TÄMÄN KUTSU HIDASTAA RATKAISEVASTI
BEGIN
              //Ik1v,,,........,,,Ks.Ziks,NJkin  ,0, '',0,.................. SYNTAXn TAKIA<<<<<<<<<<<<
   Ik1v := iks (Ik3vFA, os, Ziks_ (ohj,os,PEk,NJkinFA,0, '',0,0,0,0, ar,ar,ar,ar));
   apuSul := fSul_Neh (suCs,Ik1v,Tim);
   IF KulSal  THEN                                                        //<A2-94 ei koske SÄL<<<<<
   WHILE NOT ZsIa_OK_ (ohj,suCs,os,0,PEk, NJkin,KulSal,apuSul, tim, QJtyp,QJmm2,QJpit,QJkpl,QJlampot)
      DO pienIsul (apuSul);// '0'=KULtesti EI huomioida, ELLEI KulSal <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

   Result := apuSul;                                //<SijMyösSÄL
  {Result := alpNehSul;  //<SULKEMALLA MUUT vex, näkee NOP.ERON ####################################}
END;//fSul_Tot
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//=======================================================================================================================================================

//Jos RJMM2=0, etsitään MINA ISUL :lle->SULA.     ####  maxLrj=Max.rj:n pituus, jotta ISUL toimisi TIM
//Jos RJMM2>0, lasketaan rj :t 2.5(16A)/1.5(10A). ####  ajassa IKssa. Jos NJKIN, VIKAEVJ ei väliä <<
//eTyyp= ''    Halutaan laskea rj.
//eTyyp<>''    Tyyppi annettu kutsussa = Halutaan laskea Edvj :n  resursseja.
PROCEDURE laskeRJpit (loc :string;  NJkin :Boolean;  vikaEvj,Isul,ct :Integer;  Tim,rjmm2,muP :Real;
                      eKpl :integer;  eTyyp,suCs :string;  tapa :string;
                      VAR minA,maxLrj,maxLrj_zpe :Real;  VAR sulA,TUP :Integer);
   LABEL 1;   VAR _mm2,Qmm2 :Real; //<_mm2 korvaa rjmm2:n (debuggeri nyt näkee arvon), Q...=Pääjohdon PERÄÄN tulevan johdon suure.
                  sulQ,P_yli :Integer;   Kul, T_yli,U_yli,boo :Boolean;
                  Jtyp :string;  Jmm2,Jpit{,kR} :Real;  Jkpl,Jct,{i,}no :integer;
{###################################################################################################
 Karkeasti esim.  MCMK 1,5 Rv20=12.1 ohm/km  2,5 Rv20=7.41 ohm/km,   Kta = R20 (1 + Kcu(Ta-20),
                  10A 0.4s = 82A   16A 0,4s = 110A                   Kcu=0.00393 -> Kta50° = 1.1179
                  L=U/2rI:   10A 0.4s: Lmax=230/(2*12.1*1.1179/1000 * 82) = 103.68 m
                             16A 0.4s: Lmax=230/(2*7.41*1.1179/1000 *110) = 126.21 m
####################################################################################################}
//..........................................
PROCEDURE tutPE_OK (asti :Integer;  NJkin :Boolean;  {+9.0.1:}VAR RJmaxLzpe :real);
      VAR okStr,jalessaStr :string;   fnc :boolean;   {eka,}seur: integer;      BEGIN
 //fnc := ZpeOK (asti,1,NJkin, '',0,0,0,0, okStr,jalessaStr);                        //<-9.0.1
   fnc := ZpeOK (asti,1,NJkin, Jtyp,Jmm2,Jpit,Jkpl,Jct, okStr,jalessaStr,RJmaxLzpe); //<+9.0.1  +Jtyp ym...  1=PEk
 //eka := fJKno (1,okStr);             //<Ei tarvita Edv:ssa: Vain yksi luku         //'Jtyp jne. tarvitaan Zs:än laskemiseen.
   seur := fJKno (1,jalessaStr);       //Luetaan 1.osa Nro -stringistä
   if NOT fnc  THEN P_yli := 1    //<EiOK
               ELSE P_yli := 0;   //<OK edessä olevaan PT:hen (ennen kutsua urhaan asetus 0).
   if seur>0   THEN P_yli := 2;   //<OK jälempään PT:hen. Voitais testata: IF (seur>0) AND (Pyli=1)
END;//tutPE_ok                    //'mutta testi tarpeeton: Ei voi olla(?) ristiriitaa, ks. FNC ZpeOK
//..........................................
                       //,LABEL +120.6 Aa Never used takia.
PROCEDURE laskeLrj;    LABEL 1;   VAR Rev,Xev, Rv,Rvo,Rn,Xv,Xvo,Xn,Ika,Isn,ccU,ar,pit2{,prTim{+8.0.0},    //<,,Rev,Xev +6.0.3
                                  Aa,Bb,Cc{+12.0.04} {kasvu,{+120.5M/6u: Rey,Rea,Zea, Xey,Xea} :real;
                           ao :integer;
   FUNCTION toisastPOS (a,b,c :real;  VAR X2ast :real) :Boolean; //<Palauttaa POSITIIVISEN juuren jos on.#########
                                                      //  ax² + bx + c = 0

                                                      //      - b +- V¨(b² - 4ac)
                                                      //  x = -------------------
                                                      //              2a       ,,,,,,DEVELOPER1 7.0.1,,,,,,,,,,,,,,,,,,,,,
            {                         3 c Uv                                   ,,,,,,Antaa samat SRVOT kuin 2Rv+Rvo+3eRn+...
               ----------------------------------------------------- = Ik1v    ,,,,,,kun ne on tässä korvattu Rev+Xev
               V¨[(Rev + L(2Rv+Rvo+3Rn))² + (Xev + L(2Xv+Xvo+3Xn))²]

                                      9 c² Uv²
               ----------------------------------------------------- = Ik1v²               ; Korotetaan ²:een
                 [Rev + L(2Rv+Rvo+3Rn)]² + [Xev + L(2Xv+Xvo+3Xn)]²

               Ik1v² [[Rev + L(2Rv+Rvo+3Rn)]² + [Xev + L(2Xv+Xvo+3Xn)]²] - 9 c²Uv² = 0

               Rev + L(2Rv+Rvo+3Rn)
               Rev + L(2Rv+Rvo+3Rn)  +  Xev + ...
               --------------------
               Rev² +L Rev(2Rv+Rvo+3Rn) +
                     L Rev(2Rv+Rvo+3Rn) +L²(2Rv+Rvo+3Rn)²
               -------------------------------------------                                 ; Lisätään puuttuneet tekijät
              [Rev² +2L Rev(2Rv+Rvo+3Rn) +L²(2Rv+Rvo+3Rn)²] Ik1v² - 9 c²Uv² = 0

               Ik1v²Rev² +2L Ik1v²Rev(2Rv+Rvo+3Rn) +L² Ik1v²(2Rv+Rvo+3Rn)² +
               Ik1v²Xev² +2L Ik1v²Xev(2Xv+Xvo+3Xn) +L² Ik1v²(2Xv+Xvo+3Xn)² - 9 c²Uv² = 0

               L² Ik1v²[(2Rv+Rvo+3Rn)² + (2Xv+Xvo+3Xn)²]        =ax²   =aL²
               L  2Ik1v²[Rev(2Rv+Rvo+3Rn) + Xev(2Xv+Xvo+3Xn)]   =bx    =bL
                  Ik1v²[Rev² + Xev²] - 9 c²Uv²                  =c     =c }

   VAR x1, x2  : Real;                                //  ax² + bx + c = 0
       diskrim : Real;
   BEGIN                                              //      - b +- V¨(b² - 4ac)
      diskrim := Sqr (b) - 4 * a * c;                 //  x = -------------------
                                                      //              2a
      result := FALSE;                  //Ks. PASCAL... Otadata s.133-134<<<<<<<
    //IF diskrim > 0                    //<Jos diskrim<0, juuri ei ole reaalinen =ALP: >0
      IF diskrim >=0                    //<Jos diskrim<0, juuri ei ole reaalinen =NYT: >=0
      THEN BEGIN
         result := TRUE;
         x1 := (-b + Sqrt (diskrim)) / (2.0 * a);
         x2 := (-b - Sqrt (diskrim)) / (2.0 * a);

         IF (x1 >= 0)  AND  (x2 >= 0)
         THEN IF x1 > x2   THEN X2ast := x2    //<Pienempi juuri palautusarvoksi
                           ELSE X2ast := x1    //<- " -
         ELSE IF x1 >= 0   THEN X2ast := x1    //<AINA / YLEENSÄ TÄHÄN. Havainto/Kokeiltu 6.2.16
         ELSE IF x2 >= 0   THEN X2ast := x2
         ELSE result := FALSE;                 //<Juuret negatiivisia <<<<<<<<<<
         {IF x1 > x2  THEN X2ast := x1
                      ELSE X2ast := x2;}
         //if IsDebuggerPresent  then PaaValFrm.Caption := 'ToisAst x1=' +fRmrkt0 (x1,1,6) +'  x2=' +fRmrkt0 (x2,1,6);
         if (x1>x2) and (x1<x2) and (X2ast<0)  then ;
      END;
   END;//toisastPOS

(*   PROCEDURE TestTul (sij :integer);      VAR s :string;
      function fR (s :string;  arvo :real) :string;      begin
         result := s +'=' +fRmrkt0 (arvo,1,8) +'  ';   end;
      function fI (s :string;  arvo :integer) :string;      begin
         result := s +'=' +IntToStr (arvo) +'  ';   end;
   begin
       if (eTyyp<>'') and (rjmm2=150)  then begin s := fi ('',sij) +')  ' +
          fr ('Rev',Rev) +fr ('Xev',Xev) +fr ('Rv',Rv) +fr ('Rvo',Rvo) +fr ('Rn',Rn) +fr ('Xv',Xv) +fr ('Xvo',Xvo) +
          fr ('Xn',Xn) +fr ('Isn',Isn) +fr ('Uo',fUo) +fr ('Uv',fUv) +fr ('(Uo/Isn)²',Sqr (fUo/Isn)) +
          fr ('(c*Uv/Isn)²',Sqr (ccU*fUv/Isn)) +fr ('ccU*fUv',ccU*fUv);
          DetEvFrm.aRich.Lines.Add (s);
          DetEvFrm.aRich.Lines.Add (Chr(13));
          DetEvFrm.Show;
  {' vikaevj=' +fImrkt0(vikaevj,1) +' Isul='+fImrkt0(Isul,1)  +' ct='+fRmrkt0(ct,1,1)   +' Tim='+fRmrkt0(Tim,1,1) +
   ' rjmm2='+fRmrkt0(rjmm2,1,1)   +' suCs='+suCs             +' tapa='+tapa            +' minA='+fRmrkt0(minA,1,1) +
   ' maxL='+fRmrkt0(maxLrj,1,1)   +' sulA='+fImrkt0(sulA,1)  +' TUP='+fImrkt0(TUP,1)   +' Jtyp='+Jtyp +
   ' Jmm2='+fRmrkt0(Jmm2,1,1)     +' Jpit='+fRmrkt0(Jpit,1,1)+' Isn='+fRmrkt0(Isn,1,1) +' sulQ='+fImrkt0(sulQ,1));}
       end;
   end;//*)

   FUNCTION fL_ZsIa (VAR pituus :real) :Boolean;      VAR boo :boolean; A,B,C :real; //<Palauttaa POSITIIVISEN juuren jos on.   +7.0.1
         { Ks. FNC fZs (Zs = Ze/3):                                                  //'A,B,C +12.0.04
           Zs*Ia <= Uo  -> Ratkaistaan PITUUS siten, että em. ZsIa -ehto täyttyy:        (L=PITUUS)

                Rev     2Rv+Rvo+3Rn       Xev     2Xv+Xvo+3Xn
           V¨[ [--- + L(-----------)]² + [--- + L(-----------)]² ] * Ia  =  Uo   ->  ...]² ]  =  Uo/Ia [ohm]
                 3           3             3           3
           Hävitetään neliöjuuri korottamalla mol. puolet ²:een :
                Rev   L(2Rv+Rvo+3Rn)        Xev   L(2Xv+Xvo+3Xn)
               [--- + --------------]²  +  [--- + --------------]²  - (Uo/Ia)²  =  0
                 3          3               3           3

               [Rev/3 + L(2Rv+Rvo+3Rn)/3]²  +  [Xev/3 + L(2Xv+Xvo+3Xn)/3]²  - (Uo/Ia)²  =  0

               Rev/3 + L(2Rv+Rvo+3Rn)/3                                                     <,,Kerrotaan itsellään =korotet. toiseenPotenssiin *
               Rev/3 + L(2Rv+Rvo+3Rn)/3                                                        Tässä näytetty "käsinlaskentana".               *
               ------------------------                                                                                                        *
               Rev²/9 + L Rev(2Rv+Rvo+3Rn)/9                                                                                                   *
                        L Rev(2Rv+Rvo+3Rn)/9 + L²(2Rv+Rvo+3Rn)²/9  +  Xev²/9 ...                                                               *
               --------------------------------------------------                                                                              *
               Rev²/9 + 2L Rev(2Rv+Rvo+3Rn)/9 + L²(2Rv+Rvo+3Rn)²/9  +  Xev²/9 + 2L Xev(2Xv+Xvo+3Xn)/9 + L²(2Xv+Xvo+3Xn)²/9  <= *****************
                        .....................   ::::::::::::::::::              .....................   ::::::::::::::::::
                                                                                ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Muokataan ratkaisumuotoon:
               L²  [(2Rv+Rvo+3Rn)² + (2Xv+Xvo+3Xn)²]/9             = x²a        ax² + bx + c = 0
               L   [2Rev(2Rv+Rvo+3Rn) + 2Xev(2Xv+Xvo+3Xn)]/9       = x b
                   [Rev²+Xev²]/9  - (Uo/Ia)²                       = c          x = [ - b +- V¨(b² - 4ac) ] / 2a

                                {Kokeiltuna aikaisemmilla arvoilla suoraan:,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                                 if toisastPOS (Sqr( 2*Rv+Rvo+3*Rn ) + Sqr( 2*Xv+Xvo+3*Xn ),
                                                2*Rev*(2*Rv+Rvo+3*Rn) + 2*Xev*(2*Xv+Xvo+3*Xn),
                                                Sqr(Rev) + Sqr(Xev) - 9*(Sqr (fUo)/Sqr (Isn)),
                                                pituus)
                                {if toisastPOS (Sqr( 2*Rv/3+Rvo/3+3*Rn/3 ) + Sqr( 2*Xv/3+Xvo/3+3*Xn/3 ),
                                                2*Rev/3*(2*Rv/3+Rvo/3+3*Rn/3) + 2*Xev/3*(2*Xv/3+Xvo/3+3*Xn/3),
                                                Sqr(Rev/3) + Sqr(Xev/3) - 9*(Sqr (fUo)/Sqr (Isn)),
                                                pituus)
                                {if toisastPOS (Sqr( 2*Rv+Rvo+3*Rn )/3 + Sqr( 2*Xv+Xvo+3*Xn )/3,
                                                (2*Rev*(2*Rv+Rvo+3*Rn))/3 + (2*Xev*(2*Xv+Xvo+3*Xn)/3),
                                                Sqr(Rev)/3 + Sqr(Xev)/3 - 9*(Sqr (fUo)/Sqr (Isn)),
                                                pituus) '''''''''''''Näillä tulee aivan liian isoja pituuksia -----------}
   begin//fL_ZsIa...................
         A := (Sqr(2*Rv+Rvo+3*Rn) + Sqr(2*Xv+Xvo+3*Xn))/9;        //<  a  A,B,C +12.0.04
         B := (2*Rev*(2*Rv+Rvo+3*Rn) + 2*Xev*(2*Xv+Xvo+3*Xn))/9;  //<  b
         C := (Sqr(Rev)+Sqr(Xev))/9  - Sqr(fUo/Isn);              //<  c
      boo := toisastPOS (A, B, C, pituus);
      result := boo;      // Uv=230.94010768  (Uo/Isn)²=0.01720785  (c*Uv/Isn)²=0.01565730
   end;//fL_ZsIa             // Antaa n. 9 ... >80 % isompia pituuksia kuin Jpit, laskettu.

   FUNCTION Ik1vAo :real;      VAR IkAo :real;  os :integer;  rec :EdvPalstaType;      begin //+6.2.16
      os := Abs (vikaEvj);
      if NJkin
      then IkAo := Ikm //<Lisätty, koska pituudksi tuli 0 m Ikao sai arvon 0, nyt OK.        //<+6.2.21
      else begin  if vikaEvj<0  then rec := edv.Sorc[os].josa
                                else rec := edv.edka[os];
                  IkAo := rec.arvoU[2];  end;
      result := IkAo;
   end;//Ik1vAo

//Tällä kohtaa oli ParsiVersioFile.INC -koodiosa, jolla on ajettu  _net-Versiomuutokset.txt -tiedosto nettisivua varten.
//Siinä on koottuna ja samankaltaisesti muotoiltuna koko muutoshistoria.
//ParsiFile() -kutsu on 14 rviä alempna.
   PROCEDURE annaZedv (VAR Req,Xeq :real);      VAR rr{,r1,r2} :real;  oh,ast :integer;      begin //+6.2.19
                             {Tässä lasketaan verkon imped.komponentit Zev ao. johto-osan ALKUUN ja toisen asteen
                              yhtälöllä ratkaistaan, KUINKA PITKÄ VOI ao. JOHTO-OSA OLLA, jotta ao. sulake vielä
                              toimii. maxZ:sta ratkaistaan johto-osan kokonaispituus fKxSuhLz :lla.}
                                           //,11=Zk1v loppuun, EI huomioida rinnak.johtojen suhteellista pituutta
      oh := 11;  ast := vikaEvj;           //<12=Zk1v MaxZ -kohtaan, HUOMIOIDAAN rinnak.johtojen suht. pituus
                                           //'10=Zik1v johdon ALUSSA = Myös muuntajan, gener. tm. TOISION NAVOISSA
      if eTyyp<>''  then begin //=Halutaan laskea ao. edJ:lla:  Kuinka pitkä SaaOllaEdj, jolloin Zev lasketEdj:n
         if vikaEvj<=0                     //<Jos vikaEvj=1 -> ast := 0 -> Zev := Liittymien yhteisimped.
         then begin if a_getIntg (10051,edv.YLE.SorceCount) = 1 //<Huomioidaan LIITTYMÄ vain jos niitä on yksi.
                       then oh := 10;  end                      //<.. ja imped. Zev lasket. VAIN liittymn napoihin.
         else ast := vikaEvj -1;                                //<Zev lasketaan ED. johdn loppuun = ao:n alkuun.
      end;   //ParsiFile('C:\Projektit XE2\NolaKehi\Paketointi\_net-Versiomuutokset.txt');//VersioMuutaTest.txt');
                          {PROCEDURE laskeRJpit (loc :string;  NJkin :Boolean;  vikaEvj,Isul,ct :Integer;  Tim,rjmm2,muP :Real;
                                                 eKpl :integer;  eTyyp,suCs :string;  tapa :string;
                                                 VAR minA,maxLrj,maxLrj_zpe :Real;  VAR sulA,TUP :Integer);}
                          {FNC Ziks_a(OHJ :Integer;  asti :Integer;  PEk :real;  NJkin :boolean; //<,FNC = KOKON.Zk: YhtOhm. Uusitt 6.2.2
                                     TIM :real;  QJtyp :string;  QJmm2,QJpit,muP :real;  QJkpl,QJlampot :integer;       //§u§ mu_=+8.0.7
                                     VAR  Rsz,Xsz,LszKer,Lsz :real) :Real; //<LszKer=Kerrottuna yhden kaapln Rv..yms. antaa
                          {FUNCTION Ziks (ohj :Integer;  asti :Integer;  NJkin :boolean;
                                          TIM :real;  QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer;
                                          VAR  Rsz,Xsz,LszKer,Lsz :real) :Real;}
      if (ast<0) and (edv.Sorc[1].Josa.JkUps.ArvoInt >0)             //<Kaikissa Src´ssa sama tieto, onko JkUPS-haara(1) vai ei(0).
         then oh := oh +100                                          // >100=JkUPS-haara Sorc´en J-osassa.
         else if (ast>0) and (edv.Edka[Abs(ast)].JkUps.ArvoInt >0)
                 then oh := oh +1000;                                //<''+1412:  >1000=JkUPS-haara Edka´ssa.
                                                                     //''         Näissä tapauksissa haetaan vain JkUpsin Ik,Cos -tiedot => Req,Xeq .
      //,################################################################################################################################################
      Ziks_a (oh,ast, 0{PEk},NJkin,           //<§u§ +8.0.7, +141.1: +100 vähennettävä Ziks_a´ssa =Tänne vain riveiltä 23.., jos eTyyp<>'' =rvt 32-35
              TIM,''{typ}, 0{kpl},0{°C},muP,0,0,    //141.1:  Kaikki rvt 23-35 ovat myös JkUps´in takana, eli oh+100 =OK.
              Req,Xeq,rr,rr);                        //<PALUUparamt.
                             if oh>100  then
                                ZaoFileen('Pituus_:  '+loc +' Req=' +fRmrkt0(Req,1,4) +' Xeq=' +fRmrkt0(Xeq,1,5) +' rr=' +fRmrkt0(rr,1,5) +' Tim=' +
                                          fRmrkt0(Tim,1,1) +' A=' +fRmrkt0(rjmm2,1,0) +' Isul=' +Ints(Isul) +' suCs=' +suCs);
      //'################################################################################################################################################
                             (*~NÄISSÄ kokeillaan..rr,rr) paluuparametrin mahd. erilaisia vaikutuksia arvoihin, vrt. ..rr,rr) vs. ..r2,r2).,,,,,,,,,,,,,,,,,,,
                                if (Isul=16) and (Tim<1) and (rjmm2=2) then begin //,,Sama kuin ed, tutkit rr/r1/r2 eroja paluuarvoissa. //<,,+120.5m/6U
                                   DefsFileenZ('10.INC/LaskeLrj/AnnaZev:  oh:' +Ints(oh) + ' ast:' +Ints(ast) +' Edvj:' +Ints(vikaEvj) +'  Req:' +fRmrkt0(Req,1,6) +'  Xeq:' +
                                              fRmrkt0(Xeq,1,6) +' rr=' +fRmrkt0(rr,1,6) +'             su=' +Ints(Isul) +' A=' +' Tm=0.4s mm2=' +fRmrkt0(rjmm2,1,1));    //<+120.5m/6U
                                   Ziks_a (oh,ast, 0{PEk},NJkin,                                                         //<§u§ +8.0.7
                                           TIM,'',0,0,muP,  0,0,
                                           Req,Xeq,r1,r2);
                                   DefsFileenZ('10.INC/LaskeLrj/AnnaZev:  oh:' +Ints(oh) + ' ast:' +Ints(ast) +' Edvj:' +Ints(vikaEvj) +'  Req:' +fRmrkt0(Req,1,6) +'  Xeq:' +
                                              fRmrkt0(Xeq,1,6) +' R1=' +fRmrkt0(r1,1,6) +' R2=' +fRmrkt0(r2,1,6) +' su=' +Ints(Isul) +' A=' +' Tm=0.4s mm2=' +fRmrkt0(rjmm2,1,1));
                             end;~*)
      if rr<0  then ;
   end;//annaZedv

BEGIN//laskeRJpit,,,,,,,,,,,,,,,
   annaZedv (Rev,Xev);           (*~if (Isul=16) and (Tim<1) and (rjmm2=2) then
                                      DefsFileenZ('10.INC/LaskeLrj/AnnaZev:               Edvj:' +Ints(vikaEvj) +'  Rev:' +fRmrkt0(Rev,1,6) +'  Xev:' +
                                           fRmrkt0(Xev,1,6) +'             su=' +Ints(Isul) +' A=' +' Tm=0.4s mm2=' +fRmrkt0(rjmm2,1,1));    //<+120.5m/6U ~*)
{Rv := res('MMJ',2);
kR := res('MMJ',6);
rv := kR/rv;}
   Rv :=  res    (Jtyp,Jmm2)             /Jkpl; //<,,Yksikköarvot ryhmä/Nj:lle per [m]
     Rv :=  rTkorj (fAlCu (Jtyp), Rv,Jct);
   Rvo := resVo  (Jtyp,Jmm2)             /Jkpl;
     Rvo := rTkorj (fAlCu (Jtyp), Rvo,Jct);
   Rn :=  resP   (Jtyp,Jmm2)             /Jkpl;
     Rn :=  rTkorj (fPal  (Jtyp), Rn,Jct);
   Xv :=  Xv_ind  (Jtyp,Jmm2)            /Jkpl;
   Xvo := Xv0_ind (Jtyp,Jmm2)            /Jkpl;
   Xn :=  Xp_ind  (Jtyp,Jmm2)            /Jkpl;

  {FUNCTION toisastPOS (a,b,c :real;  VAR X2ast :real) :Boolean;
               [(2Rv+Rvo+3Rn)²+(2Xv+Xvo+3Xn)²]L²  +                                                    =ax²   =aL²
               [2(2Rm+Rmo+2eRv+eRvo+3eRn)(2Rv+Rvo+3Rn) + 2(2Xm+Xmo+2eXv+eXvo+3eXn)(2Xv+Xvo+3Xn)]L  +   =bx    =bL
               (2Rm+Rmo+2eRv+eRvo+3eRn)² + (2Xm+Xmo +2eXv+eXvo+3eXn)² - 9((cU*Uv)²/Ik1v²)          = 0 =c     =c
               =
               [Sqr( 2*Rv+Rvo+3*Rn ) + Sqr( 2*Xv+Xvo+3*Xn )]L²                                                =aL²
               [2*(2*Rm+Rmo+2*eRv+eRvo+3*eRn)(2*Rv+Rvo+3*Rn) + 2*(2*Xm+Xmo+2*eXv+eXvo+3*eXn)(2*Xv+Xvo+3*Xn)]L =bL
               Sqr( 2*Rm+Rmo+2*eRv+eRvo+3*eRn ) + Sqr( 2*Xm+Xmo +2*eXv+eXvo+3*eXn ) - 9*((cU*Uv)²/Ik1v²)      =c }
   ao := Abs (vikaEvj);                                                     //,BOO = KULUTTAJA, tod. sijoitus myöh.
   if vikaEvj<0  then boo := a_getBool (10050, edv.Sorc[ao].josa.Kuluttaja) else//<Sorc (liittymä)-osalla.<,,+6.2.2
   if vikaEvj=0  then boo := a_getBool (10050, edv.Sorc[ 1].josa.Kuluttaja)     //<PK´ta edeltävä yht.=Kylmästi [-1] +6.2.19
                 else boo := a_getBool (10051, edv.Edka[ao].     Kuluttaja);
  {if _mm2>0                                                        //<,,+8.0.0  -8.0.8
      then prTim := a_getReaa (10, Edv.YLE.PRaika)                  //<Tutkitaan rj :t 2.5/1.5, 0.2s=lääkintätiloissa.
      else prTim := tim;}                                           //KOKEILUA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

   if (eTyyp<>'') and NOT boo                     //<NOT boo = SÄHKÖLAITOksen johdolle las-
    //then Isn := Isul                            // ketaan SULAKKEEN mukaan.<'+6.2.2  prTim=8.0.0
      then if Isul > 63                           //<,,+8.0.7
              THEN  Isn := 3   * Isul
              ELSE  Isn := 2.5 * Isul
      else Isn := Isnik (suCs,sulQ,Tim);          //<Deb. ehto:         (Pos('DZ',AnsiUpperCase(sucS))>0) and (sulQ IN[10,16])
   ccU := a_getReaa (10051,edv.YLE.cU);           //'Isnik´issä JkB..D.
//TestTul (1);
   T_yli := TRUE;
   U_yli := TRUE;
   Ika := Ik1vAo;                                 //<Ik1vAo =Ik1v aoJosan alussa.
   if Ika<=Isn                                    //<,,Antoi pituuksia rj:lle, vaikka Ik1v < Isnik. +6.2.16
      then Jpit := 0;                             //'  Ik1vAo = Ik1v verkon ao. pisteessä (johdon lopussa)=arvoU[2]  <+6.2.16
    //else Oli kauan näin (1200´sta) siis että seur. vei sijoitukseen Aa := 0 ja herja: Aa might not..
  {if toisastPOS (Sqr( 2*Rv+Rvo+3*Rn ) + Sqr( 2*Xv+Xvo+3*Xn ),        //<,,DEVELOPER2 mukaan, kun mukana eRv...eRn         -7.0.1
                  2*Rev*(2*Rv+Rvo+3*Rn) + 2*Xev*(2*Xv+Xvo+3*Xn),      //,##################################################
                  Sqr(Rev) + Sqr(Xev) - 9*(Sqr (ccU*fUv)/Sqr (Isn)),  // SAMA ARVO KUIN DEVELOPER1:n seuraavassa
                  Jpit)  then begin                                   //<Jos OK =Palauttaa JPIT.##########################}
(*££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££*)
//KASVU-ve´lla toteutettuna alempna SAMA +120.5n.
   Aa := 0;                                                           //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,DEVELOPER1 7.0.1, Aa..+12.0.04
   if Aa=0  then ;                                                    //,Aa may not have been initz. ..not used.
   Aa := Sqr( Isn) *(Sqr( 2*Rv+Rvo+3*Rn) + Sqr( 2*Xv+Xvo+3*Xn));      // L² Ik1v²[(2Rv+Rvo+3Rn)² + (2Xv+Xvo+3Xn)²]        =ax²   =aL²
   Bb := 2*Sqr( Isn) *(Rev*(2*Rv+Rvo+3*Rn) + Xev*(2*Xv+Xvo+3*Xn));    // L  2Ik1v²[Rev(2Rv+Rvo+3Rn) + Xev(2Xv+Xvo+3Xn)]   =bx    =bL
   Cc := Sqr( Isn) *(Sqr( Rev) + Sqr( Xev)) - 9 *Sqr( ccU*fUv);       //    Ik1v²[Rev² + Xev²] - 9 c²Uv²                  =c     =c
   T_yli := TRUE;                                                     //<+130.2e

   if toisastPOS (Aa,Bb,Cc, Jpit)  then begin                         //<Jpit =Kutsuun palautuva Rj-PITUUS.
      if Jpit>0  then begin                                   //'OK (=TR), jos reaalijuuri.#######################
       //ar := fKxTot (12, Jtyp,Jmm2,Jkpl);                   //<MaxZ:n pituuskerroin             <,+6.2.19
         ar := fKxSuhLz (Jtyp,Jmm2,Jkpl);                     //<MaxZ:n pituuskerroin             <,+6.2.19
         Jpit := Jpit/ar;                                     //<+120.5n:  Jpit on maxZ-imped´n mukainen joten fKxSuhLz-korjattu on todellinen asennuspituus.
         if Jpit>=0.5  then                                   //           Pitäiskhän tarkistaa OHJAUSkoodi ohj tai ao tms !?!?!?
            T_yli := FALSE;                                   //<+10.0.1  '130.2e:  0.1 => 0.5 .

         if eTyyp<>''                  //<Tyyppi annettu kutsussa = Halutaan laskea NOUSUJOHTOJEN resursseja, jol-
            then ao := 10              // loin edv:n Zs lasketaan johto-osan ALKUUN ja siihen lisätään Qtyp,Qpit...
            else ao := 11;             //<Ryhmäj:lle Zs lasketaan edj:n LOPPUUN.   <''+7.0.1

         IF  NOT Kul
         THEN  U_yli := FALSE                           //<Aina jos SÄL = Ei tartte tarkistaa.
         ELSE  IF ZsIa_OK (ao, suCs,vikaEvj,0,NJkin,Kul, sulQ, Tim,  Jtyp,Jmm2,Jpit,Jkpl,Jct) //<TimEiVaik Ik1v´ssä.
         THEN U_yli := FALSE
         ELSE begin                                    //<,Jos NOT ZsIa -> lasketaan ZsIa:n mukainen PITuus (pit2)
//TestTul (2);                                         //,Ratkaistaan PITUUS siten, että em. ZsIa -ehto täyttyy.
            if fL_ZsIa (pit2)                          //<Jos OK =Palauttaa PIT2.########### +7.0.1 ##############
            then begin                                 //'OK (=TR), jos reaalijuuri.##############################
               if pit2>0  then begin
                  ar := fKxSuhLz (Jtyp,Jmm2,Jkpl);     //<MaxZ:n pituuskerroin                   <,+6.2.19
                  pit2 := pit2/ar;
                  if pit2<Jpit  then                   //<,Jos ZsIa -ehto rajoittaa lyhyemmäksi, se määrää =+8.0.7
                     Jpit := pit2;                     //'Tämä lisäys sai aikaan sen, että pituudet ed. ja seur.
                  if Jpit>=0.5  then      //<+10.0.1   // j-osissa ovat synkroonissa. Esim. jos [1]:ssa 665 m ja  <130.2e:  0.1 => 0.5
                     T_yli := FALSE;                   // res. ilmoittaa 665.3, seur. johto-osaan resurssiksi tulee
                  U_yli := FALSE;  end                 // 0.3 m.############## HYVÄ ##############################
            end;
         end;
         Jpit := fMuokDes (Jpit,1);
      end;                              if Pos('.r23',loc)>0  then
                                           ZaoFileen('PituusJ:  '+loc +' Rev=' +fRmrkt0(Rev,1,4) +' Xev=' +fRmrkt0(Xev,1,5) +' Tim=' + fRmrkt0(Tim,1,1) +
                                                     ' A=' +fRmrkt0(rjmm2,1,0) +' Isul=' +Ints(Isul) +' suCs=' +suCs +' Aa=' +fRmrkt0(Aa,1,5) +
                                                     ' Bb=' +fRmrkt0(Bb,1,5) +' Cc=' +fRmrkt0(Cc,1,5) +' Jpit=' +fRmrkt0(Jpit,1,1));
   end;//if toisastPOS ££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££*)
(*,,+120.5n------------------------------------------------------------------------------------------------------------------------------------------------
//HYVÄ HAVAINNOLLINEN:  TÄMÄ OTETTU (£´n) ToisAstPOS´n KORVAAVAKSI, KOSKA TÄSTÄ DEBUGG NÄYTTÄÄ KASVUN ANALOGISESTI. PITÄISI VIELÄ TARKISTAA p_yLI YMS KUVIOT.
 kasvu := 10000;                                      //Ekan jälkeen kasvu=1000m.
   Jpit := 0;                                         //
   repeat kasvu := kasvu/10;                          //Ekan jälkeen kasvu=1000m. PANE EdvNewLask rv 344 ehto "r>=40", kun se stoppaa, pistä näille rveille
      repeat Jpit := Jpit +kasvu;                     //                          myös BreakPoint =pääset vertaamaan ToisAst lsskentaan.
            {ar := fKxSuhLz (Jtyp,Jmm2,Jkpl);         //<MaxZ:n pituuskerroin             <,+6.2.19
             Jpit := Jpit/ar;}
            Aa := Jpit;
             Rea := Rev +Jpit*(2*Rv+Rvo+3*Rn);
             Xea := Xev +Jpit*(2*Xv+Xvo+3*Xn);
             Zea := Sqrt( Sqr(Rea) +Sqr(Xea) );
                                        //FUNCTION Ziks_ (OHJ :Integer;  asti :Integer;  PEk :real;  NJkin :boolean;     //<,Ziks_´iin lisätty MUP, MUOH, ks.
                                        //                TIM :real;  QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer; //LaskeRjPit (LääkMuuntRj).
                                        //                VAR  Rsz,Xsz,LszKer,Lsz :real) :Real;      begin
                                        //PROCEDURE laskeRJpit (loc :string;  NJkin :Boolean;  vikaEvj,Isul,ct :Integer;  Tim,rjmm2,muP :Real; //<rjmm2=>_jmm2
                                        //                      muOh,eKpl :integer;  eTyyp,suCs :string;  tapa :string;
                                        //                      VAR minA,maxLrj,{+9.0.1:}maxLrj_zpe :Real;  VAR sulA,TUP :Integer);
           //Zea := Ziks_ (11,vikaEvj, 0{PEk},NJkin,TIM,  '',0,0,0,0, ar,ar,ar,ar);  Ei OK.
             Ikj := Iks (FALSE,vikaEvj, Zea);           //<FA=Ei3v.
      until  (Ikj<Isn) or (Jpit<=0);// or (kasvu<=0.1); //<Ulos jos Iks(=Ikj) eioo riittävä.
             if kasvu>0.1
                then Jpit := Jpit -kasvu;               //<Jottei lopetustilanteessa Jpit vääristyisi.
   until  (kasvu<=0.1);
   //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,##########################################################################################################################
   ar := fKxSuhLz (Jtyp,Jmm2,Jkpl);                     //<MaxZ:n pituuskerroin             <,+6.2.19
   Jpit := Jpit/ar;                                     //<TÄLLÄ KORJAUKSELLA JPIT ON SAMAT KUIN ToisAstPOS-versiolla laskettuna, TODETTU.
                                   //ELI: ESIM. 5-rinnKaapelilla ar~0.625, joten JPIT kasvaa yli 2x´ksi ja sehän on oikein =TODELLINEN ASENNUSPITUUS.!!!!!!!!
   //''''''''''''''''''''''''''''''##########################################################################################################################
   if Jpit>=0.1  then                                   //<+10.0.1
      T_yli := FALSE;
   if eTyyp<>''                  //<Tyyppi annettu kutsussa = Halutaan laskea NOUSUJOHTOJEN resursseja, jol-
      then ao := 10              // loin edv:n Zs lasketaanjohto-osan ALKUUN ja siihen lisätään Qtyp,Qpit...
      else ao := 11;             //<Ryhmäj:lle Zs lasketaan edj:n LOPPUUN.   <''+7.0.1
   IF  NOT Kul                   //,,120.5n:  Pitäis vissiin tarkistaa!?!?!?,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   THEN  U_yli := FALSE          //<Aina jos SÄL = Ei tartte tarkistaa.
   ELSE  IF ZsIa_OK (ao, suCs,vikaEvj,0,NJkin,Kul, sulQ, Tim,  Jtyp,Jmm2,Jpit,Jkpl,Jct) //<TimEiVaik Ik1v´ssä.
   THEN U_yli := FALSE;

   if Aa<0 then ; //---------------------------------------------------------------------------------------------------------------------------------------*)
END;//laskeRJpit
{PROCEDURE laskeRJpit (loc :string;  NJkin :Boolean;  vikaEvj,Isul,ct :Integer;  Tim,rjmm2 :Real;  suCs :string;  tapa :string;
                      VAR minA,maxLrj... :Real;  VAR sulA,TUP :Integer);
suCs,vikaEvj,0,NJkin,Kul, sulQ, Tim,  Jtyp,Jmm2,Jpit,Jkpl,Jct)}
{if (vikaEvj=1) and (rjmm2<=2) and (Isul IN [10,16]) and (tim<1) and (Length(suCs)>1)  then DetEvFrm.aRich.Lines.Add (
' vikaEvj=' +fImrkt0(vikaEvj,1) +' Isul='+fImrkt0(Isul,1)  +' ct='+fRmrkt0(ct,1,1)   +' Tim='+fRmrkt0(Tim,1,1) +
' rjmm2='+fRmrkt0(rjmm2,1,1)   +' suCs='+suCs             +' tapa='+tapa            +' minA='+fRmrkt0(minA,1,1) +
' maxL='+fRmrkt0(maxLrj,1,1)   +' sulA='+fImrkt0(sulA,1)  +' TUP='+fImrkt0(TUP,1)   +' Jtyp='+Jtyp +
' Jmm2='+fRmrkt0(Jmm2,1,1)     +' Jpit='+fRmrkt0(Jpit,1,1)+' Isn='+fRmrkt0(Isn,1,1) +' sulQ='+fImrkt0(sulQ,1));
{
n=1 r=1 maxSu=16 ct=50.0 tim=0.4 aA=2 suCs=OFAAgG asTap=A
n=1 maxSu=16 ct=50.0 tim=0.4 aA=2 suCs=OFAAgG asTap=A ### minA=2.0 Lmax=116.1 suA=16 TUPx=0
vikaevj=1 Isul=16 ct=50.0 Tim=0.4 rjmm2=2.0 suCs=OFAAgG tapa=A minA=0.0 maxL=0.0   sulA=0  TUP=0 Jtyp=MMJ/MMK* Jmm2=2.0 Jpit=116.1 Isn=113.7 sulQ=16
vikaevj=1 Isul=10 ct=50.0 Tim=0.4 rjmm2=1.0 suCs=OFAAgG tapa=A minA=2.0 maxL=116.1 sulA=16 TUP=0 Jtyp=MMJ/MMK* Jmm2=1.0 Jpit=132.9 Isn=60.9 sulQ=10
vikaevj=1 Isul=16 ct=50.0 Tim=0.4 rjmm2=2.0 suCs=B      tapa=A minA=1.0 maxL=132.9 sulA=10 TUP=0 Jtyp=MMJ/MMK* Jmm2=2.0 Jpit=165.2 Isn=80.0 sulQ=16
vikaevj=1 Isul=10 ct=50.0 Tim=0.4 rjmm2=1.0 suCs=B      tapa=A minA=2.0 maxL=165.2 sulA=16 TUP=0 Jtyp=MMJ/MMK* Jmm2=1.0 Jpit=161.9 Isn=50.0 sulQ=10
vikaevj=1 Isul=16 ct=50.0 Tim=0.4 rjmm2=2.0 suCs=C      tapa=A minA=1.0 maxL=161.9 sulA=10 TUP=0 Jtyp=MMJ/MMK* Jmm2=2.0 Jpit=82.4 Isn=160.0 sulQ=16
vikaevj=1 Isul=10 ct=50.0 Tim=0.4 rjmm2=1.0 suCs=C      tapa=A minA=2.0 maxL=82.4  sulA=16 TUP=0 Jtyp=MMJ/MMK* Jmm2=1.0 Jpit=80.8 Isn=100.0 sulQ=10
vikaevj=1 Isul=16 ct=50.0 Tim=0.4 rjmm2=2.0 suCs=D      tapa=A minA=1.0 maxL=80.8  sulA=10 TUP=0 Jtyp=MMJ/MMK* Jmm2=2.0 Jpit=41.0 Isn=320.0 sulQ=16
vikaevj=1 Isul=10 ct=50.0 Tim=0.4 rjmm2=1.0 suCs=D      tapa=A minA=2.0 maxL=41.0  sulA=16 TUP=0 Jtyp=MMJ/MMK* Jmm2=1.0 Jpit=40.3 Isn=200.0 sulQ=10
}
//..........................................
PROCEDURE parametrit (aoSul :integer);
   PROCEDURE kasva_A (VAR a :Real);     BEGIN
      CASE Trunc (a) OF   10 :a := 16;   35 :a := 50;    95 :a := 120;
           1 :a := 2.5;   16 :a := 25;   50 :a := 70;   120 :a := 150;
           2 :a :=  6;    25 :a := 35;   70 :a := 95;   150 :a := 185;
           6 :a := 10;  else  a := 240;  END; END;
//..........................................
BEGIN//parametrit                  //,,_mm2>0 AINA <<<<<<<<<<<<<<<<<<<<<<<< ########################
   Jct := ct;   Jkpl := 1;         //<############## AINA kutsuparam mukaan ########################
   if eTyyp<>''                    //<Halutaan laskea ao. edJ:lla:  Kuinka pitkäSaaOllaEdj <,,+6.2.2
   then begin
      Jtyp := eTyyp;
      Qmm2 := _mm2;
      Jmm2 := Trunc (_mm2);
      Jkpl := eKpl;
      sulQ := Isul;  end                                                                 //<''+6.2.2
   else IF _mm2>0                  //<<<<<<<<<<<<<<<< Tutkitaan rj :t 2.5/1.5
   THEN BEGIN                      //                 mm2>0 AINA ###################################
//    Jtyp := 'MCMK';     sulQ := Isul;
      Jtyp := 'MMJ/MMK*'; sulQ := Isul;
      Jmm2 := _mm2;       Qmm2 := _mm2;   END         //<Qmm2 sijEiTarvTässä
   ELSE BEGIN                      //,,,,,,,,,,,,,,,,,Etsitään suQ :lle mm2,,,,,,,,,,,,,,,,,,,,,,,,,
      Jtyp := 'MCMK';     sulQ := 6;                  //<Saattaa jäädä voimaan
      Jmm2 := 1;          Qmm2 := 1.5;
      WHILE (sulQ<aoSul) AND (Qmm2<240)  DO BEGIN //<#################### aoSul ####################
         kasva_A (Qmm2);
         Jmm2 := Trunc (Qmm2);
         IF Jmm2>16  THEN Jtyp := 'AMCMK';                 //,  ,O =iso oo, ei nolla,,,,,,,,,,,,,,,,
         IF (tapa<>'') and CharInSet(tapa[1], ['o','O'])   //<'o,O'=Oikos.suojaus,  'A'=asTapa A jne.  1414cU: +(tapa<>'') and
            THEN sulQ := OikSuoj (suCs,Jtyp,Jmm2,Jkpl)     //1,=KorjKerr <<<<<<<<<<<<<<<<<<<<<<<<<<<
            ELSE sulQ := pyor (YvSuoj (suCs,FALSE,FALSE,tapa,1,Jtyp,Jmm2,Jkpl));
      END;
      WHILE sulQ>aoSul  DO pienIsul (sulQ);            //<Jos kaap salli liian ison
   END;        //'''''################################################### aoSul ####################
   if eTyyp=''  then ; //Jotta arvo säilyisi kaikille em. IF THEN ELSE :llä.
END;//parametrit
//==================================================================================================
//==================================================================================================
BEGIN//laskeRJpit
                                   //¿DefsFileenZ('10.INC/laskeRJpit: 1: vikaEvj:' +Ints(vikaEvj));
                                               //,VarmistusNJkinKutsulle(IF NJkin..vikaevj := edmx..
   _mm2 := rjmm2;                              //<Tämän jälkeen ei enää rjmm2:ta käytetty =Debuggerissa muuten eiNäy.
   TUP := 0;                                   //<Jotta debuggeri näyttäisi 0 alusta. Tod. alkusij. myöhemmin
   if suCs=''  then begin end;
   IF njkin  THEN vikaEvj := edmaxkpl;         //,EI VOI OLLA prc param :ssa, vrt. GOTO 1 ##########
   if _mm2<0.0001  then _mm2 := 0;             //<Debuggerissa 0 näkyy -2.xxxxxe-82 tms :na         +6.1.1
   IF _mm2>0  THEN sulQ := Isul                //<<<<<<<<Tutkitaan rj :t 2.5/1.5 <<<<<<<<<<<<<<<<<<<
              ELSE sulQ := 6;                  //<<<<<<<<Etsitään suQ :lle mm2, Saattaa jäädäVoimaan
   //,,,,,,,,################################################################################################################################################
   parametrit ({Isul}sulQ);                    //<Isul tässä vain kutsusyntaxin takia, ei muuten tarttis ########## 120.5m/6U:  Isul => sulQ =ei vaikutusta.
   //''''''''################################################################################################################################################
  {IF Tim <5.1  THEN Kul := TRUE               //<,-8.0.8
                ELSE Kul := FALSE;}
   no := Abs (vikaEvj);
   if vikaEvj<0  then Kul := a_getBool (10050, edv.Sorc[no].josa.Kuluttaja) else//<Sorc (liittymä)-osalla.<,,+6.2.2
   if vikaEvj=0  then Kul := a_getBool (10050, edv.Sorc[ 1].josa.Kuluttaja)     //<PK´ta edeltävä yht.=Kylmästi [-1] +6.2.19
                 else Kul := a_getBool (10051, edv.Edka[no].     Kuluttaja);    //<,,+8.0.8
1:
Jpit := 0;
IF sulQ<2        //<130.0:  Oli <6
THEN BEGIN  T_yli := TRUE;  U_yli := TRUE;  END //<Jos Tyli, on Uyli´kin TR (vaikka ero hyvin pieni) +7.0.1
ELSE BEGIN
   //,,,,,,,#################################################################################################################################################
   LaskeLrj;                                      //<PRC KasvaLrj sijoittaa JPIT,,, Korvattu 6.0.3 ToisAstYhtälöllä.
   //'''''''#################################################################################################################################################
   IF _mm2=0  THEN IF (pyor (Jpit) <1) AND (Jmm2>0) AND (sulQ>6)
      THEN BEGIN  pienIsul (sulQ);  parametrit (sulQ);  GOTO 1;  END;
   IF Jpit<0.15  THEN Jpit := 0;                  //<Muuten <2> edit min 0.1m
END;
                                                  //,EI SÄHKÖL.jakeluverkossa jaVain, jos TIM <1 //oli TIM >1 
P_yli := 0;                                       //,eli ei tarkisteta jos mm. sulQ toimii <=0.4 s:ssa.
//no := fSu4 (suCs,vikaEvj,0,NJkin,Kul, sulQ,Jtyp,Jmm2,Jpit,Jkpl,Jct, i); //< i=1, jos ZsIa vaikutti. EiKäytTässä.
maxLrj_zpe := Jpit;                               //<+9.0.1  Jos ei vaikka mentäisikään laskemaan maxLrj_zpe.
IF (Tim <1) and Kul //and  (sulQ>no)              //'sulQ>no -ehto vex, koska pituus haetaan poiskAjan mukaan -8.0.8
   THEN tutPE_OK (vikaEvj,NJkin,maxLrj_zpe);      //'9.0.1 Oli Tim>1 => Tim<1 !!!ISO PERIAATTEELLINEN MUUTOS.!!!!!
if (Tim>0.5)  OR
   ((VikaEvj<0)  OR (VikaEvj>0) and NOT Kul)  OR  //<,,Nämä muut ehdot on myös laskennassa ZpeOK :ssa.
   ((maxLrj_zpe>Jpit) and (maxLrj_zpe>0))  OR     //<RJmax_pit := QJpit jos RJmax_pit "löysempi" kuin f(Tim)
   (maxLrj_zpe<0)                                 //  eli QJpit < RJmax_pit TAI RJmax_pit on negatiivinen.
   then maxLrj_zpe := Jpit;
          //'Asetti Pyli-arvot'''''''' #############################################################}
                             (*~if (Isul=16) and (Tim<1) and (rjmm2=2) then       //<,,+120.5m/6U
                                   DefsFileenZ('10.INC/LaskeLrj/AnnaZev:  Jpit:' +fRmrkt0(Jpit,1,2));~*)
TUP := 0;
if maxLrj_zpe<-1234  then ;
if Isul>0  then begin                  //<Vika Lisäys: Jottei TUP, jos ei ole sul lainkaan !!!!!!!!!
   IF T_yli    THEN TUP := 1000;       //<,ON ylitys
   IF U_yli    THEN TUP := TUP +100;
   IF P_yli>0  THEN BEGIN       TUP := TUP + 10;         //<Vain 5 s :n RJ :lle !!!!!!!
               IF P_yli=2  THEN TUP := TUP +  1;  END;   //< =PTok Pt2:n kautta
   //,Otetaan vex TUPX:stä T ja U, koska silloinhan RJ:n pituus =0 ja "- - - -" ilmaisee sen muutenkin. +9.0.1
  {if TUP>=1000  then TUP := TUP-1000; //'Vois kommentoida vex edellä, mutta tulisi "Never used .."
   if TUP>=100   then TUP := TUP-100;} //<-130.2e.
   if TUP<0  then ;
end;//Isul>0             // Tyli = Jpit>0 => Tyli := FA   sulQ<6 => Tyli := TR
minA := Qmm2;            // Uyli = NOT ZsIa_OK            sulQ<6 => Uyli := TR
sulA := sulQ;            // Pyli =
maxLrj := Jpit;
                                   //¿DefsFileenZ('10.INC/laskeRJpit: 1: vikaEvj:' +Ints(vikaEvj));
END;//laskeRJpit
//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NOLA10.INC




