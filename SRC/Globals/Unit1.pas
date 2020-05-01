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

unit Unit1;
{Unit1/Nola1,10.INC sis‰lt‰‰ VERKON IMPEDANSSITIETOJEN laskentarutiinit. Verkon (kaapelit, muuntajat)
 impedanssikomponentit, ks. Unit1/Nola1,10.INC.}
interface
uses Globals,SysUtils,System.Classes{130.2e},
  {+6.2.2=..}Messages, Dialogs, StdCtrls, ExtCtrls{, FileCtrl}{+10.0.7 DirectoryExists};

  procedure ZaoFileen (si :string);                                                               //+141.2
  FUNCTION ZRXyv (os, Z_ :Integer) :Real;           //< Yl‰verkon imped.kompon 0=Z   1=R  >1 =X ######
     function edTc (eros,ao,oh :integer) :integer;
  FUNCTION edRv  (lahtien,asti, oh :Integer) :Real; //PALAUTTAA summaRESv:n
  FUNCTION edRv0 (lahtien,asti, oh :Integer) :Real; //PALAUTTAA summaRESvo:n          //< +6.0.2
  FUNCTION edRn  (lahtien,asti, oh :Integer) :Real; //PALAUTTAA summaRESn:n
  FUNCTION edRp  (lahtien,asti, oh :Integer) :Real; //PALAUTTAA PE-j¥n summaRESn:n    //<+130.2e
     FUNCTION edX (eros :integer;  Xkompon :Char;  lahtien,asti :Integer) :Real;      //<K‰yt: edXv jne.
  FUNCTION edXv  (lahtien,asti :Integer)  :Real;    //<PALAUTTAA SUMMA_Xv:n
  FUNCTION edXv0 (lahtien,asti :Integer)  :Real;    //<PALAUTTAA SUMMA_Xv0:n
  FUNCTION edXn  (lahtien,asti :Integer)  :Real;    //<PALAUTTAA SUMMA_Xn:n

    function fJKno (no :integer;  str :string) :integer;
    function fJKnoEiOK (OKstr :string) :string;           //< +4.0.0
  function ZpeOK (os :Integer;  PEk :real;  NJkin :Boolean;  QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer;
                  VAR OkNrot,jalessaNrot :string;  VAR RJmax_pit :real{+9.0.1}) :Boolean;
  FUNCTION iks (maxI :Boolean;  os :integer;  Zik :Real) :Real;        //MaxI=Ik3v
  PROCEDURE asMparamEdv_Ik3v (os :integer;  VAR Rm,Rmo, Xm,Xmo :Real);
  PROCEDURE asMparamEdv_Ik1v (os :integer;  VAR Rm,Rmo, Xm,Xmo :Real);
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Nola10.INC,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Nola10.INC,,,,,,,,,,,,,,,,,,,,6.0.0 Siirretty,,,,,,,,,,,,,,,,,,
  function fPoiskAikaRaja_ (Uo :integer) :real;   //< t = f(Uo).
  function fUo_ (Un  :integer) :integer;          //< NimellisUv=f(Un).
  function fUn :integer;                          //< Edvn p‰‰j‰nnite.
  function fUv :real;                             //< Uv=f(Un).
  function fUo :integer;                          //< NimellisUv.
  function fPoiskAikaRaja :real;
  function fPoiskAikaRajaS :string;
  function fValittuPoisAika :real;                                                              //<,+6.2.21
  function fValittuPoisAikaS :string;
  FUNCTION fV_U_k :Real;           //< uh% -laskuihin, uh% := V_U_k * (RP + XQ)
  //.............................................................''6.0.0 Siirretty  01.INC :st‰'''''
  procedure laskeEdvZpe (mrw,EdjNo :integer;  Zpe50V :real;  VAR qOhj :integer;  VAR qRn,qXn,PEpit :real);
