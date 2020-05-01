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

unit MoDet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, RichEditNola, ExtCtrls, PanelNola, Printers, NolaForms,
  ComboBoxXY;

type
  TMoDetFrm = class(TFormNola)      //DEVELOPER2 6.12.1998
    PanA: TPanelNola;
    SuljeBtn: TButton;
    aRich: TRichEditNola;
    TulostaBtn: TButton;
    EtsiEdi: TComboBoxXY;
    EtsiBtn: TButton;
    InfoLbl: TLabel;
    procedure SuljeBtnClick(Sender: TObject);
    procedure TulostaBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EtsiEdiKeyPress(Sender: TObject; var Key: Char);
    procedure EtsiBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aRichMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MoDetFrm: TMoDetFrm;

  procedure sisVex;
  procedure sisA;
  procedure tab;
//function tab1 :string;
  procedure LF;
  procedure adSt_ (s :string);
  procedure adStF (s :string);
  procedure ad1S_ (s :string);
  procedure ad1SF (s :string);

implementation

uses {Globals, Defs, Unit0, Unit1, Herja1, }Y_, PrintDialogNola{, Odota, Progres}, Moot;

{$R *.DFM}

//==================================================================================================
  procedure sisVex;   begin  MoDetFrm.aRich.AddText ('</in>');   end;
  procedure sisA;
     procedure asetaSis (sisStr :string);      begin
        MoDetFrm.aRich.AddText ('<in f="" l="'+sisStr+'">');  end; //<PIXeleinä
  begin  asetaSis ('10');  end;                //'SIS.. AIHEUTTAA AINA lf, joten ed. ad.. p.o. ad.._
  //------------------------------------------------------------------------------------------------
  procedure tab;      begin  MoDetFrm.aRich.AddText ('<t>');  end;    //<Siirtää seur tabiin<<<<<<<<<
//function tab1 :string;   begin Result := '<t>';  end;              //<- " -
              //,Vika "F" = sis. LineFeed<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  procedure LF;                  begin       MoDetFrm.aRich.AddText ('<br>');  end;
  procedure adSt_ (s :string);   begin       MoDetFrm.aRich.AddText (s);       end; //< String vas.marg.  Ei LF
  procedure adStF (s :string);   begin       MoDetFrm.aRich.AddText (s);  LF;  end; //< String vas.marg.   LF
  procedure ad1S_ (s :string);   begin  tab; MoDetFrm.aRich.AddText (s);       end; //< - " -  1.tabV     Ei LF
  procedure ad1SF (s :string);   begin  tab; MoDetFrm.aRich.AddText (s);  LF;  end; //< - " -   - " -      LF
//==================================================================================================
procedure TMoDetFrm.SuljeBtnClick(Sender: TObject);      begin
  Close;
end;

procedure TMoDetFrm.TulostaBtnClick(Sender: TObject);      begin
  TulostaBtn.Enabled := False;
  Screen.Cursor := crHourGlass;              //<Ilman SCREENiä vipattaa!!!
  IF PrintDlgNola.Execute(modeA2, self)  then begin   //DEVELOPER2 6.12.1998
    try
      aRich.PageRect := Rect (200,0, Printer.PageWidth,Printer.PageHeight);      //=2326,3389 =oaX,Y
      aRich.Print('');                       //Z_A2Frm.Print; = Print;  =Tulostaa VAIN FORMin=POHJAN
    finally
      Screen.Cursor := crDefault;
    end;
  end;
  Screen.Cursor := crDefault;
  TulostaBtn.Enabled := True;
end;

{
procedure TDetEvFrm.FormResize(Sender: TObject);      begin
  inherited;//,Ei auta:  Minimize + Maximize + Minimize + Maximize peräkk. jättää oik.puolen ruudusta plankoksi
   aRich.Repaint;
end;}

procedure TMoDetFrm.FormClose(Sender: TObject; var Action: TCloseAction);      begin
 //DetEvAuki := false;
   aRich.Clear;
   MoFrm.ChkDet.Checked := false;
end;

procedure TMoDetFrm.FormResize(Sender: TObject);      begin//+120.5k
  inherited;
   DetWdth := MoDetFrm.Width;                         //<Muokattuleveys talteen, mihin seur. krlla levitetään
   if IsDebuggerPresent  then
      InfoLbl.Caption := 'Width = ' +Ints(MoDetFrm.Width);
end;

procedure TMoDetFrm.EtsiEdiKeyPress(Sender: TObject; var Key: Char);      begin
  inherited;
   if Ord(key)=13  then etsiStr (MoDetFrm.aRich,  MoDetFrm.EtsiEdi);
end;

procedure TMoDetFrm.EtsiBtnClick(Sender: TObject);      begin
  inherited;
   etsiStr (MoDetFrm.aRich,  MoDetFrm.EtsiEdi);
end;

procedure TMoDetFrm.FormShow(Sender: TObject);      begin
  inherited;
   with EtsiEdi.Items  do begin
      Clear;
      Add ('Rivi ');
      Add ('sallii');
      Add ('Kas');
      Add ('Ksu');
      Add ('Krin');
      Add ('LxSu');
      Add ('sysKerr');
      Add ('tasavirtaKerr');
   end;
 //EtsiEdi.Text := ;
   EtsiEdi.ItemIndex := 0; //<Eka ve näkyviin boxiin
end;

procedure TMoDetFrm.aRichMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);      begin// +4.0.0
   inherited;
   MoDetFrm.SetFocus;
end;

initialization
 //DetEvAuki := false;


end.

