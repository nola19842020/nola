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

{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Avuste2.INC}
procedure Avu_4_Nj;     begin
case eRv of //,,,,,,,,, Nj :n StrGr :n + Boxit ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
           //, -1 on annettu <?> -napin painalluksessa kutsuun tätä varten <<<<<<<<<<<<<<<<<<<<<<<<<
  //0 :si( '<b>OTSIKKORIVI</b> :   Sarakkeiden käyttötarkoituksen mukaiset nimet. ');
    0 :si( '<b>RiviN:o</b>');
   -1 :begin
       if demoLisAs  and  NOT OliJoInfo_Nj  then stG := CLR_REB +'Tämä esittelyversion avusteikkuna on '+
                                      'lukkiutunut n. 6 s tai kunnes klikkaat jotain kohdetta.'+FNT_B0 +'<br>';
       OliJoInfo_Nj := true;
       si (GetMyB (BASE_Avu_4_Nj_01) +
           myRegSettings.GetStringValue(SETTINGS_USED, KAAPELIHINTA_FILE_ID) +'</b> ja <b>tariffi/'+
           'häviö(oletus)kustannustiedot<br>..\' +
           myRegSettings.GetStringValue(SETTINGS_USED, TARIFFIHINTA_FILE_ID) +', </b>joita voidaan muokata '+
           'ASCII -editorilla (esim. NotePad) oman kustannustietämyksen mukaiseksi. Tiedot muokkausta varten '+
           'löytyvät em. tiedostoista.');  end;
    1 :sS (GetMyB (BASE_Avu_4_Nj_e1));
    2 :sS (GetMyB (BASE_Avu_4_Nj_e2));
    3 :sS (GetMyB (BASE_Avu_4_Nj_e3));
    4 :sS (GetMyB (BASE_Avu_4_Nj_e4));
    5 :sS (GetMyB (BASE_Avu_4_Nj_e5));
    6 :sS (GetMyB (BASE_Avu_4_Nj_e6));
    7 :sS (GetMyB (BASE_Avu_4_Nj_e7));
    8 :sS (GetMyB (BASE_Avu_4_Nj_e8));
    9 :sS (GetMyB (BASE_Avu_4_Nj_e9));
   10 :sS (GetMyB (BASE_Avu_4_Nj_e10));
   11 :sS (GetMyB (BASE_Avu_4_Nj_e11));
   20 :si( '');       //<Käytetään avusteFrm:n tyhjentämiseen koska Clear tai ...Lines[0] := '' eiOK
   21 :si (GetMyB (BASE_Avu_4_Nj_e21));
   22 :si (GetMyB (BASE_Avu_4_Nj_e22));
   31 :si (GetMyB (BASE_Avu_4_Nj_e31));
   32 :si (GetMyB (BASE_Avu_4_Nj_e32)  +GetMyB (BASE_Ev_Yle_PoiskAikaS) +'s) mukaan.');
   33 :si (GetMyB (BASE_Avu_4_Nj_e33a) +GetMyB (BASE_SyAv_LT_Yliv)      +GetMyB (BASE_Avu_4_Nj_e33b));
   34 :si (GetMyB (BASE_Avu_4_Nj_e34));
   35 :si (GetMyB (BASE_Avu_4_Nj_e35));
   36 :si (GetMyB (BASE_Avu_4_Nj_e36));
   37 :si (GetMyB (BASE_Avu_4_Nj_e37)  +GetMyB (BASE_SyAv_KorjHuom));
   38 :si (GetMyB (BASE_Avu_4_Nj_e38));
   39 :si (GetMyB (BASE_Avu_4_Nj_e39));
    end;//case eRv
