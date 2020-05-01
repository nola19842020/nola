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

unit KysyUnit; //Kopioitu 1:1  \\VERKKOLEVY\Nola\__projE\ProjektitOhat\OmaBrows¥sta.

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, RichEditNola, System.UITypes;

type
  TKysyFrm = class(TForm)
    PanA: TPanel;
    Btn1: TButton;
    Btn2: TButton;
    Btn3: TButton;
    Btn4: TButton;
    REdi: TRichEditNola;
    procedure Btn1MouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState;  X,Y: Integer);
    procedure Btn1KeyDown(Sender: TObject;  var Key: Word;  Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject;  var Key: Word;  Shift: TShiftState);
    procedure REdiKeyDown(Sender: TObject;  var Key: Word;  Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }//,T‰t‰ kutsutaan.
    procedure {KysyFrm.}Valinta (LOC :integer;  Str :string;  BtnS :array of string;  VAR ValittuBtn :integer);
  end;                        //'LOC: 1=VasYl‰kulma  2=OikYK  3=VasAK  4=OikAK  5=Keskelle.

var
  KysyFrm: TKysyFrm;

implementation

{$R *.DFM}

CONST //btnja=4;
      COLOR_WHITE ='<f n="" s="" c="16777215">';
      CONST CLR_KELT='<f n="" s="" c="65535">';
            CLR_BLU = '<f n="" s="" c="16711680">';
            CLR_GRN = '<f n="" s="" c="32768">';    //<Green.
            CLR_RED = '<f n="" s="" c="255">';
           CLR_GRAY = '<f n="" s="" c="-2147483640">';
   //COLOR_BLACK    = '<f n="" s="" c="0">';

VAR paluu,qLOC :integer;
    btnja :integer;

function pyor (re :real) :integer;      begin
   result := Trunc (0.5 +re);  end;

//,Esim:  KysyFrm.Valinta( 'Haluatko tosiaankin tulostaa?', ['Kyll‰','Ei'], n);
procedure TKysyFrm.Valinta (LOC :integer;  Str :string;  BtnS :array of string;  VAR ValittuBtn :integer);
      VAR n,u,Lft :integer;  keski,puoliBtn :real;      begin   //''''Klikattu Btn.
// Screen.Cursor := crHourGlass	;
//Tics ('KysyFrm.Valinta 0    ');
   qLOC := LOC;                                                             //<Tieto tarvitaan OnShow¥ssa
   if LOC IN [1,3]  then KysyFrm.Left := 0;                                 //<VasYK+AK
   if LOC IN [2,4]  then KysyFrm.Left := Screen.Width -KysyFrm.Width;       //<OikYK+AK
   if LOC IN [1,2]  then KysyFrm.Top := 0;                                  //<YK
   if LOC IN [3,4]  then KysyFrm.Top :=  Screen.Height -KysyFrm.Height -50; //<AK

   Redi.AddText ('</b></f><br>');                                 //<Jos vaikka oli j‰‰nyt p‰‰lle ed. kerralta.
   Redi.Lines.Clear;
   n := 0;
   btnja := Length (BtnS);
   if btnja>4   then begin MessageDlg ('TKysyFrm.Kysy on varautunut vain 4:‰‰n valintapainikkeeseen (nyt yritys: '+
      IntToStr (btnja) +'), ajo keskeytyy!',mtWarning,[mbOK],0);  Abort;  end;
   for u := 0 to btnja-1  do
      if Trim (BtnS[u])<>''  then inc(n);          //<Nyth‰n n = btnja

   keski := KysyFrm.Width/2 -5;
   puoliBtn := Btn1.Width/2;
   case n of                                                            //,,Eri lkm¥lle Btn1.Left (vasemmaisin Btn)
      1 :Lft := pyor (keski                     -puoliBtn);
      2 :Lft := pyor (keski -10                 -Btn1.Width);
      3 :Lft := pyor (keski     -puoliBtn   -20 -Btn1.Width);
   else  Lft := pyor (keski -10 -Btn1.Width -20 -Btn1.Width);  end;

   Btn1.Left := Lft;
   if n>1  then Btn2.Left := Btn1.Left +Btn1.Width +20;
   if n>2  then Btn3.Left := Btn2.Left +Btn1.Width +20;
   if n>3  then Btn4.Left := Btn3.Left +Btn1.Width +20;

                     Btn1.Visible := true;
   if btnja>=2  then Btn2.Visible := true  else Btn2.Visible := false;
   if btnja>=3  then Btn3.Visible := true  else Btn3.Visible := false;
   if btnja>=4  then Btn4.Visible := true  else Btn4.Visible := false;

                      Btn1.Caption := Btns[0];
   if btnja >=2  then Btn2.Caption := Btns[1];
   if btnja >=3  then Btn3.Caption := Btns[2];
   if btnja >=4  then Btn4.Caption := Btns[3];

   //REdi.AddText (IntToStr(clYellow) +'<br>');
   REdi.AddText ('<br>' +Str +'<br>' +{CLR_KELT CLR_BLU CLR_KELT} CLR_GRN +'<b>( Leikkaa ja liimaa teksti‰, jos '+
                 'tarvis ).</b></f>');
   if REdi.Lines.Count >0  then begin
      KysyFrm.Height := pyor (Redi.Lines.Count *14.5) +{30}50; //<T‰m‰ j‰tt‰‰ vaihtelvsti alarakoa, ·13 liian v‰h‰n.
     {Caption := IntToStr (Redi.Lines.Count) +' ·  14';  }end;
   Caption := 'Valitse.';
