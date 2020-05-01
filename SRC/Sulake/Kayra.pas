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

unit Kayra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComboBoxXY, ExtCtrls, PanelNola, Math, LabelNola{=DEVELOPER1=}, NolaForms, Printers;//, clipbrd;

type
//TKayraFrm = class(TForm)
  TKayraFrm = class(TFormNola)
    Image: TImage;
    Panel: TPanelNola;
    SuljeBtn: TButton;
    TulostBtn: TButton;
    SulLbl: TLabelNola;
    SulCmBx: TComboBoxXY;
    SftLb: TLabelNola;
    SftCmBx: TComboBoxXY;
    PvitaLb: TLabelNola;
    PvitaBtn: TButton;
    PerusBtn: TButton;
    AlpBtn: TButton;
    OdotaLbl: TPanelNola;
    procedure SuljeBtnClick(Sender: TObject);
    procedure TulostBtnClick(Sender: TObject);
    procedure SulCmBxEnter(Sender: TObject);
    procedure SulCmBxChange(Sender: TObject);
    procedure SftCmBxEnter(Sender: TObject);
    procedure SftCmBxChange(Sender: TObject);
    procedure SulCmBxKeyPress(Sender: TObject; var Key: Char);
    procedure SftCmBxKeyPress(Sender: TObject; var Key: Char);
    procedure PvitaBtnClick(Sender: TObject);
    procedure PerusBtnClick(Sender: TObject);
    procedure AlpBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure PrintContent;      //DEVELOPER2
  public
    { Public declarations }
  end;

var
  KayraFrm: TKayraFrm;

implementation

uses Y_, Herja1, PrintDialogNola, Defs, Globals, Unit0;

const
  Vmarg=46;   Amarg=25;   ColrMax=4;
var
  edX,edY,Colr,               //<Colr =käyrien värivuorottelun tieto, kasvaa +1  PRC esitaKayra. Ks. myös FNC fColr_
  imaW,imaH,                  //<Piirtoalan raja, jotka asetetaan aina, kun FormShow + FormResize
  DekValiX,DekValiY,          //<150 pixeliä dekadiviivojen väliksi. 100 liian pieni
  KayOs :integer;             //<Osoite ColrAr[] :iin
  KayAr :Array [1..ColrMax] of Record       //<Array, jossa tieto vimmeisistä käyrälaskentaparametreista,
            KaySuC :string;                 // jota käytetään, kun FrmResized
            KaySft,KayColr :integer;  end;
  suC :string;
  Sft :integer;                             //,NytShow=TR, kun KUTSUTAAN Frmia, ks. initialization +Show +Resized
  NytShow :boolean;
  ed_SucAr :Array [1..ColrMax] of Record
               ed_Suc :string;              //<Kunkin sulakeväririvin selitysteksti, esim. "IECgGyr"
               ed_Sft :integer;  end;
{$R *.DFM}

procedure PvitaBtnON;      begin
   with KayraFrm  do begin
      PvitaBtn.Font.Style := [fsBold];
      PvitaBtn.Enabled := true;   end;//with
end;
procedure PvitaBtnOF;      begin
   with KayraFrm  do begin
      PvitaBtn.Font.Style := [];
      PvitaBtn.Enabled := false;  end;//with
end;
procedure ChkPvitaBtnEnab;      VAR sc,sf :string;      begin
   with KayraFrm  do begin
      sc := SulCmBx.Text;
      sf := SftCmBx.Text;
      if fSu_Sama (suC,sc) and fSu_Sama (fImrkt0 (Sft,1),sf)
         then PvitaBtnOF
         else PvitaBtnON;
   end;//with
end;

procedure TyhjaaKayAr;      VAR i :integer;      begin
   for i := 1 to ColrMax  do
   with KayAr[i]  do begin
      KaySuC := '';
      KaySft :=  0;
      KayColr := 0;  end;
end;

function fColr :integer;      var c :integer;      begin
   c := (Colr MOD ColrMax);
   if c>999  then beep;     //<Breeakpointin takia
   result := c;
end;
function clFcolr :integer;      begin
   case fColr of
{     1 :result := clRed;
      2 :result := clBlue;
      3 :result := clBlack;
   else  result := clGreen;  end;}
      1 :result := clRed;
      2 :result := clBlue;
      3 :result := clGreen;
   else  result := clBlack;  end;
end;
function fSft :real;      begin
 //KsftYR := 1+ (a_getReaa (30220,mo.moty.SulSft) +suToler)/100;  =Malliksi
   result := 1 + Sft/100;
end;
//====================================================================================================================
function xKorj :integer;       begin//<,,Marginaali- yms. korjaus
   result := Vmarg;
end;
function yKorj :integer;       begin//<,,Marginaali- yms. korjaus
 //imaH := KayraFrm.Height-KayraFrm.Panel.Height-27; // = AlkuAsetSijoituksessa
 //result := imaH - Amarg;
   result := KayraFrm.Image.Height - Amarg;
end;

function xToLog (arvo :real) :integer;       begin//<,,X -arvon sijoitus koordinaatiston X-akselille, sis. marg. yms.
   result := pyor (xKorj + DekValiX*Log10(arvo));
end;
function IkToLog (arvo :real) :integer;      VAR dek :integer;   begin //<,,Ik -arvo Y-akselilla, sis. marg. yms.
  dek := pyor (xKorj + DekValiX*Log10(arvo));                          //<dek valmiina, jos joskus origo muuttuu
(* if arvo=0
      then dek := 0;*)
(* try
      dek := pyor (xKorj + DekValiX*Log10(arvo));                          //<dek valmiina, jos joskus origo muuttuu
   except
      //on E :Exception do
         ShowMessage('Virhe r140');//E.Classname +E.Message);
   end;*)
   result := dek;
end;

function yToLog (arvo :real) :integer;       begin//<,,Y -arvon sijoitus koordinaatiston Y-akselille, sis. marg. yms.
   result := pyor (yKorj - DekValiY*Log10(arvo));
end;
function TimToLog (arvo :real) :integer;      VAR dek :integer;   begin //<,,Tim-arvo Y-akselilla, sis. marg. yms.
   dek := pyor ( yKorj - DekValiY*Log10 (arvo*1000) ); //< 1000 => dek=3, koska pienin arvo = 0.001 = 1 / 1000 ###
   result := dek;
