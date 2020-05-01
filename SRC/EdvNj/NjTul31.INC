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
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NjTul31.INC }
{NjTul30.INC, 31.INC, 31.INC, 37.INC, 38.INC INCLUUDATTU NjTul3.PAS :ssa
===================================================================================================}
PROCEDURE tulostanousu;              //,,,,,,,,,,,ar1-2 varattu WRT:nKutsulle
VAR boo, ehtoUh,ehtoSs,ehtoKat  :Boolean;
    dShIsu,dShsIsu,ShLop, dKh,dKhs,SKhLop, PuhLop,   ar1,ar2,rr1,rr2, Ik3a,Ik3b, ar,rr  :Real;   {c :Char;}
    i{+8.0.0},ii,e,ehtoi, ai,su4,sux   :Integer;               //<SUX=varokelkm, ma=mm.määrääväVEnApu
    sa,sb,sc,sd,sExt   :string;

procedure editEdvSiirrot;      VAR ar,ra :Real;  i :integer;     begin //+6.0.0
{EDELTÄVÄÄN VERKKOON SIIRRETTÄVÄT TIEDOT:
	Ph	   = 18.0 kW	Tasattu Ph (Ptas).
	Cosj 	= 0.894		Ekvivalenttinen tehokerroin.
	Lik	= 50.0 m	   Ekviv. pituus oikosulkutarkastelua varten.
	Luh	= 47.1 m	   Ekviv. pituus jännitealenematarkastelua varten}

   adStF (CLR_BLU +'<t>EDELTÄVÄÄN VERKKOON SIIRRETTÄVÄT TIEDOT: (jos lasketun NJ:n loppupää siirrettäisiin '+
          'PJ-liittymän alkupisteeksi. Ed. verkkoa ei ole tehoissa mukana).');
         //kasvu := 1;
         {if Hvrt>0  then //<Kommenttisulku tähän(kin) +6.0.2
                       {ar := a_getReaa (30024,dPprs);
                        sa := fRmrkt0 (ar,1,2) +' %/a' +Slop_arv (1,ar,ar); //+' =' +fRmrkt0 (1+rr/100,1,2) +'×';
            ad3SF (1,'Ph:n kasvu<b>ennuste</b>','=',sa);}
         //kasvu := fKertaSuor_lop_arv ( 1, a_getReaa (30001, nj.Hav.Tpit),a_getReaa (30002, nj.Hav.dPprs) );
         //sa := '<t>Ph<t>= ' +fRmrkt0 (Ptas[1]*kasvu/1000,1,1) +' kW';    //< Pedv sij. NjTul30.INC

     if Pedv<10    then i := 3  else
     if Pedv<100   then i := 2  else
     if Pedv<1000  then i := 1
                   else i := 0;
     sa := '<t>Ph<t>= ' +fRmrkt0 (Pedv,1,i) +' kW';                        //< Pedv sij. NjTul30.INC
     sa := sa +'<t>Tasattu Ph (Ptas), sis. mahd. kasvuvara, ks. <u>keskustiedot</u> alussa.';
   adStF (sa);
      ra := Ptas[1] / Sqrt( Sqr(Ptas[1]) + Sqr(Qtas[1]) );  //< = Cos=P/S =P/V¨(P²+Q²), KASVU_% ei muuta suhdetta.
      sa := '<t>Cos' +FONT_FII +'<t>= ' +fRmrkt0 (ra,1,3);  //< Debug: Cos=0.894427
      if Kesja>1  then sa := sa +'<t>Ekvivalenttinen tehokerroin.';
   adStF (sa);

      ar := 0;  rr := 0;  aa := 0;
      for i := 1 to kesja  DO begin
          ra := a_getReaa (30072, nj.jk[i].dL);
                            {rr := rr + ra*r1 *Ptas[i]; //<TehoResistMomentti ao. VÄLILLÄ dL. rr,xx=NJn res,Xv_ind
                             aa := aa + ra*x1 *Qtas[i]; //<LoistReaktMomentti ao. VÄLILLÄ dL. Vois summata RR:ään.}
          ar := ar +ra;   end;                  //<Johdon kokonaispituus.
                            // (Ptas[1]+Qtas[1])Lekv = Summá(Ptas[i] + Qtas[i]Lao
                            // => Lekv = [(Ptas[1]+Qtas[1])] / Summá(Ptas[i] + Qtasi[i])Lao
      sa := '<t>L';
      if Kesja>1  then sa := sa +'ik';
      sa := sa +'<t>= ' +fRmrkt0 (ar,1,1) +' m<t>Ekviv. pituus';
      if Kesja>1  then sa := sa +' <b>oikosulkutarkastelua </b>varten.'
                  else sa := sa +'.';
   adStF (sa);
           
   if Kesja>1  then begin
      sa := '<t>Luh<t>= ' +fRmrkt0 (LedvUh,1,1);
      if Kesja>1  then sa := sa +'<t>Ekviv. pituus <b>jännitealenematarkastelua </b>varten.';
      sa := sa +'</f>';
     adStF (sa);
     adStF ('');                                                              //<''+6.0.0'''''''''''
   end;
   adSt_ ('</f>');                                                            //<  +6.1.1
end;//editEdvSiirrot
//==========================================================================================================
                                            //,TulVE:n jälkeisen sisennyksen selvitykseen, ks.LOPUSSA
PROCEDURE KirjoitaChkFile (s :string);      VAR ABSfile,VISfile :Text;  FabsNimi,FvisNimi,sa :string;   begin
   ChkStr := ChkStr +s;
   FabsNimi := 'C:\Projektit\NolaKehi\BIN\_Ajot\KoeChkFileABS.txt';   //   //ForceDirectories (
   FvisNimi := 'C:\Projektit\NolaKehi\BIN\_Ajot\KoeChkFileVIS.txt';
                                       //¿DefsFileenZ('AssgnFile 18');
   AssignFile (ABSfile,FabsNimi);    AssignFile (VISfile,FvisNimi);
   Rewrite (ABSfile);                Rewrite (VISfile);                      //,,Tietoa tiedoston teosta
      sa := 'NjTul31.INC/PRC KirjoitaChkFile. Kutsu aivan NjTul31.INC :n lopussa. Summaa STR:n ChkStr'+
            ' :iin, joka esitelty ja alustettu NjTul3.PAS :ssa.';
   Writeln (ABSfile,sa);              Writeln (VISfile,sa);
      sa := 'KoeChkFileABS.txt :  Kirjoitettu tiedostoon SelStr :stä, johon summattu STR = Tagit mukana.';
   Writeln (ABSfile,sa);              Writeln (VISfile,sa);
      sa := 'KoeChkFileVIS.txt :  Kirjoitettu tiedostoon aRich.Text = Tab :t yms. näkyy VISUAALISESTI.';
   Writeln (ABSfile,sa);              Writeln (VISfile,sa);
   Writeln (ABSfile,ChkStr);          Writeln (VISfile,NjTulFrm.aRich.Text); //<Tulosteen varsinaiset sisällöt
   CloseFile (ABSfile);               CloseFile (VISfile);   end;
//==========================================================================================================
FUNCTION selektive (Sul :Integer;   Kat :Real;  VAR MinSul :Integer;  VAR MinKat:Real) :Boolean;
      VAR i,j, MinKpl,n,njkpl :Integer;             //''Min___ palauttaa ed. MINIMIsul, voi := 0
          {@}YvSulA,YvSulC,YvSulD,OikSul :integer;  //''Ei tarttis olla FNC, vrt. kutsun jälk.
//..........................................
   PROCEDURE sijMinS (vrtSul,vrtKpl :Integer);   //<Jos vrtsul < jo sijoitet
      BEGIN                                      //sijoittaa pienimmäksi <<<
      IF (vrtSul*vrtKpl<MinSul*MinKpl) AND (vrtSul>0)  OR  (MinSul=0)
         THEN BEGIN  MinSul := vrtSul;   MinKpl := vrtKpl;  END;
      IF MinSul<6  THEN MinSul := 0;      //<Isnik antaa min.arvonaan 0A <<<<<<<<<<<<<<<<<<<<<<<<<<<
   END;
//..........................................
   PROCEDURE sijMinK (astap :string);
         VAR ar8,a8,r8,apu8 :Real;   Etyp :string;  EKorj,Emm2,ar :real;  Ekpl :integer;    BEGIN
                                       //<Jos astapaa vastaava katk < jo sij
                                       //oitettu, sijoittaa pienimm„ksi <<<<
      WITH edv.edka[i]  DO BEGIN
         Etyp :=  a_getStrg (31011, tyyppi);
         Ekorj := a_getReaa (31012, korjaus);
         Emm2 :=  a_getReaa (31013, Amm2);
         Ekpl :=  a_getIntg (31014, lukumaara);
                    //SamaSul,NJkin.................................................................
{kat}    ar8 := YvSuoj (suCse,FALSE,TRUE,astap,Ekorj,Etyp,Emm2,Ekpl);
{iks}    apu8 := 0.8* iks (Ik3vFA, i, Ziks (12,i,NJkinTR,0, '',0,0,0,0, ar,ar,ar,ar)); //< 12=MinIk1v MaxZ:ssa
         IF apu8<ar8  THEN ar8 := apu8;             //<Magn. asetus määrää <
         a8 := IksalTerm (Etyp,Emm2);
      END;                                      //'Terminen oikos.kestoisuus

      IF ar8>a8  THEN r8 := a8           //<Term oikos.kestoa ei saa ylittää
                 ELSE r8 := ar8;         //'ja max.arvo=AINA YHDEN KPLn ARVO
      IF (r8<MinKat)  AND  (r8>0)  OR  (MinKat=0)  THEN MinKat := r8;
   END;    //'15% selekt.porras, oletus ????????????????????''''??????????????????????????????????????????????
//............................................
BEGIN//selektive
   MinKat := 0;
   MinSul := 0;
   MinKpl := 1;
   IF NJkaapx=2  THEN njkpl := 1  ELSE njkpl := NJkaapx;
   selektive := TRUE;

//@IF edka^[1].onarvot  THEN
 //FOR i := 1 TO a_getIntg (31021, edv.YLE.JohtoOsia_)  DO //############################# -4.0.0
   FOR i := 1 TO edNo-1  DO                                //############################# +3.0.3  4.0.0
   WITH edv.edka[i]  DO BEGIN                              //sijMin_ :llä etsitään pienin
      j := a_getIntg (31022, lukumaara);
      IF j=2  THEN n := 1                                  //ed.verkossa esiintyvä KOJE <<
              ELSE n := j;                                 //#############################
{@=,,}YvSulA := pyor (arvo [arvo_SUL_YLIV_A_7]);
      YvSulC := pyor (arvo [arvo_SUL_YLIV_C_8]);
      YvSulD := pyor (arvo [arvo_SUL_YLIV_D_9]);
      OikSul := pyor (arvo [arvo_SUL_OIKOS_6]);
      IF (YvSulA>0)  OR  (YvSulC>0)  OR  (YvSulD>0)  OR  (OikSul>0)
         THEN sijMinS (Trunc(edv.edka[i].arvo [arvo_SUL_MAX_5s_5]),1);

      sijMinS (YvSulA, n);
      sijMinS (YvSulC, n);
      sijMinS (YvSulD, n);
      sijMinS (OikSul, 1);                    //<Jos tätä isompi, on
                                              //varmasti myös Yv__:tä isompi
      sijMinK ('A');
      sijMinK ('C');
      sijMinK ('D');
   END;//WITH              //>>>>>>>>> LOPPUTARKISTUS JA -SIJOITUS <<<<<<<<<<
   IF (njkpl*Sul>=MinKpl*MinSul)  AND  (MinSul>0)  OR
      (Kat>=MinKat)  AND  (MinKat>0)  THEN selektive := FALSE;
END;//FNC selektive
//==========================================================================================================
{dSUL   = +X.xx kVA    = +X.xx% ...    , jonka str = 'dSUL','=',(tab1 sis sa:han ) sa }
PROCEDURE sijArvo (oh :Integer;   maaraava :boolean;   ar1,ar2,ar3 :real;   VAR st :string);
      VAR sa :string;                 //''Kutsuvaan esim.:   IF sa<>'' then ad3SF (1,'dSUL','=',st);
   PROCEDURE sij (Dimens :string);

      FUNCTION iso (rr,raja :Real;  t :Integer) :Boolean;                      BEGIN
         IF fMuokdes (rr,t) >= raja  THEN iso := TRUE   ELSE iso := FALSE;       END;

      PROCEDURE si (demot :integer;  arvo :real;  des :integer;   dimensStr :string);     BEGIN
         sa := fDemRx_PRO (demot, arvo, 1,des) +' ' +dimensStr;                             END;
   BEGIN//sij
   if ar1>0  THEN BEGIN
       IF iso (ar1,10000,2)  THEN si (0,ar1/1000      ,2 ,'M'+Dimens)   ELSE   // 10.00 - ...00 MW
       IF iso (ar1,1000 ,3)  THEN si (0,ar1/1000      ,3 ,'M'+Dimens)   ELSE   // 1.000 - 9.949 MW
       IF iso (ar1,100  ,1)  THEN si (0,ar1           ,1 ,'k'+Dimens)   ELSE   // 100.0 - 999.9 kW
       IF iso (ar1,10   ,1)  THEN si (0,ar1           ,1 ,'k'+Dimens)   ELSE   //   9.5 -  99.9 kW
                                  si (0,ar1           ,2 ,'k'+Dimens);         //  0.01 -  9.49 kW
       st := '+' +sa;   if kesja >1  then st := st +'×'+fImrkt0 (kesja,1);
       if maaraava  then st := '<u>' +st +'</u>';                 //<Bold asetetaan jälempnä koko stringille
       IF iso (ar2,1000000,1)  THEN si (0,ar2/1000000 ,1 ,'M%')  ELSE   //1.00 - _.99 M%
       IF iso (ar2,100000 ,0)  THEN si (0,ar2/1000    ,2 ,'M%')  ELSE   //100  -  999 M%
       IF iso (ar2,10000  ,1)  THEN si (0,ar2/1000    ,1 ,'M%')  ELSE   //10.0 - 99.9 k%
       IF iso (ar2,1000   ,2)  THEN si (0,ar2/1000    ,2 ,'k%')  ELSE   //1.00 - 9.99 k%
                                    si (0,ar2         ,0 ,'% ');        //1    -  999 %
       st := st +tab1 +'= '+sa;
       IF iso (ar3,10000,2)  THEN si (0,ar3/1000      ,2 ,'M'+Dimens)   ELSE   // 10.00 - ...00 MW
       IF iso (ar3,1000 ,3)  THEN si (0,ar3/1000      ,3 ,'M'+Dimens)   ELSE   // 1.000 - 9.949 MW
       IF iso (ar3,100  ,1)  THEN si (0,ar3           ,1 ,'k'+Dimens)   ELSE   // 100.0 - 999.9 kW
       IF iso (ar3,10   ,1)  THEN si (0,ar3           ,1 ,'k'+Dimens)   ELSE   //   9.5 -  99.9 kW
                                  si (0,ar3           ,2 ,'k'+Dimens);         //  0.01 -  9.49 kW
       st := st +'<t>  '+FONT_SIGMA +' = '+sa;
   if Akok>0  then begin
       ar3 := ar3/Akok *1000;       //0, = Ei demotestiä = arvo aina näkyviin <<<<<<<<<<<<<<<<<<<<<<
       IF iso (ar3,10000,2)  THEN si (0,ar3/1000      ,2 ,'k'+Dimens+'/m²')   ELSE   // 10.00 - ...00 MW
       IF iso (ar3,1000 ,3)  THEN si (0,ar3/1000      ,3 ,'k'+Dimens+'/m²')   ELSE   // 1.000 - 9.949 MW
       IF iso (ar3,100  ,1)  THEN si (0,ar3           ,1 ,    Dimens+'/m²')   ELSE   // 100.0 - 999.9 kW
       IF iso (ar3,10   ,1)  THEN si (0,ar3           ,1 ,    Dimens+'/m²')   ELSE   //   9.5 -  99.9 kW
                                  si (0,ar3           ,2 ,    Dimens+'/m²');         //  0.01 -  9.49 kW
       st := st +' = '+sa;
   end;
       st := st +'  = Kuorman kasvuvara';
   if det3
   then begin
      case oh of  1 :st := st +'  sulakkeen';
                  2 :st := st +'  katkaisijan termisen asetuksen (johdon kuormitettavuuden)';
               else  st := st +'  Uh% -rajan';   end;//case
      st := st +'  suhteen';
      IF maaraava  THEN begin  st := '<b>' +st +',</b> ' +CLR_REB +'RAJOITTAVIN.' +FNT_B0;  end; end
   else st := st +'...';
   END;{if ar1>0}
   END;//PRC sij
BEGIN//sijArvo
   st := '';  sa := '';          //<Voidaan / kannattaa / täytyy testata:   IF s1<>''  then ad3SF (..);
   case oh of  1 :sij ('VA');
               2 :sij ('VA');
            else  sij ('W');  end;//case
END;//sijArvo
//==========================================================================================================
procedure laskeVarat;      VAR rr, PsulLop,PkatLop   :real;      BEGIN
                      // NYT:             OLI:  Esitelty / Laskettu
                      //dShIsu  ======   (sama)   31.INC / 31.INC   //<Abs. SULAKres            kVA <<<< 1.1
                      //dShsIsu          (sama)   31.INC / 31.INC   //<Suht.SULAKres            %   <<<< 1.2
                      //ShLop             ar3     31.INC / 31.INC   //<NJsul lopputeho          kVA <<<< 1.3
                      //dKh     ======   (sama)   31.INC / 31.INC   //<Abs. Katkaisijan reservi kVA <<<< 2.1
                      //dKhs             (sama)   31.INC / 31.INC   //<Suht.Katkaisijan reservi %   <<<< 2.2
                      //SKhLop            ar      31.INC / Local    //<NJkat lopputeho HUOM: -> kVA <<<< 2.3
                      //dPhuh   ======   (sama)    Tul3  / 38.INC   //<Uh%:n lopputeho (38.INC) kW  <<<< 3.1
                      //dPhsuh           (sama)    Tul3  / 38.INC   //<Uh%:n lopputeho (38.INC) %   <<<< 3.2
                      //PuhLop            ar2     31.INC / 31.INC   //<Puh(Uh%):  lopputehoUh%  kW  <<<< 3.3
                      //(Pik)   ======    ar1     31.INC / 31.INC   //<Ei nyt käytössä =====================
                      //ehtoUh,ehtoSs    (samat)  31.INC / 31.INC   //<Rajoittavampi      (Boolean)<<<<< 1,2
                      //ehtoKat           uusi    31.INC / 31.INC   //<Rajoittavampi      (Boolean)<<<<< 3
dShIsu := 0;  dShsIsu := 0;
PsulLop := 0;
IF NJsul>0  THEN BEGIN
   rr := fKsul (suCse,NJsul);                 //<MuuttaaAutomsti D:ksi<=25A===
   ShLop :=   sux *NJsul *rr / fKi;              //<Abs. SULAKElopputeho kVA <<<<
   dShIsu :=  ShLop - Stas[1];                   //<Abs. SULAKEreservi   kVA <<<<
   dShsIsu := dShIsu / Stas[1] * 100;            //<Suht.SULAKEreservi   %   <<<<
     dShIsu :=  dShIsu / kesja;                  //<Abs. SULAKEreser.kVA/KESJA<<< TULOST: dS..* KESJA ######
   PsulLop := ShLop *Ptas[1]/Stas[1];         //<P/S =cosí => PsulMax =Yhteismitalliseksi <<<<<<<<<<
END;

SKhLop :=  NJkat / fKi;                          //<Abs. KATK.lopputeho  kVA <<<<
dKh :=     SKhLop -Stas[1];                      //<Abs. KATK.reservi    kVA <<<<
dKhs :=    dKh / Stas[1] * 100;                  //<Suht.KATK.reservi    %   <<<<
  dKh :=   dKh / kesja;                          //<Lasket.abs. KATKres  kVA/KESJA=TULOST: dKh * KESJA #####
PkatLop := SKhLop *Ptas[1]/Stas[1];           //<PkatMax = Yhteismitall.= P vertailuun <<<<<<<<<<<<<

PuhLop := dPhuh*kesja + Ptas[1];                 //<Puh(Uh%): lopputehoUh% kW

                 //================Tutkitaan, mikä MÄÄRÄÄVIN=PIENIN=================================
ehtoUh := FALSE;   ehtoSs := FALSE;   ehtoKat := FALSE;
  //Puh                   Puh < Psu                            Puh < Pkat
IF (PuhLop  > 0) AND ((PuhLop < PsulLop) OR (NJsul=0)) AND (PuhLop < PkatLop)  THEN ehtoUh := TRUE  ELSE
  //Psu                   Psu < Puh                            Psu < Pkat  ,,,,,Tuskin koskaan Psul>Pkat
IF (PsulLop > 0) AND  (PsulLop< PuhLop)                AND (PsulLop< PkatLop)  THEN ehtoSs := TRUE  ELSE
                                                                                    ehtoKat := TRUE;
END;//laskeVarat
//==========================================================================================================
         //,if NJsul<IkSul ei kelpaa testiksi, koska jos IkSul<NJsul -> NJsul := IkSul, ks. 38.INC/EtsiKaap
         //,mutta siellä ehto-osa:  if (NJsul>0) lienee turha ??????????????????????????????????????????????
procedure lisaaSAzsia;      begin                                           //Kutsuttu vain 1x,,,,,,
   IF (NJsul>0) AND ZSiso  THEN sa := sa +'   <b>ZsIa-ehto pienentänyt arvoa</b>.';   end;
procedure lisaaSAepas;      begin                                           //Kutsuttu vain 1x,,,,,,
   IF (ehtoi>0) or  Y_esittelyEhto  THEN
         sa := sa +'   '+CLR_REB +'Tarkista mahd.epäselektiivisyys ed.verkkoon.' +FNT_0;  end;
procedure asetaSB;      begin   IF NJsul>1250  THEN sb := '>'  ELSE sb := '=';   end;
//...........................................................................,Kutsuttu vain 1x,,,,,,
function SulValittuInf :string;      VAR s :string;   kul :boolean;      BEGIN  s := '';
if NJsul>0  then begin
   kul := a_getBool (31061, nj.jy.NjKulSal);
   s :=  '.     Pienin arvo määrännyt :   IjatkuvaSall = ';
   if NJkaapx>2  then s := s +'á';                          //<á +10.0.5
   s := s +fDemIx_PRO (2, YVsul,1);
   if kul  and  (ZSsul>0)  then
      s := s +'   ZsIa-ehto = '+fDemIx_PRO (2, ZSsul,1);
   if IkSul>0  then begin
      s := s +'   Ik1v\';
      if kul  then  s := s +fDemRx_PRO (2, a_getReaa (31162, edv.YLE.PoisAika),1,1)
              else  s := s +'SÄL';
      s := s+'s = '+fDemIx_PRO (2, IkSul,1);  end;
   s := s+' A.';
end;   Result := s;   END;
//##########################################################################################################
//##########################################################################################################
//##########################################################################################################
BEGIN//tulostanousu
tuxV := tuxV + 1;

NjTulFrm.TulNoEdi.Items.Clear;                             //<,,Siirretty tähän 38.INC´istä jotta vika tuxV tuli-
NjTulFrm.TulNoEdi.DropDownCount := 50;                     //   si mukaan, todettu.                 +8.0.4
ii := tuxV;
if ii>30  then ii := 30;
for ii := 1 to ii  do
   NjTulFrm.TulNoEdi.Items.Add (IntToStr(ii));             //<''''''''''''''''''''''''''''''''''''''+8.0.4

IF NJkaapx=2  THEN sux := 1  ELSE sux := NJkaapx;          //<Varokelukumäärä
laskeVarat;
//--------------------------------------------- 1. RIVI ---------------------------------------------------------
//if NOT NJlaji  then begin //\\\\\\\\\\\\\\\\\ Hyvä ehto: Selkeyttää koeajon seurantaa \\\\\\\\\\\\\\\\\\\\\\\\\
sisVex;  sisVex;                                                      //<Jakoviiva tavuttuu alkamaan vasMarg :sta
//    str := str +'</tab>';                                           //< -3.0.0  =Kaikki Tab :it vex

   LF;                                                                //,AINOA "ulkopuolinen" STR :n sijoitus
      if fAlCu (NJtyp)  then sa := COLOR_GREEN  else sa := COLOR_BLUE;
      sb := 'VAIHTOEHTO N:o '+fImrkt0 (tuxV,1);
      if NJlaji  then sc := 'Al'   else sc := 'Cu';
   adSt_ (sa +Pisteviiva2 (sb,sc) +FNT_B0);
 //sa := sa +Pisteviiva2 (sb,sc) +FNT_B0;                     //<Selvittelyä, miksi Jatkan jälkeen tulee sisennys

{      NjTulFrm.aRich.Enabled := false;
//NjTulFrm.aRich.AddText (str);   str := '';
      ii := NjTulFrm.Height;
      NjTulFrm.Height := ii-50;
      NjTulFrm.UpDate;                 //<Muuten buttonit jäävät aukoiksi.
      NjTulFrm.aRich.SelStart := Length (NjTulFrm.aRich.Text);
      NjTulFrm.aRich.SelLength := 0;   //<Jos kommentoi vex ja NOT ENABLED, PÄIVITTYMINEN NÄKYY TOSIAIKSTI, hidas
      NjTulFrm.aRich.AddText ('<br>'); //<Scrollataan jatkon alkukohta näkyviin = POISTAA PAHAN SIENNYKSEN !!!!!!
         //EiOkInfo ('Ruutukoko 1 ?');
      NjTulFrm.Height := ii;         //<..ja suurennetaan lomake takas, jotta uudet lisärivit alkavat näkyvOsalla
      NjTulFrm.UpDate;               //<Muuten buttonit jäävät aukoiksi.
         //EiOkInfo ('Ruutukoko 2 ?');
      NjTulFrm.aRich.Enabled := true; //}

   boo := true;                             //<BOO ilmaisee, PUUTTUUKO VÄLTTÄMÄTÖN 1x LF; (vrt. adSt_/adStF tms.)

      if Y_esittelyEhto  then begin  LF;                           //<EiTarvita edes: if BOO  (joka vielä voimassa)
         adSt_ (CLR_REB +'(Esittelyversio :  Lasketut arvot, varoitukset ja erityisviestit eivät '+  
                'välttämättä vastaa todellista tilannetta)'+FNT_B0);
         boo := true;  end;                                        //<EiTarttis asettaa, mutta helpompi tajuta

      if (IkKasvattiMm2Str<>'') and det3  then begin
         if boo  then LF;                                                            //<Puuttui LF
         adStF ('<b>Kuormitettavuudeltaan riittävät mutta sulakkeen ylittyvän poiskytkentäajan takia '+
                'hylätyt vaihtoehdot (katkaisija OK):</b><br>'+                      //'+6.1.1 +sulakkeen 
                '(YVsulMax/IkSulMax = Max.ylivirtasuojasulake / poiskytk.ajan sallima max.sulake)');
         asTabXnSisB (1,'20 á SVsystAL5S 3200\'); //<Valmiiksi tulevaisuutta varten = Jos joskus SVj:llekin 20x
       //asTabXnSisB (1,'20 á AMCMK  300 \');
         adStF (IkKasvattiMm2Str);
         sisVex;
         adSt_ ('<b>Seuraava hyväksyttävä:</b>');             //<Seur. SISB aiheuttaa LF:n = BOO nyt vapaa
      end;
      IkKasvattiMm2Str := ''; //<Tyhjennetään seur. kertaa = 38.INC varten. Tyhjätvä vaikkei det3 @@@@@@@@@@@@

sisVex; sisVex;                                               //< -3.0.0  Varm. vuoksi
{adSt_ ('</tab>');
asTabXnSisB (1,'AMCMK3½a\=_\0.889/0.874k\@8888.8\8888.8\');   //< +3.0.0  Riittää Bold AMCMK3½½ :lle, todettu
adStF ('b0' +tab1 +'1' +tab1 +'2' +tab1 +'3' +tab1 +'4' +tab1 +'5' +tab1 +'6'); //}

//asTabXnSisB (1,'IkatTerm\=_\123456.8 A\@8888.8\8888.8\');    //<CLR_REB lihavoi = (Mg/Term) 0.889/0.874 k eiMahu
//asTabXnSisB (1,'IkatTerm\=_\0.889/0.874k\@8888.8\8888.8\');  //< -3.0.0  ,,4.0.0:  Ilmeisesti VasMargEiHUOMIOITU?
//asTabXnSisB (1,'AMCMK3½½___\=_\0.889/0.874k\@8888.8\8888.8\');     //< +3.0.0  Bold AMCMK3½½ :lle, todettu. 4.0.0
asTabXnSisB (1,'20xAMCMK3½½__\=_\0.889/0.874 k___\@8888.8\8888.8\'); //< +3.0.0  Bold AMCMK3½½ :lle, todettu. 4.0.0
   sisB;                                                       //<Aiheuttaa LF:n  -3.0.0
// adStF ('sisA =' +sisAstr +'  sisB=' +sisBstr);              //< sisA=10  sisB=131
      sa := '';
      if NJkaapx>1  then sa := fImrkt0 (NJkaapx,1) +' á ';
      sa := sa +fDemRx_PRO (2, NJmm2,1,0);
      if NJlaji  then sa := sa +' Al'  else sa := sa +' Cu';
      sa := sa +'</b>' +tab1;
      if NJkaapx>1
      then sa := sa +'Kaapelilukumäärä,  v'
      else if SamIso (NJtyp,njSVj)
              then sa := sa +'Yksijohdinjärjest.:  V'
              else sa := sa +'Monijohdinkaapeli:  V';
      sa := sa +'aihe-mm² ja -materiaali.   Arvot '+NJtyp +':n mukaan.';
   ad3SF (1,'<b>mm2','=',sa);
//--------------------------------------------- 2. RIVI (n kpl) -------------------------------------------------
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
      laskeTulHinta (0);                                                   //<MCMK tai AMCMK tai SVj
//--------------------------------------------- 3. RIVI (n kpl) -------------------------------------------------
      laskeTulHinta (1);                                                   //<AXMK <<<<<<<<<<<<<<<<<
//--------------------------------------------- 4. RIVI ---------------------------------------------------------
//\\\\\\\\\\\\\\\\\\\\\\\\\\\ Sulkemalla lopu vex, on helpompi seurata Al/Cu/mm2 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
     {IF NOT selektive (IkSul,NJkat, ehtoi,ar)  AND  (ehtoi<=IkSul)  AND (ehtoi>0)  OR
         NOT selektive (NJsul,NJkat, ehtoi,ar)  AND  (ehtoi<=NJsul)  AND (ehtoi>0)}
      IF NOT selektive (NJsul,NJkat, ehtoi,ar)  AND  (ehtoi<=NJsul)  AND (ehtoi>0)
         THEN ehtoi := 1
         ELSE ehtoi := 0;
      IF ehtoi>0  THEN sa := CLR_REB //<Nollaus= FNT_B0 //### NJsul = IsuMax=Isal*äKorj. Jos ZsIa<Uo
                  else sa := '<b>';                     //### pienentänyt, on ZSiso=TRUE ###########
      if NJsul=0  then sa := sa +'- - - '
                  else begin
                       if NJkaapx>2  then sa := sa +fImrkt0 (NJkaapx,1) +' á ';
                       sa := sa +fDemIx_PRO (2,NJsul,1);  end;
      sa := sa +' A</b></f>' +tab1;

      sExt := YvSuo (2,1, suCse,FALSE,FALSE, a_getStrg (31126, nj.jy.AsTapa), a_getReaa (31127, nj.jy.Korjaus),
                     NJtyp,NJmm2,NJkaapx, ar) +  //'Demo(1),Erittely(1), EI(YhteisSuoja), EI(Katkais)
              '.';                                                                                  //<+10.0.1 ,- 
             {'.    Ksu, ks. A2 / 433.2,    Kas,Krin, ks. syöttöikkunan Korjaus -avuste';
      if NJkaapx>1  then sExt := sExt +'.   Huomaa, kuinka sulake- ja rinnakk.asennuskerroin pienentää '+
                                       'kuormitettavuutta';
      if (NJkaapx>1) and (NJsul=0)  then sExt := sExt +' ja kuinka katkaisija antaa paremmat mahdollisuudet.';}

      IF NJsul=0 //---------------------------------------------------------------------------------
{1,}  then begin
         rr := YvSuoj (suCse,FALSE,FALSE, a_getStrg (38028, nj.jy.astapa),  //<EI(YhteisSuoja), EI(Katkais)
                       a_getReaa (38029, nj.jy.korjaus), NJtyp,NJmm2,NJkaapx);
         if (rr>1000) or (rr<0.0001)
            then sa := sa +'<b>Riittävän isoa sulaketta ei ole</b>'
            else sa := sa +'<b>Johto ei salli kuormalle riittävää sulaketta</b>';
         if det3  then sExt := '.   ('{ tai ks. seur. ve :t'} +sExt +')'
                  else sExt := '...';
         sa := sa +',   käytä katkaisijaa' +sExt;
{1'###>} ad3SF (1,'<b>IsulMax</b>','=',sa);   END     //<Tulostetaan ######################=Testattu
      else begin
         ii := 0;      //<Jos muuttuu, ZsIa vaikutti fSu4 :ään (ei käytetty tässä)<<<<<<<<<<<<<<<<<<<<<<<<<<<<
         boo := false;
         if edNo<0  then e := edNo  else e := edNo-1;       //< +6.2.2  §?§
         su4 := fSu4o (suCse,e,0,TRUE{=NJkin},NJsul,        //< edmaxkpl -> edNo 3.0.3  4.0.0
                       NJtyp,NJmm2,NJpit,NJkaapx, a_getIntg (31132, nj.jy.Tk1v), ii); //<i=ZsIaVaikuts

         if (    a_getBool (31133, nj.jy.NjKulSal)   and  (fPoiskAikaRaja > 1)  or //< +2.0.5
             NOT a_getBool (31135, nj.jy.NjKulSal) ) and (su4>=NJsul)
             then boo := true;                       //<'Valittu 5s tai SÄL, mutta sulake toimii 0.4s @@@@@@@@
            //boo := false;  //<Kokeilua
         sa := sa +'Johdon, olosuhteiden ja ';
         if a_getBool (31136, nj.jy.NjKulSal)  then sa := sa +'suojausehtojen (aika, ZsIa) mukai'
                                               else sa := sa +'(SÄL) nollausehdon mukai';
         if NJkaapx>2   then sa := sa +'set max. '
                        else sa := sa +'nen max. ';
         if a_getBool (31137, edv.YLE.IecOfa)  then sa := sa +'IEC -sula'
                                               else sa := sa +'OFAA -sula';
         if NJkaapx>2   then sa := sa +'kkeet (molemmissa päissä)'
                        else sa := sa +'ke';
         if det3  then begin sa := sa +'.   Perusteet :   (IsulMax '+ FONT_PIENPI +') ' +sExt;  //<FONT_..+,10.0.5
                             sa := sa +SulValittuInf +COLOR_RED +'  Annettu MinKasvuvara ei välttämättä täyty, '+
                                   {'Kasvuvarat,}'ks. seur. rivit, </f>esim. '+
                                   '<b>dSul</b> .';
                            {sa := sa +SulValittuInf +COLOR_RED +'  Ei sis. kasvuvaroja, ks. seur. rivit,</f> '+
                                'esim. <b>dSul</b> .';}
                             lisaaSAzsia;  end
                  else       sa := sa +'...';
         lisaaSAepas;  asetaSB;
{ALKU>}  ad3SF (1,'<b>IsulMax</b>',sb,sa);            //<Tulostetaan ######################=Testattu
                                                      //,,Tämän jälk.UUSI kpl = ad3SF (1,'','',sa);
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, 5s t. SÄL -> 0.4s t. 0.4s ,,,,,,,,,,,,,,,,,,,,,,,,,,}
         if NOT Y_esittelyEhto //<################### Ohjataan DEMOveriossa tästä ohi ##############
            and det3
         then begin

         if ( boo  or  (fPoiskAikaRaja <1)  and  a_getBool (31138, nj.jy.NjKulSal) ) //< +2.0.5
{2,}     then begin
            sa := tab1;
            if boo //<,,5s valittu TAI SL, mutta 0.4s alittuu,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
            then begin
               if a_getBool (31139, nj.jy.NjKulSal)
                  then  sa := sa+'     Poiskytkentäajaksi valittu 5 s, mutta '
                  else  sa := sa+'     Jakeluverkon nollausehdon lisäksi ';
               sa := sa +fPoiskAikaRajaS +' s alittuu ja senkin mukainen <b>ZsIa -ehto toteutuu</b>.   '{+CLR_GRB};  end
            else   //<,,0.4s valittu ja KUL,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
               sa := sa+'     Poiskytkentäajaksi valittu '+ fValittuPoisAikaS +' s, joka toteutuu, '+ //<..valittu +6.2.21
                        'myös <b>ZsIa -ehto toteutuu</b>.   '{+CLR_GRB};

           {if kesja>1  then sa := sa +'Ketjun jokaiseen k' //<,,EiRiitä: Pitää olla PT tai ZpeOK,,,
                        else sa := sa +'K';
            sa := sa +'eskukseen tai pääjohtoon voidaan liittää <u>'+fPoiskAikaRajaS +' s :n poiskytkentäajan '+
                      'ryhmäjohtoja ilman vikavirtakytkimiä tms. erikoisjärjestelyjä</u>.'+FNT_B0;}

{21'###>}   ad3SF (1,'','',sa);                       //<Tulostetaan ######################=Testattu
         end//if boo or ..
         else begin
            sa := tab1;
            if a_getBool (31139, nj.jy.NjKulSal)  then  sa := sa +'<b>ZsIa -ehto toteutuu, mutta ';
            sa := sa +fPoiskAikaRajaS +' s :n poiskytkentäaika ylittyy</b>. '+CLR_REB;
            if kesja>1  then sa := sa +'Ketjun mihinkään k'
                        else sa := sa +'K';
            sa := sa +'eskukseen tai pääjohtoon EI voida liittää <u>'+fPoiskAikaRajaS +' s :n poiskytk.ajan '+
                      'ryhmäjohtoja, ELLEI 5 s :n (>'+fPoiskAikaRajaS +'s) ryhmäjohtoja varusteta vikavirtakytkimillä '+
                      'tms. erikoisjärjestelyillä TAI Zpe -ehto täyty </u> '+FNT_B0 +'(ks. seur.).'; //Takas +7.0.1
{           sa := sa +'eskukseen tai pääjohtoon EI voida liittää <u>'+fPoiskAikaRajaS +' s :n poiskytk.ajan '+
                      'ryhmäjohtoja, ELLEI niitä varusteta vikavirtakytkimillä '+                   //<6.2.21
                      'tms. erikoisjärjestelyillä TAI Zpe -ehto täyty </u> '+FNT_B0 +'(ks. seur.).';}

{22'###>}   ad3SF (1,'','',sa);                       //<Tulostetaan ######################=Testattu
         end;//else
         end;//if NOT Y_esittelyEhto

         //,,Nämä ed:n jatkoksi,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
{3,}     if ZpeOK (edmaxkpl,1,TRUE{=NJkin}, '',0,0,0,0, sc,sd, ar{+9.0.1}) //< sc=OKjkString   sd=jalessaJKstring
            and  NOT Y_esittelyEhto                   //<Ohjataan DEMOversiossa tästä ohi ##########
         THEN BEGIN                             //sc := '1,3';    sd := '1,3';    //<sc := ..Testiin
            i := 0;  ii := 0;                   //sc := '1,2,3';  sd := '1,2,3';  //<sc := ..Testiin
            if sc<>''  then                     //<,Tutkitaan, onko OK-keskuksia = kesja = KAIKKI Zpe=OK
            repeat i := i+1;
                   ii := fJKno (i,sc);
            until (i=kesmax) or (ii=0);    //<i=kesmax varm.vuoksi, vaikkei koskaan voi mennä >kesja
            if i>0  then i := i-1;
                      {sa := '  a'+fImrkt0 (fMrkPix (sisAstr),1) +'  b'+fImrkt0 (fMrkPix (sisBstr),1) +
                             '  c'+fImrkt0 (fMrkPix (sc),1) +'  1,2,3='+fImrkt0 (fMrkPix ('1,2,3'),1) +
                                '  1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25='+
                               fImrkt0 (fMrkPix ('1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,'+
                               '21,22,23,24,25'),1) +'  c=' +sc; //<'Koekeilua}
            if (sc<>'') and (i>=kesja)
{31,}       then begin  //,,,,,,,,,,,,,,,,, Jokainen JK=OK ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
               sa := tab1 +'<b>Zpe -ehto täyttyy</b>, joten';
               if det3
               then begin
                  if kesja>1  then sa := sa +' ketjun jokaiseen';
                  sa := sa +COLOR_GREEN+' <b>keskukseen voidaan liittää 5 s :n poiskytkentäajan '+ //Takas +7.0.1
                        'ryhmäjohtoja ilman vikavirtakytkimiä tms. erikoisjärjestelyjä, <u>vaikka samassa '+
                        'keskuksessa tai pääjohdossa olisi '+fPoiskAikaRajaS +' s :n lähtöjä</u>.</b></f>';  end
                 {sa := sa +COLOR_GREEN+' <b>keskukseen voidaan liittää '+fPoiskAikaRajaS +' s :n poiskytkentäajan '+
                        'ryhmäjohtoja ilman vikavirtakytkimiä tms. erikoisjärjestelyjä, <u>vaikka samassa '+
                        'keskuksessa tai pääjohdossa olisi 5 s :n lähtöjä</u>.</b></f>';  end       //<'6.2.21}
               else sa := sa +'...';
{31'###>}      ad3SF (1,'','',sa);    end                 //<Tulostetaan ##################=Testattu
{32,}       else begin  //,,,,,,,,,,,,,,,,, Joitain JK=OK (ei kaikki) ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
{33,}          if sc<>''  then begin
                  sa := tab1 +'<b>Tässä/näissä keskuksissa Zpe -ehto täyttyy</b>, joten';
                  if det3
                  then
                     sa := sa +COLOR_GREEN+' <b>siihen/niihin voidaan liittää 5 s :n poiskytkentäajan '+ //Takas +7.0.1
                           'ryhmäjohtoja ilman vikavirtakytkimiä tms. erikoisjärjestelyjä, <u>vaikka samassa '+
                           'keskuksessa tai pääjohdossa olisi '+fPoiskAikaRajaS +' s :n lähtöjä</u>.</b></f>'
                    {sa := sa +COLOR_GREEN+' <b>siihen/niihin voidaan liittää '+fPoiskAikaRajaS +' s :n poiskytkentäajan '+
                           'ryhmäjohtoja ilman vikavirtakytkimiä tms. erikoisjärjestelyjä, <u>vaikka samassa '+
                           'keskuksessa tai pääjohdossa olisi 5 s :n lähtöjä</u>.</b></f>'          //<'6.2.21}
                  else sa := sa +'...';
                  ad3SF (1,sc,'',sa);                     //<Tulostetaan ##################=Testattu

                  sc := fJKnoEiOK (sc);               //< sd := ZpeOK -keskusNrot. SC NYT MUUTTUI!!!
                  if sc<>''  then begin
                     sa := tab1 +'<b>Tässä/näissä keskuksissa Zpe -ehto ei täyty</b>, joten '+CLR_REB; //,Takas +7.0.1
                     sa := sa +'niihin tai pääjohtoon ei voi liittää 5 s :n poiskytk.ajan ryhmäjohtoja, ellei ';
                    {sa := sa +'niihin tai pääjohtoon ei voi liittää '+fPoiskAikaRajaS +' s :n poiskytk.ajan '+
                           'ryhmäjohtoja, ellei ';                                                  //<'6.2.21}
                     if det3
                    {then sa := sa +'näitä johtoja varusteta vikavirtasuojakytkimellä '+
                                'tai pot.tasauksella, <u>mikäli samassa keskuksessa tai pääjohdossa on '+
                                fPoiskAikaRajaS +' s :n lähtöjä</u>.'}
                     then begin
                          sa := sa +'näitä johtoja varusteta vikavirtasuojakytkimellä tai pot.tasauksella';
                         {if fValittuPoisAika<1                                                     //<,,6.2.21
                          then }sa := sa +', <u>mikäli samassa keskuksessa tai pääjohdossa on myös '+
                                     fPoiskAikaRajaS +' s :n lähtöjä</u>.'                          //< +7.0.1
                         {else sa := sa +'.';  }end
                     else sa := sa +'...';
                     sa := sa +FNT_B0;
                     ad3SF (1,sc,'',sa);  end;            //<Tulostetaan ##################=Testattu
{33'###>}      end;
{34,}          if sd<>''  then begin
                //if fMrkPix (sc) < fMrkPix (sisAstr)  then sa := tab1   else sa := '';
                  sa := tab1 +'JakokeskusN:ot, joiden <b>pot.tasaukset (mahd. kaikki) ovat ratkaisevassa asemassa ';
                  if det3
                  then sa := sa +'EDELLÄ olevien keskusten Zpe -ehdon täyttymisen kannalta</b> ja '+ //Takas +7.0.1
                             CLR_GRB+'mahdollistaa jakokeskukseen liitettäväksi 5 s :n poiskytkentäajan '+
                             'ryhmäjohtoja ilman vikavirtasuojakytkimiä tms. erityisjärjestelyjä, <u>vaikka '+
                             'samassa keskuksessa tai pääjohdossa olisi '+fPoiskAikaRajaS +' s :n lähtöjä</u>.'
                 {then sa := sa +'EDELLÄ olevien keskusten Zpe -ehdon täyttymisen kannalta</b> ja '+
                             CLR_GRB+'mahdollistaa jakokeskukseen liitettäväksi '+fPoiskAikaRajaS +' s :n poiskytkentäajan '+
                             'ryhmäjohtoja ilman vikavirtasuojakytkimiä tms. erityisjärjestelyjä, <u>vaikka '+
                             'samassa keskuksessa tai pääjohdossa olisi 5 s :n lähtöjä</u>.'}       //'6.2.21
                  else sa := sa +'...';
                  sa := sa +FNT_B0;
                            //,sc jo valmiiksi editoitavassa muodossa: '1,2,3.. jne.'=pilkkuerottimt
                 {ad3SF (1,sd,'=',sa);                //<Tulostetaan loppuosa ######################
                          sd := '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25';}
                  ad3SF (1,sd,'=',sa);                //<Tulostetaan loppuosa #############=Testattu
{34'###>}      end;
{32'###>}   end;//else
{3' ###>}END//if ZpeOK
         //,,############################# Tähän ohjataan demoversio ###############################
{4,}     ELSE begin   //,,,,,,,,,,,,,,,,,, Yksikään JK-PTeiOK,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
            sa := tab1 +'<b>Zpe -ehto ei täyty</b>, joten '+CLR_REB;
            if kesja>1  then sa := sa +'ketjun mihinkään ';                                         //,Takas +7.0.1
            sa := sa +'jakokeskukseen tai pääjohtoon ei voi liittää 5 s :n poiskytk.ajan ryhmäjohtoja, ellei ';
            if det3
            then sa := sa +'niitä varusteta vikavirtasuojakytkimellä '+
                       'tai pot.tasauksella, <u>mikäli samassa keskuksessa tai pääjohdossa on myös '+
                       fPoiskAikaRajaS +' s :n lähtöjä</u>.'
           {sa := sa +'jakokeskukseen tai pääjohtoon ei voi liittää '+fPoiskAikaRajaS +' s :n poiskytk.ajan '+
                      'ryhmäjohtoja, ellei ';
            if det3
            then begin
                 sa := sa +'niitä varusteta vikavirtasuojakytkimellä tai pot.tasauksella';
                 if fValittuPoisAika<1                                                              //<,,6.2.21
                 then sa := sa +', <u>mikäli samassa keskuksessa tai pääjohdossa on 5 s :n lähtöjä</u>.'
                 else sa := sa +'.';  end}
            else sa := sa +'...';
            sa := sa +FNT_B0;
{4'###>}    ad3SF (1,'','',sa);                    //<Tulostetaan ######################=Testattu
         end;//if ZpeOK..else
      END;//if NJsul=0..else
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*
//--------------------------------------------- 5. RIVI ---------------------------------------------------------
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    sijArvo (1, ehtoSs, dShIsu,dShsIsu,ShLop, sa);                  //<sa palauttaa valmiin stringin
      if sa<>''  then begin
         sc := 'dSul';
         if ehtoSs  then sc := '<b><u>' +sc +'</u></b>';
   ad3SF (1,sc,'=',sa);  end;
//--------------------------------------------- 6. RIVI ---------------------------------------------------------
      sijArvo (2, ehtoKat, dKh,dKhs,SKhLop, sa);                    //<sa palauttaa valmiin stringin
      if sa<>''  then begin
         sc := 'dKatk';
         if ehtoKat  then sc := '<b><u>' +sc +'</u></b>';
   ad3SF (1,sc,'=',sa);  end;
//--------------------------------------------- 7. RIVI ---------------------------------------------------------
      sijArvo (3, ehtoUh, dPhuh,dPhsuh,PuhLop, sa);                 //<sa palauttaa valmiin stringin
      if sa<>''  then begin
         sc := 'dUh%';
         if ehtoUh  then sc := '<b><u>' +sc +'</u></b>';
   ad3SF (1,sc,'=',sa);  end;
//--------------------------------------------- 8. RIVI ---------------------------------------------------------
      sa := fDemRx_PRO (0, uh,1,3) +' %' +tab1 +'Jännitealenema johdon lopussa = Ih '+FONT_2JUURI +
            '3 (R cos' +FONT_FII +' + X sin' +FONT_FII +') * 100 / U  = (PR + QX) * 100 / U². ';
     {if demo                                                                                               -4.0.0
      then sa := sa +',   arvo sisältää ed. verkon osuuden '+fRmrkt0 (a_getReaa (31141, edv.NjL.edUhOsa),1,3) +
                 ' %,   perinteisellä tavalla 100PL / (' +FONT_GAMMA+' AU ²) = '+CLR_REB +fRmrkt0 (uhv, 1,3) +
                 ' %,   virhe = '+fRmrkt0 ((uhv/uh -1)*100, 1,1) +' %.' +FNT_B0 +'   Virhe olisi suurempi, '+
                 'jos ed.verkkokin olisi laskettu ''perinteisesti'''
      else sa := sa +'...';}
      if det2 or det3
      then begin                                                                     //<,+4.0.0
         sa := sa +'   Perinteisellä tavalla laskettuna:  100PL / (' +FONT_GAMMA+' AU²) = '+CLR_REB +
                  fRmrkt0 (uhv, 1,3) +' %,   virhe = ';
         ar := (uhv/uh -1)*100;
         if ar>0  then sa := sa +'+';
         sa := sa +fRmrkt0 (ar,1,1) +' %.' +FNT_B0 +' Virhe kasvaa suuremmaksi cos' +FONT_FII +':n '+
               'huonontuessa ja/tai poikkipinnan ja kuorman kasvaessa.';  end
      else sa := sa +'...';
   ad3SF (1,'Uh%','=',sa);

   editEdvSiirrot;

//--------------------------------------------- 9. RIVI ---------------------------------------------------------
      ai := fTuh;
    //i := a_getIntg (31142, nj.jy.Tk1v);
    //IF (NJtyp='SVjärjest.') or (NJtyp='AXCMK') or (NJtyp='AXMK')               //< -6.0.2
     {IF fOnSV (NJtyp) or SamIso (NJtyp,'AXCMK') or SamIso (NJtyp,'AXMK')        //< +6.0.2
         THEN IF njmm2>=2400  THEN i := 90                //<SVj :lla Tsal isompi<<<<<<<<<<<<<<<<<<<
                              ELSE i := 90
         ELSE                      i := 70;}              //<''Nyt tarpeeton, ks. seur.VexKommentoitu {if ai<i ..}
      sa := fImrkt0 (ai,1) +' °C' +tab1 +'Uh% :n (resistanssien) laskentalämpötila';
      if det3
      then begin
           sa := sa +', joka on pienennetty tarvittaessa jatkuvan tilan max.arvoon:   PEXillä 90 '+
                   'ja PVCllä 70 °C :ään,   annettu Tk1v = '+fImrkt0 (a_getIntg (31143, nj.jy.Tk1v),1) +' °C';
          {if ai<i  then begin }sa := sa +'.     Jos kosketussuojausehdot rajoittavat ylivirtasuojauksen '+
                                'arvoa, rajoittuu lämpötilakin yhtälön mukaan:   Tuh = (IsulMax / YVsul) ² × '+
                                '(Tsal - Ty) + Ty,   missä YVsul = kaapelin ja olosuhteiden sallima '+
                                'ylivirtasuojasulake,   Ty = ympäristön lämpötila:   asenn.A,C = 25,  '+
                                'D = 15 °C.   Jos kaapelille ei ole IsulMax -arvoa';
                         if NJsul=0  then sa := sa +'(kuten tässä)';
                         sa := sa +', korvataan ( ) -lauseke (IkatMax / YVkat) :lla.     Menetelmä pienentää '+
                         'laskentalämpötilaa vain, jos suojausehdot rajoittavat ylivirtasuojauksen arvoa.     '+
                         'Arvo rajoitettu:   SÄL = 25°C   ja   KUL = 50 °C';  {end; }end
      else sa := sa +'...';
   ad3SF (1,'Tuh','=',sa);
//-------------------------------------------- 10. RIVI ---------------------------------------------------------
                  //Ik1v  ,                 NJkin,Qtyp....Qt, Rz,Xz,Kz,Lz <<<<<<<<<<<<<<<<<<<<<<<<<<
       //rr := iks (Ik3vFA, Ziks (1,edmaxkpl,TRUE,'',0,0,0,0, ar,ar,ar,ar1)); //<Ik1v.. -> ar1 = LzMax  -4.0.0
                  //Ik1vk,                          ,Qtyp....Qt, Rz,Xz,Kz,Lz <<<<<<<<<<<<<<<<<<<<<<<
         if edNo<0  then e := edNo  else e := edNo-1;                        //< +6.2.2  §?§
         rr := iks (Ik3vFA, e, Ziks (12,e,NJkinTR,0,'',0,0,0,0, ar,ar,ar,ar1)); //< 12=MinIk1v.. -> ar1 = LzMax
         ii := 0;   if rr<1000  then ii := 1; //<Oli Ikm, muutos 1.0.9, ei vaikuta arvoon = sama
      sa := fDemRx_PRO (1, rr,1,ii) +' A' +tab1 +'Minimi oikosulkuvirta (= maxZ -pisteessä = '+
            fRmrkt0 (ar1, 1,1) +' m)';
   ad3SF (1,'Ik1v','=',sa);
//-------------------------------------------- 11. RIVI ---------------------------------------------------------
         ii := 3;   if ImgKat/1000>=10  then ii := 1   else
                    if ImgKat/1000>=1   then ii := 2;
      sa := fDemRx_PRO (0, ImgKat/1000,1,ii) +'/';
         ii := 3;   if NJKat/1000>=10  then ii := 1   else
                    if NJKat/1000>=1   then ii := 2;
         ai := 0;  if NJkat>=KeroMg*ImgKat  then ai := 1;

         if (ai>0)  or  Y_esittelyEhto  then sa := sa +CLR_REB;  //< lihavoi, ei mahdu //COLOR_RED
      sa := sa +fDemRx_PRO (0, NJkat/1000,1,ii);                 //',Pakotetaan demossa esiin ######
         if (ai>0)  or  Y_esittelyEhto  then sa := sa +FNT_B0;
      sa := sa +' k' +tab1 +'Katkaisijan magneettinen (0.8×Ik1v, oikosulku-) ja terminen ';
      if det3
      then begin sa := sa +'(ylivirtasuoja-) asetus,   k = [kA].   Terminen asetus on tarkistettu, ettei '+
                       'ole liian lähellä magneettista asetusta (ero -' +fDemRx_PRO (0, (1-KeroMg)*100,1,0) +'%).';
           if ZSiso  then sa := sa+'   ZsIa -ehto on ollut määräävä.';
           if (ai>0) or Y_esittelyEhto  then
                 sa := sa+'   '+CLR_REB +'Img/Iterm -asetusero < 15%'+FNT_B0 +',  tarkista '+
                 'valmistajalta eron riittävyys,  tarvittaessa valitse isompi kaapeli.';

           sExt := YvSuo (0,1, suCse,TRUE,TRUE, a_getStrg (31144, nj.jy.AsTapa), a_getReaa (31145, nj.jy.Korjaus),
                     NJtyp,NJmm2,NJkaapx, ar);          //'Demo(1),Erittely(1), YhteisSuoja, Katkais
           sa := sa +'   Perusteet :  '+sExt;   end
      else sa := sa +'...';
  ad3SF (1,'Mg/Term','=',sa);
//-------------------------------------------- 12. RIVI ---------------------------------------------------------
      //,,,,,Ik3a + Ik3b KÄYTÖSSÄ JÄLJEMMILLÄ RIVEILLÄ ##########################################################
      if kesja>1  then sb := 'Ik3v ketjun 1. / viimeisessä jakokeskuksessa'
                  else sb := 'Ik3v jakokeskuksessa';
      if NOT det3  then
         sb := sb +'...';

      if edNo<0  then e := edNo  else e := edNo-1;                               //< +6.2.2  §?§
      Ik3a := iks (Ik3vTR, e, Ziks (32,e,NJkinTR,0,'',0,0,0,0, ar,ar,ar,ar)) /1000; //<Ik3v 1.JK :ssa  4.0.0
         ii := 3;   if Ik3a>=10  then ii := 1   else
                    if Ik3a>=1   then ii := 2;
      sa := fDemRx_PRO (0, Ik3a,1,ii);

      Ik3b := 0;
      if kesja>1  then begin
         Ik3b := iks (Ik3vTR, e, Ziks (31,e,NJkinTR,0,'',0,0,0,0, ar,ar,ar,ar)) /1000; //<Ik3v v.JK :ssa  4.0.0
            ii := 3;   if Ik3b>=10  then ii := 1   else
                       if Ik3b>=1   then ii := 2;
         sa := sa +'/'+fDemRx_PRO (1, Ik3b,1,ii);  end;

      sa := sa +' kA' +tab1 +sb;
   ad3SF (1,'Ik3v','=',sa);

   if det3  then begin
      ad1SF ('Kuluttajaverkossa, missä on muuntaja:');
      ad1SF ('Ik3v = Uv / ' +FONT_2JUURI +'{[Ry+Rm+Rv] ² + [Xy+Xm+Xv] ²}   ja ilman muuntajaa :');
      ad1SF ('1k3v = Ik3v` × eIk3v / (Ik3v` + eIk3v),   missä eIk3v = liittymän ilmoitettu Ik3v,   '+
                      'Ik3v` = Uv / '+FONT_2JUURI+'(Rv ² + Xv ²).   Arvo likimääräinen, koska '+
                      'laskennassa käytetty Ik1v :n Rs ja Xs arvoja liittymäpisteessä, eikä yhtälö ota '+
                      'huomioon vaihesiirtoa. Arvo on sitä tarkempi mitä lähempänä liittymäpistettä ollaan.');
   end;
//-------------------------------------------- 13. RIVI ---------------------------------------------------------
      //,,,,,Ik3a + Ik3b RIVIN 12 ARVOISTA ######################################################################
      if kesja>1  then sb := 'Ekvivalenttinen 1 s:n terminen Ik3v ketjun 1. / viimeisessä jakokeskuksessa'
                  else sb := 'Ekvivalenttinen 1 s:n terminen Ik3v jakokeskuksessa';
      sb := sb +' (<b>kilpiarvo Icw</b>).';
     {if det3  then sb := sb +',   '  //< -6.0.0
               else sb := sb +'...';}
    //if NOT det3  then sb := sb +'...';

      if edNo<0  then e := edNo  else e := edNo-1;      //< +6.2.2  §?§
      Ziks (32,e,NJkinTR,0, '',0,0,0,0, rr1,rr2,ar,ar); //<3=Ik3v vikassa JK:ssa.              4.0.0
      ar1 := sys_ker (rr1,rr2);
      ar1 := m_tasav (ar1,1);                      //<m_tasavKerroin = f(sysKerr,Aika 1s)
      ar1 := Ik3a * Sqrt (ar1 +1);                 //< +1 = n  eli V¨[(m+n)tim] ja tim=1s ##########
         ii := 3;   if ar1>=10  then ii := 1   else
                    if ar1>=1   then ii := 2;
      sa := fDemRx_PRO (1, ar1,1,ii);

      if kesja>1  then begin
         Ziks (31,e,NJkinTR,0, '',0,0,0,0, rr1,rr2,ar,ar); //< 31=Zk3v JohdnLoppuun  4.0.0
         ar2 := sys_ker (rr1,rr2);
         ar2 := m_tasav (ar2,1);                   //<m_tasavKerroin = f(sysKerr,Aika 1s)
         ar2 := Ik3b * Sqrt (ar2 +1);              //< +1 = n  eli V¨[(m+n)tim] ja tim=1s ##########
         ii := 3;   if ar2>=10  then ii := 1   else
                    if ar2>=1   then ii := 2;
         sa := sa +'/' +fDemRx_PRO (0, ar2,1,ii);  end;

      sa := sa +' kA' +tab1 +sb;
   ad3SF (1,'Ik3th','=',sa);
//-------------------------------------------- 14. RIVI ---------------------------------------------------------
      //,,,,,Ik3a + Ik3b RIVIN 12 ARVOISTA ######################################################################
      if kesja>1  then sb := 'Dynaaminen (sysäys-) Ik3v ketjun 1. / viimeisessä jakokeskuksessa'
                  else sb := 'Dynaaminen (sysäys-) Ik3v jakokeskuksessa';
      sb := sb +' (<b>kilpiarvo Ipk</b>).';
      {if det3  then sb := sb +',   '  //< -6.0.0
               else sb := sb +'...';}
      if NOT det3  then sb := sb +'...';

      if edNo<0  then e := edNo  else e := edNo-1;      //< +6.2.2  §?§
      Ziks (32,e,NJkinTR,0, '',0,0,0,0, rr1,rr2,ar,ar); //< 32=Zk3v vikassa JK:ssa.            4.0.0
      ar1 := Ik3a * sys_ker (rr1,rr2);                  //<Ik3vd 1.JK :ssa
         ii := 3;   if ar1>=10  then ii := 1   else
                    if ar1>=1   then ii := 2;
      sa := fDemRx_PRO (0, ar1,1,ii);

      if kesja>1  then begin
         Ziks (31,e,NJkinTR,0, '',0,0,0,0, rr1,rr2,ar,ar); //< 31=Zk3v johdnLoppuun.           4.0.0
         ar2 := Ik3b * sys_ker (rr1,rr2);                  //<Ik3vd v.JK :ssa
            ii := 3;   if ar2>=10  then ii := 1   else
                       if ar2>=1   then ii := 2;
         sa := sa +'/' +fDemRx_PRO (0, ar2,1,ii);  end;

      sa := sa +' kA' +tab1 +sb;
      if det3  then sa := sa +'   Suojalaitteen oikosulkua rajoittavaa vaikutusta ei ole huomioitu.';
   ad3SF (1,'Ik3d','=',sa);
//-------------------------------------------- 15. RIVI ---------------------------------------------------------
     {--------------------Vex: Lasketaan ja varoitetaan tulost:ssa/31.INC-----------,ImgTim-asetus EISAA=LYHYT
         IF (0.1 > Tekv (Iksalterm (NJtyp,NJmm2),  //,0=Ik3v 1.JK:lle. =TimEkviv.
                         iks (Ik3vTR, Ziks (0,edmaxkpl,TRUE,'',0,0,0,0, ar,ar,ar,ar)) ))
            OR  (0.1 >Tekv (Iksalterm (NJtyp,NJmm2), ImgKat))
            THEN N1ehto := FALSE;
      END;------------------------------------------------------------------------------------------}
       //ii := a_getIntg (31146, edv.YLE.JohtoOsia_); //< -4.0.0
         ii := edNo-1;                                //< +3.0.3  4.0.0
    (*rr := iks (Ik3vTR, Ziks (3,ii,FALSE{eiNJ},'',0,0,0,0, ar,ar,ar,ar));       //<Ik3v edv:n LOPUSSA  6.0.0=OK

      ar1 := Iksalterm (NJtyp,NJmm2);        //<Ekviv max. aika EDV:n LOPUSSA = NJn alussa #########
      ar := Tekv (ar1, rr);                  //ar := 0.199;     //TestattuOK------------------*)//<' -6.0.0
    //ar := Tekv_mn (ii,ii,0,NJkinTR);       //< os,TypOsMukaan (ei väliä NJllä),tamaIK,NJkin.   +6.0.0
      ar := Tekv_mn (edNo,0,NJkinTR);        //< edNo=TypOsMukaan +7.0.5 (ei väliä NJllä),tamaIK,NJkin.   +6.0.0, 6.2.21
         ii := 3;   if ar>=10  then ii := 1   else //'NJkin oli aikaisemmin FA, 6.0.0 :ssa TR.!!!!!
                    if ar>=1   then ii := 2;
      if ar<=0.2  then sa := CLR_REB +fDemRx_PRO (0, ar,1,ii) +' s' +FNT_B0   else
      if ar>=20   then sa :=                           '> 20 s'           else
                       sa :=          fDemRx_PRO (0, ar,1,ii) +' s';
      sa := sa +tab1 +'Max. aika-asetus (magn.laukaisu) nousujohdon lähdössä Ik3th :lla'; //< Ik3v => Ik3th 7.0.5
      if det3  then begin
         sa := sa +' laskettuna kaapelin termisen sallitun max.arvon (';
       //if ar1<10000  then sa := sa +fRmrkt0 (ar1,1,0)+' A'   else sa := sa +fRmrkt0 (ar1/1000,1,1)+' kA'; //6.2.21
         if ar1<1  then sa := sa +fRmrkt0 (ar1*1000,1,0)+' A'
                   else sa := sa +fRmrkt0 (ar1,1,3)+' kA';
         sa := sa +') perusteella   t = (IkSal / Ik3v) ² / (m+n),   missä m = tasavirta- (' +
               FONT_LIKIM +' 0) ja n = vaihtovirtakomponentti (' +FONT_LIKIM +'1)';
         if (ar<=0.05) or  Y_esittelyEhto  then                       //<,Pakotetaan demossa esiin
            sa := sa +'.   '+CLR_REB +'Huomaa poikkeuksellisen lyhyt laukaisuaikavaatimus < 0.05 s!, '+
                      'saattaa vaatia erityistoimenpiteitä.'+FNT_B0  else
        if (ar<=0.2)  then
           sa := sa +'.   '+CLR_REB +'Huomaa verraten lyhyt laukaisuaikavaatimus < 0.2 s!'+FNT_B0;
        if a_getBool (31147, nj.jy.NjKulSal)  and  (ar < a_getReaa (31147, edv.YLE.PoisAika))  then
           sa := sa +'   <b>Laskettu katkaisuaika on</b> '+CLR_REB +'määräävä '+FNT_B0 +'<b>(pienempi '+
                     'kuin valittu poiskytkentäaika).</b>';  end
      else sa := sa +'...';
   ad3SF (1,'t MaxIk3','=',sa);
//-------------------------------------------- 16. RIVI ---------------------------------------------------------
                    { L   = u%  * U² / (200*P*r),  r =r*LTkorj1.0786, LT=40°C  =L = u% Uv²/(200P(r + x tanø))
                      L2.5= 2.5 * 0.4² / (200*3.3*0.00741*1.0786) = 0.04549 km     //<VÄÄRÄ Uv (=Un) NolaDOS
                      L1.5= 1.5 * 0.4² / (200*2.2*0.0121 *1.0786) = 0.04179 km     //<VÄÄRÄ Uv (=Un) NolaDOS
                            ^u%   ^U          ^kW ^r      ^LTkorj                                  }
                    { L2.5= 1.5 * 0.231² / (200*3.3*0.00741*1.0786) = 0.01517 km
                      L1.5= 1.5 * 0.231² / (200*2.2*0.0121 *1.0786) = 0.01394 km

                      L2.5= 2.5 * 0.231² / (200*3.3*0.00741*1.0786) = 0.02529 km
                      L1.5= 2.5 * 0.231² / (200*2.2*0.0121 *1.0786) = 0.02323 km
                            ^u%   ^U          ^kW ^r      ^LTkorj                                  }
      sc := 'Rj uh%2.5';
      sa := '25/23 m' +tab1 +'Ryhmäjohtojen 2.5 / 1.5 mm² (3.3 / 2.2 kW)  max.pituudet, joilla uh=2.5%';
      if det3  then sa := sa +'.   Pituudet ovat vakioita, jos reaktanssit ovat häviävän pieniä Ph :n Cos'+
                          FONT_FII +' :stä riippumatta :   uh% = 200 (Rv P + Xv Q) / Uv²  ' +FONT_OIKEALLE +'  '+
                          'L = uh% Uv² / [200 P (r + x tan'+FONT_FII +')]'
      else sa := sa +'...';
   if det3  then ad3SF (1,sc,'=',sa)  //<,Koska ryhmäjohtotul :n SISB tekee LF
            else ad3S_ (1,sc,'=',sa);
//-------------------------------------------- 17. RIVI ---------------------------------------------------------
{Max. pistorasiaryhmäjohdon pituus, 0.4 s,  16A MMJ 2,5mm²:   <<< = EdvDet
Dz  16	=	47.8 m    Dz-tulppasulakkeella (tarvittava Ik=110 A). A2/413.1.3.3- .5 = OK.
jkB 16	=	92.9 m    B-tyypin js-katkaisijalla (tarvittava Ik=80 A). A2/413.1.3.3- .5 = OK.
jkC 16	=	10.1 m    C-tyypin js-katkaisijalla (tarvittava Ik=160 A). A2/413.1.3.3- .5 = OK.
jkD 16	=	0.0 m, rajoitukset :
T	=	Poiskytkentäaika 0.4s ei toteudu (tarvittava Ik=320 A)}
//==Pr 16 0.4s ==================================================================
onjoPinf := false; //<Ohjaa max.pituuksien P -herjan selitystä, ks. Nola3Y\PRC TUPsel
onRJinf :=  false; //<On max.pituuksia KORVAAVAA YHTEIStietoa,  ks. Nola3Y\PRC TUPsel ja alenpana
   if det3  then begin
      sisA;
      ad1SF ('<b>Nousujohdon päähän (ketjutuksessa etäisinpään keskukseen) liitettävien RYHMÄJOHTOJEN MAX.PITUUDET :</b>');
      ad1SF ('Jos seuraavien pituusarvojen jäljessä esiintyy jokin huomautuksista '+CLR_REB+'T,U,P'+FNT_B0 +
             ', on käytettävä vikavirtasuojakytkintä tai lisäpotentiaalintasausta, <b>yleensä 0.4 s:n lähdössä</b>.');
      ad1S_ ('Jäljempänä esiintyvä <b>js-katkaisija = johdonsuojakatkaisija</b>.');
   end;
sisVex;
sisB;
{     Tul_PrRj (10, fPoiskAikaRaja, 1, su_IECd, 'Dz  10A ' +sa +'s', 'Dz-tulppasulakkeella   ',   ' 0.4s => 82 A');
Dz  10A .4s = 138.8 m  Dz-tulppasulakkeella      (tarvittava Ik= 0.4s => 82 A). A2/413.1.3.3- .5 = OK.
Dz  10A .4s = 138.8 m  Dz-tulppasulakkeella      (0.4 s = tarvittava Ik=82 A). A2/413.1.3.3- .5 = OK.

      Tul_PrRj (10,   5, 1, 'B',     'jkB 10A  5s', 'B-tyypin js-katkaisijalla', '50 A');
jkB 10A  5s = 245.7 m  B-tyypin js-katkaisijalla (tarvittava Ik=50 A). A2/413.1.3.3- .5 = OK.
jkB 10A  5s = 245.7 m  B-tyypin js-katkaisijalla (5 s = tarvittava Ik=50 A). A2/413.1.3.3- .5 = OK.
}
sc := fPoiskAikaRajaS;  sa := sc[2] +sc[3]; //< 0 vex -> .4 tms  +2.0.5  =0.4 -> .4
   if det2 or det3  then begin
      LF;                      //<1 :lla jätetään väli vex
   ad1SF ('<b>Pistorasialähdöt <u>16A ' +fPoiskAikaRajaS +'s</u>  MMJ 2,5mm² :</b>');  end;
//    Tul_PrRj (16, fPoiskAikaRaja, 2, su_IECd, 'Dz  16A ' +sa +'s', 'Dz-tulppasulakkeella   ',   ' 0.4s => 110 A');
      Tul_PrRj (16, fPoiskAikaRaja, 2, su_IECd, 'Dz  16A ' +sa +'s', 'Dz-tulppasulakkeella   ',  {' 0.4s =>}'110 A');
      Tul_PrRj (16, fPoiskAikaRaja, 2, 'B',     'jkB 16A ' +sa +'s', 'B-tyypin js-katkaisijalla',{' 0.4s =>}'80 A');
      Tul_PrRj (16, fPoiskAikaRaja, 2, 'C',     'jkC 16A ' +sa +'s', 'C-tyypin js-katkaisijalla',{' 0.4s =>}'160 A');
      Tul_PrRj (16, fPoiskAikaRaja, 2, 'D',     'jkD 16A ' +sa +'s', 'D-tyypin js-katkaisijalla',{' 0.4s =>}'320 A');
   if det2 or det3  then
   ad1SF ('<b>Pistorasialähdöt <u>10A ' +fPoiskAikaRajaS +'s</u>  MMJ 1,5mm² :</b>');
      Tul_PrRj (10, fPoiskAikaRaja, 1, su_IECd, 'Dz  10A ' +sa +'s', 'Dz-tulppasulakkeella   ',  {' 0.4s =>}'82 A');
//Dz  10A .4s = 138.8 m  Dz-tulppasulakkeella      (tarvittava Ik= 0.4s => 82 A). A2/413.1.3.3- .5 = OK.
      Tul_PrRj (10, fPoiskAikaRaja, 1, 'B',     'jkB 10A ' +sa +'s', 'B-tyypin js-katkaisijalla',{' 0.4s =>}'50 A');
      Tul_PrRj (10, fPoiskAikaRaja, 1, 'C',     'jkC 10A ' +sa +'s', 'C-tyypin js-katkaisijalla',{' 0.4s =>}'100 A');
      Tul_PrRj (10, fPoiskAikaRaja, 1, 'D',     'jkD 10A ' +sa +'s', 'D-tyypin js-katkaisijalla',{' 0.4s =>}'200 A');
   if det2 or det3  then                                                                            //<, +4.0.0
   ad1SF ('<b>Pistorasialähdöt </b><u>'+CLR_BLB +'10A ' +fPoiskAikaRajaS +'s</u>  MMJ 2,5mm² :'+FNT_B0+ '</u>');
      Tul_PrRj (10, fPoiskAikaRaja, 2, su_IECd, 'Dz  10A ' +sa +'s', 'Dz-tulppasulakkeella   ',  {' 0.4s =>}'82 A');
      Tul_PrRj (10, fPoiskAikaRaja, 2, 'B',     'jkB 10A ' +sa +'s', 'B-tyypin js-katkaisijalla',{' 0.4s =>}'50 A');
      Tul_PrRj (10, fPoiskAikaRaja, 2, 'C',     'jkC 10A ' +sa +'s', 'C-tyypin js-katkaisijalla',{' 0.4s =>}'100 A');
      Tul_PrRj (10, fPoiskAikaRaja, 2, 'D',     'jkD 10A ' +sa +'s', 'D-tyypin js-katkaisijalla',{' 0.4s =>}'200 A');
   if det2 or det3  then  begin
   LF;
   ad1SF ('<b>Kiint.laitteiden lähdöt <u>16A  5s</u>  MMJ 2,5mm² :</b>');  end;
      Tul_PrRj (16,   5, 2, su_IECd, 'Dz  16A  5s', 'Dz-tulppasulakkeella   ',   '65 A');
      Tul_PrRj (16,   5, 2, 'B',     'jkB 16A  5s', 'B-tyypin js-katkaisijalla', '80 A');
      Tul_PrRj (16,   5, 2, 'C',     'jkC 16A  5s', 'C-tyypin js-katkaisijalla', '112 A');
      Tul_PrRj (16,   5, 2, 'D',     'jkD 16A  5s', 'D-tyypin js-katkaisijalla', '112 A');
   if det2 or det3  then
   ad1SF ('<b>Kiint.laitteiden lähdöt <u>10A  5s</u>  MMJ 1,5mm² :</b>');
      Tul_PrRj (10,   5, 1, su_IECd, 'Dz  10A  5s', 'Dz-tulppasulakkeella   ',   '46.5 A');
      Tul_PrRj (10,   5, 1, 'B',     'jkB 10A  5s', 'B-tyypin js-katkaisijalla', '50 A');
      Tul_PrRj (10,   5, 1, 'C',     'jkC 10A  5s', 'C-tyypin js-katkaisijalla', '70 A');
      Tul_PrRj (10,   5, 1, 'D',     'jkD 10A  5s', 'D-tyypin js-katkaisijalla', '70 A');
   if det2 or det3  then                                                                            //<, +4.0.0
   ad1SF ('<b>Kiint.laitteiden lähdöt </b><u>'+CLR_BLB +'10A  5s</u>  MMJ 2,5mm² :'+FNT_B0+ '</u>');
      Tul_PrRj (10,   5, 2, su_IECd, 'Dz  10A  5s', 'Dz-tulppasulakkeella   ',   '46.5 A');
      Tul_PrRj (10,   5, 2, 'B',     'jkB 10A  5s', 'B-tyypin js-katkaisijalla', '50 A');
      Tul_PrRj (10,   5, 2, 'C',     'jkC 10A  5s', 'C-tyypin js-katkaisijalla', '70 A');
      Tul_PrRj (10,   5, 2, 'D',     'jkD 10A  5s', 'D-tyypin js-katkaisijalla', '70 A');

   if det1 and onRJinf  then
      ad1SF (CLR_REB +'Ryhmäjohtojen asennettavuudessa rajoituksia. '+FNT_B0 +'Lisätietoa: Valitse '+
             '"<b>TulostLaaj</b>" laajuus 3');
//\\\\\\\\\\\\\\\\\\\\\\\\\\\ Sulkemalla tähän asti vex, on helpompi seurata Al/Cu/mm2 \\\\\\\\\\\\\\\\\\\*)
{  ad3SF (1,'KuorSul','=',fImrkt0 (KuorSul,1));
   ad3SF (1,'NJsul','=',fImrkt0 (NJsul,1));
   ad3SF (1,'YVsul','=',fImrkt0 (YVsul,1));
   ad3SF (1,'ZSsul','=',fImrkt0 (ZSsul,1));
   ad3SF (1,'IkSul','=',fImrkt0 (IkSul,1));
   ad3SF (1,'ZSiso','=',fBmrkt0 (ZSiso,0));}
//end;//if NJlaji =Koetulostukseen \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*)

      if tuxV=1  then sa := '+'  else sa := ',';
      sa := sa + fImrkt0 (tuxV,1);
   esitaProgres (sa, tuxV+1);  //<PRC esitaProgres kasvattaa merkkijonoa (sa):  VEt: Yle+1,2,3,4... jne.}
//LF;                          //<Tulisi 2 tyhjää riviä, TODETTU. <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//KirjoitaChkFile (str);
   NjTulFrm.aRich.AddText (str);   str := '';
END;//tulostanousu
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ NjTul31.INC }
