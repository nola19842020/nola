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
unit NjTul3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, NolaForms,
  ExtCtrls, StdCtrls, ComCtrls, RichEditNola, Printers, Globals, {FileCtrl}{=KoeFileen tulost takia}
  ComboBoxXY, LabelNola, InfoDlgUnit; //<Globals, jotta rinmax+mm2NoMax

type
  TNjTulFrm = class(TFormNola)
    Panel1: TPanel;
    Suljebtn: TButton;
    TulostaBtn: TButton;
    aRich: TRichEditNola;
    Jatka: TButton;
    EtsiEdi: TComboBoxXY;
    EtsiBtn: TButton;
    VExKrtBx: TComboBoxXY;
    VExKrtLbl: TLabelNola;
    TulNoEdi: TComboBoxXY;
    LabelNola2: TLabelNola;
    bRich: TRichEditNola;
    OpenDlg1: TOpenDialog;
    procedure SuljebtnClick(Sender: TObject);
    procedure TulostaBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure JatkaClick(Sender: TObject);
    procedure EtsiEdiKeyPress(Sender: TObject; var Key: Char);
    procedure aRichMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer); //< +3.0.0
    procedure EtsiBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VExKrtBxEnter(Sender: TObject);
    procedure EtsiEdiEnter(Sender: TObject);
    procedure aRichKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure VExKrtBxExit(Sender: TObject);
    procedure TulNoEdiKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure bRichMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

TYPE Ohjaava = (OK, virhe);
const tabC=10;   d1=8;                               //<tabC=Tabuln vakiov‰lit   d1=Ohmien desim.lkm
      veAlCu=0;  veAL=1;  veCU=2;
VAR NjTulFrm: TNjTulFrm; //ssf,                      //<ssf +10.0.5 kokeiluun.
    sa,str, sisAstr,sisBstr :String;                 //<sisA =Vika voimassa oleva SYMBOLIN j‰lkeinen
                                                     //'sisennyskohta, pvittyy PRC tabSis :ss‰
    ChkStr :string; //<ChkStr TulVE:n j‰lkeisen sisennyksen selvitykseen tms. ks. NjTul31.INC alussa
    aa,rr,ar,a8,r8,a7,r7,a3,  Rs,Xs,Zs,Ls,  Rv,Rn,Xv,Xo,Xn  :Real;
    {i,ct :Integer;}
    {tim :Real;   kul,onD1 :Boolean;}
    {Nsul :Integer;  }Ik1v,Ik3v,{Ikat_Zs,}rinKer :Real;
    {Qast,}
    Qtyp :string;   QUn,Qkpl,Qlampot :Integer;   Qmm2,Qpit,Qkorj, Qtim,QcU :Real;
    {viel‰ v‰liaik.=}sel, Qkul,Qpt, Qiec    :boolean;
    Btyp :string;   Bkpl,Blampot :Integer;   Bmm2,Bpit  :Real;

  LedvUh,Pedv,                 //< +6.0.0 NJlaskennan Ph+LekvUh siirt‰miseksi edv :n tietoihin.
  uh, dPhuh,dPhsuh, uhv :Real; //<uhv =uh vanhan kaavan mukaan CTRLFIL.  LekvUh=EkvivL edvssa, jolla Uh=sama
  tux         :integer ;       //<Tulostuskertalaskuri 0..VExKrt         ''''''+6.0.0
  ALve1,CUve1 :integer;        //<Ekat tulostetut TUXV :t ao. materiaalilla. Tarvit hintavrt:ssa
  tultau      :ARRAY [1..3, 0..mm2NoMax, 0..rinmax]  OF Integer;
                      // Tulostetut mm2 muistiin NJLAJI'ttain(1=AL  2=CU  3=SVj), lkm‰‰ritt‰in
                      // 1..3,0,1..rinmax  on varattu minimipoikkipinnalle<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                      // 1..3,0,0          on varattu etsitynJ‰rjNo:lle /Nola38.INC/PRC etsiKaap: EiK‰ytˆss‰ <<<<
  ekaZSiso,alpZSiso,ZSiso{-@ZIiso}{,-@ZK1iso},
  ekaIkKasvattiMm2,alpIkKasvattiMm2,IkKasvattiMm2, KatMgAli{-@ZK2iso},KatZSali :boolean;
  IkKasvattiMm2Str :string;
  NJveAC           :integer;          //< +6.1.1   0 = Al+Cu   1 = Al   2 = Cu
