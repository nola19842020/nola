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

{$IFDEF PROFILE} {$O-} {$WARNINGS OFF} {$ENDIF }
unit TextBase;

{
     TextBase
     ========

     DEVELOPER2 16.5.1997 versio 1.0

     Toimii tekstivarastona, josta voidaan erikielisi‰ tekstej‰ hakea ja
     jonne voi myˆs tekstej‰ tallentaa.

     Domain tarkoittaa esim. kielt‰, jolloin voidaan m‰‰ritt‰‰ useita
     tekstej‰ samalle key:lle.

}

interface

uses graphics, inifiles, SysUtils, classes, Windows, Messages, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, LabelNola, mask,comctrls, System.UITypes;

const
     NOT_IN_BUFFER = '[NOT_IN_BUFFER]';
     NO_BUFFER     = '[NO_BUFFER]';

type
  TFontEntry = Class
  private
  public
            NameDefined:  Boolean;
            Name:         string;
            SizeDefined:  Boolean;
            Size:         integer;
            StyleDefined: Boolean;
            Style:        TFontStyles;
            ColorDefined: Boolean;
            Color:        TColor;

            constructor Create;
            destructor Destroy; override;
  end;

  TTextEntry = Class(TObject)
  private
  public
            Ok:               Boolean;
            Domain:           string;
            Key:              string;
            Text:             string;
            Font:             TFontEntry;

            constructor Create;
            destructor Destroy; override;
  end;

  TTextBase = Class
  private
    { Private declarations }
    myFile:          TIniFile;
    isOk:            Boolean;
    errorEntry:      TTextEntry;
    TextEntryBuffer: TStringList;
    myFileName:        string;
    prevDomain:      string;

    procedure LoadDomain(const Domain: string);
    function  LoadValue(const buffer: string): TTextEntry;
    procedure ParseKeyValue(const src: string; var key, value: string);

  public
    { Public declarations }
    constructor Create(const FileName: string);
    destructor Destroy; override;


    { Hakee tietokannasta key:n osoittaman alkion.
      Mik‰li ko. alkiota ei lˆydy tietokannasta haetaan se
      Texts-taulusta. Domainina on 'language' (ks. globals) }
    function Get(const key: string): string;

    { Tyhjent‰‰ puskurin kaikista siell‰ olevista teksteist‰.
      Kun jotain teksti‰ seuraavan kerran pyydet‰‰n, luetaan
      teksti tiedostosta. }
    procedure ClearBuffer;

    { Hakee kaikki mahdolliset domainien nimet annettuun listaan. }
    function GetDomains(const Domains: TStrings): Boolean;

    { Hakee kaikki annetun Domainin keyt }
    function GetKeys(const Domain: string;
                     var Keys: TStrings): Boolean;

    { Palauttaa pyydetyn tekstin }
    function GetTextEntry(const Domain: string;
                          const Key:    string): TTextEntry;

    { Palauttaa pyydetyn tekstin ja asettaa annetun fontin. }
    function GetTextTFont(const Domain: string;
                          const Key:    string;
                          const Font:   TFont): string;

    { Palauttaa pyydetyn tekstin ja asettaa annetun fontin.
      Mik‰li annettua teksti‰ ei lˆydy, kirjoitetaan annettu
      Font- ja Text-teksti tiedostoon.  }
    function AutoGetTextTFont(const Domain: string;
                              const Key:    string;
                              const Text:   string;
                              const Font:   TFont): string;

    function AutoGetText(const Domain: string;
                         const Key:    string;
                         const Text:   string): string;

    { Palauttaa pyydetyn tekstin. }
    function GetText(const Domain: string;
                     const Key:    string): string;

    { Asettaa annetun tekstin }
    function SetTextTFont(const Domain: string;
                          const Key:    string;
                          const Text:   string;
                          const Font:   TFont): Boolean;

    function SetText     (const Domain: string;
                          const Key:    string;
                          const Text:   string): Boolean;

    function SetTextFont (const Domain: string;
                          const Key:    string;
                          const Text:   string;
                          const Font:   TFontEntry): Boolean;

    { K‰y l‰pi annetun komponentin ja sen lapset ja asettaa m‰‰ritellyt
      tekstit. Muutoin toimii kuin AutoGetText }
   procedure AutoGetRecursiveComponentText(const Domain: string;
                                           const path: string;
                                           const component: TComponent);

   { K‰y l‰pi annetun komponentin ja asettaa m‰‰ritellyt
      tekstit. Muutoin toimii kuin AutoGetText }
   procedure AutoGetComponentText(const Domain: string;
                                  const Key: string;
                                  const component: TComponent);

   function CreateBaseFile(FileName: string): Boolean;
  end;


