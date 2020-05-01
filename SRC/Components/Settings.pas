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

unit Settings;

{
     Settings
     ========

     DEVELOPER2 15.5.1997 versio 1.0

     Yll‰pit‰‰ tietoa asetuksista.
     Voidaan asettaa asetuksen arvo ja kysy‰ sit‰.
     Voidaan kopioida domainin arvot toiseen.

     Domain - mink‰ tyyppinen asetus on kyseess‰:
              SETTINGS_USED          = k‰ytˆss‰ oleva asetus
              SETTINGS_DEFAULT       = oletusarvot
              SETTINGS_NOLA_COUNT    = k‰ynniss‰ olevien nolien laskuri

     Key    - asetuksen nimi
     Value  - asetuksen arvo


     Esim.
          SetIntegerValue(SETTINGS_USED, 'Ikkunan koko', 100);
             asettaa ikkunan kooksi 100

          SetIntegerValue(SETTINGS_DEFAULT, 'Ikkunan koko', 200);
             asettaa ikkunan OLETUS kooksi 200

          GetIntegerValue(SETTINGS_USED, 'Ikkunan koko')
             palauttaa ikkunan viimeksi asetetun koon

          CopyDomain(SETTINGS_DEFAULT, SETTINGS_USED)
             asettaa k‰ytetyt asetukset samoiksi kuin defaultit asetukset


     K‰ytt‰‰ NT/95 registry-menetelm‰‰.
}

interface

uses {Defs,} registry, stdctrls, SysUtils, classes, Windows;

type
    // DEVELOPER2 26.2.2012. Siirretty Globals\defs.pas tiedostosta t‰nne, jotta
    // komponentit eiv‰t riippuisi Nolasta.
    { Tyypit, joita asetuksiin voidaan tallanetaa }
     SETTINGS_TYPE = (
                        SETTINGS_TYPE_INTEGER,
                        SETTINGS_TYPE_STRING,
                        SETTINGS_TYPE_BOOLEAN,
                        SETTINGS_TYPE_CURRENCY,
                        SETTINGS_TYPE_DOUBLE,
                        SETTINGS_TYPE_DATETIME,
                        SETTINGS_TYPE_SYSTEMTIME
                      );

  TypeInfo = record
        SelectedType:    SETTINGS_TYPE;  { Valittu tyyppi }
        Result      :    Boolean;        { Kyselyn tulos }
        BooleanValue:    Boolean;
        StringValue:     string;
        CurrencyValue:   Currency;
        IntegerValue:    integer;
        DateTimeValue:   TDateTime;
        SystemTimeValue: TSystemTime;
        DoubleValue:     Double;
  end;

  TRegSettings = Class(TRegistry)  //+12.0.05 Oli: TSettings
  private
    { Private declarations }

    function GetValueFromDataBase(Domain: string; Key: string; Cont: TypeInfo): TypeInfo;
    function SetValueToDataBase(Domain: string; Key: string; Cont: TypeInfo): Boolean;
    function GotoDomain(Domain: string; Create: Boolean): Boolean;

  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;

    {
     Tyhjent‰‰ Domainin asetukset . Esim. SETTINGS_DEFAULTS
     Poistaa kaikki entries.
    }
    procedure ClearDomain(Domain: string);

    { Poistaa annetun avaimen annetusta domainista }
    procedure RemoveKey(Domain: string; key: string);

    { Kopioi Domainin toiseen. Voidaan asettaa oletusasetukset k‰ytetyiksi. }
    function CopyDomain(sourceDomain: string; destDomain: string):  Boolean;

    { Hakee annetun domainin avamet }
    procedure getKeys(domain: string; var keys: TStringList );

    { Asettaa oletusarvot, jotka on m‰‰ritelty Definitions-tiedostossa
      automaattisesti asetettaviksi. }
    procedure SetDefaults(var Defaults: array of string);

    { Funktio kertoo lˆytyykˆ ko. akey annetusta domainista }
    function IsKey(Domain: string; Key: string): Boolean;

    { Palauttaa 'Key'-asetuksen arvon }
    function GetStringValue    (Domain: string; Key: string): String;
    function GetBooleanValue   (Domain: string; Key: string): Boolean;
    function GetCurrencyValue  (Domain: string; Key: string): Currency;
    function GetIntegerValue   (Domain: string; Key: string): Integer;
    function GetDoubleValue    (Domain: string; Key: string): Double;
    function GetDateTimeValue  (Domain: string; Key: string): TDateTime;
    function GetSystemTimeValue(Domain: string; Key: string): TSystemTime;

    { Asettaa 'Key'-asetuksen arvon }
    function SetStringValue    (Domain: string; Key: string; Value: string): Boolean;
    function SetBooleanValue   (Domain: string; Key: string; Value: Boolean): Boolean;
    function SetCurrencyValue  (Domain: string; Key: string; Value: Currency): Boolean;
    function SetIntegerValue   (Domain: string; Key: string; Value: Integer): Boolean;
    function SetDoubleValue    (Domain: string; Key: string; Value: Double): Boolean;
    function SetDateTimeValue  (Domain: string; Key: string; Value: TDateTime): Boolean;
    function SetSystemTimeValue(Domain: string; Key: string; Value: TSystemTime): Boolean;

    { Asettaa 'Value'-argumentiksi arvon SETTINGS_USED-domainin arvo.
      Mik‰li SETTINGS_USED -domainissa ei ole ko. avainta, otetaan arvo
      SETTINGS_DEFAULT -domanista ja asetaan sama arvo SETTINGS_USED-domainiin.
      Mik‰li SETTINGS_DEFAULT -domaissa ei ole ko. avainta, otetaan argumentin
      'Value' arvo ja tallennetaan SETTINGS_DEFAULT ja SETTINGS_USED -domainiin.

      N‰ill‰ voidaan v‰hentt‰‰ koodin m‰‰r‰‰ ja automatisoida oletusarvojen p‰ivityst‰. }


    function AutoGetStringValue    (Key: string; Value: string): string;
    function AutoGetBooleanValue   (Key: string; Value: Boolean): Boolean;
    function AutoGetCurrencyValue  (Key: string; Value: Currency): Currency;
    function AutoGetIntegerValue   (Key: string; Value: Integer): Integer;
    function AutoGetDoubleValue    (Key: string; Value: Double): Double;
    function AutoGetDateTimeValue  (Key: string; Value: TDateTime): TDateTime;
    function AutoGetSystemTimeValue(Key: string; Value: TSystemTime): TSystemTime;
  end;

