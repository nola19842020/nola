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

unit Odota;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, PanelNola;

type
  TOdotaFrm = class(TForm)
    PanelNola1: TPanelNola;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Start;
  end;

var
  OdotaFrm: TOdotaFrm;
//procedure animOdota;

implementation

uses PaaVal, Y_;
{$R *.DFM}

procedure TOdotaFrm.FormShow(Sender: TObject);      begin
  Timer1.Enabled := true;
  Height := 32;
  Top :=  PaaValFrm.Top  + PaaValFrm.PaaValRaa.Top +18;
  Left := PaaValFrm.Left + PaaValFrm.PaaValRaa.Left +PaaValFrm.PaaValRaa.Width - Width;
 {Caption := 't='+fImrkt0 (PaaValFrm.Top+PaaValFrm.NjLaskentaNap.Top,1)+' L='+
              fImrkt0 (PaaValFrm.Left + PaaValFrm.NjLaskentaNap.Left - Width,1);}
end;

procedure TOdotaFrm.FormClose(Sender: TObject; var Action: TCloseAction);      begin
  Timer1.Enabled := false;
end;

procedure TOdotaFrm.Timer1Timer(Sender: TObject);      begin //<,,,Tähän ei tulla ollenkaan ??? 4.0.0
//Y_piipit (3);
//if ActiveControl <> nil then
  with OdotaFrm.PanelNola1  do
  if Font.Size=14  then begin  Font.Size := 12;
                               Caption := '>>>>  ODOTA  <<<<';
                              {OdotaTim.Interval := 200;  }end
                   else begin  Font.Size := 12{14};
                               Caption := '>>>  ODOTA  <<<';
                              {OdotaTim.Interval := 500;  }end;
end;

procedure TOdotaFrm.Start;      begin//OdotaFrm.Close :ssa ENABLED := FA. CLOSE oltava ao.OhaOsan OnFormShow :ssa
   Show;                        //<ENABLED := TR.
 //SetFocus;                    //<Ei vaikutusta:  focus siirtyy siihen lomakkeeseen, jota kutsuttu!
   Update;                      //<Muuten PanelNola1 ei piirry, koska esim. EdvNew :n piirtyminen alkaa, TODETTU.
end;

end.
