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

unit Z_A2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, NolaForms,
  StdCtrls, ComCtrls, {+}Printers, ExtCtrls, RichEditNola, globals, settings, defs;

type
  TZ_A2Frm = class(TFormNola)
    Z_A2Rich: TRichEditNola;
    Z_A2RichPan: TPanel;
    Z_A2SuljeBtn: TButton;
    Z_A2TulostBtn: TButton;
    procedure Z_A2SuljeBtnClick(Sender: TObject);
    procedure Z_A2TulostBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetTexts; override;
  end;

var
  Z_A2Frm: TZ_A2Frm;

implementation

uses PrintDialogNola;

{$R *.DFM}

{ Asettaa tekstit }
procedure TZ_A2Frm.SetTexts;
begin
end;

procedure TZ_A2Frm.Z_A2SuljeBtnClick(Sender: TObject);
begin
  Close;
end;
procedure TZ_A2Frm.Z_A2TulostBtnClick(Sender: TObject);   //Aivan sama kuin seur PRC
begin                                                       //Ks. Print/TCustomRichEdit.Print!!
                           //Z_A2Rich.ParaGraph.FirstIndent := 10;  //< Sisentää vain 1.rivin
                           //Z_A2Rich.ParaGraph.LeftIndent := 500;  //< Ei worki
                           //Z_A2Rich.Update;                       //< Ei auta <''
                           //Printer.Canvas.MoveTo(1000,0);         //< Ei auta <''
//  Z_A2Rich.PageRect := Rect (200,0, 2000,50000);    //<vyX,Y, oaX,Y  1/20 pixel

  Z_A2TulostBtn.Enabled := False;
  IF PrintDlgNola.Execute(modeA2, self)  then begin //DEVELOPER2 6.12.1998
    Z_A2Rich.PageRect := Rect (200,0, Printer.PageWidth,Printer.PageHeight);  //=2326,3389 =oaX,Y
    Screen.Cursor := crHourGlass;      //<Ilman SCREENiä vipattaa!!!
    Z_A2Rich.Print(PROGRAM_NAME);                //Z_A2Frm.Print; = Print;  =Tulostaa VAIN FORMin=POHJAN
    Screen.Cursor := crDefault;  end;
  Z_A2TulostBtn.Enabled := True;
end;

(*procedure TZ_A2Frm.Z_A2TulostBtnClick(Sender: TObject);(*----------Aivan sama kuin ed PRINT*
  var rivi :integer;   UlosTxt :System.Text; {1 infofile :TextFile;  str :String;}
begin
  Screen.Cursor := crHourGlass;      //<Ilman SCREENiä vipattaa!!!
  try
    AssignPrn(UlosTxt);
    Rewrite(UlosTxt);
                                    {1 AssignFile(infofile,'C:\Projektit\NolaINC\NOLAZ1.RTF');
                                       Reset(infofile);
                                       while not Eof(infofile)  do begin
                                       readln(infofile,str);
                                       writeln(UlosTxt,str); end;}  //<Tulostaa RICH-kooditkin
//Printer.Canvas.Font := Z_A2Rich.Font;  //<Muuttaa, jos luettu RichEdit-tiedostona
  for rivi := 0 to Z_A2Rich.Lines.Count -1 do
    //writeln(UlosTxt, '       '+Z_A2Rich.Lines[rivi]);  //<'Oli OK, mutta sisenn ei
      writeln(UlosTxt, Z_A2Rich.Lines[rivi]);  //<'Oli OK, mutta sisenn ei
  finally
    CloseFile(UlosTxt);
                                    {1 CloseFile(infofile);}
    Screen.Cursor := crDefault;
  end;
end; *-----------------------------------------------------------------------------------*)

(*============= Formilla oli 2 nappia, joilla sai vaihdettua koon 8/10 ps
  procedure TZ_A2Frm.Z_A2Koko8Click(Sender: TObject);   begin
  Z_A2Koko8.Enabled := false;
  Z_A2Koko10.Enabled := false;
  if Z_A2Koko8.Checked then Z_A2Koko10.Checked := false;
  Z_A2Koko8.Enabled := true;
  Z_A2Koko10.Enabled := true;
  //Z_PaaVal.EditRakenne;//(Sender);
  if Z_A2Koko10.Checked  then Z_A2Rich.Font.Size := 10
                         else Z_A2Rich.Font.Size := 8;
//Z_A2Rich.Enabled := false;   //<Päivitystä varten ettei 'vipata'
//Z_A2Rich.Refresh;            //<Päivitetään ruutu koon muutoksen jälkeen
//Z_A2Rich.Enabled := true;
//Z_A2Rich.Visible := false;   //<Päivitystä varten ettei 'vipata'
//Z_A2Rich.Hide;               //<Päivitystä varten ettei 'vipata'
  Z_A2Rich.Update;             //<Päivitetään ruutu fonttikoon muutoksen jälkeen
//Z_A2Rich.Visible := true;    //< Ei auta vipatukseen. <'FRESH TOIMII MYÖS (SAMOIN)
end;*)

(*procedure TZ_A2Frm.Z_A2Koko10Click(Sender: TObject);   begin
  Z_A2Koko8.Enabled := false;
  Z_A2Koko10.Enabled := false;
  if Z_A2Koko10.Checked then Z_A2Koko8.Checked := false;
  Z_A2Koko8.Enabled := true;
  Z_A2Koko10.Enabled := true;
  Z_A2Rich.Refresh;
  if Z_A2Koko10.Checked  then Z_A2Rich.Font.Size := 10
                         else Z_A2Rich.Font.Size := 8;
  Z_A2Rich.Update;             //<Päivitetään ruutu fonttikoon muutoksen jälkeen
end;*)


end.