end;
                                              //,,###############################################################
procedure pisteIkTim (Ik,Tim :real);      VAR ax,ay :integer;
                                              //,,################### 100pix=n.30mm -> 1mm=3.3pix ###############
   procedure piste (x,y :integer);      begin //,,###############################################################
      KayraFrm.Image.Canvas.Brush.Color := clFcolr;//clRed; //=Täyttöväri. Color JÄÄ PÄÄLLE
      KayraFrm.Image.Canvas.Pen.Color :=   clFcolr;//clRed; //=Viivaväri.  Color JÄÄ PÄÄLLE
      KayraFrm.Image.Canvas.Brush.Style := bsSolid;       //=Täytetty
    //KayraFrm.Image.Canvas.Rectangle (200,200, 250,250); //vyXY, oaXY =Piirretään JK =MALLI Edv:sta
    //KayraFrm.Image.Canvas.Ellipse (X-2,Y-2, X+3,Y+3);   //< -2, koska paksut viivat lev=2 =Korjataan ½-väliin
      KayraFrm.Image.Canvas.Ellipse (X-2,Y-2, X+2,Y+2);   //< -2, koska paksut viivat lev=2 =Korjataan ½-väliin
      if (edX>0) or (edY>0)  then begin                   //'Rectangle vy=x1,y1  oa=x2,y2 """""""""""""""""""""
         KayraFrm.Image.Canvas.MoveTo (edX,edY);          //'X-1,Y-1 ei näy ollenkaan, koska viivalev=1""""""""
         KayraFrm.Image.Canvas.LineTo (x,y);
      end;
      edX := x;  edY := y;
      KayraFrm.Image.Canvas.Pen.Color :=   clBlack;      //=Viivaväri.  Color JÄÄ PÄÄLLE
      KayraFrm.Image.Canvas.Brush.Style := bsClear;      //=Sama kuin tausta, bsSolid=Täytetty
   end;
