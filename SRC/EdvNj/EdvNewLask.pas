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

unit EdvNewLask;{  Oli enimmältä osin EdvLaskSij26-INC ja/tai Nola26.INC
except ShowMessage('X');
end;//try 2 +120.45T yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
try//2 +120.45T µµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµ
}
interface
uses Globals, Math, SysUtils{Beep}, Classes{TStringList}, Dialogs{ShowMessage jne}; //<Math ArcCos + Tan takia = Vain kokeilussa
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,EdvLaskSij26-INC,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   function LaskeEdvArvotOK (herjakin :integer) :boolean;  //Forward; //Forward +12.0.03 Minkähän takia tässä vaikka kohta on varsinainen koodi ?????
                                                           //'1= herja  0=ei herjaa.
implementation
uses Unit0, Unit1, Y_, Herja1, PaaVal, EdvNew, DetEv{koetulostuksessa PRC sij_PrRjNj}, Winapi.Windows, Koe{12.0.0},
     {12.0.05 gAjoPath}Defs, InfoDlgUnit;

//VAR //nama :TStringList;
    //ohjF :TextFile;           //<Ohjaa PRC LaskeEdvArvotOK´n rivikirjoituksia, mitä rvja kirjoitetaan, tehtävä ETUKÄTEEN:
    //ohjFN,TmpFN :string;            //\\Reijo-xp\e\Projektit XE2\NolaKehi\BIN\$$$EdvLskTmp.txt
{-        a $I '..\GlobINC\EdvLaskSij26.INC'}

{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ EdvLaskSij26-INC }
{-                                                       Oli: Nola26.INC    '=NolaDOS :n Nola6.INC'
 - PRC laskeEdvArvot laskee kaikki EdvFrm:n rivien 6.. arvot ja sijoittaa ne ao.tietorakenteeseen.
 - KAIKKI seur. PRCt ovat pääPRCn laskeEdvArvot sisällä.}

procedure  wru(ss :string);     begin end;(*}VAR f :TextFile;  fn,sn, te,tu :string;
   procedure lueVikaTim (VAR sv :string);     VAR s :string;  SLst :TStringList;  lns :integer;      begin
     {reset(f);                               //Saattais olla nopeampi jos TStrinList.LoadFromFile() ja sieltä Count-1 rvn lukisi SV´hen.
      while not eof(f) do                     //'Ei tosin Readln algor. ollut hidas.
         readln(f,s);
      closefile(f);}
      if fFileExists (fn)  then begin
         SLst := TStringList.Create;
         SLst.LoadFromFile(fn);
         lns := SLst.Count;
         if lns>0  then
         repeat lns := lns-1;                    //<1. = Count-1 .
                s := SLst[lns];
                s := Trim(s);
         until (lns>1) and (s<>'');
         sv := '';
         while (s<>'') and (s[1]<>'>')  do begin
            sv := sv +s[1];  Delete (s,1,1);  end;
         SLst.Free;
      end;
   end;
{  procedure teeFn;      VAR pn,exd :string;  nn :integer;      begin //EiOK:  Tekee joka riviä varten oman fileNime/FILEN.
      pn := gAjoPath +'_EdvNewLsk fUk';      //C:\Projektit XE2\NolaKehi\BIN
      fn :=  pn +'.txt';
      nn := 0;
      while FileExists(fn)  do begin
         nn := nn+1;
         fn := pn +' ' +Ints(nn) +'.txt';
         if fn='!#"¤'  then ;
      end;
   end;}
begin //Erinomainen. Johdot.PAS´sista. +130.0 ...............................
   fn := gAjoPath +'_EdvNewLsk fUk.txt';      //C:\Projektit XE2\NolaKehi\BIN\..
   AssignFile(f,fn);
   lueVikaTim(te);
   if fFileExists (fn)
      then Append(f)
      else Rewrite(f);
   tu := TimeToStr(Now); //<Sadasosasekunnitkin:  DecodeTime(myDate, myHour, myMin, mySec, myMilli);
   if te<>tu  then
      Writeln(f);
   Writeln(f,tu +'>  ' +ss); //<Aikaleiman jälkeen 1. mrk=">" .
   Flush(f);
   Close(f);
