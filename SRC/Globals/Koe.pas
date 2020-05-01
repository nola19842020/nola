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

unit Koe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, RichEditNola, ExtCtrls, PanelNola, NolaForms,ShellApi{12.0.0:ShellExecute},System.Types;

type
  TKoeFrm = class(TFormNola)
    Rich1: TRichEditNola;
    PanelNola1: TPanelNola;
    Label1: TLabel;
    TulostBtn: TButton;
    OKbtn: TButton;
    PutsBtn: TButton;
    SaveDlg1: TSaveDialog;
    PrnDlg1: TPrintDialog;
    FindDlg1: TFindDialog;
    procedure PanelNola1MouseDown(Sender: TObject;  Button: TMouseButton;  Shift: TShiftState;  X,Y: Integer);
    procedure OKbtnClick(Sender: TObject);
    procedure PutsBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TulostBtnMouseDown(Sender: TObject;  Button: TMouseButton;  Shift: TShiftState; X,Y: Integer);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Rich1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDeactivate(Sender: TObject);
    procedure FindDlg1Find(Sender: TObject);
  private
  public
  end;

  procedure KoeWInfo (s :string;  LF :integer); //<12.0.0: Tänne jotta Det + EdvNewLsk´ssa voisi käyttää.

var
  KoeFrm: TKoeFrm;
  KoeStr :string;  //<Y_Koe() :n stringi
{   procedure Edic_ (s :string);
    procedure EdicB (s1,s2 :string);
    procedure Edic (qState :TCheckBoxState;  s :string);
  procedure KoeEdi (s :string;  LF :integer);
  procedure KoeInfo(oh :integer;  S :string); //#######################################################}
{   procedure KoeEdc_ (s :string);
    procedure KoeDicB (s1,s2 :string);
    procedure KoeDic (qState :TCheckBoxState;  s :string);
  procedure KoeDicEdi (s :string;  LF :integer);
  procedure KoeDicInfo(oh :integer;  S :string); //#######################################################}
{   procedure KoeEdi_ (s :string);
    procedure KoeEdiB (s1,s2 :string);
    procedure KoeEdi (qState :TCheckBoxState;  s :string);
  procedure KoeEdiInfo (s :string;  LF :integer);
  procedure KoeEdiInfoA(oh :integer;  S :string); //#######################################################}
    procedure KoeW_ (s :string);
    procedure KoeWB (s1,s2 :string);
    procedure KoeW (qState :TCheckBoxState;  s :string);
//procedure KoeWInfo (s :string;  LF :integer);
  PROCEDURE WrKoeF (SI :string);                  //<,+12.0.0
  PROCEDURE qWrKoeF (SI :string);                 //<,+141.1
  procedure KoeWInfoA(oh :integer;  S :string);   //#######################################################
                                              //OH=1 ei kantsu kutsua suoraan, joten käytä AINA Y_Koe(),
implementation

uses Moot, {KoeW=}PaaVal, Y_, Globals{12.0.0}, {122.0.05 gAjoPath}Defs;//joka jos OH=1, kutsuu JATbtn:n jälkeen AINA OH=0 :lla,
                                              //joten ed. kutsun VIESTIT JÄÄVÄT NÄKYVIIN !!!!!!!!!!!!!!
{$R *.DFM}                                    //#######################################################

//var ohj :integer;
VAR PfileN :string;                           //<12.0.0: Globaaliksi.

procedure LueTalKoeTulFrm (Lue :boolean);   VAR F :TextFile;  FN,st :string;  ii :integer; //<012.0.0
                         //'FA =tallettaa sij+koko.
   function ifi (oi :integer) :integer;      begin
      result := oi;
      if oi<0  then result := 0;
   end;
begin//LueTalKoeTulFrm ..................
   FN := gAjoConfPath;         //+-12.0.05 oli: ExtractFilePath (Application.ExeName);      //<Pelkkä polku ilman filenimeä
   FN := FN +'KoeTulFrm.TXT';  //               FN +'Config\KoeTulFrm.TXT';                 //<Extract.. teki jo 1x '\'
                               //¿DefsFileenZ('AssgnFile 1');
   AssignFile (F,FN);          //'E:\Projektit XE2\Projektit\NolaKehi\BIN\Win32\Debug\Config\..  => nyt \BIN\Config\...
   if Lue
   then begin
      if fFileExists(FN)  then begin
         Reset (F);
         if NOT Eof(F)  then begin Readln (F,st);  SokI (st,ii);  KoeFrm.Top :=    ifi (ii);  end;
         if NOT Eof(F)  then begin Readln (F,st);  SokI (st,ii);  KoeFrm.Left :=   ifi (ii);  end;
         if NOT Eof(F)  then begin Readln (F,st);  SokI (st,ii);  KoeFrm.Height := ifi (ii);  end;
         if NOT Eof(F)  then begin Readln (F,st);  SokI (st,ii);  KoeFrm.Width :=  ifi (ii);  end;
         CloseFile (F);
      end;
   end else begin //,,Talletetus.
//KoeFrm.Caption := Ints (KoeFrm.Left);
      Rewrite (F);
      Writeln (F, Ints (KoeFrm.Top)    +'  Top');
      Writeln (F, Ints (KoeFrm.Left)   +'  Left');
      Writeln (F, Ints (KoeFrm.Height) +'  Height');
      Writeln (F, Ints (KoeFrm.Width)  +'  Width');
      Flush (F);
      CloseFile (F);
{st := 'D:\__C\My Downloads\Notepad2\Notepad2.exe';
ShellExecute(Application.Handle,PChar(st),PChar(FN),nil,nil,SW_SHOWNORMAL); //<Avataan juuri tehty tiedosto Notepadiin.}
   end;
end;//LueTalKoeTulFrm

procedure CaptioniinMuutos;      begin
   if {(Pfilen<>'') and} (Pos ('*',KoeFrm.Caption) =0)    //<Jos ei vielä * -mrkiä muutoksen mrkiksi.
      then KoeFrm.Caption := '*' +KoeFrm.Caption;       //<'+12.0.0
end;

procedure KoeWInfo (s :string;  LF :integer);      begin end;(*
   with KoeFrm  do begin         //ååQ KoeEdi => KoeWInfo
      Label1.Visible :=    false;
      PutsBtn.Left := 4;
      TulostBtn.Left := PutsBtn.Left +PutsBtn.Width;
      Label1.Left := TulostBtn.Left +TulostBtn.Width +4;          //<''+12.0.0
      if NOT Visible  then Show;
      if LF>0  then s := s +'<br>';
      Rich1.AddText (s);
      CaptioniinMuutos;                                           //<+12.0.0
         Rich1.SelStart := MaxInt;
         Rich1.HideSelection := False;
         Rich1.Perform(Messages.EM_SCROLLCARET, 0, 0);            //<Vie cursorin textin loppuun, OK.
        {Rich1.SelStart := Perform(Messages.EM_LINEINDEX, Rich1.Lines.Count, 0);//Set caret at end: Tälläkin menee alkuun!
         isSelectionHidden := Rich1.HideSelection;
         Rich1.HideSelection := False;
         Rich1.Perform(Messages.EM_SCROLLCARET, 0, 0);   // Scroll to caret
       //SendMessage(Rich1.handle, EM_SCROLLCARET,0,0);  //<Tämäkin tekee saman, OK.}
   end;
end;*)
//===============================================================================================================
    //Rich1.AddText (s);                          //,,+120.5n Append ei workkinut, NYT Rich1´een ja lopussa SaveToFile.
   PROCEDURE WrKoeF (SI :string);      {VAR {KoeF :text;  KoeFN :string;      }begin//<Siirrtty tänne 10.INC´stä 12.0.0 .
     {DefsFileenZ}DebWr (0,'WrK; Koe.PAS: ' ,si);          //<+1415d. 1415f.
      if WrNyt  then                              //<Glob, asetus TR/FA EdnNewLask +DetEv :ssa.
      if IsDebuggerPresent                        //,Kun sis. "Ziks_a 0:" mutta loppu erilainen, SEURAAVAT
      then begin                                  // rvt tulostetaan kunnes taas alkuSama +loppu erilainen.
         //¿DefsFileenZ('WrKF:  ' +SI);
      end;
   end;//WrKoeF
   procedure qWrKoeF (si :string);      begin {WrKoeF(si);  }end;//+141.1
//===============================================================================================================
(* PROCEDURE WrKoeF (SI :string);      VAR KoeF :text;  KoeFN :string;      begin//<Siirrtty tänne 10.INC´stä 12.0.0 .
      if WrNyt  then                      //<Glob, asetus TR/FA EdnNewLask +DetEv :ssa.
      if IsDebuggerPresent                        //,Kun sis. "Ziks_a 0:" mutta loppu erilainen, SEURAAVAT
      then begin                                  // rvt tulostetaan kunnes taas alkuSama +loppu erilainen.
        {KoeFN := ExtractFilePath (fApplicName);  // Application.ExeName ei onannut, nyt FNC on PaaVal.PAS´ssa.
         if Pos('REKISTERI',AnsiUpperCase(KoeFn))=0
            then KoeFN := KoeFN +'Config\';       //<Extract.. teki jo 1x '\'} //<'-12.0.05
         KoeFN := gAjoPath +'_Ajot\';  //+-12.0.05 oli: 'X:\Projektit XE2\NolaKehi\BIN\';  //< +12.0.05  Lienee selkeintä kolvata koko polku.
         KoeFN := KoeFN +'WrKoeF.TXT'; //'qKoeLis.TXT'{KoeZiks_a.TXT'};        //'NolaRek.EXE´n ajossa eioo Config- dirriä.
                                       DefsFileenZ('AssgnFile 12');
         AssignFile (KoeF,KoeFN);                 //'E:\Projektit XE2\Projektit\NolaKehi\BIN\Win32\Debug\Config\..
         if fFileExists (KoeFN)
            then Append  (KoeF)                   //<Kirjoitetaan loppuun jatkoksi.
            else Rewrite (KoeF);
         WRITELN (KoeF, SI);
         Flush(KoeF);                             //<+12.0.0
         CloseFile (KoeF);
      end;
   end;//WrKoeF*)
//===============================================================================================================
                //OH =1=pysähtyy,  0=ei pysähdy.
procedure KoeWInfoA(oh :integer;  S :string); //<KoeFrm.Visible asetettu FALSE, jottei käännöksen jälkeen
begin  with KoeFrm  do begin                //' heti näy. Tässä Show tai ShowModal muuttaa (?) näkyväksi
   if oh=0                 //ååQ KoeInfo => KoeWInfoA
   then begin
    OKbtn.Visible := false;
  //TulostBtn.Visible := false;
    TulostBtn.Visible := true;                           //<,+12.0.0  Mahdetaanko tänne tulla ikinä (12.0.0)
    Label1.Visible :=    false;
   {TulostBtn.Left := KoeFrm.Width -TulostBtn.Width -10;
    PutsBtn.Left := TulostBtn.Left -PutsBtn.Width;       //< +4.0.0}
    PutsBtn.Left := 4;                                   //<',+-12.0.0
    TulostBtn.Left := PutsBtn.Left +PutsBtn.Width;
    Label1.Left := TulostBtn.Left +TulostBtn.Width +4;   //<,+12.0.0
    OkBtn.Left := Left +Width +4;
    Label1.Font.Color := clBlue;
    Label1.Font.Height := -10;
    Label1.Font.Style := [];                             //< =Normaali
    Label1.Caption := 'Ohjelma-ajon tosiaikaisia arvoja / kutsuva ohjelma jatkaa...';  end
  else begin
    Messagebeep (0);                                    //< =Beep(Freq,Dura); W95:ssä ei käytössä. =Beep;
   {OKbtn.Font.Height := -13;
    OKbtn.Font.Style := [fsBold];                       //',Nyt asetettu ObjInsp :ssa
    OKbtn.Font.ReadOnly := false;}
    OKbtn.Caption := 'J A T K A';
    OKbtn.Visible := true;
  //TulostBtn.Left := 107;                              //<-12.0.0
    Label1.Left := TulostBtn.Left +TulostBtn.Width +4;  //<+12.0.0
    TulostBtn.Visible := true;
    Label1.Font.Color := clRed;
    Label1.Font.Height := -13;
    Label1.Font.Style := [fsBold];
    Label1.Caption := 'PYSÄHDYS';{, paina [JATKA]';  }end;

  if oh=0
  then begin
       if NOT KoeFrm.Visible  then
       KoeFrm.Show;  end              //<KUTSUVA OHA JATKAA =EI PYSÄHDY TÄHÄN
  else begin            //,Muuten: Cannot make a visible window modal. Vrt. ShowModal,,,.HIDE oltava,
     KoeFrm.Hide;       //<vaikka ObjInsp:ssä asetettu VISIBLE := FALSE, koska JATbtn muuttaa (SHOW)
     KoeFrm.ShowModal;                //<KUTSUVA OHA EI JATKA ENNEN KUIN TÄMÄ Frm SULJETTU TAI := Show
  end;

//Rich1.Font.Name := 'Symbol';
//Rich1.Font.Name := 'WP Greek Courier';  //Symbol parempi. Molemmista puuttuu neliöjuuri
//Rich1.Font.CharSet := Default_Charset;  //<Ei auta = <br> ei vaihda riviä
{  if oh=0  then KoeStr := KoeStr +S+Chr(10)+Chr(13)
           else }{KoeStr := '<left><f n="Courier New">'+S+'</f>';                                   //< -2.0.5}
   KoeStr := S;                                                                                     //< +2.0.5
   Rich1.AddText (KoeStr);    //<Vaatii ADDprc:n, jotta <br> yms. workkisi, todettu ################
   CaptioniinMuutos;          //<+12.0.0
end; {with} end;//KoeWInfoA

procedure TKoeFrm.OKbtnClick(Sender: TObject);  //<Nyt näkyvissä vain, jos SHOWMODAL, =jos pysähdys
begin
  Close;
end;

{procedure TKoeFrm.Rich1Click(Sender: TObject);  //<Poistettu, jotta Cut/Copy mahista
begin
  if ohj<>0  then Close;
end;}

{-------Korvattu OkBtn...---------------------
procedure TKoeFrm.JATbtnClick(Sender: TObject);      //var S :string;
begin  with KoeFrm  do begin
//S := Rich1.Lines[0];
//Hide;                        //<
  Close;
//Rich1.Lines[0] := S+' ¤';
(*Visible := false;
  Label1.Caption := 'OliJATbtn';
  Show;                        //<Näyttää vasta kun Y_Koe kutsuu 2. krran*)
//Close;
//KoeWInfoA (0,S);
end; end;-------------------------------------}

procedure TKoeFrm.PanelNola1MouseDown(Sender: TObject;  Button: TMouseButton;  Shift: TShiftState; X,Y: Integer);
begin //ssShift ssAlt ssCtrl ssLeft ssRight ssMiddle ssDouble
 //KoeFrm.Caption := 'Shift=[ssDouble]';
   inherited;
   Rich1.Enabled := true;                                  //<+12.0.0: Avutetestatessa enable hävisi.
   if Shift=[ssDouble,ssLeft]
   then  begin
      if KoeFrm.Left +KoeFrm.Width < Screen.Width
         then KoeFrm.Width := KoeFrm.Width +100;  end
   else if Shift=[ssShift,ssDouble,ssLeft]
   then if KoeFrm.Left +KoeFrm.Width > 200
           then KoeFrm.Width := KoeFrm.Width -100;
end;

procedure TKoeFrm.TulostBtnMouseDown(Sender: TObject;  Button: TMouseButton;  Shift: TShiftState; X,Y: Integer);
      VAR Afilen,s :string;  o :integer;
begin
   inherited;
   if Shift=[ssAlt,ssLeft]
   then begin
      Afilen := gAjoConfPath;         //+-12.0.05 oli: ExtractFilePath (Application.ExeName);      //<Pelkkä polku ilman filenimeä
      Afilen := Afilen +'EdicAjo';    //               +'Config\EdicAjo';                          //<Extract.. teki jo 1x '\'
      s := FormatDateTime ('yyyy-mm-dd hh;mm;ss', Now);     //<',,12.0.0:  Aika mukaan nimeen, ehkei tule samannimisiä.
      Afilen := Afilen +' ' +s;
      Pfilen := Afilen +'.RTF';
      o := 0;
      while fFileExists(Pfilen)  do begin
         o := o+1;
         s := '-' +IntToStr (o) +'.RTF';
         Pfilen := Afilen +s;
      end;
      s := '(*.RTF)|*.RTF|(*.TXT)|*.TXT|(*.*)|*.*'; //<,+12.0.0
      SaveDlg1.Filter := s;
      SaveDlg1.FileName := Pfilen;
      SaveDlg1.Options := [ofHideReadOnly,ofOverwritePrompt,ofPathMustExist, ofFileMustExist,
                           ofNoReadOnlyReturn,ofEnableSizing];
      SaveDlg1.Title := 'Talletetaan nimellä:';
      KoeFrm.Rich1.PlainText := {true; //}false; //TR=12.0.0 kokeilu.

      if SaveDlg1.Execute  then begin
         Pfilen := SaveDlg1.FileName;     //<+12.0.0:  Talletti aina Tics..RTF -nimellä, nyt syötteen mukaan.
         Rich1.Lines.SaveToFile (Pfilen);
         KoeFrm.Caption := PfileN;
                                          //ChangeFileExt (Pfilen,'.txt');
        {Pfilen := Afilen +'.doc';
         Rich1.Lines.SaveToFile (Pfilen);

         Pfilen := Afilen +'.txt';        //<Jokainen rivi alkaa:  \par
         Rich1.Lines.SaveToFile (Pfilen);


        Rich1.PlainText := true;
         Pfilen := Afilen +'_.rtf';       //<Fnt 10 pt
         Rich1.Lines.SaveToFile (Pfilen);

         Pfilen := Afilen +'_.doc';       //<Fnt 10 pt
         Rich1.Lines.SaveToFile (Pfilen);

         Pfilen := Afilen +'_.txt';       //<Ei LF = yhtä pötköä
         Rich1.Lines.SaveToFile (Pfilen);}

         Pfilen := SaveDlg1.FileName;     //,Ei vaan avaa WordPad´iin, Handle.. PChar tai ei.
        {Pfilen := 'E:\Projektit XE2\Projektit\NolaKehi\BIN\Win32\Debug\Config\EdicAjo 2012-08-25 02;16;14.RTF';
         ShellExecute (Handle,'open', 'C:\Program Files\Windows NT\Accessories\wordpad.exe', PChar('Pfilen'), nil, SW_SHOW); //<+12.0.0: Avaa sen samantien.}
      end;
   end
   else if Shift=[ssLeft]
   then begin if PrnDlg1.Execute
      then begin //Beep;
         TulostBtn.Enabled := False;
         Screen.Cursor := crHourGlass;      //<Ilman SCREENiä vipattaa!!!
         Rich1.Print('');
         Screen.Cursor := crDefault;
         TulostBtn.Enabled := true;
      end;
   end else Beep;
end;//TulostBtnMouseDown

//,,Näihin ei tartte koskea vaikka haluttaisiin ottaa vex, ks KoDic_.. @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
procedure WKoeW_ (s :string);       var sa :string;  i :integer;      begin                         //<,, +2.0.5
   sa := '';                                          //<',,Nämä erinomaisia kokeilussa ############
   for i := 1 to Length(s)  do                        //,,,,########################################
      if s[i]='['  then sa := sa +'<b>' +s[i]   else
      if s[i]=']'  then sa := sa +s[i] +'</b>'  else sa := sa +s[i];
   s := sa;
   KoeWInfoA (0,s);
end;
procedure WKoeWB (s1,s2 :string);       var c :string;      begin                                   //<,, +2.0.5
   s1 := s1 +' ';
   if syoAktv   then c := '+ '  else c := '- ';    s1 := s1 +'akt' +c;
   if syoAvOn   then c := '+ '  else c := '- ';    s1 := s1 +'avs' +c;
   if apuaOn    then c := '+ '  else c := '- ';    s1 := s1 +'?bt' +c;
   KoeW_ (s1+s2);
end;
procedure WKoeW (qState :TCheckBoxState;  s :string);       var sa,c :string;      begin            //<,, +2.0.5
   sa := '/ ';
   if qState=cbUnChecked  then c := 'UnCd'  else
   if qState=  cbChecked  then c := 'Chkd'  else c := 'Gray';   sa := sa +c;
   sa := sa +' BxVis'+fBmrkt0(MoFrm.BxG.Visible,2);
   KoeWB (s,sa);
end;
//,,####################################################################################################################
//,,Näiden sisältö helppo kommentoida vex: Näissä ALUSSA ESITELLYISSÄ vain kutsutaan VARSINAISIA rutiineja.,,###########
procedure KoeW_ (s :string);       begin                                                            //<,, +2.0.5
   WKoeW_ (s);
end;
procedure KoeWB (s1,s2 :string);       begin                                                        //<,, +2.0.5
   WKoeWB (s1,s2);
end;
procedure KoeW (qState :TCheckBoxState;  s :string);       begin                                    //<,, +2.0.5
   WKoeW (qState,s);
end;
//''@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

procedure TKoeFrm.FormDeactivate(Sender: TObject);      begin//+12.0.0
   inherited;
   LueTalKoeTulFrm (FALSE);                             //<FA =tallettaa sij +koko.
end;

procedure TKoeFrm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);      begin//+12.0.0
   inherited;
   if (Shift=[ssCtrl]) then begin
      if CharInSet(Chr(Key),['s','S'])                      //<Ctrl +S =Talletus olevalla nimellä tai kysyy.
      then begin
         if PfileN<>''
            then begin
                 Screen.Cursor := crHourGlass;              //<Ilman SCREENiä vipattaa!!!
                 Rich1.Lines.SaveToFile (PfileN);  end                 //<Talletus fileen (on jo).
            else TulostBtnMouseDown(Self,mbLeft,[ssAlt,ssLeft], 1,1);  //<Talletus fileen, kysyy PfileN.
         KoeFrm.Caption := PfileN;
         Screen.Cursor := crDefault;  end
      else if CharInSet(Chr(Key),['f','F'])                 //<Ctrl +F =Avaa etsintäCmBx1´n.
      then begin
         FindDlg1.Execute;
         FindDlg1.Position := Point(Rich1.Left + Rich1.Width, Rich1.Top);
      end;
   end;
end;//FormKeyUp

procedure TKoeFrm.FindDlg1Find(Sender: TObject); //+12.0.0
   VAR   FoundAt: LongInt;  StartPos, ToEnd: Integer;  mySearchTypes : TSearchTypes;  //myFindOptions : TFindOptions;
begin
  inherited;
  mySearchTypes := [];
  with Rich1  do
  begin
    if frMatchCase in FindDlg1.Options then
       mySearchTypes := mySearchTypes + [stMatchCase];
    if frWholeWord in FindDlg1.Options then
       mySearchTypes := mySearchTypes + [stWholeWord];
    if SelLength <> 0 then                                      //<Begin the search after the current selection, if there
      StartPos := SelStart + SelLength                          // is one. Otherwise, begin at the start of the text.
    else
      StartPos := 0;

    ToEnd := Length(Text) - StartPos;                            //<ToEnd is the length from StartPos through the end of
    FoundAt :=                                                   // the text in the rich edit control.
      FindText(FindDlg1.FindText, StartPos, ToEnd, mySearchTypes);
    if FoundAt <> -1 then
    begin
      SetFocus;
      SelStart := FoundAt;
      SelLength := Length(FindDlg1.FindText);
    end
    else Beep;
  end;
end;//FindDlg1Find

procedure TKoeFrm.FormShow(Sender: TObject);      begin
  Rich1.Clear;                        //<Muuten jää JOSKUS vanhaa tekstiä hännille, TODETTU !!!!!!!!
 (*with KoeFrm  do begin
     {Top := MoFrm.Top + 200 + MoFrm.Height;   Left := 0;
      Height := Screen.Height - Top;   end;   //<HUOM. MoFrm ! Ehkei auki?}
      Top := 500;   Left := 0;
      Height := 280;  end;*)
   LueTalKoeTulFrm (TRUE); //<+12.0.0
end;

procedure TKoeFrm.PutsBtnClick(Sender: TObject);      begin //+4.0.0
   Rich1.Clear;
end;

procedure TKoeFrm.Rich1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);   begin//12.0.0
   inherited;
   CaptioniinMuutos;
end;

initialization
//  KoeStr := '';
end.
