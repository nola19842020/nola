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
//################################################### NolaRek EI KOSKAAN T�NNE +12.0.05 #############################################
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

//,,Lomake saadaan n�kyviin pysyv�sti PAAVAL.PAS :ssa sulkemalla kommenttisuluin vex AlkuOdotFrm.Close
procedure TAlkuOdotFrm.FormShow(Sender: TObject); //,Sine wave, Delphi 3 in 14 days, p.359 #########
   //12.0.0:  Image1 ja 2poistettu jotta p��stiin eroon ruttupaperitaustasta (koska ei voida v�ri� muuttaa (h�vi�� sinisen� 7�ss�).
   //         Nyt otettu Quadr.. imagesta kopio  omaan k�ytt��n ja laitettu Image 1 sit� varten takas.
      CONST pii=3.141593;   VAR FN, {FnD32c,FnD64c,FnR32c,FnR64c, {FnD32d�,FnD64d�,FnR32d�,FnR64d�,}
                                {actPath,}s,sn,cf,CrLf :string;  x,y, jaksot,alfa,korj,w :real;
                                puoliH, t,py,lev ,i,j :integer;
   function fY (y :real) :integer;      begin
      result := trunc (0.8*y*puoliH) +puoliH +30;  end; //< 0.8 osuttaa 0.2x irti yr :sta ja ar :sta

   //,,+12.0.01 ���������������������������������������������������������������������������������������������������������������������������������������������
   procedure qFileen (fn,si :string);      VAR qf :TextFile;      begin//Kirjoitetaan viesti qn -fileen.+12.0.01
    //fn := '\';                           //<Jos FN=luaton, "Invalid file name - %s."
      AssignFile(qf,fn);
      Rewrite(qf);                         //<Jos FN='', tulee herja "I/O error 105"
      Writeln(qf,si);
      CloseFile(qf);
   end;//procedure Fileen  (o :integer;  si :string);      begin end; //<DFileen -kutsut helppo muuttaa tyhjiksi muuttamalla DFileen => Fileen�ksi.
{procedure DFileen (o :integer;  si :string);      VAR ff :TextFile;  nm :string;      begin//o>0 =Kirjoitetaan aikaleima.
      nm := 'X:\Projektit XE2\NolaKehi\BIN\_Ajot\FileenD.txt'; //'K�ytet��n Debuggerin korvikkeena koska se ei suostu workkimaan jostain syyst�.
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
  T�m� toimii hyv�sti mutta nyt tarpeeton, koska gAjoPath, gAjoConfPath osoittavat \BIN\Config -dirriin, joista luetaan KAIKKI AINA.
            //,,12.0.05:  Nyt ei en�� tarvetta, TextBase.NOL yms tehd��n vain ..\BIN\Config -dirriin ja sielt� my�s niit� k�ytet��n.
            //,,+12.0.01..............................................,,Tekee Config -DIRrin ja kopioi sinne \BIN\Config�ist� kaikki BMP�t +TextBase.NOL yms.
            //,,http://delphi.cjcsoft.net/viewthread.php?tid=46408      koska Delphi XE2�n Post- eik� Pre-build kopioinnit onaa, todettu, DEVELOPER1+DEVELOPER2.
procedure MakeConfDir_CopyFiles (fromD,toD :string);      VAR SR: TSearchRec;      begin//+12.0.01
                                                       Fileen (1,'#0 MkdConf.. Frm: "' +fromD +'"  faDir:' +Ints(faDirectory));
                                                       Fileen (0,'#0 MkdConf..  To: "' +toD   +'"');
{WrNyt := true;
WrKoeF ('fromD= '  +fromD +'  //toD= ' +toD);}         //<DFileen t�ydellisempi.
      if (FindFirst (fromD +'\*.*',faAnyFile,SR) =0)
      then begin                                                //,if NOT DirectoryExists  <=Ei tarvita.
         ForceDirectories (toD);                                //<Tehd��n aina ekax koska filej� kerran on.
         if (SR.Attr<>faDirectory) and                          //<,,Vain muut kuin DIRrit OK.
            (SR.Name<>'.') and (SR.Name<>'..')
         then begin                                             //,Put User Feedback here if desired (Ei taitaisi olla tarpeen).
            Application.ProcessMessages;               Fileen (0,' 1 "' +fromD +'\' +SR.Name +'" => "' +toD +'"\"' +SR.name  +'"');
            CopyFile (PChar(fromD +'\' +SR.Name), PChar(toD +'\' +SR.name), true);
         end;                                          Fileen (0,' 2 MkdConf.. Frm: "' +fromD +SR.Name +'"  atr:' +Ints(SR.Attr) +' faDir:' +Ints(faDirectory));
                                                       Fileen (0,' 2 MkdConf..  To: "' +toD   +'"\"' +SR.Name +'"');
         while FindNext (SR) =0  do begin              //Windows.Beep(2500,50);
            if (SR.Attr<>faDirectory) and                       //<,,DIRripolkuihin ei menn�.
               (SR.Name<>'.') and (SR.Name<>'..')
            then begin                                          //<,Put User Feedback here if desired
               Application.ProcessMessages;            Fileen (0,' 3 "' +fromD +'"\"' +SR.Name +'" => "' +toD +'"\"' +SR.name +'"');
               CopyFile (PChar(fromD +'\' +SR.Name), PChar(toD +'\' +SR.name), true);
            end;
         end;//while
      end;
      FindClose (SR);                                  Fileen (0,' 9 MakeConfDir_CopyFiles�st� ulos OK.');
//WrNyt := false;
   end;//MakeConfDir_CopyFiles *)

   procedure TestaaWrReadModif;     {VAR err :integer;}                   //<,,+130.0:  Tutkitaan (LUONTI-?) KIRJOITUS-, LUKUoikeus
                                                      //,DirFile:  0 =Hakemiston..,  <>0=Tiedoston luontitesti.
      function  fKirjoitusOikeusOK (DirFile :integer;  Polku :string) :boolean;    VAR Fosa,Fname{,Dpath} :string;  handle :integer;  boo :boolean;      begin
         Fosa := {TEST_FILE}'$1234$';               //,,handle := FileCreate(Fname) -versio: Ks. TLicenseManager.TestKirjoitusOikeus�sta/ License.PAS.
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
            handle := FileCreate (Fname);           //<Ei tartte Assign +Rewrite�a.
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
    //if NOT LicenseManager{myLicense}.TestKirjoitusOikeus(gAjoPath)                     //<DirTeko-oikeus ..\BIN�iin (Config, Data yms.
      if {}NOT {}fKirjoitusOikeusOK(0, gAjoPath)     //< 0 =Hakemiston luontitesti,  1=Tiedoston luontitesti.
         then ShowMessage('NOLAn k�ynnistyshakemistosta (' +gAjoPath +') puuttu kirjoitusoikeus, KORJAA (Properties/Security/Edit    FI: ' +
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
      result := boD and (sf<>'') and boF;  //result := false; //<FA�lla p��see n�kem��n ShowMessage -ikkunan sis�lt��.
   end;
//********************************************************************************************************************************
begin//FormShow.....................
//,,+12.0.0:  Uusittu kokonaan, ks. j�lempn�.================================================================================================================
TimEd1 := 0;  TimEd2 := 0;  TimEd3 := 0;  TimEdY := 0;          //<+120.43 DefsFileenZ kirjoittamiseen, ks. Defs.PAS.
//�DefsFileenZ('Alku..FrmShow�sta.');
YFileen('�Alku..FormShow');
   with AlkuOdotFrm.KoeajoLbl  do
   if NOT IsDebuggerPresent //Defs_Koeajo         //<IsDeb +12.0.02
      then Visible := false;                      //<,Sijoitetaan keskelle ruutua. 12.0.0: Nyt Center := true�lla sama.
       //ColorPic(XP�ss� PaintShop�ista tehdyst� v�rimixist�): 16044964 (# A4D3F4) =Vaaleahkon siniharmaa, kiva v�ri.
       //         W7�ss�                                       13160660 (# D4D0C8  Otettu NOLAn w7 p��valikon yl�panelista.
   Color := $D4D0C8; //<Frmn v�ri: w7 PaaVal yl�panelista ColorPic�ll�.   XP=$A4D3F4; //IntToStr (16044964); EiOK.     ,+12.0.0
                        //FN := FN +'Config\Saturn.bmp';        //<Olisi hyv� mutta k�yr�osuus hyvin pieni kooltaan.
                        //FN := FN +'Config\_athena.bmp';       //<OK mutta rakeinen.
                        //FN := FN +'Config\_gears.bmp';        //<OK mutta rakeinen.
                        //FN := FN +'Config\_Saturn30%.bmp';    //<OK mutta karkea, mustaa reunaa ja 33% ei sek��n parempi.
 //cf := '_Taustakuva 002.bmp';   //<Valokuva �pilvisest� taivaasta.
   FN := gAjoConfPath +cf;                            YFileen('߶ FN= ' +FN);
                                                      YFileen('߶1 PthXN=' +IncludeTrailingPathDelimiter (ExtractFilePath (Application.ExeName)));
                                                      YFileen('FNexists= ' +fBmrkt0(fFileExists(FN),2));
   TestaaWrReadModif;                        //<+130.0:  Pousille ym. Vasta t�ss� kun gAjoPath on tiedossa.

   cf := gAjoConfPath;                                //<,,130.0
   CrLf := {Chr(10)+Chr(13);}AnsiString(#13#10);
   sn := '';                                                        //,,ilmoit. ShowMessage +kirjoitetaan fileen ja BEEPIT +kerrotaan file, mist� tietoa luettavissa.
   j := 0;
   s := cf +'_Taustakuva 002.bmp';  if NOT fFileTst(s)  then begin                        //<Valokuva �pilvisest� taivaasta.)
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end  //,Image1.Transparent := true;??
                                       else Image1.Picture.LoadFromFile(s);          //<''+12.0.0:  W7�st� puuttui ruttupaperitaustakuva, uusi= _Taustakuva 002.bmp
   s := cf +'Confirm.bmp';          if NOT fFileTst(s)  then begin                        //<,N�m� vain jotta voisi jotenkin n�hd�, meneek�
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end; //  oha sinne vaikkei BreakPnt worki. qFileen�ssa piipit.
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
 //s := {ExtractFileName}fHaePolkuFilen (KAAPELIHINTA_FILE_ID); //<KahiPolkuFilen, Tarkistus my�s my�hemmin KaapHin.INC/PRC LueKahi�ssa.  Acces violation !!!!!
   s := cf +'KaapHinD.NOL';         if NOT fFileTst(s)  then begin
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end;
   s := gAjoPath +'Data\Katuvalo\Katu.TXT';                                              //C:\Projektit XE2\NolaKehi\BIN\Data
                                    if NOT fFileTst(s)  then begin
                                       j := j+1;  sn := sn +Ints(j) +'  ' +s +CrLf;  end;
   if sn<>''  then begin
      cf := gAjoPath +'_Lukuvirheet.txt';
     {sn := '(PRC AlkuOdot):  ..\Config -hakmistossa pit�� olla K�YTT�J�kohtaiset luonti- ja lukuoideudet. ' +CrLf +'Mahd. lukuoikeutta ei ole seur. '+
            'poluille (tiedostoja ei saatu luettua):' +CrLf +sn +CrLf +'Ajo keskeytet��n.' +CrLf +'N�m� tiedot l�yd�t tiedostosta:  ' +cf;}
      sn := '(PRC AlkuOdot):  SEUR. TIEDOSTOJA EI SAATU LUETTUA (tiedosto tai lukuoikeus mahd. puuttuu),' +CrLf +
            '..\Config -hakmistossa pit�� olla K�YTT�J�kohtaiset luonti- ja lukuoideudet). ' +CrLf +CrLf +sn +CrLf +
            'Ajo keskeytet��n.' +CrLf +'N�m� tiedot l�yd�t tiedostosta:  ' +cf;
      qFileen (cf,sn);
      sn := sn +CrLf +'(Tiedostopolun saat kopioitua seur. ikkunasta!)';
      if InfoDlgFrm<>NIL                                                             //<,InfoDlg ei ole viel� luotu: "Acces violation.. +8.0.0 �LUO�
        then InfoDlg    (sn, mtCustom, 'OK','','','',  '' ,'','','')                 //<''+12.0.02: InfoD.. eeioo viel�, n�k�j��n.
        else ShowMessage (sn);
             //MessageDlg (CrLf +sn, mtInformation,[mbOk,mbYes],0);
      {if NOT }InputBox{Query} ('Leikkaa/kopioi t�st� tiedostopolku:', {'[Cancel] =Ei k�yt�ss�.}'' ,cf);
      Halt;
   end;//if sn<>''
   if sn=''
      then sn := 'AlkuOdot: TestKirjoitus+Lukuoikeudet=OK'
      else sn := 'AlkuOdot: Puutteita oli TestKirjoitus+Lukuoikeuksissa (annettu herja)';
//�DefsFileenZ(sn);
YFileen('�'+sn);
   Image1.Transparent := true;                                                       //<Ei vaikuta.
   Image1.SendToBack;
{
   Image1.Canvas.Pen.Width := 4;                                                     //<Raami, vasta t�ss� etteiFillRect peit�.
   Image1.Canvas.Pen.Color := clGray;//clBlue;//clLime;//clFuchsia;
}{
 //Rectangle(0,0,Image1.Width,Image1.Height);                                        //<Ei hyv�ksy => Error..
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
   alfa := pii*2/3;                            //<alfa = vaihesiirto eri vaiheitten v�lill� <<<<<<<<
   korj := alfa -pii/2;                        //<KORJ osuttaa k�yr�n niin, ett� eka osuu huippukoh-
   Image1.Canvas.Pen.Width := 1;               //<,,Viivavahvuus 1 ja 0 ovat samoja
   for j := 0 to 2  do begin
      case j of                                                        //,,V�rimuutos 120.4
         1 :Image1.Canvas.Pen.Color := clWhite;{clGreen;//clLime;//clYellow;}
         2 :Image1.Canvas.Pen.Color := clBlack;{clGreen; //clBlue;}
      else  Image1.Canvas.Pen.Color := RGB(202,110,2);{clFuchsia;{clRed;}  end;//case
      i := 0;
   for t := 0 to lev  do begin
      x := t *jaksot -j*alfa -korj;
    //y := -1 *sin (x);
      y := exp (-1* t/100);                    //< -1* =K��nnet��n k�yr� alkamaan nousevasti #######
      y := -1 *sin (x) -y;                     //' -1 koska origo on vy eik�Alhaallaa =KASVAA ALAS
      py := fY(y)+40;                          //<12.0.0:  +20 koska k�yr�huippu ohi kuvan yr�n.
      if i=0  then Image1.Canvas.MoveTo(t,py)
              else Image1.Canvas.LineTo(t,py);
      i := 1;
   end; end;

   Image1.Canvas.Pen.Width := 2;                                                 //<,,Vaimennusk�yr�
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
  {Image1.Visible := false;                    //<V�liaikaisesti, jotta tausta j�isi vex. 8.0.5u
   AlkuOdotFrm.Color := clCaptionText;         //<V�liaikaisesti valkoinen                8.0.5u}
   //Kommentoi vex Nola.DPR �st�:  AlkuOdotFrm.Close, saat PrintScreen�in vain sill� tavalla.*)

YFileen('AlkuOd Shw 9'); //�
//�DefsFileenZ('AlkuOd: 9:  gAjoExeN=' +gAjoExeN +CR +' �� gAjoPath=' +gAjoPath +CR +' �� gAjoConfPath=' +gAjoConfPath +CR +' �� actPath=' +actPath +' <<<ONKO Conf\Conf ???');
end;//FormShow

end.
