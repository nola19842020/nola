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

unit TilLom;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, RichEditNola, ExtCtrls, PanelNola, {+}Printers,
  globals, settings, defs, NolaForms;

type
  TTilLomFrm = class(TFormNola) //DEVELOPER2 6.12.1998
    PanelA: TPanelNola;
    aRich: TRichEditNola;
    SuljeBtn: TButton;
    TulostaBtn: TButton;
    TalletaBtn: TButton;
    HaeUusiBtn: TButton;
    LueBtn: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure SuljeBtnClick(Sender: TObject);
    procedure TulostaBtnClick(Sender: TObject);
    procedure TalletaBtnClick(Sender: TObject);
    procedure LueBtnClick(Sender: TObject);
    procedure HaeUusiBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TilLomFrm: TTilLomFrm;

implementation

uses PrintDialogNola, Y_{, FileCtrl}{Vain Tal.. takia};

{$R *.DFM}

var installDir,LomFilen :string;

procedure FrmOtsikko;      begin
   TilLomFrm.Caption := 'Täytä tiedot ja tulosta postitettavaksi tai faksattavaksi.  : '+LomFilen;  end;

procedure HaePohja (fileNimi :string);      begin
//try Z_A2Frm.Z_A2Rich.Lines.LoadFromFile('C:\Projektit\NolaINC\NOLAZ2.RTF');
//try Z_A2Frm.Z_A2Rich.Lines.LoadFromFile(installDir + fileName);
  try //TilLomFrm.aRich.Clear;
      TilLomFrm.aRich.Lines.LoadFromFile (fileNimi);
                   //Z_A2Frm.Z_A2Rich.Font.Size := 10;    //<Ei muuta kokoa, joka asetettu WP:ssä
      TilLomFrm.aRich.Refresh;
    //TilLomFrm.Show;
    //TilLomFrm.aRich.Show;
      TilLomFrm.aRich.SetFocus;
      FrmOtsikko;
  finally //Screen.Cursor := crDefault;
  end;
end;//HaePohja;

procedure HaeVakio;      begin;
   HaePohja (installDir + 'Config\NolaTil.RTF');
end;

procedure TTilLomFrm.FormShow(Sender: TObject);      begin
  WindowState := wsNormal;  //wsNormal, non-minimized, non-maximized state
  {DEVELOPER2 BEGIN A2:sta DEVELOPER1}
  installDir := myRegSettings.GetStringValue(SETTINGS_USED, PROGRAM_DIR_ID);
//fileName   := myRegSettings.GetStringValue(SETTINGS_USED, NOLAZ_A2_MAARAYKSET_FILE_ID);
  {DEVELOPER2 END}
   HaeVakio;
end;

procedure TTilLomFrm.SuljeBtnClick(Sender: TObject);      begin
  WindowState := wsNormal;
  Close;
end;

procedure TTilLomFrm.TulostaBtnClick(Sender: TObject);      begin
  TulostaBtn.Enabled := False;
  IF PrintDlgNola.Execute(modeA2, self)  then begin //DEVELOPER2 6.12.1998
    aRich.PageRect := Rect (200,0, Printer.PageWidth,Printer.PageHeight);  //=2326,3389 =oaX,Y
    Screen.Cursor := crHourGlass;      //<Ilman SCREENiä vipattaa!!!
    aRich.Print(PROGRAM_NAME);                //Z_A2Frm.Print; = Print;  =Tulostaa VAIN FORMin=POHJAN
    Screen.Cursor := crDefault;  end;
  TulostaBtn.Enabled := True;
end;

procedure TTilLomFrm.LueBtnClick(Sender: TObject);      begin
  OpenDialog1.Options := [ofHideReadOnly,ofOverwritePrompt,ofPathMustExist];
//teePolkuDir (MoFilen);
//OpenDialog1.Filename := MoFilen;
  OpenDialog1.Filter := 'Tilauslomaketiedostot (*.LOM)|*.LOM|Käyttäjän omat tiedostot (*.*)|*.*';
  if OpenDialog1.Execute  then begin
     if not xFileExists(OpenDialog1.Filename)
     then EiOKinfo ('Tiedostoa ei ole!')
     else begin
          LomFilen := OpenDialog1.Filename;                  //<FileName palauttaa Full Path #######
          HaePohja (LomFilen);  end;
  end;
end;

procedure TTilLomFrm.TalletaBtnClick(Sender: TObject);      var filen :string;   begin
   {filen := installDir + 'Config';
       if DirectoryExists (filen )  then EiOKinfo ('1 Polku OK: '+filen)
                                    else EiOKinfo ('1 Polku EiOK: '+filen);}
    filen := installDir + 'Config\Tilaus-1.LOM';
    teePolkuDir (filen);
  //EiOKinfo ('Polku tehty:  '+filen);
    SaveDialog1.Filename := filen;
    SaveDialog1.Filter := 'Tilauslomaketiedostot (*.LOM)|*.LOM|Käyttäjän omat tiedostot (*.*)|*.*';
    SaveDialog1.Options := [ofHideReadOnly,ofOverwritePrompt,ofPathMustExist,ofReadOnly];
    if SaveDialog1.Execute  then                                          //'Ei voi TALLETTAA nimellä FILEN ##
    begin                                                                 //'EI WORKI'''''''''''''''''''''''''
      LomFilen := SaveDialog1.Filename;                      //<FileName palauttaa Full Path #######
      aRich.Lines.SaveToFile (LomFilen);
      if NOT xFileExists(SaveDialog1.Filename)
         then EiOKinfo ('Talletus ei onnistunut: '+SaveDialog1.Filename);
     {if DirectoryExists(installDir + '\Config')  then EiOKinfo ('2 Polku OK')
                                                  else EiOKinfo ('2 Polku EiOK');}
    end;// else EiOKinfo ('2 Talletus ei onnistunut!'); //<Tulee näkyviin CANCEL -painikkeen jälkeen
  //EiOKinfo ('PRC loppu');
    FrmOtsikko;
end;

procedure TTilLomFrm.HaeUusiBtnClick(Sender: TObject);      begin
   HaeVakio;
end;

initialization

end.