end;//*)
procedure  wrq(si :string);     begin end; {VAR f :TextFile;  fn :string;      begin //Erinomainen. Johdot.PAS´sista. +130.0 ...............................
 //fn := gAjoPath +'_EdvNewLsk fqs.txt';      //C:\Projektit XE2\NolaKehi\BIN\..
   fn := gAjoPath +'_EdvNewLsk wrq.txt';
   AssignFile(f,fn);
   if fFileExists (fn)
      then Append(f)
      else Rewrite(f);
   Writeln(f,si);
   Flush(f);
   Close(f);
end;//}
{procedure  wre(si :string);     begin end; {VAR f :TextFile;  fn :string;      begin //Erinomainen.
   fn := gAjoPath +'_EdvNewLsk wre.txt';      //C:\Projektit XE2\NolaKehi\BIN\..
   AssignFile(f,fn);
   if fFileExists (fn)
      then Append(f)
      else Rewrite(f);
   Writeln(f,DateTimeToStr(Now) +'  ' +si);
   Flush(f);
   Close(f);
end;//}
procedure  wr(s1,s2 :string);      begin end; (*VAR f :TextFile;  fn,sa,ss :string;  i,ai :integer;      begin //Erinomainen. Johdot.PAS´sista. +130.0
fn := gAjoPath +'_EdvLsk.txt';
   AssignFile(f,fn);
   if fFileExists (fn)
      then Append(f)
      else Rewrite(f);
   if Trim(s1)<>''  then
      sa := Trim(s1)[1];   SokI(sa,ai);
   sa := '';
   for i := 1 to ai  do sa := sa +'  ';                   //Tehdään sisennyksiä alkunron mukaan á 2x' ', max sis=6x' '.
   i := 8-Length(sa);                                     //<ss väliin ennen eur tekstiosaa =vas suoraksi
   ss := '';
   for i := 1 to i  do ss := ss +' ';
   sa := DateTimeToStr(Now) +sa +'  ';
   Writeln(f,sa +s1 +ss +s2);
   Flush(f);
   Close(f);
end;//*)
procedure DefsFiL(si :string);      begin//+120.5no. 1415d:
  {DefsFileenZ}DebWr(0,'+®+',si);  end;
procedure tyPrc;      begin end; //+8.0.15
function laskeEdvArvotOK (herjakin :integer) :boolean;      VAR fnc :boolean;
   procedure ExcIlmoita(si :string);      VAR sa :string;      begin
      sa := {'Ilmoita valmistajalle VIRHE: }'EdvNewLask.PAS/PRC LaskeEdvArvotOK/ [ ' +si +' ]. Ajo keskeytetään.';
      //ShowMessage (sa);
      InputBox('Leikkaa/kopioi viesti:', 'Ilmoita valmistajalle VIRHE:', sa);
      Halt;

   {  w := InfoDlg (sa, mtError, 'Keskeytä','Jatka','','',  '.','.','',''); //Ei vaan tule näkyviin koko dlg.
      if w=1
         then Halt;}
   end;

 procedure Koe_VrtOikSuo;      VAR suCs,tyyppi :string; //+10.0.1

   function strs (sq :string;  tab :integer) :string;      VAR sx :string;  n :integer;      begin
      sx := sq;
      for n := Length (sx)+1 to tab  do //<MJonon pituus asetetaan 12:ksi.
         sx := sx +' ';
      result := sx;   end;

   procedure Vrt (mm2 :real;  kpl :Integer);      VAR suStM,suSFSa,suSFSb,dA,dB :integer;  ss :string;      begin
      suStM :=  OikSuoj    (suCs,tyyppi,mm2,kpl);    //'StM´stä,  ' SFS´llä laskettu.
      suSFSa := OikSuoSFSt (suCs,tyyppi,mm2,kpl,1);  //<suSFS´llä laskettu.
      suSFSb := OikSuoSFSt (suCs,tyyppi,mm2,kpl,5);  //<5s, '1s
      dA := suStM-suSFSa;
      dB := suStM-suSFSb;
      ss := strs (tyyppi,8) +fRmrkt0 (mm2,3,0) +' mm²  ' +strs (suCs,8) +'  <b>' +fImrkt0 (suStM,4) +
            '</b> A';
      if (dA<>0) or (dB<>0)
      then begin
         ss := ss +'  1s=<b>' +fImrkt0 (suSFSa,5) +'</b> A  d=' +fImrkt0 (dA,5) +'  5s=<b>' +fImrkt0 (suSFSb,5) +
               '</b> A  d=' +fImrkt0 (dB,5) +'  ' +Ints (kpl) +' kpl';
         DetEvFrm.aRich.AddText (ss +'<br>');  end
      else begin
         ss := ss +'  Samat SUL.';
         DetEvFrm.aRich.AddText (ss +'<br>');
      end;
   end;//Vrt

   procedure apuja;      VAR i1s,i5s :real;  sa :string;      begin
       i1s := Ikt_R (su_IECgYR,160,1);   i5s := Ikt_R (su_IECgYR,160,5);  //i1s=poisk.ajalla 1s,  i5s=ajalla 5s.
       sa := su_IECgYR+' 160A Ik= 1s: ' +fRmrkt0 (i1s,4,0) +' A  5s:  ' +fRmrkt0 (i5s,4,0) +' A<br>';
      DetEvFrm.aRich.AddText (sa);
       i1s := Ikt_R (su_IECgAR,160,1);   i5s := Ikt_R (su_IECgAR,160,5);
       sa := su_IECgAR+' 160A Ik= 1s: ' +fRmrkt0 (i1s,4,0) +' A  5s:  ' +fRmrkt0 (i5s,4,0) +' A<br>';
      DetEvFrm.aRich.AddText (sa);
   end;
begin//..............................
  {if IsDebuggerPresent  then begin
      DetEvFrm.aRich.Lines.Clear;
    //DetEvFrm.aRich.Font.Name := 'Courier New';
      DetEvFrm.aRich.AddText ('<f n="Courier New">'); //<Ei worki jos tämä ennen Clear´ia.
            //su_OFAg su_OFAm   su_IECg su_IECgAR su_IECgYR   su_IECd su_IECdAR su_IECdYR
            //   su_OFAg = 'OFAAgG';   su_OFAm =   'OFAMaM';
            //   su_IECg = 'IECgG';    su_IECgAR = 'IECgG-ar';   su_IECgYR = 'IECgG-yr';
            //   su_IECd = 'IECdZ';    su_IECdAR = 'IECdZ-ar';   su_IECdYR = 'IECdZ-yr';
      apuja;
      suCs := su_IECgYR;
      tyyppi := 'AMCMK';
         Vrt (240,1);   Vrt (185,1);   Vrt (150,1);   Vrt (120,1);   Vrt ( 95,1);   Vrt ( 70,1);   Vrt ( 50,1);
         Vrt ( 35,1);   Vrt ( 25,1);   Vrt ( 16,1);
      tyyppi := 'AXMK';
         Vrt (800,1);   Vrt (630,1);   Vrt (500,1);   Vrt (400,1);   Vrt (300,1);
         Vrt (240,1);   Vrt (185,1);   Vrt (150,1);   Vrt (120,1);   Vrt ( 95,1);   Vrt ( 70,1);   Vrt ( 50,1);
      tyyppi := 'AXCMK';
                                                                     Vrt (300,1);
                        Vrt (185,1);                  Vrt (120,1);                  Vrt ( 70,1);
         Vrt ( 35,1);                  Vrt ( 16,1);
      tyyppi := 'MMJ/MMK*'; //Sama 'PLKVJ*')
                                                                     Vrt (300,1);
         Vrt (240,1);   Vrt (185,1);   Vrt (150,1);   Vrt (120,1);   Vrt ( 95,1);   Vrt ( 70,1);   Vrt ( 50,1);
         Vrt ( 35,1);   Vrt ( 25,1);   Vrt ( 16,1);   Vrt ( 10,1);   Vrt (  6,1);   Vrt (  2,1);   Vrt (  1,1);

      suCs := su_IECgAR;//su_IECgYR;
      tyyppi := 'AMCMK';
         Vrt (240,1);
      DetEvFrm.Show;
   end;//IsDeb...}
end;
//==================================================================================================
//==================================================================================================

PROCEDURE sij_NjL;      var Rs,Xs,Zs,qTim,ar :real;  srcja,johja :integer;      begin
   qTim :=  edv.YLE.PoisAika.arvoRea; //<,,Tällä merkitystä VAIN Generaattorin Ik:ssa.              +8.0.8
   johja := edv.YLE.JohtoOsia.arvoInt;
   srcja := edv.YLE.SorceCount.arvoInt;
   if (johja=0) and  NOT edv.Sorc[srcja].Josa.Kuluttaja.arvoBoo  OR
      (johja>0) and  NOT edv.edka[johja].Kuluttaja.arvoBoo
      then qTim := 15;                                                                         //<''+8.0.8
   Zs := Ziks (11,edmaxkpl,NJkinFA,qTim, '',0,0,0,0, Rs,Xs,ar,ar); //<11=Ik1v johto-osan lopussa
   a_putReaa (6001, Rs/3, edv.NjL.yhtRs);                          //<,Jos kutsuisi fZs, ei tarttis /3
   a_putReaa (6002, Xs/3, edv.NjL.yhtXs);   a_putReaa (6003, Zs/3, edv.NjL.yhtZs);

   Ziks (31,edmaxkpl,NJkinFA,qTim, '',0,0,0,0, Rs,Xs,ar,ar); //<3=Ik3v johto-osan lopussa           +6.0.0
//Jos tämä välirivi poistetaan => Invalid BreakPoint condition: sij_PrRjNj, TODETTU, KUMMA !?!?!?
   a_putReaa (6004, Rs, edv.NjL.yhtR1);   a_putReaa (6005, Xs, edv.NjL.yhtX1);
end;

//--------------------------------------------------------------------------------------------------
{,,Voitais nopeuttaa, jos kutsuparamksi LAHTIEN, jostaLähtien lasket. uudelleen, eikäAina alustaAsti.
  ##################################################################################################
  #### Sijoitetaan SARAKKEITTAIN ao.johto-osan ARVO [1..max] tlkoon, jostaCellCol:iin  #############
  #### lähtien ylimm. Frmn rvltä = r23=Pr16/10A, r24=Rj16/10A,  r31..r34=Njn MaxSul/mm2 MaxPit #####
  #### ----- Kun ao.sarakkeen kaikki rivit on käyty (UNTIL r=...), siirrytään seur.sarakkee-   #####
  ####       seen (johto-osaan n), SARAKElaskurina n (until n=krt), RIVIlaskurina em. r=34     #####
  #### !!!!! Em.RIVILASKURILLA r selvitetään , mitä EdvFrmn riviä (r=FrmRiv) KÄSITELLÄÄN. ##########
  ################################################################### '''' #########################
  #### !!!!! r :n alkuarvo 0 muutettu 22:ksi, jotta olisi sama kuin verkkokuvaajassa = +6.2.19 #####
  ##################################################################################################}
PROCEDURE sij_PrRjNj;     CONST vas1=1;  oik2=2;{Palstat 1 ja 2}  NJfa=false;
                          VAR n,r{,u{:1412},drf{,jj{120.5}, maxSu,aA,suA,ct,TUPx,eKpl, s_e,nama,fo,no,{muOh,}maxR :Integer;
                              Pmu{+8.0.7},tim,Lmax,zpeLmax{9.0.1},minA, Zsz,Rsz,Xsz,ar,ur :Real;  suCs,asTap,eTyyp :string;  rec :EdvPalstaType;
                              qs,sa{:1412;},sx :string{130.2e,1412};
   procedure fq (ii :integer);      begin if qs<>''  then qs := qs +' ';  qs := qs +Ints(ii);  end;

   function fZjpe(aA :integer;  Lpit :real) :real;      VAR aR,aX,Za :real;  boo :boolean;      begin
      if aA=0
      then Za := 0
      else begin
           aR := resPok(false,'MMJ',aA,boo) *Lpit;     //<Xp_ind tai Xn_ind´lla samat. Lpit eiSis redusoitu pituusosa MK6´sta laskettuna 2.5²´ksi.
         aR :=  rTkorj(false,aR,50);                   //<FA=Cu. Samat arvot resP, ResN ja res´n FNC´lla.
         aX := Xp_ind('MMJ',aA) *Lpit;                 //<Xn_ind antaa saman.
         Za := Sqrt(Sqr(aR) +Sqr(aX));                 //<Za =PE-johtimen Zpe, jota kasvatetaan seur.PT´lle eteen/takaisinpäin vrkssa tutkien jos eioo kohdalla.
      end;
      result := Za;
   end;
   //,,Uk = Uo*Zpe/Zs , vrt. A2 413.1.3.5 ja Treen AMKK. <=130.2e <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   function fUk(aA :integer;  muP,Zks,Lpit :real) :real;      VAR  aV, Za, fnc :real;        begin
      Za := fZjpe(aA,Lpit);
      if muP>0                                      //<'Nyt Zpe lasketaan VAIN jakokeskukselle asti.
         then aV := 231                             //<Lääk.tiloissa 231V.  ,,ELSE Norm. Pr ja Rj´n Uk´n laskentaan.
         else aV := fUv;
      if Zks=0
         then fnc := 0
         else fnc := Av*Za/Zks;                     //,Tämä kirjoittuu fileen siis UK -kutsusta.
          //wre('  Fuk:  Uv*Zpe/Sks= ' +fRmrkt0(Av,1,0) +'*(Za)' +fRmrkt0(Za,1,4) +'/' +fRmrkt0(Zks,1,4) +' =' +fRmrkt0(fnc,1,4));
      result := fnc;
   end;//fUk

   function _sI(s :string;  ii :integer) :string;      begin result := ' ' +s +Ints(ii);  end;
   function _sR(s :string;  rr :real) :string;         begin result := ' ' +s +fRmrkt0(rr,1,4);  end;
   procedure wre_(oh :integer;  sOs :string;  aA :integer;  Pmu,Zsz,pituus,Quk  :real);     begin end;  {VAR s,sP,aC :string;  i :integer;  Zj,Av :real;  begin
      Zj := fZjpe(aA,pituus);
      if Pmu>0                                      //<'Nyt Zpe lasketaan VAIN jakokeskukselle asti.
         then aV := 231                             //<Lääk.tiloissa 231V.  ,,ELSE Norm. Pr ja Rj´n Uk´n laskentaan.
         else aV := fUv;                            //######################################################################################################
    //uk := fUk(aA,Pmu,Zsz,pituus);                   //<,,##################### GLOBAALEJA (pitäisi olla pvitettyjä ENNEN tänne kutsua.######################
      sP := '---';
      if Pmu>0  then sP := fRmrkt0(Pmu,1,1);
      for i := Length(sOs) to 9  do                 //                         aA,Pmu,Zsz,(Qpit),(Quk nyt lasketaan täälä myös)
          sOs := sOs +' ';                          //######################################################################################################
      s := sOs;                                     //<,Jos 0 => vain otsikko näkyviin omaksi rivikseen.
      aC := 'mm²';  if aA<4  then aC := '.5' +aC;
      if oh>0  then s := s +'fo=' +Ints(fo) +' r' +Ints(r) +' Josa=' +Ints(n) +' no' +Ints(no) +' Pmu=' +sP +' L=' +fRmrkt0(pituus,1,1) +' Zsz=' +fRmrkt0(Zsz,1,4) +
                         ' (Av)' +fRmrkt0(Av,1,0) +'*(Zjpe)' +fRmrkt0(Zj,1,4) +'/(Zks)' +fRmrkt0(Zsz,1,4) +' => uk=' +fRmrkt0(Quk,1,2) +' aA=' +Ints(aA) +aC;
      if r<32  then wre(s); //>Jottei turhaan tulosteta NJ´n laskentoja.
   end;//wre_  'Jos oh=0, vain nimiots kirjoitetaan.}
   procedure  wrn(LF :integer;  si :string);     begin end; {VAR f :TextFile;  fn,s :string;      begin //141.1  ar := ReadEdvJohto().RyhmaJohto[x].rjpituus[2].uk; Johto.PAS/Err selvittelyyn
      fn := gAjoPath +'PrRvtLsk.txt';      //C:\Projektit XE2\NolaKehi\BIN\..
      AssignFile(f,fn);
      if fFileExists (fn)
         then Append(f)
         else Rewrite(f);
      s := '';
      if (si<>'')  then s := DateTimeToStr(Now);
      s := s +'  ' +si;
      Writeln(f,s);
      if LF>0  then Writeln(f,'');
      Flush(f);
      Close(f);
   end;//}                                                  //,     #####################################################################################
                                                            //,,1412: Näköjäänn jokaisen Josan takia lasketaan KAIKKIEN Josien kaikki palsta-arvot, !!!!!
BEGIN//sij_PrRjNj,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//'     eikä pikaisesti ainakaan löydy mahista OSOITTAA suoraan tiettyä Josaalaskettavaksi.!!
s_e := 0;                                                   //      Koklaus,, n := 0 tilalle n := Edi-1  aiheuttaa "acces vioilations" virheen [2]BtnClick'llä.
if edi>0  then ;                                            //,     #####################################################################################
REPEAT s_e := s_e +1;  //<UNTIL s_e=2                       //< s_e:  1=Käsitellään Sorc[]  2=Edka[]              //    Header
   if s_e=1  then nama := a_getIntg (6051,edv.YLE.SorceCount) //...edLmaxKpl                                      // r  PanRv  RvOtsikko
             else nama := a_getIntg (6052,edv.YLE.JohtoOsia); //...edMaxKpl;                                      // 23  23    Pistor Dz 0.4s 16/10A
   n := 0;   aA := 0; //< aA sij. debugg./breakpointin takia UNTIL jälkeen                                        // 24  =            jkB
   if nama>0  then    //<Ei saa päästää silmukkaan jos johto-osia=0, todettu. +6.2.2                              // 25  =            jkC
   REPEAT //<:::::::::::::::::::::::::: n=JohtoOsa-/SARAKELASKURI n+1..UNTIL n=nama ::::::::::::::::              // 26  =            jkD
      n := n+1;                                                                                                   // 27  =     Ryhmäj. Dz 5s 16/10A
      if s_e=1  then begin  rec := edv.Sorc[n].josa;  fo := -1*n;  end                                            // 28  =            jkB
                else begin  rec := edv.edka[n];       fo := n;     end;                                           // 29  =            jkC
   //###############################################################################################              // 30  =            jkD
   drf := 22;   //<Sij. vain tässä. DRF käytetään taulukon osoitukseen jälempnä, esim. ...[r-drf]...+6.2.19       // 31  =     Lääkintä...
   r := drf;    //< r=22..##########################################################################              // 32  =
                  sa := '';  if s_e=1  then sa := '0';  sa := sa +Ints(n); //<,+1412
                  sx := '';//if r<10   then sx := ' ';        //,sx oikoo loppurvn oikSuoraksi.
                  ZaoFileen('==========!!!!========J-osa ' +sa +sx +' resRvien palsta:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::');
                //############### Panrv =RiviNo SAMA KUIN VERKKOKUVAAJAN PANELIN RIVINO, ###########              // jne...
                //############### eka =6(r=23), vika =35 mutta 43 koska LääkRv:llä 4 arvoa.#########
   //###############################################################################################
   IF rec.OnArvot  THEN     //<Syotto.PAS :ssa := TRUE #############################################
   REPEAT r := r+1;  //<::::::::::::::: RIVILASKURI r+1..UNTIL r>=maxR{43}.:::::::::::::::::::::::::
          Panrv := r; //<ZaoFileen varten +1412.
          if r=32
             then r := 39; //<'1412: => Eka laskettva tämän jälkeen (r)rv=39.  ZaoFileistä  huomatttu, ettei rvjä 32..38 käytetty mihinkään, koklattu.
          if r>=40{39}  then
             Panrv := r-8;
//try//1 +120.45T µµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµ
    //Yrv := Yrv+1;                     //< Yrv laskee vain riviLUKUmäärää 1 ... UNTIL, vain debuggerille. +10.0.1
      case r of    //ResurssiRivien [tod.osoitteet] = r-drf =1..21.  1412: Nyt r=31..37 ei enää ole, ks. alkusijoitus if r=.. then r :=..
         23,27,32,36 :suCs := su_IECd;  //<   (Pr 0.4s 16/10A)  Dz-tyypin sulakkeella <<<<<<<<<<<<<< Dz +6.2.0       => r=32 =gG
         24,28,33,37 :suCs := 'B';      //<           lasketaan B-tyypin johdnsuojakatk.<<<<<<<<<<<< '27 +8.0.8
         25,29,34,38 :suCs := 'C';      //<                     C-tyypin johdnsuojakatk.<<<<<<<<<<<<
         26,30,35,39 :suCs := 'D';      //<                     D-tyypin johdnsuojakatk.<<<<<<<<<<<<
                  31 :suCs := 'C';      //<                     C-tyypin johdnsuojakatk.<<<<<<<<<<<< +8.0.7
         else   suCs := suCse;  END;      //<    Muuten lasketaan IECgG tai OFAAgG-tyypeillä<<<<<<<<''10.0.1 kaikki chk.
//,,###################### Lasketaan Pr/Rj/Nj pit + Sul + TUP ######################################,,,,,,,,,,,,,,
{ ,,Entiset NjPit rivit 31..35 ovat MUUTTUNEET, nyt 40..43    10.0.1:                  ############# < 10.0.1
    ####################'''''' r=31 lääkintämuuntajan RjPit, samalla rvllä 4 arvoa.    ############# < 10.0.1
    ########>>>#########      32-35 DetEv:n 0.4s 10A:n 2.5mm²(=HUOM) Dz..JkD rjPituudet#####<<<##### < 10.0.1
    ####################      36-39 - " -     5s - " - - " -  .........................############# < 10.0.1}
      if r IN [27..30,36..39,41,43]                                                                //< 10.0.1
                            then tim := 5
                            else tim := fPoiskAikaRaja;                       //,Just edellä TIM sai arvon mutta
      if r=23               then tim := a_getReaa (10, Edv.YLE.PRaika);       //<tämä välttämätön. +8.0.8
      if r IN [42,43]       then asTap := UpperCase ('o')                     //<OikosSuojaus = iso "o", ei nolla.
                            else asTap := 'A';                                //'10.0.4
      if r IN [40..43]      then begin         //Edv :n NJ -resurssit.        //< 31..34 >= 32..35 =8.0.7  120.4m/6U:  43= panelinRvNo 35 = vika kuvaajan rv.
                               ct := a_getIntg (6017, rec.Lampotila);                                    //'#################################################
                               aA := Trunc (a_getReaa (6018, rec.Amm2));      //<Pyor->Trunc 6.2.16
                               eKpl := a_getIntg (6019, rec.Lukumaara);       //'2.5:stä tuli 3 !!!      //case Indx of        PrRjMm2Bx´n PudValikon itemit:
                               eTyyp := a_getStrg (6020, rec.Tyyppi);                                    //   0 = '16A2.5/10A1.5 mm²';   <= Sul,Mm2
                               case r of                                                  //<,,+8.0.8    //   1 = '10A 2.5/1.5 mm²';        - " -
                                 40,41 :case EdvNewFrm.BxAsT.Text[1]  of                  //<,,+8.0.11   //   2 = '6A  2.5/1.5 mm²';        - " -
                                        'A' :MaxSu := pyor (rec.arvo [arvo_SUL_YLIV_A_7]);               //   3 = '4A  2.5/1.5 mm²';        - " -
                                        'C' :MaxSu := pyor (rec.arvo [arvo_SUL_YLIV_C_8]);               //   4 = '2A  2.5/1.5 mm²';        - " -
                                        else MaxSu := pyor (rec.arvo [arvo_SUL_YLIV_D_9]); {'D'}end;     //   5 = '4 mm² 16A/10A';          Mm2,Sul
                                 42,43 :MaxSu := pyor (rec.arvo [arvo_SUL_MAX_5s_5]);  end;              //   6 = '6 mm² 16A/10A';
                            end                                                                          //   7 = '10 mm² 16A/10A';
      {r = 23..31}          else begin                                                                   //   8 = '16 mm² 16A/10A';  end;
                               PrRj_SulMm2 (PrRjIndx,1, maxSu,aA); //<+130.0 Palauttaa PrRjMm2Bx/Index´in mukaiset SUL ja MM²  PALSTA 1=Vasen(ennen "/")
                               ct := 50;     //<Ryhmäjohdoille r=23..31  'maxSu=10A VAIN kun jj=2.                             PALSTA 2=Oikea(      "/" jälkeen).
                               eKpl := 1;    //,eTyyp='' TUNNISTUU RYHMÄJOHTOLASKENTA PRC laskeRJpit :ssa.
                               eTyyp := '';  //       <> =Edv:n johdon resurssilaskenta, ks. ed. r IN [32..35].
                             //''''''''''''#######################################################################
                             //''''''''''''#######################################################################
                            end;                                   //,+10.0.1: DetTulostuksen 10A/2.5mm² 0.4 ja 5s.
      if r IN [32..39]      then begin maxSu := 10;  aA := 2;  end;//<[os]: 10,11,12,13, 14,15,16,17
                                                                   //'  'r: 32 33 34 35  36 37 38 39
                                                                   //,,Lääk.tilan muuntjn jälk. rj.,,,,,,,,,,,,,,,
      if r=31
         then begin Pmu := Edv.YLE.LaakPmu.ArvoRea; end            //<,Muuntajateho, ks. myös jälempnä +8.0.7, 130.2e: 2=>Nyt valittavissa.
         else begin Pmu := 0;  end;                                // muOh= 1 Z=1xL  t. 2=2xL, ks.myös jälempnä. 'muOh´t ei eroa.
      if r IN [23..30]  then                   //<23-26=Pr 0.4s,  27-30=Rj 5s <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
         PrRj_SulMm2(PrRjIndx,vas1, maxSu,aA); //<+130.0:  PrRj_SulMm2 (Inx,Palsta :integer;  VAR Sul,Mm2 :integer);
      //,@@@@@@@@@@@ LääkMuunt:lla 2.5mm² 16A 2 kVA (2j) -tapaus,,,,,,,,,,,,,,,,,,,,,,,,,,@@@@@@@@@@@@@@@@@@@@@@@@@
      //,@@@@@@@@@@@ Pr+Rj -riveillä "/":n  VASEN PALSTALLE tuleva 16A(2.5mm2) max.pituus @@@@@@@@@@@@@@@@@@@@@@@@@ LääkMuunt. 1/4.
//===========================================================================================================================================================
//,,VASEN PALSTA r23..30=PistorResurssit, missä testerinäyttämävaatim.=======================================================================================
//===========================================================================================================================================================
Qsij := 1;  (*u := r;
            if r>=40{39}  then u := r-8; //<+1412:  Poistettu turhat laskennat kun r =32..38. U viedään LakeRJpit /ZaoFileen. Tarve vain tässä ekassa kutsussa.*)
      sx := '';  if s_e=1  then sx := '0';         //<Liittymäjohson tunnus '0' eteen.
      sx := '1.r'+Ints(r) +'/[' +sx +Ints(n) +']';
{1.}  laskeRJpit (sx, NJkinFA, fo,maxSu,ct,tim, aA,Pmu,eKpl,eTyyp, suCs,asTap, minA,Lmax,zpeLmax, suA,TUPx);     //< (r=31) and (_<>' LääkM 1/4 ')
                 //'Tämä kutsu AINA=KAIKILLE, sijoitus jälempnä valitaan verkkokuvaajan ao. rivin mukaan.
                 //'1rX tule näkyviin vain PRC laskeRJpit´ssa olevasta ZaoFileen -kutsusta= +1412.
                             {if (r IN [23,28]) and (n=1)  then DetEvFrm.aRich.Lines.Add ('n=' +fImrkt0(n,1)   +' r='+fImrkt0(r,1) +' maxSu='+fImrkt0(maxSu,1)
                             +' ct='+fRmrkt0(ct,1,1) +' tim='+fRmrkt0(tim,1,1) +' aA='+fImrkt0(aA,1) +' suCs='+suCs +' asTap='+asTap +' ### minA='+fRmrkt0(minA,1,1) +
                             ' Lmax='+fRmrkt0(Lmax,1,1) +' suA='+fImrkt0(suA,1) +' TUPx='+fImrkt0(TUPx,1));  DetEvFrm.Show;}
Qsij := 0;
      maxR := 43{35{34};   //,-4=NousujohtoResurssirivit ELSE´ssä jälempnä.  10.0.1: 43=35+DetRvt8.  901: 34=>35.
                             wre_(0,'1v.LaskeRj_PRC',0,0,0,0,0);  if n>0  then ;
                           {,|############|}
{23..}IF r<=maxR-4 //r<=39 //|# r=23...39 #|   [no]: 10,11,12,13, 14,15,16,17 =DetTiedot 16/10 2.5² <,+10.0.1
      THEN BEGIN           //|# no=1...17 #|      r: 32 33 34 35  36 37 38 39 (>=40=NjPit).   ks. UNTIL r>=maxR
{1..}    no := r-drf{22};  //'#############|           //r31= LääkMu aina 2.5mm², tässäkinOlisi OKmutta varmVuoksi.
         qs := 'r=' +Ints(r) +' no=' +Ints(no);        //,    Edellä laskettiin 2 kVA (2j) -tapaus, nyt (1j).  130.2e: Ei enää, nyt myös 6mm²/1j´ssä.
//===========================================================================================================================================================
//,,VASEN PALSTA:============================================================================================================================================
//===========================================================================================================================================================
               if r=31     //,,LääkMuuntajarivi(31), VASEN palsta:  234m34.5V / ......... §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
               then begin
                    with rec.RyhmaJ_r31[1].rjpituus[1]  do begin //<,Tässä sijoitetaan 1. laskeRJpit:n tulokset.
                         fq(31);
                               wre_(0,'31v$j ---------..',0,0,0,0,0);
                            Zsz := Ziks_a(11,fo, 0{PEk},NJfa,Tim, 'MMJ',aA,Lmax, Pmu, 1{QJkpl},ct, Rsz,Xsz, ar,ar); //<'Nyt ketjuun mukaan Lmax => Zs.
                          Zsz := Zsz/3;          //<Per 3, koska mukana Z1+Z2+Z0. Tarkistettavissa: Aseta 01-jOsan L=0, jolloin uk po. Uo/2~115V !!!!!!!!!!!!
                            uk := fUk(aA,Pmu,Zsz,Lmax);                                //,Lmax/2 koska Lmax oli 2xPr rinnakkain MK6 -suojajohtimineen.
                               if uk>=0
                                  then ;
                               wre_(0,'  31v$j ---------..',aA,Pmu,0,Lmax,uk);         //'fUk´lle se Lmax ja Zs jolle kokonais-Lmax oli laskettu.
                            Lmax := Lmax/2;                      //Laµ=2.5mm²´n pituus,  Lbµ=6mm²´n pituus;  6/2.5=2.4;  2.4xLaµ-u = Laµ+u => u=0.7xLaµ
                            ur := 0.7*Lmax; //YhdMukaistetaan=redusoidaan pituudet samoiksi = La po.= Lb; => La := Laµ+u ja Lb := Laµ-u == VAIN JompKump käytet.
                            //''Nyt ei tarvitse tulostaa kuin yksi pituus koska 6mm²´n pituus on redusoitu samaksi. Laskenta tehty 2.5´n mukaan ja 6mm² las-
                            //  kettu 2.5/6´n suhteessa ja siitä edelleen redusoitu kummatkin samanmittaisiksi, KS. EDELLÄ =130.2e.
                       //ar := resPok(false,'MMJ',aA,boo) *Lpit;                       //<Samat arvot resP, ResN ja res´llä. 'muP ilmaisee lääkPr.
                         pituus := {1;//}Lmax +ur; //<HYVÄ indikaattori (tai r):  ao. sarake erottuu kuvassa HYVÄSTI.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                         pitZpe := {1;//}zpeLmax;                                      //'Tässä +ur NÄYTETTÄVÄKSI.  <Ei koskaan Lmax<>zpeLmax
                           wrn(0,'1 LskNr(1,2,3)=2 Palsta=1  rv=' +Ints(r) +' RyhmaJ_r31[1].rjpituus[1].uk=' +fRmrkt0(uk,4,1) +'  fo=' +Ints(fo));
                         TUP :=    TUPx;                                               //'+141.1
                               wre_(1,'  31v$j',aA,Pmu,Zsz,pituus,uk);
                               if uk>=0
                                  then ;
                    end;//with [1].[1]
                           {FUNCTION Ziks_a(OHJ :Integer;  asti :Integer;  PEk :real;  NJkin :boolean; //<,FNC = KOKON.Zk: YhtOhm. Uusitt 6.2.2
                                            TIM :real;  QJtyp :string;  QJmm2,QJpit,muP :real;  QJkpl,QJlampot :integer;       //§u§ mu_=+8.0.7
                                            VAR  Rsz,Xsz,LszKer,Lsz :real) :Real;      //<LszKer=Kerrottuna yhden kaapln Rv..yms. antaa
                                            //'TIM merkitystä vain kun 40 tai 41        'maxZ:n arvot.### Lsz=MaxZ -pisteen etäisyys alusta.
                                            //'i kun GENER.LIITTYMÄ.                   muP=LääkMuuntajan teho[kVA]. }
//,,rv31´n OIKEA PALSTA:=====================================================================================================================================
                    Pmu := 7.5;
                    sx := '';  if s_e=1  then sx := '0';         //<Liittymäjohson tunnus '0' eteen.
                    sx := '2.r'+Ints(r) +'/[' +sx +Ints(n) +']';
{2.}                laskeRJpit (sx, NJfa, fo,maxSu,ct,tim, aA,Pmu,1{kpl},'', suCs,asTap, minA,Lmax,zpeLmax, suA,TUPx);
                                            //,,Juuri laskettu Lmax lasketaan nyt Zs -ketjuun mukaan. Rsz,Xsz´ssa huomioitu kokonaisuus 2,5mm²´lla laskettuna.
                            wre_(0,'31o$j ---------..',0,0,0,0,0);
                            wre_(1,'  32o$PRC',aA,Pmu,Zsz,Lmax,0);
                    with rec.RyhmaJ_r31[1].rjpituus[2]  do begin //<,Tässä sijoitetaan äsk. laskeRJpit:n tulokset.  //, rr,rr, ar,ar Ei onaa.
                         fq(32);
                            Zsz := Ziks_a(11,fo, 0{PEk},NJfa,Tim, 'MMJ',aA,Lmax, Pmu, 1{QJkpl},ct, Rsz,Xsz, ar,ar); //< Nyt ketjuun mukaan Lmax => Zs.
                          Zsz := Zsz/3;          //<Per 3, koska mukana Z1+Z2+Z0. Tarkistettavissa: Aseta 01-jOsan L=0, jolloin uk po. Uo/2~115V !!!!!!!!!!!!
                            uk := fUk(aA,Pmu,Zsz,Lmax); //$3                           //<fUk´lle se Lmax ja Zs jolle kokonais-Lmax oli laskettu.
                               if uk>=0
                                  then ;
                            Lmax := Lmax/2;                                            //<Koska Lmax oli 2xPr rinnakkain MK6 -suojajohtimineen.
                            ur := 0.7*Lmax;                      //Yhdmukaistetaan=redusoidaan pituudet samoiksi = La po.= Lb; => La := Laµ+u ja Lb := Laµ-u
                          pituus := {3;//}Lmax +ur;              //<+130.2e: Yhdmukaistettu kuten VAS-puolen r=31 tapauksessa (nyt vähentäen, OK).
                        //pituus := rec.RyhmaJ_r31[1].rjpituus[1].pituus;
                          pitZpe := {3;//}zpeLmax;               //'3 HYVÄ indikaattori (tai r):  ao. sarake erottuu FRM:ssa HYVÄSTI.!!!!!!!!!!!!!!!!!!!!!!!!
                           wrn(1,'2 LskNr(1,2,3)=2 Palsta=2  rv=' +Ints(r) +' RyhmaJ_r31[1].rjpituus[2].uk=' +fRmrkt0(uk,4,1) +'  fo=' +Ints(fo));
                          TUP :=    TUPx;
                            wre_(1,'  32o$j',aA,Pmu,Zsz,pituus,uk);
                            if uk>=0
                               then ;
                    end;//with [1].[2]
               end//''Oli r31
//''Oli rv31´n OIKEA PALSTA:=================================================================================================================================
//,,rvt 23..30 VASEN PALSTA:=================================================================================================================================
               else if r<=30                                      //,,=======================================================================================
               then begin                                         //,,====================Tässä sijoitetaan 1. laskeRJpit:n tulokset. =======================
                    Pmu := 0;                                     //,,=======================================================================================
                    with rec.ryhmaJohto[no].rjpituus[1]  do begin
                    fq(1);
                      PrRj_SulMm2 (PrRjIndx,vas1, maxSu,aA);      //<+130.0  Kylläkin turha, koska 1.LaskeRJpit´n jälkeen voimassa, mutta ymmärretvpi näin.
                      Zsz := Ziks_a(11,fo, 0{PEk},NJfa,Tim, 'MMJ',aA,Lmax, Pmu, 1{QJkpl},ct, Rsz,Xsz, ar,ar); //<'Nyt ketjuun mukaan Lmax => Zs.
                      Zsz := Zsz/3;             //<Per 3, koska mukana Z1+Z2+Z0. Tarkistettavissa: Aseta 01-jOsan L=0, jolloin uk po. Uo/2~115V !!!!!!!!!!!!
                         uk := fUk(aA,Pmu,Zsz,Lmax);//$2
                      pituus := {2;//}Lmax;      //<HYVÄ indikaattori (tai r):  ao. sarake erottuu FRM:ssa HYVÄSTI.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                         wre_(1,'  2v$',aA,Pmu,Zsz,pituus,uk);
                         wrn(0,'3 LskNr(1,2,3)=1 Palsta=1  rv=' +Ints(r) +' ryhmaJohto[' +Ints(no) +'].rjpituus[1].uk=' +fRmrkt0(uk,4,1) +'  fo=' +Ints(fo));
                      pitZpe := {2;//}zpeLmax;
                      TUP :=    TUPx;
                    end;//with[no].[1]
//===========================================================================================================================================================
//,,OIKEA PALSTA:============================================================================================================================================
//===========================================================================================================================================================
                  PrRj_SulMm2(PrRjIndx,oik2, maxSu,aA); //<+130.0:  PrRj_SulMm2 (Inx,Palsta :integer;  VAR Sul,Mm2 :integer);
                  //,@@@@@@@@@@@ LääkMuunt:lla 2.5mm² 16A 2 kVA (1j) -tapaus,,,,,,,,,,,,,,,,,,,@@@@@@@@@@@@@@@@@@@  130.2e: Nyt asetettiin LaakMBx´ssa.
                  //,@@@@@@@@@@@ Pr+Rj -riveillä "/":n OIK.PUOLEINEN =10A(1.5mm2):n max.pituus @@@@@@@@@@@@@@@@@@@
                  sx := '';  if s_e=1  then sx := '0';         //<Liittymäjohson tunnus '0' eteen.
                  sx := '3.r'+Ints(r) +'/[' +sx +Ints(n) +']';
{3.}              laskeRJpit (sx, NJfa, fo,maxSu,ct,tim, aA,Pmu,1{kpl},'', suCs,asTap, minA,Lmax,zpeLmax, suA,TUPx);            //< (r=31) and (_<>' LääkM 2/4 ')
                              wr('2.LaskeRj_PRC', '    no=' +Ints(no) +' r=' +Ints(r) +' maxSu=' +Ints(maxSu) +' Ct=' +Ints(ct) +' tim=' +fRmrkt0(tim,1,1) +
                                 ' aA=' +Ints(aA) +' suCs=' +suCs +' Lmax=' +fRmrkt0(Lmax,1,1));
                         wre_(0,'2.LaskeRj_PRC',0,0,0,0,0);
                  with rec.ryhmaJohto[no].rjpituus[2]  do begin //<,Sijoitetaan "/" jälkeinen 2. laskeRJpit:n tulokset riveille 23..30.
                      fq(2);  Zsz := Ziks_a(11,fo, 0{PEk},NJfa,Tim, 'MMJ',aA,Lmax, Pmu, 1{QJkpl},ct, Rsz,Xsz, ar,ar); //< Nyt ketjuun mukaan Lmax => Zs.
                       Zsz := Zsz/3;          //<Per 3, koska mukana Z1+Z2+Z0. Tarkistettavissa: Aseta 01-jOsan L=0, jolloin uk po. Uo/2~115V !!!!!!!!!!!!
                         uk := fUk(aA,Pmu,Zsz,Lmax); //$3
                       pituus := {6;//}Lmax;    //<HYVÄ indikaattori (tai r):  ao. sarake erottuu FRM:ssa HYVÄSTI.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                         wre_(1,'  3o$j',aA,Pmu,Zsz,pituus,uk);
                       pitZpe := {6;//}zpeLmax; //4
                      wrn(1,'4 LskNr(1,2,3)=3 Palsta=2  rv=' +Ints(r) +' ryhmaJohto[' +Ints(no) +'].rjpituus[2].uk=' +fRmrkt0(uk,4,1) +'  fo=' +Ints(fo));
                       TUP :=    TUPx;
                  end;//with[no].[2]
               end;//else if r<=30
      END//r<=maxR-4 = <=39 ,,,Nousujohdot no = 1..4 ALIMMAT RIVIT ==========================================================================================
      ELSE begin  no := njohto_MAX_4 -(maxR-r);       //<Tänne SUORAAN kun r>maxR-4 eli r>39 =40..43  (no=1..4)  =Vain YKSI laskeRJpit -kutsu = 1x jo ALUSSA.
          fq(4);  qs := qs+'/no' +Ints(no);            //                                ''''''''''''
          with rec.nousuJohto[no]  do BEGIN //< r-rj.., koska ..nousuJoh[1..Max(4)].
                       sulake := suA;
                       IF minA<25  THEN mater := false  ELSE mater := TRUE;
                       Amm2 := minA;
                       pituus := {7;//}Lmax;       //<HYVÄ indikaattori (tai r):  ao. sarake erottuu FRM:ssa HYVÄSTI.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                       pitZpe := {7;//}zpeLmax;
                       TUP :=    TUPx;
                         wre_(1,'  9$',aA,Pmu,{Zsz}0,pituus,0);
          END;//with
      end;
//except ExcIlmoita('1# Virhe RJ-pituuslaskennassa');  end;//try 1 +120.45T yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
                        wrq(qs +' n' +Ints(n));
                           if rec.JkUps.ArvoInt=0  then sx := ' / Eioo UPSia.'  else sx := ' / OnUPSi <<<<<<<<<<<<<<<<<<<<<<<<<';
                           ZaoFileen('-----Until: r(' +Ints(r) +')>=maxR(' +Ints(MaxR) +')' +sx); //<Kuvaa hyvästi kuinka R 'juoksee' ohi jos ei UPSia.
   UNTIL r>=maxR{43}; //<::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
                           sa := '';  if s_e=1  then sa := '0';  sa := sa +Ints(n); //<,+1412
                           sx := '';//if r<10   then sx := ' ';        //,sx oikoo loppurvn oikSuoraksi.
                           ZaoFileen('==========!!!!========J-osa ' +sa +sx +' resRvien palsta valmis.:::::::::::::::::::::::::::::::::::::::::::::::::::::' +Chr(10));
         fq(5); if s_e=1  then edv.Sorc[n].josa := rec
                          else edv.edka[n] :=      rec;
         if (aA<0) or (r<-99)  then ;       //Että debuggeri näyttäisi aA:n break´issä.
   UNTIL n=nama; //<n=Johto-osien lkm. ::::::::::::::::: SARAKELASKURI n+1..UNTIL n=.. ::::::::::::::::::::::::::::::::
                 fq(6); wrq(qs);
UNTIL s_e=2; //< 1=Src  2=Edka
             //if (r<-99) or (aA<0)  then sysutils.beep;     //<Ettei:  ..never used. -130.2e
END;//sij_PrRjNj;
//--------------------------------------------------------------------------------------------------
PROCEDURE laskeIkSulOK;                   //######## LASKEE JA SIJOITTAA kaikki sulake- ym. arvot. Olisi ########
   CONST Tim_0=0;
   VAR s_e,os,ou,nama,fo,f_, edja,        //######## mahd. nopeampi, jos päivitettäisiin vain aoLAHTIEN. ########
       j,k,ai, edSulN,SulN  :Integer;     //#####################################################################
       ikEdKaap,tim :Real;                //' s_e = kertoo, ollaanko sijoittamassa 1=Sorc[]  vai  2=Edka[]
       ar,rr,aa,RD,RT  :real;             //<RD,RT =+10.0.3
       rec :EdvPalstaType;  //sd :string;
     //su :string{0120.45};

   PROCEDURE sijSul (ao :Integer;  VAR reg :EdvPalstaType);
         VAR tyyp :string;   korj,mm2 :real;  lkm,ii :integer;      BEGIN

      korj := a_getReaa (6031, reg.korjaus);
      tyyp := a_getStrg (6032, reg.tyyppi);
      mm2 :=  a_getReaa (6033, reg.Amm2);
      lkm :=  a_getIntg (6034, reg.lukumaara);
                                                 ii := OikSuoj ({'G'}suCse,tyyp,mm2,lkm);
      reg.arvo [arvo_SUL_OIKOS_6] {OikSul} := ii;  ii := pyor (YvSuoj ({'G'}suCse,FALSE,FALSE,'A',korj,tyyp,mm2,lkm));
      reg.arvo [arvo_SUL_YLIV_A_7]{YvSulA} := ii;  ii := pyor (YvSuoj ({'G'}suCse,FALSE,FALSE,'C',korj,tyyp,mm2,lkm));
      reg.arvo [arvo_SUL_YLIV_C_8]{YvSulC} := ii;  ii := pyor (YvSuoj ({'G'}suCse,FALSE,FALSE,'D',korj,tyyp,mm2,lkm));
      reg.arvo [arvo_SUL_YLIV_D_9]{YvSulD} := ii;
   END;//sijSul
//..........................................
   FUNCTION Ik3_v (ohj,os :integer) :real;      VAR ar,ir :real;      begin
      ir := Ziks (ohj ,os,NJkinFA,Tim_0, '',0,0,0,0, ar,ar,ar,ar);
      ir := iks (Ik3vTR, os, ir);
      Result := ir;
   END;                        //3' =osJohdn Lopussa <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//..........................................
   FUNCTION Ik3_tim (ohj,os :integer;  tig :real) :real;      VAR ar,ir,rr{,aa} :real;      begin   //+6.2.0  6.2.2
      rr := Ziks (ohj, os,NJkinFA,tig, '',0,0,0,0, ar,ar,ar,ar);                                  //OHs..+6.2.2
                                            KoeWInfo ('  1/2 fIk3_tim Zt=' +fRmrkt0(rr,1,6) +' oh=' +Ints(ohj), 0);
      ir := iks (Ik3vTR, os, rr);                             //< =Ik3v ×V¨[(m+n)*t].  m=fnc()  n=1.
                                            WrKoeF ('Ik3_tim:  Ziks=' +fRmrkt0(rr,1,6) +'  Ik3_tim=' +fRmrkt0(ir,1,2));
      Result := ir;
                                                              //,,12.0.0: Tällä päästiin Ziks´in tarkistukseen, nyt antaa
{WrNyt := true;                                               //          saman Z-arvon =AIKAISEMPI VIRHE NYT KORJATTU.
      ar := Ziks (41,2,NJkinFA,tig, '',0,0,0,0, ir,rr,aa,aa); //< 30=Ik3v johdn alussa.  6.0.0 ao-1 Korj 6.2.2
      if ir+rr<0  then;

      ar := Ziks (40,3,NJkinFA,tig, '',0,0,0,0, ir,rr,aa,aa); //< 30=Ik3v johdn alussa.  6.0.0 ao-1 Korj 6.2.2
      if ir+rr<0  then;
WrNyt := false; //}
   END;
//..........................................
          //,,SAA KUTSUA vasta, kun arvo_IK3V_2 + arvo_SUL_OIKOS_6 + arvo_KAT_AIKA_14 on SIJOITETTU ####### ?????
   FUNCTION Ik3_t (ohj,os :integer) :real;      VAR ir,tiq :real;      begin
      tiq := 1;                     //< +8.0.9 Takaisin oli eTim.
      ir :=  Ik3_tim (ohj, os,tiq);
      Result := ir;                         KoeWInfo ('  2/2 fIk3_t=' +fRmrkt0(ir,1,2), 0);
   END;
//..........................................
   FUNCTION Ik3_d (ohj,os :integer) :real;      VAR ar,ir,rr :real;      begin
      rr := Ziks (ohj ,os,NJkinFA,Tim_0, '',0,0,0,0, ar,ar,ar,ar);
                                            KoeWInfo ('  Zd=' +fRmrkt0(rr,1,6), 0); //<12.0.0:  ir => rr.
      ir := iks (Ik3vTR, os, rr);
      Result := ir;
                                            WrKoeF ('Ik3_d:  Ziks=' +fRmrkt0(rr,1,6) +'  Ik3_d=' +fRmrkt0(ir,1,2));
   END;
                       // ao<0 =Sorc[os].Josa,  aoos>0=Edka[os] .  1-vaiheinen ja P = P/3, eli esim. sähkölämmityksestä vain yksi vaihe kytkeytyy päälle.
procedure LaskeSij_uh (ao :integer);    VAR i,t,no :Integer;  ZRv,ZXv,ZRn,ZXn{n=+130.0},uh,uh3,uh1,Yuh,Ph,Qh,PIT, rr,rn,xx,cp :Real;
                                            SorcB,EdkaB,TamaSorcJaAinoaPh :boolean;  {rek :EdvPalstaType; EiOK koska REC sijoittaa päälle}
                                        BEGIN//+6.2.15 Uusia osia +120.5o. Uusittu +testattu 130.0 .
//                     uh% = [100/(U²V¨3)] * (RP + XQ)      = 100/(U²V¨3) * P(R + X tanø)        +6.0.0
{fDsmKoe;  Funktioiden fDsm, fMuokDesRaj, fMuokDesRajAlk, TalInifAlkio, fTdsm, fSiTdsm  KOKEILUA,
        Ks.  E:\Projektit\NolaKehi\SRC\EdvNj\EdvNewLask-Koe-fDsm-ajot.INC}

   SorcB := ao<100;                        //<,Annettiin kutsussa +100 jos Edka, eikä Sorc.
   EdkaB := NOT SorcB;
   no := ao;
   if no>100  then no := ao-100;           //NO vain jotta Local Variables´issa näkyisi, AO ei näy.#########################################################
   Ph := a_getReaa (7010, rec.Ph);
   TamaSorcJaAinoaPh := false;             //<,,+130.0  Voi silti olla Sorcaa vaikka FA.
   if SorcB  then begin
      t := 0;
      for i := 1 to no  do begin
         if i<= Edv.YLE.SorceCount.ArvoInt  then
         if edv.Sorc[i].Josa.Ph.ArvoRea >0  then begin
            t := i;  Break;  end;
      end;//for i
      TamaSorcJaAinoaPh := t=i;            //<Voi silti olla Sorcaa vaikka FA.
   end;//if SorcB
 //if (Ph>0) and NOT SorcB  OR  (SorcB and ((no=1) OR ( (no>1) and (Edv.Sorc[no-1].Josa.Ph.ArvoRea=0) )))
   if Ph=0  then begin                                   //<,,+130.0:  Uho ja Uhvo pitää nollata jos välissä on kaapOsa, jossa Ph=0, muuten Uho ja Uhvo
      if SorcB  then begin                                     //            siirtyvät laskentaan välikaapelin jälkeenkin.
         if no<Edv.YLE.SorceCount.ArvoInt
         then begin
            edv.Sorc[no+1].Josa.Uho. ArvoRea := 0;
            edv.Sorc[no+1].Josa.Uhvo.ArvoRea := 0;  end
         else begin
            edv.edka[1].Uho. ArvoRea := 0;
            edv.edka[1].Uhvo.ArvoRea := 0;
         end
      end else begin//''SorcB ,,EdkaB
         if no<Edv.YLE.JohtoOsia.ArvoInt  then begin
            edv.edka[no+1].Uho. ArvoRea := 0;
            edv.edka[no+1].Uhvo.ArvoRea := 0;
         end;
      end;
   end;
   if (Ph>0) and (TamaSorcJaAinoaPh  OR  EdkaB)
   then begin                                                                                              //  uh% -laskuihin, uh% := fV_U_k * (RP + XQ)
      rr := res (rec.Tyyppi.arvoStr, rec.Amm2.arvoRea) / rec.Lukumaara.arvoInt;                            //uh3v% = (Ip*R + Iq*X)100 /Uv,  Ip=P/(V¨3 Un cos)
      t :=  a_getIntg (7015, rec.Tuh);                                                                     //      = (PR + QX) 100 / Un²,   Iq=P/(V¨3 Un sin)
      rr := rTkorj ( fAlCu (a_getStrg (7016, rec.Tyyppi)), rr,t );                                         //      = P(R*cos + X*sin)100/(V¨3 UnUn/V¨3)
      PIT := a_getReaa (7011, rec.Pituus);                                                                 //      = (PR + QX) 100 / Un² ###################
      ZRv := PIT *rr;                                                                                      //uh1v% = (PvR + QvX) 100 / Uv² #################
                                                                                                           //        'Pv=P/3  Qv=Q/3'
      xx := Xv_ind (a_getStrg (7018, rec.Tyyppi), a_getReaa (7019, rec.Amm2)) / a_getIntg (7020, rec.Lukumaara);
      ZXv := PIT *xx;

      //1v-tapaus:  lisätään N-johdon RESISTANSSI +REAKTANSSI:
      rn := resN (a_getStrg (7012, rec.Tyyppi), a_getReaa (7013, rec.Amm2)) / a_getIntg (7014, rec.Lukumaara);
      rn := rTkorj ( fNal (a_getStrg (7016, rec.Tyyppi)), rn,t );
      ZRn := PIT *(rr+rn);
      ZXn := Xn_ind (a_getStrg (7018, rec.Tyyppi), a_getReaa (7019, rec.Amm2)) / a_getIntg (7020, rec.Lukumaara);

      cp := a_getReaa (7021, rec.Cosp);
      if Sqr (1/cp) <1                             //<Varm.vuoksi +6.0.0
         then Qh := Ph                             //< Jos kateetti isompi kuin hypotenuusa = virhe.
         else Qh := Ph *Sqrt ( Sqr (1/cp) -1 );    //< Q = V¨(S²-P²) = V¨[(P/cos)²-P²] = P* V¨[(1/cos²)-1]
//,,SÄILYTÄ.{X} vrt. koeajoTul alempna.            //,fV_U_k = 100 / Sqr(fUn);    3v=100/Un²        <+6.0.0
{1}   uh3 := ( ZRv*Ph + ZXv*Qh ) *1000 *fV_U_k;    //< uh% := fV_U_k * (RP + XQ)  <= fV_U_K = 100 / Un²;   tai /Uv²
{2} //uh1 := uh3 +Sqr(fUn)/Sqr(fUv) *100/Sqr(fUv); //< uh1v = U3v²/U1v² =kumotaan Un ja tilalle Uv.  uh1v% = (PR + QX) 100 / Uv² #################
          xx := fUv;
          xx := Sqr(xx);
{2}   uh1 := ((ZRv+ZRn)*Ph/3 +(ZXv+ZXn)*Qh/3)*1000*100/xx; //<+130.0 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      Yuh := uh3;                 //,,, uh,uh3,uh1,Yuh     //'Pv=P/3

    {if v1  then begin                             //, uh1v = U3v²/U1v² =kumotaan Un ja tilalle Uv
         ar := Sqr(fUn)/Sqr(fUv);                  //<uha/3: Ks. avuste:  uh1v tapaus siten, että vain 1 vaihe päällä, jolloin kuormastakin vain 1/3. -7.0.4
         uha := uha/3 *ar;  end;                   //Otettu kokonaan vex, koska ei liene oikein 1v-tapauksessa. Ei vaikutusta, koska uha/3 *3 = uha.
      uh := a_getReaa (7022, rec.Uho);             //<,Lisätään alkupisteen lähtöarvo (vain alkupisteessä JA senJälk >0), edJosanUh% kasvattaa myös.}
{3}   uh := rec.Uho.arvoRea;
{4}   Yuh := Yuh + uh;                             //<Uho sij. VAIN dialogissa ja VAIN kerran, Uhp ja Uhv kasvaa kumul´sti ja niitä luetaan seur. JOsille.

           //,,Sijoituksissa ei saa käyttää SUORAAN [NO]...:= koska jälempna rec. sijoitukset päällekirjoittaa ne, mutta [NO+1]..:= OK.################
      if SorcB                                           //<,,+120.5o:  Suurimmalta osin uutta.######################
      then begin                                              //, Uhp :=
           Yuh := fMuokDesRajAlk (Yuh, rec.Uhp);              //<,Muuten lopputarkistuksessa edv<>edf => turha talletus, todettu +6.2.2
{5}      rec.Uhp.ArvoRea := Yuh;                              //'fMuok.. vois ottaa myös vaikkapa Uhv´stä tms.
           uh1 := fMuokDesRajAlk (uh1, rec.Uhv);              //<, Uhv :=   Muuten lopputarkistuksessa edv<>edf => turha talletus, todettu +6.2.2
         rec.Uhv.ArvoRea := uh1;                              //'fMuok.. vois ottaa myös vaikkapa Uhp´stä tms.
{6}     {if edv.Yle.SorceCount.ArvoInt >no                    //<,Jos sorceja vielä jäljellä.
            then edv.Sorc[no+1].josa.Uho.ArvoRea := Yuh       //<Uho valmiiksi seur []´n oletusarvoksi +kumulSumman siirtämiseksi eteenpäin.
            else begin }                                      //<''130.0:  Hyväksytään vain 1x Liittymäjohto Uh-ketjuun mukaan.
                 edv.Edka[1].        Uho.ArvoRea := Yuh;      //<,Uho ja Uhv valmiiksi ekaan Edkaan. Voi sijoittaa, koska seur.JOsa on jo luotu SyottFrm´ssa.
                 edv.Edka[1].        Uhv.ArvoRea := uh1;
{7}              edv.Edka[1].        Uhvo.ArvoRea := uh1;     //<+130.0
     {end;} end//if SorcB                                     //'Uh´t valmiiksi ekaan EdkaJohtoon.
      else begin
         Yuh := fMuokDesRajAlk (Yuh, rec.Uhp);                //<,Muuten lopputarkistuksessa edv<>edf => turha talletus, todettu +6.2.2
{8}      rec.Uhp.ArvoRea := Yuh;                              //'fMuok.. vois ottaa myös vaikkapa Uhp´stä tms.

         uh := rec.Uhvo.ArvoRea;
         uh1 := uh1 +uh;                                      //<'+130.0
         uh1 := fMuokDesRajAlk (uh1, rec.Uhv);                //<,Muuten lopputarkistuksessa edv<>edf => turha talletus, todettu +6.2.2
{9}      rec.Uhv.ArvoRea := uh1;                              //'fMuok.. vois ottaa myös vaikkapa Uhp´stä tms.
         if edv.Yle.JohtoOsia.ArvoInt >no  then begin
{10}        edv.Edka[no+1].Uho.ArvoRea := Yuh;                //Uho valmiiksi seur []´n oletusarvoksi +kumulSumman siirtämiseksi eteenpäin.
            edv.Edka[no+1].Uhvo.ArvoRea := uh1; end;          //Uhvo valmiiksi seur []´n oletusarvoksi +kumulSumman siirtämiseksi eteenpäin.
      end;                                                    //,,fMuokDesRajAlk uusi FNC,  +9.0.1
     {if SorcB  then edv.Sorc[no].josa := rek //<Ei täällä, kirjoittuu myöhemmin yli, todettu.
                else edv.edka[no] :=      rek;}
                                         if (edv.Sorc[1].Josa.Uhp.ArvoRea >0) or (edv.Sorc[1].Josa.Uhv.ArvoRea >0) or (edv.Sorc[1].Josa.Uho.ArvoRea >0) or
                                            (edv.Edka[1].Uhp.ArvoRea >0) or (edv.Edka[1].Uhv.ArvoRea >0) or (edv.Edka[1].Uho.ArvoRea >0) OR
                                            (rec.Uhp.arvoRea >0) or (rec.Uhv.arvoRea >0) or  (rec.Uho.arvoRea >0) then ; //<Pitäis olla samoja.
{Olet-EvUh02-2.NOE = 2xSorc + 2xEdka:         SORCE.......               EDKA...............Edka[+1]
      (1)      (2)      (3)      (4   /    )    (5)      (6)      (7)      (8)      (9)     (10)
[no]  uh3      uh1      Yuh      +uh  /Yuh     Uhp      Uhv      Uho      Uhp      Uhv      Uho
01    0.01255  0,01255  =        0             0,013    0,038    0,013    ---      ---      ---     AXCMK 300 8m
02    0,013    0,039    =        0,013/0,026   0,026    0,039    0,026    ---      ---      ---     AMCM..300 8m
 1    1,2375   3,7125   1,2375   0,026/1,2635  ---      ---      ---      1,264    3,713    1,264   AMCM..185 200m
 2    0,155    0,465    0,155    1,264/1,419   ---      ---      ---      1,419    0,465   (1,419)  AMMK  150 20m
      (1)      (2)      (3)      (4       )    (5)      (6)      (7)      (8)      (9)     (10)
[no]  uh3      uh1      Yuh      +uh  /Yuh     Uhp      Uhv      Uho      Uhp      Uhv      Uho
01    0,01255  0,1492   3,4927   0    /0,01255 0,013    0,149    0,13     ---      ---      ---     AXCMK 300 8m
02    0,013    0,1519   0,026    0,013/0,026   0,026    0,152    0,026    ---      ---      ---     AMCM..300 8m
 1    1,2375   14,604   1,264    0,026/1,264   ---      ---      ---      1,264    14,6     1,264   AMCM..185 200m
 2    0,155    1,9238   0,155    1,264/1,419   ---      ---      ---      1,419    1,924   (1,419)  AMMK  150 20m }
   end;//if Ph>0
END;//LaskeSij_uh

  {procedure TikKoe (os,Isul :integer;  Ik3v :real);      VAR ra,ry,rr :real;      begin
      ra := TikAR (su_OFAg, Isul, Ik3v);
      ry := TikYR (su_OFAg, Isul, Ik3v);
      rr := Ik3_tim (os, Ik3v, 0.01);   //<... lasketaan kylmästi 10 ms:lla.
      DetEvFrm.aRich.Font.Name := 'Courier New';
      DetEvFrm.aRich.Lines.Add ('no='+fImrkt0 (os,1) +' Isul='+fImrkt0 (Isul,3) +' Ik3v='+fRmrkt0 (Ik3v,8,1) +
                                ' TikAR='+fRmrkt0 (ra,7,5) +' TikYR='+fRmrkt0 (ry,7,5) +
                                ' Ik3th=' +fRmrkt0 (edv.edka[os].arvo [arvo_IK3T_3],8,1) +
                                ' Ik3tOFAA=' +fRmrkt0 (rr,8,1));
      DetEvFrm.Show;           //no=1 Isul=  0 Ik3v= 12820.7 TikAR=0.00000 TikYR=0.00000
   end;//}                     //no=1 Isul=315 Ik3v= 12820.7 TikAR=0.00100 TikYR=0.00100
                                {no=2 Isul=500 Ik3v= 11665.6 TikAR=0.00314 TikYR=0.04080
                                 no=2 Isul=250 Ik3v= 11665.6 TikAR=0.00100 TikYR=0.00100
                                 no=3 Isul=400 Ik3v=  3950.3 TikAR=0.32560 TikYR=0.68264
                                 no=4 Isul=250 Ik3v=  3690.4 TikAR=0.06976 TikYR=0.08977
                                 no=4 Isul=  0 Ik3v=  3690.4 TikAR=0.00000 TikYR=0.00000
                                 no=5 Isul=160 Ik3v=  1553.5 TikAR=0.09626 TikYR=0.18374
                                 no=5 Isul=160 Ik3v=  1553.5 TikAR=0.09626 TikYR=0.18374}
//===========================================================================

BEGIN//laskeIkSulOK
//Tics ('26.INC/laskeIkSulOK 1');
                                                    //EdvFileen(1,'LskIkSul 0');
if a_getBool (6050, edv.YLE.IecOfa)  then suCse := su_IECg  //<,GLOBAALI asetus VAIN TÄSSÄ = ei edes
                                     else suCse := su_OFAg; //  FileEv.INC :ssä ####################
fnc := true; //fnc := false;//<Vain Ik1v :n alitus alle 6 A :n sulakkeen Isnik´in asettaa FALSE ####
//edja := 0;                //<Lasketaan johto-osat, jos vaikka JohtoOsia EI VIELÄ ok ##############
//'KESKEN 120.5
//¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
{sd := '';
if edv.Sorc[1].Josa.OfaVal.ArvoInt>0
   then sd := sd +' [s1]=' +IntToStr(edv.Sorc[1].Josa.OfaVal.ArvoInt);
if edv.Sorc[2].Josa.OfaVal.ArvoInt>0
   then sd := sd +' [s2]=' +IntToStr(edv.Sorc[2].Josa.OfaVal.ArvoInt);
if edv.Sorc[3].Josa.OfaVal.ArvoInt>0
   then sd := sd +' [s3]=' +IntToStr(edv.Sorc[3].Josa.OfaVal.ArvoInt);
if edv.edka[1].OfaVal.ArvoInt>0
   then sd := sd +' [j1]=' +IntToStr(edv.edka[1].OfaVal.ArvoInt);
if edv.edka[2].OfaVal.ArvoInt>0
   then sd := sd +' [j2]=' +IntToStr(edv.edka[2].OfaVal.ArvoInt);}

if edv.YLE.JohtoOsia.ArvoInt > edv.YLE.SorceCount.arvoInt  then ; //<120.5  Arvoseurantaan.
s_e := 0;                                                                                      //<,,+6.2.2
REPEAT s_e := s_e +1;                                         //s_e:  1=Sorc  2=Edka
   if s_e=1  then nama := a_getIntg (6051,edv.YLE.SorceCount) //edLmaxKpl
             else nama := edMaxKpl;
//,,for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os
for os := 1 to nama  do BEGIN
   if s_e=1  then rec := edv.Sorc[os].josa
             else rec := edv.edka[os]; {
   if rec.Amm2.arvoRea <=3)  then beep; }
                                                    //EdvFileen(2,'EdvLskPas 1');
IF NOT rec.onarvot          //<Syotto.PAS :ssa := TRUE #############################################
THEN BEGIN    //Break       //<,Alustetaan:  AINOA PAIKKA KOKO NOLAssa #############################
   for j := 1 to arvo_Max_15    do edv.edka[os].arvo[j] := 0;   //,[26]:lle (=rv31) kylläkin erikseen oma, ks. jälemp.
   for j := 1 to rjohto_Max_9  do for  k := 1 to rjpituus_Max_2  do begin
                                     rec.ryhmajohto[j].rjpituus[k].pituus := 0;
                                     rec.ryhmajohto[j].rjpituus[k].pitZpe := 0;
                                     rec.ryhmajohto[j].rjpituus[k].TUP :=    0;  end;
   j := rjohto_Max_9+1;  k := j+8-1;                           //<[os]: 10,11,12,13,        14,15,16,17  <,+10.0.1
   for j := j to k  do rec.ryhmajohto[j] := rec.ryhmajohto[1];  //    '= 0.4s 10A 2.5mm² ja  5s 10A 2.5mm² á 4 rv.
                                                                //,Nämäkin vois alustaa kuten ed.!!!!!!!!!!!!!!!!!
   for j := 1 to 2  do for  k := 1 to rjpituus_Max_2  do begin     //<,,Rivi 31: Samalle riville 4 arvoa, +8.0.7
                                     rec.RyhmaJ_r31[j].rjpituus[k].pituus := 0;
                                   //rec.ryhmajohto[j].rjpituus[k].pitZpe := 0;  //<-10.0.1
                                     rec.RyhmaJ_r31[j].rjpituus[k].pitZpe := 0;  //< 10.0.1
                                     rec.RyhmaJ_r31[j].rjpituus[k].TUP :=    0;  end;
   for j := 1 to njohto_Max_4  do with rec.nousujohto[j]  do begin
                                     sulake := 0;   mater := false;   Amm2 := 0;  pituus := 0;   pitZpe := 0; end;
                                                    //EdvFileen(3,'LskIkSul 1');
END
ELSE  {WITH rec  DO }BEGIN                                 //, FO =Ao.os   F_ =Ed.os.
   if s_e=1  then begin  fo := -1*os;   f_ := fo;     end  //<,Näillä ohjataan ao. tai edelliseen
             else begin  fo :=  os;     f_ := os -1;  end; //  alkioon. -1* =Ziks_:ssä erottuu Sorceksi.
                                                    //EdvFileen(4,'LskIkSul 2');
//try;//21 +120.6 µµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµ
//,'Tämä try..except pari esimerkkinä µµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµµ
//   if s_e=2  then edja := edja +1;
//'Otettu vex 120.5
   SulN := a_getIntg (6051, rec.lukumaara); //<Ao. johto-osan sulakelukumäärä.
   if SulN=2  then                          //<,Jos Lkm=2 (tai 1) ao. johdon sulakeLkm:ksi tulee 1.
      SulN := 1;                                                 //,edSulN :=.. siirretty aoKohtiin 10.0.3
                    //=============== LASKENTA JA SIJOITUS =========================================
   sijSul (os,rec); //<Sulakearvojen etsintä kaap.tietojen perusteella ja sijoitus.#################

   if (s_e=1)  then LaskeSij_uh (    os)  //<+120.5o:  <100=Sorc[].Josa
               else LaskeSij_uh (100+os); //<+120.5o:  >100=Edka[]
//except ExcIlmoita('21# Uh-arvojen laskennassa');  end;//try 21 +120.45T yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
   //###############################################################################################
   //############ HUOM: Täällä ei voi sijoittaa suoraan edv.Edka[os] tai Sorc[os] koska ############
   //############   lopussa edv.Edka[os] tai Sorc[os] := REC  ja sijotukset kumoutuvat. ############
   //###############################################################################################
   //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Ik1v johdon alussa,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      ou := 11;  if s_e=1  then ou := 10; //<10=Ik1vNapa 11=Ik1v [os-1=f_] j:n lopussa.#############
      ar := Ziks_ (ou ,f_,aoPEkrj,NJkinFA,Tim_0, '',0,0,0,0, ar,ar,ar,ar); //< os-1=EdLoppuun. Tim merkitystä vain
                                                                           //  kun OHJ IN [40,41].###############
   ikEdKaap := iks (Ik3vFA, f_, ar); //'os-1=Joh'don alussa =keskuksessa.  arvo [2] =Ik1v alussa (esim. 25.76/19.76 kA)
   rec.arvoU [2] := ikEdKaap;

      ar := Ziks_ (12    ,fo,aoPEkrj,NJkinFA,Tim_0, '',0,0,0,0, ar,ar,ar,ar); //<12=MinIk1v,  [os]:n MaxZ-kohtaan
   ikEdKaap := iks (Ik3vFA, fo, ar);           //<,Ik1v ao.johto-osuuden MaxZ -pisteessä.
   rec.arvo [arvo_IK1V_1] := ikEdKaap;
                                                    //EdvFileen(5,'LskIkSul 3');
   //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Ik3v, Ik3th(1s), Ik3d, Katkaisijan t_Max,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
{if os=3  then                                                                                  //<'+12.0.0
WrNyt := true;                                 //<PRC 10.INC/WrKoeF :n ohjailuun ON/EI.}
      ou := 31;  if s_e=1  then ou := 30; //<30=Ik3vNapa 31=Ik3v [os-1=f_] j:n lopussa.#############
   ar := Ik3_v (ou,f_);                        //<Ao:n alkuun = Ed.j:n loppuun.                     6.0.0 os->os-1
   rec.arvo [arvo_IK3V_2] := ar;                 //<_Ik3T() sijoitus vasta lopussa ################## 6.0.0 os->os-1
                                            KoeWInfo('',1); KoeWInfo ('Edv..Lsk: os=' +Ints(os) + ' Ik3v=' +fRmrkt0(ar,1,1), 0);
//WrOnEi := false; //<PRC WrKoeF :n ohjailuun ON/EI:  Vain tähän asti Ziks_a -laskentoja kirjoitetaan fileen. -12.0.0
      ou := 41;  if s_e=1  then ou := 40; //<40=Ik3tNapa 41=Ik3t [os-1=f_] j:n lopussa.#############
   ar := Ik3_t (ou,f_);
   rec.arvo [arvo_IK3T_3] := ar;
                                            WrKoeF('Edv..Lsk: ou=' +Ints(ou) +' f_=' +Ints(f_) +' Ik3_t=' +fRmrkt0(ar,1,1));
                                            KoeWInfo ('  Ik3th=' +fRmrkt0(ar,1,1), 0);
                                                    //EdvFileen(6,'LskIkSul 4');
 //rec.arvo [arvo_KAT_AIKA_14] := Tekv_mn (f_,fo,0, NJkinFA); //< os,TypOsMukaan (ei väliä NJllä),tamaIK,NJkin
 //,################,RR,OLI AR, aiheutti selittämättömän virheen, jota ei saanut debugattua. Tekv_..n sisällä ei saatu debugattua eikä vikaa näkyviin.
   rr := Tekv_mn (fo,ar,NJkinFA);  //< fo=TypOsMukaan,tamaIK,NJkin.  -f_=-7.0.5, Sij ekax ar´ään +8.0.7
   rec.arvo [arvo_KAT_AIKA_14] := ar;                         //'6.2.2:  Nyt lasketaan Ik3th:lla, oli Ik3v:lla
      ou := 51;  if s_e=1  then ou := 50; //<50=Ik3dNapa 51=Ik3d [os-1=f_] j:n lopussa.#############
   ar := Ik3_d (ou,f_);                        //<Ao:n alkuun = Ed.j:n loppuun.                     6.0.0 os->os-1
   rec.arvo [arvo_IK3D_4] := ar;            WrKoeF('Edv..Lsk: ou 1(3)'); //<+1415e
                                            WrKoeF('Edv..Lsk: ou=' +Ints(ou) +' f_=' +Ints(f_) +' Ik3_d=' +fRmrkt0(ar,1,1));
                                          //WrNyt := false;
                                            KoeWInfo ('  Ik3d=' +fRmrkt0(ar,1,1), 1); //<Nyt 1 (=LF).
   //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,MaxSulNeh,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   IF a_getBool (6051, rec.kuluttaja)                                //<,Varmvuoksi näin. Ilmeisesti
    //THEN tim := a_getReaa (6052, edv.YLE.PoisAika)                 // ei olla asetettu syöttölomak
      THEN tim := 5                                                                             //<'9.0.1
      ELSE tim := 15;                                                // keessa SÄL:lle PoisAikaa ???
                                            WrKoeF('Edv..Lsk: ou 1(6)'); //<+1415e
                                                      //,VoisOlla fSul_Tot(). +fSul_Neh=Uusi, +2.0.1
   ai := fSul_Neh (suCse,ikEdKaap/SulN,tim);          //<Ei sis. ZsIa -tarkistusta =RAAKA!!!!!!!!!!! SulN +6.2.0
                                                      //,fSul_ZsIa TAVATTOMAN HIDAS (josKUL)<<<<<<<<
                {FUNCTION fSul_ZsIa (os,alpNehSul :Integer;  NJkin,KulSal :Boolean;  Tim :Real;
                                     QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer) :Integer;}
                                            WrKoeF('Edv..Lsk: ou 2(6)'); //<+1415e
   ar := fSul_ZsIa (suCse,fo,ai,0, FALSE,a_getBool (6054,rec.Kuluttaja), tim, '',0,0,0,0);
   rec.arvo [arvo_SUL_MAX_5s_5] := ar; //<##### Nyt MaxSul = Pienempi OikS <-> ZsIaSul. Käytet myös 31.INC
                 //....,1=EiKulTestiä                                                   //,,,,,,,,,,+9.0.1
 //if rec.Kuluttaja.arvoBoo  and (s_e>1)  then begin  //<EI SÄHKÖL.jakeluverkossa eikä liittymäj:ssa.
                                            WrKoeF('Edv..Lsk: ou 3(6)'); //<+1415e
      ai := fSul_Neh (suCse,ikEdKaap/SulN,0.4);       //<,,9.0.1:ssä näytetään SEKÄ 5 s:n että 0.4 s:n MaxSul.!!!!
    //ar := fSul_ZsIa (suCse,fo,ai,0, FALSE,a_getBool (6054,rec.Kuluttaja), 0.4, '',0,0,0,0);  -10.0.7 Arvoa ei sijoitettu minnekään
                                                                                                    //'ja ai=ar.
                                            WrKoeF('Edv..Lsk: ou 4(6)'); //<+1415e
      rec.arvo [arvo_SUL_MAX_04s_15] := ai;                                                //''''''''''+9.0.1
                                                    //EdvFileen(7,'LskIkSul 5');
                                                      //,,,Jos Ik>= 6Asulakkeen vaatima =OK,,,,
                                                      //,,,Vasta äsken sij, IEC/OFAA huomioitu !
                                            WrKoeF('Edv..Lsk: ou 5(6)'); //<+1415e
   if (rec.arvo [arvo_SUL_MAX_5s_5] <6)  OR            //<,OR.. ei tarvittane: Äsken huomioitu ?
      (ikEdKaap/SulN < Isnik (suCse,6,tim)) {AND (uhikYkaap <= 75)}                              //<SulN +6.2.0
      THEN BEGIN      //,Välittää vain tiedon kutsuvaan ohaan, ettei saa laskea vex korjaamatta ####
        fnc := FALSE; //<########################### FNCn LOPPUSIJOITUS ############################
        if herjakin>0  then                                           //,2.0.4 Lisätty alkuun: Verkkolaskentaosan
           HerjaInfo ('Verkkolaskentaosan johto-osan n:o '+fImrkt0 (fo,1)+' Ik1v EI RIITÄ EDES 6 A:n '+
                      'SULAKKEEN LAUKAISUUN, KORJAA !!!!!!');
      END;//ELSE fnc := true;
   //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,KatkaisijaAsetukset,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
              //,,,,,,,,,,,,,,,,,,,,,,Tarkistaa IksalTerm + ZsIa -ehdon (SÄL/KUL mukaan)############
              //function Ikatk_Aset (oikos,raaka :boolean;  os :Integer;  NJkin :Boolean;  Qastap :Char;  VAR Ylitys :integer);
                                                   //,,fo = oltava etumerkki mukana => Sorc[]/Edka[]
                                            WrKoeF('Edv..Lsk: ou 6(6)'); //<+1415e
   rec.arvo [arvo_KAT_OIKOS_10]  := Ikatk_Aset (TRUE, FALSE,fo,0,NJkinFA,' ',ai); //<Olisi fiksumpaa ennen eo.
   rec.arvo [arvo_KAT_YLIV_A_11] := Ikatk_Aset (FALSE,FALSE,fo,0,NJkinFA,'A',ai); //'HerjaInfoa mutta nämä eivät
   rec.arvo [arvo_KAT_YLIV_C_12] := Ikatk_Aset (FALSE,FALSE,fo,0,NJkinFA,'C',ai); //'viene liikaa aikaa, OK.
   rec.arvo [arvo_KAT_YLIV_D_13] := Ikatk_Aset (FALSE,FALSE,fo,0,NJkinFA,'D',ai);
                                                    //EdvFileen(8,'LskIkSul 6');
   //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,(OFAA) Tim, r.10 ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   rd := 0;  rt := 0;  edSulN := 1;
   if s_e=2  then begin                             //<,,Uusittu +6.2.17, 8.0.0 ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      ai := 0;                                      //<Saattaa jäädä voimaan. Sul vaikutus lasketaan vain Edka
      edSulN := 1;                                  // -osalle (Src:t eiOoPeräkkäin).
      if os=1                                       //<,,OFA voi olla Edka tai Src -osalla.         +6.2.2
      then for j := 1 to a_getIntg (6052, edv.YLE.SorceCount)  do begin  //,Etsitään Sorc-johdoista edeltävä
               k := Trunc (edv.Sorc[j].Josa.arvo [arvo_SUL_OIKOS_6]);    // ISOIN OikoSuoj.
               if k>ai  then begin
                  ai := k;
                  edSulN := a_getIntg (6051, edv.Sorc[j].Josa.Lukumaara);  end;   //<Siirty alusta  10.0.5
      end
      else begin
         ai := Trunc (edv.Edka[os-1].arvo [arvo_SUL_OIKOS_6]);               //<Edka[os-1] OikoSuoj.
         edSulN := a_getIntg (6051, edv.edka[os-1].Lukumaara);               //<Siirty alusta tähän 10.0.5
      end;
                                                      //,OIKOSUOJ sij. ed.johto-osan alussa ja Ik[os] jakautuu
      if edSulN=2  then edSulN := 1;                  // jokaiselle sulakkeelle = Ik/edSulN.!!!!!!!!!!!!!!!!!!!!!!
          //,Ip =Ik3th =Prospekti,,ivinen Ik (rms).  Id = Ik3d=Alkuper.Ik3d (rajoittamaton) +6.0.4
          //,FNC OFAAraj_Is (IsuOFAA,Ip,Id :real)  :real;               //<fnc =OFAAsulakkeen rajoittama Is.

         rd := rec.arvo [arvo_IK3T_3];                                  //<,,Jaettu debuggaukseen  10.0.3.
         rd := rd/edSulN;
         aa := rec.arvo [arvo_IK3D_4];                                  //<+5.0.1, <'edSulN +6.2.0
         aa := aa/edSulN;
      RD := OFAAraj_Is (ai, rd,aa);                                     //<Raj. Ik3d   +5.0.1, ''edSulN +6.2.0
          //FUNCTION TikYR (suCs :string;  Isul :Integer;  Ik :Real) :Real;   =YR-käyrän poiskytkentäaika Ik:lla.
                                                    //EdvFileen(9,'LskIkSul 7');
         aa := rec.arvo [arvo_IK3V_2];                                   //<edSulN +6.2.0.  Jaettu ,,aa 10.0.3
         aa := aa/edSulN;
      aa := TikYR (su_OFAg, ai,aa);                   //<TikAR=0.3256  TikYR=0.6826,  aa := 0 jos AI>630.

      if (ai>0) and (aa<1) and (aa>0{+1003}) then begin //<,Ik3th laskettiin 1 s. Jos OFAAoikoSuo TIM rajoittaa ...
         if aa<0.01  then                             //<,Lasket. kylmästi 10 ms:lla.  os-1 =ed.j-osa 6.2.2, +6.2.1
            aa := 0.01;      //aa := 1;               //< aa:=1 =testi, että 1 s:n arvo sama kuin kuvaajassa.
         ou := 41;  if s_e=1  then ou := 40; //<40=Ik3tNapa 31=Ik3t [os-1=f_] j:n lopussa.#############
         RT := Ik3_tim (ou,f_, aa);                   //< Ik3thRaj =Ik3v ×V¨[(m+n)*t].  m=fnc()  n=1.
      end;                             //'Termisen virran laskenta suoritetaan 10 ms:lla, jolle lasketaan sys.- ja
   end;//if s_e=2                      //'tasav.kertoimet, joilla taas saadaan laskettua I ² t -lausekkeesta joh-
 //TikKoe (f_, ai,arvo [arvo_IK3V_2]);  //'dettuna muunnoskerroin, millää IkThRaj = k*Ik3th.
                                                      //,Kun rt t. rd =0, ei väliä jos edSulN eioo alustettu.
   rec.arvoU[5] := RT*edSulN;                         //<OFAAraj_Ith OikosSUL: Rv 8 (xxx)Ik3th     < +6.2.0
   rec.arvoU[1] := RD*edSulN;                         //<OFAAraj_Is  OikosSUL: Rv 9 (xxx)Ik3d     <'edSulN +6.2.0
                                                 //''arvoU[..max] nollattu FileEv :ssä.##########################
   //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,(OFAAraj_Ith/OFAAraj_Id) OFAval, r.10 ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   rd := 0;  rt := 0;  edSulN := 1;                 //<Vaikka edSulN saisi olla mitä vaan jos rt t. rd =0.
   if s_e=2  then begin                             //<,,Uusittu +6.2.17,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      ai := 0;                                      //OFAAn vaikutus lasketaan vain Edka -osalle (Src:t ovat rinnakkain)
                                                    //,,,,,,,,,,,,,Korjattuna takaisin 10.0.1,      10.0.3 ,,,,,,,
                                                    //EdvFileen(10,'LskIkSul 8');
      if os=1                                       //<,,OFA voi olla Edka tai Src -osalla.         +6.2.2
         then for j := 1 to a_getIntg (6052, edv.YLE.SorceCount)  do begin //,Etsitään Sorc-johdoista ISOIN OfaVal,
                  k := edv.Sorc[j].Josa.OfaVal.arvoInt;                    // kylläkin vissiin vain ekassa on.
                  if k>ai  then begin
                     ai := k;
                     edSulN := a_getIntg (6051, edv.Sorc[j].Josa.Lukumaara);  end; //<Siirty alusta 10.0.3
         end
      else begin
         ai :=     edv.Edka[os-1].OfaVal.arvoInt;
         edSulN := edv.edka[os-1].Lukumaara.arvoInt;                         //<Siirty alusta tähän 10.0.3
      end;                                         //'''''''''''''''''''''''''''Korjattuna takaisin 10.0.3 '''''''
                                                      //,Jos Lkm=2 (tai 1) ed.johdon sulakeLkm:ksi tulee 1.
      if edSulN=2  then edSulN := 1;                  //OfaVal sij. edJohto-osan alussa. Ik jakautuu jokaiselle SUL.
          //,Ip =Ik3th =Prospekti,,ivinen Ik (rms).  Id =Ik3d=Alkuper.Ik3d (rajoittamaton) +6.0.4
          //,OFAAraj_Is (IsuOFAA,Ip,Id :real)  :real;      //<fnc =OFAAsulakkeen rajoittama Is.
         rd := rec.arvo [arvo_IK3T_3];
         rd := rd/edSulN;
         aa := rec.arvo [arvo_IK3D_4];
         aa := aa/edSulN;                                                               //<'edSulN +6.2.0
      RD := OFAAraj_Is (ai, rd,aa);                   //<Raj. Ik3d   +5.0.1, ''edSulN +6.2.0

             //,,,ai = ed. OFAval, ai on edelleen voimassa.
             //FUNCTION TikYR (suCs :string;  Isul :Integer;  Ik :Real) :Real;   VAR arvo,kf :real;
         aa := rec.arvo [arvo_IK3V_2];
         aa := aa/edSulN;                                                                 //<edSulN +6.2.0
      aa := TikYR (su_OFAg, ai,aa);                   //<aa := 0 jos AI>630.
      if (ai>0) and (aa<1) and (aa>0{+1003}) then begin //<,Ik3th laskettiin 1 s. Jos OFAAoikoSuo TIM rajoittaa ...
         if aa<0.01  then                                                                        //<,+6.2.1
            aa := 0.01;      //aa := 1;               //< aa:=1 =testi, että 1 s:n arvo sama kuin kuvaajassa.
         ou := 41;  if s_e=1  then ou := 40; //<40=Ik3tNapa 31=Ik3t [os-1=f_] j:n lopussa.#############
         RT := Ik3_tim (ou,f_, aa);                   //< Ik3thRaj =Ik3v ×V¨[(m+n)*t].  m=fnc()  n=1.
      end;                                            //'m_tasavKerroin = f(sysKerr,Aika) pienentää IkTh:ta.
      //TikKoe (fo, ai,arvo [arvo_IK3V_2]);
   end;//if s_e=2                                   //<''Uusittu +6.2.17''''''''''''''''''''''''''''''''''''''''''
   rec.arvoU[4] := RT*edSulN;                          //<OFAAraj_Ith OfaVal  Rv 10=,,                   < +6.2.0
   rec.arvoU[3] := RD*edSulN;                          //<OFAAraj_Is OfaVal:  (OFAAraj_Ith/_Is)   <'edSulN +6.2.0
                         { arvoU[3]=ValitunOFAAnRaj_Is   arvoU[4]=ValitunOFAAnRaj_Ith   arvoU[2]=Ik1vJohnAlussa
                           arvoU[5]=OFAAoikoSULraj_Ith   arvoU[1]=OFAAoikoSULraj_Is             //<U[4,5]=+6.2.0
                           OFAn toim.aika lasketaan Johto.PAS´sissa FNC fTikToStrDim, eikä sille ole muuttujaakaan.}
if s_e=1  then edv.Sorc[os].Josa := rec
          else edv.edka[os] :=      rec;
                                                    //EdvFileen(11,'LskIkSul 9');
END;//FOR os
//''for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os  for os

END;//IF NOT onarvot ... ELSE WITH ...
UNTIL s_e=2;             //< 1=Sorc[] sijoitus   2=Edka[] sijoitus
{sd := sd +' === ';
if edv.Sorc[1].Josa.OfaVal.ArvoInt>0
   then sd := sd +' [s1]=' +IntToStr(edv.Sorc[1].Josa.OfaVal.ArvoInt);
if edv.Sorc[2].Josa.OfaVal.ArvoInt>0
   then sd := sd +' [s2]=' +IntToStr(edv.Sorc[2].Josa.OfaVal.ArvoInt);
if edv.Sorc[3].Josa.OfaVal.ArvoInt>0
   then sd := sd +' [s3]=' +IntToStr(edv.Sorc[3].Josa.OfaVal.ArvoInt);
if edv.edka[1].OfaVal.ArvoInt>0
   then sd := sd +' [j1]=' +IntToStr(edv.edka[1].OfaVal.ArvoInt);
if edv.edka[2].OfaVal.ArvoInt>0
   then sd := sd +' [j2]=' +IntToStr(edv.edka[2].OfaVal.ArvoInt);
EdvNewFrm.KuvausEdit.Text := sd;}
//¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
//try
EdvNewFrm.KuvausEdit.Text := a_getStrg (6065, edv.YLE.Kuvaus);
//a_putIntg (6065, edja, edv.YLE.JohtoOsia);        //<On jo SyottoPas -> varm.vuoks #################
//'Otettu vex 120.5
edja := edv.YLE.JohtoOsia.ArvoInt;
//'Lisätty fKESKEN 120.5
//,,,,,,,,,,,,,,,VIIMEISEN JOHTO-OSAN ARVOT (Minkä johto-osaviiva näkyy KATKOVIIVANA edvn kuvaajassa,,,,,,,,,,,,,,
            //(11=Ik1v j:n lopussa  Tim,
   ar := Ziks (11 ,edja,NJkinFA,Tim_0, '',0,0,0,0, rr,rr,rr,rr); //<Tim merkitystä vain kun OHJ IN [40,41] ja gener.
   ar := iks (Ik3vFA, edja, ar);
a_putReaa (6066, ar             , edv.NjL.Ik1v); //,,Näitä kutsuja varten eo. silmukassa laskettiin
a_putReaa (6067, Ik3_v (31,edja), edv.NjL.Ik3v); //<,EDJA (JohtoOsia ehkeiOK). Jos EDJA=0 ->.. := 0
//putReaa (6068, Ik3_t (edja,a_getReaa (6068,edv.NjL.Ik3v)), edv.NjL.Ik3t);                      //<-6.2.2
a_putReaa (6068, Ik3_t (41,edja), edv.NjL.Ik3t);
a_putReaa (6069, Ik3_d (51,edja), edv.NjL.Ik3d);
                                                    //EdvFileen(12,'LskIkSul 10');
//################################################################################################################
//Tässä lasketaan VIKAn PALSTAn ehdolliset (sul. rajoittamat) Ik:t (rvt 8, 9) ja annetun OFAAn vaikutus (rv10).
//################################################################################################################
                 //''EDJA (=> OS) on vika johto-osa joko Src´essa (jos edv:ssa 0) tai Edkas´ssa. OS tutkit. tässä.
//,,================================================ Rivit 8, 9 ==================================,+6.2.0=========
ai := 0;                                                     //<Jos ai >0, löytyy OikoSuo (joko Src´sta tai Edka´sta).
os := a_getIntg (6070, edv.YLE.JohtoOsia);                                                        //<10.0.3  os :=
if os>0                                                      //Etsitään Edkasta.====================================
then begin
   ai := pyor(edv.Edka[os].arvo [arvo_SUL_OIKOS_6]);         //<OikoSuo
   j := a_getIntg (6070, edv.edka[os].Lukumaara);  end
else begin                                                   //,,Liittymistä SUURIN OikoSuo.================ +10.0.3
   j := a_getIntg (6070, edv.YLE.SorceCount);                //<Saattaa jäädä 1 :ksi.
   os := 1;
   for j := 1 to j  do begin
      k := Trunc (edv.Sorc[j].Josa.arvo [arvo_SUL_OIKOS_6]); //<,Etsitään ISOIN OikoSuo.
      if k>ai  then begin
         ai := k;                                            //<OikoSuo
         os := j;  end;                                      //<os jää voimaan.
   end;
   j := a_getIntg (6070, edv.Sorc[os].Josa.Lukumaara);
end;
edSulN := j;
if edSulN=2  then edSulN := 1;                               //<,Jos Lkm=2 (tai 1) sulakeLkm:ksi jää 1 (alkuarvo, edellä).
                                                    //EdvFileen(13,'LskIkSul 11');
rd := 0;  rt := 0;
if ai>0  then begin                                          //,,,,,,,,+6.0.4,,,,,,,, AI >0 =OikoSuo on: 10.0.3
      rd := a_getReaa (6071,edv.NjL.Ik3t);
      rd := rd/edSulN;
      aa := a_getReaa (6071,edv.NjL.Ik3d);
      aa := aa/edSulN;                                                                  //<'edSulN +6.2.0
   RD := OFAAraj_Is (ai, rd,aa);                             //<10.0.3 ai,rd,rt.  Ik3dRaj
                                     //<Raj. Ik3d   +5.0.1, ''edSulN +6.2.0
         //FUNCTION TikYR (suCs :string;  Isul :Integer;  Ik :Real) :Real;   VAR arvo,kf :real;
      aa := a_getReaa (6071,edv.NjL.Ik3v);
      aa := aa/edSulN;                                                                  //<'edSulN +6.2.0
   aa := TikYR (su_OFAg, ai,aa);                     //<aa := 0 jos AI>630.
   if (ai>0) and (aa<1) and (aa>0{+1003}) then begin //<,Ik3th laskettiin 1 s. Jos OFAAoikoSuo TIM rajoittaa ...
       if aa<0.01  then                                                                           //<,+6.2.1
          aa := 0.01;      //aa := 1;                //< aa:=1 =testi, että 1 s:n arvo sama kuin kuvaajassa.
      RT := Ik3_tim (41,os, aa);                     //< Ik3thRaj =Ik3v ×V¨[(m+n)*t].  m=fnc()  n=1.
   end;                                              //'m_tasavKerroin = f(sysKerr,Aika) pienentää IkTh:ta.
 //TikKoe (edja, ai,a_getReaa (6071, edv.NjL.Ik3v));
end;//if ai>0

edv.NjL.Ik3thOfaOikos := RT*edSulN;          //<OFAAraj_Ith OikosSUL:  Rv 8 (Ik3thOfaOikos)Ik3th  <'edSulN +6.2.0
edv.NjL.Ik3dOfaOikos :=  RD*edSulN;          //<OFAAraj_Id  OikosSUL:  Rv 9 (Ik3dOfaOikos )Ik3d

//,,================================================ Rivi 10 =====================================================
rd := 0;  rt := 0;                                         //<Saattaa jäädä voimaan. ,,,,,,,,,,,,,,,,10.0.3,,,,,,,
edSulN := 1;                                                                                    //<,+6.2.0
ai := 0;                                                   //<Jos ai >0, löytyy OFAVAL (joko Src´sta tai Edka´sta).
os := a_getIntg (6070, edv.YLE.JohtoOsia);
                                                    //EdvFileen(14,'LskIkSul 12');
if os>0                                                    //<Jos on yksikin j-osa.
then begin
   if a_getIntg (6051,edv.Edka[os].OfaVal) >0  then begin
      edSulN := edv.Edka[os].Lukumaara.arvoInt;
      if edSulN=2  then edSulN := 1;
      ai := a_getIntg (6072,edv.Edka[os].OfaVal);                                             //<,,+6.2.0
         rd := a_getReaa (6071, edv.NjL.Ik3t);
         rd := rd/edSulN;                                                              //<,,edSulN +6.2.0
         aa := a_getReaa (6071, edv.NjL.Ik3d);
         aa := aa/edSulN;
      RD := OFAAraj_Is (ai, rd,aa);
   end; end
else begin
   for j := 1 to a_getIntg (6052, edv.YLE.SorceCount)  do begin //<,Sorc -johdoista etsitään ISOIN OFAVAL.
       k := edv.Sorc[j].Josa.OfaVal.arvoInt;
       if k>ai  then begin
          ai := k;
          edSulN := edv.Sorc[j].Josa.Lukumaara.arvoInt;
          if edSulN=2  then edSulN := 1;  end;
   end;
      rd := a_getReaa (6071, edv.NjL.Ik3t);                                                   //,,,+10.0.3
      rd := rd/edSulN;
      aa := a_getReaa (6071, edv.NjL.Ik3d);
      aa := aa/edSulN;
   RD := OFAAraj_Is (ai, rd,aa);                  //<Raj. Ik3d   +5.0.1, ''edSulN +6.2.0        <''+10.0.3
end;
         //FUNCTION TikYR (suCs :string;  Isul :Integer;  Ik :Real) :Real;   VAR arvo,kf :real;
   aa := a_getReaa (6071, edv.NjL.Ik3v);
   aa := aa/edSulN;                                                                      //<edSulN +6.2.0
aa := TikYR (su_OFAg, ai,aa);                     //<aa := 0 jos AI>630.
                                                  //'m_tasavKerroin = f(sysKerr,Aika) pienentää IkTh:ta.
                                            //EdvFileen(15,'LskIkSul 13');
if (ai>0) and (aa<1) and (aa>0{+1003}) then begin //<,Ik3th laskettiin 1 s. Jos OFAAoikoSuo TIM rajoittaa ...
   if aa<0.01  then                                                                            //<,+6.2.1
      aa := 0.01;      //aa := 1;                 //< aa:=1 =testi, että 1 s:n arvo sama kuin kuvaajassa.
 //RT := Ik3_tim (edja, a_getReaa (6071, edv.NjL.Ik3v), aa); //<... lasketaan kylmästi 10 ms:lla.
   RT := Ik3_tim (41,edja, aa);                   //< Ik3thRaj =Ik3v ×V¨[(m+n)*t].  m=fnc()  n=1.
 //TikKoe (edja, ai,a_getReaa (6071, edv.NjL.Ik3v));
end;
edv.NjL.Ik3dOfaVal :=  RD*edSulN;                     //<,Rv10: (Ik3thOfaVal/Ik3dOfaVal) ======== <'edSulN +6.2.0
edv.NjL.Ik3thOfaVal := RT*edSulN;                     //<OFAAraj_Is OfaVal'''''''''''''''''''''''''''''''''+6.0.4''

nama := a_getIntg (6071,edv.YLE.SorceCount);          //, 1=Transformer  2=LV-Cable  3=Generator  4=UPS
for j := 1 to nama  do                                                                           //<,6.2.2
if a_getIntg (6072, edv.Sorc[j].src.SorceKind) = 2  then with  edv.Sorc[j].src  do begin
   rr := a_getReaa (6072,pjLiitRs);   ar := a_getReaa (6073,pjLiitXs);
   if rr+ar=0
      then ar := 1                                                    //< +6.0.2  90=>1  =9.0.1
      else ar := rr / (Sqrt (Sqr(rr) + Sqr(ar)));                     //<Cosini = Z / R <<<<<<<<<<<<
   a_putReaa (6074,ar, Iks1vCos);  end;
//'''''''''''''''VIIMEISEN JOHTO-OSAN ARVOT (Minkä johto-osaviiva näkyy KATKOVIIVANA edvn kuvaajassa''''''''''''''

edv.OnLaskettu := true;                           //<Vasta tässä, ei FileEv.INCssä<<<<<<<<<<<<<<<<<<
                                                  //'Arvot aina alust.OK vaikka FNC=FALSE ##########
                                            KoeWInfo('',1);
//Except ShowMessage('EdvNerwLsk.PAS 2');
//Tics ('26.INC/laskeIkSulOK 9');
                                            //EdvFileen(16,'LskIkSul 14');
END;//laskeIkSulOK  ,,,,,,,,,,,TÄHÄN LIITETTÄVÄKSI KOEAJOA VARTEN \include\NolaDosKOF.txt,,,,,,,,,,,
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

 (*procedure koe1007;     VAR sk :string;  ra,xa,za :real;  i :integer;      begin //+10.0.7
      ra := 0.000098{Ry} +0.00171{Rm} +0.000062682{Rj};
      xa := 0.001597{Xy} +0.00908{Xm} +0.000108   {Xj};
      za := Sqrt (Sqr(ra)+Sqr(xa));
      sk := 'R1=' +fRmrkt0(ra,1,8) +' X1=' +fRmrkt0(xa,1,8) +' Z1=' +fRmrkt0(za,1,8) +
            ' Ik3v=' +fRmrkt0(230.94/za,1,2);
    //R1=0.00187068 X1=0.01078500 Z1=0.01094603 Ik3v=21098.05
      za := 0;
      for i := 1 to 3  do begin //,,ks. Nola10.INC / PRC LaskeSrcZ:  Sorcja = 1 ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
       //eRs := eRs +1/(sR+jR);
         case i of
            1 :ra := 10;
            2 :ra := 100;
         else  ra := 1000;  end;
         za := za   +1/ra;
       //za := za +(1 / (ra + 1/xa));
       //Rsx := Rsx +(1 / (aR + 1/eRs))
      end;
      xa := 1/10 +1/100 +1/1000;
      sk := sk +' for=' +fRmrkt0(za,1,8) + ' /..=' +fRmrkt0(xa,1,8);

      za := 0;
      for i := 1 to 3  do begin //,,ks. Nola10.INC / PRC LaskeSrcZ:  Sorcja > 1 ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
           {if qRs>0  then Rsx := 1/qRs;                   qRs=Sorce  aR=Johto
            if eRs>0  then Rsx := Rsx +(1 / (aR + 1/eRs))
                      else Rsx := Rsx +(1 / (aR        ));
            if qXs>0  then Xsx := 1/qXs;
            if eXs>0  then Xsx := Xsx +(1 / (aR + 1/eXs))
                      else Xsx := Xsx +(1 / (aR        ));}
         ra := 10;   xa := 10;
         za := za +(1 / (ra + 1/xa));
      end;
      sk := sk +'  1):' +fRmrkt0(za,1,8);
      za := 1/(10+1/10) + 1/(10+1/10) + 1/(10+1/10);
      sk := sk +'  2):' +fRmrkt0(za,1,8);

      EdvNewFrm.KuvausEdit.Text := sk;
      ra := 0.000098;                 //< =9.8e-05
      ra := ra*100;
      if ra<-1  then beep;
   end;//koe1007*)

BEGIN//laskeEdvArvotOK;
                                                    Tics ('26.INC/laskeIkSul >1');
                 DefsFiL('EdvNewLask/0:');          //EdvFileen(17,'EdvLskPas 90');
                    laskeIkSulOK;                                    Tics ('26.INC/sij_NjL    >2');
                 DefsFiL('EdvNewLask/1:');          Tics ('26.INC/sij_PrRjNj >3');
   sij_NjL;
                 DefsFiL('EdvNewLask/2:');          //EdvFileen(18,'EdvLskPas 91');
   WrNyt := true; //+120.5n
   sij_PrRjNj;
                 DefsFiL('EdvNewLask/3:');
   WrNyt := false; //+120.5n

   Result := fnc; //<:= FALSE vain, jos Isnik liian pieni 6 A :n sulakkeelle #######################
                 DefsFiL('EdvNewLask/9:');
                                                    Tics ('26.INC/laskeEdvArv-9');
                                                    //KoeTulostPit; //<+9.0.1
                                                    //Koe_VrtOikSuo;  //<+10.0.1
                                                    //koe1007;
                                                    //EdvFileen(19,'EdvLskPas 92');
//if FileExists (TmpFN)  then
{ShowMessage('Pysähdys juuri ennen tiedoston: "' +TmpFN +'" delausta, onko file syntynyt?');
if FileExists (TmpFN)  then               //<,Delataan säikeiden viivyttämiseksi tehty file +12.0.03
   DeleteFile (PChar(TmpFN));             //<,+120.45
FreeAndNIL(nama);}
END;//laskeEdvArvotOK;

end.

