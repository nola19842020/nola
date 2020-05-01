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

{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Avuste1.INC}
//Alkuosa procedure Avu_0_PaavEdv :sta ks. Avuste.INC (=versioiden muutostiedot)
//Käytä Boxeista termiä: arvoikkuna           Muista kertomerkki * => ×
function OhjeitaOngelmiin :string;      begin  result := GetMyB (BASE_Oha_Ongelmat);    end;
function OhjelmaTIETOA    :string;      VAR sp :string;      begin  sp := ''; //Sama, ks. Paketointi\AsOhjeet.rtf
                                          if demoLisAs  then sp := GetMyB (BASE_Oha_DemoVersio);
                                          stg := stg +GetMyB (BASE_Oha_JatkoTietoa);    end;
function KatkOhje :string;              begin  result := GetMyB (BASE_Oha_KatkOhje);  end;

procedure Avu_0_PaavEdv;      VAR sa :string;      begin
case eRv of //,,,,,,,,, 0,99 = Päävalikko + Edv :n pohja ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   99 :begin
       stG := '<tab s="10,20,30">';                //<,,VakioTABit osalle 99, SisX_ tekee alkuviivan '-' + TABin +
       case TabNo of //<TabNo =GLOB.               //   SISennyksen(=+LF) 2.rvstä ALKAEN.  12.0.0: TabIndex=>TabNo #####
          1: si (Avu_0_Versiot);                   //<Muutoshistoria, FNC SŧottoAv.PAS´sa.
          2: si (OhjeitaOngelmiin);
          3: si (myTextBase.Get(BASE_Avu_Lisenssi));
        else si (OhjelmaTIETOA); {0 Indx}
       end;{=case}
       si ('</tab>'); //<Poistetaan TABit.
    end;//99                                       //<''Siirretty Fnc:hin 8.0.5
    0{eRv} :begin
       if demoLisAs  and  NOT OliJoInfo_Ev  then
          stG := GetMyB (BASE_0_PaaEdv_e0_Lukkiut);
       OliJoInfo_Ev := true;
       if SyottoAvFrm.TabCtrlAv.TabIndex IN [3..5] //="Esimerkit", "RinnakLiit", "LääkMuunt_IT"
       then si( ' ')//{si( 'Lataa esimerkkiliittymien kuvan...')//LataaEsim
       else if SyottoAvFrm.TabCtrlAv.TabIndex=2                 //="Vihjeitä"
       then si (GetMyB (BASE_0_PaaEdv_e0ti2))
       else if SyottoAvFrm.TabCtrlAv.TabIndex=0                 //="Pähkinänkuoressa"
       then si (GetMyB (BASE_0_PaaEdv_e0ti0))           //,SyottoAvFrm.TabCtrlAv.TabIndex=1 //="Yleiset toimintaohjeet"
       else si (GetMyB (BASE_0_PaaEdv_e0ti1_1¤3) +fPoiskAikaRajaS +
                GetMyB (BASE_0_PaaEdv_e0ti1_2¤3) +fPoiskAikaRajaS +
                GetMyB (BASE_0_PaaEdv_e0ti1_3¤3));
    end;//eRv=0
    1 :sR (GetMyB (BASE_0_PaaEdv_e1));
    2 :si (GetMyB (BASE_0_PaaEdv_e2a) +GetMyB (BASE_SyAv_LT_Yliv) +'<br><br>' +GetMyB (BASE_0_PaaEdv_e2b));
    4 :sR (GetMyB (BASE_0_PaaEdv_e4));
    6 :sR (GetMyB (BASE_0_PaaEdv_e6));
    7 :sR (GetMyB (BASE_0_PaaEdv_e7a) +GetMyB (BASE_SyAv_RinIk3) +'  ' +GetMyB (BASE_SyAv_NapaIk) +'<br>'+
                                       GetMyB (BASE_0_PaaEdv_e7b));
    8 :sR (GetMyB (BASE_0_PaaEdv_e8a) +GetMyB (BASE_SyAv_RinIk3) +GetMyB (BASE_0_PaaEdv_e8b) +
                                       GetMyB (BASE_SyAv_NapaIk) +'<br>' +GetMyB (BASE_0_PaaEdv_e8c));
    9 :sR (GetMyB (BASE_0_PaaEdv_e9a) +GetMyB (BASE_SyAv_RinIk3) +GetMyB (BASE_0_PaaEdv_e9b) +
                                       GetMyB (BASE_SyAv_NapaIk) +'<br>' +GetMyB (BASE_0_PaaEdv_e9c));
   10 :sR (GetMyB (BASE_0_PaaEdv_e10));
   11 :sR (GetMyB (BASE_0_PaaEdv_e11)  +GetMyB (BASE_SyAv_OFAArajaInfo) +vPalstaSin +GetMyB (BASE_SyAv_YlivSuojPUNa));
   12 :sR (GetMyB (BASE_0_PaaEdv_e12a) +GetMyB (BASE_SyAv_TikInfo)  +GetMyB (BASE_0_PaaEdv_e12b) +GetMyB (BASE_SyAv_RajS_11) +'<br>' +
                                        GetMyB (BASE_SyAv_OFAArajaInfo) +vPalstaSin +GetMyB (BASE_SyAv_YlivSuojPUNa));
   13 :sR (GetMyB (BASE_0_PaaEdv_e13a) +GetMyB (BASE_SyAv_TikInfo) +GetMyB (BASE_SyAv_RajS_11) +'<br>' +
                                        GetMyB (BASE_SyAv_OFAArajaInfo) +'<br>' +CLR_BLB +GetMyB (BASE_0_PaaEdv_e13b) +
                                        GetMyB (BASE_SyAv_YlivSuojPUNa) +GetMyB (BASE_SyAv_YlivSuojPUNb));
   14 :sR (GetMyB (BASE_0_PaaEdv_e14)  +GetMyB (BASE_SyAv_TikInfo) +GetMyB (BASE_SyAv_RajS_11) +'<br>' +
                                        GetMyB (BASE_SyAv_OFAArajaInfo) +vPalstaSin   {'<br>'} +
                                        GetMyB (BASE_SyAv_YlivSuojPUNa) +GetMyB (BASE_SyAv_YlivSuojPUNb));
   15 :sR (GetMyB (BASE_0_PaaEdv_e15a) +GetMyB (BASE_SyAv_TikInfo)      +GetMyB (BASE_SyAv_RajS_11)  +
                                        GetMyB (BASE_SyAv_OFAArajaInfo) +GetMyB (BASE_0_PaaEdv_e15b) +
                                        GetMyB (BASE_SyAv_YlivSuojPUNa) +GetMyB (BASE_SyAv_YlivSuojPUNb));
   16 :sR (GetMyB (BASE_0_PaaEdv_e16)  +GetMyB (BASE_Oha_KatkOhje));
   17 :sR (GetMyB (BASE_0_PaaEdv_e17));
   18 :sR (GetMyB (BASE_0_PaaEdv_e18)  +GetMyB (BASE_SyAv_RajS_17)      +GetMyB (BASE_SyAv_RajZ_17) +
                                        GetMyB (BASE_SyAv_YlivSuojPUNa) +GetMyB (BASE_SyAv_YlivSuojPUNb));
   19 :sR (GetMyB (BASE_0_PaaEdv_e19)  +GetMyB (BASE_SyAv_RajS_17)      +GetMyB (BASE_SyAv_RajZ_17) +
                                        GetMyB (BASE_SyAv_YlivSuojPUNa) +GetMyB (BASE_SyAv_YlivSuojPUNb));
   20 :sR (GetMyB (BASE_0_PaaEdv_e20)  +GetMyB (BASE_SyAv_RajS_11)      +GetMyB (BASE_SyAv_RajZ_17) +
                                        GetMyB (BASE_SyAv_YlivSuojPUNa) +GetMyB (BASE_SyAv_YlivSuojPUNb));
   21 :sR (GetMyB (BASE_0_PaaEdv_e21));
   22 :sR (GetMyB (BASE_0_PaaEdv_e22_1¤4) +fPoiskAikaRajaS +
           GetMyB (BASE_0_PaaEdv_e22_2¤4) +fPoiskAikaRajaS +
           GetMyB (BASE_0_PaaEdv_e22_3¤4) +fPoiskAikaRajaS +
           GetMyB (BASE_0_PaaEdv_e22_4¤4));
   23 :sR (GetMyB (BASE_0_PaaEdv_e23a) +GetMyB (BASE_Ev_Yle_PoiskAikaS) +' (0.2) s:n </b>' +GetMyB (BASE_0_PaaEdv_e23b) +
   {',Sama alku,'}                                                       GetMyB (BASE_SyAv_RivSel));
   24 :sR (GetMyB (BASE_0_PaaEdv_e23a) +GetMyB (BASE_Ev_Yle_PoiskAikaS) +GetMyB (BASE_0_PaaEdv_e24b) +GetMyB (BASE_SyAv_RivSel));
   25 :sR (GetMyB (BASE_0_PaaEdv_e25a) +GetMyB (BASE_Ev_Yle_PoiskAikaS) +GetMyB (BASE_0_PaaEdv_e25b) +GetMyB (BASE_SyAv_RivSel));
   26 :sR (GetMyB (BASE_0_PaaEdv_e26a) +GetMyB (BASE_Ev_Yle_PoiskAikaS) +GetMyB (BASE_0_PaaEdv_e26b) +GetMyB (BASE_SyAv_RivSel));
   27 :sR (GetMyB (BASE_0_PaaEdv_e27)  +GetMyB (BASE_SyAv_RivSel));
   28 :sR (GetMyB (BASE_0_PaaEdv_e28)  +GetMyB (BASE_SyAv_RivSel));
   29 :sR (GetMyB (BASE_0_PaaEdv_e29)  +GetMyB (BASE_SyAv_RivSel));
   30 :sR (GetMyB (BASE_0_PaaEdv_e30)  +GetMyB (BASE_SyAv_RivSel));
   31 :sR (GetMyB (BASE_0_PaaEdv_e31)  +GetMyB (BASE_SyAv_RivSel_EiTst)); //<+1412.
   32 :sR (GetMyB (BASE_0_PaaEdv_e32)  +GetMyB (BASE_Ev_Yle_PoiskAikaS) +' s:n </b>' +GetMyB (BASE_SyAv_Ev_Yle_ResrKuSa) +
                                       {GetMyB (BASE_SyAv_RivSel) +}GetMyB (BASE_0_PaaEdv_ResUPS_ohitettu));
   33 :sR (GetMyB (BASE_0_PaaEdv_e33)  +{GetMyB (BASE_Ev_Yle_PoiskAikaS) +' s:n </b>' +}GetMyB (BASE_SyAv_Ev_Yle_ResrKuSa) +
                                       {GetMyB (BASE_SyAv_RivSel) +}GetMyB (BASE_0_PaaEdv_ResUPS_ohitettu));
   34 :sR (GetMyB (BASE_0_PaaEdv_e34a) +GetMyB (BASE_Ev_Yle_PoiskAikaS) +' s:n </b>' +GetMyB (BASE_SyAv_Ev_Yle_ResrKuSa) +
                                       {GetMyB (BASE_SyAv_RivSel) +}GetMyB (BASE_0_PaaEdv_e34b) +GetMyB (BASE_0_PaaEdv_ResUPS_ohitettu));
   35 :sR (GetMyB (BASE_0_PaaEdv_e35a) +GetMyB (BASE_SyAv_Ev_Yle_ResrKuSa) +GetMyB (BASE_0_PaaEdv_ResUPS_ohitettu)); {GetMyB (BASE_SyAv_RivSel) +
                                        GetMyB (BASE_0_PaaEdv_e35b));}
   50 :si (GetMyB (BASE_0_PaaEdv_e50_uk)); //<+130.2e:  uk -rivi       // Ao. johto-osan (pääjohdon) SUOJAUSEHTOJEN sallima MAX.sulake (rivi 11) / poikkipinta [mm ²] ja tyyppi
   end;//case eRv
