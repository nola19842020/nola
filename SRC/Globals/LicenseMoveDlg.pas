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

unit LicenseMoveDlg;

{
     LicenseMove2
     ============

     DEVELOPER2 1.1.1998 versio 1.0

     Dialogi, jossa syötetään koneentunniste johon lisenssi siirretään.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, LabelNola, ComCtrls, RichEditNola, NolaForms, System.UITypes;

type
  TLicenseMoveFrm = class(TFormNola)
    VaroitusGrb: TGroupBox;
    VaroitusRichEdit: TRichEditNola;
    GroupBox1: TGroupBox;
    OhjeRichEdit: TRichEditNola;
    OkBtn: TButton;
    PeruutaBtn: TButton;
    TunnisteGrb: TGroupBox;
    TunnisteLbl: TLabelNola;
    TunnisteEdit: TEdit;
    procedure TunnisteEditChange(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    tunniste: string;

    function Execute: Word;
  end;

var
  LicenseMoveFrm: TLicenseMoveFrm;

implementation

uses
    licenseFuncs, Globals, Defs, Textbase, TextBaseTexts;

{$R *.DFM}

function  TLicenseMoveFrm.Execute: Word;
begin
     OhjeRichEdit.text     := myTextBase.Get(LICENSE_MOVE_HELP);
     VaroitusRichEdit.text := myTextBase.Get(LICENSE_MOVE_WARNING);
     result := ShowModal;
end;

procedure TLicenseMoveFrm.TunnisteEditChange(Sender: TObject);
begin
     tunnisteEdit.color := clWhite;
     okbtn.enabled      := TRUE;

     tunniste := tunnisteEdit.Text;
end;

procedure TLicenseMoveFrm.OkBtnClick(Sender: TObject);
begin
     Beep;
     if (MessageDlg(myTextBase.Get(LICENSE_MOVE_CONFIRM),
                    mtConfirmation, [mbOK, mbCancel], 0) = mrOk) then
                    ModalResult := mrOk;
end;

end.
