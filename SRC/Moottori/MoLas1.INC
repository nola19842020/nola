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

//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ MoLas1.INC
{  MoLas1.INC + NOLAm2.INC  Liittyy:  MOOT.PAS/incl.
   PRC:t  seurSul   kysyvalmis   asRivi   toimKysy}
//a_getIntg (30211..
{============================================================================}
PROCEDURE seurSul (VAR insul :Integer);
      PROCEDURE si (s :Integer);   BEGIN  insul := s;  END;             BEGIN
  CASE insul OF   10 :si( 16);   32 :si( 40);   100 :si(125);   315 :si(400);   1000 :si(1250);
   {0 :si(  2);}  16 :si( 20);   40 :si( 50);   125 :si(160);   400 :si(500);
{2§~}0:si(  4);   20 :si( 25);   50 :si( 63);   160 :si(200);   500 :si(630); //< 630 jälkeen IECgG
    4 :si(  6);   25 :si( 32);   63 :si( 80);   200 :si(250);   630 :si(800);
    6 :si( 10);  {32 :si( 35);}  80 :si(100);   250 :si(315);   800 :si(1000);
  ELSE si(0);  END;//<0 = YLITYS
END;//seurSul
//---------------------------------------------------------------------------
FUNCTION fMsuSft :Real;      VAR sft :real;      BEGIN //,,MoSulShft
  sft := a_getReaa (30220,mo.moty.SulSft);
  result := sft;   end;

(*,,Ei käytetty,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
FUNCTION KsftYR (suCs :string;  Isul :integer) :Real;      VAR tole :real;      BEGIN //,,suToler YLÄRAJAN mukaan
 {result := 1+ (-1*(SulSft-suToler))/100;    //-15-10=>1.25 10=>0.9 9.11.96asti}
  tole := 0;                         //,,SUTOLER VAIN OFAAgG+aM :ssa, > 630=IEC, joissa jo tolerRaja
                                     //,,2.0.1:  630 raja nyt huomioitu jo suCs:ssa = := IECgG,,olkoon
  IF  ( fSu_Sama (suCs,su_OFAg) OR fSu_Sama (suCs,su_OFAm) ) AND (Isul<=630)  THEN tole := suToler;
  tole := 1+ (fMsuSft +tole)/100;
  result := tole;
//'KsftYR =kerroin, jolla KASVATET.VIRTAA = LOITONNET. SUL.KÄYRÄÄ esim. Tim (sul,Ik * Ksft) kutsussa!
//=KÄYTTÖ:  AJAN (Tim) määrittämiseen -> Iku = Ik * KsftYR #########################################
END;//KsftYR                                 // SulSft > 0  =Kestettävä Ik SUURENEE !!!!!!!!!!!!!!!!*)

FUNCTION KsftAR (suCs :string;  Isul :integer) :Real;      VAR tole :real;      BEGIN//-suToler =ALARAJA =HERKEMPI!!
  tole := 0;                         //,,SUTOLER VAIN OFAAgG+aM :ssa, > 630=IEC, joissa jo tolerRaja
                                     //,,2.0.1:  630 raja nyt huomioitu jo suCs:ssa = := IECgG,,olkoon
  IF  ( fSu_Sama (suCs,su_OFAg) OR fSu_Sama (suCs,su_OFAm) ) AND (Isul<=630)  THEN tole := suToler;
  tole := 1+ (fMsuSft -tole)/100;                                    //-15-10=>0.75  10=>1.1<<<<<<<<
  result := tole;
//''KsftAR =kerroin, jolla PIENENNET. VIRTAA esim. Ikt(sul,tim)*KsftAR -kutsuissa = SULfnc:n ALARAJA
//=KÄYTTÖ:  VIRRAN (Ik) määrittämiseen -> Tim = f(sul,Ik*KsftAR) ###################################
END;//KsftAR                                 //-suToler koska sille annettu arvo = +10 !!!!!!!!!!!!

       //,,+1.1.2 Siirtää KONEEN tms. VIRTA-ARVON KESKIARVOKÄYRÄLLE #############################################
FUNCTION KsftARo (suCs :string;  Isul :integer) :Real;      BEGIN
   result := 1 / KsftAr(suCs,Isul); //<'=1.111... Käytetään, kun ETSITÄÄN SULAKEKÄYRÄN VIRTA-ARVOA koneen VIRTA-
                               //ARVOSTA = Koneen virran kuvitellaan olevan alarajakäyrällä, josta kerto-
                               //malla tällä arvolla saadaan sulakkeen keskikäyrän arvo. kun NÄIN saatu
                               //arvo kerrotaan KsftAR:llä, saadaan taas alarajakäyrän piste, MUUTEN MENISI
                               //YLI:  Nyt esim. 60*KsftARo=66.66.. ja 66.66*KsftAr=60 =OK, muuten
END;//KsftARbak                //                60*1.1=66             66*0.9=59.4 =VIRHE ################
//þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ MoLas1.INC

