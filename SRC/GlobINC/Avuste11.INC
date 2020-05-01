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

{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Avuste11.INC}
//Käytä Boxeista termiä: arvoikkuna           Muista kertomerkki * => ×
function Avu_0_Versiot :string;   begin result := myTextBase.Get(BASE_Avu_0_Versiot1);  end; //<Oli Avust.INC´ssä/Avu_0_PaavEdv.
procedure Avu_1_EdvLiit;      VAR sa :string;      begin
case eRv of //,,,,,,,,, Edv :n SjPj ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    //,si( '<b>OTSIKKORIVI</b> :   Sarakkeiden käyttötarkoituksen mukaiset nimet. ');
    0 :si (GetMyB (BASE_Avu_1_EdvLiit_e0));
    1 :case SyottoFrm.RadGrp.ItemIndex of //, 0=SJ-liittyjä
       0 :sR (GetMyB (BASE_Avu_1_EdvLiit_e1Rd0));
       2 :sR (GetMyB (BASE_Avu_1_EdvLiit_e1Rd2));
       else//,PJ-liitt + UPS
       sR (GetMyB (BASE_Avu_1_EdvLiit_e1Rd134a) +GetMyB (BASE_SyAv_KsLiitVihje) +GetMyB (BASE_Avu_1_EdvLiit_e1Rd134b)); end;
    2 :case SyottoFrm.RadGrp.ItemIndex of //, 0=SJ-liittyjä
       0 :sR (GetMyB (BASE_Avu_1_EdvLiit_e2Rd0));
       2 :sR (GetMyB (BASE_Avu_1_EdvLiit_e2Rd2));
       else//1=PJ tai 3=UPS
       sR (GetMyB (BASE_Avu_1_EdvLiit_e2Rd13) +GetMyB (BASE_SyAv_KsLiitVihje));  end;
{--------  Ik1v :n ja sen cos'+FONT_FII+' :n perusteella.   Ik3v = Uv / '+FONT_2JUURI+'(eRs ² + eXs ²), '+
           'johon tekijät eRs ja eXs on ratkaistu yhtälöstä Ik1v = 3 × cU × Uv / '+FONT_2JUURI+' [(6eRs+6Rv) ²'+
           ' + (6eXs+3Xv) ²], josta pelkistetty  Ik1v ~ 3 × cU × Uv / '+FONT_2JUURI+' [(12eRs) ² + (9eXs) ²], '+
           'missä eRs ja eXs sisältää edeltävän verkon kaikki tekijät. Yhtälössä on oletettu, '+
           'että edeltävän verkon PE/PEN-johtimen resistanssi on puolet vaihejohtimen resistanssista '+
           'ja että kaapeli on konsentrinen, jolloin Xn=0 ja antaa siten isomman oikosulkuvirran.'); a-----}
  3,4 :case SyottoFrm.RadGrp.ItemIndex of
       0 :if eRv=3  then sR (GetMyB (BASE_Avu11_yvRs)  +GetMyB (BASE_Avu11_yv_1) +GetMyB (BASE_Avu11_Rs) +
                             GetMyB (BASE_Avu11_yvEnd) +GetMyB (BASE_SyAv_KsLiitVihje))
                    else sR (GetMyB (BASE_Avu11_yvXs)  +GetMyB (BASE_Avu11_yv_1) +GetMyB (BASE_Avu11_Xs) +
                             GetMyB (BASE_Avu11_yvEnd) +GetMyB (BASE_SyAv_KsLiitVihje));
       1 :if eRv=3 //< 1=PJ
          then begin sa := GetMyB (BASE_Avu_1_EdvLiit_e3Rd1_a);  //<eRv=3
             sa := sa +
             fMrkvia (fRpX_kaap (1,'AXMK', 300,40), 4) +' (axmk 300),  '+
             fMrkvia (fRpX_kaap (1,'AXMK', 240,40), 4) +' (axmk 240),  '+
             fMrkvia (fRpX_kaap (1,'AXMK', 185,40), 4) +' (axmk 185),  '+
             fMrkvia (fRpX_kaap (1,'AXMK', 120,40), 4) +' (axmk 120),  '+
             fMrkvia (fRpX_kaap (1,'AXMK', 70 ,40), 4) +' (axmk 70),  '+
             fMrkvia (fRpX_kaap (1,'AXMK', 16 ,40), 4) +' (axmk 16),  '+
             fMrkvia (fRpX_kaap (1,'AMCMK',240,40), 4) +' (amcmk 240),  '+
             fMrkvia (fRpX_kaap (1,'AMCMK',240,40), 4) +' (amcmk 185),  '+
             fMrkvia (fRpX_kaap (1,'AMCMK',120,40), 4) +' (amcmk 120),  '+
             fMrkvia (fRpX_kaap (1,'AMCMK',70 ,40), 4) +' (amcmk 70),  '+
             fMrkvia (fRpX_kaap (1,'AMCMK',16 ,40), 4) +' (amcmk 16),  '+
             fMrkvia (fRpX_kaap (1,'AMKA', 120,40), 4) +' (amka 120),  '+
             fMrkvia (fRpX_kaap (1,'AMKA', 70 ,40), 4) +' (amka 70),  '+
             fMrkvia (fRpX_kaap (1,'AMKA', 16 ,40), 4) +' (amka 16)  <br>';
             sR (sa +GetMyB (BASE_Avu_1_EdvLiit_e3Rd1_b) + GetMyB (BASE_SyAv_KsLiitVihje));   end
          else sR (GetMyB (BASE_Avu_1_EdvLiit_e4Rd1));           //<eRv=4
       2 :if eRv=3 //< Index 2=VV
             then sR (GetMyB (BASE_Avu_1_EdvLiit_e3Rd2{C}))
             else sR (GetMyB (BASE_Avu_1_EdvLiit_e4Rd2A));
       3 :sR (GetMyB (BASE_SyAv_PEN_PE_yhdist));  //< 3=UPS eRv 3 (tai eRv=4 jota eioo)
      end;
  5,6 :case SyottoFrm.RadGrp.ItemIndex of         // 0=SJ  1=PJ  2=VV  3=UPS
       0 :if eRv=5 //< 0 = SJ-liittyjä
             then sR (GetMyB (BASE_Avu_1_EdvLiit_e5Rd0) +BASE_SyAv_KsLiitVihje)
             else sR (GetMyB (BASE_SyAv_PEN_PE_yhdist)); //<eRv=6
       1 :sR (GetMyB (BASE_SyAv_PEN_PE_yhdist));         //<eRv=5 (eRv=6 ei olekaan).
       2 :if eRv=5                     //<,,2=VV
             then sR (GetMyB (BASE_Avu_1_EdvLiit_e5Rd2))
             else sR (GetMyB (BASE_Avu_1_EdvLiit_e6Rd2));
       end;
    //eRv=7-9 on vain VV:lla,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    7 :sR (GetMyB (BASE_Avu_1_EdvLiit_e7));
    8 :sR (GetMyB (BASE_Avu_1_EdvLiit_e8));
    9 :sR (GetMyB (BASE_Avu_1_EdvLiit_e9));

