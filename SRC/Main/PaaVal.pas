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

unit PaaVal;  //Projektitiedot, ks. esim. NotePad'illa: Nola.dpr

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs,
  StdCtrls, ExtCtrls, Printers, {DEVELOPER1+}inifiles, license, {DEVELOPER1+}LicenseFuncs, Forms, NolaForms,

  { Omat unitit }
  Globals,    { Globaalit määritykset }
  Settings,   { Asetusolio }
  TextBase,   { Tekstivarasto }
  Defs, PanelNola, LabelNola,        { Yleiset asetukset }
  Progres, ComCtrls, RichEditNola, InfoDlgUnit{,}{+6.2.2 koe}
  {FileCtrl}{FileEv.INC 6.2.2} ,ShellApi, System.UITypes;

type
  TPaaValFrm = class(TFormNola)
    PaaValRaa: TGroupBox;
    SulakeLab: TLabel;
    NjLaskentaNap: TButton;
    NjLaskentaLab: TLabel;
    LopetaNap: TButton;
    MoottoriNap: TButton;
    MoottoriLab: TLabel;
    ImpedNap: TButton;
    ImpedLab: TLabel;
    CopyrPanY: TPanel;
    CopyrPanA: TPanel;
    Copyr1Lab: TLabel;
    Copyr2Lab: TLabel;
    LbTilausInfo: TLabel;
    InfoNap: TButton;
    NolaLogo: TLabel;
    SulakeNap: TButton;
    PrinterSetupDialog1: TPrinterSetupDialog;
    AsetNap: TButton;
    Timer1: TTimer;
    Timer2: TTimer;
    VerLbl: TLabel;
    OdotaLbl: TLabel;
    Timer3: TTimer;
    DesignInfoLabel: TLabelNola;
    LaajuusLbl: TLabelNola;
    KatuvBtn: TButton;
    KatuvLbl: TLabel;
    KaykR1: TLabelNola;
    KayOikR2: TLabelNola;
    KayOikR2e: TRichEditNola;
    OpenDlg: TOpenDialog;
    OhjLbl: TLabel;
    ZkoeMem1: TMemo;
    ZkoeMem2: TMemo;
    procedure NjLaskentaNapClick(Sender: TObject);
    procedure MoottoriNapClick(Sender: TObject);
    procedure ImpedNapClick(Sender: TObject);
    procedure SulakeNapClick(Sender: TObject);
    procedure LopetaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SulakeLabClick(Sender: TObject);
    procedure KatuvBtnClick(Sender: TObject);
    procedure VerLblMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
    procedure InfoNapMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
    procedure AsetNapMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
    procedure AsetNapMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure NjLaskentaNapMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
  private
  //TrayIconData: TNotifyIconData; //<Ico:  http://delphi.about.com/library/code/ncaa121801a.htm, tässä + jälempnä VAIN alkuosa, TARYn poisto vielä puuttuu.
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetTexts; override;
  protected                                                      //<,12.0.8i:  Iconi näkyviin taskbarissa.
    procedure CreateParams(var Params: TCreateParams); override;
  end;

{-I- '..\Globals\NolaTyp.INC'}                            //<¤DEVELOPER1 -> Siirretty Globalsiin
var   PaaValFrm: TPaaValFrm;                            //' rivH =ikkunan korkeus pixeleinä
      Pval,Sval,Zval :integer;      //<Välittää tiedon valinnoista ZS_:ään. := ao. BtnClick
      SyoKut :integer;              //'Sval=ao.sulValFrm:n toimintavalitsin. syoKut=SyottoFmnKutsuOs <¤DEVELOPER1
      syoAktv :boolean;             //<Ohjaa avusteen vaihtumattomaksi, kun OnENTER ComboBox
      syoAvOn :boolean;             //<+1.1.3 =Pitää tiedon siitä, onko ChkBxAv valittu vai ei #############
      apuaOn  :boolean;             //<+1.1.3 =Pitää tiedon siitä, onko apuaBtn :lla pyydetty ao.avuste ####
      AvCloseOK :boolean;           //<FA=Estää ChkBxAv :n eventissä SyottoAv.Close ########################
    //function typOK(MUUNT :integer;  var Tstr :Text) :boolean;  //<¤DEVELOPER1
      oliW,oliH,oliLf,oliTp :longint;
      EdvJoOllut,MoJoOllut :boolean;
      HerjaY_S :string;             //<HerjaY_S +10.0.5

      procedure Tics (si :string);  //<Aikaväli eri ajokohtien välillä
      function typOK(MUUNT :integer;  var Tstr :String) :boolean;  //<¤DEVELOPER1
      function EdvVeja :boolean;
      function eriEdv :boolean;
      function eri_cU_Un :boolean;
      function NjVeja :boolean; //< TR jos NjF,Nj0, tai NjU <>Nj
      function eriNj  :boolean; //< TR jos NjF<>Nj
      function eriNj0 :boolean; //< TR jos Nj0<>Nj
      function eriNjU :boolean; //< TR jos NjU<>Nj
      function MoVeja :boolean;
      function eriMo  :boolean; //< TR jos moF<>mo
      function eriMo0 :boolean; //< TR jos mo0<>mo
      function eriMoU :boolean; //< TR jos moU<>mo

      procedure OhjeEfect_ON;
      procedure OhjeEfect_OFF;
      procedure OhjeEfect2_ON;               //<Lukitsee YLEISinfon 5:ksi sekunniksi (Interval=5000)
      function LueTalEdvFile (LUE,KYSY :boolean;  inFilen :string) :boolean; //<FileEv.INC
    //procedure NayMemory;
    //Function IsDebuggerPresent :Boolean; StdCall;                          //<Siirrtty Defs.PAS´siin 11.0.1 .
      procedure ChkLaajuusLbl;
      procedure SijLicEiPvitList;   //<+10.0.2  Siirretty Y_. / FNC OnPvitysEstoListassa
    //function fApplicName :string; //<+12.0.0:  10.INC´ssä ei onannut Application.ExeName.
      procedure PrRj_SulMm2 (Inx,Palsta :integer;  VAR Sul,Mm2 :integer); //130.0: Palauttaa Index´in mukaisia arvoja:  1...=Vasen palsta (ennen "/")  2...=Oikea palsta ("/" jälkeen).

VAR alustettu :boolean; //<+8.0.0: Tarvittu myös EdvNew´ssa
//YLst :TStringList;      //<+1412:  Ei onannut NolaVar´ssa ja Create PaaVal.PAS´ssa.

{I '..\Globals\NolaVar.INC'}                           //<¤DEVELOPER1. DEVELOPER2 siirsi Globals.PASsiin 12.12.97
implementation    //'Pval := myös Z_laske/S_laske, Sval := S-val:ssa +S_laske
                  //'koska jos peräkkäin valitaan Z-valikko + S-valikko ja esim. Sval=1 + Nx S_laskeBtn
                  //'ja aktivoidaan Z-valikko, josta valitaan joku toiminta, kuvittelee ZS_frm, että
                  //'ollaan edelleen Sval=1 -toiminnassa