begin
   ax := IkToLog(Ik);
   ay := TimToLog(Tim);
   piste (ax,ay);
{,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,TULOSTAA Ik,Tim,X,Y -arvot pisteille, HYVÄ,,,
   KayraFrm.Image.Canvas.Font.Color := clRed;          //=Tekstiväri. Color JÄÄ PÄÄLLE
   KayraFrm.Image.Canvas.TextOut (X+8,Y-8,fRmrkt0(Ik,1,0) +'/' +fRmrkt0(Tim,1,3) +'  x='+fImrkt0(x,1) +', y='+fImrkt0(y,1));
    KayraFrm.Image.Canvas.Font.Color :=  clBlack;      //=Tekstiväri. Color JÄÄ PÄÄLLE''''''''''''''}
end;
//====================================================================================================================
procedure LogViivasto;      var i,j :extended;  x,y,k,m,b :integer;  r :real;  st :string;  ulos :boolean;  begin
with KayraFrm.Image   do begin                             //##### KAIKKI LogViivat saa näkyviin parhaiten, #####
    Canvas.Pen.Color :=  clGray;  //< Viivaväri. JÄÄ PÄÄLLE  ##### kun Formiin asetta Hor+VertScrollBarit. ######
    Canvas.Font.Color := clBlack; //< Textiväri. JÄÄ PÄÄLLE  #####'#######################################'######

    x := 0;   i := 1; //,,PystySUUNTAISET viivat,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   while x<imaW  do begin //< x=1MA :n pystyviiva, josta jatkaa for silmukka + break
// while x<=xToLog (100000)  do begin //< x=100kA :n pystyviiva, josta jatkaa for silmukka
      j := i;
      for k := 1 to 9  do begin
         if k IN [1,5]  then m := 4              //<Koordin.viivan akselin ylittävä häntä
                        else m := 0;
         x := xToLog (j);
       //if x>imaW  then break;
         if x>xToLog (100000)  then break;
         Canvas.MoveTo (x,TimToLog(1000));             //<Alkupiste Formin yläreunassa, viiva siitä ALASP.
            if k=1  then Canvas.Pen.Width := 2;        //<Pääjakoviivat paksummiksi
            if k=5  then Canvas.Pen.Color := clBlack   //<LogViivojen ARVOvälin ½-väli
                    else Canvas.Pen.Color := clGray;   //<Kaikki muut viivat}
           {if k=5  then Canvas.Pen.Color := clGray    //<LogViivojen ARVOvälin ½-väli. <,OK, muttei tulostu
                    else Canvas.Pen.Color := clSilver; //<Kaikki muut viivat                        }
         Canvas.LineTo (x,yKorj+m);              //<Eka viiva yli akseliviivan m :n verran alemmaksi
            if k=1  then begin                   //,Jos 0, asettaa autom. 1 :ksi
                         Canvas.Pen.Width := 1;
                         r := j*1;
                         if r<=1.1      then begin st := '1A';                         b := 8;   end else
                         if r<=10.1     then begin st := '10A';                        b := 10;  end else
                         if r<=100.1    then begin st := '100A';                       b := 12;  end else
                         if r<=1000.1   then begin st := '1kA';                        b := 10;  end else
                         if r<=10000.1  then begin st := '10kA';                       b := 12;  end else
                         if r<=100000.1 then begin st := '100kA';                      b := 23;  end else
                                             begin st := '1MA';                        b := 12;  end;//<EiKoskaan
                                 {EiKoskaan= begin st := fImrkt0(pyor(r/1000),1)+'kA'; b := 15;  end;}
                         Canvas.TextOut (x-b,yKorj+7, st);  end;//'Extended -> Integer  'b=Ik:n dim.-arvon siirto
         j := j+i;                               //<10->20->30..90, 100->200..
      end;
      i := i*10;                                 //< 1 -> 10 -> 100 -> 1000...
   end;//while
   y := TimToLog(15);   //<,,15s .n kohdalle viivan nysä + arvo 15s,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   x := xKorj-6;
   Canvas.MoveTo (x,y);
   Canvas.LineTo (x+6,y);
   Canvas.TextOut (2,y-8, '15s');

  {y := 0;   }i := 1;  ulos := false;
 //while y>=0  do begin //<,,VaakaSUUNTAISET viivat,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   while NOT ulos  do begin //<,,VaakaSUUNTAISET viivat,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      j := i;
      for k := 1 to 9  do begin
         if k IN [1,5]  then m := 4                    //<Koordin.viivan akselin ylittävä häntä
                        else m := 0;
         y := yToLog (j);
         Canvas.MoveTo (xKorj-m,y);                    //<Alkupiste aika-akselista -m, viiva siitä OIKEALLE
            if k=1  then Canvas.Pen.Width := 2;        //<Pääjakoviivat paksummiksi
            if k=5  then Canvas.Pen.Color := clBlack   //<LogViivojen ARVOvälin ½-väli
                    else Canvas.Pen.Color := clGray;   //<Kaikki muut viivat}
           {if k=5  then Canvas.Pen.Color := clGray    //<LogViivojen ARVOvälin ½-väli. <,OK, muttei tulostu
                    else Canvas.Pen.Color := clSilver; //<Kaikki muut viivat                        }
         Canvas.LineTo (xToLog (100000){imaW},y);//<100000 = 1MA
            r := j/1000;                         //<Siirretään 3 :lla dekadilla 1 -> 0.01. j/1000, koska alkaa...
            if k=1  then begin                   //,Jos 0, asettaa autom. 1 :ksi
                         Canvas.Pen.Width := 1;
                       //r := j/1000;            //<Siirretään 3 :lla dekadilla 1 -> 0.01. j/1000, koska alkaa...
                         if r<=0.0011  then st := '0.001s'                     else
                         if r<=0.011   then st := '0.01s'                      else
                         if r<=0.11    then st := '0.1s'                       else
                         if r>=999     then st := fImrkt0(pyor(r/1000),1)+'k'  else
                                            st := fImrkt0(pyor(r),1)+'s';           //<Extended -> Integer
                         Canvas.TextOut (2,y-9, st);  end;
         j := j+i;                               //< 10->20->30..90, 100->200..
         if r>=1000  then begin
            ulos := true;
            break;  end;
      end;//for
      i := i*10;                                 //< 1 -> 10 -> 100 -> 1000...
   end;//while
end;//with KayraFrm.Image
end;//LogViivasto
//===============================================================================================================
procedure esitaKayra (kaikki :boolean);
      CONST arMax=50;   TYPE TIKarType  = array [1..ArMax] of real;
                             SulArType =  array [1..ArMax] of integer;
      VAR TimAr,IkAr :TIKarType;    SulAr :SulArType;      //sulRect :TRect;
          TimKpl,SulKpl, i,o, t,u,sul, ax,ay :integer;     //<Vikat osoitteet ao. tlkssa
   //...................................................................................
   procedure sijSul_kpl (so :string);                 //<Sijoittaa myös SULAKEarrayn vikan osoitteen
         VAR i,v,os,Code,ai :integer;    sa :string;  arvoOn :boolean;      begin
      for i := 1 to arMax  do SulAr[i] := 0;          //<Jokaiseen alkioon 0, jota testataan <<<<<<<<<< +130.0
      i := 1;   os := 0;   v := Length(so);
      while i<=v  do begin
         sa := '';  arvoOn := false;
         while (i<=v) and (CharInSet(so[i], ['0'..'9']))  do begin
            sa := sa +so[i];
            i := i+1;
            arvoOn := true;
         end;
         if arvoOn  then begin  Val(sa,ai,Code);
                                os := os+1;
                                if Code=0  then SulAr[os] := ai
                                           else SulAr[os] := 0;  end
                    else i := i+1;
      end;//while
      SulKpl := os; //<SulKpl = vika osoite
   end;//sijSul_kpl
   //...................................................................................
   procedure sijTim_kpl (so :string);              //<Sijoittaa myös AIKAarrayn vikan osoitteen
                                                   //Tekee AIKAtlkn: "0.01  0.03  0.1  0.5  1  3  5  10  30  100"
         VAR i,v,os,Code :integer;  ar :real;  sa :string;  arvoOn :boolean;      begin

      for i := 1 to arMax  do TimAr[i] := 0;       //<Jokaiseen alkioon 0, jota testataan <<<<<<<<<<

      i := 1;   os := 0;   v := Length(so);        //<so= '0.010 0.030 .. 100.000 =23 kpl. Debuggeri näyttää 146, mutta os =23 =ok.
      while i<=v  do begin
         sa := '';  arvoOn := false;
         while (i<=v) and (CharInSet(so[i], ['0'..'9','.']))  do begin
            sa := sa +so[i];
            i := i+1;
            arvoOn := true;
         end;
         if arvoOn  then begin  Val(sa,ar,Code);
                                os := os+1;
                                if Code=0  then TimAr[os] := ar
                                           else TimAr[os] := 0;  end
                    else i := i+1;
      end;//while
      TimKpl := os; //<TimKpl = vika osoite
   end;//sijTim_kpl
   //...................................................................................
   procedure sijIk (QsuC :string;  Qsul :integer);      VAR i :integer;  ar,sr :real;      begin
      for i := 1 to arMax  do begin                           //<,,Sijoittaa virta-arvot IkAR[] :iin
         ar := TimAr[i];
         if ar>0
         then begin
              sr := fSft;                                     //<Vain BreakPointeja varten
              ar := sr * Ikt_R(QsuC,Qsul,ar);                 //<Ainoa fSft -sijoitus tässä
              IkAr[i] := ar;   end
         else Break;
      end;
   end;
   //...................................................................................
                    //o,=Sulakkeen nimellisvirran järjN:o (1,2,3...jne) = silmukkalaskuri
   procedure sijAyAx (o :integer;  VAR y,x :integer);     begin //< y,x = Sulakearvotextin sijainnin hienosäätö
     {if (ohj>0)  then y := -475        //<Ohjataan käyrien alapäähän        //KayraFrm.Image.Height-Amarg - 120;
                  else y := 18;
      if Odd (u)  then  if ohj>0  then y := y+12
                                  else y := y+12; //'''OK, mutta X kohdistaa tekstin YLIMMÄN pisteen mukaan'''''}
      y := 10;
      if NOT Odd (o)  then y := y+11;   //<Mahd. vielä KOKO rivi ylösp.  1.sulakekäyrän sulakearvoteksti
      y := y +Colr*6;                   // esim. 125.  ('Odd=Pariton) jää alemmksi
//    if NOT Odd (Colr)  then y := y+6; //<Nostetaan parilliset värit ylemmäksi = perääkäisten värien ero =12 

      if sul>=1000  then x := 15  else
      if sul>=100   then x := 11  else
      if sul>=10    then x := 7   else x := 4;  end;
   //...................................................................................
   function fKayratOn :boolean;      var i :integer;      begin //<,TR, jos löytyy jo piirretty käyrä aiemmista
      result := false;
      for i := 1 to ColrMax  do
      if fSu_Sama (suC,ed_SucAr[i].ed_Suc)  then begin   //<Kunkin sulakeväririvin selitysteksti, esim. "IECgGyr"
         result := true;   break;  end;
   end;
//---------------------------------------------------------------------------------------------------------------
begin//esitaKayra
{  pisteIkTim (50000, 0.005);   pisteIkTim (10000, 0.01);   pisteIkTim (5000, 0.05);   pisteIkTim (1000, 0.1);
   pisteIkTim (500,   0.5);     pisteIkTim (100,   1   );   pisteIkTim (50,   5);      pisteIkTim (10,   10);
   pisteIkTim (5,     15);      pisteIkTim (5,     50);     pisteIkTim (1,    100);//}

   KayraFrm.OdotaLbl.Visible := true;
   KayraFrm.Update; //<Muuten ODOTAlbl ei tule ollenkaan näkyviin ja Btnit näkyvät aukkoina, TODETTU

if kaikki
then o := 1     //<Esitetään jo käsitellyt 4 vikaa käyrästöä
else begin      //<,,Esitetään vika käyräparvi ja lisätään taulukkoon sen laskentaparametrit
   Colr := Colr+1;
   if Colr>ColrMax  then Colr := 1;   //<Värilaskuri alkuun, kun 4 käyrää piirretty.
                                      //'1=Pun  2=Sin  3=Vih  4=Musta,  ks. fColr_
   KayOs := KayOs +1;
   if KayOs>ColrMax  then begin
      KayOs := ColrMax;
      for i := 1 to KayOs-1  do
         KayAr[i] := KayAr[i+1];
   end;
   KayAr[KayOs].KaySuC :=  suC;
   KayAr[KayOs].KaySft :=  Sft;
   KayAr[KayOs].KayColr := Colr;
    o := KayOs;
end;

for o := o to kayOs  do begin //su_OFAg su_OFAm su_IECg su_IECgAR su_IECgYR su_IECd su_IECdAR su_IECdYR
   suC :=  KayAr[o].KaySuC;
   Sft :=  KayAr[o].KaySft;
   Colr := KayAr[o].KayColr;
   if fSu_Sama (suC,su_OFAg) //,,OFAgG,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   then begin
        sijSul_kpl ('2, 4, 6, 10, 16, 20, 25, 32, 40, 50, 63, 80, 100, 125, 160, 200, 250, 315, 400, 500, 630'); //+130.0:  2A
          {#######################################################################################
           #####,, PAKKO testata JOKAINEN SULfncX :n PISTE: paljastaa ARVOVIRHEET, todettu ,,#####
           #####,,#########################################################################,,#####}
       {sijTim_kpl (fRmrkt0(0.03 ,1,3) + ' '+ fRmrkt0(0.07 ,1,3) + ' '+
                    fRmrkt0(0.1  ,1,3) + ' '+ fRmrkt0(0.2  ,1,3) + ' '+ fRmrkt0(0.5  ,1,3) + ' '+
                    fRmrkt0(1    ,1,3) + ' '+ fRmrkt0(2    ,1,3) + ' '+ fRmrkt0(3    ,1,3) + ' '+
                    fRmrkt0(4    ,1,3) + ' '+ fRmrkt0(5    ,1,3) + ' '+ fRmrkt0(6    ,1,3) + ' '+
                    fRmrkt0(7    ,1,3) + ' '+ fRmrkt0(8    ,1,3) + ' '+ fRmrkt0(9    ,1,3) + ' '+
                    fRmrkt0(10   ,1,3) + ' '+ fRmrkt0(15   ,1,3) ); //<''OFAAgG matem.fnclla}
        sijTim_kpl (fRmrkt0(0.01 ,1,3) + ' '+ fRmrkt0(0.1  ,1,3) + ' '+ fRmrkt0(0.2  ,1,3) + ' '+
                    fRmrkt0(0.5  ,1,3) + ' '+ fRmrkt0(1    ,1,3) + ' '+ fRmrkt0(2    ,1,3) + ' '+
                    fRmrkt0(3    ,1,3) + ' '+ fRmrkt0(4    ,1,3) + ' '+ fRmrkt0(6    ,1,3) + ' '+
                    fRmrkt0(8    ,1,3) + ' '+ fRmrkt0(10   ,1,3) + ' '+ fRmrkt0(15   ,1,3) + ' '+
                    fRmrkt0(20   ,1,3) + ' '+ fRmrkt0(30   ,1,3) + ' '+ fRmrkt0(40   ,1,3) + ' '+
                    fRmrkt0(60   ,1,3) + ' '+ fRmrkt0(100  ,1,3){
                  + fRmrkt0(300  ,1,3) + ' '+ fRmrkt0(1000 ,1,3) + ' '+ fRmrkt0(3600 ,1,3) + ' '+
                    fRmrkt0(7200 ,1,3) + ' '+ fRmrkt0(10000,1,3)});
        for u := 1 to SulKpl  do begin
           edX := 0;  edY := 0;
           sul := SulAr[u];    //<SUL 4A ... 630A tulostuu käyrän yläpäähän.....................
           sijIk (suC,sul);

           for t := 1 to TimKpl  do
               pisteIkTim (IkAr[t], TimAr[t]);

           if NOT fKayratOn  then begin
//            KayraFrm.Image.Canvas.Font.Style :=  fsBold;
{             if sul>100  then begin
//                  sulRect := Rect(10,10, 100,100);
//                  sulRect := Rect(10,10, edX+50,edY+4);
//                  KayraFrm.Image.Canvas.TextRect(sulRect,100,200, fImrkt0(sul,1)); end;
//               sulRect := Rect(10,10, 100,100);
                 sulRect := Rect(100,100, 100,100);
//               sulRect := Rect(10,10, xKorj+edX+4,edY+4);
                 KayraFrm.Image.Canvas.TextRect(sulRect,100,200, fImrkt0(sul,1)); end;}

              sijAyAx (u, ay,ax);                     //<, ay,ax = Sulaketextin sijainnin hienosäätö
              KayraFrm.Image.Canvas.Font.Color :=  clFcolr;
              KayraFrm.Image.Canvas.TextOut (edX-ax,edY-ay,fImrkt0(sul,1));
           end;//if Color..
        end;//for u
       {with KayraFrm.Image  do begin          //,,Laskee ja tulostaa DekValisuhteen TIEDOKSI SUUNNITTELUA varten
             Canvas.TextOut (Vmarg-20,1300, 'kX=       '+fRmrkt0((Width-Vmarg) /dekvaliX,1,2));     //=5.11
             Canvas.TextOut (Vmarg-20,1320, 'kY=       '+fRmrkt0((Height-Amarg)/dekvaliY,1,2));     //=5.25
             Canvas.TextOut (Vmarg-20,1340, 'FmWdh= '+fimrkt0(KayraFrm.Width,1));
             Canvas.TextOut (Vmarg-20,1360, 'ImWdh= '+fimrkt0(Width,1));
             Canvas.TextOut (Vmarg-20,1380, 'imW=     '+fimrkt0(imaW,1));
             Canvas.TextOut (Vmarg-20,1400, 'imH=      '+fimrkt0(imaH,1));
         end;//}
   end else//''OFAgG''
   if fSu_Perus (suC)=su_IECd //,,IECdYR/AR,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   then begin
        sijSul_kpl ('2, 4, 6, 10, 16, 20, 25, 35, 50, 63, 80, 100'); //<Sijoittaa SulAr   +130.0:  2A
       {#######################################################################################
        #####,, PAKKO testata JOKAINEN SULfncX :n PISTE: paljastaa ARVOVIRHEET, todettu ,,#####
        #####,,#########################################################################,,#####}
        sijTim_kpl (fRmrkt0(0.1  ,1,3) + ' '+ fRmrkt0(0.2  ,1,3) + ' '+ fRmrkt0(0.5  ,1,3) + ' '+
                    fRmrkt0(1    ,1,3) + ' '+ fRmrkt0(2    ,1,3) + ' '+ fRmrkt0(3    ,1,3) + ' '+
                    fRmrkt0(4    ,1,3) + ' '+ fRmrkt0(5    ,1,3) + ' '+ fRmrkt0(6    ,1,3) + ' '+
                    fRmrkt0(7    ,1,3) + ' '+ fRmrkt0(8    ,1,3) + ' '+ fRmrkt0(9    ,1,3) + ' '+
                    fRmrkt0(10   ,1,3) + ' '+ fRmrkt0(15   ,1,3) + ' '+ fRmrkt0(20   ,1,3) + ' '+
                    fRmrkt0(30   ,1,3) + ' '+ fRmrkt0(40   ,1,3) + ' '+ fRmrkt0(60   ,1,3) + ' '+
                    fRmrkt0(80   ,1,3) + ' '+ fRmrkt0(100  ,1,3) );
{       sijTim_kpl (fRmrkt0(0.1 ,1,3) + ' '+ fRmrkt0(0.2 ,1,3) + ' '+
                    fRmrkt0(0.3 ,1,3) + ' '+ fRmrkt0(1   ,1,3) + ' '+
                    fRmrkt0(3   ,1,3) + ' '+ fRmrkt0(5   ,1,3) + ' '+
                    fRmrkt0(10  ,1,3) + ' '+ fRmrkt0(15  ,1,3) );}

        for u := 1 to SulKpl  do begin
           edX := 0;  edY := 0;
           sul := SulAr[u];    //<SUL 4A ... 630A tulostuu käyrän yläpäähän.....................
           sijIk (suC,sul);
           for t := 1 to TimKpl  do
               pisteIkTim (IkAr[t], TimAr[t]);

           if NOT fKayratOn  then begin
              sijAyAx (u, ay,ax);                     //<, ay,ax = Sulaketextin sijainnin hienosäätö
              KayraFrm.Image.Canvas.Font.Color :=  clFcolr;
              KayraFrm.Image.Canvas.TextOut (edX-ax,edY-ay,fImrkt0(sul,1));
           end;//if Color..
        end;//for u
   end       //''IECdYR/AR''
   else begin//,,OFAaM,IECgG,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
        if fSu_Sama (suC,su_OFAm)
           then
        sijSul_kpl ('   4, 6, 10, 16, 20, 25, 32, 40, 50, 63, 80, 100, 125, 160, 200, 250, 315, 355, 400, 500, 630')
           else                                                                          //, 355,puuttuu IEC :stä
        sijSul_kpl ('2, 4, 6, 10, 16, 20, 25, 32, 40, 50, 63, 80, 100, 125, 160, 200, 250, 315, 400, 500, 630, '+    //<'+130.0:  2A
                    '800, 1000, 1250');
                {'0.01s 0.03s 0.1s 0.5s 1s 3s 5s 10s 30s 100s'); //<TÄMÄ oli alp.
                 '0.01s 0.03s 0.05s  0.1s 0.2s 0.3s  0.4s 0.5s 1s  2s 3s 5s  10s 30s 100s'); //<Pisteet tasaisemmin käyrällä visuaalisesti
                 '0.01s 0.03s 0.1s 0.4s 1s 2s 5s 10s 30s 100s'); //<Pisteet tasaisemmin käyrällä visuaalisesti}
                                                                 //'mutta särmikkäämpi käyrä ainakin IECgG:llä
       {#######################################################################################
        #####,, PAKKO testata JOKAINEN SULfncX :n PISTE: paljastaa ARVOVIRHEET, todettu ,,#####
        #####,,#########################################################################,,#####}
        sijTim_kpl (fRmrkt0(0.01 ,1,3) + ' '+ fRmrkt0(0.03 ,1,3) + ' '+ fRmrkt0(0.07 ,1,3) + ' '+
                    fRmrkt0(0.1  ,1,3) + ' '+ fRmrkt0(0.2  ,1,3) + ' '+ fRmrkt0(0.5  ,1,3) + ' '+
                    fRmrkt0(1    ,1,3) + ' '+ fRmrkt0(2    ,1,3) + ' '+ fRmrkt0(3    ,1,3) + ' '+
                    fRmrkt0(4    ,1,3) + ' '+ fRmrkt0(5    ,1,3) + ' '+ fRmrkt0(6    ,1,3) + ' '+
                    fRmrkt0(7    ,1,3) + ' '+ fRmrkt0(8    ,1,3) + ' '+ fRmrkt0(9    ,1,3) + ' '+
                    fRmrkt0(10   ,1,3) + ' '+ fRmrkt0(15   ,1,3) + ' '+ fRmrkt0(20   ,1,3) + ' '+
                    fRmrkt0(30   ,1,3) + ' '+ fRmrkt0(40   ,1,3) + ' '+ fRmrkt0(60   ,1,3) + ' '+
                    fRmrkt0(80   ,1,3) + ' '+ fRmrkt0(100  ,1,3) );
{       sijTim_kpl (fRmrkt0(0.01 ,1,3) + ' '+ fRmrkt0(0.03 ,1,3) + ' '+
                    fRmrkt0(0.1  ,1,3) + ' '+ fRmrkt0(0.5  ,1,3) + ' '+
                    fRmrkt0(1    ,1,3) + ' '+ fRmrkt0(3    ,1,3) + ' '+
                    fRmrkt0(5    ,1,3) + ' '+ fRmrkt0(10   ,1,3) + ' '+
                    fRmrkt0(30   ,1,3) + ' '+ fRmrkt0(100  ,1,3) );}

        for u := 1 to SulKpl  do begin
           edX := 0;  edY := 0;
           sul := SulAr[u];    //<SUL 4A ... 630A tulostuu käyrän yläpäähän.....................
           sijIk (suC,sul);
           for t := 1 to TimKpl  do begin
               pisteIkTim (IkAr[t], TimAr[t]);
               if (u<0) or (t<0)  then beep;  //<jotta u ja t näkyisi Debugg:ssa/Watch
           end;

           if NOT fKayratOn  then begin
              sijAyAx (u, ay,ax);                     //<, ay,ax = Sulaketextin sijainnin hienosäätö
              KayraFrm.Image.Canvas.Font.Color :=  clFcolr;//clRed;
              KayraFrm.Image.Canvas.TextOut (edX-ax,edY-ay,fImrkt0(sul,1));
           end;
        end;//for u
   end;//''OFAaM,IECgG''

   with KayraFrm.Image.Canvas  do begin
      t := 80 - Colr*15;                       //< 1=Red->65   2=Blue->50  3=Green->35  4=Black->20
      ax := Vmarg+10;  ay := KayraFrm.Image.Height-Amarg - t;

      if (ed_SucAr[Colr].ed_Suc<>'') and  NOT kaikki  then begin //<,,Putsataan vanha teksti alta -> Kirjoit. White
         Font.Color :=  clWhite;//clRed;
         TextOut (ax,ay, ed_SucAr[Colr].ed_Suc);
         TextOut (ax+70,ay, 'Sft = ' +fImrkt0 (ed_SucAr[Colr].ed_Sft,1) +'%');  end;
      Font.Color :=  clFcolr;//clRed;
      TextOut (ax,ay, suC);//+' Colr='+fImrkt0(Colr,1)+' clFcolr='+fImrkt0(clFcolr,1));
      TextOut (ax+70,ay, 'Sft = ' +fImrkt0 (Sft,1) +'%');
      ed_SucAr[o].ed_Suc := suC;   //<Pannaan talteen, jotta osataan pyyhkiä nyt kirjoitettu suC
      ed_SucAr[o].ed_Sft := Sft;   //<Pannaan talteen, jotta osataan pyyhkiä nyt kirjoitettu Sft
//    Font.Style :=  [];           //=TekstiTyyli JÄÄ PÄÄLLE
      Font.Color :=  clBlack;      //=Tekstiväri. Color JÄÄ PÄÄLLE
   end;
end;//for o ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
                      {with KayraFrm.Image.Canvas  do begin
                          Font.Color :=  Colr;         //<Tekstiväri. Color JÄÄ PÄÄLLE
                          TextOut (Vmarg+25,Height-Amarg-95, 'clFcolr=      '+fImrkt0(clFcolr,1));
                          TextOut (Vmarg+25,Height-Amarg-80, 'fColr=        '+fImrkt0(fColr,1));   //<,fColr=Colr
                          TextOut (Vmarg+25,Height-Amarg-65, 'Colr=         '+fImrkt0(Colr,1));
                          TextOut (Vmarg+25,Height-Amarg-50, 'Amarg=        '+fImrkt0(Amarg,1));
                          TextOut (Vmarg+25,Height-Amarg-35, 'imH=          '+fimrkt0(imaH,1));
                          TextOut (Vmarg+25,Height-Amarg-20, 'imageH        '+fimrkt0(Height,1));
                          Font.Color :=  clBlack;      //<Tekstiväri. Color JÄÄ PÄÄLLE
                       end;//with}
   KayraFrm.OdotaLbl.Visible := false;
end;//esitaKayra;
//===============================================================================================================
function okSuc :boolean;      var us :string;
   function OKsij (vs :string) :boolean;      begin
      result := false;
      if fSu_Sama (us,vs)  then begin
         us := vs;  result := true;
         suC := us;
         KayraFrm.SulCmBx.Text := us;  end
   end;
begin
  result := false;
  us := KayraFrm.SulCmBx.Text;
  if OKsij (su_OFAg)    or  OKsij (su_OFAm)    or
     OKsij (su_IECgAR)  or  OKsij (su_IECgYR)  or
     OKsij (su_IECdAR)  or  OKsij (su_IECdYR)
  then result := true
  else begin HerjaInfo ('Virheellinen merkkijono sulakeTYYPPINÄ');     //<DEVELOPER2TextBase
             KayraFrm.SulCmBx.SetFocus;  end;
end;//okSuc

function okSftk :boolean;      var i,code :integer;   s :string;   begin
   result := false;
   s := KayraFrm.SftCmBx.Text;
 //for i := 1 to Length (s)  do  if s[i] =','  then s[i] := '.';   //<Korjataan ',' => '.'
   Val(s, i,Code);
   if code=0
   then if (i < -50) or (i > 50)
      then begin HerjaInfo ('KÄYRÄNSIIRRON arvo Sft <> -50..50%');
                 KayraFrm.SftCmBx.SetFocus;  end                   //<Focus takas
      else begin result := true;
                 Sft := i;    end                                  //<Muuttaa arvoa vain jos OK
   else begin    HerjaInfo ('Virheellinen merkkijono KÄYRÄNSIIRTOarvona Sft');
                 KayraFrm.SftCmBx.SetFocus;  end;                  //<Focus takas
end;//okSftk
//===============================================================================================================
{ Tulostaa sisällön:  DEVELOPER1: Koklattu, OK, mutta tulostaa koko arkille }
{procedure PrintContent;      VAR Arect,Brect :TRect;      begin
// Arect := Rect (0,0, KayraFrm.Width,   KayraFrm.Height); //<OK, mutta ottaa koko sivun = kuva venyy korkeudessa
   Arect := Rect (0,0, KayraFrm.Image.Width,KayraFrm.Image.Height);
   Brect := Rect (0,0, Printer.PageWidth,Printer.PageHeight);
   with Printer do begin
      BeginDoc;	                                // start printing
    //Canvas.Draw(0, 0, KayraFrm.Image.Picture.Graphic);      //<OK. draw Image at upper left of page
//    canvas.CopyRect(rect, TImage(control).canvas, srcRect); //<Tämä on PrintDialogNola :sta
      Printer.Canvas.CopyRect(Brect, KayraFrm.Image.Canvas, Arect);
      EndDoc;	                                // finish printing
   end;
end;//}

{DEVELOPER2 BEGIN Kopioutu suoraan moot.pas}
procedure TKayraFrm.PrintContent;
var
   destRect: TRect;
   mult: real;
   leftMargin, topMargin : integer;
begin
     Screen.Cursor := crHourGlass;

     { Marginaalit }
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

     { Tulosteen otsikko }
     printer.Title := PROGRAM_NAME;

     printer.BeginDoc;

     { Lasketaan zoomaus kerroin }
     mult := printer.canvas.font.PixelsPerInch / font.PixelsPerInch * (PrintDlgNola.Zoom / 100);

     { Luodaan otsikko }
     destrect.top := destrect.top + PrintHeader(self, printer.canvas, printer.PageWidth, leftMargin, topMargin,
                     caption, 1, date, time, PrintDlgNola.Zoom, mult, PrintDlgNola.PrintHeader);

     { Merkataan mitä ei tulosteta }
     SuljeBtn.tag :=  SuljeBtn.tag       or PRINT_DISABLED;
     PvitaBtn.tag :=  PvitaBtn.tag       or PRINT_DISABLED;
     TulostBtn.tag := TulostBtn.tag      or PRINT_DISABLED;
     PvitaLb.tag :=   PvitaLb.tag        or PRINT_DISABLED;
     PerusBtn.tag :=  PerusBtn.tag       or PRINT_DISABLED;
     AlpBtn.tag :=    AlpBtn.tag         or PRINT_DISABLED;

     { Merkataan mitkä leviävät sivun levyisiksi }
     Panel.tag :=  Panel.tag or PRINT_WIDTH_FIT_TO_PAGE;

     { Tulostetaan Form(self) }
     destrect.top := destrect.top +
           PrintControlEx(self, destrect.left, destrect.top, printer.canvas,
                          mult, PRINT_BG_COLOR, true, printer.PageWidth - leftMargin);

     printer.EndDoc;
     Screen.Cursor := crDefault;
end;//PrintContent
{ DEVELOPER2 END }
//===============================================================================================================
procedure putsaa;      var ARect: TRect;  i :integer;      begin
//Copy1Click(Sender);                               //copy picture to Clipboard
  for i := 1 to ColrMax  do begin
     ed_SucAr[i].ed_Suc := '';                      //<Kunkin sulakeväririvin selitysteksti, esim. "IECgGyr"
     ed_SucAr[i].ed_Sft := 0;  end;                 //<Kunkin sulakeväririvin käyräsiirtoSft, esim. -10(%)
  with KayraFrm  do
  with Image.Canvas  do begin //,,Putsaa koko Imagen,,,,,,,,,,,,,,,,,,,,,,,,,,,
    CopyMode := cmWhiteness;                        //copy everything as white
    ARect := Rect(0, 0, Image.Width, Image.Height); //get bitmap rectangle
    CopyRect(ARect, Image.Canvas, ARect);	    //copy bitmap over itself
    CopyMode := cmSrcCopy;	                    //restore normal mode
  end;
end;

procedure AlkuEsit (kaikki :boolean);
  {procedure AlpImage;      begin
     {KayraFrm.ClientWidth :=  KayraFrm.Width-8;                         //<,,EiTartte: Asettuu automsti, TODETTU
      KayraFrm.Image.Width :=  KayraFrm.ClientWidth;                     //<Sis. BevelWidth=2x1
      KayraFrm.Image.Height := KayraFrm.Height-KayraFrm.Panel.Height-27; //...-27=CaptionHeight + BevelWidth 2x1
      KayraFrm.Image.Top := 0;
      KayraFrm.Image.Left := 0;                                          //''''''''''''''''''''''''''''''''''''''
//    KayraFrm.Image.ControlStyle := [csOpaque];                         //<Täyttää kok Clientin Rect. Ei worki
//    KayraFrm.ControlStyle := [csOpaque];                               //<Täyttää kok Clientin Rect. Ei worki
   end;}
   procedure sijImaDekv;      begin                //,,Näitä ei nyt tarttis laskea kuin kerran, koska Autosize=FA
      imaW := KayraFrm.Width-8;                    //  ja Stretcf=FA, joten Image näkyy aina saman kokoisena.
      imaH := KayraFrm.Height-KayraFrm.Panel.Height-27;            //<', -27=FrmCaption.  '-8=FrmReunukset
      KayraFrm.Image.Top := KayraFrm.Height-KayraFrm.Panel.Height-KayraFrm.Image.Height-27;
      DekValiX := pyor ((imaW -Vmarg) / 5.11);
      DekValiY := pyor ((imaH -Amarg) / 5.35);//25);
   end;
begin
 //AlpImage;
   sijImaDekv;
   with KayraFrm  do begin
    //Colr := 0;           //<Aloitetaan aina alusta => Colr +1 = 1 = clRed
    //Sft := 0;            //<Eka käyrä aina perusasetuksella (SulC voi olla 'aM')
      SulCmBx.Text := suC;
      SftCmBx.Text := sRmrkt0vex (Sft,1,1);
     LogViivasto;
     esitaKayra (kaikki);  end;
end;//AlkuEsit
//===============================================================================================================
procedure TKayraFrm.SuljeBtnClick(Sender: TObject);      begin
   Close;
end;

procedure TKayraFrm.TulostBtnClick(Sender: TObject);      begin
  IF PrintDlgNola.Execute(modeBLANK, self)  then begin    //DEVELOPER2 6.12.1998
    TulostBtn.Enabled := false;
    Screen.Cursor := crHourGlass;      //<Ilman SCREENiä vipattaa!!!
    try
         PrintContent;
    finally
      Screen.Cursor := crDefault;
    end;//finally
  end;//if PrintDlg...
  TulostBtn.Enabled := True;
end;

procedure TKayraFrm.SulCmBxKeyPress(Sender: TObject; var Key: Char);      begin
  if key=#13  then
     SelectNext(SulCmBx,true,true);
end;
procedure TKayraFrm.SftCmBxKeyPress(Sender: TObject; var Key: Char);      begin
  if key=#13  then
     SelectNext(SftCmBx,true,true);
end;

procedure TKayraFrm.SulCmBxEnter(Sender: TObject);      begin
   with SulCmBx.Items  do begin
      Clear;       {su_OFAg su_OFAm   (su_IECg) su_IECgAR su_IECgYR   (su_IECd) su_IECdAR su_IECdYR}
      {Strings[0] := }Add (su_IECgYR);
      {Strings[1] := }Add (su_IECgAR);
      {Strings[2] := }Add (su_IECdYR);
      {Strings[3] := }Add (su_IECdAR);
      {Strings[4] := }Add (su_OFAg);
      {Strings[5] := }Add (su_OFAm);  end;//with
end;
procedure TKayraFrm.SulCmBxChange(Sender: TObject);      begin
   inherited;
   ChkPvitaBtnEnab;
   PvitaBtnClick(Sender); //<+130.0 nyt päivittyy jo valinnan jälkeen itsekseen, OK.
end;

procedure TKayraFrm.SftCmBxEnter(Sender: TObject);      begin
   SftCmBx.Items.Clear;
   SftCmBx.Items.{Strings[0] := }Add ('-10');
   SftCmBx.Items.{Strings[1] := }Add ('-5');
   SftCmBx.Items.{Strings[2] := }Add ('0');
   SftCmBx.Items.{Strings[3] := }Add ('5');
   SftCmBx.Items.{Strings[4] := }Add ('10');
end;
procedure TKayraFrm.SftCmBxChange(Sender: TObject);      begin
   inherited;
   ChkPvitaBtnEnab;
end;

procedure TKayraFrm.PvitaBtnClick(Sender: TObject);      begin
   Screen.Cursor := crHourGlass;
   if okSuc and okSftk  then begin
      PvitaBtnOF;
      esitaKayra (FALSE);  end;    //<Esittää + lisää yhden käytän
   Screen.Cursor := crDefault;
end;

procedure TKayraFrm.PerusBtnClick(Sender: TObject);      begin
   Screen.Cursor := crHourGlass;
   putsaa;
    TyhjaaKayAr;
    KayOs := 0;
    Sft := 0;
    Colr := 0;
   AlkuEsit (FALSE); //<Esittää ao.sulaketyypin peruskäyrän
   Screen.Cursor := crDefault;
end;

procedure TKayraFrm.AlpBtnClick(Sender: TObject);      begin
   Screen.Cursor := crHourGlass;
   putsaa;
   with KayraFrm  do begin
      Height := 700;
      Left := Left + Width - 670; //<Pidetään OikYläkulma samana
      Width :=  670;
    //Left :=   345;          //<,Pakko määrätä myös, muuten jos isonnettu ja viety vas. tai alas, tai
    //Top :=    -2;           //  pienennetty ja viety oik. tai ylös, KATOAA ALKUPER.btn =Frm HÄVIÄÄ !!!!!
    //if KayraFrm.Left<0  then KayraFrm.Left := 0; //<Ettei AlbBtn mene ohi näytön, vrt. edellä
      Image.Align :=  alNone; //<,Siltä varalta, että obj.insp:ssa on käyty asettamassa
      Image.Height := 2000;   //  välillä alClient, joka PIENENTÄÄ AUTOMAATTISESTI Imagen !!!!
      Image.Width :=  2500;  end;
   AlkuEsit (TRUE);           //<Esittää kaikki mahd. 4 esillä olevaa käyrää
   Screen.Cursor := crDefault;
end;

procedure TKayraFrm.FormResize(Sender: TObject);      begin //<Pääoha kutsuu tätä luontivaiheessa, joten nämä
   Screen.Cursor := crHourGlass;                            // estettävä, muuten menee Colr sekaisin, TODETTU
   if NytShow  then begin
      putsaa;
      AlkuEsit (TRUE);        //<Esittää kaikki mahd. 4 esillä olevaa käyrää
   end;
   Screen.Cursor := crDefault;
end;
procedure TKayraFrm.FormClose(Sender: TObject; var Action: TCloseAction);      begin
 //putsaa;
end;
procedure TKayraFrm.FormShow(Sender: TObject);      begin
   Image.Align :=  alNone;                      //<,Siltä varalta, että obj.insp:ssa on käyty asettamassa
   Image.Height := 2000;
   Image.Width :=  2500;
   OdotaLbl.Left := PerusBtn.Left + PerusBtn.Width +3;
   NytShow := true;                             //,Laskee DekValit + piirtää peruskäyrät
   if KayAr[1].KaySuC=''  then AlkuEsit (FALSE) //<Esittää yhden (perus)käyrän
                          else AlkuEsit (TRUE); //<Esittää kaikki esillä olevat käyrät (max. 4)
   PvitaBtnOF;
   OdotaLbl.Visible := false;
end;

initialization
  NytShow := false;
  edX := 0;  edY := 0;
  Colr := 0;
  TyhjaaKayAr;
  KayOs := 0;
  for Sft := 1 to ColrMax  do begin
     ed_SucAr[sft].ed_Suc := '';       //<Kunkin sulakeväririvin selitysteksti, esim. "IECgGyr"
     ed_SucAr[sft].ed_Sft := 0;  end;  //<Kunkin sulakeväririvin käyräsiirtoSft,      -10(%)
  Sft := 0;
//suC := su_OFAm;
  suC := su_IECgYR; //<Olet.
//suC := su_IECdYR;
//suC := su_OFAg;
end.