//,,,Näihin ohjataan StrGr:n SAR 1:sta '+nuo+' rivi+11 = 11...,  SAR 4:sta rivi+31 = 31... sekä Btnit 51...
   10 :if SyottoFrm.RadGrp.ItemIndex=2 //< 2=VV
       then sR (GetMyB (BASE_Avu_1_EdvLiit_e10Rd2))
       else begin //Tähän vain apulask.ikkunasta.
          stG := GetMyB (BASE_Avu_1_EdvLiit_e10);
          if SyottoFrm.PanelYa.Visible  then stG := stG + //<PanelYa ei ole näkyvissä, ellei APULASKENTARUUTU auki.
             GetMyB (BASE_Avu_1_EdvLiit_e10YaVisA) +GetMyB (BASE_SyAv_SiirA) +GetMyB (BASE_Avu_1_EdvLiit_e10YaVisB) +
             GetMyB (BASE_SyAv_LiitVihje);
       end;
 //,,,,,,,,,,,,,,,,,,,,,,,,,,Yläverkon vas. puolen avusteet,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   11 :if SyottoFrm.RadGrp.ItemIndex=2 //< 2=VV
          then sR (GetMyB (BASE_Avu_1_EdvLiit_e11Rd2))
          else sRi(1, GetMyB (BASE_Avu_1_EdvLiit_e11Rd_));
   12 :if SyottoFrm.RadGrp.ItemIndex=2 //< 2=VV
          then sR (GetMyB (BASE_SyAv_PEN_PE_yhdist))
          else sRi( 2,GetMyB (BASE_Avu_1_EdvLiit_e12) +GetMyB (BASE_SyAv_CosYmEiTarv));
   14 :sRi (4,GetMyB (BASE_Avu_1_EdvLiit_e14) +GetMyB (BASE_SyAv_CosYmEiTarv) +'<br><br>' +GetMyB (BASE_SyAv_SjKaapArv));
