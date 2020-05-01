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

{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ DetEv-2.INC }
function ediJohto (rec :EdvPalstaType;  tabS :string) :string;      VAR sa :string;  j :integer;      begin
            sa := '';
            j := a_getIntg (10116, rec.lukumaara);
         if j>1  then sa := sa +fImrkt0 (j,1) +' x ';
         sa := sa +tabS;
         sa := sa +a_getStrg (10117, rec.tyyppi)             +' '      +tabS;
         sa := sa +fMm2Des (a_getReaa (10118, rec.Amm2),1) +' mm² '  +tabS;                    //< +6.2.16
         if a_getBool (10119, rec.kuluttaja)  then sa := sa  +'KUL'
                                              else sa := sa  +'SÄL';   sa := sa +' ' +tabS;
         sa := sa +fRmrkt0 (a_getReaa (10120, rec.pituus),1,1)  +' m ' +tabS + 'PEker='+
                   fRmrkt0 (a_getReaa (10120, rec.PEker),1,3)    +' '   +tabS +
                   fImrkt0 (a_getIntg (10121, rec.lampotila),1) +'°C ' +tabS +'korj='+
                   fRmrkt0 (a_getReaa (10122, rec.korjaus),1,3);
         result := sa;
end;
//===============================================================================================================
function ediJohtoDet (ao :integer) :boolean;      LABEL 3,9;
      VAR s_e,fo,f_,i,j,k,o :integer;   Rv,Rvo,Rn, Xv,{Xvo,}Xn, Rs,Xs,Zs,Ls,
          ar,rr,r8,a8,a7 :real;   req,rec :EdvPalstaType;
         {Qpt,}Qkul :boolean;  Qtyp,Btyp :string;  QUn,Qkpl,Bkpl,Qlampot,Blampot :integer;
          Qmm2,Bmm2,Qpit,Bpit,Qkorj,QKpe,Qtim  :real;

   function ifs_e (oh1,oh2 :integer) :integer;      VAR ii :integer;      begin
      if s_e=1  then ii := oh1
                else ii := oh2;
      result := ii;  end;

begin//ediJohtoDet...........
   result := true;
   if ao<0  then s_e := 1    //<Liittymäjohto/Sorc[]
            else s_e := 2;   //<Jakeluverkko /Edka[]
   fo := ao;                 //<Säilyttää etumerkin +/-
   ao := Abs (ao);

   if s_e=1  then begin  req := edv.Sorc[ao].josa;
                         f_ :=  ao;  end
             else begin  req := edv.Edka[ao];
                         f_ :=  ao-1;  end;

   if not req.OnArvot  then begin
      result := false;              //<#############################################################
      GOTO 9;  end;                 //<#############################################################

   ad1SF (ediJohto (req, tab1));    //<#############################################################

   Qkul :=    a_getBool (10142,req.kuluttaja);
   if not Qkul  then Qtim := 15                             //<Varm.vuoksi<<<<<<<<<<<<<<<<<<<<<<<<<<
                else Qtim := Gtim;
 //Qpt :=     a_getBool (10143,req.PTlopussa);
   Qtyp :=    a_getStrg (10144,req.tyyppi);
   Qmm2 :=    a_getReaa (10145,req.Amm2);
   Qkpl :=    a_getIntg (10146,req.lukumaara);
   Qpit :=    a_getReaa (10147,req.pituus);
   Qlampot := a_getIntg (10148,req.lampotila);
   Qkorj :=   a_getReaa (10149,req.korjaus);
   QKpe :=    a_getReaa (10149,req.PEker);

 //ad1SF (fImrkt0 (Qkpl,1)+' x '+Qtyp+' '+fRmrkt0 (Qmm2,1,0)+' mm²  '+fRmrkt0 (Qpit,1,1)+' m');
      sa := 'Suojausehtotarkastelu: ';
      if Qkul  then sa := sa +'Kuluttaja-asennus t='+fRmrkt0 (Qtim,1,1)+'s'
               else sa := sa +'SÄHkölaitoksen jakeluverkko '+fOik+' MaxSulake = Ik1v/3.0(>63A) tai /2.5';
   ad1SF (sa);
   ad1SF ('T='+fImrkt0 (Qlampot,1)+'°C,   Kuormitettavuuden korjauskerroin='+fRmrkt0 (Qkorj,1,3)+
          '   <b>HUOM! Ohjelma olettaa:</b>  Korjaus=1, kun ympäristölämpötila  Ty=25°C (maassa 15°C), '+
          'rinnakkainasennuksissa  kk=d (koskettavat toisiaan, maassa kk=125), kaapelikerroksia yksi');
   LF;//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

   ad1S_ ('<b>Johtotyypin '+Qtyp+' '+fMm2Des (Qmm2,1)+' arvot :</b>'); //:::::::::::::::::::::::::
      r8 := res (Qtyp,Qmm2)*1000;
      sa := fRmrkt0 (r8,1,d1)+' (20°C,   '+fImrkt0 (Qlampot,1)+'°C=) '+
            fRmrkt0 (rTkorj (fAlCu (Qtyp), r8, Qlampot), 1,d1)+ fOhK+ '   ='+fMm2Des (Qmm2,1)+' mm² ';
      if fAlCu (Qtyp)  then sa := sa+ 'Al'  else sa := sa+ 'Cu';
sisB;
   ad3SF (1, 'Rv', '=',sa);
      r8 := resVo (Qtyp,Qmm2)*1000;                                                                 //<,,+6.0.2
      sa := fRmrkt0 (r8,1,d1)+' (20°C,   '+fImrkt0 (Qlampot,1)+'°C=) '+
            fRmrkt0 (rTkorj (fAlCu (Qtyp), r8, Qlampot), 1,d1)+ fOhK+ '   ='+fMm2Des (Qmm2,1)+' mm² ';
      if fAlCu (Qtyp)  then sa := sa+ 'Al'  else sa := sa+ 'Cu';
   ad3SF (1, 'Rvo', '=',sa);                                                                        //<''+6.0.2
      r8 := resP (Qtyp,Qmm2)*1000;
      sa := fRmrkt0 (r8,1,d1)+' (20°C,   '+fImrkt0 (Qlampot,1)+'°C=) '+
            fRmrkt0 (rTkorj (fPal  (Qtyp), r8, Qlampot), 1,d1)+ fOhK+ '   ='+
            fMm2Des (mm2_Pj (Qtyp,Qmm2),1) +' mm² ';
      if fPal (Qtyp)  then sa := sa+ 'Al'  else sa := sa+ 'Cu';
   ad3SF (1, 'Rn', '=',sa);
   ad3SF (1, 'Xv', '=',fRmrkt0 (Xv_ind  (Qtyp,Qmm2)*1000 ,1,d1)+ fOhK);
   ad3SF (1, 'Xvo','=',fRmrkt0 (Xv0_ind (Qtyp,Qmm2)*1000 ,1,d1)+ fOhK);
   ad3SF (1, 'Xn', '=',fRmrkt0 (Xp_ind  (Qtyp,Qmm2)*1000 ,1,d1)+ fOhK);
   //+1.1.7,,,,,,,,,,,,
 //if Qtyp='SVjärjest.'  then begin                               //< -6.0.2
   if fOnSV (Qtyp)  then begin                                    //< +6.0.2
      ad1SF ('Suurvirtajärjestelmän max.impedanssikomponentit:');
         r8 := RmaxSV (Qtyp,Qmm2) *1000;
         sa := fRmrkt0 (r8,1,d1)+' (20°C,   '+fImrkt0 (Qlampot,1)+'°C=) '+
               fRmrkt0 (rTkorj (fAlCu (Qtyp), r8, Qlampot), 1,d1)+ fOhK;
      ad3SF (1, 'Rmax', '=',sa);
      ad3SF (1, 'Xmax', '=',fRmrkt0 (XmaxSV (Qtyp,Qmm2) *1000 ,1,d1)+ fOhK);
   end;
   //+1.1.7''''''''''''
sisVex;
   ad1S_ (CLR_REB+'HUOM:   Mikäli</f> annettulla kaapelityypillä ja poikkipinnalla '+CLR_REB+
         'ei ole 5 (tai 4½) -johdintyyppiä, lasketaan  alaindeksin n -mukaiset komponentit '+
         '4 (tai 3½) -johtimellisen kaapelin ominaisuuksien mukaan.</f>');  //'</f> = FNT_B0
sisB;
   LF;//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
   ad1SF ('<b>Annetun pituuden mukaan ('+fRmrkt0 (Qpit,1,1)+'m) :</b>'); //:::::::::::::::::::::::::
      r8 := res (Qtyp,Qmm2)*Qpit;
   ad3SF (1, 'Rv', '=',fRmrkt0 (r8,1,d1)+' (20°C,   '+fImrkt0 (Qlampot,1)+'°C=) '+
         fRmrkt0 (rTkorj (fAlCu (Qtyp), r8, Qlampot), 1,d1)+ fOhm);
      r8 := resVo (Qtyp,Qmm2)*Qpit;                                                 //<,+6.0.2
   ad3SF (1, 'Rvo', '=',fRmrkt0 (r8,1,d1)+' (20°C,   '+fImrkt0 (Qlampot,1)+'°C=) '+
         fRmrkt0 (rTkorj (fAlCu (Qtyp), r8, Qlampot), 1,d1)+ fOhm);                 //<'+6.0.2
      r8 := resP (Qtyp,Qmm2)*Qpit;
   ad3SF (1, 'Rn', '=',fRmrkt0 (r8,1,d1)+' (20°C,   '+fImrkt0 (Qlampot,1)+'°C=) '+
         fRmrkt0 (rTkorj (fPal  (Qtyp), r8, Qlampot), 1,d1)+ fOhm);
   ad3SF (1, 'Xv', '=',fRmrkt0 (Xv_ind  (Qtyp,Qmm2)*Qpit ,1,d1)+ fOhm);
   ad3SF (1, 'Xvo','=',fRmrkt0 (Xv0_ind (Qtyp,Qmm2)*Qpit ,1,d1)+ fOhm);
      ar := Xp_ind  (Qtyp,Qmm2);
      if ar=0  then i := 0  else i := d1;
   ad3SF (1, 'Xn', '=',fRmrkt0 (ar*Qpit ,1,i)+ fOhm);
   //+1.1.7,,,,,,,,,,,,
 //if Qtyp='SVjärjest.'  then begin                               //< -6.0.2
   if fOnSV (Qtyp)  then begin                                    //< +6.0.2
      ad1SF ('Suurvirtajärjestelmän max.impedanssikomponentit:');
         r8 := RmaxSV (Qtyp,Qmm2) *Qpit;
         sa := fRmrkt0 (r8,1,d1)+' (20°C,   '+fImrkt0 (Qlampot,1)+'°C=) '+
               fRmrkt0 (rTkorj (fAlCu (Qtyp), r8, Qlampot), 1,d1)+ fOhm;
      ad3SF (1, 'Rmax', '=',sa);
      ad3SF (1, 'Xmax', '=',fRmrkt0 (XmaxSV (Qtyp,Qmm2) *Qpit ,1,d1)+ fOhm);
   end;
   //+1.1.7''''''''''''

   LF;//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
   sa := '<b>Ik1v :n maksimi-impedanssipisteen tekijät :</b>';
 //if (Qkpl<=2) and (Qtyp<>'SVjärjest.')  or  (Qtyp='SVjärjest.') and (SVsuhtL(Qmm2)>0.99999) //< -6.0.2
   if (Qkpl<=2) and NOT fOnSV (Qtyp)  or  fOnSV (Qtyp) and (SVsuhtL(Qtyp,Qmm2) > 0.99999)     //< +6.0.2
      then sa := sa +'   (= Tässä johto-osan lopussa)';
   ad1S_ (sa); //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
