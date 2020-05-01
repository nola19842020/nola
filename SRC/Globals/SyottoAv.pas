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

unit SyottoAv;
(*case SyoOsa of
     0 :begin if eRv=99                    //< 0=Päävalikon "Ohjeita/Tietoa"
        then begin ... else ...
        Avu_0_PaavEdv;  end;                                   //<' +8.0.5
     1 :Avu_1_EdvLiit;
   2,7 :Avu_2_EdvJtied;                                        //< 7 +8.0.5
   //3 :Avu_3_EdvUh;                                           //< -4.0.0
     4 :begin  if ...
        Avu_4_Nj;  end;
     5 :Avu_5_Hav;
     8 :Avu_8_Sul;
     9 :Avu_9_Moo;
  end;//case SyoOsa
  ######################################################################################################################
   =function avuste (CmBx,Rv,SyoOsa, tulost :integer) :String;                                                ##########
  #################     SyoOsa =0 :if Rv=0   then 'Edeltävä verkko / Yleistietoa'                             ##########
  #################                          else 'Edeltävä verkko / Riviselitykset';                         ##########
  #################             1 :               'Edeltävä verkko / Liittymätiedot';                         ##########
  #################             2 :               'Edeltävä verkko / Johto-osatiedot';                        ##########
  #################             3 :               'Edeltävä verkko / Jännitealenematiedot';                   ##########
  #################             4 :if Rv=-1  then 'Nj-laskenta / Yleistietoa'                                 ##########
  #################                          else 'Nj-laskennan syöttö-/sarakeselitykset';                    ##########
  #################             8 :if eRv>50 then 'Impedanssitarkastelu / Muuntajat:  Sarakeselitykset'  else ##########
  #################                if eRv>20 then 'Impedanssitarkastelu / Johdot:  Sarakeselitykset'     else ##########
  #################                               'Sulaketarkastelu / Sarakeselitykset';                      ##########
  #################             9 :if Rv=-1  then 'Moottorilähtöjen käsittely / Yleistietoa'                  ##########
  #################                          else 'Moottorilähtöjen sarakeselitykset';                        ##########
  ################# eli SyoOsa: 0=PääVal  1=EdvLiit  2=EdvJ  (3=Uh)  4=Nj  5=Hav  7=EdvJLis  8=Sul  9=Moot    ##########
  ####################################################################################################################*)
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, NolaForms,
  StdCtrls, ComCtrls, ComboBoxXY, RichEditNola, Math{, NolaPrinters},
  ExtCtrls,   //<Math ArcCos + Tan takia
  {FileCtrl}{WinExec}InfoDlgUnit{8.0.5}, TextBaseTexts{12.0.0};

type
  TSyottoAvFrm = class(TFormNola)
    TabCtrlAv: TTabControl;
    SyoAv: TRichEditNola;
    Image1: TImage;
    YPan: TPanel;
    EtsiBx: TComboBoxXY;
    EtsiBtn: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormHide(Sender: TObject);
    procedure TabCtrlAvChange(Sender: TObject);
    procedure SyoAvKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EtsiBxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EtsiBtnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SyottoAvFrm: TSyottoAvFrm;
  eCmBx :integer;
  procedure asetaBx9Color;
  procedure fSyoAktv (i :integer);              // i<0 =Vain editointi   0 -> FALSE   1 -> TRUE
  procedure ValmistaNollaaAvuste;               //< +3.0.0
  procedure AvuChkSft (oh :integer);            //<Vaihtaa kaikkien lomakkeiden ChkAvusteBx :n tilaa
  function avuste (CmBx,Rv,SyoOsa, tulost :integer) :String;
  function avusteU (CmBx,Rv,RvNr,SyoOsa, tulost :integer) :String; //+120.5o:  avuste=>avusteU: Listty RvNr =Avusteen eka tieto "Rivi XX" =RvNr.
  function f_Items (str :String) :TStringList;                     //          EI TARVITAISI ENÄÄ, KUN Sorc[].Josan Boxeihin nyt lisätty Uho.
  function BxItems (riv,SyoOs :integer) :String;
  procedure BxArvot(rivi,SyoOsa :integer);
  procedure Lado_TeeSyoFrm (apuikkuna :integer);
  function arvoOK (riv,SyoOsa :integer) :boolean;  //<HerjaJosEiOK
  function arvoOKe(riv,SyoOsa :integer) :boolean;  //<EiHerjaa
     procedure Qedic_ (s :string);                         //<,, +2.0.5 Testaukseen
     procedure QedicB (s1,s2 :string);                     //<,, +2.0.5
     procedure Qedic (qState :TCheckBoxState;  s :string); //<,, +2.0.5
  function EtsiOlet(oh :integer;  str :String) :String;    //< +6.1.1  NolaZ.INC/EtsiOlet

implementation
                                                             //,PaaVal :ssa esittely: SyoKut,SyoAktv
uses   PaaVal, Defs, Y_, Globals, Herja1, Syotto, EdvNew, NjVrk, ZS_, Moot, Koe{=Kokeiluun}, Unit0,
       StringGridNola{SyoKut.INC/PRC puts_StrGr :n takia},    //'Syotto :ssa esittely: SyoRivja
       Unit1{+4.0.1}, Korj{4.0.2}, Settings{, DetEv 6.0.2 koe-edit takia, ks. SyoArvOK/FNC sVeOK_};
{$R *.DFM}
CONST nuo=FONT_OIKEALLE;
VAR  {xRv +12.0.0}eRv,{141.1 oRv,}eOsa, eTop,eLeft,eHeight,eWidth{, AlpTabIndex,TabNo{+10.0.3 Glob12.0.0 141.0:}, SyoOsaQ :integer;
     OliJoInfo_Ev,OliJoInfo_Nj,OliJoInfo_Mo{, EstaFrmSulkeminen +8.0.5 -12.0.0} :boolean;    //'SyoOsaQ TabCtrlAvChange´en tiedonvälittämiseen.

//##################################################################################################
{$I '..\GlobINC\SyoKut.INC'}                 //< 2 StrGr -tekstit + BxOletukset + BxItemit
{$I '..\GlobINC\SyoArvOK.INC'}               //< 3 FNC ArvotOK
//##################################################################################################
//,,Näiden sisältö helppo kommentoida vex ,,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      function erittely :boolean;      begin  result := true;//<KOE result := false; //,,,,@@@@@@@@@@@@@@@@@@@@@@@@@@
       //if MoFrm.Bx1.Text ='   1'  then result := true;  end; //< = "...1" :llä jäljitysikkuna päälle ~Debug -4.0.0
 (*§LUO§ if MoFrm.EdiY1.Text ='..1' then result := true; *)end; //               Jäljitysikkuna päälle ~Debug +4.0.0

procedure Qedic_ (s :string);       begin                                                           //<,, +2.0.5
  {if erittely  then KoeW_ (s);     }end;//<,,Koe.PAS´ssa.
procedure QedicB (s1,s2 :string);   begin                                                           //<,, +2.0.5
  {if erittely  then KoeEdiB (s1,s2); }end;
procedure Qedic (qState :TCheckBoxState;  s :string);       begin                                   //<,, +2.0.5
  {if erittely  then KoeW (qState,s);     }end;
//''@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//åå 12.0.0: Tässä oli FNC Avu_0_Versiot, se siirretty Avuste11.INC´iin. Tässä myös KAIKKI DEVELOPER2 tekemät tyhjät ohituskutsut.

procedure fSyoAktv (i :integer);      begin // 1<i<0 =Vain editointi   i=0 -> FALSE   i=1 -> TRUE
   if i=0  then syoAktv := false  else
  {if i=1  then}syoAktv := true;                    //< -2.0.5
end;

procedure ValmistaNollaaAvuste;      VAR alpB :boolean;      begin //+3.0.0
   alpB := SyoAktv;
   if syoAvOn  then
      SyoAktv := false;    //function {procedure }avuste (CmBx,Rv,SyoOsa, tulost :integer{;  s :string}) :String;
   avuste(-1,0,8,0);       //<Tyhjä avuste + -1  jotta seur Click herättäisi avusteen samaltakin riviltä
   SyoAktv := alpB;
   try                     //<+6.2.2
   SyottoAvFrm.Hide;       //<Tuli herja: Cannot change Visible in OnShow or OnHide.
   finally end;            //<+6.2.2
 //SyottoAvFrm.Close;      //<Ei vaikuttanut.
end;

//,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//,@@@@@@@@@@@@@@@@@@@@@@@@@@ Jos DblClick, tullaan tähän ekax Click:stä = YHT. 2x @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   //.......,,,,,,,,,,,,,Eri, kuin PRC Avuste() :ssa,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   //,,,,,,,OH = 0 kun vain näytetään tila   OH=10/11 kunVap/Lukit ao.Avuste   OH=9 kun SYOAVON+SYOAKTVvapaut.
   //,,,,,,,Ohjaa ChkBx :n Checked/Grayed/UnChecked tilaa. ,,,,,,,,,,,,,,,,,,,,,,,,
   //,,,,,,,TÄHÄN TULLAAN vasta ao: ChkBxAvClick :n JÄLKEEN tai ERIKSEEN KUTSUMALLA ###################################
   //IDEA:  SyoAvOn :ssa tieto AVUSTE ON/EI (aset. VAIN ChkAvBxClick + StrGrDblClick :ssä). ###########################
   //       SyoAktv :ssa tieto GRAYED/NORM  (aset. ao. ohassa JA TÄSSÄ).    ###########################################

procedure AvuChkSft (oh :integer);    VAR aState :TCheckBoxState;  ss :string;

   function Nay :string;      begin
      result := 'oh:' +Ints (oh) +' syoAktv:' +fBmrkt0 (syoAktv,2) +' syoAvOn:' +fBmrkt0 (syoAvOn,2);  end;

   procedure wKoe (os :integer);      begin end; (*VAR s :string;      begin
      s := 'AvuChkSft: ' +Ints(os) +':  AvCloseOK=' +fBmrkt0 (AvCloseOK,2)  +'  syoAvOn=' +fBmrkt0 (syoAvOn,2) +'  syoAktv=' +fBmrkt0 (syoAktv,2) +
           '  SyFrm.Visib=' +fBmrkt0 (SyottoFrm.Visible,2);
      DefsFileenZ(s);
   end;*)

begin//AvuChkSft.........................
                                                    wKoe (1);
   if AvCloseOK         //<,IF AvCloseOK -testi, ettei TÄMÄN PRCn kutsumat kutsut TOISTA SAMAA ########################
   then begin AvCloseOK := false;     //<Asetetaan NYT alussa =Glob. tieto, että tämä PRC KÄYNNISSÄ MUIDEN AIKANA
                                      //SyottoFrm.Caption := SyottoFrm.Caption +' ' +fImrkt0(oh,1);
      CASE oh of
         0 :;                         //<Myös 1..8 ym. sama = Vain päivittää muutkin formien ChkAvBx´it  +4.0.0u
         9 :if syoAvOn  then                          //<oh=9 kun Exit ComBx, missä YLEENSÄ oli
               syoAktv := false;                      //'lukittu avuste, joka nyt vapautetaan
        10 :syoAktv := false;
        11 :syoAktv := true;                          //<Lukitsee avusteen.
        20 :begin syoAvOn := true;                    //<,Avuste päälle + vapautetaan  = +3.0.0
                  syoAktv := false;  end;
(*      30 :begin SyottoAvFrm.Hide;                   //<,Sulkee avusteikkunan (vain SyottoFrm :sta)= +4.0.1
                  syoAvOn := false;
                 {syoAktv := false; }end;*)
      end;//CASE
                                                    wKoe (2);
                                                                     QedicB ('[sft.1/3]','<br>');
      if syoAktv and syoAvOn                                       //'''''''''''''''''''''''''''''''
      then aState := cbGrayed
      else if syoAvOn
      then aState := cbChecked
      else aState := cbUnChecked;                                  //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                                                    wKoe (3);
                                                                     Qedic (aState,' [sft.2/3]<br>');
      if (aState=cbGrayed) and NOT syoAktv  then      //<,Koska vaihto Unchecked:stä Checked:iin tekee harmaaksi!
         aState := cbChecked;                          //< Järjestys:   Checked -> UnCheckd -> Grayed
{if isDebuggerPresent  then begin     //<,,1413=16å4: Nämä DebugRvt tehty kun ShowMes.. debugin NÄYTÖKSI osui kohtaan, missä Show..+InfoDlg´tä ei oltu vielä luotu,
      WBeep([200,200,0,100,200,200]); //   nyt ainoa kohta on PRC isTypeNolaFileOK´ssa VAIN kun KYSY -ehto täyttyy, jolloin luonnit =OK ja ajo=OK.
      ShowMessage('SyottoAv.PAS´issa ChkBxAv.State := cbChecked;//aState;  P O I S T A tämä');
      EdvNewFrm.ChkBxAv.State := aState;  end
   else }                                            //,,Checked := ... Aiheuttaa Eventin, VAIN JOS MUUTTUU ###
      if EdvNewFrm{.ChkBxAv}<>NIL  then //<,,+1416.  <,,AIheuttaa Acces violation´in jos NIL.
         EdvNewFrm.ChkBxAv.State := aState;
      if NjFrm<>NIL  then
         NjFrm.    ChkBxAv.State := aState;
      if ZS_Frm<>NIL  then
         ZS_Frm.   ChkBxAv.State := aState;
      if ZS_Frm<>NIL  then                //<+8.0.0  §LUO§
         MoFrm.    ChkBxAv.State := aState;
      if SyottoFrm<>NIL  then            //<+8.0.0  §LUO§
         SyottoFrm.ChkBxAv.State := aState; //< +4.0.1
      if SyottoFrm<>NIL  then                                                                    //<+8.0.4
    //if SyottoFrm.Visible and (aState=cbChecked)                                              //<,,+8.0.3
         if SyottoFrm.Visible and (aState IN [cbChecked,cbGrayed])               //<,,+8.0.3  cbGrayed +8.0.5
            then begin  {SyottoFrm.UpDwnH.Visible := true;   SyottoFrm.UpDwnW.Visible := true;   }end //<+130.3u
            else begin  SyottoFrm.UpDwnH.Visible := false;  SyottoFrm.UpDwnW.Visible := false;  end;
                                         //,,adStf = MoDetFormiin,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                                 //<Nyt takas alkuasetus. Tällä estettiin... ks. alku ##############
      AvCloseOK := true;         //,,ERITTÄIN HYVÄ 'KOEAJOSSA' @@@@@@@@,,,,,,,,,,,,,,,,,,,,,,,,,,,@@@@@@@@@@@@@@@
                                                                 Qedic (aState,' [sft.3/3]<br>' );  Qedic_ ('<br>');
                                                    wKoe (4);
      ss := Nay +'//' +Nay; //<???120.5i                         //<,,+12.0.0
    (*if IsDebuggerPresent  then
         EdvNewFrm.Caption := {EdvNewFrm.Caption +' }'AvuChk: ' +ss;                    //<Capt+Capt+Avu +120.5i*)
                                                    wKoe (5);
   end;//if AvCloseOK            //'################################################################
                                                    wKoe (9);
end;//AvuChkSft
//==================================================================================================

procedure TSyottoAvFrm.FormClose(Sender: TObject;  var Action: TCloseAction);      begin //< 1.OnClose  2.OnHide
{  if WindowState=wsMaximized
   then CanClose := False                   //< +4.0.0  Täysi ikkuna vain pienennetään normaaliksi, ks. := wsNormal}
{  if WindowState=wsMaximized
   then ModalResult := 0                    //< +4.0.0  Täysi ikkuna vain pienennetään normaaliksi, ks. := wsNormal}
{  if WindowState=wsMaximized
   then OnClose := false                    //< +4.0.0  Täysi ikkuna vain pienennetään normaaliksi, ks. := wsNormal}
{  if WindowState=wsMaximized
   then SendCancelMode(SyottoAvFrm.FormClose)//< +4.0.0  Täysi ikkuna vain pienennetään normaaliksi, ks. := wsNormal
   else }
  {if EstaFrmSulkeminen                     //<+12.0.0:  Nyt sallitaan sulkeminen.
   then Action := caNone                    //<'Ei sallita sulkea (eikä minimize) SyottoAvFrm. +8.0.5
   else begin}
      //,,Ei saada Closea peruttua, koklattu, OK = Sulkeutuu,,,,, jos painetaan X -painiketta !!!!!!!!!
      if WindowState=wsNormal  then begin //< +4.0.0  Jottei PÄÄVALINNAN INFOSTA avustVex ########
         EdvNewFrm.ChkBxAv.Checked := false;   //<Kun avusteFrm suljetaan, asetetaan UnChecked ######## +2.0.1
         syoAvOn := false;                     //<Tämä poistaa AvuChkSft :ssä ChkBxAv -> UnChecked. ''Turha
         apuaOn := false;                      //<Jos oli APUAbtn :sta pyydetty info
         AvuChkSft (0);             //<####### VAIHDETAAN ChkBxAv:n tila MUIHINKIN LOMAKKEISIIN #######
      end;                          //'####### jos suljetaan muualta kuin PÄÄVALINNAN INFOSTA #########
      PaaValFrm.Caption := Sender.ClassName;   //,wsMinimized siirtäisi avusteen TaskBariin, koklattu!!
      WindowState := wsNormal;          //< +4.0.0  Demoversiossa avusteet aukesi joskus täysikkunoina.
  {end;                                 //' Nyt aina palautetaan wsNormal´iksi ########################}
end;

procedure TSyottoAvFrm.FormHide(Sender: TObject);      begin
  inherited;
   if apuaOn and  NOT apuaOn  and syoAktv   then       //<Breakpointin takia
      begin end;//beep;
end;
//================================================================================================================
{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Avuste.INC}
{Rv<>eRv     Tarvittava avusterivi muuttunut koska rivi vaihtunut. eRv := Rv PRC avuste() :ssa.
CmBx<>eCmBx Cursorin paikka muuttunut ComBx-ikkunan sisään tai sieltä ulos. Ulkopuolisten avus-
            teiden kutsussa (StrGr1_35MouseMove) AVUSTE (0), (Com.._11MouseMove) sisäpuolisissa (1).
            eCmBx := Rv PRC avuste() :ssa.
              Tietoa käytetään SARAKKEISTA riippuvan avustetarpeen havaitsemiseen.
syoAktv     Ilmaisee, ollaanko Boxissa. Käytetään havaitsemaan, ollaanko syöttämässa ikkunaan arvoa,
            jolloin cur saattaa olla ikkunan ulkopuolella, jolloin avuste ei kuitenkaan saa vaihtua.
            CmBx=0 ilmaisee kyllä, jos cur on boxin ulkopuolella, mutta syoAktv avusteen luonteen.}

//,,§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//,,§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
function avuste (CmBx,Rv,SyoOsa, tulost :integer) :String;      begin
   //Wavu('avuste: CmBx=' +Ints(CmBx) +' Rv=' +Ints(Rv) +' SyoOsa=' +Ints(SyoOsa) +' tulost(--)');
   result := avusteU (CmBx,Rv,Rv,SyoOsa, tulost);  end;
                                                                //,Nyt vois nimetä takas AVUSTE´eksi, koska RV ja RvNr voisivat nyt olla yksin Rv (=RvNr vex).
function avusteU (CmBx,Rv,RvNr,SyoOsa, tulost :integer) :String;//+120.5o:  avuste=>avusteU: Listty RvNr =Avusteen eka tieto "Rivi XX" =RvNr.
      CONST M_OH='['+FONT_OMEGA+'] tai [m'+FONT_OMEGA+']';// (ks. viimeinen sarake)';
      VAR stG :string;  boA,boB,boC{:10.0.4},boP{:141.1:},{boQ,} PanDblClickSelit{:+12.0.0:}, isSelectionHidden :boolean;

procedure QedicSV (s :string);       {VAR sa :string;      }begin                             //<,, +2.0.5
{   sa := ' CmBx:' +Ints(CmBx) +'  sOs:' +Ints(SyoOsa) +' Rv:' +Ints(Rv) +' eRv:' +Ints(eRv) +'  tul:' +Ints(tulost) +'<br>';
   if (s<>'') and (s[1]='#')
   then KoeW_ (s +'<br><br>')     //<Pelkkä LF.
   else KoeW_ (s +sa);     }end;  //<,,Koe.PAS´ssa.

   procedure LataaSijKuva (KuvaNimi :string);      VAR xFilen :string;  BitMapA :TBitMap; //8.0.5, Nimi 8.0.7
//begin end;
   procedure AsPosFrm;      VAR u,w,hYli,wYli :integer;        begin
      u := SyottoAvFrm.EtsiBx.Height;                       //<EtsiBx tuli lisää yläpaneliin +130.2e: 2*u jotta jos TabCtrlAv aukeaa 2´lle rvlle.
      hYli := 20+5 +2*u;                                    //<hYli =TAB + raamin ´in ottama tila, mitä
      SyottoAvFrm.ClientHeight :=  BitMapA.Height +hYli;    // ClientH ei huomioi.
      w := 0;                                               //,Vain jos TabCtrlAv käytössä ao. kuvalla.
      if SyottoAvFrm.TabCtrlAv.Visible  then                //,Vaikka ekax asettaisi ClientWidth isoksi,
      for u := 0 to SyottoAvFrm.TabCtrlAv.Tabs.Count-1  do  // TextWidth antaa aina saman (380).  TabWidth =0
         w := w +SyottoAvFrm.TabCtrlAv.Canvas.TextWidth (SyottoAvFrm.TabCtrlAv.Tabs[u]);
                                             //,EdvNewFrm.KuvausEdit.Text´iin koemielessä WIDTH -lukema.#########
        {SokI (EdvNewFrm.KuvausEdit.Text,u); //Kun 6 Tab´ia: "Pähkinänkuoressa ... LääkMuunt_IT", w=457 =Tab´it
         EdvNewFrm.KuvausEdit.Text := EdvNewFrm.KuvausEdit.Text +'  ' +IntToStr (w); //pysyvät yhdessä rivissä ja
                                             //TextWidth=380 =>  KORJ = 457/380=1.2026 millä siis W kerrottava.}
      w := Trunc (w *1.21 +0.5);              //<'VarmVuoksi 1.2026 => 1.3, muuten TAB´it jakautuu 2:lle rvlle.
      wYli := 5;
      u := BitMapA.Width +wYli;
      if u>w  then w := u;

      SyottoAvFrm.ClientWidth := w;                         //<''Height,Width muutettu ClientH... =8.0.8

      if SyottoAvFrm.Height > Screen.Height  then SyottoAvFrm.Height := Screen.Height; //<Jos AvFrm liian korkea
      if SyottoAvFrm.Width  > Screen.Width   then SyottoAvFrm.Width :=  Screen.Width;  //<Jos AvFrm liian leveä
                                                                                       //''+8.0.5
      if SyottoAvFrm.Left +SyottoAvFrm.Width > Screen.Width                            //<,Jos meni oikealta ohi.
         then SyottoAvFrm.Left := Screen.Width -SyottoAvFrm.Width;
      if SyottoAvFrm.Top +SyottoAvFrm.{Top +8.0.5=}Height > Screen.Height              //<,Jos meni alhaalta yli.
         then SyottoAvFrm.Top := Screen.Height -SyottoAvFrm.Height;
      if SyottoAvFrm.Left <0  then SyottoAvFrm.Left := 0;                              //<,Jos yr/vr ohi.
      if SyottoAvFrm.Top  <0  then SyottoAvFrm.Top :=  0;
   end;//AsPosFrm

begin//LataaSijKuva........................

   with SyottoAvFrm  do begin                            //<,Otetaan talteen muun avusteen ikkunatieto.  +8.0.5
      eTop := Top;  eLeft := Left;  eHeight := Height;  eWidth := Width;  end;
   SyottoAvFrm.SyoAv.Visible := false;                   //< := FA =PAKKO asettaa RichEdit näkymättömäksi.
      SyottoAvFrm.Width :=  Screen.Width;                //<,,Ekax isoksi, jotta BitMap mahtuu KOKONAAN,
      SyottoAvFrm.Height := Screen.Height;               //   muuten muu osa jää harmaaksi, todettu.
   xFilen := gAjoPath; //+-12.0.05 oli: ExtractFilePath (Application.ExeName);      //<Pelkkä polku ilman filenimeä
   xFilen := xFilen +KuvaNimi;

   if NOT fFileExists(xFilen)
   then InfoDlg ('Kuvatiedosto "'+xFilen +'" puuttuu, avustetta ei esitetä!', mtCustom, 'OK','','','',  '','','','')
   else begin
         BitMapA := TBitMap.Create;
       //SyottoAvFrm.Image1.AutoSize := true;          //<Ei vaikutusta.
         SyottoAvFrm.Image1.Canvas.Brush.Color := {clLime;}clWhite; //<,Putsaa vanhan kuvan alta ja levittää kuva-alaa oikein.
       //SyottoAvFrm.Image1.Canvas.FillRect(Rect(0,0, SyottoAvFrm.Image1.Width, SyottoAvFrm.Image1.Height));
       //                                             2500             , 2000               )); //<-12.0.0: Ei kuvaa ollenkaan.
         SyottoAvFrm.Image1.Canvas.FillRect(Rect(0,0, Screen.Width     , Screen.Height));       //<12.0.0:  Näköjään OK.
       //SyottoAvFrm.Image1.Canvas.FillRect(Rect(0,0, BitMapA.Width, BitMapA.Height)); //<Jättää pari pixeliä put-
      try                                                                              // saamatta ed.kuvan oik.sivusta.
   {b1}  BitMapA.LoadFromFile (xFilen);                //<Vasta Load´in jälkeen BitMap:n koko tiedossa, todettu.
                  {with BitmapA do begin                //,,Kokeiltu, ei onaa!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                     //Eioo: LoadFromFile('c:\Program Files\Common Files\Borland Shared\Images\Splash\256color\factory.bmp');
                     LoadFromFile('E:\Projektit\NolaKehi\BIN\Config\SulRajSel.bmp');
                     Transparent := True;
                     TransParentColor := BitMapA.canvas.pixels[50,50];
                   //SyottoAvFrm.Canvas.Draw(0,0,BitMapA);
                     SyottoAvFrm.Canvas.Draw(500,500,BitMapA);
                     TransparentMode := tmAuto;   // Transparent color now is clDefault = TColor($20000000);
                   //SyottoAvFrm.Canvas.Draw(50,50,BitMapA);
                     SyottoAvFrm.Canvas.Draw(500,500,BitMapA);
                   end;//}
                                      {EdvNewFrm.KuvausEdit.Text :=
                                       'cH='+IntToStr (SyottoAvFrm.ClientHeight) +' cW='+IntToStr (SyottoAvFrm.ClientWidth) +
                                       ' @ iH='+IntToStr (SyottoAvFrm.Image1.Height) +' iW='+IntToStr (SyottoAvFrm.Image1.Width) +
                                       ' @ bH='+IntToStr (BitMapA.Height) +' bW='+IntToStr (BitMapA.Width) +
                                       ' # eH='+IntToStr (eHeight) +' eW='+IntToStr (eWidth);}
      AsPosFrm;
                                      {EdvNewFrm.KuvausEdit.Text := EdvNewFrm.KuvausEdit.Text +
                                       ' // cH='+IntToStr (SyottoAvFrm.ClientHeight) +' cW='+IntToStr (SyottoAvFrm.ClientWidth) +
                                       ' @ iH='+IntToStr (SyottoAvFrm.Image1.Height) +' iW='+IntToStr (SyottoAvFrm.Image1.Width) +
                                       ' @ bH='+IntToStr (BitMapA.Height) +' bW='+IntToStr (BitMapA.Width);}
   {b2}//BitMapA.Dormant;                              // Free up GDI resources.  OK, oli tämä eli ei.
   {b3}//BitMapA.FreeImage;                            // Free up Memory.         OK, oli tämä eli ei.
   {b4}  SyottoAvFrm.Image1.Canvas.Draw(0,0,BitMapA);  // Note that previous calls don't lose the image
   {b5}//BitMapA.Monochrome := false;//true;           //'50,50 siirtää kuvaa. //<OK, oli tämä eli ei.
   {b6}  BitMapA.ReleaseHandle;                        // This will actually lose the bitmap;
      finally
   {+} //SyottoAvFrm.Canvas.Brush.Bitmap := nil;                               //<OK, oli tämä eli ei.
//   {b7}  BitMapA.Free; KOE vex kokeeksi
      end;
   end;//if NOT FileExists ELSE
   end;//LataaSijKuva

  procedure sijCaption;      var sc :string;      begin
     with SyottoAvFrm  do begin
      //OhaOsa := SyoOsa;              //< +4.0.0  Siirretään tieto PASsin globaaliksi: Ohjaa PaaVal´in AvuChk.. -12.0.0
        SyoAv.Enabled := false;        //<Muuten tekstin vaihtuminen näkyy levottomana vilahteluna<<<<<
        sc := 'Syöttö- / Tulostuskenttäselitykset'; //<Saattaa jäädä voimaan (jos SyoOsa > 9)
        if (SyoOsa=0) and (Rv=99)
        then sc := 'Yleistietoa'
        else case SyoOsa of
           0 :if Rv=0   then sc := 'Edeltävä verkko / Yleistietoa (sulje ikkuna "?")'
                        else sc := 'Edeltävä verkko / Riviselitykset';
           1 :               sc := 'Edeltävä verkko / Liittymätiedot';
           2 :               sc := 'Edeltävä verkko / Johto-osatiedot';
           3 :               sc := 'Edeltävä verkko / Jännitealenematiedot';
           4 :if Rv=-1  then sc := 'Nj-laskenta / Yleistietoa'
                        else sc := 'Nj-laskennan syöttö-/sarakeselitykset';
           8 :if eRv>50 then sc := 'Impedanssitarkastelu / Muuntajat:  Sarakeselitykset'  else
              if eRv>20 then sc := 'Impedanssitarkastelu / Johdot:  Sarakeselitykset'     else
                             sc := 'Sulaketarkastelu / Sarakeselitykset';
           9 :if Rv=-1  then sc := 'Moottorilähtöjen käsittely / Yleistietoa'
                        else sc := 'Moottorilähtöjen sarakeselitykset';  end;//case
        if NOT ((SyoOsa=0) and (Rv=0)  OR (SyoOsa=4) and (Rv=-1))               //<+8.0.7
           then sc := sc +'  (Ctrl+P =Avuste paperille)';                       //<P =+5.0.0;
        Caption := sc;
      //Caption := 'Top=' +IntToStr (Top) +' H=' +IntToStr (Height) +' W=' +IntToStr (Width);
   end; end;//with, PRC sijCaption

   function ifd (n :integer) :string;      begin result := '';  end; //<,Lisää stG´n ALKUUN tunnistusmerkin debuggaukseen. 1415e: Eioo käyössä.
                                               //if IsDebuggerPresent then result := '¤' +Ints(n) +'¤';  end;
            //,KAIKKI GetMyB korvattu TÄLLÄ GetMyB´llä Avuste1.INC .. Avuste11.INC ja SyottoAv.PAS´sa.
   function GetMyB (BaseOs :string) :string;   begin result := ifd(1) +myTextBase.Get (BaseOs);  end; //<+12.0.0
                                                                                 //,SisXo +12.0.0: 1.rv=0, seurvt 10 .
   procedure si (ss :string);  begin stG := ifd(2) +stG +ss;  end;               //,STG +tb =+12.0.0 Sis.tekeeAina <br>n
   procedure sR (ss :string);  begin stG := ifd(3) +stG +'<b>RIVI '  +Ints(eRv)+':</b>   '  +{SisXo +}ss;  end;
   procedure sRi (i :integer;  ss :string);   begin
                                     stG := ifd(4) +stG +'<b>RIVI '  +Ints (i)  +':</b>   ' +{SisXo +}ss;  end;
   procedure sS (ss :string);  begin stG := ifd(5) +stG +'<b>SARAKE '+Ints (eRv)+':</b> '   +{SisXo +}ss;  end;
   procedure sZ (ss :string);  begin stG := ifd(6) +stG +'<b>SARAKE:  </b>'                 +{SisXo +}ss;  end;
   function PEN_PErw :boolean;      begin result := false; //<,,+141.1
      if (SyoOsa=1) AND (Rv<>eRv) AND NOT SyoAktv  then
         if ((SyottoFrm.RadGrp.ItemIndex=0) and (Rv=6))  OR //,,Näillä asetukssa ja aoRvllä ollaan PEN_PE -Bx´ssa,
            ((SyottoFrm.RadGrp.ItemIndex=1) and (Rv=5))  OR //  jolloin avusteikkunaan sij TabCtrlAv´n sivu(lehti)
            ((SyottoFrm.RadGrp.ItemIndex=2) and (Rv=12)) OR //  ja siihen PEN_PEyhdist.bmp -kuva.
            ((SyottoFrm.RadGrp.ItemIndex=3) and (Rv=14))
         then result := true;
      //if result  then {SyottoAvFrm.TabCtrlAv.TabIndex := TabNo := 0; }
   end;
   function parmt :string;   begin result := 'SOsa:' +Ints(SyoOsa) +'  eOsa:' +Ints(eOsa) +'  Rv:' +fImrkt0(Rv,-3) +'  eRv:' +fImrkt0 (eRv,-4) +
      '  Bx:' +Ints(CmBx) +' eBx:' +Ints(eCmBx) +' tul:' +Ints(tulost) +'  Aktv:' +fBmrkt0(syoAktv,1) +'  bA:' +fBmrkt0(boA,1) +'  bB:' +fBmrkt0(boB,1) +
      '  bC:' +fBmrkt0(boC,1) +' =yhtOR:' +fBmrkt0((boA or boB or boC),1);
   end;//Koe_SyAv:  Kirjoittaa vain jos rv vaihtuu =Ei saman rvn takia useampia tietorvja. =12.0.0
       //''Erittäin H Y V Ä EHTOJEN T U T K I M I S E E N.

{   procedure Koe_SyAv (ss :string);
      function b_(boo :boolean) :string;   begin if boo  then result := '<b>TR</b>'  else result := 'fa';  end;
   begin  if (rv<>xRv) or (ss='+++')  then KoeWInfo (ss +
      'SOsa:' +Ints(SyoOsa) +'  eOsa:' +Ints(eOsa) +'  Rv:' +fImrkt0(Rv,-3) +'  xRv:' +fImrkt0 (xRv,-4)  +'  eRv:' +fImrkt0 (eRv,-4) +
      '  Bx:' +Ints(CmBx) +' eBx:' +Ints(eCmBx) +' tul:' +Ints(tulost) +'  bA:' +b_(boA) +'  bB:' +b_(boB) +'  bC:' +
      b_(boC) +'  Aktv:' +b_(syoAktv) +' =bU:' +b_(boU) +' =yhtOR:' +b_(boA or boB or boC), 1);
   end;//Koe_SyAv:  Kirjoittaa vain jos rv vaihtuu =Ei saman rvn takia useampia tietorvja. =12.0.0
       //''Erittäin H Y V Ä EHTOJEN T U T K I M I S E E N. }

//##################################################################################################
//,,Tässä olivat $I :llä KAIKKI Avuste..INC´it (Avuste.INC(nytVex), Avuste1.INC, Avuste2.INC ja Avuste11.INC
{-$I '..\GlobINC\Avuste.INC'}   //<Versioiden muutostiedot + Avu_0_PaavEdv :n alku, siirretty TextBaseText.PAS´siin.
{$I '..\GlobINC\Avuste11.INC'}  // 1.INC___________    2.INC____    11.INC_______
{$I '..\GlobINC\Avuste1.INC'}   // OhanPoistaminen     Avu_4_Nj     Avu_0_Versiot
{$I '..\GlobINC\Avuste2.INC'}   // OhjeitaOngelmiin    Avu_5_Hav;   Avu_1_EdvLiit
//''12.0.0: Kutsujärjestys jou- // VersioLaajuudet     Avu_8_Sul;   Avu_2_EdvJtied
//  duttu muuttamaan.           // OhjelmaTIETOA       Avu_9_Moo;   Avu_3_EdvUh
                                // KatkOhje
                                // Avu_0_PaavEdv
//############################################################################################//,"+++" jotta avust´seen
//,############## NÄMÄ erinom.hyviä tutkittaessa muuttujia. jotka määräävät josko avuste näytetään eli ei.##############

begin//avusteU....................................................................................... CmBx,Rv,(RvNr,)SyoOsa, tulost
  SyoOsaQ := SyoOsa;            //<TabCtrlAvChange´en tiedon välittämiseen +141.1 .
  stG := '';                    //< +3.0.2   //stG := '<left>';           //< -3.0.2
                            QedicSV ('AvuAlku'); //= +CmBx,Rv,eRv,tul
                                //function avuste (CmBx,Rv,SyoOsa, tulost :integer) :String;
                                // 0=EdvKuvaaja  1=Liitt  2=EdvJ  3=Uh-raj(eiEnää)  4=KetjuParam  5=Häviökust
                                // 6=LisätLIITTYMÄ  7=LisätJohto-osa  8=MoottItemit.
                                //if CmBx+ Rv +SyoOsa+ tulost= -1  then ;
{______________________________Koe_SyAv('>  '); //}
  PanDblClickSelit := false;
  if Rv>=100  then begin        //<',,+12.0.0:  Hiiren liike EdvRvSelitPANELissa (HeaderPanel) selitetään normRvSelityk-
     Rv := Rv-100;              // sen ALUSSA. Jos MouseMove onkin johto-osissa, selitetäänkin alussa DblClick´in avus-
     PanDblClickSelit := true;  // teen lukittuminen/vapautuminen.
  end;
                                //if isDebuggerPresent  then EdvNewFrm.KuvausEdit.Text := parmt; //TOSI HYVÄ  TOSI HYVÄ  TOSI HYVÄ  TOSI HYVÄ  TOSI HYVÄ
  boA := (TabNo>=10)  OR //<+10.0.3/12.0.0  Tultiin PRC TabCtrlAvChange´sta. Tämä hoitaisi ,,8.0.5 ehtolausekkeet, mahd. muitakin.
         (CmBx=0) and (Rv=10) and (SyoOsa=1) and //<+10.0.4:  10.0.3:n korjaus: Apulask.yleisinfo Label2:sta ei herännyt.
         (Tulost=0) and (eRv<>Rv);               //< eRv<>Rv pakko olla: muuten värähtelee.
                                                 //,+12.0.0:  Edvn MouseMove ei herättänyt avusteita, nyt OK.
//if NOT SyottoFrm.Active  then syoAktv := false;//<+141.1 :  Mikään Bx ei vissiin voi olla auki jos SyottoFrm eioo auki!?!?
  if NOT boA  then boA := (SyoOsa=0) and (Rv<>eRv) and (Rv IN[0..35,99])  //<Avuste1.INC/Avu_0_PaavEdv´n eRiv´t. Ed.ehto
     and NOT syoAktv;                                                     //aikaisVersoissa kaiketi hoiti tämän: +12.0.0
                                                                          //'Jos SYOAKTV =avuste LUKITTU =ei uutta avust.
                                                 //'boA := TR myös Edv´n ? -btn´sta näköjään, havaittu 12.0.0.
  if NOT boA  then boA := (SyoOsa=9) and (Rv<>eRv) and (Rv IN [52,99]);   //< Rv<>eRv estää välkynnän.
                                                 //'+12.0.0:  MoottOsan TaajKaytLbClick ei antanut luvattua tietoa.
  boB := (SyoOsa=0) and (Rv=0) OR                //<Jotta "?" -klick edv:ssä workkisi  +8.0.5/+"Pähkinänkuoressa"
      ( ((Rv<>eRv) or (CmBx<>eCmBx))             //'eRv=Rivin vaihtuminen,  eCmBx=ComBx:sta siirtyminen
          and not syoAktv );                     //'eComBx: ComBx:sta 1, StrGr:sta 0''. Boxssa: Ent=TR,Exit=FA

  boC := (SyoOsa=0) and (Rv IN [{0,}99])  OR        //<Rv=eRv AINA, josPeräkkäin esim. ?Btn+?Btn  tai PaaVal/Info+Info
         (SyoOsa=4) and ( (Rv=-1) or (Rv IN [21,22,50]) )  OR //141.1: 50 //<NjFrm :n ?yms. -painik. ###### Korj 4.0.0
         (SyoOsa=9) and   (Rv=-1)                          OR             //<MoFrm :n ?yms. -painik. ###### Korj 4.0.0
         (SyoOsa=0) and (Rv=0)  and not syoAktv            OR             //<Edv :n   ? -painike <<<<<<<<<<<<<<<<
       ( (SyoOsa=5) and ((Rv<>eRv) or (CmBx<>eCmBx))                      //<KustHav  <<<<<<<<<<<<<<<<<<<<<<<<< +2.0.7
                                     and not syoAktv )     OR
         (tulost>0);                                //<'Päivitetään vain, jos rivi vaihtuu, eikä olla Boxissa (=syöttä-
                                                    // mässä). Jos TULOST, ohjataan aina FNC:oon !!!!!!
                                                    //function avuste (CmBx,Rv,SyoOsa, tulost :integer) :String;
   boP := PEN_PErw;                                 //<+141.1
{______________________________Koe_SyAv('   ');{_______________________________________________________________________}
    //xRv := Rv;            //<+12.0.0 Estyy Koe_SyAv´n 2x SamaRv, jos seurKrlla Rv=xRv, näkyy vain Koe_SyAv´ssa.
                            //if isDebuggerPresent  then EdvNewFrm.KuvausEdit.Text := 'SyoOsa=' +Ints(SyoOsa) +' Rv=' +Ints(Rv);  RadGrp
//nction avusteU (CmBx,Rv,RvNr,SyoOsa, tulost :integer) :String;//+120.5o:  avuste=>avusteU: Listty RvNr =Avusteen eka tieto "Rivi XX" =RvNr.
//Wavu('avusteU:  CmBx=' +Ints(CmBx) +' Rv=' +Ints(Rv) +' RvNr=' +Ints(RvNr) +' SyoOsa=' +Ints(SyoOsa));

 if boA or boB or boC {141.1:}or boP {+1412:}or (SyoOsa=1) and (Rv=1) //1412:  Vv-klikkaus toi Gener.käyräavusteen näkyviin, nyt txt-avuste.
 then begin                 //'boA..boC 10.0.4
    eOsa := SyoOsa;         //<+12.0.0:  Ei voi siirtää ed. ehtorivin edelle, todettu.##################################
    eRv := Rv;//RvNr;       //<########################## Päivitetään ############################## 120.5o:  Rv => RvNr
    eCmBx := CmBx;          //<########################## Päivitetään ##############################
    if TabNo>=10  then TabNo := TabNo-10;                 //<12.0.0: Sai arvon +10 PRC TabCtrlAvChange´ssa.
{______________________________Koe_SyAv('+++');  KoeWInfo('',1);{______________________________________________________}
  //if SyottoAvFrm.SyoAv.Text=''  then beep;     1xLF'.   //<Kokeiluun / Breakpoint = Vanhan sisältö
  //SyottoAvFrm.SyoAv.AddText ('</f></b>');               //< +4.0.0  =Ekax nollataan ettei jää päälle  <,Siirto 12.0.0
    stG := '</f></b>';
    SyottoAvFrm.SyoAv.Clear;
                            QedicSV ('>boA..'); //= +CmBx,Rv,eRv,tul
                            QedicSV ('  Seuraavissa : sOs/eR:..');
                            Qedic_(' boA..boC,[avu.2]<br><br>');
  SyottoAvFrm.TabCtrlAv.Visible := false;  //<,,TabCtrlAv asetetaan näkyväksi jälempnä vain, jos TABeja tarvitaan...
  SyottoAvFrm.SyoAv.Parent := SyottoAvFrm; //..., jolloin PARENT=TabCtrlAv, muulloin SyoAv.PARENT=ao. Frm
  with SyottoAvFrm  do                     //<,Otettiin talteen muun avusteen ikkunatieto LataaKuva´ssa  +8.0.5
                    //if (eTop>-1) and (Left>-1) and (Height>-1)  then begin  //< -8.0.8
  if (eHeight>30) and (eWidth>30)  then begin  //< +8.0.8
     Top := eTop;  Left := eLeft;  Height := eHeight;  Width := eWidth;  end;
                                                 //,+12.0.0:  Clear asettaa Indexin -1´ksi, muualta Clear vex.
  SyottoAvFrm.TabCtrlAv.Tabs.Clear;  //<+12.0.0:  Nyt aina kaikki vex, jätti "r.8 10 kuvaote" -lehtiTABin.
                                     //TODETTU:  Jos muualla Indx´iin sijoitetaan isompi arvo kuin on SILLÄ hetkellä leh-
                                     //+12.0.0:  tiä, arvoksi TULEE -1. SIKSI TabNo´a käytetään yleisesti JOS LEHTIÄ>0.
  case SyoOsa of                     //<,eRv=fRv, koska päästy tähän. Näin vältetään fRv :n kutsu            //case SyoOsa of //
   0 :case eRv of                    //< 0=Päävalikon "Ohjeita/Tietoa"                                       //     0   :if eRv=99  0=Päävalikon "Ohjeita/Tietoa"
      99 :begin           //TabNo := 1;           //<+1415a: Versiomuutokset alkuavaukseen. -1415eU          //          Avu_0_PaavEdv;
                            QedicSV ('s0/r99, '); //= +CmBx,Rv,eRv,tul                                       //     1   :Avu_1_EdvLiit;
           SyottoAvFrm.TabCtrlAv.Visible := true;                                                            //     2,7 :Avu_2_EdvJtied;
           SyottoAvFrm.SyoAv.Parent := SyottoAvFrm.TabCtrlAv;                                                //     3   :Avu_3_EdvUh;
           SyottoAvFrm.TabCtrlAv.Tabs.Add ('Asennus- ym. ohjeita, rajoituksia');                             //     4   :begin  if ...
           SyottoAvFrm.TabCtrlAv.Tabs.Add ('Tietoa versiomuutoksista');                                      //          Avu_4_Nj;  end;
           SyottoAvFrm.TabCtrlAv.Tabs.Add ('Ohjeita ongelmiin');                                             //     8   :Avu_8_Sul;
           SyottoAvFrm.TabCtrlAv.Tabs.Add ('Lisenssi');
           SyottoAvFrm.SyoAv.Visible := true;                  //<LataaKuva´ssa .. := fa (=RichEdit.Visible) //      end;//case SyoOsa
           SyottoAvFrm.TabCtrlAv.TabIndex := TabNo;            //<+12.0.0
           Avu_0_PaavEdv;                 //<Siellä valinta.   //<,Text saa arvon, joka nyt stG :ään, vrt. Hide jälempnä.
          end{99};                                             //<' +8.0.5 12.0.0:  Avu_0_PaavEdv => Avu_0_Versiot
      0  :begin                           //,,Edv ? -painike.  //<,,+8.0.5
                            QedicSV ('s0/r0, '); //= +CmBx,Rv,eRv,tul
           SyottoAvFrm.TabCtrlAv.Visible := true;
           SyottoAvFrm.SyoAv.Parent := SyottoAvFrm.TabCtrlAv;
           SyottoAvFrm.TabCtrlAv.Tabs.Add ('Pähkinänkuoressa');       //<TabIndex= 0
           SyottoAvFrm.TabCtrlAv.Tabs.Add ('Yleiset toimintaohjeet'); //           1
           SyottoAvFrm.TabCtrlAv.Tabs.Add ('Vihjeitä');               //           2
           SyottoAvFrm.TabCtrlAv.Tabs.Add ('Esimerkit');              //           3 Kuva
           SyottoAvFrm.TabCtrlAv.Tabs.Add ('RinnakLiit');             //           4 Kuva
           SyottoAvFrm.TabCtrlAv.Tabs.Add ('Vv-KoneEsim.');           //           5 Kuva
           SyottoAvFrm.TabCtrlAv.Tabs.Add ('LääkMuunt_IT');           //           6 Kuva  §u§ +8.0.7
           SyottoAvFrm.TabCtrlAv.Tabs.Add ('Testerinäyttö');          //           7 Kuva  130.2e.
           SyottoAvFrm.TabCtrlAv.TabIndex := TabNo;

           stG := ' ';                                           //< Jos stG='' => Hide, ks. jälempnä.
           SyottoAvFrm.Image1.Visible := true;
           case SyottoAvFrm.TabCtrlAv.TabIndex of
             3 :LataaSijKuva ('Config\LiitEsim-4.bmp');        //<,,Vain .BMP -kuva kelpaa, ei JPG tms.
             4 :LataaSijKuva ('Config\RinSyoMuGe-B.bmp');      //<,,+8.0.7
             5 :LataaSijKuva ('Config\GenerParam.bmp');
             6 :LataaSijKuva ('Config\LaakMuunt_IT.bmp');   //,======Tähän kun TabIndex IN [0,1,2] = PähkinK,Yle,Vihj.
             7 :LataaSijKuva ('Config\Testerinäyttämä.bmp');
           else begin
              SyottoAvFrm.Image1.Visible := false;             //<,§u§ +8.0.7
              SyottoAvFrm.SyoAv.Visible := true;
              Avu_0_PaavEdv;
           end;
          end;//case
      end{0};//case eRv
      else begin{=SyoOsa=0=EdvKuvaaja}                         //,,Kokonaan uusittu 10.0.3  Nyt mukana selittävä kuva.
         if eRv IN [8..10]                                     //<Tällä rivillä TabCtrlAv, ks. myös eRv=31 (Lääkintä..)
         then begin         if SyoOsa<0  then ;                //<Debugille.
                            QedicSV ('s0/r8..10, '); //= +CmBx,Rv,eRv,tul
            SyottoAvFrm.TabCtrlAv.Visible := true;
            SyottoAvFrm.SyoAv.Parent := SyottoAvFrm.TabCtrlAv;
            SyottoAvFrm.TabCtrlAv.Tabs.Add ('Avuste');              //<TabIndex= 0
            SyottoAvFrm.TabCtrlAv.Tabs.Add ('r8..10 kuvaote');      //           1
            if TabNo<0  then TabNo := 0;                            //<,Init´ssa =-1.
            SyottoAvFrm.TabCtrlAv.TabIndex := TabNo;                //'Jos > Tabs.Count => Indx := -1 automsti.

            stG := ' ';                                              //< Jos stG='' => Hide, ks. jälempnä.
            SyottoAvFrm.Image1.Visible := true;
            case SyottoAvFrm.TabCtrlAv.TabIndex of
              1 :LataaSijKuva ('Config\SulRajSel.bmp');              //<,,Vain .BMP -kuva kelpaa, ei JPG tms.
            else begin                                               //<Valittu lehti=Avuste.
               SyottoAvFrm.Image1.Visible := false;
               SyottoAvFrm.SyoAv.Visible := true;
               Avu_0_PaavEdv;  end; end;//case                       //<,Verkkokuvaajan riviavusteet.
         end                                                         //,141.1: Johdot´ssa ohjataan avusteelle 50, nyt NÄIHINkin korjattu.
         else if eRv IN [{22}50,31]                                  //<,,+1202: Myös näillä riveillä TabCtrlAv, ks. myös [8..10] edellä.
         then begin
            SyottoAvFrm.TabCtrlAv.Visible := true;
            SyottoAvFrm.SyoAv.Parent := SyottoAvFrm.TabCtrlAv;
            SyottoAvFrm.TabCtrlAv.Tabs.Add ('Avuste');                   //<TabIndex= 0
            case eRv of                                                  //,,         1
               50 :SyottoAvFrm.TabCtrlAv.Tabs.Add ('rv22 Asennustesterivaatimus');
               31 :SyottoAvFrm.TabCtrlAv.Tabs.Add ('rv31 Havainnekaavio');
            end;
            if SyottoAvFrm.TabCtrlAv.Tabs.Count <0  then ;
            if TabNo<0  then TabNo := 0;                            //<,Init´ssa =-1.
            SyottoAvFrm.TabCtrlAv.TabIndex := TabNo;                //'Jos > Tabs.Count => Indx := -1 automsti.

            stG := ' ';                                              //< Jos stG='' => Hide, ks. jälempnä.
            SyottoAvFrm.Image1.Visible := true;
            case SyottoAvFrm.TabCtrlAv.TabIndex of
              1 :case eRv of
                    50 :LataaSijKuva ('Config\Testerinäyttämä.bmp'); //<,,Vain .BMP -kuva kelpaa, ei JPG tms.');
                    31 :LataaSijKuva ('Config\LaakMuunt_IT.bmp');
                 end;
            else begin                                               //<Valittu lehti=Avuste.
               SyottoAvFrm.Image1.Visible := false;
               SyottoAvFrm.SyoAv.Visible := true;
               Avu_0_PaavEdv;  end; end;//case                       //<,Verkkokuvaajan riviavusteet.
         end
         else begin
                            QedicSV ('s0/r1..7,11.., '); //= +CmBx,Rv,eRv,tul
            SyottoAvFrm.SyoAv.Visible := true;                       //<LataaKuva´ssa .. := fa (=RichEdit.Visible)
            Avu_0_PaavEdv;  end;                                     //'ILMAN := TR JÄÄ BLANKOKSI, TODETTU 10.0.3
      end;//case eRv of.. else
      end;{case eRv}                                                 //,120.5n/6:  +SyoOsa[6]: LisäLiittymän avu oli blancko.
   1,6 :begin //Avu_1_EdvLiit;                                       //,,Kokeilua GenerKäyrä -kuvalla.  +8.0.8
        stG := ' ';                                                  //< Jos stG='' => Hide, ks. jälempnä.
        //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,+141.1 ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
        if ((SyottoFrm.RadGrp.ItemIndex=0) and (Rv=6))  OR           //< Sj <,,PEN_PE -rv.
           ((SyottoFrm.RadGrp.ItemIndex=1) and (Rv=5))  OR           //< Pj
           ((SyottoFrm.RadGrp.ItemIndex=2) and (Rv=12)) OR           //< Vv
           ((SyottoFrm.RadGrp.ItemIndex=3) and (Rv=4))               //< UPS
        then begin
               //SyottoAvFrm.TabCtrlAv.TabIndex := TabNo; //<Jos Tab > Tabs.Count => Indx := -1 automsti, eikä hyväksy >-1 arvoja, koska vasta kohta Add().
           boP := (SyottoAvFrm.TabCtrlAv.TabIndex =0) OR (SyottoAvFrm.TabCtrlAv.TabIndex =-1) OR (TabNo>=0); //and (TabNo<=0);
           if (SyoOsa=1) AND boP {AND (Rv<>eRv) AND NOT SyoAktv  }then begin
              Avu_1_EdvLiit;
              if TabNo<0  then TabNo := 0;                              //<,Init´ssa =-1.
              SyottoAvFrm.TabCtrlAv.Visible := true;                    //<,,Tab -lehdet näkyviin 0 ja 1.
              SyottoAvFrm.SyoAv.Parent := SyottoAvFrm.TabCtrlAv;
              SyottoAvFrm.SyoAv.Visible := true;
              SyottoAvFrm.Image1.Visible := true;                       //,TabCtrlAv.Tabs.Clear; alussa ennen CASE´ea.}
              SyottoAvFrm.TabCtrlAv.Tabs.Add ('Avuste');                //<Tab 0
              SyottoAvFrm.TabCtrlAv.Tabs.Add ('PEN_PE muualla');        //<Tab 1
              SyottoAvFrm.TabCtrlAv.TabIndex := TabNo;                  //<Tab 0 (tai 1) valituksi, joka on avuste ja jo kutsuttu tässä 1.rvllä.
              if TabNo=1  then begin
                 SyottoAvFrm.Image1.Visible := true;                    //,TabCtrlAv.Tabs.Clear; alussa ennen CASE´ea.
                 LataaSijKuva ('Config\PEN_PEyhdist.bmp');              //<Vain .BMP -kuva kelpaa, ei JPG,PNG tms.
              end;//if TabNo..
           end;//(SyoOsa..
        end;//if((..
        //'''''''''''''''''''''''''''''''''''''''''+141.1 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        if (SyottoFrm.RadGrp.ItemIndex=2{VV}) and (eRv IN [8..10])   //<,,Kuvat tehty vain riveille 8..10.
        then begin //<BEGIN oli välillä hävinnyt, nyt OK (varmaankin XE2´n ^Z poistanut TABin jälkeen).
                            QedicSV ('s1/r8..10, '); //= +CmBx,Rv,eRv,tul
           SyottoAvFrm.TabCtrlAv.Visible := true;
           SyottoAvFrm.SyoAv.Parent := SyottoAvFrm.TabCtrlAv;
//{?}        SyottoAvFrm.Image1.Visible := true;                     //<-1412  vaikka ei merkitystä, mutta koska myöh. luontevampi, tämä vex.
           SyottoAvFrm.TabCtrlAv.Tabs.Add ('Avuste');                //<TabIndex= 0  Nyt takas +1412, oli vex.
           SyottoAvFrm.TabCtrlAv.Tabs.Add ('Generaattorin käyrä');   //           1
           if TabNo<0  then TabNo := 0;                              //<+1412.  Oli virhe:  KäyräTab jätti näyttämätt usein kuvaa, ,,ISOJA MUUTOKSIA.
           SyottoAvFrm.TabCtrlAv.TabIndex := TabNo;
           if TabNo=1  then begin                                    //<+1412.
              case eRv of
                 8 :LataaSijKuva ('Config\A2-GenerKayra-3p8r.bmp');  //<,,Vain .BMP -kuva kelpaa, ei JPG tms.
                 9 :LataaSijKuva ('Config\A2-GenerKayra-3p9r.bmp');
                10 :LataaSijKuva ('Config\A2-GenerKayra-3p10r.bmp'); end;
{?}           SyottoAvFrm.Image1.Visible := true;                    //<,,+1412.
           end else begin
              SyottoAvFrm.Image1.Visible := false;
              SyottoAvFrm.SyoAv.Visible := true;
              Avu_1_EdvLiit;  end;                                   //<''+1412.
        end
        else begin
                            QedicSV ('s1/r.., '); //= +CmBx,Rv,eRv,tul
           {if TabNo<1  then                                //<+,-141.1
              SyottoAvFrm.Image1.Visible := false;}
           if SyottoAvFrm.TabCtrlAv.TabIndex <1  then begin //<+141.1
              if SyottoAvFrm.SyoAv.Lines[0]=''              //<,Jos ei SyoAv´issa ole avustetekstiä.
                 then Avu_1_EdvLiit;
              SyottoAvFrm.SyoAv.Visible := true;  end;
        end; //GetMyB (BASE_Avu_1_EdvLiit);  end;}
      end{SyoOsa=1};
   2,7 :{if SyoOsa= ???}begin
                            QedicSV ('s2,7/r.., '); //= +CmBx,Rv,eRv,tul
        Avu_2_EdvJtied;  end;                                  //< 7 +8.0.5
   //3 :Avu_3_EdvUh;                                           //< -4.0.0
   4 :begin
                            QedicSV ('s4/r.., '); //= +CmBx,Rv,eRv,tul
      if eRv=-1  then begin
         SyottoAvFrm.TabCtrlAv.Visible := true;
         SyottoAvFrm.SyoAv.Parent := SyottoAvFrm.TabCtrlAv;
         SyottoAvFrm.TabCtrlAv.Tabs.Add ('Selitys');
         SyottoAvFrm.TabCtrlAv.Tabs.Add ('Esimerkkikuva');
         SyottoAvFrm.TabCtrlAv.TabIndex := TabNo;  end;
      if (eRv=-1) and (SyottoAvFrm.TabCtrlAv.TabIndex=-1)      //<12.0.04: 1 => -1
      then begin
         stG := ' ';                                           //< Jos stG='' => Hide, ks. jälempnä.
         LataaSijKuva ('Config\NJketju-4.bmp');  end
      else begin
         SyottoAvFrm.SyoAv.Visible := true;                    //<LataaKuva´ssa .. := fa (=RichEdit.Visible)
         Avu_4_Nj;  end;
      end;
   5 :begin                 QedicSV ('s5, '); //= +CmBx,Rv,eRv,tul
      Avu_5_Hav;  end;
   8 :begin                 QedicSV ('s8, '); //= +CmBx,Rv,eRv,tul
      Avu_8_Sul;   end;
   9 :begin                 QedicSV ('s9, '); //= +CmBx,Rv,eRv,tul
      Avu_9_Moo;  end;
   end;//case SyoOsa       }
                            QedicSV ('#SyoAv END;'); //#= VAIN tämä texti +<br>
   //===================================================================================================================
   with SyottoAvFrm  do begin
     SyoAv.AddText ({t+}stG);             //<###########################################################################
     WindowState := wsNormal;                                                                   //< +4.0.0
                                          //TODETTU:  SyottoAvFrm.FormStyle oltava StayOnTop jottei Edvn alle. 11.0.1
     if stG=''                            //TODETTU: Show´ta ei saa kutsua ollenkaan kun SyottoFrm on auki, koska
     then Hide  //else Show;     //<-11.0.1  johto-osa, liittymä ja apulaskentaikkunoissa Bx kyllä maalautui, mutta
     else if SyoOsa IN [1,2,5,7] //<+11.0.1  otti numeroym. näppäilyjä vasta 2:n klikinjälkeen +PudVal eiHetiHerää.
        then SyottoAvFrm.Visible := true  // Nyt OLTAVA (SHOW valmiiksi ON tai) Visible := TR (syy: Handle ehkä muut-
        else SyottoAvFrm.Show;            // tuu, ks. NETti),Syotto.PAS/ComBx1_11Enter.             11.0.1''''''''

     if Visible  then begin                             //<,,Jos FRM oli pieni, näkyi loppuosa avusteesta        +6.0.4
        sijCaption;
       {SyoAv.SelStart := 0;                            //<,,Ei vie näkymää tekstiosan alkuun ##########################
        SyoAv.SelLength := 0;                           //   ja SelStart + Enabled tarvitaan, muuten SyoAv HARMAANA.####
        SyoAv.Enabled := true;
        SyoAv.Perform (EM_SCROLLCARET,0,0);             //<Tämä yksin vie CURSORIN ALKUUN, ks. Help/Windows sdk/Index/EM_}
                                //12.0.0: Nämä vie cursorin alkuun,todettu.#############################################
        SyoAv.SelStart := 0;
      //SyoAv.SelStart := Perform(Messages.EM_LINEINDEX, SyoAv.Lines.Count, 0);//Set caret at end: Tälläkin menee alkuun!
        isSelectionHidden := SyoAv.HideSelection;
        SyoAv.HideSelection := False;
        SyoAv.Perform(Messages.EM_SCROLLCARET, 0, 0);   // Scroll to caret
      //SendMessage(SyoAv.handle, EM_SCROLLCARET,0,0);  //<Tämäkin tekee saman, OK.
        SyoAv.HideSelection := isSelectionHidden;
        SyoAv.Enabled := true;                          //<Enabled tarvitaan, muuten SyoAv HARMAANA, todettu.###########
         //SyoAv.SetFocus;                              //<Can´t focus invisible..
     end;//if Visible
   end;//with
 end;//if boA  or boB  or boC ...=Kaikki avustekuviot oli tässä.########################################################

  avusteU := stG;                      //<Palautusarvo, Formn RichEdi sisältö hoidettiin edellä <<<<<<<
  TabNo := -1;                     //<+10.0.3  Ks. seur. PRC TabCtrlAvChange,, +ehto avuste´n alussa.
                //{SyottoAvFrm.Caption}EdvNewFrm.KuvausEdit.Text := 'Sos='+Ints (SyoOsa) +' Skut=' +Ints (SyoKut);
end;//avusteU
//''§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//''§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
procedure TSyottoAvFrm.TabCtrlAvChange(Sender: TObject);      begin //,,Tutkitaan MINKÄ avusteosan käytöstä on kyse Tabs[0]´n TEKSTISTÄ.
  inherited;                                                        //  Tähän tullaan, kun ollaan AVUSTEIKKUNASSA valittu aikaisemmin esim. Havainnekuva
                                                                    //  -lehti ja siellä ollessa valitaan Tab[0], esim. varsinainen avustetekstisivu.
           TabNo := TabCtrlAv.TabIndex +10;       //<+10=+12.0.0: =Ohj ..avChange´sta. +10.0.3  Siirtää tiedon PRC Avuste´eseen, +10 mrkiksi CtrlAvChange.
   if TabCtrlAv.Tabs[0] =      'Asennus- ym. ohjeita, rajoituksia' //<Ohjeita, rajoituksia'
   then avuste (0,99,0,0)                                          //<CmBx,Rv,SyoOsa,Tulost
   else if TabCtrlAv.Tabs[0] = 'Selitys'
   then avuste (0,-1,4,0)
   else if TabCtrlAv.Tabs[0] = 'Pähkinänkuoressa'                  //<, 0=Pähkinänkuoressa  1=Yleisohjeet  +8.0.5
   then avuste (0,0,0,0)
   else if TabCtrlAv.Tabs[0] = 'Avuste'                            //<,+10.0.3
      then begin                                                    //,,AVUSTE -kutsu jotta menisi takaisin kutsurutiiniin, missä nyt TabNo+10 ohjaa kulkua.
         if (SyoOsaQ=1) and (eRv IN [4..6,12])    //<Liittym PEN_PE //,,AVUSTE´n paramt eivät tartte olla kovin tarkkoja kunhan päästään vain AVUSTEeseen.
         then avuste(0,eRv,SyoOsaQ,0)
         else if (SyoOsaQ=0) and (eRv IN [8..10]) //<EdvKuva..IkdOFA Kuva.
         then avuste(0,eRv,SyoOsaQ,0)
         else if (SyoOsaQ=0) and (eRv IN [22,31]) //<Testerimittausvaatimus ja Lääkintä..Kuva.
         then avuste(0,eRv,SyoOsaQ,0)
         else if (SyoOsaQ=1) and (eRv IN [8..11]) //<EdvKuva..IkdOFA Kuva. //<,+1412:  Avusteteksi ja kuva epävarmat näkymät.
         then begin
           {if isDebuggerPresent
               then WBeep([200,100, 2000,500]); //'+1412.}
            avuste(0,eRv,SyoOsaQ,0)
         end;
      end; //'Avuste(CmBx,Rv,SyoOsa, tulost :integer).
end;
//<,,141.1
procedure TSyottoAvFrm.SyoAvKeyDown(Sender: TObject;  var Key: Word;  Shift: TShiftState);      begin
   inherited;
   if (CharInSet(Chr(Key), ['P','p'])) and (ssCtrl IN Shift) and PaaValFrm.PrinterSetupDialog1.Execute
    //then PrintRichEditNolaSymbolText (SyoAv,SyottoAvFrm);
      then SyoAv.Print('');
end;

procedure TSyottoAvFrm.FormResize(Sender: TObject);
begin
   inherited;
   if (top<10) and (height<10)  then ;
end;

procedure TSyottoAvFrm.FormShow(Sender: TObject);      begin //+130.2e
  inherited;
   EtsiBx.Text := '';
   EtsiBx.ItemIndex := 0;
end;

   procedure EtsiLisaaItemit;      VAR ss :string;      begin //+130.2e
    //procedure etsiStr (Rich :TRichEditNola;  ComBxy :TComboBoxXY);
      ss := Trim(SyottoAvFrm.EtsiBx.Text);
      SyottoAvFrm.EtsiBx.Text := ss;
      etsiStr (SyottoAvFrm.SyoAv, SyottoAvFrm.EtsiBx);
      if (ss<>'') and (SyottoAvFrm.EtsiBx.Items.IndexOf (SyottoAvFrm.EtsiBx.Text) <0)  then
         SyottoAvFrm.EtsiBx.Items.Add(ss);
   end;
procedure TSyottoAvFrm.EtsiBtnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); //+130.2e
begin
  inherited;
   EtsiLisaaItemit;
end;

procedure TSyottoAvFrm.EtsiBxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState); //+130.2e
begin
  inherited;
 //procedure etsiStr (Rich :TRichEditNola;  ComBxy :TComboBoxXY);
   if {Ord(}key IN [13,114]  then EtsiLisaaItemit; //<114=F3 ei worki!?!?
end;

initialization
  eRv := -100;  eCmBx := 0;   //< eRv := -100 jotta eRv=0 ekana mahista, todettu
//OliJoInfo_Ev := false;   OliJoInfo_Nj := false;   OliJoInfo_Mo := false;  =Never used.
  eTop := -1;  eLeft := -1;  eHeight := -1;  eWidth := -1; //<+8.0.5
  TabNo := -1;
end.


