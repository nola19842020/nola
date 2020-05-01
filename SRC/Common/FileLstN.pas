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
unit FileLstN;
{Tässä on pohjana FileLstN 1411.pas 22.06.2015  18:33
   Teksti StrGr.Celleihin hoidetaan PRC SijMrgCel´illä :1414d.
     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
     @@@@@@@@@  KAIKKI PARAMETRIT x... TÄHÄN UNITtiin välitetään PRC Y_gLueTal_FileLista :n   @@@@@@
     @@@@@@@@@  KUTSUSSA ja siirretään SEN SISÄLLÄ vastaaviin PAIKALLISIIN q... muuttujiin.@@@@@@@@@
     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Viim muutos:
LisaaSLst_JosEiJoOle_OSvalissa -kutsu kustakin OS ja ErLaji -osasta, OS:xz´ssa määrää OS:x (Z ohitetaan).
1414f: 2 kpl ¶¶ø KoeajojärjestelynALKUKOPIOT, välttämättömät.
       3 kpl ¶°  FN.. jonka sisältö näytetään NotePad´issa KEHIvaiheessa, reaaliajassa: Lst..SaveToFile() +Show...
       4 kpl ¶-  DynArrayn uArr,sArr´n yhdessä muiden SList´ien kanssa. Näyttää hiirenosoit´lla JONONA TULOSSA olevat
                  SLst itemit: ('A1','B_'..), keinotekoinen, alkuvaiheessa oli HYVÄ.
       9 kpl ¶"   Ehkei aina välttämätöntä mukana, mutta täydellisempää.. .
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, NolaForms{+4.0.1},
  Grids, StringGridNola, StdCtrls, ExtCtrls, PanelNola{+4.0.1}, {FileCtrl,} Y_, {+12.0.07 DefsFileenø:}Defs, PaaVal{1414/FileLstN};

//Koe{1414d};{EdiStrGrSelected}
//'Delphi korjasi koko alemman rivin itsestään kun olin lisännyt NolaForms´in

type
  TFileLstFrm = class(TFormNola) //<Muutos TForm -> TFormNola´ksi onnistui vain kirjoittamalla, OK.
    Panel: TPanelNola;
    SuljeBtn: TButton;
    NaytaBtn: TButton;
    TamaBtn: TButton;
    StrGr: TStringGridNola;
    OpenDlg: TOpenDialog;
    SaveDlg: TSaveDialog;
    KoeLb: TLabel;
    procedure ListBxDblClick(Sender: TObject);
  //procedure NaytaBtnClick(Sender: TObject{;  VAR _qFileNvar :string});
    procedure NaytaBtnClick(Sender: TObject); //<1414 muutos.
    procedure SuljeBtnClick(Sender: TObject);
    procedure TamaBtnClick(Sender: TObject);
    procedure StrGrWidestColInRow(Sender: TObject; ACol,ARow, newWidth: Integer);
    procedure StrGrDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StrGrKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure StrGrAfterPaint(Sender: TObject);
    procedure StrGrMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    function isTypeNolaFileOK (qOHA :integer;  Filen :string;  VAR Sout :string) :boolean; //<1414.
  //function isTypeNolaFileOkI (Filen :string) :integer;                                   //<1414fu 1415d: ..OkI => ..OK korvaa täysin. ..OkI ei ollut kutsuja.
    function fLueTal_FileLista (OS,xOHA :integer;  xKieli :string;  xLUE,xKYSY :boolean;
                                xDlgTitle,xLstTitle,xFilter :string;  VAR xFileNvar :string) :boolean; //<DEVELOPER1 1414fu: -xListaFileN siirttyTänne.
  end;

var
  FileLstFrm: TFileLstFrm;
  ListFD,ListFT :TStringList; //<Tiedostosta luettu D=Date  T=Time
//SelD_ots,SelT_ots,CreD_ots,CreT_ots :string;
  Accs2_ots,Tim_ots{3,5,7},Modi4_ots{+1414},Cred6_ots{CreD_ots}{,CreT_ots=SelT_ots} :string;

implementation

uses InfoDlgUnit, Globals{+6.2.2}, ShellApi{ShellExec1413}, Inifiles{TInifile}, Koe{1413 KoeWInfoA 1414d},
  NjVrk, NjTul3, EdvNew, Moot{1414: TalMoFile};
{$R *.DFM}

CONST ruuMax=20;
      COLOR_BLUE   = '<f n="" s="" c="16711680">';
      COLOR_SILVER = '<f n="" s="" c="12632256">';

VAR qKieli,qDlgTitle,qLstTitle,VrkLstFileN,GrdColFN,
    qFilter,qFileNvar{1414},zFileNvar :string; //<,Näihin siirretään FNC EditFileList :n parametrit @@@@@@@@@@@@@@ 1414fu: +zFileNvar
    qLUE,qKYSY{, qFnc} :boolean;         //<Paluuarvo sij. tähän (qFnc) = tästä RESULT @@@@@@@@@@@@@@@@@@@@@@@@@@@
    SeiooF,CLteho,CLnorm :string;        //,+1414=16å10: COHA on voimassa koko tämän PAS´sin alalla. Jotkin kutsuparam ..OHA voitais nyt korvata tällä.
    erv,nFnc{:1414:},COHA :integer;      //<erv Päivittyy MouseDown + KeyDown mukaan, nFnc=2? =_qFileNvar saanut arvon fValittuStrGr_Sij´ssa,
                                         //'koska LstF´ään ei voida siellä sijoittaa, vasta jälempnä.

function SamIso (str1,str2 :string) :boolean;      begin  //<Testaa isoilla kirj:lla onko samat
    result := AnsiSameText (str1,str2);  end;  //<Without case sensitivity.
//==================================================================================================
function fTagVex (s :string) :string; // Tagit + Alku/LoppuTyhjät Vex ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
     CONST tagMax=23;
           begTag: array[1..tagMax] of string = (
                   '<f ',                       //<Ainoa tagi, JOSTA LÄHTIEN LOPETTAVAAN TAGIIN ASTI texti PYYHITÄÄN
                   '</f>',   '<in','</in>',     // HUOMAA välilyönti f :n jälkeen =DEVELOPER1 lisäys @@@@@@@@@@@@@@@@@@@@
                   '<tab','</tab>',   '<t>', '<above>', '<below>', '<middle>', '<left>', '<right>', '<center>',
                   '<b>','</b>',   '<i>','</i>',   '<u>','</u>',   '<s>','</s>',   '<br>', '<colspan');
           endTag: array[1..tagMax] of string = (
                   '">',                        //<Ainoa tagi, JOHON ASTI texti PYYHITÄÄN, aloittava oli '<f'
                   '','','','','','','','','','','','','','','','','','','','','','');
      VAR i,os1,os2,begL,endL,delL :integer;  su,begS,endS :string;  jatka :boolean;      begin
   su := s;                                                    //SokI (s,i) and (i=46)   s=' 46 '
   for i := 1 to tagMax  do begin
      begS := begTag[i];    begL := Length (begS);
      endS := endTag[i];    endL := Length (endS);
      os1 :=  Pos    (begTag[i], su);                          //<AloitusTagin alun osoite
      if os1>0  then jatka := true
                else jatka := false;
      while jatka  do begin
         os2 := 0;
         if endL>0  then os2 := Pos (endTag[i], su);           //<endTagin alun osoite
         if os2>0
            then delL := os2 - os1 + endL
            else delL := begL; //Length (su);

         if delL>0  then Delete (su, os1, delL);               //<,,Tagit +Alku/LoppuTyhjätVex
         os1 :=  Pos    (begTag[i], su);                       //<AloitusTagin alun osoite
         if (i>=tagMax) and (os2=0)  OR  (os1=0)
            then jatka := false;                               //<Tämä lopettaa WHILEn #############
      end;//while
   end;//for

   while (Length (su)>0) and (su[1]=' ')            do Delete (su,1,1);           //<Alkutyhjät vex
   while (Length (su)>0) and (su[Length (su)]=' ')  do Delete (su,Length (su),1); //<Lopputyhjät vex

   result := su;
end;//fTagVex
//==================================================================================================
      procedure qFileen(si :string);     VAR qf :TextFile;  qn :string;      begin//+1414 paikalliseksi avuksi kun curPoint rajallista.
      if isDeb  then begin
         qn := gAjoPath +'\LstFym[].txt';
          AssignFile(qf,qn);
          if xFileExists(qn)
             then Append(qf)
             else Rewrite(qf);
         Writeln(qf,si);
         Flush(qf);
         CloseFile(qf);
      end;//if isDeb
   end;//qFileen
//==================================================================================================        Haettavaksi: OpenDlg jos en hoksaa OpenFileDlg.
//nction fKutsuOpen (oha :integer;  VAR xFileN :string) :integer;      VAR ExtN :string;  pal :integer;     begin
function fOpenFileDlg (zOHA :integer;  zDlgTitle,zFilter :string;  VAR zFileN :string) :integer{:1414 -boolean, 1=Exec  9=Cancel};
                                       LABEL 1;  VAR uFileN,str :string;  boo :boolean;  oLst :TStringList;  k :integer;
                     //''''''''FNC:  TRUE=Avattava file valittu ja=OK,  FALSE=Cancel === Sama kuin OpenDlg.Execute
{HKEY_CURRENT_USER   <,,+1414: Ongelma oli:  OpenDlg rupesi yht´äkkiä avautumaan täysruudulle, eikä dlg´ssä ollu Minimize tai NormalSize -valintoja.
   Software                                  Googlattu => "http://www.codeproject.com/Questions/479290/OpenplusDialogplusshowsplusmaximizedplusandpluscan"
      Microsoft
         Windows
            CurrentVersion
               Explorer
                  Comdlg32
You will find the SubKey called CIDSizeMRU. There will be a lot of entries (one per application). They are REG_BINARY entries.
You will need to open each one of them and locate one that has the name of your exe. Delete it and it all start to work.
''Nola.exe oli [11], poistin sen, nyt palautui NormalSize´ksi.<<<#############################################################
}//JOptionPane.showMessageDialog(frame, "Eggs are not supposed to be green."); =Kokeilua nettivihjeen perusteella, ei worki.
   procedure VexJosOnLSTssa (fn :string);      VAR i :integer;   begin //+1414.
      if FileOnEiEmpty(fn)  then begin
         oLst.LoadFromFile(fn);          //<1414f: Oli qListaFikeN
         for i := 0 to oLst.Count-1  do
            if AnsiUpperCase(fn)=AnsiUpperCase(oLst[i])  then begin
               oLst.Delete(i);
               Break;
            end;
      end;//if
   end;//onLSTssa

begin//fOpenFileDlg......................
   FileLstFrm.OpenDlg.Title := zDlgTitle;      //<1414: sirrtty jälempää With´in sisältä.
1: with FileLstFrm  do begin  //,,PoistaaChkBoxin,PäällekirjPrompti,MsgIfNoPathExist<<<<<<<<<<<<<<<<
      OpenDlg.Options := [ofHideReadOnly,ofOverwritePrompt,ofPathMustExist, ofFileMustExist,
                          ofNoReadOnlyReturn,ofEnableSizing,{1414}ofEnableSizing];
      str := ExtractFilePath (zFileN);         //< Pelkkä polku ilman filenimeä
    //OpenFileDialog.InitialDir :='';
      OpenDlg.InitialDir :=str;                //<+1414
      if str<>''  then Sysutils.ForceDirectories (str); //< Tekee tarvittaessaDIRrin

      OpenDlg.Filename := zFileN;
      OpenDlg.Filter := 'Kaikki tiedostotyypit|*.*'; //zFilter;  { := fOhaS (oha) +'tiedostot (*.' +ExtN +')|*.'+
                                                     //ExtN +'|Käyttäjän omat tiedostot (*.*)|*.*';}
                        //OpenDlg.FilterIndex := 2;   //<Tuo näkyviin: "Käyttäjän omat tiedostot (*.*)"
      if OpenDlg.Execute                                    //<Ei tartte: if FikeExists, ks. Options
      then begin             //OpenDialog1.Handle, HWND_TOP, Left, Top, Width, Height, SWP_SHOWWINDOW);
         //SetWindowPos(FileLstFrm.OpenDlg.Handle,      100,  300, 200,   400,    300, SWP_SHOWWINDOW);  //SetWindowPos; //<+1414. Ei vaikutusta.
           uFilen := OpenDlg.Filename;                      //<FileName palauttaa Full Path ########
         //boo := isTypeNolaFil2eOK({zOHA}COHA,uFilen,str); //<+1415c: COHA. ..2eOK oli ´itsekseen´ syntynyt VIRHE?! mutta tätä FNC ei olekaan.
           boo := isTypeNolaFileOK (COHA,uFilen,str);       //<1414d
           zFileN := uFilen;        //<,,+1414.
           if boo
              then begin
                 result := 1;
                 LueTalFilenReg ('Opn',{gOha}COHA,LueFA,KysFA,zFilen); //+1414:  Talletus Registryyn heti:  Oha 1=Edv  2=NjLask  3=KustLsk  4=Moot.
                 oLst := TStringList.Create;
                                          for k := 0 to oLst.Count-1  do qFileen('1  oLst[' +Ints(k) +']=' +oLst[k]);  qFileen('');
                   VexJosOnLSTssa(zFilen);
                   oLst.Insert(0,zFilen);                  //<''Sijoitus ekaxi [=0].
                   oLst.SaveToFile(VrkLstFileN);
                                          for k := 0 to oLst.Count-1  do qFileen('2  oLst[' +Ints(k) +']=' +oLst[k]);  qFileen('');
                   case {gOHA}COHA of 1 :EdvFilen := zFilen;
                                      2 :NjFilen :=  zFilen;
                                 else{3} MoFilen :=  zFilen;  end; //<1414:  FnLstaan<>'' ilmaisee että on valittu uusi file.
                 oLst.Free; //1414f: Ei aiheuttanut erroreita mutta lienee hyvempi näin.
              end
              else begin
                 OpenDlg.Title := str +' =Sopimaton valinta, valitse toinen.';                //<Herja titteliksi.
                 GOTO 1;
              end;
      end
      else result := -1; //oli false.  X tai Cancel =9 => 1414fu: -1
      if result>-22  then ;
   end;//with
end;//fOpenFileDlg (fKutsuOpen)

procedure SijMrgCel (sar,riv :integer;  si :string);     VAR sa :string;      begin
   sa := '';
   case sar of
      0 :sa := '  <center>';
      1 :sa := '   ';
    4,6 :sa := '<left>  ';        //<+120.5i:  Vierekkäiset samaan Luonti/Teko(aikaan) liittyvät lähekkäämmin.
  //else sa := '<right>  ';  end; //<2,3, 5
    else sa := '<left>  ';  end; //<2,3, 5  =1414.
    FileLstFrm.StrGr.Cells[sar,riv] := sa +si +' '{1414 Ettei peity reunaviivan alle};
end;//SijMrgCel
//===============================================================================================================

function fRivTila :integer;      begin
   result := FileLstFrm.StrGr.DefaultRowHeight +FileLstFrm.StrGr.GridLineWidth;  end;
//===============================================================================================================
procedure KoeTul (s :string);      begin
{   with FileLstFrm  do KoeWInfo (
   s +'  GrW='   +Ints (StrGr.Width)    +'  GrH='   +Ints (StrGr.Height) +
      '  ClntW=' +Ints (ClientWidth)    +'  ClntH=' +Ints (ClientHeight) +
      '  FrmW='  +Ints (Width)          +'  FrmH='  +Ints (Height)       +
      '  PanH='  +Ints (Panel.Height)   +'  PanW='  +Ints (Panel.Width)  +
      '  RwCnt=' +Ints (StrGr.RowCount) +'  fTila=' +Ints (fRivTila)     +
      '  fT*Rw=' +Ints (StrGr.RowCount*fRivTila)    +'  Ch-Ph=' +Ints (ClientHeight-Panel.Height)
   , 1);   }end;                                                                                                 // 0 FixedRw (otsikot)
//===============================================================================================================// 1  Ev-uk.NOE
                                                                                                                 // 2  EsimEdv.NOE
function fValittuStrGr_Sij :boolean;      VAR s :string;  c,r,rw :integer;  LstX :TStringList;                   // 3  -Ev.NOE
                                                                                                                 // 4  3s2j.NOE
   procedure CellToU (ca,ra,RU :integer);      begin //RA=kopioitava rv kopioidaan riville RU +1414.             // 5  1s2j.Noe
      FileLstFrm.StrGr.Cells[ca,RU] := FileLstFrm.StrGr.Cells[ca,ra];  end;                                      // u  tänne valittuRv väliaik.
                                                                        // ValUlle: 1     C:\Projektit XE2\NolaKehi\BIN\Data\Olet-Ev-uk.NOE
                                                                        // ValUlle: 2     C:\Projektit XE2\NolaKehi\BIN\Data\EsimEdv.NOE
begin//fValittuStrGr_Sij..........                                      // ValUlle: 3     C:\Projektit XE2\NolaKehi\BIN\Data\Olet-Ev.NOE
   result := false;                                                     // ValUlle: 4     C:\Projektit XE2\NolaKehi\BIN\Data\Olet-Ev 3s2j.NOE
   with FileLstFrm.StrGr  do begin                                      // ValUlle: 5     C:\Projektit XE2\NolaKehi\BIN\Data\Olet-Ev 1s2j.NOE
      rw := FileLstFrm.StrGr.Row;                                       // ValUlle: 6     C:\Projektit XE2\NolaKehi\BIN\Data\Olet-Ev 3s2j.NOE
      if rw < FileLstFrm.StrGr.FixedRows                                // All +1 : 1     C:\Projektit XE2\NolaKehi\BIN\Data\Olet-Ev-uk.NOE
      then Beep                   //<'+1414.                            // All +1 : 2     C:\Projektit XE2\NolaKehi\BIN\Data\EsimEdv.NOE
      else begin                                                        // All +1 : 3     C:\Projektit XE2\NolaKehi\BIN\Data\EsimEdv.NOE
         s := fTagVex(Cells[1,rw]);                                     // All +1 : 4     C:\Projektit XE2\NolaKehi\BIN\Data\Olet-Ev.NOE
         if xFileExists(s)                                              // All +1 : 5     C:\Projektit XE2\NolaKehi\BIN\Data\Olet-Ev 3s2j.NOE
         then begin                                                     // All +1 : 6     C:\Projektit XE2\NolaKehi\BIN\Data\Olet-Ev 1s2j.NOE
              nFnc := 2;//<fValittuStrGr_Sij.  2=qFileNvar sijoitettava ao.List´oihin myöhemmin koska täällä ei voi (Lst´it =NIL).
              qFileNvar := s;
              result := true;                                                   //,,+1414=16å10.
              case COHA of 1 :EdvFilen := S;           //<,,+1414=16å10.,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                           2 :NjFilen := S;
                      else{3} MoFilen := S;  end;
                             //for r := FixedRows to RowCount-1  do qFileen( 'Alkuper: ' +Ints(r) +'  ' +Cells[1,r]);  qFileen('');
              if rw > FileLstFrm.StrGr.FixedRows  then begin                    //<Siirto vain jos Row muu kuin ekaRv,
                                             //+16å10: Delphi how to insert a row in TStrongGrid => http://www.delphipages.com/forum/showthread.php?t=174303
                                             {for r := 2 to RowCount -1  do FileLstFrm.StrGr.Rows[r] := FileLstFrm.StrGr.Rows[1];
                                                 for r := FixedRows to RowCount-1  do qFileen( 'Rows:= ' +Ints(r) +'  ' +Cells[1,r]);  qFileen('');
                                              for r := 2 to RowCount -1  do FileLstFrm.StrGr.Rows[r].Assign(FileLstFrm.StrGr.Rows[1]);
                                   ''Ei worki>   for r := FixedRows to RowCount-1  do qFileen( 'Assgn: ' +Ints(r) +'  ' +Cells[1,r]);  qFileen('');}
                 FileLstFrm.StrGr.RowCount := FileLstFrm.StrGr.RowCount +1;     //<Tehdään ylimäär.row. johon VALITUN rvn Cellien arvot, delataan myöh.
                 for c := 1 to ColCount-1  do                                   //' +1 jotta on tilaa siirtää alkurvt 1x alemmaksi.
                    CellToU (c,rw, FileLstFrm.StrGr.RowCount -1);               //<Lisärvlle kopioidaan valitun rvn cellit, josta siiretään ekax kunhan muut on siirrtty 1 alemmaksi.
                             //for r := FixedRows to RowCount-1  do qFileen( 'ValUlle: ' +Ints(r) +'  ' +Cells[1,r]);  qFileen('');
                                                                                //,<-3 osoittaa entiselle tokaVikalle rvlle.
                 for r := RowCount-3 DownTo FixedRows  do                       //<FixedRows[1] siirtyy myös, tilalle kohta valitun rvn sisältö.
                    if r<>rw  then                                              //<Muuten valittu rv tulee kahteen kertaan riveille.
                    for c := 1 to ColCount-1  do begin                          //<,EdRvt kopioidaan seurlle riveille. '-3 jottei kopiois vikalle U-Rvlle,
                       CellToU (c,r,r+1);                                       //  missä on valittu (klikattu) rv säilössä.
                       {if c=1  then
                          qFileen(Ints(r) + '=>' +Ints(r+1) +' [' + Ints(r) +']=' +Cells[1,r] +' =>[' +Ints(r+1) +']');//}
                    end;  //qFileen('');  for r := FixedRows to RowCount-1  do qFileen( 'FixJälk: ' +Ints(r) +'  ' +Cells[1,r]);  qFileen('');

                 for c := 1 to ColCount-1  do                                   //<,Vikalle rvlle väliaik sijoitettu valittu rv lopuksi ekalle rvlle.
                    CellToU (c,RowCount-1,FixedRows);
                 RowCount := RowCount-1;                                        //<VäliaikRv vex.
                             //for r := FixedRows to RowCount-1  do qFileen( 'Finishd: ' +Ints(r) +'  ' +Cells[1,r]);  qFileen('');
                 for r := FixedRows to RowCount-1  do Cells[0,r] := Ints(r);    //<Rivinrointi.
                 LstX := TStringList.Create;
                   for r := FixedRows to RowCount-1  do begin
                      s := fTagVex(Cells[1,r]);
                      LstX.Add(s);  end;
                 LstX.SaveToFile(VrkLstFileN);                                  //<Jotta luettavissa fLueTalChkLista´ssa LstF´ään.
                   LstX.Free;
                 PvitaMuutokset;                       //<+1414: Muuten ei valittu FileNimi tulekaan EdvNewFrm.Captioniin, todettu. Kutsuu PvitaEdvFrm
                             //for r := FixedRows to RowCount-1  do qFileen(Ints(r) +'  ' +Cells[1,r]);  qFileen('^^^^^');
              end;
              if FileLstFrm.StrGr.RowCount<0  then ;
         end
       //else MessageDlg (SeiooF, mtInformation, [mbOk], 0);
         else InfoDlg (SeiooF, mtCustom, 'OK','','','',  '','','',''); //<+6.2.2
      end;//else
   end;//with
end;//fValittuStrGr_Sij
//===============================================================================================================

procedure TFileLstFrm.ListBxDblClick(Sender: TObject);      begin
   TamaBtnClick(Sender);   end;
//===============================================================================================================

{function fCol (X,Y :integer) :integer;      var CelCol,CelRow :integer;      begin //<Pal Cellin AbsCOLn
  FileLstFrm.StrGr.MouseToCell(X,Y, CelCol,CelRow);                                 //'Scrollattu tai ei
  Result := CelCol;
end;//fCol;}
function fRow (X,Y :integer) :integer;      var CelCol,CelRow :integer;      begin //<Pal Cellin AbsROWn
  FileLstFrm.StrGr.MouseToCell(X,Y, CelCol,CelRow);                                //'Scrollattu tai ei
  Result := CelRow;
end;//fRow;
//===============================================================================================================
                                     {function KoeWidth :string;      VAR i,k,t :integer;  st :string;      begin
                                         t := 0;  st := '';
                                         for i := 0 to FileLstFrm.StrGr.ColCount -1  do
                                         with FileLstFrm  do begin
                                            k := StrGr.ColWidths[i];   t := t+k;
                                            st := st +Ints (k);
                                            if i<StrGr.ColCount -1  then st := st +'+';  end;
                                         st := st +'=' +Ints (t) +' cW: '+Ints (FileLstFrm.ClientWidth);
                                         result := st;
                                      end;}
procedure TFileLstFrm.StrGrWidestColInRow(Sender: TObject; ACol,ARow,  newWidth: Integer);      begin
   inherited;
   if newWidth > StrGr.ColWidths[ACol]  then
      StrGr.ColWidths[ACol] := newWidth;     //< Tässä oli kutsu PRC asetaFrmW, mutta 2.krlla levitti +16
end;//StrGrWidestColInRow

//===============================================================================================================
procedure TFileLstFrm.SuljeBtnClick(Sender: TObject);      begin
   //nFnc := 0{1414}; //<SuljeBtnClick. <Jos ohjelmallisesti kutsutaan tätä BtnClikkiä, pitää nFNC :n arvo tarkistaa
   Close;   end;

procedure TFileLstFrm.TamaBtnClick(Sender: TObject);      begin //KESKEN KESKENkö???
   if fValittuStrGr_Sij                                         //<Oli:  fValittu_Sij
      then Close;  end;

(*procedure TFileLstFrm.NaytaBtnClick(Sender: TObject);      begin //<=14.06.2015 versio =~ALP.
   qFnc := _fOpenFileDlg (9,qDlgTitle,qFilter,_qFileNvar);
 //if NOT qFnc  then Close;   end;                         //<Ei tehoa kun ShowModal
   if qFnc  then begin
      if FileLstFrm.Visible                                //<Valinta OK:  Suljetaan listaFrm, muuten saa jäädä
         then FileLstFrm.SuljeBtnClick(Sender);
      qFnc := true;                                        //<Koska SuljeBtnClick sijoitti FALSE
   end;
end;*)
procedure TFileLstFrm.NaytaBtnClick(Sender: TObject);      begin //<1414:
   nFnc := fOpenFileDlg (gOha,qDlgTitle,qFilter,qFileNvar);      //<NaytaBtnClick. <gOha +1414.
   if nFnc=1  then begin                       //<NaytaBtnClick. nFnc=9 =Cancel.
      NjFrm.Close;                             //<+1414: Siirtty LueBtnClickistä, jonne ei enää mennäkään jostain syystä.
      NjTulFrm.Close;                          //< -"-   Siellä NJtulAuki := false ##############
      if FileOnEiEmpty(qFileNvar)  then //<,,+1414: Oli vain EdvFilen := qFileNvar;
         case gOHA of 1 :EdvFilen := qFileNvar;
                      2 :NjFilen :=  qFileNvar;
                 else{3} MoFilen :=  qFileNvar;  end;

      EdvNew.PvitaEdvFrm;                      //< -"-   Muuten ei valittu FileNimi tulekaan EdvNewFrm.Captioniin, todettu.
      LueTalFilenReg ('NayB',1,LueFA,KysFA,EdvFilen); //+gOHA 1414:  Talletus Registryyn heti:  Oha 1=Edv  2=NjLask  3=KustLsk  4=Moot.
      if FileLstFrm.Visible                                //<Valinta OK:  Suljetaan listaFrm, muuten saa jäädä
         then FileLstFrm.SuljeBtnClick(Sender);
   end ;//else
      //ShowMessage ('Valittu tiedosto [' +_qFileNvar +'] ei sovellu tähän käyttöön, valitse toinen.'); //<'+1414.
      //_qFileNvar := InputBox('Sopimaton tiedostorakenne',' Valitse toinen','???'); //<Kuten ShowMessage =ERROR.*)
end;//NaytaBtnClick

procedure TFileLstFrm.StrGrAfterPaint(Sender: TObject);      begin
  inherited;
   EdiStrGrSelect (StrGr, 1,StrGr.ColCount-1, StrGr.Row,StrGr.Row);
end;

procedure TFileLstFrm.StrGrKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
     {VAR yy :integer;      }begin
   inherited;  //Caption := 'Key=' +Ints (Key); //<FormShow :sta otettava Caption := ... vex !!
   case key of
     13 :TamaBtnClick(Sender);                                //<Enter
 {33,34 :begin StrGr.Update;
               yy := StrGr.Selection.Bottom;
               Caption := 'yy=' +Ints (yy) +'  top=' +Ints (StrGr.Selection.Top)+
                          '  Btm=' +Ints (StrGr.Selection.Bottom) +'  TRw=' +Ints (StrGr.TopRow);
               erv := yy;// DIV fRivTila;  end;}
     33 :begin erv := erv - StrGr.VisibleRowCount +1;         //<33=PgUp
               if erv<0  then erv := 0;  end;
     34 :begin erv := erv + StrGr.VisibleRowCount -1;         //<34=PgDwn
               if erv>StrGr.RowCount-1  then erv := StrGr.RowCount-1;  end;
     35 :if Shift=[ssCtrl]  then begin                        //<CtrlEnd
               erv := StrGr.RowCount-1;  end;
     36 :if Shift=[ssCtrl]  then begin                        //<CtrlHome
               erv := 0;  end;
     38 :begin if erv>0                 then erv := erv -1;   //<38=CurYlös
               end;
     40 :begin if erv<StrGr.RowCount-1  then erv := erv +1;   //<40=CurAlas
               end;
   end;//case
end;

procedure TFileLstFrm.StrGrMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);      VAR w,i :integer;   begin //+1414d.
   inherited;  w := 0;  //®if isDeb  then WBeep ([50,200,0,200, 500,200,0,200, 1000,200]);
   for i := 0 to StrGr.ColCount-1  do w := w +StrGr.ColWidths[i] +StrGr.BevelWidth;//DefaultLineWidth;
   StrGr.Width := w +0;  FileLstFrm.Width := w +10;
end;

procedure TFileLstFrm.StrGrDblClick(Sender: TObject);      begin
   inherited;
   TamaBtnClick(Sender);   end;

procedure TFileLstFrm.FormClose(Sender: TObject;  var Action: TCloseAction);      begin
   inherited;
   StrGr.ColCount := 0; //<Aiheuttaa sen, ettei Selected näy tummana, tekstin peittävänä alueena =Parempi näin!
   StrGr.RowCount := 0;
end;

procedure TFileLstFrm.FormResize(Sender: TObject);      begin
   //Caption := 'H=' +Ints (FileLstFrm.Height) +'  W='+Ints (FileLstFrm.Width);
   if Height<104  then Height := 104;
   if Width <500  then Width :=  500; //<282 => 500.   Mahd. 645 ???
   //KoeLb.Caption := 'w' +Ints(StrGr.Width) +'  fw' +Ints(FileLstFrm.Width);  KoeLb.Visible := true; //+1414d: Ei näköjään pvitä jos käsin muuttaa...
end;   

procedure TFileLstFrm.FormShow(Sender: TObject);      VAR i :integer;      begin
   if qKieli=''  then qKieli := 'Englanti';
   i := 0;         //< 0=Suomi
   if (Pos ('ENG',  AnsiUpperCase (qKieli)) >0)  or  (Pos ('GBR', AnsiUpperCase (qKieli)) >0)  or
      (Pos ('BRIT', AnsiUpperCase (qKieli)) >0)
      then i := 1; //< 1=English
   if i=0
   then begin
        GrdColFN := 'Tiedoston nimi';
        Accs2_ots := 'Ed.ajopvm';    //<Oli SelD_ots
        Tim_ots :=   '-aika';        //<    SelT_ots, nytTim..{3,5,7}
        Modi4_ots := 'Muutospvm';    //<    +1414
        Cred6_ots := 'Luontipvm';    //<    CreD_ots
        SeiooF :=           'Tiedostoa ei ole, valitse uudelleen!';
        Caption :=          qLstTitle;
      //StrGr.Hint :=       'Valittu  tiedosto väritetyllä rivillä';
        SuljeBtn.Caption := '&Sulje';
        SuljeBtn.Hint :=    'Sulkee ikkunan';
        TamaBtn.Caption :=  '&Tämä';
        TamaBtn.Hint :=     'Valittu tiedosto avataan';
        NaytaBtn.Caption := '&Näytä kaikki';
        NaytaBtn.Hint :=    'Näyttää koko levysisällön';  end
   else begin
        GrdColFN := 'File name';
        Accs2_ots := 'LastAccess';   //<Oli SelD_ots
        Tim_ots :=   '-aika';        //<    SelT_ots, nytTim..{3,5,7}
        Modi4_ots := 'Modified';     //<    +1414
        Cred6_ots := 'CreateDate';   //<    CreD_ots
        SeiooF :=           'Invalid file name, try with new one!';
        Caption :=          qLstTitle;
      //StrGr.Hint :=       'Selected file in colored row';
        SuljeBtn.Caption := '&Close';
        SuljeBtn.Hint :=    'Closes this window';
        TamaBtn.Caption :=  '&SelectThis';
        TamaBtn.Hint :=     'Opens selected file';
        NaytaBtn.Caption := '&Browse';
        NaytaBtn.Hint :=    'Browses disk(s)';  end;
// FileLstFrm.StrGrMouseDown(Self,mbLeft,[ssLeft],X,Y); //<Aiheutetaan valintaa osoittava Rect
// FileLstFrm.StrGrMouseDown(Sender,Button,Shift,X,Y); //<Aiheutetaan valintaa osoittava Rect
//   TamaBtn.SetFocus;      //< Ei voi käyttää tässä (ainakaan näin):  Cell[0,0] näkyisi MUSTANA !!!
end;//FormShow
//==================================================================================================
//==================================================================================================
//==================================================================================================

procedure EdiFileList (zLista :TStringList);      VAR Lista :TStringList;
                                //,oh 1=Created  2=Acces  3=Modif.
   function GetFile_Times (oh :integer;   sFileName : string ) :TDateTime; //+1414: Ks. ..__Delphi-Vihjeet\FileAge
         VAR W32 :TWin32FindData;  Dwr :DWord;  Ft :TFileTime;  h :THandle;  Tdt :TDateTime{=Double: DEVELOPER1};
             FRec :TSearchRec;  {++:LocalTime: TFileTime;  DOSTime: Integer;}

      function FileTimeToDTime(FTime: TFileTime): TDateTime;      VAR LocalFTime: TFileTime;  STime: TSystemTime;   begin    //  (2 |)
        FileTimeToLocalFileTime(FTime, LocalFTime);               //Tämä FNC otettu ulos ,,(1)´stä.                          //  (  |)
        FileTimeToSystemTime(LocalFTime, STime);                                                                             //  (  |)
        Result := SystemTimeToDateTime(STime);                                                                               //  (  |)
      end;                                                                                                                   //  (  |)
                                                                                                                             //  (  |)
      //,,http://forum.lazarus.freepascal.org/index.php?topic=10869.0    ,,(1)  Nyt kommentoisu vex, käytössä vain (2) -merkityt,,,,,.
    (*function aboutfile(fn:string):string;      VAR SR: TSearchRec;  CreateDT, AccessDT, ModifyDT: TDateTime;  Size: Integer;   (  |)
                                                                                                                             //  (  |)
         function FileTimeToDTime(FTime: TFileTime): TDateTime;      VAR LocalFTime: TFileTime;  STime: TSystemTime;   begin //< (2 |) <<<<<<<<<<<<<<<<
           FileTimeToLocalFileTime(FTime, LocalFTime);               //Tämä oli kylläkin erillisenä, siirsin sen tässä sisälle ABOUT..´in ALLE.
           FileTimeToSystemTime(LocalFTime, STime);                                                                          //  (  |)
           Result := SystemTimeToDateTime(STime);                                                                            //  (  |)
         end;                                                                                                                //  (  |)
                                                                                                                             //  (  |)
       begin//aboutfile.................................                                                                     //  (  |)
          if FindFirst(fn, faAnyFile, SR) = 0 then begin                                                                     //  (2 |)
             CreateDT := FileTimeToDTime(SR.F indData.ftCreationTime);                                                        //  (  |)
             AccessDT := FileTimeToDTime(SR.F indData.ftLastAccessTime);; //<,Onkohan tupla";;"´lla merkitystä !?!?!?.        //  (  |)
             ModifyDT := FileTimeToDTime(SR.F indData.ftLastWriteTime);;  //<Vain tätä ja FNC FileTimeToDTime käytetty NOLAssa//< (2 |) <<<<<<<<<<<<<<<<
             Size := SR.Size;
             Result := ('Created: ' + DateTimeToStr(CreateDT) +
               '  and Accessed: ' + DateTimeToStr(AccessDT) +
               '  and Modified: ' + DateTimeToStr(ModifyDT) +
               '  and Size: ' + IntToStr(Size));
          end;
          else
             Result := 'No information';
           FindClose(SR);
       end;//aboutfile ''''''''''''''''''''''''''''''''''''''''''''''''''''(1) 'merkitty on omaa osaansa, josta vain (2) käytetty.*)

   begin//GetFile_Times.................................
      Result := Now;                                              //<Oli herja:  GetFile_Times might undefined.
      h := Windows.FindFirstFile (PChar(sFileName), W32);  			//<Get file information
      if (INVALID_HANDLE_VALUE <> h)  then  begin
         Windows.FindClose( h );			 	    		               //<We're looking for just one file, so close our "find"
         case oh of
            1 :FileTimeToLocalFileTime (W32.ftCreationTime,         Ft); //<,,Convert the FILETIME to  local FILETIME
            2 :FileTimeToLocalFileTime (W32.ftLastAccessTime,       Ft);
            3 ://FileTimeToLocalFileTime (W32.ftLastModificationTime, Ft);
               if FindFirst(sFileName,faAnyFile, FRec) = 0  then begin
                  //,1414f: Netistä korvaava, KUINKA käytän(?): function FileSetDate(const FileName: string; Age: Integer): Integer; overload;
                  //,1415e: W1002 Symbol 'FindData' is specific to a platform how to avoid it.  Tdt :TDateTime
{$WARN SYMBOL_PLATFORM OFF}  // DEVELOPER2: Supress W1002 Symbol 'FindData' is specific to a platform.
                {Oli: }Tdt := FileTimeToDTime(FRec.FindData.ftLastWriteTime); //<Vain tätä ja FNC FileTimeToDTime käytetty NOLAssa//< (2 |) <<<<<<<<<<<<<
{$WARN SYMBOL_PLATFORM DEFAULT}
                  //Tdt := FileDateToDateTime{FileSetDate(sFileName,}FRec.FindData.ftLastWriteTime); //<1415e. <,,Ei vaan onaa. vaikka eipä haittaakaan.
                  //Tdt := FileDateToDateTime({sFileName,}FRec.FindData.ftLastWriteTime); //<1415e.
                  //Tdt := FileDateToDateTime(FRec.ftLastWriteTime);
                  Result := Tdt;  end; //< Tdt="13.02.2015 16:35.34"
          else {4 :}begin FileAge(sFileName, Tdt);            //<Modified. Ks. C:\Projektit_YLE -----\__Delphi-Vihjeet\FileAge\LastAccesYms.rtf
                          Result := Tdt;  end;
         end;
         if oh IN [1,2]  then begin  //<Vain niillä arvotyyppi=Ft joista => Dwr.
            FileTimeToDosDateTime (Ft, LongRec(Dwr).Hi, LongRec(Dwr).Lo);     //<Convert FILETIME to DOS time
            Result := FileDateToDateTime(Dwr);  end; //Dwr="1199669073"       //<Finally, convert DOS time to TDateTime for use in
       end;//if (INV..                             'Result="01.12.2015 15:58:34" Delphi's native date/time functions.
       //CloseHandle(h);
   end;//''Result =Delphi "TDateTime" type which you can convert to a string by using the "DateTimeToStr()" function.

   procedure asetaFrmW;      CONST ScrW=16;   VAR i,x,w :integer;      begin
      with FileLstFrm  do begin
         x := 0;
         for i := 0 to StrGr.ColCount-1  do                     //,x := GetGridWidth ???????????????
             x := x +(StrGr.ColWidths[i] +StrGr.GridLineWidth); //<Method:  GetGridWidth/Height ????
         w := NaytaBtn.Left +NaytaBtn.Width +8;                 //,ScrolBarin Width = 16, koklattu !!!!!!!!!!!!!!
         if w>x  then x := w;                                   //,FrminWidth-ClientWidth = 8, laskettu (ObjInsp)
       //x := x +8{=reunat} +5{=vara};// +16{=ScrlBar};         //<Frm :n leveys pisimmän rivin muk.+..
         ClientWidth := x+2;                                    //,StrGr.Height ei kerro oikein -> ..*fRivTila=OK
         x := fRivTila;
         if (FileLstFrm.StrGr.RowCount * x > FileLstFrm.ClientHeight - FileLstFrm.Panel.Height)  AND
            (FileLstFrm.ClientHeight>0)
            then ClientWidth := ClientWidth +ScrW{16=ScrlBar}; //<Jos kaikki ei mahdu kerralla->ScrBar(=16 koklttu)

         StrGr.Width := ClientWidth;          //FileLstFrm.Caption := 'Wdst:   ' +KoeWidth;
                                                KoeTul ('Widst:   ');
      end;//with
   end;
   procedure SijAsetaFrmH;    VAR i,u{j,-1414d} :integer;  S,sd,st :string;  Tdt :TDateTime{1414};

     {procedure MSecsVex (VAR si :string);      begin                           //TURHA, ks fTimToStr0.
         while (Length(si)>0) and CharInSet(si[Length(si)],['0'..'9'])  do begin
            Delete(si,Length(si),1);
            if CharInSet (si[Length(si)], [':','.','/'])  then begin
               Delete(si,Length(si),1);
               Break;  end;
         end;//while
      end;}

      function fDateToStr0 (Tdt :TDateTime) :string;    VAR yy,mm,dd :word;  sd :string;   begin//1414: Näyttäisi että DateToStr hoitaisi saman.
         DecodeDate (Tdt, yy,mm,dd);                                                            //      Testasin loin Tst.txt 2.10.2016 => 02.10...=OK
         if dd<10  then sd := sd +'0';   sd := sd +Ints (dd) +'.';                              //      mutta jos asiak.koneissa eri pvmMuod, tämäParee.
         if mm<10  then sd := sd +'0';   sd := sd +Ints (mm) +'.' +Ints(yy); //= 2.3.2016 => 02.03.2016
         result := sd;  end;
      function fTimeToStr0 (Tdt :TDateTime) :string;    VAR Hour,Min,Sec,MSec :word;  st :string;   begin//1414. MSec jätetään vex paluuarvosta.
         DecodeTime (Tdt, Hour,Min,Sec,MSec);
         if Hour<10  then st := st +'0';   st := st +Ints (Hour) +':';
         if Min <10  then st := st +'0';   st := st +Ints (Min );
         result := st;  end;

   begin//SijAsetaFrmH...................
      with FileLstFrm.StrGr  do begin
         case COHA of 1 :S := EdvFilen;           //<,,+1414=16å10.,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                      2 :S := NjFilen;
                 else{3} S := MoFilen;  end;
         if Trim(S)<>''  then begin               //,1414cU: oli: LstF[1] => [0], Count oli 1 =Tässä err: "Listindex out of bound [1]."
            if NOT SamIso(S,Lista[0])  then       //<Jos ei ekana ole verkkokuvaajassa (tai Nj´ssä tai Mo´ssa) oleva, korjataan se listaan ekaxi.
               Lista.Insert(0,S);                 //<Nyt on oletFNimi ekana
            i := 1;
            while i<Lista.Count-1  do begin       //<,Poistetaan ekan rvn jälkeisiltä riveiltä sama nimi (jos on), joka juuri sijoitettiin [0]´aan.
               if SamIso(Lista[0],Lista[i])  then //'for i := .. ei käy koska DELETE muuttaa Count´ia, todettu (tuli Err).
                  Lista.Delete(i);
               i := i+1;  end;//while
         end;                                     //<''+1414=16å10.'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

         Options := [goThumbTracking];
         GridLineWidth := 0;
         Color := clWhite;
        {Options := [goVertLine,goHorzLine,goThumbTracking]; //<,,Testaukseen
         GridLineWidth := 1;
         Color := clLime;//}
                                                KoeTul ('Aseta 1:');
        for i := 0 to FileLstFrm.StrGr.ColCount -1  do  //<,,Kavennetaan KAIKKI Cellit, jotta OnWidhest @@@@@@@@@@
             FileLstFrm.StrGr.ColWidths[i] := 0;        //'''@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                                                        //'''@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         ColCount := {6}8;
         RowCount := Lista.Count +1; //<1414: +1 (jätti 1 rv =vikan vex.
         i := RowCount;                                                //<Ei -1, koska osoittaa TODELLISET rivit
         FileLstFrm.StrGr.Height := i *fRivTila;
         if i<6       then i := 6  else
         if i>ruuMax  then i := ruuMax;
         i := i *fRivTila;                                             //,Huomioi CaptionHeight = 27 (sis.reunat)
         FileLstFrm.ClientHeight := i +FileLstFrm.Panel.Height;        //<Määrää Frm:n korkeuden
                                                KoeTul ('Aseta 2:');
         SijMrgCel (0,0,'Rv');       SijMrgCel (1,0,GrdColFN);     //<"Tiedoston nimi"
         SijMrgCel (2,0,'');         SijMrgCel (3,0,'');               //<Näihin sij. lopuksi, kun tiedet. tuleeko
         SijMrgCel (4,0,Modi4_ots);  SijMrgCel (5,0,Tim_ots);          //<"Muutospvm"  "-Aika
         SijMrgCel (6,0,Cred6_ots);  SijMrgCel (7,0,Tim_ots);          //<"Luontipvm"  "-Aika
         u := -1;                                          //<,,+1414d: Jotta eka U olisi 0.
         for i := 0 to Lista.Count-1  do begin //<1414: FixedRows => 0 to ...
                                            //if (i+1 <Lista.Count) and (Trim(Lista[i+1]) <>'')  then begin //<+1414d: Filenimen puuttuessa tulli tyhjä Celli (syy?).
           //j := i+1;                         //<1414: j osoittaa nyt CellRvjä. 1414d: Nyt j => u+1 : Listassa oli filenimi tyhjä mutta SD,ST'ssä oli pvt yms.
             u := u+1;                         //<Pienenee jos txt jää vex jälempnä.
                                            //SijMrgCel (0,j, Ints (j));         //<RvNrointi alkaa 1´stä.  0-rv on otsikolle.
                                            {if Trim(Lista[i])=''
                                                then SijMrgCel (1,j, '???')                //<',,1414d: Tuli tyhjä Celli filenimen kohdalle (syy???)
                                                else}//SijMrgCel (1,j, Lista[i]);          //<',,1414:  j=>i
            S := Trim(Lista[i]);
           if S=''                                        //<,,+1414d.
           then u := i-1
           else begin                                     //<,+1414d.
              SijMrgCel (0,{j}u+1, Ints ({j}u+1));         //<RvNrointi alkaa 1´stä.  0-rv on otsikolle.
              SijMrgCel (1,{j}u+1, S);

{GetFT 2}   Tdt := GetFile_Times(2{LastAcces},Lista[i]);  //<1414. 3=Modif/Write  2=Access  1=Created  4=~FileAge
            sd := fDateToStr0(Tdt);
            st := fTimeToStr0(Tdt);
            ListFD.Add(sd);                      //<,+1414: Jostain syystä missään eioo näitä addeja ja kuitenkin seurRvllä käyttöä.
            ListFT.Add(st);                      //         ..kyllä on, mutta myöhemmin, ks. Sij_LstF_FD_FT, ehkä eri tarkoitus.!?!?.
            SijMrgCel (2,{j}u+1,ListFD[{i}u]);
            SijMrgCel (3,{j}u+1,ListFT[{i}u]);

{GetFT 3}   Tdt := GetFile_Times(3{Modif},Lista[{i}u]); //<,+1414.
            sd := fDateToStr0(Tdt);
            st := fTimeToStr0(Tdt);
            SijMrgCel (4,{j}u+1,sd);
            SijMrgCel (5,{j}u+1,st);

{GetFT 1}   Tdt := GetFile_Times(1{Creat},Lista[{i}u]); //<,+1414.
            sd := fDateToStr0(Tdt);
            st := fTimeToStr0(Tdt);
            SijMrgCel (6,{j}u+1,sd);
            SijMrgCel (7,{j}u+1,st);
                     {if i=0  then begin qFileen(''); qFileen(DateTimeToStr(Now));  end;
                      qFileen(Ints(j) +'  ' +Lista[i] +':1 Crea=' +DateTimeToStr(GetFile_Times(1,Lista[i])));
                      qFileen(Ints(j) +'  ' +Lista[i] +':2 Accs=' +DateTimeToStr(GetFile_Times(2,Lista[i]))); //<'Arvot=samat.
                      qFileen(Ints(j) +'  ' +Lista[i] +':3 Modf=' +DateTimeToStr(GetFile_Times(3,Lista[i])));
                      qFileen(Ints(j) +'  ' +Lista[i] +':4 Mod4=' +DateTimeToStr(GetFile_Times(4,Lista[i])));
                      qFileen(''); //}
           end;//if S=''  else
          //end;//if (i+1 <
         end;//for  *)

         if (FileLstFrm.StrGr.ColWidths [2]>10) or (FileLstFrm.StrGr.ColWidths [3]>10) //<On päiväyksiä TAI aikoja
         //or (1<3) //<1414: Jotta tulisi kaikkien sar´n nimet.
            then begin SijMrgCel (2,0,Accs2_ots);
                       SijMrgCel (3,0,Tim_ots);  end;
                                               {FileLstFrm.KoeLb.Visible := true;
                                                FileLstFrm.KoeLb.Caption := 'H:' +KoeWidth;}
                                                KoeTul ('Aseta 3:');
                                                FileLstFrm.KoeLb.Visible := false;
      end;//with
   end;//SijAsetaFrmH
begin//EdiFileList..............................
   Lista :=  zLista;
   CLteho := {'<b>'+}COLOR_BLUE;
   CLnorm := {COLOR_GRAY;}COLOR_SILVER;

     SijAsetaFrmH;   //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ?????????????¶
     asetaFrmW;      //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Oltava FrmH :n jälkeen, TODETTU. @@@@@@@@@@@@@@@@@@@@@@@@@@@ ?????????????
   FileLstFrm.TamaBtn.Enabled := true; //<Koska valinta asetetaan kuitenkin "päälle"
        FileLstFrm.StrGr.Align := alClient; //<On jätetty alNone :ksi ObjInsp :ssa #################
        FileLstFrm.Width :=  1;     //<,,Vain näin saadaan ScrollBar -tilanne todelliseksi. Muuten
        FileLstFrm.Height := 1;     //   Formimitat ei asetu oikein ja ScrollBar ilmestyy, TODETTU
        FileLstFrm.Show;            //   @@@@@@@@@@@@@@@@@@@ Ks. myös OnClose @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
        FileLstFrm.StrGr.SetFocus;  //<Cells[0,0] :n "selecte" -maalaus saadaan vex ja FOCUS jää!!!!
        FileLstFrm.Close;           //   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
     SijAsetaFrmH;   //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
     asetaFrmW;      //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Oltava FrmH :n jälkeen, TODETTU. @@@@@@@@@@@@@@@@@@@@@@@@@@@
//   varitaRivit (FileLstFrm.StrGr.FixedRows); //< -5.0.0
     FileLstFrm.StrGr.Col := 1;
     FileLstFrm.StrGr.FixedRows := 1;                    //<1414.
     FileLstFrm.StrGr.Row := FileLstFrm.StrGr.FixedRows; //< +5.0.0  1414: Vissiin maalautuu valituksi(olet).
     erv := 0;
                            //,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   FileLstFrm.ShowModal;    //<@@@@@@@@@@@@@@@@@@@@@@ OHA PYSÄHTYY TÄHÄN KUNNES SULJETAAN @@@@@@@@@@@@@@@@@@@@@@@@
end;//EdiFileList
//================================================================================================================
{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ LISTAN TALLETUS VAIN kun LueFA @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@''''''''''''''''''''''''''''''''@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ KUVAUS-TIIVISTELMÄ @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ???}
//================================================================================================================
                  //,,+1413=16å4:  Siirretty Sij_LstF_FD_FT´in sisältä, minne se oli siirrty Y_gLueTal_FileLista´sta. OLI: isTypeNolaFileOha takas isTypeNolaFileOk.
                  //Jos qOHA>0 ja Filen OnOlemassa JA qOhaTyyppinen => FNC=TR  MUUTEN FNC=FA ja SOUT=KäyttötarkoitusStr
         function TFileLstFrm.isTypeNolaFileOK (qOHA :integer;  Filen :string;  VAR Sout :string) :boolean; //Pal (EdvFileTypen) EdvNimet.txt jos on OK.
               VAR EdvInif :TInifile;  so,sq,ss,err :string;  n :integer;      begin
                        DebWr(2,'1/3','isTypeNolaFileOK / FileLstN.PAS:  Filen= ' +Filen);
           {result := false;  }ss := '';                //Jos INIFfile on, FNC tutkii tyypin. Jos eioo haluttua tyyppiä, herjaa ja kertoo mihin NOLAtarpeeseen.
            if FileOnEiEmpty(Filen)  then begin
               EdvInif := TInifile.Create(Filen);
               ss := EdvInif.ReadString ('Version','FileType',err); //<Ei ole kumpikaan CASE herkkiä, koklattu.
               EdvInif.Free;                                   //,Tutkit. tyyppi ja vrt onko se oikeaa tyyppiä.
               case qOHA of 1 :so := EdvFileType;           // EdvFileType = 'EdvFileNOE';   EdvFiletN = 'EdvNimet.txt';
                            2 :so := NjFileType;            // NjFileType =  'NjFileNON';    NjFiletN =  'NjNimet.txt';   HävKustFile sis NjFilee´seen
                            3 :so := MoFileType;            // MoFileType =  'MoFileNOM';    MoFiletN =  'MoNimet.txt';
                         else  so := 'Tunnnistamaton'; end; //,OLATAVA SAMOJA, MUUTEN fILEN ON EKSYNYT TÄHÄN LISTAAN VIRHEEN KAUTTA, esim. minä olin avannut
               result := ss=so;                             // POUSIn Nj-filen luullen sitä Edv-fileksi ja se joutui tähän listaan. TÄMÄN TAKIA KOKO FNC isTypeOK..
                        DebWr(2,'2/3','isTypeNolaFileOK / FileLstN.PAS:  Filen= ' +Filen +'  §§§: ss= ' +ss);
               sq := so;                                     //<Mahd. loppuherjaa varten.
               if SamIso(ss, EdvFileType)  then n := 1  else
               if SamIso(ss, NjFileType)   then n := 2  else
               if SamIso(ss, MoFileType)   then n := 3  else n := 4;
               case n of
                  1 :so := 'Ed.verkon tiedosto';
                  2 :so := 'Nj-laskennan tiedosto';
                  3 :so := 'Moot.lähtöjen tiedosto';            //<,Näissä Nro eri kuin OHAluettelossa edellä.  1414: Mahtaakohan olla eri, näyttäisi olevan OK.
               else  so := '?Tuntematon käyttötarkoitus';  end;
            end else//if FileOnEiEmpty
            begin//Filen eioo t. ..
               result := false;
               so := '?Tuntematon käyttötarkoitus';
            end;                                             //,ShowMessage´a ei voi käyttää => Acces..ERROR, ei vielä käytettävissä =Ei luotu vielä.
            if NOT result {and xKYSY}  then begin            // mutta kun on KYSY -tapaus, on luonnit jo suoritettu (Show.. + InfoDlg =OK).
               ss := Filen +'  ' +so; // +' (ei ole käytettävissä, ohitetaan).';
               Sout := ss;  end; //<1413.                    //InfoDlg (ss, mtCustom, 'OK','','','',  '','','','');  //<'1413:  -xKYSY,-InfoDlg.
                        DebWr(2,'3/3','isTypeNolaFileOK / FileLstN.PAS:  Filen= ' +Filen +'  §§§: ss= ' +ss  +'  so= ' +so);
         end;//isTypeNolaFileOK
//======================================================================================================================================================
       (*function TFileLstFrm.isTypeNolaFileOkI (Filen :string) :integer; //1414fu: Pal EdvFileTypeNron 1..3 jos OK, 0=EiOK.  1415d: ..OkI => ..OK
               VAR EdvInif :TInifile;  so,ss,err :string;  n :integer;      begin
                           DebWr(3,'1/3','isTypeNolaFileOhaI / FileLstN.PAS:  Filen= ' +Filen);
            n := 0;
            if FileOnEiEmpty(Filen)  then begin
               EdvInif := TInifile.Create(Filen);
               ss := EdvInif.ReadString ('Version','FileType',err); //<Ei ole kumpikaan CASE nuukia, koklattu.

               if SamIso(ss, EdvFileType)  then n := 1  else // POUSIn Nj-filen luullen sitä Edv-fileksi ja se joutui tähän listaan. TÄMÄN TAKIA KOKO FNC isTypeOK..
               if SamIso(ss, NjFileType)   then n := 2  else //Häviökustannuslaskennan tiedoston, 1414: Sis. NjFileeseen.
               if SamIso(ss, MoFileType)   then n := 3;
                        DebWr(3,'2/3','isTypeNolaFileOhaI / FileLstN.PAS:  Filen= ' +Filen +'  §§§: ss= ' +ss);
               EdvInif.Free;                                 //<Err vaikka siirrettäis PRCn loppuun 1413=16å4.
            end;//if FileOnEiEmpty()
            result := n;
                           DebWr(3,'3/3','isTypeNolaFileOhaI / FileLstN.PAS:  Filen= ' +Filen +'  §§§: ss= ' +ss  +'  so= ' +so);
         end;//isTypeNolaFileOkI*)
{=======================================================================================================================================================
§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§}
                                       {,,OS annetaan FileEv(..Nj,..Mo)´ssä josko niistä vois päätellä onko kutsu eri kohdasta tms.
                                        ,,11..14=Edv  21,22=Nj  31,32=Mo }
//        function Y_gLueTal_FileLista (os,oha :integer;                    LUE,KYSY :boolean;   VAR aoFileN :string) :integer;  VOISKO YHDISTÄÄ?!?!?!?!?
function TFileLstFrm.fLueTal_FileLista (OS,xOHA :integer;  xKieli :string;  xLUE,xKYSY :boolean; //1413: +xOHA
                                        xDlgTitle,xLstTitle,xFilter :string;  VAR xFileNvar :string) :boolean; //<DEVELOPER1 1414fu: -xListaFileN siirttyTänne.
      CONST RiviMax=30;  LueTR=TRUE;  LueFA=FALSE;   TalTR=TRUE;  TalFA=FALSE;
      VAR boo,IuIeEri,samat :boolean;  m,k :integer;  LstFnU,LstFnE,Bfn,uSLstFn,LstOkEfn,S,sa :string;{:1414f}
          LstF,     onok_FLst,   eioo_FLst,   eiOK_FLst,   LstIu,LstIe :TStringList;
      //  'EdvNimet 'OKfilet     'puuttuu     'eiOkTyyppiä 'TunnistusJoskoSamaKuinÄsken (koska tulee AINA 2krt sama, vaikkakin 4-kohtaa.)
      //  HAKUSANOJA:  Err ToErrFile  Load Save  Sij Sij_LstF_FD_FT  ListaFileN
   //................................................
      //  ,ErrLaji:  0=eioo_FLst´stä  1=eiOK_FLst´sta
   procedure ToErrFile(ErrLaji :integer;  SLst :TStringList;  DblVii2 :integer{EiKäytössä});      VAR LstOut,uSLst :TStringList;  i :integer;

      function onjoLstX_ssa (si :string;  LstX :TStringList) :boolean;      VAR u :integer;   begin
         result := false;
         if LstX.Count-1 >0   then
         for u := 0 to LstX.Count-1  do
         if CompareText(si,LstX[u])=0  then begin    //<..returns 0 if they are equal, not Case sensitive =0 jos samoja.
            result := true;  Break;  end;
      end;

      function fVii (c :string) :string;      begin//Tekee väliviivan.
         if Pos('-',c)>0  then Result := c[1]+'^`-----------------------------------------------------------------------------------------------------------'  else
         if Pos('=',c)>0  then Result := c[1]+'^`==========================================================================================================='  else
                               Result := c[1]+'^`///////////////////////////////////////////////////////////////////////////////////////////////////////////';
      end;

      //================================================================================================================================================
      procedure LisaaSLst_JosEiJoOle_OSvalissa (OS,ErrLaji :integer);    VAR Su,Se,So,S1,S2,SLstFN :string;
                                                                             boo :boolean; nLst :TStringList{1414f};
                      {¶- uArr,sArr :array of string; {Vain apuna kehitssä,¶} k,i,e,n :integer;
                                   //'nLst ja SLst KOPIOIDAAN DynArr´eihin, testialkiot näkyy DEBUGISSA jonona: ('A1,'B_',C3'..).
                  {################# Tänne tullaan alkukutsulla ToErrFile(eioo_FLst tai eiOK_FLst) jotka jo luetteloita virheensä mukaan.###############
                   ################# Täällä vain tarkistetaan ja karsitaan samat rvt sekä lopuksi liitetään yhteen LstOut´iksi.       ##################}
         function valivii(si :string) :boolean;      VAR k,g :integer;   begin
            k := Pos('====',si);  g := Pos('----',si);
            result := (k>0) and (k<5) OR (g>0) and (g<5); //<Rvn lopussa oleva välivii ei lueta väliviiRvksi.
         end;
    //Ks. C:\Projektit XE2\NolaKehi\SRC\Common\Testattu OSetsintä.txt, jota ei siis käytetty mutta oli OK testattuna.
      procedure nLstAdd(si :string);      {¶-VAR L :integer;   }begin //<Tämä jotta debugissa voi cur´lla osoittamalla nohdä KOKO nLst´in sisältö (sArr).
        {¶-L := Length(uArr);               //<uArr ja sArr ovat vain kehitVaiheessa apuna, niistä näki CURilla koko testipötkön ('A1',B_'..) jne.TOSIHYVÄ
         SetLength (uArr,L+1);
         uArr[L] := si;//¶}
         nLst.Add(si);   end;

      begin//LisaaSLst_JosEiJoOle_OSvalissa = Verrtaan tulossaOlevan SLst rvjä nLst rveihin (kasvaa rvittäin) onko jo sama olemassa, nSLst´iin josEiJoOo.
            //===Alussa kun Count=0 =seursta ohi LstOu.SaveToFile´een koska WHILE o<=.. Vasta kun 1. nLst.SaveToFile(), on tutkitavaa.################
            //===KOSKA FileEv.Inc/LueTalEdvFile´ta (yms) tulee 2 kutsua (eioo + eiOk), käydään läpi nSLst´in KAIKKI saman ohaOsan (OS:X..) etteiJoOle.
            //,,########################################################################################################################################
            //,,Tässä TÄRKEIN tutkintaselvittely:  Onko tämä OS:N -väli KOKONAISUUDESSAAN jo nSLst´ssa.#################################################
            //''########################################################################################################################################
      //,,TOSIhYVÄ kehitssä,,###########################################################################################################################
//,,Etsi mrk "¶" jolla MERKITTY hyvät lisäykset TESTIkäyttöön.##########################################################################################
      {¶-     if isDeb  then begin SLst.Clear; SLst.Add('A1'); SLst.Add('B_'); SLst.Add('C3'); SLst.Add('B_'); SLst.Add('D5'); SLst.Add('E6');
                SetLength(sArr,6);  sArr[0] := 'A1'; sArr[1] := 'B_';  sArr[2] := 'C3';  sArr[3] := 'B_';  sArr[4] := 'D5';  sArr[5] := 'E6';  end;
      //''''''''#######################################################################################################################################}
      if (So='') or (SLstFN='') or (LstFnU='') or (uSLst=NIL)  then ; //<1414f: Ettei ..never used kun ¶..¶ ohitettu {..}´lla.

      Su := 'OS:' +Ints(OS);           //<Su ="OS:x"      =SLst´in OS.
      Se := 'ERRLAJI:' +Ints(ErrLaji); //<Se ="ERRLAJI:x" =SLst´in ErrLaji (0 tai 1).
      Delete (Su,5,99);                //<"OS:14" => "OS:1"  tai Copy(Su,1,4);
      nLst := TStringList.Create;              //<,1414f: Tähän kaikki SLst´stä tarkistuksen jälkeen ja lopussa summatataan LstOut´in perään =AddStrings().
    {¶°SLstFN := ExtractFilePath(LstOutErrFn);  //,..LstOut~.tmp talletus vasta tämän PRCn lopussa kun kaikki tarkistetut SLst´stä lisäilty nLst´aan.
         SLstFN := SLstFN +'$^$Err-SLst~.tmp'; //<..BIN\$^$Err-SLst~.tmp  =Sisään tulossa olevat rivit (SLst).
         if isDeb  then SLst.SaveToFile(SLstFN); //,Näyttää tulossa olevan SLst´n sisällön.
                              //'G:\__D\Mun_Downloads\Notepadeja\nPad2\Notepad2.exe', PChar(SLstFN), nil, SW_SHOW);
                              if isDeb  then ShellApi.ShellExecute(Application.Handle,'open', 'C:\Windows\NotePAD.EXE', PChar(SLstFN), nil, SW_SHOW);//¶}
         //''SLst on esim. EdvNimet.txt =VrkLstFileN "raaka"sisältö.
      boo := (SLst.Count>=0) AND ((Pos('OS:',SLst[0])>0) or (Pos('ErrLaji:',SLst[0])>0)); //< Pos>0 =Onko 0.rvllä "ErrLaji" oli Laji 0 tai 1 (kumpi vaan).
             {¶boo := true;}
      if boo                                      //'1414f': SaveToFile =Testailua, näkee, mikä on fileen sisältö ennen parsintaa ja sen aikana.
      then begin                                  //<,################# Siirretään tulossa olevat SLst[] nLst´iin jos ei jo ole siellä.#################
         n := 0;  k := 0;
{->}     if FileOnEiEmpty(Bfn)  then begin //<,Ruvetaan jatkamaan edSilmukan perään.  Bfn= '$^$Err-nLst~.tmp'  =nLST´iin kopioidut rvt.
{}        //nLst.LoadFromFile(Bfn);
{}          nLst.AddStrings(SLst);                //<eiOK_FLst´n käsittelyyn, jolloin SLst´ssä herjat ja eiOk -luettelo VALMIINA.
{}       (*¶°S1 := ChangeFileExt(Bfn,'_L¨~.tmp');   //<',+1414f:  S1="..BIN\$^$Err-nSLst_L¨.tmp" .
{}          SLst.SaveToFile(S1);
{}                                 if isDeb and NOT FileExistsAndEmpty(S1)  then begin //,,Näyttää jo olevan nLst´n (sij edKrralla), ks. alempna.
{}                                    ShellApi.ShellExecute(Application.Handle,'open', 'C:\Windows\NotePAD.EXE', PChar(S1), nil, SW_SHOW);
{}                                    DeleteFile(S1);  end;//¶*)
{}          k := 9;  end;                         //<,1414f: eiOK_FLst osuudet, edKrt oli eioo_FLst ja nyt nLst lisätään lopussa LstOut´iin.
{}       if k=0  then                             //<Vain eooo_FLst tässä käsittelyssä.
{}       for i := n to SLst.Count-1  do begin
{}          if (i=0)                              //<,Jotta saadaan EKA alkio (SLst[0]) vertailtavaksi seurKrrlle nLst[0]´aan(?).
{}          then begin nLstAdd(SLst[i]);          //<,Pakko tutkia edeltvät myös josko on jo sijoitettu hetki sitten. TODETTU TARVE.
{->}                             {¶"if isDeb  then nLst.SaveToFile(Bfn);  //<,Tämä mielekäs vain testVaiheessa, jolloin myös uArr ja sArr käytössä.¶}
            end
            else begin                            //<Jälempnä lisättävä SLst[i] ei vaikuta, koska sehän on jo uusi ja tutkit seurKrlla.
               s1 := Trim(SLst[i]);
               s2 := '';                          //<Vain jotta debugissa vanha ei turhaan näkyisi Watch List´issa.
               for e := 0 to nLst.Count-1  do     //<Tutkit AINA nLst´n alusta asti.
               begin
                  s2 := Trim(nLst[e]);            //if SamIso(Trim(nLst[e]),Trim(SLst[i]))  //s2 := AnsiUpperCase(s2);
                  if (AnsiSameText (s1,s2))       //Ei casesensitive, TR jos samoja.
                  then Break
                  else if (e=nLst.Count-1)
                          then nLstAdd(SLst[i]);
                                     {¶"if uArr[0]+sArr[0]<>'' then ;         //<Tässä cur näyttää koko uArr (=nLst) ja sArr (=SLst) sisällön.¶}
                                     {¶"if isDeb  then nLst.SaveToFile(Bfn);  //<,Tämä mielekäs vain testVaiheessa, jolloin myös uArr ja sArr käytössä.¶}
               end;//for e
            end;//else
         end;//for i
         if ErrLaji=0
         then nLst.Add(fVii('1-'))                //<Z` vain sorcekohdan tunnistamiseksi. Z`-Väliviiva vain eioo_FLst´n jälkeen =sen ja eiOK_FLst väliin.
         else begin
              nLst.Add('');
              nLst.Add(fVii('2='));
         end;                     {¶"if isDeb  then nLst.SaveToFile(Bfn);  //<,Tämä mielekäs vain testVaiheessa, jolloin myös uArr ja sArr käytössä.¶}
      end;//if boo                                //,§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
      //¶"if isDeb  then WBeep([200,100, 0,200, 500,200]);
      {¶° S1 := ChangeFileExt(SLstFN,'-Z¨~.tmp'); //Bfn
         nLst.SaveToFile(S1);                     //,Näyttää tulossa olevan SLst´n sisällön.¶}
                                  {¶"if isDeb  then ShellApi.ShellExecute(Application.Handle,'open','C:\Windows\NotePAD.EXE', PChar(S1), nil, SW_SHOW);
                                    if then DeleteFile(S1);//¶}
      LstOut.AddStrings(nLst);
      LstOut.SaveToFile(LstOutErrFn);             //<AINOA LstOut.SaveToFile(LstOutErrFn). PaaVal.PAS´ssa sama ,,err-näyttö (NotePad) jakeluversiolle.
                                  {¶¶ø if isDeb and FileOnEiEmpty(LstOutErrFn)  then ShellApi.ShellExecute(Application.Handle,'open',
                                                                                 'C:\Windows\NotePAD.EXE', PChar(LstOutErrFn), nil, SW_SHOW);//¶}
      nLst.Free;
      //OSrvTlk.Free;
   end;//LisaaSLst_JosEiJoOle_OSvalissa;
//======================================================================================================================================================
//======================================================================================================================================================
   begin//ToErrFile +1413. .......................... LstOutErrFn = "..\BIN\$_$Err-LstOut~.tmp';
      if SLst.Count>0  then begin                    //Tänne tullaan:  1. eioo_FLst'stä  2. eiOK_FLst´stä.
         LstOut := TStringList.Create;               //,,################## KAIKKI teksti sijoitetaan SLst´iin, mistä vasta LstOut´iin #################
      {¶+} uSLst := TStringList.Create;              //  ja siitä LstOut´iin, uSLst.SaveToFile(uSLstFn), mitä voi katsella heti SAVE´n jälkeen.
         if FileOnEiEmpty(uSLstFn)   //<Täällä edit LstOut´iin tulevat FNimiRivit (SLst) edKerralla luettujen JÄLKEEN.##############
            then uSLst.LoadFromFile(uSLstFn);      //<################################################################################### ¶}
         if FileOnEiEmpty(LstOutErrFn)      //<LstOut´ssa jo olevat FNimiRivit.
            then LstOut.LoadFromFile(LstOutErrFn); //<''##################################################################################
         if uSLst.Count>0
            then uSLst.Add('');                    //<VäliRv ennen seurRvjä.
         if LstOut.Count=0
            then uSLst.Add('   LstOut on tyhjä, nyt vasta alkaa SLst´sta js selityksistä koostua LstOut´in sisällöksi.'); //Tämä vain ekallaKrlla.
      {¶" Bfn := ExtractFilePath(LstOutErrFn);      //,..LstOut~.tmp talletus vasta tämän PRCn lopussa kun kaikki tarkistetut SLst´stä lisäilty siihen.
         Bfn := Bfn +'$^$Err-nLst~.tmp';           //<..BIN\$^$Err-nLst~.tmp =nLST´iin kopioidut rvt. ¶}

         uSLst.Add('   Tulossa SLst LstOut´iin: >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
       //SLst.Insert(0,fLst_OSrv('Q¹  Tiedostonimi: ' +LstOutErrFn)); //<,1414f:  +Tied...   fLst_OSrv korvattu suorSij´lla.
         SLst.Insert(0,'OS:' +Ints(OS) +' ErrLaji:' +Ints(ErrLaji) +'  Ajo: ' +DateTimeToStr(Now) +' Q¹  Tiedostonimi: ' +LstOutErrFn);

         if ErrLaji=0                                //,AlkuperRvt SLst´ssä siirtyvät loppuun päin seurssa:  uSLst.Add(SLst[]).
         then begin
         {¶" if FileOnEiEmpty(Bfn)             //<EkaKrtTänneTullessa delataan vanha jos on
               then DeleteFile(Bfn); //<'...\BIN\$^$Err-nLst~.tmp' ¶}
            SLst.Insert(1,'   [' +VrkLstFileN +'] -ajotiedostolistassa on seur. tiedostoja, joita ei LÖYDY'+Chr(10)+
                            '(mahd. siirretty alkuper. sijainniltaan muualle):');  end
         else begin
            SLst.Insert(1,'[' +VrkLstFileN +'] -ajotiedostolistassa seuraavat polut/tiedostot ovat'); //VrkLstFileN = "EdvNimet.txt"
            SLst.Insert(2,'   virheellisiä ja ne ohitetaan. Voit korjata näitä esim. Notepad´issä.')  ;
            SLst.Insert(3,'   Huomaa, että verkon yli toimittaessa polkumääritys yleensä alkaa');
            SLst.Insert(4,'     esim. "\\..." ellei verkkopolkua ole ns. mapattu (uudelleennimetty levyasematunnukselle).');
            SLst.Insert(5,'   VOIT KUITENKIN NYT JATKAA. Talleta tämä UUDELLE nimelle mahd. myöhempiä tarkasteluja tai muutoksia varten.');
          //SLst.Insert(6,'>>TÄMÄ [' +{LstOutErrFn }VrkLstFileN {FileErr_1FN} +'] TIEDOSTO SIIVOTAAN :');
            SLst.Insert(6,'V i r h e e l l i s i ä: , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , ,');
         end;              //'AlkuperRvt SLst´ssä siirtyvät loppuun päin seurssa:  uSLst.Add(SLst[]).
         for i := 0 to SLst.Count-1  do
            uSLst.Add(SLst[i]);                      //<Ints.. vex ettei sotke rivivertailuja (SLsr[] vs LstOut[]).
         uSLst.Add(fVii('3'));
       //uSLst.Add('');                              //<Loppuun tyhjäRv.
      {¶+} if isDeb  then
            uSLst.SaveToFile(uSLstFn);               //<=..Polku +'$_$Err-LstOut~.tmp£££ -file.  <uSLstFn ny vasta luettavissa, LstOutErrFn ei vielä.¶}
         uSLst.Free;                                 //<Nyt jos uSLdt´iin lisätään jotain, on ekax LoadFromFile(), ks. esim. newUSLst_Save´ssa.

         if FileOnEiEmpty(LstOutErrFn)  then  //<=..Polku +'$_$Err-LstOut~.tmp.  <,,Uudet virheilmoitukset edellisten perään.
            LstOut.LoadFromFile(LstOutErrFn);        //'Pakko testata, muuten: Can´t open ...
{>>>>>}  LisaaSLst_JosEiJoOle_OSvalissa(OS,ErrLaji);
         LstOut.Free; //<+1414f
      end;//if SLst.Count>0
   end;//ToErrFile
   //=====================================================================================================================================================
   //=====================================================================================================================================================
   function fSaveFileDlg (zOHA :integer;  zTitle,zFilter :string;  VAR zFileN :string) :boolean;
         LABEL 1;   VAR sA,SX,ss,su :string;   begin //<1414fu: +zOHA vex takas.
      with FileLstFrm  do begin  //,,PoistaaChkBoxin,PäällekirjPrompti,MsgIfNoPathExist<<<<<<<<<<<<<
         SaveDlg.Options := [ofHideReadOnly,ofOverwritePrompt,ofPathMustExist,ofEnableSizing];
         SaveDlg.Title := zTitle;
         SaveDlg.Filename := zFilen;
         SaveDlg.Filter := zFilter;  {fOhaS (oha) +'tiedostot (*.'+ExtN+')|*.' +ExtN+'|Käyttäjän omat tiedostot (*.*)|*.*';}
         sA := zFilen;               //<<+1414fu:  Kopioitava filenimi jos Execute.
1:       SX := sA;                   //' Alp talteen sA.
         result := true;
         if SaveDlg.Execute
            then begin
                 zFilen := SaveDlg.Filename;              //<FileName palauttaa Full Path ########
                 case zOHA of
                    1 :ss := iso(filen_Ev); //= 'Olet-Ev.NOE';
                    2 :ss := iso(filen_Nj); //= 'Olet-Nj.NON';
                    3 :ss := iso(filen_Mo); //= 'Olet-Mo.NOM';
                 end;
                 su := iso(ExtractFileName(zFilen));
                 if ss=su  then begin
                    ShowMessage('Nimi "' +ss +'" on varattu ensiajon oletustiedostoksi, anna jokin muu nimi.');
                    GOTO 1;  end;

                 case zOHA of              //<,,+1414f
                    1 :EdvFileN := zFilen;
                    2 :NjFilen := zFilen;
                    3 :MoFilen := zFilen;
                 end;
                 CopyFile(PChar(SX),PChar(zFilen),false); //<+1414fu.
                 if FileOnEiEmpty(zFilen)
                    then LueTalFilenReg ('Sav',zOHA,LueFA,KysFA,{VAR}zFilen); //1414fu Tallet Reg´iin.
                 if zFilen = '-1-'  then ;  end    //<Debuggerille.
            else result := false;
      end;//with
   end;//fSaveFileDlg
   //=====================================================================================================================================================
   //=====================================================================================================================================================
                                                                      //,Tekee listat eioo_FLst, eiOK_FLct, onOKLst yms ja TALLETTAA jos TAL pyydetty.
   function fLueTalChkLista (LUE :boolean;  qFileN :string) :boolean; //<,,OLI: fLueTalOrdLista.
      VAR S :string;  i,j,k{,Handl} :integer;  boo,bos{1414} :boolean{1202};
          LstQ :TStringList{1413=16å4};
      //................................................
      function TyhjaNimi (SV :string) :boolean;     begin
        result := Trim(SV)='';       //<1413=16å4  //for i := 1 to Length (SV)  do if SV[i]<>' '  then begin ...}   //<Yksikin todMrk => FA.
      end;
      //................................................

      procedure Sij_LstF_FD_FT (str :string);      VAR m :integer;  sa,sx,SD,ST,sv :string;   {edLst :TStringList 1414d;}//1202: Kokonaan uusiksi.
                                               //str =09.10.2012 09:00:52 \\Reijo-xp\e\Projektit XE2 1200\NolaKehi\BIN\Data\Horneman\Horneman-PK4-4.noe
                                               //                         \\REIJO-XP\xE\ProjektitOhat\OmaBrows\Apu.txt
         function onLSTssa (si :string;  {VAR }nLst :TStringList) :boolean;      VAR i :integer;   begin //+1414.
            result := false;
            //si := fDTvexVainFN(si);
            for i := 0 to nLst.Count-1  do
               if AnsiUpperCase(si)=AnsiUpperCase(nLst[i])  then begin
                  result := true;
                  Break;
               end;
         end;//onLSTssa
//Ks. C:\Projektit XE2\NolaKehi\SRC\Common\eiVerkonYlikaan.txt, missä valmis FNC verkon yli tutkivasta versiosta.
      begin//Sij_LstF_FD_FT                              //,141: Vissiin/ehkä StrGr´stä luettaessa ?!?!?
         str := Trim(str);  //Verkkoaseman oikea polku:  löytyy netistä Googlella: "GetUNCName" ja "WNetGetUniversalName"
         sa := str;                                      //<ALP talteen.                            //<,,,+1202
       //t := Pos('\\',str);                             //<Tutkit onko verkko-osio,
         SD := '';   ST := ''; //ss := AnsiUpperCase (str);    //<,Koska Ansi..Fnc kutsu ei onaa ehdossa(???)
         sx := '';  m := 0;                                    //<,,+1413: Luetaan alukRv =ohitet nrot yms mrkt =Loppuosa on FileNimi polkuineen.
         while (str<>'') and CharInSet(str[1],['0'..'9', '.', ':', ' '])  do begin   //<,,Luetaan DATE ja TIME -osat, jää STR =ao. filenimi.
            sx := sx +str[1];                                  //'1414d: +str<>''  aih. errorin, nyt OK.
            if str[1]=' '  then
               if m=0
               then begin
                  SD := sx;  sx := '';  m := 1;  end
               else begin
                  ST := sx;  sx := '';  m := 1;  end;
            Delete(str,1,1);
         end;//while                        //,,HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ HYVÄ
         str := Trim(str);                 {qFileen(DateTimeToStr(Now));  qFileen('LstF: LstF.Count=' +Ints(LstF.Count));
                                            for m := 0 to LstF.Count-1  do qFileen('  LstF[' +Ints(m) +']=' +LstF[m]);  qFileen('onok_FLst:');
                                            for m := 0 to onok_FLst.Count-1  do qFileen('  onok_FLst[' +Ints(m) +']=' +onok_FLst[m]); //}
         if NOT FileOnEiEmpty(str)   //<130.2eµ, 1314,1414f
         then begin                         //,,,,1413: Jätin koko verkon yli tutkimisen vex, oltava kuten on kirjattu, muuten tulkit. eioo.
            //if eiVerkonYlikaan  then,,    //<Tähän lisäys jos tutkitaan tilanne verkon yli...
            if Trim(str)<>''  then          //<,Ettei tyhjää filenimeä listaan.
               eioo_FLst.Add(str);
            if isDeb  then eioo_FLst.SaveToFile('C:\Projektit XE2\NolaKehi\BIN\$¨$Err-Nj~.tmp');
         end //C:\Projektit XE2\NolaKehi\BIN\$_$\Kehi\Nj
         else if isTypeNolaFileOK(xOHA,str,sx)      //<1413:  SX :=.. jos herjoja, ks. ELSE,,.. +xOHA.
         then begin                                         //<,,Nämä ovat sellaisenaan päteviä FNimiä, jotka filet myös löytyvät ja ovat OK.
            if sd<>''  then ListFD.Add (sd);                //<EditDate: SD
            if st<>''  then ListFT.Add (st);                //<EditTime: ST
            if NOT onLSTssa(str,onok_FLst)  then begin
               onok_FLst.Add(str);                   //<'+1414f: STR´ssä eioo PV+TIM enää, vain FN.
               onok_FLst.SaveToFile(LstOkEfn);  end;
         end
         else eiOK_FLst.Add(sx);          //for m := 0 to LstF.Count-1  do qFileen('  LstF[' +Ints(m) +']=' +LstF[m]);  qFileen('');  end;
                                           {qFileen('LstF:  LstF.Count=' +Ints(LstF.Count) +' FD.Count=' +Ints(ListFD.Count) +'  FT.Count=' +Ints(ListFT.Count));
                                            for m := 0 to LstF.Count-1  do qFileen('  LstF[' +Ints(m) +']=' +LstF[m]);
                                            qFileen('onok_FLst:');
                                            for m := 0 to onok_FLst.Count-1  do qFileen('  onok_FLst[' +Ints(m) +']=' +onok_FLst[m]);  qFileen(''); //}
         if sa +str +sv = '"#¤%&/'  then ;  if eioo_FLst.Count +eiOK_FLst.Count +ListFD.Count +ListFT.Count <0  then ;
      end;//Sij_LstF_FD_FT
                                          //,,Palauttaa AjoDaten + Timen yhtenä stringinä talletusta varten ######
      function fAjoDateTime :string;      VAR {DateTime :TDateTime;  }o :integer;  sd,st :string;      begin
         st := '';
         sd := DateTimeToStr (Now);   //< Tai:  sd := TimeToStr(Time);
         Delete (sd,Length (sd)-3,3);                 //<Poistetaan sadasosamrk ':' ja sen numerot
         o := Pos (' ',sd);
         if o>0  then begin                           //<'Etsitään Daten ja Timen VÄLI ...
            st := Copy (sd,o+1,Length (sd));          //< ja loppuosa Timeksi = ST
            Delete     (sd,o  ,Length (sd));          //< ja alkuosa ennen ' ' jää Dateksi = SD
         end;
         result := sd +' ' +st;
       end;//fAjoDateTime

       procedure Lisaa (VAR yhtLst :TStringList;  JatkoLst :TStringList);      VAR i :integer;   begin
          for i := 0 to JatkoLst.Count-1  do
             yhtLst.Add(JatkoLst[i]);
       end;

   begin//fLueTalChkLista ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      result := false;           //<@@@@@ RESULT @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      onok_FLst.Clear;
      eioo_FLst.Clear;
      //ListFD.Free;
      ListFD := TStringList.Create; //<,,1414d:  Muuten Err.
      //ListFT.Free;
      ListFT := TStringList.Create;
      LstF := TStringList.Create;          //<,,1413=16å4:  ListFile => LstF. Jo tässä. muuten herjaa Might not..iniz.
      if FileOnEiEmpty(VrkLstFileN) //<..\EdvNimet.txt .
      then begin //IDEA:  Tutkitaan VrkLstFileN -tiedostot. Jos fileä ei ole, se sijoitetaan SijListoihiSij_LstF_FD_FT´ssa EIOO_FLST´hin, jos on VÄÄRÄÄ
                 //       tyyppiäesim. Nj-tyyppiä Edv -osassa, ne sijoitetaan eiOK_FLst´iin.  ONGELMA: Kutsuja tulee 2xEsim. FileEv.INC´stä, joten
                 //       samoja rvejä tulee myös 2x, joka estetään tutkimalla josko sama rvi on jo virhefilessä (LstOutF).
         LstF.LoadFromFile(VrkLstFileN);   //<'TiedostoFile listaan LstF =Kaikki tiedostot listaan LstF.
         i := 0;                           //<+1414d:  Alkusijoitus puuttui !!! Kylläkin näytti olettavan 0.
         while (i<=LstF.Count-1)  do begin //<1413=16å4: Oli i<=.. Takaisin 1414, muuten [0] ohittuu, todettu.
            S := Trim(LstF[i]);
            if S <>''  then
               Sij_LstF_FD_FT (S);         //<Sijoittaa onok_FLst, eioo_FLst, eiOK_FLst, ListFD ja ListFT ####
            i := i+1;                      //'1414f: Erottaa Daten ListFD+ListFT ja FN´n onok_FLst()´hen.
         end;//while                       //<''+1413=16å4'''''''''''''''''''''''''''''''''''''''''' }
         LstQ := TStringList.Create;
         LstQ.Assign(onok_FLst);           //<NYT LstQ :ssa SAMAT KUIN onok_FLst :ssa
         //,########################################################################################
         //,#################### Poistetaan SAMAT esiintymät TAI jos EIOO FILEÄ ####################
         //,########################################################################################
                   //1202: ShowMessage ei worki vielä. InfoDlgUnit/InfoDlgFrm´kin on toisena heti PaaValFrm´in jälkeen Nola.DPR´ssä, mutta ei vielä worki.
                   {function InfoDlg_ (InfoStr :String;   Symbol :TMsgDlgType;
                                      BtnOts1,BtnOts2,BtnOts3,BtnOts4, BtnInfo1,BtnInfo2,BtnInfo3,BtnInfo4 :String;
                                      KopioInfokin,Arvokin :Boolean;  PudStr :String;  VAR Arvo :String) :integer;}
                   {if InfoDlgFrm<>NIL  then InfoDlg_ ('Kokeilua nyt kun Image1 on poistettu eikä kuvaketta ole ollenkaan näytölle.', mtInformation,
                                                       'OK','','','',  'OKselitys','','','', TRUE,TRUE,'',S);}
         boo := FileOnEiEmpty(qFileN);
         if NOT TyhjaNimi(qFileN)  and NOT boo  then    //<6.0.0: Ei tallentanut listaan. 1414d: Havainto: Tyhj.. testi turha ja oli TAL/LUKU aina LISTaan.
         if onok_FLst.Count >0                          //<,,+1414. '1414f: Takas tyhjäTesti: = Ei talleteta tyhjää qFileN.
          //then onok_FLst.Strings[0] := qFileN         //<Ekaksi Itemiksi käytössä oleva Fnimi(=qFileN). 1414f ,Insert.
            then onok_FLst.Insert(0,qFileN)             //<Ekaksi Itemiksi käytössä oleva Fnimi(=qFileN).
            else onok_FLst.Add(qFileN);
         if onok_FLst.Count >0  then                    //<+1414f: Ilman tuli "..List index out of bouds (0)."
            qFilen := onok_FLst[0];
         if (eioo_FLst.Count>0) or (eiOK_FLst.Count>0)  then begin   //,Pannaan fileeseen (FileErr..) lista.
            if (eioo_FLst.Count>0)  then begin
               if (eiOK_FLst.Count>0) then          //<,Jos TULEE eiOk_.. tämän jälkeen, jakoviivaksi tähän singleviiva "---.." k=1, muuten "===.." k=2.
                  k := 1  else k := 2;              //<,k ei käytössä.
               ToErrFile(0,eioo_FLst,k);  end;      //< ..0="Listassa näkyvät mutta puuttuvat fileet.."
            if (eiOK_FLst.Count>0) then
               ToErrFile(1,eiOK_FLst,2);
         end;//if (eioo_FLst.Count>0) or..
                                             {for k := 0 to onok_FLst.Count -1  do qFileen('onok_FLst.Count=' +Ints(onok_FLst.Count) +
                                                  '  onok_FLst[k' +Ints(k) +']=' +onok_FLst[k] );// +'  ListFD[k]=' +ListFD[k] +'  ListFT[k]=' +ListFT[k]);}
         for i := 1 to onok_FLst.Count -1  do begin             //<,,OK vaikka Count=0, [0...Cnt] ######################################################
                     {if i=1  then begin                       //<,,+1414d.  Nämä vain jotta visuaali olisi ymmärrettävämpi, havainnollisempi.
                          xFileen ('  Alku KaikkiLsts:');       //'Ei taitaisi vaikuttaa vaikka ifi=1 ehto vex: ei vaikuta, testattu, OK.
                          xFileen ('  onok_FLst:');
                          for k := 0 to onok_FLst.Count -1  do
                             xFileen (Ints(k) +':  '+onok_FLst[k]);
                          xFileen ('  ListFD:');
                          for k := 0 to ListFD.Count -1  do
                             xFileen (Ints(k) +':  '+ListFD[k]);
                          xFileen ('  ListFT:');
                          for k := 0 to ListFT.Count -1  do
                             xFileen (Ints(k) +':  '+ListFT[k]);  end;//if i=1 }
            k := i;   j := i-1;                                 //< j=Etsittävän itemin listan Indeksi, k=tutkittavan [j]=ed.rvn itemi k=1 -1=j=0=OK.
            while k<=onok_FLst.Count -1  do begin               //, Etsitään ja poistetaan SAMAT.
               boo := FileOnEiEmpty(onok_FLst[k]);
               bos := SamIso (onok_FLst[k],onok_FLst[j]);
               if bos  OR LUE and NOT boo  then begin           //<,####### POISTETAAN LISTASTA JOS EIOO tätä FILEÄ ####################################
                  if j=0  then begin                            //'1414: Oli LUE=FA, mennään ehtoon (=then) vain JOS LUE=TR.
                     if ListFD.Count>=k  then                   //<,,+1414: ..Count>=k testi.
                        ListFD[0] := ListFD[k];                 //<,Löytyi sama aikaisemmista ajoista =Siirretään ajoaikatiedot ennen delausta #########
                     if ListFT.Count>=k  then
                        ListFT[0] := ListFT[k];  end;//if j=0
                  if onok_FLst.Count>=k
                     then onok_FLst.Delete (k);                 //<Poistetaan jäljempnä oleva qFileN jos jo listassa
                  if ListFD.Count>=k                            //<+1414d:  Estää List index out..
                     then ListFD.Delete (k);                    //<,..ja vastaavat Date + Time alkiot
                  if ListFT.Count>=k                            //<+1414d:  Estää List index out..
                     then ListFT.Delete (k);
                  k := k-1;                                     //<Pienennetään, koska Count muuttui ja
               end;//if bos..                                   // seur. siirtyi tilalle, joka myös tutkittava!
               k := k+1; //<tämän takia i´tä ei voi käyttää tässä koska se on for i := ...
            end;//while k<=
         end;//for i
                         {xFileen ('');                         //<,,+1414d.  havainnollinen, näkyy HYVIN kuinka tuplanimi/nimet häipyy.
                          xFileen ('  Loppu Del jälk. KaikkiLsts:');
                          xFileen ('  onok_FLst:');
                          for k := 0 to onok_FLst.Count -1  do
                             xFileen (Ints(k) +':  '+onok_FLst[k]);
                          xFileen ('  ListFD:');
                          for k := 0 to ListFD.Count -1  do
                             xFileen (Ints(k) +':  '+ListFD[k]);
                          xFileen ('  ListFT:');
                          for k := 0 to ListFT.Count -1  do
                             xFileen (Ints(k) +':  '+ListFT[k]);//}
         //'########################################################################################
         //'########################################################################################
         for i := onok_FLst.Count-1 DownTo RiviMax  do begin     //<Poistetaan liiat rivit
            onok_FLst.Delete (i);                                //,MuitaItemeitä pitää olla kuin tähän annettu
            ListFD.Delete (i);
            ListFT.Delete (i);  end;
                                                             //,On Itemeitä (muita kuin qFileN) tai vain 1xMuu JA qFileN on TYHJÄ.
// WBeep([100,200, 0,300,300,200, 0,300,500,200,  100,200, 0,300,300,200, 0,300,500,200]);
         if (onok_FLst.Count>1) OR (onok_FLst.Count=1) and TyhjaNimi (qFileN) //<,,141.1: FNC TyhjaNimi oli väärin, mahtaako antaa tässä saman kuin ennen???
            then result := true; //<@@@@@ RESULT =fLueTalChkLista @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         LstQ.Free;
      end//if xFileExists
      else begin                        //,141.1: FNC TyhjaNimi oli väärin, mahtaake antaa tässä saman kuin ennen (ks. FileLstN.pas/FNC TyhjaNimi ???
         if NOT TyhjaNimi (qFileN)  and FileOnEiEmpty(qFileN)
         then begin onok_FLst.Add (qFileN);             //'130.2eµ:  Oli eFileExists. 1414f: Jos ei vielä talletettu file, tallennuksn jälkeen tänne.
                    boo := onok_FLst.Count=1;           //<+1202
                    if boo  then ;                      //<+120.43:  'Never used.
         end;
      end;

      if NOT LUE  and  (onok_FLst.Count>0)  then begin     //,,@@@@@ TALLETUS VAIN KUN ERIKSEEN PYYDETTY @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         for i := 0 to onok_FLst.Count -1  do begin        //        tai jos oli tyhjä lista (eka ajo) +1202.
            if i=0
            then S := fAjoDateTime                         //<Valittuun (=[0]) ajohetken Date + Time
            else if ListFD.Count >{0}i  then begin         //<+1414: Count>0, muuten Err, todettu. 1414d: tuli tallet´ssa err: 0=>i
                 S := ListFD[i];                           //<,Muihin talletetaan niiden aikaisemmat D+T
                 if S<>''  then S := S +' ';
                 S := S +ListFT [i];  end;
            if S<>''  then S := S +' ';                    //<Välilyönti erottamaan tiedostonimeä (polkua)
            S := S +onok_FLst[i];
         end;//for i
         onok_FLst.SaveToFile(VrkLstFileN);                //<+1413=16å4
         if onok_FLst.Count<0  then ;                      //<+1414d.
      end;//if NOT LUE
    //if LstF<>nil  then LstF.Free;                        //,,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   end;//fLueTalChkLista
   //=====================================================================================================================================================

   procedure ChkTunniste (aFilter :string;  VAR aFileNvar :string); //<,,+6.2.14, 1414d: Tekee aFilterin *.NOE (tms.) tiedostonimen tunnisteosan(EXT).
         VAR o :integer;  tunniste,s :string;      begin
      tunniste := '(*.';
      o := Pos (tunniste, aFilter);    //< (*.  =aFilterissä EXT´n alkumrkt.
      s := ExtractFileExt (aFileNvar); //< .NOE
      if (s='') and (o>0)  then begin  //<Jos eioo .NOE (tms) ja kuitenkin sen alku(tunnisteMrkt), luetaan ) ´hon asti mrkt. 1414d: Tämä lienee turhaa,OK.
         s := '';
         o := o +Length (tunniste) -1;                              //<Tunnisteen vikan mrk osoite.
         while (o<Length (aFilter)) and (aFilter[o+1]<>')')  do begin
            s := s +aFilter[o+1];
            o := o+1;  end;
         if s<>''  then
            aFileNvar := aFileNvar +'.' +s;
      end;                                                          //<''+6.2.14
      if aFileNvar = ' -1#¤$£€-'  then ;                            //<Debuggerille.
   end;
      procedure Fn_VrkListaan_TalReg(FN :string);      VAR fnLst :TStringList;  LstName :string;  u :integer;     begin //+1414fu.
         fnLST := TStringList.Create;              //+1414fu: Tämä PRC ei ollut aiemmin. Tallettaa Rekisteriin ja ao. FileListaan.
         case xOHA of
            1 :LstName := EdvFiletN;     //'EdvNimet.txt';
            2 :LstName := NjFiletN;      //'NjNimet.txt';
            3 :LstName := MoFiletN;      //'MoNimet.txt';
         end;//case
         LstName := gAjoConfPath +LstName;               //<1414fu: +Polku.
         if FileOnEiEmpty(LstName)  then begin           //<File ON eikä tyhjä.
            fnLst.LoadFromFile(LstName);
            if FileOnEiEmpty(FN)  then begin             //<,,Delataan jos jälempää löytyy sama/samoja.
               fnLST.Insert(0,FN);
               if fnLST.Count-1 >0   then
               for u := fnLST.Count-1 DownTo 1  do       //<fnLst[0]´aan juuri edellä sijoitettiin FN.
                  if CompareText(FN,fnLST[u])=0  then //<..returns 0 if they are equal, not Case sensitive =0 jos samoja.
                     fnLST.Delete(u);
            end;//if FileOnEiEmpty(FN)
         end else
            if FileOnEiEmpty(FN)   then
               fnLST.Add(FN);                            //Lisätään alkuun ainoaksi.
         fnLst.SaveToFile(LstName);                      //<+1414fu Save.
         fnLst.Free;
         LueTalFilenReg('LueTalLs1',xOHA,LueFA,KysFA,FN);  //<Talletus Reg´iin, jos FN='' tekee nimen ..\Olet-...jne. xOhan muk.
      end;//Fn_VrkListaan_TalReg

begin//fLueTal_FileLista............................................................................
 //,,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 //,,@@@@@@@@@@@@@@@@@@@@@ Kusun parametrit siirretään paikallisiin muuttujiin @@@@@@@@@@@@@@@@@@@@@
   case xOHA of          //<,,1414fu: Siirtty Y_gLueTal_FileLista´sta.
      1 :s := EdvFiletN;            //< 'EdvNimet.txt';
      2 :s := NjFiletN;             //< 'NjNimet.txt';
   else  s := MoFiletN;  end;//case //< 'MoNimet.txt';
   s := gAjoConfPath +s;            //+-12.0.05 oli: ExtractFilePath (Application.ExeName);      //<Pelkkä polku ilman filenimeä
   VrkLstFileN :=  s;               //<1414fu: qListaFileN korvattu VrkLstFileN´llä.
   GListaEvFileN := s;              //<,,+120.5i Globaalit sijoitukset FileEv.INC (esim.) NotePad edit. varten. Tämäkin siirtty Y_..´stä 1414fu.

   qKieli :=     xKieli;
   qLUE :=       xLUE;
   qKYSY :=      xKYSY;
   qDlgTitle :=  xDlgTitle;
   qLstTitle :=  xLstTitle;
   qFilter :=    xFilter;
 //_qFileNvar := xFileNvar;   //<qFi.. palautetaan takaisin VAR kutsuun @@@@@@@@@@@@@@@@@@@@@@@@@@@ xFileNvar on tulossa oleva FNimi.
   zFileNvar :=  xFileNvar;   //<1414fu: +zFi.. palautetaan takaisin VAR kutsuun @@@@@@@@@@@@@@@@@@@@@@@@@@@ xFileNvar on tulossa oleva FNimi.
 //''@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   COHA := xOHA;                   //<+1414=16å10: Nyt tämän jälkeen xOHA,qOHA,gOHA ja zOHA voitaiSIIN korvata COHA´lla.
       //¿DefsFileenZ('fLueTal_FileLista 1');
       YFileen('¿fLueTal..1');
   ListFD := TStringList.Create;                 //<,Käyttöpäiväykset + aika
   ListFT := TStringList.Create;
   onok_FLst := TStringList.Create;
   eioo_FLst := TStringList.Create; //<,,1413
   eiOK_FLst := TStringList.Create;
   LstIu := TStringList.Create;                  //<,,+1414f:  LstIu/LstIe käytetään VAIN TÄSSÄ, niitä vertaillaan, onko nyt kutsu samalla qListaFilellä.
   LstIe := TStringList.Create;
   uSLstFn := LstOutErrFn +'£££';                //<+1414f:  ,,,Siirtty jälempää fLueTalChkLista´stä.
   LstFnU := '';                                 //<1414f: Ettei ..never used kun ¶..¶ ohitettu {..}´lla.
//µ if qLUE  then begin            //<1414f:  Jos esim EdvwNew.TalletaBtn´sta, mennään suoraan loppupuolelle.
{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
=============================== Täällä vain putsataan EdvNimet.txt (ja Nj,Mo) filet virheellisistä nimistä/poluista joten ==============================
=============================== EdvNimet.txt´ssä kaikki rvt ovat OK ja olemassa. Täältä myös LUKU REGístä ja TALLET REGiin.=============================
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ M U I S T A  ~.TMP -loppuiset fileet ekax DELAT  \BIN ja \BIN\Config -DIRreistä, @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ muuten jotain tarkistamatonta saattaa ilmetä KUN ¶¶ø on kommntoitu ohi. Varsinkin @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ LstOutErrFn oltava tyhjä, muuten siihen lisätään uudet tutkitut nimet.           @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,, NÄMÄ T Ä R K E I N  K E H I T. V A I H E E S S A.,,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
{¶¶ø if isDeb  then begin                        //<,,¶¶¶ V A I N  KEHIvaiheessa oltava kaikki NÄMÄ rvt:  DEL ja CopyFile. Ks. myös FileEv.INC(?)
      //WBeep([1000,100, 2000,100, 3000,100]);
      if FileOnEiEmpty(uSLstFn)              //<Del.. $_$Err-LstOut~.tmp£££
         then DeleteFile(uSLstFn) ;              //                          ,,Kopioi testailutiedostot ettei käsin tarvitse. HYVÄ.
         S := 'C:\Projektit XE2\NolaKehi\BIN\$_$\Kehi\Edv\EdvNimet Koe.txt';  sa := 'C:\Projektit XE2\NolaKehi\BIN\Config\EdvNimet.txt';
      CopyFile(PChar(S),PChar(sa),false);  if NOT FileOnEiEmpty(sa)  then WBeep([150,100, 300,100, 500,100, 1000,200]);
         S := 'C:\Projektit XE2\NolaKehi\BIN\$_$\Kehi\Nj\NjNimet.txt';        sa := 'C:\Projektit XE2\NolaKehi\BIN\Config\NjNimet.txt';
      CopyFile(PChar(S),PChar(sa),false);  if NOT FileOnEiEmpty(sa)  then WBeep([150,100, 300,100, 500,100, 1000,200]);
         S := 'C:\Projektit XE2\NolaKehi\BIN\$_$\Kehi\Mo\MoNimet.txt';        sa := 'C:\Projektit XE2\NolaKehi\BIN\Config\MoNimet.txt';
      CopyFile(PChar(S),PChar(sa),false);  if NOT FileOnEiEmpty(sa)  then WBeep([150,100, 300,100, 500,100, 1000,200]);
   end;//if isDeb ¶¶                         //ShowMessage('Puutoksia');               Ei voi vielä käyttää, aih. epämääräisyyksiä, error minne tahansa.
                                             //InputBox ('OnkoOK?','Ei tartte txt',s); Ei voi tätäkään vielä käyttää, - " -
                            {Tätä ei tarvita, uusilla käyttäjillähän eioo vielä EdvNimet.txt -tiedostoa ollenkaan, on Olet-Ev.NOE tms ja vasta kerryttyään muitakin => EdvNimet.txt.
                                 sa := ExtractFilePath(Application.ExeName);  sa := sa +'Config\'; //Koskei ShowMessage tms. ei voi käyttää tehdään txtFile ja edit se NotePadillä.
                                 S := ExtractFileName(VrkLstFileN);  S := Iso(S);
                                 if (Pos('EDVNIMET.TXT',S)=0) and  (Pos('NJNIMET.TXT',S)=0) and  (Pos('MONIMET.TXT',S)=0)  then begin
                                    ListFD.Add('NOLAsta puuttuu hakemistosta "' +sa +'"  "EdvNimet.txt", "NjNimet.txt, tai "MoNimet.txt" -tiedosto.');
                                    ListFD.Add('');
                                    ListFD.Add('M u i s t a  s u l k e a  tämä  N o t e P a d  näkymä!');
                                    S := sa +'NimiListaError.txt';
                                    ListFD.SaveToFile(S);
                                    if FileOnEiEmpty(S)  then begin
                                       ShellApi.ShellExecute(Application.Handle,'open', PChar('C:\Windows\NotePAD.EXE'), PChar(S), nil, SW_SHOW);
                                       DeleteFile(S);
                                    end;
                                 end;}
//______________________________________________________________________________________________________________________________________________________
//1.________________________________ Ekax tutkitaan FileListat (EdnNimet.TXT, Nj.. Mo..) epäkelvot FN´t karsitaan.______________________________________
   LstFnE := ChangeFileExt(VrkLstFileN,'E~.TMP');     //+1414f: ..\EdvNimet-E~.TMP  =sama kuin file VrkLstFileN "raakana".
   LstOkEfn := ChangeFileExt(VrkLstFileN,'-ok~.TMP'); //+1414f  ..\EdvNimet-ok~.TMP

   if FileOnEiEmpty(VrkLstFileN)
      then LstIu.LoadFromFile(VrkLstFileN);      //<"Uudenpi file" jota verrataan edKrran fileen (LstIe vs LstIu) ja tämä silmukan jälkeen LstIe´hen.
   if FileOnEiEmpty(LstFnE)  then                //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''##############################
      LstIe.LoadFromFile(LstFnE);                //<'',Näillä estetään 2.kerran koko FileListan (VrkLstFileN) läpikäynti kun 2(tms) samaa peräkkäin.
                                                 //    Ja tämä toistuu NjNimet ja MoNimet.txt fileille =8x.#############################################
   IuIeEri := false;  samat := false;            //<IuIeEri: LstIu ja nyt LstIe ovat erilaisia.
   if (LstIu.Count>0)  then                      //'samat: edLst ja nyt uusiLst Count´it ovat samoja.
      if (LstIu.Count <> LstIe.Count)
      then IuIeEri := true
      else begin k := 0;
         for m := 0 to LstIu.Count-1  do
            if CompareText(LstIu[m],LstIe[m])=0        //<..returns 0 if they are equal, not Case sensitive =0 jos samoja.
               then k := k+1                           //'=if AnsiSameText(s1,s2).
               else begin
                  IuIeEri := true;  Break;  end;       //<TR = erilaisia = LstIu<>LstIe. Yksikin erilainen rv =mentävä parsimaan => fLueTalChk..
         samat := k=LstIu.Count;                       //<samat=TR jos kaikki samoja, ja LstIu.Count´han = LstIe.Count, ks. ed ELSE ..
      end;
   if FileOnEiEmpty(LstOkEfn)                    //<,,1414f.  SaveBtnFN´sta: 'fLue 3'>''
      then begin
           m := 0;
           onok_FLst.LoadFromFile(LstOkEfn);  end      //<EdSilmukassa tehty + talletettu.
      else m := 1;
   //,§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
   boo := false;                                 //<,,Jos fLueTalChkLista palauttaa TR.
   if IuIeEri  OR  (samat and (m>0))  then begin //< samat= TR=LstIu=LstIe ja LstOkEfn -file ON ed silmukasta tai ed.ajosta.
      boo := fLueTalChkLista (LueTR,zFileNvar);  //<Ainoa kutsu, siellä tallettaa LISTAN onok_FLst.SaveToFile(LstOkEfn).§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
   end;                                          //'Tekee listat eioo_FLst, eiOK_FLct, onOKLst jne ja TALLETTAA jos TAL pyydetty.§§§§§§§§§§§§§§§§§§§§§§§
   if FileOnEiEmpty(LstFnE)                      //"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      then LstIe.SaveToFile(LstFnE)              //<+++1414f: Jo tässä koska LstIe näköjään häviää(omaVirhe..). Tästä tunnistetaan edKrtainen EdvNimet.txt .
      else LstIu.SaveToFile(LstFnE);             //<Jos eioo edKrran fileä, sijoitetaan ALP.
   //'§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
   if NjFrm<>NIL  then begin                     //,,Oli  TEdvNewFrm.TalletaBtnClick´ssä.
      NjFrm.Close;                               //<,EdRvn kutsusta EI PALATA ENÄÄ NÄIHIN.
      NjTulFrm.Close;                            //<Siellä NJtulAuki := false #####
   end;   // WBeep([100,200, 0,300,300,200, 0,300,500,200]); //FileOnEiEmpty
//______________________________________________________________________________________________________________________________________________________
//2.________________________________ Selvitetään FileN joko annettu, 1.Lst´ssa t. Reg.__________________________________________________________________
   if qLUE
   then begin
      if boo
      then begin
           if qKYSY  then                      //<EdiFileList :ssa BtnEventeistä qFnc := ...
              EdiFileList (onok_FLst);  end    //<Tätä kutsua ei saa tehdä ennen kuin PaaValFrm on luotu. Turvallista kun EdvNewFrm on jo olemassa.
      else                                     //'Tekee Date+Timet onok_FLst´in FileNimille.
        if qKYSY  then                         //<===== FA=EiOoItemeita taiVainSamaItem,  TR=OnItemeita =====
           nFnc := fOpenFileDlg (xOHA,qDlgTitle,qFilter,zFileNvar); //<xOHA +1414:  fOpen..´ssa simukka jos eiOK valinta. nFnc: 1 tai -1(=Cancel oli 9)
   end//if qLUE                       //,==== TALLETUS =============================================
   else begin                         YFileen('¿fLueTal..2'); //¿DefsFileenZ('fLueTal_FileLista 2');
   if qKYSY  then begin
      boo := fSaveFileDlg (xOHA,qDlgTitle,qFilter,zFileNvar);  //<,+1414fu Tästä mennään SaveDlg´hen nimenantoon, +xOHA.§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
           //if isDeb  then WBeep([100,200, 300,200, 500,200,  100,200, 300,200, 500,200]);             DlgI
      if boo  then DlgI := 0   //<,1414fu. Esittly Defs.PAS eikä missään (~)sijoitusta eikä testausta if ..
              else DlgI := -1;
      if boo  then begin                               //<FA jos Dlg´ssä Cancel.
           //case xOHA of 1..3 ..FileN := qFileNar;..  //<,,Rekursiiviset kutsut poistettu, OLI IKUINEN silmukka. Uusi PRC TalReg_FnList korvaa.
         Fn_VrkListaan_TalReg(zFileNvar);              //1414fu: Ainoa kutsu.
         nFnc := 1{1414};
         //Y_gLueTal_FileLista (15,xOHA,LueFa,KysFa,EdvFileN);     //<+1414d: Talletettava tuonne koska lukee FileEv´ssä sieltä uudestaan.
         EdvNewFrm.Caption := PROGRAM_VERSIO_STRING +'´:  Verkkolaskenta / Edeltävä verkko:   '+ EdvFileN; //Tämä sama kuin EdvNewFrm.FrmOtsikossa,
      end;//if boo
   end; end;//else if qKYSY
               //¶"if isDeb  then WBeep([500,100, 0,300, 2000,100, 0,300, 5000,100]);
                 DebWr(3,'2/2','  fLueTal_FileLista / FileLst.PAS: zFileNvar= ---' +zFileNvar);
   S := zFileNvar;  //,,xLUE,xKYSY     //<,,+1414f
   LueTalFilenReg ('LueTalLs2',xOHA,LueFA,KysFA,S); //<+1414f: Tallet(EdvTallBtn) mahd uudella nimellä tehty talletusPYYNTÖ.
                                        //'Tekee oletFileNimen jos tyhjäFileNimi, eli lukee filenimen REKISTERISTÄ, tehty JO Y_.PAS/Y_gLueTal_FileLista.
                                        //'Jos LueTalFilenReg (...FN) FN eioo, sinne tallentui Olet-Ev... tms. JA okRG=FA.
   if (S='') and xLUE  then begin       //<Otetaan Listasta[0] jo S=''. S´hän ei tule Registä JOS LueFA.
      if onok_FLst.Count>0
         then S := onok_FLst[0]
         else //S := teePolkuDataFilen(101);       //<''+1414fu -1415b.
              LueTalFilenReg ('LueTalLs3',xOHA,LueTR,KysFA,S); //<+1415b Luetaan Reg´istä, jos eioo => Olet-...
   end;                              //,,+1414f: Tätä pääVARia(zFileNvar) ei oltu sijoitettu aikaisemmin, mutta Y_gLueTal_FileLista palautti EdvNimet.txt(Nj,Mo)
   zFileNvar := S;                   //   ekan (rnv) alkion mikä on sama kuin tämän onok_FLst[0].               '#################'
   xFileNvar := zFileNvar;           //<+1414fu: TÄRKEIN SIJOITUS puuttui!?!?!?!?
if eioo_FLst.Count +eiOK_FLst.Count >0  then ;
S := '';  sa := '';   if S+sa <''  then;           //<Ettei tule ,, never used.
   onok_FLst.Free;
   eioo_FLst.Free;
   eiOK_FLst.Free;                                 //Alussa oli nämä Create´sit:
   result := nFnc=1;         //<1414.              //   ListFD := TStringList.Create;                 //<,Käyttöpäiväykset + aika
                                                   //   ListFT := TStringList.Create;                 <'Näille kahdelle eioo .Free´tä.
   ListFD.Free;              //<,,+1414f.          //>  onok_FLst := TStringList.Create;
   ListFT.Free;                                    //>  eioo_FLst := TStringList.Create; //<,,1413
   LstIu.Free;                                     //>  eiOK_FLst := TStringList.Create;
   LstIe.Free;                                     //   LstIu := TStringList.Create;
                             YFileen('¿fLueTal..9'); //¿
end;//fLueTal_FileLista                            //   LstIe := TStringList.Create;                  <'Näillekään kahdelle eioo .Free´tä.
end.

