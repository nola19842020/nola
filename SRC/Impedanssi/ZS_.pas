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

unit ZS_; {DEVELOPER2, etsi ja täydennä kohdat:  DEVELOPER2TextBase

ZS_InfRv_
NayAsetuksetGrd //HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ
TControl(Sender).Name => Senderin nimi =OK.
ZS_Frm.ZS_StrGrid.Cells[1,rv]

           PERUSIDEA:
           1) Z_ ja S_ -laskentatulokset esitetään peräkkäin samalla ZS_Frm:lla. Siirtyminen Z_:sta S_:ään tai
              päinvastoin tyhjentää lomakkeen (ChkR_n :ssä). Putsaus myös PaaVal, S_/Z_PaaVal.SuljeBtnClick.-----
           2) S_/Z_PaaVal...BtnClick ohjaa:  OHJAASVAL -> ao.PRC (esim. I_T2), joka asettaa AVAL:n ja kutsuu
              CHKR_N, joka:
              - Tutkii, mahtuuko tuloste vielä samalle Gridille + kysyy toimenpiteet, jos ei mahdu, putsaa gridin
                valinnan mukaan ja VASTA TÄMÄN JÄLKEEN asettaa AVAL:n SVAL:ksi (jos perutaan putsaus, jää SVAL
                ennalleen)
              - Asettaa AVOS[] taulukkoon ao.alkioihin arvon S(Z)VAL välille R_c-1-..R_c-1, jota avuste käyttää.
           3) CHKR_N palauttaa tulostusrivin vikan rivinron(+1), jos TR, jonka jälkeen kutsutaan yleistä asetus-
              PRCtä ASETASVAL_TXT, joka asettelee CmBx:t SVALin mukaan ja sijoittaa niihin oletusarvot.---------
           4) GridiCelliin sijoitusten jälkeen OHJAAS(Z)VAL kutsuu
              - TUTKICOLCOUNT, joka tutkii vikan käytössä olevan COLin ja asettaa sen COLCOUNTiksi, jotta harmaa
                loppualue jää vex (N x GridLinbeWidth)
              - Kutsuu TOPALIMMANMUK, joka asettaa TOPROWn siten, että alin rivi aina näkyy, jos vaikka Gridi oli
                zoomattu 'vähäriviseksi'. Samaa kutsutaan myös OnResize -eventissä.------------------------------
     Eli:  Ao.valBtnClick tai LaskeBtnClick -> ohjaaS(Z)val -> I_T1 tms.:  if ChkR_n() then...
                                               - tutkiColCount                - asetaS(Z)valN
                                               - topAlimmanMuk                - asetaS(Z)val_
                                                                              - sijoitukset GridinCelleihin''''''
     R_n = KUMUL.RiviLaskuri 1..RowMax,  ks. NolaS.INC / FNC R_u ###############################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, Mask, {+}Printers, LabelNola, StringGridNola,
  ComCtrls, RichEditNola, ComboBoxXY, NolaForms;

type
  TZS_Frm = class(TFormNola)
    ZS_InfPan: TPanel;
    ZS_Pan: TPanel;
    ZS_SuljeBtn: TButton;
    ZS_TulostBtn: TButton;
    ZS_LLbl: TLabel;
    ZS_LMed: TMaskEdit;
    ZS_TLbl: TLabel;
    ZS_TMed: TMaskEdit;
    ZS_Mm2Lbl: TLabel;
    ZS_Mm2Cm: TComboBoxXY;
    ZS_LaskeLbl: TLabel;
    ZS_TypLbl: TLabel;
    ZS_TypCm: TComboBoxXY;
    ZS_LaskeBtn: TButton;
    ZS_xLbl: TLabel;         //<,Käytössä vain SULAKEtoiminnassa SVAL=3
    ZS_xMed: TMaskEdit;
    ZS_StrGrid: TStringGridNola;
    aRich: TRichEditNola;
    ChkBxAv: TCheckBox;
    ZS_SuTypCm: TComboBoxXY;
    ZS_SuTypLbl: TLabel;
    SaveDlg: TSaveDialog;
    ZS_SuTimCm: TComboBoxXY;
    ZS_InfRv1: TRichEditNola;
    ZS_InfRv2: TRichEditNola;
    ZS_InfRv3: TRichEditNola;
    procedure ZS_StrGridWidestColInRow(Sender: TObject; ACol, ARow, newWidth: Integer);
    procedure ZS_StrGridHighestColInRow(Sender: TObject; ACol, ARow, newHeight: Integer);
    procedure ZS_SuljeBtnClick(Sender: TObject);
//    procedure ZS_TulostBtnClick(Sender: TObject);
    procedure ZS_LMedKeyPress(Sender: TObject; var Key: Char);
    procedure ZS_TMedKeyPress(Sender: TObject; var Key: Char);
    procedure ZS_Mm2CmKeyPress(Sender: TObject; var Key: Char);
    procedure ZS_TypCmKeyPress(Sender: TObject; var Key: Char);
    procedure ZS_xMedKeyPress(Sender: TObject; var Key: Char);
    procedure ZS_StrGridMouseMove(Sender: TObject;  Shift: TShiftState;  X,Y: Integer);
    procedure ZS_StrGridMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
    procedure ZS_LaskeBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ZS_LMedExit(Sender: TObject);
    procedure ZS_TMedExit(Sender: TObject);
    procedure ZS_Mm2CmExit(Sender: TObject);
    procedure ZS_TypCmExit(Sender: TObject);
    procedure ZS_xMedExit(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ChkBxAvClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure ZS_StrGridDblClick(Sender: TObject);
    procedure ZS_PanMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure ZS_SuTypCmExit(Sender: TObject);
    procedure ZS_SuTypCmKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure ChkBxAvMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y:Integer);
    procedure ZS_Bx1_6Enter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ZS_TulostBtnMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X,Y: Integer);
    procedure ZS_SuTimExit(Sender: TObject);
    procedure ZS_SuTimCmKeyPress(Sender: TObject; var Key: Char);
    procedure FormPaint(Sender: TObject);
  private
  public
      procedure PrintContent;
  end;

const c_='  ';   RowMax={10;6;11;13;}{24;}{25;16;}{51;}100{+6.0.4};
      SulColNrm=12;  ColMax=25;  boldArrMax=ColMax;
                                   //'TARKISTETTAVA, ETTEI > ObjInsp:ssa, muuten init.error Jo käynnist:ssä (=OK)
var                                      //,Aval apumuuttuja Sval:lle. Jos tuloste mahtuu Gridille SVAL := AVAL.
  Aval,ZSX,ZSy, R_n,ots :integer;        //<MouseMove tallentaa, jotta DblClick:ssä avustemahis. OTS=ao.tulOsa
  DblClck :Boolean;                      //'R_n = Kumul. riviLaskuri 1..RowMax #################################
  jatkaMm2 :Real;                        //<+6.2.2  +jatkaMm2
sq,BxtEd,BxtNyt :string;                              //<Kokeiluun: TulostetaanFrmnCaptioniin: mm.ChkR_n + KUTSUprc:t
  boldArr :ARRAY [FALSE..TRUE,1..2,1..boldArrMax] of RECORD //< boldAr=Sarakkeiden riviosoitteet löytyneille isoimmille arvoille
           rivi :integer;   arvo,ero :real;  END; //'[1(max)..2(min),...] +4.0.0  AlCu,ero +6.2.2
  apuFilen :string;  apuFile :text; //<Tiedostoon tulost. edv:n pud.valikkojen +avust.tekemiseen /PRC tulJR +6.0.4
  ZSfile :text;  ZSfileN :string;   //<ZS_.PAS / ZS_TulostBtnMouseDown

  ZS_Frm :TZS_Frm;
  procedure ZS_InfRv_(n :integer;  si :string); //<+130.2e: ZS_InfRv1..3´lle
  procedure alustaBoldArr;
  procedure PutsCells_ (ekaCol,ekaRow :integer);
  procedure PutsCellsR_n;                           //<,,Jotta näkyisi Z_PaaVal yms.:ssa
  procedure PutsInfoRvt;
  function blu (aos :string) :string;
  function fRno (riv,kohta :integer) :string;
  function fTutColCount (olet :integer) :integer;
  procedure tarkistColCount;
  procedure topAlimmanMuk;
  function ChkR_n (Vr,Ot,Nr :integer) :boolean;
  function ChkOtsTarve (otsu,rvja, sSar :integer;  s :string;  VAR o :integer) :boolean;
  function fUusSivu (Vr,Ow,Nr :integer) :boolean;  //< +4.0.0
//........;;;;.............||||.....................................................;;;;;;;;;;;;..............|||||||......................................;
procedure MEDI_JalkSij_Lbl_MEDI (VasenMedi :TMaskEdit; VAR UusLbl :TLabel;  UusLblCapt,UusLblHnt :string;  VAR UusMedi :TMaskEdit; TabNo :integer; UusMediHnt :string);
procedure MEDI_JalkSij_Lbl_COMX (VasenMedi :TMaskEdit; VAR UusLbl :TLabel;  UusLblCapt,UusLblHnt :string; VAR UusCombXY :TComboBoxXY; TabNo :integer; UusCombXYHnt :string);
procedure COMX_JalkSij_Lbl_COMX (VasenComBxXY :TComboBoxXY;  VAR UusLbl :TLabel;  UusLblCapt,UusLblHnt :string; VAR UusCombXY :TComboBoxXY; TabNo :integer; UusCombXYHnt :string);
procedure COMX_JalkSij_Lbl_MEDI (VasenComBxXY :TComboBoxXY;  VAR UusLbl :TLabel;  UusLblCapt,UusLblHnt :string; VAR UusMedi :TMaskEdit; TabNo :integer; UusMediHnt :string);
procedure Sij_SftnJalkeen_LasBtn_jaAvustChk;
                                                                                                          //<''+130.1
procedure fBxtNyt (os :string);           //,,+130.0                                                             >>>!
procedure NayAsetuksetGrd (ohj :integer); //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>!
                                                                                                                  //!
implementation                                                                                                    //!
                                                                                                                  //!
uses Y_, Unit0, Herja1, PaaVal, Z_PaaVal, S_PaaVal, SyottoAv,                                                     //!
     PrintDialogNola, Globals, defs, textbasetexts, Moot, InfoDlgUnit{+6.2.2};                                    //!
//uses Koe;                                                                                                       //!
                                                                                                                  //!
var                                                                                                               //!
  avos :array [0..RowMax] of RECORD      //<Avusteen osoitetaulukko: Kertoo, mikä valinta (Sval) milläkin rivllä  //!
              aoVal,aoRow :integer;  END;// AOVAL ja mikä ao.tulOsan CellRow AOROW <<<<<<<<<<<<<<<<<<<<<<<<<<<<<  //!
  Gray_Chkd :boolean;  //<+1.1.3 Vain PRC ChkBxAvMouseDown ja ChkBxAvClick väliseen tiedonsiirtoon ILMAN EVENTIÄ  //!
//Saved :boolean;      //<+130.0:  FileExist ei worki,                                                            //!
{$R *.DFM}                                                                                                        //!
                               //,,,,,,,,,PRC´n nimen alkuosa juontaa tästä (MEDI).                                       //!
procedure MEDI_JalkSij_Lbl_MEDI (VasenMedi :TMaskEdit; VAR UusLbl :TLabel;  UusLblCapt,UusLblHnt :string; //UUSLBL.Left := VASENMEDI.oikR. +UUSMEDI sen jälk. <,,+130.1
                                 VAR UusMedi :TMaskEdit; TabNo :integer;  UusMediHnt :string);      VAR X :integer;    begin
 //if VasenMask is TMaskEdit  then
   X := VasenMedi.Left +VasenMedi.Width;               //<Sijoituksen lähtökohteen oikReuna.
   UusLbl.Left := X +7;
   UusLbl.Caption := UusLblCapt;
   if fRepunKehi and (UusLblHnt='!')  then
      UusLblHnt := UusLbl.Name;
   if fRepunKehi  then UusLblHnt := UusLblHnt +'"11"';
   UusLbl.Hint := UusLblHnt;
   UusLbl.ShowHint := true;
   UusLbl.Visible := true;

   UusMedi.Left := X +UusLbl.Width +8;                 //<,,Näissä yleensä PAIKALLISESTI sijoitettuna +2 riittäisi, mutta tässä yleisessä PRC´ssä vaatti enemmän.
   UusMedi.Hint := '';
   if fRepunKehi and (UusMediHnt='!')  then
      UusMediHnt := UusMedi.Name;
   if fRepunKehi  then UusMediHnt := UusMediHnt +'"12"';
   UusMedi.Hint := UusMediHnt;
   UusMedi.ShowHint := true;
   UusMedi.Visible := true;
   UusMedi.TabOrder := TabNo;
