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

//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ MoLas2.INC
{  MoLas1.INC + MoLas2.INC  Liittyy:  MOOT.PAS/incl.
   PRC:t  RJarvot //fSul //fLuh10 //fMm2Pmax
//a_getIntg (30211..  × (=158)
============================================================================} //,RJ :n alkuSul ja maxSUL
PROCEDURE RJarvot (DetNyt :boolean;  os :integer;  VAR suCs :string;  Ljmin :real;   VAR rj_SUL :integer; //VAR rj_SUmax :integer;
                   VAR rj_xCU        :integer;    VAR rj_mmCU         :real;    //<CU-ryhmäjohto,,,,,,,,,,,,,,,,
            {22}   VAR rj_LmaxCU     :real;       VAR rj_ChrCU,SulCUc :string;  //<RJ :n maxPituus jaRajoitus-chr
                   VAR rj_PmaxCU     :real;                                     //<RJ :n maxP, 'SulCUc=SulEiOKjohdlle
            {23}   VAR rj_LmaxPmaxCU :real;       VAR rj_ChrPmaxCU    :string;

                   VAR rj_xAL        :integer;    VAR rj_mmAL         :real;    //<AL-ryhmäjohto,,,,,,,,,,,,,,,,
                   VAR rj_LmaxAL     :real;       VAR rj_ChrAL,SulALc :string;
                   VAR rj_PmaxAL     :real;
                   VAR rj_LmaxPmaxAL :real;       VAR rj_ChrPmaxAL :string);