15,35 :sRi (5,GetMyB (BASE_Avu_1_EdvLiit_e15_35));
   16 :sRi (6,GetMyB (BASE_Avu_1_EdvLiit_e16));
   17 :sRi (7,GetMyB (BASE_Avu_1_EdvLiit_e17) +GetMyB (BASE_Avu_1_EdvLiit_e17));
   18 :sRi (8,GetMyB (BASE_Avu_1_EdvLiit_e18));
   19 :sRi (9,GetMyB (BASE_Avu_1_EdvLiit_e19) +GetMyB (BASE_SyAv_SjKaapArv));
23,43 :begin  if eRv=23  then sRi (13,GetMyB (BASE_Avu_1_EdvLiit_e23))
                         else sRi (13,GetMyB (BASE_Avu_1_EdvLiit_e43));
              stG := stG +GetMyB (BASE_Avu_1_EdvLiit_e23_43a) +GetMyB (BASE_SyAv_SiirY) +'<br>' +GetMyB (BASE_Avu_1_EdvLiit_e23_43b);  end;
   24 :sRi (14,GetMyB (BASE_Avu_1_EdvLiit_e24) +GetMyB (BASE_SyAv_SiirY));
//,,,,,,,,,,,,,,,,,,,,,,,,,,Yläverkon oikean puolen avusteet,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
{  31 :sRi( 1,'<b>cos' +FONT_FII +'</b> = Yläjännitepuolen johtoverkon <b>myötäimpedanssin vaihesiirto</b>.  '+
            'Kantaverkossa 400 kV :lla '+cosf +' ' +FONT_LIKIM +' 0.052(87°) ... 0.104(84°) ja 110 kV :lla '+
            '0.174(80°) ... 0.259(75°), eli reaktanssi on selkeästi määräävä, jolloin suurehkokaan virhe '+
            'resistanssissa ei johda oleellisiin virheisiin.<br>'+
            '   Eräitä raja-arvoja:   Kun cos'+FONT_FII +' = 0.3 ('+FONT_FII +' '+FONT_LIKIM +' 72°), R = X/3,'+
            '   kun cos'+FONT_FII +' = 0.1 ('+FONT_FII +' '+FONT_LIKIM +' 84°), R = X/10 (eli dekadin X :ää '+
            'pienempi).<br>'+
            '   '+ cosf +' -arvo voidaan arvioida myös käytetyn johtotyypin perusteella:   ' +cosf +' = '+
            'cos (arcTan(X/R)), mihin X ja R -arvot saadaan kohdan Ry, Xy -avusteista. Eräitä arvoja: <br>'+
            '<b>Savo</b> 0.879(28.5°),  <b>Raven</b> 0.829(34°),    <b>Imatra</b> 0.686(46.7°),   '+
            '<b>Suursavo</b> 0.652(49.3°),...   <b>Piper</b> 0.528(58.1°),...   <b>Hawk</b> 0.377(67.9°),...  '+
            '<b>Finch</b> 0.199(78.5°).<br>'+
            '   Mitä lyhyempi johto-osuus, sitä määräävämpi muuntajan osuus; reaktanssin osuus suurenee, '+
            cosf +' pienenee.<br>'+
            '   Ry, Xy :llä laskien:  ' +cosf +' = Ry / Zy ,   Zy = ' +FONT_2JUURI +'(Ry ²+Xy ²).' +CosYmEiTarv);}
   31 :sRi (1,GetMyB (BASE_Avu_1_EdvLiit_e31a) +GetMyB (BASE_SyAv_CosYmEiTarv) +GetMyB (BASE_Avu_1_EdvLiit_e31b));
   32 :sRi (2,GetMyB (BASE_Avu_1_EdvLiit_e32)  +GetMyB (BASE_SyAv_CosYmEiTarv));
   34 :sRi (4,GetMyB (BASE_Avu_1_EdvLiit_e34)  +GetMyB (BASE_SyAv_CosYmEiTarv) +'<br><br>' +GetMyB (BASE_SyAv_SjKaapArv));
   37 :sRi (7,GetMyB (BASE_Avu_1_EdvLiit_e37)  +GetMyB (BASE_SyAv_1_MuuntArv));
   38 :sRi (8,GetMyB (BASE_Avu_1_EdvLiit_e38));
   39 :sRi (8,GetMyB (BASE_Avu_1_EdvLiit_e39)  +GetMyB (BASE_SyAv_SjKaapArv));
   41 :sRi (11,GetMyB (BASE_Avu_1_EdvLiit_e41) +GetMyB (BASE_SyAv_SjKaapArv));
   42 :sRi (12,GetMyB (BASE_Avu_1_EdvLiit_e42));
   44 :sRi (14,GetMyB (BASE_Avu_1_EdvLiit_e44a)+GetMyB (BASE_SyAv_SiirY) +GetMyB (BASE_Avu_1_EdvLiit_e44b));
   //,,,,,,,,,,,,,,,,,,,,,,,,,,Btns                                                       //' Ik3v2[kA]=U/(Z*V¨3)
   51 :si (GetMyB (BASE_Avu_1_EdvLiit_e51));
   52 :si (GetMyB (BASE_Avu_1_EdvLiit_e52));
   60 :si (GetMyB (BASE_Avu_1_EdvLiit_e60));
   end;//case eRv
