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

unit InfoDlgUnit; //+6.2.2
//-1202i merkityt: Otin pois koko PanelIm +Image1 +Bmp, koska en saanut kuvaketta (Warn,Inform jne.) enää näkymään.

{function InfoDlg  (InfoStr :String;   Symbol :TMsgDlgType;
                    BtnOts1,BtnOts2,BtnOts3,BtnOts4, BtnInfo1,BtnInfo2,BtnInfo3,BtnInfo4 :String) :integer;

 function InfoDlg_ (InfoStr :String;   Symbol :TMsgDlgType;                //,,ShowModal. Kommentti +10.0.5
                    BtnOts1,BtnOts2,BtnOts3,BtnOts4, BtnInfo1,BtnInfo2,BtnInfo3,BtnInfo4 :String) :integer;
                                                     ''''''''ao. Buttoni (Btn1) selitysteksti: [Btn1] = "BtnInfo1"
                                                             tai tyhjä '', jolloin ei tule Buttonille selitysriviä.
                    KopioInfokin,Arvokin :Boolean;  PudStr :String;  VAR Arvo :String);
                    KopioInfokin="Leikkaa ja kopioi ... info '''''':n itemErottimena ";"
                                'Arvokin=Pud.valikko(PudStr)=TComboBoxXY tulee + VAR Arvo palautetaan
                    '''''''Kukin tyhjästä '' poikkeava Stringi saa aikaan Buttonin, jonka Caption := BtnOtsX.
                           Kaytettävä järjestyksessä.
                    Symbol:   mtWarning,mtError...    mtCustom  ei tee iconia =Aivan kuten MessageDlg.
                    ##########'''''''''''''''''###################################################################
Käyttö kuten MessageDlg, MUTTA:
 - Palauttaa BtnNumeron 1..4, mikä valittu. Jos suljetaan lomakkeen X -btn:sta, arvoksi tulee 9.##################
 - InfoStr = Yleisviesti/ohje. Jos ei muita TXT-RIVEJÄ, tämä editoidaan keskitetysti = <center>.
Lomake kasvaa korkeussuunnassa tarpeen mukaan.
HUOM:  Dialogista tulee "tasapainoisempi", jos SYMBOL´iksi sijoitetaan mtCustom, jolloin koko tekstialue tulee
       koko lomakkeen levyisenä käyttöön.
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, NolaForms, Dialogs,
  StdCtrls, ComCtrls, RichEditNola, Grids, StringGridNola,
 {StringGridBoxNola, }ExtCtrls, ComboBoxXY;

type
  TInfoDlgFrm = class(TFormNola)
    PanelBtn: TPanel;
    PanelY: TPanel;
    Btn1: TButton;
    Btn2: TButton;
    Btn3: TButton;
    Btn4: TButton;
    RediN: TRichEditNola;
    StrGr: TStringGridNola;
    PanelBx: TPanel;
    ComBx1: TComboBoxXY;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Btn1Click(Sender: TObject);
    procedure Btn2Click(Sender: TObject);
    procedure Btn3Click(Sender: TObject);
    procedure Btn4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StrGrWidestColInRow(Sender: TObject; ACol,ARow, newWidth: Integer);
    procedure PanelBtnClick(Sender: TObject);
    procedure RediNMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState;  X,Y: Integer);
    procedure ComBx1KeyDown(Sender: TObject;  var Key: Word;  Shift: TShiftState);
    procedure RediNKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var InfoDlgFrm: TInfoDlgFrm;                                                                       //,Workkii OK.
    function InfoDlg_ (InfoStr :String;   Symbol :TMsgDlgType;           //=ShowModal -muodossa. Kommentti +10.0.5
                       BtnOts1,BtnOts2,BtnOts3,BtnOts4, BtnInfo1,BtnInfo2,BtnInfo3,BtnInfo4 :String;
                       KopioInfokin,Arvokin :Boolean;  PudStr :String;  VAR Arvo :String) :integer;
    function InfoDlg  (InfoStr :String;   Symbol :TMsgDlgType;
                       BtnOts1,BtnOts2,BtnOts3,BtnOts4, BtnInfo1,BtnInfo2,BtnInfo3,BtnInfo4 :String) :integer;

implementation