end;//Avu_4_Nj;
//===============================================================================================================
procedure Avu_5_Hav;     begin
case eRv of //,,,,,,,,, Nj :n Häviökust.StrGr+Boxit,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    1 :sR (GetMyB (BASE_Avu_5_Hav_e1) +GetMyB (BASE_SyAv_sLaina));
    2 :sR (GetMyB (BASE_Avu_5_Hav_e2) +GetMyB (BASE_Avu_5_Hav_e1));
    3 :sR (GetMyB (BASE_Avu_5_Hav_e3) +GetMyB (BASE_SyAv_sDiskont));
    4 :sR (GetMyB (BASE_Avu_5_Hav_e4));
    5 :sR (GetMyB (BASE_Avu_5_Hav_e5));
    6 :sR (GetMyB (BASE_Avu_5_Hav_e6));
    7 :sR (GetMyB (BASE_Avu_5_Hav_e7)  +GetMyB (BASE_SyAv_Loppuarvo));
    8 :sR (GetMyB (BASE_Avu_5_Hav_e8)  +GetMyB (BASE_SyAv_Loppuarvo));
    9 :sR (GetMyB (BASE_Avu_5_Hav_e9)  +GetMyB (BASE_SyAv_Loppuarvo));
   10 :sR (GetMyB (BASE_Avu_5_Hav_e10) +GetMyB (BASE_SyAv_Loppuarvo));
   11 :sR (GetMyB (BASE_Avu_5_Hav_e11) +GetMyB (BASE_SyAv_Loppuarvo));
  {12 :sR( '<b>Liittymän Ph[kW]</b> = Saman sähkölaskutuskohteen <b>kokonaishuipputeho</b>. Arvoa tarvitaan '+
           'tässä vain energian keskihinnan määrittämiseen häviökustannusten kapitalisoinnissa.');}
   12 :sR (GetMyB (BASE_Avu_5_Hav_e12));
   13 :sR (GetMyB (BASE_Avu_5_Hav_e13));
    end;//case eRv
end;//Avu_5_Hav;
//===============================================================================================================
procedure Avu_8_Sul;     begin
case eRv of //,,,,,,,,, Sulake + Imped.tarkastelu ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    0 :si('');
    1 :sZ (GetMyB (BASE_Avu_8_Sul_e1));
    2 :sZ (GetMyB (BASE_Avu_8_Sul_e2));
    3 :sZ (GetMyB (BASE_Avu_8_Sul_e3));
    4 :sZ (GetMyB (BASE_Avu_8_Sul_e4));
    5 :sZ (GetMyB (BASE_Avu_8_Sul_e5));
    7 :sZ (GetMyB (BASE_Avu_8_Sul_e7));
    8 :sZ (GetMyB (BASE_Avu_8_Sul_e8));
    9 :sZ (GetMyB (BASE_Avu_8_Sul_e9));
   10 :sZ (GetMyB (BASE_Avu_8_Sul_e10));
{----}
   20 :si('');
   21 :sZ (GetMyB (BASE_Avu_8_Sul_e21));
   22 :sZ (GetMyB (BASE_Avu_8_Sul_e22));
   23 :sZ (GetMyB (BASE_Avu_8_Sul_e23));
   24 :sZ (GetMyB (BASE_Avu_8_Sul_e24));
   25 :sZ (GetMyB (BASE_Avu_8_Sul_e25));
   26 :sZ (GetMyB (BASE_Avu_8_Sul_e26));
   27 :sZ (GetMyB (BASE_Avu_8_Sul_e27));
   28 :sZ (GetMyB (BASE_Avu_8_Sul_e28));
   29 :sZ (GetMyB (BASE_Avu_8_Sul_e29));
   30 :sZ (GetMyB (BASE_Avu_8_Sul_e30));
   31 :sZ (GetMyB (BASE_Avu_8_Sul_e31));
   32 :sZ (GetMyB (BASE_Avu_8_Sul_e32));
   33 :sZ (GetMyB (BASE_Avu_8_Sul_e33));
   34 :sZ (GetMyB (BASE_Avu_8_Sul_e34));
   35 :sZ (GetMyB (BASE_Avu_8_Sul_e35));
   36 :sZ (GetMyB (BASE_Avu_8_Sul_e36));
   37 :sZ (GetMyB (BASE_Avu_8_Sul_e37));
   38 :sZ (GetMyB (BASE_Avu_8_Sul_e38));
   39 :sZ (GetMyB (BASE_Avu_8_Sul_e39));
   40 :sZ (GetMyB (BASE_Avu_8_Sul_e40));
   41 :sZ (GetMyB (BASE_Avu_8_Sul_e42));
   42 :sZ (GetMyB (BASE_Avu_8_Sul_e42));
   43 :sZ (GetMyB (BASE_Avu_8_Sul_e43));
{----}
   46 :sZ (GetMyB (BASE_Avu_8_Sul_e46));
   47 :sZ (GetMyB (BASE_Avu_8_Sul_e47));
   48 :sZ (GetMyB (BASE_Avu_8_Sul_e48));
   49 :sZ (GetMyB (BASE_Avu_8_Sul_e49));
{----}
   51 :sZ (GetMyB (BASE_Avu_8_Sul_e51));
   52 :sZ (GetMyB (BASE_Avu_8_Sul_e52));
   53 :sZ (GetMyB (BASE_Avu_8_Sul_e53));
   54 :sZ (GetMyB (BASE_Avu_8_Sul_e54));
   55 :sZ (GetMyB (BASE_Avu_8_Sul_e55));
   56 :sZ (GetMyB (BASE_Avu_8_Sul_e56));
   57 :sZ (GetMyB (BASE_Avu_8_Sul_e57));
   58 :sZ (GetMyB (BASE_Avu_8_Sul_e58));
   59 :sZ (GetMyB (BASE_Avu_8_Sul_e59));
   60 :sZ (GetMyB (BASE_Avu_8_Sul_e60));
   61 :sZ (GetMyB (BASE_Avu_8_Sul_e61));
   62 :sZ (GetMyB (BASE_Avu_8_Sul_e62));
   63 :sZ (GetMyB (BASE_Avu_8_Sul_e63));
   64 :sZ (GetMyB (BASE_Avu_8_Sul_e64));
   65 :sZ (GetMyB (BASE_Avu_8_Sul_e65));
   66 :sZ (GetMyB (BASE_Avu_8_Sul_e66));
    end;//case eRv
