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

{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{Tässä on  pohjana Y_ ~1779~.pas 12.03.2016 15:58 versio.
Tärkeitä/keskeisiä:  Y_.PAS/Y_gLueTal_FileLista
130.2e: £STR -hakusanalla löytyy kaikki uudet:
         StoSok_e5  RtoS_e5  StrToFloatQ  fMrkvia  fRmrkt0  (=RtoS)  sRmrkt0vex  SokR   =MUUNNOSfunctiot ja PRC´t oleellisten muutosten jälkeen.
 12.0.0: - Val (s,ar,Code); ,vaihdettu => StrToFloatQ  FNC fRmrkt0´ssa.
             String to real :    a := StrtoFloat('111.231');
             String to integer : a := StrtoInt('12');
         - NolaStr2(ja1) on MUUTETTU VolaStr2(ja1):ksi jottei haku veisi jo KORJATTUIHIN merkintöihin +12.0.0

FUNCTION keskih (n :Integer;  summa :Real8) :Real8;         BEGIN//E:\PASCAL\OHATPAS\Gluco.PAS
      (* keskihaj = û (1/n ä (Xv - keskim)ý) *)
         keskih := Sqrt (summa) /n;   END;

GeomKeskiArvo = n:s juuri (x1*x2*..xn)
}
unit Y_;
{$I ..\Globals\Defines.INC}
interface

uses Windows{+10.0.4 wbeep vaati},WinTypes,WinProcs, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
     {+220806:} ComCtrls, Messages, {Dialogs, FileCtrl,}
     Buttons, ExtCtrls, Vcl.Dialogs, {DEVELOPER1/DEVELOPER2+}Globals, {DEVELOPER1+Dialogs,} Settings, Defs, Inifiles, Printers, Asetus,
     RichEditNola,ComboBoxXY,StringGridNola,Grids, LicenseFuncs, mmsystem{SetVolume 1415f}, System.UITypes;

(*Windows, Messages, Dialogs,
  SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, {Printers Printer.Canvasin takia,}
            ExtCtrls,
 {FMXUtils,}ComCtrls, RichEditNola, {=Exec.: Ei löytynyt valmista .DCU-fileä, mutta .PAS löytyi ..\\Delphi\..:stä, joka nyt kopioitu mukaan}
  Inifiles,FileCtrl, LabelNola;*)
type
  TY_DemoFrm = class(TForm)
    OKBtn: TButton;
    Bevel1: TBevel;
    Timer1: TTimer;
    HerjaLbl: TLabel;
    DemoLbl: TLabel;
    OpenDlg: TOpenDialog;
    SaveDlg: TSaveDialog;
    Memo1: TMemo;
    ReditN: TRichEditNola;
    procedure OKBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

CONST sDemI='Xxx';   sDemR='X.xx';
var
  Y_s :string;             //<Globaaliin mjonojen käyttöön esim. Y_Koe ()###########################
  Y_DemoFrm: TY_DemoFrm;
//procedure LoadFromFil_(VAR Lst :TStringList; fn :string); //1214cU2: Oli tarkoitus korvata kaikki LoadFromFile -kutsut tällä, mutta n. 65 kutsua
                                                            //         tuntui turhan työläältä vaihtaa tähän. Onpahan varalla jos tulisi tarpeeseen.
  procedure Valivii (IniFN :string);
  function fDTvexVainFN(str :string) :string;               //<+1414f.
  procedure WBeepitN (krt :integer);                        //<+1414d
  function fGetAika(FileName :string;  VAR ModifiedDate :TDateTime) :boolean; //<120.6 DEVELOPER1
//function fGetAikaU(FileName :string;  VAR ModifiedDate :TDateTime) :boolean; //<1414 DEVELOPER1
  function StoSok_e5 (VAR SX :string) :boolean;
  function StrToFloatQ (s :string) :Extended;   //Override;      //<+12.0.04 Turkii '.'/',' ja muuttaa...
  function RtoS_e5 (RX :real) :string;
  procedure tyP;                                //<+8.0.3 Tyhjä PRC korvaamaan if ... then Beep => tyP
  function fHandleFN(TheFileName: string) :integer;
  function Rounder(var Value: {Double}real; Decimals: Integer): Double;       //<+12.0.0
  function PROGRAM_VERSIO_STRING :string;  //<+6.2.10
  function OnPvitysEstoListassa :boolean;  //<+6.0.0, nimimuutos 10.0.2, oli EiPvitysListassa.
//,,Y_.INC´ssä,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  function LisLaajToStr (LisLaajuus :LicenseScope;  Pit :integer) :string;    //<,,7.0.1
  function LisLaajToInt (LisLaajuus :LicenseScope) :integer;                  //<+8.0.0
  function fVoimassaLaajTest :LicenseScope;
  function LisYliDemo_ (MinLisRaja :LicenseScope) :Boolean;                   //<+8.0.0
  function LisYliDemo_Info (MinLisRaja :LicenseScope) :Boolean;
  function PRO_Demo :Boolean;                                                 //<''7.0.1
  function EXT_Demo :Boolean;                                                 //<+8.0.0
  function SalaSallii (MinLisRaja :LicenseScope) :Boolean;                    //<,+8.0.0
  function fSalaLaajuus (VAR TestiRaja :integer) :integer;
  function demoLisAs :Boolean;
  function demo(os :integer) :Boolean;                                        //< +os +12.0.03
//''Y_.INC´ssä''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  function fKaikkiOikeudet_1x :Boolean;      //<f -etumääre +1101å2
//  function LTajo  :Boolean;                //<,2.0.x, DEVELOPER2 20040328, poistettu tarpeettomina
//  function PROajo :Boolean;                //<,2.0.x, DEVELOPER2 20040328, poistettu tarpeettomina
//  function SetProLT :Boolean;              //<,2.0.x, DEVELOPER2 20040328, poistettu tarpeettomina
  function LisAsennettu: Boolean;
  function Y_esittelyEhto :Boolean;
  procedure Y_Koe (oh :integer;  S :string);{=@}
  procedure WBeep(arrI :array of integer);   //<+10.0.4, 130.2e  Ks. mm. Syotto.PAS:  [Hz,ms, Hz,ms,..]
  procedure Y_piipit (krt :integer);         //<Tässä unitissa, =jotta Z_Lask -unit tunnistaisi
  function Y_piip :boolean;                  //<Piippaa ja estää toiminnan. Korvaa kommenttisulut ja muistuttaa!!!
  procedure erPiip;
  procedure EiOKinfo (CONST s :string);
  procedure Y_DemoInfo(CONST S :string);     //<Itse lisätty: Muut Unitit tunnistavat niissä
                                             // esitellyn USES Y_ :n kautta. Todettu}
//-----------------------------------------
  FUNCTION fEmtyS (CONST s :string) :boolean;
  FUNCTION fMuokDesRaj (arvR,rajR :real;  rajD :integer) :real;
  FUNCTION fMuokDesRajAlk (arvR :real;  alkio :arvoTyyp) :real;
  //,OLI:  fMuokDesx (arvo :real;  raja0,maxDes :integer) :real;
  FUNCTION fMuokDes (arvR :real;  des :integer) :real;
//function fDes0 (r :real;  rajaD,maxDes :integer) :integer;             //<Antaa desimLkmn, esim. 123, 12.3  1.23, 0.123
  function fDsm (r :real;  rajR :real;  maxD :integer) :integer;         //<Korvaa 'ed. fDes0 :n viritt:n jälk.     9.0.1
function fDesDyn (rr,ar :real) :integer;                                 //+130.0
  function fMrkvia (rr :real;   merkitsevia :integer) :string;           //<Vain MERKITSEVIA -määrä N:OITA
  function fMrkviaN (arvR :real;   merkitsevia,Des0vex :integer) :string;//<Vain MERKITSEVIA -määrä N:OITA LOPUSTA lukien.
  function fVexN_ (s :string) :string;                        //<,Poistaa loppunollat, Esim: 23.000 -> 23   23.01000 -> 23.01
  function fVexNrd (r :real;  des :integer) :string;
  function fVexNS (r :real) :string;                          //<Poistaa loppunollat ###############

  FUNCTION fImrkt_(arvI :Integer;   tab :Integer) :String;               //< Int:  0 = - - - - - -
  FUNCTION fRmrkt_(arvR :Real;  tab,des :Integer) :String;               //< Real: 0 = - - - - - -
  FUNCTION fRmrk5x(oh :integer;  arvR :Real;  tab,des :Integer) :String; //< Real: 0 =- - - - - <X.xx
  FUNCTION fRmrk5x_PRO(oh :integer;  arvR :Real;  tab,des :Integer) :String; //<+7.0.1
  FUNCTION IntS (arvI :Integer) :String;                       //< IntToStr
  FUNCTION fImrkt0(arvI :Integer;   tab :Integer) :String;     //< Int:  0   = 0:tab
  FUNCTION fRmrkt0(arvR :Real;  tab,des :Integer) :String;     //< Real: 0.0 = 0:tab:des      ,,X.xx  NegatDes =Loppu0vex
  FUNCTION RtoS   (arvR :Real;  tab,des :Integer) :String;     //< Kutsuu fRmrkt0()´aa.
  FUNCTION fRmrkt (arvR, rajD :real;  desD :Integer) :String; //< Tutkii DESIM määrän
//function fRmrkt0x (r :real;  tab,des :integer) :string;     //<Poistaa loppunollat + mahd. loppu"."
  FUNCTION sRmrkt0vex (arvR :Real;  tab,des :Integer) :String;
  FUNCTION fRkilo0(oh :integer;  arvR :Real;  tab,des :Integer) :String; //<10000.00/1000.00 -> 10000.0 .. 1000
  FUNCTION fRkilo0_PRO(oh :integer;  arvR :Real;  tab,des :Integer) :String; //+7.0.1
  FUNCTION fRkil5x(oh :integer;  arvR :Real;  tab,des :Integer) :String; //< - " - / - - - - < X.xx
  FUNCTION fRkil5x_PRO(oh :integer;  arvR :Real;  tab,des :Integer) :String; //+7.0.1
  FUNCTION fBmrkt0(arvB :Boolean;  tab :integer)  :String;
  function fBmrkt2(boo :boolean) :string;                                //<+1415f.
  FUNCTION fBmrkt_(arvB :Boolean;  tab :integer)  :String;
  procedure Imrkt0(arvI :Integer;   tab :Integer;  VAR S :String);
  procedure Rmrkt0(arvR :Real;  tab,des :Integer;  VAR S :String);
  FUNCTION fKmark (oh :integer;  arvR :Real;  tab,des :Integer) :String;//<1000.00 -> 1.000,00  1.000,0 tms.
  FUNCTION fKmark_PRO (oh :integer;  arvR :Real;  tab,des :Integer) :String; //+7.0.1
  FUNCTION fMm2Des (mm2 :Real;  tab :integer) :string;                                          //<+6.2.16

  FUNCTION fDemI (oh :Integer;  arvI,tab :Integer) :string; //<,OH=0 =ArvO tulostet ilman DEMOtestiä
  FUNCTION fDemI_PRO (oh :Integer;  arvI,tab :Integer) :string;         //+7.0.1
  FUNCTION fDemIx (oh :Integer;  arvI,tab :Integer) :string;            //<Xxx
  FUNCTION fDemIx_PRO (oh :Integer;  arvI,tab :Integer) :string;        //+7.0.1
  FUNCTION fDemR (oh :Integer;  arvR :real;  tab,des :Integer) :string; //<DemoX
//FUNCTION fDemR_PRO (oh :Integer;  arvR :real;  tab,des :Integer) :string;  //+7.0.1
  FUNCTION fDemRx (oh :Integer;  arvR :real;  tab,des :Integer) :string;     //<X.xx
  FUNCTION fDemRx_PRO (oh :Integer;  arvR :real;  tab,des :Integer) :string; //+7.0.1
  FUNCTION fDemRxx_PRO (oh :Integer;  arvR :real;  tab,des :Integer) :string;//+7.0.4  Xxx
  FUNCTION fDemMrkt (des :Integer) :String;                    //< R/Int:  x.xDemo     NolaS.INC  1x
  PROCEDURE DemMrkt_(oh :Integer;  arvR :Real;  tab,des :Integer;  VAR S :String);
  FUNCTION fDemMrkt0(oh :Integer;  arvR :Real;  tab,des :Integer) :string;

  function MukanaOs  (CONST str1,str2 :string;  VAR os :integer) :boolean;   //<,,,Testaa isoilla kirj:lla onko mukana
  function Mukana (CONST sa,sb :string) :boolean;                                                //<+6.0.2
  function Mukan_1 (CONST sa,sb :string) :boolean;                                               //<+6.0.2
  function Iso (CONST str :string) :string; //<,,+1414e Muuttaa isoiksi kirjaimiksi.

  function SamIso (CONST str1,str2 :string) :boolean;                                            //<6.0.2 oli fSamAnsIso
  FUNCTION sRdim (merkitsevia :integer;  alpr :Real;  VAR Dim :string) :string; //<Strng ALPR:stä + dimensio 'm..T'
  {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,DOS: Pascal\Vakiot\LueavVakA.INC}
  FUNCTION RadToDeg (RadKulma :Real) :Real; //<Palauttaa RADIAALisen kulman ASTEperusteisena
  FUNCTION DegToRad (DegKulma :Real) :Real; //<Palauttaa ASTEperusteisen kulman RADIAALisena
  FUNCTION tang (kulma :Real) :Real;        //<Palauttaa TANGENTIN ASTEperusteisesta kulmasta
  FUNCTION arcTang (tang :Real) :Real;      //<Palauttaa TANGENTISTA KULMAN ASTEINA
  FUNCTION sini (kulma :Real) :Real;        //<Palauttaa SININ ASTEperusteisesta kulmasta
  FUNCTION cosi (kulma :Real) :Real;        //<Palauttaa COSININ ASTEperusteisesta kulmasta
  FUNCTION arcCosi (cosn :Real) :Real;      //<Palauttaa COSINISTA KULMAN ASTEINA
  {,,,,,,,,,,,,,,,,,,,Uuudet tietorakenteet}
  function fSokI (s :string) :integer;                     //+141.1
  function SokI (s :string;  VAR k :integer) :boolean;
  function SokR (s :string;  VAR RX :real): boolean;
  function SokB (CONST s :string;  VAR b :boolean) :boolean;
  function SokS (CONST s :string;  VAR ss :string): boolean;
//function fHaePolkuFilen (FileName :string) :string;        //<Siirrtty +yhdistty tänne 3´sta .INC´sta 12.0.05 . Ei enää käytössä -12.0.01/13å51  -130.0
  function TalInif (oha :integer;  AOfile :TInifile;   CONST sectionS,keyS :string;  s :string) :boolean;
  function LueTalInifVersio (oha :integer;  LUE :boolean;  AOfile :TInifile) :boolean;
  function LueInifAlkio (AoFile :TInifile;  CONST sectionS :string;  VAR alkio :arvoTyyp) :boolean;
  function TalInifAlkio (oha :integer;  AoFile :TInifile;  CONST sectionS :string;  alkio :arvoTyyp) :boolean;
  procedure TallErrInfo;
  procedure teePolkuDir (CONST Filen :string);
  function teePolkuDataFilen (oha :integer) :string;                                                       //<+1415f: Siirtty LueTalFilenReg´in sisältä.
  function LueTalFilenReg (OS :string; oha :integer;  LUE,KYSY :boolean;  VAR annettuFn :string) :boolean; //<+1415f: Lisätty OS.
  procedure tyhArvo (VAR alkio :arvoTyyp;  CONST nimi :string);
  function StrTarkSijAlkio (ArYrTark :boolean;  CONST stg :string;  VAR alkio :arvoTyyp): boolean;
  function SijSRajAlkio (CONST strg :string;  VAR alkio :arvoTyyp): boolean;
  function SijStrAlkio (CONST strg :string;  VAR alkio :arvoTyyp): boolean;
  procedure ohjelmavirhe(os :integer;  typ :integer;  c :char);
  function a_getIntg (os :integer;  alkio :arvoTyyp): integer;
  function a_getReaa (os :integer;  alkio :arvoTyyp): real;
  function a_getBool (os :integer;  alkio :arvoTyyp): boolean;
  function a_getStrg (os :integer;  alkio :arvoTyyp): string;
  function fOnArv (alkio :arvoTyyp): boolean;
  procedure a_putIntg (os :integer;  ii :integer;  VAR alkio :arvoTyyp);
  procedure a_putReaa (os :integer;  rr :real;     VAR alkio :arvoTyyp);
  procedure a_putBool (os :integer;  bb :boolean;  VAR alkio :arvoTyyp);
  procedure a_putStrg (os :integer;  CONST ss :string;   VAR alkio :arvoTyyp);
  {'''''''''''''''''''}
  function fSiTdsm (r :real;  d :integer) :desTyyppi;
  function fTdsm (alkio :arvoTyyp;  arvR :real) :integer;
  function fMrktRaj (alkio :arvoTyyp) :String;
  function fRmrktRaj (arvR :real;  alkio :arvoTyyp) :String;
  {'''''''''''''''''''}
  function pyor(r :real) :integer;
  function TagVexB_Ero ({CanvasOwner :TCanvas;  }SA :string;  VAR BoldPixEro :integer) :string; //+130.2e: Palauttaa Boldina olleiden erot normFonttiin verrattuna.
  function TagVex (SA:string) :string;                                                          // Tagit + Alku/LoppuTyhjät Vex

  function fKpix :real;
  function Y_fPixPit (CanvasOwner :TCanvas;  CONST Txt :String;  TxtFont :TFont) :Integer;
  function Y_fPixPitB(CanvasOwner :TCanvas;  CONST Txt :String;  TxtFont :TFont) :Integer;
  //Fontti:  1=PixCourier  2=PixMSsan  3=PixMSserif  4=PixTahoma  5=PixTimesNR
  function fMSpixPit (FontNo :integer;  str :string) :integer;                                    //<+120.45
  function otsikko (RivPit :integer;  CONST strg :string; _Font :TFont) :string;
  function Y_SamPitOikSuor (CONST malli,st1,st2 :string; CanvasOwner :TCanvas;  aFont :TFont) :string;
  procedure etsiStr (Rich :TRichEditNola;  ComBxy :TComboBoxXY);
  procedure LiitRpX_Phi_Str (eR,eX,PJ_Ik1v :real;  VAR RpX_s,Phi_s :string);
  procedure EdiStrGrSelect (VAR StrGr :TStringGridNola;  Sar1,SarV,Riv1,RivV :integer);
  function mmH1500(mmHeight :integer) :integer;            //<,120.6 koe KESKEN KESKEN
  function mmW2000(mmWidth  :integer) :integer;

  function Y_gLueTal_FileLista (os,oha :integer;  LUE,KYSY :boolean;   VAR aoFileN :string) :integer; //<1413: +Y_

//===============================================================================================================
implementation

uses  EdvNew, {Herja1, }{@=}Koe, Math,license, {LicenseFuncs,}            //<Herja1 vain väliaikaisesti =1x Kutsu
      {FileCtrl,} TextBaseTexts, Moot, PaaVal, {FileList -4.0.1}FileLstN, //Math ???=Vain Un :n (=fUv :n) takia ####
      Unit1{+6.0.0}, InfoDlgUnit{+6.2.2}, Syotto;
{$R *.DFM}

procedure Valivii (IniFN :string);      VAR LstU :TStringList;  sa :string;  i,u :integer;   begin //<,,+1415f
                       //,,+1415f: Lisätään välirivi ennen seur Sec -rviä.-----------------------
   LstU := TStringList.Create;                       //<,,+1415f: Jotta saadaan väliviivat "-----..." ennen seur väliOtsikkoa (Section).
   LstU.LoadFromFile(IniFN);
   u := LstU.Count-1;  i := u-1;                     //<Aloitetaan tokaVikalta riviltä jos vaikka vikalla olisi "[" alkuinen (Section -nimi).
   while (i>0)  do begin
      if (i>0) and (LstU[i+1]<>'')  then begin       //<Aloitetaan lopusta, koska väliin kasvatetaan väliMrkRvjä.
         sa := Trim(LstU[i+1]);                          //,Ettei tulisi 2 välirviä perääkäin, todettu.
         if (sa[1]='[') and (Pos('´´´', LstU[i])=0) then //,Eli [ Section -nimiRvn kohdalle ja Sec. siirtyy seur´ksi.
            LstU.Insert(i+1,'´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´'); //<Lisätää välirivi Sectionin loppuun =ennen  seur. Sec´n alkua.
      end;
      i := i-1;
   end;
   LstU.SaveToFile(IniFN);                         //<''+1415f.
   LstU.Free;
end;//Valivii

function fDTvexVainFN(str :string) :string;      VAR sx :string;  m :integer;   begin
   str := Trim(str);  sx := '';             //'+1414f: Poistaa mad. alussa olevat PV jaTIM-osuudet ja pal vain fileNimen.
   m := Pos(':\',str);
   if m>0
      then m := m-1 //<m-1 =LevyOsioTunnus
      else m := Pos('\\',str);
   if m>0  then
      sx := Copy(str,m,200);
   result := sx;
end;//fDTvexVainFN
{-1414fu:  Koodi siirretty tuohon kutsupaikkaan rv277.
procedure LoadFromFil_(VAR Lst :TStringList; fn :string);  begin //1414d: Oli tarkoitus korvata kaikki LoadFromFile -kutsut tällä, mutta n. 65 kutsua
   if xFileExists(fn) and (Lst<>nil)  then                       //         tuntui turhan työläältä vaihtaa tähän. Nyt vain 1 kutsu (FileEv.INC)
      Lst.LoadFromFile (fn);  end;}

procedure WBeepitN (krt :integer);   begin                       //<+1414d
   for krt := 1 to krt do
      WBeep([200,100, 0,200]);  end;

function StoSok_e5 (VAR SX :string) :boolean;       //£STR 130.2e: FNC KORJAA ja muokkaa SI´n str´ksi niin että 0.00001 ja pienemmät luvut näkyvät oikein, SokR
                                                    //     muokkaa ne esim. 9.8E-5 tms. PUD.VALIKOISSA STR NÄKYY SIIS halutunlaisena STRnä: 0.000098z .
   procedure tee (nro :integer;  SI,NAY___ :string);      LABEL 1;   VAR S,sA,sc,er,potS :string;  i,j,k,d,pot :integer;  c :char;  neg :boolean;
      function mrkOK (c :char) :boolean;       begin //<+130.2e      //<,SokR´ssäkin.
         result := (s<>'') and CharInSet(c,['0'..'9','.','-']);  end;
      function nroOK (c :char) :boolean;       begin //<+130.2e      //<,SokR´ssäkin.
         result := (s<>'') and CharInSet(c,['0'..'9','-']);  end;

      {procedure  wre(si :string);     begin end; {VAR f :TextFile;  fn :string;      begin //Erinomainen.
         fn := gAjoPath +'_Y,pas StoSok_e5.txt';      //C:\Projektit XE2\NolaKehi\BIN\..
         AssignFile(f,fn);
         if fFileExists (fn)
            then Append(f)
            else Rewrite(f);
         Writeln(f,DateTimeToStr(Now) +'  ' +si);
         Flush(f);
         Close(f);
      end;//}

   begin//StoSok_e5...............
      S := SI;
      sA := S;  //kerr := 1;             //<Debuggerille molemmat.  SA=Talteen debuggiin. NAY__ näkyy Local Variables´ssa.
//wre('1.SI=' +S);// +'  Sender: ' {+TComboBoxXY(Sender).Name +' => '} +ActiveControl.Name);
//,, Muokataan  xxEnn´stä 0.0000XX -muotoon, kun R < 0.0001..§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
   1: S := Trim(S);
      d := Pos(',',S);           // 12.0.0:  Globals.PAS´sa asetus (DecimalSeparator := '.').
      if d>0  then S[d] := '.';  //<Delphi / StrToFloatQ VAATII desimPISTEEN vaikka desErotin olisi ',' , muuten tulee herja.
      er := '';
      i := Pos('e',S);
      if i>0  then S[i]:= 'E';                        //<Jotta kohta vain "E" -testi ilman "e" -testiä.
//,,Del KAIKKI VÄÄRÄT mrkt.§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
      i := Pos(' ',S);
      if i>0  then
         Delete(S,i,99);                    //<Delataan tyhjästä eteenp se ml.
//wre('2.S=' +S);
      i := 1;                                         //,§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
      while (i<=Length(S))  do begin                  //,§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
         c := S[i];  //j := Length(S);                //,§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
         if NOT mrkOK(c) and                          //,"9,8E-5000"sta ei vielä saa hävittää, koska kohta sitä etsitään.
            (Pos('E-',S)=0) and (Pos('E+',S)=0)        //<"9,8E-05"  "-9,8e-05"  (0.00001 = 1e-05)   (0.00000100 = 1E-6)
         then begin                                   //,§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
              er := er +S[i];                         //< ============================== Kerätään poistetut mrkt ER-mrkJonoksi.==============================
              Delete(S,i,1);  end //< i säilyy.       //'§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
         else begin                                   //'§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
              i := i+1;                               //< ============================== Kerätään OK-mrkt aukkoina.==========================================
              er := er +' ';  end;                    //'§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
      end;//while
      S := Trim(S);
//wre('3.S=' +S);
//,Väärät alkunollat vex: 01.=>1.  012=>12 §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
    //i := 1;
      while (Length(S)>1) AND (S[1]='0') AND (S[2]<>'.')  //<Tai: while (Length(S)>1) and (S[1]='0')  and (S[2]='0')  do Delete(S,2,1);
         do Delete(S,1,1);

//..Tutkitaan "-"etumerkki §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
      neg := (S<>'') and (S[1]='-');
      if neg  then Delete(S,1,1);                     //<Delataan "-", lopussa palautetaan.
      d := Pos('.',S);                                //<Äsken muutettiin pisteeksi.
      if d=1  then S := '0' +S;                       //<.xxzz => 0.xxzz  =Lisätään alkuun "0" .
//..Muokataan xxE.. =Scientific -muotoinen normaaliksi desimLuvuksi 0.000..§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
      k := Pos('E',S);
      if k=0  then k := Pos('e',S);                   //<,,Tämä muotohan tulee (NOLAssa) vain kun hyvin pieni luku (<0.0001), joten "-" exponja.
//wre('4.S=' +S);
      if k>0  then begin                              //<,,9.8E-5000 muutetaan realiStr´ksi 0.000098
         i := Length(S);
         while (i>0) and (S[i]='0')  do begin         //<Delataan loppunollat xE-5000 => xE-5 (tai xE+5)
            Delete(S,i,1);                            //<Kunnes i pysähtyy osoittamaan exponenttiNroa 5 (tms).
            i := i-1;  end;

         i := Length(S)+1;  potS := '';               //<,,Tutkitaan exponentti (pot).  CharInSet(c,['0'..'9','-']);
         repeat i := i-1;
                if CharInSet(S[i], ['0'..'9'])
                then begin
                   potS := S[i] +potS;
                   Delete(S,i,1);  end;
         until (S<>'') and (i={0}1) or (S[i]='E');    //<1414d: 0 => 1 ja S<>''
        {if S[i]='-'  then j := -1                    //<,Näitä ei nyt jälempnäkään ole käytetty =Oletus, että luku on aina <1 (pienempi kuin1)
                      else j := 1; //<"+"}
         Delete(S,Length(S),1);
         if (S<>'') and (S[Length(S)]='E')            //<1414d: +S<>''
            then Delete(S,Length(S),1);               //<Nyt enää jäljellä vain mantissaosa "98".
         //i := Length(potS);
         //pot := Ord(S[i])-48;                       //Exp =Ord(Chr)-30 = 1..9, oletus: Exp<10 .
         pot := StrToInt(potS);
//wre('5.S=' +S +'  pot=' +potS);

         d := Pos('.',S);
         Delete(S,d,1);                               //<Delataa desimErotn.
         sc := '0.';
         for i := 1 to pot-1  do
            sc := sc +'0';                            //<Kunnes S[i]="E" tai "e"
         S := sc +S;                                  //<"0.0000" + "98" => "0.000098"
      end;//if k>0
//'xxE -muokkaus §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
      k := 1;  j := 0;                                //,,TUTKITAAN onko useampia desimErottimia.§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//wre('6.S=' +S);
      while (k<=Length(S)) and mrkOK(S[k])  do begin  //<+130.2e:  "-" lisätty.
         if (S[k]='.') or (S[k]=',')
            then j := j+1;
         k := k+1;  end;
      if j>1  then begin
         InputBox('Y_.PAS/SokR: Desim.erottimia ' +Ints(j) +':', 'Korjaa:',S);
         GOTO 1;  end; //_____________________________Tässä pyöritään kunnes muutettu S kelvolliseksi_____________________________________
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
      j := Pos(' ',S);
      if j>0  then
         Delete(S,j,99);                              //<Jo ed´stä jäi numerojakin jäljelle, välissä lienee tyhjä, josta eteenp. delataan se ml.
 //,,POISTETAAN lopusta turhat 0´t.§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
      d := Pos('.',S);
      if (d>0)  then begin                            //'Alussa jo sijoitettu pilkun paikalle piste:.
         i := Length(S);       //for i := Length(S) DownTo 1  do begin
         repeat if (i=Length(S)) and ((S[i]='0') or (S[i]='.'))
                   then begin
                      Delete(S,i,1);                //<'Loppunollat ja loppuDesErotin vex.   0.1000 => 0.1  ;  1.000 => 1
                      i := i-1;  end;
         until (i=d-1) or (S[i]<>'0') and (S[i]<>'.');
      end;
{//,,Poistetaan liiat alkuNollat.§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
      while (Length(S)>1) and (S[1]='0')  and (S[2]='0')  do                                       //< +4.0.0
         Delete (S,2,1);                              //<Desim.pilkun eteen hyväksytään vain 1 kpl NOLLIA}


      while (Length(S)>1) and (S[1]='0') and
            CharInSet(S[2],['1'..'9'])                //<,0 alussa ei sallittu, jos seur on arvonumero, eka delataan.
         do Delete(S,1,1);

      if (S='0')
         then neg := false;
      if neg  then                                    //,,Edellä testattu ja korjattu väärät 1.mrkt ("."=>"0.", "a"..)<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
         S := '-' +S;                                 //<Jotta S=poNAY (eikä herjapiippejä)
    //er := 'Alp: "' +sA +'" | Poistetut mrkt: "' +er +'" | nyt OK: "' +S +'"'; //<Koklattu ShowMessage, MessageDlg, InfoDlg;  Ei onaa, kaikilla AINA:
      er := Trim(er);                                                           // "Debugger Exeption ..EAccess Violation..". Tydyttävä debugin editiin.
      result := er='';
      SX := S;
   end;//tee

begin//StoSok_e5......
  {tee( 1,'9,8E-5000'     , '0.000098' );
   tee( 2,'9.8E-5000'     , '0.000098' );
  {tee( 3,'a1234a'        , '1234'    );
   tee( 4,'1234a'         , '1234'    );
   tee( 5,'a0012b3,45600a', '123.456'  ); //<,,Eka nro vain helpottaa debug´ssa näkemään, mikä alp kokeilurv on kyseessä.
   tee( 6,'a123,456a'     , '123.456'  );
   tee( 7,'a 123.456 a'   , '123.456'  );
   tee( 8,'-.00098'       , '-0.00098' );
   tee( 9,'-0.00098'      , '-0.00098' );
   tee(10,'0,00009800'    , '0,000098' ); //<,Minimi reaaliarvo desimMuodossa =0.0001,  0.00001 Delphi näyttää 0.1E-4  JUURI scientific -muodon muuttaminen
   tee(11,'-0.00009800'   , '-0,000098'); //  on tämän FNC´n tarkoitus.
   tee(12,'0,00098'       , '0,00098'  );
   tee(13,'0.0009800'     , '0.00098'  );
   tee(14,'0,0009800'     , '0,00098'  );
   tee(15,'0.0098'        , '0.0098'   );
   tee(16,'0,0098'        , '0,0098'   );
   tee(17,'123,000'       , '123'      );
   tee(18,'5,0'           , '5'        );
   tee(19,'1,000'         , '1'        );
   tee(20,'-1,000'        , '-1'       );
   tee(21,'0,1000'        , '0,1'      );
   tee(22,'0,1'           , '0,1'      );
   tee(23,'1'             , '1'        );  //}
  {Tee(23, '1.234',  '1,234');
   Tee(24, '3.5',    '3,5');
   beep;}
  {Tee(1, '3.5abc',    '3,5');
   Tee(2, '3,5abc',    '3,5');}

   tee (0,SX,'');
end;//StoSok_e5

function RtoS_e5 (RX :real) :string;      VAR S :string; //£STR. 130.2e:  FNC muokkaa RX´n str´ksi niin että 0.00001 ja pienemmät luvut näkyvät oikein, SokR
                                                         //      muokkaa de esim. 9.8E-5 tms. PUD.VALIKOISSA STR NÄKYY SIIS halutunlaisena STRnä: 0.000098 .
   procedure tee(nro :integer;  ri :real;  NAY :string);      begin
      s := FloatToStr(ri);
      StoSok_e5(s);                                     //130.2e: FNC KORJAA ja muokkaa S´n str´ksi niin että 0.00001 ja pienemmät luvut näkyvät oikein, SokR
                                                     //      muokkaa ne esim. 9.8E-5 tms. PUD.VALIKOISSA STR NÄKYY SIIS halutunlaisena STRnä: 0.000098 .
{,,TOIMIVA kerroin -tekijän osa, muttei tässä nyt tarvittu, TESTATTU. KERROIN: Kun rmuutettu S´ksi, on ehkä jouduttu muuntamaan S 1/1000 pienemmäksi, jottei
      d := Pos('.',s);                               // RI muuttuisi scientific -muotoon. Jos >1, tunnustetaan esim. milliOhmeiski.
      n := Length(s);                                //'<d kylläkin edelleen voimassa.
      k := 0;
      if (s='0.') or (s='0')
      then neg := false
      else begin
         if (s[1]='0') and (s[2]='.') and (n>2)      //<Minimi s= "0.x"
         then for i := 3 to n do
            if s[i]<>'0'  then begin
               k := i;               //   d=2 k=6  k-d=6-2 =4
               j := k-d;             //< 0.000098    mja ennen "9"tä =6 =i-1 .
               if j>=5  then begin   //<,,AR olisi niin pieni että tulisi Err, pienennetään 1/1000´lla.
                  kerr := 1000;
                  Insert('.',s,d+j-1);
                  Delete(s,1,d+j-3);
               end;
               Break;
            end;//if S[i]
      end;//else}
    //if neg  then S := '-' +S;
      if S<>''  then ;
   end;//tee

begin//RtoS_e5...........................
  {tee( 1,  -0.00098       , '-0.00098' ); //<,,Eka nro vain helpottaa debug´ssa näkemään, mikä alp kokeilurv on kyseessä.
   tee( 2,  0.00009800     , '9,8e-05'  ); //<,Minimi reaaliarvo desimMuodossa =0.0001 .
   tee( 3,  -0.00009800    , '-9,8e-05' );
   tee( 4,  0.00098        , '0,00098'  );
   tee( 5,  0.0009800      , '0.00098'  );
   tee( 6,  0.0009800      , '0,00098'  );
   tee(17,  0.0098         , '0.0098'   );
   tee(18,  0.0098         , '0,0098'   );
   tee(19,  123.000        , '123'      );
   tee(10,  5.0            , '5'        );
   tee(11,  1.000          , '1'        );
   tee(12,  -1.000         , '-1'       );
   tee(13,  0.1000         , '0,1'      );
   tee(14,  0.1            , '0,1'      );
   tee(15,  1              , '1'        );  //}
  {Tee(16,  1.234,  '1,234');
   Tee(17,  3.5,    '3,5');//}

   tee(0,RX,'');
   result := S;
end;//RtoS_e5
                                                                  //Vain Settings.PAS´issa olevat StrToFloat muuttamatta StrToFloatQ´ksi.
function StrToFloatQ (S :string) :Extended;     VAR ur :Extended; //<£STR +130.2e  Täysin uusi.  +12.0.04 Täysin uusi.
   //'Oli StrToFloatQ_         //,NAY___ näkyy debuggerin Local Variable´ssa =AR pitää näyttää tältä.
      function mrkOK (c :char) :boolean;       begin //<+130.2e      //<,SokR´ssäkin.
         result := (s<>'') and CharInSet(c,['0'..'9', ',', '.', '-']);  end;
   procedure tee(nro :integer;  S,NAY___ :string;  VAR ar :Extended);      VAR sA :string;  {kerr}i :integer;  neg :boolean;      begin
        {if isDebuggerPresent  then
            Wbeep([500,100, 0,200, 2000,100]);}
      sA := S;
      S := Trim(S);
      neg := (S<>'') and (S[1]='-');
      i := Length(S);
      while (i>0) and NOT mrkOK(S[i])  do begin
         beep;  i := i-1;  end;
      StoSok_e5 (S);          //<Korjaa aakkoset vex reaaliluvusta yms.
      try
        {if isDebuggerPresent  then
            Wbeep([500,100, 0,500, 2000,100]);}
         ar := StrToFloat (S);       //FloatToStrF(amount1, ffExponent, arvoA,DES);
      except
         on EConvertError  do
          //ShowMessage ('Virheellinen merkkijono luvuksi:  [' +s +']'); //Kuitenkin heittää oman herjan, ei tätä.  130.2e: Debugissa ei OK, mutta norm ajo OK.
            InputBox('Virheellinen merkkijono luvuksi:','Luku talteen:',s);
      end;
      if neg and (ar>0)  then ar := -1*ar;
    //ar := ar/kerr;            //<''DesErottimen paikkaa muutettiin S'ssä oikealle niin, että luku suureni KERR´lla, nyt korjataan takas.
      if ar<0  then ;
   end;//tee

begin//StrToFloatQ ...............Oli StrToFloatQ_
  {tee (1,'a0012b3,45600a', '123.456' ,ur ); //<,,Eka nro vain helpottaa debug´ssa näkemään, mikä alp kokeilurv on kyseessä.
   tee (2,'a123,456a'     , '123.456' ,ur );
   tee (3,'a 123.456 a'   , '123.456' ,ur );
   tee (4,'-.00098'       , '-0.00098',ur );
   tee (5,'-0.00098'      , '-0.00098',ur );
   tee (6,'0,00009800'    , '9,8e-05' ,ur ); //<,Minimi reaaliarvo desimMuodossa =0.0001 .
   tee (7,'-0.00009800'   , '-9,8e-05',ur );
   tee (8,'0,00098'       , '0,00098' ,ur );
   tee (9,'0.0009800'     , '0.00098' ,ur );
   tee(10,'0,0009800'     , '0,00098' ,ur );
   tee(11,'0.0098'        , '0.0098'  ,ur );
   tee(12,'0,0098'        , '0,0098'  ,ur );
   tee(13,'123,000'       , '123'     ,ur );
   tee(14,'5,0'           , '5'       ,ur );
   tee(15,'1,000'         , '1'       ,ur );
   tee(16,'-1,000'        , '-1'      ,ur );
   tee(17,'0,1000'        , '0,1'     ,ur );
   tee(18,'0,1'           , '0,1'     ,ur );
   tee(19,'1'             , '1'       ,ur );  //}
  {Tee(20, '1.234',  '1,234', ur);
   Tee(21, '3.5',    '3,5', ur);
   beep;}

     tee(0,s,'',ur);
     result := ur;
end;//StrToFloatQ Oli StrToFloatQ_

procedure tyP;      begin end; //<+8.0.3 Tyhjä PRC korvaamaan if ... then Beep => tyP

function fHandleFN(TheFileName: string) :integer;      VAR Hnd: integer;      begin
//Google:  dlphi xe2 FileGetDate FileAge
//http://www.delphipraxis.net/159976-fehler-bei-filedatetodatetime-filegetdate-fhandle-wenn-dateidatum-1980-a.html
  Hnd := FileOpen(TheFileName, 0);
  result := Hnd;
end;
function DateTimeToFileTime(FileTime: TDateTime): TFileTime; //120.6: Ks. C:\Projektit_YLE =====\Delphi-Vihjeet\FileAge\FileTimesReplace.txt
var
  LocalFileTime, Ft: TFileTime;
  SystemTime: TSystemTime;
begin
  Result.dwLowDateTime  := 0;
  Result.dwHighDateTime := 0;
  DateTimeToSystemTime(FileTime, SystemTime);
  SystemTimeToFileTime(SystemTime, LocalFileTime);
  LocalFileTimeToFileTime(LocalFileTime, Ft);
  Result := Ft;
end;//DateTimeToFileTime

//,,1414 DEVELOPER1:  Antaa samat arvot kuin fGetAika (=ALP). Uudempi (Avuste.INC) livahti ohi, aikaeroa ei huomannut koska TIM oli joskus komment vex.
//http://stackoverflow.com/questions/144453/how-to-get-create-last-modified-dates-of-a-file-in-delphi  <,,+1414,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
(*function DSiFileTimeToDateTime(fileTime: TFileTime; var dateTime: TDateTime): boolean;
var
  sysTime: TSystemTime;
begin
  Result := FileTimeToSystemTime(fileTime, sysTime);
  if Result then
    dateTime := SystemTimeToDateTime(sysTime);
end; { DSiFileTimeToDateTime }

function  DSiGetFileTimes(const fileName: string; var creationTime, lastAccessTime,
  lastModificationTime: TDateTime): boolean;
var
  fileHandle            : cardinal;
  fsCreationTime        : TFileTime;
  fsLastAccessTime      : TFileTime;
  fsLastModificationTime: TFileTime;
begin
  Result := false;
  fileHandle := CreateFile(PChar(fileName), GENERIC_READ, FILE_SHARE_READ, nil,
    OPEN_EXISTING, 0, 0);
  if fileHandle <> INVALID_HANDLE_VALUE then try
    Result :=
      GetFileTime(fileHandle, @fsCreationTime, @fsLastAccessTime,
         @fsLastModificationTime) and
      DSiFileTimeToDateTime(fsCreationTime, creationTime) and
      DSiFileTimeToDateTime(fsLastAccessTime, lastAccessTime) and
      DSiFileTimeToDateTime(fsLastModificationTime, lastModificationTime);
  finally
    CloseHandle(fileHandle);
  end;
end; { DSiGetFileTimes }


  (*function fGetAika(FileName :string) :integer;      VAR hnd :THandle;      begin //120.5h Tiedoston luontiaika. (oiskohan myös muutosaika?)
   hnd := fHandleFN(FileName);               //<+1202.
   result := FileGetDate (hnd);              //<12.0.2: FileAge=Deprecated => Y_.PAS
  {result := DatTim<>-1;  }end;              //<-120.6  Tämä kun fnc oli boolean.*)

(*function fGetAikaU(FileName :string;  VAR ModifiedDate :TDateTime) :boolean; //<1414 DEVELOPER1:  Antanee samat arvot kuin fGetAika (=ALP).
{Microsoft / GetFileTime function
BOOL WINAPI GetFileTime(
  _In_      HANDLE     hFile,
  _Out_opt_ LPFILETIME lpCreationTime,
  _Out_opt_ LPFILETIME lpLastAccessTime,
  _Out_opt_ LPFILETIME lpLastWriteTime
);}
var
  hnd :Integer;                                          //<DEVELOPER1:  h=>hnd
  st: TSystemTime;
  dCr, dAc, dMod: TFileTime;
  //function findfirst ( const FileMask : string; Attributes : Integer; var SearchResult : TSearchRec ) : Integer;
  //Aika1 := FileTime2DateTime (DateTimeToStr(req.dLuotu));
    reQ :TSearchRec;
    dt, t2,t3: TDateTime;  //ft :TFileTime{1414};
     y, d, m, h, min, sec, msec: word;
//CreatedDate, {ModifiedDate, }AccessedDate: TDateTime;  //<120.6: Modif.. sisällytin palautusarvoksi.  Never used.
begin                                                    //Em (120.5h versio varasi ao. filen ettei sitä voinut lukea toisaalla, syy :CloseHandle puuttui.
  Result := True;
//DSiGetFileTimes(const fileName: string; VAR creationTime, lastAccessTime, lastModificationTime: TDateTime): boolean;
  DSiGetFileTimes( fileName, dt,t2,t3);

  hnd := CreateFile(PChar(FileName), Generic_Read, 0, nil, Open_Existing,
         File_Attribute_Normal, 0);
  if hnd = -1 then
  begin
    Result := False;
    Exit;
  end;
  try
     if dt<0  then ;
     if t2<0  then ;
     if t3<0  then ;

     if FindFirst(FileName, faAnyFile, reQ) = 0  then begin
      //ModifiedDate := DateTimeToStr(reQ.ftLastWriteTime));
      //ModifiedDate := FileDateToDateTime(reQ.time);
     dt := fileDateToDateTime(reQ.time);
     decodeDate( dt, y, d, m );
     decodeTime( dt, h, min, sec, msec );
     if d<0  then ;
     dt := fileDateToDateTime(reQ.time);
     if dt<0  then ;
    end;
'''''''''''*)
(*
   Ero := ii-EdTime;               //si := DateTimeToStr (FileDateToDateTime (FileAge(nm))); //<YhtLsk.PAS
                                   //System.DateUtils.SecondsBetween(Now, FileDateToDateTime (FileAge(nm))); //AThen: TDateTime): Int64;
               DecodeTime(FileDateToDateTime(onf), Hour,Min,Sec,MSec);
if FileDateToDateTime (i)< StrToDate ('2002/1/1')  then


 GetFileTime(hnd, @dCr, @dAc, @dMod);
    // Date created
    FileTimeToLocalFileTime(dCr, dCr);
    FileTimeToSystemTime(dCr, st);
  //CreatedDate := SystemTimeToDateTime(st); //120.6:  Never used.

    // Date accessed
    FileTimeToLocalFileTime(dAc, dAc);
    FileTimeToSystemTime(dAc, st);
  //AccessedDate := SystemTimeToDateTime(st); //120.6:  Never used.

    // Date modified
    FileTimeToLocalFileTime(dMod, dMod);
    FileTimeToSystemTime(dMod, st);
    ModifiedDate := SystemTimeToDateTime(st);   //TFileTime to TSystemTime ??? FileDateToDateTime  DateTimeToFileDate
  //ModifiedDate := DateTimeToFileDate(st)
  //ModifiedDate := st;
  //ModifiedDate := DateTimeToFileTime({st}dMod);
*)
(*finally
    CloseHandle(hnd);
  end;
end;//fGetAika*)

function fGetAika(FileName :string;  VAR ModifiedDate :TDateTime) :boolean; //<120.6 DEVELOPER1
var
  hnd :Integer;                                          //<DEVELOPER1:  h=>hnd
  st: TSystemTime;
  dCr, dAc, dMod: TFileTime;
//CreatedDate, {ModifiedDate, }AccessedDate: TDateTime;  //<120.6: Modif.. sisällytin palautusarvoksi.  Never used.
begin                                                    //Em (120.5h versio varasi ao. filen ettei sitä voinut lukea toisaalla, syy :CloseHandle puuttui.
  Result := True;
  hnd := CreateFile(PChar(FileName), Generic_Read, 0, nil, Open_Existing,
         File_Attribute_Normal, 0);
  if hnd = -1 then
  begin
    Result := False;
    Exit;
  end;
  try
    GetFileTime(hnd, @dCr, @dAc, @dMod);
    // Date created
    FileTimeToLocalFileTime(dCr, dCr);
    FileTimeToSystemTime(dCr, st);
  //CreatedDate := SystemTimeToDateTime(st); //120.6:  Never used.

    // Date accessed
    FileTimeToLocalFileTime(dAc, dAc);
    FileTimeToSystemTime(dAc, st);
  //AccessedDate := SystemTimeToDateTime(st); //120.6:  Never used.

    // Date modified
    FileTimeToLocalFileTime(dMod, dMod);
    FileTimeToSystemTime(dMod, st);
    ModifiedDate := SystemTimeToDateTime(st);   //TFileTime to TSystemTime ??? FileDateToDateTime  DateTimeToFileDate
  //ModifiedDate := DateTimeToFileDate(st)
  //ModifiedDate := st;
  //ModifiedDate := DateTimeToFileTime({st}dMod);

  finally
    CloseHandle(hnd);
  end;
end;//fGetAika

function Rounder(var Value: {Double}real;  Decimals: Integer): Double;      VAR j: Integer;  A: Double;      begin
//http://www.delphitricks.com/source-code/math/round_numbers_to_a_predetermined_number_of_decimals.html  +12.0.0=12å8
//Category: Math   Title: Round numbers to a predetermined number of decimals.
   A := 1;
   case Decimals of
      0: A := 1;
      1: A := 10;
   else
      for j := 1 to Decimals do
         A := A * 10;
   end;                                         //,(1.345,6,2) pitäisi => 1.35-- mutta tulee 1.34 !!!!
 //Result := {Int}Trunc((Value * A) + 0.5) / A; //< =1.345*100 +0.5 =134.5 +0.5 =135.0 => 1.35
   Result := Value *A;                          //< =>1.345*10  =13.45
   Result := Result + 0.5;                      //< =>13.45+0.5 =13.95
   Result := Int(Result) / A;                   //< =>Int(13.95/10) =1
end;
//===============================================================================================================
function PROGRAM_VERSIO_STRING :string;      begin
   result := IntToStr(PROGRAM_VERSION_MAJOR) +'.' +IntToStr(PROGRAM_VERSION_MINOR) +'.' +
             IntToStr(PROGRAM_VERSION_RELEASE);
end;
//===============================================================================================================
(*function OnPvitysEstoListassa :boolean;      VAR i :integer;      begin //<,+6.0.0  Vex 12.0.03 on Y_.INC´ssä.
...
end;*)

{$I '..\Globals\Y_.INC'}                 //<Lisenssin demo- ja testirutiinit +8.0.7

function fKaikkiOikeudet_1x :Boolean;      var s,sx :string;

   function fErikLupa (sao :string) :boolean;      VAR si,su :string;  i :integer;  Lst :TStringList;      begin
      Lst := TStringList.Create;
      si := Trim (AnsiUpperCase (ValiaikKaikkiOik)); //= "KARIPESSI" "ÄIKÄOIKA"
      su := '';
      while si<>''  do
      if si[1]=' '
      then begin
         Lst.Add (su);
         su := '';
         si := Trim (si);  end
      else begin
         su := su +si[1];
         Delete (si,1,1);      //<Delataan eka.
         if Trim (si)=''
            then Lst.Add (su);
      end;

      result := false;
      sao := Trim (AnsiUpperCase (sao));
    //sao := 'KARIPESSI';                              //<VAIN TESTIIN, workkii OK.
      for i := 0 to Lst.Count-1  do begin              //<,,Tätä helpompi debugata.
          si := Trim (AnsiUpperCase (Lst.Strings[i]));
          if si=sao  then begin
             result := true;  Break;  end;//}
      end;
     {if Lst.IndexOf (sao) >-1                         //<,Tämä OK, testattu.
         then result := true;}
      Lst.free
   end;

begin //<,2.0.x
   result := false;                           //<,,Pitäisköhän rajoittaa YksittOikeuteen, entäSitten LICENSE.NOS?
   s := AnsiUpperCase (AsetusFrm.SalaEdi.Text); //< Salasana piilotetussa EditBoxissa
   sx := Trim (s);
   if (Length (s)>=5)  and
      (Ord(s[1])=78) and (Ord(s[2])=65) and     //< 'NAROI' = N=78, A=65, R=82, O=79, I=73
      (Ord(s[3])=82) and (Ord(s[4])=79) and (Ord(s[5])=73)
   OR fErikLupa (sx)                                      //<+10.0.3:  "KARIPESSI"
   then                 //'#########
      result := true;   //'#########
   if NOT result  then result := (KaikkiOikDirN<>'') and
                                 fDirectoryExists (KaikkiOikDirN); //<+11.0.0:  Sallii kaikki ajot täyslaajuudella,
end;//fKaikkiOikeudet_1x //'#########                                     //  jos vain KaikkiOikDirN<>'' ja se DIRri löytyy.
                         //'#########                                     //'Kommenttitäsmennys +11.0.1 . Tämä myös PaaVal.PAS/Tutki
{ DEVELOPER2 20040328, poistettu tarpeettomina
function PROajo :Boolean;      begin //<,2.0.x
   result := false;
   if myLicense.lisenssilaajuus = lvPro  then //< 0=VasenBtn=PRO(oletus)  1=OikeaBtn=LT
      result := true;
end;
function LTajo :Boolean;      begin //<,2.0.x
   result := true;
   if PROajo  then
      result := false;
end;

function SetProLT :Boolean;      begin //<,2.0.x  Kutsutaan Aseta.PAS :sta
   if (myLicense.lisenssilaajuus = lvPro)  and //<Ehkä tarpeeton: tätähän kutsutaan, kun clickataan PRO -valintaa
      (LisAsennettu and
       //(mylicense.status IN [lsPROversio])
       (66>55))                                   //<Korvaa ''':n =lsPROversio
      or Demo
   then
      result := true                              //<Jos PRO-lisenssi tai Demo, sallitaan PROajo
   else begin                                     //<Lisensoitu LT-versiolle eikä ole Demö -> muutetaan
      result := false;                            //'takas LT-versioksi
      AsetusFrm.ProLtGrp.ItemIndex := 1;  end;    //< 0=VasenBtn=PRO(oletus)  1=OikeaBtn=LT
end;
}
function LisAsennettu: Boolean;
begin
//result := false;          //<+120.5n:  LisAsennettu Might not have been initz.
// DEVELOPER2 2003-10-26 BEGIN
{$IFNDEF NOLALIS}
    result := mylicense.IsLicenseInstalled;
{$ENDIF NOLALIS}
    // DEVELOPER2 2003-10-26 END
end;

function Y_esittelyEhto :Boolean;   begin //,LisYliDemo_ +7.0.1
   if (demo(1) OR LisYliDemo_ (lvPRO)) and  (tuxV IN [1,4])   then Result := true   else Result := false;  end;

procedure Y_Koe(oh :integer;  S :string);{@}      begin
  KoeWInfoA (oh,S);                  //,Jos oli (KoeFrm:n)JATbtn -näppäilyä edellyttävä, asetetaan
//if oh<2  then KoeInfo (0,S);         //<nyt näkyviin, jotta vanha viesti (S) pysyisi näkyvissä
end;//''2=Ei avata enää jatkuvaa seurantaikkunaa

procedure WBeep(arrI :array of integer);     VAR nn,i :integer;      begin //10.0.4  Ks. mm. Syotto.PAS
      //Windows.Beep (500,100);
      //WBeep([500,100, 2000,200]); => ari[0]=500Hz  ari[1]=100ms jne. ... rajattomasti.
   nn := {High}Length (arrI);
   for i := 0 to nn  do
   if i<=nn  then
      //Windows.Beep (arrI[i],arrI[i+1]);
      if Odd(i)  then //<0=parillinen.                                    //<,+120.5n/6
         Windows.Beep (arrI[i-1],arrI[i]); //'''''''''''''''''''''''''''''edVersio*)
end;//Wbeep
{procedure SetVoice (vol :integer);   VAR MyWaveOutCaps: TWaveOutCaps;   begin //http://delphiexamples.com/others/setsoundvolume.html
      //Volume := Scrollbar1.Position;  //'Äänenvoimakkuusasetus ei worki.
      if WaveOutGetDevCaps(
         WAVE_MAPPER,
         @MyWaveOutCaps,
         sizeof(MyWaveOutCaps))=MMSYSERR_NOERROR then
            WaveOutSetVolume(WAVE_MAPPER, MakeLong(vol,vol));
end;}
procedure Y_piipit (krt :integer);      var i :integer;      begin
  //ZS_Frm.Timer1.Enabled := true;     //<Ei worki.    Windows.Beep (500,500); =500 Hz, 500 ms =workkii, todettu.
  //if krt>100  then krt := 100;
  i := 0;
  while i<krt  do
    {ZS_Frm.Timer1.OnTimer. = 5  then}
    begin i := i+1;   SysUtils.Beep;  end; //<+10.0.4  SysUtils lisätty vaikkei ollut ongelmia.
  //ZS_Frm.Timer1.Enabled := false;    //<Ei worki
  if IsDebuggerPresent  then Windows.Beep (500,500); //=500 Hz, 500 ms =workkii, todettu. +10.0.7
end;

function Y_piip :boolean;      begin
  Y_piipit (500);   result := false;   end;

procedure erPiip;      begin
   if Defs_KoeAjo               //< +4.0.0
      then Y_piipit (70)
      else Y_piipit (2);  end;

procedure EiOKinfo (CONST s :string);      begin
  if IsDebuggerPresent  then
     PaaValFrm.Caption := 'Debug: Y_.pas/EiOKinfo beep;'; //<+12.0.0
  Beep;  //MessageDlg (s, mtInformation, [mbOk], 0);
         InfoDlg (s, mtCustom, 'OK','','','',  '','','','');  end;
//if MessageDlg (s, mtInformation, [mbYes,mbNo], 0) = mrYes;  end;

procedure TY_DemoFrm.OKBtnClick(Sender: TObject);
begin
  //Close; -1413
  Hide;   //1413
end;
procedure Y_DemoInfo(CONST S :string);   begin
//Messagebeep (0);           //< =Beep(Freq,Dura); W95:ssä ei käytössä  -4.0.1
//Beep;
  EiOkInfo (S);
{---------------------------------------------- Korvattu väliaikaisesti EiOKinfo -kutsulla----------
  Y_DemoFrm.HerjaLbl.Alignment := taCenter;
  Y_DemoFrm.Timer1.Enabled := true;
  if s=''  then begin
              //Y_DemoFrm.Timer1.Interval := 2500;
                Y_DemoFrm.DemoLbl.Caption := 'D E M O V E R S I O N';
                Y_DemoFrm.HerjaLbl.Top := 40;
                Y_DemoFrm.HerjaLbl.Caption := 'Toiminta ei käytössä';
                Y_DemoFrm.Show;
                Y_DemoFrm.Timer1.Interval := 2500;  end
           else begin
              //Y_DemoFrm.Timer1.Interval := 4000;
                Y_DemoFrm.DemoLbl.Caption := '';
                Y_DemoFrm.HerjaLbl.Top := 25;
                Y_DemoFrm.HerjaLbl.Caption := S;
                Y_DemoFrm.Show;
                Y_DemoFrm.Timer1.Interval := 4000;  end; a-----------------------------------------}
end;

procedure TY_DemoFrm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#27  then begin
     Y_DemoFrm.Timer1.Enabled := false;
     Close;  end; {<Properties/KeyPreview po TRUE}
end;

procedure TY_DemoFrm.Timer1Timer(Sender: TObject);
begin
  Y_DemoFrm.Timer1.Enabled := false;
  Close;   //<Sulkee herjaikkunan INTERVALlin jälkeen = 4s
end;

procedure TY_DemoFrm.FormClick(Sender: TObject);
begin
  Y_DemoFrm.Timer1.Enabled := false;
  Close;
end;

//--------------------------------------------------------------------------------------------------
FUNCTION fEmtyS (CONST s :string) :boolean;      var i :integer;   begin //<TRUE, jos s='' tai s='     '
   Result := false;
   if s='' then Result := true
           else for i := 1 to Length (s)  do
                if (s<>'') and (s[i]<>' ')  then break; //<1414d: +(s<>'')
END;
//==================================================================================================
         //,FNC fDsm palauttaa desimLukumäärän RAJD:n ja DESD:n mukaan siten, että R:n YLITTÄESSÄ RAJR:n,
         // D(desLkm) PIENENEE, siihen asti D = DESD (=rajD:n mukainen desD) !!!!!!!!!!!!!!!!!!!!!!!
         //,Esim. r,100,2 = 99.999 :aan asti 2 desimaalia, isommilla 1 desim. !!! <<<<<<<<<<<<<<<<<<
         //,######################################################################################################
         //,################################### Ks. kokeilu EdvNewLask.PAS #######################################
         //,######################################################################################################
//,,maxD=maxDesLkm  kun R<=rajR(maxArvo) => maxD(=maxDesLkm), ISOMMILLA DES pienenee (-1) per dekadi.
function fDsm (r,rajR :real;  maxD :integer) :integer;      VAR d :integer; //rajR=rArvo minkä
//FNC fDsm palauttaa desimLkm´n esim. fRmrkt0(r,tab,des) -kutsuun tms.
   procedure DsmFileen(si :string);     begin end;{VAR ff :TextFile;  nm,su :string;      begin//+130.3b
      nm := IncludeTrailingPathDelimiter (ExtractFilePath(Application.ExeName));
      nm := ChangeFileExt(nm,'_YDsm.TXT');                    //<nm= C:\Projektit XE2\NolaKehi\BIN\_YDsm.TXT
      AssignFile(ff,nm);
      if fFileExists(nm)                                      //<130.0
         then Append(ff)
         else Rewrite(ff);
      cnt := cnt +1;
      su := fImrkt0(cnt,2) +'  ';
      if (si<>'')
         then Writeln(ff,su +DateTimeToStr(Now) +'  ' +si)
         else Writeln(ff,                          '');
      Flush(ff);
      CloseFile(ff);
   end;//DsmFileen}

   function TyhAsti(alkuS,si :string;  tyhjaa :integer) :string;      VAR n, m :integer;      begin// Pal SI´n jatkoksi TYHJAA " " ASTI -saakka.
      n := Length(si);
      for m := n to {n+}tyhjaa   //ALKUS = esim. alkutyhjä edellisen loppuun.
          do si := si +' ';
      result := alkuS +si;  end;
   function Hanta(si :string;  tyhjaa :integer) :string;      VAR n, m :integer;      begin// Pal SI TYHJAAn pituudeksi.
      n := Length(si);
      for m := n to tyhjaa
          do si := si +' ';
      result := si;  end;

   //,,Jos Pos('.',sRq)=0 => Tutkitaan Pos(',',sRq).  Pos('.',sRq)=0  aiheutti virheellisen tulkinnan.
   procedure Dsm (Rq,rajRq :real;  maxD :integer;  nay :string);      VAR n, nX :integer;  sF,sa :string;  rRq :real;      begin
      sF := sF +FloatToStr(Rq);      sF := TyhAsti(''  ,sF,10);       //FloatToStr(3) ='3' ei '3.0'
      sF := sF +FloatToStr(rajRq);   sF := TyhAsti('  ',sF,19);       //<'Nämä vain tiedostoonkirjoitusta(DsmFileen) varten.

      rRq := Rq;                                                      //??? rRq := fMuokDes(Rq,maxD);
        nX := 1;  n := 0;  d := 99;
      if Rq<=rajRq                           //< 3.215(Rq) > 3.2146(maxD)
      then d := maxD
      else while rRq>rajRq  do begin         //<,,Kunnes tutkittava rRq <= rajRq
         nX := nX*10;
         n := n+1;
         rRq := Rq/nX;                       //< 3.215 -> 0.3215
      end;

      if d=99  then
         d := maxD-n;                        //maxD -Abs(n) -1; ??
      if d<0  then d := 0;

         sF := sF +'maxD=' +Ints(maxD);   sa := '  rRq=' +FloatToStr(rRq);
         sF := sF +Hanta(sa,12);          sa := '  nX=' +Ints(nX);
         sF := sF +Hanta(sa,9);           sa := '  n= ' +Ints(n);
         sF := sF +Hanta(sa,6{8});           sa := '  d= ' +Ints(d);
         sF := sF +Hanta(sa,6{8});           sa := '  mrt0= ' +fRmrkt0(Rq,1,d); //<Nyt näytetään fRmrkt0 muodolla.
         sF := sF +Hanta(sa,12);
         sF := sF +'  Nay: ' +Nay +'  Rq-rajRq= ' +FloatToStr(Rq-rajRq);
      DsmFileen(sF);
   end;//Dsm
begin//fDsm........................
//cnt := 0;
{  DsmFileen(''); //<Tyjä rv alkuun.
   DsmFileen ( '  Rq(aoRea)  rajRq           Real-arvot,,,=FloatToStr().');//                    d  maxD  -nu +na');
//     Rq(arvo), rajRq ,  maxD             ,Näyttävä näin ja d oltava
   Dsm(2.5     , 2.5              ,    1 , '2.5   d=1'  );
   Dsm(1.5     , 2.5              ,    1 , '1.5   d=1'  ); //<'2.5 ja 1.5 olivat ongelmia (=> 3).
   Dsm(4       , 2.5              ,    1 , '4     d=0'  );
   Dsm(3.215   , 3.2146           ,    3 , '3.22  d=2'  );
   Dsm(0.3215  , 3.2146           ,    3 , '0.322 d=3'  );
   Dsm(0.03215 , 3.2146           ,    3 , '0.032 d=3'  );
   Dsm(32.15   , 3.2146           ,    3 , '32.2  d=1'  );
   Dsm(321.5   , 3.2146           ,    3 , '322   d=0'  ); //Vai 1 ???
   DsmFileen('');
   Dsm(3.214   , 3.2146           ,    3 , '3.214 d=3'  );
   Dsm(0.3214  , 3.2146           ,    3 , '0.321 d=3'  );
   Dsm(0.03214 , 3.2146           ,    3 , '0.032 d=3'  );
   Dsm(32.14   , 3.2146           ,    3 , '32.14 d=2'  );
   Dsm(321.4   , 3.2146           ,    3 , '321.1 d=1'  );
   DsmFileen('');
   Dsm(324    , 100.245600000000  ,    3  , '324.0    d=1'  );
   Dsm(100    , 100.000000000000  ,    3  , '100.000  d=3'  );
   Dsm(101    , 101.000000000000  ,    3  , '101.000  d=3'  );
   Dsm( 99    ,  99.000000000000  ,    3  , '99.000   d=3'  );
   Dsm(110    , 110.000000000000  ,    3  , '110.000  d=3'  );
   Dsm(1000   ,1000.000000000000  ,    3  , '1000.000 d=3'  );
   Dsm(6.34   ,3                  ,    0  , '6        d=0'  );
   Dsm(5.34   ,3                  ,    0  , '5        d=0'  );
   Dsm(4.34   ,3                  ,    0  , '4        d=0'  );
   Dsm(3.34   ,3                  ,    0  , '3        d=0'  );
   Dsm(3      ,3                  ,    0  , '6        d=0'  );
   Dsm(2.34   ,3                  ,    0  , '2        d=0'  );
   Dsm(0.34   ,3                  ,    0  , '0        d=0'  );}

   Dsm(r,rajR, maxD,''); //<Tähän Breakpoint testatessa. Avaa tässä _YDsm.txt -tiedosto.
   result := d;
end;//fDsm

   procedure LopNolVex (VAR c :string);      VAR s :string;  mja,i,d,e :integer;      begin
     {while (Length (s)>1) and (s[Length (s)]='0')  do            //<,,Käytetty aiemmin =Oli OK ####
         Delete (s, Length (s), 1);
      if (Length (s)>1) and (s[Length (s)]='.')  then             //<Vikaksi jäänyt desim.piste vex
         Delete (s, Length (s), 1); a''''''''''''''''''''''''''''''''''''''''''''''''''''''''-3.0.2}

      s := c;  d := 0;  e := 0;  mja := Length (c); //,,,,,,,,,,,,,,,,,,,,,,+3.0.2 =Mahd.nopeampi kuin N*Delete''
      for i := mja DownTo 1  do
         if s[i] ='0'  then e := i                  //<Eka poistettava '0' talteen
                       else Break;
      for i := mja DownTo 1  do begin
         if s[i] ='.'  then d := i;                 //<Desimaalin sijainti talteen
         if d>0  then Break;  end;                  //<Break vasta kun Desimn paikka tiedossa

      if d=0  then begin                            //,Oli jo nollista putsattu luku (25.0->25) eikä desiä =Jotta
         d := mja+1;  e := d;  end;                 //<'Delete ei pyyhkisi tarpeellisia nollia (250->25 !!!!!!!!)
      if e>0  then
      if d<e-1  then Delete (s, e, mja)             //<Desim.piste on ekaa poistettavaa '0' ENNEN (=norm.).  Riittäisi: mja-e+1
                else Delete (s, d, mja);            //<Muutetaan kokonaisluvuksi =DesimPiste + loput vex.           Riittäisi: mja-d+1
      c := s;                    //'''Riittäisi: mja-...!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   end;//LopNolVex

         //,Esim. r,100,2 = 99.999 :aan asti 2 desimaalia, sen jälkeen 1 desim. !!! ==>> FNC fMerktsvia #########
{function fDsmVexNS (r :real;   rajD :real;  desD :integer) :string;      VAR s :string;  Code :integer;     begin
   Code := fDsm (r,rajD,desD);
   Strg (r:1:Code, s);
   Val(s,r,Code);
   s := fVexNS (r);
   result := s;   end;}

//FNC palautta RR´n DES -lkm´llä. Jos RR<ar, DES kasvaa DESAR´sta YHDELLÄ, esim: fDesDyn(0.01, 0.01) => "0.01"
//    fDesDyn(0.001, 0.01) => "0.001",  fDesDyn(0.005, 0.01) => "0.005",  fDesDyn(0.1, 0.01) => "0.1"
//eli: DesimLkm kasvaa, mitä pienemmäksi luku menee (enint. 1 desim.).
{Testattavaksi, sijoita nämä kutsut jonnekin koodiin:
    S := fDesDyn (0.0100,0.01);   if S='1'  then typ;
    S := fDesDyn (0.01,0.01);     if S='1'  then typ;
    S := fDesDyn (0.001,0.01);    if S='1'  then typ;
    S := fDesDyn (0.0005,0.01);   if S='1'  then typ;
    S := fDesDyn (0.0003,0.01);   if S='1'  then typ;}

function fDesDyn (rr,ar :real) :integer;      VAR desARssa,Drr,Dar,k{,i} :integer;  Srr,Sar{,sa} :string;      begin //+130.0
   Srr := FloatToStr(rr); //StrToFloat
   Sar := FloatToStr(ar);                    //<FlotTo.. poistaa turhat nollat lopusta.

   k := Pos('.',Srr);                        //<Varsinainen tutkittava lukuarvo RR.
   if k=0  then
      k := Pos(',',Srr);
   Drr := Length(Srr) -k;                    // 0.01 => 4-2 =2

   k := Pos('.',Sar);                        //<Verrattava (esimerkki)lukuarvo AR.
   if k=0  then
      k := Pos(',',Sar);
   Dar := Length(Sar) -k;                    // 0.01 => 4-2 =2

   desARssa := Dar;
   if (Drr>Dar) and (rr<ar)                  //<,Jos pienempi kuin alaraja-arvo, DES kasvaa +1.
      then desARssa := desARssa +1;
  {m := 0;
   if k>0  then
   for i := 1 to Length(Srr)  do
      if NOT CharInSet(Srr[i], ['0', ',', '.']) //<Jos eioo nroja, desim kasvatetaan +1 (vain 1x).
         then m := m+1;
   sa := '';
   if m=0  then                                 //<,Jos eioo muita nroita kuin nollia.
      sa := fRmrkt0(rr,1,desARssa+1);
   if (sa<>'') and (sa[Length(sa)]<>'0')  then
        Srr := sa;//fRmrkt0(rr,1,desARssa+1);
   result := Srr;}

{  sa := fRmrkt0(rr,1,desARssa);  //<Tämä testattu OK, jos RESULT olisi STRING.
   result := sa;}
   result := desARssa;
end;

//FNC palauttaa STRINGin, jossa MERKITSEVIA määrä numeroita: 1.001 tai 0.001 =MERKITSEVIA=4 ################ 3.0.2
function fMrkvia (rr :real;   merkitsevia :integer) :string; //£STR: fMrktsvia fMerktsvia fMerkitsevia fMrkvia fMrkvja
(*    VAR s :string;  mja,i,d :integer;   ar :real;  neg :boolean;      begin

   if rr<0  then neg := true  else neg := false;
   ar := Abs(rr);                       //<Poistetaan etumerkki = Mjono aina ilman +/-
   s := fVexNS (ar);                    //<Loppunollat vex
   mja := Length (s);                   //,,,,,,,,,,,,,,,,,,,,,+3.0.2 =Mahd.nopeampi kuin mrkKohtainenDelete''
   d := Pos ('.',s);                    //<Desim.pisteen SIJAINTI (d) talteen, d := 0 jos ei löydy (aina löytyy)

  {e := 0;
   for i := d to mja  do
   if s[i] IN ['1'..'9']  then begin
      e := i;  Break;   end;            //<Ekan MERKITSEVÄN N:on SIJAINTI (e) talteen}
                                        //,,  12345.123456   0.00000123    ,,Näissä riittäisi:  Delete(s, d, mja-..)
   if merkitsevia <= d-1        //<,Haluttu vähemmän merkitseviä kuinOnEnnenDesiä -> kokon.luku Des asti.
   then Delete (s, d, mja)              //< 123456.12345 Mrkvia 5 -> 123456
  {else if ar<1
   then Delete (s, e+merkitsevia, mja)  //< 0.0012345    Mrkvia 3 -> 0.00123}
   else if merkitsevia >= d             //<,Ennen desiä vähemmän mrkja kuin haluttu tarkkuus =Desin ohi !!!!!!!!!
   then Delete (s, 2+merkitsevia, mja)  //< 123.12345    Mrkvia 4 -> 123.1  ja 0.012345    Mrkvia 4 -> 0.012
   else Delete (s,   merkitsevia, mja); //< 123.12345    Mrkvia 3 -> 123

   Val(s,ar, i);                        //< i = Code. Jos eiOK Code > 0 kylläkin, ei tod.näköistä.
   s := fVexNS (ar);                    //<Mahd. 0.00000 -> 0 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   if neg  and (s<>'0')
      then s := '-' + s;
   result := s;*)

      VAR s :string;  mja,i,d,vika :integer;   ar :real;  neg :boolean;      begin
                                        //Tässä tehdään 1) mjono, josta tutkitaan kohta, mista katkaista
                                        //              2) Tehdään uusi mjono tutkitulla pituudella
                                        //''''''''''''' = SAADAAN VIKA NUMERO TARVITTAESSA PYÖRISTETTYNÄ !!!!!!!!
   if rr<0  then neg := true  else neg := false;
   ar := Abs(rr);                       //<Poistetaan etumerkki = Mjono aina ilman +/-
   s := fRmrkt0 (ar,1,merkitsevia);     //<Karkean arvon mjono
   StoSok_e5(s);                           //<+130.2e
   d := Pos ('.',s);                    //<Desim.pisteen SIJAINTI (d) talteen, d := 0 jos ei löydy (aina löytyy)
   if merkitsevia <= d-1
   then vika := d-1                     //< Merkitsevia 1:  123.567 -> 123     3:  123.567 -> 124
   else begin                           //< Merkitsevia 5:  123.567 -> 123.57  i=2=Desimaalien lkm.
        i := merkitsevia-d+1;           //< i = Desimaalien lkm
        s := fRmrkt0 (ar,1,i);
        StoSok_e5(s);                      //<+130.2e
        vika := merkitsevia +1;  end;

   mja := Length (s);                   //,,,,,,,,,,,,,,,,,,,,,+3.0.2 =Mahd.nopeampi kuin mrkKohtainenDelete''
   Delete (s, vika+1,mja);              //<Putsataan VIKAmrkin SEURAAVASTA LÄHTIEN !!!!!!!!!!!!!!!!!
 //Val(s,ar, i);                        //< i = Code. Jos eiOK Code > 0 kylläkin, ei tod.näköistä.
   try
      ar := StrToFloatQ (s);  //FloatToStrF(amount1, ffExponent, arvoA,DES);
   except
      on EConvertError  do
       //ShowMessage ('Virheellinen merkkijono luvuksi:  [' +s +']'); //Kuitenkin heittää oman herjan, ei tätä.  130.2e: Debugissa ei OK, mutta norm ajo OK.
         InputBox('Virheellinen merkkijono luvuksi:','Luku talteen:',s);
   end;
   s := fVexNS (ar);                    //<Mahd. 0.00000 -> 0   12.4500 -> 12.45 !!!!!!!!!!!!!!!!!!!
   StoSok_e5(s);                           //<+130.2e
   if neg  and (s<>'0')
      then s := '-' + s;
   result := s;

{,,Lukualueen tarkkuuden kokeiluun (hakusanalla Real (=Double) = 15-16 Significant digits____________________
         //,123456789012345678                                              ,,.....,123456789012345678 =MrkNo
    fVexNS (0.123456789012345678901234567890);//16 desim ok      vika OKmrk=18   ok=0.1234567890123456
    fVexNS (1234.123456789012345678901234567);//13 desim ok                 18   ok=1234.1234567890123
    fVexNS (12345678.12345678901234567890123);// 9 desim ok                 18   ok=12345678.123456789
    fVexNS (1234567890123456.123456789012345);// 0 desim ok = 16 DEK ok     16   ok=1234567890123456
    fVexNS (123456789012345678901.1234567890);//16 DEK ok                   16   ok=1234567890123456
         //,1234567890123456789                                             ,,.....,1234567890123456789-----
    fVexNS (0.000000000000001234567890123456);//..0123                      19   ok=0.00000000000000123
    fVexNS (0.000000000001234567890123456789);//..012345                    18   ok=0.0000000000012345
    fVexNS (0.000000001234567890123456789012);//..0123456789                19   ok=0.00000000123456789 }
end;//fMrkvia
                                                                         //Esim: 23.000 -> 23   23.01000 -> 23.01
//FNC palauttaa STRINGin, jossa MERKITSEVIA määrä numeroita:  0.001 =MERKITSEVIA=1 ######################## 6.2.0
function fMrkviaN (arvR :real;   merkitsevia,Des0vex :integer) :string;
                                        //Tässä tehdään 1) mjono, josta tutkitaan kohta, mista katkaista
                                        //              2) Tehdään uusi mjono tutkitulla pituudella
                                        //''''''''''''' = SAADAAN VIKA NUMERO TARVITTAESSA PYÖRISTETTYNÄ !!!!!!!!
                                        //                ja haluttaessa LoppuNOLLADESIMAALIT poistettuna.!!!!!!!
   procedure teeStr;      VAR ss,sa{,st} :string;  alku,des,vika,i,d :integer;      begin
    //st := '0.123456789_123456789_123456789_123456789_';
      sa := fRmrkt0 (arvR,1,20);               //<Max.tarkkuuden + n. 2 digit. mjono (max. lienee 18).
      alku := 0;
      for i := 1 to Length (sa)  do            //<,Etsitään 1. merkitsevä no(=x):  0.00xz,  x.00zz,  -0.0xz
      if NOT (CharInSet(sa[i], ['-','0','.']))  then begin
         alku := i;  break;  end;

      d := Pos ('.',sa);                       //<Etsitään DESImaalipisteen sijainti

      vika := alku + merkitsevia-1;            //<Jos esim. MERKITSEVIA=1, kasvaisi liikaa +1.
      if d>alku  then                          //<,Jos desim.piste ALUN JÄLKEEN, merkkejä lisättävä +1.
         vika := vika +1;
      if vika>Length (sa)  then                //<,Tarkistetaan, ettei mennä ohi vikan mrkn.
         vika := Length (sa);

     {ss := Copy (sa,1,vika);                  //<,,Toimii OK, mutta mahd. vika pyöristys jää tekemättä.
      result := ss;}

      des := vika - d;                         //<,Tämä korvaa ed. Copy´n ja hoitaa mahd. tarvittavan pyöristyksen.
      if des<0  then des := 0;
      ss := fRmrkt0 (arvR,1,des);              //<Pyöristää vikan digitin tarvittaessa.
                                                                //,Pos>0 koska 100.0 :sta tuli 1   +7.1.2006
      if (Des0vex>0) and (Pos ('.',ss)>0{7.1.2006})  then begin //<,,Jos halutaan loppunollat DESIMAALEISTA vex.
         while (Length (ss)>1) and (ss[Length (ss)]='0')  do //<,Poistetaan mahd. loppunollat ...
            Delete (ss,Length (ss),1);
         if (ss<>'') and (ss[Length (ss)]='.')  then         //<, ... ja mahd loppuun jäävä desim.piste.  1414d: +ss<>''
            Delete (ss,Length (ss),1);
      end;
      if (Length (ss)=1) and (ss='-')   OR                   //<, '-' ja '-0' => '0' :ksi
         (Length (ss)=2) and (ss='-0')   then
         ss := '0';
      result := ss;

    //if (ss<>sa) and (st<>sa) and (st<>sa) and (alku<0) and (vika<0) and (d<0)  then beep;
   end;
begin
   {arvR := 0.163456789012345678901234567890;
       merkitsevia := 0;  teeStr;
       merkitsevia := 1;  teeStr;
       merkitsevia := 2;  teeStr;
       merkitsevia := 3;  teeStr;
    arvR := 1634.123456789012345678901234567;
       merkitsevia := 0;  teeStr;
       merkitsevia := 1;  teeStr;
       merkitsevia := 2;  teeStr;
       merkitsevia := 3;  teeStr;
    arvR := 16345678.12345678901234567890123;
       merkitsevia := 1;  teeStr;
       merkitsevia := 2;  teeStr;
       merkitsevia := 3;  teeStr;

    arvR := -0.163456789012345678901234567890;
       merkitsevia := 0;  teeStr;
       merkitsevia := 1;  teeStr;
       merkitsevia := 2;  teeStr;
       merkitsevia := 3;  teeStr;
    arvR := -1634.123456789012345678901234567;
       merkitsevia := 1;  teeStr;
       merkitsevia := 2;  teeStr;
       merkitsevia := 3;  teeStr;
    arvR := -16345678.12345678901234567890123;
       merkitsevia := 1;  teeStr;
       merkitsevia := 2;  teeStr;
       merkitsevia := 3;  teeStr;//}

   teeStr;
end;

{function fVexNS (r :real) :string;      VAR s :string;  i,mja,d,v :integer;    begin //<,,Poistaa loppunollat ###
 //Str (r:1:8, s);                        //< -3.0.2
   Str (r:1:18, s);                       //< +3.0.2  Real (=Double) = 15(>0?) -16(<0?) Significant digits

   mja := Length (s);
   d := Pos ('.',s);                      //<Desim.pisteen SIJAINTI (d) talteen, d := 0 jos ei löydy.

 //v := 18;   if d>=17  then v := 17;     //< v = Eka mahd. pyöristyvä Nro, ks. koekutsut fVexNS (1234....)
                                          //,Varm.vuoksi lyhennetty yhdellä 18->17 ja 17->16 ______________
   v := 17;   if d>=16  then v := 16;     //< v = Eka mahd. pyöristyvä Nro, ks. koekutsut fVexNS (1234....)
   for i := v to mja  do                  //<,,Korvataan mahd. pyöristyneet luvun osat '0' :ksi !!!!
   if s[i]<>'.'  then                     //'  15 +1 = 16, koska desim.piste ottaa yhden.
      s[i] := '0';

   LopNolVex (s);
   result := s;
end;//fVexNS}

function fVexN_ (s :string) :string;      begin //Poistaa loppunollat, Esim: 23.000 -> 23   23.01000 -> 23.01 +6.0.0
   if (Pos ('.',s)>0) or (Pos (',',s)>0)   then
   while (Length(s)>1) and (s [Length(s)]='0')  do
      Delete (s,Length(s),1);                   //<Poistetaan vika mrk.
   if (Length(s)>1) and (CharInSet(s [Length(s)], ['.',',']))  then
      Delete (s,Length(s),1);                   //<Poistetaan vika mrk. => Kokonaisluvuksi
// if s=''  then s := '0';                      //<Varm.vuoksi 6.0.0
   result := s;
end;//fVexN_
                                                //,,Poistaa loppunollat, Esim: 23.000 -> 23   23.01000 -> 23.01
function fVexNrd (r :real;  des :integer) :string;      VAR s :string;      begin//+6.0.0
   s := fRmrkt0 (r,1,des);
   s := fVexN_ (s);
// if s=''  then s := '0';                      //<Varm.vuoksi 6.0.0
   result := s;
end;//fVexNrd

function fVexNS (r :real) :string;    VAR s{,c} :string;      begin //Poistaa loppunollat
   {-----------------------------------------------------------------------
   s := '';                                                              //Esim: 23.000 -> 23   23.01000 -> 23.01
   for i := 0 to 18  do begin             //< +3.0.2 ,,,,,,  Real (=Double) = 15(>0?) -16(<0?) Significant digits
      VolaStr2 (r, 1, i, c);                     //<,,Tehdään R:stä str X, X.x, X.xx jne. kunnes AR=R ##################
    //Str (r, s);                         //<OK, mutta tekee muotoon X.xxE+004 jne.
//    if i>1  then Delete (c,Length(c),1);//<Vika mrk vex;  saattoi olla pyöristetty ############################
      Val (c,ar,Code);
      if ar=r  then begin
         s := c;  Break;  end;
   end;

   if s=''  then
      VolaStr2 (r, 1, 15, s);
   LopNolVex (s);
// if s=''  then s := '0';                      //<Varm.vuoksi 6.0.0
   result := s;
   ---------------------------------------------------------------------}
                                                                         //,,VolaStr2 korvattu täysin uusiksi 12.0.0
   s := FloatToStr (r);                                                  //Esim: 23.000 -> 23   23.01000 -> 23.01
 //for i := 0 to 18  do begin             //< +3.0.2 ,,,,,,  Real (=Double) = 15(>0?) -16(<0?) Significant digits
 //while (Length(s)>1) and (s[Length(s)] IN ['0','.',','])  do             //<XE2 käyttää "," .
   while (Length(S)>1) and (CharInSet (S[Length(S)], ['0', '.', ',']))  do //<'12.0.0 Consider CharInSet ..
      Delete (s,Length(s),1);
   result := s;
end;//fVexNS
//,                       ,rajaArvolla  rajaDesiLkm
FUNCTION fMuokDesRaj (arvR,rajR :real;  rajD :integer) :real;    VAR s :string;  ar :real;  des{,Code} :integer;  BEGIN
{des := fDsm (arvR,rajR,rajD);          //<DesimLkm.           //'FNC muokkaa reaaliluvun desimaaliosan<<<<<<<<<
 //Str (arvR:1:des, s);                 //<arvR strg:ksi.      Sama kuin fRmrk0 ().
   VolaStr2 (arvR, 1, des, s);                 //<arvR strg:ksi.      Sama kuin fRmrk0 ().
   Val(s,ar,des);                       //<Strg ar :ksi =FNC.  Sama kuin SokR () mutta ei hyväksy ',' DesimPpilkkua.
   if des=0  THEN Result := ar
             ELSE Result := ar;  END;
 //Val (s,ar,Code);                     //<procedure Val(S: String; var V; var Code: Integer); <'',,ym.. -12.0.0}

   s := FloatToStr (arvR);
   des := fDsm (arvR,rajR,rajD);        //<DesimLkm.
   ar := fMuokDes (arvR,des);
   result := ar;
END;

FUNCTION fMuokDesRajAlk (arvR :real;  alkio :arvoTyyp) :real;      VAR ar :real;      BEGIN
   ar := fMuokDesRaj (arvR, alkio.Rdsm.Raj, alkio.Rdsm.Des);     //'FNC muokkaa reaaliluvun desimaaliosan.  +9.0.1
   result := ar;
end;

FUNCTION fMuokDes (arvR :real;  des :integer) :real;    BEGIN //,FNC muokkaaRealiluvun desimOsan: 12.349 des=2 => 12.35
  {Str (arvR:1:des, s);
  {VolaStr2 (arvR, 1, des, s);
   Val(s,ar,Code);
  {if Code=0  THEN Result := ar
              ELSE Result := ar;  END;}
// ------------------------------------''-12.0.0,,+}
{   s := FloatToStr (arvR);
   p := Pos('.',s);
   if p=0  then
      p := Pos(',',s);                          //<,Näköjään "." on korvattu "," :lla XE2´ssa.
   n := Length(s);
   d := n-p;                                    //< d=Alp DesimLkm.
   for i := 1 to des-d  do
      s := s +'0';
   s := Copy (s,1,p+des);                       //<Kopioidaan 1..vikaan desimaaliin se ml.
   Val(s,ar,Code);                              //<Ei pyöristä:  12.349 des=2 => 12.34 po. 12.35

 //if NOT SokR(s,ar)  then begin        //<S ar :ksi =FNC.  Sama kuin SokR () mutta ei hyväksy ',' DesimPpilkkua.
   if Code=0
   THEN Result := ar
   else begin  Result := arvR;
    //ShowMessage ('Muokattavan reaaliluvun muunnos merkkijonoksi FNC SokR(arvR,strg) Y_.PAS´ssa ei onnistunut.');
   end;//'''''''''''''''''''''''''''''''''''''''}
   result := Rounder (arvR,des);
END;//fMuokDes
//==================================================================================================

FUNCTION fImrkt_(arvI :Integer;   tab :Integer) :String;   VAR S :String;    BEGIN
   IF arvI=0  THEN S := ' - - - - - - '
              ELSE RtoST {VolaStr1}(arvI, Tab, S);        Result := S;  END;

FUNCTION fRmrkt_(arvR :Real;  tab,des :Integer) :String;   VAR S :String;    BEGIN //NolaZ.INC  3x
   IF arvR=0  THEN S := ' - - - - - - '                                            //Y_         1x
              ELSE RtoSD {VolaStr2}(arvR, Tab,Des, S);   Result := S;  END;

   FUNCTION fRmrk5x_(oh :integer;  aliPRO :boolean;  arvR :Real;  tab,des :Integer) :String;   VAR S :String;    BEGIN
      if (demo(2) OR aliPRO) and (oh=1)  then Result := 'X.xx'  else                                              //< X.xx
         IF arvR=0  THEN S := '- - - - - '
                    ELSE RtoSD {VolaStr2}(arvR, Tab, Des, S);   Result := S;  END;
FUNCTION fRmrk5x(oh :integer;  arvR :Real;  tab,des :Integer) :String;      BEGIN
   result := fRmrk5x_(oh,FALSE,       arvR, tab,des);  end; //<FA=Ei väliä onko mahd lvLT
FUNCTION fRmrk5x_PRO(oh :integer;  arvR :Real;  tab,des :Integer) :String;      BEGIN //+7.0.1
   result := fRmrk5x_(oh,PRO_Demo,arvR, tab,des);  end; //<Demo jos lvLT

FUNCTION IntS (arvI :Integer) :String;     begin //< IntToStr
   result := IntToStr (arvI);   end;
FUNCTION fImrkt0(arvI :Integer;   tab :Integer) :String;   VAR S :String;  i :integer;  BEGIN//12.0.0: NEGATtab=VasSuora.
   //VolaStr1(arvI, Tab, S);   for i := 1 to Length (S)  do if S[i]=' '  then S[i] := Chr (255);  ,,Korvattu 12.0.0
   S := Ints (arvI);                                                               //'Chr (255):n pit=5='8', ' '=2
   if tab<0
   then for i := Length (S)+1 to Abs(tab)  do S := S +' '//'~'                  //<12.0.0:  VasSuora.
   else for i := Length (S)+1 to tab       do S := ' ' +S;                      //<12.0.0:  Välit jäljstä etupuolle.
   Result := S;     END;                                                        //,,Des=0 =>Integ,  <0 =>LoppuNollatVex.
//==================================================================================================
(*  procedure Testaa;      VAR S :string;  r :real;      begin//fRmrkt0 testaukseen 12.0.0 .
{        r := 0.000098;
       //Format ('%8.2f', [123.456]); //<Is equivalent to: Format ('%*.*f', [8, 2, 123.456]);
        {ShowMessage(Format('%f',[r]));    //= 0.00
         ShowMessage(Format('%g',[r]));    //= 9.9E-005
         ShowMessage('0.¤¤¤¤ : '  +FormatFloat('0.####'  , r));   // 0.0001
         ShowMessage('0.¤¤¤¤¤¤ : '+FormatFloat('0.######', r));   // 0.000098
         ShowMessage('0.0000 : '  +FormatFloat('0.0000'  , r));   // 0.0001
         ShowMessage('0.000000 : '+FormatFloat('0.000000', r));   // 0.0001  ---}
{        ShowMessage(FormatFloat('0.####'  , r));   // 0.0001
         ShowMessage(FormatFloat('0.######', r));   // 0.000098
         ShowMessage(FormatFloat('0.0000'  , r));   // 0.0001
         ShowMessage(FormatFloat('0.000000', r));   // 0.0001                ---}
{        r := 0.000098;
         S := '0.####';   ShowMessage(FormatFloat(S, r));   // 0.0001
         S := '0.######'; ShowMessage(FormatFloat(S, r));   // 0.000098
         S := '0.0000';   ShowMessage(FormatFloat(S, r));   // 0.0001
         S := '0.000000'; ShowMessage(FormatFloat(S, r));   // 0.000098
         S := '0';        ShowMessage(FormatFloat(S, r));   // 0
         r := r +100;     ShowMessage(FormatFloat(S, r));   // 100
      ShowMessage('1 0000.#: '   +FormatFloat('0000.#'  , 89));
      ShowMessage('2 00000.#: '  +FormatFloat('00000.#' , 89));
      ShowMessage('3 0000.#: '   +FormatFloat('0000.#'  , 890));
      ShowMessage('4 00000.#: '  +FormatFloat('00000.#' , 890));
      ShowMessage('5 00000.##: ' +FormatFloat('00000.##', 890));

      ShowMessage('6 0000.#: '   +FormatFloat('0000.#'  , 89.45));   //= 0089.5
      ShowMessage('7 00000.#: '  +FormatFloat('00000.#' , 89.45));   //= 00089.5
      ShowMessage('8 0000.#: '   +FormatFloat('0000.#'  , 890.45));  //= 0890.5
      ShowMessage('9 00000.#: '  +FormatFloat('00000.#' , 890.45));  //= 00890.5
      ShowMessage('10 00000.##: '   +FormatFloat('00000.##'   ,890.445));  //= 00890.45
      ShowMessage('11 00000.###: '  +FormatFloat('00000.###'  ,890.445));  //= 00890.445
      ShowMessage('12 00000.##: '   +FormatFloat('00000.##'   ,890.445));  //= 00890.45
      ShowMessage('13 000000.###: ' +FormatFloat('000000.###' ,890.445));  //= 000890.445
      ShowMessage('14 000000.0:   ' +FormatFloat('000000.0'   ,890.445));  //= 000890.4
      ShowMessage('15 000000.00:  ' +FormatFloat('000000.00'  ,890.445));  //= 000890.45
      ShowMessage('16 000000.000: ' +FormatFloat('000000.000' ,890.445));  //= 000890.445
      ShowMessage('17 000000.0000: '+FormatFloat('000000.0000',890.445));  //= 000890.4450
      ShowMessage('18 0.##: '       +FormatFloat('0.##'       ,890.445));  //= 890.45
      ShowMessage('19 0.######: '   +FormatFloat('0.######'   ,890.445));  //= 890.445
      ShowMessage('20 0.00: '       +FormatFloat('0.00'       ,890.445));  //= 890.45
      ShowMessage('21 0.000000: '   +FormatFloat('0.000000'   ,890.445));  //= 890.445000
      ShowMessage('22 0: '          +FormatFloat('0'          ,890.445));  //= 890
      ShowMessage('23 0.00: '       +FormatFloat('0.00'       ,890.445));  //= 890.45 ---}

    //Global.PAS´sta:,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    //procedure KoklaaG;      VAR s :string;      begin//,,fRmrkt0 (arvo :Real;  tab,des :Integer) :String;
                         s := fRmrkt0 (1.345,6,1);    //= 1.3---                     '''PilkunJälkeinen DesLkm ########
          if s='' then;  s := fRmrkt0 (1.345,6,2);    //= 1.35--                 '''KokonaisMrkLkm sis.desimPiste +DES
          if s='' then;  s := fRmrkt0 (1.345,6,1);    //= 1.3---
          if s='' then;  s := fRmrkt0 (1.345,6,0);    //= 1
          if s='' then;  s := fRmrkt0 (1.351,6,0);    //= 1
          if s='' then;  s := fRmrkt0 (1.35,6,1);     //= 1.4---
          if s='' then;  s := fRmrkt0 (1.344,6,2);    //= 1.34--
          if s='' then;  s := fRmrkt0 (1.3446,7,2);   //= 1.34---
          if s='' then;  s := fRmrkt0 (1.3456,7,2);   //= 1.35---
          if s='' then;  s := fRmrkt0 (1.3456,6,2);   //= 1.35--
          if s='' then;  s := fRmrkt0 (0.000098,1,6); //= 0.000098   rajR=1  maxD=8
          if s='' then;  s := fRmrkt0 (0.000098,1,6); //= 0.000098
          if s='' then;  s := fRmrkt0 (0.000098,1,6); //= 0.000098
          if s='' then;  s := fRmrkt0 (0.000098,1,7); //= 0.0000980
          if s='' then;  s := fRmrkt0 (0.000098,1,7); //= 0.0000980
          if s='' then;
    //Global.PAS´sta''---------------------------------------------}
  end;//*)
FUNCTION fRmrkt0(arvR :Real;  TAB,DES :Integer) :String; //130.2e:  £STR. Täältä FloatToStr kutsuu FNC StrToFloat => FNC StrToFloatQ .
{                                 '''PilkunJälkeinen DesLkm ###########################################################
                              '''KokonaisMrkLkm SIS.desimPiste ########################################################
                              //if des<0  then begin.. =Lisäys:  NEGAT.DES = LoppuNollat VEX !!!!!!!!!!!!+5.0.0}
   function fTee(oh :integer;  arvoA :real;  TAB,DESa :integer;  NAY____S :string) :string;
                                      VAR neg :boolean;  S :String;  c0,c1,c2 :char;  i,n,d,DES :integer;  ARVO :real;    BEGIN //NAY: Debuggerissa näkyy.
      //if des=0  then VolaStr2(arvo, Tab, Des, S)  else VolaStr2(arvo, Tab, Abs(Des), S);  +12.0.0 . 12.11.98: Hyvin iso integ. aiheutti: Invalid floating point oper.
      //===========================================================================================
      if IsDebuggerPresent or (oh>0)  then begin c0 := '¨';  c1 := '~';  c2 := '^';  end //< 0h>0 VAIN kun testaillaan, 0 = ks, varsin. kutsu vikana.
                                      else begin c0 := ' ';  c1 := ' ';  c2 := ' ';  end;
      if DESa>=0  then neg := false
                  else neg := true;   //<Tähän saa BrekPnt´in vain NEG´lle.
      DES := Abs(DESa);               //<DESa jotta Local Var´ssa näkyisi NEGATIIVINEN DESa.
                                       {try                                             //<130.2e:  En saa workkimaan.
                                           S := FormatFloat (so,arvo);
                                        Except
                                           on E : Exception do
                                              ShowMessage('Y_.pas: fRmrkt0/FormatFloat: ');//+E.Message);
                                        end;
                                        //Finally}
     {arvo := 9.8E-05 *10;                         // =0.000098*10  =  0.00098
      if arvo>1000  then ;   arvo := 9.8E-05 *100; // =0.000098*100 =  0.0098
      arvo := 9.8E-5 *10;                          // =0.000098*10  =  0.00098  =sama kuin E-05..
      if arvo>1000  then ;   arvo := 9.8E-5 *100;  // =0.000098*100 =  0.0098
      if arvo>1000  then ;   arvo := 9.8E-0 *100;  // =0.000098*100 =  980
      if arvo>1000  then ;   arvo := 9.8E5;        // =0.000098*100 =  980000
      if arvo>1000  then ;   arvo := 9.8E5 *100;   // =0.000098*100 =  98000000}

//:::::::::::::::::::::::::::::::: Desimaalit ja erotin :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      arvo := fMuokDes(arvoA,DES);                    //<+130.2e:  Nyt jo ennen kuin jälemmät mahd vaikuttavat not häviää (no 5 pyöristää isompaan) delautuu.
      S := FloatToStr(arvo);                          //<+130.2e
      StoSok_e5(S);                                   //<+141.1    //<Tämä vasta poistaa E -esitystavan =muttaa oikeaksi liukuluvuksi 0.98e-05 => 0.000098
      d := Pos('.',S);                                //        Debuggeri näyttää desimErottimen realiluvussa PILKKUNA, mutta STR´ssä PISTEENÄ,
      if d=0  then                                    //        joten tässä d=PISTEEN paikka.
         d := Pos(',',S);                             //,+130.2e:  Piste (tai pillku) pilkuksi.
      if d>0  then                                    //  1234    d=0 TAB=6 DES=3 => 1234~~~~
         S[d] := ',';                                 //  1234,1  d=5 TAB=6 DES=3 => 1234,1~~
//:::::::::::::::::::::::::::::::: Desimaalit ja erotin :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      n := Length(S);              //Tutkit desimOsa:  Lisätään erotin ja selvitetään sen osoite (d) JA lisätvät loppu-0´t & Delataan ylimääräiset lopusta.
      if d>0                       //JOS DES=0 => fMuokDes(arvoA,DES) on POISTANUT DESIM.EROTTIMEN JA ALPaRVOSTA KAIKKI DESIMAALIT = 1,234 => 1
         then begin                                   //<,,Jos on desimErotin.
            //k := d+DES-n;                           //<123,456  n=7 d=4 k=d+DES-n =4+3-7 =0.  K =loppuun lisättävien nollien lkm.
              Delete(S,d+DES+1,99);  end              //<+130.2e:  Turhat hännästä vex.        'DELPHI herjasi: k Never used.
         else begin
            //k := 0;
              if DES>0  then begin
                 S := S +',';                         //<Pilkku puuttui, lisätään.
                 n := n+1;                            //<n´hän oli pilkun eteen, joka sijoitettiin nyt sen jälkeen (n+1).
                 d := n;                              //<DesimErottimen osoite d.                 1234 6 2 => 1234,00
                {k := d+DES-n;  }end;                  //< 1,234  TAB=1 DES=0 d=2 => k := 2+0-1 .  1,234  TAB=1 DES=2 => k := 0+0-1 .
         end;
//:::::::::::::::::::::::::::::::: Lisättävät loppunollat K kpl.:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      n := Length(S);              //<,,Loppunollat.
      for i := n+1 to d+DES  do
         S := S +'0';                                 //< (1.2, 1,3)=> 1,200
      n := Length(S);                                 //<,,+130.2e:  Edellä mahd. muuttui.
      for i := n to TAB-1  do      //<,Etumrkt TAB leveyteen.
         S := c0 +S; //c0="¨" tai " "                 //< 1.355,6,1) => "1.4" => "¨¨¨1.4"
//:::::::::::::::::::::::::::::::: NEGAT.DES = LoppuNollat VEX ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      if neg  then
         while (S<>'') and (S[Length (S)]='0')
            do Delete (S,Length (S),1);
      n := Length(S);
      if (neg or (DES=0)) and (n>0) and (CharInSet(S[n], [',','.'])) //<,Jos desimErottimen jälkeen ei mja, delataan myös erotin.
         then S[n] := c1;{~}                                         //'1414d: +(n>0)
//:::::::::::::::::::::::::::::::: Alkutyhjät TAB´in mukaan :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      for i := n+1 to TAB  do                         //<,,Alkunollat vex mutta "0(.?)" jää.
         S := S +c2;{^}                               //< (1.355,1,6) => "1.4" => "1.4^^^^^"

      for i := 1 to n  do                                //<,,Alkunollat vex mutta "0(.?)" jää. ,1414d: +(i<Length(s))
         if (i<Length(s)) and CharInSet (S[i], ['.',',','-','+','1'..'9']) //,Lopetetaan desimErottimeen, alkuMrkiin tai anyNumeroon.
         then Break                                      //,Desim.erottimen eteen jäätävä "0".
         else if (S<>'') and (S[i]='0') and ((i+1)<=n) and NOT (CharInSet (S[i+1], ['.',','])) //<1414d: +S<>''
         then {if IsDebuggerPresent                  //-130.2e
            then S[i] := '¤'                         //<Ei joi jättää ajon ajaksi => Err.
            else }begin S[i] := ' ';  {if isDebuggerPresent  then WBeep(500,100, 0,300, 2000,100, 0,300, 5000,100);  }end;
     {n := Length(S);                                //<,,130.2e.
      for i := n downto 1  do                        //<,,+130.2e:  Tulee HIRVEÄSTI WindosBeep´pejä, ihme => Y_.pas/StrToFloatQ´ssa  W..Beep nyt ohitettu.
      if S[i]='.'  then begin S[i] := ',';  Break;  end;                  //<DesimPiste pilkuksi.}
      Result := S;
   //end;//try
   end;//fTee

BEGIN//fRmrkt0...................    ,,,,,,,,=Local Variablessa NÄYTTÄVÄ:  0.000098 oli 9.8E-5 , KIRJOITETAAN numeroina 0,000098
{  result := fTee(1, 9.8E-05, 1,8,   '0.00098');
   result := fTee(1, 9.8E-05, 1,8,   '0.00098');
   result := fTee(1, 9.8E-05, 1,8,   '0.00098');
   result := fTee(1, 9.8E-05, 1,8,   '0.00098');
{  result := fTee(1, 1.234, 1,6,    '1,234000');
   result := fTee(2, 1234.567 ,1,6, '1234,567000');
   result := fTee(3, 1.234,  1,6,    '1,234000');
   result := fTee(4, 1.234,  1,1,    '1,2');
   result := fTee(5, 1.234,  1,0,    '1');
   result := fTee(6, 1.564,  1,6,    '1,564000');
   result := fTee(7, 1.564,  1,1,    '1,6');
   result := fTee(8, 1.564,  1,0,    '2');
   result := fTee(9, 1.000,  1,-2,   '1~');
   result := fTee(10, 1.234, 1,-3,   '1,234');
   result := fTee(11, 1234,  6,2,    '1234,00');
   result := fTee(12, 1234,  3,3,    '1234,000');
   result := fTee(13, 1234,  3,-3,   '1234~');       //<Mrk "~" koska desimErotin korvautui sillä.
   result := fTee(14, 12.56, 7,1,    '¨¨¨12,6');      //<''Debuggerissa näkyy Local Variables) ja ohjaa erikoismerkeille "~" "¨".}
  {result := fTee(15, 1.234,  1,1,    '1,2');
   result := fTee(15, 3.5,    1,1,    '3,5');
Beep;//}
   result := fTee(0, arvR,TAB,DES,'');
END;//fRmrkt0

FUNCTION RtoS(arvR :Real;  tab,des :Integer) :String;      begin//+130.2e:  < Kutsuu fRmrkt0()´aa.
   result := fRmrkt0(arvR,tab,des);  end;

FUNCTION fRmrkt (arvR, rajD :real;  desD :Integer) :String;      VAR S :String;     BEGIN //Tutkii DESIM määrän
   s := fRmrkt0 (arvR, 1,fDsm (arvR, rajD,desD));                //<Esim:  0.1234, 1,3 -> 0.123
   result := s;  end;                                            //'       1.2345, 1,3 -> 1.23 jne.

{function fRmrkt0x (r :real;  tab,des :integer) :string;      var s,su :string;   i,o :integer;      begin
   su := fRmrkt0 (r,tab,des);  s := su;        //'Poistaa loppunollat ja mahd. tarpeettoman VIKAN '.'
   if des>0  then begin
      i := Length (su);  o := 0;
      while (i>1) and (su[i] IN ['0','.',','])  do begin
         i := i-1;  o := i;
         if su[i] IN ['.',',']  then begin //<Muuten menee poistamaan myös kokonaisosan '0':ia, todettu
            o := o-1;  break;  end;
      end;
      if o>0  then begin
         s := '';
         for i := 1 to o  do s := s +su[i];  end;
   end;
   result := s;
end;//fRmrkt0x}
                                                                               //,Sama kuin fRmrkt0x: Poistaa '.' :n jälkeiset NOLLAt
FUNCTION sRmrkt0vex (arvR :Real;  tab,des :Integer) :String;      VAR S :String;                    //£STR: 130.2e:  asetaPvBtn´ssa virhetulkinta koska SokR
   procedure tee(ra :real  {VAR su :string});     {VAR i :integer;}      begin                       //         yms muuttui ja 0-poisto ei enää worki.
       S := fRmrkt0 (ra,tab,des);                                                                   //0.950 => 0.95   0.0 => 0
       StoSok_e5(S);
       result := S;

      {S := fRmrkt0 (arvR,tab,des);
       i := Pos ('.',S);  if i=0  then i := Pos (',',S);
       while (i>0) and ( (CharInSet(S[Length(S)], ['.',','])) or (S[Length(S)]='0') )  do
          if CharInSet(S[Length(S)], ['.',','])
          if (S[Length(S)]=',') or (S[Length(S)]='.')
          then begin
               Delete (S, Length(S),1);            //<'Vika mrk vex jos '.' tai '0'
               Break;  end                         //<'.' ja ',' :n jälk, muuten jatkaa pilkunEd.nollien pyyhkimistä
          else Delete (S, Length(S),1);            //<'Vika mrk vex jos '.' tai '0'
       result := S;}
    end;//tee
begin//sRmrkt0vex.....................
  {tee(0.009800);
   tee(1.23400);
   tee(1.230);
   tee(1.0230);
   tee(1.023);
   tee(01230);}

   tee(arvR);
end;

   FUNCTION fKmark_ (oh :integer;  aliPRO :boolean;  arvR :Real;  tab,des :Integer) :String;
          VAR S,a :String;  i,d,n,mja :integer;       BEGIN      //<' 1000.00 -> 1.000,00  1.000,0 tms.
      if (demo(3) OR aliPRO) and (oh=1)  then S := 'X.xx'  else BEGIN
      s := fRmrkt0 (arvR,tab,des);
      mja := Length (s);
      for i := 1 to mja  do if s[i]='.'  then s[i] := ',';                   //<DesimPiste pilkuksi <<<

      d := mja;  if des>0  then d := mja-des-1;
      a := '';   if des>0  then for i := mja DOWNTO mja-des  do a := s[i] +a;       //<xxx,X -> a=',X'

      n := 0;    for i := d DOWNTO 1  do begin
                          if (n MOD 3=0) and (n>0)  then a :=  '.' +a;   a := s[i] +a;   n := n+1;  end;
      Result := a;
      END; END;
FUNCTION fKmark (oh :integer;  arvR :Real;  tab,des :Integer) :String;      BEGIN
   result := fKmark_ (oh,FALSE,   arvR, tab,des);  end; //<Demo jos lvLT
FUNCTION fKmark_PRO (oh :integer;  arvR :Real;  tab,des :Integer) :String;     BEGIN //+7.0.1
   result := fKmark_ (oh,PRO_Demo,arvR, tab,des);  end; //<Demo jos lvLT

   FUNCTION fRkilo0_(oh :integer;  aliPRO :boolean;  arvR :Real;  tab,des :Integer) :String;   VAR S :String;   BEGIN//<10000.00/1000.00 -> 10000.0 .. 1000
      if arvR>9999.499  then des := des-1;  //<10000.00 +des=2 -> 10000.0   10000.0 +des=1 -> 10000
      if arvR> 999.499  then des := des-1;  //< 1000.00 +des=2 ->  1000.0    1000.0 +des=1 ->  1000
      if des<0  then des := 0;
      if (demo(4) OR aliPRO) and (oh=1)  then S := 'X.xx'  else
         if des=0  then RtoST {VolaStr1}(pyor(arvR), Tab, S)  else RtoSD {VolaStr2}(arvR, Tab, Des, S);       Result := S;   END;
FUNCTION fRkilo0(oh :integer;  arvR :Real;  tab,des :Integer) :String;      BEGIN
   result := fRkilo0_(oh,FALSE,       arvR, tab,des);  end;
FUNCTION fRkilo0_PRO(oh :integer;  arvR :Real;  tab,des :Integer) :String;      BEGIN //+7.0.1
   result := fRkilo0_(oh,PRO_Demo,arvR, tab,des);  end;

   FUNCTION fRkil5x_(oh :integer;  aliPRO :boolean;  arvR :Real;  tab,des :Integer) :String;   VAR S :String;    BEGIN
      if (demo(5) OR aliPRO) and (oh=1)  then S := 'X.xx'  else
         IF arvR=0  THEN S := '- - - - -'
                    ELSE S := fRkilo0 (oh, arvR, tab,des);                          Result := S;   END;
FUNCTION fRkil5x(oh :integer;  arvR :Real;  tab,des :Integer) :String;      BEGIN
   result := fRkil5x_(oh,FALSE,       arvR, tab,des);  END;
FUNCTION fRkil5x_PRO(oh :integer;  arvR :Real;  tab,des :Integer) :String;      BEGIN //+7.0.1
   result := fRkil5x_(oh,PRO_Demo,arvR, tab,des);  END;

FUNCTION fMm2Des (mm2 :Real;  tab :integer) :string;      VAR i :integer;     begin             //<+6.2.16
   i := 0;   if mm2<3  then i := 1;
   result := fRmrkt0 (mm2,tab,i);  end;

FUNCTION fBmrkt0(arvB :Boolean;  tab :integer)  :String;   VAR S,Sa :String;    BEGIN //TAB=0=kokon.
   if arvB   then S := 'TRUE'  else S := 'FALSE';   Sa := '';
   if tab>0  then //begin  for i := 1 to tab  do   if Length(S)>=i  then Sa := Sa+S[i];  end
                  Sa := Copy(S,1,tab)
             else Sa := S;
   if AnsiUpperCase(Sa)='TR'  then Sa := 'tr'  else Sa := 'FA'; //<+141.1:  tr pieneksi, fa isoksi.
   result := Sa;  END;
function fBmrkt2(boo :boolean) :string;   begin result := fBmrkt0(boo,2);  end;       //<+1415f: TR tai FA
FUNCTION fBmrkt_(arvB :Boolean;  tab :integer)  :String;   VAR S,Sa :String;    BEGIN //TAB=0=kokon.
   if arvB   then S := 'TRUE'  else S := 'FALSE';   Sa := '';
   if tab>0  then Sa := Copy(S,1,tab)
             else Sa := S;
   if AnsiUpperCase(Sa)<>'TR'  then Sa := '--'; //<+141.1:  fa => '--'.
   result := Sa;  END;

procedure Imrkt0(arvI :Integer;   tab :Integer;  VAR S :String);       BEGIN
   RtoST {VolaStr1}(arvI, Tab, S);    END;
procedure Rmrkt0(arvR :Real;  tab,des :Integer;  VAR S :String);       BEGIN
   RtoSD {VolaStr2}(arvR, Tab, Des, S);   END;

//,KUTSU: strg := fDemI (OH, arvI, tab);   esim. 3x.INC:ssä <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   FUNCTION fDemI_(oh :Integer;  aliBoo :Boolean;  arvI,tab :Integer) :string;   BEGIN
      IF (demo(6) OR aliBoo) AND (oh>0)  THEN Result := 'DemoX'    //<'OH=0 =arvI tulostet ilman DEMOtestiä
                          ELSE Result := fImrkt0 (arvI, tab);   END;
FUNCTION fDemI (oh :Integer;  arvI,tab :Integer) :string;   BEGIN
   result := fDemI_(oh,FALSE,         arvI,tab);   END;
FUNCTION fDemI_PRO (oh :Integer;  arvI,tab :Integer) :string;   BEGIN //+7.0.1
   result := fDemI_(oh,PRO_Demo,arvI,tab);   END;

   FUNCTION fDemIx_(oh :Integer;  aliBoo :Boolean;  arvI,tab :Integer) :string;      VAR boo :boolean;      BEGIN
   {  IF demo AND (oh>0)  THEN Result := 'Xxx'                 //<'OH=0 =arvI tulostet ilman DEMOtestiä
                          ELSE Result := fImrkt0 (arvI, tab);   END;}
    //IF demo AND ((oh=1) or  (oh=2) and (tuxV<9))             //< OH=0 =arvI tulostet ilman DEMOtestiä.  -8.0.0
      boo := Demo(7);
      IF (boo OR aliBoo) AND ((oh=1) or  (oh=2) and (tuxV<9)) //< OH=0 =arvI tulostet ilman DEMOtestiä.   +8.0.0
         THEN Result := sDemI                                 //< 1 = Aina Xxx   2 = Tod.arvot, jos >8
         ELSE Result := fImrkt0 (arvI, tab);
     {if boo OR aliBoo
         then if oh>999  then beep;}
   END;
FUNCTION fDemIx (oh :Integer;  arvI,tab :Integer) :string;   BEGIN
   result := fDemIx_(oh,FALSE,         arvI,tab);  END;
FUNCTION fDemIx_PRO (oh :Integer;  arvI,tab :Integer) :string;   BEGIN //+7.0.1
   result := fDemIx_(oh,PRO_Demo,arvI,tab);  END;

   FUNCTION fDemR_(oh :Integer;  aliBoo :Boolean;  arvR :real;  tab,des :Integer) :string;   BEGIN //DemoX
      IF (demo(8) OR aliBoo) AND (oh>0)  THEN Result := 'DemoX'       //<'OH=0 =arvR tulostet ilman DEMOtestiä
                          ELSE Result := fRmrkt0 (arvR, tab,des);   END;
FUNCTION fDemR (oh :Integer;  arvR :real;  tab,des :Integer) :string;   BEGIN //DemoX
   result := fDemR_(oh,FALSE,         arvR,tab,des);  END;
FUNCTION fDemR_PRO (oh :Integer;  arvR :real;  tab,des :Integer) :string;   BEGIN //DemoX  +7.0.1
   result := fDemR_(oh,PRO_Demo,arvR,tab,des);  END;

   FUNCTION fDemRx_ (oh :Integer;  aliBoo :Boolean;  arvR :real;  tab,des :Integer) :string;   BEGIN
   {  IF demo AND (oh>0)  THEN Result := 'X.xx'                //<'OH=0 =arvR tulostet ilman DEMOtestiä
                          ELSE Result := fRmrkt0 (arvR, tab,des);   END;}
      IF (demo(9) OR aliBoo) AND ((oh=1) or  (oh=2) and (tuxV<6)) //< OH=0 =arvR tulostet ilman DEMOtestiä
         THEN if des>0  then Result := sDemR                  //< 1 = Aina Xxx   2 = Tod.arvot, jos >8
                        else Result := sDemI
         ELSE Result := fRmrkt0 (arvR, tab,des);   END;
FUNCTION fDemRx (oh :Integer;  arvR :real;  tab,des :Integer) :string;   BEGIN
   result := fDemR_(oh,FALSE,         arvR,tab,des);  END;
FUNCTION fDemRx_PRO (oh :Integer;  arvR :real;  tab,des :Integer) :string;   BEGIN //+7.0.1
   result := fDemR_(oh,PRO_Demo,arvR,tab,des);  END;

   FUNCTION fDemRxx_ (oh :Integer;  aliBoo :Boolean;  arvR :real;  tab,des :Integer) :string;   BEGIN //Xxx +7.0.4
      IF (demo(10) OR aliBoo) AND (oh=1)                          //< OH=0 =arvR tulostet ilman DEMOtestiä
         THEN Result := sDemI
         ELSE Result := fRmrkt0 (arvR, tab,des);   END;
FUNCTION fDemRxx_PRO (oh :Integer;  arvR :real;  tab,des :Integer) :string;   BEGIN //+7.0.4  Xxx
   result := fDemRxx_(oh,PRO_Demo,arvR,tab,des);  END;

//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
FUNCTION fDemMrkt (des :Integer) :String;      BEGIN                       //< R/Int:  x.Demo/xDemo
   if des=0  then result := 'xDemo'                                        //'NolaS.INC  1x
             else result := 'x.Demo';  END;                                //'Y_         2x
//,KUTSU: sijMrkt(arvR, tab,des, Cell[col,row]);, esim. NolaZ.INC:ssä<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
PROCEDURE DemMrkt_(oh :Integer;  arvR :Real;  tab,des :Integer;  VAR S :String);   BEGIN         //NolaZ.INC 20x
   IF demo(11) AND (oh>0)  THEN S := fDemMrkt(des)            //'OH=0 =arvR tulostetaan ilman DEMOtestiä
                       ELSE S := fRmrkt_(arvR, tab,des);  END;
FUNCTION fDemMrkt0(oh :Integer;  arvR :Real;  tab,des :Integer) :string;   BEGIN                 //NolaS.INC 8x
   IF demo(12) AND (oh>0)  THEN result := fDemMrkt(des)       //'OH=0 =arvR tulostetaan ilman DEMOtestiä
                       ELSE result := fRmrkt0(arvR, tab,des);  END;

{================================================================================================================}
function MukanaOs (CONST str1,str2 :string;  VAR os :integer) :boolean;  begin //<,,CONST +6.0.3
    os := AnsiPos (AnsiUpperCase(str1), AnsiUpperCase(str2));       //<Testaa isoilla kirj:lla onko mukana, PAL os.
    if os>0  then result := true  else result := false;   end;                           //'AnsiPos +6.0.3
function Mukana (CONST sa,sb :string) :boolean;      begin                                       //<+6.0.2
   result := false;
   if AnsiPos (AnsiUpperCase (sa),AnsiUpperCase (sb)) >0                                 //<AnsiPos +6.0.3
      then result := true;   end;
function Mukan_1 (CONST sa,sb :string) :boolean;      begin                                      //<+6.0.2
   result := false;
   if AnsiPos (AnsiUpperCase (sa),AnsiUpperCase (sb)) =1                                 //<AnsiPos +6.0.3
      then result := true;   end;
function Iso (CONST str :string) :string;      begin        //<,,+1414e Muuttaa isoiksi kirjaimiksi.
   result := AnsiUpperCase(str);  end;

function SamIso (CONST str1,str2 :string) :boolean;      begin  //<Testaa isoilla kirj:lla onko samat
   {stg1 := AnsiUpperCase(stg1);   stg2 := AnsiUpperCase(stg2); //< -result := ... if ... -6.0.3
    result := stg1=stg2;                                                //='832 ms 3-josaa alku -> PrLrj}
  //result := 0=AnsiCompareText (stg1,stg2);   //<Without case sensitivity, 651 ms
  //result := AnsiSameText (stg1,stg2);        //<Without case sensitivity, 651 ms
   {if 0=CompareText ('äÄ','ÄÄ')
       then beep
       else beep;}
    result := 0=CompareText (str1,str2);       //<Without case sensitivity, 201 ms
end;
{================================================================================================================}

FUNCTION sRdim (merkitsevia :integer;  alpr :Real;  VAR Dim :string) :string; //<Strng ALPR:stä + dimensio 'm..T'
      VAR Expn,d,N :integer;  ar :real;  sr :string;                          //ks. \EdvNj\3merkitsevaaKoe.INC
                                         //''MERKITSEVIA = esim. 3:  1.234 -> 1.23   0.1234 -> 0.12  100.1 -> 100
   procedure sijDim;      VAR Exn :integer;  s :string;      begin
      s := '';   Exn := Expn;
      if Exn < 0
      then begin
           Exn := (-1)*Expn;
           case Exn of 0 :;   1..3 :s := 'm';   4..6 :s := FONT_MYY;
                              7..9 :s := 'n';    else s := 'p';  end;  end
      else case Exn of 0 :;   1..3 :s := 'k';   4..6 :s := 'M';  else s := 'T';  end;
      Dim := s;
   end;
BEGIN//.................................................................
   //merkitsevia := 4;
   N := merkitsevia;
   Expn := 0;  ar := Abs (alpr);
   if alpr=0  then  begin end  //<Ei tehdä mittän = oli 0 eli Expn=0
   else begin
        if ar>=1
        then begin
           while fMuokDes (ar/1000,N-1) > 1  do begin
                 ar := ar / 1000;   Expn := Expn +3;  end;
           sr := fRmrkt0 (ar,1,N-1);
           d := Pos ('.',sr);
           while (d=N+1) and (Length(sr)>=N+1)  or        //< 100.00  -> 100  =3 merkitsevää numeroa
                 (d<N+1) and (Length(sr) >N+1)  DO        //< 99.9, 9.99      =3 merkitsevää numeroa
                 Delete (sr, Length(sr),1);   end
        else begin
           while fMuokDes (ar,N-1) < 1  do begin
                 ar := ar * 1000;   Expn := Expn -3;  end;
           sr := fRmrkt0 (ar,1,N-1);
           d := Pos ('.',sr);
           while (d=N+1) and (Length(sr)>=N+1)  or        //< =3 merkitsevää numeroa
                 (d>N+1) and (Length(sr) >N+1)  DO        //< =3 merkitsevää numeroa
                 Delete (sr, Length(sr),1);
        end;//else
   end;//else
   sijDim;
 //sr := sRmrkt0vex (ar,1,2);
   d := Pos ('.',sr);                                     //'Poistaa '.' :n jälkeiset NOLLAt
   while (d>0) and ( (CharInSet(sr[Length(sr)], ['.',','])) OR (sr<>'') and (sr[Length(sr)]='0') )  do //<1414d: sr<>''
      if (Length(sr)>0) and CharInSet(sr[Length(sr)], ['.',',']) //<Pilkku turhaa. Kopioitu sRmrkt0vex FNC :stä
      then begin                                                 //'1414d: +Length(sr)>0
           Delete (sr, Length(sr),1);                     //<'Vika mrk vex jos '.' tai '0'
           Break;  end                          //<'.' ja ',' :n jälk, muuten jatkaa pilkunEd.nollien pyyhkimistä
      else Delete (sr, Length(sr),1);                     //<'Vika mrk vex jos '.' tai '0'

   if alpr<0  then sr := '-'+sr;
   result := sr;
end;//fRdim   
{==================================================================================================}
FUNCTION RadToDeg (RadKulma :Real) :Real;   VAR Deg :real;   begin //<Palauttaa RADIAALisen kulman ASTEperusteisena
   Deg := RadKulma * 180 / 3.1415927;
   result := Deg;  end;
FUNCTION DegToRad (DegKulma :Real) :Real;   VAR Rad :real;   begin //<Palauttaa ASTEperusteisen kulman RADIAALisena
   Rad := DegKulma *3.1415927 / 180;
   result := Rad;  end;
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,DOS: Pascal\Vakiot\LueavVakA.INC :stä}
FUNCTION tang (kulma :Real) :Real;     BEGIN   //<Palauttaa TANGENTIN ASTEperusteisesta kulmasta
   kulma := DegToRad (kulma);
   tang := sin (kulma) / cos (kulma);  END;
FUNCTION arcTang (tang :Real) :Real;   BEGIN  //Palauttaa TANGENTISTA KULMAN ASTEINA
  arctang := arctan (tang) * 180 / 3.1415927;   END;
FUNCTION sini (kulma :Real) :Real;   BEGIN    //<Palauttaa SININ ASTEperusteisesta kulmasta
   kulma := DegToRad (kulma);
   sini := sin (kulma);  END;
FUNCTION cosi (kulma :Real) :Real;   BEGIN    //<Palauttaa COSININ ASTEperusteisesta kulmasta
   kulma := DegToRad (kulma);
   cosi := cos (kulma);  END;
FUNCTION arcCosi (cosn :Real) :Real;      VAR k,ar :real;      BEGIN //Palauttaa COSINISTA KULMAN ASTEINA
{ar := cosi (0);   EiOkInfo (fRmrkt0(ar,1,20));
ar := cosi (45);  EiOkInfo (fRmrkt0(ar,1,20));
ar := cosi (90);  EiOkInfo (fRmrkt0(ar,1,20));}
   k := 180 / 3.1415927;
{ar := ArcCos (1)*k;      EiOkInfo ('1  '     +fRmrkt0(ar,1,20));
ar := ArcCos (0);        EiOkInfo ('0/9999  '+fRmrkt0(ar,1,20));
ar := ArcCos (0.707)*k;  EiOkInfo ('0.707  ' +fRmrkt0(ar,1,20));}
  ar := ArcCos (cosn) * k;
  result := ar;   END;
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Uudelle tietorakenteelle:,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
(*function SokI (s :string;  VAR i :integer): boolean;      var k,j,code :integer;      begin
   for k := 1 to Length (s)  do if s[k]=' '  then Delete (s,k,1)  //<Alkutyhjät vex  +4.0.0
                                             else Break;
   for j := k to Length (s)  do                    //<,,Putsataan kokonaisluvun jälkeisestä välistä lähtien
   if s[j]=' '  then begin
      Delete (s,j,Length (s));                     //<'' +3.0.3
      Break;  end;

  Val(s,i,Code);                                   //< code <> 0  =Luku ei muodostunut oikein
  if code=0  then SokI := true                     //'VAL muokkaa TEXT :stä i :lle arvon, jos CODE=0
             else SokI := false;  //end;
             {Y_Koe (2,'Y_/okI ='+fImrkt0(i,1)+'  Code='+fImrkt0(Code,1));  }end;*)
function SokI (s :string;  VAR k :integer): boolean;      VAR i{,code} :integer;  sa :string;      begin
   s := Trim (s);
   k := Pos (' ',s);
   if k>0  then s := Copy (s,1,k-1);               //<Kopioidaan alusta vikaan arvomerkkiin =esiintymä -1
   k := Pos (',',s);
   if k>0  then s[k] := '.';                       //<Muutetaan desim.PILKKU PISTEEKSI
   k := Pos ('.',s);
   if k=1  then s := '0' +s;                       //< .XX -> 0.XX =Tod.näk -> FNC := 0
   k := Pos ('.',s);
   if k>0  then s := Copy (s,1,k-1);               //<Muutetaan Real-luku INT :ksi desim.mrkiin asti
//   if s='-0'  then s := '0';                     //<Ei tarvise lisätä (ei ole ollut aikaisemminkaan 6.2.4).

 {Val(s,k,Code);                                   //< code <> 0  =Luku ei muodostunut oikein
  if code=0  then result := true                   //'VAL muokkaa TEXT :stä i :lle arvon, jos CODE=0
             else result := false;}                //<'Teki 'x125 => 293 vaikka Code=0 !!!!!!!!!!!! -6.2.2
  result := true;                                                                              //<,,+6.2.2
  s := Trim (s);
  if (s<>'') and  NOT (CharInSet(s[1], ['-','0'..'9']))  OR //<Oli '-','1'..                                  6.2.4
     (s='')                                                                                      //<+7.0.4
  then result := false
  else begin
       sa := s;
       if (sa<>'') and (sa[1]='-')  then Delete (sa,1,1);   //<Etumerkki vex.  1414d:  +sa<>''
       for i := 1 to Length (sa)  do
       if NOT (CharInSet(sa[i], ['0'..'9']))  then begin
          result := false;
          Break;  end;
  end;
//SokIFileen('#SokI  :' +s);                        //Kirjoittaa fileen =näkyy virheen aihauttaja vikana. 130.3u
   if result  then begin                            //,Tutkitaan etumerkillistä merkkijonoa.
                      {if s=''  then s := '0';
                       Val(s,k,Code);                                //< code <> 0  =Luku ei muodostunut oikein
                       Result := Code=0;  end;}                      //<+''130.3u
      k := StrToInt (s);                            //<"05212721101"  34212721101
                  //http://www.freepascal.org/docs-html/rtl/sysutils/strtoint.html     2147483647 =MaxInt (+/-)
                  {_Try
                      k := StrToInt (s);                            //<"05212721101"  34212721101
                    except
                      On E : EConvertError do
                        ShowMessage('Invalid number encountered');
                    end;_}
   end;
end;//SokI
function fSokI (s :string) :integer;      VAR i :integer;      begin //+141.1
   SokI(s,i);
   result := i;
end;
{                                                          //,,Testiajoon:  Muuta ed.SokI => SokI_
function SokI (s :string;  VAR k :integer) :boolean;      VAR m :integer;      begin
                           result := SokI_ ('-0',m);          if Result and NOT result  then ;
   if m=-999  then beep;   result := SokI_ ('-0.',m);         if Result and NOT result  then ;
   if m=-999  then beep;   result := SokI_ ('-0.1',m);        if Result and NOT result  then ;
   if m=-999  then beep;   result := SokI_ ('-0.10',m);       if Result and NOT result  then ;
   if m=-999  then beep;   result := SokI_ (' -0. 1',m);      if Result and NOT result  then ;
   if m=-999  then beep;   result := SokI_ ('-0.9',m);        if Result and NOT result  then ;
   if m=-999  then beep;   result := SokI_ ('  1',m);         if Result and NOT result  then ;
   if m=-999  then beep;   result := SokI_ ('123456',m);      if Result and NOT result  then ;
   if m=-999  then beep;   result := SokI_ ('-123456',m);     if Result and NOT result  then ;
   if m=-999  then beep;   result := SokI_ ('-123456,7',m);   if Result and NOT result  then ;
   if m=-999  then beep;   result := SokI_ ('12',m);          if Result and NOT result  then ;
   if m=-999  then beep;   result := SokI_ ('666',m);         if Result and NOT result  then ;

   if m=-999  then beep;   result := SokI_ (s,k);
end;//SokI}
//---------------------------------------------------------------------------------------------------------------
function SokR (s :string;  VAR RX :real): boolean;           //£STR. How to disable scientific notation in StrToFloat in Delphi ????????????????????????????
  {procedure EriBiip (Hz :integer);     begin end;{          //<Nyt suljettu vex:  aiheutti ti-ty-ti-ty.. piippisarjan FNC fRmrkt0´sta
      if IsDebuggerPresent  then Windows.Beep (Hz,50);  end; //<Jotta ilman BreakPointiakin tieto, jos käytiin täällä, 50ms.}
      function mrkOK (c :char) :boolean;       begin //<+130.2e
         result := (s<>'') and CharInSet(c,['0'..'9','.','-']); end; //<+130.2e:  "-" lisätty.
                //,NRO vain dbugissa kertoo testirivin LocalVariab.  //,poNAY näkyy debuggerin Local Variable´ssa =R pitää näyttää tältä.  Uusittu 130.2e .
   procedure SokR_(nro :integer;  S :string;  VAR RX :real;  poNAY :string);     LABEL 1;   VAR sA{,sc,er} :string; {i,j,k,,x,}d :integer; {neg :boolean;}  begin
                                                                     //Vain Settings.PAS´issa olevat StrToFloat muuttamatta StrToFloatQ´ksi.
      sA := S;                                                       //<Talteen debuggiin.   (Pos('4,517',S)>0) or (Pos('4.517',S)>0) or (Pos('517',S)>0)
      StoSok_e5(s);
      RX := 0;
      if (S<>'') and mrkOK(S[1])
      then begin                           //,OLI: Val(S,R,i) i <> 0  =Luku ei muodostunut oikein.  -130.2e ..mutta ei riippuvainen maa-asetuksista '.','.' .
         RX := StrToFloatQ (S);                       //'Pitää saada tieto onko OK.  ,,130.2e: S=0.000098 => 9.8E-5000, joten käytettävä StrToFloatQ
                 //if isDebuggerPresent  then WBeep([500,100, 1000,100]);  //Koklattu: try ShowMessage(er); except ..
         result := true;  end                         //',,Debuggeri näyttää kyllä ',' eikä '.', jos on SysUtils.FormatSettings.DesimSeparator := '.'
      else result := false;                     //,How to disable scientific notation in StrToFloat in Delphi: ##############################################
      if (S<>poNAY)  then begin                 //'http://stackoverflow.com/questions/11665298/delphi-floattostr-why-is-the-display-different
         d := Pos(',',poNAY);                   //'##########################################################################################################
         if d>0  then poNAY[d] := '.';
        {if (S<>poNAY) and isDebuggerPresent  then
            WBeep([1000,200, 0,100, 3000,200, 0,100, 200,200]); //[Hz,ms..  0,xx =paussi.]}
      end;
      if S='!"#¤'  then ;
   end;//SokR_........................                //r := FloatToStrF(amount1, ffExponent, arvoA,DES);//'VAL muokkaa TEXT :stä i :lle arvon, jos CODE=0
                                                      //FormatFloat('0.0000', r);
begin//SokR.................//<3x0 desim´n alussa => tulee R oikein!!!!!!! Minimi arvo ettei vielä scientific mode = 0.0001 (Delphissä tieto väärin 0.00001 .
  {SokR_ (1,'a0012b3,45600a',rx, '123.456'  ); //<,,Eka nro vain helpottaa debug´ssa näkemään, mikä alp kokeilurv on kyseessä.
   SokR_ (2,'a123,456a'     ,rx, '123.456'  );
   SokR_ (3,'a 123.456 a'   ,rx, '123.456'  );
   SokR_ (4,'-.00098'       ,rx, '-0.00098' );
   SokR_ (5,'-0.00098'      ,rx, '-0.00098' );
   SokR_ (6,'0,00009800'    ,rx, '9,8e-05'  ); //<,Minimi reaaliarvo desimMuodossa =0.0001 .
   SokR_ (7,'-0.00009800'   ,rx, '-9,8e-05' );
   SokR_ (8,'0,00098'       ,rx, '0,00098'  );
   SokR_ (9,'0.0009800'     ,rx, '0.00098'  );
   SokR_(10,'0,0009800'     ,rx, '0,00098'  );
   SokR_(11,'0.0098'        ,rx, '0.0098'   );
   SokR_(12,'0,0098'        ,rx, '0,0098'   );
   SokR_(13,'123,000'       ,rx, '123'      );
   SokR_(14,'5,0'           ,rx, '5'        );
   SokR_(15,'1,000'         ,rx, '1'        );
   SokR_(16,'-1,000'        ,rx, '-1'       );
   SokR_(17,'0,1000'        ,rx, '0,1'      );
   SokR_(18,'0,1'           ,rx, '0,1'      );
   SokR_(19,'1'             ,rx, '1'        );  //}
  {SokR_(20, '1.234'        ,rx, '1.234'); //
   SokR_(21, '5.5'          ,rx, '5,5');
   beep;//}

   SokR_(0,S,RX,'');
end;//SokR
//---------------------------------------------------------------------------------------------------------------

function SokB (CONST s :string;  VAR b :boolean) :boolean;      var boo :boolean;    begin
  boo := false;  b := false;
  if AnsiSameText (s,'TRUE')   then begin  boo := true;  b := true;   end  else
  if AnsiSameText (s,'FALSE')  then begin  boo := true;  b := false;  end;
  result := boo;  end;                   //'''''''''''TRUE koska arvo oikein annettu <<<<<<<<<<<<<<<
function SokS (CONST s :string;  VAR ss :string): boolean;       begin
  {if s<>''  then begin }SokS := true;  ss := s;  end;
  {          else        SokS := false;  end;}
//==================================================================================================
 (*function fHaePolkuFilen (FileName :string) :string;      VAR {InstallDir,}FileStr :string;      begin//Ei enää käytössä -12.0.01/13å51  -130.0
      //Kopioitu DEVELOPER2 Z_PaaVal.PAS :sta              //'Yhdistetty +Siirrtty tänne KaapHin.INC,TaryfHin.INC,KatuvalF.INC´stä 12.0,05 .
     {InstallDir := myRegSettings.GetStringValue(SETTINGS_USED, PROGRAM_DIR_ID);}
      FileStr :=    myRegSettings.GetStringValue(SETTINGS_USED, FileName);
DefsFileenZ('Y_.INC: gHaePolku:  SETTINGS_USED=' +SETTINGS_USED +CR +' ®® FileName=' +FileName +' ®® FileStr=' +FileStr); //<+12.0.07
      Result := {InstallDir -12.0.05+}gAjoConfPath +FileStr; //<"\" lisää väliin +120.4, vex 120.5u
   end;*)
//==================================================================================================
//,,TalInif: SIIRRÄ TARVITTAESSA VÄLIAIKAISESTI MUUALLE JOTTA DEBUGGERI PYSYISI oikeilla RIVEILLÄ.
function TalInif (oha :integer;  AOfile :TInifile;   CONST sectionS,keyS :string;  s :string) :boolean;      begin
//Result := false;
  try
     AOfile.WriteString (sectionS,keyS,s);
     AOfile.UpdateFile;                    //<+1415f: Tallettää fyysisesti ja näkyy heti FileExplore´rissa, todettu, OK.
     Result := true;
  except
      on E :Exception  do begin
      case oha of
         1 :s := 'Edeltävän verkon tiedoston';
         2 :s := 'Nousujohtolaskennan tiedoston';     //<Sis. myös häviökust. parametrit.
       //3 :s := 'Häviökustannuslaskennan tiedoston'; //<-1414: On jo ed´ddä.
      else  s := 'Moottorilähtöjen tiedoston';  end;  //<1414: Oli siis 4, nyt 3.
      EiOKinfo (s +' TALLETUSvirhe');
      Result := false;  end;
   end;//except
end;//TalInif

function LueTalInifVersio (oha :integer;  LUE :boolean;  AOfile :TInifile) :boolean;
      const err='X_Q_Z_987654321';   VAR s :string;      begin
   Result := false;
try
   if LUE
   then begin {s := AOfile.ReadString (VersionSec,VersionMajorKey,err); //<,Näille piäisi varata glob.
               if s=err  then xx := ''  else xx := s;                   // muuttujat ennen sijoitusta
               s := AOfile.ReadString (VersionSec,VersionMajorKey,err); // ja käyttöä, jota eioo vielä
               if s=err  then xx := ''  else xx := s;                   ...
               s := AOfile.ReadString (VersionSec,ProjectKey,err);  s    ...
               if s=err  then xx := ''  else xx := s;
               s := AOfile.ReadString (VersionSec,FileTypeKey,err);     ...
               if s=err  then xx := ''  else xx := s;                   }
               s := AOfile.ReadString (VersionSec,FileCreatedKey,err);   if s=err  then s := '';
                  case oha of 1 :EdvFileCreated := s;
                              2 :NjFileCreated := s;
                            //3 : ;                         //< HävKustFile.  1414: sis. NjFileeseen.
                         else    MoFileCreated := s;   end; //< MoottorilähtöFile (4)
        Result := true;
   end//if LUE
   else begin  s := fImrkt0 (PROGRAM_VERSION_MAJOR,1)   +'.' +fImrkt0 (PROGRAM_VERSION_MINOR,1)   +'.' +fImrkt0 (PROGRAM_VERSION_RELEASE,1) +'/' +
                    PROGRAM_BUILD_DATE;
               if NOT TalInif (oha,AOfile, VersionSec,VersionKey,       s                               )     then Exit;//<+1415f: On joskus jätettyVex.
               if NOT TalInif (oha,AOfile, VersionSec,VersionMajorKey,  fImrkt0 (PROGRAM_VERSION_MAJOR  ,1))  then Exit;
               if NOT TalInif (oha,AOfile, VersionSec,VersionMinorKey,  fImrkt0 (PROGRAM_VERSION_MINOR  ,1))  then Exit;
               if NOT TalInif (oha,AOfile, VersionSec,VersionReleaseKey,fImrkt0 (PROGRAM_VERSION_RELEASE,1))  then Exit;
                  s := '';
                  case oha of 1 :s := EdvFileType;
                              2 :s := NjFileType;
                            //3 : ;                        //< HävKustFile.  1414: sis. NjFileeseen.
                         else    s := MoFileType;     end; //< MoottorilähtöFile (4)
               if NOT TalInif (oha,AOfile, VersionSec,FileTypeKey,     s)  then Exit;
               if NOT TalInif (oha,AOfile, VersionSec,DescriptionKey, '')  then Exit;
                  case oha of 1 :s := EdvFileCreated;
                              2 :s := NjFileCreated;
                            //3 : ;                        //< HävKustFile.  1414: sis. NjFileeseen.
                         else    s := MoFileCreated;  end; //< MoottorilähtöFile (4). 1414 4=>3
                  if s=''  then s := DateTimeToStr(Now);
               if NOT TalInif (oha,AOfile, VersionSec,FileCreatedKey, s)  then Exit;
                  s := DateTimeToStr(Now);
               if NOT TalInif (oha,AOfile, VersionSec,FileModifiedKey,s)  then Exit;
        Result := true;  end;
except
   on E :Exception  do begin       //<TalInif hoiti herjat #########################################
      Result := false;
      Exit;  end;
end;//except
end;//LueTalInifVersio

{-------------
function LueInifAlkio (AOfile :TInifile;  sectionS :string;  VAR alkio :arvoTyyp) :boolean;
    const err='X_Q_Z_987654321';      var s :string;      begin
    const err='X_Q_Z_987654321';  var s,ss :string;  ii :integer;  rr :real;  bb,fnc :boolean;  begin
  fnc := true;
  s := AOfile.ReadString (sectionS,alkio.Tunniste,err);
  if s=err                                                 //<ERR = merkkijono, joka sijoitetaan ar-
  then fnc := false                                        //'voksi, jos luku ei onaa tms.lukuvirhe.
  else case alkio.arvTyp of
    Intg :if SokI (s,ii)  then alkio.arvInt := ii   else fnc := false;
    Reaa :if SokR (s,rr)  then alkio.arvRea := rr   else fnc := false;
    Bool :if SokB (s,bb)  then alkio.arvBoo := bb   else fnc := false;
    Strg :if SokS (s,ss)  then alkio.arvStr := ss   else fnc := false;
  end;//case
  if fnc  then SijStrAlkio (s, alkio);                     //<Asetti FNC := FALSE, jos matoja ######-------}

function LueInifAlkio (AoFile :TInifile;  CONST sectionS :string;  VAR alkio :arvoTyyp) :boolean;
    const err='X_Q_Z_987654321';      VAR s :string;      begin
  s := AOfile.ReadString (sectionS,alkio.Tunniste,err);
  if (alkio.ArvoTyp=Bool)  then
     if (Pos('FA',AnsiUpperCase(s)) >0)
        then s := 'FALSE'
        else s := 'TRUE';                                  //<141.1:  Olet-Ev 2s2j.NOE´ssa Bool oli kirjoittunut FA´ksi, mikä aiheutti virheen luvussa.
  if s=err                                                 //<ERR = merkkijono, joka sijoitetaan ar-
  then Result := false                                     //'voksi, jos luku ei onaa tms.lukuvirhe.
  else Result := SijStrAlkio (s, alkio);                   //<Asetti FNC := FALSE, jos matoja ######
end;//LueInifAlkio

{function LueInifAlkio (AoFile :TInifile;  CONST sectionS :string;  VAR alkio :arvoTyyp) :boolean;
    const err='X_Q_Z_987654321';  io=999;      VAR s :string;  ii :integer;      begin
  Result := true;
  if alkio.arvoTyp=Intg                                        //<,+1202:  ei pystynyt lukemaan str, koklaus toimiiko näin. KESKEN.
  then begin AoFile.ReadInteger (sectionS,alkio.Tunniste,ii);
             if ii=io
                then Result := false;  end
  else begin AoFile.ReadString (sectionS,alkio.Tunniste,err);
             if s=err                                      //<ERR = merkkijono, joka sijoitetaan ar-
                then Result := false;                      //'voksi, jos luku ei onaa tms.lukuvirhe.
  end;
  if Result then
     Result := SijStrAlkio (s, alkio);                     //<Asetti FNC := FALSE, jos matoja ######
end;//LueInifAlkio}

function TalInifAlkio (oha :integer;  AoFile :TInifile;  CONST sectionS :string;  alkio :arvoTyyp) :boolean;
      VAR s :string;      begin
   Result := false;
   try
      case alkio.arvoTyp of
         Intg :s := fImrkt0 (alkio.arvoInt,1);
         Reaa :s := fRmrkt0 (alkio.arvoRea,1,fTdsm (alkio,alkio.arvoRea));
         Bool :s := fBmrkt0 (alkio.arvoBoo,0);
         Strg :s := alkio.arvoStr;
      end;//case
      if TalInif (oha,AOfile, sectionS,alkio.Tunniste,s)  then Result := true;
   except
   on E :Exception  do begin       //<TalInif hoiti herjat #########################################
      Result := false;  end;
   end;//except
{-case alkio.arvTyp of
    Intg :AOfile.WriteInteger (sectionS,alkio.Tunniste,alkio.arvInt);
    Reaa :begin Stg (alkio.arvRea:1:20, s);  i := Length (s);         //<Desim.osa 20 merkkiä pitkä
                while (i>1) and (s[i] IN ['0','.'])  do i := i-1;     //<Vika '.'kin vex ->Integer
                Stg (alkio.arvRea:1:i, s);                            //<Nyt osattiin muokataHaluttu
                AOfile.WriteString  (sectionS,alkio.Tunniste,s);  end;
    Bool :AOfile.WriteBool    (sectionS,alkio.Tunniste,alkio.arvBoo);
    Stg  :AOfile.WriteString  (sectionS,alkio.Tunniste,alkio.arvStr);  end; ---------------------OK}
end;//TalInifAlkio
//==================================================================================================
procedure TallErrInfo;    begin
  //MessageDlg( 'Talletus ei onnistunut. Tarkista asema ja yritä uudelleen.',mtWarning,[mbOK],0); end;
  InfoDlg ('Talletus ei onnistunut. Tarkista asema ja yritä uudelleen.',
            mtWarning,  'OK','','','',  '','','','');  end;

procedure teePolkuDir (CONST Filen :string);      VAR stg :string;    begin //<Käyttö talletuskutsuissa
   stg := ExtractFilePath(Filen);  //<Pelkkä polku ilman filenimeä          //'=tekee tarvittaessaDIRrin
   if stg<>''  then ForceDirectories (stg);
end;

{procedure teeFilenData (CONST Filen :string);      VAR stg :string;    begin //<Käyttö talletuskutsuissa
   stg := ExtractFilePath(Filen);  //<Pelkkä polku ilman filenimeä          //'=tekee tarvittaessaDIRrin
   if stg<>''  then ForceDirectories (stg);                                 //<1414fu: \Data t. \Congig
end;}
{function teePolkuConfFilen (s :string) :string;      VAR polku :string;      begin //<,,+1414fu
  polku := IncludeTrailingPathDelimiter (ExtractFilePath (Application.ExeName));
  result := polku +'Config\' +s;
end;}

//,,¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
   procedure  wri(si :string);     begin end; (*VAR f :TextFile;  fn :string;  Lstz :TStringList;    begin //<,,+1414f,15f  VAIN LueTalFilenReg´IN KÄYTTÖÖN.
    //if isDeb  then begin                              if regexp(fname, '[/\*:?"<>|]', 'once')   do something about it?
      fn := ExtractFilePath (Application.ExeName); //< "\" tulee loppuun autom.
      fn := fn +DefsFileChkLueONdn_203;
      if fDirectoryExists(fn)  then begin
         fn := fn +'\RegWrX.TXT';  //<+1415f
         Lstz := TStringList.Create;                       //<Ei onannut.
         if xFileExists(fn)
            then Lstz.LoadFromFile(fn)                     //.Lines.LoadFromFile and SaveToFile.  <={Lines.} oli RTF´lle.
            else Lstz.Add(DateTimeToStr(Now));             //<Aikaleima alkuun.
         Lstz.Add(si);
         if Pos('(9)',si)>0                                //<,Välirv. loppuun.
            then Lstz.Add('');
         Lstz.SaveToFile(fn);
         Lstz.free;
      end;
   end;//*)

   function teePolkuDataFilen (oha :integer) :string;      VAR polku,FN :string;      begin //<,,-1414fu: Uusittu. Oli teefilen().
                              {polku := myRegSettings.GetStringValue(SETTINGS_USED, PROGRAM_DIR_ID);            //Nola.EXE
                               polku := polku +myRegSettings.GetStringValue(SETTINGS_USED, DATA_PATH_ID) +'\';  //AjotiedPATH}
     polku := IncludeTrailingPathDelimiter (ExtractFilePath (Application.ExeName)); //<Jos käynnistetty tikulta, tämä antaa kelpaamattoman DRVn polkuun.
     case oha of
        1 :FN := filen_EV;            //< 'Olet-Ev.NOE';
        2 :FN := filen_NJ;            //< 'Olet-Nj.NON';
      else FN := filen_MO; end;       //< 'Olet-Mo.NOM';
      polku := polku +'Data\';
      ForceDirectories (polku);
      result := polku +FN;
   end;//teePolkuDataFilen

//======================================================================================================================================================
//,,¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
//,,¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
//,,¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶,,,,UUSITTU 1415f,,¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
                                {JOS REG´ssä eioo FNää, täältä palautetaan "Olet-Ev.NOE" (.NON. t. NOM) ja se myös SAMALLA talletetaan jotta olisi ajan-
                                 tasalla. FileLst.PAS/PRC fLueTal_FileLista´ssa luetaan Lst´sta.
                                 1) if LUE:  TÄÄLTÄ FNC := TR VAIN JOS luettu DRV+PATH=OK jaFN on. JOS eiOK tai eioo => tehdään Olet-Ev.NOE (.NON,.NOM)
                                             nimi ja se talletetaan heti Reg´iin jotta ajantasalla.
                                 2) NOT Lue: FNC := TR, jos talletus Reg´iin onnistuu (yleensä aina).
                                 =============================================  K O K O N A A N  UUSITTU. =============================================}
//,,¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
//,,¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
//,,¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
//  ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶                                                                                    ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
//  ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶ Täältä ei saa kutsua selaista PRC, mistä kutsu tänne takaisin => Ikuinen silmukka. ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
//  ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶                                                                                    ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
//,,¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
//,,¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
//,,¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶,,,,UUSITTU 1415f,,¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
function LueTalFilenReg (OS :string;  oha :integer;  LUE,KYSY :boolean;  VAR annettuFn :string) :boolean; //< LopTal->KYSY 3.0.1
      VAR FNC,pthOK :boolean;  KEYnimi,Filen,sZ,{1415f:}alpRg,fnOle :string;  Z :integer{+1414fu TäälläLäpikäyntiKertalaskuri};
      CONST RED='';   CONST SINc='';   //CONST RED='<f n="" s="" c="255">';  CONST SINc='<f n="" s="" c="16711680">';

function BLue :string;   begin                          //<,,+1414f.
   if LUE then result := SINc +'LUKU'  else result := RED +'TALLETUS';  end;

//;;¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
begin//,,,LueTalFilenReg,,,,,,,,,,,,,,,,,,,,,Selvitetään SETTINGS -tiedoston ALKIOnimi #############,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      Z := 0;      //WBeep([100,100, 0,200, 300,100, 0,200, 500,100]); //[Hz,ms..  0,xx =paussi.]}
      sZ := myRegSettings.GetStringValue( Settings_Used, 'LapiRegKerta'); //<,Z=LäkikäyntiKertalaskuri: Luetaan edKertaNo. Helpottaa tapausjäljitystä tässä.
      Z := Z+1;   //<Nollaus CreateGlobals´ssa, jos Z>5000.
      YFileen('ß¶¿Y_.PAS/LueTalFilenReg 0: OS:' +OS +'  Oha:' +Ints(oha) +' Z:' +Ints(Z) +' Lue:' +BLue +' Kysy:' +fBmrkt0(KYSY,2) +' KEYnimi:"' +
                                           KEYnimi +'"  annettuFn: "' +annettuFn +'"');
   case oha of
      1 :KEYnimi := LastPreNet;             //< 'LastPreNet';
      2 :KEYnimi := LastBranch;             //< 'LastBranch'; 'LastCost';  1414: sis. NjFileeseen (LastBranch).
   else  KEYnimi := LastMotor;  end;        //< 'LastMotor';
               wri(Ints(Z) +'(0)  Oha:' +Ints(oha) +' S:' +Ints(Z) +' Lue:' +BLue +' Kysy:' +fBmrkt0(KYSY,2) +' KEYnimi:"' +KEYnimi +'"  annettuFn: "' +annettuFn +'"');
   alpRg := myRegSettings.GetStringValue( Settings_Used, KEYnimi);  //<Tutkitaan/Luetaan rekisteristä (registry).
   alpRg := Trim(alpRg);
   fnOle := teePolkuDataFilen(oha);
   pthOK := DRVok(alpRg); //DRVokJaFon(alpRg);
   FNC := false;                                                     //<Might not...
   if LUE  then FNC := (alpRg<>'') and pthOK and fFileExists(alpRg); //<Jos LUE, annettuFn´llä ei merkitystä.<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   if NOT FNC  then begin
      Filen := fnOle;
      myRegSettings.SetStringValue( Settings_Used, KEYnimi,fnOle);  end; //<..TALLETUS=Set..heti perään nimenannon jälk.

   if NOT LUE  then begin       //<,,T A L L E T U S <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      Filen := Trim(annettuFn);
      if Filen=''  then
         Filen := fnOle;
      case OHA of               //<,,+1414f:  Pitäiskos jos MYÖS LUE?
         1 :EdvFileN := Filen;
         2 :NjFilen := Filen;
         3 :MoFilen := Filen;
      end;
      FNC := myRegSettings.SetStringValue( Settings_Used, KEYnimi, Filen);   //<DRV oli edellä tarkisttu.
   end;
   annettuFn := Filen;  //if Length(alpD)>0  then ;
   Result := FNC;                           //<Tosin ei käytetty kertaakan if LueTal..
      myRegSettings.SetStringValue( Settings_Used, 'LapiRegKerta', Ints(Z));//<z=LäkikäyntiKertalaskuri, löytyy Reg´in R-alkuisista.
YFileen('¿¶Y_.PAS/LueTalFilenReg 9: OS:' +OS +' fnc=' +fBmrkt0(FNC,2) +' Filen: ' +Filen);
end;//LueTalFilenReg
//''¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
//''¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
//''¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
//======================================================================================================================================================

procedure tyhArvo (VAR alkio :arvoTyyp;  CONST nimi :string);      begin
   with alkio  do begin
      Tunniste := nimi;    onArvo := false; {arvTyp := Strg;}//Ei saa muuttaa ALUSTETTUA,muutenSEKOAA
      arvoInt := 0;        arvoRea := 0;    arvoBoo := false;    arvoStr := '';
      onAlar :=  false;    alarInt := 0;    alarRea := 0;
      onYlar :=  false;    ylarInt := 0;    ylarRea := 0;
      Rdsm.Raj := 0;       Rdsm.Des := 0;   end;//with
end;
{::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}
function StrTarkSijAlkio (ArYrTark :boolean;  CONST stg :string;  VAR alkio :arvoTyyp): boolean;
      var ii :integer;  rr :real;  fnc,bb :boolean;  ss :string;
    procedure sijBoo (boolArvo :boolean);      begin
      if boolArvo
      then fnc := false
      else begin
           fnc := true;
           alkio.onArvo := true;
           with alkio  do
           case arvoTyp of
             Intg :arvoInt := ii;
           //Reaa :arvoRea := rr; //< -3.0.0
             Reaa :begin ii := fDsm (rr, alkio.Rdsm.Raj,alkio.Rdsm.Des); //<DesimRajat määritetty ALKIOn alustssa!
                         rr := fMuokDes (rr,ii);
                         arvoRea := rr;  end;
             Bool :arvoBoo := bb;
             Strg :arvoStr := ss;  end;//case
      end;   //Y_Koe (2,'Y_/sijBoo/FNC ='+fBmrkt0(fnc,2));
    end;
begin//StrTarkSijAlkio
//if (Stg='NäinköSeOn') and NOT (alkio.arvoTyp IN [Intg,Reaa,Bool,Stg])  then beep; //+8.0.5}
//if (Stg='NäinköSeOn') and (alkio.arvoTyp=Reaa)  then beep; //+8.0.5}
  if alkio.arvoTyp IN [Intg,Reaa,Bool,Strg]  then //<''Vain jotta Trace InTo workkisi, ei worki. +8.0.5
  with alkio  do
  case arvoTyp of
    Intg :sijBoo (not SokI (stg,ii)  or ArYrTark and ( onAlar and (ii<alkio.alarInt)  or onYlar and (ii>alkio.ylarInt))); //<,130.2e:  alkio. .. debuggerille.
    Reaa :sijBoo (not SokR (stg,rr)  or ArYrTark and ( onAlar and (rr<alkio.alarRea)  or onYlar and (rr>alkio.ylarRea)));
    Bool :sijBoo (not SokB (stg,bb));
    Strg :sijBoo (not SokS (stg,ss));
{,,,Intg :begin  fnc := okI (stg,ii);
                 if fnc  then begin onArvo := true;  arvInt := ii;  end; end;  <<<,,,ArYrTark ??????
    Reaa :begin  fnc := okR (stg,rr);
                 if fnc  then begin onArvo := true;  arvRea := rr;  end; end;
    Bool :begin  fnc := okB (stg,bb);
                 if fnc  then begin onArvo := true;  arvBoo := bb;  end; end;
    Stg  :begin     fnc := true;    onArvo := true;  arvStr := ss;       end;''''''''''''''''''''''}
  end;//case
  if NOT (alkio.arvoTyp IN [Intg,Reaa,Bool,Strg]) and (alkio.arvoTyp=Intg) //<Debuggerille +6.2.6
     then beep;
 {if fnc  then StrTarkSijAlkio := true
          else StrTarkSijAlkio := false;                      //Y_Koe (2,'Y_/FNC ='+fBmrkt0(fnc,2));}
  if fnc  then Result := true
          else Result := false;                               //Y_Koe (2,'Y_/FNC ='+fBmrkt0(fnc,2));
end;//StrTarkSijAlkio                                               //,,Suorittaa YR+AR tarkistukset
function SijSRajAlkio (CONST strg :string;  VAR alkio :arvoTyyp): boolean;      begin;
  result := StrTarkSijAlkio (TRUE, strg,alkio);  end;           //<Tarkistaa myös ylä-/alarajat
function SijStrAlkio (CONST strg :string;  VAR alkio :arvoTyyp): boolean;      begin;
  result := StrTarkSijAlkio (FALSE,strg,alkio);  end;

procedure ohjelmavirhe (os,typ :integer;  c :char);      VAR s :string;      begin
  s := fImrkt0( os,1);
  if typ=0
     then s := s+' Tietueen LUKUvirhe ('
     else s := s+' Tietueen SIJOITUSvirhe (';
  case c of
    'I' :s := s+'Integer';
    'R' :s := s+'Real';
    'B' :s := s+'Boolean';
    'S' :s := s+'String';
  else   s := s+'???';  end;//case;
  s := s+'), joka saattaa olla aiheutunut käsin virheellisesti muutetusta ajotiedostosta. ';
  if typ=0  then s := s+'Virheellinen arvotyyppi saattaa aiheuttaa ajon keskeytymisen. ';
  s := s+'Ota yhteys ohjelman toimittajaan ja välitä tiedot virheilmoituksesta, käsittelyik'+
         'kunasta ja edeltäneestä tilanteesta.';
  Y_Piipit (50);
{IFNDEF kso_debug}  //Dollari IFDEFin eteen + välilyönti = ohittaa herjailmoituksen, mutta PIIPITjää
//MessageDlg( s,mtWarning,[mbOK],0);
  InfoDlg (s, mtWarning, 'OK','','','',  '','','',''); //<+6.2.2
{ENDIF}
end;//ohjelmavirhe
{.........................................}
{function a_getIntg (alkio :arvoTyyp): integer;      begin  a_getIntg := 0;   with alkio  do //=Kun EiArvostaHerja
  if (arvTyp<>Intg) or  not onArvo   then ohjelmavirhe(0,'I')   else a_getIntg := arvInt;   end;//Intg}
function a_getIntg (os :integer;  alkio :arvoTyyp): integer;      begin  Result := 0;   with alkio  do
  if (arvoTyp<>Intg)  then
     ohjelmavirhe(os,0,'I')   else if onArvo  then Result := arvoInt;  end;             //Intg
function a_getReaa (os :integer;  alkio :arvoTyyp): real;         begin  Result := 0;   with alkio  do
  if (arvoTyp<>Reaa)
     then ohjelmavirhe(os,0,'R')
     else if onArvo  then Result := arvoRea;  end;                                      //Reaa
function a_getBool (os :integer;  alkio :arvoTyyp): boolean;      begin  Result := false;   with alkio  do
  if (arvoTyp<>Bool)  then
     ohjelmavirhe(os,0,'B')   else if onArvo  then Result := arvoBoo;  end;             //Bool
function a_getStrg (os :integer;  alkio :arvoTyyp): string;       begin  Result := '';   with alkio  do
  if (arvoTyp<>Strg)  then
     ohjelmavirhe(os,0,'S')   else if onArvo  then Result := arvoStr;  end;             //Strg
function fOnArv (alkio :arvoTyyp): boolean;     begin   fOnArv := false;  with alkio  do
                                                        if onArvo  then fOnArv := true;    end;//fOnArv
{.........................................}
procedure a_putIntg (os :integer;  ii :integer;  VAR alkio :arvoTyyp);     begin  with alkio  do
  if arvoTyp=Intg  then begin  onArvo := true;  arvoInt := ii;  end else ohjelmavirhe(os,1,'I'); end;
procedure a_putReaa (os :integer;  rr :real;     VAR alkio :arvoTyyp);     begin  with alkio  do
  if arvoTyp=Reaa  then begin  onArvo := true;  arvoRea := rr;  end else ohjelmavirhe(os,1,'R'); end;
procedure a_putBool (os :integer;  bb :boolean;  VAR alkio :arvoTyyp);     begin  with alkio  do
  if arvoTyp=Bool  then begin  onArvo := true;  arvoBoo := bb;  end else ohjelmavirhe(os,1,'B'); end;
procedure a_putStrg (os :integer;  CONST ss :string;   VAR alkio :arvoTyyp);     begin  with alkio  do
  if arvoTyp=Strg  then begin  onArvo := true;  arvoStr := ss;  end else ohjelmavirhe(os,1,'S'); end;

//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Palautt.Stringinä ao. arvon.,,,TAB Int+Rea+Boo  DES vain ReaaLuvuille
function fSiTdsm (r :real;  d :integer) :desTyyppi;      VAR desT :desTyyppi;      begin
   desT.Raj := r;  desT.Des := d;
   result := desT;  END;
{.........................................}
//,Palauttaa ALKIOn DESIMAALILUKUMÄÄRÄtiedon arvoTyypin mukaisena, Int:lle=1  Bool=2  Strg=ALKIO.arvoStr  r=fTDsm()
function fTdsm (alkio :arvoTyyp;  arvR :real) :integer;      VAR d :integer;      begin
   d := 0;                                          //',,Tätä kutsuttu vain REAA:lla, muut arvotyypit varm.vuoksi.
   case alkio.arvoTyp of
      Intg :d := 1;                                          //,Esim. (3,0)
      Reaa :d := fDsm (arvR, alkio.Rdsm.Raj,alkio.Rdsm.Des); //<'(3)Des=MaxDes  (0)Raj=MaxArvo, JOTA PIENEMMILLÄ MaxDes, isommilla DES pienenee (-1) per dekadi.
      Bool :d := 2;
      Strg :d := Length (alkio.arvoStr);
   end;//case
   result := d;
end;//fTdsm
{.........................................}
//,Palauttaa ALKIOn arvoTyyp ´in mukaisena STRg :nä = f (alkio.Rdsm.Raj, alkio.Rdsm.Des)
function fMrktRaj (alkio :arvoTyyp) :String;      VAR ss :string;  d :integer;  ar :real;      begin
  ss := '';
  with alkio  do  //if onArvo  then            //<-130.3u:  Edv.Edka[1].JkUps_Ik3v.onArvo oli aina FA (IHME?!?!?).
  case arvoTyp of
    Intg :ss := fImrkt0( arvoInt,1);
    Reaa :BEGIN  ar := arvoRea;                //<ar BreakPointin takia
                 d :=  fTdsm (alkio,arvoRea);  //<(3,0) = (3)Des=MaxDes  (0)Raj=MaxArvo, JOTA PIENEMMILLÄ MaxDes, isommilla DES pienenee (-1) per dekadi.
                 ss := fRmrkt0(ar,1,d);  END;
    Bool :ss := fBmrkt0 (arvoBoo,4);
    Strg :ss :=        arvoStr;
  //Strg :ss := a_getStrg (0,alkio); //< OK
  end;//case
  Result := ss;
end;//fMrktRaj
{.........................................}
//,Muuntaa arvR :n arvoTyyp ´in mukaiseksi STRg :ksi = f (alkio.Rdsm.Raj, alkio.Rdsm.Des)
function fRmrktRaj (arvR :real;  alkio :arvoTyyp) :String;      VAR ss :string;  d :integer;      begin
  alkio.onArvo := true;                                           //<,,Sijoitukset eivät palaudu alp alkioon !!!!
  case alkio.arvoTyp of                                           //<',ALKIOssa tieto Rdsm.Raj/.Des !!!!!!!!!!!!!
    Intg :ss := fRmrkt0 (arvR,1,0);                               //<,,Muut sijoitukset kuin REAA vainVarm.vuoksi
    Reaa :BEGIN  d := fTdsm (alkio,arvR);
                 ss := fRmrkt0(arvR,1,d);  END;
    Bool :;
    Strg :;
  end;//case
  result := ss;
end;//fRmrktRaj;
{==================================================================================================}

function pyor(r :real) :integer;   begin; //<¤DEVELOPER1
  pyor := trunc(r+0.5);              end;
//===============================================================================================================
{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Muutos 4.0.0
@@@@@@@@@@@@@@@@@@@@@ HUOLELLA TESTATTU VeryDir/Vrt.PAS :ssa, KATTAVA, OK !!! @@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
//,,+130.2e: BoldPix palauttaa Bold- ja NormFonttien PixEron. Tämä on vanha TagVex.§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
function TagVexB_Ero ({CanvasOwner :TCanvas;  }SA :string;  VAR BoldPixEro :integer) :string;      VAR su :string;  {i,n,}u :integer;
       //TagYmVex  YhtLask.PAS´sissa                                   //11å108 'YhtLask.PAS´sista.  130.2e: Täysin UUSI, PAREMPI, mietitty poistojärjestys.
procedure wre(ss :string);      begin end; {VAR f :TextFile;  fn :string;      begin //<+130.2e. TOSI HYVÄ, LOISTAVA.
      fn := gAjoPath +'_EdvNewLsk TAG.txt';      //C:\Projektit XE2\NolaKehi\BIN\..
      AssignFile(f,fn);
      if fFileExists (fn)
         then Append(f)
         else Rewrite(f);
      Writeln(f,ss);
      Flush(f);
      Close(f);
   end;//}

   procedure Tee(SI :string);      VAR a,b,i :integer;  sa :string;

      function onTag2(st1,st2 :string) :boolean;      VAR a,b :integer;      begin //130.2e
         a := Pos(st1,su);
         b := Pos(st2,su);
         result := (a>0) and (b>a);
      end;
      function onTag(st :string) :boolean;      VAR n :integer;      begin //11å109
         n := Pos(st,su);
         result := (n>0);  end;

//tee('<left><f n="" s="" c="16711680">72,2m<b><f n="" s="" c="255">P</f></b><f n="" s="" c="255"></f><b>X</b>  {142,5/105}');
begin//Tee..................
//Nämä  vielä: '<in', '</in>', '<tab', '</tab>', '<t>', '<above>', '<below>', '<middle>', '<center>', '<i>', '<s>', '</i>', '</s>', '<br>', '<colspan'
   while (Pos(Chr(10),SI) >0) or (Pos(Chr(13),SI) >0)  do begin
      Delete(SI, Pos(Chr(10),SI),1);
      Delete(SI, Pos(Chr(13),SI),1);  end;                         //<'+1414.
try
   BoldPixEro := 0;
   su := SI;                                   //<+11å109
         //if SI<>''  then wre('== ' +SI);       //<+130.2e.
   while onTag('<f') OR onTag('">')  do begin
      a := Pos('<f',su);
      b := Pos('">',su);
      if (a>0) and (b>a)
         then Delete (su,a,b+2-a);             //<11å107,å109
   end;                 //if su<>''  then wre('1: '+su);
   while onTag('<left>')  do begin
      a := Pos('<left>',su);
      if (a>0)  then
         Delete(su,a,6);
   end;                 //if su<>''  then wre('2: '+su);
   while onTag('<right>')  do begin
      a := Pos('<right>',su);
      if (a>0)  then
         Delete(su,a,7);
   end;                 //if su<>''  then wre('3: '+su);
   while onTag('<center>')  do begin
      a := Pos('<center>',su);
      if (a>0)  then
         Delete(su,a,8);
   end;                 //if su<>''  then wre('4: '+su);
   while onTag('<u>') OR onTag('</u>')  do begin
      a := Pos('<u>',su);
      if (a>0)  then
         Delete(su,a,3);
      a := Pos('</u>',su);
      if (a>0)  then
         Delete(su,a,4);
   end;                 //if su<>''  then wre('5: '+su);
   while onTag('</f>')  do begin
      a := Pos('</f>',su);
      if (a>0)
         then Delete(su,a,4);
   end;                 //if su<>''  then wre('6: '+su);
   while onTag('<b>') OR onTag('</b>')  do begin                     //<'Boldit:  Koska on voitava tunnistaa boldatut mrkt erikseen joten muut TAGit vex ekax.
         a := Pos('<b>',su);                         {,,try  OldFont.Assign (CanvasOwner.Font);   CanvasOwner.Font.Assign (TxtFont); ?????}
         if (a>0)  then begin
            u := Pos('</b>',su);                                     //<"<b>"=3mrk
            sa := '';
            for i := u-1 DownTo 1  do                                //<Haetaan alkuun päin, helpompi.
            if su[i]='>'                                             //<Mikä tagi vaan lopettaa.
               then Break                                            //<TUPX on [b..u]
               else sa := su[i] +sa;                                 //<Välilyönnitkin voivat olla boldattuja.  ,BoldiTextin ja NormTextin ero.
            BoldPixEro := BoldPixEro + (Y_fPixPitB (EdvNewFrm.Canvas, sa, EdvNewFrm.Font) - Y_fPixPit (EdvNewFrm.Canvas, sa, EdvNewFrm.Font));
            Delete(su,u,4);                                          //<Delataan ekax jälempi "</b>"
            Delete(su,a,3);                                          //<Delataan "<b>"
                      //if su<>''  then wre('91: '+su +'  BPx= ' +Ints(BoldPixEro)); //<+130.2e.
         end;//if (a>0)                                              //,,Jos vaikka olisi muitakin samoja.
         a := Pos('</b>',su);
         if (a>0)  then Delete(su,a,4);
                      //if su<>''  then wre('92: '+su);
   end;//while
Except
  ShowMessage('Virhe/Exept');  end;
   //if su<>''  then wre('');
 (*
      a := Pos('<',su);                                          //<colspan c="3">                                   //<,,+1202
      b := Pos('">',su);                                         //,Jätti loppuun ">1" =RivNro, jota eiTarvita.
      if (a>0) and (b>a)                                             //  ===  ;    -8,41  ;  1  ;   -8,41  ;   -44,96  ;
         then Delete (su,a,b+2-a);                               //,Jätti loppuun ">1" =RivNro, jota eiTarvita.
                        //if su<>''  then wre(su); //<+130.2e.}    //========  ==========  ====  =========  ==========
      if (a>0)
         then su := Copy (su,1,a-1) +Copy (su,a+4{+1},Length (su));
                        //if su<>''  then wre(su); //<+130.2e. *)
   end;//tee
begin//TagVex......................
 (*tee('1.) <f n="" s="" c="255">P</f></b>¤<f n="" s="" c="16711680"><u>P</u>isto<u>r.    Dz 0,4s 16/10A <right>{142,5/105}');
   tee('2.) <f n="" s="" c="255">P</f></b>¤<f n="" s="" c="16711680">Pistor.    Dz 0,4s 16/10A <right>{142,5/105}');
   tee('3.) 72,2m<b><f n="" s="" c="255">P</f></b>¤<f n="" s="" c="16711680">Pistor.    Dz 0,4s 16/10A <right>{142,5/105}');
   tee('4.) <left><f n="" s="" c="16711680">72,2m<b><f n="" s="" c="255">P</f></b>¤<f n="" s="" c="16711680">Pistor.    Dz 0,4s 16/10A <right>{142,5/105}');
   tee('5.) <left><f n="" s="" c="16711680">72,2m<b><f n="" s="" c="255">P</f></b><f n="" s="" c="255"></f><b>X</b>  {142,5/105}');
   tee('6.) <left><f n="" s="" c="16711680">72,2m<b><f n="" s="" c="255">P</f></b><f n="" s="" c="255"></f><b>X</b>  {142,5/105}');
   tee('7.) <left><f n="" s="" c="16711680">72,2m<b><f n="" s="" c="255">P</f></b>  {142,5/105}');
   tee('8.) <left><f n="" s="" c="16711680">72,2m<b><f n="" s="" c="255">P</f></b>  {142,5/105}');
   tee('9.) <left><f n="" s="" c="16711680">72,2m<b><f n="" s="" c="255"><b>TPX</b></f>  {142,5/105}'); //*)
if SA<>''  then
   tee(SA);
   result := su;
end;//TagVexB_Ero
//==================================================================================================
function TagVex (SA :string) :string;      VAR n :integer;      begin //Kutsuu vanhaa TagVex´iä.
   result := TagVexB_Ero ({CanvasOwner :TCanvas;  }SA, n);
end;
//==================================================================================================
                                                               //########,,,,,,,,,,,,,,,,,, ########
//,,,TIEDOKSI: Pixelipituudet, kun Font.Size=8 (MS Sans Serif):  ' '=2   '8'=5   Chr(255)=5 ########
//   mutta Chr255 onkin MS Sans Seriffissä kaksoispilkullinen y, TODETTU ###########################
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,Palauttaa merkkijonon pituuden PIXELEINÄ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
                {SyottoAvFrm.SyoAv.AddText ('Screen.PixelsPerInch=' +fImrkt0 (Screen.PixelsPerInch,1) +' fKpix=' +
                                   'PixPerI/96=' +fRmrkt0 (fKpix,1,5) +'  96/120=' +fRmrkt0 (96/120,1,5) +
                                   '  120/96=' +fRmrkt0 (120/96,1,5) +'<br>');}
function fKpix :real;      VAR k :real;      begin //< +3.0.1
              {Ks. HELP / TTextAttributes.Height (tai .Size)
               Specifies the height of the font in pixels.

               property Height: Integer;
               Description
                  To specify a font height in pixels, use the Height property. To specify the size of the font in
                  points instead, use the Size property. Users usually specify font size in points within an
                  application, while programmers are often concerned with the actual size of the font in pixels
                  when displaying a font on the screen.
               The relationship between the Height and Size properties is expressed by the formula:

                  Height = Size * ScreenPixelsPerInch / 72

               Note:   Unlike the Height property of a TFont object, the Height property of a TTextAttributes
                       object always includes the internal leading that appears at the top of the font.

               ############################################################################################
               WinProperties´sista katsottuna:  Norm. (Aral) fonts = 96 dpi,  Larfe fonts (125%) = 120 dpi.
               ############################################################################################}

// k := Screen.PixelsPerInch / 120;   //< -4.0.0   Nyt omassa koneessa ,,Small Font ja 96 PixPerInch
   k := 96 / Screen.PixelsPerInch;    //<NjTulFrm.aRich.Font.PixelsPerInch = 120 myös omassa koneessa kehitysvai-
                                      // heessa, missä k = 1, koska Large Font (=120 dpi), Leinon & Mantsin = 96
// k := 1;                            // = heillä Small Font ####################################################
   Result := k;  end;

function Y_fPixPit (CanvasOwner :TCanvas;  CONST Txt :String;  TxtFont :TFont) :Integer;
    var OldFont :TFont;   begin                            //'Fnc:n perusmuoto säilytetty=näkyy idea
  OldFont := TFont.Create;
  try  OldFont.Assign (CanvasOwner.Font);
       CanvasOwner.Font.Assign (TxtFont);
       Result := Pyor (CanvasOwner.TextWidth (Txt) *fKpix);
       CanvasOWner.Font.Assign (OldFont);
  finally  OldFont.Free;  end;
end;//Y_fPixPit;

function Y_fPixPitB (CanvasOwner :TCanvas;  CONST Txt :String;  TxtFont :TFont) :Integer; //<BOLDilla
    var OldFont :TFont;   begin                            //'Fnc:n perusmuoto säilytetty=näkyy idea
  OldFont := TFont.Create;
  try  OldFont.Assign (CanvasOwner.Font);
       CanvasOwner.Font.Assign (TxtFont);
       CanvasOwner.Font.Style := [fsBold];
       Result := Pyor (CanvasOwner.TextWidth (Txt) *fKpix);
       CanvasOwner.Font.Assign (OldFont);
  finally  OldFont.Free;  end;
end;//Y_fPixPitB;
//'n.1909 error!?!?!?!?  130.2e
//Fontti,,:  1=PixMSsanSerif  2=PixCourier  3=PixMSserif  4=PixTahoma  5=PixTimesNR  <,,+120.45
function fMSpixPit (FontNo :integer;  str :string) :integer;      CONST Maxi=11;  VAR i,j,ii,xw :integer;  xs :string;  Pxar :array [1..maxi] of string;

begin//,,PixArvot on kaapattu Apu.PAS/NaytaCharPixt´in ApuFrm.RichN´in näytöltä. [1]=1 pixeliä jne. PILKUT NYT TURHIA ALUSSA,LOPUSSA JA VISSIIN VÄLEISSÄKIN.
   TagVex(str); //<+1414.
   case FontNo of
   1 : begin //1PixMSsanS.TXT =MS Sans Serif.
      Pxar[ 1] := ',';
      Pxar[ 2] := ',39,105,106,108,124,';
      Pxar[ 3] := ',32,33,40,41,44,45,46,58,59,73,91,93,96,102,114,116,';
      Pxar[ 4] := ',42,123,125,';
      Pxar[ 5] := ',34,47,74,92,115,120,121,122,';
      Pxar[ 6] := ',36,38,43,48,49,50,51,52,53,54,55,56,57,60,61,62,63,70,76,94,95,97,98,99,100,101,103,104,107,110,111,112,113,117,118,';
      Pxar[ 7] := ',35,65,66,67,69,75,80,83,84,86,88,89,90,126,';
      Pxar[ 8] := ',37,68,71,72,78,79,81,82,85,109,119,';
      Pxar[ 9] := ',77,';
      Pxar[10] := ',';
      Pxar[11] := ',64,87,';  end;//<Max=11 pixeliä, tulostus oli 20´een mutta vika arvoalkio on [11].
   2 : begin //2PixCourier.TXT =Courier New
      Pxar[ 1] := '';
      Pxar[ 2] := '';
      Pxar[ 3] := '';
      Pxar[ 4] := '';
      Pxar[ 5] := '';
      Pxar[ 6] := '';
      Pxar[ 7] := ',32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,'+
                  '76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,'+
                  '115,116,117,118,119,120,121,122,123,124,125,126,';  //No niinpä tietenkin Courierin kaikki mrkt ovat samanpituisia (7 pix) pixeinä.
      Pxar[ 8] := '';
      Pxar[ 9] := '';
      Pxar[10] := '';
      Pxar[11] := '';  end;
  3 :  begin //3PixMSserif.TXT =MS Serif.
      Pxar[ 1] := '';
      Pxar[ 2] := '32,39,44,46,58,59,105,106,108,124';
      Pxar[ 3] := '33,40,41,45,47,91,92,93,96,102,116';
      Pxar[ 4] := '34,73,114,115,123,125';
      Pxar[ 5] := '36,42,48,49,50,51,52,53,54,55,56,57,63,74,94,95,97,98,99,100,101,103,104,107,110,111,112,113,117,118,120,121,122';
      Pxar[ 6] := '35,43,60,61,62,70,76,80,83,84,90,126';
      Pxar[ 7] := '66,67,69,82';
      Pxar[ 8] := '38,65,68,71,72,75,78,79,81,85,86,88,89,109,119';
      Pxar[ 9] := '64';
      Pxar[10] := '37,77,87';
      Pxar[11] := '';  end;
   4 :  begin //4Tahoma.TXT =Tahoma.
      Pxar[ 1] := '';
      Pxar[ 2] := ',39,105,108,';
      Pxar[ 3] := ',32,106,';
      Pxar[ 4] := ',33,34,40,41,44,45,46,47,58,59,73,91,92,93,102,114,116,124,';
      Pxar[ 5] := ',63,74,76,99,107,115,122,123,125,';
      Pxar[ 6] := ',36,42,48,49,50,51,52,53,54,55,56,57,66,69,70,75,80,83,84,86,88,89,90,95,96,97,98,100,101,103,104,110,111,112,113,117,118,120,121,';
      Pxar[ 7] := ',38,65,67,68,71,72,78,82,85,';
      Pxar[ 8] := ',35,43,60,61,62,77,79,81,94,109,119,126,';
      Pxar[ 9] := '';
      Pxar[10] := ',64,87,';
      Pxar[11] := ',37,';  end;
   end;//case

   xw := 0;
   for i := 1 to Length(str)  do
   for j := 1 to Length(Pxar)  do begin
      ii := Ord(str[i]);
      xs := Ints(ii);
      if Pos(xs,Pxar[j])>0
         then xw := xw +j; //<J ilmaisee aoMrkn PIXleveyden.
   end;
   result := xw;
end;//fMSpixPit

function otsikko (RivPit :integer;  CONST strg :string; _Font :TFont) :string;
     const pist=' . . .';   var sa :string;      begin
   sa := '';
   while Y_fPixPit (Printer.Canvas, strg +sa+pist, _Font) < RivPit  do sa := sa+pist;
   result := strg + sa;  end;

function Y_SamPitOikSuor (CONST malli,st1,st2 :string; CanvasOwner :TCanvas;  aFont :TFont) :string;
      CONST vali=' ';   VAR s :string;      begin
   s := st1;
   while Y_fPixPit (CanvasOwner, s+vali+st2, aFont) <= Y_fPixPit (CanvasOwner, malli, aFont) +2
         do s := s +vali;
   s := s +st2;
   result := s;   end;

(*---------------------------------------------------------------------------
procedure muunnaInteiksi (s :string);      var i :integer;  sa :string;      begin
  i := 0;                                  //<'Muunnetaan mjono intksi ='1 2 3..' -> 1 2 3 jne.
  while (i<Length(s))  do begin
     sa := '';  i := i+1;
     while (i<Length(s)) and (s[i]=' ')   do i := i+1;  //<Ohitetaan ' ':t
     while (i<Length(s)) and (s[i]<>' ')  do begin
           sa := sa+s[i];
           i := i+1;
     end;
     if (i<Length(s)) and (s[i]=' ')  then sa := sa+','; //<StrGrNolan tab -tiedoksi
  end;
  if sa<>''  then ....
end;//muunnaInteiksi  --------------Ei vielä ihan valmis--------------------*)

procedure etsiStr (Rich :TRichEditNola;  ComBxy :TComboBoxXY);
      var FoundAt: LongInt;   StartPos,ToEnd,i: integer;      begin //<DetEv,NjTul3,MoDet.PAS :ssa
                                     //rvja := Frm1.REditN.Lines.Count -1;   for i := 1 to rvja  do begin .......
   if ComBxy.Text=''
   then EiOkInfo ('Etsittävä merkki tai merkkijono puuttuu!')                     //,Help:  FindText
   else  with Rich  do begin          //begin the search after the current selection if there is one
            if SelLength <> 0 then    //otherwise, begin at the start of the text
               StartPos := SelStart + SelLength
            else StartPos := 0;
            SelLength := Length(ComBxy.Text);
          //StartPos := SelStart + SelLength; //<Aloittaa etsimisen cursorin vikasta paikasta, parempi niin.
                              {ToEnd is the length from StartPos to the end of the text in the rich edit control}
            ToEnd := Length(Text) - StartPos;
            FoundAt := FindText(ComBxy.Text, StartPos, ToEnd, []{[stMatchCase]});
            if FoundAt <> -1 then begin //<Löytyi
                 {SetFocus;             //<,,Oli näin, -22.8.06/ST-artik.PAS´sissa koklattu.
                  SelStart := FoundAt;
                  SelLength := Length(ComBxy.Text);}
               SelStart := FoundAt;
               SelLength := Length(ComBxy.Text); //<Ilman tätä ei maalaudu, vaikka cursori jää sen alkuun, OK.
               Perform (EM_SCROLLCARET,0,0);     //<+3.0.0 Vie CURSORIN NÄKYVIIN, ks. Help/Windows sdk/Index/EM_
               SetFocus;                         //<Voi olla alussakin, koklattu.
                                    //ComBxy.Text := ComBxy.Text +' '+fImrkt0(ComBxy.Items.Count,1);
            end else Beep;
            with ComBxy  do begin                         //<',,Siirretty tähän +6.0.2 =Löytyi eli ei.############
               i := Items.IndexOf(ComBxy.Text);           //<Etsittyä textiä eioo pudotusvalikossa -> lisätään
               if i=-1  then begin
                  if Items.Count < DropDownCount  then
                     Items.Add (Items.Strings [Items.Count-1]); //<Vika siirretään rivin kauemmaksi
                  for i := Items.Count -2 DownTo 0  do          //<Siirretään muita alemmaksi ja TEXT ekaxi
                     Items.Strings[i+1] := Items.Strings[i];
                  Items.Strings[0] := Text;
               end;
             //ComBxy.ItemIndex := 0; //<Eka ve näkyviin boxiin. Ei tartte, muutenkinVikaxEtsittyJääNäkyv. Lis.+6.0.2
            end;//with ComBxy                                                                                 '-6.0.3
         end;//with Rich
end;//etsiStr

{====================================================================================================================}
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}            //<,,+4.0.1,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
procedure LiitRpX_Phi_Str (eR,eX,PJ_Ik1v :real;  VAR RpX_s,Phi_s :string);
   LABEL 9;  VAR cosn,cU,Uv{:1414f::},eZ,{Ik1eR,} ar,rr,vrtR,AeR{:1414fu} :real;  sa :string;      begin
 //if SyottoFrm.RadGrp.ItemIndex=1  then begin   //<,,=PJ-liittyjällä kutsussa Ik1v, SJ:llä eX (KUTSUSSA!)
 //ar := eR+1; //1414f=??? -1414fu.              //<Ettei ar<eR -ehto vääristyisi SJ:llä.########################### Onkohan enää tarpeen ???
   AeR :=eR;                                    //<<+1414fu: Mahd. virheellisen arvon eistämiseen herjassa,,.
if (eX>0) or NOT SyottoFrm.Visible  then GOTO 9; //<+1414f: ,,eX=0 asetettu jotta ohj, NOTvisib=Muuten herjaEnnenNäkymää. Nyt jälemmät X=0 testit turhia.
   eZ := eR;  vrtR := eR;                        //<+1414fu x2: Might not ..initz.
   if (PJ_Ik1v>0)  and (eX=0)  then begin      //<,,=PJ-liittyjällä kutsussa Ik1v (ellei eXs, SJ:llä Xy (KUTSUSSA!)
      cU := a_getReaa (113, edv.YLE.cU);       //< PJ:llä eX=0 (kutsussa)                                   ,,1414f: Otettava 1/3, muuten myötä,vasta,0
      Uv := fUv;       //<+14154f                      //,eX = V¨{ [3*cU*fUv/(Ik1v*1000)]² - (3*eR)² } / 3  < KAIKKI yhdessä/mukana, mutta 3´set supistuu.
      eZ := cU*Uv/(PJ_Ik1v*1000);                      //    = V¨{ [cU*fUv/(Ik1v*1000)]² - eR² }            <Turha korottaa ² ja perään V¨. :1414f
      if (eZ>eR){:1414f Oli: (eZr<=eR)}  then          //<Onko Ik1v :stä laskettu eZ(ar) riittäv iso jotta Xe voi olla >0.
         eX := Sqrt ( Sqr (eZ) - Sqr (eR) );         //SAMA KUIN: eX := Sqrt ( Sqr (3*cU*fUv/(PJ_Ik1v*1000)) - Sqr (3*eR) ) /3; //<PJ:lle Xs = f (Rs,Ik1v).
               //'Tarvitaan Phi_s´n laskentaan.      //Jikkon:  0.046126   0.013332       PJ_Ik1v= 16,456  22,996 =3v
      sa := fRmrkt0(eZ,1,-5);                        //,,+1414f.  eZ = cU*Uv/(PJ_Ik1v*1000) => PJ_Ik1v = cU*Uv/(1000*eZ).  eR=edv.Sorc[edi].src.pjLiitRs.ArvoRea;
    //Ik1eR := cU*Uv/(1000*eR{eZ});  <-1414fu        //<eR´n Ik1v. eZ antaisi PJ_Ik1v´n.       '''''''''''''''''''''''''
      SyottoFrm.ComBx3.Text := sa +'   eRs(max)';
      vrtR := edv.Sorc[edi].src.pjLiitRs.ArvoRea;    //<vrtR ja eZ verrataan: jos ovat samoja =varoitus on jo kertaalleen näytetty.
      edv.Sorc[edi].src.pjLiitRs.ArvoRea := eZ;      //<''+1414f
      sa := Chr(10) +'<left><t>eRs po. ' +FONT_PIENPI +' ' +sa +' '+FONT_OMEGA; // +'   JA' +Chr(10) +'<left><t>Ik1v po. ' +FONT_SUURPI +' ' +fRmrkt0(Ik1eR,1,-3) +' kA' +Chr(10) +'<center>';
   end;                                                                         //''Turha, koska eZ on laskettu PJ_Ik1v´stä ja Ik1eR on AINA sama=PJ_Ik1v

   if (eZ<=eR) and (eZ<>vrtR)                          //<Ik1v :stä laskettu eZ liian pieni =eX pitäisi olla <0.
   then begin  WBeep([1000,300,2000,300]);             //<,Vain PJ:llä Iks1v :n syötöstä. OK-btnssa jo OK, jos sinne päästy.
      InfoDlg  ('<left>2) Annetulla eRs :n arvolla (' +fRmrkt0(AeR,1,5) +') Ik1v ei toteudu, eXs pitäisi olla <0, (eRs jo korjattu alustavasti): '{'korjaa eRs tai Ik1v:'} +sa,
                mtInformation,'OK','','','', '','','','');
     {RpX_s := '???';
      Phi_s := '???';  end     <''-1414f}  //<,Koska Bx3´een sijoitettiin eZ= R=f(PJ_Ik1v)
      RpX_s := FONT_AARETON; //<,,+1414f
      Phi_s := '0';  end
   else begin
      if eR=eX                                               //< Jos R=X, vaikkapa 0 ,,,,,,,,,,,,,,,+6.0.2
      then begin RpX_s := '1';                                    //< si =R/X   -arv.
                 Phi_s := '45';   end                             //< sx =kulma -arvo (phi)
      else if eR>=1000*eX                                    //< Jos R hyvin paljon isompi kuin X,,,,,,,
      then begin RpX_s := FONT_AARETON;                      //< si =R/X   -arvo.          999 =+6.0.2
                 Phi_s := '0';   end                             //< sx =kulma -arvo (phi)
      else if eX>=1000*eR                                    //< Jos X hyvin paljon isompi kuin R,,,,,,,
      then begin RpX_s := '0';
                 Phi_s := '90';  end
      else begin cosn := eR/Sqrt (Sqr (eR) + Sqr (eX));          //< Cos=R/Z
                 if cosn >= 1
                 then begin
                      RpX_s := '999´';                            //< 1 => 999 =+6.0.2
                      Phi_s := '0';  end
                 else begin
                      ar :=    arcCosi (cosn);                   //< ar = Kulma Phii
                      rr := eR/eX;                               //<+130.2e
                      RpX_s := fMrkvia (rr,4);
                      Phi_s := fMrkvia (ar,3);   end;
      end;
   end;//if ar<eR  else
9:
end;                                                         //<''+4.0.1''''''''''''''''''''''''''''''''''''''''''
//==================================================================================================
                                       //Sarakkeet,,,,,,,,,+,,,,,,,,,Rivit mistä mihin ESITETÄÄN VALITTUNA (Selected) värityksellä.
procedure EdiStrGrSelect (VAR StrGr :TStringGridNola;  Sar1,SarV,Riv1,RivV :integer);//+5.0.0
      VAR myRect: TGridRect;      begin
   myRect.Left :=   Sar1; //<Eka  Selected sarake
   myRect.Right :=  SarV; //<Vika Selected sarake
   myRect.Top :=    Riv1; //<Eka  Selected rivi
   myRect.Bottom := RivV; //<Vika Selected rivi, voi olla = Riv1
   StrGr.Selection := myRect;
end;

function mmH1500(mmHeight :integer) :integer;      begin //<,120.6 koe fKESKEN KESKEN
   Result := mmHeight;
   if mmHeight>1500
      then Result := 1500;
end;
function mmW2000(mmWidth :integer) :integer;       begin
   Result := mmWidth;
   if mmWidth>2000
      then Result := 2000;
end;

{function fTeeExtN (oha :integer) :string;      VAR s :string;   begin //1414d: FNC Sirrtty tähän Y_gLueTal_FileLista´n sisältä yleiseksi FNC´ksi, +1 tarve.
   case oha of
      1 :s := filen_EvExt;          //< 'NOE';
      2 :s := filen_NjExt;          //< 'NON';
   else  s := filen_MoExt;  end;    //< 'NOM';
   result := s;   end;}

//==================================================================================================,,+4.0.1
//>>>>>>>>>>>>1414fu: Siirretty FileLstN.PAS`iin, ennen oli: ks. Y_ Ennen_fLue..iin siirtoa.pas<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//Siirretty Y_.PAS´sin loppuun 1413=16å4 (Täällä luontevampi liittyessään FileLst.PAS´siin kiinteämmin.
//,,1413:  OS -arvoa seuramalla tieto, mistä ohaOsasta kutsu tulee:  1x=Edv  2x=Nj  3x=Mo joista mahd. arvaa.
//         Ks. FileLstN.PAS/ToErrFile ja /SijListoihin.
function Y_gLueTal_FileLista (os,oha :integer;  LUE,KYSY :boolean;   VAR aoFileN :string) :integer;
      VAR {paluu :integer;}   {boo,}{okRg,}boF :boolean;  {VrkLstFileN,}FileFilter,DlgTitle,LstTitle{, se1414d}{,1414f:sp} :string;
  //,Ei sallittu enää: Jos LueTalFilenReg (...FN) FN eioo, sinne tallentui Olet-Ev... tms.
  {function VaihdaReqNimJosOn (VAR anFilen :string) :boolean;      VAR ss :string;      begin //+1414cU,1414f,fu
      anFilen := Trim(anFilen);                                   //1414cU: Tutkii jos VrkLstFileN´ssa 1.FN eri kuin Reg´ssa, aoFile := listan 1.FileNimi.
      ss := anFilen;                                              //1414f:  Sijoittaa Reqisterin LastBranch -nimeksi, jos tyh => EdvNimet[0] jos <>'' ,
      if anFilen=''  then                                         //        EdvNimiVEthan ovat saatavilla Lue -btnlla.
         LueTalFilenReg (oha,LueTR,KysFA,ss);                               //<Siellä := Trim() ja teePolkuDataFilen (oha) jos eiReg´issä.
      anFilen := ss;
   end;//}
   //................................................
   function fTeeFileFilter (VAR Filen :string) :string;      VAR s,ExtN :string;      begin
      case oha of
         1 :s := filen_EvExt;          //< 'NOE';
         2 :s := filen_NjExt;          //< 'NON';
      else  s := filen_MoExt;{=4} end; //< 'NOM';
      ExtN := s;
      case oha of
         1 :s := 'Edelt.verkon ';
         2 :s := 'Nj-laskennan ';
      else  s := 'Moottorilähtö';{=4, 1414: 4=>3} end;
      s := s +'tiedostot (*.' +ExtN +')|*.'+
           ExtN +'|Käyttäjän omat tiedostot (*.*)|*.*';
      result := s;
      if KYSY and not LUE  then begin                       //<,, +6.0.2 Tarjotaan tarkenneosa nimen
         s := ExtractFileExt (Filen);                       //           loppuun jos ei jo ole.
         if s=''  then
            Filen := Filen +'.'+ExtN;
      end;
   end;//fTeeFileFilter
   //................................................
   //......................................................................................,,Uusittu 1414fu:
begin//Y_gLueTal_FileLista 4.0.1....................................................................
   aoFilen := Trim(aoFilen);                                                       //FileLstFrm´in FnLstGrd´n dialogiin TITLE yms:
   if LUE  then DlgTitle := 'Lue tiedosto'                                         //    1. Jos eiOKfile => otetaan Reg´sta FN
           else DlgTitle := 'Talleta tiedosto';                                    //    2. Jos Reg=FA, otet Lst[0] fLueTal_FileLista´ssa, ifEioo=>RegFN
   LstTitle := 'Aikaisemmat työtiedostot';                                         //    3. FileLstGRDdlg´n otsikko, filter yms.
   FileFilter := fTeeFileFilter (aoFilen);      //<Tekee ExtN ja liittää Filteriin +tarvittaessa  aoFileNimeen mm. Olet-Ev.NOE

   boF := xFileExists(aoFilen);
   if NOT boF  then                             //<,,1414d: Paha moka: FileListaa ei voikaan löytyä jos eioo ListFileNimeä EIKÄ Reg´istä
      //aoFilen := teePolkuDataFilen (oha);     //<-1415b   luettua fileä, ainoa mahis on lukea oletusfile (teeFilen (oha), nyt teePolkuDataFilen=EIenää).
      LueTalFilenReg ('FLst',oha,LueTR,KysFA,aoFilen); //<+1415b,e siellä teePolkuDataFilen.

                 DebWr(1,'1/3','Y_gLueTal_FileLista / Y_.PAS:  aoFilen= ' +aoFilen);
   DlgI := 0;
   FileLstFrm.fLueTal_FileLista (OS,OHA,'Suomi',LUE,KYSY,                                                  {:1414f÷÷ -KYSY} //<1413: +xOHA.  1414: -boo
                                 DlgTitle +': (' +aoFilen +')', LstTitle +': (' +aoFilen +')',FileFilter, aoFilen);
                 DebWr(1,'2/3ß','Y_gLueTal_FileLista / Y_.PAS:  aoFilen= ' +aoFilen);
                                  {if aoFilen=''
                                   then begin end
                                   else if KYSY     //<EiOK (?)
                                   then paluu := -1 //<= Save t. OpeDlg´ssa PERUTTU
                                   else paluu := 0;
                                                 DebWr(1,'3/3','Y_gLueTal_FileLista / Y_.PAS:  aoFilen= ' +aoFilen);}
   result := DlgI; //-1 =Cancel, 0..=OK.
   DebWr(1,'1/1','DebWr @£$µ'); //+1415e
end;//Y_gLueTal_FileLista
end.