//function fKxLz (ohj :integer;  tyyp :string;  mm2 :real;  kpl :integer): real; //<Korvattu ,,, :lla
  function fKxTot (ohj :integer;  tyyp :string;  mm2 :real;  kpl :integer): real;//<<<<<<< TotZ = L*fKxTot
  function fKxSuhLz (tyyp :string;  mm2 :real;  kpl :integer): real;             //<MaxZ -piste = L*fKxSuhLz
  function fPEkEkaJ :integer;
  function PEN_PE_LenkkiOK (VAR pen_peS :string;  VAR qR,qX :real) :boolean;            //<qR,qX p.o.<>'' KASVAA.
  FUNCTION Ziks_a(OHJ :Integer;  asti :Integer;  PEk :real;  NJkin :boolean; //<,FNC = KOKON.Zk: YhtOhm. Uusitt 6.2.2
                TIM :real;  QJtyp :string;  QJmm2,QJpit,muP :real;  QJkpl,QJlampot :integer;      //ßuß mu_=+8.0.7
                VAR  Rsz,Xsz,LszKer,Lsz :real) :Real; //^^^.      //<LszKer=Kerrottuna yhden kaapln Rv..yms. antaa
  FUNCTION Ziks_(ohj :Integer;  asti :Integer;  PEk :real;  NJkin :boolean;             //<10=Zk1vMin ... 51=Zk3d
                TIM :real;  QJtyp :string;  QJmm2,QJpit{muP^} :real;  QJkpl,QJlampot :integer; //<muP lis‰‰ Ziks_a:ssa.
                VAR  Rsz,Xsz,LszKer,Lsz :real) :Real;                  //',Ziks = KOKONAISoikosImpedanssi: YhtOhm
  FUNCTION Ziks (ohj :Integer;  asti :Integer;  NJkin :boolean;                                //<PEk lis‰‰ Ziks_:ssa.
                 TIM :real;  QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer;
                 VAR  Rsz,Xsz,LszKer,Lsz :real) :Real;
  procedure Zkaap (typ :string;  mm2,pit :real;  clt :integer;   VAR Rv,Rvo,Rn, Xv,Xvo,Xn :real); //< Rvo +6.0.2
  FUNCTION fZj (QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer): real; //<Yht‰lˆlle: Ik1v=c*Uv/Ze +7.0.0
  FUNCTION fZs (ohj :integer;  asti :Integer;  PEk :real;  NJkin :boolean;
                QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer;  //'yht‰lˆlle: Ik1v = c*Uv/Ze
                VAR  Rsz,Xsz,LszKer,Lsz :real) :Real;                         //'=KƒYTT÷: ZsIa_OK, Zs ymv
  FUNCTION ZsIa_OK (ohj :integer;  suCs :string;  asti :Integer;  PEk :real;  NJkin,KulSal :Boolean;  Isu :Integer;  Tim :Real;
                    QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer) :Boolean;{+@}
 {FUNCTION ZsIa_OKo (suCs :string;  asti :Integer;  PEk :real;  NJkin :Boolean;  Isu :Integer;  Tim :Real;  //<Ei KulSalTESTIƒ
                    QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer) :Boolean; {+@}
  FUNCTION fSu4 (suCs :string;  asti :Integer;  PEk :real;  NJkin,KulSal :Boolean;  Isu :Integer; //<maxSul 0.4s :lle
                 QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer;  VAR ylit :integer) :Integer;
  FUNCTION fSu4o (suCs :string;  asti :Integer;  PEk :real;  NJkin :Boolean;  Isu :Integer; //<maxSul 0.4s :lle, Ei KulSalTESTIƒ
                 QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer;  VAR ylit :integer) :Integer;
  FUNCTION Ikatk_ZsIa (asti :Integer;  PEk :real;  NJkin :boolean) :Real;         //''Ylit=1, jos ZsIa vaikutti
  function Ikatk_Aset (oikos,raaka :boolean;  os :Integer;  PEk :real;  NJkin :Boolean;  Qastap :Char;
                       VAR Ylitys :integer) :real;
  FUNCTION fSul_ZsIa (suCs :string;  os,alpNehSul :Integer;  PEk :real;  NJkin,KulSal :Boolean;  Tim :Real;
                      QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer) :Integer;
  FUNCTION fSul_Neh  (suCs :string;  Ik1v :real;  Tim :Real) :Integer;                       //<,Uudet FNC +2.0.1
  FUNCTION fSul_Tot  (ohj :integer;  suCs :string;  os :Integer;  PEk :real;  NJkin,KulSal :Boolean;  Tim :Real;
                      QJtyp :string;  QJmm2,QJpit :real;  QJkpl,QJlampot :integer) :Integer;
  PROCEDURE laskeRJpit (loc :string;  NJkin :Boolean;  vikaEvj,Isul,ct :Integer;  Tim,rjmm2,muP :Real;
                        eKpl :integer;  eTyyp,suCs :string;  tapa :string;
                        VAR minA,maxLrj,{+9.0.1:}maxLrj_zpe :Real;  VAR sulA,TUP :Integer);
implementation

uses Unit0, Y_, PaaVal,EdvNew{Kuvaus -tiedon takia/10.INC/Ziks_)}, Defs{FONT_OMEGA}, DetEv{1.INC koetul},
     InfoDlgUnit, Winapi.Windows,Koe{12.0.0};
{$I '..\GlobINC\NOLA1.INC'}
{$I '..\GlobINC\NOLA10.INC'}

end.