end;//Avu_8_Sul
//===============================================================================================================
procedure Avu_9_Moo;     begin
case eRv of //,,,,,,,,, Moottorilähtöosa ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
           //, -1 on annettu <?> -napin painalluksessa kutsuun tätä varten <<<<<<<<<<<<<<<<<<<<<<<<<
 0,32 :sS( '<b>Riv n:o</b> = Taulukon rivinumero.');
   -1 :begin
       if demoLisAs  and  NOT OliJoInfo_Mo  then
          stG := GetMyB (BASE_Avu_9_Moo_e01a);
       OliJoInfo_Mo := true;
       si (GetMyB (BASE_Avu_9_Moo_e01b));  end;
   -2 :sZ (GetMyB (BASE_Avu_9_Moo_e02));
   -3 :sZ (GetMyB (BASE_Avu_9_Moo_e03));
   -4 :sZ (GetMyB (BASE_Avu_9_Moo_e04));
    1 :sZ (GetMyB (BASE_Avu_9_Moo_e1));
    2 :sZ (GetMyB (BASE_Avu_9_Moo_e2)    +GetMyB (BASE_SyAv_MoTaajMuut));
    3 :sZ (GetMyB (BASE_Avu_9_Moo_e3));
    4 :sZ (GetMyB (BASE_Avu_9_Moo_e4a)   +GetMyB (BASE_Ev_Yle_PoiskAikaS) +GetMyB (BASE_Avu_9_Moo_e4b));
    5 :sZ (GetMyB (BASE_Avu_9_Moo_e5));
    6 :sZ (GetMyB (BASE_Avu_9_Moo_e6));
    7 :sZ (GetMyB (BASE_Avu_9_Moo_e7));
    8 :sZ (GetMyB (BASE_Avu_9_Moo_e8a)   +GetMyB (BASE_SyAv_KorjHuom) +'<br>' +GetMyB (BASE_Avu_9_Moo_e8b)
                                         +GetMyB (BASE_SyAv_LisaMoDet));
    9 :sZ (GetMyB (BASE_Avu_9_Moo_e9));
   10 :sZ (GetMyB (BASE_Avu_9_Moo_e10));
   11 :sZ (GetMyB (BASE_Avu_9_Moo_e11));
   12 :sZ (GetMyB (BASE_Avu_9_Moo_e12));
   13 :sZ (GetMyB (BASE_Avu_9_Moo_e13));
   14 :sZ (GetMyB (BASE_Avu_9_Moo_e14)    +GetMyB (BASE_SyAv_MoTaajMuut));
   15 :sZ (GetMyB (BASE_Avu_9_Moo_e15));
   16 :sZ (GetMyB (BASE_Avu_9_Moo_e16a)   +fRmrkt0 (m_tasavImg, 1,3) +GetMyB (BASE_Avu_9_Moo_e16b));
   17 :sZ (GetMyB (BASE_Avu_9_Moo_e17a)   +IntToStr(suToler) +GetMyB (BASE_Avu_9_Moo_e17b));
   18 :sZ (GetMyB (BASE_Avu_9_Moo_e18));
   19 :sZ (GetMyB (BASE_Avu_9_Moo_e19)    +GetMyB (BASE_SyAv_LisaMoDet));
   20 :sZ (GetMyB (BASE_Avu_9_Moo_e20)    +GetMyB (BASE_SyAv_OiksMo) +'<br>   ' +GetMyB (BASE_SyAv_LisaMoDet));