sisB;
      sa := FONT_2JUURI+'(Re ² + Xe ²)';
   ad3SF (1, 'Ze','=',sa);
   ad1SF ('Liittymän verkossa, jossa ei ole muuntajaa:');
   ad3SF (1, 'Ze','=',FONT_2JUURI +'{[3eRs + 2Rv+Rvo+3'+COLOR_RED+'Kpe'+FNT_0+'Rn] ² + '+
                                   '[3eXs + 2Xv+Xvo+3'+COLOR_RED+'Kpe'+FNT_0+'Xn] ²}');
   ad1SF ('Liittymän verkossa, jossa on muuntaja:');
   ad3SF (1, 'Ze','=',FONT_2JUURI +'{[2Ry+2Rm+Rmo+2Rv+Rvo+3'+COLOR_RED+'Kpe'+FNT_0+'Rn] ² + '+
                                   '[2Xy+2Xm+Xmo+2Xv+Xvo+3'+COLOR_RED+'Kpe'+FNT_0+'Xn] ²},');
   ad1SF ('jolla   Ik1v = cU×3×Uv/Ze.');
   ad1SF ('Suurvirtajärjestelmille tekijät   2Rv+Rvo+3Rn  ja  2Xv+Xvo+3Xn  on tällä johto-osalla korvattu '+
          'tekijöillä   3Rmax  ja  3Xmax, jotka ovat järjestelmätoimittajan (NK-Energy Oy) erikoisesti '+
          'max.impedanssin määrittämiseen ilmoittamia arvoja.');                //<'+1.1.7

      ar := Ziks_ (12,fo,0,NJkinFA,0, '',0,0,0,0, r8,a8,rr,rr); //< 12=Zk1v johdon max.imped.    OK 6.2.2
   ad3SF (1, 'Re','=',fRmrkt0 (r8,1,d1)+ fOhm +'   '+fOik+'   Rs = '+fRmrkt0 (r8/3,1,d1)+ fOhm +' =Re/3');
   ad3SF (1, 'Xe','=',fRmrkt0 (a8,1,d1)+ fOhm +'   '+fOik+'   Xs = '+fRmrkt0 (a8/3,1,d1)+ fOhm +' =Xe/3');

      sa := fRmrkt0 (ar,1,d1)+ fOhm +'   '+fOik+'   Zs = '+fRmrkt0 (Sqrt (Sqr(r8/3)+Sqr(a8/3)),1,d1)+
                                                     fOhm +' = '+FONT_2JUURI +'[(Re/3)² + (Xe/3)²]';
      sa := sa +',   joista ko. johto-osan osuus :';
   ad3SF (1, 'Ze','=',sa);
                                                         //,ao-1 = ED. JOHTO_OSAN LOPPUUN koska lasketaan EROTUS.
     Ziks_ (11,fo,0,NJkinFA,0, '',0,0,0,0, rr,aa,r7,r7);  //< 11=Zk1v johdon loppuun.            OK 6.2.2
     rr := r8-rr;
     aa := a8-aa;
   ad3SF (1, 'Rk','=',fRmrkt0 (rr,1,d1)+ fOhm);
   ad3SF (1, 'Xk','=',fRmrkt0 (aa,1,d1)+ fOhm);
     ar := Sqrt (Sqr (rr) + Sqr (aa));
   ad3SF (1, 'Zk','=',fRmrkt0 (ar,1,d1)+ fOhm);             //<Korj +6.0.3 ,+
   ad1S_ (UPS_huom);                                        //<+6.0.3

 //if (Qkpl>2) and (Qtyp<>'SVjärjest.')  or  (Qtyp='SVjärjest.') and (SVsuhtL(Qmm2)>0.99999) then begin //< -6.0.2
   if (Qkpl>2) and NOT fOnSV (Qtyp)  or  fOnSV (Qtyp) and (SVsuhtL(Qtyp,Qmm2) > 0.99999)  then begin    //< +6.0.2
      ad1SF ('Laskettuna johto-osan loppuun:');
         ar := Ziks_ (11, ao,0,NJkinFA,0, '',0,0,0,0, r8,a8,rr,rr); //< 11 =Zk1v JohdnLoppuun
      ad3SF (1, 'Re','=',fRmrkt0 (r8,1,d1)+ fOhm +'   '+fOik+'   Rs = '+fRmrkt0 (r8/3,1,d1)+ fOhm +' =Re/3');
      ad3SF (1, 'Xe','=',fRmrkt0 (a8,1,d1)+ fOhm +'   '+fOik+'   Xs = '+fRmrkt0 (a8/3,1,d1)+ fOhm +' =Xe/3');
      ad3SF (1, 'Ze','=',fRmrkt0 (ar,1,d1)+ fOhm +'   '+fOik+'   Zs = '+fRmrkt0 (Sqrt (Sqr(r8/3)+Sqr(a8/3)),1,d1)+
                                                           fOhm +' = '+FONT_2JUURI +'[(Re/3)² + (Xe/3)²]');
   end;

sisVex; sisA;
   ad1S_ ('<b>Max.impedanssipisteen esiintymiskohta :</b>');