end;//MEDI_JalkSij_Lbl_MEDI
procedure MEDI_JalkSij_Lbl_COMX (VasenMedi :TMaskEdit; VAR UusLbl :TLabel;  UusLblCapt,UusLblHnt :string; //UUSLBL.Left := VASENMEDI.oikR. +UUSMEDI sen jälk. <,,+130.1
                                 VAR UusCombXY :TComboBoxXY; TabNo :integer;  UusCombXYHnt :string);      VAR X :integer;    begin
   X := VasenMedi.Left +VasenMedi.Width;               //<Sijoituksen lähtökohteen oikReuna.
   UusLbl.Left := X +7;
   UusLbl.Caption := UusLblCapt;
   UusLbl.Hint := '';
   if fRepunKehi and (UusLblHnt='!')  then
      UusLblHnt := UusLbl.Name;
   if fRepunKehi  then UusLblHnt := UusLblHnt +'"21"';
   UusLbl.Hint := UusLblHnt;
   UusLbl.ShowHint := true;
   UusLbl.Visible := true;

   UusCombXY.Left := X +UusLbl.Width +8;
   UusCombXY.Hint := '';
   if fRepunKehi and (UusCombXYHnt='!')  then
      UusCombXYHnt := UusCombXY.Name;
   if fRepunKehi  then UusCombXYHnt := UusCombXYHnt +'"22"';
   UusCombXY.Hint := UusCombXYHnt;
   UusCombXY.ShowHint := true;
   UusCombXY.Visible := true;
end;//MEDI_JalkSij_Lbl_COMX
procedure COMX_JalkSij_Lbl_COMX (VasenComBxXY :TComboBoxXY;  VAR UusLbl :TLabel;  UusLblCapt,UusLblHnt :string; //UUSLBL.Left := VASENCOMX.oikR. +UUSCOMX sen jälk. <,,+130.1
                                 VAR UusCombXY :TComboBoxXY; TabNo :integer;  UusCombXYHnt :string);      VAR X :integer;    begin
   X := VasenComBxXY.Left +VasenComBxXY.Width;         //<Sijoituksen lähtökohteen oikReuna.
   UusLbl.Left := X +7;
   UusLbl.Caption := UusLblCapt;
   UusLbl.Hint := '';
   if fRepunKehi and (UusLblHnt='!')  then
      UusLblHnt := UusLbl.Name;
   if fRepunKehi  then UusLblHnt := UusLblHnt +'"31"';
   UusLbl.Hint := UusLblHnt;
   UusLbl.ShowHint := true;
   UusLbl.Visible := true;

   UusCombXY.Left := X +UusLbl.Width +8;
   UusCombXY.Hint := '';
   if fRepunKehi and (UusCombXYHnt='!')  then
      UusCombXYHnt := UusCombXY.Name;
   if fRepunKehi  then UusCombXYHnt := UusCombXYHnt +'"32"';
   UusCombXY.Hint := UusCombXYHnt;
   UusCombXY.ShowHint := true;
   UusCombXY.Visible := true;
   UusCombXY.TabOrder := TabNo;
end;//COMX_JalkSij_Lbl_COMX
procedure COMX_JalkSij_Lbl_MEDI (VasenComBxXY :TComboBoxXY;  VAR UusLbl :TLabel;  UusLblCapt,UusLblHnt :string; //UUSLBL.Left := VASENCOMX.oikR. +UUSMASK sen jälk. <,,+130.1
                                 VAR UusMedi :TMaskEdit; TabNo :integer;  UusMediHnt :string);      VAR X :integer;    begin
   X := VasenComBxXY.Left +VasenComBxXY.Width;         //<Sijoituksen lähtökohteen oikReuna.
   UusLbl.Left := X +7;
   UusLbl.Caption := UusLblCapt;
   UusLbl.Hint := '';
   if fRepunKehi and (UusLblHnt='!')  then
      UusLblHnt := UusLbl.Name;
   if fRepunKehi  then UusLblHnt := UusLblHnt +'"41"';
   UusLbl.Hint := UusLblHnt;
   UusLbl.ShowHint := true;
   UusLbl.Visible := true;

   UusMedi.Left := X +UusLbl.Width +8;
   UusMedi.Hint := '';
   if fRepunKehi and (UusMediHnt='!')  then
      UusMediHnt := UusMedi.Name;
   if fRepunKehi  then UusMediHnt := UusMediHnt +'"42"';
   UusMedi.Hint := UusMediHnt;
   UusMedi.ShowHint := true;
   UusMedi.Visible := true;
   UusMedi.TabOrder := TabNo;
end;//COMX_JalkSij_Lbl_MEDI

procedure Sij_SftnJalkeen_LasBtn_jaAvustChk;      VAR u :integer;      begin
   {COMX_JalkSij_Lbl_MEDI (ZS_Frm.ZS_SuTimCm, ZS_Frm.ZS_xLbl,lc,'!', ZS_xMed,5,mh);
    if ZS_Frm.ZS_xLbl.Hint='1'  then ;   if ZS_Frm.ZS_xMed.Hint ='1'  then ; }
   with ZS_Frm  do begin                                                           //,xMed =Sft´in boxi.
     {ZS_Frm.}ZS_LaskeLbl.Left := ZS_Frm.ZS_xMed.Left +ZS_Frm.ZS_xMed.Width +3;      //<ZS_LaskeLbl= "=>"
     ZS_Frm.ZS_LaskeLbl.Visible := true;  end;//}
   with ZS_Frm.ZS_LaskeBtn  do begin
     ZS_Frm.ZS_LaskeBtn.Left := ZS_Frm.ZS_LaskeLbl.Left +ZS_Frm.ZS_LaskeLbl.Width +2;
     ZS_Frm.ZS_LaskeBtn.TabOrder := 6;
   //-130.1 Hint := myTextBase.Get(S_19) +fRP('ZS_LaskeBtn*');
     ZS_Frm.ZS_LaskeBtn.ShowHint := true;
     ZS_Frm.ZS_LaskeBtn.Visible := true;  end;

   with ZS_Frm.ChkBxAv  do begin
     Visible := false;                           //<"Sottaa" ruutua vähemmän, jos vanha sij. vex
     ZS_Frm.ChkBxAv.Left := ZS_Frm.ZS_LaskeBtn.Left +ZS_Frm.ZS_LaskeBtn.Width +5;
     u := ZS_Frm.ZS_LaskeBtn.Top +Trunc(ZS_Frm.ZS_LaskeBtn.Height/2 +0.5) -Trunc(ZS_Frm.ChkBxAv.Height/2 +0.5); //+130.1
     ZS_Frm.ChkBxAv.Top := u;                    //<'ChkBx´n yr = LaskeBtn.Top +(LaskeBtn.Heigth -ChkBx.Height)/2  eli Btn.Top +korkeuksien erotus/2 .
     ZS_Frm.ChkBxAv.Visible := true;
   end;
end;//SftnJalkeen_LasBtn_jaAvustChk

procedure ZS_InfRv_(n :integer;  si :string);      begin //<+130.2e: ZS_InfRv1..3´lle
   case n of
      1 :with ZS_Frm.ZS_InfRv1  do begin Lines.Clear;  AddText(si);  Visible := true;  end;
      2 :with ZS_Frm.ZS_InfRv2  do begin Lines.Clear;  AddText(si);  Visible := true;  end;  else
         with ZS_Frm.ZS_InfRv3  do begin Lines.Clear;  AddText(si);  Visible := true;  end;
   end;
end;

function FileExists(const FileName: string): Boolean;      VAR TimeDate : TDateTime{+14.1.1};   begin //Borland's sources for this function:           //!
{Netvihje/http://docwiki.embarcadero.com/Libraries/XE7/en/System.SysUtils.FileAge.  130.2e: Ei vielä korjattu missään muuallakaan.
uses
  System.SysUtils;
var
  timeDate : TDateTime;
begin
  FileAge('C:\Users\User\Desktop\aFile.xml', timeDate);
  writeln(DateTimeToStr(timeDate));
end.}

 //Result := FileAge(FileName) <> -1;  -14.1.1                   //',+130.0: Kaikkien Bxien nimet + arvot Str-pötkössä'.
   Result := FileAge(FileName,TimeDate);                         //',+14.1.1: Kaikkien Bxien nimet + arvot Str-pötkössä'.