const
    // DEVELOPER2 26.2.2012. Siirretty Globals\defs.pas tiedostosta t‰nne, jotta
    // komponentit eiv‰t riippuisi Nolasta.
     { Asetusten vakioita }
     SETTINGS_USED                  = 'Settings';
     SETTINGS_DEFAULT               = 'Settings - default';
     SETTINGS_NOLA_COUNT            = 'Active Nola-programs';
     SETTINGS_SOFTWARE              = 'Software';
     SETTINGS_ROOT                  = 'Nola';
     SETTINGS_TYPE_INTEGER_CHAR     = 'I';
     SETTINGS_TYPE_STRING_CHAR      = 'S';
     SETTINGS_TYPE_BOOLEAN_CHAR     = 'B';
     SETTINGS_TYPE_CURRENCY_CHAR    = 'C';
     SETTINGS_TYPE_DOUBLE_CHAR      = 'D';
     SETTINGS_TYPE_DATETIME_CHAR    = 'A';

     SETTINGS_TYPE_BOOLEAN_FALSE    = 'F';
     SETTINGS_TYPE_BOOLEAN_TRUE     = 'T';

     SETTINGS_DEFAULTS_COUNT        = 18;  { Kuinka monta alustusarvoa asetetaan }//< 16=>17 2.0.7  18 6.0.2

var
   emptySystemTime: TSystemTime = ();


implementation

{uses
    Globals;}