//if eRv=7  then KoeW_ (stG +'<br><br>');
  {if Pos ('<in f="', stG) =0
      then stG := '<in f="0" l="10"><t>' +stG;}
//sa := '<in f="0" l="10"><t>';
(*sa := '';
   if (eRv IN [6..35]) and PanDblClickSelit                  //,<Lisätään alkuun: "Panelin DblClick kaventaa/leventää..
      then stG := GetMyB (BASE_0_PaaEdv_eDblClikHeader) +{SisXo}sa +stG  //<SisXo =sisennys vasta RIVInon JÄLKeiselle rvlle.
      else if (eRv>0) and (eRv<99)                                   //<Täytyy olla johto-osapalstoilla.
      then stG := GetMyB (BASE_0_PaaEdv_eDblClikJohdot) +{SisXo}sa +stG; //*)
sa := '<br>';//SisXo;
   if (eRv IN [6..35]) and PanDblClickSelit                  //,<Lisätään alkuun: "Panelin DblClick kaventaa/leventää..
      then stG := GetMyB (BASE_0_PaaEdv_eDblClikHeader) +sa +stG  //<SisXo =sisennys vasta RIVInon JÄLKeiselle rvlle.
      else if (eRv>0) and (eRv<99)                                //<Täytyy olla johto-osapalstoilla.
      then stG := GetMyB (BASE_0_PaaEdv_eDblClikJohdot) +sa +stG; //}
//if eRv=7  then KoeW_ (stG);
   if eRv<0  then ;
end;//Avu_0_PaavEdv
//===============================================================================================================

