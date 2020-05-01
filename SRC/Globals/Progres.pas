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

unit Progres;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, LabelNola, NolaForms;

type
  TProgresFrm = class(TFormNola)
    ProgresBar: TProgressBar;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProgresFrm: TProgresFrm;

  procedure asetaProgres (otsikko :string;  ylarArvo :integer);
  procedure esitaProgres (mrkt :string;  kohta :integer);

implementation

uses
    Globals, Settings, Defs;

{$R *.DFM}


procedure asetaProgres (otsikko :string;  ylarArvo :integer);      begin
   if NOT isDebuggerPresent  then                                  //<+11.0.1: Ettei estä näkymää Call Stack´iin.
   with ProgresFrm  do  begin
      ProgresBar.Min := 0;
      ProgresBar.Max := ylarArvo;
    //ProgrsBar.Position := 0;        //,,Poistettu käytöstä ObjInsp :ssa <<<<<<<<<<<<<<<<<<<<<<<<<<
      Label1.Caption := '';           //<Tyhjennetään, jotta kasvatettaisiin tyhjästä <<<<<<<<<<<<<<
    //Label1.Caption := 'Tekstitietoja muokataan :';  //<Pitää olla ObjInsp :ssa asetettu:
    //Caption := '';                  //<Tyhjennetään, jotta kasvatettaisiin tyhjästä <<<<<<<<<<<<<<
      Caption := otsikko;
      Visible := true;
      Show;
    //Update;
   end;
end;
                                        //,,,,,kohta =Prosessin vaihe välillä 0..ylarajaArvo <<<<<<<
procedure esitaProgres (mrkt :string;  kohta :integer);      VAR str :string;      begin
   with ProgresFrm  do  begin
    //str := Caption;                 //<Tyhjennetään PRC asetaProgrs <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    //Caption := str + mrkt;
      str := Label1.Caption;          //<Tyhjennetään PRC asetaProgrs <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      Label1.Caption := str + mrkt;   //<,,Ei onaa:  Teksti ei muutu =Ekax asetettu jää ############
      //Update;
      Refresh;
      ProgresBar.Position := kohta;  end;
end;

end.