{ Alustetaan olio }
constructor TRegSettings.Create;
begin
     inherited Create;
   // DEVELOPER2 2.3.2012. Tallennetaan asetukset kohtaisuuden sijaan k‰ytt‰j‰kohtaisesti,
   // koska normaalik‰ytt‰j‰ll‰ on oikeudet muuttaa omia asetuksiaan (HKEY_CURRENT_USER) muttei
   // v‰ltt‰m‰tt‰ konekohtaisia asetuksia (HKEY_LOCAL_MACHINE).
   {myRegSettings.{Registry.}RootKey := HKEY_CURRENT_USER; //<11.0.0a
end;

{ Tuhotaan olio }
destructor TRegSettings.Destroy;
begin
     inherited Destroy;
end;

{ ---------- PRIVATE -----------}
{ Hakee annetun asetuksen varsinaisesta tietokannasta }
function TRegSettings.SetValueToDataBase(Domain: string; Key: string;
                                      Cont: TypeInfo): Boolean;
begin
     SetValueToDataBase := True;

     if (GotoDomain(Domain, TRUE) = True) then
     begin
          case Cont.SelectedType of
                SETTINGS_TYPE_INTEGER:
                begin
                     WriteInteger(Key, Cont.IntegerValue);
                end;
                SETTINGS_TYPE_STRING:
                begin
                     WriteString(Key, Cont.StringValue);
                end;
                SETTINGS_TYPE_BOOLEAN:
                begin
                     WriteBool(Key, Cont.BooleanValue);
                end;
                SETTINGS_TYPE_DOUBLE:
                begin
                     WriteFloat(Key, Cont.DoubleValue);
                end;
                SETTINGS_TYPE_CURRENCY:
                begin
                     WriteCurrency(Key, Cont.CurrencyValue);
                end;
                SETTINGS_TYPE_DATETIME:
                begin
                     WriteDateTime(Key, Cont.DateTimeValue);
                end;
                SETTINGS_TYPE_SYSTEMTIME:
                begin
                     WriteBinaryData(key, Cont.SystemTimeValue, sizeof(TSystemTime));
                end;
                else SetValueToDataBase := False;
          end;
          CloseKey;
     end
     else
         SetValueToDataBase := False;
end;

{ Asettaa annetun asetuksen varsinaiseen tietokantaan }
function TRegSettings.GetValueFromDataBase(Domain: string;
                                        Key: string; Cont: TypeInfo): TypeInfo;
begin
     Cont.Result := True;

     if (GotoDomain(Domain, TRUE) = True) then
     begin
          if (ValueExists(Key) = TRUE) then
          begin
              case Cont.SelectedType of
                SETTINGS_TYPE_INTEGER:
                begin
                     if (GetDataType(Key) <> rdInteger) then
                        Cont.Result := False
                     else
                        Cont.IntegerValue := ReadInteger(Key);
                end;
                SETTINGS_TYPE_STRING:
                begin
                     if (GetDataType(Key) <> rdString) then
                        Cont.Result := False
                     else
                        Cont.StringValue :=  ReadString(Key);
                end;
                SETTINGS_TYPE_BOOLEAN:
                begin
                     if (GetDataType(Key) <> rdInteger) then
                        Cont.Result := False
                     else
                        Cont.BooleanValue := ReadBool(Key);
                end;
                SETTINGS_TYPE_DOUBLE:
                begin
                     if (GetDataType(Key) <> rdBinary) then
                        Cont.Result := False
                     else
                        Cont.DoubleValue := ReadFloat(Key);
                end;
                SETTINGS_TYPE_CURRENCY:
                begin
                     if (GetDataType(Key) <> rdBinary) then
                        Cont.Result := False
                     else
                        Cont.CurrencyValue := ReadCurrency(Key);
                end;
                SETTINGS_TYPE_DATETIME:
                begin
                     if (GetDataType(Key) <> rdBinary) then
                        Cont.Result := False
                     else
                        Cont.DateTimeValue := ReadDateTime(Key);
                end;
                SETTINGS_TYPE_SYSTEMTIME:
                begin
                     if (GetDataType(Key) <> rdBinary) then
                        Cont.Result := False
                     else
                        ReadBinaryData(key, Cont.SystemTimeValue, sizeof(TSystemTime));
                end;
              else Cont.Result := False;
              end;
          end
          else
              Cont.Result := False;

          CloseKey;
     end
     else
         Cont.Result := False;

     GetValueFromDataBase := Cont;
end;

{ Menee annetun domain-nimen alle registryss‰ }
function TRegSettings.GotoDomain(Domain: string; Create: Boolean): Boolean;
begin
     GotoDomain := TRUE;

     { Menn‰‰n juureen }
     CloseKey;

     if (OpenKey('', TRUE) = FALSE) then
        GotoDomain := False
     else
          if (OpenKey(SETTINGS_SOFTWARE, Create) = FALSE) then
          begin
            GotoDomain := False
          end
          else
                if (OpenKey(SETTINGS_ROOT, Create) = FALSE) then
                begin
                   GotoDomain := False;
                   CloseKey;
                end
                else
                    if (Domain = '') then
                    begin
                       GotoDomain := True;
                    end
                    else
                    begin
                         if (OpenKey(Domain, Create) = FALSE) then
                         begin
                              GotoDomain := FALSE;
                              CloseKey;
                         end;
                    end;
end;


{ ---------- PUBLIC -----------}

{
 Poistaa kaikki arvot annetusta domainista.
}
procedure TRegSettings.ClearDomain(domain: string);
var
     values: TStringList;
     index:  integer;
begin
     values := TStringList.Create;
     values.Clear;

     if (GotoDomain(Domain, FALSE) = True) then
     begin
          GetValueNames(values);
          for index := 0 to values.Count - 1 do
          begin
               DeleteValue(values.Strings[index]);
          end;
     end;

     values.Clear;
     values.Destroy;
end;

{
  palauttaa domainin sis‰lt‰m‰t avaimet
}
procedure TRegSettings.getKeys(domain: string; var keys:TStringList);
begin
     if (keys <> nil) then
     begin
          if (GotoDomain(Domain, FALSE) = True) then
          begin
                GetValueNames(keys);
          end;
     end;
end;

{
 Poistaa kaikki arvot annetusta domainista.
}
procedure TRegSettings.removeKey(domain: string; key: string);
begin
     if (GotoDomain(Domain, FALSE) = True) then
     begin
          DeleteValue(key);
     end;
end;

{

    Kopioi sourceDomain-arvot destDomain-keyn alle.
    Mik‰li destDomain on olemassa, tuhotaan sen nykyiset arvot.

}
function TRegSettings.CopyDomain(sourceDomain: string; destDomain: string): Boolean;
var
   success:    Boolean;
begin
     success := False;

     if (GotoDomain('', FALSE) = True) then
     begin
          if (KeyExists(sourceDomain) = True) then
          begin
               if (KeyExists(destDomain) = True) then
                  DeleteKey(destDomain);

               MoveKey(sourceDomain, destDomain, False);
               success := True;
          end;
     end;

     CloseKey;
     CopyDomain := success;
end;

function TRegSettings.IsKey(Domain: string; Key: string): Boolean;
begin
     IsKey := FALSE;

     if (GotoDomain(Domain, FALSE) = True) then
     begin
          if (ValueExists(Key) = TRUE) then
             IsKey := True;

          CloseKey;
     end;
end;

{ K‰ytett‰v‰t arvot }
function TRegSettings.GetStringValue(Domain: string; Key: string): String;
var
   Container: TypeInfo;
begin
   Container.SelectedType := SETTINGS_TYPE_STRING;
   Container := GetValueFromDataBase(Domain, Key, Container);

   if (Container.Result = False) then
       Result := ''
   else
       Result := Container.StringValue; //<12.0.0:  "E:\Projektit XE2\NolaKehi\BIN\Win32\Debug\Config\License"
end;

function TRegSettings.GetBooleanValue   (Domain: string; Key: string): Boolean;
var
   Container: TypeInfo;
begin
   Container.SelectedType := SETTINGS_TYPE_BOOLEAN;
   Container := GetValueFromDataBase(Domain, Key, Container);

   if (Container.Result = False) then
       Result := FALSE
   else
       Result := Container.BooleanValue;
end;

function TRegSettings.GetCurrencyValue  (Domain: string; Key: string): Currency;
var
   Container: TypeInfo;
begin
   Container.SelectedType := SETTINGS_TYPE_CURRENCY;
   Container := GetValueFromDataBase(Domain, Key, Container);

   if (Container.Result = False) then
       Result := 0
   else
       Result := Container.CurrencyValue;
end;

function TRegSettings.GetIntegerValue   (Domain: string; Key: string): Integer;
var
   Container: TypeInfo;
begin
   Container.SelectedType := SETTINGS_TYPE_INTEGER;
   Container := GetValueFromDataBase(Domain, Key, Container);

   if (Container.Result = False) then
       GetIntegerValue := 0
   else
       GetIntegerValue := Container.IntegerValue;
end;


function TRegSettings.GetDoubleValue    (Domain: string; Key: string): Double;
var
   Container: TypeInfo;
begin
   Container.SelectedType := SETTINGS_TYPE_DOUBLE;
   Container := GetValueFromDataBase(Domain, Key, Container);

   if (Container.Result = False) then
       Result := 0.0
   else
       Result := Container.DoubleValue;
end;

function TRegSettings.GetDateTimeValue    (Domain: string; Key: string): TDateTime;
var
   Container: TypeInfo;
begin
   Container.SelectedType := SETTINGS_TYPE_DATETIME;
   Container := GetValueFromDataBase(Domain, Key, Container);

   if (Container.Result = False) then
       Result := 0.0
   else
       Result := Container.DatetimeValue;
end;

function TRegSettings.GetSystemTimeValue    (Domain: string; Key: string): TSystemTime;
var
   Container: TypeInfo;
begin
   Container.SelectedType := SETTINGS_TYPE_SYSTEMTIME;
   Container := GetValueFromDataBase(Domain, Key, Container);

   if (Container.Result = False) then
   begin
        result := EmptySystemTime;
   end
   else
       Result := Container.SystemtimeValue;
end;



function TRegSettings.SetStringValue(Domain: string;
                                  Key: string; Value: string): Boolean;
var
   Container: TypeInfo;
begin
     Container.SelectedType := SETTINGS_TYPE_STRING;
     Container.StringValue :=  Value;
     Result := SetValueToDataBase(Domain, Key, container); //<Kirjoittaa registryyn.
end;
function TRegSettings.SetBooleanValue   (Domain: string;
                                      Key: string; Value: Boolean): Boolean;
var
   Container: TypeInfo;
begin
     Container.SelectedType := SETTINGS_TYPE_BOOLEAN;
     Container.BooleanValue := Value;
     Result := SetValueToDataBase(Domain, Key, container);
end;

function TRegSettings.SetCurrencyValue  (Domain: string;
                                      Key: string; Value: Currency): Boolean;
var
   Container: TypeInfo;
begin
     Container.SelectedType := SETTINGS_TYPE_CURRENCY;
     Container.CurrencyValue := Value;
     Result := SetValueToDataBase(Domain, Key, container);
end;

function TRegSettings.SetIntegerValue   (Domain: string;
                                      Key: string; Value: Integer): Boolean;
var
   Container: TypeInfo;
begin
     Container.SelectedType := SETTINGS_TYPE_INTEGER;
     Container.IntegerValue := Value;
     Result := SetValueToDataBase(Domain, Key, container);
end;

function TRegSettings.SetDoubleValue    (Domain: string;
                                      Key: string; Value: Double): Boolean;
var
   Container: TypeInfo;
begin
     Container.SelectedType := SETTINGS_TYPE_DOUBLE;
     Container.DoubleValue :=  Value;
     Result := SetValueToDataBase(Domain, Key, container);
end;

function TRegSettings.SetDateTimeValue    (Domain: string;
                                        Key: string; Value: TDateTime): Boolean;
var
   Container: TypeInfo;
begin
     Container.SelectedType :=  SETTINGS_TYPE_DATETIME;
     Container.DateTimeValue := Value;
     Result := SetValueToDataBase(Domain, Key, container);
end;

function TRegSettings.SetSystemTimeValue    (Domain: string;
                                        Key: string; Value: TSystemTime): Boolean;
var
   Container: TypeInfo;
begin
     Container.SelectedType := SETTINGS_TYPE_SYSTEMTIME;
     Container.SystemTimeValue := Value;
     Result := SetValueToDataBase(Domain, Key, container);
end;


procedure TRegSettings.SetDefaults(var Defaults: array of string);
procedure DefsFileen(os: integer; si :string);     begin end; //T‰‰ll‰kin koska USES¥illa ei onannut Defs¥in k‰yttˆ t‰‰ll‰. Kirjoittaa samaan kuin Defs..
(*        'EiKutsuja'                                  VAR Reg :TRegistry;  ff :TextFile;  i :integer;  nm,SS :string;      begin//o>0 =Kirjoitetaan aikaleima.
                                                       //nm := '\\Reijo-xp\e\Projektit XE2\NolaKehi\BIN\_Ajot\DefsFileen.txt';
//DefsFileen('SetStrValue∞∞∞∞∞∞∞∞∞∞∞∞Get:' + myRegSettings.GetStringValue(SETTINGS_USED, TEXTBASE_FILE_ID);
   SS := '';
   Reg := TRegistry.Create;
   with Reg do
   try
     RootKey := HKEY_USERS;
     if OpenKey({SETTINGS_USED=}'Settings',false)  then
        SS := ReadString ({TEXTBASE_FILE_ID=}'Program directory');
//     Vcl.Dialogs.ShowMessage ('SetDefaults: PrgrDir=' +SS);
   finally
     Free;
   end;
   si := si +SS;


   nm := 'X:\Projektit XE2\NolaKehi\BIN\';                //<Ennen L‰pp‰rin tehdasasetusten palautusta vekkopolku oli n‰in.
   if DirectoryExists(nm)
   then begin  //ShowMsg ('Dirri "' +nm +'"  ON.');
      nm := nm +'_DefsAjot\';
      forceDirectories(nm);
      nm := nm +'DefsFileen.txt';  end
   else begin
      nm := '\\REIJO-XP\e\Projektit XE2\NolaKehi\BIN\';   //<L‰pp‰rin tehdasasetusten palautuksen j‰lken vekkopolku on n‰in.
      if DirectoryExists(nm)
      then begin
         nm := nm +'_DefsAjot\';
         forceDirectories(nm);
         nm := nm +'DefsFileen.txt';  end
      else begin  //ShowMsg ('Dirri‰ "' +nm +'  EIOO.');
         nm := 'E:\_Projektit XE_Ajot\';                  //<Tehd‰‰n l‰pp‰rin E:asemaan erikoispolku.
         forceDirectories(nm);
         nm := nm +'DefsFileen.txt';
         //SysUtils.Windows.Beep (2000,100);   ei onaa.
         //for i := 0 to 100  do Beep;
      end;
   end;

   AssignFile(ff,nm);
   if FileExists (nm)
      then Append(ff)
      else Rewrite(ff);
   if o>0  then
      Writeln(ff,'============================SettingsDef===== ' +DateTimeToStr(Now)); //+ ' ' + DateTimeToStr(time));
   si := 'Defs.PAS:  ' +si;                                                      //<+12.0.05
   Writeln(ff, si);
   Flush(ff);
   CloseFile(ff);
 //Windows.Beep (1500,200);
end;//DefsFileen*)

   PROCEDURE WrKoeF (SI :string);     {VAR KoeF :text;  KoeFN :string;      }begin//<Siirrtty t‰nne 10.INC¥st‰ 12.0.0 .
    //if WrNyt  then                      //<Glob, asetus TR/FA EdnNewLask +DetEv :ssa.
    (*if IsDebuggerPresent
      then begin
        {KoeFN := ExtractFilePath (myApplication.ExeName);
         if Pos('REKISTERI',AnsiUpperCase(KoeFn))=0
            then KoeFN := KoeFN +'Config\';      //<Extract.. teki jo 1x '\'} //<'-12.0.05}
         KoeFN := {gAjoPath;} 'X:\Projektit XE2\NolaKehi\BIN\';  //< +12.0.05  Lienee selkeint‰ kolvata koko polku.
         KoeFN := KoeFN +'_Ajot\WrKoeSets.TXT';  //'qKoeLis.TXT'{KoeZiks_a.TXT'};        //'NolaRek.EXE¥n ajossa eioo Config- dirri‰.
                                       DefsFileen('AssgnFile 15');
         AssignFile (KoeF,KoeFN);                //'E:\Projektit XE2\Projektit\NolaKehi\BIN\Win32\Debug\Config\..
         if FileExists (KoeFN)
            then Append  (KoeF)                  //<Kirjoitetaan loppuun jatkoksi.
            else Rewrite (KoeF);
         WRITELN (KoeF, SI);
         Flush(KoeF);                            //<+12.0.0
         CloseFile (KoeF);
      end;*)
   end;//WrKoeF

var
   x:     integer;
   tmp:  integer;
   value: Boolean;
   OldDecimal: char;
begin
         {WrKoeF ('Alku:::::::::::::::::::::::::::');
          WrKoeF ('Loppu:::::::::::::::::::::::::::');
          for x := 0 to (SETTINGS_DEFAULTS_COUNT - 1)  do begin
             tmp := x;//x*3;
             WrKoeF ('Count=' +IntToStr(SETTINGS_DEFAULTS_COUNT) +' tmp=' +IntToStr(tmp) +' Defaults[' +IntToStr(tmp) +']=' +
                     Defaults[tmp] +' Defaults[' +IntToStr(tmp+1) +']=' +Defaults[tmp+1]);
          end;}
     OldDecimal := FormatSettings.DecimalSeparator;
     FormatSettings.DecimalSeparator := '.';         //<T‰m‰ asetettu jo Globals¥issa =jo asetettu, OK t‰‰ll‰kin: 12.0.04, sij.Lopussa.
     value := True;
                                                               //SetDefaults
     for x := 0 to ((SETTINGS_DEFAULTS_COUNT) - 1) do
     begin
          tmp := x*3;                                                  //<Pos('X:\Projektit XE2\NolaKehi\BIN\Win64', Defaults[tmp+1]) >0
          if (Defaults[tmp] = SETTINGS_TYPE_INTEGER_CHAR) then
          begin
               SetIntegerValue(SETTINGS_DEFAULT,
                                        Defaults[tmp],                 //< Defaults[tmp]   =NolaLICENSE , kun tmp=[21]
                                        StrToInt(Defaults[tmp + 1]));  //< Defaults[tmp+1] =License            +1=[22]
               if (IsKey(SETTINGS_USED, Defaults[tmp]) = FALSE) then
                  SetIntegerValue(SETTINGS_USED,
                                           Defaults[tmp],
                                           StrToInt(Defaults[tmp + 1]) );
          end;

          if (Defaults[tmp + 2] = SETTINGS_TYPE_STRING_CHAR) then
          begin
               SetStringValue(SETTINGS_DEFAULT,
                                        Defaults[tmp],
                                        Defaults[tmp + 1]);
               if (IsKey(SETTINGS_USED, Defaults[tmp]) = FALSE) then
                  SetStringValue(SETTINGS_USED,
                                           Defaults[tmp],
                                           Defaults[tmp + 1]);
          end;

          if (Defaults[tmp + 2] = SETTINGS_TYPE_DOUBLE_CHAR) then
          begin
               SetDoubleValue(SETTINGS_DEFAULT,
                                        Defaults[tmp],
                                        StrToFloat(Defaults[tmp + 1]));
               if (IsKey(SETTINGS_USED, Defaults[tmp]) = FALSE) then
                  SetDoubleValue(SETTINGS_USED,
                                           Defaults[tmp],
                                           StrToFloat(Defaults[tmp + 1]));
          end;

          if (Defaults[tmp + 2] = SETTINGS_TYPE_CURRENCY_CHAR) then
          begin
               SetCurrencyValue(SETTINGS_DEFAULT,
                                        Defaults[tmp],
                                        StrToCurr(Defaults[tmp + 1]));
               if (IsKey(SETTINGS_USED, Defaults[tmp]) = FALSE) then
                  SetCurrencyValue(SETTINGS_USED,
                                           Defaults[tmp],
                                           StrToCurr(Defaults[tmp + 1]));
          end;

          if (Defaults[tmp + 2] = SETTINGS_TYPE_BOOLEAN_CHAR) then
          begin
               if (Defaults[tmp + 1] = SETTINGS_TYPE_BOOLEAN_FALSE) then
                  value := FALSE;

               SetBooleanValue(SETTINGS_DEFAULT,
                                        Defaults[tmp],
                                        value);
               if (IsKey(SETTINGS_USED, Defaults[tmp]) = FALSE) then
                  SetBooleanValue(SETTINGS_USED,
                                           Defaults[tmp],
                                           value);
          end;
     end;

     FormatSettings.DecimalSeparator := OldDecimal; //<Ei muuta koska asetettu jo GlobaalsÌssa, ks. alussa.

         {WrKoeF ('');
          WrKoeF ('Loppu:::::::::::::::::::::::::::');
          for x := 0 to (SETTINGS_DEFAULTS_COUNT - 1)  do begin
             tmp := x;//x*3;
             WrKoeF ('Count=' +IntToStr(SETTINGS_DEFAULTS_COUNT) +' tmp=' +IntToStr(tmp) +' Defaults[' +IntToStr(tmp) +']=' +
                     Defaults[tmp] +' Defaults[' +IntToStr(tmp+1) +']=' +Defaults[tmp+1]);
          end;}
//DefsFileenZ(0,'SetStrValue∞∞∞∞∞∞∞∞∞∞∞∞Get:');// + {my}RegSettings.GetStringValue(SETTINGS_USED, TEXTBASE_FILE_ID);
end;//SetDefaults

function TRegSettings.AutoGetStringValue(Key: string; Value: string): string;     {12.0.05:}VAR sf :string;
begin
     if (IsKey(SETTINGS_USED, Key) = False) then             //<Onko KEY¥lle asetettu arvoa VALUE Reg¥iss‰ (vai ei)?
     begin
          if (IsKey(SETTINGS_DEFAULT, Key) = False) then
          begin
               { Arvo ei oltu ollenkaan asetettu }
               SetStringValue(SETTINGS_DEFAULT, Key, Value);
               SetStringValue(SETTINGS_USED, Key, Value);
             //AutoGetStringValue := Value;                                               //<,-+12.0.05
               sf := Value;
          end
          else
          begin
               {Arvo oli oletus asetuksissa }
             //AutoGetStringValue := GetStringValue(SETTINGS_DEFAULT, Key);               //<,-+12.0.05
             //SetStringValue(SETTINGS_USED, Key, GetStringValue(SETTINGS_DEFAULT, Key));
               sf := GetStringValue(SETTINGS_DEFAULT, Key);
               SetStringValue(SETTINGS_USED, Key, sf);
          end;
     end
     else
     begin
          {Arvo oli oletus k‰ytetyiss‰ asetuksissa }
        //AutoGetStringValue := GetStringValue(SETTINGS_USED, Key);                       //<,-+12.0.05
          sf := GetStringValue(SETTINGS_USED, Key);
     end;
     AutoGetStringValue := sf;                                                            //<+12.0.05
end;

function TRegSettings.AutoGetBooleanValue(Key: string; Value: Boolean): Boolean;
begin
     if (IsKey(SETTINGS_USED,Key) = False) then
     begin
          if (IsKey(SETTINGS_DEFAULT,Key) = False) then
          begin
               { Arvo ei oltu ollenkaan asetettu }
               SetBooleanValue(SETTINGS_DEFAULT, Key, Value);
               SetBooleanValue(SETTINGS_USED, Key, Value);
               AutoGetBooleanValue := Value;
          end
          else
          begin
               {Arvo oli oletus asetuksissa }
               AutoGetBooleanValue := GetBooleanValue(SETTINGS_DEFAULT, Key);
               SetBooleanValue(SETTINGS_USED, Key, GetBooleanValue(SETTINGS_DEFAULT, Key));
          end;
     end
     else
     begin
          {Arvo oli oletus k‰ytetyiss‰ asetuksissa }
          AutoGetBooleanValue := GetBooleanValue(SETTINGS_USED, Key);
     end;
end;

function TRegSettings.AutoGetCurrencyValue(Key: string; Value: Currency): Currency;
begin
     if (IsKey(SETTINGS_USED,Key) = False) then
     begin
          if (IsKey(SETTINGS_DEFAULT,Key) = False) then
          begin
               { Arvo ei oltu ollenkaan asetettu }
               SetCurrencyValue(SETTINGS_DEFAULT, Key, Value);
               SetCurrencyValue(SETTINGS_USED, Key, Value);
               AutoGetCurrencyValue := Value;
          end
          else
          begin
               {Arvo oli oletus asetuksissa }
               AutoGetCurrencyValue := GetCurrencyValue(SETTINGS_DEFAULT, Key);
               SetCurrencyValue(SETTINGS_USED, Key, GetCurrencyValue(SETTINGS_DEFAULT, Key));
          end;
     end
     else
     begin
          {Arvo oli oletus k‰ytetyiss‰ asetuksissa }
          AutoGetCurrencyValue := GetCurrencyValue(SETTINGS_USED, Key);
     end;
end;


function TRegSettings.AutoGetIntegerValue(Key: string; Value: Integer): Integer;
begin
     if (IsKey(SETTINGS_USED,Key) = False) then
     begin
          if (IsKey(SETTINGS_DEFAULT,Key) = False) then
          begin
               { Arvo ei oltu ollenkaan asetettu }
               SetIntegerValue(SETTINGS_DEFAULT, Key, Value);
               SetIntegerValue(SETTINGS_USED, Key, Value);
               AutoGetIntegerValue := Value;
          end
          else
          begin
               {Arvo oli oletus asetuksissa }
               AutoGetIntegerValue := GetIntegerValue(SETTINGS_DEFAULT, Key);
               SetIntegerValue(SETTINGS_USED, Key, GetIntegerValue(SETTINGS_DEFAULT, Key));
          end;
     end
     else
     begin
          {Arvo oli oletus k‰ytetyiss‰ asetuksissa }
          AutoGetIntegerValue := GetIntegerValue(SETTINGS_USED, Key);
     end;
end;

function TRegSettings.AutoGetDoubleValue(Key: string; Value: Double): Double;
var
   tmp: Double;
begin
     if (IsKey(SETTINGS_USED,Key) = False) then
     begin
          if (IsKey(SETTINGS_DEFAULT,Key) = False) then
          begin
               { Arvo ei oltu ollenkaan asetettu }
               SetDoubleValue(SETTINGS_DEFAULT, Key, Value);
               SetDoubleValue(SETTINGS_USED, Key, Value);
               AutoGetDoubleValue := Value;
          end
          else
          begin
               {Arvo oli oletus asetuksissa }
               tmp := GetDoubleValue(SETTINGS_DEFAULT, Key);
               SetDoubleValue(SETTINGS_USED, Key, tmp);
               AutoGetDoubleValue := tmp;
          end;
     end
     else
     begin
          {Arvo oli oletus k‰ytetyiss‰ asetuksissa }
          tmp := GetDoubleValue(SETTINGS_USED, Key);
          AutoGetDoubleValue := tmp;
     end;
end;

function TRegSettings.AutoGetDateTimeValue(Key: string; Value: TDateTime): TDateTime;
var
   tmp: Double;
begin
     if (IsKey(SETTINGS_USED,Key) = False) then
     begin
          if (IsKey(SETTINGS_DEFAULT,Key) = False) then
          begin
               { Arvo ei oltu ollenkaan asetettu }
               SetDateTimeValue(SETTINGS_DEFAULT, Key, Value);
               SetDateTimeValue(SETTINGS_USED, Key, Value);
               AutoGetDateTimeValue := Value;
          end
          else
          begin
               {Arvo oli oletus asetuksissa }
               tmp := GetDateTimeValue(SETTINGS_DEFAULT, Key);
               SetDateTimeValue(SETTINGS_USED, Key, tmp);
               AutoGetDateTimeValue := tmp;
          end;
     end
     else
     begin
          {Arvo oli oletus k‰ytetyiss‰ asetuksissa }
          tmp := GetDateTimeValue(SETTINGS_USED, Key);
          AutoGetDateTimeValue := tmp;
     end;
end;

function TRegSettings.AutoGetSystemTimeValue(Key: string; Value: TSystemTime): TSystemTime;
var
   tmp: TSystemTime;
begin
     if (IsKey(SETTINGS_USED,Key) = False) then
     begin
          if (IsKey(SETTINGS_DEFAULT,Key) = False) then
          begin
               { Arvo ei oltu ollenkaan asetettu }
               SetSystemTimeValue(SETTINGS_DEFAULT, Key, Value);
               SetSystemTimeValue(SETTINGS_USED, Key, Value);
               AutoGetSystemTimeValue := Value;
          end
          else
          begin
               {Arvo oli oletus asetuksissa }
               tmp := GetSystemTimeValue(SETTINGS_DEFAULT, Key);
               SetSystemTimeValue(SETTINGS_USED, Key, tmp);
               AutoGetSystemTimeValue := tmp;
          end;
     end
     else
     begin
          {Arvo oli oletus k‰ytetyiss‰ asetuksissa }
          tmp := GetSystemTimeValue(SETTINGS_USED, Key);
          AutoGetSystemTimeValue := tmp;
     end;
end;
end.
