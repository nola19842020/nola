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
unit AlkuOdot;
//###################################################################################################################################
//###################################################################################################################################
//################################################### NolaRek EI KOSKAAN TÄNNE +12.0.05 #############################################
//###################################################################################################################################
//###################################################################################################################################
//Clipboardiin leikkausta / kotisivun taustakuvaa varten, etsi "Clip"

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Defs{+4.0.0},Y_;

type
  TAlkuOdotFrm = class(TForm)
    LatausLbl: TLabel;
    KoeajoLbl: TLabel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AlkuOdotFrm: TAlkuOdotFrm;

implementation

{$R *.DFM}

uses Korj, InfoDlgUnit;

//,,Lomake saadaan näkyviin pysyvästi PAAVAL.PAS :ssa sulkemalla kommenttisuluin vex AlkuOdotFrm.Close
procedure TAlkuOdotFrm.FormShow(Sender: TObject); //,Sine wave, Delphi 3 in 14 days, p.359 #########
   //12.0.0:  Image1 ja 2poistettu jotta päästiin eroon ruttupaperitaustasta (koska ei voida väriä muuttaa (häviää sinisenä 7´ssä).
   //         Nyt otettu Quadr.. imagesta kopio  omaan käyttöön ja laitettu Image 1 sitä varten takas.
      CONST pii=3.141593;   VAR FN, {FnD32c,FnD64c,FnR32c,FnR64c, {FnD32då,FnD64då,FnR32då,FnR64då,}
                                {actPath,}s,sn,cf,CrLf :string;  x,y, jaksot,alfa,korj,w :real;
                                puoliH, t,py,lev ,i,j :integer;
   function fY (y :real) :integer;      begin
      result := trunc (0.8*y*puoliH) +puoliH +30;  end; //< 0.8 osuttaa 0.2x irti yr :sta ja ar :sta

   //,,+12.0.01 §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
   procedure qFileen (fn,si :string);      VAR qf :TextFile;      begin//Kirjoitetaan viesti qn -fileen.+12.0.01
    //fn := '\';                           //<Jos FN=luaton, "Invalid file name - %s."
      AssignFile(qf,fn);
      Rewrite(qf);                         //<Jos FN='', tulee herja "I/O error 105"
      Writeln(qf,si);
      CloseFile(qf);
   end;//procedure Fileen  (o :integer;  si :string);      begin end; //<DFileen -kutsut helppo muuttaa tyhjiksi muuttamalla DFileen => Fileen´ksi.
{procedure DFileen (o :integer;  si :string);      VAR ff :TextFile;  nm :string;      begin//o>0 =Kirjoitetaan aikaleima.
      nm := 'X:\Projektit XE2\NolaKehi\BIN\_Ajot\FileenD.txt'; //'Käytetään Debuggerin korvikkeena koska se ei suostu workkimaan jostain syystä.
      AssignFile(ff,nm);
      if FileExists (nm)
         then Append(ff)
         else Rewrite(ff);
      if o>0  then
         Writeln(ff,'==============================A===== ' +DateTimeToStr(Now)); //+ ' ' + DateTimeToStr(time));
      si := 'AlkuOdot.PAS/DFileen:  ' +si;                                              //<+12.0.05
      Writeln(ff, si);
      CloseFile(ff);
    //Windows.Beep (1500,200);
   end;}
(*##################################################################################################################################
  ##################################################################################################################################
  Tämä toimii hyvästi mutta nyt tarpeeton, koska gAjoPath, gAjoConfPath osoittavat \BIN\Config -dirriin, joista luetaan KAIKKI AINA.
            //,,12.0.05:  Nyt ei enää tarvetta, TextBase.NOL yms tehdään vain ..\BIN\Config -dirriin ja sieltä myös niitä käytetään.
            //,,+12.0.01..............................................,,Tekee Config -DIRrin ja kopioi sinne \BIN\Config´istä kaikki BMP´t +TextBase.NOL yms.
            //,,http://delphi.cjcsoft.net/viewthread.php?tid=46408      koska Delphi XE2´n Post- eikä Pre-build kopioinnit onaa, todettu, DEVELOPER1+DEVELOPER2.
procedure MakeConfDir_CopyFiles (fromD,toD :string);      VAR SR: TSearchRec;      begin//+12.0.01
                                                       Fileen (1,'#0 MkdConf.. Frm: "' +fromD +'"  faDir:' +Ints(faDirectory));
                                                       Fileen (0,'#0 MkdConf..  To: "' +toD   +'"');
{WrNyt := true;
WrKoeF ('fromD= '  +fromD +'  //toD= ' +toD);}         //<DFileen täydellisempi.
      if (FindFirst (fromD +'\*.*',faAnyFile,SR) =0)
      then begin                                                //,if NOT DirectoryExists  <=Ei tarvita.
         ForceDirectories (toD);                                //<Tehdään aina ekax koska filejä kerran on.
         if (SR.Attr<>faDirectory) and                          //<,,Vain muut kuin DIRrit OK.
            (SR.Name<>'.') and (SR.Name<>'..')
         then begin                                             //,Put User Feedback here if desired (Ei taitaisi olla tarpeen).
            Application.ProcessMessages;               Fileen (0,' 1 "' +fromD +'\' +SR.Name +'" => "' +toD +'"\"' +SR.name  +'"');
            CopyFile (PChar(fromD +'\' +SR.Name), PChar(toD +'\' +SR.name), true);
         end;                                          Fileen (0,' 2 MkdConf.. Frm: "' +fromD +SR.Name +'"  atr:' +Ints(SR.Attr) +' faDir:' +Ints(faDirectory));
                                                       Fileen (0,' 2 MkdConf..  To: "' +toD   +'"\"' +SR.Name +'"');
         while FindNext (SR) =0  do begin              //Windows.Beep(2500,50);
            if (SR.Attr<>faDirectory) and                       //<,,DIRripolkuihin ei mennä.
               (SR.Name<>'.') and (SR.Name<>'..')
            then begin                                          //<,Put User Feedback here if desired
               Application.ProcessMessages;            Fileen (0,' 3 "' +fromD +'"\"' +SR.Name +'" => "' +toD +'"\"' +SR.name +'"');
               CopyFile (PChar(fromD +'\' +SR.Name), PChar(toD +'\' +SR.name), true);
            end;
         end;//while
      end;
      FindClose (SR);                                  Fileen (0,' 9 MakeConfDir_CopyFiles´stä ulos OK.');
//WrNyt := false;
   end;//MakeConfDir_CopyFiles *)

   procedure TestaaWrReadModif;     {VAR err :integer;}                   //<,,+130.0:  Tutkitaan (LUONTI-?) KIRJOITUS-, LUKUoikeus
                                                      //,DirFile:  0 =Hakemiston..,  <>0=Tiedoston luontitesti.
      function  fKirjoitusOikeusOK (DirFile :integer;  Polku :string) :boolean;    VAR Fosa,Fname{,Dpath} :string;  handle :integer;  boo :boolean;      begin
         Fosa := {TEST_FILE}'$1234$';               //,,handle := FileCreate(Fname) -versio: Ks. TLicenseManager.TestKirjoitusOikeus´sta/ License.PAS.
//{SysUtils.}ForceDirectories(Polku +Fname);        //TEST_FILE= "_NolTest"
         Polku := IncludeTrailingPathDelimiter(Polku);
       //boo := false;
         if DirFile=0                               //< 0 =HAKEMISTON luontiyritys.###############################################
         then begin
            Fname := Polku +Fosa;
            boo := CreateDir(Fname);                //<Fosa -niminen DIRrin luontiyritys.
            if boo
            then if NOT RemoveDir(Fname)  then begin
               ShowMessage(IntToStr(GetLastError));
               boo := false;  end;
         end//then
         else begin                                 //<,,TIEDOSTON luontiyritys.##################################################
            Fname := Polku +Fosa;
            handle := FileCreate (Fname);           //<Ei tartte Assign +Rewrite´a.
            if (handle = -1)
            then boo := False
            else begin
                 FileClose(handle);
                 sysutils.DeleteFile(Fname);
                 boo := True;
            end;
         end;//else
         result := boo;
      end;//fKirjoitusOikeusOK
   begin//...........................
    //err := 0;
    //if NOT LicenseManager{myLicense}.TestKirjoitusOikeus(gAjoPath)                     //<DirTeko-oikeus ..\BIN´iin (Config, Data yms.
      if {}NOT {}fKirjoitusOikeusOK(0, gAjoPath)     //< 0 =Hakemiston luontitesti,  1=Tiedoston luontitesti.
         then ShowMessage('NOLAn käynnistyshakemistosta (' +gAjoPath +') puuttu kirjoitusoikeus, KORJAA (Properties/Security/Edit    FI: ' +
                          'Ominaisuudet/Oikeudet(?)).');
      if {}NOT {}fKirjoitusOikeusOK(1, gAjoConfPath)     //< 1=Tiedoston luontitesti.
         then ShowMessage('NOLAn ..\Config -hakemistosta (' +gAjoConfPath +') puuttu kirjoitusoikeus, KORJAA (Properties/Security/Edit    FI: ' +
                          'Ominaisuudet/Oikeudet(?)).');
   end;//TestaaWrReadModif

   function fFileTst (sf :string) :boolean;     VAR sa :string;  boD,boF :boolean;      begin  //<+130.0
      sf := Trim(sf);
      sa := ExtractFilePath(sf);
      boD := fDirectoryExists(sa);
      boF := fFileExists(sf);
      result := boD and (sf<>'') and boF;  //result := false; //<FA´lla pääsee näkemään ShowMessage -ikkunan sisältöä.
   end;
//********************************************************************************************************************************
begin//FormShow.....................
//,,+12.0.0:  Uusittu kokonaan, ks. jälempnä.================================================================================================================
TimEd1 := 0;  TimEd2 := 0;  TimEd3 := 0;  TimEdY := 0;          //<+120.43 DefsFileenZ kirjoittamiseen, ks. Defs.PAS.
//¿DefsFileenZ('Alku..FrmShow´sta.');
YFileen('¿Alku..FormShow');
   with AlkuOdotFrm.KoeajoLbl  do
   if NOT IsDebuggerPresent //Defs_Koeajo         //<IsDeb +12.0.02
      then Visible := false;                      //<,Sijoitetaan keskelle ruutua. 12.0.0: Nyt Center := true´lla sama.
       //ColorPic(XP´ssä PaintShop´ista tehdystä värimixistä): 16044964 (# A4D3F4) =Vaaleahkon siniharmaa, kiva väri.
       //         W7´ssä                                       13160660 (# D4D0C8  Otettu NOLAn w7 päävalikon yläpanelista.
   Color := $D4D0C8; //<Frmn väri: w7 PaaVal yläpanelista ColorPic´llä.   XP=$A4D3F4; //IntToStr (16044964); EiOK.     ,+12.0.0
                        //FN := FN +'Config\Saturn.bmp';        //<Olisi hyvä mutta käyräosuus hyvin pieni kooltaan.
                        //FN := FN +'Config\_athena.bmp';       //<OK mutta rakeinen.
                        //FN := FN +'Config\_gears.bmp';        //<OK mutta rakeinen.
                        //FN := FN +'Config\_Saturn30%.bmp';    //<OK mutta karkea, mustaa reunaa ja 33% ei sekään parempi.
 //cf := '_Taustakuva 002.bmp';   //<Valokuva ½pilvisestä taivaasta.
   FN := gAjoConfPath +cf;                            YFileen('ß¶ FN= ' +FN);
                                                      YFileen('ß¶1 PthXN=' +IncludeTrailingPathDelimiter (ExtractFilePath (Application.ExeName)));
                                                      YFileen('FNexists= ' +fBmrkt0(fFileExists(FN),2));
   TestaaWrReadModif;                        //<+130.0:  Pousille ym. Vasta tässä kun gAjoPath on tiedossa.

   cf := gAjoConfPath;                                //<,,130.0
   CrLf := {Chr(10)+Chr(13);}AnsiString(#13#10);
   sn := '';                                                        //,,ilmoit. ShowMessage +kirjoitetaan fileen ja BEEPIT +kerrotaan file, mistä tietoa luettavissa.
   j := 0;
   s := cf +'_Taustakuva 002.bmp';  if NOT fFileTst(s)  then begin                        //<Valokuva ½pilvisestä taivaasta.)
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end  //,Image1.Transparent := true;??
                                       else Image1.Picture.LoadFromFile(s);          //<''+12.0.0:  W7´stä puuttui ruttupaperitaustakuva, uusi= _Taustakuva 002.bmp
   s := cf +'Confirm.bmp';          if NOT fFileTst(s)  then begin                        //<,Nämä vain jotta voisi jotenkin nähdä, meneekö
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end; //  oha sinne vaikkei BreakPnt worki. qFileen´ssa piipit.
   s := cf +'Error.bmp';            if NOT fFileTst(s)  then begin
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end;
   s := cf +'LiitEsim-4.bmp';       if NOT fFileTst(s)  then begin
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end;
   s := cf +'NJketju-4.bmp';        if NOT fFileTst(s)  then begin
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end;
   s := cf +'Nola_Icon.ico';        if NOT fFileTst(s)  then begin
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end;
   s := cf +'NolaTil.rtf';          if NOT fFileTst(s)  then begin
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end;
   s := cf +'TarifHinD.NOL';        if NOT fFileTst(s)  then begin
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end;
   s := cf +'Warn.bmp';             if NOT fFileTst(s)  then begin
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end;
   s := cf +'Z_a2.rtf';             if NOT fFileTst(s)  then begin
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end;
   s := cf +'Z_Raken.rtf';          if NOT fFileTst(s)  then begin
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end;
 //s := {ExtractFileName}fHaePolkuFilen (KAAPELIHINTA_FILE_ID); //<KahiPolkuFilen, Tarkistus myös myöhemmin KaapHin.INC/PRC LueKahi´ssa.  Acces violation !!!!!
   s := cf +'KaapHinD.NOL';         if NOT fFileTst(s)  then begin
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end;
   s := gAjoPath +'Data\Katuvalo\Katu.TXT';                                              //C:\Projektit XE2\NolaKehi\BIN\Data
                                    if NOT fFileTst(s)  then begin
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end;
   if sn<>''  then begin
      cf := gAjoPath +'_Lukuvirheet.txt';
     {sn := '(PRC AlkuOdot):  ..\Config -hakmistossa pitää olla KÄYTTÄJÄkohtaiset luonti- ja lukuoideudet. ' +CrLf +'Mahd. lukuoikeutta ei ole seur. '+
            'poluille (tiedostoja ei saatu luettua):' +CrLf +sn +CrLf +'Ajo keskeytetään.' +CrLf +'Nämä tiedot löydät tiedostosta:  ' +cf;}
      sn := '(PRC AlkuOdot):  SEUR. TIEDOSTOJA EI SAATU LUETTUA (tiedosto tai lukuoikeus mahd. puuttuu),' +CrLf +
            '..\Config -hakmistossa pitää olla KÄYTTÄJÄkohtaiset luonti- ja lukuoideudet). ' +CrLf +CrLf +sn +CrLf +
            'Ajo keskeytetään.' +CrLf +'Nämä tiedot löydät tiedostosta:  ' +cf;
      qFileen (cf,sn);
      sn := sn +CrLf +'(Tiedostopolun saat kopioitua seur. ikkunasta!)';
      if InfoDlgFrm<>NIL                                                             //<,InfoDlg ei ole vielä luotu: "Acces violation.. +8.0.0 §LUO§
        then InfoDlg    (sn, mtCustom, 'OK','','','',  '' ,'','','')                 //<''+12.0.02: InfoD.. eeioo vielä, näköjään.
        else ShowMessage (sn);
             //MessageDlg (CrLf +sn, mtInformation,[mbOk,mbYes],0);
      {if NOT }InputBox{Query} ('Leikkaa/kopioi tästä tiedostopolku:', {'[Cancel] =Ei käytössä.}'' ,cf);
      Halt;
   end;//if sn<>''
   if sn=''
      then sn := 'AlkuOdot: TestKirjoitus+Lukuoikeudet=OK'
      else sn := 'AlkuOdot: Puutteita oli TestKirjoitus+Lukuoikeuksissa (annettu herja)';
//¿DefsFileenZ(sn);
YFileen('¿'+sn);
   Image1.Transparent := true;                                                       //<Ei vaikuta.
   Image1.SendToBack;
{
   Image1.Canvas.Pen.Width := 4;                                                     //<Raami, vasta tässä etteiFillRect peitä.
   Image1.Canvas.Pen.Color := clGray;//clBlue;//clLime;//clFuchsia;
}{
 //Rectangle(0,0,Image1.Width,Image1.Height);                                        //<Ei hyväksy => Error..
   Image1.Canvas.MoveTo(0,0);
   Image1.Canvas.LineTo(Image1.Width,0);
   Image1.Canvas.LineTo(Image1.Width,Image1.Height);
   Image1.Canvas.LineTo(0,Image1.Height);
   Image1.Canvas.LineTo(0,0);
}{
   Image1.Canvas.Pen.Width := 1;                                                     //<,,Jakoviivat
   Image1.Canvas.Pen.Color := clSilver;
   lev := Image1.Width;                        //<Kuvion leveys
   w := 2*pii;                                 //< w = Oomega = 2*Pii*f
 //t := Trunc (Image1.Width/10); //W=350  H=237
   t := Trunc (Lev/4);
   i := 1;
   while (i*t) < Lev  do begin                                                       //<Pystyviivat
       Image1.Canvas.MoveTo(Trunc(i*t),0);
       Image1.Canvas.LineTo(Trunc(i*t),Image1.Height);
       i := i+1;  end;
   t := Trunc(Image1.Height/8);
   i := 1;
   while (i*t) < Image1.Height  do begin                                             //<Vaakaviivat
       Image1.Canvas.MoveTo(0,Trunc(i*t));
       Image1.Canvas.LineTo(Image1.Width,Trunc(i*t));
       i := i+1;  end;
}
   puoliH := Image1.Height div 2;              //<Lomakkeen puolikorkeus
   puoliH := puoliH -40;
   lev := Image1.Width;                        //<Kuvion leveys
   w := 2*pii;                                 //< w = Oomega = 2*Pii*f
   jaksot := w / (lev div 4);                  //<DIV 4 = mahdutetaan 2 jaksoa lomakkeelle <<<<<<<<<
   alfa := pii*2/3;                            //<alfa = vaihesiirto eri vaiheitten välillä <<<<<<<<
   korj := alfa -pii/2;                        //<KORJ osuttaa käyrän niin, että eka osuu huippukoh-
   Image1.Canvas.Pen.Width := 1;               //<,,Viivavahvuus 1 ja 0 ovat samoja
   for j := 0 to 2  do begin
      case j of                                                        //,,Värimuutos 120.4
         1 :Image1.Canvas.Pen.Color := clWhite;{clGreen;//clLime;//clYellow;}
         2 :Image1.Canvas.Pen.Color := clBlack;{clGreen; //clBlue;}
      else  Image1.Canvas.Pen.Color := RGB(202,110,2);{clFuchsia;{clRed;}  end;//case
      i := 0;
   for t := 0 to lev  do begin
      x := t *jaksot -j*alfa -korj;
    //y := -1 *sin (x);
      y := exp (-1* t/100);                    //< -1* =Käännetään käyrä alkamaan nousevasti #######
      y := -1 *sin (x) -y;                     //' -1 koska origo on vy eikäAlhaallaa =KASVAA ALAS
      py := fY(y)+40;                          //<12.0.0:  +20 koska käyrähuippu ohi kuvan yr´n.
      if i=0  then Image1.Canvas.MoveTo(t,py)
              else Image1.Canvas.LineTo(t,py);
      i := 1;
   end; end;

   Image1.Canvas.Pen.Width := 2;                                                 //<,,Vaimennuskäyrä
   Image1.Canvas.Pen.Color := clRed;
   for t := 0 to LEV  do begin
      y := exp (-1* t/100);
    //y := -1 *(y +sin (pii/2));
      y := -1 *y;
      py := fY(y);
      if t=0  then Image1.Canvas.MoveTo(t,py)
              else Image1.Canvas.LineTo(t,py);
   end;

   Image1.Canvas.Pen.Width := 2;
   Image1.Canvas.Pen.Color := clYellow;//clWhite;//clBlack;                      //<,,Vaaka-akseli
   Image1.Canvas.MoveTo(0,puoliH+70);                                            //'clWhite 12.0.03
   Image1.Canvas.LineTo(Image1.Width,puoliH+70);
{
   Image1.Canvas.Pen.Width := 4;
   Image1.Canvas.Pen.Color := clLime;//clFuchsia;                                //<,,Raamit +12.0.0
   Image1.Canvas.MoveTo(0,0);
   Image1.Canvas.LineTo(Image1.Width,0);
   Image1.Canvas.LineTo(Image1.Width,Image1.Height);
   Image1.Canvas.LineTo(0,Image1.Height);
   Image1.Canvas.LineTo(0,0); }
                                               //,,Clipboardiin leikkausta / kotisivun taustakuvaa varten:
  {Image1.Visible := false;                    //<Väliaikaisesti, jotta tausta jäisi vex. 8.0.5u
   AlkuOdotFrm.Color := clCaptionText;         //<Väliaikaisesti valkoinen                8.0.5u}
   //Kommentoi vex Nola.DPR ´stä:  AlkuOdotFrm.Close, saat PrintScreen´in vain sillä tavalla.*)

YFileen('AlkuOd Shw 9'); //¿
//¿DefsFileenZ('AlkuOd: 9:  gAjoExeN=' +gAjoExeN +CR +' ®® gAjoPath=' +gAjoPath +CR +' ®® gAjoConfPath=' +gAjoConfPath +CR +' ®® actPath=' +actPath +' <<<ONKO Conf\Conf ???');
end;//FormShow

end.
