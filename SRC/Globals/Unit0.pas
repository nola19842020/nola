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

unit Unit0;
{Unit0/Nola01,02.INC sis‰lt‰‰ VERKON IMPEDANSSITIETOJEN verkon (kaapelit, muuntajat) impedanssikomponentit.
 Laskentarutiinit, ks. Unit1/Nola1,10.INC.}
interface //,,,,,,,,,,,,,,,,,,,,,,,,,Nola01.INC,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

uses SysUtils, Dialogs{=MessageDlg}, Controls{mrYes}, Globals, Defs, Math{+5.0.1 Power()},
     Forms{+8.0.1 Application,ExeName}{, FileCtrl}{+8.0.1 DirectoryExist};

CONST AlfaAL=0.00403;  AlfaCU=0.00393;
//Nola01.INC,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  function fOnSV   (CONST tyyppi :string) :boolean; //<TR jos tyyppi :ss‰ mik‰‰n SVsyst.. mukana (POS >=1). +6.0.2
  function fOnSVal (CONST tyyppi :string) :boolean; //<TR jos STR :ss‰ 'SVsyst' ja 'AL' mukana (POS >=1).   +6.0.2
  function fOnSVcu (CONST tyyppi :string) :boolean; //<TR jos STR :ss‰ 'SVsyst' ja 'Cu' mukana (POS >=1).   +6.0.2
  FUNCTION rTkorj  (AlCu :boolean;  R20 :Real;  Tuus :Integer) :Real;   //R:n LT korjaus T20∞C:sta -> Tu∞C:een
  function fOnKIS   (CONST tyyppi :string) :boolean; //<,, +6.0.2
  function fOnKISal (CONST tyyppi :string) :boolean;
  function fOnKIScu (CONST tyyppi :string) :boolean; 
//FUNCTION fR20    (AlCu :boolean;   R20 :Real;   Tu :Integer) :Real;   //<T‰m‰ korvattu rTaT20 :lla. +6.0.2
  FUNCTION rTaT20  (AlCu :boolean;   Ralp :Real;  Talp :Integer) :Real; //R:n LT korjaus Talp∞C -> 20∞C:een
  procedure teeKtlk;                                      //<Korjauskerrointlkn teko
  function fAlCu   (CONST tyyppi :string) :boolean;             //<Pal VAIHEjohdnMater
  FUNCTION fPal    (CONST tyyppi :string) :Boolean;             //<Pal P-johdnMater
  FUNCTION fNal    (CONST tyyppi :string) :Boolean;             //<Pal N-johdnMater
  function SVsuhtL (CONST tyyppi :string;  mm2 :real) :real;
  function fM2     (mm2 :real) :integer;                  //<Muuntaa RealMm2 -> Int = 1.5 -> 1 jne.
  FUNCTION mm2_Pj  (CONST tyyppi :string;  mm2 :real) :Real;    //<Pal Pe-johdnMm2
  FUNCTION mm2_Nj  (CONST tyyppi :string;  mm2 :real) :Real;
  FUNCTION res     (CONST tyyppi :string;  mm2 :real) :Real;
  FUNCTION resPok (herjakin :boolean;  CONST tyyppi :string;  mm2 :real;  VAR onPE :boolean) :Real; //<+6.2.19  
  FUNCTION resP    (CONST tyyppi :string;  mm2 :real) :Real;    //<'Pal Pe-johdnResist.
  FUNCTION resN    (CONST tyyppi :string;  mm2 :real) :Real;
  FUNCTION resVo   (CONST tyyppi :string;  mm2 :real) :Real;
  FUNCTION Xv_ind  (CONST tyyppi :string;  mm2 :real) :Real;
  FUNCTION Xv0_ind (CONST tyyppi :string;  mm2 :real) :Real;
  FUNCTION Xp_ind  (CONST tyyppi :string;  mm2 :real) :Real;    //<Pal Pe-johdnReakt.
  FUNCTION Xn_ind  (CONST tyyppi :string;  mm2 :real) :Real;
  FUNCTION Xkap    (CONST tyyppi :string;  mm2 :real) :Real;
  FUNCTION RmaxSV  (CONST tyyppi :string;  mm2 :real) :Real;
  FUNCTION XmaxSV  (CONST tyyppi :string;  mm2 :real) :Real;
    FUNCTION fZd1_ (alcu :Boolean;   mm2 :real) :Real;
  FUNCTION fZd1    (CONST tyyppi :string;  mm2 :real) :Real;
  FUNCTION IksalTerm (CONST tyyppi :string;  mm2 :Real) :Real;      var a :integer;
  FUNCTION fUn_Umn :real;                                                      //<Muuntajan nimellisj‰nnite +6.0.4
  FUNCTION fTrAlCu (HavSrj :integer;  Sm :real) :boolean;