end;
//,,Tämä erinom, näyttää Box´ien sisällöt ja Ik,Tk´n arvot joidenkin PRN alussa, ks. C:\Projektit XE2\NolaKehi\BIN\_RePunKoe.txt
procedure fBxtNyt (os :string);      begin end; (*VAR i :integer;  ff :TextFile;  s,se,fn :string;  {Lst :TStringList;}      begin
   if Sval<>Aval  then
      beep;   //<EItuu piippiä = pysyvät samoina, OK.
   Delete (os,18,99);  for i := Length(os) to 17  do os := os +' '; //<Tehdään  OS-str 17 mrk pitkä (kaikki sanabpit).
   s := '  Sval=' +Ints(Sval) +'  ' +os +'  Boxit:  ZS_SuTypCm=' +ZS_Frm.ZS_SuTypCm.Text +' /// SuTim='  +ZS_Frm.ZS_SuTimCm.Text  +
            ' /// LMed=' +ZS_Frm.ZS_LMed.Text +' /// TMed=' +ZS_Frm.ZS_TMed.Text +' /// Mm2Com=' +ZS_Frm.ZS_Mm2Cm.Text +
            ' /// TypCom=' +ZS_Frm.ZS_TypCm.Text +' /// Ik=' +fRmrkt0(Ik,1,2) +'  Tk=' +fRmrkt(Tk,1,2) +'  Sftk=' +fRmrkt(Sftk,1,2);
   fn := gAjoPath +'_RePunKoe.txt';                                                                               //!
   AssignFile(ff,fn);                                                                                             //!
   if FileExists({'\\?\' +}fn)  //<Ei worki täällä.                                                               //!
      then {begin                                                                                                 //!
           Lst := TStringList.Create;                                                                             //!
           Lst.LoadFromFile(fn);}                                                                                 //!
           Append(ff)                                                                                             //!
      else Rewrite(ff);                                                                                           //!
   Writeln(ff, DateTimeToStr(Now) +s);                                                                            //!
   Flush(ff);                                                                                                     //!
   CloseFile(ff);                                                                                                 //!
end;*)                                                                                                            //!
                                                                                                                  //!
procedure NayAsetuksetGrd (ohj :integer);      begin end; (*VAR rv, X,Y, ACol,ARow :integer; //HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ
      if boo  then result := 'TR'
              else result := 'fa';  end;
begin//..................................
if fRePunKehiAjo  then with ZS_Frm.ZS_StrGrid  do begin
  //ZS_TMed.Visible := false;
  if ohj>0  then with ZS_Frm  do begin
ZS_SuTypLbl.Caption := 'SuLbl1';  ZS_LLbl.Caption := 'LLbl2';  ZS_TLbl.Caption := 'TLbl3';  ZS_Mm2Lbl.Caption := 'Mm2Lbl4';  ZS_TypLbl.Caption := 'TypLbl5';
  end;//if ohj>0
rv := 12;
   with ZS_Frm  do begin  //Height := Height -5;//<Kokeilua korjaako =KORJAA, OK.
                               Cells[2,rv] := 'LblNimi';             Cells[3,rv] := 'Caption';   rv := rv+1;
Cells[1,rv] := 'SuLbl:';       Cells[2,rv] := ZS_SuTypLbl.Caption;   Cells[3,rv] := '<left>vis=' +fBtoS(ZS_SuTypLbl.Visible);  rv := rv+1;
Cells[1,rv] := 'LLbl:';        Cells[2,rv] := ZS_LLbl.Caption;       Cells[3,rv] := '<left>vis=' +fBtoS(ZS_LLbl.Visible);      rv := rv+1;
Cells[1,rv] := 'TLbl:';        Cells[2,rv] := ZS_TLbl.Caption;       Cells[3,rv] := '<left>vis=' +fBtoS(ZS_TLbl.Visible);      rv := rv+1;
Cells[1,rv] := 'Mm2Lbl:';      Cells[2,rv] := ZS_Mm2Lbl.Caption;     Cells[3,rv] := '<left>vis=' +fBtoS(ZS_Mm2Lbl.Visible);    rv := rv+1;
Cells[1,rv] := 'TypLbl:';      Cells[2,rv] := ZS_TypLbl.Caption;     Cells[3,rv] := '<left>vis=' +fBtoS(ZS_TypLbl.Visible);    rv := rv+2;
Cells[1,rv] := 'ZS_SuTypCm:';  Cells[2,rv] := ZS_SuTypCm.Text;       Cells[3,rv] := '<left>vis=' +fBtoS(ZS_SuTypCm.Visible);   rv := rv+1;
Cells[1,rv] := 'ZS_SuTimCm:';  Cells[2,rv] := ZS_SuTimCm.Text;       Cells[3,rv] := '<left>vis=' +fBtoS(ZS_SuTimCm.Visible);   rv := rv+1;
Cells[1,rv] := 'ZS_LMed:';     Cells[2,rv] := ZS_LMed.Text;          Cells[3,rv] := '<left>vis=' +fBtoS(ZS_LMed.Visible);      rv := rv+1;
Cells[1,rv] := 'ZS_TMed:';     Cells[2,rv] := ZS_TMed.Text;          Cells[3,rv] := '<left>vis=' +fBtoS(ZS_TMed.Visible);      rv := rv+1;
Cells[1,rv] := 'ZS_Mm2Cm:';    Cells[2,rv] := ZS_Mm2Cm.Text;         Cells[3,rv] := '<left>vis=' +fBtoS(ZS_Mm2Cm.Visible);     rv := rv+1;
Cells[1,rv] := 'ZS_TypCm:';    Cells[2,rv] := ZS_TypCm.Text;         Cells[3,rv] := '<left>vis=' +fBtoS(ZS_TypCm.Visible);     rv := rv+1;
Cells[2,rv] := 'LnCnt(' +Ints(RowCount) +')';                  //<,,+130.2e
Cells[3,rv] := 'Vis(' +Ints(VisibleRowCount) +')';
Cells[4,rv] := 'x (DefH+lW)' +Ints(DefaultRowHeight+GridLineWidth);
Cells[5,rv] := '=' +Ints(VisibleRowCount*(DefaultRowHeight+GridLineWidth));
Cells[6,rv] := 'GrdH(' +Ints(Height) +')';
//ZS_Frm.ZS_StrGrid.MouseToCell(X,Y, ACol,ARow);
Cells[7,rv] := 'TopRw=' +Ints(TopRow);
  {ZS_InfRv_(2,'LCnt=' +Ints(RowCount) +' x áH=' +Ints(DefaultRowHeight) +' =' +Ints(RowCount*DefaultRowHeight) +' Hgrd=' +Ints(Height) +
                   ' Vis=' +Ints(VisibleRowCount) +' x DefH =' +Ints(VisibleRowCount *DefaultRowHeight));}
end;//with ZS_Frm
end;//with
//2LLbl + 3ZS_TMed näkyy po. ZS_LMed
end;//NayAsetuksetGrd *)

procedure NroiRows (ekaRow :integer);      var rw :integer;      begin
  with ZS_Frm.ZS_StrGrid  do
    for rw := EkaRow to RowMax-1  do Cells[0,rw] := {'<left>'+}COLOR_SILVER +fImrkt0 (rw,1) +FNT_0;
end;                                                     //'Rivino vaaleana, LASKEbtnsta normaalina mustana

function ChkOtsTarve (otsu,rvja, sSar :integer;  s :string;  VAR o :integer) :boolean;      VAR i,ai,{ii,}ind :integer;
begin                                           //<,,Palauttaa tiedon, löytyykö tulevalta näkymäalueelta OTSriviä
   result := true;                                             //<Saattaa jäädä voimaan, vrt. if i=0 ...
   i := 0;
   if (o=0) or (otsu<>OTS)  then i := 1;        //< 1 = Ekan rivin tulostus tai eri OTSU aiheuttaa OTSrvtarpeen
   OTS := otsu;                                                //<Merkitään voimaan tuleva OtsikkoNo

   if i=0  then                                 //<,,Ei turhaan selvitetä muita syitä jos jo muutenkin OTSrvtarve
   with ZS_Frm.ZS_StrGrid  do begin
      i := R_n-rvja;                                           //<R_n = Yksi yli tulevan vikan rivin
      repeat i := i-1;                                         //'Turha aloittaa TULEVASTA VIKASTA TULEVASTA!!!!!
             ind := 0;
             if i<=RowCount -1  then                           //,sSar =Haluttu stringin S sarake ###############
                ind := pos (s, Cells[sSar,i]);                 //<Löytyi jos pos<>0. IND = Str:nAlkuos AoCellissä
             ai := R_n -VisibleRowCount +1;                    //<VisibleRowCount = Kokonaan näkyvien LKM: 0..2=3
      until (ind<>0) or (i=0) or (i<=ai);                      //<EiEtsitä TopRowta ylempää; eivät näy muutenkaan

      if (ind=0) //or (R_n-1-rvja<TopRow)                      //<ind=0 =Ei löytynyt Stringiä
         then begin  o := o+1;
                     R_n := R_n+1;              //<Koska tehtiin välirivi, josta Chk.. ei ole tietoinen #########
                     result := true;  end                      //<Ei tarttis := true, vrt. alkuasetus
         else        result := false;                          //,Viim.rivi, jolle ei kirjoiteta tulevia rvja
             {ii := R_n-1 -rvja-1;                                   Cells[4,ii] := ' R_n='+fImrkt0(R_n,1);
              Cells[1,ii] := ' Top='+fImrkt0(TopRow,1);              Cells[5,ii] := ' i='+fImrkt0(i,1);
              Cells[2,ii] := ' Vis='+fImrkt0(VisibleRowCount,1);     Cells[6,ii] := ' ind='+fImrkt0(ind,1);
              Cells[3,ii] := ' rja='+fImrkt0(rvja,1);                Cells[7,ii] := ' ai='+fImrkt0(ai,1);
              if result  then Cells[8,ii] := ' fnc=TR'          else Cells[8,ii] := ' fnc=FA';           {%koe}
   end;//with
end;//ChkOtsTarve

//===============================================================================================================
procedure alustaBoldArr;      VAR i :integer;      begin
  for i := 1 to boldArrMax  do begin              //[AlCu, 1=Max 2=Min, RIV]                 //,,FA/TR,ero +6.2.2
     boldArr[TRUE ,1,i].rivi := 0;  boldArr[TRUE ,1,i].arvo := 0;  boldArr[TRUE ,1,i].ero := 0;
     boldArr[TRUE ,2,i].rivi := 0;  boldArr[TRUE ,2,i].arvo := 0;  boldArr[TRUE ,2,i].ero := 0;
     boldArr[FALSE,1,i].rivi := 0;  boldArr[FALSE,1,i].arvo := 0;  boldArr[FALSE,1,i].ero := 0;
     boldArr[FALSE,2,i].rivi := 0;  boldArr[FALSE,2,i].arvo := 0;  boldArr[FALSE,2,i].ero := 0;  end; //<' [n,i] +4.0.0
end;

procedure PutsCells_ (ekaCol,ekaRow :integer);      var cl,rw :integer;      begin
  with ZS_Frm.ZS_StrGrid  do begin
    R_n := 0;
    for cl := ekaCol to ColMax  do
    for rw := ekaRow to RowMax  do Cells[cl,rw] := '';
    for rw := 0      to RowMax  do begin  avos[rw].aoVal := 0;   avos[rw].aoRow := 0;  end;
    NroiRows (ekaRow);
end; end;
procedure PutsCellsR_n;     begin //<Putsaa koko gridin
  PutsCells_(0,0);
end;
procedure PutsInfoRvt;      begin
    ZS_Frm.ZS_InfRv1.Lines.Clear;      //<,,130.2e:  InfRv1..3 => RichInfo1..3
    ZS_Frm.ZS_InfRv2.Lines.Clear;
    ZS_Frm.ZS_InfRv3.Lines.Clear;  end;
//===============================================================================================================
function blu (aos :string) :string;      VAR s :string;      begin
   s := '';   s := COLOR_BLUE;   s := s +aos;   s := s +FNT_0;   result := s;  end;
//===============================================================================================================
function fRno (riv,kohta :integer) :string;      var s :string;   begin
   case kohta of  1 :s := '<left>';
                  0 :s := '<center>';
                else s := '<right>';  end;//case
   result := s +COLOR_SILVER +fImrkt0 (riv,1) +FNT_0;  end;
//===============================================================================================================
function fMaxColCount :integer;                    //<,,#### Tutkitaan StrGridin Col -lukumäärät ####
var i,j,max :integer;    begin
   max := 0;
   with ZS_Frm.ZS_StrGrid  do begin
      for i := 0 to RowMax-1 do                     //<Hyväksyy isomman arvon kuin RowCount
      if (ZS_Frm.ZS_StrGrid.Cells[0,i]<>'') and     //<[Col,Row], 0 :ssa varmasti pitäis olla, josYleensä rivillä
         NOT (CharInSet(ZS_Frm.ZS_StrGrid.Cells[0,i][1], ['1'..'0'])) //<Etsitään otsikkorivi = ei riviNroa
      then begin
         for j := ColMax downto 0  do
         if (ZS_Frm.ZS_StrGrid.Cells[j,i]<>'') then begin
            if j>max  then max := j;
            break;  end;
      end;
      result := max+1;
   end;//with
end;//fMaxColCount

//,,Tutkii ja palauttaa käytössä olevan max.Coln. Käytetään, jottei tarttis asettaa ColMax -> ScrollBar välähtäisi
function fTutColCount (olet :integer) :integer;      var i :integer;      begin
   i := fMaxColCount;   if i<olet  then i := olet;
   result := i;
end;//fTutColCount
procedure tarkistColCount;    begin//################ Tähän tultaessa Gridissä jo halutut arvot ################
   with ZS_Frm.ZS_StrGrid  do      //#### Tutkitaan StrGridin Col -lukumäärät ja asetetaan ColCount löydetyn MAX
      ColCount := fMaxColCount;    //#### mukaan, jolloin kapeamman Gridin loput GridLinet eivät näy harmaana ##
end;//tarkistColCount;
//===============================================================================================================
procedure topAlimmanMuk;      var i,vc,frw,uusTop :integer;  {s :string;      }begin
  with ZS_Frm.ZS_StrGrid  do begin                       //,,,TopRow määrätty NolaS.INC/ChkR_n:ssä
                                                         //   RowCount -FixedRows ..
    for i := RowCount-1 Downto FixedRows  do             //<,Etsitään vika arvorivi
        if (ZS_Frm.ZS_StrGrid.Cells[2,i]<>'')  or        //<[Col,Row], 2,i :ssa nyt AINA arvo, jos arvoja on
           (i=FixedRows)  then break;                    //<Asettaa arvon i :lle vaikkei arvorivejä
                            {s := 'Top'+fImrkt0(TopRow,1)+', Vis'+fImrkt0(VisibleRowCount,1)+', i'+fImrkt0(i,1)+' (';}
    uusTop := TopRow;
    vc := VisibleRowCount;
    frw := FixedRows;
    if i < uusTop +vc -1  then begin        //<Alareunassa vapaita rvja -> rvt alemmaksi
       uusTop := frw; {s := s+'1:ut'+fImrkt0(uusTop,1);   }end;
                                                         //'Väliaiksti ylin mahd =Rvt niin alas kuin mahd
    if i > uusTop +vc -1  then begin
       uusTop := i -vc +1;
                            {s := s+',2:ut'+fImrkt0(uusTop,1);  }end;
    if TopRow<>uusTop  then begin                        //<LOPPUSIJOITUS #######################################
      {Visible := false;}
       TopRow := uusTop;    {s := s+',3:ut'+fImrkt0(uusTop,1);  }
      {Visible := true;  }end;
                            {s := s+')===Top'+fImrkt0(TopRow,1)+', Vis'+fImrkt0(VisibleRowCount,1);
                             ZS_Frm.Caption := s;  //ZS_Frm.ZS_InfRv1.Caption := s //<Ei saa Cut&Copy}
  end;//with
end;//topAlimMuk;

                 //Vr=Välirivi  Ow=OtsRw  Nr=ArvoRvTarve <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
function fUusSivu (Vr,Ow,Nr :integer) :boolean;     begin //< +4.0.0
  with ZS_Frm.ZS_StrGrid  do 
  if (R_n=0) and (R_n+1+Nr     > RowCount) or //<Jos ekasta rvstä(Row=0) alkaen, tulee AINA ekax OTSIKKORIVI (=+1)
     (R_n>0) and (R_n+Vr+Ow+Nr > RowCount)    //<edeltVäliRivejä +1xOtsRw +Nriviä (edeltVäliRivejä eiHeti otsikon jälkeen)
     then result := true
     else result := false;
end;
//===============================================================================================================
               //,,, R_n -1 = VIKA TULEVA ARVORIVI. Korjautuu FNC:ssa ChkOtsTarve ###############################
               //Vr=Välirivi  Ot=OtsNo  Nr=ArvoRvTarve <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
function ChkR_n (Vr,Ot,Nr :integer) :boolean;     var jatko,ow,i :integer;
   function fVisibRws :integer;     {VAR h,rh :integer;     }begin //<FNC=NÄKYVIEN rivLkm, ei sis. FixedRows
      with ZS_Frm.ZS_StrGrid  do begin                             //'Periaatteessa sama kuin: VisibleRowCount
        {h := ZS_Frm.ZS_InfPan.Top;   rh := RowHeights[0] +GridLineWidth;
         result := (h DIV rh) -FixedRows;  //<''Antaa 1 rivin liian ison !!!!!!! ???????? !!!!!!! ???????? !!!!!}
         result := VisibleRowCount;
   end; end;
begin
  result := true;  jatko := 0;   //,,Laita kommenttisulut PRC asetaSval_Txt/asetaZval_ :ssa ZS_Frm.Caption := ...
with ZS_Frm.ZS_StrGrid  do begin //,,sq = Global/ZS_.PAS + 1.Sij ao.PRCssä/NolaS+Z.INC =Etsi {#}SQ := ,,,,,,,,,,,
  if (ots=99) or                                            //UpDate;  TopRown pvitys ??? =EiTartte =EiVaikutusta
     (ot IN [1..5]) and (ots IN [6..9])  or                 //<,Putsataan Gridi, jos sulakkeet alla ja tulossa
     (ot IN [6..9]) and (ots IN [1..5])  then PutsCellsR_n; //  imped. tai päinvastoin +Numeroi ColorSilverillä
  ow := 0;                      {#sq := sq+' Ots='+fImrkt0(Ots,1)+'++Rc='+fImrkt0(R_n,1)+' ++ Vr='+fImrkt0(Vr,1);//}
  if (R_n=0) or (R_n>0) and (ots<>Ot)  then ow := 1;        //<Jos olevaOTS poikkeaa kutsuvasta -> uusi OtsRv
                                                            //'Sivun vaihtumisen vaikutus huomioidaanErikseen(+1)
  if (R_n=0)  or                                            //,Välirivi Vr alusta jää vex JA SULAKK:llaJosSamaOsa
     (ot=ots) and (ot IN [1..3])  or                        //<paitsi jos SVAL=4 tai 5. <<<<<<<<<<<<<<<<<<<<<<<<<
     (R_n+Vr+ow>RowCount)  then Vr := 0;                    //<Tai joudutaan "seur.sivulle" =Ei ekax väliriviä.
                                {#sq := '='+fImrkt0(Vr,1)+' Ot='+fImrkt0(Ot,1)+' ow='+fImrkt0(ow,1)+' Nr='+
                                       fImrkt0(Nr,1)+' Top='+fImrkt0(TopRow,1)+' fVis='+fImrkt0(fVisibRws,1)+
                                       ' RwCnt='+fImrkt0(RowCount,1)+' ///';   ZS_Frm.Caption := sq;//}
                                          //,,R_n :n arvo ed.krlta =KUMULATIIVINEN glob.rivilaskuri =...RowMax
                                          //,,R_n-1 =ao.GridRown riviosoite =...Grid.RowCount
 {if (R_n=0) and (R_n+1+Nr     > RowCount) or //<Jos ekasta rvstä(Row=0) alkaen, tulee AINA ekax OTSIKKORIVI (=+1)
     (R_n>0) and (R_n+Vr+ow+Nr > RowCount)    //<edeltVäliRivejä +1xOtsRw +Nriviä (edeltVäliRivejä eiHeti otsikon jälkeen)}
  if fUusSivu (Vr,Ow,Nr)                      //< +4.0.0  '-4.0.0 Korvattu
  then  begin
    {if MessageDlg ('Max.rivimäärä ' +fImrkt0(RowCount - FixedRows,1) +' ylittyy ('+
                    'vapaana ' +fImrkt0(RowCount - R_n, 1) +', tarve ' +fImrkt0(Vr+ow+Nr,1) +
                    '), TYHJENNETÄÄNKÖ taulukko?', mtInformation, [mbYes,mbCancel], 0) = mrYes}
     if InfoDlg ('Max.rivimäärä ' +fImrkt0(RowCount - FixedRows,1) +' ylittyy ('+
                 'vapaana ' +fImrkt0(RowCount - R_n, 1) +', tarve ' +fImrkt0(Vr+ow+Nr,1) +
                 '), TYHJENNETÄÄNKÖ taulukko?',  mtCustom,
                 'Kyllä','Peru','','',  '','','','') = 1
               //['Kyllä','Peru'], []) = 1
     then begin                                                  //''1'' ''''2'''<<<<<<<<<<<<<<<<<<<
        jatko := 1;
        R_n := 0;                               //<R_n = Kumul. riviLaskuri 1..RoxMax ###########################
        Vr := 0;   ow := 1;                     //<Ei väliriviä, Otsikkorivi aina ekax
        ots := 99;                              //<Jotta kutsuvan PRCn otsikkorvtesti: if ots<>.. -> uusi otsikko
        Visible := false;                       //<Jottei putsaus näkyisi "vilahteluina"
        PutsCells_(0,FixedRows);
        Visible := true;  end
     else begin
        jatko := 2;
        result := false;  end;                  //<Välittää kutsuvaan tiedon, ettei voida jatkaa ###
  end;//if R_n...
                          //,,Tämä vain jos tulevat rivit mahtuu lopuille riveille ##############################
  if jatko<>2  then begin //<Jatko=2 =mbCancel =loppu ohitetaan #################################################
     Sval := Aval;
     R_n := R_n+Vr+ow+Nr;                       //<R_n = Kumul. riviLaskuri 1..RoxMax ###########################
     for i := R_n-1 downto R_n-1 -ow-Nr+1  do
     if (i>=0) and (i<=RowMax)  then begin      //<Array AVOS:n sallittu alue
        avos[i].aoVal := Sval;                  //<AvusteColOsoite
        jatko := i - (R_n -Nr -ow);
        avos[i].aoRow := jatko;                 //<BreakPointin takia jatko apuna
     end;
  end;{if jatko<>2}                           {#sq := sq+' Rc='+fImrkt0(R_n,1)+' Top='+fImrkt0(TopRow,1)+' Vr='+
                                                   fImrkt0(Vr,1)+' ow='+fImrkt0(ow,1);   ZS_Frm.Caption := sq;//}
end;//with
end;//ChkR_n
//===============================================================================================================
{ Tulostaa sisällön }
procedure TZS_Frm.PrintContent;
var
   destRect: TRect;
   mult:   real;
   leftMargin, topMargin: integer;
   tmpGrid: TStringGridNola;
   adate, atime: TDateTime;
begin
     Screen.Cursor := crHourGlass;

     adate := date;
     atime := time;

     { Marginaali }
     if (Printer.Orientation = poPortrait) then
     begin
          leftMargin := PRINT_MARGINAL;
          topMargin :=  0;
     end
     else
     begin
          leftMargin := 0;
          topMargin :=  PRINT_MARGINAL;
     end;

     destrect.left := leftMargin;
     destrect.top :=  topMargin;

     printer.Title := PROGRAM_NAME;
     printer.BeginDoc;

     mult := printer.canvas.font.PixelsPerInch / font.PixelsPerInch * (PrintDlgNola.Zoom / 100);

     { Luodaan otsikko }
     destrect.top := destrect.top + PrintHeader(self, printer.canvas, printer.PageWidth, leftMargin, topMargin,
                         caption, 1, adate, aTime, PrintDlgNola.Zoom, mult, PrintDlgNola.PrintHeader);

     { Tulostetaan grid }
     { Luodaan temp grid }
     tmpGrid := TStringGridNola.Create(nil);
     tmpGrid.Visible := False;
     tmpgrid.Assign(TStringGrid(ZS_StrGrid));
     tmpGrid.Visible := False;
     tmpGrid.Parent :=  self;
     tmpGrid.Width :=   tmpGrid.GetMaxWidth;
     //tmpGrid.Height :=  tmpGrid.GetMaxHeight;         //<-130.2e kohta uusi kutsu.

     tmpGrid.RowCount := tmpGrid.GetFirstEmptyRow(1)+1; //< +1 =+4.0.0
     tmpGrid.Height :=   tmpGrid.GetMaxHeight();

     { Merkataan mitä ei tulostetaa }
    ZS_SuljeBtn.tag :=  ZS_SuljeBtn.tag      or PRINT_DISABLED;
    ZS_TulostBtn.tag := ZS_TulostBtn.tag     or PRINT_DISABLED;
    ChkBxAv.tag :=      ChkBxAv.tag          or PRINT_DISABLED;
    ZS_LaskeLbl.tag :=  ZS_LaskeLbl.tag      or PRINT_DISABLED;
    ZS_LaskeBtn.tag :=  ZS_LaskeBtn.tag      or PRINT_DISABLED;

     { Merkataan mitkä leviävät sivun levyisiksi }
     ZS_InfPan.tag := ZS_InfPan.tag or PRINT_WIDTH_FIT_TO_PAGE;
     ZS_Pan.tag :=    ZS_Pan.tag    or PRINT_WIDTH_FIT_TO_PAGE;

    destrect.top := destrect.top +
                 PrintControlEx(tmpGrid, destrect.left, destrect.top,
                                printer.canvas, mult, 0, false, printer.PageWidth - leftMargin);
    tmpGrid.Free;

     { Tulostetaan infot }
     destrect.top := destrect.top +
                  PrintControlEx(ZS_InfPan, destrect.left, destrect.top,
                                 printer.canvas, mult, PRINT_BG_COLOR, true, printer.PageWidth - leftMargin);

     { Tulostetaan alapaneeli }
     destrect.top := destrect.top +
                  PrintControlEx(ZS_Pan, destrect.left, destrect.top,
                                 printer.canvas, mult, PRINT_BG_COLOR, true, printer.PageWidth - leftMargin);

     printer.EndDoc;
     Screen.Cursor := crDefault;
end;//PrintContent
// DEVELOPER2 END

procedure TZS_Frm.ZS_StrGridWidestColInRow(Sender: TObject; ACol, ARow,  newWidth: Integer);   begin
  ZS_StrGrid.ColWidths[ACol] := newWidth;  end;
procedure TZS_Frm.ZS_StrGridHighestColInRow(Sender: TObject; ACol, ARow,  newHeight: Integer); begin
  if ARow<=ZS_StrGrid.RowCount-1  then ZS_StrGrid.RowHeights[ARow] := newHeight;  end;

procedure TZS_Frm.ZS_SuljeBtnClick(Sender: TObject);   begin
   AvuChkSft (10);        //< 0=Sijoittaa saman muihin Frmeihin  10=Vapauttaa  11=Lukitsee
  Close;
  PutsCellsR_n;           //<Numeroi 1..RowMax + Nollaa R_n
  PutsInfoRvt;            //<Tyhjätään alimmat inforivit
  ots := 99;              //<Aiheuttaa GridiPohjaan OtsRivin. Ei enää välttämätön: Aina ao.BtnClick sijUuden
end;

procedure TZS_Frm.ZS_SuTimCmKeyPress(Sender: TObject; var Key: Char); //<+130.1 ObjInsp´ssa.
begin
  inherited;
  if {(Pval=2) and} (key=#13) and okTk
     then SelectNext(ZS_SuTimCm,true,true);
end;

procedure TZS_Frm.ZS_SuTimExit(Sender: TObject);      VAR s :string;  o :integer;  re :real;      begin //+130.0
  inherited;
   s := Trim(ZS_SuTimCm.Text);         //,,,Näitä korjailuja myös FNC okTk´ssä.
   o := Pos(',',s);                    //< s[1]=','
   if (o=1)
   then begin
      s[1] := '.';                     //<Pilkku pisteeksi.
      s := '0' +s  end
   else begin
      o := Pos('.',s);                 //< s[1]='.'
      if (o=1) then s := '0' +s;  end;
   while (Length(s)>=3) and (s[Length(s)]='0') //<1414d: Sirtty Length ekax.
      do Delete (s,Length(s),1);
   o := ZS_SuTimCm.Items.IndexOf(s);

   if SokR(s,re)  and (re>0.05) and (re<10) and (o<0)  then begin
      ZS_SuTimCm.Items.Add(s);
      ZS_SuTimCm.Text := s;
   end;
end;

{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
function okL :boolean;      var r :real;  i{,code} :integer;   s :string;   begin
  okL := false;
  fBxtNyt('okL');
     s := ZS_Frm.ZS_LMed.Text;
     if s<>''  then for i := 1 to Length (s)  do  if s[i] =','  then s[i] := '.'; //<Korjataan ',' => '.'  +1414d: s<>''
     ZS_Frm.ZS_LMed.Text := s;
//Val(ZS_Frm.ZS_LMed.Text, r,Code);             //< code <> 0  =Luku ei muodostunut oikein
  r := StrToFloatQ ({ZS_Frm.ZS_LMed.Text} s);

 {if code=0                                     //'VAL muokkaa TEXT :stä r :lle arvon, jos CODE=0
  then }if (r >= 1) and (r <= 100000)
       then begin okL := true;
                  L := r;    end
       else begin HerjaInfo (myTextBase.Get(ZS_VIRHE_PITUUS_YLITYS));
                  ZS_Frm.ZS_LMed.SetFocus;  end;
 {else begin      HerjaInfo (myTextBase.Get(ZS_VIRHE_PITUUS));
                  ZS_Frm.ZS_LMed.SetFocus;  end; }end;

function okT :boolean;      var r :real;  i{,code} :integer;   s :string;   begin
  okT := false;
  fBxtNyt('okT');
     if Pval=1
        then begin
             s := ZS_Frm.ZS_TMed.Text;                //<,130.2e
             uT := StrToFloatQ (s);  end              //<LASKEbtn  ohjaa ekax tänne ja 2.krlla tämä ohittuu ellei uT -testiä. uT VAIN TÄTÄ TESTIÄ VARTEN.
        else begin
             s := ZS_Frm.{ZS_TMed}ZS_SuTimCm.Text;    //<130.1
             uT := T;  end;                           //<130.2e    'Nollattava'.
     if s<>''  then for i := 1 to Length (s)  do  if s[i] ='.'  then s[i] := ','; //<Korjataan '.' => ','  1414d: +s<>''
     if Pval=1
        then ZS_Frm.ZS_TMed.Text := s                 //<130.2e
        else ZS_Frm.{ZS_TMed}ZS_SuTimCm.Text := s;    //<130.1
//Val(ZS_Frm.ZS_TMed.Text, r,Code);                   //< code <> 0  =Luku ei muodostunut oikein
   //r := StrToFloatQ (ZS_Frm.{ZS_TMed}ZS_SuTimCm.Text); //<130.1
     r := StrToFloatQ (s);                            //<130.1  130.2e
     uT := r;
     if (r >= 0) and (r <= 300)
        then begin okT := true;
                   T := r;    end
        else begin HerjaInfo (myTextBase.Get(ZS_VIRHE_LAMPOTILA_YLITYS));
                   ZS_Frm.{ZS_TMed}ZS_SuTimCm.SetFocus;  end;        //<130.1
  {else begin      HerjaInfo (myTextBase.Get(ZS_VIRHE_LAMPOTILA));
                   ZS_Frm.ZS_TMed.SetFocus;  end; }
end;//okT

function fokLT :boolean;      var ok :boolean;   begin
  ok := okL;
  if ok  then ok := okT;
  fokLT := ok;   end;
//----------------------------------------------------------------
function okMm2 :boolean;      var r :real;  i{,code} :integer;   s :string;   begin
  okMm2 := false;
     s := ZS_Frm.ZS_Mm2Cm.Text;
     if s<>''  then for i := 1 to Length (s)  do  if s[i] =','  then s[i] := '.'; //<Korjataan ',' => '.'  1414d: +s<>''
     ZS_Frm.ZS_Mm2Cm.Text := s;
//Val(ZS_Frm.ZS_Mm2Cm.Text, r,Code);             //< code <> 0  =Luku ei muodostunut oikein
  r := StrToFloatQ (ZS_Frm.ZS_Mm2Cm.Text);
 {if code=0                                      //'VAL muokkaa TEXT :stä r :lle arvon, jos CODE=0
  then}if Aok (trunc(r))
       then begin okMm2 := true;
                  jatkaMm2 := 0;                 //<Estetaan "Kaikki" -valinnan jatko, jos välillä valitaan muuta.
                  mm2 := r;    end
       else begin HerjaInfo ('Lukuarvo poikkeaa hyväksyttävästä!'); //<DEVELOPER2TextBase
                  ZS_Frm.ZS_Mm2Cm.SetFocus;  end;
 {else if SamIso ('Kaikki',s)                                                    //<,,+6.2.2
  then begin      okMm2 := true;
                  if jatkaMm2>0  then
                     mm2 := jatkaMm2;  end
  else begin      HerjaInfo ('Virheellinen merkkijono POIKKIPINTA-arvona');      //<DEVELOPER2TextBase
                  ZS_Frm.ZS_Mm2Cm.SetFocus;  end;  }end;
//---------------------------------------------------------------- ¤DEVELOPER1
function okTyp :boolean;      var utyp :String{Text};      begin
  okTyp := false;
  utyp := ZS_Frm.ZS_TypCm.Text;
  if typOK(1,utyp)                           //<Myös korjasi mahd. lyhennetyn, esim. AMK -> AMKA
  then begin okTyp := true;                  //' ja samalla sijoitti KTYP :ksi, jos oli OK
             ZS_Frm.ZS_TypCm.Text := utyp;  end
  else begin HerjaInfo ('Virheellinen merkkijono kaapeliTYYPPINÄ'); //<DEVELOPER2TextBase
             ZS_Frm.ZS_TypCm.SetFocus;  end; end;
{function okTyp :boolean;      begin
  okTyp := false;
  if typOK(1,ZS_Frm.ZS_TypCm.Text)           //<Myös korjasi mahd. lyhennetyn, esim. AMK -> AMKA
  then okTyp := true                         //' ja samalla sijoitti KTYP :ksi, jos oli OK
  else HerjaInfo ('Virheellinen merkkijono kaapeliTYYPPINÄ');  end;}
{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
{,,,,,,,,,,,,,,,,,,,,EXITissä oltava myös tarkistus, vrt. TABUL. siirtyminen,,,,,,,,,,,,,,,,,,,,,,,}
procedure TZS_Frm.ZS_SuTypCmExit(Sender: TObject);
begin
  inherited;
  if Pval=2  then okSuc;                     //<,Sulaketyyppivalinta vain sulaketarkastelussa Pval=2
  AvuChkSft (10);  end;                      //<+3.0.0

procedure TZS_Frm.ZS_SuTypCmKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Pval=2) and (key=#13) and okSuc
     then SelectNext(ZS_SuTypCm,true,true);
end;

procedure TZS_Frm.ZS_LMedExit(Sender: TObject);      begin //Pval: 1=Imped.tarkastelu  2=Sulaketark.
  case Pval of
  1 :okL;                                            //< Jos eiOK, asetti Focusin takas
  2 :{case Sval of  1,3 :okIk;                       //< Tarkist vasta LaskeBtn :ssa. Muuten ei pääs
                    2,4 :okTk;  end; }end;           //  tä takaisin/eteenpäin muuttamaan mitään.
  AvuChkSft (10);  end;                              //<+3.0.0

procedure TZS_Frm.ZS_LMedKeyPress(Sender: TObject; var Key: Char);      begin
  if key=#13  then begin
  case Pval of
  1 :if okL  then SelectNext(ZS_LMed,true,true);                //< Jos eiOK, asetti Focusin takas
  2 :case Sval of
       1,3 :{if okIk  then }SelectNext(ZS_LMed,true,true);      //<Tarkistus vasta LaskeBtn!!!!!!!
       2   :{if okTk  then }SelectNext(ZS_SuTimCm,true,true);   //<+130.0
       4   :{if okTk  then }SelectNext(ZS_LMed,true,true);  end;//case Sval
end;{case Pval} end; end;//-------------------------------------------------------------------------
(*,,,,,,,,Näin oli ennen OnExit PRCn lisäyksiä =TABsiitymistarkistuksia ei ollut. Muuten OK,,,,,,,,,
procedure TZS_Frm.ZS_LMedKeyPress(Sender: TObject; var Key: Char);      begin
  if key=#13  then begin
  case Pval of
  1 :if okL  then SelectNext(ZS_LMed,true,true);
  2 :case Sval of
       1,3   :if okIk  then SelectNext(ZS_LMed,true,true);
       2,4   :if okTk  then SelectNext(ZS_LMed,true,true);  end;//case Sval
end;{case Pval} end; end;//-------------------------------------------------------------------------*)

procedure TZS_Frm.ZS_TMedExit(Sender: TObject);      begin
  case Pval of //Pval=1 =Z-valinta  2=S-valinta
  1 :okT;
  2 :case Sval of  1,2,4 :{okSftk};
                   3     :{okTk};  end; end;
  AvuChkSft (10);  end;                              //<+3.0.0

procedure TZS_Frm.ZS_TMedKeyPress(Sender: TObject; var Key: Char);      begin
  if key=#13  then begin
  case Pval of //Pval=1 =Z-valinta  2=S-valinta
  1 :if okT  then SelectNext(ZS_xMed,true,true);                                  //<Imped.tarkastelu
  2 :case Sval of                                                                 //<Sulaketarkastelu
       1,2,4   :{if okSftk  then }SelectNext({ZS_TMed}ZS_SuTimCm,true,true);      //<130.1
       3       :{if okTk    then }SelectNext({ZS_TMed}ZS_SuTimCm,true,true);  end;//case Sval     130.1
end;{case Pval} end; end;//-------------------------------------------------------------------------

procedure TZS_Frm.ZS_Mm2CmExit(Sender: TObject);      begin
  case Pval of //Pval=1 =Z-valinta  2=S-valinta
  1 :if ZS_Mm2Lbl.Visible  then okMm2;                                //<Imped.tarkastelu
  2 :case Sval of                                     //,EiTarttis =4 ei aktivoi Mm2Com:ia ollenkaan
       1,2,3,4 :okIsu;  end; end;                     //<okIsu oli kommentoitu vex, nyt takas +2.0.2
  AvuChkSft (10);  end;                               //<+3.0.0
procedure TZS_Frm.ZS_Mm2CmKeyPress(Sender: TObject; var Key: Char);      begin
  if key=#13  then begin
  case Pval of //Pval=1 =Z-valinta  2=S-valinta
  1 :if ZS_Mm2Lbl.Visible  then if okMm2  then SelectNext(ZS_Mm2Cm,true,true);
  2 :case Sval of                                     //,EiTarttis =4 ei aktivoi Mm2Com:ia ollenkaan
       1,2,3,4 :{if okIsu  then }SelectNext(ZS_Mm2Cm,true,true);  end;//case Sval
end;{case Pval} end; end;//-------------------------------------------------------------------------

procedure TZS_Frm.ZS_TypCmExit(Sender: TObject);      begin
  case Pval of //Pval=1 =Z-valinta  2=S-valinta
  1 :if ZS_TypLbl.Visible  then okTyp;
  2 : ;  end;                               //<S :ssä eioo käytetty ollenkaan
  AvuChkSft (10);  end;                     //<+3.0.0

procedure TZS_Frm.ZS_TypCmKeyPress(Sender: TObject; var Key: Char);      begin
  if key=#13  then begin
  case Pval of //Pval=1 =Z-valinta  2=S-valinta
  1 :if ZS_TypLbl.Visible  then if okTyp  then SelectNext(ZS_TypCm,true,true);
  2 : ;                                         //<S :ssä eioo käytetty ollenkaan
end;{case Pval} end; end;//-------------------------------------------------------------------------

procedure TZS_Frm.ZS_xMedExit(Sender: TObject);      begin
  case Pval of //Pval=1 =Z-valinta  2=S-valinta
  1 : ;        //<Ei käytössä Z-valinnassa
  2 :{okSftk};  end; end;
procedure TZS_Frm.ZS_xMedKeyPress(Sender: TObject; var Key: Char);      begin
  if key=#13  then
  case Pval of //Pval=1 =Z-valinta  2=S-valinta
  1 : ;        //<Ei käytössä Z-valinnassa
  2 :{if okSftk  then }SelectNext(ZS_xMed,true,true);//<Vain 3 aktivoi xMmed:n, ei tarvita: case Sval
  end;//case Pval
  AvuChkSft (10);  end;                              //<+3.0.0
{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
procedure anAvuste (X,Y :integer);      var ZSval,avRw,uCl,uRv :integer;
  {------------------------- Korvattu ..MouseToCell -PRC:llä ---------------------------------------
    var dX,dY :integer;
  function fCl :integer;  begin  fCl := (X div dX) +1;  end; //<fCl = SarakeN:o, 1 =1.vasemmalta jne.
  function fRv :integer;  begin  fRv := (Y div dY) +1;  end; //<oY=0= Caption -otsikkoalueen alareuna, missä X=0 ja Y=0
  -------------------------------------------------------------------------------------------------}
{@function fY :integer;   begin  fY := fRv *dY;         end;@}         //'Otsikkorivi => fRv=1
  function fCl :integer;      var ACol,ARow :integer;      begin //<Pal Cellin COLn
    ZS_Frm.ZS_StrGrid.MouseToCell(X-3,Y, ACol,ARow);
   {if Pval=1  then result := ACol+1   //'-3 =Jättää vähän marginaalia oik. reunassa<<<<<<<<<<<<<<<<
               else result := ACol;    //<Rivisarake ekana = 0 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<}
    result := ACol;
  end;//fCl;
  function fRv :integer;      var ACol,ARow :integer;      begin //<Pal Cellin ROWn
    ZS_Frm.ZS_StrGrid.MouseToCell(X,Y, ACol,ARow);
    result := ARow;
  end;//fRv;

{-function LopTyhRv (colu :integer) :boolean;      begin //,[2,x]=mm²:ssa aina jotain, jos jotain ko.rvllä
    if ZS_Frm.ZS_StrGrid.Cells[colu,uRv]=''  then result := true  else result := false;
  end;-}

  function SVjOsa :boolean;      var s0,s1 :string;   boo :boolean;      begin
  //if (Zval=1) and (ZS_Frm.ZS_TypCm.Text = 'SVjärjest.')  then onSVj := true   else onSVj := false;    end;
    with ZS_Frm.ZS_StrGrid  do begin                        //''Sijoitettiin tätä testiä varten TYPok :ssa
       s0 := Cells[1,uRv-avRw];   s1 := Cells[1,uRv-avRw+1];
     //if (ZSval=1) and (( Pos('SVjärjest.', s0) <> 0 ) or  ( Pos('SVjärjest.', s1) <> 0 ))         //< -6.0.2
       if Mukana ('SVsystAL3½',s0) or Mukana ('SVsystCu3½',s0) or Mukana ('SVsystAL4N',s0) or       //<,,+6.0.2
          Mukana ('SVsystCu4N',s0) or Mukana ('SVsystAL5S',s0) or Mukana ('SVsystCu5S',s0) or

          Mukana ('SVsystAL3½',s1) or Mukana ('SVsystCu3½',s1) or Mukana ('SVsystAL4N',s1) or
          Mukana ('SVsystCu4N',s1) or Mukana ('SVsystAL5S',s1) or Mukana ('SVsystCu5S',s1)
       then boo := true   else boo := false;
       result := boo;  end;
  end;

  function fSVjVr :integer;      var i :integer;      begin
    result := 0;
    for i := uRv-avRw to RowMax-1  do
    if ZS_Frm.ZS_StrGrid.Cells[2,i]=''  then begin          //<[2,x]=mm²
       result := i;
       break;  end;
  end;//fSVjVr                              //,,AVj :n tulostusosa ennen oikosulkuimped.osaa edeltävää VÄLIRIVIÄ
  function SVjAlkuOsa :boolean;      var boo :boolean;      begin
    if SVjOsa  and (uRv<fSVjVr)  then boo := true  else boo := false;
    result := boo;
  end;//SVjAlkuOsa                          //,,AVj :n tulostusosa normaali-imped.osan VÄLIRIVIN JÄLKEEN
  function SVjLoppOsa :boolean;      var boo :boolean;      begin
    if SVjOsa  and (uRv>fSVjVr)  then boo := true  else boo := false;
    result := boo;
  end;//SVjLoppOsa

  function MnOsa :boolean;      var s0,s1 :string;   os0,os1 :integer;   boo :boolean;      begin
   {if (Zval=1) and ((ZS_Frm.ZS_TypCm.Text = 'Muuntajat 1') or (ZS_Frm.ZS_TypCm.Text = 'Muuntajat 2'))
    then onMn := true   else onMn := false;    end;}
    with ZS_Frm.ZS_StrGrid  do begin
       s0 :=  Cells[1,uRv-avRw];       s1 :=  Cells[1,uRv-avRw+1];
       os0 := Pos('HÄVIÖsarja', s0);   os1 := Pos('HÄVIÖsarja', s1);
       if (os0<>0) or (os1<>0)  then boo := true  else boo := false;
       result := boo;
  end;  end;

  procedure sel (otsNo :integer);      begin
     if SyoAvOn and (otsNo>0)       //< +3.0.0
        then avuste (0,otsNo,8, 0)
        else ValmistaNollaaAvuste;  //< +3.0.0
     ZS_Frm.SetFocus;     end;

begin//anAvuste...........................................................
  {------------------------- Korvattu ..MouseToCell -PRC:llä ---------------------------------------
  dX := ZS_StrGrid.DefaultColWidth;    //< Width=64  =dX, testattu OK: ks. Herjainfo h=,,,
  dY := ZS_StrGrid.DefaultRowHeight;   //< Height=15 =dY, testattu OK: ks. Herjainfo h=,,,
  -------------------------------------------------------------------------------------------------}
uCl := fCl;  uRv := fRv;   //<Breakpointin takia:  FNC fCl,fRv = Unaccessible ...
if (uRv<0) or (uRv>RowMax)
then sel(0) //<'MuutenVirheilmoitus lukual.ylityksestä, kun Gridstä oikealta ulos //<############################
else begin
   ZSval := avos[uRv].aoVal;
   avRw :=  avos[uRv].aoRow;
case Pval of                                                //,,uCl = Sarakkeen (=col) mukainen info
1:case ZSval of //<Pval= 1=Imped.tarkastelu  2=Sulaketarkastelu ####################################
  1,2 :if SVjLoppOsa  then                                  //<,SVj:n oikosulkuimpedanssit
          case uCl of  0 :sel(0);    1 :sel(21);   2 :sel(22);   3 :sel(23);  4 :sel(24);  5 :sel(25{43});
                       6 :sel(46{44});   7 :sel(47{45});   8 :sel(48{46});   9 :sel(49{38}); else sel(0);  end  else
       if SVjAlkuOsa or  NOT SVjOsa and NOT MnOsa  then     //<<SVj:n norm.impedanssit tai MMJ yms.
          sel(uCl+20)  else
       if MnOsa  then
          case uCl of  1,2 :sel(uCl+50);   4 :sel(24);   5 : sel(25);  6..19 :sel(uCl+47); //< 6.1.1  Muutos
                       else sel(0);  end  else                                             //'16=>19  8.0.5
       sel(0);
  else
       sel(0);  end;//case Zval                             //,,uCl = Sarakkeen (=col) mukainen info
2:case ZSval of //<Pval= 1=Imped.tarkastelu  2=Sulaketarkastelu ####################################
  1 :case uCl of 0 :sel(0);  1 :sel(1);  2 :sel(2);  3 :sel(3);  4 :sel(5);  5 :sel(7);  6 :sel(9);  else sel(0); end;
  2 :case uCl of 0 :sel(0);  1 :sel(1);  2 :sel(2);  3 :sel(7);  4 :sel(5);  5 :sel(3);  6 :sel(9);  else sel(0); end;
  3 :case uCl of 0 :sel(0);  1 :sel(1);  2 :sel(2);  3 :sel(4);  4 :sel(7);  5 :sel(5);  6 :sel(8);  7 :sel(9);  else sel(0); end;
  4 :case uCl of 0 :sel(0);  1,3,5,7 :sel(1);  2,4,6,8 :sel(3);  9 :sel(7); 10 :sel(5); 11 :sel(9);  else sel(0); end;
  5 :case uCl of 0 :sel(0);  1 :sel(1);  2 :sel(2);  3..12 :sel(10);  else sel(0);  end;
else sel(0);  end;//case Sval.                                     <''else sel(0); =Putsaa avusteruudun
end;{case Pval             HYVÄ:}{-ZS_Frm.ZS_InfRv1.Caption := 'ZSval='+fImrkt0(ZSval,1) +' avRw='+
                                   fImrkt0(avRw,1) +'  uCl='+fImrkt0(uCl,1) +' uRv='+fImrkt0(uRv,1)+
                                   ' // SVjAlku='+fBmrkt0 (SVjAlkuOsa,2)+' SVjLopp='+fBmrkt0 (SVjLoppOsa,2)+
                                   ' fSVjVr='+fImrkt0(fSVjVr,1)+'  aoRow0='+fImrkt0(uRv-avRw+1,1);//}
end;//if (sRow<=RowMax) &..else
end;//anAvuste
{--------------------------------------------------------------------------------------------------}
procedure TZS_Frm.ZS_StrGridMouseMove(Sender: TObject; Shift: TShiftState;  X, Y: Integer);    begin
   if ZS_Frm.Active  then begin                                                                  //<+6.1.1
      anAvuste (X,Y);
      ZSx := X;  ZSy := Y;            //<Tarvitaan StrGridDblClikissä ##############################
    //SyottoAvFrm.FormStyle := fsStayOnTop; //<Ei tarvita, TODETTU
    //ZS_Frm.SetFocus;                //<Jos oli.. Aiheuttaa avFrm :n vilahtelua BxClickin jälkeen, TODETTU
   {½-ZS_StrGrid.SetFocus;            //<Jos oli UnChecked +Click, jätti ekalla focusin avusteFrmiin½}
   end;
end; //''''''''''''TÄMÄ YKSIN EHKÄ RIITTÄISI #######################################################

procedure TZS_Frm.ZS_StrGridMouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);
     {var alpBoo :boolean;  }begin              //'MouseDown, koska se antaa X,Y :n, OnClick ei anna
     //EiOkInfo ('MouseDwn');
   if DblClck
   then begin
      DblClck := false;      //<DblClick aiheuti näköjään MouseDwn:n. Tämä ohjaa DblClick -tapahtumat
      syoAktv := false;      //<Vapauttaa avusteen                    ''Varmksi myös siellä
      anAvuste (ZSx,ZSy);    //<+1.1.0+
      AvuChkSft (10);  end   //<VAIHDETAAN MUIHINKIN LOMAKKEISIIN, 10=Vapauttaa #######################
   else begin
    //if (Shift=ssShift) or (Shift=ssAlt) or (Shift=ssCtrl)  then NayAsetuksetGrd;  ==EiOKI
    //if Shift IN [ssShift,ssAlt,ssCtrl]  then NayAsetuksetGrd;                     ==EiOKI
    //if (Shift IN ssCtrl) or (Shift IN ssShift) or (Shift IN ssAlt)                 ==EiOKI
    if (ssCtrl IN Shift) or (ssShift IN Shift) or (ssAlt IN Shift)
       then NayAsetuksetGrd (1)
       else NayAsetuksetGrd (0);
   {if ssAlt IN Shift
    then NayAsetuksetGrd (2)
    else NayAsetuksetGrd (0);}
      syoAktv := false; //<+1.1.0+
      anAvuste (X,Y);
      AvuChkSft (11);                 //<VAIHDETAAN MUIHINKIN LOMAKKEISIIN, 11=Lukitsee ######################
   end;  {,,,Näillä eka Click lukitsee ja vapautuu vasta ChkBxAv :n Clickauksella ############################
         //,,HUOMAA, että SYOTTOAV.PASsin PRC AvuChkStr :ssa pitää olla tähän sopiva kuvio ###################}
end;//ZS_StrGridMouseDown
{==================================================================================================}
procedure TZS_Frm.ZS_TulostBtnMouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      const marg=200;                                                       //<Object Inspectorissa LINES p.o. TYHJÄ,
      var   i,RivPit :integer;  s :string;  alpSyoAktv,alpSyoAvOn :boolean; //'muuten zsRICH NÄKYY lomakkeella,TODETTU

  procedure LF;                        begin  aRich.AddText ('<br>');  end;
  procedure lisaaKpl (ss :string);     begin  if ss<>''  then begin
                                                 ss := ss+'<br>';  aRich.AddText (ss);  LF;  end; end;
  procedure PRNfile;      VAR aw :word;  i,o,c :integer;  ss :string;          //<+6.0.4
                              arr :Array [0..30] of integer;                 //<ARR=Mjonon max.pituus ao. Cellissä
   //procedure wr (Col,Riv :integer);      VAR ai,i,tab,des :integer;  ar :real;  sa :string;      begin
     procedure wr (Col,Riv :integer);      VAR i,tab :integer;  sa :string;      begin
        sa := TagVex (ZS_StrGrid.Cells[Col,Riv]);
        sa := Trim (sa);
        tab := arr[Col];
{        if SokI (sa,ai) or SokR (sa,ar) //<,,Jos Integeri tai Reaaliluku, tehdään strg uudestaan: TAB/DES suoraksi
        then begin
             if SokR (sa,ar)  then begin
                i := Pos ('.',sa);
                if i>0  then
                   des := Length (sa) -i;
             end;
             if des>0
                then sa := fRmrkt0 (ar,tab,des) +'  '
                else sa := fImrkt0 (ai,tab)     +'  ';
        end
        else begin for i := Length (sa) to tab-1  do
                     if c>2  then sa := sa +' '
                             else sa := ' ' +sa;       //<Alkusarakkeissa ilevien tekstien ETEEN = OIK.SUORA
                     sa := sa                   +'  '; //<Sama väli seuraavalle kuin AR,AI :llä.
        end;}
        for i := Length (sa) to tab-1  do
          {if c>2  then sa := sa +' '
                   else sa := ' ' +sa;       //<Alkusarakkeissa ilevien tekstien ETEEN = OIK.SUORA}
           sa := ' ' +sa;                    //<Alkusarakkeissa ilevien tekstien ETEEN = OIK.SUORA
        sa := sa +'  ';
        Write (ZSfile,sa{+'\'});             //< '\' =Havainnollistaa hyvästi. 
     end;
  begin
     if ZSfileN=''  then begin
        ZSfileN := gAjoPath ; //+-12.0.05 oli: ExtractFilePath (Application.ExeName);//<Pelkkä polku ilman filenimeä
        ZSfileN := ZSfileN +'Data\ZS-Tuloste.TXT';  end; //<Extract.. teki jo 1x '\'. Ei tartte ForceDirectories ()
     SaveDlg.FileName := ZSfileN;
     SaveDlg.Filter := '*.TXT|*.TXT|*.*|*.*';
                   {s := fOhaS (oha) +'tiedostot (*.' +ExtN +')|*.' +ExtN +'|Käyttäjän omat tiedostot (*.*)|*.*';}
   //if MessageDlg ('Kirjoitetaanko tiedostoon  '+ZSfileN +' ?', mtInformation,[mbYes,mbCancel],0) = mrYes
     if SaveDlg.Execute                         //SaveDialog
     then begin
        ZSfileN := SaveDlg.FileName;            //<+6.1.1  Ei muuttanut nimeä, vaikka dialogissa muutettiin
                               //¿DefsFileenZ('AssgnFile 11');
        AssignFile (ZSfile,ZSfileN);
        aw := 2;                                //< 2 = Ei
        if fFileExists(ZSfileN)  then
          {aw := MessageDlg ('Kirjoitetaanko vanhan tiedoston jatkoksi (No = Vanha korvataan uudella) ?',
                             mtInformation,[mbYes,mbNo,mbCancel],0);}
           aw := InfoDlg ('Kirjoitetaanko vanhan tiedoston jatkoksi ?',  mtCustom,
                 'Kyllä','Ei','Peru','',  '','Vanha korvataan uudella.','','');
           if aw=9  then aw := 3; //<Jos Dlg suljettiin X :llä
           
        if aw=1  then begin
                          Append  (ZSfile);  Writeln (ZSfile);  end else //<Tyhjä rivi väliin
        if aw=2   then Rewrite (ZSfile);                                 //<'Jos mrCancel, ei avata ollenkaan.

        if aw<>3  then begin
           for c := 0 to ZS_StrGrid.ColCount-1  do //<,Alustetaan, jotta vertailu mahista.
              arr[c] := 0;

           o := 0;
           for i := ZS_StrGrid.RowCount-1 DownTo 0  do  //<,Etsitään vika arvorivi
           if (ZS_StrGrid.Cells[1,i]<>'') or (ZS_StrGrid.Cells[2,i]<>'') or (ZS_StrGrid.Cells[3,i]<>'') or
              (ZS_StrGrid.Cells[4,i]<>'') or (ZS_StrGrid.Cells[5,i]<>'')
              then begin o := i;  break;  end;

           for c := 0 to ZS_StrGrid.ColCount-1  do //<,Käydään läpi Cellit SARAKKEITTAIN, sijoitet. isompi Length
           for i := 0 to o  do begin               //  merkkijonon pituustaulukkoon ARR[] :iin.
              ss := ZS_StrGrid.Cells[c,i];
              ss := TagVex (ss);
              ss := Trim (ss);
              if Length (ss) > arr[c]
                 then arr[c] := Length (ss);
           end;
           for i := 0 to o  do begin
              for c := 0  to ZS_StrGrid.ColCount-1  do
                 wr (c,i);
              Writeln (ZSfile);
              Flush (ZSfile);  { ensures that the text was actually written to file }
           end;
           CloseFile(ZSfile);
        end;
     end;
 end;//PRNfile

begin//ZS_TulostBtnMouseDown..........................
  inherited;
//IF PaaValFrm.PrinterSetupDialog1.Execute  then begin
   ZS_TulostBtn.Enabled := False;
   alpSyoAktv := SyoAktv;                             //< +3.0.0
   alpSyoAvOn := SyoAvOn;                             //< +3.0.0
   if (ssCtrl IN Shift) and (ssShift IN Shift)
   then PRNfile                                       //< +6.0.4
   else begin
     IF Pval=1                                        //<,,+6.0.2
        then Printer.Orientation := poLandscape
        else Printer.Orientation := poPortrait;
     IF PrintDlgNola.Execute(modeZS, self)  then begin  //DEVELOPER2 6.12.1998
       Screen.Cursor := crHourGlass;        //<Ilman SCREENiä vipattaa!!!
       try
          if (PrintDlgNola.printRange = rangeHelpPages) // DEVELOPER2 1.1.1998
          then begin          //<Tulostetaan AVUSTEET #################################################
            with aRich  do begin
              WordWrap := true;
              Lines.Clear;                                //<Pakko (???) tyhjätä, jää muuten osa alpsta
              RivPit := Printer.PageWidth;
              PageRect := Rect(marg,0, RivPit,Printer.PageHeight);  //=2326,3389 =oaX,Y
              RivPit := RivPit-marg;
              Alignment := taLeftJustify;                 //<Ei riittänyt Obj.Inspectorista asettaen<<<
            end;//with aRich                              //'=Tämäkään eiOK. Lisättävä 1.rvlle '<left>'
            syoAktv := false;                             //<Jotta avuste päivittyisi aRichiin<<<<<<<<<
            aRich.Font.Size :=  10;                  //<,Jo tässä, jotta WHILE-silmukka laskisi oikein.
            aRich.Font.Style := [fsBold];
            aRich.AddText ('<left>'); //<Muutetaan vasensuoraksi ######################################

            if Pval=1         //<Impedanssitarkastelu #################################################
            then s := otsikko (RivPit,'IMPEDANSSITARKASTELUOSAN SARAKEKOHTAISET SELITYKSET: ',aRich.Font)
            else s := otsikko (RivPit,'SULAKETARKASTELUOSAN SARAKEKOHTAISET SELITYKSET: ',aRich.Font);
            aRich.Font.Size :=  8;                        //<,Vex, jotta <..> workkisi, muuten ei onaa,
            aRich.Font.Style := [];                       //<' TODETTU ################################
                        (*aRich.AddText ('Rich.Width='+fImrkt0(aRich.Width,1)+'  Printer.PageWidth='+
                                fImrkt0(Printer.PageWidth,1)+'  pist='+fImrkt0(Length(pist),1)+
                               {'  Y_fPixPit()='+fImrkt0(Y_fPixPit (ZS_Frm,s,aRich.Font),1)+}
                                '  Prn.Cnv.TxWdh(s)='+fImrkt0(Printer.Canvas.TextWidth(s),1)+   {=2076}
                                '  RivPit='+fImrkt0(RivPit,1)+'  Y_fPix(ZS_,s,zsR.F)='+
                                fImrkt0(Y_fPixPit(ZS_Frm,s,aRich.Font),1));                     {=683}
                                aRich.Visible := true;*)
                                                      //,</b> tässä järjestyksessä, nuuka #############
            lisaaKpl ('<b><f n="" s="10">'+ s +'</f></b>');  LF;                 //< LF=TyhjäRiviVäliin
            if Pval=1         //<Impedanssitarkastelu #################################################
            then begin        //,,Seuraavassa käytetään aRichin WordWrap:iä hyväksi rivijakoon ########
              for i := 21 to 60  do begin
                s := avuste (0,i,8, 1);
                lisaaKpl (s);
              end; end//for i/if Pval=1 ###############################################################
            else begin        //<Sulaketarkastelu #####################################################
              for i := 1 to 15  do begin //< 10=vika
                s := avuste (0,i,8, 1);
                lisaaKpl (s);
              end;{for i}
            end;//if Pval=1 else
          //avuste (0,avuRv,0, 0);                 //<Avusteikkunassa vilisti kaikki avust. Alp takas
            aRich.Print('');  //#######################################################################
          end                 //<Tulostettiin avusteet ################################################
          else begin          //<Tulostetaan LOMAKE ###################################################
            // ZS_Frm.PrintScale := poPrintToFit;
            // ZS_Frm.Print;  end;                //ZS_Frm.Print; =Tulostaa FORMin painikkeineen + tlkn
            PrintContent; // DEVELOPER2 1.1.1998         //'ZS_Frm.Z_StrGrid.Print = Undeclared identifier
          end;
       finally
       //sijTulHint;
         Screen.Cursor := crDefault;
       end;//finally
     end;//if ..Execute
  end;
  ZS_TulostBtn.Enabled := True;
  SyoAktv := alpSyoAktv;             //< +3.0.0
  SyoAvOn := alpSyoAvOn;             //< +3.0.0
  SyottoAvFrm.Hide;                  //< +3.0.0 Poistetaan tulostuksesta näkyviin jäänyt vika avuste
end;//ZS_TulostBtnMouseDown
(*procedure TZS_Frm.ZS_TulostBtnClick(Sender: TObject);      //Tämä OK, mutta sarakkeet eiOK
  var cl,rw :integer;   UlosTxt :System.Text;
begin
  IF PrintDialog1.Execute  then begin
    Screen.Cursor := crHourGlass;                   //<Ilman SCREENiä vipattaa!!!
    try
      AssignPrn(UlosTxt);
      Rewrite(UlosTxt);
      Printer.Canvas.Font := Z_StrGrid.Font;
      with ZS_Frm.Z_StrGrid  do begin
        for rw := 0 to RowCount -1 do
        for cl := 0 to ColCount -1 do begin
          write(UlosTxt, Cells[cl,rw]);
          if cl=ColCount-1  then writeln(UlosTxt);  end;

        writeln(UlosTxt, ZS_Frm.RichInfo1.Line[1]);
        writeln(UlosTxt, ZS_Frm.RichInfo2.Line[1]);
        writeln(UlosTxt, ZS_Frm.RichInfo3.Line[1]);  end;
    finally
      CloseFile(UlosTxt);
      Screen.Cursor := crDefault;
    end;
  end;
end;//-----------------------------------------------------------------------------------*)
{==================================================================================================}
procedure TZS_Frm.ZS_LaskeBtnClick(Sender: TObject);   //L := FNC okL,  T := FNC okT / fokLT :ssa
    var boo :Boolean;  u :integer;                     //mm2 := FNC okMm2 (/ Aok) :ssa
begin
  Screen.Cursor := crHourGlass;                        //<+6.2.2
  Herja1Frm.Close;
  boo := true;
  //  Y_DemoInfo ('Tulosta');
  //  if Sender = PaaValFrm.ImpedNap   then Y_DemoInfo ('Imped.');   //<SENDER ei tunnista
  //  if Sender = PaaValFrm.SulakeNap  then Y_DemoInfo ('Suleke');   //<SENDER ei tunnista
  //if Sender = PaaValFrm.ImpedNap
  {then }
  //  if Sender = PaaValFrm.ImpedNap   then Y_DemoInfo ('Imped.');   //<SENDER ei tunnista
  //  if Sender = PaaValFrm.SulakeNap  then Y_DemoInfo ('Suleke');   //<SENDER ei tunnista
  //if ZS_LLbl.Caption = 'L [m] :'                      //<Oli asetettu IMPEDANSSEJA varten

{,,,,,,,,,,,,,,,,,,ok.. TUTKII SYÖTTÖIKKUNOIDEN OIKEELLISUUDEN + SIJOITTAA,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                        TULOSTETTAVAT ARVOT LASKETAAN AO.PRCssä (S.INC)                                         }
//  Y_DemoInfo ('Pv='+fImrkt0(Pval,1)+'  Sv='+fImrkt0(Sval,1));
  if Pval=1                                             //<PÄÄVALIKOSTA valittu: IMPEDANSSI...
  then begin
       if ZS_TypLbl.Visible                             //<TYYPPIkohtaisten arvojen laskenta
          then if NOT okTyp  then boo := false;         //Ktyp := typOK :ssa
       if fokLT
          then if okMm2
               then if boo
                    then ohjaaZval;  end                //<..then if.. Jottei peräkk herjoja
  else begin
    boo := false;  u := 0;
    case Sval of                                        //<,,130.1: +case
        1 :boo := okSuc and okIsu and  okIk  and okSftk;
        2 :boo := okSuc and okIsu and  okTk  and okSftk;
        3 :begin //boo := okSuc and okIsu and  okIk  and okTk and okSftk;
                 if                NOT okSuc  then u := u+1;  //<,,Ei muita testejä kun eka NOT.
                {if (u=0) then} if NOT okIsu  then u := u+10;
                {if (u=0) then} if NOT okIk   then u := u+100;
                {if (u=0) then} if NOT okTk   then u := u+1000;
                {if (u=0) then} if NOT okSftk then u := u+10000;
                 if u=0  then boo := true;
           end;
        4 :boo := okSuc and            okTk  and okSftk;
        5 :boo := true;
    end;
  (*if Sval=1 then begin  if okSuc and okIsu and  okIk  and okSftk   then boo := true;  end else         -130.1
    if Sval=2 then begin  if okSuc and okIsu and  okTk  and okSftk   then boo := true;  end else
    if Sval=3 then begin  if okSuc and okIsu and  okIk  and okTk and okSftk   then boo := true;  end else//<okSftk tutkii: IF Sval=3
    if Sval=4 then begin  if okSuc and            okTk  and okSftk   then boo := true;  end;
    if Sval=5 then begin {ZS_Frm.ZS_SuTypCm.Text := su_OFAg;                               //<+2.0.1 FNCokSucVarten
                          if okSuc                                 then}boo := true;  end; //<-2.0.1  *)
    if boo  then ohjaaSval;  end;
  Screen.Cursor := crDefault;                          //<+6.2.2
end; {ZS_LaskeBtnClick}

procedure TZS_Frm.FormActivate(Sender: TObject);      begin
{6 if ChkBxAv.Checked  then syoAktv := false
                       else syoAktv := true;}
  if Pval=1                                             //<Pval=2 =SUL hoidetaan S_Paaval / ohjaaSval
  then begin  ZS_Frm.ZS_xLbl.Visible := false;          //<Käytössä vain SULAKEtoiminnassa SVAL=3..?
              ZS_Frm.ZS_xMed.Visible := false;          //<Käytössä vain SULAKEtoiminnassa SVAL=3..?
              ZS_SuljeBtn.Hint := 'Sulkee lomakkeen, palaa impedanssitarkastelun valikkoon';  end
  else        ZS_SuljeBtn.Hint := 'Sulkee lomakkeen, palaa sulaketarkastelun valikkoon';
   //ZS_Frm.Caption
  if Pval=1  then Caption := PROGRAM_VERSIO_STRING +':  Impedanssitarkastelut' //<,+6.2.10
             else Caption := PROGRAM_VERSIO_STRING +':  Sulaketarkastelut   [ ' +Ints (Aval) +' ]'; //+10.0.1: Sval jälkeen uusi Caption.

  ZS_StrGrid.SetFocus;             
end;

procedure TZS_Frm.FormDeactivate(Sender: TObject);      begin
//6syoAktv := false;
//sijTulHint;                                           //<Tutkii ja sijoittaa syoAkt :n mukaan<<<<<
end;//'Oltava OnDeactiv:ssa: Siirrettäessä avusteikkunaa, active siirtyy siihen, eikä Hint ole ajantas.

procedure TZS_Frm.ChkBxAvMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
begin                            //'=TapahtuuKunKlikattu ChkBxAv :ta, CB -ARVO EI VIELÄ EHTINYT MUUTTUA, TODETTU.
  inherited;                     //,,Vaihdetaan cbUnChecked, muuten eventti vaihtaa Grayed -> Checked -> UnCheckd
   apuaOn := false;
                 //==Jos tässä sij. cb -arvo, menee ChkBxAvClick -eventiin, eli ei voi lisätä muuta: Menee ENDiin
   if ChkBxAv.State IN [cbGrayed,cbChecked]            //<Pakotet. cbGrayed t. cbChecked -> cbUnChecked
      then Gray_Chkd := true                           //<,Ei voi asettaa suoraan STATEa: aiheuttaa
      else Gray_Chkd := false;                         //  eventin, TODETTU.########################
end;

//,,AvCloseOK on aina päällä, FA vain AvuChkSf :stä
procedure TZS_Frm.ChkBxAvClick(Sender: TObject);  begin//,,CheckedArvo onJo ehtínyt vaihtua Clickin jälk, TODETTU
   if AvCloseOK  then begin                            //<Vain ekalla kerralla läpi, 2.krt tullaan AvuChkSf :stä
      if Gray_Chkd  then begin
         ChkBxAv.State := cbUnChecked;                 //<Vain ChkBxAvMouseDown :sta. Aiheuttaa EVENTIN @@@@@@@@@
{2.0.5+} syoAktv := false;  end;        //<Koska SYOAKTV+SYOAVONin perusteella Grayed/Chkd/UnChkd AvuChkSft :ssa
      if ChkBxAv.State=cbUnChecked
{2.0.5+} then begin syoAvOn := false;   //<, SYOAVON asetus VAIN TÄSSÄ + StrGrDblClick :ssä #####################
                    SyottoAvFrm.Hide;  end
{2.0.5+} else       syoAvOn := true;                   //<Kattaa cbGrayed + cbChecked
      AvuChkSft (0);  end;
   Gray_Chkd := false;                                 //<Vain ChkBxAvMouseDown :ssa @@@@@@@@@@@@@@@@@@@@@@@@@@@@
end;//ChkBxAvClick
//==================================================================================================
procedure TZS_Frm.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);      begin//1.1.3 m++
  inherited;
   if key=112  then begin                //<112 = F1. HUOM: MoFrm.KeyPreview p.o. TRUE #############
      if syoAvOn  then ChkBxAv.Checked := false //<+1.1.3
                  else ChkBxAv.Checked := true;
      AvuChkSft (0);  end;               //<Päivitetään muihinkin lomakkeisiin <<<<<<<<<<<<<<<<<<<<<
end;
procedure TZS_Frm.FormPaint(Sender: TObject);
begin
  inherited;
end;

//==================================================================================================
procedure TZS_Frm.FormShow(Sender: TObject);      {VAR ii,ih,uh :integer;      }begin//m++  Tämä hyvä, jos ObjInsp:ssä joskus oletAset muuttuu
  {if syoAvOn  then ChkBxAv.Checked := true    //< -+1.1.3  +Oli FALSE,  ,,oli TRUE
               else ChkBxAv.Checked := false;  //< -2.0.5}
   AvuChkSft (0);                              //< +2.0.5
   ZS_SuTimCm.Items.Clear;                     //<,,+130.0
   ZS_SuTimCm.Items.Add('5');
   ZS_SuTimCm.Items.Add('0.8');
   ZS_SuTimCm.Items.Add('0.4');
   ZS_SuTimCm.Items.Add('0.2');
   ZS_SuTimCm.Items.Add('0.1');
   ZS_SuTypCm.Hint :=    ZS_SuTypCm.Hint +fRP('²SuTypCm');     //<,,+130.1
   ZS_SuTypCm.ShowHint :=                 true;
   ZS_SuTimCm.Hint :=    ZS_SuTimCm.Hint +fRP('²SuTimCm');
   ZS_SuTimCm.ShowHint :=                 true;
   ZS_LMed.Hint :=     ZS_LMed.Hint      +fRP('²LMed');
   ZS_LMed.ShowHint :=                    true;
   ZS_TMed.Hint :=     ZS_TMed.Hint      +fRP('²TMed');
   ZS_TMed.ShowHint :=                    true;
   ZS_xMed.Hint :=     ZS_xMed.Hint      +fRP('²xMed');
   ZS_xMed.ShowHint :=                    true;
   ZS_Mm2Cm.Hint :=   ZS_Mm2Cm.Hint      +fRP('²Mm2Cm');
   ZS_Mm2Cm.ShowHint :=                   true;
   ZS_TypCm.Hint :=   ZS_TypCm.Hint      +fRP('²TypCm');
   ZS_TypCm.ShowHint :=                   true;
   ZS_LLbl.Hint :=     ZS_LLbl.Hint      +fRP('²LLbl');
   ZS_LLbl.ShowHint :=                    true;
   ZS_TLbl.Hint :=     ZS_TLbl.Hint      +fRP('²TLbl');
   ZS_TLbl.ShowHint :=                    true;
   ZS_xLbl.Hint :=     ZS_xLbl.Hint      +fRP('²xLbl');
   ZS_xLbl.ShowHint :=                    true;
   ZS_Mm2Lbl.Hint :=   ZS_Mm2Lbl.Hint    +fRP('²Mm2Lbl');
   ZS_Mm2Lbl.ShowHint :=                  true;
   ZS_LaskeLbl.Hint := ZS_LaskeLbl.Hint  +fRP('²LskLbl');
   ZS_LaskeLbl.ShowHint :=                true;
   ZS_TypLbl.Hint :=   ZS_TypLbl.Hint    +fRP('²TypLbl');
   ZS_TypLbl.ShowHint :=                  true;
   ZS_xLbl.Hint :=     ZS_xLbl.Hint      +fRP('²xLbl');
   ZS_xLbl.ShowHint :=                    true;
(* ih := 26 *(15+1); //,26......... *(...........15...........................1............)    <,,+130.2e:  Grid oli n.3pix korkeampi kuin RowJako.
   uh := ZS_StrGrid.VisibleRowCount *(ZS_StrGrid.DefaultRowHeight +ZS_StrGrid.GridLineWidth);
   if ih <> uh  then
   with ZS_StrGrid  do begin
      {VisibleRowCount := 26;  }DefaultRowHeight := 15;  GridLineWidth := 1;
      uh := ZS_StrGrid.VisibleRowCount *(ZS_StrGrid.DefaultRowHeight +ZS_StrGrid.GridLineWidth);
      ZS_StrGrid.Height := uh;
   end;*)
end;

procedure TZS_Frm.ZS_StrGridDblClick(Sender: TObject);      begin//m++
  inherited;
   DblClck := true;       //<DblClick aihauttaa näköjään MouseDwn:n. Tämä ohjaa siellä tapahtumat. Tässä myös
   syoAvOn := true;       //< +1.1.3 Vain tässä + ChkAvBxClick :ssä
   AvuChkSft (10);        //<VAIHDETAAN MUIHINKIN LOMAKKEISIIN, 10=Vapauttaa #######################
   anAvuste (ZSx,ZSy);    //<+1.1.0+
end;

procedure TZS_Frm.ZS_PanMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);      begin//m++
  inherited;
//if NOT syoAktv  then SyottoAvFrm.Hide;
   if fRePunKehi and isDebuggerPresent  then begin                                                //<,,+130.2e
      ZS_InfRv_(1,'<b>' +TControl(Sender).Name +'  ' +Ints(Pval) +'</b>'); //<Putsaa +AddText
      ZS_InfRv1.Font.Color := clRed;
   end;
   if ZS_Frm.Active  then                                                                         //<+6.0.1
   if NOT syoAktv  and  syoAvOn   then begin //< +1.1.3 +Korjattu
   //''EI Lukittu   +   Ruksi
      SyottoAvFrm.Hide;  end;                //< +1.1.3
end;

procedure TZS_Frm.FormResize(Sender: TObject);     {var i,uusTop :integer;  {s :string;      }begin
  inherited; //''Korjaa näkymää: 1) Jos Resizen jälkeen alareunaan jää vapaita rvja ja ylhäällä pii-
             //  lossa, ottaa rivejä alemmaksi.  2) Jos alhaalle jää piiloon rvja, ottaa ylöspäin.
  topAlimmanMuk;
  ZS_InfRv1.Width := ZS_Frm.ClientWidth; //<,,+130.2e .
  ZS_InfRv2.Width := ZS_Frm.ClientWidth;
  ZS_InfRv3.Width := ZS_Frm.ClientWidth;
end;

procedure TZS_Frm.ZS_Bx1_6Enter(Sender: TObject);      var i :integer;  s :string;      begin
   AvuChkSft (11);   //< +2.0.5
   SyottoAvFrm.Hide;
   if Sender is TMaskEdit
      then s := (Sender as TMaskEdit).Name
      else s := (Sender as TComboBoxXY).Name;    //<''130.1:  Eioo muita tyyppeja boxeina.
  {if Sender
   if Sender=ZS_LMed  then i := 1  else          //Valinta 4 (Ik-taulukko)    Aika[s]: -boxina.
   if Sender=ZS_TMed  then i := 2  else  i := 9; //Valinta 3 (Sulakevertailu) Aika[s]: -boxina.
   if i=9  then ;}
   if s=''  then;                                //<''Nämä vain testauksessa.

   if (Pval=2) and NOT (Aval IN [4,5])  then begin    //< +2.0.2           +10.0.1
      AddSul_Mm2Lbl_jaCm_Lft;                               //< +2.0.1  ,,,2.0.2
      for i := 0 to ZS_Frm.ZS_Mm2Cm.Items.Count -0  do
         if Pos (ZS_Mm2Cm.Text, ZS_Frm.ZS_Mm2Cm.Items.Strings[i]) >0  then begin
            ZS_Mm2Cm.ItemIndex := i;  break;  end;    //<Pakko, muuten 1.Clickillä 6 -> 630, todettu
      fSyoAktv (1);
   end;
//ZS_Mm2Cm.Text := ZS_Mm2Cm.Text;//'xxx';//fImrkt0 (Isu,1); //< +2.0.2 KOE ?????????????????????????????????????????????????????????????
end;

procedure TZS_Frm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   SyottoAvFrm.Hide;
end;

initialization
   BxtEd := '';          //<,+130.0:  Kaikien Bxien nimet+ sisältö pötkössä talteen, muutos erottuu näistä.
   BxtNyt := '';
   apuFilen := '';       //< +6.0.4
   ZSfileN := '';        //< +6.0.4
   DblClck := false;
   Gray_Chkd := false;   //< +1.1.3
   ots := 99;            //<OtsikkoNro
   R_n := 0;
   jatkaMm2 := 0;
end.
