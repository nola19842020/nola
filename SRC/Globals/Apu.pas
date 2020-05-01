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
unit Apu; //Application.CreateForm(TApuFrm, ApuFrm);  Juurri ennen CreateGlobals Nola.DPR´ssä.

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, RichEditNola, Vcl.ExtCtrls;

type
  TApuFrm = class(TForm)
    PanA: TPanel;
    RichN: TRichEditNola;
    SuljeBtn: TButton;
    TallBtn: TButton;
    SaveDlg: TSaveDialog;
    ListBx: TListBox;
    Lbl1: TLabel;
    FntDlg: TFontDialog;
    procedure SuljeBtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);
    procedure TallBtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);
    procedure ListBxMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ApuFrm: TApuFrm;
procedure NaytaCharPixt; //<Nyt kun MessageDlgn fontti on löydetty, tätä ei enää tarvittaisi
                         // (ks. Globals.PAS/PRC EtsiUusimmatAvusteet_jaFNimet/FNC _fMSpixPit).
implementation

{$R *.dfm}

uses Globals;

   function Ints (ii :integer) :string;      begin result := IntToStr(ii);  end;

   {,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,TÄTÄ EI ENÄÄ TARVITA, TULOKSET JO Y.PAS/FNC fMSpixPit´SSA.}
   procedure NaytaCharPixt;      const Maxi=20;   VAR i,w :integer;  ss,ca :string;  Pxar :array [1..maxi] of string;     begin
                                                  //Tämä PRC tutkii jokaisen charin (Ord 32..126) Chr(X) pixPituuden fMSpixPit, joka laskee annetun
    //ApuFrm.Visible := true;                     //mjonoPixPit´uuden halutun fontin mukaan. Nämä on tutkittu ApuFrm´issa siis MS Sans..fontilla.
      ApuFrm.RichN.Lines.Clear;
      ApuFrm.RichN.AddText('RichN.Font.Name=' +ApuFrm.RichN.Font.Name +'<br>');   //RichN.Canvas´ia eioo.
      ApuFrm.RichN.AddText('ApuFrm.Font.Name=' +ApuFrm.Font.Name +'<br>');
      ApuFrm.RichN.AddText('ApuFrm.Canvas.Font.Name=' +ApuFrm.Canvas.Font.Name +'<br>');
      for i := 1 to maxi  do Pxar[i] := ',';        //<Alustus = alkuun"," .
      for i := 32 to 126  do begin
         ss := Chr(i);
         ca := Ints(i);
       //w := 3;                                    //<-120.6
         w := ApuFrm.Canvas.TextWidth(ss);
         Pxar[w] := Pxar[w] +Ints(i) +',';          //<,49,50,60,61, ...alkaaJAloppuu "," :lla, EI TAARVITTAIS ALUSSA,LOPUSSA.
         ApuFrm.RichN.AddText(ss +'=' +Ints(w) +'pix<br>');
      end;//for i
      for i := 1 to maxi  do
         ApuFrm.RichN.AddText(Ints(i) +':  ' +Pxar[i] +'<br>');
    //ApuFrm.Visible := false;
      ApuFrm.Show;//Modal;        //<Jos Visible, ShowModal => Error.
   end;

procedure TApuFrm.FormShow(Sender: TObject);      begin
   RichN.PlainText := true;
end;

procedure TApuFrm.ListBxMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);      VAR Fnt :string;  rv :integer;      begin
   rv := ListBx.ItemIndex;
   if ListBx.ItemIndex>0  then               //<Koska 0 =Otsikko.
      Fnt := Trim(ListBx.Items.Strings[rv]); //<Trim poistaa Itemin alkutyhjät.
   ApuFrm.Font.Name := Fnt;
   ApuFrm.RichN.Font.Name := Fnt;
   ListBx.Visible := false;
   Lbl1.Visible := true;                     //<Tulee ekalla krlla näkyviin.
  {if NOT Lbl1.Visible
   then Lbl1.Visible := true      //<Tulee ekalla krlla näkyviin.
   else begin
        ListBx.Visible := false;
        Lbl1.Visible := false;    //<2.:lla vex.
   end;}
 //ApuFrm.Refresh;                           //<,Ei vaikutusta.
 //ApuFrm.RichN.Refresh;                     //<Muuten ei muutokset näy heti.
end;

procedure TApuFrm.SuljeBtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);      begin
   Close;
end;

procedure TApuFrm.TallBtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);      VAR Path,Fnt :string;
   procedure TeeFontValintaRvt;      begin
      ListBx.Items.Clear;
      ListBx.Items.Add('Valitse Fontti________:');
      ListBx.Items.Add('   Courier New');
      ListBx.Items.Add('   MS Sans Serif');
      ListBx.Items.Add('   MS Serif');
      ListBx.Items.Add('   Tahoma');
      ListBx.Visible := true;
      NaytaCharPixt;
   end;

begin//TallBtnMouseDown...................
   if ssAlt IN Shift
   then begin
      TeeFontValintaRvt;
      Lbl1.Visible := false;         //<2.:lla vex.
     {if NOT Lbl1.Visible
      then Lbl1.Visible := true      //<Tulee ekalla krlla näkyviin.
      else begin
           ListBx.Visible := false;
           Lbl1.Visible := false;    //<2.:lla vex.
      end;}

      if FntDlg.Execute  then begin
         Fnt := FntDlg.Font.Name;
         ApuFrm.Font.Name := Fnt;
         ApuFrm.RichN.Font.Name := Fnt;
         //ListBx.Visible := false;
      end;
   end else
   if ssCtrl IN Shift
   then ListBx.Visible := false
   else begin
      SaveDlg.Options := [ofPathMustExist,ofOldStyleDialog,ofEnableSizing];
      SaveDlg.DefaultExt := 'TXT';
      Path := {gAjoPath;}ExtractFilePath(Application.ExeName);
      SaveDlg.InitialDir := Path;
      SaveDlg.Options := [ofEnableSizing,{ofOldStyleDialog,}ofPathMustExist{,ofOverWritePromt}];
      SaveDlg.FileName := Path+'*.txt';
      if SaveDlg.Execute  then
         RichN.Lines.SaveToFile(SaveDlg.FileName);
   end;
end;

//initialization
end.