end;//Avu_1_EdvLiit
//===============================================================================================================
procedure Avu_2_EdvJtied;      begin
case eRv of //,,,,,,,,, Edv :n johto-osan syöttö ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    0 :sR (GetMyB (BASE_Avu_2_EdvJtied_e0));
    1 :sR (GetMyB (BASE_Avu_2_EdvJtied_e1)  +fPoiskAikaRajaS +'s) mukaan.');
    2 :sR (GetMyB (BASE_Avu_2_EdvJtied_e2));
    3 :sR (GetMyB (BASE_Avu_2_EdvJtied_e3));
    4 :sR (GetMyB (BASE_Avu_2_EdvJtied_e4));
    5 :sR (GetMyB (BASE_Avu_2_EdvJtied_e5a) +IntToStr(rinmax) +GetMyB (BASE_Avu_2_EdvJtied_e5b));
    6 :sR (GetMyB (BASE_Avu_2_EdvJtied_e6)                    +GetMyB (BASE_SyAv_LT_Yliv));
    7 :sR (GetMyB (BASE_Avu_2_EdvJtied_e7)  +GetMyB (BASE_SyAv_KorjHuom));
    8 :sR (GetMyB (BASE_Avu_2_EdvJtied_e8));
    9 :sR (GetMyB (BASE_Avu_2_EdvJtied_e9));
   10 :sR (GetMyB (BASE_Avu_2_EdvJtied_e10));
   11 :sR (GetMyB (BASE_Avu_2_EdvJtied_e11));
   12 :sR (GetMyB (BASE_Avu_2_EdvJtied_e12));
   13 :sR (GetMyB (BASE_Avu_2_EdvJtied_e13));
   14 :if Rv<>RvNr                            //<,,+120.5o
          then sR (GetMyB (BASE_Avu_2_EdvJtied_e15) +GetMyB (BASE_SyAv_LT_Yliv))
          else sR (GetMyB (BASE_Avu_2_EdvJtied_e14));
   15 :sR (GetMyB (BASE_Avu_2_EdvJtied_e15) +GetMyB (BASE_SyAv_LT_Yliv));

(* -8.0.3, korvattu PRC UpDwnH(W)Click´illä ,,,,,,,,,
   66 :si( '<b>Avusteikkunan koon muuttaminen:</b>'{   (poistumatta ikkunasta, á 80 pixeliä, n. 5 riviä) }+'<br>'+
           '<b>   Korkeus kasvaa    </b><t>= KaksoisKlikkaa alapanelia<br>'+
           '<b>   Korkeus <u>pienenee</u></b><t>= KaksoisKlikkaa + <u>Shift</u><br>'+
           '<b>   Leveys  kasvaa    </b><t>= KaksoisKlikkaa + Ctrl<br>'+
           '<b>   Leveys  <u>pienenee</u></b><t>= KaksoisKlikkaa + Ctrl + <u>Shift</u><br>'); *)
    end;//case eRv
end;//Avu_2_EdvJtied
//===============================================================================================================
procedure Avu_3_EdvUh;      begin //<,Ei enää tarvita  -4.0.0
case eRv of //,,,,,,,,, Edv :n %-palstan syöttö ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    0 :si (GetMyB (BASE_Avu_3_EdvUh_e0));
    1 :si (GetMyB (BASE_Avu_3_EdvUh_e1));
    2 :si (GetMyB (BASE_Avu_3_EdvUh_e2));
    3 :si (GetMyB (BASE_Avu_3_EdvUh_e3));
    end;//case eRv
end;//Avu_3_EdvUh