21,27 :sZ (GetMyB (BASE_Avu_9_Moo_e21_27) +GetMyB (BASE_SyAv_LisaMoDet));
22,28 :sZ (GetMyB (BASE_Avu_9_Moo_e22_28) +GetMyB (BASE_SyAv_LisaMoDet));
23,29 :sZ (GetMyB (BASE_Avu_9_Moo_e22_29) +GetMyB (BASE_SyAv_LisaMoDet));
24,30 :sZ (GetMyB (BASE_Avu_9_Moo_e24_30));
25,31 :sZ (GetMyB (BASE_Avu_9_Moo_e25_31));
   26 :sZ (GetMyB (BASE_Avu_9_Moo_e26)    +GetMyB (BASE_SyAv_OiksMo) +'<br>   ' +GetMyB (BASE_SyAv_LisaMoDet));
99,52 :si (GetMyB (BASE_SyAv_MoTaajMuut)  +GetMyB (BASE_Avu_9_Moo_e52));      //<+12.0.0: 99 =PanelA´n avuste lisätty.
    end;//case eRv
end;//Avu_9_Moo
//==================================================================================================
  {41 :sS( '<b>Sft [%]</b> = Sulakkeen toimintapisteen siirto.   <b><0%</b> = Sulake ''hidastuu'',   '+
           '<b>>0%</b> = Sulake ''herkistyy''');}
  {23 :sS( '<b>Katkais. [+kW%]</b> = Moottoritehon kasvuvara ryhmäjohdolle katkaisijaa käytettäessä.<br>'+
           '     Ero syntyy pääosin siitä, että katkaisijaa käytettäessä sulakekerrointa ei tarvita ja '+
           'siitä, että katkaisijan terminen asettelu voidaan säätää tarkasti johdon ja asennusolosuhteiden '+
           'mukaan.');}
{--23 :sS( '<b>In [A]</b> = Pmax -moottorin nimelliskuorman mukainen virta laskettuna kaavalla:<br>'+
           '     In = Pmax / (Un × '+FONT_2JUURI +'3 × cos'+FONT_FII+' × '+FONT_EETTA+'),   missä '+
           FONT_EETTA+' on Pmax ja napaluvun mukaisen, nimellistehollaan käyvän moottorin mukainen '+
           'hyötysuhde.');
   24 :sS( '<b>cos'+FONT_FII +'</b> = Pmax -moottorin nimelliskuorman mukainen tehokerroin.');
   25 :sS( '<b>'+FONT_EETTA +'</b> = Pmax -moottorin nimelliskuorman mukainen hyötysuhde.');}

(* 29 :sS( '<b>SUL [A]</b> = Ryhmäjohdon sallima max. '{ylivirta- / }+'(oikosulku)suojasulake.<br>'+
           '     Arvo eroaa sarakkeen 16 arvosta vain pienehköillä moottoriyksiköillä.');*)
{--27 :sS( '<b>Start [A]</b> = Pmax -moottorin käynnistysvirta laskettuna kaavalla:<br>'+
           '     Ist = In × k ,   missä k on Pmax- ja napaluvusta määräytyvä käynnistys- ja nimellisvirto'+
           'jen suhde.');
   28 :sS( '<b>Start cos'+FONT_FII+'</b> = Moottorin käynnistystilanteen mukainen, Pmax- ja napaluvusta '+
           'määräytyvä tehokerroin.');}

