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

{################################################################# NOLAs.INC}
{function gGsuC :boolean;      begin  result := false; //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,-2.0.1
   if fSu_Sama (suCs,su_OFAg)  then result := true;
end;}
{=================================================================================================}
function R_u :integer;      begin  result := R_n;  end; //<Kokeilua: R_c -> R_n:ksi ei vaikuta, OK (kuten odotus)

function fTimAR :real;      var r :real;      begin
   if fSu_PerusSama (suCs,su_IECd)
   then  r := 0.1       //< IECdZ
   else  r := 0.01;     //< Muut = OFAA,OFAM,IECgG
   result := r;
end;
function fTimYR :real;      var r :real;      begin
   if fSu_PerusSama (suCs,su_OFAg)
   then  r := 10000     //< OFAA
   else  r := 100;      //< Muut = OFAM,IECgG,IECdZ
   result := r;
end;

function fTimARs :string;      var r :real;  s :string;  des :integer;      begin
   r := fTimAR;
   if r<0.051  then des := 3  else
   if r<0.51   then des := 2  else
   if r<0.1    then des := 1  else des := 0;
   s := fRmrkt0 (r,1,des);
   result := s;
end;
function fTimYRs :string;      var r :real;  s :string;      begin
   r := fTimYR;
   s := fRmrkt0 (r,1,0);
   result := s;
end;

function fTimARs2 :string;      var r :real;  s :string;  des :integer;      begin
   r := fTimAR/2;
   if r<0.051  then des := 3  else
   if r<0.51   then des := 2  else
   if r<0.1    then des := 1  else des := 0;
   s := fRmrkt0 (r,1,des);
   result := s;
end;
function fTimYRs2 :string;      var r :real;  s :string;      begin
   r := fTimYR*2;
   s := fRmrkt0 (r,1,0);
   result := s;
end;
//..................................................................................................
function okSul (sul :integer) :boolean;
   function fSu_100 :boolean;      begin
      result := false;
      if (sul IN [2,4,6,10,16,20,25,32,40,50,63,80,100]) //<+130.0:  +2A
         then result := true;   end;
   function fSu_630 :boolean;      begin
      result := false;
      if fSu_100 OR (sul IN [125,160,200,250]) OR
         (sul=315) OR (sul=400) OR (sul=500) OR (sul=630)
         then result := true;   end;
   function fSu_1250 :boolean;      begin
      result := false;
      if fSu_630 OR (sul=800) OR (sul=1000) OR (sul=1250)
         then result := true;  end;
begin
   okSul := false;
   if fSu_PerusSama (suCs,su_IECd) and fSu_100    or
      fSu_PerusSama (suCs,su_IECg) and fSu_1250   or
     (fSu_PerusSama (suCs,su_OFAg) or fSu_PerusSama (suCs,su_OFAm))  and  fSu_630
   then okSul := true;
end;
//..................................................................................................
function okIsu :boolean;      var i,code :integer;   s :string;   begin
  okIsu := false;
     s := ZS_Frm.ZS_Mm2Cm.Text;
     for i := 1 to Length (s)  do  if s[i] =','  then s[i] := '.'; //<Korjataan ',' => '.'
     ZS_Frm.ZS_Mm2Cm.Text := s;
  Val(s, i,Code);                                //< code <> 0  =Luku ei muodostunut oikein
  if code=0                                      //'VAL muokkaa TEXT :stä r :lle arvon, jos CODE=0
  then if okSul(i)
       then begin okIsu := true;
                  Isu := i;    end               //<Muuttaa arvoa vain jos OK
       else begin {HerjaInfo ('Virheellinen SULAKEarvo');}HerjaInfo ('Sulakkeen KOKO ei vastaas sulakeTYYPPIä');
                  ZS_Frm.ZS_Mm2Cm.SetFocus;  end
  else begin      HerjaInfo ('Virheellinen merkkijono SULAKEarvona');
                  ZS_Frm.ZS_Mm2Cm.SetFocus;  end; end;
//..................................................................................................
function okSuc :boolean;      var ostr,ustr :string;
   function sijTypOK (vrtS :string) :boolean;      begin
      result := false;
      if fSu_Sama (ustr,vrtS)  then begin
         result := true;
         ostr := vrtS;  end;   end;                //<Sijoitetaan oikeamuotoisena
begin          {su_OFAg su_OFAm   (su_IECg) su_IECgAR su_IECgYR   (su_IECd) su_IECdAR su_IECdYR}
   result := false;
   ustr := ZS_Frm.ZS_SuTypCm.Text;
   if sijTypOK (su_OFAg)    or  sijTypOK (su_OFAm)    or
      sijTypOK (su_IECgAR)  or  sijTypOK (su_IECgYR)  or  sijTypOK (su_IECdAR)  or  sijTypOK (su_IECdYR)
      then result := true
      else begin  HerjaInfo ('Käytä vain pudotusvalikon vaihtoehtoja!');
                  ostr := su_IECgYR;  end;
   suCs := ostr;
   ZS_Frm.ZS_SuTypCm.Text := suCs;
end;//okSuc
//..................................................................................................
function okIk :boolean;      var r :real;  i,code :integer;   s :string;   begin
  result := false;                              //,'LMed :. Ei saa kutsua Sval2 ja 4:llä, missä LMed=Tk
{ZS_Frm.ZS_InfRv1.Caption := BxtEd;}
{BxtNyt := }fBxtNyt('okIk');                    //<'+130.0:  Kaikkien Bxien nimet +arvot. Nyt kirjoitetaankin fileeseen.
     s := ZS_Frm.ZS_LMed.Text;
     for i := 1 to Length (s)  do  if s[i] =','  then s[i] := '.'; //<Korjataan ',' => '.'
     ZS_Frm.ZS_LMed.Text := s;
  Val(s, r,Code);                               //< code <> 0  =Luku ei muodostunut oikein
  if code=0                                     //'VAL muokkaa TEXT :stä r :lle arvon, jos CODE=0
  then if (r < Isu) //and (r <= 100000)         //<<<<<<<<<<<< kutsu OKISU oltava tehty EKAX !!!!!!!!!!
       then begin HerjaInfo ('VIRTA-arvo Ik=' +fRmrkt0(Ik,1,2)  +' oltava > In=' +Ints(Isu));
                  ZS_Frm.ZS_LMed.SetFocus;  end
       else begin result := true;
                //Ik := fMuokDesx   (r,100,2);    end //<Muuttaa arvoa vain jos OK
                  Ik := fMuokDesRaj (r,100,1);    end //<Muuttaa arvoa vain jos OK.  9.0.1
  else begin      HerjaInfo ('Virheellinen merkkijono "' +s +'" VIRTA-arvona Ik');
                  ZS_Frm.ZS_LMed.SetFocus;  end;
{BxtEd := BxtNyt; //<,+130.0
ZS_Frm.ZS_InfRv2.Caption := BxtNyt;}
end;//okIk
//..................................................................................................
function okTk :boolean;      var r :real;  i,code :integer;   s :string;   ok :boolean;      begin
  fBxtNyt('okTk');
  ok := false;  //r := 0;//+130.0
  case Sval of
     2 :s := ZS_Frm.ZS_SuTimCm.Text;                            //<+130.0
     3 :s := ZS_Frm.{ZS_LMed}ZS_SuTimCm.Text;                   //< 130.0 T=>L ZS_TMed, 130.1=>SuTim
   else s := ZS_Frm.{ZS_LMed}ZS_SuTimCm.Text;  end;             //<Sval=4
  for i := 1 to Length (s)  do  if s[i] =','  then s[i] := '.'; //<Korjataan ',' => '.'
  case Sval of
     2 :ZS_Frm.ZS_SuTimCm.Text := s;                            //<'130.0:  Vaikkakin korjattu jo ZS_SuTimCmExit´ssä
     3 :ZS_Frm.{ZS_LMed}ZS_SuTimCm.Text := s;                   //<,130.0 T=>L,  130.1=>SuTim
     4 :ZS_Frm.{ZS_LMed}ZS_SuTimCm.Text := s;  end;
(*case Sval of                                                  //, code <> 0  =Luku ei muodostunut oikein    <,,-130.1
     2 :Val(ZS_Frm.ZS_SuTimCm.Text,r,Code);                     //<Sval=2  +130.0
     3 :Val(ZS_Frm.{ZS_LMed}ZS_SuTimCm.Text, r,Code);  //<Sval=3   130.0 T=>L 130.1=>SuTim
     4 :Val(ZS_Frm.ZS_LMed.Text, r,Code); end;                  //<Sval=4*)
  Val(s, r,Code);                                               //<+130.1
  if code=0
  then begin
     if (r < fTimAR/2) or (r > fTimYR*2)
     then begin  HerjaInfo ('Sallittu AIKA-arvo ' +fTimARs2 + ' - ' +fTimYRs2 +'s (tarkkuusalue ' +
                            fTimARs +' - ' +fTimYRs +')');
                 case Sval of
                    2 :ZS_Frm.ZS_SuTimCm.SetFocus;                     //+130.0
                    3 :ZS_Frm.{ZS_TMed}{ZS_LMed}ZS_SuTimCm.SetFocus;   //<130.0 T=>L  130.1=>SuTim
                    4 :ZS_Frm.ZS_LMed.SetFocus;  end; end
     else ok := true;                                                  //<Muuttaa arvoa vain jos OK
  end//if code=0
  else begin  HerjaInfo ('Virheellinen merkkijono AIKA-arvona');
              case Sval of                                 //<+130.0
               2,3 :ZS_Frm.ZS_SuTimCm.SetFocus;
               //3 :;//                                              ZS_Frm.{ZS_TMed}{ZS_LMed}ZS_SuTimCm.SetFocus;      //<130.0 T=>L  <'130.1=>SuTim
                 4 :ZS_Frm.ZS_LMed.SetFocus;  end;
  end;
  if ok  then begin                             //<Muuttaa arvoa vain jos OK.  9.0.1
     case Sval of                               //<,+130.0
      //3 :Ik := fMuokDesRaj (r,100,2);         //<,+10.0.1
      2,3,4 :Tk := fMuokDesRaj (r,100,2);  end; //<+130.0:  3
  end;
  result := ok;
end;//okTk
//..................................................................................................
function okSftk :boolean;      var r :real;  i,code :integer;   s :string;   begin
  okSftk := false;
(*   if Sval=3                                              Sval=3 on ainoa, missä oli xMed käytössä, muissa TLbl +TMed 130.1:  Nyt kaikissa xMed (ja xLbl)
        then s := ZS_Frm.ZS_xMed.Text
        else s := ZS_Frm.{ZS_TMed}ZS_SuTimCm.Text; //<+130.1
     for i := 1 to Length (s)  do  if s[i] =','  then s[i] := '.'; //<Korjataan ',' => '.'
     if Sval=3
        then ZS_Frm.ZS_xMed.Text := s
        else ZS_Frm.{ZS_TMed}ZS_SuTimCm.Text := s; //<+130.1
  if Sval=3
     then Val(ZS_Frm.ZS_xMed.Text, r,Code)
     else Val(ZS_Frm.{ZS_TMed}ZS_SuTimCm.Text, r,Code);     //< code <> 0  =Luku ei muodostunut oikein. VAL muokkaa TEXT :stä r :lle arvon, jos CODE=0
'''''*)
  s := ZS_Frm.ZS_xMed.Text;                                 //<,,130.1:  Nyt kaikissa xMed (ja xLbl)
    for i := 1 to Length (s)  do  if s[i] =','  then s[i] := '.'; //<Korjataan ',' => '.'
  ZS_Frm.ZS_xMed.Text := s;
  Val(ZS_Frm.ZS_xMed.Text, r,Code);                         //< code <> 0  =Luku ei muodostunut oikein. VAL muokkaa TEXT :stä r :lle arvon, jos CODE=0
                                                            //<''130.1
  if code=0
  then if ((r < -50) or (r > 50)) and (Sval<>4)
       then begin HerjaInfo ('KÄYRÄNSIIRRON arvo Sft <> -50..50%');
                  if Sval=3  then ZS_Frm.ZS_xMed.SetFocus                  //<Focus takas
                             else ZS_Frm.{ZS_TMed}ZS_SuTimCm.SetFocus;  end  //<Focus takas, 130.1
       else begin okSftk := true;
                  Sftk := r;    end             //<Muuttaa arvoa vain jos OK
  else begin      HerjaInfo ('Virheellinen merkkijono KÄYRÄNSIIRTOarvona Sft');
                  if Sval=3  then ZS_Frm.ZS_xMed.SetFocus             //<Focus takas
                             else ZS_Frm.{ZS_TMed}ZS_SuTimCm.SetFocus;  end; end; //<Focus takas, 130.1
{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%}
function SFSinfo :string;                     BEGIN
   SFSinfo := 'SFS 5468, IEC 269 / ABB Oy:   OFAA,  OFAM.'+ CLR_REB+
              '   Arvot luotettavia alueella:  0.01s (0.1s dZ) ... 100s (OFAM,IEC) ... 10000s (OFAA).'+FNT_B0;  end;
function TOLinfo :string;                     BEGIN
   TOLinfo := 'IEC-sulaketyyppien tunnisteosat  <b>yr/ar</b> = ylä-/alarajakäyrän mukaan.     '+
              'Huomioi valmistajakohtainen TOLERANSSI (n. ±10%).';  end;
function SFTinfo :string;                     BEGIN
{ result := 'Sft  [%]  =  Virta-akselin siirto:  <0%  = aika kasvaa, virta pienenee,'+
             '    >0%  = aika pienenee, virta kasvaa.';}
  result := 'Sft  [%]  =  Toimintapisteen siirto (kun sulakkeen toiminta-aika ajatellaan pysyvän vakiona):   '+
            '<b><0% = Vasemmalle</b> =Ik pienenee,   <b>>0% = Oikealle</b> =Ik kasvaa.';  end;//<=UUSIN}
procedure InfoRivitCapt;      begin //130.1 koottu yhdeksi PRC´ksi.
   ZS_InfRv_(1, SFSinfo);
   ZS_InfRv_(2, TOLinfo);
   ZS_InfRv_(3, SFTinfo);
end;
{===========================================================================}
FUNCTION tarkkaYli (tim :Real;  VAR palS :string):boolean;      var sa :string;   YLI :boolean;
   procedure testSij (sq :string;  ar,yr :real);
      procedure sij (si :string);      begin
         palS := si;   YLI := true;    end;
   begin
      IF tim=0     THEN sij ('(' +fRmrkt0(ar,1,2) +'-' +fRmrkt0(yr,1,0) +'s)')  else // "(0.01s-100s)"
      IF tim<ar    THEN sij ('<' +fRmrkt0(ar,1,2) +'s')                         else // "<0.01s"
      IF tim>yr    THEN sij ('>' +fRmrkt0(yr,1,0) +'s');                             // ">100s"

      if YLI  then palS := palS +'(' +sq +')';
   end;
BEGIN
   palS := '';   sa := '';   YLI := false;
            if fSu_Sama (suCs,su_OFAg)
   then  testSij ('OFAA',0.01,10000)
   else     if fSu_PerusSama (suCs,su_IECd)
   then  testSij ('IECdZ',0.1,100)
   else begin
            if fSu_Sama (suCs,su_OFAm)  then sa := 'OFAM'
                                        else sa := 'IECgG';
            testSij (sa,0.01,100);   end;

   if YLI  then palS := CLR_REB     + palS +FNT_B0
           else palS := COLOR_GREEN +'ok'  +FNT_B0;
   Result := YLI;
END;//tarkkaYli
{---------------------------------------------------------------------------}
function fSuC :string;     var s :string;      begin
   s := suCs;
   result := '<center>'+S;
end;
//==================================================================================================}
procedure SijTstAjoon(rv :integer;  Nimi :string; Vis :boolean;  Capt :string;  Lft,OikR :integer);  //VAR si :string;
                                                                                                     //Tosi hyvä +havainnollinen, hyvät vertailuun. +130.1
   function boS(boo :boolean) :string;      begin
      if boo then result := 'tr'  else result := 'FA';  end;
begin//............................
{   if fRePunKehiAjo  then
   WITH ZS_Frm.ZS_StrGrid  DO BEGIN
      Cells[1,rv] := '<left>' +Nimi +':  ';
       Cells[2,rv] := 'Visible=' +boS(vis);
        if Pos('LBL',AnsiUpperCase(Nimi))>0
           then si := '<left>Capt=' +Capt
           else si := '<left>Text=' +Capt;
        Cells[3,rv] := si;
         Cells[4,rv] := 'Lft='        +Ints(Lft);
          Cells[5,rv] := 'OikR='      +Ints(OikR);
   END;}
end;
{==========================================================================================<Sval=1>}
PROCEDURE Ik_sv1_Cells;     var S,yliS :String;   rv :integer;  ar :real; //TÄNNE vain kun Sval=1.
BEGIN//sq := 'Ik_sv1_Cells/Sval1:  ';            //,ChkR_x(Välirivi,OhaOsa,TulostettavaArvoRvLkm)<<<<<<<<<<<<<<<<
  if ChkR_n(1,Aval,1) then                       //<Aset R_u,n. JosEiMahdu, kysyyToimenpit. Vr TÄSSÄ 1=JosEriSval
  WITH ZS_Frm.ZS_StrGrid  DO BEGIN               //'Sval := Aval ######## [c,r] = 0=ekaCOL, 0=ekaROW, 1=toka jne.
    asetaSval1;                                  //<CmBxit yms. asetellaan vasta jos tuloste mahtuu gridiin #####
    rv := R_u-2;                                 //< -2, koska ChkR_x:lle annettiin OTS+TULrvTarve ja se palaut-
{"  if (rv=0) or (ots<>Sval)  then begin         //'ti KUMUL.riviLkmn, joten ao. ekaCellRow = R_x - (OTS+TulTarv)
      ots := Sval; //<OhjaaSeur.ChkR_() -kutsuja ################################################################}
    if ChkOtsTarve (Sval,1, 3,myTextBase.Get(S_15), rv)  then begin  //< rv ja R_n muuttuu tarvitaessa, Sval asetetaan aina
         if rv=0  then //1'Rvja 3'sarake, mistä str etsitään'''''''''''''''''''''''''''''''''''''''''''''''''''''
      Cells[0,rv] := blu('Rv')  else Cells[ 0,rv] := COLOR_SILVER +fImrkt0(rv,1) +FNT_0; //<KaiTextBase
      Cells[1,rv] := blu(myTextBase.Get(S_16));
      Cells[2,rv] := blu(' Typ ');                                                       //<KaiTextBase
      Cells[3,rv] := blu('  '+myTextBase.Get(S_15));
      Cells[4,rv] := blu('  '+myTextBase.Get(S_17));
      Cells[5,rv] := blu('  ='+myTextBase.Get(S_18));
      Cells[6,rv] := blu('  '+myTextBase.Get(S_21));
    end;//if..then
   Cells[0,rv+1] := fImrkt0(R_n-1,1);
   Cells[1,rv+1] := fImrkt0(Isu,1);
 //Cells[0,rv+1] := rvno(R_n)+'<right>'+fImrkt0(Isu,1);
   Cells[2,rv+1] := fSuC;
 //Cells[3,rv+1] := fDemMrkt0 (0,Ik, 1,fDes0 (Ik,100,2)); //<100:0, maxDes=1 esim. 100, 10.1, 0.1 ->Nyt: 1.00
   Cells[3,rv+1] := fDemMrkt0 (0,Ik, 1,fDsm (Ik,100,0));  //<100:0, maxDes=1 esim. 100, 10.1,  1.10 ...     9.0.1
   Cells[4,rv+1] := fRmrkt0(Sftk,1,1);
      ar := Ik * (1+ Sftk/100);                //<,Loitontaa käyrää I-akselilla=Antaa isomman ajan samalla Ik:lla
      Tk := Tik_R (suCs,Isu, ar);
    //S := fDemMrkt0(1,Tk, 1,fDes0 (Tk,100,3));          //<DemMrkt(1=DEMOtesti  0=EiEdesTestiä
    //S := fDemMrkt0(1,Tk, 1,2{fDsm (Tk,100,2)});        //<DemMrkt(1=DEMOtesti  0=EiEdesTestiä             9.0.1
      S := fDemMrkt0(1,Tk, 1,fDesDyn (Tk,0.01));                                                        //<+130.0
      if Tk<=0  then S := '- - -';                       //'+130.0:  Nyt AINA 2 desim.
      if tarkkaYli (Tk,yliS)  then S := CLR_REB +S +FNT_B0;
   Cells[5,rv+1] := S;
   Cells[6,rv+1] := yliS;//fS_tarkkuus (Tk);
  end; {with}
END; {Ik_sv1_Cells}
{==========================================================================================<Sval=2>}
PROCEDURE Tk_sv2_Cells;      var S,yliS :String;   rv :integer; //Ava2=2/3. tänne.
BEGIN//sq := 'Tk_sv2_Cells/Sval2:  ';            //,ChkR_x(Välirivi,OhaOsa,TulostettavaArvoRvLkm)<<<<<<<<<<<<<<<<
  if ChkR_n(1,Aval,1) then                       //<Aset R_u,n. JosEiMahdu, kysyyToimenpit. Vr TÄSSÄ 1=JosEriSval
  WITH ZS_Frm.ZS_StrGrid  DO BEGIN               //'Sval := Aval ######## [c,r] = 0=ekaCOL, 0=ekaROW, 1=toka jne.
    asetaSval2;                                  //<CmBxit yms. asetellaan vasta jos tuloste mahtuu gridiin #####
    rv := R_u-2;                                 //< -2, koska ChkR_x:lle annettiin OTS+TULrvTarve ja se palaut-
{"  if (rv=0) or (ots<>Sval)  then begin         //'ti KUMUL.riviLkmn, joten ao. ekaCellRow = R_x - (OTS+TulTarv)
      ots := Sval; //<OhjaaSeur.ChkR_() -kutsuja ################################################################}
    if ChkOtsTarve (Sval,1, 3,myTextBase.Get(S_18), rv)  then begin  //< rv ja R_n muuttuu tarvitaessa, Sval asetetaan aina
         if rv=0  then //1'Rvja 3'sarake, mistä str etsitään'''''''''''''''''''''''''''''''''''''''''''''''''''''
      Cells[0,rv] := blu('Rv')  else Cells[ 0,rv] := COLOR_SILVER +fImrkt0(rv,1) +FNT_0; //<KaiTextBase
      Cells[1,rv] := blu(myTextBase.Get(S_16));
      Cells[2,rv] := blu(' Typ ');                                                       //<KaiTextBase
      Cells[3,rv] := blu('  '+myTextBase.Get(S_18)+' ');
      Cells[4,rv] := blu('  '+myTextBase.Get(S_17));
      Cells[5,rv] := blu('  ='+myTextBase.Get(S_15));
      Cells[6,rv] := blu('  '+myTextBase.Get(S_21));
    end;//if..then
   Cells[0,rv+1] := fImrkt0(R_n-1,1);
   Cells[1,rv+1] := fImrkt0(Isu,1);
 //Cells[0,rv+1] := rvno(R_n)+'<right>'+fImrkt0(Isu,1);
   Cells[2,rv+1] := fSuC;
    //S := fDemMrkt0(0,Tk, 1,2{fDsm (Tk,100,2)});        //<DemMrkt(1=DEMOtesti  0=EiEdesTestiä             9.0.1
      S := fDemMrkt0(0,Tk, 1,fDesDyn (Tk,0.01));                                                        //<+130.0
   if tarkkaYli (Tk,yliS)  then S := CLR_REB +S +FNT_B0; //'130.0:  Nyt AINA desim=2
   Cells[3,rv+1] := S;
   Cells[4,rv+1] := fRmrkt0(Sftk,1,1);
      Ik := Ikt_R (suCs,Isu,Tk) * (1+ sftk/100);
    //S := fDemMrkt0 (1,Ik, 1,fDes0 (Ik,100,2));         //<100:0, maxDes=1 esim. 100, 10.1, 0.1 ->Nyt: 1.00
      S := fDemMrkt0 (1,Ik, 1,fDsm (Ik,100,0));          //<100:0, maxDes=1 esim. 100, 10.1, 0.1 ->Nyt: 1.00 9.0.1
      if tarkkaYli (Tk,yliS)  then S := CLR_REB +S +FNT_B0;
   Cells[5,rv+1] := S;
   Cells[6,rv+1] := yliS;//fS_tarkkuus (Tk);
  end; {with}
END; {Tk_sv2_Cells}
{==========================================================================================<Sval=3>}
PROCEDURE Ik_sv3_Cells;      var S,yliS :String;  ero :real;   rv,u :integer;      BEGIN
//sq := 'Ik_sv3_Cells/Sval3:  ';            //,ChkR_x(Välirivi,OhaOsa,TulostettavaArvoRvLkm)<<<<<<<<<<<<<<<<
  if ChkR_n(1,Aval,1) then                       //<Aset R_u,n. JosEiMahdu, kysyyToimenpit. Vr TÄSSÄ 1=JosEriSval
  WITH ZS_Frm.ZS_StrGrid  DO BEGIN               //'Sval := Aval ######## [c,r] = 0=ekaCOL, 0=ekaROW, 1=toka jne.
    asetaSval3;                                  //<CmBxit yms. asetellaan vasta jos tuloste mahtuu gridiin #####
    rv := R_u-2;                                 //< -2, koska ChkR_x:lle annettiin OTS+TULrvTarve ja se palaut-
{"  if (rv=0) or (ots<>Sval)  then begin         //'ti KUMUL.riviLkmn, joten ao. ekaCellRow = R_x - (OTS+TulTarv)
      ots := Sval; //<OhjaaSeur.ChkR_() -kutsuja ################################################################}
    if ChkOtsTarve (Sval,1, 3,myTextBase.Get(S_22), rv)  then begin  //< rv ja R_n muuttuu tarvitaessa, Sval asetetaan aina
         if rv=0  then //1'Rvja 3'sarake, mistä str etsitään'''''''''''''''''''''''''''''''''''''''''''''''''''''
      Cells[0,rv] := blu('Rv')  else Cells[ 0,rv] := COLOR_SILVER +fImrkt0(rv,1) +FNT_0; //<KaiTextBase
      Cells[1,rv] := blu(myTextBase.Get(S_16));        //< Sulake[A]
      Cells[2,rv] := blu(' Typ ');                     //< Typ                           //<KaiTextBase
      Cells[3,rv] := blu('  '+myTextBase.Get(S_22));   //< Itod.[A]      Ik
      Cells[4,rv] := blu('  Aika [s]');                //< Aika [s]      Tk
      Cells[5,rv] := blu('  '+myTextBase.Get(S_17));   //< Sft [%]
      Cells[6,rv] := blu('  ='+myTextBase.Get(S_23));  //< Ero [%]
      Cells[7,rv] := blu('Tarkk.ylitys');
    end;//if..then
 //if NOT okIk or NOT okTk  then //<,+130.0:  Muuten ei Ik ja Tk päivity.
   u := 0;                                             //<,,+130: Debuggaukseen.
   if NOT okIk  then u := u+1;
   if (u=0) then if NOT okTk  then u := u+1;
   if u>0  then
      HerjaInfo ('NolaS.INC:  Ik taiTk -muuttujissa virhe, ilmoita valmistajalle.');
   Cells[0,rv+1] := fImrkt0(R_n-1,1);
   Cells[1,rv+1] := fImrkt0(Isu,1);
                    S := fSuC;   //<'IECgG' tms.
   Cells[2,rv+1] := S;
 //Cells[3,rv+1] := fDemMrkt0 (0,Ik, 1,fDes0 (Ik,100,1)); //<100:0, maxDes=1 esim. 100, 10.1, 0.1
   Cells[3,rv+1] := fDemMrkt0 (0,Ik, 1,fDsm (Ik,100,0));  //<100:0, maxDes=1 esim. 100, 10.1, 0.10          9.0.1
    //S := fDemMrkt0 (0,Tk, 1,fDes0 (Tk,100,3));          //<100:0, maxDes=3 esim. 100  10.1  0.1  0.01  0.001
    //S := fDemMrkt0 (0,Tk, 1,fDsm (Tk,100,1));           //<100:0, maxDes=3 esim. 100  10.1  0.1  0.01  0.001 =9.0.1
      S := fDemMrkt0 (0,Tk, 1,fDesDyn (Tk,0.01));         //<Tk=0.01=>0.01,  0.0005=>0.001,  0.0003=>0.000
      if tarkkaYli (Tk,yliS)  then S := CLR_REB +S +FNT_B0;
   Cells[4,rv+1] := S;
   Cells[5,rv+1] := fRmrkt0(Sftk,1,1);
      ero := Ikt_R (suCs,Isu,Tk) * (1+ Sftk/100); //<Ero apuna
      ero := ((ero-Ik)/Ik)*100;
      S := fDemMrkt0(1,ero, 1,1);                //<DemMrkt(1=DEMOtesti  0=EiEdesTestiä
   Cells[6,rv+1] := S;
   Cells[7,rv+1] := yliS;//fS_tarkkuus (Tk);
                 with ZS_Frm.ZS_SuTypLbl  do     //<<Tosi hyvä ja havainnollinen.
                      SijTstAjoon(10,'SuTypLbl',Visible,Caption,Left,Left+Width);
                 with ZS_Frm.ZS_SuTypCm   do
                      SijTstAjoon(11,     'SuTypCm',Visible,Text,Left,Left+Width);
                 with ZS_Frm.ZS_Mm2Lbl    do
                      SijTstAjoon(12,     'Mm2Lbl',Visible,Caption,Left,Left+Width);
                 with ZS_Frm.ZS_Mm2Cm     do
                      SijTstAjoon(13,     'Mm2Cm',Visible,Text,Left,Left+Width);
                 with ZS_Frm.ZS_LLbl      do
                      SijTstAjoon(14,     'LLbl',Visible,Caption,Left,Left+Width);
                 with ZS_Frm.ZS_LMed      do
                      SijTstAjoon(15,     'Lmed',Visible,Text,Left,Left+Width);
                 with ZS_Frm.ZS_TLbl      do
                      SijTstAjoon(16,     'TLbl',Visible,Caption,Left,Left+Width);
                 with ZS_Frm.ZS_TMed      do
                      SijTstAjoon(17,     'TMed',Visible,Text,Left,Left+Width);
                 with ZS_Frm.ZS_SuTimCm   do
                      SijTstAjoon(18,    'SuTimCm',Visible,Text,Left,Left+Width);
  end; {with}
END; {Ik_sv3_Cells}
{==========================================================================================<Sval=4>}
PROCEDURE Ik_TxSv4_Cells;      var S,yliS :String;  rv,rw,rn, su1,su2,su3,su4, o :Integer;
  PROCEDURE seurSu (VAR su :Integer);       BEGIN
    CASE su OF
       0 :su := 4;   20 :su :=25;    50 :su := 63;   160 :su :=200;   500 :su := 630;
       4 :su := 6;   25 :su :=32;    63 :su := 80;   200 :su :=250;   630 :su := 800;
       6 :su :=10;   32 :su :=40;{!} 80 :su :=100;   250 :su :=315;   800 :su :=1000;
      10 :su :=16;   35 :su :=40;{!}100 :su :=125;   315 :su :=400;  1000 :su :=1250;
      16 :su :=20;   40 :su :=50;   125 :su :=160;   400 :su :=500;  //Käytössä 630 asti
    else  su := 0; END;          {!}{=35->40 ohittuu!!!}
  END; {seurSu}
  function c_su :string;      begin  result := fSuC +c_ +c_ +c_ +'<right>';  end;
  function si_S (Isu :integer) :string;      var r :real;  su,yliSa :string;      begin
     r := Ikt_R (suCs,Isu,Tk) * (1+ Sftk/100);
   //r := 55;
   //su := fDemMrkt0 (1,r, 1,fDes0 (r,100,1));          //<100:0, maxDes=1 esim. 100, 10.1, 0.1
     su := fDemMrkt0 (1,r, 1,fDsm (r,100,0));           //<100:0, maxDes=1 esim. 100, 10.1, 0.1             9.0.1
     if tarkkaYli (Tk,yliSa)  then su := CLR_REB +su +FNT_B0;
     result := su;
  end;
//..........................................
BEGIN//sq := 'Ik_TxSv4_Cells/Sval4:  ';          //,ChkR_x(Välirivi,OhaOsa,TulostettavaArvoRvLkm)<<<<<<<<<<<<<<<<
  if ChkR_n(1,Aval,5) then                       //<Aset R_u,n. JosEiMahdu, kysyyToimenpit. Vr TÄSSÄ 1=JosEriSval
  WITH ZS_Frm.ZS_StrGrid  DO BEGIN               //'Sval := Aval ######## [c,r] = 0=ekaCOL, 0=ekaROW, 1=toka jne.
    asetaSval4;                                  //<CmBxit yms. asetellaan vasta jos tuloste mahtuu gridiin #####
    rv := R_u-5-1;                               //< -5-1, koska ChkR_x:lle annettiin OTS+TULrvTarve ja se palaut-
{"  if (rv=0) or (ots<>Sval)  then begin         //'ti KUMUL.riviLkmn, joten ao. ekaCellRow = R_x - (OTS+TulTarv)
      ots := Sval; //<OhjaaSeur.ChkR_() -kutsuja ################################################################}
    if ChkOtsTarve (Sval,5, 3,myTextBase.Get(S_16), rv)  then begin  //< rv ja R_n muuttuu tarvitaessa, Sval asetetaan aina
         if rv=0  then //5'Rvja 3'sarake, mistä str etsitään'''''''''''''''''''''''''''''''''''''''''''''''''''''
      Cells[ 0,rv] := blu('Rv')  else Cells[ 0,rv] := COLOR_SILVER +fImrkt0(rv,1) +FNT_0; //<KaiTextBase
      Cells[ 1,rv] := blu(myTextBase.Get(S_16));
      Cells[ 2,rv] := blu('  '+myTextBase.Get(S_15));
      Cells[ 3,rv] := blu(' '+myTextBase.Get(S_16));
      Cells[ 4,rv] := blu('  '+myTextBase.Get(S_15));
      Cells[ 5,rv] := blu(' '+myTextBase.Get(S_16));
      Cells[ 6,rv] := blu('  '+myTextBase.Get(S_15));
      Cells[ 7,rv] := blu(' '+myTextBase.Get(S_16));
      Cells[ 8,rv] := blu('  '+myTextBase.Get(S_15));
      Cells[ 9,rv] := blu(' '+myTextBase.Get(S_18));
      Cells[10,rv] := blu('  '+myTextBase.Get(S_17));
      Cells[11,rv] := blu('  '+myTextBase.Get(S_21));
    end;//if..then
    rw := R_n-5;                           //<Koska ChkR_ kasvatti 5 t. 6:lla (6= 1 tyhjä välirivi)
    rn := R_u-5;
//  HerjaInfo ('Sv='+fImrkt0(Sval,1)+' Sn='+fImrkt0(R_u,1));     //<Koe
    su1 := 0;   su2 := 20;   su3 := 63;   su4 := 200;
    o := -1;
    REPEAT  o := o+1;                      //<1.arvo = o+0
                      Cells[0,rn+o] := fImrkt0(rw+o,1);
       seurSu (su1);  Cells[1,rn+o] := c_su +fImrkt0(su1,1);
                         S := si_S (su1);
                      Cells[2,rn+o] := S;
       seurSu (su2);  Cells[3,rn+o] := c_su+fImrkt0(su2,1);
                         S := si_S (su2);
                      Cells[4,rn+o] := S;
       seurSu (su3);  Cells[5,rn+o] := c_su+fImrkt0(su3,1);
                         S := si_S (su3);
                      Cells[6,rn+o] := S;
       seurSu (su4);  Cells[7,rn+o] := c_su+fImrkt0(su4,1);
                         S := si_S (su4);
                      Cells[8,rn+o] := S;
    UNTIL su1=20;
    for o := 0 to 4  do begin
                        S := fDemMrkt0(0,Tk, 1,2{fDsm (Tk,100,2)});              //<DemMrkt(1=DEMOtesti  0=EiEdesTestiä             9.0.1
                           if tarkkaYli (Tk,yliS)  then S := CLR_REB +S +FNT_B0; //'130.0:  Nyt AINA desim=2
                        Cells[ 9,rn+o] := S;  end;
    for o := 0 to 4  do Cells[10,rn+o] := fRmrkt0(Sftk,1,1); {,,,KOE=Kommentisulkeet:,,,,,,,,,,,,,,,}
    for o := 0 to 4  do Cells[11,rn+o] := yliS;//fS_tarkkuus (Tk);  //<'Suljettu vex VAIN KOKEILUA varten}
  //for o := 0 to 4  do Cells[11,rn+o] := 'RCnt'+fImrkt0(ZS_Frm.ZS_StrGrid.RowCount,1);
  //for o := 0 to 4  do Cells[12,rn+o] := 'n'+fImrkt0(R_u,1)+'  r'+fImrkt0(rn,1)+'+o'+fImrkt0(o,1);
//  if R_u=RowCount-1  then TopRow := RowCount-VisibleRowCount-FixedRows+1;
  //Visible := true;                         //<Asetettiin FA FNC ChkR_ :ssä, ettei rvSiirrot näkyisi
  end; {with}                                //' +1 = varmasti ehjä rivi (joskus vaakaviiva jää vex)
END; {Ik_TxSv4_Cells}
{################################################################# NOLAs.INC}