//PROCEDURE asMparam_ (Smn :Real;  Typ :integer;  VAR Rm,Rmo, Xm,Xmo :Real;  VAR Mtyp :integer);
//PROCEDURE asMparam_ (qSmn :Real;  qTyp :integer;  VAR qRm,qRmo, qXm,qXmo :Real;  VAR qMtyp :integer); //<5.0.1 +q
  PROCEDURE asMparam_ (qSmn :Real;  qTyp,qTuus{+6.0.4} :integer;  VAR qRm,qRmo, qXm,qXmo :Real;  VAR qMtyp :integer);
  //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Nola02.INC,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  FUNCTION Isal (CONST tyyppi :string;  mm2 :real;  tapa :string) :Real;
  PROCEDURE pienIsul  (VAR IsulNim :Integer);
  PROCEDURE kasvaIsul (VAR Isu :Integer);{su_OFAg su_OFAm su_IECg su_IECgAR su_IECgYR su_IECd su_IECdAR su_IECdYR
                                          su_OFAg = 'OFAAgG';   su_OFAm =   'OFAMaM';
                                          su_IECg = 'IECgG';    su_IECgAR = 'IECgG-AR';   su_IECgYR = 'IECgG-YR';
                                          su_IECd = 'IEC-Dz';   su_IECdAR = 'IEC-DzAR';   su_IECdYR = 'IEC-DzYR';}
  FUNCTION fKsul (CONST suCs :string;  Isul :Integer) :Real;            //<SulakeKerroin
  FUNCTION fKrin (tapa :string;  kpl :Integer) :Real;

  FUNCTION YvSuo (oh, special :Integer;  CONST suCs :string;  samaSul,katkaisija :Boolean;   TAPA :string;
                  korjkerr :Real;  CONST tyyppi :string;  mm2 :real;  kaapkpl :Integer;   VAR Suoja :Real) :string;

  FUNCTION YvSuoj (CONST suCs :string;  samaSul,katkaisija :Boolean;  TAPA :string;  korjkerr :Real;
                   CONST tyyppi :string;  mm2 :real;  kaapkpl :Integer) :Real;

  function OikSuoSFSt (CONST suCs :string;  CONST tyyppi :string;  mm2 :real;  kpl :Integer;  Tim :real) :Integer;
  FUNCTION OikSuoj (CONST suCs :string;  CONST tyyppi :string;  mm2 :real;  kpl :Integer) :Integer;     //'+10.0.1

  FUNCTION fSu_Sama (CONST suCs,suCo :string) :boolean;
  FUNCTION fSu_MuotoR (CONST suCs :string;  VAR suCo :string) :boolean;  //<Tut+Pal myˆs IEC-YLƒ/ALArajaVE :t
  FUNCTION fSu_Muoto (CONST suCs :string;  VAR suCo :string) :boolean;   //<EI TUT+PAL   IEC-YLƒ/ALArajaVE :ja
  FUNCTION fSu_Chr (CONST suCs :string) :string;                         //<su_OFAg:st‰ 'F' jne. #######################
  FUNCTION fSu_Str (CONST suCs :string) :string;                         //<'F':st‰ su_OFAg jne. #######################
  FUNCTION fSu_Perus (CONST suCs :string) :string;                       //<su_OFAgAR :st‰ su_OFAg jne. ################
  FUNCTION fSu_PerusSama (CONST suCs,suCv :string) :boolean;             //<su_OFAgAR :st‰ su_OFAg jne. ##################
{ FUNCTION SulTypOKrajat (suCs :string) :boolean;                        //<Tutkii, onko SULtyp OK  YR/AR/OFAg/OFAm -tarkasteluja}
                                                                         // varten. Ulkopuolelle j‰‰ vain:  su_IECg ja su_IECd
  FUNCTION IkT   (CONST suCs :string;  Isul :Integer;  Tim :Real) :Real; //<Ik, jolla IsulToimii ajassa 0.03-10s}
  FUNCTION IktAR (suCs :string;  Isul :Integer;  Tim :Real) :Real;       //<Ik, jolla IsulToimii ALArajallaan ajassa TIM
                                                                         //'KƒYTT÷: Moottoril‰hdˆn sulake (KESTETTƒVƒ)
//FUNCTION IktYR (suCs :string;  Isul :Integer;  Tim :Real) :Real;       //<Ik, jolla IsulToimii YLƒrajallaan ajassa TIM
                                                                         //'KƒYTT÷: Poiskytkent‰aikatarkasteluun
  FUNCTION Ikt_R (CONST suCs :string;  Isul :Integer;  Tim :Real) :Real; //<Tik=Kuten edelliset, mutta YLƒ/ALAraja TYYPIN MUK.

  FUNCTION Tik   (CONST suCs :string;  Isul :Integer;  Ik :Real) :Real;  //<Tik=Oikosulun kestoaika (=0.03-10s)
  FUNCTION TikYR (suCs :string;  Isul :Integer;  Ik :Real) :Real;        //<Tik=Oikosulun kestoaika YLƒrajallaan virralla IK
  FUNCTION TikAR (suCs :string;  Isul :Integer;  Ik :Real) :Real;        //<Tik=Oikosulun kestoaika ALArajallaan virralla IK
  FUNCTION Tik_R (CONST suCs :string;  Isul :Integer;  Ik :Real) :Real;  //<Tik=Kuten edelliset, mutta YLƒ/ALAraja TYYPIN MUK.

  FUNCTION Isnik (suCs :string;  Isul :Integer;  Tim :Real) :Real;       //<,Palauttaa SULAKETTA (Isul) vastaavan MIN.OIKOS.VIRRAN (SƒL tai KUL+TIM<=5s)

  FUNCTION sys_ker (R,X :Real) :Real;                                    //<Sys‰yskerroin Ik :lle
  FUNCTION m_tasav (sys,aika :Real) :Real;                               //,os => TypOsMukaan 7.0.5 Tek
  FUNCTION Tekv_mn (TypOsMukaan :integer;  tamaIk :real;  NJkin :boolean) :Real; //<Aika, jolla Ikmax:lla IkSal. +6.0.0  errS+120.45
  function OFAAraj_Is (IsuOFAA,Ip,Id :real)  :Real;                      //<fnc =OFAAsulakkeen rajoittama Is.   +5.0.1
  (*FUNCTION uhik (Rn,Xn,Ioikos :Real) :Real;
     uhik := Ioikos * Sqrt ( Sqr(Rn) + Sqr (Xn) );  END;*)

implementation
uses Y_,PaaVal{=Close},Unit1{6.0.0}, InfoDlgUnit, Winapi.Windows;
{$I '..\GlobINC\NOLA01.INC'}
{$I '..\GlobINC\NOLA02.INC'}

end.