implementation

uses Globals, Defs, ComboBoxXY, TextBaseTexts;

{ ###################################################

   FONTENTRY

  ################################################### }

{ Alustetaan olio }
constructor TFontEntry.Create;
begin
     inherited Create;
end;

{ Tuhotaan olio }
destructor TFontEntry.Destroy;
begin
     inherited Destroy;
end;


{ ###################################################

   TEXTENTRY

  ################################################### }

{ Alustetaan olio }
constructor TTextEntry.Create;
begin
     ok :=   True;
     Font := TFontEntry.Create;
     inherited Create;
end;

{ Tuhotaan olio }
destructor TTextEntry.Destroy;
begin
     inherited Destroy;

     Font.Free;
end;


{ ###################################################

   TEXTBASE

  ################################################### }


{ Alustetaan olio }
constructor TTextBase.Create(const FileName: string);
var
   myString: string;
begin
     inherited Create;

     myFileName := filename;
     prevDomain := '';

     isOk :=            TRUE;
     errorEntry :=      TTextEntry.Create;
     errorEntry.Ok :=   False;
     TextEntryBuffer := TStringList.Create;
     TextEntryBuffer.Clear;
     TextEntryBuffer.Sorted := True;

     if (fFileExists(FileName) = FALSE) and
        (CreateBaseFile(FileName) = FALSE) then
     begin
        mystring := TEXTBASE_TEXT_FILE_ERROR + ' (' + FileName + ')';
        MessageDlg(myString, mtError, [mbOK], 0);
        isOk := FALSE;
     end
     else
     begin
          myFile := TIniFile.Create(FileName);
     end;
end;

{ Tuhotaan olio }
destructor TTextBase.Destroy;
begin
     if (isOk = TRUE) then
        myFile.Destroy;

     ClearBuffer;

     errorEntry.Free;
     TextEntryBuffer.Free;

     inherited Destroy;
end;

{ Tyhjent‰‰ muistissa olevan puskurin }
procedure TTextBase.LoadDomain(const domain: string);
var
   values: TStringList;
   section: TStringList;
   key, tmp, value: string;
   cont: boolean;
   x: integer;
begin
     ClearBuffer;

     values := TStringList.Create;
     section := TStringList.Create;

     values.LoadFromFile(myFileName);

     x := values.IndexOf('['+domain+']');

     prevDomain := domain;

     if (x <> -1) then
     begin
          cont := true;
          x := x + 1;

          while (cont = TRUE) do
          begin
               if (x < values.Count) then
               begin
                    tmp := values[x];
                    ParseKeyValue(tmp, key, value);
                    TextEntryBuffer.AddObject(key, LoadValue(value));
                    if (tmp = '') or (tmp<>'') and (tmp[1] <> '[') then //1414d: tmp<>''
                    begin
                         section.Add(tmp);
                    end
                    else
                        cont := false;

                    x := x + 1;
               end
               else
                   cont := False;
          end;
     end;

     section.free;
     values.Free;
end;

function TTextBase.CreateBaseFile(FileName: string): Boolean;
var
   myfile: TIniFile;
   x: integer;
begin
     TRY
        myfile := TIniFile.Create(FileName);
        for x:=0 to TEXTS_COUNT - 1 do
        begin
             myfile.WriteString(language,texts[x][0], texts[x][1]);
        end;
        myFile.Free;
        result := true;
     EXCEPT
           result := false;
     END;
end;

procedure TTextBase.ParseKeyValue(const src: string; var key, value: string);
var
   pos: integer;
begin
     key :=   '';
     value := '';

     pos := System.Pos('=', src);

     if (pos <> 0) then
     begin
          key :=   Copy(src, 1, pos - 1);
          value := Copy(src, pos + 1, 99999);
     end;
end;

function TTextBase.LoadValue(const buffer: string): TTextEntry;
var
   tmp:    string;
   name,size,style,color: integer;
   nameLen,sizeLen,styleLen,colorLen: integer;
   returnVal: TTextEntry;
begin
     returnVal := TTextEntry.Create;
     returnVal.Ok := True;

     name :=  Pos(TEXTBASE_FONT_NAME, buffer);
     size :=  Pos(TEXTBASE_FONT_SIZE, buffer);
     style := Pos(TEXTBASE_FONT_STYLE, buffer);
     color := Pos(TEXTBASE_FONT_COLOR, buffer);

     nameLen :=  Length(TEXTBASE_FONT_NAME);
     sizeLen :=  Length(TEXTBASE_FONT_SIZE);
     styleLen := Length(TEXTBASE_FONT_STYLE);
     colorLen := Length(TEXTBASE_FONT_COLOR);

     if (name = 0) then
        returnVal.Text := buffer
     else
         returnVal.Text := Copy(buffer,0,name - 1);

     tmp := Copy(buffer, name + nameLen, size - name - nameLen);

     if ((tmp = '') or (name = 0)) then
        returnVal.Font.NameDefined := False
     else
         returnVal.Font.NameDefined := True;

     returnVal.Font.Name := tmp;

     tmp := Copy(buffer, size + sizeLen, style - size -sizeLen);

     if ((tmp = '') or (size = 0)) then
        returnVal.Font.SizeDefined := False
     else
     begin
          returnVal.Font.SizeDefined := True;
          returnVal.Font.Size :=        StrToInt(tmp);
     end;

     tmp := Copy(buffer, style + styleLen, color - style - styleLen);

     returnVal.Font.StyleDefined := False;
     if ( (style <> 0) and (Pos(TEXTBASE_STYLE_BOLD,      tmp) <> 0)) then
     begin
          returnVal.Font.StyleDefined := True;
          returnVal.Font.Style := returnVal.Font.Style + [ fsBold ];
     end;

     if ( (style <> 0) and (Pos(TEXTBASE_STYLE_ITALIC,    tmp) <> 0)) then
     begin
          returnVal.Font.StyleDefined := True;
          returnVal.Font.Style := returnVal.Font.Style + [ fsItalic ];
     end;

     if ( (style <> 0) and (Pos(TEXTBASE_STYLE_UNDERLINE, tmp) <> 0)) then
     begin
          returnVal.Font.StyleDefined := True;
          returnVal.Font.Style := returnVal.Font.Style + [ fsUnderline ];
     end;

     if ( (style <> 0) and (Pos(TEXTBASE_STYLE_STRIKEOUT, tmp) <> 0)) then
     begin
          returnVal.Font.StyleDefined := True;
          returnVal.Font.Style := returnVal.Font.Style + [ fsStrikeout ];
     end;

     tmp := Copy(buffer, color + colorLen, Length(buffer) - color - colorLen + 1 );

     if ((tmp = '') or (color = 0)) then
        returnVal.Font.ColorDefined := False
     else
     begin
          returnVal.Font.ColorDefined := True;
          returnVal.Font.Color := StrToInt(tmp);
     end;                                  

     LoadValue := returnVal;
end;

{ Tyhjent‰‰ muistissa olevan puskurin }
procedure TTextBase.ClearBuffer;
var
   index: integer;
begin
     for index := 0 to TextEntryBuffer.Count - 1 do
     begin
         TTextEntry(TextEntryBuffer.Objects[index]).Free;
     end;

     TextEntryBuffer.Clear;
end;

function TTextBase.GetDomains(const Domains: TStrings): Boolean;
begin
    if (isOk = True) then
    begin
          myFile.ReadSections(Domains);
          GetDomains := True;
    end
    else
          GetDomains := False;
end;

function TTextBase.GetKeys(const Domain: String; var Keys: TStrings): Boolean;
begin
    if (isOk = True) then
    begin
          myFile.ReadSectionValues(Domain, Keys);
          GetKeys := True;
    end
    else
          GetKeys := False;
end;

function TTextBase.GetTextEntry(const Domain: string;
                                const Key:    string): TTextEntry;
var
   returnVal:     TTextEntry;
   index: integer;
begin
     result := errorEntry;

     if (isOk = True) and (domain <> '') and (key <> '') then
     begin

          { Katsotaan onko teksti jo muistissa }
          if (prevDomain <> Domain) then
          begin
             LoadDomain(Domain);
          end;

          if (TextEntryBuffer.Find(Key, index) = false) then
          begin
               returnVal := nil;
               result := returnVal;
          end
          else
          begin
               { Oli muistissa, joten otetaan tieto puskurista }
               result := TTextEntry(TextEntryBuffer.Objects[index]);
          end;
     end
end;


function TTextBase.GetTextTFont(const Domain: string;
                                const Key:    string;
                                const Font:   TFont): string;
var
   entry:  TTextEntry;
begin
     GetTextTFont := '';

     if (isOk = True) then
     begin
          entry := GetTextEntry(Domain, Key);

          if (entry <> nil) and (entry.ok = True) then
          begin
               GetTextTFont := entry.Text;

               if (Font <> nil) then
               begin
                 if (entry.Font.NameDefined = True) and
                    (Font.name <> entry.font.name) then
                    Font.Name := entry.Font.Name;

                 if (entry.Font.SizeDefined = True) and
                    (Font.size <> entry.font.size) then
                    Font.Size := entry.Font.Size;

                 if (entry.Font.StyleDefined = True) and
                    (font.style <> entry.font.style) then
                    Font.Style := entry.Font.Style;

                 if (entry.Font.ColorDefined = True) and
                    (font.color <> entry.font.color) then
                    Font.Color := entry.Font.Color;
               end;
          end
          else
          if (entry = nil) then
             GetTextTFont := NOT_IN_BUFFER
          else
             GetTextTFont := NO_BUFFER;
     end
     else
         GetTextTFont := NO_BUFFER
end;

function TTextBase.GetText(const Domain: string;
                           const Key:    string): string;
var
   entry:  TTextEntry;
begin
     GetText := '';

     if (isOk = True) then
     begin
          entry := GetTextEntry(Domain, Key);

           if (entry <> nil) and (entry.ok = True) then
               GetText := entry.Text
           else
           if (entry = nil) then
              GetText := NOT_IN_BUFFER
           else
               GetText := NO_BUFFER;
     end
     else
         GetText := NO_BUFFER;
end;


function TTextBase.SetTextFont(const Domain: string;
                               const Key:    string;
                               const Text:   string;
                               const Font:   TFontEntry): Boolean;
var
   buffer: string;
   entry:  TTextEntry;
   index:  integer;

begin
    entry := TTextEntry.Create;
    SetTextFont := False;
    if (isOk = True) and (key <> '') and (domain <> '') then
    begin
         buffer := text;
         if (Font.NameDefined = TRUE) then
         begin
            buffer := buffer + TEXTBASE_FONT_NAME;
            buffer := buffer + Font.Name;
         end;

         if (Font.SizeDefined = True) then
         begin
            buffer := buffer + TEXTBASE_FONT_SIZE;
            buffer := buffer + IntToStr(Font.Size);
         end;

         if (Font.StyleDefined = True) then
         begin
              buffer := buffer + TEXTBASE_FONT_STYLE;
              if (Font.Style >= [fsBold]) then
                 buffer := buffer + TEXTBASE_STYLE_BOLD;
              if (Font.Style >= [fsItalic]) then
                 buffer := buffer + TEXTBASE_STYLE_ITALIC;
              if (Font.Style >= [fsUnderline]) then
                 buffer := buffer + TEXTBASE_STYLE_UNDERLINE;
              if (Font.Style >= [fsStrikeout	]) then
                 buffer := buffer + TEXTBASE_STYLE_STRIKEOUT;
         end;

         if (Font.ColorDefined = True) then
         begin
              buffer := buffer + TEXTBASE_FONT_COLOR;
              buffer := buffer + IntToStr(Font.Color);
         end;

         myFile.WriteString(Domain, Key, Buffer);
         SetTextFont := True;

         if (TextEntryBuffer.Find(Key, index) = True) then
         begin
               { Oli muistissa, joten otetaan tieto pois puskurista }
               TTextEntry(TextEntryBuffer.Objects[index]).Free;
               TextEntryBuffer.Delete(index);
         end;

         { Lis‰t‰‰n uusi entry puskuriin }
         entry.Ok :=     True;
         entry.Domain := Domain;
         entry.Key :=    Key;
         entry.Text :=   text;

         entry.Font.Name :=  Font.Name;
         entry.Font.Size :=  Font.Size;
         entry.Font.Style := Font.Style;
         entry.Font.Color := Font.Color;

         TextEntryBuffer.AddObject(Key, entry);
    end;
end;

function TTextBase.SetTextTFont(const Domain: string;
                                const Key:    string;
                                const Text:   string;
                                const Font:   TFont): Boolean;
var
   myFont: TFontEntry;
begin
    myFont := TFontEntry.Create;

    SetTextTFont := False;
    if (isOk = True) then
    begin
         myFont.NameDefined :=  True;
         myFont.Name :=         Font.Name;
         myFont.SizeDefined :=  True;
         myFont.Size :=         Font.Size;
         myFont.StyleDefined := True;
         myFont.Style :=        Font.Style;
         myFont.ColorDefined := True;
         myFont.Color :=        Font.Color;

         SetTextTFont := SetTextFont(Domain, Key, Text, myFont);
    end;

    myFont.Free;
end;

function TTextBase.SetText(const Domain: string;
                           const Key:    string;
                           const Text:   string): Boolean;
var
   myFont: TFontEntry;
begin
    myFont := TFontEntry.Create;

    SetText := False;
    if (isOk = True) then
    begin
         myFont.NameDefined :=  False;
         myFont.SizeDefined :=  False;
         myFont.StyleDefined := False;
         myFont.ColorDefined := False;

         SetText := SetTextFont(Domain, Key, Text, myFont);
    end;

    myFont.Free;
end;

function TTextBase.AutoGetTextTFont(const Domain: string;
                          const Key:    string;
                          const Text:   string;
                          const Font:   TFont): string;
var
   tmp:  String;
begin
     if (isOk = TRUE) then
     begin
          tmp := GetTextTFont(Domain, Key, Font);
          if (tmp = NOT_IN_BUFFER) then
          begin
               SetTextTFont(Domain, Key, Text, Font);
               AutoGetTextTFont := Text;
          end
          else if (tmp = NO_BUFFER) then
          begin
               AutoGetTextTFont := text;
          end
          else
              AutoGetTextTFont := tmp;
     end
     else
         AutoGetTextTFont := text;
end;

function TTextBase.AutoGetText(const Domain: string;
                          const Key:    string;
                          const Text:   string): string;
var
   tmp:  String;
begin
     if (isOk = TRUE) then
     begin
          tmp := GetText(Domain, Key);
          if (tmp = NOT_IN_BUFFER) then
          begin
               SetText(Domain, Key, Text);
               AutoGetText := Text;
          end
          else if (tmp = NO_BUFFER) then
          begin
               AutoGetText := Text;
          end
          else
              AutoGetText := tmp;
     end
     else
         AutoGetText := Text;
end;

procedure TTextBase.AutoGetRecursiveComponentText(const Domain: string;
                                        const path: string;
                                        const component: TComponent);
var
   x: integer;
begin
     if (component <> nil) then
     begin
          AutoGetComponentText(Domain, path + component.Name, component);

          for x := 0 to component.ComponentCount - 1 do
              AutoGetComponentText(Domain, (path + component.Name + '-' +
                   component.Components[x].Name), component.Components[x]);
     end;
end;

procedure TTextBase.AutoGetComponentText(const Domain: string;
                               const Key: string;
                               const component: TComponent);
var
   x: integer;
   tmp: string;
begin
     if component is TPageControl then
     begin
          tmp := myTextBase.AutoGetText(domain, key + '-Hint',
                                         TPageControl(component).Hint);

          if (TPageControl(component).Hint <> tmp) then
             TPageControl(component).Hint := tmp;

          if (TPageControl(component).Hint <> '') then
             TPageControl(component).ShowHint := True
          else
              TPageControl(component).ShowHint := False;
     end
     else
     if (component is TTabSheet) then
     begin
          tmp := myTextBase.AutoGetTextTFont(domain, key + '-Caption',
                                         TTabSheet(component).Caption, TTabSheet(component).Font);

          if (TTabSheet(component).Caption <> tmp) then
             TTabSheet(component).Caption := tmp;

          tmp := myTextBase.AutoGetText(domain, key + '-Hint',
                                         TTabSheet(component).Hint);

          if (TTabSheet(component).Hint <> tmp) then
              TTabSheet(component).Hint := tmp;

          if (TTabSheet(component).Hint <> '') then
             TTabSheet(component).ShowHint := True
          else
              TTabSheet(component).ShowHint := False;
     end
     else
     if (component is TComboBoxXY) then
     begin
          tmp := myTextBase.AutoGetText(domain, key + '-Hint',
                                         TComboBoxXY(component).Hint);

          if (TTabSheet(component).Hint <> tmp) then
              TComboBoxXY(component).Hint := tmp;

          if (TComboBoxXY(component).Hint <> '') then
             TComboBoxXY(component).ShowHint := True
          else
              TComboBoxXY(component).ShowHint := False;
     end
     else
     if (component is TComboBox) then
     begin
          tmp := myTextBase.AutoGetText(domain, key + '-Hint',
                                         TComboBox(component).Hint);

          if (TComboBox(component).Hint <> tmp) then
              TComboBox(component).Hint := tmp;


          if (TComboBox(component).Hint <> '') then
             TComboBox(component).ShowHint := True
          else
              TComboBox(component).ShowHint := False;
     end
     else
     if (component is TEdit) then
     begin
          tmp := myTextBase.AutoGetText(domain, key + '-Hint',
                                         TEdit(component).Hint);

          if (TEdit(component).Hint <> tmp) then
             TEdit(component).Hint := tmp;

          if (TEdit(component).Hint <> '') then
             TEdit(component).ShowHint := True
          else
              TEdit(component).ShowHint := False;
     end
     else
     if (component is TMaskEdit) then
     begin
          tmp := myTextBase.AutoGetText(domain, key + '-Hint',
                                         TMaskEdit(component).Hint);

          if (TMaskEdit(component).Hint <> tmp) then
             TMaskEdit(component).Hint := tmp;

          if (TMaskEdit(component).Hint <> '') then
             TMaskEdit(component).ShowHint := True
          else
              TMaskEdit(component).ShowHint := False;
     end
     else
     if (component is TComboBox) then
     begin
          tmp := myTextBase.AutoGetText(domain, key + '-Hint',
                                         TComboBox(component).Hint);

          if (TComboBox(component).Hint <> tmp) then
             TComboBox(component).Hint := tmp;

          if (TComboBox(component).Hint <> '') then
             TComboBox(component).ShowHint := True
          else
              TComboBox(component).ShowHint := False;
     end
     else
     if (component is TCheckBox) then
     begin
          tmp := myTextBase.AutoGetTextTFont(domain, key + '-Caption',
                                         TCheckBox(component).Caption, TCheckBox(component).Font);

          if (TCheckBox(component).Caption <> tmp) then
             TCheckBox(component).Caption := tmp;

          tmp := myTextBase.AutoGetText(domain, key + '-Hint',
                                         TCheckBox(component).Hint);

          if (TCheckBox(component).Hint <> tmp) then
             TCheckBox(component).Hint := tmp;

          if (TCheckBox(component).Hint <> '') then
             TCheckBox(component).ShowHint := True
          else
              TCheckBox(component).ShowHint := False;
     end
     else
     if (component is TRadioButton) then
     begin
          tmp :=  myTextBase.AutoGetTextTFont(domain, key + '-Caption',
                                         TRadioButton(component).Caption,TRadioButton(component).Font);

          if (TRadioButton(component).Caption <> tmp) then
             TRadioButton(component).Caption := tmp;

          tmp := myTextBase.AutoGetText(domain, key + '-Hint',
                                         TRadioButton(component).Hint);

          if (TRadioButton(component).Hint <> tmp) then
             TRadioButton(component).Hint := tmp;

          if (TRadioButton(component).Hint <> '') then
             TRadioButton(component).ShowHint := True
          else
              TRadioButton(component).ShowHint := False;
     end
     else
     if (component is TRadioGroup) then
     begin
          tmp := myTextBase.AutoGetTextTFont(domain, key + '-Caption',
                                         TRadioGroup(component).Caption, TRadioGroup(component).Font);

          if (TRadioGroup(component).Caption <> tmp) then
             TRadioGroup(component).Caption := tmp;


          tmp := myTextBase.AutoGetText(domain, key + '-Hint',
                                         TRadioGroup(component).Hint);

          if (TRadioGroup(component).Hint <> tmp) then
             TRadioGroup(component).Hint := tmp;

          if (TRadioGroup(component).Hint <> '') then
             TRadioGroup(component).ShowHint := True
          else
              TRadioGroup(component).ShowHint := False;

          for x:= 0 to TRadioGroup(component).items.Count - 1 do
          begin
               tmp := myTextBase.AutoGetText(domain, key + '-item-' + intToStr(x),
                                         TRadioGroup(component).items[x]);

               if (TRadioGroup(component).items[x] <> tmp) then
                  TRadioGroup(component).items[x] := tmp;
          end;
     end
     else
     if (component is TLabelNola) then
     begin
          tmp :=  myTextBase.AutoGetText(domain, key + '-Caption',
                                    TLabelNola(component).Caption);

          if (TLabelNola(component).Caption <> tmp) then
             TLabelNola(component).Caption := tmp;

          tmp := myTextBase.AutoGetText(domain, key + '-Hint',
                                         TLabelNola(component).Hint);

          if (TLabel(component).Hint <> tmp) then
             TLabel(component).Hint := tmp;

          if (TLabelNola(component).Hint <> '') then
             TLabelNola(component).ShowHint := True
          else
              TLabelNola(component).ShowHint := False;
     end
     else
    if (component is TLabel) then
     begin
          tmp := myTextBase.AutoGetTextTFont(domain, key + '-Caption',
                                         TLabel(component).Caption, TLabel(component).Font);

          if (TLabel(component).Caption <> tmp) then
             TLabel(component).Caption := tmp;

          tmp := myTextBase.AutoGetText(domain, key + '-Hint',
                                         TLabel(component).Hint);

          if (TLabel(component).Hint <> tmp) then
             TLabel(component).Hint := tmp;

          if (TLabel(component).Hint <> '') then
             TLabel(component).ShowHint := True
          else
              TLabel(component).ShowHint := False;
     end
     else
     if (component is TButton) then
     begin
          tmp := myTextBase.AutoGetTextTFont(domain, key + '-Caption',
                                         TButton(component).Caption, TButton(component).Font);

          if (TButton(component).Caption <> tmp) then
             TButton(component).Caption := tmp;

          tmp := myTextBase.AutoGetText(domain, key + '-Hint', TButton(component).Hint);

          if (TButton(component).Hint <> tmp) then
             TButton(component).Hint := tmp;

          if (TButton(component).Hint <> '') then
             TButton(component).ShowHint := True
          else
              TButton(component).ShowHint := False;
     end
     else
     if (component is TGroupBox) then
     begin
          tmp := myTextBase.AutoGetTextTFont(domain, key + '-Caption',
                                         TGroupBox(component).Caption, TGroupBox(component).Font);

          if (TGroupBox(component).Caption <> tmp) then
             TGroupBox(component).Caption := tmp;

          tmp := myTextBase.AutoGetText(domain, key + '-Hint',
                                         TGroupBox(component).Hint);

          if (TGroupBox(component).Hint <> tmp) then
             TGroupBox(component).Hint := tmp;

          if (TGroupBox(component).Hint <> '') then
             TGroupBox(component).ShowHint := True
          else
              TGroupBox(component).ShowHint := False;
     end
     else
     if (component.Owner.ClassNameIs('TApplication')) then  // Form
     begin
          tmp := myTextBase.AutoGetText(domain, key + '-Caption', TForm(component).Caption);

          if (TForm(component).Caption <> tmp) then
             TForm(component).Caption := tmp;

     end;
end;

function TTextBase.Get(const Key:    string): string;
var
   tmp, text:  String;
   x: integer;
begin
     if (isOk = TRUE) then
     begin
          tmp := GetText(language, Key);
          if (tmp = NOT_IN_BUFFER) then
          begin
               text := '';
               for x:=0 to TEXTS_COUNT - 1 do
               begin
                    if (texts[x][0] = key) then
                       text := texts[x][1];
               end;
               SetText(language, Key, Text);
               Get := Text;
          end
          else if (tmp = NO_BUFFER) then
          begin
               Get := '';
          end
          else
              Get := tmp;
     end
     else
         Get := '';
end;

end.
