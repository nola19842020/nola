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

//################################################################# KaapHin.INC
{Lukee KaapHinD.NOL -tekstitiedoston ja siirtää alustettuun KAHITAU -taulukkoon
                          {Taulukon rakenne:        ,,= Osoite [1..maxkaap] MÄÄRÄYTYY POIKKIPINNASTA
                                   [1] = mm2(1.5)   MCMK.nimi   \.laji  \.jLkm   \.oh   \.kh  \.khme
                                                    AMCMK.nimi  \.laji  \.jLkm   \.oh   \.kh  \.khme
                                                    AXMK.nimi   \.laji  \.jLkm   \.oh   \.kh  \.khme
                                                    SVjar.nimi  \.laji  \.jLkm   \.oh   \.kh  \.khme
                                   [2] = mm2(2.5)   MCMK.nimi   \.laji  \.jLkm   \.oh   \.kh  \.khme
                                                    AMCMK.nimi  \.laji  \.jLkm   \.oh   \.kh  \.khme
                                                    AXMK.nimi   \.laji  \.jLkm   \.oh   \.kh  \.khme
                                                    SVjar.nimi  \.laji  \.jLkm   \.oh   \.kh  \.khme
                                   [3] = mm2(4)     MCMK.nimi   \.laji  \.jLkm   \.oh   \.kh  \.khme
                                    .               AMCMK.nimi  \.laji  \.jLkm   \.oh   \.kh  \.khme
                                    .               AXMK.nimi   \.laji  \.jLkm   \.oh   \.kh  \.khme
                                    .               SVjar.nimi  \.laji  \.jLkm   \.oh   \.kh  \.khme
                                    .     ''''''jne.}
PROCEDURE LueKahi; //,,,,,KAIKKI PRC:t + FNC:t voisi olla LueSijKahi :n sisällä
      VAR KahiPolkuFilen :string;  //nm :string;  ff :TextFile;
//==================================================================================================
   FUNCTION mm2r (i :integer) :real;
   BEGIN  CASE i OF
        1 :mm2r := 1.5;    2 :mm2r := 2.5;     3 :mm2r :=   4;     4 :mm2r :=   6;
        5 :mm2r :=  10;    6 :mm2r :=  16;     7 :mm2r :=  25;     8 :mm2r :=  35;
        9 :mm2r :=  50;   10 :mm2r :=  70;    11 :mm2r :=  95;    12 :mm2r := 120;
       13 :mm2r := 150;   14 :mm2r := 185;    15 :mm2r := 240;    16 :mm2r := 300;
       17 :mm2r := 600;   18 :mm2r := 900;    19 :mm2r :=1200;    20 :mm2r := 2400;
     else  mm2r := 3200;{21}  END;
   END;
//==================================================================================================
   PROCEDURE alusta;   VAR i :Integer;   rec :aslaji;     BEGIN                  // o = 1,5..3200=21
      with rec  do begin nimi := '';  laji := TRUE;  jLkm := 0;  oh := 0;  kh := 0;  khme := 0;  end;
      FOR i := 1 TO KHmaxNmm2  DO  WITH kahitau [i] DO
      BEGIN  mm2 := mm2r (i);    //<MM2 -arvo jää voimaan. AINOA SIJOITUS TÄSSÄ ####################
            {MMJ    := rec;}
             MCMK   := rec;
             AMCMK  := rec;
             AXMK   := rec;
             SVjarj := rec;
   END; END;
//==================================================================================================
//==================================================================================================
                                                                 //,RV=ao.sorcerivi  AOR=ao.arvorivi (<>';')
   PROCEDURE LueSijKahi;      VAR i,mja,rv,aor,sarak,MMJryh :Integer;   Qrec :aslaji;   Qmm2 :real;
                                  sorc, s :string;               //'MMJryh{1=MMJ}  1=MCMK  2=AMCMK jne.
                                  ohitaLoput,onarvoja :boolean;  //'SARAK  1=mm2   2=Nimi  3=A/C   jne.
      procedure breakpt;    begin end;
      //............................................................................................
      procedure sijoita (Umm2 :real;  nimiRyh :Integer;  Urec :aslaji);   VAR o :integer;   begin
         o := mm2i (Umm2);                               //<o = 1..21 (max=25)
         CASE nimiRyh OF {1 :kahitau [o].MMJ :=    Urec;}//<,mm2i (1.5)=1  (2.5)=2  (4)=3  (6)=4 jne.
                          1 :kahitau [o].MCMK :=   Urec; //<'',,Testattava: if Qmm2>0 <<<<<<<
                          2 :kahitau [o].AMCMK :=  Urec;
                          3 :kahitau [o].AXMK :=   Urec;
                       else  kahitau [o].SVjarj := Urec;  end;//case
      end;//sijoita
      //............................................................................................
      procedure sorceherja;   begin
         MessageDlg ('Kaapelihintatiedostossa '''+KahiPolkuFilen+''' virhe:   Rivi: '+fImrkt0 (rv,1) +
                     '   Sarake: '+fImrkt0 (sarak,1), mtInformation, [mbOk], 0);   end;
      //............................................................................................
      function fInt (ss :string) :integer;       VAR  i :integer;    BEGIN
         if not SokI (ss,i)  then begin  sorceherja;  i := 0;   end;   Result := i;   end;
      //............................................................................................
      function fRea (ss :string) :real;          VAR  r :real;       BEGIN //,Hoitaa myös ',' -> '.'
         if not SokR (ss,r)  then begin  sorceherja;  r := 0;   end;   r := r;   Result := r;   end;
   //-----------------------------------------------------------------------------------------------
   BEGIN//LueSijKahi
      rv := 0;  aor := 0;   MMJryh := 0;
      while not Eof (KahiFile)  do begin
     {}  rv := rv+1;
     {}  Readln (KahiFile, sorc);
     {}
     {}  with Qrec  do begin  Nimi := '';  laji := false;  jLkm := 0;  oh := 0;  kh := 0;  khme := 0;  end;
     {}  onarvoja :=   false;
     {}  ohitaLoput := false;    Qmm2 := 0;                          //,s:='' PAKKO tyhjätä, muuten
     {}  i := 1;   sarak := 0;   mja := Length (sorc);   s := '';    //<seur. MMJRYH := +1 #########
     {}                                                              //,HUOM.järjestys:  i = Ekax!!!
     {}  while (i<mja)  and (sarak<7)  and  NOT ohitaLoput   do begin//<LuetaanRecordin kaikkisarakt
     {} {}  while (i<mja)  and  (sorc[i]=' ')  do                    //<Ohitetaan tyhjät
     {} {}     i := i+1;                                             //',OHITALOPUT estää jatkamisen
     {} {}                                                           // jos s[i]=';' tai(='0' AND sar=0)
     {} {}  s := '';
     {} {}  while (i<mja)  and (sorc[i]<>' ')  and  NOT ohitaLoput   do begin
     {} {}     if sorc[i]=';'   then  ohitaLoput := true
     {} {}                      else  s := s +sorc[i];   i := i+1;   end;
     {} {}
     {} {}  if (s<>'') then begin                           //,i=mja&sar=0 =AINOA arvo rivillä =EiOK
     {} {}     if (sarak=0) and ((s[1]='0') or (i=mja))                //<JuuriLueattu 1.sarake ####
     {} {}     then ohitaloput := true
     {} {}     else if (sarak=0) and (CharInSet(s[1], ['1'..'9']))  or (sarak>0)//<JuuriLueattu 1.- tai N.sar
     {} {}     then  with Qrec  do begin                               //'ja ONARVO tai 1. sar :ssa
     {} {}        onarvoja := true;                                    //' ='0' => EI ARVOKÄSITTELYÄ
     {} {}        sarak := sarak +1;
     {} {}        case sarak  of
     {} {}          1 :Qmm2 := fRea (s);  //<Qmm2 ohjaa oikeaan SOLUUN, ei kuulu Qrec :iin ############
     {} {}          2 :nimi := s;                               //<Tämä strng TULOSTUU ################
     {} {}          3 :if CharInSet(s[1], ['C','c'])  then laji := FALSE //<Cu ,,samaKuin alustettu=EiTarttisSij
     {} {}                                   else laji := TRUE; //<Aina muuten Al vaikka virheMrk
     {} {}          4 :jLkm := fInt (s);                        //<,,,0 jos virhe <<<<<<<<<<<<<<<<<<<<<
     {} {}          5 :oh :=   fRea (s);
     {} {}          6 :kh :=   fRea (s);
     {} {}        else khme := fRea (s); end;  //<Valmis: Qrec.nimi   .laji   .jLkm  .oh  .kh  .khme
     {} {}        breakpt;                     //<Tyhjä PRC breakpointia varten <<<<<<<<<<<<<<<<<<<<
     {} {}     end;//else if (sarak=0)&
     {} {}  end;//if s<>''..  with Qrec
     {}  end;//while (i<mja)..(nimiOsa<7) Nyt arvotiedot luettu, jäljellä mahd. kommenttia #########
     {}
     {}  if (s<>'') and (sarak=0) and (s[1]='0')  or  (MMJryh=0) and onarvoja
     {}     then MMJryh := MMJryh +1;               //'MMJRYH & ONARVOJA ohjaa KAHITAU [EKA=1] :een
     {}  if (MMJryh>0)  then aor := aor +1;         //'heti EKAN ARVORIVIN jälkeen #################
     {}  if aor>0  then breakpt;          //<Tyhjä PRC, jotta WatchListissä näkyisi AOR, jota eioo
     {}                                   //'vielä käytetty mihinkään ="Variable 'aor' inaccess.here
     {}  if kahitau [1].mm2>0  then breakpt;          //<Tyhjä PRC, jotta saisi KAHITAUn DelphHintin
     {}
     {}  if onarvoja  and  (MMJryh<=KHmaxTyp)   then
     {}  with Qrec  do begin   //,,Sijoitetaan tyhjiin kenttiin, jos on YKSIKIN arvo ###############
     {}     if (oh  =0)  then begin  if kh>0    then oh :=   kh   else if khme>0   then oh := khme;  end;
     {}     if (kh  =0)  then begin  if khme>0  then kh := khme   else if oh>0     then kh :=   oh;  end;
     {}     if (khme=0)  then begin  if kh>0    then khme := kh   else if oh>0     then khme := oh;  end;
     {}     if onarvoja  and (Qmm2>0)  and (jLkm>0)  and (oh>0)
     {}        then sijoita (Qmm2,MMJryh,Qrec);   //<<<#############################################
     {}  end;//with Qrec                          //'''SIJOITUS ####################################
      end;//while not Eof
      eiKahiFile := FALSE;
   end;//LueSijKahi
//==================================================================================================
//==================================================================================================
BEGIN//LueKahi
   alusta;
   eiKahiFile := TRUE;         //<Tulostuksessa käytetään herjan ohjailuun
                               //KahiFilen := 'KaapHinD.NOL';
                               //KahiPolku := 'C:\Projektit\NolaKehi\Bin\';
 //KahiPolkuFilen := fHaePolkuFilen (KAAPELIHINTA_FILE_ID); //<fHae.. siirrtty Y_.PAS´siin 12.0.05
 //KahiPolkuFilen := ExtractFileName(fHaePolkuFilen (KAAPELIHINTA_FILE_ID)); //'Antoi: Config\Config\..  Mahd. Acces violation !!!!!! -130.0
   KahiPolkuFilen := gAjoConfPath +'KaapHinD.NOL';                           //<+130.0
//¿DefsFileenZ('0 LueKahi:  gAjoConfPath= ' +gAjoConfPath +' ®® KahiPolkuFilen=' +KahiPolkuFilen +' ®® KAAPELIHINTA_FILE_ID=' +KAAPELIHINTA_FILE_ID);
 //KahiPolkuFilen := gAjoConfPath +KahiPolkuFilen;                           //<Nyt:  \\Reijo-xp\e\Projektit XE2\NolaKehi\BIN\Config\KaapHinD.NOL  =OK. -130.0
//¿DefsFileenZ('1 LueKahi:  KahiPolkuFilen=' +KahiPolkuFilen);// +CR +' ®® gAjoPath=' +gAjoPath +CR +' ®® gAjoConfPath=' +gAjoConfPath +CR +' ®® actPath=' +actPath +' <<<ONKO Conf\Conf ???');
if NOT fFileExists(KahiPolkuFilen)
   then  MessageDlg ('Kaapelihintatiedosto '''+KahiPolkuFilen+''' puuttuu, nousujohtotulostus '+
                     'tapahtuu ilman hinnoittelua!', mtInformation, [mbOk], 0)
   else try
                               //¿DefsFileenZ('AssginKahiFile 5');
         AssignFile (KahiFile, KahiPolkuFilen);
         Reset (KahiFile);
         LueSijKahi;
      except
         on E:Exception  do Close (KahiFile);
      end;//try
END;//LueKahi




