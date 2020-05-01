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

unit NolaCount;

{
     NolaCount
     =========

     DEVELOPER2 1.1.1998 versio 1.0

     Pit‰‰ yll‰ tietoa siit‰ kuinka monta Nola-ohjelmaa on ajossa ja p‰ivitt‰‰
     omaa tunnistetta rekistryss‰.

     Rekistryss‰ on lista prosessitunnisteista ja niiden p‰ivitysajoista.
     Jokainen nola huolehtii oman tunnisteensa p‰ivitt‰misest‰ NOLACOUNT_UPDATE_INTERVAL
     sekunnin v‰lein.Mik‰li p‰ivitys on vanhempi kuin NOLACOUNT_UPDATE_INTERVAL sekuntia,
     merkint‰ poistetaan. Ajossa olevien nolien lukum‰‰r‰ saadaan laskemalla
     voimassa olevien tunnisteiden lukum‰‰r‰ rekistryss‰. T‰m‰ menettely
     on tarpeen, koska muutoin ep‰normaalisti kaatuva nola j‰tt‰isi turhan
     merkinn‰n rekistryyn.
}

interface

uses
    extctrls, settings;

type
    TNolaCount = Class
    private
    { Private declarations }
      timer: TTimer;          // Laittaa uden aikaleiman registryyn
      settings: TRegSettings; //<12.0.05 Oli: TSettings;

      procedure cleanEntries;
      procedure TimerCallBack(Sender: TObject);

    public
    { Public declarations }
      constructor Create;
      destructor Destroy; override;
      procedure addCurrentNola;
      procedure removeCurrentNola;
      function  getNolaCount: integer;
    end;

implementation

uses
    SysUtils, defs, globals, windows, classes;

const
     { Registryn p‰ivityksen intervalli sekunteina }
     NOLACOUNT_UPDATE_INTERVAL = 60;

constructor TNolaCount.Create;
begin
     inherited Create;
     settings := TRegSettings.create;
     addCurrentNola;
end;

{ Tuhotaan olio }
destructor TNolaCount.Destroy;
begin
     removeCurrentNola;
     settings.free;
     inherited Destroy;
end;

{ Laittaa registryyn merkinn‰n ajettavasta nolasta.
  Merkint‰‰n laitetaan prosessin tunniste ja p‰iv‰ys.
  Mik‰li samalla prosessi tunnisteella on edellinen
  merkint‰, vanha tuhoutuu }
procedure TNolaCount.addCurrentNola;
begin
     cleanEntries;

     settings.setDateTimeValue(SETTINGS_NOLA_COUNT, IntToStr(GetCurrentProcessId), now);

     if (timer = nil) then
     begin
          timer :=          TTimer.Create(nil);
          timer.enabled :=  true;
          timer.Interval := NOLACOUNT_UPDATE_INTERVAL * 1000;
          timer.OnTimer :=  TimerCallBack;
     end;
end;

{ Poistaa regiestryst‰ ajettavan nolan prosessi tunnisteella
  varustetun merkinn‰n }
procedure TNolaCount.removeCurrentNola;
begin
     if (timer <> nil) then
     begin
          timer.Enabled := false;
          timer.free;
          timer :=         nil;
     end;

     settings.removeKey(SETTINGS_NOLA_COUNT, IntToStr(GetCurrentProcessId));

     cleanEntries;
end;

{ Poistaa vanhentuneet merkinn‰t registryst‰ }
procedure TNolaCount.cleanEntries;
var
   nolat: TStringList;
   curr:  TDateTime;
   nola:  TDateTime;
   index: integer;
begin
     nolat := TStringList.create();

     // Haetaan kaikki nolat
     settings.getKeys(SETTINGS_NOLA_COUNT, nolat);

     // lasketaan varhaisin p‰ivityshetki
     curr := now - (2 * NOLACOUNT_UPDATE_INTERVAL) / (24 * 60 * 60);

     for index := 0 to nolat.Count - 1 do
     begin
         // luetaan nolan p‰ivityshetki
         nola := settings.getDateTimeValue(SETTINGS_NOLA_COUNT, nolat.Strings[index]);

         // Katsotaan onko p‰ivityshetki annetuissa rajoissa
         if (nola < curr) or (nola > now) then
         begin
              // Poistetaan turhat
              settings.removeKey(SETTINGS_NOLA_COUNT, nolat.Strings[index]);
         end;
     end;

     nolat.free;
end;

{ Palauttaaa aktiivisten nola merkintˆjen lukum‰‰r‰n registryss‰ }
function TNolaCount.getNolaCount;
var
   nolat: TStringList;
begin
     cleanEntries;
     nolat := TStringList.create;
     settings.getKeys(SETTINGS_NOLA_COUNT, nolat);
     result := nolat.count;
     nolat.free;
end;

{ Timer kutsuu t‰t‰ funktiota }
procedure TNolaCount.TimerCallBack(Sender: TObject);
begin
     addCurrentNola;
end;

end.
