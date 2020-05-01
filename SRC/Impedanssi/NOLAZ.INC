(*############################################################### NOLAz.INC*)
{-----------------
FUNCTION demoX (tab,des :Integer) :Boolean;           VAR i :Integer;   BEGIN
   demoX := FALSE;   IF Demö  THEN BEGIN  demoX := TRUE;
   FOR i := 1 TO tab-des-2 DO WRITE (' ');   WRITE ('x.');       (*X.xxDemo*)
   FOR i := 1 TO des-4     DO WRITE ('x');   WRITE ('demo');  END;  END;
------------------}
//==================================================================================================
function R_u :integer;      begin  result := R_n;  end; //<Kokeilua: R_c -> R_n:ksi ei vaikuta, OK (kuten odotus)

FUNCTION fZekv_info1 (eioo :Boolean) :String;      VAR S:String;   BEGIN  S := '';
 {IF eioo  THEN }S := '* = Valmistus lopetettu.   ';
  S := S + 'Max.impedanssin määrittäminen, ks. Päävalinta/Verkkolaskenta/Detaljit.   '+
           {COLOR_RED}CLR_REB +'Kun  D1err[%]  on negat.(<0%), on arvo VAARALLINEN.' +{FNT_0}FNT_B0;
  result := S;  END;
FUNCTION fDimOts :string;      begin  result := '<center>rxz[?] ';  end;
{FUNCTION fmH (L :Real) :String;        VAR S:String;      BEGIN -6.0.2
  {IF L<100  THEN s := FONT_MYY  else s := 'm';
   s := s +'H';   result := s;  END;}
FUNCTION fmH (Indukt :Real) :String;        VAR S:String;      BEGIN //+6.0.2
   IF Indukt<0.001  THEN s := FONT_MYY
                    ELSE s := 'm';
   s := '['+ s +'H]';   result := s;  END;
FUNCTION fDimens (L :Real) :String;        VAR S:String;      BEGIN
   S := S +'[';
   IF L<100  THEN S := S+'m';   S := S +FONT_OMEGA+']';
   result := s;  END;

(*FUNCTION fZekv_info2 (L,T :Real) :String;        VAR S:String;   BEGIN
   S := fDimens (L) +'  L = ' +fRmrkt_(L,1,1) +'m,' +
           '          T= ' +IntToStr(Trunc(T+0.5)) +'°C  Rv(ac),Rvo(ac),Rn(dc),' +
          {'          Zv+n = '' Zs'',         Zn = '' Zpe'',' +}
           '          Zn = Zpe,' +
           '          Zekv = '+FONT_2JUURI+'{ [ 2Rv+Rvo+3Rn ] ²  + [ 2Xv+Xvo+3Xn ] ² }  / 3,' +
           '     ( Ik1v = c Uv / Zekv ),'+
           '     Re/Xe = (2Rv+Rvo+3Rn)/(2Xv+Xo+3Xn) ';
   result := S;  END;*)
FUNCTION fZekv_info2 :String;        VAR S:String;   BEGIN
   S :=//'Rv(ac),Rvo(ac),Rn(dc),' +
        {'     Zv+n = '' Zs'',     Zn = '' Zpe'',' +}
        {'     }'<b>Zn = Zpe =</b> '+FONT_2JUURI +'(Rn²+Xn²),   '+
         '<b>Zk3v = Z1 =</b>'+FONT_2JUURI+'[(Rm+Rv) ²+(Xm+Xv) ²] ,    <b>Ik3v = </b>Uv/Z1 ,'+
         '    <b>Zk1v = Ze = </b>'+FONT_2JUURI +'{[(2Rm+Rmo +2Rv+Rvo+3Rn)] ² + [2Xm+Xmo +2Xv+Xvo+3Xn] ²} ,'+
         '    <b>Ik1v = </b>3 c Uv / Ze .';
   result := S;  end;

FUNCTION fZkaap_info3 :String;      BEGIN  result := 'Tuetut tyypit:     AMCMK,  AXCMK, AXMK,  '+
   'AMMK*,  APAKM*,  MMJ/MMK*,  MCMK,  Kis(kot)Abb,  SVjärjest (SVsyst3½AL-SVsyst5Cu),  PLKVJ*,     AMKA,  '+
   'AVOJOHal,  AVOJOHcu';  end;
FUNCTION fZkaap_info4 :String;      BEGIN  result := 'Samapoikkipintaisten tulostuksessa <b>suurimmat '+
   CLR_GRB +'(ja pienimmät) '+FNT_B0 +'impedanssikomponentit esitetty lihavoituna</b> (poislukien AMKA, '+
   'AVOJOHal ja  AVOJOHcu).';  end;
//==================================================================================================
(*£a Vex >1.1.1
procedure asetaFrm (i :Integer);      begin  with ZS_Frm  do begin
  //Z_StrGrid.DefaultRowHeight :=15;  //< Tällä kokeiltu, OK = Jää Object Inspectorin asettamaksi
  ZS_StrGrid.RowCount := i +2;        //< +2=Välit ZS_sel varten
  // Height := ZS_StrGrid.DefaultRowHeight * ZS_StrGrid.RowCount  +45 +33 +43;
  Height := ZS_StrGrid.GetMaxHeight +45 +33 +43 +10{vara/isot fonti};
end; end; //''Tulostuslomakkeen koko'':   45=InfPan..=Inforivit,  33=LaskPan,  43=Y/A-margin.*)
//==================================================================================================
FUNCTION typAok (typ :string;  aa2 :Integer) :Boolean;
   FUNCTION mm2On :Boolean;      VAR i :Integer;  sj,sa,s :string;  boo :boolean;      BEGIN
      i := -1;                   //Aikaisemmmat FNCt korvattu tällä 6.1.1 ##########################
      repeat  i := i+1;                        //<,,Etsitään tyypin JÄRJESTYSN:O = ARRAYn osoite.!!!
              sa := AnsiUpperCase(EtsiOlet(i,S_KaTyp));
      until (sa=typ) or (sa='');               //<0..27=28 tyyppiä AMCMK..AvoC+'' ##################
      sj := trim (mm2arr[i]);                  //<Tyyppiä i vastaavat poikkipinnat: "16\25\35\..."
//    sa := fImrkt0 (aa2,1);                   //<-7.0.4
      if aa2=1  then sa := '1.5'  else         //<+7.0.4
      if aa2=2  then sa := '2.5'  else
                     sa := fImrkt0 (aa2,0);
     {i := Pos (sa,sj);     //<,Tutkitaan onko edessä tai jäljessä merkitseviä, muuten 85 ok 185:stä
      j := Length(sa);
      boo := ( (i  =1) and (sj[i+j] IN ['\',' '])  or                 //<,,"Range check error"     -6.2.10
               (i-1>0) and (sj[i-1] IN ['\',' ']) and (sj[i+j] IN ['\',' ']) )  OR
             ( (typ='MMJ/MMK*') or (typ='MCMK3½') or (typ='MCMK3½½') ) and (aa2 IN [1,2]);}
     {boo := ( (i  =1) and ((i+j>Length(sj)) or (i+j=Length(sj)) and (sj[i+j] IN ['\',' ']))  or
               (i-1>0) and (sj[i-1] IN ['\',' ']) and (sj[i+j] IN ['\',' ']) )  OR
             ( (typ='MMJ/MMK*') or (typ='MCMK3½') or (typ='MCMK3½½') ) and (aa2 IN [1,2]);}
      boo := false;                                                                            //<,,+6.2.10
      s := '';
      for i := 1 to Length (sj)  do begin
         s := s +sj[i];
         if (CharInSet(sj[i], ['\',';',' '])) or (i=Length (sj))  then begin
            if CharInSet(sj[i], ['\',';',' '])
            then Delete (s,Length (s),1);
            if sa=s
            then begin
               boo := true;  Break;  end
            else s := '';
         end;
      end;
      result := boo;        //'Koska näillä tyypeillä myö 1.5 ja 2.5 mm2 mutta ne ei tlkssa ########
   end;
BEGIN//typAok
//.....,,,,,,,,,,Muutettava myös isoiksi kirjaimiksi, muuten eiOK, TODETTU #########################
typ := AnsiUpperCase(typ);
result := mm2On;
END; //typAok
//==================================================================================================
FUNCTION seurT (VAR typ :string) :Boolean;
   function ty (str :string) :boolean;          begin  //<Testaa isoilla kirj:lla onko samat stringt
      ty := SamIso (str,typ);                     end;
   PROCEDURE si (S :string);           BEGIN     //'Pal 0 VIKAN A:n JÄLKEEN=
      typ := S;  seurT := TRUE;         END;     //=MERKIKSI=ve:tLOPPU+FALSE
BEGIN //seurT
   typ := AnsiUpperCase(typ);  seurT := FALSE;
//........,,,,,,,Muutettava myös isoiksi kirjaimiksi, muuten eiOK, TODETTU #########################
   if typ=''             then si('MMJ/MMK*')     else
   if ty('MMJ/MMK*')     then si('MCMK3½')       else
   if ty('MCMK3½')       then si('MCMK3½½')      else
   if ty('MCMK3½½')      then si('MCMK4½')       else
   if ty('MCMK4½')       then si('PLKVJ*')       else
   if ty('PLKVJ*')       then si('AVOJOHcu')     else
   if ty('AVOJOHcu')     then si('AMCMK3½')      else
   if ty('AMCMK3½')      then si('AMCMK3½½')     else
   if ty('AMCMK3½½')     then si('AMCMK4½')      else
   if ty('AMCMK4½')      then si('AXMK')         else
   if ty('AXMK')         then si('AXCMK')        else
   if ty('AXCMK')        then si('AMMK*')        else
   if ty('AMMK*')        then si('APAKM*')       else
  {if ty('APAKM*')       then si('SVjärjest.')   else
   if ty('SVjärjest.')   then si('AMKA')         else  //<' -6.0.2}
   if ty('APAKM*')       then si('KiskAbb-CuN')  else  //<, +6.0.4  <,,6.1.1
   if ty('KiskAbb-CuN')  then si('KiskAbb-CuS')  else
   if ty('KiskAbb-CuS')  then si('KiskAbb-CuNx') else
   if ty('KiskAbb-CuNx') then si('KiskAbb-CuSx') else
   if ty('KiskAbb-CuSx') then si('KiskAbb-AlN')  else
   if ty('KiskAbb-AlN')  then si('KiskAbb-AlS')  else
   if ty('KiskAbb-AlS')  then si('SVsystCu3½')   else
   if ty('SVsystCu3½')   then si('SVsystCu4N')   else
   if ty('SVsystCu4N')   then si('SVsystCu5S')   else
   if ty('SVsystCu5S')   then si('SVsystAL3½')   else
   if ty('SVsystAL3½')   then si('SVsystAL4N')   else
   if ty('SVsystAL4N')   then si('SVsystAL5S')   else
   if ty('SVsystAL5S')   then si('AMKA')         else
   if ty('AMKA')         then si('AVOJOHal')     else typ := '';   //<Jää FALSE
END; //seurT
//==================================================================================================
FUNCTION Aok (aa2 :Integer) :Boolean;
   FUNCTION a (ala :Integer) :Boolean;          BEGIN
      a := FALSE;   IF aa2=ala  THEN a := TRUE;  END;
BEGIN
   Aok := FALSE;
   IF (aa2 IN [1,2,6,10,16,21,25,34,35,50,54,70,85,95,120,150,185,240])  OR
      a(300)  OR  a(600)  OR  a(900)  OR  a(1200)  OR  a(1600)  OR  a(2400)  OR  a(3200)
   THEN Aok := TRUE;
END; //Aok
//==================================================================================================
FUNCTION seurA (VAR aa2 :Integer) :Boolean;
   PROCEDURE si (ala :Integer);         BEGIN   //'Pal 0 VIKAN A:n JŽLKEEN=
      aa2 := ala;  seurA := TRUE;        END;   //=MERKIKSI=ve:tLOPPU+FALSE
BEGIN //seurA
   seurA := FALSE;
   CASE aa2 OF
        0 :si (  1);     21 :si ( 25);       70 :si ( 85);       240 :si (300);     1600 :si(2400);
        1 :si (  2);     25 :si ( 34);       85 :si ( 95);       300 :si (600);     2400 :si(3200);
        2 :si (  6);     34 :si ( 35);       95 :si (120);       600 :si (800);
        6 :si ( 10);     35 :si ( 50);      120 :si (150);       800 :si (900);
       10 :si ( 16);     50 :si ( 54);      150 :si (185);       900 :si(1200);
       16 :si ( 21);     54 :si ( 70);      185 :si (240);      1200 :si(1600);
   else  aa2 := 0;  END;                    //<FNC jää FALSE<<<<<<<<<<<<<<<<<<
END; //seurA

FUNCTION pienA (VAR aa2 :Integer) :Boolean;
   PROCEDURE si (ala :Integer);         BEGIN   //'Pal 0 VIKAN A:n JÄLKEEN=
      aa2 := ala;  pienA := TRUE;        END;   //=MERKIKSI=ve:tLOPPU+FALSE
BEGIN //pienA
   pienA := FALSE;
   CASE aa2 OF
        1 :si (  0);    25 :si ( 21);       85 :si ( 70);      300 :si ( 240);     2400 :si(1600);
        2 :si (  1);    34 :si ( 25);       95 :si ( 85);      600 :si ( 300);     3200 :si(2400);
        6 :si (  2);    35 :si ( 34);      120 :si ( 95);      800 :si ( 600);
       10 :si (  6);    50 :si ( 35);      150 :si (120);      900 :si ( 800);
       16 :si ( 10);    54 :si ( 50);      185 :si (150);     1200 :si ( 900);
       21 :si ( 16);    70 :si ( 54);      240 :si (185);     1600 :si (1200);
   else  aa2 := 0;  END;                   //<FNC jää FALSE<<<<<<<<<<<<<<<<<<
END; //pienA
//==================================================================================================
function SamaZtyyppi (typ :string) :boolean;      VAR boo :boolean;      begin //+6.2.2
   boo := true;
   if (typ='AVOJOHal') or (typ='AVOJOHcu') or (typ='AMKA') or (typ='PLKVJ*') or (typ='APAKM*') or
       fOnSV (typ) or fOnKIS (typ)
      then boo := false;
   result := boo;
end;
//==================================================================================================
//RivNoEtsi >0  0=tulosta ==RivNoEtsi=kutsussa annettava RiviNo,   SILVER 0=Normal 1=Silver  TYYP 1=TulostaKaapNimi
PROCEDURE tulJR (silver,tyyp,rw :Integer;  typ :string;  aa2 :Integer;  L,T :Real);
      VAR Rv,Rvo,Rn,Xv,Xo,Xn,Zekv,zz,aa :Real;   k :Integer;   S,typS :String;

   PROCEDURE ifTul (ohj,sar :integer;  ar :real;  s1,s2 :string);      VAR sa :string;  boo :boolean;      begin
         sa := s1 +s2;                                                             //=>+6.2.2
         if ohj>0  then                                          //<,Talletetaan isoin löytynyt arvo.
         if SamaZtyyppi (typ)  then begin
            boo := fAlCu (typ);                                                    //<+6.2.2
            if (ar > boldArr[boo,1,sar].arvo) or (boldArr[boo,1,sar].arvo=0)  then begin
               boldArr[boo,1,sar].arvo := ar;                        //< ISOIMMAN löytyneen arvo.
               boldArr[boo,1,sar].rivi := rw;  end;                  //< ISOIMMAN löytyneen arvon RiviNo.
            if (ar>0)  and
              ((ar < boldArr[boo,2,sar].arvo) or (boldArr[boo,2,sar].arvo=0))  then begin
                     boldArr[boo,2,sar].arvo := ar;                  //< PIENIMMÄN löytyneen arvo.
                     boldArr[boo,2,sar].rivi := rw;   end;           //< PIENIMMÄN löytyneen arvon RiviNo.
         end;
         ZS_Frm.ZS_StrGrid.Cells[sar,rw] := sa;
   end;
{apuFile #########################################################################################################
   procedure wrn (r :real);      VAR ar :real;      begin //Tiedostoon  +6.0.4
             //PROCEDURE siL (mH_km :Real);   BEGIN  Xv_ind := (mH_km *314.15926/1000) /1000; END; //< 01.INC :stä
             //                                      mH_km = Xv_ind*1000 / (314.15926/1000);
      ar := r / (314.15926/1000);
      if (r>0)
         then writeln (apuFile, fRmrkt0 (ar,6,4) +'  ' +fRmrkt0 (r,8,5));// +'  ' +fImrkt0 (i,1) +' mH/km')
       //else writeln (apuFile); //<Tyhjä rivi.
      Flush (apuFile);           //<ensures that the text was actually written to file
   end;
#################################################################################################################}
BEGIN//tulJR.......................
   WITH ZS_Frm.ZS_StrGrid  DO BEGIN
{apuFile #########################################################################################################
      if apuFilen=''  then begin
         apuFilen := 'E:\Projektit\NolaKehi\SRC\Impedanssi\Apu.txt';
         AssignFile (apuFile,apuFilen);
         Rewrite (apuFile);
      end;
{#################################################################################################################}
      Cells[0,rw] := fImrkt0(rw,1);
      typS := typ;                                                      //<,+6.2.2  Hopea väri kun EiSamaZ...
      if silver>0  then typS := COLOR_SILVER + typS +'</f>';            //  typS, jotta TYP säilyisi alpna.

      k := 1;    IF L<100  THEN k := 1000;
      IF (tyyp=1) and ZS_Frm.ZS_TypLbl.Visible  or                      //<tyyp=1 jos tyyppilistaus
                  NOT ZS_Frm.ZS_TypLbl.Visible  THEN BEGIN
         S := '<left>'+typS;   Cells[1,rw] := S {+c_+fRno(rw,2)};   END; //<Kaapelityyppi. fRn(..,2)=right
     {IF typ='S' THEN S := fImrkt_(aa2,4)  ELSE}
      IF aa2>3   THEN S := fImrkt_(aa2,1)  ELSE S := fRmrkt_(aa2+0.5, 1,1);
                              Cells[2,rw] := S;                         //<[0,rw] :ssä on kaapelityyppi
                              Cells[3,rw] := fRmrkt0(L,1,1);
                              Cells[4,rw] := fRmrkt0(T,1,1);
                              Cells[5,rw] := '<center>' +fDimens (L);   //<,,6.1.1  Järjestys uusittu ###########
    //Rv := rTkorj (fAlCu (typ), res (typ,aa2),trunc(T+0.5)) *L*k;
      Rv :=  res (typ,aa2);
      Rv :=  rTkorj (fAlCu (typ), Rv,pyor(T)) *L*k;
      Rvo := resVo (typ,aa2);
      Rvo := rTkorj (fAlCu (typ), Rvo,pyor(T)) *L*k;
      Rn :=  rTkorj (fPal (typ), resP (typ,aa2),pyor(T)) *L*k;
      Xv :=  Xv_ind  (typ,aa2) *L*k;
      Xo :=  Xv0_ind (typ,aa2) *L*k;
      Xn :=  Xp_ind  (typ,aa2) *L*k;
   //DemM..(1,=DEMOtesti  0=EiEdesTestiä) ##########################################################
   DemMrkt_(1,Rv, 1,5, S);      ifTul (1, 6,Rv ,c_,S);
   DemMrkt_(1,Rvo,1,5, S);      ifTul (1, 7,Rvo,c_,S);
   DemMrkt_(0,Rn, 1,5, S);      ifTul (1, 8,Rn ,c_,S);
   DemMrkt_(0,Xv, 1,5, S);      ifTul (1, 9,Xv ,c_,S);
   DemMrkt_(1,Xo, 1,5, S);      ifTul (1,10,Xo ,c_,S);
   DemMrkt_(0,Xn, 1,5, S);      ifTul (1,11,Xn ,c_,S);
     {zz := Xkap(typ,aa2) *L*k;
   DemMrkt_(0,zz,1,6, S);       ifTul (0,11,zz,c_,S);               //<Xc}
                                                                    //zz := Sqrt ( Sqr (Rv+Rn) + Sqr (Xv+Xn) ) = Z
      zz := Sqrt (Sqr(Rn) + Sqr(Xn));
   DemMrkt_(0,zz, 1,5, S);      ifTul (1,12,zz,c_,S);               //<Zn

      zz := 2*Rv+Rvo+3*Rn;                                          //<Re
   DemMrkt_(0,zz,1,5, S);       ifTul (1,13,zz,c_,S);
      zz := 2*Xv +Xo +3*Xn;                                         //<Xe
   DemMrkt_(0,zz,1,5, S);       ifTul (1,14,zz,c_,S);
      Zekv := Sqrt ( Sqr (2*Rv+Rvo+3*Rn) + Sqr (2*Xv+Xo+3*Xn) );    //<Ze
   DemMrkt_(1,Zekv,1,5, S);     ifTul (1,15,Zekv,c_,S);             //<Ze
      zz := (2*Rv+Rvo+3*Rn) / (2*Xv +Xo +3*Xn);                     //<Re/Xe
   DemMrkt_(0,zz,1,5, S);       ifTul (1,16,zz,c_,S);

      zz := Rv;                                                     //<R1
   DemMrkt_(1,zz,1,5, S);       ifTul (1,17,zz,c_,S);
      zz := Xv;                                                     //<X1
   DemMrkt_(1,zz,1,5, S);       ifTul (1,18,zz,c_,S);
      zz := Sqrt ( Sqr (Rv) + Sqr (Xv));                            //<Z1 myötäimpedanssi
   DemMrkt_(1,zz,1,5, S);       ifTul (1,19,zz,c_,S);
      zz := Rv/Xv;                                                  //<R1/X1
   DemMrkt_(1,zz,1,5, S);       ifTul (1,20,zz,c_,S);

 //FUNCTION fZd1 (tyyppi :string;  mm2 :Integer) :Real;      BEGIN   fZd1 := 2*fZd1_ (fAlCu(tyyppi), mm2);
      aa := fZd1 (typ,aa2);                                         //< Zd1*2 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      if (zz=0) or (aa2>200)                                        //<+6.2.2  or (aa2>200)
      then begin  Cells[21,rw] := '- -';
                  Cells[22,rw] := ' - - - - - - ';
                  Cells[23,rw] := ' - - - - - - ';  end
      else begin     aa := aa  *L*k;                                //< Z = 2Zd1
                     zz := 3*aa/2;                                  //<Jotta Ik1v = 3cUv / Z        +6.2.0
                     S := fRmrkt0(zz,1,3);
                  ifTul (0,22,zz,c_,S);                             //< Zd1_e
                     zz := aa/2;                                    //< Zd1  =taulukkoarvo / 2.
                     S := fRmrkt0(zz,1,3);
                  ifTul (0,23,zz,c_,S);                             //< Zd1  =taulukkoarvo / 2.
                     zz := (3*aa/2 -Zekv)/Zekv *100;
                     S := fRmrkt0(zz,1,1);
                     ifTul (0,21,zz,c_,S);                          //<Zd1Err vasta tässä (sar 21).

                  if (zz<0) and (abs(zz)>5)                               then                      //<,,6.2.0
                     S := CLR_REB +S +FNT_B0                              else
                  if                 zz>5                                 then
                     S := COLOR_BLUE +'<b>' +S +FNT_0;
                  Cells[21,rw] := S;
      end;
      //ZS_Frm.ZS_InfRv3.Caption := '';  //<Tyhjätään varmksi: Jää muuten joskus ObjInsp:n teksti, todettu
   END; //WITH
{apuFile #########################################################################################################
   Zekv := Rv/Xv;                                               //<,,VÄLIAIKAISESSA LASKENNASSA TILANT.MUK. +6.0.4
   if Rv/Xv>100  then k := 1  else
   if Rv/Xv>10   then k := 2  else
   if Rv/Xv>1    then k := 3  else
   if Rv/Xv>0    then k := 4  else k := 5;
   writeln (apuFile, fImrkt_(aa2,1) +'/' +fRmrkt0 (Rv,1,4) +'/' +fRmrkt0 (Xv,1,4) +'=' +
            fRmrkt0 (Rv/Xv,1,k));                                                          //<''Tiedostoon  +6.0.4
   Flush (apuFile);  //<ensures that the text was actually written to file
#################################################################################################################

writeln (apuFile, 'Wiski 10');
wrn (0.116 );
wrn (0.1068);
wrn (0.1   );
wrn (0.1   );
writeln (apuFile, 'Wiski 20');
wrn (0.132);
wrn (0.126);
wrn (0.123);
wrn (0.116);
wrn (0.113);
wrn (0.11 );
wrn (0.107);
writeln (apuFile, 'AHXLMK 110');
wrn (0.1948);
wrn (0.1885);
wrn (0.1759);
wrn (0.1696);
wrn (0.1382);
wrn (0.1288);
wrn (0.1162);
wrn (0.11  );
writeln (apuFile, 'AlFe avo 110');
wrn (0.375);
wrn (0.366);
wrn (0.339);
wrn (0.32 );
wrn (0.312);
wrn (0.309);
wrn (0.302);
wrn (0.295);
wrn (0.29 );
wrn (0.282);
wrn (0.271);
writeln (apuFile, 'AlCu avo 110');
wrn (0.4);
wrn (0.3);
writeln (apuFile, 'PLKVJ 10');
wrn (0.141);
wrn (0.132);
wrn (0.123);
wrn (0.113);
wrn (0.107);
wrn (0.101);
wrn (0.097);
wrn (0.094);
wrn (0.081);
writeln (apuFile, 'APYAKMM 10 ');
wrn (0.132);
wrn (0.125);
wrn (0.118);
wrn (0.112);
wrn (0.101);
wrn (0.102);
wrn (0.101);
wrn (0.097);
wrn (0.094);
wrn (0.082);
writeln (apuFile, 'AXMK');
wrn (0.0911);
wrn (0.0880);
wrn (0.0880);
wrn (0.0880);
wrn (0.0848);
wrn (0.0848);
wrn (0.0817);
wrn (0.0817);
wrn (0.0817);
wrn (0.0785);
wrn (0.0785);
writeln (apuFile, 'AMCMK3½');
wrn (0.0817);
wrn (0.0817);
wrn (0.0817);
wrn (0.0785);
wrn (0.0754);
wrn (0.0754);
wrn (0.0723);
wrn (0.0723);
wrn (0.0723);
wrn (0.0723);
wrn (0.0723);
CloseFile (apuFile);
beep;               //<Tähän BreakPoint, jotta kirjoittaisi vain kerran = ei joka kutsukerralla.!!!!!!!!!!!!!!!!!!
-----------------------------------------------------------------------------------------------------------------}
{############################### NÄMÄ SÄILYTETÄÄN PUD.VALIKKOIHIN SIJ. VARTEN ####################################
                                                                       '<br><b><u>Sj-JOHTOJEN ARVOJA:     (mm²/Rv/Xv['+FONT_OMEGA +'/km]=suhde/L[mH/km])</u></b><br>'+
                                                                       '<b>=== NK-Cables AHXAMK-W ("Wiski") 10 kV</b>,  Rv=Rac 65°C, kRv 65'+nuo+'40°C = 0.89925:<br>'+
120  </b>/0.3 /0.116 =2.586/0.3692
185  </b>/0.2 /0.1068=1.873/0.340
240  </b>/0.15/0.1   =1.5  /0.318
300  </b>/0.12/0.1   =1.2  /0.318<br>' +
                                                          '<b>=== NK-Cables AHXAMK-W ("Wiski") 20 kV</b>,  Rv=Rac 65°C, kRv 65'+nuo+'40°C = 0.89925:<br>'+
70   </b>/0.53/0.132=4.015/0.420
95   </b>/0.38/0.126=3.016/0.401
120  </b>/0.3 /0.123=2.439/0.392
150  </b>/0.25/0.116=2.155/0.369
185  </b>/0.2 /0.113=1.77 /0.360
240  </b>/0.15/0.11 =1.364/0.350
300  </b>/0.12/0.107=1.121/0.341<br>'+
                                                          '<b>=== NK-Cables AHXLMK 110 kV</b>,  kk=D, Rv=Rac 65°C, kRv 65'+nuo+'40°C = 0.89925:<br>'+
300   </b>/0.15 /0.1948=0.77  /0.62                       1j×3 tasoss
500   </b>/0.1  /0.1885=0.5305/0.60
800   </b>/0.078/0.1759=0.4434/0.56
1200  </b>/0.071/0.1696=0.4186/0.54<br>'+
300   </b>/0.15 /0.1382=1.085 /0.44                       1j×3 kolmio
500   </b>/0.11 /0.1288=0.854 /0.41
800   </b>/0.08 /0.1162=0.6885/0.37
1200  </b>/0.071/0.11  =0.6455/0.35<br>'+
                                                          '<b>=== NK-Cables (Al/Fe)-avojohdot < 110 kV</b>,  1.5 A/mm², Rv=Rac 20°C, kRv 20'+nuo+'40°C '+FONT_LIKIM +' 1.081, Xv vaihevälillä 1 m:<br>'+
Savo           (42/25) </b>  /0.692 /0.375=1.845/ 1.194
Raven          (54/9)  </b>  /0.543 /0.366=1.484/ 1.165
Imatra         (93/39) </b>  /0.32  /0.339=0.944/ 1.079
Suursavo       (106/25)</b>  /0.275 /0.32 =0.8594/1.019
<u>Ostrich</u> (152/25)</b>  /0.192 /0.312=0.615/ 0.993
Piper          (152/35)</b>  /0.192 /0.309=0.621/ 0.984
Ibis           (201/33)</b>  /0.145 /0.302=0.48/  0.961
Hawk           (242/39)</b>  /0.12  /0.295=0.4068/0.939
<u>Duck</u>    (305/39)</b>  /0.0988/0.29 =0.3407/0.923
Condor         (402/52)</b>  /0.0759/0.282=0.2691/0.898
Finch          (565/72)</b>  /0.0549/0.271=0.2026/0.863<br>'+
                                                       '<b>=== NK-Cables Al- tai Cu-avojohdot ' +FONT_SUURPI +' 110 kV</b>:   Rv kuten edellä, Cu: ks. '+
                                                        'esim. päävalikon "Imped. tarkasteluosa",
<b>Xv = 0.4/1.27 '+FONT_OMEGA +'/km yleensä, '+
       '0.3/0.95 '+FONT_OMEGA +'/km, kun nippu- tai ''tandenbaum''-ripustus</b><br>'+
                                                        '<b>=== NOKIA PLKVJ 10 kV</b>,  Rv=Rac 40°C, kRv 40'+nuo+'65°C = 1.09825:<br>'+
10</b> /1.909/0.141=13.54/0.449
16</b> /1.299/0.132=9.841/0.420
25</b> /0.787/0.123=6.398/0.392
35</b> /0.568/0.113=5.027/0.360
50</b> /0.422/0.107=3.944/0.341
70</b> /0.292/0.101=2.891/0.322
95</b> /0.212/0.097=2.186/0.309
120</b>/0.169/0.094=1.798/0.299
185</b>/0.112/0.081=1.383/0.258
                                                        '<br>' +
                                                        '<b>=== NOKIA APYAKMM 10 kV</b>,  Rv=Rac 40°C, kRv 40'+nuo+'65°C = 1.10075:<br>'+
25 </b>/0.792/0.132=6/    0.420
35 </b>/0.573/0.125=4.584/0.398
50 </b>/0.899/0.118=7.534/0.376
70 </b>/0.485/0.112=4.33/ 0.357
95 </b>/0.353/0.101=3.299/0.322
120</b>/0.281/0.102=2.755/0.325
150</b>/0.231/0.101=2.287/0.322
185</b>/0.187/0.097=1.928/0.309
240</b>/0.147/0.094=1.564/0.299
300</b>/0.121/0.082=1.476/0.261<br><br>'+
                                                        '<b><u>Pj-JOHTOJEN ARVOJA:     (mm²/Rv/Xv[' +FONT_OMEGA +'/km]=suhde/L[mH/km])</u></b><br>'+
                                                        '<b>=== AXMK 1 kV</b>,  Rv=Rac 40°C, kRv 40'+nuo+'65°C = 1.08925:<br>'+
16 </b>/2.0686/0.0911=22.70/0.29
25 </b>/1.3491/0.0880=15.34/0.28
35 </b>/0.9380/0.0880=10.66/0.28
50 </b>/0.6925/0.0880=7.873/0.28
70 </b>/0.4794/0.0848=5.651/0.27
95 </b>/0.3463/0.0848=4.082/0.27
120</b>/0.2743/0.0817=3.358/0.26
150</b>/0.2230/0.0817=2.731/0.26
185</b>/0.1781/0.0817=2.180/0.26
240</b>/0.1439/0.0785=1.832/0.25
300</b>/0.1169/0.0785=1.489/0.25<br>'+
                                                        '<b>=== AMCMK3½ 1 kV</b>,  Rv=Rac 40°C, kRv 40'+nuo+'65°C = 1.08925:<br>'+
16 </b>/2.0686/0.0817=25.32/0.26
25 </b>/1.2591/0.0817=15.42/0.26
35 </b>/0.9380/0.0817=11.48/0.26
50 </b>/0.6925/0.0785=8.817/0.25
70 </b>/0.4794/0.0754=6.358/0.24
95 </b>/0.3463/0.0754=4.592/0.24
120</b>/0.2743/0.0723=3.796/0.23
150</b>/0.2230/0.0723=3.087/0.23
185</b>/0.1781/0.0723=2.464/0.23
240</b>/0.1385/0.0723=1.917/0.23
300</b>/0.1169/0.0723=1.618/0.23<br><br>' +
#################################################################################################################}
END; //tulJR
//==================================================================================================
PROCEDURE Jotsikko (VAR o :integer;  rvja :integer);      BEGIN //<OTS := 6,   o := +1 jos tarvis
   if ChkOtsTarve (6,rvja, 1,'Tyyppi', o)  then     //< o ja R_n muuttuu tarvitaessa, 6 asetetaan aina
   WITH ZS_Frm.ZS_StrGrid  DO BEGIN                 //i = 1.. =ROW =eka ROW=2 jne
      if ZS_Frm.ZS_StrGrid.ColCount < 25            //<, 6.1.1  20 => 25
         then ColCount := 25;                       //<'6.0.2 lisätty Rvo -sarake
         if o=0  then
      Cells[ 0,o] := blu('Rv')  else Cells[ 0,o] := COLOR_SILVER +fImrkt0(o,1) +FNT_0;
      Cells[ 1,o] := blu('Tyyppi____');   Cells[ 2,o] := blu(' mm²');         Cells[ 3,o] := blu(' Lpit [m]');
      Cells[ 4,o] := blu(' T [°C]');      Cells[ 5,o] := blu(fDimOts);
      Cells[ 6,o] := blu(' Rv____');      Cells[ 7,o] := blu(' Rvo___');      Cells[ 8,o] := blu(' Rn____:');
      Cells[ 9,o] := blu(' Xv____');      Cells[10,o] := blu(' Xvo___');      Cells[11,o] := blu(' Xn____:');
      Cells[12,o] := blu(' Zn____|');     Cells[13,o] := blu(' Re____');      Cells[14,o] := blu(' Xe____');
      Cells[15,o] := blu(' Ze____');      Cells[16,o] := blu(' Re/Xe_|');     Cells[17,o] := blu(' R1____');
      Cells[18,o] := blu(' X1____');      Cells[19,o] := blu(' Z1____');      Cells[20,o] := blu(' R1/X1__|');
      Cells[21,o] := blu(' D1err[%]');    Cells[22,o] := blu (' Z_D1_e');     Cells[23,o] := blu (' Z_D1');

END;{WITH} END; //Jotsikko
PROCEDURE Sotsikko (o :integer);      BEGIN //<OTS := 7
   if (o=0) or (ots<>7)  then               //<Kylläkin aina (olisi OK ilman testiäkin =AINA otsikko)
   WITH ZS_Frm.ZS_StrGrid  DO BEGIN         //i = 1.. =ROW =eka ROW=2 jne
      ots := 7;                             //<Merkitään voimassa oleva OtsikkoNo
         if o=0  then
      Cells[0,o] := blu('Rv')  else Cells[ 0,o] := COLOR_SILVER +fImrkt0(o,1) +FNT_0;
    //Cells[0,o] := blu(Cells[0,o] +fRno(o,2)); //<fRn(..,2)=right
      Cells[2,o] := blu(' mm²');
      Cells[3,o] := blu(' Lpit [m]');
      Cells[4,o] := blu(' T [°C]');
      Cells[5,o] := blu(fDimOts);
      Cells[6,o] := blu(' Rmax__');
      Cells[7,o] := blu(' Xmax__');
      Cells[8,o] := blu(' Ze____');
      Cells[9,o] := blu(' Lsuht__');
END;{WITH} END; //Sotsikko
PROCEDURE Motsikko (VAR o :integer;  rvja :integer);      var sa :string;   BEGIN //<OTS := 8,   o := +1 jos tarvis
   if ChkOtsTarve (8,rvja, 1,'HÄVIÖ', o)  then      //< o ja R_n muuttuu tarvitaessa, 8 asetetaan aina
   WITH ZS_Frm.ZS_StrGrid  DO BEGIN                 //i = 1.. =ROW =eka ROW=2 jne
      Visible := false; //<ON MUISTETTAVA LAITTAA TAKAS PÄÄLLE GRIDITÄYTÖN JÄLKEEN KUTSUOSASSA ##################
         if o=0  then   //'######################################################################################
      Cells[0,o] := blu('Rv')  else Cells[ 0,o] := COLOR_SILVER +fImrkt0(o,1) +FNT_0;
      Cells[1,o] := blu('<left>'+'HÄVIÖsarja');
      if SamIso (Ktyp,'Muuntajat 1')  then sa := blu('<center>1')  else //<Riville 2 =1, eka sarake =0
      if SamIso (Ktyp,'Muuntajat 2')  then sa := blu('<center>2')
                                      else sa := blu('<center>3');
      Cells[1,o+1] := sa;
      Cells[1,o+2] := blu('<center>' +fRmrkt0 (fUn_Umn,1,0) +' V');                             //< +6.0.4
//                                Cells[1,o+1] := blu(Cells[0,o+1] +fRno(o+1,2)); //<fRn(..,2)=right
      Cells[ 2,o] := blu(' Sm[kVA]');
      Cells[ 4,o] := blu(' T [°C]');
      Cells[ 5,o] := blu(fDimOts);
      Cells[ 6,o] := blu(' Rm_____');
      Cells[ 7,o] := blu(' Rm0____:');
      Cells[ 8,o] := blu(' Xm_____');
      Cells[ 9,o] := blu(' Xm0___');
      Cells[10,o] := blu(' Zm0___|');
      Cells[11,o] := blu(' Re____');
      Cells[12,o] := blu(' Xe____');
      Cells[13,o] := blu(' Ze____');
      Cells[14,o] := blu(' Re/Xe_|');
      Cells[15,o] := blu(' R1____');
      Cells[16,o] := blu(' X1____');
      Cells[17,o] := blu(' Z1____');
      Cells[18,o] := blu(' R1/X1__|');
      Cells[19,o] := blu(' Z1/Z0__'); //<+8.0.5
END;{WITH} END; //Motsikko
//,,,###################################### Zval 1 ##############################################,,,
PROCEDURE K_typ;      VAR k :Integer;  ar :Real;  typ,S :String;
   //###################################### Zval 1 Tyyp #########################################,,,
   PROCEDURE tulT;      LABEL 1;   VAR aa2, rv,i, tyyp :Integer;   tul,OK, bo,bool :Boolean;    BEGIN

 //sq := 'tulT(1):';
   tul := false;
   i := 0;  rv := 0;
 1:
   OK := true;
   if tul  then        //,,OtsNo = 1 ############################################################################
   if ChkR_n(1,6,i)                  //<Asetti R_x =Siirtää tarvittaessa.   1=Välirivi  1=OtsNo  i=ArvoRiviTarve
   then begin          //ZS_Frm.Caption := ZS_Frm.Caption +' tulT(1)Rc=' +fImrkt0(R_u,1);
      asetaZval1_LftVis;
      rv := R_u-i-1;                 //<i tutkittiin, kun TUL oli FA. -1 = koska i oli 1.. ja Row=0..
      Jotsikko (rv,i);  end          //<Asetti OTS := 6;   rv korjautui tarvittaessa +1
   else OK := false;                 //'Ei haittaa, vaikka jo olisi: Menee 0 -riville aina

   if OK  then begin
      typ := Ktyp;
      i := 0;   aa2 := 0;   bo := true;
      REPEAT
         bool := seurA (aa2);                        //<Kunnes FALSE =Oli vika
         IF typAok (typ,aa2)  THEN BEGIN
            i := i+1;
            if bo   then tyyp := 1  else tyyp := 0;  //<,Vain ekalle tulriville KaapTyyppi
            bo := false;
            if tul  then tulJR (1,tyyp,rv+i, typ,aa2,L,T);  END; //<NORMAALITYYPPIEN TULOSTUS ###################
      UNTIL  NOT bool; //'''''###################################################################################

    //IF typ='SVjärjest.'  THEN              //< -6.0.2
      IF fOnSV (typ)  THEN                   //< +6.0.2
      WITH ZS_Frm.ZS_StrGrid  DO BEGIN               //i = 1.. =ROW =eka ROW=2 jne
         k := 1;   IF L<100  THEN k := 1000;
         i := i+2;                                   //<Välirivi + seur. otsakerivi
         if tul  then Sotsikko (rv+i);               //<Asetti OTS := 7;

         aa2 := 0;
         REPEAT
            bool := seurA (aa2);                     //<Kunnes FALSE =Oli vika
            IF typAok (typ,aa2)  THEN BEGIN
               i := i+1;
               if tul  then begin                             Cells[0,rv+i] := fImrkt0(rv+i,1);
                  IF aa2>3   THEN S := fImrkt_(aa2,1)  ELSE S := fRmrkt_(aa2+0.5, 1,1);
                  ar := RmaxSV (typ,aa2);  ar := rTkorj (fAlCu (typ), ar, pyor (T));
                                                              Cells[2,rv+i] := c_+S;
                                                              Cells[3,rv+i] := c_+fRmrkt0 (L,1,1);
                                                              Cells[4,rv+i] := c_+fRmrkt0 (T,1,1);
                                                              Cells[5,rv+i] := '<center>' +fDimens (L);
                                                              //,sijM..(1=DEMOtesti  0=EiEdesTestiä
                  DemMrkt_(1, L*k *ar,               1,5, S); Cells[6,rv+i] := c_+S; //<DemoTEST
                  DemMrkt_(0, L*k *XmaxSV (typ,aa2), 1,5, S); Cells[7,rv+i] := c_+S; //<Ei -"-
                  DemMrkt_(1, L*k *Sqrt ( Sqr(ar) + Sqr(XmaxSV (typ,aa2)) ), 1,5, S);
                                                              Cells[8,rv+i] := c_+S;
                  ar := SVsuhtL (typ,aa2);                    //<Unit0
                  DemMrkt_(0, ar, 1,4, S);                    Cells[9,rv+i] := c_+S;
               end;//if tul
            END;//if typAok
         UNTIL  NOT bool;

         if tul  then ZS_InfRv_(3,'Arvot PE-järjestelmille (5j).     Lsuht=SUHTEELLINEN '+
         'etäisyys max.impedanssiPISTEESEEN.                (Max) Ze = '+FONT_2JUURI+'(Rmax ² + Xmax ²)');
      END;//IF SamIso (typ,'SVsyst..'  THEN .. with
      if NOT tul  then begin
         tul := true;
         GOTO 1;  end;

      IF SamIso (Ktyp,'MMJ/MMK*') or SamIso (Ktyp,'PLKVJ*') or SamIso (Ktyp,'AMMK*') or SamIso (Ktyp,'APAKM*')
         THEN bo := TRUE  ELSE bo := FALSE;            //'Valmistus lopetettu
      ZS_InfRv_(1, fZekv_info1 (bo));              //<BO =eioo =Valmistus lopetettu
      ZS_InfRv_(2, fZekv_info2);                   //<L,T asetettu ZS_
      ZS_InfRv_(3, fZkaap_info3);
      //£a asetaFrm (i);
   end;//if OK then
   END; //tulT
   //,,,###################################### Zval 1 Muunt #####################################,,,
   PROCEDURE tulM;      LABEL 1;   CONST armax=25;
         TYPE siAr=array [1..armax] of record Sm :integer;  vm :string;  end{+5.0.1};
         VAR Sm,rv,i,m :Integer;   R,R0,X,X0,ar :Real;  S :String;  tul,OK :Boolean;
             arr :siAr{+5.0.1};

     {FUNCTION rTm (R :Real) :Real;      var AlCu :Boolean;  ra :real;  MuTyp :integer;      BEGIN  -6.0.4
         IF SamIso (Ktyp,'Muuntajat 1')  then MuTyp := 1  else
         IF SamIso (Ktyp,'Muuntajat 2')  then MuTyp := 2  else MuTyp := 3;
         AlCu := fTrAlCu (MuTyp,1*Sm);
         ra := rTaT20 (AlCu,R, 75);            //<Korjataan ekax T=75°:ssa ollut R 20°C :een ###### +2.0.5
         ra := rTkorj (AlCu,ra,pyor(t));
         result := ra;   END;}
      //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,+5.0.1
      PROCEDURE sijARR;      VAR ar1,ar2 :siAr;   i1,i2,ia :integer;   s1,s2 :string;   ulos :boolean;

         PROCEDURE teeS_I (VAR arx :siAr;  si,sx :string);      VAR sa :string;  i,u,no :integer;      begin
            for i := 1 to armax  do begin              //<Alustus, pakko.
               arx[i].Sm := 0;  arx[i].vm := '';  end;
            sa := '';   u := 0;
            for i := 1 to Length (si) +1  do begin
               if (i<Length (si)+1) and (CharInSet(si[i], ['0'..'9'])) //< i<..+1 jotta vikakin koko sa :han,TODETTU.
               then sa := sa +si[i]
               else begin
                    if SokI (sa,no)  then begin
                       u := u+1;  arx[u].Sm := no;       //<Sijoitetaan muodostettu integer
                                  arx[u].vm := sx;  end; //<ja ao. vuosimalli-info taulukkoon.
                    sa := '';  end;
            end;//for
         end;
      begin//sijARR,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
        {S_MUUN  = '16\30\50\100\160\200\250\315\400\500\630\800\1000\1250\1600\2000\2500\3150'; =18 kpl
         S_MUUN_1=                  '200\    315\    500\630\800\1000\1250\1600\2000\2500\3150';
         S_MUUN_2= '   30\50\100\    200\    315\    500\630\800\1000\1250\1600\2000';
         S_MUUN_3= '   30\50\100\160\200\250\315\400\500\630\800\1000\1250\1600\2000\2500\3150';}
         IF SamIso (Ktyp,'Muuntajat 1')  THEN s1 := S_MUUN_1  else
         IF SamIso (Ktyp,'Muuntajat 2')  THEN s1 := S_MUUN_2
                                         else s1 := S_MUUN_3;
         s2 := S_MUUN;
         teeS_I (ar1,s1, 'vm00   ');                //<,Alustaa samalla
         teeS_I (ar2,s2, 'vm93(*)');
         for i1 := 1 to armax  do begin             //<Alustus, pakko.
            arr[i1].Sm := 0;  arr[i1].vm := '';  end;

         ia := 0;  i1 := 0;
         repeat
            i1 := i1+1;  i2 := 0;
            repeat                  //<,,Kaikkikattavasta tlkosta pienemmät kuin valitun tyypin tlkn PIENIN.!!!!!!
               ulos := false;
               i2 := i2 +1;
               if (ar2[i2].Sm > 0)  and (ar2[i2].Sm < ar1[i1].Sm)  then begin
                  ia := ia +1;                         //'Jos a2:ssa a1[] :tä pienempi koko.
                  arr[ia] := ar2[i2];  end;

               if ar2[i2].Sm <= ar1[i1].Sm        //, OK vaikka olisikin jo 0.
                  then ar2[i2].Sm := 0            //< 0 jottei seur. silmukassa enää näkyisi, VM saa jäädä.
                  else ulos := true;              //<Jos isompi, ohjataan ulos
            until (i2=armax)  or ulos;

            if ar1[i1].Sm>0  then begin                //<,,Valitun tyypin tlkosta seuraava koko.
               ia := ia +1;
               arr[ia] := ar1[i1];
            end;

            i2 := 0;
            repeat                  //<,,Kaikkikattavasta tlkosta loput isommat kuin valitun tyypin tlkn SUURIN.!!
                                    //,ar1[i1] = arr[ia] =Juuri sijoitettu.
               i2 := i2+1;                    //i1+1 ei saa ylittää,,,,ARMAX´ia, eikä nykyisellään teekään niin.
               if (ar2[i2].Sm > ar1[i1].Sm)  and (ar2[i2].Sm < ar1[i1+1].Sm)  OR
                  (ar1[i1].Sm = 0)           and (ar2[i2].Sm > 0)  and (ar2[i2].Sm > arr[ia].Sm)
               then begin
                  ia := ia +1;                //'Jos a2:ssa a1[] ja [+1]:n välikoko.
                  arr[ia] := ar2[i2];
                  ar2[i2].Sm := 0;  end;      //< 0 jottei seur. silmukassa enää näkyisi, VM saa jäädä.
            until (i2=armax);
         until (i1=armax)  or (ar1[i1].Sm=0);
         if arr[1].Sm<0  then beep;        //<Breakpointille
      end;//sijARR''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''+5.0.1
   BEGIN //tulM ....................................................................................

 //sq := 'tulM(1):';
   sijARR;
   tul := false;
   i := 0;  rv := 0;
1:
   OK := true;
   if tul  then        //,,OtsNo = 3 ############################################################################
   if ChkR_n(1,8,i)                  //<Asetti R_x =Siirtää tarvittaessa.   1=Välirivi  1=OtsNo  i=ArvoRiviTarve
      then begin asetaZval1_LftVis;
                 rv := R_u-i-1;  end //<i tutkittiin, kun TUL oli FA. -1 = koska i oli 1.. ja Row=0..
      else OK := false;              //<''ALP''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

   if OK  then
   WITH ZS_Frm.ZS_StrGrid  DO BEGIN  //i = 1.. =ROW =eka ROW=2 jne
      if tul  then Motsikko (rv,i);  //<Asetti OTS := 8;  = Visible := false;  RV korjautui tarvittaessa +1
      rv := R_u-i-1;                 //<Motsikko ehkä muutti R_n :ää väliotsikon takia ##########################

      i := 0;
      REPEAT
         i := i+1;
         Sm := arr[i].Sm;

         if Sm>0  then begin
            IF SamIso (Ktyp,'Muuntajat 1')  THEN asMparam_ (1*Sm, 1,Pyor(T), R,R0,X,X0, m)  else//<Hävsrj 1=Ik3v. m syntaxin takia
            IF SamIso (Ktyp,'Muuntajat 2')  THEN asMparam_ (1*Sm, 2,Pyor(T), R,R0,X,X0, m)      //<Hävsrj 2=Ik3v. m syntaxin takia
                                            ELSE asMparam_ (1*Sm, 3,Pyor(T), R,R0,X,X0, m);     //<Hävsrj 3=Ik1v. m syntaxin takia
            if tul  then begin
              {R :=  rTm (R);                                                //<LämpötilaKorj              -6.0.4
               R0 := rTm (R0);}
                                           Cells[ 0,rv+i] := fImrkt0(rv+i,1);//Cells[0,rv+i] +'@'+fRno(rv+i,2); //<fRn(..,2)=right
//             S := fImrkt_(Sm,1);         Cells[ 2,rv+i] := c_+S;    //,[3,..] jää tyhjäksi        //< -5.0.1
               S := fImrkt_(Sm,1);         Cells[ 2,rv+i] := '<left>'+arr[i].vm +'<right>' +c_ +S;  //<  5.0.1
                                           Cells[ 4,rv+i] := fRmrkt0(T,1,1); //'[3,..] jää tyhjäksi
                                           Cells[ 5,rv+i] := '<center>' +fDimens (1000); //<1000 antaa Ohmia, <100 antaa mOhmia
               DemMrkt_(1, R  , 1,6, S);   Cells[ 6,rv+i] := c_+S;    //<1=DemoTESTI
               DemMrkt_(0, R0 , 1,6, S);   Cells[ 7,rv+i] := c_+S;    //<0=Ei DemoTESTIÄ
               DemMrkt_(1, X  , 1,6, S);   Cells[ 8,rv+i] := c_+S;    //<1=DemoTESTI
               DemMrkt_(0, X0 , 1,6, S);   Cells[ 9,rv+i] := c_+S;    //<0=Ei DemoTESTIÄ
                        ar := Sqrt( Sqr(R0) + Sqr(X0) );              //<, Z0  +8.0.5
               DemMrkt_(0, ar , 1,6, S);   Cells[10,rv+i] := c_+S;    //<0=Ei DemoTESTIÄ

               DemMrkt_(0, 2*R+R0,1,5, S); Cells[11,rv+i] := c_+S;    //<0=Ei DemoTESTIÄ
               DemMrkt_(0, 2*X+X0,1,5, S); Cells[12,rv+i] := c_+S;    //<0=Ei DemoTESTIÄ
               DemMrkt_(1, Sqrt( Sqr(2*R+R0) + Sqr(2*X+X0) ), 1,6, S);
                                           Cells[13,rv+i] := c_+S;
               DemMrkt_(0, (2*R+R0)/(2*X+X0)
                              , 1,5, S);   Cells[14,rv+i] := c_+S;    //<0=Ei DemoTESTIÄ
               DemMrkt_(1, R  , 1,6, S);   Cells[15,rv+i] := c_+S;    //<1=DemoTESTI
               DemMrkt_(1, X  , 1,6, S);   Cells[16,rv+i] := c_+S;    //<1=DemoTESTI
               DemMrkt_(0, Sqrt (Sqr(R) + Sqr(X)), 1,6, S);           //<0=Ei DemoTESTIÄ
                                           Cells[17,rv+i] := c_+S;    //,1=DemoTESTI
               DemMrkt_(1, R/X, 1,6, S);   Cells[18,rv+i] := c_+S;    //<1=DemoTESTI
                        ar := Sqrt( Sqr(R) + Sqr(X) ) / Sqrt( Sqr(R0) + Sqr(X0) ); //<, Z1/Z0  +8.0.5
               DemMrkt_(1, ar, 1,6, S);    Cells[19,rv+i] := c_+S;    //<1=DemoTESTI
            end;//if tul
         end;//if Sm>0
      UNTIL Sm=0;
      if tul
         then Visible := true //<Sotsikko() asetti FA ###########################################################
         else begin
              tul := true;
              GOTO 1;  end;

      ZS_InfRv_(2, fZekv_info2);
      ZS_InfRv_(3, 'Häviösarja 1 = Normaalit häviöt,     2 = Alennetut '+
                   'tyhjäkäyntihäviöt  (suurempi Zk),     3 = Alennetut '+
                   'kuormitushäviöt (pieni Zk, käyttö:  teollisuus, Ik3v)');
       //£a asetaFrm (i);
   end; //if OK then with
   END; //tulM
//-------------------------------------------------------------------------
BEGIN//K_typ
  if SamIso (Ktyp,'Muuntajat 1') or SamIso (Ktyp,'Muuntajat 2') or SamIso (Ktyp,'Muuntajat 3')
     then tulM
     else tulT;
end; //K_typ

//,,,###################################### Zval 2 ##############################################,,,
//==================================================================================================}*)
PROCEDURE tulA (ala :Real);
     LABEL 1,3,8,9;   VAR typ,AlpTyp,ss :string;  tul,OK, valmis,eioo,kaikki :Boolean; //<Kaikki +6.2.2
                        am2,rv,i,j,k, val :Integer;  ar,re :real;
   function mm2R (aa2 :integer) :real;      VAR rr2 :real;      begin//+6.2.2
      if aa2<2  then rr2 := 1.5  else
      if aa2<4  then rr2 := 2.5  else
                     rr2 := aa2;
      result := rr2;  end;

   function mm2Rs (aa2 :integer) :string;      VAR o :integer;  rr2 :real;  ss :string;      begin//+6.2.2
      rr2 := mm2R (aa2);
      if aa2<4  then o := 1  else o := 0;
      ss := fRmrkt0 (rr2,1,o);
      result := ss;
   end;

BEGIN
//sq := 'tulA(2):';
   ZS_InfRv_(3, fZkaap_info4);
   am2 :=  Trunc (ala);
   LaskeeOdFrm.NayLaskeeOdota;                             //<+6.2.2
   AlpTyp := typ;                                          //<Tämä palautetaan lopuksi +2.0.3
   if SamIso ('Kaikki',ZS_Frm.ZS_Mm2Cm.Text)               //<,,+6.2.2
      then kaikki := true
      else kaikki := false;                                //<Ilmaisee, halutaanko kaikki mm2:t listata kerralla.
   i := 0;   {rv := R_n; }rv := 0;
   tul := false;
   alustaBoldArr;
   if kaikki  then begin //§§1
      if InfoDlg ('Vanhat tiedot poistetaan!',  mtWarning,  'OK','Peru','','',  '','','','') = 2
    //if InfoDlg ('Vanhat tiedot poistetaan!',  ['OK','Peru'], []) = 2
         then GOTO 9;
      if jatkaMm2>0
         then am2 := Trunc (jatkaMm2)
         else am2 := 1;
      ZS_Frm.ZS_StrGrid.Visible := false;                  //<Jottei putsaus näkyisi "vilahteluina"
      PutsCells_(0,ZS_Frm.ZS_StrGrid.FixedRows);
      ZS_Frm.ZS_StrGrid.Visible := true;  end;

1: if kaikki  then //§§1                                   //<Jos KAIKKI, aloitetaan aina ALA:n etsintä MMJ:stä.
      typ := 'MMJ/MMK*';
                         //,#####################################################################################,
3:                       //<,,1.krlla:  Tutkitaan tarvittava rivimäärä.  2.krlla:  Tutkit.mahtuuko sivulle +Tulost.
   OK := true;           //'#####################################################################################'
   if tul  then begin    //,,OtsNo = 1 ##########################################################################
      //,,,,,,,,,,,,,,,,,,,KAIKKIEN vaihtoehtojen etsintä +6.2.2,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      val := 2;            //<Ohjataan CASE 2 :een.
      if kaikki  then begin                                                                       //<,,+6.2.2
         k := am2;
         pienA (k);
         ss := mm2Rs (k);
         ZS_Frm.ZS_Mm2Cm.Text := ss;             //<Pysähdyksen ajaksi mm2 näkyviin (saattaa jäädä näkyviin).
         if R_n+i+2>RowMax-10  then begin        //< +2 =Koska arvorivien jälkeen tulee 1xRivi dCu% + 1xRivi dAl%
            beep;
            val := InfoDlg ({'Max.rivimäärä ' +fImrkt0(ZS_Frm.ZS_StrGrid.RowCount - ZS_Frm.ZS_StrGrid.FixedRows,1) +
                             ' ylittyy (vapaana ' +fImrkt0(ZS_Frm.ZS_StrGrid.RowCount - R_n, 1) +'). }
                            {'PYSÄHDY/TUTKI NÄMÄ ENSIN [OK], jatkuu mm²="Kaikki" -valinnalla.  OHITA NÄMÄ '+
                             '[Yes]. ' {+typ +'  ' +fImrkt0 (am2,1) +' mm²  R_n=' +fImrkt0 (R_n,1) +
                             '  R_u=' +fImrkt0 (R_u,1) +'  rv=' +fImrkt0 (rv,1) +'  i=' +fImrkt0 (i,1),
                             mtInformation, [mbOK,mbYes,mbCancel], 0);}
                             'Osatulostus, mm² -vaihtoehdot jatkuvat vielä.',  mtCustom,
                             'Pysähdy','Jatka','Peru','',
                             'Pysähtyy katselua varten, jatkuu mm²=Kaikki -valinnalla.','Jatkaa seuraaviin mm²',
                             'Pysähtyy eikä jatka.','');
                            {['Pysähdy','Jatka','Peru'],
                             ['Pysähtyy katselua varten, jatkuu mm²=Kaikki -valinnalla.','Jatkaa seuraaviin mm²',
                              'Pysähtyy eikä jatka.']);}
         end;
      end;
      case val of
         1 :GOTO 8;
       9,3 :GOTO 9;
         2 :begin
            if ChkR_n(1,6,i)      //<Asetti R_x =Siirtää tarvittaessa.   1=Välirivi  6=OtsNo  i=ArvoRiviTarve
            then begin                 //ZS_Frm.Caption := ZS_Frm.Caption +' tulT(1)Rc=' +fImrkt0(R_u,1);
               asetaZval2;
               rv := R_u-i-1;          //<i tutkittiin, kun TUL oli FA. -1 = koska i oli 1.. ja Row=0..
               Jotsikko (rv,i+2);  end //<Asetti OTS := 6;   rv korjautui tarvittaessa +1. EiKorj 6.2.2 +2=dCu%+dAl%
            else OK := false;          //'Ei haittaa, vaikka jo olisi: Menee 0 -riville aina
            end;          //'+2 =Koska arvorivien jälkeen tulee 1xRivi dCu% + 1xRivi dAl% !!!!!!!!!!!!!!!!!!!!!!!
      end;//case
   end;

if OK  then begin
  LaskeeOdFrm.Refresh;                                                                           //<+6.2.2
//Y_piipit (10);                         //<Kuulee, milloin Refresh, OK.
//am2 :=  Trunc (ala);
  eioo := FALSE;  valmis := FALSE;
  typ := '';
  i := 0;
  REPEAT
    IF NOT seurT (typ)                   //<Kunnes FALSE =TYYPIT LOPPU
    THEN valmis := TRUE                  //<Vikakin veTyyppi oliTulost
    ELSE  IF typAok (typ,am2)            //<Löytyi haluttu am2<<<<<<<<
    THEN BEGIN  i := i+1;                ZS_Frm.Caption := fImrkt0 (i,1) +'  ' +typ +'  ' +fImrkt0 (am2,1);
         {FNC SamaZtyyppi <> (typ='AVOJOHal') or (typ='AVOJOHcu') or (typ='AMKA') or (typ='APAKM*') or
                             fOnSV (typ) or fOnKIS (typ)}       //<'Nämä rajattu vex taulukkoonsijoituksessa.
         if NOT SamaZtyyppi (typ)                               //<,+6.2.2
            then k := 1  else k := 0;//typ := COLOR_SILVER + typ +'</f>';             //<Samapoikkipintatulostssa
         IF tul  then tulJR (k,1,rv+i, typ,am2,L,T); //<Tutkii min/max rivit ja arvot sekä sij. ne BOLDARR´iin.
         IF SamIso (typ,'PLKVJ*') or SamIso (typ,'AMMK*') or SamIso (typ,'MMJ/MMK*') or SamIso (typ,'APAKM*')
            THEN eioo := TRUE;  END;                            //'Valmistus lopetettu, infotaan jälempnä.
  UNTIL  valmis;
  if NOT tul                                                    //<,,Kaikki samaMm²:t on jo käyty => tulostukseen.
  then begin      ZS_Frm.Caption := fImrkt0 (i,1) +'  ' +typ +'  ' +fImrkt0 (am2,1);// +' <<<<<<<<<<<<<<<<<<<<<<<<';
     tul := true;
     GOTO 3;  end
  else begin            //<,,+6.2.2  Eroja ei voi sijoitettaessa tutkia, koska PIENIN arvo saattaa olla JÄLEMPNÄ.
     for k := 6 to ZS_Frm.ZS_StrGrid.ColCount-1  do begin       //<,,Lasketaan + sijoit. suurimmat erot.
         ar := boldArr[FALSE,1,k].arvo;                         //< ISOIMMAN  [,1,] löytyneen Al-arvo vertailuun.
         re := boldArr[FALSE,2,k].arvo;                         //< PIENIMMÄN [,2,] löytyneen Cu-arvo vertailuun.
         if re>0  then
            re := (ar-re)/ar *100;                              //< PIENIMMÄN ero ISOIMPAAN %:na.
         boldArr[FALSE,1,k].ero := re;  end;
     for k := 6 to ZS_Frm.ZS_StrGrid.ColCount-1  do begin       //<,,Lasketaan + sijoit. suurimmat erot.
         ar := boldArr[TRUE ,1,k].arvo;                         //< ISOIMMAN  [,1,] löytyneen Al-arvo vertailuun.
         re := boldArr[TRUE ,2,k].arvo;                         //< PIENIMMÄN [,2,] löytyneen Cu-arvo vertailuun.
         if re>0  then
            re := (ar-re)/ar *100;                              //< PIENIMMÄN ero ISOIMPAAN %:na.
         boldArr[TRUE ,1,k].ero := re;  end;

     rv := R_n-1;
     for k := 6 to ZS_Frm.ZS_StrGrid.ColCount-1  do
     if (boldArr[TRUE ,1,k].ero >0) or (boldArr[FALSE,1,k].ero >0)  then begin
           ss := 'dCu:' +fRmrkt0 (boldArr [FALSE,1,k].ero, 1,2) +'%'; //< FA,1,k =Isoin Cu
           if k IN [15,19]  then ss := '<b>' +ss;                     //<,Boldataan Ze ja Z1 -sarakkeiden erorivit
        ZS_Frm.ZS_StrGrid.Cells[k,rv+1] := ss;
           ss := 'dAl:' +fRmrkt0 (boldArr [TRUE ,1,k].ero, 1,2) +'%'; //< TR,1,k =Isoin Al
           if k IN [15,19]  then ss := '<b>' +ss;
        ZS_Frm.ZS_StrGrid.Cells[k,rv+2] := ss;
     end;
     R_n := R_n+2;
  end;//else +6.2.2
  k := boldArrMax;
  j := ZS_Frm.ZS_StrGrid.ColCount-1; //<Pienempi ColLkm määräävä
  if j<k  then k := j;
                                            //,5=Ohm -sarake, mutta OK.  Nyt 6  +6.2.2
  for j := 6 to k  do begin //,,Cu-kaapelit //<Aloitetaan sar.6 :stä =Eka boldattu sar,  TO = vähempikin riittäisi.
     if (boldArr[FALSE,1,j].arvo>0) and (boldArr[FALSE,1,j].ero>0)  then     //,LIHAVOIDAAN (ISOIMMAT)###########
        ZS_Frm.ZS_StrGrid.Cells[j, boldArr[FALSE,1,j].rivi] := '<b>'   +ZS_Frm.ZS_StrGrid.Cells[j, boldArr[FALSE,1,j].rivi];
     if (boldArr[FALSE,2,j].arvo>0) and (boldArr[FALSE,1,j].ero>0)  then     //,LIHAVOIDAAN (PIENIMMÄT)##########
        ZS_Frm.ZS_StrGrid.Cells[j, boldArr[FALSE,2,j].rivi] := CLR_GRB +ZS_Frm.ZS_StrGrid.Cells[j, boldArr[FALSE,2,j].rivi];
                                                                        ZS_Frm.ZS_StrGrid.Cells[j, boldArr[FALSE,2,j].rivi];
  end;                                                                  //,,''+6.2.2
  for j := 6 to k  do begin //,,Al-kaapelit //<Aloitetaan sar.6 :stä =Eka boldattu sar,  TO = vähempikin riittäisi.
     if (boldArr[TRUE ,1,j].arvo>0) and (boldArr[TRUE ,1,j].ero>0)  then     //,LIHAVOIDAAN (ISOIMMAT)###########
        ZS_Frm.ZS_StrGrid.Cells[j, boldArr[TRUE ,1,j].rivi] := '<b>'   +ZS_Frm.ZS_StrGrid.Cells[j, boldArr[TRUE ,1,j].rivi];
     if (boldArr[TRUE ,2,j].arvo>0) and (boldArr[TRUE ,1,j].ero>0)  then     //,LIHAVOIDAAN (PIENIMMÄT)##########
        ZS_Frm.ZS_StrGrid.Cells[j, boldArr[TRUE ,2,j].rivi] := CLR_GRB +ZS_Frm.ZS_StrGrid.Cells[j, boldArr[TRUE ,2,j].rivi];
                                                                        ZS_Frm.ZS_StrGrid.Cells[j, boldArr[TRUE ,2,j].rivi];
  end;
//ZS_Frm.ZS_StrGrid.Color := clTeal; //<Vain mahd. min.arvojen värien kokeiluun. "65280">' =clLime
  WITH ZS_Frm  DO BEGIN      //i = 1.. =ROW =eka ROW=2 jne
       ZS_InfRv_(1, fZekv_info1 (eioo));
       ZS_InfRv_(2, fZekv_info2);
       ZS_InfRv_(3, fZkaap_info3);
  END;//WITH
  if kaikki  then begin         //<Jos haluttiin listata kaikki mm2:t ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,+6.2.2,,,,,,,
     if SeurA (am2)  then begin
        tul := false;
        alustaBoldArr;
                  ZS_Frm.Caption := fImrkt0 (i,1) +'  ' +typ +'  ' +fImrkt0 (am2,1);// +' @@@@@@@@@@@@@@@@@@@@@@@@';
        GOTO 1;  end;
  end;                          //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''+6.2.2'''''''
end;//if OK
8:
  if kaikki  then begin                       //<,,+6.2.2
     jatkaMm2 := mm2R (am2);                  //<Seur. "Kaikki"-valinnalla jatkaa siitä, mitä ei pääs-
     pienA (am2);                             // syt tulostamaan.
     mm2 := mm2R (am2);
     ss := mm2Rs (am2);                       //<Editoidaan vika TULOSTETTU mm2.
     ZS_Frm.ZS_Mm2Cm.Text := ss;  end;
9:
  typ := AlpTyp; //<+2.0.3
  alustaBoldArr; //<Tyhjennetään varm.vuoosi, jos vaikka jossain muussa ZS_osassa otettaisiin käyttöön
  LaskeeOdFrm.Close;                          //<''+6.2.2
END; //tulA
//==================================================================================================}
{
     mb := mrOK;
     if rv+i+2>RowMax  then
        mb := MessageDlg ('Max.rivimäärä ' +fImrkt0(ZS_Frm.ZS_StrGrid.RowCount - ZS_Frm.ZS_StrGrid.FixedRows,1) +
                          ' ylittyy (vapaana ' +fImrkt0(ZS_Frm.ZS_StrGrid.RowCount - R_n, 1) +'.  ' +
                          typ +'  ' +fRmrkt0 (ala,1,0),
                          mtInformation, [mbOK,mbYes,mbCancel], 0);
     case mb of           //<mrCancel´illa ohittuu
        mrYes :GOTO 1;
        mrOK  :begin i := Trunc (ala);
                     if SeurA (i)  then begin
                        tul := false;
                        alustaBoldArr;
                        ala := i;
                        GOTO 1;  end;   end;
     end;//case
}




