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

{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FileNj.INC}
{'INCLUUDATTU NjVrk.PAS :ssa ######################################################################}
function LueTalNjFile (LUE,KYSY :boolean;  inFilen :string) :boolean;  //<LUE:   TRUE =Lue   FALSE =Tall.
    var  alus_Hav :NjHavTied;  alus_JY :NJylTiedot;  alus_JK :NJjkTiedot;  njX :jkYHTtype;
         fnc,edFnc :boolean;                          //<<FNC tarkkaillaan KOKO AJAN, edFNC=Ed.alkion LUVUSTA
        //koes :string;  kg :integer;                 //<KG = glob. PRC Koe :n laskuri
  procedure koe(os :integer);   begin  {kg := os;     //<Vika os talteen
            Y_Koe (0,'NjFile, OS: '+fImrkt0(os,1)+'  Fnc='+fBmrkt0(fnc,2));   }{+'  s='+koes);}  end;
  procedure alkuarvot;      var i :integer;      begin
    LueTarif;                                    //<######## Sijoittaa HavTarif :iin arvot #########
                                                 // ######## ja k‰ytt‰‰ niit‰ ,,,,,olet:na #########
  with alus_Hav  do begin//,,,,,,,,Asettaa KAIKKIIN kenttin OLET-arvot,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    with Tpit       do begin tyhArvo (Tpit,'Pitoaika');     //mink‰ j‰lk. asettaa NƒMƒ,,,,,,,,,,,,,,
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := HavTarif.Tpit.arvoRea;   Rdsm := fSiTdsm (100,1);
                         onAlar := true;  alarRea := 0.1;   onYlar :=  true;  ylarRea := 1000;  end;
    with Korko      do begin tyhArvo (Korko,'Korko');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := HavTarif.Korko.arvoRea;  Rdsm := fSiTdsm (100,2);
                         onAlar := true;  alarRea := 0;     onYlar :=  true;  ylarRea := 100;   end;
    with Hprs       do begin tyhArvo (Hprs,'Huolto%inv');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := HavTarif.Hprs.arvoRea;   Rdsm := fSiTdsm (100,2);
                         onAlar := true;  alarRea := 0;     onYlar :=  true;  ylarRea := 1000;  end;
    with Tph        do begin tyhArvo (Tph,'HuipunKA');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := HavTarif.Tph.arvoRea;    Rdsm := fSiTdsm (0,0);
                         onAlar := true;  alarRea := 1;     onYlar :=  true;  ylarRea := 8760;  end;//< Max/a
    with YOprs      do begin tyhArvo (YOprs,'YO-osuus%');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := HavTarif.YOprs.arvoRea;  Rdsm := fSiTdsm (100,2);
                         onAlar := true;  alarRea := 0;     onYlar :=  true;  ylarRea := 100;   end;
    with Ktyh       do begin tyhArvo (Ktyh,'Tyhjakaynti');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := HavTarif.Ktyh.arvoRea;   Rdsm := fSiTdsm (100,2);
                         onAlar := true;  alarRea := 0.01;  onYlar :=  true;  ylarRea := 1;     end;
    with dPprs      do begin tyhArvo (dPprs,'Ph_kasvu%');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := HavTarif.dPprs.arvoRea;  Rdsm := fSiTdsm (100,2);
                         onAlar := true;  alarRea := 0;     onYlar :=  true;  ylarRea := 100;   end;
    with dWmkprs    do begin tyhArvo (dWmkprs,'Wmk_kasvu%');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := HavTarif.dWmkprs.arvoRea; Rdsm := fSiTdsm (100,2);
                         onAlar := true;  alarRea := 0;     onYlar :=  true;  ylarRea := 100;   end;
    with PVpen      do begin tyhArvo (PVpen,'PVhinta');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := HavTarif.PVpen.arvoRea;  Rdsm := fSiTdsm (100,2);
                         onAlar := true;  alarRea := 0.1;   onYlar :=  true;  ylarRea := 1000;  end;
    with YOpen       do begin tyhArvo (YOpen,'YOhinta');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := HavTarif.YOpen.arvoRea;  Rdsm := fSiTdsm (100,2);
                         onAlar := true;  alarRea := 0.1;   onYlar :=  true;  ylarRea := 1000;  end;
    with Pmk       do begin tyhArvo (Pmk,'Tehomaksu');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := HavTarif.Pmk.arvoRea;    Rdsm := fSiTdsm (100,2);
                         onAlar := true;  alarRea := 0;     onYlar :=  true;  ylarRea := 10000; end;
  end;//with alus_Hav
  //.....................................................
  with alus_JY  do begin//,,,,,,,,Asettaa KAIKKIIN kenttin 0-arvot:  0, FALSE tai '' =kent‰n muk.
    with UhRaja     do begin tyhArvo (UhRaja,'UhRaja');                                               //<,+3.0.3
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 2.5;    Rdsm := fSiTdsm (1,3); //<Lasketaan
                         onAlar := true;  alarRea := 0.01;  onYlar := true;    ylarRea := 50;     end;
    with Ketjussa   do begin tyhArvo (Ketjussa,'Ketjussa');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 1;
                         onAlar := true;  alarInt :=  0;    onYlar :=   true;   ylarInt := kesmax; end;
    with NjKulSal   do begin tyhArvo (NjKulSal,'NjKulSal');
                         onArvo := true;  arvoTyp := Bool;  arvoBoo := true;                      end;
    with AsTapa     do begin tyhArvo (AsTapa,'AsTapa');
                         onArvo := true;  arvoTyp := Strg;  arvoStr := 'A';                       end;
    with Tasaus     do begin tyhArvo (Tasaus,'Tasaus');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 1;      Rdsm := fSiTdsm (1,2);
                         onAlar := true;  alarRea := 0.1;   onYlar :=   true;  ylarRea := 1;      end;
    with Korjaus    do begin tyhArvo (Korjaus,'Korjaus');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 1;      Rdsm := fSiTdsm (1,2);
                         onAlar := true;  alarRea := 0.01;  onYlar :=  true;   ylarRea := 10;     end;
    with Kasvuv     do begin tyhArvo (Kasvuv,'Kasvuv');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 10;     Rdsm := fSiTdsm (10,2);
                         onAlar := true;  alarRea := 0;                                           end;
    with Tk1v       do begin tyhArvo (Tk1v,'Tk1v');
                         onArvo := true;  arvoTyp := Intg;  arvoInt := 80;
                         onAlar := true;  alarInt := 0;     onYlar :=  true;   ylarInt := 300;    end;
  end;//with alus_JY
  //.....................................................
  with alus_JK  do begin
    with Tunnus     do begin tyhArvo (Tunnus,'Tunnus');
                         onArvo := true;  arvoTyp := Strg;  arvoStr := 'NK-A1.3.31';               end;
    with Huom       do begin tyhArvo (Huom,'Huom');
                         onArvo := true;  arvoTyp := Strg;  arvoStr := 'Ekasta keskuksesta ALAkerran l‰hdˆt.'; end;
    with dL         do begin tyhArvo (dL,'dL');                                              //,100->1000 +6.2.21
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 123.5; Rdsm := fSiTdsm (1000,1);
                         onAlar := true;  alarRea := 0;     onYlar :=  true;  ylarRea := 99999;   end;
    with Ps         do begin tyhArvo (Ps,'Ps');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 23.6;  Rdsm := fSiTdsm (1,4);
                         onAlar := true;  alarRea := 0.01;  onYlar :=  true;  ylarRea := 9999;    end;
