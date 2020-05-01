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

{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FileEv.INC}
{'INCLUUDATTU PaaVal.PAS :ssa #####################################################################}
{"myLicense.lisenssilaajuus"
         if (edvX.YLE.SorceCount.Arvoint>1) and (myLicense.lisenssilaajuus<>lvEXTended)
            then edvX.YLE.SorceCount.ArvoInt := 1;                                      //<'+120.5n/6U:  Jos ei EXT -laajuus, muutetaan aina yhdeksi.
 PERUSAJATUS: - Alustetaan alus_.. ja tyh_.. muuttujat, jolloin muuttujat saavat: OLETUSARVONSA,
                arvoTYYPIT, ALA- ja YLÄRAJAT kaikkiin tietueisiin: YLE, Sorc[], NjL ja edka[1..20].
              - Sijoitetaan nämä apumuuttujaan EDVX PRCssa sij_alust, johon myös luetaan tiedostoa.
              - Jos lukutilanteessa tulee virhe, suoritetaan alustus uudelleen:
                Virheen ilmenemiskohta:       Toimenpide:
                  - YLE, Sorc[n], NjL           - Täysi alustus
                  - Edka[n]                     - YLE+NjL jää luetun mukaiseksi, alust. EDKA[n-1 ..]
              - VIRHE ilmaistaan muuttujalla FNC, jonka tilaa tutkitaan aina ennen operaatioita
,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
procedure WrSS (si :string);      begin end;{VAR ff :TextFile;  fn :string;     begin //+1414
   if isDebuggerPresent  then begin
      fn := ExtractFilePath(Application.ExeName);
      fn := fn +'InifSort.txt';
      AssignFile(ff,fn);
      if fFileExists(fn)
         then Append(ff)
         else Rewrite(ff);
      Writeln(ff,si);
      CloseFile(ff);  end; end;}

//,,PrRjIndx := PrRjMm2Bx.ItemIndex; =Ilmaisee valitun riviNon (0..). Ks. EdvNew.PAS/PrRjMm2BxSelect
{  case No of
      0 = '16A 2.5/10A1.5 mm²';   <= Sul,Mm2
      1 = '10A 2.5/1.5 mm²';        - " -
      2 = '6A  2.5/1.5 mm²';        - " -
      3 = '4A  2.5/1.5 mm²';        - " -
      4 = '2A  2.5/1.5 mm²';        - " -
      5 = '4 mm² 16A/10A';          Mm2,Sul
      6 = '6 mm² 16A/10A';
      7 = '10 mm² 16A/10A';
      8 = '16 mm² 16A/10A';  end;}
procedure PrRj_SulMm2 (Inx,Palsta :integer;  VAR Sul,Mm2 :integer); //Palauttaa Index´in mukaiset SUL ja MM²  1=Vasen palsta (ennen "/")  2...=Oikea palsta ("/" jälkeen).
   procedure Sij (Sulake,Amm :integer);      begin                  //'=ResurssilaskentaBx´sta valinta: Sul ja mm² esim. 2A 2.5mm², millä halutLaskea maxPit.
      Sul := Sulake;  Mm2 := Amm;
   end;
begin//................................
   case Inx of              //Sul,Mm2
      0 :if Palsta=1  then Sij(16,2)        //<16A 2.5 mm²  Palsta ennen   "/"  => 16A 2,5mm² /
                      else Sij(10,1);       // 10A 1.5 mm²  Palsta jälkeen "/"  =>            / 10A 1,5mm²
      1 :if Palsta=1  then Sij(10,2)        //<10A 2.5 mm²
                      else Sij(10,1);       // 10A 1.5 mm²
      2 :if Palsta=1  then Sij( 6,2)        //< 6A 2.5 mm²
                      else Sij( 6,1);       //  6A 1.5 mm²
      3 :if Palsta=1  then Sij( 4,2)        //< 4A 2.5 mm²
                      else Sij( 4,1);       //  4A 1.5 mm²
      4 :if Palsta=1  then Sij( 2,2)        //< 2A 2.5 mm²
                      else Sij( 2,1);       //  2A 1.5 mm²
      5 :if Palsta=1  then Sij(16,4)        //<16A   4 mm²
                      else Sij(10,4);       // 10A   4 mm²
      6 :if Palsta=1  then Sij(16,6)        //<16A   6 mm²
                      else Sij(10,6);       // 10A   6 mm²
      7 :if Palsta=1  then Sij(16,10)       //<16A  10 mm²
                      else Sij(10,10);      // 10A  10 mm²
      8 :if Palsta=1  then Sij(16,16)       //<16A  16 mm²
                      else Sij(10,16); end; //  10  16 mm²
end;

//,Kutsu myös PaalVal.PAS´sista (=OK).  //,,Jos Older1101 ja AMCMK3½ 25 t. 35mm2 =>korjaustarve AMCMK3½o :ksi
function Is_AMCMK3_25t35_to_AMCMK3o (Filen :string)  :boolean;                               //11.0.1
      VAR Lst :TStringList;   i :integer;   sTYP,sMM2 :string;   Inif :TIniFile;      begin
   result := false;                                                   //  [Version]     <,,=ReadSections(Lst)
   if fFileExists(Filen)  then begin                           //< [edv_YLE]
      Lst := TStringList.Create;                                      //  [edv_Sorce1]
      Inif := TIniFile.Create (Filen);                                //  [edv_Edka1]
      Inif.ReadSections(Lst);                                         //  [edv_Edka2]
                                                                      //  [edv_NjL]
      for i := 0 to Lst.Count-1  do begin                             //  [edv_Edka3]
         sTYP := Inif.ReadString (Lst[i],'Tyyppi','');
         sMM2 := Inif.ReadString (Lst[i],'Amm2','');
         if (UpperCase (sTYP) = 'AMCMK3½')  and            //Condi.: (sMM2=2.5) or (sMM2=2,5) or (sMM2=3)
            ((sMM2='25') OR (sMM2='35'))  then begin
               result := true;   Break;  end;
      end;
      Inif.Free;
      Lst.free;
   end;
end;//Is_AMCMK3_25t35_to_AMCMK3o

function fEdvFileNimi :string;      VAR fn :string{141.1};   begin
   if {Trim(EdvFilen)<>''}FileOnEiEmpty(EdvFilen)//1414fu
      then fn := EdvFilen
      else Y_gLueTal_FileLista (11,1, LueTR,KysFA,fn);     //<Tähän alussa =ensiajossa tekee OLETUSNIMEN ############################## ??????
   Result := fn;
end;
                                                                         //+12.0.5m/6U: oMa => oMajr jne.
function fOlderVersioThan (oMajr,oMinr,oRels :integer) :boolean;    VAR EdvInif :TInifile;  fn :string;  iMajr,iMinr,iRels :integer;      begin
             //Kutsu esim:   if fOlderVersioThan (6,2,2)     Korvattu:  Older622 := fOlderVersioThan (6,2,2)    //Siirrtty jälempää tähän.
   fn := fEdvFileNimi;
      YFileen('¿ß¶OlderTstInif 0 ' +ExtractFilePath(Application.ExeName)); //1415f ß¶ =225 244
      YFileen('¿ß¶OlderTstInif 1 ' +fn); //1415f ß¶ =225 244
   EdvInif := TInifile.Create (fn);
      YFileen('¿ß¶OlderTstInif 6 ' +fn); //1415f ß¶ =225 244
   iMajr := EdvInif.ReadInteger (VersionSec,VersionMajorKey,  1000); //<,,1000=OletArvo jos error, jolloin
   iMinr := EdvInif.ReadInteger (VersionSec,VersionMinorKey,  1000); //   Result := FA, ja LUKUkohdassa
   iRels := EdvInif.ReadInteger (VersionSec,VersionReleaseKey,1000); //   LueTal :n palautettava FNC=TR,
   if  (iMajr< oMajr)  OR                                            //< 5.x.x  <  6.2.2  muuten virheen takia tehtävä jotain.
      ((iMajr<=oMajr) and (iMinr< oMinr))  OR                        //< 6.1.x  <  6.2.2
      ((iMajr<=oMajr) and (iMinr<=oMinr)   and (iRels< oRels))       //< 6.2.1  <  6.2.2
      then Result := true
      else Result := false;
   EdvInif.Free;
end;

function Older_12_0_6_OR_JkUpsPuuttuu :boolean;    VAR EdvInif :TInifile;  OldVer :boolean;  fn,ss :string;  begin
   fn := fEdvFileNimi;                             //<+120%m/6U:  Kutsut jälempää sekä PaaVal´sta. TUTKII, onko EdvFile´n Sorce1´ssä JkUps´ia.
   EdvInif := TInifile.Create (fn);
   OldVer := fOlderVersioThan(12,0,6);                       //<OK jos EiOO vanhempi versio.
   if (NOT OldVer)  then begin                               //<,Tutkitaan JkUps vain jos ed. ehto ei aseta FNC := FA.
      ss := EdvInif.ReadString({'edv_Sorce1}'edv_Edka1','JkUps','¤'); //<Ehkä selkeämpi testata johto-osalta.
      OldVer := ss='¤';  end;                                //<Jos palauttaa "¤", ei Key´tä tai oikeaa arvoa ole.
   if NOT OldVer  then begin                                 //,,+141.1,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      ss := EdvInif.ReadString('edv_Edka1','JkUps_Ik1v','¤');
    //ss := ss +EdvInif.ReadString('edv_Edka1','JkUps_Ik3v','¤'); //<Ei tarvita.
      ss := ss +EdvInif.ReadString('edv_Edka1','JkUps_Cos','¤');
      OldVer := Pos('¤',ss) =0; //<1414: Oli >0.             //<Jos palauttaa yhdenkin "¤", ei Key´tä tai oikeaa arvoa ole.
   end;
   result := OldVer;
   EdvInif.Free;
end;
//######################################################################################################################
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function LueTalEdvFile (LUE,KYSY :boolean;  inFilen :string) :boolean;
  VAR alus_EdvYLE  :EdvTiedotType;    alus_EdvSorce :EdvSorceType;   alus_EdvNjL :EdvNjLahtoType;
      alus_EdvEdka :EdvPalstaType;    edvX :EdvYHTtype;  u :integer{120.5i};  tapaus :string;
      fnc,edFnc,Older622,Older1101 :boolean;              //<<FNC tarkkaillaan KOKO AJAN, edFNC=Ed.alkion LUVUSTA.
         KoeFile :text;  fncS,se{120.5i},anFilen :string;  NytKoeTul :boolean;                 //'Older622 =Vanhempi kuin 6.2.2
       infoTyypKorj{11.0.1} :string;                                           //'Older1101=Vanhempi kuin 11.0.1

//+120.5n/6#############################################################################################################
                            //KÄYTY ÄPI 141.1, JOLLOIN MYÖS APUTULOSTUS FILEISIIN LISÄTTY.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                            //Järjestellään (JkUps siirretään vikaksi) ja talletus vanhan filen päälle.
                            //IDEA:  Luetaan koko INIFA LstF'hon, josta kopioidaan LstB´hen kukin Section -väli kerralla ArrU´n järjestyksessä.
                            //       LstB´stä etsitään JkUps -rivi, joka siirretään sectionin loppuun, näin mahd. muitakin Key -rivejä voidaan siirtää.
  //µ -kommenttimerkki kohdissa, missä poistettu DetEvFrm.aRich´iin kirjoitus ja korvattu fileenkirjoituksella +141.1 .
   procedure SortInif;      VAR i,j,k,o,ii,uy{,un} :integer;  fn,sfn,sfA, SA,SC,SX :string;
                               LstFx,LstFk{:+1414f},LstF,{LstU}LstSecU,{ArrU}LstSecA,LstCU,LstS,LstD :TStringList; //,,+120.5n/6
                               InifA :TIniFile;  boo :boolean;  JkUS: Array [1..3] of string;

      procedure ChgeExt (VAR fn :string;  ext :string);      VAR ss :string; //<FNC korvaa ChangeFileExt´n, mikä ei täällä näköjään worki.
         function fnc (fu,ext :string) :string;      VAR p :integer;      begin
            p := Pos('.',fu);
            if p=0
            then ss := fu         //<Jos eioo erotinta, EXT säilyy ennallaan.
            else begin
               Delete(fu,p,99);   //<Delataan EXT pisteineen ja tilalle uusi EXT.
               ss := fu +ext;            //          ,,,,,Oli aikaisemmin <1414.
            end;                         // InifA          =Luettu IniFile KOKONAISUUDESSAAN, LstF sis. saman LISTANA, ks. seur.
            result := ss;                // LstF           =Alkuperäisen InifA´n kopio LISTANA, SÄILYY KOSKEMATTOMANA.
         end;                            // InifB          =Lopullinen (järjestykseltään) korjattu IniFile.
      begin//ChgeFnExt...............    // LstSecA (=ArrU)=Halutut IniFileen sectionNimet (Otsikot). mikä =Uuden inif´n sectJärjestys. "[Version",
        {fnc('TämäKoe.txt','X12.tct');   // LstFx          =Sectionin loppuun lisättävät löydetyt Key-rivit (arvoineen).
         fnc('DämäCoe.txt','Z45.tXt');}  // LstSecU =LstU  =Apulista, josta uusi inif. SaveToFile
         ss := fnc(fn,ext);              // LstCU          =Uusi section -järjestys Inif´ssa.
         fn := ss;                       // LstS           =Sections -lista luettuna Inif´sta ja Lopullinen sortattu inifile      "Version".
      end;                               // LstD           =Lista jo löytyneistä Section -otsakenimistä ja MYÖS siirretyistä KEYriveistä, delausta varten.

      function ChgeExt_NextNroFN (fn,ext :string) :string;      VAR sa :string;  i,j,k :integer;      begin  //<Ext='' = EXTosa jää ennalleen. +141.1 .
         //ChgeExt(fn,'.tut');
         if ext<>''  then ChgeExt(fn,ext);
         j := 0;
         i := Pos('.',fn);                                           //, j=1 2 3 .. 9 10 11 .. 19 20 .. jotka delataan alta uuden Ints(j)´n tieltä.
         while (i>0) and fFileExists(fn)  do begin j := j+1;              //uy := 1 div 10;
            sa := '';                                                      //uy := 9 div 10;   //<' =0
            if j>0  then sa := Ints(j);                                    //uy := 10 div 10;  //<,,=1
            uy := (j-1) DIV 10;         //<UY =Delattavien numeroiden lkm. //uy := 11 div 10;
            i := Pos('.',fn);                                              //uy := 19 div 10;
            if j>1  then k := 1                                            //uy := 20 div 10;  //<2
                    else k := 0;                                     //if (fn[i-1]) + (fn[i]) + (fn[i+1]) <''  then;
            Delete(fn,(i-uy-k),uy+k);
            i := Pos('.',fn);                                        //<Helpoin etsiä "."n sij. ja siihen sij SA, koska dekadin kasvu haittaa "ymmärrystä".
            Insert(sa,fn,i);
            if fn <''  then ;
         end;
         result := fn;
      end;

    (*procedure wrinf(si :string;  Lst :TStringList);      VAR {fff :Text;  }fun,sa :string;  i{,n} :integer;      begin //+141.1:  Jokainen Lst omaan fileen.
         //wrinf('4 LstFx-Ini =PARSITTU LstF´stä/tiedostosta: "' +fn +'"', LstFx); LstFx := LstF, joka LstF.LoafFromFile(fn).

         i := Pos(' ',si);
         if (Lst<>nil) and (Lst.Count>0)  then begin
              sa := Copy(si,i,99);  sa := Trim(sa);  i := Pos(' ',sa);  // "1 LstS SECT.." => " LstS SECT.."
              sa := Copy(sa,1,i);   sa := Trim(sa);                     // "LstS "         => "LstS"
            fun := gAjoPath +'_FileEvSort ' +sa +'.TXT';       //<Tätä PRC´tä käytet. vain jotta näkee, mitä kunkin Lst´n on alunperin ajateltu sisältävän.
            fun := ChgeExt_NextNroFN (fun,'');                 //<Panee väliin järjNron josOnJoFileN.
                     {AssignFile(fff,fun);
                      if fFileExists(fun)
                        then Append(fff)
                        else Rewrite(fff);
                      writeln(fff,si +' \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\:');
                      if Trim(si[1])='1'
                         then writeln(fff,fn);
                      writeln(fff,'');        //<Tyhä rv väliin.
                      n := Lst.Count-1;
                      for i := 0 to n  do
                         writeln(fff,Lst[i]);
                      writeln(fff,'');        //<Tyhjä rv loppuun.
                      Flush(fff);
                      CloseFile(fff);}
            Lst.Insert(0,'');                 //<Tyhjä rv väliin. Tämä rv siirtyy [1]´ksi kun SI sijoitetaan [0]´ksi seur.
            Lst.Insert(0,si);
            Lst.SaveToFile(fun);
        end;
      end;//wrinf*)
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      procedure rvEdi(si :string);      begin end; (*VAR fft :Text;      begin
      {µ DetEvFrm.aRich.AddText(si +'<br>');
         DetEvFrm.Show;
         DetEvFrm.Update; µ}
         AssignFile(fft,sfA);   //<,,Siirrtty 141.1
         if fFileExists(sfA)
            then Append(fft)
            else Rewrite(fft);
         writeln(fft,si);
         Flush(fft);
         CloseFile(fft);
      end;//rvEdi*)

      //,,################################################### TÄMÄ vissiin nyt turha vaikka paremmat selitykset.##########################################
      procedure Kirjoita;    VAR m :integer;  X :TStringList;  sx :string;      begin//Kirjoita......................................
     {µ DetEvFrm.aRich.Lines.Clear;                                  // LstCU   = Lista kaikista Senctio´n -nimikkeistä LstSecA´n JÄRJESTYKSESSÄ.
        DetEvFrm.Width := 630;
        DetEvFrm.Left := Screen.Width -DetEvFrm.Width; µ}
      //SyottoAvFrm.Hide;
         rvEdi(DateTimeToStr(Now));
         rvEdi('');
         X := LstCU;  sx := 'LstCU';                                 //<,,Kaikkiin TStringList´eihin tänne tultaessa on suoritettu sijoitukset.
         rvEdi('Uusi Sections järjestys:');
         for m := 0 to X.Count-1  do
            rvEdi(sx +'[' +Ints(m) +']:  ' +X[m]);

         rvEdi('');
         X := LstSecU;  sx := 'LstSecU';
         rvEdi('Uusi inifLst:');
         for m := 0 to X.Count-1  do
            rvEdi(sx +'[' +Ints(m) +']:  ' +X[m]);

         rvEdi('');
         X := LstF;  sx := 'LstF';
         rvEdi('Alkuperäisestä inif´stä luetut:');
         rvEdi('Sections/AlpRaw: ' +sx);
         for m := 0 to X.Count-1  do
            rvEdi(sx +'[' +Ints(m) +']:  ' +X[m]);

         //LstS.SaveToFile(sfU);           //<Tämä korvaisi.., ks. rvFileen edellä.
      {µ DetEvFrm.aRich.PlainText := true;
         DetEvFrm.aRich.Lines.SaveToFile(sfU); µ}
      end;//Kirjoita
      //''################################################### TÄMÄ vissiin nyt turha.#####################################################################
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      function IsoCase(si :String) :String;   begin //+141.3 =16å4
         result := AnsiUpperCase(si);  end;

begin//SortInif,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
//########################################################################################################################################################
//Luodaan LISTAT<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//########################################################################################################################################################
{zzz := TStringList.Create;  //<,,TRY testausta.
zzz.Add('111');
try
if zzz[1]<>''
   then beep;
finally //except
beep;   //<Ohittuu aluksi ja menee SortIníf´n loppuun mutta palaa tähän.
end;}
      if Trim(EdvFilen)<>''
         then fn := EdvFilen
         else Y_gLueTal_FileLista (12,1, LUE,KYSY, fn);   //<LUE=TR. Tähän alussa =ensiajossa tekee OLETUSNIMEN ######################### ??????????????
  //µ AssignFile(ffn,fn);      //<rvEdi´ssä               //C:\Projektit XE2\NolaKehi\BIN\ApuInifSort.TXT
      InifA := TIniFile.Create(fn);             //<Luodaan inifile. Luetaan alempna KOKONAISUUDESSAAN listaan InifA, jota parsitaan rv kerrallaan.======
      LstF := TStringList.Create;                         //<,Tänne KOKO INIFILE LISTAAN, TÄMÄ SÄILYY koskemattomana.
      LstF.LoadFromFile(fn);
      LstFx := TStringList.Create;                        //<Tähän listaan koko inifile, TÄTÄ PARSITAAN ja DELATAAN.====================================
      LstFx.LoadFromFile(fn);                             //<'C:\Projektit XE2\NolaKehi\BIN\Data\Olet-Ev.NOE'); =Mahis.
      if LstFx.Count>0  then ;                            //<Tästä pääsee näkemään jos BreakPnt.

      LstS := TStringList.Create;                         //<Tänne inifilen KAIKKI Section -nimet (Pääotsikot (lohko-osoitteet)).
{LstS}InifA.ReadSections(LstS);                 //<Luetaan InifA´n Sections LstS´hen.=====================================================================
       if LstS.Count>0  then ;                            //< 6  Tästä pääsee näkemään BreakPnt´n aikana.
       if LstF.Count>0  then ;

      LstSecA :=  TStringList.Create;                        //<,LstSecA on korjattava uusi section -järjestys Inif´ssa.
      LstCU := TStringList.Create;
      LstSecA.Add('[Version');   LstSecA.Add('[edv_YLE');   LstSecA.Add('[edv_Sorce');   LstSecA.Add('[edv_Edka');   LstSecA.Add('[edv_NjL');
    //if (LstSecA[0])  +(LstSecA[1])  +(LstSecA[2])  +(LstSecA[3])  +(LstSecA[4])  <>''  then ;  //<'Näistä pääsee näkemään BreakPnt aikana.
      i := LstSecA.Count-1;  SA := '';
      for j := 0 to i  do SA := SA +'LstSecA[' +Ints(j) +']=' +LstSecA[j] +'  ';        //<141.3: <'a' => <>'a'.
      if SA<>''  then ;     WrSS(SA){1414};
      //'[Version   '[edv_YLE   '[edv_Sorce '[edv_Edka  '[edv_NjL
    //if OsStr(0,LstS) +(LstS[1]) +(LstS[2]){+(LstS[3])} +(LstS[3]) {+(LstS[5])}  +(LstS[4]) <>'a'  then ; //< Olet-Ev.NOE,  -141.3
      i := LstS.Count-1;  SA := '';
      for j := 0 to i  do SA := SA +'LstS[' +Ints(j) +']=' +LstS[j] +'  ';        //<+141.3
      if SA<>''  then ;     WrSS(SA){1414};
      //'Version    edv_YLE    edv_Sorce1{edv_Sorce2} edv_Edka1 {edv_Edka2 }   edv_NjL                //< Olet-Ev 2s2j.NOE, missä 2Src +2ej

         {WrSS('InifA:');
          for i := 1 to Length(InifA)  do WrSS(InifA[i]);}
          WrSS('LstS:');
          for i := 0 to LstS.Count-1  do WrSS(LstS[i]);
          WrSS('LstF:');
          for i := 0 to LstF.Count-1  do WrSS(LstF[i]);
          WrSS('LstSecU:');
          //for i := 0 to LstSecU.Count-1  do WrSS(LstSecU[i]);
          WrSS('LstSecA:');
          for i := 0 to LstSecA.Count-1  do WrSS(LstSecA[i]);

     {if IsDebuggerPresent  then begin
        wrinf('1 LstS-Sec SECTIONIT tiedostosta: "' +                     fn +'"', LstS); //<Jo kertaalleen filessä, kerran riittää OK.
         wrinf('2 LstSecA-Sec Etsittävät pääotsikot tiedostosta: "' +         fn +'"', LstSecA);
         wrinf('3 LstF-Ini =ALP Inifile KOKONAISUUDESSAAN tiedostosta: "' +fn +'"', LstF);//}
                                                                  //,,Näillä kopioidaan sfU filenimiTestausta (ChgeExt_NextNroFN) varten.
           {CopyFile(PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort.TXT'),PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort3.TXT'),false);
            CopyFile(PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort.TXT'),PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort4.TXT'),false);
            CopyFile(PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort.TXT'),PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort5.TXT'),false);
            CopyFile(PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort.TXT'),PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort6.TXT'),false);
            CopyFile(PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort.TXT'),PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort7.TXT'),false);
            CopyFile(PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort.TXT'),PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort8.TXT'),false);
            CopyFile(PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort.TXT'),PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort9.TXT'),false);
            CopyFile(PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort.TXT'),PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort10.TXT'),false);
            CopyFile(PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort.TXT'),PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort11.TXT'),false);
            CopyFile(PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort.TXT'),PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort12.TXT'),false);
            CopyFile(PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort.TXT'),PChar('C:\Projektit XE2\NolaKehi\BIN\FileEvSort13.TXT'),false);//
        //sfU := ChgeExt_NextNroFN(sfA,'');  //<'' =Ext -osa jää ennalleen.
      end;//if Deb..}
//########################################################################################################################################################
//Sijoitetaan SECTION -lohkonimet (sx) LstCU´hun.
//########################################################################################################################################################
//KESKEN KESKEN KEHI KEHI VÄLIAIKAINEN
            {if IsDebuggerPresent  then begin                   //,Jos nämä erilaisia, on OpenRegistry´ssä tapahtunut muutos, korjaa sinne, todettu 141.1,
                sfn := gAjoPath +'_UusiJkUps.NOE';              //<Tälllä \Bin -dirriin missä muutkin tarkkailufilet.
                if fn<>'C:\Projektit XE2\NolaKehi\BIN\Data\Olet-Ev 2s2j.NOE'  then // aiheuttaa jostain syystä myös Errorin siirtyessään tämnJälk AvuChkSft -tarkistukseen.
                   for i := 1 to 10  do WBeep([200,100, 0,10]);  end;}
      for i := 0 to LstSecA.Count-1  do begin             //,,Etsitään KAIKKI LstSecA´n (Sections) esiintymät (esim. edv_Edka1..edv_Edka3 yms.), sitä voidaan
         sa := LstSecA[i];   j := 0;   boo := true;       //  sitten käyttää oikean järjestyksen mukaiseen Sectionkohtien lukuun seur. "[" asti,!!!!!!!!!
         while boo  and (i<=LstSecA.Count-1)  {and        //<+141.3/16å4: +(i<=LstSecA.Count-1). 1414d:  Ehto: and (1<=..Count-1  TURHA, ks. for i :=...
         (LstCU.IndexOf(LstSecA[i]) <0) }do begin         //<IndexOf<0 =Ei vielä LstSecA´sa. LstCU =Tämä on korjattava uusi section -järjestys Inif´ssa.
            sc := LstFx[j];                               //<'BOO =Pitää Whilessa kunnes j=__LstC.Count-1, eli parsitaan AINA sinne asti.
            k := Pos(IsoCase(sa),IsoCase(sc));
            if k>0  then begin                            //<,,Kun Section -otsikkonimi on kohdalla "VersionMaj.." ei kelpaa.
               sx := LstFx[j];
               ii := LstCU.IndexOf(sx);
               if ii = -1  then                           //<Jos SX eioo (vielä) CU´ssa.
{LstCU.Add}       LstCU.Add(sx);                          //<LstCU[] := 'edv_Edka1' yms.  LstFx.Delete(j);  Nyt korvattu Indxof.. WHILE rivillä.

               if (j=LstFx.Count-1)                   //<Jos vika LstFx´sta jo tutkittu => Ulos !!!!! HUOM: [j]´hän delattiin edRvllä joten tässä Count=VIKA.
                  then boo := false                       //<Lähdetään etsimään UUTTA LstSecA[]´itemia vasta kun LstFx tutkittu ..
                  else j := j+1;                          //<+141.1
           end//if k>0                                    //,###########################################################################################
           else if (j=LstFx.Count-1)                      // ..LOPPUUN, esim. edv_Edka.. voi olla useita.###############################################
                then boo := false                         //'###########################################################################################
                else j := j+1;
         end;//while
         if (i > LstSecA.Count-1) or (j > LstFx.Count-1)
            then WBeep([50,100]);
      end;//for i
      if LstSecA.Count>=0  then ;  if LstF.Count>=0  then ;   if LstFx.Count>=0  then ;  if LstCu.Count>=0  then ;
      //if (LstCU[0]) +(LstCU[1]) +(LstCU[2]) {+(LstCU[3])} +(LstCU[3]) {+(LstCU[5])} +(LstCU[4])  <'a'  then ;  //< Olet-Ev.NOE, muuten Error.
      i := LstCU.Count-1;  SA := '';
      for j := 0 to i  do SA := SA +'LstCU[' +Ints(j) +']=' +LstCU[j] +'  '; //<141.3
      if SA<>''  then ;
      // '[Version]   [edv_YLE] [edv_Sorce1]{[edv_Sorce2]} [edv_Edka1]{[edv_Edka2]}  [edv_NjL]                 //< Olet-Ev 2s2j.NOE, missä 2Src +2ej
//########################################################################################################################################################
//Sijoitetaan KEY -rivit LstSecU´hun, deletoidaan LstF´stä.<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//########################################################################################################################################################
     {if IsDebuggerPresent  then                          //'[Versio] jääVex jos LstFx := LstF, todettu.
        wrinf('4 LstFx-Ini = LstF = "' +fn +'"', LstFx);  //<,,Näillä kopioidaan sfU filenimitutkintaa (ChgeExt_NextNroFN) varten.}
                                                          //'WRINF ei tarvita uusia joka testiajossa, yksi krt riittää, ks. ..LstFx-Ini.txt -file.
//PERIAATEMUUTOS:  Luetaan LstF (=alp.fileLista) siihen lisätään (Add) löydetyt etsityt (nyt JkUps..) ja kopioidaan seltä juuri ennen Section vaihtumista.
      sfA := gAjoPath +'_Ajotietoja.txt';                 //<rvEdi/fileenkirjoitusta varten.
      DeleteFile(sfA);                                    //<Delataan vanha alta vex.
//########################################################################################################################################################
//########################################################################################################################################################
//IDEA: Käydään LstF läpi JÄRJESTYKSESSÄ (kaikki), kun tullaan JkUps.. sis. rv, kerätään NÄMÄ RIVIT LstFx´ään ja rivi seur "^^^.." -rvllä PURETAAN
//      =KOPIOIDAAN ennen tuota jakoviivaa LstFx´stä LstSecU´hun +LstS´ään ja LstFx putsataan (Clear). Kun JkUps.. rv löytyy, sitä ei kopioida LstS´ään
//      kuten kaikki muut rvt ja "^^^.." rivin edelle samat rvt listään kuten LstSecU´hunkin.
//>>>>  Alunperin piti etsiä LstCU´n Sectionit ja etsiä niistä em. JkUps..-rvt. NYT mennäänkin järjet´ssä läpi ja JkUps.. herättää LstFx +LstS keräilyn.
//########################################################################################################################################################
//########################################################################################################################################################

      JkUS[1] := IsoCase('JkUps=');   JkUS[2] := IsoCase('JkUps_Ik1v=');   //JkUS[3] := IsoCase('JkUps_Ik3v='); //<Ei tarvita.
      LstSecU :=  TStringList.Create;                     //<Lopullinen (UUSI) inif.
                                     //................................................................#####............................................
      LstFk := TStringList.Create;   //<LÖYDETYT Key-rivit (arvoineen, "JkUps.."). 1414f: OLI LstFx => Lstfk ###########################################
                                     //................................................................#####............................................
      LstD :=  TStringList.Create;                        //<Lopuksi DELattavien (siirrettyjen) alpRivien riviOsoitteet.
      LstS.Clear;                                         //<Lopullinen sortattu inifile.
      o := -1;                                            //,,LstCU=uusi Sectionjärjestys. Eioo CaseSensitive. "[Version] [edv_YLE] .. jne.
      REPEAT o := o+1;          //<LstCU[i]: Käydään NOEtiedoston KAIKKI Section -otsikkonimet läpi.######################################################
            SA := IsoCase(LstF[o]);
         if (Pos(JkUS[1],SA) >0) or (Pos(JkUS[2],SA) >0) or (Pos(JkUS[3],SA) >0)  then //HUOM: Järjestys (JkUS[],SA)
            LstFk.Add(LstF[o]);

         ii := Pos('^^^',LstF[o] );                       //<Tämän Section -otsikkonimen vika rv.
                 //if ii=0  then ii := Pos('[',LstF[o] ); //<,,Tulisi konstikkaaksi: Pitäisi ehtoja laajentaa, nyt vain USKOTTAVA, että tuo rv AINA mukana.
         if ii>0 //<###############^^^^^^^^^^^^^^^^^^ tai "[" -rivi löytyy kohdalta [j], eli SECTION -osa vaihtuu, eli tämän ETEEN JkUps -lisät,#######
         then begin                               //o on siis Sectionin vika rv.#######################################################################
               if o<0  then ;
            for ii := 0 to LstFk.Count-1  do begin//<LstSecU[ii]´n loppuun lisätään kaikki JkUpsi´t, jotka sij´ttiin väliaikaisesti LstFk´een (JkS oli
{LstSecU.Add}  LstSecU.Add(LstFk[ii] );           // uusi, joka sijoittui ehkä villisti inifileen).
{LstS.Add}     LstS.Add(LstFk[ii] );  end;        //<Tännekin  samat JkUps..rivit.
            LstFk.Clear;
{LstSecU.Add}  LstSecU.Add(LstF[o] );             //<Jakoviiva vasta siirrettyjenJkUps´ien JÄLKEEN.
{LstS.Add}     LstS.Add(LstF[o] );                //<Jakoviiva vasta siirrettyjenJkUps´ien JÄLKEEN.
               //if IsDebuggerPresent  then LstS.SaveToFile(sfn);
         end//if ii>0
         else begin //<,,########################### Joku muu kuin ^^^^^^^^^-rivi =SECTION -osa on vielä sama.#########################################
{LstSecU.Add}  LstSecU.Add(LstF[o] );
{LstS.Add}  if Pos(IsoCase('JkU'), IsoCase(LstF[o])) =0
               then LstS.Add(LstF[o] );           //<Nämähän siirrettin jo "^^^.." -viivan eteen.
         end;
      UNTIL o>=LstF.Count-1;
      LstFk.Free; //<1414f. Koska LstFx muutin LstFk´ksi.

//KESKEN KESKEN KEHI KEHI VÄLIAIKAINEN
     {if IsDebuggerPresent  then begin
         LstS.SaveToFile(sfn);              //<Vain KEHIvaiheessa BIN-dirriin ja poikkeavalla tunnisteella .."D", ks. Sort.. pääPRCn alussa.
         SA := sfn;
         ChgeExt(SA,'D.txt');
         RenameFile(sfn,SA);
         LstD.SaveToFile(SA+'6');  end;}

     {if IsDebuggerPresent  then begin
        wrinf('5 LstCu-Sec =~LstS Sectionit :',LstCU);
         wrinf('6 LstSecU-Ini Lopullinen Inifile:' ,LstSecU);//
      end;//if Debugg..}

//VÄLIAIKAINEN
      if NOT IsDebuggerPresent  then        //<Normaaliajossa talletus vanhan päälle.
         sfn := fn;                         //<'Vain KEHIvaiheessa BIN-dirriin, ks. Sort.. pääPRCn alussa.
      if (sfn<>'') and fFileExists(sfn)     //<,Muuten tulee error, todettu 141.1 .
         then LstS.SaveToFile(sfn);         //<Talletetaan vanhan päälle lopullisessa versiossa.

      LstFx.Free;  LstF.Free;  LstSecU.Free;  LstSecA.Free;  LstCU.Free;  LstS.Free;  LstD.Free;
   //,,Kirjoitus vain kehitysvaiheessa. Kirjoittaa LstC´ää ja LstF ??ja LstB´tä tiedostoon jotta toiminta varmistuisi.,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
(* if{fRePunKehiAjo}IsDebuggerPresent  then begin                  //Kehit´ssä ota kommenttisulut (x vex, saat DetEvFrmn.aRich´iin kaikki Lst´n tiedot.
      Kirjoita;                          //<Siellä DetEvFrm.aRich´iin..'#################################################################################'

      //µDetEvFrm.Hide;                  //<..ja suljetaan koska seressa editoidaan Notepad´issa.
   end;*)
(*µ       ShellExecute({Handle}0,'open', 'c:\windows\notepad.exe', PChar(sfn),  nil, SW_SHOW); //=OK. SW_SHOW tai SW_SHOWNORMAL. Avataan myös Olet-Ev.NOE
          ShellExecute({Handle}0,'open', 'c:\windows\notepad.exe', PChar(sfU), nil, SW_SHOW); //=OK. SW_SHOW tai SW_SHOWNORMAL. µ*)

end;//SortInif
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  procedure alkuarvot;      var i :integer;      begin
                            //,,,,,,,,##############################################################
  with alus_EdvYLE  do begin//,,,,,,,,Asettaa KAIKKIIN kenttin 0-arvot:  0, FALSE ja '' =kentän muk.

    with SorceCount do begin tyhArvo (SorceCount,'SorceCount');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 1;
                         onAlar := true;  alarInt := 0;     onYlar :=  false;                     end;
    with JohtoOsia  do begin tyhArvo (JohtoOsia,'JohtoOsia');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 1;{1415f oli 0}            end;
    with Kuvaus     do begin tyhArvo (Kuvaus,'Kuvaus');
                         onArvo := true;  arvoTyp := Strg;  arvoStr := '';                        end;
    with Un         do begin tyhArvo (Un,'Un');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 400;
                         onAlar := true;  alarInt := 100;   onYlar :=  true;   ylarInt :=  1000;  end;
    with VaiheLkm   do begin tyhArvo (VaiheLkm,'VaiheLkm');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 3;
                         onAlar := true;  alarInt := 1;     onYlar :=  true;   ylarInt :=  3;     end;
  //fSiTdsm (Raj,MaxDes):  Raj=MaxArvo, JOTA PIENEMMILLÄ MaxDes, isommilla arvoilla DES pienenee ,,,,, per dekadi.
                                              // esim.  d := fSiTdsm (100,3), fRmrkt0 (2000.3456,1,1) => 2000.3
                                              //                              fRmrkt0 ( 200.3456,1,2) =>  200.34
                                              //                              fRmrkt0 ( 100.3456,1,3) =>  200.345
                                              //                              fRmrkt0 (  20.3456,1,3) =>   20.345
                                              //                              fRmrkt0 (   2.3456,1,3) =>    2.345
                                              //        d := fSiTdsm (1,3),   fRmrkt0 (0.99999 ,1,3) => 0.999
    with cU         do begin tyhArvo (cU,'cU');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.95;   Rdsm := fSiTdsm (1,3);
                         onAlar := true;  alarRea := 0.85;  onYlar :=  true;   ylarRea :=  1.15;  end;
    with LaakPmu    do begin tyhArvo (LaakPmu,'LaakPmu');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 3.5;    Rdsm := fSiTdsm (1,1); //<,+130.2e
                         onAlar := true;  alarRea := 2.0;   onYlar :=  true;   ylarRea :=  11.5;  end;
    PrRjIndx := 0; //<+130.0 ,,-130.0
   {with PrRjMm2    do begin tyhArvo (PrRjMm2,'PrRjMm2');                                          //<+120.5:  1=16A2.5/10A1.5  2=10A2.5/10A1.5 tai 4..6mm²
                         onArvo := true;  arvoTyp := Intg;  arvoInt := -1;     //< -1 tulkit. indx=0            '16/10A
                         onAlar := true;  alarRea := 1;     onYlar := true;    ylarInt :=  70;    end; //<PudValikossa vain 4.. ve, ei vapaasti syötettävä.}
    with IecOfa     do begin tyhArvo (IecOfa,'IecOfa');                                 //'70 teoreettinen, pud.valikossa max 6mm².
                         onArvo := true;  arvoTyp := Bool;  arvoBoo := true;                      end;
    with PoisAika   do begin tyhArvo (PoisAika,'PoisAika');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 5;      Rdsm := fSiTdsm (1,1);
                         onAlar := true;  alarRea := 0.1;   onYlar := true;    ylarRea :=  5;     end;
    with PRaika     do begin tyhArvo (PRaika,'PRaika');                                             //<,+8.0.0
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.4;    Rdsm := fSiTdsm (1,1);
                         onAlar := true;  alarRea := 0.1;   onYlar := true;    ylarRea :=  5;     end; //<Yr/Ar eiväliä =Buttoneilla
    with PEN_PE     do begin tyhArvo (PEN_PE,'PEN_PE');                                             //<+6.0.3
                         onArvo := true;  arvoTyp := Strg;  arvoStr := '';                        end;
    with AsTapa     do begin tyhArvo (AsTapa,'AsTapa');
                         onArvo := true;  arvoTyp := Strg;  arvoStr := 'A';                       end; //<'+8.0.11
    with ZpeBx      do begin tyhArvo (ZpeBx,'ZpeBx');
                         onArvo := true;  arvoTyp := Bool;  arvoBoo := false;                     end;  //<+9.0.1
  end;//with alus_EdvYLE
  //.....................................................
  with alus_EdvSorce  do begin
    onarvot := true;   //<############################ H U O M A A ################################# +8.0.0
    with SorceKind  do begin tyhArvo (SorceKind,'SorceKind');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 1;//1=Sj.
                         onAlar := true;  alarInt := 1;     onYlar :=  true;  ylarInt := 4;       end;
    with Smn        do begin tyhArvo (Smn,'Smn');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 800;
                         onAlar := true;  alarInt := 10;    onYlar :=  true;   ylarInt :=  3150;  end;
    with TrfTyp     do begin tyhArvo (TrfTyp,'TrfTyp');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 2;
                         onAlar := true;  alarInt := 1;     onYlar :=  true;   ylarInt :=  18;    end;
    with yvRs       do begin tyhArvo (yvRs,'yvRs');  //Sijoitus vasta arvoTyp sij.,,,,,,,,,,,,,,,,,,,,,, jälkeen
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.000098;  Rdsm := fSiTdsm (1,8); //Oli:  0.000098;
                         onAlar := true;  alarRea := 0;{0.00000001;}                              end;
//if alus_EdvSorce.yvRs.arvoRea<0  then beep; //KESKEN KESKEN 9.8E-5000 err selvittelyyn.
    with yvXs       do begin tyhArvo (yvXs,'yvXs');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.001597;  Rdsm := fSiTdsm (1,8);
                         onAlar := true;  alarRea := 0;{0.00000001;}                              end;
    with Iks1v      do begin tyhArvo (Iks1v,'Iks1v');                  //,800 kVA:n navoissa
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 18.1101;   Rdsm := fSiTdsm (10,3);//100,1, 10,2, 0,3, 0,0);
                         onAlar := true;  alarRea := 0.01;  onYlar := true;    ylarRea :=  300;   end;
    with Iks3v      do begin tyhArvo (Iks3v,'Iks3v');                  //,800 kVA:n navoissa
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 21.4329;   Rdsm := fSiTdsm (10,3);//100,1, 10,2, 0,3, 0,0);
                         onAlar := true;  alarRea := 0.01;  onYlar := true;    ylarRea :=  400;   end;   //'2->3 6.2.17
    with Iks1vCos   do begin tyhArvo (Iks1vCos,'Iks1vCos'); //<On käytössä, sij. 26.INC :ssä <<<<<<<
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.999;     Rdsm := fSiTdsm (1,3);//100,1, 10,2, 0,3, 0,0);
                         onAlar := true;  alarRea := 0.1;   onYlar := true;    ylarRea :=  1;     end;
    with pjLiitRs   do begin tyhArvo (pjLiitRs,'pjLiitRs');            //,800 kVA:n navoissa
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.0120;    Rdsm := fSiTdsm (1,8); //<1415f: 0.359 => 0.0120 Korj f2:  Oli:0.00189867;
                         onAlar := true;  alarRea :={0.0000000001} 0;   {,800 kVA:n navoissa}     end;   //< 6.0.2 =>0
    with pjLiitXs   do begin tyhArvo (pjLiitXs,'pjLiitXs'); //<ARVOA ei tarvittaisi: Lasket. jäljempnä.
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.0065;   Rdsm := fSiTdsm (1,8);  //<1415f: 0.0065 Korj f2:  Oli:0.01196467;
                         onAlar := true;  alarRea := 0;     {<'Alar + Ylar TARVITAAN #######}     end;
//case row of  //Sn   Xd   X'd  X"d   Rs          Xq   X"q   XL   X2    Xo       T'd   T"d     Tdo     tIkMin tIkSust IkSust K1vSust =GenerParam-Nola.txt´stä
//               1000 2.73 0.22 0.15  0.002   '  {1.61 0.19  0.08 0.19  0.02} +' 0.185 0.025'{ 3.03 } +' 0.23  0.55  3500  2.5';
    with gSn        do begin tyhArvo (gSn,'gSn');           //<,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,+6.2.2
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 1000;
                         onAlar := true;  alarInt := 1;     onYlar :=  true;   ylarInt :=  3150;  end;
    with gXd        do begin tyhArvo (gXd,'gXd');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 2.73;      Rdsm := fSiTdsm (1,4);
                         onAlar := true;  alarRea := 0.001;                                       end;
    with gXd1       do begin tyhArvo (gXd1,'gXd''');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.22;      Rdsm := fSiTdsm (1,4);
                         onAlar := true;  alarRea := 0.001;                                       end;
    with gXd2       do begin tyhArvo (gXd2,'gXd"');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.15;      Rdsm := fSiTdsm (1,4);
                         onAlar := true;  alarRea := 0.001;                                       end;
   {with gX2        do begin tyhArvo (gX2,'gX2');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.19;      Rdsm := fSiTdsm (1,4);
                         onAlar := true;  alarRea := 0;                                           end;
    with gX0        do begin tyhArvo (gX0,'gX0');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.023;     Rdsm := fSiTdsm (1,5);
                         onAlar := true;  alarRea := 0;                                           end; //<'-8.0.8}
    with gRs        do begin tyhArvo (gRs,'gRs');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.0024;    Rdsm := fSiTdsm (1,5);
                         onAlar := true;  alarRea := 0.00001;                                     end;
    with gTd1       do begin tyhArvo (gTd1,'Tau''');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.185;     Rdsm := fSiTdsm (1,5);
                         onAlar := true;  alarRea := 0.001;                                       end;
    with gTd2       do begin tyhArvo (gTd2,'Tau"');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.025;     Rdsm := fSiTdsm (1,5);
                         onAlar := true;  alarRea := 0.001;                                       end;
    with gtIkMin    do begin tyhArvo (gtIkMin,'gtIkMin'); //<,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,+8.0.8
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.25;      Rdsm := fSiTdsm (1,5);
                         onAlar := true;  alarRea := 0.001;                                       end;
    with gtIkSust   do begin tyhArvo (gtIkSust,'gtIkSust');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.55;      Rdsm := fSiTdsm (1,5);
                         onAlar := true;  alarRea := 0.001;                                       end;
    with gIkSust    do begin tyhArvo (gIkSust,'gIkSust');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 3600;
                         onAlar := true;  alarInt := 10;    onYlar :=  true;  ylarInt := 40000;   end;
    with gK1vSust   do begin tyhArvo (gK1vSust,'gK1vSust');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 2.50;      Rdsm := fSiTdsm (1,4);
                         onAlar := true;  alarRea := 0.1;                                         end;
//,,+141.1--------------------------------------------------------------------------------------------''=Yhdenmuk. version 1299 kanssa (chkd 2.11.2017)
    with Ups_Ik1v   do begin tyhArvo (Ups_Ik1v,'Ups_Ik1v');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 18.11;    Rdsm := fSiTdsm (10,3);
                         onAlar := true;  alarRea := 0;                                           end;
    with Ups_Ik3v   do begin tyhArvo (Ups_Ik3v,'Ups_Ik3v');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 21.43;    Rdsm := fSiTdsm (10,2);
                         onAlar := true;  alarRea := 0;                                           end;
    with Ups_Cos    do begin tyhArvo (Ups_Cos,'Ups_Cos');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.9;    Rdsm := fSiTdsm (1,3);
                         onAlar := true;  alarRea := 0.01;  onYlar :=  true;   ylarRea :=  1;   end;
//''+141.1
  end;//with alus_EdvSorce
  //.....................................................
  with alus_EdvNjL  do begin
    with yhtZs      do begin tyhArvo (yhtZs,'yhtZs');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.67245;   Rdsm := fSiTdsm (1,8);
                         onAlar := true;  alarRea := 0.0000000001;                                end;
    with yhtRs      do begin tyhArvo (yhtRs,'yhtRs');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.66888;   Rdsm := fSiTdsm (1,8);
                         onAlar := true;  alarRea := 0.0000000001;                                end;
    with yhtXs      do begin tyhArvo (yhtXs,'yhtXs');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.06919;   Rdsm := fSiTdsm (1,8);
                         onAlar := true;  alarRea := 0.0000000001;                                end;
    with yhtCosZs   do begin tyhArvo (yhtCosZs,'yhtCosZs');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.9947;    Rdsm := fSiTdsm (1,3);
                         onAlar := true;  alarRea := 0.01;                                        end;
    with yhtR1      do begin tyhArvo (yhtR1,'yhtR1');  arvoTyp := Reaa;  Rdsm := fSiTdsm (1,8);  {VainLasket.}end;//<+6.0.0a
    with yhtX1      do begin tyhArvo (yhtX1,'yhtX1');  arvoTyp := Reaa;  Rdsm := fSiTdsm (1,8);  {VainLasket.}end;//<+6.0.0a
    with Ik1v       do begin tyhArvo (Ik1v,'Ik1v');  arvoTyp := Reaa;   Rdsm := fSiTdsm (100,1); {VainLasket.}end;
    with Ik3v       do begin tyhArvo (Ik3v,'Ik3v');  arvoTyp := Reaa;   Rdsm := fSiTdsm (100,1); {VainLasket.}end;
    with Ik3t       do begin tyhArvo (Ik3t,'Ik3t');  arvoTyp := Reaa;   Rdsm := fSiTdsm (100,1); {VainLasket.}end;
    with Ik3d       do begin tyhArvo (Ik3d,'Ik3d');  arvoTyp := Reaa;   Rdsm := fSiTdsm (100,1); {VainLasket.}end;
  end;//with alus_EdvNjL
  //.....................................................
  with alus_EdvEdka do begin
    onarvot := true;   //<############################ H U O M A A ####################################
    with Nimi       do begin tyhArvo (nimi,'Nimi');
                         onArvo := true;  arvoTyp := Strg;  arvoStr := '';                        end;
    with Kuluttaja  do begin tyhArvo (kuluttaja, 'Kuluttaja' );
                         onArvo := true;  arvoTyp := Bool;  arvoBoo := false;  {=SÄL}             end;
    with PTlopussa  do begin tyhArvo (PTlopussa,'PTlopussa');
                         onArvo := true;  arvoTyp := Bool;  arvoBoo := true;                      end;
    with Tyyppi     do begin tyhArvo (tyyppi,'tyyppi');
                         onArvo := true;  arvoTyp := Strg;  arvoStr := 'AXCMK';                   end;
    with Amm2       do begin tyhArvo (Amm2,'Amm2');         // (3)Des=MaxDes  (0)Raj=MaxArvo, JOTA PIENEMMILLÄ MaxDes, isommilla DES pienenee (-1) per dekadi.
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 300;    Rdsm := fSiTdsm (2.5,1); //<130.2e:  3,1=>3,0 => 2.5,1
                         onAlar := true;  alarRea := 1.5;   {yr valvotaan}                        end;
    with PEker      do begin tyhArvo (PEker,'PEker');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 1.0;    Rdsm := fSiTdsm (1,2);
                         onAlar := true;  alarRea := 0;     onYlar :=  true;   ylarRea := 1;     end;
    with Lukumaara  do begin tyhArvo (lukumaara,'lukumaara');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 1;
                         onAlar := true;  alarInt := 1;     onYlar :=  true;   ylarInt :=  20;    end;
    with Pituus     do begin tyhArvo (pituus,'pituus');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 350;    Rdsm := fSiTdsm (100,1);
                         onAlar := true;  alarRea := 0;                                           end;
    with Korjaus    do begin tyhArvo (korjaus,'korjaus');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 1.0;    Rdsm := fSiTdsm (1,3);
                         onAlar := true;  alarRea := 0.01;  onYlar :=  true;   ylarRea := 10;     end;
    with Lampotila  do begin tyhArvo (lampotila,'lampotila');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 40;
                         onAlar := true;  alarInt := 0;     onYlar :=  true;   ylarInt :=  300;   end;
    with OfaVal     do begin tyhArvo (OfaVal,'OfaVal');                                               //<+6.0.2
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 0;
                         onAlar := true;  alarInt := 0;     onYlar :=  true;   ylarInt :=  630;   end;
    with Ph         do begin tyhArvo (Ph,'Ph');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0;      Rdsm := fSiTdsm (1,4);
                         onAlar := true;  alarRea := 0;     onYlar :=  true;   ylarRea :=  100000;   end;
    with Cosp       do begin tyhArvo (Cosp,'CosPh');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 1;      Rdsm := fSiTdsm (1,3);
                         onAlar := true;  alarRea := 0.05;  onYlar :=  true;   ylarRea :=  1;   end;
  //,,,Vaikka vain lasketaan, tarvitaan AINAKIN:  onArvo (ellei virhetarkistuksessa), Rdsm  TODETTU.!!!!!!!,,,,,,,
  //,,,Ilman näitä tulee ARVOTYYPIN mukainen herja.,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    with Uho        do begin tyhArvo (Uho,'Uho');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0;      Rdsm := fSiTdsm (1,2);
                         onAlar := true;  alarRea := 0;     onYlar :=  false;  ylarRea :=  0;   end;
    with Uhp        do begin tyhArvo (Uhp,'Uhp');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0;      Rdsm := fSiTdsm (1,2);
                         onAlar := true;  alarRea := 0;     onYlar :=  false;  ylarRea :=  0;   end;
    with Uhv        do begin tyhArvo (Uhv,'Uhv');                                                     //<+6.2.15
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0;      Rdsm := fSiTdsm (1,2);
                         onAlar := true;  alarRea := 0;     onYlar :=  false;  ylarRea :=  0;   end;
    with Uhvo       do begin tyhArvo (Uhvo,'Uhvo');                                                   //<+130.0
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0;      Rdsm := fSiTdsm (1,2);
                         onAlar := true;  alarRea := 0;     onYlar :=  false;  ylarRea :=  0;   end;
    with Tuh        do begin tyhArvo (Tuh,'Tuh');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 70;
                         onAlar := true;  alarInt := 10;    onYlar :=  true;   ylarInt :=  300;   end;
//,,+130.2
    with JkUps  do begin tyhArvo (JkUps,'JkUps');                                                       //<,,+120.6:  0=eiUPSia  1=OnUPSi.
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 0;
                         onAlar := true;  alarInt := 0;     onYlar :=  true;   ylarInt :=  1;     end;
    with JkUps_Ik1v   do begin tyhArvo (JkUps_Ik1v,'JkUps_Ik1v');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 4.0;    Rdsm := fSiTdsm (100,1); //< 1=MaxDes  100=MaxArvo, JOTA PIENEMMILLÄ Des=MaxDes
                         onAlar := true;  alarRea := 0;                                           end;
   {with JkUps_Ik3v   do begin tyhArvo (JkUps_Ik3v,'JkUps_Ik3v');                                       //<,Ei tarvita.
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 6.0;    Rdsm := fSiTdsm (100,1); //< 1=MaxDes  100=MaxArvo, JOTA PIENEMMILLÄ Des=MaxDes
                         onAlar := true;  alarRea := 0;                                           end;}
    with JkUps_Cos    do begin tyhArvo (JkUps_Cos,'JkUps_Cos');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.9;    Rdsm := fSiTdsm (1,3); //<,+141.1
                         onAlar := true;  alarRea := 0.05;  onYlar :=  true;   ylarRea :=  1;   end;
//''+130.2
  end;//with alus_EdvEdka
  //.....................................................Nämä sijoitukset jättää muut ennalleen, kun
  with tyh_EdvEdka do begin                            //ekax sijoitettu alus_EdvEdka alle #########
    tyh_EdvEdka :=  alus_EdvEdka;                      //<Pakko, muuten muut kentät jää EPÄMÄÄRÄIS.
  //tyhA_EdvEdka := alus_EdvEdka;                      //<+-8.0.1  Tämä voidaan sijoitta, jos muut delattu.
    kuluttaja .onArvo := false;  //<,,Tarve???         //''''''''''''''''TODETTU''''''''''''''''''''
    tyyppi    .onArvo := false;
    Amm2      .onArvo := false;
    pituus    .onArvo := false;
    lukumaara .onArvo := false;
    OfaVal    .onArvo := false;
    lampotila .onArvo := false;
    korjaus   .onArvo := false;
    PTlopussa .onArvo := false;
    JkUps     .onArvo := false;  //<+120.6
  //PrRjMm2   .onArvo := false;  //<+120.5  Kuuluu tyh_YLE -osaan, jota eioo.
    PEker     .onArvo := false;
    Ph        .onArvo := false;
    Cosp      .onArvo := false;
    Uho       .onArvo := false;
    Uhp       .onArvo := false;
    Uhv       .onArvo := false;  //<+6.2.15
    Tuh       .onArvo := false;
    JkUps_Ik1v.onArvo := false;  //<+130.2
  //JkUps_Ik3v.onArvo := false;  //<+130.2 Ei tarvita.
    onarvot := false;  //<##########################################################################
    //'Näistä puuttuu vielä muuttujien: ARVO [1..],RYHMAJOHTO [1..], ja NOUSUJOHTO [1..] alust.+tyhj.
  end;//with tyh_EdvEdka
  //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  edvX.YLE :=          alus_EdvYLE;    //<Sisälsi oletusasetukset yleiselle osalle
  edvX.Sorc[1].Src :=  alus_EdvSorce;  //<Sisälsi oletusasetukset liittymille
  edvX.Sorc[1].Josa := alus_EdvEdka;
  with edvX  do
    for i := 2 to edLmaxKpl  do begin
       Sorc[i].Josa := tyh_EdvEdka;    //<Muuttaa vain ONARVO := FALSE; ja jättää muut kentät[1]:n mukaisiksi
       Sorc[i].Src :=  alus_EdvSorce;  end;
  edvX.NjL :=          alus_EdvNjL;    //<Sisälsi oletusasetukset yhdelle johto-osalle
  edvX.edka[1] :=      alus_EdvEdka;   //<Sisälsi oletusasetukset = yksi johto-osa LIITTYMÄN j-osan lisäksi+6.2.2
  with edvX  do                        //,Muuttaa vain ONARVO := FALSE; ja jättää muut kentät[1]:n mukaisiksi
    for i := 2 to edMaxKpl  do edka[i] := tyh_EdvEdka; //'  edvX.YLE.JohtoOsia := 0 alus_EdvYLE :ssä.
  if edMaxKpl>0  then ;
  end;//alkuarvot'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

{procedure alustaEdv;      VAR i,alkaen :integer;      begin//Käyttöön 120.5, edvX tässä korvattu EDV´llä.
   edv.YLE := alus_EdvYLE;                                  //Nyt vasta eka kutsu/käyttötarve, ks. EEdvNew.PAS/LueBtnClick.
   edv.NjL := alus_EdvNjL;                                  //'Ei pääsekään käyttämään ulkopuolelta (EdvNew.PAS´sista).
   edv.edka[1] := alus_EdvEdka;
   with edv  do           //<,,Muuttaa vain ONARVO := FALSE; ja jättää muut kentät[1]:n mukaisiksi
   for i := 1 to edmaxkpl  do begin
       edka[i] := alus_EdvEdka;  edka[i] := tyh_EdvEdka;  end;
end;//alustaEdv}
                                                                                              //,,,+6.2.2,,,,,,,,
  procedure KoeWn (s :string);      begin if NytKoeTul  then writeln (KoeFile, s);  Flush (KoeFile);  end;
                                                        //Vaatii, jos avattu Append´''''''''illa, Rewrite´lla OK.
  procedure KoeVali___ (loc :integer);      begin
     if NytKoeTul  then
        KoeWn ('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^FNC=' +fBmrkt0 (fnc,2) +'^^^^^^^^^^^^^^^^^(' +
               IntToStr (loc) +')');  end;

  procedure TulRecorditKoe;      VAR i,osa :integer;  c,sa :string;  rec :EdvPalstaType;      begin
  if NytKoeTul  then begin
     KoeWn ('');
     KoeWn ('   ' +DateTimeToStr (Now)); //< Tai:  sd := TimeToStr(Time);
     KoeWn ('PRC: TulRecorditKoe:,,,,,,,,,,,,,,,,,,MUOKATUT,,,,,,,,,,,,,,,,,,,,,,');
   //KoeWn ('edv.YLE.Kuvaus     = ' +fSmrkt0 (a_getStrg (10, edv.YLE.Kuvaus   )     ));
     KoeWn ('edv.YLE.Kuvaus     = ' +                        edv.YLE.Kuvaus.arvoStr  );
     KoeWn ('edv.YLE.JohtoOsia  = ' +fImrkt0 (a_getIntg (11, edv.YLE.JohtoOsia), 1  ));
     KoeWn ('edv.YLE.SorceCount = ' +fImrkt0 (a_getIntg (12, edv.YLE.SorceCount),1  ));
     KoeWn ('edv.YLE.VaiheLkm   = ' +fImrkt0 (a_getIntg (13, edv.YLE.VaiheLkm ), 1  ));
     KoeWn ('edv.YLE.Un         = ' +fImrkt0 (a_getIntg (14, edv.YLE.Un       ), 1  ));
     KoeWn ('edv.YLE.cU         = ' +fRmrkt0 (a_getReaa (15, edv.YLE.cU       ), 1,3));
     KoeWn ('edv.YLE.LaakPmu    = ' +fRmrkt0 (a_getReaa (15, edv.YLE.LaakPmu  ), 1,1));
   //KoeWn ('edv.YLE.PrRjMm2    = ' +fImrkt0 (a_getIntg (16, edv.YLE.PrRjMm2  ), 1  )); //<+120.5: Pr&Rj reserviMm² -laskenta. -130.0
     KoeWn ('edv.YLE.IecOfa     = ' +fBmrkt0 (a_getBool (17, edv.YLE.IecOfa   ), 5  ));
     KoeWn ('edv.YLE.PEN_PE     = ' +                        edv.YLE.PEN_PE.arvoStr  );
     KoeWn ('edv.YLE.PoisAika   = ' +fRmrkt0 (a_getReaa (18, edv.YLE.PoisAika ), 1,1));
     KoeWn ('edv.YLE.PRaika     = ' +fRmrkt0 (a_getReaa (19, edv.YLE.PRaika ),   1,1));
     KoeWn ('edv.YLE.AsTapa     = ' +                        edv.YLE.AsTapa.arvoStr  );
     KoeWn ('edv.YLE.ZpeBx      = ' +fBmrkt0 (               edv.YLE.ZpeBx.arvoBoo,2));
     KoeWn ('');

     i := a_getIntg (18, edv.YLE.SorceCount);
    for i := 1 to i  do begin
     c := IntToStr (i);
     KoeWn ('edv.Sorc[' +c +'].src.SorceKind = ' +fImrkt0 (a_getIntg (21, edv.Sorc[i].src.SorceKind), 1  ));
     KoeWn ('edv.Sorc[' +c +'].src.Smn       = ' +fImrkt0 (a_getIntg (22, edv.Sorc[i].src.Smn      ), 1  ));
     KoeWn ('edv.Sorc[' +c +'].src.TrfTyp    = ' +fImrkt0 (a_getIntg (23, edv.Sorc[i].src.TrfTyp   ), 1  ));
     KoeWn ('edv.Sorc[' +c +'].src.yvRs      = ' +fRmrkt0 (a_getReaa (24, edv.Sorc[i].src.yvRs     ), 1,8));
     KoeWn ('edv.Sorc[' +c +'].src.yvXs      = ' +fRmrkt0 (a_getReaa (25, edv.Sorc[i].src.yvXs     ), 1,8));
     KoeWn ('edv.Sorc[' +c +'].src.Iks1v     = ' +fRmrkt0 (a_getReaa (26, edv.Sorc[i].src.Iks1v    ), 1,2));
     KoeWn ('edv.Sorc[' +c +'].src.Iks3v     = ' +fRmrkt0 (a_getReaa (27, edv.Sorc[i].src.Iks3v    ), 1,2));
     KoeWn ('edv.Sorc[' +c +'].src.Iks1vCos  = ' +fRmrkt0 (a_getReaa (28, edv.Sorc[i].src.Iks1vCos ), 1,4));
     KoeWn ('edv.Sorc[' +c +'].src.pjLiitRs  = ' +fRmrkt0 (a_getReaa (29, edv.Sorc[i].src.pjLiitRs ), 1,8));
     KoeWn ('edv.Sorc[' +c +'].src.pjLiitXs  = ' +fRmrkt0 (a_getReaa (30, edv.Sorc[i].src.pjLiitXs ), 1,8));
     KoeWn ('edv.Sorc[' +c +'].src.gSn       = ' +fImrkt0 (a_getIntg (31, edv.Sorc[i].src.gSn      ), 1  ));
     KoeWn ('edv.Sorc[' +c +'].src.gXd       = ' +fRmrkt0 (a_getReaa (32, edv.Sorc[i].src.gXd      ), 1,4));
     KoeWn ('edv.Sorc[' +c +'].src.gXd1      = ' +fRmrkt0 (a_getReaa (33, edv.Sorc[i].src.gXd1     ), 1,4));
     KoeWn ('edv.Sorc[' +c +'].src.gXd2      = ' +fRmrkt0 (a_getReaa (34, edv.Sorc[i].src.gXd2     ), 1,4));
    {KoeWn ('edv.Sorc[' +c +'].src.gX2       = ' +fRmrkt0 (a_getReaa (34, edv.Sorc[i].src.gX2      ), 1,4));
     KoeWn ('edv.Sorc[' +c +'].src.gX0       = ' +fRmrkt0 (a_getReaa (35, edv.Sorc[i].src.gX0      ), 1,5));}
     KoeWn ('edv.Sorc[' +c +'].src.gRs       = ' +fRmrkt0 (a_getReaa (35, edv.Sorc[i].src.gRs      ), 1,5));
     KoeWn ('edv.Sorc[' +c +'].src.gTd1      = ' +fRmrkt0 (a_getReaa (36, edv.Sorc[i].src.gTd1     ), 1,4));
     KoeWn ('edv.Sorc[' +c +'].src.gTd2      = ' +fRmrkt0 (a_getReaa (37, edv.Sorc[i].src.gTd2     ), 1,4));
     KoeWn ('edv.Sorc[' +c +'].src.gtIkMin   = ' +fRmrkt0 (a_getReaa (37, edv.Sorc[i].src.gtIkMin  ), 1,4));//<,+8.0.8
     KoeWn ('edv.Sorc[' +c +'].src.gtIkSust  = ' +fRmrkt0 (a_getReaa (38, edv.Sorc[i].src.gtIkSust ), 1,4));
     KoeWn ('edv.Sorc[' +c +'].src.gIkSust   = ' +fImrkt0 (a_getIntg (39, edv.Sorc[i].src.gIkSust  ), 1  ));
     KoeWn ('edv.Sorc[' +c +'].src.gK1vSust  = ' +fRmrkt0 (a_getReaa (40, edv.Sorc[i].src.gK1vSust ), 1,4));
     KoeWn ('');
    end;   //,,+141.1
           KoeWn ('edv.Sorc[1].src.Ups_Ik1v  = ' +fRmrkt0 (a_getReaa (41, edv.Sorc[1].src.Ups_Ik1v   ), 1,3));
           KoeWn ('edv.Sorc[1].src.Ups_Ik3v  = ' +fRmrkt0 (a_getReaa (42, edv.Sorc[1].src.Ups_Ik3v   ), 1,3));
           KoeWn ('edv.Sorc[1].src.Ups_Cos   = ' +fRmrkt0 (a_getReaa (43, edv.Sorc[1].src.Ups_Cos    ), 1,3));
           //''+141.1
     osa := 0;
    REPEAT
     osa := osa +1;
     if osa=1  then begin
                    i := a_getIntg (40, edv.YLE.SorceCount);
                    if (i>1) and  NOT lvEXTok  //{µ}(myLicense.lisenssilaajuus <lvEXTended)
                       then begin i := 1;
                                  edv.YLE.SorceCount.ArvoInt := i;  end; end //<''+120.5n/6U:  Jos ei EXT -laajuus, muutetaan aina yhdeksi.
               else i := {a_getIntg (41, }edv.YLE.JohtoOsia.ArvoInt;         //<1414cU: a_get..=>arvoInt.
    for i := 1 to i  do begin
     c := IntToStr (i);
     if osa=1  then begin sa := 'edv.Sorc[' +c +'].josa.';   rec := edv.Sorc[i].josa;  end
               else begin sa := 'edv.edka[' +c +'].     ';   rec := edv.edka[i];      end;

     KoeWn (sa +'Nimi          = ' +                        rec.Nimi.arvoStr);
     KoeWn (sa +'Kuluttaja     = ' +fBmrkt0 (a_getBool (45, rec.Kuluttaja), 2  ));
     KoeWn (sa +'PTlopussa     = ' +fBmrkt0 (a_getBool (46, rec.PTlopussa), 2  ));
     KoeWn (sa +'Tyyppi        = ' +                        rec.Tyyppi.arvoStr);
     KoeWn (sa +'Amm2          = ' +fRmrkt0 (a_getReaa (47, rec.Amm2)     , 1,0));
     KoeWn (sa +'PEker         = ' +fRmrkt0 (a_getReaa (48, rec.PEker)    , 1,2));
     KoeWn (sa +'JkUps         = ' +fImrkt0 (a_getIntg (49, rec.JkUps)    , 0  )); //<+120.6
     KoeWn (sa +'Lukumaara     = ' +fImrkt0 (a_getIntg (50, rec.Lukumaara), 1  ));
     KoeWn (sa +'Pituus        = ' +fRmrkt0 (a_getReaa (51, rec.Pituus)   , 1,1));
     KoeWn (sa +'Korjaus       = ' +fRmrkt0 (a_getReaa (52, rec.Korjaus)  , 1,3));
     KoeWn (sa +'Lampotila     = ' +fImrkt0 (a_getIntg (53, rec.Lampotila), 1  ));
     KoeWn (sa +'OfaVal        = ' +fImrkt0 (a_getIntg (54, rec.OfaVal)   , 1  ));
     KoeWn (sa +'Ph            = ' +fRmrkt0 (a_getReaa (55, rec.Ph)       , 1,2));
     KoeWn (sa +'Cosp          = ' +fRmrkt0 (a_getReaa (56, rec.Cosp)     , 1,2));
     KoeWn (sa +'Uho           = ' +fRmrkt0 (a_getReaa (57, rec.Uho)      , 1,2));
     KoeWn (sa +'Tuh           = ' +fImrkt0 (a_getIntg (58, rec.Tuh)      , 1  ));
     KoeWn (sa +'JkUps_Ik1v    = ' +fRmrkt0 (a_getReaa (59, rec.JkUps_Ik1v),1,1)); //<+130.2
   //KoeWn (sa +'JkUps_Ik3v    = ' +fRmrkt0 (a_getReaa (60, rec.JkUps_Ik3v),1,1)); //<+130.2 Ei tarvita
     KoeWn (sa +'JkUps_Cos     = ' +fRmrkt0 (a_getReaa (6, rec.JkUps_Cos ),1,3)); //<+141.1
     KoeWn ('OnArvot           = ' +fBmrkt0 (               rec.OnArvot   , 2  ));
     KoeWn ('');
    end;//for
    UNTIL osa=2;

    {,,,Näiden arvot jätetään tulostamatta, koska niitä ei ole laskettu vasta kun 26.INC :ssä:
      4 :with edvX.NjL  do begin //============================= NjL ============================================
              LueTal (58,edv_NjL, yhtZs    ,'yhtZs');
              LueTal (59,edv_NjL, yhtRs    ,'yhtRs');
              LueTal (60,edv_NjL, yhtXs    ,'yhtXs');
              LueTal (61,edv_NjL, yhtCosZs ,'yhtCo');
         end;}
  end; end;//TulRecorditKoe                                                                   //'''+6.2.2''''''''

  //=============================================================================================================
  procedure LueTalFile (alue :integer);
        VAR i :integer;  Uvx,ar,ra{:1415f:},re :real;  boo :boolean;  apuKey,sf :string;
            yRec :EdvTiedotType;   sRec :EdvSorceType;   nRec :EdvNjLahtoType;

    procedure Zto_RjaX(Iks1v,Zs :real;  VAR R,X :real);      VAR mm2,Rv,Rvo,Rn, Xv,Xvo,Xn, IkSal, Z,RprsZ :real;  n,ai,m :integer;   begin
      {Iks1v := 25.4; }mm2 := 16;  N := 1;  IkSal := IksalTerm ('AXMK',mm2);        //1415f: PRC laskee AXMK kaapRX´n mukaiset R ja X.
                       m := Trunc(Iks1v*1000);
       while IkSal*N < m  do begin                                 //'''Aina aloitus 16´lla, CASE osassa mm2 ja N ohjautuu.
          ai := Trunc(mm2);
          case ai of
             16  :mm2 := 25;
             25  :mm2 := 35;
             35  :mm2 := 50;
             50  :mm2 := 70;
             70  :mm2 := 95;
             95  :mm2 := 120;
             120 :mm2 := 150;
             150 :mm2 := 185;
             185 :mm2 := 240;
             240 :mm2 := 300;
             300 :mm2 := 1;  end;                 //                  ,,,,,,,,,,,                    ,,,,,,,,,,, Vain nämä PJ-liittymäjohdon osalle, kyl-
          IkSal := IksalTerm ('AXMK',mm2);        // V¨{[2Ry+2Rm+Rmo +2Rv+Rvo+3Rn] ² + [2Xy+2Xm+Xmo+ 2Xv+Xvo+3Xn] ²}.  'läkin yläverkko vaikuttaaMyös
       end;//while                                                                                                     'mutta siitä ei tietoa, OK.
       Rv :=  Res    ('AXMK',mm2);
       Rvo := ResVo  ('AXMK',mm2);
       Rn :=  ResN   ('AXMK',mm2);
       Xv :=  Xv_ind ('AXMK',mm2);
       Xvo := Xv0_ind('AXMK',mm2);
       Xn  := Xn_ind ('AXMK',mm2);
       R := 2*Rv+Rvo+3*Rn;
       X := 2*Xv+Xvo+3*Xn;  Z := Sqrt(Sqr(R) +Sqr(X));
       RprsZ := R/Z;
       R := Zs*RprsZ;
       X := Zs*(1-RprsZ);
    end;//Zto_RjaX

    procedure LueTal (os :integer;  alueS :string;  VAR alkio :arvoTyyp;  str :string);
          VAR sF :string;   eFnc,aoFnc :boolean;

       procedure AdjPalstaLev (VAR ss :string);      VAR sa :string;  o :integer;      begin
          sa := ss;   sa := sa +'  ';                //<Minimiväli '  '.
          for o := Length (sa) +1 to 50  do sa := sa +' ';
          ss := sa;  end;

       procedure tulF;      begin
          if NytKoeTul  then begin
             if os=1  then begin
                KoeWn ('   Luettu tiedosto: ' +anFilen);
                KoeWn ('   eFnc ,,,, -arvo on syntynyt ed. rivin, fnc.....,,, -arvo ao. rivin kutsukerralla:');  end;

             sF := 'os=' +fImrkt0 (os,3) +'  eFnc=';   //<,,Ed. kutsukerralla syntynyt FNC:n arvo.
             if eFnc  then sF := sF +' +'
                      else sF := sF +fBmrkt0 (eFnc,2);
             sF := sF +'  ' +alueS +':  ' +str +'=  ';
                                       //sF := sF +IntToStr (edvX.YLE.JohtoOsia.arvoInt); //<Tämä OK
             if NOT alkio.onArvo
             then sF := sF +'onArvo=FA  '
             else case alkio.arvoTyp of
                Intg :sF := sF + IntToStr (alkio.arvoInt);
                Reaa :sF := sF + fRmrkt0  (alkio.arvoRea, 1, alkio.Rdsm.Des);
                Strg :sF := sF +           alkio.arvoStr;
              //Bool :sF := sF + fBmrkt0  (alkio.arvoBoo, 2);
                Bool :if alkio.arvoBoo  then sF := sF + '+ '
                                        else sF := sF + 'FA';
             end;//case
             AdjPalstaLev (sF);
             sF := sF +'onArvo=';
             if alkio.onArvo  then sF := sF + '+ '
                              else sF := sF +'FA';
             sF := sF +'  fnc=';
             if Fnc  then sF := sF +' +'
                     else sF := sF +fBmrkt0 (Fnc,2); //<'Tällä kutsukerralla syntynyt FNC:n arvo.
             KoeWn (sF);
          end;//if
       end;//tulF
    begin//LueTal,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      eFnc := fnc;                                   //<Vain koetulostusta varten;
    //if fnc  then                                                                              //<-6.2.2
      if LUE  then begin
                   aoFnc := LueInifAlkio (EdvFile,alueS,alkio);        //<ALKIO palautuu kutsuun ######
                   tulF;  end
              else aoFnc := TalInifAlkio (1,EdvFile,alueS,alkio);      //<Tässä ALKIO ei muutu ########
      if NOT fnc  then
         fncS := COLOR_BLUE +'<b> / [' +alueS +']: ' +alkio.tunniste +'</b></f>';             //<+120.5i
      if fnc  then fnc := aoFnc;                                                                //<+6.2.2
      if fnc  then ;
    end;//LueTal
    //----------------------------------------------------------------------------------------------
    procedure LueBoo (Section,Key :String;  VAR ArvoB :boolean);      CONST err='X_Q_Z_£§4321';   VAR s :string;
    begin ArvoB := FALSE;
          s := EdvFile.ReadString (Section,Key,err);
          if s=err  then fnc := false                                 //<Globaali fnc
                    else if SamIso (s,'TRUE')  then ArvoB := TRUE
                                               else ArvoB := FALSE;
    end;
   {procedure LueStr (Section,Key :String;  VAR ArvoS :string);
    procedure LueInt (Section,Key :String;  VAR ArvoI :integer);
    procedure LueRea (Section,Key :String;  VAR ArvoR :real);
       s := EdvFile.ReadString (Section,Key,err);
       if s=err  then s := '';}

    procedure SijAlustFncTR (AlustAlkio :arvoTyyp;  VAR alkioU :arvoTyyp);      begin
       alkioU := AlustAlkio;  //Käytetään, kun esim. ikivanhassa filessä ei ollut ao. tietuekenttää, jolloin
       alkioU.onArvo := true; //halutaan sijoittaa oletusarvo. Tämä tehty 7.0.0 :ssa, modif. 6.2.2
       fnc := true;
    end;//SijAlustFncTR

  //function Lue_NotFnc_eFnc :boolean;      begin //+6.2.2
    function Lue_EdOliOK_TamaErr :boolean;      begin //+6.2.2
       if LUE  and NOT fnc  and edFnc  then result := true    //<Jos ennen vikaa lukuriviä ennen oli OK, mutta
                                       else result := false;  //'vikan luennassa FA => result := FA.
    end;

  (**)function pjIk1v_RperX_kerr (Ik1v :real) :real; //Palauttaa kertoimen, jolla  eRs = eZs * fnc.  +6.2.14  1415f: Tarpeeton, etsi "pjIk1v_RperX_kerr".
       procedure laske (Ik :real);
          CONST arI=10{ar Ik1v};  yrI=27000{Ik1v 1000kVA muunt.};  arRpX=0.9995{ar 10A};  yrRpX=0.145{Ik1v 1000kVA};
          VAR fnc :real;      begin //arI,yrI = ala,ylärajapiste Ik1v:lle,  ar,yrRpX = vastaavat R/X suhteet.
                                    //  Ik-arI     RpX-yrRpX
                                    // -------- = -----------  tämä suhde säilyy, joten ratkaistaan RpX:
                                    // yrI-arI    arRpX-yrRpX
                                    //
                                    //       (Ik-arI)(arRpX-yrRpX)
                                    // RpX = --------------------- + yrRpX
                                    //            yrI - arI
          fnc := arRpX;                           //<Jää voimaan jos Ik1v <= 10 A
          if Ik1v>10  then
             fnc := ( (Ik-arI)*(arRpX-yrRpX) / (yrI-arI) ) +yrRpX;
          result := fnc;
       end;//laske
       procedure laske2 (Ik :real);      {VAR rr,xx :real;   }begin
       end;
    begin//pjIk1v_RperX_kerr
      {Laske (5);
       Laske (10);
       Laske (10000);
       Laske (20000);
       Laske (27000);
       Laske (100000);}
       Laske (Ik1v);
    end;//pjIk1v_RperX_kerr*)

    //--------------------------------------------------------------------------------------------------,,,+6.2.2
    procedure LueTalEdkaSrcJohto;      CONST EdkaTR=TRUE;  EdkaFA=FALSE;      VAR o,ii :integer;

       procedure LueTalJohto (EdkaOsa :boolean); //< EdkaOsa=TR => edv.edka[1..]  FA=Liittymän Sorc[1..].josa
             VAR kpl,i,j,UPSoh :integer;  SecKey,ss :string;  rec :EdvPalstaType;

          procedure KirjoitaRiviValiVanhat;                                                         //<,,+6.2.9
                VAR SectList :TStringList;  sect,ss :string;  i,no :integer;

             function VanhaSectNo (sec :string) :integer;      VAR o :integer;  s :string;      begin
                result := -1;
                o := Pos (edv_Edka, sec);
                if o>0  then begin
                   s := Copy (sec,o+Length (sec)-1,Length (sec));
                   if SokI (s,o)  then
                      result := o;
             end; end;

          begin//KirjoitaRiviValiVanhat,,,,,,,,,,,,,,,,,,
             if fFileExists(anFilen)  then begin
                SectList := TStringList.Create;
                EdvFile.ReadSections (SectList);
               {ss := '';
                for i := 0 to SectList.Count-1  do ss := ss +SectList[i] +' # ';}
                for i := 0 to SectList.Count-1  do begin
                   sect := SectList.Strings[i];          //<"[edv_Edka7]"
                   no := VanhaSectNo (sect);             //< -1 jos ei SECT´issä "edv_Edka" + lopussa numero.
                 //if (no>-1) and  NOT EdvFile.ValueExists (sect, RiviValiKey)  then //<,Nyt kirjoitetaan AINA.
                   if  no>-1  then begin
                      if no>edikayty
                         then ss := 'Ent_e'+IntToStr (no)
                         else ss :=     'e'+IntToStr (no);
                      EdvFile.WriteString (sect, RiviValiKey, ss);
                   end;
                end;//for i
                SectList.free;
              //myFile.free;
             end;//if FileExists
          end;//KirjoitaRiviValiVanhat
{
E:\Projektit\NolaKehi\BIN\Data\Kokeilut621\K22500_1.NOE
}             //##################################################################################################
             //##### Tähän ei saa päästää VANHOILLA TIEDOSTORAKENTEILLA ennen kuin Sorc[].josa, Edka[] SE-  #####
             //##### KÄ NIIDEN Edka[].JohtoOsia ja Sorc[].SorceCount on korjattu (Edka[1] => Sorc[1].josa]).#####
             //##################################################################################################
       begin//LueTalJohto ,,,,,,,,,,,
          if EdkaOsa //====== Edka[] ===============================================================
          then begin                       //,,,JohtoOsia + SorceCount korjataan tämän PRC:n lopussa.
             kpl := {a_getIntg (4, }edvX.YLE.JohtoOsia.ArvoInt; //<1414cU: a_get..=>Arvoint.
             if (kpl=0) and (edvX.edka[1].Onarvot)  then begin  //<,Jikkonin ..\Jikkon\14.12.2016\PK-NOE´ssa oli JohtoOsia=0. Toimi OK vaikka en
                edvX.YLE.JohtoOsia.ArvoInt := 1;                //  tarkistanut OnArvot´a vaan sijoitin suoraan JohtoOsia.. := 1 .}
                if HerjaY_S<>''  then HerjaY_S := HerjaY_S +Chr(13) +Chr(13);
                HerjaY_S := HerjaY_S +'Luetussa tiedostossa <b>[' +anFilen +'] on johto-osien lukumäärävirhe 0 korjattu 1:ksi</b>, tarkista ja korjaa jos aihetta!';
             end;                      //'1415f: Nyt oletusarvo muutettu 1´ksi (oli 0), joten herjaa ei enää voi tulla.
             SecKey := edv_Edka;  end                           //  Taitaa vissiin aina talletta yhden johto-osan tiedot, muistelen, joten tiedot on.
          else begin //====== Sorc[].josa ==========================================================
             kpl := a_getIntg( 13,edvX.YLE.SorceCount); //<SorceCount pitää olla jo 622 mukana. //<+120.5n/6U:  Jos ei EXT -laajuus, muutetaan aina yhdeksi.
             if (kpl>1) and  NOT lvEXTok  then begin    //<130.0:  Nyt lvExtok sijoitettu GLOBALS´ssa. {µ}(myLicense.lisenssilaajuus <lvEXTended)
           //if (kpl>1) and  (myLicense.lisenssilaajuus <lvEXTended)  then begin                //<130.0:  lvEXTok ei vielä sijoitettu.
                ShowMessage('Tiedostossa: "' +EdvFilen +'" SorceCount -arvo>1, joka on sallittu vain EXTended ja GLOBals -laajuisilla '+
                            'versioilla. Arvo muutetaan lupaehtojen mukaiseksi (1)');
                edvX.YLE.SorceCount.ArvoInt := 1;  end;
             SecKey := edv_Sorce;  //#############################################################
          end;                     //##### HUOM.HUOM.HUOM.HUOM.HUOM.HUOM.HUOM.HUOM.HUOM.HUOM.#####
                                   //##### 1) a_put.. sijoittaa myös:       rec.onArvo := TR #####
                                   //##### 2) SijAlustFncTR:  FNC := TR  +  rec.onArvo := TR #####
                                   //#########################'''''''''#####'''''''''''''''' #####
                                   //#############################################################
        //for i := 1 to edvX.YLE.JohtoOsia.arvoInt  do  //<Tämä OK ilmaisu.
          for i := 1 to kpl  do begin
             (*if LUE
             then                     rec := alus_EdvEdka
             else *)if EdkaOsa   then rec := edvX.edka[i]
                                 else rec := edvX.Sorc[i].josa;   edFnc := fnc;

             if Lue  then for j := 1 to arvo_Max_15  do
                rec.arvoU[j] := 0;                                                            //<'+6.0.0
             LueTal (100*i+1, SecKey+IntToStr(i), rec.nimi     ,'Nimi '); //<,Jossain filessä on jo kokeiluNimi '12..'
                if LUE  and (NOT fnc  or fnc  and (Trim (rec.nimi.arvoStr)=''))  and edFnc  then begin
                   if NOT EdkaOsa and (i=kpl)  then j := 1                        //<'Ikivanhoissa eioo:  Nimi´ä
                                               else j := i;                       // 'tai uusissa jätetty tyhjiks.
                   a_putStrg (5, IntToStr (j), rec.nimi);   fnc := edFnc;  end;
               {if LUE  and edFnc  then                                           //<Ikivanhoissa eioo:  Nimi´ä
                   SijAlustFncTR (alus_EdvEdka.Nimi, rec.Nimi);}
             LueTal (100*i+2, SecKey+IntToStr(i), rec.kuluttaja,'Kul  ');
                if NOT EdkaOsa  then                                              //<,,120.5/6U:  Kaikkien Sorcien JkUps samaksi fileeseen kirjoituksessa.
                if NOT LUE  then begin                                            //<,,Vain talletuksessa.
                   UPSoh := 0;
                   if (rec.JkUps.ArvoInt>0)
                      then UPSoh := 1;
                   j := edvX.YLE.SorceCount.ArvoInt;                              //<141.1: oli If i=...ArvoInt; Selvisi miksei tallettanut.
                   for j := 1 to j  do begin
                      edvX.Sorc[j].josa.JkUps.ArvoInt := UPSoh;
                      LueTal (100+i+3, SecKey+IntToStr(i), rec.JkUps    ,'JkUps');
                   end;
                end;
             LueTal (100+i+3, SecKey+IntToStr(i), rec.JkUps    ,'JkUps');
                if NOT EdkaOsa  then                                              //<,,120.5/6U:  Kaikkien Sorcien JkUps samaksi filestä luettaessa.
                if LUE  then begin                                                //<,,Nyt vain luettaessa.
                   UPSoh := 0;
                   if (rec.JkUps.ArvoInt>0)
                      then UPSoh := 1;
                   if i=edvX.YLE.SorceCount.ArvoInt  then
                   for j := 1 to i  do begin
                      edvX.Sorc[j].josa.JkUps.ArvoInt := UPSoh;                   //,,edv.Sorc[].src.Ups_Ik1v ..Ups_Ik3v,Ups_Cos :arvoTyyp; //<+141.1
                      LueTal (100+i+3, SecKey +IntToStr(i), rec.JkUps     , 'JkUps');
                      LueTal (100+i+4, SecKey +IntToStr(i), rec.JkUps_Ik1v, 'JkUps_Ik1v');
                    //LueTal (100+i+4, SecKey +IntToStr(i), rec.JkUps_Ik3v, 'JkUps_Ik3v'); //JkUps´issa ei tarvita 3v vain pistorasiaPitLaskentaa.
                      LueTal (100+i+4, SecKey +IntToStr(i), rec.JkUps_Cos , 'JkUps_Cos');
                   end;
                end;                                                              //,,edv.edka[].JkUps_Ik1v .._Cos
             if LUE  and fnc  and edFnc  then begin                                            //<141.1
           //if {Lue_EdOliOK_TamaErr} edFnc  then begin
                 SijAlustFncTR (alus_EdvEdka.JkUps,      rec.JkUps);                           //<+120.6
                 SijAlustFncTR (alus_EdvEdka.JkUps_Ik1v, rec.JkUps_Ik1v);                      //<,,+141.1
               //SijAlustFncTR (alus_EdvEdka.JkUps_Ik3v, rec.JkUps_Ik3v); //<Ei tarvita.
                 SijAlustFncTR (alus_EdvEdka.JkUps_Cos,  rec.JkUps_Cos);
             end;
             LueTal (100*i+6, SecKey+IntToStr(i), rec.PTlopussa,'PTlop');
             LueTal (100*i+7, SecKey+IntToStr(i), rec.tyyppi   ,'Tyypp');
                if LUE  and fnc  then
                   if SamIso (a_getStrg ( 8,rec.tyyppi),'AMCMK')  then //<,2.0.3:ssa vanhat AMCMKt ovat 3½,
                    a_putStrg ( 9,'AMCMK3½',rec.tyyppi)           else //Lv=0.23mH/km, 3½½ ja 4½:ssa 0.25mH/km
                   if SamIso (a_getStrg ( 10,rec.tyyppi),'MCMK')   then
                    a_putStrg ( 11,'MCMK3½', rec.tyyppi)           else
                   if SamIso (a_getStrg (12,rec.tyyppi),'SVjärjest.')  then                    //<+,6.0.2
                    a_putStrg (13,'SVsystAL5S',rec.tyyppi);
             LueTal (100*i+8, SecKey+IntToStr(i), rec.Amm2     ,'Amm2 ');   edFnc := fnc; //<#####################
                               //'''''Jos seur.LueTal jälk. EDFNC=TR ja FNC=FA, syntyy mahd. virhe vasta jälempnä.
                    if Trunc(rec.Amm2.arvoRea)=3                              //<,+130. Pisako raportoi:  Lukee 2.5 3´ksi.
                       then rec.Amm2.arvoRea := 2;
             if LUE  and Older1101  and (rec.tyyppi.arvoStr='AMCMK3½')  and                    //<,+11.0.1
                ((rec.Amm2.arvoRea=25)  OR (rec.Amm2.arvoRea=35))  then begin //<'AMCMK3½o -testi ja korjaussijoitus,
                rec.tyyppi.arvoStr := 'AMCMK3½o';                             //  talletus vasta talletuskerralla.
                infoTyypKorj := 'Vanhasta laskentatiedostosta löytyi AMCMK3½ ' +fRmrkt0 (rec.Amm2.arvoRea,1,0) +
                   '/10cu, jonka NOLA nyt muutti vanhan asennuskannan kaapelityypiksi AMCMK3½<b>o</b> NOLAn '+
                   'tyyppinimikkeistön mukaan). Talletus automaattisesti vasta muiden muutosten yhteydessä, '+
                   'lopetettaessa tai erikseen pyydettäessä [Talleta] -painikkeesta.';
             end;

             LueTal (100*i+9, SecKey+IntToStr(i), rec.PEker    ,'PEker');
                if LUE  and NOT fnc  then
                   SijAlustFncTR (alus_EdvEdka.PEker, rec.PEker);             //<Pakko, ikivanhoissa eioo:  PEker
             LueTal (100*i+10, SecKey+IntToStr(i), rec.lukumaara,'Lukum');
                if LUE and Mukan_1 ('SVsyst',a_getStrg (13,rec.tyyppi)) and
                   (a_getIntg (14,rec.lukumaara)>1)  then
                   SijAlustFncTR (alus_EdvEdka.lukumaara, rec.lukumaara);
             LueTal (100*i+11, SecKey+IntToStr(i), rec.pituus   ,'Pituu');
             LueTal (100*i+12, SecKey+IntToStr(i), rec.korjaus  ,'Korja');
             LueTal (100*i+13,SecKey+IntToStr(i), rec.lampotila,'Lämpö');   edFnc := fnc;
                                                              //,,,,SijAlustFncTR:  rec.onArvo := TR  + FNC := TR
             LueTal (100*i+14, SecKey+IntToStr(i), rec.OfaVal  ,'OfaVa');
                if LUE  and NOT fnc  then                                   //<,,,Ikivanhoissa eioo.
                   SijAlustFncTR (alus_EdvEdka.OfaVal, rec.OfaVal);

             LueTal (100*i+15, SecKey+IntToStr(i), rec.Ph  ,'Ph   ');
                if LUE  and NOT fnc  then
                   SijAlustFncTR (alus_EdvEdka.Ph, rec.Ph);
                                                            {if EdkaOsa   then rec := edvX.edka[i]         Tästä selviää EdkaOsa + EdvX´n käyttö. 130.0
                                                                          else rec := edvX.Sorc[i].josa;}
             if NOT EdkaOsa and (i>1) and (edvX.Sorc[i-1].Josa.Ph.ArvoRea >0) //<,,+130.0:  Ei rinnakkaisten liittymien jälempiä J-osia Uh´hon.
             then begin
                {ShowMessage('Tiedostossa: "' +EdvFilen +'" Rinnakkaisliittymien peräkkäisiä johto-osia on määritetty laskettavaksi jännitealenemaan '+
                            'mukaan. ');{ +//Chr(10) +Chr(13) +
                            'Rinnakkaisjohdot pystyttäisiin laskemaan, mutta niiden vaikutus pääkeskuksen jälkeisiin johto-osiin ei ole ' +//Chr(10)+Chr(13) +
                            'loogisesti esitettävissä. Arvot korjataan rinnakkaisliittymän n:o ' +Ints(i) +':n osalta.');}
                rec.Ph.ArvoRea :=   0;    //'Tulee herja tästä, vex.
                rec.Cosp.ArvoRea := 1;
                rec.Uho.ArvoRea :=  0;
             end
             else begin                                                     //<+130.0
                LueTal (100*i+16, SecKey+IntToStr(i), rec.Cosp,'Cosp ');
                   if LUE  and NOT fnc  then
                      SijAlustFncTR (alus_EdvEdka.Cosp, rec.Cosp);

                LueTal (100*i+17, SecKey+IntToStr(i), rec.Uho ,'Uho  ');
                   if LUE  and NOT fnc  then
                      SijAlustFncTR (alus_EdvEdka.Uho, rec.Uho);
             end;//else

             LueTal (100*i+18, SecKey+IntToStr(i), rec.Uhp ,'Uhp  ');
                if LUE  and NOT fnc  then
                   SijAlustFncTR (alus_EdvEdka.Uhp, rec.Uhp);               //<Tätä ei talletettu, aina lasketaan.

{if EdkaOsa and (i=1)  then ;
rec.Uhv.arvoRea := 46.79;}
             LueTal (100*i+19, SecKey+IntToStr(i), rec.Uhv ,'Uhv  ');       //<+6.2.15 ,,,
                if LUE  and NOT fnc  then
                   SijAlustFncTR (alus_EdvEdka.Uhv, rec.Uhv);               //<Tätä ei talletettu, aina lasketaan.

             LueTal (100*i+20, SecKey+IntToStr(i), rec.Tuh ,'Tuh  ');
                if LUE  and NOT fnc  then
                   SijAlustFncTR (alus_EdvEdka.Tuh, rec.Tuh);
             //,,+130.2,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
             LueTal (100*i+21, SecKey+IntToStr(i), rec.JkUps         ,'JkUps');
                if NOT fnc  then                                             //<,,Vain kirjoituksessa.
                   SijAlustFncTR (alus_EdvEdka.JkUps     , rec.JkUps     );  //<Pakko, vanhemmissa eioo.
             LueTal (100*i+22, SecKey+IntToStr(i), rec.JkUps_Ik1v    ,'JkUps_Ik1v');
                if NOT fnc  then                                             //<,,Vain kirjoituksessa.
                   SijAlustFncTR (alus_EdvEdka.JkUps_Ik1v, rec.JkUps_Ik1v); //<Pakko, vanhemmissa eioo.
            {LueTal (100*i+23, SecKey+IntToStr(i), rec.JkUps_Ik3v    ,'JkUps_Ik3v');                    //<,Ei tarvita.
                if NOT fnc  then                                             //<,,Vain kirjoituksessa.
                   SijAlustFncTR (alus_EdvEdka.JkUps_Ik3v, rec.JkUps_Ik3v); //<Pakko, vanhemmissa eioo.}
             //,,+130.2,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                                                                     //,### edFnc määrää kokonaistilanteen.#######
                                                                      fnc := edFnc; //<#############+6.2.2
             if LUE and fnc  then rec.OnArvot := true;               //<### Tätä ei oltu talletettu <6.2.1:ssä ###

             //##################### Tähän tokax.###################################################
             if NOT EdkaOsa //====== Sorc[] ========================================================
             then begin
                  if LUE
                  then begin
                     if fnc                   //,,Jos VikaOs, vikaksi SorceCount:ksi edellinen = i-1
                     then edvX.Sorc[i].josa := rec  //##############################################
                     else begin
                        if i-1>=1  then begin   //<Pitää jäädä ainakin yksi LITTYMÄN JOHTO.!!!!!!!!!
                           fnc := true;         //<Jotta päästäisi lukemaan myös EdkaJohtoja.!!!!!!!!!
                           a_putIntg (31, i-1, edvX.YLE.SorceCount); //<Lukumääräksi edellinen i, joka oli OK.
                           for j := i to edLmaxKpl  do
                              edvX.Sorc[j].josa := tyh_EdvEdka{alus_EdvEdka}; //<onArvo := FA
                           ss := anFilen +' -tiedoston liittymän johto-osatiedoissa oli virheellinen arvo. Tiedoista '+
                                 'poistetaan virheellinen (0' +IntToStr (i) +') ja sen jälkeiset johto-osat.';
                           if InfoDlgFrm<>NIL      //<Muuten alkuluvussa KAIKKI jälemmät OHITTUU, TODETTU. Oltava vikana,
                           then InfoDlg (ss, mtWarning, 'OK','','','',  '','','','') //muuten ohittuu (ellei if..<>NIL)
                           else FileLukuVirhe := ss; //<Koska InfoDlg ei worki 1.luvulla, herjataan PaaValFrm:ssa.
                        end;
                     end;//else                                                        //
                  end    //,TALLETUS
                  else TalInif (1,EdvFile, edv_Sorce+IntToStr (i), RiviValiKey,'Sorce_'+IntToStr (i));  //<TalInif=TALLETUS.
             end
             //##################### Tähän ekax.####################################################
             else begin //====== Edka[] ============================================================
                  if LUE
                  then begin
                     if fnc                   //,,Jos VikaOs, vikaksi SorceCount:ksi edellinen = i-1
                     then edvX.Edka[i] := rec //####################################################
                     else begin
                        if i>=1  then begin     //<Edka´an ei tarvita johto-osia.!!!!!!!!!!!!!!!!!!!!!
                           fnc := true;         //<Jotta päästäisi lukemaan myös EdkaJohtoja.!!!!!!!
                           a_putIntg (31, i-1, edvX.YLE.JohtoOsia); //<Lukumääräksi edellinen i, joka oli OK.
                           for j := i to edMaxKpl  do
                              edvX.Edka[j] := tyh_EdvEdka;          //<onArvo := FA
                           ss := anFilen +' -tiedoston johto-osatiedoissa oli virheellinen arvo. ';
                           if Older622                              //<Tämän jälkeen Edka[1] := Edka[2] jne.
                              then ss := ss +'Vanhasta tietorakenteesta'
                              else ss := ss +'Tiedoista';
                           ss := ss +' poistetaan virheellinen (' +IntToStr (i) +') ja sen jälkeiset johto-osat.';
                           if InfoDlgFrm<>NIL      //<Muuten alkuluvussa KAIKKI jälemmät OHITTUU, TODETTU. Oltava vikana,
                           then InfoDlg (ss, mtWarning, 'OK','','','',  '','','','') //muuten ohittuu (ellei if..<>NIL)
                           else FileLukuVirhe := ss; //<Koska InfoDlg ei worki 1-luvulla, herjataan PaaValFrm:ssa.
                        end;
                     end;//else                                                        //ohittuu (ellei if..<>NIL)
                  end
                  else begin//,TALLETUS                                            //,"---.." rivi ed.sec.loppuun
                     TalInif (1,EdvFile, edv_Edka+IntToStr (i), RiviValiKey,{'e' 1414:}'Edka_'+IntToStr (i));    //<TalInif=TALLETUS.
                     if (i=kpl) and Older622  then
                        KirjoitaRiviValiVanhat;     //<Kirjoittaa "^^^^^^^...=Ent_e4"            //<+6.2.9
                  end;
             end;
             //if NOT EdkaOsa and (i>1) and (edvX.Sorc[2].Josa.Ph.ArvoRea >0)  then ; //<,,+130.0:  Testi: Ei rinnakkaisten liittymien jälempiä J-osia Uh´hon.
             //######################################################################################
             KoeVali___(300);
             if NOT fnc  then Break;
          end;//for i
       end;//LueTalJohto

    begin//LueTalEdkaSrcJohto,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

       LueTalJohto (EdkaTR{=edv.edka[]}); //<Ekax Edka, jotta siirto Edka[1] => Sorc[1].josa´aan,,mahdollista.!!!
          KoeVali___(30);       //###############################################################################
                                //##### VANHA RAKENNE KORJATAAN:  Edka[1] => Sorc[1].josa´aan ja siirretään #####
                                //##### loput Edka[2..] => Edka[-1] + korjaa YLE.JohtoOsia + YLE.SorceCount.
                                //###############################################################################
       if LUE  and Older622 //<,,Tähänkään ei tulla, ellei ALKULUVUSSA edellä ole testattu:  if InfoDlgFrm<>NIL
       then begin               //<SRC:n VANHA rakenne korjatan.#################################################
          edvX.Sorc[1].josa := edvX.edka[1];          //<,,Vanha tiedostorak, jossa edka[1]
          ii := a_getIntg (1, edvX.YLE.JohtoOsia);    //   siirretään Sorc[1].josa :an.
          for o := 2 to ii  do                        // ''Sorc[].src oli tehty jo YLE:n jälkeen luvussa.
             edvX.edka[o-1] := edvX.edka[o];          //<Siirretään loppupään johto-osatiedot
          edvX.edka[ii] := tyh_EdvEdka;               // alkupäähän päin =-1 ja vanha vika alust.
          a_putIntg (2,    1, edvX.YLE.SorceCount);   //<Kylläkin jo alustettu 1 :ksi.
          a_putIntg (3, ii-1, edvX.YLE.JohtoOsia);    //<Lukumäärä pieneni -1 :llä. SorceCount
       end else                                       // sijoitettu YLE:ssä, mahd. alustettu arvo.
          LueTalJohto (EdkaFA{Sorc[].josa});          //<TALLETUS + uuden LUKU ##################################
       KoeVali___(31);
    end;//LueTalEdkaSrcJohto''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''6.2.2

  begin//LueTalFile==============================================================================================
       //##################### Jos LUE ja LueTal => virhe, ALUSTETTU arvo jää voimaan, kok- #####################
       //##################### lattu 6.2.2 = ei tarvitse erikseen sijoittaa oletusarvoja.   #####################
       //########################################################################################################
                                //#############################################################
                                //##### HUOM.HUOM.HUOM.HUOM.HUOM.HUOM.HUOM.HUOM.HUOM.HUOM.#####
                                //##### 1) a_put.. sijoittaa myös:       rec.onArvo := TR #####
                                //##### 2) SijAlustFncTR:  FNC := TR  +  rec.onArvo := TR #####
                                //#########################'''''''''#####'''''''''''''''' #####
    case alue of                //#####################################################################################
                                //#####,,Alla on ALKUARVOT, jotka jäävät jos ei päälle LUETA tässä uutta. =12.0.0 #####
                                //#####################################################################################
      1 :begin //=============================================== YLE ============================================
         (*if LUE  then yRec := alus_EdvYLE{=EdvTiedotType}
                 else *)yRec := edvX.YLE;
         if LUE
         then fnc := LueTalInifVersio (1,TRUE{LUE}, EdvFile)
         else begin
              fnc := LueTalInifVersio (1,FALSE{NOT LUE},EdvFile);     //<Versiotiedot talletetaan AINA.##########
              TalInif (1,EdvFile, VersionSec,RiviValiKey,'Ver');      //<"========.." rivi ed.sec.loppuun. +6.0.1  TalInif=TALLETUS.
         end;                                                         //,,,######################################
                                                                      //'RiviValiKey= '^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'  Komment: <+1415f.
         LueTal (1, edv_YLE, yRec.Kuvaus    ,'Kuvau');   fnc := true; //<KaikissaVanhoissaEIoo, String''=OK
         LueTal (3, edv_YLE, yRec.JohtoOsia ,'JOsia');   edFnc := fnc;//<edFnc := tässä, koska seur.=uusi=mahdErr.
         LueTal (2, edv_YLE, yRec.SorceCount,'SCoun');   fnc := true; //<Uusi =nämä ''2 ei saa keskeyttää.<+6.2.2
         LueTal (4, edv_YLE, yRec.VaiheLkm  ,'vLkm ');                //<MuuttujaOli, Luku/Kirj.=RiviPuuttui+6.2.2
          //if LUE  and NOT fnc  and edFnc  =,,,                      //,Jos VaiheLkm -luvussa virhe, mutta sitä
            if Lue_EdOliOK_TamaErr  and Older622  then fnc := true;   //  edelliset OK. Jos<=6.2.1 => Alust=3 OK.
         LueTal (5, edv_YLE, yRec.Un        ,'Un   ');                //<,,Oltava OK.
         LueTal (6, edv_YLE, yRec.cU        ,'cU   ');
         LueTal (7, edv_YLE, yRec.LaakPmu   ,'LaakPm');
            if Lue_EdOliOK_TamaErr  then                              //<,Jos luvussa virhe, sijoitetaan. +130.2o
               SijAlustFncTR (alus_EdvYLE.LaakPmu, yRec.LaakPmu);     //<+130.2e:  Text := OnShow´ssa.
        {LueTal (7, edv_YLE, yRec.PrRjMm2   ,'PrRjMm2');
            if Lue_EdOliOK_TamaErr  then
               SijAlustFncTR (alus_EdvYLE.PrRjMm2, yRec.PrRjMm2);                                   //<+120.5 -130.0}
         LueTal (8, edv_YLE, yRec.IecOfa    ,'IecOf');   edFnc := fnc;                              //<+6.0.3
         LueTal (9, edv_YLE, yRec.PEN_PE    ,'PEN_P');                                              //<+6.0.3
            if Lue_EdOliOK_TamaErr  then                              //<,Jos luvussa virhe, sijoitetaan. <+6.2.2
               SijAlustFncTR (alus_EdvYLE.PEN_PE, yRec.PEN_PE);
         LueTal (10, edv_YLE, yRec.PoisAika ,'PoisA');    edFnc := fnc;
         LueTal (11,edv_YLE, yRec.PRaika    ,'PRaika');
            if Lue_EdOliOK_TamaErr  then                              //<,Jos luvussa virhe, sijoitetaan. ',+8.0.0
               SijAlustFncTR (alus_EdvYLE.PRaika, yRec.PRaika);
                                                                      //,SalaSallii, jos SalaEdi´llä >lvLT  <,,+8.0.0
    (*§LUO§ if LisYliDemo_ (lvLT{PRO}) and NOT SalaSallii (lvLT)      //,LT-versioon PRajaksi 0.4 s.
               then a_putReaa (4, 0.4, yRec.PRaika);                  //<'Myös EdvNew.PAS / PRC PvitaEdvFrm +8.0.0
                       LisYliDemo_ kutsuu:  FNC Demo / AnsiUpperCase (AsetusFrm.SalaEdi.Text)  ja AsetusFrm refe-
                       renssit aiheuttaa "Acces violation..." virheilmoituksen, koska Frm´ia ei vielä oltu luotu.
                       Tämän takia tämä testi ja sijoitus on siirretty PaaValFrm.Show ´iin.*)
                                                        fnc := edFnc; //<###################################+6.2.2
         LueTal (12,edv_YLE, yRec.AsTapa   ,'AsTapa');
            if Lue_EdOliOK_TamaErr  then                              //<,Jos luvussa virhe, sijoitetaan. +8.0.11
               SijAlustFncTR (alus_EdvYLE.AsTapa, yRec.AsTapa);
         LueTal (13,edv_YLE, yRec.LaakPmu  ,'LaakPmu');
            if Lue_EdOliOK_TamaErr  then                              //<,+130.2o
               SijAlustFncTR (alus_EdvYLE.LaakPmu, yRec.LaakPmu);
         LueTal (14,edv_YLE, yRec.ZpeBx    ,'ZpeBx');
            if Lue_EdOliOK_TamaErr  then                              //<,Jos luvussa virhe,..           <,+9.0.1
               SijAlustFncTR (alus_EdvYLE.ZpeBx, yRec.ZpeBx);
         if NOT LUE  then                      //Näihin (CASE X:) tullaan VAIN jos FNC = TRUE +onFILE tai NOT LUE
            TalInif (1,EdvFile,edv_YLE,RiviValiKey,'YLE'); //'##################################################' <TalInif=TALLETUS.
                                                           //'"=======.." -rivi edellisen sectorin loppuun +6.2.2
         edvX.YLE := yRec; //<Pitäiskö  rajoittaa:  if LUE ...
         KoeVali___(1);
         end;
      2 :begin //=============================================== Sorc[] =========================================
                                               //Näihin (CASE X:) tullaan VAIN jos FNC = TRUE +onFILE tai NOT LUE
         for i := 1 to a_getIntg( 11,edvX.YLE.SorceCount)  do begin //<Arvo = Mahd. YLE:ssä alustettu = 1.
          (*if LUE  then sRec := alus_EdvSorce{=EdvSorceType}
                  else *)sRec := edvX.Sorc[i].src;

//          with edvX.Sorc[i].src  do begin
               if LUE  and Older622
                  then apuKey := edv_YLE                   //<Vanhoissa FILEversioissa LUETAAN aina YLE-sectoria
                  else apuKey := edv_Sorce +IntToStr (i);  //<TALLETUKSESSA ja UUSISSA Sorce -sectoria.

               //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, Arvojen luku ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                                                           edFnc := true;   //<1.krlla AINA TRUE (=tänne tullessa)
               if LUE and  NOT Older622  OR  NOT LUE                        //<,Uudessa OLTAVA, muuten fnc := FA
               then LueTal (20, apuKey, sRec.SorceKind,'SKind')             //<sRec. +6.2.9
               else begin                               //<,,---------------LUE & VanhaFileType------------------
                //LueTal (21, edv_Sorce+IntToStr (i), SjPj, 'SjPj ');       //< .SjPj -alkiota eioo enää >= 6.2.2
                  LueBoo (apuKey, 'SjPj',boo);                              //<fnc := , 'SjPj' =IdentificationKey
                  if fnc
                  then begin                                                //<,,,Myös (sRec.)onArvo := TR
                       if boo  then a_putIntg (12, 1, sRec.SorceKind)//<,1=Transformer 2=LV-Cable 3=Generator 4=
                               else a_putIntg (12, 2, sRec.SorceKind);  end
                  else if edFnc  then fnc := true;             //< EiTarvitsisiEhtoa, koska 1.LUKUrivi ja edFnc=TR.
               end;                                        edFnc := fnc;    //'Jos NOT fnc => alustus jää voimaan
               LueTal (22, apuKey, sRec.Smn     ,'Smn');   edFnc := fnc;    //<Jos seur.LueTal jälk. EDFNC=TR ja
               LueTal (23, apuKey, sRec.TrfTyp  ,'TrfTy');                  // FNC := FA, onVirhe vain seur:ssa.
                  if Lue_EdOliOK_TamaErr  then fnc := true;  edFnc := fnc;
               LueTal (24, apuKey, sRec.yvRs    ,'yvRS ');                  //<,,Nämä jo hyvin vanhoja = oltava OK.
               LueTal (25, apuKey, sRec.yvXs    ,'yvXs ');
               LueTal (26, apuKey, sRec.Iks1v   ,'Iks1v');
               LueTal (27, apuKey, sRec.Iks3v   ,'Iks3v');
               LueTal (28, apuKey, sRec.Iks1vCos,'IksCo');
               LueTal (29, apuKey, sRec.pjLiitRs,'LpjRs');
                  if LUE and (sRec.SorceKind.arvoInt=2) and (sRec.pjLiitRs.arvoRea<=0) //<,,+6.2.8
                  then begin                               //'Sai juuri äsken arvon 1 tai 2.
                     sRec.SorceKind.arvoInt := 4;          //<pjLiitRx=0=pjLiitXs =>
                     sRec.pjLiitXs.arvoRea := 0;   end     //<eRs=0 => eXs := 0 ####################
                  else begin                                     //,,,-6.2.9
                    {//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,+6.2.9,,,,,,,
                     r2 := sRec.Iks1v.arvoRea;                         //< r2=Iks1v[kA]
                     rr := fLas_Iks1v_Zs (r2);                         //< rr=Zs  Iks1v[kA]
                     ar := fIk1v (rr)/1000;                            //<Lasketaan Iks1v[kA] Zs:stä
                           //,Esim. ((460-1200)/460)*100 = -160.87%  tai ((1200-460)/1200)*100 = 61.67%
                     a2 := ((r2-ar)/r2) *100;
                     si := '';
                     if (a2<-1) or (a2>1)  then
                        si := 'Impedanssista eZs laskettu Iks1v poikkeaa annetusta arvosta > 1 % (' +
                              fRmrkt0 (a2,1,1) +'). Korjaa Iks1v ja/tai eRs,eXs  (laskettu Iks1v olisi '+
                              fRmrkt0 (ar/1000,1,2) +' kA)';

                     if si<>''  then InfoDlg (si,  mtCustom, 'OK','','','',  '','','',''); //<''''''+6.2.9''''''}

(*,,Oli ennen 1415f:,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                     LueTal (30, apuKey, sRec.pjLiitXs,'LpjXs'); //<Vain alarajanMäärittelynTakia, arvo lasketaan, ks.,,
                     if LUE and fnc  then begin
                        Uvx := a_getIntg (14,edvX.YLE.Un) / Sqrt (3);  //< = fUv ei VIELÄ käytettävissä (=edvX)                   //<Uvx=230.94

                        ar := a_getReaa (15, sRec.pjLiitRs);           //< ar=pjLiitRs =5.111 ohm                                 //<pjLiitRs=5.111 =ar
                        if ar>0
                        then begin                                     //,kA -> Ampeereiksi,,, ################# ,,U/I=Z          //Ik1sv=600A (.6x1000)
                             rr := a_getReaa (16, edvX.YLE.cU) *Uvx / (a_getReaa (17, sRec.Iks1v)*1000);    //< rr= 0.95x230.94/600 => rr=0.365655 ohm
                             if rr<ar  //<'Lasketaan Zs(rr):  Jos Zs(rr) < pjLiitRs(ar) on kyseessä virhe (Zs´hän on määräävä =pjRs(ar) eiSaaOllaIsompi.)
                             then begin                                //,,Lasketaan kylmästi X/R -suhteella 2/3
                                ra := pjIk1v_RperX_kerr (rr);          //<1415f: ra´=` pj...(rr) =Siirtty seurRvltä.
                                ar := rr *ra;                          //< ar = eRs = eZs *2/3 (esim.)
                                a_putReaa (18, ar, sRec.pjLiitRs);
                                ar := Sqrt (Sqr (rr) -Sqr (ar));       //< =eXs, sijoitetaan jälempnä.
                                                                       //,,Alkulukuvirheestä tieto mahd. pääval:aan.
                                if InfoDlgFrm<>NIL  then               //<Jos <>NIL, voidaan infota heti eikä ole
                                   FileLukuVirhe := '';                // tarvetta viedä tietoa PaaVal :iin.
                                sf := 'PJ-liittymätiedoissa eRs arvo oli liian iso (pj) Ik1v :lle, eRs ja eXs '+
                                      'korjattu suhteessa, TARKISTA, MIKÄLI KÄYTÄT PJ-LIITYNTÄÄ.';
                                if FileLukuVirhe<>''                   //<Jos myös muita virheitä aikaisemmin
                                   then FileLukuVirhe := FileLukuVirhe +'<br>'
                                   else begin
                                        sf := anFilen +' -tiedoston ' +sf;
                                        FileLukuVirhe := sf;  end;
                                                         //,Koska InfoDlg ei worki 1-luvulla, herjataan PaaValFrm:ssa.
                                if InfoDlgFrm<>NIL  then //<Muuten alkuluvussa KAIKKI jälemmät OHITTUU, TODETTU.
                                   InfoDlg (sf, mtWarning, 'OK','','','',  '','','','');  end //Oltava vikana.
                             else begin
                                ar := Sqr (a_getReaa (19, edvX.YLE.cU) *Uvx / ( a_getReaa (20, sRec.Iks1v)*1000) ) -Sqr (ar);
                                ar := Sqrt (ar);  end;                 //<eXs = V¨[(cU*Uv/Iks1v)² - eRs²]
                             a_putReaa (21,ar, sRec.pjLiitXs);   end
                        else a_putReaa (22, 0, sRec.pjLiitXs);         //<eRs=0 => eXs := 0 ####################
                     end;{if LUE and fnc..}
                  end;                                     edFnc := fnc;
//''-1415f.  ,,1415f:*)
//,,1415f:,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                     LueTal (30, apuKey, sRec.pjLiitXs,'LpjXs'); //<Vain alarajanMäärittelynTakia, arvo lasketaan, ks.,,
                     if LUE and fnc  then begin
                        Uvx := a_getIntg (14,edvX.YLE.Un) / Sqrt (3);  //< = fUv ei VIELÄ käytettävissä (=edvX)                   //<Uvx=230.94
                        ar := a_getReaa (15, sRec.pjLiitRs);           //< ar=pjLiitRs =5.111 ohm                                 //<pjLiitRs=5.111 =ar
                        if ar>0                                                                                                   //,,re=Zs=ƒ(Ik1v)
                        then begin                                     //,kA -> Ampeereiksi,,, ################# ,,U/I=Z          //Ik1sv=600A (.6x1000)
                             //                        0.95 *230.94 /                      18.11 *1000  => re =0.012114 => Korjataan pjLiitRs=0.120 alust´een.
                             re := a_getReaa (16, edvX.YLE.cU) *Uvx / (a_getReaa (17, sRec.Iks1v)*1000);   //< re= 0.95x230.94/600 => re=0.365655 ohm=Zs
                             if re<ar  //<'Lasketaan Zs(re):  Jos Zs(re) < pjLiitRs(ar) on kyseessä virhe (Zs´hän on määräävä =pjRs(ar) eiSaaOllaIsompi.)
                             then begin
                                Zto_RjaX(ar,re, ar,ra); //<Iks1v,Zs to Rs,Xs: Etsii Iks1v´tä vastaava IkSalTrm (AXMK,mm²) jonka mukaisen R/X suhteestaLask.
                                                                       //,,Alkulukuvirheestä tieto mahd. pääval:aan.
                                if InfoDlgFrm<>NIL  then               //<Jos <>NIL, voidaan infota heti eikä ole
                                   FileLukuVirhe := '';                // tarvetta viedä tietoa PaaVal :iin.
                                sf := fRmrkt0(sRec.pjLiitRs.ArvoRea,1,5)+ ' => ' +fRmrkt0(ar,1,5) +'/' +fRmrkt0(ra,1,5);
                                sf := 'PJ-liittymätiedoissa eRs arvo oli liian iso Ik1v :lle: ' +sf +', =eRs/eXs '+
                                      'korjattu AXMK-johtoverkon mukaan (mm2 =Iks1v´n mukaan), TARKISTA LIITTYMÄIKKUNASSA, MIKÄLI KÄYTÄT PJ-LIITYNTÄÄ.';
                                a_putReaa (18, ar, sRec.pjLiitRs);     // ar=eRs=Rs.Vasra tässä ettei ed. infossa eRs arvo muuttuisi 1415f.
                                a_putReaa (19, ra, sRec.pjLiitXs);     // ra=eXs=Xs. +1415f.
                                if FileLukuVirhe<>''                   //<Jos myös muita virheitä aikaisemmin
                                   then FileLukuVirhe := FileLukuVirhe +'<br>'
                                   else begin
                                        sf := anFilen +' -tiedoston ' +sf;
                                        FileLukuVirhe := sf;  end;
                                                         //,Koska InfoDlg ei worki 1-luvulla, herjataan PaaValFrm:ssa.
                                if InfoDlgFrm<>NIL  then //<Muuten alkuluvussa KAIKKI jälemmät OHITTUU, TODETTU.
                                   InfoDlg (sf, mtWarning, 'OK','','','',  '','','','');  end //Oltava vikana.
                             else begin
                                ar := Sqr (a_getReaa (19, edvX.YLE.cU) *Uvx / ( a_getReaa (20, sRec.Iks1v)*1000) ) -Sqr (ar);
                                ar := Sqrt (ar);  end;                 //<eXs = V¨[(cU*Uv/Iks1v)² - eRs²]
                             a_putReaa (21,ar, sRec.pjLiitXs);   end
                        else a_putReaa (22, 0, sRec.pjLiitXs);         //<eRs=0 => eXs := 0 ####################
                     end;//if LUE and fnc..
                  end;                                     edFnc := fnc;
//''1415f:'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
               if LUE  and fnc  and edFnc  OR NOT Lue  then begin          //<,,+141.1
                  LueTal (31, apuKey, sRec.Ups_Ik1v, 'Ups_Ik1v');          //<Näköjään sijoitti alustetun arvon jos eioo filessä
                     if NOT fnc
                        then sRec.Ups_Ik1v.ArvoRea := sRec.Iks1v.ArvoRea;  //<Toimii tosiaan OK: Edellä sijtti alustetun, tässä sij vanha "oletus".
                  if edFnc
                     then LueTal (32, apuKey, sRec.Ups_Ik3v, 'Ups_Ik3v');
                     if NOT fnc
                        then sRec.Ups_Ik3v.ArvoRea := sRec.Iks3v.ArvoRea;
                  if edFnc
                     then LueTal (33, apuKey, sRec.Ups_Cos, 'Ups_Cos');    //<Tähän ei ole vanhoja oletuksia kuten ..Ik1v.. jne.

                  if edFnc  then fnc := true;
               end;

               if LUE  and fnc  and edFnc  OR         //<Kylläkin edFnc=fnc, ks. ed rv.       //<,,,+6.2.2,,,,,,,
//                NOT Lue and edvX.Sorc[i].SorceKind=3{Gener.}  then begin                    //<   +8.0.0
//Ei ehkä ole järkevää pistää TALLETTUMAAN ennenkuin on param.tarve huomioitu ja kokeiltu.
               NOT Lue  then begin                                                     //<,,+8.0.0
                  LueTal (40, apuKey, sRec.gSn     , 'gSn  ');   if edFnc  then fnc := true;
                  LueTal (41, apuKey, sRec.gXd     , 'gXd  ');   if edFnc  then fnc := true;
                  LueTal (42, apuKey, sRec.gXd1    , 'gXd1 ');   if edFnc  then fnc := true;
                  LueTal (43, apuKey, sRec.gXd2    , 'gXd2 ');   if edFnc  then fnc := true;
                 {LueTal (44, apuKey, sRec.gX2     , 'gX2  ');   if edFnc  then fnc := true;
                  LueTal (45, apuKey, sRec.gX0     , 'gX0  ');   if edFnc  then fnc := true;}
                  LueTal (47, apuKey, sRec.gRs     , 'gRs  ');   if edFnc  then fnc := true;
                  LueTal (48, apuKey, sRec.gTd1    , 'gTd1 ');   if edFnc  then fnc := true;
                  LueTal (49, apuKey, sRec.gTd2    , 'gTd1 ');   if edFnc  then fnc := true;
                  LueTal (50, apuKey, sRec.gtIkMin , 'gtIkMi');  if edFnc  then fnc := true; //<,,+8.0.8
                  LueTal (51, apuKey, sRec.gtIkSust, 'gtIkSu');  if edFnc  then fnc := true;
                  LueTal (52, apuKey, sRec.gIkSust , 'gIkSus');  if edFnc  then fnc := true;
                  LueTal (53, apuKey, sRec.gK1vSust, 'gK1vSust');  if edFnc  then fnc := true;
               end;

                  if LUE and fnc  then sRec.OnArvot := true; //<########################################## +8.0.0
                                                      //,Ei voi kutsua, koska JohtoOsia on viel virheellinen/vanha.
                edvX.Sorc[i].src := sRec; //<Pitäiskö  rajoittaa:  if LUE ...
                KoeVali___(2);                           fnc := edFnc; //<######################### +6.2.2'''''''
//          end;//with                                //########################################//<'''+6.2.2'''''
         end;//for
         end;
      3 :begin //=============================================== Edka[] =========================================
            LueTalEdkaSrcJohto; //<################################################################//<+6.2.2
         end;
      4 :begin //=============================================== NjL ============================================
            if LUE  then nRec := alus_EdvNjL{=EdvNjLahtoType} //Uusittu 6.2.2: Vain kirjoitetaan, ei sekään pakko
                    else nRec := edvX.NjL;                    //mutta näkeepähän tiedostosta loppupään arvot.
            if NOT LUE  then begin
               LueTal (58,edv_NjL, nRec.yhtZs    ,'yhtZs');      //Jäävät lukematta/kirjoittamatta:
               LueTal (59,edv_NjL, nRec.yhtRs    ,'yhtRs');      // yhtR1,yhtX1
               LueTal (60,edv_NjL, nRec.yhtXs    ,'yhtXs');      // Ik1v,Ik3v,Ik3t,Ik3d
               LueTal (61,edv_NjL, nRec.yhtCosZs ,'yhtCo');      //''Aina lasketaan, ei olekaan tarvetta kirjoittaa.
               TalInif (1,EdvFile,edv_NjL,RiviValiKey,'NjL'); //<################################## +6.2.2 ###### <TalInif=TALLETUS.
            end;
         edvX.NjL := nRec;
              KoeVali___(4);
         end;
    end;//case alue
  end;//LueTalFile
//===============================================================================================================
  function fLue_Talleta :boolean;
        LABEL 1,3{1415f},9;
        VAR onf :boolean;  KoeFilen,uFilen{,sq} :string;  i,ohj{1414f} :integer;   aEdvFile :TInifile;
                                                                //,Kirjoittaa versiokohtaisesti ajokertojen Lkm.
     procedure JarjestaFileRivit;        {Uhv=0.000
                                          Tuh=70
                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=Sorce_2          <Tämä rivi siirretään
                                          gSn=1000                                           ennen [edv_...]
                                          gXd=2.730
                                          [edv_Sorce2]
                    Kun Inifile´en lisätään rivejä, edellinen Section´in vika rivi (^^^^...) ei siirrykään vikak-
                    si, vaan uudet rivit ([xxx=...]) menevät sen alapuolelle. TÄSSÄ ^^^^... siirretään vikaxi.}
           VAR FromFile :Text;  FromFilen,ToFilen, sFrom,sVali :string;  MyList :TStringList;

        function EriFile :boolean;
              VAR {A,B :RichEdit;  }i,j :integer;  Alist,Blist :TStringList;  eri :boolean;    begin
              
           Alist := TStringList.Create;
           Blist := TStringList.Create;
                    {A.Lines.LoadFromFile ('E:\Projektit\NolaKehi\BIN\Data_A_Olet-Ev-koe.NOE');
                     B.Lines.LoadFromFile ('E:\Projektit\NolaKehi\BIN\Data_B_Olet-Ev-koe.NOE');}
                    {Alist.LoadFromFile ('E:\Projektit\NolaKehi\BIN\Data\_A_Olet-Ev-koe.NOE');
                     Blist.LoadFromFile ('E:\Projektit\NolaKehi\BIN\Data\_B_Olet-Ev-koe.NOE');}
           Alist.LoadFromFile (FromFilen);
           Blist.LoadFromFile (ToFilen);

           eri := false;
           if Alist.Count<>Blist.Count                      //<EriFile jos riviLkm eri.
           then eri := true
           else for i := 0 to Alist.Count-1  do begin       //<,Etsitään FileModified -rivi joka pois, jotta pvmEiVaikuta
              j := Pos ('FileModified=', Alist.Strings[i]); //FileModified=21.9.2004 11:39:13
              if j>0  then begin
                        //if Blist.Strings[i]<>''  then ;
                        //if Blist.Strings[i]<>''  then ;   //,Vain aikaero (ehkä) ellei muita eroja.
                 Alist.Delete(i);                           //FileModified=21.9.2004 11:39:13
                 Blist.Delete(i);                           //FileModified=21.9.2004 11:39:12
                        //if Blist.Strings[i]<>''  then ;
                        //if Blist.Strings[i]<>''  then ;
                 if Alist.Text<>Blist.Text
                    then eri := true;
                 Break;  end;
           end;//for
           result := eri;
        end;//EriFile;

     begin//JarjestaFileRivit..............................
                      //,1414fu? =ei muut.
        FromFilen := anFilen;  ToFilen := FromFilen +'$$$';        //<'ToFile vain väliaikainen.
                               //¿DefsFileenZ('AssgnFile 4');
                               YFileen('¿FileEv.INC 1');
        AssignFile (FromFile,FromFilen);
          Reset (FromFile);

        sVali := '';  sFrom := '';
        MyList := TStringList.Create;
        try
      //while NOT Eof (FromFile)  do begin       //<Vika ^^^... -rivi (tms.) jää tulostumatta, todettu.
        if NOT Eof (FromFile)  then
        REPEAT
           Readln (FromFile,sFrom);              //,Tällaisia rivejä EI SAA OLLA kuin YKSI ennen [edv_...]
           if Pos (RiviValiKey,sFrom)>0          //<Löytyi välirivi ennen seur.Section´in alkua. RiviValiKey='^^^^...';
              then sVali := sFrom                 //<Pannaan rivi sivuun kunnes löytyy uuden Section´in alku.
              else if (Pos ('[edv_',sFrom)>0) and (sVali<>'') //<Löytyi seur. Section´in alku.
                   then begin
                      MyList.Add (sVali);              //<,Pannaan listaan sivuun laitettu välirivi ja
                      MyList.Add (sFrom);              //<,myös [edv_...] -rivi heti sen jälkeen.
                      sVali := '';  end
                   else if sFrom<>''
                   then begin
                        MyList.Add (sFrom);              //<Talteen otetun rivin JÄLKEISET rivit listaan (josEiTyhjä)
                        sFrom := '';                     //<Vain jotta UNTIL´in jälkeen testattavissa.
                   end;
           if sFrom<''  then ;
        UNTIL Eof (FromFile);       //<while -silmukka jättäisi viimeisenä rivinä olevan ^^^...-rivn vex, todettu.
           if sVali<>''  then       //
              MyList.Add (sVali);                //<Eof :n jälkeen, jo luettu vika rivi vielä listaan, todettu.
           MyList.SaveToFile (ToFilen);
        finally
           MyList.Free;
        end;

        CloseFile (FromFile);
        CopyFile(PChar(ToFilen), PChar(FromFilen), false); //<Kopioi filen toiselle nimelle, FA=Kopioi päälle
        if NOT EriFile                                     //<,Jos filet samoja, delataan juuri tehty ja vanha
        then DeleteFile (ToFilen)                          //  (FromFile) jää. Vertailussa oli otettu rivi "FileM-
        else begin                                         //  odified=" kokonaa pois jotta sen pvm ei vääristäisi.
             DeleteFile(FromFilen);                        //<ALPfile delataan
             RenameFile(ToFilen,FromFilen);  end;          //<Apufile nimetään ALPfileksi
     end;//JarjestaFileRivit

  begin//fLue_Talleta,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    NytKoeTul := false;
   {================= JOS TAHDOT KoeTulostuksen VEX, poista kommenttisulku TÄMÄN RIVIN LOPUSTA ================= Poistettu 120.5n/6
                    if IsDebuggerPresent  then begin
                        NytKoeTul := true;
                        KoeFilen := gAjoPath; //+-12.0.05 oli: ExtractFilePath (Application.ExeName); //<Pelkkä polku ilman filenimeä
                        KoeFilen := KoeFilen +'Data\Kokeilut';
                        if NOT DirectoryExists(KoeFilen)  then             //<KoeFilen tässä vain DIR
                           ForceDirectories (KoeFilen);
                        KoeFilen := KoeFilen +'\UusiTiedostoRak.TXT';
                                       DefsFileenZ('AssgnFile 17');
                        AssignFile (KoeFile,KoeFilen);
                        if inFilen=''
                           then Rewrite (KoeFile)  //<Vain alkuluvussa kirjoitetaan uusiksi.
                           else Append  (KoeFile); //<Muuten kirjoitetaa loppuun (kun tullaan >= 2.kerran tänne).
                        writeln (KoeFile, EdvFilen +'   ' +DateTimeToStr (Now)); //< Tai:  sd := TimeToStr(Time);
                     end;//'Aikaleimaus tulee 2x:  1.=Kun tämän jälkeen luetaan alkioita  2.=Muokattujen tulost.}
  //============================================================================================================}
                     //if NOT TalInif (oha,AOfile, VersionSec,FileModifiedKey,s)  then Exit; //<Y_.PAS´sista
    infoTyypKorj := '';                 //<11.0.1:  >0 = AMCMK3½ 25t35/10cu & Older1101 =Muutettava AMCMK3½o :ksi.
  1:
//¿DefsFileenZ('FileEv.INC/LueTal 1: inFilen=' +inFilen); //+120.3
                 YFileen('¿FileEv.INC 2');
    anFilen := inFilen;                      //<inFilen säilytet. ALKUPERÄISENÄ LOPPURIVLLE ASTI ###  KESKEN KESKEN
    fnc := false;
                 //LueTalFilenReg (1,LueTR,KysFA,EdvFilen); //<Testaan tässä kun Reg´n PreNet='' pitäisi EdvFilen := Olet-Ev.NOE .
                 DebWr(0,'1/2','       fLue_Talleta / FileEv.INC:  inFilen= ' +inFilen);
    //if Lue  then //<+1414f: Jos Save as meni tässä sisään ja muutti nimen OletEv.NOE´ksi vaikka oli uusi nimi annettu.
    //,,FileListN.PAS/fLueTal_FileLista´ssa 0 KUN sinne PÄÄDYTTY ja sieltä KUTSU estää ikuisn silmkukan.§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
    //,,§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§,,,!,,,,!,,,,,,,§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
    ohj := Y_gLueTal_FileLista (13,1, LUE,KYSY,anFilen); //< -1 =Cancel  0= IkuisSilmukan esto ks.FileListN/fLueTal_FileLista. Ehkei OLE???.§§§§§§§§§§§§
    if ohj<0  then GOTO 9;                               //'mm. FileLstN.PAS ja Y_.PAS: Y_gLueTal_FileLista/FileLstFrm.fLueTal_FileLista ´ssa saa arvot.
                 DebWr(0,'2/2','       fLue_Talleta / FileEv.INC:  anFilen= ' +anFilen);  //'Ensiajossa tekee OLETUSNIMEN, 'JOS LueFA -> FILEnimen TALLETUS.
    //if LUE  then begin -1415f                        //<1415f: Lieneekö muutenkaaan tarvis?
       alkuarvot;                                      //<Asettaa alkuoletukset:  YLE+NjL+Edka[1] ##
       FileLukuVirhe := '';//end;                      //<''Talletssa kohta tiedettävä jos <>''   =+11.0.1
    fnc := true;   //<GLOBAALI FNC:ssa #############################################################
    onf := true;                                       //'JÄÄVÄT VOIMAAN JOS EIOO vielä tiedostoa ##
    if LUE  then onf := fFileExists(anFilen);
                   //,,,LUKU tai KÄYTTÄJÄN t. LoppuTALLETUS ########################################
   {if LUE and onf  and Older_12_0_6_OR_JkUpsPuuttuu        //<Myös PaaVal´ssa sama. EI ENÄÄ 141.1 . Ohitettu 141.1 koska lopussa kutsu AINA.
       then ;//SortInif;                                    //<'Siirrtty jälempää 141.1 .}
   {if (LUE and onf  or  NOT LUE)                           //<IF onf -testi riittäisi, nyt ei ehtoja...
    then begin//1415} //try }                               //,Näissä luetaan kaikki alkiot ehdol-
       EdvFile := TInifile.Create (anFilen);                //'lisesti:  if FNC  then LUEF(); Siirto tähän 11.0.1
       Older622 :=  fOlderVersioThan ( 6,2,2);              //<,Kutsu vasta tässä, koska EdvFile PITÄÄ OLLA.
       Older1101 := fOlderVersioThan (11,0,1);                                                  //<+11.0.1
                 //¿DefsFileenZ('FileEv.INC/LueTal 2: ®®®®® AnFilen: ' +AnFilen);
                 YFileen('¿FileEv.INC 3');
       if NOT LUE  and fFileExists(anFilen) then begin                                          //<+11.0.1
          if Older622  then begin                           //<Ei tarvita tälle testiä if FileLukuVirhe<>''.
             if NOT EdvFile.ValueExists(edv_YLE,'SorceCount')  then begin //1414d: Exs_ poistettu Defs.PAS´sista, joten tästäkin,tuleeko ONGELMIA?
                uFilen := anFilen +'-Ver621';                  //< Edellinen tietorakenneversio (622:ta edeltävä)
                CopyFile(PChar(anFilen), PChar(uFilen),false); //< FA =kirjoittaa päälle jos on jo file.
                aEdvFile := TInifile.Create (uFilen);          //<,Lisätään inforivi varm.kopioon
                aEdvFile.WriteString (VersionSec,'---------', 'Varmistuskopio ver 6.2.1 :sta ennen ver 6.2.2 muutoksia');
                aEdvFile.Free;
             end
          end else                   //<,,ELSE: Jos ed.ehto tallettaa, tätä,, ei tarvitakaan.  //,,+11.0.1
          if Older1101  and Is_AMCMK3_25t35_to_AMCMK3o (anFilen)  then begin //<Tarve AMCMK3½ => AMCMK3½o .
             uFilen := anFilen +'-Ver1101';                   //< Edellinen tietorakenneversio (1101:ta edeltävä)
             CopyFile(PChar(anFilen), PChar(uFilen),false);   //< FA =kirjoittaa päälle jos on jo file.
             aEdvFile := TInifile.Create (uFilen);            //<,Lisätään inforivi varm.kopioon. COPY vaikka ehkä
             aEdvFile.WriteString (VersionSec,'---------',    //'AMCMK3½o muutettu edelleen, joka tapaukssa muutos
                                  'Varmistuskopio ennen Ver 11.0.1 muutoksia'); //'jo havaittu lopetettaessa ja
             aEdvFile.Free;                                                     //'talletushalu kysytty.
            {InfoDlg  ('NOLA on muuttanut vanhan asennuskannan kaapelityypin AMCMK3½ (25/10cu tai 35/10cu) '+
               'AMCMK3½o -tyypiksi. Alkuperäisestä tiedostosta tehty varmuuskopio lopputarkentimella Ver-1101<br>'+
               '(=<b>' +uFilen +'</b>)', mtInformation,'OK','','','', '','','','');}
                                              //'Jo lukuvaiheen jälkeen PaaVal:n avautuessa tiedotus infoTyypKorj
          end;//if Older1101                  //'Ei tarvita infoa: PaaValOnClose´ssa ilmoitus.//<''+11.0.1
         {if Older_12_0_6_OR_JkUpsPuuttuu     //<Myös PaaVal´ssa sama. EI ENÄÄ 141.1 .
             then SortInif;                   //<'Siirrtty LUE -puolelle.}
       end;//if NOT LUE and fFile...
  //end;//if LUE and onf  or  NOT LUE +ent TRY //<1415f: Siirtty tähän rvltä 1728.######################################################################

 //KESKEN KESKEN ,+141.1 ??? En muista, mikä jäi vielä tarkistettavaksi. Mahd. liittyi NOE,NON,NOM.. tyyppien tarkistukseen. 16å10/10.10.2016 .
                              //,,Vasta tässä aletaan sijoittaa arvoja muuttujiin:
       if NOT LUE  then begin                                //Jos eioo filesta luettu, sijoitetaan ALKUARVOT (komm: 12.0.0), tai(1415f) eiVIeläTallettu.
          edvX := edv;                                       //<Sijoitetva,jotta olisi TALLETETTAVAA
          edvE := edv;  end;                                 //<JottaFNCeriEdv palauttaisi FALSE lopputarkstssa
       u := 0;  if LUE  then u := 1;        //<,,+1415f: Alp LUE talteen: u=0=FA.
3:                                  //<1415f: Tähän takas hyppy jos LueTalFile´istä FNC=FA =Luvussa virhe =ehkä tiedot vajaita tai puuttuu tai muu virhe,
                                    //        eli mennään kirjoittamaan file fyysisesti tiedostoksi vaikka alla olisi vajaa, tämä päälle.
                    LueTalFile (1);         //< edv.YLE
       if fnc  then LueTalFile (2);         //< edv.Sorc[]
       if fnc  then LueTalFile (3);         //< edv.edka[]
       if fnc  then LueTalFile (4);         //< edv.NjL
       if NOT fnc  then begin               //<Oli vain ed:n  if fnc then... else alkuvarvot;    //<+6.2.2
          alkuarvot;                        //'<########## Jos aivan lopussa NOT FNC => EdvFilen := Olet-Ev.NOE ################
          if u=1  then begin
             u := 2;  LUE := false;         //<Jotta LueTalFile´issä tallettaisi.
             GOTO 3;  end;
        end;
        LUE := u>0;                         //<''+1415f.
if edv. Sorc[1].src.pjLiitRs.ArvoRea >0  then; // =0
if edvX.Sorc[1].src.pjLiitRs.ArvoRea >0  then; // >0
     //if u=0  then LUE := false  else LUE := true;          //<1415f: Palautetaan alp LUE -arvo.
       if LUE and (infoTyypKorj<>'')  then begin                                               //<,,+11.0.1
          if FileLukuVirhe<>''  then FileLukuVirhe := FileLukuVirhe +'<br>';
          FileLukuVirhe := FileLukuVirhe +infoTyypKorj;                        //<Tarvitaan vieläkin PaaVal.PAS/OnClosesta.
          if InfoDlgFrm<>NIL then                                              //<PaaVal´ista tultssa 1.krlla =NIL.
             InfoDlg (FileLukuVirhe, mtInformation, 'OK','','','',  '','','',''); //'<>NIL jo esim. EdvNew.LueBtn´sta
       end; //'InfoDlg tässä vielä ERROR.                                         //'Info myös PaaVal.PAS ´ssa.
                 //¿DefsFileenZ('FileEv.INC/LueTal 3: ®®®®® AnFilen: ' +AnFilen);
                 YFileen('¿FileEv.INC 4');
       if NOT LUE
          then edvf := edv;
       EdvFile.Free;
       if NOT Lue  then
          JarjestaFileRivit;     //<############# ^^^^^... siirretään uusien rivien jälkeen.######### +8.0.0
{  @except                       //<,Varsinainen käsittely (=HERJA) Lue/talInif../Y_ :ssä ###########
       on E :Exception  do begin //'141.1:  Mahtaneeko olla kuten PRC SortInif, missä myös ainakin esiintyy "^^^^^.." rivi.
          fnc := false;
                 //¿DefsFileenZ('FileEv.INC/LueTal 4 Except: ®®®®® AnFilen: ' +AnFilen);
                 YFileen('¿FileEv.INC 5');
       end;//on
    end;//if LUE and onf  or  NOT LUE .. @except =poistettu 1415f.}
//------------------------------------------------------------------------------------
    if LUE  then begin
       if NOT fnc  and KYSY  then begin
          //EiOkInfo ('Tiedosto "<b>' +anFilen{+120.5i} +'</b>"' +fncS +' on virheellinen, valitse uudelleen!'); //<,,+120.5i
          if     fFileExists(anFilen) and     fFileExists(GListaEvFileN)  then tapaus := '11'  else
          if     fFileExists(anFilen) and NOT fFileExists(GListaEvFileN)  then tapaus := '10'  else
          if NOT fFileExists(anFilen) and     fFileExists(GListaEvFileN)  then tapaus := '01';

          if tapaus='11'  then                                                                                  //<,,+120.5i
             u := InfoDlg ('Tiedosto "<b>' +anFilen +'</b>"' +fncS +' on virheellinen, valitse uudelleen!', mtCustom, 'OK','EditoiFile','EditoiLista','',
                           'Jatketaan tiedostovalintaan','Editoi (NotePad) viallinen tiedosto','Editoi tiedostolista','')  else
          if tapaus='10'  then
             u := InfoDlg ('Tiedosto "<b>' +anFilen +'</b>"' +fncS +' on virheellinen, valitse uudelleen!', mtCustom, 'OK','EditoiFile','','',
                           'Jatketaan tiedostovalintaan','Editoi (NotePad) viallinen tiedosto','','')  else
          if tapaus='01'  then
             u := InfoDlg ('Tiedosto "<b>' +anFilen +'</b>"' +fncS +' on virheellinen, valitse uudelleen!', mtCustom, 'OK','EditoiLista','','',
                           'Jatketaan tiedostovalintaan','Editoi tiedostolista','','');

          if tapaus='11'
          then if u=2
               then se := AnFilen
               else se := GListaEvFileN //u=3
          else
          if tapaus='10'
          then begin
               if u=2
               then se := AnFilen;  end
          else
          if tapaus='01'
          then begin
               if u=2
               then se := GListaEvFileN;
          end;
          if u IN [2,3]  then
             ShellExecute (0{Handle},'open', {C:\Program Files\Windows NT\Accessories\}'notepad.exe', PChar(se), nil, SW_SHOW);
          GOTO 1;
       end;//if NOT fnc  and KYSY
       for i := edvX.YLE.JohtoOsia. arvoInt+1 to edMaxKpl   do edvX.edka[i].OnArvot := false;
       for i := edvX.YLE.SorceCount.arvoInt+1 to edLmaxKpl  do edvX.Sorc[i].Josa.OnArvot := false; //<+6.2.2
       for i := edvX.YLE.SorceCount.arvoInt+1 to edLmaxKpl  do edvX.Sorc[i].Src.OnArvot :=  false; //<+8.0.0
       edvX.OnLaskettu := false;                            //<Koska ei PRC ALKUARVOIssa ###########

{1414f +:} {if isDeb  then begin
   edvX.Sorc[1].src.Iks1v.ArvoRea := 0.6;//16.456;
   edvX.Sorc[1].src.Iks3v.ArvoRea := 22.996;
   edvX.Sorc[1].src.pjLiitRs.ArvoRea := 5.111; //0.0111;  5.111 aiheuttaa herjan: "Annetulla eRs :n arvolla Ik1v ei toteudu..."
   end;}
{-$message Hint'1  P O I S T A  Pj-liittymäSIJOITUKSET.'}  {-$mess.. =Estää Hintin näkymästä.}
{-$message Hint'2  P O I S T A  Pj-liittymäSIJOITUKSET.'}
{-$message Hint'3  P O I S T A  Pj-liittymäSIJOITUKSET.'}
       edv :=  edvX;                                        //<AINA sijoitetaan luettu/alustettu EDV
       edvE := edvX;                                                //< Watch:  edv.Sorc[1].josa.Amm2
       edvf := edvX;                                        //<Luvussa MYÖS  -> EDVF
       srckayty := {a_getIntg (14, }edv.YLE.SorceCount.ArvoInt; //<Muualla VAIN SYOTTO.PAS / OKbtnClick  +8.0.0
       edikayty := {a_getIntg (14, }edv.YLE.JohtoOsia.ArvoInt;  //<'1414cU: ArvoInt.
       if (inFilen='') and LUE  then begin  //,EdvFilen,EdvF_Filen,Edv0_Filen := '' PaaVal.PAS :ssa
          Edv0_Filen := inFilen;                            //<AINA '', kun ALUST, OK ##############
          edv0 := edv;
       end;
    end;//if LUE
if edv.edka[1].Amm2.ArvoInt>0  then ;
if edv.Sorc[1].src.onArvot  then ;
if edv.Sorc[1].src.pjLiitRs.ArvoRea >0  then;
if EdvFilen >''  then ;
                         //,########################################################################
    EdvFilen := anFilen; //<Myös ks. FileLstN.PAS ##################################################
                         //'########################################################################
    if LUE  and onf  and FNC  or  NOT LUE   then //<Ei väliä jos LopTal ############################
       EdvF_Filen := inFilen;
    if NOT fnc
    then begin EdvFilen := '';                          //<,Tekee + tallettaa filen_Ev (="Olet-Ev.NOE")   +6.2.2
         fnc := true;                                   //<,Jos LueFA => LueTR, otaa listasta ekan nimen =EiOK.
         LueTalFilenReg ('LueT',1,LueFA,KysFA,EdvFilen);  end  //<Tekee oletFileNimen josTyhjäFileNimi, eiTalletListaan, Tallet Reg´iin.
    else
         Y_gLueTal_FileLista (14,1, LueFA,KysFA,EdvFilen); //<Tallettaa filenimen ##################
  9:
    Result := fnc;                  //,Vanhojen kenttien siirron uuteen tietorak:een onnistumisen tarkistamiseksi.
                    if NytKoeTul  then begin //Vain alkuluvussa, ks. edellä.
                       if inFilen=''  then TulRecorditKoe; //<Vanhojen kenttien siirron uuteen tietorak:een.
                       CloseFile (KoeFile);                //',inFilen='' = vain alkuLUKUkerralla.
                       CopyFile(PChar(KoeFilen), PChar(EdvFilen +'-TXT'),false);
            //         if inFilen=''  then LueTalEdvFile (LueFA,KysFa,{LUE,KYSY :boolean;} EdvFilen +'-aaa');
            //'Nyt kommentoitu vex, koska/ettei avaudu seur. ajoon automaattisesti ja tarvitsisi käsin valita ALP.
                    end;//NytKoeTul.     'Uuden tiedostorakenteen tiedoston kokeilu.  inFilen<>'' estää rekursion.
//¿DefsFileenZ('FileEv.INC/fLue_Talleta: anFilen=' +anFilen); //+120.3
YFileen('¿FileEv.INC 6');
  end;//fLue_Talleta

begin//LueTalEdvFile,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
//YFileen('¿FileEv.INC 0'); Nyt korvattu DebWr(-1, ...´llä.
DebWr(-1,'-1-','¿LueTalEdvFileALKU_0 '+DateTimeToStr(Now)); //+1414f;
 //DebWr(-1,'-1-','LueTalEdvFile' +DateTimeToStr(Now){+1415c}); //+1414fu
   LueTalEdvFile := fLue_Talleta;

  {Y_DemoFrm.Memo1.Text := 'Kokeilua';            //<,,Nämä kaikki aihauttavat Acces violation -errorin.
   Y_DemoFrm.ShowModal;
   ShowMessage('Tuleeko herjaa? /LueTalEdvFile');}

 //  if NOT Lue  then     //<KEHIvaiheessa ehto vex, mutta huolehdittava, että avattavassa filessä (esim. Olet-Ev.NOE) halutut rivit ovat mukana.
    {if IsDebuggerPresent  then
     CopyFile(PChar('C:\Projektit XE2\NolaKehi\BIN\Data\Olet-Ev 2s2j AlpTst sekaSij.NOE'), //<Testifile kopioidaan käyttöön.
              PChar('C:\Projektit XE2\NolaKehi\BIN\Data\Olet-Ev 2s2j.NOE'),false);}

   SortInif;           //<+141.1: Vasta nyt uudet lisättävät Key -rivit ja(oletus)arvot ovat FILESSÄ mukana.
YFileen('¿FileEv.INC 9');
end;//LueTalEdvFile