VAR i,ai{,120.5k: PixL} :Integer;
    mrk :string;   ar :Real;
    kwQ,cosQ,timQ,korjQ :real;   //<,sij motr[] :sta
    napQ :integer;  astQ :string;  

   FUNCTION fKaTyp (AlCu :boolean) :string;      begin  if AlCu  then Result := 'AMCMK'
                                                                 else Result := 'MCMK';  end;
   FUNCTION fSul (Okw,Ocos :Real;  Onap :Integer;  Otim :Real) :Integer;
         VAR sul :Integer;  aTik,aSft,aCos,aIst,aFin,ar :real;        BEGIN
      sul := 0;
    //aSft := KsftYR;  //,Ei Ocos, koska Ist :llä In :stä poikkeava ja StrGr -sijoituksissakin esitet. tämä
      aSft := KsftARo (suCs,sul);
      aCos := fCos (Okw,Onap); //<Ei Ocos, koska Ist :llä In :stä poikkeava ja StrGr -sijoituksissakin esitet. tämä
      aIst := fIst (Okw,aCos,Onap);   //<fIst AINA nimellisCosinin muk.!!!!
      aIst := aIst * aSft;            //<,,,,Huijataan Ist :llä = kestet-
         ar := aIst;                  //,,,,,,tävä Sft+Toler ISOMPAA VIRTAA
      aFin := fIn (Okw,Ocos,Onap);
      aFin := aFin * aSft;
      if aFin>ar  then ar := aFin;
      REPEAT  seurSul (sul);          //<1. sulake = 6A ###################
              ChkOFAdzRaja (suCs,sul); //<Vaihdetaan SUCS -tyyppi, jos aM tyyppi ei riitä (IsnikFnc muutti)
            //aTik := Tik (suC,sul,ar);                                                             //< -2.0.1
              aTik := TikAR (suCs,sul,ar); //<AR, koska sulakkeen kestettävä se. YR vain poiskytk.ajalle #####
      UNTIL (aTik>=Otim) AND (sul>=aFin)  OR  (sul=0);
                {''############ Kasvattaa sulaketta, koska TikAR < Tik, debugattu !!!! #############
                 ''######### Vaikuttaa tulosteisiin = 2.0.1 eroaa 2.0.0 :sta ja aiemmista ##########}
      result := sul;
   END;//fSul

   function fKwDes(kW :real) :string;      VAR u :integer;      begin//+120.5k
      if kW<0.1  then u := 3  else
      if kW<1    then u := 2  else u := 1;
      result := fRmrkt0(kW,1,u);  end;
//..........................................      ,PALAUTTAA: L[m] kun Uh=10% Ist:llä ja 3% In :llä
   FUNCTION fLuh10 (os,oh :integer;  AlCu :boolean; //<oh = 1=Pn  muu=lasketaan Pmax :lle, vrt. DET
                    Okw,Ocos{120.5k} :Real;  Onap  :Integer;
                    Okaax :Integer;  Omm :Real;  VAR str :string) :Real;      //<Omm =Amm2
      CONST CLB=COLOR_BLUE;
      VAR r8,x8,rU{,ra,rr{11.0.1},nCos, nSin,sCos,sSin,rE{:120.5k:},xE, Lnim,Lstart,Les,Len, rIn,rIs :Real;
          i :integer;   KaTyp,s,sa{, Lfn{120.5k} :string;   (*Lst{120.5k} :TStringList;*)           BEGIN
    {'Vois muuttaa glob.  =>  SYÖTTÖ:  I,cos,katyyppi('C') <<<<<<<<<<<<<<<<<<
     Lasketaan häviö PÄÄ'JÄNNITTEENÄ' ja verrataan PÄÄJÄNNITTEESEEN TAI
     VAIHEjohtimelle ja verrataan VAIHEjännitteeseen (kuten tässä).@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-6.0.3:
      uh%= 100I(Rcos + Xsin)/Un => 100IL(rCos+xSin)/Uv,             josta ratkaistaan L:
      L = uh%Uv / [100I*(r*Cos + x*Sin)].                           Kun sin = V¨(1-Cos²):
      L = uh%Uv / [100I*( r*Cos + x*V¨(1-Cos²) )].                  '##################'
+6.0.3:
      uh%= V¨3 I(Rcos + Xsin) *100/Un => V¨3 IL(rCos+xSin)*100/Un,  josta ratkaistaan L:
      L = uh%*Un / [V¨3 100*I* (r*Cos + x*Sin)].                    Kun sin = V¨(1-Cos²):
      L = uh%*Un / [V¨3 100*I* (r*Cos + x*V¨(1-Cos²) )].            '####################'
      ''Ei vaikutusta edelliseen, koska nyt nimittäjässä V¨3 korjaa takaisin = LOPPUTULOS ON SAMA.
      ............................''''''''''sin #################################################}
   mrk := ' ';                                            //VIRHEITÄ havaittu 120.5k:  - rE summattu moottRj´oon.
   IF (Omm<=0)  OR  (Okaax=0)  THEN  Result := 0          //                           - Istr laskennassa oli nCos, korjattu sCos´iksi
   ELSE BEGIN
      KaTyp := fKaTyp (AlCu);                //<MCMK tai AMCMK <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        s := Trim (MoFrm.VrkCmBx.Text);        //<Verkkopiste, mihin Mo-keskus on liitetty.              <,,11.0.1
        SokI (s,i);
        s := MoFrm.EdiY1.Text; //,TÄSSÄ TUTKITTAVISSA, KUINKA edVERKKOA LASKETAAN MUKAAN.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
{oli ra}rE := edRv (1,i,50);                   //<Esim. "1" =Ekan edj:n JÄLKEEN VASTA, eli RA =ekan edj:n Rv.     .005437
        if (s<>'')  and (s[1]='@')  then rE := 0; //<,,Antamalla "Kuvaus:" -kenttään ekaxiMrksi "@" =>Edv ohittuu KOEAJOSSA.#################################
      r8 := res (KaTyp,Omm) / Okaax;              //<Moottorin rj. 'Turha nykyään =sama jos vp=0.
{ra+} r8 := {rE +}rTkorj (AlCu,r8, 50);           //<r8 = Rrj/m,  50°C, uh% StartVirranMuk <<<<<<<<<<<< rE=edRv =Ei saa summata rj´oon =vex -120.5k §§§§§§§§§
{oli ra}xE := edXv (1,i);
        if (s<>'')  and (s[1]='@')  then xE := 0;
      x8 := {xE +}Xv_ind (KaTyp,Omm) /Okaax;   //<x8 = Xrj/m <<<<<<<<<<<<<<<<<<<<<<<<<<<<''11.0.1<<< xE=edXv =Ei saa summata rj´oon =vex -120.5k §§§§§§§§§§§§
                        {Lst := TStringList.Create;  Lfn := IncludeTrailingPathDelimiter(ExtractFilePath (Application.ExeName))  +'MootAjoDet.txt';
                         if FileExists(Lfn)  then                                    //,,IDEA: Kirjoitetaan kukin arvo =ed. arvo ennen virhettä näkyy filessä.
                            Lst.LoadFromFile (Lfn);
                         Lst.Add('Okw: '+fRmrkt0(Okw,1,2) +' ' +Ints(Onap));}
      nCos := Ocos;                           //fCos (Okw,Onap) -120.5k:  Annetulla Cosinilla.
                         //Lst.Add('nCos: '+fRmrkt0(nCos,1,6));
      nSin := Sqrt(1- Sqr(nCos));             //<+120.5k: sSin = V(1-Cos²).
                         //Lst.Add('nSin: '+fRmrkt0(nSin,1,2));

      rIn := fIn (Okw,nCos,Onap);             //<'120.5k
                         //Lst.Add('rIn: '+fRmrkt0(rIn,1,2));

      sCos := fScos (Okw,Onap);
                         //Lst.Add('sCos: ' +fRmrkt0(sCos,1,6));
      sSin := Sqrt(1- Sqr(sCos));             //<+120.5k: sSin = V(1-Cos²).
                         //Lst.Add('sSin: '+fRmrkt0(sSin,1,6));
      rIs := fIst (Okw,sCos,Onap);            //<fIst laskee Is/In suhteen mukaan. NÄIN vaikka ANNETTUcos eri.
                         //Lst.Add('rIs: '+fRmrkt0(rIs,1,2));
                         //Lst.SaveToFile(Lfn);
{rU := fUmh / Sqrt(3);                         //<Uv =690/V(3) =398V ,,Tässä lasketaan uh%´t =selvitetään jälkikäteen Zedv +Zmootj´n uh%.####################
rr := 100*rI/rU;
rr := rI* (rE*nCos + xE*nSin)*100/rU;          //<Zedv´n uh%=0,298% (2x240cu 120m)
rU := rI* (r8*nCos + x8*nSin)*136*100/rU;      //<Zmootj´n uh%.
rU := rr +rU;                                  //<uh%=(2x240cu 120m) + MootRj=136m
if rU<0  then ;}                               //<'rU =uh%(Edv+Mj)

rU := fUmh / Sqrt(3);                          //<Uv =690/V(3) =398V   Tässä taas jotta jos ed. testiajo muutti alp. sijoituksen.
         //-----------------------------------------------------------------------------------------------------------------
  //Alp: then Lnim := 10*fUmh  /( Sqrt(3)*100 *rI *( r8 *nCos + x8 *Sqrt (1- Sqr (nCos)) ) )                      < =uh%=10% Ist :llä
  //     else Lnim := 10*fUmh  /( Sqrt(3)*100 *rI *( rE *1 ));                                                   'fUmv=>fUmh ja Sqrt(3)* =+6.0.3
         //            uh%=100 I(R cosF +XsinF)/Uv                                                               <VTT
         //            uh%= 3 (R*cosF + X*sinF) * 100 / U        = (PR + QX) * 100 / U²                          <NjTl31.INC´stä.  I = P/(Uv/ V(3))
         //            uh%=100 I*[_(rE +r8*L2)cosF +(xE +x8*L2)sinF_] /Uv
         //            uh%=  100 I*( rE*cosF +xE*sinF +r8*L2*cosF +x8*L2*sinF ) / Uv
         //            uh%Uv=100 I*( rE*cosF +xE*sinF) + 100 I*(r8*cosF +x8*sinF )*L2
         //           [uh%Uv -100*I*(rE*cosF +xE*sinF)] / [100 I*(r8*cosF +x8*sinF)] = L2
         //U >>>>>>>>> L2 = uh%Uv -100*I*(rE*cosF +xE*sinF) / (100 I*(r8*cosF +x8*nSin )                         <rE+xE´ssä L1 jo mukana.
      if sCos<1                                //<Varm.vuoksi +6.0.0.  +6.0.3: fUmv => fUmh, joka helppo muuttaa.  L = f(In,nCos..) §§§§§§§§§§§§§§§§§§§§§§§§§
         then Lstart := (10*rU - 100*rIs* (rE*sCos +xE*sSin)) / (100*rIs*(r8*sCos +x8*sSin))                      //<Uudella algoritmillä 120.5k.
         else Lstart := (10*fUmh /( Sqrt(3)*100*rIs ) ) -  rE *1;                                                 //<' fUmv=>fUmh ja Sqrt(3)* =+6.0.3
      if sCos<1       //''L = f(Is,sCos..)  ,,L = f(In,nCos..)
         then Lnim := (10*rU - 100*rIn* (rE*nCos +xE*nSin)) / (100*rIn*(r8*nCos +x8*nSin))                      //<Uudella algoritmillä 120.5k.
         else Lnim := (10*fUmh /( Sqrt(3)*100*rIs ) ) -  rE *1;                                                 //<' fUmv=>fUmh ja Sqrt(3)* =+6.0.3
      IF Lnim < Lstart          //<,,+120.5k
         then result := Lnim
         else result := Lstart;
//UUSI ======================================================================================================================================================
      if DetNyt and det  and (Lstart>Ljmin)  then begin  //<Ljmin=1 ainako?  DetNyt ohjaa:  1.krt) FA=LxSu´n arvo  2.krt) TR=LxSu´n arvo +detaljit.
         sisVex;
         if MoDetFrm.aRich.Lines.Count=0  then begin                                                   //<,,+120.5k:  Vain kerran.
            s := '<b><...  =Ennen versiota ...   ' +FONT_SUURPI +'...  =Versiossa ... ja sen jälkeen</b>.  Huom. erot: uh% ja (Nimel:) In,nCos vs. (Start:) Is,sCos.';
            adSt_(s);  sisA;
            //ad1S_(s);  sisA;
         end;//if ..Count=0
//UUSI Lstart ===============================================================================================================================================
//120.5k: Lstart := (10*rU - 100*rIs* (rE*nCos +xE*nSin)) / (100*rIs*(r8*nCos +x8*nSin))
         s := CLB+'<b>'+FONT_SUURPI +'</b>12.0.5k:</f> LxSu (Is)=[uh%Uv - 100*Is*(Redv*sCos' +FONT_FII +'+(Xedv*sSin' +FONT_FII +')] / [100*Is*(r*sCos' +FONT_FII +
                                             ' +x*sSin' +FONT_FII +')].     ';
         if Okaax>1  then s := s +fImrkt0 (Okaax,1) +' á ';
         s := s +CLB +KaTyp +'  ';                                             //,Str Samanpituiseksi AMCMKn kanssa
         for i := Length (KaTyp) to Length ('AMCMK') -1  do s := s +'  ';
         if Omm<3  then s := s +fRmrkt0(Omm,1,1)  else s := s +fRmrkt0(Omm,1,0);
         s := s +' mm²   <b>';
         with MoFrm  do//StrGrd
         if oh=1  then s := s +'Pn : '
                  else s := s +'Pmax : ';                                     //,,Tämäpisin rivi, tarkisteta Frmn leveys.
         s := s +fKwDes(Okw) +'</b> kW.</f>';                                 //<120.5k:  fRmrkt0(Okw,1,3) => fKwDes(Okw)
           sa := TagVex(s);
           ai := fMSpixPit (1,sa) +300;                                       //<120.5k:  1=MS Sans Serif.
         (*if (ai>PixL) and (ai<=Trunc(Screen.Width/3))                       //<-"-      Jos PixPisin S ja pienpi kuin Screen/3
              {and ai>MoDetFrm.Width)  }then begin                            //<Ei worki tarkasti
              MoDetFrm.Width := ai;
              PixL := ai;
              //Update;//Refresh;
           end;*)
           if MoDetFrm.Width<DetWdth  then                                    //<+120.5k
              MoDetFrm.Width := DetWdth;
       adSt_ (s +'</b>');  //sisA;                                            //<Sisennys aiheuttaa FF

         s := 'LxSu (Is)=(10%*'+fRmrkt0(fUmh,1,2)+'V/'+FONT_2JUURI+'3) *100*' +fRmrkt0 (rIs,1,2)+'A *('+
                                  fRmrkt0 (rE,1,8) +FONT_OMEGA +'*' +fRmrkt0 (sCos,1,3)+ ' +' +
                                  fRmrkt0 (xE,1,8) +FONT_OMEGA +'*';// +fRmrkt0 (sSin,1,3)+ ')';
         if nCos<1                                                        //<Varm.vuoksi +6.0.0
            then s := s +fRmrkt0(sSin,1,3)
            else s := s +'0.000';
         s := s +')] = <b>'+fRmrkt0 (Lstart,1,1)+'m   TAI</b>';
       ad1SF (s);
//UUSI Lnimel================================================================================================================================================
         str := '';                                           //<  Lstr < Lnim = In(L=Lstr) pienempi kuin Is(L=Lnim)
         IF Lnim < Lstart  THEN BEGIN
           {Lnim := Lstart;}  str := COLOR_PUDVAL +'°</f>';  END;//<Jos In :n Uh%=3% määräävä, tiedoksi '°' -mrk

  //Alp: then Lnim := 10*fUmh  /( Sqrt(3)*100 *rI *( r8 *nCos + x8 *Sqrt (1- Sqr (nCos)) ) )                      < =uh%=10% Ist :llä
  //     else Lnim := 10*fUmh  /( Sqrt(3)*100 *rI *( rE *1 ));                                                   'fUmv=>fUmh ja Sqrt(3)* =+6.0.3
         s := 'LxSu (In)=  (3%*'+fRmrkt0(fUmh,1,2)+'V/'+FONT_2JUURI+'3) *100*'+fRmrkt0 (rIs,1,2)+'A *('+
              fRmrkt0 (r8,1,8) +FONT_OMEGA+'*'+fRmrkt0 (sCos,1,3)+' +'+fRmrkt0 (x8,1,8) +FONT_OMEGA +'*';
         if sCos<1                                                         //<Varm.vuoksi +6.0.0
            then s := s +fRmrkt0(sSin,1,3)
            else s := s +'0.000';
         s := s +')] = <b>'+fRmrkt0 (Lnim,1,1)+'m</b>.';{+fImrkt0 (os,1)}
       ad1SF (s);
       sisVex;

         if oh<>1  then begin //<Jotta vain kerran -- fLuh10_kutsutaan 2 x per Cu + Al,,,,,,,,,,,,,,,
            s := '- - - t=' +fRmrkt0(timQ,1,3) +'s  ->  sysKerr=' +fRmrkt0(sys_ker(rE+r8,xE+x8), 1,3) +'     '+  //<r8,a8=OK, eiTartte (r8*Lnim,x8*Lnim)
                 'm_tasavirtaKerr=' +fRmrkt0(m_tasav(sys_ker(rE+r8,xE+x8), timQ), 1,3)+
                 '     (R/X=' +fRmrkt0((rE+r8)*Lnim, 1,6) +'/' +fRmrkt0((xE+x8)*Lnim, 1,6) +'=' +fRmrkt0((rE+r8)/(xE+x8), 1,3) +')';
            ad1SF(s);
            s := '- - - t=0.010s  ->  sysKerr='+fRmrkt0(sys_ker(rE+r8,xE+x8), 1,3) +'     '+                    //<r8,a8=OK, eiTartte (r8*Lnim,x8*Lnim)
                 'm_tasavirtaKerr='+fRmrkt0(m_tasav(sys_ker(rE+r8,xE+x8), 0.01), 1,3) +'  <=  Startissa.  R/X=Sis. ed.verkko - - -';
            ad1SF(s);


            //???sisVex; // = '</in>'
         end;
//ALP  Is aCos := fScos (Okw,Onap) ==========================================================================================================================
//Vanha laskentatapa ennen 12.0.5k:
//   :   then Lnim := 10*fUmh  /( Sqrt(3)*100 *rI *( r8 *nCos + x8 *Sqrt (1- Sqr (nCos)) ) )                      < =uh%=10% Ist :llä
//       else Lnim := 10*fUmh  /( Sqrt(3)*100 *rI *( rE *1 ));                                                   'fUmv=>fUmh ja Sqrt(3)* =+6.0.3
{       ra := edRv (1,i,50);                   //<Esim. "1" =Ekan edj:n JÄLKEEN VASTA, eli RA =ekan edj:n Rv.
        if (s<>'')  and (s[1]='@')  then ra := 0; //<,,Antamalla "Kuvaus:" -kenttään ekaxiMrksi "@" =>Edv ohittuu
      r8 := res (KaTyp,Omm) / Okaax;              //   KOEAJOSSA.################################################
      r8 := ra +rTkorj (AlCu,r8, 50);             //<r8 = Rrj/m,  50°C, uh% StartVirranMuk <<<<<<<<<<<<
        ra := edXv (1,i);
        if (s<>'')  and (s[1]='@')  then ra := 0;
      x8 := ra +Xv_ind (KaTyp,Omm) /Okaax;        //<x8 = Xrj/m <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<     <''11.0.1
      aCos := fCos (Okw,Onap);                    //<,,fIst laskee Is/In suhteen mukaan. NÄIN vaikka ANNETTUcos eri.
      ri := fIst (Okw,aCos,Onap);
      aCos := fScos (Okw,Onap);                   //<,,Startin Uh%-laskuissa StartCos, vaikka ANNETTUcos eri.@@@@@@
ra=>rE}
{r8 := fUmv;
if r8<0  then ;}
r8 := res (KaTyp,Omm) / Okaax;
r8 := rE +rTkorj (AlCu,r8, 50);
x8 := xE +Xv_ind (KaTyp,Omm) /Okaax;
nCos := fCos (Okw,Onap);       //Oli: aCos        //<,,fIst laskee Is/In suhteen mukaan. NÄIN vaikka ANNETTUcos eri.
//nSin := Sqrt(1- Sqr(nCos));
rIs := fIst (Okw,nCos,Onap);                      //<fIst haluttu laskea em. Cos´illa.
sCos := fScos (Okw,Onap);                         //<Alp´ssä oli eri Cos.
//sSin := Sqrt(1- Sqr(sCos));
      if nCos<1                                 //<Varm.vuoksi +6.0.0.  +6.0.3: fUmv => fUmh, joka helppo muuttaa.
        {then Les := 10*fUmh / ( Sqrt(3)*100 *rIs *( r8 *sCos + x8 *Sqrt (1- Sqr (sCos)) ) ) //< =uh%=10% Ist :llä @@@@@@
         else Les := 10*fUmh / ( Sqrt(3)*100 *rIs *( r8 *1 ));     //<' fUmv=>fUmh ja Sqrt(3)* =+6.0.3}
         then Les := 10*fUmv / ( 100 *rIs *( r8 *sCos + x8 *Sqrt(1- Sqr(sCos)) ) ) //< =uh%=10% Ist :llä @@@@@@
         else Les := 10*fUmv / ( 100 *rIs *( r8 *1 ));                             //<' fUmh ja Sqrt(3) => fUmv

      sisVex;
///////- s := '<12.0.5k: LxSu (Is)=10%Un / ['+FONT_2JUURI+'3 *100*Is*((Redv+r)*sCos'+FONT_FII +' + (Xedv+x)*sSin'+FONT_FII +')].     ';
         s := '<12.0.5k: LxSu (Is)=10%Umv / [100*Is*((Redv+r)*sCos'+FONT_FII +' + (Xedv+x)*sSin'+FONT_FII +')].     ';
       //s :=           'LxSu (Is)=Uh%Un/['+FONT_2JUURI+'3 *100*I*(rCos'+FONT_FII +' + xSin'+FONT_FII +')].     ';
         if Okaax>1  then s := s +fImrkt0(Okaax,1) +' á ';
         s := s +KaTyp +'  ';                                        //,Str Samanpituiseksi AMCMKn kanssa
         for i := Length(KaTyp) to Length('AMCMK') -1  do s := s +'  ';
         if Omm<3  then s := s +fRmrkt0(Omm,1,1)  else s := s +fRmrkt0(Omm,1,0);
         s := s +' mm²   <b>';
         if oh=1  then s := s +'Pn : '
                  else s := s +'Pmax : ';
         s := s +fKwDes(Okw) +'</b> kW.';                                 //<120.5k:  fRmrkt0(Okw,1,3) => fKwDes(Okw)
      //adSt_(s +'</b>');  sisA;                                  //<Sisennys aiheuttaa FF
      //ad1S_(s +'</b>');  //sisA;                                  //<Sisennys aiheuttaa FF
      adStF(s +'</b>');                                           //<Sisennys aiheuttaa FF

///////- s := 'LxSu (In)=10%*'+fRmrkt0(fUmh,1,2)+'V/['+FONT_2JUURI+'3 *100*'+fRmrkt0(rIs,1,2)+'A*('+
         s := 'LxSu (In)=10%*'+fRmrkt0(fUmv,1,2)+'V / [100*'+fRmrkt0(rIs,1,2)+'A*('+
              fRmrkt0(r8,1,8)+FONT_OMEGA+'*'+fRmrkt0(nCos,1,3)+'+'+fRmrkt0(x8,1,9) +FONT_OMEGA +'*';
         if nCos<1                                                  //<Varm.vuoksi +6.0.0
            then s := s +fRmrkt0(Sqrt(1- Sqr(nCos)),1,3)
            else s := s +'0.000';
         s := s +')] = <b>'+fRmrkt0(Les,1,1) +'m   TAI</b>';
      ad1SF(s);                      //,,In + nimCos mukaan ############################################
   nCos := a_getReaa(30221,mo.motr[os].cos);                 //<Muutettu versioon 1.0.7 => 1.0.8
 //rIs := fIn(Okw,nCos,Onap);
      if nCos<1                                                                 //<Varm. vuoksi +6.0.0
        {then Lsrt :=  3*fUmv /( 100 *ri *( r8 *aCos + x8 *Sqrt(1- Sqr(aCos)) ) ) //< =Uh%=3% In :llä @@@@@@@@
         else Lsrt :=  3*fUmv /( 100 *ri *( r8 *1));                                //<',Lopputulos sama. -6.0.3}
         then Len :=  3*fUmh /( Sqrt(3)*100 *rIn *( r8 *nCos + x8 *Sqrt(1- Sqr(nCos)) ) ) //< =Uh%=3% In :llä @@@@@@@@
         else Len :=  3*fUmh /( Sqrt(3)*100 *rIn *( r8 *1));
      str := '';                                           //<  Lsrt < Lnim = In(L=Lsrt) pienempi kuin Is(L=Lnim)
      IF Len < Les  THEN BEGIN  {Lnim := Lsrt;  }str := '°';  END; //<Jos In :n Uh%=3% määräävä, tiedoksi '°' -mrk
      s := 'LxSu (In)=  3%*'+fRmrkt0(fUmh,1,2)+'V / ['+FONT_2JUURI+'3 *100*'+fRmrkt0(rIn,1,2)+'A*('+
           fRmrkt0(r8,1,8) +FONT_OMEGA+'*'+fRmrkt0(nCos,1,3)+'+'+fRmrkt0(x8,1,9) +FONT_OMEGA +'*';
      if nCos<1                                                         //<Varm.vuoksi +6.0.0
         then s := s +fRmrkt0(Sqrt(1- Sqr(nCos)),1,3)
         else s := s +'0.000';
      s := s +')] = <b>' +fRmrkt0(Len,1,1)+'m.</b>';{+fImrkt0(os,1)}
      ad1SF(s);
      if oh<>1  then //<Jotta vain kerran -- fLuh10_kutsutaan 2 x per Cu + Al,,,,,,,,,,,,,,,
         ad1SF('- - - t='+fRmrkt0(timQ,1,3) +'s  ->  sysKerr='+fRmrkt0(sys_ker(r8,x8), 1,3) +'     '+  //<r8,a8=OK, eiTartte(r8*Lnim,x8*Lnim)
         'm_tasavirtaKerr='+fRmrkt0(m_tasav(sys_ker(r8,x8), timQ), 1,3)+
         '    (R/X='+fRmrkt0(r8*Lnim, 1,6) +'/'+fRmrkt0(x8*Lnim, 1,6) +'='+fRmrkt0(r8/x8, 1,3) +')');
         ad1SF('- - - t=0.010s  ->  sysKerr='+fRmrkt0(sys_ker(r8,x8), 1,3) +'     '+  //<r8,a8=OK, eiTartte(r8*Lnim,x8*Lnim)
         'm_tasavirtaKerr='+fRmrkt0(m_tasav(sys_ker(r8,x8), 0.01), 1,3) +
         '  <=  Startissa.  R/X=eiEd.verkko - - -');
      end;//if det  and ..
   END;//IF (Omm<=0) ..
   END;//fLuh10
   //............................................
   PROCEDURE asmm2 (os :integer;  tapa :string;  suCs :string;  sul :Integer;  minL,korj :Real;  kW :real;  nap :integer;
                    VAR CUx :Integer;  VAR CUmm2,CUmaxL :Real;  VAR CUchr,CUoikSChr :string;   //CUmaxL
                    VAR ALx :Integer;  VAR ALmm2,ALmaxL :Real;  VAR ALchr,ALoikSChr :string);
         VAR johdtOK :Boolean;  Inm,Ijs,Ijk :Real;

      PROCEDURE kasvaA (VAR mm2 :Real);
         PROCEDURE sij (A :Real);   BEGIN  mm2 := A;  END;
      BEGIN CASE Trunc(mm2) OF        //<<,,111=Alkutilanne 1.5 :lle<<<<<<<<<<<<
               111:sij(1.5);   10 :sij( 16);    50 :sij( 70);   150 :sij(185);
                1 :sij(2.5);   16 :sij( 25);    70 :sij( 95);   185 :sij(240);
                2 :sij(  6);   25 :sij( 35);    95 :sij(120);  {240 :sij(300);}
                6 :sij( 10);   35 :sij( 50);   120 :sij(150);      //'300eioo _MCMK
              ELSE sij(  0);  END; END;
      FUNCTION fIJohdSal (Isul :Integer;  tyyp,tapa :string;
                          korj,amm2 :Real;  kpl :Integer) :Real;     BEGIN
         Result := YvSuoj (suCs,TRUE,TRUE,tapa,korj,tyyp,amm2,kpl);  END;
                                      //1xSu'Katk'------------------------------<<<<<<<<<<<<<<<<<<<<<<<
   BEGIN //asmm2         ''''''''''''Ei tarvita, koska SULAKE vain oikos.suojana<<<<<<<<<<<<<<<<<<<<<<<
      WITH mo.motr[os]  DO Inm := fin (a_getReaa (30211,kw),a_getReaa (30212,cos),a_getIntg (30213,nap));

      CUx := 0;            //,,Cu-kaapeli @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      REPEAT CUx := CUx +1;
             IF CUx=1  THEN CUmm2 := 111{,9.11.96}
                       ELSE CUmm2 := 25;{oli 95}       //<Eka rinnak.=35mm2, turha iteroida pienempiä.
         REPEAT
            johdtOK := FALSE;  CUoikSChr := '';        //<+7.0.3
            kasvaA (CUmm2);
            WITH mo.motr[os]  DO //,Cu,                //,,Ijs=Johdon maxYlivS   Ijk=Johdon maxOikoS
            Ijs := fIJohdSal (sul,'MCMK',a_getStrg (30216,asT), a_getReaa (30217,korj),CUmm2,CUx);
            Ijk := OikSuoj  (suCs,'MCMK',CUmm2,CUx); //<Yhteiset suojat =Ei rinnakkaisia OikSuojia =Yksi JOHTO määrää
                                               //,Johdn ylivS (1xIjs) oltava >= Inm JA oikosKestoisuus >= 1xSULake.
            if (Ijs >= Inm)//AND  (Ijk >= sul) //<'Nyt JOHDOT määräytyy In mukaan =Moott.suojakytkn myös johdnsuojna
               THEN BEGIN  CUmaxL := fLuh10 (os,1,FALSE, kW,mo.motr[os].cos.ArvoRea,nap,CUx,CUmm2, CUchr); //< 1=Uh Pn :lle, TR=Cu  '-7.0.3
                           if CUmaxL>minL  then           //''''''''+120.5k''''''''
                              johdtOK := TRUE;
                           if Ijk < sul    then CUoikSChr := '«';  END //<SUL liian iso johdolle  +7.0.3 »
               ELSE johdtOK := FALSE;
         UNTIL johdtOK  OR  (CUmm2=0);
      UNTIL    johdtOK  OR  (CUmm2=0) AND (CUx=20);
                           //,,Al-kaapeli @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ALx := 0;  ALmm2 := 0;
      IF CUmm2>=16  THEN
      REPEAT ALx := ALx +1;                          //#########################
             IF ALx=1  THEN ALmm2 := 16 {,9.11.96}   //<Eka AMCMK=25mm2<<<<<<<<<
                       ELSE ALmm2 := 25;{oli 95}     //<Eka rinnak.=35mm2,A1:ssä oli Cu120,Al150, nyt keinotekoinen
         REPEAT
            johdtOK := FALSE;  ALoikSChr := '';      //<+7.0.3
            kasvaA (ALmm2);
            WITH mo.motr[os]  DO //,Al
            Ijs := fIJohdSal (sul,'AMCMK',a_getStrg (30218,asT), a_getReaa (30219,korj),ALmm2,ALx);
            Ijk := OikSuoj  (suCs,'AMCMK',ALmm2,ALx);
            if (Ijs >= Inm) //AND  (Ijk >= sul) //<'Nyt JOHDOT määräytyy In mukaan =Moott.suojakytkn myös johdnsuojna
               THEN BEGIN  ALmaxL := fLuh10 (os,1,TRUE,  kW,mo.motr[os].cos.ArvoRea,nap,ALx,ALmm2, ALchr); //< 1=Uh Pn :lle, TR=Al  '-7.0.3
                           if ALmaxL>minL  then johdtOK := TRUE; //'''''+120.5k''''
                           if Ijk < sul    then ALoikSChr := '«';  END //<SUL liian iso johdolle  +7.0.3 »
               ELSE johdtOK := FALSE;
         UNTIL johdtOK  OR  (ALmm2=0);
      UNTIL    johdtOK  OR  (ALmm2=0) AND (ALx=20);        {curpak;}
   END;//asmm2
   //...........................................       //<,,,,MAX_kW  N*mm2 :lle
   FUNCTION fMm2Pmax (AlCu :boolean;  Okw :Real;  Onap :Integer;  Okaax :Integer;  Omm :Real;  VAR uuSUL :Integer) :Real;
      VAR edSUL,{edN,uuN,}i,j    :Integer;   KaTyp :string;
          {edA,}uuA, uP,uCos,por :Real;      {ar,}ur,rr,{xCos,}xP :Real;
   BEGIN //fMm2Pmax
      KaTyp := fKaTyp (AlCu);
      with mo.motr[os]  do uuA := YvSuoj (suCs,TRUE,TRUE,a_getStrg (30221,asT),a_getReaa (30222,korj),KaTyp,Omm,Okaax);
                        //'uuA apuna--------YhtSuoj'Kat '.....................'......................'.....'mm2'kpl  '
      uuSUL := 2000;                         //'''KAT jotta ei huomioisi Ksul
      WHILE (uuSUL > uuA) AND (uuA > 0)  DO pienIsul (uuSUL);
      edSUL := uuSUL;                        //,,Koska johto määriteltiin moo
      IF uuSUL<rj_SUL  THEN edSUL := rj_SUL; //<ttorin In:n perust (asmm2) ja
                                             //rj_SUL Ist:n muk, saattaa YvSuo
                                             //ollaPienpi. MoottSuoja=YvSuoja
   nopeus := 1; //<Tarkka  0=Nopea
   IF edSUL=0                    //,,,ITEROITAVA, koska uP riippuu Cos=f(uP),
   THEN  uP := Okw               //   uP=f(Cos), StN=f(uP), Tim=f(uP) !!!!!!!
   ELSE BEGIN                    //,,,MUOKDES() fCos,fTim:ssa TŽRKEITŽ, JOTTA
   IF nopeus=0                   //   SYÖTETTÖESSÄ Pmax, OLET OLTAVA SAMAT, J
   THEN BEGIN                    //   OTTA fSul tms.EI VALITSISI ERI ARVOA !!
      //################### 0 = NOPEA, EPÄTARKKA uP :lle ####################
              {uP    := Umo/1000 *0.9*edSUL * Sqrt(3) *uCos *fEta (Okw,Onap);}
      uP := Okw;                      //<Alkutilanne uP :lle<<<<<<<<<<<<<<<<<
      xP := 0;
    //uCos := fCos (Okw,Onap);        //<RESERV NIMcos muk=Alkutil. uCos :lle //=..never used
      i :=   0;   j := 0;
      REPEAT i := i+1;
           //xCos := uCos;                               //<Vain UNTIL takia<
             {xP   := uP;}                      //<<<<<<<<<<<<<<<<<<<<<<<<<<<
             {IF uP > xP  THEN xP := uP;}
             uCos := fcos (uP,Onap);

           //ur := IkT (suC,edSUL, fTim (TRUE,uP,Onap));//<kestää fTim -ajan <<<<<<<<<<<<<<<<<<<<<<< -2.0.1
             ur := Ikt{AR} (suCs,edSUL, fTim (TRUE,uP,Onap));  //<IkT =Ik jota edSUL kestää fTim -ajan
             with mo.motr[os]  do IF a_getReaa (30226,tim) > ur  THEN ur := a_getReaa (30227,tim);
             ar := ur / fStN (uP,Onap);                      //<<<ar := MOOTTORIN NIMELLISVIRTA
                                                             //jokaSaad Ikt:sta Ist/InKertoimla
           //uP := Umo/1000 * ar * 0.9 * Sqrt(3) * uCos * fEta (uP,Onap);     //<alp
           //      In = Pn / ( (fUmv/1000) * 3 * COS * eta;   ->   Pn = In * (fUmv/1000) * 3 * COS * eta;

             uP := fUmv/1000 * ar * 0.9 * 3 * uCos * fEta (uP,Onap);

           //IF uP > xP  THEN uP := xP   { + (uP-xP)/2;} ELSE
(*¤--------  IF uP = xP  THEN j := j+1
                         ELSE BEGIN xP := uP;  j := 0;  END;
                      {koe} IF  extra1  AND  NOT esi   THEN BEGIN  Curpos;
                      curxy (1,2{i}); eral; WRITE (' 1eS=',edSUL:3,' a=':7,
                      edA:5:1,' x=',edN:1,'  xP=',xP:6:2,' uCos=':12,xCos:1:2,
{17.11.96+}           ' Ik=');                   rr := fTim (TRUE,xP,Onap);
{17.11.96+}           with mo.motr[os]  do IF a_getReaa (30228,tim) > rr  THEN rr := a_getReaa (30229,tim);
{17.11.96+}           WRITE (IktA_R (suCs,edSUL,rr) :1:0);
                      WRITE (' In=',ar:1:1,' mm2=',Omm:1:1);
                      curxy(1,3{i+1}); WRITE (' 1uS=',uuSUL:3,' a=':7,uuA:5:1,
                      ' x=',Okaax:1,'  uP=',uP:6:2,' uCos=':12,uCos:1:2,' Ik=');
{17.11.96+}                                      rr := fTim (TRUE,uP,Onap);
{17.11.96+}           with mo.motr[os]  do IF a_getReaa (30230,tim) > rr  THEN rr := a_getReaa (30231,tim);
{17.11.96+}           WRITE (IktA_R (suCs,edSUL,rr) :1:0);
                      WRITE (' i=',i:1,' j=',j:1); eral;  jatka; curpak; END;
     {UNTIL  Abs (xP-uP) <= 0.1; Tilttasi, kun n4 4kW ko. oletuksilla}       -----------------------¤*)
      UNTIL  (xP >= uP)  AND  (j>2)    //<Kunnes toistaa itseään <<<<<<<<<<<<
             OR (i>20);                //<Varm vuoksi <<<<<<<<<<<<<<<<<<<<<<<
                     (*koe IF  extra1  AND  NOT esi   THEN  BEGIN curpos;
                        {IF NOT vaintul  AND  NOT esi THEN  BEGIN curpos;}
                       curxy(1,4); WRITE (' 2uS=',uuSUL:3,' a=':7,uuA:5:1,
                       ' x=',Okaax:1,'  uP=',uP:6:2,' uCos=':12,uCos:1:2,
                       ' PnSul=',fUmn/1000*edSUL*Sqrt(3)*uCos:1:1,' mm2=',Omm:1:1);
                       eral; {IF NOT esi  THEN jatka;  }curpak;  END;*)
   END//IF nopeus=0
   ELSE BEGIN
      //################### >0 = HIDAS, TARKKA uP :lle ######################
      uP := Trunc (Okw*10)/10 -0.1;     //< 13.56 -> 13.4 , 0.1=pienin porras
      IF uP<2   THEN uP := 2;           //<Valmiiksi isompi, VAARALLINEN<<<<<
      IF uP<55  THEN por := 10                             //< 1.por -> 1.0
                ELSE por := 100;                           //< 1.por -> 10.0
    //ur := por/10;  ar := uP;          //<koe: ur=alkupor,  ar=alkuP<<<<<<<< //=..never used ur, ar
    //i := 0;                           //<koe: i := <<<<<<<<<<<<<<<<<<<<<<<< //=..never used
      REPEAT por := por/10;                     //,,VAKkokoPORTAAN kohdalla A
         REPEAT//i := i+1;                      //,,INAvaihtuu COS+EETTA pare //=..never used
            uP :=    fMuokdes (uP +por,3);      //,,mmiksi ja sentakia joskus
            xP :=    uP;                        //<uP ei pääse kasvamaan tarp
          //uCos :=  fCos (uP,Onap);            //'eeksi,TODETTU, vrt. 60kW   //=..never used
          //xCos :=  uCos;                      //'->74.4 kun p.o. 76.7kW ### //=..never used
            uuSUL := 0;                       //<Merkataan testiä varten<<<<<
            IF por<0.9  THEN BEGIN            //<por/10 saattaa jättää .0099
               uP := xP+0.2;                  //<Muuten 6n -10% 1.1->3.3po4.1
               uCos := fCos (uP,Onap);
{17.11.96+}    rr := fTim (TRUE,uP,Onap);
{17.11.96+}    with mo.motr[os]  do IF a_getReaa (30236,tim) > rr  THEN rr := a_getReaa (30237,tim);
{17.11.96 }    uuSUL := fSul (uP,uCos,Onap,rr);
               IF (uuSUL>edSUL)  OR  (uuSUL=0)  THEN BEGIN
                  uP := xP+0.1;               //<Muuten 10n 0% 15->18.4po18.5
                  uCos :=  fCos (uP,Onap);
{17.11.96 }       uuSUL := fSul (uP,uCos,Onap,rr);
                  IF (uuSUL>edSUL)  OR  (uuSUL=0)  THEN uuSUL := 0; END; END;
            IF uuSUL=0  THEN BEGIN            //<0=Joko merkattu tai por<1&..
               uP := xP;
               uCos := fCos (uP,Onap);
{17.11.96+}    rr := fTim (TRUE,uP,Onap);
{17.11.96+}    with mo.motr[os]  do IF a_getReaa (30238,tim) > rr  THEN rr := a_getReaa (30239,tim);
{17.11.96 }    uuSUL := fSul (uP,uCos,Onap,rr);   END;
(*¤----------------- {koe} IF {}extra2  AND  {95}NOT esi   THEN  BEGIN Curpos;
                     curxy (1,2); eral; WRITE ('1E/U=',edSUL:3,'/',uuSUL:3,
                     ' a=',edA:5:1,' x=',edN:1,' ºuP=',uP:6:2,' i=',i:2,' ',
                     por:5:2,' º xP=',xP:6:2,' xCos=',xCos:1:2,' alP=',
                     ar:6:2); curpak; jatka; END; a-------------------------------------------------¤*)
         UNTIL  (uuSUL>edSUL) OR (uuSUL=0);     //<edSUL=maxSul Omm*Okaax:lle
            uP := fMuokdes (uP -por,1);         //<<PAKKO, muuten1.desVoiMuut
      UNTIL  por<0.105;          //<Toistuva por/10 aih.ep„tarkkTakia,TODETTU
(*¤----------------- {koe}IF {}extra2  AND  {95}NOT esi   THEN  BEGIN curpos;
                     curxy (1,3); eral; WRITE ('2E/U=',edSUL:3,'/',uuSUL:3,
                     ' alP=',ar:6:2,'  ºuP=',uP:6:2,' i=',i:2,' ',por:5:2,
                     ' º xP=',xP:6:2,' uCos=',uCos:1:2);   curpak; END; a---------------------------¤*)
   END;//IF edSUL=0 ELSE
   IF uP>=100  THEN uP := Trunc (uP);            //<Pakko, muuten 218.6-> 219
(*¤----------------- {koe} IF  extra1  AND  NOT esi   THEN WITH mo.motr[os] DO
                     BEGIN curpos; curxy (1,4); eral; WRITE ('Riv=',mno:2,
                     ' iter=',i:2,'x  Pkw___  Cos_  Eetta  START: Cos_  Ist__  *In t[s]_',
                     edSUL:3,'AsalSft');
                     eraln;
                     IF nopeus=0  THEN WRITE (' ':10)  ELSE WRITE ('1. =',ur:6:2);
                     WRITE ('  Pnim:',kw:6:2,fCos (kw,nap):6:2,fEta(kw,nap):7:3,
                       fScos (kw,nap):13:2,fist (kw,cos,nap):7:1,fStN
                       (kw,nap):5:1,tim:6:2,IktA_R (suCs,edSUL,tim)*KsftAR(suCs,,qj_sul):8:1,'alar');
                     eraln;
                     WRITE ('xP =',xP:6:2,'  Pmax:',uP:6:2,fCos (uP,nap):6:2,
                       fEta (uP,nap):7:3,fScos(uP,nap):13:2,fist (uP,fCos (uP,nap),
                       nap):7:1,fStN (uP,nap):5:1);
{17.11.96+}                                       rr := fTim (TRUE,uP,Onap);
{17.11.96+}            with mo.motr[os]  do IF tim > rr  THEN rr := tim;
{17.11.96 }          WRITE (rr:6:2,IktA_R (suCs,edSUL,rr*KsftAR(suCs,qj_sul)):8:1,'alar');
                     eraln;
                     WRITE (Okaax:1,'Cu_');  IF Omm>3  THEN WRITE (Trunc(Omm):1,
                       ': ')  ELSE WRITE (Omm:1:1,': ');    WITH mo.motr[os]  DO
                       YvSuo (1,TRUE,{FALSE}TRUE,asT,korj,FALSE,'C',Trunc(Omm),Okaax,ar);
                     IF (xAl>0) AND (mmAl>0)  THEN WITH mo.motr[os]  DO  BEGIN
                       eraln;
                       eral;  WRITE (xAl:1,'Al_');   IF mmAl>3  THEN WRITE (
                       Trunc(mmAl):1,': ')  ELSE WRITE (mmAl:1:1,': ');
                       YvSuo (1,TRUE,{FALSE}TRUE,asT,korj,TRUE,'C',Trunc(mmAl),xAl,ar); END;
                     WRITE ('(Ksul=1.00) '); eraln;
                     IF (xAl=0) AND (mmAl=0)  THEN eral;       //<Pyyhit van
                     curpak; END;                               //ha Al-rivi a----------------------¤*)
   END;//IF edSUL=0 ELSE
   fMm2Pmax := uP;
   uuSUL :=    edSUL;
END;//fMm2Pmax
//............................................
BEGIN//RJarvot
IF a_getIntg (30251,mo.motr[os].kpl) >0  THEN BEGIN
   WITH mo.motr[os] DO BEGIN
      kwQ :=  a_getReaa (30252,kw);    cosQ :=  a_getReaa (30253,cos);
      timQ := a_getReaa (30254,tim);   korjQ := a_getReaa (30255,korj);
      astQ :=  a_getStrg (30257,asT);  //napQ := a_getIntg (30256,nap);
      napQ := mo.motr[os].nap.ArvoInt;  //<+130.0
      rj_sul := 0;

      rj_xCU := 0;           //=============CU-KAAP,,,
      rj_mmCU := 0;
      rj_LmaxCU := 0;
      rj_ChrCU := '';  SulCUc := '';
      rj_PmaxCU := 0;
      rj_LmaxPmaxCU := 0;
      rj_ChrPmaxCU := '';

      rj_xAL := 0;           //=============AL-KAAP,,,
      rj_mmAL := 0;
      rj_LmaxAL := 0;
      rj_ChrAL := '';  SulALc := '';
      rj_PmaxAL := 0;
      rj_LmaxPmaxAL := 0;
      rj_ChrPmaxAL := '';

      i := fSul (kwQ,cosQ,napQ,timQ);                 //<Vois kutsua suoraan Moot.INC :ssä
      rj_SUL := i;                                    //,Palauttaa CU + AL,,,,,,,,,,,,,,,,..........
      asmm2 (os,astQ,suCs,rj_SUL,Ljmin,korjQ, kwQ,napQ, rj_xCU,rj_mmCU,rj_LmaxCU,rj_ChrCU,SulCUc, //rj_LmaxCU => qj_LmaxCu
                                                        rj_xAL,rj_mmAL,rj_LmaxAL,rj_ChrAL,SulALc);
                                    {'FNC asmm2:ssa otettu täysi kuormitettavuus, joten eroa ei voi
                                      olla Kat-Sul:lla, eroa ei voi olla myöskään RAJApituudessa !!}
    //:::::::::::::::::::::::::::::::::::::::: RajaL SYÖTETYLLE KONEELLE=====Cu=====================
      IF rj_LmaxCU>0
      THEN BEGIN
         ar := fMm2Pmax (FALSE, kwQ,napQ,rj_xCU,rj_mmCU, ai);
         IF ar>0  THEN BEGIN                          //,,,,, Pmax_Sul_Raja ########################
            IF ar<kwQ  THEN BEGIN ar := kwQ;          //<SaattoiJäädäPienmksi
                                  ai := rj_SUL; END;  //uCos:nTakia.TimKorjtu
            rj_PmaxCU := ar;                                    //<Pmax======
          //rj_SUmax :=  ai;                                    //<maxSUL====
            IF ar>=kwQ  THEN         //,2<>1 =Uh Pmax :lle, TR=Cu
               rj_LmaxPmaxCU := fLuh10 (os,2,FALSE, ar,mo.motr[os].cos.ArvoRea,napQ,rj_xCU,rj_mmCU, rj_ChrPmaxCU); //<maxL ar -kw:lle
         END;//IF ar>0                                 ''''''''+120.5k''''''''
      end;//IF rj_LmaxCU>0
    //:::::::::::::::::::::::::::::::::::::::: RajaL SYÖTETYLLE KONEELLE=====Al=====================
      IF rj_LmaxAL>0
      THEN BEGIN
         ar := fMm2Pmax (TRUE, kwQ,napQ,rj_xAL,rj_mmAL, ai);
         IF ar>0  THEN BEGIN                          //,,,,, Pmax_Sul_Raja ########################
            IF ar<kwQ  THEN BEGIN ar := kwQ;          //<SaattoiJäädäPienmksi
                                 {ai := rj_SUL;} END; //uCos:nTakia.TimKorjtu
            rj_PmaxAL := ar;                                    //<Pmax======
           {rj_SUmax :=  ai;                                    //<maxSUL====}
            IF ar>=kwQ  THEN         //,2<>1 =Uh Pmax :lle, TR=Al <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
               rj_LmaxPmaxAL := fLuh10 (os,2,TRUE, ar,mo.motr[os].cos.ArvoRea,napQ,rj_xAL,rj_mmAL, rj_ChrPmaxAL); //<maxL ar -kw:lle
         END;//IF ar>0                                ''''''''+120.5k''''''''
      end;//IF rj_LmaxAL>0
   END;//WITH
END;//if kpl>0
END;//RJarvot
//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ MoLas2.INC