//,,N‰m‰ lasketaan
    with Qs         do begin tyhArvo (Qs,'Qs');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0;     Rdsm := fSiTdsm (1,4);
                         onAlar := true;  alarRea := 0.01;  onYlar :=  true;  ylarRea := 9999;    end;
    Ss :=  Qs;
    Iss := Qs;
    with Ss         do begin tyhArvo (Ss,'Ss');                                                   end;
    with Iss        do begin tyhArvo (Iss,'Iss');                             ylarRea := 99999;   end;
//''N‰m‰ lasketaan
    with Coss       do begin tyhArvo (Coss,'Coss');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.6;   Rdsm := fSiTdsm (1,2);
                         onAlar := true;  alarRea := 0.01;  onYlar :=  true;  ylarRea := 1;       end;
    with palV       do begin tyhArvo (palV,'palV');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 65;    Rdsm := fSiTdsm (0,0);
                         onAlar := true;  alarRea := 0;     onYlar :=  true;  ylarRea := 9999;    end;
    with cosV       do begin tyhArvo (cosV,'cosV');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 0.65;  Rdsm := fSiTdsm (1,2);
                         onAlar := true;  alarRea := 0;     onYlar :=  true;  ylarRea := 1;       end;
    with ala        do begin tyhArvo (ala,'ala');
                         onArvo := true;  arvoTyp := Reaa;  arvoRea := 1234.5;  Rdsm := fSiTdsm (0,0);
                         onAlar := true;  alarRea := 0;     onYlar :=  true;  ylarRea := 99999;   end;
    with PTlop      do begin tyhArvo (PTlop,'PTlop');
                         onArvo := true;  arvoTyp := Bool;  arvoBoo := false;                     end;
  end;//with alus_JK
  //.....................................................N‰m‰ sijoitukset j‰tt‰‰ muut ennalleen, kun
  with tyh_JK  do begin                                //ekax sijoitettu alus_NjJK alle ############
    tyh_JK := alus_JK;                                 //<Pakko, muuten muut kent‰t j‰‰ EPƒMƒƒRƒIS.
    Tunnus.onArvo := false;                            //''''''''''''''''TODETTU''''''''''''''''''''
    Huom  .onArvo := false;
    dL    .onArvo := false;
    Ps    .onArvo := false;
    Qs    .onArvo := false; //<Lasketaan
    Ss    .onArvo := false; //<Lasketaan
    Iss   .onArvo := false; //<Lasketaan
    Coss  .onArvo := false;
    palV  .onArvo := false;
    cosV  .onArvo := false;
    ala   .onArvo := false;
    PTlop .onArvo := false;
  end;//with tyh_JK
  //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  njX.Hav :=   alus_Hav;
  njX.jy :=    alus_JY;     //<Sis‰lsi oletusasetukset yhdelle johto-osalle
  njX.jk[1] := alus_JK;     //<Sis‰lsi oletusasetukset = yksi johto-osa
  with njX  do              //<,,Muuttaa vain ONARVO := FALSE; ja j‰tt‰‰ muut kent‰t[1]:n mukaisiksi
    for i := 2 to kesmax  do jk[i] := tyh_JK;
  end;//alkuarvot'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

