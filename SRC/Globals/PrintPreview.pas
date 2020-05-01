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

unit PrintPreview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ToolWin, ComCtrls, ExtCtrls, NolaForms;

type
  TPrintPreviewDlg = class(TForm)
    PanelY: TPanel;
    PrintImage: TImage;
    PrintZoomCmb: TComboBox;
    ZoomLbl: TLabel;
    ViewZoomLbl: TLabel;
    ToolBar1: TToolBar;
    OkBtn: TButton;
    CancelBtn: TButton;
    ViewZoomCmb: TComboBox;
    PageCmb: TComboBox;
    PageLbl: TLabel;
    PageForwardBtn: TButton;
    PageBackBtn: TButton;
    TotalPageLbl: TLabel;
    procedure ViewZoomCmbChange(Sender: TObject);
    procedure PrintZoomCmbChange(Sender: TObject);
  private
    { Private declarations }
    viewzoom: integer;     { Zoomauskerroin näyttämistä varten }
    printzoom: integer;    { Zoomauskerroin tulostamista varten }
    page: integer;         { Tämänhetkinen sivu }
    form: TFormNola;       { Formi jota tulostetaan }

  public
    { Public declarations }
    function Execute(zoom: integer; form: TFormNola): Boolean;
    function GetZoom: integer;

  end;

var
  PrintPreviewDlg: TPrintPreviewDlg;

implementation

{$R *.DFM}

uses printdialognola, globals, defs, textbase, textbasetexts;

{ **********************************************************
   Avaa dialogin ja suorittaa esikatselun.
   Palauttaa false, jos käyttäjä valitsi 'peruuta'.

   zoom = aloituszoomaus.

   DEVELOPER2 6.12.1998
  ********************************************************** }
function  TPrintPreviewDlg.Execute(zoom: integer; form: TFormNola): Boolean;
begin
     printzoom := zoom;
     page      := 1;
     self.form := form;

     PrintZoomCmb.text   := IntToStr(zoom) + myTextBase.Get(SYMBOLI_PROSENTTI);

     if ShowModal = mrOK then
     begin
        result := True;
     end
     else
         result := False;
end;

{ **********************************************************
   Palauttaa käyttäjän valitseman zoomauksen

   DEVELOPER2 6.12.1998
  ********************************************************** }
function TPrintPreviewDlg.GetZoom(): integer;
begin
     result := printzoom;
end;

{ **********************************************************
   Näytön zoomausta muutettiin

   DEVELOPER2 6.12.1998
  ********************************************************** }
procedure TPrintPreviewDlg.ViewZoomCmbChange(Sender: TObject);
begin
     viewzoom := GetPros(ViewZoomCmb.text, viewzoom);
     viewzoom := CheckPrintZoom(viewzoom);
     PrintZoomCmb.text   := IntToStr(viewzoom) + myTextBase.Get(SYMBOLI_PROSENTTI);
end;

{ **********************************************************
   Tulostuksen zoomausta muutettiin

   DEVELOPER2 6.12.1998
  ********************************************************** }
procedure TPrintPreviewDlg.PrintZoomCmbChange(Sender: TObject);
var
   zoom: integer;
begin
     zoom := GetPros(PrintZoomCmb.text, printzoom);
     zoom := CheckPrintZoom(zoom);
     PrintZoomCmb.text   := IntToStr(zoom) + myTextBase.Get(SYMBOLI_PROSENTTI);

     if (zoom <> printzoom) then
     begin
          form.Print(PrintImage.Canvas);
     end;
end;

end.