uses Y_, Herja1, Z_PaaVal, S_PaaVal, NjVrk, EdvNew, EdvNewLask, {Odota, }Asetus, {Od }AlkuOdot, SyottoAv,Syotto{kokeilu},
    {ShareMem,{=Deleten poiskommentoinnin vaikutuksen seurantaan, ks. GetHeapStatus.TotalFree lopussa}
    {,Unit1{ZpeOK kokeiluun} Moot, textBaseTexts, ZS_{,  MoDet{AvuChk kokeiluun +1.1.3},
    LaskeeOd, NjTul3{Kokeiluun +NjTulFrm.Top :=... jne.}, Korj{KorjFrm -kokeiluun}, DateUtils{141.1},
    Unit0{TeeKtlk}, KoePaa{KoePaaFrm.Show:  Ks. PaaValFrm.FormShow}, Koe{Tics-ajojen tulost}, DetEv;
                                                                    //''PutsCells takia <<<<<<<<<<<<
{$R *.DFM}

var iii :integer;
    Tics0 :TDateTime;  TicsY :Integer{Double};

{$I '..\EdvNj\EdvNjAs.INC'}                               //<¤DEVELOPER1
{$I '..\EdvNj\FileEv.INC'}                                //<¤DEVELOPER1
{$I '..\EdvNj\KaapHin.INC'}                               //<¤DEVELOPER1  =LueKahiFile / KaapHinD.NOL<<<<<<<<<<<<<<<<<<

{procedure LoadResourceFile(aFileN :string; ms :TMemoryStream); //<,,,,,,,,,,,,,,,,,,,,,,+12å8=12.0.0 Workki OK mutta
var                  //Ks. E:\Projektit_YLE =====\Delphi-Vihjeet\Resources\Resources.RTF             ks.TextBaseText..
   HResInfo :HRSRC;
   HGlobal  :THandle;
   Buffer,GoodType :PChar;
   I   :integer;
   Ext :string;
begin
  Ext:= UpperCase(ExtractFileExt(aFileN));
  Ext:= Copy (Ext,2,Length(Ext));
  if Ext='HTM' then Ext:='HTML';                        //<Ei liene tarvetta, olkoon.
  Goodtype := PChar(Ext);
  aFileN := ChangeFileExt(aFileN,'');
  HResInfo := FindResource(HInstance, PChar(aFileN), GoodType);
  HGlobal := LoadResource(HInstance, HResInfo);
  if HGlobal = 0 then
     raise EResNotFound.Create('Can''t load resource: '+aFileN);
  Buffer := LockResource(HGlobal);
  ms.clear;
  ms.WriteBuffer(Buffer[0], SizeOfResource(HInstance, HResInfo));
  ms.Seek(0,0);
  UnlockResource(HGlobal);
  FreeResource(HGlobal);
end;
procedure LoadStringResource (RichE :TRichEditNola;  FN :String);      VAR ms :TMemoryStream;      begin
  //List := TStringList.Create;
  LoadResourceFile(FN,ms);
  //Memo1.Lines.LoadFromStream(ms);
  RichE.Lines.LoadFromStream(ms);
end;                                                           //<''''''''''''''''''''''+12å8=12.0.0 }
//function fApplicName :string;      begin //,Pelkkä polku ilman filenimeä 12.0.0
//   result := ExtractFilePath ({Vcl.Forms.}Application.ExeName);  end;

procedure Bep;   begin end; //if IsDebuggerPresent  then Beep;  end; //<12.0.0:  Tässä hyvä debugata, mistä piippauspyyntö tulee
procedure MuokFileTextBaseen (aoFN :string);      VAR aoF{,TmpF} :TextFile;       begin
                                       //¿DefsFileenZ('AssgnFile 16');
                                       YFileen('¿AssignF 16');
   AssignFile (aoF,aoFN);
end;

(*procedure ChkTestiAjo;      begin//+8.0.8
      //,Nyt herjaa aina jos vain TestiAjo=TR.  9.0.1
   if {NOT IsDebuggerPresent  and} TestiAjo  then begin //TestiAjo := TR  PRC TestiAjoON;  Esittely Defs.PAS.  +8.0.8
      Y_piipit (100);
      InfoDlg  ('2)  Kokeilunaikainen toiminta poistamatta jakeluversiosta, toiminta ei ehkä vastaa lopullista '+
                'tarkoitusta:  <b>Find "TstAjo"[word] In Files ..</b>, jatketaan.',mtWarning,
                'OK','','','', '','','','');  end;
end;*)

{ **********************************************************
   Alustetaan ohjelman tarvitsemat globaalit asetukset ja
   tarkistetaan mahdolliset ongelmat luotaessa formi.
   DEVELOPER2 1.9.1997
  ********************************************************** }
procedure TPaaValFrm.AsetNapMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);     {VAR ss :string;}      begin //+130.2
  inherited;
   if fRePunKehi
      then Hint := 'Määrit..  DEVELOPER1:  [ssCtrl +ssAlt +ssShift +mbRight] =Näkyy "²" = fRePunEriAjoSTAY:=TR'
      else Hint := 'Ohjelman määrityksiä, KÄYTTÖOIKEUSMÄÄRITYKSET, MUUTOKSET JA SIIRROT';
end;
                                   //,-1415: ChkLisensLista_NolaRek´ssa, Esti alkutietojen näyn PaaValOnShow´ssa. Siirtty PaaVal valintojen jälkeen.
procedure SyoAvHide;      begin  SyottoAvFrm.Hide;  end; //+1415.

procedure TPaaValFrm.AsetNapMouseUp(Sender: TObject;  Button: TMouseButton;  Shift: TShiftState;  X,Y: Integer);//120.5o:  BtnKlick vex, tämä tilalle ^C yms.
VAR ss :string;
{VAR ss :string;      begin
  inherited;
   ss := AsetNap.Caption;
   if (Button=mbLeft) and (Shift=[ssCtrl] +[ssShift] +[ssAlt])
   then AsetNap.Caption := ss
   else }begin
   SyoAvHide; //<+1415.
      if fRePunKehi and (Shift=[ssShift,ssAlt,ssCtrl]) and (Button=mbRight)  then begin //,,Nämä mahista VASTA kunPaaVal on ruudulla, liian myöhään.
         ss := AsetNap.Caption;
         if (ss<>'') and (ss[Length(ss)] ='²') //1414d: ss<>''
            then Delete(ss,Length(ss),1)
            else ss := ss +'²';                //<Lisätään loppuun erityistoiminnan merkiksi.
         AsetNap.Caption := ss;
      end;
      AsetusFrm.Execute;
      //KayOikR2.caption := AsetusFrm.haltija; //<,,Nämä hoidettu PRC ChkLaajuusLbl'ssa
{$IFNDEF NOLALIS}
      //KaykR1.caption := '£Käyttöoikeus:  '+mylicense.LisenssiNum;  //<Sama sijoitus rv 228 ja 351, tänne ei tulla kertaakaan.
{$ENDIF NOLALIS}
      //LicNum_NollatToVii; //<+12.0.04:  0 lisenssi viivoiksi.  -12.0.06: Nyt KayKr1 := Ei lisenssiä..
      AsetusFrm.Update;   //<Ettei Btnit näkyisi aukkoina ennakkovalinna jälkeen = kun esim <r> tms.
      ChkLaajuusLbl;      //<+1101 12å2: Tämä PRC AsetNapClick pyyhkii vex ChkLaajuusLbl´n tekemät lisäykset, todettu.
end;

constructor TPaaValFrm.Create(AOwner: TComponent);
 //VAR H :THandle; //<æ +12.0.08
begin
  inherited;

{//Ico,,
  with TrayIconData do
  begin
    cbSize := System.SizeOf(TrayIconData);
    Wnd := Handle;
    uID := 0;
    uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
    uCallbackMessage := WM_USER+1; //WM_ICONTRAY;
    hIcon := Application.Icon.Handle;
    StrPCopy(szTip, Application.Title);
  end;

  Shell_NotifyIcon(NIM_ADD, @TrayIconData);
//''Ico }

//LoadIconResource; //æ 12.0.08
//Application.Icon.LoadFromResourceName(Handle,'Nola_IconU.ico');
//Application.Icon := LoadIcon (H,'Nola_IconU.ico');

  myDesignInfo.ScreenHeight := DesignInfoLabel.DesignScreenHeight; //< 4.0.0: KAI: asettaa suunnittelu
  myDesignInfo.ScreenWidth :=  DesignInfoLabel.DesignScreenWidth;  //              aikaisen näytön koon.
                                                                   //              ks. NolaForms, TNolaForm
  Init;
  if NOT alustettu  then begin         //<,,120.5n: Nyt ks. LueAllFilet => Takas tähän,
     LueTalEdvFile (LueTR,KysFA,'');   //<Alkuluku =tutkitaan ed.istunn.lopussaTalletetut tied.nimet
     LueTalNjFile  (LueTR,KysFA,'');   //<Alkuluku =tutkitaan ed.istunn.lopussaTalletetut tied.nimet
    {''''''''''''''''''''''''''^^ ed. versio 1.0.3 ''''''''''''''''''''''''''''''''''''''''''''''''}
    {,,,,,,,,,,,,,,,,,,,,,,,,,,,, Saman arvoinen kuin ''', koska _FileN on tyhjä ,,,,,,,,,,,,,,,,,,}
     LueTalMoFile  (LueTR,KysFA,'');   //<Alkuluku =tutkitaan ed.istunn.lopussaTalletetut tied.nimet
     LueKahi;
   //alustettu := true;                //<Vasta OnShow´ssa.
  end;//if NOT alust*)
end;//TPaaValFrm.Create

procedure TPaaValFrm.CreateParams(var Params: TCreateParams);      begin //12.0.08i:  Iconi näkyviin taskbariin. Ei näy taskbarissa ainakaan.
 // change window style to have an icon in the taskbar
 // to do this we add WS_EX_APPWINDOW to the window style parameters
 // for more info ,look into MS win32 help reference on msdn
 inherited CreateParams(Params);
 ParentWindow:=GetDesktopWindow; // make sure desktop is owner of this form, if not, taskbar button will not function properly
 Params.ExStyle := WS_EX_APPWINDOW;
end;

{Laita yrityksen nimi näkyviin päävalikkoon ja kaikkiin paperitulosteisiin:  paina Asetukset, valitse Yleinen -lehti ja kirjoita yrityksen nimi kohtaan "käyttöoikeuden haltija".
Asetukset/..haltijan nimi (yritys???)}

procedure ChkLaajuusLbl;      VAR so,sn,{+120.4:}sz2,sz1,ss :string;  i,j :integer;      begin //<DEVELOPER1 7.0.1:  Jos DemoTab´ssa eri asetus, esitet LT/EXT (esim.)
   sn := '';  if sn='' then ;
{$IFNDEF NOLALIS}
   {µ~}LicNro := mylicense.LisenssiNumero; //+1415e: Tarvie: NjLaskentaNapClick
   so := LisLaajToStr (myLicense.lisenssilaajuus,0);
 //{µ} lvEXTok := myLicense.lisenssilaajuus>=lvEXTended; //<120.5n+:  TR jos lvEXTended tai lvGLOB.  130:  Nyt sijoitus Globals´sissa.
                              //¿DefsFileenZ('ChkLaaj: 0:  gAjoPath=' +gAjoPath +CR +' ®® gAjoConfPath=' +gAjoConfPath +'  TextBaseFN=' +TextBaseFileN +
                              //¿            CR +'LisLaaj=' +so +' ®® LisStat=' +MyLicStatusText +' ®® LicNroS=' +LicNroS);
                              YFileen('¿ChkLaajuusLbl');
ss := LisLaajToStr (AsetusFrm.DemoLisenssiLaajuus,0); //+1415a
   if NOT Demo(71) and (AsetusFrm.DemoLisenssiLaajuus <> myLicense.lisenssilaajuus)  then begin
      so := so +'<b>/';
      so := so +LisLaajToStr (AsetusFrm.DemoLisenssiLaajuus,0) +'</b>';
   end;                                                                //,,-11.0.1å2
   if fKaikkiOikeudet_1x  then begin                                                           //<, +10.0.4
      sn := mylicense.LisenssiNum;                                                             //<,,+11.0.2  12.0.06: Paikoin korvattu LicNroS´lla.
      while (sn<>'') and (sn[1]='0')  do //<1414d: sn<>''
            Delete(sn,1,1);
      so := 'EXT';                                        //<,,SO sijoitetaan alempna (tämän PRCn lopussa) LaajuusLbl´iin.
      if sn='1'  then//SIPky´n lis.
         so := so +'/koulu';
     {if Pos ('erivap',PaaValFrm.KaykR1.Caption) =0  then //<Jos ei vielä ole mukana, 12å2: siirto tähänOnShow´sta
         PaaValFrm.KaykR1.Caption := PaaValFrm.KaykR1.Caption +' EXT ' +COLOR_GRAY +'</b> erivap.'; //<-120.4:  Ei koskaan tätä. Jossain kirjoitetaan}
   end;                                                                                             //          tämän päälle.
{$ENDIF NOLALIS}
(*ALP,,,,,,,,,,,,,,,,,,,,,, DefsFileenZ('ChkLaaj: 8:  gAjoPath=' +gAjoPath +CR +' ®® gAjoConfPath=' +gAjoConfPath +'  TextBaseFN=' +TextBaseFileN +'<<<<<<<<<<<<<<<<<<');

   if Pos('EI LISENSSIÄ',AnsiUpperCase(MyLicStatusText{MyLicense.StatusText})) >0                //<,+12.0.06 Sijoitettu Y_.INC/Demossa.
      then PaaValFrm.KaykR1.Caption := MyLicStatusText//MyLicense.StatusText                     //<,+12.0.06 Muuten ,,
      else PaaValFrm.KaykR1.Caption := mytextbase.Get(PAAVAL_1)+'  '+LicNroS;//ææ mylicense.LisenssiNum; //<'Käyttöoikeus: ...' <= PRCn TPaaValFrm.SetTexts toisto tässä.
                                                                   //'Aivan sama sijoitus rv 351 ja tähän tullaan 351´n jälkeen, 582´ssa (AsetNapClick) sama siellä ei käydä.
 //AsetusFrm.HaltijaEdit.Text := 'Sähköinst. PUURRSSIIAINEN ky';
   PaaValFrm.KayOikR2e.Visible := false;                                                         //<Kylläkin jo FA ObjInsp´ssa.
   PaaValFrm.KayOikR2e.Lines.Clear;
                            //,,KS.VerLblMouseUp: testailukuvio eri LabelNola/RichEditNola vaihtoehdoilla:  ssShift/ssCtrl/[]  //!
   if Trim(AsetusFrm.HaltijaEdit.Text)=''                   //<,,Näiden värit ObjInsp´ssä clMaroon. +12.0.06
      then PaaValFrm.KayOikR2.Caption := '</b>(Yritysnimi näkyviin): <b>Asetukset/Yleinen/Käyttöoik.haltija..'                 //!
      else PaaValFrm.KayOikR2.Caption := '<b>' +AsetusFrm.HaltijaEdit.Text +'</b>';                                            //!

   if IsDebuggerPresent  then begin//"EXT/koulu 0 -1 -1"                                        //<,,+8.0.0                    //!
      i := fSalaLaajuus (j);                                                                                                   //!
      so := so +'  ' +IntToStr (TEST_LISENSSILAAJUUS) +' '+                                                                    //!
                      IntToStr (j) +' '+                                                                                       //!
                      IntToStr (i);                                                                                            //!
   end;                                                                                                                        //!
   PaaValFrm.LaajuusLbl.Caption := so;                                                                                         //!
end;//ChkLaajuusLbl '''ALP*)

                             //¿DefsFileenZ('ChkLaaj: 8:  gAjoPath=' +gAjoPath +CR +' ®® gAjoConfPath=' +gAjoConfPath +'  TextBaseFN=' +TextBaseFileN +'<<<<<<<<<<<<<<<<<<');
                             YFileen('¿ChkLaaj: 8:');
   PaaValFrm.KaykR1.Visible := false;     //<,,+120.4:  Nyt kaikki viestit pannaan RichEdit´iin KayOikR2e.##################################################
   PaaValFrm.KayOikR2.Visible := false;
   PaaValFrm.KayOikR2e.Visible := true;
   PaaValFrm.KayOikR2e.Align := alClient;
   PaaValFrm.KayOikR2e.Color := clBtnFace;          //<Kylläkin jo ObjInsp´ssa.
   PaaValFrm.KayOikR2e.Font.Color := {clBlue;//}clMaroon;
   PaaValFrm.KayOikR2e.Lines.Clear;
   sz2 := '<b><f n="" s="12">';                     //<,+120.4:  Koot KayOikR2e´n riveille
   sz1 := '<b><f n="" s="8">';                      //<,+120.4:  Koot KayOikR2e´n riveille

                            //,,KS.VerLblMouseUp: testailukuvio eri LabelNola/RichEditNola vaihtoehdoilla:  ssShift/ssCtrl/[]  //!
if (fDirectoryExists (KaikkiOikDirN) and (KaikkiOikDirN<>'')) //<+,,1413
then begin
   PaaValFrm.KayOikR2e.AddText ('<right>.<br><center>');                                        //<Ylämarginaaliksi, piste oikMrginaalin.
   PaaValFrm.KayOikR2e.AddText ('<b>Licenssintarkistus ohitettu, OK.<b><br>');  end //<''1413
else begin
   PaaValFrm.KayOikR2e.AddText ('<right>.<br><center>');                                        //<Ylämarginaaliksi, piste oikMrginaalin, loput te
   //if Pos('EI LISENSSIÄ',AnsiUpperCase(MyLicStatusText{MyLicense.StatusText})) >0               //<,+12.0.06 Sijoitettu Y_.INC/Demossa.
   //   then PaaValFrm.KayOikR2e.AddText (sz2 +MyLicStatusText +'<br>')                           //MyLicense.StatusText
   //   else PaaValFrm.KayOikR2e.AddText (sz2 +mytextbase.Get(PAAVAL_1)+'  '+LicNroS +'<br>');    //< "00001"  ææ mylicense.LisenssiNum;
end;
if isDeb  then begin DetEvFrm.Hide;  SyottoFrm.Hide;  end;//+1415a //'Sama sijoitus OLI: rv 351 ja tähän tullaan 351´n jälkeen, 582´ssa (AsetNapClick) sama siellä ei käydä.
   PaaValFrm.KayOikR2e.AddText ('<f n="" s="4"><br>');      //<Välirivi pienää fontilla.                                       //!
   if Trim(AsetusFrm.HaltijaEdit.Text)=''                   //<,,Näiden värit ObjInsp´ssä clMaroon. +12.0.06                   //!
      then PaaValFrm.KayOikR2e.AddText (sz1 +'</b>Yritysnimi näkyviin: <b>Asetukset/Yleinen/Käyttöoik.haltija..<br>')          //!
      else PaaValFrm.KayOikR2e.AddText (sz1 +AsetusFrm.HaltijaEdit.Text +'</b><br>');           //<"Sähköinst.."               //!
                                                                                                                               //!
   if IsDebuggerPresent  then begin//"EXT/koulu 0 -1 -1"                                        //<,,+8.0.0                    //!
      i := fSalaLaajuus (j);                                                                                                   //!
      so := so +'  ' +IntToStr (TEST_LISENSSILAAJUUS) +' '+                                                                    //!
                      IntToStr (j) +' '+                                                                                       //!
                      IntToStr (i);                                                                                            //!
   end else                                                                                                                    //!
      so := ss;//LisLaajToStr (myLicense.lisenssilaajuus,0); //<+1415a: Laajuus näkyviin LT/PRO/EXT.                                //!
   PaaValFrm.LaajuusLbl.Caption := so;                                                                                         //!
end;//ChkLaajuusLbl*)                                                                                                          //!
                                                                                                                               //!
procedure TPaaValFrm.VerLblMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);   begin          //!
   inherited;                                       //'Tällä päästään  vaihtamaan näkyvä LabelNola / RichEditNola -kompon/!.   //!
   if IsDebuggerPresent  then                                                                                                  //!
      if KayOikR2e.Visible                                                                                                     //!
      then begin                                                                                                               //!
         KayOikR2e.Visible := false;                                                                                           //!
         KayOikR2.Visible := true;                                                                                             //!
         PaaValFrm.KayOikR2.Font.Color := clMaroon;                                                //<+1101 12å2               //!
         if ssShift IN Shift                                                                                                   //!
         then PaaValFrm.KayOikR2.Caption := '</b>`      r(Yritysnimi puuttuu): <b>Asetukset /<br>Yleinen /Käyttöoik.haltija...' //!
         else if ssCtrl IN Shift                                                                                               //!
         then PaaValFrm.KayOikR2.Caption := '</b>r(Yritysnimi puuttuu): <b>Asetukset /Yleinen /Käyttöoik.haltija...'            //!
         else if ssAlt IN Shift                                                                                                //!
         then PaaValFrm.KayOikR2.Caption := '</b>r(Yritysnimi puuttuu): <b>Asetukset/Yleinen/Käyttöoik.haltija..'               //!
         else PaaValFrm.KayOikR2.Caption := '</b>r(Yritysnimi puuttuu): <b>Asetukset /<br>Yleinen /Käyttöoik.haltija...';  end  //!
      else begin                                                                                                               //!
         KayOikR2e.Visible := true;                                                                                            //!
         KayOikR2.Visible := false;                                                                                            //!
         PaaValFrm.KayOikR2e.Font.Color := clTeal;                                                //<+1101 12å2                //!
         if ssShift IN Shift                                                                                                   //!
         then PaaValFrm.KayOikR2e.Text := '</b>`      €(Yritysnimi puuttuu): <b>Asetukset /<br>Yleinen /Käyttöoik.haltija...'   //!
         else if ssCtrl IN Shift                                                                                               //!
         then PaaValFrm.KayOikR2e.Text := '</b>€(Yritysnimi puuttuu): <b>Asetukset /Yleinen /Käyttöoik.haltija...'              //!
         else if ssAlt IN Shift                                                                                                //!
         then PaaValFrm.KayOikR2e.Text := '</b>€(Yritysnimi puuttuu): <b>Asetukset/Yleinen/Käyttöoik.haltija..'                 //!
         else PaaValFrm.KayOikR2e.Text := '</b>€(Yritysnimi puuttuu): <b>Asetukset /<br>Yleinen /Käyttöoik.haltija...';         //!
      end;                                                                                                                     //!
end;                                                                                                                           //!

{ **********************************************************
   Tallennetaan tarvittavat asiat formin tuhoutuessa.
   DEVELOPER2 1.9.1997
  ********************************************************** }
destructor TPaaValFrm.Destroy;
begin
     inherited;
//Shell_NotifyIcon(NIM_DELETE, @TrayIconData); //<Ico

{$IFNDEF NOLALIS}
     mylicense.free;
{$ENDIF NOLALIS}
end;

(*procedure LicNum_NollatToVii;      VAR ss :string; //Muuttaa kaikkiNollia LicNon "- " -pareiksi: 00000 => "- - - ".  +12.0.04  -12.0.06: Nyt KayKr1 := Ei lisenssiä..
   procedure NollatToVii (VAR SI :string);      VAR so,sa,sn,sc :string;  i,n :integer;      begin
      SI := Trim(SI);
      so := SI;                                 //<Jotta alp olisi lopussakin nähtävillä.
      SA := '';  SN := '';  SC := '';           //<SA=alkuosa  SN=numero-osa  SC=Loppuosa.
      i := Length (SI);  n := 0;
      while NOT (SI[i] IN ['0'..'9']) and       //<Ohitetaan kirjaimet ja edelt välit, joista tehdään SC.   "Xxxx 00000 xx" => "Xxxx 00000"
            (i>1)  do begin
         SC := SI[i] +SC;
         Delete (SI,i,1);  i := i-1;  end;      //<SI lyhenee lopusta samalla.
      if SI<>'!"#¤'  then ;

      while (SI[i]='0') and (i>1)  do begin     //<Ohitetaan '0':t, joista tehdään SN.                      "Xxxx 00000"    => "Xxxx "
         SN := SI[i] +SN;
         Delete (SI,i,1);  i := i-1;  end;      //<SI lyhenee lopusta samalla.
      if SI[i]<>' '  then begin
         SI := so;                              //<Jos ei ollutkaan pelkkiä nollia, palautetaan alp ja muut nollataan ettei tuplaannu.
         SN := '';
         SC := '';  end;
      if SI<>'!"#¤'  then ;

      while (SN<>'') and (SI[i]=' ')  do begin  //<Numjerojonossa vain NOLLIA ja edessä väli.
         SA := SA +'- ';  Delete (SN,1,2);  end;//<Delataan alusta '00' pätkiä.
      SI := SI +SA +SC;
      if SI+so<>'!"#¤'  then ;
   end;
begin//LicNum_NollatToVii........
  {ss := 'Asdfghj: 000000 xz';  NollatToVii (ss);
   ss := 'Asdfghj: 000000 xz';  NollatToVii (ss);
   ss := 'Asdfghj: 000000';     NollatToVii (ss);
   ss := 'Asdfghj: 000001';     NollatToVii (ss);
   ss := 'Asdfghj: 000001';     NollatToVii (ss);
   ss := 'Asdfghj: 000001 xz';  NollatToVii (ss);
   ss := 'Asdfghj: 000010 xz';  NollatToVii (ss);
   ss := 'Asdfghj: 000010';     NollatToVii (ss);
   ss := 'Asdfghj: 000010 xz';  NollatToVii (ss);
   ss := 'Asdfghj: 100000';     NollatToVii (ss);
   ss := 'Asdfghj: 100000 xz';  NollatToVii (ss);
   ss := 'Asdfghj: 100000 xz';  NollatToVii (ss);
   ss := 'Asdfghj: 000000';     NollatToVii (ss);//}
   ss := PaaValFrm.KaykR1.Caption;     NollatToVii (ss);
   PaaValFrm.KaykR1.Caption := ss;
   if ss='a'  then ;
end;*)

procedure TPaaValFrm.SetTexts;
begin
     myTextBase.AutoGetRecursiveComponentText(language, '', self);
   //KayOikR2.caption := myRegSettings.AutoGetStringValue(ASETUS_HALTIJA, '');  //<-120.4
   //KaykR1Num.caption := mylicense.LisenssiNum;
//message Hint 'Oliko joskus IFNDEF/IFDEF ?? NOLALIS ohitus.'
{$IFNDEF NOLALIS} //æ                                                           //<DEVELOPER2 ALP: Ohittuu jos EI NOLALIS =Ohittuu siis NOLAlla. KOE=vex => eiOK.
{-$IFDEF NOLALIS} //æ                                                           //<,Ohittuu jos EI NOLALIS =Ohittuu siis NOLAlla
   //KaykR1.caption := mytextbase.Get(PAAVAL_1)+'  ¤'+{LicNroS;//}mylicense.LisenssiNum; //<'Käyttöoikeus: ...'
   //'-120.4                                        //<''''''Aivan sama sijoitus rv 228, se tämän jälkeen, myös 582 (AsetNapClick) siellä ei käydä?.
{$ENDIF NOLALIS} //æ                                //''120.4:  Nyt kaikki sijoitukset kutsussa ChkLaajuusLbl´ssa.
     //LicNum_NollatToVii; //<+12.0.04:  0 lisenssi viivoiksi.              -13å3
end;
//***************************************************************************************************************

      procedure TPaaValFrm.Timer3Timer(Sender: TObject);      begin //<,,Ei tapahdu koskaan ??? Lisätty +4.0.0
        inherited;                                                  //   Nyt otettu vex = ObjInsp :ssa Enabled =FA
        with OdotaLbl  do
        if Font.Size=14  then begin  Font.Size := 12;
                                     Caption := '>>>> ODOTA <<<<';
                                    {OdotaTim.Interval := 200;  }end
                         else begin  Font.Size := 14;
                                     Caption := '>>> ODOTA <<<';
                                    {OdotaTim.Interval := 500;  }end;
      end;

procedure odota_ON;      begin
         PaaValFrm.OdotaLbl.Visible := true;
         PaaValFrm.Timer3.Enabled :=   true;
       //PaaValFrm.Refresh;  end;
         PaaValFrm.Update;  end;
      procedure odota_OFF;     begin
         PaaValFrm.Timer3.Enabled :=   false;
         PaaValFrm.OdotaLbl.Visible := false;
       //PaaValFrm.Refresh;  end;
         PaaValFrm.Update;  end;

{function aikaS :string;      VAR st :string;      begin
   st := DateTimeToStr (Now); //< Tai:  sd := TimeToStr(Time);
   st := st +'  ' +fMsecS;
   result := st;  end;}

procedure Tics (si :string);                                   //,,Laskee ejankäyulun edelliseen leimaan, editoi KoeWInfoA´han, mistä kopioitavissa.
   function fNo (i :integer)  :string;      VAR s :string;      begin                        //'TICSonKulunut aika
      s := '';
      if i<10  then s := '0';
      s := s +IntToStr (i);
      result := s;   end;
   function ots (s :string)  :string;      VAR i :integer;      begin
      for i := Length (s) to 25  do s := s +' ';
      result := s;   end;
   procedure LaskeTics;      VAR h1,m1,s1,ms1, h2,m2,s2,ms2 :Word;  tim1,tim2,dt,qTics :Integer{Double};     begin
   {  dt := 6630010;
      h1 :=  dt DIV 3600000;  //< h1 nyt aikaero   [h]
      dt :=  dt MOD 3600000;  //< dt aikaerojäännös   [ms]
      m1 :=  dt DIV 60000;    //< s1 nyt aikaero   [m]
      dt :=  dt MOD 60000;    //< dt aikaerojäännös   [ms]
      s1 :=  dt DIV 1000;     //< ms1 nyt aikaero  [s]
      dt :=  dt MOD 1000;     //< dt aikaerojäännös   [ms]
      ms1 := dt;              //< ms1 nyt aikaero  [ms]   }

      DecodeTime(Tics0, h1,m1,s1,ms1);
      Tics0 := Time;                   //<Aika muistiin eur. vertailua varten.
      DecodeTime(Tics0, h2,m2,s2,ms2);
      //       h  m  s   ms    m  s   ms    s   ms
      tim1 := h1*60*60*1000 + m1*60*1000 + s1*1000 + ms1; //<, Aika [ms]
      tim2 := h2*60*60*1000 + m2*60*1000 + s2*1000 + ms2;
      dt := tim2-tim1;                                    //< Aikaero [ms]

      qTics := dt;
      TicsY := TicsY +dt;

      h1 :=  dt DIV (60*60*1000);  //< h1 nyt aikaero   [h]
      dt :=  dt MOD (60*60*1000);  //< dt aikaerojäännös   [ms]
      m1 :=  dt DIV (60*1000);     //< s1 nyt aikaero   [m]
      dt :=  dt MOD (60*1000);     //< dt aikaerojäännös   [ms]
      s1 :=  dt DIV 1000;          //< s1 nyt aikaero   [s]
      dt :=  dt MOD 1000;          //< dt aikaerojäännös   [ms]
      ms1 := dt;                   //< ms1 nyt aikaero  [ms]}

      dt := TicsY;  //,,,Kokonaisaika,,,,,,,,,,,,,,,,,,,,,,,,,,
      h2 :=  dt DIV (60*60*1000);  //< h2 nyt aikaero   [h]
      dt :=  dt MOD (60*60*1000);  //< dt aikaerojäännös   [ms]
      m2 :=  dt DIV (60*1000);     //< s2 nyt aikaero   [m]
      dt :=  dt MOD (60*1000);     //< dt aikaerojäännös   [ms]
      s2 :=  dt DIV 1000;          //< s2 nyt aikaero   [s]
      dt :=  dt MOD 1000;          //< dt aikaerojäännös   [ms]
      ms2 := dt;                   //< ms2 nyt aikaero  [ms]}

      if NOT KoeFrm.Visible  then
       //KoeInfo(0, '                                   Väliajat:                     Kumulatiivisesti:<br>');
         KoeWInfoA(0,'                                [ms]Väliajat=hh:mm:ss: ms     [ms]Kumulat.=hh:mm:ss: ms<br>');
      KoeWInfoA(0, ots (si) +':   ' +fImrkt0 (qTics,8) +'       ' +
                                   fNo (h1) +':' +fNo (m1) +':' +fNo (s1) +':' +fImrkt0 (ms1,3) +'   '+
                                   fImrkt0 (TicsY,8) +'       ' +
                                   fNo (h2) +':' +fNo (m2) +':' +fNo (s2) +':' +fImrkt0 (ms2,3) +'<br>');
   end;//LaskeTics

begin//Tics.....................
 //LaskeTics;                      //<1414d: Koment tämä vex => ei editoi aijankäyttöä =Kommentoitu vex =jakeluversiossa
end;//Tics

procedure TPaaValFrm.NjLaskentaNapClick(Sender: TObject);
      LABEL 1;   VAR x :integer;  {s1,s2 :string;}{=Kokeiluun +1415e}   //begin                   //,,Nämä vain jos eioo licenssi OK.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                                                                                        //,,~1/2 vuotta +120.5n+: Herjataan + esto jos LICENSE_VALV_DirL´n
begin//NjLaskentaNapClick...........................................
   SyoAvHide; //<+1415.
{               ZpeOK (1,false,'',0,0,0,0, s1,s2);
                ZpeOK (2,false,'',0,0,0,0, s1,s2);
                ZpeOK (3,false,'',0,0,0,0, s1,s2);
                ZpeOK (4,false,'',0,0,0,0, s1,s2);
                ZpeOK (5,false,'',0,0,0,0, s1,s2); {ZpeOKn kokeilua}
   //if fRePunKehi  then   //<,+120.5n
   if isDeb  then          //<+1415e
      DetEvFrm.Close;//Hide;
DefsFile3 ('NjLaskentaNapClick 120.45 #######################################');
YFileen ('NjLskNap 0');

//if NOT {myLicense.IsLicenseInstalled µ} LicAsttuOK  then       //<,,+120.5n,  -1415e
//if {myLicense.lisenssilaajuus <lvEXTended µ} NOT lvEXTok  then //<-1415e
     {s1 := mylicense.LisenssiNum;
      while (s1>'') and (s1[1]='0')  do Delete(s1,1,1);
      if s1>''  then x := StrToInt(s1)  else x := 0; <''Nyt FNC fLisNoStrToInt }
{µ~}x := LicNro; //+1415e: LicNro := mylicense.LisenssiNumero; =..PaaVal.PAS
if fDirectoryExists(KaikkiOikDirN)  then
if x<>33  then                             //<+1415e vapaa ajo, ei estoa = 33=Yhtyneet Insinöörit Oy.´lle
   NjLaskentaNap.Enabled := false;
   Screen.Cursor := crHourGlass;      //<Ilman SCREENiä vipattaa!!!
   {OdotaFrm.Start;}
    odota_ON;
                     {Koe:
                      syoKut := 5;  editSyoFrm;//}
  //HerjaInfo ('!');                  //<OdotaFrm "elää" vai       n, jos tässä stop, muuten ei näy kun Edv latautuu
       syoKut := 2;
{KOE +6.2.2 InfoDlg,,,,,,,,,,,,,}
YFileen ('NjLskNap 1');
    if NOT EdvJoOllut  or MootNj      //<MootNj := FA siellä, Siellä myös Cursor crHour..
       then begin asetaProgres ('Verkkoarvoja lasketaan',1);// + a_getIntg (1,edv.YLE.JohtoOsia));  //< +3.0.3
Tics ('PaaVal/EdvBtn 1 ');
YFileen ('@£$µ1/2'); //+1415e
                  PvitaEdvFrm;                                  //<EiOlis tarpeen jos tullaan AsetusFrm´ista (10.0.4§).
YFileen ('@£$µ2/2'); //+1415e
                  if demo(72)  then begin                       //<,,Ettei Btnit jää avusteFrmn alle +4.0.0
                     x := EdvNewFrm.Left +EdvNewFrm.ChkBxAv.Left +20;
                     if SyottoAvFrm.Left<x
                        then SyottoAvFrm.Left := x;
                  end;
                  NjTulFrm.Top := 0;                        //<,+4.0.0  Koska koko ei talletu jostain syystä.
                  NjTulFrm.Height := Screen.Height -20;
                  if NjTulFrm.Width<300           then NjTulFrm.Width := 800;
                  if NjTulFrm.Width>Screen.Width  then NjTulFrm.Width := Screen.Width;
                  if NjTulFrm.Left <300           then NjTulFrm.Left :=  0;   end
       else begin EdvNewFrm.Show;
                  Screen.Cursor := crDefault;  end;

    odota_OFF;
   {EdvNewFrm.Width := EdvNewFrm.Width +1;     //<,Jotta NjL:stä lähtevä johto asettuisi samaan korkoon =+6.2.2
    EdvNewFrm.Width := EdvNewFrm.Width -1;     //<'Ei tehoa.}
   EdvJoOllut := true;
                  Screen.Cursor := crDefault;
   NjLaskentaNap.Enabled := true;
YFileen ('NjLskNap 2');
//Tics ('PaaVal/EdvBtn 9 '); //''''''''''''''''KOE +6.2.2 InfoDlg''''''}
1:
{//MessageDlg ('',mtError,  [mbOK],0);
//MessageDlg ('',mtWarning,[mbOK],0);
//MessageDlg ('mtInformation',mtInformation,[mbOK],0);
//MessageDlg ('mtConfirmation',mtConfirmation,[mbOK],0);
//MessageDlg ('mtCustom',mtCustom,[mbOK],0); //<Ei tule minkäänlaista imagea
x := InfoDlg ('1/12 Tietueen SIJOITUSvirhe (Boolean), joka saattaa olla aiheutunut käsin virheellisesti '+
              'muutetusta ajotiedostosta. Virheellinen arvotyyppi saattaa aiheuttaa ajon keskeytymisen. '+
              'Ota yhteys ohjelman toimittajaan ja välitä tiedot virheilmoituksesta, käsittelyikkunasta '+
              'ja edeltäneestä tilanteesta.',
              mtError,        'Ei talletusta','','','',
                              'Se1' ,'Se2' ,'Se3' ,'Buttoni4XX 123');  Caption := IntToStr (x);
if x <> 9  then //< := 9 kun InfoDlg suljetaan X :llä
x := InfoDlg ('0/12 Infokoe = o-btn 0-sel Pitkällä pitkällä pitkällä pitkällä pitkällä pitkällä pitkällä pitkällä pitkällä tekstillä.',
              mtCustom,       '','','','',
                              '','','','');                       Caption := IntToStr (x);
if x <> 9  then
x := InfoDlg ('2/12 Infokoe = 1-btn 0-sel Pitkällä pitkällä pitkällä pitkällä pitkällä pitkällä pitkällä pitkällä pitkällä tekstillä.',
              mtWarning,      'Btn1','','','',
                              '' ,'' ,'' ,'');                    Caption := IntToStr (x);
if x <> 9  then
x := InfoDlg ('3/12 Infokokeilua = 2-btn 2-sel Kohtalaisen pitkällä pitkällä pitkällä pitkällä tekstillä.',
              mtCustom,       'Btn1','Btn--2','','',
                              'Se1' ,'Selit2' ,'' ,'');           Caption := IntToStr (x);
if x <> 9  then
x := InfoDlg ('',  mtCustom,  'OK','','','',
                              '','','','');                       Caption := IntToStr (x);
if x <> 9  then
x := InfoDlg ('',  mtError,   'OK','','','',
                              '','','','');                       Caption := IntToStr (x);
if x <> 9  then
x := InfoDlg ('6/12 Infokokeilua = 3-btn 4-sel Kohtalaisen pitkällä pitkällä tekstillä.',
               mtCustom,      'Btn1','Btn--2','Btn3','',
                              'Se1' ,'Se2' ,'Se3' ,'Se4');        Caption := IntToStr (x);
if x <> 9  then
x := InfoDlg ('7/12 Infokokeilua = 4-btn 4-sel Kohtalaisen pitkällä pitkällä pitkällä tekstillä.',
               mtCustom,      'Btn1','Btn2','Btn3','Btn4',
                              'Se1' ,'Se2' ,'Se3' ,'Se4');        Caption := IntToStr (x);
if x <> 9  then
x := InfoDlg ('8/12 Kokeilua = 4-btn 4-sel Kohtalaisen pitkällä pitkällä pitkällä pitkällä tekstillä.',
               mtCustom,      'Btni1','Btni2','Btni3','Btni4',
                              'Seli1' ,'Sel2' ,'Sel3' ,'Sel4');   Caption := IntToStr (x);
if x <> 9  then
x := InfoDlg ('9/12 Infokoe = 4-btn 4-sel Pitkällä pitkällä pitkällä pitkällä pitkällä pitkällä pitkällä pitkällä pitkällä tekstillä.',
               mtCustom,      'Btn1X','Btn2X','Btn3X','Buttoni4xxXxx17',
                              'Se1X' ,'Se2X' ,'Se3X' ,'Se4Xpitkäkin kuvaus pitkä pitkä pitkä pitkä pitkä pitkä pitkä.');
                                                                  Caption := IntToStr (x);
if x <> 9  then
x := InfoDlg ('10/12 Infokokeilua = 4-btn 2-sel',
               mtCustom,      'Btn1','Btn2','Btn3','Btn4',
                              'Se1' ,'Se2' ,'','');               Caption := IntToStr (x);
if x <> 9  then
x := InfoDlg ('11/12 Infokokeilua = 4-btn 2-sel',
               mtInformation, 'Btn1','Btn2','Btn3','Btn4',
                              'Se1' ,'Se2' ,'','');               Caption := IntToStr (x);
if x <> 9  then
x := InfoDlg ('12/12 Infokokeilua = 4-btn 2-sel',
               mtConfirmation,'Btn1','Btn2','Btn3','Btn4',
                              'Se1' ,'Se2' ,'','');               Caption := IntToStr (x);
if x <> 9  then GOTO 1;//}
                   end;//TPaaVal.NjLaskentaNapClick

procedure TPaaValFrm.MoottoriNapClick(Sender: TObject);   begin //,,Saatais olla syytä: LaskeEdvArvot
   MoottoriNap.Enabled := false;                                //jos joskus MOOTT.LÄHDT tarvits arvoja ????
   SyoAvHide; //<+1415.
   LisYliDemo_Info (lvPRO);          //<+7.0.1
   Screen.Cursor := crHourGlass;     //<Ilman SCREENiä vipattaa!!!
   {OdotaFrm.Start;}
    odota_ON;
// EditNj;
                                              {  Y_DemoInfo('');  //Kommenttisulut vex demoversioon}
  (*if MoJoOllut  then begin  MoFrm.Show;     //<Mahd. demolehden valintamuutosten takia. -7.0.1
                             {OdotaFrm.Close;}
                              odota_OFF;  end
                  else *)EditMoFrm;
        //MoDetFrm.Show; //Kokeilua varten, ettei vaikuta sekoittavasti =EiTodMukainen, KS. PRC AvuChkSft. +1.1.3
    odota_OFF;
   Screen.Cursor := crDefault;
   MoJoOllut := true;
   MoottoriNap.Enabled := true;
end;

procedure TPaaValFrm.ImpedNapClick(Sender: TObject);      begin
//PutsCellsR_cn;                       //<ZS_Frm.  Putsataan + Numeroi = "Alustaa" niin, ettei Heighist yms. "maalaa"
  ZS_Frm.ZS_SuTimCm.Visible := false;  //<+130.0:  Muuten jää  Imped.käsittelyssä näkyviin.  KESKEN KESKEN 130.1
  DetEvFrm.Hide;                       //<+130.2e: Jottei tarttis sulkea käsin.
  SyoAvHide; //<+1415.
  Z_PaaValFrm.Show;
  Z_PaaValFrm.Update;
end;

procedure TPaaValFrm.InfoNapMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,Y: Integer);      begin
  inherited;
   if (ssCtrl IN Shift) and (ssAlt IN Shift)
   then if DefsFileeseenONb                  //<1414e:  -and DefsFileeseenNyt
      then begin
         X := InfoDlg ('Lopetetaanko ajotietojen kirjoittaminen (tiedostoon:  ' +fDefsFN +')',  mtCustom,
                       'Kyllä','Ei','','',  '','','','');
         if X=1  then DefsFileeseenONb := false;  end
      else begin
         X := InfoDlg ('Aletaanko kirjoittaa ajotietoja (tiedostoon:  ' +fDefsFN +') ?',  mtCustom,
                       'Kyllä','Ei','','',  '','','','');
         if X=1  then DefsFileeseenONb := true;
      end
   else begin         //<Normaalivalinta: Tetoa ohjelmamuutoksista yms
      Screen.Cursor := crHourglass;
      TabNo := 1;                          //<+12.0.0:  Ohjataan suoraan versiomuutostietoihin
      avuste (0,99,0,0);
      Screen.Cursor := crDefault;
   end;
end;
//'käyttämättömiä. S_PaaVal..:ssa ei tarvita, koska siellä aoBtnClickissä SAMA.

procedure TPaaValFrm.SulakeNapClick(Sender: TObject);     begin
                                              {  Y_DemoInfo('');  //Kommenttisulut vex demoversioon}
   SyottoAvFrm.Hide;                          //<+130.0  jottei Sulakekäyrä tulisi alle.
   S_PaaValFrm.Show;
   S_PaaValFrm.Update; //<Ettei Btnit näkyisi aukkoina ennakkovalinna jälkeen = kun esim <r> tms.
end;

procedure TPaaValFrm.KatuvBtnClick(Sender: TObject);      begin //10.0.4
  inherited;
   SyoAvHide; //<+1415.
   NjLaskentaNapClick(Self);
   EdvNewFrm.OkBtnClick(Self);
   NjFrm.OkBtnMouseDown(Self,mbLeft,[ssAlt], 0,0);
//Laskee pää-/nousujohtovaihtoehdot halutusta verkkopisteestä lähtien.  PRO-laajuus:  ALT+Klik = KATUVALOJOHTOJEN LASKENTA... (Kysyy tiedoston). Syntax: Ks. ..\Nola\Data\Katuvalo\Katu.TXT
end;

procedure TPaaValFrm.LopetaClick(Sender: TObject);
// Ks. \\Reijo-xp\e\Projektit XE2\NolaKehi\SRC\Globals\WNetGetUniversalName.inc
begin PaaValFrm.Close;  end;

procedure Efect (o :integer);           //<,, +2.0.5,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   procedure muuta (Btn :TButton);      begin
      if o=0  then begin                //< 0 = Palautetaan normaaliksi
         Btn.Font.Size := 18;//17;
       //Btn.Font.Color := clLime;      //< Ei worki
         Btn.Font.Style := [fsBold];  end
      else begin
         Btn.Font.Size := 10;
       //Btn.Font.Color := clBlack;     //< Ei worki
         Btn.Font.Style := [];  end;
   end;
begin                            //,1416: Tänne tullaan jo DebWr/SijKutsuLkm -DLGstä.
   if EdvNewFrm<>NIL  then begin //<,,+1416: Eioo muitakaan luotu jos ei Edv..
   muuta (EdvNewFrm.OhjeBtn);
      muuta (NjFrm.OhjeBtn);
      if MoFrm<>NIL  then    //<+8.0.0  §LUO§
      muuta (MoFrm.OhjeBtn);  end;
end;
procedure OhjeEfect_OFF;      begin
   PaaValFrm.Timer1.Enabled := false;
   Efect (0);
end;
procedure OhjeEfect_ON;      begin
   with PaaValFrm  do begin
      Timer1.Interval := 200;
      Timer1.Enabled := true;  end;
end;

procedure TPaaValFrm.Timer1Timer(Sender: TObject);      begin //<,,Muuttaa OhjeBtn :n kokoa ja tekstiväriä
  inherited;
   if EdvNewFrm.OhjeBtn.Font.Style=[]
      then Efect (0)
      else Efect (1);
{  if Caption='1'                       //<Hyvä testauksessa =Näkyy pääval :ssa, ei tartte mennä muihin formeihin
      then Caption := '2'
      else Caption := '1';}
end;
//...........................................................
procedure OhjeEfect2_ON;      begin //<,,Lukitsee YLEISinfon 5 :ksi sekunniksi (Interval=5000)
   with PaaValFrm  do begin
      Timer2.Interval := 6000;
      Timer2.Enabled := true;
      AvuChkSft (11);               //<Lukitaan 6 :ksi sekunniksi (Interval=6000) YLEISinfo
   end;                             //'Poiskytkentä, ks. Timer2Timer jälempnä !!!!!!!!!!!!}
end;
procedure TPaaValFrm.Timer2Timer(Sender: TObject);      begin
  inherited;
   AvuChkSft (10);                  //<Vapautetaan 6:ksi sekunniksi (Interval=6000) lukittu YLEISinfo
   PaaValFrm.Timer2.Enabled := false;
 //Y_piipit (5);                    //<Vaikuttaa oudolta kun piippaa EdvFrm´n aukeamisen jälkeen muutaman s kuluttua.
   OhjeEfect_OFF;                   //<Myös ?Btn normaaliksi (iso, bold, ei vilku)
end;                                //<'' +2.0.5'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
//==================================================================================================
{procedure LueKirjRTF;      VAR RTFfile,KOEfile :Text;  s :string;      begin
   AssignFile(RTFfile,'KoeRTF.rtf');
   AssignFile(KOEfile,'KoeRTF.txt');
   Reset  (RTFfile);
   Rewrite(KOEfile);
   while NOT Eof (RTFfile)  do begin
      Readln (RTFfile,s);
      Writeln (KOEfile,s);  end;
   CloseFile (RTFfile);
   CloseFile (KOEfile);
end;}
             //,,4.0.0:  Siirretty LopetaBtn´ista, LABEL 9 vex, korvattu Action := caNone.
procedure TPaaValFrm.FormClose(Sender: TObject;  VAR Action: TCloseAction);
      VAR s,fa,pc{1415f} :string;  vsii :integer;  eriEdv,errFil,errAmc,errUps :boolean{..:120.5n};      begin
   inherited;
 //procedure TPaaValFrm.LopetaClick(Sender: TObject);
 {function MessageDlg(const Msg: string; AType: TMsgDlgType; AButtons: TMsgDlgButtons; HelpCtx: Longint): Word;}
 //CloseKrt := 0;
   //¿DefsFileenZ('#¤%&: FrmClose: DTot:' +Ints(DTot) +' (err)DExc:' +Ints(DExc) +' KumTOT: ' +Ints(KumTOT)); //+120.5o: Ei kyllä kirjoita tätä fileen.!?!?!?
   YFileen('¿FormClose');

   AsetusFrm.SalaEdi.Text := '';        //<Mahd.salasana vex ettei talletu (???)
{  if ( EriEdvF  or (FileLukuVirhe<>'')  and Is_AMCMK3_25t35_to_AMCMK3o (EdvFilen) )  //<>''=Luettssa havaittu +txt tehty.
      OR Older_12_0_6_OR_JkUpsPuuttuu                                                 //<+120.5n+ }
   fa := teePolkuDataFilen(1); //< 1=Olet-Ev.NOE, 2=Olet-Nj.NON, 3=Olet-Mo.NOM        //<+1415eX ?.



   eriEdv := EriEdvF;
   errFil := FileLukuVirhe<>'';
   errAmc := Is_AMCMK3_25t35_to_AMCMK3o (EdvFilen); //<>''=Luettssa havaittu +txt tehty.
   errUps := Older_12_0_6_OR_JkUpsPuuttuu;
   if eriEdv OR (errFil and errAmc) OR errUps                                         //<''+120.5n+
   then begin                                                                         //'Tutkit ennen talletusta onko tallTarve.
      s := '';
      if (FileLukuVirhe<>'')  and Is_AMCMK3_25t35_to_AMCMK3o (EdvFilen)  then                  //<,+11.0.1
         s := 'Verkkokuvaajasta löytynyt vanhan asennuskannan AMCMK3½, vaihdettu AMCMK3<b>½o</b> (PEN 10cu) '+
              'tyypiksi.<br>';
      pc := fPCnNimi;
      Bep;   s := s +'Edeltävän verkon tiedot muuttuneet, TALLETETAANKO?<br>' +EdvFilen +':' +pc; //<+1415eX.
    //vast := MessageDlg (s, mtInformation, [mbYes,mbNo,mbCancel], 0);
      vsii := InfoDlg (s, mtWarning, 'Talleta','Ei talletusta','Peru','',  '','','','');
     {case vast of                                                                                  -6.2.2
         mrYes    :LueTalEdvFile (LueFA,KysFA,EdvFilen); //<FALSE,FALSE = TALLETTAA,KysFA=FA =EiKysyNimeä +TalNimeä
         mrNo     : ;
         mrCancel :Action := caNone;   end;}
      case vsii of                                                                             //<,,+6.2.2
         1   :LueTalEdvFile (LueFA,KysFA,EdvFilen); //<FALSE,FALSE = TALLETTAA,KysFA=FA =EiKysyNimeä +TalNimeä
         2   : ;
         3,9 :Action := caNone;   end;
   end;    //'Vikax luetun käsitellyn nimen talletus aina, jos vaikka eka istunto ja oletustiedot -> Viim-...
 //Y_gLueTal_FileLista (1, LueFA,KysFA,EdvFilen);   //<+130.0:  Aina talletetaan filenimi lopuksi.
   LueTalFilenReg ('pva',1,LueFA,KysFA,EdvFilen);       //<1=Edv   FA=Tallettaa  FA=EiLopTal=TekeeNimenJos''. 1415f: Lisätty kutuosoite ekaxi param.
                                                    //+130.0:  UUDESSA AJOSSA EKAX LUETAAN REKISTERISÄ, JOTEN TÄMÄ PÄIVITETTÄVÄ.
   if EriNj  then begin
      Bep;   s := 'Keskustiedot muuttuneet, TALLETETAANKO?<br>' +NjFilen; //<,Jos MootNJ, nimikin oli jo muutettu,
    //vast := MessageDlg (s, mtInformation, [mbYes,mbNo,mbCancel], 0);    //  ks. NjVrk.INC/EditNjFrm
      vsii := InfoDlg (s,  mtWarning,  'Talleta','Ei talletusta','Peru','',  '' ,'','','');
     {case vast of
         mrYes    :LueTalNjFile  (LueFA,KysFA,NjFilen); //<FALSE,FALSE = TALLETTAA,LopTal=FA =EiKysyNimeä +TalNimeä
         mrNo     : ;
         mrCancel :Action := caNone;   end;}
      case vsii of                                                                             //<,,+6.2.2
         1   :LueTalNjFile  (LueFA,KysFA,NjFilen); //<FALSE,FALSE = TALLETTAA,LopTal=FA =EiKysyNimeä +TalNimeä
         2   : ;
         3,9 :Action := caNone;   end;
   end;    //'Vikax luetun käsitellyn nimen talletus aina, jos vaikka eka istunto ja oletustiedot -> Viim-...
 //LueTalFilenReg (2,LueFA,KysFA,NjFilen);                        //<1=Edv  FA=Tallettaa  FA=EiLopTal=TekeeNimenJos''

   if EriMo  then begin
      Bep;   s := 'Moottorilähtötiedot muuttuneet, TALLETETAANKO?<br>' +MoFilen;
    //vast := MessageDlg (s, mtInformation, [mbYes,mbNo,mbCancel], 0);
      vsii := InfoDlg (s,  mtWarning, 'Talleta','Ei talletusta','Peru','',  '' ,'','','');
     {case vast of
         mrYes    :LueTalMoFile  (LueFA,KysFA,MoFilen); //<FALSE,FALSE = TALLETTAA,LopTal=FA =EiKysyNimeä +TalNimeä
         mrNo     : ;
         mrCancel :Action := caNone;   end;}
      case vsii of                                                                             //<,,+6.2.2
         1   :LueTalMoFile  (LueFA,KysFA,MoFilen); //<FALSE,FALSE = TALLETTAA,LopTal=FA =EiKysyNimeä +TalNimeä
         2   : ;
         3,9 :Action := caNone;   end;
   end;    //'Vikax luetun käsitellyn nimen talletus aina, jos vaikka eka istunto ja oletustiedot -> Viim-...
 //LueTalFilenReg (4,LueFA,KysFA,MoFilen);                        //<1=Edv  FA=Tallettaa  FA=EiLopTal=TekeeNimenJos''
end;//FormClose

(*procedure ApuLaske;      CONST {Kcu=0.00393;  }Kal=0.00403;  {Kly=0.004;{=Klyijy}
   procedure prc (mm2,Rv,Rn :real{40°C});    VAR R20v,R20n,Ka :real;      begin //Rt = R20[1+Kal(t-20)] = R20 *Ka .
        Ka := 1 + Kal*(40-20);
      R20v := Rv / Ka;
      //Ka := 1 + Kly*(40-20);
      R20n := Rn / Ka;
      if mm2 +R20v +R20n<0  then ;
   end;
begin prc (185, 0.183, 0.183);   prc (120, 0.278, 0.278);   prc (70, 0.479, 0.479);   prc (35, 0.941, 0.941);  end;*)

(*procedure ApuLaske;    //type arrType=array of string;
   function onSamat (arr :array of string{arr :arrType}{Lst :TStringList}) :boolean;      VAR vakS,sa :string;  i :integer;   begin
      vakS := 'qAXMK';   result := false;
      i := High(arr);
      for i := 0 to i-1  do
      if SamIso (vakS,arr[i])  then begin
         result := true;   Break;  end;
begin  OnSamat ('AMCMK3½','AMCMK3½HD');  end; //<Constant can not be as open array arguments,*)

procedure ApuLaske; (*
   function OnYksiSama (si :string{arr :arrType}{Lst :TStringList}) :boolean;      VAR str,vakS,sa :string;
   begin
      vakS := 'qAXMK';   result := false;
      str := si;
      str := Trim (str);
      sa := '';
      while str<>''  do begin
         if NOT (str[1] IN [';',' '])
            then sa := sa +str[1];                               //,Length()<=1 =vikaMrk luettu jo, delautuuKohta.
         if (str[1]=';') or (Length(str)<=1)                     //< ";" on eri mjonojen erotusMrk.
         then begin
            Delete (str,1,1);
            if SamIso (vakS,sa)
            then begin
               result := true;   Break;  end
            else sa := '';
         end//if str[1]
         else Delete (str,1,1);
         str := Trim (str);
      end;//while
      if sa='§!"#¤%>'  then ;
   end; //*)
begin end;
     (*OnYksiSama ('AMCMK3½ ;AMCMK3½HD');
       OnYksiSama ('AMCMK3½ ;AMCMK3½HD ; qAxmk');
       OnYksiSama ('qAxmk');
       OnYksiSama (' qAxmk');
       OnYksiSama ('qAxmk ');
end; //<Constant can not be as open array arguments, *)
//========================================================================================================================================================

procedure TPaaValFrm.FormShow(Sender: TObject);       var polku{,ss} :string;  //i,Handl :integer{1314}; -1414f
                                                          Qdemo,QLicAsnttu{IsLicenseInstalled} :boolean;
   procedure InfoDlgKoe;      begin
      {InfoDlg_ ('Kokeilua', mtInformation, 'OK','','','',  '','','','',
                FALSE,TRUE, '-1;-2;1;2;3',s); //< KopioInfokin,ArvoBxkin}
      {InfoDlg_ ('Kokeilua', mtInformation, 'OK','','','',  '','','','',
                TRUE,FALSE,'-1;-2;1;2;3',s);
      InfoDlg_ ('Kokeilua', mtInformation, 'OK','','','',  'OKselitys','','','',
                TRUE,FALSE,'-1;-2;1;2;3',s);
      InfoDlg_ ('Kokeilua', mtInformation, 'OK','2btn','','',  'OKselitys','2selitys','','',
                TRUE,FALSE,'-1;-2;1;2;3',s);
      InfoDlg_ ('Kokeilua', mtInformation, 'OK','2btn','3btn','',  'OKselitys','2selitys','3selitys','',
                TRUE,FALSE,'-1;-2;1;2;3',s);
      InfoDlg_ ('Kokeilua', mtInformation, 'OK','2btn','3btn','4btn',  'OKselitys','2selitys','3selitys','4selitys',
                TRUE,FALSE,'-1;-2;1;2;3',s);
      InfoDlg_ ('Kokeilua', mtInformation, 'OK','2btn','3btn','4btn',  'OKselitys','2selitys','3selitys','4selitys',
                TRUE,TRUE,'-1;-2;1;2;3',s);
      InfoDlg_ ('Kokeilua', mtInformation, 'OK','','','',  '','','','',
                TRUE,TRUE,'-1;-2;1;2;3',s);//}
   end;
   procedure posAvFrm;      begin                //SyottoAvFrm.Top := 800;  SyottoAvFrm.Left := 800; //<Koe
      if SyottoAvFrm.Width  < 600            then SyottoAvFrm.Width :=  600;     //<Jos AvFrm turhan kapea
    //if SyottoAvFrm.Height > 400            then SyottoAvFrm.Height := 400;     //<Jos AvFrm turhan matala -11.0.0
      if SyottoAvFrm.Width  > Screen.Width   then SyottoAvFrm.Width :=  600;     //<Jos AvFrm liian leveä
    //if SyottoAvFrm.Height > Screen.Height  then SyottoAvFrm.Height := 400;     //<Jos AvFrm liian korkea -11.0.0

      if SyottoAvFrm.Left <0  then SyottoAvFrm.Left := 0;
      if SyottoAvFrm.Top  <0  then SyottoAvFrm.Top :=  0;
      if SyottoAvFrm.Top    +200 > Screen.Height  then SyottoAvFrm.Top := Screen.Height-200; //<Ohi ar:n +11.0.0
      if SyottoAvFrm.Left +SyottoAvFrm.Width > Screen.Width
         then SyottoAvFrm.Left := Screen.Width -SyottoAvFrm.Width;
      if SyottoAvFrm.Height +200 > Screen.Height  then SyottoAvFrm.Height := Screen.Height-200;       //<+11.0.0
      if SyottoAvFrm.Top +SyottoAvFrm.Height > Screen.Height
         then SyottoAvFrm.Top := Screen.Height -SyottoAvFrm.Height;
   end;

   //,,Tarkistaa, onko NolaRek.NOR´rin ja pvityssulkulistan LicEiPvitList (Defs.PAS) -listojen välillä ristiriitaa.
   procedure ChkLisensLista_NolaRek;      //VAR NorFilen :string; //+6.0.4 -12.0.0

      function OnLicEiPvitListassa (LicNo :integer) :boolean;      VAR nja,j,k :integer;      begin
         nja := Length (LicEiPvitList)-1;
         j := -1;
         repeat j := j+1;                //<,,Tatkistetaan onko sulkulistalla.
                k := LicEiPvitList[j];
         until (j=nja) or (LicNo=k);          //<Ulos jos löytyi listasta (no=k) tai vika(j=m)
         result := LicNo=k;
      end;

      procedure ChkNolaRekNor;  //<,,120.4:  KokofFNC uusittu.
            VAR myFile :TIniFile;  SectList :TStringList;  Sect,s,errS,ms :string;  i,no,nja,k,m, YY :integer;
                OnOtsikko,OnOtsikko2 :boolean;

         function fNytVuosi :integer;      VAR sa :string;  k :integer;      begin
             sa := DateTimeToStr (Now);
             k  := Pos(' ',sa);                   //<Väli:  "03.11.2013  10:10:23"
             Delete (sa,k,99);  sa := Trim(sa);
             while (sa<>'') and (Length(sa)>4)  do
                Delete (sa,1,1);                  //<'Delataan ekat mrkt kunnes mja=4.
             SokI(sa,k);
             result := k;
         end;
         function fMtoMs(m :integer) :string;      VAR ms :string;      begin
            case m of
               1   :ms := '001';
               10  :ms := '010';
               11  :ms := '011';
               100 :ms := '100';
               101 :ms := '101';
               111 :ms := '111'; end;
            result := ms;
         end;

      begin//ChkNolaRekNor...................................................
       //if IsDebuggerPresent  then SyottoAvFrm.Visible := false;
       //Windows.Beep (100,500);    //<OK
         OnOtsikko :=  false;
         OnOtsikko2 := false;
DefsFile3('pv 1');
         if fFileExists(NolaRekPFN)  then begin                       //,,Tarkist NolaRek.NOR Lisenssi-paivitys=KYLLA mutta oltava SULKULISTASSA JOS
            SectList := TStringList.Create;                           //  - Pvitysloppunut EdVuonna
            myFile := TIniFile.Create({NorFilen}NolaRekPFN);          //  - Versio=LT  tai
DefsFile3('pv 1');
            myFile.ReadSections (SectList);                           //  - Lisenssi-pvitys=EI
DefsFile3('pv 1');
                                                               //,,,##################################################################
            for i := 1 to SectList.Count-1  do begin           //,,,##################################################################
               m := 0;                                         //<'Käydään kaikki Sectorit [no] läpi NolaRek.NOR´rista.##############
               Sect := SectList[i];                            //'SectList[0] = [Header] tms.
               if SokI (Sect,no)  then begin   //Windows.Beep (5000,100);
                  s := myFile.ReadString (Sect,'Lisenssi-paivitys','');
                  s := AnsiUpperCase(s);
                  if (Pos ('EI',s)>0)  then                          //<Lisenssi-paivitys=EI mutta PUUTTUUko SULKULISTASTA?
                  if NOT OnLicEiPvitListassa(no)
                     then m := 1;
                  s := myFile.ReadString (Sect,'Lisenssi-laajuus','');
                  s := AnsiUpperCase(s);
                  if (Pos ('LT',s)>0)  then                          //<Lisenssi-laajuus=LT mutta PUUTTUUko SULKULISTASTA?
                  if NOT OnLicEiPvitListassa(no)
                     then m := m +10;
                  s := myFile.ReadString (Sect,'PvitysLoppunut','');
                  s := Trim(s);
                  SokI (s,k);
                  YY := fNytVuosi;                                    //<PvitysLoppunut<NOW mutta PUUTTUUko SULKULISTASTA?
                  if (k>0) and (YY>k)  then
                  if NOT OnLicEiPvitListassa(no)
                     then m := m +100;
                  s := myFile.ReadString (Sect,'Kayttolaji','');
                  s := AnsiUpperCase(s);
                  s := Trim(s);

DefsFile3('pv 1');
                  if (m>0) and (s<>'PILOTTI')  then begin
                     if NOT OnOtsikko  then begin
                        DetEvFrm.aRich.Lines.Clear;
                        DetEvFrm.aRich.AddText ('<b>' +LicEiPvitStr +' =</b>' + Ints(Length (LicEiPvitList)-1) +' kpl sulkulistalla.<br>');
                        DetEvFrm.aRich.AddText ('<u>Seur. LicNot <b>puuttuvat Defs/LicEiPvitStr</b>´stä:  (m=) <b>1xx</b> =PvitLoppunut,  '+
                                                '<b>x1x</b> =LT-versio  <b>xx1</b> =Ei PvitSopim</u>:<br>');
                        DetEvFrm.Width := 630;
                        DetEvFrm.Left := Screen.Width -DetEvFrm.Width;
                        SyottoAvFrm.Hide;
                        DetEvFrm.Show;
                     end;
                     OnOtsikko := true;       //Windows.Beep (1000,500);
                     ms := fMtoMs(m);
                     errS := myFile.ReadString (fImrkt0 (Abs (no),1), 'Yritys','') +', ' +
                             myFile.ReadString (fImrkt0 (Abs (no),1), 'Postitoimipaikka','') +'.';
                     errS := 'm=' +ms  +'  <b>' +fImrkt0 (Abs (no),1) +'</b>  ' +errS +'<br>';
                     DetEvFrm.aRich.AddText (errS);
                  end;//if(m>0).. 6U}
               end;//SokI
            end;//for i                     //,Firma := ... =Palautetaan kutsuun vain tässä.........
            //------------------------------------------------------------------------------------------------------------------------
DefsFile3('pv 1');
                                                               //,,,##################################################################
            nja := Length (LicEiPvitList)-1;                   //,,,##################################################################
            for i := 0 to nja  do begin                        //#### Käydään LicEiPvitList läpi ja vrt NolaRek ettei VÄÄRÄÄ ESTOA.###
               m := 0;                                         //,,,##################################################################
               no := LicEiPvitList[i];          //,,, m>0 jos EI SAA OLLA kieltolistassa.#############################################
               Sect := Ints(no);                //,,, Tännehän tullaan VAIN jos (Lic)No on sulkulistassa.#############################
               s := myFile.ReadString (Sect,'Lisenssi-paivitys','');
               s := Trim(AnsiUpperCase(s));
               if (Pos ('KYLLA',s)>0)  then begin                     //<Lisenssi-paivitys=KYLLA ellei PvitLoppunut.
                  s := myFile.ReadString (Sect,'PvitysLoppunut','');
                  s := Trim(s);
                  SokI (s,k);
                  YY := fNytVuosi;
                  if (s='') or (k>0) and (YY<=k)  then                //<Eioo merkitty loppuvaksi <NOW eli loppuu vasta tänä vnna tai seurVuonna tai myöhemmin.
                     m := 1;
               end;
DefsFile3('pv 1');

              {s := myFile.ReadString (Sect,'Lisenssi-laajuus','');
               if (Pos ('LT',s)=0)  then                              //<Lisenssi-laajuus = PRO tms. onOK mutta LT pitää olla kieltolistassa
                  m := m +10;                                         // niinkuin nyt on, koska on tultu tänne.}

               s := myFile.ReadString (Sect,'Kayttolaji','');         //<Pilottikäyttäjillä aina oikeus päivityksiin ja nyt sulkulistalla.
               s := AnsiUpperCase(s);
               if Pos('PILOTTI',s)>0  then
                  m := m +100;
DefsFile3('pv 1');

               if (m>0)  then begin
                  ms := fMtoMs(m);
                  if NOT OnOtsikko
                     then DetEvFrm.aRich.Lines.Clear;
                  if NOT OnOtsikko2  then begin
                     if OnOtsikko  then
                        DetEvFrm.aRich.AddText ('<br>');
                     DetEvFrm.aRich.AddText ('<u>Nämä LicNot <b>VIRHEELLISESTI Defs/LicEiPvitStr</b>´ssä:  (m=) <b>1xx</b> =Pilotti  '+
                                             '<b>x1x</b> =???  <b>xx1</b> =PvitSopON.</u><br>');
                     DetEvFrm.Width := 630;
                     DetEvFrm.Left := Screen.Width -DetEvFrm.Width;
                     SyottoAvFrm.Hide;
                     DetEvFrm.Show;
                     OnOtsikko2 := true;
                  end;//if NOT
DefsFile3('pv 1');
                  errS := myFile.ReadString (fImrkt0 (Abs (no),1), 'Yritys','') +', ' +
                          myFile.ReadString (fImrkt0 (Abs (no),1), 'Postitoimipaikka','') +'.';
                  errS := 'm=' +ms  +'  <b>' +fImrkt0 (Abs (no),1) +'</b>  ' +errS +'<br>';
                  DetEvFrm.aRich.AddText (errS);
               end;//if (m>0) 6U}
            end;//for i
DefsFile3('pv 1');
            if NOT OnOtsikko and NOT OnOtsikko2  then begin
             //Windows.Beep (100,500);
               DetEvFrm.aRich.Lines.Clear;
               DetEvFrm.aRich.AddText ('<b>LicEiPvitStr:</b>  ' +LicEiPvitStr +' =<b>' + Ints(Length (LicEiPvitList)-1) +' kpl.</b><br>');
               DetEvFrm.aRich.AddText ('<br>');
               DetEvFrm.aRich.AddText ('<b>Em. pvitysten sulkuLista läpikäyty NolaRek.NOR´iin vertaillen ja kaikki on synkroonissa =OK.</b><br><br>');
               DetEvFrm.Width := 630;
               with DetEvFrm  do begin
                  PaaValFrm.Left := Screen.Width -PaaValFrm.Width;    //<PaaVal oikReunaan
                  Left := PaaValFrm.Left -Width;  end;                //<..ja DetEv siitä vasemmalle. <'+120.5i
               //DetEvFrm.Left := Screen.Width -DetEvFrm.Width;
               //SyottoAvFrm.Hide; //<-1415: Esti alkutietojen näyn PaaValOnShow´ssa. Siirtty PaaVal valintojen jälkeen, oli ChkLisensLista_NolaRek´ssa.
               if isDeb  then    //<,1415: +Ehto. Jakeluversiossa ei tarvita, tarve vain kehivaiheessa edit LicenssiLtlto pvitLopettaneista.
                  DetEvFrm.Show;
            end;//6U}
            SectList.free;
            myFile.free;

            if fKESKENsumS<>'' then begin                         //<,,+120.5i
               DetEvFrm.aRich.AddText('- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - '+
                                      ' - - - - - - - - - - - - - - - - - - - - - - -<br>');
               DetEvFrm.aRich.AddText(fKESKENsumC +'<br>');
               DetEvFrm.aRich.AddText(fKESKENsumS +'<br>');  end;
            DetEvFrm.aRich.AddText ('<br>');
            DetEvFrm.aRich.AddText (COLOR_SILVER +'<right>Tämän Frm´n asettelu +AvusteFrm.Hide: ks. PaaVal.PAS/PRC ChkLisensLista_NolaRek.</f><br>'); //<''+120.5i
          //fKESKEN('PaaVal'); //+141.1  Ei tuo fKESKENsumS DetEv´hen näkyviin.
            //6U}
         end;//,Tähän latettuna fKESKEN.. tarkistus ei eorki, koska esim.JohtoPAS´iin tehdyt strLisäykset SYNTYVÄT vasta EdvVrkEdi vaiheessa.
        {if isDebuggerPresent and (fKESKENsumS<>'')  then
            InputBox('Jossain on kesken HUOMATUSKOHTIA', 'etsi:', 'fKESKENsumS :='); //+141.1 en saanut vanhaa systeemiä Det../RED päälle.}
      end;//ChkNolaRekNor ''Siirrtty EdvNewFrm.OnShow´hun koska vasta silloin on esim. Johto.PAS´issa fKESKE..-sijoitukset selvillä.

      procedure tutki;      begin
         if {IsDebuggerPresent}fRePunKehi  then begin //+120.45
            ChkNolaRekNor;
            if (KaikkiOikDirN<>'') {or}and fDirectoryExists (KaikkiOikDirN)  then
               ShowMessage ('DEVELOPER1 / PaaVal: Tarkista mahd. globaalit erikoisvapaa-ajot sallivat ohjelmarivit Y_.PAS/'+
                         'fKaikkiOikeudet_1x, KaikkiOikDirN<>'''' nyt tämä hakemisto löytyy: '+KaikkiOikDirN);
                                     //'+11.0.1:  OR muutettu AND´iksi =Sama ehto kuin Y_.PAS´sissa =Sallii kaikki
                                     //  ajot täyslaajuudella, jos vain KaikkiOikDirN<>'' ja se DIRri löytyy.
         end;//if IsDebuggerPresent
      end;//tutki
   begin//ChkLisensLista_NolaRek.....................
      tutki;
   end;//ChkLisensLista_NolaRek

  procedure Koklaa;      {VAR s,p :string;      }begin
{      p := gAjoPath; //+-12.0.05 oli: ExtractFilePath (Application.ExeName);
      s := p +'\..\bin\$(Platform)\$(Config)';//\$(OUTPUTNAME).exe ..\bin\$(OUTPUTNAME)_$(Config).exe&xcopy /E /I /K /Y ..\bin\config ..\bin\$(Platform)\$(Config)\config&xcopy /E /I /K /Y ..\bin\data ..\bin\$(Platform)\$(Config)\data
      ShowMessage (s);}
{                    s := fRmrkt0 (1.345,6,1);
      if s='' then;  s := fRmrkt0 (1.345,6,2);         //StoRD (arvo :Real;  tab,des :Integer;  VAR S :String);
      if s='' then;  s := fRmrkt0 (1.345,6,1);
      if s='' then;  s := fRmrkt0 (1.345,6,0);
      if s='' then;  s := fRmrkt0 (1.351,6,0);
      if s='' then;  s := fRmrkt0 (1.35,6,1);
      if s='' then;  s := fRmrkt0 (1.344,6,2);
      if s='' then;  s := fRmrkt0 (1.3446,7,2);
      if s='' then;  s := fRmrkt0 (1.3456,7,2);
      if s='' then;  s := fRmrkt0 (1.3456,6,2);
      if s='' then;  s := fRmrkt0 (0.000098,1,6); //= 0.000098   rajR=1  desR=8
      if s='' then;  s := fRmrkt0 (0.000098,1,6); //= 0.000098
      if s='' then;  s := fRmrkt0 (0.000098,1,6); //= 0.000098
      if s='' then;  s := fRmrkt0 (0.000098,1,7); //= 0.0000980
      if s='' then;  s := fRmrkt0 (0.000098,1,7); //= 0.0000980
      if s='' then; }
                    {RtoSD (1.345,7,2, s);         //StoRD (arvo :Real;  tab,des :Integer;  VAR S :String);
      if s='' then;  RtoSD (1.345,7,1, s);
      if s='' then;  RtoSD (1.345,7,0, s);
      if s='' then;  RtoSD (1.351,7,0, s);
      if s='' then;  RtoSD (1.35,7,1, s);
      if s='' then;  RtoSD (1.344,7,2, s);
      if s='' then;  RtoSD (1.3446,7,2, s);
      if s='' then;  RtoSD (1.3456,7,2, s);
      if s='' then;  RtoSD (1.3456,7,2, s);}
{
      ar := fMuokDes (12.349,2);                   //fMuokDes (arvo :real;  des :integer)
      if ar>0  then;  ar := fMuokDes (12.349,1);   //= 12.3
      if ar>0  then;  ar := fMuokDes (12.3409,2);  //= 12.34
      if ar>0  then;  ar := fMuokDes (12.3409,3);  //= 12.341
      if ar>0  then;  ar := fMuokDes (12.99,0);    //= 13
      if ar>0  then;  ar := fMuokDes (13.95,0);    //= 14
      if ar>0  then;  ar := fMuokDes (0.000098,6); //= 0.000098
      if ar>0  then;  ar := fMuokDes (0.000098,7); //= 0.0000980 }
                                                //,(1.345,6,2) pitäisi => 1.35-- mutta tulee 1.34 !!!!
(* //Result := {Int}Trunc((Value * A) + 0.5) / A; //< =1.345*100 +0.5 =134.5 +0.5 =135.0 => 1.35
   Result := Value *A;                          //< =>1.345*10  =13.45
   Result := Result + 0.5;                      //< =>13.45+0.5 =13.95
   Result := Int(Result) / A;                   //< =>Int(13.95/10) =1

      if ar>0  then;//*)

(*     //s := 'E:\Projektit XE2\Projektit\NolaKehi\BIN\Win32\Debug\Config\Testiajot.TXT';
       //s := 'E:\Projektit XE2\Tietoa.txt';
         s := 'E:\Projektit XE2\Projektit\NolaKehi\BIN\Win32\Debug\Config\EdicAjo 2012-08-25 02;16;14.RTF';
       //ShellExecute({KoeFrm.Application PaaValFrm.}Handle, PChar(s), nil, nil, SW_SHOW);//<EiOK.
       //,Ilmoittaa: E:\Projektit  Cannot find this file. Please verify path .. =Siis hävittää välilyönninjälkeisen nimen.
       ShellExecute(Handle,'open', 'C:\Program Files\Windows NT\Accessories\wordpad.exe', PChar(s), nil, SW_SHOW);
       //ShellExecute(Handle,'open', 'c:\windows\notepad.exe', PChar(s), nil, SW_SHOW); //=OK. SW_SHOW tai SW_SHOWNORMAL*)
    end;//Koklaa                                                                         //' open pakko olla.

function ifLic :string;      begin result := '';
{$IFNDEF NOLALIS}
   if MyLicense<>NIL  then result := '  øLic=OK'
                      else result := '  øLic=EIOK';
{$ENDIF NOLALIS}
end;//}

   procedure DelaaDefsFileJosEiDebg;      begin end; {'120.5n:  VAR fn :string;      begin
      fn := fDefsFN;
      if NOT IsDebuggerPresent and  FileExists (fn) //and (NOT DirectoryExists (DefsFileenKirjONdn_204))  //Jos DefsFileeseenONb dirri on =haluttiin Defsiin ajo.
         then DeleteFile (fn);                      //'1201: Jos ei ..ONdn, ei voi olla FN´kään koska samassa dirrissä.
   end;}
 (*procedure PutsaaDefFile;      VAR {ff :TextFile;}  fn,sa :string;  LstU,LstA :TStringList;  n :integer;  w :word;      begin//+120.5n
                                  //Nola10.INC´in LaskeLrj -osan arvotulosteista (DefsFileenZ) putsaa muut rivit, jottavois vrtailla UPS-syötön RjPituuslakent.
                                  //1. Ajettava normaalilla DefsFileenKirjONdn_204 -polkunimellä ao. \$DefsFileenZ.txt -file, ks. kohdat "10.INC/LaskeLrj/AnnaZev:"
                                  //2. Muuta DefsFileeseenONd´n -polkuosan eteen "--", eli:  "C:\Projektit XE2\NolaKehi\BIN\--_$DefsFileeseenON-204",
                                  // jolloin vasta sen polun $DefsFileenZ.txt siivotaan muut paitsi ohessa valkatut rvt.  Alp $DefsFileenZ.txt jää koskematta.
                                  // Siivottu $DefsFileenZ.txt uusnimetään => $DefsFileenZ uVrt.txt  ja editoidaan NotePad´iin.
                                  //Vois siivota suoraan toiselle polulle ettei tarttis renaimata "--_$Defs..", mutta jos ei muuteta, kiroittuisi $Defs.. yli.
      fn := gAjoPath +'--' +DefsFileenKirjONdn_203{4} +'\$DefsFileenZ.txt'; //<Siis DirNimi oltava muutettu näin.
      sa := 'DefsFilen siivoamismahis käytössä (DEVELOPER1 koneessa): DefsFile voidaan siivota PaaVal/PutsaaDefFile´ssä, mutta DefsFile PITÄÄ: '+Chr(10) +
            '   1. tehdä NORM.POLULLE '+Chr(10) +
            '   2. ' +DefsFileenKirjONdn_203{4} + 'eteen lisäys "--"  eli .."--' +DefsFileenKirjONdn_203{4} +'",' +Chr(10) +
            '   jolloin TÄHÄN polkuun tehdään siivottu "$DefsFileenZ uVrt.txt" -file.' +Chr(10)+Chr(10);
      if fFileExists(fn)  then sa := sa +'Siivotaanko DefsFile=[Yes],  ei siivota =[No]'
                          else sa := sa +'Ei ole vielä siivottavaa DefsFileä, ohitetaan tämä =[OK]';

      if fFileExists(fn)
         then w := MessageDlg(sa,mtInformation,[mbNo,mbYes],0)
         else w := MessageDlg(sa,mtInformation,[mbOK],0);
      if w=mrYes  then begin
       //ShowMessage('DefsFilen siivoaminen käytössä (DEVELOPER1 koneessa), File= ' +fn);
     {OpenDlg.FileName := fn;
      if NOT FileExists(fn)  then
      if OpenDlg.Execute then begin
         OpenDlg.Title := 'Eioo fileä "' +fn +'"';
         if FileExists(OpenDlg.FileName)  then begin
            fn := OpenDlg.FileName;}
            LstA := TStringList.Create;          //<Tähän luetaan ff.
            LstU := TStringList.Create;          //<Tähän putsataan turhat rivit, jää vain valitut.
            LstA.LoadFromFile(fn);
            n := 0;
            while n<LstA.Count-1  do begin
               if (Pos('10.INC/LaskeLrj/AnnaZev:', LstA.Strings[n]) >0) OR
                  (Pos('UPS', LstA.Strings[n]) >0)
                  then LstU.Add(LstA.Strings[n]);
               n := n+1;  end;
            fn := ChangeFileExt(fn,' uVrt.txt');    //<Muutetaan nimen loppuosa jotta alp säästyisi.
            LstU.SaveToFile(fn);
            LstU.Free;
            LstA.Free;
            ShellExecute(Handle,'open', 'c:\windows\notepad.exe', PChar(fn), nil, SW_SHOW); //=OK. SW_SHOW tai SW_SHOWNORMAL
       //end;
      end;
   end;//PutsaaDefFile*)

  {procedure WrAjoleima;      VAR ff :TextFile; FN :string;      begin//<,,+120.5no  Koe josko ei tulisi Invalid floating point.. erroria. Ei riitä
      FN := gAjoPath +'__Ajotieto.txt';
      AssignFile(ff,FN);
      Rewrite(ff);
      Writeln(ff,'Ajoaika: ' +DateTimeToStr(now));
      CloseFile(ff);
   end;}(*
   procedure  LueOsKrj;     VAR f0 :TextFile;  sU,fnU, s0,fn0 :string;  Lst :TStringList;  u :integer;  begin //Testataan vain Thunderbirdin osoitekirjariviä
      fn0 := gAjoPath +'_KoeOsKrj.txt';             //C:\Projektit XE2\NolaKehi\BIN\..             // joka on otettu cut +copyna KAIKISTA riveistä, joista
      fnU := gAjoPath +'_OsKrjRiviToRvt.txt';       //<Tähän muokataan yksi rivinen monirvseksi.   // joka on otettu cut +copyna KAIKISTA riveistä, joista
      AssignFile(f0,fn0);                                                                          // tulee vain yksi rivi >, ´lla erotettuna kukin itemi.
      if fFileExists (fn0)  then begin
         Reset(f0);
         Lst := TStringList.Create;
         while NOT Eof(f0)  do begin
            Readln(f0,s0);  sa := '';               //,,'affe' <alf.krogell@gmail.com>,Etteplan
            while NOT Eoln(f0) do begin
               u := Pos('>,',s0);
               if u>0  then begin
                  sU := Copy(s0,1,u+1);
                  Delete(s0,1,u+1);
                  Lst.Add(sU);  end;
               if s0<>'x'  then;
            end;//while
         end;//while
         CloseFile(f0);
         Lst.SaveToFile(fnU);
         Lst.Free;
      end;//if FileExists
   end;//}
*)

//KESKEN KESKEN 1415c
//http://stackoverflow.com/questions/14938570/how-do-i-programmatically-check-modify-permissions
//I have been using NT Utilities for this. Worked very well for me with Win2K/XP/Vista/7

{uses unitNTSecurity;

function CheckAccessToFile(DesiredAccess: DWORD; const FileOrDirName: string; ObjectName: string): Boolean;
var
  fo: TNTFileObject;
  acl: TAccessControlList;
  ace: TAccessControlElement;
  name: string;
  i: integer;
begin
  Result := False;
  if FileExists(FileOrDirName) or DirectoryExists(FileOrDirName) then
  begin
    fo := TNTFileObject.Create(FileOrDirName);
    acl := TAccessControlList.Create;
    try
      fo.GetDiscretionaryAccessList(acl);
      for i := 0 to acl.ElementCount - 1 do
      begin
        ace := acl.Element[i];
        name := ace.Name; // format is: BUILTIN\Users
        if (CompareText(ObjectName, name) = 0) and
          (ace.Type_ = aeAccessAllowed) and
          (DesiredAccess = ace.Mask) then
        begin
          Result := True;
          Break;
        end;
      end;
    finally
      fo.Free;
      acl.Free;
    end;
  end;
end;

//,Kutsu:
Result := CheckAccessToFile($001301BF, 'C:\foo', 'BUILTIN\Users'); }

{procedure wrTest;   VAR ff :TextFile;  fn :string;   begin
   AssignFile(ff,fn);
   fn := 'C:\inetpub\temp\appPools\RePuTest.txt';
   //Rewrite(ff);              //<I/O error 105= File not open for output.
   //Writeln(ff,'DEVELOPER1-rivi');
   CloseFile(ff);
end;//}

   procedure DelaaAjoFileChkListatTMP;   LABEL 1;  VAR LstP :TStringList;
                                                   SR :TSearchRec;  Dir :string;  nn :integer; //<,,+1414f: ..Config\EdvNimet.txt filen parsinnan apufileiden
      procedure KillNotePad;      VAR MyHandle: THandle;   begin //http://www.tek-tips.com/viewthread.cfm?qid=1274357
         MyHandle:=FindWindow(nil, 'NotePAD.EXE');
         SendMessage(MyHandle, WM_CLOSE, 0, 0);
      end;//KillNotePad
      function OKfileSR(oh :integer) :boolean;      VAR xs,SA :string;  m :integer;            //           tarkistusten ja korjailujen jälkihoitoa.

         function f_EdvNjMo(Sv :string) :boolean;      begin  result := true;
            if Pos('EDVNIMET',Sv) >0  then SA := Dir +'EdvNimet.txt' else
            if Pos('NJNIMET' ,Sv) >0  then SA := Dir +'NjNimet.txt'  else
            if Pos('MONIMET' ,Sv) >0  then SA := Dir +'MoNimet.txt'  else begin
               SA :='';  result := false;  end
         end;
      begin//OKfileSR...........................
         result := oh=0;                        //<Kutsun OH>0 vaihtuu  FindNext´illä, jolloin vaihdetaan BIN hakemistoon, ks. while..,,
         if (SR.Attr<>faDirectory) and          //<,,Vain muut kuin DIRrit OK.
            (SR.Name<>'.') and (SR.Name<>'..')  then begin  //Application.ProcessMessages; ???
{0>}        xs := Iso(Dir +SR.Name);
{======,,}  if Pos('~.TMP',xs) >0  then begin   //<VAIN NÄMÄLOPPUISET FILE KÄSITELLÄÄN.§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
               if Pos('-OK~.TMP',xs) >0         //<,,KAIKKI FileLstN.PAS´issa tehdyt filet ovat näitä varten tehty (_OK~.TMP).
{1>}           then begin                       // '-OK~.TMP' pätee BIB\Congig´iin ja \BIN´iin.
                  if f_EdvNjMo(xs)
                  then begin
                     CopyFile(PChar(xs),PChar(SA),false);
                     DeleteFile(xs);  end
                  else begin//<,,Tähän EI VISSIIN KOSKAAN JOUDUTA!!!!!
{2>}                 m := InfoDlg ('<b>Käyttötarkoitus ei selvinnyt!</b' +Chr(10) +
                                   '[1]=EdvNimet.txt  [2]=NjNimet.txt  [3]=MoNimet.txt ?' +Chr(10)+
                                   '     EdeltväVerk.   Nousujoh.Verk.  Moottorijoh.Verk.'+Chr(10),
                                   mtCustom,  '1','2','3','',  '','','','');
                     if m IN [1..3]  then
                        CopyFile(PChar(xs),PChar(SA),false);
{<2}                 DeleteFile(xs);
                  end;//if f_EdvNj.. else
{<1}           end else//if Pos('-OK~.TMP)
               if Pos('-LSTOUT~.TMP',xs) >0     //,LstOut~.tmp säilytettävä, siinähän on virhelistaus jos vaikka halutaan sitä manipuloida.
               then begin                       //<,,\BIN\$_$Err-LstOut~.tmp  ja ..\$¨$Err-Nj~.tmp mutta tätä vikaa ei tarvita.
{3>}            //1414f: Siirretty FrmShow´sta:,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                  if FileOnEiEmpty(LstOutErrFn)  then begin               //<,''Siirtty FileLstN.PAS´ista ettei kutsuisi kuin kerran.
{4>}                  if isDeb  then DetEvFrm.Hide;                       //<+1414f ettei peitä debugissa BreakPointeja.
                                                                          //¶?'%ProgramFiles%\Windows NT\Accessories\WORDPAD.EXE.??? ei worki'}
                      ShellApi.ShellExecute(Application.Handle,'open', 'C:\Windows\NotePAD.EXE', PChar(LstOutErrFn), nil, SW_SHOW); //=OK. SW_SHOW tai SW_SHOWNORMAL.
                    //KillNotePad; //+1414fu: Ei worki, pitäis olla jonkinlainen tauko välissä.
                  //ei ShellApi.ShellExecute({Application.Handle}Handl{0},'open', '%ProgramFiles%\Windows NT\Accessories\WORDPAD.EXE.', PChar(LstOutErrFn), nil, SW_SHOW); //=OK. SW_SHOW tai SW_SHOWNORMAL.
                  //ok ShellApi.ShellExecute(Application.Handle,'open', 'C:\Program Files\Windows NT\Accessories\Wordpad.exe', PChar(LstOutErrFn), nil, SW_SHOW); //=OK. SW_SHOW tai SW_SHOWNORMAL.
                      //ShowMessage('Muista sulkea Notepad!');//, sen jälkeen tiedosto " ' +LstOutErrFn +' " poistetaan.');
                      SA := LstOutErrFn;  m := Pos('~.TMP',Iso(SA));  //ChangeFileExt(SA,'.ERR');  //Ei onaa, kumma.
                      if m>0  then begin
                         Delete(SA,m,9);  SA := SA +'~.ERR';  end; //Vaihdetaan tunnisteosa ja edMrkt =korvaa ChangeFileExt´in.}
                      m := InfoDlg ('<b>M u i s t a   s u l k e a   N o t e p a d !</b>' +Chr(10) +
                                    'Poistetaanko virheellisten ajotiedostojen lista (tiedosto) vai säilytetäänkö se mahd. myöh. käyttöön (ERR tunnisteella):  '+
                                    '[ ' +SA +' ] ?',  mtCustom,  'Säilytä','Poista','','',  '','','','');
                      if m=2  then begin                       //<'1=Säilytä  2=Poista  X=9,
                         DeleteFile(LstOutErrFn);              //<Mutta jos aikaisKrrlla on trhty/jäänyt ..~.ERR -file, se säilyy edelleen.
                         if FileOnEiEmpty(LstOutErrFn)  then
                            ShowMessage('Tiedosto:  " ' +LstOutErrFn +' " ei delautunut, poista se käsin, muuten se ehkä kasvaa isoksi.');
                      end else
                      if FileOnEiEmpty(LstOutErrFn)  then  begin
                         LstP := TStringList.Create;
                         LstP.LoadFromFile(LstOutErrFn);   //<'$_$Err-LstOut~.tmp'
                         LstP.SaveToFile(SA);              //<E I  M I S S Ä Ä N  N I M E S S Ä saa jättää alpNimiseksi: SIIHEN summataan seurt virheet.
                         DeleteFile(LstOutErrFn);          //,,ja ALP delataan ettei jäisi kumuloitavaksi.
                         LstP.Free;
                      end;
{<4}              end//if FileOn..
{<3}           end//Pos('-LSTOUT~.TMP'
               else DeleteFile(xs); //<..\$¨$Err-Nj~.tmp  tai Configin tarpeettomat, nimeämättömät.
            end;//if Pos('~.TMP'..
{<0}     end;//if (SR.Attr ..
      end;//OKfileSR
   begin//DelaaAjoFileChkListatTMP...................
      if isDeb  then DetEvFrm.Hide;                  //<+1414f ettei peitä debugissa BreakPointeja, vaikka eihän DetEvFrm tule näkyviin tässä jakVersiossa.
      Dir := ExtractFilePath (Application.ExeName);
      Dir := Dir +'Config\';
   1: nn := FindFirst(Dir +'*.*',faAnyFile,SR);
      if SR.Name<>''  then ;
      if (nn=0)  then                                //C:\Projektit XE2\NolaKehi\BIN\Config\$_$Err-..-Out~.tmp  tms.
      while OKfileSR(nn)  do begin                   //C:\Projektit XE2\NolaKehi\BIN\$¨$Err-Nj~.tmp
         nn := FindNext (SR);
         if (nn>0) and (Pos(Iso('Config'),Iso(Dir)) >0)  then begin//<,Config´in jälkeen nn>0 => NOLA(BIN),,-dirriin.
            Dir := ExtractFilePath (Application.ExeName);          //<..NOLA(BIN)-dirriin.
            GOTO 1;  end;
      end;//while
//    if isDeb  then DetEvFrm.Visible := true; //<-1415eU
   end;//DelaaAjoFileChkListatTMP

(*Siirtty aiemmaksi 1415f. Ei onannut.*)
   procedure Kysy_203_DebWr_RvYlitInfo;      begin
      ChkYliRvtDebWrInfo('PaaVal',DebWrCnt); //<+1415f: Siellä ajon keskeytys valittavissa.
   end;//Kysy_203_DebWr_RvYlitInfo*)

begin//FormShow...........................................................................................................
//wrTest;
{if FileExists('C:\inetpub\temp\appPools\APC19B2.tmp')   //Ei onaa delaus jos ei premissions.. ,,
   then beep;
ShowMessage('Delataan: C:\inetpub\temp\appPools\APC19B2.tmp');
sysutils.DeleteFile('C:\inetpub\temp\appPools\APC19B2.tmp');
if NOT FileExists('C:\inetpub\temp\appPools\APC19B2.tmp')
   then beep; }
   //if fRePunKehi  then PutsaaDefFile; //<,+120.5/6U
                                                    //¿DefsFileenZ('PaaVal: 00:  gAjoPath=' +gAjoPath +CR +' ®® gAjoConfPath=' +gAjoConfPath +' <<<<<<<<<<<<<<<<<' +ifLic);
                                                    //¿DefsFile3('pv 1');
                                                    YFileen('¿PaaVal FormShow 00');
  {if isDebuggerPresent  then begin                 //<+1412: SyottoFrm kulunSeurantaan. ,,NolaVAR.INC. ..Koska filennKirj sotki SyottoFrm.PAS + Johdot.PAS´ssa.
      YLst := TStringList.Create;                   // YLst.Free ilmeisesti tarpeeton}
      YLstFN := ExtractFilePath(Application.ExeName); //<'Nyt muutettu Defs´iin Append ..kuvioihin.
      YLstFN := YLstFN +'_EditSyoFrm-jälkiä.txt';
 //end;
 //WrAjoleima;                                      //<+120.5no
 //LueOsKrj;                                          //<+141.1
if Chk64B_ohitus  then                   //,,Debugatessa AINA Application.ExeName=Nola.exe, ei siis 32 tai 64.  := TR/FA
   if (Pos('32',Application.ExeName) >0) //...............................''''''''''''''''.................................
   then ShowMessage ('Chk64/32B ohjailu ohitettu, ajo 32B, toiminta epävarmaa, ilmoita valmistajalle.')
   else if (Pos('64',Application.ExeName) >0)
        then ShowMessage ('Chk64/32B ohjailu ohitettu, ajo 64B, toiminta epävarmaa, ilmoita valmistajalle.')
        else ShowMessage ('Chk64/32B ohjailu ohitettu, ilmoita valmistajalle.');                            //<''''''''''''''''''''''+120.4
                                                    DefsFile3('pv 2');
YFileen ('FrmShw 0');
Koklaa;
                                                    DefsFile3('pv 3');
  if fWnd  then begin                                             //<,,+12å11b
                PaaValRaa.Caption := PaaValRaa.Caption +' (fWnd)testi.';
                PaaValRaa.Font.Color := clFuchsia;  end
           else PaaValRaa.Font.Color := clBlue;
  PaaValRaa.Font.Color := clBlue; //<+1414. Paha mennä fWnd´iä muuttamaan tässä, vaikutus pitäisi tutkia perusteellisesti. Ei vaan worki !?!?
//LoadStringResource;  //<+12å8=12.0.0:  Otinkin TextBase´n käyttöön.
                                                    DefsFile3('pv 4');
  //if {IsDebuggerPresent} fRePunKehi  then KirjoitaTestiKerta; //<12.0.0:  Siirrtty LueTal/ Lue´sta.  120.45: Siirrtty Def.PAS´iin.
               { if IsDebuggerPresent  then
                 if IsWindows64   then ShowMessage ('Win on 64 bittinen (Win7..).') else ..}

               //Uusi TextBase.NOL on jo syntynyt tähän tultaessa jos EDELLINEN oli ennen ajon käynnistymistä delattu.
               //'Delaustiedustelu, ks. Globals / PRC KysyTxtBaseNOLjaDelaa;
                                                    //¿DefsFileenZ('PaaVal: x1:' +ifLic);
                                                    YFileen('¿PaaVal: x1:');
{TicsY := 0;
Tics0 := Time;}
{%  DEFINE TstAjo} //<Tässä ollessaan herja workkii, mutta muualla sorcassa kääntäminen tai ajo ei herätä herjaa.
                   //,,Ei worki.  9.0.1
   {$IFDEF TstAjo} //<Kun jossain kohtaa koodissa esitelty:  {%DEFINE -stAjo}, missä % on KORVATTU TAALAN $
                   // MERKILLÄ, tässä tulee herja.           '##############' =Etsittävissä -"stAjo"
    //if NOT IsDebuggerPresent  then ??? toimisikohan ???
     {InfoDlg  ('Def)  Kokeilunaikainen toiminta poistamatta jakeluversiosta, toiminta ei ehkä vastaa lopullista '+
                'tarkoitusta:  <b>Find "TstAjo"[word] In Files ..</b>, jatketaan.',mtWarning,
                'OK','','','', '','','',''); //'Ei worki}
   {$ENDIF}
                                                    //¿DefsFileenZ('PaaVal: x2:' +ifLic);
                                                    YFileen('¿PaaVal x2:');
ApuLaske; //<11.0.1:  R20°C=f(SLYn_R40°C)
{if myRegSettings.GetStringValue( Settings_Used, '')='1'
   then bep; }
 //ChkTestiAjo; //<Koska ed. IFDEF .. ei worki, on vanha systeemi vielä käytössä.
                                                    //¿DefsFileenZ('PaaVal: x3:' +ifLic);
                                                    //¿DefsFile3('pv 5');
                                                    YFileen('PaaVal x3:');
   DesignInfoLabel.visible := false; //< +4.0.0 KAI: Komponettia käytetään vain näytön suunnittelu-
                                     //              aikaisen leveyden tutkimiseen. Tarvitaan
                                     //              asettamaan myDesignInfo muuttujan arvo.
   AvuChkSft (20);                   //<Avuste on +6.0.0  Uuskäyttäjillä ehkei ole muuten oletuksena. //æ SYYPÄÄ sekoi8luun.
                                    {Tics ('PaaValShw/SamIso');  //,,Näissä ei vielä CONST str.
                                     for i := 1 to 500000 do
                                        if SamIso ('MMJ/MMK*','AMCMK3½½')  then ; //=1142 ms, sama jos PRC doit
                                     Tics ('PaaValShw/SamVrt');
                                     for i := 1 to 500000 do
                                        if 'MMJ/MMK*'='AMCMK3½½'  then ;          //=0 ms
                                     Tics ('PaaValShw/SamVrtFNC');
                                     for i := 1 to 500000 do
                                        if samaVrt('MMJ/MMK*','AMCMK3½½')  then ; //=40 ms'''''''''''''''''''''''}
  {Tämä oltava jos ALP FileLuku..
   if NOT alustettu  then  //<,,Alustettu TPaaValFrm.Create´ssa, mutta vasta tässä merkataaan. -120.5n
      alustettu := true;//}
   VerLbl.Caption := 'Versio  '+fImrkt0 (PROGRAM_VERSION_MAJOR,1)   +'.' +
                                fImrkt0 (PROGRAM_VERSION_MINOR,1)   +'.' +
                                fImrkt0 (PROGRAM_VERSION_RELEASE,1) +'      '+PROGRAM_BUILD_DATE;
                                                 //¿DefsFileenZ('PaaVal: x4:' +ifLic);
                                                 //¿DefsFile3('pv 6');
                                                 YFileen('PaaVal x4:');
YFileen ('FrmShw 2');
   InfoDlgKoe;
                                                 //¿DefsFile3('pv 7');

   SijLicEiPvitList;                 //<Siirretään sulkulistaCONST array´hyn.                     <+6.2.2  -10.0.2  +12.0.03
   if FileLukuVirhe<>''  then                                     //<File..Virhe := FileEv.INC:ssa +6.2.2
      InfoDlg (FileLukuVirhe, mtInformation, 'OK','','','',  '','','','');     //<'-11.0.1 siirrtty EdvFileLukuun.

YFileen ('FrmShw 3');
   if LisYliDemo_ (lvLT)  then //and NOT SalaSallii (lvLT)        =NOT Sala... =AsetusFrm.SalaEdi ei vielä OK.
      a_putReaa (4, 0.4, edv.YLE.PRaika);                     //<'=LT-versioon PRajaksi 0.4 s.   <,,+8.0.0
                   {LisYliDemo_ kutsuu:  FNC Demö / AnsiUpperCase (AsetusFrm.SalaEdi.Text)  ja AsetusFrm refe-
                    renssit aiheuttaa "Acces violation..." virheilmoituksen, koska Frm´ia ei vielä oltu luotu.
                    Tämän takia tämä testi ja sijoitus on siirretty FileEv.INC´stä tähän, missä luonnit valmiit.
                                                     Luonnin ajoittumisesta aikaisemmaksi kuin koodi edellyttää
                                                     aiheuttaa muuallakin ongelmia. Ne löytyy haulla "§LUO§"}
   Edi := 1;                         //<Testejä varten (koska testatessa ei lueta Edv)!!!!!!!!!!!!!!
                                                    //¿DefsFileenZ('PaaVal: x5:' +ifLic);
                                                    YFileen('PaaVal x5:');
Tics ('PaaValShw/TeeKtlk');
                                                    YFileen('FrmShw 31');
   TeeKtlk;                          //<Tekee korjauskerrointlkn +5.0.0
Tics ('PaaValShw/LaskeEdv 0');
                                                    YFileen('FrmShw 32 LaskEdv');
                                                    DefsFile3('pv 8 LaskEdv');
   //,Tämä aiheuttaa "Invalid floating point error" -virheilmoituksen, siellä sisäisten säikeitten hidastamiseksi fileenkirjoitus +sen delaus.#############
//£$£-1412  LaskeEdvArvotOK (1); //<Pakko jo tässä: esim. Moottorilähtöjen noususul.lask:ssa tarvitaan suCse -tietoa mm. UUSI TIETO 120.5n: Eioo säikeistä kysymys.
Tics ('PaaValShw/LaskeEdv 1');
                                                    YFileen('FrmShw 4');
                                                    DefsFile3('pv 9');
   polku := myRegSettings.GetStringValue(SETTINGS_USED, PROGRAM_DIR_ID);         //<+201 DEVELOPER1 Nola.EXE +203  Pitäisiköhän ,,näihinkin laittaa := gAjoPath +..
  {Caption := Caption +':  '+AnsiLowerCase(polku);                               //<+201 DEVELOPER1 -203           '+130.0}
   polku := polku +'Config\License\NUL';
{$IFNDEF NOLALIS}
                                                    //¿DefsFileenZ('PaaVal: x6:' +ifLic);
                                                    YFileen('PaaVal x6:');
   if NOT mylicense.paikallinenLisenssi  then
      Caption := Caption +'                    [ VERKKOversio ]';

 //{µ} lvEXTok := myLicense.lisenssilaajuus >=lvEXTended; //<,120.5n+:  TR jos lvEXTended tai lvGLOB.  130.0:  Nyt sijoitus Globals´issa.
   {µ} LicAsttuOK := myLicense.IsLicenseInstalled;        //<'LIIAN MYÖHÄÄN, FILE ON JO LUETTU JA NIISSÄ OLISI TARVITTU NÄITÄ.
{$ENDIF NOLALIS}
                                                    //¿DefsFileenZ('PaaVal: x7:' +ifLic);
                                                    YFileen('PaaVal x7:');
   OhjeEfect_OFF;                                //< +2.0.5
                                                    YFileen('FrmShw 5');
       {lvEXTok := myLicense.lisenssilaajuus >=lvEXTended; //<,120.5n+:  TR jos lvEXTended tai lvGLOB.
        LicAsttuOK := myLicense.IsLicenseInstalled;}

   //,Tämä aiheuttaa "Invalid floating point error" -virheilmoituksen, siellä sisäisten säikeitten hidastamiseksi fileenkirjoitus +sen delaus.#############
// LaskeEdvArvotOK (1); //<Pakko jo tässä: esim. Moottorilähtöjen noususul.lask:ssa tarvitaan suCse -tietoa mm.
//'-130.0:  Poistettu 2. kutsu, vrt.25 rv ylempnä.




   edNo := {a_getIntg (10,}edv.YLE.JohtoOsia.ArvoInt +1;  //< +4.0.0
   PaaValFrm.Timer2.Enabled := false;            //< +2.0.5  Ekax vex, muuten Error
   //OhjeEfect_ON;                               //< +2.0.5  Tässä koekäytössä                     ,Muutos 4.0.4
// if demoLisAs  then with SyottoAvFrm  do begin //< +2.0.5  nyt demoLisAs :ssa alkuperäinen ehto: Demö & NOTlisAs
                                                    YFileen('FrmShw 5b');
   with SyottoAvFrm  do
   if demoLisAs                    //,12.0.01: Demo= LT ja yritysPROajoon tms,  LisAsennettu = mylicense.IsLicenseInstalled; (/Y_.pas)
   then begin                      //< +2.0.5  Nyt demoLisAs :ssa alkuperäinen ehto: Demö & NOTlisAs.
                                                    YFileen('FrmShw 5c');
                                                    //¿DefsFileenZ('PaaVal: x8:' +ifLic);
      OhjeEfect_ON;                              //< +2.0.5
    //LbTilausInfo.Visible := true;              //< -4.0.4
      LbTilausInfo.Caption := 'Sopimus- ja tilaustiedot :  Asetukset/TilausLomake';       //< +4.0.4
      InfoNap.Font.Style := [fsBold];            //<,+12.0.0
      AsetNap.Font.Style := [fsBold];
      Screen.Cursor := crHourglass;
       {TabNo := 0;                              //< +5.0.0  0=Ohjataan OHJELMARAJOITUSTIETOIHIN. 12.0.0. //1415: DemoLisAs ohittaa tämän siirtty alemksi.
        avuste (0,99,0,0);                       //< Sinne lisätty [99] :lle := wsMaximized = 4.0.0}
      Screen.Cursor := crDefault;  end           //wsMinimized, wsMaximized
   else begin
                                                    YFileen('FrmShw 5e');
                                                    //¿DefsFileenZ('PaaVal: x9:' +ifLic);
                                                    //¿DefsFile3('pv 10');
      LbTilausInfo.Caption := '';                //< +4.0.4
      InfoNap.Font.Style := [];                  //< +12,.0.0  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      if LisAsennettu  then                      //<,+12,.0.0
      AsetNap.Font.Style := [];
      TabNo := 1;                                //< +5.0.0  =Ohjataan VERSIOMUUTOSTIETOIHIN. 12.0.0
//      InfoNapMouseDown(Sender,mbLeft,[], 0,0);   //<,+6.0.0  =Nyt ohjataan MUUTOSikkuna/Avuste'''NÄKYVIIN.!!!!!!!!!!!!!!!  -1415: Ei vielä tarvetta.
                              //Caption := 'w' +IntToStr (SyottoAvFrm.Width) +' h' +IntToStr (SyottoAvFrm.Height);
                                                    YFileen('FrmShw 5f');
      posAvFrm;   end;                           //          Sijoitetaan SyottoAvFrm näkyviin jos piilossa.
 //TabNo := 0;                              //< +5.0.0  0=Ohjataan OHJELMARAJOITUSTIETOIHIN. 12.0.0. //1415: DemoLisAs ohittaa tämän siirtty alemksi.
   avuste (0,99,0,0);                       //< Sinne lisätty [99] :lle := wsMaximized = 4.0.0}      //<'-1415eU?
                                                    //¿DefsFile3('pv 11');
                                                    YFileen('FrmShw 6');
// DEVELOPER2 2003-10-26 BEGIN
//   if Demo  or {mylicense.status IN [lsTyhja,lsViallinen] ) }   //<,,+ DEVELOPER1 1.1.6
 //if demo or not myLicense.IsLicenseInstalled                    //< -10.0.6
                                                    YFileen('FrmShw 7');
                              //¿DefsFileenZ('PaaVal: 01:  gAjoPath=' +gAjoPath +CR +' ®® gAjoConfPath=' +gAjoConfPath +'  TextBaseFN=' +TextBaseFileN +
                              //¿            CR +'LicLaajS=' +LicLaajS+' ®® LisStat=' +MyLicStatusText +' ®® LicNroS=' +LicNroS +ifLic);
//Nola:     DEBUG/RELEASE;
//NolaNet:  DEBUG/RELEASE;NOLALIS
//NolaRek:  DEBUG/RELEASE;
{$IFNDEF NOLALIS}             //NOLALIS on asetettu VAIN NolaNet + NolaRek´lle, joten myLicense := suoritettu VAIN Nola.EXE´lle.<<<<<<<<<<<<<<<<<<<<<<<<<<<
                              //¿DefsFileenZ('PaaVal: 02:  gAjoPath=' +gAjoPath +CR +' ®® gAjoConfPath=' +gAjoConfPath +'  TextBaseFN=' +TextBaseFileN +
                              //¿            CR +'LicLaajS=' +LicLaajS+' ®® LisStat=' +MyLicStatusText +' ®® LicNroS=' +LicNroS +ifLic);
   Qdemo := demo(73);   QLicAsnttu := myLicense.IsLicenseInstalled;   //<,+10.0.6
   if QLicAsnttu  then ; //<+1415e.
{$ENDIF NOLALIS}
                                                    YFileen('FrmShw 8');
   if Qdemo  or NOT QLicAsnttu                                    //<12.0.0: +NOT.  120.6: Might not have been initz (QDemo QLic..
// DEVELOPER2 2003-10-26 END
   then begin
        AsetNap.Font.Style := [fsBold];
   {$IFNDEF NOLALIS}
                              //¿DefsFileenZ('PaaVal: 11:  gAjoPath=' +gAjoPath +CR +' ®® gAjoConfPath=' +gAjoConfPath +'  TextBaseFN=' +TextBaseFileN +
                              //¿            CR +'LicLaajS=' +LicLaajS+' ®® LisStat=' +MyLicStatusText +' ®® LicNroS=' +LicNroS +ifLic);
        if OnPvitysEstoListassa  then
         //EiOkInfo (myTextBase.Get (LICENSE_STATUS_8) +'. Toimii esittelyversiona. [PaaVal]');  end //<-,+10.0.6
           EiOkInfo ('Lisenssi n:o ' +IntToStr (myLicense.LisenssiNumero) +' ei päivityskäyttöön, huomioitava '+
                     'käännöslistassa. Toimii esittelyversiona. [PaaVal.PAS/FormShow]');
   {$ENDIF NOLALIS}
   end
   else AsetNap.Font.Style := [];
                              //¿DefsFileenZ('PaaVal: 12:  gAjoPath=' +gAjoPath +CR +' ®® gAjoConfPath=' +gAjoConfPath +'  TextBaseFN=' +TextBaseFileN +
                              //¿            CR +'LicLaajS=' +LicLaajS+' ®® LisStat=' +MyLicStatusText +' ®® LicNroS=' +LicNroS +ifLic);
                                                    YFileen('FrmShw 9');
   ChkLisensLista_NolaRek; //<+6.0.4
Tics ('PaaValShw 9 ==============');
//   LueKirjRTF;
{                         NjLaskentaNapClick(Sender);     //<,Koekäytössä LIITTYMÄTIETOJEN syötön virittelyssä
                          syoKut := 1;
                          editSyoFrm;//}
{EiOkInfo ('Poista PaaVal.PAS rivin 133 kommentti ja nämä r. 393-396');
Polku := '2.200';
if SokR (Polku,r)  then Caption := Polku +'  '+fRmrkt0 (r,1,2) +'  =OK'
                   else Caption := Polku +'  Ei OK';}
//KoePaaFrm.Show;                    //< +5.0.0 Hyvä kokeillessa SYMBOL -merkistöjen tulostumista yms.############

                                                    YFileen('FrmShw 10');
   ChkLaajuusLbl;
   if HerjaY_S<>''  then begin       //<Tyhjättiin + sij. Y_.INC:ssä jos NolaNet.EXE eiPäällä, demo tms. +10.0.5
             {o := InfoDlg_ (InfoStr,Symbol, BtnOts1,BtnOts2,BtnOts3,BtnOts4, BtnInfo1,BtnInfo2,BtnInfo3,BtnInfo4,
                              TRUE,          FALSE,   ''??,  ss);         }
                            //'KopioInfokin 'FA =Arvokin     ss=VAR PudStr
             {              //'KopioInfokin="Leikkaa ja kopioi ... info '''''':n itemErottimena ";"
                            //              'Arvokin=Pud.valikko(PudStr) + arvoBoxi tulee + VAR Arvo palautetaan }
      Bep;                                                                      //,Tässä InfoDlg jo toimii, OK.
                                                    YFileen('FrmShw 11');
      InfoDlg (HerjaY_S, mtCustom,  'OK','','','',  '','','','');  end;         //<Kutsuu InfoDlg_.ShowModal muutenkin.
   //LicNum_NollatToVii;                                                        //<+12.0.06, -12.0.06: Nyt KayKr1 := Ei lisenssiä..
   DelaaDefsFileJosEiDebg;
   Application.Icon.LoadFromFile(gAjoConfPath +'Nola_Icon.ico');
  {SyottoAvFrm.Hide;  }DetEvFrm.Hide; //<+1414fu
DebWr(-1,'',''); //<-1(+1415d)=Tekee filen loppuun yhteenvedon DebWr-kutsuista.
 //DetEvFrm.Visible := true;          //<+1414fu
   if NOT isDeb                       //<,+1415 (=1414fu) En osannut muuten saada näkymättömäksi. Deb´ssa ehkä tarpeen.
      then DetEvFrm.Hide;

   ChkYliRvtDebWrInfo('PaaVal',DebWrCnt); //<+1415f: Onko DefsFileChkLueONdn_203 mukana, ajon keskeytys valittavissa.
   DelaaAjoFileChkListatTMP;  //<+1414f Delataan ajotiedosotarkistusten apufileet.
   if isDeb  then PaaValFrm.Caption := ExtractFilePath (Application.ExeName); //1415f: Muistitikulta-ajon testiin.
   if RegFnVirhe>''  then begin        //<,,1415f.,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      ShowMessage(RegFnVirhe);
      //RegFnVirhe := '';                //<Lienee turha.
      //Halt;                          //<Käynnistää vain itsensä uudelleen ja uudelleen...
      //PaaValFrm.FormClose;//LopetaClick(Sender);
      //PaaValFrm.LopetaClick(Self);
      Application.Terminate;         //<KUMMA: 1.Terminaten jälkeen tulee tähän uudelleen!?!?!?
      Application.Terminate;
      Exit;                          //<Ei näköjään tarvita ed. lisäksi. Tarttee sittenkin, 1x ainakin jatkaa uudelle kierrokselle.
      Halt;
   end;
 //Siirretty em. PRC DelaaAjoFileChkListatTMP´iin:,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
end;//FormShow
//========================================================================================================================================================
//,,12.0.03: Tässä siirretään LicEiPvitStr´stä EiPvitOikeutetut LisNot => LicEiPvitList -arriiin.
procedure SijLicEiPvitList;      VAR ss,sa :string;  i,no :integer;      begin //Siirretty FormShow´sta 10.0.2
                                                 YFileen('SijLicEiPvitLst');
   ss := Trim (LicEiPvitStr);
   SetLength (LicEiPvitList, 0);                //<120.4:  Jokainen kutsu kasvatti ja 2. krlla Length oli 127, tämä korjasi tilanteen.
   sa := '';
   while ss<>''  do begin
      sa := sa +ss[1];
      Delete (ss,1,1);                          //<Delataan saman tien kopioitu merkki vex, jolloin operoidaan aina vain [1] :llä.
      if (sa<>'') and                           //, ss[1] :ta ei saa päästää lukemaan jos ss=''.!!
         ((ss='') or (ss<>'') and (ss[1]=' '))  then begin
         if NOT SokI (sa,i)  then i := 0;
         if (i=0) and IsDebuggerPresent  then
            InfoDlg ('PaaVal.PAS / PRC FormShow / PRC SijLicEiPvitList ei tulkinnut oikein CONST '+
                     'LicEiPvitStr :a (SulkulistaStringiä). OK.',  mtWarning,
                     'OK','','','',  '','','','');
         no := Length (LicEiPvitList);
         no := no+1;
         SetLength (LicEiPvitList, no);
         LicEiPvitList [no-1] := i;   //<Eka = [1]
         sa := '';
         ss := Trim (ss);
      end;
   end;//while
   no := Length (LicEiPvitList)-1;
   if no<0  then bep;
                                        YFileen('SijLicEiPvitLst Lngth:' +Ints (Length (LicEiPvitList)));
end;//SijLicEiPvitList

(*procedure NayMemory;      begin //EAccesViolation -herjan selvittelyssä. Piip ettei jääVahingossa levitysversioon
   Y_piipit (500);
   PaaValFrm.Caption := fImrkt0 (GetHeapStatus.TotalFree,1);
{GetHeapStatus = The total number of free bytes available in the (current) address space for allocation by your
 program. If this number is exceeded, and enough virtual memory is available, more address space will be
 allocated from the OS; TotalAddrSpace will be incremented accordingly.end;}
end;//*)

procedure TPaaValFrm.FormCreate(Sender: TObject);      begin
  inherited;
//SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW); //<+12.0.08:  Iconi taskbariin.
TicsY := 0;
Tics0 := Time;
end;

procedure TPaaValFrm.SulakeLabClick(Sender: TObject);      begin
  inherited;
{Caption := IntToStr (_InfoDlg (['1','2']));
Caption := IntToStr (_InfoDlg ([]));}
{Caption := IntToStr (InfoDlg ('Kokeilutekstiä InfoDlg:hen ylimmälle riville<br><t>1<t>2<t>3<t>4',
                              'Button 1','Butto2','But3','B4',
                              'BtnSelitys 1','BtnSelit 2','BtnSel 3','BtnS 4')); //}
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, OK ,,,,,,,,,,,,,,,,,,
Caption := IntToStr (InfoDlg ('Infokoe 1/6',
                              'Btn1','','','',
                              'Se1' ,'Se2' ,'Se3' ,'Se4'));
Caption := IntToStr (InfoDlg ('Infokokeilua 2/6',
                              'Btn1','Btn2','','',
                              'Se1' ,'Se2' ,'Se3' ,'Se4'));
Caption := IntToStr (InfoDlg ('Infokokeilua 3/6',
                              'Btn1','Btn2','Btn3','',
                              'Se1' ,'Se2' ,'Se3' ,'Se4'));
Caption := IntToStr (InfoDlg ('Infokokeilua 4/6',
                              'Btn1','Btn2','Btn3','Btn4',
                              'Se1' ,'Se2' ,'Se3' ,'Se4'));

Caption := IntToStr (InfoDlg ('Kokeilua 5/6',
                              'Btni1','Btni2','Btni3','Btni4',
                              'Seli1' ,'Sel2' ,'Sel3' ,'Sel4'));
Caption := IntToStr (InfoDlg ('InfokokeiluaX 6/6',
                              'Btn1X','Btn2X','Btn3X','Btn4X',
                              'Se1X' ,'Se2X' ,'Se3X' ,'Se4X'));}
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, OK ,,,,,,,,,,,,,,,,,,
Caption := IntToStr (InfoDlg ('Infokoe 1/6',
                              ['Btn1'],
                              ['Se1' ,'Se2' ,'Se3' ,'Se4']));
Caption := IntToStr (InfoDlg ('Infokokeilua 2/6',
                              ['Btn1','Btn2'],
                              ['Se1' ,'Se2' ,'Se3' ,'Se4']));
Caption := IntToStr (InfoDlg ('Infokokeilua 3/6',
                              ['Btn1','Btn2','Btn3'],
                              ['Se1' ,'Se2' ,'Se3' ,'Se4']));
Caption := IntToStr (InfoDlg ('Infokokeilua 4/6',
                              ['Btn1','Btn2','Btn3','Btn4'],
                              ['Se1' ,'Se2' ,'Se3' ,'Se4']));

Caption := IntToStr (InfoDlg ('Kokeilua 5/6',
                              ['Btni1','Btni2','Btni3','Btni4'],
                              ['Seli1' ,'Sel2' ,'Sel3' ,'Sel4']));
Caption := IntToStr (InfoDlg ('InfokokeiluaX 6/6',
                              ['Btn1X','Btn2X','Btn3X','Btn4X'],
                              ['Se1X' ,'Se2X' ,'Se3X' ,'Se4X']));}
end;

procedure TPaaValFrm.NjLaskentaNapMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState;  X,Y: Integer);   begin //+1413 16å4
   inherited;
   if (Shift =[ssShift,ssCtrl,ssAlt])  then
      if OhjLbl.Visible
         then OhjLbl.Visible := false
         else OhjLbl.Visible := true;
end;

initialization
  Qsij := 0;                  //<+141.1
  AsetusOkBtnSulkiSyoFrmin := false;
  Pval := 0;    //<Ei välttämättä muutu: Z -> Pval := 1,   Sul -> Pval := 2;
  syoKut := 0;  syoAktv := false;  syoAvOn := true;  apuaOn := false;  MootNJ := false;
  EdvJoOllut := false;   MoJoOllut := false;
  AvCloseOK := true;     //<ChkBxAv:n eventiä varten. Asetus VAIN OhjeBtnClick +AvustAkt.. :ssä ####
//ChkBxAvON := true;     //<Glob.tieto, onko avuste valittu PÄÄLLE/POIS. Asetus formien ChkBxAv.Click
//alustaNj;     //<¤DEVELOPER1  <On kutsuttu PRC alkuEdvNj :stä
//lueJKok;      //<¤DEVELOPER1  <On kutsuttu PRC alkuEdvNj :stä
//alkuEdvNj;    //<¤DEVELOPER1
//''''''''''''''Nyt korvattu LueTall.., ks. Form.Create + FormShow
  alustettu := false;
  EdvFilen :=   '';
  EdvF_Filen := '';
  Edv0_Filen := '';
  NjFilen :=    '';
  MoFilen :=    '';
  VExKrt :=  6{2};         //<Yhdellä laskentakrlla tulostuvien NjVE :jen lkm
  for iii := 0 to YvrkMax  do Yvrk [iii] := -1; //< 0 => -1  10.0.4 tunnistettavuuden takia, ks. FNC fYvrk.
  FileLukuVirhe := '';     //<+6.2.2
//CloseKrt := 0;
  UpsNyt := true;//}false;      //<+120.4:  FA =Ei näytetä/huomioida seur. kehitelyvaiheen juttuja.
  JkUpsInt := 0;
//RePuFNCohi := {true;//}false; //<+130.2, +1415d: TR =FNC fRePunKehi ehdon ohittamiseen VAIN FnRePunEhdotOHI (='$RePunEhdotOHI.oma') läsnäolo OHITTAA.
  ChkDebWr_kertoja := 0;        //<+1415f.
end.