{ procedure alustaNj (alkaen :integer);      var i :integer;      begin
    if alkaen = 0  then begin                 //<Eka kutsu #########################################
       njX.jy := alus_JY;
       njX.jk[1] := alus_JK;  end;
    with njX  do begin      //<,,Muuttaa vain ONARVO := FALSE; ja j‰tt‰‰ muut kent‰t[1]:n mukaisiksi
      if alkaen=0  then alkaen := 1;
      for i := alkaen to kesmax  do begin
        jk[i] := alus_JK;  jk[i] := tyh_JK;  end; end;//with
  end;//alustaNj'''}
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
  procedure LueTalFile (alue :integer);      var i,j :integer;
    //........................................................
    procedure LueTal (os :integer;  alueS :string;  VAR alkio :arvoTyyp);      begin
      if fnc  then                                   //DES:ll‰ merkityst‰ '''vain REAL-TALLETUKSESSA
      if LUE  then fnc := LueInifAlkio (NjFile, alueS,alkio)        //<ALKIO palautuu kutsuun ######
              else fnc := TalInifAlkio (2,NjFile, alueS,alkio);     //<T‰ss‰ ALKIO ei muutu ########
      if fnc  then koe(os);         //<############### Vika KOE OKluku/kirj.rivi NƒKYVIIN ##########
    end;//LueTal
  begin//LueTalFile,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    if LUE  then fnc := LueTalInifVersio (2,TRUE, NjFile)
            else fnc := LueTalInifVersio (2,FALSE,NjFile);
    if fnc  then
    case alue of                      //,,DESimaalien lukum‰‰r‰. Merkityst‰ vain REAL-luvuilla #####
      1 :with njX.Hav  do begin       //,,Ei kovin nuukaa REAL-luvuillakaan, kunhan riitt‰v‰sti#####
              edFnc := fnc;
              LueTal (1,  NJ_HAV, Tpit   );  fnc := edFnc;
              LueTal (2,  NJ_HAV, Korko  );  fnc := edFnc;
              LueTal (3,  NJ_HAV, Hprs   );  fnc := edFnc;
              LueTal (4,  NJ_HAV, Tph    );  fnc := edFnc;
              LueTal (5,  NJ_HAV, YOprs  );  fnc := edFnc;
              LueTal (6,  NJ_HAV, Ktyh   );  fnc := edFnc;
              LueTal (7,  NJ_HAV, dPprs  );  fnc := edFnc;
              LueTal (8,  NJ_HAV, dWmkprs);  fnc := edFnc;
              LueTal (9,  NJ_HAV, PVpen  );  fnc := edFnc;
              LueTal (10, NJ_HAV, YOpen  );  fnc := edFnc;
              LueTal (11, NJ_HAV, Pmk    );  fnc := edFnc;  end;
      2 :with njX.JY  do begin
              LueTal (21, NJ_JY, UhRaja);    
              if LUE  and  NOT fnc  then begin //< +4.0.0  NOT (fnc)
                 a_putReaa (1, 4.0, UhRaja);   //<3.0.3 :een lis‰tty‰ arvoa eioo, sijoitetaan
                 fnc := true;  end;            //< ja korjataan FNC.
              LueTal (22, NJ_JY, Ketjussa);
              LueTal (23, NJ_JY, NjKulSal);
              LueTal (24, NJ_JY, AsTapa  );
              LueTal (25, NJ_JY, Tasaus  );
              LueTal (26, NJ_JY, Korjaus );
              LueTal (27, NJ_JY, Kasvuv  );
              LueTal (28, NJ_JY, Tk1v    );  end;
      3 :for i := 1 to a_getIntg( 12,njX.jy.Ketjussa)  do
         with njX.jk[i]  do begin
              LueTal (30*i+1, NJ_JK+fImrkt0 (i,1), Tunnus);
              LueTal (30*i+2, NJ_JK+fImrkt0 (i,1), Huom  );
              LueTal (30*i+3, NJ_JK+fImrkt0 (i,1), dL    );
              LueTal (30*i+4, NJ_JK+fImrkt0 (i,1), Ps    );
              LueTal (30*i+5, NJ_JK+fImrkt0 (i,1), Coss  );
              LueTal (30*i+6, NJ_JK+fImrkt0 (i,1), palV  );
              LueTal (30*i+7, NJ_JK+fImrkt0 (i,1), cosV  );
              LueTal (30*i+8, NJ_JK+fImrkt0 (i,1), ala   );
              j := 0;
              if LUE  then if fnc  then j := 1              //<Lis‰tyn kent‰n PTLOP :n tarkistukseen
                                   else j := 2;
              LueTal (30*i+9, NJ_JK+fImrkt0 (i,1), PTlop );
              if (j=1)  and NOT fnc  then begin             //< +4.0.0  +NOT Fnc
                 fnc := true;                               //<Luettaessa vanhaa tiedstoa, PTLOP eiOllut.
                 a_putBool (1, FALSE,PTlop);                //< = Korjattiin:  EiPTlop (= PTlop := FA)
              end;
              if LUE  then
              if fnc                //,#############################################################
              then OnArvot := true  //<################## T‰t‰ ei oltu talletettu ##################
              else begin                          //<jk[i] eiOK, joten tyhj‰t‰‰n se + seuraavat
                 with njX  do                     //,,Muuttaa vain ONARVO := FALSE; ja j‰tt‰‰ muut
                   for j := i to kesmax  do jk[j] := tyh_JK;
                 j := i-1;                        //'kent‰t ALUST :n mukaisiksi
                 a_putIntg (1, j,njX.jy.Ketjussa);  //<Korjataan oikeaksi todettua vastaavaksi #####
                {if j>0  then }fnc := true;         //<Muuten OKtietueet ei olisi k‰ytett‰viss‰
                 Break;   //<#######################################################################
              end;
         end;//with
    end;//case alue
  end;//LueTalFile
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  function Lue_Talleta :boolean;      LABEL 1,3{1415f},9;   VAR onf :boolean;  anFilen :string;  i,u :integer;      begin
  1:
 //øDefsFileenZ('FileNj.INC/LueTal 1: ÆÆÆÆÆ AnFilen: ' +AnFilen);
   anFilen := inFilen;                      //<inFilen s‰ilytet. ALKUPERƒISENƒ LOPPURIVLLE ASTI ###
    fnc := false;

    if Y_gLueTal_FileLista (21,2, LUE,KYSY,anFilen) < 0  then GOTO 9; //<Ensiajossa tekee OLETUSNIMEN ####
                                             //' -1 =Cancel.  JOS LueFA -> FILEnimen TALLETUS ######
    if LUE  then alkuarvot;                            //<Asettaa alkuoletukset ####################
    fnc := true;   //<GLOBAALI FNC:ssa #############################################################
    onf := true;                                       //'JƒƒVƒT VOIMAAN JOS EIOO viel‰ tiedostoa ##
    if LUE  then onf := fFileExists(anFilen);
                   //,,,LUKU tai KƒYTTƒJƒN t. LoppuTALLETUS ########################################
    u := 0;
    if (LUE {and onf  }or  NOT LUE)                             //<IF onf -testi riitt‰isi, nyt ei ehtoja...
    then begin//1415f //try                                     //,N‰iss‰ luetaan kaikki alkiot ehdol-
//øDefsFileenZ('FileNj.INC/LueTal 2: ÆÆÆÆÆ AnFilen: ' +AnFilen); //'lisesti:  if FNC  then LUEF();  Jos
       NjFile := TInifile.Create (anFilen);
       if NOT LUE  then njX := nj;          //<Kopioitava,jotta olisi TALLETETTAVAA
       u := 0;  if LUE  then u := 1;        //<,,+1415f: Alp LUE talteen: u=0=FA.
3:                                  //<1415f: T‰h‰n takas hyppy jos LueTalFile¥ist‰ FNC=FA =Luvussa virhe =ehk‰ tiedot vajaita tai puuttuu tai muu virhe,
                                    //        eli menn‰‰n kirjoittamaan file fyysisesti tiedostoksi vaikka alla olisi vajaa, t‰m‰ p‰‰lle.
                    LueTalFile (1);         //< NJ.Hav       His TarifFile eiOK, sij kuitenkin OK => FNC := TR
       fnc := true; LueTalFile (2);         //< NJ.YLE       JK[n]=eiOK, vikaksi j‰‰ JK[n-1]
       if fnc  then LueTalFile (3)          //< NJ.JKa[]
               else alkuarvot;              //<Muuten tulee arvoTyyppin LUKUvirheit‰, TODETTU ######
          if u=1  then begin
             u := 2;  LUE := false;         //<Jotta LueTalFile¥iss‰ tallettaisi.
             GOTO 3;  end;
        end;
        LUE := u>0;                         //<''+1415f.
//øDefsFileenZ('FileNj.INC/LueTal 3: ÆÆÆÆÆ AnFilen: ' +AnFilen);
       if NOT LUE                                            //<Ed.versiossa 1.0.3 on viel‰. Takas +3.0.0
          then njf := nj;                                    //<Talletssa NJ -> NJF
     //if LUE  then u := 1;                                  //<,,+1415f: Alp LUE talteen: u=0=FA. ..Never used.
       NjFile.Free;
{   except                      //<,Varsinainen k‰sittely (=HERJA) Lue/talInif../Y_ :ss‰ ###########
       on E :Exception  do begin
          fnc := false;
//øDefsFileenZ('FileNj.INC/LueTal 4 Except: ÆÆÆÆÆ AnFilen: ' +AnFilen);
       end;//on
    end;{except}
//------------------------------------------------------------------------------------''1415f.

    if LUE  then begin
       if NOT fnc  and KYSY  then begin
          EiOkInfo ('Tiedosto "<b>' +anFilen{+120.5i} +'</b>" onvirheellinen, valitse uudelleen!');
          GOTO 1;  end;
       kesja := a_getIntg (0,njX.jy.ketjussa);               //<Myˆs: 38.INC/Ketjuteho

       for i := kesja+1 to kesmax  do njX.jk[i].OnArvot := false;
       nj := njX;                                            //<AINA sijoitetaan luettu/alustettu NJ
       njf := njX;                                           //<AINA LUVUSSA myˆs -> NJF
       if (inFilen='') and LUE  then begin                   //<Ekalla kerralla alkutilanne NJ0 :aan
          Nj0_Filen := anFilen;//inFilen;                    //< 4.0.0  anFilen. Nj0_ =IstunnonAlussa
          Nj0 := nj;
       end;
    end;
                         //,########################################################################
    NjFilen := anFilen;  //<AINOA PAIKKA, MISSƒ NjFilen SAA ARVON ##################################
                         //'########################################################################
    if LUE  and onf  and FNC  or  not LUE   then //<Ei v‰li‰ jos LopTal ############################
       NjF_Filen := NjFilen;//inFilen;                       //< 4.0.0  NjFilen. NjF_ =Filest‰Luettu
    Y_gLueTal_FileLista (22,2, LueFA,KysFA,NjFilen); //<Tallettaa filenimen #########################
    Valivii (NjFilen);                               //<+1415f: V‰liviivaRv ennen seurSection -nime‰.
  9:
    Result := fnc;
  end;//Lue_Talleta
begin//LueTalNjFile,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  LueTalNjFile := Lue_Talleta;
end;//LueTalNjFile
{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FileNj.INC}