uses LabelNola, Defs{, PaaVal{IsDeb..};

var BtnLkm,val :integer;

{$R *.DFM}
     {,,,HELPistä Canvas.TextWidth pixeleinä,,,,,,,,,,,,,,,,,,,,,,,,
      if (Canvas.TextWidth(Pages[i].Caption) * 2) > TabWidth then
        TabWidth := Canvas.TextWidth(Pages[i].Caption) * 2;
      if (Canvas.TextHeight(Pages[i].Caption) * 2) > TabHeight then
        TabHeight := Canvas.TextHeight(Pages[i].Caption) * 2;}

function InfoDlg_ (InfoStr :String;   Symbol :TMsgDlgType;
                   BtnOts1,BtnOts2,BtnOts3,BtnOts4, BtnInfo1,BtnInfo2,BtnInfo3,BtnInfo4 :String;
                   KopioInfokin,Arvokin :Boolean;  PudStr :String;  VAR Arvo :String) :integer;
                //'KopioInfokin="Leikkaa ja kopioi ... info
                //              'Arvokin=Pud.valikko + aevoBoxi tulee + VAR Arvo palautetaan
      CONST BVali=10;   BtnMax=4;
      VAR fnc,i,j,k, dx,x,ax, SelLkm :integer;   ArrBtnOts,ArrBtnInf :array [1..4] of string;
          c1,c2,c3,c4,c5 :integer;   {Bmp :TBitMap;}   {BmFilen ,}ss :string;   {MyRect :TRect;}
        //BitMap1,BitMap2 : TBitMap;  MyFormat : Word; //<+1202 netistä.

{  function asetaSis (sis :integer) :string;      begin  //Stg := Stg+ '<in f="" l="'+sisStr+'">';  end; //<NjTul3Y.INC
      result := '<in f="" l="' +IntToStr (sis) +'">';  end;}
   function tabSet (Stg :string) :string;      begin //Stg := Stg+ '</tab> <tab s="'+s+'">';  end;//s='10,15,..jne
      result := '</tab> <tab s="' +Stg +'">';  end;  //s='10,15,..jne

   procedure PuraSijItms (Stg :string;  VAR Boxi :TComboBoxXY);      VAR s,SI :string;  {Lst :TStringList;}    begin//Erottimena ";"  +1202
      s := '';          //'Stg= '11110;11111;11112;11113'
                        //Lst := TStringList.Create;  =Vain kokeilua josko  Debuggerissa hiiriosoitus näyttäisi listaa: EI NÄYTÄ.
      Stg := Trim (Stg);
      SI := Stg;
      while (Stg<>'')  DO begin
         if (Stg[1]=';')
         then begin if (s<>'')         //<' (s<>'') Muuten vika Itemi jää vex, todettu.
                       then begin
                       Boxi.Items.Add(s);
                      {Lst.Add (s);  }end;
                  //sa := sa +' ' +s;
                    s := '';
                    Delete (Stg,1,1);
                    Stg := Trim (Stg);  end
         else begin s := s +Stg[1];
                    Delete (Stg,1,1);   end;
      end;//while
      if (s+SI='') {and (Lst.Count>99) }then ;
   end;

begin//InfoDlg_,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   InfoDlgFrm.ComBx1.DropDownCount := 50;      //<,,+8.0.0
 //PuraSijItms ('-1;1;2',InfoDlgFrm.ComBx1);
   if Arvokin
   then begin
      InfoDlgFrm.PanelBx.Visible :=  true;
      InfoDlgFrm.ComBx1.Items.Clear;
      PuraSijItms (PudStr,InfoDlgFrm.ComBx1);
      InfoDlgFrm.ComBx1.ItemIndex := 0;
      InfoDlgFrm.ComBx1.Visible :=   true;
      InfoDlgFrm.PanelBx.Parent := InfoDlgFrm.PanelY;
      InfoDlgFrm.PanelBx.Height :=   41;  end
   else begin
      InfoDlgFrm.PanelBx.Visible :=  false;
      InfoDlgFrm.PanelBx.Height :=   0;   end; //<''+8.0.0
   val := 0;                            //<FNC:n paluuarvo, vois := 9 valmiiksi, OK näinkin, ks. FormClose
(*-1202i Otin pois koko PanelIm +Image1 +Bmp, koska en saanut kuvaketta (Warn,Inform jne.) enää näkymään.
        Image 1 oli: Left 0, Top 38, Height 87, Width 43. Vex tilakin, jotta InfoStr saisi koko FrmLeveyden käyttöönsä.
                                        //,Jos 0 jää voimaan, Image1 häviääKokonaan =RediN pääsee vasemmalle asti
   InfoDlgFrm.PanelIm.Width := 0;       //<Jolloin Btn´it kohdistuvat oikein tutkimatta PanelIm.Visible
{  Bmp := TBitMap.Create; -1202i
   try                                         //,PATH => Pelkkä polku ilman filenimeä, Extr.. tekee '\' loppuun. -1202i }
      if NOT (Symbol IN [mtWarning,mtError,mtConfirmation,mtInformation])
      then begin                                    //'mtCustom jää ilman BMP, kuten alp. MessageDlg:ssä.
         InfoDlgFrm.PanelIm.Width := 0;             //<Jolloin Btn´it kohdistuvat oikein tutkimatta PanelIm.Visible
         InfoDlgFrm.Image1.Width :=  0;
         InfoDlgFrm.Image1.Visible :=  false;       //<,Jolloin RediN + StrGrd pääsee ohi vasemmalle
         InfoDlgFrm.PanelIm.Visible := false;  end
      else begin
         BmFilen := gAjoConfPath ; //+-12.0.05 oli:  ExtractFilePath (Application.ExeName) +'Config\';
         case Symbol of
            mtError        :BmFilen := BmFilen +'Error.BMP';
            mtWarning      :BmFilen := BmFilen +'Warn.BMP';
            mtInformation  :BmFilen := BmFilen +'Inform.BMP';
            mtConfirmation :BmFilen := BmFilen +'Confirm.BMP'; //mtCustom jää ilman BMP, kuten alp. MessageDlg:ssä
         end;
          //,,SyottoAv´sta:
//          InfoDlgFrm.Image1.Canvas.Brush.Color := {clLime;}clWhite; //<,Putsaa vanhan kuvan alta ja levittää kuva-alaa oikein.
          //InfoDlgFrm.Image1.Canvas.FillRect(Rect(0,0, SyottoAvFrm.Image1.Width, SyottoAvFrm.Image1.Height));
          //                                             2500             , 2000               )); //<-12.0.0: Ei kuvaa ollenkaan.
//          InfoDlgFrm.Image1.Canvas.FillRect(Rect(0,0, Screen.Width      , Screen.Height));       //<12.0.0:  Näköjään OK.
         InfoDlgFrm.PanelIm.Visible := true;
         InfoDlgFrm.Image1.Visible :=  true;
         if fFileExists (BmFilen)
         then begin  *)
(*          Rect := InfoDlgFrm.GetClientRect;        //<InfoDlgFrm.PanelIm. tai Image1 = EiOK
            InfoDlgFrm.Image1.Canvas.FillRect(Rect); //<clear the rectangle
            Bmp.LoadFromFile (BmFilen);
            Bmp.Dormant;                             // Free up GDI resources
            Bmp.FreeImage;                           // Free up Memory.
                                    //if IsDebuggerPresent  then PaaValFrm.Caption := 'BmH='+IntToStr(Bmp.Height);
            InfoDlgFrm.PanelIm.Width := Bmp.Width;   //<Image1 seuraa PanelIm´ia:  Image1=alClient.
            InfoDlgFrm.Image1.Width :=  Bmp.Width;   //<Pakko asettaa, todettu.
            InfoDlgFrm.Image1.Height := Bmp.Height;  //<Pakko asettaa, todettu.}
                                        {Bmp.Transparent := True;
                                         Bmp.TransParentColor := Bmp.canvas.pixels[0,0];//[50,50];
                                         Bmp.TransparentMode := tmAuto;   // Transparent color now is clDefault = TColor($20000000);}
            InfoDlgFrm.Image1.Canvas.Draw(0,0,Bmp); // Note that previous calls don't lose the image
          //InfoDlgFrm.Image1.Canvas.Draw(0,0,NIL);
                //i := InfoDlgFrm.PanelIm.Height -Bmp.Height-11; //<Panelin alareunassa, OK.
                //InfoDlgFrm.Image1.Canvas.Draw(0,i,Bmp);
            InfoDlgFrm.Image1.Top := 0;//InfoDlgFrm.PanelIm.Height -Bmp.Height;
            Bmp.Monochrome := true;
            Bmp.ReleaseHandle;  end                 // This will actually lose the bitmap; *)

//--------------------------------------------------,,D5 Help´istä.
(*-1202i     MyRect := Rect(10,10,100,100);
            Bmp := TBitMap.Create;
            Bmp.LoadFromFile(BmFilen);
            InfoDlgFrm.Canvas.BrushCopy(MyRect, Bmp, MyRect,clBlack);
            Bmp.Free;
         end
*)
(*
            try
              Bmp.LoadFromFile('factory.bmp');
              Canvas.Draw(20,20,Bmp);               // Note that previous calls do not lose the image.
            finally
              Bmp.Free;
            end;
         end *)
(*-1202i  else begin                                 //<,,Jos fileä ei ole, kirjoitetaan Bmp:n sijaan jotain vastaavaa.
            InfoDlgFrm.PanelIm.Width := 35;
            InfoDlgFrm.Image1.Width :=  35;
            case Symbol of
               mtWarning :InfoDlgFrm.PanelIm.Caption := '! ! !';
               mtError   :InfoDlgFrm.PanelIm.Caption := 'Err';
            end;
         end
      end; *)
(*  finally
      Bmp.Free;
   end;*)
                               BtnLkm := 1;          //<Pakko olla ainakin 1. Nimi tarkist. myöhemmin
   if Trim (BtnOts2)<>''  then BtnLkm := BtnLkm +1;
   if Trim (BtnOts3)<>''  then BtnLkm := BtnLkm +1;
   if Trim (BtnOts4)<>''  then BtnLkm := BtnLkm +1;
   with InfoDlgFrm  do begin
      //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Btn sijoittelu,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      dx := Btn1.Width +BVali;                                                        //<Kaikki BtnX.Width samoja
      if Odd (BtnLkm)  then ax := Trunc ((ClientWidth-Btn1.Width)/2)                  //<,Keskimmäisen Btnin Left
                       else ax := Trunc ( ClientWidth/2) -Trunc (BVali/2) -Btn1.Width;
      x := Trunc (BtnLkm/2 +0.5) -1;                                                  //<,VasPuoLIMMAISIMMAN Left
                                       //Caption := 'Lkm=' +IntToStr (BtnLkm) +'  n=' +IntToStr (x);
      x := ax -  x * dx;
                                       //Caption := Caption +'  x=' +IntToStr (x);
      for i := 1 to BtnLkm  do
      case i of
         1 :Btn1.Left := x;
         2 :Btn2.Left := x +(i-1)*dx;
         3 :Btn3.Left := x +(i-1)*dx;
      else  Btn4.Left := x +(i-1)*dx;  end;
      //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''Btn sijoittelu''''''''''''''''''''''''''''
      SelLkm := 0;
      ArrBtnOts [1] := BtnOts1;   ArrBtnOts [2] := BtnOts2;   ArrBtnOts [3] := BtnOts3;   ArrBtnOts [4] := BtnOts4;

      if Trim (BtnOts1) =''  then BtnOts1 := 'OK';                                  //<Pakko olla jokin näyväOts.
      if Trim (InfoStr) =''  then InfoStr := 'Jatka.';                              //<Olisi outoa tyhjänä.??????

      if (Trim (BtnOts1)<>'') and (Trim (BtnInfo1)<>'')  then begin                 //,,Arr:sta helpompi käyttää.
                                                         ArrBtnInf [1] := BtnInfo1;  SelLkm := SelLkm +1;  end;
      if (Trim (BtnOts2)<>'') and (Trim (BtnInfo2)<>'')  then begin
                                                         ArrBtnInf [2] := BtnInfo2;  SelLkm := SelLkm +1;  end;
      if (Trim (BtnOts3)<>'') and (Trim (BtnInfo3)<>'')  then begin
                                                         ArrBtnInf [3] := BtnInfo3;  SelLkm := SelLkm +1;  end;
      if (Trim (BtnOts4)<>'') and (Trim (BtnInfo4)<>'')  then begin
                                                         ArrBtnInf [4] := BtnInfo4;  SelLkm := SelLkm +1;  end;
                                                        //''Muuten jää '' :ksi
                              Btn1.Visible := true;   Btn1.Hint := BtnInfo1;
      if BtnLkm>1  then begin Btn2.Visible := true;   Btn2.Hint := BtnInfo2;  end
                   else begin Btn2.Visible := false;  Btn2.Hint := '';        end;
      if BtnLkm>2  then begin Btn3.Visible := true;   Btn3.Hint := BtnInfo3;  end
                   else begin Btn3.Visible := false;  Btn3.Hint := '';        end;
      if BtnLkm>3  then begin Btn4.Visible := true;   Btn4.Hint := BtnInfo4;  end
                   else begin Btn4.Visible := false;  Btn4.Hint := '';        end;

      if Arvokin
      then                   Caption := 'Valitse ja vahvista' //<'+8.0.0
      else if BtnLkm>1  then Caption := 'Valitse'
                        else Caption := 'Vahvista';
    //Caption := Caption +'   (jos tarve: Cut/Copy)'; //+7.0.5
    //if (Trim (BtnInfo1)<>'') or Trim (BtnInfo2)<>'') or Trim (BtnInfo3)<>'') or Trim (BtnInfo4)<>'')  then
      if KopioInfokin and (Trim (InfoStr)<>'')  then
       //InfoStr := InfoStr +'</b></f>' +COLOR_WHITE +'  (Cut/Copy tästä, jos tarvis)</f>';
         InfoStr := InfoStr +'</f></b>' +{COLOR_WHITE}COLOR_GREEN +'  (leikkaa/kopioi teksti, jos tarvis)</f>';

      for i := 1 to BtnLkm  do
      case i of
         1 :Btn1.Caption := BtnOts1;
         2 :Btn2.Caption := BtnOts2;
         3 :Btn3.Caption := BtnOts3;
      else  Btn4.Caption := BtnOts4;  end;
      //---------------------------------------Selvitetään välirivitarpeet RediN+StrGr---------------------------
      j := 0;
      if SelLkm > 0  then j := 1;                               //<j := 1  =Alkuun ain yksi tyhjä rivi.
      StrGr.RowCount := SelLkm +j;
      //---------------------------------------RediN Texti-------------------------------------------------------
      RediN.Clear;
      ss := '';  if Symbol=mtError  then ss := '<b>';
    //RediN.AddText ('<center><b>' +InfoStr +'</b>');  //< -7.0.1
      RediN.AddText ('<center>' +ss +InfoStr +'</b>'); //< +7.0.1
      if RediN.Lines.Count < 4  then RediN.Lines.Insert (0,''); //<Tilaa varattu 4 r:lle, lisätään 1 rv alkuun.
      j := 0;
      if SelLkm=0  then j := 1;                                 //<,Muuten InfoStr tulee Buttoniin ~kiinni.
      RediN.Height := Trunc ((InfoDlgFrm.RediN.Lines.Count +j) *12.8 +2 +0.5);
                                    //if IsDebuggerPresent  then Caption := 'rwCnt='+IntToStr(RediN.Lines.Count);
      //---------------------------------------StrGr-------------------------------------------------------------
      StrGr.GridLineWidth := 0;
      StrGr.Options := [goThumbTracking];
      StrGr.Color := clBtnFace;   StrGr.FixedColor := clBtnFace;

    (*,,Kokeiluun,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      StrGr.GridLineWidth := 1;
      StrGr.Options := [goThumbTracking,goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine];
      StrGr.Color := clSilver;{clAppWorkSpace;}   StrGr.FixedColor := clSilver;//*)

      StrGr.ColCount := 8;                            //<Riittävästi, jotta saadaan VÄRIVIRHEALUE PIILOON.!!!!!!!
      c1 := 2;     c2 := c1+1;  c3 := c1+2;           //<,,c1 :lla säädetään vas.marg, c2=[  c3=BtnOts  c4=]  c5=Selit.
      c4 := c1+3;  c5 := c1+4;

      for i := 0 to StrGr.ColCount-1  do begin        //<,,Putsaa mahd. vanhat merkit.
         for j := 0 to StrGr.RowCount-1  do
            StrGr.Cells[i,j] := '';
            StrGr.ColWidths[i] := 0;                  //<Tämä hävittää tyhjiksi jäävät Col´it,  <'KOKLATTU
      end;
      //---------------------------------------StrGr Texti-------------------------------------------------------
      j := 0;
      for i := 1 to BtnMax  do
      if Trim (ArrBtnInf [i])<>''  then begin                  //,,Cells[Col,Row]
         j := j+1;
        {StrGr.Cells[c2,j] := '<b>' +COLOR_WHITE +'[</f></b> ';
         StrGr.Cells[c3,j] := '<center>' +ArrBtnOts [i] +' ';  //<Loppuun ' ' jottaVikanKirjaimenLoppuOK, TODETTU.
         StrGr.Cells[c4,j] := '<b>' +COLOR_WHITE +']</f></b>';
         StrGr.Cells[c5,j] := '   = ' +ArrBtnInf [i];}

         StrGr.Cells[c2,j] := COLOR_WHITE +'[</f> ';           //<,,120.5i:  <b></b> poistettu
         StrGr.Cells[c3,j] := '<center>' +ArrBtnOts [i] +' ';  //<Loppuun ' ' jottaVikanKirjaimenLoppuOK, TODETTU.
         StrGr.Cells[c4,j] := COLOR_WHITE +']</f>';
         StrGr.Cells[c5,j] := '   = ' +ArrBtnInf [i];
      end;
//InfoDlgFrm.PanelIm.Color :=  clGray; //Koe 8.0.0
{InfoDlgFrm.PanelY.Color := clBlue;
InfoDlgFrm.RediN.Color :=  clGreen;
InfoDlgFrm.StrGr.Color :=  clRed;
InfoDlgFrm.PanelBx.Color :=  clFuchsia;
InfoDlgFrm.PanelBtn.Color := clAqua;//}
      InfoDlgFrm.StrGr.Visible := true;
      i := InfoDlgFrm.StrGr.DefaultRowHeight * (InfoDlgFrm.StrGr.RowCount +1);
      if SelLkm=0
      then begin
         i := 0;
         InfoDlgFrm.StrGr.Height := 0;                                      //<+8.0.0
         InfoDlgFrm.StrGr.Visible := false;  end
      else InfoDlgFrm.StrGr.Height := i;                                    //<+8.0.0

      InfoDlgFrm.Height := InfoDlgFrm.PanelBtn.Height + i + InfoDlgFrm.RediN.Height +
                           InfoDlgFrm.Height - InfoDlgFrm.ClientHeight;// +100;
{      InfoDlgFrm.Height := InfoDlgFrm.PanelBtn.Height +InfoDlgFrm.PanelY.Height +
                           InfoDlgFrm.Height - InfoDlgFrm.ClientHeight;}
      if Arvokin  then begin                                                //<,,+8.0.0
         InfoDlgFrm.Height := InfoDlgFrm.Height +InfoDlgFrm.PanelBx.Height;
         InfoDlgFrm.ComBx1.Left := (InfoDlgFrm.ClientWidth -InfoDlgFrm.ComBx1.Width)  DIV 2
                                   {- InfoDlgFrm.PanelIm.Width}; //<' +8.0.0
         //'Parent muuttuu siitä, mitä ObjInsp. näyttää:  siinä PanelBx näyttää menevän Frm´in vas.reunaan
         //'asti (Align=alBottom) ja sen yläpuolella vas.reunassa on PanelIm, jolla Align=alLeft ja joka alkaa
         //'PanelBx´in YLÄPUOLELTA. Ajossa kuitenkin PanelIm menee alas PanelBtn´iin asti PanelBx´in ohi.!!!!!!!!
      end;
//if InfoDlgFrm.PanelIm.Height < 150  then InfoDlgFrm.{PanelIm.}Height := 200; //Koe 8.0.0
                           //,Keskitetään tekstiä sisältävät Cellit lisäämällä c1 :een ' ' x N kpl.
      i := InfoDlgFrm.StrGr.Width -//InfoDlgFrm.PanelIm.Width -          //<,Lasketaan tyhjä osuus koko leveydestä -1202i
          (InfoDlgFrm.StrGr.ColWidths[c1] +InfoDlgFrm.StrGr.ColWidths[c2] +InfoDlgFrm.StrGr.ColWidths[c3] +
           InfoDlgFrm.StrGr.ColWidths[c4] +InfoDlgFrm.StrGr.ColWidths[c5]); //'ColWidths[c1] kylläkin 0.
      k := i DIV 2;                                                         //<Tyhjä osa sijoitettuna vas + oik.
                      {if IsDebuggerPresent  then begin  ss := '[]>0:  ';  j := 0;
                           for i := 0 to StrGr.ColCount-1  do
                           if StrGr.ColWidths[i] > 0  then begin  j := j +StrGr.ColWidths[i];
                              ss := ss +IntToStr(i)+'='+IntToStr(StrGr.ColWidths[i])+' ';  end;  Caption := 'k='+
                              IntToStr(k) +'  ' +ss +' Y=' +IntToStr(j) +'  grdW=' +IntToStr(StrGr.Width);  end;//}
      while InfoDlgFrm.StrGr.ColWidths[c1] +2 < k                      //< +2 = hienosäätöä
            do InfoDlgFrm.StrGr.Cells[c1,0] := StrGr.Cells[c1,0] +' ';
                                                                 //'Jos 1 riviä, lisää alkuun KAKSI tyhjän rivin.
//-1202i InfoDlgFrm.Image1.Top := Trunc (1.5 *12.8) - (InfoDlgFrm.Image1.Height DIV 2); //< 12.8 =RediN:n riviH,
   end;//with                       //'''1.5 osuttaa Imagen puolivälin rivin keskilinjaan...........
//PanImH=76 ImH=31 FrmClntH:107 -PanAH:31=76 PanBxH=0 rdiNH=28 PanYH=76 srGH=0 frmH=132 ImYr=4 ImAr=35
                                  {if IsDebuggerPresent  then begin InfoDlgFrm.RediN.Clear;
                                      for i := 0 to InfoDlgFrm.StrGr.RowCount-1  do
                                      InfoDlgFrm.RediN.Text := InfoDlgFrm.RediN.Text +InfoDlgFrm.StrGr.Cells[4,i];  end;
                                  {if IsDebuggerPresent  then  InfoDlgFrm.RediN.Text := 'PanImH='+IntToStr
                                      (InfoDlgFrm.PanelIm.Height) +' ImH=' +IntToStr (InfoDlgFrm.Image1.Height) +
                                      ' FrmClntH:' +IntToStr (InfoDlgFrm.ClientHeight)             +' -PanAH:' +
                                      IntToStr (InfoDlgFrm.PanelBtn.Height)                        +'='+
                                      IntToStr (InfoDlgFrm.ClientHeight -InfoDlgFrm.PanelBtn.Height) +' PanBxH='+
                                      IntToStr (InfoDlgFrm.PanelBx.Height)                         +' rdiNH='+
                                      IntToStr (InfoDlgFrm.RediN.Height)                           +' PanYH='+
                                      IntToStr (InfoDlgFrm.PanelY.Height)                          +' srGH='+
                                      IntToStr (InfoDlgFrm.StrGr.Height)                           +' frmH='+
                                      IntToStr (InfoDlgFrm.Height)                                 +' ImYr='+
                                      IntToStr (InfoDlgFrm.Image1.Top)                             +' ImAr='+
                                      IntToStr (InfoDlgFrm.Image1.Top+InfoDlgFrm.Image1.Height);//}
   InfoDlgFrm.ActiveControl := InfoDlgFrm.Btn1;
   //InfoDlgFrm.Btn1.SetFocus;       //<+1101 (12å2) Ei onaa:  Cannot focuse invisible or ..
   fnc := InfoDlgFrm.ShowModal;
   Arvo := InfoDlgFrm.ComBx1.Text; //< +8.0.0
   result := fnc;
end;//InfoDlg_

procedure TInfoDlgFrm.FormShow(Sender: TObject);      begin
   //if Visible  then RediN.SetFocus;                   //<+10.0.5: Jotta rutiinisti annettu Enter ei poistaisi näytöltä.
   if Visible and Showing  then Btn1.SetFocus;          //<141.2 takas.
end;

procedure TInfoDlgFrm.FormClose(Sender: TObject; var Action: TCloseAction);      VAR o :integer;      begin
 //if TComponent (Sender).Name<>''  then beep; //< "InfoDlgFrm"
 //o := TComponent(Sender).Tag;                //< 0 AINA (=Frm), Buttoneiden TAG asetettu tätä varten 1..4
{  if Sender=Btn1  then o := 1  else           //<,,Ei tunnista BtnX:ää.!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   if Sender=Btn2  then o := 2  else}          //   Sama vaikka ModalResult := 1..

   o := val;
   if NOT (o IN [1..BtnLkm]) //or (o=BtnLkm)   //<Jos suljetaan X :stä o := 4 AINA, tämä korjaa o :n 9 :ksi.
      then o := 9;                             //'HUOM: Ei enää vikaksi Btn:ksi, joka on AINA "Peru" tai "Cancel".
   InfoDlgFrm.ModalResult := o;                //<P.o. > 0, muuten Form ei sulkeudu.
end;

procedure TInfoDlgFrm.Btn1Click(Sender: TObject);      begin
   val := 1;   Close;
 //ModalResult := 1; //<Ei worki = Ei välity kutsupaikkaan.
end;
procedure TInfoDlgFrm.Btn2Click(Sender: TObject);      begin
   val := 2;   Close;  end;
procedure TInfoDlgFrm.Btn3Click(Sender: TObject);      begin
   val := 3;   Close;  end;
procedure TInfoDlgFrm.Btn4Click(Sender: TObject);      begin
   val := 4;   Close;  end;

procedure TInfoDlgFrm.StrGrWidestColInRow(Sender: TObject;  ACol, ARow, newWidth: Integer);    begin
   inherited;                                             //StrGr.Cells[ACol,ARow]
   StrGr.ColWidths[ACol] := newWidth;
end;

procedure TInfoDlgFrm.PanelBtnClick(Sender: TObject);      begin
   inherited;              //KOKLATTU:  StrGr :n Cellit eivät tunnista hiiren Clickiä, jos Celli <= FixedCol/Row
{  if StrGr.Enabled
   then begin StrGr.Enabled := false;  StrGr.SelectionEnabled := false;
              StrGr.Options := StrGr.Options -[goRowSelect,goDrawFocusSelected,goEditing];  end
   else begin StrGr.Enabled := true;   StrGr.SelectionEnabled := true;
              StrGr.Options := StrGr.Options +[goRowSelect,goDrawFocusSelected,goEditing];  end;
                                      if IsDebuggerPresent  then Caption := 'Enab=' +fBmrkt0 (StrGr.Enabled,2);}
end;

procedure TInfoDlgFrm.RediNMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
begin
   inherited;
  {if IsDebuggerPresent  then begin
      if ssShift IN Shift  then begin  if Image1.Top<PanelIm.Height -Image1.Height -10  then
                                          Image1.Top := Image1.Top +10;  end
                           else begin  if Image1.Top>0  then
                                          Image1.Top := Image1.Top -10;  end;
      Caption := 'ImTop='+IntToStr (Image1.Top) +
                  ' ImW=' +IntToStr  (Image1. Width) +' ImH='  +IntToStr (Image1. Height) +
                  ' PanW=' +IntToStr (PanelIm.Width) +' PanH=' +IntToStr (PanelIm.Height) +
                  ' pVs='  +fBmrkt0 (PanelIm.Visible,1) +' IVs='  +fBmrkt0 (Image1.Visible,1);  end;}

end;

function InfoDlg (InfoStr :String;   Symbol :TMsgDlgType; //Tämä on vanhojen kutsujen muuntamiseen uudelle FNC´lle.
                  BtnOts1,BtnOts2,BtnOts3,BtnOts4, BtnInfo1,BtnInfo2,BtnInfo3,BtnInfo4 :String) :integer;
      VAR o :integer;  ss :string;      begin
   o := InfoDlg_ (InfoStr,Symbol, BtnOts1,BtnOts2,BtnOts3,BtnOts4, BtnInfo1,BtnInfo2,BtnInfo3,BtnInfo4,
                  TRUE{KopioInfokin},FALSE{Arvokin},''{PudStr},{VAR Arvo}ss);
               //'KopioInfokin="Leikkaa ja kopioi ... info '''''':n itemErottimena ";"
               //                   'Arvokin=Pud.valikko(PudStr) + arvoBoxi tulee + VAR Arvo palautetaan
   result := o;
end;

procedure TInfoDlgFrm.ComBx1KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);      begin//+8.0.0
   inherited;
   if Key=13  then begin
      val := 1;   Close;  end;
end;

procedure TInfoDlgFrm.RediNKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);      begin
  inherited;
   if Key=13          //<,+1101 12å2.
      then Btn1Click (Sender);
end;

initialization

{
    IconID := IconIDs[DlgType];
    IconTextWidth := TextRect.Right;
    IconTextHeight := TextRect.Bottom;
    if IconID <> nil then
    begin
      Inc(IconTextWidth, 32 + HorzSpacing);
      if IconTextHeight < 32 then IconTextHeight := 32;
    end;

    Icon := TIcon.Create;
    with InfoDlgFrm do
    try
      IcoFilen := gAjoPath ; //+-12.0.05 oli: ExtractFilePath (Application.ExeName);      //<Pelkkä polku ilman filenimeä
      IcoFilen := IcoFilen +'Config\Error.bmp';               //<Extract.. teki jo 1x '\'
      Icon.LoadFromFile (IcoFilen);

      Image1.Width := Icon.Width;
      Image1.Height := Icon.Height;
      Image1.Canvas.Draw(0,0,Icon);
    finally
      Icon.Free;
    end;
}
end.
