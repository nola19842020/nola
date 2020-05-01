
Google:  WNetGetUniversalName
http://www.delphifaq.com/faq/delphi/windows_file_system/f430.shtml

var
  cFile,
  Buffer : array [0..450] of char;
  Size   : DWord;
  ret    : integer;
  FileName : string;
..
  Size := sizeof(Buffer);
  ret := WNetGetUniversalName(StrPCopy(cFile, FileName),
           UNIVERSAL_NAME_INFO_LEVEL, @Buffer, Size);
  if ret = NO_ERROR then
    Result := PChar(@Buffer[4])
  else
    Result := FileName;

========================================================
http://www.swissdelphicenter.ch/torry/showcode.php?id=425

ExpandUNCFileName returns the full path of the FileName with the network drive portion in UNC format.
The pathname in the UNC-Format has the format:
\\Servername\sharename

ExpandUNCFileName gibt einen String mit dem vollständigen Pfadnamen der in FileName übergebenen Datei zurück.
Ein vollständig qualifizierter Pfadname besteht aus der Laufwerkskomponente des Dateinamens im UNC-Format:
\\Servername\sharename

// Example, Beispiel:

Label1.Caption := ExpandUNCFileName('K:\sharename.tmp'));

{where "K" is a Network Drive.}


{*****************************************************}
{2. Way }

function GetUNCName(const LocalPath: string): string;
var
  BufferSize: DWord;
  DummyBuffer: Byte;
  Buffer: Pointer;
  Error: DWord;
begin
  BufferSize := 1;
  WNetGetUniversalName(PChar(LocalPath), UNIVERSAL_NAME_INFO_LEVEL, @DummyBuffer, BufferSize);
  Buffer := AllocMem(BufferSize);
  try
    Error := WNetGetUniversalName(PChar(LocalPath), UNIVERSAL_NAME_INFO_LEVEL, Buffer, BufferSize);
    if Error <> NO_ERROR then
      begin
        SetLastError(Error);
        RaiseLastWin32Error;
      end;
    Result := PUniversalNameInfo(Buffer)^.lpUniversalName
  finally
    FreeMem(Buffer);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 Label1.Caption := GetUNCName('y:\xyz\')
end;