//mrk1,mrk2 :real;                    //'alpx,tuxV yms. vois olla myˆs t‰‰ll‰ ??????????????????????

  PROCEDURE EditNJ;
  //,,,,,,,,,,,,,,,,,,,,,,,,,Nola38.INC,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  PROCEDURE etsiKaap (uhkin :Boolean;   VAR pal :ohjaava);
  PROCEDURE etsiSulTapa (VAR pal :ohjaava);
  PROCEDURE ohjaaEditNj;
  PROCEDURE ketjuarvot;
  //,,,,,,,,,,,,,,,,,,,,,,,,,NjTul30.INC,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  FUNCTION fTuh :Integer;    //<Palauttaa JOHDINLT:n uh%- ja haviokusLaskentaan
  PROCEDURE tulostaKesk;
  //,,,,,,,,,,,,,,,,,,,,,,,,,NjTul31.INC,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  PROCEDURE tulostaNousu;
//FUNCTION fKi :Real;        //<NjLas37.INC

  PROCEDURE LueLaskeKatuval; //<KatuvalF.INC +7.0.3

  function fBtnAL :boolean;
  function fBtnCU :boolean;
  function fBtnAC :boolean;

implementation

uses Defs, Unit0, Unit1, Y_, {Herja1, EdvNew, }PrintDialogNola, {Odota, }Progres,
     NjVrk, Settings, TextBase, LaskeeOd, DetEv{SyottoAv{LaskeNj koetul.takia}, PaaVal{IsDebuggerPresent},
     licenseFuncs{KatuvalF.INC/LicenseScope};
{$I '..\EdvNj\NjTul3Y.INC'}
{$I '..\EdvNj\NjLas37.INC'}
{$I '..\EdvNj\NjLas38.INC'}
{$I '..\EdvNj\NjTul30.INC'}
{$I '..\EdvNj\NjTul31.INC'}

{$R *.DFM}

function fBtnAL :boolean;    begin  Result := false;   if NjFrm.AlBtn.Checked    then Result := true;   end;
function fBtnCU :boolean;    begin  Result := false;   if NjFrm.CuBtn.Checked    then Result := true;   end;
function fBtnAC :boolean;    begin  Result := false;   if NjFrm.AlCuBtn.Checked  then Result := true;   end;

//,=procedure TEdvNewFrm.DetaljitBtnClick(Sender: TObject);      begin
PROCEDURE EditNJ;      BEGIN
   NjFrm.OkBtn.Enabled := false;
   OhjTul_eritNj;                //<NjTul3Y.INC=====================================================
   NjFrm.OkBtn.Enabled := true; 
end;

function VExKrt_OK :boolean;      VAR ai :integer;      begin //< +3.0.0
   with NjTulFrm  do
   if SokI (VExKrtBx.Text,ai)  and (ai>0) and (ai<=20)
      then begin result := true;
                 VExKrt := ai;  end
      else begin result := false;
                 VExKrtBx.SetFocus;  end;
end;

procedure TNjTulFrm.SuljebtnClick(Sender: TObject);      begin
   ChkStr := '';
   Close;
end;
procedure TNjTulFrm.FormClose(Sender: TObject; var Action: TCloseAction);      begin
   TulNoEdi.Text := '';
   bRich.Visible := false;

{  aRich.Clear;                              //<+1.0.9
   aRich.Text := '';                         //<+1.0.9
   sisAstr := '';   sisBstr := '';           //<+1.0.9
   str := '';                                //<+1.0.9 T‰h‰n tuloste, t‰st‰ aRichiin Nola3x.INC :ss‰
   aRich.Update;                             //<+1.0.9}
   NjTulAuki := false;
end;

procedure TNjTulFrm.TulostaBtnClick(Sender: TObject);      LABEL 6{+7.0.3};
                                                           VAR s :string;  ve,val,TxtPituus :integer;
                                                                                               //,,,+6.2.2
   function TulValittu :integer;     CONST VeStr='VAIHTOEHTO N:o ';      VAR os1,os2,os3 :integer;   aos :string;
   begin
     //bRich.Assign(aRich);     //<Error. On asetettava k‰sin,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
       bRich.Align := alClient;
                   {bRich.Height := 500;   bRich.Width := aRich.Width -55;
                    bRich.Top :=    200;   bRich.Left :=  50;              //<''Kokeiluun}
      {bRich.AddText (aRich.Lines[i]);                                     //<,,Kokeilua, ei OK.
       bRich.AddText ('1  ' +aRich.Lines[2]);
       bRich.AddText ('4  ' +aRich.Lines.Strings[5]);//''''''''''''''''''''Lihavointi, v‰rit ym. j‰‰ vex.}

       Result := 11;
       AOS := VeStr +IntToStr(ve);                                         //,Eka tulostusosa = YleisTiedot
       TxtPituus := Length (aRich.Text);
          aRich.SelStart :=  0;               //<,Jos tulostettu jo jokin osa (alue tms.), j‰‰ cursori muuten
          aRich.SelLength := 0;               //  v‰‰r‰‰n kohtaan.
       os1 := aRich.FindText(VeStr, 0,Length(aRich.Text), [{stWholeWord{,stMatchCase}]); //<Yleistieto-osan LOPPU.

       os2 := -1;
       if os1<>-1  then                       //,,Etsit‰‰n valittu tulostusVE    =ALOITUSKOHTA......
        //os2 := aRich.FindText(AOS,                   os1+10,TxtPituus, [{stWholeWord{,stMatchCase}]); //< -8.0.4
          os2 := aRich.FindText(AOS,                      0,TxtPituus, [{stWholeWord{,stMatchCase}]);
       os3 := -1;                                          //'Tarkemmin:  Length() -os1-10..........
       if os2<>-1  then                       //,,Etsit‰‰n tulostusVE:t‰ seur.VE = LOPETUSKOHTA.....
          os3 := aRich.FindText(VeStr +IntToStr(ve+1), os2+10,TxtPituus, [{stWholeWord{,stMatchCase}]);
                                              //+10 jottei ''' "lˆyt‰isi" samaa.....................
       if (os3=-1) and (Length (aRich.Text) >0) //<,,Jos oli vika ve, ei seur. ve:t‰ olekaan tai jos se on
          then os3 := Length (aRich.Text);      //   delattu, otetaan tekstin pituus.

       if (os1<>-1) and (os2<>-1) and (os3<>-1)
       then begin
          aRich.SelStart :=  0;          //<,,Leikataan ja kopioidaan leikepˆyd‰lle/-lt‰ YLEISosa
          aRich.SelLength := os1-1;
          aRich.CopyToClipboard;
          bRich.PasteFromClipboard;

          aRich.SelStart :=  os2;        //<,,Leikataan ja kopioidaan leikepˆyd‰lle/-lt‰ VALITTU VE.
          aRich.SelLength := os3-os2-1;  //< -1 =Vikaksi lˆytyneen edelliseen mrkiin.
          aRich.CopyToClipboard;

          bRich.PasteFromClipboard;      //<,,,Siirretty ELSEn j‰ljest‰ t‰h‰n (j‰i blankoksi, josEiLˆytynyt) 8.0.4
          bRich.Visible := true;         //< MouseDown sulkee.
          bRich.SelStart :=  0;          //< Cursori/focus alkuun
          bRich.SelLength := 0;          //<JosKommentoi vex ja NOT ENABLED, PƒIVITTYMINEN NƒKYY TOSIAIKSTI, hidas
          bRich.Width := aRich.Width -1; //<,,Muutetaan tulfrmn kokoa hetkellisesti, jolloin sisennyk-
          bRich.Width := aRich.Width +1; //   set p‰ivittyv‰t oikein. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        //bRich.Enabled := true;         //<-6.0.3:  Ei en‰‰ tarvetta, ks. ylempn‰, enab := FA otettu vex.
        //bRich.Perform (EM_SCROLL,SB_LINEDOWN,0); //<Editorin scroll/1xAlas
          bRich.Update;
          bRich.SetFocus;
          Screen.Cursor := crDefault;
       end
       else begin
          InfoDlg ('Tulostettavaa osuutta ei lˆytynyt "' +AOS +'"', mtCustom,
                 'OK','','','',  '','','','');
          Result := 2;
       end;
   end;//TulValittu

   function TulAlue :integer;      begin //<,,+7.0.4
       bRich.Align := alClient;
       Result := 22;

       aRich.CopyToClipboard;            //<Kopioidaan jo valmiiksi maalattu tekstiosa leikepˆyd‰lle
       bRich.PasteFromClipboard;         //... ja sielt‰ bRich¥iin.

       bRich.Visible := true;            //< MouseDown sulkee.
      {bRich.SelStart :=  0;             //< Cursori/focus alkuun
       bRich.SelLength := 0;             //<JosKommentoi vex ja NOT ENABLED, PƒIVITTYMINEN NƒKYY TOSIAIKSTI, hidas
       bRich.Width := aRich.Width -1;    //<,,Muutetaan tulfrmn kokoa hetkellisesti, jolloin sisennyk-
                                         //   set p‰ivittyv‰t oikein. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! }
       bRich.Width := aRich.Width +1;
     //bRich.Enabled := true;            //<-6.0.3:  Ei en‰‰ tarvetta, ks. ylempn‰, enab := FA otettu vex.
     //bRich.Perform (EM_SCROLL,SB_LINEDOWN,0); //<Editorin scroll/1xAlas
       bRich.Update;
       bRich.SetFocus;

       Screen.Cursor := crDefault;
   end;//TulAlue

begin//TulostaBtnClick,,,,,,,,,,,,,,,,,,,,,,,,
//if IsDebuggerPresent  then NjTulFrm.Hide; //<+7.0.4 Debuggauksen: jotta lomake h‰vi‰isi p‰‰lt‰ ja breakpoint rivi n‰kyisi.

   NjTulFrm.TulostaBtn.Enabled := False;
   Screen.Cursor := crHourGlass;             //<Ilman SCREENi‰ vipattaa!!!
   bRich.Lines.Clear;

   s := Trim (TulNoEdi.Text);                //<,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,+6.2.2
   val := 0;
   if Katuval  then GOTO 6;

   if (NjTulFrm.aRich.SelStart>0) and (NjTulFrm.aRich.SelLength>0)  then begin//<,,+7.0.4
      val := InfoDlg ('Tulostetaanko vain valittu tekstiosa?',  mtCustom,
                      'Valittu',             //< 1  => 22
                      'Peru','','',          //< 2. Jos suljetaan X :ll‰ => val := 9;

                      'Tulostetaan vain valittu tekstiosa',
                      'Palataan edelt‰v‰‰n tilanteeseen','','');
      if val=1  then val := 22
                else val := 2;  end;

   if (s<>'') and NOT (val IN [9,22])  then
   if NOT SokI (s, ve)
   then begin
        InfoDlg ('Tulostettavan vaihtoehdon N:o virheellinen!',  mtError,
                 'OK','','','', '','','','');
      val := 2;  end
   else begin
      if (ve>tuxV) or (ve<=0)
      then begin
           InfoDlg ('Tulostettava vaihtoehto N:o ' +IntToStr(ve) +' virheellinen',  mtError,
                    'OK','','','',  '','','','');
           val := 2;  end
      else begin
         val := InfoDlg ('Tulostettava vaihtoehto N:o ' +IntToStr(ve),  mtCustom,
                     'TulostN:o ' +IntToStr(ve),   //< := 11
                     'Tulosta',                    //< := 12
                     'Peru','',                    //< := 13,  val := 1, 2 tai 3 +10

                     'Tulosta N:o ' +IntToStr(ve), //< 11
                     'Tulosta KAIKKI',             //< 12
                     'Peru','') +10;               //< 13      <HUOM:  val := IngoDlg() +10 !!!!!!!!
         if val IN [13,19]  then val := 2;         //' 9 => 19 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      end;             //,########################################################################################
   end; //''''''''''''''''22=Tulost vain valittu osa   2=Peru   11=Tulosta ve N:o   12=Tulost KAIKKI''''''''''''''
   if val=11           //'########################################################################################
   then val := TulValittu           //<Jos ei lˆydy VE:ta, palauttaa 2.
   else if val=0                    //<,Jos ei oltu k‰yty miss‰‰n kyselyss‰ (ehk‰ turha), tulost. KAIKKI =12.
   then val := 12;

   TulNoEdi.Text := '';             //,Jos InfoDlg suljettu X :st‰, palautti arvon 9.###############
6:                                  //<+7.0.3             +7.0.4 =MAALATUN [22] tulostus
   if val IN [11,12,22]  then begin //<Jokin tulostus:  Kaikki ve:t (12=aRich) tai haluttu ve (11,22=bRich).
{Kokeilun ajaksi ota vex.,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,KOE}
      IF PrintDlgNola.Execute(modeA2, self)  then begin  //DEVELOPER2 6.12.1998
        try
          if (val=12) or Katuval                 //<,Valittu kaikkien vaihtoehtojen tulostus. Katuval +7.0.3
          then begin
             aRich.PageRect := Rect (200,0, Printer.PageWidth,Printer.PageHeight);   //=2326,3389 =oaX,Y
             aRich.Print('');  end               //Z_A2Frm.Print; = Print;  =Tulostaa VAIN FORMin=POHJAN
          else begin //11,22                     // 11 =Valittu m‰‰r‰tyn vaihtoehdon tulostus.
             if val=22                           // 22 =MAALATUN alueen tulostus.
                then TulAlue;                    //<+8.0.4
             bRich.PageRect := Rect (200,0, Printer.PageWidth,Printer.PageHeight);   //=2326,3389 =oaX,Y
             bRich.Print('');                    //Z_A2Frm.Print; = Print;  =Tulostaa VAIN FORMin=POHJAN
             bRich.Visible := false;  end;       //<+8.0.4
        finally
          Screen.Cursor := crDefault;
        end;
      end;//Kokeilun ajaksi vex}
   end;
   aRich.SelLength := 0;
   Screen.Cursor := crDefault;
   TulostaBtn.Enabled := True;
   ChkStr := '';
end;//TulostaBtnClick

procedure TNjTulFrm.TulNoEdiKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState); //+6.2.2
      VAR ve :integer;  s :string;      begin
   inherited;
//if IsDebuggerPresent  then NjTulFrm.Hide; //<+7.0.4 Debuggauksen: jotta lomake h‰vi‰isi p‰‰lt‰ ja breakpoint rivi n‰kyisi.
   s := Trim (TulNoEdi.Text);               //'Ei SAA JƒTTƒƒ PƒƒLLE =KOMMENTOITAVA VEX. Muuten lomake h‰vi‰‰ n‰kyvist‰.
   if (s<>'') and SokI (s, ve)  and (Key=13)  then //< s<>'' +7.0.4
      TulostaBtnClick(Sender);
end;


procedure TNjTulFrm.JatkaClick(Sender: TObject);      VAR s :string;  alp :integer;      begin
   if  NOT NJlaji  and (NJkaapx=rinmax)  and (NJmm2=240)     //<Tarvitaankohan t‰ss‰kin, vrt. 38.inc
   then begin
      Y_piipit (10);
      s := '20 x 300 Cu ylittyi';
      IF (tux<VExKrt)  AND  (tuxV<VExKrt)   THEN s := s +'.   Onko ed.verkko liian kevyt?';
      EiOKinfo (s);   END
   else if  VExKrt_OK                           //<Asettaa VExKrt
   then begin
      Screen.Cursor := crHourGlass;             //<Ilman SCREENi‰ vipattaa!!!
    //aRich.Enabled := false;                   //<EKA RIVI SISENEE PALJON, mutta ei muuta konstia !!!???!!!???!!
      alp := Length (aRich.Text);               //'-6.0.3:  Err: Can't focus invis. or unenabled... +k‰‰nsi harmaaksi
    //alp := aRich.SelLength;
      aRich.SelStart := alp; //Length (aRich.Text);
      aRich.SelLength := 0;             //<JosKommentoi vex ja NOT ENABLED, PƒIVITTYMINEN NƒKYY TOSIAIKSTI, hidas
         aRich.Width := aRich.Width -1; //<,,Muutetaan tulfrmn kokoa hetkellisesti, jolloin sisennyk-
                                        //   set p‰ivittyv‰t oikein. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      //aRich.SetFocus; //<+6.0.2
      ohjaaEditNj;
         aRich.Width := aRich.Width +1;
    //aRich.Invalidate;                 //<... + Update. Ei vaikutusta
    //alp := Length (aRich.Text);
      aRich.SelStart := {Length (aRich.Text); }alp;
    //aRich.SelStart := Length (aRich.Lines.Text); //alp;
    //aRich.SelLength := 0;             //<Ei vaikutusta
    //aRich.Enabled := true;            //<-6.0.3:  Ei en‰‰ tarvetta, ks. ylempn‰, enab := FA otettu vex.
      Screen.Cursor := crDefault;
//      aRich.Perform (EM_SCROLL,SB_LINEDOWN,0); //<Editorin scroll/1xAlas
      aRich.SetFocus;
    //NjTulFrm.aRich.Lines.SaveToFile('C:\Projektit\RichNola.rtf');
   end;

{     a := NjTulFrm.Height;
      NjTulFrm.Height := a-50;
      aRich.SelStart := Length (aRich.Text);
      aRich.SelLength := 0;            //<Jos kommentoi vex ja NOT ENABLED, PƒIVITTYMINEN NƒKYY TOSIAIKSTI, hidas
      aRich.AddText ('<br>');          //<Scrollataan jatkon alkukohta n‰kyviin = POISTAA PAHAN SIENNYKSEN !!!!!!
      aRich.Enabled := false;
         EiOkInfo ('Ruutukoko?');
      NjTulFrm.Height := a;            //<..ja suurennetaan lomake takas, jotta uudet lis‰rivit alkavat n‰kyvOsalla
      NjTulFrm.UpDate;                 //<Muuten buttonit j‰‰v‰t aukoiksi.
         ohjaaEditNj;
      aRich.Enabled := true;
      Screen.Cursor := crDefault;
   end;}

(*  //aRich.Enabled := false;
      a := Length (aRich.Text);
      aRich.SelStart := a;                      //<Vied‰‰n cursori textin loppuun
    // aRich.SelLength := 0;                     //,,Lis‰t‰‰n rivej‰, jotta Texti Scrollaisi, jolloin ei VIRHESISEN.
    //aRich.SetSelStart (a);
    //aRich.SetSelLength (0);
         s := 'a='+fImrkt0 (a,1);
         EiOkInfo ('Ollaanko lopussa?' +s);
         aRich.AddText ('1. poistettava lis‰rivi ' +fImrkt0 (Length (aRich.Text),1) +'<br>');
         aRich.AddText ('2. poistettava lis‰rivi ' +fImrkt0 (Length (aRich.Text),1) +'<br>');
         aRich.AddText ('3. poistettava lis‰rivi ' +fImrkt0 (Length (aRich.Text),1) +'<br>');
     {aRich.SelStart := 1;                      //<Vied‰‰n cursori koko Textin alkuu
         EiOkInfo ('Ollaanko alussa?' +s);}

      aRich.SelStart := a;                      //<Vied‰‰n cursori alkuper‰iseen "loppuun" ja poistetaan lis‰rivit
    //aRich.Update;
      aRich.AddText ('£');
         EiOkInfo ('Ollaanko lopussa? £');

    //aRich.SelStart := a;                      //<Vied‰‰n cursori alkuper‰iseen "loppuun" ja poistetaan lis‰rivit
    //aRich.SelStart := a-1000;                      //<Vied‰‰n cursori alkuper‰iseen "loppuun" ja poistetaan lis‰rivit
      aRich.SelStart := 40000;                       //<Vied‰‰n cursori alkuper‰iseen "loppuun" ja poistetaan lis‰rivit
      aRich.SelLength := 1000;
    //aRich.Update;
      aRich.AddText ('@');
         u := Length (aRich.Text);
         s := s +'  u='+fImrkt0 (u,1);
         EiOkInfo ('Ollaanko vanhassa lopussa? @ ' +s);
    //aRich.SelLength := u-a +1;
      aRich.SelLength := 1000;
      aRich.AddText ('#');
         EiOkInfo ('Onko lis‰rivit valittuna? # ' +s);
      aRich.ClearSelection;                     //<Poistetaan lis‰rivit
         EiOkInfo ('Rullasiko Texti ylˆs lis‰riveill‰? poistuivatko rivit' +s);
     {aRich.ScrollBy (0,-50);
      aRich.Update;
         EiOkInfo ('Rullasiko Texti ylˆs -50' +s); //}

         //ohjaaEditNj;
      aRich.Enabled := true;
      Screen.Cursor := crDefault;
   end; //}*)

{     v := Length (aRich.Text);
      aRich.SelStart := v;                      //<Vied‰‰n cursori textin loppuun
      aRich.SelLength := 0;
      aRich.ScrollBy (0,-50);                   //<Scrollataan teksti‰, -xx = ylˆs pixelein‰
      aRich.Enabled := false;

         //ohjaaEditNj;
      aRich.Enabled := true;
      Screen.Cursor := crDefault;
   end;}
end;

procedure TNjTulFrm.EtsiEdiKeyPress(Sender: TObject; var Key: Char);      begin
  inherited;
  if Ord(key)=13  then etsiStr (NjTulFrm.aRich,  NjTulFrm.EtsiEdi);
end;

procedure TNjTulFrm.aRichKeyDown(Sender: TObject;  var Key: Word;  Shift: TShiftState);      VAR KeyC :Char;  begin
   inherited;
   if (ssCtrl IN Shift) and (Key IN [80,112]) //<,,+7.0.3  Tulostus ^C + P
   then TulostaBtnClick(Sender)
   else if Key=114{F3}                       //<,,+6.0.3
   then begin
      KeyC := #13{Enter};
      EtsiEdiKeyPress(Sender,KeyC);  end
   else if (Key=70{f}) and (ssCtrl IN Shift)
   then EtsiEdi.SetFocus                     //<''+6.0.3
   else if Shift = [ssShift,ssAlt]
   then begin
        if (Key=46) and (aRich.SelLength>0)  then begin
           aRich.ReadOnly := false;
           aRich.ClearSelection;
           aRich.ReadOnly := true;  end; end
   else if (Shift = [ssCtrl]) and (Key IN [Ord('z'),Ord('Z')]) //<Toimii OK, mutta ei palauta Undo¥lla
   then aRich.Undo;
end;

procedure TNjTulFrm.EtsiBtnClick(Sender: TObject);      begin
  inherited;
  etsiStr (NjTulFrm.aRich,  NjTulFrm.EtsiEdi);
end;

procedure TNjTulFrm.aRichMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);      begin //< +3.0.0
  inherited;
 //SetFocus; //< -6.1.1
end;

procedure TNjTulFrm.VExKrtBxEnter(Sender: TObject);      begin
  inherited;
   with VExKrtBx.Items  do begin //< +3.0.0
      Clear;
      if VExKrt>1  then            //<,,+6.1.1 Ettei samat '1' per‰kk‰in.
         Add (fImrkt0 (VExKrt,1));
      Add ('1');                   //<,,+6.1.1
      Add ('2');
      Add ('3');
      Add ('4');
      Add ('5');
      Add ('6');
      Add ('8');
      Add ('10');
      Add ('12');
      Add ('14');
      Add ('20');
      VExKrtBx.DropDownCount := 30; //< +4.0.0
   end;
   VExKrtBx.ItemIndex := 0; //<Eka ve n‰kyviin boxiin
end;

procedure TNjTulFrm.EtsiEdiEnter(Sender: TObject);      begin
  inherited;
   LaskeeOdFrm.Close;             //< +3.0.3
   with EtsiEdi.Items  do begin
      Clear;
      Add ('vaihtoehto');
      Add ('	amcmk');
      Add ('	axmk');
      Add ('	mcmk');
      Add ('SVj');
      Add ('ik1v');
      Add ('ik3v');
      Add ('pistorasia');
      Add ('kiint.laitt');
    //Add ('0.4s');               //< -2.0.5
      Add (fPoiskAikaRajaS +'s'); //< +2.0.5
      Add ('5s');
      Add ('2,5');
      Add ('1,5');
      Add ('max');
      Add ('sulak');
      Add ('pot');
      Add ('k‰sinlask');
      Add ('oikos');
      Add ('yliv');
      Add ('vikav');
      EtsiEdi.DropDownCount := 30; //< +4.0.0
   end;
 //EtsiEdi.Text := ;
   EtsiEdi.ItemIndex := 0; //<Eka ve n‰kyviin boxiin
end;
procedure TNjTulFrm.FormShow(Sender: TObject);      begin
  inherited;
  if KatuVal  then Caption := PROGRAM_VERSIO_STRING +':  Katuvalojohtojen laskenta'      //+7.0.3  10.0.4
              else Caption := PROGRAM_VERSIO_STRING +':  P‰‰- / Nousujohtojen laskenta'; //+6.2.10
   TulNoEdi.Text := '';
   bRich.Visible := false;

   VExKrtBx.Text := fImrkt0 (VExKrt,1);
   EtsiEdi.Text := 'vaihtoehto';
end;

procedure TNjTulFrm.VExKrtBxExit(Sender: TObject);      VAR i :integer;      begin //<,,+6.1.1
  inherited;
   if SokI (VExKrtBx.Text,i)  then
      VExKrt := i;
   NjFrm.Bx9.Text := fImrkt0 (VExKrt,1);
end;

procedure TNjTulFrm.bRichMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
begin
   inherited;
   bRich.Visible := false;
end;


initialization
   ALve1 := 0;  CUve1 := 0;
end.

