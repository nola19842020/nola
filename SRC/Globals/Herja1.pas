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

unit Herja1;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, NolaForms;

type
  THerja1Frm = class(TFormNola)
    HerjaOKbtn: TButton;
    Timer1: TTimer;
    Panel1: TPanel;
    Herja: TLabel;
    procedure HerjaOKbtnClick(Sender: TObject);
    procedure HerjaOKbtnKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
//  procedure Timer2Timer(Sender: TObject);
    procedure FormClick(Sender: TObject);
//  procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Herja1Frm: THerja1Frm;
  procedure HerjaInfo (S :String);  {<Itse lisätty: Muut Unitit tunnistavat niissä}
                                    { esitellyn USES Herja1 :n kautta. Todettu}
implementation

uses ZS_, Syotto, Globals, TextBase, Y_;  //<Y_ vain EiOkInfo -kutsun takia

{$R *.DFM}


procedure HerjaInfo (S :String);      begin
//   Beep;   MessageDlg (S, mtInformation, [mbOk], 0);   
   EiOkInfo (S);
{--------------------------------------------- Korvattu väliaikaisesti EiOkInfo -kutsulla ----------
procedure HerjaInfo (S :String);   begin
//Messagebeep (0);           //< =Beep(Freq,Dura); W95:ssä ei käytössä
  Beep;                      //< =Beep(Freq,Dura); W95:ssä ei käytössä. Sama kuin MESSAGEBEEB
//-  SyottoFrm.FormStyle := fsNormal;     //<Takaisin fsNormal :ksi
//-  Herja1Frm.FormStyle := fsStayOnTop;  //<S..Frm on myös fsStayOnTop, joka muutettiin HERJAN ajaksi
  Herja1Frm.Timer1.Enabled := false;
  Herja1Frm.Herja.Caption := S;
  Herja1Frm.Timer1.Interval := 3000;
//Herja1Frm.BringToFront;
  Herja1Frm.Timer1.Enabled := true;
  Herja1Frm.Show{Modal};
end;{----------------------------------------------------------------------------------------------}

procedure sulje;      begin
  Herja1Frm.Close;
  Herja1Frm.FormStyle := fsNormal;     //<Takaisin fsNormal :ksi
  SyottoFrm.FormStyle := fsStayOnTop;  //<S..Frm on myös fsStayOnTop, joka muutettiin HERJAN ajaksi
end;                                   //'fsNormal ja nyt takaisin'''''''''''''''''''''''''''''''''

procedure THerja1Frm.HerjaOKbtnClick(Sender: TObject);      begin
//Herja1Frm.Timer1.Enabled := false;
  sulje;
end;

procedure THerja1Frm.HerjaOKbtnKeyPress(Sender: TObject; var Key: Char);      begin
  //if Key IN [#27,#13]  then Close;  //{<Properties/KeyPreview po TRUE.  #13 workkii ilmankin, OK
  if Key=#27  then sulje;  {<Properties/KeyPreview po TRUE}
end;

procedure THerja1Frm.Timer1Timer(Sender: TObject);      begin //<Interval=4000
  sulje;                                                      //<Sulkee herjaikkunan 4s:n jälkeen
end;
(*---------------------Ääntelee yllättävästi???  Tutki joskus----------------------------------
  ---------------------Olisiko Create(ZS_Frm) :lla osuutta-------------------------------------
procedure THerja1Frm..Timer1Timer(Sender: TObject);  //<Interval=200
begin
  Beep;                                              //<Piippaa 200ms:n välein
end;

procedure THerja1Frm.Timer2Timer(Sender: TObject);   //<Interval=4000
begin
  //THerja1Frm.Timer1Timer.Enabled := false;         //<..method call only allowed for class...
  THerja1Frm.Create(ZS_Frm).Timer1.Enabled := false; //<Aloitti piipityksen, kun HERJAikk aukesi
  Close;                                             //<Sulkee herjaikkunan INTERVAlin jälkeen
end;

procedure THerja1Frm.FormActivate(Sender: TObject);
begin
  THerja1Frm.Create(ZS_Frm).Timer1.Enabled := true;  //<Aloittaa piipityksen, kun HERJAikk aukeaa
end; ------------------------------------------------------------------------------------------*)

procedure THerja1Frm.FormClick(Sender: TObject);
begin
  Close;
end;


end.