// Redi.AddText ('</b></f>');                                  //<Jos vaikka oli j‰‰nyt p‰‰lle.
{BtnLbl.Transparent := true;
BtnLbl.Left :=  Btn1.Left;
BtnLbl.Top :=   Btn1.Top;
BtnLbl.Width := Btn1.Width;}

   ShowModal;
 //KysyFrm.Btn1.SetFocus;                                      //<Jotta Enter hoitaisi klikkauksen. Ei ONAA.
   ValittuBtn := paluu;
// Screen.Cursor := crDefault;
//Tics ('KysyFrm.Valinta 9    ');
end;//Valinta

procedure SimulBtn1 (Key :word);      begin //<K‰ytet‰‰n Btn1¥n asemesta: Kun FormKeyDown kutsuu eik‰ TButton.
   if Key IN [13]  then begin
      paluu := 1;                  //'Ei ole muuta keinoa kuin Redi.SetFocus jolloin Enter tuo eventin t‰nne ja
      KysyFrm.Close;  end;         // t‰m‰ saa aikaan Btn1¥t‰ vastaavan eventin.
end;

procedure TKysyFrm.Btn1MouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState;  X,Y: Integer);   begin
   if (Sender as TButton).Name='Btn1'  then {paluu := 1}SimulBtn1(13)  else
   if (Sender as TButton).Name='Btn2'  then paluu := 2  else
   if (Sender as TButton).Name='Btn3'  then paluu := 3  else
   if (Sender as TButton).Name='Btn4'  then paluu := 4  else
                                            paluu := 1;      //<,Kun FormKeyDown kutsuu eik‰ TButton.
   Close;
end;
procedure TKysyFrm.Btn1KeyDown(Sender: TObject;  var Key: Word;  Shift: TShiftState);      begin
   Btn1MouseDown (Sender,mbLeft,[], 2,2);        //<Ei worki Enter, vaatii edelleenkin MouseClik/Down¥in.
end;

procedure TKysyFrm.FormShow(Sender: TObject);      begin
 //Btn1MouseDown (Sender,mbLeft,[], 0,0);   //
 //Btn1.SetFocus;
 //KysyFrm.SetFocus;
   Redi.SetFocus;
  {if REdi.Lines.Count>4  then begin               //<,,+12Â10,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      KysyFrm.Width := 500;  //KysyFrm.Width +50;  >>> Nyt kasvatettu Widthi‰ niin, ettei t‰t‰ en‰‰tarvita.
      if qLOC IN [2,4]  then
         KysyFrm.Left := Screen.Width -500;        //<OikYK+AK
   end;}
   paluu := 0;                                     //<+12Â7: J‰‰ voimaan jos frm suljetaan X-closella.
end;

procedure TKysyFrm.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);      begin
   Btn1MouseDown (Sender,mbLeft,[], 2,2);
   SimulBtn1(Key);
end;

procedure TKysyFrm.REdiKeyDown(Sender: TObject;  var Key: Word;  Shift: TShiftState);      begin
   //Btn1MouseDown ({Sender}(Sender as TButton),mbLeft,[], 2,2);
   SimulBtn1 (Key);
end;

end.