(*'''\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\'''*)
   Zs := fZs (12,fo,2,NJkinFA, '',0,0,0,0,  Rs,Xs,rinKer,Ls);  //< 2=PEker=EiHuomioid,EhkeiVäliä. Korj 6.2.2
sisB;                                                          //RINKER ''''''ei saa käyttää muuhun, ks. jäljempnä
   ad3SF (1, 'Lzmax','=',fRmrkt0 (Ls,1,1)+' m   = '+fRmrkt0 (Qpit-Ls,1,1)+' m lopusta  (johtopituus = '+
         fRmrkt0 (Qpit,1,1)+' m).');
         //,, Zmax/Z  =  [n*L/4(n-1)] / (L/n)  '+fOik+'  n² / [4(n-1)] <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   if Qkpl=1  then sa := '1'  else sa := fRmrkt0 (Sqr (Qkpl) / (4*(Qkpl-1)),1,3);
   sa := sa+ '= Suhdeluku, joka ilmaisee max.impedanssipisteen huomioivan laskentatavan vaikutuksen '+
             'koko johto-osapituuden mukaan laskettuun impedanssiin (z×Ljohto / kpl) verrattuna.';
   ad3SF (1, 'Zmax/Z','=',sa);
   ad3SF (1,'','','     Ratkaisuyhtälö:    Kun kpl '+FONT_SUURPI+' 2,   Zmax/Z  =  [kpl×L/4(kpl-1)] '+
         '/ (L/kpl)  =  n² / [4(n-1)],  muulloin  Zmax/Z = 1');
   ad3SF (1, 'Kzmax','=', fRmrkt0 (rinKer,1,3)+ '   Kun kpl '+FONT_SUURPI+' 2,   Kzmax = kpl / '+
             '(4 (kpl-1)),   muuten Kzmax = 1,   ks. Lzmax edellä.     = Kerroin, jolla saadaan yhden '+
             'johtopituuden arvoilla kokonaismax.impedanssikomponentit, esim. yhtRv = Rv × Kzmax × '+
             'Ljohto.');

   Ik1v := req.arvo [arvo_IK1V_1];
   Ik3v := req.arvo [arvo_IK3V_2];
(*,,,\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\,,,*)
   sa := '';
   if QKpe<1  then sa := COLOR_RED;                              //<Syötössä estetty <1, jos j-osa<2
   sa := sa +fDemRx (1,Ik1v,1,1)+ ' A   = cU×3×Uv/Ze   (Ze ks. edellä) MaxZ -pisteessä, kun PE-johtimen '+
         'osuus on huomioitu arvolla Kpe=' +fRmrkt0 (QKpe,1,3) +'.' +FNT_0;
   ad3SF (1, 'Ik1v','=',sa);
// if Qkpl>2  then begin
       //o := ifs_e (10,11); //<Sorc: 10=Zk1v kiskostossa  Edka: 11=Zk1v johdon lopussa, fo osoittaa OK.
         o := 11;
         ar := iks (Ik3vFA, fo, Ziks_ (o,fo,2,NJkinFA,0, '',0,0,0,0, rr,rr,rr,rr)); //< 2=PEohit ei huomioida. +6.2.2
      ad3SF (1, ''    ,'=',fDemRx (1,ar,  1,1)+ ' A,   kun Ze laskettu johto-osan loppuun (ilman PE-ohitusta).');
// end;
   LF;   //::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
   ad1S_ (UPS_huom);                                                                            //<+6.0.3
      o := ifs_e (10,11);    //<Sorc: 10=Zk1v kiskostossa  Edka: 11=Zk1v johdon lopussa, fo osoittaa OK.
      ar := Ziks (o,fo,NJkinFA,0, '',0,0,0,0, r8,a8,rr,rr);                                //<'Korj 6.2.2
      ar := Sqrt ( Sqr(r8+10) + Sqr (a8)) -10; //<Ziks, kun piiriin on lisätty 10 ohmin mittausresistanssi Rt
      rr := fIk1v (ar);
   ad3SF (1, COLOR_BLUE +'Ik1vm','=',fRmrkt0 (rr,1,1) +' A   = Asennustesterillä saatava Ik1v :n arvo <b>johdon '+
         'alusta</b> kiskostosta mitattuna</b> Ik1vm = ' +FONT_2JUURI +'{[Re+Rt]² + Xe²}  - Rt,   Rt on tässä '+
         '10 '+fOhm +', mutta sen tarkalla arvolla ei ole havaittavaa vaikutusta lopputulokseen tällä suuruusluokalla. '+
         'Mittausarvon <b>laskennallinen luotettavuus</b> riippuu Kpe :n luotettavuudesta.');
   ad3SF (1, '','','   Mikäli kyseessä on UPS-syöttö ja <b>laskettu arvo (Ik1vm) on suurempi kuin liittymän '+
         '(UPSin) Ik1v, mittarin pitäisi näyttää samaa kuin liittymän Ik1v</b> (vrt. UPSin '+
         'vakiovirtaominaisuus).</f>');

   //Tästä Rv...Ik1vo + PE:n ohittumisen laskentaperusteet siirretty alkuun yleiseen osaan
if fo>1  then begin //<,,####################### Vain Edka[] verkon osalle tokasta lähtien.######################
    //o := ifs_e (10,11); //<Sorc: 10=Zk1v johdn lopussa,  Edka: 11=Zk1v johdon lopussa, fo osoittaa OK.
      o := 11;
      a8 := iks (Ik3vFA, fo, Ziks (o,fo, NJkinFA,0, '',0,0,0,0, rr,rr,rr,rr));                    //< 6.0.2 ao-1

    //o := ifs_e (10,11); //<Sorc: 10=Zk1v johdn alussa,  Edka: 11=Zk1v johdon lopussa, fo osoittaa OK.
      o := 11;             //,   2=eiPEk, NJkin,....................................................
      i := fSul_Tot (o,suCse,fo, 2, NJkinFA,Qkul,Qtim, '',0,0,0,0);   //<MaxSulake (2)kiskoIk1v:n muk. 6.0.2 ao-1
   sa := fDemRx (1,a8,1,1)+ ' A   johdon lopussa ilman PEn ohitusta, sallisi MaxSul = ';
      sa := sa +fImrkt0 (i,1) +' A  ';
      if Pos ('OFA',UpperCase(suCse)) > 0  then sa := sa +'OFAA'
                                           else sa := sa +'IEC';
   ad3SF (1, '</b>(<b>Ik1v </b>','=',sa +').');

      ra := 0.7;  //<ra=PEkerroin <= 1.0
    //o := ifs_e (10,11); //<Sorc: 10=Zk1v johdn alussa,  Edka: 11=Zk1v johdon lopussa, fo osoittaa OK.
      o := 10;            //<###### JÄÄ VOIMAAN ####################################################
      ar := iks (Ik3vFA, fo, Ziks_ (o,fo, ra, NJkinFA,0, '',0,0,0,0, rr,rr,rr,rr));
      r8 := (ar/a8 -1) *100;
      j := fSul_Tot (o,suCse,fo,ra, FALSE,Qkul,Qtim, '',0,0,0,0);     //<MaxSulake (2)kiskoIk1v:n muk.
   sa := fDemRx (0,ar,1,1)+ ' A   Kpe = '+fRmrkt0(ra,1,1) +'   '+fOik+' ero Ik1v :hen = ' +fDemRx (0,r8,1,1) +
         '%,  MaxSul ';
      if j<>i  then  sa := sa +' '+fOik+' '+fImrkt0(j,1) +' A'
               else  sa := sa +' = ei muutu';
   ad3SF (1, '<b>Ik1vo</b>','=',sa);

      ra := 0.5;  //<ra=PEkerroin <= 1.0
      ar := iks (Ik3vFA, fo, Ziks_ (o,fo, ra, NJkinFA,0, '',0,0,0,0, rr,rr,rr,rr)); //< o,fo Edellisestä sijoituksesta
      r8 := (ar/a8 -1) *100;
      j := fSul_Tot (o,suCse,fo,ra, FALSE,Qkul,Qtim, '',0,0,0,0);     //<MaxSulake (2)kiskoIk1v:n muk.
   sa := fDemRx (0,ar,1,1)+ ' A   Kpe = '+fRmrkt0(ra,1,1) +'   '+fOik+' ero Ik1v :hen = ' +fDemRx (0,r8,1,1) +
         '%,  MaxSul ';
      if j<>i  then  sa := sa +' '+fOik+' '+fImrkt0(j,1) +' A'
               else  sa := sa +' = ei muutu';
   ad3SF (1, '<b>Ik1vo</b>','=',sa);

      ra := 0.3;  //<ra=PEkerroin <= 1.0
      ar := iks (Ik3vFA, fo, Ziks_ (o,fo, ra, NJkinFA,0, '',0,0,0,0, rr,rr,rr,rr));
      r8 := (ar/a8 -1) *100;
      j := fSul_Tot (o,suCse,fo,ra, FALSE,Qkul,Qtim, '',0,0,0,0);     //<MaxSulake (2)kiskoIk1v:n muk.
   sa := fDemRx (0,ar,1,1)+ ' A   Kpe = '+fRmrkt0(ra,1,1) +'   '+fOik+' ero Ik1v :hen = ' +fDemRx (0,r8,1,1) +
         '%,  MaxSul ';
      if j<>i  then  sa := sa +' '+fOik+' '+fImrkt0(j,1) +' A'
               else  sa := sa +' = ei muutu';
   ad3SF (1, '<b>Ik1vo</b>','=',sa);
   ad1SF ('Tarkempi kuvaus PE-johtimen ohituksen laskentamenetelmästä, ks. yleinen osa alussa ("<b>Edeltävän '+
          'verkon laskentaparametrit ja selitykset</b>"');
end;//if s_e>1

sisB;
   ad1SF ('<b>Ik3v:n minimi-impedanssipisteen tekijät :</b>'); //:::::::::::::::::::::::::::::::::::
   ad1SF ('Laskettuna ao. <u>johto-osan <b>ALUSSA</b></u> olevan jakokeskuksen tms. kiskostossa.');  //< 6.0.0 ALUSSA
   ad3SF (1, 'Ik3v  ','=', fRmrkt0 (Ik3v,1,1)+ ' A');
   ad1SF ('Kun kuluttajaverkossa on muuntaja :');
   ad3SF (1, 'Ik3v  ','=','Uv / '+FONT_2JUURI +'{[Ry+Rm+Rv] ² + [Xy+Xm+Xv] ²}   ja ilman muuntajaa :');
   ad3SF (1, 'Ik3v  ','=','Uv / '+FONT_2JUURI +'[(eRs+Rv) ² + (eXs+Xv) ²],   mihin tekijät on '+
                 'ratkaistu edeltävän verkon osalta 1-vaiheisen oikosulun liittymäarvoina syötetyistä '+
                 'impedanssikomponenteista yhtälöparilla:   '+FONT_2JUURI+'[2Rv+Rvo+3Rn]² + [3(Xv+Xn)]² = '+
                 FONT_2JUURI+'[3eRs]² + [3eXs]².   Kun oletetaan, että komponentit muodostuvat pääosin '+
                 'konsentrisen kaapelin komponenteista, Xn=0 ja olettaen edelleen, että Rn '+FONT_LIKIM +
                 ' 2Rv,   saadaan:   Rv = eRs/3  ja  Xv = eXs.  <b>VakiovirtaUPS-syötössä </b>verrataan '+
                 'liittymälle ilmoitettua ja tässä pisteessä laskettuja arvoja, joista ilmoitetaan pienempi '+
                 '<b>(ks. Ik1v :n vastaavat UPS-huomautukset).</b>');
if os=3  then begin
//WrNyt := true;                                     //<Koe.PAS/PRC WrKoeF :n ohjailuun ON/EI.
end;                                                 //<'12.0.0: +Sulkeet 12å11
      j := 40;                                               //, 30 => 40 =12.0.0 Tuskin eroa.##########################
                                            WrKoeF ('Det 0:   os=' +Ints(os) +' oh=' +Ints(j) +' fo=' +Ints(fo));
      a7 := Ziks (j ,fo,NJkinFA,0, '',0,0,0,0, r8,a8,rr,rr); //< 30=Ik3v johdn alussa.  6.0.0 ao-1 Korj 6.2.2
      AR := sys_ker (r8,a8); //<R,X .               //<AR :ssä nyt SYSKERR, jota käytetään jälempnä Ik3d :ssa
                                                    //'######################################################'
                                            WrKoeF ('Det 1:   Ik3v=' +fRmrkt0(Ik3v,1,2) +' R=' +fRmrkt0(r8,1,6) +
                                            ' X=' +fRmrkt0(a8,1,6) +' Sys_K=' +fRmrkt0(AR,1,6) +' Zt=' +fRmrkt0(a7,1,6));
      rr := 1;
      a8 := m_tasav (AR,rr);                        //<m_tasavKerroin = f(sysKerr,Aika). ARsys..arvo sij.aiemmin
                                            WrKoeF ('Det 2:   m_tasav=' +fRmrkt0(a8,1,6));
      r8 := Ik3v * Sqrt ((a8 +1)*rr);               //<r8= Ik3th = Ik3v × V¨[(m+n)×tim]. a8=m  1=n.
                                            WrKoeF ('Det 3:   Ik3th=' +fRmrkt0(r8,1,6) +'=Ik3v × V¨[(m+n)×tim].');
   ad3SF (1, 'Ik3th','=',fRmrkt0 (r8,1,2)+ ' A   = Terminen ekvivalenttinen 1 s :n 3v-oikosulkuvirta (<b>'+
             'kilpiarvo Icw</b>).   Ik3th = Ik3v × '+FONT_2JUURI+'[(m+n)×tim],     missä  m = tasavirta- ja n = '+
             'vaihtovirtakomponentti.   Aika (tim) -arvona käytetään 1 s (myös tasavirtatekijää m '+
             'laskettaessa, ks. seuraava).   Pienjännitekaapeliverkossa alkuoikosulkuvirta ei sanottavasti '+
             'poikkea jatkuvan tilan oikosulkuvirrasta, jolloin vaihtovirtatekijä n = 1.');
   ad3SF (1, '','','     Ik3th -arvosta voidaan redusoida tarvittaessa muita poiskytkentäaikoja (vrt. '+
             'sulakkeen toiminta, katkaisijan magneettinen ja/tai aika-asettelu) vastaava terminen arvo, '+
             'josta vanhoissa määräyksissä (A1/23§5) on sanottu, ettei alle 0.2 s :n arvoja saa käyttää. '+
             'Kaapeleiden tilanteiden mukaisia arvoja laskettaessa valmistajat yleensä ilmoittavat, ettei yli '+
             '5 s :n arvoja saa käyttää.   <b>Yksinkertaistettu redusointikaava   </b>Ik3th´ = Ik3th × '+
             FONT_2JUURI +'tim´, missä tim´ on uusi poiskytkentäaika.   Vertaamalla Ik3th :n kaavaan nähdään '+
             'redusointikaavasta, että oletetaan:  m = 0  ja  n = 1.');
   ad3SF (1, 'm','=',fRmrkt0 (a8,1,6) +',   m = {1 / [100 × tim × Ln('+FONT_KAPPA+'-1)]} × {exp [200 × tim ×'+
             ' Ln('+FONT_KAPPA +'-1)] -1},   missä tim on 1 s.');

      rr := AR * Sqrt (2) * Ik3v;           //< rr= Ik3d = € × V¨(2)×Ik3v, €=Kappa=SysKerr=AR.
                                            WrKoeF ('Det 4/4: sys_K*V¨(2)*Ik3v =Ik3d=' +fRmrkt0(AR,1,6) +'*' +
                                                    fRmrkt0(Sqrt(2),1,4) +'*' +fRmrkt0(Ik3v,1,2) +'=' +fRmrkt0(rr,1,2));
   ad3SF (1, 'Ik3d','=',fRmrkt0 (rr,1,2)+ ' A   = Sysäysoikosulkuvirta (dynaaminen, <b>kilpiarvo Ipk</b>)   '+
                        '= '+FONT_KAPPA +' × '+FONT_2JUURI+'2×Ik3v,     Ik3dMax = 2.83×Ik3v');
   ad3SF (1, FONT_KAPPA,'=',fRmrkt0 (AR,1,6)+ ' = Sysäyskerroin  = 1.022 + 0.969 × exp(-3.03R/X),   '+
         FONT_KAPPA+'max = 2.0');                                  //'AR NYT VAPAA #####################################
WrNyt := false;                                    //<Koe.PAS/PRC WrKoeF :n ohjailuun ON/EI.
   ad3SF (1,'','','// exp( ) = e potenssiin( ) //.');

if (s_e=2) and (ao>1)  then with req  do begin                                                 //<,,+6.2.0
      ad1SF ('<b>Edeltävän sulakkeen [' +IntToStr (f_) +'] vaikutus </b>termisiin ja dynaamisiin arvoihin:');

      sa := '';
      if ao>1  then begin                          //<,,j = Ed.johto-osan sulakeLkm vain tässä paikallisesti apuna.
         j := a_getIntg (10151,edv.edka[ao-1].lukumaara);
         if j=2  then
            j := 1;
         if j>2  then
            sa := 'á';
      end;
      a8 := arvo [arvo_IK3T_3];                    //<,,Nämä ovat 0 jos ei vaimentavaa vaikutusta sulakkeilla.
      r8 := arvo [arvo_IK3D_4];

      j := pyor (arvo [arvo_SUL_OIKOS_6]);         //<j nyt vapaa muuhun käyttöön, tieto siirretty SA:han.
      ar := arvoU[5];                                                       //<OFAAraj_Ith OikosSUL.
      if (ar>0) and (ar<a8)                        //<Vaim.arvo on ja se on pienempi kuin alkuper.Th
      then ad3SF (1, 'Ik3th','=',fRmrkt0 (ar,1,0) +' A, kun OikoSulkusuoja=' +sa +fImrkt0 (j, 1) +' A OFAA.')
      else if j=0
      then ad3SF (1, 'Ik3th','=','- - - - <t>Oikosulkusuojaa ei ole johdolle määriteltävissä.')
      else ad3SF (1, 'Ik3th','=','- - - - <t>Oikosulkusuoja ei vaimenna.');  //<VaimentunutArvo=Ik3th

      ar := arvoU[1];                                                       //<OFAAraj_Is OikosSUL.
      if (ar>0) and (ar<r8)                        //<Vaim.arvo on ja se on pienempi kuin alkuper.D
      then ad3SF (1, 'Ik3d ','=',fRmrkt0 (ar,1,0) +' A, kun OikoSulkusuoja=' +sa +fImrkt0 (j, 1) +' A OFAA.')
      else if j=0
      then ad3SF (1, 'Ik3d ','=','- - - - <t>Oikosulkusuojaa ei ole johdolle määriteltävissä.')
      else ad3SF (1, 'Ik3d ','=','- - - - <t>Oikosulkusuoja ei vaimenna.');   //<VaimentunutArvo=Ik3d

      j := a_getIntg (10151, req.OfaVal);
      ar := arvoU[4];                                                       //<OFAAraj_Ith OfaVal.
      if (ar>0) and (ar<a8)                        //<Vaim.arvo on ja se on pienempi kuin alkuper.Th
      then ad3SF (1, 'Ik3th','=',fRmrkt0 (ar,1,0) +' A, kun sulakkeeksi valittu=' +sa +fImrkt0 (j, 1) +' A OFAA.')
      else if j=0
      then ad3SF (1, 'Ik3th','=','- - - - <t>Sulaketta ei ole määritetty.')
      else ad3SF (1, 'Ik3th','=','- - - - <t>Valittu sulake ' +fImrkt0 (j, 1) +' A OFAA ei vaimenna.');

      ar := arvoU[3];                                                       //<OFAAraj_Is OfaVal.
      if (ar>0) and (ar<r8)                        //<Vaim.arvo on ja se on pienempi kuin alkuper.D
      then ad3SF (1, 'Ik3d ','=',fRmrkt0 (ar,1,0) +' A, kun sulakkeeksi valittu=' +sa +fImrkt0 (j, 1) +' A OFAA.')
      else if j=0
      then ad3SF (1, 'Ik3d ','=','- - - - <t>Sulaketta ei ole määritetty.')
      else ad3SF (1, 'Ik3d ','=','- - - - <t>Valittu sulake ' +fImrkt0 (j, 1) +' A OFAA ei vaimenna.');
   end;//if ao>1
//end;//if ai>0
   LF; //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//,,,,,,,,,,,,,,,,,Lasketaan edeltävien johtojen osuus jo tässä, vrt. IF RR>= TESTI ########################
   rr := 0; //<#############################################################################################
   for i := 1 to f_  do begin                     //<[ao] :sta oli sijoitettu Q.. -muuttujiin ######
      if s_e=1  then rec := edv.Sorc[i].josa      //<,+6.2.2  Rivit vaihtaneet paikkaa = +6.2.14
                else rec := edv.Edka[i];
              Btyp :=    a_getStrg (10154, rec.tyyppi);
              Bmm2 :=    a_getReaa (10155, rec.Amm2);
              Bpit :=    a_getReaa (10156, rec.pituus);
              Bkpl :=    a_getIntg (10157, rec.lukumaara);
              Blampot := a_getIntg (10158, rec.lampotila);
           r8 := res (Btyp,Bmm2)*Bpit/Bkpl;
        Rv := rTkorj (fAlCu (Btyp), r8, Blampot);
           r8 := resVo (Btyp,Bmm2)*Bpit/Bkpl;         //<,+6.0.2
        Rvo := rTkorj (fAlCu (Btyp), r8, Blampot);
           a8 := resP (Btyp,Bmm2)*Bpit/Bkpl;
        Rn := rTkorj (fPal  (Btyp), a8, Blampot);
        Xv := Xv_ind  (Btyp,Bmm2)*Bpit/Bkpl;
        Xo := Xv0_ind (Btyp,Bmm2)*Bpit/Bkpl;
        Xn := Xp_ind  (Btyp,Bmm2)*Bpit/Bkpl;
      rr := rr + Sqrt ( Sqr (2*Rv+Rvo+3*Rn) + Sqr (2*Xv+Xo+3*Xn) ); //<Summataan IMPEDANSSIt #######
   end;//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Vikan (os) johdon osuus MaxZ -kohtaan ################
     {   r8 := res (Qtyp,Qmm2)*Qpit;                      //< (Qpit)/Qkpl korvataan RINKER :lla ####
      Rv := rTkorj (fAlCu (Qtyp), r8, Qlampot);
         a8 := resP (Qtyp,Qmm2)*Qpit;                     //< (Qpit)/Qkpl korvataan RINKER :lla ####
      Rn := rTkorj (fPal  (Qtyp), a8, Qlampot);
      Xv := Xv_ind  (Qtyp,Qmm2)*Qpit;                     //< (Qpit)/Qkpl korvataan RINKER :lla ####
      Xo := Xv0_ind (Qtyp,Qmm2)*Qpit;                     //< (Qpit)/Qkpl korvataan RINKER :lla ####
      Xn := Xp_ind  (Qtyp,Qmm2)*Qpit;                     //< (Qpit)/Qkpl korvataan RINKER :lla ####
                                          //,,Summataan IMPEDANSSIt ################################
      rr := rr + Sqrt ( Sqr (3*(Rv+Rn)) + Sqr (2*Xv+Xo+3*Xn) ) * rinKer; //< *rinKer = MaxZ -kohtaan //-2.0.7}

         r8 := res (Qtyp,Qmm2)*Qpit/Qkpl;
      Rv := rTkorj (fAlCu (Qtyp), r8, Qlampot);
         r8 := resVo (Qtyp,Qmm2)*Qpit/Qkpl;      //<,+6.0.2
      Rvo := rTkorj (fAlCu (Qtyp), r8, Qlampot);
         a8 := resP (Qtyp,Qmm2)*Qpit/Qkpl;
      Rn := rTkorj (fPal  (Qtyp), a8, Qlampot);
      Xv := Xv_ind  (Qtyp,Qmm2)*Qpit/Qkpl;
      Xo := Xv0_ind (Qtyp,Qmm2)*Qpit/Qkpl;
      Xn := Xp_ind  (Qtyp,Qmm2)*Qpit/Qkpl;
                                          //,,Summataan IMPEDANSSIt ################################
      rr := rr + Sqrt ( Sqr (2*Rv+Rvo+3*Rn) + Sqr (2*Xv+Xo+3*Xn) );
//##########################################################################################################
if rr<=0  then GOTO 3;//####################################################################################
//##########################################################################################################
sisVex; sisVex; sisVex;
   adStF ('<b>Rinnakkaisliittymät jäykistävät myös liittymän jälkeistä verkkoa;</b> myös napaoikosulku '+
          'saa virtaa jokaisesta rinnakkaisliittymästä niiden ja jälkeisten johtojen impedanssien kautta. '+
          'Liittymäkohtaiset, johto-osuudet sisältävät impedanssit kytkeytyvät rinnakkain keskenään ja näiden '+
          'rinnakkaisimpedanssien kanssa summautuu sarjaan vikaantuneen liittymän jälkeinen johto-osa '+
          'kokonaisimpedanssiksi. Koska johto-osissa saattaa olla suoja- tai erotinlaitteita, <b>ei '+
          'suojausehtotarkasteluun voida huomioida Ik1v -laskennassa </b>tätä oikosulkuvirtaa kasvattavaa ja '+
          'siten suojausehtoja parantavaa ominaisuutta. Sen sijaan <b>kojeistojen lujuusvaatimuksiin '+
          'tarvittavissa Ik3v, Ik3t ja Ik3d -arvoissa ne on huomioitava.</b>  Sarjaan summautuvan johto-osan '+
          'impedanssin takia esim. kahden rinnakkaisen ja identtisen muuntajan tapauksessa oikosulkuvirrat '+
          'ovat hieman kaksinkertaista pienempiä.');
   adStF ('Esim:  Neljän rinnakkaisliittymän tapauksessa liittymän 01 kokonaisimpedanssi Zk saadaan:<br>   '+
          '1/Zk = 1/<u>Z</u>01 +(1 / {<u>Z</u>02 + 1/[1/<u>Z</u>03+1/<u>Z</u>04)]}');
        //'1/Zk = 1/Z01        +(1 / (Z02 + 1 /( 1/Z03+1/Z04 ))                                 //''+8.0.0
   LF;//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
   ad1SF ('<b>Ik1v laskettuna pelkistetyillä käsinlaskentamenetelmillä (Ik1v`) :</b>'); //::::::::::::::::::
   ad1SF ('Virhe = (Ik1v`/Ik1v -1)×100 [%], missä Ik1v` on Ik1v:n arvo pelkistetysti laskettuna :'+
         '     Ik1v` = cU×3×Uv/Zpelk.  Zpelk :n yhteisarvo on saatu laskemalla kunkin johto-osan '+
         'impedanssit aritmeettisesti yhteen.  Arvoissa on huomioitu kunkin johto-osan pituus ja '+
         'johtokohtaiset komponentit on jaettu rinnakkaiskaapeleiden lukumäärällä.');
        {sekä <b>tarkasteltavassa johto-osassa</b> sen '+
         'vaikutus MaxZ -pisteen määräytymiseen (kun kpl '+FONT_SUURPI+' 2,   Lzmax = kpl / '+
         '(4 (kpl-1))×Ljohto).');}
   ad1SF ('     Zpelk -arvossa ei ole huomioitu yläverkon eikä syöttävän muuntajan impedanssikomponentteja, '+
         'joten lähellä muuntajaa Ik1v` pitäisi olla todellista suurempi.');
   ad1SF ('     Mikäli virhearvo on '+CLR_REB +'positiivinen (Ik1v` todellista isompi), '+
         'on laskentamenetelmä vaarallinen'+FNT_B0 +', koska sen mukaan suojat toimivat riittävän nopeasti, '+
         'vaikkei näin todellisuudessa tapahdu.');
   ad1SF ('     Suurin virhetekijä yksinkertaistetuissa laskentamenetelmissä syntyy silloin, kun '+
         'rinnakkaiskaapeleita > 2, jolloin maksimimpedanssipiste siirtyy lähemmäksi alkupistettä. '+{, '+
         'vrt. edellä laskettu Lzmax -arvo. }'Virhe on sitä isompi, mitä useampi rinnakkaiskaapeli.');
//##########################################################################################################
//,,,,,,,,,,,,,,,,,,,RR>0 TULOSTUS VASTA TÄSSÄ, VRT. IF RR>0 TESTI EDELLÄ, muuten: ERROR: Divided by Zero ##
      ar := fIk1v (rr);
      a7 := fErrArv (Ik1v,ar);   a7 := f_0 (a7);                 //<Jottei -0.049999 tulostuisi -0.0

      sa := fDemRx (1,ar,1,1)+ ' A   '+fOik+'   virhe = ';
         if a7>0  then sa := sa +CLR_REB
                  else sa := sa +CLR_GRB;
      sa := sa +fRmrkt0 (a7 ,1,1)+'%'+FNT_B0 +'     Zpelk = '+fRmrkt0 (rr,1,d1) +FONT_OMEGA +
            '   <b>Zekv</b> mukaan.';
sisB;
   ad3SF (1, 'Ik1v`','=',sa);
   ad3SF (1, '','','<b>=ve1)   Zpelk</b> = '+FONT_2JUURI+'{[2Rv+Rvo+3Rn] ² + [2Xv+Xvo+3Xn)] ²},  '+
         'ao.°C,  vrt. Päävalinta / Impedanssit -valinnalla saatavat tiedot.');
   //,,,,,,,,,,,,,,,,,Lasketaan edeltävien johtojen osuus ##########################################
   j := 0;  //<Jos MUUTTUU, ei D1 tunne ao. poikkipintaa, eikä silloin voida laskea ollenkaan ######
   k := 0;  //<Jos MUUTTUU, ei D1 -selitystä ole [1]:ssä, mihin viitata ############################<Tätä ei enää
   rr := 0; //<#####################################################################################   '6.2.2:ssa
   for i := 1 to ao-1  do                          //<,,Lasketaan edeltävät johdot D1 :llä.
   with edv.edka[i]  do begin                      //   Ao. johto D1 :llä näiden jälkeen erikseen.
              Btyp :=    a_getStrg (10161,tyyppi);
              Bmm2 :=    a_getReaa (10162,Amm2);
              Bpit :=    a_getReaa (10163,pituus);
              Bkpl :=    a_getIntg (10164,lukumaara);
            //Blampot := a_getIntg (10165,lampotila);//,,,Kerroin 3 kompensoi Ik1v -yhtälnKertoimn 3
      ar := 3 * fZd1 (Btyp,Bmm2)*Bpit/Bkpl;               //<fZd1 = valmiiksi 2 x D1 :n taulukkoarvo
      if ar=0
      then begin          //<D1 EI tunne ao. poikkipintaa, eikä silloin voida laskea ollenkaan #####
         j := i;                  //<Merkiksi, ettei D1 tuntenut ###################################
         Break;  end              //'SelitysTARVE, jos j=0 #########################################
      else
         if i=1  then k := 1;     //<Merkiksi, että  D1 oliOK mahd.viitattavassa [1]:ssä ########### Ei käytetty
         if k<0  then ;           //'ViittausMAHIS, jos k=1 ########################################   '6.2.2:ssa
      rr := rr+ar;                //'Never used.
   end;//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Vikan (ao) johdon osuus MaxZ -kohtaan ################
if (j=0) or (ao=j)  then begin                      
         ar := fZd1 (Qtyp,Qmm2);                          //<fZd1 = valmiiksi 2 x D1 :n taulukkoarvo
       //rr := rr + 3 * ar *Qpit * rinKer;                //<,ErotettuBreakPointin takia =Näkyy fZd1 -6.2.2
         rr := rr + 3 * ar *Qpit /Qkpl;                   //< (Qpit)/Qkpl korvataan ################ +6.2.2
   if rr>0  then begin                     //'''''''LasRXs :n palauttama pituuskerroin #############
         ar := fIk1v (rr);
         a7 := fErrArv (Ik1v,ar);   a7 := f_0 (a7);              //<Jottei -0.049999 tulostuisi -0.0

         sa := fDemRx (1,ar,1,1)+ ' A   '+fOik+'   virhe = ';
            if a7>0  then sa := sa +CLR_REB
                     else sa := sa +CLR_GRB;
         sa := sa +fRmrkt0 (a7 ,1,1)+'%'+FNT_B0 +'     Zpelk = '+fRmrkt0 (rr,1,d1) +FONT_OMEGA +'   D1 mukaan.';
      ad3SF (1, 'Ik1v`','=',sa);
      ad3SF (1, '','','=<b>ve2)   Zpelk</b> = 3 × 2 × (=yht. 6x) julkaisun D1, taulukon 41.5 '+
            's.80 arvo,  80°C.  Kerroin 3 kompensoi virtayhtälön \5\ vastaavan kertoimen, kerroin 2 '+
            'huomioi PE/PEN-johtimen D1 :n esimerkin mukaan.');
   end
   else ad1SF ('D1 :n mukaista tulostusta ei voida tässä esittää, koska D1 ei tunne kaikkia käsiteltyjä '+
            'kaapelityyppejä ja poikkipintoja (vrt. esim. suurvirta- ja kiskojärjestelmät).');
end
else ad1SF ('D1 :n mukaista tulostusta ei voida tässä esittää, koska D1 ei tunne kaikkia käsiteltyjä '+
            'kaapelityyppejä ja poikkipintoja (vrt. esim. suurvirta- ja kiskojärjestelmät).');

   ad3SF (1,'','','Lisätietoa, <b>ks. yleinen selitysosa alussa / "Käsikirja D1 :n '+
                  'laskentamenetelmä".</b>');
if s_e=1  then GOTO 3;//< Ohitetaan Edka.###########################################################
   //,,,,,,,,,,,,,,,,,Lasketaan edeltävien johtojen osuus ##########################################
   rr := 0; //<#####################################################################################
   for i := 1 to ao-1  do
   with edv.edka[i]  do begin
              Btyp :=    a_getStrg (10171,tyyppi);
              Bmm2 :=    a_getReaa (10172,Amm2);
              Bpit :=    a_getReaa (10173,pituus);
              Bkpl :=    a_getIntg (10174,lukumaara);
              Blampot := a_getIntg (10175,lampotila);
           r8 := res (Btyp,Bmm2)*Bpit/Bkpl;
        Rv := rTkorj (fAlCu (Btyp), r8, Blampot);
       {   r8 := resVo (Btyp,Bmm2)*Bpit/Bkpl;      //<,+6.0.2
        Rvo := rTkorj (fAlCu (Btyp), r8, Blampot);
           a8 := resP (Btyp,Bmm2)*Bpit/Bkpl;
        Rn := rTkorj (fPal  (Btyp), a8, Blampot); //,,,Kerroin 3 kompensoi Ik1v -yhtälön kertoimen 3}
      rr := rr + (6{3}*Rv{+Rvo+3*Rn})*Qpit/Qkpl;  //<Summataan IMPEDANSSIt #########################
   end;//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Vikan (ao) johdon osuus MaxZ -kohtaan ################
    //rr := (3*Rv+Rvo+3*Rn)*Qpit * rinKer;                //< (Qpit)/Qkpl korvataan RINKER :lla ####
      rr :=  6*Rv*Qpit/Qkpl;                              //<'HUOMAA 6(3)* #########################

//##########################################################################################################
if rr<=0  then GOTO 3;//####################################################################################
//##########################################################################################################
      ar := fIk1v (rr);                                   //'HUOMAA 3 * ############################
      a7 := fErrArv (Ik1v,ar);   a7 := f_0 (a7);                 //<Jottei -0.049999 tulostuisi -0.0

      sa := fDemRx (1,ar,1,1)+ ' A   '+fOik+'   virhe = ';
         if a7>0  then sa := sa +CLR_REB
                  else sa := sa +CLR_GRB;
      sa := sa +fRmrkt0 (a7 ,1,1)+'%'+FNT_B0 +'     Zpelk = '+fRmrkt0 (rr,1,d1) +FONT_OMEGA +'   2Rv+Rvo+3Rn mukaan.';
   ad3SF (1, 'Ik1v`','=',sa);
 //ad3SF (1, '','','<b>=ve3)   Zpelk</b> = 2Rv+Rvo+3Rn =suoraan luettelotiedoista (ao.°C, ilman '+
   ad3SF (1, '','','<b>=ve3)   Zpelk</b> = 6Rv =suoraan luettelotiedoista (ao.°C, ilman '+
         'reaktansseja. Kerroin 6 (=3*Rv+3*Rn) kompensoi virtayhtälön \5\ kertoimen 3. Tässä impedanssina '+
         'on käytetty <b>pelkästään vaiheresistanssia</b>.');
//##########################################################################################################
3://########################################################################################################
//##########################################################################################################
(*'''\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\'''*)

   LF; //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
sisVex;
   ad1S_ ('<b>Sulakkeiden valintaan vaikuttavat tekijät :</b>'); //:::::::::::::::::::::::::::::::::
sisB;
      ar := req.arvo [arvo_SUL_MAX_5s_5]; //:= fSul_ZsIa (i,ai,..);  ' +fVas +'> OikS :EdvLaskSij26-INC//'Muutos1.1.2
      sa := fDemRx (1,ar,1,0)+' A   =Suojausehtojen (';                    //'''' = SÄL:n  SUL_MAX!!
      if Qkul
         then       sa := sa+'KULuttaja, valittu poiskytkentäaika '+fRmrkt0 (Qtim,1,1) +'s'
         else begin sa := sa+'SÄHKÖLAITOS, Isul > 63   '+fOik+'   Ik1v '+FONT_PIENPI+' 3.0×Isul, muuten '+
                          'Ik1v '+FONT_PIENPI+' 2.5×Isul   .:  Isul = Ik1v / ';
                    if ar>63  then sa := sa+'3.0 = '+fRmrkt0 (Ik1v/3,   1,1)
                              else sa := sa+'2.5 = '+fRmrkt0 (Ik1v/2.5, 1,1);  end;
      sa := sa+ ') sallima, SUURIN MAHDOLLINEN sulakekoko valitulla sulaketyypillä (' +suCse;
    //if Qiec  then sa := sa+ 'IEC'  else sa := sa +'OFAA';
      sa := sa+ ') niin, että suoja vielä laukeaa ';
      if Qkul  then  sa := sa+'valitussa poiskytkentäajassa'
               else  sa := sa+'nollausehdon mukaan';
   ad3SF (1, 'sehSu','=',sa+ '.   Tätä sulaketta pienennetään tarvittaessa niin, että jäljempänä '+
         'esitetty ZsIa -ehto täyttyy.');
   ad3SF (1, 'OikS','=',fDemRx (1, req.arvo [arvo_SUL_OIKOS_6],1,0)+//:=OikSuoj(Qtyp,Qmm2,Qkpl);
         ' A   =Johdon tyypin, rakenteen ja poikkipinnan sallima suurin sallittu oikosulkusuojasulake. '+
         'Kun rinnakkaisjohtoja >2, suoja on johto- (ja johdin)kohtainen.');
sisVex;
   QUn := Pyor(fUv);                          //<+12.0.04:  Oli Warn:  QUn may not have been initz. Tarkoitettiinkohan tässä Uv ???
   ad1S_ ('Määräysten SFS 6000-A1 / 413.1.3.3  s.53 mukaan  <b>Zs×Ia  saa olla KULUTTAJA-asennuksissa '+
         'enintään = Uo</b>, (Un='+fImrkt0 (QUn,1)+ ' '+fOik+' Uo='+fImrkt0 (fUo,1)+ ' V) :');
sisB;
      rr := req.arvo [arvo_SUL_MAX_5s_5];     //:= fSul_ZsIa (i,ai,..);  ' +fVas +'> OikS  :EdvLaskSij26-INC
      i := pyor (rr);
      if rr = 0  then ar := 0
                 else ar := Isnik (suCse,i,Qtim);                   //< i = Isul <<<<<<<<<<<<<<<<<<<
      r7 := Zs*ar;        //< =ZsIa    Zs =fZs -kutsusta (edellä) <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      sa := ' V   =  Zs '+fRmrkt0 (Zs,1,8) +fOhm+ ' × Ia '+fRmrkt0 (ar,1,1)+ ' A (sulakkeelle '+
            fDemRx (1,rr,1,0) +' A)   ';
      if r7 <= fUo
      then begin sa := sa+ FONT_PIENPI+' '+fImrkt0 (fUo,1)+ ' V,   joten sulake täyttää ehdon.';
                 if not Qkul  then sa := sa+ ' Koska kyseessä on SÄHKÖLAITOKSEN jakeluverkkoon kuuluva '+
                                       'johto-osa, ei määräyksen täyttymisellä olisikaan merkitystä.';  end
      else begin sa := sa+ '> ' +fImrkt0 (fUo,1)+ ' V,   joten sulaketta täytyy pienentää, KUNNES '+
                       'ehto täyttyy.';
                 if not Qkul  then sa := sa+ ' Koska kyseessä on SÄHKÖLAITOKSEN jakeluverkkoon kuuluva '+
                                         'johto-osa, ei määräyksen täyttymistä vaadita.';  end;
   ad3SF (1, 'ZsIa','=',fRmrkt0 (r7,1,1)+ sa);
   if (r7 > fUo) and Qkul  then
      ad3SF (1, 'zehSu','=',fRmrkt0 (req.arvo [arvo_SUL_MAX_5s_5],1,0)+ ' A   =Suurin sulakearvo, '+
            'joka täyttää poiskytkentäaikavaatimuksen sekä ZsIa -ehdon. <b>Tämä arvo on esitetty '+
            'rivillä <b>"Suojausehdot sallivat"</b> arvon sehSu :n sijasta.');
if ao=1  then begin
   ad3SF (1,'','','     ZsIa -ehto vaikuttaa harvoin max.sulakearvon määräytymiseen kuluttajaverkossa. '+
         'Milloin asennusolosuhteet ovat poikkeuksellisen hyvät ja sen mukainen KORJAUSKERROIN kasvaa '+
         'merkittävän suureksi SEKÄ verkko on heikko, saattaa Ia :n arvo nousta normaaliolosuhteita '+
         'suuremmalla ylivirtasuojalla isommaksi kuin ZsIa -ehto sallii, jolloin suojaa pienennettäessa '+
         'johdon ja sen asennusolosuhteita vastaava kapasiteetti jää kaapelin sallimaa pienemmäksi.<br>');
   ad3SF (1, '','','     Yhteismitallistamalla Ze jakamalla se kolmella, merkitsemällä sitäkin Zs :llä '+
          'ja ratkaisemalla ZsIa -lauseke virran suhteen (Ik = Uo/Zs) ja vertaamalla sitä Ik1v :n '+
          'yhtälöön (Ik = cU×Uv/Zs), saadaan epäyhtälö:   Uo / Zs  >  cU×Uv/Ze.   Koska Zs = Ze  '+
          fOik+'  Uo > cU×Uv.     Kun Un = 400 V,  Uv = 230.94 V ja Uo = 230 V,  saadaan:   230 > '+
          '0.95×230.94  '+fOik+'  230 > 219.393, joten koska sulake valitaan aina siten, että Ia on '+
          'korkeintaan Ik1v, ei normaalisti koskaan jouduta pienentämään suojaa tämän ehdon takia.');
   ad3SF (1, '','','     <b>Ainoa tilanne, milloin ehto on määräävä syntyy, kun kertoimen cU :n arvoa '+
         'kasvatetaan</b>, tässä tapauksessa esim. 1.049 :ksi tai isommaksi (jolloin epäyhtälön molemmat '+
         'puolet tulevat saman suuruisiksi), mitä standardit eivät vielä hyväksy.   Tarkassa verkon '+
         'mitoituksessa tälläkin on merkitystä:  mm. haja-asutusalueen pitkiä linjoja mitoitettaessa '+
         'on välttämätöntä huomioida muuntajan käämikytkimen asento, jotta laskennallinen lopputulos '+
         'vastaisi mahdollisimman tarkasti todellisuutta.  Standardin muutosehdotus onkin tehty '+
         '(CENELEC) ja siinä cU -kertoimen lisäksi tulisi toinen kerroin cM, joka ottaisi em. tekijän '+
         'huomioon, jolloin ZsIa-ehto karsisi kohtuuttomuudet.');
end else
   ad3SF (1,'','','     '+lisatietoJ1);
   LF; //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
(*,,,\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\,,,*)
sisVex;
   ad1S_ ('Ylivirtasuojasulakkeen määrittämiseen vaikuttavat tekijät :');
sisB;
   ad3SF (1, 'Kas ','=','Annettu korjauskerroin');{, jossa on huomioitu edellä kuvatun lämpötilan, '+
         'rinnakkaiskaapelien asennusvälien ja kerrostamisen perusoletuksen (ks. edellä "Johto-osan '+
         'tiedot" alussa) korjaus');}                                                               //<'-10.0.1
   ad3SF (1, 'Ksu ','=','Sulaketyypistä ja kokoluokasta määräytyvä kerroin (0.6 ... 0.906). Tyyppinä '+
         'yleensä Gg,  '+FONT_PIENPI+' 25 A :lla tyyppinä D (Diazed)');
  {ad3SF (1, 'Krin','=','Rinnakkaisten kaapeleiden ryhmäasennuksesta aiheutuva kerroin A2-94/52-E1, '+
         's.235 mukaan');                                                                           <''-10.0.1}
   ad3SF (1, 'Kyht','=','Kokonaiskerroin = Kas × Ksu'{ × Krin'});
   LF; //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
                                                        //,,AR palauttaa asetusarvon ###############
      sa := YvSuo (1,1, {'G'}suCse,FALSE,FALSE,'A',Qkorj,Qtyp,Qmm2,Qkpl,ar);//<Dem(1),Eritt(1),EI(YhteisSuoja),EI(Katkais)
   ad3SF (1,'asA','=',fDemRx (1,ar,1,0) +' A   ' +fVas +'  '+ sa);
      sa := YvSuo (1,1, {'G'}suCse,FALSE,FALSE,'C',Qkorj,Qtyp,Qmm2,Qkpl,ar);//<Dem(1),Eritt(1),EI(YhteisSuoja),EI(Katkais)
   ad3SF (1,'asC','=',fRmrkt0 (ar,1,0) +' A   ' +fVas +'  '+ sa);
      sa := YvSuo (0,1, {'G'}suCse,FALSE,FALSE,'D',Qkorj,Qtyp,Qmm2,Qkpl,ar);//<Dem(1),Eritt(1),EI(YhteisSuoja),EI(Katkais)
   ad3SF (1,'asD','=',fRmrkt0 (ar,1,0) +' A   ' +fVas +'  '+ sa);
// LF; //::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::://-10.0.1
9:
end;//ediJohtoDet
//===============================================================================================================
//===============================================================================================================
procedure ediSj (ao :integer);      VAR Rm,Rmo,Xm,Xmo, Ry,Xy,ar,rr,r2,x2,r3,{x3,}Ik3v :real;
                                        Sm,tr,etr, fo :integer;   {mAlCu :boolean;  }sa :string;      begin
      fo := ao;                     //<Säilyttää etumerkin +/-
      ao := Abs (ao);
    //adSt_ (Pisteviiva ('Suurjänniteliittyjän liittymätiedot :'));
      adStF ('<b><u>N:o 0' +IntToStr (ao) +' Suurjänniteliittymä :</u></b>');
      Ry := a_getReaa (10101,Edv.Sorc[ao].src.yvRs);
      Xy := a_getReaa (10102,Edv.Sorc[ao].src.yvXs);
sisB; ad3SF (1, 'Ry', '=',fRmrkt0 (Ry,1,d1)+fOhm);
      ad3S_ (1, 'Xy', '=',fRmrkt0 (Xy,1,d1)+fOhm);
         asMparamEdv_Ik1v (ao, Rm,Rmo, Xm,Xmo);              //<Valittu tyyppi      +3.0.0
         tr := a_getIntg (10103,Edv.Sorc[ao].src.TrfTyp);   //<Valittu tyyppi (=tr) +3.0.0
         Sm := a_getIntg (10104,Edv.Sorc[ao].src.Smn);
        {mAlCu := fTrAlCu (tr,1*Sm);               //<+3.0.0
         r20 := rTaT20 (mAlCu,Rm, 75);        //<Korjataan T=75°:ssa ollut R 20°C :een ###### +2.0.5
         r20o:= rTaT20 (mAlCu,Rm, 75);        //<Korjataan T=75°:ssa ollut R 20°C :een ###### +2.0.5  <'-6.0.4}
sisA; //sisVex;  //<sisA :han
      sa := '';                                                                         //<,, +6.0.0
      if tr>10  then begin
         sa := '(-93)';
         tr := tr -10;  end;
      sa := 'Muuntaja: '+fImrkt0 (Sm,1)+' kVA (<b>häviösarja ' +fImrkt0 (tr,1) +'</b> (' +fRmrkt0 (fUn_Umn,1,0) +
            ' V)' +sa;                                                                //fUn_' +6.0.4
      if tr=8  then sa := sa +' = maxIk3v'  else
      if tr=9  then sa := sa +' = minIk1v';

      sa := sa +'), jonka impedanssikomponentit :';
      ad1S_ (sa);
    //if mAlCu  then sa := 'al'  else sa := 'cu';
{sisB;ad3SF (1, 'Rm ','=',fRmrkt0 (Rm ,1,d1)+ fOhm+'  (75°C,   Rm  20°C '+sa+' = '+fRmrkt0 (r20 ,1,d1)+ fOhm+ ')');
      ad3SF (1, 'Rmo','=',fRmrkt0 (Rmo,1,d1)+ fOhm+'  (75°C,   Rmo20°C ' +sa+' = '+fRmrkt0 (r20o,1,d1)+ fOhm+ ')');}
sisB; ad3SF (1, 'Rm ','=',fRmrkt0 (Rm ,1,d1)+ fOhm+'  (75°C)');
      ad3SF (1, 'Rmo','=',fRmrkt0 (Rmo,1,d1)+ fOhm+'  (75°C)');
      ad3SF (1, 'Xm ','=',fRmrkt0 (Xm ,1,d1)+ fOhm);
      ad3SF (1, 'Xmo','=',fRmrkt0 (Xmo,1,d1)+ fOhm+',  joista laskettu <b>muuntajan navoissa</b> (R75°C) :');
         r3 := Ziks (10,fo,NJkinFA,0, '',0,0,0,0, r2,x2,rr,rr); //<10=Ik1v Muuntajan navoissa. Korj 6.2.2
         ar := iks (Ik3vFA, fo, r3);
      ad3SF (1, 'Re ','=',fRmrkt0 (r2 ,1,d1)+ fOhm +'   = 2Ry+2Rm+Rmo  '+fOik+'  1/3 = '+fRmrkt0 (r2/3 ,1,d1)+' = Rs');
      ad3SF (1, 'Xe ','=',fRmrkt0 (x2 ,1,d1)+ fOhm +'   = 2Xy+2Xm+Xmo  '+fOik+'  1/3 = '+fRmrkt0 (x2/3 ,1,d1)+' = Xs');
      ad3SF (1, 'Ze ','=',fRmrkt0 (r3 ,1,d1)+ fOhm +'   = '+
                                      FONT_2JUURI+'(Rs ² + Xs ²)  '+fOik+'  1/3 = '+fRmrkt0 (r3/3 ,1,d1)+' = Zs');
      ad3SF (1, 'Ik1v ','=',fRmrkt0 (ar,1,1)+ ' A   = cU×3×Uv / Zs,   Zs = '+
                                      FONT_2JUURI+'{[2Ry+2Rm+Rmo] ² + [2Xy+2Xm+Xmo] ²}');
         Ik3v := Edv.Sorc[ao].josa.arvo [arvo_IK3V_2];
      ad3SF (1, 'Ik3v ','=',fRmrkt0 (Ik3v ,1,1) +' A   = Uv / '+FONT_2JUURI +'{[Ry+Rm] ² + [Xy+Xm] ²}');
      ad3SF (1, 'Ik3th','=',fRmrkt0 (Edv.Sorc[ao].josa.arvo [arvo_IK3T_3] ,1,1) +' A '+
                            ' (terminen)  = Ik3v × '+FONT_2JUURI+'[(m+n)×tim]');
         Ziks (30,fo,NJkinFA,0, '',0,0,0,0, r2,x2,rr,rr); //< 30=Ik3v johdn alussa, mukana Zy + Zmuuntaja.  6.2.2
         ar := sys_ker (r2,x2);                     //<AR :ssä nyt SYSKERR, jota käytetään jälempnä Ik3d +th :ssa
         rr := 1;
         x2 := m_tasav (ar,rr);                     //<m_tasavKerroin = f(sysKerr,Aika). ARsys..arvo sij.aiemmin
      ad3SF (1, 'm','=',fRmrkt0 (x2,1,5) +'   = DC-komponentti = {1 / [100 × tim × Ln('+FONT_KAPPA+'-1)]} × '+
                        '{exp [200 × tim × Ln('+FONT_KAPPA +'-1)] -1},   missä Tim on 1 s.');
      ad3SF (1, 'n','=','1   = AC-komponentti, tarkemmin ks. johto-osatiedot.');
      ad3SF (1, FONT_KAPPA,'=',fRmrkt0 (ar,1,6)+ ' = Sysäyskerroin  = 1.022 + 0.969 × exp(-3.03R/X),   '+
            FONT_KAPPA+'max = 2.0,  Zy huomioitu.');
      ad3SF (1,'','','// exp( ) = e potenssiin( ) //.');
      ad3SF (1, 'Ik3d ','=',fRmrkt0 (Edv.Sorc[ao].josa.arvo [arvo_IK3D_4] ,1,1) +' A '+
                            ' (dynaaminen)  = '+FONT_KAPPA +' '+FONT_2JUURI+'2 *Ik3v');
sisVex;//<sisA :han
         etr := tr;  //r3 := Rm;  x3 := Xm;      //<Talteen valitun tyypin Zk3v arvot ennen kuin muuttuvat. 6.2.2
         asMparam_ (Sm,8,75, Rm,Rmo,Xm,Xmo, tr); //< 8=MinZ. 75 +6.0.4
if etr=tr
then  ad1SF ('Valittu muuntajatyyppi on <b>isoimman Ik3v virran antavaa tyyppiä.</b>')
else begin                                       //<Valittu muuntajatyyppi ei olllut max.Ik3v:n antava.
      LF;//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        {mAlCu := fTrAlCu (tr,1*Sm);              //<+3.0.0
         if mAlCu  then sa := 'al'  else sa := 'cu';}
      ad1SF ('<b>Isoimman virran antavalla muuntajatyypillä:</b>');
      ad1SF ('Zy kuten edellä.');
      ad1S_ ('Muuntaja: '+fImrkt0 (Sm,1)+' kVA  <b>häviösarja ' +fImrkt0 (tr,1) +'</b> (' +fRmrkt0 (fUn_Umn,1,0) +
            ' V), jonka impedanssikomponentit:');                                          //fUn_' +6.0.4
{sisB;ad3SF (1, 'Rm ','=',fRmrkt0 (Rm ,1,d1)+ fOhm+'  (75°C,   Rm20°C '+sa+' = '+fRmrkt0 (r20 ,1,d1)+ fOhm+ ')');
      ad3SF (1, 'Xm ','=',fRmrkt0 (Xm ,1,d1)+ fOhm+',  joista laskettu <b>muuntajan navoissa</b> (Rm20°C) :'); -6.0.4}
sisB; ad3SF (1, 'Rm ','=',fRmrkt0 (Rm ,1,d1)+ fOhm+'  (75°C)');
      ad3SF (1, 'Rmo','=',fRmrkt0 (Rmo,1,d1)+ fOhm+'  (75°C)');
      ad3SF (1, 'Xm ','=',fRmrkt0 (Xm ,1,d1)+ fOhm);
      ad3SF (1, 'Xmo','=',fRmrkt0 (Xmo,1,d1)+ fOhm+',  joista laskettu <b>muuntajan navoissa</b> (R75°C) :');
   //##########################################,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,6.2.2
   a_putIntg (10103,tr, Edv.Sorc[ao].src.TrfTyp);       //<Sijoitetaan VÄLIAIKAISESTI helpomman laskennan takia.
   //##########################################''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
         ar := iks (Ik3vFA,fo,Ziks (10,fo,NJkinFA,0, '',0,0,0,0, rr,rr,rr,rr)); //<10,=Ik1v Muuntajan navoissa.
      ad3SF (1, 'Ik1v ','=',fRmrkt0 (ar, 1,1)+ ' A');
         ar := iks (Ik3vTR,fo,Ziks (30,fo,NJkinFA,0, '',0,0,0,0, r2,x2,rr,rr)); //<30,=Ik3v Muuntajan navoissa.
      ad3SF (1, 'Ik3v ','=',fRmrkt0 (ar, 1,1)+ ' A');         //'' ''=Sysäyskertoimen ja AC-kompon. laskentaan.
         ar := iks (Ik3vTR,fo,Ziks (40,fo,NJkinFA,1, '',0,0,0,0, rr,rr,rr,rr)); //<40,=Ik3t(1s) Muuntajan navoissa.
      ad3SF (1, 'Ik3th','=',fRmrkt0 (ar, 1,1)+ ' A');         //'< 1=Tim
         ar := iks (Ik3vTR,fo,Ziks (50,fo,NJkinFA,0, '',0,0,0,0, rr,rr,rr,rr)); //<50,=Ik3d Muuntajan navoissa.
      ad3SF (1, 'Ik3d ','=',fRmrkt0 (ar, 1,1)+ ' A');
         ar := sys_ker (r2,x2);                     //<AR :ssä nyt SYSKERR, jota käytetään jälempnä Ik3d +th :ssa
         rr := 1;
         x2 := m_tasav (ar,rr);                     //<m_tasavKerroin = f(sysKerr,Aika). ARsys..arvo sij.aiemmin
      ad3SF (1, 'm','=',fRmrkt0 (x2,1,5) +'   = DC-komponentti,   n = AC-komponentti = 1.');
      ad3SF (1, FONT_KAPPA,'=',fRmrkt0 (ar,1,6)+ ' = Sysäyskerroin,  Zy huomioitu.');

      {--Y.o. korvattu: ,,,,,,,,Näin laskettuna antaa KAIKKIEN ARVOJEN OSALTA TÄSMÄLLEEN SAMAT ARVOT KUIN EDELLÄ.
         Ziks (30,fo,NJkinFA,0, '',0,0,0,0, r2,x2,rr,rr); //<30,=Ik3v Muuntajan navoissa.      Korj 6.2.2
         r2 := r2-r3+Rm;   x2 := x2-x3+Xm;                //<Vähennetään alp. muuntajan arvot ja lisätään uuden.
         ar := Sqrt( Sqr(r2)+Sqr(x2) );                   //< ar=Zk3v
         Ik3v := iks (Ik3vTR, ar);
      ad3SF (1, 'Ik3v ','=',fRmrkt0 (Ik3v, 1,1)+ ' A');
         r2 := sys_ker (r2,x2);                           //<R2=sys.kerroin.
         x2 := m_tasav (r2,1);                            //<X2=m_tasavKerroin = f(sysKerr,Aika).
         ar := Ik3v *Sqrt (x2 +1);                        //<Vaihtovirtakompon.=1
      ad3SF (1, 'Ik3th','=',fRmrkt0 (ar,1,1) +' A');
         ar := Ik3v *Sqrt(2) *r2;
      ad3SF (1, 'Ik3d ','=',fRmrkt0 (ar,1,1) +' A');--}
   {--ad3SF (1, 'Ik3v','=',fRmrkt0 (fUv/Sqrt( Sqr(r20)+Sqr(Xm) ),1,1)+' Häv.Srj 1 ?????');
      ''Kokeilu, antaako saman arvon kuin iks ():  Antaa, TODETTU--}
   //###########################################,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   a_putIntg (10103,etr, Edv.Sorc[ao].src.TrfTyp);        //<Sijoitetaan ALKUPERÄINEN TAKAISIN.
   //###########################################''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''6.2.2
   {     ar := iks (Ik3vFA, (Ziks (10,fo,NJkinFA,0, '',0,0,0,0, rr,rr,rr,rr))); //<10,=Ik1v Muuntajan navoissa.
      ad3SF (1, 'Ik1v ','=',fRmrkt0 (ar, 1,1)+ ' A = p.o. ALP.???'); //<'Tarkistus, että muuttui takaisin ALP:ksi.}
end;//is etr=tr else

      LF;//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      ad3SF (1, '<b>Johto pääkeskukseen:</b>','','');
      ediJohtoDet (fo);
    //ad1SF (ediJohto (edv.Sorc[ao].josa, tab1));
end;//ediSj
//..................................................................................................
procedure ediGen (ao :integer);      VAR fo :integer;      begin
      fo := ao;                     //<Säilyttää etumerkin +/-
      ao := Abs (ao);
      adSt_ ('<b><u>N:o 0' +IntToStr (ao) +' Generaattori :</u></b>');
sisB; ad3SF (1, 'Sgn',   '=',fMrktRaj (edv.Sorc[ao].src.gSn)  +' kVA');
      ad3SF (1, 'kXd',   '=',fMrktRaj (edv.Sorc[ao].src.gXd)  +'<t> = Jatkuvan tilan suhteellinen oikosulkureaktanssi');
      ad3SF (1, 'kXd''', '=',fMrktRaj (edv.Sorc[ao].src.gXd1) +'<t> = Muutostilan suhteellinen oikosulkureaktanssi');
      ad3SF (1, 'kXd"',  '=',fMrktRaj (edv.Sorc[ao].src.gXd2) +'<t> = Alkutilan suhteellinen oikosulkureaktanssi');
     {ad3SF (1, 'kX2',   '=',fMrktRaj (edv.Sorc[ao].src.gX2)  +'<t> = Suhteellinen vastaoikosulkureaktanssin');
      ad3SF (1, 'kX0',   '=',fMrktRaj (edv.Sorc[ao].src.gX0)  +'<t> = Suhteellinen nollaoikosulkureaktanssi');}
      ad3SF (1, 'Rgs',   '=',fMrktRaj (edv.Sorc[ao].src.gRs)  +'<t> = Staattorin resistanssi (22°C)');
      ad3SF (1, 'T''',   '=',fMrktRaj (edv.Sorc[ao].src.gTd1)  +'<t> = Alkutilan suhteellinen oikosulkureaktanssi');
      ad3SF (1, 'T"',    '=',fMrktRaj (edv.Sorc[ao].src.gTd2)  +'<t> = Alkutilan suhteellinen oikosulkureaktanssi');
      ad3SF (1, 'tIkMin','=',fMrktRaj (edv.Sorc[ao].src.gtIkMin) +'<t> = Aika, missä Ik saavuttaa miniminsä');
      ad3SF (1,'tIkSust','=',fMrktRaj (edv.Sorc[ao].src.gtIkSust)+'<t> = Aika, missä Ik saavuttaa jatkuvuusarvonsa');
      ad3SF (1,'gIkSust','=',fMrktRaj (edv.Sorc[ao].src.gIkSust) +'<t> = Jatkuvan (sustaun) tilan Ik');
      ad3SF (1, 'gK1vSust','=',fMrktRaj (edv.Sorc[ao].src.gK1vSust)  +'<t> = Kerroin, jolla Ik1v = Ik3v*gK1vSust');
      ad3SF (1, '<b>Johto pääkeskukseen:</b>','','');
      ediJohtoDet (fo);
    //ad1SF (ediJohto (edv.Sorc[ao].josa, tab1));
end;//ediGen
//..................................................................................................
procedure ediUPS (ao :integer);      VAR fo :integer;      begin
      fo := ao;                     //<Säilyttää etumerkin +/-
      ao := Abs (ao);
      adSt_ ('<b><u>N:o 0' +IntToStr (ao) +' UPS-syöttö :</u></b>');
sisB;{ad3SF (1, 'Sun',  '=',fMrktRaj (edv.Sorc[ao].src.gSn)   +' kVA');                                                  //<Oli: gSn)  141.1: Ik}
      ad3SF (1, 'Ik1v', '=',fMrktRaj (edv.Sorc[ao].src.Ups_Ik1v) +'<t> = 1v -oikosulkuvirran syöttökyky halutulla ajalla'); //<Oli: gXd  141.1=Iks1v=>Ups_Ik1v
      ad3SF (1, 'Ik3v', '=',fMrktRaj (edv.Sorc[ao].src.Ups_Ik3v) +'<t> = 3v -oikosulkuvirran syöttökyky halutulla ajalla'); //<Oli: gXd1 - " -..
      ad3SF (1, 'Cos' +FONT_FII,'=',fMrktRaj (edv.Sorc[ao].src.Ups_Cos) +'<t> = oikosulkuvirran tehokerroin');              //<+141.1
      ad3SF (1, '<b>Johto pääkeskukseen:</b>','','');
      ediJohtoDet (fo);
    //ad1SF (ediJohto (edv.Sorc[ao].josa, tab1));
end;//ediUPS

