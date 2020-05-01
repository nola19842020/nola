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

{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FileMo.INC}
{'INCLUUDATTU Moot.PAS :ssa #######################################################################}
function LueTalMoFile (LUE,KYSY :boolean;  inFilen :string) :boolean;  //<LUE:   TRUE =Lue   FALSE =Tall.
    var  fnc,edFnc :boolean;   tyh_Mor,alus_Mor :moRecRvType;   alus_Moy :moRecYlType;     moX :moYHTtype;
       {'FNC tarkkaillaan KOKO AJAN}    //koes :string;  kg :integer;         //<KG = glob. PRC Koe :n laskuri
  procedure koe(os :integer);   begin  {kg := os;                             //<Vika os talteen
    Y_Koe (0,'MoFile, OS: '+fImrkt0(os,1)+'  Fnc='+fBmrkt0(fnc,2));   }{+'  s='+koes);}  end;
  //................................................................................................
  procedure alkuarvot;      var i :integer;      begin
  with alus_Moy  do begin//,,,,,,,,Asettaa KAIKKIIN kenttin 0-arvot:  0, FALSE tai '' =arvotyypin muk.
    with Lahtoja    do begin tyhArvo (Lahtoja,'Lahtoja');//minkä jälk. asettaa NÄMÄ,,,,,,,,,,,,,,,,,,
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 1;
                         onAlar := true;  alarInt :=  0;    onYlar :=   true;   ylarInt := momax; end;
    with Kuvaus     do begin tyhArvo (Kuvaus,'Kuvaus');
                         onArvo := true;  arvoTyp := Strg;  arvoStr := '';                        end;
    with sulSft     do begin tyhArvo (sulSft,'SulSft');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0;     Rdsm := fSiTdsm (0,0);
                         onAlar := true;  alarRea := -50;   onYlar :=  true;  ylarRea := 50;      end;
    with Umo        do begin tyhArvo (Umo,'Umo');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 400;
                         onAlar := true;  alarInt := 100;   onYlar :=  true;   ylarInt :=  1000;  end;
    with Vrk        do begin tyhArvo (Vrk,'Verkkopiste');                                         //<,+6.0.3
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 0; //0 => 1 =7.0.5   1 => 0 =11.0.1
                         onAlar := true;  alarInt :=  0;    onYlar :=   true;   ylarInt := edmaxkpl; end;
  end;//with .._Moy                                 //'0 -> -5  =7.0.5  =>0 =11.0.1
  //.....................................................
  with alus_Mor  do begin
    with kw         do begin tyhArvo (kw,'kW');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 2.2;    Rdsm := fSiTdsm (1,3);
                         onAlar := true;  alarRea := 0.055; onYlar :=  true;   ylarRea := 1400;   end;
    with cos        do begin tyhArvo (cos,'cos');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.65;   Rdsm := fSiTdsm (1,3);
                         onAlar := true;  alarRea := 0.01;  onYlar :=  true;   ylarRea := 1;      end;
    with tim        do begin tyhArvo (tim,'tim');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.1;    Rdsm := fSiTdsm (1,3);
                         onAlar := true;  alarRea := 0.01;  onYlar :=  true;   ylarRea := 100;    end;
    with nap        do begin tyhArvo (nap,'nap');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 2;
                         onAlar := true;  alarInt := 2;     onYlar :=  true;   ylarInt := 12;     end;
    with rno        do begin tyhArvo (rno,'rno');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 1;
                         onAlar := true;  alarInt := 0;     onYlar :=  true;   ylarInt := 9;      end;
    with kpl        do begin tyhArvo (kpl,'kpl');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 1;
                         onAlar := true;  alarInt := 1;     onYlar :=  true;   ylarInt := 500;    end;
    with asT        do begin tyhArvo (asT,'AsTapa');
                         onArvo := true;  arvoTyp := Strg;  arvoStr := 'A';                       end;
    with korj       do begin tyhArvo (korj,'korj');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 1.0;    Rdsm := fSiTdsm (1,3);
                         onAlar := true;  alarRea := 0.01;  onYlar :=  true;   ylarRea := 10;     end;
    with suT        do begin tyhArvo (suT,'SulTyp');        //<Tarkistetaan Moot.INC/PRC pvRivi  +4.0.0u   
                         onArvo := true;  arvoTyp := Strg;  arvoStr := su_OFAg;                   end;
    with Lmo        do begin tyhArvo (Lmo,'Lmo');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0;      Rdsm := fSiTdsm (1,2);
                         onAlar := true;  alarRea := 0;     onYlar :=  true;   ylarRea := 10000;  end;
  end;//with alus_Mo
  //.....................................................Nämä sijoitukset jättää muut ennalleen, kun
  tyh_Mor := alus_Mor;                                 //ekax sijoitettu alus_Mor alle #############
  with tyh_Mor  do begin                               //'Pakko, muuten muut kentät jää EPÄMÄÄRÄIS.
    kw    .onArvo := false;                            //''''''''''''''''TODETTU''''''''''''''''''''
    cos   .onArvo := false;
    tim   .onArvo := false;
    nap   .onArvo := false;
    rno   .onArvo := false;
    kpl   .onArvo := false;
    asT   .onArvo := false;
    korj  .onArvo := false;
    suT   .onArvo := false;
    Lmo   .onArvo := false;
  end;//with tyh_Mo
  //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  moX.moty := alus_Moy;           //<Sisälsi oletusasetukset yleiselle tieto-osalle
  moX.motr[1] := alus_Mor;        //<Sisälsi oletusasetukset YHDELLE(=ekalle) johto-osalle
  moX.motr[1].onArvot := true;    //<PAKKO, muuten ei editoidu;  Muutos: Nyt lisätty LAHTOJA =HOITAA
  for i := 2 to momax  do moX.motr[i] := tyh_Mor;     //'NYT Tutkit + sij. (myös) jäljempnä'''''''''
  end;//alkuarvot'''''''''''''//'Muuttaa vain ONARVO := FALSE; ja jättää muut kentät[1]:n mukaisiksi
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
  procedure LueTalFile (alue :integer);      var i,j :integer;  sa :string;//<sa=koe
    procedure LueTal (os :integer;  alueS :string;  VAR alkio :arvoTyyp);      begin
      if fnc  then                                   //DES:llä merkitystä '''vain REAL-TALLETUKSESSA
      if LUE  then fnc := LueInifAlkio   (MoFile, alueS,alkio)      //<ALKIO palautuu kutsuun ######
              else fnc := TalInifAlkio (4,MoFile, alueS,alkio);     //<Tässä ALKIO ei muutu ########
      if fnc  then koe(os);         //<############### Vika KOE OKluku/kirj.rivi NÄKYVIIN ##########
    end;//LueTal
  begin//LueTalFile,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    if LUE  then fnc := LueTalInifVersio (4,TRUE, MoFile)
            else fnc := LueTalInifVersio (4,FALSE,MoFile);
    if fnc  then
    case alue of                      //,,DESimaalien lukumäärä. Merkitystä vain REAL-luvuilla #####
      1 :with moX.moty  do begin      //,,Ei kovin nuukaa REAL-luvuillakaan, kunhan riittävästi#####
              LueTal (1, MO_Yle, lahtoja);
              LueTal (2, MO_Yle, kuvaus );
              LueTal (3, MO_Yle, sulSft );
               edFnc := fnc;
              LueTal (4, MO_Yle, Umo    );
              if LUE and NOT fnc and edFnc  then begin      //<edFnc =Oli OK ennen kutsua <<<<<<<<<<
                 a_putIntg (1, 400,Umo);
                 fnc := true;  end;
               edFnc := fnc;
              LueTal (5, MO_Yle, Vrk    );
              if Vrk.arvoInt<0  then Vrk.arvoInt := 0;      //<+11.0.1:  Vanhojen tiedostojen luvussa joskus -1.
              if LUE and NOT fnc and edFnc  then begin      //<edFnc =Oli OK ennen kutsua <<<<<<<<<<
             {if LUE and NOT fnc and edFnc  or              //<, +7.0.5          <,,-11.0.1
                                    (a_getIntg (1,Vrk) = 0)  then begin //<edFnc =Oli OK ennen kutsua <<<<<<<<<<<<
                 a_putIntg (1, 1,Vrk);                      //<  0 -> 1  +7.0.5  <''-11.0.1}
                 a_putIntg (1, 0,Vrk);                      //<  1 => 0    takaisin +11.0.1
                 fnc := true;  end;
         end;
      2 :for i := 1 to a_getIntg( 12,moX.moty.Lahtoja)  do
         with moX.motr[i]  do begin
              LueTal (10*i+1, MO_Rv+fImrkt0 (i,1), kw  );
              LueTal (10*i+2, MO_Rv+fImrkt0 (i,1), cos );
              LueTal (10*i+3, MO_Rv+fImrkt0 (i,1), tim );
              LueTal (10*i+4, MO_Rv+fImrkt0 (i,1), nap );
              LueTal (10*i+5, MO_Rv+fImrkt0 (i,1), rno );
              LueTal (10*i+6, MO_Rv+fImrkt0 (i,1), kpl );
              LueTal (10*i+7, MO_Rv+fImrkt0 (i,1), asT );
              LueTal (10*i+8, MO_Rv+fImrkt0 (i,1), korj);
                 edFnc := fnc;
              LueTal (10*i+9, MO_Rv+fImrkt0 (i,1), suT );
                {F=su_OFAg M=su_OFAm   I=su_IECg su_IECgAR su_IECgYR   Z=su_IECd su_IECdAR su_IECdYR}
                 sa := suT.arvoStr;
                 if fSu_Sama (sa,'G')  then sa := 'F'; //<OFAA oli alunperin 'G', nyt 'F' ##########
                 sa := fSu_Str (sa);
                 a_putStrg (1, sa,suT);                     //<Siirretään joka tapauksessa rec:iin
              if LUE and NOT fnc and edFnc  then
                 fnc := true;

                 edFnc := fnc;
              LueTal (10*i+10, MO_Rv+fImrkt0 (i,1), Lmo);
              if LUE and NOT fnc and edFnc  then begin
                 a_putReaa (2, 0,Lmo);
                 fnc := true;  end;                 //<Muuten OKtietueet ei olisi käytettävissä <<<<

              if LUE  then
              if fnc                //,#############################################################
              then OnArvot := true  //<################## Tätä ei oltu talletettu ##################
              else begin                          //<motr[i] eiOK, joten tyhjätään se + seuraavat
                 with moX  do                     //,,Muuttaa vain ONARVO := FALSE; ja jättää muut
                   for j := i to momax  do motr[j] := tyh_Mor;
                 j := i-1;                        //'kentät ALUST :n mukaisiksi'''''''''''''''''''''
                 a_putIntg (3, j,moX.moty.Lahtoja); //<Korjataan oikeaksi todettua vastaavaksi #####
                 fnc := true;                       //<Muuten OKtietueet ei olisi käytettävissä <<<<
                 Break;   //<#######################################################################
              end;
         end;//with
     end;//case
  end;//LueTalFile

{  procedure Valivii;      VAR LstU :TStringList;  sa :string;  i,u :integer;   begin
                          //,,+1415f: Lisätään välirivi ennen seur Sec -rviä.-----------------------
    LstU := TStringList.Create;                       //<,,+1415f: Jotta saadaan väliviivat "-----..." ennen seur väliOtsikkoa (Section).
    LstU.LoadFromFile(MoFilen);
    u := LstU.Count-1;  i := u-1;                     //<Aloitetaan tokaVikalta riviltä jos vaikka vikalla olisi "[" alkuinen (Section -nimi).
    while (i>0)  do begin
       if (i>0) and (LstU[i+1]<>'')  then begin       //<Aloitetaan lopusta, koska väliin kasvatetaan väliMrkRvjä.
          sa := Trim(LstU[i+1]);                          //,Ettei tulisi 2 välirviä perääkäin, todettu.
          if (sa[1]='[') and (Pos('´´´', LstU[i])=0) then //,Eli [ Section -nimiRvn kohdalle ja Sec. siirtyy seur´ksi.
             LstU.Insert(i+1,'´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´'); //<Lisätää välirivi Sectionin loppuun =ennen  seur. Sec´n alkua.
       end;
       i := i-1;
    end;
    LstU.SaveToFile(MoFilen);                         //<''+1415f.
    LstU.Free;
  end;//Valivii}
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  function Lue_Talleta :boolean;      LABEL 1,3{1415f},9;   VAR onf :boolean;  anFilen :string;  i,u :integer;      begin
1:  anFilen := inFilen;                      //<inFilen säilytet. ALKUPERÄISENÄ LOPPURIVLLE ASTI ###
    fnc := false;

    if Y_gLueTal_FileLista (31,3, LUE,KYSY,anFilen) < 0  then GOTO 9; //<Ensiajossa tekee OLETUSNIMEN #### 1414: Oli 4(OHA) => 3.
                                             //' -1 =Cancel.  JOS LueFA -> FILEnimen TALLETUS ######
    if LUE  then alkuarvot;                            //<Asettaa alkuoletukset ####################
    fnc := true;   //<GLOBAALI FNC:ssa #############################################################
    onf := true;                                       //'JÄÄVÄT VOIMAAN JOS EIOO vielä tiedostoa ##
    if LUE  then onf := fFileExists(anFilen);
                   //,,,LUKU tai KÄYTTÄJÄN t. LoppuTALLETUS ########################################
   {if (LUE and onf  or  NOT LUE)                            //<IF onf -testi riittäisi, nyt ei ehtoja...
    then begin//1415f //try }                                //,Näissä luetaan kaikki alkiot ehdol-
       MoFile := TInifile.Create (anFilen);                  //'lisesti:  if FNC  then LUEF();  Jos
       if NOT LUE  then moX := mo;                           //<Kopioitava,jotta olisi TALLETETTAVAA
       u := 0;  if LUE  then u := 1;                         //<Alp LUE talteen
3:                                  //<1415f: Tähän takas hyppy jos LueTalFile´istä FNC=FA =Luvussa virhe =ehkä tiedot vajaita tai puuttuu tai muu virhe,
                                    //        eli mennään kirjoittamaan file fyysisesti tiedostoksi vaikka alla olisi vajaa, tämä päälle.
                    LueTalFile (1);         //< mo.moty      //'mo.motr[n]=eiOK, vikaksi jää motr[n-1]
       if fnc  then LueTalFile (2)          //< mo.motr[]
               else alkuarvot;              //<Muuten tulee arvoTyyppin LUKUvirheitä, TODETTU ######}
          if u=1  then begin
             u := 2;  LUE := false;         //<Jotta LueTalFile´issä tallettaisi.
             GOTO 3;  end;
       LUE := u>0;                          //<''+1415f.

       if NOT LUE                                            //<Ed.versiossa 1.0.3 on vielä. Takas +3.0.0
          then mof := mo;                                    //<Talletssa mo -> MoF
       MoFile.Free;
     //u := 0;  if LUE  then u := 1;                         //<+1415f: Alp LUE talteen: u=0=FA.

{   except                      //<,Varsinainen käsittely (=HERJA) Lue/talInif../Y_ :ssä ###########
       on E :Exception  do begin
          fnc := false;
       end;//on
    end;{except}
//------------------------------------------------------------------------------------''1415f.

    if LUE  then begin
       if NOT fnc  and KYSY  then begin
          EiOkInfo ('Tiedosto virheellinen, valitse uudelleen!');
          GOTO 1;  end;
       motja := a_getIntg (0,moX.moty.lahtoja);              //<Myös: Moot.PAS
       Mrv := motja;   eMrv := Mrv;
       
       for i := motja+1 to momax  do moX.motr[i].OnArvot := false;
       mo := moX;                                            //<AINA sijoitetaan luettu/alustettu mo
       mof := moX;                                           //<AINA LUVUSSA myös -> MoF
       if (inFilen='') and LUE  then begin                   //<Ekalla kerralla alkutilanne NJ0 :aan
          Mo0_Filen := anFilen;//inFilen;                    //< 4.0.0  anFilen. Mo0_ =IstunnonAlussa
          mo0 := mo;                                         //'####################################'
//        moU := mo;                                         //< +4.0.0u
       end;
    end;
                         //,########################################################################
    MoFilen := anFilen;  //<AINOA PAIKKA, MISSÄ MoFilen SAA ARVON ##################################
                         //'########################################################################
    if LUE  and onf  and FNC  or  not LUE   then //<Ei väliä jos LopTal ############################
       MoF_Filen := MoFilen;//inFilen;                       //< 4.0.0  MoFilen. MoF_ =FilestäLuettu
    Y_gLueTal_FileLista (32,3, LueFA,KysFA,MoFilen); //<Tallettaa filenimen ######################## 1414: OHA oli 4 => 3.
    Valivii (MoFilen);                               //<+1415f: VäliviivaRv ennen seurSection -nimeä.
  9:
    Result := fnc;                  {MoFrm.ChkDet.Caption := '';{eriMo=' +fBmrkt0(eriMo ,2) +'eriMo0=' +
                                                    fBmrkt0(eriMo0,2) +'eriMoU=' +fBmrkt0(eriMoU,2);}
  end;//Lue_Talleta
begin//LueTalMoFile,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  LueTalMoFile := Lue_Talleta;
end;//LueTalMoFile
{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FileMo.INC}

