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

unit Korj;
{ - C_GrdAfterPaint kutsuu AsetaRuutu
  - AsetaRuutu järjestelee Panelit, Gridit, W, H...
  - EsitaTlk / Esita:  Asettaa värit, sijoittaa Gridien tekstit (KsijCelliin)
    EsitaTlk´a kutsuu:
       TabCtrlChange
       C_RadClick
       FormShow
120.5o:  Koko 64b-ajan on Korj.PAS´ssa ollut virhe maakaapeliosalla:  alaosa näytöstä  välkkyi piirtäen Grd´ejä ja Pan´eja alekkain eikä ilmeisesti
         koskaan päässyt PRC EdiKarvot´hin. Korjaus:  otin C_Grd.Align :=  ... D_Pan.Align jne. vex, ks. (*µ .. µ*) =KOMMENTOITU VEX sorceosa.
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Grids, StringGridNola,
  StdCtrls, ExtCtrls, NolaForms, Defs, ComCtrls, RichEditNola, Y_, SyottoAv, Globals,
  ImgList, PanelNola, LabelNola{Ktlk +CONST esittelyt};

type
  TKorjFrm = class(TFormNola)
    PanelA: TPanel;
    SuljeBtn: TButton;
    OkBtn: TButton;
    TabCtrl: TTabControl;
    RichInfo: TRichEditNola;
    ScrBx: TScrollBox;
    A_Pan: TPanel;
    A_Grd: TStringGridNola;
    B_Pan: TPanel;
    B_Grd: TStringGridNola;
    C_Pan: TPanel;
    C_Pan2: TPanel;
    C_Rad: TRadioGroup;
    C_Grd: TStringGridNola;
    D_Pan: TPanel;
    C_Redi0: TRichEdit;
    C_Redi1: TRichEdit; //1412/16å4 TRichEditNola;//
    C_Redi2: TRichEdit;
    C_Redi3: TRichEdit;
    C_Redi4: TRichEdit;
    C_Redi5: TRichEdit;
    KPan1: TPanelNola;
    Kedi1: TEdit;
    KPan2: TPanelNola;
    Kedi2: TEdit;
    KPan3: TPanelNola;
    Kedi3: TEdit;
    KPanY: TPanelNola;
    KediY: TEdit;
    KLabY: TLabelNola;
    KPanAlp: TPanelNola;
    KediAlp: TEdit;
    PitTstPan: TPanel;
    procedure FormShow(Sender: TObject);
    procedure SuljeBtnClick(Sender: TObject);
    procedure A_GrdWidestColInRow(Sender: TObject; ACol,ARow,newWidth: Integer);
    procedure TabCtrlChange(Sender: TObject);
    procedure C_RadClick(Sender: TObject);
    procedure C_GrdAfterPaint(Sender: TObject);
    procedure C_GrdSelectCell(Sender: TObject; ACol, ARow: Integer;  var CanSelect: Boolean);
    procedure OkBtnClick(Sender: TObject);
  private
    procedure AsetaRuutu; //<,Näin vain, jottei tarvitsisi:  with KorjFrm...
    procedure EsitaTlk;
    procedure mrkHylly (KOSKET :boolean;  JOHTO_n,KHlaji :integer;  VAAKA :boolean;  Col,Row :integer);
  public
  end;

var
  KorjFrm: TKorjFrm;

implementation

uses Syotto,InfoDlgUnit, UITypes;

{$R *.DFM}

CONST kosketTR=true; kosketFA=false;   levyTR=true; levyFA=false;   vaakaTR=true; vaakaFA=false;
VAR NollaaCellsW :boolean; //<TRUE kun halutaan nollata vanhat ColWidths´it.  
    Jedi{,TotN} :integer;    //<+10.0.1  <0 =Josa  >0 =Edka. TotN kokonaiskäyntikrtlaskuri A_GrdWidestColInRow :lle.
    //& koeFile :textFile;  koeFn :string;

//  GridLineWith on vain Cellien väleissä, ei reunoilla ja kasvattaa RowHeight -arvoa pixeleillään, TODETTU
//,,BxG:n sijoitus lomakkeelle:   Left := fBxX(sar);   Top := fBxY(fRow(X,Y));,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
{function fCelX (aoSar :integer) :integer;      var CelXY :TRect;   begin //< Palautaa CELLin VAS_X:n
   CelXY := KorjFrm.C_Grd.CellRect (aoSar,0);
   Result := CelXY.Left;                                   //<0: (Left, Top, Right, Bottom: Integer);
end;//fCelX
function fCelY (aoRiv :integer) :integer;      var CelXY :TRect;   begin //< Palautaa CELLin YLÄ_Y:n
   CelXY := KorjFrm.C_Grd.CellRect (0,aoRiv);
   Result := CelXY.Top;
end;//fCelY}
function fCelXo (GrdU :TStringGridNola;  aoSar :integer) :integer;      var CelXY :TRect;   begin
   CelXY := GrdU.CellRect (aoSar,0);                                    //'Palautaa CELLin OIK_X:n
   Result := CelXY.Right;
end;//fBxXo
function fCelYa (GrdU :TStringGridNola;  aoRiv :integer) :integer;      var CelXY :TRect;  i :integer;   begin
   CelXY := GrdU.CellRect (0,aoRiv);                                    //'Palautaa CELLin ALA_Y:n
   i := CelXY.Bottom +GrdU.GridLineWidth +3; //< +3 koska FixedRows´lla paksumpi viiva
   Result := i;
end;//fBxYa;

function fPixPit (str :string;  iFont :TFont) :Integer;       VAR k :integer;  ar :real;  apuImage :TImage;
   function fPixPit_ (str :String) :Integer;   VAR n :integer;                 //<,Mjonon pituus PIXeleinä
      begin apuImage := TImage.Create(NIL);
            apuImage.Visible := false;
            apuImage.Parent := KorjFrm;
          //apuImage.Canvas.Font := iFont;
            apuImage.Canvas.Font.Assign (iFont);
           {if apuImage.Canvas.Font.Style=[fsBold]
               then beep;                                                      //<OK.}
          //n := Y_fPixPit (apuImage.Canvas, str, apuImage.Canvas.Font);
            n := apuImage.Canvas.TextWidth (str);       //<'Samat lopputulokset prikulleen ######
            Result := n; //pyor (n*0.75);
            apuImage.Free;   end;
begin//fPixPit,,,,,,,,,,,,,,,,,,,,
   ar := 1;
   k := pyor (ar *fPixPit_ (str));
   Result := k;
end;

//&
{procedure avaaKoe;      begin//Tarvitaan vain jos kirjoitetaan KOEFN´ään.
   koeFn := 'E:\Projektit\NolaKehi\SRC\Globals\Apuja\_KoeFile.txt';
   AssignFile (koeFile,koeFn);                      // Tarvitaan KoeFN´ään kirjoitukseen:
   if FileExists (koeFn)  then Append (koeFile)     // - avaaKoe -kutsu
                          else Rewrite (koeFile);   // - Writeln(koeFile,'...');
end;                                                // - Flush(koeFile);
                                                    // - CloseFile(koeFile);}
//,,,Kokeiluun: Näyttää filessä Ktlk´n sisällön.,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
procedure ediKoe;      //VAR sc :string;
   procedure ediKtlk;      //& VAR i,j :integer;  sa,su :string;
      function s4 (si :string) :string;      begin //Tekee si :stä 4 mrk pitkän.
         while Length (si)<4  do si := ' ' +si;
         result := si;  end;
   begin//ediKtlk..........
     {for i := 1 to KtlkRivMax  do begin           //&
         su := '';
         for j := 1 to KtlkSarMax  do begin
            sa := Ktlk[i,j];
            if sa<>KtlkArvoTyh
               then su := su +s4(sa) +'  ';  end;//for j
         if su<>''  then begin
            su := fImrkt0 (i,2) +':  ' +su;
            Writeln(koeFile,su);  end;
      end;//for i}
   end;

begin//ediKoe..............................
(*---Vain aRich´iin kirjoittava versio.
   if DetEvFrm.aRich.Lines.Count=1  then begin
      DetEvFrm.aRich.Lines.Clear;
      DetEvFrm.aRich.AddText ('           Col Row  newWidth:<br>');  end;
   DetEvFrm.aRich.Font.Name := 'Courier New';            //<Vaikuttaa vain 1.r:lle ja kun kirjoittaa käsin.
   DetEvFrm.aRich.AddText ('<f n="Courier New">');       //<Pois päältä eli paluu ed:lle:  '</f>'
   sn := (Sender as TStringGridNola).Name;               //<Tämä workki OK.
   sc := (Sender as TStringGridNola).Cells[ACol,ARow];   //<OK, mutta error jää "päälle" eikä päästä katsomaan.
   DetEvFrm.aRich.AddText (fImrkt0 (TotN,2) +'  '+sn +'   ' +fImrkt0 (ACol,2) +' ' +fImrkt0 (ARow,2) +'   ' +
                           fImrkt0 (W,2) + '  ' +sc +'<br>');
  {DetEvFrm.aRich.AddText ('<b>Form:</b> ' +
   IntToStr (Screen.FormCount-1) +'<t><t><t><t><b>CustomForm:</b> '+IntToStr (Screen.CustomFormCount-1) +'<br>');}
   DetEvFrm.Show; ---*)
 //'''Kokeiluun, käyttää aRich´iä.'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

//&   avaaKoe;
   ediKtlk;
 (*sc := (Sender as TStringGridNola).Name;               //<Tämä workki OK.
   sc := fImrkt0 (TotN,2) +'  ' +sc +'   ' +fImrkt0 (ACol,2) +' ' +fImrkt0 (ARow,2) +'   ' +fImrkt0 (W,2);
   sc := sc +'  =' +(Sender as TStringGridNola).Cells[ACol,ARow]; //<Käytä vain WidestConIn.. sisällä.
   if {koeFile.Lines.Count<=1}  TotN=1  then sc := sc +'       =No Grd  Col Row  newWidth  CellTxt';
   Writeln(koeFile,sc);*)

{//&   Writeln(koeFile,'');                                  //<Tyhjä rivi vikan rvn erottamiseksi.
   Flush(koeFile);                                       //<Ensures that the text was actually written to file
   CloseFile(koeFile);}
end;//ediKoe
//'''Kokeiluun: Näyttää filessä Ktlk´n sisällön.''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

procedure TKorjFrm.A_GrdWidestColInRow(Sender: TObject;  ACol,ARow, newWidth: Integer);      VAR W,u,v :integer;
//sa :string;
          {Ruudun rakentamisen idea:
           1. - Tätä kutsuvat kaikki x_Grd´t PRC EsitaTlk´n Celliinsijoituksista, kutsuva tutkitaan Sender´istä.
                kutsuva tutkitaan Sender´istä.
              - TÄSSÄ ColWidths[] := SUUREMPI:  Joko newWidth TAI C_RediX.Width
           2. Ennen PRC EsitaTlk´n Celliinsijoituksia, D_Pan´elin C_Redi0..5´n tekstien sijoituksien jälkeen on
              niiden Width´it asetettu niiden PIXpisimpien tekstirivien mukaan PRC asReditW:ssa.
           3. VIIMEISENÄ VAIHEENA kutsutaan PRC AsetaRuutu, joka tutkii SENDER=C_Grd tapauksen (missä mukana
              D_Pan ja sen C_Redi0..2) ja SÄÄTÄÄ ColWidths[]´in sen mukaan, kumpi on PIXpitempi: ao.Redi vai Col }
   procedure sijCellW (uw :integer);      VAR iCol :integer;      begin //iCol +10.0.1 debuggerille.
      iCol := ACol;

      if Sender=A_Grd                                                   //< = if (Sender as TStringGridNola)=A_Grd
      then  A_Grd.ColWidths[iCol] := uw   else
      if Sender=B_Grd
      then  B_Grd.ColWidths[iCol] := uw
      else  C_Grd.ColWidths[iCol] := uw;  end;

begin//A_GrdWidestColInRow,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   W := newWidth;                                              //<Saataa jäädä voimaan
//TotN := TotN+1;
   if NOT NollaaCellsW and (Sender=C_Grd)  then begin //<NollaaCellsW ASETETTU PÄÄLE PUTSAUKSEN AJAKSI.###########
      if ACol=0                                    //,############################################################
      then begin                                   //,############################################################
           u := C_Redi0.Width;                     //<,,C_RediX.Width := PRC AsetaRuutu :ssa ao.ColWidths[] mukaan
           if u>W  then W := u;   end              //'############################################################
      else if TabCtrl.TabIndex=1                   //'############################################################
      then begin                       //,,Muulloin ei C_Redi.. vaikuta ColWidthsiin.
           if C_Rad.ItemIndex IN [1,2] //,,ColWidts[] -mitta on VERTLINE´n VÄLI eikä sis. GridLineWith´iä
           then case ACol of                    //,,joten C_RediX.Width p.o.= ColWidths[] -mitta
              1 :begin u := C_Redi1.Width;
                       if u>W  then W := u;   end;
              2 :begin u := C_Redi2.Width;
                       v := C_Grd.ColWidths[0] +C_Grd.GridLineWidth +W; //<+10.0.1
                       if u>v  then u := v;
                       if u>W  then W := u;   end;
              3 :begin u := C_Redi3.Width;         //<[3,X]:ään keinotekoinen sijoitus +poisto, jotta eventiHeräisi
                       if u>W  then W := u;   end;
              4 :begin u := C_Redi4.Width;         //,C_Redi5.Width := PRC AsetaRuutu.############################
                       if u>W  then W := u;   end; //Muiden ACol´n leveys Widhest´in mukaan.
(*&1------------------------------------------     //,,901  Korjaa takas ???
           end{case} else        //,,############# C_Rad.ItemIndex=0 #############################################
           if ACol=2  then begin
              u := C_Grd.ColWidths[0] +C_Grd.GridLineWidth +W;
              if u > C_Redi1.Width
                 then C_Redi1.Width := u;   end;
      end                        //''############# TabCtrl.TabIndex=1 ############################################
      else if ACol=1             //,,############# TabCtrl.TabIndex=0,2 ##########################################
      then begin
           if C_Redi1.Width > W
              then W := C_Redi1.Width;  end;
   end;
   sijCellW (W);
//&1-------------------------------------------''*)
//&2-------------------------------------------,,//,,10.0.1  oli pitkään.
           end;{case}                  //C_Redi5.Width := PRC AsetaRuutu.#########################################
      end//''TabCtrl.TabIndex=1
      else if ACol=1                     //,,TabCtrl.TabIndex=0,2
      then begin
           if C_Redi1.Width > W
              then W := C_Redi1.Width;  end;
   end;//if NOT ...
   sijCellW (W);
                        {sa := '';
                        if (Sender=A_Grd) then begin  if (ACol+1 >A_Grd.ColCount)
                           then sa := 'A' +Ints (ACol) +'(' +Ints(A_Grd.ColCount) +')';  end else
                        if (Sender=B_Grd) then begin  if (ACol+1 >B_Grd.ColCount)
                           then sa := 'B' +Ints (BCol) +'(' +Ints(B_Grd.ColCount) +')';  end else
                        if (Sender=C_Grd) then begin  if (ACol+1 >C_Grd.ColCount)
                           then sa := 'C' +Ints (ACol) +'(' +Ints(C_Grd.ColCount) +')';  end else
                                sa := '?' +Ints (ACol);
                        if Caption[1] IN ['0'..'9']
                           then Caption := Caption +sa +' '
                           else Caption :=          sa +' ';}
                        //Caption := IntToStr (TotN) +' w' +IntToStr (W);
//&2-------------------------------------------- *)
end;//A_GrdWidestColInRow
//==================================================================================================

procedure TKorjFrm.mrkHylly (KOSKET :boolean;  JOHTO_n,KHlaji :integer;  VAAKA :boolean;  Col,Row :integer);
         {KOSKET kk=D  FA: kk=2D,   KHlaji   0=Umpilevy  1=Reikälevy  2=puola,   VAAKA FA=pysty
                                    JOHTO_n  10=YKSITTÄISIÄ monijohtimisia   11=Monijohdin NIPUSSA (EI KÄYTÖSSÄ)
                                             20=YKSITTÄISIÄ yksijohtimisia   21=Yksijohtimisia NIPUSSA
          IDEA:  Piirretään suoraan C_Grd:n CANCAS´ille,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
         VAR marg,d,kk,i, ax,ay,x,y,Xo,Yo :integer;

      function UMPI_kh :boolean;      begin
         result := false;
         if KHlaji=0  then result := true;  end;
      function REIKA_kh :boolean;      begin
         result := false;
         if KHlaji=1  then result := true;  end;
      function PUOLA_kh :boolean;      begin
         result := false;
         if KHlaji=2  then result := true;  end;

      function NIPPU_1j :boolean;      begin
         result := false;
         if JOHTO_n=21  then result := true;  end;
      function JOHDIN_1j :boolean;      begin
         result := false;
         if JOHTO_n IN [20,21]  then result := true;  end;

      function fCX (aoSar :integer) :integer;      var CelXY :TRect;      begin //< Palautaa CELLin VAS_X:n
         CelXY := KorjFrm.C_Grd.CellRect (aoSar,0);
         Result := CelXY.Left;                                   //<0: (Left, Top, Right, Bottom: Integer);
      end;//fCX
      function fCY (aoRiv :integer) :integer;      var CelXY :TRect;      begin //< Palautaa CELLin YLÄ_Y:n
         CelXY := KorjFrm.C_Grd.CellRect (0,aoRiv);
         Result := CelXY.Top;
      end;//fCY

     //,KaapHyllyImagen asettamiseksi Celleihin (Nämä FNCt voisivat olla glob. jos tarvis),,,,,,,,,,,,,,,,,,,,
      function fEkvLnW :integer;      VAR w :integer; begin//< Palauttaa vaikuttavan (tod.) GrdLineWidth´in
         w := KorjFrm.C_Grd.GridLineWidth;                 //''Jos NOT goFixedHor/VerLine ->KORJATTAVA KÄSIN 0:ksi.
        {if Col<=C_Grd.FixedCols-1  then
            w := w +1;}
        {if w=1  then                                      //<Vaihtoehto  ''edelliselle.
            w := w +1;}
         result := w;   end;

   function fImX (CelCol,CelRow :integer) :integer;      begin    //< Palautaa Imagen vasYläX:n
      result := fCX (CelCol) +fEkvLnW +6;   end;                  //< +6 irti Cel-Väliviivasta
   function fImY (CelCol,CelRow :integer) :integer;      VAR y :integer;     begin//< Palautaa Imagen vasYläY:n
      y := fCY (CelRow);
    //result := y +fEkvLnW;  end;
      result := y;  end;

begin//mrkHylly,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                                      {Tämä PUTSAISI KOKO C_GRD´N. koklattu.#####################
                                       MoveTo, LineTo Example
   C_Grd.Canvas.FillRect(ClientRect);  first call FillRect to paint the surface of the form.
                                       this removes any previously drawn lines (and anything else!) }

   C_Grd.Canvas.Brush.Color := clInfoBk;//{clRed;//}clWhite;//}
   C_Grd.Canvas.FillRect(C_Grd.CellRect(Col,Row));      //<Putsataan mahd. vanha PIIRROS.!!!!!!!!
   Xo := fImX (Col,Row);                                //<,KUVAkeCellin VasYläKulma ############
   Yo := fImY (Col,Row);
   marg := 1;//Trunc (d/2);
   d := (C_Grd.DefaultRowHeight-2*marg) DIV 3;          //<Reunoille 1xPix + 3 ympyrää
   ax := marg;
   if VAAKA  then ay := d +marg                         //< Rivin keskelle tulevan ympyrän yr.
             else ay := 0 +marg;                        //< Pystyssä olevien ympyröiden ylimmän yr.
                                       {A_Pan.Caption := fImrkt0(Grd.Top,1) +'  h' +fImrkt0(Grd.Height,1) +
                                        '  ax=' +fImrkt0(ax,1) +' ay=' +fImrkt0(ay,1) +', x=' +fImrkt0(x,1) +
                                        '  y=' +fImrkt0(y,1) +' d=' +fImrkt0 (d,1);}
   //================================== Piirretään KAAPELIympyrät ===============================
   x := Xo +ax;  y := Yo +ay;
   if NOT VAAKA  then x := x+marg+1;    //<Ympyrät MARG+1 irti jälempna tehtävästa PYSTYviivasta.

   C_Grd.Canvas.Pen.Width := 1;                         //<Dot ja Dash toimii vain, kun Width=1
   C_Grd.Canvas.Pen.Color := clBlue;//}clRed;//}clWhite;//}

   if JOHDIN_1j                         //,Yksijohtimelliset MAALAATAAN LÄPI JOHDINVÄRILLÄ.######
      then C_Grd.Canvas.Brush.Color := C_Grd.Canvas.Pen.Color //}clRed //}clBlack //}
      else C_Grd.Canvas.Brush.Color := clInfoBk;              //}clRed;//}clWhite;//}
   kk := d;
   for i := 1 to 3  do begin
{     if KOSKET or Odd(i)  then              //<,,ALKUPERÄINEN
      C_Grd.Canvas.Ellipse(x,y, x+d,y+d);            //<x,y=VasY  x+d,y+d =KOKO
{     if KOSKET or Odd(i)  then begin
      C_Grd.Canvas.Pen.Width := 1;
      C_Grd.Canvas.Ellipse(x,y, x+d,y+d);            //<x,y=VasY  x+d,y+d =KOKO
      C_Grd.Canvas.Pen.Width := 2;
      C_Grd.Canvas.Ellipse(x+1,y+1, x+3,y+3);        //<Pisteet keskelle
   end;}

   if KOSKET or Odd(i)  then
      if NIPPU_1j  then C_Grd.Canvas.Ellipse(x,y, x+d+2,y+d+2)
                   else C_Grd.Canvas.Ellipse(x,y, x+d,y+d);//<x,y=VasY  x+d,y+d =KOKO
      if VAAKA  then x := x +kk
                else y := y +kk;
   end;

   C_Grd.Canvas.Brush.Color := clInfoBk;
   C_Grd.Canvas.Pen.Width := 1;                         //<Dot ja Dash toimii vain, kun Width=1
   //================================== Piirretään KAAPELIHYLLYviivat ===========================
   C_Grd.Canvas.Pen.Style := psSolid;
   x := Xo +ax;                         //<,,Origo määräytyi FNCssa fImX(),fImY #################
   if VAAKA  then y := Yo +ay+d+1
             else y := Yo +ay;
   if UMPI_kh                           //<,,Piirretään ehjä viiva <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   then begin
      C_Grd.Canvas.Pen.Width := 2;                       //<Dot ja Dash toimii vain, kun Width=1
      C_Grd.Canvas.Pen.Color := clRed;
      C_Grd.Canvas.MoveTo (x,y);
      kk := 3*d;
      if VAAKA  then x := x+kk
                else y := y+kk;
      C_Grd.Canvas.LineTo (x,y);  end
   else begin
      C_Grd.Canvas.Pen.Width := 1;                       //<Dot ja Dash toimii vain, kun Width=1
      if PUOLA_kh  then begin
         C_Grd.Canvas.Pen.Color := clGreen;
         C_Grd.Canvas.Pen.Width := 2;   end;

      while (x < Xo +C_Grd.DefaultRowHeight) and //<,,Piirretään pisteviiva 2Pix pitkinä pätkinä<<<<
            (y < Yo +C_Grd.DefaultRowHeight)  do begin   //yhden pisteen välein (psDot eiOK =näyttää
            C_Grd.Canvas.MoveTo (x,y);                   //liian harvalta (vain 2 pätkää).
            if VAAKA  then x := x+2
                      else y := y+2;
            C_Grd.Canvas.LineTo (x,y);
            if VAAKA  then x := x+1
                      else y := y+1;  end;

      if PUOLA_kh  then begin                            //<PUOLA_kh :lle piirretään toinen viiva 2 pix viereen
         x := Xo +ax;
         if VAAKA  then y := Yo +ay+d+3
                   else begin
                        y := Yo +ay;
                        x := x-2;  end;
         while (x < Xo +C_Grd.DefaultRowHeight) and //<,,Piirretään pisteviiva 2Pix pitkinä pätkinä<<<<
               (y < Yo +C_Grd.DefaultRowHeight)  do begin   //yhden pisteen välein (psDot eiOK =näyttää
               C_Grd.Canvas.MoveTo (x,y);                   //liian harvalta (vain 2 pätkää).
               if VAAKA  then x := x+2
                         else y := y+2;
               C_Grd.Canvas.LineTo (x,y);
               if VAAKA  then x := x+1
                         else y := y+1;  end;
      end;//}
   end;
end;//mrkHylly
//==================================================================================================

{FrmH=625  PanAH=33  FrmCh=600  TabCh=567  TabT=0
 CPanT=84  CPanH=66  DPanT=150  DPanH=30  CgrT=180  CGr.H=394}
procedure TKorjFrm.AsetaRuutu;      VAR w,u,j,mrg :integer;  sa :string;      begin
   ScrBx.Color := clBtnFace;
   w := fCelXo (A_Grd,A_Grd.ColCount -1);                //<Vikan Col´n oik.reunaan
   u := fCelXo (C_Grd,C_Grd.ColCount -1);                //<Vikan Col´n oik.reunaan
   if u>w  then w := u;                                  //<Leveämpi määrää.!!!!!!!
//TabCtrl.ClientWidth := w;
//ScrBx.HorzScrollBar.Range := w +ScrBx.HorzScrollBar.Size +5;
   mrg := (KorjFrm.Width -KorjFrm.ClientWidth +1) DIV 2; //<Tämän lähemmäksi FORMin reunaa ei pääse  => mrg =2x3
   u := w +2*mrg +48;                                    //< 48 = Grd:n +ScrBx:n ScrollBar´in leveys
         {#######################################################################################################
          ##### GRIDin äärimitat = viivan leveyden alkureunasta vikan rivin/sarakkeen jälkeisen viivan jäl- #####
          ##### kimmäiseen reunaan = Height/Width:   Row(Col)Count x (DefaultRowHeight + GridLineWidth) +2. #####
          #######################################################################################################}
//if u<800  then u := 800;//Korjaa vex?????????. Nyt workkii OK ilman kolvausta 800.

 //if TabCtrl.TabIndex=0   then begin //_Pan ei voida käyttää, nehän muuttuvat seur. muk.        //<+10.0.1
   if TabCtrl.TabIndex>=0  then begin //_Pan ei voida käyttää, nehän muuttuvat seur. muk.        //<+10.0.1
(*µ*) w := fPixPit (A_Pan.Caption,A_Pan.Font);    j := w;              //<,,Etsitään pisin Caption -stringi.
        sa := 'PxA=' +Ints (w);                                        //',,j =Pisin tilantarve tähän asti.
      w := fPixPit (B_Pan.Caption,B_Pan.Font);    if w>j  then j := w;
        sa := sa +' PxB=' +Ints (w);
      w := fPixPit (C_Pan2.Caption,C_Pan2.Font);  if w>j  then j := w;
        sa := sa +' PxC=' +Ints (w);              //##############################################################
                                                  //############### ASETA PitTstPan.VISIBLE := TR. ###############
                                                  //##############################################################
        PitTstPan.Width := j;                                   //<Korjaa vex  => Visible := FA
//      w := C_Redi2.Left +C_Redi2.Width;                       //<TabIndx=0 :lla oikeanpuoleisin Redi.
        w := KPanAlp.Left +KPanAlp.Width;
      if w>j  then j := w;
        sa := sa +' u=' +Ints (u) +' u´=' +Ints (Pyor (u*1.05)) +' j=' +Ints (j) +' AiOR=' +Ints (w);
        //KorjFrm.Caption := sa;
        if sa='#¤%&/()'  then beep;                             //<Ettei "sa not used.." tms.

        j := Pyor (j*1.05);
      if u<j  then u := j; //*µ*) :Grd´t jää vex.
      //u := 800;
   end;

   KorjFrm.ClientWidth := u;
   //ScrBx.HorzScrollBar.Range := w +ScrBx.HorzScrollBar.Size +5;
   //ScrBx.HorzScrollBar.Range := KorjFrm.Width +1;}
ScrBx.HorzScrollBar.Range := 0; //<ScrollBar´ia ei tule, mutta koko ja muutenkin OK
   w := fCelYa (A_Grd,A_Grd.RowCount -1); //<=ALP.
// w := A_Pan.Height +A_Grd.RowCount*(A_Grd.DefaultRowHeight +A_Grd.GridLineWidth) +3; //<Korjaa vex.

   A_Grd.Height := w;
 //w := fCelYa (C_Grd,C_Grd.RowCount -1);
   w := C_Grd.RowCount *(C_Grd.DefaultRowHeight +C_Grd.GridLineWidth) +3;
   if TabCtrl.TabIndex=0
      then C_Grd.Height := w;

   mrg := KorjFrm.ClientHeight -KorjFrm.TabCtrl.Height; //<TabCtrl.Height = TabCtrl.ClientHeight, TODETTU.
   w := mrg +C_Grd.Top +C_Grd.Height +KorjFrm.PanelA.Height -5;
   KorjFrm.ClientHeight := w;
// KorjFrm.ClientHeight := 600;}
//TabCtrl.ClientHeight := C_Grd.Top +C_Grd.Height;
//      ScrBx.VertScrollBar.Range := w -mrg -PanelA.Height;
 //ScrBx.VertScrollBar.Range := TabCtrl.ClientHeight -mrg;
ScrBx.VertScrollBar.Range := 0; //<ScrollBar´ia ei tule, mutta koko ja muutenkin OK

   if TabCtrl.TabIndex=1   //<,,Asennus ILMAAN /a, /uo, /seinä, /kanava,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   then begin
        B_Pan.Height := 0; //<,Kun 0, C_Pan nousee kiinni A_Grd´hen (C_Pan.Align=alTop)
        B_Grd.Height := 0; //'Tästä tiedetään, ettei B_Pan ole käytössä (visible saattaa olla TR).
   end
   else begin              //,,Asennus MAAHAN,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
        B_Pan.Height := 30;
        w := B_Grd.RowCount *(B_Grd.DefaultRowHeight +B_Grd.GridLineWidth) +2;
        B_Grd.Height := w;
        B_Pan.Top := A_Grd.Top +A_Grd.Height;
        B_Grd.Top := B_Pan.Top +B_Pan.Height;
(*µ     C_Grd.Align := alNone; //<,,B_ -osat kiilataan näin edelle. HUOMAA JÄRJESTYS.
        D_Pan.Align := alNone;
        C_Pan.Align := alNone;

        C_Pan.Align := alTop;  //<,,Nyt taas onTop, jolloin nämä tulevat TÄSSÄ JÄRJESTYKSESSÄ B_ -osan JÄLKEEN.
        D_Pan.Align := alTop;
        C_Grd.Align := alTop;   (*µ*)//Kun kommentoitu vex, ei vipata enää.
   end;
                        {,,Ei voida asett.ennen kuin ColWidths[1]...[5] säätyneet.  Perusasetukset tehty
                         PRCasReditW:ssa, joita PRC OnWidesth´issä on tarkistetaa SILLOIN, KUN C_RediX on
                         YKSITTÄISEN SARAKKEEN OTSIKKONA. Näitä käytetään PRC AsetaRuutu:ssa.}
   C_Redi0.Left :=  2;                          //<Jotta alta näkyvä MUSTA Panel2 muodostaisi pystyviivan.
   C_Redi0.Width := C_Grd.ColWidths[0];
   C_Redi1.Left :=  C_Redi0.Left +C_Redi0.Width +C_Grd.GridLineWidth;
   if TabCtrl.TabIndex=1//<,,Asennus ILMAAN,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   then begin                 //,,###############################################################
                              //,,ColWidts[] -mitta on VERTLINE´n VÄLI eikä sis. GridLineWith´iä
                              //,,joten C_RediX.Width p.o.= ColWidts[] -mitta
      if C_Rad.ItemIndex=0    //''###############################################################
      then begin                                            //,,Width sai jo arvot PIXpit mukaan.
         C_Redi1.Width := C_Grd.ColWidths[1] +C_Grd.GridLineWidth +C_Grd.ColWidths[2]; //<2:n sarakkeen yli.!!!
         C_Redi2.Left :=  C_Redi1.Left +C_Redi1.Width +C_Grd.GridLineWidth;
         C_Redi2.Width := D_Pan.Width -C_Redi2.Left -2;   end
      else begin
         C_Redi3.Visible := true;
         C_Redi4.Visible := true;
         C_Redi5.Visible := true;
         C_Redi1.Width := C_Grd.ColWidths[1]; //<Left sijoitettiin jo aikaisemmin, ks. edellä.
         C_Redi2.Left :=  C_Redi1.Left +C_Redi1.Width +C_Grd.GridLineWidth;
         C_Redi3.Left :=  C_Redi2.Left +C_Redi2.Width +C_Grd.GridLineWidth;
         C_Redi4.Left :=  C_Redi3.Left +C_Redi3.Width +C_Grd.GridLineWidth;
         C_Redi5.Left :=  C_Redi4.Left +C_Redi4.Width +C_Grd.GridLineWidth;
         C_Redi5.Width := D_Pan.Width -C_Redi5.Left -2;
      end;
   end
   else if TabCtrl.TabIndex=0 //<,,Asennus MAAHAN,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   then begin
(*µ*) C_Redi1.Width := C_Grd.ColWidths[1];
      C_Redi2.Left :=  C_Redi1.Left +C_Redi1.Width +C_Grd.GridLineWidth;
      C_Redi2.Width := D_Pan.Width -C_Redi2.Left -2;
      C_Redi3.Visible := false;
      C_Redi4.Visible := false;
      C_Redi5.Visible := false; //µ*) :Ei välky vieläkään jos ei komm. vex
   end;

   //===============================================================================================
//KorjFrm.Caption := 'ClW=' +IntToStr (KorjFrm.ClientWidth);

   {A_Pan.Caption := 'R0w=' +fImrkt0 (C_Redi0.Width,1) +'   1=' +fImrkt0 (C_Redi1.Width,1) +'  2=' +fImrkt0 (C_Redi2.Width,1) +'  '+
     'C0w=' +fImrkt0 (C_Grd.ColWidths[0],1) +'  1=' +fImrkt0 (C_Grd.ColWidths[1],1) +'  2=' +fImrkt0 (C_Grd.ColWidths[2],1) +
     '  R2Lft=' +fImrkt0 (C_Redi2.Left,1) +'  w=' +fImrkt0 (C_Redi2.Width,1);}

   {A_Pan.Caption :=
    'Ag_h' +IntToStr(A_Grd.Height) +' ar' +IntToStr(fCelYa (A_Grd,A_Grd.RowCount -1)) +' Cnt' +IntToStr(A_Grd.RowCount) +
   ' Bg_h' +IntToStr(C_Grd.Height) +' ar' +IntToStr(fCelYa (C_Grd,C_Grd.RowCount -1)) +' Cnt' +IntToStr(C_Grd.RowCount);}

{  RichInfo.Text :=
     'C1w=' +fImrkt0 (C_Grd.ColWidths[1],1) +'  Redi1w=' +fImrkt0 (C_Redi1.Width,1);}

{  RichInfo.Text :=
      'FrmCw'+fImrkt0(KorjFrm.ClientWidth,1) +' TabCw' +fImrkt0(TabCtrl.ClientWidth,1) +
      ' PanYw'+fImrkt0(C_Pan.Width,1) +' PanYaW' +fImrkt0(D_Pan.Width,1) +' Grd.w' +fImrkt0(C_Grd.Width,1) +
      ' Vc' +fImrkt0 (fCelXo (C_Grd,C_Grd.ColCount-1),1) +' V-1c' +fImrkt0 (fCelXo (C_Grd,C_Grd.ColCount-2),1) +
      ' Vcw' +fImrkt0 (C_Grd.ColWidths[C_Grd.ColCount-1],1) +'<br>' +
      ' GrdLft' +fImrkt0(C_Grd.Left,1) +' 0cx' +fImrkt0 (fCelXo (C_Grd,0),1) +' 0c' +fImrkt0 (C_Grd.ColWidths[0],1) +
      ' pYtop'+fImrkt0(C_Pan.Top,1)+' pYaTop'+fImrkt0(D_Pan.Top,1)+ ' CgrTop'+fImrkt0(C_Grd.Top,1);  //-}

{  RichInfo.Text :=
        'FrmH=' +fImrkt0(KorjFrm.Height,1)       +'  PanAH=' +fImrkt0(PanelA.Height,1) +
      '  FrmCh='+fImrkt0(KorjFrm.ClientHeight,1) +'  TabCh=' +fImrkt0(TabCtrl.ClientHeight,1) +
      '  TabT=' +fImrkt0(TabCtrl.Top,1) +
      '<br>' +
        'CPanT='+fImrkt0(C_Pan.Top,1)  +'  CPanH='+fImrkt0(C_Pan.Height,1)  +
      '  DPanT='+fImrkt0(D_Pan.Top,1)  +'  DPanH='+fImrkt0(D_Pan.Height,1) +
      '  CgrT=' +fImrkt0(C_Grd.Top,1)  +'  CGr.H='+fImrkt0(C_Grd.Height,1);// +'<br>' }

{  RichInfo.Text :=
       'A_Ptop' +IntToStr(A_Pan.Top) +' A_PH'  +IntToStr(A_Pan.Height) +
      ' A_GrTop'+IntToStr(A_Grd.Top) +' A_GrH' +IntToStr(A_Grd.Height) +
      ' C_Ptop' +IntToStr(C_Pan.Top) +' C_PH'  +IntToStr(C_Pan.Height) +
      ' D_Ptop' +IntToStr(D_Pan.Top) +' D_PH'  +IntToStr(D_Pan.Height) +'<br>' +
       'CgrTop' +IntToStr(C_Grd.Top);//}

   //C_Redi0.Color := clInfoBk;
   //end;//with
end;//AsetaRuutu
//==================================================================================================

procedure TKorjFrm.EsitaTlk;

   procedure Esita;      CONST c=' ';   VAR ai :integer;

      procedure EdiKarvot;      VAR ar,r1,r2,r3 :real;  su :string;
         function  LueKs ({VAR} GrdU :TStringGridNola) :string;      VAR s :string;  ar :real;    begin
            s := TagVex(GrdU.Cells[GrdU.Col,GrdU.Row]); //<.Col ja .Row OSOITTAVAT VALITTUA CELLIÄ jo avattaessa.
            if NOT SokR (s,ar)                          //'######################################################
               then s := '1'                            //'######################################################
               else s := fRmrkt0 (ar,1,-2);
            result := s;
         end;

      begin//EdiKarvot,,,,,,,,,,,,,,,,,,,
         Kedi1.Text := LueKs (A_Grd);
         if KPan3.Visible  //<Korjaa takas.
       //if KPan3.Height>5
         then begin
              Kedi2.Text := LueKs (B_Grd);
              Kedi3.Text := LueKs (C_Grd);  end
         else begin                           //<,,Kun TabCtrl.TabIndex=1.!!!!!!!!!!!!!!!!!!!!!!!!!!
              Kedi2.Text := LueKs (C_Grd);
              Kedi3.Text := '1';  end;

         if SokR (Kedi1.Text,r1) and SokR (Kedi2.Text,r2) and SokR (Kedi3.Text,r3)  then begin
            ar := r1 *r2 *r3;
            su := fRmrkt0 (ar,1,-2);
            KediY.Text := su;  end;
         if Jedi>0                                                       //<,,Edi => Jedi +/-  +10.0.1
            then ar := a_getReaa (222,edv.Sorc[     Jedi ].Josa.Korjaus) //<+10.0.1
            else ar := a_getReaa (223,edv.edka[Abs (Jedi)].Korjaus);

         su := fRmrkt0 (ar,1,-2);
         KediAlp.Text := su;
      end;//EdiKarvot
      //............................................................................................

    (*procedure PutsCells ({VAR+10.0.1} GrdU :TStringGridNola);     VAR i,j :integer;      begin
         for i := 0 to GrdU.ColCount-1  do
         for j := 0 to GrdU.RowCount-1  do begin   //<,,Enää vain tyhjennetään sellit (myös ed. [i,0])
               NollaaCellsW := true;               //<TRUE kun halutaan nollata vanhat ColWidths´it
               GrdU.Cells[i,j] := '';              //'OnWidhest eventissä .. := FALSE.############################
               //GrdU.Cells[i,j] := '.';           //<Tällä SAA NÄKYVIIN "HAAMUsarakkeet"
         end;
         NollaaCellsW := false;                    //<Pois päältä. Varm.vuoksi TÄSSÄKIN.##########################
      end;                                         //''Vain tässä PRC´ssä sekä OnWidhest -eventissä.*)
      procedure PutsCells ({VAR+10.0.1} GrdU :TStringGridNola);     VAR i,j :integer;      begin
         if GrdU.RowCount>0  then          //<+10.0.1  Uusittu
         for i := 0 to GrdU.RowCount-1  do
         if GrdU.ColCount>0  then
         for j := 0 to GrdU.ColCount-1  do begin   //<,,Enää vain tyhjennetään sellit (myös ed. [i,0])
               NollaaCellsW := true;               //<TRUE kun halutaan nollata vanhat ColWidths´it
               GrdU.Cells[j,i] := '';              //'OnWidhest eventissä .. := FALSE.############################
               //GrdU.Cells[i,j] := '.';           //<Tällä SAA NÄKYVIIN "HAAMUsarakkeet"
         end;
         NollaaCellsW := false;                    //<Pois päältä. Varm.vuoksi TÄSSÄKIN.##########################
      end;                                         //''Vain tässä PRC´ssä sekä OnWidhest -eventissä.
      //............................................................................................

      procedure asReditW;      VAR w,u :integer;      begin
                {Nämä ovat perusasetuksia, joita PRC OnWidesth´issä tarkistetaan SILLOIN, KUN C_RediX on YKSITTÄI-
                 SEN SARAKKEEN OTSIKKONA. Näitä käytetään PRC AsetaRuutu:ssa.}
            w := fPixPit (C_Redi0.Lines.Strings[0],C_Redi0.Font); //<,,Tutkitaan kumpi rv pitempi
            u := fPixPit (C_Redi0.Lines.Strings[1],C_Redi0.Font);
            if u>w  then w := u;
         C_Redi0.Width := w+2;

            w := fPixPit (C_Redi1.Lines.Strings[0],C_Redi1.Font); //<,,Tutkitaan kumpi rv pitempi
            u := fPixPit (C_Redi1.Lines.Strings[1],C_Redi1.Font);
            if u>w  then w := u;
         C_Redi1.Width := w+2;
                              //C_Redi2..4.Widt := myös PRC AsetaRuu :ssa,,,,,,,,,,,,,,,,,,,,,,,,,,,
            w := fPixPit (C_Redi2.Lines.Strings[0],C_Redi2.Font); //<,,Tutkitaan kumpi rv pitempi
            u := fPixPit (C_Redi2.Lines.Strings[1],C_Redi2.Font);
            if u>w  then w := u;
         C_Redi2.Width := w+2;

            w := fPixPit (C_Redi3.Lines.Strings[0],C_Redi3.Font);
            u := fPixPit (C_Redi3.Lines.Strings[1],C_Redi3.Font);
            if u>w  then w := u;
         C_Redi3.Width := w+2;

            w := fPixPit (C_Redi4.Lines.Strings[0],C_Redi4.Font);
            u := fPixPit (C_Redi4.Lines.Strings[1],C_Redi4.Font);
            if u>w  then w := u;
         C_Redi4.Width := w+2;

            w := fPixPit (C_Redi5.Lines.Strings[0],C_Redi5.Font);
            u := fPixPit (C_Redi5.Lines.Strings[1],C_Redi5.Font);
            if u>w  then w := u;
         C_Redi5.Width := w+2;
      end;//asReditW
      //............................................................................................

      function fCc (s :string) :string;      begin
         result := c +s +c;  end;
      //............................................................................................
(*9.0.1:
      procedure KsijCelliin (VAR GrdU :TStringGridNola;  EkaTlkRv,VikaTlkRv, {GrdU´n:}EkaGsar,EkaGrv :integer);
            VAR Gsar,Griv,TlkSar,TlkRiv :integer;  ss,sc :string;      begin
         GrdU.ColCount :=  GrdU.FixedCols +1;  //<,ALKUTILANNE:  Count..PoistaaHaamuSarakkeet (turhat CelliViivat)
         GrdU.RowCount :=  GrdU.FixedRows +1;
         Griv := EkaGrv -1;
         for TlkRiv := EkaTlkRv to VikaTlkRv  do begin
            Griv := Griv +1;
            if Griv>GrdU.RowCount-1  then
               GrdU.RowCount := Griv+1;

            TlkSar := 1;  Gsar := 0;             //,Ei taulukon ohi                     ,,TyhjänArvonMrk "-1" lopettaa
            while (TlkRiv<=KtlkRivMax) and (TlkSar<=KtlkSarMax) and (Ktlk[TlkRiv,TlkSar]<>KtlkArvoTyh)  do begin
               sc := '';
               if ((TabCtrl.TabIndex=0) OR (TabCtrl.TabIndex=1) and (C_Rad.ItemIndex IN [1,2]))  and
                  (Gsar=GrdU.FixedCols-1)                       //<'Näistä tiedetään, mitkä sarakkeet keskitetään.
                  then sc := '<center>';

               if Gsar<EkaGsar
               then begin
                  //if Griv>GrdU.FixedRows-1  then begin
                  if Gsar=0
                     then GrdU.Cells[Gsar,Griv] := sc +fCc (IntToStr (Griv)) //<RiviNo. 0 -riville ei aina tule =KÄSIN
                     else GrdU.Cells[Gsar,Griv] := '';  //<Tyhjätään alkupään Cellit aikaisemman käytön merkeistä.
                  Gsar := Gsar +1;   end
               else begin
                  if Gsar>GrdU.ColCount-1  then
                     GrdU.ColCount := Gsar+1;
                  ss := Ktlk[TlkRiv,TlkSar];
                  if (ss='0') or (ss='0,0') or (ss='0,00')
                     then GrdU.Cells[Gsar,Griv] := '<center>- ' //fCc (' -- -- ') //<,fCc lisää ' ' alk +loppuun
                     else GrdU.Cells[Gsar,Griv] := sc +fCc (ss);
                  Gsar := Gsar +1;
                  TlkSar := TlkSar +1;
               end;
            end;//while
         end;//for
      end;//KsijCelliin*)

      //............................................................................................
      //,,Uusittu 10.0.1                   //,EkaTlkRv...VikaTlkRv =Ktlk:sta luettavat tiedot.  Ktlk :oon  sijoi-
                                           //, tettiin näyttökohtaiset rivit ja sarakkeet, ks. 01.INC/teeKtlk.
      procedure KsijCelliin (VAR GrdU :TStringGridNola;  EkaTlkRv,VikaTlkRv, EkaGsar,EkaGrv :integer);
            VAR Gsar,Griv,TlkSar,TlkRiv :integer;  ss,sc :string;      begin //'GrdU´n eka sar ja rivi =0.
         GrdU.ColCount :=  GrdU.FixedCols +1;  //<,ALKUTILANNE:  Count..PoistaaHaamuSarakkeet (turhat CelliViivat)
         GrdU.RowCount :=  GrdU.FixedRows +1;
                             {avaaKoe;
                              sc := (GrdU as TStringGridNola).Name +' EkaTlkRv=' +Ints (EkaTlkRv) +' VtlkRv=' +Ints (VikaTlkRv) +//<Tämä workki OK.
                                    ' EkaGsr=' +Ints (EkaGsar) +' EkaGrv=' +Ints (EkaGrv) +' >>> TbIndx=' +Ints (TabCtrl.TabIndex) +'C_Indx=' +Ints (C_Rad.ItemIndex);
                              Writeln(koeFile,sc);
                              Flush(koeFile);}
               if EkaTlkRv >KtlkRivMax  then EkaTlkRv :=  KtlkRivMax;
               if VikaTlkRv>KtlkRivMax  then VikaTlkRv := KtlkRivMax;
         Griv := EkaGrv -1;
         for TlkRiv := EkaTlkRv to VikaTlkRv  do begin
            Griv := Griv +1;
            if Griv>GrdU.RowCount-1  then
               GrdU.RowCount := Griv+1;

            TlkSar := 0;
            for Gsar := 0 to KtlkSarMax+EkaGsar  do begin      //< +EakGsar jotta ainakin riittävän leveästi.
               if Gsar<EkaGsar                                 //<Ei vielä arvosarakkeissa (ei vielä Ktlk :n osalla)
               then begin                                      // vaan "otsakesarakkeissa".
                  //if Griv>GrdU.FixedRows-1  then begin
                  if Gsar=0
                     then GrdU.Cells[Gsar,Griv] := sc +fCc (IntToStr (Griv)) //<RiviNo. 0 -riville ei aina tule =KÄSIN
                     else GrdU.Cells[Gsar,Griv] := '';  end    //<Tyhjätään alkupään Cellit aikaisemman käytön mer-
               else begin                                      // keistä. Näihin Celleihin tekstit myöhemmin.
                  TlkSar := TlkSar+1;
                  if Ktlk[TlkRiv,TlkSar]=KtlkArvoTyh           //<Alustettu, loppuriville jää "-1" =KtlkArvoTyh.
                  then begin
                   //if Caption='-'  then caption := '-'; //=Koe: Break lopettaa vain tämän sisemmän TLKSAR -for´in.
                     if (TlkRiv<-99) and (TlkSar<-99)  then beep;
                     Break;  end
                  else begin
                     if Gsar>GrdU.ColCount-1  then
                        GrdU.ColCount := Gsar+1;
                     ss := Ktlk[TlkRiv,TlkSar];
                     if (ss='0') or (ss='0,0') or (ss='0,00')
                        then GrdU.Cells[Gsar,Griv] := '<center>- ' //fCc (' -- -- ') //<,fCc lisää ' ' alk +loppuun
                        else GrdU.Cells[Gsar,Griv] := sc +fCc (ss) {+';'}; //<Korjaa ";" vex, oli kokeilua.
                  end;
               end;//if Gsar ..else
                             {sc := Ktlk[TlkRiv,TlkSar+1];
                              if sc='--'  then beep;
                              sc := 'TlkSar=' +Ints (TlkSar) +' TlkRiv=' +Ints (TlkRiv) +' [' +Ints (Gsar) +',' +Ints (Griv) +']=' +GrdU.Cells[Gsar,Griv];
                              Writeln(koeFile,sc); //'-1 koska kasvatettiin silmukan lopussa.}
            end;//for Gsar
            if (TlkRiv<-99) and (TlkSar<-99)  then beep;
         end;//for TlkRiv
                             {Flush(koeFile);
                              CloseFile(koeFile);}
      end;//KsijCelliin

   begin//Esita,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      Screen.Cursor := crHourglass; //Cells[Col,Row]
      C_Redi0.Lines.Clear;
      C_Redi1.Lines.Clear;
      C_Redi2.Lines.Clear;
      C_Redi3.Lines.Clear;
      C_Redi4.Lines.Clear;
      C_Redi5.Lines.Clear;
      PutsCells (A_Grd);
      PutsCells (B_Grd);
      PutsCells (C_Grd);

      KPan1.Color := clBtnFace; //,,+10.0.1:  Siirretty TabIndex=1 :stä.
      KPan3.Color := clBtnFace; //<,Olivat objInsp:ssa ClInfoBk jotta erottuisi muista paneleista/osista.
      Kedi1.Text := '';
      Kedi2.Text := '';
      Kedi3.Text := '';
      KediY.Text := '';
      KediAlp.Text := '';       //<''+10.0.1:  Siirretty TabIndex=1 :stä.
                                //<,,+10.0.1:  Korjaa vex.
      PanelA.Visible := true;   //PanelA.Enabled := true;
      KPan1.Visible :=  true;   //KPan1.Enabled :=  true;
      KPan2.Visible :=  true;   //KPan2.Enabled :=  true;
      KPan3.Visible :=  true;   //KPan3.Enabled :=  true;
      KPanY.Visible :=  true;   //KPanY.Enabled :=  true;
      KPanAlp.Visible := true;  //KPanAlp.Enabled := true;

      if TabCtrl.TabIndex=1 //<,,Asennus ILMAAN /a, /uo, /seinä, /kanava
      then begin
         A_Pan.Color :=  clBlue;
         B_Pan.Color :=  A_Pan.Color;
         C_Rad.Color :=  A_Pan.Color;
         C_Pan2.Color := A_Pan.Color;
       //KPan3.Visible := false;                  //<-10.0.1  Ei vaikutusta
         KPanY.Left :=   KPan2.Left +Kpan2.Width;
         KPanAlp.Left := KPanY.Left +KpanY.Width;

         A_Pan.Caption :=   'Ympäristön LÄMPÖTILAn aiheuttama korjaus:  SFS 6000 v.2007/A.52-14';//A2 52-D1 s.234';
          A_Grd.FixedCols := 2;   A_Grd.FixedRows := 1;
       //,,,,,,,,,,, ( GrdU, 21=EkaTlkRv,23=VikaTlkRv, {Grd´n:}2=EkaGsar,0=EkaGrv :integer);
         KsijCelliin (A_Grd, 12{21},14{23}, 2,0);    //<Sijoittaa KTLK:sta RIVit 1..3 Grd:n SAR 1:stä / RIVeille 0..eteenp.
         A_Grd.Cells[0,0] := fCc ('Rv ');            //<Kirjoittaa KsijCelliin sijoittaman rvNo´n päälle.
         A_Grd.Cells[1,0] := fCc ('Ympäristön lämpötila');
         A_Grd.Cells[1,1] := fCc ('PVC');
         A_Grd.Cells[1,2] := fCc ('PEX/EPR');

{,,Jostain syystä aiheuttaa "Abstract error´in tai Acces violation, ilmeisesti syynä:  Clear ja Add.  +10.0.1:
   mutta hyväksyy sen kun TabIndex=0, ks. jälempnä.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
         ai := C_Rad.ItemIndex;                              //<Talteen, ObjInsp´ssa asetus=0  //<,,+10.0.1
         C_Rad.Visible := false;                             //<Estää OnClick -eventin, OK.
         C_Rad.Items.Clear;
         C_Rad.Columns := 3;                                 //<C_Rad.Items.Count := 3;  Cannot assign to a read-only...

         C_Rad.Items.Add ('Normaalias. (/a,/uo,/s )');
         C_Rad.Items.Add ('Kaap.hyllyas. (/kh) monijohdin');
         C_Rad.Items.Add ('Kaap.hyllyas. (/kh) yksijohdin');
//         C_Rad.Columns := 3;
         if C_Rad.Columns-1 <ai  then ai := C_Rad.Columns-1;
         C_Rad.ItemIndex := ai;                              //<Vanha valinta näkyviin.
         C_Rad.Visible := true;                              //<Esti OnClick -eventin.         //<''+10.0.1
''''''''''''''''''''''''''''''''''''''''''''}

//TStrings.Strings:  MyStrings.Strings[0] := 'This is the first string';
//                   MyStrings[0] := 'This is the first string';
         C_Rad.Items[0] := 'Normaalias. (/a,/uo,/s)';           //< Tai:  C_Rad.Items.Strings[0] :=
         C_Rad.Items[1] := 'Kaap.hyllyas. (/kh) monijohdin';
         if C_Rad.Items.Count<3                                 //<'TabIndex=0 :ssa.
            then C_Rad.Items.Add ( 'Kaap.hyllyas. (/kh) yksijohdin')
            else C_Rad.Items[2] := 'Kaap.hyllyas. (/kh) yksijohdin';
         C_Rad.Columns := 3;                                 //<C_Rad.Items.Count := 3;  Cannot assign to a read-only...
                                                             //'Pitää asettaa jos välillä Count oli pienempi.
//if (C_Rad.Items[0]='') and (C_Rad.Items[1]='') and (C_Rad.Items[2]='')  then beep; 

         if C_Rad.ItemIndex=0
         then begin                                     //,1412/16å4:  Oli "Kohta"
            C_Redi0.Lines.Add ('Rivi ');                //<,,Clear oli alussa. ENNEN Grd:hen sijoitusta jotta OnWidestOsaaVerrata
            C_Redi1.Lines.Add ('Kaapeleiden asettelu'); //<Lopussa ' ' tarpeen, ks. ed. OnWidest -eventti
            C_Redi1.Lines.Add ('(Koskettavat toisiaan)');
            C_Redi2.Lines.Add ({'Yksijohdinvirta}'Piirien tai monijohdin-kaapeleiden lukumäärä.');
            C_Redi2.Lines.Add ('Korjauskertoimet:   Jos väli > 2D  =>  Korj=1'); //FONT_OIKEALLE  FONT_PIENPI
            asReditW;                           //<Asettaa C_ReditX.Width tkestirivien [0] tai [1] PixPituuden mukaan

            C_Pan2.Caption :=  'ASENNUSJÄRJESTELYn aiheuttama korjaus, useita piirejä tai kaapeleita:  '+
                               'SFS 6000 v.2007/A.52-17';//'A2 52-E1 s.235';  +10.0.1 ????????????????????????????????????????
             C_Grd.FixedCols := 3;   C_Grd.FixedRows := 1;
          //,,,,,,,,,,, ( GrdU, 24=EkaTlkRv,29=VikaTlkRv, {Grd´n:}3=EkaGsar,0=EkaGrv :integer);
            KsijCelliin (C_Grd, 15{24},20{29}, 3,0);                             //,,fCc lisää ' ' alk +loppuun
                                                                                     //,,fCc lisää ' ' alk +loppuun
            C_Grd.Cells[1,1] := fCc ('/a, /uo, /kanava');               C_Grd.Cells[2,1] := fCc ('Nipussa');
            C_Grd.Cells[1,2] := fCc ('1 krs= /seinä,/lattia,/KhUmpi');  C_Grd.Cells[2,2] := fCc (' ');
            C_Grd.Cells[1,3] := fCc ('1 krs= /a suor. katon alap.');    C_Grd.Cells[2,3] := fCc (' ');
            C_Grd.Cells[1,4] := fCc ('1 krs /KhReikä,/Kyljellään');     C_Grd.Cells[2,4] := fCc (' ');
          //C_Grd.Cells[1,5] :=      '<center>- " -';                   C_Grd.Cells[2,5] := fCc ('Erillään');
            C_Grd.Cells[1,5] := fCc ('1 krs /KT,/a');                   C_Grd.Cells[2,5] := fCc (' ');
         end//''''''''''C_Rad.ItemIndex=0
         else begin//,,,C_Rad.ItemIndex=1,2
            C_Redi0.Lines.Add ('Rv ');
            C_Redi1.Lines.Add ('KH:n tyyppi '); //<Lopussa ' ' tarpeen, ks. ed. OnWidest -eventti
            C_Redi1.Lines.Add ('ja asento');
            C_Redi2.Lines.Add ('Kaapelien ');
            C_Redi2.Lines.Add ('asennustapa ');
               C_Grd.Cells[3,1] := ' ';         //<Sijoitus " " jotta OnWidhest HERÄISI
            C_Redi3.Lines.Add ('Kuva ');
            C_Redi4.Lines.Add ('Hyllyjen ');
            C_Redi4.Lines.Add ('lukumäärä ');
            asReditW;                        //<Asettaa C_ReditX.Width tkestirivien [0] tai [1] PixPituuden mukaan

            if C_Rad.ItemIndex=1 //<,,KH, MONIjohtimelliset,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
            then begin
               C_Redi5.Lines.Add ('Kaapeleiden lkm hyllyllään ');
               C_Redi5.Lines.Add ('Korjauskerroin');

               C_Pan2.Caption :=  'KAAPELIHYLLYJÄRJESTELYn aiheuttama korjaus,  MONIjohdinkaapelit:  '+
                                  'SFS 6000 v.2007/A.52-20';//'A2 52-E4 s.238';  +10.0.1
                C_Grd.FixedCols := 5;   C_Grd.FixedRows := 1;
             //,,,,,,,,,,, ( GrdU, 30=EkaTlkRv,30=VikaTlkRv, {Grd´n:}5=EkaGsar,0=EkaGrv :integer);
               KsijCelliin (C_Grd, 21{30},21{30}, 5,0);              //<Otsikko
               KsijCelliin (C_Grd, 22{31},37{52}, 4,1);                               //,,fCc lisää ' ' alk +loppuun
               C_Grd.Cells[1, 1] := fCc ('Reikälevy, vaaka');        C_Grd.Cells[2, 1] := fCc ('Koskettavat');
               C_Grd.Cells[1, 2] := fCc ('<center>-- " --');         C_Grd.Cells[2, 2] := fCc ('<center>-- " --');
               C_Grd.Cells[1, 3] := fCc ('<center>-- " --');         C_Grd.Cells[2, 3] := fCc ('<center>-- " --');
               C_Grd.Cells[1, 4] := fCc ('<center>-- " --');         C_Grd.Cells[2, 4] := fCc ('Erillään');
               C_Grd.Cells[1, 5] := fCc ('<center>-- " --');         C_Grd.Cells[2, 5] := fCc ('<center>-- " --');
               C_Grd.Cells[1, 6] := fCc ('<center>-- " --');         C_Grd.Cells[2, 6] := fCc ('<center>-- " --');

               C_Grd.Cells[1, 7] := fCc ('Reikälevy, kyljell.');     C_Grd.Cells[2, 7] := fCc ('Koskettavat');
               C_Grd.Cells[1, 8] := fCc ('<center>-- " --');         C_Grd.Cells[2, 8] := fCc ('<center>-- " --');
               C_Grd.Cells[1, 9] := fCc ('<center>-- " --');         C_Grd.Cells[2, 9] := fCc ('Erillään');
               C_Grd.Cells[1,10] := fCc ('<center>-- " --');         C_Grd.Cells[2,10] := fCc ('<center>-- " --');

               C_Grd.Cells[1,11] := fCc ('Puolarakenne, vaaka');     C_Grd.Cells[2,11] := fCc ('Koskettavat');
               C_Grd.Cells[1,12] := fCc ('<center>-- " --');         C_Grd.Cells[2,12] := fCc ('<center>-- " --');
               C_Grd.Cells[1,13] := fCc ('<center>-- " --');         C_Grd.Cells[2,13] := fCc ('<center>-- " --');
               C_Grd.Cells[1,14] := fCc ('<center>-- " --');         C_Grd.Cells[2,14] := fCc ('Erillään');
               C_Grd.Cells[1,15] := fCc ('<center>-- " --');         C_Grd.Cells[2,15] := fCc ('<center>-- " --');
               C_Grd.Cells[1,16] := fCc ('<center>-- " --');         C_Grd.Cells[2,16] := fCc ('<center>-- " --');
            end        //'''C_Rad.ItemIndex=1
            else begin //<,,C_Rad.ItemIndex=2. KH,YKSIjohtimelliset,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
               C_Redi5.Lines.Add ('3-vaihevirtapiirien lkm hyllyllään ');
               C_Redi5.Lines.Add ('Korjauskerroin');

               C_Pan2.Caption :=  'KAAPELIHYLLYJÄRJESTELYn aiheuttama korjaus,  YKSIjohdinkaapelit:  '+
                                  'SFS 6000 v.2007/A.52-21';//'A2 52-E5 s.239';  +10.0.1
                C_Grd.FixedCols := 5;   C_Grd.FixedRows := 1;
             //,,,,,,,,,,, ( GrdU, 53=EkaTlkRv,53=VikaTlkRv, {Grd´n:}5=EkaGsar,0=EkaGrv :integer);
               KsijCelliin (C_Grd, 38{53},38{53}, 5,0);              //<Otsikko
               KsijCelliin (C_Grd, 39{54},54{75}, 4,1);                               //,,fCc lisää ' ' alk +loppuun
               C_Grd.Cells[1, 1] := fCc ('Reikälevy, vaaka');        C_Grd.Cells[2, 1] := fCc ('Koskettavat');
               C_Grd.Cells[1, 2] := fCc ('<center>-- " --');         C_Grd.Cells[2, 2] := fCc ('<center>-- " --');
               C_Grd.Cells[1, 3] := fCc ('<center>-- " --');         C_Grd.Cells[2, 3] := fCc ('<center>-- " --');

               C_Grd.Cells[1, 4] := fCc ('Reikälevy kyljell.');      C_Grd.Cells[2, 4] := fCc ('Koskettavat');
               C_Grd.Cells[1, 5] := fCc ('<center>-- " --');         C_Grd.Cells[2, 5] := fCc ('<center>-- " --');

               C_Grd.Cells[1, 6] := fCc ('Puola, vaaka');            C_Grd.Cells[2, 6] := fCc ('Koskettavat');
               C_Grd.Cells[1, 7] := fCc ('<center>-- " --');         C_Grd.Cells[2, 7] := fCc ('<center>-- " --');
               C_Grd.Cells[1, 8] := fCc ('<center>-- " --');         C_Grd.Cells[2, 8] := fCc ('<center>-- " --');
                                                            //,,Nipputapaukset,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
               C_Grd.Cells[1, 9] := fCc ('Reikälevy, vaaka');        C_Grd.Cells[2, 9] := fCc ('3:n niput erill.');
               C_Grd.Cells[1,10] := fCc ('<center>-- " --');         C_Grd.Cells[2,10] := fCc ('<center>-- " --');
               C_Grd.Cells[1,11] := fCc ('<center>-- " --');         C_Grd.Cells[2,11] := fCc ('<center>-- " --');

               C_Grd.Cells[1,12] := fCc ('Reikälevy kyljell.');      C_Grd.Cells[2,12] := fCc ('3:n niput erill.');
               C_Grd.Cells[1,13] := fCc ('<center>-- " --');         C_Grd.Cells[2,13] := fCc ('<center>-- " --');

               C_Grd.Cells[1,14] := fCc ('Puola, vaaka');            C_Grd.Cells[2,14] := fCc ('3:n niput erill.');
               C_Grd.Cells[1,15] := fCc ('<center>-- " --');         C_Grd.Cells[2,15] := fCc ('<center>-- " --');
               C_Grd.Cells[1,16] := fCc ('<center>-- " --');         C_Grd.Cells[2,16] := fCc ('<center>-- " --');
            end;
         end;
      end//'''TabIndex=1 =========================================================================================
      else//,,TabIndex=0 =MAAKAAPELIasennukset ===================================================================
      begin
(*µ*)    A_Pan.Color :=  clGreen;
         B_Pan.Color :=  A_Pan.Color;
         C_Rad.Color :=  A_Pan.Color;
         C_Pan2.Color := A_Pan.Color;
       //KPan3.Visible := true;                   //-10.0.1:  Nyt ei enää missään := FA.
         KPanY.Left :=   KPan3.Left +Kpan3.Width;
         KPanAlp.Left := KPanY.Left +KpanY.Width;

         A_Pan.Caption :=   'Maan LÄMPÖTILAn aiheuttama korjaus:  SFS 6000 v.2007/A.52-15';//A2 52-D2 s.234'; +10.0.1
          A_Grd.FixedCols := 2;   A_Grd.FixedRows := 1;
       //,,,,,,,,,,, ( GrdU, 1=EkaTlkRv,3=VikaTlkRv, {Grd´n:}2=EkaGsar,0=EkaGrv :integer);
         KsijCelliin (A_Grd, 1,3, 2,0);      //<Sijoittaa KTLK:sta RIVit 1..3 Grd:n SAR 1:stä / RIVeille 0..eteenp.
         A_Grd.Cells[0,0] := fCc ('Rv ');    //<Kirjoittaa KsijCelliin sijoittaman rvNo´n päälle.
         A_Grd.Cells[1,0] := fCc ('Maan lämpötila °C');
         A_Grd.Cells[1,1] := fCc ('PVC');
         A_Grd.Cells[1,2] := fCc ('PEX/EPR');

         B_Pan.Caption :=   'Maan LÄMPÖRESISTIIVISYYDEN aiheuttama korjaus:  SFS 6000 v.2007/A.52-16';//A2 52-D3 s.237';
          B_Grd.FixedCols := 2;   B_Grd.FixedRows := 1;                                             //'+10.0.1
         KsijCelliin (B_Grd, 4,5, 2,0);      //<Sijoittaa KTLK:sta RIVit 4..5 Grd:n SAR 2:stä / RIVeille 0..eteenp.
         B_Grd.Cells[0,0] := fCc ('Rv ');    //<Kirjoittaa KsijCelliin sijoittaman rvNo´n päälle.
         B_Grd.Cells[1,0] := fCc ('Maan resistiivisyys K m/W');
         B_Grd.Cells[1,1] := fCc ('Korjauskerroin');
//,,OK:
{         C_Rad.Items[0] := 'Asennus suoraan maahan';
         C_Rad.Items[1] := 'Asennus putkessa maahan';//'Monijohdinkaap. putkessa';
       //C_Rad.Items[2] := 'Yksijohdinkaap. putkessa';                                         //<-10.0.1
         C_Rad.Items[2] := '';}

         ai := C_Rad.ItemIndex;                              //<Talteen.                       //<,,+10.0.1
         C_Rad.Visible := false;                             //<Estää OnClick -eventin.
         C_Rad.Items.Clear;
         C_Rad.Columns := 2;
         C_Rad.Items.Add ('Asennus suoraan maahan');         //<,,Tässä ei Clear ja Add aiheuta ongelmia.
         C_Rad.Items.Add ('Asennus putkessa maahan');//'Monijohdinkaap. putkessa';
         if C_Rad.Columns-1 <ai  then ai := C_Rad.Columns-1; //<Ettei yli.
         C_Rad.ItemIndex := ai;                              //<Vanha valinta näkyviin.
         C_Rad.Visible := true;                              //<Esti OnClick -eventin.         //<''+10.0.1}

         if C_Rad.ItemIndex=0
         then begin
            C_Redi0.Lines.Add ('Rv ');   //<,,Clear oli alussa. ENNEN Grd:hen sijoitusta jotta OnWidestOsaaVerrata
           {C_Redi1.Lines.Add ('Virtapiirien '); //<Lopussa ' ' tarpeen, ks. ed. OnWidest -eventti  <,,-10.0.1
            C_Redi1.Lines.Add ('lukumäärä');
            C_Redi2.Lines.Add ('Kaapeleiden asettelu');
            C_Redi2.Lines.Add ('Kaapeleiden VÄLI (pinnasta pintaan) [m]'); }
            C_Redi1.Lines.Add ('KaapeliVÄLI ');                                                //<,,+10.0.1
            C_Redi1.Lines.Add ('[mm]');
            C_Redi2.Lines.Add ('Vierekkäisten 3j-kaapelien '); //<Lopussa ' ' tarpeen, ks. ed. OnWidest -eventti
            C_Redi2.Lines.Add ('tai 1j-ryhmien lukumäärä ');
            asReditW;                        //<Asettaa C_ReditX.Width tkestirivien [0] tai [1] PixPituuden mukaan

           {C_Pan2.Caption :=  'ASENNUSJÄRJESTELYn aiheuttama korjaus,  >1 yksi- tai >1 monijohdinkaapelit:  '+
                               'A2 52-E2 s.236';                                                    -10.0.1}
            C_Pan2.Caption :=  'ASENNUSJÄRJESTELYn aih. korjaus,  yksijohdinryhmä- tai monijohdinkaapelit:  '+
                               'SFS 6000 v.2007/A.52-18';                                       //<'+10.0.1
             C_Grd.FixedCols := 2;   C_Grd.FixedRows := 1;
{§}         KsijCelliin (C_Grd, 6{6},8{10}, 1,1);
            C_Grd.Cells[0,0] := fCc ('0');       //<1.Rv =0 riviNo
           {C_Grd.Cells[2,0] := fCc ('0,0');     C_Grd.Cells[3,0] := fCc ('D');                  <,,-10.0.1
            C_Grd.Cells[4,0] := fCc ('0,125');   C_Grd.Cells[5,0] := fCc ('0,25');
            C_Grd.Cells[6,0] := fCc ('0,5');   end}                                             //,,+10.0.1
            C_Grd.Cells[1,1] := fCc ('0');       //< "0" tulostuu "-" :ksi, joka tässä kolvataan suoraan.
            C_Grd.Cells[2,0] := fCc ('2');       C_Grd.Cells[3,0] := fCc ('3');     C_Grd.Cells[4,0] := fCc ('4');
            C_Grd.Cells[5,0] := fCc ('5');       C_Grd.Cells[6,0] := fCc ('6');     C_Grd.Cells[7,0] := fCc ('8');
            C_Grd.Cells[8,0] := fCc ('10');   end
         else {if C_Rad.ItemIndex=1
         then }begin
{*µ}        C_Redi0.Lines.Add ('Rv ');   //<,,Clear oli alussa. ENNEN Grd:hen sijoitusta jotta OnWidestOsaaVerrata
           {C_Redi1.Lines.Add ('Kaapeleiden '); //<Lopussa ' ' tarpeen, ks. ed. OnWidest -eventti
            C_Redi1.Lines.Add ('lukumäärä');
            C_Redi2.Lines.Add ('Kaapeleiden asettelu');
            C_Redi2.Lines.Add ('Suojaputkien VÄLI (pinnasta pintaan) [m]');}                   //<''-10.0.1
            C_Redi1.Lines.Add ('PutkiVÄLI ');   //<Lopussa ' ' tarpeen, ks. ed. OnWidest -eventti
            C_Redi1.Lines.Add ('[mm]');
            C_Redi2.Lines.Add ('Vierekkäisten putkien ');
            C_Redi2.Lines.Add ('lukumäärä');
            asReditW;                        //<Asettaa C_ReditX.Width tkestirivien [0] tai [1] PixPituuden mukaan

           {C_Pan2.Caption :=  'MONIJOHDINkaapelit yksittäisissä suojaputkissa:  '+
                               'A2 52-E3/A s.237';                                              //<'-10.0.1}
            C_Pan2.Caption :=  'Korjaus, kun kaapelit putkissa maassa:  '+
                               'SFS 6000 v.2007/A.52-19';                                       //<'+10.0.1
{*µ*}       C_Grd.FixedCols := 2;   C_Grd.FixedRows := 1;
{§}         KsijCelliin (C_Grd, 9{11},11{15}, 1,1);
            C_Grd.Cells[0,0] := fCc ('0');     //<1.Rv =0 riviNo
           {C_Grd.Cells[2,0] := fCc ('0,0');   C_Grd.Cells[3,0] := fCc ('0,25');                   <,,-10.0.1
            C_Grd.Cells[4,0] := fCc ('0,5');   C_Grd.Cells[5,0] := fCc ('1,0');   end}            //,,+10.0.1
            C_Grd.Cells[1,1] := fCc ('0');       //< "0" tulostuu "-" :ksi, joka tässä kolvataan suoraan.
            C_Grd.Cells[2,0] := fCc ('1');     C_Grd.Cells[3,0] := fCc ('2');     C_Grd.Cells[4,0] := fCc ('3');
            C_Grd.Cells[5,0] := fCc ('4');     C_Grd.Cells[6,0] := fCc ('5');     C_Grd.Cells[7,0] := fCc ('6');
            C_Grd.Cells[8,0] := fCc ('8');     C_Grd.Cells[9,0] := fCc ('10');
         end;
{        else begin//C_Rad.ItemIndex=2   //<,,-10.0.1 EI OLE ENÄÄ SFS 6000 V.2007:ssä.!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            C_Redi0.Lines.Add ('Rv ');   //<,,Clear oli alussa. ENNEN Grd:hen sijoitusta jotta OnWidestOsaaVerrata
            C_Redi1.Lines.Add ('2 tai 3:n kaapelin');
            C_Redi1.Lines.Add ('1-johdinvirtapiiriLkm '); //<Lopussa ' ' tarpeen, ks. ed. OnWidest -eventti
            C_Redi2.Lines.Add ('Kaapeleiden asettelu');
            C_Redi2.Lines.Add ('Suojaputkien VÄLI (pinnasta pintaan) [m]');
            asReditW;                        //<Asettaa C_ReditX.Width tkestirivien [0] tai [1] PixPituuden mukaan

            C_Pan2.Caption :=  'YKSIJOHDINkaapelit yksittäisissä suojaputkissa:  '+
                               'SFS 6000 v.2007/A.52-17';//'A2 52-E3/B s.237';  +10.0.1
             C_Grd.FixedCols := 2;   C_Grd.FixedRows := 1;
            KsijCelliin (C_Grd, 16,20, 1,1);        //<Yksijohtimista versiota ei ole SFS 6000 v.2007 :ssä enää,
            C_Grd.Cells[0,0] := fCc ('0');          // tämä nyt sama edellä.
            C_Grd.Cells[2,0] := fCc ('0,0');   C_Grd.Cells[3,0] := fCc ('0,25');
            C_Grd.Cells[4,0] := fCc ('0,5');   C_Grd.Cells[5,0] := fCc ('1,0');
         end;} //µ*)
      end;//TabIndex=0
      Screen.Cursor := crDefault;
      EdiKarvot;
   end;//Esita

begin//EsitaTlk,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   Esita;
end;

procedure TKorjFrm.C_GrdAfterPaint(Sender: TObject);      begin
                           {Kutsutaan AfterPaint´issä koska Celleihin tekstien sijoittamistapahtuma käynnistää il-
                            meisesti OnPaint´in jolloin vain tekstit jäävät näkyviin. Vain näin onnistuu, TODETTU.}
   inherited;                   //,,, X,Y...=Sar,Riv
  {mrkHylly (kosketFA,1,vaakaFA, 1,5);
   mrkHylly (kosketTR,0,vaakaTR, 1,6);}

   AsetaRuutu; //<################################################################################################
   //'''''''''''''################################################################################################
   //'''''''''''''################################################################################################
//(*Korjaa takas =kommenttisulut vex.
   if TabCtrl.TabIndex=1  then //<,,Asennus ILMAAN,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   if C_Rad.ItemIndex=1        //A.52-20 (A2 52-E4 s.238)
   then begin           {10,=YKSITTÄISIÄ monijohtimisia   11=Monijohdin NIPUSSA (EI KÄYTÖSSÄ),,,,,,,
                         20,=YKSITTÄISIÄ yksijohtimisia   21=Yksijohtimisia NIPUSSA,,,,,,,,,,,,,,,,,
                           ,0,=Umpilevy  1=Reikälevy  2=puola,   VAAKA FA=pysty(kyljellään), kosketTR/FA
                           , ,       Sar,Riv ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
      mrkHylly (kosketTR,10,1,vaakaTR, 3,1); //<,,Vaaka-asennossa (=normaali),,,,,,,,,,,,,,,,,,,,,,,
      mrkHylly (kosketTR,10,1,vaakaTR, 3,2);
      mrkHylly (kosketTR,10,1,vaakaTR, 3,3);

      mrkHylly (kosketFA,10,1,vaakaTR, 3,4);
      mrkHylly (kosketFA,10,1,vaakaTR, 3,5);
      mrkHylly (kosketFA,10,1,vaakaTR, 3,6);

      mrkHylly (kosketTR,10,1,vaakaFA, 3,7);
      mrkHylly (kosketTR,10,1,vaakaFA, 3,8);

      mrkHylly (kosketFA,10,1,vaakaFA, 3,9);
      mrkHylly (kosketFA,10,1,vaakaTR, 3,10);
                                              //,,Kyljellään,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      mrkHylly (kosketTR,10,2,vaakaTR, 3,11);
      mrkHylly (kosketTR,10,2,vaakaTR, 3,12);
      mrkHylly (kosketTR,10,2,vaakaFA, 3,13);

      mrkHylly (kosketFA,10,2,vaakaFA, 3,14);
      mrkHylly (kosketFA,10,2,vaakaFA, 3,15);
      mrkHylly (kosketFA,10,2,vaakaFA, 3,16);
   end//'''C_Rad.ItemIndex=1
   else if C_Rad.ItemIndex=2   //A.52-21 (A2 52-E5 s.239)
   then begin           {10,=YKSITTÄISIÄ monijohtimisia   11=Monijohdin NIPUSSA (EI KÄYTÖSSÄ),,,,,,,
                         20,=YKSITTÄISIÄ yksijohtimisia   21=Yksijohtimisia NIPUSSA,,,,,,,,,,,,,,,,,
                           ,0,=Umpilevy  1=Reikälevy  2=puola,   VAAKA FA=pysty(kyljellään), kosketTR/FA
                           , ,       Sar,Riv ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,}
      mrkHylly (kosketTR,20,0,vaakaTR, 3,1);  //<,,Vaaka-asennossa (=normaali),,,,,,,,,,,,,,,,,,,,,,
      mrkHylly (kosketTR,20,0,vaakaTR, 3,2);
      mrkHylly (kosketTR,20,0,vaakaTR, 3,3);

      mrkHylly (kosketTR,20,1,vaakaFA, 3,4);
      mrkHylly (kosketTR,20,1,vaakaFA, 3,5);

      mrkHylly (kosketTR,20,2,vaakaTR, 3,6);
      mrkHylly (kosketTR,20,2,vaakaTR, 3,7);
      mrkHylly (kosketTR,20,2,vaakaTR, 3,8);  

      mrkHylly (kosketFA,21,1,vaakaTR, 3,9);
      mrkHylly (kosketFA,21,1,vaakaTR, 3,10);
      mrkHylly (kosketFA,21,1,vaakaTR, 3,11);

      mrkHylly (kosketFA,21,1,vaakaFA, 3,12);
      mrkHylly (kosketFA,21,1,vaakaFA, 3,13);

      mrkHylly (kosketFA,21,2,vaakaTR, 3,14);
      mrkHylly (kosketFA,21,2,vaakaTR, 3,15);
      mrkHylly (kosketFA,21,2,vaakaTR, 3,16);
   end;//*)
end;//C_GrdAfterPaint

procedure TKorjFrm.C_GrdSelectCell(Sender: TObject; ACol, ARow: Integer;  var CanSelect: Boolean);
      VAR sk :string;
   function  ChkOK (VAR GrdU :TStringGridNola;  VAR Sedi :string) :boolean;      VAR s :string;  ar :real;    begin
      result := false;
      Sedi := '';
      s := TagVex(GrdU.Cells[ACol,ARow]);
      if SokR (s,ar)  then begin
         result := true;
         Sedi := fRmrkt0 (ar,1,-2);  end;
   end;
   procedure sijKs (s :string;  EdiOs :integer);      VAR ar,r1,r2,r3 :real;      begin
      case EdiOs of
         1 :Kedi1.Text := s;
         2 :Kedi2.Text := s;
       else if KPan3.Visible              //<Aina  10.0.1
            then Kedi3.Text := s
            else begin
                 Kedi2.Text := s;         //<Kun TabCtrl.TabIndex=1.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                 Kedi3.Text := '1';  end;
      end;
      if SokR (Kedi1.Text,r1) and SokR (Kedi2.Text,r2) and SokR (Kedi3.Text,r3)  then begin
         //(NOT KPan3.Visible  OR  KPan3.Visible and SokR (Kedi3.Text,r3))  then begin
         ar := r1 *r2 *r3;
         s := fRmrkt0 (ar,1,-2);
         KediY.Text := s;  end;

      if Jedi>0                                                       //<,,Edi => Jedi +/-  +10.0.1
         then ar := a_getReaa (225,edv.Sorc[     Jedi ].Josa.Korjaus) //<+10.0.1  Tämä lisäys puuttui ed. 10.0.1:stä.
         else ar := a_getReaa (226,edv.edka[Abs (Jedi)].Korjaus);
      s := fRmrkt0 (ar,1,-2);
      KediAlp.Text := s;
   end;

begin//C_GrdSelectCell,,,,,,,,,,,,,,,,,,,
   inherited;
   if (Sender=A_Grd) and ChkOK (A_Grd,sk)  then sijKs (sk,1)  else
   if (Sender=B_Grd) and ChkOK (B_Grd,sk)  then sijKs (sk,2)  else
   if (Sender=C_Grd) and ChkOK (C_Grd,sk)  then sijKs (sk,3);
end;//C_GrdSelectCell

procedure TKorjFrm.OkBtnClick(Sender: TObject);      VAR s :string;  ar :real;      begin
  inherited;
   s := KediY.Text;
   if NOT SokR (s,ar)
   then begin
       {if MessageDlg ('Korjauskertoimen arvo ei ole kelvollinen. Aikaisemmin verkkolaskennalle annettu '+
                       'arvo palautetaan [ Yes ].', mtWarning, [mbYes, mbNo], 0) = mrYes}
        if InfoDlg ('Korjauskertoimen arvo ei ole kelvollinen. Aikaisemmin verkkolaskennalle annettu '+
                    'arvo palautetaan.',  mtWarning,
                       'Palauta','Peru','','',  '','','','') = 1 //<mbNo muutettu "Peru" :ksi       //<'+6.2.2
           then begin
                KediY.Text := KediAlp.Text; //<Sijoitetaan, jotta ALP-arvo korvaisi "Valintataulukko" -tekstin
                Close;  end;                //'ComBx7.Text´in.
   end
   else Close;
end;//OkBtnClick

procedure TKorjFrm.TabCtrlChange(Sender: TObject);      begin
   inherited;
   EsitaTlk;
end;
procedure TKorjFrm.C_RadClick(Sender: TObject);      begin
   inherited;
   if C_Rad.Visible //<+10.0.1  Asetettu FA siksi aikaa kun Index´iä asetetaan ettei tätä eventiä tapahdu.
      then begin EsitaTlk;
         //if KediY.Text='-+-+'  then beep; //<Korjaa vex.
      end;
end;

procedure TKorjFrm.FormShow(Sender: TObject);      begin//Kutsu:  Syotto.PAS/PRC ComBx1_11Change
   Caption := PROGRAM_VERSIO_STRING +':  Johdon kuormitettavuuden korjauskertoimen käsittely'; //+6.2.10
   SokI (KediY.Text,Jedi);                     //<+10.0.1  Jedi = Edi, mutta mukana +/-. Asetettiin Syotto.PAS:ssa
   EsitaTlk;                                   //                 tämän kutsussa (PRC ComBx1_11Change).
//& if TotN<0  then beep;
if Caption ='"#¤%&/'  then beep;
end;//FormShow

procedure TKorjFrm.SuljeBtnClick(Sender: TObject);      begin
   KediY.Text := KediAlp.Text; //<Sijoitetaan, jotta ALP-arvo korvaisi "Valintataulukko" -tekstin CmBx7 :ssä +5.0.0
   Close;
end;

initialization
//==================================================================================================
(*   VAR PntA,PntB :TPoint;   Suorak :TRect;
C_Grd.Canvas.Brush.Color := clRed;//}clWhite;//}
C_Grd.Canvas.Pen.Color := clRed;//}clWhite;//}
         C_Grd.Canvas.Pen.Width := 3;                         //<Dot ja Dash toimii vain, kun Width=1
         C_Grd.Canvas.Pen.Style := psSolid;
         C_Grd.Canvas.MoveTo (C_Grd.CellRect(ACol,ARow).Left,  C_Grd.CellRect(ACol,ARow).Top);
         C_Grd.Canvas.LineTo (C_Grd.CellRect(ACol,ARow).Right, C_Grd.CellRect(ACol,ARow).Bottom);
  {C_Grd.Canvas.DrawFocusRect(C_Grd.CellRect(ACol,ARow).Left,  C_Grd.CellRect(ACol,ARow).Top,
                              C_Grd.CellRect(ACol,ARow).Right, C_Grd.CellRect(ACol,ARow).Bottom);}
   Suorak := C_Grd.CellRect(ACol,ARow);
   PntA := Suorak.TopLeft;
   PntB := Suorak.BottomRight;
   C_Grd.Canvas.MoveTo (PntA.x,PntA.y);
   C_Grd.Canvas.LineTo (PntB.x,PntA.y);
   C_Grd.Canvas.LineTo (PntB.x,PntB.y);
   C_Grd.Canvas.MoveTo (PntA.x,PntA.y);
{   C_Grd.CellRect(ACol,ARow).Top,
                C_Grd.CellRect(ACol,ARow).Right, C_Grd.CellRect(ACol,ARow).Bottom));}
   C_Grd.Canvas.DrawFocusRect(Suorak);*)
//==================================================================================================
{The following code uses the BITMAPS in an IMAGELIST COMPONENT to draw the contents of each cell in a DRAW GRID.
 It draws a focus rectangle around the cell that has focus.

procedure TForm1.DrawGrid1DrawCell(Sender: TObject; Col, Row: Longint; Rect: TRect; State: TGridDrawState);

var
  index: integer;
begin
  index := Row * DrawGrid1.ColCount + Col;
  with Sender as TDrawGrid do
  begin
    Canvas.Brush.Color := clBackGround;
    Canvas.FillRect(Rect);
    ImageList1.Draw(Canvas,Rect.Left,Rect.Top,index);
    if gdFocused in State then
      Canvas.DrawFocusRect(Rect);
  end;
end;}

(*//C_Grd.Canvas.Brush.Color := clRed;//}clWhite;//}
C_Grd.Canvas.Pen.Color := clRed;//}clWhite;//}
         C_Grd.Canvas.Pen.Width := 3;                         //<Dot ja Dash toimii vain, kun Width=1
         C_Grd.Canvas.Pen.Style := psSolid;
         C_Grd.Canvas.MoveTo (5,5);
         C_Grd.Canvas.LineTo (100,100);
*)

end.
